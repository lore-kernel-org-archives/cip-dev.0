Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5ECD41D74
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 09:44:23 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44778.1765791853575480343
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Dec 2025 01:44:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=HSpVuR5V;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.48, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NdPhYOdRNSIOe8dO5f1lVSQXpBPOJkAXqazE1O/mY31UFJti6Sfn9c9+K0b+diZ1LhYqanV34DjTDLJ0KHQgqqK7VmFeimAglzINu7OXaPXBGRJ1FKGOO0GzETOeca5kj44ZHzGR5ID1BybdoHMZHmBK5004Dmqe6fq4ZZru139bZsX5F8K0cZGkWUR98G3XRFvnhHcjtLN9J15VlZMbzm8wsGBlh7kSGRsM2tgC4Zs8JfJ0E4VZ42GVeSUGyQZ9/R1HYahHN3h6WgItAiiHR1h0KLQMQ1+Jw+2wOnONYCaDaL2p2rQQb5bLMRlETq7Yb4RxzbcLsv1n9cCNkuUD+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3Wi97zS261XGVVxF03nOhS23XxgBjzOsTfIKSi6ezk=;
 b=OdlpHUnLFWtzxWSprEvJm88ikjLvZHcuOvE7KghnABBMQv2EyiY4eL7crU+t038AUNk5/sfI0E5trxzXwSyIW7D4Y4j0fnTNUy3eM6GHV7T0oPEjeZq7xq1IkP/ax0RprOng/U5uISJS37k255gYgWljmPexjJ6JCv5isbTG51k/Piq74s3mpRPPr27mPCVBa330hZlx2bnLV1TvnacZ63J3+Q6sYUW/JYke5OqpcgHj4D9y/GewTrlsg0N3isNBPzTqHTes4SC72tAzymj2o+0regP4VaUVsUgk4omMOCntSQfz45QtCCLjDWIVeMJ+yydMZ/RTi60tXp1RxeOytw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3Wi97zS261XGVVxF03nOhS23XxgBjzOsTfIKSi6ezk=;
 b=HSpVuR5VmkLMY+1nSoTu5XyDfNRtqgMRNS4j5PHfQKtKcxAIs53Uh8BTdpHJnL4X9oZPn6pNQLQUbSDsWQRDIH4/EaoMa/y1wcPZIeNReZRh/ux11aUF0rjOPq8tO236HaxntcivYVsVmP0zkVETdn6+aZPhuDeOjsolFwbx55A=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY7PR01MB17008.jpnprd01.prod.outlook.com (2603:1096:405:32c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Mon, 15 Dec
 2025 09:44:07 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9434.001; Mon, 15 Dec 2025
 09:44:07 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: biju.das.au <biju.das.au@gmail.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, Nobuhiro Iwamatsu
	<nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel Machek <pavel@denx.de>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: RE: [PATCH 6.1.y-cip 0/3] Add suspend/resume support for RZ/G3E
 ethernet
Thread-Topic: [PATCH 6.1.y-cip 0/3] Add suspend/resume support for RZ/G3E
 ethernet
Thread-Index: AQHcbPFhFoOGeJRTnEqw1vN3E8eynbUidKfA
Date: Mon, 15 Dec 2025 09:44:07 +0000
Message-ID: 
 <TY3PR01MB11346E5C94784858F3DBBAE4686ADA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251214120122.3784-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251214120122.3784-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY7PR01MB17008:EE_
x-ms-office365-filtering-correlation-id: aaf1847c-5443-44a5-e67b-08de3bbe7dec
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?YOjKWORfI0wx9+qC9ZTinpAjvdU20+CP16l4900I37SwOaMUcRga0xt9n3GB?=
 =?us-ascii?Q?+7nmwYU/7iewVD2oORfpB6mkPwMys8O/ckXXd6VMCP86+QSMPiFRhe0bse+1?=
 =?us-ascii?Q?UDIN/9i8rywnPwz6rNp1YuOaj2HuKAu+IDatAJmciEtpnWYuqBPSWh5visYp?=
 =?us-ascii?Q?oCaS9KtDAclKNqSifurMQY7kGbkQ3mYsuUK5mKloZQSGjTtYuA3fAGNXieQF?=
 =?us-ascii?Q?soXiztNnQiHXT8INNswz19ssykAR/xKWuP3MvptQRLS+Mm/bJB05BjMOIaT/?=
 =?us-ascii?Q?ljqp09crM3Bycc/3iMWuITygAMytBpPglliJcpkpdhD3NAKeVTI49S46EQiJ?=
 =?us-ascii?Q?IOw46W6u7Jsp+O2PqyehS6ZT0OHRCqL4qJv3likyaQE3Ks0VmipFBGFGMkJ0?=
 =?us-ascii?Q?zqEYQDebzmPqhB4n726u2en4PCmxfEdvXuqaOlUSAlvWx1oR3SOP7uoGMTkt?=
 =?us-ascii?Q?pDzGg8oo0rM4UwnMB2barUR09KlkXuFkZj+4D/abQAUx+Ucdg20+AMUKTebC?=
 =?us-ascii?Q?tuCzoAKZSMU3cPngGYlbMY1pucmlo2kVBpP13sn0f5vswLQ1ADf2zUgC4oYf?=
 =?us-ascii?Q?0vP3OYmwDeFeEIVxaopwv+3dLtdANEonTi0jovxAMAoOxi5PtrpxGn37b0Tj?=
 =?us-ascii?Q?XSun32OjWNgjfZSr6+vcvxDxLStyco1xbVMN/vZ5lmxJcqvYa4HOH1OtAGP/?=
 =?us-ascii?Q?eYLte8ezElNBb20V+ZJKvHKsfXqCiP5qCwvkBVmL31DOdmXriHp+wzC1W5ZE?=
 =?us-ascii?Q?r4M0JHz62Kq68O03MR+/p1nz5DHOgGc46JqVcUJehNbd5gJx325c48lqnif+?=
 =?us-ascii?Q?xWpge4oJYunYYIFDTrVP/8x39mMztz+b6imptrQ92dTB4hIFlN8UbOSMLyOt?=
 =?us-ascii?Q?M+QlpVfCrZvRZqMGgorlZM/JfAqLaGwUJjeJsETCRJHA1/pXsaFVggcBM/bQ?=
 =?us-ascii?Q?88txTJTtcldHtZoA9pOuga/v3vDEdWhxjyYXkJnloCiL0LcjX8sByZ6w/cGB?=
 =?us-ascii?Q?1PA78kxg8I90bZobsQwdrFHnty7TIrvrOkHCWyzW+g1a3cuh6M06suEqzD4z?=
 =?us-ascii?Q?HusHLHpo/lF1HNljcu+5t5AlH/ZvRrZZPHNqB+1dE4ybM4gyy9slqCeww4tZ?=
 =?us-ascii?Q?WMQLMHdwx8poXR1tjjSGxPSw+wZyAmQhBhpcHKIJPWkg8EfpnQa66p2jPY7s?=
 =?us-ascii?Q?YP7Vkl2H5Ovkb5l/YQ8JV/8LeIDOBgZIkp0eDAZgF9E38c6owBu42Kh38zTW?=
 =?us-ascii?Q?QJ+ePidys1OA/5pesEgRjGPq1jY6RkWxQ9frydaIfGbbn7NT31Ova5zlEVdB?=
 =?us-ascii?Q?CKMyqHcaJT9261ij8Bm+X1JZjJjKmPys19NsIrCNdPBNI/khWICdH+2uOFRZ?=
 =?us-ascii?Q?t+Iidav8vKfk0raN9dL3rR50+og6s2bxnHPkxg1xSjsXWdD/S2CKBZraugM7?=
 =?us-ascii?Q?XlRZDfG4t2YwsOGJx/LiZPxkyIAgb49PQ5l87za+qcrlO/4/P32TZl7735bd?=
 =?us-ascii?Q?psW/e7XoQtpEEuCEHzmzsD19bLM8fQDNMkiE?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?NzPpBoLpj/ab4soyb+7clB5Iwcz3RdYqIzhuWa5sHoY5o3+AZR8hrepE0T3s?=
 =?us-ascii?Q?nwmAZoXI4Ua6nMa7ysF1lMevicyG9Tfw5MMvnOitRCvn1I/4tdiDreeL3GOG?=
 =?us-ascii?Q?J+vlO1pp6eQMSbJgpbcjmahnmWJ700+PHJSGFx05Wl/QIPxZQlhHz6tM6FG7?=
 =?us-ascii?Q?fPqC6+vRAOTEnXDn4d8edFdN+ejnVk+7zjJ3mUrEi03hhB7m4KHctDlTHheK?=
 =?us-ascii?Q?So6itB0RqZ1MlljEobHdEIC0xtZSpWxZO8BGvM9ZZCuKnOdxHymfN38EphkU?=
 =?us-ascii?Q?RrCqbI7r7PJmSQDG5bn0O/+vOlZ+LsAJ9GU/XancJf3dcllMNU4onBYLJsCF?=
 =?us-ascii?Q?3q+UmSUYmlIrFnNuUgq7FkQx+dbIo9nmncHQEma2f1l9umELNzBvnWQw26ir?=
 =?us-ascii?Q?Qt1JfIeyZ3EILe9HtYSbY1OyGndyH6qp0v+PR/uepp4ZLE1wr4R4nVoULlPj?=
 =?us-ascii?Q?j5nd7NVsE5XSQ36jWFBaQWtce6KaF8f8YxBP6+igAbdJ7y8c6OjxQrAXvFAu?=
 =?us-ascii?Q?efc8nEEzI8EqZ5naRZN7ae/FgRGF09xfC3qbeKUnBp8Lxye8p41J7McUQEh6?=
 =?us-ascii?Q?5VS57rsHCs0UfCZAG5fYCLRk7r1dpFYpBXZ8qTUqKwXl1Lbzk5uJc+6xRgyb?=
 =?us-ascii?Q?nYECvQrsipbrA/5HRS41cCSwnBYpZAH/lc/vJUIIr9SqoWUSFRVjyx289pkS?=
 =?us-ascii?Q?z8t/5wDaWe/k42KoK/jyHqCEXdB/LHeyXgBrFiWmb1zYSK3eI2PdCJZpRawb?=
 =?us-ascii?Q?DXMNEK64c+z5jiVERqiloj5MQsj1an0bWOs1ns0HMSbP/5qpGUIN1k9pYsVD?=
 =?us-ascii?Q?anbMJXeGNaXGEdiY84cSTZumteRhG6tpTMs2E3bQpZat4Vof7AveIYhi6mQ6?=
 =?us-ascii?Q?teg16SrxVAzxfjVkKOLSGQN7ULfvCVY8y0BtA7+Bt7g9mTa1/k1zCxZSMf9h?=
 =?us-ascii?Q?qfGW8uy73JVMhW2x4O8CVzxXvmU+XlzqB3aGQXX0ysxKqnwltTUky4hnG2QD?=
 =?us-ascii?Q?0E+NTz78i0zw+iH3zeUDOisLAo+3KpUNwVjE1lXuFj1Fiu9qSP0ycwXnA6W+?=
 =?us-ascii?Q?llzERz3kNOxYLsR5bDA/CvKPazvY8tqXe46dSz3LwqvJyRJlsMZzm46Xk9Si?=
 =?us-ascii?Q?A1/6Ypj126V8iQKnEbRFraDTFpoJR9GLlp/1GhQMJgUxh7fgT0z7gEoE7I6g?=
 =?us-ascii?Q?CSctgKE+9zCsH031pF2gCM8w3TExwXk0kW8MR8Tk8ILFRFXGXvKFUVefbX2n?=
 =?us-ascii?Q?1uI9pNZAhv8B+a8L8eimzGgolRjgnsuF6Ok4NMHXIDDpMCaNBHLNvRN9+LVR?=
 =?us-ascii?Q?BoTPFhP/4T1Oh60u1/y2z6yLVhNB09PfpqgBy3H9NNxb0PRMzvNrivZfrvN9?=
 =?us-ascii?Q?dy93qjFmOvByjO2ekdDv6+TsBSM64WwK1tjiQfWSa76h96x4N4QwfViEbg8t?=
 =?us-ascii?Q?/JRYqLhPXkgH/6bVjaNKLNfxXVxEvfsljy98dmt7/LAE4K110K+aCGNvhHjb?=
 =?us-ascii?Q?+o1o0y8obDjWtdGMiup3KO3Pj0U53DdybgWzKf7Ktr/UAPg18rJGXSCU56/T?=
 =?us-ascii?Q?SofGkBu1ZPgLUjNh+3WImAVF/qU8rfkdEVRXSJdQZYWyt0iVrLS00E/JY+8r?=
 =?us-ascii?Q?lg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf1847c-5443-44a5-e67b-08de3bbe7dec
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2025 09:44:07.5652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L3jJznDnV94/SHmrPZOWVpWPw1DfbFlO0+DOcmuBSRxQBy93m1Rw+GaAmBV82P0Bqmq0bckNhpGWa+hrai8oIz3GA1NDHFhyx0f9CKwJGCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB17008
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 09:44:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21036


+cc=20
nobuhiro.iwamatsu.x90@mail.toshiba as Nobuhiro Iwamatsu <nobuhiro1.iwamatsu=
@toshiba.co.jp>
bouncing.


> -----Original Message-----
> From: Biju <biju.das.au@gmail.com>
> Sent: 14 December 2025 12:01
> To: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Prabhakar Mahadev Lad <prabhak=
ar.mahadev-
> lad.rj@bp.renesas.com>
> Subject: [PATCH 6.1.y-cip 0/3] Add suspend/resume support for RZ/G3E ethe=
rnet
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> This patch series adds support for suspend/resume support for RZ/G3E ethe=
rnet
>=20
> Biju Das (2):
>   net: phy: micrel: Add ksz9131_resume()
>   net: stmmac: dwmac-renesas-gbeth: Add PM suspend/resume callbacks
>=20
> Raju Lakkaraju (1):
>   net: phy: micrel: Add PHY Auto/MDI/MDI-X set driver for KSZ9131
>=20
>  .../stmicro/stmmac/dwmac-renesas-gbeth.c      |  1 +
>  drivers/net/phy/micrel.c                      | 91 ++++++++++++++++++-
>  2 files changed, 91 insertions(+), 1 deletion(-)
>=20
> --
> 2.43.0


