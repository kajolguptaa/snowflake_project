create or replace storage integration superstore_int
    type = external_stage
    storage_provider = s3
    enabled = true
    storage_aws_role_arn = 'arn:aws:iam::308435124514:role/bucket0416_policy_role'
    storage_allowed_locations = ('s3://bucket0416/');
    
DESC INTEGRATION superstore_int;