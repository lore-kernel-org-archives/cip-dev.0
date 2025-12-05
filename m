Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253C3D32D80
	for <webhook@archiver.kernel.org>; Fri,  5 Dec 2025 14:33:52 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6938.1764945225571344838
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Dec 2025 06:33:47 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: X8cLNs0hSJG6A6FqLC/nTw==
X-CSE-MsgGUID: zhZipEtlTQOjk/N/m1kLwg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 05 Dec 2025 23:33:46 +0900
Received: from Ubuntu-22.. (unknown [10.24.1.60])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 61FDF4179CE0;
	Fri,  5 Dec 2025 23:33:45 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 26/38] pinctrl: renesas: rzt2h: Add support for RZ/N2H
Date: Fri,  5 Dec 2025 14:32:46 +0000
Message-ID: <20251205143258.13748-27-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Dec 2025 14:33:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20940

commit d1d31e2739ff063da1e85cd9b44316ca5cccdba8 upstream.

The Renesas RZ/N2H (R9A09G087) SoC shares a similar pin controller
architecture with the RZ/T2H (R9A09G077) SoC, differing primarily in the
number of supported pins: 576 on RZ/N2H versus 729 on RZ/T2H.

Add the necessary pin configuration data and compatible string to enable
support for the RZ/N2H SoC in the RZ/T2H pinctrl driver.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250808133017.2053637-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pinctrl/renesas/Kconfig         |  1 +
 drivers/pinctrl/renesas/pinctrl-rzt2h.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/pinctrl/renesas/Kconfig b/drivers/pinctrl/renesas/Kconfig
index 99f290ae77aaf..27ddc5dc46194 100644
--- a/drivers/pinctrl/renesas/Kconfig
+++ b/drivers/pinctrl/renesas/Kconfig
@@ -45,6 +45,7 @@ config PINCTRL_RENESAS
 	select PINCTRL_RZG2L if ARCH_R9A09G056
 	select PINCTRL_RZG2L if ARCH_R9A09G057
 	select PINCTRL_RZT2H if ARCH_R9A09G077
+	select PINCTRL_RZT2H if ARCH_R9A09G087
 	select PINCTRL_PFC_SH7203 if CPU_SUBTYPE_SH7203
 	select PINCTRL_PFC_SH7264 if CPU_SUBTYPE_SH7264
 	select PINCTRL_PFC_SH7269 if CPU_SUBTYPE_SH7269
diff --git a/drivers/pinctrl/renesas/pinctrl-rzt2h.c b/drivers/pinctrl/renesas/pinctrl-rzt2h.c
index 02dcd79247cd3..d567612b30953 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzt2h.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzt2h.c
@@ -760,17 +760,33 @@ static const u8 r9a09g077_gpio_configs[] = {
 	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x7f,
 };
 
+static const u8 r9a09g087_gpio_configs[] = {
+	0x1f, 0xff, 0xff, 0x1f, 0x00, 0xfe, 0xff, 0x00, 0x7e, 0xf0, 0xff, 0x01,
+	0xff, 0xff, 0xff, 0x00, 0xe0, 0xff, 0xff, 0x00, 0xff, 0xff, 0xff, 0x01,
+	0xe0, 0xff, 0xff, 0x7f, 0x00, 0xfe, 0xff, 0x7f, 0x00, 0xfc, 0x7f,
+};
+
 static struct rzt2h_pinctrl_data r9a09g077_data = {
 	.n_port_pins = ARRAY_SIZE(r9a09g077_gpio_configs) * RZT2H_PINS_PER_PORT,
 	.port_pin_configs = r9a09g077_gpio_configs,
 	.n_ports = ARRAY_SIZE(r9a09g077_gpio_configs),
 };
 
+static struct rzt2h_pinctrl_data r9a09g087_data = {
+	.n_port_pins = ARRAY_SIZE(r9a09g087_gpio_configs) * RZT2H_PINS_PER_PORT,
+	.port_pin_configs = r9a09g087_gpio_configs,
+	.n_ports = ARRAY_SIZE(r9a09g087_gpio_configs),
+};
+
 static const struct of_device_id rzt2h_pinctrl_of_table[] = {
 	{
 		.compatible = "renesas,r9a09g077-pinctrl",
 		.data = &r9a09g077_data,
 	},
+	{
+		.compatible = "renesas,r9a09g087-pinctrl",
+		.data = &r9a09g087_data,
+	},
 	{ /* sentinel */ }
 };
 
-- 
2.43.0


