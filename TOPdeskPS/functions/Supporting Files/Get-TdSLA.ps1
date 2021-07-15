function Get-TdSLA {
    <#
    .SYNOPSIS
        Gets SLA's
    .DESCRIPTION
        Get SLA details
    .PARAMETER Nummer
        Retrieve contracts by their friendly number
    .PARAMETER Omschrijving
        Retrieve contract by their description field where normally the company name exist
    .EXAMPLE
        PS C:\> Get-TdSLA -Username "test" -Password "password" -SQLServer "10.100.100.10/sql1" -SQLDatabase "PRODUCTION" -Nummer "SLA10020" OR -Omschrijving "Company Name"
        Returns all SLA contracts

    #>
    [CmdletBinding(HelpUri = 'https://andrewpla.github.io/TOPdeskPS/commands/Get-TdSLA')]
    param (
        [Parameter(Position = 0)]
        [String]
        $Nummmer = 'SLA',

        [String]
        $Omschrijving = ''

    )
    try{

        $SQLServer = Get-PSFConfigValue -FullName TOPdeskPS.SQLserver -NotNull
        $SQLDatabase = Get-PSFConfigValue -FullName TOPdeskPS.SQLdatabase -NotNull
        $SQLcredentials = Get-PSFConfigValue -FullName TOPdeskPS.SQLcredentials -NotNull

        $query = "SELECT Naam as nummer, omschrijving, unid AS id, aanvangsdatum, einddatum FROM $SQLDatabase.dbo.dnocontract WHERE naam like '%$($Nummer)%' AND omschrijving like '%$($Omschrijving)%'"
        $res = Invoke-Sqlcmd -ServerInstance $SQLServer -Database $SQLDatabase -Query $query -Username $SQLcredentials.username -Password $SQLcredentials.GetNetworkCredential().password -Verbose
        $res

    }
    catch{
        throw 'You have created a connection with the SQL database of TOPdesk, please use "Connect-TdServiceSql" to create a secure SQL connection with the database'
    }

}
