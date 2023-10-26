Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BEDC25B48
	for <webhook@archiver.kernel.org>; Thu, 26 Oct 2023 08:30:05 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.65831.1698309003929957156
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Oct 2023 01:30:04 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 39Q8U2eM2297535; Thu, 26 Oct 2023 17:30:02 +0900
X-Iguazu-Qid: 2rWgM08FfFLr31Pvxk
X-Iguazu-QSIG: v=2; s=0; t=1698309001; q=2rWgM08FfFLr31Pvxk; m=Gsu4fzTbgSeSO/9zEDBBBrG4DOD+AaHpjCXnZDyYmFY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 39Q8U0XL3478364
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 26 Oct 2023 17:30:01 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v2 1/3] reproducible-check-ci: Include swu files in reproducible tests
Date: Thu, 26 Oct 2023 13:59:57 +0530
X-TSB-HOP2: ON
Message-Id: <20231026082959.16939-2-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <92324ead-e15c-48fd-876c-41398d15a956@siemens.com>
References: <92324ead-e15c-48fd-876c-41398d15a956@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 26 Oct 2023 08:29:57.0873 (UTC) FILETIME=[9A9D6610:01DA07E6]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Oct 2023 08:30:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13458

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



