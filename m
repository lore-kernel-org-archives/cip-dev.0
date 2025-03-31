Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871F9C3600B
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:46:41 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.52])
 by mx.groups.io with SMTP id smtpd.web10.49070.1743417993355484910
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:46:33 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=QsOQyYgt;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.52, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eOQN1TCmIGs2Hjj6rtsgym+ACmeEha77wiDEHpPld1JBtWzUSHBYFg2oS8Xsk2hO3Mg9S2OrwdInLbvHw4WTSlgCD0rK83Ur/XEH9i6SjWF7EydsxoMEFmDZxCGDg1zgT8Sw1hzk/L8iQPvxXH66GAm1tqz5RCurp9VkiB2lxSZXx4J9jX2/1ih0J4oUIcEXmH4j5dK3WLKbKwoepZSq/uruVZp+f1V9I4CyrifzxU03oZGdtcC/gomQsR5fIw9rVItrdQmvaz8t5BcfbYesUMIVBMzHvug1wNRHiFUhA98dP2UOjl7lqL2lUc+GslP3GV/U8tm2w+AHY24g1Y7mtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXM3ZXyTTZiExDdWnRfkkVmtsY/h8bQRnz1JX/m1Sxo=;
 b=fK4EMqXFHI+boUcCcrEP7CoLtWesbHHGyNIct45kJeZVTYU+fL8QDXXp+Ho8vjh72r0w9lsVx2i3x9A5+hTD3BTbbjzCHCOb8wJvXGrp/XJrctm7zE4NBORD1xiEJzkOL5a36TrCxWWE7ae9T7OEkhjNSghuD2ZchEAsPQhB6O0eo4yOdTlRkalSMf2aFzrNXyT+ifj2tt+ZrulQJ64FFnctG5ZogwpHVTFuCxjYgBIKxr5Tq/ZcWeozPruwtGC8Vh5YYXSWyxLnRgRcOEdj9eZl9xQ6vETcA/M/RSdiXic/lx/AlTgT9AI/XbWtuWCA2glJkmNL+GB4NkHAnCBmTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXM3ZXyTTZiExDdWnRfkkVmtsY/h8bQRnz1JX/m1Sxo=;
 b=QsOQyYgtpzsJrfBNmUwn/97f7EfJrw8VscfGPwOEGl3nKIsobSuOvbERx8eK/HMjiKX9Ca4dfL4xYldgvqL7226jS8i6QxhO7bqWj6yXCiguJ7uMYRwiCfHXYz2ds/DGmsa4Vp++uZ65e4Yq4hBuFY48swPyZp1rNGEPt9tYu+M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYWPR01MB10032.jpnprd01.prod.outlook.com (2603:1096:400:1e0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.36; Mon, 31 Mar
 2025 10:46:31 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:46:31 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 20/43] pinctrl: renesas: rzg2l: Update PIN_CFG_MASK() macro to be 32-bit wide
Date: Mon, 31 Mar 2025 12:44:51 +0200
Message-ID: <20250331104514.79090-21-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYWPR01MB10032:EE_
X-MS-Office365-Filtering-Correlation-Id: b2b3391b-7149-4d3b-88b3-08dd70414c3c
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?goSavAXwYuKGazMfrf1Gbpbf7dGsv9HtXT+5QuSgPyodsCHIHcdtTwxk0f7m?=
 =?us-ascii?Q?qVO0zqSfyG8/RRE+bY6sreHQs/Oz6Bu8h2FT+7VN/4JpJFPRmAi+SzdJmBf+?=
 =?us-ascii?Q?90Tmf1TtyZidkWA0zdTGcZoCYcYwXrPES5ssCQXuwW83D64k9lpm1zzlPurM?=
 =?us-ascii?Q?b3q/+qmyKsZ88mogNHFZmfp/tplAuoOMErXLu2+rkl4ty08EFIXv5B4tRPIH?=
 =?us-ascii?Q?N6j2QBevzDov0XXyDN7bKZJkTqeYrhWA1zvkIsMOA6nSEA6qIbHGh7yo17f9?=
 =?us-ascii?Q?o0Nx/YRToWvtex8xkhyqhLhvhpbdTh93C/rbbiRpVHv96BQ3aWUiBU4mNcl/?=
 =?us-ascii?Q?qU3XAA3K/xeOWyCglN9L8Z/PvQPn1LUOHN3HUn9D9L4CktijJvFpTkm4r9uo?=
 =?us-ascii?Q?dHD45tGWA2q4DKn7DRhg5YxCQtJzXJuZ3rVlBMLLAUz/ORcs1zmuE7WxWkh8?=
 =?us-ascii?Q?HYzhJcliOqqjDubMQdS+1mJS9drW4Zl7mDJCNJiAyKpscYnjm+SC7r2B05MO?=
 =?us-ascii?Q?UvIm0EEHhWE9UnBt8kfwz+PyuJGHUH4OkEBvTY37Y38IRgm8a9+l5ARLz6zE?=
 =?us-ascii?Q?BYcHGSX22VC05WI9a1dlB5RMiacewGGU16hRi8GA1Aaq+q3S04aScsPxYsEb?=
 =?us-ascii?Q?E7kAFP6SA7/iPRuAALtuzoVBbM141eX5DDrI1T70wxDp1+ykLnqV4Wtofi1B?=
 =?us-ascii?Q?SNk/Do1tunDwYDU45fosd+qqWowi7udE6cp+h4VSNKPl0lSywjIfbXjahrIe?=
 =?us-ascii?Q?HA93cwC/ua6D/h1k9ZJwbGt66+cI5QNy9KCrzZRGRAz3M+OH0tERMADvCSZ0?=
 =?us-ascii?Q?75qvDQDxbc0qC/q1QHunbQDhnTj4YB4WQl1cVkO3EFE8XHnl1AZQOn2qB8dM?=
 =?us-ascii?Q?WuAtcCHFvESiW2+1YdvPxd9moPGrt68FdKJAeKXneR1Qjq2n+ZkYRXdEBCO4?=
 =?us-ascii?Q?75C4HmOJp42NHrVLeXrBkvcXSmfr+HXwSqSz5GjNRw+KHP+zZTdhTv8OxGR8?=
 =?us-ascii?Q?REZIYMXQ3yiwRGFt1EsC2q532zlBPV6A8wIjp/GW1xEe1tWqVUVaJtWpoTi3?=
 =?us-ascii?Q?rGgu6jKMisiZ0IhaS30QeQUPrO7NtXFjzV3mt7AqZ9+I45u7BCPY1ZDM/DWp?=
 =?us-ascii?Q?lmYifTXNmxOJJjLHhKuL4ab8iMEfK2C0uzApjQhOU8qJol4k/KJEv4TPXwt7?=
 =?us-ascii?Q?FeD2qv9+9RsPvKTLoOUF2mXh1CdBMGnapFvtUz5t4McGkep2l66MXhkGNmeH?=
 =?us-ascii?Q?Fi7xbOmTdid9yrbvIDnEtyM94NatnzNlVfm1uTlkBCfD0nqyNZ53kxF6ie8U?=
 =?us-ascii?Q?iJrLn5m1bh0hWYJKH/1uPl2d/p+VUHacg600biN8TvEwmxzOYu39O9u+gR0d?=
 =?us-ascii?Q?LNFoIwpdJmJJ5iA+yIiqBI8ZyJqWsu7oMPv73KpgacUwblGxhQfZGPcAra4k?=
 =?us-ascii?Q?0c9QqKcrq5iunBaG1A10JtTQEmFhXxoGHGT2m0ybIKBXluIJQxlFBH/zYD9e?=
 =?us-ascii?Q?V7JiDTjnv9a+jE0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?AVy142WMMhW2zNtdeK99U9IKacdgDyIi6WUvn7HScs2veHkYaFSGWr8x6RgI?=
 =?us-ascii?Q?h/YQSqehlEclTrJFq3Lt18yy5AB+DPimisAbbv1xjhU2L1D4O5g3Jg7RRyVv?=
 =?us-ascii?Q?Y7B0WVFGZ+1dpGWiCmg3tFOKKmsswMHBU7JCJjjl8fFhcpR2RXtj+7UcU5bF?=
 =?us-ascii?Q?pNjntNd9s/nSGq1Lar9K57Q9MOjFlm1LuqEn703+5OBkgXSUbOkwVfc4lU/M?=
 =?us-ascii?Q?rCNm+QYvcx21Dhdvs44dyfgqmuriGMgC/xhPpa9czbI1OrNpi2yv5+/Xrx48?=
 =?us-ascii?Q?kKQRPVNbIrmc5EhdJdDJ1HHmHstk4RKHhA6xSb1Q/XBCPGZi+JfNqWEjGuSe?=
 =?us-ascii?Q?Vd9TLGD6qubcMcUqj8vgTLkxSV6aYi/qTjpZ8bwfadTv9K3mN2oEBJCRwR2L?=
 =?us-ascii?Q?7u/Fqf4Adzss66uexKdd0I7DKWLz40QoW5YqmiOF5nctLlO+SnNjYuey+zCH?=
 =?us-ascii?Q?H5FH4NQzMls3pJzFUZLzNlhHk5mDu/3NM/IlOa0imlN6YlUG/Pe9UKHc04t2?=
 =?us-ascii?Q?kUiCw2s+uGr3jDW745HgUfo05FzTHMi1JFWJzGYxxmjBYrcZBv84mrztg1nr?=
 =?us-ascii?Q?0RwVifsz73QdU8AL/1/V2sJnl3dadr/W9rrBhbnZkyJO3F3bww1Ov9FsbaPJ?=
 =?us-ascii?Q?gbad2opiI++MYzL5w/+wv1PI2MXEygfNL3vdi5qfbfiDKFVvNQYDmB8msOV/?=
 =?us-ascii?Q?6H2YSDh7+msYxYbOeh8FVWFuYfBOqlkldFf1BYm9jLpmDUmFqKpYUV4+PTJa?=
 =?us-ascii?Q?is9aT0uEQEdtk0FYU8G5FWq4g7JAkC00qpQeyd2LyhFbiCnETix8zu/14jcp?=
 =?us-ascii?Q?zl9K0Hs39NWFS8+oP6DC7UnyNQZhACZwfJRhf2TNopRxWHYflluIwZ1PKFNe?=
 =?us-ascii?Q?N9yxuV2P6PorAEVzLzkhA0eriEsrUyGXVrea6pjVPVMRKi/sswcRxfHbBKCF?=
 =?us-ascii?Q?TehtMXgC6tWScF9tCt8cT4ZZHajtz08vBrTIpLy9mrid5USE1CZhpZG/O3b2?=
 =?us-ascii?Q?TQkoJlYRvjFcnufXJmEuByxcEy/Bh5CdkmYLmpGLY9/pGV6lnU0HSozIKOI7?=
 =?us-ascii?Q?jxjFI4+Gd4+8T1QVmjIHYv5ZzkQ1ADSZjGAu530kZ559GkJzRFwmkl6yf5QC?=
 =?us-ascii?Q?g69k9RW31XymOXm81dukLY+IlMnG2H381i3EKZ0K1oRtw0bjB5bSDBISkxbi?=
 =?us-ascii?Q?ho9ma821w5hAl83pSuXKZGWsU7ggG25brbP6UNyygKsL/vXnugZti9Q4shsh?=
 =?us-ascii?Q?NdJFrVg31OHjpgZ4cSU1vQApQQHNgwAvUMPpLlatpIg9D0mN/4U9wC6Eper3?=
 =?us-ascii?Q?X0kr84iCHrEUpA3xGJi0yHNoh0Pbc16uyMx3lg/6JneGmsUliGeKio49PLwg?=
 =?us-ascii?Q?MARqRS2cXUzI1+YumRXG4U9dFX5dW6f+cRvib3AZMazjSuSKyVgb1NihPkXS?=
 =?us-ascii?Q?vdw4TEG3mU+4XcI6DWPiWJQETOuQig401YewqFhzsoxr0ytQLk/+mPSlDIH3?=
 =?us-ascii?Q?FItNui8AB4Uwf4F03ykoktquwZWvVfDWFHgJ1mq7gAQvvFi7NEZyv4bsH7fY?=
 =?us-ascii?Q?MG2T9v4aeYiyWP5Qu4fyLs2sUxLCJXPmaxfbOATJh4lAZrWqCKm5A7e8RgG4?=
 =?us-ascii?Q?6E1szsABOm3Fucfh00yZyLI=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b3391b-7149-4d3b-88b3-08dd70414c3c
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:46:31.4423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aidhrVUziVsgI7uYbHKykwpWUY3Huwng79ynS9fsRyyGaZ/8Say6GgaJOMpUVbtY4ATMLp3eth2TfDZNmPg0x9PjtXfaRgJ4yg4mmYJL6H/OZVA6UmMslwQcufVcZ9lE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10032
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:46:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18408

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 0a5e40f9c29756dec3da573edce3f4b3194e6f91 upstream.

Modify the `PIN_CFG_MASK()` macro to be 32-bit wide. The current maximum
value for `PIN_CFG_*` is `BIT(21)`, which fits within a 32-bit mask.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/r/20240618174831.415583-2-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 8c29c8d3c5743..b4ad4a4d20463 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -88,7 +88,7 @@
=20
 #define PIN_CFG_PIN_MAP_MASK		GENMASK_ULL(62, 55)
 #define PIN_CFG_PIN_REG_MASK		GENMASK_ULL(54, 47)
-#define PIN_CFG_MASK			GENMASK_ULL(46, 0)
+#define PIN_CFG_MASK			GENMASK_ULL(31, 0)
=20
 /*
  * m indicates the bitmap of supported pins, a is the register index
@@ -1187,7 +1187,7 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_d=
ev *pctldev,
 	u64 *pin_data =3D pin->drv_data;
 	unsigned int arg =3D 0;
 	u32 off;
-	u64 cfg;
+	u32 cfg;
 	int ret;
 	u8 bit;
=20
@@ -1322,7 +1322,7 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_d=
ev *pctldev,
 	u64 *pin_data =3D pin->drv_data;
 	unsigned int i, arg, index;
 	u32 off, param;
-	u64 cfg;
+	u32 cfg;
 	int ret;
 	u8 bit;
=20
@@ -2755,9 +2755,9 @@ static void rzg2l_pinctrl_pm_setup_regs(struct rzg2l_=
pinctrl *pctrl, bool suspen
=20
 	for (u32 port =3D 0; port < nports; port++) {
 		bool has_iolh, has_ien;
-		u64 cfg, caps;
+		u32 off, caps;
 		u8 pincnt;
-		u32 off;
+		u64 cfg;
=20
 		cfg =3D pctrl->data->port_pin_configs[port];
 		off =3D RZG2L_PIN_CFG_TO_PORT_OFFSET(cfg);
@@ -2801,7 +2801,7 @@ static void rzg2l_pinctrl_pm_setup_regs(struct rzg2l_=
pinctrl *pctrl, bool suspen
 static void rzg2l_pinctrl_pm_setup_dedicated_regs(struct rzg2l_pinctrl *pc=
trl, bool suspend)
 {
 	struct rzg2l_pinctrl_reg_cache *cache =3D pctrl->dedicated_cache;
-	u64 caps;
+	u32 caps;
 	u32 i;
=20
 	/*
--=20
2.43.0


