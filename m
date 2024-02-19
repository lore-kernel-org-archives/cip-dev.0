Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED72C54764
	for <webhook@archiver.kernel.org>; Mon, 19 Feb 2024 14:08:41 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.39711.1708344549982376280
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Feb 2024 04:09:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=GXUKaz3n;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-1321639-20240219120907445f1667442800db35-k_sxxu@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20240219120907445f1667442800db35
        for <cip-dev@lists.cip-project.org>;
        Mon, 19 Feb 2024 13:09:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=H+i4n0TeIt+7S+Bu5vSqINUaSZrlLX0VyeaVtjIg2pk=;
 b=GXUKaz3nf5YoY6heuQpEH7gl8MlN98kjyQ7o5A7s4dB3RLP/0fT4CmYhToouPOB2RPqSKZ
 DD72Bic98GJXJHPASN16yl/vyzznrtncoIUXqGGWlcisFALYo+xr1TQ3gTinzoALaJdfI1wG
 MuvPIK8iSaIg/3eMT0t7AUsOUkS3c=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	shivanand.kunijadar@toshiba-tsip.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][RFC v3 2/2] copy and symlink dpkg db to ro-rootfs
Date: Mon, 19 Feb 2024 13:08:58 +0100
Message-Id: <20240219120858.59136-3-felix.moessbauer@siemens.com>
In-Reply-To: <20240219120858.59136-1-felix.moessbauer@siemens.com>
References: <20240219120858.59136-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Feb 2024 14:08:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15035

The dpkg database is located on the var partition, but this partition is
not updated (and might not even be deployed). To still have information
about what is installed, we relocate the database to /usr/share and
create a symlink using tmpdirs.d.

Note, that this is only enabled on debian bookworm, as the proper
packaging of tmpdirs files is only supported from debhelper-compat 13
on.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 classes/read-only-rootfs.bbclass              | 10 ++++++++
 .../files/immutable-rootfs.tmpfiles           |  1 +
 .../immutable-rootfs/immutable-rootfs_0.1.bb  | 23 +++++++++++++++++++
 3 files changed, 34 insertions(+)
 create mode 100644 recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles
 create mode 100644 recipes-core/immutable-rootfs/immutable-rootfs_0.1.bb

diff --git a/classes/read-only-rootfs.bbclass b/classes/read-only-rootfs.bbclass
index 6f91f66..bb8ab9a 100644
--- a/classes/read-only-rootfs.bbclass
+++ b/classes/read-only-rootfs.bbclass
@@ -17,6 +17,16 @@ do_image_wic[depends] += "${INITRAMFS_RECIPE}:do_build"
 IMAGE_INSTALL += "home-fs"
 IMAGE_INSTALL += "tmp-fs"
 
+# For pre bookworm images, empty /var is not usable
+IMAGE_INSTALL:append:bookworm = " immutable-rootfs"
+
+ROOTFS_POSTPROCESS_COMMAND:append:bookworm =" copy_dpkg_state"
+copy_dpkg_state() {
+    IMMUTABLE_VAR_LIB="${ROOTFSDIR}/usr/share/immutable-data/var/lib"
+    sudo mkdir -p "$IMMUTABLE_VAR_LIB"
+    sudo cp -a ${ROOTFSDIR}/var/lib/dpkg "$IMMUTABLE_VAR_LIB/"
+}
+
 image_configure_fstab() {
     sudo tee '${IMAGE_ROOTFS}/etc/fstab' << EOF
 # Begin /etc/fstab
diff --git a/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles b/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles
new file mode 100644
index 0000000..d180bc5
--- /dev/null
+++ b/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles
@@ -0,0 +1 @@
+L /var/lib/dpkg - - - - /usr/share/immutable-data/var/lib/dpkg
diff --git a/recipes-core/immutable-rootfs/immutable-rootfs_0.1.bb b/recipes-core/immutable-rootfs/immutable-rootfs_0.1.bb
new file mode 100644
index 0000000..2dbda6d
--- /dev/null
+++ b/recipes-core/immutable-rootfs/immutable-rootfs_0.1.bb
@@ -0,0 +1,23 @@
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
+inherit dpkg-raw
+
+MAINTAINER = "Felix Moessbauer <felix.moessbauer@siemens.com>"
+DESCRIPTION = "Config to link volatile data to immutable copies"
+
+SRC_URI = "file://${BPN}.tmpfiles"
+DPKG_ARCH = "all"
+
+do_prepare_build:append() {
+    cp ${WORKDIR}/${BPN}.tmpfiles ${S}/debian/
+}
-- 
2.39.2


