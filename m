Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC67C88E4C
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 10:19:47 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.36198.1789121980658613757
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Sep 2026 03:19:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=qn4cs6b3;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.42, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYUyo+FIsDmv241ZAUuuTex7BJEmYzirTTQ0ZRuIpR36nVSMnp6x4HbiTEZsUixcrjovtLGenZ2xL/0P++PWtK+qJMZRBuH2IzDbXfETzc01mUpZK3tnB9Jb/sRc91KrWyJfwHs0GBn2VR77Uh1Q2NRFiSczs+JMS1qwuTz1/5pBqe7FiX+SV4THY6GrpcbQB4xbkRMAl7gtAZRd9Dg+StpLh+UXXA8pFaOo5+WHMCoE2OBaXaREaqVIwmgB4u0h0l47WFMhhqSpLQG+DRK5SCHeUQlCOT3/zQPDY1lFIM8jewOrLWrOgf5WqN33pgOjjW4H/4+U/tBG8ZrcXQE8Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0w1iFiD0FEt0fNn0ttCqXbkh8ssD2qsWvuaND2enBIc=;
 b=xKiryWc+Dkotntin6Q5Ygaam+HOuvmiRKsc4UodliukMPmWu/f/MG3qnZaz4Rqh2t0LuzQrzq238o4Hh/06V12iLXecz1aMYzGJ/aHfhF/OH+I2Q5q2HUpYEukE4QQYgcHJCyzn+A/UBSPJRjHIOVs8ZjLcKYlacOVkqf8JGPdIf+3g9eW3xHfc8FlNWJLjcx6Lb5QZHE0CcZoLb+EJ52sNsdfV5KJq8+i3NSbvzCGTXHZ15GS1p4hpaEFOJKAEAZBBIxcgzk9KKwEDVuYgLvk0Td27ss6EtljelXaWuD1YFTN/8vQhIoPbV1aMTo4OgZ0E7WhMsiJUrNSW5biy7OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0w1iFiD0FEt0fNn0ttCqXbkh8ssD2qsWvuaND2enBIc=;
 b=qn4cs6b3H6J1n3m3Z/q1BScmwFThOTKdnNTY9Rtu9fEsEUemQ5ZS5V00mC3qmEqsQD2bGT4nEalZC7LVGnZhbronNtL3uuuqwrwZOIkoJNr8BxxqDhNHEcX1sEL+fh9SUx6FjFR0aknPjCBN8FMZ4xy6oxC7ljgEDV6U32+5zAo=
Received: from OSCPR01MB14315.jpnprd01.prod.outlook.com (2603:1096:604:39f::5)
 by OSCPR01MB14471.jpnprd01.prod.outlook.com (2603:1096:604:3a3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 10:19:35 +0000
Received: from OSCPR01MB14315.jpnprd01.prod.outlook.com
 ([fe80::66f:fac9:2ef6:9796]) by OSCPR01MB14315.jpnprd01.prod.outlook.com
 ([fe80::66f:fac9:2ef6:9796%3]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 10:19:28 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@nabladev.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip 3/8] dmaengine: sh: rz-dmac: fix device leak on
 probe failure
Thread-Topic: [PATCH 6.12.y-cip 3/8] dmaengine: sh: rz-dmac: fix device leak
 on probe failure
Thread-Index: AQHdQdVCWIB1OK6+g0GpARueWRsLv7bJKU7A
Date: Fri, 11 Sep 2026 10:19:28 +0000
Message-ID: 
 <OSCPR01MB143153F204063BEF8DEB55D0AAABE2@OSCPR01MB14315.jpnprd01.prod.outlook.com>
References: <20260911081132.11879-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260911081132.11879-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <aqPSqkVhPqfT7pD3@duo.ucw.cz>
In-Reply-To: <aqPSqkVhPqfT7pD3@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB14315:EE_|OSCPR01MB14471:EE_
x-ms-office365-filtering-correlation-id: 7e6bb767-589c-4f46-a456-08df0fee2986
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|38070700021|10067099003|4143699003|11063799006|22082099003|56012099006|18002099003;
x-microsoft-antispam-message-info: 
 bmjRImi+BPQ034YXNJ2FEgyamFx6bYi2YnMLAexRhib+QKbfkvpqrUOkC/xsBCwOrS2hVYjRq9+BL2Gv4yD9rxTvxk0UXA3N92utvmTBARqYq6TVaqnbwnopjcg2XUgScR7XfUFsQGCzHbYzU6daldftRTva4dlfRXETxh31mnTmXUoQVLWV+h0zzqYSqduH4ixyKBte+zHb95SUNSuVoojX0cEKnqkEvdQq0ELpxQ/1ZXolakbF9G2NmlI+jqEO/IoV9UXikUYKY0vAQ67+nWgzz5mi4IfNARGpX5XmKVlSkR/y1XcYJgTSbC1EePLOUUuLbb5nPmE/zaC6NPPWJHxTDbTEyYZsqZaVQYIY0PAaDQRjjAmQsDhDcm1FUlE2ea2v+CxMskDSLqIWknmqV8SdBUFSzCxO05oSwsFbDL3wdgv76+8Xskjww/Xiq0NYc1uhuFpc9R1COtWaKw+B6l70xgqe78O+0xNSz706dYzlED6aLCLyt9Q68SbRKAHE5eRTQqD9afwwBeeE2eI3Y4QxKjNGJIqhbJQ6/e3FipPszB6Rv/QU4fH+xb7ZmefF0DeHp/x3ZRK2K3Ko6GeEHvObhB83SYI6udqUKSXk70mbG5GVZsDDJ4gB78uu6nlwrlaBa2lyyXX6znMxE1Qo0gbl1UQxN05DepPhAW9c8hk=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB14315.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(10067099003)(4143699003)(11063799006)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?zMztAMVDftnSNzjfdS5164L0VOgUjzAD+tKrilZRpH7evnTI+l+ZUb2SBfjs?=
 =?us-ascii?Q?lDWP/RJu9lfmS+P0R8xpijSop+3rc6afvDDpPmEjcN9zCUmsMcNKGaQr3W/I?=
 =?us-ascii?Q?uk7jb/1EQndRK44VIsfyR+7+O3LXd7KHFJ5O6PJ0jiyh3nrzgMUTdZnNnVg4?=
 =?us-ascii?Q?lh+fOKp3DvuXUbKxB0NzXmlIgBQPlPaX4UWlsQZc3jh2y634S7pK33QPpv+R?=
 =?us-ascii?Q?LmI1onLAYmJ/9TH3h+ZyVw9WafkvzJjkVoApszSd9piOGrzLBVjNFyMtBWFu?=
 =?us-ascii?Q?NOCv3XmWSr/T/8pz7gpr7VwOE9S57Zi5uTx2HsanA6WOn6SSTtdJ2VwBkWdO?=
 =?us-ascii?Q?S9V/XWSrXhQBLqKfmlmVcJm1/5PXmSyf5iyaugJBYOr4deUYHO6efzTMNBNk?=
 =?us-ascii?Q?r0tsBi32vzhYGjIqijsgn/5271azXJl/G0q0JQ4E2//uNx04d7BnPtaXY2HS?=
 =?us-ascii?Q?2WN5VDWDttZHEvYxtSsgrtq/z1NHa61fYbOaYAK9Lk312KyWXZHchZIw1K55?=
 =?us-ascii?Q?hpwiQ+7volEOaG+b+ji5Y5BJyuAt53d0Ib+B6V+/8/Mgog3IhYACG+/pXeZE?=
 =?us-ascii?Q?hUyu2Ehm50f8GBSkXvzAQ/Cg99DNVynWiNR78j1hQE9i4/XJNi1CPIVlnQXv?=
 =?us-ascii?Q?ESXpuOEDg5ltFZc2Q878DEaDEGZ9q9eT0ncaH5tM2uAwTPgeWQl+NuA58OS7?=
 =?us-ascii?Q?IbUPWcwRfqRXTYkhprV2dYkD73kPA3dHJ7PN55biI86uOv1Jvq39CaKAVwXY?=
 =?us-ascii?Q?WLsvcN48AUHofgtpZRT/FLgS4PJkGH4e90n524p5GlxohCVH+ziBJJ/uVNJZ?=
 =?us-ascii?Q?FYjr4myT5/lMcTrzIcfZPf7lhe7zzuBAXKkbCeAnAzAkHsiU8Z/ZfS+B0eFS?=
 =?us-ascii?Q?mxaRrxdvH6HA2ggg9Ui2Sxw9MiAYEumpdV64KXfoPPIyDsGqNcz7wVfPvymI?=
 =?us-ascii?Q?RPIBh3d9I1jsAYQCeMUrKSvuo5gRRjzyHHyOtuxxtJ8niWjdNBs+kdZo+7Kt?=
 =?us-ascii?Q?QS+ruYtWBnrwg5wajqQXoffrQC2Uz2nNEbPbS61iMAqJngUdLOyoBmy/vaQX?=
 =?us-ascii?Q?lRINQ16rqN7/etexmpt3Obj+1hfOxWy6ZqHtTE/tpCvSkytDCt994RkFO/D9?=
 =?us-ascii?Q?MRNU5m5aKFHYznxUIHgzNsCH4IvBvGY3A9ILPtCq8z6/sRXQYYMs14LqbXnq?=
 =?us-ascii?Q?5AOy876EEOXq7EQtySG0p+967f4fTf2DcwTQrta7faUr833Jt4Modf9zxzmc?=
 =?us-ascii?Q?ok9jBX2AcKRtb6DdR58MkC/0Mh/s42PNo2Vo7FB6fnab2IhIQyEFCyT4dqrS?=
 =?us-ascii?Q?Zb0wsMQbUcTnpwsReXSV1INCDpPRkiiedgy5Rhj9v3Cjgk94+vgx0RXBS9dA?=
 =?us-ascii?Q?9NrmKNvRlN0d1RSotx5Y70jAjTs/IXQ9GMcHZ8JN1I7glGnZaEmLQbxkmT/V?=
 =?us-ascii?Q?yTA3FICScpD50s0G4GMJxJodrxMA7K2D9OVqKBfb+aaUh5nln6rm6erOch67?=
 =?us-ascii?Q?Nl5zqZN+loY8zX4O7O9FEEarq6PYhsyp4eCn8jDFGvo0TdmBxlfHhyQnv/W5?=
 =?us-ascii?Q?O4TBLfkmvzEYyIuFvSGtflY8yLASayz2T/xMSsZOc2ts2IPaizuqNnB5NEKK?=
 =?us-ascii?Q?b06xPN9W6HLDkwiwlvPqHeQvSQPvqcEzKcQpYWQvsTkfOa51sRa3zFIpv9rr?=
 =?us-ascii?Q?G3BbiEBdY3aMlA2vGBptTIxvePvNPATZkakO9RdfKEMiX3MGDAoRtIuuZLDF?=
 =?us-ascii?Q?I3cY8mFnSdpHEomd1vCFiNIWsqc8tl8f9LyB16VsF7z6AQYl5bx/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB14315.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e6bb767-589c-4f46-a456-08df0fee2986
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 10:19:28.2780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JhvIvaMpcQM7tcYxkKD2PKSmO7/XMSy9cOPmWIp7c6FljmkwMe1S50DCrOMZ5YkMJpiMhyTx+0dkEBxXlT1esBjkNIfTINSWSQOuJG+C/tkFpSn7qFuCcbZBRDLiltdR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14471
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Sep 2026 10:19:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24131

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: 11 September 2026 11:07
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek <pavel@nabladev.com>;
> Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 6.12.y-cip 3/8] dmaengine: sh: rz-dmac: fix device
> leak on probe failure
>=20
> Hi!
>=20
> > From: Johan Hovold <johan@kernel.org>
> >
> > commit 9fb490323997dcb6f749cd2660a17a39854600cd upstream.
> >
> > Make sure to drop the reference taken when looking up the ICU device
> > during probe also on probe failures (e.g. probe deferral).
>=20
> Ok, but you need to do the put_device when devm_add_action_or_reset()
> fails...?
>=20
If the devm_add_action_or_reset() fails, in the same code path action callb=
ack
is called see [0].

[0] https://elixir.bootlin.com/linux/v6.12.107/source/include/linux/device.=
h#L292

Cheers,
Prabhakar

> > +++ b/drivers/dma/sh/rz-dmac.c
> > @@ -885,6 +892,10 @@ static int rz_dmac_parse_of_icu(struct device *dev=
,
> struct rz_dmac *dmac)
> >  		return -ENODEV;
> >  	}
> >
> > +	ret =3D devm_add_action_or_reset(dev, rz_dmac_put_device, &dmac-
> >icu.pdev->dev);
> > +	if (ret)
> ### <- here?
> > +		return ret;
> > +
> >  	dmac_index =3D args.args[0];
>=20
> Best regards,
> 										Pavel

