Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AB0C36006
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:16 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.61])
 by mx.groups.io with SMTP id smtpd.web10.34475.1741778759536923358
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:26:00 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=MK8t3Tzu;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.61, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HhLH0hmT3uTx2MhP236NWPdMbqkmxLxS7R5ITuXIMGUdsFRSNgefGxz3Q9ItLnF4v0678kPDsq8xj29ZiyFb6UNYeJpE/BvKVfOTAF0DOGuU3+cqUnt6bcSZ4/rMTd5f9Ind6jT3JjjRLFcM6sjG5eeCTIxAZV0o8zM4sLk3nGy9ujEchOzvy0QnbJ+yhpr9FJPhhlZ37/9KD9g3W1WWeNQ1ZZ/XVywo7g5q0VdsdTKR6g9TsUU3yeJ6V6PNbmkkTAOYmGmRgnJSDXdFFdHgdgsamHGhyXwFALXP+AtiyKosZ0wjnb5AzUdegMKGMghaT+IEGZRb+pnRhuIwk6OvjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CuMPrWF3NC8RKvxO9HBWIaiRdutUJ6WVn9qvZB3i/4M=;
 b=Ud6YT9D45SJ1KiaxsDYmx7+H3WZwK+D82XEY2O5yifreVqEEvYzbsUsdTftCk+rtWQoFHY3+vi2SM4NiuE+D9smcf+gFCqIGOyBIcGBNAnnW7qlFUWZDsKhKSsTwpJjpnN1K2KAz7IuuXyIVsfoDUMrx8iK5+O1AcJoPPvhKt5TbpUOb7psmZ3OHFiRsWKENu6OxLjMfUNOqVwf8PynkyMAFp7LFcYHQCnDi01rG4oE0kEqLzsrHiOwp9MP0HZSmqV3jkU1pstwwGcUBoPn/IwYprq8lzEdLwiyzW27i/RWetFubhCtiR0m8zYl5M2/ha5hoVtmpa3OmJxO7EDTjgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuMPrWF3NC8RKvxO9HBWIaiRdutUJ6WVn9qvZB3i/4M=;
 b=MK8t3TzuE2xAM/zmYD//vEQ24gU6UrQS5qg7r6g7Fwb3IVXOo47+5V397w4FBehEQ50ojrTW+mDbdHpQo1vvQEEvOGCnUKH9OuPx+x2dKSDlDHZZ1tZgGKv67GYLNMSxH4m0dE+j1x/UPYprfB68JWO9WXPqqIlqn394o6oscwE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYWPR01MB10982.jpnprd01.prod.outlook.com (2603:1096:400:397::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:25:57 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:25:57 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 48/85] pinctrl: renesas: rzg2l: Support output enable on RZ/G2L
Date: Wed, 12 Mar 2025 12:22:25 +0100
Message-ID: <20250312112302.1605750-49-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYWPR01MB10982:EE_
X-MS-Office365-Filtering-Correlation-Id: e0b3da54-9812-4181-4728-08dd6158a8ad
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?5VlMsgzGXF1+2/tbs7gneIrB64Ihehe6sHpshuJwsUdxI3M1SYD748UhT/zm?=
 =?us-ascii?Q?dkHQ9kMLbY5Ijg/DP7W0zO5vv1gaX3Ew4eDA2wTHyKU04KTKbYKyRHqu4TDC?=
 =?us-ascii?Q?Z35wmqCO8qYwrdz3uRmJgM5CroczWkGqXAgYtSGLuC4S90v0xvGqsxwa68vO?=
 =?us-ascii?Q?iF82GKR2bBfav2p5gp8V6dMoPmmyk/eNBgVG2AqUR8JpzMGA6zkHteox0ZrN?=
 =?us-ascii?Q?ECKpJccAduROXCo/dTAxoJi9wGwhx1Y8IxiDj9i8ubj6SSwoL8hhJ425rGto?=
 =?us-ascii?Q?70JS6mv8RY0Q7G6uCn3qieaUPkvqmRNNkZw8gJF7FlR17Gz1ojeU4w3TI1qO?=
 =?us-ascii?Q?30R8PMrJ03C7rLceykXaHEBbGHzfhKzqFxTXYvWBiB46kN+hhDIrAx0AB9Et?=
 =?us-ascii?Q?p1tk4Jsuiw72mqXleVk/VxVMNblplryFT4bdH6S58QAqnljIjoCUqEsBVmxw?=
 =?us-ascii?Q?ccIcUxcNuKyX3clmjlrmlfC5jQh4n8hIfHEEtnykLxGymGX9DV9tsnZxbL/P?=
 =?us-ascii?Q?KIrMyP5/rS/1Ng4pYmJ/hNrFY/8IyXlXBq5pdFRnZZwhus4eOioj0IMnw0ve?=
 =?us-ascii?Q?vrNLX8JvvneLuP9PJQSspef1dk1205KYdndzm13/Btz5eLuper7qhJGROr0k?=
 =?us-ascii?Q?5bc0oQA3LuTyj/dHYaxgYQ/WXX8stCv8fckLainw1aX3maE3jWEE2P3NykfU?=
 =?us-ascii?Q?50Sw2AeLK29OP0eXpgYCjYgA7EeKbzdk2Nr2nHCUnUuI9ksAgIL7/AZCjEA5?=
 =?us-ascii?Q?H0+6FFqLpb/FJfKahVnZJdgjb2gOzacjgB/I4oAPCpjj81JvI6XDkqkHdVt6?=
 =?us-ascii?Q?5kjK7OoIc7UvqVj2dCGpLhWj73nReMKDz8WyN9prlZhHj0c4uCRAGSTcwuH+?=
 =?us-ascii?Q?x0oI+/DD0F/7Ye0PuIx/n+DW7RsAWKHtQtc92s+tIHfNDR1AUt5bfNLHxhOT?=
 =?us-ascii?Q?o99NS4c27jMGzRLopV4XQvpArJsaCKe0HdEi5VqvnIAU4UX1wXYQuqE3v+vM?=
 =?us-ascii?Q?lk+CKfAJnSOcx+4/P/jTDFTd2PDILXGA0mtGEgfehoEJ2cJgpZlTaOgnYism?=
 =?us-ascii?Q?s5xHFUMLFtDZlsyXXtRP2HIF3PXr27dCJO6tpUHR6gljXV4W3USNZ0Q8vAOU?=
 =?us-ascii?Q?7QenXm+lzUteENpeJ8+C82nmY9BzRDyav5HchNP4HebEghI6+W4jbru6mq65?=
 =?us-ascii?Q?Yc688UnqCMAEkFln9+yporkLU+ModWNHnlP1EF1J2A83Urp3I3DfCIKM5kda?=
 =?us-ascii?Q?gkKmBBUHrMCxTYo/epnTSyEqpBVeP1lBnwczQYhbjKOEDn9GnCiPA7tx6bEf?=
 =?us-ascii?Q?o3qICJ0GJ92+3x9YefiXEGlo9BLgVxLLQjhyF34Kt07G/gutIOnuav9QOuxv?=
 =?us-ascii?Q?l929yBh4i7E8YRB2nwk+/Nwf8ZANe0sHfXcekDrwAa25rJXpbq05ysFHDMov?=
 =?us-ascii?Q?JguuYedFp71H10S5kl0H/EsFtxBPzqPK?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xWXezJ6j8lbwRW6FvVHs8pCPLpWiVHBZrpVN/aDrWEMkCAjrh/SBQi9cVVoG?=
 =?us-ascii?Q?yMISmKDkxMv8yjs3ZOXjHk3kffx2pFyqIzucCvYp1wLX8gpPkS+hWKT2NB6w?=
 =?us-ascii?Q?dYJoijdAujPEmunFOLpgW/E314vfw41EhvY8tuho9PwzU3x7e/YAXk3gxbow?=
 =?us-ascii?Q?Cg1C0EXEo7qtqyWWXI04hc2PeS6wCEZZnRRTBnEx1nS4g+uZ6srFdTm0p8aZ?=
 =?us-ascii?Q?Br8uZla2HsG8KS/RWyydZc9zLy0zWkl3tTBWZ/fOaj0mQfzK3PIcDjNNBXn0?=
 =?us-ascii?Q?rxophbE+vLCT83olNGzVeWeWbSm66bpnnXsZu5Scm2iAMjXb2yso6Y0k6Qny?=
 =?us-ascii?Q?etNc2phj80rptqDARIT6mgDfqz9cXxpT3QzYSTlSSHTcravN3ch9+waxH/Vm?=
 =?us-ascii?Q?Locd+9w/ceMuFcqC7JGm7ZAlQeOxz5wHFN0GRr3+mjnQQdMpxF38f3mRtYoA?=
 =?us-ascii?Q?oO31vrAAtENSb23CKgkiLHYWgey1SBLaUSeSjb59XXiEB1kb7VIu6LcMoj1p?=
 =?us-ascii?Q?LykiBYv83JVv6wk4RYUhGfBa8gSFVI9igkbxo/s0mP8CopSOf4T9dVt2ea8A?=
 =?us-ascii?Q?N2FK5S1/MOp4zfkChWD3ywDCQzyaxmPU3V/vJ8GKeP365ybjPcV55GLUuOIa?=
 =?us-ascii?Q?c4uF+VEOT+R5GywX5FB4RVNVQPcqb+eLbxlT9Kq5BA1knBN5e0fKv5EPYcOj?=
 =?us-ascii?Q?I45pzs6v90tjEs40XTxoiEA6WaY8U9W0aKYxJnOI0cQsHe/Zz7MhMpv/aIW3?=
 =?us-ascii?Q?Wlrqza4OCVc702EcamddcbxQ34Z+ftSIRof3Gq/ViySDBfekPO4rqIUnywe2?=
 =?us-ascii?Q?3WRElrKdIpPvtN2ZtNOEWf19HA2cwTOIjiKDyimCA3riR47l02HhnOOUgsKj?=
 =?us-ascii?Q?iOqq+s5emtzYwF0utGyWnk6NvoDHIIvlu96A3OtiK9mnfYlOgJo8c8ds1uCF?=
 =?us-ascii?Q?FmTqn+ugta/kn9lfuXRjnRVg0YcVWqcSlJTUqxh89ZZ+XHSen2nhen1akIzT?=
 =?us-ascii?Q?0wspTaT7v/bZEp3oQ+/zD1HRgKBsc+knir8d6EGgIOr6ss9psPbMPHe2G14S?=
 =?us-ascii?Q?wapI3lT5+AtQjGt1P8d8xvkh4AGY8/5jwIvWFvtaiD6yWc6Vkr772xsU2nmM?=
 =?us-ascii?Q?7qM6f0ZT8WuCXIO+AGdbIHR9yj0CMh4zVoRK/7rUr/f1XISU28td73KXvQB4?=
 =?us-ascii?Q?nnT6sdxzPG9oTA/976ni1+JrhU/c20PGAMmaKgGvaAz8VvRfy7tuSXmKnAzk?=
 =?us-ascii?Q?8ErKa3S1p9SS1413G1OUl0cV2FODk5DbGHs986wqCHJJg3DQmKmRb1XWIeNP?=
 =?us-ascii?Q?jVCBmmbj8E/zg/Ou6do+M8B6DS7Ede+0dKd3V6pqlE5aIBcJw482EaLA6Ci5?=
 =?us-ascii?Q?3pXUCm40R4o65J+MNarR8lMKHeaENhFRIR+BAx29hXjMsIibxvW0Z0VQksyv?=
 =?us-ascii?Q?jVdrVSzak1mPLE/LFsjlEzT/uPULFXtq7FH43mF+yRAfN71GUMPo45Elp9ll?=
 =?us-ascii?Q?SyGQG1YtCFFo8CbZykh39tlhSPR0Oxa4k2Rb7n1OaOGWSK4a0Feu/xNTzSWz?=
 =?us-ascii?Q?zm31YIUmlsKeYBi6ucIpMI/RXleIMj8d3qfvOt8jEUjCf2w0wPEgGHoNvA9Q?=
 =?us-ascii?Q?VJLALWAAeMZVbL8G56uV2KY=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b3da54-9812-4181-4728-08dd6158a8ad
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:25:57.5608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vNUpoeuxUT7IOemHOfbbW2d3ynEyLDyvhNbvZrovA6P16D3MDBLEde7ynZeea03iZ53qKbeCNx2RGyfkuN19ZAgSZquENEPBNy7lRq+zTkZGYiYNbysp5jYzXY5O6/cN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10982
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18140

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
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 67 +++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 6b383f2baf47..ba0122b46da0 100644
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


