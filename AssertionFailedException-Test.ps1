# D:\inetpub\ad-transact-rpc-api\scripts\Modules\Assert\AssertionFailedException-Test.ps1
using module '.\Assert.psm1'
using module '.\AssertionFailedException.psm1'
$value1 = 1
$value2 = 2

try
{
    [Assert]::new($value1).code(500).eq($value2)
}
catch [AssertionFailedException]
{

#     $formatstring = "{0} : {1}`n{2}`n" +
#                 "    + CategoryInfo          : {3}`n"
#                 "    + FullyQualifiedErrorId : {4}`n"

# $fields = $_.InvocationInfo.MyCommand.Name,
#           $_.ErrorDetails.Message,
#           $_.InvocationInfo.PositionMessage,
#           $_.CategoryInfo.ToString(),
#           $_.FullyQualifiedErrorId

# $formatstring -f $fields
[AssertionFailedException] $e = [AssertionFailedException]$_.Exception
    write-host  $e.jsonSerialize()
    write-host $e.getProperty()
$_.in
    $MyInvocation.ScriptLineNumber 
write-host "Location:"
write-host $_.ge




.InvocationInfo.ScriptLineNumber
write-host $e.InvocationInfo.ScriptLineNumber

        # https://poshoholic.com/2009/01/19/powershell-quick-tip-how-to-retrieve-the-current-line-number-and-file-name-in-your-powershell-script/
        # https://www.petri.com/unraveling-mystery-myinvocation
        $MyInvocation.ScriptName 
        $MyInvocation.ScriptLineNumber 


        $STACKTRACE
        Contains a stack trace for the most recent error.


    # write-host $Error[0].InvocationInfo.Line
    # write-host $Error[0].InvocationInfo.PositionMessage
    # write-host $Error[0].Exception.GetBaseException() | format-list -Property *
    
    # .ErrorRecord.InvocationInfo.Line
}