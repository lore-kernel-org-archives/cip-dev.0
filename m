Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6773C4332F
	for <webhook@archiver.kernel.org>; Thu,  3 Nov 2022 08:03:40 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.93])
 by mx.groups.io with SMTP id smtpd.web11.16852.1667462617048828107
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Nov 2022 01:03:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=FOP3baOy;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.93, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZpJmv+glj85fUOqrSxfsGn8N0K33je8s4XqUf34RyebBhGmSMmJmGnXv/5HKyvzEAd5jCPVWviVfB+Vu83tnEzrpucOPNzrMDsFAtX65S4244C3QG8bog/MZg5vO1l0s6UsP7PudhP+6KocUM//WO2+yLPOnXgYZFmPMsAg0/NGGv5MkOhzq71mabQjwWyLDk9TP6bPuHI1D1xW5r4sXyZdjp+anSb45p+BPEEevHT2ayus+mcGzNbKq1ZGSPuzd1RV1mmdTJOqy5sB+8hByYMK7f6GCaHXIuoEQZSyoBaLag/YwPxHCW0sWG7bfFuOmxs3LJmhEhncM1Dk8XoxzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgY1ftX5ZaHhhtACEx+pyRwzsGpBc9pVzXxgqi7X04A=;
 b=Gn6FTARxqYe9uSQWYg/mhZjBoMPSfIod6Z6k6qABckSnDLTOX8DhP6R4xReQObT94atJAF8CDdVxuDeoQHK/0gp3+fF31kukWImZZmf1ZV7U3qpCZuZbGLx07rn0JqGvFFRb/2+qVK2MKro+caJpHPQiXLFcx93UYKEu+gdRtxGkPo8MXv68anJHH6S6V8Y19AiVSTea9cDQ/rtMzz3ez5WLyINt34Z7eHC3ifjTiVep13JS9gmHhOHo0KQM95MaJe47nvMeA/nSm60KZ6bZ458uRYByTO84w+A+l1+Xuke6oHSPWQWVd1zRDUR3eS35Z99yGzfZDSlN1uWdM2IeMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgY1ftX5ZaHhhtACEx+pyRwzsGpBc9pVzXxgqi7X04A=;
 b=FOP3baOyjqJwq/v993zSV3o9yFmvq5pa74+UI3g6bGn0PGE3Byck9nZvRAiLkSk90gx42XAS0jMTAcCC3ZyyF/C2A4RPi9ZH7Suv8mc3IMpIftXuGMO9hWOGwjI2wrWsd9fxvLYxg6dr1ZA6+ibTvPisZHINoJb2GwAPYPTnwks=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB8575.jpnprd01.prod.outlook.com (2603:1096:400:13f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Thu, 3 Nov
 2022 08:03:33 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2%3]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 08:03:33 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip] can: rcar_canfd: fix channel specific IRQ
 handling for RZ/G2L
Thread-Topic: [PATCH 5.10.y-cip] can: rcar_canfd: fix channel specific IRQ
 handling for RZ/G2L
Thread-Index: AQHY7u2ZOICKdXoSbkOgcUmh7Q95MK4s0jAAgAAAoGCAAAPQgIAAABRQ
Date: Thu, 3 Nov 2022 08:03:32 +0000
Message-ID: 
 <OS0PR01MB5922ED582C321250F2BDB24686389@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221102190200.1166569-1-biju.das.jz@bp.renesas.com>
 <20221103074354.GA12403@duo.ucw.cz>
 <OS0PR01MB59224E2B90A0FD095A1AC8B186389@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20221103075947.GB12403@duo.ucw.cz>
In-Reply-To: <20221103075947.GB12403@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB8575:EE_
x-ms-office365-filtering-correlation-id: 23b85890-b752-4493-3767-08dabd71e6f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 LXnaBDsfLWSt5zd8hcM5GHZr9yHGkeQdAQMfdj1iOHlfuAwxRWkPiRWJf8lW7OuZyEGshT1zC/iaLyl9HOriFLrB+k69XkMRfqrMC9lcQaVZQ5lt+9lqoYEPhM79WJMyavGsGreMzCQilh4Uyz+wSvjilyOdyFbh6cjTZ3rXb2HvPzNzaDmeE24SPi3ily5f4tn5gG8htUinX0p+ulkDa8PtaFIf/y7xtT0s1O+oN4NikctbSIMwfs4kOsE9l9YvDZAY82Ktb6ujPn+FGjb0fFdkTkDilpvmWewxati7YjyLVZX922l3mt6/d0EfxmyppYTviqj9IHF56M1XEqhXDEDWjWIH0UO4GUDDk+d7249DCsCesqzeQoVVs7d99DHQqvR4gzEVcvDXldI78V7z6ISMh95Cbi9cEsLHM32dc2Cbnr0CH0dnV77Ozdep1XszDJOabcX0CU5l9WS9i+clh6Qd1ffXJnt7TNEHiBjGgrFYzMQotWRr67paKL7eW6GEbllZ2Jm9g+uHSL67Bs/E3JHOW7BNxVtL8ETZms+uhvYaJ0tu8Gu0FYRNpOwt0Mlz+7/2cOVTq79Mef6eRz2Uzd6CRf8r5rI+QzkkPSEC5oO0S47ZVFiR0YOrT2mz+vk4NTRBuP82Bwh4R4LDnnGvMyl8YcCuL9AomlIkqJVYP9dHj+kjIck8sebZuYS2ukjYJx5LlLB0QC7XdFgpqEbp0gf+B45FRoXYtZrxOm7Ror/fUkWjAqATVe8v9V7Tdlgg3KhfrhrgkvmdFcKecgxNjg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(451199015)(86362001)(55016003)(38100700002)(122000001)(6916009)(38070700005)(54906003)(316002)(478600001)(8676002)(107886003)(71200400001)(52536014)(33656002)(5660300002)(9686003)(26005)(2906002)(83380400001)(186003)(8936002)(66946007)(66556008)(66476007)(64756008)(41300700001)(4326008)(76116006)(66446008)(7696005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?633QaHBiK3SVng6rcmcTpxlHRzrf2cc5Y8xQz3+p93TkJCxix4uDrSaeZKUU?=
 =?us-ascii?Q?miwtMKT5eFvHeQfMo8gU1ZAJ+ZmVTojsJBI5xPwil+oTZfjSCC9eYWc/nNt/?=
 =?us-ascii?Q?c4ZhYKFYQvbt1fG1qovVol2QgP+iPtRySc9tu5ski2F4GbqtiCEGc3ykYYY8?=
 =?us-ascii?Q?4oJtKqAskC4ZcGsNhQ+z/9NOnaw3Ay2h2PvbilC6MSX2DujlDhCPOROcauVh?=
 =?us-ascii?Q?zRR67IoRn/IcaLK4e3P0e1WabCVyJ2D2CRZ8j1tPOmlvKVVKTuR24e4LTF9k?=
 =?us-ascii?Q?AVv6uVsiMd4FWPQcwwX5HA1B+mr5fNPi3yzn3vvkJYcdrGzN+Hj8NqTYlM3g?=
 =?us-ascii?Q?XLBvsidMRP5kjjjT5rlvpLNCp29yRjRiXeLwZTS8ji1db4eN6pa6hl9TwRjQ?=
 =?us-ascii?Q?jgTUDyZzcrknMrp7I6COf5OyX+qWKYjFLKb7xzbqR8JCakw5TmoOodo8XkZA?=
 =?us-ascii?Q?bN5xYOy12lqIiBqhgN8YM/RrbVEuyUAsqxvkUz/cyx9QYS+AVvud4LRObxUA?=
 =?us-ascii?Q?l8e9qj+wY1mbcbrHUkRmqJai6ZKmWcilILjvpZBS96ZVuY2fvKnvrQgbPsvM?=
 =?us-ascii?Q?K3xJHh+YkG2fAaOhEDghD1BVVadcTp+IHocE1Oy82QCdZcsIVpNJ76xHGm5B?=
 =?us-ascii?Q?euAyMlLKJd7chCo9cHqcoNcncDSoFiCam551iNoFsMbTDIDel2YgHwlsPAKR?=
 =?us-ascii?Q?YLfI0oxjS3DAtWJV3ChkXUwBLOUiN3t9xH28yiCp4tfNB2UrM0uLbOhTAgBO?=
 =?us-ascii?Q?3OhPHTtuh7GB61KW1NJD0gfopXeaDJ47L9H4mXWVxUdGBbGjCJhNzwJeZBE5?=
 =?us-ascii?Q?5omOL4evNRDz+/X5dDo5I14NmKi7EEWbI1ISHA5lsUAgyU+CJliUXbleqlbF?=
 =?us-ascii?Q?6EOm6zt6alYnOaDTURvPt7Y4CbAqXSgeCsHJzY/GlE53iEpWsnKF/4WUj0mU?=
 =?us-ascii?Q?Lky4jc43Trb/cVDHYtVQqZaaC+vdZxSkWZXwguxR3XLm+h0FgMkmsURIINFC?=
 =?us-ascii?Q?zuUMzfeMkPjy9btwK5gBtdkmbapxFW6P5H+azDaB8e0sVGwbYAO6o3hWf44D?=
 =?us-ascii?Q?bE5mK4YSZbLP2ffBr7fmvKk0/mWkwQxgqLdPLC6rgQV9GHRLItuVA1bsmRxV?=
 =?us-ascii?Q?plyUB3Rrkp5NkirGpxD/Wrh9mkbmeM8lRMvBBmPd1caLPXTMP8ufxF16/3CN?=
 =?us-ascii?Q?/GPHUK3qo+0CKwQlzmGjey6n+V5WYkKPjnT1rgS7qSomT/G88OFd+aq+fhij?=
 =?us-ascii?Q?LO5H5SX/Qp3N8S3AzsOMxFb+MBNhuhxRZ0NMVjwiw8Weox9Wp7uZgtyzjScg?=
 =?us-ascii?Q?/3XVB27JdzcGACq8rpf+rvRuOyxkVF1mKx9lI/uWGN5K9gOWWiF2tIU3IoJp?=
 =?us-ascii?Q?5J8OXB/IppSErQaXay/keGMEksccZS2XrF6TBcitq2Bw77YOJjxyuz8z8GhY?=
 =?us-ascii?Q?PNqYODFqiAtlw2GuFerL//JtmYttVGJAoHJjE9DfS3PF5TRm7Ns1u0N9UtaY?=
 =?us-ascii?Q?U37Pq7jFiih7o3cUaZSPDb6DTUuz+dUZBDYwaztimxP5C7/sRqY7Hz6wovPJ?=
 =?us-ascii?Q?BsEuS0rNKwyORodZByjo9D5n4UDmOOzuCtLkQWOOcpNNOU3R6kic5xCtzE20?=
 =?us-ascii?Q?8Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b85890-b752-4493-3767-08dabd71e6f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 08:03:32.9687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9+ttNoMrnYpvFmcK7KU7KmxqrIl+/Ydz3FB1A4MrTT34onUuEhZW/wT8+nR1rKf7lRheGYHZv79jTXDU5mp77JvLhAHK4IXaMxTGxjAepME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8575
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Nov 2022 08:03:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9900

> Subject: Re: [PATCH 5.10.y-cip] can: rcar_canfd: fix channel specific
> IRQ handling for RZ/G2L
>=20
> Hi!
>=20
> > > > RZ/G2L has separate channel specific IRQs for transmit and error
> > > > interrupts. But the IRQ handler processes both channels, even if
> > > there
> > > > no interrupt occurred on one of the channels.
> > > >
> > > > This patch fixes the issue by passing a channel specific context
> > > > parameter instead of global one for the IRQ register and the IRQ
> > > > handler, it just handles the channel which is triggered the
> > > interrupt.
> > >
> > > Can you elaborate what "the issue" is? AFAICT the code worked
> > > before, and will work after the patch, with maybe tiny little less
> > > overhead after the patch?
> >
> > Basically, tx IRQs are channel specific.
> > Previously if any txIRQ is triggered, you are unnecessarily Checking
> > IRQ status of the txIRQ which is not triggered.
> >
> > For eg: if ch0 IRQ is triggered you are checking for ch1 IRQ status
> as
> > well. Similarly, if ch1 IRQ is triggered, then you are checking ch0
> > IRQ status.
>=20
> Understood, but checking ch1 status on ch0 IRQ is not going to cause
> any problems, right?

IRQ processing should be fast as possible. You are improving latency of=20
the system by avoiding unnecessary checks and by calling an unwanted functi=
on call.

If it is shared IRQ, then it make sense you don't have any other alternativ=
e.
Since you have dedicated handler, make use of it and don't call any
Unnecessary function and checks in IRQ routine.


Cheers,
Biju

