Return-Path: <SRS0=Z9fI=EI=lists.cip-project.org=bounce+64572+5701+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,T_TVD_MIME_NO_HEADERS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4943C388F9
	for <cip-dev@archiver.kernel.org>; Mon,  2 Nov 2020 09:24:50 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE1B722272
	for <cip-dev@archiver.kernel.org>; Mon,  2 Nov 2020 09:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="sC8+O/gK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE1B722272
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5701+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id yb8iYY4521723xdpfq4iFrgS; Mon, 02 Nov 2020 01:24:48 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.28758.1604309087598437275
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2020 01:24:47 -0800
X-IronPort-AV: E=Sophos;i="5.77,444,1596466800"; 
   d="scan'208";a="61246961"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 02 Nov 2020 18:24:45 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 741F34005E2A;
	Mon,  2 Nov 2020 18:24:44 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 0/6] Renesas RZ/G2H add PCIe{EP}/SATA support
Date: Mon,  2 Nov 2020 09:24:37 +0000
Message-Id: <20201102092443.4142-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: vBXDL3mPnZUaHaAqG6njCGBjx4520388AA=
Content-Type: multipart/mixed; boundary="Ow2ag3hGRJerES76hJi9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604309088;
 bh=N7Td/WXz7zyppKj5FzPJQGY9aSdoeWGAEeAwv7cpLmI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=sC8+O/gKMyJsVwiNglRIv5N4zd/U7FTpVWXX05e3WUHPSutjtJLqSSCMUpzSxo3KssF
 yFJNyW/AAhf8RG+lVpGRVg7ZuaquxjL3U9mtlfEB3zD1mU5ccyIfZCPqBuzhNkjVSKHZc
 Ff/5BTV4i2+ToJXHb2m+eIT1D3UfbBhnZro=

--Ow2ag3hGRJerES76hJi9

Hi All,

This patch series adds PCIe{EP}/SATA support to Renesas RZ/G2H.

All the patches have been cherry-picked from mainline kernel
v5.10-rc2.

Cheers,
Prabhakar

Lad Prabhakar (6):
  arm64: dts: renesas: r8a774e1: Add PCIe device nodes
  arm64: dts: renesas: r8a774e1: Add SATA controller node
  dt-bindings: pci: rcar-pci-ep: Document r8a774e1
  arm64: dts: renesas: r8a774e1: Add PCIe EP nodes
  misc: pci_endpoint_test: Add Device ID for RZ/G2H PCIe controller
  arm64: dts: renesas: r8a774e1-hihope-rzg2h-ex: Enable sata

 .../devicetree/bindings/pci/rcar-pci-ep.yaml  |  1 +
 .../dts/renesas/r8a774e1-hihope-rzg2h-ex.dts  |  5 +
 arch/arm64/boot/dts/renesas/r8a774e1.dtsi     | 97 ++++++++++++++++++-
 drivers/misc/pci_endpoint_test.c              |  2 +
 4 files changed, 104 insertions(+), 1 deletion(-)

-- 
2.17.1


--Ow2ag3hGRJerES76hJi9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5701): https://lists.cip-project.org/g/cip-dev/message=
/5701
Mute This Topic: https://lists.cip-project.org/mt/77977469/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Ow2ag3hGRJerES76hJi9--
