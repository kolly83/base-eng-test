# Cloud Systems Engineering Tests

## Scope of Work
Create and deploy a script to AWS that parses object names and moves these objects found in a S3 bucket, in account A to the destination bucket you provision in account B, depending on defined conditions.
All resources need to be provisioned using Terraform. 

High level objectives: 
- Write the script in Python version 3.8 and above.
- Configure a pipeline in CircleCI to test and deploy your code.
- Authenticate with AWS (Applicants choice)
- Provision S3 buckets as source & destination.
- Create IAM dependencies for Lambda function
- Provision and deploy your code to Lambda functions (Invocation of function is applicants choice)
- Provision a AWS CloudWatch log group to monitor and log the lambda function actions. 
- Trigger function and move objects from `bucket_A/Deliveries` to `Bucket_B/{prefix}/{file_type}` according to conditions.
- Send result notification to email address {engineering@base-mc.com}.


### Prerequisites
- Credentials to 2 sandbox AWS account will be provided to you.
- Github (or other VCS provider supported by CircleCI) account
- CircleCI account (CircleCI offer a free tier account)
- Local IDE of your choice
- Python3 (At least version 3.8)
- AWS Boto3 (at least version 1.26.0)
- AWS Lambda Powertools for Python (At least version 2.8.0)
- AWS CLI
- Terraform (At least version 1.0.0)
- Terraform Cloud Account (TFC provide a free tier)

### Lambda Function Success Criteria
- The function should be written to accept AWS Lambda's event and context responses.
- When said function is invoked (by a trigger of your choice) it should interogate `Bucket_A/Source_Folder` for objects with certain prefixes, file extenstions, and move these objects to `Bucket_B/{prefix}/{file_type}`.
- Once object move is complete a result notification should be sent to the provided email endpoint.  
- Each stage and action the function does should be logged using AWS Lambda Powertools for Python, Logger

#### Conditions
Each object that is found in Bucket_A should pass one of the following conditions: 
The filenames will be formatted like this: `{prefix}_filename.{file_extension}`

### Test Files
Use the below test files to upload to your S3 buckets.  
[/TestFiles](./TestFiles)

Acceptable filename prefixes:
- `ch1`
- `ch2`
- `vfx`
- `gfx`
- `bday`

Acceptable file extensions:
- `.wav` (Audio file type)
- `.mov` (Video file type)
- `.tga` (Image file type)

If the object passes these condtions they should be moved to the correct destination folder in Bucket_B. 

For example: 
- Filename = `ch1_test_video.mov`
- file delivered to `Bucket_A/Deliveries`
- prefix condition met
- file extension condition met
- move to `Bucket_B/ch1/video`

Should a object not meet any of these criteria, they should be moved to a `Quarantine` folder in `Bucket_A`.

### Provisioning/Deployment Success Criteria
Provisioning and Deployment is largely up to the applicant on how to execute this.
Below are the basic rquirements:
- The fundamental requirement is to successfully complete provisioning and deployment using Terraform. 
- Deployment should be achieved through a CircleCI pipeline, using best practices.
- Test and validate terraform configuration before applying.
- (Optional) Test and lint your python code.
- Correctly package and deploy your code to a Lambda function.

### Demonstrable Requirements
- Ability to comment your code and describe the functions in use.
- Ability to implement a logger that can be referenced for testing and engineer/developer experience feedback.
- Ability to implement security best practices when writing applications and building pipelines.
- Ability to document the build and usage parameters in an accompanying README file.

## References

### CircleCI
- SignUp: https://circleci.com/signup/?return-to=https%3A%2F%2Fapp.circleci.com%2F
- Documentation: https://circleci.com/docs/getting-started/

### AWS
- Boto3
    - Documentation: https://boto3.amazonaws.com/v1/documentation/api/latest/index.html
- AWS Lambda Powertools for Python
    - Documentation: https://awslabs.github.io/aws-lambda-powertools-python/2.9.0/

### Terraform
- Terraform Source
    - Documentation: https://developer.hashicorp.com/terraform/docs 
- Terraform Cloud
    - Documentation: https://developer.hashicorp.com/terraform/cloud-docs

LICENSE
See [LICENSE](LICENSE.txt)
