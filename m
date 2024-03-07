Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E097C48BF6
	for <webhook@archiver.kernel.org>; Thu,  7 Mar 2024 07:45:58 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.18218.1709797556184302639
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Mar 2024 23:45:56 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 4277jrEG829344; Thu, 7 Mar 2024 16:45:54 +0900
X-Iguazu-Qid: 2rWglQcuM2IOr0AF2w
X-Iguazu-QSIG: v=2; s=0; t=1709797553; q=2rWglQcuM2IOr0AF2w; m=DLYvheW5XbgV7EgNVvXjxady6RfG2v/ZgwB/GDzvU/I=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 4277jq6l996455
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 7 Mar 2024 16:45:53 +0900
From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][RFC v1 2/6] swupdate-handler-roundrobin: Increase revision for Delta Handler support
Date: Thu,  7 Mar 2024 13:16:08 +0530
X-TSB-HOP2: ON
Message-Id: <20240307074612.1996609-3-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240307074612.1996609-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20240307074612.1996609-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 07 Mar 2024 07:45:48.0634 (UTC) FILETIME=[787C5BA0:01DA7063]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Mar 2024 07:45:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15254

This revision allows the use of delta handler in swupdate for zchunk based
delta updates

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 .../swupdate-handler-roundrobin_0.1.bb                          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
index b39278e..41eb06c 100644
--- a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
+++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
@@ -13,7 +13,7 @@ inherit dpkg-raw
 PROVIDES = "swupdate-handlers"
 
 SRC_URI += "git://gitlab.com/cip-project/cip-sw-updates/swupdate-handler-roundrobin.git;protocol=https;destsuffix=swupdate-handler-roundrobin;name=swupdate-handler-roundrobin;nobranch=1"
-SRCREV_swupdate-handler-roundrobin ?= "bb35127231ec08a67f79a7584ccfc0cada88cc4e"
+SRCREV_swupdate-handler-roundrobin ?= "e6936b8c29a20cb6a6893faae57e12499ebbc342"
 
 SWUPDATE_LUASCRIPT = "swupdate-handler-roundrobin/swupdate_handlers_roundrobin.lua"
 
-- 
2.39.2



