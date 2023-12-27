Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B378C46CD4
	for <webhook@archiver.kernel.org>; Wed, 27 Dec 2023 16:08:52 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.91])
 by mx.groups.io with SMTP id smtpd.web11.104029.1703693322850989508
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Dec 2023 08:08:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=Tx+aPznA;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.91, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9QGSzx2AqTY+wGX8JZMbC4slOWvPvKRLa57Qk+KG996oSKHcuqftmaHMB4ycmnUTjMnlZkZrgwkEnhiSoAJSLHiLw9Bdh1STzoIWNjoNZ3Q7Vg5Q8gf7VbP/+G1ITiSewJhhIhUsEKwexPdZsYwNiEUPsMK+3VN+Yj9pLDHlkkbq4ZA+SJ5/cIy4pqvM3qR1zDQFjsEMgv66FR0n8eebl5zfp9YV7rJMh4LASvS/e8qOmniK9XIPRKebj+77S2q3ds7xWqMqOgCnXxDLNO9g59WboJy70W8rEuuJUmivOVJlCXp6GVOy9jqi4ptoYqIu1ecIavaAh4UeI35xY5PTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAYVhoVCPyLQDCrekYKEPea5OHw4p0CDO2f4Gx1lEJU=;
 b=A2V6oitzHOAygjwMxJNvQVYwKTfOgKJpKCDDOM5WXmB6b+aHbfYCutDeXnW8XBeIwigA+esQeMRE+91dD0qKL4bN81V4+VHVCiJl/JluZaFW9FqGpH3Inw1OFtmMzFjPxk3WSFc1LoXVKijX++jCEuCuF5rOuI3ONI+ohFrGJ/cNM6P915B17k6gMiQE35CFZ/ZuCGguKf420aIRJUOnrFtt4fN965Kosq4ZPI1DfypRnl8g5BR9oB8x1mQ/quyyebT4SkkQJE+45wLOTcOgO1SY9tjknQFx5vnyVusUYNuSvCGsVAsabmEQJ/4hZ46uT62FH+U00oEQ9TJT4GLfhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAYVhoVCPyLQDCrekYKEPea5OHw4p0CDO2f4Gx1lEJU=;
 b=Tx+aPznAwfHn2GdEI5GuFf9WVKHERBxMToM4uHQcv69K/jbxAWBU9c0NnZdL8IVYrOYEQ4mG741/Sc2yql2fPl3ZQUGJ+yAsoGAPNWJEHIJmS8hjbQIiC2GmZ9zJ3s2Jsa5uPkbKEZSkK7GHlCcO1ixr+qVUszaQywa/m+mO5vA=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TYWPR01MB10996.jpnprd01.prod.outlook.com (2603:1096:400:394::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Wed, 27 Dec
 2023 16:08:38 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::39b3:aad0:4e87:9926]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::39b3:aad0:4e87:9926%5]) with mapi id 15.20.7135.019; Wed, 27 Dec 2023
 16:08:38 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH RFC 28/30] riscv: dts: renesas: r9a07g043f: Add L2 cache
 node
Thread-Topic: [PATCH RFC 28/30] riscv: dts: renesas: r9a07g043f: Add L2 cache
 node
Thread-Index: AQHaM5ldJ9pQEefJtUquSfViVkl+q7C77fAAgAFoXvA=
Date: Wed, 27 Dec 2023 16:08:38 +0000
Message-ID: 
 <OSZPR01MB7019AC5DB449CCF718F59EE0AA9FA@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20231220230646.219816-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20231220230646.219816-29-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ZYsdZBWqFUjPaa3Q@duo.ucw.cz>
In-Reply-To: <ZYsdZBWqFUjPaa3Q@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|TYWPR01MB10996:EE_
x-ms-office365-filtering-correlation-id: a680e475-1611-44f7-80f3-08dc06f61677
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 G9zJ+I4+VEau71/sz0jlqcjJ+bggwdeYoXzB4hySNy9Ia319SpMNcVvDc1kxDw3L4rWKGapH6ptu8HJLjisnqL3SGQovVMGqcnGaDDltsDW7e8hv6s9yiRWoNEF1/QWJkA3Hzb7Lbgk3S96xAmqD4nt/DRNYUQMDBbIIKarEzjurN/sPOm9InIdT6safaqTRlzdnqc7kE/psIY4badT7vJ/iYy/9IpFr0sd5XAdlDpbL786k2UXGuTtXaePWjNKvim+u1vOKqQheqb6lBmFV5xBPbzmZGBLN11nDVTaNznm5c3IHFPIYVUMZT2oQXYPi/bMan8elAc5Ck+rWSDg108jtTMAkWAa8NlZofmAxZCyGIeHhqlSHfdLmcB/opn/+9Atcwf1Y+Fthyf1+BYq759PV+tDwHYbaBdugBAPZj817l7CNed0scQDZPb/pS4motbnpVFiRpkoKJiqlBFd8CZOoiJkZWUFiaLHePEbKqz7x4gaelMkWfvAVy2D5HAMAbwEgbX0/yoQtm++EMh/qivr6pvKqmA+NaJDESj5EHeqfvgjMa2akdu/ckiz4H125fda15ALZ1eKbgXw8mPuvDAGOCx3jSGXzFXtcuOJFNL4EucBWI+mTikZT4/un+b16
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(396003)(136003)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(2906002)(5660300002)(38100700002)(55016003)(86362001)(52536014)(4326008)(8676002)(122000001)(41300700001)(316002)(8936002)(4744005)(66556008)(66446008)(64756008)(66476007)(6916009)(76116006)(66946007)(54906003)(83380400001)(33656002)(26005)(107886003)(478600001)(9686003)(6506007)(71200400001)(38070700009)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?T/XImDMwJqAOBhR4DA87BrTg+oK5+8FPkbz6fVRFrIXk7gnyM3SEIHAW9qxf?=
 =?us-ascii?Q?m2sU+HImq6K1egtipr3L5HAtjuuIVvgMD7OejXN28BMJ+CZN7l6/cyS+f26O?=
 =?us-ascii?Q?CI12mZcvdbCcuD8owDTul07mBAydFkZ56vHyXfbXntTmaaSS3VNb4gen6fic?=
 =?us-ascii?Q?c+E7vhSM6OIDGcliLg8EMUjQba5yoWamNF/pg1TuOinktQriDQNcsdUvyoxm?=
 =?us-ascii?Q?iuoBySeoX3BUpTzZWqaJhqFrQhf8O5v3Uv/WhkY6gZ4bdqjZGqWz0IH/bmJp?=
 =?us-ascii?Q?LjcsyOkT5npjAw+nxGNbClHUnDiML0O1BgMZq+HiZDEOaPetUWkSbmrCoWZk?=
 =?us-ascii?Q?orvRnBDjbrjy1HkvLXrCXKfiET48afHocIfXJHbChPPByoHfLZpJ2/7TK4c5?=
 =?us-ascii?Q?eXCTL7RmMi9ow1ij7pWZ1yzIhffxW50jwk5OA/CeVKLh6VvbbBIgD/P0jvk1?=
 =?us-ascii?Q?nUX/s+WbiFCH91loX28UMZeVrgKc/TwOKtYjN4XjcbYvk4QLzCUuT5PUJMfy?=
 =?us-ascii?Q?ve3s4HSr0lo62Dmmvv4Yu5+7n/0GsVyaJouw+/JllhFLEHRf1Da3ne73ObWE?=
 =?us-ascii?Q?SF1XTH1kgjWCn2WzVVpVGIrpj8rH1wryFJ886dccpvFUOW4YF3gmnesPH64o?=
 =?us-ascii?Q?3gbwEnikkaXIntiN1CFzc8hW5Cv1HzwPByoPTbx45yL8sWHgE+jHeMMcvKNJ?=
 =?us-ascii?Q?XLOuQreUHQLEbBNndJIwUohMLQIMoiDIJpvCfe0lo+eDH/BKDpmJoKnLC6ZI?=
 =?us-ascii?Q?quBVDvQ8aYkusybPSlihYtF6VAoA3Kkl7nlmuSDgwOxcm27UJ6FN/JNhQHiB?=
 =?us-ascii?Q?t1eWBZt1kJ1QGQHM1EnTNqPKPDoQggmGyaazxqW4jpayoqjIcqX4KG7enkif?=
 =?us-ascii?Q?qDUHREJvbgvVdORTMRuTAjtjcLfi4X2uWIQPXsFsBsl0+Qd00+1fLn3Y+8EW?=
 =?us-ascii?Q?yxVrTuP8tBem46IpgjARlCDik6MAdn4UcAZFeYN72T3lLHqmLDqpnzjtsuZr?=
 =?us-ascii?Q?dqRIbZQwbTBaFet6cCcFI1inCHutx/c86PwGmHobTGv32FBJHbKwyelROSTY?=
 =?us-ascii?Q?A3Jkh1U9ZM7iogbfXgOUsA3Mg4MHiqS+lVTlImWS/hhAzz1KQc45RcRhhJWz?=
 =?us-ascii?Q?fHUWdguYflqX6VdpJ2E/dxWIPYHm0qOaXuDHNHIphyknYOxj1T2Bg8FHOjNe?=
 =?us-ascii?Q?2fitN3a8VU0inLkuzEYFy4piRecNK6les9F/NsmaKRYH8BK8DXy+fNwcAQ/Y?=
 =?us-ascii?Q?4KGBXuIfC7w2ZoaYooXlMkLYTTHCn825i6JZ6B2oVAuVrHYYkfQUIEtZH2a8?=
 =?us-ascii?Q?/I0hmskcZgYjMP1kTQshD8wE15MG464k62IM1MhL6O1XA8hONUeympteu2pl?=
 =?us-ascii?Q?V7vXCcNEw4X/ihZ7edRuni+e4M7WZeTh+vPTDpZoGOt/4yADVl4f5lqK/Tmi?=
 =?us-ascii?Q?mmnxazP3FmBg89iHhlD5RrTlBZYYayZZuVJWjKOX1sEXkYo0dCyjGCiXp1+e?=
 =?us-ascii?Q?MzzdNzsohFdoo+h6glpQZDFzMWl/ExBw5BWc5890XCyAEYr73Hxwqa5Qsuil?=
 =?us-ascii?Q?YYM2T3p+IbYDN8DozJXxmLhVpAAx/KLh17+ZnHEgUyMtHXOmqViGODJdTddX?=
 =?us-ascii?Q?pCn46L+4O3twBdt+jCc9d6M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a680e475-1611-44f7-80f3-08dc06f61677
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2023 16:08:38.8065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ymY4Px3z1qkXhD1iXEnjdJAo3iRiKHk0vKfsaz26q5KYQsorXNcEfCWg2jeILgJSCDd6z6xwvqsHSdUYAf3loZnTwrw0x5hvuZD8gLurXqlf7hfkZNz69jrTE6W7OD3V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10996
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Dec 2023 16:08:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14203

Hi Pavel,

Thank you for the review.

> Hi!
>=20
> > commit a38b1061d327c120844e5dc0217191b06ce3b25f upstream.
> >
> > Add L2 cache node for RZ/Five SoC.
>=20
> This is minor, but..
>=20
> > +++ b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
> > @@ -29,6 +29,7 @@ cpu0: cpu@0 {
> >  			i-cache-line-size =3D <0x40>;
> >  			d-cache-size =3D <0x8000>;
> >  			d-cache-line-size =3D <0x40>;
> > @@ -56,4 +57,15 @@ plic: interrupt-controller@12c00000 {
> >  		resets =3D <&cpg R9A07G043_NCEPLIC_ARESETN>;
> >  		interrupts-extended =3D <&cpu0_intc 11 &cpu0_intc 9>;
> >  	};
> > +
> > +	l2cache: cache-controller@13400000 {
> ...
> > +		cache-size =3D <0x40000>;
> > +		cache-line-size =3D <64>;
>=20
> Sometimes using hex and sometimes dec for cache-line-size looks strange.
>=20
Agreed, If there arises a chance to change this file upstream I'll update i=
t.

Cheers,
Prabhakar

