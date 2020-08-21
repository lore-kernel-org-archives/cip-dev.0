Return-Path: <SRS0=l97G=B7=lists.cip-project.org=bounce+64572+5205+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2E1C433EC
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:46 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 460652072D
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="BfE05msJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 460652072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5205+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id xOWNYY4521723xzPx3fGJE1N; Fri, 21 Aug 2020 03:58:46 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.131152.1598003016916343991
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2020 02:43:59 -0700
X-IronPort-AV: E=Sophos;i="5.76,335,1592838000"; 
   d="scan'208";a="54954604"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Aug 2020 18:43:58 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.2])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E08C44232061;
	Fri, 21 Aug 2020 18:43:56 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 23/36] pinctrl: sh-pfc: rcar-gen3: Rename RTS{0,1,3,4}# pin function definitions
Date: Fri, 21 Aug 2020 10:42:59 +0100
Message-Id: <20200821094312.3249-24-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
References: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: jdKPDcLmaoWPxYc0BtqlMqq7x4520388AA=
Content-Type: multipart/mixed; boundary="AziB6g08Hk12Qz7IQLyf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598007526;
 bh=5M/7gaVuEqAKpWPOCz7w1dL5LZRjQk+6n5yyWohRT7k=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=BfE05msJF5xsrzs4nJe/i4Ix7p74kcnp6ma3UJWeHT3jwo3B5a4ypwJg2dNOIX79nDS
 4PbnbOElgNfGdZ21iEj4+lt/vtCEW+OmZDqLmtxSprIJG1xjDNmrvpcFBxjMVynRIwpnS
 SGrVbxQcrC5VACfKCo2UKkAVeaPcn95LPrw=

--AziB6g08Hk12Qz7IQLyf

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

commit 624a7a12cc0cc776c9c82347ffe5ddce7218eeca upstream.

According to the R-Car Gen3 Hardware Manual Errata for Rev 1.50 of
Feb 12, 2019, the RTS{0,1,3,4}_#/TANS pin names defined in the GPSR and
IPSR registers are renamed to RTS{0,1,3,4}_#.
This patch updates the pin control drivers to reflect this.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[geert: Update R-Car H3 ES1.x, V3M, V3H, and D3]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
[Biju: removed E3 related changes since it is already backported]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c | 48 ++++++++++++------------
 drivers/pinctrl/sh-pfc/pfc-r8a77970.c    | 24 ++++++------
 drivers/pinctrl/sh-pfc/pfc-r8a77980.c    | 32 ++++++++--------
 drivers/pinctrl/sh-pfc/pfc-r8a77995.c    | 12 +++---
 4 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
index d92c979dfb98..97a6b0221855 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
@@ -155,11 +155,11 @@
 #define GPSR5_11	F_(RX2_A,		IP12_7_4)
 #define GPSR5_10	F_(TX2_A,		IP12_3_0)
 #define GPSR5_9		F_(SCK2,		IP11_31_28)
-#define GPSR5_8		F_(RTS1_N_TANS,		IP11_27_24)
+#define GPSR5_8		F_(RTS1_N,		IP11_27_24)
 #define GPSR5_7		F_(CTS1_N,		IP11_23_20)
 #define GPSR5_6		F_(TX1_A,		IP11_19_16)
 #define GPSR5_5		F_(RX1_A,		IP11_15_12)
-#define GPSR5_4		F_(RTS0_N_TANS,		IP11_11_8)
+#define GPSR5_4		F_(RTS0_N,		IP11_11_8)
 #define GPSR5_3		F_(CTS0_N,		IP11_7_4)
 #define GPSR5_2		F_(TX0,			IP11_3_0)
 #define GPSR5_1		F_(RX0,			IP10_31_28)
@@ -212,7 +212,7 @@
 #define IP0_11_8	FM(AVB_PHY_INT)		F_(0, 0)	FM(MSIOF2_SYNC_C)	FM(RX4_A)			F_(0, 0)	F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0_15_12	FM(AVB_LINK)		F_(0, 0)	FM(MSIOF2_SCK_C)	FM(TX4_A)			F_(0, 0)	F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0_19_16	FM(AVB_AVTP_MATCH_A)	F_(0, 0)	FM(MSIOF2_RXD_C)	FM(CTS4_N_A)			F_(0, 0)	F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0_23_20	FM(AVB_AVTP_CAPTURE_A)	F_(0, 0)	FM(MSIOF2_TXD_C)	FM(RTS4_N_TANS_A)		F_(0, 0)	F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0_23_20	FM(AVB_AVTP_CAPTURE_A)	F_(0, 0)	FM(MSIOF2_TXD_C)	FM(RTS4_N_A)			F_(0, 0)	F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0_27_24	FM(IRQ0)		FM(QPOLB)	F_(0, 0)		FM(DU_CDE)			FM(VI4_DATA0_B)	FM(CAN0_TX_B)	FM(CANFD0_TX_B)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0_31_28	FM(IRQ1)		FM(QPOLA)	F_(0, 0)		FM(DU_DISP)			FM(VI4_DATA1_B)	FM(CAN0_RX_B)	FM(CANFD0_RX_B)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1_3_0		FM(IRQ2)		FM(QCPV_QDE)	F_(0, 0)		FM(DU_EXODDF_DU_ODDF_DISP_CDE)	FM(VI4_DATA2_B)	F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)		FM(PWM3_B)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
@@ -234,7 +234,7 @@
 #define IP2_27_24	FM(A7)			FM(LCDOUT23)	FM(MSIOF2_SS2_A)	FM(TX4_B)			FM(VI4_DATA15)	FM(VI5_DATA15)	FM(DU_DB7)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP2_31_28	FM(A8)			FM(RX3_B)	FM(MSIOF2_SYNC_A)	FM(HRX4_B)			F_(0, 0)	F_(0, 0)	F_(0, 0)		FM(SDA6_A)	FM(AVB_AVTP_MATCH_B)	FM(PWM1_B)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP3_3_0		FM(A9)			F_(0, 0)	FM(MSIOF2_SCK_A)	FM(CTS4_N_B)			F_(0, 0)	FM(VI5_VSYNC_N)	F_(0, 0)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP3_7_4		FM(A10)			F_(0, 0)	FM(MSIOF2_RXD_A)	FM(RTS4_N_TANS_B)		F_(0, 0)	FM(VI5_HSYNC_N)	F_(0, 0)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP3_7_4		FM(A10)			F_(0, 0)	FM(MSIOF2_RXD_A)	FM(RTS4_N_B)			F_(0, 0)	FM(VI5_HSYNC_N)	F_(0, 0)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP3_11_8	FM(A11)			FM(TX3_B)	FM(MSIOF2_TXD_A)	FM(HTX4_B)			FM(HSCK4)	FM(VI5_FIELD)	F_(0, 0)		FM(SCL6_A)	FM(AVB_AVTP_CAPTURE_B)	FM(PWM2_B)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP3_15_12	FM(A12)			FM(LCDOUT12)	FM(MSIOF3_SCK_C)	F_(0, 0)			FM(HRX4_A)	FM(VI5_DATA8)	FM(DU_DG4)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP3_19_16	FM(A13)			FM(LCDOUT13)	FM(MSIOF3_SYNC_C)	F_(0, 0)			FM(HTX4_A)	FM(VI5_DATA9)	FM(DU_DG5)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
@@ -250,7 +250,7 @@
 #define IP4_27_24	FM(RD_N)		F_(0, 0)	FM(MSIOF3_SYNC_D)	FM(RX3_A)			FM(HRX3_A)	F_(0, 0)	F_(0, 0)		F_(0, 0)	FM(CAN0_TX_A)		FM(CANFD0_TX_A)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP4_31_28	FM(RD_WR_N)		F_(0, 0)	FM(MSIOF3_RXD_D)	FM(TX3_A)			FM(HTX3_A)	F_(0, 0)	F_(0, 0)		F_(0, 0)	FM(CAN0_RX_A)		FM(CANFD0_RX_A)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP5_3_0		FM(WE0_N)		F_(0, 0)	FM(MSIOF3_TXD_D)	FM(CTS3_N)			FM(HCTS3_N)	F_(0, 0)	F_(0, 0)		FM(SCL6_B)	FM(CAN_CLK)		F_(0, 0)	FM(IECLK_A)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP5_7_4		FM(WE1_N)		F_(0, 0)	FM(MSIOF3_SS1_D)	FM(RTS3_N_TANS)			FM(HRTS3_N)	F_(0, 0)	F_(0, 0)		FM(SDA6_B)	FM(CAN1_RX)		FM(CANFD1_RX)	FM(IERX_A)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP5_7_4		FM(WE1_N)		F_(0, 0)	FM(MSIOF3_SS1_D)	FM(RTS3_N)			FM(HRTS3_N)	F_(0, 0)	F_(0, 0)		FM(SDA6_B)	FM(CAN1_RX)		FM(CANFD1_RX)	FM(IERX_A)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP5_11_8	FM(EX_WAIT0_A)		FM(QCLK)	F_(0, 0)		F_(0, 0)			FM(VI4_CLK)	F_(0, 0)	FM(DU_DOTCLKOUT0)	F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP5_15_12	FM(D0)			FM(MSIOF2_SS1_B)FM(MSIOF3_SCK_A)	F_(0, 0)			FM(VI4_DATA16)	FM(VI5_DATA0)	F_(0, 0)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP5_19_16	FM(D1)			FM(MSIOF2_SS2_B)FM(MSIOF3_SYNC_A)	F_(0, 0)			FM(VI4_DATA17)	FM(VI5_DATA1)	F_(0, 0)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
@@ -263,7 +263,7 @@
 #define IP6_15_12	FM(D8)			FM(LCDOUT0)	FM(MSIOF2_SCK_D)	FM(SCK4_C)			FM(VI4_DATA0_A)	F_(0, 0)	FM(DU_DR0)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP6_19_16	FM(D9)			FM(LCDOUT1)	FM(MSIOF2_SYNC_D)	F_(0, 0)			FM(VI4_DATA1_A)	F_(0, 0)	FM(DU_DR1)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP6_23_20	FM(D10)			FM(LCDOUT2)	FM(MSIOF2_RXD_D)	FM(HRX3_B)			FM(VI4_DATA2_A)	FM(CTS4_N_C)	FM(DU_DR2)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP6_27_24	FM(D11)			FM(LCDOUT3)	FM(MSIOF2_TXD_D)	FM(HTX3_B)			FM(VI4_DATA3_A)	FM(RTS4_N_TANS_C)FM(DU_DR3)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP6_27_24	FM(D11)			FM(LCDOUT3)	FM(MSIOF2_TXD_D)	FM(HTX3_B)			FM(VI4_DATA3_A)	FM(RTS4_N_C)	FM(DU_DR3)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP6_31_28	FM(D12)			FM(LCDOUT4)	FM(MSIOF2_SS1_D)	FM(RX4_C)			FM(VI4_DATA4_A)	F_(0, 0)	FM(DU_DR4)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP7_3_0		FM(D13)			FM(LCDOUT5)	FM(MSIOF2_SS2_D)	FM(TX4_C)			FM(VI4_DATA5_A)	F_(0, 0)	FM(DU_DR5)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP7_7_4		FM(D14)			FM(LCDOUT6)	FM(MSIOF3_SS1_A)	FM(HRX3_C)			FM(VI4_DATA6_A)	F_(0, 0)	FM(DU_DR6)		FM(SCL6_C)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
@@ -301,11 +301,11 @@
 #define IP10_31_28	FM(RX0)			FM(HRX1_B)	F_(0, 0)		F_(0, 0)			F_(0, 0)	FM(TS_SCK0_C)	FM(STP_ISCLK_0_C)	FM(RIF0_D0_B)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP11_3_0	FM(TX0)			FM(HTX1_B)	F_(0, 0)		F_(0, 0)			F_(0, 0)	FM(TS_SPSYNC0_C)FM(STP_ISSYNC_0_C)	FM(RIF0_D1_B)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP11_7_4	FM(CTS0_N)		FM(HCTS1_N_B)	FM(MSIOF1_SYNC_B)	F_(0, 0)			F_(0, 0)	FM(TS_SPSYNC1_C)FM(STP_ISSYNC_1_C)	FM(RIF1_SYNC_B)	FM(AUDIO_CLKOUT_C)	FM(ADICS_SAMP)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP11_11_8	FM(RTS0_N_TANS)		FM(HRTS1_N_B)	FM(MSIOF1_SS1_B)	FM(AUDIO_CLKA_B)		FM(SCL2_A)	F_(0, 0)	FM(STP_IVCXO27_1_C)	FM(RIF0_SYNC_B)	F_(0, 0)		FM(ADICHS1)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP11_11_8	FM(RTS0_N)		FM(HRTS1_N_B)	FM(MSIOF1_SS1_B)	FM(AUDIO_CLKA_B)		FM(SCL2_A)	F_(0, 0)	FM(STP_IVCXO27_1_C)	FM(RIF0_SYNC_B)	F_(0, 0)		FM(ADICHS1)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP11_15_12	FM(RX1_A)		FM(HRX1_A)	F_(0, 0)		F_(0, 0)			F_(0, 0)	FM(TS_SDAT0_C)	FM(STP_ISD_0_C)		FM(RIF1_CLK_C)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP11_19_16	FM(TX1_A)		FM(HTX1_A)	F_(0, 0)		F_(0, 0)			F_(0, 0)	FM(TS_SDEN0_C)	FM(STP_ISEN_0_C)	FM(RIF1_D0_C)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP11_23_20	FM(CTS1_N)		FM(HCTS1_N_A)	FM(MSIOF1_RXD_B)	F_(0, 0)			F_(0, 0)	FM(TS_SDEN1_C)	FM(STP_ISEN_1_C)	FM(RIF1_D0_B)	F_(0, 0)		FM(ADIDATA)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP11_27_24	FM(RTS1_N_TANS)		FM(HRTS1_N_A)	FM(MSIOF1_TXD_B)	F_(0, 0)			F_(0, 0)	FM(TS_SDAT1_C)	FM(STP_ISD_1_C)		FM(RIF1_D1_B)	F_(0, 0)		FM(ADICHS0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP11_27_24	FM(RTS1_N)		FM(HRTS1_N_A)	FM(MSIOF1_TXD_B)	F_(0, 0)			F_(0, 0)	FM(TS_SDAT1_C)	FM(STP_ISD_1_C)		FM(RIF1_D1_B)	F_(0, 0)		FM(ADICHS0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP11_31_28	FM(SCK2)		FM(SCIF_CLK_B)	FM(MSIOF1_SCK_B)	F_(0, 0)			F_(0, 0)	FM(TS_SCK1_C)	FM(STP_ISCLK_1_C)	FM(RIF1_CLK_B)	F_(0, 0)		FM(ADICLK)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP12_3_0	FM(TX2_A)		F_(0, 0)	F_(0, 0)		FM(SD2_CD_B)			FM(SCL1_A)	F_(0, 0)	FM(FMCLK_A)		FM(RIF1_D1_C)	F_(0, 0)		FM(FSO_CFE_0_B)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP12_7_4	FM(RX2_A)		F_(0, 0)	F_(0, 0)		FM(SD2_WP_B)			FM(SDA1_A)	F_(0, 0)	FM(FMIN_A)		FM(RIF1_SYNC_C)	F_(0, 0)		FM(FSO_CFE_1_B)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
@@ -618,7 +618,7 @@ static const u16 pinmux_data[] = {
 
 	PINMUX_IPSR_PHYS_MSEL(IP0_23_20, AVB_AVTP_CAPTURE_A,	I2C_SEL_5_0,	SEL_ETHERAVB_0),
 	PINMUX_IPSR_PHYS_MSEL(IP0_23_20, MSIOF2_TXD_C,		I2C_SEL_5_0,	SEL_MSIOF2_2),
-	PINMUX_IPSR_PHYS_MSEL(IP0_23_20, RTS4_N_TANS_A,		I2C_SEL_5_0,	SEL_SCIF4_0),
+	PINMUX_IPSR_PHYS_MSEL(IP0_23_20, RTS4_N_A,		I2C_SEL_5_0,	SEL_SCIF4_0),
 	PINMUX_IPSR_PHYS(IP0_23_20,	SDA5,			I2C_SEL_5_1),
 
 	PINMUX_IPSR_GPSR(IP0_27_24,	IRQ0),
@@ -758,7 +758,7 @@ static const u16 pinmux_data[] = {
 
 	PINMUX_IPSR_GPSR(IP3_7_4,	A10),
 	PINMUX_IPSR_MSEL(IP3_7_4,	MSIOF2_RXD_A,		SEL_MSIOF2_0),
-	PINMUX_IPSR_MSEL(IP3_7_4,	RTS4_N_TANS_B,		SEL_SCIF4_1),
+	PINMUX_IPSR_MSEL(IP3_7_4,	RTS4_N_B,		SEL_SCIF4_1),
 	PINMUX_IPSR_GPSR(IP3_7_4,	VI5_HSYNC_N),
 
 	PINMUX_IPSR_GPSR(IP3_11_8,	A11),
@@ -861,7 +861,7 @@ static const u16 pinmux_data[] = {
 
 	PINMUX_IPSR_GPSR(IP5_7_4,	WE1_N),
 	PINMUX_IPSR_MSEL(IP5_7_4,	MSIOF3_SS1_D,		SEL_MSIOF3_3),
-	PINMUX_IPSR_GPSR(IP5_7_4,	RTS3_N_TANS),
+	PINMUX_IPSR_GPSR(IP5_7_4,	RTS3_N),
 	PINMUX_IPSR_GPSR(IP5_7_4,	HRTS3_N),
 	PINMUX_IPSR_MSEL(IP5_7_4,	SDA6_B,			SEL_I2C6_1),
 	PINMUX_IPSR_GPSR(IP5_7_4,	CAN1_RX),
@@ -942,7 +942,7 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_MSEL(IP6_27_24,	MSIOF2_TXD_D,		SEL_MSIOF2_3),
 	PINMUX_IPSR_MSEL(IP6_27_24,	HTX3_B,			SEL_HSCIF3_1),
 	PINMUX_IPSR_MSEL(IP6_27_24,	VI4_DATA3_A,		SEL_VIN4_0),
-	PINMUX_IPSR_MSEL(IP6_27_24,	RTS4_N_TANS_C,		SEL_SCIF4_2),
+	PINMUX_IPSR_MSEL(IP6_27_24,	RTS4_N_C,		SEL_SCIF4_2),
 	PINMUX_IPSR_GPSR(IP6_27_24,	DU_DR3),
 
 	PINMUX_IPSR_GPSR(IP6_31_28,	D12),
@@ -1114,7 +1114,7 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_MSEL(IP11_7_4,	AUDIO_CLKOUT_C,		SEL_ADG_2),
 	PINMUX_IPSR_GPSR(IP11_7_4,	ADICS_SAMP),
 
-	PINMUX_IPSR_GPSR(IP11_11_8,	RTS0_N_TANS),
+	PINMUX_IPSR_GPSR(IP11_11_8,	RTS0_N),
 	PINMUX_IPSR_MSEL(IP11_11_8,	HRTS1_N_B,		SEL_HSCIF1_1),
 	PINMUX_IPSR_MSEL(IP11_11_8,	MSIOF1_SS1_B,		SEL_MSIOF1_1),
 	PINMUX_IPSR_MSEL(IP11_11_8,	AUDIO_CLKA_B,		SEL_ADG_1),
@@ -1143,7 +1143,7 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_MSEL(IP11_23_20,	RIF1_D0_B,		SEL_DRIF1_1),
 	PINMUX_IPSR_GPSR(IP11_23_20,	ADIDATA),
 
-	PINMUX_IPSR_GPSR(IP11_27_24,	RTS1_N_TANS),
+	PINMUX_IPSR_GPSR(IP11_27_24,	RTS1_N),
 	PINMUX_IPSR_MSEL(IP11_27_24,	HRTS1_N_A,		SEL_HSCIF1_0),
 	PINMUX_IPSR_MSEL(IP11_27_24,	MSIOF1_TXD_B,		SEL_MSIOF1_1),
 	PINMUX_IPSR_MSEL(IP11_27_24,	TS_SDAT1_C,		SEL_TSIF1_2),
@@ -3219,7 +3219,7 @@ static const unsigned int scif0_ctrl_pins[] = {
 	RCAR_GP_PIN(5, 4), RCAR_GP_PIN(5, 3),
 };
 static const unsigned int scif0_ctrl_mux[] = {
-	RTS0_N_TANS_MARK, CTS0_N_MARK,
+	RTS0_N_MARK, CTS0_N_MARK,
 };
 /* - SCIF1 ------------------------------------------------------------------ */
 static const unsigned int scif1_data_a_pins[] = {
@@ -3241,7 +3241,7 @@ static const unsigned int scif1_ctrl_pins[] = {
 	RCAR_GP_PIN(5, 8), RCAR_GP_PIN(5, 7),
 };
 static const unsigned int scif1_ctrl_mux[] = {
-	RTS1_N_TANS_MARK, CTS1_N_MARK,
+	RTS1_N_MARK, CTS1_N_MARK,
 };
 
 static const unsigned int scif1_data_b_pins[] = {
@@ -3293,7 +3293,7 @@ static const unsigned int scif3_ctrl_pins[] = {
 	RCAR_GP_PIN(1, 26), RCAR_GP_PIN(1, 25),
 };
 static const unsigned int scif3_ctrl_mux[] = {
-	RTS3_N_TANS_MARK, CTS3_N_MARK,
+	RTS3_N_MARK, CTS3_N_MARK,
 };
 static const unsigned int scif3_data_b_pins[] = {
 	/* RX, TX */
@@ -3322,7 +3322,7 @@ static const unsigned int scif4_ctrl_a_pins[] = {
 	RCAR_GP_PIN(2, 14), RCAR_GP_PIN(2, 13),
 };
 static const unsigned int scif4_ctrl_a_mux[] = {
-	RTS4_N_TANS_A_MARK, CTS4_N_A_MARK,
+	RTS4_N_A_MARK, CTS4_N_A_MARK,
 };
 static const unsigned int scif4_data_b_pins[] = {
 	/* RX, TX */
@@ -3343,7 +3343,7 @@ static const unsigned int scif4_ctrl_b_pins[] = {
 	RCAR_GP_PIN(1, 10), RCAR_GP_PIN(1, 9),
 };
 static const unsigned int scif4_ctrl_b_mux[] = {
-	RTS4_N_TANS_B_MARK, CTS4_N_B_MARK,
+	RTS4_N_B_MARK, CTS4_N_B_MARK,
 };
 static const unsigned int scif4_data_c_pins[] = {
 	/* RX, TX */
@@ -3364,7 +3364,7 @@ static const unsigned int scif4_ctrl_c_pins[] = {
 	RCAR_GP_PIN(0, 11), RCAR_GP_PIN(0, 10),
 };
 static const unsigned int scif4_ctrl_c_mux[] = {
-	RTS4_N_TANS_C_MARK, CTS4_N_C_MARK,
+	RTS4_N_C_MARK, CTS4_N_C_MARK,
 };
 /* - SCIF5 ------------------------------------------------------------------ */
 static const unsigned int scif5_data_pins[] = {
@@ -5448,11 +5448,11 @@ static const struct pinmux_drive_reg pinmux_drive_regs[] = {
 		{ RCAR_GP_PIN(5,  3),  0, 3 },	/* CTS0 */
 	} },
 	{ PINMUX_DRIVE_REG("DRVCTRL18", 0xe6060348) {
-		{ RCAR_GP_PIN(5,  4), 28, 3 },	/* RTS0_TANS */
+		{ RCAR_GP_PIN(5,  4), 28, 3 },	/* RTS0 */
 		{ RCAR_GP_PIN(5,  5), 24, 3 },	/* RX1 */
 		{ RCAR_GP_PIN(5,  6), 20, 3 },	/* TX1 */
 		{ RCAR_GP_PIN(5,  7), 16, 3 },	/* CTS1 */
-		{ RCAR_GP_PIN(5,  8), 12, 3 },	/* RTS1_TANS */
+		{ RCAR_GP_PIN(5,  8), 12, 3 },	/* RTS1 */
 		{ RCAR_GP_PIN(5,  9),  8, 3 },	/* SCK2 */
 		{ RCAR_GP_PIN(5, 10),  4, 3 },	/* TX2 */
 		{ RCAR_GP_PIN(5, 11),  0, 3 },	/* RX2 */
@@ -5700,11 +5700,11 @@ static const struct pinmux_bias_reg pinmux_bias_regs[] = {
 		[13] = RCAR_GP_PIN(5,  1),	/* RX0 */
 		[14] = RCAR_GP_PIN(5,  2),	/* TX0 */
 		[15] = RCAR_GP_PIN(5,  3),	/* CTS0_N */
-		[16] = RCAR_GP_PIN(5,  4),	/* RTS0_N_TANS */
+		[16] = RCAR_GP_PIN(5,  4),	/* RTS0_N */
 		[17] = RCAR_GP_PIN(5,  5),	/* RX1_A */
 		[18] = RCAR_GP_PIN(5,  6),	/* TX1_A */
 		[19] = RCAR_GP_PIN(5,  7),	/* CTS1_N */
-		[20] = RCAR_GP_PIN(5,  8),	/* RTS1_N_TANS */
+		[20] = RCAR_GP_PIN(5,  8),	/* RTS1_N */
 		[21] = RCAR_GP_PIN(5,  9),	/* SCK2 */
 		[22] = RCAR_GP_PIN(5, 10),	/* TX2_A */
 		[23] = RCAR_GP_PIN(5, 11),	/* RX2_A */
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77970.c b/drivers/pinctrl/sh-pfc/pfc-r8a77970.c
index 57859287287c..78159b146e3f 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77970.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77970.c
@@ -180,14 +180,14 @@
 #define IP3_3_0		FM(VI0_CLKENB)			FM(MSIOF2_RXD)		FM(RX3)		FM(RD_WR_N)	FM(HCTS3_N)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP3_7_4		FM(VI0_HSYNC_N)			FM(MSIOF2_TXD)		FM(TX3)		F_(0, 0)	FM(HRTS3_N)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP3_11_8	FM(VI0_VSYNC_N)			FM(MSIOF2_SYNC)		FM(CTS3_N)	F_(0, 0)	FM(HTX3)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP3_15_12	FM(VI0_DATA0)			FM(MSIOF2_SS1)		FM(RTS3_N_TANS)	F_(0, 0)	FM(HRX3)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP3_15_12	FM(VI0_DATA0)			FM(MSIOF2_SS1)		FM(RTS3_N)	F_(0, 0)	FM(HRX3)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP3_19_16	FM(VI0_DATA1)			FM(MSIOF2_SS2)		FM(SCK1)	F_(0, 0)	FM(SPEEDIN_A)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP3_23_20	FM(VI0_DATA2)			FM(AVB0_AVTP_PPS)	FM(SDA3_A)	F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP3_27_24	FM(VI0_DATA3)			FM(HSCK1)		FM(SCL3_A)	F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP3_31_28	FM(VI0_DATA4)			FM(HRTS1_N)		FM(RX1_A)	F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP4_3_0		FM(VI0_DATA5)			FM(HCTS1_N)		FM(TX1_A)	F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP4_7_4		FM(VI0_DATA6)			FM(HTX1)		FM(CTS1_N)	F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP4_11_8	FM(VI0_DATA7)			FM(HRX1)		FM(RTS1_N_TANS)	F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP4_11_8	FM(VI0_DATA7)			FM(HRX1)		FM(RTS1_N)	F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP4_15_12	FM(VI0_DATA8)			FM(HSCK2)		FM(PWM0_A)	FM(A22)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP4_19_16	FM(VI0_DATA9)			FM(HCTS2_N)		FM(PWM1_A)	FM(A23)		FM(FSO_CFE_0_N_B)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP4_23_20	FM(VI0_DATA10)			FM(HRTS2_N)		FM(PWM2_A)	FM(A24)		FM(FSO_CFE_1_N_B)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
@@ -206,14 +206,14 @@
 #define IP6_11_8	FM(VI1_DATA6)			F_(0,0)			FM(RX4)		FM(D9)		FM(MMC_CLK)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP6_15_12	FM(VI1_DATA7)			F_(0,0)			FM(TX4)		FM(D10)		FM(MMC_D4)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP6_19_16	FM(VI1_DATA8)			F_(0,0)			FM(CTS4_N)	FM(D11)		FM(MMC_D5)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP6_23_20	FM(VI1_DATA9)			F_(0,0)			FM(RTS4_N_TANS)	FM(D12)		FM(MMC_D6)		FM(SCL3_B)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP6_23_20	FM(VI1_DATA9)			F_(0,0)			FM(RTS4_N)	FM(D12)		FM(MMC_D6)		FM(SCL3_B)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP6_27_24	FM(VI1_DATA10)			F_(0,0)			F_(0, 0)	FM(D13)		FM(MMC_D7)		FM(SDA3_B)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP6_31_28	FM(VI1_DATA11)			FM(SCL4)		FM(IRQ4)	FM(D14)		FM(MMC_WP)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP7_3_0		FM(VI1_FIELD)			FM(SDA4)		FM(IRQ5)	FM(D15)		FM(MMC_CD)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP7_7_4		FM(SCL0)			FM(DU_DR0)		FM(TPU0TO0)	FM(CLKOUT)	F_(0, 0)		FM(MSIOF0_RXD)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP7_11_8	FM(SDA0)			FM(DU_DR1)		FM(TPU0TO1)	FM(BS_N)	FM(SCK0)		FM(MSIOF0_TXD)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP7_15_12	FM(SCL1)			FM(DU_DG0)		FM(TPU0TO2)	FM(RD_N)	FM(CTS0_N)		FM(MSIOF0_SCK)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP7_19_16	FM(SDA1)			FM(DU_DG1)		FM(TPU0TO3)	FM(WE0_N)	FM(RTS0_N_TANS)		FM(MSIOF0_SYNC)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP7_19_16	FM(SDA1)			FM(DU_DG1)		FM(TPU0TO3)	FM(WE0_N)	FM(RTS0_N)		FM(MSIOF0_SYNC)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP7_23_20	FM(SCL2)			FM(DU_DB0)		FM(TCLK1_A)	FM(WE1_N)	FM(RX0)			FM(MSIOF0_SS1)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP7_27_24	FM(SDA2)			FM(DU_DB1)		FM(TCLK2_A)	FM(EX_WAIT0)	FM(TX0)			FM(MSIOF0_SS2)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP7_31_28	FM(AVB0_AVTP_CAPTURE)		F_(0, 0)		F_(0, 0)	F_(0, 0)	FM(FSCLKST2_N_B)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
@@ -499,7 +499,7 @@ static const u16 pinmux_data[] = {
 
 	PINMUX_IPSR_GPSR(IP3_15_12,	VI0_DATA0),
 	PINMUX_IPSR_GPSR(IP3_15_12,	MSIOF2_SS1),
-	PINMUX_IPSR_GPSR(IP3_15_12,	RTS3_N_TANS),
+	PINMUX_IPSR_GPSR(IP3_15_12,	RTS3_N),
 	PINMUX_IPSR_GPSR(IP3_15_12,	HRX3),
 
 	PINMUX_IPSR_GPSR(IP3_19_16,	VI0_DATA1),
@@ -530,7 +530,7 @@ static const u16 pinmux_data[] = {
 
 	PINMUX_IPSR_GPSR(IP4_11_8,	VI0_DATA7),
 	PINMUX_IPSR_GPSR(IP4_11_8,	HRX1),
-	PINMUX_IPSR_GPSR(IP4_11_8,	RTS1_N_TANS),
+	PINMUX_IPSR_GPSR(IP4_11_8,	RTS1_N),
 
 	PINMUX_IPSR_GPSR(IP4_15_12,	VI0_DATA8),
 	PINMUX_IPSR_GPSR(IP4_15_12,	HSCK2),
@@ -620,7 +620,7 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_GPSR(IP6_19_16,	MMC_D5),
 
 	PINMUX_IPSR_GPSR(IP6_23_20,	VI1_DATA9),
-	PINMUX_IPSR_GPSR(IP6_23_20,	RTS4_N_TANS),
+	PINMUX_IPSR_GPSR(IP6_23_20,	RTS4_N),
 	PINMUX_IPSR_GPSR(IP6_23_20,	D12),
 	PINMUX_IPSR_GPSR(IP6_23_20,	MMC_D6),
 	PINMUX_IPSR_MSEL(IP6_23_20,	SCL3_B,	SEL_I2C3_1),
@@ -667,7 +667,7 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_GPSR(IP7_19_16,	DU_DG1),
 	PINMUX_IPSR_GPSR(IP7_19_16,	TPU0TO3),
 	PINMUX_IPSR_GPSR(IP7_19_16,	WE0_N),
-	PINMUX_IPSR_GPSR(IP7_19_16,	RTS0_N_TANS),
+	PINMUX_IPSR_GPSR(IP7_19_16,	RTS0_N),
 	PINMUX_IPSR_GPSR(IP7_19_16,	MSIOF0_SYNC),
 
 	PINMUX_IPSR_GPSR(IP7_23_20,	SCL2),
@@ -1421,7 +1421,7 @@ static const unsigned int scif0_ctrl_pins[] = {
 	RCAR_GP_PIN(4, 3), RCAR_GP_PIN(4, 2),
 };
 static const unsigned int scif0_ctrl_mux[] = {
-	RTS0_N_TANS_MARK, CTS0_N_MARK,
+	RTS0_N_MARK, CTS0_N_MARK,
 };
 
 /* - SCIF1 ------------------------------------------------------------------ */
@@ -1444,7 +1444,7 @@ static const unsigned int scif1_ctrl_pins[] = {
 	RCAR_GP_PIN(2, 11), RCAR_GP_PIN(2, 10),
 };
 static const unsigned int scif1_ctrl_mux[] = {
-	RTS1_N_TANS_MARK, CTS1_N_MARK,
+	RTS1_N_MARK, CTS1_N_MARK,
 };
 static const unsigned int scif1_data_b_pins[] = {
 	/* RX, TX */
@@ -1474,7 +1474,7 @@ static const unsigned int scif3_ctrl_pins[] = {
 	RCAR_GP_PIN(2, 4), RCAR_GP_PIN(2, 3),
 };
 static const unsigned int scif3_ctrl_mux[] = {
-	RTS3_N_TANS_MARK, CTS3_N_MARK,
+	RTS3_N_MARK, CTS3_N_MARK,
 };
 
 /* - SCIF4 ------------------------------------------------------------------ */
@@ -1497,7 +1497,7 @@ static const unsigned int scif4_ctrl_pins[] = {
 	RCAR_GP_PIN(3, 13), RCAR_GP_PIN(3, 12),
 };
 static const unsigned int scif4_ctrl_mux[] = {
-	RTS4_N_TANS_MARK, CTS4_N_MARK,
+	RTS4_N_MARK, CTS4_N_MARK,
 };
 
 /* - TMU -------------------------------------------------------------------- */
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77980.c b/drivers/pinctrl/sh-pfc/pfc-r8a77980.c
index 27c4392cbbbd..8c6707f9a335 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77980.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77980.c
@@ -187,7 +187,7 @@
 #define IP0_7_4		FM(DU_DR3)			FM(RX4)			FM(GETHER_RMII_RX_ER)	FM(A1)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0_11_8	FM(DU_DR4)			FM(TX4)			FM(GETHER_RMII_RXD0)	FM(A2)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0_15_12	FM(DU_DR5)			FM(CTS4_N)		FM(GETHER_RMII_RXD1)	FM(A3)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0_19_16	FM(DU_DR6)			FM(RTS4_N_TANS)		FM(GETHER_RMII_TXD_EN)	FM(A4)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0_19_16	FM(DU_DR6)			FM(RTS4_N)		FM(GETHER_RMII_TXD_EN)	FM(A4)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0_23_20	FM(DU_DR7)			F_(0, 0)		FM(GETHER_RMII_TXD0)	FM(A5)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0_27_24	FM(DU_DG2)			F_(0, 0)		FM(GETHER_RMII_TXD1)	FM(A6)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0_31_28	FM(DU_DG3)			FM(CPG_CPCKOUT)		FM(GETHER_RMII_REFCLK)	FM(A7)		FM(PWMFSW0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
@@ -210,14 +210,14 @@
 #define IP3_3_0		FM(VI0_CLKENB)			FM(MSIOF2_RXD)		FM(RX3)			FM(RD_WR_N)	FM(HCTS3_N)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP3_7_4		FM(VI0_HSYNC_N)			FM(MSIOF2_TXD)		FM(TX3)			F_(0, 0)	FM(HRTS3_N)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP3_11_8	FM(VI0_VSYNC_N)			FM(MSIOF2_SYNC)		FM(CTS3_N)		F_(0, 0)	FM(HTX3)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP3_15_12	FM(VI0_DATA0)			FM(MSIOF2_SS1)		FM(RTS3_N_TANS)		F_(0, 0)	FM(HRX3)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP3_15_12	FM(VI0_DATA0)			FM(MSIOF2_SS1)		FM(RTS3_N)		F_(0, 0)	FM(HRX3)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP3_19_16	FM(VI0_DATA1)			FM(MSIOF2_SS2)		FM(SCK1)		F_(0, 0)	FM(SPEEDIN_A)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP3_23_20	FM(VI0_DATA2)			FM(AVB_AVTP_PPS)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP3_27_24	FM(VI0_DATA3)			FM(HSCK1)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP3_31_28	FM(VI0_DATA4)			FM(HRTS1_N)		FM(RX1_A)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP4_3_0		FM(VI0_DATA5)			FM(HCTS1_N)		FM(TX1_A)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP4_7_4		FM(VI0_DATA6)			FM(HTX1)		FM(CTS1_N)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP4_11_8	FM(VI0_DATA7)			FM(HRX1)		FM(RTS1_N_TANS)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP4_11_8	FM(VI0_DATA7)			FM(HRX1)		FM(RTS1_N)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP4_15_12	FM(VI0_DATA8)			FM(HSCK2)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP4_19_16	FM(VI0_DATA9)			FM(HCTS2_N)		FM(PWM1_A)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP4_23_20	FM(VI0_DATA10)			FM(HRTS2_N)		FM(PWM2_A)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
@@ -243,7 +243,7 @@
 #define IP7_7_4		FM(SCL0)			F_(0, 0)		F_(0, 0)		FM(CLKOUT)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP7_11_8	FM(SDA0)			F_(0, 0)		F_(0, 0)		FM(BS_N)	FM(SCK0)	FM(HSCK0_B)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP7_15_12	FM(SCL1)			F_(0, 0)		FM(TPU0TO2)		FM(RD_N)	FM(CTS0_N)	FM(HCTS0_N_B)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP7_19_16	FM(SDA1)			F_(0, 0)		FM(TPU0TO3)		FM(WE0_N)	FM(RTS0_N_TANS)	FM(HRTS0_N_B)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP7_19_16	FM(SDA1)			F_(0, 0)		FM(TPU0TO3)		FM(WE0_N)	FM(RTS0_N)	FM(HRTS0_N_B)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP7_23_20	FM(SCL2)			F_(0, 0)		F_(0, 0)		FM(WE1_N)	FM(RX0)		FM(HRX0_B)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP7_27_24	FM(SDA2)			F_(0, 0)		F_(0, 0)		FM(EX_WAIT0)	FM(TX0)		FM(HTX0_B)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP7_31_28	FM(AVB_AVTP_MATCH)		FM(TPU0TO0)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
@@ -470,7 +470,7 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_GPSR(IP0_15_12,	A3),
 
 	PINMUX_IPSR_GPSR(IP0_19_16,	DU_DR6),
-	PINMUX_IPSR_GPSR(IP0_19_16,	RTS4_N_TANS),
+	PINMUX_IPSR_GPSR(IP0_19_16,	RTS4_N),
 	PINMUX_IPSR_GPSR(IP0_19_16,	GETHER_RMII_TXD_EN),
 	PINMUX_IPSR_GPSR(IP0_19_16,	A4),
 
@@ -580,7 +580,7 @@ static const u16 pinmux_data[] = {
 
 	PINMUX_IPSR_GPSR(IP3_15_12,	VI0_DATA0),
 	PINMUX_IPSR_GPSR(IP3_15_12,	MSIOF2_SS1),
-	PINMUX_IPSR_GPSR(IP3_15_12,	RTS3_N_TANS),
+	PINMUX_IPSR_GPSR(IP3_15_12,	RTS3_N),
 	PINMUX_IPSR_GPSR(IP3_15_12,	HRX3),
 
 	PINMUX_IPSR_GPSR(IP3_19_16,	VI0_DATA1),
@@ -609,7 +609,7 @@ static const u16 pinmux_data[] = {
 
 	PINMUX_IPSR_GPSR(IP4_11_8,	VI0_DATA7),
 	PINMUX_IPSR_GPSR(IP4_11_8,	HRX1),
-	PINMUX_IPSR_GPSR(IP4_11_8,	RTS1_N_TANS),
+	PINMUX_IPSR_GPSR(IP4_11_8,	RTS1_N),
 
 	PINMUX_IPSR_GPSR(IP4_15_12,	VI0_DATA8),
 	PINMUX_IPSR_GPSR(IP4_15_12,	HSCK2),
@@ -728,7 +728,7 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_GPSR(IP7_19_16,	SDA1),
 	PINMUX_IPSR_GPSR(IP7_19_16,	TPU0TO3),
 	PINMUX_IPSR_GPSR(IP7_19_16,	WE0_N),
-	PINMUX_IPSR_GPSR(IP7_19_16,	RTS0_N_TANS),
+	PINMUX_IPSR_GPSR(IP7_19_16,	RTS0_N),
 	PINMUX_IPSR_MSEL(IP1_23_20,	HRTS0_N_B, SEL_HSCIF0_1),
 
 	PINMUX_IPSR_GPSR(IP7_23_20,	SCL2),
@@ -1676,11 +1676,11 @@ static const unsigned int scif0_clk_mux[] = {
 	SCK0_MARK,
 };
 static const unsigned int scif0_ctrl_pins[] = {
-	/* RTS0#/TANS, CTS0# */
+	/* RTS0#, CTS0# */
 	RCAR_GP_PIN(4, 3), RCAR_GP_PIN(4, 2),
 };
 static const unsigned int scif0_ctrl_mux[] = {
-	RTS0_N_TANS_MARK, CTS0_N_MARK,
+	RTS0_N_MARK, CTS0_N_MARK,
 };
 
 /* - SCIF1 ------------------------------------------------------------------ */
@@ -1699,11 +1699,11 @@ static const unsigned int scif1_clk_mux[] = {
 	SCK1_MARK,
 };
 static const unsigned int scif1_ctrl_pins[] = {
-	/* RTS1#/TANS, CTS1# */
+	/* RTS1#, CTS1# */
 	RCAR_GP_PIN(2, 11), RCAR_GP_PIN(2, 10),
 };
 static const unsigned int scif1_ctrl_mux[] = {
-	RTS1_N_TANS_MARK, CTS1_N_MARK,
+	RTS1_N_MARK, CTS1_N_MARK,
 };
 static const unsigned int scif1_data_b_pins[] = {
 	/* RX1, TX1 */
@@ -1729,11 +1729,11 @@ static const unsigned int scif3_clk_mux[] = {
 	SCK3_MARK,
 };
 static const unsigned int scif3_ctrl_pins[] = {
-	/* RTS3#/TANS, CTS3# */
+	/* RTS3#, CTS3# */
 	RCAR_GP_PIN(2, 4), RCAR_GP_PIN(2, 3),
 };
 static const unsigned int scif3_ctrl_mux[] = {
-	RTS3_N_TANS_MARK, CTS3_N_MARK,
+	RTS3_N_MARK, CTS3_N_MARK,
 };
 
 /* - SCIF4 ------------------------------------------------------------------ */
@@ -1752,11 +1752,11 @@ static const unsigned int scif4_clk_mux[] = {
 	SCK4_MARK,
 };
 static const unsigned int scif4_ctrl_pins[] = {
-	/* RTS4#/TANS, CTS4# */
+	/* RTS4#, CTS4# */
 	RCAR_GP_PIN(0, 4), RCAR_GP_PIN(0, 3),
 };
 static const unsigned int scif4_ctrl_mux[] = {
-	RTS4_N_TANS_MARK, CTS4_N_MARK,
+	RTS4_N_MARK, CTS4_N_MARK,
 };
 
 /* - SCIF Clock ------------------------------------------------------------- */
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77995.c b/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
index 20b58e4602c9..6e952fe0818a 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
@@ -291,7 +291,7 @@
 #define IP10_23_20	FM(SSI_SDATA4_A)	FM(HTX0)		FM(SCL2_A)		FM(CAN1_RX_B)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP10_27_24	FM(SSI_WS4_A)		FM(HRX0)		FM(SDA2_A)		FM(CAN1_TX_B)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP10_31_28	FM(SCL1)		FM(CTS1_N)		F_(0, 0)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP11_3_0	FM(SDA1)		FM(RTS1_N_TANS)		F_(0, 0)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP11_3_0	FM(SDA1)		FM(RTS1_N)		F_(0, 0)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP11_7_4	FM(MSIOF1_SCK)		FM(AVB0_AVTP_PPS_B)	F_(0, 0)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP11_11_8	FM(MSIOF1_TXD)		FM(AVB0_AVTP_CAPTURE_B)	F_(0, 0)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP11_15_12	FM(MSIOF1_RXD)		FM(AVB0_AVTP_MATCH_B)	F_(0, 0)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
@@ -302,7 +302,7 @@
 
 /* IPSRx */		/* 0 */			/* 1 */			/* 2 */			/* 3 */		/* 4 */			/* 5 */		/* 6  - F */
 #define IP12_3_0	FM(RX1_A)		FM(CTS0_N)		FM(TPU0TO0_B)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP12_7_4	FM(TX1_A)		FM(RTS0_N_TANS)		FM(TPU0TO1_B)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP12_7_4	FM(TX1_A)		FM(RTS0_N)		FM(TPU0TO1_B)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP12_11_8	FM(SCK2)		FM(MSIOF1_SS1)		FM(TPU0TO3_B)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP12_15_12	FM(TPU0TO0_A)		FM(AVB0_AVTP_CAPTURE_A)	FM(HCTS0_N)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP12_19_16	FM(TPU0TO1_A)		FM(AVB0_AVTP_MATCH_A)	FM(HRTS0_N)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
@@ -854,7 +854,7 @@ static const u16 pinmux_data[] = {
 
 	/* IPSR11 */
 	PINMUX_IPSR_GPSR(IP11_3_0,	SDA1),
-	PINMUX_IPSR_GPSR(IP11_3_0,	RTS1_N_TANS),
+	PINMUX_IPSR_GPSR(IP11_3_0,	RTS1_N),
 
 	PINMUX_IPSR_GPSR(IP11_7_4,	MSIOF1_SCK),
 	PINMUX_IPSR_MSEL(IP11_7_4,	AVB0_AVTP_PPS_B, SEL_ETHERAVB_1),
@@ -889,7 +889,7 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_GPSR(IP12_3_0,	TPU0TO0_B),
 
 	PINMUX_IPSR_MSEL(IP12_7_4,	TX1_A, SEL_SCIF1_0),
-	PINMUX_IPSR_GPSR(IP12_7_4,	RTS0_N_TANS),
+	PINMUX_IPSR_GPSR(IP12_7_4,	RTS0_N),
 	PINMUX_IPSR_GPSR(IP12_7_4,	TPU0TO1_B),
 
 	PINMUX_IPSR_GPSR(IP12_11_8,	SCK2),
@@ -1418,7 +1418,7 @@ static const unsigned int scif0_ctrl_pins[] = {
 	RCAR_GP_PIN(4, 24), RCAR_GP_PIN(4, 23),
 };
 static const unsigned int scif0_ctrl_mux[] = {
-	RTS0_N_TANS_MARK, CTS0_N_MARK,
+	RTS0_N_MARK, CTS0_N_MARK,
 };
 /* - SCIF1 ------------------------------------------------------------------ */
 static const unsigned int scif1_data_a_pins[] = {
@@ -1454,7 +1454,7 @@ static const unsigned int scif1_ctrl_pins[] = {
 	RCAR_GP_PIN(4, 11), RCAR_GP_PIN(4, 10),
 };
 static const unsigned int scif1_ctrl_mux[] = {
-	RTS1_N_TANS_MARK, CTS1_N_MARK,
+	RTS1_N_MARK, CTS1_N_MARK,
 };
 
 /* - SCIF2 ------------------------------------------------------------------ */
-- 
2.17.1


--AziB6g08Hk12Qz7IQLyf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5205): https://lists.cip-project.org/g/cip-dev/message=
/5205
Mute This Topic: https://lists.cip-project.org/mt/76326745/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--AziB6g08Hk12Qz7IQLyf--
