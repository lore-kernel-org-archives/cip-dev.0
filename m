Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26F8EE49AD
	for <webhook@archiver.kernel.org>; Wed, 23 Aug 2023 02:17:13 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.3052.1692757030593929778
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Aug 2023 19:17:11 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 37N2H6jB4058457; Wed, 23 Aug 2023 11:17:06 +0900
X-Iguazu-Qid: 2rWhQ1EpZ6OHIBkfs8
X-Iguazu-QSIG: v=2; s=0; t=1692757026; q=2rWhQ1EpZ6OHIBkfs8; m=Gz6gucRn8cwHyOoVmuAOtE+yB9nlKJfMiKZuNaQoGqw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 37N2H4DK1504180
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 23 Aug 2023 11:17:05 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: jan.kiszka@siemens.com
Cc: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [isar-cip-core][PATCH] linux/cip-kernel-config: Bump cip-kernel-config revision
Date: Wed, 23 Aug 2023 11:17:01 +0900
X-TSB-HOP2: ON
Message-Id: <20230823021701.87071-1-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Aug 2023 02:17:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12831

Update cip-kernel-config revision to latest commit.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 recipes-kernel/linux/cip-kernel-config.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
index e104200..51b17c6 100644
--- a/recipes-kernel/linux/cip-kernel-config.inc
+++ b/recipes-kernel/linux/cip-kernel-config.inc
@@ -14,4 +14,4 @@ SRC_URI:append = " ${@ \
     if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
     }"
 
-SRCREV_cip-kernel-config ?= "a28b7a678418287b12161975fe8b9b04a3cc8c88"
+SRCREV_cip-kernel-config ?= "aca5978b5abf93b20df4efda067c3a3f461476e0"
-- 
2.40.1



