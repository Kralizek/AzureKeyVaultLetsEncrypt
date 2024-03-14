# Let's Encrypt certificates in Azure KeyVault

This repository shows how to generate a certificate using Let's Encrypt and store it in Azure KeyVault. Additionally, it installs ACMEbot for automatic renewal of the certificate.

## Variables

This module has the following variables:

|Name|Type|Required|Description|
|-|-|-|-|
|`subscription_id`|`string`|✔️|The subscription where all resources will be created|
|`location`|`string`||The location where all resources will be created. Defaults to `eastus2`.|
|`email_address`|`string`|✔️|The email address used to interact with Let's Encrypt|
|`base_zone_name`|`string`|✔️|The name of the DNS zone used as base for this example.|
|`base_zone_resource_group_name`|`string`|✔️|The name of the resource group where the base DNS zone is located.|
|`shared_subscription_id`|`string`||The ID of the subscription where the base DNS zone is located. If omitted, the `subscription_id` value is used.|
|`create_acme_both`|`bool`||Specifies if an instance of the ACMEbot module should be created. Defaults to `false`.|
