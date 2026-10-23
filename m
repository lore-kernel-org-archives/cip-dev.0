Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11161.1792773040417002764
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 Oct 2026 09:30:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=rTo8UKS2;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.53, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+aXzHxMDQaYDqqjnDDD8mV39IiatYKTz41Ze67/6ctY1H7jvR+4djT19jkUyIBqcH30M3z9kTAZCW4rp5TRzKQCFS7dk3qe1GW6fzd/ZswtGY1+Pj4KMCjQaAWs1jc5X2rAIrnGHN+/BwAjAJXarJyu/jAw5hvD8IJBVhRUBJvQHyzcUHwvUMj4xXNDMliGtUQ3vqD4wSegSONnDBaXvjC64fkjbgQG85utwNQ/AwWGVfkmAc8Q5aLqHuRwgfTUALWnDLr8qkmmATVZG5sfQXAhW2XtNzw1c47C63Ibqkiqcp7DZSrjzm7dwuUh3xN37/Ne8y0LPO+44VcfLqw1Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmZ1g5IvRw6pqvu4M0q4WvIEA1rBfNV76A3T1e/M2N8=;
 b=E3MjJoImRnCvikbwC+bqVTyqD010N1A/MYdNRQlrxhk+hLs05D55Ak+2pfRX4k4cEq5z1eHpNLIPK3EJqlHsGpAJTDT3EELbp9jpVV2yjtNebb8eF5F8tLPzkfVqNOsbS8aYOWt4kJGZMaHmQhhvPwUQdbbTqWv9ok+Yctw9Sy6Yq0/Q1kAtV/fqANbXhtOmi8yuwmwFd8Er3AJIbhw/uLPRUlsGsQUYfTULPJ/5+Z2d1ov7S8kIDEK+X09oEJhk0XXfAtMsPfCcMp9RalLHL1ZWARISU1tFtnFkG17+Lb+Vnc0QFTTOvxxg6kpO05ba7FBYWZlaqUssNSruobiadA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmZ1g5IvRw6pqvu4M0q4WvIEA1rBfNV76A3T1e/M2N8=;
 b=rTo8UKS25qowE/d7nhaEIjudRPv3QytJ99EWySgh6T1ox0WPGVw7eaFGeco7xL6tVh5f5oiviipfYkTDXk0J+CbtkJYyMhvfxuyb0GAVinkA2uKzzfuQwYneXbubInxplbWwAlJddBHrAzAf4IMVLC2ubx4dTCk8/jjUMU6zFHI=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYYPR01MB13512.jpnprd01.prod.outlook.com (2603:1096:405:1c0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Fri, 23 Oct
 2026 16:30:34 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0496.021; Fri, 23 Oct 2026
 16:30:34 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "pavel@nabladev.com" <pavel@nabladev.com>, "biju.das.au"
	<biju.das.au@gmail.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 4/5] arm64: dts: renesas:
 r9a08g046l48-smarc: Enable rsci{1,2,3} nodes
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 4/5] arm64: dts: renesas:
 r9a08g046l48-smarc: Enable rsci{1,2,3} nodes
Thread-Index: AQHdYiruBBTlKdocaU6Z7BCT0XnXXbcJ/BQAgAFV1FA=
Date: Fri, 23 Oct 2026 16:30:34 +0000
Message-ID: <TY3PR01MB113463D3EAC53C4C1AE74E76586642@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20261022134021.217964-1-biju.das.au@gmail.com>
 <20261022134021.217964-5-biju.das.au@gmail.com> <atprvF6_zDyUihQD@duo.ucw.cz>
In-Reply-To: <atprvF6_zDyUihQD@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYYPR01MB13512:EE_
x-ms-office365-filtering-correlation-id: bdb892f3-27ea-48c8-2e36-08df3122f654
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|22082099003|18002099003|10067099003|4143699003|11063799006|261009223027099003|261021121427099003|38070700021|56012099006;
x-microsoft-antispam-message-info: i2E9LN3jMQV06q2jHidFgKdAqP7HJ9MnEcXtAriudwhrX37q7fJpFNpnSGx5iC4ex6kD18s2b9bLDHWC2MZx4YVh1vsbmMmOlqgO0x073JekG6D4oI8a11RvaOALKkUe0Ou22UvhgiEDQkeVZE/4WPugwQHj1w+pH4Vjjyo1j+pUr1qJCbSTgVhhSitBvvkYyGaMj+JBlQhS849sHDi7KAS+xwAF4aj8QP6BaRpHKUyanKmJpuDU0901ux71Diud3BJIVPWwzNJN0lNOM4nV9uRT2+Yx5PXdbeIGFeiR2jT+PDGDSaHI9GQae+uWDR3MD43apj56m4SNQIE4/iKSiu2sGAG5tb5sRvMUm+tQw0719C10J53MhamLTp2XJ416fIrxmgU9R/az0q+c8Kia9o3tv7bj3zJs6C0VzKWyR9Nn5HfqAR7CtSKuQj16Hq2a6lfcEcI35306Cv46BcLGbyQIiUdzj4XqbUEYYM5lHOB2hUqaeht9Gks819jJXDUGuRB3O48KQbBLq8lSuwQ9l6Do3heFOF08QT5lfTGPjpn27fL4pUGhJP0iZTKLOYly6JdcRGsn/NYY62odCTAegrb5gywCRhGUCcRxvBF77W/nVrHNk8Ia+BDn/OrSvNKUE/goT/bny+Oj5NZQZzQygtQwJLEZUJUvtP8GWh2I5fi7+hnCVplzpPRGvdCRzXKUrYD1Unv56AKn2y0Mm8pbCrRE4cZvhrNXDMCpCebdey0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(261009223027099003)(261021121427099003)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2B0j1lP7cg0FMUhFnr29Fa3TNmflrSSVBa3iRdWWEUxy/MVommEIh1fbBJno?=
 =?us-ascii?Q?Z1sg2djRbxYcfYHdd/6kz9m+GSuR/goo6QyRzJ6zC1dRK5LCJr8gXUvECCbH?=
 =?us-ascii?Q?9OxPiXYDJhYPnvpikXvaoIBzfx7Ip9PArr5zuDY9+q+y/OXzP2Au8iynXOcw?=
 =?us-ascii?Q?Js/7EgazhBBHMteHnamyYSZCOcYwiEkzriJnbznNJYM1UHQjXXUNZnJKffnm?=
 =?us-ascii?Q?2+aqyBm0wFbSQFZ3Z0OMb/NES01Etmi8y1e3qU4xl4qyvT8G/YlB64minTFX?=
 =?us-ascii?Q?d+dNGf1ZsdVHnY3I+6DvhE+eMrR1heVVOucRKuLwFM19ZO5CgQx4O4hFwgT+?=
 =?us-ascii?Q?wuX8aWr6rHvVx2BZaAxmOQ6IXNvGX8TpSCnV4WQJ0jxjADOcXRzo3iCm0SVw?=
 =?us-ascii?Q?njR37rKgvOCUWL9YCxcCAaSHGBnBHY2/WmotqvGYZpKi18w4kwCfXJbG07Fn?=
 =?us-ascii?Q?syn4estPpG6DJxN5m5EkzOy03JzatrcBKedjpwofROHAjxW6eJp9tRT4/DdT?=
 =?us-ascii?Q?4ycgaHgxp92H46eZDed8PBGInOmN3vY2DBGGvam4hyE65Ny/DMFuKWlI9DA/?=
 =?us-ascii?Q?u3nXPGK5ed5JTCYsjzisK6oQ/hfyG9CuVmDygeQmedxqZF9sw3UA11XJuSmM?=
 =?us-ascii?Q?MDhy7897XclT4oghJEn+zg3Hw0J5+ybTDdulLUK+ToF24+dI+7+N6KEb5bRD?=
 =?us-ascii?Q?BpVRzvviuZHzgc94EAl6cZq67T94tehclRfeVh/51c13ZtRIv0I59dwsJ2lg?=
 =?us-ascii?Q?/Jok1Q7p+oQISmrKlcwkVwJYXNZZO9tHhrp6XZ9Q+j+CjohSyjaiux7KvDaR?=
 =?us-ascii?Q?LVRxI2R7NnvgANyhum4vRZcNPRiD+SaX60AvckwAtXnG1FTFzqMeqBoHuQm2?=
 =?us-ascii?Q?OwE4UqlQ/pLEPedloBV/dknJRnbun7NYc5oJrVl84uLJi9/smicxOXCoSgXb?=
 =?us-ascii?Q?rzNRbJ7ePyIyVqLVL00iqe+BeQwARy2LB08d2Y3eRSODNBoIDJHymzpIu4Td?=
 =?us-ascii?Q?1Zb8iaOBLYG7ls2HVOCf1+ndROcHeJEd9dwGYVu38k0U2MyFsCIiVRsEQqWX?=
 =?us-ascii?Q?ihii7LkIxMq2hRAdqoSQhDMIogIy6ls6p+VdfL9Jo8Yl6+2f6zpYnVEoePgH?=
 =?us-ascii?Q?2Gimuq71yTUczX0XyRr7TtLK4+66i37EEyzXWjHSHoPraokjkNBSXvPwdPiq?=
 =?us-ascii?Q?DzT0pgBXZhCL8mDLeU44qNH7K8V0c4zUsYpu/Y2H2+HQ99kDpVUykPMs//6t?=
 =?us-ascii?Q?RTqU1zovCV+uEFXaWhBK+Xm0zshpRYcDSmKAWVUH7ZeHwp3LzQkpu3GLz6hV?=
 =?us-ascii?Q?R76anzHGLPpGi5a8fcSCCh0BPPcPqu9hHiDb167Au07SPxsHJvW/gVuhYF5k?=
 =?us-ascii?Q?m3LAtMF9L/NN28Rad1IgddeGsIQjbXvgx5mFyi8T0vHOvSmNB1TN6WI8dqqe?=
 =?us-ascii?Q?gt6IMjn5v1szTJTXHmvwJvCXwFRUJXyIcRjmXrL9zD4DLyVsibBCHp3CXUBZ?=
 =?us-ascii?Q?ztcVM02oygHzKPq1aJv1ZY4yOPco6qMhQKk8iUBg9RCtpj6ybGMKpnmZFEFX?=
 =?us-ascii?Q?dpsQnC2vF3O7nlL4a7FYA3elzsQA3r91aPUCDweE8XbKL83V1yA4vs4j4Vc0?=
 =?us-ascii?Q?J126o3PBI+J+fRQTLX8p86KKNI0Gl82OBjGHcAm/Ffz0RixhTDR5GxLTC+1I?=
 =?us-ascii?Q?2w31onXdFtVXcihkPuSIgIaGbsVaZjDSID24PGiH1OD7FW3i9qJiDkfeASUP?=
 =?us-ascii?Q?0pm0KeAEyg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb892f3-27ea-48c8-2e36-08df3122f654
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 16:30:34.0859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SftyUWlPzmtP13nHOD24vq0tyGGMC3d4tav0VZiiQErCLzVghxNI/yXhaymJ+TfKrT1RJNTu9SGqwiLuKOW1g4kzTWmteWdVs9LRfvC8vcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13512
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 23 Oct 2026 16:30:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24521

Hi Pavel,

Thanks for the feedback.

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Pavel Machek via
> lists.cip-project.org
> Sent: 22 October 2026 21:02
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 4/5] arm64: dts: renesas: r9a08g=
046l48-smarc: Enable rsci{1,2,3}
> nodes
>=20
> Hi!
>=20
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > [ Upstream commit 4fb32d9e4836c33ea9861f7c3e57beab6f546eb1 ]
> >
> > Enable rsci{1,2,3} device nodes for the RZ/G3L SMARC EVK.
> >
> > ---
> >  .../boot/dts/renesas/r9a08g046l48-smarc.dts   | 59 +++++++++++++++++++
> >  1 file changed, 59 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
> b/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
> > index c1c36f7529597..5289efd1a430a 100644
> > --- a/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
> > +++ b/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
> > @@ -134,6 +138,30 @@ i2c3_pins: i2c3 {
> >  			 <RZG3L_PORT_PINMUX(2, 1, 4)>; /* RIIC3_SDA */
> >  	};
> >
> > +	rsci1_pins: rsci1 {
> > +		pinmux =3D <RZG3L_PORT_PINMUX(D, 4, 5)>, /* RSCI1_RXD_MISO_SCL */
> > +			 <RZG3L_PORT_PINMUX(D, 5, 5)>, /* RSCI1_TXD_MOSI_SDA */
> > +			 <RZG3L_PORT_PINMUX(D, 6, 6)>, /* RSCI1_CTS */
> > +			 <RZG3L_PORT_PINMUX(D, 7, 5)>; /* RSCI1_SS_CTS#_RTS# */
> > +		bias-pull-up;
> > +	};
>=20
> I just want to verify power-souce is not required here?

On the hardware manual, it is mentioned 3 bits for OTHER_POC registers(OTHE=
R IO Voltage Mode Control_

WDTOVF_N_POC : It is for WDT pins
PVDD1833_OTH_ISO_POC: PG6 to PG7, PK0 to PK3, P50 to P56, P60 to P66, P70 t=
o P77 and P80 to P85 pins
PVDD1833_OTH_AWO_PO: SCIF_RXD, SCIF_TXD and P30 to P36 pins

That is the reason power-source is not added here.

Cheers,
Biju
