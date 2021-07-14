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
        $Omschrijving = '',

        [String]
        $Username,

        [String]
        $Password,

        [String]
        $SQLServer,

        [String]
        $SQLDatabase

    )
    try{
        $query = "SELECT Naam as nummer, omschrijving, unid AS id, aanvangsdatum, einddatum FROM $SQLDatabase.dbo.dnocontract WHERE naam like '%$($Nummer)%' AND omschrijving like '%$($Omschrijving)%'"
        $res = Invoke-Sqlcmd -ServerInstance $SQLServer -Database $SQLDatabase -Query $query -Username $Username -Password $Password -Verbose
        $res

    }
    catch{

    }

}
