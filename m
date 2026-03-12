Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF39FED2E3
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 07:57:06 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.9])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16570.1773302218134129237
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Mar 2026 00:56:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=gD7eCME1;
 spf=pass (domain: renesas.com, ip: 52.101.228.9, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nIbd4xS5g+J6lcGCWUpWd/7GS51LEsraYDqru3Pa7wB0Yc6skFJIDJju1SP6H4tTJGQyruSY7mpDxHAlQFiIRJMGMfvvNus4r4vRbXQcVZjbf1GEik2HLvNeHAFtF8ohahQOs53g6G6d4QR1xUyur0Vwxk/XWZKKSYEkpGVNTjXJgDdvRgBtXaQ9j0KORHznZLh0DLMS52n1TK19kNTycvOtTwkjZzs07qZujH8/rM5FCo6oo75JJqq2dXiFZ+UPr93Q3TDMs3qQlCGbu31Uy0NGQqN6XEk8M+dyzVLtrwYe23mQ9gYeyqQPqEVmdXDczwa9TiPpwisJipKoORBS0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dL3w9CueOI5hlF4BomqdSiYYWPXFfOXxrlFtptCzeJU=;
 b=wOS7GqMWiYhEcEmnh2rrotyTESG8vhOIbNCZbZCc5cuUZA89EMe4Xyac2ox9EVBehoSvDYRHV8WGKuyHm5J+qPqmsIUekrlzBEOrEvXmHRC2u+YyiNREgBU7Oj8agC0ikY6dexCUn7aZpK25P5HcAiPGKftiA8XSkbxDWaexKKPsp19GdPXZcpQ1/RO7I//OD5lrY4CuFTDWxTPSY2E58vrrFjfjHva1Uy5P3NY6U2imlkConW3tTTOOBvxEjdML9puo64iv5hWrDNQhzQMzIJ6c8z43QYhlWGNSdXuy5yVPA2/QnzE/Xs9LQlUEtgvOdqpipMJgQvC3LeOe3LYgyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dL3w9CueOI5hlF4BomqdSiYYWPXFfOXxrlFtptCzeJU=;
 b=gD7eCME19ufS40iJctQrPjekFTkzpI8Zl0QuiI2+1AbP6xmjF7OZQLv+XQZPnSSIbWDpRrgg+N0DzQSPuSLR7MCyFyucGiSkBAu9DmD4LHCzr8vu2JCv3MdSdBYH1iMS0XHS5/+Ko8H8xZ1a17w2TY5H8KOHB6em7Eym11ovDZk=
Received: from TYRPR01MB15619.jpnprd01.prod.outlook.com
 (2603:1096:405:29b::10) by OS3PR01MB7777.jpnprd01.prod.outlook.com
 (2603:1096:604:17c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Thu, 12 Mar
 2026 07:56:52 +0000
Received: from TYRPR01MB15619.jpnprd01.prod.outlook.com
 ([fe80::a68f:5c9:9de8:4fa4]) by TYRPR01MB15619.jpnprd01.prod.outlook.com
 ([fe80::a68f:5c9:9de8:4fa4%5]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 07:56:45 +0000
From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: "nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>
Subject: RE: [PATCH 6.12.y-cip v3 11/17] spi: rzv2h-rspi: add support for
 using PCLK for transfer clock
Thread-Topic: [PATCH 6.12.y-cip v3 11/17] spi: rzv2h-rspi: add support for
 using PCLK for transfer clock
Thread-Index: AQHcr9Z2/1I583+gt0eZklnpIt7mErWqPiPQgABKxOA=
Date: Thu, 12 Mar 2026 07:56:45 +0000
Message-ID: 
 <TYRPR01MB156192DB51B8675801796C7018544A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
References: <20260309150619.761962-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260309150619.761962-12-cosmin-gabriel.tanislav.xa@renesas.com>
 <TY7PR01MB148182B08E606EFE9EB6D1E79CD44A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY7PR01MB148182B08E606EFE9EB6D1E79CD44A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYRPR01MB15619:EE_|OS3PR01MB7777:EE_
x-ms-office365-filtering-correlation-id: 79fd9708-5906-4256-851e-08de800ce7e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|14052099004|38070700021|7053199007|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 
 O0Z6SmCzw90fkjTsTc9gBn5GT5VQbWGTHT9V+BrQNElLzfDgD0V9xwSO9+9vFdszNQEOX7To/hDfHGtl2mxoofdtlIMvtGC9HkmH60CPf8SbK0MmU+nh9PokyYFMVOODwcXr+LXOVDY4JxfysNKJcIXMkK+uFIGCk8gUzN/oR9JBEonkRtts1ZplnN9MZgt0BmVD5a90bEiPMvpTncLIKle3Pn4qbo3mBhIzuCBQEPnIMRlEBTz4mU1Q0a1lCpovO1lhhpRojun2yOPcR7NEUr3zSAbTvZ6MWr/PZTAmz6kaimU3u6EWMmg/fQVmZJDEVjrQ9jZsLmdq4HK5AHu1FkXNkPoU9aleRPQFYlyhcJcI0bC00g0RQIDqppSVGtCI1NpMrz75eEBzEZsqkO90EinHq32MIUoh9wAW0CYkP8gjSr/pQM8wSKMYuKXffHAAncMyo030Q+qqma8JgqBQ8OrZbm3a36O28P7PB2KSdEukjddbQpTZh4LB2LEwaAlgxnKsjMeaNd+gdZldA8b5tKu1aqaS7Ki6Ezcz4PjeN+YhOflJ94v9EEdWeblyA/Vj2Rsic/MRSwAKFPIrf9tvPhXWAyw++4cOdiSnLmt4KlFQZjEiH50Bgao7ElLcRCQ8KQfvIyTuQ/W2rZY5A8jtzuZxvw7OCVhd2OFgMIznx+u1mvon945dhvsVUGcXIet2HLxCHmN3H/qgfHVwHaFGUsNZ6bKlPmZYm0M882rXdOD2V2r5gr4G7K9MTiAx9+ml
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB15619.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(14052099004)(38070700021)(7053199007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?aUR3MVgzRWR1SncrUGlHNkVWeU1UVDg5UC9WK0ptcTZuVG9zM2dUY2hR?=
 =?iso-2022-jp?B?VVMvcEx5allJeW85SEhqNm1hdC9KQVR5cS9BdXp6QWg4OFpkN0tydDJ2?=
 =?iso-2022-jp?B?VTlRZ1pQcmlIZEkvZ1M3RnRhSUJFMndtSi85Tjc5V0JDdjhtMldSc3hL?=
 =?iso-2022-jp?B?aHBmbTZpZ3UzSTZIL1ZUVXBDYksrL1ZhWUtFMDZGVzhYVGxwbitGdkZO?=
 =?iso-2022-jp?B?OWtaYk85bVJ2M1hyMVBFNE5obUFDMkFkdGp5VTcxdzI1MDFmeDlxQ0E4?=
 =?iso-2022-jp?B?eitHcmF1c3NSZkRaeE82WkVIWENBVDBRNjNjc0dYSytudlh6OW9LS3lB?=
 =?iso-2022-jp?B?dDc2UEExN21iWTBiMTVTc0Z3a1p1K1hUMnVMWFl6Z0IxaFlkZmU0NVNU?=
 =?iso-2022-jp?B?QTd0UG9adTVpazVGMVNwWC9ZNGY4Z3o4NUFNQ3NTWllzN3BBWE0rd1dQ?=
 =?iso-2022-jp?B?dzVVNC9xS0dHaWp4S3k2WUw1TzhKZHNnK2JpUnJJam5CVTVkcGJrL0pl?=
 =?iso-2022-jp?B?R0hhcWRUQi8rNFpWY0diU2UyMm1na3pJZjJjdUdXc0xtdmJReVNtQkdV?=
 =?iso-2022-jp?B?ek1BRDhKc3FLdFllZU04YjR2MjNEYmp4ZkZud25zTHFsRHN3Z3UyZmFk?=
 =?iso-2022-jp?B?eXZrdjdnR3o1dVZuRURrUzdGZFZPeWt2dFZoWW5PME1VelA5SFRHM0Fj?=
 =?iso-2022-jp?B?N3hZMS9CUVlxL0xHU0hOT0FMODdqWWZEb2VZWTk0Z1BvbjM4ZWxqcDdQ?=
 =?iso-2022-jp?B?eHY5cVNqKzRRMGdQam5zOXZsQXVpRVZRNm9SWCszMWZxcC9LQ0pmeTYy?=
 =?iso-2022-jp?B?N3ZpbXJsdEdlL0IzMXNkTi9rcDNpZDNkdmhMMTAzQnRlN1l4MEdNOFI4?=
 =?iso-2022-jp?B?bUM2dTU5eUNBejRKUC8zQ1YrdEh4SmZrcTcwR1Q0Q250QUE4Z2VNcXFC?=
 =?iso-2022-jp?B?Y05Bck8vVlYwYlJjNTk1K0IvaVVrVFhLOGx5T281bzgzbGhCU0lhR3Bw?=
 =?iso-2022-jp?B?NHVXRjErTnhma2tBUlRpNml1UUJKMjZaUGhyUnF3d1JEejR1ZUM5dTR1?=
 =?iso-2022-jp?B?YXZFK2N6Z3BwWW4vOXZlNDdOd29TUDRSK2NTdW5mNnZIRGRGdWw2djlS?=
 =?iso-2022-jp?B?bW5Wd01UUjU4MmIwelhZU1lBQ3pnYWlycU1vckM1eW53VTA5SThoV2Ev?=
 =?iso-2022-jp?B?Z3lBR2IyTXR3NGp1Z2dNa091MUJvVzI4QUpHaTlPcjRsOWlQOHNjZEFw?=
 =?iso-2022-jp?B?Z202V3FQUTJyek1TVlJwZlVXM05VeitWQS9FU0EzdVZwaTFiVmM2dU1p?=
 =?iso-2022-jp?B?VVVQaGduQndLSXNZbjdWcStqL1lBOWNSUzJpbm1QL3p5MWluSk1rclJ1?=
 =?iso-2022-jp?B?b0xvQ2xLeEtUVTBWb3RuYzlrUzFXSnNkSk9POTh1UXord2k2L24xSVRI?=
 =?iso-2022-jp?B?TEZheWRpL0M5U1o2YnZSVTk4Vm5FZXJkbWpsMzNDcXFSbW83R3U4V2dR?=
 =?iso-2022-jp?B?SGZPeTFYbnhEWWc4WlN4M2trNmt1cnZDRUpxZjA2YTR3aXlNenEvS1gv?=
 =?iso-2022-jp?B?OE1ORUNBRWJrTWE5L2RCWjh6clN3eGlnSE8rYVpVdE9rcWRUT1ZvL1pn?=
 =?iso-2022-jp?B?MlJKczNhVVJoYVVQOVNYOERTKzBKU3EzdWQrcXY5U0tWb0RSV01tdVdu?=
 =?iso-2022-jp?B?RVdUWGFUcEJDK0pZZE5nR2JsZWtYczluRXRyM0xGNDM1dkYyQlhNUE16?=
 =?iso-2022-jp?B?MlpMZktGN3VucUpmVDJtNGtPZzNaemgzUEFnSlRQeXhiNGhKQnB4N0pF?=
 =?iso-2022-jp?B?eDJXWExZeGFDbmhqdUZtMHFYbjlvQ0JYZVJhUm5TYU1RODdZREV0dytk?=
 =?iso-2022-jp?B?Wi9pTXJza3ozMzJHU25DRzhaeDVjUU1jdTlqMnNCWWhXRmVRTTVZa200?=
 =?iso-2022-jp?B?aWVJa0ZIc0paNElUdEFjZTBveXRuRlRoVzYxMWJaRENCMzBZWFpYWGc4?=
 =?iso-2022-jp?B?akZCSEpwUXNmalNGc0Z3aFFpalVBUzB0a05RRGwvZDZOK3VydWZsbW9L?=
 =?iso-2022-jp?B?QTJnM3NhK3E4Y0RsOGdSc05pQmpxc3VvQmNuaGk5OUZJQnI3NUlsNlF6?=
 =?iso-2022-jp?B?eTcrUGFEM1FCQjJUUER4Nm1DajZWclN2dDRnbDJNcFkrWmI0VDBIREl6?=
 =?iso-2022-jp?B?NXZwK1hDaEZDc1doM3NucHdFaVNhRUd6WGM3NEloMFEzYk5ET2ptZUtR?=
 =?iso-2022-jp?B?Z0o0QUxaSjZhT2FqTzUrZnlvTHhJNElrSHRtd0xvaTVOR0ZsNi9tV1pR?=
 =?iso-2022-jp?B?VGwxZU1lNktUM1VES2Z0bGVWeGg1K0dWSGM5UHVKRzlnWlZQM2NVQUIz?=
 =?iso-2022-jp?B?eWV6MkkyYmpFeVBFWlhGRE5xb3MvT09Ndkw3ZUhTc2pKQm1FRnphL3cr?=
 =?iso-2022-jp?B?amg3dDhHZy9mODFNblBQZmEyRXkxYm1weWVtMnpxOHNTR1pOV1g5eTZK?=
 =?iso-2022-jp?B?U3ZlYlhGOWlRNzdNMTFjcDdOem0yVVJtMXh3Lys1UkxMR2JzR25HY2Z3?=
 =?iso-2022-jp?B?WUFqckdNdWxoTUQ5SHZOengzN25qc1d0dVV4Lw==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB15619.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79fd9708-5906-4256-851e-08de800ce7e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 07:56:45.1233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QM+fVVNCirF29fbyiRCzt2T27vAxhsA7qK3egNcMnyiRlPkAYXtr2qXUvWZFs73XddGtStuxJn/YzK2vaRvwsZ/I0dkz0Qp+Ir1Lyl1GqzJbUF4nQt/oU+ha3YqRCdML
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7777
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Mar 2026 07:57:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22355

> From: nobuhiro.iwamatsu.x90@mail.toshiba <nobuhiro.iwamatsu.x90@mail.tosh=
iba>
> Sent: Thursday, March 12, 2026 5:23 AM
> clock
>=20
> Hi,
>=20
> > -----Original Message-----
> > From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> > Sent: Tuesday, March 10, 2026 12:06 AM
> > To: cip-dev@lists.cip-project.org; pavel@nabladev.com; iwamatsu nobuhir=
o(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> > <nobuhiro.iwamatsu.x90@mail.toshiba>
> > Subject: [PATCH 6.12.y-cip v3 11/17] spi: rzv2h-rspi: add support for u=
sing PCLK for transfer clock
> >
> > commit 1ce3e8adc7d0038e59a7c9f5c9e5f399ba0db5d6 upstream.
> >
> > The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs support gene=
rating the SPI transfer clock
> from PCLK,
> > with the quirk that SPR 0 is not supported, causing the highest achieva=
ble SPI transfer frequency to
> be 31.25MHz.
> >
> > Add support for generating the SPI transfer clock from PCLK.
> >
> > Renesas RZ/V2H (R9A09G057) also has the BPEN bit used to enable this op=
tion in the datasheet, but it
> is not explicitly
> > documented and there's no details about its limitations as there are on=
 RZ/T2H.
> >
> > Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> > Link: https://patch.msgid.link/20251119161434.595677-8-cosmin-gabriel.t=
anislav.xa@renesas.com
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> > Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> > ---
> >
> > V3:
> >  * no changes
> >
> > V2:
> >  * remove internal Reviewed-by tags
> >
> >  drivers/spi/spi-rzv2h-rspi.c | 22 +++++++++++++++++++++-
> >  1 file changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.=
c index
> f59bcadf5e38..e9d8ee919261 100644
> > --- a/drivers/spi/spi-rzv2h-rspi.c
> > +++ b/drivers/spi/spi-rzv2h-rspi.c
> > @@ -34,6 +34,7 @@
> >  #define RSPI_SPFCR		0x6c
> >
> >  /* Register SPCR */
> > +#define RSPI_SPCR_BPEN		BIT(31)
> >  #define RSPI_SPCR_MSTR		BIT(30)
> >  #define RSPI_SPCR_SPRIE		BIT(17)
> >  #define RSPI_SPCR_SCKASE	BIT(12)
> > @@ -41,6 +42,7 @@
> >
> >  /* Register SPBR */
> >  #define RSPI_SPBR_SPR_MIN	0
> > +#define RSPI_SPBR_SPR_PCLK_MIN	1
> >  #define RSPI_SPBR_SPR_MAX	255
> >
> >  /* Register SPCMD */
> > @@ -79,6 +81,8 @@ struct rzv2h_rspi_best_clock {  struct rzv2h_rspi_inf=
o {
> >  	void (*find_tclk_rate)(struct clk *clk, u32 hz, u8 spr_min, u8 spr_ma=
x,
> >  			       struct rzv2h_rspi_best_clock *best_clk);
> > +	void (*find_pclk_rate)(struct clk *clk, u32 hz, u8 spr_low, u8 spr_hi=
gh,
> > +			       struct rzv2h_rspi_best_clock *best_clk);
> >  	const char *tclk_name;
> >  	unsigned int fifo_size;
> >  	unsigned int num_clks;
> > @@ -90,6 +94,7 @@ struct rzv2h_rspi_priv {
> >  	const struct rzv2h_rspi_info *info;
> >  	void __iomem *base;
> >  	struct clk *tclk;
> > +	struct clk *pclk;
> >  	wait_queue_head_t wait;
> >  	unsigned int bytes_per_word;
> >  	u32 last_speed_hz;
> > @@ -97,6 +102,7 @@ struct rzv2h_rspi_priv {
> >  	u16 status;
> >  	u8 spr;
> >  	u8 brdv;
> > +	bool use_pclk;
> >  };
> >
> >  #define RZV2H_RSPI_TX(func, type)					\
> > @@ -306,9 +312,18 @@ static u32 rzv2h_rspi_setup_clock(struct rzv2h_rsp=
i_priv *rspi, u32 hz)
> >  	rspi->info->find_tclk_rate(rspi->tclk, hz, RSPI_SPBR_SPR_MIN,
> >  				   RSPI_SPBR_SPR_MAX, &best_clock);
> >
> > +	/*
> > +	 * T2H and N2H can also use PCLK as a source, which is 125MHz, but no=
t
> > +	 * when both SPR and BRDV are 0.
> > +	 */
> > +	if (best_clock.error && rspi->info->find_pclk_rate)
> > +		rspi->info->find_pclk_rate(rspi->pclk, hz, RSPI_SPBR_SPR_PCLK_MIN,
> > +					   RSPI_SPBR_SPR_MAX, &best_clock);
> > +
> >  	if (!best_clock.clk_rate)
> >  		return -EINVAL;
> >
> > +	rspi->use_pclk =3D best_clock.clk =3D=3D rspi->pclk;
> >  	rspi->spr =3D best_clock.spr;
> >  	rspi->brdv =3D best_clock.brdv;
> >
> > @@ -361,6 +376,9 @@ static int rzv2h_rspi_prepare_message(struct spi_co=
ntroller *ctlr,
> >  	/* SPI receive buffer full interrupt enable */
> >  	conf32 |=3D RSPI_SPCR_SPRIE;
> >
> > +	/* Bypass synchronization circuit */
> > +	conf32 |=3D FIELD_PREP(RSPI_SPCR_BPEN, rspi->use_pclk);
> > +
> >  	writel(conf32, rspi->base + RSPI_SPCR);
> >
> >  	/* Use SPCMD0 only */
> > @@ -433,7 +451,9 @@ static int rzv2h_rspi_probe(struct platform_device =
*pdev)
> >  	for (i =3D 0; i < rspi->info->num_clks; i++) {
> >  		if (!strcmp(clks[i].id, rspi->info->tclk_name)) {
> >  			rspi->tclk =3D clks[i].clk;
> > -			break;
> > +		} else if (rspi->info->find_pclk_rate &&
> > +			   !strcmp(clks[i].id, "pclk")) {
>=20
> I think strncmp is better than strcmp.
>=20

How would strncmp look when applied to this case, if you do not mind me
asking? I only see the following possibilities:

strncmp(clks[i].id, "pclk", strlen("pclk")) -> prefix match, not ok,
as it would return 0 for "pclk2" for example

strncmp(clks[i].id, "pclk", strlen("pclk") + 1) -> equivalent to strcmp

Am I missing something?

> > +			rspi->pclk =3D clks[i].clk;
> >  		}
> >  	}
> >
> > --
> > 2.53.0
>=20
> Best regards,
>   Nobuhiro


