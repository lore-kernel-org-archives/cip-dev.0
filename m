Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D87C369D9
	for <webhook@archiver.kernel.org>; Fri, 25 Apr 2025 12:15:29 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.5125.1745583308658722051
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Apr 2025 05:15:21 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: yxiGHtNWTYmyxsT3aiO5ag==
X-CSE-MsgGUID: u3Kz798XQ/e17pambZKxIg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 25 Apr 2025 21:15:21 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.1])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 58B0B42D7EC8;
	Fri, 25 Apr 2025 21:15:19 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.1.y-cip 15/21] mmc: renesas_sdhi: Add compatible string for RZ/G2L family, RZ/G3S, and RZ/V2M SoCs
Date: Fri, 25 Apr 2025 13:14:39 +0100
Message-ID: <20250425121445.62818-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425121445.62818-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250425121445.62818-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Apr 2025 12:15:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18637

commit 35eea0defb6e46b26e286066e0e77ac5d53e7fba upstream.

- RZ/G2UL and RZ/Five ("r9a07g043")
- RZ/G2L(C) ("r9a07g044")
- RZ/V2L ("r9a07g054")
- RZ/G3S ("r9a08g045")
- RZ/V2M ("r9a09g011")

The above SoCs have HS400 disabled and use fixed address mode. Add a
generic compatible 'renesas,rzg2l-sdhi' fallback string for these SoCs,
where fixed_addr_mode and hs400_disabled quirks are applied.

For backward compatibility, compatible string 'renesas,sdhi-r9a09g011' for
RZ/V2M is retained.

Also rename sdhi_quirks_r9a09g011->sdhi_quirks_rzg2l and
of_r9a09g011_compatible->of_rzg2l_compatible to make it generic.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20240430145937.133643-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 3e254f76c1c6b..0572b39428562 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -211,7 +211,7 @@ static const struct renesas_sdhi_quirks sdhi_quirks_r8a77990 = {
 	.manual_tap_correction = true,
 };
 
-static const struct renesas_sdhi_quirks sdhi_quirks_r9a09g011 = {
+static const struct renesas_sdhi_quirks sdhi_quirks_rzg2l = {
 	.fixed_addr_mode = true,
 	.hs400_disabled = true,
 };
@@ -257,9 +257,9 @@ static const struct renesas_sdhi_of_data_with_quirks of_r8a77990_compatible = {
 	.quirks = &sdhi_quirks_r8a77990,
 };
 
-static const struct renesas_sdhi_of_data_with_quirks of_r9a09g011_compatible = {
+static const struct renesas_sdhi_of_data_with_quirks of_rzg2l_compatible = {
 	.of_data = &of_data_rcar_gen3,
-	.quirks = &sdhi_quirks_r9a09g011,
+	.quirks = &sdhi_quirks_rzg2l,
 };
 
 static const struct renesas_sdhi_of_data_with_quirks of_rcar_gen3_compatible = {
@@ -285,7 +285,8 @@ static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
 	{ .compatible = "renesas,sdhi-r8a77970", .data = &of_r8a77970_compatible, },
 	{ .compatible = "renesas,sdhi-r8a77990", .data = &of_r8a77990_compatible, },
 	{ .compatible = "renesas,sdhi-r8a77995", .data = &of_rcar_gen3_nohs400_compatible, },
-	{ .compatible = "renesas,sdhi-r9a09g011", .data = &of_r9a09g011_compatible, },
+	{ .compatible = "renesas,sdhi-r9a09g011", .data = &of_rzg2l_compatible, },
+	{ .compatible = "renesas,rzg2l-sdhi", .data = &of_rzg2l_compatible, },
 	{ .compatible = "renesas,rcar-gen3-sdhi", .data = &of_rcar_gen3_compatible, },
 	{ .compatible = "renesas,rcar-gen4-sdhi", .data = &of_rcar_gen3_compatible, },
 	{},
-- 
2.43.0


