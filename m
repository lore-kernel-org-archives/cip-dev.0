Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E130C61DA4
	for <webhook@archiver.kernel.org>; Mon,  6 Feb 2023 12:17:44 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web11.51856.1675685857449598969
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Feb 2023 04:17:38 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.155, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 316CHYcA023490; Mon, 6 Feb 2023 21:17:35 +0900
X-Iguazu-Qid: 34tKr4VoBbrsR7WPR2
X-Iguazu-QSIG: v=2; s=0; t=1675685854; q=34tKr4VoBbrsR7WPR2; m=PKuUFLLwCLNPbcm5Nuo1hfJOI4XrwdPZ6S8W9nRmlYM=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1513) id 316CHX1h013220
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 6 Feb 2023 21:17:34 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core] generate_rb_kas_file.sh: Add script to generate rb.yml
Date: Mon,  6 Feb 2023 17:47:47 +0530
X-TSB-HOP2: ON
Message-Id: <20230206121747.1633-1-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 06 Feb 2023 12:17:32.0674 (UTC) FILETIME=[FD482E20:01D93A24]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Feb 2023 12:17:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10598

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

This script helps to generate kas file on the fly for reproducible
builds that includes latest value of SOURCE_DATE_EPOCH value.

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 scripts/generate_rb_kas_file.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100755 scripts/generate_rb_kas_file.sh

diff --git a/scripts/generate_rb_kas_file.sh b/scripts/generate_rb_kas_file.sh
new file mode 100755
index 0000000..cf0b030
--- /dev/null
+++ b/scripts/generate_rb_kas_file.sh
@@ -0,0 +1,17 @@
+#!/bin/bash
+
+# Generates kas file on the fly for reproducible builds with the
+# SOURCE_DATE_EPOCH value
+
+
+source_date_epoch=${SOURCE_DATE_EPOCH:-$(git log -1 --pretty=%ct)}
+
+cat <<EOT > rb.yml
+header:
+  version: 12
+
+local_conf_header:
+  reproducible-builds: |
+    SOURCE_DATE_EPOCH = "$source_date_epoch"
+EOT
+
-- 
2.20.1



