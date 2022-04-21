Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F5EC38A05
	for <webhook@archiver.kernel.org>; Thu, 21 Apr 2022 16:46:06 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.118])
 by mx.groups.io with SMTP id smtpd.web09.19933.1650538943656141709
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Apr 2022 04:02:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=mrPC3cSp;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.118,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIzCjTmCae/BAKD9D0Qhb7UppQPFtDnjVKfHJw1CJRJqglSInWJPci31VpBmEA7uxtYxY6wbW6v2lLlN8/EGQ8hCL/tPRr3OL7DKt5QQZOjEvoD4e9du7ZYuY0ftAS1pxkV+4AH4PtkJkFOv3v5v6WB0gx3lwkuCf1PPCVfVi+Usk71Wlj6k6Fpwnp+/ZKuAZCnZQLot2HdCQ7ivzpzkMCMA4+RkC1v5bqXRaH+BdTZjplyMR+1Q0SfhMdlT0rhei04jnfGTRXZYfM9DkX0qRx0ftETEGHfp38mQBHe6wNuGlq9vWpt3DtDaaq6IVBVf1lt8GGriWr2301k6qXe7VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dagPwUvDpbbmIRaNC6e+356/ltNgljpy659Ncb5+204=;
 b=ZD9t6fLc24XrDdCM13I6EXPqABbuIOqK6AW1cTTfnpHXMNnStintYXVzs4XbROd+8/yxtZr71BzeSwunxBH6V49R8yp9O2zplJGMD/h/hq8vTGA/jUw+xuYmfxom9xhjpGcebUjLRoqZ76qxLd3FJNwb6PW71aG7rKjDpqw8lyq4w8wqp5oz5D3/IIw4PKlKDrUAIP/Ooho9UWxiRMYItzv8NKc0AVDJ9I7qXtyarfuMm5pkP7idKEzGdC+bCqcSWzRe4OrzjNbnqYOwLrx0agzxtUDw6xeHlDiIe3jhc2UuJpNaQERNlOJtvs8ODtHqPC0tvtIfj6OMDbqPV1GhpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dagPwUvDpbbmIRaNC6e+356/ltNgljpy659Ncb5+204=;
 b=mrPC3cSpKZUB4WYYgYg768ewP5eb62aQdxaBmhAHk9fEk3HfftLsD9Sz0CM+Ph8IVaejThcwNQVFDi7u12p7ObK7wgb0rYTtwgwLRfsIuh+5Wcvp/CM0VifLSOl9Bdw1NolwgyzQhctCFM+8b2LYb7mL6qNX6ypniMKR/kA/Wbc=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TYCPR01MB8723.jpnprd01.prod.outlook.com (2603:1096:400:18b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 11:02:19 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::f40f:460f:2222:3dd1]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::f40f:460f:2222:3dd1%4]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 11:02:19 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 05/24] ASoC: sh: rz-ssi: Add SSI DMAC support
Thread-Topic: [PATCH 5.10.y-cip 05/24] ASoC: sh: rz-ssi: Add SSI DMAC support
Thread-Index: AQHYVVpuoCGObUGWmkGc4yj75ioBaqz6MyTA
Date: Thu, 21 Apr 2022 11:02:19 +0000
Message-ID: 
 <OSZPR01MB7019EB4D49B585A63666008BAAF49@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20220420213424.27837-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220420213424.27837-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220421083303.GB3269@amd>
In-Reply-To: <20220421083303.GB3269@amd>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5b88863-26b7-4757-0d5b-08da23866791
x-ms-traffictypediagnostic: TYCPR01MB8723:EE_
x-microsoft-antispam-prvs: 
 <TYCPR01MB872337C811EEC7AD49E09030AAF49@TYCPR01MB8723.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 liyFYOlC5I8VpKyNX/YhFZOOZcwNBvIqiBKt83niamtqSEU8Of5AfaYB+CIYPc5juZMkdS9axRn3ep4UVjR92LOe5KQkO/EpzBv6Wm7J4KRkTPYby2eS9quxdCx8NcOyxQZqoTWHpqGCNpdDYlyXU596b/f2g+DH3H1Ru95j7HkZR9tWQyJ9+Xel6KPFQpqU/Wli3qAkzXD4f16qYHOZ5tAjlqFRn1OYzJN9eDvJasBisTP/0h9fZFr2CxM92modZqDevfvXeda/dpq2CA3PLeU3KKyhLXSnRpEJdrh2ZN7DwCVTDDh7S1bLRdPPeA5GpFeojZfXTpl33Er30Cw8+sq70LZyneSZ8azq6WDv9RRplc2DM/7bO1HNCEwuk87yZKm8nsx0Dy9Vz1pOXBZ9hVGHViIizv9LDqE7mHnDFSt4YWqx4PVz/UHSWEt8ADEAEMcD9NU84hcvk7uLEBQPHiLrmaVCO4PLOajMTFgpi3Wmaatc3Qq+dirpuPyULC+mdjSquGJgIj+Am5k5dEH6zUOHm8nwTHlus51wPsVY9sGmulWGWMSXlrAhPg0sgPj6hIjBhhWD+JG0QHXCgYY8r2zgFnnNZt6TcSKVB1kBAueDFg4rD6F2lSSQgmrLI8IkQr4p1v1OeVyu3VrTWj2kLzN9DCZ/mzkQN6QxKvqsH8WPv0MiMpSCNT3L4IBsRknZV0LvN7jm5Wn31S8lw/9CqQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(55016003)(508600001)(86362001)(53546011)(7696005)(9686003)(6506007)(33656002)(6916009)(316002)(54906003)(71200400001)(38070700005)(38100700002)(122000001)(83380400001)(186003)(4326008)(8936002)(66476007)(52536014)(66556008)(8676002)(64756008)(2906002)(66946007)(66446008)(107886003)(5660300002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?MROpbR2rHvNcExgIth++gv0CSdiG1Cw5wr6IRtMImKC2ATU6mI0N80oBAyQ6?=
 =?us-ascii?Q?fPwP8vA5zvq9vAi6GU0v5cHeM88fHRld4SZqrBvZlasMe45gfHeavtigNVfN?=
 =?us-ascii?Q?cGsWfnPrklr7mdWey4AaWAgW9+EwUYLA4L+ELLCCtNFcjPKL3LomeNuwyfWS?=
 =?us-ascii?Q?EM/Mu29D0nLpwCYnBtq9l/GG9HOTrXi6yOnqI5nMi/AxJFpgwMUIoq+zHB40?=
 =?us-ascii?Q?i8sMH3MgtJB/mtBWhylpqMv387x3161EDluFtAXxAa4LfRH7//yhy3GgnJxP?=
 =?us-ascii?Q?i0/y+T4GHjhXYh4Scc3RVMaFCXfLA8+Oa7631obuXWINxlK75WMi3eoMDlYJ?=
 =?us-ascii?Q?XWMH/ddr4gVoikp9Z6LXeM/Tol05Ft+cWlhdPcQ6cdfbVa3U+U4wwBHeDyT2?=
 =?us-ascii?Q?sNKq27DQ6rJVaO1Bh1a55mEcKw9eC4V2Cn2blctk6tZdBDwojppOTEUCtz8Q?=
 =?us-ascii?Q?lsXRSuPtrL3U6WMoV3KIXioKkaloZ1gt4cqQ8VmKqjal8U2iriWBoU+3gYyN?=
 =?us-ascii?Q?X30n2BeA0LS7ChvkK5zC5nM6NiVKgWOzOd3OGGSQEz4jd4ovdqc3/MkaSLNY?=
 =?us-ascii?Q?XlbNvFHOvkKLLTOst8Wgrz2D5qP7RJGZj++JurTCaDiBV8pYxkqQiuk/ZF42?=
 =?us-ascii?Q?8PeX62LedNEMpwusXM0jcUVGgQu+cbFj/+D9e/vzJGB266nC6saRCFeB75QB?=
 =?us-ascii?Q?WhB4HwpzMSHMJWq6fjrMYTnV7QiaNJe8PZTJBL9oFY2XN9iIy3OBuRISvOhQ?=
 =?us-ascii?Q?kFHAdVZKyOl0UZYcj5j8usfNcL4ZgtYj2A7cDyXhayKjVcopWaMK5W7BectJ?=
 =?us-ascii?Q?59TyI0UBSUWmeFFODxieLi1EEuuA8ww7mTWfChBkYhDZKM16GvqkR9tXlyK2?=
 =?us-ascii?Q?DCR2oLD27DUztUxTgZD42SLNA3+JqNssA42IMYaI15IDroae9tfnsFzKcTLH?=
 =?us-ascii?Q?8BFro3iLV6Y2xlJuEyiP35geIdQkWR6YnzMflK8FNOhghAxMjLy4DlB5BHEI?=
 =?us-ascii?Q?isITXUuri73oitfF5Tv2hwApUwg8twUGLbYKZTSOI/1nQhX5FSai4arv3Ntu?=
 =?us-ascii?Q?87Tq5674tvJREwqyXyQxtevQrR7rvNwtbapJIiIlfL/2x4UtaMHxwz6cAOcT?=
 =?us-ascii?Q?wNej/b+a0O9CoSCiZ4YENAPxZXEe4OEC2osEdMs3G4eFQv+TSyjCodLZ7BOT?=
 =?us-ascii?Q?lB6DJ2eFBDA/wUW0sxVYnxEbHRD5F75uklXzMFxP6WYAkuMkbDUuF257SDtK?=
 =?us-ascii?Q?g5UGkuHLHks2y8tncNfEiCepdx8z6u/VrZHxKNk51WmFUVkjhMmiDHZStG+f?=
 =?us-ascii?Q?C74n7HxqOXafb28xBTk/ojXZIOoCg+0imuZIVRdQThXdPqM2oWSYjL+fX/95?=
 =?us-ascii?Q?3Hr6JwR8B+vSO7OyZq2oPBud3xrF82uRmmoPLs4YvfpkPJDpViUhA0ACDWkF?=
 =?us-ascii?Q?6hxu6ccCX75kI4uWbMmeYPd6igREvHN2qI4fr1jgeBlCDx3L8bfHoKQJbVUv?=
 =?us-ascii?Q?UEKL8hXfKBoaLga8Yg9H6+B4rrsE3I5m8D+WnIS295CjI9H6/7iILLg3J79d?=
 =?us-ascii?Q?irMxoUYfmeOLm6ztaSwz0jitBDLaD3VY7+LXxWrnYZGCNropvolAoPOpIx6Q?=
 =?us-ascii?Q?Hm8w/IkTsqq7vZDINylpOGqFP1XxO/qugGumoJpnwuXJ5YMjlkSidngGkutX?=
 =?us-ascii?Q?r1bFiuGtZORIgnEKYkJZ5Xz0aXZHjQ/UmFXKG+OfLRsAVC4kSjWvvEGbOdKQ?=
 =?us-ascii?Q?vjXHUvickBst5lE3Kr0oGtQnhY+WAglMc7YhlJGzMKQ5W3kbSFNK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 b5b88863-26b7-4757-0d5b-08da23866791
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 11:02:19.6027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 v18fLyta3XniiMHoTSbwjBuuxRywd7OOy01c0/bg6cpbPDjj3fO/e1UNYX0tEFbs5WqVVjV6JEun/o64d+PeZIIFPQCb7jYhTtfMW5ykAzmlR5xMPQCtELfL9c6ZyAUb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8723
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Apr 2022 16:46:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8159

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 21 April 2022 09:33
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>; Biju Da=
s
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip 05/24] ASoC: sh: rz-ssi: Add SSI DMAC
> support
>=20
> Hi!
>=20
> > @@ -775,8 +949,18 @@ static int rz_ssi_probe(struct platform_device
> *pdev)
> >
> >  	ssi->audio_mck =3D ssi->audio_clk_1 ? ssi->audio_clk_1 : ssi-
> >audio_clk_2;
> >
> > -	ssi->playback.transfer =3D rz_ssi_pio_send;
> > -	ssi->capture.transfer =3D rz_ssi_pio_recv;
> > +	/* Detect DMA support */
> > +	ret =3D rz_ssi_dma_request(ssi, &pdev->dev);
> > +	if (ret < 0) {
> > +		dev_warn(&pdev->dev, "DMA not available, using PIO\n");
> > +		ssi->playback.transfer =3D rz_ssi_pio_send;
> > +		ssi->capture.transfer =3D rz_ssi_pio_recv;
> > +	} else {
> > +		dev_info(&pdev->dev, "DMA enabled");
> > +		ssi->playback.transfer =3D rz_ssi_dma_transfer;
> > +		ssi->capture.transfer =3D rz_ssi_dma_transfer;
> > +	}
> > +
> >  	ssi->playback.priv =3D ssi;
> >  	ssi->capture.priv =3D ssi;
> >
>=20
> AFAICT rz_ssi_dma_request() allocates resources and
> rz_ssi_release_dma_channels() is needed to free them if we fail.
>=20
> But in most failure paths below, that's not done, with one exception:
>=20
Ouch you are right, rz_ssi_release_dma_channels() needs to be called in the=
 error path.

Cheers,
Prabhakar

> > @@ -829,6 +1017,8 @@ static int rz_ssi_probe(struct platform_device
> *pdev)
> >  					      rz_ssi_soc_dai,
> >  					      ARRAY_SIZE(rz_ssi_soc_dai));
> >  	if (ret < 0) {
> > +		rz_ssi_release_dma_channels(ssi);
> > +
> >  		pm_runtime_put(ssi->dev);
> >  		pm_runtime_disable(ssi->dev);
> >  		reset_control_assert(ssi->rstc);
>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

