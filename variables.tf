variable "BASE_URL" {
  default     = "https://github.com/GradientFlow-ai"
  description = "GH root page"
  type        = string
}

######################### terraform repo secrets ############################
variable "AWS_ACCESS_KEY_ID" {
  type        = string
  description = "Admin account that can create IAM roles. Created in roles/admin"
  default     = "secret"
  sensitive   = true
}
variable "AWS_SECRET_ACCESS_KEY" {
  type        = string
  description = "Admin account that can create IAM roles. Created in roles/admin"
  default     = "secret"
  sensitive   = true
}
variable "TF_VAR_AWS_ACCOUNT_ID" {
  type        = string
  description = "Allows GitHub runner to authenticate with AWS. Role created manually on AWS."
  default     = "secret"
  sensitive   = true
}
variable "SUPER_GITHUB_TOKEN" {
  type        = string
  description = "A second token necessary for Github Actions terraform plan and apply in Terraform repo"
  default     = "secret"
  sensitive   = true
}
variable "TF_VAR_VERCEL_API_TOKEN" {
  type        = string
  description = "Allows Terraform's Vercel provider to manage Vercel projects"
  default     = "secret"
  sensitive   = true
}


######################### eaas repo secrets ############################
variable "DATABASE_URL" {
  type        = string
  description = "Allows eaas to access Supabase postgres"
  default     = "foo"
  sensitive   = true
}
variable "SHADOW_DATABASE_URL" {
  type        = string
  description = "Allows eaas to access Prisma postgres shadow on Supabase"
  default     = "bar"
  sensitive   = true
}


######################### vercel project: frontend secrets ############################
variable "S3_BUCKET_NAME" {
  type        = string
  description = "Tells eaas where to store documents on S3"
  default     = "secret"
  sensitive   = true
}

variable "S3_BUCKET_REGION" {
  type        = string
  description = "Allows serverless functions to make correct S3 url"
  default     = "secret"
  sensitive   = true
}

######################### vercel project: platform secrets ############################
variable "GITHUB_ID" {
  type        = string
  description = "Enables Vercel to use GitHub as OAuth provider"
  default     = "secret"
  sensitive   = true
}
variable "GITHUB_SECRET" {
  type        = string
  description = "Enables Vercel to use GitHub as OAuth provider"
  default     = "secret"
  sensitive   = true
}
variable "GOOGLE_CLIENT_ID" {
  type        = string
  description = "Enables Vercel to use Google as OAuth provider"
  default     = "secret"
  sensitive   = true
}
variable "GOOGLE_CLIENT_SECRET" {
  type        = string
  description = "Enables Vercel to use Google as OAuth provider"
  default     = "secret"
  sensitive   = true
}

variable "NEXTAUTH_URL" {
  type        = string
  description = "Serves as callback for Vercel OAuth"
  default     = "url"
  sensitive   = true
}
