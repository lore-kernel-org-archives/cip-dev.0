Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258EDCA0EC4
	for <webhook@archiver.kernel.org>; Tue, 12 Aug 2025 09:38:13 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.70476.1754991486320921039
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Aug 2025 02:38:06 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 57C9c4XY3165202; Tue, 12 Aug 2025 18:38:04 +0900
X-Iguazu-Qid: 2yAbuzQy5lephBE1gn
X-Iguazu-QSIG: v=2; s=0; t=1754991483; q=2yAbuzQy5lephBE1gn; m=r2SuVO+1FnAKmAxuKhlk9BhAUWk+HiSBC9NLH+MzbqI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 57C9c2Nl1189028
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 18:38:03 +0900
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH] swupdate-handler-roundrobin: Update revision for rdiff_file handler support
Date: Tue, 12 Aug 2025 14:58:15 +0530
X-TSB-HOP2: ON
Message-Id: <20250812092815.1282546-1-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 12 Aug 2025 09:38:01.0153 (UTC) FILETIME=[CB6C7B10:01DC0B6C]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Aug 2025 09:38:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19718

This revision includes the support of rdiff_file handler which is
helpful to update the single files using rdiff.

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 .../swupdate-handler-roundrobin_0.1.bb                          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
index a185f25..d2edbbd 100644
--- a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
+++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
@@ -13,7 +13,7 @@ inherit dpkg-raw
 PROVIDES = "swupdate-handlers"
 
 SRC_URI += "git://gitlab.com/cip-project/cip-sw-updates/swupdate-handler-roundrobin.git;protocol=https;destsuffix=swupdate-handler-roundrobin;name=swupdate-handler-roundrobin;nobranch=1"
-SRCREV_swupdate-handler-roundrobin ?= "e6936b8c29a20cb6a6893faae57e12499ebbc342"
+SRCREV_swupdate-handler-roundrobin ?= "5deb75df5469c5a66cdd727eb72af83ce0784054"
 
 SWUPDATE_LUASCRIPT = "swupdate-handler-roundrobin/swupdate_handlers_roundrobin.lua"
 
-- 
2.39.5



