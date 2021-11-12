Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C24BC433F5
	for <webhook@archiver.kernel.org>; Fri, 12 Nov 2021 11:50:25 +0000 (UTC)
Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web09.14721.1636717823604269922
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Nov 2021 03:50:24 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 194.138.37.39, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 1ACBoJeS028340
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 12 Nov 2021 12:50:19 +0100
Received: from md2dvrtc.fritz.box ([167.87.35.150])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1ACBoHAm023845;
	Fri, 12 Nov 2021 12:50:19 +0100
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][RFC 6/8] Create systemd mount units for a
 etc overlay
Date: Fri, 12 Nov 2021 12:50:15 +0100
Message-Id: <20211112115017.401779-8-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211112115017.401779-1-Quirin.Gylstorff@siemens.com>
References: <20211112115017.401779-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Nov 2021 11:50:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6887

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

As /etc is read-only and needs to be accessed by the initrd
move the user defined settings to a overlay in /var/local/etc.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../etc-overlay-fs/etc-overlay-fs_0.1.bb         | 16 ++++++++++++++++
 .../etc-overlay-fs/files/etc-hostname.service    | 14 ++++++++++++++
 .../etc-overlay-fs/files/etc-sysusers.service    | 14 ++++++++++++++
 recipes-core/etc-overlay-fs/files/etc.mount      | 13 +++++++++++++
 .../files/overlay-parse-etc.service              | 12 ++++++++++++
 recipes-core/etc-overlay-fs/files/postinst       |  6 ++++++
 recipes-core/images/cip-core-image-read-only.bb  |  1 +
 7 files changed, 76 insertions(+)
 create mode 100644 recipes-core/etc-overlay-fs/etc-overlay-fs_0.1.bb
 create mode 100644 recipes-core/etc-overlay-fs/files/etc-hostname.service
 create mode 100644 recipes-core/etc-overlay-fs/files/etc-sysusers.service
 create mode 100644 recipes-core/etc-overlay-fs/files/etc.mount
 create mode 100644 recipes-core/etc-overlay-fs/files/overlay-parse-etc.service
 create mode 100755 recipes-core/etc-overlay-fs/files/postinst

diff --git a/recipes-core/etc-overlay-fs/etc-overlay-fs_0.1.bb b/recipes-core/etc-overlay-fs/etc-overlay-fs_0.1.bb
new file mode 100644
index 0000000..f1c8349
--- /dev/null
+++ b/recipes-core/etc-overlay-fs/etc-overlay-fs_0.1.bb
@@ -0,0 +1,16 @@
+inherit dpkg-raw
+
+SRC_URI = "file://postinst \
+           file://etc.mount \
+           file://overlay-parse-etc.service \
+           file://etc-hostname.service \
+           file://etc-sysusers.service"
+
+do_install[cleandirs]+="${D}/lib/systemd/system ${D}/var/local/etc ${D}/var/local/.atomic"
+do_install() {
+    TARGET=${D}/lib/systemd/system
+    install -m 0644 ${WORKDIR}/etc.mount ${TARGET}/etc.mount
+    install -m 0644 ${WORKDIR}/overlay-parse-etc.service  ${TARGET}/overlay-parse-etc.service
+    install -m 0644 ${WORKDIR}/etc-hostname.service ${TARGET}/etc-hostname.service
+    install -m 0644 ${WORKDIR}/etc-sysusers.service ${TARGET}/etc-sysusers.service
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
diff --git a/recipes-core/etc-overlay-fs/files/etc-sysusers.service b/recipes-core/etc-overlay-fs/files/etc-sysusers.service
new file mode 100644
index 0000000..6caf6b0
--- /dev/null
+++ b/recipes-core/etc-overlay-fs/files/etc-sysusers.service
@@ -0,0 +1,14 @@
+[Unit]
+Description=make systemd-sysusers /etc overlay aware
+Before=network-pre.target
+Wants=network-pre.target
+Requires=etc.mount
+After=etc.mount
+
+[Service]
+Type=oneshot
+RemainAfterExit=yes
+ExecStart=/usr/bin/systemd-sysusers
+
+[Install]
+WantedBy=basic.target
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
diff --git a/recipes-core/etc-overlay-fs/files/overlay-parse-etc.service b/recipes-core/etc-overlay-fs/files/overlay-parse-etc.service
new file mode 100644
index 0000000..062bb40
--- /dev/null
+++ b/recipes-core/etc-overlay-fs/files/overlay-parse-etc.service
@@ -0,0 +1,12 @@
+[Unit]
+Description=Reload Configuration from the etc overlay
+Requires=etc.mount
+After=etc.mount
+
+[Service]
+Type=oneshot
+RemainAfterExit=yes
+ExecStartPre=!/bin/systemctl daemon-reload
+ExecStart=!/bin/systemctl --no-block isolate multi-user.target
+[Install]
+WantedBy=local-fs.target
diff --git a/recipes-core/etc-overlay-fs/files/postinst b/recipes-core/etc-overlay-fs/files/postinst
new file mode 100755
index 0000000..35641af
--- /dev/null
+++ b/recipes-core/etc-overlay-fs/files/postinst
@@ -0,0 +1,6 @@
+#!/bin/sh
+
+deb-systemd-helper enable etc.mount  || true
+deb-systemd-helper enable overlay-parse-etc.service || true
+deb-systemd-helper enable etc-hostname.service || true
+deb-systemd-helper enable etc-sysusers.service || true
diff --git a/recipes-core/images/cip-core-image-read-only.bb b/recipes-core/images/cip-core-image-read-only.bb
index 24ace3c..6e2a40a 100644
--- a/recipes-core/images/cip-core-image-read-only.bb
+++ b/recipes-core/images/cip-core-image-read-only.bb
@@ -6,6 +6,7 @@ do_wic_image[depends] += "${INITRAMFS_RECIPE}:do_build"
 
 SQUASHFS_EXCLUDE_DIRS += "home var"
 
+IMAGE_INSTALL += "etc-overlay-fs"
 IMAGE_INSTALL += "tmp-fs"
 IMAGE_INSTALL_remove += "initramfs-abrootfs-secureboot"
 
-- 
2.30.2


