Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3137BC77B7A
	for <webhook@archiver.kernel.org>; Wed, 17 May 2023 13:42:30 +0000 (UTC)
Received: from esa4.mentor.iphmx.com (esa4.mentor.iphmx.com [68.232.137.252])
 by mx.groups.io with SMTP id smtpd.web11.49791.1684330948767712196
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 May 2023 06:42:28 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: mentor.com, ip: 68.232.137.252, mailfrom: srinuvasan_a@mentor.com)
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="5676501"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa4.mentor.iphmx.com with ESMTP; 17 May 2023 05:42:25 -0800
IronPort-SDR: QFOTT5PHtXUU5YTrjBmdRzpQasHtJ1bLO2hH5DYgvCkAByCkExTXMye2/+VScZmNSLZZUhnPht
 ptxzr+ht9jrijMBHbg4Cc4zTlFafqnfM/CWKC4g1PaX/rLdDVu6GWaxf7iYgAmrcPFZU9FjTNG
 RSRAB1hyjGYCftu9GxkY29RsmVohBDbG5jKO+rqy5pXdza+MS4QBiIdpasXzhOPauzMYn6AnMr
 7RnpY2LulqnosM5grhIbfllTxwZkluZExnPKOAOWrpyJAa0hRzsXM9FZoWhjy8MerehL9Pz5sc
 Ft8=
From: Srinuvasan Arjunan <srinuvasan_a@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, Srinuvasan A <srinuvasan.a@siemens.com>
Subject: [isar-cip-core][PATCH] recipes-kernel/linux: Update cip-kernels to latest one
Date: Wed, 17 May 2023 19:12:06 +0530
Message-ID: <20230517134206.1517172-1-srinuvasan_a@mentor.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-11.mgc.mentorg.com (147.34.90.211) To
 svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 May 2023 13:42:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11495

From: Srinuvasan A <srinuvasan.a@siemens.com>

Update cip-kernels to latest one.

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 ...{linux-cip_4.19.280-cip96.bb => linux-cip_4.19.282-cip97.bb} | 2 +-
 .../{linux-cip_4.4.302-cip74.bb => linux-cip_4.4.302-cip75.bb}  | 2 +-
 ...{linux-cip_5.10.177-cip31.bb => linux-cip_5.10.179-cip32.bb} | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
 rename recipes-kernel/linux/{linux-cip_4.19.280-cip96.bb => linux-cip_4.19.282-cip97.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip74.bb => linux-cip_4.4.302-cip75.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_5.10.177-cip31.bb => linux-cip_5.10.179-cip32.bb} (72%)

diff --git a/recipes-kernel/linux/linux-cip_4.19.280-cip96.bb b/recipes-kernel/linux/linux-cip_4.19.282-cip97.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_4.19.280-cip96.bb
rename to recipes-kernel/linux/linux-cip_4.19.282-cip97.bb
index 0a1af14..5fbe92d 100644
--- a/recipes-kernel/linux/linux-cip_4.19.280-cip96.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.282-cip97.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
 
-SRC_URI[sha256sum] = "30f092e20799b9797376ee40d14995fd31a68773dff0b4913d4bbe5848cab5f6"
+SRC_URI[sha256sum] = "aeefefeea208364ee091950b1bc7d088d3769bce3bd5dc4397423641993cd2a0"
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip74.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip75.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip74.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip75.bb
index 4b6a548..4be6e36 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip74.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip75.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
 
-SRC_URI[sha256sum] = "0758c47f454d51fa80e3c63aac919d04ab4e6dc1a6ef8c34807e1e180d44d9d4"
+SRC_URI[sha256sum] = "1a606abebcf83aade421f0600c088cd94c3844fe6866d312d86b3fb1591b82bd"
diff --git a/recipes-kernel/linux/linux-cip_5.10.177-cip31.bb b/recipes-kernel/linux/linux-cip_5.10.179-cip32.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_5.10.177-cip31.bb
rename to recipes-kernel/linux/linux-cip_5.10.179-cip32.bb
index 08bc8ad..ff55f9e 100644
--- a/recipes-kernel/linux/linux-cip_5.10.177-cip31.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.179-cip32.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "7a53197c1bd26c3c2dbcea0d93d287900dc3e0d92199ef13702e5bf78ae97f56"
+SRC_URI[sha256sum] = "0688c26a0d8c1d425844ada9f42bbb5e8efb18b93b8cb6a823c587e12381fb8e"
-- 
2.34.1


