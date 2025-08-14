Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E37CA0EE4
	for <webhook@archiver.kernel.org>; Thu, 14 Aug 2025 10:31:21 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.19340.1755167475985709373
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Aug 2025 03:31:16 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 57EAVEua730789; Thu, 14 Aug 2025 19:31:14 +0900
X-Iguazu-Qid: 2yAbuzQy5p7TEXMbOy
X-Iguazu-QSIG: v=2; s=0; t=1755167473; q=2yAbuzQy5p7TEXMbOy; m=g+wkpo1TNRxWkY55eByLt5WM91Dfp6FRsWlSzwvcsGU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 57EAVCTI2491330
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 19:31:13 +0900
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v2 4/5] .gitlab-ci.yml: Add linux.efi to previous image folder
Date: Thu, 14 Aug 2025 15:51:14 +0530
X-TSB-HOP2: ON
Message-Id: <20250814102117.2608463-5-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250814102117.2608463-1-Shivanand.Kunijadar@toshiba-tsip.com>
References: <20250814102117.2608463-1-Shivanand.Kunijadar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 14 Aug 2025 10:31:07.0491 (UTC) FILETIME=[8B749330:01DC0D06]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Aug 2025 10:31:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19746

The CI creates rdiff based SWUpdate images by default, so add previous
images kernel file in the previous image folder as well along with
rootfs.

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 .gitlab-ci.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index d1b21f5..7f0f450 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -81,6 +81,7 @@ default:
           else
               cp build/tmp/deploy/images/${target}/*.squashfs build/previous-image;
           fi;
+          cp build/tmp/deploy/images/${target}/linux.efi build/previous-image;
           echo "PV = \"2.0\"" >> recipes-core/images/cip-core-image-security.bb;
           kas build ${base_yaml}:kas/opt/delta-update.yml;
           scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_COMMIT_REF_SLUG} swu;
-- 
2.39.5



