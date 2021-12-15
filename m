Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42807C433F5
	for <webhook@archiver.kernel.org>; Wed, 15 Dec 2021 10:31:46 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.113])
 by mx.groups.io with SMTP id smtpd.web10.38724.1639564304281573233
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Dec 2021 02:31:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=gR6P2DUQ;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.113,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ng6BwIivMvjqyai1or/wXFfuoFznXmZWzPWoYo2qjvua1vml6jgVbsI8W216sp9CUhSos73eSJIC/uhyBXia2h2d3ADM/Qbq/9UZNRTm/QWx5SNi85B3yJFrxeTqwFOmwC3xiNH/rZqoAwA9e3omWngpMm1p+/mlKqlT64Ggp27H68r97FLqI91xzeMRnSM8/DgqVhFF6c13jxPZazDraNwmIC0qQSun7T3DuLTc7F7yScBQjrlC+tmZliPDKHncJlqO2f27BFOTyRoRtfxUIxMqLH87wMoPSrjK7LEqmO+0fcxopqF41QwrMkYkDgaInBiZA60gv5ZwYhmJ5OKcLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Taw5PiOxDn7/HET1n8ksfJ9Gzzr55tunX6HXdM2xKCU=;
 b=THhldhG4bod06u/g4y4R4ZSDR4uDVWHXwYi6TTjtUwUijcVwUwMhAZF5xWvYR/oWkMQdfR2FpI+6UsNwBCNn2bPButvXo6xvIOk67ai2ekAslDcv/q97hZzLJ120LRmrCMkzAdCYhDgWLD0Wcy042shKkImjAW+9K5v4hlu3P9cyqxGuSYf50+ogVkyYBTOUXjwUK6oK4IvzsF94xEYXUKzGD1fR5Oe5bry2xR8HfHLjRU9QNUAc2LgM/JL26aOJG4QAfXtK4F8Gktjb5IGwWaS5GTfLoCRHAl1QCKB4LoG8tz7ytH+eL4TT288fph39zPQn0o0J+F7Wh3IUICXciw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Taw5PiOxDn7/HET1n8ksfJ9Gzzr55tunX6HXdM2xKCU=;
 b=gR6P2DUQg4vtkn1x0q68hoQQUPA9dHb2Fa6L+WJ1lVQPSjX0MimzffRLmpx+CGQEUZCXlvjNQi2bDHEybzUrG+gj4JaraPGzAAQqr2Jz3va8Vnh7B9vEH8zrTywJun9U6JXpHNcbeMjfkERVBOdxpu+dOZuyNJ6a35GnFVBdKgQ=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OS3PR01MB5800.jpnprd01.prod.outlook.com (2603:1096:604:b5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Wed, 15 Dec
 2021 10:31:40 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::1d3d:8c79:ad2c:62ae]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::1d3d:8c79:ad2c:62ae%8]) with mapi id 15.20.4778.018; Wed, 15 Dec 2021
 10:31:40 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>, Chris Paterson <Chris.Paterson2@renesas.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 0/7] Add binding and SoC identification for
 Renesas RZ/G2L SoC and Renesas RZ/G2L SMARC EVK
Thread-Topic: [PATCH 5.10.y-cip 0/7] Add binding and SoC identification for
 Renesas RZ/G2L SoC and Renesas RZ/G2L SMARC EVK
Thread-Index: AQHX8U0rW1E1893z9kK9QFiOnFoKGKwzVAKAgAAGhTA=
Date: Wed, 15 Dec 2021 10:31:40 +0000
Message-ID: 
 <OSZPR01MB70197955B16B1ED048518F1EAA769@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20211215004612.13289-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211215100537.GA18047@amd>
In-Reply-To: <20211215100537.GA18047@amd>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6635852f-7e9d-43db-1737-08d9bfb6150f
x-ms-traffictypediagnostic: OS3PR01MB5800:EE_
x-microsoft-antispam-prvs: 
 <OS3PR01MB580078A5F240F7C663AC5880AA769@OS3PR01MB5800.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 rITqpDLS3sWgCeKYaAPTXK7vEOTylilpDlVObZ2xz1JkkTGMOz2WC5+ttYLOOD+0Yw7e6W5nmCDkl1UJDp3FjPmTT7LiqXxMwHJSiRDB4yR0LwqgMPuV0/nOYKj7/JNRmILi+wn3LwEahZfi5m+7HS82cag3bnLavCxGbSK9I5WaVl5+ybst/oJy0ZHI+oX6HeEQKJTq1IvwEO0ca4CyXh8u8NQoZ0aYhtFS90HCIkRED9uJo5e5DtN9VF2jyQKLLw3L+1YE4aBhVdWF/EshBETpGTkfcRzwjT/xWnHe2UkdGKHgDWEpB5zRqaVQyj9nQbV4KHr5ubtjVX3/xvcXGX2f2mJ/mv5Bqt/V0m9mZ1f+X1lxEilAx7QaGkpdT/NYSIa9ZOIxgg5cnOeHNQUKpQLDl4kk1IB1uQidHeH47Xu9A4JJWJRRWS/tfYxiOZf5pgd5fgcJbJTV42gLuAsMxgDF1xdnZsTmTEPtWzsbHvmmUzuRW2yJGMz9AeGPFftS8Th5PJUwT4IM+8Ais52dPJPbiu+xIxQ+PZLwc2flZ4NR41BgM7d/UxQbRPSiqOLwbS1OdaQRK0hH+I1KwpMKNO84oiFFsZHl1AhA1dFKTMUbK9snPpGbHieuvjN0UhrKu5J0MWa9jPtKZJeyXvfP9a3/+l+rR6kvmEXOG62cZ6NHhd8z+NaLictQt4k6dK2OChLIUdzE0xAFo7th5Vrj21gjzpOyMCb1Wiyt7W4cpH3oJS/fecHBw/PcDbLibxzSfXAYcfJ/W+jCuhHbhatE4Vg+940t8wov9J6kTaR5D/U=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(86362001)(55016003)(9686003)(83380400001)(8936002)(5660300002)(66946007)(38100700002)(110136005)(4326008)(966005)(508600001)(52536014)(54906003)(64756008)(71200400001)(316002)(7696005)(38070700005)(2906002)(66556008)(122000001)(53546011)(6506007)(66476007)(66446008)(186003)(107886003)(76116006)(26005)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?JShdv2sxa350zOERgss6rgU1Y0pMrFskYmhDUAv8FVyXazg+t3XYEq8xDmEi?=
 =?us-ascii?Q?gliTQ1vxYIGgLTjvMUiXPHK6t7U7a7pCgH4OtSkzCO6F37KjDSEpDzyPhe2H?=
 =?us-ascii?Q?jBEogN9oJOvoOIqtmXaIXCdBETolhl6NKPZE545V1WyY1kunIiGp9RcMaja2?=
 =?us-ascii?Q?OkC38dN/66ojFEKpruoQ4iz97tqSL4D1VhgL68mVMtzn8t6A5Fm/v7O7FVtj?=
 =?us-ascii?Q?A+2p9oVmalKi8Cw8czt+xCfdDvkNnkiBc+O+/5c6mh4oj/BUC03kbVihhv+P?=
 =?us-ascii?Q?U+yu7S+0TROmELJK1U3lByGWvDnHHU57dUw4NA5mpykVtdLiLJCVer4WHFr3?=
 =?us-ascii?Q?oPqZ9fm26wl5SvNH5g4c+zqLnLW8AWFkUecvuhyaYf+lc3hWhmVKqMfGL2TM?=
 =?us-ascii?Q?MzaEB6K9O/bp8I5bOAok0zu8PtdYhYGXzKIqoBX+WifpAmpMRL0ru2TVshtg?=
 =?us-ascii?Q?kkuKZmw3MrntQJ+IvJE7yXyw/ZtAXolcOO+R97o5ENoXQdZGCG4cJtvyZuBP?=
 =?us-ascii?Q?6/9h8NTAAQqn/Iwp5d2NZD5soUxYrlxEwUVZMmIZET74yiMc1HVapSx7AjtC?=
 =?us-ascii?Q?xUW8sRs+IQ3/apyA/1p1p7lGoauGAA4b96zvVIyIb0HlEOxkQ4rge5KwHKUI?=
 =?us-ascii?Q?eGGyj66zeyEDPK0iTRpCY2S7gCDU3M19N5x5S3LfqWwX4QYKV3iJzyGP8Cdu?=
 =?us-ascii?Q?YYrcD0EN8cMkztNB0o7W+Lu1EWXUL5NsIfcs9oeUglLAkHKHv8w/2PKMs4ed?=
 =?us-ascii?Q?E+qsx5lf3aSyThNkt1W4S54+iYx7wtlLfxWznnlb28BGLMqvUfrC8QSLjX7U?=
 =?us-ascii?Q?qGRnIWqQpNz6l3WFNxpTonO1YhfyDfbzUr3Xr2pwNOjdbjZmVz6o6xHABHLo?=
 =?us-ascii?Q?oB6Pumqbe4FXos/3diVkleEJpE768E+Xj/82sCCLJHMNFaz6VJeAmY2GoeZ1?=
 =?us-ascii?Q?PlSioshkzdS9Rc053yHDNq3kGVnURHhemf15dfy+nHlBohwhG4iFdSqiri9O?=
 =?us-ascii?Q?RJVVetRSL0RTiyEWpjAYzkCGAL94IU9Pbjp3b2jRLVmugxchxaRmFcR/iRq+?=
 =?us-ascii?Q?+PLpO2phAkNQ30RMjUGmL5OvBe5op1ITF30W148d1by6B1KDWUSCJtIMdF+E?=
 =?us-ascii?Q?CYzi+8PRdFCXuY+99w8lrAP+oXtGML1yFZQ+1i7jp9MBa/1viKYiAy1B174C?=
 =?us-ascii?Q?dr99awJryEG1JX3oXbVWA/58QxtwdcY320LCfFdpzgQN1i98LInjnaznbMke?=
 =?us-ascii?Q?+hfEIzJgoD0LRIFP+m/uRu6pQ4rZrqSBVoDMbYeEpqHFts0fS+rTwxqjUaoK?=
 =?us-ascii?Q?Lrpwf0tv20OhujUMmmSqYnkky2SyJrNa3zngfVDHCF1GYKAJZ6jLqq6wUxYR?=
 =?us-ascii?Q?Rbph007jpo5ssrIo1NiyfccxOHzK+J6SYk5rNo/TuwqSiN9B2Y7JZYwWC87Q?=
 =?us-ascii?Q?+8Z0aMwmhyWEtzc+ND12JosN2ON3nm5re+eUuaST0HN18wrpysRj5esN+t3m?=
 =?us-ascii?Q?ccEI/8BNTzFFoqyNBSsopWgJU4ne4vAMN7cObLWHVDrgR5+6dI9/Y6Jh5Wv2?=
 =?us-ascii?Q?ZmqDlgHz9wvi/RCN/2DsDvro0icvsMxx9Sej2qSi/c19NHoW+2fKlcq3hcGa?=
 =?us-ascii?Q?MnTtFrKN4N30J4+RBwL+mNsluKgwKoG6rBGfWdd40/YuAanVPBlNUEwPTrQY?=
 =?us-ascii?Q?L+8QKu7zIoZ9gEIKhhK23qAjOmEW/6v4XGTnze8Zczio6vzZBTDRyKaJbsHY?=
 =?us-ascii?Q?MsLVAlYc8g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6635852f-7e9d-43db-1737-08d9bfb6150f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2021 10:31:40.6854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 OFWc9zpLaa+QGWl3sKphhVdVSm56piaStS/cxnIwXqvmcM3fzK1g8OL9M3bD5NJPf5kNhIEoTZAbs97GcP6iJQw+vnb0YrZlm1oObfFbXODtVveRIVNms38QmbCbjqGX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5800
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Dec 2021 10:31:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7109

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 15 December 2021 10:06
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip 0/7] Add binding and SoC identification fo=
r Renesas RZ/G2L SoC and
> Renesas RZ/G2L SMARC EVK
>=20
> Hi!
>=20
> > This patch series adds initial support for Renesas RZ/G2L SoC [0] and
> > Renesas RZ/G2L SMARC EVK [1].
> >
> > The RZ/G2L microprocessor includes a Cortex-A55 (1.2 GHz) CPU, 16-bit
> > DDR3L/DDR4 interface, 3D graphics engine with Arm Mali-G31 and video
> > codec (H.264). It also has many interfaces such as camera input,
> > display output, USB 2.0, and Gbit-Ether, making it ideal for
> > applications such as entry-class industrial human-machine interfaces
> > (HMIs) and embedded devices with video capabilities.
>=20
> I have reviewed patches and they look okay to me. I'll proceed with testi=
ng.
>=20
Thank you for the review. For testing purpose I have created an MR for the =
configs [0].

> Do we have suitable board in the test lab / is there plan to add one?
>=20
I'll let Chris answer this.

> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

[0] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/merge_req=
uests/52

Cheers,
Prabhakar

