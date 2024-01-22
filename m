Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD88C47DAF
	for <webhook@archiver.kernel.org>; Mon, 22 Jan 2024 12:38:00 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.72484.1705927075769109558
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Jan 2024 04:37:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=oruFymkZ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-2024012212375291fddb9ac294b6530f-x6benq@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2024012212375291fddb9ac294b6530f
        for <cip-dev@lists.cip-project.org>;
        Mon, 22 Jan 2024 13:37:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=W3EiuH+CezxsPEUFsV4096n204g1WVxszUXC5Ah8Bng=;
 b=oruFymkZnBAMgnmT8t4tcUBb4m/l0g2TzaukdjkPvMX+DJsahNWaIyzQccJs733ViLmVZ8
 qtuZYbDvtzxMowwyiQ/H82Aj56wTWYI8xeMDrC2ZuoR6RiVivoxrpYuEyOQ+bvsLdS0cioG4
 xgrn2dRzWEGZ3De/mjGubH1KlYsAU=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][RFC 2/4] swupdate: set SWU_HW_COMPAT
Date: Mon, 22 Jan 2024 13:37:13 +0100
Message-ID: <20240122123751.83696-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240122123751.83696-1-Quirin.Gylstorff@siemens.com>
References: <20240122123751.83696-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Jan 2024 12:38:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14438

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

With this item SWUpdate from Debian can be used in place of a
build from isar-cip-core.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-core/images/swupdate.inc                    | 2 +-
 recipes-core/swupdate-config/files/hwrevision.tmpl  | 2 +-
 recipes-core/swupdate-config/swupdate-config_0.1.bb | 2 +-
 recipes-core/swupdate/swupdate.inc                  | 3 ---
 4 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index 4983f7c..183503b 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -13,7 +13,7 @@ inherit image_uuid
 inherit read-only-rootfs
 
 SWU_SIGNED ?= "1"
-
+SWU_HW_COMPAT ?= "cip-core-1.0"
 IMAGE_INSTALL += " swupdate"
 
 IMAGE_INSTALL += " swupdate-handler-roundrobin"
diff --git a/recipes-core/swupdate-config/files/hwrevision.tmpl b/recipes-core/swupdate-config/files/hwrevision.tmpl
index ec1d667..1eb0996 100644
--- a/recipes-core/swupdate-config/files/hwrevision.tmpl
+++ b/recipes-core/swupdate-config/files/hwrevision.tmpl
@@ -1 +1 @@
-cip-${MACHINE} ${IMAGE_HW_VERSION}
+cip-${MACHINE} ${MACHINE_HW_VERSION}
diff --git a/recipes-core/swupdate-config/swupdate-config_0.1.bb b/recipes-core/swupdate-config/swupdate-config_0.1.bb
index 6991321..260c0f1 100644
--- a/recipes-core/swupdate-config/swupdate-config_0.1.bb
+++ b/recipes-core/swupdate-config/swupdate-config_0.1.bb
@@ -14,7 +14,7 @@ inherit dpkg-raw
 SRC_URI = "file://swupdate.cfg \
            file://hwrevision.tmpl"
 
-MACHINE_HW_VERSION ??= ""
+MACHINE_HW_VERSION ??= "cip-core-1.0"
 TEMPLATE_FILES += "hwrevision.tmpl"
 TEMPLATE_VARS += "MACHINE MACHINE_HW_VERSION"
 
diff --git a/recipes-core/swupdate/swupdate.inc b/recipes-core/swupdate/swupdate.inc
index cb1716b..818b431 100644
--- a/recipes-core/swupdate/swupdate.inc
+++ b/recipes-core/swupdate/swupdate.inc
@@ -34,9 +34,6 @@ DEPENDS += "${@bb.utils.contains('DEB_BUILD_PROFILES', 'mtd', 'mtd-utils', '', d
 
 DEB_BUILD_PROFILES += "${@'pkg.swupdate.nosigning' if not d.getVar('SWU_SIGNED') == '1' else ''}"
 
-# deactivate hardware compability for simple a/b rootfs update
-DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"
-
 # add cross build and deactivate testing for arm based builds
 DEB_BUILD_PROFILES += "cross nocheck"
 
-- 
2.43.0


