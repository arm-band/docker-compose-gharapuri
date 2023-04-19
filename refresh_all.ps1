rm ./apache/log/*.log
Remove-Item ./apache/www/* -Exclude .gitkeep -Recurse -Force
rm ./php/error_log/*.log
Remove-Item ./vsftpd/user_conf/* -Exclude .gitkeep
rm ./vsftpd/log/*.log
rm ./cert/server.*