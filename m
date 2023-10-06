Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACB6E81DF6
	for <webhook@archiver.kernel.org>; Fri,  6 Oct 2023 12:58:59 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.11986.1696597130804361810
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Oct 2023 05:58:51 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 396Cwmsu3857399; Fri, 6 Oct 2023 21:58:49 +0900
X-Iguazu-Qid: 2rWhnZe9oxh75VdULS
X-Iguazu-QSIG: v=2; s=0; t=1696597127; q=2rWhnZe9oxh75VdULS; m=ii33TW5HvK7sP+bKlh3V47EaS/2jvW+WzN4ykZNLtIw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 396Cwkdc2919007
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 6 Oct 2023 21:58:47 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 2/2] reproducible.yml: Disable signed swupdate in reproducible tests
Date: Fri,  6 Oct 2023 18:28:45 +0530
X-TSB-HOP2: ON
Message-Id: <20231006125845.2661-3-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231006125845.2661-1-venkata.pyla@toshiba-tsip.com>
References: <20231006125845.2661-1-venkata.pyla@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 06 Oct 2023 12:58:44.0181 (UTC) FILETIME=[D661B850:01D9F854]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Oct 2023 12:58:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13297

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

signed artifacts are not reproducible due to fact that the signature
can include some randomness for security reasons, so skip signature
verifications in reproducible tests.

Fixes #80

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 kas/opt/reproducible.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kas/opt/reproducible.yml b/kas/opt/reproducible.yml
index 5d6a896..73dd4d5 100644
--- a/kas/opt/reproducible.yml
+++ b/kas/opt/reproducible.yml
@@ -15,3 +15,4 @@ local_conf_header:
   reproducible-builds: |
     SOURCE_DATE_EPOCH := "${@bb.process.run("git -C ${LAYERDIR_cip-core} log -1 --pretty=%ct | tr -d '\n'")[0]}"
     WIC_DEPLOY_PARTITIONS = "1"
+    SWU_SIGNED = "0"
-- 
2.20.1



