# backup-container
A container that allows for other containers to uniformly adhere to a 3-2-1

3 Backups
2 Locations
1 Off-site


## Notes

### Actions 

Actions are scripts that need to be run on the container to prepare by 
placing files on on the monted NAS drive.

Enabled by:
- An configured instance of kubectl
- A daily cron job at 1:00 AM that calls all scripts in 
  /opt/backup-data/scripts/actions/default



 
Expose multiple drop points.
Encryption
Check status

https://www.nakivo.com/blog/mount-amazon-s3-as-a-drive-how-to-guide/

