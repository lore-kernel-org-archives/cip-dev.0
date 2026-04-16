Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410ECF8A154
	for <webhook@archiver.kernel.org>; Thu, 16 Apr 2026 09:54:02 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10023.1776333232492923411
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Apr 2026 02:53:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=MaKpNMpX;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-202604160953497768047feb00020703-k55_bz@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202604160953497768047feb00020703
        for <cip-dev@lists.cip-project.org>;
        Thu, 16 Apr 2026 11:53:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=EN38XXF2istEIpcmyZ+nLEsGkH7fMcHfk76CToguqMI=;
 b=MaKpNMpXuR5KezhoR+fAiCdbHSJzGqSUeNwaEf6Das6CbPP8ERKaBlKnKkUDhOU7GayB3K
 4jocllwzq3xk6Vr4SCQVaDKjIE9jHdSaG1ziHAwFh+HVtGIagH8amjl0a8HTt7Whmn0p8d3x
 j7cfb0q+QyLW7BcK1e0CH8GZSrWso37a9cOOzxGbvKK2+P2gvZN/VRgF2HQJts9KEx/dOa7h
 Hb2KeDeANjIdxKyuRKcFBgCxS7gbFoLbOZcuBXO/AdWbEww6BsbQQIx22L6OrQPhD7YloVqg
 P/j91yB4SZfylytk1NW+fe24a9Tqiez/9RB0LNYyVkws99kSp/XEgv1Q==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH] swupdate: Set Debian build profile cross only if ISAR_CROSS_COMPILE is active
Date: Thu, 16 Apr 2026 11:51:21 +0200
Message-ID: <20260416095328.964484-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Apr 2026 09:54:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22736

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This avoids the following error with building bookworm or older in
trixie:

E: The package cache was built for different architectures: amd64 vs
W: You may want to run apt-get update to correct these problems
E: The package cache file is corrupted
E: apt-get update failed
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-core/swupdate/swupdate.inc        | 4 +++-
 recipes-core/swupdate/swupdate_2023.12.bb | 3 ---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/recipes-core/swupdate/swupdate.inc b/recipes-core/swupdate/swupdate.inc
index 497b1c2..59db631 100644
--- a/recipes-core/swupdate/swupdate.inc
+++ b/recipes-core/swupdate/swupdate.inc
@@ -37,8 +37,10 @@ DEPENDS += "${@bb.utils.contains('DEB_BUILD_PROFILES', 'mtd', 'mtd-utils', '', d
 SWU_SIGNED ?= "1"
 DEB_BUILD_PROFILES += "${@'pkg.swupdate.nosigning' if not bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
 
+DEB_BUILD_PROFILES += "${@'cross' if bb.utils.to_boolean(d.getVar('ISAR_CROSS_COMPIILE')) else ''}"
+
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


