Return-Path: <SRS0=BJk5=EL=lists.cip-project.org=bounce+64572+5741+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,T_TVD_MIME_NO_HEADERS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02094C4742C
	for <cip-dev@archiver.kernel.org>; Thu,  5 Nov 2020 09:50:47 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43B7B2151B
	for <cip-dev@archiver.kernel.org>; Thu,  5 Nov 2020 09:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="pXJ0Rgzk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B7B2151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5741+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id YwJvYY4521723xRIjqfoE8tn; Thu, 05 Nov 2020 01:50:43 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.5243.1604569842298237083
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Nov 2020 01:50:42 -0800
X-IronPort-AV: E=Sophos;i="5.77,453,1596466800"; 
   d="scan'208";a="61538021"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 05 Nov 2020 18:50:41 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 17E5C41E1F6D;
	Thu,  5 Nov 2020 18:50:39 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 0/6] Renesas RZ/G2H add USB{2,3} support
Date: Thu,  5 Nov 2020 09:50:33 +0000
Message-Id: <20201105095039.4751-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: riFcLnp6nnMafvQRumFS3Z9fx4520388AA=
Content-Type: multipart/mixed; boundary="lmq9J1ipnWVG54eQzyX1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604569843;
 bh=yTl507a0QpyJ0WW9n/yWAZCP1TlBh5vpwCdYAQ39qiU=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=pXJ0RgzkwmEYgZui/jv5oRU3GRBlbKZ8JWNQOLwY/FQ83sPngHbtwcKPYDXzrKDhsEx
 WUgb08yrp63mTcSxozfc50cPMieETDcHXjLzwhWeK6MsLfYHM5b08cjORvMH9YGsIy1wx
 +z+/91f6eC4tXbGotkR8LjUnNwuqDSFLLhE=

--lmq9J1ipnWVG54eQzyX1

Hi All,

This patch series adds USB{2,3} support to Renesas RZ/G2H SoC.

All the patches have been cherry-picked from Linux v5.10-rc2.

Cheers,
Prabhakar

Lad Prabhakar (6):
  dt-bindings: phy: renesas,usb2-phy: Add r8a774e1 support
  dt-bindings: phy: renesas,usb3-phy: Add r8a774e1 support
  dt-bindings: dma: renesas,usb-dmac: Add binding for r8a774e1
  arm64: dts: renesas: r8a774e1: Add USB2.0 phy and host (EHCI/OHCI)
    device nodes
  arm64: dts: renesas: r8a774e1: Add USB3.0 device nodes
  arm64: dts: renesas: r8a774e1: Add USB-DMAC and HSUSB device nodes

 .../bindings/dma/renesas,usb-dmac.txt         |   1 +
 .../bindings/phy/rcar-gen3-phy-usb2.txt       |   2 +
 .../bindings/phy/rcar-gen3-phy-usb3.txt       |   2 +
 arch/arm64/boot/dts/renesas/r8a774e1.dtsi     | 120 +++++++++++++++---
 4 files changed, 106 insertions(+), 19 deletions(-)

-- 
2.17.1


--lmq9J1ipnWVG54eQzyX1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5741): https://lists.cip-project.org/g/cip-dev/message=
/5741
Mute This Topic: https://lists.cip-project.org/mt/78047670/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--lmq9J1ipnWVG54eQzyX1--
