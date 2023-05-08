Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570D9C77B7F
	for <webhook@archiver.kernel.org>; Mon,  8 May 2023 09:56:08 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web10.103453.1683539759097997825
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 May 2023 02:56:00 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.155, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 3489tu4b006591; Mon, 8 May 2023 18:55:56 +0900
X-Iguazu-Qid: 34trEg1Q838d6eHlcc
X-Iguazu-QSIG: v=2; s=0; t=1683539755; q=34trEg1Q838d6eHlcc; m=HYsEIzRCkZWiJulUmGIBoxoQfnMX/96e4+LllXkSlGE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1510) id 3489tsfR039409
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 8 May 2023 18:55:55 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, nobuhiro1.iwamatsu@toshiba.co.jp
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>, dinesh.kumar@toshiba-tsip.com
Subject: [cip-kernel-config] 5.10.y-cip/arm64: qemu: Add nftable configs
Date: Mon,  8 May 2023 15:25:51 +0530
X-TSB-HOP2: ON
Message-Id: <20230508095551.8237-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 08 May 2023 09:55:53.0693 (UTC) FILETIME=[4715D8D0:01D98193]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 May 2023 09:56:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11414

From: Sai <Sai.Sathujoda@toshiba-tsip.com>

These kernel configs are required for nftables package to work
which is used for IEC-62443-4-2 evaluation

Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
---
 5.10.y-cip/arm64/qemu_arm64_defconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/5.10.y-cip/arm64/qemu_arm64_defconfig b/5.10.y-cip/arm64/qemu_arm64_defconfig
index f7ac60f..529baa8 100644
--- a/5.10.y-cip/arm64/qemu_arm64_defconfig
+++ b/5.10.y-cip/arm64/qemu_arm64_defconfig
@@ -70,6 +70,17 @@ CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
 CONFIG_NETFILTER_XT_TARGET_LOG=m
 CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
 CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
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
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
-- 
2.20.1



