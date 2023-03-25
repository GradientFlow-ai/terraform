# Add a user to the organization
resource "github_membership" "membership_for_christie" {
  username = "aretoodeetoo"
  role     = "member"
}
resource "github_membership" "membership_for_tim" {
  username = "coyotespike"
  role     = "admin"
}
resource "github_membership" "membership_for_aj" {
  username = "antoniojcaporicci"
  role     = "member"
}
