# Creo el bucket S3, uso for_each para poder crear varios buckets si es necesario
resource "aws_s3_bucket" "this" {
  for_each = var.s3_config

  # El nombre del bucket se toma de la variable
  bucket = each.value.bucket_name

  # Se agregan los tags combinando los tags globales del proyecto.
  tags = merge(
    each.value.tags,
    var.tags
  )
}

# Activo o desactivo el versionamiento del bucket para guardar historial de cambios.
resource "aws_s3_bucket_versioning" "this" {
  for_each = var.s3_config

  bucket = aws_s3_bucket.this[each.key].id

  versioning_configuration {
    status = each.value.versioning ? "Enabled" : "Suspended"
  }
}

# Controlo si el bucket debe tener acceso publico.
resource "aws_s3_bucket_public_access_block" "this" {
  for_each = var.s3_config

  bucket = aws_s3_bucket.this[each.key].id

  block_public_acls       = each.value.block_public_acls
  block_public_policy     = each.value.block_public_policy
  ignore_public_acls      = each.value.ignore_public_acls
  restrict_public_buckets = each.value.restrict_public_buckets
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  for_each = var.s3_config

  bucket = aws_s3_bucket.this[each.key].id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = each.value.sse_algorithm
    }
  }
}

# subo el archivo index.html al bucket
resource "aws_s3_object" "index" {
  for_each = var.s3_config

  bucket       = aws_s3_bucket.this[each.key].id
  key          = each.value.index_document
  source       = each.value.index_html_path
  content_type = each.value.content_type

  depends_on = [aws_s3_bucket_public_access_block.this]
}

# Configuro el bucket para que funcione como sitio web estático 
resource "aws_s3_bucket_website_configuration" "this" {
  for_each = var.s3_config

  bucket = aws_s3_bucket.this[each.key].id

  index_document {
    suffix = each.value.index_document
  }
}

# Creo la política de acceso del bucket
resource "aws_s3_bucket_policy" "this" {
  for_each = var.s3_config

  bucket = aws_s3_bucket.this[each.key].id

  depends_on = [aws_s3_bucket_public_access_block.this]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = each.value.bucket_policy_effect
        Principal = each.value.bucket_policy_principal
        Action    = each.value.bucket_policy_action
        Resource  = "${aws_s3_bucket.this[each.key].arn}/*"
      }
    ]
  })
}