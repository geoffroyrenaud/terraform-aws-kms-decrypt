
provider "aws" {
  version = "~> 3"
  region  = "eu-west-1"

}

resource "aws_kms_key" "test" {
  description = "test key"
  is_enabled  = true
}

data "aws_kms_ciphertext" "test" {
  key_id = "${aws_kms_key.test.key_id}"

    plaintext = <<EOF
{
  "client_id": "e587dbae22222f55da22",
  "client_secret": "8289575d00000ace55e1815ec13673955721b8a5"
}
EOF
}

data "aws_kms_ciphertext_decrypt" "test" {
  key_id = "${aws_kms_key.test.key_id}"

  ciphertext_blob = "AQICAHjpl+Jso80PAhn6Y25NdSrCrN/3jkn5QgFnIYHxFhKfEwFevfP5zEGiLdapRmuomL3fAAAAzDCByQYJKoZIhvcNAQcGoIG7M IG4AgEAMIGyBgkqhkiG9w0BBwEwHgYJYIZIAWUDBAEuMBEEDNeBdZ/dTEged2fT7AIBEICBhMZyoVMLIoSlSvdiFPwLlu5Vq7sbfkEyF3byYbB4K4w6d+jGNoIElso+0Yh4vh9Md7xeZZ0DGwEdjdsrz0mgkwHPHmEDCdVCDykSdqcJ4XXT1D1iPyNSJP16q6NmGuDQ85SE5krfJQ8ARRFYAU3mRt8qXskghwdgYusd/pHn0JH3IdGsvw=="
}

output "encrypt" {
  value = data.aws_kms_ciphertext.test
}

output "decrypt" {
value = data.aws_kms_ciphertext_decrypt.test
}
