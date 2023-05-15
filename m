Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADD6C7EE22
	for <webhook@archiver.kernel.org>; Mon, 15 May 2023 12:12:52 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web11.86577.1684152766599091370
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 May 2023 05:12:47 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.155, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 34FCChPH032251; Mon, 15 May 2023 21:12:44 +0900
X-Iguazu-Qid: 34trY2IxVcFEVR539U
X-Iguazu-QSIG: v=2; s=0; t=1684152763; q=34trY2IxVcFEVR539U; m=izLdw7S1iFPS8wd9I1CEIhnHWoOcnN7btYIrgpjiryg=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1510) id 34FCCgtj024696
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 15 May 2023 21:12:43 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, nobuhiro1.iwamatsu@toshiba.co.jp
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>, dinesh.kumar@toshiba-tsip.com
Subject: [cip-kernel-config] 5.10.y-cip/arm : Add audit and nftables configs
Date: Mon, 15 May 2023 17:42:38 +0530
X-TSB-HOP2: ON
Message-Id: <20230515121238.14356-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 15 May 2023 12:12:41.0126 (UTC) FILETIME=[8BFCFC60:01D98726]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 May 2023 12:12:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11453

From: Sai <Sai.Sathujoda@toshiba-tsip.com>

These kernel configs are required for nftables and auditd package
to work which is used for IEC-62443-4-2 evaluation.

Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
---
 5.10.y-cip/arm/qemu_arm_defconfig | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/5.10.y-cip/arm/qemu_arm_defconfig b/5.10.y-cip/arm/qemu_arm_defconfig
index 58ca273..4cb1344 100644
--- a/5.10.y-cip/arm/qemu_arm_defconfig
+++ b/5.10.y-cip/arm/qemu_arm_defconfig
@@ -1,5 +1,6 @@
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
+CONFIG_AUDIT=y
 CONFIG_USELIB=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
@@ -39,6 +40,24 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_IP_PNP_RARP=y
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



