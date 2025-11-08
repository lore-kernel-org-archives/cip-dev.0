Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00069CCFA1A
	for <webhook@archiver.kernel.org>; Sat,  8 Nov 2025 11:02:06 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3430.1762599719178796395
 for <cip-dev@lists.cip-project.org>;
 Sat, 08 Nov 2025 03:01:59 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 5A8B1wM64068180; Sat, 8 Nov 2025 20:01:58 +0900
X-Iguazu-Qid: 2yAaYMbrhLMLumMb7i
X-Iguazu-QSIG: v=2; s=0; t=1762599717; q=2yAaYMbrhLMLumMb7i; m=KfwyS0XlkUP1xYwKp1L3fAP0tOLUNepchO+19bLQyQw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4d3Y0P5XhtzyPQ; Sat,  8 Nov 2025 20:01:57 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp, akunuri.sahithi@toshiba-tsip.com
Subject: [isar-cip-core][PATCH v1 3/3] .gitlab-ci.yml: Update variables to stay consistent with changes in deploy-cip-core.sh
Date: Sat,  8 Nov 2025 06:15:17 -0500
X-TSB-HOP2: ON
Message-Id: <20251108111517.752691-4-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251108111517.752691-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20251108111517.752691-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 08 Nov 2025 11:01:54.0125 (UTC) FILETIME=[17A90FD0:01DC509F]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 08 Nov 2025 11:02:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20480

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

New variables related to RB are introduced in deploy-cip-core.sh, let's
update the invokation of the script to stay consistent.

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 .gitlab-ci.yml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index c5bf613..5e510d3 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -28,6 +28,8 @@ variables:
   separate_home_partition: disable
   factory_reset: disable
   no_kernel: disable
+  rb_test: disable
+  rb_build_num: none
 
 stages:
   - build
@@ -74,7 +76,7 @@ default:
     - if [ "${no_kernel}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/no_kernel.yml"; fi
     - echo "Building ${base_yaml}"
     - kas build ${base_yaml}
-    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_COMMIT_REF_SLUG} wic; fi
+    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_COMMIT_REF_SLUG} ${rb_test} ${rb_build_num} wic; fi
     - if [ "${build_swu_v2}" = "enable" ]; then
           mkdir build/previous-image;
           if [ "${extension}" = "security" ] || [ "${extension}" = "ebg-secure-boot-snakeoil" ]; then
@@ -85,7 +87,7 @@ default:
           cp build/tmp/deploy/images/${target}/linux.efi build/previous-image;
           echo "PV = \"2.0\"" >> recipes-core/images/cip-core-image-security.bb;
           kas build ${base_yaml}:kas/opt/delta-update.yml;
-          scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_COMMIT_REF_SLUG} swu;
+          scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_COMMIT_REF_SLUG} ${rb_test} ${rb_build_num} swu;
       fi
     - if [ "${deploy_kernelci}" = "enable" ]; then scripts/deploy-kernelci.py ${release} ${target} ${extension} ${dtb}; fi
 
-- 
2.39.5



