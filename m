Return-Path: <SRS0=u5Ma=EM=lists.cip-project.org=bounce+64572+5755+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,T_TVD_MIME_NO_HEADERS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AAAC55178
	for <cip-dev@archiver.kernel.org>; Fri,  6 Nov 2020 09:51:58 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1465C20A8B
	for <cip-dev@archiver.kernel.org>; Fri,  6 Nov 2020 09:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="OA2gviR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1465C20A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5755+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 1B1nYY4521723xxVcMqGg9xG; Fri, 06 Nov 2020 01:51:56 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web08.9516.1604656314998776624
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Nov 2020 01:51:55 -0800
X-IronPort-AV: E=Sophos;i="5.77,456,1596466800"; 
   d="scan'208";a="61650154"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 06 Nov 2020 18:51:53 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A11FC4266628;
	Fri,  6 Nov 2020 18:51:52 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 0/8] Renesas RZ/G1H add PCIe, SATA and VSP support
Date: Fri,  6 Nov 2020 09:51:43 +0000
Message-Id: <20201106095151.25880-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 5lLp0cXXd0K9KI5058i8loHpx4520388AA=
Content-Type: multipart/mixed; boundary="CV6Bnvjlr8WtaT4NhAKw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604656316;
 bh=vaPKj6PWKWqA5ykGx4p7Z3tGUF4CcqF+JZBUso++yQ0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=OA2gviR/rezRTJc96VNhNIfPRXio6v5FOBRK2CqWXKFkl2xoQNEspopCWZSaXbwP8df
 dEVSd3E7bImjoHFXGnQ+Bs/YnQc8HMHJuCxvoEHKc7tsrNnUqBD6BFc0hlQwYVlCKc6FG
 FxcYUf1MVwtJNp5FLXv7hWbDjALpv3CTQQ8=

--CV6Bnvjlr8WtaT4NhAKw

Hi All,

This patch series adds support for PCIe, SATA and VSP.

All the patches have been cherry-picked from Linux v5.10-rc2.

Cheers,
Prabhakar

Geert Uytterhoeven (1):
  ata: sata_rcar: Fix DMA boundary mask

Lad Prabhakar (6):
  dt-bindings: PCI: pci-rcar-gen2: Add device tree support for r8a7742
  ARM: dts: r8a7742: Add PCIe Controller device node
  ARM: dts: r8a7742-iwg21d-q7: Enable PCIe Controller
  dt-bindings: ata: renesas,rcar-sata: Add r8a7742 support
  ARM: dts: r8a7742: Add SATA nodes
  ARM: dts: r8a7742: Add VSP support

Simon Horman (1):
  ata: sata_rcar: add gen[23] fallback compatibility strings

 .../devicetree/bindings/ata/sata_rcar.txt     |  14 ++-
 .../devicetree/bindings/pci/pci-rcar-gen2.txt |   3 +-
 arch/arm/boot/dts/r8a7742-iwg21d-q7.dts       |  12 ++
 arch/arm/boot/dts/r8a7742.dtsi                | 109 ++++++++++++++++++
 drivers/ata/sata_rcar.c                       |   6 +-
 5 files changed, 139 insertions(+), 5 deletions(-)

-- 
2.17.1


--CV6Bnvjlr8WtaT4NhAKw
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5755): https://lists.cip-project.org/g/cip-dev/message=
/5755
Mute This Topic: https://lists.cip-project.org/mt/78070979/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--CV6Bnvjlr8WtaT4NhAKw--
