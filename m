Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1723C46467
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 18:46:47 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.98])
 by mx.groups.io with SMTP id smtpd.web09.3389.1648841380671252914
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Apr 2022 12:29:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=WmqFNHQG;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.98,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqjP52Ft11aEwajAU67bOX2wCKsebqIBvOLHv36dPxf2O9DBe8r4a3YHTCk9hfZ1Goted2OCH+4jBoId5tlPoZH4BglWYDwksJNU+qjbd9OfExjA+PNhg+GfxCf2V/MXwOQllAIEs9H67LgXkwTS9NpWNPdp52zzUvbDasDKYtj5XseMGqFx+QAcpyBI8hE2ynV5Zy1WO6U90xtirIsgzcXN7jxRVBs36eFCaXecFcWKdsZZW3CTvJz0iGpXeFhyKtt1f1d6KkB6NZpiFhKa/wBoBEoXdt3XVB57rfxGfwwT3+gRuDDpDFdt5bNQXAKYOui7l1csK14fJrnxnnpDug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cX0/zDRt/hIqtKgatrZXsNgctLvocyYtz/GnG7snLMM=;
 b=jf/e1zrGQtkAwMgUWCN1ZoUZpbmuIUMcTnlBQ2tYN/3Nv0Yy6MFvEsUMAd50adrWMGPEBmN/DY5eyW698YUZ6Je+d0c6tn4wu1A403+a+F2VFNCM6rA526LeG21/tKrGiyDynhOz4RwYlY2UmCrp0JaRQrhOSmnWTPCrPThkrtIRGXh0mCZzFD5ak5wiRLHH2Mazmchw5oVJUuSgUJhshZXIvoA3zHywS6rqoj1IR9x31NtLe+l0ccO8rTJ32doYXN64kfSkEj6ohmhCwLIB1pSTNQOX/GJs6DRwwOrKq0IjZjLihP0Ln6l+1xT3k3IB39z6sWwwTV5OhrVXQVmFVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cX0/zDRt/hIqtKgatrZXsNgctLvocyYtz/GnG7snLMM=;
 b=WmqFNHQGYOer+eA9RIJBHx9tby7elAC2p6Ig4CtMva1E+gBqJK+7VsmTq0DoJrGQ7R+hsHfLcya3pYrePA9IzKPsm9Cp+1z037WSaej1+zlG1qhm7DQcZLdkfS6Wg9u9hsZO5O5lMljr+/ACUi2UNt/1zIbx6v+F4bwQCHklywo=
Received: from TYYPR01MB7024.jpnprd01.prod.outlook.com (2603:1096:400:dc::9)
 by TY1PR01MB1595.jpnprd01.prod.outlook.com (2603:1096:403:4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.20; Fri, 1 Apr
 2022 19:29:36 +0000
Received: from TYYPR01MB7024.jpnprd01.prod.outlook.com
 ([fe80::9ad:c691:48a0:e92]) by TYYPR01MB7024.jpnprd01.prod.outlook.com
 ([fe80::9ad:c691:48a0:e92%9]) with mapi id 15.20.5123.028; Fri, 1 Apr 2022
 19:29:36 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 21/39] mmc: renesas_sdhi: do hard reset if
 possible
Thread-Topic: [PATCH 5.10.y-cip 21/39] mmc: renesas_sdhi: do hard reset if
 possible
Thread-Index: AQHYROjxPDovsM06VESDN0k7RVkl06zbc4gQ
Date: Fri, 1 Apr 2022 19:29:36 +0000
Message-ID: 
 <TYYPR01MB70248911655416A546EE08E6AAE09@TYYPR01MB7024.jpnprd01.prod.outlook.com>
References: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220330185454.10887-22-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220331102022.GE21513@amd>
In-Reply-To: <20220331102022.GE21513@amd>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc13c9f2-28f4-40c6-1c4c-08da1415f548
x-ms-traffictypediagnostic: TY1PR01MB1595:EE_
x-microsoft-antispam-prvs: 
 <TY1PR01MB15957C0DC60F58D2562B4A9DAAE09@TY1PR01MB1595.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 TtCNqmi8HWmreacv74Sd8ODmc90XtKcsvyoKI5U7YdS3ZTJuuz6dtevMHw3QiD6J/RX0JjV4ID4L66qtHwMR9zIoZcS8B5GZdTYWHPv3ZtJfLQjQXWvc1sY5bMy++wINjgYQHrhTqbfuQD2mMfQYRjiWY5un3eP+QJj6jR1WtxLijux3uVON3tyJGucRAqgVsM2E1QAnx9dJ/kPFL3+oFtRTKseG6W5rsqq2ubEcpfDb5fN3fR2Jn4a2QruBbmqYMw6PXFy3InMVwYvWKMXTCiUaSbjtq7VNNgKy5SHQFt9YnzZNpcvvhw5PNm+NB3TcO1SATLUjqiPd0TGVXlKOJghdmXTKpP6iyPNM5Nl4wyZJF24AeoHYnM6sgfjoKPgL77Uu4/x+J7LWTigM6UC7Df8eJad/RJXARVfKrq7mEC+z1z4qztEVFrETrXFAPq8VUl/qUKyl0VrNmsI0fT5HPsIgXQWsW2oetqUfinj2QXV9RZZhr9i9Y9vTWqY//KM2MCQzsLGQhGSS2cWPoYyef8jv2X+DcNGoCC5La5qHtTxSFlO5ZMy4A4J3wxfJdOxCGZl4oT3CZPw00eWJ2CZth98ZtAwu/Uei4gFp6FHAbfe+jcdp9khU+B0H86gtaerL4JrqfrwBS9g3bm/2YTRtJ+cw0ZsaLL/oOhRUAD2CPvC87TRvSkiOlxp1cq3gj2dEigGpXPd6qXV5F1K3mxOt+A==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB7024.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(7696005)(52536014)(83380400001)(6916009)(5660300002)(54906003)(71200400001)(8936002)(55016003)(508600001)(6506007)(53546011)(26005)(66556008)(2906002)(9686003)(38070700005)(107886003)(122000001)(38100700002)(186003)(64756008)(4326008)(8676002)(66946007)(66476007)(76116006)(33656002)(316002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?GZRNW50XXhdrAQctqj6rlrU7yXMkhiLaGwc9AlfmGja+rLUUMS8vsGUxpF2n?=
 =?us-ascii?Q?ohZoUAkc3a++qE5a21IArP7WfNWqu75Rpfoa7pHESNCoXOKlSg4F0Kjf2niK?=
 =?us-ascii?Q?SaRgz80RoDUrCfv5HHfDW1doK6GmswPfxw/eN8XYBVASf8EQrZf/c0JliFfF?=
 =?us-ascii?Q?4prVrVa8PoqhbW7OkZ8YPV9eOCYhC9OyFd/KgTQLDm1IvnUzpOnw6FW0MPhp?=
 =?us-ascii?Q?YeAT6BxmRdgnNPyCjPK8PgubtOkGGlC3x67iTMx2PTUnTJDtYCHeeCxEoKhg?=
 =?us-ascii?Q?q2rxQPNWveraOjMKerMrLtmIrZC5DtSn+veuXXWYlAnpyXXRaeFBAdF3IRXc?=
 =?us-ascii?Q?JkFQhaEJDhYbhBspxY11u5aGAt4JTHAVj6QpAbc5bYRHr7R8TYRigoFKFlR1?=
 =?us-ascii?Q?bkelxx6pb69c/63GKvNq7kdM6nk19OGFu8i65XeTJztaY0cHVDb34T7VTE+/?=
 =?us-ascii?Q?0a0byIywmENwpxdcisXya9AmujsO1z3Av53wnBot7tV8r6rFvvCb41Fqpwmr?=
 =?us-ascii?Q?ThC3oYt+Ep1XnHEfeWNBAFTiUCuypsLa6i7qmoq6Wy3P1bzPz5vUGhZXakBM?=
 =?us-ascii?Q?HOevp2vMd71S70oQAOVSdarySAKhbuO9eI7e8JgVblBOBkSixDY/+anA9CtU?=
 =?us-ascii?Q?z1vwM50uIjmZIgTJENMmj14p6k+FZW8bE1n7Qs9YLSsmS+88A3m/i/8llDz7?=
 =?us-ascii?Q?dyuMyGfpWpOl8D2ULrgvv6cHg8vowKDtMzu1k5UgTKZeZEtsI7KRtlo08W51?=
 =?us-ascii?Q?3+JmLC2OcTfepbrQ3u2Ibj6RMtm7M9fiUGwkMohK6rRF/qOViW5BfSetOq11?=
 =?us-ascii?Q?tGJSqu5hdGxkZfZbPVVQEVK5tylvputaX8W7j8la37gJd7O3Ks/1hQ8W4VKx?=
 =?us-ascii?Q?SG4yQuR6zxDvw6p2/hJfH028kv96KI9TgLNRU/sGFYTrn+iNPPea/H04rYzk?=
 =?us-ascii?Q?Eotd5QeQw2VEQQEGD+htTkYj5ZvCmOZMLoSY3PhkKyGF9dNmLMbfyYkB7PBM?=
 =?us-ascii?Q?knBPAiH8asT3EvNwfNbSE44MoLdN0qW9Gy4185423gMA3TXFnJm7Sq23F8i1?=
 =?us-ascii?Q?oellIcy3FUQKtD3bLpnBAIxU4ZcAdYwLO/vnXg+8KR+E4kHRNVxZlRWmpQ3T?=
 =?us-ascii?Q?SaeJgYXtGJkPMBLS+mzXvf+Z3/uvP73HioyJEZM+IgUthIDaMMh41HvyWUSb?=
 =?us-ascii?Q?srPPXuQqxJikW/hxpadZMfFf1Gf6Zk14LJHE3BnxlU0lbH7wSkqYjsp/Cftf?=
 =?us-ascii?Q?tCzkJd7yHU+0AYUVLpbdumGYGPHup6OujIvVUXWLu86zcJa7m5KOqT4Ds2dB?=
 =?us-ascii?Q?EFmgtK5jQThtiX2EW15CF6YnMF2hfuUwaOzC25akpFpNxvXRPpsrG9WnPk/O?=
 =?us-ascii?Q?CuOpAWct6ilWK1A6m2yg4yero6EUHwuDwhipqscIaIsM0O/kQcVt1F9Ysf23?=
 =?us-ascii?Q?qMq27mLtlxZ4jNB4JpO2urt80uiMXFj+989ImYDpk9TEro3N2++mmgsPjr1x?=
 =?us-ascii?Q?Zk5M8mOJNnXXPRYTUZD54MtfC/zBbpusFfv81tiW2721XpwGjCuJEulqsMo3?=
 =?us-ascii?Q?C9kNnBQpzhjLzPSt7RwI8aOjCwFySntt2cWnWmK/hwJ0xcW0LxCIaoxeL1c1?=
 =?us-ascii?Q?jBdkmahX3ZfBYuiIzSx6+withOeR90vTwzkh5Nnmr/HsMFM8yKlOIj3SMdMj?=
 =?us-ascii?Q?OQeJMrWvd66mB50hWMNhGPGIUg3cO/zyx7ZL3lrX1UzFu1wME1jZVTEKd/gz?=
 =?us-ascii?Q?nyQnYAvjE6GzwajV0aB8aTqGi2SjWeP6nLBuVEVZtE+TzKmTUrZh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB7024.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 bc13c9f2-28f4-40c6-1c4c-08da1415f548
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 19:29:36.7889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 7yLmrn3dy9b+t4ZcmB97h6cqxA/FrEzhx21kbwtdjL8rOxp+Cb2rSMjnO7XDmX40CNCCZZVJ4VOEwFMy8R8dMOARCL5E7e6mTaYf77rRE6AnaxGUp43T1XncjrUh/PgE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1595
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Apr 2022 18:46:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7908

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 31 March 2022 11:20
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>; Biju Da=
s
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip 21/39] mmc: renesas_sdhi: do hard reset if
> possible
>=20
> Hi!
>=20
> > commit b4d86f37eacb724690d0d300576b82806bc743d5 upstream.
> >
> > All recent SDHI instances can be reset via the reset controller. If
> > one is found, use it instead of the open coded reset. This is to get a
> > future-proof sane reset state.
>=20
> > +++ b/drivers/mmc/host/renesas_sdhi_core.c
> > @@ -1086,6 +1097,10 @@ int renesas_sdhi_probe(struct platform_device
> *pdev,
> >  	if (ret)
> >  		goto efree;
> >
> > +	priv->rstc =3D devm_reset_control_get_optional_exclusive(&pdev->dev,
> NULL);
> > +	if (IS_ERR(priv->rstc))
> > +		return PTR_ERR(priv->rstc);
> > +
>=20
> I believe this needs to goto to appropriate error path, not return
> directly.
>=20
Yes you are right this needs to land into appropriate error path.

Cheers,
Prabhakar

> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

