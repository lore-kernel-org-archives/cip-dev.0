From: binh.nguyen.uw@rvc.renesas.com (Binh Thanh. Nguyen)
Date: Fri, 4 Aug 2017 19:22:43 +0700
Subject: [cip-dev] B@D support Renesas iwg20m board - issue
Message-ID: <FD48CE4B67D3004BAA683CC1E3106E2D07BABEAB32@RVC-MBS-CL.rvc.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello all,

I am trying to add support healthcheck for Renesas iwg20m board into [1]. My current healthcheck is just simply boot up the board (no deploy and test definition).
And I still meet one issue with that booting action. The issue is whenever I run healthcheck, It always run soft-reboot and failed. 'reboot' command is just supported after booting board. So if I booted the board first, then run the healthcheck, it will pass.

Anyone have advices for me?

Please find my patches to apply for [1] in attached files.

[1] https://gitlab.com/cip-project/cip-testing/board-at-desk-single-dev/

Below is the log:

start: 0 validate
device may need manual intervention to reboot validate duration: 0.00
start: 1 uboot-action (max 120s)
start: 1.1 uboot-prepare-kernel (max 120s) uboot-prepare-kernel duration: 0.00
start: 1.2 uboot-from-media (max 120s)
uboot-from-media duration: 0.00
start: 1.3 uboot-overlay (max 120s)
Parsed boot commands: setenv autoload no; setenv initrd_high '0xffffffff'; setenv fdt_high '0xffffffff'; setenv bootargs 'console=ttySC0,115200n8 vmalloc=384M root=/dev/mmcblk0p2 '; setenv loadkernel 'fatload mmc 2:1 0x40007fc0 uImage'; setenv loadfdt 'fatload mmc 2:1 0x40f00000 r8a7743-iwg20m.dtb'; setenv bootcmd 'run loadkernel; run loadfdt; bootm 0x40007fc0 - 0x40f00000'; run bootcmd uboot-overlay duration: 0.00
start: 1.4 connect-device (max 120s)
connect-device Connecting to device using 'telnet localhost 8020'
connect-device duration: 0.00
start: 1.5 uboot-retry (max 120s)
start: 1.5.1 reboot-device (max 120s)
start: 1.5.1.1 soft-reboot (max 120s)
reboot
reboot
reboot -n
reboot -n
reboot -n -f
reboot -n -f
soft-reboot: Wait for prompt Restarting system. 120 seconds Trying ::1...
Connected to localhost.
Escape character is '^]'.
ser2net port 8020 device /dev/ttyUSB0 [115200 N81] (Debian GNU/Linux)
case: soft-reboot
definition: lava
result: fail
level: 1.5.1.1
duration: 120.000326157
extra: ...
soft-reboot timed out after 120 seconds
soft-reboot timed out after 120 seconds
uboot-retry failed: 1 of 2 attempts. 'soft-reboot timed out after 120 seconds'
start: 1.5.1 reboot-device (max 120s)
start: 1.5.1.1 soft-reboot (max 120s)
...

Best regards,
Binh Nguyen
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-device-types-renesas-iwg20m-add-new-device-types-fil.patch
Type: application/octet-stream
Size: 3511 bytes
Desc: 0001-device-types-renesas-iwg20m-add-new-device-types-fil.patch
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20170804/c3fe3b08/attachment.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-intergration-scripts-add-renesas-iwg20m-device-type-.patch
Type: application/octet-stream
Size: 2243 bytes
Desc: 0002-intergration-scripts-add-renesas-iwg20m-device-type-.patch
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20170804/c3fe3b08/attachment-0001.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0003-tests-add-iwg20m-healthcheck-script.patch
Type: application/octet-stream
Size: 1080 bytes
Desc: 0003-tests-add-iwg20m-healthcheck-script.patch
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20170804/c3fe3b08/attachment-0002.obj>
