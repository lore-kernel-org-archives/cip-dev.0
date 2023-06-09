Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0B6C7EE29
	for <webhook@archiver.kernel.org>; Fri,  9 Jun 2023 12:19:58 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.99])
 by mx.groups.io with SMTP id smtpd.web11.11778.1686313195146198605
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Jun 2023 05:19:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=aYV3Clyu;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.99, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8U+xyd0bWXgRr+cnPAtnf2PdxAlKffeCKdxnbtPpY4xSRj0dhMCEUd3e5t1JHCBw9AtftZZ9oz/zY+EH80azAaJ9dorbiJxtqokds+5EgWO1DBDByhko09PdxiSqTwUiXI1W+YvK8Gik8siRNBHk57fE+IUelOqZVr4Iot+/ePlqwm0aBtTSwH1n8GfUyT77Ryt2yfJ6J+8rudezaU7WOj6TwyiMURluVjpu9P2yoaZX/5nrda4B3EbybXc9d/mLeaDjF9N+pGKINMqxlDIhicGB5bOOgdEIGxjIIgN6r+dqxGjIUg4sRqsr0NXSEmjdhdPyptDv31Yo+uAiqHx0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jBzUbHVTIf7BlEErVdUpjNaB8GZYkokaEeCqKi0fDw=;
 b=FOoDBOOlGCraYUnlsGLMip9jS6I89W22tRas5TseYzeB0oyonQkm8QYpd65Mh7S+j6Bqk3w6qGN/Ub/v8O3S9ZsEWkzDX6CJuSwP7xxsg4fnKNLt4Q4RgcHUht5dOe9/2GOVEISO0G7NL2tVW84EpLp0DCtVDa6iDAIo2P5+zwImHRIMsGT/wVerszsy7oJ8X4zOxsYKm5aV2CyTgkHznb9WGzs7imht375yQORL7UfrPVU8X1cCeNwLAmcocVecMChGXD1mDZYErfc5FVOECIbBVWc4C/V9HKvGvKiHVS7fVC65J8tjla0ymPbRZAGypZVX7QZn6sPr7kH6FtcWBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jBzUbHVTIf7BlEErVdUpjNaB8GZYkokaEeCqKi0fDw=;
 b=aYV3Clyuu82G1+xwcq00JH7LdT7odcbawCgKk7Q6OkCAK7cKOaVF7ITDFVMbiK+qVPm5JbQgsDNFCmpIirzQGFN5ioGty3CnVEGjtUeEW2/KVCo+0BYXn92h85OeSa7kY/hRgbhmDYMOdCR0fMJB5t1cc52EWg3PfbTUBdK8AAw=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB8286.jpnprd01.prod.outlook.com (2603:1096:604:1a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 12:19:51 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%6]) with mapi id 15.20.6455.039; Fri, 9 Jun 2023
 12:19:49 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 3/8] mfd: Add Renesas RZ/G2L MTU3a core driver
Thread-Topic: [PATCH 6.1.y-cip 3/8] mfd: Add Renesas RZ/G2L MTU3a core driver
Thread-Index: AQHZmEvjJmIiIfwjnEK//0R8nkJPUa99irMAgAABckCABL5oAIAAHhmg
Date: Fri, 9 Jun 2023 12:19:49 +0000
Message-ID: 
 <OS0PR01MB59226AAD9D81B8BE6AE720F88651A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230606075235.183132-1-biju.das.jz@bp.renesas.com>
 <20230606075235.183132-4-biju.das.jz@bp.renesas.com>
 <ZH8DnHZb8dDrq+Zm@duo.ucw.cz>
 <OS0PR01MB592237E5932B612CC5D4B4EB8652A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ZIL/itcJvV5s3Bnf@duo.ucw.cz>
In-Reply-To: <ZIL/itcJvV5s3Bnf@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB8286:EE_
x-ms-office365-filtering-correlation-id: c7f569ed-1cf8-4e71-8185-08db68e3d223
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 YNa1jgIuCUx9OW++qcuQ2wysSBEjnj1iNn6i/qsR6UzAWRbFxnuJP4tJJSVE9MVQvPdMA7NZtcBYi0CQQ22Mur+HXz13ShWBnYEAAJXjlNWYaIU9P3OYDuy8fp/UagIOfxjY+IFm/5CNBWC3biQ5a1W2Te5/hu8RePDArkVzix07WTHc7a+UB1Qauz9mH+JFIBP6LSmrrVQ8gG77mG6eQucZxd/aBmpeGlF3Ko9ggyxzCd30J6twJ3UjhJ7WKWMzhFuvJLQwieLWx5QI+iFJXrO4mmxbQBHcndMVt/4jYeOe3Q9udTVAjnkEK/Swn2td2IfL9B1W1fxrTDP8i7mEaX+tJpV3enR1IDwj4GwKZIifBjav+cJQqr1Q6XBuKSSgXihx9s6s8JA4inLUTonKrEwMQlbGq011ZDdExEwBSd1WrOGLysHhcaGwABl2PWRAbeIs0U1yVeu5InLxiQsSQz3qJWpJ91oQ+IcgjOjEKrodGE6ggzP3PCI7ehc8a4myYzfLagNw3kvUNrBr/UmpxGPDk7PhGQOLSYoQ2qtjW/5i4Wbl8iux30W7bcM9tMViwgYyzuUOqxJoSxoTz+SCWgj/iE6eNkwar5JW/S+glLL3z9LDaTzicNJeOMNHz1Me1oU/dKfhEQrApEyLhZoTUQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(451199021)(55016003)(54906003)(478600001)(122000001)(8936002)(8676002)(316002)(4326008)(6916009)(66476007)(66446008)(64756008)(76116006)(66946007)(66556008)(41300700001)(38100700002)(186003)(83380400001)(7696005)(71200400001)(9686003)(26005)(6506007)(107886003)(33656002)(86362001)(5660300002)(52536014)(2906002)(38070700005)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?lvPjiM/fMK1h6vIX0V2C1tV1DLgE9WHHUzd3vN84CLtUh5IEhRZbDbC/Msfp?=
 =?us-ascii?Q?XoLJtv6d9hv3WPkgsLQpsFp17pTUh2ChQmvZ8WPUcfN4O3iNhD0N8+ds74a2?=
 =?us-ascii?Q?8e5pchwevYAXrCkBnK5iv9IOyFE/rWRaWQp3EI6xKs+FXkn783IkDEfbYMRL?=
 =?us-ascii?Q?uc6jP5MnadOg1IZYdie6DJieqjp2kKGNMqIG2AuQT+Ijcv8T+e7CcbjgYeCl?=
 =?us-ascii?Q?GD8nCmsVIM3hO48Mpcn1KQ0o7k5hwV6qFtiz7TBsNqhMP0yuoHInNmd88QX0?=
 =?us-ascii?Q?veAPZxjVbMzeYa2vpfZACs/rptW4YtbiKBDGz/s7mRgVI9MLxIo8+ak9O9Q1?=
 =?us-ascii?Q?QgtjtsLsBhYvehGuOCGmv4UhtPnlsJchLG3rB6RkIXF8qwON1hWJZMgjeP+n?=
 =?us-ascii?Q?9ocbE82aoHFQbljX5IE9zf4SbSQKCkn7keJ/RGIxHgusSP350M6RCRggJJ+O?=
 =?us-ascii?Q?7xda0ku4VMDtsHLnaPehk24P+LUCd+SZrmfMFRTHxVFg+CchWbpLGxMe9jY6?=
 =?us-ascii?Q?NLK1pr2aeVZCAIebGLr2WYXWizIouzlLZbItRrv+0yJ7l+zka9In5x9LJ0lW?=
 =?us-ascii?Q?yee43OcBEYjkXmOE6uAm3a+JSdrGghc7234t3iAuAGBxEsFqpFU2Y8sCR1cn?=
 =?us-ascii?Q?YDH5hV5leRJRdlCAhxf1Bj1bwSafYZwiVHoJMLbYr3HDH5hx6ISk6mAy9msg?=
 =?us-ascii?Q?FCpiEw8T1RC+UpUbl4uCAT0HDgsUWX7vYMsoolnjtF4Uyqs1f9JocfT1ScGf?=
 =?us-ascii?Q?Gl7JV1F+463pEri+2svpIG+toY08FEWJlIv2mynLJ8LXqiBNm3yynW3Nz+Gl?=
 =?us-ascii?Q?ZZM/GycBQ/PIbQYYY7TgMTmMYhqvmk3OyhwAIJkMfflymjioG067PLJLiosT?=
 =?us-ascii?Q?YnDHSsNiPZPLOLDyONaYk0Fw2JA9B6xiImTgXt75cGB81WFwB98HkUmzTNTv?=
 =?us-ascii?Q?H7sMlQTSpzM8CVNPce1p0brX85w5LslmhnNTzhrsp3UQn3c/JQUBU2fGYKYo?=
 =?us-ascii?Q?5voIOg1YqbYcmoh+Q8PaZOcREOWAJBW6pppJqLEzajMhK2eLHmSq09wCmcrO?=
 =?us-ascii?Q?raxiDef1Hcn9MBRo7OS4KVCMbvrsCLT33xVRz43jY6Oixnj4l4cRDmMvOimW?=
 =?us-ascii?Q?B00IB1/kDWDZ6NBvDDb6C51Sg/AkY4ArNxJM6B0YVXVOae9YZkofuezJXO3F?=
 =?us-ascii?Q?1X1FAKNr8SZaIxjTFKjwYmMxUx+pFGc5kt7mUesQFvkBN58+uOFdThfRsHyD?=
 =?us-ascii?Q?UZQ6sSV8qqiX1EgDKd7iQLD+Zocnu3oNl2hDv0M1XxOwditKBaB+wjsSjakL?=
 =?us-ascii?Q?AAgJsxIb920FmqvnJz+dGJ7sx3iURVVWpfCEdF/1O/wxNL7tUGf4wbprCEfr?=
 =?us-ascii?Q?3hxWqqH1Pte1Eqb6WL9tFjY61+opV4FKxDqYDHBI/+MZ4ZJPTjypqPYMWjcv?=
 =?us-ascii?Q?BRvEF6lJ2iYh9J6t9rGZO4+N8lmhFiOQdxe/b0JewtNHnx8DFZapmhFw3MB3?=
 =?us-ascii?Q?6X7t/NuZqyc4bolUeJ7BVtk69znq3YEx2D2K8VPwEtka73F9Aeiwdv9562fx?=
 =?us-ascii?Q?XIfBTMJdpqnaoYDDm5oq6ef2hx1Q3jk7D6N/wHnHEonYuHeyw0atpRo6Y148?=
 =?us-ascii?Q?pg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f569ed-1cf8-4e71-8185-08db68e3d223
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 12:19:49.4944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B2hFRg+tDKz3PItLciCLMLkprR46/ARm3WJ2rJRVhbH3Fp9AALKfZIo/uJok0VDOS0f2qvRWx65N6HEVqEMCyn05sLXcsuR2n0spND+BE3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8286
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jun 2023 12:19:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11937

Hi Pavel,

> Subject: Re: [PATCH 6.1.y-cip 3/8] mfd: Add Renesas RZ/G2L MTU3a core
> driver
>=20
> Hi!
>=20
> > > > The 8/16/32 bit registers are mixed in each channel.
> > > >
> > > > Add MTU3a core driver for RZ/G2L SoC. The core driver shares the
> > > > clk and channel register access for the other child devices like
> > > > Counter, PWM and Clock event.
> > >
> > > > +struct rz_mtu3_priv {
> > > > +	void __iomem *mmio;
> > > > +	struct reset_control *rstc;
> > > > +	raw_spinlock_t lock;
> > > > +};
> > >
> > > Why is raw_spinlock used here? This is not really a core code...
> > > this makes analysis for rt safety more interesting.
> >
> > I just used the spinlock variant used in regmap for concurrent access
> > from different drivers.
> >
> > Do you see any issues here?
>=20
> I guess regmap has to use it due to something critical (timer?) using
> regmap.
>=20
> raw_spin_lock:
>=20
> + better performance if used correctly on -rt kernel
>=20
> - harder to analyse

Thanks for the explanation.

Cheers,
Biju

