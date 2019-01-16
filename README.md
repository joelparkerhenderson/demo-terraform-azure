# Demo of Terraform by HashiCorp for Azure

<img src="README.png" alt="Terraform" style="width: 100%;"/>

Contents:

* [Azure setup](#azure-setup)
  * [Get your Azure account](#get-your-azure-account)
  * [Get Azure command line software (optional)](#get-azure-command-line-software-optional)
  * [Get your Azure subscription id](#get-your-azure-subscription-id)
  * [Sign in (optional)](#sign-in-optional)
* [Terraform setup](#terraform-setup)
  * [Install](#install)
  * [Configure](#configure)
  * [Initialize](#initialize)
  * [Build](#build)
  * [Plan](#plan)
  * [Congratulations](#congratulations)


## Azure setup


### Get your Azure account

Get an Azure account, if you don't already have one:

  * Go to https://azure.microsoft.com/

  * Sign up.
  
Azure offers a free trial period; this is fine for this demo. When we did a free trial period, Azure required a credit card.

Azure offers Pay-As-You-Go signup; this is what we use. If you use Pay-As-You-Go, remember to delete resources when you're done with them.


### Get Azure command line software (optional)

To install Azure CLI on macOS via brew:

```sh
$ brew update && brew install azure-cli
```

To install Azure CLI via python pip:

```sh
$ pip install azure --upgrade --user
```

Verify:

```sh
$ az --version
azure-cli (2.0.33)
...
```

### Get your Azure subscription id

Get your Azure subscription id:

  * Go to https://portal.azure.com

  * To see your subscription id, look on the web page left side icon column.

  * Click the item "Cost Management + Billing".

  * You see "Active subscriptions you've created" and a column "SUBSCRIPTION ID" column. 

  * Make a note of your subscription id.


### Sign in (optional)

To use the Azure CLI to sign in:

```sh
$ az login
To sign in, use a web browser to open the page
https://microsoft.com/devicelogin and enter the
code NGYE5M41LJ18224T to authenticate.
```

Successful sign in will reply with JSON.

Example:

```json
[
  {
    "cloudName": "AzureCloud",
    "id": "244a3a0d-ff3b-b935-ecba-bc490ee73b1d",
    "isDefault": true,
    "name": "Pay-As-You-Go",
    "state": "Enabled",
    "tenantId": "e44cb508-53fa-edf5-93b1-9df17410e137",
    "user": {
      "name": "alice@example.com",
      "type": "user"
    }
  }
]
```

## Terraform setup


### Install

Use the Terraform install page.

  * Go to https://www.terraform.io/intro/getting-started/install.html


### Configure

Create a Terraform configuration file.

Our demo configuration file is [demo.tf](demo.tf)


### Initialize

Initialize Terraform for the Azure Provider:

```sh
$ terraform init
Initializing provider plugins...
- Checking for available provider plugins on https://releases.hashicorp.com...
- Downloading plugin for provider "azurerm" (1.21.0)...
...
Terraform has been successfully initialized!
```

### Build

Use the Terraform build page.

  * Go to https://www.terraform.io/intro/getting-started/build.html

Typical commands:

  * `terraform plan` shows what will run.

  * `terraform apply` runs it.

  * `terraform show` prints the results file.


### Plan

Plan example:

```sh
$ terraform plan
Refreshing Terraform state in-memory prior to plan...
...
Terraform will perform the following actions:
...
Plan: 1 to add, 0 to change, 0 to destroy.
...
```


### Congratulations

Congratulations, you're up and running!
