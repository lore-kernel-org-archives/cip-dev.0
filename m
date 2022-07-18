X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from esa2.mentor.iphmx.com (esa2.mentor.iphmx.com [68.232.141.98])
 by mx.groups.io with SMTP id smtpd.web11.26622.1658148822003921086
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Jul 2022 05:53:42 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: mentor.com, ip: 68.232.141.98, mailfrom: srinuvasan_a@mentor.com)
X-IronPort-AV: E=Sophos;i="5.92,281,1650960000"; 
   d="scan'208";a="79895605"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa2.mentor.iphmx.com with ESMTP; 18 Jul 2022 04:53:41 -0800
IronPort-SDR: 5V5M4IwsEGAnig5HOSpIL0OC0S8MTH8yYTxj2rjqhDityEw40OgYMyN4Vu1Hp7MMez4DWCZlNh
 rG3Lo+aN/MhjnQFz2hBP0n5p8hDJ+JxvE9NsH1dW7p7fgFltnNrlB1ys9ZF/jgkSmoTaifJDiD
 yJxh246knsVqRo8lVfjivTfkV0f79axCZW7Gh2tz1MPRcAdj/0bJcZ/lQ2WB55as4z69KV+xW8
 lHmLw8cDkGYU46zPM19wSfzi3/kRvR4OSF8TUR2U7SF0PocZNeZRI5bK2II08Bcr/0NdpIlAEo
 mpU=
From: "Srinuvasan A" <srinuvasan_a@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, Srinuvasan A <srinuvasan_a@mentor.com>
Subject: [cip-dev][isar-cip-core][PATCH] doc: Update the document for bullseye image
Date: Mon, 18 Jul 2022 18:22:35 +0530
Message-ID: <20220718125235.1871420-1-Srinuvasan_A@mentor.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Return-Path: Srinuvasan_A@mentor.com
X-ClientProxiedBy: svr-orw-mbx-10.mgc.mentorg.com (147.34.90.210) To
 svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
List-Id: <cip-dev.lists.cip-project.org>

From: Srinuvasan A <srinuvasan_a@mentor.com>

Now the default distro is bullseye, hence correct the document of
swupdate and secureboot w.r.t bullseye image.

Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
---
 doc/README.secureboot.md |  6 +++---
 doc/README.swupdate.md   | 16 ++++++++--------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
index c1a0301..319b4db 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -204,10 +204,10 @@ OVMF_VARS=<path to the modified OVMF_VARS.fd> \
 
 For updating the image, the following steps are necessary:
 - [Build the image with snakeoil keys](### Build image)
-- save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-buster-qemu-amd64.swu` to /tmp
+- save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-bullseye-qemu-amd64.swu` to /tmp
 - modify the image for example add a new version to the image by adding `PV=2.0.0` to
   [cip-core-image.bb](recipes-core/images/cip-core-image.bb)
-- start the new target and copy the swu `cip-core-image-cip-core-buster-qemu-amd64.swu`
+- start the new target and copy the swu `cip-core-image-cip-core-bullseye-qemu-amd64.swu`
   to the running system, e.g.:
 ```
 SECURE=y ./start-qemu.sh amd64 -virtfs local,path=/tmp,mount_tag=host0,security_model=passthrough,id=host0
@@ -228,7 +228,7 @@ sda      8:0    0    2G  0 disk
 └─sda5   8:5    0 1000M  0 part
 ```
 
-- install with `swupdate -i /mnt/cip-core-image-cip-core-buster-qemu-amd64.swu`
+- install with `swupdate -i /mnt/cip-core-image-cip-core-bullseye-qemu-amd64.swu`
 - reboot
 - check which partition is booted, e.g. with `lsblk`. The rootfs should have changed:
 ```
diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
index e28db24..1b242a2 100644
--- a/doc/README.swupdate.md
+++ b/doc/README.swupdate.md
@@ -15,7 +15,7 @@ Then build the image which will later serve as update package:
 ```
 host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml
 ```
-Save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-buster-qemu-amd64.swu` into a separate folder (ex: /tmp).
+Save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-bullseye-qemu-amd64.swu` into a separate folder (ex: /tmp).
 
 Next, rebuild the image, switching to the RT kernel as modification:
 ```
@@ -27,9 +27,9 @@ Now start the image which will contain the RT kernel:
 host$ SWUPDATE_BOOT=y ./start-qemu.sh amd64
 ```
 
-Copy `cip-core-image-cip-core-buster-qemu-amd64.swu` file from `tmp` folder into the running system:
+Copy `cip-core-image-cip-core-bullseye-qemu-amd64.swu` file from `tmp` folder into the running system:
 ```
-host$ scp -P 22222 /tmp/cip-core-image-cip-core-buster-qemu-amd64.swu root@localhost:
+host$ scp -P 22222 /tmp/cip-core-image-cip-core-bullseye-qemu-amd64.swu root@localhost:
 ```
 
 Check which partition is booted, e.g. with lsblk:
@@ -56,7 +56,7 @@ root@demo:~# cat /sys/kernel/realtime
 
 Now apply swupdate and reboot
 ```
-root@demo:~# swupdate -i cip-core-image-cip-core-buster-qemu-amd64.swu
+root@demo:~# swupdate -i cip-core-image-cip-core-bullseye-qemu-amd64.swu
 root@demo:~# reboot
 ```
 
@@ -123,7 +123,7 @@ Build the image for swupdate with a service which causes kernel panic during sys
 ```
 host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/kernel-panic.yml
 ```
-Save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-buster-qemu-amd64.swu` in a separate folder.
+Save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-bullseye-qemu-amd64.swu` in a separate folder.
 Then build the image without `kernel-panic.yml` recipe using below command:
 ```
 host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml
@@ -134,14 +134,14 @@ Start the target on QEMU:
 host$ SWUPDATE_BOOT=y ./start-qemu.sh amd64
 ```
 
-Copy `cip-core-image-cip-core-buster-qemu-amd64.swu` file from `tmp` folder into the running system:
+Copy `cip-core-image-cip-core-bullseye-qemu-amd64.swu` file from `tmp` folder into the running system:
 ```
-host$ scp -P 22222 /tmp/cip-core-image-cip-core-buster-qemu-amd64.swu root@localhost:
+host$ scp -P 22222 /tmp/cip-core-image-cip-core-bullseye-qemu-amd64.swu root@localhost:
 ```
 
 Apply swupdate as below:
 ```
-root@demo:~# swupdate -i cip-core-image-cip-core-buster-qemu-amd64.swu
+root@demo:~# swupdate -i cip-core-image-cip-core-bullseye-qemu-amd64.swu
 ```
 
 Check bootloader ustate after swupdate. If the swupdate is successful then **revision number** should be **3** and status should be changed to **INSTALLED** for Partition #1.
-- 
2.25.1


