Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE93C35FF5
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:05 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.37])
 by mx.groups.io with SMTP id smtpd.web10.34455.1741778715273841073
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:25:15 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=vz29gxCO;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.37, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f42mXRvdx3vjzbv/ITtykWltSBRgY53HHJ6q7TWQ7FqGFfZgeAncyuQ8XvWYi8lINe8mp2sDcACKdslFS166R8z+z4/R7EXX/qDKFmR62YaHwZzX+ZJ3DX6JbJoSrXJJMYbO5tEoLkBhQkOKsz5i+NO9MPPLpKztAFUMtksIpZeocEVb5zWB5MJ2RVjAt4EtFZuByZbYOsDF9GjYUNbeY5eQ6YN73/lRyjqDjOdiX8XUylQRv553hUmXkoCliOqcXnWaSruDxhQA9RgSdMGGEKg3Ov5vSY/KQpmilbuCEWxfyBdh1NANS6MZtaMAVF2Ox4H4ddot7SCBbKTWmEhmCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MiCZA2Ux3katc76eCJqrsPJJmOBMKz63GYcPJqAq1tk=;
 b=U+FN2qqa2xFQ97Mymkf8iqSgDetU7IVY5p683kf+il9BDE+/iOf0Vof3/w1AzG0+mMvXvp/uQuBC+KcHgDq1ML+7DE7cQd+4q61xJ50OuFhrGQsMjbeQCcVG5r1Jp7GebnL1O43MPYxizDFBs5C2ri54JUJwRTaHI0Psy6PWFcnDpGxyZ8HXPxU8tXdwM1xFWZqMh8zfW0ws/8PIyiStmMOVkmUr+OawSvoZzdiLmSTsS4mpgNwBZeK+nzh5QozFyBa7G7vRR8MvtbNHU9YI6pLmdIURkwNyxPMFls1CT4+UD15zdRHnuTI0MpVGkwWoAzIANMosBObYKLN8TlF/SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiCZA2Ux3katc76eCJqrsPJJmOBMKz63GYcPJqAq1tk=;
 b=vz29gxCOnFWcJHPiDJmPOYu+PMZ5qttZcVSTZXm3RK85uiq175WDml5Jj9Uoi6hrrJXpruMzhCZCT+348OumZf6TOINB/IcyZz2IzhTNy+xiHDiUsQvous+L/GNdtMTc0lqEgo3KfrrO6rWjcwNaeKZoPeYHIknmjSco63ZUfes=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB12752.jpnprd01.prod.outlook.com (2603:1096:604:33e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 11:25:13 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:25:13 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 33/85] pinctrl: renesas: rzg2l: Add function pointer for PFC register locking
Date: Wed, 12 Mar 2025 12:22:10 +0100
Message-ID: <20250312112302.1605750-34-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB12752:EE_
X-MS-Office365-Filtering-Correlation-Id: 36e3bbcb-0990-4739-3855-08dd61588e73
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?oRe0dvlhLYLvVCK7r3+OLa02+odtgFg+qQCzgCIufCIKwCtzLkxsPRHRyWUJ?=
 =?us-ascii?Q?R9wMLWNMTKUSVfEsR3KAzKZ+dteBcVwrn98hCne1Zy+3tT+/MhYNGIZucgpC?=
 =?us-ascii?Q?0VH8oPN7TLAniwgoy1tre7sgnqiy35wcwsz5kivS2t12PnfEndTmrhNVC86m?=
 =?us-ascii?Q?EJpw73Neg33++j3MNDR+zSkHW/0NzWMolyw2811Oeu1rDfGS2Vpb7P0tXCHp?=
 =?us-ascii?Q?kmVcy4xItCOEq4RA2gFBRuT6OHBXRiIVw69zYqHmeJlSJtxBTgg5dYkLcoZU?=
 =?us-ascii?Q?nACrj7iCwUTjv2fLBefrntNnJeGrZgoeZMdV7SuzkU1xRYrFkv2nXruI/Ii0?=
 =?us-ascii?Q?oZvHqtmwBjiDidh812rjHi1oZ8ZxY5poiPMhwn6ldfLi6jGNUhlks/k8kUzm?=
 =?us-ascii?Q?euXFU6ra+fBiiK9Vmg2ucJ5ZdSL+wnx8Lqi6wHPxsoH2sh54/NDqVXk8SAjW?=
 =?us-ascii?Q?/EUV5OjmfKiX5HEjcjeTv6iqsA4s9fq2b2LFPgU5LJgUS3KcF9cgAtM8eNmO?=
 =?us-ascii?Q?f7zZLPOEp9im3Gg4rnDnsMLvMkztVbGVF3ZC/fkuUyf2Dszqg7YF3ElSMDRR?=
 =?us-ascii?Q?qaklcGf4JnSC4rWeVpL7VeRYvdcYbDePdKbA93gkrpJJ+yaXtsRMu1nfuI/+?=
 =?us-ascii?Q?z1mWVKtLK4EXpaz4qPdiVflyT+tyyqyk0J+IA8MxOdcuAtQ1hyYIpJe2k93e?=
 =?us-ascii?Q?oWykbjehiQw1Fjoo7A74ElfYNZPekGGEB7GKscMQlzx6BssMTY0JrKo+x06q?=
 =?us-ascii?Q?l45JTKCufXRlcN7QdIXsV0kujWdggjlWJKQ7b4TZ6WVOX0XcgfT95K0ErNh/?=
 =?us-ascii?Q?iBBnF886otd+z+DVst2Mc9bXFhN9hoh3ZJNkG9ot6wDGHUnzWdwZ2wxWRLuf?=
 =?us-ascii?Q?WSphAw5T3aGaX5m1zH4YobUsfoz7A1Xiy2w7hwHLJxu1Nvit29Y5MEXJ5Ks0?=
 =?us-ascii?Q?OJcmSiGAzHX8nVSq6HxzH99tqUdZEcVvcS82mK3MWdgjoc/H7Xh8cNrXikK8?=
 =?us-ascii?Q?RThHgGLCAJ3eVO25sOJiXNXxxgPZhVVYoppnnU2wMkElAj4phuFpzjEGHaOi?=
 =?us-ascii?Q?y4C8LFSZ/d8ana7uxSMnKkpyPBdrOe7p9Wt//Q0X2gwyfIpFc4yqBE16e6UZ?=
 =?us-ascii?Q?d9d9yJe3uTaappDVRXNgi13dQJdC241qqgeutk2O7629XU5gwqCg9hI9sflH?=
 =?us-ascii?Q?wD9anj3SbXoppzqbX5N3Zi90WSz2oiC66/x+TQqmFqab7MKDyMWIC++//3Ui?=
 =?us-ascii?Q?ZLNR0gBHE6ADh14T7jkXApM3GWCy81rCdNvxHqOg5k9EuoxGHKNsCWZxn4qO?=
 =?us-ascii?Q?5i/fUvCr28nHUw9wK6f7vWL8Ueb357SaxMCXWfb+EWX+eWgmT/GUyvCrRjLn?=
 =?us-ascii?Q?nlWhRYom/rbK5FTQiPO7vylg+uR0HHQv9hBFH49KzRoNMZNOCh8ALS9rDrQu?=
 =?us-ascii?Q?VYZl5goSDhH7fk1Efz1ma+gUhLxVl46Z?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?VTEnpGcb5+07cH16QIBORVWsaa8CLhdt2rQIoAr+UOiI0k5a1FXU69NbR07p?=
 =?us-ascii?Q?EPfHL6Vzt2q0cv62GhF27vyLtN5DnzEO573CsVkGnVkFAu96OjQGOhK1UWcO?=
 =?us-ascii?Q?gZX2KNp9+vIAB23yFASXMOnKMbde3RDm6Uz0x7Ap/B1KqSM/ddpJPFGa2Tdx?=
 =?us-ascii?Q?ti85/J/Krk0fZJs+H+qwMNWXGE7z/fy4zyhlQyB8ltQTx6CLcsNht/V/TDsS?=
 =?us-ascii?Q?/Xqrl9MC2Pl+XSw1ZpRh/JOlQYwr3K1FbaZVZYBAJHVT5yZSmcFv3Ef7NFse?=
 =?us-ascii?Q?VFA0u8GbuHRDhvDTAIfhvHNh2RJrJdQDBqkqqaNBogYzn/OyesiN+RDrgSHi?=
 =?us-ascii?Q?V3WbCKk3kUdZuX1P0tqubnL4HmXuhsy6DCDXGstOwCSd1xxh2tgnL2GHSh0q?=
 =?us-ascii?Q?7X8sGKgVj+52jtzBoN7MPMBWeg2+6Uq0jy5l4KuNVp2vUYMd2scCLLbmXTpa?=
 =?us-ascii?Q?03IudRlXAB2XEJALd7EOFq9n327T38bTJVtzD/2d6kh0ayjGWKuwwD88NBy/?=
 =?us-ascii?Q?qu9HHnydbHK9s3/eGaT1R/7b8/iGFpUfYZaDEMsPkX7ghLcA5O3h1ymb5zYz?=
 =?us-ascii?Q?sxAsL7wtMgsnwaBSx5HQIGRW74y9NsNaWuj5ZaUYo0gy5s67tYFnWpYGglfl?=
 =?us-ascii?Q?gaes/0paVV0moL5COGtPMbhzf4KXxjZ/x5O4Lw2NDnI8+lHMfnXeYXlJ2sDJ?=
 =?us-ascii?Q?98k5lXAviTozQxKmDS0QpEZkQG+CXCgSJjrlpl8xIyyggB2KBDSQeyiM4cvX?=
 =?us-ascii?Q?Vi15eYmapz7oDef09w995DIdFoSO7d8E+ddN6ewX3jBXsRJ8paEsQRDjml8M?=
 =?us-ascii?Q?vRmSXhVpzEXfxuC5Vwoggm3y3zR8ARpmzR3f8HNLhcqGlGa8/xN6Czrp4dr5?=
 =?us-ascii?Q?c6wfz9882g4ZQBrYiUkN388pPwsRuY2l5khqHiSY0gPZDtRBAgHgjPPH8mIi?=
 =?us-ascii?Q?s+Y3eCbefaEy+SYhqtDionQrjQaj18bW4REd1if1A7pkj0ki5n0OWQYKMzpL?=
 =?us-ascii?Q?w6Hu7q3pRc0aFqkkEH9k3pObvmc8Zo0iBBPccA0eMp+oB1jXEQAYv7Xlmm3j?=
 =?us-ascii?Q?K5Oi9GFUNNfgZV2Q5222yqgEV9nAKsnWCb9xHOC5O4tGJociwlTd+qgB/XYs?=
 =?us-ascii?Q?PXQQ+Fto9pqzaQoY4i6lzA5XuQmxS0N53nD3lOZ8DIdsBD3+WU0oNyIdOp1y?=
 =?us-ascii?Q?xL2w8BLXs2bYvksN8jnxWKS0s9LSXxjqYaXymbaCzes2vhCOVQ1fbYuDt6Yz?=
 =?us-ascii?Q?KMLykEDz7/pq0qeRdigUs231Ouoq8p6XlMgsQvwZ+GZ9whspjxjY0nBuMP8B?=
 =?us-ascii?Q?6gw/PcyT81tTu9OfXMpC3HJppdm7qq8KKtTLBCPrWJy1Z/D8ShobkWce4SCZ?=
 =?us-ascii?Q?Qosqe+ZFMOFwp6w+d9IjUwwHgQWOLycuu4z8FRbj7uI8a+aKf462N17VlvOA?=
 =?us-ascii?Q?EhlKY7LAkop2C1pthRNdvwWmZbkqvllMB/MPJxlhWnm+8pmf4u2W8z0OjgEf?=
 =?us-ascii?Q?9RgdPV6M9SJHaDWz7SOvzZGc7k3Oq3wmDXQX9STMgGVd40cfz4lDMFjADRH2?=
 =?us-ascii?Q?hozULCEM+R2MvWIfMxCaZnCxCoJX+r2BRlAv8yhp7KvMUBpM+moypuN3WidX?=
 =?us-ascii?Q?gmI88Lt8PpnUtsEUmXPFEvo=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e3bbcb-0990-4739-3855-08dd61588e73
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:25:13.4876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c4s9zEqYqMZegGcmY/f35w1Q/ijYDw92x8OXkj4ZG9Jq5K7lCt6fXZLS/4nMoPUsLLOMgOcTc9o4P8TNxPqvKeZoAoKvJbcMAKRTQBV1bLRl/ba9Jglzs1h9WvCC1kg0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12752
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18125

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 14c32dc1f63d0de865e67c04c919ae036de20f87 upstream.

On the RZ/G2L SoC, the PFCWE bit controls writing to PFC registers.
However, on the RZ/V2H(P) SoC, the PFCWE (REGWE_A on RZ/V2H) bit controls
writing to both PFC and PMC registers.  Additionally, BIT(7) B0WI is
undocumented for the PWPR register on RZ/V2H(P) SoC.  To accommodate these
differences across SoC variants, introduce the pwpr_pfc_lock_unlock()
function pointer.

Note, in rzg2l_pinctrl_set_pfc_mode() the pwpr_pfc_lock_unlock(.., false)
is now called before PMC read/write and pwpr_pfc_lock_unlock(.., true) is
now called after PMC read/write this is to keep changes minimal for
RZ/V2H(P) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S
Link: https://lore.kernel.org/r/20240530173857.164073-8-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 44 +++++++++++++++----------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index b6b53757d803..95b51f31c387 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -240,6 +240,8 @@ struct rzg2l_dedicated_configs {
 	u64 config;
 };
=20
+struct rzg2l_pinctrl;
+
 struct rzg2l_pinctrl_data {
 	const char * const *port_pins;
 	const u64 *port_pin_configs;
@@ -250,6 +252,7 @@ struct rzg2l_pinctrl_data {
 	const struct rzg2l_hwcfg *hwcfg;
 	const u64 *variable_pin_cfg;
 	unsigned int n_variable_pin_cfg;
+	void (*pwpr_pfc_lock_unlock)(struct rzg2l_pinctrl *pctrl, bool lock);
 };
=20
 /**
@@ -382,7 +385,6 @@ static const u64 r9a07g043f_variable_pin_cfg[] =3D {
 static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
 				       u8 pin, u8 off, u8 func)
 {
-	const struct rzg2l_register_offsets *regs =3D &pctrl->data->hwcfg->regs;
 	unsigned long flags;
 	u32 reg;
=20
@@ -393,27 +395,23 @@ static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_p=
inctrl *pctrl,
 	reg &=3D ~(PM_MASK << (pin * 2));
 	writew(reg, pctrl->base + PM(off));
=20
+	pctrl->data->pwpr_pfc_lock_unlock(pctrl, false);
+
 	/* Temporarily switch to GPIO mode with PMC register */
 	reg =3D readb(pctrl->base + PMC(off));
 	writeb(reg & ~BIT(pin), pctrl->base + PMC(off));
=20
-	/* Set the PWPR register to allow PFC register to write */
-	writel(0x0, pctrl->base + regs->pwpr);		/* B0WI=3D0, PFCWE=3D0 */
-	writel(PWPR_PFCWE, pctrl->base + regs->pwpr);	/* B0WI=3D0, PFCWE=3D1 */
-
 	/* Select Pin function mode with PFC register */
 	reg =3D readl(pctrl->base + PFC(off));
 	reg &=3D ~(PFC_MASK << (pin * 4));
 	writel(reg | (func << (pin * 4)), pctrl->base + PFC(off));
=20
-	/* Set the PWPR register to be write-protected */
-	writel(0x0, pctrl->base + regs->pwpr);		/* B0WI=3D0, PFCWE=3D0 */
-	writel(PWPR_B0WI, pctrl->base + regs->pwpr);	/* B0WI=3D1, PFCWE=3D0 */
-
 	/* Switch to Peripheral pin function with PMC register */
 	reg =3D readb(pctrl->base + PMC(off));
 	writeb(reg | BIT(pin), pctrl->base + PMC(off));
=20
+	pctrl->data->pwpr_pfc_lock_unlock(pctrl, true);
+
 	spin_unlock_irqrestore(&pctrl->lock, flags);
 };
=20
@@ -2439,12 +2437,8 @@ static void rzg2l_pinctrl_pm_setup_dedicated_regs(st=
ruct rzg2l_pinctrl *pctrl, b
 static void rzg2l_pinctrl_pm_setup_pfc(struct  rzg2l_pinctrl *pctrl)
 {
 	u32 nports =3D pctrl->data->n_port_pins / RZG2L_PINS_PER_PORT;
-	const struct rzg2l_hwcfg *hwcfg =3D pctrl->data->hwcfg;
-	const struct rzg2l_register_offsets *regs =3D &hwcfg->regs;
=20
-	/* Set the PWPR register to allow PFC register to write. */
-	writel(0x0, pctrl->base + regs->pwpr);		/* B0WI=3D0, PFCWE=3D0 */
-	writel(PWPR_PFCWE, pctrl->base + regs->pwpr);	/* B0WI=3D0, PFCWE=3D1 */
+	pctrl->data->pwpr_pfc_lock_unlock(pctrl, false);
=20
 	/* Restore port registers. */
 	for (u32 port =3D 0; port < nports; port++) {
@@ -2487,9 +2481,7 @@ static void rzg2l_pinctrl_pm_setup_pfc(struct  rzg2l_=
pinctrl *pctrl)
 		}
 	}
=20
-	/* Set the PWPR register to be write-protected. */
-	writel(0x0, pctrl->base + regs->pwpr);		/* B0WI=3D0, PFCWE=3D0 */
-	writel(PWPR_B0WI, pctrl->base + regs->pwpr);	/* B0WI=3D1, PFCWE=3D0 */
+	pctrl->data->pwpr_pfc_lock_unlock(pctrl, true);
 }
=20
 static int rzg2l_pinctrl_suspend_noirq(struct device *dev)
@@ -2551,6 +2543,21 @@ static int rzg2l_pinctrl_resume_noirq(struct device =
*dev)
 	return 0;
 }
=20
+static void rzg2l_pwpr_pfc_lock_unlock(struct rzg2l_pinctrl *pctrl, bool l=
ock)
+{
+	const struct rzg2l_register_offsets *regs =3D &pctrl->data->hwcfg->regs;
+
+	if (lock) {
+		/* Set the PWPR register to be write-protected */
+		writel(0x0, pctrl->base + regs->pwpr);		/* B0WI=3D0, PFCWE=3D0 */
+		writel(PWPR_B0WI, pctrl->base + regs->pwpr);	/* B0WI=3D1, PFCWE=3D0 */
+	} else {
+		/* Set the PWPR register to allow PFC register to write */
+		writel(0x0, pctrl->base + regs->pwpr);		/* B0WI=3D0, PFCWE=3D0 */
+		writel(PWPR_PFCWE, pctrl->base + regs->pwpr);	/* B0WI=3D0, PFCWE=3D1 */
+	}
+}
+
 static const struct rzg2l_hwcfg rzg2l_hwcfg =3D {
 	.regs =3D {
 		.pwpr =3D 0x3014,
@@ -2608,6 +2615,7 @@ static struct rzg2l_pinctrl_data r9a07g043_data =3D {
 	.variable_pin_cfg =3D r9a07g043f_variable_pin_cfg,
 	.n_variable_pin_cfg =3D ARRAY_SIZE(r9a07g043f_variable_pin_cfg),
 #endif
+	.pwpr_pfc_lock_unlock =3D &rzg2l_pwpr_pfc_lock_unlock,
 };
=20
 static struct rzg2l_pinctrl_data r9a07g044_data =3D {
@@ -2619,6 +2627,7 @@ static struct rzg2l_pinctrl_data r9a07g044_data =3D {
 	.n_dedicated_pins =3D ARRAY_SIZE(rzg2l_dedicated_pins.common) +
 		ARRAY_SIZE(rzg2l_dedicated_pins.rzg2l_pins),
 	.hwcfg =3D &rzg2l_hwcfg,
+	.pwpr_pfc_lock_unlock =3D &rzg2l_pwpr_pfc_lock_unlock,
 };
=20
 static struct rzg2l_pinctrl_data r9a08g045_data =3D {
@@ -2629,6 +2638,7 @@ static struct rzg2l_pinctrl_data r9a08g045_data =3D {
 	.n_port_pins =3D ARRAY_SIZE(r9a08g045_gpio_configs) * RZG2L_PINS_PER_PORT=
,
 	.n_dedicated_pins =3D ARRAY_SIZE(rzg3s_dedicated_pins),
 	.hwcfg =3D &rzg3s_hwcfg,
+	.pwpr_pfc_lock_unlock =3D &rzg2l_pwpr_pfc_lock_unlock,
 };
=20
 static const struct of_device_id rzg2l_pinctrl_of_table[] =3D {
--=20
2.43.0


