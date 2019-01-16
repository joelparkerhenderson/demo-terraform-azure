# Demo of Terraform by HashiCorp for Azure

Contents:

* [Azure setup](#azure-setup)
  * [Get your Azure account](#get-your-azure-account)
  * [Get Azure software](#get-azure-software)
  * [Get your Azure subscription id](#get-your-azure-subscription-id)
* [Terraform setup](#terraform-setup)
  * [Install](#install)
  * [Configure](#configure)
  * [Build](#build)


## Azure setup


### Get your Azure account

Get an Azure account, if you don't already have one:

  * Go to https://azure.microsoft.com/

  * Sign up.
  
  * You'll need a credit card.


### Get Azure software

If you want, you can install Python, PIP, and Azure on macOS:

    brew install python
    pip install --pre azure


### Get your Azure subscription id

Get your Azure subscription id:

  * Go to https://portal.azure.com

  * To see your subscription id, look on the web page left side icon column.

  * click the "Billing" icon. 

  * You see "Active subscriptions you've created" and a column "SUBSCRIPTION ID" column. 

  * Make a note of your subscription id.


## Terraform setup


### Install

Use the Terraform install page.

  * Go to https://www.terraform.io/intro/getting-started/install.html

  * Caveat: When I try to install Terraform on a MacBook with macOS by using `brew install terraform`, then the brew tool warns me that this is not yet supported. 

  * Workaround on Mac: download the Mac binary, unzip it, and move the `terraform` binary to somewhere convenient; I move it to my `/usr/local/bin` directory, which already on my path.


### Configure

Create a Terraform configuration file.

Our demo configuration file is [demo.tf](demo.tf)


### Build

Use the Terraform build page.

  * Go to https://www.terraform.io/intro/getting-started/build.html

Typical commands:

  * `terraform plan` shows what will run.

  * `terraform apply` runs it.

  * `terraform show` prints the results file.

Congratulations, you're up and running!
