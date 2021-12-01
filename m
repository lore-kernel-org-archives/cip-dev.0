Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB28C433EF
	for <webhook@archiver.kernel.org>; Wed,  1 Dec 2021 14:23:59 +0000 (UTC)
Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web11.92100.1638368638666024109
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Dec 2021 06:23:59 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 194.138.37.39, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 1B1ENuxv023773
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 1 Dec 2021 15:23:56 +0100
Received: from [139.25.68.37] ([139.25.68.37])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1B1ENtHW029754
	for <cip-dev@lists.cip-project.org>; Wed, 1 Dec 2021 15:23:56 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH v2] linux-cip: Update to latest releases
To: cip-dev <cip-dev@lists.cip-project.org>
Message-ID: <a2acca03-2fa3-24b3-76ad-f008cb1cea08@siemens.com>
Date: Wed, 1 Dec 2021 15:23:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 01 Dec 2021 14:23:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7055

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - include fresh 4.19-rt release

 ...19.206-cip57-rt22.bb => linux-cip-rt_4.19.217-cip62-rt23.bb} | 2 +-
 ...4.4.277-cip60-rt35.bb => linux-cip-rt_4.4.285-cip63-rt36.bb} | 2 +-
 ...{linux-cip_4.19.206-cip57.bb => linux-cip_4.19.217-cip62.bb} | 2 +-
 .../{linux-cip_4.4.283-cip62.bb => linux-cip_4.4.291-cip65.bb}  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.19.206-cip57-rt22.bb => linux-cip-rt_4.19.217-cip62-rt23.bb} (68%)
 rename recipes-kernel/linux/{linux-cip-rt_4.4.277-cip60-rt35.bb => linux-cip-rt_4.4.285-cip63-rt36.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_4.19.206-cip57.bb => linux-cip_4.19.217-cip62.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_4.4.283-cip62.bb => linux-cip_4.4.291-cip65.bb} (68%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.206-cip57-rt22.bb b/recipes-kernel/linux/linux-cip-rt_4.19.217-cip62-rt23.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.19.206-cip57-rt22.bb
rename to recipes-kernel/linux/linux-cip-rt_4.19.217-cip62-rt23.bb
index e6af865..a3a9c43 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.19.206-cip57-rt22.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.19.217-cip62-rt23.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "586ff1af1c0ee794794db4af40544391d8b2dde88417136e32e6105c6f9d77b3"
+SRC_URI[sha256sum] = "f7584d79132ad99ed5b7ce7430c79a08cb9b81ad40b5982464f95859a00ceb6f"
diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.277-cip60-rt35.bb b/recipes-kernel/linux/linux-cip-rt_4.4.285-cip63-rt36.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.4.277-cip60-rt35.bb
rename to recipes-kernel/linux/linux-cip-rt_4.4.285-cip63-rt36.bb
index 0a2de66..c051583 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.4.277-cip60-rt35.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.4.285-cip63-rt36.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "ea4a5de21e6ad82001685bddcfaacd2eaaf524fea61dd774c2895c7adb3b934e"
+SRC_URI[sha256sum] = "c2fe6bcf44fc7a8ee9785adc4dc41d07c50d803883add859648cbbb0461854fa"
diff --git a/recipes-kernel/linux/linux-cip_4.19.206-cip57.bb b/recipes-kernel/linux/linux-cip_4.19.217-cip62.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.19.206-cip57.bb
rename to recipes-kernel/linux/linux-cip_4.19.217-cip62.bb
index f23ab83..1a60571 100644
--- a/recipes-kernel/linux/linux-cip_4.19.206-cip57.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.217-cip62.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "a88ab84c6cf072743890a11e2f782540ecf1081167f3a2f34311060f99eda44d"
+SRC_URI[sha256sum] = "00b22f2e7b3d4f5787ca92f2e182211ac2c1391c09435174c2b4670b2837b23c"
diff --git a/recipes-kernel/linux/linux-cip_4.4.283-cip62.bb b/recipes-kernel/linux/linux-cip_4.4.291-cip65.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.4.283-cip62.bb
rename to recipes-kernel/linux/linux-cip_4.4.291-cip65.bb
index bcb754d..e45c57c 100644
--- a/recipes-kernel/linux/linux-cip_4.4.283-cip62.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.291-cip65.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "842c443e6adc43cebe73acb071a59a8c410cc6cd83488502f297ee1a995dbae6"
+SRC_URI[sha256sum] = "9ed7782c067793e684691e99388608ff746f04121cc35dbbbfc2fa5ed6f9e88e"
-- 
2.31.1

