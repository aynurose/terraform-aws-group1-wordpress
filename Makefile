ohio:
	terraform workspace new ohio || terraform workspace select ohio
	terraform init
	terraform apply -var-file regions/ohio.tfvars --auto-approve

virginia:
	terraform workspace new virginia || terraform workspace select virginia
	terraform init
	terraform apply -var-file regions/virginia.tfvars --auto-approve

apply-all:ohio virginia

ohio-destroy:
	terraform workspace new ohio || terraform workspace select ohio
	terraform init
	terraform destroy -var-file regions/ohio.tfvars --auto-approve

virginia-destroy:
	terraform workspace new virginia || terraform workspace select virginia
	terraform init
	terraform destroy -var-file regions/virginia.tfvars --auto-approve

destroy-all:ohio-destroy virginia-destroy
	