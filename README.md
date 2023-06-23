# terraform-dev-env

This is a basic terraform project within which I have tried to create the following things :

Resources :
    1. VPC
    2. Subnet
    3. Internet Gateway
    4. Route table
    5. Route for route table
    6. Association between subnet and route table
    7. Security Group
    8. key pair for instance
    9. EC2 instance (t2.micro)

Data Source :
    1. AMI for ubuntu 22.04 LTS

The project is divided among 3 files. 
"Providers.tf" contains data about AWS such as Login credentials.
For using terraform you need to create a new user from AWS IAM which has progmatic access, login credentials of this user will be used for this project.

"main.tf" contains all the Resources present in this project.

"data_source.tf" contains information about the AMI of ubuntu 22.04 lts.
