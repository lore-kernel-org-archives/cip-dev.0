Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.21])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.812.1795110951807616760
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Nov 2026 09:55:52 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=SCCb1R42;
 spf=pass (domain: renesas.com, ip: 52.101.229.21, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yE8sFNZbbnY753n9Hf61ucOmp75RL7NHOPgCoIsLG1yylxtKjwL9mm2e/dJqX/zYaoLJQLJAZcb/wz8iNsXP3bMeibIQeqtAbMt7EorJHFZ+bOAE2ppVggoknl5jhkY+hUtoOyvwxG/8UnuEfEhyoHEa9OFDSZR52kN65ZaQdiIcVMeZDtLwFvB4zM9ITw5A75/UG/rSJFvbKsACCE0RvtrLqkXyelqdbT3F+nzsiRDT6GDHVQOdQZgFwSzk9Rv5xYbPOjEFfrxkJDaZ5AxU4bk9YpSe+thsVPOvB99SSY/UHm4IORIDqw1S1I+q3XbNCm33aPN7VGAUzv2fWqinqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNdlV3OdRBwHOixbq/Xv3IKq1FTKKtRDr7x6TdkF4QQ=;
 b=JJJjRv6wdZEaCwPoNl6EIQXrTSMhLROc10JL4+BM9enDOVyciQWFGGGtlGHOR7nW+7w8dFBJSSMavATKqpS2iPGDKcFEnsXw3Q4Rvs9K0fFCvq/kbC/hY2GM+ofZH9jqeCi+k2vweW1LgK8h+a9stCTwUQqI1dv4hQFZa3jhYSrEeqCtAddsiCs96yJ6dj+dmFDixFE/AfIwGmWRt3lvltKcoz4JGgxq2Qp/EDZHUoZ1WKk5Zk1L6XD1MJ4ltQovF6iGTNkRGJVAwbiGUaKUb3a4zVRdxtPG5K2eTcDTHqjWVwp7OGX1cmAFcFUnZ8gBGlkqDkQ/+KRyaBDBFrEs5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNdlV3OdRBwHOixbq/Xv3IKq1FTKKtRDr7x6TdkF4QQ=;
 b=SCCb1R4237A5Vjdf0WRXRmNX0ZWiCyhJPOPL6ttUIkqYz9HOvczl/+vTKBaSPsrawNiLQ1Pws2qMtFDLA4lLd4BPqNaIODMIVVRSOk80UCqM6Puyl1xyzLxoCsB16AkiuPguB+4u+LqPNF4NfQc1LDjjkeYDanBTkPks8rmlJwc=
Received: from TYCP286CA0311.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:38b::6)
 by TYWPR01MB11828.jpnprd01.prod.outlook.com (2603:1096:400:402::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 19 Nov
 2026 17:55:46 +0000
Received: from TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b:cafe::f) by TYCP286CA0311.outlook.office365.com
 (2603:1096:400:38b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Thu,
 19 Nov 2026 17:55:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD9.mail.protection.outlook.com (10.167.240.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Thu, 19 Nov 2026 17:55:45 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.9])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 9D1993000230;
	Fri, 20 Nov 2026 02:55:44 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 4.19.y-cip 6/8] mmc: renesas_sdhi: only check CMD status for HS400 manual correction
Date: Thu, 19 Nov 2026 17:55:31 +0000
Message-ID: <20261119175533.110210-7-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119175533.110210-1-ovidiu.panait.rb@renesas.com>
References: <20261119175533.110210-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: ovidiu.panait.rb@renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD9:EE_|TYWPR01MB11828:EE_
X-MS-Office365-Filtering-Correlation-Id: 967a1c98-e6e3-4fb0-e0fc-08df46665657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|22082099003|18002099003|13003099007|56012099006|11063799006|261026121527099003|10067099003|261026140227099003|261028144727099003|261022105027099003|261021123027099003|261009223027099003|261021121427099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: kPGpGxGni6FnnkuhMyd6d+SiAFs0LvCmFdLrxccRHsJ4Zo7aedCnXYYI9cMr2GMD0l7MjQ4XAKrmn5hJ1b34bJ6tFLhB9kVz71k3Cgmb8ze1BLaqSRhziWe7FZwypGOXhdfhYQVN07kkbIalw1uiuxjBOL8j4oY/sY8Abdmo4svY0pcaODXr+cjihYw+TLSzKbRsp9Rxs9ncQ6ZK10L1DEANFOzJj5Fl3T8wGzCf4ISO6O48EHf2y+OajZ8zRqw1sIa6mP/a9mv9q+MaU0Ao8ORq7gfSZtWlQbMDs3/+eGbIRWnoZbEKWqjI+ZKlH7yXC+gJqU0CRyXfqcqsC25lYn8YtXgewIAcCXicBWwz/XjFYThoauJdOoNVzwDiA4N9uJBaDRSyiyaRza42mbanU8FalK8cW+hE34UGS4TPlZe2e7AzD1yRuUfTudbklx0+6RiibufvPabvEun5kLGD5uWpL6zTvVKrIXMmleR6VK/G6cJEa85Lp/Ji+tO6LC1a9rsd6ys66s0fhlDFpFbwcAdZMDfW3At2T57IH/1BOqM2S4W+/+bVNnYHfDL8tXBOpAPLako0Y8WNPBOinebKRM5/npFWKWfXvcuCCbyj6YPj9eOVEKdfhqsLKN3GeGJBYdGwOqZ0pRo1nbQQ5VapkeckSYJnjKxAJ1lXaMEBWj8=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(13003099007)(56012099006)(11063799006)(261026121527099003)(10067099003)(261026140227099003)(261028144727099003)(261022105027099003)(261021123027099003)(261009223027099003)(261021121427099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wD1g8Gbsm8ogY+zAHQI5bqoCKlGhLfz67hMAoCUc8tdkZ7JEQ5PwLjhbMhYXA232xUHIWZWcfBzLG+3NrfUXU4hLSeYP6j2uY0ETciruOCQmsQYIpdVA4gNCuEkzXAT/pTkGcW1/vICXWeLgloW3XNoyPQyGweRmRoIU3yH+4yXSmjMeiSg6mn3jNtSA1J0f9n8kjxmQ7ZcrcgcXleeR34mvuUZmq62lF6K3H2tyNtnEJ8f3RTiCHckZcPiAKz/m6WhW1use4+c4AUT7+w1X9OUN3tSwC5085KZNmpDk5a0BSMyLao9tPpHDgfAEx/TlYTpP0WFJSUUgpQtj0ix5WzpiinLQtiDPTUggRUgWgPQe2/gIuqzcEidov0aZfIrxDn0z7NYZJJCuszU+RVA0YeOzpwCpkLqDS1QPuj3hi0QriHAl01Pqyok+CkaMXXRr
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 17:55:45.8594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 967a1c98-e6e3-4fb0-e0fc-08df46665657
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11828
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 19 Nov 2026 17:55:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25022
Content-Type: text/plain; charset="utf-8"

From: Takeshi Saito <takeshi.saito.xv@renesas.com>

commit 71cfc92751ac7a3185e73cffc43a673b73c39683 upstream.

R-Car Gen3 cannot use correction error status with HS400.
HS200: CMD and DAT signal timing are based on CLK signal.
HS400: CMD signal is based on CLK. DAT signal is based on DS signal.

In HS400, CMD signal is 200MHz(SDR). DAT signal is 200MHz(DDR).
Center position of signal is different between CMD and DAT.

TAP position should be adjusted to the center position of CMD signal.
DAT sampling timing is adjusted by HS400 calibration circuit regardless
of TAP position. Refer to renesas_sdhi_adjust_hs400mode_enable().

However, correction error status contains CMD and DAT status in HS400
(DAT signal is not masked in HS400). Therefore, correction error status
cannot use in HS400. It means that auto correction cannot be uses in
HS400. Manual correction can change to the correct TAP position by
ignoring DAT correction error status and using only CMD correction
status.

Signed-off-by: Takeshi Saito <takeshi.saito.xv@renesas.com>
[wsa: refactored patch from BSP]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://lore.kernel.org/r/20191217114034.13290-4-wsa+renesas@sang-eng=
ineering.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 41 ++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesa=
s_sdhi_core.c
index a10eb50884b2..09d23a770f70 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -272,6 +272,7 @@ static int renesas_sdhi_start_signal_voltage_switch(str=
uct mmc_host *mmc,
 #define SH_MOBILE_SDHI_SCC_CKSEL	0x006
 #define SH_MOBILE_SDHI_SCC_RVSCNTL	0x008
 #define SH_MOBILE_SDHI_SCC_RVSREQ	0x00A
+#define SH_MOBILE_SDHI_SCC_SMPCMP       0x00C
 #define SH_MOBILE_SDHI_SCC_TMPPORT2	0x00E
=20
 /* Definitions for values the SH_MOBILE_SDHI_SCC_DTCNTL register */
@@ -287,6 +288,10 @@ static int renesas_sdhi_start_signal_voltage_switch(st=
ruct mmc_host *mmc,
 #define SH_MOBILE_SDHI_SCC_RVSREQ_RVSERR	BIT(2)
 #define SH_MOBILE_SDHI_SCC_RVSREQ_REQTAPUP	BIT(1)
 #define SH_MOBILE_SDHI_SCC_RVSREQ_REQTAPDOWN	BIT(0)
+/* Definitions for values the SH_MOBILE_SDHI_SCC_SMPCMP register */
+#define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_ERR	(BIT(24) | BIT(8))
+#define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_REQUP	BIT(24)
+#define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_REQDOWN	BIT(8)
 /* Definitions for values the SH_MOBILE_SDHI_SCC_TMPPORT2 register */
 #define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL	BIT(4)
 #define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN	BIT(31)
@@ -516,6 +521,7 @@ static int renesas_sdhi_select_tuning(struct tmio_mmc_h=
ost *host)
 static bool renesas_sdhi_manual_correction(struct tmio_mmc_host *host, boo=
l use_4tap)
 {
 	struct renesas_sdhi *priv =3D host_to_priv(host);
+	unsigned long new_tap =3D host->tap_set;
 	u32 val;
=20
 	val =3D sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_RVSREQ);
@@ -525,15 +531,34 @@ static bool renesas_sdhi_manual_correction(struct tmi=
o_mmc_host *host, bool use_
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_RVSREQ, 0);
=20
 	/* Change TAP position according to correction status */
-	if (val & SH_MOBILE_SDHI_SCC_RVSREQ_RVSERR)
-		return true;    /* Need re-tune */
-	else if (val & SH_MOBILE_SDHI_SCC_RVSREQ_REQTAPUP)
-		host->tap_set =3D (host->tap_set + 1) % host->tap_num;
-	else if (val & SH_MOBILE_SDHI_SCC_RVSREQ_REQTAPDOWN)
-		host->tap_set =3D (host->tap_set - 1) % host->tap_num;
-	else
-		return false;
+	if (sd_ctrl_read16(host, CTL_VERSION) =3D=3D SDHI_VER_GEN3_SDMMC &&
+	    host->mmc->ios.timing =3D=3D MMC_TIMING_MMC_HS400) {
+		/*
+		 * With HS400, the DAT signal is based on DS, not CLK.
+		 * Therefore, use only CMD status.
+		 */
+		u32 smpcmp =3D sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_SMPCMP) &
+					   SH_MOBILE_SDHI_SCC_SMPCMP_CMD_ERR;
+		if (!smpcmp)
+			return false;	/* no error in CMD signal */
+		else if (smpcmp =3D=3D SH_MOBILE_SDHI_SCC_SMPCMP_CMD_REQUP)
+			new_tap++;
+		else if (smpcmp =3D=3D SH_MOBILE_SDHI_SCC_SMPCMP_CMD_REQDOWN)
+			new_tap--;
+		else
+			return true;	/* need retune */
+	} else {
+		if (val & SH_MOBILE_SDHI_SCC_RVSREQ_RVSERR)
+			return true;    /* need retune */
+		else if (val & SH_MOBILE_SDHI_SCC_RVSREQ_REQTAPUP)
+			new_tap++;
+		else if (val & SH_MOBILE_SDHI_SCC_RVSREQ_REQTAPDOWN)
+			new_tap--;
+		else
+			return false;
+	}
=20
+	host->tap_set =3D (new_tap % host->tap_num);
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TAPSET,
 		       host->tap_set / (use_4tap ? 2 : 1));
=20
--=20
2.34.1

