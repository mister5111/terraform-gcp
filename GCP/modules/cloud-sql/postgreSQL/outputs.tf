output "postgres_instance" {
  value = google_sql_database_instance.postgres_instance.ip_address
}
output "default_db" {
  value = google_sql_database.default_db.instance
}