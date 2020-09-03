Return-Path: <SRS0=1t45=CM=lists.cip-project.org=bounce+64572+5395+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,T_TVD_MIME_NO_HEADERS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16387C433E9
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 14:43:08 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EF1C206EB
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 14:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="M1VGlThn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EF1C206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5395+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id BZXRYY4521723xtmPlZTqRbV; Thu, 03 Sep 2020 07:43:07 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web12.15617.1599144186096464858
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Sep 2020 07:43:06 -0700
X-IronPort-AV: E=Sophos;i="5.76,387,1592838000"; 
   d="scan'208";a="56297543"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 03 Sep 2020 23:43:05 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 95B3340C46C1;
	Thu,  3 Sep 2020 23:43:04 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 0/6] RZ/G1H add support for Ether/[H]SCIF{A|B}
Date: Thu,  3 Sep 2020 15:42:57 +0100
Message-Id: <20200903144303.13275-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: PcAMjFaBHRLe7xAn7SAOk6Lox4520388AA=
Content-Type: multipart/mixed; boundary="X8ng7khvgTZqsSGqVFek"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599144187;
 bh=IqCEdimsbzFonxAapkz5D0b+5npNjiV3yZwGIp1VOT8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=M1VGlThn095urn88pugr0vtoQxz5wfb/vkhkP0RG+dlIWbP6rf7yv8uz3AT1ZChXFQU
 gFiK6jiI5SdjM+yTaD+IKj+s5AjD6YKE0f+oaZR8ekVtgks/rlp1d7QDFFztu5OEpXuFh
 7+EOXNiVuUR73/xqk9c7yqHJLnV2Pdd7mO0=

--X8ng7khvgTZqsSGqVFek

Hi All,

This patch series adds support for ETHER/[H]SCIF{A|B} to
R8A7742 SoC and alongside adds camera daughter board dts
which fits on iwg21d-q7 development platform.

Patches 1/6, 3/6, 5/6, 6/6 have been cherry picked from
upstream kernel, patch 2/6 is a hookup patch to enable 
eth on R8A7742 SoC and patch 4/6 is a fixup patch.

Cheers,
Prabhakar

Lad Prabhakar (6):
  dt-bindings: net: renesas,ether: Document R8A7742 SoC
  sh_eth: Add compatible string for R8A7742 SoC
  ARM: dts: r8a7742: Add Ether support
  ARM: dts: r8a7742: Drop undocumented compatible string from scifa2
    node
  ARM: dts: r8a7742: Add [H]SCIF{A|B} support
  ARM: dts: r8a7742-iwg21d-q7-dbcm-ca: Add device tree for camera DB

 .../devicetree/bindings/net/sh_eth.txt        |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/r8a7742-iwg21d-q7-dbcm-ca.dts    |  96 +++++++++++
 arch/arm/boot/dts/r8a7742.dtsi                | 159 +++++++++++++++++-
 drivers/net/ethernet/renesas/sh_eth.c         |   1 +
 5 files changed, 257 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/r8a7742-iwg21d-q7-dbcm-ca.dts

-- 
2.17.1


--X8ng7khvgTZqsSGqVFek
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5395): https://lists.cip-project.org/g/cip-dev/message=
/5395
Mute This Topic: https://lists.cip-project.org/mt/76608365/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--X8ng7khvgTZqsSGqVFek--
