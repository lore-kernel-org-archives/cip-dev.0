Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB87CEE57F5
	for <webhook@archiver.kernel.org>; Wed, 31 Dec 2025 10:06:50 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.58])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.83020.1767175605141917622
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Dec 2025 02:06:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=QtNOF91X;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.58, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tnzjbKfPFHrbpdPTJ+MFHWt0vCoLrsa+b3xRPeCEFOyVTIyoYKBnx/yj0zwskIeFP+Tmkp4JZDSqL8uTAaSE7nayE9JBtkuKeQoh0ed6l7ImhiTdfYUhJskwPkqLSac6Kr/oBb2Qu5h7Y8jI6Zwz921Nsv3ab/0DDMvWoGrCU6vy2zZmdXZlSOrbg4gH37cPUg7IXHNR9Y8flUcC2GDDtqaYqrr6J9BOwRrR/woVLo/UCbzkEwd7oCSTurf3S0vDMZDyfySpSjxp41w84U263ZbV8OMX/5zH4oDnRo4jZqsjUIia3+pAgg77WRi4AjML4VGJnOp1TUIufuioK6RxcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSpL9eUVaR0VYaL/3Ej29iNU5u0KyDf8G4vSbirnLY8=;
 b=P91ZoSR0f8hVd1MfcfGCliBQPMhxkLMGaW5Gv0MNbJNOYkpsf5jYKHYFtkoF1MMT/nziGGuQO9MEhsIytLWr3aHwzqCFqiz/KvdU+g6w8gsiP7TY6vKSu0kC0uFkhtAxGG/U9uGdD2N4uvKKiBSCj+hObPIF1cHVCckD++OfUZb+mATq/Qi85D/mcwjcuDhm5ibzrTLORdBdX1jMGxXnXPNpRFNfeK8CEwl0/OfcHnJ6JHQYy+nzNv49cYBtWrsMC3CRnghxk4Cm2P5l8Q3T4FbjuOWlR9VpUSBz6A/eJ8h1A72yzBQi2LI18mNqIE8pouD7cYgGoZ8vYbIFvnasqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSpL9eUVaR0VYaL/3Ej29iNU5u0KyDf8G4vSbirnLY8=;
 b=QtNOF91XKQCTHF30zKLNi7hK7h20KcxcOtCWShUvjbBX4pie7xuoSVsGOeVMfKrjIxjOM81Gt7xELtVdAIEmXx9t76YSz/zKD3ielAnX7e6t9pg48tZCs6ma/aqYb+fKPOWwdPnKKiYpx73Pm2A/cYway303HM1cAJkIjXVFm0o=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY4PR01MB17786.jpnprd01.prod.outlook.com (2603:1096:405:34d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.10; Wed, 31 Dec
 2025 10:06:38 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9478.004; Wed, 31 Dec 2025
 10:06:38 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>, biju.das.au <biju.das.au@gmail.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip 4/5] arm64: dts: renesas: r9a09g047e57-smarc:
 Add gpio keys
Thread-Topic: [PATCH 6.12.y-cip 4/5] arm64: dts: renesas: r9a09g047e57-smarc:
 Add gpio keys
Thread-Index: AQHccOMcm1fSE7Ivv0Om27G62g4SN7U5LcqAgAJp5tA=
Date: Wed, 31 Dec 2025 10:06:38 +0000
Message-ID: 
 <TY3PR01MB11346A3AE9FD02270C4781F4A86BDA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251219122916.129256-1-biju.das.jz@bp.renesas.com>
 <20251219122916.129256-5-biju.das.jz@bp.renesas.com>
 <aVLupTHC7bQtYEsn@duo.ucw.cz>
In-Reply-To: <aVLupTHC7bQtYEsn@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY4PR01MB17786:EE_
x-ms-office365-filtering-correlation-id: 87cbf119-fdea-4cca-573d-08de485449cc
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?7jJbdTe2sPvP9OwOATWQdj92M6kfYEMG5OuOIwSszDgybfJVoO0081Ed8gLl?=
 =?us-ascii?Q?/vfA6MVcixQxUVa+XUtGcffw0pXPqcz3vxJd7TCeoRrMAW42lLsKecIZxa+A?=
 =?us-ascii?Q?/F6u5HfPlyuSZAQh2NIRCAmY6jMrflbZ88l01yIGdAiDs7TLHZpEs1Xy1VUR?=
 =?us-ascii?Q?tUCDwNbGfVUiDwBLiyAWfnj2ZNYbrzSaHopMb93m0PxNrBMQxLquzJzdMVwW?=
 =?us-ascii?Q?rLB3CXKiocKcj+OvCnG3LPD5UsZm7J1NmU8ohgoZrXA+xqvhKDrHhgrOat+a?=
 =?us-ascii?Q?Wlt0k11zE2cs6U8AIbS/PTt5Fm49M8NRBIQm8h2KLyL/SF8KwREGuXmX8UZA?=
 =?us-ascii?Q?MsfysZtHbmRKb706UcdwLwXABG/ETFpD2itONF+MziHEYj8z224D4wDgIT8C?=
 =?us-ascii?Q?vMchyABneagpZ67K4ZI8jhOjqJhiUfjOtaAQoT6MuHm6YVMgA7TCLP066LkM?=
 =?us-ascii?Q?f7ZZYfR5wR41CCsEm1yl3pEQfheCUzThs1RBOYzOKH7WhztdLCbZUGcFAku4?=
 =?us-ascii?Q?slM1yTqbxnE5Kjr3q0lltaO2Lbn9LO8iCBansiHdw/7spdgLJaBCbY9sl9aT?=
 =?us-ascii?Q?cL0AuJGXQaEtJjaSRJuu1rEd5BOtLphJY9VvGMSZCPhEqQeXG5Yk+uwyR8q8?=
 =?us-ascii?Q?wtmMvyTt+BcdWDePWV70zLnip6Wv/F3H/NdtPMVT9ZxEPteH6AVshvm7FQaz?=
 =?us-ascii?Q?3qhHZPBMQR6vSEJp2i1jIpTYgAVY/mVgAwpybWnd0z+Eq5VpBjGi3SD/mb3w?=
 =?us-ascii?Q?4Cb0XHfjnMJBcrTy4vA/9upupkxuju/Fj/cT6sGvW+MyUMI1ldjpoBPJdUhn?=
 =?us-ascii?Q?kL2M9MOXoIrGyBJihasrOyVC7T+VI/uuFg7WmEeqoEBYvsICH6htF2pJ69mu?=
 =?us-ascii?Q?x/cmxERFzcVr9R3O3ok1oXsFA6+LtK3fwMksK5+FzsdvKNg6F1Ysgw3ba8Uj?=
 =?us-ascii?Q?zZusQx9FGfB1agGZKrgnYOHHZxage9Py60opxVCLmkdMvJiPY754dxconXvv?=
 =?us-ascii?Q?WE/x/CAayXhYA0Vr91OhEkm3rkN+j6iXqL7xFAIzDCsA1PNhWp2wlJSIwzAl?=
 =?us-ascii?Q?bi9Wa4FidmBp8gTW+hYBTqtGRwg5MRQx6eD0icSA597FoiJXxOwLUovaasaD?=
 =?us-ascii?Q?rIhzgBC7y+4QEUk/AwQKWjOYP8kmjv5S3rYYGsJsH+UqvezHjlQVM8Kvtl0b?=
 =?us-ascii?Q?IaaOQkOAI9XftsPjptMAf5bfwfzAbe3YgBgAboHnXlO16T3Zfh4KSJbwjzoC?=
 =?us-ascii?Q?q5QheiMa41vS2Zu62xszs5xMRJcpDB858ULmYcfs5jWul37pZX34IWzxNZ9g?=
 =?us-ascii?Q?QxSJLcMOb3rDEfp/WyBMJjhlTITO/nKvoC/1yWxgpzaVp2QmrGwYOpPez9C/?=
 =?us-ascii?Q?umsD8aPW51bF15YtUG5DkkL6gJeZIgcAIdE/Fmx4reotByrTF1MPXI732kjg?=
 =?us-ascii?Q?RCGj+zrYi94MRKwuXqqyRjgsxQPQ3gPa/SGqXG7/PceRGkL7XpXYsSl8Imst?=
 =?us-ascii?Q?JGsqRxm48tQ/DHEFCCztxxw3SGEYx+Zh+Ilg?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?0rYam+sIg7n2fOMrWFdhyGVNM2n/iBXLYZqsUpsUegOeuz4pOH2MHmrKYwSL?=
 =?us-ascii?Q?oqHUhiKYAPACaSvqGECiz0GEQSzgC8EKTpcl9rx6SI8R0COY0vIgnH9IDTJs?=
 =?us-ascii?Q?/+3CsOEOMgajoDtdOa05U3BIo2+5b1qN/Bd8yk5OhJRZrjKC8i7KGdObDY8r?=
 =?us-ascii?Q?NG0oF9noQv4lzgFhj8L8z5ek52H0HuP7K/U7MkSD74amvNi6uBjDvDrchjSQ?=
 =?us-ascii?Q?vxn4Jd0xfCJP8OCfxy6x+HBtJKUb8mxztPrTt3nX4USj2oLHDGY8KaUGxgm+?=
 =?us-ascii?Q?3QugImqGUNlST4F45hUyP7R4+DJeAn2drGTwt4GpNcoZuIZC+BFwU60krevh?=
 =?us-ascii?Q?J+Uc6ojkSJweFz4tg++OMofCrSchZyPDvSY8WuIxvsKZy7hlfQKVCamKdTwz?=
 =?us-ascii?Q?3xbn7oCkjPWT5C0Rzs1l/rtHleRyrb/Uv3jL1EABivqNXqDOLbRVzOwVULvd?=
 =?us-ascii?Q?TP25Bq8e6kufZFJBtSRtPiZvRuRfGfYZaq/cG7xkLHuIMc5VifFqOMxOH0x2?=
 =?us-ascii?Q?Z3mef9dX7WgcGybGRDv87MrIG32GEmdxcy4iOLcEbjCZ2zPH5Dfu/BcEW7o8?=
 =?us-ascii?Q?oqG8XJkLkxqirwpaiCDdP0ugcgnwvdXSAjSutkierds1PqXkd5YjVKn0J2qZ?=
 =?us-ascii?Q?yaK9NrHSyWEkUc9VipryZh2Ymrp1veVVTaAzFbUWY4rVKnCLjqMnJiNVh5ZA?=
 =?us-ascii?Q?4z6oHRgtLX5pv7yWPPOwYVPT8LsQ/FqXVwtAQTLhoxpBpFPYYmEor3UcdEHc?=
 =?us-ascii?Q?+O80ux/0/kjAPpD2ol11zGy+BlK4+5fU/ON5jnUOiliRuNR+7dj7DCtCYTll?=
 =?us-ascii?Q?h6aFPZ1HfDXvxA6TPeGZJ10WECQ+8KpItMaUaHzrUIwe/AVUZdR3Ch9lvzNG?=
 =?us-ascii?Q?wzLw1GPEbRG1e2anxNtjSEZ3/F1dArDu8+I/UiZIMCvCAFfeaZY5UEFCP/BG?=
 =?us-ascii?Q?ZpxOB1jFWa9x8xQxaiTLhM3RWOURMKgpmz7MovLmsTp1LVWS1/DCPx1zajlp?=
 =?us-ascii?Q?RAMemOBxNL7SJzBza3DH/iJ2yPqlvqmgc5VPuU+VEqaCNuDaE4tJHkW5bSDr?=
 =?us-ascii?Q?wDJLBSOTP2E2qwDgBSzzMhwIZAZKy38omtTOFOA6bzNLm9aIGKbDpNzDOcV2?=
 =?us-ascii?Q?BDUFGaX39emIM0TkQfn0m8jGSpO+nsK+kc3fsV06NMLsSMQxAUog+iWgte3w?=
 =?us-ascii?Q?b7HUgGIP+YQvgBEDaCTRAjyx/nksB+kAx8jSYLiOR/yORX6/YgWHv6q5tPEA?=
 =?us-ascii?Q?EMRu6XCbAXucnD6ojpCXVyMOVCpo1WXSJZ4x7DuVbHsASgUwy9YikUnT8DFd?=
 =?us-ascii?Q?P75aP6Bjc94xbwnE5BCnZjH0Cb1fkHjtvG4aG67R9Gy6E0tCAK/+9elkGIOd?=
 =?us-ascii?Q?iBKa4XVgQyx/RB/Mvu9SWROCNf9QYRxXJB6oZ9VfM/1ziLziHQNcatOuasjz?=
 =?us-ascii?Q?HxSC1Omp2UUC2W6ZNchYe9uBPgCis3oNtiyEb1u9oFTUX9IogusQpgxy5hEk?=
 =?us-ascii?Q?0DR6hWqZf/ki+ICBB30/v7dtqcv8Q/panN3xaq/r6Q9+cBfKFB68qb9kSRFW?=
 =?us-ascii?Q?PcBx0+n5jpIpNWXXvTWZ/tjChxDVG1pOjncD2VCjVixHRaYYAZXtRqJbQcVJ?=
 =?us-ascii?Q?mlzC8CrPaWq2mXOwlk8mlbgI9zJMQlT3ml0f9L3Zln4qqi38sQ434ZynLE0z?=
 =?us-ascii?Q?bDVv1PZ+8H/rva+FXmzYnw2/E7V05IF7hYZuSIMkCSaXS3khCbOlm1A8tYim?=
 =?us-ascii?Q?0/ORCL1lOw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87cbf119-fdea-4cca-573d-08de485449cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2025 10:06:38.5463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O+zfGxtMnKZ0bkszpYfrz71gB0UrAC5kQeosBu7s4Ldq84jdH5N0VwHc+rANGvf/Fw0DEPPytop8/MGkF/1BBOcBJCjkKjoXIz0+zhSZtxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB17786
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Dec 2025 10:06:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21277

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 29 December 2025 21:12
> Subject: Re: [PATCH 6.12.y-cip 4/5] arm64: dts: renesas: r9a09g047e57-sma=
rc: Add gpio keys
>=20
> Hi!
>=20
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > [ Upstram commit 9e95446b0cf93a91bc3b3b64c6d423f4024a6ff0 ]
> >
> > RZ/G3E SMARC EVK  has 3 user buttons called USER_SW1, USER_SW2 and
> > USER_SW3 and SLEEP button with NMI support. Add a DT node in device
> > tree to instantiate the gpio-keys driver for these buttons.
> >
> > The system can enter into STR state by pressing the sleep button and
> > wakeup from STR is done by pressing power button. The USER_SW{1,2,3}
> > configured as wakeup-source, so it can wakeup the system during
> > s2idle.
>=20
>=20
> > +++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
> > @@ -8,6 +8,7 @@
> >  /dts-v1/;
> >
> >  /* Switch selection settings */
> > +#define SW_LCD_EN		0
> >  #define SW_GPIO8_CAN0_STB	0
> >  #define SW_GPIO9_CAN1_STB	0
> >  #define SW_LCD_EN		0
>=20
> SW_LCD_EN already exists, 3 lines below. This may confuse someone when th=
e defines get out of sync.


OK. I will backport the patch [1] separately

[1]=20
https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git/com=
mit/?h=3Dnext&id=3Dfdf74a6cb506ed4f516c34b594d56dd1358bcc1c


>=20
> > +	keys: keys {
> > +		compatible =3D "gpio-keys";
> > +
> > +		key-1 {
> > +			interrupts-extended =3D <&pinctrl KEY_1_GPIO IRQ_TYPE_EDGE_FALLING>=
;
> > +			linux,code =3D <KEY_1>;
> > +			label =3D "USER_SW1";
> > +			wakeup-source;
> > +			debounce-interval =3D <20>;
> > +		};
>=20
> Are they buttons (they return to 0 when force is released) or switches (y=
ou move them to 1 position,
> then you have to move them again into 0 position)?
>=20
> If they are buttons, label is quite confusing. If they are switches, more=
 fixing may be needed.

It is buttons. But on the board. it is labelled as "USER_SW1".

Cheers,
Biju

