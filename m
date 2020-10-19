Return-Path: <SRS0=FdtV=D2=lists.cip-project.org=bounce+64572+5590+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC01C433DF
	for <cip-dev@archiver.kernel.org>; Mon, 19 Oct 2020 07:48:12 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDE0122243
	for <cip-dev@archiver.kernel.org>; Mon, 19 Oct 2020 07:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Il2MqmBo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE0122243
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toshiba-tsip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5590+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id j9XEYY4521723xMGzBGmOSNl; Mon, 19 Oct 2020 00:48:11 -0700
X-Received: from peak.toshiba-tesi.com (peak.toshiba-tesi.com [202.56.254.199])
 by mx.groups.io with SMTP id smtpd.web10.8956.1603093690224883070
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Oct 2020 00:48:10 -0700
IronPort-SDR: dTEs6hi+ymovdTW4zPObLOBt0Do6nTDGehinGwoeO2rkifQNjlBAXRJ2fqzHiVeste/b28cmjk
 UO+vAZvNNWuQ==
X-IronPort-AV: E=Sophos;i="5.77,394,1596479400"; 
   d="scan'208";a="6918139"
X-Received: from unknown (HELO TOSBLRMBX0419.TOSHIBA-TSIP.COM) ([10.116.85.28])
  by peak.toshiba-tesi.com with ESMTP; 19 Oct 2020 14:03:10 +0530
X-Received: from TOSBLRMBX0319.TOSHIBA-TSIP.COM (172.28.80.120) by
 TOSBLRMBX0419.TOSHIBA-TSIP.COM (10.116.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 19 Oct 2020 13:17:54 +0530
X-Received: from pvenkat.TOSHIBA-TSIP.COM (172.28.80.121) by
 TOSBLRMBX0319.TOSHIBA-TSIP.COM (172.28.80.120) with Microsoft SMTP Server id
 15.1.1847.3 via Frontend Transport; Mon, 19 Oct 2020 13:17:54 +0530
From: "Venkata Pyla" <venkata.pyla@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <nobuhiro1.iwamatsu@toshiba.co.jp>
CC: venkata pyla <venkata.pyla@toshiba-tsip.com>
Subject: [cip-dev] [cip-kerenl-config] 4.19.y-cip/x86/cip_qemu_defconfig: Enable NF_TABLES_SET
Date: Mon, 19 Oct 2020 13:19:32 +0530
Message-ID: <20201019074932.1543-1-venkata.pyla@toshiba-tsip.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: cYcOsqpyoU11N9NBLdnM9Dxpx4520388AA=
Content-Type: multipart/mixed; boundary="4Sf90FOAXbYFnWIUUgtq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603093691;
 bh=W8codH0nbQP+I2jmfXG8u9tPRvNFtSxSMrooaOiiNf8=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=Il2MqmBoYB8QYzdX9u0HE2GhYuPWaKPTk4wg3cOlk2qN4+KEn2aCrAjKiWScBuCi+3y
 5Avpq1dDv8f7TcZcInZ66PTr6oFx8Ud2dBQaN5f60EYwSI5W6n8gEmaTynZAW/cxhIwM2
 Sf9O76qpdHn1IPyfC7/ah/6DVKTOP7zYxH4=

--4Sf90FOAXbYFnWIUUgtq
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Add NF_TABLES_SET config to support nftables set infrastructure
which is expecting in fail2ban package to work

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 4.19.y-cip/x86/cip_qemu_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/4.19.y-cip/x86/cip_qemu_defconfig b/4.19.y-cip/x86/cip_qemu_defconfig
index b86efeb..7b8fc66 100644
--- a/4.19.y-cip/x86/cip_qemu_defconfig
+++ b/4.19.y-cip/x86/cip_qemu_defconfig
@@ -96,6 +96,7 @@ CONFIG_INET6_ESP=y
 CONFIG_NETLABEL=y
 CONFIG_NETFILTER=y
 # CONFIG_NETFILTER_ADVANCED is not set
+CONFIG_NF_TABLES_SET=y
 CONFIG_NF_CONNTRACK=y
 CONFIG_NF_CONNTRACK_FTP=y
 CONFIG_NF_CONNTRACK_IRC=y
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


--4Sf90FOAXbYFnWIUUgtq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5590): https://lists.cip-project.org/g/cip-dev/message=
/5590
Mute This Topic: https://lists.cip-project.org/mt/77653645/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--4Sf90FOAXbYFnWIUUgtq--
