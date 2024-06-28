Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5419C2BBCA
	for <webhook@archiver.kernel.org>; Fri, 28 Jun 2024 04:38:33 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.10123.1719549510258787608
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Jun 2024 21:38:30 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 45S4cSSH3305162; Fri, 28 Jun 2024 13:38:28 +0900
X-Iguazu-Qid: 2yAaTpjblSkZuuPTfi
X-Iguazu-QSIG: v=2; s=0; t=1719549507; q=2yAaTpjblSkZuuPTfi; m=et51F00xoK+BEFmJ3WEJwCA8Et8BA5Jzge5qq8SC6cE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 45S4cQcJ3491877
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 13:38:27 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core] submit_lava.sh: Rectify condition to push results to relevant projects in SQUAD.
Date: Fri, 28 Jun 2024 10:08:27 +0530
X-TSB-HOP2: ON
Message-Id: <20240628043827.3608797-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 28 Jun 2024 04:38:25.0459 (UTC) FILETIME=[03B5C030:01DAC915]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Jun 2024 04:38:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16340

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

This commit makes kernel-panic, initramfs-crash rollback test results available
under swupdate project in CIP SQUAD.

Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
---
 scripts/submit_lava.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
index ee8dd37..4b1b671 100755
--- a/scripts/submit_lava.sh
+++ b/scripts/submit_lava.sh
@@ -103,12 +103,15 @@ submit_squad_watch_job(){
 		return 0
 	fi
 
-	if [ "$TEST" = "swupdate" ]; then
+	if [ "$TEST" = "swupdate" ] || [ "$TEST" = "kernel-panic" ] || [ "$TEST" = "initramfs-crash" ]; then
 		squad_project="swupdate-testing"
 	elif [ "$TEST" = "secure-boot" ]; then
 		squad_project="secure-boot-testing"
-	else
+	elif [ "$TEST" = "IEC" ]; then
 		squad_project="iec-layer-testing"
+	else
+		echo "Unable to host results in available CIP Core SQUAD projects"
+		return 1
 	fi
 
 	local DEVICE=$2
-- 
2.30.2



