Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CE0C433F5
	for <webhook@archiver.kernel.org>; Mon, 10 Oct 2022 07:02:42 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web11.3501.1665385360654024061
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Oct 2022 00:02:41 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.153,
 mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 29A72cba030985;
 Mon, 10 Oct 2022 16:02:38 +0900
X-Iguazu-Qid: 34trtLOdcrWwh3fQu2
X-Iguazu-QSIG: v=2; s=0; t=1665385358; q=34trtLOdcrWwh3fQu2;
 m=oCPC4gh5Dol9cn8hPNG3gXoeIcHcru0SP4r2qYBo5Hs=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1510) id 29A72bDv022705
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 10 Oct 2022 16:02:38 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 1/3] start-qemu.sh : Set bullseye as default DISTRO
 RELEASE
Date: Mon, 10 Oct 2022 12:32:30 +0530
X-TSB-HOP2: ON
Message-Id: <20221010070232.10478-2-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221010070232.10478-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20221010070232.10478-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 10 Oct 2022 07:02:34.0482 (UTC)
 FILETIME=[45ECAD20:01D8DC76]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Oct 2022 07:02:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9703

From: Sai <Sai.Sathujoda@toshiba-tsip.com>

Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
---
 start-qemu.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index bcc7a51..639951e 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -31,10 +31,10 @@ if [ -n "${QEMU_PATH}" ]; then
 fi
 
 if [ -z "${DISTRO_RELEASE}" ]; then
-	if grep -s -q "DEBIAN_BULLSEYE: true" .config.yaml; then
-		DISTRO_RELEASE="bullseye"
-	else
+	if grep -s -q "DEBIAN_BUSTER: true" .config.yaml; then
 		DISTRO_RELEASE="buster"
+	else
+		DISTRO_RELEASE="bullseye"
 	fi
 fi
 
-- 
2.20.1



