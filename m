Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB3BC531DD
	for <webhook@archiver.kernel.org>; Mon, 12 Aug 2024 07:04:22 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.40678.1723446252124696545
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Aug 2024 00:04:12 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 47C74AOE1597540; Mon, 12 Aug 2024 16:04:10 +0900
X-Iguazu-Qid: 2rWgipQxjcYlGxZfGc
X-Iguazu-QSIG: v=2; s=0; t=1723446249; q=2rWgipQxjcYlGxZfGc; m=lU1GZDBRxkuLXq5Zj0RYpyqRPcz/Pz+ahP1/Gz76uV8=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 47C748l03069432
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 16:04:09 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 1/3] scripts/run-cve-checks.sh: Extract suite from dpkg status file name
Date: Mon, 12 Aug 2024 12:33:01 +0530
X-TSB-HOP2: ON
Message-Id: <20240812070303.1206167-2-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240812070303.1206167-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20240812070303.1206167-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 12 Aug 2024 07:04:06.0812 (UTC) FILETIME=[D28D1DC0:01DAEC85]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 Aug 2024 07:04:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16770

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

cve_checker.py script in debian-cve-checker repository expects relevant
suite as input which is needed for debsecan tool to list vulnerabilities
of that suite.

Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
---
 scripts/run-cve-checks.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/run-cve-checks.sh b/scripts/run-cve-checks.sh
index 9cebc90..12fd74e 100755
--- a/scripts/run-cve-checks.sh
+++ b/scripts/run-cve-checks.sh
@@ -32,7 +32,8 @@ aws s3 cp --no-progress --recursive s3://download.cip-project.org/cip-core/cve-c
 mkdir cve-reports
 for file in *.dpkg_status; do
 	echo "Checking $file"
-	cve_checker.py --status "$file" --output ./cve-reports/"${file%.dpkg_status}".csv
+	suite=$(echo "${file%.dpkg_status}" | awk -F- '{print $NF}')
+	cve_checker.py --suite "$suite" --status "$file" --output ./cve-reports/"${file%.dpkg_status}".csv
 done
 
 # Synchronize the CVE reports to AWS (it will delete old reports)
-- 
2.30.2



