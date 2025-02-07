Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67726C0219E
	for <webhook@archiver.kernel.org>; Fri,  7 Feb 2025 15:08:03 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.71587.1738940880491971498
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Feb 2025 07:08:00 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 517F7wJJ676115; Sat, 8 Feb 2025 00:07:58 +0900
X-Iguazu-Qid: 2yAbj3N9XbBEzx3JJa
X-Iguazu-QSIG: v=2; s=0; t=1738940878; q=2yAbj3N9XbBEzx3JJa; m=ykaFbsxFUFSrUhWtcnBZ+JS6ynDv2nCwveusy3dCThA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 517F7vF41285162
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 8 Feb 2025 00:07:58 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v1 4/5] .gitlab-ci.yml: Enable building v2 x86-uefi target to deploy its swupdate artifact
Date: Fri,  7 Feb 2025 20:34:38 +0530
X-TSB-HOP2: ON
Message-Id: <20250207150439.392479-5-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250207150439.392479-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20250207150439.392479-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 07 Feb 2025 15:07:53.0032 (UTC) FILETIME=[0F780C80:01DB7972]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Feb 2025 15:08:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17774

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
---
 .gitlab-ci.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 0459604..2e3054c 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -231,6 +231,7 @@ build:x86-uefi-secure-boot:
     targz: disable
     watchdog: disable
     security_test: enable
+    build_swu_v2: enable
 
 build:qemu-amd64-swupdate:
   extends:
-- 
2.30.2



