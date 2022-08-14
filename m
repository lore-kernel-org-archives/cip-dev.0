Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30DCC3F6B0
	for <webhook@archiver.kernel.org>; Sun, 14 Aug 2022 12:47:44 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web12.4608.1660481259293484752
 for <cip-dev@lists.cip-project.org>;
 Sun, 14 Aug 2022 05:47:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=ikQWYzZS;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228,
 mailfrom: fm-294854-20220814124737a2ee13511a5b9401b1-upp_xm@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 20220814124737a2ee13511a5b9401b1
        for <cip-dev@lists.cip-project.org>;
        Sun, 14 Aug 2022 14:47:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Y9YY5L4BIwQWcPatkuOFo5DCIfiLLBMm/aJiSkMWZP8=;
 b=ikQWYzZSAfGy6RcpRDATggftmL1U0L/g2Ji1ofIqgkhs9+JjMsLancjIvhdL/LdPAe9MPz
 RZ0X5/mWgqPdJCI7cwi06eiUGWgw2LDz6P9tYRN+sqUKAkw/RfWJNZpStyoh95azuwXIP0wb
 VX7/H0d0jJndgVsxz0Ixey0kT+lIs=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Shivanand.Kunijadar@toshiba-tsip.com
Subject: [isar-cip-core][PATCH 2/4] linux-cip: Update to latest 4.4/4.19/5.10
 releases
Date: Sun, 14 Aug 2022 15:47:31 +0300
Message-Id: 
 <dc9c981b6d495530c80befa3e6d75f830f3f1a00.1660481252.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1660481252.git.jan.kiszka@siemens.com>
References: <cover.1660481252.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 14 Aug 2022 12:47:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9206

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...19.245-cip74-rt25.bb => linux-cip-rt_4.19.252-cip78-rt26.bb} | 2 +-
 ...4.4.302-cip69-rt39.bb => linux-cip-rt_4.4.302-cip70-rt40.bb} | 2 +-
 ..._5.10.109-cip5-rt4.bb => linux-cip-rt_5.10.131-cip13-rt5.bb} | 2 +-
 ...{linux-cip_4.19.249-cip76.bb => linux-cip_4.19.252-cip78.bb} | 2 +-
 .../{linux-cip_4.4.302-cip69.bb => linux-cip_4.4.302-cip70.bb}  | 2 +-
 ...{linux-cip_5.10.126-cip11.bb => linux-cip_5.10.131-cip13.bb} | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.19.245-cip74-rt25.bb => linux-cip-rt_4.19.252-cip78-rt26.bb} (72%)
 rename recipes-kernel/linux/{linux-cip-rt_4.4.302-cip69-rt39.bb => linux-cip-rt_4.4.302-cip70-rt40.bb} (72%)
 rename recipes-kernel/linux/{linux-cip-rt_5.10.109-cip5-rt4.bb => linux-cip-rt_5.10.131-cip13-rt5.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_4.19.249-cip76.bb => linux-cip_4.19.252-cip78.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip69.bb => linux-cip_4.4.302-cip70.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_5.10.126-cip11.bb => linux-cip_5.10.131-cip13.bb} (72%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.245-cip74-rt25.bb b/recipes-kernel/linux/linux-cip-rt_4.19.252-cip78-rt26.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip-rt_4.19.245-cip74-rt25.bb
rename to recipes-kernel/linux/linux-cip-rt_4.19.252-cip78-rt26.bb
index 0fbf34a..f27be73 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.19.245-cip74-rt25.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.19.252-cip78-rt26.bb
@@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
 
-SRC_URI[sha256sum] = "a14a5230356d334a2f06bdd2fed731956d3f6492e085c75dbebc7c4f7b5da1d8"
+SRC_URI[sha256sum] = "770db530cb68f0eb022757fde73774b7312d420fcfc3d86d906f37208bdbce2d"
diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip69-rt39.bb b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip70-rt40.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip-rt_4.4.302-cip69-rt39.bb
rename to recipes-kernel/linux/linux-cip-rt_4.4.302-cip70-rt40.bb
index ddce99a..9310dda 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip69-rt39.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip70-rt40.bb
@@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
 
-SRC_URI[sha256sum] = "5cbddbd7780739f7af91545691ffaa07a436dab4a0e8380a5e2b9b31e883071f"
+SRC_URI[sha256sum] = "186949d20d7ca0856d666665d66782805c39d6811a6baab1b88af1690c6c73e1"
diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.109-cip5-rt4.bb b/recipes-kernel/linux/linux-cip-rt_5.10.131-cip13-rt5.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip-rt_5.10.109-cip5-rt4.bb
rename to recipes-kernel/linux/linux-cip-rt_5.10.131-cip13-rt5.bb
index 3105f43..8c82e7e 100644
--- a/recipes-kernel/linux/linux-cip-rt_5.10.109-cip5-rt4.bb
+++ b/recipes-kernel/linux/linux-cip-rt_5.10.131-cip13-rt5.bb
@@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "71fba4ed5cb48fa7869e9fe271b68b77fed26775ce5cf2f50891aa8f71c388b3"
+SRC_URI[sha256sum] = "fc5ba1290c6ebeab65ad3783d3a0c65e2bb866c58905f2e627da04dff25166b3"
diff --git a/recipes-kernel/linux/linux-cip_4.19.249-cip76.bb b/recipes-kernel/linux/linux-cip_4.19.252-cip78.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_4.19.249-cip76.bb
rename to recipes-kernel/linux/linux-cip_4.19.252-cip78.bb
index a5b240e..326d011 100644
--- a/recipes-kernel/linux/linux-cip_4.19.249-cip76.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.252-cip78.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
 
-SRC_URI[sha256sum] = "7068eae8ea25eaded7891e14019e0c1d1fdaf8bb0abe77d42205b34fa059a157"
+SRC_URI[sha256sum] = "a77f4b3f81b76318a3d5a68a034100efae35ccb43e99afc820a8525689040bf4"
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip69.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip70.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip69.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip70.bb
index 2ae0b52..2fd314c 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip69.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip70.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
 
-SRC_URI[sha256sum] = "3acecb8f9ee4d9fba58d4a4cf4a2114018f030865f55b65cbc8e385ad04e691e"
+SRC_URI[sha256sum] = "0c59f3b3859c309a9a74d9709d70a35ea449868ebfa2fc56a0cc9d533f351000"
diff --git a/recipes-kernel/linux/linux-cip_5.10.126-cip11.bb b/recipes-kernel/linux/linux-cip_5.10.131-cip13.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_5.10.126-cip11.bb
rename to recipes-kernel/linux/linux-cip_5.10.131-cip13.bb
index a59333b..b2e372f 100644
--- a/recipes-kernel/linux/linux-cip_5.10.126-cip11.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.131-cip13.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "fa6b05e52b095ff29c08bbb2cd9d40fc4aedc69e9abf295fc303d30bdce51caf"
+SRC_URI[sha256sum] = "bbc453c27e4d67d1e07b741505f7012ab6c0f7e17efebf29ffc246b42cb612c7"
-- 
2.35.3


