Return-Path: <SRS0=ODqS=E6=lists.cip-project.org=bounce+64572+5840+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,T_TVD_MIME_NO_HEADERS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773CBC63798
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 17:11:35 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C375320857
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 17:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Af2fXjdl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C375320857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5840+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 6exLYY4521723xKnzszHD6dx; Tue, 24 Nov 2020 09:11:34 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.22.1606237776676984965
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2020 09:09:37 -0800
X-IronPort-AV: E=Sophos;i="5.78,366,1599490800"; 
   d="scan'208";a="63522771"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 25 Nov 2020 02:09:34 +0900
X-Received: from localhost.localdomain (unknown [172.29.53.254])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2AB0540ABFEE;
	Wed, 25 Nov 2020 02:09:32 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 0/9] Add USB[2.0|3.0] support
Date: Tue, 24 Nov 2020 17:09:23 +0000
Message-Id: <20201124170932.13588-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: HriWC6Gf8NaEENmtWD3Mszbtx4520388AA=
Content-Type: multipart/mixed; boundary="dL3axkePrzKWGiBMf60S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606237894;
 bh=yL1XLPYOwO96UHIRi0RgusLxbJecE5LjSHw9GR4VjwQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Af2fXjdlu/DUtYyh9/EUPFl8x1sLOU1YufpyJ0OQepkMky3jy82vbhxnxZZBVhXViy4
 36btQEAdKv8CM0FE5fZ5jpLWcwPrTqaM9C14lctC3Z3/FGfiskMah7ZAn6X7ga6esxUz6
 WH9s541nHrOWDX6PCmVFZkww/vAkVxijI+Q=

--dL3axkePrzKWGiBMf60S

This patch series aims to add USB2.0/USB3.0 support for iWave
RZ/G1H platform.

All the patches in this series are cherrypicked from mainline and
it is based linux-4.4.y-cip.

Biju Das (1):
  usb: host: xhci-plat: Add r8a7742 support

Lad Prabhakar (8):
  dt-bindings: phy: rcar-gen2: Add r8a7742 support
  ARM: dts: r8a7742: Add USB 2.0 host support
  dt-bindings: usb: renesas,usbhs: Add support for r8a7742
  ARM: dts: r8a7742: Add USB-DMAC and HSUSB device nodes
  dt-bindings: usb: usb-xhci: Document r8a7742 support
  ARM: dts: r8a7742: Add XHCI support
  pinctrl: sh-pfc: r8a7790: Add USB1 PWEN pin and group
  ARM: dts: r8a7742-iwg21d-q7: Enable HSUSB, USB2.0 and xHCI

 .../devicetree/bindings/phy/rcar-gen2-phy.txt |   3 +-
 .../devicetree/bindings/usb/renesas_usbhs.txt |   1 +
 .../devicetree/bindings/usb/usb-xhci.txt      |   4 +-
 arch/arm/boot/dts/r8a7742-iwg21d-q7.dts       |  42 +++++
 arch/arm/boot/dts/r8a7742.dtsi                | 165 ++++++++++++++++++
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c          |  11 +-
 drivers/usb/host/xhci-plat.c                  |   3 +
 7 files changed, 225 insertions(+), 4 deletions(-)

-- 
2.17.1


--dL3axkePrzKWGiBMf60S
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5840): https://lists.cip-project.org/g/cip-dev/message=
/5840
Mute This Topic: https://lists.cip-project.org/mt/78481722/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--dL3axkePrzKWGiBMf60S--
