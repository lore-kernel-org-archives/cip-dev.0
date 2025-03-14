Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB8BC28B2F
	for <webhook@archiver.kernel.org>; Fri, 14 Mar 2025 06:06:52 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.7387.1741932411076826075
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Mar 2025 23:06:51 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 52E66moR2470790; Fri, 14 Mar 2025 15:06:48 +0900
X-Iguazu-Qid: 2rWhBFYKJX2WuiAOoQ
X-Iguazu-QSIG: v=2; s=0; t=1741932407; q=2rWhBFYKJX2WuiAOoQ; m=bxJlsX8N6GxLXFPRuDKmY8ICCJRVYoVM7t9FQzeAdSA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 52E66kTp4043471
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 15:06:47 +0900
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v1] .reproducible-check-ci.yml: Add x86-uefi target for reproducibility test
Date: Fri, 14 Mar 2025 02:14:21 -0400
X-TSB-HOP2: ON
Message-Id: <20250314061421.2146773-1-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 14 Mar 2025 06:06:44.0801 (UTC) FILETIME=[435A6B10:01DB94A7]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Mar 2025 06:06:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18200

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

Current weekly reproducibility test has more virtual targets (QEMU) than
physical targets (currently only BBB). Lets add x86-uefi as well since
its supposed to be common target for all x86 based devices.

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 .reproducible-check-ci.yml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
index 7bf1ac6..7dc4b60 100644
--- a/.reproducible-check-ci.yml
+++ b/.reproducible-check-ci.yml
@@ -96,6 +96,12 @@ build:bbb-repro-build:
     target: bbb
     extension: "none"
 
+build:x86-uefi-repro-build:
+  extends:
+    - .repro-build
+  variables:
+    target: x86-uefi
+
 # repro build test
 test:qemu-amd64-repro-test:
   extends:
@@ -129,3 +135,11 @@ test:bbb-repro-test:
     extension: "none"
   dependencies:
     - build:bbb-repro-build
+
+test:x86-uefi-repro-test:
+  extends:
+    - .repro-test
+  variables:
+    target: x86-uefi
+  dependencies:
+    - build:x86-uefi-repro-build
-- 
2.39.5



