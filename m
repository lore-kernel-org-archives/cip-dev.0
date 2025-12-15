Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831B4D59D99
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 09:46:13 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.12])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44983.1765791967216350641
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Dec 2025 01:46:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=vrHhvdzu;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.12, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVRL6QiYI/iqoyGSxKCnSzPz+CS+dwJ3pN+hV3e+ZweuiuV1uVAh7rplFT7589Q3ejB2S1gDkGcytSgzM+qcjhnme1gvxWLABf5JHC5KyEd0O0pNdEQD22foM+WOSvK0cI5lHcyjxD2bvEUQLy7D1XWMwYnBhIUMnySqbnzx4OwM2xHpeGTocAkxcdu8Q7Lb6DYG0DA9dRY57W+RIuIS1W8eKsZ72WOGC/C8ybHQ5mC4OgIRXxbBGSpWHH/ZGaGq/najM0ZpBsnSJ1Dtn6fgoHzHnMrKPFurRrb4UUbBcA2d65r9+7B3JZkNW4qYjcsGaD8VZFCX/kD2nWV5CvWAGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pO/AkQdvjnw/KSdUf3Sy0rLK8oWhhzun3sk1YbpB7dQ=;
 b=EcxzGteZKhZyaCy2S/83/BBc30x06FtLQZ5vuS+32XWwtTBfCIHEwMnji3objw1qcEAw/OAW1+hcAGum+xjzOeQ03I3napHv4Qx3915qeUYVl7QtbQnab/tN8RgBEyNXUr56qnjngkAXVxml0FSeU8z/L0f7ovX4MUM1au507ivzAaFm0GulYhrmqzGxDcp6cglygtFXBWE+872jHMLfn0sv/hCArBGcmvDwV35uel1lqL1rBE5NN+kqVSBLybIu1wijRstldhFZ+iBbxaLgHMq743tQPcWXNRuB3bPGNk4oUvzaODsv9zqEkHchwgDQggUb8ebYf0eqsd1ZbgBrBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pO/AkQdvjnw/KSdUf3Sy0rLK8oWhhzun3sk1YbpB7dQ=;
 b=vrHhvdzu16RvzHRMcE3h1XPv1yX/I0+UCLctRH0ZZVADvsgS/JswwEyL4Tga0sYIXYKnLvRHWphHLmJajsCzcKOEopqZoHOxQ2DijsnHDKb3Mu2n2tQejWf2KxS0nlDjBxjs4lbmMg7uyThoD+POhpQPfyPOC6C0XkjCBqk2Q/U=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB11729.jpnprd01.prod.outlook.com (2603:1096:604:242::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Mon, 15 Dec
 2025 09:46:04 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9434.001; Mon, 15 Dec 2025
 09:46:04 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: biju.das.au <biju.das.au@gmail.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, Pavel Machek <pavel@denx.de>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 1/3] mmc: tmio: Add 64-bit read/write support
 for SD_BUF0 in polling mode
Thread-Topic: [PATCH 6.1.y-cip 1/3] mmc: tmio: Add 64-bit read/write support
 for SD_BUF0 in polling mode
Thread-Index: AQHcbPKqX8LQDYRlrU2NmFw7W0ZMzrUidVSQ
Date: Mon, 15 Dec 2025 09:46:04 +0000
Message-ID: 
 <TY3PR01MB113465A87B95424ABA69A612A86ADA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251214121034.4352-1-biju.das.jz@bp.renesas.com>
 <20251214121034.4352-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251214121034.4352-2-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS7PR01MB11729:EE_
x-ms-office365-filtering-correlation-id: 7caf5bad-fa91-4380-743f-08de3bbec3bd
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?wQzf1aX3MAK2ZTa5UNRM2QTHo5GAKdvUj0esUOsHXq4Cno2leqCMR5095AlC?=
 =?us-ascii?Q?QTwvYTnLyllsiwroYND3nlM8znAHcMGrY5QJoCnG81sj6ECzkSPRLo/2jvhQ?=
 =?us-ascii?Q?rtq5e6boBh9o1kj16oH7seGJmrWYG006+Ek1CfRZ/K344mMpffTRwx35JOVJ?=
 =?us-ascii?Q?+9NU4FGx9mmdNf7YlK81joTH1adVlfQCKOYKDVdkoQZIR0UUgzlbBPmi2jN+?=
 =?us-ascii?Q?Hg0Vw4JdcflyubAj8Bocfd1yd3Gtepimb5+nqZNiz4sVC1Bs7dtJAZEOYuV9?=
 =?us-ascii?Q?/RKuUr0uo66/OyUzahUktfmUpad6XOS40stgUKFv4ujNs6Ejj096keVZSsCR?=
 =?us-ascii?Q?Ea8zTsDGKatSZEk1Bo4rQ3lIIqdmpKaYtQwZN9wHOykVOjeGBS9YmG9tjT3A?=
 =?us-ascii?Q?5b/1QjVT2qWrZ+Q6U4OOwpfFkONfh2HX0HZN5ti0PHMfJvUwecjhq+hqHtLX?=
 =?us-ascii?Q?hhMPSCu9B9RZz+N6XQPtGzlqxxW0+N+u2q4c//j7NjfbByAR/DB5pyCAlLD8?=
 =?us-ascii?Q?G0L8tx8Z2RUIHBSGPc+4UWV62DHq4wdBdTUeEx3+vcXr+FzP7JKsDomNnUiE?=
 =?us-ascii?Q?hgmflITTcTA9JitvgtGh24L5QOawD7LUKlQKRtwXm09EDxoNBI62TzEqE12p?=
 =?us-ascii?Q?esmdoSW2LgqgEyGc6p6RMaRU51veZPZqtGPKf/HUnNb3oCEf2JEF8X5Zs8/S?=
 =?us-ascii?Q?sY7lk8VWoyHPq0s34z0NBOaHZRohsD/Pv0/285ti7TBuw+wbAwlKGW6ckPcb?=
 =?us-ascii?Q?YUCUdZbc7oPS9H95NgnXpUGqge5Iqa6JYxDgLQUZTP44sKQYCqpOmnmI4Mvs?=
 =?us-ascii?Q?qKJAouh6YT2gmzAONgu580ewV0A3O0oIJIivuMoA8OFa69r2ATjthRWGXG0l?=
 =?us-ascii?Q?62TUseaisZi4m5oTgr0gqszF89gdavgcRotjcruozFsDZkkV7MRxQCwcEmKk?=
 =?us-ascii?Q?2GBu0uuGg7hodMg1iRBy7UA970S5EsO+r70SFbNDHWqcQjtNUIdYgdE8jFKn?=
 =?us-ascii?Q?O7AGBUJcq9uvEJHKKb2unfpUWX3W+Qxp2o/t+9iZAHDx1fZNHnZoXTX00Gqy?=
 =?us-ascii?Q?GQ5cbvCk2JRwmqAGn+dd7AXFK1oR2BotxA9Dk1LeTL5rpq3S77FBQHW9rM+d?=
 =?us-ascii?Q?VcZIRYJTvJy+pOWH/k2zD4nH15Q7g85vxyIsId9gNCOxEKCAgyZDL0R7pL7D?=
 =?us-ascii?Q?DljNme1F0V9rSeydaiM6d7wovCdLKAMyi/5BuWWEEalRzVQpTLSZiXjdgq4i?=
 =?us-ascii?Q?pUsNSuUR6EOlmKTXqv+CghZQ6rtcdsKfeqSK4ugLj22e1OmYT1IsoNBmj7Iy?=
 =?us-ascii?Q?qHn/rd4htMWWSO8kDCQm2nJCEhVKQjEL3as66VavmCZR9pZiew7OYaknTa7q?=
 =?us-ascii?Q?POiJDbyLOi0Y6wfMWJu+bxAE28S0gjhuUSBP0vgbTMsxVZgpL9ABtkP2kZ0w?=
 =?us-ascii?Q?2ufTEevF5qZ+vs8U/ZLaHQJByq02PCtcLWKPSHbfBNliwwGFuTiq8Z888gT0?=
 =?us-ascii?Q?EYlLYwA6jk3Z6684aDg34cXa7R/duS0upwp+?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?TTrxEdR72iZo9hlBRZ+e+SHCsN5B4wOpOCXFGi3eqZvR7I/oXJDXVuVAhwpq?=
 =?us-ascii?Q?rnYguI7gS38elXNk9yCyeyxIBygLWzRnvUV8Ry4nUWZfcnuZ9pxlBMcxFD4B?=
 =?us-ascii?Q?AVz3sFdbpetJkAc3sS4WoxgEzCu2W4mwBvOGArWgAftFoIxHrXWsOTW2eKRO?=
 =?us-ascii?Q?e2icFayDHpFK8ktJ6FkF0PQtckDlr+q/+JCK8slmQcWvBlemun1cwemEQEkh?=
 =?us-ascii?Q?bTAqJ9F0RTL8N1QYTjR28dtwrqByMTud+yoh+5xOVeJR3jCyBpW58VAa9dB9?=
 =?us-ascii?Q?yF1sB7UQajKHTZ7P1gcywcBcYnI1ACkHRT2BhHU3Bv6KH2WtXiFvDISY7SRG?=
 =?us-ascii?Q?01xQUijUCf5snVeF3wh7bWtHvauhDBE1tbAtiYEXsXfbxmHT8KezA9nsJsDU?=
 =?us-ascii?Q?CP7YYL2aJBCRpdt0DjtRQYZriuCZDdVpcabWg6ANHMhzEOTisOL0C0edca8s?=
 =?us-ascii?Q?OdZcdwWISqZXHnReywvoOggslfCmSrHdj48W0GKeHMdLpA/SV8uJTy7vFNtq?=
 =?us-ascii?Q?8HARIR46YVulkKCinvYFyh3a6z9l957CxiKagglZzc6tgnQg+sv9dLynzLku?=
 =?us-ascii?Q?tA87k/RBwxcwjmEEqNJ6kGTjKfr6BLkXajAJhrNCGOC9hJOkIZ7a1MawWfT7?=
 =?us-ascii?Q?1ewniMRB0ZwieM+6trILTc97oQdd2+FUgIXK6mJ+UZHQVxREYL0gqoLX/MWJ?=
 =?us-ascii?Q?u9TKJfVGTGXd5eOxtWkGCUJ/kqAUoC3yRGhICXcU3DXpDjcgedmn9gTH/3bx?=
 =?us-ascii?Q?VFFJ3+/BDrdvHta9k2e27zbvOc3T+LjNnQoKpOOxcpGBilKCb21tcw+Wrwu5?=
 =?us-ascii?Q?pnpB12APHhl+Ouf6UXqAVfo23sLSsx5cnWMvUbZayXgqM0e1q6saNq0bVQTG?=
 =?us-ascii?Q?T/RiI+7wnzSa6UyoZATIjCuZjGYM/vzgKSW/g3rmQHrPjrVYmyyQ5MXS6fDT?=
 =?us-ascii?Q?UDk7dJdVOfOuZl8RzyOrilGELAKsdFacwsx86x7dP3Bta5iRN+y+/WogK4HI?=
 =?us-ascii?Q?qsg7k3jA9xTU1zDQXco0yAcAgVsWuU0wjdWsiCaWHAzx+Lg1hb6O39yb3o53?=
 =?us-ascii?Q?JvWa88voJ4X4hr9K08W9jpBZYIUZYYHZ7htem7aDubJ0XbL5lgkaVAne0YbU?=
 =?us-ascii?Q?yJLx9uTWQNJOoAHdZiXn8haBMpxld3DviKSip1KeTrsOCACZ1fTkKKMspH/6?=
 =?us-ascii?Q?9Ider0ypwzeiixDE0L34lDD4skOYfZCtdJ6FrGjaaf3OXLQftXoUQKPElVBy?=
 =?us-ascii?Q?gMxxL126BxloeHEcWUmlZDVEupd3VhsR/AK0GV+zj8WyX47yrfr7wHG0Rc4b?=
 =?us-ascii?Q?wdZ46/yvVCeIazrk+Q3ePHOMNFFCf1cVUTNNBd5SEJB4Z4IkuENhpPh+Yyzb?=
 =?us-ascii?Q?L95IFYG9Aee5V9uGvO0CFaxpt8uZURSFMkfm8j1blMa5Cri964BWztBMcl8K?=
 =?us-ascii?Q?byDu6TqxOjVLlwl/ax4PZruRXimixTeNLsdIyschtcpvQMd13jede6FGXx+v?=
 =?us-ascii?Q?XrPkn7EBTlv8yZ9kgZSnuetJL+5FuU0uJ6Y638VFUvdaRjESczmbGt/0wRl4?=
 =?us-ascii?Q?gxecIWQDlhX756BYLwkTl5LXicH3hD1DS6AXFX/Y?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7caf5bad-fa91-4380-743f-08de3bbec3bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2025 09:46:04.6748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8U7vdOdmL6DN6McpiCiZYWP5IyA4hWSXe/YnN6lHaeA2ldamj/ZgVF8XqdbAhDMg9H0qB5UhwWDiXZRZlWEBMa1Zv852b2/WxtykfprhS2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11729
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 09:46:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21042

+cc=20
nobuhiro.iwamatsu.x90@mail.toshiba as Nobuhiro Iwamatsu <nobuhiro1.iwamatsu=
@toshiba.co.jp>
bouncing.

> -----Original Message-----
> From: Biju <biju.das.au@gmail.com>
> Sent: 14 December 2025 12:10
> To: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Prabhakar Mahadev Lad <prabhak=
ar.mahadev-
> lad.rj@bp.renesas.com>
> Subject: [PATCH 6.1.y-cip 1/3] mmc: tmio: Add 64-bit read/write support f=
or SD_BUF0 in polling mode
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> [ Upstream commit 74f44ad07d1063933c237a7db16f6a4036643d60 ]
>=20
> As per the RZ/{G2L,G3E} HW manual SD_BUF0 can be accessed by 16/32/64 bit=
s. Most of the data transfer
> in SD/SDIO/eMMC mode is more than 8 bytes.
> During testing it is found that, if the DMA buffer is not aligned to 128 =
bit it fallback to PIO mode.
> In such cases, 64-bit access is much more efficient than the current 16-b=
it.
>=20
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Link: https://lore.kernel.org/r/20250730164618.233117-2-biju.das.jz@bp.re=
nesas.com
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> [Biju: Moved the macro definition from platform_data/tmio.h->mfd/tmio.h]
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/mmc/host/tmio_mmc.h      | 15 +++++++++++++++
>  drivers/mmc/host/tmio_mmc_core.c | 33 ++++++++++++++++++++++++++++++++
>  include/linux/mfd/tmio.h         |  3 +++
>  3 files changed, 51 insertions(+)
>=20
> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h in=
dex
> 86bf13fa8bde..c7c94caea3d8 100644
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -16,6 +16,7 @@
>=20
>  #include <linux/dmaengine.h>
>  #include <linux/highmem.h>
> +#include <linux/io.h>
>  #include <linux/mutex.h>
>  #include <linux/pagemap.h>
>  #include <linux/scatterlist.h>
> @@ -258,6 +259,20 @@ static inline void sd_ctrl_read32_rep(struct tmio_mm=
c_host *host, int addr,
>  	ioread32_rep(host->ctl + (addr << host->bus_shift), buf, count);  }
>=20
> +#ifdef CONFIG_64BIT
> +static inline void sd_ctrl_read64_rep(struct tmio_mmc_host *host, int ad=
dr,
> +				      u64 *buf, int count)
> +{
> +	readsq(host->ctl + (addr << host->bus_shift), buf, count); }
> +
> +static inline void sd_ctrl_write64_rep(struct tmio_mmc_host *host, int a=
ddr,
> +				       const u64 *buf, int count)
> +{
> +	writesq(host->ctl + (addr << host->bus_shift), buf, count); } #endif
> +
>  static inline void sd_ctrl_write16(struct tmio_mmc_host *host, int addr,
>  				   u16 val)
>  {
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc=
_core.c
> index 7283252aa07b..929f92d17ac4 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -350,6 +350,39 @@ static void tmio_mmc_transfer_data(struct tmio_mmc_h=
ost *host,
>  	/*
>  	 * Transfer the data
>  	 */
> +#ifdef CONFIG_64BIT
> +	if (host->pdata->flags & TMIO_MMC_64BIT_DATA_PORT) {
> +		u64 *buf64 =3D (u64 *)buf;
> +		u64 data =3D 0;
> +
> +		if (count >=3D 8) {
> +			if (is_read)
> +				sd_ctrl_read64_rep(host, CTL_SD_DATA_PORT,
> +						   buf64, count >> 3);
> +			else
> +				sd_ctrl_write64_rep(host, CTL_SD_DATA_PORT,
> +						    buf64, count >> 3);
> +		}
> +
> +		/* if count was multiple of 8 */
> +		if (!(count & 0x7))
> +			return;
> +
> +		buf64 +=3D count >> 3;
> +		count %=3D 8;
> +
> +		if (is_read) {
> +			sd_ctrl_read64_rep(host, CTL_SD_DATA_PORT, &data, 1);
> +			memcpy(buf64, &data, count);
> +		} else {
> +			memcpy(&data, buf64, count);
> +			sd_ctrl_write64_rep(host, CTL_SD_DATA_PORT, &data, 1);
> +		}
> +
> +		return;
> +	}
> +#endif
> +
>  	if (host->pdata->flags & TMIO_MMC_32BIT_DATA_PORT) {
>  		u32 data =3D 0;
>  		u32 *buf32 =3D (u32 *)buf;
> diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h index 27=
264fe4b3b9..566cc9ad0363
> 100644
> --- a/include/linux/mfd/tmio.h
> +++ b/include/linux/mfd/tmio.h
> @@ -84,6 +84,9 @@
>  /* Some controllers have a CBSY bit */
>  #define TMIO_MMC_HAVE_CBSY		BIT(11)
>=20
> +/* Some controllers have a 64-bit wide data port register */
> +#define TMIO_MMC_64BIT_DATA_PORT	BIT(12)
> +
>  int tmio_core_mmc_enable(void __iomem *cnf, int shift, unsigned long bas=
e);  int
> tmio_core_mmc_resume(void __iomem *cnf, int shift, unsigned long base);  =
void tmio_core_mmc_pwr(void
> __iomem *cnf, int shift, int state);
> --
> 2.43.0


