terraform {
    required_providers {
        rootly = {
        source = "rootlyhq/rootly"
        }
    }
}  

provider "rootly" {
    api_token = "${var.api_token}"
}

# Alert workflow
resource "rootly_workflow_alert" "alert" {
    name = "This is a test alert workflow."
    enabled = false
    trigger_params {
        trigger_type = "alert"
        triggers = ["alert_created"]
        alert_condition = "ALL"
        alert_condition_source = "IS"
        #alert_sources = ["pagerduty"]
        alert_condition_label = "IS"
        #alert_labels = ["action:incident.triggered"]
        #alert_query_payload = "$data.teams[*].id"
        #alert_condition_payload = "IS"
        #alert_payload = ["PJLRE93"]
    }
}

resource "rootly_workflow_task_create_incident" "create_incident" {
    workflow_id = rootly_workflow_alert.alert.id
    task_params {
      title = "This is a test alert workflow."        
    }
}

# Incident workflow
resource "rootly_workflow_incident" "incident" {
    name = "This is a test incident workflow."
    enabled = false
    trigger_params {
    }
}