Return-Path: <SRS0=DZkC=FE=lists.cip-project.org=bounce+64572+5900+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8080C64E7B
	for <cip-dev@archiver.kernel.org>; Mon, 30 Nov 2020 14:19:34 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B80F2084C
	for <cip-dev@archiver.kernel.org>; Mon, 30 Nov 2020 14:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="EhneSiJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B80F2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5900+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Y8OcYY4521723xvIFxUNneVB; Mon, 30 Nov 2020 06:19:33 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.60324.1606745963854532164
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Nov 2020 06:19:33 -0800
X-IronPort-AV: E=Sophos;i="5.78,381,1599490800"; 
   d="scan'208";a="64149824"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 30 Nov 2020 23:19:33 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 052CA49708F6;
	Mon, 30 Nov 2020 23:19:31 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 10/11] soc: renesas: Identify RZ/G1C
Date: Mon, 30 Nov 2020 14:19:15 +0000
Message-Id: <20201130141916.8211-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201130141916.8211-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201130141916.8211-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: KnIBaUcmuU9qHnMP8qb3xW4vx4520388AA=
Content-Type: multipart/mixed; boundary="670VfAuIt5dFBbtVig4K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606745973;
 bh=Qq0wVJs0no7eEH9L1MZQg3GAVO/pcD36+CGgmeFrZgY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=EhneSiJYFaDvj7V8HvEdHyJbvQ/HwQHj/xtiTVJQ6TvwwUp/lSvHgjE1/CEP6pc9J8d
 NHBKkUfletekwBS12pUDbmct1WWllpUMJ4pkBUqR673oXN85p2C/YFqRZ7tHdnMebjmfz
 3zPPP/Mh8yjPNd4IWAb1sTWJsLYaK5gefas=

--670VfAuIt5dFBbtVig4K

From: Biju Das <biju.das@bp.renesas.com>

commit 1daf13ba10378cad9ea4f5f26b83dd36c36dcdc0 upstream.

Add support for identifying the RZ/G1C (r8a77470) SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[PL: manually applied the changes, replaced fam_rzg1 to fam_rzg,
enabled SOC_BUS config for RZ/G1C]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm/mach-shmobile/Kconfig    | 1 +
 drivers/soc/renesas/renesas-soc.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 6812b3e19ba3..017d03d3e4e5 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -89,6 +89,7 @@ config ARCH_R8A7745
 config ARCH_R8A77470
 	bool "RZ/G1C (R8A77470)"
 	select ARCH_RCAR_GEN2
+	select SOC_BUS
 
 config ARCH_R8A7778
 	bool "R-Car M1A (R8A77781)"
diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index eaa540bfc9bd..a267c7637003 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -55,6 +55,11 @@ static const struct renesas_soc soc_rz_g1e __initconst __maybe_unused = {
 	.id	= 0x4c,
 };
 
+static const struct renesas_soc soc_rz_g1c __initconst __maybe_unused = {
+	.family	= &fam_rzg,
+	.id	= 0x53,
+};
+
 static const struct of_device_id renesas_socs[] __initconst = {
 #ifdef CONFIG_ARCH_R8A7742
 	{ .compatible = "renesas,r8a7742",	.data = &soc_rz_g1h },
@@ -67,6 +72,9 @@ static const struct of_device_id renesas_socs[] __initconst = {
 #endif
 #ifdef CONFIG_ARCH_R8A7745
 	{ .compatible = "renesas,r8a7745",	.data = &soc_rz_g1e },
+#endif
+#ifdef CONFIG_ARCH_R8A77470
+	{ .compatible = "renesas,r8a77470",	.data = &soc_rz_g1c },
 #endif
 	{ /* sentinel */ }
 };
-- 
2.17.1


--670VfAuIt5dFBbtVig4K
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5900): https://lists.cip-project.org/g/cip-dev/message=
/5900
Mute This Topic: https://lists.cip-project.org/mt/78608811/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--670VfAuIt5dFBbtVig4K--
