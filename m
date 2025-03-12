Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00B7C35FF8
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:15 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.68])
 by mx.groups.io with SMTP id smtpd.web11.34834.1741778756352380653
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:25:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=KmV9K+0v;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.68, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqA9U7xTQBKax8PoTx+/fNAynEtR9b5dM5CvEQPCPElpoqQEDloky4dIYyMlgv5+bgHm0eeFC7l7oaB7uQnfVLWX/+uuOqonrEGihg+BJAPUh4adPEZ2ZUGytDKD7r+/sC9J4M20wNAMothOMUVhcNdbeNh0vmEIHqoyyOKm2rZahhw2VPU/LgJ8LXbAVbUHHSNLy35F8PvS6fY4jz9krCmVNimbz7XRO0vqeiHADnj7MJuWLhsaXdZKQbm5zbWpAAaRdmhTtGQPqncc8TVPPtg09o4gn+xOljWLGkL8OHqu50eiCrQciFOBRApUTzWGvz+NXqOzjKPPSDoVkZ943Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4ZC+o2SED60IHDxBLj7pGnxU3dkz5GzC8vsYWYIuzo=;
 b=E47xEtNZHaj028JndcwbmK+z5WaRuANsvYQTJxfI7GKr3gBOpsuzVMyr3thNvvChBB8CO2ccYdsqIfxyRbLGF/I+iMkwE1TqhG5uMvRLZe6cCm8cA5h89qv/zRryz8cTWUEYhtx4xBmzh5vG+E4syA3A2mDo7TNh2TFkDKJAnkzef0vL7q2QwPpee1yHxYiH3zipPK22F6PotTBA8a0/hoPNJsbjMAhrk467nD+6kclX6TTsNcZ1hXWBGAE8zcWLno5+kM/DetrSejROsWmMH1KIRyrSGtcNTNVCOEw5AE6Ku8Sv8JDJTBhr4pPPYE4+X2sI2Xh/rnlZAHM4vchYQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4ZC+o2SED60IHDxBLj7pGnxU3dkz5GzC8vsYWYIuzo=;
 b=KmV9K+0voNQDXQd7XrJeW8Ark/xVheb81pEYRbxYy2dc08hqdIHoKRIpXT8dgjiqNn49XA8NuORsjAQuQUxxSD3K7Nc4uTjl23jb6UOe87cfDOicZ51Wc1W5Yclob16bllJbX0GXD+LO3LeV/sYyQVxhD/AlQUIXMeVgl8+1Zy0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYWPR01MB10982.jpnprd01.prod.outlook.com (2603:1096:400:397::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:25:54 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:25:54 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 47/85] pinctrl: renesas: rzg2l: Clean up and refactor OEN read/write functions
Date: Wed, 12 Mar 2025 12:22:24 +0100
Message-ID: <20250312112302.1605750-48-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYWPR01MB10982:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f4ead62-c36a-4c05-c6e1-08dd6158a6e7
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?6S49PJmZtuMz0qqpEjy34D2ZvaJqBnxQaBk+1cS8J426MAyYjdYB77Ktm9sf?=
 =?us-ascii?Q?riDYiYTiMbhZYR+YbCG3IDMlLnpH/08WFV2Zs/jksaqZPmxIXx8Q0jm0Tnhw?=
 =?us-ascii?Q?HhewHGRoPJds1Tnavv3qocfyltE/gH+vUqpyKIsC5TxgMqqZircSTWlNCJva?=
 =?us-ascii?Q?tZ3YmYPHu648MQMXOCo6TDD7cpSmGIWStWqNeqmziA814QgLIxXozNsVwlPU?=
 =?us-ascii?Q?bLBAGGk9EdHKbWwcsnoJGjUg5vNsNlxbaL6mz4nPI3sVpXwmEN5ZPVJduz8Y?=
 =?us-ascii?Q?f4V6F5MOmMjMRg7pqjKWd2w0CcFe8MadU3NmzOYbvrEMdNYaG54UprqzmmWt?=
 =?us-ascii?Q?qGkpDSzLXgERNvWNztGU9bHO7dAYSYmm+EmDf9VjCFO0QZN7DetlKvqJVFDF?=
 =?us-ascii?Q?lY/7JmkAPWVTaTd2BirhxoLVM5iuxYLkPOtV+831U3bFfuXneleW1m/NC5rs?=
 =?us-ascii?Q?Y6boOxlqs+Ceo3gqh8iTfGwGMS7zGnH/4ruM+8//nSwEprPZ6wgQWDPpsJJi?=
 =?us-ascii?Q?Z/l9aH91o2PudjpSmzhcx680gkFYjeQ5l0vYR4vmevRbboIDqHomxj5prinK?=
 =?us-ascii?Q?KjVJLCFAZBpGlZp+H73jTA0BBU+trzdiJBbZWfFMc07Af01tvkaJao9S8V+l?=
 =?us-ascii?Q?2D4MYlFthK+M/Zz5a8IqNn3IlxVAuQzt6ZonXV6OWjwQN0fh3joO42Y/SXiU?=
 =?us-ascii?Q?KARRHdq5nshtpyGgYHM8ZK1ppV9ScFpHtDzZY8ezZHgjmkfOkHRbmlSaMqic?=
 =?us-ascii?Q?m1Vo5sQPFtML8W8/tpLDs7ApN3OhPqXOIvIlu4IXfkMmdE/3KbfzIcB9BN+N?=
 =?us-ascii?Q?BqhJXHwTQy5ueaPP85TcRMp91a0tEBAvEXIIw63/KMI1R/0H+zsOVrQG9zVg?=
 =?us-ascii?Q?L7yWLEw3g0oIQG5L1VWp3DGbzvsSbCmlsAohr25yisUshR49kxjvDx06CNC2?=
 =?us-ascii?Q?OeTCv67K+o3aXVaa3G6qQWANZgUO5TbCrcfR6Z4o19pZrGkq+eTYgCvtAD9g?=
 =?us-ascii?Q?n463RA1EFZ/b4BrqVsN6yHuS6kFG5MdtS/3ICipFt1GrBscYvydHosb69bSr?=
 =?us-ascii?Q?CdheqHn/WMw/HesX36W72eSCov7MN3L7sLjRoHeLz+gL+4C6/Ekpetc/dyL2?=
 =?us-ascii?Q?KcxIl5jvcNywmhsneGHOmeLJcfR4hYKPjvgC/KyTL0JwJ0Lj0Dp18fgIGFyC?=
 =?us-ascii?Q?Tt9EFqjykGPP2jsvq+CIOBQudEzsmRzgliKr2QC74sLTNoizgIfcfhjjiRD5?=
 =?us-ascii?Q?V/PlUBlq1g0+egOdDqIeyPu9Olffz/gpaFi5XxAfsONADX1YN41z3y09AnHv?=
 =?us-ascii?Q?a7cXyeMCazR4Nhzx9Z+06swUTt8LgWdJq/tOQFQIP8cnLTwBMkpPJThms08M?=
 =?us-ascii?Q?IJXpWHqXNt5Bpmb+KUWBIP6plYu3dyOnv9TW4O27V1A5dDfZ1tiB+3EHysac?=
 =?us-ascii?Q?FD+r93ZwBIJlBzAoYxTId5ddTFUJRDq+?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZPgbWIb6OT48UEK3RBsW/tImo4DRnAzsRevAVDBwbl+Mw3Ear+Pf0zQRklNQ?=
 =?us-ascii?Q?yM3oz01luMo1+Wl5mBOlJOSQffWnCOWxzqWL+wCQ/BwBXHS1iHcBRrwwZbT3?=
 =?us-ascii?Q?rclWb6FIm2gy3lyd7lYH91z42mpbVq5wswHJZiNeZhjHFLH5+Xvs+0nZ3g+O?=
 =?us-ascii?Q?4Sm2UP//VfCUnzDOuZdU5if5a+33dpfvIsGeJUKoHQ/dThvpU+z6PEGKD9r4?=
 =?us-ascii?Q?bg1RYpDcOYC+vHVpuqLGChN/KLDV7FjCgCha0jf3F7qHchEh/8x4/p9NvlHx?=
 =?us-ascii?Q?GRruowxYXLgH35/9jwLfIFlHQvijhj7v4ANgQA93gMqz29Wz3IXpDdiyDW2A?=
 =?us-ascii?Q?531/Yq4tlkAsLvhLdl+qyOdwSck+C0rHO7RBvUuGDC6NNEh15Cf6K1sB7WiL?=
 =?us-ascii?Q?uYFMnWhv5JC0qRvbICgzHlNnHaxH5taZIB4ZE0NLrEGQhpwCs1wiB/3PQzKC?=
 =?us-ascii?Q?745V+hxNUB2xH3qLOJfKCoMI+YXcipanU5QhoHwFGN7OYkllpuLLCwOsxVOC?=
 =?us-ascii?Q?kT5vmYmyCvx2fGFB2YsKRDOE6tYF8T/4AfyqhiqdcCbw9fq/OLkyqgFjgFJo?=
 =?us-ascii?Q?pADSislg9sCygYWy5R77x0JoeG0UonEREJXR3qwitOaAThqgFsr/4p9ylf+g?=
 =?us-ascii?Q?oGttdJNZHKjxr8/HK36Ms3kWtFW7lnGlX7Y6NwAi0fa4FNUlIXkU4mes/meL?=
 =?us-ascii?Q?tbYu6BUWLSuFefzVPCfXQbO2kPlrvaXSgNzJsn896yzv6Yd/zYJrBcdpPRh+?=
 =?us-ascii?Q?6gn17kbDGQx/n7vfpLRz2EE3izD1el2QVSV4QpDYhKWAuTUBJ6yHehKOqk1f?=
 =?us-ascii?Q?zeyv1jsyUd2VFbZp64DIudjXAFA9nAqG4kEchOmgzwnqFvSSNCyNK4HL47cK?=
 =?us-ascii?Q?Ldbhh7QJVqtpwH2L8SVuxPdIS+t8Efzuz0vh333xqLHjwaRyjK2lVZg23hSH?=
 =?us-ascii?Q?oy1skhkbJpdwrlsdsKC2SZFgzGqmYdlib9HJyqqx4HnLDHwSb57CdZ67Fwwz?=
 =?us-ascii?Q?jb9SRIgprq1ePBAk+fM9FNGCV5Wbh6pSqHCvcgjEZdQTqoRZscMbka+QPr4v?=
 =?us-ascii?Q?GeXYKq4j1uj9/MbIgYJRhc4TDeHEAdMh4WT8EVHyhT85JYDlXc+FkYPARvhd?=
 =?us-ascii?Q?p3TcnC/zg6x0iQJtZkENP5miUX6P1ZJY9FhQMAS4iNHDRxrtyUF+FRpsVAq2?=
 =?us-ascii?Q?hlACSeblTDAEEV0syhsazxLrjnLaYcQwcXw17RRSivmAvh989WzAb2LNe4lv?=
 =?us-ascii?Q?y4iukjMw1i9jgaOMloEWT6iCPstus+fhNc2/IUAQwrXkx0TAX2w7guvT8Hl3?=
 =?us-ascii?Q?Xz7LaoOHiHpVn77g5JZFa4HTmQuKTKIqAOh/yUrIMMRtxtYEiuxoLg9jY6FO?=
 =?us-ascii?Q?c7pVjE2VJR9dYDQaakU3BL0uBhJVcP+lDBpbnTznL0ow+zWNRWjkeWqrDz1p?=
 =?us-ascii?Q?cvmaQYxr7Sc+hs8nA0btUEomzAgb0X2vkKyFF7uBQAeCjvN7QO8/EbLv4arw?=
 =?us-ascii?Q?K6OrwNLGJVVA+0pkEOKAKzF6jxj1nUHf05sbMejbKBoc2tqMULbhJ9EqKndY?=
 =?us-ascii?Q?PfavFiDZgmLVC3j4HC0SM03EnQ4k7WwZWHgjI6PhdVyC04OWWH5XmX/QrihF?=
 =?us-ascii?Q?GGd4yq+WS095/HTgU7bvo2g=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4ead62-c36a-4c05-c6e1-08dd6158a6e7
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:25:54.4989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ffs4GTHBuGQ3JaAliPehSoS8vQkfCYlhoZq2rLdSgDOeAx7T0xKCyuSm3w2xm81ovJ6jvOfwpP7PaBGf6wwbDFal5Ol9jeUYexyqu9/sEjKmoHAkYsfoPwOJNJgXmqvP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10982
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18139

From: Paul Barker <paul.barker.ct@bp.renesas.com>

commit a9024a323af2235a6d11cbbde924c6dde8bd355b upstream.

The variable naming in the various OEN functions has been confusing. We
were passing the _pin & bit variables from rzg2l_pinctrl_pinconf_get()
and rzg2l_pinctrl_pinconf_set() as the offset & pin argument to the
oen_read() and oen_write() functions. This doesn't make sense, the first
of these isn't actually an offset and the second is not needed for
RZ/V2H but leads to confusion with the bit variable used within these
functions.

To tidy this up, instead pass the _pin variable directly to the
oen_read() and oen_write() functions with consistent naming. Then
rzg3s_read_oen() and rzg3s_write_oen() can use macros to get the port
and pin numbers it needs.

Instead of passing the pin capabilities into oen_read() and oen_write(),
check that the pin supports OEN before calling these functions.

Also, merge rzg3s_oen_is_supported() into rzg3s_pin_to_oen_bit() to give
a single translation function which returns an error if the pin doesn't
support OEN. While we're here, remove an unnecessary branch and clarify
the variable naming. Lastly, check that we are not dealing with a
dedicated pin before calling RZG2L_PIN_ID_TO_{PORT,PIN}().

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240625200316.4282-3-paul.barker.ct@bp.renes=
as.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 85 +++++++++++--------------
 1 file changed, 36 insertions(+), 49 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 5159dff565b7..6b383f2baf47 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -293,8 +293,8 @@ struct rzg2l_pinctrl_data {
 #endif
 	void (*pwpr_pfc_lock_unlock)(struct rzg2l_pinctrl *pctrl, bool lock);
 	void (*pmc_writeb)(struct rzg2l_pinctrl *pctrl, u8 val, u16 offset);
-	u32 (*oen_read)(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offset, u8 pin=
);
-	int (*oen_write)(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offset, u8 pi=
n, u8 oen);
+	u32 (*oen_read)(struct rzg2l_pinctrl *pctrl, unsigned int _pin);
+	int (*oen_write)(struct rzg2l_pinctrl *pctrl, unsigned int _pin, u8 oen);
 	int (*hw_to_bias_param)(unsigned int val);
 	int (*bias_param_to_hw)(enum pin_config_param param);
 };
@@ -999,53 +999,46 @@ static bool rzg2l_ds_is_supported(struct rzg2l_pinctr=
l *pctrl, u32 caps,
 	return false;
 }
=20
-static bool rzg3s_oen_is_supported(u32 caps, u8 pin, u8 max_pin)
+static int rzg3s_pin_to_oen_bit(struct rzg2l_pinctrl *pctrl, unsigned int =
_pin)
 {
-	if (!(caps & PIN_CFG_OEN))
-		return false;
-
-	if (pin > max_pin)
-		return false;
+	u64 *pin_data =3D pctrl->desc.pins[_pin].drv_data;
+	u8 port, pin, bit;
=20
-	return true;
-}
+	if (*pin_data & RZG2L_SINGLE_PIN)
+		return -EINVAL;
=20
-static u8 rzg3s_pin_to_oen_bit(u32 offset, u8 pin, u8 max_port)
-{
-	if (pin)
-		pin *=3D 2;
+	port =3D RZG2L_PIN_ID_TO_PORT(_pin);
+	pin =3D RZG2L_PIN_ID_TO_PIN(_pin);
+	if (pin > pctrl->data->hwcfg->oen_max_pin)
+		return -EINVAL;
=20
-	if (offset / RZG2L_PINS_PER_PORT =3D=3D max_port)
-		pin +=3D 1;
+	bit =3D pin * 2;
+	if (port =3D=3D pctrl->data->hwcfg->oen_max_port)
+		bit +=3D 1;
=20
-	return pin;
+	return bit;
 }
=20
-static u32 rzg3s_oen_read(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offse=
t, u8 pin)
+static u32 rzg3s_oen_read(struct rzg2l_pinctrl *pctrl, unsigned int _pin)
 {
-	u8 max_port =3D pctrl->data->hwcfg->oen_max_port;
-	u8 max_pin =3D pctrl->data->hwcfg->oen_max_pin;
-	u8 bit;
-
-	if (!rzg3s_oen_is_supported(caps, pin, max_pin))
-		return 0;
+	int bit;
=20
-	bit =3D rzg3s_pin_to_oen_bit(offset, pin, max_port);
+	bit =3D rzg3s_pin_to_oen_bit(pctrl, _pin);
+	if (bit < 0)
+		return bit;
=20
 	return !(readb(pctrl->base + ETH_MODE) & BIT(bit));
 }
=20
-static int rzg3s_oen_write(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offs=
et, u8 pin, u8 oen)
+static int rzg3s_oen_write(struct rzg2l_pinctrl *pctrl, unsigned int _pin,=
 u8 oen)
 {
-	u8 max_port =3D pctrl->data->hwcfg->oen_max_port;
-	u8 max_pin =3D pctrl->data->hwcfg->oen_max_pin;
 	unsigned long flags;
-	u8 val, bit;
-
-	if (!rzg3s_oen_is_supported(caps, pin, max_pin))
-		return -EINVAL;
+	int bit;
+	u8 val;
=20
-	bit =3D rzg3s_pin_to_oen_bit(offset, pin, max_port);
+	bit =3D rzg3s_pin_to_oen_bit(pctrl, _pin);
+	if (bit < 0)
+		return bit;
=20
 	spin_lock_irqsave(&pctrl->lock, flags);
 	val =3D readb(pctrl->base + ETH_MODE);
@@ -1124,12 +1117,12 @@ static int rzv2h_bias_param_to_hw(enum pin_config_p=
aram param)
 	return -EINVAL;
 }
=20
-static u8 rzv2h_pin_to_oen_bit(struct rzg2l_pinctrl *pctrl, u32 offset)
+static u8 rzv2h_pin_to_oen_bit(struct rzg2l_pinctrl *pctrl, unsigned int _=
pin)
 {
 	static const char * const pin_names[] =3D { "ET0_TXC_TXCLK", "ET1_TXC_TXC=
LK",
 						  "XSPI0_RESET0N", "XSPI0_CS0N",
 						  "XSPI0_CKN", "XSPI0_CKP" };
-	const struct pinctrl_pin_desc *pin_desc =3D &pctrl->desc.pins[offset];
+	const struct pinctrl_pin_desc *pin_desc =3D &pctrl->desc.pins[_pin];
 	unsigned int i;
=20
 	for (i =3D 0; i < ARRAY_SIZE(pin_names); i++) {
@@ -1141,19 +1134,16 @@ static u8 rzv2h_pin_to_oen_bit(struct rzg2l_pinctrl=
 *pctrl, u32 offset)
 	return 0;
 }
=20
-static u32 rzv2h_oen_read(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offse=
t, u8 pin)
+static u32 rzv2h_oen_read(struct rzg2l_pinctrl *pctrl, unsigned int _pin)
 {
 	u8 bit;
=20
-	if (!(caps & PIN_CFG_OEN))
-		return 0;
-
-	bit =3D rzv2h_pin_to_oen_bit(pctrl, offset);
+	bit =3D rzv2h_pin_to_oen_bit(pctrl, _pin);
=20
 	return !(readb(pctrl->base + PFC_OEN) & BIT(bit));
 }
=20
-static int rzv2h_oen_write(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offs=
et, u8 pin, u8 oen)
+static int rzv2h_oen_write(struct rzg2l_pinctrl *pctrl, unsigned int _pin,=
 u8 oen)
 {
 	const struct rzg2l_hwcfg *hwcfg =3D pctrl->data->hwcfg;
 	const struct rzg2l_register_offsets *regs =3D &hwcfg->regs;
@@ -1161,10 +1151,7 @@ static int rzv2h_oen_write(struct rzg2l_pinctrl *pct=
rl, u32 caps, u32 offset, u8
 	u8 val, bit;
 	u8 pwpr;
=20
-	if (!(caps & PIN_CFG_OEN))
-		return -EINVAL;
-
-	bit =3D rzv2h_pin_to_oen_bit(pctrl, offset);
+	bit =3D rzv2h_pin_to_oen_bit(pctrl, _pin);
 	spin_lock_irqsave(&pctrl->lock, flags);
 	val =3D readb(pctrl->base + PFC_OEN);
 	if (oen)
@@ -1220,9 +1207,9 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_d=
ev *pctldev,
 		break;
=20
 	case PIN_CONFIG_OUTPUT_ENABLE:
-		if (!pctrl->data->oen_read)
+		if (!pctrl->data->oen_read || !(cfg & PIN_CFG_OEN))
 			return -EOPNOTSUPP;
-		arg =3D pctrl->data->oen_read(pctrl, cfg, _pin, bit);
+		arg =3D pctrl->data->oen_read(pctrl, _pin);
 		if (!arg)
 			return -EINVAL;
 		break;
@@ -1361,9 +1348,9 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_d=
ev *pctldev,
=20
 		case PIN_CONFIG_OUTPUT_ENABLE:
 			arg =3D pinconf_to_config_argument(_configs[i]);
-			if (!pctrl->data->oen_write)
+			if (!pctrl->data->oen_write || !(cfg & PIN_CFG_OEN))
 				return -EOPNOTSUPP;
-			ret =3D pctrl->data->oen_write(pctrl, cfg, _pin, bit, !!arg);
+			ret =3D pctrl->data->oen_write(pctrl, _pin, !!arg);
 			if (ret)
 				return ret;
 			break;
--=20
2.43.0


