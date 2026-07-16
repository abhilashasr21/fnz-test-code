variable "enrollment_account_id" {
  description = "Full ARM ID of the EA enrollment account"
  type        = string
}

variable "name" {
  description = "Alias — a stable name; can be reused to import an existing sub"
  type        = string
}

variable "displayName" {
  description = "Friendly name shown in the portal"
  type        = string
}

variable "workload" {
  description = "Production or DevTest"
  type        = string
}

variable "managementGroupId" {
  description = "MG to place the sub under"
  type        = string
}

variable "tags" {
  description = "Tags to be in subscription"
  type        = map(string)
  default     = {}
}

variable "resource_providers" {
  description = "List of Azure Resource Providers to register on the subscription"
  type        = list(string)
  default = [
    "Microsoft.ADHybridHealthService",
    "Microsoft.AVS",
    "Microsoft.Advisor",
    "Microsoft.AlertsManagement",
    "Microsoft.ApiManagement",
    "Microsoft.AppConfiguration",
    "Microsoft.AppPlatform",
    "Microsoft.Authorization",
    "Microsoft.Automation",
    "Microsoft.Billing",
    "Microsoft.Blueprint",
    "Microsoft.BotService",
    "Microsoft.Cache",
    "Microsoft.Cdn",
    "Microsoft.ChangeSafety",
    "Microsoft.CloudShell",
    "Microsoft.CognitiveServices",
    "Microsoft.Commerce",
    "Microsoft.Compute",
    "Microsoft.Consumption",
    "Microsoft.ContainerInstance",
    "Microsoft.ContainerRegistry",
    "Microsoft.ContainerService",
    "Microsoft.CostManagement",
    "Microsoft.CustomProviders",
    "Microsoft.DBforMariaDB",
    "Microsoft.DBforMySQL",
    "Microsoft.DBforPostgreSQL",
    "Microsoft.Dashboard",
    "Microsoft.DataFactory",
    "Microsoft.DataLakeAnalytics",
    "Microsoft.DataLakeStore",
    "Microsoft.DataMigration",
    "Microsoft.DataProtection",
    "Microsoft.Databricks",
    "Microsoft.DesktopVirtualization",
    "Microsoft.DevCenter",
    "Microsoft.DevTestLab",
    "Microsoft.Devices",
    "Microsoft.DocumentDB",
    "Microsoft.EventGrid",
    "Microsoft.EventHub",
    "Microsoft.Features",
    "Microsoft.GuestConfiguration",
    "Microsoft.HDInsight",
    "Microsoft.HealthcareApis",
    "Microsoft.IoTCentral",
    "Microsoft.KeyVault",
    "Microsoft.Kusto",
    "Microsoft.Logic",
    "Microsoft.MachineLearningServices",
    "Microsoft.Maintenance",
    "Microsoft.ManagedIdentity",
    "Microsoft.ManagedServices",
    "Microsoft.Management",
    "Microsoft.Maps",
    "Microsoft.MarketplaceOrdering",
    "Microsoft.Monitor",
    "Microsoft.Network",
    "Microsoft.NotificationHubs",
    "Microsoft.OperationalInsights",
    "Microsoft.OperationsManagement",
    "Microsoft.PolicyInsights",
    "Microsoft.Portal",
    "Microsoft.PowerBIDedicated",
    "Microsoft.RecoveryServices",
    "Microsoft.Relay",
    "Microsoft.ResourceGraph",
    "Microsoft.ResourceHealth",
    "Microsoft.ResourceIntelligence",
    "Microsoft.ResourceNotifications",
    "Microsoft.Resources",
    "Microsoft.Search",
    "Microsoft.Security",
    "Microsoft.SecurityInsights",
    "Microsoft.SerialConsole",
    "Microsoft.ServiceBus",
    "Microsoft.ServiceFabric",
    "Microsoft.ServiceFabricMesh",
    "Microsoft.SignalRService",
    "Microsoft.Sql",
    "Microsoft.Storage",
    "Microsoft.StreamAnalytics",
    "Microsoft.Web",
    "microsoft.insights",
    "microsoft.support",
  ]
}