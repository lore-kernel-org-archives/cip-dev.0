Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8E0C46CD2
	for <webhook@archiver.kernel.org>; Tue, 30 Jan 2024 13:15:36 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.16381.1706615835970746692
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jan 2024 03:57:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=RQUbU+fu;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-1321639-20240130115712dc58b9870d3c9619ab-ffzqkd@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240130115712dc58b9870d3c9619ab
        for <cip-dev@lists.cip-project.org>;
        Tue, 30 Jan 2024 12:57:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=8caep5UdD3VelXITjoYujXnByGEKFiX6P4bv0pZhQdU=;
 b=RQUbU+fuaKEOdTWUhCUqRex1lkku6E19DNj6oY8wDKKYApTVqo2sxgUpoHCkPMhvhqa8OU
 /FQkwhZ6l0MqhFmSzHlGj4KtfRJhKc59dlBKHXV/2CZM2vU9MjWagUpx3v4itlShGPDAnxSU
 NbOUY3ZFNVRkHPgjJxS7VzR1BUrlI=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	shivanand.kunijadar@toshiba-tsip.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][RFC 1/2] copy and symlink dpkg db to ro-rootfs
Date: Tue, 30 Jan 2024 12:56:47 +0100
Message-Id: <20240130115648.311177-2-felix.moessbauer@siemens.com>
In-Reply-To: <20240130115648.311177-1-felix.moessbauer@siemens.com>
References: <20240130115648.311177-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jan 2024 13:15:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14496

The dpkg database is located on the var partition, but this partition is
not updated (and might not even be deployed). To still have information
about what is installed, we relocate the database to /usr/share and
create a symlink using tmpdirs.d.

Note, that this is only enabled on debian bookworm, as the proper
packaging of tmpdirs files is only supported from debhelper-compat 13
on.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 classes/read-only-rootfs.bbclass              | 10 +++++++
 .../cip-read-only-rootfs_0.1.bb               | 26 +++++++++++++++++++
 .../files/cip-read-only-rootfs.tmpfiles       |  1 +
 .../cip-read-only-rootfs/files/control        | 11 ++++++++
 4 files changed, 48 insertions(+)
 create mode 100644 recipes-core/cip-read-only-rootfs/cip-read-only-rootfs_0.1.bb
 create mode 100644 recipes-core/cip-read-only-rootfs/files/cip-read-only-rootfs.tmpfiles
 create mode 100644 recipes-core/cip-read-only-rootfs/files/control

diff --git a/classes/read-only-rootfs.bbclass b/classes/read-only-rootfs.bbclass
index 6f91f66..14ed85d 100644
--- a/classes/read-only-rootfs.bbclass
+++ b/classes/read-only-rootfs.bbclass
@@ -17,6 +17,16 @@ do_image_wic[depends] += "${INITRAMFS_RECIPE}:do_build"
 IMAGE_INSTALL += "home-fs"
 IMAGE_INSTALL += "tmp-fs"
 
+# For pre bookworm images, empty /var is not usable
+IMAGE_INSTALL:append:bookworm = " cip-read-only-rootfs"
+
+ROOTFS_POSTPROCESS_COMMAND:append:bookworm =" cip_copy_dpkg_state"
+cip_copy_dpkg_state() {
+    IMMUTABLE_VAR_LIB="${ROOTFSDIR}/usr/share/cip/var/lib"
+    sudo mkdir -p "$IMMUTABLE_VAR_LIB"
+    sudo cp -a ${ROOTFSDIR}/var/lib/dpkg "$IMMUTABLE_VAR_LIB/"
+}
+
 image_configure_fstab() {
     sudo tee '${IMAGE_ROOTFS}/etc/fstab' << EOF
 # Begin /etc/fstab
diff --git a/recipes-core/cip-read-only-rootfs/cip-read-only-rootfs_0.1.bb b/recipes-core/cip-read-only-rootfs/cip-read-only-rootfs_0.1.bb
new file mode 100644
index 0000000..76453ab
--- /dev/null
+++ b/recipes-core/cip-read-only-rootfs/cip-read-only-rootfs_0.1.bb
@@ -0,0 +1,26 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2024
+#
+# Authors:
+#  Felix Moessbauer <felix.moessbauer@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+# Note: This requires debhelper-compat 13, which limits it to bookworm
+
+inherit dpkg
+
+SRC_URI = " \
+    file://${BPN}.tmpfiles \
+    file://control"
+
+do_prepare_build[cleandirs] += "${S}/debian"
+do_prepare_build() {
+    deb_debianize
+    rm -f ${S}/debian/compat
+    cp ${WORKDIR}/control \
+       ${WORKDIR}/${BPN}.tmpfiles \
+       ${S}/debian/
+}
diff --git a/recipes-core/cip-read-only-rootfs/files/cip-read-only-rootfs.tmpfiles b/recipes-core/cip-read-only-rootfs/files/cip-read-only-rootfs.tmpfiles
new file mode 100644
index 0000000..16a91bd
--- /dev/null
+++ b/recipes-core/cip-read-only-rootfs/files/cip-read-only-rootfs.tmpfiles
@@ -0,0 +1 @@
+L /var/lib/dpkg - - - - /usr/share/cip/var/lib/dpkg
diff --git a/recipes-core/cip-read-only-rootfs/files/control b/recipes-core/cip-read-only-rootfs/files/control
new file mode 100644
index 0000000..55eec25
--- /dev/null
+++ b/recipes-core/cip-read-only-rootfs/files/control
@@ -0,0 +1,11 @@
+Source: cip-read-only-rootfs
+Section: misc
+Priority: optional
+Standards-Version: 4.6.1
+Maintainer: Felix Moessbauer <felix.moessbauer@siemens.com>
+Build-Depends: debhelper-compat (= 13)
+
+Package: cip-read-only-rootfs
+Architecture: all
+Depends: ${misc:Depends}
+Description: Config to link volatile data to immutable copies
-- 
2.39.2


