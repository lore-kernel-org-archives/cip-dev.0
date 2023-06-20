Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B4AEB64D7
	for <webhook@archiver.kernel.org>; Tue, 20 Jun 2023 07:09:34 +0000 (UTC)
Received: from esa3.mentor.iphmx.com (esa3.mentor.iphmx.com [68.232.137.180])
 by mx.groups.io with SMTP id smtpd.web10.4859.1687244967914424716
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Jun 2023 00:09:28 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: mentor.com, ip: 68.232.137.180, mailfrom: srinuvasan_a@mentor.com)
X-IronPort-AV: E=Sophos;i="6.00,256,1681200000"; 
   d="scan'208";a="9263316"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa3.mentor.iphmx.com with ESMTP; 19 Jun 2023 23:09:22 -0800
IronPort-SDR: 9z9CsnNTDd/ByhiWK+N8HXj+xIXWRAimP3p3MR1esRMIKbXgJJ6jIv4xrS9oKW+0vg4rCw4QMX
 fB+1jiDWUcBVXbXEH4sYXq4vzpMLH+eumw5oF2y1absc8XQoQ1RcJ57uCm7mw5n4mSfNZEwf0E
 P+Ue+khZLMxtpsJt1Bkz22KubHi6KpIheOOlmU3llraZLxLk1bzxn7exzTYxsjgpRyCJkIjbie
 a/Ep0llYmcJsNn711uCIsXWrHcaAU6e0xjRrFTIUeN1RlQiIkWFCA+jdzoyK/f6q0skC3aO/3V
 GiA=
From: Srinuvasan Arjunan <srinuvasan_a@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, Srinuvasan A <srinuvasan.a@siemens.com>
Subject: [isar-cip-core][PATCH] recipes-kernel/linux: update cip-kernels to latest one
Date: Tue, 20 Jun 2023 12:38:57 +0530
Message-ID: <20230620070857.885691-1-srinuvasan_a@mentor.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213) To
 svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 20 Jun 2023 07:09:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12084

From: Srinuvasan A <srinuvasan.a@siemens.com>

Update cip-kernels to latest one.

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 ...19.280-cip95-rt30.bb => linux-cip-rt_4.19.284-cip99-rt31.bb} | 2 +-
 ...4.4.302-cip74-rt43.bb => linux-cip-rt_4.4.302-cip76-rt44.bb} | 2 +-
 ...{linux-cip_4.19.283-cip98.bb => linux-cip_4.19.284-cip99.bb} | 2 +-
 .../{linux-cip_4.4.302-cip75.bb => linux-cip_4.4.302-cip76.bb}  | 2 +-
 ...{linux-cip_5.10.180-cip34.bb => linux-cip_5.10.182-cip35.bb} | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.19.280-cip95-rt30.bb => linux-cip-rt_4.19.284-cip99-rt31.bb} (72%)
 rename recipes-kernel/linux/{linux-cip-rt_4.4.302-cip74-rt43.bb => linux-cip-rt_4.4.302-cip76-rt44.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_4.19.283-cip98.bb => linux-cip_4.19.284-cip99.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip75.bb => linux-cip_4.4.302-cip76.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_5.10.180-cip34.bb => linux-cip_5.10.182-cip35.bb} (72%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.280-cip95-rt30.bb b/recipes-kernel/linux/linux-cip-rt_4.19.284-cip99-rt31.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip-rt_4.19.280-cip95-rt30.bb
rename to recipes-kernel/linux/linux-cip-rt_4.19.284-cip99-rt31.bb
index d973b94..6a1ccea 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.19.280-cip95-rt30.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.19.284-cip99-rt31.bb
@@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
 
-SRC_URI[sha256sum] = "dfe9992d937c47f2f5a79ddd2156fd4ab749c9d82ef04506dfa8da6cfbb594b0"
+SRC_URI[sha256sum] = "a4984846d2a239cfe9ab8546dd3a692d8fcf6da60228b54b51a8abc5b0ce2fed"
diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip74-rt43.bb b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip76-rt44.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip-rt_4.4.302-cip74-rt43.bb
rename to recipes-kernel/linux/linux-cip-rt_4.4.302-cip76-rt44.bb
index 7380fb6..43488dd 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip74-rt43.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip76-rt44.bb
@@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
 
-SRC_URI[sha256sum] = "62b83cafae6009b407018178ce76ffe7d23be8b33b7cf1bb1af82eb7a323c02a"
+SRC_URI[sha256sum] = "01260a42cf979e28e183bc2161a5885dfaae1628eefc1325438294f4def8adc5"
diff --git a/recipes-kernel/linux/linux-cip_4.19.283-cip98.bb b/recipes-kernel/linux/linux-cip_4.19.284-cip99.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_4.19.283-cip98.bb
rename to recipes-kernel/linux/linux-cip_4.19.284-cip99.bb
index b12fb6b..e223a1f 100644
--- a/recipes-kernel/linux/linux-cip_4.19.283-cip98.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.284-cip99.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
 
-SRC_URI[sha256sum] = "6d8474aad8621163f1478fcd110f391863ee2ed5180fccb4613c2e3eccc2e4e6"
+SRC_URI[sha256sum] = "eb64e6f848e8c60e00b5234e7460cf4bfbdd138047bc31244f692c33b83226cc"
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip75.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip76.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip75.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip76.bb
index fae6e12..6c45b5d 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip75.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip76.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
 
-SRC_URI[sha256sum] = "b7616ce99de5f9f29065c8adb4a9465d118b7f4c89276f95b9de755c99cb3f61"
+SRC_URI[sha256sum] = "a3437df29f07a2dbfcc2dbee94fc0397b37b5eb63c6e4453fcb0bff694c0169f"
diff --git a/recipes-kernel/linux/linux-cip_5.10.180-cip34.bb b/recipes-kernel/linux/linux-cip_5.10.182-cip35.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_5.10.180-cip34.bb
rename to recipes-kernel/linux/linux-cip_5.10.182-cip35.bb
index 9b812b7..86020b6 100644
--- a/recipes-kernel/linux/linux-cip_5.10.180-cip34.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.182-cip35.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "6b715945aa287b93fa8e69086988a76b3d0f1e5da82caad47dd653baac3bfd55"
+SRC_URI[sha256sum] = "cc25a9303eb46f39ae882df646ba3c544494ae136e05812b1d1e7ebf9e8db28a"
-- 
2.34.1


