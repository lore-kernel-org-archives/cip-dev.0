Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23631C5AC67
	for <webhook@archiver.kernel.org>; Tue, 11 Aug 2026 09:18:06 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.50430.1786439879039147178
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Aug 2026 02:17:59 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 67B9HvWF1790783; Tue, 11 Aug 2026 18:17:57 +0900
X-Iguazu-Qid: 2yAbqIO4MG3D1OfIrA
X-Iguazu-QSIG: v=2; s=1; t=1786439877; q=2yAbqIO4MG3D1OfIrA; m=OpuwyVHgLrFWRXs6Yb4gwFGKp0og+yEkOp4XHh6sCUY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hK5d11MVVzyPQ; Tue, 11 Aug 2026 18:17:56 +0900 (JST)
From: Shivanand.Kunijadar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
        kumar.dinesh.h95@mail.toshiba, kazuhiro.hayashi.f74@mail.toshiba
Subject: [isar-cip-core][PATCH v3 1/3] .gitlab-cip.yml: Change CI variable to CI_RUN_UNSTABLE
Date: Tue, 11 Aug 2026 14:34:19 +0530
X-TSB-HOP2: ON
Message-Id: <20260811090421.3547180-2-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260811090421.3547180-1-Shivanand.Kunijadar@toshiba-tsip.com>
References: <20260811090421.3547180-1-Shivanand.Kunijadar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 11 Aug 2026 09:17:53.0739 (UTC) FILETIME=[4A1CB9B0:01DD2972]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Aug 2026 09:18:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23893

From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>

It is better to keep just UNSTABLE which helps in case of forky as well.

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 .gitlab-ci.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index b53def4..480ad3d 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -355,7 +355,7 @@ build:qemu-amd64-secure-boot-buster:
   rules:
     - if: $CI_COMMIT_TAG
       when: never
-    - if: '$CI_PIPELINE_SOURCE == "schedule" && $CI_RUN_UNSTABLE_SID'
+    - if: '$CI_PIPELINE_SOURCE == "schedule" && $CI_RUN_UNSTABLE'
     - if: $CI_COMMIT_BRANCH != "master"
       when: never
   allow_failure: true
@@ -730,7 +730,7 @@ test:qemu-arm-swupdate-apply-same-image-swu:
   rules:
     - if: $CI_COMMIT_TAG
       when: never
-    - if: '$CI_PIPELINE_SOURCE == "schedule" && $CI_RUN_UNSTABLE_SID'
+    - if: '$CI_PIPELINE_SOURCE == "schedule" && $CI_RUN_UNSTABLE'
     - if: $CI_COMMIT_BRANCH != "master"
       when: never
   allow_failure: true
-- 
2.39.5



