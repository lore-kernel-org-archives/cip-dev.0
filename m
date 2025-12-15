Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C7CD5B170
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 09:47:53 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.23])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.45014.1765792070665607768
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Dec 2025 01:47:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=plccCSvJ;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.23, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jt1cfLlwKR9VGdYY9Zxm6zTS1lvI7M3x3aexMQ08p+SePH1wQDCjyNsOyvzyPvRE+c8busbl6yDnyMCsIHyODPiPj2kZRFOF+HwHS1d6dPWW5aw2k/Xs8/NxtZ2CTcT24rVGfbzzQACFcJfAwwHz2BxMkcBWK+72okt2pa7f+ca2Vhf+1K46f69J71Iw7nOohPmmRhfIUxlldNfDzQlthaUPBfDDLczoPvWUdimy8kaTnFxpTJWd7zCkO/Q8HXA2R8Kr9QBQKH89ZEhdwPJQl+EjxXfNqEHiMDAXqzZbuFluEkqfelwySJ6D7Dx28K1SmG/jjIQLNJLcRiiEh17DpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaQhdKc7sBZ/WD5+MPzjz2h55eH+oZzc+mj1T12AoTc=;
 b=H8AMgwr2jepxImIOZjl6Uzhbs9ur0Y61IYIezz5HZJBeL+JcAyeh8QtjFvz9rr4x+1B5q/z+wa+txcEOr0CnsLuefkZ6kHtJbz6LSpjS5PSgleCMn4KusEv3w6Zv3dO4/uGWMv9XWB+xcIgowFypNxwAuiWaOgViA1CRuZTbJF1mC2e2EqLjqVdZwv03Lhf0G6ep5xRrIKdEGnjPc1Z9M4HYimKGJv6J89d/qj94mR8XYKzKmvt2M6EMucI33W7gkb5Amsp2iClLqLP6/A13DeI1SWGDLObhwpLzQ7saqDbhc1Us9tlYMPaGWCiLrUVLslvkqdsx3UNzeUQ8J6u6+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaQhdKc7sBZ/WD5+MPzjz2h55eH+oZzc+mj1T12AoTc=;
 b=plccCSvJk+dk9LOp5FnXJehQph2YTnXKnvzbTWL0B2N2+V6KXNwyxpHstyNerDa0rXBpAj/lgbbEb7QdnwX952kG0aY0LJZhpTbpqGYuOAgR4MEzMQe8tFHchplZgC9y7/qT5cqESRM83e6OdbHDZVxFxbUCwWWyzf2tKMY33Sk=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY3PR01MB11283.jpnprd01.prod.outlook.com (2603:1096:400:36e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Mon, 15 Dec
 2025 09:47:47 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9434.001; Mon, 15 Dec 2025
 09:47:47 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: biju.das.au <biju.das.au@gmail.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, Pavel Machek <pavel@denx.de>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip 1/3] mmc: tmio: Add 64-bit read/write support
 for SD_BUF0 in polling mode
Thread-Topic: [PATCH 6.12.y-cip 1/3] mmc: tmio: Add 64-bit read/write support
 for SD_BUF0 in polling mode
Thread-Index: AQHcbPN9IOLHdVAZE0epxsC3DGfU2bUidcSg
Date: Mon, 15 Dec 2025 09:47:47 +0000
Message-ID: 
 <TY3PR01MB1134691817FDD3F871A9F63AF86ADA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251214121627.4656-1-biju.das.jz@bp.renesas.com>
 <20251214121627.4656-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251214121627.4656-2-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY3PR01MB11283:EE_
x-ms-office365-filtering-correlation-id: 90a4fd42-596b-498b-2603-08de3bbf0138
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?NUPF3Tg92QZJYmiFU7bG8BCXGtb7zOrME3J7tN7kcSxB8Lu8Yq0nkNsl4WnL?=
 =?us-ascii?Q?qv2WZbRkKlIsY/Z/SywlTw/WfK0LB1GAzuKzIMj26lMkFPKqG6REKl29gWes?=
 =?us-ascii?Q?UVUu89mjRJWXwvE4m8sRur3JVW9Ijmk94RcABy4my7L+axG0dOJ8tS1cxclx?=
 =?us-ascii?Q?qt1Pfw+sN6Z+TwTO+HhgsENPpkwG7eNksncgpZQU1yC3vPBCsujMjx8iId1g?=
 =?us-ascii?Q?ib6UB9IQjPryTIZ3afGu62MNmbxnAr6AOANT8PZp5CQiYtf8rt5pfNHIglPe?=
 =?us-ascii?Q?VTElXPpdFVTEP7yB4I/0Y63T5LwLJ6RD2aNmMtGYBOxJVm0u4Vx3C9eNztnt?=
 =?us-ascii?Q?ongGVa7Sz9w7RqRDkI/Gs6QYEsygsipacZqGz3GOR2BQpkZ4laLJXTOcAOmr?=
 =?us-ascii?Q?2mJLshsaoTpTQ/Loxx9kLV4ObhC/KbLq4nqg9W/Dp239qZ8mzJOKfDc2AxWr?=
 =?us-ascii?Q?RHzeZBJWfijmIee0llicbQRpDYiAMFNNjI4vGoFmyLmvxnXnDlVlcd1DB6N9?=
 =?us-ascii?Q?Av/sDcYBw0tCHwY1nPrFWIrygN0bFEc8wFvPKTfnvy9xxrSlPTgs3pPIChKe?=
 =?us-ascii?Q?/9uroH6MQ3WmVk52roGUyK1RvC1+hcL0pwwXe0YZs/T1DabQRNuBLnxBJomu?=
 =?us-ascii?Q?KAzIkxG/xWlHeAaqU0qaBGl7QPrPPsaxRj5aFFizy1cvNozEcqn0wKxYE5W4?=
 =?us-ascii?Q?EicO/Gvmk++qayYwbpZL5gQaLiwWM3q9ku3K1kuUA73KVfhKKpsp22SwaN+g?=
 =?us-ascii?Q?0sTg3qrLH2OtjydcYNXjoVG9uXlTDFRfvYaOK0nDry5PvcXqW7yUfDgrnpB6?=
 =?us-ascii?Q?Up6NedacBok5NRZgZXX5NC/vjPj3lBZhG3IhzTH5HQlMXomRnMb/p5VJNPg1?=
 =?us-ascii?Q?alBfwD7iKZeOx16A+RGo7hryf8voVQa76KtTqg5n+DeU9XDAchyDOdioecnU?=
 =?us-ascii?Q?aHDBpjB7+zCF9XCI6/XvDV/EJj4UBFHOwkLDakW97BFCG9C1EkyUjdLURP/E?=
 =?us-ascii?Q?t4sQh63GJQewVYXFp76y2pJsprEOMw5hhra6zJwB/uokGKpJKXQi5IpOliGz?=
 =?us-ascii?Q?byIjMzVsvYB72byS4gv06a1LBLDU0A8hwuXULYGmg+Y5DwbJvuTIerbex5tt?=
 =?us-ascii?Q?+27TEvEsTwzPhNMe6qgxcPI2vNSvSV++A5S3vEsyBKU6iGspOHJFmFqW60sO?=
 =?us-ascii?Q?CEVMPv2/wIj23AghzS+MEfDDP9z1G5naICtOtd4DkdbCskivakZ7qFJaqAwG?=
 =?us-ascii?Q?A+ye7cZtA3l/aPgMYRnSYp+B0nS3KnqoAOjh2qA31PS+ZI058j/ioU74B3V3?=
 =?us-ascii?Q?lheewi/kyEO9Dy0AE543R1TZaYnIGQkhHRGAO9NNW4E3A5ScKIDoYDzmz7Lw?=
 =?us-ascii?Q?mJDxmgokrqWQMa0dwWuVcmVrQhbE7kLX4keikpvRrd1BHT05AnfsiHCdJPz4?=
 =?us-ascii?Q?7qCvcfkKKSqYYuaay/gwLZ3FO5WdbL6hfLup61fQjzdya0kb6YgjASAKnyat?=
 =?us-ascii?Q?IaG3rP+NF3HPeq9el6E5c3xa32vqBljdmaGq?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?zmG9zLilgTA2GEdNZCIOett0BegjfizniB3vjApxXEZuftzsRefG/9gIMa6s?=
 =?us-ascii?Q?qsOmmoQVwV9h9j1Vg/IZexS3HUzkP84q1SUFHUGaiGp8oVBmawn/OCrkA9fF?=
 =?us-ascii?Q?fS0w4qiBTaCDwOTSNQceCSIV4+6zxySC3gJCv+xG698DHE5D+n3U4DAWtQee?=
 =?us-ascii?Q?e3mtJ55xqkvkt2+Qi1m/gsyRyM9FIH4Dj5gGv7s7u+voA2f/QwheSjmFTuor?=
 =?us-ascii?Q?VqYq9kaVDaZaPis5F79lBXjepCiIAmjkupbn+aHl9srifFsKwXpFU8dsjbXL?=
 =?us-ascii?Q?7a6asgmKogfYkGoA45a/jeER1pGCYU1V/fMTU/caXXSBF3UdANs9ewnaPDvM?=
 =?us-ascii?Q?OUsO8fP1JKlc/CWEDFO3rS10PyICtV4BwaI5PIfFKk0vMsziJ2MtcaW8sVPm?=
 =?us-ascii?Q?46Z9NLUj6HziYL8QDz4mEMoJOq7XB+g57PXaDaWOleMwj/jdAqMAXjWCaKXw?=
 =?us-ascii?Q?2vcUbg992OuyK0b9rrPuqu5h5U/RhnB4vttqQzCIhtHGAydLynC3VtAxLdkx?=
 =?us-ascii?Q?aq0K1DqI2wo2m0x8tEZYf4gLKbRiQEBHOvmLp3aMaX+ek/Sj8Lxcbkzv4rhS?=
 =?us-ascii?Q?HzucbDN1xOIF8FUOa+Y9jAbFaDzBR3IUYcHei4aMVxtPN1FjtBfF4iGreUki?=
 =?us-ascii?Q?9kEMS0XYf+EXyOb5g3UrIFAtXi/MbqCvD0HYNUxUj+CJPSFbg+FQ2/EoWJC/?=
 =?us-ascii?Q?HhY4rkFYjr5jOQ6IXXpQDVdEUcI/3yKXPTigM3I64pkHQCGSawB8hfXYQ4pw?=
 =?us-ascii?Q?ExRI8DSCrI61OGwakMFms4QL6gEA+cRidAK4UF2r5VD37JKqwYCAW/8vPA8Y?=
 =?us-ascii?Q?gJGuSG+NBOclyYwAoYzGgHOy28u/eXLSrUKGazFceifk6R0Is+eqfun+gvIt?=
 =?us-ascii?Q?iXebdm+CyfCL46uDV22EV6n0OD14wiijTTIxJNaWE2cn1K1aSVqiqaa5/fnk?=
 =?us-ascii?Q?+4O/fwScKpKdn7bAg3Eapu3sy667X55D1kvtkF0maOmEm+0duVCOU7ExYP5U?=
 =?us-ascii?Q?83CZBnVzE0eic4G8uO57TMipBkVBUbCsGUTXNllj/8Iu2h0pOx9Gq+dMkyXP?=
 =?us-ascii?Q?p8Qu30yZ2Pa59OkVpZsfvtkAESoRFVcL4zVYIemjf4d0QQtyToiTdUDvV/LW?=
 =?us-ascii?Q?Gq0gDV5xFA+SwQEzBt7ZoENvroFSz8kFBBsDmEkIBQeVllFXlq5rcB1xQsV8?=
 =?us-ascii?Q?/26adcjoi1fXiVw8bJazdU/GHddOVyL3UBZyQyatNzTI6rNsXxkQdauuw4Un?=
 =?us-ascii?Q?f13Sk3GPf6Z75RGGM6yD5heVszj++13NLlwquKG5FU3D5bfckMRwKNPVJurY?=
 =?us-ascii?Q?lGw72JJZCWND4boIm3EgM3ZBzzKC9Y3Op0weNuKjrcEBxA1WhMHoI+NUnnzM?=
 =?us-ascii?Q?tf6/EKRJkYbUpm1IoIzm0IMoeE7gsqTggzYp+MkpFklnUQxQpe7WHXl0PcZ3?=
 =?us-ascii?Q?WgaVJW67JzPnfUAvrKdSFzUzspPSg6f8ZzwdX/xvRaFqTkYxjNO9whF20HeT?=
 =?us-ascii?Q?GP9weTKdM52Z0Ss9sbHualmDk62V9hqdQCiuYUxc17vpIbj968KB8qOYq91C?=
 =?us-ascii?Q?z1bv0HlVsTgU7V7TPVeNCMTPfmIQ9y8b1jFIcmJ9SZLkwHVWsShed7E+s80Z?=
 =?us-ascii?Q?rw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a4fd42-596b-498b-2603-08de3bbf0138
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2025 09:47:47.8126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fHETLkLDOlXTC+HXtYi0x8RV0NR50B1llnok1dC4kE+4zywsnuJkaklETuOR/GulwTaaNwWNxe63852oL7Txjf8D4kbW3OJ+1xOfqzo/pUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11283
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 09:47:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21048

+cc nobuhiro.iwamatsu.x90@mail.toshiba

> -----Original Message-----
> From: Biju <biju.das.au@gmail.com>
> Sent: 14 December 2025 12:16
> To: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Prabhakar Mahadev Lad <prabhak=
ar.mahadev-
> lad.rj@bp.renesas.com>
> Subject: [PATCH 6.12.y-cip 1/3] mmc: tmio: Add 64-bit read/write support =
for SD_BUF0 in polling mode
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
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/mmc/host/tmio_mmc.h        | 15 ++++++++++++++
>  drivers/mmc/host/tmio_mmc_core.c   | 33 ++++++++++++++++++++++++++++++
>  include/linux/platform_data/tmio.h |  3 +++
>  3 files changed, 51 insertions(+)
>=20
> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h in=
dex
> 41787ea77a13..a7263eb10450 100644
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
> @@ -242,6 +243,20 @@ static inline void sd_ctrl_read32_rep(struct tmio_mm=
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
> index 45a474ccab1c..6b12607fd167 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -351,6 +351,39 @@ static void tmio_mmc_transfer_data(struct tmio_mmc_h=
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
> diff --git a/include/linux/platform_data/tmio.h b/include/linux/platform_=
data/tmio.h
> index b060124ba1ae..426291713b83 100644
> --- a/include/linux/platform_data/tmio.h
> +++ b/include/linux/platform_data/tmio.h
> @@ -47,6 +47,9 @@
>  /* Some controllers have a CBSY bit */
>  #define TMIO_MMC_HAVE_CBSY		BIT(11)
>=20
> +/* Some controllers have a 64-bit wide data port register */
> +#define TMIO_MMC_64BIT_DATA_PORT	BIT(12)
> +
>  struct tmio_mmc_data {
>  	void				*chan_priv_tx;
>  	void				*chan_priv_rx;
> --
> 2.43.0


