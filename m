Return-Path: <SRS0=1T+y=FF=lists.cip-project.org=bounce+64572+5921+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09845C64E7A
	for <cip-dev@archiver.kernel.org>; Tue,  1 Dec 2020 08:39:56 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8716F2054F
	for <cip-dev@archiver.kernel.org>; Tue,  1 Dec 2020 08:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="kF4tJTFi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8716F2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5921+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ZUWvYY4521723xWu6bibnbNe; Tue, 01 Dec 2020 00:39:53 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.7147.1606811992292120940
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Dec 2020 00:39:52 -0800
X-IronPort-AV: E=Sophos;i="5.78,383,1599490800"; 
   d="scan'208";a="64471876"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Dec 2020 17:39:51 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id AAE014256B64;
	Tue,  1 Dec 2020 17:39:50 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH v2 4.4.y-cip 08/11] soc: renesas: Identify RZ/G1H
Date: Tue,  1 Dec 2020 08:39:35 +0000
Message-Id: <20201201083938.32688-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201201083938.32688-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201201083938.32688-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 7usKT4HdnIFkKngvKpAzDQHxx4520388AA=
Content-Type: multipart/mixed; boundary="qDUh70dTC2w2FV08j29s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606811993;
 bh=RCI6KWSNmrJZ6Z+Lo+SysgwOivCSiJFiyThTjZnoQts=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=kF4tJTFigfjas1sy8kViJZLUwXeWMRAGOYKFZWkQuGXMgFN2Sy3mHBsf0vk+e/WiJM2
 di7RR//lBCfwHc2zrA06Ktw9QhNsbmEvbpF4j/Yr9rvOReDEnCpInK3RF+SjDijz/fw8b
 Yko3HWPMwExhms1ri6bcewQYc3XacNwjsZI=

--qDUh70dTC2w2FV08j29s

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 8848e1b14231a40ed66229fb3ee98519b32f2ae7 upstream.

Add support for identifying the RZ/G1H (r8a7742) SoC.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[PL: manually applied the changes, enabled SOC_BUS config for RZ/G1N]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm/mach-shmobile/Kconfig    | 1 +
 drivers/soc/renesas/renesas-soc.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 8b84eb630dee..6812b3e19ba3 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -68,6 +68,7 @@ config ARCH_R8A7742
 	bool "RZ/G1H (R8A77420)"
 	select ARCH_RCAR_GEN2
 	select ARM_ERRATA_798181 if SMP
+	select SOC_BUS
 
 config ARCH_R8A7743
 	bool "RZ/G1M (R8A77430)"
diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index 2cf62855cc45..eaa540bfc9bd 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -35,6 +35,11 @@ struct renesas_soc {
 	u8 id;
 };
 
+static const struct renesas_soc soc_rz_g1h __initconst __maybe_unused = {
+	.family	= &fam_rzg,
+	.id	= 0x45,
+};
+
 static const struct renesas_soc soc_rz_g1m __initconst __maybe_unused = {
 	.family	= &fam_rzg,
 	.id	= 0x47,
@@ -51,6 +56,9 @@ static const struct renesas_soc soc_rz_g1e __initconst __maybe_unused = {
 };
 
 static const struct of_device_id renesas_socs[] __initconst = {
+#ifdef CONFIG_ARCH_R8A7742
+	{ .compatible = "renesas,r8a7742",	.data = &soc_rz_g1h },
+#endif
 #ifdef CONFIG_ARCH_R8A7743
 	{ .compatible = "renesas,r8a7743",	.data = &soc_rz_g1m },
 #endif
-- 
2.17.1


--qDUh70dTC2w2FV08j29s
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5921): https://lists.cip-project.org/g/cip-dev/message=
/5921
Mute This Topic: https://lists.cip-project.org/mt/78628866/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--qDUh70dTC2w2FV08j29s--
