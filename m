Return-Path: <fabrizio.castro.jz@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05E9EE4996
	for <webhook@archiver.kernel.org>; Tue, 22 Aug 2023 10:21:47 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.137])
 by mx.groups.io with SMTP id smtpd.web10.4861.1692699701315942417
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Aug 2023 03:21:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=jEJ8wWEV;
 spf=pass (domain: renesas.com, ip: 40.107.114.137, mailfrom: fabrizio.castro.jz@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzbzsmjCi4HOjVqIl0tE8iPiJ6XJ7eLgx6UtIuW3H4NEth/IuClUy4ESrRbq0+wS2KPBLWXtoz3+4k+xhdxun/58aFPzTldY1zlxAiBrG0ppBVefWCjMVq0fO70KNq8+H7iudTxwdnSCIsf351RSDtD/YXVlDXiSgFPqxFpSQPZ4NjZefF7laK00l8Bra/FtG00wmkHr/bi7AX5RB8WtjgLyg/h2MEbaoIQpmitVSUrF5AvDBt8no3KKmAVkB0O7AmS3rTjjLHlTZmhmEy/PlOHTY4+eY+0+fwVKacvS2zCWTAHqlZs7QsREQXFQajust99VB0f5l3y6FDLv+518Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08KfmiYa71T/ipw9j5y8+rEm52nrZUQXz/e5AGTuays=;
 b=DJgddHC/ndslhgty8GNwhf1YyYtDO0nyDBQPhH2JmbagGksYA/V64iU5VQlJleeOhq54DD/s91PI9DHtM9j+IqKSgB+84smQDtPSRrc6bwQEJmleu9DBiWibTyymvaRd41rCHJBCg/sFhO2hsdghi4gn/uv7wgRvnzhji1JY3sS92jnTZwICF+NNYunS2ndEVKll4WfsI3ZvYtXRVyozAqocw/Mc0+YlA22ajCnHWhAV/9Cz6BEEqlo6iQC3ySzJP+6zVjfxh6PjR/WxpHi8Tsw6oxEaVOtrjGefRg0iLuQ1j60uJ+2bWleZpE97fvf1qhUZsARLnszt6esHUdcCrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08KfmiYa71T/ipw9j5y8+rEm52nrZUQXz/e5AGTuays=;
 b=jEJ8wWEVehVTb5ohI7mrkQpFOl+BWi9bn9wQwIR0wrH3TZsi06LQDtDD/IT1FzfuTKipPZGqyU//UaUbzUMTQI5+swDFo0gXpNs3xqmm0bgga9WyWarLd9jEx9Gu+ZrbRBz9oFkVQQvNFmOg+BnrecfEF0hygiQhVIZCFqgawBM=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by TYCPR01MB11866.jpnprd01.prod.outlook.com (2603:1096:400:3e2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Tue, 22 Aug
 2023 10:21:36 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::20b:248d:188d:a7ec]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::20b:248d:188d:a7ec%3]) with mapi id 15.20.6699.025; Tue, 22 Aug 2023
 10:21:36 +0000
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"biju.das@bp.renesas.com" <biju.das@bp.renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Chris Paterson
	<Chris.Paterson2@renesas.com>
Subject: RE: [PATCH 6.1.y-cip 0/6] Add eMMC/SDHI support
Thread-Topic: [PATCH 6.1.y-cip 0/6] Add eMMC/SDHI support
Thread-Index: AQHZuY0J+7CeCYEopkmf+IJ+KNnWna/CbewAgAADHYCAMjSlQIABqbkAgAACKLA=
Date: Tue, 22 Aug 2023 10:21:36 +0000
Message-ID: 
 <TYWPR01MB87751FAD44B308A8317216C9C21FA@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20230718153212.327448-1-fabrizio.castro.jz@renesas.com>
 <TYWPR01MB94206BB60C37FC05D49F8641923EA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <ZLkHg75tYMjt6rhq@duo.ucw.cz>
 <TYWPR01MB87755C152C51606BBB7FC52FC21EA@TYWPR01MB8775.jpnprd01.prod.outlook.com>
 <ZOSKNusPvGn/Huuz@duo.ucw.cz>
In-Reply-To: <ZOSKNusPvGn/Huuz@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|TYCPR01MB11866:EE_
x-ms-office365-filtering-correlation-id: 6be5c6b5-aa0b-4cd0-8d0e-08dba2f9910c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 QPpe+53ZjJxF66cEJoNd5gSVJrcUmXcA/xkqnnyEbvm8K9FRfNa0GCWSYnNBbaWymqEpMv+iU/Zk3pdVPvqUOYYkdAcCRawiEcw9wOwOnVfaWSS5xQVjOQezTxgUHU1AEfXKdbKF/2FZ96hIIW9M7nHThBU3x9BkQVD9MMav1+WY05QYcWvrz1rFjkuBxP09gNUUyYOpIsNgEs4ai5ye8jtB13s4motIabJTNw0dpq1mdKotWGGfYTeycSg6iC69l+6tCJNeuBIH91Ao8QbI/oFmMg9NF6Of+htJYmQ+fb16S5w0LQZjBr/68wASBhTK6XqE1XNQzOiJpWsYTSHGqvRDc+Gk63Ry4bNuQKfyGUTuLLG1mE701N6Qv+ksWhFva4d+Wu6h5CdAfI9+BZZFEsAFOt5tA/8IM96Ken0F/kAcI1E03/BrqKrIbE7Bm3xvbI3mNJTGdps/yDSnqDEL/WiCuVo8vjFrVxkU6GTbNcL+PQuxa1ov0NmCbBlga1xLFwPm+pX3O6TrLcr8ySWDJeILQ7cvblFAl/JxC/ELLElht4Gk6ISAMdY2IN8xHUv2i93qL3W1oUxhwht++h2m1eoBhvlmOHL5phLAxVFguaQLKuwVY5a0Szj9ROZeoeT+
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(396003)(376002)(451199024)(1800799009)(186009)(52536014)(54906003)(64756008)(6916009)(2906002)(66446008)(76116006)(33656002)(316002)(66476007)(66556008)(66946007)(8936002)(8676002)(5660300002)(4326008)(4744005)(6506007)(7696005)(53546011)(9686003)(107886003)(55016003)(41300700001)(38100700002)(71200400001)(122000001)(38070700005)(86362001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?xaOeRwalkEsyvV2WUCNS15hvPEXRqzX7YPmjshqqKhYbJwg5pnlgAz+56Sx9?=
 =?us-ascii?Q?CBEveWu0LIDgiU55YfFQL34EotX/mg/HiNRyage0pP9fK1XqhoKEl9Nq81Bd?=
 =?us-ascii?Q?lPiAauHg0v0fKTlMfMos5SVuyZAN5w8i5UrpO/DlsOUhgpwAE7gxGrBJ7f0V?=
 =?us-ascii?Q?jSrSa3h7Bm7weUL+32Iy4YT70VpM6v4hsjM2wROkReW1k6UgUIBUWjeoQfgf?=
 =?us-ascii?Q?D/dk2z1vOarcE2TM5WgPuhZYkD/ioAXv6jkb09FADqW0uQZHuqIPj89WoWYX?=
 =?us-ascii?Q?ueVPq8CSoRGHQJrG/Y3P7HnZoOubgF09uDd/jtx42wCAx1YeQkr097VBqEEg?=
 =?us-ascii?Q?OPRbkEDMQ8eU/LqVGumD2UXD+MafgKl0HcNxmDBsNdHC7hSc2Lokx1bzW9Ti?=
 =?us-ascii?Q?TeRB3wbejJ3zZDpvkrbiw3Mt0NJI8XJtovAZ2Q/+NS8Iogg/9No552L3kPOx?=
 =?us-ascii?Q?GrQnAH8iguYZBj9dw/dEEHvRy5Y1k2jkPFrfA089+rwZI72OPTdVMqJTgHqI?=
 =?us-ascii?Q?ZwziZT/xGbw+nH8AD9SPEKIpCUSNg4lZ35I+GJ8MW/HcuOLqhDQI+4fAdQlf?=
 =?us-ascii?Q?X7vm3aALIsiDQilXC4VgLyv38po/yUEH3P6DiWaLn228/cnuBbqYh2J+6+UK?=
 =?us-ascii?Q?6OjVRHG0ey8yZPEL6l5fBkl3F5r2cmw3rrRd//99pMIpCnNgMZ3B/LviE3J4?=
 =?us-ascii?Q?y97qWnBSCS/2enl7eJUuvzQtD1BKig2Lb/HBV7S3upnNZMRGQSM89cHS71vu?=
 =?us-ascii?Q?ZOPciQ+BtqBZr2fLQjpwGZwZIbEa9LUpZR78UcSXMe1//Ry+SgDyfe9pHjTi?=
 =?us-ascii?Q?2lIaiB/VGKeVqhoStFvmVdokmDUeLkeYvp+ZVGqvrXuWP7BHg5B5NZzihT9I?=
 =?us-ascii?Q?OeBUqnYGIDW/UazvSrXp3JcUYskCXSOPvQYivxsh2dCfQjA8Hr4j6bVFWoki?=
 =?us-ascii?Q?aWzrBGOQ6adveUE5SCVYGKKGuHSEGbC2KtEf8uEgBp7ZgamrYnYyNh9w9Nfj?=
 =?us-ascii?Q?ym0aSIkyP4hfC53wtdYC+o7OrtyEo4JIfoMGq+Mop/0Ggqe3E16PXGQ9lNdj?=
 =?us-ascii?Q?JjBMTDMfqoq8pOj9qeWO6QKIaH6ukyiYa5qB//NWmDHgAcL1w0glnJvSmw+a?=
 =?us-ascii?Q?Eg/6sjll00c+fM54SVI/9gNj/2BITEBzQXwAu3Bo7ymMQ8bx4vhJv7OEpp7V?=
 =?us-ascii?Q?qMMdZsfmm43hP2CdRrTpm0qf86sVfwrcCAgG9OhWZQ2AdDsI7M2Qcjpu/BBL?=
 =?us-ascii?Q?dvRruMoIo8cduPTkVQk8aL5O391uwIxb7O/3ixK5xFUpAvI45F3YhT26bDwO?=
 =?us-ascii?Q?kF4PJmHIwzj48BPKNh3gKJl0cVaWMtx/XOmdH/1QdC6Z2eGtGmWuBLzR/yNy?=
 =?us-ascii?Q?LNovPwXv+xhKdXFZLH9RsDwozimPwV0u2dkWfdW1V5aRQEhAuKCBbRqw3Opv?=
 =?us-ascii?Q?5VsqAHiWk8njEsBMsnRGr9ZH0JtRUXQOOPzJO5O8wx1sEmX2162dd6ikRLnm?=
 =?us-ascii?Q?FXU9uujBYZ/8DYv67ITcr8okXIqfx7sb63j98GbcYqLJPGktNUEF2XLXJ2bU?=
 =?us-ascii?Q?w74KUeWEJWkKdbYIc9PnSAbpR+m2feHc20bJDSxd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be5c6b5-aa0b-4cd0-8d0e-08dba2f9910c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2023 10:21:36.6888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DDsYeMWtn3mh4J1UUv5YQgJWO0Ja1/VDqpHIuZz4SziLX1IQbfd5zUBCpcKrCtTq2FfNU1XeOXOECDgo+gROtOsD5oUTnvp9pSPL6WLbLYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11866
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Aug 2023 10:21:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12818

Hi Pavel,

Thanks for your reply.

> From: Pavel Machek <pavel@denx.de>
> Sent: Tuesday, August 22, 2023 11:13 AM
> Subject: Re: [PATCH 6.1.y-cip 0/6] Add eMMC/SDHI support
>=20
> Hi!
>=20
> > Patches "mmc: renesas_sdhi: Add RZ/V2M compatible string"
> > and "arm64: dts: renesas: r9a09g011: Add eMMC and SDHI support"
> > are found in v6.3.
> >
> > Patch "arm64: dts: renesas: rzv2mevk2: Add uSD card and eMMC
> support"
> > is found in v6.4.
>=20
> Aha, let me investigate, it looks like I got confused between
> different patch series.
>=20
> > Could you please apply them?
>=20
> They were already reviewed by Nobuhiro-san, let me take another look,
> test them, and probably apply them with the other batch.

Thanks.

Fab

>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

