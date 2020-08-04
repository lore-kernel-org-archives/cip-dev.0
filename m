Return-Path: <SRS0=e/12=BO=lists.cip-project.org=bounce+64572+5091+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26943C433E0
	for <cip-dev@archiver.kernel.org>; Tue,  4 Aug 2020 12:58:59 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9793208A9
	for <cip-dev@archiver.kernel.org>; Tue,  4 Aug 2020 12:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="YeB7IBWf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9793208A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toshiba-tsip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5091+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id UxQTYY4521723xz99fLhtODW; Tue, 04 Aug 2020 05:58:57 -0700
X-Received: from peak.toshiba-tesi.com (peak.toshiba-tesi.com [202.56.254.199])
 by mx.groups.io with SMTP id smtpd.web10.4645.1596545936695050163
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Aug 2020 05:58:57 -0700
IronPort-SDR: 1dTpIagyBykIHf0DRvqnOvXW/+xVmMFxfz4z6vg1shKV/tlKOEW/5Shb+2QPod1O3ZqJIolUbe
 j9ApJ3ew3JNw==
X-IronPort-AV: E=Sophos;i="5.75,434,1589221800"; 
   d="scan'208";a="5349121"
X-Received: from unknown (HELO TOSBLRMBX0419.TOSHIBA-TSIP.COM) ([10.116.85.28])
  by peak.toshiba-tesi.com with ESMTP; 04 Aug 2020 19:04:13 +0530
X-Received: from TOSBLRMBX0219.TOSHIBA-TSIP.COM (172.28.80.119) by
 TOSBLRMBX0419.TOSHIBA-TSIP.COM (10.116.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 4 Aug 2020 18:28:36 +0530
X-Received: from pvenkat.TOSHIBA-TSIP.COM (172.28.80.121) by
 TOSBLRMBX0219.TOSHIBA-TSIP.COM (172.28.80.119) with Microsoft SMTP Server id
 15.1.1847.3 via Frontend Transport; Tue, 4 Aug 2020 18:28:36 +0530
From: "Venkata Pyla" <venkata.pyla@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <daniel.sangorrin@toshiba.co.jp>,
	<nobuhiro1.iwamatsu@toshiba.co.jp>
CC: venkata pyla <venkata.pyla@toshiba-tsip.com>
Subject: [cip-dev] [cip-kernel-config] 4.19.y-cip/x86: qemu: Add nftable configs
Date: Tue, 4 Aug 2020 18:29:35 +0530
Message-ID: <20200804125936.1434-1-venkata.pyla@toshiba-tsip.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: iH4xZOcd2xtaq7MpB3kUKNrwx4520388AA=
Content-Type: multipart/mixed; boundary="p1FblpOMjpIoU4sTPAXa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596545937;
 bh=1gA6MJEiG2KXYV5YPEluhyeurpDXx+ODt/J3UyaAOoE=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=YeB7IBWfopibyFscrvqAEa7PV8jisusud02LpPnCyHuj+1WfP80IpG2q1iLeSd0+D3V
 yDHvJHXnFsac+xP7V0Ir/TiIov9Q8hJX+dKdcg7NO3nVckgYlUjF6uO6zd6nCuFogcF1G
 2bJStZarRpvn9LsFCAMY37aBYZ46qSeUfMw=

--p1FblpOMjpIoU4sTPAXa
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

These kenrel configs are required for nftable package to work
and which is used for IEC-62443-4-2 evaluation

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 4.19.y-cip/x86/cip_qemu_defconfig | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/4.19.y-cip/x86/cip_qemu_defconfig b/4.19.y-cip/x86/cip_qemu_defconfig
index 02732ae..7e5437a 100644
--- a/4.19.y-cip/x86/cip_qemu_defconfig
+++ b/4.19.y-cip/x86/cip_qemu_defconfig
@@ -282,3 +282,34 @@ CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
 CONFIG_EARLY_PRINTK_DBGP=y
 CONFIG_DEBUG_BOOT_PARAMS=y
 CONFIG_OPTIMIZE_INLINING=y
+CONFIG_NF_TABLES=y
+CONFIG_NF_TABLES_INET=y
+CONFIG_NF_TABLES_NETDEV=y
+CONFIG_NFT_EXTHDR=y
+CONFIG_NFT_META=y
+CONFIG_NFT_CT=y
+CONFIG_NFT_RBTREE=y
+CONFIG_NFT_HASH=y
+CONFIG_NFT_COUNTER=y
+CONFIG_NFT_LOG=y
+CONFIG_NFT_LIMIT=y
+CONFIG_NFT_MASQ=y
+CONFIG_NFT_REDIR=y
+CONFIG_NFT_NAT=y
+CONFIG_NFT_QUEUE=y
+CONFIG_NFT_REJECT=y
+CONFIG_NFT_REJECT_INET=y
+CONFIG_NFT_COMPAT=y
+CONFIG_NFT_CHAIN_ROUTE_IPV4=y
+CONFIG_NFT_REJECT_IPV4=y
+CONFIG_NFT_CHAIN_NAT_IPV4=y
+CONFIG_NFT_MASQ_IPV4=y
+# CONFIG_NFT_REDIR_IPV4 is not set
+CONFIG_NFT_CHAIN_ROUTE_IPV6=y
+CONFIG_NFT_REJECT_IPV6=y
+CONFIG_NFT_CHAIN_NAT_IPV6=y
+CONFIG_NFT_MASQ_IPV6=y
+# CONFIG_NFT_REDIR_IPV6 is not set
+CONFIG_NFT_BRIDGE_META=y
+CONFIG_NFT_BRIDGE_REJECT=y
+CONFIG_NF_LOG_BRIDGE=y
-- 
2.20.1

The information contained in this e-mail message and in any
attachments/annexure/appendices is confidential to the 
recipient and may contain privileged information. 
If you are not the intended recipient, please notify the
sender and delete the message along with any 
attachments/annexure/appendices. You should not disclose,
copy or otherwise use the information contained in the
message or any annexure. Any views expressed in this e-mail 
are those of the individual sender except where the sender 
specifically states them to be the views of 
Toshiba Software India Pvt. Ltd. (TSIP),Bangalore.

Although this transmission and any attachments are believed to be
free of any virus or other defect that might affect any computer 
system into which it is received and opened, it is the responsibility
of the recipient to ensure that it is virus free and no responsibility 
is accepted by Toshiba Embedded Software India Pvt. Ltd, for any loss or
damage arising in any way from its use.


--p1FblpOMjpIoU4sTPAXa
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5091): https://lists.cip-project.org/g/cip-dev/message=
/5091
Mute This Topic: https://lists.cip-project.org/mt/75985980/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--p1FblpOMjpIoU4sTPAXa--
