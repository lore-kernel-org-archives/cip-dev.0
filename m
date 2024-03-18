Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC60CC54E58
	for <webhook@archiver.kernel.org>; Mon, 18 Mar 2024 12:51:54 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.web11.43024.1710766308634564034
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Mar 2024 05:51:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=fJc3am9o;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-51332-2024031812514507654ad645b638a95d-d94_xb@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 2024031812514507654ad645b638a95d
        for <cip-dev@lists.cip-project.org>;
        Mon, 18 Mar 2024 13:51:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=cnTZJynPjd1aOR2K+zXv6JvFKT9d3QmFz/gUcoJOAzM=;
 b=fJc3am9oFxKzpVpgHBP5skU3ez7qC9bHf7AD+SMHxRmXJmX1CysI8AWpO8Hr/fAhcBoGPO
 vRshNW7P6Gkv+1OuA2W3OG5eLZr9E67u1ILc2Q20E9KoOctAWHOdPj/KFbZt3vz0dg5JDP3l
 b9xaOL2/nnaA2av0uhj7cxshUK7/E=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 2/3] conf/distro/cip-core-*: prefer swupdate 2023.12 for all distro except buster
Date: Mon, 18 Mar 2024 13:51:29 +0100
Message-ID: <20240318125144.634700-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240318125144.634700-1-Quirin.Gylstorff@siemens.com>
References: <20240318125144.634700-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Mar 2024 12:51:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15358

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Also remove the preferred version from sid as it now installs the
upstream version of SWUpdate.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/distro/cip-core-bookworm.conf | 2 +-
 conf/distro/cip-core-bullseye.conf | 2 +-
 conf/distro/cip-core-sid.conf      | 1 -
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/conf/distro/cip-core-bookworm.conf b/conf/distro/cip-core-bookworm.conf
index 9bcf559..a827c25 100644
--- a/conf/distro/cip-core-bookworm.conf
+++ b/conf/distro/cip-core-bookworm.conf
@@ -12,6 +12,6 @@
 require conf/distro/debian-bookworm.conf
 require cip-core-common.inc
 
-PREFERRED_VERSION_swupdate ?= "2023.05%"
+PREFERRED_VERSION_swupdate ?= "2023.12%"
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
index aff4572..48f26ff 100644
--- a/conf/distro/cip-core-sid.conf
+++ b/conf/distro/cip-core-sid.conf
@@ -15,6 +15,5 @@ require cip-core-common.inc
 DISTRO_APT_SOURCES = "conf/distro/cip-debian-sid-snapshot.list"
 HOST_DISTRO_APT_SOURCES = "${DISTRO_APT_SOURCES}"
 
-PREFERRED_VERSION_swupdate ?= "2023.05%"
 PREFERRED_VERSION_linux-cip ?= "6.1.%"
 PREFERRED_VERSION_linux-cip-rt ?= "6.1.%"
-- 
2.43.0


