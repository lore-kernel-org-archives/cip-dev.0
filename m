Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7820CD11DE
	for <webhook@archiver.kernel.org>; Wed, 20 Mar 2024 10:32:01 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.40302.1710930712530080067
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Mar 2024 03:31:53 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 42KAVphp3644378; Wed, 20 Mar 2024 19:31:51 +0900
X-Iguazu-Qid: 2yAamVQ9TFi7Qej6Ho
X-Iguazu-QSIG: v=2; s=0; t=1710930710; q=2yAamVQ9TFi7Qej6Ho; m=j7/8yn5CGtrQFANy1+GbQ0iN6Yqa+7Wbum9wTR5Ha5k=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 42KAVnag1294791
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 20 Mar 2024 19:31:50 +0900
From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, adithya.balakumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][RFC v2 1/4] swupdate-handler-roundrobin: Increase revision for Delta Handler support
Date: Wed, 20 Mar 2024 16:02:26 +0530
X-TSB-HOP2: ON
Message-Id: <20240320103229.1078738-2-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240320103229.1078738-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20240320103229.1078738-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 20 Mar 2024 10:31:46.0630 (UTC) FILETIME=[CF48B660:01DA7AB1]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Mar 2024 10:32:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15380

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



