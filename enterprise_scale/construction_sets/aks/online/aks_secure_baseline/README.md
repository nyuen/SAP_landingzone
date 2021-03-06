# Enterprise-Scale Construction Set for Azure Kubernetes Services using Terraform

Enterprise-scale is an architectural approach and a reference implementation that enables effective construction and operationalization of landing zones on Azure, at scale. This approach aligns with the Azure roadmap and the Cloud Adoption Framework for Azure.

The Azure Kubernetes Services Construction Set is an implementation of [AKS Secure Baseline Architecture](https://github.com/mspnp/aks-secure-baseline) for Enterprise-Scale Online Landing zone. An application deployed in a subscription for an online landing zone will be internet-facing, and does not require hybrid connectivity.

This implementation is based on [Cloud Adoption Framework Landing Zones for Terraform best practices](https://github.com/Azure/caf-terraform-landingzones).

![network](pictures/ns-vwan.png)

## Applied Azure Policies for Online Landing zones

The list below details only notable Policies for this implementation, it is not exhaustive.  
Please view Azure Policy portal or [List all assigned Azure Policies](#list-all-assigned-azure-policies) section to list out the details of assigned policies

| Policy                          | Config files                                                                                                                                                                                                                                                                                                                     |
|---------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Deploy-AKS-Policy               | Deploy Azure Policy Add-on to Azure Kubernetes Service clusters                                                                                                                                                                                                                                                                  |
| Deny-Privileged-AKS             | Do not allow privileged containers in Kubernetes cluster. <br /> Excluded namespaces: kube-system; gatekeeper-system; azure-arc; **cluster-baseline-settings** <br /> <br />  **cluster-baseline-settings** namespace is dedicated to host Daemonsets components such as AKV Secret Store CSI driver, AAD Pod Identity, Kured... |
| Deny-Privileged-Escalations-AKS | Kubernetes clusters should not allow container privilege escalation <br /> Excluded namespaces: kube-system; gatekeeper-system; azure-arc; **cluster-baseline-settings**                                                                                                                                                         |
| Enforce-Https-Ingress-AKS       | Enforce HTTPS ingress in Kubernetes cluster                                                                                                                                                                                                                                                                                      |

<br />

### List all assigned Azure Policies

```Bash
# To view details of assigned Policies of the current Subscription
az policy assignment list --disable-scope-strict-match

# To view details of assigned Policies of the a resource
az policy assignment list --disable-scope-strict-match --scope {RESOURCEID} 
```

## Prerequisites

There is required access and tooling you'll need in order to accomplish this. Follow the instructions below and on the subsequent pages so that you can get your environment ready to proceed with the AKS cluster creation.

1. An Azure subscription. If you don't have an Azure subscription, you can create a [free account](https://azure.microsoft.com/free).

   > :warning: The user or service principal initiating the deployment process _must_ have the following minimal set of Azure Role-Based Access Control (RBAC) roles:
   >
   > * [Contributor role](https://docs.microsoft.com/azure/role-based-access-control/built-in-roles#contributor) is _required_ at the subscription level to have the ability to create resource groups and perform deployments.
   > * [User Access Administrator role](https://docs.microsoft.com/azure/role-based-access-control/built-in-roles#user-access-administrator) is _required_ at the subscription level since you'll be granting least-privilege RBAC access to managed identities.
   >   * One such example is detailed in the [Container Insights documentation](https://docs.microsoft.com/azure/azure-monitor/insights/container-insights-troubleshoot#authorization-error-during-onboarding-or-update-operation).

1. An Azure AD tenant to associate your Kubernetes RBAC configuration to.

   > :warning: The user or service principal initiating the deployment process _must_ have the following minimal set of Azure AD permissions assigned:
   >
   > * Azure AD [User Administrator](https://docs.microsoft.com/azure/active-directory/users-groups-roles/directory-assign-admin-roles#user-administrator-permissions) is _required_ to create a "break glass" AKS admin Active Directory Security Group and User. Alternatively, you could get your Azure AD admin to create this for you when instructed to do so.
   >   * If you are not part of the User Administrator group in the tenant associated to your Azure subscription, please consider [creating a new tenant](https://docs.microsoft.com/azure/active-directory/fundamentals/active-directory-access-create-new-tenant#create-a-new-tenant-for-your-organization) to use while evaluating this implementation.

1. Latest [Azure CLI installed](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest) or you can perform this from Azure Cloud Shell by clicking below.

   [![Launch Azure Cloud Shell](https://docs.microsoft.com/azure/includes/media/cloud-shell-try-it/launchcloudshell.png)](https://shell.azure.com)

1. Clone/download this repo locally, or even better fork this repository.

   > :twisted_rightwards_arrows: If you have forked this reference implementation repo, you'll be able to customize some of the files and commands for a more personalized experience; also ensure references to repos mentioned are updated to use your own (e.g. the following `GITHUB_REPO`).

   ```bash
   export GITHUB_REPO=https://github.com/Azure/caf-terraform-landingzones-starter.git
   git clone $GITHUB_REPO
   ```

   > :bulb: The steps shown here and elsewhere in the reference implementation use Bash shell commands. On Windows, you can use the [Windows Subsystem for Linux](https://docs.microsoft.com/windows/wsl/about#what-is-wsl-2) to run Bash.


# Next step

:arrow_forward: [Deploy infrastructures using Terraform](./01-terraform.md)
