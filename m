Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E98CC25B47
	for <webhook@archiver.kernel.org>; Mon, 23 Oct 2023 15:02:52 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.122855.1698073368915208372
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Oct 2023 08:02:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=gka9jwIw;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-20231023150246b0ac4c61c6aa9b4c96-9e9th9@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20231023150246b0ac4c61c6aa9b4c96
        for <cip-dev@lists.cip-project.org>;
        Mon, 23 Oct 2023 17:02:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=cf6CKS5vv+7Bbob2Up+oY7zdNhEIWYkPB0sj770ounI=;
 b=gka9jwIw5Ifu5A4ZWbVi+ApnBWKsi+OXBUxwA76cF9DHOkjxQ3axLysd2SoPKwPEE5AL8y
 GtmlkRMm+jAlmfk9wROvwPZLSMce9add2qJSnyz0YhFSAPNqZSY6vT21mUp3cbITn3ppCZgM
 6Ha0Krunt7QrZL/zUIlav28nP4gQg=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	venkata.pyla@toshiba-tsip.com,
	dinesh.kumar@toshiba-tsip.com,
	kazuhiro3.hayashi@toshiba.co.jp
Subject: [cip-dev][isar-cip-core][RFC 4/9] security-customizations: Add dependency to customizations
Date: Mon, 23 Oct 2023 17:00:02 +0200
Message-ID: <20231023150243.3990309-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20231023150243.3990309-1-Quirin.Gylstorff@siemens.com>
References: <20231023150243.3990309-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Oct 2023 15:02:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13437

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

To simplify package structure Security customizations no
longer set the hostname and use a dependency instead of a include.

Add the OVERRIDE `security` to enable or disable security related
configuration settings.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas/opt/security.yml                                      | 2 ++
 recipes-core/customizations/customizations.bb             | 2 ++
 recipes-core/security-customizations/files/postinst       | 4 ----
 .../security-customizations/security-customizations.bb    | 8 ++++----
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/kas/opt/security.yml b/kas/opt/security.yml
index d87235a..000c522 100644
--- a/kas/opt/security.yml
+++ b/kas/opt/security.yml
@@ -24,3 +24,5 @@ local_conf_header:
   adjust-swupdate: |
     ABROOTFS_IMAGE_RECIPE = "cip-core-image-security"
     VERITY_IMAGE_RECIPE = "cip-core-image-security"
+  security-override: |
+    OVERRIDES .= ":security"
diff --git a/recipes-core/customizations/customizations.bb b/recipes-core/customizations/customizations.bb
index 3dbeb3f..3f6b5de 100644
--- a/recipes-core/customizations/customizations.bb
+++ b/recipes-core/customizations/customizations.bb
@@ -12,6 +12,8 @@
 require common.inc
 
 SRC_URI += "file://ssh-permit-root.conf"
+SRC_URI:remove:security = "file://ssh-permit-root.conf"
+
 DESCRIPTION = "CIP Core image demo & customizations"
 
 do_prepare_build:prepend:qemu-riscv64() {
diff --git a/recipes-core/security-customizations/files/postinst b/recipes-core/security-customizations/files/postinst
index 620c863..bbd21bd 100755
--- a/recipes-core/security-customizations/files/postinst
+++ b/recipes-core/security-customizations/files/postinst
@@ -8,10 +8,6 @@ set -e
 
 echo "CIP Core Security Image (login: root/CIPsecurity@123)" > /etc/issue
 
-HOSTNAME=demo
-echo "$HOSTNAME" > /etc/hostname
-echo "127.0.0.1 $HOSTNAME" >> /etc/hosts
-
 # CR1.7: Strength of password-based authentication
 # Pam configuration to  enforce password strength
 PAM_PWD_FILE="/etc/pam.d/common-password"
diff --git a/recipes-core/security-customizations/security-customizations.bb b/recipes-core/security-customizations/security-customizations.bb
index 240a577..d5249a2 100644
--- a/recipes-core/security-customizations/security-customizations.bb
+++ b/recipes-core/security-customizations/security-customizations.bb
@@ -9,12 +9,12 @@
 # SPDX-License-Identifier: MIT
 #
 
-require recipes-core/customizations/common.inc
+inherit dpkg-raw
 
 DESCRIPTION = "CIP Security image for IEC62443-4-2 evaluation"
 
-SRC_URI += "file://postinst"
+SRC_URI = "file://postinst"
 
-DEPENDS += "sshd-regen-keys"
-DEBIAN_DEPENDS += ", sshd-regen-keys, libpam-google-authenticator"
+DEPENDS = "customizations, sshd-regen-keys"
+DEBIAN_DEPENDS = "customizations , sshd-regen-keys, libpam-google-authenticator"
 
-- 
2.42.0


