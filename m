Return-Path: <SRS0=wKKe=CE=lists.cip-project.org=bounce+64572+5263+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEF4C433E1
	for <cip-dev@archiver.kernel.org>; Wed, 26 Aug 2020 11:35:16 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8162E2087C
	for <cip-dev@archiver.kernel.org>; Wed, 26 Aug 2020 11:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="JAAHvZYH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8162E2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5263+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 8DWkYY4521723xp3qUwa1zTg; Wed, 26 Aug 2020 04:35:15 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.10103.1598440898295323947
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2020 04:21:42 -0700
X-IronPort-AV: E=Sophos;i="5.76,355,1592838000"; 
   d="scan'208";a="55588062"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 26 Aug 2020 20:21:41 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.148])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 67A67429693C;
	Wed, 26 Aug 2020 20:21:40 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 02/10] mmc: renesas_sdhi_internal_dmac: Add r8a774e1 support
Date: Wed, 26 Aug 2020 12:21:24 +0100
Message-Id: <20200826112132.4090-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200826112132.4090-1-biju.das.jz@bp.renesas.com>
References: <20200826112132.4090-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: XdAxKDNR3AOp26Ti14myVY3Nx4520388AA=
Content-Type: multipart/mixed; boundary="GsLqoXqoksEcZouhzOpJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598441715;
 bh=69OFU+ZcIJYzG8UZ+y/ImG+niFRj0rg7D8vFblkFbfs=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=JAAHvZYHi76x5W3NkbJlNTIPmyLWGW54fGj6UpD3vJmA3ztRHNh7R1WlcxQm8CQTHaF
 Kx7EUzNI4kwEAPdB56PCY+cmHUxD7iv42RpOBgIHLs3CVvnMemdajvCFpnQ97EHt2HG40
 t1DDvOAsl2gNJU3Z/b/Ap4XXrIxjaifYCdw=

--GsLqoXqoksEcZouhzOpJ

This patch adds SDHI support for RZ/G2H (R8A774E1) SoC.
Based on the work done for R8A7795 SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index d15615852de6..a492e226a262 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -302,6 +302,7 @@ static const struct soc_device_attribute gen3_soc_whitelist[] = {
 	{ .soc_id = "r8a774a1" },
 	{ .soc_id = "r8a774b1" },
 	{ .soc_id = "r8a774c0" },
+	{ .soc_id = "r8a774e1" },
 	{ .soc_id = "r8a7795" },
 	{ .soc_id = "r8a7796" },
 	{ .soc_id = "r8a77965" },
-- 
2.17.1


--GsLqoXqoksEcZouhzOpJ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5263): https://lists.cip-project.org/g/cip-dev/message=
/5263
Mute This Topic: https://lists.cip-project.org/mt/76426356/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--GsLqoXqoksEcZouhzOpJ--
