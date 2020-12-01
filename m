Return-Path: <SRS0=co5i=FF=lists.cip-project.org=bounce+64572+5913+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,T_TVD_MIME_NO_HEADERS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6130C64E7A
	for <cip-dev@archiver.kernel.org>; Tue,  1 Dec 2020 08:39:48 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E5102054F
	for <cip-dev@archiver.kernel.org>; Tue,  1 Dec 2020 08:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ORCMwPiK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E5102054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5913+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id GDFxYY4521723xk5wTLb3nFU; Tue, 01 Dec 2020 00:39:43 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.7290.1606811982507933503
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Dec 2020 00:39:42 -0800
X-IronPort-AV: E=Sophos;i="5.78,383,1599490800"; 
   d="scan'208";a="64255537"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Dec 2020 17:39:40 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5644E4256B66;
	Tue,  1 Dec 2020 17:39:39 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH v2 4.4.y-cip 00/11] Renesas RZ/G1x add SoC detection support
Date: Tue,  1 Dec 2020 08:39:27 +0000
Message-Id: <20201201083938.32688-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: g4lEm1n99soKzGiUF17vztC9x4520388AA=
Content-Type: multipart/mixed; boundary="SUjE1cEBD77omD4oKEna"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606811983;
 bh=ywdxLLHo+uDiLNjdr7Boudt6woz7mT2tsQLbD4LmH9Q=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=ORCMwPiKZ0b52sKTBDERdez001RlL6r+eCaIsSoDiONqhFXJVsGVXuRuKPn99WVEJvE
 N/w6D7qQ1lhggY40ZwxE4MDiTKunacYJTfpAHbKsS88YqHXXqdypgCow48oRYiVUz0g2u
 qea7HkEltE8vpxsNPDL9EdODcN8i+LIFk/0=

--SUjE1cEBD77omD4oKEna

Hi All,

This patch series adds SoC detection support for Renesas RZ/G1x SoC's.

All the patches apart from {7, 9, 11}/11 have been cherry picked from
Linux v5.10-rc6

Cheers,
Prabhakar

Changes for v2:
* Added upstream commit-id for patches {7, 9, 11}/11

Biju Das (1):
  soc: renesas: Identify RZ/G1C

Geert Uytterhoeven (6):
  base: soc: Early register bus when needed
  soc: renesas: Identify SoC and register with the SoC bus
  ARM: dts: r8a7743: Add device node for PRR
  ARM: dts: r8a7745: Add device node for PRR
  soc: renesas: Identify RZ/G1N
  soc: renesas: Identify RZ/G1H

Lad Prabhakar (3):
  ARM: dts: r8a7744: Add device node for PRR
  ARM: dts: r8a7742: Add device node for PRR
  ARM: dts: r8a77470: Add device node for PRR

Simon Horman (1):
  dt-bindings: arm: renesas: Convert 'renesas,prr' to json-schema

 .../devicetree/bindings/arm/renesas,prr.yaml  |  37 +++++
 arch/arm/boot/dts/r8a7742.dtsi                |   5 +
 arch/arm/boot/dts/r8a7743.dtsi                |   5 +
 arch/arm/boot/dts/r8a7744.dtsi                |   5 +
 arch/arm/boot/dts/r8a7745.dtsi                |   5 +
 arch/arm/boot/dts/r8a77470.dtsi               |   5 +
 arch/arm/mach-shmobile/Kconfig                |   5 +
 drivers/base/soc.c                            |   9 ++
 drivers/soc/renesas/Makefile                  |   2 +
 drivers/soc/renesas/renesas-soc.c             | 147 ++++++++++++++++++
 10 files changed, 225 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/renesas,prr.yaml
 create mode 100644 drivers/soc/renesas/renesas-soc.c

-- 
2.17.1


--SUjE1cEBD77omD4oKEna
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5913): https://lists.cip-project.org/g/cip-dev/message=
/5913
Mute This Topic: https://lists.cip-project.org/mt/78628858/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--SUjE1cEBD77omD4oKEna--
