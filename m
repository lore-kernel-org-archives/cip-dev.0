X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web11.13754.1663688426045925302
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Sep 2022 08:40:27 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.153, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 28KFeNl8014500; Wed, 21 Sep 2022 00:40:23 +0900
X-Iguazu-Qid: 34tMQIIQy0tvlQQ0YN
X-Iguazu-QSIG: v=2; s=0; t=1663688422; q=34tMQIIQy0tvlQQ0YN; m=rTj8TkOTJJULh/T3sMXQuDzFrlzUAZLpo2tkEtZ0mA0=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1512) id 28KFeLIq016702
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 21 Sep 2022 00:40:22 +0900
From: sai.sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core] README.secureboot.md : Update steps for bullseye version
Date: Tue, 20 Sep 2022 21:10:19 +0530
X-TSB-HOP2: ON
Message-Id: <20220920154019.555-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-OriginalArrivalTime: 20 Sep 2022 15:40:19.0626 (UTC) FILETIME=[49EE78A0:01D8CD07]
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
List-Id: <cip-dev.lists.cip-project.org>

From: Sai <Sai.Sathujoda@toshiba-tsip.com>

Updated steps to enable secureboot with user-generated & snakeoil keys.

Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
---
 doc/README.secureboot.md | 62 ++++++++++++++++++++++++++--------------
 1 file changed, 41 insertions(+), 21 deletions(-)

diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
index 319b4db..977377a 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -76,7 +76,7 @@ Set up a secure boot test environment with [QEMU](https://www.qemu.org/)
 ### Debian Snakeoil keys
 
 The build copies the  Debian Snakeoil keys to the directory `./build/tmp/deploy/images/<machine>/OVMF.
-You can use them as described in section [Start Image](### Start the image).
+You can use them as described in section [Start Image](#start-the-image).
 
 ### Generate Keys
 
@@ -113,7 +113,7 @@ cp /lib/efitools/x86_64-linux-gnu/KeyTool.efi secureboot-tools
 to the current directory. OVMF_VARS_4M.fd contains no keys can be instrumented for secureboot.
 3. Start QEMU with the script scripts/start-efishell.sh
 ```
-scripts/start-efishell.sh secureboot-tools
+OVMF_CODE=/usr/share/OVMF/OVMF_CODE_4M.secboot.fd OVMF_VARS=./OVMF_VARS_4M.fd ./scripts/start-efishell.sh secureboot-tools
 ```
 4. Start the KeyTool.efi FS0:\KeyTool.efi and execute the the following steps:
 ```
@@ -147,16 +147,28 @@ For user-generated keys, create a new option file in the repository. This option
 header:
   version: 10
   includes:
-   - kas/opt/ebg-secure-boot-base.yml
+   - kas/opt/ebg-swu.yml
+
+local_conf_header:
+  secure-boot-image: |
+    IMAGE_CLASSES += "verity"
+    IMAGE_FSTYPES = "wic"
+    WKS_FILE = "${MACHINE}-efibootguard-secureboot.wks.in"
+    INITRAMFS_INSTALL_append = " initramfs-verity-hook"
+    # abrootfs cannot be installed together with verity
+    INITRAMFS_INSTALL_remove = " initramfs-abrootfs-hook"
 
 local_conf_header:
   secure-boot: |
-    IMAGER_BUILD_DEPS += "ebg-secure-boot-secrets"
-    IMAGER_INSTALL += "ebg-secure-boot-secrets"
+    IMAGER_BUILD_DEPS += "ebg-secure-boot-signer"
+    IMAGER_INSTALL += "ebg-secure-boot-signer"
+
+# Use user-generated keys
+    PREFERRED_PROVIDER_secure-boot-secrets = "secure-boot-key"
+
   user-keys: |
-    SB_CERTDB = "democertdb"
-    SB_VERIFY_CERT = "demo.crt"
-    SB_KEY_NAME = "demo"
+    SB_CERT = "demo.crt"
+    SB_KEY = "demo.key"
 ```
 
 Replace `demo` with the name of the user-generated certificates. The user-generated certificates
@@ -174,7 +186,7 @@ kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:<path to the new option
 
 Start the image with the following command:
 ```
-SECURE_BOOT=y \
+SECURE_BOOT=y DISTRO_RELEASE=bullseye \
 ./start-qemu.sh amd64
 ```
 
@@ -194,27 +206,32 @@ To change the boot behavior, enter `exit` in the shell to enter the bios and cha
 #### User-generated keys
 Start the image with the following command:
 ```
-SECURE_BOOT=y \
+SECURE_BOOT=y DISTRO_RELEASE=bullseye \
 OVMF_CODE=./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_CODE_4M.secboot.fd \
 OVMF_VARS=<path to the modified OVMF_VARS.fd> \
 ./start-qemu.sh amd64
 ```
-
+After boot check the dmesg for secure boot status like below:
+```
+root@demo:~# dmesg | grep Secure
+[    0.008368] Secure boot enabled
+```
 ## Example: Update the image
 
 For updating the image, the following steps are necessary:
-- [Build the image with snakeoil keys](### Build image)
+- [Build the image with snakeoil keys](#build-image)
 - save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-bullseye-qemu-amd64.swu` to /tmp
-- modify the image for example add a new version to the image by adding `PV=2.0.0` to
-  [cip-core-image.bb](recipes-core/images/cip-core-image.bb)
-- start the new target and copy the swu `cip-core-image-cip-core-bullseye-qemu-amd64.swu`
-  to the running system, e.g.:
+- modify the image for example, switch to the RT kernel as modification:
+```
+kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-secure-boot-snakeoil.yml:kas/opt/rt.yml
+```
+- start the new target 
 ```
-SECURE=y ./start-qemu.sh amd64 -virtfs local,path=/tmp,mount_tag=host0,security_model=passthrough,id=host0
+SECURE_BOOT=y DISTRO_RELEASE=bullseye ./start-qemu.sh amd64
 ```
-- mount `host0` on target with:
+Copy the swu cip-core-image-cip-core-bullseye-qemu-amd64.swu to the running system
 ```
-mount -t 9p -o trans=virtio,version=9p2000.L host0 /mnt
+scp -P 22222 /tmp/cip-core-image-cip-core-bullseye-qemu-amd64.swu root@127.0.0.1:/home/
 ```
 - check which partition is booted, e.g. with `lsblk`:
 ```
@@ -228,8 +245,11 @@ sda      8:0    0    2G  0 disk
 └─sda5   8:5    0 1000M  0 part
 ```
 
-- install with `swupdate -i /mnt/cip-core-image-cip-core-bullseye-qemu-amd64.swu`
-- reboot
+- install the swupdate and reboot the image 
+```
+root@demo:~# swupdate -i /home/cip-core-image-cip-core-bullseye-qemu-amd64.swu`
+root@demo:~# reboot
+```
 - check which partition is booted, e.g. with `lsblk`. The rootfs should have changed:
 ```
 root@demo:~# lsblk
-- 
2.20.1



