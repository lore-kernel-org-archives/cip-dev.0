Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8788FC52D7C
	for <webhook@archiver.kernel.org>; Mon, 12 Aug 2024 07:04:22 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.40580.1723446252559063554
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Aug 2024 00:04:12 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 47C74AAp1597552; Mon, 12 Aug 2024 16:04:10 +0900
X-Iguazu-Qid: 2rWgxxkZ67aDU4coF6
X-Iguazu-QSIG: v=2; s=0; t=1723446250; q=2rWgxxkZ67aDU4coF6; m=jjwvn7aUr4Q0HvuYK3ZxU3vrtqF8a4mFGJHUgp6dwhk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 47C7493Z2719234
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 16:04:09 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 2/3] scripts/deploy-cip-core.sh: Include release name in dpkg status filename
Date: Mon, 12 Aug 2024 12:33:02 +0530
X-TSB-HOP2: ON
Message-Id: <20240812070303.1206167-3-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240812070303.1206167-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20240812070303.1206167-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 12 Aug 2024 07:04:06.0890 (UTC) FILETIME=[D29904A0:01DAEC85]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 Aug 2024 07:04:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16771

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



