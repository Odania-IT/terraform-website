resource "aws_api_gateway_rest_api" "default" {
  name = "${var.domain}-api"
}

resource "aws_api_gateway_deployment" "default" {
  rest_api_id = "${aws_api_gateway_rest_api.default.id}"
  stage_name = "api"
}

resource "aws_api_gateway_integration" "health-integration" {
  rest_api_id          = "${aws_api_gateway_rest_api.default.id}"
  resource_id          = "${aws_api_gateway_resource.health.id}"
  http_method          = "${aws_api_gateway_method.health.http_method}"
  type                 = "MOCK"

  request_parameters = {
    "integration.request.header.X-Authorization" = "'static'"
  }

  # Transforms the incoming XML request to JSON
  request_templates {
    "application/json" = <<EOF
{
   "body" : "{\"status\": \"ok\"}"
}
EOF
  }
}

resource "aws_api_gateway_resource" "health" {
  parent_id = "${aws_api_gateway_rest_api.default.root_resource_id}"
  path_part = "health"
  rest_api_id = "${aws_api_gateway_rest_api.default.id}"
}

resource "aws_api_gateway_method" "health" {
  authorization = "NONE"
  http_method = "GET"
  resource_id = "${aws_api_gateway_resource.health.id}"
  rest_api_id = "${aws_api_gateway_rest_api.default.id}"
}
