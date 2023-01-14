# grimoire

grimoire is a wiki application based on git repositories. this apps have similar functionality as `docusaurus`, 
an app that let user focus on creating content like documentation, blog, or articles. The only difference is this app
use git repository as data / content provider. All you need to do is only set up your related git auth token and project path.

## Features
Here's some features that will provided :
- 📃Document Versioning : since it's git based, so file versioning will use `commit` as version control, which mean we can also track who make changes.
- 🔍Content Search : search everything through single search bar
- 🍨Flavored markdown
- 🗃Git as Content Provider : all content stored as git project, so it easy to edit, no need to recompile the project.

## Roadmap
- Outgoing Links
- Backlinks


## Changelog 📝
[See full changes through version here.](CHANGELOG.md)

## Deploy as WAR for Weblogic
1. ``cd /<path_project>/build/web``
2. ``jar -cvf grimoire.war *``

## Deploy using Docker with NGINX
1. ``docker build -t grimoire:[APP_VERSION] .``
2. ``docker run --name grimoire -d -p 8085:8085 grimoire:[APP_VERSION]``

## Windows MSIX tutorial
https://docs.microsoft.com/en-us/windows/msix/package/create-certificate-package-signing
```
New-SelfSignedCertificate -Type Custom -Subject "CN=PBS Software, O=dargoz, C=ID" -KeyUsage DigitalSignature -FriendlyName "MB Back Office" -CertStoreLocation "Cert:\CurrentUser\My" -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.3", "2.5.29.19={text}")
```
You can view your certificate in a PowerShell window by using the following commands:
```
Set-Location Cert:\CurrentUser\My
Get-ChildItem | Format-Table Subject, FriendlyName, Thumbprint
```
Above command will print :
```
Thumbprint                   Subject
----------                   -------
<YOUR Thumbprint>            CN=PBS Software, O=dargoz, C=ID
```
then you can use that information to
export cert :
```cmd
$password = ConvertTo-SecureString -String <YOUR PASSWORD> -Force -AsPlainText
Export-PfxCertificate -cert "Cert:\CurrentUser\My\<YOUR Thumbprint>" -FilePath "C:\dev\certs\grimoire.pfx" -Password $password
```
note : More detail explanation coming soon
