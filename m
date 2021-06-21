Return-Path: <SRS0=TFg2=LP=lists.cip-project.org=bounce+64572+6546+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4610C48BE5
	for <cip-dev@archiver.kernel.org>; Mon, 21 Jun 2021 17:09:32 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BF6860FDB
	for <cip-dev@archiver.kernel.org>; Mon, 21 Jun 2021 17:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF6860FDB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6546+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id nHj1YY4521723xNLT1ZKoIgf; Mon, 21 Jun 2021 10:09:31 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.50344.1624295370433045949
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Jun 2021 10:09:30 -0700
X-IronPort-AV: E=Sophos;i="5.83,289,1616425200"; 
   d="scan'208";a="84957071"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 22 Jun 2021 02:09:28 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 50CA1400C4D4;
	Tue, 22 Jun 2021 02:09:27 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 5.10.y-cip 00/16] Renesas RZ/G2 sync patches from 4.19-cip to 5.10-cip
Date: Mon, 21 Jun 2021 18:09:09 +0100
Message-Id: <20210621170925.11328-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: OZYOQW3il9Viuv3dCn4QG56rx4520388AA=
Content-Type: multipart/mixed; boundary="Qrcux0qUVS7gVURLwqXT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1624295371;
 bh=cHC+op4xJncgnDiNvK2LWPnJNcFgOAmJlk5UAD4IDwE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Khl0iyvagksknh5jxnCct0yrB/YPJmghJRQ1JePDD43lgBaVUw6S3/YoD6cN8A4DqEW
 lg6z5pCcUV1Sqd+g9ELlDuBHT6nWWI1rgoaLJAO8Wx6wgwPlCvV4cRxnfH73/LZTYGJxo
 OFp8vDG0vDU8OUl4PKRfwN1cr2YkLS0sILo=

--Qrcux0qUVS7gVURLwqXT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi All,

This patch series sync's patches from 4.19-cip to 5.10-cip.

All the patches have been cherry-picked from upstream.

Cheers,
Prabhakar

Biju Das (6):
  pinctrl: renesas: r8a77965: Optimize pinctrl image size for R8A774B1
  pinctrl: renesas: r8a7796: Optimize pinctrl image size for R8A774A1
  pinctrl: renesas: r8a77951: Optimize pinctrl image size for R8A774E1
  pinctrl: renesas: r8a77990: Optimize pinctrl image size for R8A774C0
  clk: renesas: r8a774b1: Add RPC clocks
  clk: renesas: r8a774a1: Add RPC clocks

Geert Uytterhoeven (1):
  dt-bindings: pci: rcar-pci-ep: Document missing interrupts property

Lad Prabhakar (7):
  pinctrl: renesas: r8a77965: Add QSPI[01] pins, groups and functions
  pinctrl: renesas: r8a7796: Add QSPI[01] pins, groups and functions
  pinctrl: renesas: r8a77951: Add QSPI[01] pins, groups and functions
  pinctrl: renesas: r8a77990: Add QSPI[01] pins, groups and functions
  clk: renesas: r8a774c0: Add RPC clocks
  memory: renesas-rpc-if: Make rpcif_enable/disable_rpm() as static
    inline
  dt-bindings: PCI: rcar-pci-host: Document r8a774e1 bindings

Marian-Cristian Rotariu (1):
  dt-bindings: timer: renesas: tmu: Document r8a774e1 bindings

YueHaibing (1):
  spi: spi-mem: Fix passing zero to 'PTR_ERR' warning

 .../devicetree/bindings/pci/rcar-pci-ep.yaml  |  9 ++
 .../devicetree/bindings/pci/rcar-pci.txt      |  1 +
 .../devicetree/bindings/timer/renesas,tmu.txt |  1 +
 drivers/clk/renesas/r8a774a1-cpg-mssr.c       |  8 ++
 drivers/clk/renesas/r8a774b1-cpg-mssr.c       |  8 ++
 drivers/clk/renesas/r8a774c0-cpg-mssr.c       |  9 ++
 drivers/clk/renesas/rcar-gen3-cpg.c           | 28 ++++++
 drivers/clk/renesas/rcar-gen3-cpg.h           |  5 ++
 drivers/memory/renesas-rpc-if.c               | 13 ---
 drivers/pinctrl/renesas/pfc-r8a77951.c        | 89 ++++++++++++++++++-
 drivers/pinctrl/renesas/pfc-r8a7796.c         | 87 +++++++++++++++++-
 drivers/pinctrl/renesas/pfc-r8a77965.c        | 87 +++++++++++++++++-
 drivers/pinctrl/renesas/pfc-r8a77990.c        | 87 +++++++++++++++++-
 drivers/spi/spi-mem.c                         |  2 +-
 include/memory/renesas-rpc-if.h               | 13 ++-
 15 files changed, 421 insertions(+), 26 deletions(-)

-- 
2.17.1


--Qrcux0qUVS7gVURLwqXT
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6546): https://lists.cip-project.org/g/cip-dev/message=
/6546
Mute This Topic: https://lists.cip-project.org/mt/83693866/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Qrcux0qUVS7gVURLwqXT--
