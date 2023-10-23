Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5838C001E0
	for <webhook@archiver.kernel.org>; Mon, 23 Oct 2023 15:02:51 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.123302.1698073368080723669
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Oct 2023 08:02:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=XBGQ+wqa;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-2023102315024675d07f75a33157049a-8nxajt@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2023102315024675d07f75a33157049a
        for <cip-dev@lists.cip-project.org>;
        Mon, 23 Oct 2023 17:02:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=+J4uuX7uOtQ+LbSvZ3IDo8ENFfKDx5ouS56iYtvAg20=;
 b=XBGQ+wqaEXoZV1dQYn4e3tat7YdceE3BfZqqEl2F0NYThPvt4Obip+TLXFXHNuyMg9K1bG
 XUCQr/p+6X8WgaVFhg90sgwHJXi3mG7150IphyxomLy110a1QMOOKzcrIyLqauRo92NMV6WN
 XbqE2h5NUOq6h2KmpWMJM3rRdTpm8=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	venkata.pyla@toshiba-tsip.com,
	dinesh.kumar@toshiba-tsip.com,
	kazuhiro3.hayashi@toshiba.co.jp
Subject: [cip-dev][isar-cip-core][RFC 2/9] customizations: Add variable to set the HOSTNAME
Date: Mon, 23 Oct 2023 17:00:00 +0200
Message-ID: <20231023150243.3990309-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20231023150243.3990309-1-Quirin.Gylstorff@siemens.com>
References: <20231023150243.3990309-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Oct 2023 15:02:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13433

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Add the variable CUSTOM_HOSTNAME to modify the hostname of
the image.

The default value of CUSTOM_HOSTNAME is "demo".

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-core/customizations/common.inc                      | 6 +++++-
 .../customizations/files/{postinst => postinst.tmpl}        | 4 ++--
 2 files changed, 7 insertions(+), 3 deletions(-)
 rename recipes-core/customizations/files/{postinst => postinst.tmpl} (85%)

diff --git a/recipes-core/customizations/common.inc b/recipes-core/customizations/common.inc
index 680a4d6..79bf80d 100644
--- a/recipes-core/customizations/common.inc
+++ b/recipes-core/customizations/common.inc
@@ -14,16 +14,20 @@ inherit dpkg-raw
 FILESPATH:append := ":${FILE_DIRNAME}/files"
 
 SRC_URI = " \
-    file://postinst \
+    file://postinst.tmpl \
     file://ethernet \
     file://99-silent-printk.conf \
     file://99-watchdog.conf"
 
 SRC_URI:append:swupdate = " file://swupdate.cfg"
 
+CUSTOM_HOSTNAME ??= "demo"
 WIRELESS_FIRMWARE_PACKAGE ?= ""
 INSTALL_WIRELESS_TOOLS ??= "0"
 
+TEMPLATE_FILES += "postinst.tmpl"
+TEMPLATE_VARS += "CUSTOM_HOSTNAME"
+
 DEPENDS += "sshd-regen-keys change-root-homedir"
 
 DEBIAN_DEPENDS = " \
diff --git a/recipes-core/customizations/files/postinst b/recipes-core/customizations/files/postinst.tmpl
similarity index 85%
rename from recipes-core/customizations/files/postinst
rename to recipes-core/customizations/files/postinst.tmpl
index 7e7ea36..2668a93 100644
--- a/recipes-core/customizations/files/postinst
+++ b/recipes-core/customizations/files/postinst.tmpl
@@ -2,7 +2,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019-2023
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -18,6 +18,6 @@ if ! grep -e "^PermitRootLogin.*yes" -q /etc/ssh/sshd_config; then
 	echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
 fi
 
-HOSTNAME=demo
+HOSTNAME="${CUSTOM_HOSTNAME}"
 echo "$HOSTNAME" > /etc/hostname
 echo "127.0.0.1 $HOSTNAME" >> /etc/hosts
-- 
2.42.0


