Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858EFC3DA7F
	for <webhook@archiver.kernel.org>; Mon, 12 Aug 2024 07:04:22 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.40581.1723446253104642129
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Aug 2024 00:04:13 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 47C74Bj02480181; Mon, 12 Aug 2024 16:04:11 +0900
X-Iguazu-Qid: 2yAapsDzCvM7QodTsJ
X-Iguazu-QSIG: v=2; s=0; t=1723446250; q=2yAapsDzCvM7QodTsJ; m=HWzP9TAx597bhhzR9zxNi+W/Qa8j2JZerpSeJ7bRF+I=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 47C749vt738836
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 16:04:10 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 3/3] .gitlab-ci.yml: Update debian-cve-checker image reference and runner tag
Date: Mon, 12 Aug 2024 12:33:03 +0530
X-TSB-HOP2: ON
Message-Id: <20240812070303.1206167-4-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240812070303.1206167-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20240812070303.1206167-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 12 Aug 2024 07:04:06.0968 (UTC) FILETIME=[D2A4EB80:01DAEC85]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 Aug 2024 07:04:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16772

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

This commit updates image reference of debian-cve-checker project.

The reason to change the runner tag to large is because cve-checks job is
being stuck in the middle after generating cve-reports for dpkg status files
of very few targets. This behavior is observed in several attempts.
After changing th tag to large, the job ran successfully in minimal
time.

Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
---
 .gitlab-ci.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index ab1835a..6c92927 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -456,9 +456,9 @@ test:qemu-arm-IEC:
 cve-checks:
   stage: cve-check
   needs: []
-  image: registry.gitlab.com/cip-playground/debian-cve-checker:latest
+  image: registry.gitlab.com/cip-project/cip-core/debian-cve-checker:build-latest
   tags:
-    - small
+    - large
   script:
     - scripts/run-cve-checks.sh
   when: manual
-- 
2.30.2



