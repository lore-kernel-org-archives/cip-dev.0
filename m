Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB80D2F7FD
	for <webhook@archiver.kernel.org>; Fri,  5 Dec 2025 14:15:51 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6644.1764944143095877285
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Dec 2025 06:15:43 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 5B5EFfdI3238458; Fri, 5 Dec 2025 23:15:41 +0900
X-Iguazu-Qid: 2yAaLE8zsEiiEkYSAK
X-Iguazu-QSIG: v=2; s=0; t=1764944141; q=2yAaLE8zsEiiEkYSAK; m=HQ5zsD0do0G3sInuWwTYS0AY+BrrfmuLWhxQKYPE0bw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dND1T0d9Pz1xnc; Fri,  5 Dec 2025 23:15:40 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp, akunuri.sahithi@toshiba-tsip.com
Subject: [isar-cip-core][PATCH v1 1/3] .reproducible-check-ci.yml: Align with recent changes in deploy-cip-core.sh
Date: Fri,  5 Dec 2025 09:29:25 -0500
X-TSB-HOP2: ON
Message-Id: <20251205142927.4087770-2-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251205142927.4087770-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20251205142927.4087770-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 05 Dec 2025 14:15:37.0923 (UTC) FILETIME=[A1232130:01DC65F1]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Dec 2025 14:15:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20910

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

Align with recent changes from e1c4b6fa (ci: Build and deploy kernel-panic update artifact)

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 .reproducible-check-ci.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
index a545b0d..fb24188 100644
--- a/.reproducible-check-ci.yml
+++ b/.reproducible-check-ci.yml
@@ -29,7 +29,7 @@
           scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_COMMIT_REF_SLUG} ${artifact} ${rb_build_num};
         done;
         if [ "${extension}" != "none" ]; then
-          scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_COMMIT_REF_SLUG} swu ${rb_build_num};
+          scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_COMMIT_REF_SLUG} swus ${rb_build_num};
         fi;
       }
     # Build 1st time
-- 
2.39.5



