rm ./apache/log/*_log
rm ./php/error_log/*.log
Remove-Item ./vsftpd/user_conf/* -Exclude .gitkeep
rm ./vsftpd/log/*.log
rm ./cert/server.*