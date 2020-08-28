Return-Path: <SRS0=N0ai=CG=lists.cip-project.org=bounce+64572+5301+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755BBC2BBDB
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:47 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4779E208C9
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="lLhxtGVa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4779E208C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5301+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Sj3sYY4521723xlkZimKlF6V; Fri, 28 Aug 2020 09:07:47 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.45837.1598629320009468924
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Aug 2020 08:42:22 -0700
X-IronPort-AV: E=Sophos;i="5.76,364,1592838000"; 
   d="scan'208";a="55587863"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 29 Aug 2020 00:42:21 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.245])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4F021400C9FD;
	Sat, 29 Aug 2020 00:42:20 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 11/30] ARM: debug-ll: Add support for r8a7742
Date: Fri, 28 Aug 2020 16:41:36 +0100
Message-Id: <20200828154155.5827-12-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
References: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: NjWaN0gmpFOdnM3O17WEgWE8x4520388AA=
Content-Type: multipart/mixed; boundary="gHGn6yxhP2GLGuGkmCra"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598630867;
 bh=iyT/pPN8jo4LrpbghFJZbRgz1PpiPNYM/T5aX+00iUE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=lLhxtGVathFprTtrKN/iuKN+XIStDxc5nM+8+jMH35mqY/bwvJUBf9NRkrHxAYSTFuX
 QLShcku54jaVHUYvvXCuKbtD0yUd6anKKEC8ysWclHHMajN9VSvrtikkcNISqivTEHAxM
 vPUtBTpqb5cEG3iZ8hTh+99dV1fMTyiMiGQ=

--gHGn6yxhP2GLGuGkmCra

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 96866b1a1d32318b6bbc321a762bf79db1f4686e upstream.

Enable low-level debugging support for RZ/G1H (R8A7742). RZ/G1H uses
SCIFA2 for the debug console.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/1588197415-13747-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm/Kconfig.debug | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index f647c067d930..7df076789a3a 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -846,6 +846,13 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  via SCIF4 on Renesas RZ/G1E (R8A7745).
 
+	config DEBUG_RCAR_GEN2_SCIFA2
+		bool "Kernel low-level debugging messages via SCIFA2 on R8A7742"
+		depends on ARCH_R8A7742
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  via SCIFA2 on Renesas RZ/G1H (R8A7742).
+
 	config DEBUG_RMOBILE_SCIFA0
 		bool "Kernel low-level debugging messages via SCIFA0 on R8A73A4"
 		depends on ARCH_R8A73A4
@@ -1351,6 +1358,7 @@ config DEBUG_LL_INCLUDE
 	default "debug/renesas-scif.S" if DEBUG_RCAR_GEN2_SCIF1
 	default "debug/renesas-scif.S" if DEBUG_RCAR_GEN2_SCIF2
 	default "debug/renesas-scif.S" if DEBUG_RCAR_GEN2_SCIF4
+	default "debug/renesas-scif.S" if DEBUG_RCAR_GEN2_SCIFA2
 	default "debug/renesas-scif.S" if DEBUG_RMOBILE_SCIFA0
 	default "debug/renesas-scif.S" if DEBUG_RMOBILE_SCIFA1
 	default "debug/renesas-scif.S" if DEBUG_RMOBILE_SCIFA4
@@ -1448,6 +1456,7 @@ config DEBUG_UART_PHYS
 	default 0xe4007000 if DEBUG_HIP04_UART
 	default 0xe6c40000 if DEBUG_RMOBILE_SCIFA0
 	default 0xe6c50000 if DEBUG_RMOBILE_SCIFA1
+	default 0xe6c60000 if DEBUG_RCAR_GEN2_SCIFA2
 	default 0xe6c80000 if DEBUG_RMOBILE_SCIFA4
 	default 0xe6e58000 if DEBUG_RCAR_GEN2_SCIF2
 	default 0xe6e60000 if DEBUG_RCAR_GEN2_SCIF0
@@ -1487,6 +1496,7 @@ config DEBUG_UART_PHYS
 		DEBUG_RCAR_GEN1_SCIF0 || DEBUG_RCAR_GEN1_SCIF2 || \
 		DEBUG_RCAR_GEN2_SCIF0 || DEBUG_RCAR_GEN2_SCIF1 || \
 		DEBUG_RCAR_GEN2_SCIF2 || DEBUG_RCAR_GEN2_SCIF4 || \
+		DEBUG_RCAR_GEN2_SCIFA2 || \
 		DEBUG_RMOBILE_SCIFA0 || DEBUG_RMOBILE_SCIFA1 || \
 		DEBUG_RMOBILE_SCIFA4 || DEBUG_S3C24XX_UART || \
 		DEBUG_BCM63XX_UART || DEBUG_ASM9260_UART || \
-- 
2.17.1


--gHGn6yxhP2GLGuGkmCra
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5301): https://lists.cip-project.org/g/cip-dev/message=
/5301
Mute This Topic: https://lists.cip-project.org/mt/76477084/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--gHGn6yxhP2GLGuGkmCra--
