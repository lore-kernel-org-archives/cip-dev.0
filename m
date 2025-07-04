Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D25C83F03
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 09:08:46 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.38])
 by mx.groups.io with SMTP id smtpd.web10.8437.1751620116115710426
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Jul 2025 02:08:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=lIoogg/R;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.38, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QR2Ja+STtRExLmWYem/Ddw2lA3ViIZn4O21pDxOxSBTwADc6GIrx7I25EItMSl020xRS+nNcpnEnYPkJ5oX+LUQZxrjGuwtEgtdGpz29QwkCQtHK3sXw89M9oUAXlcvkgeb7LK6abTgO3XdnaoXDhlrca8YC6qHK4aZCfEtZRYbT8vaalSFJ7ysI9IGE3Z1pH696kbGF9Ql47yaBxL7Xq8d+DwfB8uGLn3uXyYzlNIjaVqxn24+di1klnq7l0ZP0BXpqkHkviThmiw/WCklw3SJ0CMsXRADgV88u+qswSu0K9MBRlpqNVq9mOcqDKUaaEQmyqwPOD38Wq7fvgzB67A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYx8cvWpCBnVr5dTI7qJPMZzgrZjRJWqZY6gDFjvbKc=;
 b=HaqdVkBMgKo+81G0pL4L19oDAv3qTkvb3I84koHLsrmz7XRBnB3tgvf0g7QRL85DokJV3yQT8ChIqQnu/x9J3s8W82HxlxSRqkdgwZMqpZ2fPrCwPMK0C8mrS+Eok8Svd41v774zz6oLABXR6nTkvaP+GBTJUQyJxzbkdHVI/YcczBzYSSk/y5s9kD0bRVd6eyOCQsmu1Z3Fl6JoMPgkz6Du5LQ8AVlLfWCFfIGaJxGO5lF/nlSe+HV8a0iWN1E9LXoorlmijXF8xWqT390sxBrrC2ZWEjT0tzfBdE7V2pvrOZksyWm7+9aR0IRXpmqWjO68xfE7IYviOOqzL4pQ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYx8cvWpCBnVr5dTI7qJPMZzgrZjRJWqZY6gDFjvbKc=;
 b=lIoogg/RsPiQD6Nvmd2qdfPbExVLjaacib6vWUwfjzd5JE7V2Jp4aoruqtpphxPznmWJNi6huPsUBWnom68RMXE1UYwmNccTr71q6SBXbSzr4UgPzb1F+3U2qSz6XMmUksKXMgPEDVleJwdgs7og9/oSn1KnN+Px/f61wXeaX+k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY4PR01MB14451.jpnprd01.prod.outlook.com (2603:1096:405:23b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Fri, 4 Jul
 2025 09:08:33 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Fri, 4 Jul 2025
 09:08:33 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 16/18] irqchip/renesas-rzv2h: Add RZ/G3E support
Date: Fri,  4 Jul 2025 11:07:22 +0200
Message-ID: <20250704090724.669848-17-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704090724.669848-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250704090724.669848-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY4PR01MB14451:EE_
X-MS-Office365-Filtering-Correlation-Id: f967661b-95f0-444c-0114-08ddbada5a08
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?laV/11hoCo2orrxqQ7Y9WAp07nZwNY4//xkGlW1CVkUnVW19ykoHaxQohsIK?=
 =?us-ascii?Q?jsyTuZRf+c/MUH+3liU/0s6zvTEUi3gtgR5el0795RdlEKiEaa93WpYt7Yp3?=
 =?us-ascii?Q?JR/jFyVCjDb6H2uV5Tml45fkZDeMFcp4XJ0fl6XwyY5TuhHD6zYemkWUzpVH?=
 =?us-ascii?Q?XLZ6c+MDL6VPwu+NM/u/LfkBUTjkicJ0g0p4Ax9eeHq8K8nAA5r6E4S6PgyB?=
 =?us-ascii?Q?Imq1xQCjWF3AQMi/eJW+WZJ+XFwsMj7HzQ93Kh8ABdbqgNey+ysmv3da7OcY?=
 =?us-ascii?Q?LqQIk/vaPkeoyGnF+kzxHk9qpktHFTmk5ShonlszBbK56U0Fvr1NSqq4cPAE?=
 =?us-ascii?Q?1K2a9mGGD8UFMsTOx9pUUWXJn1JZkQAB0SyQr3zJOYJmP1SHh97pQAegefxt?=
 =?us-ascii?Q?Vx2c5h08gHYu4sk6CAACAfjc9DVm9kOXqYthxtPvWiocyMk3W1bV5Y6XjLgk?=
 =?us-ascii?Q?MlKDCaCp4IOfqjpuL508yUlHjndr2HhZ48e826J9NgEhazQeJK1TarKmoeGY?=
 =?us-ascii?Q?aHb2Ip//OxqWsccU4ONd+ogmb2yZWQKM7l+nXJRELADxOFMeCOir9bngtEPO?=
 =?us-ascii?Q?4Pd5VMtqH7oFY9aE3g4nt8OZe6tDkZeEQAxIfYRxXTCGk/Xv19rUgG3Fd2lO?=
 =?us-ascii?Q?VogWt/dorKORIhzUb2e9XZQAqxoLxnvzkjCkt8tVPDuj8OyZcb5DNhQJHGtf?=
 =?us-ascii?Q?VrQfZg5uoyu2TJImHgP+AFe8kTVYWnUn4O867xyONNClmed666uXJETbSuHp?=
 =?us-ascii?Q?wa5MZkR7HbLC4hUN/pU7wuB011iGR05MJG/4WWWX4ORD7PzCeuop006Jb+vc?=
 =?us-ascii?Q?aSFsIfkJKKgmYfI9jC8RObXXGlFUOjH5RyOTOkic4ygyOPs6watZ1ibaoGR+?=
 =?us-ascii?Q?s9ISAPZmq/CG+wuTnM/pnZ0JxAwBk/alpl46VvbHxZRwc5TG+RyNt3I0KnTz?=
 =?us-ascii?Q?3HspDxm/DgAz+bt/X58gKfPQcT3EXEdR7npPyQeCPqQTAIyc2rCAmp6UV7yu?=
 =?us-ascii?Q?ekeDs1TKf3c9E3L+BDjQzKavckjQbFu7DR+dNguINmY5UoQLbPc956wiMWK6?=
 =?us-ascii?Q?fDOPwscYEpy+E1+0wx3zBTpZEvhcFVlcqHF4mCB7/Uc73kWTjxd0nrYVhRrT?=
 =?us-ascii?Q?YD+b4lXvhQskcrgDeWCrCShfAvYh0XQw8vUzg2sL0sRnaseW/klI7dLCdkwO?=
 =?us-ascii?Q?XfFLZVSijzfybaFEuLTDSILTQjv9k55v3Pk99q552NkcoiTKVGzp0Yqk/W02?=
 =?us-ascii?Q?SL0qXn/V6UWg5FJvSSO41iFTzQ3EBt9JTwLKiyYImr2R4V/VWO1OnYm/pyUd?=
 =?us-ascii?Q?FEHN6i2tM7CaQd928mGQoB7gpnM6DeyBlZ2MwFsBQMRd0e6pRdH8CMnnIab0?=
 =?us-ascii?Q?0KfXwHfSfuJbpRJgYsknbosceyhvHPEt7jZlB335ZKLeK4Ojjs2JLmHQuFRH?=
 =?us-ascii?Q?c5cAtDiRg3lsPyuVQjB37cz+dpqx0XFWsLP+fKSQdtFvlR9pnCQtjOSzrvrt?=
 =?us-ascii?Q?OUtqigIe0hQOSf0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WeRogAgLeKgxnlRSxKFG98/riowKMUXvpZh4t1N+4c67dQkdUNI99Temcvhb?=
 =?us-ascii?Q?JMD9FcndWhjybklnDafdqK6cjZu+D9mjHyaEUKcuJMyaI+KYASormZSbLkVy?=
 =?us-ascii?Q?/uRLa5oD11AaJiqFKaZErhqsYPNwuw3nLvETqrc5QwXyFDpuniffGYxSc3zJ?=
 =?us-ascii?Q?gOSzIpAVcTLuCXzhDaL7BO1L2BKyfl4SZT0p39AwaDbgY/OUE4AlhDSTV8We?=
 =?us-ascii?Q?NyzMjFreMEithmE0cbMsU3qPyqWAHbgGwFISmVnVRA7s+9RqWXdolvpFCMdA?=
 =?us-ascii?Q?m0+f9I25q7dLjl8q/RYutUeZahD5kZ2aNgvUuxcA6hMw0SZhGzld/IgLfmvE?=
 =?us-ascii?Q?7Kmnyly4hLAJuopu1/SVnhhemOiy5rXaSLIRu3m22rZ02EvFnzoOaWyLlcQ+?=
 =?us-ascii?Q?Y4tj8k/gPc9pERB+hgWDDAiYxyvdF15ULApNu/I7X2oS/t9effa6fOL0s9am?=
 =?us-ascii?Q?q8JrHtDIVCsipQFsngva5qOMgRdPWEE0wQ83QmovvrPoxYK5gfej2NQfPPIs?=
 =?us-ascii?Q?bBELPPZGFSbth4dtxP6cJ4qXoSFfXE5/RJsnl3jgIb7jEounu9In9wtnT9op?=
 =?us-ascii?Q?3xYJOY3UfvR9cySJtX805vS62EqXzum9I/9qYhe4ea/fzOcUmPRPHOXXaZdV?=
 =?us-ascii?Q?k5UUN32WEbiBGfoOLxvyjSOXLS+CMfMGqN7TMKINQg6r2ys8yyWQCFt4aOZ+?=
 =?us-ascii?Q?T0TDFUBB9ks9zGXfLPR7Klsjd7ak53dFA6rMVTOUX8NvvR/ETGV2jhMbjmuZ?=
 =?us-ascii?Q?QPibaqCc9YnmmllTiqmB/EGgqpi+5hBXMmxgaycOEB5hVe49VGrDv4TJj8aC?=
 =?us-ascii?Q?mFOdcgg3AdyMXufO/xVLzEd5dVTgiNkx7Wg+z5IfTEFeoLYba+256zcSEqzA?=
 =?us-ascii?Q?Gvt4ALHkDuqcVR/gER+ErKEDUK+vt/Kbj8y2SxBBk1RvahgROGDTpbfp3age?=
 =?us-ascii?Q?mmcKZXOBFvl6OXxUKGP+RpN9KioyL2W4pAR7wKLdBXqNS6PYBK8HmzdTcz5S?=
 =?us-ascii?Q?hnDiGCYfviNft5jKiT2aMmdcLNF1JPbcpQp65i7gGR3+OJpCnTRktPpQbGFi?=
 =?us-ascii?Q?pBvfiG5rra7/y2hvlJZ8xD+ignfCMuIuOFOW79IN/mmSE1hZNtxTPE1Oittd?=
 =?us-ascii?Q?Vym8khRG7UjUgK/9dC37XLEOc3heEZwBoFNpk8D3bwCpm7vfRu4i6Ew+AlS0?=
 =?us-ascii?Q?YYOxTWl+FnCxhfUyQzxUw3yB1g/AZ39y1FnhW2KTQ9+qvrx4uHwO7GdLe2px?=
 =?us-ascii?Q?tM/kI6jPRy1Qqa7ipYOPhrxK0ez5rIQlNfMRtdoy+gFBOkjOGMnQjRKkyKy9?=
 =?us-ascii?Q?WGKHkTpLJLHQvklMufvH137/VMu3TDaNWxdSqVUAjaGuETllBDocps6NXCPu?=
 =?us-ascii?Q?rRIHifO6kIA5bRJVrQiLeDYZ1zKY9iqgS8UwGOl1FLXak02zNUCJceaYrT7T?=
 =?us-ascii?Q?jiDUR6MvsBDBJI0kKAmsJWwxSYX5RmNZAwRyBEtV0ijsOtfOoLgTMmkDj0Xs?=
 =?us-ascii?Q?xJtj88schrSniDEDGz9WltFxaFZ1KXz1kNiN5HzrFDLC90uGFrqkiqrQelAZ?=
 =?us-ascii?Q?rxQV4neYPE7D/xJh7wIt9ySQVhbmiF/GlSQ6gsCKuz8ivrrh/K3nd0nnx6R8?=
 =?us-ascii?Q?ve4sB6hxAUyN9UYKlCWufT4=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f967661b-95f0-444c-0114-08ddbada5a08
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 09:08:33.5409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lw3Baa1bVwZIt97gDBbgHb5Nu+KTKvqS6jAHv6oLzhSObZtiwWJsm7pj+lZH2lud5BhuwmeXZWnYJbYVLKxZ2RQt0e7Gkr3gt7mzxOj5uOy7Q0X1ln2+aD5oRakfYKY/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14451
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Jul 2025 09:08:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19360

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
index 7bc4397ec149..3d5b5fdf9bde 100644
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
@@ -529,18 +536,57 @@ static int rzv2h_icu_init_common(struct device_node *=
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


