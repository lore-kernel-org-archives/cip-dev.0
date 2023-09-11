Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518D3EE57DF
	for <webhook@archiver.kernel.org>; Mon, 11 Sep 2023 13:32:01 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.58428.1694439114834215172
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Sep 2023 06:31:55 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 38BDVqne3930806; Mon, 11 Sep 2023 22:31:52 +0900
X-Iguazu-Qid: 2rWgyA9ooqJgITHMAr
X-Iguazu-QSIG: v=2; s=0; t=1694439112; q=2rWgyA9ooqJgITHMAr; m=6F7U3Er/e8a6R852hqBoxrOWLKy+SZrp3CgQQjBLfeY=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 38BDVpOY3612992
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 11 Sep 2023 22:31:51 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 5/5] scripts/repro-tests.sh: Add *wic.p0 image into reproducible tests
Date: Mon, 11 Sep 2023 19:01:47 +0530
X-TSB-HOP2: ON
Message-Id: <20230911133147.3164-6-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230911133147.3164-1-venkata.pyla@toshiba-tsip.com>
References: <20230911133147.3164-1-venkata.pyla@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 11 Sep 2023 13:31:47.0067 (UTC) FILETIME=[4FF25CB0:01D9E4B4]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Sep 2023 13:32:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13023

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

BBB disk image contains raw partitions that creates as *.wic.p0, so add
them to reproducible tests.

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 scripts/repro-tests.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/repro-tests.sh b/scripts/repro-tests.sh
index 2143058..127484f 100755
--- a/scripts/repro-tests.sh
+++ b/scripts/repro-tests.sh
@@ -74,6 +74,7 @@ fi
 
 # Define files in the artifacts for checking the reproducibility
 set -- \
+	"${IMAGE_BASE}-${RELEASE}-${TARGET}.wic.p0" \
 	"${IMAGE_BASE}-${RELEASE}-${TARGET}.wic.p1" \
 	"${IMAGE_BASE}-${RELEASE}-${TARGET}.wic.p2" \
 	"${IMAGE_BASE}-${RELEASE}-${TARGET}.wic.p3" \
@@ -86,8 +87,8 @@ set -- \
 res=0
 for file in "$@"; do
 	if [ -f "${artifacts1}/${file}" ] && [ -f "${artifacts2}/${file}" ]; then
-		label=$(blkid -s LABEL -o value ${artifacts1}/${file})
-		fstype=$(blkid -s TYPE -o value ${artifacts1}/${file})
+		label=$(blkid -s LABEL -o value ${artifacts1}/${file} || true)
+		fstype=$(blkid -s TYPE -o value ${artifacts1}/${file} || true)
 		if $DIFFOSCOPE --text "${file}.diffoscope_output.txt" \
 			--html-dir diffoscope_output \
 			--html "${file}.diffoscope_output.html" \
-- 
2.20.1



