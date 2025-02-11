Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5FCC021A5
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 08:51:38 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.7694.1739263889280019617
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Feb 2025 00:51:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=WziA7x5U;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-20250211085126944fc07bc75e763d48-v_mfq0@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20250211085126944fc07bc75e763d48
        for <cip-dev@lists.cip-project.org>;
        Tue, 11 Feb 2025 09:51:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=6HleNXBOZXfF4SbVFskMc1up+/2RPByndKE13VuqYdc=;
 b=WziA7x5Ug+kHjgQCNBa8dbfjscZqRnWsj0KL4UjHBC7Ecw0eV4xveuAMxepeR4fmECpQr+
 j9i4clcnDJO4K8xRbhd4QqFmTksrFvKcrKwy+oGv0SNkRsrvCj2mq5xWCm4DUp3EAD9dioSs
 1H/fbYoCOoi6+KqD5qM9EpSalSA8zhSz5vRYHhH+mUy/idbU/iza6C3g+ubXq+AaHVV1OHIH
 3cdd5q2pbB7qVp9hjuMPzSDG6l03YXkEr3Ze8HYpAFHt8kpC3GdQmbmhsYzUvs8hDO0xLzUp
 LG/3ah55WCQiyuucfn10jX5H5Gnh9E7VhdVqoNebd5k7EeQZRMuITj2Q==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	ludwig.nussel@siemens.com
Subject: [cip-dev][isar-cip-core][RFC 1/4] read-only-rootfs: Make IMMUTABLE_DATA_DIR configurable
Date: Tue, 11 Feb 2025 09:49:08 +0100
Message-ID: <20250211085125.22154-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250211085125.22154-1-Quirin.Gylstorff@siemens.com>
References: <20250211085125.22154-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Feb 2025 08:51:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17808

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows the user to set the variable IMMUTABLE_DATA_DIR.

This allows to set directory as requested by issue #124.

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/124
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/read-only-rootfs.bbclass                            | 4 +++-
 .../immutable-rootfs/files/immutable-rootfs.tmpfiles        | 2 --
 .../immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl   | 2 ++
 recipes-core/immutable-rootfs/immutable-rootfs_0.1.bb       | 6 +++++-
 4 files changed, 10 insertions(+), 4 deletions(-)
 delete mode 100644 recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles
 create mode 100644 recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl

diff --git a/classes/read-only-rootfs.bbclass b/classes/read-only-rootfs.bbclass
index 35a3ab3..acc04e0 100644
--- a/classes/read-only-rootfs.bbclass
+++ b/classes/read-only-rootfs.bbclass
@@ -28,8 +28,10 @@ IMAGE_INSTALL:remove:bullseye = " immutable-rootfs"
 ROOTFS_POSTPROCESS_COMMAND:append =" copy_dpkg_state"
 ROOTFS_POSTPROCESS_COMMAND:remove:buster =" copy_dpkg_state"
 ROOTFS_POSTPROCESS_COMMAND:remove:bullseye =" copy_dpkg_state"
+
+IMMUTABLE_DATA_DIR ??= "usr/share/immutable-data"
 copy_dpkg_state() {
-    IMMUTABLE_VAR_LIB="${ROOTFSDIR}/usr/share/immutable-data/var/lib"
+    IMMUTABLE_VAR_LIB="${ROOTFSDIR}/${IMMUTABLE_DATA_DIR}/var/lib"
     sudo mkdir -p "$IMMUTABLE_VAR_LIB"
     sudo cp -a ${ROOTFSDIR}/var/lib/dpkg "$IMMUTABLE_VAR_LIB/"
 }
diff --git a/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles b/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles
deleted file mode 100644
index 2f7c338..0000000
--- a/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles
+++ /dev/null
@@ -1,2 +0,0 @@
-L /var/lib/dpkg - - - - /usr/share/immutable-data/var/lib/dpkg
-d /var/log/audit 0700 root adm -
diff --git a/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl b/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl
new file mode 100644
index 0000000..de8a238
--- /dev/null
+++ b/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl
@@ -0,0 +1,2 @@
+L /var/lib/dpkg - - - - /${IMMUTABLE_DATA_DIR}/var/lib/dpkg
+d /var/log/audit 0700 root adm -
diff --git a/recipes-core/immutable-rootfs/immutable-rootfs_0.1.bb b/recipes-core/immutable-rootfs/immutable-rootfs_0.1.bb
index 2dbda6d..c61005c 100644
--- a/recipes-core/immutable-rootfs/immutable-rootfs_0.1.bb
+++ b/recipes-core/immutable-rootfs/immutable-rootfs_0.1.bb
@@ -15,9 +15,13 @@ inherit dpkg-raw
 MAINTAINER = "Felix Moessbauer <felix.moessbauer@siemens.com>"
 DESCRIPTION = "Config to link volatile data to immutable copies"
 
-SRC_URI = "file://${BPN}.tmpfiles"
+SRC_URI = "file://${BPN}.tmpfiles.tmpl"
 DPKG_ARCH = "all"
 
+IMMUTABLE_DATA_DIR ??= "usr/share/immutable-data"
+TEMPLATE_VARS = "IMMUTABLE_DATA_DIR"
+TEMPLATE_FILES += "${BPN}.tmpfiles.tmpl"
+
 do_prepare_build:append() {
     cp ${WORKDIR}/${BPN}.tmpfiles ${S}/debian/
 }
-- 
2.47.0


