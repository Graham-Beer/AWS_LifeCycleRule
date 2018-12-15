function Get-BucketLifeCycle {
    [cmdletbinding(DefaultParameterSetName = 'FromPipeline')]
    param (
        [Parameter(Mandatory, Position = 0, ValueFromPipeline, ParameterSetName = 'FromPipeline')]
        [Amazon.S3.Model.S3Bucket] $S3Bucket,

        [Parameter(Mandatory, Position = 0, ParameterSetName = 'ByBucketString')]
        [String] $BucketByString
    )
    begin {
        if ($pscmdlet.ParameterSetName -eq 'ByBucketString') {
            $S3Bucket = Get-S3Bucket -BucketName $BucketByString
        }
    }
    process {
        $bucketRules = $S3Bucket | Get-S3LifecycleConfiguration

        foreach ($bucketRule in $bucketRules.Rules) {
            [PSCustomObject]@{
                RuleName          = $bucketRule.Id
                PrefixPath        = $bucketRule.Filter.LifecycleFilterPredicate.Prefix
                DateTimeExpire    = $bucketRule.Expiration.Date
                DaysUntilArchieve = $bucketRule.Expiration.Days
                NoncurrentExpire  = $bucketRule.NoncurrentVersionExpiration.NoncurrentDays
                Transitions       = $bucketRule.Transitions.Transitions
                StatusOfRule      = $bucketRule.Status.Value
            }
        }
    }
}
