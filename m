Return-Path: <SRS0=3Q9b=CE=lists.cip-project.org=bounce+64572+5261+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,T_TVD_MIME_NO_HEADERS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619B6C433E3
	for <cip-dev@archiver.kernel.org>; Wed, 26 Aug 2020 11:35:16 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 325A32083B
	for <cip-dev@archiver.kernel.org>; Wed, 26 Aug 2020 11:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="T2uO4GJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 325A32083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5261+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id qwXJYY4521723xK12DGWCxcP; Wed, 26 Aug 2020 04:35:16 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.10103.1598440898295323947
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2020 04:21:38 -0700
X-IronPort-AV: E=Sophos;i="5.76,355,1592838000"; 
   d="scan'208";a="55588054"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 26 Aug 2020 20:21:36 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.148])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 36712429693B;
	Wed, 26 Aug 2020 20:21:34 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 00/10] Add support for [H]SCIF/SDHI/I2C/RWDT/MSIOF
Date: Wed, 26 Aug 2020 12:21:22 +0100
Message-Id: <20200826112132.4090-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 5McnOqObLUsGzCOFJzCBTuvmx4520388AA=
Content-Type: multipart/mixed; boundary="M5HsllUQ5p5V268LU7Zw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598441716;
 bh=S/UHdI90FGXghJP6KT1Qp5CoazXmkHJ3sVmyUxoVSLA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=T2uO4GJCf8lsUyEOCSAWC6matKVC4FxFBQhXhHiPCuqDf0GyK9TIXJyZK5cZY/F0zSt
 xsXOcbKmrVV+ewk3Do5dweqa8pdik60tHmjGvlbtGPFr7fg4fONKTllL4PA40jeYkHtH5
 ABY+vLeWn/6iwSzSD9/ir7M97Si+cThP/dQ=

--M5HsllUQ5p5V268LU7Zw

Add RZ/G2H SoC support for [H]SCIF/SDHI/I2C/RWDT/MSIOF on 4.19.y-cip kernel.

All the patches in this series are cherry-piced from ML, except [1] which is 
a new patch similar to the workdone for other similar SoC's

[1] mmc: renesas_sdhi_internal_dmac: Add r8a774e1 support

This patch series depend on [2]
[2] https://patchwork.kernel.org/project/cip-dev/list/?series=338235

Biju Das (1):
  mmc: renesas_sdhi_internal_dmac: Add r8a774e1 support

Lad Prabhakar (9):
  arm64: dts: renesas: r8a774e1: Add SCIF and HSCIF nodes
  arm64: dts: renesas: r8a774e1: Add SDHI nodes
  dt-bindings: i2c: renesas,i2c: Document r8a774e1 support
  dt-bindings: i2c: renesas,iic: Document r8a774e1 support
  arm64: dts: renesas: r8a774e1: Add I2C and IIC-DVFS support
  spi: renesas,sh-msiof: Add r8a774e1 support
  arm64: dts: renesas: r8a774e1: Add MSIOF nodes
  dt-bindings: watchdog: renesas,wdt: Document r8a774e1 support
  arm64: dts: renesas: r8a774e1: Add RWDT node

 .../devicetree/bindings/i2c/renesas,i2c.txt   |   1 +
 .../devicetree/bindings/i2c/renesas,iic.txt   |   1 +
 .../devicetree/bindings/spi/sh-msiof.txt      |   1 +
 .../bindings/watchdog/renesas,wdt.txt         |   1 +
 arch/arm64/boot/dts/renesas/r8a774e1.dtsi     | 390 +++++++++++++++++-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |   1 +
 6 files changed, 386 insertions(+), 9 deletions(-)

-- 
2.17.1


--M5HsllUQ5p5V268LU7Zw
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5261): https://lists.cip-project.org/g/cip-dev/message=
/5261
Mute This Topic: https://lists.cip-project.org/mt/76426354/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--M5HsllUQ5p5V268LU7Zw--
