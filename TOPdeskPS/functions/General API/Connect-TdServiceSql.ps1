function Connect-TdServiceSql {
    <#
	.SYNOPSIS
		Prepares your session for TOPdeskPS SQL Queries

	.DESCRIPTION
		This command either generates a login token if you provide TOPdesk credentials or this will generate the headers if you are using an application password (use -ApplicationPassword)

	.PARAMETER Credential
		Credentials used to access TOPdesk SQL server.

    .PARAMETER Server
        Server adres of the TOPdesk SQL server.

    .PARAMETER Database
        The current database you would like to work in like production, staging, etc.


	.EXAMPLE
		PS C:\> Connect-TdServiceSql -Credential $Cred -Server "10.100.10.1\sql1" -Database "PRODUCTION"
#>

    [CmdletBinding(HelpUri = 'https://andrewpla.github.io/TOPdeskPS/commands/TOPdeskPS/Connect-TdServiceSql')]
    [OutputType([System.String])]
    param
    (

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [PSCredential]
        $Credential,

        [Parameter(Mandatory = $true)]
        [string]
        $Server,

        [Parameter(Mandatory = $true)]
        [string]
        $Database,

        [switch]
        $EnableException
    )
    Write-Host "Creating SQL config for TOPdesk"
    Set-PSFConfig -FullName TOPdeskPS.SQLserver -Value $Server
    Set-PSFConfig -FullName TOPdeskPS.SQLdatabase -Value $Database
    Set-PSFConfig -FullName TOPdeskPS.SQLcredentials -Value $Credential


    if (Test-PSFFunctionInterrupt) {
        return
    }
}
