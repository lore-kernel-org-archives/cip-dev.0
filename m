Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57321C3F6B0
	for <webhook@archiver.kernel.org>; Fri, 12 Aug 2022 09:51:25 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.8812.1660297876304775214
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Aug 2022 02:51:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2
 header.b=Zp/o9khc;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228,
 mailfrom: fm-51332-20220812095113cc4d125f1a72370af8-dhu96m@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 20220812095113cc4d125f1a72370af8
        for <cip-dev@lists.cip-project.org>;
        Fri, 12 Aug 2022 11:51:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=5cbb1r00jgIEkcNlN6fcDY8t08oC6fqngs/nGkMjYjQ=;
 b=Zp/o9khcOTNyfP0TS+woiZr5pNSeFrrSl0tyMMOu6iIAdEnkCHtzaSDB8KwPx9SbKzvlGc
 SZ8f3fJkvL/VbNPVodDzUyMmR03H3xlFVojDkn1nXmLp6dtqdga9eiYkuphVN1+42azKfjct
 z9bQQ0tZJF3UyRTORAjBFnz1m1QGw=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v5 1/3] initramfs-*-hook: Add
 DEBIAN_CONFLICTS
Date: Fri, 12 Aug 2022 11:51:10 +0200
Message-Id: <20220812095112.632930-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20220812095112.632930-1-Quirin.Gylstorff@siemens.com>
References: <20220812095112.632930-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Aug 2022 09:51:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9168

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

If both initramfs-abrootfs-hook and initramfs-verity-hook
are installed the system will enter a reboot loop.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.1.bb       | 1 +
 .../initramfs-verity-hook/initramfs-verity-hook_0.1.bb           | 1 +
 2 files changed, 2 insertions(+)

diff --git a/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.1.bb b/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.1.bb
index 1693e85..8b1536f 100644
--- a/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.1.bb
+++ b/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.1.bb
@@ -13,6 +13,7 @@
 inherit dpkg-raw
 
 DEBIAN_DEPENDS = "initramfs-tools"
+DEBIAN_CONFLICTS = "initramfs-verity-hook"
 
 SRC_URI += "file://abrootfs.hook \
             file://abrootfs.script"
diff --git a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
index 60ee8da..5998908 100644
--- a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
+++ b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
@@ -23,6 +23,7 @@ TEMPLATE_FILES = "verity.script.tmpl"
 TEMPLATE_VARS += "VERITY_BEHAVIOR_ON_CORRUPTION"
 
 DEBIAN_DEPENDS = "initramfs-tools, cryptsetup"
+DEBIAN_CONFLICTS = "initramfs-abrootfs-hook"
 
 VERITY_IMAGE_RECIPE ?= "cip-core-image"
 
-- 
2.35.1


