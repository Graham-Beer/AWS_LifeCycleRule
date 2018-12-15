## Creating a transition rule
$Transition = [Amazon.S3.Model.LifecycleTransition]::new()
$Transition.Days = 7
$Transition.StorageClass = 'Glacier'

## Creating an expiration rule
$Expiration = [Amazon.S3.Model.LifecycleRuleExpiration]::new()
$Expiration.Date = [DateTime]::new(2018,12,28)

## Configuring the Lifecycle rule 
$LifecycleRule = [Amazon.S3.Model.LifecycleRule]::new()
$LifecycleRule.Expiration = $Expiration
$LifecycleRule.Prefix = $null
$LifecycleRule.Status = 'Enabled'

## Applying the lifecycle rule to the S3 Bucket
Get-S3Bucket -BucketName demo-life-cycle |
    Write-S3LifecycleConfiguration -Configuration_Rules $LifecycleRule
