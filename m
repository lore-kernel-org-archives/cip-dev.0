Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D69C61D92
	for <webhook@archiver.kernel.org>; Wed, 22 Nov 2023 07:01:35 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.13996.1700636490162519672
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Nov 2023 23:01:30 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 3AM71SCU2306656; Wed, 22 Nov 2023 16:01:28 +0900
X-Iguazu-Qid: 2yAaLcf4ODe1IlQeY4
X-Iguazu-QSIG: v=2; s=0; t=1700636488; q=2yAaLcf4ODe1IlQeY4; m=iKE85ISlhpgGwLcOxU5CCUNO3oVbLSeywMmUNCu/uwU=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 3AM71RCM889045
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 22 Nov 2023 16:01:28 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v1 3/3] scripts/run-cve-checks.sh: Add script to generate CVE report
Date: Wed, 22 Nov 2023 12:31:21 +0530
X-TSB-HOP2: ON
Message-Id: <20231122070121.326276-4-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231122070121.326276-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20231122070121.326276-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 22 Nov 2023 07:01:21.0404 (UTC) FILETIME=[B2E7DBC0:01DA1D11]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Nov 2023 07:01:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13610

From: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>

This script will extract latest dpkg-status files for all the deployed
targets and generate their CVE reports using the cve_checker.py script in
[1] and these report shall be uploaded back to cve-reports sub-directory
under cip-project.org in the s3 bucket.

[1] https://gitlab.com/cip-playground/debian-cve-checker

Signed-off-by: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
---
 scripts/run-cve-checks.sh | 40 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100755 scripts/run-cve-checks.sh

diff --git a/scripts/run-cve-checks.sh b/scripts/run-cve-checks.sh
new file mode 100755
index 0000000..a655151
--- /dev/null
+++ b/scripts/run-cve-checks.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Toshiba Corp., 2020
+#
+# Authors:
+#  Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
+#
+# SPDX-License-Identifier: MIT
+#
+
+# This script is used in .gitlab-ci.yml to create
+# CVE reports in CSV format for each build target.
+# It uses the dpkg status files generated during
+# the build stages and saved as gitlab-ci artifacts.
+
+set -e
+
+# Install AWS CLI
+if ! which aws 2>&1 >/dev/null; then
+	echo "Installing awscli..."
+	apt update
+	apt install -y python3-wheel
+	apt install -y awscli
+fi
+
+# Retrieve the latest dpkg status files from AWS
+aws s3 cp --no-progress --recursive s3://download.cip-project.org/cip-core/cve-checks/dpkg-status/ ./
+
+# Create new CVE reports
+mkdir cve-reports
+for i in *.dpkg_status; do
+	echo "Checking $i"
+	filename=${i%.dpkg_status}
+	cve_checker.py --status $i --output ./cve-reports/$filename.csv
+done
+
+# Synchronize the CVE reports to AWS (it will delete old reports)
+aws s3 sync --no-progress --delete --acl public-read cve-reports s3://download.cip-project.org/cip-core/cve-checks/cve-reports
-- 
2.30.2



