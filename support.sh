#!/system/bin/sh

if [ ! -d /system/etc/init.d ]; then
        echo "Create init.d directory" 
        /system/bin/mkdir /system/etc/init.d
        chown root.root /system/etc/init.d
		chmod 0755 /system/etc/init.d
fi

if [ -e /system/etc/init.qcom.post_boot.sh ]; then
	if grep "/system/xbin/busybox run-parts /system/etc/init.d" /system/etc/init.qcom.post_boot.sh > /dev/null; then
		:
	else
		echo "/system/xbin/busybox run-parts /system/etc/init.d" >> /system/etc/init.qcom.post_boot.sh
	fi
elif [ -e /system/etc/hw_config.sh ]; then
	if grep "/system/xbin/busybox run-parts /system/etc/init.d" /system/etc/hw_config.sh > /dev/null; then
		:
	else
		echo "/system/xbin/busybox run-parts /system/etc/init.d" >> /system/etc/hw_config.sh
	fi
fi

if [ ! -e /system/etc/init.d/99SuperSUDaemon ]; then
        echo "Create script"
        echo "#!/system/bin/sh" > /system/etc/init.d/99SuperSUDaemon
        echo "" >> /system/etc/init.d/99SuperSUDaemon
        echo "/system/xbin/daemonsu --auto-daemon &" >> /system/etc/init.d/99SuperSUDaemon
        chown root.root /system/etc/init.d/99SuperSUDaemon
        chmod 0755 /system/etc/init.d/99SuperSUDaemon
fi

echo " "
echo "All done..."
exit 0;
