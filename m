Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA92C36014
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:46:51 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.4])
 by mx.groups.io with SMTP id smtpd.web10.49076.1743418008864182298
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:46:49 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=riKaFEMP;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.4, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dd2eDO4w8dGoKKOGSE2E+x9CW1D2aiJxZX9huFGXsVwpn6ef6m3PNo04NKwrxT3S5+/99yUc1SawJ7PhfJFIchEhjZlqJVBf/mgadthcY1GU/E6UX9PM7jT64U+xmz5qm+zSbGSaKbX7HNa/BdrhGt5TfgQ4hDIgnGRPnHM5MM85rbQMiSYnjHjhHqICH34fwrWWK4X/6QZenbRN5c+vApk6YCF5QqY2LRPP8z6HXL8goGFd54157UjUmpthDzKvcgI9zKoU7NAFCgF5IN7AMb0JzxSyEt7cDnqHaAQxIiiAQDd99jA9VAB2q3Rj8cd9EJf13IcAxQ4iYshty7Rx5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uy1q9lLwkerROK7WjiuSlgl1PMPzhiwlEiU1ADVopwA=;
 b=kYbfwvGo8idLpaq9WVD4dEM3/xudsoFKWlTWA8Jyr1nghcOGunInk32H4mzy7JSb0ZzY+pdwEdb1geZYElP1+8SqkldND5OxkU0KqAmNgUSiehFLu3Oqt2xMUF12ekbDYSVmMWEE2kfuTwnTIhvcCKa1xLBWBYn27lvJDuc+OZeD8TU1S84aRZzS4AVMVGQ1IXp30S0SqSxyjZSdMLJ+LM8gtQC0mhzzAZsM9aY3mG3U3Psbgf1G6su6olTsy6DhJKKQLrQxnJUW4NK7CqQR7td9ak9njg1PkKod6MNmHB8ZJaZCyuN9T3lwoUUq+Zl+2AOsqgI7tMaEB+i7+SqvOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uy1q9lLwkerROK7WjiuSlgl1PMPzhiwlEiU1ADVopwA=;
 b=riKaFEMP9fBsZBEzM35ob5cOKGwTh0TOhG+15+zEqaquiJSlV5IAY/xCWUqyVi005i2A2s/R9VGHN987Ds5WX1Hb17jn0R+dmV7KoCzU3ie4O6Wz7gjxCtnjPSmVL6hNMu7nWrCWqa2Y0qAdqhXyCqWlxs7zphC4R7PgxfnSTCw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY7PR01MB13744.jpnprd01.prod.outlook.com (2603:1096:405:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.33; Mon, 31 Mar
 2025 10:46:46 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:46:46 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 25/43] pinctrl: renesas: rzg2l: Clean up and refactor OEN read/write functions
Date: Mon, 31 Mar 2025 12:44:56 +0200
Message-ID: <20250331104514.79090-26-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 696a6fa1-64a3-4d72-f6c7-08dd704154ed
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?e9Z0aBtqB9O8XIA8Cl8klyZnxg3V6yFCcSdUD0Nkx0T5/00aE5l9BvGtPvje?=
 =?us-ascii?Q?UjCFSPNGC6MYqBWH6tBFRTBW/rOfKrXLsuSLNUydbg1+6hdbD7hXeSvXc84D?=
 =?us-ascii?Q?YK11ymePHaqwUqHdDebsDgIrMhA+DdMIIk1EMucyXJgjrIg4Jg3p6TqJQ8Fo?=
 =?us-ascii?Q?XnPyuk1j/0/TxDVIOLKfdEF8BK2NswV8vYRaldsuVuUemzsHeoxGezS/9jHW?=
 =?us-ascii?Q?sf8heffES0hw8L7DB9Wq10birJh6cjXU/fVoiCa3gO4kwJ6ow9xP42GrZKXr?=
 =?us-ascii?Q?5I55+qom0ojAtFj8nNg3dWs6zp4n5xItSSMWdGM3EhYPcf+qAVYP/HkJL/5B?=
 =?us-ascii?Q?8l1RsLnT8yT6LanjiLDQQRA3nmemT4DUgnOWSveiQR6OINI+NHHG/k7xpkxE?=
 =?us-ascii?Q?/kcpqif3mmCTeA5UrkInF+HnWKsDYXR9QfFb2fg6QkLjil/FY4mVJlwh/YMy?=
 =?us-ascii?Q?Bo1boxuvxBZpzUh8AxuGifpIpw+osmFPRZsNy3OHcj+TgboF666XDK00koH8?=
 =?us-ascii?Q?6ReD0OCxGpGQsI5l1i56pYK8c2WwJE8TD7vp8c5owCmZzm2oTUfQcWWoW48v?=
 =?us-ascii?Q?GJTWdFSM34eR5yJexBmtewNUyOfSQsZLw6Hh/P3lcPN7aDYhlVzcEeJODxCJ?=
 =?us-ascii?Q?z2jP2PCz8Uk0Zhf+OfN+e86TQkRwbYoUAUqlU3Bbz6sICAHZrzholsnypliz?=
 =?us-ascii?Q?HjwsA2l4+1yi0MgK9ahuxFsvjsUYnwa92NbjPqnumIBJQc1Bqf/7AanpFUwJ?=
 =?us-ascii?Q?5PsTOiN4XqYNa6JuTbtwtbZPPUdI5y7m2+n9nJ+zxkfRVBi+rAUm/RRQfWzR?=
 =?us-ascii?Q?C43BL2Vcdc7gv3GJaU6aMrrDk1cE6pZybMxwLm2BNA2K8DIBhDCw+CzzA6H0?=
 =?us-ascii?Q?6xyZzAH3P5I2ZZOVSH4KaeGNdpfdk9N1E9W0Zdqmx2sU/7BkxkfNsWrwB6LI?=
 =?us-ascii?Q?vfpUMBuuhuG2vm0lENchomrhk7bqr1HVTwaux6aaaoGE1DsSyvyxeaxfRVyR?=
 =?us-ascii?Q?lAULYO9Yba2yTHXS6dbxzHkjm0aGI/yuuJF8CizI7yYA9OsgBOpqZZVeSURc?=
 =?us-ascii?Q?pc9RSyraAb1YGBO/hxcj38QU5EX74mFlAstCiYBZGWww6Kyct60nG44eQ0H7?=
 =?us-ascii?Q?Q7UndFLdvKpoZ2bYkJUlUZq7sBuDIT4B1Z7TVmNwtqoPsiFEgtGXuzKCdO7H?=
 =?us-ascii?Q?YlzFNtwveEdfF3sThNUvkyBLhqC7HJqkXnLZys55DpjWekj6U+ziJx3ENaDO?=
 =?us-ascii?Q?xuC6fNISMsTKgVHxguOC0pjibtiB1SU0Mw8cG5TXopi3HZMOaBBcTAon2Anm?=
 =?us-ascii?Q?i53CqlCodxDHB4TdL5Y+zMxCai8ZnIcW8xQ4oyzMqXSuhmmDjlxizO2ILXwe?=
 =?us-ascii?Q?/ZoAh1UseJEFyTiBdGIzs6Tb9FKrYvttPalEhi4OJQ9ZwO30QjMHcPT8XgU4?=
 =?us-ascii?Q?2JPMmPzkB0NO1I8LJTUC6FlP9dSzmMRQ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WUMUdIhVm5+iL3eyN/ahvajShgmYaJd16cuUOfWdp94AGeQIMIy1/f3FFfr5?=
 =?us-ascii?Q?wkqibaY4lNfZ9dqCwgd/KuHyddcrSQOF/s/EkfcNgcSSXgtB+7fXdw7/kHtJ?=
 =?us-ascii?Q?BoqosvUcapXFw+4GCCFhjf+uFhDmm5yb9uedz49nJ026Ea5jBEiC61ihyGpq?=
 =?us-ascii?Q?lKzQE5gRYMPpbg8cD2qCK3lYRK+WtJxAZWTalMbeiGgIdyMQNUgf7wVm9guy?=
 =?us-ascii?Q?53iZ0R7COyp1kuHzzT+9ZoXQZ2vSCVsqvc2Le9I2K0y5IfhyJF/ZS+A2O32B?=
 =?us-ascii?Q?SrrlanFKaw6Bdez8ey4UE1+YIV+c2YnoRlbpXVqkYlgr+k1Oei0+Fz26b5wm?=
 =?us-ascii?Q?P4T4Q8Z9T+982RPThvF1TRMrVIbnnnW25zGjx634C2bRHXL37s/vxzASraO9?=
 =?us-ascii?Q?pxKCRHR3e/rrINLFxQWXYx5lCcVlTbJ9NZP6HPvePDDdRNxKZtBOONbwZzlq?=
 =?us-ascii?Q?DVHvOh1upd4R78F46aU1x19dfMC5321Znii1lP2nK5jpMwRmO0U7wzNO+abH?=
 =?us-ascii?Q?+NHj9v0xnX9k/guCu8sU6muRiICxaRYP1lU+0EiSQ1GRBE6JSw/cPkjBuVlQ?=
 =?us-ascii?Q?aojnsWor+lgJP376Vv19LlW61spkG0uu+BzVMkmgDsxdYxJrxMgPS5UTcLVE?=
 =?us-ascii?Q?NXULO4VymTxzsYNlhbE6sZEN5W29UzUJokUA/jpAg3TBGFPC+g7wJ13j+/O9?=
 =?us-ascii?Q?6FDFqKmtmQVydiHgGh/sg5zTNwVlVtB2mB3UbZNF0vJ81F0UstqIDQfQ6XoP?=
 =?us-ascii?Q?HbW2BZGP9LrGFmOJFTi0alF6geQgNlrv12/SeMzL2ouFE13Bjp5BxPaT3Yp3?=
 =?us-ascii?Q?uqV6/s7PYV47JpgkppogaOk76WGz15BLQsQKzO0NJvraCvqtryV0vmkqOHUE?=
 =?us-ascii?Q?e4sJw0kjUJ6enetwuFCvSiOdZDRbp2lTrWuZQaxXMSw4umr/3k7hHuhUbxpY?=
 =?us-ascii?Q?pHLQFz+C14aUH9hg56aW+c9VjGMMBlPPspudUv7nNBmHnk9QMhwxvgfNokNS?=
 =?us-ascii?Q?yfhssEB78dhsCUQqOiH9SdA3Fr5YTHGyPZz2pedRycXkDPhiGCy2ssak4zJa?=
 =?us-ascii?Q?N9ZR7yEVDgxcCzukiAPn6r6d/KSvKnNG2z+4snqvd2tRr+WfcLkXxjJi/XMJ?=
 =?us-ascii?Q?9Q1u8UtzA8bLis18wMYsaqYsS0i0OZ3/7Ic0jYp34suamt7wbkJ/wYXEsTbY?=
 =?us-ascii?Q?8EN4oCr7Yd1vTj5o3GuCTZ2SQzUxuT6YyfGsF3zlqKrEfn5awX+GFKgmvNrl?=
 =?us-ascii?Q?plthZHRLje30uEEpH2DcVhxjMjNMEXcE5zFVXWNXwm1PHgKhlYPBgqO0oUFz?=
 =?us-ascii?Q?e/6fgWpZZqo1RvcKwjgYDSjAqaQYsx01CAN2TxD7ccLM/tomQ9899NC17VfL?=
 =?us-ascii?Q?KS8J/7Kh/HGxOk67Bbw6/M20l5DlBi1z7bBhX3QydxC42GphKUxzM7GMME3b?=
 =?us-ascii?Q?4DHb/y8BhWwh2kjJcOSCkLWlDE/unfhQrxT8aHkouYBAmDFgXf2lcOYv+irb?=
 =?us-ascii?Q?TUd+R1yfSlQg6nqGZwcP0t1TkEz1ahJktdhPebkeDQuWZqZF5l3V16A/yof5?=
 =?us-ascii?Q?YT/C+/LMkhnk4/DQW6GrR84N2Q51jU0kbbmcWpQ/IdhKCUnUSv+paKV9e0u7?=
 =?us-ascii?Q?OBab37GTJSi9F7QyalRxZf0=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 696a6fa1-64a3-4d72-f6c7-08dd704154ed
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:46:45.9842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rF1BBjs2IbSByI1oKd0jf7UhnZKGG0GqbSGyiQRSIDvb8M09ncuiAyozEc4iOPUc0vL39bF5X5ItBi7IvK2krvLsumaYUKBA2QgM/CkJ4J1rSokKQwj9U0OcUPQOdk8+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13744
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:46:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18413

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
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 85 +++++++++++--------------
 1 file changed, 36 insertions(+), 49 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 5159dff565b74..6b383f2baf478 100644
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


