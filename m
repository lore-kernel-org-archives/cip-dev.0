Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF6BC04FFE
	for <webhook@archiver.kernel.org>; Fri, 17 May 2024 09:18:33 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.35697.1715937506463186858
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 May 2024 02:18:27 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 44H9IOYp2310385; Fri, 17 May 2024 18:18:24 +0900
X-Iguazu-Qid: 2rWhclmqRWz677Sott
X-Iguazu-QSIG: v=2; s=0; t=1715937504; q=2rWhclmqRWz677Sott; m=/LuAqBkPznp5wSAQJFnbH4vwcuIGD1+Ji7xsFSqqXH4=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1121) id 44H9INAg1225412
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 May 2024 18:18:24 +0900
From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, adithya.balakumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v1] .gitlab-ci.yml: Build for delta update when build_swu_v2 is enabled
Date: Fri, 17 May 2024 14:48:34 +0530
X-TSB-HOP2: ON
Message-Id: <20240517091834.1398975-1-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 17 May 2024 09:18:21.0669 (UTC) FILETIME=[29AE8150:01DAA83B]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 May 2024 09:18:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15910

Build for delta update when build_swu_v2 is enabled in the CI

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 .gitlab-ci.yml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index aab55be..2f88dea 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -70,8 +70,14 @@ default:
     - kas build ${base_yaml}
     - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG} wic; fi
     - if [ "${build_swu_v2}" = "enable" ]; then
+          mkdir build/previous-image;
+          if [ "${extension}" = "security" ] || [ "${extension}" = "ebg-secure-boot-snakeoil" ]; then
+              cp build/tmp/deploy/images/${target}/*.verity build/previous-image;
+          else
+              cp build/tmp/deploy/images/${target}/*.squashfs build/previous-image;
+          fi;
           echo "PV = \"2.0\"" >> recipes-core/images/cip-core-image-security.bb;
-          kas build ${base_yaml};
+          kas build ${base_yaml}:kas/opt/delta-update.yml;
           scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG} swu;
       fi
     - if [ "${deploy_kernelci}" = "enable" ]; then scripts/deploy-kernelci.py ${release} ${target} ${extension} ${dtb}; fi
-- 
2.39.2



