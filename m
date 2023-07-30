Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB66EB64DD
	for <webhook@archiver.kernel.org>; Sun, 30 Jul 2023 22:43:23 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.83631.1690756997949919195
 for <cip-dev@lists.cip-project.org>;
 Sun, 30 Jul 2023 15:43:19 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 36UMhEXj638199; Mon, 31 Jul 2023 07:43:15 +0900
X-Iguazu-Qid: 2rWhi9UHchGn3Q50qH
X-Iguazu-QSIG: v=2; s=0; t=1690756994; q=2rWhi9UHchGn3Q50qH; m=H3VNVOzNKFzi4xMwZ7ZwjoJWW5qN8DEYGxc344PkU3w=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 36UMhDx71570507
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 31 Jul 2023 07:43:13 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [isar-cip-core] linux-cip: Update to 6.1.42-cip2
Date: Mon, 31 Jul 2023 07:43:10 +0900
X-TSB-HOP2: ON
Message-Id: <20230730224310.1333158-1-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 30 Jul 2023 22:43:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12523

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 .../{linux-cip_6.1.38-cip1.bb => linux-cip_6.1.42-cip2.bb}      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-kernel/linux/{linux-cip_6.1.38-cip1.bb => linux-cip_6.1.42-cip2.bb} (65%)

diff --git a/recipes-kernel/linux/linux-cip_6.1.38-cip1.bb b/recipes-kernel/linux/linux-cip_6.1.42-cip2.bb
similarity index 65%
rename from recipes-kernel/linux/linux-cip_6.1.38-cip1.bb
rename to recipes-kernel/linux/linux-cip_6.1.42-cip2.bb
index 417de50..0b6ffaa 100644
--- a/recipes-kernel/linux/linux-cip_6.1.38-cip1.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.42-cip2.bb
@@ -9,4 +9,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "6.1.y-cip"
 
-SRC_URI[sha256sum] = "188c2ee35a13058858d71aa9121ad9f75c3834126bd93d019ab1687ce0027aa7"
+SRC_URI[sha256sum] = "70d05a84e8194a94dccbdce952a983466a404498fe59fb61fd3de1463322bb5a"
-- 
2.40.1



