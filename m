Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97748FED2C2
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 03:22:54 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13580.1773285771286640488
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 20:22:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=MC3CwfbI;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1773285768;x=1774495368;bh=unzU6SZqXLUzeokXf3D8zsiVrauDdT+wbEhGh
	oGjgr0=;b=MC3CwfbIkJk0YMImmstJVVmUzou0oBJnNbCKDoVDGFxoY392x3QUVRdzQGZzXRF1qR0
	ufgHAiBmfa79Cy/No2/NDgbzoFwCYZwGq/kXiL4iGmtpWgdiWe7OEYuqMeLvIdUKhtfG59mT7UCSQ
	sR4ygz57XcdJvQeW5ClU7Kbl9Hgy+3Ci+5joLrYd6CJem5z0eh1KzEae7dvXoZp+m1cnPGIOkJkAd
	ijOJNCOo5VgjzFHxJ/8oBNWZ+lWeZ/flm4TMgN8twNnkxRJxKUV+FeDMqWFM7OAetLksSUAR/mvMf
	lYkn9uVL4jgLFERtIL3ms4BgALtXIZQn+xZXhzRsuKtg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 62C3Mm2R1836146; Thu, 12 Mar 2026 12:22:48 +0900
X-Iguazu-Qid: 2rWgBS9jW2nu0xW07Z
X-Iguazu-QSIG: v=2; s=0; t=1773285767; q=2rWgBS9jW2nu0xW07Z; m=rwDxIsKv2x4kQMaxYrymdmplLygB8MujnbFIcfSH0CE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fWXxM3TXxz1xnf; Thu, 12 Mar 2026 12:22:47 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GVPZ4c8BCjfPCAnYXdg7epbgCnBxakyabTvlOmH9CEWJiRsWUb/T5usldAhSA16us7c7UkPWL07E3jYdFU08a3Nz5s+5pRCD+OKZhTNkknE1CTd8h6f0p7AMhtUub86nukzuVZmka2PHEd5orp7RfCpIhDpM6XBpgoW/siYcgfIe8f1qnyzcAIMeQsWHeMWDkUr14m+gak4qDGgRxY9aBRlUp4gHlUo1s2NOv1kijXJ+8Ad86wSTDO5YilHK8X1zWccy4PgHpay31rB7iGM9Xx0VviZd/vk9yrnWOA82XHKQntpsF25GtWnk2MrAOKa0EwzX/h4lm1vq5NK8rbGcxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIBgFNPNBgZ6Lj37Ez8pXN4TyhOq3jgw23paWTMsIQk=;
 b=b1MU5XiQlcJHvKPaNkd7sT9uDQySxzg+whfCoGMcrX+Ir7Cx2IGl1HPpCcVcN8Qb2FWXx/VqSTgdi0TI2JbwPeUWUCwZSSix4IUdMWxUAOCEhnuJbkbaML0vM+C6QeEUP6lXLMUoc5iJkBp6kqG4j11P9vjqL91g+UwhE/YYJMfbKOSGwCvDm8tWDTIiuowr+vp7GO+4GoYWlnGXyJqcqt//C0BMS2X4YbTdydfw93PHqOTAIISvx8zH6O+UyTgz6aqO2dfZ/rVgUOOSRfp6uCliq4pgz7nH3ehDCq/GSby2IJxLrBPunBiQWS5kAR7SrJk54HZpZ84saCCh+H2ODA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cosmin-gabriel.tanislav.xa@renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@nabladev.com>
Subject: RE: [PATCH 6.12.y-cip v3 11/17] spi: rzv2h-rspi: add support for
 using PCLK for transfer clock
Thread-Topic: [PATCH 6.12.y-cip v3 11/17] spi: rzv2h-rspi: add support for
 using PCLK for transfer clock
Thread-Index: AQHcr9Z2/1I583+gt0eZklnpIt7mErWqPiPQ
Date: Thu, 12 Mar 2026 03:22:40 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148182B08E606EFE9EB6D1E79CD44A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260309150619.761962-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260309150619.761962-12-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20260309150619.761962-12-cosmin-gabriel.tanislav.xa@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSCPR01MB13060:EE_
x-ms-office365-filtering-correlation-id: 81289fbf-574e-482f-8b40-08de7fe69e29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|14052099004|38070700021|7053199007|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: 
 C+dXJm8Pm77krQkP0dTyG1fyZj9n2/zGb/ii+cfCTMY1acZl3/jNOswGRbMCVj//U7dlLXYWsNFqelzI+vJJr2/7OCVBc/lypeErP9zlZVI1hdzmDmGF1rvnvkdQnSag9PpST4+Of/05lbmKP8bibGnnOkCZSwlQj1FrVuZs7Sh/498xBxLf6G2gDN4EHo/mSUioqoTEu1dFoFMVSy7I0kiDj1rGimidv5f1rrdxkyOpTylNsphdCcRKUo9/mPmOlLqvcw4UFNLSaOnAG2QFzCzK5/GwkUSqHGVbNZ0MRr3Dx6TVM29XATaOCafMrsZojV8V/PfRkhQrU+eiv8hiEDxSnQyad3jDts+njz1Y8GzF/8p9TE8BBtfUy++6vS7P0Uu6fXD/f3PtRWqIlA6zQ0Cm752UoyUsrB3P7w4hp7hcpc5TWXAlxXrsAQRj35nUpt6cbL+oDgBhkwuHdtPthm014EfYqMi2rIsc8W0AH8/cQYnGHS5hpBlkq4sYQx4FXP8Ca8wGYOUefMoIFO/23Tk/clo+6P32hqb+hh5C8leakzzoqWUXQLu+BFRBOh7AqjX0H+9YVdJmh7RCIjXF20L6QR9kxWvF6IPPQfSBunBbp7rIMIoXuFtD4TE6CJ+JdGmfuEM5R6zwvR8YX/xL77Q4IQwqcqYsqHiGm3jbrPDH2C3z2EdahysyzKuBpzePdu58si9f6Ug8QKcgZmlR+Zfjio0ego+uDfuj3IJVFzh1XTi/Hb0xwZVnNXEQqP/D
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(14052099004)(38070700021)(7053199007)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Q3piV3VZNHE5STVWTGc1dmVoR09KQ1lVN1VLaE1PRXN4dGFsRExJT1pm?=
 =?iso-2022-jp?B?VU9ibU9Pa1pxWlc0TDRtU1lMblZ0TGFWTGRQanJORkRNRjFBRHRpcmp3?=
 =?iso-2022-jp?B?VGprZ2RSMFI0anY4ZDBQKzlBVjFHZTZOc3kya1RtSWFjNTF2VEhmRHQ0?=
 =?iso-2022-jp?B?TDJRZ2EzbFN1YzkvdHZZZ0xTU0crVUxNZkwyRVF4TWtQcFJFV080cjRI?=
 =?iso-2022-jp?B?QlBHa1ZyOFZmQ1o1TWNwV3dmTWxDT0FRVXVmZS9wZTdqTjkweEowcUN6?=
 =?iso-2022-jp?B?b2lZRWk5b01iSlhldnVhMzZDMW0vSHBSV2paVGtnaXk3RlFlRFFqNHo4?=
 =?iso-2022-jp?B?WmVoWUFEbGFVTDFLYjNiZVVWd1lKandyZUlHOUNkTDRIclJ4eTRmMkxr?=
 =?iso-2022-jp?B?bERDQWRBNW9HWXZ1amt2QXdkaXoyY1Nsd1B6YjBzUFBiVzlQY2Q0Si82?=
 =?iso-2022-jp?B?RHJhRTB6RHlMQWFIZ3RSSU5UVHpoWlJ4dkhHdVBWWlREOTBhV21lNzB6?=
 =?iso-2022-jp?B?U1g5VGxmbGxEWUhReFJqU1hrQ0Z3bnZMaWhsdzNuQU93Ny9HUkkvdFcz?=
 =?iso-2022-jp?B?Qm1UNExVbFpERElBbzdVV1FMS3FsTi9DSUpmVkNHNDJkTDBGUzJ1OUw3?=
 =?iso-2022-jp?B?NzhVdFhPQTQ0NDJOK2RjVlpLS3k2NEtOS2xqd3lXeHdoRXJlYzhZaUdn?=
 =?iso-2022-jp?B?K0t5K2hrL0MreWd3azcwS2FqZ0xrM3Z2T0k2a2tLQ1ZoRVlrcWpzTHZO?=
 =?iso-2022-jp?B?UEE3UUk4ZkpKRENQRzk1SmQ5NjMyc1FRUld5TDdZOExzS3prNFZ0Y2F2?=
 =?iso-2022-jp?B?VmNHU0JyK2pSQU54L1FraFJKSU1wMkdjc0NTWldQNHNDNk9FN3huNW9K?=
 =?iso-2022-jp?B?clVPeHNVc0RNbWJBbGJjYTJNUit5TC9KcTV3Z0NFSTdRbDV3dEJmVnpW?=
 =?iso-2022-jp?B?YnRrSEh6VGIwSzN0cGRuNUpEVGdnSXFzR0x4NGh2U2RqVGJHUmZtRFJq?=
 =?iso-2022-jp?B?djRZb0U0Z3R2ckFRSEVJZmRSZ1RZczROQjd5WjhSdDV1bUVHUkRSZmg1?=
 =?iso-2022-jp?B?bE1hNWVSaGxaeXg3YmFSR21KMlFMUTd5UkFSTzBkWEZJTlppQXhBOU1T?=
 =?iso-2022-jp?B?cWcyenVxUEtWUFkva3huTjNRZHR3ejVyckx5Y0VoemNySzJOQkJjOGxS?=
 =?iso-2022-jp?B?Y2d4WVpLa25ITXk2N25wVUlHeGJ6Tm44TG9hQno3cUFiUHhZY0JBQXhh?=
 =?iso-2022-jp?B?TUl0S0RNbDlKc21GM1Zsc1lQa3FFaEhGYnBCWnZKQURxNEhvdFR1MzZJ?=
 =?iso-2022-jp?B?NjVNaG5KcCtDWmhaa0grdWY1Qkx4Z1N1UWlnalRjajRNbkU2SlRoYytn?=
 =?iso-2022-jp?B?bXEzNXU1WlMrSitsbzg1SkJXRTdLbXhvc2U2cE45UzFGRlJqaUxuZUpW?=
 =?iso-2022-jp?B?ajVJLzVTMWt3TFkzcUFkUDg5QVIyYTNOY0hHbmJ5UjBtdXdQdGhDa09D?=
 =?iso-2022-jp?B?LzBITjA3a1VQVU5QSDZ2S2lzRVI3eFBMcjgvd3N3MGF6NFhDSG5WOWJ0?=
 =?iso-2022-jp?B?dVc4TzU3aTBqY0tmM01Sb2hHVEh6eUxvYVRxSkN2U2hPNVIwTlRtYW1w?=
 =?iso-2022-jp?B?by9jeWJhQlB4ZXhDQUY4Q3BUcWErTHoyUUp1b0NKVmE2eUw5Sko4c1d6?=
 =?iso-2022-jp?B?Y0dkSXhjcUdyOHIwcGVRcHhZQnVjZ2MvSE5Kc1hpKzNyTER4dDd6QW5l?=
 =?iso-2022-jp?B?b2F0NVVxYllMSDBydFdkaXB1T2EvNEtnZUZoTDBOdUFSVGFxeHdQSHVH?=
 =?iso-2022-jp?B?Z0ZvQmRaOEhQdDk0UHZiSDhlYU44QVRTMGQyMjA4bnRwMHZrUGRka0Zq?=
 =?iso-2022-jp?B?elhnWmNLV3J1dFF0N2FTU0NnalI1MVFEcmZYZVFrL0tJcUJPQ2drRThn?=
 =?iso-2022-jp?B?UU9OWDgrR25ncmVoNWZqZ3kzMjlHRVJyV3lvQTBWWWFQSVpUZEFPUU1k?=
 =?iso-2022-jp?B?OVVxUTZtdVhDMkhGRFVIYlhLYVRxYldoVS9HSjcwaGk2aXY2M25IWkRt?=
 =?iso-2022-jp?B?VmtzeUg3TkRZTEZvbmw0WW9lcy9UWlV6VDJkcllmTHJwZ2o3ZmFmVVov?=
 =?iso-2022-jp?B?MU9vdkF6c05iK0d0ejNhTUZncUVjMThFcjJNMTVqbzRjT3ROSEVHVGts?=
 =?iso-2022-jp?B?eGtiR0dmYUhJSDA5NDlGWTg1MkxGSzR0TmVoL2RmQWJ3QmVzNHZzaWY5?=
 =?iso-2022-jp?B?Y25ZckZYREtteWhTNHoyMzJjcHNCQ00rdVE1RU9XS1RtYWRXWnBqV25W?=
 =?iso-2022-jp?B?bjhrZEtpUmtFSy9PWko5SHJXT1RVZVJWU25ITG5hMXFWSEdiLzJ4L0lT?=
 =?iso-2022-jp?B?aUlPSng2cnFhUjZQL2ovOGRqVGduc3lKUGZpVldZcDZCRy9JZmdGMjJ5?=
 =?iso-2022-jp?B?bk1UR1gzdUZOL1crU2UxczU4UnU4aWpQQi9mZ2k5WFhoVmxtUkxWZldG?=
 =?iso-2022-jp?B?OFRRcnJ6QWgxY3p4QlJpWUc2ZDhLTkIxZkRZRlEzY3p3RG1TSk51QVVH?=
 =?iso-2022-jp?B?QjlBK2xZUT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	szuk+E0t6rq2cvsFXa5WV9VAp8KJYOPxZDKvuw4aqWnVYXZbCNTom10T+R7lEfwIlGOBvyf7zxQ1FpF21G+sVD+B7TMgzwWopEwuksoaYeSLYwn61qjm84wmFH5wDH0rZSKghVve9RvEANABh7bjkec6y12TqMPZAGfFBdVN5uQUhZLQqFzBcWZRaqQHBxb9FvHUQJPMcYt4PSeOgzmt4KkN/NvxZTHKh1sgK4oZ9r6Ls4prZArDq9LX7MS7K4WE8ZmzLg7oRg266kBwe7sFkopeOFCUMRn8ZceHIs/Zqqk5hvL15JkSf8URPP55+U5rO6+qI+k479GdMmws0lkQyg==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81289fbf-574e-482f-8b40-08de7fe69e29
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 03:22:40.5779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WvdbgSGVnWOhpWACyaPO36sKeouQVVIyDtAE/4D65qKTQrnbpP0kJBrFVYuG2hfWmC0/ue9ZK//3+Hxy1xhnkWCjCQS9HgKpwAPV/8zTaYB2xRBVkxlTa3ZxO/vYj2Yz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13060
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Mar 2026 03:22:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22349

Hi,

> -----Original Message-----
> From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Sent: Tuesday, March 10, 2026 12:06 AM
> To: cip-dev@lists.cip-project.org; pavel@nabladev.com; iwamatsu nobuhiro(=
=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Subject: [PATCH 6.12.y-cip v3 11/17] spi: rzv2h-rspi: add support for usi=
ng PCLK for transfer clock
>=20
> commit 1ce3e8adc7d0038e59a7c9f5c9e5f399ba0db5d6 upstream.
>=20
> The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs support genera=
ting the SPI transfer clock from PCLK,
> with the quirk that SPR 0 is not supported, causing the highest achievabl=
e SPI transfer frequency to be 31.25MHz.
>=20
> Add support for generating the SPI transfer clock from PCLK.
>=20
> Renesas RZ/V2H (R9A09G057) also has the BPEN bit used to enable this opti=
on in the datasheet, but it is not explicitly
> documented and there's no details about its limitations as there are on R=
Z/T2H.
>=20
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Link: https://patch.msgid.link/20251119161434.595677-8-cosmin-gabriel.tan=
islav.xa@renesas.com
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> ---
>=20
> V3:
>  * no changes
>=20
> V2:
>  * remove internal Reviewed-by tags
>=20
>  drivers/spi/spi-rzv2h-rspi.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c =
index f59bcadf5e38..e9d8ee919261 100644
> --- a/drivers/spi/spi-rzv2h-rspi.c
> +++ b/drivers/spi/spi-rzv2h-rspi.c
> @@ -34,6 +34,7 @@
>  #define RSPI_SPFCR		0x6c
>=20
>  /* Register SPCR */
> +#define RSPI_SPCR_BPEN		BIT(31)
>  #define RSPI_SPCR_MSTR		BIT(30)
>  #define RSPI_SPCR_SPRIE		BIT(17)
>  #define RSPI_SPCR_SCKASE	BIT(12)
> @@ -41,6 +42,7 @@
>=20
>  /* Register SPBR */
>  #define RSPI_SPBR_SPR_MIN	0
> +#define RSPI_SPBR_SPR_PCLK_MIN	1
>  #define RSPI_SPBR_SPR_MAX	255
>=20
>  /* Register SPCMD */
> @@ -79,6 +81,8 @@ struct rzv2h_rspi_best_clock {  struct rzv2h_rspi_info =
{
>  	void (*find_tclk_rate)(struct clk *clk, u32 hz, u8 spr_min, u8 spr_max,
>  			       struct rzv2h_rspi_best_clock *best_clk);
> +	void (*find_pclk_rate)(struct clk *clk, u32 hz, u8 spr_low, u8 spr_high=
,
> +			       struct rzv2h_rspi_best_clock *best_clk);
>  	const char *tclk_name;
>  	unsigned int fifo_size;
>  	unsigned int num_clks;
> @@ -90,6 +94,7 @@ struct rzv2h_rspi_priv {
>  	const struct rzv2h_rspi_info *info;
>  	void __iomem *base;
>  	struct clk *tclk;
> +	struct clk *pclk;
>  	wait_queue_head_t wait;
>  	unsigned int bytes_per_word;
>  	u32 last_speed_hz;
> @@ -97,6 +102,7 @@ struct rzv2h_rspi_priv {
>  	u16 status;
>  	u8 spr;
>  	u8 brdv;
> +	bool use_pclk;
>  };
>=20
>  #define RZV2H_RSPI_TX(func, type)					\
> @@ -306,9 +312,18 @@ static u32 rzv2h_rspi_setup_clock(struct rzv2h_rspi_=
priv *rspi, u32 hz)
>  	rspi->info->find_tclk_rate(rspi->tclk, hz, RSPI_SPBR_SPR_MIN,
>  				   RSPI_SPBR_SPR_MAX, &best_clock);
>=20
> +	/*
> +	 * T2H and N2H can also use PCLK as a source, which is 125MHz, but not
> +	 * when both SPR and BRDV are 0.
> +	 */
> +	if (best_clock.error && rspi->info->find_pclk_rate)
> +		rspi->info->find_pclk_rate(rspi->pclk, hz, RSPI_SPBR_SPR_PCLK_MIN,
> +					   RSPI_SPBR_SPR_MAX, &best_clock);
> +
>  	if (!best_clock.clk_rate)
>  		return -EINVAL;
>=20
> +	rspi->use_pclk =3D best_clock.clk =3D=3D rspi->pclk;
>  	rspi->spr =3D best_clock.spr;
>  	rspi->brdv =3D best_clock.brdv;
>=20
> @@ -361,6 +376,9 @@ static int rzv2h_rspi_prepare_message(struct spi_cont=
roller *ctlr,
>  	/* SPI receive buffer full interrupt enable */
>  	conf32 |=3D RSPI_SPCR_SPRIE;
>=20
> +	/* Bypass synchronization circuit */
> +	conf32 |=3D FIELD_PREP(RSPI_SPCR_BPEN, rspi->use_pclk);
> +
>  	writel(conf32, rspi->base + RSPI_SPCR);
>=20
>  	/* Use SPCMD0 only */
> @@ -433,7 +451,9 @@ static int rzv2h_rspi_probe(struct platform_device *p=
dev)
>  	for (i =3D 0; i < rspi->info->num_clks; i++) {
>  		if (!strcmp(clks[i].id, rspi->info->tclk_name)) {
>  			rspi->tclk =3D clks[i].clk;
> -			break;
> +		} else if (rspi->info->find_pclk_rate &&
> +			   !strcmp(clks[i].id, "pclk")) {

I think strncmp is better than strcmp.

> +			rspi->pclk =3D clks[i].clk;
>  		}
>  	}
>=20
> --
> 2.53.0

Best regards,
  Nobuhiro


