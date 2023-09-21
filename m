Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74417E7070A
	for <webhook@archiver.kernel.org>; Thu, 21 Sep 2023 10:23:40 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.12717.1695291816019516885
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Sep 2023 03:23:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=ZL8OXNs+;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-294854-2023092110233360ca09401cb7bd40e4-ozcz_e@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2023092110233360ca09401cb7bd40e4
        for <cip-dev@lists.cip-project.org>;
        Thu, 21 Sep 2023 12:23:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=o6B5IZnxddrFXrfyaNeAJ6BHzE9JJH5QLaf2yubYbPs=;
 b=ZL8OXNs+QFv67HPz8B7/2wMFBWcZoCNeh/01M9z9BcwXVeFHJI0Zv0VH2wocAI0lSaHc1m
 eADulxw+R9VWFmINVbjtd709j6O5NhMn1yhid1UbmMyetpWKaWD//Dq05KZGDew41BXoba//
 aG6m8vwvcXKJ1j56QTwEE/U9CN6zc=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 3/5] linux-cip: Update to 5.10.194-cip39[-rt16] and 6.1.54-cip6
Date: Thu, 21 Sep 2023 12:23:29 +0200
Message-Id: <d511f8a666d091acf54deff7110f7483ea67ad6f.1695291811.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1695291811.git.jan.kiszka@siemens.com>
References: <cover.1695291811.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Sep 2023 10:23:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13190

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...10.186-cip37-rt15.bb => linux-cip-rt_5.10.194-cip39-rt16.bb} | 2 +-
 ...{linux-cip_5.10.191-cip38.bb => linux-cip_5.10.194-cip39.bb} | 2 +-
 .../{linux-cip_6.1.52-cip5.bb => linux-cip_6.1.54-cip6.bb}      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_5.10.186-cip37-rt15.bb => linux-cip-rt_5.10.194-cip39-rt16.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_5.10.191-cip38.bb => linux-cip_5.10.194-cip39.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.52-cip5.bb => linux-cip_6.1.54-cip6.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.186-cip37-rt15.bb b/recipes-kernel/linux/linux-cip-rt_5.10.194-cip39-rt16.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_5.10.186-cip37-rt15.bb
rename to recipes-kernel/linux/linux-cip-rt_5.10.194-cip39-rt16.bb
index 277c1612..f11a5bfe 100644
--- a/recipes-kernel/linux/linux-cip-rt_5.10.186-cip37-rt15.bb
+++ b/recipes-kernel/linux/linux-cip-rt_5.10.194-cip39-rt16.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "076f4b1019a37fe03aa53ad47e2f530316d2190608200c5c09557b84651797e5"
+SRC_URI[sha256sum] = "54f319ecb09f98d2df408b97dbed015c90cf8871ef83430b10eae8e40fb93070"
diff --git a/recipes-kernel/linux/linux-cip_5.10.191-cip38.bb b/recipes-kernel/linux/linux-cip_5.10.194-cip39.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_5.10.191-cip38.bb
rename to recipes-kernel/linux/linux-cip_5.10.194-cip39.bb
index 73008c05..82f7e15c 100644
--- a/recipes-kernel/linux/linux-cip_5.10.191-cip38.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.194-cip39.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "285dee8d7076fa4ac236167c0be10122f7eac5052e2ec20379fdf5be6452ec79"
+SRC_URI[sha256sum] = "39fa92032d1c5abfd6cc2a04d3dd4a5ab52df7b92a18bb63a3f4424e3c2d9c8b"
diff --git a/recipes-kernel/linux/linux-cip_6.1.52-cip5.bb b/recipes-kernel/linux/linux-cip_6.1.54-cip6.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.52-cip5.bb
rename to recipes-kernel/linux/linux-cip_6.1.54-cip6.bb
index 2f2367b2..07dea15e 100644
--- a/recipes-kernel/linux/linux-cip_6.1.52-cip5.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.54-cip6.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "b2271049dface2d9220d185f58d567f593fcd94cd7819ab0e6a3c131c02d97c7"
+SRC_URI[sha256sum] = "83b2172ee00e0b1621c83567955c232488213d36486d77a8f90766f053b6f5de"
-- 
2.35.3


