Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F806C64EC4
	for <webhook@archiver.kernel.org>; Thu,  9 Mar 2023 00:29:57 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.97])
 by mx.groups.io with SMTP id smtpd.web11.1762.1678321790561086237
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Mar 2023 16:29:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=DinRmCYC;
 spf=pass (domain: renesas.com, ip: 40.107.113.97, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lH7NLqeInly4gAY2KLjTWLhf139e1rrQCbrVIEDaJsUZODj8nwBICd1RUVoyU/r92P7GZeei92TEBUgT+ofyUhh8v+IExXXdMzr7FMLjHHttVOLWWYc68cxzWPeTkaQLLDZ/JkVzJv4ZhXu0sKNdUT2Jm+B/dF/FPvjzxxsjl9dbr+f01Ss7jzuLsC/q8fFARcqHG5hhPxuUYoxie6QM1m4bg2l3ol6diHEq/is/BYe4XZybC+iG6Wtn37W4sZmBHL1lS8SsBhEV2aTy+t5B320opbh8Uo68FQYlVN4UvFHKOc2dBd9gYsSF+0nDZQabj/VgjZZKZc0H/qTmF9BuGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2AcB6+mbIoklu5KI+KbW5/Ey7adlLmN84SJw8K1g0Q=;
 b=bIg4ezmeKCIWYpzrV2sKn4c5gcc3GI7hd00NJc56US0k5pwSnVWhU4EC98NLGhX1E9Q8BcO8S+wuEr0P4WKjTKrEYWlszVXKMgDyYL6vbDHwvwPrs75je1p92QeW6Iq+gYygWpXwdXGsxKk9SFaHSEnYlpJ8nC+hEp6hawlP4ypWi19rBKxDr1oW/Durj+SLvggn+ZIVY/wBbhCE+zKfwVzbfZwq9FZeic1Br2eNib+HPE9MjvkU/N8mSJySvK8NB7gPx5myenzVQ2yl7sx7kuK99s20khSbjCLUwU4ytvuwGIEcpyp7reiz4x5yOJtJIZ5X8eHhIBCm2ik1XTGVzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2AcB6+mbIoklu5KI+KbW5/Ey7adlLmN84SJw8K1g0Q=;
 b=DinRmCYCArnMhgrlqkUvP8wnRnG/EUscpU6PaO0Jd8E8M9nglcdJ1jAuMey6o4ezZ+slIoXXpeCRbOQXIPP2TvtxvfghuNnMyoPV2ZRBcx0SOHEtYtNL/600y/R1+FeSjW4BP2/r/wGvXOHKIOjZZ6VPyKBK1vwLiHSRsDw8P5Y=
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com (2603:1096:400:309::8)
 by OS0PR01MB5762.jpnprd01.prod.outlook.com (2603:1096:604:b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.18; Thu, 9 Mar
 2023 00:29:46 +0000
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::dc49:e307:b424:4a53]) by TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::dc49:e307:b424:4a53%4]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 00:29:46 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: Tests of 6.1-stable and others
Thread-Topic: Tests of 6.1-stable and others
Thread-Index: AQHZUTsFntlHQmiumkOidsV6NvPLwa7xl75A
Date: Thu, 9 Mar 2023 00:29:45 +0000
Message-ID: 
 <TYCPR01MB10588AF3EF062659C99C13D8AB7B59@TYCPR01MB10588.jpnprd01.prod.outlook.com>
References: <ZAerOFASj+Fgqe1o@duo.ucw.cz>
In-Reply-To: <ZAerOFASj+Fgqe1o@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10588:EE_|OS0PR01MB5762:EE_
x-ms-office365-filtering-correlation-id: 5b5aa152-7cbf-411d-cc98-08db20356273
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 6UMUA47eD7Qy+r6RH/hyOUq5d4L03ZDq8nnWcFi6PNGjE7CGRYq/DFagOFHwB09PuDoQo3wDFV6hKlWWy2RR3lp6sMYSd20vBuvcmKVCqpxY4dS+lcXb4J4ZPI+B2vxhm83ZW1hMN0GpnCozO6jzbkWqt8OTmpPvqMIbe8anr272acnYjS65DorwDvi9Xdur1AcW5ovrMpcsszMyteOZr6ZuQXa1Z629yMXUEKS0Lr4c7x3l83IOTllR/HsV8gmMq4Ny0IZVUI+Yyqt0WJq+iO8/sIAsI0jc4wgT0r/OGoY3KFEDUlHAA6uq35erq+ZQpOqKIPUK7hyl2gd5ie9b7M0UZ2aPIbETBltZx4Jpem0avX1v+PHP4qeSTqyiK7ksi+QIy9MxAUqEH2UaCtFxJn7zR4AkofPJKokORA74fNuaWpccOf+GJUZRSqAv5XorOya5b5cEyxvlLw6jO82Htx5hg5CLo28HeBe3Qh7fdHxig5/qBlifnFRU3Ug0a7y6Xyz+fkJCx0n/5EzVa5aqVT0KDGeKk3YLWr3pq2FN0lSpldB7iF/fYRCPaVovHUowxMnV4Tpc4a8IJagmh6A6CyQXKsQdBIbXLjfpnaU0X2gVIFdjRnpe7xrMW+2YBF4j4Ci2CC//H+0LdjnceDio081yafwtCrLT3I8kJL1+zpN6Q/kE7cczTREmhq3cI9bi7SVaQ4WUaf7zp1CBlqVSEi0JawAbYiIdWiNAwD2nJwE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199018)(66899018)(316002)(110136005)(33656002)(55016003)(38070700005)(38100700002)(86362001)(122000001)(6506007)(83380400001)(9686003)(186003)(7696005)(71200400001)(52536014)(8936002)(5660300002)(966005)(478600001)(41300700001)(2906002)(66556008)(66446008)(64756008)(8676002)(66476007)(66946007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?L1FM2NZayPgzScZWkpHGunUPZomvFpjLvfFNilODZpk8MKZ3++7jFAi4?=
 =?Windows-1252?Q?Qy6RMsHGOzQf3pC6IoZGAO3Kuk30u0V9pY+zJIo/zd64KVjEryuaCHv6?=
 =?Windows-1252?Q?O8cD8POEEK04L60+L0aaOGDQxkB4lwnUIRB2TeRpi5AEIYOkHhYgpNvQ?=
 =?Windows-1252?Q?a5zpqnUZuINz4VvYwkpPYJGiTaD6OpEaIu57kIloPFstTTYXmr0+JYyy?=
 =?Windows-1252?Q?kOfRL1jZd6Gbkmaq3AWnaPYZValGugCrtx/1aEN9S6ptLJLV0cV/OBtV?=
 =?Windows-1252?Q?EjoURL0Hswcectyc/Gu/Q+GcSHpQ3qevX7bPh1QLr5tjhJQc96DT0L4l?=
 =?Windows-1252?Q?xWzGCc8QBKA0ohaiqOi/1q09s43JiMZu5J5stQTOyO86Ky338PFMZMPR?=
 =?Windows-1252?Q?RcDIC0WpvQzfruEvh8vWfEp4kVDcKuLqsE7wjCt8ofeiJa3n00V9BY7T?=
 =?Windows-1252?Q?rs9rbIsixsidSD37FKn5D244zOrgCZd3B9hTrt08o5A5Ss6I/dDakXjc?=
 =?Windows-1252?Q?vmkMC24EDz4nj7ubX3Y5cG9tiSN529+PQ0AtjRhEDLvkfT0NBp/v3rTU?=
 =?Windows-1252?Q?l5Yl17gd0PnOr5Lq+uYmfOcXneEwtMcmToZxehRC5OfKWy6HG8WREXyS?=
 =?Windows-1252?Q?vu7N1Pv8gsZ7kG6ShnKQqW1Jkf/B89T8h9hpCSNpLjPZdu7T6lP/Y6j+?=
 =?Windows-1252?Q?misVc2wi7uuZtDbgQ3klML7ezXyl3VfrUrxz8U9mFV+37/OYOYj0WG37?=
 =?Windows-1252?Q?yIPB2OCAkwbuyGsYHcwkcmwiaJ1VUi4vrmrJyTA4o1R9eJ/ijFBkovnk?=
 =?Windows-1252?Q?6HT1w68+1I1zBwkulfYQ3BG7i6PeMo7wcx/jB84C8lmS2p3q8z+ojjp9?=
 =?Windows-1252?Q?cptdmm0nz3mjFdnJVrNqyzSny1hMaAUv6Xj5yfXYVso6KxsmVGBZ03ox?=
 =?Windows-1252?Q?kHUV8co0IHGiDQHtfXaXnCbPgSHF/0+FcHlQM4McUPen9yDJi/kIGMj1?=
 =?Windows-1252?Q?Trkmsah2g7dGywXJ46zYqk/39HNj6H49Ae+LFSfWxoaYechFE31a+qUR?=
 =?Windows-1252?Q?Lh7+NyXFg4ighNTADCgiMpTJtPnpnv5MYm2yIjg78olG4d5XDHapKRAn?=
 =?Windows-1252?Q?XScMdEsHhKYYmN3UTszrHM+vZxyexe/YOVnx9rMwabsaQAwUryj1Ny52?=
 =?Windows-1252?Q?9kMmFdWR+IWsX69ajRB5u6ht5EJutEb8ykIt7QBx+MyL7bA0RII/tc4P?=
 =?Windows-1252?Q?tsEIPaeuf0s0kjcP/uK3Y/W0oxkVvuFh5jJved2s8AffLmt+UIkr+f+Q?=
 =?Windows-1252?Q?qdSMFugDJHdtfUz2iay8YqAZy1vTA4X43EGDQ1703M9av534ybY6ezFK?=
 =?Windows-1252?Q?69hAriOuohuNNqGSn51geW6ROQ9Uw/2GUFmdvVlOb+TgbvDvYUXaRxZq?=
 =?Windows-1252?Q?zvKeS9Ju3RTVcTiLe7wvVwp7YREvSUN3aiBcsEZxPfGLdFdYzXiDhGPy?=
 =?Windows-1252?Q?tKs6B2gyZVLhJ4B+vic2QitwLttrSQV/7Q8C/WARxlCO6K3EEHRiFX3u?=
 =?Windows-1252?Q?kV8VMj57ik0X7kOJP+MUBBl3CpciYDXfN+bcJposbCeqCLQVySSMV+1E?=
 =?Windows-1252?Q?VUerqGrb8TaD9vE2SRzC2fuIytITQ45ItL300cdIDZ5glt25jeLDlqDR?=
 =?Windows-1252?Q?fF1rgxmhggg=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b5aa152-7cbf-411d-cc98-08db20356273
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 00:29:45.7668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L92o2H0tyl/pqcOHgxm9lOMRa8LV2klQ+d0RyBgBNGbGqaAg47kzrYQo4hBzz0rtL331m3NFG6TGgjTLmwaVxeGekGtGijsxdo2V0FQa1Rw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5762
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Mar 2023 00:29:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10953

Hello Pavel,

> From: Pavel Machek <pavel@denx.de>
> Sent: 07 March 2023 21:23
>=20
> Hi!
>=20
> 6.1.16-rc1 review was announced, and I guess this would be great time to
> announce that we are now testing it.
>=20
> I see tree at:
>=20
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-
> /commits/ci/patersonc/linux-6.1.y
>=20
> ...but that one is does not contain recent commits from 6.1.16-rc1.

Nope; it was just a dev branch using whatever version of 6.1 was around a w=
eek or so ago.

>=20
> I see it updates from linux-cip. I believe it should update from
> stable@kernel.org.
>=20
> Ideally, I'd like to see same setup we have at
>=20
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linu=
x-
> 5.10.y

This was the original plan. I was just using linux-cip for testing.

I've now added everything needed to run all the testing in the linux-stable=
-rc-ci repository.
You can see all the latest pipelines for each branch here: https://gitlab.c=
om/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines?scope=3Dbranches&=
page=3D1

As part of this work I've also improved the way the version gets logged/add=
ed to a commit.
So now it's easier to work out which version of stable-rc is being built.
e.g.
old approach: Upstream SHA: a1a87af47a80
new approach: Linux 5.10.173-rc1 (a1a87af47a80)

At the moment it's using dev branches for the linux-cip-ci, linux-cip-pipel=
ines and cip-kernel-config repos.
I'll create MRs for these tomorrow, as I'd like some reviews on these to ch=
eck that the correct compiler is being used, and the correct kernel configs=
 are being used etc.

Kind regards, Chris

>=20
> ... (And prefferably do it at the same address).
>=20
> Thanks and best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

