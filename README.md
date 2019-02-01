# Tableau Server Single Node
<img src="https://github.com/maddyloo/tableau-server-single-node/blob/master/images/tableau_rgb.png"/>
<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2F100-blank-template%2Fazuredeploy.json" target="_blank">
<img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2F100-blank-template%2Fazuredeploy.json" target="_blank">
<img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/visualizebutton.png"/>
</a>

This template deploys a **single node Tableau Server instance on a Windows, Standard_D16_v3 VM instance** in its own Virtual Network.

`Tags: Tableau, Tableau Server, Windows Server, Analytics, Self-Service, Data Visualization, Windows`

## Tableau Server and deployed resources overview

Tableau Server on Azure is browser and mobile-based visual analytics anyone can use.  Publish interactive dashboards with Tableau Desktop and share them throughout your organization. Embedded or as a stand-alone application, you can empower your business to find answers in minutes, not months.  By deploying Tableau Server on Azure with this quickstart you can take full advantage of the power and flexibility of Azure Cloud infrastructure.  

Tableau helps tens of thousands of people see and understand their data by making it simple for the everyday data worker to perform ad-hoc visual analytics and data discovery as well as the ability to seamlessly build beautiful dashboards and reports. Tableau is designed to make connecting live to data of all types a simple process that doesn't require any coding or scripting. From cloud sources like Azure SQL Data Warehouse, to on-premise Hadoop clusters, to local spreadsheets, Tableau gives everyone the power to quickly start visually exploring data of any size to find new insights.

<img src="https://github.com/maddyloo/tableau-server-single-node/blob/master/images/azure_single_node.png"/>

The following resources are deployed as part of the solution

#### Tableau

Business Intelligence Software Provider

+ **Tableau Server Installer**: Hosted collaboration software where users can share and manage Tableau Dashboards and data sources. 
+ **config_script.ps1**: Powershell script that installs dependancies and calls python installer
+ **ScriptedInstaller.py**: Python script that performs a silent Tableau Server install

#### Microsoft Azure

This template deploys the following Azure resources.  For information on the cost of these resources please use the pricing calculator found here: https://azure.microsoft.com/en-us/pricing/calculator/

+ **Virtual Network**: New (or existing) virtual network that contains all relevant resources required by the Tableau Server install
+ **Virtual Machine**: Standard_D16-v3 instance
+ **Network Interface**: Allows Azure VM to communicate with the internet
+ **Public IP Address**: Static Public IP that allows users to access Tableau Server
+ **Network Security Group**: Limits traffic to Azure VM (RDP/SSH & port 80/22 only)

## Prerequisites

By default this template will install a 12-day free trial of Tableau Server.  To switch to a licensed version please contact your Tableau Sales representative.

## Deployment steps

You can click the "Deploy to Azure" button at the beginning of this document or follow the following instructions for command line deployment using the scripts in the root of this repo.

To deploy this template using the scripts from the root of this repo: 

Powershell:
```PowerShell
.\Deploy-AzureResourceGroup.ps1 -ResourceGroupLocation 'west us' -ArtifactsStagingDirectory 'tableau-server-single-node' -UploadArtifacts 
```
Bash:
```bash
azure-group-deploy.sh -a tableau-server-single-node -l westus -u
```

## Usage

#### Connect

Navigate to Tableau Server using the public IP address: http://- Public IP -:80

#### Management

Manage your Azure resources directly from your Azure portal.  Use the web UI and Desktop Interface to adminsitrate your Tableau Server instance: https://onlinehelp.tableau.com/current/server/en-us/admin.htm  

## Notes

Follow these requirements when setting parameters: https://docs.microsoft.com/en-us/azure/virtual-machines/windows/faq#what-are-the-username-requirements-when-creating-a-vm

This template is intended as a sample for how to install Tableau Server.  If you choose to run a production version of Tableau Server you are responsible for managing the cost & security of your Azure & Tableau deployment.  This version has been written by Madeleine Corneli and is not officially endorsed by Tableau Software.