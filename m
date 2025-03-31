Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA4DC36010
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:46:51 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.44])
 by mx.groups.io with SMTP id smtpd.web10.49077.1743418010884818855
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:46:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=bU/awbHd;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.44, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CnOxo4tjCEp9JWSxcKts9QVZMw6DLLaIO2vZkYX9kr289aTj5PmKWnS8PCLsMmyJRV59G6mvwNQ77f83SPC0S3WdnFmgarauriEAGIJsuHHvYNFd6eWxUxSKZTuKP35GY8nqHrmIAxm5qoFyDO3ICC7AhKlFe1Q4aManNwFVKrFRD2yvoZqj2dvXbyqlJIfJOZsgmMhO7mSTS/HJ7ifyfXBH3O4J0BVkzTckPSsbEgSx3EqkCywGDAhuRLoZm1pnOGcJl7vQGuJxa8FzkPi+2J9sKFwZeQe7t51qgFNaIpMtTvmLKpjWgJeWVOunym1FhdSGRpsmm4mJd0hJbrIVOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQ/Y537IIP9Lxz2J2y8tmeKtGb5Plu3ylVanq4ellfg=;
 b=fVfQS7yFZ5jmJ/96XpmbLp4gHDGgFpDDc/P0O3Gt/hXE/McgKZNqJWhYhdtro+ywxzyUBbkwQGF7Aa7zqHItJmvILjGgmfOD/ADVaQl1Bbi/UdLxk3TYViI+BZuyUY4w26pG83+7p7W8AB0mvBDzKVhtJND6jwmPwgZPkY2yE9PMLf652f3mX8EFRA4p0ngABImdsswTnVjb+yxyllWw3XbMUT/lHT9sqAIKxTQdYp6Ng69+yS1ZoSrsftAE3HGfyganvxmD142Gaiz7ayMNwg8gYjWfMxgyLjDsG4aUbzzQOFCufL1M7LD2+4HdowA/tmOFWzmr+v7rdBAqNzzV7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQ/Y537IIP9Lxz2J2y8tmeKtGb5Plu3ylVanq4ellfg=;
 b=bU/awbHdmkPzOH14MQDFWIZXY+wD0CPbF9fQ6cjbZzwwM0EyCjgm3PRhUVcEV8PM7HjmLC0duDHbcjlHxtNWwZBizzVZS6E03PrTvRKjJcrdtuS/+unwTu7n8AAMzZx+r+I8dftuVThKJ0R6+AHURb15hYYrOncSY0W04WH4vGY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY7PR01MB13744.jpnprd01.prod.outlook.com (2603:1096:405:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.33; Mon, 31 Mar
 2025 10:46:49 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:46:49 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 26/43] pinctrl: renesas: rzg2l: Support output enable on RZ/G2L
Date: Mon, 31 Mar 2025 12:44:57 +0200
Message-ID: <20250331104514.79090-27-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 027ff358-3496-4dff-0439-08dd704156be
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?gFkY8WdT3tVWmt7AhGcWayB+dWeo6dwTFMXAcwXflIdfkCqwz/vFBqe8xLs0?=
 =?us-ascii?Q?nf0Dv0ABFhNCyBlIGF9dT4oNBJScZjCjbhwnyWA2qx3j3y0/CmHbDxvDtm/I?=
 =?us-ascii?Q?DqVB/PeKzF3bTtlvRI/wfHRKkTUSifaDjS4FdtN8+5M0B8AlLp0GmJ6hEkkK?=
 =?us-ascii?Q?A5VvbTHkgvZ/rpmByDymp/LhzymVQphTzSxDFNvc2tl0HWUe3mQrhw6pMFu8?=
 =?us-ascii?Q?+8uUWrYyD2g76dpo/nb1X74BEIhAfaubo9cIJ/k0eVdSuHt82lbDbUaV7SWI?=
 =?us-ascii?Q?vvAiP5nX24Hc1rTxX1+MIPcwcG7pObL5AiAOA5B0B6UdmDH8K+2xnDTqia4N?=
 =?us-ascii?Q?j4y0HOezYWhEurpO2g6S9mGoHJtuacmLtpDF20rVuqLgkTMaBU7kip9XJ3PA?=
 =?us-ascii?Q?EUEJScc2abJ07yhaS8XnlptVC3YyjpgqtIjtgyI1BAqKkdPOOxU2AnF/q2lz?=
 =?us-ascii?Q?Kg1iVMGgADKV5J2WLjqgvCfKmzmWMqefjbZiXwyzvssioGoWBGYbr6Bq3euV?=
 =?us-ascii?Q?aiettcQrv4j7xn8CeQMK4v2utJdu5H1Tlz31zGDVRaLOgmzKJFA1Fy+ja1uG?=
 =?us-ascii?Q?qZjVCIJOOkr1eru6DFOnTcMjosNjpQenqgPd6vKMM5CpkCFV6xExraigDO6Z?=
 =?us-ascii?Q?R5ZsRR8l4jZzqwhmKtWJdlbcF2fTga38MuJX1oQDMqbEBXc2G5eTvOSlNHhj?=
 =?us-ascii?Q?OUf0Ly8Zbm2sDWmp6IKaCpnXB+95kZgDd+bEtCjpr2/TVVONYOQtnKSvJ/8R?=
 =?us-ascii?Q?rVqMvEPZzxqLJ/jHrZ+SJ8DLz7jVCU15O5X2QprwiAj2BQ1e+xybpX0SuTgw?=
 =?us-ascii?Q?Lec1WVzkQGCOWXnCM5tt96I6ElqP4KbEr+OnTYPPLpG3R0i+VN1ChnvExGNG?=
 =?us-ascii?Q?UxtkyRyCWZ0eD4lasx/Qi7QFn0ZSFUjcRvNi87M6YqAYzjRmt8EdRJBktXo5?=
 =?us-ascii?Q?ijVW1nkbSZwLjGmZH0sFc/g8p6JnVqIi0GgNrywPYu/s2Hyzr9H9QMqmQXw/?=
 =?us-ascii?Q?2p/uOqPl9s3MWjVEqpUUNXx/rT9P/Lg3hN+/8kT3hIpIos0w20SnA4uFHHal?=
 =?us-ascii?Q?n/CoHUOWZm5pCrrTOD/hpNas8zCdFOY4Dug0GcYE1dWPlG2OGrgajjGkt5JB?=
 =?us-ascii?Q?loGdmGLndqsJREWlkzFZE4Z88HaOHw5JSynhiI6Mv053IU9ANer27/79k1gT?=
 =?us-ascii?Q?eScJenvV/r9JZZ/5jOUsm2EDkNSK9JjbqCWM3guMEuEAtYUi6vxaxMjQ6VtR?=
 =?us-ascii?Q?B0IWpLu1fROzEQzBeW3N8t3BlvOHn4b2Eo0klZ5OJLHiRFvdTuFPlK2fB6IZ?=
 =?us-ascii?Q?kqs45Ohtqyaks5yfqMGAMrucGXJvm7HoOKhNmAsSct2cpNok2y1HxCNqtibe?=
 =?us-ascii?Q?iTsOoPWOPVk/NPJTq5WKt58721IdDlMArNNNHtC6DaPZEllT3wkyLP8dEFEC?=
 =?us-ascii?Q?Ld9igrLWsxIPE0P1xaBfLCpAqghN4EPy?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?J3GNnlLpkeNodBWHkqBaR8GjSd3l+PB5LpXgBYIuUF2bI3omxoIRCQNf7a9y?=
 =?us-ascii?Q?yLZ1DGUNrgD5g9nLnptEhRttBxDqmYq66rOw2VDvLFMLbKy9Pr+9GJfr8zG8?=
 =?us-ascii?Q?eV+WHm0qDW8asLD6r5KjAQCKG3IMEuEsAmsAsWlket9r4b8RC3dSMnoq6hTb?=
 =?us-ascii?Q?ZTAMVg9ZINHPVTNSm5RxEbcOY7qjLsJwuuUxtdiNPIVxmvAEu+S3vsxq/eKf?=
 =?us-ascii?Q?SDWjGH0u2I0ZvPf8MiVT+puMT89dae/jxcAMw2922kT8zvbNyXEefvaw5+gj?=
 =?us-ascii?Q?TZJXETJU4q3/g6iBDMFEZADSKJ3mdZhp5FHk6K7j4KlbB1G1U42Om+ZR65hD?=
 =?us-ascii?Q?VIe2L7nkgUHlYrAZV7aKP7g5kutUvxWBnUNVz8kOXbqcTL3Iv0aOpoC22R6U?=
 =?us-ascii?Q?9295ZGm8EcepKwfGADO7LAaa6lQjvxeNn7yhcH1sMTURLxbrEYSyH+ItcpAm?=
 =?us-ascii?Q?dh7E95lhL9K4GQQrnTS/V9YG3uXjdSSpb2ibBQQymiCGlOz54/nm73U8mCYL?=
 =?us-ascii?Q?Qi3ZprnnnJdfvq/Hk+iSim/V7Mmc1mQY+jWAtNji7y3SNhlhSoda0/5CYBnZ?=
 =?us-ascii?Q?R2I7goXt2MXb/7+5pM0tgDhcnHj5lw12HRqZWQjv5PiHkxemT+J5s6omcbzt?=
 =?us-ascii?Q?UbYRF1bS/R3Z27nTS1tyS69PMyck+hWhC+aEWBDn9bFfSVLmcjvVDrLt5TQ9?=
 =?us-ascii?Q?ofo3SR9V+WjggZnuZj/t1RWxVRojtyu9CkGF2oXEm7AGnOhcPtLDVePov2l4?=
 =?us-ascii?Q?3/eNJ9jUJFUEXzAvEB3y293+31uHp+b/kmBkJZD/rByP32dZxOg1h2/Frexr?=
 =?us-ascii?Q?YiGkvoOM967f6QRgKKdjgQ7q/jfajAxABaFBdsE2TYSv8BNaYs3fCHn8BMbO?=
 =?us-ascii?Q?02FbT3z3FP0JWLDuOPX4KdFCFTINp93QT3pjPjJOnU6jiVCOV7lyHw5rTXe8?=
 =?us-ascii?Q?JVBdw+cOOxHxDJg4dUz5CmBqpR7sq2lNHb0Jd6k42HnT50MW3noLN+HdlbO8?=
 =?us-ascii?Q?VPWli3ibta4RmdHDavwEovBvjoccDg7C+ajAQBSSlcZXoxvVNSCt8D8Z5+ht?=
 =?us-ascii?Q?NG6VhSLdGDtJZTrwpii/3ODZl3xtV5aU8B99jvXSMO8f6+WNcCtLJh+V57+z?=
 =?us-ascii?Q?45BmAlmsovM7yzL/bQ1qPDFFGxSH7T9rBg41YWMdqq3DmnRIDcqEGElUqR90?=
 =?us-ascii?Q?AecIptaybUHe0c1qK4/awYTjH1VCJzVThE+z4qzp+Hx928RVOXky7WxTfJ5a?=
 =?us-ascii?Q?zKXYIAeF3mfNhyvgcPpcc1TZKQCiPsmYStA9ARcghUb6m8vY5nw+bEvBCUAV?=
 =?us-ascii?Q?t59TtrVemYtGDepRlx7U1S+t2tfc7q81aF0DYklPvxcUZiC1hvFv1apjemG+?=
 =?us-ascii?Q?Oz0W5XLsSI6QrG+4rZfa+ttakts3Pn26xe1PHNkI0cdhBquppFNh7TvP9ANd?=
 =?us-ascii?Q?Te6+C60H8/n+R6x1E01orANucKzRd309h84I8BwMH2eX/86Bi3oPJUx6otUE?=
 =?us-ascii?Q?aiKoKsAeax1jz/HEvVMbVFHYE3X3bdTZqKzAEDTs910xDGHIYYQqK9hapS6w?=
 =?us-ascii?Q?TngokwguXNpSy1NUpv/2jsS3+r9jXQ3hvfJ4DFUKuSEghX5ahsgjp5a7ZHsl?=
 =?us-ascii?Q?4jzYAI9qhUvD31aADECo1/A=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 027ff358-3496-4dff-0439-08dd704156be
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:46:49.0394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzhF+5y7v/PMOePNU3k92Anc5/Fr9HshAfOl/tkmK2Rq4qyfigbNzUoH3PkOl2GfuRgKmJmMt26XMSbqlozvTzIJCrbFIkVtAbsTZHWIW3g4745e3E5vUDGoXX2kKqgw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13744
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:46:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18414

From: Paul Barker <paul.barker.ct@bp.renesas.com>

commit 2453e858e945e5e2fa8da9fde8584995e7dd17d1 upstream.

On the RZ/G2L SoC family, the direction of the Ethernet TXC/TX_CLK
signal is selectable to support an Ethernet PHY operating in either MII
or RGMII mode. By default, the signal is configured as an input and MII
mode is supported. The ETH_MODE register can be modified to configure
this signal as an output to support RGMII mode.

As this signal is by default an input, and can optionally be switched to
an output, it maps neatly onto an `output-enable` property in the device
tree.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240625200316.4282-4-paul.barker.ct@bp.renes=
as.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 67 +++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 6b383f2baf478..ba0122b46da08 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -999,6 +999,60 @@ static bool rzg2l_ds_is_supported(struct rzg2l_pinctrl=
 *pctrl, u32 caps,
 	return false;
 }
=20
+static int rzg2l_pin_to_oen_bit(struct rzg2l_pinctrl *pctrl, unsigned int =
_pin)
+{
+	u64 *pin_data =3D pctrl->desc.pins[_pin].drv_data;
+	u64 caps =3D FIELD_GET(PIN_CFG_MASK, *pin_data);
+	u8 pin =3D RZG2L_PIN_ID_TO_PIN(_pin);
+
+	if (pin > pctrl->data->hwcfg->oen_max_pin)
+		return -EINVAL;
+
+	/*
+	 * We can determine which Ethernet interface we're dealing with from
+	 * the caps.
+	 */
+	if (caps & PIN_CFG_IO_VMC_ETH0)
+		return 0;
+	if (caps & PIN_CFG_IO_VMC_ETH1)
+		return 1;
+
+	return -EINVAL;
+}
+
+static u32 rzg2l_read_oen(struct rzg2l_pinctrl *pctrl, unsigned int _pin)
+{
+	int bit;
+
+	bit =3D rzg2l_pin_to_oen_bit(pctrl, _pin);
+	if (bit < 0)
+		return 0;
+
+	return !(readb(pctrl->base + ETH_MODE) & BIT(bit));
+}
+
+static int rzg2l_write_oen(struct rzg2l_pinctrl *pctrl, unsigned int _pin,=
 u8 oen)
+{
+	unsigned long flags;
+	int bit;
+	u8 val;
+
+	bit =3D rzg2l_pin_to_oen_bit(pctrl, _pin);
+	if (bit < 0)
+		return bit;
+
+	spin_lock_irqsave(&pctrl->lock, flags);
+	val =3D readb(pctrl->base + ETH_MODE);
+	if (oen)
+		val &=3D ~BIT(bit);
+	else
+		val |=3D BIT(bit);
+	writeb(val, pctrl->base + ETH_MODE);
+	spin_unlock_irqrestore(&pctrl->lock, flags);
+
+	return 0;
+}
+
 static int rzg3s_pin_to_oen_bit(struct rzg2l_pinctrl *pctrl, unsigned int =
_pin)
 {
 	u64 *pin_data =3D pctrl->desc.pins[_pin].drv_data;
@@ -1775,7 +1829,7 @@ static const u64 r9a07g044_gpio_configs[] =3D {
 	RZG2L_GPIO_PORT_PACK(3, 0x21, RZG2L_MPXED_PIN_FUNCS),
 	RZG2L_GPIO_PORT_PACK(2, 0x22, RZG2L_MPXED_PIN_FUNCS),
 	RZG2L_GPIO_PORT_PACK(2, 0x23, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(3, 0x24, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ET=
H0)),
+	RZG2L_GPIO_PORT_PACK(3, 0x24, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ET=
H0) | PIN_CFG_OEN),
 	RZG2L_GPIO_PORT_PACK(2, 0x25, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ET=
H0)),
 	RZG2L_GPIO_PORT_PACK(2, 0x26, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ET=
H0)),
 	RZG2L_GPIO_PORT_PACK(2, 0x27, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ET=
H0)),
@@ -1784,7 +1838,7 @@ static const u64 r9a07g044_gpio_configs[] =3D {
 	RZG2L_GPIO_PORT_PACK(2, 0x2a, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ET=
H0)),
 	RZG2L_GPIO_PORT_PACK(2, 0x2b, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ET=
H0)),
 	RZG2L_GPIO_PORT_PACK(2, 0x2c, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ET=
H0)),
-	RZG2L_GPIO_PORT_PACK(2, 0x2d, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ET=
H1)),
+	RZG2L_GPIO_PORT_PACK(2, 0x2d, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ET=
H1) | PIN_CFG_OEN),
 	RZG2L_GPIO_PORT_PACK(2, 0x2e, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ET=
H1)),
 	RZG2L_GPIO_PORT_PACK(2, 0x2f, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ET=
H1)),
 	RZG2L_GPIO_PORT_PACK(2, 0x30, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ET=
H1)),
@@ -1808,13 +1862,13 @@ static const u64 r9a07g044_gpio_configs[] =3D {
=20
 static const u64 r9a07g043_gpio_configs[] =3D {
 	RZG2L_GPIO_PORT_PACK(4, 0x10, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(5, 0x11, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ET=
H0)),
+	RZG2L_GPIO_PORT_PACK(5, 0x11, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ET=
H0) | PIN_CFG_OEN),
 	RZG2L_GPIO_PORT_PACK(4, 0x12, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ET=
H0)),
 	RZG2L_GPIO_PORT_PACK(4, 0x13, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ET=
H0)),
 	RZG2L_GPIO_PORT_PACK(6, 0x14, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ET=
H0)),
 	RZG2L_GPIO_PORT_PACK(5, 0x15, RZG2L_MPXED_PIN_FUNCS),
 	RZG2L_GPIO_PORT_PACK(5, 0x16, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(5, 0x17, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ET=
H1)),
+	RZG2L_GPIO_PORT_PACK(5, 0x17, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ET=
H1) | PIN_CFG_OEN),
 	RZG2L_GPIO_PORT_PACK(5, 0x18, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ET=
H1)),
 	RZG2L_GPIO_PORT_PACK(4, 0x19, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ET=
H1)),
 	RZG2L_GPIO_PORT_PACK(5, 0x1a, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ET=
H1)),
@@ -3007,6 +3061,7 @@ static const struct rzg2l_hwcfg rzg2l_hwcfg =3D {
 		[RZG2L_IOLH_IDX_3V3] =3D 2000, 4000, 8000, 12000,
 	},
 	.iolh_groupb_oi =3D { 100, 66, 50, 33, },
+	.oen_max_pin =3D 0,
 };
=20
 static const struct rzg2l_hwcfg rzg3s_hwcfg =3D {
@@ -3061,6 +3116,8 @@ static struct rzg2l_pinctrl_data r9a07g043_data =3D {
 #endif
 	.pwpr_pfc_lock_unlock =3D &rzg2l_pwpr_pfc_lock_unlock,
 	.pmc_writeb =3D &rzg2l_pmc_writeb,
+	.oen_read =3D &rzg2l_read_oen,
+	.oen_write =3D &rzg2l_write_oen,
 	.hw_to_bias_param =3D &rzg2l_hw_to_bias_param,
 	.bias_param_to_hw =3D &rzg2l_bias_param_to_hw,
 };
@@ -3076,6 +3133,8 @@ static struct rzg2l_pinctrl_data r9a07g044_data =3D {
 	.hwcfg =3D &rzg2l_hwcfg,
 	.pwpr_pfc_lock_unlock =3D &rzg2l_pwpr_pfc_lock_unlock,
 	.pmc_writeb =3D &rzg2l_pmc_writeb,
+	.oen_read =3D &rzg2l_read_oen,
+	.oen_write =3D &rzg2l_write_oen,
 	.hw_to_bias_param =3D &rzg2l_hw_to_bias_param,
 	.bias_param_to_hw =3D &rzg2l_bias_param_to_hw,
 };
--=20
2.43.0


