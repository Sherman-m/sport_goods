#include "view.hpp"

#include <userver/components/component_config.hpp>
#include <userver/components/component_context.hpp>
#include <userver/decimal64/decimal64.hpp>
#include <userver/formats/json.hpp>
#include <userver/formats/serialize/common_containers.hpp>
#include <userver/http/content_type.hpp>
#include <userver/server/handlers/http_handler_base.hpp>
#include <userver/server/http/http_response.hpp>
#include <userver/storages/postgres/cluster.hpp>
#include <userver/storages/postgres/component.hpp>

namespace sport_goods::views::v1::products::get {
namespace {

struct Product {
  std::string name;
  std::string description;
  std::string category_name;
  userver::decimal64::Decimal<10> price;
};

userver::formats::json::Value Serialize(
    const Product& product,
    userver::formats::serialize::To<userver::formats::json::Value>) {
  userver::formats::json::ValueBuilder item;
  item["name"] = product.name;
  item["description"] = product.description;
  item["category_name"] = product.category_name;
  item["price"] = product.price;

  return item.ExtractValue();
}

class View final : public userver::server::handlers::HttpHandlerBase {
 public:
  static constexpr std::string_view kName = "handler-v1-products-get";

  explicit View(const userver::components::ComponentConfig& config,
                const userver::components::ComponentContext& context)
      : HttpHandlerBase(config, context),
        pg_cluster_(
            context
                .FindComponent<userver::components::Postgres>("postgres-db-1")
                .GetCluster()) {}

  std::string HandleRequestThrow(
      const userver::server::http::HttpRequest& request,
      userver::server::request::RequestContext&) const override {
    auto result = pg_cluster_->Execute(
        userver::storages::postgres::ClusterHostType::kSlave, kSelectProducts);

    userver::formats::json::ValueBuilder response_body;
    response_body["items"] = result.AsContainer<std::vector<Product>>(
        userver::storages::postgres::kRowTag);

    auto& response = request.GetHttpResponse();
    response.SetContentType(userver::http::content_type::kApplicationJson);
    return userver::formats::json::ToString(response_body.ExtractValue());
  }

 private:
  const userver::storages::postgres::Query kSelectProducts{
      "SELECT p.name, p.description, c.name, p.price "
      "FROM sport_goods.products AS p "
      "JOIN sport_goods.categories AS c ON p.category_id = c.id; ",
      userver::storages::postgres::Query::Name("select-products")};

  userver::storages::postgres::ClusterPtr pg_cluster_;
};

}  // namespace

void AppendView(userver::components::ComponentList& component_list) {
  component_list.Append<View>();
}

}  // namespace sport_goods::views::v1::products::get