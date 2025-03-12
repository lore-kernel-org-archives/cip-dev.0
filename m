Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B663C35FF4
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:05 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.20])
 by mx.groups.io with SMTP id smtpd.web11.34826.1741778733644310337
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:25:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=u/vvImD8;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.20, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QSzYgQKJQ5FET8KP3N1bY/mVXg1R6pUnH+nv9jUBGABYmyFUZmKr25G/BGtQ1iqC2C3a9BQtTyqShbSvNuwv9yb2EU8zi5jfziZlWUOS17m4xzRb8kMjLNPznz73Q5BAcdezJsUnfDBD55GjN6sXV/jmGYtvmQdvpnA7kOlSkD+x/ZWjfbXxmw5ygw12227eMCFrOotkAoJ4ElOFK1+Qcz9eUHCDen3N34BoHWsddcOm6ci5K5vcernCeTuzq7NGJ5ZC0xoxamChFB9V5leJc2Vi2jOy/3im3gFHh3lH5Vsd8qhFKg19PR6DEYhmghAc5emUaJ265Mlp+59E/ND0Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0wRKB70lhcHhhVBu88PJVQbs5g8XuCBg3tJmmFc8NQ=;
 b=tyeEL8xQ4rsi0rEmuU+K1w7EhKDrEd8p+o68z7D9WveZjIokOdGq6cL5dKrHD8SmBfQekXEMsEspCrmY5QClv5pjoFU/AdAMZPIKTppM52ToK99jHZnVYTurClwGQbVJRzlNJt6LnMhb8B1KaVVvZkz0P6WUlFgmAcpCKCSDGa5BtoHYLsx1d+X7jnGi5iQbpMxXpGLHk7ao8kti8B4IYBpNd6ImWTAb13MOokGnr0SqM/vgj948b9cnn7uhCqsBz7rKjy3lVU+Itx7Yz8yFRGyTMfN1XpwfiXycVJR2IXStS/7BRd1oDLa65dGnGazvtfsi6Rs6G5yKJMf6F+tQ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0wRKB70lhcHhhVBu88PJVQbs5g8XuCBg3tJmmFc8NQ=;
 b=u/vvImD8LxNAr5J23t2tj5IjFukO91wbSm/spZdzX3YpYnzPFoOzSj9g6YQxyNXyzH4GXpFXM/ynS6nLhGwCy3byMYlN1KHJ5k5Ct2HIS45EfADiyMnllBHz5VJQ7iFl1x429PqnSgRCJhS32JYEehysaklYEszdlqpR16jI2ks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB12752.jpnprd01.prod.outlook.com (2603:1096:604:33e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 11:25:31 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:25:30 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 39/85] pinctrl: renesas: rzg2l: Add support for custom parameters
Date: Wed, 12 Mar 2025 12:22:16 +0100
Message-ID: <20250312112302.1605750-40-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB12752:EE_
X-MS-Office365-Filtering-Correlation-Id: 6992c499-24fb-4615-d4ed-08dd615898ce
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?539L1cuPNmSqgEPRnAAfyzmwhU4WFGmyAJtuRxqfOo15OxouQ9ZwCEfT+huk?=
 =?us-ascii?Q?7a2plTWyRYfa/QgleEqhO1DDpiJbNFpL8fXDpJf6znOmZp+rU+U7ecZyjWo0?=
 =?us-ascii?Q?YzTyNUWUEsT7D0sydpVG+qDUP87MyedpCPOFMbxbVslmG0xcGumJot0ZJW9k?=
 =?us-ascii?Q?mW3zkCmJ9WoB+1fiJDij1zw7eiUmcO0ZVVpTfpwP9cQ/et+PjzrXQjLRwwOG?=
 =?us-ascii?Q?zmue/xVu3LJv47hVX+rqegfObzwP5efFsNPFSDPL7aQTqxydBkLpHVZiOtSE?=
 =?us-ascii?Q?YUSDxdTXzRaj/EkDj/aLqSJ9FNZjxF3h4cCxpxDtdMV3JpmtlSlb8o1TR74n?=
 =?us-ascii?Q?Y/HpdjVIlLYsQgXOHvBQZg7VAShHAX2EdllT84i7vp5/EM7ENLMSnMsu9q5w?=
 =?us-ascii?Q?ExOUBurjO1uH+bA9CMfs4DbHslDmYV2HAU/tJd+5U2N2uvEWkTJJXp5OgoSG?=
 =?us-ascii?Q?xUiJicFpQxP9LOtDtIg+PIu2My66MhZxeynU2+CMlFsw3/ynOSsGD+kJIVs0?=
 =?us-ascii?Q?acRIl1E2JNFF8BQgGcWHmHIsRWLcJYve9Ja8N8Q6KlayV2dv4M66fFjJv0Yk?=
 =?us-ascii?Q?twXyU+Dsqjo0joA1mBsd9wU/EoSpz047+4ynQ7zpchzo9kGMycquwyU1U27Q?=
 =?us-ascii?Q?z3TrdkSF/mhyxfvKistq1uh18hszn8R8PjU3gMo34/qCdYXKBBNc1fl3+oQr?=
 =?us-ascii?Q?Y1UGsTdJuULBFb+ZVkyrmgYybJE02k+mqYQVT2VJHKABm34Mv04/xjalBzDq?=
 =?us-ascii?Q?mSmnjy/YFJXNvx+rcKnongiBJERqvCqUoKv4YVBHZ7m8lW719zIKYPsFYUMv?=
 =?us-ascii?Q?JjIu13ETN6lHb+L/ZujwK547WTjtEDUuFkAx+V2Sh502virY8Hfrmreoklkz?=
 =?us-ascii?Q?Jj1GHXD7PNAKlYKGqzEioJELUn8QV6IZD3lL8qcMImTjiaBn/+0XQYSd+dpk?=
 =?us-ascii?Q?dD0F8wox7pPP7lXHD/vb7V7b+zU9Jsv2WDXaS58ye2sH+yxAY23Kket4P5TK?=
 =?us-ascii?Q?J8c6RsZcUAUOnCUasvXQxPGKWh+WoTmbz4gY22qfA8YiAMEcNqrsNa4X8e3u?=
 =?us-ascii?Q?v2cJh98Bvp9L5m73acKLbHlcf8G19zp0NGlQlj+pjtnRDQTIH4oTWad+809g?=
 =?us-ascii?Q?g+2s8Y4p4foiSnDmkFRMhGkx3tivvBAc6FReRN/uhjdzHCKSUbXLMydK1h2N?=
 =?us-ascii?Q?qk/3mbVk5Alc8U0fWfvXECOkVauK8MHmEpU7YsauumKXhFrDIBaP2j8UH+me?=
 =?us-ascii?Q?xtSFwkGKtTXTV9sp+ve4WizGtu5Tt9cO89Ih5B3nOc3bpK39cRBQlUkAgI2O?=
 =?us-ascii?Q?aN520/AnKG6AQZTTECrZ3Ngt9F9Ic45y26uUu5kS3yB4a5vicBt/1sCbHFR6?=
 =?us-ascii?Q?Eaa3h1BJNyTHeY5KJlOdJar7MjhtJWaNFt7qMGRpjNFraSzKjNNghUjM6+aS?=
 =?us-ascii?Q?fRHeXI2EPklZeH3FP4toPn67wVINvFPj?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?NllPkVMFcmuPraI4Qc6VFMjbN09WrSH8r2Vwf/uClTvGCYwQ30j/ktAAmkLh?=
 =?us-ascii?Q?8d68MVJz9ZUcsU37Jc7t5P97Lvz5SC9Gft3aEMtn6v15lenewmHGcpoTZyoi?=
 =?us-ascii?Q?l7qHxmGp64LhexLGua+mOBK2dc7pD7RZJ2+NtLqHbkZ+v/PXoVExi9AIALvx?=
 =?us-ascii?Q?IsHl6C/jygL0At0Z0WdVAttPemledyVvTpBdYLBD0fhBQUf+Kkclr7LYq1C5?=
 =?us-ascii?Q?kctbMwb46y7npYl7T+QqhYvcVfh0f2SgoCMWqsF1wzxaimfXV4kVta+KL6cX?=
 =?us-ascii?Q?R6/TkJrS5+oa6sYden3RW022pjFRUszaSIvNvBWI6yslK5y/3qL+qv6ByBje?=
 =?us-ascii?Q?gSSyQSH8HXWINfjdvVqFi9rAGA0zyXfs61IlIDFbhCdvj0dZzmzjJiTEkgJ2?=
 =?us-ascii?Q?xd49dbSko1wMB1NHRohsI7/s3vN0emTT/Kd8kRb0CzymFquzoNPmhDb//vlf?=
 =?us-ascii?Q?wIgKj0U1lAR0h3ieegInU66/GZUGdKzee3lWSTixO8/g0iVhxvLM3+Va6bSz?=
 =?us-ascii?Q?2AZESKez/xQLIZPtzuws5m5SqcYsJtZnfmRxawdjPbgBMaysKnI6FEQUnzIy?=
 =?us-ascii?Q?xzwNkVf+zy7O8gV6fB0G/aRer8fl00Hmk1a3KlRe7JgJ1WAIovDNGQOtDvIQ?=
 =?us-ascii?Q?TOXiiVhIig1Y+urQ8sTDcY+H8E1HwIkyrcqjbHZVpDXHbAYO61m6RbI/V5D0?=
 =?us-ascii?Q?Z7Uill0Q0k8TWiLA9gDT9jbBqaWg2ZxRabXDuny9e51FGSF+PPkU+97j2ur4?=
 =?us-ascii?Q?uSW5Z5roIXuvZy+yAtlHBiqCzcJvFAnTwSAyNQZlezGKxDtu5N+mUx2zK/qs?=
 =?us-ascii?Q?wzayoskRykKUaM9krrq+kYcau6a1/IfWGZFRRpgZZHIY8RK/dAZzvKlinRLw?=
 =?us-ascii?Q?PZqr+Qx9ulkILJs522tb5G+IcXY1CL6QGrtnOzFuQfV3Pi5PiEthFc11u1io?=
 =?us-ascii?Q?zm0FB2pDBC6dgtjo8ZxroyHSYgr37LtSwyd+4nPDzW1ZuRiM7wLdKwKLKkVh?=
 =?us-ascii?Q?df8btveWIYV4kKIFef1A8IV1HgVHg9FEeZ89JVrzQvlJcgSZHeIIJAGh9C70?=
 =?us-ascii?Q?auNZxROv0b+vThYpishHV97w+LZzsaA0YhwpRb/0R+EDJntgctPiynzaL/K3?=
 =?us-ascii?Q?dSg9a2XIDTWDcmWdMubUPgQ5BvIZpeaMW/dTSLbyGjjdxeWUE0TLuyYIQBym?=
 =?us-ascii?Q?zld6WSfCNRHuu3QhAKeAzp1f3ePG7EFJvDV61U3nY+rKhU9AW+uwKRtqzEf4?=
 =?us-ascii?Q?8Mkxpg2NQ/FeUnytK24pK5gfJEVCQeSCeTjFxQi7x3L5KdF5jtNaQF4C/BHO?=
 =?us-ascii?Q?+qfSqI+JYSAUV9oQjDThxS2eUgGp7QUGJtn4aGePRjnoRcmmEdJBkLBN1raV?=
 =?us-ascii?Q?dEMzBW0pVOXJwsywKjKFWlYmMJ8kW2Vqe5F1sU5enHctTRRlOF3fQxqc8HNZ?=
 =?us-ascii?Q?MITp5exHFsrsneF0jVx8cojeGj8ASMcNNNloXgtlqOc0XnEt9AdbjF+kSzZl?=
 =?us-ascii?Q?rBnSRWJQxF9rknBTLkRVy/YIYTbQPT6/C5cc44yhdDQ6Nt5ObedidpKxRu5E?=
 =?us-ascii?Q?WbCJjl+BnKG1TIEYhKV/VCnunFM6/yy7+R1FJARMo4uZqyOK6ls8/Au6e1Re?=
 =?us-ascii?Q?Fa9Le3+ytslMtIky5MWJ+uM=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6992c499-24fb-4615-d4ed-08dd615898ce
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:25:30.8821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QdOz7DpyH3BK+F/RzrCg/niGBNWRct9N+0k/nsICWIfxhx1NlfLtsOqWL+yJae+xXUjhwmWj+hLgSSujV3s15LXS4F4ByD5egXBcRk09KSbYBPh9pFvwYdq4XbkX4kwL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12752
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18131

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit d930e8f783daef890980c0ca209a0f4f9ae73160 upstream.

In preparation for passing custom params for RZ/V2H(P) SoC assign the
custom params that are being passed via struct rzg2l_pinctrl_data.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240530173857.164073-14-prabhakar.mahadev-=
lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 9c1f32f6e1e4..538959643cde 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -256,6 +256,11 @@ struct rzg2l_pinctrl_data {
 	const struct rzg2l_hwcfg *hwcfg;
 	const u64 *variable_pin_cfg;
 	unsigned int n_variable_pin_cfg;
+	unsigned int num_custom_params;
+	const struct pinconf_generic_params *custom_params;
+#ifdef CONFIG_DEBUG_FS
+	const struct pin_config_item *custom_conf_items;
+#endif
 	void (*pwpr_pfc_lock_unlock)(struct rzg2l_pinctrl *pctrl, bool lock);
 	void (*pmc_writeb)(struct rzg2l_pinctrl *pctrl, u8 val, u16 offset);
 	u32 (*oen_read)(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offset, u8 pin=
);
@@ -2290,6 +2295,13 @@ static int rzg2l_pinctrl_register(struct rzg2l_pinct=
rl *pctrl)
 	pctrl->desc.pmxops =3D &rzg2l_pinctrl_pmxops;
 	pctrl->desc.confops =3D &rzg2l_pinctrl_confops;
 	pctrl->desc.owner =3D THIS_MODULE;
+	if (pctrl->data->num_custom_params) {
+		pctrl->desc.num_custom_params =3D pctrl->data->num_custom_params;
+		pctrl->desc.custom_params =3D pctrl->data->custom_params;
+#ifdef CONFIG_DEBUG_FS
+		pctrl->desc.custom_conf_items =3D pctrl->data->custom_conf_items;
+#endif
+	}
=20
 	pins =3D devm_kcalloc(pctrl->dev, pctrl->desc.npins, sizeof(*pins), GFP_K=
ERNEL);
 	if (!pins)
--=20
2.43.0


