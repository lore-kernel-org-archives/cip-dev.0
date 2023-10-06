Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B7EE81DF5
	for <webhook@archiver.kernel.org>; Fri,  6 Oct 2023 12:58:59 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.11985.1696597130749619777
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Oct 2023 05:58:51 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 396CwmMw3857395; Fri, 6 Oct 2023 21:58:48 +0900
X-Iguazu-Qid: 2rWhdxlJJ1Hcz6OmkU
X-Iguazu-QSIG: v=2; s=0; t=1696597127; q=2rWhdxlJJ1Hcz6OmkU; m=Nmw0yXQrZcVQUbfl+8fCiqW3e8Aekw/gPkIVkxNXNBU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 396CwkeR2362549
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 6 Oct 2023 21:58:47 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 1/2] reproducible-check-ci: Include swu files in reproducible tests
Date: Fri,  6 Oct 2023 18:28:44 +0530
X-TSB-HOP2: ON
Message-Id: <20231006125845.2661-2-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231006125845.2661-1-venkata.pyla@toshiba-tsip.com>
References: <20231006125845.2661-1-venkata.pyla@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 06 Oct 2023 12:58:44.0103 (UTC) FILETIME=[D655D170:01D9F854]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Oct 2023 12:58:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13296

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 .reproducible-check-ci.yml | 1 +
 scripts/repro-tests.sh     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
index 6bcc215..03b4c00 100644
--- a/.reproducible-check-ci.yml
+++ b/.reproducible-check-ci.yml
@@ -43,6 +43,7 @@
     paths:
       - scripts/repro-tests.sh
       - image*/*.wic.p*
+      - image*/*.swu
 
 .repro-test:
   image:
diff --git a/scripts/repro-tests.sh b/scripts/repro-tests.sh
index 127484f..8bdb34b 100755
--- a/scripts/repro-tests.sh
+++ b/scripts/repro-tests.sh
@@ -74,6 +74,7 @@ fi
 
 # Define files in the artifacts for checking the reproducibility
 set -- \
+	"${IMAGE_BASE}-${RELEASE}-${TARGET}.swu" \
 	"${IMAGE_BASE}-${RELEASE}-${TARGET}.wic.p0" \
 	"${IMAGE_BASE}-${RELEASE}-${TARGET}.wic.p1" \
 	"${IMAGE_BASE}-${RELEASE}-${TARGET}.wic.p2" \
-- 
2.20.1



