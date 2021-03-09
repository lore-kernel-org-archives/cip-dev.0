Return-Path: <SRS0=7nC/=IH=lists.cip-project.org=bounce+64572+6247+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAC0C433DB
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:43 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E76C064F35
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E76C064F35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6247+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 9EXVYY4521723xRHpiYSBBIf; Tue, 09 Mar 2021 08:37:42 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.11726.1615307822860198874
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Mar 2021 08:37:41 -0800
X-IronPort-AV: E=Sophos;i="5.81,236,1610377200"; 
   d="scan'208";a="74591043"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Mar 2021 01:37:40 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A038440A2DC7;
	Wed, 10 Mar 2021 01:37:39 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 31/40] arm64: dts: renesas: r8a774b1: Add VIN and CSI-2 support
Date: Tue,  9 Mar 2021 16:36:47 +0000
Message-Id: <20210309163656.20944-32-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: vVcS5mFRFQiAZMvZBfsUBspAx4520388AA=
Content-Type: multipart/mixed; boundary="6ILOivGmPrmSsUvdaRTh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615307862;
 bh=DrRbRZwPBXHn+rxyjp3YL9evZfGX0eOK41BY7WrqPUs=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=uOL+vP4gm/q6rErNszAMtUxtzYYNgOYS7qdaRGxZmjZ001niQCozt1GaYVPh2CfFagO
 1ojgKXxRBPkgVZuILwKcysXP8zyzyDvAlQKFy5ALFcrfDKmoqSWXJWqwR6HudvTxENpsK
 eCFnVY3Y4rqIqrYHk1n5iphBUbUTd+dNv90=

--6ILOivGmPrmSsUvdaRTh

From: Biju Das <biju.das@bp.renesas.com>

commit bf216639036607dd35d8a5724b9deaee478ee684 upstream.

Add VIN and CSI-2 support to the RZ/G2N SoC specific dtsi.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Link: https://lore.kernel.org/r/1571137271-33973-1-git-send-email-biju.das@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi | 366 ++++++++++++++++++++++
 1 file changed, 366 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774b1.dtsi b/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
index 0e5bfaeda983..2f28f3fdeb26 100644
--- a/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
@@ -1284,6 +1284,262 @@
 			status = "disabled";
 		};
 
+		vin0: video@e6ef0000 {
+			compatible = "renesas,vin-r8a774b1";
+			reg = <0 0xe6ef0000 0 0x1000>;
+			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 811>;
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			resets = <&cpg 811>;
+			renesas,id = <0>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <1>;
+
+					vin0csi20: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&csi20vin0>;
+					};
+					vin0csi40: endpoint@2 {
+						reg = <2>;
+						remote-endpoint = <&csi40vin0>;
+					};
+				};
+			};
+		};
+
+		vin1: video@e6ef1000 {
+			compatible = "renesas,vin-r8a774b1";
+			reg = <0 0xe6ef1000 0 0x1000>;
+			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 810>;
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			resets = <&cpg 810>;
+			renesas,id = <1>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <1>;
+
+					vin1csi20: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&csi20vin1>;
+					};
+					vin1csi40: endpoint@2 {
+						reg = <2>;
+						remote-endpoint = <&csi40vin1>;
+					};
+				};
+			};
+		};
+
+		vin2: video@e6ef2000 {
+			compatible = "renesas,vin-r8a774b1";
+			reg = <0 0xe6ef2000 0 0x1000>;
+			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 809>;
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			resets = <&cpg 809>;
+			renesas,id = <2>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <1>;
+
+					vin2csi20: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&csi20vin2>;
+					};
+					vin2csi40: endpoint@2 {
+						reg = <2>;
+						remote-endpoint = <&csi40vin2>;
+					};
+				};
+			};
+		};
+
+		vin3: video@e6ef3000 {
+			compatible = "renesas,vin-r8a774b1";
+			reg = <0 0xe6ef3000 0 0x1000>;
+			interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 808>;
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			resets = <&cpg 808>;
+			renesas,id = <3>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <1>;
+
+					vin3csi20: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&csi20vin3>;
+					};
+					vin3csi40: endpoint@2 {
+						reg = <2>;
+						remote-endpoint = <&csi40vin3>;
+					};
+				};
+			};
+		};
+
+		vin4: video@e6ef4000 {
+			compatible = "renesas,vin-r8a774b1";
+			reg = <0 0xe6ef4000 0 0x1000>;
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 807>;
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			resets = <&cpg 807>;
+			renesas,id = <4>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <1>;
+
+					vin4csi20: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&csi20vin4>;
+					};
+					vin4csi40: endpoint@2 {
+						reg = <2>;
+						remote-endpoint = <&csi40vin4>;
+					};
+				};
+			};
+		};
+
+		vin5: video@e6ef5000 {
+			compatible = "renesas,vin-r8a774b1";
+			reg = <0 0xe6ef5000 0 0x1000>;
+			interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 806>;
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			resets = <&cpg 806>;
+			renesas,id = <5>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <1>;
+
+					vin5csi20: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&csi20vin5>;
+					};
+					vin5csi40: endpoint@2 {
+						reg = <2>;
+						remote-endpoint = <&csi40vin5>;
+					};
+				};
+			};
+		};
+
+		vin6: video@e6ef6000 {
+			compatible = "renesas,vin-r8a774b1";
+			reg = <0 0xe6ef6000 0 0x1000>;
+			interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 805>;
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			resets = <&cpg 805>;
+			renesas,id = <6>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <1>;
+
+					vin6csi20: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&csi20vin6>;
+					};
+					vin6csi40: endpoint@2 {
+						reg = <2>;
+						remote-endpoint = <&csi40vin6>;
+					};
+				};
+			};
+		};
+
+		vin7: video@e6ef7000 {
+			compatible = "renesas,vin-r8a774b1";
+			reg = <0 0xe6ef7000 0 0x1000>;
+			interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 804>;
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			resets = <&cpg 804>;
+			renesas,id = <7>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <1>;
+
+					vin7csi20: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&csi20vin7>;
+					};
+					vin7csi40: endpoint@2 {
+						reg = <2>;
+						remote-endpoint = <&csi40vin7>;
+					};
+				};
+			};
+		};
+
 		rcar_sound: sound@ec500000 {
 			/*
 			 * #sound-dai-cells is required
@@ -2116,6 +2372,116 @@
 			resets = <&cpg 611>;
 		};
 
+		csi20: csi2@fea80000 {
+			compatible = "renesas,r8a774b1-csi2";
+			reg = <0 0xfea80000 0 0x10000>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 714>;
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			resets = <&cpg 714>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <1>;
+
+					csi20vin0: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&vin0csi20>;
+					};
+					csi20vin1: endpoint@1 {
+						reg = <1>;
+						remote-endpoint = <&vin1csi20>;
+					};
+					csi20vin2: endpoint@2 {
+						reg = <2>;
+						remote-endpoint = <&vin2csi20>;
+					};
+					csi20vin3: endpoint@3 {
+						reg = <3>;
+						remote-endpoint = <&vin3csi20>;
+					};
+					csi20vin4: endpoint@4 {
+						reg = <4>;
+						remote-endpoint = <&vin4csi20>;
+					};
+					csi20vin5: endpoint@5 {
+						reg = <5>;
+						remote-endpoint = <&vin5csi20>;
+					};
+					csi20vin6: endpoint@6 {
+						reg = <6>;
+						remote-endpoint = <&vin6csi20>;
+					};
+					csi20vin7: endpoint@7 {
+						reg = <7>;
+						remote-endpoint = <&vin7csi20>;
+					};
+				};
+			};
+		};
+
+		csi40: csi2@feaa0000 {
+			compatible = "renesas,r8a774b1-csi2";
+			reg = <0 0xfeaa0000 0 0x10000>;
+			interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 716>;
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			resets = <&cpg 716>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <1>;
+
+					csi40vin0: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&vin0csi40>;
+					};
+					csi40vin1: endpoint@1 {
+						reg = <1>;
+						remote-endpoint = <&vin1csi40>;
+					};
+					csi40vin2: endpoint@2 {
+						reg = <2>;
+						remote-endpoint = <&vin2csi40>;
+					};
+					csi40vin3: endpoint@3 {
+						reg = <3>;
+						remote-endpoint = <&vin3csi40>;
+					};
+					csi40vin4: endpoint@4 {
+						reg = <4>;
+						remote-endpoint = <&vin4csi40>;
+					};
+					csi40vin5: endpoint@5 {
+						reg = <5>;
+						remote-endpoint = <&vin5csi40>;
+					};
+					csi40vin6: endpoint@6 {
+						reg = <6>;
+						remote-endpoint = <&vin6csi40>;
+					};
+					csi40vin7: endpoint@7 {
+						reg = <7>;
+						remote-endpoint = <&vin7csi40>;
+					};
+				};
+			};
+		};
+
 		hdmi0: hdmi@fead0000 {
 			compatible = "renesas,r8a774b1-hdmi",
 				     "renesas,rcar-gen3-hdmi";
-- 
2.17.1


--6ILOivGmPrmSsUvdaRTh
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6247): https://lists.cip-project.org/g/cip-dev/message=
/6247
Mute This Topic: https://lists.cip-project.org/mt/81205382/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--6ILOivGmPrmSsUvdaRTh--
