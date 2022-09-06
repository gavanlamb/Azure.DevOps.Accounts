variable "azure_devops_projects" {
  type = list(object({
    name = string
    description = string
  }))
}
resource "azuredevops_project" "project" {
  for_each = {for adp in var.azure_devops_projects:  adp.name => adp}
  name = each.value.name
  description = each.value.description
  visibility = "private"
  version_control = "Git"
  work_item_template = "Scrum"
  features = {
    "boards" = "enabled"
    "repositories" = "disabled"
    "pipelines" = "enabled"
    "testplans" = "enabled"
    "artifacts" = "enabled"
  }
}
resource "azuredevops_environment" "production" {
  for_each = {for adp in var.azure_devops_projects:  adp.name => adp}
  project_id = azuredevops_project.project[adp.key].id
  name = "Production"
}
resource "azuredevops_environment" "preview" {
  for_each = {for adp in var.azure_devops_projects:  adp.name => adp}
  project_id = azuredevops_project.project[adp.key].id
  name = "Preview"
}
