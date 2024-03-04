Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BAFC5478C
	for <webhook@archiver.kernel.org>; Mon,  4 Mar 2024 10:54:58 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.95412.1709549696424434463
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Mar 2024 02:54:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=EHeJTW0J;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-20240304105454b16bcf1ffc77c3fb47-5hfi1j@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240304105454b16bcf1ffc77c3fb47
        for <cip-dev@lists.cip-project.org>;
        Mon, 04 Mar 2024 11:54:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=dwqZSf1/iQ47rZon716QcH+DQ9Ek4qw7leiKNjOfNXE=;
 b=EHeJTW0JbY4VfXnKiU9eI1BmesIcfJr4qI5qRIK7idGfxqG4zBhdLbFcczHlq0QHn+SqeL
 eCbzS0GTqUdt6lFcPv77GlvYp8cKaryNEnoxSoAa3cbBFMWqlV3f7WHG7AylNehGgaXyRudK
 SNzlY+jdgF1xUbYFPlXoz4kJ53qPM=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v4 2/4] swupdate: set SWU_HW_COMPAT
Date: Mon,  4 Mar 2024 11:54:50 +0100
Message-ID: <20240304105453.984881-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240304105453.984881-1-Quirin.Gylstorff@siemens.com>
References: <20240304105453.984881-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Mar 2024 10:54:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15190

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

With this item SWUpdate from Debian can be used in place of a
build from isar-cip-core.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-core/images/swupdate.inc                    | 2 +-
 recipes-core/swupdate-config/swupdate-config_0.1.bb | 2 +-
 recipes-core/swupdate/swupdate.inc                  | 3 ---
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index 213b97f..1d237f7 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -13,7 +13,7 @@ inherit image_uuid
 inherit read-only-rootfs
 
 SWU_SIGNED ?= "1"
-
+SWU_HW_COMPAT ?= "cip-core-1.0"
 IMAGE_INSTALL += " swupdate"
 
 IMAGE_INSTALL:remove:sid = "swupdate"
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
index 7a4214f..c92b14a 100644
--- a/recipes-core/swupdate/swupdate.inc
+++ b/recipes-core/swupdate/swupdate.inc
@@ -34,9 +34,6 @@ DEPENDS += "${@bb.utils.contains('DEB_BUILD_PROFILES', 'mtd', 'mtd-utils', '', d
 
 DEB_BUILD_PROFILES += "${@'pkg.swupdate.nosigning' if not bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
 
-# deactivate hardware compability for simple a/b rootfs update
-DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"
-
 # add cross build and deactivate testing for arm based builds
 DEB_BUILD_PROFILES += "cross nocheck"
 
-- 
2.43.0


