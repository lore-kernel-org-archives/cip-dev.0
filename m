Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A67C433EF
	for <webhook@archiver.kernel.org>; Thu, 30 Dec 2021 14:18:36 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.104])
 by mx.groups.io with SMTP id smtpd.web08.65033.1640873914585073151
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Dec 2021 06:18:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=VBhqX8/s;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.104,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HM2WrSLGr3c2az83kWzIDtL2m4uRVJnSgfJ3F/ar7uc6L8wypBUmWglSPRFkRDTorL/jD4UQMTtyv+PkRAeVAA9g4h3qNWphavR10u2/ULPpaQaTsjRCo/iKPpnjJtHjA0+D3YN9J3WwwxYNFTnbLOcglI4OPQDsKtMphdxqDJ7xMwZc6PPU/d8bP5zseqTp5sFH8Y7SAoEqxb1Jh6B7NqMRW34+A0poZh80waOcyXVz7u7cEIBc+tH5m35lVuD1MncOciEY+R8ELywwji2tcMN0/4uwX9Ms6r8P+asxKu0JtCgeqyt0RHLpu3BHOQTRxHcmv2YRi+Wahu6Mtw8dDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8xYx3rNdGUIgJRgW43eD5dlbjeCU20Iqu9w0kCRVwg=;
 b=ZpoIWvpErXlcavkJhVt/6fWbXjbMwBJ+j37ax0gvnYoBrv+aSU1E2EPCgw558mzhwVDpSyEz+LIh3T6/z1VNB9Rtzgn18m04bZ7Q4QCzO3lwar2Sx9YyrL3uPaKBcTLMWav1HQ48+FyVA7iE3n61BQq8xJbfBqiHQAAt4KIRWRPUaRyva7q+279PX9A4Uli5MA2400H1O/c4Wcqvw+QjoV3fzGqOqfDwUBltlTou2zG8eD0G0/7wnkYq4I1rq3IOMv1qe1DoWU0iOUrlXn+dv4V1W8wX7CIC8IcvbiX/NmyWDwYIddXScefc2yxtaB2opLirCcUKi6K464gbUPfQAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8xYx3rNdGUIgJRgW43eD5dlbjeCU20Iqu9w0kCRVwg=;
 b=VBhqX8/s6e4DU+LEBesTUUYmZDeaH4U10nloU2MlLNmilEqY+iYBnPMQbPDKqAUOW0VvxFC36bhst30pLkwQmUpgItgJbGBSsQpjhoJS7qjgH6bVPrNh4oBdV4PpelxSGQLxtncJ+ixw1wuA3N/gK8eFv7gHei05ywjU0+5OkPk=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OSAPR01MB2242.jpnprd01.prod.outlook.com (2603:1096:603:17::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Thu, 30 Dec
 2021 14:18:30 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::2182:43e9:3f29:1b3e]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::2182:43e9:3f29:1b3e%6]) with mapi id 15.20.4844.014; Thu, 30 Dec 2021
 14:18:30 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 03/31] ASoC: sh: Add RZ/G2L SSIF-2 driver
Thread-Topic: [PATCH 5.10.y-cip 03/31] ASoC: sh: Add RZ/G2L SSIF-2 driver
Thread-Index: AQHX/W6AXhxN1mgPEkiDqfv3D1/LKqxLCzCQ
Date: Thu, 30 Dec 2021 14:18:30 +0000
Message-ID: 
 <OSZPR01MB7019B90F14E42871D896F12BAA459@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20211229101530.22783-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211229101530.22783-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211230111500.GD9799@amd>
In-Reply-To: <20211230111500.GD9799@amd>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37daff04-de8c-45ce-7e9b-08d9cb9f4153
x-ms-traffictypediagnostic: OSAPR01MB2242:EE_
x-microsoft-antispam-prvs: 
 <OSAPR01MB22427B977E8D6CDC6094015FAA459@OSAPR01MB2242.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 qZ1TQRcshRowk3z+6PbC3ebeOSBH9RJ9+62W/V1txXqdJYP8bHfcnhXJlBllkM5Pg+MHXa1C6iKLmjWZ5+rA8Xgv2nZjKtA4nzK6y6NfT0rDXeX9J6IFWoncF7IOb6wAATBMRhFLbWckkkEHZEF3w60SwxE1p3bgby7CdICg8TaChJA95nFKWbBIsEg9JXckDfj9aOWQTCwfa2MVlm6unNL1m+vHNn/fOucjFrwmocSRbCObeyh49m6IOCkVUUTkqx7Hyp+vcBb2oz6bogW/DJqET/85o65z7pXbzVprdHr+D1+0VQKnJY0VsPwPzfQMOJjDiF0M0KD8gQ9Fqj9ug5MdWZpahCAwTsWE5keCW4UhwLLPCsLzBzBC97TSHVsMgBQ1xOHt2Yk38kb+WKkU549Lg/rxo+k949lzbamDk1R+q6REb3ilPXAmvChV3+OGjv7P3a784AXGSmK6CDsmzXFZV5Hu3FLBE7Rw1HLsM2Tcwil8I6vUPdvweTmC0qfrKjL3nLMCe4waKD+b5nvWszfEPny5vrXQglI8R2ZRMsjol8W96RWvDVzEpwesfg5B7NhtsikjLw4G03o4wLLBfbYiuoTmLdmpLMUVt/Y4tFEWEyfliUfUzHUMmusVVxra+KWW/exv0gKR00Z4Osl+RSiAWwg2iImCP6mgsrW4hP9e2anlmEEJlH9hCEge/VWBauIUUq9AClm6Iy8OMQEZ6A==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(6916009)(107886003)(7696005)(71200400001)(66556008)(38070700005)(86362001)(53546011)(122000001)(38100700002)(26005)(66946007)(66476007)(76116006)(83380400001)(186003)(316002)(508600001)(55016003)(54906003)(52536014)(66446008)(9686003)(64756008)(5660300002)(33656002)(8676002)(2906002)(8936002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Q14wbyaYGNRfOYzBwIuiIahrV0K2f0dwcJ0dI5ODNQ2iXvlOKYCXU7zp5/fM?=
 =?us-ascii?Q?3khd7I+JKjA6RQVZU+b2dFapOXpl+9VeqRSefvWW1K8VFonIwFX+seLFfmqN?=
 =?us-ascii?Q?Nv/USDCrwxdV62yMavPLBmWdCekeim+SaTxfKFte6CB0uMxlIzClc0Lfdkxg?=
 =?us-ascii?Q?1T2AImMYbHLgEvnDDY23VvktK2W5TQWmiKYqVoW46gO0zaozRara7aXklesz?=
 =?us-ascii?Q?49Npp3kLLNOKk6yxDBeSyr4N0o7k2mopgu8bO2D/6toSv8O4kh8cXlwgnV2P?=
 =?us-ascii?Q?z7P6VSBl6C2iQOJfbs8uf24t1ZErddFGZH+LaPM+LS1V2yyznE4GGaDmm3LA?=
 =?us-ascii?Q?jmMq9I0cNoWO5Zisz4DQmW1umdmrIrXxRG5JDcesnUACaK9RRtf4IzWma+nG?=
 =?us-ascii?Q?GYEmgzo+zfRBZleF1rG18UXg5QIKqgE5ekbwFQmJfKjL/i3YZPeKnKVw+o5/?=
 =?us-ascii?Q?hZRbXU+A94iI/ch+1J/blkSRJ5g5N8YY2A1CbanoxX69atWZgcNustqE4uuo?=
 =?us-ascii?Q?gYbiRpNQ47kJRbz+jHVACChCivoNaM1CZELdiEI8kW/kj+UmBcZ70ReAncch?=
 =?us-ascii?Q?PEnHTEklGAAYMYsJFomFrOSQONJZwn+1qzx44tzQUM4QTn4qgNqDHqCbwtof?=
 =?us-ascii?Q?5tDriokeGut3AowF2sYOD88WTCEIJAyDY2It8Vbk4MajlcNFWNKeivudql2M?=
 =?us-ascii?Q?BRoEWC1wYr+9XXJsa+6K1phg7JKOlXZmzLgSLEyUlK7w3YqaYIiESr1HpjHZ?=
 =?us-ascii?Q?rzny9VRqE24GY3vUhn5sj/D9hjNE/DRZ5hbU1C7ae1AEPF0QOrP5sc5Ww8i/?=
 =?us-ascii?Q?q67vMsWe7RjzwGydJ2FyH/LsQGvTFEGbcwy+WiHubvLxcRolP9PY75MQTg+Z?=
 =?us-ascii?Q?g8Rybziw7BG6rLs51fjK30jiOZspQBRJxlYyg5rtHlIbrfpchDQa5CERlIuL?=
 =?us-ascii?Q?A8VH0m94ug3eFCyI9PxLnmK0+GVRarcHgzkshvUBRB9ue+qHYhsaubcwEU65?=
 =?us-ascii?Q?fZnM6t1mosW1kxTDLtAZVWPj8IF+zauP4bsMMY0srY/v+pdUrxNUV6Umg6qL?=
 =?us-ascii?Q?o0tbxg7mQTKl2GUEAZa6BrZOnGFvPtDcSOdEhDn+r+0N8HV7FjNCMibXEYtu?=
 =?us-ascii?Q?uZ+l6fg9kf+a47nWspMXtsqNasPRgDB02sm4C6UWFGwsfHBs1anikPnF2VeD?=
 =?us-ascii?Q?keHojfci+/QZZZ8wHynbouc7BKrzWhQoz6WhhpPevWKz0Qyls8/KD8pcV/4P?=
 =?us-ascii?Q?u1Dfofr6H1tvLtEjEFhkAq8RpUWEAF1U1QSltyIwH9B6e5QAc0H2TJ8nlPGw?=
 =?us-ascii?Q?7MrbvZuNHiQ4e5JKjU0FSkr20eJp88ADmCAOOd5CShiwGHvq3fMXgU9suvaH?=
 =?us-ascii?Q?W8B1ZsIrHhK6fITezV1Ej6wiApXNuFifh84SRNON4syPIYZW+wJzR0r0lfgD?=
 =?us-ascii?Q?+8/L08mcICdfKpSzEswEi8Ks/K0ZaY4RYi5ho9JDRkPwg496jV2DldO/63I7?=
 =?us-ascii?Q?xKtB4shpfveFKkuG+568sLVgdzyjDTrlJnFfe1eoRRCvfQTcEgQALn038e3g?=
 =?us-ascii?Q?2PCPEkBfpJggEnHvk6Qr3kNr/f1Uv18hSm6doIEBABqAPGXk5ydh3J7X6emA?=
 =?us-ascii?Q?VeHPEkdEpUyCmmeldY7HCtFZnB0biaSbhKDJ1wjBWRdviYXN7vxAcNc3KQlW?=
 =?us-ascii?Q?dSGZyl975QGmeeMKwZE9+GbxMkFVNfUwYsLPczvtJfrJAATcJAugkPYlWxvA?=
 =?us-ascii?Q?Qz9/mpqiHQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 37daff04-de8c-45ce-7e9b-08d9cb9f4153
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2021 14:18:30.5240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 nS+3ZmrXbAY10oSqcq6zFM5vKIUn2ciAbLwjXlXDeEovxDCfw0zw1GkRabbq2Ao0OUvEOn3fXvl85bIIpJHSO5fgUnnoijvWgg+0CrMpNMbOf42acJOktlGgAu7tOPQ1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2242
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Dec 2021 14:18:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7318

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 30 December 2021 11:15
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip 03/31] ASoC: sh: Add RZ/G2L SSIF-2 driver
>=20
> Hi!
>=20
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > commit 03e786bd43410fa93e5d2459f7a43e90ff0ae801 upstream.
> >
> > Add serial sound interface(SSIF-2) driver support for RZ/G2L SoC.
> >
> > Based on the work done by Chris Brandt for RZ/A SSI driver.
>=20
> I'm not sure what the locking rules are here.
>=20
> > --- /dev/null
> > +++ b/sound/soc/sh/rz-ssi.c
> > +static int rz_ssi_stream_is_valid(struct rz_ssi_priv *ssi,
> > +				  struct rz_ssi_stream *strm)
> > +{
> > +	unsigned long flags;
> > +	int ret;
> > +
> > +	spin_lock_irqsave(&ssi->lock, flags);
> > +	ret =3D !!(strm->substream && strm->substream->runtime);
> > +	spin_unlock_irqrestore(&ssi->lock, flags);
> > +
> > +	return ret;
> > +}
>=20
> Nit: I don't think !!() is useful here, as it is boolean expression anywa=
y.
>=20
Agreed can be dropped.

> But I notice that code is very careful to access strm->substream with spi=
nlock held.
>=20
...
> > +static void rz_ssi_pointer_update(struct rz_ssi_stream *strm, int
> > +frames) {
> > +	struct snd_pcm_substream *substream =3D strm->substream;
> > +	struct snd_pcm_runtime *runtime;
> > +	int current_period;
> > +
> > +	if (!strm->running || !substream || !substream->runtime)
> > +		return;
>=20
> But here we do same checks, and this time without the spinlock?
>=20
... agree we need to lock...
> > +static int rz_ssi_pio_recv(struct rz_ssi_priv *ssi, struct
> > +rz_ssi_stream *strm) {
> > +	struct snd_pcm_substream *substream =3D strm->substream;
> > +	struct snd_pcm_runtime *runtime;
> > +	u16 *buf;
> > +	int fifo_samples;
> > +	int frames_left;
> > +	int samples =3D 0;
> > +	int i;
> > +
> > +	if (!rz_ssi_stream_is_valid(ssi, strm))
> > +		return -EINVAL;
> > +
> > +	runtime =3D substream->runtime;
>=20
> Again, access without locking.
>=20
... and here too.

> > +	/*
> > +	 * If we finished this period, but there are more samples in
> > +	 * the RX FIFO, call this function again
> > +	 */
> > +	if (frames_left =3D=3D 0 && fifo_samples >=3D runtime->channels)
> > +		rz_ssi_pio_recv(ssi, strm);
>=20
> Here we call ourselves recurively. Without checking the return value.. bu=
t more importantly recursion
> is unwelcome in kernel due to limited stack use.
>=20
>=20
Agreed, this needs to be handled differently with recursion removed.

> > +static int rz_ssi_pio_send(struct rz_ssi_priv *ssi, struct
> > +rz_ssi_stream *strm) {
> > +	struct snd_pcm_substream *substream =3D strm->substream;
> > +	struct snd_pcm_runtime *runtime =3D substream->runtime;
> > +	int sample_space;
> > +	int samples =3D 0;
> > +	int frames_left;
> > +	int i;
> > +	u32 ssifsr;
> > +	u16 *buf;
> > +
> > +	if (!rz_ssi_stream_is_valid(ssi, strm))
> > +		return -EINVAL;
>=20
> Access without locking before verifying that stream is valid with the loc=
k. This is wrong.
>=20
rz_ssi_stream_is_valid() does lock/unlock to check stream validity.

> > +static irqreturn_t rz_ssi_interrupt(int irq, void *data) {
> > +	struct rz_ssi_stream *strm =3D NULL;
> > +	struct rz_ssi_priv *ssi =3D data;
> > +	u32 ssisr =3D rz_ssi_reg_readl(ssi, SSISR);
> > +
> > +	if (ssi->playback.substream)
> > +		strm =3D &ssi->playback;
> > +	else if (ssi->capture.substream)
> > +		strm =3D &ssi->capture;
> > +	else
> > +		return IRQ_HANDLED; /* Left over TX/RX interrupt */
>=20
> You mark interrupt as handled even when it is not. Probably not a problem=
 w/o shared interrupts.
>=20
ATM the interrupts aren't shared so this should be OK.

> > +static int rz_ssi_probe(struct platform_device *pdev) {
> ...
> > +	/* Error Interrupt */
> > +	ssi->irq_int =3D platform_get_irq_byname(pdev, "int_req");
> > +	if (ssi->irq_int < 0)
> > +		return dev_err_probe(&pdev->dev, -ENODEV,
> > +				     "Unable to get SSI int_req IRQ\n");
> > +
> > +	ret =3D devm_request_irq(&pdev->dev, ssi->irq_int, &rz_ssi_interrupt,
> > +			       0, dev_name(&pdev->dev), ssi);
> > +	if (ret < 0)
> > +		return dev_err_probe(&pdev->dev, ret,
> > +				     "irq request error (int_req)\n");
> > +
> > +	/* Tx and Rx interrupts (pio only) */
> > +	ssi->irq_tx =3D platform_get_irq_byname(pdev, "dma_tx");
> > +	if (ssi->irq_tx < 0)
> > +		return dev_err_probe(&pdev->dev, -ENODEV,
> > +				     "Unable to get SSI dma_tx IRQ\n");
> ...
>=20
> So you registered interrupt handlers...
>=20
> > +
> > +	ret =3D devm_request_irq(&pdev->dev, ssi->irq_tx, &rz_ssi_interrupt, =
0,
> > +			       dev_name(&pdev->dev), ssi);
> > +	if (ret < 0)
> > +		return dev_err_probe(&pdev->dev, ret,
> > +				     "irq request error (dma_tx)\n");
> > +
> > +	ssi->irq_rx =3D platform_get_irq_byname(pdev, "dma_rx");
> > +	if (ssi->irq_rx < 0)
> > +		return dev_err_probe(&pdev->dev, -ENODEV,
> > +				     "Unable to get SSI dma_rx IRQ\n");
> > +
> > +	ret =3D devm_request_irq(&pdev->dev, ssi->irq_rx, &rz_ssi_interrupt, =
0,
> > +			       dev_name(&pdev->dev), ssi);
> > +	if (ret < 0)
> > +		return dev_err_probe(&pdev->dev, ret,
> > +				     "irq request error (dma_rx)\n");
> > +
> > +	ssi->rstc =3D devm_reset_control_get_exclusive(&pdev->dev, NULL);
> > +	if (IS_ERR(ssi->rstc))
> > +		return PTR_ERR(ssi->rstc);
> > +
> > +	reset_control_deassert(ssi->rstc);
> > +	pm_runtime_enable(&pdev->dev);
> > +	pm_runtime_resume_and_get(&pdev->dev);
> > +
> > +	spin_lock_init(&ssi->lock);
> > +	dev_set_drvdata(&pdev->dev, ssi);
>=20
> But only here you have data structures ready to handle the interrupts. Yo=
u won't see obvious problems
> w/o shared interrupts, but I believe there are debugging modes that trigg=
er this intentionally.
>=20
But the devm_snd_soc_register_component() is after this so it should be OK =
I believe unless there is a spurious interrupt which will trigger the handl=
er.

Cheers,
Prabhakar


