Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58738C77B7A
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 10:11:50 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.118])
 by mx.groups.io with SMTP id smtpd.web11.5306.1686046301106924902
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jun 2023 03:11:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=kPIBTSHl;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.118, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWpMyNW06p98ipNwtLCT8kynSvzjZsj/kbyJLgbknFH4tNLV5eQIwugOsRwv2eYY/gHhaB53p1H3C0RK46hN4uZJ+b9SRq5I9Tpiq5LvkxtNGyMLu9r2s12rw+ivlcCGN+L8b7gdakK/DlYh1Dw4+n4k1ORBOABqkWcxvezNn6Z5fnmrVYZ1HYxAZJxZKEkEuS7JUKfpWn5gorPZRmTKtooG/8C8qkWK9GiI6oEPD30/jabrEznAjkewGL4ZSVW2txDEpkWDpuNRWTGtLkFkY+ysq8NDUC7G/xAIgLYZcHPnQPjrkGE5Zyj7pCmtkijs4GMG/vb6X5TZxyt9fDSsFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZaecvIBGfs5SJw+uRSA4KkhqTGZHOqblS7LLX6KvmuM=;
 b=AW62c3pngEUAlxt1U8OsuC5IklrVKfrsY+2WL6x+qYVOiESsPbxcqeHqjULhgOHaDH9vGC26BkibT61Czsro4y58CdE6pebfNsAzqtnafY31FqaAC4lY4zP7Z39EDQMkMt4Atkz2BsLjGqLCAwwfQLklBIEQGo7xtr0PpMBy3Yc+DqBMQ51bN6+vYhKiNjseO9Z8AJn39yvtHQJn/p13dWIMiJQw6pgP7N4GIPfilhgfbF/KSRUzqmT47ohAWlVzXtXRvvpTRbhl3lQUbZEE2bu/IxD5EZKiqXF7tmHX5y4x2MOJ03IBRltAI52ZrcYNrDmfP2srStC9Lfvy1vEjYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaecvIBGfs5SJw+uRSA4KkhqTGZHOqblS7LLX6KvmuM=;
 b=kPIBTSHlu2DP0ZMtLtOadlv7KLOxDcJxqJMarUQ7FqengB7ce5SFCcB14KHselQ/dVQb3YeJIf1GhltybC+EC6tUVC1zRcuTQvEXUpGcLvHLgGK7OIshIO07oT4JODtKorJf7B3NLGUInQstVHdr8T/eJ+cB9vNjtzJuZo4jkng=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYYPR01MB8047.jpnprd01.prod.outlook.com (2603:1096:400:f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Tue, 6 Jun
 2023 10:11:36 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 10:11:36 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 3/8] mfd: Add Renesas RZ/G2L MTU3a core driver
Thread-Topic: [PATCH 6.1.y-cip 3/8] mfd: Add Renesas RZ/G2L MTU3a core driver
Thread-Index: AQHZmEvjJmIiIfwjnEK//0R8nkJPUa99irMAgAABckA=
Date: Tue, 6 Jun 2023 10:11:36 +0000
Message-ID: 
 <OS0PR01MB592237E5932B612CC5D4B4EB8652A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230606075235.183132-1-biju.das.jz@bp.renesas.com>
 <20230606075235.183132-4-biju.das.jz@bp.renesas.com>
 <ZH8DnHZb8dDrq+Zm@duo.ucw.cz>
In-Reply-To: <ZH8DnHZb8dDrq+Zm@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYYPR01MB8047:EE_
x-ms-office365-filtering-correlation-id: e5e27542-269d-4dc6-8a23-08db66766997
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 eS2Hw6qKsf0OdhlddSKQ99Ts5ipiXGbTfKGaRewV0Vr387j9dDyZIZzyRXJ/rVfSofL2qVbAyth4zmVbYS1NiaME6TqPABr5dvH8P0oc+Mbr5jdJjIPpStTABKqrJm8jd/C9BaR3TMCKaLlDGt53Vfm0lFufHY5FXpy3wU3Q1qMp252S3EsNEdHyWNd2W/LNLHzK6oYYUGVGo+dPvVZFk5kmtZvK96QsB8FBuZvT53eu8L5zF6uij5sqssYJQxAdDdbbU5V4vpkU2RwrPqJQFUOjf8IHCAx/VDWgimJQBzamKiJq9fvCqvUyKHXFAfqxzvS1k9ISXk7/+rjWzNPYB8FFGspkf3QyvwnFUMjmmoOH4Bbch0qZ87NdgxrNZq0GiXrWl7cmvDkEM40DaNc66BsrX69sTm4/fw0FC7zaxZAOj+NQV4lB691jPCWMy2ZoYPO3XAdWsOWDTxG658uo++zb4IidmXd9m2mgQIWqj5BboAVo25x+UZJBcv0HzHglTL+aTdTo6u7knthmNTyJh5ShoUGjMG8Roy6SdlBDWeB0u7dmLdlabnp52lHMwpVA3BvQgoNl2ZRdHbXG8LcHF5vYwq3wb/fhNEIHOknqa+YNaJO2ppk1ERqON1JhKVw4zmRBxxfzADFKKIlOxHlhCA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199021)(52536014)(5660300002)(83380400001)(86362001)(41300700001)(316002)(66556008)(66446008)(6916009)(66946007)(76116006)(38070700005)(64756008)(2906002)(54906003)(66476007)(38100700002)(478600001)(8936002)(8676002)(4326008)(122000001)(33656002)(71200400001)(7696005)(107886003)(6506007)(26005)(9686003)(186003)(55016003)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?iI5idHXD1by9SAtm3khz/MzhbH7cr9Bw+LSdIs2fTNk1yghVtebz76fCSQqs?=
 =?us-ascii?Q?UT2hBdBalE4QzGDBE5iWF7n19MzfI5py87eehC5Uxhi9G5+eTBzcLqUB4ZGc?=
 =?us-ascii?Q?yvX41uoL9vQeqk5hYJ8VGUCVqis18Fv0dXI+xto1hhWsfHWt++fZK3iutjTc?=
 =?us-ascii?Q?YbAs6lRDFCy8MZJiS6RwMtYZ1bU/6iszx1IUscg+lMoHkXuOPC2NxmE3tX0e?=
 =?us-ascii?Q?i3fOBwM5GWanMc5/V4ZvJJrwRwue+kgeJ4LaDBXR2e+0z0Ej8t5eO4m/lVIQ?=
 =?us-ascii?Q?A02Khcume7/zgEfePTNrpO+ZCjpAryPmKO4WoxvmzxvoAMTkOUAfUKPDtGjY?=
 =?us-ascii?Q?1gl2KNy/r7tPn9pcPrP5GTZXIVPAzXgRuMtwXEM/sCRiADlbZ4I0fUNxD1i2?=
 =?us-ascii?Q?6iMyaYDHEkKuROHzTqAUKLfn3v0ikMR00jYmSb6L0N96GY31jdqOf7/dHeob?=
 =?us-ascii?Q?iUK8o13dPr/E895A/sFdGL2OZnURe2zMrKYiJ8YF+Mx/SM6JIvHWMgR4omqg?=
 =?us-ascii?Q?c1y9Qj4avD9LIOs2gUFY4nSaXc1DoqHgsoGWzile026fA81KPSUP1bbHBxjs?=
 =?us-ascii?Q?2dEMMM2hkDiyHgiSv+4LPwMsp8+ihvUEfRewxsaFUXV7ZKguTzQw2Yy4mre2?=
 =?us-ascii?Q?LMtM4bNE/4dzVqsrLoQI6G+wLtdXdHgfJBb51U9shWsfpPePCHG+6EHstYI0?=
 =?us-ascii?Q?Gdqb6ow7MAfn0L+R1zdH/MrlncA6d2g5EyFdHIpRNvLHwzDt3IRMWZkTOH49?=
 =?us-ascii?Q?aZVlW4AcJ15SbM1uvmy3FE+I9FiZyN46PJaPu0iwiA549T2vvIsz+CeXdob6?=
 =?us-ascii?Q?GNG3ZkbWZR7qcFRmnbFlqV/ZGFeIB5iabWslsuNG0mfzke/GXE6GQ7Wic2gO?=
 =?us-ascii?Q?avrgA0nJAl89GAyZihM5UNQSrWbR1aby4w0dCg3f07KmxxhJ1VvRv286r488?=
 =?us-ascii?Q?A4BdP7IbSubd7jiKELBQaGMvUz2fT3pByqLV8BUSOGJG0TJnkOZWOlqtLYHW?=
 =?us-ascii?Q?E42Fbro0eKwuA6arfVXphgygZZ2MHdx5y+2R1kBkBwp7kYNsytGu4+z1NbnR?=
 =?us-ascii?Q?vE157bPxZ9jUnLd9cF2pdlmnxNyJEycCDd5aNxDm7zL0mHpr4T95W/NWImX2?=
 =?us-ascii?Q?1TTqf0qI3KUOgjjyAGXfT+DVBhW13UOiLGEueQXAjsHiqpBFt/pU1YoiHai7?=
 =?us-ascii?Q?FXd8qF0npTJI2BpSrfdUOn0SgA1MZUtVAvcMtucB8acpSsSjkOJD9G/dxygw?=
 =?us-ascii?Q?lQh3wCBesHFLk/jVsdqtF0C+8HsIqz/OCkQDZODb6uVbR331DeoFxOpv/9ez?=
 =?us-ascii?Q?9agvNDEuwCXc8gkbTr9zBm9vEKwTO9pgzDt1yT5N0ZD/vxX9zYTw6y5QLK+c?=
 =?us-ascii?Q?8oDC9mpef53lxaGQ1gkhoHHOGlrUAXJwfhqG359LomE6a/fbp1BqAV+kGOb1?=
 =?us-ascii?Q?sZP6jcXfcOQcGn6WeMEZSGP/XpqlskZaWo8Ecl0iTnzX095vT3U+3bI5qpj3?=
 =?us-ascii?Q?kQhVSgEUQHDVp5zkRZBr7PLGfi2rcW4Vwel/ive8l7lwdHPUB5/f3TWDkRMN?=
 =?us-ascii?Q?AGTjrRsRzvm3wGMFdY8i8IDUWztfsQmimxMolXG4Pj5/ZFR2tvEm6Rshn4p8?=
 =?us-ascii?Q?UQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e27542-269d-4dc6-8a23-08db66766997
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 10:11:36.6516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pkKAB4hKt/V4vumVIwbAJrxHZYAplGdYjr9zoCmFhnoyDSmGvgbzXo+5sNBs6VTVpo+Aqg14yopMGDbHZYosC1eILBoBlQP/O1npXMfMEXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8047
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 10:11:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11858

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [PATCH 6.1.y-cip 3/8] mfd: Add Renesas RZ/G2L MTU3a core
> driver
>=20
> Hi!
>=20
> On Tue 2023-06-06 08:52:30, Biju Das wrote:
> > commit 654c293e1687b31819f9bf1ac71b5a85a8053210 upstream.
> >
> > The RZ/G2L multi-function timer pulse unit 3 (MTU3a) is embedded in
> > the Renesas RZ/G2L family SoCs. It consists of eight 16-bit timer
> > channels and one 32-bit timer channel. It supports the following
> > functions
> >  - Counter
> >  - Timer
> >  - PWM
> >
> > The 8/16/32 bit registers are mixed in each channel.
> >
> > Add MTU3a core driver for RZ/G2L SoC. The core driver shares the clk
> > and channel register access for the other child devices like Counter,
> > PWM and Clock event.
>=20
> > +struct rz_mtu3_priv {
> > +	void __iomem *mmio;
> > +	struct reset_control *rstc;
> > +	raw_spinlock_t lock;
> > +};
>=20
> Why is raw_spinlock used here? This is not really a core code... this
> makes analysis for rt safety more interesting.

I just used the spinlock variant used in regmap for concurrent access from
different drivers.

Do you see any issues here?

Cheers,
Biju

