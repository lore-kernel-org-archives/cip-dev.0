Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75059C43219
	for <webhook@archiver.kernel.org>; Tue, 30 Nov 2021 09:31:01 +0000 (UTC)
Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web10.74460.1638264660191331468
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Nov 2021 01:31:00 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.28, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 1AU9Uwlv015100
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Tue, 30 Nov 2021 10:30:58 +0100
Received: from md2dvrtc.fritz.box ([167.87.34.248])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 1AU9UuEn020034;
	Tue, 30 Nov 2021 10:30:57 +0100
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH 6/9] Create systemd mount units for a
 etc overlay
Date: Tue, 30 Nov 2021 10:30:53 +0100
Message-Id: <20211130093056.324717-7-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211130093056.324717-1-Quirin.Gylstorff@siemens.com>
References: <20211130093056.324717-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Nov 2021 09:31:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7035

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

As /etc is read-only and needs to be accessed by the initrd
move the user defined settings to a overlay in /var/local/etc.

As systemd sets the hostname directly on start reread the /etc/hostname
after mounting the overlay.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../etc-overlay-fs/etc-overlay-fs_0.1.bb      | 32 +++++++++++++++++++
 .../etc-overlay-fs/files/etc-hostname.service | 14 ++++++++
 .../files/etc-sshd-regen-keys.conf            |  7 ++++
 .../etc-overlay-fs/files/etc-sysusers.conf    |  4 +++
 recipes-core/etc-overlay-fs/files/etc.mount   | 13 ++++++++
 recipes-core/etc-overlay-fs/files/postinst    |  4 +++
 .../images/cip-core-image-read-only.bb        |  1 +
 7 files changed, 75 insertions(+)
 create mode 100644 recipes-core/etc-overlay-fs/etc-overlay-fs_0.1.bb
 create mode 100644 recipes-core/etc-overlay-fs/files/etc-hostname.service
 create mode 100644 recipes-core/etc-overlay-fs/files/etc-sshd-regen-keys.conf
 create mode 100644 recipes-core/etc-overlay-fs/files/etc-sysusers.conf
 create mode 100644 recipes-core/etc-overlay-fs/files/etc.mount
 create mode 100755 recipes-core/etc-overlay-fs/files/postinst

diff --git a/recipes-core/etc-overlay-fs/etc-overlay-fs_0.1.bb b/recipes-core/etc-overlay-fs/etc-overlay-fs_0.1.bb
new file mode 100644
index 0000000..4e2b80b
--- /dev/null
+++ b/recipes-core/etc-overlay-fs/etc-overlay-fs_0.1.bb
@@ -0,0 +1,32 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2021
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+inherit dpkg-raw
+
+SRC_URI = "file://postinst \
+           file://etc.mount \
+           file://etc-hostname.service \
+           file://etc-sshd-regen-keys.conf \
+           file://etc-sysusers.conf"
+
+do_install[cleandirs]+="${D}/usr/lib/systemd/system \
+                        ${D}/usr/lib/systemd/system/local-fs.target.wants \
+                        ${D}/usr/lib/systemd/system/systemd-sysusers.service.d \
+                        ${D}/usr/lib/systemd/system/sshd-regen-keys.service.d \
+                        ${D}/var/local/etc \
+                        ${D}/var/local/.atomic \
+                        "
+do_install() {
+    TARGET=${D}/usr/lib/systemd/system
+    install -m 0644 ${WORKDIR}/etc.mount ${TARGET}/etc.mount
+    install -m 0644 ${WORKDIR}/etc-hostname.service ${TARGET}/etc-hostname.service
+    install -m 0644 ${WORKDIR}/etc-sshd-regen-keys.conf ${D}/usr/lib/systemd/system/sshd-regen-keys.service.d/etc-sshd-regen-keys.conf
+    install -m 0644 ${WORKDIR}/etc-sysusers.conf ${D}/usr/lib/systemd/system/systemd-sysusers.service.d/etc-sysusers.service
+}
diff --git a/recipes-core/etc-overlay-fs/files/etc-hostname.service b/recipes-core/etc-overlay-fs/files/etc-hostname.service
new file mode 100644
index 0000000..2306b9f
--- /dev/null
+++ b/recipes-core/etc-overlay-fs/files/etc-hostname.service
@@ -0,0 +1,14 @@
+[Unit]
+Description=set hostname /etc overlay-aware
+Before=network-pre.target
+Wants=network-pre.target
+Requires=etc.mount
+After=etc.mount
+
+[Service]
+Type=oneshot
+RemainAfterExit=yes
+ExecStart=/bin/hostname --boot --file /etc/hostname
+
+[Install]
+WantedBy=basic.target
diff --git a/recipes-core/etc-overlay-fs/files/etc-sshd-regen-keys.conf b/recipes-core/etc-overlay-fs/files/etc-sshd-regen-keys.conf
new file mode 100644
index 0000000..014b5a6
--- /dev/null
+++ b/recipes-core/etc-overlay-fs/files/etc-sshd-regen-keys.conf
@@ -0,0 +1,7 @@
+[Unit]
+# set hostname /etc overlay-aware
+Before=network-pre.target
+Wants=network-pre.target
+Requires=etc.mount
+After=etc.mount
+
diff --git a/recipes-core/etc-overlay-fs/files/etc-sysusers.conf b/recipes-core/etc-overlay-fs/files/etc-sysusers.conf
new file mode 100644
index 0000000..ad45d7f
--- /dev/null
+++ b/recipes-core/etc-overlay-fs/files/etc-sysusers.conf
@@ -0,0 +1,4 @@
+[Unit]
+# make systemd-sysusers /etc overlay aware
+Requires=etc.mount
+After=etc.mount
diff --git a/recipes-core/etc-overlay-fs/files/etc.mount b/recipes-core/etc-overlay-fs/files/etc.mount
new file mode 100644
index 0000000..f0ae3c5
--- /dev/null
+++ b/recipes-core/etc-overlay-fs/files/etc.mount
@@ -0,0 +1,13 @@
+[Unit]
+Description=Overlay-mount /etc
+Requires=var.mount
+After=var.mount
+
+[Mount]
+What=overlay
+Where=/etc
+Type=overlay
+Options=noauto,x-systemd.automount,lowerdir=/etc,upperdir=/var/local/etc,workdir=/var/local/.atomic
+
+[Install]
+WantedBy=local-fs.target
diff --git a/recipes-core/etc-overlay-fs/files/postinst b/recipes-core/etc-overlay-fs/files/postinst
new file mode 100755
index 0000000..e436b53
--- /dev/null
+++ b/recipes-core/etc-overlay-fs/files/postinst
@@ -0,0 +1,4 @@
+#!/bin/sh
+
+deb-systemd-helper enable etc.mount  || true
+deb-systemd-helper enable etc-hostname.service || true
diff --git a/recipes-core/images/cip-core-image-read-only.bb b/recipes-core/images/cip-core-image-read-only.bb
index 7ef2dc2..ceb6ac4 100644
--- a/recipes-core/images/cip-core-image-read-only.bb
+++ b/recipes-core/images/cip-core-image-read-only.bb
@@ -2,6 +2,7 @@ require cip-core-image.bb
 
 SQUASHFS_EXCLUDE_DIRS += "home var"
 
+IMAGE_INSTALL += "etc-overlay-fs"
 IMAGE_INSTALL += "tmp-fs"
 IMAGE_INSTALL_remove += "initramfs-abrootfs-secureboot"
 
-- 
2.30.2


