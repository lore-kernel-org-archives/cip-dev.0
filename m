Return-Path: <SRS0=sfto=E5=lists.cip-project.org=bounce+64572+5814+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9005C2D0E4
	for <cip-dev@archiver.kernel.org>; Mon, 23 Nov 2020 10:55:00 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA27520721
	for <cip-dev@archiver.kernel.org>; Mon, 23 Nov 2020 10:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="nFxbpaSP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA27520721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5814+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Qk5KYY4521723xXW75XcgRsB; Mon, 23 Nov 2020 02:54:58 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.33730.1606128898253595216
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Nov 2020 02:54:58 -0800
X-IronPort-AV: E=Sophos;i="5.78,363,1599490800"; 
   d="scan'208";a="63369017"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 23 Nov 2020 19:54:57 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2B92342697A9;
	Mon, 23 Nov 2020 19:54:55 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 1/2] arm64: dts: renesas: r8a774e1: Add missing audio_clk_b
Date: Mon, 23 Nov 2020 10:54:52 +0000
Message-Id: <20201123105453.22074-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201123105453.22074-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201123105453.22074-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ByRwslP1CN7bbKNsZtpucGSZx4520388AA=
Content-Type: multipart/mixed; boundary="Zv9rFwjRmyDX3X33jSho"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606128898;
 bh=p8J/wH538IHKP1B9Zn4jeF+A9WQfo0WOxBKvuGxdkQU=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=nFxbpaSPRh2FGV2gXMG0HOl9wiQ03ZKd/KWgJP/6d5fNuq2kDX1E5O+PuBL7qMIqXFC
 WNFDYkQvMcocYh6lKjoWd+TGsQtk7uCmvyn/jolqgoAW63V3htgFfWllPFQhGWLV3vWTd
 UjxuToZRdn4LAJVB9fNxfSuoU9Gf6F4Uugw=

--Zv9rFwjRmyDX3X33jSho

commit 7de8bfaa095fcbc2db2952d4b561be102a41c2a6 upstream.

Add audio_clk_b configured as 0 Hz, this will be overridden by the
boards providing the audio clock.

Fixes: 8183a7938cfec ("arm64: dts: renesas: r8a774e1: Add audio support")
Reported-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20201104105508.21197-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774e1.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
index 154f13e20181..18bc2a11b9c8 100644
--- a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
@@ -28,6 +28,12 @@
 		clock-frequency = <0>;
 	};
 
+	audio_clk_b: audio_clk_b {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
 	audio_clk_c: audio_clk_c {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-- 
2.17.1


--Zv9rFwjRmyDX3X33jSho
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5814): https://lists.cip-project.org/g/cip-dev/message=
/5814
Mute This Topic: https://lists.cip-project.org/mt/78450805/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Zv9rFwjRmyDX3X33jSho--
