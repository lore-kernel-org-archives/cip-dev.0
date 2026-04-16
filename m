Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151CCF8A175
	for <webhook@archiver.kernel.org>; Thu, 16 Apr 2026 13:24:24 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13985.1776345854155632544
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Apr 2026 06:24:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=dY8IMAR4;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-202604161324104509e9ebc000020797-tb9mbb@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202604161324104509e9ebc000020797
        for <cip-dev@lists.cip-project.org>;
        Thu, 16 Apr 2026 15:24:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=SySJP4jQDtzm3RNudxl2leVHKlWGfjWY153sfhqLPlQ=;
 b=dY8IMAR4kgv9vNMSdd4+j4MeYF9ONzIG3mzWioqqgGb2CLCCpdD6CE1qPU25FGFBhiH/7b
 /gT4c5wSlfuGpwOtXPEAM2gvHin57tV6/peJCE93yFq+GUjq4+mNdlDdjk1zR9cYp/tQBMcW
 QzqEE3bI3V69ZxHxB70Ywh3p+oGOuar4Qb9TO4P0qnBH59Z3eJTJXduhoQmzEzX+woxR2I9N
 sgDQXLuYsjXjVgwRRGcLRAXbi4t1JUr36OXxAebW2X8NemTE/R9WWrwpyqm2uXXuZKUtLdLf
 9vQlUAl4yd2UqS5+IRpX2vltOafKRZzX7XYFQ4GFcMI0TM/oRneib5gQ==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v3] swupdate: Remove Debian build profile cross
Date: Thu, 16 Apr 2026 15:22:59 +0200
Message-ID: <20260416132349.1560392-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Apr 2026 13:24:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22740

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

Changes v3:
 - correct comment

Changes v2:
 - drop setting cross seperate from ISAR_CROSS_COMPILE and change
    subject was swupdate: Set Debian build profile cross only if ISAR_CROSS_COMPILE is active

 recipes-core/swupdate/swupdate.inc        | 4 ++--
 recipes-core/swupdate/swupdate_2023.12.bb | 3 ---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/recipes-core/swupdate/swupdate.inc b/recipes-core/swupdate/swupdate.inc
index 497b1c2..4038e7e 100644
--- a/recipes-core/swupdate/swupdate.inc
+++ b/recipes-core/swupdate/swupdate.inc
@@ -37,8 +37,8 @@ DEPENDS += "${@bb.utils.contains('DEB_BUILD_PROFILES', 'mtd', 'mtd-utils', '', d
 SWU_SIGNED ?= "1"
 DEB_BUILD_PROFILES += "${@'pkg.swupdate.nosigning' if not bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
 
-# add cross build and deactivate testing for arm based builds
-DEB_BUILD_PROFILES += "cross nocheck"
+# deactivate testing
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


