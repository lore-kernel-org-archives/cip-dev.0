Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67711EB64DA
	for <webhook@archiver.kernel.org>; Mon, 10 Jul 2023 05:58:28 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.33785.1688968697606937830
 for <cip-dev@lists.cip-project.org>;
 Sun, 09 Jul 2023 22:58:18 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 36A5wF5h1688401; Mon, 10 Jul 2023 14:58:15 +0900
X-Iguazu-Qid: 2yAb9zVTfL5SneASfL
X-Iguazu-QSIG: v=2; s=0; t=1688968694; q=2yAb9zVTfL5SneASfL; m=OytzIkn5wwYbUq5sljKtjO4wC1lgxRmD9yg/EzTYx3M=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 36A5wDZK200259
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 10 Jul 2023 14:58:14 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, nobuhiro1.iwamatsu@toshiba.co.jp
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [cip-kernel-config] 6.1.y-cip/arm/qemu_arm_defconfig: Add audit and nftables configs
Date: Mon, 10 Jul 2023 11:28:09 +0530
X-TSB-HOP2: ON
Message-Id: <20230710055809.10197-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 10 Jul 2023 05:58:11.0739 (UTC) FILETIME=[82529EB0:01D9B2F3]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jul 2023 05:58:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12287

From: Sai <Sai.Sathujoda@toshiba-tsip.com>

These kernel configs are required for nftables and auditd package
to work which is used for IEC-62443-4-2 evaluation.

Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
---
 6.1.y-cip/arm/qemu_arm_defconfig | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/6.1.y-cip/arm/qemu_arm_defconfig b/6.1.y-cip/arm/qemu_arm_defconfig
index 946bcc9..ad11ce6 100644
--- a/6.1.y-cip/arm/qemu_arm_defconfig
+++ b/6.1.y-cip/arm/qemu_arm_defconfig
@@ -34,6 +34,25 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_IP_PNP_RARP=y
+CONFIG_AUDIT=y
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
+CONFIG_NETFILTER=y
+CONFIG_IP_NF_IPTABLES=m
+CONFIG_IP6_NF_IPTABLES=m
+CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
+CONFIG_NETFILTER_XT_TARGET_LOG=m
+CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
+CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
 CONFIG_NETWORK_PHY_TIMESTAMPING=y
 CONFIG_VLAN_8021Q=y
 CONFIG_VLAN_8021Q_GVRP=y
-- 
2.20.1



