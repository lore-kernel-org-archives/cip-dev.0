Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76368C433EF
	for <webhook@archiver.kernel.org>; Tue, 16 Nov 2021 11:27:58 +0000 (UTC)
Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web09.8653.1637062077187918323
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Nov 2021 03:27:57 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 194.138.37.39, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 1AGBRtPR022515
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Tue, 16 Nov 2021 12:27:55 +0100
Received: from md2dvrtc.fritz.box ([167.87.1.223])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1AGBRqNW006209;
	Tue, 16 Nov 2021 12:27:55 +0100
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: raphael.lisicki@siemens.com, jan.kiszka@siemens.com,
        cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core]RFC v2 7/9] Mount writable home partition
Date: Tue, 16 Nov 2021 12:27:50 +0100
Message-Id: <20211116112752.1521211-8-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211116112752.1521211-1-Quirin.Gylstorff@siemens.com>
References: <20211116112752.1521211-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Nov 2021 11:27:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6934

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Add an example how to add an writable home partition

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-core/home-fs/files/home.mount           | 11 +++++++++++
 recipes-core/home-fs/files/postinst             |  3 +++
 recipes-core/home-fs/home-fs_0.1.bb             | 10 ++++++++++
 recipes-core/images/cip-core-image-read-only.bb |  1 +
 wic/qemu-amd64-efibootguard-secureboot.wks.in   |  2 ++
 5 files changed, 27 insertions(+)
 create mode 100644 recipes-core/home-fs/files/home.mount
 create mode 100755 recipes-core/home-fs/files/postinst
 create mode 100644 recipes-core/home-fs/home-fs_0.1.bb

diff --git a/recipes-core/home-fs/files/home.mount b/recipes-core/home-fs/files/home.mount
new file mode 100644
index 0000000..31272a0
--- /dev/null
+++ b/recipes-core/home-fs/files/home.mount
@@ -0,0 +1,11 @@
+[Unit]
+Description=Mount /home partition
+
+[Mount]
+What=/dev/disk/by-partlabel/home
+Where=/home
+Type=auto
+Options=defaults
+
+[Install]
+WantedBy=local-fs.target
\ No newline at end of file
diff --git a/recipes-core/home-fs/files/postinst b/recipes-core/home-fs/files/postinst
new file mode 100755
index 0000000..f6184d6
--- /dev/null
+++ b/recipes-core/home-fs/files/postinst
@@ -0,0 +1,3 @@
+#!/bin/sh
+
+deb-systemd-helper enable home.mount  || true
diff --git a/recipes-core/home-fs/home-fs_0.1.bb b/recipes-core/home-fs/home-fs_0.1.bb
new file mode 100644
index 0000000..c2b31c1
--- /dev/null
+++ b/recipes-core/home-fs/home-fs_0.1.bb
@@ -0,0 +1,10 @@
+inherit dpkg-raw
+
+SRC_URI = "file://postinst \
+           file://home.mount"
+
+do_install[cleandirs]+="${D}/lib/systemd/system"
+do_install() {
+    install -m 0644 ${WORKDIR}/home.mount ${D}/lib/systemd/system/home.mount
+
+}
\ No newline at end of file
diff --git a/recipes-core/images/cip-core-image-read-only.bb b/recipes-core/images/cip-core-image-read-only.bb
index ceb6ac4..79cd6bf 100644
--- a/recipes-core/images/cip-core-image-read-only.bb
+++ b/recipes-core/images/cip-core-image-read-only.bb
@@ -3,6 +3,7 @@ require cip-core-image.bb
 SQUASHFS_EXCLUDE_DIRS += "home var"
 
 IMAGE_INSTALL += "etc-overlay-fs"
+IMAGE_INSTALL += "home-fs"
 IMAGE_INSTALL += "tmp-fs"
 IMAGE_INSTALL_remove += "initramfs-abrootfs-secureboot"
 
diff --git a/wic/qemu-amd64-efibootguard-secureboot.wks.in b/wic/qemu-amd64-efibootguard-secureboot.wks.in
index c4ea0c8..81fd4fe 100644
--- a/wic/qemu-amd64-efibootguard-secureboot.wks.in
+++ b/wic/qemu-amd64-efibootguard-secureboot.wks.in
@@ -8,6 +8,8 @@ part --source efibootguard-boot --ondisk sda --size 32M --extra-space 0 --overhe
 part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}.verity.img" --ondisk sda --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
 part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}.verity.img" --ondisk sda --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
 
+# home and var are extra partitions
+part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --ondisk sda --fstype=ext4 --label home --align 1024  --size 1G
 part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --ondisk sda --fstype=ext4 --label var --align 1024  --size 2G
 
 bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait rw earlyprintk"
-- 
2.30.2


