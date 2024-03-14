Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A0EC54E69
	for <webhook@archiver.kernel.org>; Thu, 14 Mar 2024 12:37:46 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.11500.1710419860729631759
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Mar 2024 05:37:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=PTIuk08r;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-20240314123738f8c89b185972774767-_wrosm@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240314123738f8c89b185972774767
        for <cip-dev@lists.cip-project.org>;
        Thu, 14 Mar 2024 13:37:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=X+CL/CcdkCeotT6I+sF42pxCga4uBu5EZesM0lY6i1Y=;
 b=PTIuk08r4jyL4n0cl+kAaKrOfdnUEAujCoRwydwSqtK8kIBIAvBY3hqX4qPKVIYhSS4sBA
 9HGpXHK9SQ4IFgH/eiIOkXtc+3J0Wq4tlDVKMzyal1STEX+MMhKFxjZRbUHwBSLsqyMS+q73
 Z6qVBPx6Catlqw/SNpHDPAFn+ULSk=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH 2/3] conf/distro/cip-core-*: prefer swupdate 2023.12 for all distro except buster
Date: Thu, 14 Mar 2024 13:36:37 +0100
Message-ID: <20240314123736.1100948-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240314123736.1100948-1-Quirin.Gylstorff@siemens.com>
References: <20240314123736.1100948-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Mar 2024 12:37:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15304

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/distro/cip-core-bookworm.conf | 3 ++-
 conf/distro/cip-core-bullseye.conf | 2 +-
 conf/distro/cip-core-sid.conf      | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/conf/distro/cip-core-bookworm.conf b/conf/distro/cip-core-bookworm.conf
index 9bcf559..634a666 100644
--- a/conf/distro/cip-core-bookworm.conf
+++ b/conf/distro/cip-core-bookworm.conf
@@ -12,6 +12,7 @@
 require conf/distro/debian-bookworm.conf
 require cip-core-common.inc
 
-PREFERRED_VERSION_swupdate ?= "2023.05%"
+PREFERRED_VERSION_swupdate ?= "2023.12%"
+PREFERRED_VERSION_libubootenv-dev ?= "0.3.5%"
 PREFERRED_VERSION_linux-cip ?= "6.1.%"
 PREFERRED_VERSION_linux-cip-rt ?= "6.1.%"
diff --git a/conf/distro/cip-core-bullseye.conf b/conf/distro/cip-core-bullseye.conf
index 4f26299..110f334 100644
--- a/conf/distro/cip-core-bullseye.conf
+++ b/conf/distro/cip-core-bullseye.conf
@@ -15,6 +15,6 @@ require cip-core-common.inc
 DISTRO_APT_SOURCES:append:swupdate = " conf/distro/debian-bullseye-backports.list"
 DISTRO_APT_PREFERENCES:append:swupdate = " conf/distro/preferences.swupdate-bullseye-backports.conf"
 
-PREFERRED_VERSION_swupdate ?= "2023.05%"
+PREFERRED_VERSION_swupdate ?= "2023.12%"
 PREFERRED_VERSION_linux-cip ?= "5.10.%"
 PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
diff --git a/conf/distro/cip-core-sid.conf b/conf/distro/cip-core-sid.conf
index aff4572..692c105 100644
--- a/conf/distro/cip-core-sid.conf
+++ b/conf/distro/cip-core-sid.conf
@@ -15,6 +15,6 @@ require cip-core-common.inc
 DISTRO_APT_SOURCES = "conf/distro/cip-debian-sid-snapshot.list"
 HOST_DISTRO_APT_SOURCES = "${DISTRO_APT_SOURCES}"
 
-PREFERRED_VERSION_swupdate ?= "2023.05%"
+PREFERRED_VERSION_swupdate ?= "2023.12%"
 PREFERRED_VERSION_linux-cip ?= "6.1.%"
 PREFERRED_VERSION_linux-cip-rt ?= "6.1.%"
-- 
2.43.0


