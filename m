Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDCEC433EF
	for <webhook@archiver.kernel.org>; Tue,  8 Mar 2022 10:44:31 +0000 (UTC)
Received: from esa3.mentor.iphmx.com (esa3.mentor.iphmx.com [68.232.137.180])
 by mx.groups.io with SMTP id smtpd.web08.6640.1646736268187563682
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Mar 2022 02:44:28 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: mentor.com, ip: 68.232.137.180, mailfrom: srinuvasan_a@mentor.com)
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400";
   d="scan'208";a="72700482"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa3.mentor.iphmx.com with ESMTP; 08 Mar 2022 02:44:28 -0800
IronPort-SDR: 
 VzifucTE7YxZVNrCBWDz0JQvRtdO8AXjDFAkIGjmn8pHSvRUIiaofbozIO/0/IShfuleLW8AWD
 mpcoP0c3x4aqAil13asSPKmdVRyFDwZ+lBTr8QvlEWNJRFm49ZcQ1YLApA49mWRneMfzZ3MvEB
 a2mhu+/lt0VOvJzh+zufFfD97pCrtbNK1CvFs/+4dVqJ9sJbW3S3YhBfIGEv6z2d+Ah8ZRrRJJ
 KEa9AbTXIk7kfOVqha9IBtW19OHkyVGZ97+VdlxKgud9N8oHVBvMON+OKCvItkXj4PRcRQQabi
 wyU=
From: Srinuvasan A <Srinuvasan_A@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, Srinuvasan A <srinuvasan_a@mentor.com>
Subject: [cip-dev][PATCH] linux-cip: Update kernel versions
Date: Tue, 8 Mar 2022 16:14:07 +0530
Message-ID: <20220308104407.780804-1-Srinuvasan_A@mentor.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 08 Mar 2022 10:44:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7668

From: Srinuvasan A <srinuvasan_a@mentor.com>

Bump kernel versions for linux-cip-kernel 4.4,4.19 and 5.10.

Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
---
 ...4.4.285-cip63-rt36.bb => linux-cip-rt_4.4.302-cip68-rt38.bb} | 2 +-
 ...rt_5.10.83-cip1-rt1.bb => linux-cip-rt_5.10.100-cip2-rt2.bb} | 2 +-
 ...{linux-cip_4.19.217-cip62.bb => linux-cip_4.19.231-cip68.bb} | 2 +-
 .../{linux-cip_4.4.291-cip65.bb => linux-cip_4.4.302-cip68.bb}  | 2 +-
 .../{linux-cip_5.10.83-cip1.bb => linux-cip_5.10.100-cip2.bb}   | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.4.285-cip63-rt36.bb => linux-cip-rt_4.4.302-cip68-rt38.bb} (72%)
 rename recipes-kernel/linux/{linux-cip-rt_5.10.83-cip1-rt1.bb => linux-cip-rt_5.10.100-cip2-rt2.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_4.19.217-cip62.bb => linux-cip_4.19.231-cip68.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_4.4.291-cip65.bb => linux-cip_4.4.302-cip68.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_5.10.83-cip1.bb => linux-cip_5.10.100-cip2.bb} (71%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.285-cip63-rt36.bb b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip68-rt38.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip-rt_4.4.285-cip63-rt36.bb
rename to recipes-kernel/linux/linux-cip-rt_4.4.302-cip68-rt38.bb
index 41342b3..fae4125 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.4.285-cip63-rt36.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip68-rt38.bb
@@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
 
-SRC_URI[sha256sum] = "c2fe6bcf44fc7a8ee9785adc4dc41d07c50d803883add859648cbbb0461854fa"
+SRC_URI[sha256sum] = "bbcc9af1b08a1285a9fc5ba57cba74dcc9fb6511dd74029576ca82629d04cad7"
diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.83-cip1-rt1.bb b/recipes-kernel/linux/linux-cip-rt_5.10.100-cip2-rt2.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip-rt_5.10.83-cip1-rt1.bb
rename to recipes-kernel/linux/linux-cip-rt_5.10.100-cip2-rt2.bb
index b20ac56..96c4d07 100644
--- a/recipes-kernel/linux/linux-cip-rt_5.10.83-cip1-rt1.bb
+++ b/recipes-kernel/linux/linux-cip-rt_5.10.100-cip2-rt2.bb
@@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "e10b3ab1ad09ed7650883c5357b68660ac1c56f6d71b3b82feb0d69ed182ea54"
+SRC_URI[sha256sum] = "e642fc604b611dc6f3e8382447fb2bc4047d129a14cba3996d34b85e07ae9d3a"
diff --git a/recipes-kernel/linux/linux-cip_4.19.217-cip62.bb b/recipes-kernel/linux/linux-cip_4.19.231-cip68.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_4.19.217-cip62.bb
rename to recipes-kernel/linux/linux-cip_4.19.231-cip68.bb
index 0147313..91ef5f6 100644
--- a/recipes-kernel/linux/linux-cip_4.19.217-cip62.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.231-cip68.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
 
-SRC_URI[sha256sum] = "00b22f2e7b3d4f5787ca92f2e182211ac2c1391c09435174c2b4670b2837b23c"
+SRC_URI[sha256sum] = "f39146555dcee1e9f76c4b6e000e0d6f42d4a6a56d95d415ac1442b1f99d0465"
diff --git a/recipes-kernel/linux/linux-cip_4.4.291-cip65.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip68.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_4.4.291-cip65.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip68.bb
index 4e32031..160b7ed 100644
--- a/recipes-kernel/linux/linux-cip_4.4.291-cip65.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip68.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
 
-SRC_URI[sha256sum] = "9ed7782c067793e684691e99388608ff746f04121cc35dbbbfc2fa5ed6f9e88e"
+SRC_URI[sha256sum] = "d49e1fd2df419279a8595db6e68311cbb91399a92e6d71672543c4eb2088b317"
diff --git a/recipes-kernel/linux/linux-cip_5.10.83-cip1.bb b/recipes-kernel/linux/linux-cip_5.10.100-cip2.bb
similarity index 71%
rename from recipes-kernel/linux/linux-cip_5.10.83-cip1.bb
rename to recipes-kernel/linux/linux-cip_5.10.100-cip2.bb
index 236358a..e2bb298 100644
--- a/recipes-kernel/linux/linux-cip_5.10.83-cip1.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.100-cip2.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "85af8f809b2505c6434266d6658d977d62d383889b3a4f9968b2764794108d4f"
+SRC_URI[sha256sum] = "0fe532c7900299888160a740ed70c1daaa9536fe545bee4f754043e1e0a09c16"
-- 
2.25.1


