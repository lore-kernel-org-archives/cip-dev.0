Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B155C433EF
	for <webhook@archiver.kernel.org>; Thu, 30 Dec 2021 13:40:33 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.98])
 by mx.groups.io with SMTP id smtpd.web12.64322.1640871631729275682
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Dec 2021 05:40:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=LxIUDYbw;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.98,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIo2lXAPj0SjV2RuYvHmuTdXVOsJYqgt2FnKwkZ0vbPk1YjgdeD3PLNAMLm+L0qLNl6fpthSHfmYpuKTfffvYfdFk4bdnfPdF/cJYxN8DlecO/uobw/ctapiC/PemZrterkJ8/1imyTc6plqyQUro7VzjK4taBitBaEfqognGv39F4uKR174wM9NqtnPsvNxsi1fBU30xyU4vVGJy7v9Rr75gH/M2nUEEWJvbDo8VUq4VG7PsghAm4nUzDhSuOdEfY8FNVOyRovDCYd7E9O/16tx6KypTc91iuPnY3qPEFShcFrDM5ld24uHojO0IPiy0GRhem0Kw2IrEVUCgkEZtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7Zq5G2vCiSH2CD8qkl+ZCQIcauMza1ZNCx7msm6p4c=;
 b=DZeJ/o4t2mvQsGIR2xgIjNe9yRixCfgJzl50pZ9+fIJh4ZFvGv7haQNMS0bcB+mrP3g/HpRHktJ/Od7eaKfd5bepbPAYtd1DwT7vdKYhh5fEhQ9LXE303D4cwUfD8Wr+uuwJzpGG1qpH3YXSg66hi3Qqntq7b6Dx4esX92eTTpZv50vKc8dk4KQM1zCorIfsqCYZNxKAWXfHpTrOeckHZzMjV7kmZRCaw+jjJwqHF8UfTM576Y+b8/NJA6JI2+t+gxsLEmqpKEwIt8cr6/llH2D9afzpjppt8XqwAbkiFzYjFOqPjHsWPOhFDa662qLHd0DLhADei7oI3okw41XiQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7Zq5G2vCiSH2CD8qkl+ZCQIcauMza1ZNCx7msm6p4c=;
 b=LxIUDYbw2UO9WPXvUiJI9cG0BMCE3In1dPaPclfXT8HxKkxFNG58Wz9Syqho25eaLjfKS16xpvQ/PA7LkdwsUpaI1BSP2ryOMaKCmXox9MWz2uL4W9wyupwfRyOIHffESmNGyg1teOrrwJsbKAPE8HDB/OQbgOUejp/CQn8JqhE=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OS3PR01MB6183.jpnprd01.prod.outlook.com (2603:1096:604:d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Thu, 30 Dec
 2021 13:40:28 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::2182:43e9:3f29:1b3e]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::2182:43e9:3f29:1b3e%6]) with mapi id 15.20.4844.014; Thu, 30 Dec 2021
 13:40:28 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 21/31] arm64: dts: renesas: rzg2l-smarc: Enable
 audio
Thread-Topic: [PATCH 5.10.y-cip 21/31] arm64: dts: renesas: rzg2l-smarc:
 Enable audio
Thread-Index: AQHX/Wy+iL4f3wimk0O+0s6NEnYlT6xLCpXA
Date: Thu, 30 Dec 2021 13:40:28 +0000
Message-ID: 
 <OSZPR01MB701960F65A69F94AED7761A6AA459@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20211229101530.22783-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211229101530.22783-22-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211230110227.GC9799@amd>
In-Reply-To: <20211230110227.GC9799@amd>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e985b951-917f-48f9-393e-08d9cb99f0e8
x-ms-traffictypediagnostic: OS3PR01MB6183:EE_
x-microsoft-antispam-prvs: 
 <OS3PR01MB61830E6420230BDEEE741483AA459@OS3PR01MB6183.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:499;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 pi/Oix66ZCBJdMHTx2STyRwBBo41PrFdTdqzE+nCKtOfzqt5BY6VQw2gXgSMn5tMvgGPiMjLfxgNn23IQCnydDasi6fIKGl7uG3Ygz3c8THh9WOij/+cWdU+NhCGX8jL9yIcEM5lNIcWvy7PlLCT47d+0ck0Ka3CXkCBsyzSfWokus3XyJwSIB/x7JtnrdrptJR3xz/Kh82Mv4VZMqwB5tDi5xNciG3H8hGYizVelXNKrFG2PP9spB99iJ2c4DE3u/W7Iko8J6MmS3CXcZIzItPS+8gyv1RwbeCaWvvjbrsUZpzuv1nEJ0WIfuEiEpcntPPLhn29xFYSsgnbJaMFHvZ1WiplSmJsOfKsoQdNvszxPZ0Azq/86S0uiNLeirLDU2SGgWblklHn06M6uuQ8bplCb5c2O92WNiPXCIngXIeCgXlE6+iE6m1DmMp7vbUkuJmPpXS4cZAId5dJyUWwLq/xSvwm15vhd9loNvydcxoa+KlU443jzCs46itLBNzSuH7Y42UStFw87wwCMxCxS01ACyk+0ju4pDoWMp9rRk7dvLBJJBO5KmRbmJkJnfMplQsXF4mDPrqp0V2ChCeQIMyvetvTUdfNLSZSYFHbdng53u8psCLaWftDLAev4U8KNuPBCPpRk1VCiZ71FnEauHvBO+uvmzlcTKNQZVhZoWSGqYHZC+ZWhjB6Z/04oq2fcCXr3fuLdnQEw/YmrDwtYA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(71200400001)(54906003)(26005)(33656002)(6506007)(53546011)(9686003)(5660300002)(2906002)(186003)(55016003)(122000001)(4326008)(38070700005)(7696005)(316002)(66446008)(76116006)(508600001)(86362001)(6916009)(83380400001)(52536014)(8936002)(107886003)(66946007)(66476007)(64756008)(66556008)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?ufyADwMTJYy00X4nHWhMp5MCHHyTNQa+6Mh0h7pKSvpAN/InVVdWjAKAZrTF?=
 =?us-ascii?Q?HgPLIGWCPbK8rDXKi/fpsqspJCcFE4ob02vQlWUrY1Z4ZNUDhytDBXMFavzD?=
 =?us-ascii?Q?GP5EcMAtIlQLO4+jvr7T503bdgZ3ExKOZDfODaV0bXzXrrwL+FnV+YoAW6t1?=
 =?us-ascii?Q?GNkcH3SRnCqUIaHSb26uRBwnxikk961gTMhIyoCMS0dWA6mydWQGJtraKzOh?=
 =?us-ascii?Q?sKq46WndyVqwt8xIZyGhT0L31eERxcXq/H0K6IZqzR6oGU/fmz7cZjpTsQIc?=
 =?us-ascii?Q?BgLUJYmfYEabo8Ows5m/6XgINaj8ZJK+UZbrhwegZDcINuRXN4OJqPW7pk+f?=
 =?us-ascii?Q?zu61YhPloUti9TI+FXgIZIh23z1MENgIUwchZFVec5ZKKtcyLb4dmtGnluqo?=
 =?us-ascii?Q?uJfPBg++Fw3PfQMLm1ZUym/3NAGhz/tK+Tek5wderOrTKYL7BblJVXwnzDx7?=
 =?us-ascii?Q?zr+UhxTuBcRhBou/8sDWMLeIT7uExgBGjrnWmq16scLNDUKTW3X/Eq1FrOzD?=
 =?us-ascii?Q?exLWZDbYVUgsv6Vkqwt1Yu9lQTPgRPOb2SNex1igorg5ZkV3ZRwk8Wj/ioT2?=
 =?us-ascii?Q?m50MH4uUhjtr+uoTrfpYkuChoUT7CjDI6nBPG7sleBPTaFWYq7gt7uOd9gK1?=
 =?us-ascii?Q?HQ4PJzAj00OXHWb7nKMF9B2QKLwMZ+j2iBbQsCTDYJvGXnC4yCB9wf2k+TUr?=
 =?us-ascii?Q?wLYpLlftD/0xKYJ1jTfhfpDMZCuSEL2DxabeV6AOjFE2HvL4QT896QlkKi1C?=
 =?us-ascii?Q?V1zArmlw1mX01/h5tN6fs11KbY98rl3DxOXFi/V5r4/7zP4pK4wk4bKl2CWt?=
 =?us-ascii?Q?FzkXTgExs51PhoZBbxVztWvoKeOdz8E5S1I/FYnxyFrMALu9ly9b2uEaabrt?=
 =?us-ascii?Q?Ok+KeBaXxEpZn6d9I52fGDQOV1Z6rl3qTAzXExZBGXYD13XqSySPP8RitrBi?=
 =?us-ascii?Q?6euUJhg01L1CPvWGotU0n2C+kWohBF5zYeDJpxtw/9LwJDj47Wwu11JcxzJ1?=
 =?us-ascii?Q?3K5XdaGb9z8wqJ8xZFUqHW+bw0lK7Ko7rPVqOTLgs1h1RwqmRO8B5iOrabej?=
 =?us-ascii?Q?gL31HPFLg4+sYtyOdyCR87PIWTQTbNYDUr7M7lPlggOX8rmzc2BH9CdGwlVi?=
 =?us-ascii?Q?j/3CS2N8UyXwuMxrYNp3condk96I5GqQCiY7XlPkfx66eJktQseRzxUeyUeP?=
 =?us-ascii?Q?3iv3nXZuTXc2JUj3vWkIQbzNclTLrIwfWTA8upIl/dNUUDaNqzKZdB+gEEOd?=
 =?us-ascii?Q?buhgu9yPtHEDkx3GpSZ+Gtqn54g8Z+OFqnh2QND0WJvImAIR+GMpNcIoNAPe?=
 =?us-ascii?Q?4IkjYCFSsTYgFFvVu2PM4tSgzDmvMb6jM+DBbO8EiThBroDvXM/F+cmhEcMY?=
 =?us-ascii?Q?62hmKgbFR4NMiONpPXvcplxuLMN0/5u1FU2ul04szqQVm+ZucLhmtjaZK3nO?=
 =?us-ascii?Q?8BGeN+Oaqd9DUJPV8127gYLt5v2PjlP5SSBHVrcaW1smhZ1rf8O2NhF0iZh8?=
 =?us-ascii?Q?5zhIEoGidf4mtrFfda5vB75XTWX/Z5GHAykYLie3Qjm5EM7II8hDh8A+wjoc?=
 =?us-ascii?Q?iRidE7LQ9V2sexNEMu3TFFPv7kh/5mVeHkIp5bT2ETr4+L3ykUDTsujU10AP?=
 =?us-ascii?Q?72OFvG39DhipVxO07PaSPtV06MKqBPLXH2FP1PznzaiNqntH0UaMP1FbHZ/7?=
 =?us-ascii?Q?slSh+ty0H1ohxWSD4b7fdQO9seKyD6I8Cku4OYBz0st1y9N/WNvS9SQfBZU2?=
 =?us-ascii?Q?elpJpwkYYg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e985b951-917f-48f9-393e-08d9cb99f0e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2021 13:40:28.0885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 jPvG4shtedfRU1+TON4zHpGHjLarBw32J5yVKrEdbnCL3b2fO4C+4Wn08GjVJZ8iFNT4xm97yoE6+UTOThx692l2MteAL73GRsoAYNs5n9b4ygd+KCR4WSrwCRjITcni
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6183
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Dec 2021 13:40:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7317

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 30 December 2021 11:02
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip 21/31] arm64: dts: renesas: rzg2l-smarc: E=
nable audio
>=20
> Hi!
>=20
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > commit e396d6103343ff95874444bd8a67f031eafe0e38 upstream.
> >
> > Enable audio on RZ/G2L SMARC EVK by linking SSI0 with WM8978 audio
> > CODEC.
>=20
> > +++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
> > @@ -8,6 +8,19 @@
> >  #include <dt-bindings/gpio/gpio.h>
> >  #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
> >
> > +/*
> > + * SSI-WM8978
> > + *
> > + * This command is required when Playback/Capture
> > + *
> > + *	amixer cset name=3D'Left Input Mixer L2 Switch' on
> > + *	amixer cset name=3D'Right Input Mixer R2 Switch' on
> > + *	amixer cset name=3D'Headphone Playback Volume' 100
> > + *	amixer cset name=3D'PCM Volume' 100%
> > + *	amixer cset name=3D'Input PGA Volume' 25
>=20
> "These commands are required for Playback/Capture".
>=20
Will fix that.

> > @@ -30,6 +66,14 @@
> >  	};
> >  };
> >
> > +&audio_clk1{
> > +	clock-frequency =3D <11289600>;
> > +};
> > +
> > +&audio_clk2{
> > +	clock-frequency =3D <12288000>;
> > +};
> > +
>=20
> I'd expect spaces before {. (And yes, I'm picking nits here).
>=20
Ditto.


Cheers,
Prabhakar

