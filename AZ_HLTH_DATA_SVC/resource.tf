resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

data "azurerm_client_config" "current" {
}

resource "azurerm_healthcare_workspace" "example" {
  name                = "example"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_healthcare_fhir_service" "example" {
  name                = "tfexfhir"
  location            = var.location
  resource_group_name = var.resource_group_name
  workspace_id        = azurerm_healthcare_workspace.example.id
  kind                = "fhir-R4"

  authentication {
    authority = "https://login.microsoftonline.com/tenantId"
    audience  = "https://tfexfhir.fhir.azurehealthcareapis.com"
  }

  access_policy_object_ids = [
    data.azurerm_client_config.current.object_id
  ]

  identity {
    type = "SystemAssigned"
  }

  container_registry_login_server_url = ["tfex-container_registry_login_server"]

  cors {
    allowed_origins     = ["https://tfex.com:123", "https://tfex1.com:3389"]
    allowed_headers     = ["*"]
    allowed_methods     = ["GET", "DELETE", "PUT"]
    max_age_in_seconds  = 3600
    credentials_allowed = true
  }

  configuration_export_storage_account_name = "storage_account_name"
}
