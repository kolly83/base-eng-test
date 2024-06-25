output "api_gateway_url" {
  value       = aws_apigatewayv2_stage.event_handler.invoke_url
  description = "The URL of the API Gateway"
}
