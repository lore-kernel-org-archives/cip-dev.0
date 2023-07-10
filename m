Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254C3EB64D9
	for <webhook@archiver.kernel.org>; Mon, 10 Jul 2023 04:51:18 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.33008.1688964673619326522
 for <cip-dev@lists.cip-project.org>;
 Sun, 09 Jul 2023 21:51:14 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 36A4pBte1277845; Mon, 10 Jul 2023 13:51:11 +0900
X-Iguazu-Qid: 2rWhDvohsOqsuef4DL
X-Iguazu-QSIG: v=2; s=0; t=1688964671; q=2rWhDvohsOqsuef4DL; m=PWWIvCztZo4Egpgn4Q0ZYUmM92Qz6FDT2UER6WvDTKk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 36A4pAIL4077408
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 10 Jul 2023 13:51:11 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, nobuhiro1.iwamatsu@toshiba.co.jp
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [cip-kernel-config] 6.1.y-cip/arm64/qemu_arm64_defconfig: Add nftables configs
Date: Mon, 10 Jul 2023 10:21:06 +0530
X-TSB-HOP2: ON
Message-Id: <20230710045106.4117-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 10 Jul 2023 04:51:09.0248 (UTC) FILETIME=[24BB3400:01D9B2EA]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jul 2023 04:51:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12286

From: Sai <Sai.Sathujoda@toshiba-tsip.com>

These kernel configs are required for nftables package to work
which is used for IEC-62443-4-2 evaluation.

Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
---
 6.1.y-cip/arm64/qemu_arm64_defconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/6.1.y-cip/arm64/qemu_arm64_defconfig b/6.1.y-cip/arm64/qemu_arm64_defconfig
index bf1713e..087dd34 100644
--- a/6.1.y-cip/arm64/qemu_arm64_defconfig
+++ b/6.1.y-cip/arm64/qemu_arm64_defconfig
@@ -59,6 +59,17 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_IPV6=m
+CONFIG_NETFILTER_NETLINK=m
+CONFIG_NF_LOG_COMMON=m
+CONFIG_NF_NAT=m
+CONFIG_NF_TABLES=m
+CONFIG_NF_TABLES_INET=y
+CONFIG_NF_TABLES_NETDEV=y
+CONFIG_NFT_CT=m
+CONFIG_NFT_COUNTER=m
+CONFIG_NFT_LOG=m
+CONFIG_NFT_LIMIT=m
+CONFIG_NFT_NAT=m
 CONFIG_NETFILTER=y
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_EVENTS=y
-- 
2.20.1



