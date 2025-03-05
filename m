Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BF5C282D9
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 10:28:12 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.10350.1741170491160672886
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Mar 2025 02:28:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=A2ZwzTdK;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-202503051028088e1dac173ad9a4d294-msxxqm@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202503051028088e1dac173ad9a4d294
        for <cip-dev@lists.cip-project.org>;
        Wed, 05 Mar 2025 11:28:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=nHYAPP3CyTaZk6BaGjFPkDA8bXbweSDg3U+tTje8F6Y=;
 b=A2ZwzTdKcywAX5/O7zKkNtKVhb+kyH3Bb3tBzfhqXrhWlnIIANc58tmAhMeMWtmT9tlt1j
 Aa2XTfTVT93bQ+G/gPWlwczYxpumws51NmOJH4hFBo9A7CnGqeW3mWYGtnPkLJXVrNAbHUNN
 vpbiNWS2J9gxxshy0FsClmcGDRU/EkQxABs5rl2VjBsG9pNixwNseztdnak9J8NtrVYOHeuu
 dilIYQ21UHz9ObZrrU7KsSUFYRD7CwtyDIffnNnsM2CPCMvs2/7Ci8piiU7wT5CwXOCF8TET
 VhZHHas54kWkjlqeZS+3hUv5YRymjPObWWR1CRaQ2vm9zFhejoyQuDFg==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v3 1/6] read-only-rootfs: Make IMMUTABLE_DATA_DIR configurable
Date: Wed,  5 Mar 2025 11:27:40 +0100
Message-ID: <20250305102807.2614514-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250305102807.2614514-1-Quirin.Gylstorff@siemens.com>
References: <20250305102807.2614514-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Mar 2025 10:28:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18034

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows the user to set the variable IMMUTABLE_DATA_DIR.

This allows to set directory as requested by issue #124.

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/124
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/read-only-rootfs.bbclass                            | 4 +++-
 .../immutable-rootfs/files/immutable-rootfs.tmpfiles        | 2 --
 .../immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl   | 2 ++
 .../{immutable-rootfs_0.1.bb => immutable-rootfs_0.2.bb}    | 6 +++++-
 4 files changed, 10 insertions(+), 4 deletions(-)
 delete mode 100644 recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles
 create mode 100644 recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl
 rename recipes-core/immutable-rootfs/{immutable-rootfs_0.1.bb => immutable-rootfs_0.2.bb} (73%)

diff --git a/classes/read-only-rootfs.bbclass b/classes/read-only-rootfs.bbclass
index 35a3ab3..0db398f 100644
--- a/classes/read-only-rootfs.bbclass
+++ b/classes/read-only-rootfs.bbclass
@@ -28,8 +28,10 @@ IMAGE_INSTALL:remove:bullseye = " immutable-rootfs"
 ROOTFS_POSTPROCESS_COMMAND:append =" copy_dpkg_state"
 ROOTFS_POSTPROCESS_COMMAND:remove:buster =" copy_dpkg_state"
 ROOTFS_POSTPROCESS_COMMAND:remove:bullseye =" copy_dpkg_state"
+
+IMMUTABLE_DATA_DIR ??= "/usr/share/immutable-data"
 copy_dpkg_state() {
-    IMMUTABLE_VAR_LIB="${ROOTFSDIR}/usr/share/immutable-data/var/lib"
+    IMMUTABLE_VAR_LIB="${ROOTFSDIR}${IMMUTABLE_DATA_DIR}/var/lib"
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
index 0000000..001dbb1
--- /dev/null
+++ b/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl
@@ -0,0 +1,2 @@
+L /var/lib/dpkg - - - - ${IMMUTABLE_DATA_DIR}/var/lib/dpkg
+d /var/log/audit 0700 root adm -
diff --git a/recipes-core/immutable-rootfs/immutable-rootfs_0.1.bb b/recipes-core/immutable-rootfs/immutable-rootfs_0.2.bb
similarity index 73%
rename from recipes-core/immutable-rootfs/immutable-rootfs_0.1.bb
rename to recipes-core/immutable-rootfs/immutable-rootfs_0.2.bb
index 2dbda6d..c847f44 100644
--- a/recipes-core/immutable-rootfs/immutable-rootfs_0.1.bb
+++ b/recipes-core/immutable-rootfs/immutable-rootfs_0.2.bb
@@ -15,9 +15,13 @@ inherit dpkg-raw
 MAINTAINER = "Felix Moessbauer <felix.moessbauer@siemens.com>"
 DESCRIPTION = "Config to link volatile data to immutable copies"
 
-SRC_URI = "file://${BPN}.tmpfiles"
+SRC_URI = "file://${BPN}.tmpfiles.tmpl"
 DPKG_ARCH = "all"
 
+IMMUTABLE_DATA_DIR ??= "/usr/share/immutable-data"
+TEMPLATE_VARS = "IMMUTABLE_DATA_DIR"
+TEMPLATE_FILES += "${BPN}.tmpfiles.tmpl"
+
 do_prepare_build:append() {
     cp ${WORKDIR}/${BPN}.tmpfiles ${S}/debian/
 }
-- 
2.47.0


