Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6205.1792499392741852017
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Oct 2026 05:29:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm2 header.b=BhM83Qxi;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-1330684-202610201229503c3848eb0f00020745-maq9mk@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202610201229503c3848eb0f00020745
        for <cip-dev@lists.cip-project.org>;
        Tue, 20 Oct 2026 14:29:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=8r7qeXgao0OJ120rSMZxy/hz3NtfsEOmbOxQGeMDwwk=;
 b=BhM83Qxi3tUZRkKqDFXpLgwV0SCYaSFZfQEepITZD3Y+2d9aZ0qIxjygh0CmwI4+K0rFQ4
 o0c1ZPhva1KtpGG6Cizde5ysI/msWvlBclYMvYQ16pI9mZyZ1AVNIS/R3Qi5Zr3CXD3BTRz1
 mfsjKT9r31jWkFkkRkTTVHNW3l5Uf2wDcVWyTMw8lx3X5kftpEJqZbeAaHKlu2wBLIgydAuY
 UDNvt0V8EZlppQsadBsxbYScAn9jWbzapU4fW7l0Fn/Z+b7obUU6Ph9XZKQgxkoH5XTNI+s2
 3PQI1FTIgw48LvWKy6sM9gI0FYARL/oK5L+f+w+e+fy/wOjtepNQxp+Q==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH 1/2] swupdate: Split signing and verification configuration
Date: Tue, 20 Oct 2026 14:29:31 +0200
Message-ID: <20261020122932.470811-2-alexander.heinisch@siemens.com>
In-Reply-To: <20261020122932.470811-1-alexander.heinisch@siemens.com>
References: <20261020122932.470811-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 20 Oct 2026 12:29:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24499
Content-Type: text/plain; charset="utf-8"

From: Alexander Heinisch <alexander.heinisch@siemens.com>

This allows downstreams to sign artifacts out of tree (excluding
signing done by swu-IMAGER) while still enforcing signature
verification at runtime.

Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
---
 classes-recipe/swupdate.bbclass    |  3 ++-
 recipes-core/images/swupdate.inc   | 12 +++++++-----
 recipes-core/swupdate/swupdate.inc |  3 ++-
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/classes-recipe/swupdate.bbclass b/classes-recipe/swupdate.bbclass
index b5b5273b..4011739d 100644
--- a/classes-recipe/swupdate.bbclass
+++ b/classes-recipe/swupdate.bbclass
@@ -42,6 +42,7 @@ SWU_ADDITIONAL_FILES ?= "${SWU_KERNEL_ARTIFACT_NAME} ${SWU_ROOTFS_ARTIFACT_NAME}
 
 # Including swupdate.inc in CIP_IMAGE_OPTIONS enables signing by default.
 SWU_SIGNED ??= ""
+SWU_SIGN_UPDATE ??= "${SWU_SIGNED}"
 SWU_SIGNATURE_EXT ?= "sig"
 SWU_SIGNATURE_TYPE ?= "cms"
 
@@ -231,7 +232,7 @@ IMAGE_CMD:swu() {
         done
 
         # Prepare for signing
-        export sign='${@'x' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}'
+        export sign='${@'x' if bb.utils.to_boolean(d.getVar('SWU_SIGN_UPDATE')) else ''}'
         export swu_file_base
         # create a exetension to differ between swus
         swu_file_extension=""
diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index 006d6220..699c9619 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -33,10 +33,12 @@ SWU_COMPRESSION_TYPE = ""
 RO_ROOTFS_EXCLUDE_DIRS = "boot var home"
 
 SWU_SIGNED ?= "1"
+SWU_SIGN_UPDATE ??= "${SWU_SIGNED}"
+SWU_VERIFY_UPDATE ??= "${SWU_SIGNED}"
 SWU_HW_COMPAT ?= "cip-core-1.0"
-IMAGER_BUILD_DEPS:swu += "${@'swupdate-signer' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
-IMAGER_INSTALL:swu += "${@'swupdate-signer' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
-IMAGE_INSTALL += "${@'swupdate-certificates' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
+IMAGER_BUILD_DEPS:swu += "${@'swupdate-signer' if bb.utils.to_boolean(d.getVar('SWU_SIGN_UPDATE')) else ''}"
+IMAGER_INSTALL:swu += "${@'swupdate-signer' if bb.utils.to_boolean(d.getVar('SWU_SIGN_UPDATE')) else ''}"
+IMAGE_INSTALL += "${@'swupdate-certificates' if bb.utils.to_boolean(d.getVar('SWU_VERIFY_UPDATE')) else ''}"
 
 SWUPDATE_SELFBUILT ?= "0"
 SWUPDATE_SELFBUILT:buster = "1"
@@ -50,8 +52,8 @@ python() {
         bb.fatal(f'Self-built SWUpdate not supported for {base_distro}')
 
     if not bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) and \
-       not bb.utils.to_boolean(d.getVar('SWU_SIGNED')):
-        bb.fatal('SWUpdate from Debian requires signed SWUs')
+       not bb.utils.to_boolean(d.getVar('SWU_VERIFY_UPDATE')):
+        bb.fatal('SWUpdate from Debian requires signature verification for SWUs')
 }
 
 IMAGE_INSTALL:append = "${@' swupdate' if bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) else ''}"
diff --git a/recipes-core/swupdate/swupdate.inc b/recipes-core/swupdate/swupdate.inc
index 4038e7e3..e11f0d58 100644
--- a/recipes-core/swupdate/swupdate.inc
+++ b/recipes-core/swupdate/swupdate.inc
@@ -35,7 +35,8 @@ DEPENDS += "${@get_bootloader_dependencies(d)}"
 DEPENDS += "${@bb.utils.contains('DEB_BUILD_PROFILES', 'mtd', 'mtd-utils', '', d)}"
 
 SWU_SIGNED ?= "1"
-DEB_BUILD_PROFILES += "${@'pkg.swupdate.nosigning' if not bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
+SWU_VERIFY_UPDATE ??= "${SWU_SIGNED}"
+DEB_BUILD_PROFILES += "${@'pkg.swupdate.nosigning' if not bb.utils.to_boolean(d.getVar('SWU_VERIFY_UPDATE')) else ''}"
 
 # deactivate testing
 DEB_BUILD_PROFILES += "nocheck"
-- 
2.47.3

