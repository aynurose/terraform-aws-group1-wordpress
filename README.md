# terraform-aws-group1-wordpress
Installing-Wordpress-AWS_Terraform 
Group1 (Olga, Natalia, Aigerim, Aynura, Anton)                        


- You can copy paste all .tf files from github account or just test by using module which is given as a 2nd option bellow and simplifies the task. 
                                    
                                    ##1st option

- **main.tf** - includes provider, VPC, 3 subnets (2 public and 1 private ones), route tables and its subnet associations, internet gateway, NAT gateway with allocating elastic IP. In this step we are also opening necessary ports like 22,80,3306 by creating 2 security groups for RDS and EC2 instance  with Wordpress application and mariadb database

- **vars.tf** - all variables and their values that are used in our Project1 

Then 

- Create [3 .tfvars] files under the regions folder **ohio.tfvars**, **virginia.tfvars** and 1 ./tfvars file in terms of root folder/**terraform.tfvars**:

-for ohio.tfvars

    region = "us-east-2"
    vpc_cidr = "10.0.0.0/16"
    public1_cidr = "10.0.1.0/24"
    public2_cidr = "10.0.2.0/24"
    private1_cidr = "10.0.3.0/24"

-for virginia.tfvars

    region = "us-east-1"
    vpc_cidr = "10.60.0.0/16"
    public1_cidr = "10.60.1.0/24"
    public2_cidr = "10.60.2.0/24"
    private1_cidr = "10.60.3.0/24"

- for terraform.tfvars.

    username = "aynurka"
    password = "aynura12345"
    dbname = "wordpressdb"


- **ec2.tf**-  includes creation of RDS and EC2 instance with provisioner "remote exec". 

- **Makefile** -used to automate and ease the deployment process. It simplifies our script and at the same time can create in several workpaces . In our case we used 2 regions: Ohio and Virgina. But before using makefile , you have to install make package to your machine with command : [sudo yum install make -y] , then you can run commands: "make ohio", "make virginia", "make ohio-destroy", "make virginia-destroy" or "make apply-all" or "make destroy-all".

- **backend.tf** - used to store our tfstate file in S3 bucket. First of all , you have to create manually S3 bucket ,give uniq name and enable bucket versioning  then connect with terraform with those backend S3 code written in backend.tf file change name of the bucket to your name if you want. 

- Then run command:
:terraform init  
- If you want to add or do modification in terraform backend s3 code after creation of a code .You have to run command:
:terraform init -migrate state

- At the end run command:
:[make ohio] 
   - you can run any make commands, it depends on your choice. 

** Below action the same for both option 
** - You will wait approximately 12-14 minutes , then check Ohio region, there you will find EC2 instance, VPC with all it`s components and RDS will be runining and available for check.

- copy public ip of instance and go to your browser -enter 

-WORDPRESS application will be installed, use all values from terraform.tfvars (db_name,username,password) and     enpoint of RDS to open Wordpress , then on the second filling page write any names of site , username, password and any email adress but remember your username and password entered, you will use it to sign in to Wordpress website. 

- go to AWS EC2 console, connect to your instance ,connect with instance through connect then run command:

: mysql -h endpoint of database -P 3306 -u username -p     ENTER
- password will be asked , use password that was used in db_instance(RDS) creation.
- msql > is succesfully opened 
**




                                   ##2nd option

- Open a new folder in Visual Code with any name ex: “Module test” , create your own **main.tf** file ,copy paste **gitignore** to your folder. 
- To **main.tf** file copy paste bellowing USAGE and run:
 : terraform init
-	You will deal with :
 
Warning: Backend configuration ignored
│ 
│   on .terraform/modules/ohio/backend.tf line 2, in terraform:
│    2:   backend "s3" {
│

     The Warning: Backend configuration ignored implies that the module is not actually at the root and is being used incorrectly. You cannot interactively get input for module variables outside of the root module.  

BUT SKIP IT, IT SHOULD WORK 
    This is a warning rather than an error because it's sometimes convenient to temporarily call a root module as a child module for testing purposes, but this backend configuration block will have no effect.
╵



##USAGE 

```hcl
module "ohio" {
  source  = "aynurose/group1-wordpress/aws"
  version = "0.0.2"
  region = "us-east-2"
  vpc_cidr = "10.0.0.0/16"
  public1_cidr = "10.0.1.0/24"
  public2_cidr = "10.0.2.0/24"
  private1_cidr = "10.0.3.0/24"
  username = "aynurka"
  password = "aynura12345"
  dbname = "wordpressdb"
}

module "virginia" {
  source  = "aynurose/group1-wordpress/aws"
  version = "0.0.2"
  region = "us-east-1"
  vpc_cidr = "10.60.0.0/16"
  public1_cidr = "10.60.1.0/24"
  public2_cidr = "10.60.2.0/24"
  private1_cidr = "10.60.3.0/24"
  username = "aynurka"
  password = "aynura12345"
  dbname = "wordpressdb"
}
```



    You can use terraform to target a certain module or two modules will be creating at the same time, depends on you.

-For one module , run commands:
: terraform apply -target module.ohio        (or ……..module.virginia)
: terraform destroy -target module.ohio    (or ……..module.virginia)


-For multiple modules:
: terraform apply -target module.ohio -target virginia 
To destroy it , run :
 : terraform destroy -target module.ohio -target virginia 






  












