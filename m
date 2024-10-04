Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3F7CFA760
	for <webhook@archiver.kernel.org>; Fri,  4 Oct 2024 10:23:43 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.18643.1728037413515252963
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Oct 2024 03:23:37 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.11,177,1725289200"; 
   d="scan'208";a="220808733"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 04 Oct 2024 19:23:37 +0900
Received: from localhost.localdomain (unknown [10.226.92.178])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 41B0640065D0;
	Fri,  4 Oct 2024 19:23:33 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 3/3] arm64: dts: renesas: rzg2lc-smarc: Enable HDMI audio
Date: Fri,  4 Oct 2024 11:23:23 +0100
Message-ID: <20241004102326.73157-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004102326.73157-1-biju.das.jz@bp.renesas.com>
References: <20241004102326.73157-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Oct 2024 10:23:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16997

commit 7fe722ee4c5a2f6d718db18e5f654dd28394f097 upstream.

Enable HDMI audio on the RZ/G2LC SMARC EVK.  Set SW 1.5 on the SoM
module to the OFF position to turn on HDMI audio.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240826090803.56176-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../boot/dts/renesas/r9a07g044c2-smarc.dts    |  3 ++
 arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi | 33 +++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dts b/arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dts
index 0b90367b6d1e..ee5bf2c58051 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dts
@@ -47,6 +47,9 @@
 #error "Cannot set as both PMOD_MTU3 and SW_RSPI_CAN are mutually exclusive"
 #endif
 
+/* Please set SW_I2S0_I2S1. Default value is 0 */
+#define SW_I2S0_I2S1   0
+
 #include "r9a07g044c2.dtsi"
 #include "rzg2lc-smarc-som.dtsi"
 #include "rzg2lc-smarc.dtsi"
diff --git a/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
index 969153a86510..47b5013b984e 100644
--- a/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
@@ -36,6 +36,16 @@ hdmi_con_out: endpoint {
 			};
 		};
 	};
+
+#if (SW_I2S0_I2S1)
+	/delete-node/ sound;
+
+	sound_card {
+		compatible = "audio-graph-card";
+		label = "HDMI-Audio";
+		dais = <&i2s2_port>;
+	};
+#endif
 };
 
 #if (SW_SCIF_CAN || SW_RSPI_CAN)
@@ -51,9 +61,11 @@ &canfd {
 };
 #endif
 
+#if (!SW_I2S0_I2S1)
 &cpu_dai {
 	sound-dai = <&ssi0>;
 };
+#endif
 
 &dsi {
 	status = "okay";
@@ -107,6 +119,15 @@ adv7535_out: endpoint {
 					remote-endpoint = <&hdmi_con_out>;
 				};
 			};
+
+#if (SW_I2S0_I2S1)
+			port@2 {
+				reg = <2>;
+				codec_endpoint: endpoint {
+					remote-endpoint = <&i2s2_cpu_endpoint>;
+				};
+			};
+#endif
 		};
 	};
 };
@@ -185,6 +206,18 @@ &ssi0 {
 	pinctrl-names = "default";
 
 	status = "okay";
+
+#if (SW_I2S0_I2S1)
+	i2s2_port: port {
+		i2s2_cpu_endpoint: endpoint {
+			remote-endpoint = <&codec_endpoint>;
+			dai-format = "i2s";
+
+			bitclock-master = <&i2s2_cpu_endpoint>;
+			frame-master = <&i2s2_cpu_endpoint>;
+		};
+	};
+#endif
 };
 
 #if (SW_RSPI_CAN)
-- 
2.43.0


