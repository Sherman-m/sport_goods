#include "view.hpp"

#include <userver/components/component_config.hpp>
#include <userver/components/component_context.hpp>
#include <userver/formats/json.hpp>
#include <userver/server/handlers/http_handler_base.hpp>
#include <userver/storages/postgres/cluster.hpp>
#include <userver/storages/postgres/component.hpp>

namespace sport_goods::views::v1::products::get {

namespace {

struct Product {
  size_t id;
  std::string name;
  std::string description;
  std::string category_name;
  double price;
  uint64_t quantity;
};

userver::formats::json::Value Serialize(
    const Product& product,
    userver::formats::serialize::To<userver::formats::json::Value>) {
  userver::formats::json::ValueBuilder item;
  item["id"] = product.id;
  item["name"] = product.name;
  item["description"] = product.description;
  item["category_name"] = product.category_name;
  item["price"] = product.price;

  return item.ExtractValue();
}

class HandlerV1ProductsGet final
    : public userver::server::handlers::HttpHandlerBase {
 public:
  static constexpr std::string_view kName = "handler-v1-products-get";

  explicit HandlerV1ProductsGet(
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
    const auto& category_name = request.GetPathArg("category");

    if (!category_name.empty() && category_name != "") {
      return SelectProductsWithCategory(category_name);
    }
    return SelectProducts();
  }

 private:
  userver::storages::postgres::ClusterPtr pg_cluster_;
};

}  // namespace

}  // namespace sport_goods::views::v1::products::get