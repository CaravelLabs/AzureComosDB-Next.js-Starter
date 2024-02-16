terraform {
  backend "azurerm" {
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.54.0"
    }
  }
}

provider "azurerm" {
  subscription_id            = var.subscription_id
  tenant_id                  = var.tenant_id
  client_id                  = var.client_id
  client_secret              = var.client_secret
  skip_provider_registration = true
  features {}
}

data "azurerm_resource_group" "ch" {
  name = var.main_resource_group_name
}

resource "azurerm_cosmosdb_account" "ch" {
  name                               = var.cosmos_name
  location                           = var.location
  resource_group_name                = data.azurerm_resource_group.ch.name
  offer_type                         = "Standard"
  access_key_metadata_writes_enabled = false
  local_authentication_disabled      = false

  capabilities {
    name = "EnableServerless"
  }

  consistency_policy {
    consistency_level       = "Session"
    max_interval_in_seconds = 5
    max_staleness_prefix    = 100
  }

  geo_location {
    location          = var.location
    failover_priority = 0
  }
}

resource "azurerm_cosmosdb_sql_database" "ch" {
  name                = "${var.naming_prefix}-${var.environment}-db"
  resource_group_name = data.azurerm_resource_group.ch.name
  account_name        = azurerm_cosmosdb_account.ch.name
}

resource "azurerm_cosmosdb_sql_container" "ch-container-items" {
  name                = "items"
  resource_group_name = data.azurerm_resource_group.ch.name
  account_name        = azurerm_cosmosdb_account.ch.name
  database_name       = azurerm_cosmosdb_sql_database.ch.name
  partition_key_path  = "/id"
}

resource "azurerm_service_plan" "ch" {
  name                = var.app_service_plan_name
  location            = var.location
  resource_group_name = data.azurerm_resource_group.ch.name
  os_type             = "Linux"
  sku_name            = var.web_tier
}

resource "azurerm_linux_web_app" "ch" {
  name                = var.app_service_name
  location            = var.location
  resource_group_name = data.azurerm_resource_group.ch.name
  service_plan_id     = azurerm_service_plan.ch.id
  https_only          = "true"

  app_settings = {
    COSMOSDB_ENDPOINT               = azurerm_cosmosdb_account.ch.endpoint
    COSMOSDB_KEY                    = azurerm_cosmosdb_account.ch.primary_key
    COSMOSDB_DATABASE_NAME          = azurerm_cosmosdb_sql_database.ch.name
    COSMOSDB_CONTAINER_NAME         = azurerm_cosmosdb_sql_container.ch-container-items.name
    WEBSITE_RUN_FROM_PACKAGE        = "1"
    WEBSITE_ENABLE_SYNC_UPDATE_SITE = "true"
    SCM_DO_BUILD_DURING_DEPLOYMENT  = "false"
  }

  site_config {
    always_on        = var.web_always_on
    app_command_line = "NODE_ENV=production npx npm@latest run start"
    ftps_state       = "Disabled"
    http2_enabled    = true
    application_stack {
      node_version = "18-lts"
    }
  }
  #   lifecycle {
  #     ignore_changes = [
  #       # These are set from the build pipelines
  #     ]
  #   }
}


