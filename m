X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web10.3621.1665385361262635829
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Oct 2022 00:02:41 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.155, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 29A72diq015771; Mon, 10 Oct 2022 16:02:39 +0900
X-Iguazu-Qid: 34ts01SW9QcoxfKccb
X-Iguazu-QSIG: v=2; s=0; t=1665385359; q=34ts01SW9QcoxfKccb; m=PjrQ++2wg9wpyL9kphvAX6QDHzA6Z0C59iUk/CCTAeM=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1513) id 29A72c5V000464
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 10 Oct 2022 16:02:39 +0900
From: sai.sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 2/3] README.secureboot.md : Update steps for user-generated keys
Date: Mon, 10 Oct 2022 12:32:31 +0530
X-TSB-HOP2: ON
Message-Id: <20221010070232.10478-3-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221010070232.10478-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20221010070232.10478-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
X-OriginalArrivalTime: 10 Oct 2022 07:02:34.0669 (UTC) FILETIME=[460935D0:01D8DC76]
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
List-Id: <cip-dev.lists.cip-project.org>

From: Sai <Sai.Sathujoda@toshiba-tsip.com>

Modified readme for the following changes
- Updated sample kas file for recent modifications in base yaml files.
- Corrected syntaxes of the reference links to sub sections
- changed steps for copying the swu file inside qemu image

Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
---
 doc/README.secureboot.md | 55 +++++++++++++++++++++++++++-------------
 1 file changed, 38 insertions(+), 17 deletions(-)

diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
index 319b4db..6b90497 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -76,7 +76,7 @@ Set up a secure boot test environment with [QEMU](https://www.qemu.org/)
 ### Debian Snakeoil keys
 
 The build copies the  Debian Snakeoil keys to the directory `./build/tmp/deploy/images/<machine>/OVMF.
-You can use them as described in section [Start Image](### Start the image).
+You can use them as described in section [Start Image](#start-the-image).
 
 ### Generate Keys
 
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
@@ -200,21 +212,27 @@ OVMF_VARS=<path to the modified OVMF_VARS.fd> \
 ./start-qemu.sh amd64
 ```
 
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
+SECURE_BOOT=y ./start-qemu.sh amd64
 ```
-- mount `host0` on target with:
+Copy the swu cip-core-image-cip-core-bullseye-qemu-amd64.swu to the running system
 ```
-mount -t 9p -o trans=virtio,version=9p2000.L host0 /mnt
+scp -P 22222 /tmp/cip-core-image-cip-core-bullseye-qemu-amd64.swu root@127.0.0.1:/home/
 ```
 - check which partition is booted, e.g. with `lsblk`:
 ```
@@ -228,8 +246,11 @@ sda      8:0    0    2G  0 disk
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



