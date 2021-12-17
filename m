Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355C1C433F5
	for <webhook@archiver.kernel.org>; Fri, 17 Dec 2021 11:12:03 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.94])
 by mx.groups.io with SMTP id smtpd.web08.4925.1639739520331099233
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Dec 2021 03:12:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=aVDl2r+t;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.94,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/hvL6ittoesDhrlGEYV+IKyMkPFijCklGMyMQufd0+kTXwDP4sExzXaTRpFQsETNQOkEi7Y1++ty3+nHeVtr6KpPcqUCtCfhtQnCBoaKCZ84XnXExuNtFkbkkeeGr8RGTXKnW9cZRRfMR5+FZ+GEVumZLJEsKJ8HsU618D9J56WZHo01jEU9E22maritqf61k86c7aYARkNHCHaObl+VdSwROXU9eVnHMja2bJIHVYmfkamEKlGANBA9xIgpk/7FPBYkSeIqLe9KTWivmKFx1Kq4vqj2466qZgurn204SK7+sJ8f4hoJt1PSjK7yldEzzbSOmTwJpEKEUOOO+r1gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YR8ncEkIbKyt7mUBQXLCNI0L0B+fiI3W65P4ptkIpag=;
 b=dIwhCUn4J3gkEaBrn3/0wC3x+XmCTfOv0tIu5v3SpIrPQDfxpsFAFQP64nNdFdBrW2GDYZaF3tUz3nO3ihKPOnxj5g9xuW3x3INqjTf2R2fZWNM1sz162VoUi4wv2N7nj/hIb0XzNDs2YdSt6i0Z1WkFFpsIGasV0HokZdUE8/FSMA45GE3qZGtMV4EXT9c+Cr3FiXm49DQYxi/oS1ED865XqbtinvkI0tKxnsFLe6eLwZdUuPdawLysrDlOAR/Hj6aOfyQN38oOCbTvgGxsQUFNCe5/VwU1HiTPaXayqXnUZ39tHpgFdxFYsCuqPcn4gVEO1OnvYuJVZYMdAKgrQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YR8ncEkIbKyt7mUBQXLCNI0L0B+fiI3W65P4ptkIpag=;
 b=aVDl2r+twaZBoTlCzAPb+E7C0pwEWuM9S88fed01uTz0NIXGm1SY9c1I4dXDc5mtp1ol6lS6DmhqrHEdX7eBE5ulNEVIlL1bF8hAYVRQcWEQFXTRGLRjGUiQHYgkY4yn3kKegWTH0JqXfJd0Chmoj1FnulFt9oK5PbF4k0CE7T4=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OSAPR01MB4228.jpnprd01.prod.outlook.com (2603:1096:604:59::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 11:11:56 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::2182:43e9:3f29:1b3e]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::2182:43e9:3f29:1b3e%4]) with mapi id 15.20.4801.015; Fri, 17 Dec 2021
 11:11:56 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 11/24] arm64: dts: renesas: Add initial DTSI
 for RZ/G2{L,LC} SoC's
Thread-Topic: [PATCH 5.10.y-cip 11/24] arm64: dts: renesas: Add initial DTSI
 for RZ/G2{L,LC} SoC's
Thread-Index: AQHX8y+PP5ElYgCbw0apMETbScFmvaw2hTAg
Date: Fri, 17 Dec 2021 11:11:55 +0000
Message-ID: 
 <OSZPR01MB7019211D88AC278EC7419B2EAA789@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20211216125446.15451-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211216125446.15451-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211217101917.GB17079@amd>
In-Reply-To: <20211217101917.GB17079@amd>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9601bd1b-8676-43c6-2136-08d9c14e0982
x-ms-traffictypediagnostic: OSAPR01MB4228:EE_
x-microsoft-antispam-prvs: 
 <OSAPR01MB4228B4EF529214C0FEAC843CAA789@OSAPR01MB4228.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 sVncskovqSoqh0qzzsC5nl/zwEF6quGlSfq13myI/dE3McRcIl34EMglfjVYzZ/w33gXvwahVuC6J7UlxEvoILysWyx3dk7n64P4bKgx8PqgmbPAer08l8roWinfNnLfNXQZqp9QqzD3ajkVYNdiE49jq5FSeUlOSQn9OrPLnxE8Khkj1JfDo6X+QGtq8jqVkFzaZtTgW1+TfPzaGsFswHYz3dXFZ0fu/VsHK7FkW9CiL8COkkuZzlj6porEVnPVMHwE39iUKovWxpWm4Uf00ZfA2ZcHd9LHnB0d36ERhNUsQJgVGLyfhN/ohq0h/6RmIBZjfFH2xkQPQfpBZ9ep6Rrm/tcseioJLw9j9jMQen5+zWiElNf1adR6ksrHAApX9IScruocYfG41iL1e8BRu5SFIHZZ7ppwub85OwV1DbpN2m1nc+Zd6euDLGa+e0DJ+E73BOyCU73ZJjvn1/2b10y6UTunjbVeeJo40QldLecIh7uBCgqf+yqFGkbPOwKYA4onfbTDQV7HhCEnI+nYgJcG3jMXSQg9/OdNGxD5jRXiun08kxnSX1kmM7L+PGT3/JCIo/hWUypQlYsKzuEUdodkFwIXyHh7GloJVDjbqbz9W8cKxApADjr0GmBQYqZrQvkY7h9ENdpksyExcjyDekKWgR+cX0hdQBw39dwhGqPaBc3Gj71o8Z7sp7da53r4BM53Nl22SJvC/CyAwsja6Q==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66446008)(66476007)(64756008)(55016003)(76116006)(66556008)(66946007)(8936002)(186003)(122000001)(38100700002)(86362001)(4326008)(9686003)(2906002)(7696005)(6506007)(316002)(26005)(71200400001)(5660300002)(6916009)(508600001)(53546011)(107886003)(38070700005)(83380400001)(33656002)(54906003)(52536014)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?AHkoPQvRNqSEHNfMA/UIWSFRYt77reS4HsTRbnHsi6NouI6AzW0TZdvnIwDg?=
 =?us-ascii?Q?TJV2Lcx4R2X6SdRy/hBgjbjlNXzOKj8YqXFOuvlg0LvoNi4oTel6tw0TrSG1?=
 =?us-ascii?Q?pADVPLIKqhwpgzkRqvu7gOl6kq67daPx+5IsAzH6oAy3O7MYqjpgefcanPSb?=
 =?us-ascii?Q?BpZYFG6f8un+ydyhRJMNFbn/cgmUwdOfxEQcswkcDkK5A+UVEXEvcrScNUMs?=
 =?us-ascii?Q?gQsHm4b+ygiML3xrndjLKqKPduxaBE8fsoIP0IYG4IvPhJXil1KBo59jhuwe?=
 =?us-ascii?Q?xCtIjWxugdVCSlrKRKJ+9ECwmGeRiIlbt7O+/dNS4hZWqb3zfY9v9E3BIYE2?=
 =?us-ascii?Q?/vxChszpV3c/QYpme5cgnonGJvhmYpFtW1ruG/EfpgFljrcKuzDrMGKnxWVp?=
 =?us-ascii?Q?D10U9eoqodRqocZAsnwLIs9WE/9N1tdQxfqGPHzqHpJDpoAFyU3MzCdoNMag?=
 =?us-ascii?Q?kZiAz/D08p/TvmxKIm8MHMT1A4ZB5HKXyp2VIYPNg1K2y8cQv/BrdqgKiHgv?=
 =?us-ascii?Q?OZXXexehxNE0/GlI7xBKjMJ/QW5HXSKgV3/8ddawcI41+2OZ4nZBbKzapi8U?=
 =?us-ascii?Q?lFyAvvzPip1mCr5V0spVs0grJIJLBz2zrQPg5qupuvbsJ8/7/BifWx9imOxs?=
 =?us-ascii?Q?Dcwwo/hwhY+CvIxSFflTLgJIWHj0/5rtkl7lnMXbdAF/A1lWPK1YUQdPDANs?=
 =?us-ascii?Q?DPB0+0pa2Mhtorr96z99sPLFK3CPFLpd9P18M/TZC9O81UM+oLDdAhpnVEmL?=
 =?us-ascii?Q?Ti01zW7q8vfKTgAn+YEH37E2VPjbJVu5ULTxbEKW9rERcNJnzqKB0DiMBrop?=
 =?us-ascii?Q?ImRLmQ4xVIxJMY7x7jg0jRwh5M/T8R2gYbX1ukXAsHsxiOACG7QtcvQ2p9H6?=
 =?us-ascii?Q?xHlcnFN6HnJGSEv7ABqWp2fPqxUdXLs23T+9HCZskkKbpwmJDe5ZoRAsK8QK?=
 =?us-ascii?Q?hUXzmIwNAchVznEUnQCiSR3ArqzX6tV4UHvXJ++6/Tl90d8+MMoQvM41u/yy?=
 =?us-ascii?Q?QAEjFs3DEWpMe5T0I+ObfclKF5/Xhf0oTGHHjypsfo8CZ5jPpkOQe90ky6df?=
 =?us-ascii?Q?P1Et3DTOvJgW455C0HIz2WToVCDsBIp4ZDzs/Dpthb4DNhObEBCh3hoL/J89?=
 =?us-ascii?Q?aWjki0OBn83EUKLUN2Z3GJB4VlxoDH/t/+uWTiOzSGl5SqY8LwRD1QxslzLk?=
 =?us-ascii?Q?sWzqR1p+jH4QooDubjYI3kgaE0jVj/Pa7j5W70mfyNeEBo3piAGhOBa0uwDf?=
 =?us-ascii?Q?e90+SEOy+p5Nl25iXwtcC11IHy94vuzNRI8YRjoDN0Ow5v2cJnsN/TMD5Czg?=
 =?us-ascii?Q?e4RrXmvHC5y/+Zf7XrD5cQPUp8A7lzg7s5uXlqZW3wSAQHtZn6N4UP39L197?=
 =?us-ascii?Q?plTCvuRln6AMsQHQPzUQKhzY46OoHSzs9M893bGulbLWe+qxkxFHqOnTMdqD?=
 =?us-ascii?Q?SCffSiVpVsRfPeg1XVSeqo4jn0RmBhXsNC/QG1WXOUfgGjGMc+4NB6W0sJ6G?=
 =?us-ascii?Q?LkefIIwXzitHWmbSqyOROfuwuB7k63ytRHA+J5uv3vN0YDSqF61BS4LXFy5W?=
 =?us-ascii?Q?ZRCi8q0zszTKv9pFmodfYtyFD18R0gcjVGV1tydtKGd5fqJTaSLW3y6P1Xpw?=
 =?us-ascii?Q?pb3UuKrF1/7jmJXJ0+F0ouaR1tNOsZ7dYi0R8ZBBUBYcjHaCBeLp3fot0F4z?=
 =?us-ascii?Q?n53DGWtYMNaPvwsqMhbLSs7gE8nga5pe5uujVlHNOXhdme2WVIWHtV2i56mJ?=
 =?us-ascii?Q?MZcxahLbgw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 9601bd1b-8676-43c6-2136-08d9c14e0982
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 11:11:55.9675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 yr9d0/d5lpk0yiqGQInl2lT/Ro24Vum0sjwVOiWL25YBZ+yBTq0SWGymmSunjjgR0gLkKL5WsknZyG90TgboaPRNBC0HuIdxp4gWd3KRUzA4unVdiMh3VD61Ol6sBZGy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4228
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Dec 2021 11:12:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7175

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 17 December 2021 10:19
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip 11/24] arm64: dts: renesas: Add initial DT=
SI for RZ/G2{L,LC} SoC's
>=20
> Hi!
>=20
> > commit 68a45525297b2e9afbd9bba807ddd2c9f69beee6 upstream.
> >
> > Add initial DTSI for RZ/G2{L,LC} SoC's.
> >
> > File structure:
> > r9a07g044.dtsi  =3D> RZ/G2L family SoC common parts r9a07g044l1.dtsi =
=3D>
> > RZ/G2L R9A07G044L1 SoC specific parts r9a07g044l2.dtsi =3D> RZ/G2L
> > R9A07G044L2 SoC specific parts
>=20
> I just want to double check:
>=20
> > +		scif0: serial@1004b800 {
> > +			compatible =3D "renesas,scif-r9a07g044";
> > +			reg =3D <0 0x1004b800 0 0x400>;
> > +			interrupts =3D <GIC_SPI 380 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 382 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 381 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 384 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 384 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-names =3D "eri", "rxi", "txi",
> > +					  "bri", "dri", "tei";
>=20
> Are the last two interrupts supposed to be same?
>=20
Yes, as "dri" and "tei" share the interrupt.

Cheers,
Prabhakar

> Best regards,
> 							Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

