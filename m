Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E99C5DF89
	for <webhook@archiver.kernel.org>; Fri, 21 Aug 2026 13:17:23 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7169.1787318234537464728
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2026 06:17:14 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=MdlK9wJe;
 spf=pass (domain: renesas.com, ip: 40.107.74.56, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=myLqfK01+qDHfloqbnroSAjTNLexOkP+HnvjfY5msfYKpMmp3p7RLXgM/PgXzX+1naRhOKvhjt3TFdsMYYI6QsAVo6h21dGeMEg2lJdoUjUCCBSmwgAYJWmNCusl/RVzJysKgmsk4iuqRXjUwXfgByP2gcy8pFPPxtvL8vKhrQnoenLP9cHW1GenxdDUzQZmxmdG+3E0qjFkshm5sT/jswdkutv5jGw2b1+bgID24K4hdIVTwbeWbzVvmWd4E5nNkMGeI26+VBCpG2bCRcb6tuPww5Nfh23E6mJjCnHxUGVJRsePJvH3Xda0pL6DSWCMwrPkqrIrPqTkCkO4Hr6f2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBNrt+jriX8UzHplqLxCEQwXFEOWs7OMxIlnOjpR1W8=;
 b=rxjQWmI2JiteX20kcbcU+F8DXGyvo+uu6OfZgk3dLqFLFwFCtPBdVYLZp12Oxs1wVDW0j3KNNJ+AlN+fwaBE3GuAjCRZ6lMayn0v0yTlhgPzY0azyrYr4Nwp/vfi/UGT247lmmhWT2EX1uYV2Dd0+JDARrQZ1GvqkQjcXawRtkv/TpEmcndIeAHUcatmSQFY9k9Gju0IQgjCNO91WZ4PB4I6JBYy03yUsFzOvPbhs7rmrtiGqqvMJ8LcQ5IzRrIyEWUZtKZJBBj57bH3d2Rac9OaE375WMxiOdn9hAC02fvo3R1Hauf/pmnGoGhnyqet9bRkvPEBDG1rbmmy0PTwVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBNrt+jriX8UzHplqLxCEQwXFEOWs7OMxIlnOjpR1W8=;
 b=MdlK9wJegpWui+fHZu6xnHi8+A52UGmMg5U41gYnOPLdeUvRpVT0g75LbfmOfyZhqd/Q3S00Wo4uF70S5dDOI40EDoGksunDN+EhaKwsxhjYqB5f6becXdv0/vE8sNsDXEwwugbpXE7Oc2BN9Suh7VTITt72fHb5022HIF8SdYc=
Received: from TY6P286CA0007.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:3b8::6)
 by TYWPR01MB10064.jpnprd01.prod.outlook.com (2603:1096:400:1e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 13:17:08 +0000
Received: from TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b8:cafe::59) by TY6P286CA0007.outlook.office365.com
 (2603:1096:405:3b8::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 13:17:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005023.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Fri, 21 Aug 2026 13:17:07 +0000
Received: from demon-pc.localdomain (DEU-5CG5050QD0.adwin.renesas.com [10.226.92.179])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 88F663000374;
	Fri, 21 Aug 2026 22:17:06 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 12/18] irqchip/renesas-rzt2h: Add error interrupts support
Date: Fri, 21 Aug 2026 16:15:48 +0300
Message-ID: <20260821131554.638741-13-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821131554.638741-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260821131554.638741-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005023:EE_|TYWPR01MB10064:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c82f10bd-527a-437f-f70b-08deff86807f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|11063799006|56012099006|10067099003|13003099007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	OTqf/hziy3N0OO1UZMpHcXIyweNveLkfcv8n+wTbJlArGZZXUTx1mWFP4+q7DnmLMXVvuapYywwDItXBGacrXUapWYXKZwSft2x3Qgogj65glMdB7JmwOj2sHlLcHGJIXzrZNN6gpxf1+mV16Mw6FWTOVjI/MUfJbdmTophLFQxsehPvAtNntthNoPy/95Vy4eUvrkh5bTwsmh4QHxlnM8hIR0UrWycEZmHEM+pqeo5tZp/uVRtVeJSYNh9VqNu8Ixbuupg4AZAYW48OZEfuqZKINDnh6ebEUDCRKVF035bEjnlZJCzHKFjVZNlZu7Ljd0FemGeaTrI1JLZLu9pVWRLPt6AoL+8aimvcX990TAnFNoo7VcAHdqY2AimiliJyWQpLunTUtU2HtuoN1K/a63D0dF2KvGJNTtDXGVU3+IzO8ufiHmyLYN9Jh4bByDimlepkuJYkQE94jniPioyKiArPsefwgE7kVjz13ALyVE1eBXPrWgkf2tke7+eWvWSy+oGrYjDmHi32Y4T6cjDA2k+GWtsOTNaDbxluj+UrL67KgR4Gu7xTqPpiicSNndFLB19OK7HL4x14t2Gc/i42xU85bkEJJoI7Lr9N/9nIvnGCrMd+alTI+8yB+KZ04OoAs3bvzxZBIwrJLstjYXv/3dfPabbFCjazLQHTDFsF8xI=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(11063799006)(56012099006)(10067099003)(13003099007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	2d8/EXSGNZUWDo8RdRPQhvXctJqjIsJX+jiLLJErkcl3wozohoNqYc5qHvIFdsu4AxDuqR7uIpvaQuf1agdabYI53ts+bhBnevPCw7jpB9OoCFSp3QtyEhn6vqehF7WB5fIkBrwvYf7smpY3VEw46tnaSRnyo98BNdmMglpvDb041ma7drZ1dS06avGIS7OKtjR2NP0aNxGMVvzf+t3oz6cK42uCKFHh9CmN7LZBQ8Y+2GMEr84d1TlH4g8VYdwJDW4TAExlsJY7PNtOEnto6pHbOqKjgcnMfyr36gRvSCeUriuwGTEt/GriPXDwvYFrwSmqc6QRtp/t02dZCDO7MF9csQzbM847Sx+sX4UVypW98XKOMSVynck7C3pJHNLRimN1R8VIzOAZLxL358GvjYhzTBdoxYNAyZsENzJxwBm/kocYhgeQtRqG1GdWnTkH
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 13:17:07.9259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c82f10bd-527a-437f-f70b-08deff86807f
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10064
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Aug 2026 13:17:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23969

commit 8d721c08dd67af96664ce381f6b2790d15de7213 upstream.

The Renesas RZ/T2H ICU is able to report errors for CA55, GIC, and
various IPs. Unmask these errors, request the IRQs and report them when
they occur.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260520203117.1516442-4-cosmin-gabriel.tani=
slav.xa@renesas.com
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/irqchip/irq-renesas-rzt2h.c | 151 +++++++++++++++++++++++++++-
 1 file changed, 147 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzt2h.c b/drivers/irqchip/irq-rene=
sas-rzt2h.c
index 54d9e82e5de5..a536ebd792ff 100644
--- a/drivers/irqchip/irq-renesas-rzt2h.c
+++ b/drivers/irqchip/irq-renesas-rzt2h.c
@@ -32,11 +32,36 @@
 						 RZT2H_ICU_IRQ_S_COUNT)
 #define RZT2H_ICU_SEI_COUNT			1
=20
+#define RZT2H_ICU_CA55_ERR_START		(RZT2H_ICU_SEI_START +		\
+						 RZT2H_ICU_SEI_COUNT)
+#define RZT2H_ICU_CA55_ERR_COUNT		2
+
+#define RZT2H_ICU_CR52_ERR_START		(RZT2H_ICU_CA55_ERR_START +	\
+						 RZT2H_ICU_CA55_ERR_COUNT)
+#define RZT2H_ICU_CR52_ERR_COUNT		4
+
+#define RZT2H_ICU_PERI_ERR_START		(RZT2H_ICU_CR52_ERR_START +	\
+						 RZT2H_ICU_CR52_ERR_COUNT)
+#define RZT2H_ICU_PERI_ERR_COUNT		2
+
+#define RZT2H_ICU_DSMIF_ERR_START		(RZT2H_ICU_PERI_ERR_START +	\
+						 RZT2H_ICU_PERI_ERR_COUNT)
+#define RZT2H_ICU_DSMIF_ERR_COUNT		2
+
+#define RZT2H_ICU_ENCIF_ERR_START		(RZT2H_ICU_DSMIF_ERR_START +	\
+						 RZT2H_ICU_DSMIF_ERR_COUNT)
+#define RZT2H_ICU_ENCIF_ERR_COUNT		2
+
 #define RZT2H_ICU_NUM_IRQ			(RZT2H_ICU_INTCPU_NS_COUNT +	\
 						 RZT2H_ICU_INTCPU_S_COUNT +	\
 						 RZT2H_ICU_IRQ_NS_COUNT +	\
 						 RZT2H_ICU_IRQ_S_COUNT +	\
-						 RZT2H_ICU_SEI_COUNT)
+						 RZT2H_ICU_SEI_COUNT +		\
+						 RZT2H_ICU_CA55_ERR_COUNT +	\
+						 RZT2H_ICU_CR52_ERR_COUNT +	\
+						 RZT2H_ICU_PERI_ERR_COUNT +	\
+						 RZT2H_ICU_DSMIF_ERR_COUNT +	\
+						 RZT2H_ICU_ENCIF_ERR_COUNT)
=20
 #define RZT2H_ICU_IRQ_IN_RANGE(n, type)						\
 	((n) >=3D RZT2H_ICU_##type##_START &&					\
@@ -54,6 +79,29 @@
 #define RZT2H_ICU_MD_RISING_EDGE		0b10
 #define RZT2H_ICU_MD_BOTH_EDGES			0b11
=20
+#define RZT2H_ICU_CA55ERR_E0MSK			0x50
+#define RZT2H_ICU_CA55ERR_CLR			0x60
+#define RZT2H_ICU_CA55ERR_STAT			0x64
+#define RZT2H_ICU_CA55ERR_MASK			GENMASK(12, 0)
+
+#define RZT2H_ICU_PERIERR_E0MSKn(n)		(0x98 + 0x4 * (n))
+#define RZT2H_ICU_PERIERR_CLRn(n)		(0xc8 + 0x4 * (n))
+#define RZT2H_ICU_PERIERR_STAT			0xd4
+#define RZT2H_ICU_PERIERR_NUM			3
+#define RZT2H_ICU_PERIERR_MASK			GENMASK(31, 0)
+
+#define RZT2H_ICU_DSMIFERR_E0MSKn(n)		(0xe0 + 0x4 * (n))
+#define RZT2H_ICU_DSMIFERR_CLRn(n)		(0x1a0 + 0x4 * (n))
+#define RZT2H_ICU_DSMIFERR_STAT			0x1d0
+#define RZT2H_ICU_DSMIFERR_NUM			12
+#define RZT2H_ICU_DSMIFERR_MASK			GENMASK(31, 0)
+
+#define RZT2H_ICU_ENCIFERR_E0MSKn(n)		(0x200 + 0x4 * (n))
+#define RZT2H_ICU_ENCIFERR_CLRn(n)		(0x250 + 0x4 * (n))
+#define RZT2H_ICU_ENCIFERR_STAT			0x264
+#define RZT2H_ICU_ENCIFERR_NUM			5
+#define RZT2H_ICU_ENCIFERR_MASK			GENMASK(31, 0)
+
 #define RZT2H_ICU_DMACn_RSSELi(n, i)		(0x7d0 + 0x18 * (n) + 0x4 * (i))
 #define RZT2H_ICU_DMAC_REQ_SELx_MASK(x)		(GENMASK(9, 0) << ((x) * 10))
 #define RZT2H_ICU_DMAC_REQ_SELx_PREP(x, val)	(FIELD_PREP(GENMASK(9, 0), va=
l) << ((x) * 10))
@@ -285,6 +333,50 @@ static irqreturn_t rzt2h_icu_intcpu_irq(int irq, void =
*data)
 	return IRQ_HANDLED;
 }
=20
+static irqreturn_t rzt2h_icu_err_irq(struct rzt2h_icu_priv *priv, const ch=
ar *name,
+				     unsigned int num, u32 stat_base, u32 clr_base)
+{
+	bool handled =3D false;
+
+	for (unsigned int n =3D 0; n < num; n++) {
+		u32 stat =3D readl(priv->base_ns + stat_base + n * 0x4);
+
+		if (!stat)
+			continue;
+
+		handled =3D true;
+
+		pr_err("rzt2h-icu: %s error n=3D%u status=3D0x%08x\n", name, n, stat);
+
+		writel_relaxed(stat, priv->base_ns + clr_base + n * 0x4);
+	}
+
+	return handled ? IRQ_HANDLED : IRQ_NONE;
+}
+
+static irqreturn_t rzt2h_icu_ca55_err_irq(int irq, void *data)
+{
+	return rzt2h_icu_err_irq(data, "CA55", 1, RZT2H_ICU_CA55ERR_STAT, RZT2H_I=
CU_CA55ERR_CLR);
+}
+
+static irqreturn_t rzt2h_icu_peri_err_irq(int irq, void *data)
+{
+	return rzt2h_icu_err_irq(data, "peripheral", RZT2H_ICU_PERIERR_NUM, RZT2H=
_ICU_PERIERR_STAT,
+				 RZT2H_ICU_PERIERR_CLRn(0));
+}
+
+static irqreturn_t rzt2h_icu_dsmif_err_irq(int irq, void *data)
+{
+	return rzt2h_icu_err_irq(data, "DSMIF", RZT2H_ICU_DSMIFERR_NUM, RZT2H_ICU=
_DSMIFERR_STAT,
+				 RZT2H_ICU_DSMIFERR_CLRn(0));
+}
+
+static irqreturn_t rzt2h_icu_encif_err_irq(int irq, void *data)
+{
+	return rzt2h_icu_err_irq(data, "ENCIF", RZT2H_ICU_ENCIFERR_NUM, RZT2H_ICU=
_ENCIFERR_STAT,
+				 RZT2H_ICU_ENCIFERR_CLRn(0));
+}
+
 static int rzt2h_icu_request_irqs(struct platform_device *pdev, struct irq=
_domain *irq_domain,
 				  unsigned int start, unsigned int count, irq_handler_t handler,
 				  void *data)
@@ -315,10 +407,13 @@ static int rzt2h_icu_request_irqs(struct platform_dev=
ice *pdev, struct irq_domai
=20
 static int rzt2h_icu_setup_irqs(struct platform_device *pdev, struct irq_d=
omain *irq_domain)
 {
+	struct rzt2h_icu_priv *priv =3D platform_get_drvdata(pdev);
+	unsigned int n;
+	int ret;
+
 	if (IS_ENABLED(CONFIG_GENERIC_IRQ_INJECTION)) {
-		int ret =3D rzt2h_icu_request_irqs(pdev, irq_domain, RZT2H_ICU_INTCPU_NS=
_START,
-						 RZT2H_ICU_INTCPU_NS_COUNT, rzt2h_icu_intcpu_irq,
-						 NULL);
+		ret =3D rzt2h_icu_request_irqs(pdev, irq_domain, RZT2H_ICU_INTCPU_NS_STA=
RT,
+					     RZT2H_ICU_INTCPU_NS_COUNT, rzt2h_icu_intcpu_irq, NULL);
 		if (ret)
 			return ret;
=20
@@ -328,6 +423,54 @@ static int rzt2h_icu_setup_irqs(struct platform_device=
 *pdev, struct irq_domain
 			return ret;
 	}
=20
+	/*
+	 * There are two error interrupts and two error masks that can be used
+	 * separately for each error type. It would not be very useful to
+	 * receive two interrupts for the same error, so use only the first one.
+	 */
+
+	ret =3D rzt2h_icu_request_irqs(pdev, irq_domain, RZT2H_ICU_CA55_ERR_START=
, 1,
+				     rzt2h_icu_ca55_err_irq, priv);
+	if (ret)
+		return ret;
+
+	ret =3D rzt2h_icu_request_irqs(pdev, irq_domain, RZT2H_ICU_PERI_ERR_START=
, 1,
+				     rzt2h_icu_peri_err_irq, priv);
+	if (ret)
+		return ret;
+
+	ret =3D rzt2h_icu_request_irqs(pdev, irq_domain, RZT2H_ICU_DSMIF_ERR_STAR=
T, 1,
+				     rzt2h_icu_dsmif_err_irq, priv);
+	if (ret)
+		return ret;
+
+	ret =3D rzt2h_icu_request_irqs(pdev, irq_domain, RZT2H_ICU_ENCIF_ERR_STAR=
T, 1,
+				     rzt2h_icu_encif_err_irq, priv);
+	if (ret)
+		return ret;
+
+	/* Clear and unmask CA55 error events */
+	writel_relaxed(RZT2H_ICU_CA55ERR_MASK, priv->base_ns + RZT2H_ICU_CA55ERR_=
CLR);
+	writel_relaxed(0, priv->base_ns + RZT2H_ICU_CA55ERR_E0MSK);
+
+	/* Clear and unmask peripheral error events */
+	for (n =3D 0; n < RZT2H_ICU_PERIERR_NUM; n++) {
+		writel_relaxed(RZT2H_ICU_PERIERR_MASK, priv->base_ns + RZT2H_ICU_PERIERR=
_CLRn(n));
+		writel_relaxed(0, priv->base_ns + RZT2H_ICU_PERIERR_E0MSKn(n));
+	}
+
+	/* Clear and unmask DSMIF error events */
+	for (n =3D 0; n < RZT2H_ICU_DSMIFERR_NUM; n++) {
+		writel_relaxed(RZT2H_ICU_DSMIFERR_MASK, priv->base_ns + RZT2H_ICU_DSMIFE=
RR_CLRn(n));
+		writel_relaxed(0, priv->base_ns + RZT2H_ICU_DSMIFERR_E0MSKn(n));
+	}
+
+	/* Clear and unmask ENCIF error events */
+	for (n =3D 0; n < RZT2H_ICU_ENCIFERR_NUM; n++) {
+		writel_relaxed(RZT2H_ICU_ENCIFERR_MASK, priv->base_ns + RZT2H_ICU_ENCIFE=
RR_CLRn(n));
+		writel_relaxed(0, priv->base_ns + RZT2H_ICU_ENCIFERR_E0MSKn(n));
+	}
+
 	return 0;
 }
=20
--=20
2.55.0


