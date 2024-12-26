#include "view.hpp"

#include <userver/components/component_config.hpp>
#include <userver/components/component_context.hpp>
#include <userver/formats/json.hpp>
#include <userver/server/handlers/http_handler_base.hpp>
#include <userver/storages/postgres/cluster.hpp>
#include <userver/storages/postgres/component.hpp>

#include <string>

namespace sport_goods::views::v1::orders::post {

namespace {

struct OrderData {
  std::optional<std::string> name;
  std::optional<std::string> email;
  std::optional<std::string> phone;
};

class HandlerV1OrdersV1Post final
    : public userver::server::handlers::HttpHandlerBase {
 public:
  static constexpr std::string_view kName = "handler-v1-orders-post";

  explicit HandlerV1OrdersV1Post(
      const userver::components::ComponentConfig& config,
      const userver::components::ComponentContext& context)
      : HttpHandlerBase(config, context),
        pg_cluster_(
            context
                .FindComponent<userver::components::Postgres>("postgres-db-1")
                .GetCluster()) {}

  std::string HandleRequestThrow(
      const userver::server::http::HttpRequest& request,
      userver::server::request::RequestContext&) const override {
    const auto& request_body =
        userver::formats::json::FromString(request.RequestBody());

    const auto data = OrderData{
        .name = request_body["name"].As<std::optional<std::string>>(),
        .email = request_body["email"].As<std::optional<std::string>>(),
        .phone = request_body["phone"].As<std::optional<std::string>>()};

    if (!OrderDataIsValid(data)) {
      auto& response = request.GetHttpResponse();
      LOG_INFO() << "incorrect order data";
      response.SetStatus(userver::server::http::HttpStatus::BadRequest);
      return {};
    }

    auto result = pg_cluster_->Execute(
        userver::storages::postgres::ClusterHostType::kMaster, kCreateOrder,
        data.name, data.email, data.phone);

    auto order = result.AsSingleRow<std::string>();
    return userver::formats::json::ToString(
        userver::formats::json::ValueBuilder{order}.ExtractValue());
  }

 private:
  bool OrderDataIsValid(const OrderData& data) const {
    return data.name.has_value() && !data.name->empty() &&
           data.email.has_value() && !data.email->empty() &&
           data.phone.has_value() && !data.phone->empty();
  }

  const userver::storages::Query kCreateOrder{
      "WITH ins AS ( "
      "INSERT INTO sport_goods.orders (name, email, phone) "
      "VALUES ($1, $2, $3) "
      "ON CONFLICT DO NOTHING "
      "RETURNING id "
      ") "
      "SELECT id FROM ins; ",
      userver::storages::Query::Name("create-order")};

  userver::storages::postgres::ClusterPtr pg_cluster_;
};

}  // namespace

void AppendView(userver::components::ComponentList& component_list) {
  component_list.Append<HandlerV1OrdersV1Post>();
}

}  // namespace sport_goods::views::v1::orders::post