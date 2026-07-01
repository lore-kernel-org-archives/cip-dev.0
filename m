Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D22C43458
	for <webhook@archiver.kernel.org>; Wed,  1 Jul 2026 10:49:28 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.41958.1782902958848336128
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Jul 2026 03:49:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=nyIHGQF/;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.46, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQ4r8yqvTLyMa6f6cqrt6v5tO6YIU/Kbjlp/TEGJG57s2UoB/OSrA3Umt8Yz47voHQC6Uj1rMecHPHjgSJT+ukdQDKFaT4qwigcLWSWMOqUu1AxzfAJmeiNWk922Xj7Z9YsvIUg4Gj3sQKHe4g14f1Zo/urWPow0xyLtZYWlwqkjRXFao9ayruyAUVix85LR4/epf1CHLg9OjlRRDrGig67/zBjcHSrpRf9TVgg8Gfef0ohZMLCc9ODqTB+eNJMuS8oaCJADv5UGMT1IY3dpTwewfGeqATsiouTRz7JZBh2z/dA+UdsDehRiZVZ5J0pCkjrPeJXTjhI4BM2W7Md9MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqO2+V69GXRB/0ibYcMjmI9g80ovS/UjiyLU23E4+z0=;
 b=cAiueyNDtE95lnOTkX3O68RGhnLrTXkk4PIUjfrgqall90ZljpN6DFOv272BVUgcUwffemO7pB+D4FRGa1BD7CZ+q+CzIgyqVaEW3HBKcCrTpb2N8Jy72KvR1w+4ZOzCpuuip0kFJbJwEIE7SNONbm3pK201dHIWL/8FN0bjiM2mJcSYNaqrJrAWZusvtfLNdXp85GS8+pIByHQHe2OLnoyKj7BEWKlb8F75+37m7DgoueS8twCrca1VtApzRSg2EGN8lY+MinCpY6bnMv6JTGIETKwwIkmyzYan0WJVvfWYggk7kRpcjhy/PkGxEYrrwfSEHkVduRU863y0FqLRoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqO2+V69GXRB/0ibYcMjmI9g80ovS/UjiyLU23E4+z0=;
 b=nyIHGQF/K+ZaYHIaqIi9FGI724sR70yIRgQY89nwAL5tPGJNT8sN/VaFfEdPgGnBmLwcG5VVz6XglfSrGlJAH6eGL/2BTUpSdxXD636d5I4SODs1c5gLe2oBugq2KZ4c4ZTKb+oFl1bKtBrmwVka8yViiTEHOA0PIuUJPI35+b0=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY7PR01MB14857.jpnprd01.prod.outlook.com (2603:1096:405:257::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Wed, 1 Jul
 2026 10:49:12 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 10:49:12 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@nabladev.com>, biju.das.au <biju.das.au@gmail.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip 00/39] Add RZ/G3L SMARC EVK support
Thread-Topic: [PATCH 6.12.y-cip 00/39] Add RZ/G3L SMARC EVK support
Thread-Index: AQHdCIZcnfwWkbGTQEarCpA6NdFQR7ZYfEmAgAAA6IA=
Date: Wed, 1 Jul 2026 10:49:11 +0000
Message-ID: 
 <TY3PR01MB1134661444CC12523908AFA2286F62@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
 <akTvrRZXQHsC6Nqj@duo.ucw.cz>
In-Reply-To: <akTvrRZXQHsC6Nqj@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY7PR01MB14857:EE_
x-ms-office365-filtering-correlation-id: c383eab2-1aad-4523-5a94-08ded75e62e7
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|11063799006|18002099003|22082099003|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info: 
 ICSETcxV7ip/7VYYFZjC3g1aBd2MOK+Mv5vtQHoh+2xQ9wwqYc57krItv9Y8xluRXbmWJxIubtc42pC8uJ4jhp4DhanCxtWktRRQGzqiGqDWgIuz1CXtDeTaDNNDltV4lMADaRN3f80tXndySgImsLCLVmWK0s79Xt3QdMLv7H0cHu08PkTxJ3WjOLO2vM8/fpfz95FcTd4Pe5DigKBYS+Buj2XXPB45k/Uciz14/n3O6T3/cFdg/9VMj4Zo6+CE/iH8M2UM3uMacNxkM71PJSMcOvKDCijhkpMGDi5bhV0tePOYeO4J+laxSNuJe5O+7WVv2ifoUHQkP69ca5o9HntaODnXSigJrblpl3ragDp1XU56h1eQAaxUO4HNnuGflKiIDLj7AUP7JzBeSVnhhHS6oa4San4ceuPH9OwkNfJ+3DSmtlZ6bDZ8/scUVmXQReHnIFaSbIdszj9jePGCrg/CPx2VtrB2SXUR3eY86JUpSMyoCAT9M5JRXqnU0+JR09vbg+nX80++GbeB29ims2E8yq3zWmkBjR3FasWsAQ/6jmsO0RrPrHRd0Y9ejn778h/grBUoc3KYK0L60GMdP+/8SHrTonFZrOPXB52PGCyBWq+yG+6aN77sT1uNIs4MYKti2gDR2hmY1j7A9WGrg6Xa2gjbfb8q9DvC5nASU8CfI1RJzweqmfpjLFEqANCVnJhYJlSR5kepx/5Y/pbIQiORpQAqX215wIxWhsoHhbs=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(18002099003)(22082099003)(56012099006)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?HgAQAGSIzfQcKe/fPoXxjl5ObIEI2K4smUatjBVIu1s8Ute3LBT10O1Ic1r6?=
 =?us-ascii?Q?XIFX/hZe7qk2d1Nrw/oA/618h29RBSKXTygp1dNSDH7qSy/+bS9KsY8WgJyS?=
 =?us-ascii?Q?rHV/VgM4WyltWQlRLTKS51gbUj+av6kmtFA+Tvq5u5jwxGMS2XZGYy8JRvit?=
 =?us-ascii?Q?kP9jsZKogYHhScT+2Evj4Z1rCxGwQy+calgehYGy/uWepCI7mVqNxPGTVus2?=
 =?us-ascii?Q?wn/G3EXw/mf5UtIOPtyOwAh4MoAmKEDk4altZhTHHPQ8JSBMCI2p4I/PFTbE?=
 =?us-ascii?Q?/ab9FRQZLQtZo/cGCe2TFnCEh7/nwi0CoT7l6IHoG2M05YHv0sSVriu+eEXs?=
 =?us-ascii?Q?5OMSdSvfhCVscNBtUy3L/O/9j5QPMyyTWR4Ko3mFnyXiOek+xpaA6Ufai3cH?=
 =?us-ascii?Q?F4f5VhcHL4Dh6At74LaVZHqeFtyGIMI6u7G+qPw5F4PbMM2OT2a6gDY/F6hF?=
 =?us-ascii?Q?l4Uo1n6CH9jZ+vwid+dmWuLInxqRfz8VsVmLoqZ4lQOExKGsBpIt1lesl3On?=
 =?us-ascii?Q?Bbi6UZ29Vl5bnOZh3sxdUcdnZi2nhecHlDTjVbZMvy4jiMG8nMFQMX/b4J6Y?=
 =?us-ascii?Q?F/MFURErLAcTAHfiRbT+806j8MXw2XGipzeYjt5fzUmjVhYFt93oAuMTDI4s?=
 =?us-ascii?Q?zUJOWgXdy+S0eG6qXiGVWEFe/5bBrbWj2JW8cYy09ngUhayvI21sm8bCntsT?=
 =?us-ascii?Q?fGmDFLFtA3AsyzfgNxuiUvvh+ZRJJkf87ccC0BFyAVA8P58ty4TuQD4j0foG?=
 =?us-ascii?Q?XOsU7Md+rxr1NEJxqb5FbSy7tiVIORylqKONiBJADBIn0CkBU7qPJLMm7gkE?=
 =?us-ascii?Q?1HTQt/mwlgRaZsbUtC6SyYH7rb/yU7RoRdw2kyhm9HY1LsIPuTC8ewqn5n/1?=
 =?us-ascii?Q?NVFkpCCZsDIzlONYEmpXe6gMA70z7TzqTTPlMl+MV3KBxMB23k8mZIJrhbnN?=
 =?us-ascii?Q?D1LDPZpELxUNW88q+UqikplqL3QhK39+g6VpyNCFcr9uhfjkFAaXLW7nHDYa?=
 =?us-ascii?Q?8AApxDJCP1W083rE6IY7CLfQnofPv35xpVKRCZyyuKULPIHnuuZT0v6gnzSf?=
 =?us-ascii?Q?D3zfZrKIkTtGGfSsnXXzZn1segpyk9OfiEQ1tKSi3f1WYXQ0YxpFtLKhnKou?=
 =?us-ascii?Q?j8lLJ2nJpcMKPgffvfQklOPpyR1Sxoc0pyyhPS/upBYW5U50iJJ0Ociv7+r4?=
 =?us-ascii?Q?dz8OypbQrCzW2KzumJQWOfSOcEdhaPgmPZwNQbQoAYVZpR0CVY8kM8z+shB1?=
 =?us-ascii?Q?yyXDvc8Ie/EIX4TjJwugplqI0bzmSHAQn1Kn4DDsbNF3c801R6+7Tfx05Qcz?=
 =?us-ascii?Q?UvMIe+4kYfBU0kHyB5FtPoOm7Cq9l1rz/yFSEfgR6uMBpvmcMDu3MUcZev6h?=
 =?us-ascii?Q?IdWWSPOJK3WL6w264cfMWO7fcHhMQ488i7x9ZHcjf59ZdXm09DO+K+SAp7T/?=
 =?us-ascii?Q?93coNo81AKS7TVQi93Y6gG2PfnrMucnhur8uvd/p6nTGBAwEsexYk5JwH4vQ?=
 =?us-ascii?Q?aOl3Kgj5eOZwNc/zoaz95bxNSeeMSeuYa6dNGqHijXWHshi4mRYgeybhKp/X?=
 =?us-ascii?Q?jVvxv+a9Hq3M9I6qpnwcP+qgpfN2oDuOJsAcxNKfLlvAKFOio+a6FXESOWHQ?=
 =?us-ascii?Q?CIh4OaDXvvunIN2OFwKyjncfyaUu46n+P45Qt2pa8FsvjItS14qrmIfxlMMZ?=
 =?us-ascii?Q?sV1Jc0g6QhdN1a13KCgfbEJVomxkwXCs2xWDuMJ6ZvWS8cRFu4DCXNhvxiPQ?=
 =?us-ascii?Q?vnhljelv+A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c383eab2-1aad-4523-5a94-08ded75e62e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2026 10:49:11.8904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c8Ll1aBf4SWGXB6X1GKm0TpHgHjQG/+5fP1PDc9riL/fNTkTRcLbk2PFYhZIedT4Ml6pHi7scs6+gZZU1PZMcbbc6p04aUkuh4fTPDEHo9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14857
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 01 Jul 2026 10:49:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23368

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: 01 July 2026 11:45
> Subject: Re: [PATCH 6.12.y-cip 00/39] Add RZ/G3L SMARC EVK support
>=20
> Hi!
>=20
> > This patch series add minimal boot support for RZ/G3L SMARC EVK. All
> > patches in this series are cherry-picked from mainline.
>=20
> (I assume similar support for 6.1 and older is not being prepared?)

We plan to support RZ/G3L for 6.12-cip+ kernels.

Cheers,
Biju

