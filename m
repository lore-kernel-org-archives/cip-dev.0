Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550CFC83F05
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 09:06:56 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.61])
 by mx.groups.io with SMTP id smtpd.web11.8463.1751620014439566996
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Jul 2025 02:06:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=QxC+qWrz;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.61, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ic0cnoRtFZOyq8REqNtzzGNgaq0EO3gsiAlTWr92Cz6Iiy3xgbzV+QwYrbcX5ykC1kbOhDzkcMes+F80BCgEbMF1xoM8tAHJK1VYeJqJ4+gjQ66rDLZjLNm1tG10IQIxypM+F4rNGtJlUki4fGnOBC4Q/txdNkU3KFU1DroLJSAjHNQfAC83e7CBPFwx72ptxLy6J7R3HA2uvooeVcAoXukhIZx7e8ZR2x/WloZxPYKAx2JeiqqT8DpvFIb92X5y3AOhvjRuLTWlUy7CNkOT5t0KYFLl0uePUuT3j7VNyjnqQR1NRCmLkmZgPoCDtFOPDmGivyitwRmH1O8C6ar8AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22S+C025NRgEsw0zqlGiqK8/QPqW/LGMKOo+PjSeyFw=;
 b=MoL3nXBtmX98BLPXBlJg/ASzXY3Z8cbbAz95KZFbADi7TG91m6hQLYVRRgbvELl6SRaOiOhSuuTTo1DAix1pT9iwetJ4gHetBQricuH0OaSe4wlvRVk6XBpMdLAzJ3zMulANl3igEGMLHoLbONZC6stM84Yqgon1RT5UN+loByOv5BnCsfiKK2pHSMeEyTYDVHkfcOq8Tj42xPMPA3ivHSZJa8g1AYGw6Y5ddC0YRtcckWPa3fQBOj++WUFO1S+aJL+hYL8JHTH1ny1UVNQJQYP2whXrVrhI0Dtzyfe8cBz139KQba9ml1GdBqO/Xb1IMdaeJZWp3Gj/tu+9Mupt9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22S+C025NRgEsw0zqlGiqK8/QPqW/LGMKOo+PjSeyFw=;
 b=QxC+qWrzxWLxgnU7UmSj23TxEJXBZB492ITqgwAtizLUXgWQZpfqM+4I9p1s1Md/HNkMoZtuMLwIsEwn8ious5Ehg/S7/KuS0jJL3eRRRpUYRjyN/pOTjvuJ6sXbwwHN8g/ngswx4zq41ffZv+0ek/seSAhLBIErCbHog03zRcM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYYPR01MB13039.jpnprd01.prod.outlook.com (2603:1096:405:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 4 Jul
 2025 09:06:52 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Fri, 4 Jul 2025
 09:06:52 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 12/14] irqchip/renesas-rzv2h: Add RZ/G3E support
Date: Fri,  4 Jul 2025 11:05:54 +0200
Message-ID: <20250704090556.669652-13-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704090556.669652-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250704090556.669652-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::8) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYYPR01MB13039:EE_
X-MS-Office365-Filtering-Correlation-Id: f196f40f-5c6f-43b5-9c54-08ddbada1db3
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?aw7zPGzIRZ2UbkgUBTTJ3dI3CjfUHlXIaZkT7+odWyWBxv67oFq15DPa4kjT?=
 =?us-ascii?Q?3ZjNea44zaJlk+VRE6pt+hKXE91bYfXGUdbtrzsq4uGW7/cYbysxLdERc8pv?=
 =?us-ascii?Q?b9vATCcyUost5wDCuQFZFIsQv4lFX/BdEykWpW+9LRv2yIVpaf6iXjDvuNOw?=
 =?us-ascii?Q?d8Veyme6uerrP381uOXTMAzBgjypaaIQek8VhtvwgN7cwVB60N/5N0d2rRSk?=
 =?us-ascii?Q?3bo+lGdutR8DsIDcha5a93mt/zd/9xEFIRAneQnA/Im2tvrS7S+veP9+buE3?=
 =?us-ascii?Q?IBYJ2oD+GHQUGYfpt6nM7FhZW9Rp9AT90TZ7O18uCae9rATtbdip/2+7W+I3?=
 =?us-ascii?Q?R7xalQl3WJ5DQkvk+pjyeo6VYU1P4TFKhGpu1ItsmBwBSJuI4pN1ygmmi7er?=
 =?us-ascii?Q?T+H0OCGdOX3xgtR8H8Ds6vDKZkEIu6DNpd6hBFsoauYQTc0MMrdAsFMKrx/J?=
 =?us-ascii?Q?vqmvn8PuBcjmPydkPq7/0CwN42pyTGGPUxj31S/cu5G9R1Qp9Cf6nuuoLYmu?=
 =?us-ascii?Q?9mDi/9eieNoC1ysI+Ldul4x1TvGdly5weXWupJLGRJAmOJhePfK/WXwEdtMW?=
 =?us-ascii?Q?vCzRl25XSPIxy3k/UX/Syv2kmsyOylT0OEwoY4MVJABxdf/a+R0uls9i7y88?=
 =?us-ascii?Q?RVmKcxp1hbBexJt5FKDnjo09GING36PcQ7mSY6p2duJQyUTCw9e5khfFmYBq?=
 =?us-ascii?Q?6bSF6zY0E7eI6u+buX+6LV9UsTstm2TyG1tdgfM+H9WKaxT9QGj+MIA53VE3?=
 =?us-ascii?Q?rdvnUlRgaNrwsyp/e+MreWKJE85T052grZOhyifpJKxcII2+dnCVLfTRF6o3?=
 =?us-ascii?Q?Ha0HdDNORIu24nzF8pWc0y1khB2cIHBK9cWzMVhurLFq9itOQjQMxMPzQN04?=
 =?us-ascii?Q?zX10C4cDtDag25cTHOs/SAZ1Pr9+xZB05BR6UB0kCVN4oZE09Hq9TYsxbDD1?=
 =?us-ascii?Q?71/J78lQsrc3R8Q6i9+I1hEfGm+mTjrf26t0qei3gZwMrCvzzhGsH8IyJb13?=
 =?us-ascii?Q?sZOe/9QwXMhHGeWfw/BF+4JEcZ4yzqnn3KpGVpRmratCNEcIBBlrC+w36z+V?=
 =?us-ascii?Q?sbVCVMHozPyAMG2oRH26TJU97iqKVCWGUtGSO3F3LNZwN6ddWva17yx+QZPG?=
 =?us-ascii?Q?NPG098BQ1swxcjoenVO7KyHZ/JxFXaBOiMjehzR6Mqae9gityBSVxZ2T/oHf?=
 =?us-ascii?Q?btWnTDALOGCxVUiayTolvmJIpIFpQPVGuRmaApTtx3p07jzHgJJyx8mjyeia?=
 =?us-ascii?Q?TvsDIkwNG8xsb7oQ+pQFI+zQi/yphCc21nhjIS0tWmEorouPhuD6MtW1IotB?=
 =?us-ascii?Q?YHzhTNoG6JUQETyLTxx/sjdrBpdKSTdllavbpC+10XCadbK+A511uIlfackr?=
 =?us-ascii?Q?jGQQP8Yt/vN+G/yM0824B4xGWZmlLMjpyrJKW76pK0m1NzSc8wYOEvLl24Xm?=
 =?us-ascii?Q?+rwHiDyo5pgU/G4HHxjvh+vfqjYvDtZrOt1/kisp7+hvt41GZtMMFvtLH0nJ?=
 =?us-ascii?Q?etHVGUir3ErbZOY=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Z68cTuHIpoLxTBRHksg1yUq/PSqz1Mg2Ng341BK/ekT/h0sCYIIWqO3d6iIf?=
 =?us-ascii?Q?gdv3U1tp7RsN5NFvdHdcIONNSoJ5AGHU4bRWuvSO+N1LOUHGhrqv/y2SuItU?=
 =?us-ascii?Q?YmTzR1dEvBfVLP166jEKuNQ2OZF3F69YEqp/go892ZFe2CwmpC2by3rJvm49?=
 =?us-ascii?Q?Hw3EZyB1YmCHRIzz9pY9LDvpxKfyTCcvQkK3toAcX2r8R2chI+/WMw46Dn5w?=
 =?us-ascii?Q?Bt2AbXDJ4f93n2INbm8v1mUSHhs85bFZCRT4PBDg0Z8Jl1xhfsBKOyn+kBin?=
 =?us-ascii?Q?Gf25RaoeXs8pGZDEJO+xsJlpoM63Aok1qRw9OsCdjgx0WD1YRjf2Ce9Uu5sd?=
 =?us-ascii?Q?K6Lom+XMcjK7uYixnt+MnMWTG0+KHp2d9orOqqjXVghJgW4RiC9HoovjbKCg?=
 =?us-ascii?Q?wV/40sSFSAuMtQhOW98RFgkJJfBr5hw1UeNZnZP2/o+AeybUMjGCBCq14706?=
 =?us-ascii?Q?Yft1j+gmBXd6wb8zMs27WbzjLcX/ViOzv/i1ioK3d+xBf/8jWirep5fOobWC?=
 =?us-ascii?Q?9CKSlMkviGcbtVKnTKBoY4R9YIRAj2XE9DUrBujxwWE1JyM8iKAvD+K7cdMQ?=
 =?us-ascii?Q?5XNTsEYEJ/EYUyewVZX7gfnLkMVrdOEKg2MwcPC7+jb6eGiYqn1aXgWD27hx?=
 =?us-ascii?Q?cZS5kYrbI3AsVbinK/YW971B9sLN5urVPG1HamGNbnVtlinMKkIA3x2EoynV?=
 =?us-ascii?Q?I/xTC6vJHNE0yi+XEdLa78kJ1Lte8QQ2trP4dCxnIPsZ6EXbuU/Nby+/zmAa?=
 =?us-ascii?Q?efXUKq1X8nCqlxgaS3UDGc8VKzZsZVAH7f2knX39yLMm9wIaWQaZvt+rOEmH?=
 =?us-ascii?Q?Vv1oPL+9XbwwV3nWOp1aO5Uha+TCD84HT7r8Ayqft3n1TfByH1oHO1JHFbXG?=
 =?us-ascii?Q?OdqSU48H6AARXxA3Tc6AI3WU+jQBha7rUFUaEpybHEGikRV2X2v5mhbExQzC?=
 =?us-ascii?Q?oJvaRvysWNQE9RpqLWvnvF48Jy60rZG/6zgUKamVIYGtCiFTMYVE5MyxaY64?=
 =?us-ascii?Q?Y2l1lILHbRZkqqAbQGZX/q+RdDILlOlOoLkygukQxCurfpUaun9xe3teqy8r?=
 =?us-ascii?Q?Y7l65qpZqnqUEkQ+nyEGzPUoELFN4t4FEFc6assmgzdwDSBvDcZnsbACqQ4X?=
 =?us-ascii?Q?2Pucx/RMgUP87Y1Jo3v7cTYDQw6lBQ4U3/4203m0xEpzGFRGca6BIlGETuW5?=
 =?us-ascii?Q?qat14mfpDzfi3k+KkkaFX+7GZKT3Fb4ZRYpJRo+3WmGmkQ1okZLWnKMMXo7+?=
 =?us-ascii?Q?gLGg6JVvj8T+kpRRTSx4IwU5NJnS0TvS2K2678BCv1rl4NWB9KolICYNw3xa?=
 =?us-ascii?Q?2Yu3yMd8XJ29L/nYm9xDIVJHKDgELqEyFtDfxxYVkeGK9PJpk9lB8Bfo2cc3?=
 =?us-ascii?Q?iPpugLyb90sj+XcNtbesig2kFXxzkMLPJfNtmr2w+BsUj34/leVk8mV/Syaa?=
 =?us-ascii?Q?u6veJkhNbo475urg+MZ+gVR2DbYBxVli85thDgyPbNpkpQgFqEOXv1w0t5gH?=
 =?us-ascii?Q?rCAMgbrIghrazdhEV6qnInMg5+q+nmIeS00ab7D5miQFE2kuFbynvsaBaI1Y?=
 =?us-ascii?Q?o2orBceVgwO/bFqT5A5GKFemjKn1y6jPjA1M5k43HfXA3XXO9ewGs48SZJGR?=
 =?us-ascii?Q?U41rWVnHPZpXBDMRk/VemVQ=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f196f40f-5c6f-43b5-9c54-08ddbada1db3
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 09:06:52.3563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLS4Ti2BXxyUtcBbk3x6BiaiOzsSfSRoC4kmJVdAAhpg991O35WyL880yMSzAkwhjUaq/nfKH/iTVxf3apU6eEDEU3j9bptEeTpYTR+hBNwj/Dp9s4UYMQUCSE5Shy1c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13039
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Jul 2025 09:06:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19341

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 399b2799985237cf5c3656b7cfc87cdaa489efd1 upstream.

The ICU block on the RZ/G3E SoC is almost identical to the one found on
the RZ/V2H SoC, with the following differences:

 - The TINT register base offset is 0x800 instead of zero.
 - The number of GPIO interrupts for TINT selection is 141 instead of 86.
 - The pin index and TINT selection index are not in the 1:1 map.
 - The number of TSSR registers is 16 instead of 8.
 - Each TSSR register can program 2 TINTs instead of 4 TINTs.

Add support for the RZ/G3E driver by filling the rzv2h_hw_info table and
adding LUT for mapping between pin index and TINT selection index.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/all/20250224131253.134199-13-biju.das.jz@bp.r=
enesas.com
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 46 +++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-rene=
sas-rzv2h.c
index d1e2613dd7d3..374108f2fcda 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -85,15 +85,19 @@
=20
 #define ICU_TINT_EXTRACT_HWIRQ(x)		FIELD_GET(GENMASK(15, 0), (x))
 #define ICU_TINT_EXTRACT_GPIOINT(x)		FIELD_GET(GENMASK(31, 16), (x))
+#define ICU_RZG3E_TINT_OFFSET			0x800
+#define ICU_RZG3E_TSSEL_MAX_VAL			0x8c
 #define ICU_RZV2H_TSSEL_MAX_VAL			0x55
=20
 /**
  * struct rzv2h_hw_info - Interrupt Control Unit controller hardware info =
structure.
+ * @tssel_lut:		TINT lookup table
  * @t_offs:		TINT offset
  * @max_tssel:		TSSEL max value
  * @field_width:	TSSR field width
  */
 struct rzv2h_hw_info {
+	const u8	*tssel_lut;
 	u16		t_offs;
 	u8		max_tssel;
 	u8		field_width;
@@ -317,6 +321,9 @@ static int rzv2h_tint_set_type(struct irq_data *d, unsi=
gned int type)
 	if (tint > priv->info->max_tssel)
 		return -EINVAL;
=20
+	if (priv->info->tssel_lut)
+		tint =3D priv->info->tssel_lut[tint];
+
 	hwirq =3D irqd_to_hwirq(d);
 	tint_nr =3D hwirq - ICU_TINT_START;
=20
@@ -530,18 +537,57 @@ static int rzv2h_icu_init_common(struct device_node *=
node, struct device_node *p
 	return ret;
 }
=20
+/* Mapping based on port index on Table 4.2-6 and TSSEL bits on Table 4.6-=
4 */
+static const u8 rzg3e_tssel_lut[] =3D {
+	81, 82, 83, 84, 85, 86, 87, 88,		/* P00-P07 */
+	89, 90, 91, 92, 93, 94, 95, 96,		/* P10-P17 */
+	111, 112,				/* P20-P21 */
+	97, 98, 99, 100, 101, 102, 103, 104,	/* P30-P37 */
+	105, 106, 107, 108, 109, 110,		/* P40-P45 */
+	113, 114, 115, 116, 117, 118, 119,	/* P50-P56 */
+	120, 121, 122, 123, 124, 125, 126,	/* P60-P66 */
+	127, 128, 129, 130, 131, 132, 133, 134,	/* P70-P77 */
+	135, 136, 137, 138, 139, 140,		/* P80-P85 */
+	43, 44, 45, 46, 47, 48, 49, 50,		/* PA0-PA7 */
+	51, 52, 53, 54, 55, 56, 57, 58,		/* PB0-PB7 */
+	59, 60,	61,				/* PC0-PC2 */
+	62, 63, 64, 65, 66, 67, 68, 69,		/* PD0-PD7 */
+	70, 71, 72, 73, 74, 75, 76, 77,		/* PE0-PE7 */
+	78, 79, 80,				/* PF0-PF2 */
+	25, 26, 27, 28, 29, 30, 31, 32,		/* PG0-PG7 */
+	33, 34, 35, 36, 37, 38,			/* PH0-PH5 */
+	4, 5, 6, 7, 8,				/* PJ0-PJ4 */
+	39, 40, 41, 42,				/* PK0-PK3 */
+	9, 10, 11, 12, 21, 22, 23, 24,		/* PL0-PL7 */
+	13, 14, 15, 16, 17, 18, 19, 20,		/* PM0-PM7 */
+	0, 1, 2, 3				/* PS0-PS3 */
+};
+
+static const struct rzv2h_hw_info rzg3e_hw_params =3D {
+	.tssel_lut	=3D rzg3e_tssel_lut,
+	.t_offs		=3D ICU_RZG3E_TINT_OFFSET,
+	.max_tssel	=3D ICU_RZG3E_TSSEL_MAX_VAL,
+	.field_width	=3D 16,
+};
+
 static const struct rzv2h_hw_info rzv2h_hw_params =3D {
 	.t_offs		=3D 0,
 	.max_tssel	=3D ICU_RZV2H_TSSEL_MAX_VAL,
 	.field_width	=3D 8,
 };
=20
+static int rzg3e_icu_init(struct device_node *node, struct device_node *pa=
rent)
+{
+	return rzv2h_icu_init_common(node, parent, &rzg3e_hw_params);
+}
+
 static int rzv2h_icu_init(struct device_node *node, struct device_node *pa=
rent)
 {
 	return rzv2h_icu_init_common(node, parent, &rzv2h_hw_params);
 }
=20
 IRQCHIP_PLATFORM_DRIVER_BEGIN(rzv2h_icu)
+IRQCHIP_MATCH("renesas,r9a09g047-icu", rzg3e_icu_init)
 IRQCHIP_MATCH("renesas,r9a09g057-icu", rzv2h_icu_init)
 IRQCHIP_PLATFORM_DRIVER_END(rzv2h_icu)
 MODULE_AUTHOR("Fabrizio Castro <fabrizio.castro.jz@renesas.com>");
--=20
2.43.0


