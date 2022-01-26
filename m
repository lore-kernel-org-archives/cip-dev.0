Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC92C433FE
	for <webhook@archiver.kernel.org>; Wed, 26 Jan 2022 22:34:21 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.127])
 by mx.groups.io with SMTP id smtpd.web12.20221.1643236459282111888
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Jan 2022 14:34:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=cm2bxU+u;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.127,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpTY+0v+sQ36SqxUjBbNHT+h+3FmC15AnOTa2Ib2tlHfK6tSsmK+P8liTlgrCgAVzfF7uBFtOApc7t15lxo0ssYst466Tj3oOlscYvghs1Dz48kJVeKNbAhFHZR8isT6yt4bXAOv2Joi3FJYyM4hglVlW2iq5MoMr2scyLin077h/8/BE6s3Y1TwNJDsqEX1aLR0iUPH2097J7sblfhVA54U+g5oLDXM3+t3s6Qkio3iQ6eKeVXWUCRDAwW8QrJEoULE/ZGzXqA1DdHb6IqippFUZJqlJEevfM6JBVylttgn6DJGlGl5PbRsASZYoM9uhDlopQL4jFuEX9V0kmA8Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxdqd+5PDeoL5xWwE/BUXJQh/FuTmbhXy+mcPNS3zyU=;
 b=H5Fvqa+x9SGBaVTqPfwOvenCLuvi9uYPzWtyB9uTEBsm3LOezeZ4ev7QsZrz07lokMY8GZAa3GcNzmgrtBW5/7+Ru5DwJlkEfj5W0gN3ao8XNObhVd6C9WTut3H9di0UzEM4jj9DUsfh81RBx8f59qasGYotZL11ra/TO+fSDrJ2U0qPHR75+H5TUYTNZWFmB/lFQPReSOY3Cbi2pHteUouCuPsOB3xDSg9FiJZ3yUqD8C+H8fbzGW7OuRR7NoVCZHNnPt3yQENnZQMIhlZsT0i/Q7rwNP/lQQZy6vEeLGgLhMl+/pojGCKeX0RZT22mI5qSurQ7drWh7Fz4Uxg6Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxdqd+5PDeoL5xWwE/BUXJQh/FuTmbhXy+mcPNS3zyU=;
 b=cm2bxU+uXwV7b7XDHHB4H+lu98z+PWtsZB71YqLcDkzzTcopfBciV5VFQxJYL3AycuGBHcg9Fnjnxo7eGGNhYJWl+xJNzY6/i3LHWsSZmwFBrXVG41H1dfs8qwbX4tXrySLO77pgJ8YkWtiur5uD7An06Y0zCY8VeDlHhBZ17yA=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OS0PR01MB5666.jpnprd01.prod.outlook.com (2603:1096:604:bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Wed, 26 Jan
 2022 22:34:14 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::a5a8:3660:7f57:43f7]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::a5a8:3660:7f57:43f7%9]) with mapi id 15.20.4930.017; Wed, 26 Jan 2022
 22:34:13 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip] can: rcar_canfd: rcar_canfd_channel_probe():
 make sure we free CAN network device
Thread-Topic: [PATCH 5.10.y-cip] can: rcar_canfd: rcar_canfd_channel_probe():
 make sure we free CAN network device
Thread-Index: AQHYEwHa02eby2TASUy4nztI+sVchqx14rXg
Date: Wed, 26 Jan 2022 22:34:13 +0000
Message-ID: 
 <OSZPR01MB7019A1C696667D60C8F1EBF2AA209@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20220126202213.31975-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220126221249.GB26019@duo.ucw.cz>
In-Reply-To: <20220126221249.GB26019@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74963447-2d78-4188-3683-08d9e11bfad7
x-ms-traffictypediagnostic: OS0PR01MB5666:EE_
x-microsoft-antispam-prvs: 
 <OS0PR01MB5666C02E58114D75E5313600AA209@OS0PR01MB5666.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ZXcuhUKWzVpDta4xuxgQ9u1NqqKHPFhGwWqXjItlnNNeEm4MVBgTlk/1l818PLKrqieG3NaA007zEzj2ySZftrqp9MFLYIhSD+SEZUEE+oZreCAB0IJFq/DOq+B5qsudzsch7qBCfoG1kK62raP1UkA30RIZhPQW/97Kf1cqoEkoX69CwndXyImT9xQHPAdznawfo2F0Ny27cdu4dD8f0mey76rLE/SZLcBKlXdA1WOZrUL3LLBGDwbYMaevzDRT23UTxih7avASJ057eZfkEvHxLpwRkrvE1JKQSOBMDUrJHVXDwQdDjQK4jm/NqDEwPEC+aMSDc3EYzQaGc10A7FD46cNHSxJBMCK8LN36pkgoIYqTRSX3chJJ7bi5J4byoB2Wm6Ak7n+Ju4IQ/ZnlKVwJYmLPpgpUiU42pq0o/gLKWu1kJixc4AqOZw4e6pOzPA9sFZmeQkF0Wm8gSyHpJeeVXNtbR8uEe1v6fXDC7osz6ThOtdLxkvJlTbswfx0u7/kQbQEheOUPhkCSmbPDoGz73/UK62OCSdvCNCjqiGzeKq6/WLboPSH2neUAI0EDF8CZb7yoLQeikVL2tGOzLdDJNnCaqGrzS3ZTWR6S0Db5/H0FTLsvGrOumXRXcefbm1/kh4wsX/XBU6q3iSrV8u+m4pkrZ80LpmnAUx8ABs+6/nyaROktisW9E2LCqEXCgXVdvY1TRAdO75fArc4cDwmOJcwJAB8TXYd/Ts38pTMPnt6Saps/hbq+liw9SBTP/USx4wF4pTN4sXSyRlly/Kz8lE4jq6Jhu5WkJ5ylqD4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(966005)(5660300002)(8676002)(66946007)(8936002)(4326008)(66556008)(66476007)(66446008)(64756008)(76116006)(7696005)(53546011)(38070700005)(9686003)(52536014)(316002)(86362001)(6916009)(508600001)(54906003)(6506007)(122000001)(2906002)(107886003)(38100700002)(186003)(26005)(55016003)(83380400001)(33656002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?d/gwb2PdV3xSFJuITOGrBsbC1IXyj6afvNBe3GsGYPl9Ab4Kd9ImQwSLf8Lu?=
 =?us-ascii?Q?oxFPy0mT5S8fPgboTqiYT/QVQhky6L9l2fW5Jme+dVQ2OX0gLglZUUbyCbsd?=
 =?us-ascii?Q?ffGoJL8v5vKXuCYVWiIGyD/MtKKaKs7RKiuj3a6RtHsb6hFvIoy634em/fj8?=
 =?us-ascii?Q?VBXe+0KdcxyPUhOElKglOPWqS7wSKcgdvbbQrtx2Z/veHEx8Chka86rx3N7e?=
 =?us-ascii?Q?k2Arqd4VcPbDR/N+lBaXYL+zOQf7QlksWkUUE5NzIepwYen64FVv0nYsLcJi?=
 =?us-ascii?Q?XL1zZK2j4G0EMddR01BSppDF/tvhiRrj1rVxBhnXD9p6WlT77NOL++YPbMg7?=
 =?us-ascii?Q?yssxwgpzzXb8npEqfG+ami0jcYRas7C7Tt/o7Td4kKKLFWWAeGmgIX9PnrDF?=
 =?us-ascii?Q?77ihLd14vAM0X+MC2YZ4JjmpfY4/DI5yLG0u2twilO1TSPu2bW96qwUyD9b9?=
 =?us-ascii?Q?NWiiQEJyXinaTtowr61P46ij9FE4E6T5oKPw7hlMWSvJr48iBayXd2MqTlWx?=
 =?us-ascii?Q?0s9coHNVHTejXSI1Je7gS4djt5dBDC7TsIQRodMsf6RAAUfEZDtKQR7aXzcG?=
 =?us-ascii?Q?LZAVk9I+TBltg1va7HsrpwTVvpbkoihWnVBltA7Cheq9x+3UIBBn0+4CLzYA?=
 =?us-ascii?Q?cyv9uK3AqvGPEkdUAQmJhIo236zLrPvzXs+fDabg0Wd4QBaTyWpeHkVUUafo?=
 =?us-ascii?Q?lendYKWLKZpL0/SvHVyyKC8L73ZCKwf5ZWqY63YOG2wplDKppQCSnvrfgPey?=
 =?us-ascii?Q?PWVyRIs5wJjtjSJ7NijrHaLwJ/sY5t07bx/PgDnqPt3DU0GlOdd17gL3+Z+3?=
 =?us-ascii?Q?Bb5761IfBgJ+3eop2DvZjfjY4As5xhxl5Qp1BCTNBu/HHMSpHJ//cukyhK84?=
 =?us-ascii?Q?5F+U5P6EDaVpseLstLKOHzMfdDR9ynBCwQfy4mLwCFQ2qSePmiJ5O2CVY5J7?=
 =?us-ascii?Q?AetOhuyfLe/V0aYsIzXR/9zziX0yJcezXdl5mycBZmQyhkAGst9VlTLS4ekT?=
 =?us-ascii?Q?NOmAWP5nQaSxeIzJor22vXzF0ov4pubA8uMrRb1jLNfgj7zHrGJUknby4ZdI?=
 =?us-ascii?Q?rAOmkP+0ylSPpgwUlvZtzuth0gSsbSIBIq1aSSlZ8uZbcaKcVsI6GTvjaq/5?=
 =?us-ascii?Q?mJSQIP1JLpkvIQLW8Vk9ewliR6CW36v2dTiKxKGiAhoJI3rZsjtgLQmrohJ6?=
 =?us-ascii?Q?Kq/gqVdNCMpePW1l390yFl15gAaOVZhjSvqMW5h7IYydHCxXvtpjN0pFZGYe?=
 =?us-ascii?Q?1++XQooJ4u2mPOCWW7QKEogEK3CiRDNQYkMKOOk/GavmRkVuU05Yub8801MT?=
 =?us-ascii?Q?QqxFUrONRwL+hTFqD4/jn1lJNtSLp5pDpZ/zIyNlco/9aNJAJINoJRGn3UZX?=
 =?us-ascii?Q?2Hi213hfBS4qZ/YVcd3msKmbqqn3fVMRbmrl705mUI5vBHAgsZB00jfBVee0?=
 =?us-ascii?Q?kBlc+jdlOpWWsBLvn5m8ttRx9xzFc/l0iLdSAuBERyrqpTkUIVZ75d0ApjBP?=
 =?us-ascii?Q?Qon4/QdAfE2L7zuSaFQ0v+Q6u7BK/BmLWtIziF3vAcbk8CXq9as8I4W2w9Nb?=
 =?us-ascii?Q?yrFhp8MxfcoZZdbzDgGJLWDlyDqP/1aG6/jNUEwJ7Ex88mWv4mt7MiBrI6MF?=
 =?us-ascii?Q?QTHAnU87YWlRO8kW2sug5r/+7fW6/qmHVS6pbejeEzjHzlzw9awse2SOERdl?=
 =?us-ascii?Q?k0Q+wx8h2BagAnopydfRdEM+PyAsPZ9j2xE2Jz72JnbkzbWFJ5Om5IuDAGvn?=
 =?us-ascii?Q?4Q8Eyro/Tg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 74963447-2d78-4188-3683-08d9e11bfad7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 22:34:13.7473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 yqJhN1Xy/ad8T4ZYzHuJxa2s/ZSA3wa7Kn5o8TIggnXcjQEtqMkl7V+1wQaoJn3UEJ7inMupS+PCfQX0TsTWMWJKcFnGIMvqy9C1LK6Q/Uu0KRMb7ohFc/fFbZg5qi96
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5666
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Jan 2022 22:34:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7493

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 26 January 2022 22:13
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip] can: rcar_canfd: rcar_canfd_channel_probe=
(): make sure we free CAN
> network device
>=20
> Hi!
>=20
> > commit 72b1e360572f9fa7d08ee554f1da29abce23f288 upstream.
> >
> > Make sure we free CAN network device in the error path. There are
> > several jumps to fail label after allocating the CAN network device
> > successfully. This patch places the free_candev() under fail label so
> > that in failure path a jump to fail label frees the CAN network
> > device.
>=20
> Are they? I see fail label being unused in our 5.10 tree (but mainline us=
es it and I don't think we
> need it removed).
>=20
It is being used [0].

> But more importantly... staring at the code some more:
>=20
> 	err =3D register_candev(ndev);
> 	if (err) {
>                 dev_err(&pdev->dev,
> 	                "register_candev() failed, error %d\n", err);
> 	        goto fail_candev;
>         }
> 	spin_lock_init(&priv->tx_lock);
>         devm_can_led_init(ndev);
> 	gpriv->ch[priv->channel] =3D priv;
>         dev_info(&pdev->dev, "device registered (channel %u)\n", priv->ch=
annel)\ ;
> 	return 0;
>=20
> Device is registered before being fully ready, and I don't see anything p=
reventing the device from
> being used. Should register_candev be done last?
>=20
Good catch, do agree register_candev() has to be done last.

> (And sorry for not noticing that earlier).
>=20
No worries.


[0] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/tree/=
drivers/net/can/rcar/rcar_canfd.c?h=3Dlinux-5.10.y-cip#n1664

Cheers,
Prabhakar

> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

