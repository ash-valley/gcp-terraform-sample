provider "google" {
  project = var.project
  region  = var.region
}

resource "google_cloud_scheduler_job" "slack-notify-scheduler" {
  name      = "slack-notify-daily"
  project   = var.project
  schedule  = "0 12 * * *"
  time_zone = "Asia/Tokyo"

  pubsub_target {
    topic_name = google_pubsub_topic.slack_notify.id
    data       = base64encode("{\"mention\":\"channel\",\"channel\":\"random\"}")
  }
}

resource "google_pubsub_topic" "slack_notify" {
  name    = "slack-notify"
  project = var.project
}
