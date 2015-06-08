# server-status
Bash script that outputs server details to an html page

##Step 1
Move script to wherever you store your user scripts (ex: /home/user/sys.sh). 

##Step 2
Set up cron job--update script and output file locations as needed.
```
0,30 * * * * /home/user/sys.sh > /var/www/domain/htdocs/status.html
```
This will run the script every 30 minutes and output the contents to an html file called status.html.

##Step 3
Ask yourself why you didn't invest in a monitoring solution. 
