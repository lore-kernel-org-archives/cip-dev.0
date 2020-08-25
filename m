Return-Path: <SRS0=obY3=CD=lists.cip-project.org=bounce+64572+5240+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B82BC433E1
	for <cip-dev@archiver.kernel.org>; Tue, 25 Aug 2020 13:42:00 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F26902076C
	for <cip-dev@archiver.kernel.org>; Tue, 25 Aug 2020 13:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="tgxzVYvy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F26902076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5240+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id BuuMYY4521723x0sfLU5gjZX; Tue, 25 Aug 2020 06:41:59 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.13293.1598361720422412146
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Aug 2020 06:22:00 -0700
X-IronPort-AV: E=Sophos;i="5.76,352,1592838000"; 
   d="scan'208";a="55269165"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 25 Aug 2020 22:21:59 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.65])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id CE6FA4004950;
	Tue, 25 Aug 2020 22:21:57 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 00/10] Add OPP/Thermal/Timer/CAN[FD] support
Date: Tue, 25 Aug 2020 14:21:46 +0100
Message-Id: <20200825132156.7839-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: LI2IOwW2aJ8p9CwaEqXC8QNMx4520388AA=
Content-Type: multipart/mixed; boundary="tMVXZmqxI7g1ASKKF1YR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598362919;
 bh=o8WcA/pD3MZC94zR/LZTRMnoJWNdK9WI+kQmsE2tZ9I=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=tgxzVYvy4ND5bWauc9Ti4dsXkVJtrqEHFNn3AAtD60I+vHvcJEbbZQa5LlM8MCz76AH
 iUTtCss5k5dCDzmmIBPfiEbbeQ+EOLBxg/Fob/I2gxpHesMtEcNU4A7B5H79UJnWvh++f
 ERSyjqihb16scvC/ei/6C2qL1/Jww+muYkU=

--tMVXZmqxI7g1ASKKF1YR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series add RZ/G2H SoC support for OPP/Thermal/Timer/CAN[FD]
to 4.19.y cip kernel.

All the patches in this series are cherry-picked from ML.

This patch series depend upon [1]
[1]: https://patchwork.kernel.org/project/cip-dev/list/?series=336609

Dien Pham (1):
  thermal/drivers/rcar_gen3: Fix undefined temperature if negative

Geert Uytterhoeven (1):
  can: rcar_can: Remove unused platform data support

Lad Prabhakar (1):
  arm64: dts: renesas: r8a774e1: Add CAN[FD] support

Marian-Cristian Rotariu (5):
  arm64: dts: renesas: r8a774e1: Add operating points
  thermal: rcar_gen3_thermal: Add r8a774e1 support
  arm64: dts: renesas: r8a774e1: Add RZ/G2H thermal support
  arm64: dts: renesas: r8a774e1: Add CMT device nodes
  arm64: dts: renesas: r8a774e1: Add TMU device nodes

Niklas Söderlund (2):
  thermal: rcar_gen3_thermal: Remove temperature bound
  thermal: rcar_gen3_thermal: Generate interrupt when temperature
    changes

 arch/arm64/boot/dts/renesas/r8a774e1.dtsi | 323 +++++++++++++++++++++-
 drivers/net/can/rcar/rcar_can.c           |  22 +-
 drivers/thermal/rcar_gen3_thermal.c       |  34 +--
 include/linux/can/platform/rcar_can.h     |  18 --
 4 files changed, 347 insertions(+), 50 deletions(-)
 delete mode 100644 include/linux/can/platform/rcar_can.h

-- 
2.17.1


--tMVXZmqxI7g1ASKKF1YR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5240): https://lists.cip-project.org/g/cip-dev/message=
/5240
Mute This Topic: https://lists.cip-project.org/mt/76406704/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--tMVXZmqxI7g1ASKKF1YR--
