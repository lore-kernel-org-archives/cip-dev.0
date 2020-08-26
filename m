Return-Path: <SRS0=ySWQ=CE=lists.cip-project.org=bounce+64572+5271+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A47C433F8
	for <cip-dev@archiver.kernel.org>; Wed, 26 Aug 2020 11:35:18 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24BD320897
	for <cip-dev@archiver.kernel.org>; Wed, 26 Aug 2020 11:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Auj+5P6+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24BD320897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5271+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id KJhsYY4521723xuadG6VBlH5; Wed, 26 Aug 2020 04:35:17 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.10260.1598440912320910289
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2020 04:21:57 -0700
X-IronPort-AV: E=Sophos;i="5.76,355,1592838000"; 
   d="scan'208";a="55371161"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 26 Aug 2020 20:21:57 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.148])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id DF283429693C;
	Wed, 26 Aug 2020 20:21:55 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 10/10] arm64: dts: renesas: r8a774e1: Add RWDT node
Date: Wed, 26 Aug 2020 12:21:32 +0100
Message-Id: <20200826112132.4090-11-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200826112132.4090-1-biju.das.jz@bp.renesas.com>
References: <20200826112132.4090-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Kal66nEzehxTxcZvGp52r0a1x4520388AA=
Content-Type: multipart/mixed; boundary="xXl7D5GvoHRwpGzNjXql"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598441717;
 bh=sigq3XPX2RUFXgTCVhP36Kz6KfMcz3miRvFPRvuZ0rg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Auj+5P6+m14dRddktZ/VviO6+NVSHawgpmzM6fSlmdaRdxpwEjO29+OpivIo1ICrLq9
 9+02FAIs0bFCy64IprS238sbR0m2xgSXrcdi6vxe5PUPdcOzHnEj8/LmCXEp6+JZ3NxWo
 kOMM8D0QE3/mcsqD9+iUdOpcjG/gfr6iZrI=

--xXl7D5GvoHRwpGzNjXql

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 96ebdb7a87917fd6ee74f46024ca756cc3d3d1ce upstream.

Add a device node for the Watchdog Timer (RWDT) controller on the Renesas
RZ/G2H (r8a774e1) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/1594811350-14066-18-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774e1.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
index 372f89e55887..0f86cfd52425 100644
--- a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
@@ -297,10 +297,14 @@
 		ranges;
 
 		rwdt: watchdog@e6020000 {
+			compatible = "renesas,r8a774e1-wdt",
+				     "renesas,rcar-gen3-wdt";
 			reg = <0 0xe6020000 0 0x0c>;
+			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 402>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			resets = <&cpg 402>;
 			status = "disabled";
-
-			/* placeholder */
 		};
 
 		gpio0: gpio@e6050000 {
-- 
2.17.1


--xXl7D5GvoHRwpGzNjXql
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5271): https://lists.cip-project.org/g/cip-dev/message=
/5271
Mute This Topic: https://lists.cip-project.org/mt/76426364/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--xXl7D5GvoHRwpGzNjXql--
