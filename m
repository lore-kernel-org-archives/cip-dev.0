Return-Path: <SRS0=JzF6=EJ=lists.cip-project.org=bounce+64572+5713+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,T_TVD_MIME_NO_HEADERS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF78C388F7
	for <cip-dev@archiver.kernel.org>; Tue,  3 Nov 2020 17:33:43 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7646F21D91
	for <cip-dev@archiver.kernel.org>; Tue,  3 Nov 2020 17:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="LhNes8K7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7646F21D91
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5713+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id i9ZBYY4521723xmdwFkuUiFD; Tue, 03 Nov 2020 09:33:41 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.806.1604424820742793591
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Nov 2020 09:33:41 -0800
X-IronPort-AV: E=Sophos;i="5.77,448,1596466800"; 
   d="scan'208";a="61344806"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 04 Nov 2020 02:33:38 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 71C9B4009BE5;
	Wed,  4 Nov 2020 02:33:37 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 00/17] Renesas RZ/G2H add FCP{FV}, VSP, FDP1, DU, HDMI, LVDS, PWM and sound support
Date: Tue,  3 Nov 2020 17:33:19 +0000
Message-Id: <20201103173336.2829-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Rarz5xqcabK2KYcQAGUVtKTbx4520388AA=
Content-Type: multipart/mixed; boundary="0oN0Q9MZXXtzCg3EZq2F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604424821;
 bh=ZJg1VlcyseWtHTj/whBlNmOvHkpaAWw+ZOYDPW8e9GQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=LhNes8K70Ai7VwsWbBwYsS3ceMoYFTdwyRB1OXeZYMfaur4Blu8+CAzQxHK2HgD76hq
 P9T/tDZQoZeNwrVhL63gJXaZ/ZwahRqBWUYeF9YHYZjWTZOzP9+xaXBXhNySoEwGhLJj1
 VvTvKjT5nkjHMTEIbV+o+X+N993izbQ6tjQ=

--0oN0Q9MZXXtzCg3EZq2F

Hi All,

This patch series adds support for following peripheral to Renesas
RZ/G2H,
* FCPF, FCPV
* FDP1
* PWM
* DU, HDMI, LVDS
* Sound

All the patches have been cherry picked from Linux kernel v5.10-rc2.

Cheers,
Prabhakar

Lad Prabhakar (4):
  arm64: dts: renesas: r8a774e1-hihope-rzg2h: Setup DU clocks
  arm64: dts: renesas: Add HiHope RZ/G2H board with idk-1110wr display
  dt-bindings: sound: renesas, rsnd: Document r8a774e1 bindings
  arm64: dts: renesas: r8a774e1: Add audio support

Marian-Cristian Rotariu (13):
  arm64: dts: renesas: r8a774e1: Add FCPF and FCPV instances
  arm64: dts: renesas: r8a774e1: Add VSP instances
  arm64: dts: renesas: r8a774e1: Add FDP1 device nodes
  dt-bindings: display: renesas,du: Document r8a774e1 bindings
  drm: rcar-du: Add support for R8A774E1 SoC
  arm64: dts: renesas: r8a774e1: Populate DU device node
  dt-bindings: display: renesas,dw-hdmi: Add r8a774e1 support
  arm64: dts: renesas: r8a774e1: Populate HDMI encoder node
  dt-bindings: display: renesas,lvds: Document r8a774e1 bindings
  drm: rcar-du: lvds: Add support for R8A774E1 SoC
  arm64: dts: renesas: r8a774e1: Add LVDS device node
  dt-bindings: pwm: renesas,pwm-rcar: Add r8a774e1 support
  arm64: dts: renesas: r8a774e1: Add PWM device nodes

 .../display/bridge/renesas,dw-hdmi.txt        |   1 +
 .../bindings/display/bridge/renesas,lvds.txt  |   1 +
 .../bindings/display/renesas,du.txt           |   2 +
 .../bindings/pwm/renesas,pwm-rcar.txt         |   1 +
 .../bindings/sound/renesas,rsnd.txt           |   1 +
 arch/arm64/boot/dts/renesas/Makefile          |   1 +
 .../r8a774e1-hihope-rzg2h-ex-idk-1110wr.dts   |  15 +
 .../dts/renesas/r8a774e1-hihope-rzg2h.dts     |  11 +
 arch/arm64/boot/dts/renesas/r8a774e1.dtsi     | 751 +++++++++++++++++-
 drivers/gpu/drm/rcar-du/rcar_du_drv.c         |  30 +
 drivers/gpu/drm/rcar-du/rcar_lvds.c           |   1 +
 11 files changed, 809 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex-idk-1110wr.dts

-- 
2.17.1


--0oN0Q9MZXXtzCg3EZq2F
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5713): https://lists.cip-project.org/g/cip-dev/message=
/5713
Mute This Topic: https://lists.cip-project.org/mt/78011684/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--0oN0Q9MZXXtzCg3EZq2F--
