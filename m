Return-Path: <SRS0=ERJS=EJ=lists.cip-project.org=bounce+64572+5725+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BA9C2D0A3
	for <cip-dev@archiver.kernel.org>; Tue,  3 Nov 2020 17:33:56 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 646CA22226
	for <cip-dev@archiver.kernel.org>; Tue,  3 Nov 2020 17:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="bERS3z5G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 646CA22226
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5725+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id mmr7YY4521723xfLFaEyKRDX; Tue, 03 Nov 2020 09:33:55 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.794.1604424834598542940
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Nov 2020 09:33:54 -0800
X-IronPort-AV: E=Sophos;i="5.77,448,1596466800"; 
   d="scan'208";a="61344831"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 04 Nov 2020 02:33:54 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 267FE4009BE5;
	Wed,  4 Nov 2020 02:33:52 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 12/17] arm64: dts: renesas: r8a774e1-hihope-rzg2h: Setup DU clocks
Date: Tue,  3 Nov 2020 17:33:31 +0000
Message-Id: <20201103173336.2829-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201103173336.2829-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201103173336.2829-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ozSUH0UJndpSkztcrYrNcBIkx4520388AA=
Content-Type: multipart/mixed; boundary="reyfQhfFtQHVQmYctJDb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604424835;
 bh=N8Qut6Vzo+TAcv4BVhEJoDe/fp+5pR8bravTtUb9L2M=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=bERS3z5GX8nnNFQDg3dnjPmtT4pJoBPLQ3Ok+7zQvFDneg2n7dPCqMsGe/pVIAjHfhE
 jXN/WB+0ToV6xqb16Rq/71groF2uJ35NPchkqVOefcvftqAL0yMywAkZVeZaHk+jBxnhz
 ghz0wV2zdSpBIT9J453ZMBZb8ButayMt3k0=

--reyfQhfFtQHVQmYctJDb

commit 2e23a1db4840e6adf4072802d4d91edf4a375b90 upstream.

Setup up the required clocks for the DU to be functional.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://lore.kernel.org/r/20200812140217.24251-10-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h.dts b/arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h.dts
index cdbe527e9340..12f9242e263b 100644
--- a/arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h.dts
+++ b/arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h.dts
@@ -24,3 +24,14 @@
 		reg = <0x5 0x00000000 0x0 0x80000000>;
 	};
 };
+
+&du {
+	clocks = <&cpg CPG_MOD 724>,
+		 <&cpg CPG_MOD 723>,
+		 <&cpg CPG_MOD 721>,
+		 <&versaclock5 1>,
+		 <&x302_clk>,
+		 <&versaclock5 2>;
+	clock-names = "du.0", "du.1", "du.3",
+		      "dclkin.0", "dclkin.1", "dclkin.3";
+};
-- 
2.17.1


--reyfQhfFtQHVQmYctJDb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5725): https://lists.cip-project.org/g/cip-dev/message=
/5725
Mute This Topic: https://lists.cip-project.org/mt/78011704/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--reyfQhfFtQHVQmYctJDb--
