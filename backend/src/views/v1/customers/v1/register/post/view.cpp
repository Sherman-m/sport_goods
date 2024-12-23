#include "view.hpp"

#include <userver/components/component_config.hpp>
#include <userver/components/component_context.hpp>
#include <userver/server/handlers/http_handler_base.hpp>
#include <userver/storages/postgres/cluster.hpp>
#include <userver/storages/postgres/component.hpp>

#include <userver/crypto/hash.hpp>
#include <userver/formats/json.hpp>

#include <string>

namespace sport_goods::v1::customers::post {
namespace {

class V1CustomerV1RegisterPost final
    : public userver::server::handlers::HttpHandlerBase {
 public:
  static constexpr std::string_view kName =
      "handler-v1-customers-v1-register-post";

  using Response = std::string;

  V1CustomerV1RegisterPost(const userver::components::ComponentConfig& config,
                           const userver::components::ComponentContext& context)
      : HttpHandlerBase(config, context),
        pg_cluster_(
            context
                .FindComponent<userver::components::Postgres>("postgres-db-1")
                .GetCluster()) {}

  Response HandleRequestThrow(
      const userver::server::http::HttpRequest& request,
      userver::server::request::RequestContext&) const override {
    auto email = request.GetFormDataArg("email").value;
    auto password =
        userver::crypto::hash::Sha256(request.GetFormDataArg("password").value);

    auto result = pg_cluster_->Execute(
        userver::storages::postgres::ClusterHostType::kMaster,
        "INSERT INTO sport_goods.customers(email, password) VALUES($1, $2) "
        "ON CONFLICT DO NOTHING "
        "RETURNING sport_goods.id",
        email, password);

    userver::formats::json::ValueBuilder response;
    response["id"] = result.AsSingleRow<std::string>();

    return userver::formats::json::ToString(response.ExtractValue());
  }

 private:
  userver::storages::postgres::ClusterPtr pg_cluster_;
};

}  // namespace

void AppendV1CustomerV1RegisterPost(
    userver::components::ComponentList& component_list) {
  component_list.Append<V1CustomerV1RegisterPost>();
}

}  // namespace sport_goods::v1::customers::post