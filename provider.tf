provider "azurerm" {
    subscription_id = var.usr-subscription-id
    tenant_id = var.usr-tenant-id
    client_id = var.usr-client-id
    client_secret = var.usr-client-secret
    skip_provider_registration = var.usr-skip-provider-registration
    features {}
}

terraform {
    required_version = ">= 0.13"
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "2.98"
        }

        mongodbatlas = {
            source = "mongodb/mongodbatlas"
        }
    }
}