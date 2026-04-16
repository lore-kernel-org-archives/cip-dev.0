Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F1FF8A173
	for <webhook@archiver.kernel.org>; Thu, 16 Apr 2026 12:59:24 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13358.1776344361616038022
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Apr 2026 05:59:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=JtX28RTj;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-51332-20260416125918c089eb903f0002077c-_zsb65@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20260416125918c089eb903f0002077c
        for <cip-dev@lists.cip-project.org>;
        Thu, 16 Apr 2026 14:59:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=icbP9rebTTY37rgmeslZDpmy/gxeDfpK4qNESPEE74Q=;
 b=JtX28RTjP6hlb6BkwvhhBvNXZT3jkPKIMTVnyVGbEWwXvypsyam8J3hL6CpLb42nbI5mNs
 EAQWNzDyaoqTxHtVMN4rvXyxv6zf8PJG8VPKvximpuOrjfOlemo9zNkFx9/cdfeHDtZuh70/
 XZ2lq44A0rq/UMmXrhA0aoyHDMAetyNFfjJ93yuBcPezn2PcWdRTr8DfdJiipXxEmNWK8mKD
 kI244XyWJSTfoibIOGbJvu/OwYc0CiM+iS6fFmUDW8p/iZZs583zr9Yct9ueNS6A5KAvyjfk
 lkiTDbsxEtkt5y70B1s9GPN/Wt3tOUZaLFNXP1EQ5ftthI2mvodXsOOw==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2] swupdate: Remove Debian build profile cross
Date: Thu, 16 Apr 2026 14:58:47 +0200
Message-ID: <20260416125857.1544426-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Apr 2026 12:59:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22739

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The cross profile is automatic set by ISAR_CROSS_COMPILE.

This avoids the following error with building bookworm or older in
trixie:

E: The package cache was built for different architectures: amd64 vs
W: You may want to run apt-get update to correct these problems
E: The package cache file is corrupted
E: apt-get update failed
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---

Changes v2:
 - drop setting cross seperate from ISAR_CROSS_COMPILE and change
    subject was swupdate: Set Debian build profile cross only if ISAR_CROSS_COMPILE is active

 recipes-core/swupdate/swupdate.inc        | 2 +-
 recipes-core/swupdate/swupdate_2023.12.bb | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/recipes-core/swupdate/swupdate.inc b/recipes-core/swupdate/swupdate.inc
index 497b1c2..14da35b 100644
--- a/recipes-core/swupdate/swupdate.inc
+++ b/recipes-core/swupdate/swupdate.inc
@@ -38,7 +38,7 @@ SWU_SIGNED ?= "1"
 DEB_BUILD_PROFILES += "${@'pkg.swupdate.nosigning' if not bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
 
 # add cross build and deactivate testing for arm based builds
-DEB_BUILD_PROFILES += "cross nocheck"
+DEB_BUILD_PROFILES += "nocheck"
 
 python do_check_bootloader () {
     bootloader = d.getVar("SWUPDATE_BOOTLOADER") or "None"
diff --git a/recipes-core/swupdate/swupdate_2023.12.bb b/recipes-core/swupdate/swupdate_2023.12.bb
index 6822153..89785b6 100644
--- a/recipes-core/swupdate/swupdate_2023.12.bb
+++ b/recipes-core/swupdate/swupdate_2023.12.bb
@@ -39,9 +39,6 @@ DEB_BUILD_PROFILES += "pkg.swupdate.suricattawfx"
 # with cross compile we have a unsat-dependency to dh-nodejs on arm/arm64
 ISAR_CROSS_COMPILE:bullseye = "0"
 
-# add cross build and deactivate testing for arm based builds
-DEB_BUILD_PROFILES += "cross nocheck"
-
 # use backport build profile for bullseye
 DEB_BUILD_PROFILES += "pkg.swupdate.bpo"
 
-- 
2.53.0


