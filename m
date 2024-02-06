Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86977C48286
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 09:02:24 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.113])
 by mx.groups.io with SMTP id smtpd.web10.17613.1707210142136540061
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Feb 2024 01:02:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=fcKVtotL;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.113, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFRS9NEc2HG0UtgDh+u47ik6hzpdjekHI7l1MPmTyRjwbVNO6qqjGXrv4ylW7VeCEpCjG8ivoN+EQ9f//FJFSpzviLUZyhi7luVoAgitDWL8pdeBxyyH1j3svgNEv41o23d1WvZq3Z+XVodlXh+zdYu0uEFsHIctHRXJpiGjJjPSkVn1nTG6ludn/hJouu2csYNUSi8oJq6Ejt4rPLlOMzuRRrwc4xAMO4+ZOk23AL2DUi9vczCLecrtOgkzIjGwLVQIASGSa+tZTR0YIPUmLVET5VgBqRSJx993+EAsYfPDrjTJGOGZafE7VKDOaKmkk9cE8qDt7KJlm6sHOzEA2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQblLobTVRbyObT1wCH4F9qzHwib2XVSo+12aQ0EmOQ=;
 b=f58tuiP7cwO36CMx28MuQIbx+RgaZTK3EPJLioWuo2niE6ZENOB1aXotvosre8D1qNJuVdVXiNC9dPtaXnAy9WpP8UO/kFwi4bfK8N2lK1MB2q4l46W7+pSKge2jBrsljLBfI2KgYyYYIPBBmp0qZNOGq1O6/XBdUk3Y/2NjW8M6rkkjpmmE0Sb5NQvkOoYRzRajbmUlwzSCiveyPFR5ijdrjKU1SEUni87W92C+HdldNnxuzpTH+5QweBFggUnogpwkU7kba3T5IGcaxcRJxrDU/tSv+LXH2vuSE9tY8KKQsW6bUynRePZKA3O7Mfax20jvmR18vdWMPLoz1NSgrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQblLobTVRbyObT1wCH4F9qzHwib2XVSo+12aQ0EmOQ=;
 b=fcKVtotLKcxWpKBr7u+OtT5V6qpTYdg8b1aW7BBMEBYtInhYXRa/yuL2smyeQuYS3mqkJ4MYckxdIl3qh++64gzgxY1rYElGTMR1DyHDOph5ISXsup4CAk3Ck2oBB2Ivu9tdOXeFvv3Sa9jz5fRELaO/5YBoOuHkx2ZNUX0eAs4=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TYCPR01MB9733.jpnprd01.prod.outlook.com (2603:1096:400:20b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Tue, 6 Feb
 2024 09:02:16 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::deb5:2f61:e3a4:dd66]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::deb5:2f61:e3a4:dd66%6]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 09:02:16 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 00/48] Add support for Renesas RZ/Five RISC-V
 SoC
Thread-Topic: [PATCH 5.10.y-cip 00/48] Add support for Renesas RZ/Five RISC-V
 SoC
Thread-Index: AQHaWNaSnNINzCoDzEeR1S+KlSxgW7D9BIgQ
Date: Tue, 6 Feb 2024 09:02:16 +0000
Message-ID: 
 <OSZPR01MB7019AB3F3CFDE3AEDE0D5F55AA462@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20240205124135.14779-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ZcHt3L9g6EtZ1OJj@duo.ucw.cz>
In-Reply-To: <ZcHt3L9g6EtZ1OJj@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|TYCPR01MB9733:EE_
x-ms-office365-filtering-correlation-id: b8537f10-630a-472e-92ba-08dc26f2510d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 B14PQyUGPKmQUAYcl3mUZTEXWe34q1Ta6VikAgpaU7MNZ7ZxqrKvcz7df2sVdlmYLFTSlP8UsVpJA35yyiLb4DVk4gdrmwzloWNRJ0XS3Kn9YcHjpcSqyX7ESmyYdWokW8NKjL60/Y7y5Vc5kFtQjOWuKnGK9cWlWOXxzn31NH0oA2x6JbzCeSz5XxayFAVG/i0IAf/cmD2jAlaPjpzNcx1WAEG/jeoA4RiauA2aq5j+Xlcp4Vj0aImjqGaTqgsbSbko9mDOe7lpvn9UIY3tjdbTo4G9OHBwINs1i0yIRpskIcU77rVOShUDZ8xdYdr3bBMztyXeUxlILWa3wubV2zSUqFfDUbYUJ0WuNs8FZdyqEf4+kaKf8Zi0/Uz8cnM3Uc4HmCaO8BmoBHDGcGxrCN+1bwFtoLodZiY6AfvweCmYLjDPKsSmiCotcjohYCb/58h8OeL1O0E+DRjEVVE18fmChxTIjrhi/G3nTRY7Tig3aIlHqKR3xY+0N2rXfpmL8bMkFrV6gJAS15Gd9P4Am99oPtjhO4oKOeiZMB+pHTwBHlxepEzd+UljyhMN+VIxnOtSLSmZuH73L3+hfxEu0GWkc/dJ86jH1zQM9+aOGKfJ1iVfnjMND+FEglwQPiUc
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(376002)(346002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(71200400001)(83380400001)(107886003)(9686003)(6506007)(53546011)(122000001)(5660300002)(4326008)(52536014)(8676002)(8936002)(2906002)(6916009)(66946007)(66446008)(66556008)(76116006)(64756008)(478600001)(54906003)(66476007)(316002)(33656002)(86362001)(38100700002)(38070700009)(7696005)(41300700001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?nKAUJ7EiUkcNDC2A/J2FDM5ckDpF9BptkkLsfcE4K2AuA3zO4WgUOKR1LXdr?=
 =?us-ascii?Q?2aDr1gcmMa6mhPF9934HbgfauMHVQMguxp0JwxifNxegZ+4OsHGxkyXVZSM1?=
 =?us-ascii?Q?wpXuGRB0cee9xZmexy1KIhLm9hxHLQPdtpvCKMnrElgN35J9YDxGN/WBOQpI?=
 =?us-ascii?Q?VzWiHZ2ECi1eZ7Xuu1G1MEvE1heCXtxq6sKJomJE9wmG7im8vb3wCK6cRgnL?=
 =?us-ascii?Q?dfaHfug79jO0MHlBpOBIXphRNdpcLsJpQMyX60rlyhZl9HAEkFx7KjaNlXzm?=
 =?us-ascii?Q?081+TaIjnBU3H5RCBuSGHZcg4q2115lU/kKjucvSp1kScq3qdupDhZNZGh+l?=
 =?us-ascii?Q?Aq5VfrDDdUZMkTgotQd9OHxLVCTR4lm1RECSc/vPH7eBHm8DKKXZjOdJhayR?=
 =?us-ascii?Q?y1g6tSQCb1ELdeZ83hOlWDGhEv6iN0DRfB+Wx11IncD64s3lpNxMY5diA97s?=
 =?us-ascii?Q?zF4PdUlbZlLyByBu8XygyH6fWxfuvfNSCZ9fuQJs1Hn8ZH4jODBzpiFgNXir?=
 =?us-ascii?Q?+cNfU0ksY/yjXEKTgnJuGIw49YyoO2zneyA/sUu8+PsdGe0JmBND48YnyELZ?=
 =?us-ascii?Q?rxKmK/PrYl7E5W3d87DTmXrceA0hCRVH2B7T86BAA6Nwfg8UdLoi2zlJrzlO?=
 =?us-ascii?Q?IKD4J3+hCfiRFrlqSK4eTjYUMd1/h1bRBAWr4u6arBnP6LQo6ORU1+WR/A+Z?=
 =?us-ascii?Q?yzKICO0UNFu8hi/bNHbRKAdfd1mKRHjD9WfJtwu7BqqQ5vZPTMj4+dgHgQin?=
 =?us-ascii?Q?x+2W7kuOuiX9kWencyBo6qplmepkA+x4+jrr6V0ut7M5hgt2oP+XnsPDQmqE?=
 =?us-ascii?Q?2NsH+3KUPvcP+K1B4EHQlEVQfUbpVnxQNnUF+Ljh827x8Be60H20WD+b/RJ3?=
 =?us-ascii?Q?zh7DmfJBq8kO3QHUuHo7CDeI9GibXxQdUJvPaq8zNaedJLzdgS25QTTX8zk9?=
 =?us-ascii?Q?k4bmPKSqfKaKqaDskHkd3DXoGL5mYi6QRynvgS+ZPh11nc9phbRxPArNeV3k?=
 =?us-ascii?Q?+grIKY31Udl5KhajDjhzWXfdkaNgAfanKJguOXXtgk+4CV3kQ09KZdslsRDE?=
 =?us-ascii?Q?x+CSjoWt4jsQH6U8PRgfT6pGaiYPRqYMMZN7t5fGngCfX7l0EjiD/v/qQCvU?=
 =?us-ascii?Q?R12Xy8E8sbcOD+kWU4Ath5CCtIGmpYNbVnMt5UWzqwy3KNgUKVetrZ5sNkjl?=
 =?us-ascii?Q?BPWTFjZY848GKJTpMVtALGj/TqdUuAqzgmdiT/cVxQJ0nlfP17+42yXyT61q?=
 =?us-ascii?Q?twP9Jq9zHigmsyRUYSTYgiTWBtyeR0QPaLxEsEU0FUKwd7VokpusBVI41h4t?=
 =?us-ascii?Q?KexCo0sG6ayPoiM4FlwXLCULPIyRIbJqz+awaUjHS0J9xfgqshTC1PQUP8Wn?=
 =?us-ascii?Q?3zEltVx11uYSJMkdT3ggy7Zliji5l5PLcvFr83RxWneCkWG5U7AYO3gHNugM?=
 =?us-ascii?Q?ubR6piewLtyDmD7KomWYvs7nhhCpgFUBVcSGsqBoQvjoeB347Zf948cKBd+5?=
 =?us-ascii?Q?Oyg5ud9OGBn9s06NGCpwLo2oSA3Hdvbi/XwUNHwOXNf2xIruM8ZaY9ldKp/w?=
 =?us-ascii?Q?2ntrb36SZJzZNOXgFCvc/nhtkUVkfvxqIu3xAGhvCBKuIIUBrFZEb7Y972jr?=
 =?us-ascii?Q?xA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8537f10-630a-472e-92ba-08dc26f2510d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 09:02:16.3424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bz2MeDCMA2BJaKKRrtxUQwakexHwzm8GNrqxovAAmiUdP87cqK3QTxRvyX/JyfWdiVTFNj4KtVcHzJNj9NKx0yNnwLTA/WnJr3+fjEUDWwyiaDY/qLKTacbD8zrOLA5I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9733
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 09:02:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14776

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Tuesday, February 6, 2024 8:29 AM
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip 00/48] Add support for Renesas RZ/Five RIS=
C-V SoC
>=20
> Hi!
>=20
> > This patch series aims to add support for Renesas RZ/Five RISC-V SoC,
> > support for this SoC has already been added to 6.1-cip kernel.
> >
> > RFC->v1
> > * Patch #35 updated according uptstream for easier maitainance.
> >   Rest of the patches have been unchanged.
> > * Merged RFC series [0] and preporatory series [1].
> > * Previous test run results can be found at [2].
> > * RISC-V Renesas defconfig file can be found at [3].
>=20
> I tried to apply/test the series, and besides 1..4 being already applied,=
 these failed, too:
>=20
> Can you double-check?
>=20
Can you please point me to the pipeline.

Cheers,
Prabhakar

> > Christoph Hellwig (5):
> >   dma-direct: add support for dma_coherent_default_memory
> >   dma-mapping: allow using the global coherent pool for !ARM
> >   dma-mapping: simplify dma_init_coherent_memory
> >   dma-mapping: add a dma_init_global_coherent helper
> >   dma-mapping: make the global coherent pool conditional
>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

