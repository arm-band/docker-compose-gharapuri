rm ./apache/log/*.log
find ./apache/www/ -type f | grep -v -E "\.gitkeep" | xargs rm -rf
rm ./php/error_log/*.log
find ./vsftpd/user_conf/ -type f | grep -v -E "\.gitkeep" | xargs rm -rf
rm ./vsftpd/log/*.log
rm ./cert/server.*