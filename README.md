<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a id="readme-top"></a>

<!-- PROJECT SHIELDS -->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![Unlicense License][license-shield]][license-url]

<br />

<!-- PROJECT LOGO -->
<div align="center">
  <a href="https://github.com/telekom-mms/terraform-aws-kms">
    <img src="logo.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">AWS KMS Module</h3>

  <p align="center">
    PSA-compliant KMS module with mandatory rotation, secure default policies, and extended deletion protection.
    <br />
    <a href="https://github.com/telekom-mms/terraform-aws-kms"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/telekom-mms/terraform-aws-kms">View Demo</a>
    ·
    <a href="https://github.com/telekom-mms/terraform-aws-kms/issues/new?labels=bug&template=bug-report---.md">Report Bug</a>
    ·
    <a href="https://github.com/telekom-mms/terraform-aws-kms/issues/new?labels=enhancement&template=feature-request---.md">Request Feature</a>
  </p>
</div>

## Documentation

Full auto-generated documentation of inputs, outputs, and resources: [TERRAFORM-DOCS.md](TERRAFORM-DOCS.md)

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#about-the-project">About The Project</a></li>
    <li><a href="#getting-started">Getting Started</a></li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#security-features">Security Features</a></li>
    <li><a href="#psa-compliance-features">PSA Compliance Features</a></li>
    <li><a href="#outputs">Outputs</a></li>
    <li><a href="#troubleshooting">Troubleshooting</a></li>
    <li><a href="#license">License</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
## About The Project

This module manages AWS Key Management Service (KMS) keys with a focus on security and compliance. It enforces best practices like automatic rotation and restrictive policies to protect your data at rest.

### Features

- **Symmetric & Asymmetric Support**: Flexible key specification for different use cases.
- **Mandatory Rotation**: Automatic annual rotation is enabled by default.
- **Secure Policies**: Generates a default policy that restricts management to the account root while allowing easy expansion.
- **Alias Management**: Simplified alias creation for readable key identification.
- **Deletion Protection**: Default 30-day deletion window to prevent accidental key loss.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- USAGE -->
## Usage

### Basic Usage

```hcl
module "kms" {
  source = "./terraform-aws-kms"

  project_name = "myapp"
  environment  = "prod"
  
  alias_name  = "myapp-storage-key"
  description = "Encryption key for application storage"
}
```

### Advanced Usage with Grants

```hcl
module "kms_with_grants" {
  source = "./terraform-aws-kms"

  project_name = "secure-data"
  environment  = "prod"
  
  grants = {
    lambda_access = {
      name              = "lambda-grant"
      grantee_principal = module.lambda.role_arn
      operations        = ["Encrypt", "Decrypt", "GenerateDataKey"]
    }
  }
}
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- SECURITY FEATURES -->
## Security Features

- **Automatic Rotation**: Reduces the impact of a compromised key by ensuring key material is changed regularly.
- **Extended Deletion Window**: Sets a 30-day mandatory wait period before a key is permanently deleted.
- **Restrictive Default Policy**: Follows the principle of least privilege for key management.
- **Multi-Region Support**: Option to create multi-Region keys for global application consistency.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- PSA COMPLIANCE FEATURES -->
## PSA Compliance Features

This module implements the following PSA compliance features (referencing `01-Strukturierte_PSA_Anforderungen_Allgemein.pdf`):

### Security Controls

- **Req 1 (Encryption Key Management)**: Full lifecycle management for secure key creation, aliasing, grants, rotation, and controlled deletion.
- **Req 1 (Rotation)**: `enable_key_rotation = true` is enforced by default for production-ready key hygiene.
- **Req 1 (Access Governance)**: Granular policy and grant management support least-privilege key usage patterns.
- **Req 1 (Operational Visibility)**: Outputs expose key, alias, grant IDs, and grant tokens for downstream integrations.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- TROUBLESHOOTING -->
## Troubleshooting

### Access Denied (KMS)

- Verify the calling principal is added to the key policy or has a valid grant.
- Ensure the key is in the `Enabled` state (`is_enabled = true`).

### Key Deletion Recovery

- If a key was accidentally deleted, it can be recovered during the deletion window (default 30 days) using the AWS console or CLI.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
[contributors-shield]: https://img.shields.io/github/contributors/telekom-mms/terraform-aws-kms.svg?style=for-the-badge
[contributors-url]: https://github.com/telekom-mms/terraform-aws-kms/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/telekom-mms/terraform-aws-kms.svg?style=for-the-badge
[forks-url]: https://github.com/telekom-mms/terraform-aws-kms/network/members
[stars-shield]: https://img.shields.io/github/stars/telekom-mms/terraform-aws-kms.svg?style=for-the-badge
[stars-url]: https://github.com/telekom-mms/terraform-aws-kms/stargazers
[issues-shield]: https://img.shields.io/github/issues/telekom-mms/terraform-aws-kms.svg?style=for-the-badge
[issues-url]: https://github.com/telekom-mms/terraform-aws-kms/issues
[license-shield]: https://img.shields.io/github/license/telekom-mms/terraform-aws-kms.svg?style=for-the-badge
[license-url]: https://github.com/telekom-mms/terraform-aws-kms/blob/master/LICENSE.txt
