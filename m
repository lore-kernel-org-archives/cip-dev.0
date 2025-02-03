Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0141EC02197
	for <webhook@archiver.kernel.org>; Mon,  3 Feb 2025 11:56:49 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.86148.1738583800507615225
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Feb 2025 03:56:40 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 513BucqN3465046; Mon, 3 Feb 2025 20:56:38 +0900
X-Iguazu-Qid: 2yAbJ3LJ1krAf8m2nz
X-Iguazu-QSIG: v=2; s=0; t=1738583798; q=2yAbJ3LJ1krAf8m2nz; m=DahRd9zvzAI9XhZS91MRLaxQixZ+mph+ewrkI9RV4gU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 513Bubxe840173
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 3 Feb 2025 20:56:38 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v1 1/3] security.yml: Set new LTP installation path in case of security target.
Date: Mon,  3 Feb 2025 17:23:19 +0530
X-TSB-HOP2: ON
Message-Id: <20250203115321.3589084-2-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250203115321.3589084-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20250203115321.3589084-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 03 Feb 2025 11:56:34.0728 (UTC) FILETIME=[AC36DA80:01DB7632]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Feb 2025 11:56:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17727

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

Due to read-only rootfs of security image, LTP tests cannot be executed
because the runltp tool expects the install path as working directory and
this creates issues with "/opt/ltp" as install path.

So in case of security image, the LTP installation path is configured
to be "/home/ltp"

Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
---
 kas/opt/security.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kas/opt/security.yml b/kas/opt/security.yml
index 4aa40e0..974b756 100644
--- a/kas/opt/security.yml
+++ b/kas/opt/security.yml
@@ -26,3 +26,5 @@ local_conf_header:
     VERITY_IMAGE_RECIPE = "cip-core-image-security"
   security-override: |
     OVERRIDES .= ":security"
+  change_ltp_path: |
+    LTP_INSTALL_PATH = "/home/ltp"
-- 
2.30.2



