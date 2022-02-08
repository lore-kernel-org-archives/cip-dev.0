Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42655C433F5
	for <webhook@archiver.kernel.org>; Tue,  8 Feb 2022 11:46:07 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web12.10026.1644320764963578060
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Feb 2022 03:46:06 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158,
 mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 218Bk2kK030940;
 Tue, 8 Feb 2022 20:46:02 +0900
X-Iguazu-Qid: 2wGrVsu7KzqS6yDgeI
X-Iguazu-QSIG: v=2; s=0; t=1644320761; q=2wGrVsu7KzqS6yDgeI;
 m=JaTVmCnQcuSDCkUNCb4kqKBBeO8CAdD8RwQkrWQbGr0=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1113) id 218Bk0T0030888
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 8 Feb 2022 20:46:01 +0900
From: Shivanand.Kunijadar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com,
        christian.storm@siemens.com
Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp,
        akihiro27.suzuki@toshiba.co.jp
Subject: [isar-cip-core] swupdate: use latest swupdate handler code
Date: Tue,  8 Feb 2022 17:11:01 +0530
X-TSB-HOP2: ON
Message-Id: <20220208114101.22800-1-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 08 Feb 2022 11:45:59.0428 (UTC)
 FILETIME=[70DE8440:01D81CE1]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 08 Feb 2022 11:46:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7582

From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>

Latest swupdate handler supports to update the files with dashes.

This fixes issue [20]:

[20]: https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/20

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 .../swupdate-handler-roundrobin_0.1.bb                          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
index 3a5a51e..90803a3 100644
--- a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
+++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
@@ -13,7 +13,7 @@ inherit dpkg-raw
 PROVIDES = "swupdate-handlers"
 
 SRC_URI += "git://gitlab.com/cip-project/cip-sw-updates/swupdate-handler-roundrobin.git;protocol=https;destsuffix=swupdate-handler-roundrobin;name=swupdate-handler-roundrobin;nobranch=1"
-SRCREV_swupdate-handler-roundrobin ?= "ba4c5ae8e664a9624335753cb152e6e264b3f518"
+SRCREV_swupdate-handler-roundrobin ?= "bf73f04b1eec0b8714d3a1b56bfcd1431c58ba10"
 
 SWUPDATE_LUASCRIPT = "swupdate-handler-roundrobin/swupdate_handlers_roundrobin.lua"
 
-- 
2.20.1



