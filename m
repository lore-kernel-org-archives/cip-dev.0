Return-Path: <SRS0=t5hB=EP=lists.cip-project.org=bounce+64572+5769+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,T_TVD_MIME_NO_HEADERS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01214C2D0A3
	for <cip-dev@archiver.kernel.org>; Mon,  9 Nov 2020 15:50:18 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEDD9206C0
	for <cip-dev@archiver.kernel.org>; Mon,  9 Nov 2020 15:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="MJfqk+4d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEDD9206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5769+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id uG9QYY4521723xGR0IPC6ofE; Mon, 09 Nov 2020 07:50:17 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.13504.1604937015956466828
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2020 07:50:16 -0800
X-IronPort-AV: E=Sophos;i="5.77,463,1596466800"; 
   d="scan'208";a="62129260"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 10 Nov 2020 00:50:13 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id C032540078A1;
	Tue, 10 Nov 2020 00:50:12 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 00/14] Renesas RZ/G1H add support for CAN, IPMMU, QSPI, RTC
Date: Mon,  9 Nov 2020 15:49:57 +0000
Message-Id: <20201109155011.10291-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Lzd72P2IwBaGq54XpGuW83Upx4520388AA=
Content-Type: multipart/mixed; boundary="e1vQUGogY21svrGpDVO3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604937017;
 bh=CnPEohwa/EeuwNSgfjqVcpl2dGEmkUq0uQWAuE6MmkM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=MJfqk+4ds2wsvAXne9pkX4pRGDie1urcpKGzKPxEcDvugLznPkTP3EtOIrsg6N32sqP
 jUHEUBFlMbgz4OKdAV9BvtQEGDzp+G20Iy8P/Z2flOzvHHecDry5RxatrJ4U5f1H1rX5I
 lWnCqifoQ5aGeBjs/s1KwYP5VMHeWx2LzVQ=

--e1vQUGogY21svrGpDVO3

Hi All,

This patch series adds support for below peripherals (along with fixes to
msiof driver),
 * CAN
 * IPMMU
 * QSPI
 * RTC

All the patches have been cherry picked from upstream kernel.

Cheers,
Prabhakar

Geert Uytterhoeven (2):
  spi: sh-msiof: Avoid writing to registers from spi_master.setup()
  spi: sh-msiof: Implement cs-gpios configuration

Lad Prabhakar (12):
  ARM: dts: r8a7742-iwg21m: Sort the nodes alphabetically
  ARM: dts: r8a7742-iwg21m: Add RTC support
  spi: renesas,rspi: Add r8a7742 to the compatible list
  ARM: dts: r8a7742: Add QSPI support
  ARM: dts: r8a7742-iwg21m: Add SPI NOR support
  ARM: dts: r8a7742-iwg21d-q7: Add SPI NOR support
  pinctrl: sh-pfc: r8a7790: Add CAN pins, groups and functions
  dt-bindings: can: rcar_can: Add r8a7742 support
  ARM: dts: r8a7742: Add CAN support
  ARM: dts: r8a7742-iwg21d-q7: Add can1 support to carrier board
  ARM: dts: r8a7742-iwg21d-q7-dbcm-ca: Add can0 support to camera DB
  ARM: dts: r8a7742: Add IPMMU DT nodes

 .../devicetree/bindings/net/can/rcar_can.txt  |   3 +-
 .../devicetree/bindings/spi/spi-rspi.txt      |   1 +
 .../boot/dts/r8a7742-iwg21d-q7-dbcm-ca.dts    |  11 ++
 arch/arm/boot/dts/r8a7742-iwg21d-q7.dts       |  52 ++++++++
 arch/arm/boot/dts/r8a7742-iwg21m.dtsi         |  79 +++++++++++-
 arch/arm/boot/dts/r8a7742.dtsi                |  90 ++++++++++++++
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c          | 112 +++++++++++++++++-
 drivers/spi/spi-sh-msiof.c                    |  92 +++++++++++---
 8 files changed, 418 insertions(+), 22 deletions(-)

-- 
2.17.1


--e1vQUGogY21svrGpDVO3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5769): https://lists.cip-project.org/g/cip-dev/message=
/5769
Mute This Topic: https://lists.cip-project.org/mt/78138424/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--e1vQUGogY21svrGpDVO3--
