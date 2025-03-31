Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BB3C3600C
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:46:41 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.6])
 by mx.groups.io with SMTP id smtpd.web11.48819.1743418000098288197
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:46:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=MvcS9wsL;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.6, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RtIPpQlVOeA8rECEcgKPeHKLelCFBv3fqQHQpI8B4hbYv3uBdhRSiQ53Bp076rvlfizadFfVM3aF7QYStibqLtkZSgOI97622vCBfKKCnX9bW5e4HqXOPszFm6NK5c0ebZKal2XigkhBK+0HWSqysWBx/P4eunz14eOVXFoJpzfpGeoE1YlmmB7hygA75tc7B0ac0b1YFviLKpnDMyVzBrtbpSD+xlvuSVtF9K8Ycz5X6dU47hdVQyebc4QjwoxpZyyCX7ZNmgdBePHuuIYwecwc/UvVWL+kZLoIjXQWgqTZ/YvCxHEO0mNQzy4DdkaOKt31l4NUzBXi7iMbm+d/Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CF8foSSqQ81GWpEe96hyAlLp9TlUGjOxpXj2T4soehY=;
 b=ISDCCiwp+qMiNXuwhbhBAIG0OGv1umyI9OGrybLe8kC8FSDWJVCVWtznU2TYtevChKAbxhPYidcs7qAk6fpAvSifhHOW6yzwXMXFDRX/GqvGfvPC3VTFwPUQvNVHogwPRkoi0Yiw8A7fy5UCbRYDtdTF+Uq0hHBQvalUbUVbmfM5pbaLqrtWjmmypKsIZuvulrw2vuetFjYRpqpiSX2dqFgTC8hlCHTOYQz0s63V88QJhRxHATxV622vUwFhmSbEuwO1QbBSnH10Vh/2+0USBvBGnpnhTDknLsSo3/vU7Hz8jo9Hl4H6nIMIzF2abtOTye0F7SXyGCc+hGP3HT230Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CF8foSSqQ81GWpEe96hyAlLp9TlUGjOxpXj2T4soehY=;
 b=MvcS9wsLWIsXEg3ER545Y8GEjWp5IoTGJCOEVUxMI3s7iUK6J1Yr+BLFGsCpjwVRJHg44AudzrIwkHgA09vyz6BtYcV4py41Z9fnkM4FwKSE24uDSp5ACcl05pMCYNLTLj2sS+Pna4kDr3iOKBsR8RR1HrzEGBJctdE9MntAe28=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY7PR01MB13744.jpnprd01.prod.outlook.com (2603:1096:405:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.33; Mon, 31 Mar
 2025 10:46:37 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:46:37 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 22/43] pinctrl: renesas: rzg2l: Move RZG2L_SINGLE_PIN definition to top of the file
Date: Mon, 31 Mar 2025 12:44:53 +0200
Message-ID: <20250331104514.79090-23-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY7PR01MB13744:EE_
X-MS-Office365-Filtering-Correlation-Id: 16089afc-14c5-44cf-3459-08dd70414fb2
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?hPnrw4RxvMZ5Gf1WiS/pl9auNlp11HIfDDPGgDI16PXDqToWfQUXJ5pDx7Kk?=
 =?us-ascii?Q?StiTOqtoZXDtAUMt7zzz1TPLnL+QzoHBODa3iFl40qOMZJNqs3D7WCN+G7oG?=
 =?us-ascii?Q?4nnylAhUgGq2gRHCjMLzyrnA7uHwsAR+cwNbd66R7Qwh8HqIye/dQyGySgGT?=
 =?us-ascii?Q?ijltAPz8tA6MbSbbv5+ZoIJ6eqJ0slhoGZDGIoz8rXythqIQsWDI1tH9cbL3?=
 =?us-ascii?Q?n+VsIZsw+S+mWC/y9Q5451sMsnsOes0DRYV0nuaqnIAcBFb447fY8IlA4Qbu?=
 =?us-ascii?Q?iLqYtPTfPm0HaFkaygRNwLQGH/3ZmJPizSjE2FwZTvPiqodIKoYeVN2JM9Ty?=
 =?us-ascii?Q?ZyCsjd2YLPLfAfDgeUrAk+1ubMfFxGzMzuxgF/uasouXQDPfLP71QPH4tduQ?=
 =?us-ascii?Q?K54Kp7hjJm3880/AxCJg6IB4HJIkQCvmxyESeceiMNSPsog2SaG4E3O9dmMT?=
 =?us-ascii?Q?//KGjAWKc0H05WwZw6Z71AjB6YqfxATetyW6bXYVtIeDOuWDIZbhlkcbElgo?=
 =?us-ascii?Q?O+VRMxev4USzjxG7tCrL/8JpNDdUdBWrJzfh5Rh7jALnmsfrXdxpw290K6CM?=
 =?us-ascii?Q?/fzLiuFqhgPnGMBJ6GaKBjWdakofPDRZBmOL6PWWbOvOLzrDOLMc23KcLbsv?=
 =?us-ascii?Q?M9ViDeYHpKDyzFI3nNJ/XwfP3vyL4oLQ6hLvpmUZ7Dt6GPXFlqVxRXpxZ7R7?=
 =?us-ascii?Q?WLszHROyUWXNYuUuEDe8/rJAiiRW7D0Thh02A0deYLFCWxGGtyG2moBLxxgO?=
 =?us-ascii?Q?fz6ZIU2vKh+z5vSrtzX1BarLpqXD3L8qgt5z+xNGzZT+JwRNxc7QMH1hHGJb?=
 =?us-ascii?Q?F6dkO5HIL2ziAcmSElxvgPRc+vfJpCnUaB7ZqCncIwN6ualTFzjo2pEmYK8k?=
 =?us-ascii?Q?RWhDQUxNEdvNElcyX3NiIbV/PMeV1b378eH0CxMVcd6B+Y24hG3AB0lkaHY1?=
 =?us-ascii?Q?eu13jlWjiwZuLIPJW97VBOv9dY4jK9KPqwwc9C5XY0IaAGBc1YkpBvBx/dr6?=
 =?us-ascii?Q?UkX+/0J+Iy669Zzvt8owvBFaKEIvmw9/HDbfHtbX/c/QtaKmNNyZleQgfwz6?=
 =?us-ascii?Q?9+87Kpc3hAvSFAfis3z81BRU2WVxnftBLFeL2Y6aDn0SI8fXMRCr3nvK7l4i?=
 =?us-ascii?Q?N808gNcRoE6OxltpXf7KM9cIfd/T+b38uXFkUskoEqIhn8K0yBd6QMFji/mT?=
 =?us-ascii?Q?WKeG+D7FPSzYUGLodJpXuAbG/w9oBPS0/TUSUfSOHoZSbhXXs2ylNoBkiCE5?=
 =?us-ascii?Q?+YTbrWFDlUC3vyQ+l/LbFUd9irCzwivZHlBJPDcYTJ3VhRR4ThRIGWmnXjg3?=
 =?us-ascii?Q?OS9hKxGUH4hxNSZk6H8BLzDTFTGh91g5c2tfBienUm09gpJnviouLRDKVNrQ?=
 =?us-ascii?Q?5g97LGC4efd97kcRRG1beRu13DYulBUC4SJmoYnkY/zW7ZHRWTZo7ZxFoByy?=
 =?us-ascii?Q?7URMep77vFABsbOBPD0DW8Qy9BTs3ACA?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?aqJPN60OHhwogOzT1nye7DzjSK6rxli3UMHrs+1wlr9lcg5U4Vee3NtcmFsV?=
 =?us-ascii?Q?MJLD6RW6Ygl75zLqLduhdy0AQuDI0wcbeVOdSbfcdWMFJB3oHASfKIARKtOL?=
 =?us-ascii?Q?AmCcFWtT5FuaZuPldDKe5d4Yt9LrI1btsm+jwnAx1Dp++pIyb7ke0eXO6GCa?=
 =?us-ascii?Q?kcJZmw/ZTo1Alkjex7Nir5soEg3oe87nGebRwQN3PLi3xQON+1sZlXMCil2j?=
 =?us-ascii?Q?bLt1zgtlQrUkulJ4L7kQh8SIllNweDxq6U8J2WVj7HM+NBOF8Symy7kzMWMC?=
 =?us-ascii?Q?yXw2f5zpPonOtcPxsAx0LANx+a9U4ALVPU/uMywGWO8hYO6dQhS08T70SoA3?=
 =?us-ascii?Q?Dhx8vugbIC+fNxZ7/n7XuOA5Eta1qm3OP6aYS9/9rXmQNGc27korkFt2OjoW?=
 =?us-ascii?Q?DdKoiSUeMo3EczleugzRF4fQGPrs/h4A2FscylqxGqLJ3Cr1IPR1nzSicyRu?=
 =?us-ascii?Q?cExkQ5EVQJfhGlJ1CuXMY0ifUBAtdSYOYOIrT2/cwYs/oZsBxGBZfep9qaqX?=
 =?us-ascii?Q?GCncI4qbXs18XLwO/pvbkbRampuVIpIc7p+cY6EL/Vp4tPqb2F+stWygeYXZ?=
 =?us-ascii?Q?5WMN+eLNvl2fdCNRCLBEInx4rIL2BOn3Iy7oXuMSiwLJb1+1bK+jR6RpXdBM?=
 =?us-ascii?Q?FhVu/Nz7nuoWZ2KG8YNVImapdn28OHrNZcafeKc/DK7QBVvlJftKbxowQJwu?=
 =?us-ascii?Q?xHwa+DbQNBCY1jJJlXQL0tDdmkWw88E4NbmxiyXMy8wI3KuN/80Jj3Po/i+b?=
 =?us-ascii?Q?Z0qvQFIIsaFgj9AKX5biQUp3LfxV0kFN+IUHYXDbjTe/iuWRsl97qyziXG+J?=
 =?us-ascii?Q?m1hpE2PAg46hldmS6DExNACCVTK7M5O8gGwCGerjuQci4hdNyLdgVvDRV45+?=
 =?us-ascii?Q?EEMF/9j2UjNdCZmOsQr2M67uxaLB+kuJ9BYuAKlRKLORDyeUFMEHwN15QPfi?=
 =?us-ascii?Q?o08RlJx0uhieMTcAe02ZXQmMC69+wJtu18FpFYE+3Zpn45Ic34cCnFiT7r4t?=
 =?us-ascii?Q?OwtKkigJxSQHbuEugqjp3wkkWGhpaW/N5OmGy2dEonSl2uPk3mgHMVU0QTT+?=
 =?us-ascii?Q?rv+AsquJo5eQV8h3rvjzVbHit0lVmUbrrSsPyNmFFePXcn5frk8SoAekkqeP?=
 =?us-ascii?Q?8U7MpFb/Q827RIibCaEkvgZyNv4sAgS3R0diq1Yl+QqPOAWWCbvcNEE74UK6?=
 =?us-ascii?Q?BJp7jzqMFgEgb4pczEQx3LNuc5rBFZuMk1GwBsob1VeNbEgOB3Dd/f9kFcwe?=
 =?us-ascii?Q?FQNqBMp84ChvMyNyYZ12x+UB7SjCt4HVxYcjGwWAI8r/oFdn0HXmyo2mRoxg?=
 =?us-ascii?Q?1r1WcEfPgAqz9UQpSybdImj/T38xcplAYO/FCubCJdEhtURDVQjeQ37V5DQM?=
 =?us-ascii?Q?OJjdSN55e4qjlyoI8vesngFY5kaN/25gO8dWOgWoycGG1HqzhAa1CD0tdS8X?=
 =?us-ascii?Q?m8oJE2m+BgHKjBSMX1NWPCL6KsrZevlAlo9B+lnHE/BlKJavuQERcdL/rMsL?=
 =?us-ascii?Q?Zz+5/7eN4eoNDCwqxKXjtcI38L7hIBV7qmB3uDsBaMeI55KjJnxTNxaJT9ze?=
 =?us-ascii?Q?2dbVGJEUJLhjDGsRDtp+2gleZ9/Nz3T1EuzGX5oM74d8aUO3dcFwFyDNlPUd?=
 =?us-ascii?Q?Wu29ha06Sx4Bv004TsfuLLc=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16089afc-14c5-44cf-3459-08dd70414fb2
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:46:37.2274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vL/dSKLWZLmO110akUwjhxc13fgPKf8KfjxfuIyhGeGBTOhVQFau/HG3pBTYYXQ+JLt6NYL1vneLQ0MQi1psJzQ2WMxM4sPkf0mRVPoBaTfMjuESougDkRo6ZOq5DCsf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13744
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:46:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18410

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 13dcd63dc704b33a8ad94f1d161c0f5dad243a5b upstream.

Define `RZG2L_SINGLE_PIN` at the top of the file to clarify its use for
dedicated pins for improved readability.

While at it update the comment for `RZG2L_SINGLE_PIN_PACK` macro and place
it just above the macro for clarity.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/r/20240618174831.415583-4-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 2a8223a9e226b..d38df51c7118b 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -63,6 +63,8 @@
 #define PIN_CFG_ELC			BIT(20)
 #define PIN_CFG_IOLH_RZV2H		BIT(21)
=20
+#define RZG2L_SINGLE_PIN		BIT_ULL(63)	/* Dedicated pin */
+
 #define RZG2L_MPXED_COMMON_PIN_FUNCS(group) \
 					(PIN_CFG_IOLH_##group | \
 					 PIN_CFG_PUPD | \
@@ -104,15 +106,13 @@
  */
 #define RZG2L_GPIO_PORT_PACK(n, a, f)	RZG2L_GPIO_PORT_SPARSE_PACK((1ULL <<=
 (n)) - 1, (a), (f))
=20
-/*
- * BIT(63) indicates dedicated pin, p is the register index while
- * referencing to SR/IEN/IOLH/FILxx registers, b is the register bits
- * (b * 8) and f is the pin configuration capabilities supported.
- */
-#define RZG2L_SINGLE_PIN		BIT_ULL(63)
 #define RZG2L_SINGLE_PIN_INDEX_MASK	GENMASK_ULL(62, 56)
 #define RZG2L_SINGLE_PIN_BITS_MASK	GENMASK_ULL(55, 53)
-
+/*
+ * p is the register index while referencing to SR/IEN/IOLH/FILxx
+ * registers, b is the register bits (b * 8) and f is the pin
+ * configuration capabilities supported.
+ */
 #define RZG2L_SINGLE_PIN_PACK(p, b, f)	(RZG2L_SINGLE_PIN | \
 					 FIELD_PREP_CONST(RZG2L_SINGLE_PIN_INDEX_MASK, (p)) | \
 					 FIELD_PREP_CONST(RZG2L_SINGLE_PIN_BITS_MASK, (b)) | \
--=20
2.43.0


