# D:\inetpub\ad-transact-rpc-api\scripts\Modules\Assert\AssertionFailedException-Test.ps1
using module '.\Assert.psm1'
using module '.\AssertionFailedException.psm1'

function Get-ScriptLineNumber { return $MyInvocation.ScriptLineNumber }
function Get-ScriptName { return $MyInvocation.ScriptName }

new-item alias:__LINE__ -value Get-ScriptLineNumber | out-null
new-item alias:__FILE__ -value Get-ScriptName | out-null

try
{
    # $value1 = @("jcitiz","something","stringstringstringstringstringstringstringstringstringstringstringstringstringstringstringstringstringstringstringstringstringstringstringstringstringstringstringstringstringstringstringstringstringstringstringstringstringstringstringstringstringstringstringstringstringstringstringstringstringstring","blah")
    # [void][Assert]::new($value1).
    #         fieldName('username').
    #         file($(__FILE__)).
    #         line($(__LINE__)).
    #         all().
    #         samAccountName()

    $value2 = "stringstringstringstringstringstringstringstringstringstring"
    [void][Assert]::new($value2).all().file($(__FILE__)).line($(__LINE__)).fieldName("USERNAAEM").samAccountName("your username is invalid.")
}
catch [AssertionFailedException]
{
    [AssertionFailedException]  $e = [AssertionFailedException] $_.Exception
    write-host $e.jsonSerialize()
}

