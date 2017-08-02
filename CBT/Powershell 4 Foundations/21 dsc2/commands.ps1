
# configuration to be pulled
Configuration SetIEHomePage 
{ 
    Param 
    (     
        [Parameter(Mandatory)]
        [String]$StartPageURL,    
        [String]$SecondaryStartPagesURL
    ) 
     
    Import-DSCResource -ModuleName xInternetExplorerHomePage 
  
    Node "localhost"
    { 
        xInternetExplorerHomePage IEHomePage 
        { 
            StartPage = $StartPageURL 
            SecondaryStartPages = $SecondaryStartPagesURL 
            Ensure = "Present" 
        } 
    } 
} 
  
SetIEHomePage -StartPageURL "www.cbtnuggets.com" -SecondaryStartPagesURL "www.bing.com"


# requires guid, not machine name in pull configuration
$guid = [guid]::NewGuid()
$guid

# copy .mof to pull server with new guid as name
$source = "SetIEHomePage\localhost.mof"
$destination = "\\appnugget\c`$\program files\windowspowershell\dscservice\configuration\$guid.mof"
Copy-Item -Path $source -Destination $destination

# generate checksum for the .mof
New-DSCChecksum $destination

# zip and copy custom resource over to pull server
$resource = "C:\Program Files\WindowsPowerShell\Modules\xInternetExplorerHomePage"
$source = "xInternetExplorerHomePage_1.0.0.0.zip"
$destination = "\\appnugget\c`$\program files\windowspowershell\dscservice\modules\xInternetExplorerHomePage_1.0.0.0.zip"

Add-Type -As System.IO.Compression.FileSystem 
[IO.Compression.ZipFile]::CreateFromDirectory(($resource), $source, "Optimal", $true)
Copy-Item -Path $source -Destination $destination


# generate checksum for the custom resource
New-DSCChecksum $destination