variable "main_resource_group_name" {
    type = string
    description = "The Azure resource group the resources are deployed to"
}

variable "subscription_id" {
    type = string
    description = "The Azure subscription to deploy these resources to"
}

variable "tenant_id" {
    type = string
    description = "The Azure tenant where the resources are deployed to"
}

variable "client_id" {
  type        = string
  description = "The AD service principal to use to deploy the resources"
}

variable "client_secret" {
  type        = string
  description = "The AD service principal secret"
}

variable "environment" {
  type        = string
  description = "solution environment where the resource will be used for. (dev, ci, uat, prod..)"
  default     = "ci"
}

variable "location" {
  type        = string
  description = "The default Azure region to deploy to"
  default     = "centralindia"
}

variable "naming_prefix" {
  type        = string
  description = "Prefix used when generating resource names"
  default     = "caravel"
}

variable "cosmos_name" {
  type        = string
  description = "Variable name for Cosmos database"
  default     = "cdb-bread-ci"
}

variable "app_service_name" {
  type        = string
  description = "Variable name for App Service"
  default     = "web-bread-ci"
}

variable "app_service_plan_name" {
  type        = string
  description = "Variable name for App Service Plan"
  default     = "asp-bread-ci"
}

variable "web_tier" {
  type        = string
  description = "VM tier for the Web App plan"
  default     = "B1"
}

variable "web_always_on" {
  type        = string
  description = "Whether the Web App will be always on"
  default     = "true"
}