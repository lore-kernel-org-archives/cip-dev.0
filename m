Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB820CFA775
	for <webhook@archiver.kernel.org>; Fri,  4 Oct 2024 13:48:54 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.65])
 by mx.groups.io with SMTP id smtpd.web11.22668.1728049730780886084
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Oct 2024 06:48:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=s0eos49S;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.65, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQ4ahZw5K6jwlP86+gzuSn/yF73oC/DXrxItyHweARRtcYBqpGIxRyAdPC8bi7pjr7t/LPm3kSOXVYPnHpZkfeb9lBL/31lQgsPhzNsFKHa8JIJ+GNQ5mBegD8T8MEjF/5gAALyxdliwoVZZvPJGFhsEX/AK3U/1EJm5haogEZw1k/xRv01h7jxXRu2DKChdn55xjsTG/oeEtBC1SCFqz0sLwucx1DMaBlCXD8nKaPQQjTNLNt/1QttsS42UTeFkfXrSCl85TJCX+UfshRlfT5yIUbT/7hvf8uSsWUw/1P2SIbSfzscjx/gdskd/bJrjOP7N0saUTrB2/pckvDxOPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00wjWXmOzH4nw4DB8I87LMRq8dDmVwhKZ1quA0aP3lY=;
 b=dB7LBCadm4oR/EaUEFiU4YkfG3Oqr8W4hiuPU1b2ifJ78E4WHoINNt6jQlxDcnXg0ZKgCCYb9nvoHgwyswVsZUzog52BNamd35FtLMd9NQI1GVfMgyXtwtXrA+5O35F2dlPjijg16iKewI0Do/Dp2GNSVEXmQ0TfshqkUUB8tyMWNc3UNiZx6JoURoeDjhNlf8p+iZR3CTkpQTaox9/6hCUdj81ZIOAnvYrELY4yqbimdVsz+Hi+Jwqa11VxLhTwc0XBumDZc8zbZ6zRKL5w3UrZlm9XUxDyUUh+nB+6xThUwpZiX0zTidbBgrKuAGKLg/Sf/UwC8Qf4Knc/dLZhwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00wjWXmOzH4nw4DB8I87LMRq8dDmVwhKZ1quA0aP3lY=;
 b=s0eos49SVNJllDM5BnVwoZHMSJK+X5fFBhFatj5jpS9RFxfpj6BluQuYxRIRq8UDeU+9ryYDbMty8VeqYeTxJ3hZcL5A4+b7gCrCCAiHXzHSceo6GfiCSTIUTmW/bQ8UpPDXwbEKk3rECHJVWRE9AqyjR9wFEzrmNqdYt7BzjBQ=
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com (2603:1096:400:3c0::7)
 by OSCPR01MB13009.jpnprd01.prod.outlook.com (2603:1096:604:332::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 13:48:46 +0000
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::7497:30af:3081:1479]) by TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::7497:30af:3081:1479%7]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 13:48:46 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 0/3] Add HDMI audio support**
Thread-Topic: [PATCH 5.10.y-cip 0/3] Add HDMI audio support**
Thread-Index: AQHbFltI35KKstuKjkOO28vBNWRYXbJ2ii0Q
Date: Fri, 4 Oct 2024 13:48:46 +0000
Message-ID: 
 <TYCPR01MB11332025EC532A35647593C3B86722@TYCPR01MB11332.jpnprd01.prod.outlook.com>
References: <20241004102521.73256-1-biju.das.jz@bp.renesas.com>
 <Zv/jXSbn3G3oEXSn@duo.ucw.cz>
In-Reply-To: <Zv/jXSbn3G3oEXSn@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11332:EE_|OSCPR01MB13009:EE_
x-ms-office365-filtering-correlation-id: 96d49dbf-4d3d-404d-cfe2-08dce47b4498
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?qsAlxSpEEhivi5m3CjC0+pnJ0ldxc2MI0+kfhosPtnExbsiJruIUpZ2UjLCF?=
 =?us-ascii?Q?H+QV72yisPhbLbQgfxNfpnrHPitKfpKE/+AK3xLrsJa4GcKevyy3ZMP8wcTJ?=
 =?us-ascii?Q?y6+zatlASYXrIyQAYiwE6qJZBeF/CvZtz63GVAfNUFF7BhDRxFyADVhku1Kq?=
 =?us-ascii?Q?VXpFcBUiVny8kPx9LFY9RlVZBQRAvhK4BKCV5dsxN2d8jV9kwZWQl3m4GbDA?=
 =?us-ascii?Q?b3Irjuf37Grjzla9vdyh9BCCthMZgaM5/RHV5+HFVIGqFhn20W9x3W77xvWp?=
 =?us-ascii?Q?JYxXkfW9UcPtW1ew3ucxWokiCDXlDfoO/+IanuylxmkJJhqQGlXLF06+ozWN?=
 =?us-ascii?Q?wVDt6RzAxHbGvzqWdTPlWBW724tJTj97gBWDqRFl4HYLCemtAwBQVxw3RUSB?=
 =?us-ascii?Q?QHWWordexXdIU0G7erdknxWxIeIMafnSa/QNH2GfAWxje0sm2E32kHKvf7Zc?=
 =?us-ascii?Q?yTZK8wQbtgOTB9gB17AYdKyPTSeekLF2HjnxBs0U5qDZZu6+wo1tiRfetiYl?=
 =?us-ascii?Q?BB8/xJ7bMiwbTQP0flCgOIC34W7gIWToIiNrtx7OdwEZgiFFWOLwgABmHbpB?=
 =?us-ascii?Q?QiIoItgHxwfwweQWntW9q9bSX13GKvMFfBV4/wEojySeN6BnRq0yJmMtLGPC?=
 =?us-ascii?Q?FE86gNV7CFBAkXD1ngu28Kut0jBJpQM9WRBQoNJKjk/uH293ZvDcJ6ovzTD/?=
 =?us-ascii?Q?T+2YM2cLduButtFn+DiJali+XTKfx4EOySz1poOkHiYtaQjSoNw5jqulGomt?=
 =?us-ascii?Q?AMvgV5V4/SF5Ykx5k9xawQ4PClkArSOPVapRHHD4eMC6T5lU1flDNrHzpF6V?=
 =?us-ascii?Q?WTCGK7/+cBnnJM4a/NfOsJtop49KwRRD3SdALwwxPSpYPl7ohgoKQKgC9MkT?=
 =?us-ascii?Q?puMsj35GqJw9mMO1EOGUQ7HMuM0b4+gcoxe6SGzDIyH+/L2x/WMC7+HAZMPz?=
 =?us-ascii?Q?zoAZYQTBw5LI4UzUztqz79O7C7KLAoDxVJfE2YtWuAzJnYx5fnjT7sAwIZRZ?=
 =?us-ascii?Q?4Q3AoI/gKE/sRWPU5LmnfmW5sdZCmicV2pX/jQaVfwsyrSWC5HJN2YIw2QMq?=
 =?us-ascii?Q?YWm3XFb7RTtKCvwWTmYlXDtURtZDiGIZ5bkeqEn7jnDgBkj95OT6nrjMfhxN?=
 =?us-ascii?Q?WUfsVyMX610m+QASwIdWZASpZ0aGdbTUSXIhBpBhKEVNyAIZL27G+MeTBzHC?=
 =?us-ascii?Q?x4e2w/0rBxTtLFgcSvPs8I0PLjiDosokfh08gNpZKAcMtp4x64Mp30OXOVpa?=
 =?us-ascii?Q?WmzusRC/h21a2JneT5mCVR8oobfzlp0wd4dsL66Jtz3i2ZmSu+jDRyta9gYl?=
 =?us-ascii?Q?MwmFrfC9fO1vU/ukdLmeKFhetNdNjs0BON1BfK3UbHlvYw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11332.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?fcI79qEKN6t68aky/DtKd1QDnMC9JSv8+2QNTc4KNBBCUb70vSSJjhQKwxS6?=
 =?us-ascii?Q?KF/bPasg3UQ3SaHp9+oUcvZBo4BieiLhU8d6LQIsfTvoZX3ps+MBMLvhtrnt?=
 =?us-ascii?Q?ID8MUWPJbZTanZNnaQjHnNaHcUCt94eCEJ2Eqq16HrjQJgv2Y5ew/1EbTH5U?=
 =?us-ascii?Q?tTjj3590HGtIh6FJ1Un1PgQjz+2ZG1hEm8dBFJczudhiRmNdd5kzkQ+bPVvp?=
 =?us-ascii?Q?GfKYfQAB1uTZyhMEshJ/Bet98+pU5mMrp0ox2o4Ydg3hWI9xhtKAEdaGI17F?=
 =?us-ascii?Q?4+EXVzswc/NJxPdasPQVSVb/KHip130WoaT4LwztZK2oHEZIwbEo5c5Rgwkx?=
 =?us-ascii?Q?xMKknnAszohjOucY6dgDiRCdsN/7v9jTzsyJ3nuDgdNg0RX3sH1bAsp0+Twc?=
 =?us-ascii?Q?EBkaxfzBGs0XaMj3i+hIF9HFkaGl7k2Ai1yWJyMC/VQ+bOQiL6SUWZZA8tCi?=
 =?us-ascii?Q?RinOnE7DhLY4dPJ2Gov72Zp0buhT6r8CmXkeUpFIL5QlQSP4fbfpR1zAnTDR?=
 =?us-ascii?Q?sUsUVtsHPxiUyBMKn3IpzQXlY929k+KccJXOfB9/O7CavTnLZ7DmBoCImEEh?=
 =?us-ascii?Q?vFsGDqN8w1cUaqciu0xMp6ys8OcN2+bU31fOxtOUjDTvcjTu04bl/MerZRut?=
 =?us-ascii?Q?xN0r/175UDSXmsebUuVsx4M8+uuQLuN8Avf3MIYdQP1Ci0ChSPQPOvNzSemR?=
 =?us-ascii?Q?jCKXhBN4KmI1eqH1CS2L1fd87prtUGFYNy+2p1SLx79BeYnqN+Tp0ubC9O1H?=
 =?us-ascii?Q?2OS3blO19Q7Irxcg8nTRn2K0mh3oGKXM3foG2pBERKR8b8f2DVCINIHoeMgP?=
 =?us-ascii?Q?x60oZsErmmK29KzD0lNEHwMrYsoXJtJsV+05njpWglfCZZFqsRv0FU7WxXLT?=
 =?us-ascii?Q?RCmVoF4HR9if0x/FoPCOFoZMHq4stuh5ZNAALtOjYjl/H7weC/I4w7geiIwH?=
 =?us-ascii?Q?6nN2Jflu39NaJxOe1G58StWt/28LWFTbWEb29jeWVSz3dWjo7k6SsissrwY1?=
 =?us-ascii?Q?mGyzgKRLM4sreSOgxi5+v18M4cf7bo3lFzr7LouO0AtXzT7ATSvi+QPZyN0r?=
 =?us-ascii?Q?T5n3mxxxLE8LJ88zTTzmFOMLBZNHXYLE5m38Ajl43jgzkwG84E3+Vh/oo8RB?=
 =?us-ascii?Q?6OiIj6rxD81ts5bYn3zCQRI54URlH7ty4MWEupVjHxZGA+N0VvGXwfQHh+AF?=
 =?us-ascii?Q?JMDnXGkM0vztsGbzKfD1kgmJUMctT+GOZwNo67WDXAiPc9sfvgRQOPSdZPRW?=
 =?us-ascii?Q?SwtxdeKRrRnh+FDLMN+dNld4ruQBC5eGxtCnnS2AfeqC7F2YrWmi80J/biHC?=
 =?us-ascii?Q?KJLQQ5LjEbejqRJpM1V03Qnqbb2WkwednCVN7PASG0+/uadarz3S3PsaltGv?=
 =?us-ascii?Q?c7lDSPpS8rRWfTutKgF07IeaSgtrv+8B+QkBKuh93tyzNVjZ0rtOY/cIcB0X?=
 =?us-ascii?Q?yiTfzhIw7Y9J3WUavIv8BQBVKSzoW4PTJ8/vbl9hZQMM3J6JSgD+M8uBK7ZZ?=
 =?us-ascii?Q?psKPMQeiBLyfJTgsLiAHRLTeyI7r0TGb8z3jn5cmfCmdM9AxpVpLpyEsipYj?=
 =?us-ascii?Q?3lOoMZf59pZtV8nO2zVLRl5e4XSgqK2AkyEWZtxiJ/4oQ+niVu9Xk/YID7eA?=
 =?us-ascii?Q?tw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11332.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d49dbf-4d3d-404d-cfe2-08dce47b4498
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 13:48:46.2131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VnD/NetNX/KlCr47mB4G7mUcQt9X+Ac+wpE953kmTBahnLnDV4ZGBCZf4BePN5LWkGLGWlXwl21RfiN6ZbMVhiaxpt+ZuSZImu+RsXlWHIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13009
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Oct 2024 13:48:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17004

Hi Pavel,

Thanks for the feedback.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Friday, October 4, 2024 1:45 PM
> Subject: Re: [PATCH 5.10.y-cip 0/3] Add HDMI audio support**
>=20
> Hi!
>=20
> > Add HDMI audio support for RZ/{G2L,G2L,V2L} SMARC EVKs All the patches
> > are cherry-picked from the mainline.
>=20
> I see "**" in the subject, so I'd expect to see "**" and some kind of not=
e here, but no.

Oops, somehow missed to remove that chars which generated by format-patch.

>=20
> This adds documentation for "port" property for renesas,rz-ssi. I assume =
the code is already in the .c
> file in 5.10, but was not documented for some reason?

Yes, That is correct.

Cheers,
Biju


