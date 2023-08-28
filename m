Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084DDC83F10
	for <webhook@archiver.kernel.org>; Mon, 28 Aug 2023 02:02:16 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.5350.1693188126181321466
 for <cip-dev@lists.cip-project.org>;
 Sun, 27 Aug 2023 19:02:07 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 37S2242H4079967; Mon, 28 Aug 2023 11:02:04 +0900
X-Iguazu-Qid: 2yAaUxDRIg3fFCJXhK
X-Iguazu-QSIG: v=2; s=0; t=1693188123; q=2yAaUxDRIg3fFCJXhK; m=TDPTKL8AmIbXKkh7v02VLnzEzEmIJI7NvQIJVKAsZPU=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 37S223Y13009209
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 28 Aug 2023 11:02:03 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: jan.kiszka@siemens.com
Cc: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH] linux-cip: Update to latest releases
Date: Mon, 28 Aug 2023 11:01:58 +0900
X-TSB-HOP2: ON
Message-Id: <20230828020158.1788420-1-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Aug 2023 02:02:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12867

  - Update to 6.1.46-cip4
  - Update to 5.10.191-cip38
  - Update to 4.19.292-cip102

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 ...inux-cip_4.19.288-cip101.bb => linux-cip_4.19.292-cip102.bb} | 2 +-
 ...{linux-cip_5.10.186-cip37.bb => linux-cip_5.10.191-cip38.bb} | 2 +-
 .../{linux-cip_6.1.45-cip3.bb => linux-cip_6.1.46-cip4.bb}      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
 rename recipes-kernel/linux/{linux-cip_4.19.288-cip101.bb => linux-cip_4.19.292-cip102.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_5.10.186-cip37.bb => linux-cip_5.10.191-cip38.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_6.1.45-cip3.bb => linux-cip_6.1.46-cip4.bb} (65%)

diff --git a/recipes-kernel/linux/linux-cip_4.19.288-cip101.bb b/recipes-kernel/linux/linux-cip_4.19.292-cip102.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_4.19.288-cip101.bb
rename to recipes-kernel/linux/linux-cip_4.19.292-cip102.bb
index 44f1e2d..8b1d4b3 100644
--- a/recipes-kernel/linux/linux-cip_4.19.288-cip101.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.292-cip102.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
 
-SRC_URI[sha256sum] = "6d737010f07b27838247880e7aa4699bbf881b587f5b5eb6cfbe98bd523c7969"
+SRC_URI[sha256sum] = "106b3bcf4b3cc8b4ed25995a843839875e5fbbaf3b533df9d666199314628e31"
diff --git a/recipes-kernel/linux/linux-cip_5.10.186-cip37.bb b/recipes-kernel/linux/linux-cip_5.10.191-cip38.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_5.10.186-cip37.bb
rename to recipes-kernel/linux/linux-cip_5.10.191-cip38.bb
index 06ad14c..cf66e55 100644
--- a/recipes-kernel/linux/linux-cip_5.10.186-cip37.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.191-cip38.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "0a0eafb33490fbf6116c69f65846745dd0cb288119889ed87d336447683d46bb"
+SRC_URI[sha256sum] = "cee2c13b4e7280e6eb92746d14ec2b5e0e76c3842808de4348765e33b9e6dd39"
diff --git a/recipes-kernel/linux/linux-cip_6.1.45-cip3.bb b/recipes-kernel/linux/linux-cip_6.1.46-cip4.bb
similarity index 65%
rename from recipes-kernel/linux/linux-cip_6.1.45-cip3.bb
rename to recipes-kernel/linux/linux-cip_6.1.46-cip4.bb
index 8124f1d..fef2d05 100644
--- a/recipes-kernel/linux/linux-cip_6.1.45-cip3.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.46-cip4.bb
@@ -9,4 +9,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "6.1.y-cip"
 
-SRC_URI[sha256sum] = "bef9588c018ef583303b288baa4eec3b0fc8a723058d52da7fd2fa27d6e619d2"
+SRC_URI[sha256sum] = "691c4e52281e47d324c4c9b840cba7050e42147a05342ce4cfe1ece40fb9c27b"
-- 
2.39.2



