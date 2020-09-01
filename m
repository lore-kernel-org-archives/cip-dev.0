Return-Path: <SRS0=TMDc=CK=lists.cip-project.org=bounce+64572+5349+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,T_TVD_MIME_NO_HEADERS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A53C433E2
	for <cip-dev@archiver.kernel.org>; Tue,  1 Sep 2020 11:45:12 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18B44206FA
	for <cip-dev@archiver.kernel.org>; Tue,  1 Sep 2020 11:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="g7S+Y05h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B44206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5349+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id AWEpYY4521723xMuvnvrHDWY; Tue, 01 Sep 2020 04:45:11 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.11106.1598960479890530571
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Sep 2020 04:41:20 -0700
X-IronPort-AV: E=Sophos;i="5.76,378,1592838000"; 
   d="scan'208";a="55870248"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 01 Sep 2020 20:41:17 +0900
X-Received: from localhost.localdomain (unknown [172.29.53.50])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 30F50400752B;
	Tue,  1 Sep 2020 20:41:16 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 00/10] Add IRQC/I2C/IIC/AVB/APMU support for RZ/G1H
Date: Tue,  1 Sep 2020 12:41:04 +0100
Message-Id: <20200901114114.3465-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: UEX0fNJxIqJ4oapkaT7ZF4AEx4520388AA=
Content-Type: multipart/mixed; boundary="YEGe1OfrtAHRcNzx8uzF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598960711;
 bh=PXVxHTrOxbZZeI+6nCpeMaH3LoHlbTzY1pV5J9GaTxM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=g7S+Y05hDfSq6ZUkR8+uUn7KVibx+HZcw9dz6tzDPeK49chQT59Hc1pzNY6DdeSYxNC
 jFWthhne8laixxJbbV9WWFhBrgdndY15d+xC3wy9A3IDuNxg8ZuGnb9f79jBOh4NL7K8p
 n76992BcqQyEil2TR8OZYx+nDn8ebGpO7ec=

--YEGe1OfrtAHRcNzx8uzF

This patch series add IRQC/I2C/IIC/AVB/APMU support for iWave RZ/G1H board based on
r8a7742 SoC to 4.4.y-cip kernel. All patches in this series
are cherry-picked from mainline.

Lad Prabhakar (10):
  dt-bindings: irqchip: renesas-irqc: Document r8a7742 bindings
  ARM: dts: r8a7742: Add IRQC support
  dt-bindings: i2c: renesas, i2c: Document r8a7742 support
  dt-bindings: i2c: renesas, iic: Document r8a7742 support
  ARM: dts: r8a7742: Add I2C and IIC support
  dt-bindings: net: renesas, ravb: Add support for r8a7742 SoC
  ARM: dts: r8a7742: Add Ethernet AVB support
  ARM: dts: r8a7742-iwg21d-q7: Enable Ethernet AVB
  dt-bindings: power: renesas,apmu: Document r8a7742 support
  ARM: dts: r8a7742: Add APMU nodes

 .../devicetree/bindings/i2c/i2c-rcar.txt      |   1 +
 .../devicetree/bindings/i2c/i2c-sh_mobile.txt |   1 +
 .../interrupt-controller/renesas,irqc.txt     |   1 +
 .../devicetree/bindings/net/renesas,ravb.txt  |   1 +
 .../bindings/power/renesas,apmu.txt           |   1 +
 arch/arm/boot/dts/r8a7742-iwg21d-q7.dts       |  21 +++
 arch/arm/boot/dts/r8a7742.dtsi                | 148 ++++++++++++++++++
 7 files changed, 174 insertions(+)

-- 
2.17.1


--YEGe1OfrtAHRcNzx8uzF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5349): https://lists.cip-project.org/g/cip-dev/message=
/5349
Mute This Topic: https://lists.cip-project.org/mt/76554005/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--YEGe1OfrtAHRcNzx8uzF--
