# resource "google_sql_database_instance" "postgres_instance" {
#   name             = format("%s-postgres", var.env)
#   deletion_protection = false
#   database_version = "POSTGRES_14"
#   region           = var.zone_names[1]

#   settings {
#     tier = "db-f1-micro"

#     ip_configuration {
#       ipv4_enabled    = true
#       authorized_networks {
#         name  = "my-ip"
#         value = "85.198.140.130"
#       }
#     }

#     backup_configuration {
#       enabled                        = false
#       point_in_time_recovery_enabled = false
#     }

#     location_preference {
#       zone = format("%s-a", var.zone_names[1])
#     }
#   }
# }

# resource "google_sql_user" "postgres_user" {
#   name     = "admin"
#   instance = google_sql_database_instance.postgres_instance.name
#   password = "admin1234"
# }

# resource "google_sql_database" "default_db" {
#   name     = "kodi-db"
#   instance = google_sql_database_instance.postgres_instance.name
# }