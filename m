Return-Path: <SRS0=u4Ls=CL=lists.cip-project.org=bounce+64572+5371+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,T_TVD_MIME_NO_HEADERS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E03C2D0A5
	for <cip-dev@archiver.kernel.org>; Wed,  2 Sep 2020 16:06:42 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3930E21532
	for <cip-dev@archiver.kernel.org>; Wed,  2 Sep 2020 16:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="whFFoXif"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3930E21532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5371+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id NTxkYY4521723xushVkN6UF8; Wed, 02 Sep 2020 09:06:42 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.11144.1599062722879544691
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2020 09:05:23 -0700
X-IronPort-AV: E=Sophos;i="5.76,383,1592838000"; 
   d="scan'208";a="56196955"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 03 Sep 2020 01:05:20 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.133])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 07C1540065AE;
	Thu,  3 Sep 2020 01:05:18 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 0/9] Add RZ/G1H WDT/Thermal/CMT/MSIOF support
Date: Wed,  2 Sep 2020 17:05:05 +0100
Message-Id: <20200902160517.5181-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: JlahhTsEvNATQ9EcRglsiAqux4520388AA=
Content-Type: multipart/mixed; boundary="QHsvBasdFD0xXWXCMwhb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599062802;
 bh=UJc8L8gpeevcvQpNjonww3XEFgxgwltYQFDFbSHEFPw=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=whFFoXifKW6DTTPiBfMpk5NH+rBDlP6x8GVlWy/B6u5NyzNUrd7ygfUZRlxsIfUFecT
 szItlznQVvZLEXkaTGT0HHEMcgAdYfjpyhoRBjmQkfk1T/CNaDVt8EpknivYZREALWlXl
 p127CY9bJ0YzVLd3AELU8szqUJnliLrb8io=

--QHsvBasdFD0xXWXCMwhb

This patch series add WDT/Thermal/CMT/MSIOF support for iWave RZ/G1H board based on
r8a7742 SoC to 4.4.y-cip kernel. All patches in this series except last one
are cherry-picked from mainline. The patch "ARM: dts: r8a7742-iwg21d-q7: Enable cmt0"
is ported from linux next.

This patch is depend on [1]
[1] https://patchwork.kernel.org/project/cip-dev/list/?series=342183

Lad Prabhakar (9):
  dt-bindings: watchdog: renesas,wdt: Document r8a7742 support
  ARM: dts: r8a7742: Add RWDT node
  ARM: dts: r8a7742-iwg21d-q7: Add RWDT support
  dt-bindings: thermal: rcar-thermal: Add device tree support for
    r8a7742
  ARM: dts: r8a7742: Add thermal device to DT
  ARM: dts: r8a7742: Add CMT SoC specific support
  spi: renesas,sh-msiof: Add r8a7742 support
  ARM: dts: r8a7742: Add MSIOF[0123] support
  ARM: dts: r8a7742-iwg21d-q7: Enable cmt0

 .../devicetree/bindings/spi/sh-msiof.txt      |   3 +-
 .../bindings/thermal/rcar-thermal.txt         |   1 +
 .../bindings/watchdog/renesas-wdt.txt         |   1 +
 arch/arm/boot/dts/r8a7742-iwg21d-q7.dts       |   9 ++
 arch/arm/boot/dts/r8a7742.dtsi                | 135 ++++++++++++++++++
 5 files changed, 148 insertions(+), 1 deletion(-)

-- 
2.17.1


--QHsvBasdFD0xXWXCMwhb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5371): https://lists.cip-project.org/g/cip-dev/message=
/5371
Mute This Topic: https://lists.cip-project.org/mt/76585838/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--QHsvBasdFD0xXWXCMwhb--
