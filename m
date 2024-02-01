Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C19C47258
	for <webhook@archiver.kernel.org>; Thu,  1 Feb 2024 02:56:18 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.7107.1706756175382167011
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Jan 2024 18:56:16 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 4112u40F1689144; Thu, 1 Feb 2024 11:56:04 +0900
X-Iguazu-Qid: 2rWhQ9h8CD9qeFQLw5
X-Iguazu-QSIG: v=2; s=0; t=1706756164; q=2rWhQ9h8CD9qeFQLw5; m=9GDdfrDHsZHUrmgSG08qxCp3z1rcy20nEc4eRGJ6aCQ=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 4112u3E4662806
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 1 Feb 2024 11:56:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKm8POgdCS8VAenbjoZZfPxh4ey/VZT3Grqpk40ZMq7y4kjZPnrcBYPZtTtfHgyD8JC+8+cCHN5XisnbhSa/AHcKaTcziFiBcB2O9nZpeYFxQHPfVkrqPHPuVErqk3wHwN2ecvyEcUdFFAW2NlB+ag9567WeIbh7pniA8+1Bupi8aLs/6EoU5mJD/WBypDRTsd4kwCPFQ98z6vBNRWvx3sckhxNkdCBxRqtWvIAk5cbey+1JjISp69UAU0sw8utynavzTL46cV18nEkbT+CkkzqTy1MJTVrZEoLMAPuyT504nrQ2jkOq3jHBBp8/eb+0Ao6AdThdhLyVS7M98WU+GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a78tihzGeFZSNzpSF8eioYMg+zdTXqFcUCEbcMGkqq0=;
 b=O2cQHQFahOJcdgPE2xz23xPXBoiOia0J2En5oCyiBL4+0DS5jSFeYrTxhoHw8s/8zNUrmRdXjjLymgywsblt/+ku/acdm8mmnU2glZiB+Tq2/NsnPX0w35RZ6K16huivNpSHcKVwBSEwOkjEWTDRqIsWrT5MaJI0JcR6Uo3El8S3fpQWY3uhgg67FGiuA87TScIvWOWPAAzL9iQPKWg49dXX1qUEToB53aDj9H/AP5RNsJo7rVBkMQzCqL8s63GZ6ZDE46A5LMtdVDRNHuq+k06SkPMFn4PLW6GrKRDBGW9DSj9u5lgwTjZdHkkmaIjRm6/sKjkKhLrjvr2D4gfhSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <Chris.Paterson2@renesas.com>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 0/2] Add IRQ affinity support for IRQC
Thread-Topic: [PATCH 6.1.y-cip 0/2] Add IRQ affinity support for IRQC
Thread-Index: AQHaVCsZMMChrZBSzkCxhj3S6yaH8rD0yyMg
Date: Thu, 1 Feb 2024 02:55:59 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388E2365F4D1D98F4A21C3F92432@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20240129191829.45687-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB6388181EE39FC04C88103D58927D2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
 <Zbi9j7QrnxocN+af@duo.ucw.cz>
 <TY2PR01MB3209DAF580A7B848FF2D9F7CB77D2@TY2PR01MB3209.jpnprd01.prod.outlook.com>
 <ZboYHqLJhaD3JnOA@duo.ucw.cz>
In-Reply-To: <ZboYHqLJhaD3JnOA@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|OSZPR01MB8465:EE_
x-ms-office365-filtering-correlation-id: 4b838597-3a21-4d0c-e1eb-08dc22d151ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 qd7g0widczwxvG+0PaAxt4XhJk9HM6LDRHALxYtoPYWa0aBWitserFwajKA3fDFbWdAslPx61zRdu3emgR3lAXv83eka28TXzvcQPk8eGfmI9qJbXAzGbbmU+nfN+Moqvi7mlwiInSo/wYqUyK4ayjPAA5jtnQO3MqHM2dRNvJU7ow/DJjFJwywxM+VKoYMFbEi1e8seY6oUpW6EIkOEHIHvWRuSJxNguo5HlTk6Jtn0Jof1poVjqqiRvUse627mSfqZxES/cmODIgvKvZ9XXKgERuP5Tr7AhV+efcUIhh554lsx9h0qou0ZuL0kpiO8GasiMraCkZPSWzzBEY1B9q39IrpITe0npqVaqjhdrZTrligNs8iPP8+m14ia88hRhOUZBroo4BuKnOp2otjQsH3zM9e2ZD/MwEY3DEHZFjnCsUFmr41Jmj0KU1qVK2ICRWxNugZytZyZjy4nAHKoCtnfr8f4rM8LNCMdAAmqoItSUZ1IKqIDLpfGkn+5natpTJxJ1GA24Wrwph0bSuMth9PKhfPD0Dzcy+4aj2/a8/DF4JMO7Qj0FNx1bzwAemzcwGLUfHO3eIu61xW6gitmcx8g6J+qd822BiHxePss296iR663Lw8g8thIK29VBfD7MVshq6qP6+YQ/NIFUnZatg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(346002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(478600001)(53546011)(122000001)(38100700002)(66446008)(2906002)(86362001)(41300700001)(33656002)(316002)(66476007)(64756008)(66556008)(52536014)(966005)(54906003)(9686003)(110136005)(7696005)(5660300002)(8676002)(6506007)(26005)(83380400001)(66946007)(8936002)(4326008)(76116006)(71200400001)(38070700009)(55016003)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?OTl4Uk1Qdll1UUhoTy9PYVpHWGdIckVDUGE5ZENXTzBteWV1OGxXMk5m?=
 =?iso-2022-jp?B?b2toMVFQZ0hlRGVvUlJlZ3JnczBFWTVjcEx1ZHVtenJqc0liU3NIaG0x?=
 =?iso-2022-jp?B?c0d2cmRXMkkwV2Y4aFl1a3VKaDBjUXJVZU96dnVhWkJCYkJ4dXVnV3pq?=
 =?iso-2022-jp?B?MHd2OGsreDNSb1NGZTk4Zk9sMEV2SlFGNUJTZ21YcDZMNE1pZHcxQXBF?=
 =?iso-2022-jp?B?NEU3YzhrSytBNUNzZGh6blFVRmVkUlRMZnpuSkhKMFo5MW8rMmREZ3N1?=
 =?iso-2022-jp?B?YlhjYjlwdThyWVQ1eXpVckE2cGI2NFMycjYrbmJKbWZ1WldXUnVTM04w?=
 =?iso-2022-jp?B?OHQ5b2dZR1RpR0g3NXpuUW0vd2x2TjZaOWZpNWZlbHVaVzJOUWhJRC91?=
 =?iso-2022-jp?B?cXIvUG5tQkd1NXJTbVgyeC9SS29mand4RVpob3RXcm5YRTdlbHJlVGUy?=
 =?iso-2022-jp?B?a1d2RWY3Z3kyR0xydWdJQnRGNjNXdFZ3emcyQjVIUDBQaUczVTV4NVFO?=
 =?iso-2022-jp?B?Z3M5MTdPdDBtdkowR3A3eWJiQ0w4Y1BHRW1RRjhsWWZPdnBlMHd5Q2E1?=
 =?iso-2022-jp?B?dVFGTFErTzY1NHhPUHZ2T0krdFpkR29qYm9uMzQvaFdOTVR5WTl1SkZi?=
 =?iso-2022-jp?B?cUxrUEIrY1lnNFVydWdudUJ3R2xYTEc2cTFjMTg0bk5OMG1uREl0VERh?=
 =?iso-2022-jp?B?bE1qOXBBU0wvVUpUeVdzVU5hZUE3Mi82MXBMdmRwNURZdEN6RERoN3JY?=
 =?iso-2022-jp?B?V2tBTG9DYXNKeTZwTkxXcVQxY0xLWEJkaS9yanNqNVN0b2VXelFMUk4v?=
 =?iso-2022-jp?B?eVRnY3poN3A3ckNUQnBtNTNHbnZYRDlDQ0RmVTFQYXdjWHJrR2lmZElN?=
 =?iso-2022-jp?B?NFRyRDNhR3R4ZFowbHZmTFhEaHgxSkFRckZNaGtuTkZYSWZQd0xoUDdp?=
 =?iso-2022-jp?B?cUttUllmeElXZmJuK1kzcVJlMXlWY3BpWU5kVUJCc1IwRnNqdVFkQmdG?=
 =?iso-2022-jp?B?M2oyWFdFRC9XUlJCa05BVkRranpCeFdHQjRrdmlUTnJ0aE1BT3E4aUlt?=
 =?iso-2022-jp?B?ZkttdjhJOVZXN3FjcVZHMTlBWmdreSt5R25BK0lxelJ3dUdRWmZSRDVO?=
 =?iso-2022-jp?B?WUNYQVcyQ0RNMmxnUTM3enpZSWdaeHlCang3WHBSeDZyZGoybFVsU3o2?=
 =?iso-2022-jp?B?VU9SS1pmeUU5a1BNWEhuSFpDNW4zSTFwemxJRFpYSy9BNzI4WWl2NERP?=
 =?iso-2022-jp?B?MGtqN0lKTktJTUYrdlBNQnBwdWlVL2dOOWhMTzhMVkJFNHRiSnhUM0xP?=
 =?iso-2022-jp?B?bC9lclVzUVpVZDFFSVFwZEgrU253andoMjhYVUZHWHNXU1BLSXVJT3NC?=
 =?iso-2022-jp?B?Z0dLdTFLNTQ4V0ZSNnhCVXIxWTlzcjE4YXNyNTlxdENoTW1XTG0rUTJB?=
 =?iso-2022-jp?B?Ynp3RktwLzM5ZXNrOFFYWXFTK3Y1UldraE40TkhOUXA4OFI2N0xlSXBL?=
 =?iso-2022-jp?B?TXYwZlkxYjkrSTczS3N2bDlOdVpaeEY3Q1NLZUdieXdITnRDWFIzWlRY?=
 =?iso-2022-jp?B?Zk92cXpqblZtb0JSL21JcGs5ZE8wN0VMbUFUaURjZTcrdVFLU0sxb3d1?=
 =?iso-2022-jp?B?ank0aVlka3RsMWlkdTMvRzd2OHRMYjBQcmU2TTRnVUJPQU4zZjBLTk5o?=
 =?iso-2022-jp?B?SjdiTDZGUmNKY1YycWFOVk16aHJpNyttYlh0TGJHVTA5anJ3Sm1LU1Y4?=
 =?iso-2022-jp?B?Qk0rY21qREE3aFdqdlhWa2hJNUQ4WWR0d0NEL0g0Qi8renJSOERqZ1hS?=
 =?iso-2022-jp?B?VzltdXpBeFkxbTZMMWxrNkR3d1RyaCtudzc4SnRnbXZYQjQ5RjVMdzRE?=
 =?iso-2022-jp?B?U0dMRkVkZjc3Q1djaFA2ZS9kdE5xckFjNVNBMk9VVGdtWktPWHFtTEYy?=
 =?iso-2022-jp?B?TE5tUUk4ZFg5Sm9aTk8xekRxYnNNNExYMlJhR0ZEWmIwai9CbGE5SEd3?=
 =?iso-2022-jp?B?SWJlcW5jTGlsUWJjZmppR2hRNHlWM1NvK3pjMkVrS2pHaUZHMndlbFVh?=
 =?iso-2022-jp?B?VzYxOFFUNTZrOXIvdVBnRm5DY0pjVC9zQUQ2YU9YOFdhZTRyYVNLSlpj?=
 =?iso-2022-jp?B?RzVVVHkrRUFZeStaSnNITkhJTU5sM3haMWhGdDdrM1V1SGJTVndTQjA4?=
 =?iso-2022-jp?B?MXN5cXZndkRFR3VYODUzQjNEZlhpSjE4WXNHaS84cGE3UWRTOHRNb3dw?=
 =?iso-2022-jp?B?UGIzWWRPeWVlb2Y5d0FXc1ZoUUdURVZDcnpLSHFMNlZTdDd0aWU0OHFi?=
 =?iso-2022-jp?B?Ynpqclc1amZ1WG1QSFlhMHEyeXdXQlpIcWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b838597-3a21-4d0c-e1eb-08dc22d151ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 02:55:59.7496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GGgNfTz32Jpnle38RZNf/aGIQ9LmBGlbDDBgw3M6NmocDPi2eYObdXfAkiEPVKW/kusWmej9Za9Ex9a39tO4k7/hGgFyaHpnW09T2K44hWLzar8pWAIVUKWZwiewoWeX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8465
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Feb 2024 02:56:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14571

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Wednesday, January 31, 2024 6:51 PM
> To: Chris Paterson <Chris.Paterson2@renesas.com>
> Cc: Pavel Machek <pavel@denx.de>; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?=
.MN=1B(B =1B$B!{#D#I#T=1B(B
> =1B$B#C""#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Prabhak=
ar
> Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>;
> cip-dev@lists.cip-project.org; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 6.1.y-cip 0/2] Add IRQ affinity support for IRQC
>=20
> Hi!
>=20
> > > It seems to be testing problem, but it would be nice to get the
> > > testing fixed.
> >
> > The job that failed was an arm64 defconfig boot test on hihope-rzg2m, d=
ue to
> missing files in AWS S3.
> > It turns out that this was because the actual build failed, but GitLab =
CI didn't
> realise.
> > I've found the issue and fixed it.
>=20
> Thank you, -stable-rc testing seems to be fixed now.
>=20
> Could you take a look at Iwamatsu-san's tests of this series?

Sure.

>=20
> # I can apply this series, If we have no other opinion.
> # Test:
> #
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/115700019=
4
>=20
> That may be similar problem, but I don't see where the compile fails.

The test failure seems to be caused by something like fetching data.
If we retry, the problem will be resolved.

Best regards,
  Nobuhiro


