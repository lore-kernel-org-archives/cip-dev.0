Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0E5C4167E
	for <webhook@archiver.kernel.org>; Wed,  4 May 2022 19:46:09 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web12.2024.1651693566883093079
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 May 2022 12:46:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=h6pBKEU8;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228,
 mailfrom: fm-294854-20220504194603708c28dc5a43bb47d3-_yieob@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 20220504194603708c28dc5a43bb47d3
        for <cip-dev@lists.cip-project.org>;
        Wed, 04 May 2022 21:46:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=mXv2P4MwnBJxlCvTGoPqN3icakHbb0rep6WZaUFFgV4=;
 b=h6pBKEU8A9KuUmePOWn6erWYF5NTu4ZeLuaM39dQeaTXQNbjSbyCzP3rcWBmgLxNphuMkL
 sxH/TzQvxIF/2Yr+NtnIga7hXixKjwjUJ9qBZjL1qmhyss7ogb89NhFGZbzdVJFyPb/JibK6
 //v5aqRik9t98rK6H9GI3j6vzq3hA=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH 06/12] linux-cip: Update to 4.19.239-cip72 and
 5.10.112-cip6
Date: Wed,  4 May 2022 21:45:54 +0200
Message-Id: 
 <cb388d29742dbff98818c7eb08ce24a39f865b23.1651693560.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1651693560.git.jan.kiszka@siemens.com>
References: <cover.1651693560.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 May 2022 19:46:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8248

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...{linux-cip_4.19.235-cip70.bb => linux-cip_4.19.239-cip72.bb} | 2 +-
 .../{linux-cip_5.10.106-cip4.bb => linux-cip_5.10.112-cip6.bb}  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename recipes-kernel/linux/{linux-cip_4.19.235-cip70.bb => linux-cip_4.19.239-cip72.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_5.10.106-cip4.bb => linux-cip_5.10.112-cip6.bb} (72%)

diff --git a/recipes-kernel/linux/linux-cip_4.19.235-cip70.bb b/recipes-kernel/linux/linux-cip_4.19.239-cip72.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_4.19.235-cip70.bb
rename to recipes-kernel/linux/linux-cip_4.19.239-cip72.bb
index eaad5e8..718bbfb 100644
--- a/recipes-kernel/linux/linux-cip_4.19.235-cip70.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.239-cip72.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
 
-SRC_URI[sha256sum] = "b3bcb1ffd82c2ccdcb96aba55bdc46c72db12b6b5442591f804c8e298ad405c4"
+SRC_URI[sha256sum] = "5f22ea902c89b1cd178706411e48a40613c1db069fa7dc5993b979fd4652c2cd"
diff --git a/recipes-kernel/linux/linux-cip_5.10.106-cip4.bb b/recipes-kernel/linux/linux-cip_5.10.112-cip6.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_5.10.106-cip4.bb
rename to recipes-kernel/linux/linux-cip_5.10.112-cip6.bb
index 2f52cdb..b54dcb5 100644
--- a/recipes-kernel/linux/linux-cip_5.10.106-cip4.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.112-cip6.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "512787b7f75b25e2c7f64978957bb2e6613e7c9edccc6d677ddd256109244d25"
+SRC_URI[sha256sum] = "aedeaefcb3da02fe6ab36859eb15c2e36844b2a0ea828a902b85037ad145e1ee"
-- 
2.34.1


