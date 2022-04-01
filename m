Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD94BC64E77
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 18:46:47 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.98])
 by mx.groups.io with SMTP id smtpd.web09.3469.1648841725552430380
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Apr 2022 12:35:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=YstzJdGe;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.98,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwLOZ86yu80fYzLVQV9KcbqcK5NKv084wkYcAT9qSWiR0JMavoSrtwyhJ9gUPp+pHoMAFFKuGNdOOper5TuVtRDBfxDKtZ/hURXiXWK79HYsvJJiiQX7hI7KtysBvGIJIF3oHcw9q48j/7rEQN9Rte5r5jw52mEDZe3ooIuztDP9bbDQS5XfcR+ewdqN9NMpj2UEFYDOkM+uGxugAXFvdjjuc/6SOAo4tGfGp1KLeIv4BDap/BCbIUMt0lynfGJ0mBOMo6WpNi9nbXpTkbcgE4ANjQoa28kf2NvoIER/Vw/QFRowm6dkS8rJea0dw4opetScF39zGfQZk7ZyBwahjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3PFKM8VfRhLau6dQSW3F5T3CEhT5beKhd3o4YapMQs=;
 b=Dilpa4laD7YQW/utH+cMnHYEVszLjsG+bJY/ENG8Ads0huTDvWgINuYSFDOVTMPdvj69KuUxPrmpDRvGQltpHSNw+uU+GhD61/Zr1qFUYqeCS2vvUf7BKJlPZ1y8FoRdZx0V6xec7HG92BbxmN1sESAlWx4puEk63JJtogfwEsLGL+ykoBdF1RNV3J8mRdyvOlU4ZC5ZoVL6YV/n1AwqWa7jwg+thPWNL1uN2itDwgbnkjrNOxRndCZjo5NvSVimTL96B03vrwZm944gRHTDENhY8m1h3LujplYaXYCx9H7qZfxllEYCzgLX1pItnnKKg4S/8h7CZ9o+oUsDnL3k6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3PFKM8VfRhLau6dQSW3F5T3CEhT5beKhd3o4YapMQs=;
 b=YstzJdGe/alp7feDHWu234zJthCIWTN4o3F51T1q8JjL+gn2eaYtUqnPo4Cgm4GHxPOad8gEQ014flMD8XJ4C//nQGml911wb+Q6fmeAoKfZMHTiTn/ZMB4eTVsMuvPEViIXE1PFIApOoVGic2pQBYgcfYFdeKAB/hotboAQCos=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TYCPR01MB8568.jpnprd01.prod.outlook.com (2603:1096:400:138::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.28; Fri, 1 Apr
 2022 19:35:22 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::9dda:1c9e:4a15:bddf]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::9dda:1c9e:4a15:bddf%5]) with mapi id 15.20.5123.029; Fri, 1 Apr 2022
 19:35:22 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 00/39] Add SD/eMMC support for Renesas RZ/G2L
 SoC
Thread-Topic: [PATCH 5.10.y-cip 00/39] Add SD/eMMC support for Renesas RZ/G2L
 SoC
Thread-Index: AQHYROGhzuvU31rZKEOpst2SCZ9dx6zbdQyQ
Date: Fri, 1 Apr 2022 19:35:22 +0000
Message-ID: 
 <OSZPR01MB7019E7522B2A3D7D0D6C039DAAE09@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220331092808.GA20092@amd>
In-Reply-To: <20220331092808.GA20092@amd>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c8426e1-7a12-4e26-e1a5-08da1416c31d
x-ms-traffictypediagnostic: TYCPR01MB8568:EE_
x-microsoft-antispam-prvs: 
 <TYCPR01MB8568C12FED4081A192779038AAE09@TYCPR01MB8568.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 bPEG6AMge9BSeHNtN8EehAYfrPXF/wmNOEApnS8LlHNRK7sjKFlFHWil4jKQ/R88484p7IBq5VJMnBeELqJWg7PnMG7DuJIDYVibujhguzEVdMKXwg8xJ6a+274PMUSCgZ3ZPWS3GI4kP93zuG20nwnHRGnBBPfYaEylN65m3o+OMZkj/9J0CxlErjzzRlC5QMpVDEBuKNp25cPI+a9joGSynsR2e1ZF/htWT+EGYP2jeduicuNI9/GkDTk0PgWAPV2q9ks2BbkYUNklpS5wLBJv9O2oaEyvn7j/VJFiqlFScG0Epm4krSCnlFssUMsJ4t71wboItdhFbj//9pxYB3y1zUId7B4veatyCFzpWMKhLFKSEKaR9At/sItTWCvfL7ZlADUk4rhAzCFpEvzHfqgvsdacfVAwl3UwwX7Wos9+uLi3b+mpWU5cXWydCvKfzLD4Oj0nss/IXhtqeBRyUQTLkuq7bR3vf/HReKQOcurnCrf5cyb0GF0DaVM5qh3vkmTLQarbB1Eh9HaBhgyDEXAnukPBrM+98g5uOErqANZn8emgUUipDs4rqCmu8m8tLIQpC7s1OSF/oIwUk89Rou6Z4va0vSiyVahWv+Nxqf+1eZcx6uP1yaoMpzDeCRtrfuRPLi6fXXA0sw8iN79ZlpSb+PnAoH0Ed1wwIuP+XmbaGb3c4dFzYYp2km51JvGC
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66446008)(66556008)(66476007)(64756008)(316002)(66946007)(6916009)(54906003)(76116006)(38100700002)(508600001)(38070700005)(55016003)(86362001)(8676002)(52536014)(5660300002)(7696005)(53546011)(4326008)(2906002)(186003)(9686003)(26005)(6506007)(8936002)(122000001)(83380400001)(107886003)(71200400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?l1bDnI2V7BXPvgnVZhEkJTpQWJfMX9A/p3R0xGLvXyZHyQJgT7wyKAoWkrOY?=
 =?us-ascii?Q?oSj99KV2GeAhi7SJ3Ffp4OGoAygUEylgTdhMjNR39udphl+GZ2u3ySqMpR84?=
 =?us-ascii?Q?dF0bTYYWEy9pzrIg6NPU9ytV/q2HwycTlAAcuIG4eDH4XXHsxcSnEX9Z9G7Z?=
 =?us-ascii?Q?+MtIQ5gVql2nQmkdkhmLi3FkgJ8swi+IGMPEVqP29YuUbHtpqAm4WMBaYWCb?=
 =?us-ascii?Q?HhFuitrxGOYdCb5VqApojE3eBX5bslY4c1rtxYarh4rfNR0jmLtZBx5nvOb+?=
 =?us-ascii?Q?Pyc3FhOCAgs/bSJSFfW6VmG+OM2NXa7iZIsrTOYbGWfIHW+5yigPVtTAaawl?=
 =?us-ascii?Q?daxfC0996n3ZVdce9Tih0DpwID1adbN4VUeHEQwTmW/VgFnKAYHRY7kv4mnE?=
 =?us-ascii?Q?28ZDDxu/1T/2UwY363vD5Ie+lf5KUfnFX22j3xkZjwbEdb5McSa3A5AyyGAA?=
 =?us-ascii?Q?XfegLGI7ZluewAVsYVg6rbHN8qMklA1xT8/xT2drnSC/q+kRWhjsOW2BLTtS?=
 =?us-ascii?Q?i8t5E0fbDDOVWOcOib5/JZI/GMlQuXWn5jPXFvkyQlOypqxknMMZ8zNE2lS4?=
 =?us-ascii?Q?TKSmowcr+/fWULQvc8PuioFP8GECN/Bjk+Qgjnci1mlNFBNwE4jgaZG0dVXA?=
 =?us-ascii?Q?z971OeRNeTWBw9/E8HDmIkomdXlaq0JrbPPqieoz8gorPaIDQDO8TF8h4HeG?=
 =?us-ascii?Q?OgGHa+/bD4wgC/OyC53Qrtq9LmSr7IleOmyvQ9fcTtkeISMQ+hn2SJWn4geH?=
 =?us-ascii?Q?lwM6q7FbJAryzvLvh8Hgw9QDY7YqJGsUF1a/UbewPlDJK0Z6sVdbnvLXF93U?=
 =?us-ascii?Q?x9fj/z3BS7lJau4Av0B4ROWdz7zwX1YvSr+eY9bSs7PxEElWxuwaAxONDnPe?=
 =?us-ascii?Q?vgCEn3Bpg2s1VS8VC0VZDJ7LYkQaH0vcHxH9NVnCbGWZM7RIZrqd/aAeKbm3?=
 =?us-ascii?Q?+jpt1g1jbKvBFyKxNxEnOnGKZNikgH9fWN7ebSeE0FG/sm6voMcDQQbjLz56?=
 =?us-ascii?Q?59X9yH78+mRve/KK9DINLKcBBuAdg7wxTcnxYin1t2DduYMozeLV+5juL7RW?=
 =?us-ascii?Q?Ger0G48X4D5Ef9wY1mkpV+bKoUlgwhzxWT6efB9BQ5IFvnqkxnf0O1KG0Zna?=
 =?us-ascii?Q?LWWCIvv0LUP8LopDHAdGm/hKCAcb5+XUJ8yJpmrq26bVskL4ceRaZM/UPDzA?=
 =?us-ascii?Q?GybTJlYUMhUnkh/DvGe8KU275gDpgzY9uR9pUzNW5C0Fne134jBzDAEUgx2B?=
 =?us-ascii?Q?Uc9Q1j+vMwyoCtxAtrSGMRFkC/kFlYhEK1eo8QWQMRyfxp4nBg1H9831UIXz?=
 =?us-ascii?Q?md0B+ykGO3zisMa+1yKgPu8mAPDcGvUJdUjtD+Sl5G1ff8czkg5snbuSPrXz?=
 =?us-ascii?Q?eU4BuWxyAmve1rsbrbk4y+3zuhShrspP7Nig2cGzw8uHVVPNMLDBowCVWz2L?=
 =?us-ascii?Q?EE43hkiDZhEr17Il6NtF5CFjZJHrhtnD6coricWIVtXIF1lyzyDN606Lo5Xj?=
 =?us-ascii?Q?Y15oNZJgDobFb0fVlFpcGJomzcKVYc8t0UOcCwNtBiWCRd3C91gTqoS/ObdJ?=
 =?us-ascii?Q?e+gL+LoDlQhht8I3SlDPTKxOYK1Rzoekq2lIdT9gKcBSKifcgZWhsmfXV6Sq?=
 =?us-ascii?Q?u5qq1V5LQEhqCL7dalkf57pjiwhCJOOyikuVHmplQkd80EGR1yDFHTkiuq0i?=
 =?us-ascii?Q?YfpbtpOIatHQk/nJvTs7KZ/H9P+b7UFnl5atvlOPRwcaBQb+Wi5pEXW2pGlc?=
 =?us-ascii?Q?BqokUC5LfJ1/M6NZ7UYQ/dps0sdPmuncXRt0xIR1Y8UBG0z7xOcl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 4c8426e1-7a12-4e26-e1a5-08da1416c31d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 19:35:22.0448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 F3tJRq1wh2dRcO8k/jJXsECuOu+OxtIEMb1/qWru0c/obzHY+bhMjGhtUwqLHBbrp4vR4U1tIXxrFD2HM1lBVvDY/N1HmkBfQShfV3jP8Fn5h7aRAawpsU/JqgPZXi1g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8568
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Apr 2022 18:46:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7910

Hi Pavel, Nobuhiro,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 31 March 2022 10:28
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>; Biju Da=
s
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip 00/39] Add SD/eMMC support for Renesas
> RZ/G2L SoC
>=20
> Hi!
>=20
> > This patch series adds support for SD/eMMC on Renesas RZ/G2L SoC and
> > enables this interfaces on Renesas RZ/G2L SMARC EVK.
> >
> > All the patches have been cherry picked from v5.17 release.
>=20
> I tried to apply the patches on top of 5.10.106-cip4, and could not. Can
> you double check series applies properly?
>=20
Sorry about that, I realized now I had missed a patch!

Will resend the series (with 40 patches).

Cheers,
Prabhakar

> 8bb6e30b765989a3c0924158316d689e16317cd1
>     CIP: Bump version suffix to -cip4 after merge from stable commit
> 66f600a7a5460b6acab5272ac9f54f842927a50d
>     Merge tag 'v5.10.106' into linux-5.10.y-cip
>=20
> Best regards,
> 							Pavel
>=20
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

