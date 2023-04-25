Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5AFC77B61
	for <webhook@archiver.kernel.org>; Tue, 25 Apr 2023 09:43:27 +0000 (UTC)
Received: from esa2.mentor.iphmx.com (esa2.mentor.iphmx.com [68.232.141.98])
 by mx.groups.io with SMTP id smtpd.web10.75463.1682415803252319042
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Apr 2023 02:43:23 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: mentor.com, ip: 68.232.141.98, mailfrom: srinuvasan_a@mentor.com)
X-IronPort-AV: E=Sophos;i="5.99,225,1677571200"; 
   d="scan'208";a="3836316"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa2.mentor.iphmx.com with ESMTP; 25 Apr 2023 01:43:22 -0800
IronPort-SDR: +I40i/1bwiipR6acEJHowvS7HcaHo/ueyhlZopBQQyzs+Cm+LlyVDHEkLrxyj3VD3pjkYxt1NI
 Wq4kU297gyyqZXqoqYNMLwfpiDAZLRCBCkAopGSYzVw/NyQw/fP8Qvdn6P6N0+9p7+lCH9ixUD
 oRNvf89vEEGVxsY9QmynK+llc/T4tIYPiCK1SRklrixPDe0SZwMHJwTAbhXMjsOeQslRIzGI5c
 ElTWzusAxdn9STQzfAJGsGcDt2kte9vo6klvDdIh/AHYrz/ZJNWMb0SSuBbcU8F9jM/a2iVTTO
 m2I=
From: Srinuvasan Arjunan <srinuvasan_a@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, Srinuvasan A <srinuvasan.a@siemens.com>
Subject: [PATCH] linux-cip: Update to latest releases
Date: Tue, 25 Apr 2023 15:13:04 +0530
Message-ID: <20230425094304.3212474-1-srinuvasan_a@mentor.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-15.mgc.mentorg.com (147.34.90.215) To
 svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Apr 2023 09:43:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11339

From: Srinuvasan A <srinuvasan.a@siemens.com>

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 ...{linux-cip_4.19.279-cip95.bb => linux-cip_4.19.280-cip96.bb} | 2 +-
 ...{linux-cip_5.10.176-cip30.bb => linux-cip_5.10.177-cip31.bb} | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename recipes-kernel/linux/{linux-cip_4.19.279-cip95.bb => linux-cip_4.19.280-cip96.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_5.10.176-cip30.bb => linux-cip_5.10.177-cip31.bb} (72%)

diff --git a/recipes-kernel/linux/linux-cip_4.19.279-cip95.bb b/recipes-kernel/linux/linux-cip_4.19.280-cip96.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_4.19.279-cip95.bb
rename to recipes-kernel/linux/linux-cip_4.19.280-cip96.bb
index 802a855..0a1af14 100644
--- a/recipes-kernel/linux/linux-cip_4.19.279-cip95.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.280-cip96.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
 
-SRC_URI[sha256sum] = "fb5808626317e464408203562941d287fc49f747f3af1c1a34c125229a5efa43"
+SRC_URI[sha256sum] = "30f092e20799b9797376ee40d14995fd31a68773dff0b4913d4bbe5848cab5f6"
diff --git a/recipes-kernel/linux/linux-cip_5.10.176-cip30.bb b/recipes-kernel/linux/linux-cip_5.10.177-cip31.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_5.10.176-cip30.bb
rename to recipes-kernel/linux/linux-cip_5.10.177-cip31.bb
index 6f740f5..08bc8ad 100644
--- a/recipes-kernel/linux/linux-cip_5.10.176-cip30.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.177-cip31.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "722931b6291d1c796d571ff2e1bf4393734928edb6af7df7138ca0379d9a27c9"
+SRC_URI[sha256sum] = "7a53197c1bd26c3c2dbcea0d93d287900dc3e0d92199ef13702e5bf78ae97f56"
-- 
2.34.1


