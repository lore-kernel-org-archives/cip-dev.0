Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFD8C001B0
	for <webhook@archiver.kernel.org>; Fri,  7 Jul 2023 14:16:10 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.13308.1688739362882775709
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jul 2023 07:16:03 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 367EG1PU1360928; Fri, 7 Jul 2023 23:16:01 +0900
X-Iguazu-Qid: 2rWhoCDaNC2jJvf3Fg
X-Iguazu-QSIG: v=2; s=0; t=1688739361; q=2rWhoCDaNC2jJvf3Fg; m=wARAyfGPHoSvfQNckTFSTNkKyYRCNs4P6BcJXkxbfho=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1121) id 367EG0Kt1303739
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 7 Jul 2023 23:16:01 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v3 7/8] .reproducible-check-ci.yml: Enable reproudicble check on bookworm
Date: Fri,  7 Jul 2023 19:45:49 +0530
X-TSB-HOP2: ON
Message-Id: <20230707141550.27805-8-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <176E5CF032D87010.7887@lists.cip-project.org>
References: <176E5CF032D87010.7887@lists.cip-project.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 07 Jul 2023 14:15:54.0652 (UTC) FILETIME=[8AC445C0:01D9B0DD]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jul 2023 14:16:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12271

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Generating squashfs image reproducibly is enabled from bookworm version.

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 .reproducible-check-ci.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
index 4d38e0a..6782eea 100644
--- a/.reproducible-check-ci.yml
+++ b/.reproducible-check-ci.yml
@@ -19,6 +19,7 @@
     deploy_kernelci: disable
     artifact_suffix: ".tar.gz"
     base_yaml: "kas-cip.yml:kas/board/${target}.yml"
+    release: bookworm
   stage: build
   tags:
     - large
@@ -56,6 +57,7 @@
     - schedules
   variables:
     GIT_STRATEGY: none
+    release: bookworm
   before_script:
     - apt update && DEBIAN_FRONTEND=noninteractive apt install -y diffoscope
   script:
-- 
2.20.1



