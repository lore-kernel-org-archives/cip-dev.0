Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4632C52D7F
	for <webhook@archiver.kernel.org>; Mon, 12 Aug 2024 11:17:23 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.43894.1723461434369940209
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Aug 2024 04:17:15 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 47CBHCG41860396; Mon, 12 Aug 2024 20:17:12 +0900
X-Iguazu-Qid: 2rWgZF6BSVIE2ffdr6
X-Iguazu-QSIG: v=2; s=0; t=1723461432; q=2rWgZF6BSVIE2ffdr6; m=gtDccMk+BSMMBgPVvPXgqqBay1x621z8l4hVidAnM3E=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 47CBHBss3696334
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 20:17:12 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v2 2/3] scripts/deploy-cip-core.sh: Include release name in dpkg status filename
Date: Mon, 12 Aug 2024 16:46:04 +0530
X-TSB-HOP2: ON
Message-Id: <20240812111605.1246549-3-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240812111605.1246549-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20240812111605.1246549-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 12 Aug 2024 11:17:08.0894 (UTC) FILETIME=[2BC6FBE0:01DAECA9]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 Aug 2024 11:17:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16779

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

This commit includes release name as part of dpkg status filename so that
it can be passed as "--suite" to cve_checker.py script.

Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
---
 scripts/deploy-cip-core.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
index c75f2d1..6e4dfd7 100755
--- a/scripts/deploy-cip-core.sh
+++ b/scripts/deploy-cip-core.sh
@@ -71,4 +71,10 @@ fi
 #     * cve-reports: folder to store the cve-reports generated from the dpkg status files
 #       * they can be linked from the release website
 DPKG_STATUS_FILENAME=${CI_JOB_NAME#build:}.dpkg_status
+
+# As default release name is not included in CI_JOB_NAME, it is appended to dpkg status file name
+# For further use in  run-cve-checks.sh script to get the right suite
+if ! echo "$CI_JOB_NAME" | grep -q "$1"; then
+	DPKG_STATUS_FILENAME=${CI_JOB_NAME#build:}-$1.dpkg_status
+fi
 aws s3 cp --no-progress build/tmp/deploy/images/"$TARGET"/cip-core-image-*.dpkg_status s3://download.cip-project.org/cip-core/cve-checks/dpkg-status/"$DPKG_STATUS_FILENAME"
-- 
2.30.2



