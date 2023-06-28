Deployment Notes
1. To initiate the deployment 
    a. push code to master
    b. run command 'cap production deploy'

Access AWS from terminal
1. Execute 'ssh -i "urban-key.pem" adminman@ec2-3-110-118-27.ap-south-1.compute.amazonaws.com'
2. Enter password #E20****
3. 

Troubleshoot
1. git@github.com: Permission denied (publickey). 
    Make sure you have the correct access rights and the repository exists
    Resource: https://capistranorb.com/documentation/getting-started/authentication-and-authorisation/

    Solution: Execute 'ssh-add' in local machine and 'ssh-add' in remote machine