Return-Path: <fabrizio.castro.jz@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFBFEB64DA
	for <webhook@archiver.kernel.org>; Wed,  5 Jul 2023 11:16:45 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.102])
 by mx.groups.io with SMTP id smtpd.web11.14448.1688555801866302302
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Jul 2023 04:16:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=oUbv0V/n;
 spf=pass (domain: renesas.com, ip: 40.107.113.102, mailfrom: fabrizio.castro.jz@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQ/Z3R6vrwhUIIt2ei9qYS2wdijgVWs9Dabe/jSx7kF2x+A9xJ0cy77vlNzs/5vSrBnSF4mwdqC05oaegkc2gpjm78TaAnJoc766+LspdqLLx2eLw71tmjWntPu++TSbkzCqFX9NYjnHSG8UTvfxeSZlRPX3OJhPFSQlrnSHaFF+G0hQ+JsbbMjJfVS7Yue+XLIKvKkEzAOmwl74aWTAvVLlp2rJgWDc+D/Age876V0Z/uShyg8pUr0dAMpzD8SdrrmBehU9rfBMMxyxIR2wdIevSy45qUt1tiiEX03Ro+dj9iCEyB1f/XzKZYrFf9Kd7vQC95wGC9ZvozPEvKxIFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XfYVUeAkP6/2F1SGFdDm74DGkGvVbALMs+7QzzO5xC8=;
 b=VEIBFi3NeciDhSPAnBlPPqoB4eSz82tb4WSRdKNvETl2c2nYE2ShVNBWrugQDK0YiHSUvnSxdZyDGNn0XHetuH11u3PiDFf1DzQ8Fd66nr9BngAw0zNZjKGWnUOn1tpP1RTYYVw621AzCJQ0wfbTB6xCL3GAfkEApAwiIM2w04bSEaT67/ZdJ3kga0ViBzvghKKUPReRyRb/dTDvW4HrQStbC7KkIeq3U989mSym61q/ri7TwsLSjahtFLzGxfyZH1JGqa+knMQgApNQckgH5aTJJP0Kx/Dz7Dg0PRglVCuT9k0FIa6PtaRbsEmR5oHtnFSEUF9gitbr5ICZ8isPiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfYVUeAkP6/2F1SGFdDm74DGkGvVbALMs+7QzzO5xC8=;
 b=oUbv0V/nlVjZwUKm+0CoHqBtGsyw6Lv6h+vh9N2qcMZZ8key04GxDGG4aJDe9Mkx/9RTHkThpOoC/Srk5gTefuM1/oR/2fHfNWJIWhj2M52mkUUWQOUdzM9vpkkwK2Sn6gfQBaTEAo5K3VsRyA7REX5c1om9osHc/FA79P7yZUU=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by OSZPR01MB9393.jpnprd01.prod.outlook.com (2603:1096:604:1d9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 11:16:36 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::16e4:67a4:68fe:f297]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::16e4:67a4:68fe:f297%7]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 11:16:34 +0000
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH 5.10.y-cip 2/4] soc: renesas: Add PWC support for RZ/V2M
Thread-Topic: [PATCH 5.10.y-cip 2/4] soc: renesas: Add PWC support for RZ/V2M
Thread-Index: AQHZrdAmhEORTh9a+0me1+EhbGI3Ma+pBj0AgABjSvCAAKQlgIAA+I9g
Date: Wed, 5 Jul 2023 11:16:34 +0000
Message-ID: 
 <TYWPR01MB87759C9107A2C498C175EA21C22FA@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20230703170211.15484-1-fabrizio.castro.jz@renesas.com>
 <20230703170211.15484-3-fabrizio.castro.jz@renesas.com>
 <TYWPR01MB9420F2EADFD20272DE1E5588922EA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <TYWPR01MB87752AFE6723CB34DCF625C1C22EA@TYWPR01MB8775.jpnprd01.prod.outlook.com>
 <ZKR+gX4mNSKrfZes@duo.ucw.cz>
In-Reply-To: <ZKR+gX4mNSKrfZes@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|OSZPR01MB9393:EE_
x-ms-office365-filtering-correlation-id: 151d3bf1-5323-4355-d6c7-08db7d494b0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 N7qfnFi0ES3Vtu2DXRkPoySK6iWuQ6eZcjuKZdNZ8HQnaXIc1yoJayIiSO3Huy7AWVsxQ4r9FQQEnPFa7uE1jxuFfDvEgzGwhxcoVkO4FPshq3J/j39nW1LRbYzlXmQe7JhrGqOA2srxBzQVx3kZVbiFWLGo6vUkLODD9Jixv2taXcHP3IpDL60DVXNHfwHIgdPsz8BkeyNyj3r99YF+MfwYWEZOUCTUncwKC4Wtq/SLRhKU8QYU6aw2dHtYIIRiuDUtXKDbQFjaliQA5IA/RbyEHj++bli6+flQqC1kA5YLBHNGA0NQGfFwxNv/SZela8XVwSNk/YsxTPZ0StJcMEzumk4J8pxDHV2Aqx+VBItWoTLy5T7V+aKDdvf9BmDywrVJm8eRKYm3ooz+TDpKktraTkPmZg7imJe9Lf1tFLFbTQ974jKpkgwlVF0aLc2LvYPYWQFdOil/oyXWOzt79wvF5gOW5el7vPJ0lO5XMWpl7z7lago4Oz8SJBciMgScM2PhmhA8neOd2lGuTMUtg8PfcHT4uzqhIvp6+0dq5AWBG+AZyDvhooy4rUeMz78UFSwR8rNiYIqeXT/CecOfR8vFkD5gtuCU4GdmqXxTy7qrm3BYBahwkxM3QCqVnU7A
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199021)(186003)(38070700005)(38100700002)(122000001)(26005)(6506007)(55016003)(52536014)(41300700001)(33656002)(5660300002)(8936002)(8676002)(7696005)(2906002)(86362001)(4326008)(71200400001)(66946007)(9686003)(76116006)(478600001)(64756008)(316002)(6916009)(54906003)(66556008)(66476007)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?TB84fNLpToejSDIvw5reor++CS1UmEhIdRO/ElbN1jOVRt3wXWIZV0VsRTkB?=
 =?us-ascii?Q?ONHz0nENOOW/MtsVyLLCh/mrY81wI6ZO9v1BCSPzhY0MAgPGpUqePXq6Bqo/?=
 =?us-ascii?Q?tq5Wvh5Wudj/yL/wzN6NgaPY+PbESPR8k+O0ROU06wdADdbq4slOYmz4WNLC?=
 =?us-ascii?Q?T5GyqCtmzGaGRbVYwrCKDeyl0hqdPdm2FM/wvotj3ecEGA6DtCeNsXVWUjFS?=
 =?us-ascii?Q?yHitLtTLQRYJRLEXnRqDB1TNt7aHUaqOVJGXcT5UWRBE6F5yikuhTxP1yH9B?=
 =?us-ascii?Q?yPbnz3QBvt9eNCwUFOT+isdQ5IyaXzzvwVdy5pFwkTfLujbY2xTwB4ePB9bQ?=
 =?us-ascii?Q?MfYuQbniljthfeo4q+MRbBpjtdVzkaatDi/fWMxeuoVN8kxuUX8DGisF6Axd?=
 =?us-ascii?Q?Mm/wRIg0EJehu5Gw4WgUNntXpE4xo4Wk8sn3QnRXsOHWEKFcKldO/SbMC3yY?=
 =?us-ascii?Q?8g2cmSQWgAXtlSZqevrsBMJpQfSEPZgbBgerBYoxWqRcJLn+9owd8XuznPX/?=
 =?us-ascii?Q?BxCVFqV+adgedS+vK8ryv2ZTnkMncqWhasBKOId6Ovj1NYyE/SaiClue2yG6?=
 =?us-ascii?Q?KcZnzN2jhN5YLPSPci8KPhKuymoyjgU1OH5zBzyv2qJVzRf3y2Y0nWigouPm?=
 =?us-ascii?Q?hHx4aD7oY22lVvi5XBsjzKTL9oI3wws93XuwjzDhK5iMla/yBG+yTK/Cge2d?=
 =?us-ascii?Q?Cgr8+iiQgajOk9I+zimKf7Mhkv9bfeOXOnP1vK8BFkg6hnRKqU30O0F4eKiQ?=
 =?us-ascii?Q?EkiagpIYZlhnVJ+3kfcnzuU2WirX8zVKEgvGoGhPbD8EuG5zxBYyJqpWBAAf?=
 =?us-ascii?Q?WzyctS8sch39d5t68esgcWI/8np0B1Bnx+4Fi7/4KMqToq72Xkw1CdVmtyqo?=
 =?us-ascii?Q?kM2Z2tKEMMuwP9S2PPYRzIqCv/UerZKeQeUryBkww7zu5GzxgqnpjMasEIiR?=
 =?us-ascii?Q?fJF4XVvW2P1fT26HsQe6hYtNkepjNUcmY/tE/w/AgcWVp0zskRHj4TCdkPv2?=
 =?us-ascii?Q?vyJW+ZnI8RFlNKN3vibdLJWEWt7MsDazXH2L3bIGYpQNjzzO7n5kTHrjygRo?=
 =?us-ascii?Q?SupCoq/XVHYgwdOwxQn4NoQCxGR5+wa3JACus/btMiyPRkGENqWdSwjlmz8U?=
 =?us-ascii?Q?Wx+isZUrO/G/O4EApucYI+yD4FIjSJHYWDPzM8dKxAw8hOurwDfeVcENBfjr?=
 =?us-ascii?Q?PUkJunUNOkjIipBL0eAixVLXvl90fbbs/6byljXfrgRbZrQim4iDWSdhvpZZ?=
 =?us-ascii?Q?ymCx6D5p5p2USbvbFbZyu3M40IILlwkhVMSrPFlqObPfSghn2Z5+JyDfelmI?=
 =?us-ascii?Q?s4zkfJCGuJU47lklbOwq4PEZrLrYQmPnVdQtSzF8MFGBPQ1GG0+09ToZvdUb?=
 =?us-ascii?Q?zQbVoip2WasUmMePoVMkKvp1cH8C0ue2oz3tbsMYPh3t9QpQ71vC0K0iNetS?=
 =?us-ascii?Q?pgDrs7ZHjPtb9qqJAcnZSVvKkqxOCsMuVYx5lTduTyyczGoC5QF4ZJmFAH+w?=
 =?us-ascii?Q?UIPI5eCuN48nvPA7CsYoAwWoSasszgDUOHmZD71nKLKCMwGjHmD1uhaYdYg3?=
 =?us-ascii?Q?6ucMKtG16scqShengkzhv9XBhC7OXfYGeDbZdrp5YqwmudeQaPhAgoA21MXl?=
 =?us-ascii?Q?HA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 151d3bf1-5323-4355-d6c7-08db7d494b0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 11:16:34.8351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dYFtpp2fakQvtaflTjR/phRaa+BO8N2xAtnBUuTq5CBkONrbQCgik1hbaMh7OIU6L6ci5RZbzL2IDm3z0kbmmw1pDWvYjli3cckdi9DbkGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9393
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Jul 2023 11:16:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12232

Hi Pavel,

Thanks for your reply.

> From: Pavel Machek <pavel@denx.de>
> Subject: Re: [PATCH 5.10.y-cip 2/4] soc: renesas: Add PWC support for RZ/=
V2M
>=20
> Hi!
>=20
> > > > +static int rzv2m_pwc_probe(struct platform_device *pdev) {
> > > > +	struct rzv2m_pwc_priv *priv;
> > > > +	char symname[KSYM_NAME_LEN];
> > >
> > > It's not a big, but we can declare symname in ' if (pm_power_off) {'.
> > >
> >
> > I'll send a v2 for this, no problem at all
>=20
> Thank you, but I believe we should take the orignal version (and wait
> for the cleanup to reach mainline, first).

This driver looks slightly different in mainline. This driver has been
modified to make use of pm_power_off, as that's what's available in
v5.10 to hook up a power off related callback (symname was added as part
of the handling of the backported power off implementation), therefore the
cleanup recommended by Iwamatsu-san only applies to the backported version.

Thanks,
Fab

>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

