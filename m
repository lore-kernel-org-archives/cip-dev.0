Return-Path: <SRS0=r7d3=EE=lists.cip-project.org=bounce+64572+5689+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,T_TVD_MIME_NO_HEADERS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108CFC2D0A3
	for <cip-dev@archiver.kernel.org>; Thu, 29 Oct 2020 11:46:10 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C5D620780
	for <cip-dev@archiver.kernel.org>; Thu, 29 Oct 2020 11:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="X/dDcy+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C5D620780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5689+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Rvy8YY4521723xH97RuT5ca5; Thu, 29 Oct 2020 04:46:08 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.7422.1603971966938953559
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 Oct 2020 04:46:07 -0700
X-IronPort-AV: E=Sophos;i="5.77,429,1596466800"; 
   d="scan'208";a="61161053"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 29 Oct 2020 20:46:04 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8567942E288B;
	Thu, 29 Oct 2020 20:46:03 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 0/4] Add SATA support to RZ/G2N
Date: Thu, 29 Oct 2020 11:45:58 +0000
Message-Id: <20201029114602.9107-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 61YbXmKqjofNAFwuVEaQaj2ex4520388AA=
Content-Type: multipart/mixed; boundary="6yeFHauSjWg2dYaukb6e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603971968;
 bh=N1jIUeuZDSJysxmxNOJtSMCnISpSmOEWaxusRM/ReII=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=X/dDcy+S/5hYyZ7BsKUSejBtXGw7gK8gzTYL81oHVdyXRFEBIGHMzT7mRc1/tWr4Iev
 Nu/ht4Hb3r50QT0ovIZ8IG0P5DZNHYjs6HI2BCyCXPz9kMZoIChEIw6nIlL2awIhw3v4K
 oMF2d9Tm3jXdY5hLokwBEGRznlgL1h3qWQ0=

--6yeFHauSjWg2dYaukb6e

Hi All,

This patch series adds SATA support to RZ/G2N SoC and enables
sata node in Hihope RZ/G2N board, alongside a fix to sata driver.

Cheers,
Prabhakar

Fabrizio Castro (2):
  dt-bindings: ata: sata_rcar: Add r8a774b1 support
  arm64: dts: renesas: r8a774b1: Add SATA controller node

Geert Uytterhoeven (1):
  ata: sata_rcar: Fix DMA boundary mask

Lad Prabhakar (1):
  arm64: dts: renesas: r8a774b1-hihope-rzg2n-ex: Enable sata

 Documentation/devicetree/bindings/ata/sata_rcar.txt   |  7 +++++--
 .../boot/dts/renesas/r8a774b1-hihope-rzg2n-ex.dts     |  5 +++++
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi             | 11 +++++++++++
 drivers/ata/sata_rcar.c                               |  2 +-
 4 files changed, 22 insertions(+), 3 deletions(-)

-- 
2.17.1


--6yeFHauSjWg2dYaukb6e
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5689): https://lists.cip-project.org/g/cip-dev/message=
/5689
Mute This Topic: https://lists.cip-project.org/mt/77885348/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--6yeFHauSjWg2dYaukb6e--
