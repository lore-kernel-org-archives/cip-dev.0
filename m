Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD524C3600B
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 11:07:51 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.33])
 by mx.groups.io with SMTP id smtpd.web11.49170.1743419267975217209
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 04:07:48 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=hlTPMd+7;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.33, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GAc95BsV8yPmE+IY+bAtr2OtZhj5QGQFgorxG74bZp1+LoyXG4hcIBEviRd0fDyY5mHt8b9yuiO6DpiYTfiDI5s2w4KSs6joTZxhPwDGB2PsEbZ/Z4x6liT+J/OuHNOUHzaNPEbWJRelgQjN79d/O/PmECVjtPnJ8xVTn9SSV9iUJ+1t705MC3XulDzAtT6k0Nxrhu5lVwZmVrMSrcdpE0uq6JYnECCbBv5bba2Z3v8PctfTknSnDDDljma1oX7Ao+ozifFk3RW6d+m3840cFvKYM7HvrXxnKxjkPoK6XNQta2CtFXs3p/bXoOZKHoaNOwrTZmsqtJio7qpy9iAciA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4u2+e48EXFTeCnJ2mx/s0/dK1NnMKGuAUC5iG+esnQw=;
 b=WlQn2faGd1Uw1CpSNysuoPC+KeYZOd4MEH6jWXaX3hgvtKQWTea6P1gN95BoKdXEyzWhUNuO6idDCnYzmuDcmK7ulOUCPKicKqVFUvw8mSi/s+4JrtOoCuGT5/kTtq3CYve4CresLAt5pMVETGBq88aF2iUDnr5oSLa8B3C+I/URny5Dn9rScYcdNWaNM5dD4pdEkUX+wQo0Z6R0ABxKxMnoN2DGO6lfavrh6MdjF/6I8cQXgiuhMtub1/ZSkzKRCJzoHhwTo9Fa67H/FslrfxZZZ4PQB8Mvm4+P3RNrVU7N1XbMqUuV57r1oa0FJDMa7BhN0ymvB01g7JwPL9E8LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4u2+e48EXFTeCnJ2mx/s0/dK1NnMKGuAUC5iG+esnQw=;
 b=hlTPMd+7HveLFxppsxR8wfoIJvYix6YwYYHK2gwalvQXSN9cFapPIu9BWVnf3sRUt8h5/9qrztdhFCRWdMlwCZpImtuqv+tDCvraOeu/xIdnzJbm6YMNpTpjHGxUkC/I8B6fKP3XNOqwZsrq4y4JvfXZkYd1Mf7L09mdnzDqiw0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS7PR01MB15065.jpnprd01.prod.outlook.com (2603:1096:604:370::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.38; Mon, 31 Mar
 2025 11:07:46 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 11:07:46 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 09/13] pinctrl: renesas: rzg2l: Use gpiochip_populate_parent_fwspec_twocell helper
Date: Mon, 31 Mar 2025 13:06:55 +0200
Message-ID: <20250331110659.252237-10-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331110659.252237-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250331110659.252237-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::20) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS7PR01MB15065:EE_
X-MS-Office365-Filtering-Correlation-Id: e550956a-7bdf-43d7-ae5c-08dd70444413
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?TjF+Rq6738HU3mvRXdA9VLyhWll0/ZsA+zFwXGwnBUt41zj4vu4/+/5QSJKq?=
 =?us-ascii?Q?Wk8z7/P2dxMW8sBcIig5iS78D2HGIYSTsUzyLJmly5yEp8pu516A7Xs2NId7?=
 =?us-ascii?Q?gcSz8Zfway6uXJymGQzUw6uE1Oh/Ym4xYggJo6W3DRAwZyFmdS3Rh1f688xj?=
 =?us-ascii?Q?c2V+aqAkvwLqBjyx2tVHufPP6SPKiVeLyWuclWRn4DM8zQAhjULu1U8N818l?=
 =?us-ascii?Q?/AKHl8PlvklA6Cr1fV+PVpYaknEgQlBXhso183dGuWr+08fsoo3SshM9TXPE?=
 =?us-ascii?Q?nqg2sIUKBgWRBKb9/GUHT4dnCvi59pC+Ggfui/TT6Vp4GEhYQCogExo+JO1Y?=
 =?us-ascii?Q?PJUYYDV+tbAqnQFn48N2+lXwfA8FpwySEhRLJbwtyKN+SpKKb9NHJiUQ93id?=
 =?us-ascii?Q?oAgtpzuoP7BXCZPXO+OZZamrCuzZvlGaRMCIosu6CN0Ad0dYq6J0DnPww8Wh?=
 =?us-ascii?Q?Lbip8VJXu8bjGIVZHM4wg4BfgYQlViQ4+j/cNhlboJkR47w+wi1d1PR65fjS?=
 =?us-ascii?Q?8DVcI+7YMsJqiW7yDSTZW3iMYaZvGJTEyhmjVoJdyRqekEKQc8ofNP9diLtk?=
 =?us-ascii?Q?xf5u6OGuhvK6TJfbmM6LT5VKhPNCWLBPvrDDATUOZ6Vx1FawQirkLya309Wo?=
 =?us-ascii?Q?XUpUMFzgmDBW61uVXh7oLJM+JNDByFscKCZtoliQoj56sphUe/FKeEHy8NqU?=
 =?us-ascii?Q?VPeKoMbJeHZEuY/M0E3VDnWIA/aVqoa5ih0H0h5mdDDTuLJtBt1eMrFxjdJc?=
 =?us-ascii?Q?0HBQKpUxOuPqKjKJoK3AC9jOex9GimC+Sp/aTZR+u53b2UasZRlsJ5Zt2/gj?=
 =?us-ascii?Q?2EC8tBGCUM3BMj7hewmZyrFIwJqKdUflwhFRN8LSfdlrS9CJq0TbWcZCWPyD?=
 =?us-ascii?Q?8/hVlB7OYyT5eOWD19ihG5lkItQrmiK35GxQ4tehNGAe0cjDAXmDy69lCRwz?=
 =?us-ascii?Q?kT+n8HO5VwaRSVrhb6xW3ZYNxPF8EAoS+iSFq7syDlTKrfEoPArJJOo1cb6g?=
 =?us-ascii?Q?TxCf0cljH5cCC07CMT/caDBiBpe6K6ggD+cSdN0tYzWxuk5QIORXjh/vAvg6?=
 =?us-ascii?Q?xK17C0vMOEh7NykXSxa09K2Y3/QsqVYjuqQQXKqoeX9K6L2MAwkpKyJKh3tr?=
 =?us-ascii?Q?ULtlf4T9aJ0TZ5eVUi2Xdmx8JYZJjvuuTK9+dPt/WvVzsf9Y+dAYnTF+zwt5?=
 =?us-ascii?Q?fZP/JAZF6HuuXGKeCY97ArjsRoIQzZuvqHUuOXOT4rC+Iq0lR7QO1Zw0sVH/?=
 =?us-ascii?Q?tCx44FnlMCJwPMD0BoOz5Te+5r8yw7BJiOPUAv7b6Jc8eZvULxehxPrC5Q+x?=
 =?us-ascii?Q?1d+yAFfqIiXXm1x1l3jiXDb39z9CvZ17eD8+W8pY2mm2NHR8g8mWzL0I/e1A?=
 =?us-ascii?Q?v465uLpF/soiQOmjJ00TdzTurI7PmACauYRTzmsYFQwtaqCcJNrW6SrwPVIs?=
 =?us-ascii?Q?wYJRJ3G6geP3K27MfK4hlaYxl5NWq4Qo?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?mBBtR5luPUwBdLeON/t2e1h0plVaqlaUPYDGoMjAtZNWIYKyXXcc7f10sIFr?=
 =?us-ascii?Q?5gEDvUsYInbrwrwOkNGrvLgmKrzt0/vj181jvlWyEmrzR5/YVguTJLovuggm?=
 =?us-ascii?Q?lzYCh3L0Mowr7at2pjpEL+W0LDcsxY1Ge+YOfIifbe//u5GLjMTLl5cSXYIG?=
 =?us-ascii?Q?bgOzbUvv93xv2C+2+m++7+crS4dv9T9SVt6U3O0gODl1hyPOZiNcdnHQ4yEL?=
 =?us-ascii?Q?yaDcPPhcKzkhtIimLY2P0piwp75stuTDX7actzwScrMHnVSEmTOBmDI8l95z?=
 =?us-ascii?Q?Idbmzim9FDANfpV9tzw+uHXRj466WGxEXFxKrPeAsNb0odlwBxvNHQfB/6Dg?=
 =?us-ascii?Q?Pzys2VyUc2raYg+JalrJt9t+UeqL0UETQ6kPe8ISYv2BxLfAiLYLfDz2DGCg?=
 =?us-ascii?Q?eLlKIl3mNYqmqpIEw/o7AZMRfl2XoSJpwW86ADLEsY2Udqrl4zgomHEzu46D?=
 =?us-ascii?Q?32X9UetbbOpMUJB1/lB0Rd9RnVyeiL2i0/gXOBLj14iOrXgwn6d8cbWEHri6?=
 =?us-ascii?Q?crwluA0Y1mpL8ewOTiY/wfEYoe6cRX81wUdHnSon7rikP15kpc07zxLlIsmp?=
 =?us-ascii?Q?mRFcytpnlVp6u8T79s8WbqUR7KLX9hpAj5kz/yhtx+o94CzhqHmNPjLAFFFR?=
 =?us-ascii?Q?HefJwpdaKTLhUWjMM38oXdstG5+Ap1gh1Jll0h+mk9qKfsZanfyeUkLmjZJ/?=
 =?us-ascii?Q?uJe307biTGXNHJsMKX9a3D9mkdLe3MFJfOnLfltPKorwKnxKGF/7wq4tBzQK?=
 =?us-ascii?Q?DCXJN7urdvUFZZI4P+Mk+jqheRpvTkVQDtIqW6afQN1aIiSk3NwqXX0klUtI?=
 =?us-ascii?Q?tgEYdW/UXsoyyWcaKvXXkm69HCB9/NzbTNJ5WDLnEtn9g++Jrl5xYmN2qX7j?=
 =?us-ascii?Q?Rp7WFcRm+giE7z7x1mi57Rcq6G/oFnvlBVDDdYeBQ6Zdy5xSmKmE2XhuCq3K?=
 =?us-ascii?Q?C94Ka+bFuyp2mZp024QxRALytcNdeegp9M17x9RmoE/TJwyUhXkI0JB4goId?=
 =?us-ascii?Q?JQDGnAZGs+KsxH4ykNDVtHy7zPVIPQYr6Dh9G6TMbGKSnfjNog/t/sdLCC/b?=
 =?us-ascii?Q?/fmA9OErdxojHSx98GA62oJC/MqbIvUMMrU0iyGgwt2ojaREIc5H57J6lsQO?=
 =?us-ascii?Q?27pONMjA3/bTYxoSVV/FdC9O4Ux7icoubC/qFIwFYXWokKsBU7CINMirTEc6?=
 =?us-ascii?Q?rmDvyFUebHEC32bQxq+YPtXci82Q8Ew+6Qx0PEP1lXtt+K17k/4alaj9VRxv?=
 =?us-ascii?Q?TgM1tGaceatQ8VUz1w6haSqDmNNtm9vOFM4yOKDtPVZz0KZnY7+4v/QSSqsT?=
 =?us-ascii?Q?a0ftz5iGoPY+rbEp4y8Gjbsg3QILUvGvTH2M1jvYvIis9UqLPa4hMpA4CwbF?=
 =?us-ascii?Q?Tpu1v3gdYCVcfCPKPVeht99CqWeXuxl5+9ru/M6wbB/XMal0Qoq/t4iG+9j0?=
 =?us-ascii?Q?wqFedzg3mBemqh+les9MtLb2rx8EZzq4IsmbT1Ghtq2ar03+npsgzznzyB+A?=
 =?us-ascii?Q?uNEgwCfIoHlVT6s+L9RzFSpSB6GBvSSHm5fvBRYSR/8RTqj3vQOVHldfpuiQ?=
 =?us-ascii?Q?BfkOj3kjQTI4TtAs2nyupkObjjtuWsTuF/udlZLBeFTVNCBlRgkcRstlKJfs?=
 =?us-ascii?Q?/7UwuC+3I56TfmD1VA/VE7E=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e550956a-7bdf-43d7-ae5c-08dd70444413
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 11:07:46.1828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Labunvw8PyI8eopv6qbjlgrPCp+9CZpi0IZYA30s8w/w++tj19EA3aIsLy/Byhpw3JHj3XC7vh8NGAmYvVgSAqJBFK0d6jjpB7s7aactCsZ7/L4TcYHu9J7tgkFDObEx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB15065
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 11:07:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18441

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit f407af78c8d3b6035f81152b15ad67063f42514e upstream.

Because rzg2l_gpio_populate_parent_fwspec() and
gpiochip_populate_parent_fwspec_twocell() are identical.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241017113942.139712-3-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 802c4795770a0..b06a6a2542cbb 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -2435,21 +2435,6 @@ static int rzg2l_gpio_child_to_parent_hwirq(struct g=
pio_chip *gc,
 	return ret;
 }
=20
-static int rzg2l_gpio_populate_parent_fwspec(struct gpio_chip *chip,
-					     union gpio_irq_fwspec *gfwspec,
-					     unsigned int parent_hwirq,
-					     unsigned int parent_type)
-{
-	struct irq_fwspec *fwspec =3D &gfwspec->fwspec;
-
-	fwspec->fwnode =3D chip->irq.parent_domain->fwnode;
-	fwspec->param_count =3D 2;
-	fwspec->param[0] =3D parent_hwirq;
-	fwspec->param[1] =3D parent_type;
-
-	return 0;
-}
-
 static void rzg2l_gpio_irq_restore(struct rzg2l_pinctrl *pctrl)
 {
 	struct irq_domain *domain =3D pctrl->gpio_chip.irq.domain;
@@ -2651,7 +2636,7 @@ static int rzg2l_gpio_register(struct rzg2l_pinctrl *=
pctrl)
 	girq->fwnode =3D dev_fwnode(pctrl->dev);
 	girq->parent_domain =3D parent_domain;
 	girq->child_to_parent_hwirq =3D rzg2l_gpio_child_to_parent_hwirq;
-	girq->populate_parent_alloc_arg =3D rzg2l_gpio_populate_parent_fwspec;
+	girq->populate_parent_alloc_arg =3D gpiochip_populate_parent_fwspec_twoce=
ll;
 	girq->child_irq_domain_ops.free =3D rzg2l_gpio_irq_domain_free;
 	girq->init_valid_mask =3D rzg2l_init_irq_valid_mask;
=20
--=20
2.43.0


