Return-Path: <fabrizio.castro.jz@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5D4EB64DC
	for <webhook@archiver.kernel.org>; Tue, 11 Jul 2023 08:26:08 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.91])
 by mx.groups.io with SMTP id smtpd.web11.2973.1689063959624990999
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Jul 2023 01:26:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=BvKPn1bv;
 spf=pass (domain: renesas.com, ip: 40.107.114.91, mailfrom: fabrizio.castro.jz@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnF2dL2nH44QilOKpaVpu4uuqABdlWLPMud/x+2xF5WaH6lfIhcXV9NWz46c2oxisyBu0o+d3g8KkIePi7dsJYf6VNShNJPEjme2qAP6Bjz22wWVvfVNzw8C3UxfOQUWo6Kd5GTbfNHZJsqLf89BzSZ7DH5gaKFPDwc322wmlQZy7IO8TbfQx3vkQpubtS41u+RcnlHEtjnHOZbU8e+ph043GYPxxIwZ+eSzj/wJneH/5PyL6lVlWQNPBgn0KdSaNqHPwSeBD0wtYrno9I2eYDRtByrxMiyJoxJ8h3rS7ZtcP4s6faYUJrR93nuCP4wI8fRtapfA4khL2ujISuw99Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJY73v17vowA6vVvC1VkCmq4NhMO/Xs9+OIBWOr8odA=;
 b=b8SHDJmUqU/K/XfAIkUTBlCLlYpFN/qxMN8Gx4hferz6Iwx3o7luxXf3N73kVtvMZfO6zwWiTIWUKjxRoxm35qVkBJPGM0S8F0sI62QOeu5cPDH+IElgen/PH2zz8me8F7D8b5mvJA3WiIYMOfJEWDt2yW18QU3CjiyqblVY/DKWV/OyhkEEokx1ezh1Yrjia6+Xc89Q3FgrPTkW7tCgO2ostz0TMRhVdCr1J+aU94LJb5+tp9bJpRRpRTipfdiTlyhGgG4+x3bjReDWnqKY4yloTzlF5g07av8LpZHS1UF3tSOT1xMvIF5RSOnYVaDpglqcWGq/GV2BDxa9ZyF+cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJY73v17vowA6vVvC1VkCmq4NhMO/Xs9+OIBWOr8odA=;
 b=BvKPn1bvAGkzpgOJe//Cjyq5TVwGNHrMbKE09HNctPgmyzej0+ENi9rHvVGGT5iCm42YILnI8b8KkozQK38qHSOdWqRWF++zfXfMeIw/JaYfFEcmMkajymQU5n78q3ftGCf6u7U1mk6qeHysl0Or9r9eLQOSjwyUfvdADcja2PU=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by TYWPR01MB8824.jpnprd01.prod.outlook.com (2603:1096:400:16e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Tue, 11 Jul
 2023 08:25:54 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::c3b4:9b5b:7ec3:7ab7]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::c3b4:9b5b:7ec3:7ab7%5]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 08:25:33 +0000
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Pavel Machek <pavel@denx.de>, "nobuhiro1.iwamatsu@toshiba.co.jp"
	<nobuhiro1.iwamatsu@toshiba.co.jp>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"biju.das@bp.renesas.com" <biju.das@bp.renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Chris Paterson
	<Chris.Paterson2@renesas.com>
Subject: RE: [PATCH 5.10.y-cip 0/5] Add SDHI support to the Renesas RZ/V2M
Thread-Topic: [PATCH 5.10.y-cip 0/5] Add SDHI support to the Renesas RZ/V2M
Thread-Index: AQHZrdIq3XDB89H7b06mLbgyT4rIha+r8+GAgAKFt4CABczyAA==
Date: Tue, 11 Jul 2023 08:25:33 +0000
Message-ID: 
 <TYWPR01MB87756E0648124BAB16604A03C231A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20230703171649.15862-1-fabrizio.castro.jz@renesas.com>
 <TYWPR01MB9420D58265BF325B0FB9F9A8922CA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <ZKg0CxYHByaAo3VG@duo.ucw.cz>
In-Reply-To: <ZKg0CxYHByaAo3VG@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|TYWPR01MB8824:EE_
x-ms-office365-filtering-correlation-id: 8b70e58c-c6bf-44e5-7263-08db81e86529
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 3t0gOhY8u3JFHLx3WdDzbWgeAszegy6yOIWhHvwH8hIPxnasP8k5puYASSpNuJUFo4o3xBSg8rR4N0tJAUS9BmXFLvCKHCOdt9yQiuavvzPw5vPYBMDU6IU0yRc9Fy0rfs89IT+trTBHIdIgGlu/d4EHFz1D2TBCHN9M4k/P6b0DnFDxLQbYJGPBgypivAkXaXIfr7EQ6/N/FV6apvp5UhmAx2HYZ7BJAdjvdeXvqDvzsmwINAHjuRAngAxCfzWS520aKoteNp/5BdTBkIr4hKKcR/GS9jAnYLSd2vJrf9pOowHpVfAtWrRdN3CIZvtWrG0qE0mnnwcv4FLWNQWKbox9djCxXZa1cS7h5QdpaLpzg5VHOejFrm4E4+/t0nokC9kYVMBOU9/6e/1dX6XfwG6UWFDHRlrk6fG1Q2gxwR8jubkVyWB4jkFRvbV/6NH6bpPYA7Xeh2ARjIMSIs0tQdVgOY4u+dhwenLwlF5KITmkBJVRs0K4cAgCyNkPLjlsF9oXrADCl3ybYCfgpcXjjuiIgj+SZ6uqsfCvAl0Tt2hqXKxcF9ucF7xNCyoojtV4898LiBVwTgJZrwwHsNa+JO1VFInt3xHWLCCexAS1xuM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199021)(6506007)(9686003)(41300700001)(26005)(107886003)(966005)(83380400001)(186003)(478600001)(122000001)(110136005)(54906003)(71200400001)(7696005)(4326008)(55016003)(76116006)(66556008)(64756008)(66446008)(66476007)(38100700002)(66946007)(316002)(86362001)(33656002)(38070700005)(8936002)(52536014)(5660300002)(8676002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?cbCusuACNJHVgybnl3LJ9/MKEyCJYnHhwdPCnx8qN6KXncG7f6qn5vYzqEgk?=
 =?us-ascii?Q?k7I9gTKfeARFLavNJdpdaOpx5AMe0ggqBBidZFwuK3s4J68b5qLJID91HAEt?=
 =?us-ascii?Q?CKXSMm8U8RJ2cJFBT4FSCAr7+0/mrPQO+b7xY44rVFV1IiT5OHSs/oT1Q29h?=
 =?us-ascii?Q?4qmTe3Bj2ZJAHKfLCODfO66/NPt8pt9tK9ZnstuDvQo6d+QxCe1bQecFwclR?=
 =?us-ascii?Q?/GJc5AFy8MuNhqdI4IOA5vgu7zDWWlByPbQZI0bDwcAjEHzpWWAM5Q5SBer7?=
 =?us-ascii?Q?7nrHkdebIbfvoBA9ct8cRQEoLQx2vzZgOiMt+SC7KEcNnKqd3p8+vEWvnogz?=
 =?us-ascii?Q?u0tTlci/vM8ZDHZh6I9LtuRhnHpG2C5JP/iR3CcdweFZUGGAsO6WuLS/y0xm?=
 =?us-ascii?Q?Inxao2knNgy9mfsYiwxb6M8iJStQRMJ143XSTHL9c781TNxGCCuR+PWLfm1W?=
 =?us-ascii?Q?om+suPlih6VeTSCtBLyQhK+2Ae3P1itPJEX0tdcLJngtLk6SLqDkIhjBF21Q?=
 =?us-ascii?Q?QRdHmxeB7Co6AO3XkX7ahmmTnyf6jg3EHTxsXIj/vEdshRMfaJvQGljvWPM0?=
 =?us-ascii?Q?mjZPgLs14Hnqp78ri0kCV3vYCfh+URMBkvTvdSmy54f8d5uTeh92IuHQsYvF?=
 =?us-ascii?Q?Izd5TKfhKrzunOBKNcHDM8bhltGk8dO79MeqoROVAq+NGGu5MbLprPXoBnQV?=
 =?us-ascii?Q?8GNy5f6FWFM9wQW5GwALFvE5hl2kqN3JaoYjmyVYbLzRO1JLVR6+ITVDXZSW?=
 =?us-ascii?Q?P6l/NejM6REI+Bp08yhXqYR+RfDryIEbxVWAByxNRbKMNGPeMBB8dzW1y8f/?=
 =?us-ascii?Q?Vqmp1n7K2xhCiDjkWeSfEWN56iOXJybQiBojapyDRXwv7G9BbjjxCtElYDMC?=
 =?us-ascii?Q?kPHd45jr+gZHK6hogFD9r/yN4tQ5Gz5CzHRwRdhOoqd+YrT2Xt91BpQMWoJh?=
 =?us-ascii?Q?kLlGZfPhMbwF2ZeNd3d1XuP6enue3XEoYT1TUskBHVLka7UMO4eu4ZO8uRyi?=
 =?us-ascii?Q?i/og+mPTSJdtxpY6Un+bktmTXy6CqHuEPHq4Bf5jFp5ILSofywnbG10DgGM/?=
 =?us-ascii?Q?8reEPoJIU5c8I2LrI0ooDMuW0uXbtGQw2njY5eJQnZhlwu1UOidWW+TQC6dO?=
 =?us-ascii?Q?Ovs+8ydTnZc5JkCFtFzmPbivJL7niRtlBNzap+THZ0dvI+82lU2LS3x7/ZFn?=
 =?us-ascii?Q?QeMs6G8oMqoASCyewZ1r61M868nqRpy+cLQTwhM/EA0dSmAgiJyhTn9hIhZT?=
 =?us-ascii?Q?nzOKi2l4wGmza4ppjy7DnZSQEq8rNzq3fz3hgRxyH2dhkh8U2d1rdbxRF8Ds?=
 =?us-ascii?Q?9TqFP/VLb3RvDKsZxN+j051dT3B/yxFGzYm79UHSDmEEJYTtZThN02OJPxd2?=
 =?us-ascii?Q?oo5FSsGQo5ECDwOS+aH8EYN7WjGcQrjkrkwdTQx0npTc+A3bY4ChHYxeLtM8?=
 =?us-ascii?Q?aXRzFxD96y55LHXVacO0Rk4TvSX5STnwMVRTlwpHk1gRvr1EHGys3T/8wtf/?=
 =?us-ascii?Q?F6j9+4Z9UUJqrnEvqtRLLxxxqy/BH+wg9O2XGOojksnZE/whRCYx0LAJgDw9?=
 =?us-ascii?Q?lUz8zRKe1bMLd9LWzuesco0TEUuy+t7H73gxa6/YVGIxktHkPIzjM51MooEZ?=
 =?us-ascii?Q?6w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b70e58c-c6bf-44e5-7263-08db81e86529
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2023 08:25:33.2127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R8SEv33TgZa9jLDixu5SB8VICPtICuJPru3sakQI6IufE37uLy7lRhHQXdMYAelJuymlnPGd0el8Dn/QegyKvlR8aMeSjzyC152VdPfMSGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8824
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Jul 2023 08:26:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12301

Hi Pavel,

Thanks for your feedback.

> From: Pavel Machek <pavel@denx.de>
> Subject: Re: [PATCH 5.10.y-cip 0/5] Add SDHI support to the Renesas
> RZ/V2M
>=20
> Hi!
>=20
> > > Fabrizio Castro (4):
> > >   dt-bindings: mmc: renesas,sdhi: Document RZ/V2M support
> > >   mmc: renesas_sdhi: Add RZ/V2M compatible string
> > >   arm64: dts: renesas: r9a09g011: Add eMMC and SDHI support
> > >   arm64: dts: renesas: rzv2mevk2: Add uSD card and eMMC support
> > >
> > > Phil Edworthy (1):
> > >   clk: renesas: r9a09g011: Add SDHI/eMMC clock and reset entries
> > >
> >
> > I reviewed the patch and found no issues.
> > I can apply, if there are no comments and issues.
> >
> > Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-
> /pipelines/919945015
> > Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
>=20
> There's an extra empty line in 2/5, but that's too minor detail to be
> worth fixing.
>=20
> Reviewed-by: Pavel Machek <pavel@denx.de>
>=20
> We'll need similar series for 6.1, AFAICT.

Yes, I will send a similar series for 6.1 soon.

Cheers,
Fab

>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

