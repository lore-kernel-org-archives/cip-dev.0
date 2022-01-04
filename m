X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.91])
 by mx.groups.io with SMTP id smtpd.web11.4975.1641292791128499698
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Jan 2022 02:39:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=aKek4TbZ;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.91, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OuJPQ/dSiotRMr87oJSQElBt4KF9lccnsOYISmFGm6UnA6/3Jy9qEvKIi8H9TlIKZvxogVK48G9CLdnVUruW40hRCdBrARLLXl5zCBignSD1vdLDAQDQTaRQHE8num6TY9TWow55LcdyFeRM9KU88zac2Ioq5B26GKLIaR5jBCScxUT1AKQMD1NG/ikP0VHXwBg7MalGOCVUV/Zhr7UhJflUuHIIiq4YqlxpPu21Gph/Giw2WcQwmvXCcYh2Tn1HcxoP65KNYp9YqQRymtN/iLmn1rp0D1bp2RTDKLpEF+QeaO3dSFe+3CAJbqQhSTpdoeEG61HTD5zzQECVFHICWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVOxhZF63URo6/e6Dh8Ss1EWunInNqglR/9JPZHSsKw=;
 b=dymc1+YCHtnMe419xpcBp+Z0uzLPqf4NVsY4HRMfFmyVCJmhenNpjp2+vMCGECdxBg4Flf2TtmMFuHioKtXpS3KxUVOrOlMmkueyCU4e+Paiilvn7zfiGqbm7xNaEWgrvcfuSafPg+dWXfP9GaA8lz0Mfp7NzDtFQpy2ZqjGmc0hDZlwj1OMbzIeedC+baAxALowisfxRBK7H0e59ALQv40bjPjN2qDQRacz+KQ7AlKoaUTyE7yhu3Tr2vpshiC7xYg9moU5KTivaKLPjPQEHttBwGkXpS+DUItd8ZNptk2Glr0BcbVn4tB88maKAmCEEFcxj0E8oHziy43VwO5gMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVOxhZF63URo6/e6Dh8Ss1EWunInNqglR/9JPZHSsKw=;
 b=aKek4TbZKGWZUZixtDd5HQAlSSq66hg4h0xw5QpsIlboMmf2+o0A+5dBxLi44PuVGRmJgdQIVg4445V13shTWndN9Y/CPVMfFj0GPQ28c4lxMWqrp+zlTRJxYXQPrnKhdQvtS/MXb9NbSMNvX4feEEQVzawG0nZ2vqT5vJO5HcA=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSBPR01MB4181.jpnprd01.prod.outlook.com (2603:1096:604:4d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Tue, 4 Jan
 2022 10:39:46 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3847:4115:3fbe:619]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3847:4115:3fbe:619%5]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 10:39:46 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [PATCH 5.10.y-cip 20/22] dmaengine: sh: make array ds_lut static
Thread-Topic: [PATCH 5.10.y-cip 20/22] dmaengine: sh: make array ds_lut static
Thread-Index: AQHX9aX861LilHBwvUmXPQ0yVEWUV6w+S26AgBR2tFA=
Date: Tue, 4 Jan 2022 10:39:46 +0000
Message-ID: 
 <OS0PR01MB59224B8BE3F18F57B4B5A893864A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20211220133139.21624-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211220133139.21624-21-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211222100453.GD15186@amd>
In-Reply-To: <20211222100453.GD15186@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 433c3ac8-14a7-46bd-2b0f-08d9cf6e86e2
x-ms-traffictypediagnostic: OSBPR01MB4181:EE_
x-microsoft-antispam-prvs: 
 <OSBPR01MB4181FE92E7F5FCF35BD3B7E0864A9@OSBPR01MB4181.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 dNtZO7N/jOCsi5kw+aMsPw0Evqhl4cKSA97pazVeFxFVerzMM2p4sNTZiYzcu0F81I426EGEN3DA5wFeQjwztZgMQBPkL9tRvTK7zR0RWzS4Cq/CZu/T811pxB6Ph8qW9TLSNl5XGfQEXzHLffGgU1ZVGvCmJ8cOo2WV66ms9lA+DyqLpfb7veUo4seuT0tVY8t8QQxrfordrjOS254vo82fJVupWSUqF5upaPk9twP1CM0/VJT6DyYUo0B5eTD4HE8Hj906yCphze/hYusdeSlru1qZtqqi1SGFjPg+5i/KF4KkMBBt0Xee/VfR+8STIokhe7I40ctBhqyp6GQ7EbR5LidEb1napI6HuFuijGEvC+RAR+0k0zyWA2ogfhCs3/0xp3zaBi210aL92DduNXQge9z/XB8pLT3+4jkZE3iRrbXhZ/wDiBCkKMwmwC67HilmmtEY6nT6RVqIoIPvJQi4hsVkF/v0wV8h2OU73+hwib/dquSCbSrVX5Hf5W415Rb7SXic/zhPPT+JJmCbNe1CUM1dd+u1k/fuD6MCTtlMoc9OluNNhTKEPBsmVxPKdxAJfSx6bMqekSYl4EwuFqZUbjlsD/o9DNU9CxaQKxOm6dSVwHEf0V/4Y1lHPgo/hGlBxljuxwXatHws4sBNfb4fjQ2pApcAaqBQ/jFSZTwnEZzzBiv7B4KerzJf0oKHwCjqX6UMDUskoqDP/TEWWw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(71200400001)(54906003)(6636002)(33656002)(7696005)(9686003)(122000001)(38100700002)(38070700005)(8676002)(86362001)(8936002)(76116006)(110136005)(55016003)(316002)(186003)(52536014)(26005)(64756008)(5660300002)(2906002)(66946007)(508600001)(66556008)(4326008)(66476007)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?RSns7SVoXbcvS0KRmnCvl/OgC2hz3R3dBB6yTKH/g+wJOvu01Afo2FmtXby0?=
 =?us-ascii?Q?vDmoFTcLoZ9E9Ha5CvHsSh8+EoKb7HUFAqd151NVQOClh4LHGe7Lz5pzTzC0?=
 =?us-ascii?Q?uoHOkmLA0oIY02r9x4fnzqR/PLWriaMe3HdEkj3al1DqVqKHZAbVAUgQ4Ee1?=
 =?us-ascii?Q?ukd1xVSsZX3k8YmRxVSHA1vNjYK4DpZyPLAEivv0H3rpxz/FXzV7OKFBaI+0?=
 =?us-ascii?Q?1y0LEXbzvtoQyNQqlr1wfddR41aEdOx8UUsEXq+HZAZ9khYRsZr/zaEkYTb4?=
 =?us-ascii?Q?HXVPxBhmb5GnLz3DF2eVjNCdIjVQYILaugkYWYP1+8SSqc/E7uMxYZtxjeZt?=
 =?us-ascii?Q?t7A0E94qRWONIVUHSfeOJu+1S5oqvLTlww9IxjnsSmb0lm/i0rxKGXde6Pm8?=
 =?us-ascii?Q?ZpM9o3Jaw0+0yMOpx5PiQxIP7oSwObmxmSvWLTMR1m520Z2Lg0BaVJibqM2B?=
 =?us-ascii?Q?uYF/vI2bwvF0hHKlexjX+ZfPaSh6XEK+haHHVULRykGZR506LbqMgDjYaBq3?=
 =?us-ascii?Q?2snJj4DIpuGx8JXubyrXsO3GLJwJFWVqlBtIRnz5sdGIjrsvgh8waDHR3adF?=
 =?us-ascii?Q?hD/RUl6nDZYsQb7fCLIGHl+1gi+/2Y22e/c6BsYM2s3RDsHyGPPzw1FZ+/k3?=
 =?us-ascii?Q?jsxxoC5lM3R6M9RLUHwUVTGLFz3et0V/cPbgE8+slqAJhFe/nq2LBPejevCS?=
 =?us-ascii?Q?12p9x0DEUt31Lnbulm+insJx+FXrd0vpfQZ1yzHLbMeaB16CP6cgk5nbWtaW?=
 =?us-ascii?Q?wAnfmxBCtBoBZFLtNfAeeWOU+2h0sIrKYUZhBwWD0JeuAjGyyIBhXRvMI6A/?=
 =?us-ascii?Q?icgqKFCiFip3kwG6cwjRxHLnkQicYnZSQaCmUofwAlDT/3wd3PkfbAWZIqUQ?=
 =?us-ascii?Q?qTpQ0NY9f/SAb6PSPTljFOEKloCbC/9C1lmXluZVNr5qW9zeoPmG0f5N7g9I?=
 =?us-ascii?Q?lx5DfniyMpkCHj8tVIJXqbrPrhpx8KKacKCXCC2eCJrpXUffTRdJwM8YXNVv?=
 =?us-ascii?Q?7WQ6lgDnTZPfPjoc5q6SupkH/r8EI/cGN2kMQNZrmp/adtA5unCPhmgYrPht?=
 =?us-ascii?Q?UGKS6LhSdo/e0OXz6/mr5LVls7Me1VnH0Nx90bn+2dfpPR2ni8eGarYtZoyl?=
 =?us-ascii?Q?ZQ7R/P+8iQnvAKtDoX+fUjuF0bvhNpSlZA+tdymkQVdJIgTINofAojyGPUr5?=
 =?us-ascii?Q?z8jojPibmrtMzABB04HaCkWMUmpRKHhBvELD7wSfbVdD0QSBcq1vFfsTjJcs?=
 =?us-ascii?Q?EWRG+9clVoJMOEEj1azHBwiCRfIRLR9QbHixHUHyuz05SRO95MV2Q47CWiRE?=
 =?us-ascii?Q?MnMRS3zNp2gOgtPsvS3FvHfx4yEHd6AAeUHXNsmRajMSaHj0K9iaLb2aN/ey?=
 =?us-ascii?Q?lzEO3swjB06UtAlamM9IPcWwHVEGTNyCpGeXtw62+ELu+iMzW2gZduI66FZa?=
 =?us-ascii?Q?JVlFlKc6+OHvPap2hI3Q8kUvwpdbu5WOT2600wTngLoN+2tXgWYQ1yGb7ZkA?=
 =?us-ascii?Q?ZBywcTHPMIS9TBcSsnZHCsf4uo/pZg6sONvMOKVY4SlInDB6y8RySB0wQ1q1?=
 =?us-ascii?Q?B6l0cQ7E07rTGdhPIYrGeu1xiMTCqjJU3fldO5cKhbWelToYRyiRFiibpXwA?=
 =?us-ascii?Q?ZDhw4/1GQhF4ObphFRk8JhW0+DF3m1p/f5t9OyYAPSpGyTUXqJs6OJNHD0Pk?=
 =?us-ascii?Q?jTHM5w=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 433c3ac8-14a7-46bd-2b0f-08d9cf6e86e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2022 10:39:46.5332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dDFAYeCoWr8qLTI4MZRHD81fhRAl4pUI54vvJX4G/VEOvDttNbkenx4m1UelhNaK12vC7cgHqVIDAiUDZGMnExqh+I4iyUPIX1YllXKr374=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4181
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>

Hi Pavel,

> Subject: Re: [PATCH 5.10.y-cip 20/22] dmaengine: sh: make array ds_lut
> static
>=20
> Hi!
>=20
> > commit 4c0eee50658746b0333d35a75d3db6e0aac08ef9 upstream.
> >
> > Don't populate the read-only array ds_lut on the stack but instead it
> > static. Also makes the object code smaller by 163 bytes:
> >
> > Before:
> >    text    data     bss     dec     hex filename
> >   23508    4796       0   28304    6e90 ./drivers/dma/sh/rz-dmac.o
> >
> > After:
> >    text    data     bss     dec     hex filename
> >   23281    4860       0   28141    6ded ./drivers/dma/sh/rz-dmac.o
>=20
> Heh.
>=20
> > @@ -574,7 +574,7 @@ static void rz_dmac_issue_pending(struct dma_chan
> > *chan)  static u8 rz_dmac_ds_to_val_mapping(enum dma_slave_buswidth
> > ds)  {
> >  	u8 i;
> > -	const enum dma_slave_buswidth ds_lut[] =3D {
> > +	static const enum dma_slave_buswidth ds_lut[] =3D {
> >  		DMA_SLAVE_BUSWIDTH_1_BYTE,
> >  		DMA_SLAVE_BUSWIDTH_2_BYTES,
> >  		DMA_SLAVE_BUSWIDTH_4_BYTES,
>=20
> Array could be avoided altogether; you could check for power of two and
> then count bits. That would give even shorter code, but I'm not sure abou=
t
> readability.
>=20
> I'd also not mind using usual convention here: return int, >=3D 0 success=
, <
> 0 errno.

Readability is ok with current implementation and moreover it is faster.

Otherwise, you need to check whether it is power of 2, then do count bits t=
o make sure it is bounded between
DMA_SLAVE_BUSWIDTH_1_BYTE and DMA_SLAVE_BUSWIDTH_128_BYTES and then return =
the index.

Regards,
Biju

