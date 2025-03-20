Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D924AC28B30
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 10:26:27 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.43])
 by mx.groups.io with SMTP id smtpd.web10.4014.1742466380004339069
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Mar 2025 03:26:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=nGqpqEVV;
 spf=pass (domain: renesas.com, ip: 52.101.125.43, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NOgk4oO8Sw8Uf5zHIqv8jgSADtDNgCwnf1ZKKHGB9Wy9DgCLMxJy8A9H9xJAauMZT+1xg1CVdr8tpDJ9OocFbKri6LC+JBmFys7fa4Foff45945EjJRNaNVDNSjEcGNmF6FxqNgkfmHrzPS/reJRsHZSq+T/mDi3lZECDM3LVsRGuIkJI8RpL7LGo39Sz+31AT+7zSRKMWxva3yxvh91BY/mn56zGCUOOWKNlv99KUQmme7MAdzVIIbEAfSxmhMQbjrycmS7PZArPDLQ5E/4QlHq0Lq69jBMXMf+lOn8j39EvA67LQjA4Uh+hcBjIohS9g1RMHD+i8TcS+1eJgFDwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfVVN/xPqDEzHaKskNfk/JEDy8WT9U+zgHxyOvYv5MU=;
 b=QAD7E/aSfpp1roPvBpiDbbHcTn29Bi2ubVKxWR/kouDCb53UEtnJmXNP6a8xGJhodM0wu2ra/d0VDhlmf6M+MAhAVoDj+7qC1O08wWP0tln7cfilab91pHzrIV8hOWNwouZo5dc64iM19UyA9NVFKwndBJq+j1/07gVlPk248BqOfBPGW9qg0F/xvDWEhwj0K83pUSm+OWGURTW6yWGiTXDRZ3nmLLRLBVeRzVF8qeVvBczDxrzQKnTAypE+IFI6gzdDtVQ9P4sKk3j1hlOGObaWdn/bLN82hDsyLoAkBm/MXdXhL6WBn3Cs1uVjuylN6HkvyDrcHVs2DUrBks/qkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfVVN/xPqDEzHaKskNfk/JEDy8WT9U+zgHxyOvYv5MU=;
 b=nGqpqEVVWJiArjNA3QLudCTNkNcbhIOQTs5Ckr2vIGBBEnKxLB91gEUJaYIitJKpaJ9n73JKX/zlr5t7b+Vi0Xa2pVLrw7X16HqWp967JF68kf42OsQPuX2nwx1N27kyHi7N2lG6WeGb47Xj0AQpLnO9Xd8qZls7pJ37AmqnLYA=
Received: from OS3PR01MB5896.jpnprd01.prod.outlook.com (2603:1096:604:c6::8)
 by OS3PR01MB8260.jpnprd01.prod.outlook.com (2603:1096:604:1bf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 10:26:14 +0000
Received: from OS3PR01MB5896.jpnprd01.prod.outlook.com
 ([fe80::1b62:57c6:c2cf:641b]) by OS3PR01MB5896.jpnprd01.prod.outlook.com
 ([fe80::1b62:57c6:c2cf:641b%5]) with mapi id 15.20.8534.031; Thu, 20 Mar 2025
 10:26:14 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Tommaso
 Merciai <tommaso.merciai.xr@bp.renesas.com>
CC: Pavel Machek <pavel@denx.de>, Nobuhiro Iwamatsu
	<nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Tommaso
 Merciai <tomm.merciai@gmail.com>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip v2 00/12] serial: sh-sci: Add support
 for RZ/G3E serial driver
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip v2 00/12] serial: sh-sci: Add support
 for RZ/G3E serial driver
Thread-Index: AQHbmLgPvWcvHOKNoUGQBFONmbNOhbN6Qe7qgAAA/ICAAYoEgIAABmlg
Date: Thu, 20 Mar 2025 10:26:14 +0000
Message-ID: 
 <OS3PR01MB5896D57F73D7B6952E9A08E4B7D82@OS3PR01MB5896.jpnprd01.prod.outlook.com>
References: <20250319101629.2407727-1-tommaso.merciai.xr@bp.renesas.com>
 <182E2D5440856AF6.20726@lists.cip-project.org> <Z9qcRBPx38dI4QtV@duo.ucw.cz>
 <Z9qdLZ6MSVEaMpj0@tom-desktop> <Z9vns4WDhX0uvZ2N@duo.ucw.cz>
In-Reply-To: <Z9vns4WDhX0uvZ2N@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB5896:EE_|OS3PR01MB8260:EE_
x-ms-office365-filtering-correlation-id: 7e4e9ffb-2d2d-459b-71bc-08dd6799a4a4
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?Windows-1252?Q?ieZC1NJPGFa6wZWoER2D/D2m7TRzV/w8x3pGzqCxLik44BtbF4kG3OuG?=
 =?Windows-1252?Q?I8St0o9vuiK4niq3IG8eQEIjQONfwSMRhQ33lEGhPv6DyY1A2CIc9okW?=
 =?Windows-1252?Q?UtZNhKUiLuv9npxO7AfzjnIC1Yqx6F/R209lIEuCLvbMkJtv1JXLcNI1?=
 =?Windows-1252?Q?gaHmKiPBYAUhaNaQATLsqVh4EZjZEq8cjd1rNO6PRQI6nID8Bd2IoTfD?=
 =?Windows-1252?Q?rMH5Ndw3cvr01ONIqlWKNBD4gUfUki5+jgW5kd+0eZ3nmp/waS+Y8lfd?=
 =?Windows-1252?Q?Rl9RNweSNgB7wTUNUvc+AjFhRK8Lu4B9qLMReEgo87BvESvDZw72o9J9?=
 =?Windows-1252?Q?6ML6D1hrpLTj/j/jedHWUQ44NfBpHp8fi7lrjRyL6TUCgxzWHaFVeEDu?=
 =?Windows-1252?Q?Vn9SgIu7jNMMW52E5P2KyAQL8ST+sfgMsituAfmShcCNbRg+ZQyqm5aJ?=
 =?Windows-1252?Q?WittmWniORKf6Zvs4WqZytGcBCZqXlnTRRZAlIMaZ6zRBH+Fg7DS5RQq?=
 =?Windows-1252?Q?0a9xUiMj3GQUPhgnOjBA7wPA9SUBr9mHz21Z7Q+wjx42+M5SAXWRqgGm?=
 =?Windows-1252?Q?uCK0YWXWG3QI2UEh5r8BJJOPGlQo93YUPc1nrfyhLIMSXQiZRtPIwlbM?=
 =?Windows-1252?Q?B077BR2IaxcyuVZ5jJGnj8yKY9DQP7GwOO7/djqPypF5bk1QBgpZ5FNV?=
 =?Windows-1252?Q?F0t4i3hgKjmp8acMYUicync6x0IlqNVSEsJQf4tGkJE8J+TyEif9BdtD?=
 =?Windows-1252?Q?C8Nay3d5aCgI2uFcNeFSDMH0IkG6fg+o8B8pBvFc2aUnnd4Y90MgR7Yk?=
 =?Windows-1252?Q?l28qhUQpCZ57hNlWQBXuk62WPxc9w1K1xPoeUQ/Xx+wYy4EyN73zR904?=
 =?Windows-1252?Q?lEeQMABkE+hKqQifQFTzYs+FADef7Z+9T5xwBsxTdSSLQZmE70uSNtkP?=
 =?Windows-1252?Q?IrLjK8Pm6z0/ptflSmvEbwsVLxoMo2roYWZatBiHNCvuILxCFDyQ+Zdw?=
 =?Windows-1252?Q?l3MVXKWG4V/ytXtC47tfWbUUfI+9WKEDnH8qzd+VHceCHnkEtmRsDzeG?=
 =?Windows-1252?Q?jvrpkHbXQ38WymytFwascYuL5E4+PyokAbCPCoRve4fuQ1FSV7pGCOzt?=
 =?Windows-1252?Q?Rw0pp4ht3zuNDUm2MMcFqjyV7QpJ77qgC+2aNjxFYc/8ZmCjJHvR6euj?=
 =?Windows-1252?Q?ZdQ+LL+AtVnRT58zhhh3vWsQSQXBw7T6Dkx7DdJEseOFsjBwdQ2If4/V?=
 =?Windows-1252?Q?4oimv67PDv8rWRQmhSE4l3h2xaU2/SMYMPXujIGSs/co3puwEvjmYluC?=
 =?Windows-1252?Q?sn6woxhROBYOdzB9lkPRggCtRn5JjaDAozyQsJ1Wh8OBBAZuKhMCWAy7?=
 =?Windows-1252?Q?Epyal43dbQeFyaUsl1xlQ0atcEbkRYAC31/OA9bn3P7IiNdFVaIKZS/U?=
 =?Windows-1252?Q?VHsBpZUkjEardHQG5mVrSWuAA+DEjajYTuBqrvntHXyjMdLDTXynJrk8?=
 =?Windows-1252?Q?nUigR/IhyleGv0e/b0w8yfAUqLU4faBsmayPg/RkYVfawDmqoGI=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB5896.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?h16aLo9m4N76KRa/JYLctHDdYkYgjCoRv+NRUiBxkUDKgQs7YniuL2i8?=
 =?Windows-1252?Q?Prd9K8t/aE2sJRo9s8T5EV1XtlcFKyXnh7c8UDJbp7OPCO4xXwzRpb3X?=
 =?Windows-1252?Q?bHtTz6QIAakJSsiQuprqdu90iM6g+YTvtClwCDwnjob3eLfBKGFAt25b?=
 =?Windows-1252?Q?TIkh9/zWQxV8NqtgkEIl3jxrsZnAlivuZH69OdTkl1Yjmzi5aCRfOw7n?=
 =?Windows-1252?Q?xi8Lde9F5uqFZQ+Pt8Tez10f/AFzC7aw0DozsZQxrgkxh6QOQPTrz456?=
 =?Windows-1252?Q?QYDGWHyjUbPnKF12dImkTu1QEew2P+RRVtdK38kws/VssERzHpTqtC8h?=
 =?Windows-1252?Q?GBvyhN4Vfmv426VOUhe4BM/FH+VXnFeh/ZPBp/u3bSA6Dp/ObLS3Ym+X?=
 =?Windows-1252?Q?EASJ5FiUQu/BpgBDhxox+wYp9qC3QySRx1ogVk7w8avZPYx/RGJchSTz?=
 =?Windows-1252?Q?/YLtDC+rdAqRCDbzP/xXl9Bb7N1GW0gcYdLSUjC/OAyuN24pEwzcNhlH?=
 =?Windows-1252?Q?wuzn00fs6eNBvrX9zQ7uVFPqJRxI447vyI85nsT1Ph12P+/jS8jsY0JD?=
 =?Windows-1252?Q?I5GF+xW9bMqSIKhXn5PRfXYpzgrCbWcwCIStwzPbhumpeCB+FUfnZLww?=
 =?Windows-1252?Q?kbYTeM9Uqf9z4AgkFUYPSYN2HghX277N7jCrfzQ9BE9gwJVOIrRN+3GG?=
 =?Windows-1252?Q?tgabW7N35xAok1Z5u/r9ks6ZQhgJPXtRtpkZwhTR20v7e3d71fB4XYAj?=
 =?Windows-1252?Q?dbQviS3OgGwaMZCtPdUPCJKhMGOUoNeGdN3YRh/zdmAlOTt2mrUyeM4v?=
 =?Windows-1252?Q?wxpg5WgkpjRNggHkjALFA19a03Bm6I2bqiVzOGl6KSX/qzDRT8Zhm7LR?=
 =?Windows-1252?Q?e0I4NuOjgfZQ3XNBVTl6BqNzfpcUaJeiL5+svnpURDo80hKku1eAfxTu?=
 =?Windows-1252?Q?ba4YTV8z5woxdtf9mkKtZv1JyeKGHn0U4LM6CzCe5LboZwHbhmKqeHZd?=
 =?Windows-1252?Q?sSltE9ZFjI38uEWypV3H/mN1HbXq/Q3T8mPZTHx1SB9sX+YebjrbuWDj?=
 =?Windows-1252?Q?h4JErQ2oS/Udm+XS39gGLv6H2AFSlWfDMWjs5buS1R2U7On2iWDKYN0p?=
 =?Windows-1252?Q?NVkrNT51l9o2qIvpP1tesLs5r/JTz8hARPtqEKcm2qYfMw8HmnP/IOE8?=
 =?Windows-1252?Q?LJns6Cofz1gFGdzbBeUyipREFjyF/adRsXjds8MeaQOpsovaC6FDozap?=
 =?Windows-1252?Q?4klc5r8PWPMrKR1PVf5ZMLs7n5b/DCUPiPbEgT9eGSjOwH5hJ9Wytu83?=
 =?Windows-1252?Q?dbdv0gTPn5Ut9MN1QJHTD1aGYkna/+4Xu7xiPBHtUWKmxGqkpzzmLJA5?=
 =?Windows-1252?Q?GDrpoR3nbI6EH/ixEirInNT6FJwO7qu9X1cVln5tg+m2lwxYL0Ew1Eqe?=
 =?Windows-1252?Q?1pLp80H4OgFi2lDGe8QK+8q1fPBlnp+B9Vimc0Zj6nb9DoUG0n9Pk8qf?=
 =?Windows-1252?Q?6SGY2KoDtnqHK5PMk8i4jJ6ZPqzzyO7E+IUJBoddppLwojcm+M5Abi99?=
 =?Windows-1252?Q?jxIFL4MjfbFLOTH2bHK6lKaZxBpqUqWAZCTxi0GcrTS7e//wTxaTR2ud?=
 =?Windows-1252?Q?LWqrAAoLwQQ1m6JK9APO4j2aoTYxDicPQ27vl/Lk9bp2cXNuZ9gZEUx+?=
 =?Windows-1252?Q?FV1wF31T5S/fxoMNUWqTnOdBx5jIManEBYsSXDDU4LLB0GY9SHY+7Q?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB5896.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4e9ffb-2d2d-459b-71bc-08dd6799a4a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 10:26:14.6040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IgTHijMeRt91LGmjAa19LGAoX9GfOJz/YHvHE7nG7sKFIJKOoBnAJQ2HlXBYfB4Nso2GvcCNJVMHGtEYLsaamMoH7UK+oIbYrfdcRd7Mjzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8260
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Mar 2025 10:26:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18292

Hi Pavel,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: 20 March 2025 10:02
>=20
> Hi!
>=20
> > Yup sorry, I forgot to update the cover letter :'(
> > Basically on v1 I missed my SOB.
>=20
> No problem.
>=20
> For some reason, your patches don't seem to hit the cip-dev mailing
> list (?).

If it helps, I got the patches emailed via the list and they are in the onl=
ine archives:
https://lore.kernel.org/cip-dev/

Kind regards, Chris

>=20
> It passed the testing so I applied the series.
>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

