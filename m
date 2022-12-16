Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4CDC4332F
	for <webhook@archiver.kernel.org>; Fri, 16 Dec 2022 10:21:03 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.100])
 by mx.groups.io with SMTP id smtpd.web11.9927.1671186061958804094
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 Dec 2022 02:21:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=gj6XNyYq;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.100, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yv7CT/akr4tlNEpYKlZhYlKl10uWSNZUun6AxksI3ewcAic+KElgXLJYi9NlYky4mBxa7aKpkj84nAdpWzJTGKC1RwdqcwJaIWW3Imy7ZoRx1ECRQQJcfj43c79A65vMzbakm0rZ73SVSeyL60U+XFNzEwIRx4dNpLsbdDOPtTMvfqo0AayrocLniHNg9K5KtpJNKkaDw1hJfHMq8W7A5CCFrW+FewW6GIZdvCsg21QHpJ0aARloWbIM93z9gII/NgxihiZYraECMTLf0qUo/8ir9wCWn9fy6hrfLyzf0PjFoGKy668XVpy85Fj7yeC5RKjK8zaxbVMQN/FRgLXpLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJPiDcsMOU9IPfGnR0+b0uKNQzDHBx03QSyQlEh5wn8=;
 b=nm7TV8RghEbVG9O5aCapA5FvgHpABcTwuyKaBYkfivOL1+JTg7Aa8lMihasyMngBy074aFuSGI08NpQu1Zua4kUovGi6shJCFQJ2Sjr+Gdu3rx3SmbZ77TISw6TKAyA7N3Cfji/e1+Mvbx3AvBucEiHRzH5B9y/rVnIaOs70Scjfr8ArmFZAsX9YaghthrBXnMGiPzZL94eGakT7ZSOsHeZ1QDnAg1EK8LqvX3qnqBBQTANBFngugIcdSy1cvP8B2NeW10bOdmpZH5DUve9L3qvyXcx6s9gyP4gTRv3r7CkvmQ1QUFiB71WFpTkWgQepcLKedyfmxBVWcnDQ3LNNSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJPiDcsMOU9IPfGnR0+b0uKNQzDHBx03QSyQlEh5wn8=;
 b=gj6XNyYq3Iq8YZqXT6Gzl09BnlKuVIaOl802597U2zbSnZ43ORF+voynXUPp82AHhgXSacHZ3daG/A9ZP44M1YvMuvA0oDjnZ4IvrAHB8UHHNsSs4dLHp0FknUso0wCikNhPDk0J8jw64D5TA+H+wcWIWSZU0nMT1ba98n15R4k=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TYAPR01MB6076.jpnprd01.prod.outlook.com (2603:1096:402:38::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Fri, 16 Dec
 2022 10:20:58 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::f472:84ae:c3ff:90e6]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::f472:84ae:c3ff:90e6%5]) with mapi id 15.20.5924.012; Fri, 16 Dec 2022
 10:20:57 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [QUERY]: Avoiding tree wide changes
Thread-Topic: [QUERY]: Avoiding tree wide changes
Thread-Index: AdkQ3ZNAHjEi1KSETs6AtIVh9KGqjgAVI60AAABv2YA=
Date: Fri, 16 Dec 2022 10:20:57 +0000
Message-ID: 
 <OSZPR01MB70190830369FB5FE1641B11BAAE69@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: 
 <OSZPR01MB70195709C33AE5168BFDEFE1AAE19@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <Y5w8jFcx0DAISYoV@duo.ucw.cz>
In-Reply-To: <Y5w8jFcx0DAISYoV@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|TYAPR01MB6076:EE_
x-ms-office365-filtering-correlation-id: e2491943-3b83-4a98-ab39-08dadf4f3897
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 zu9KR0sOclHhtr5eA70MndB6wh8tJQ2asL0tkS2N7dKwGXL9NyuUHxuSjyTwUf6LPwESt3ceYvvjL0J8Xk6Hm/aaLVoVctx+6kKtcO0D0RCgJlgh5NctsLFniqXBMkH2zYlVPd5S1nBO0KpL1JKJNsIGbqykHMz+uigJEhglEpHXfZnGhgofKFJC8DxKtkOgwGMcKgLVqysi+D0uKH0KGbq2eG4w7kIJCPRjxJ2jjOhsZTqg6J+vWBnVDAUsrKApGUGXJjHvQuk6HkSPVOO9OqU/WiTBiBTyXPj4lbHLi0eNCXc539f/a4ztmkecX6mq9eiNF9WxWVf0pqw7yBUTClmmPKb8xLhvijHBwaZWQ5J25d9u5v2gjimyLQ9l1VNxv1YHHlXMBZLigpGvDspx6A7xbN6AV9+j2XmW8xnworqaMjgKQEgL/HS8VHk08VFifcdXrznL17/V2O8NDtJLf3LVw/QIGO7sZpj/NHgK/HpI71TBlmvOu923w3f+GbR+WWEFviAGNH4176l/rgxQhmm5sRPpsokN1wSxLrQoCHYusaAvswNEEjiL1IFGveG9RCkVXBX8nECWlbAyCecPBH0/8GplVZ44lUDovKWALXz4mTU93Y04ogkQ3Tm23EX1b/zR5vm4hYuAqAnI5n+Nm20BA38La8h56282JUyGJkmrIe3xQHKnmxEnXcszbcwHEP3jjdI4RnqmaQf2eZRMn9hzEAmePQdVocSanhLWDRQ1v0ejLu5oroutS0aASkya/OyYxHAvfwjM1CAOd3UqoA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199015)(71200400001)(33656002)(55016003)(76116006)(41300700001)(478600001)(8676002)(186003)(64756008)(9686003)(26005)(86362001)(4326008)(52536014)(966005)(54906003)(7696005)(316002)(6506007)(122000001)(38100700002)(38070700005)(5660300002)(8936002)(83380400001)(6916009)(66446008)(2906002)(66556008)(53546011)(66946007)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?SbOyGZvWLeNGh47x3mpNRemB0Y7RNYg7IIYmGwc6I8pg7blfcVuC3XdshtNM?=
 =?us-ascii?Q?1jIlNnSLrSbq4DYiPShMM9Gp8MX2iO4SlxCtCGV774Qg1xHY6fbpPA34xrGV?=
 =?us-ascii?Q?VI/caH6HUb31kE9XReGdfja7yVFeZ5b6qekoxSSbBBJ3Lis7iTkQ6EUy7gKl?=
 =?us-ascii?Q?Aj4irQuhAsEpUrEwGos649hlKNxvkQKntSV2SasbAwx9ATHqjsHkuYJcC580?=
 =?us-ascii?Q?yIu4Exe9kuSa0g8Uce/3Jfm8xwejq4gjIS5N2lR3ojd/KJCqUnBPzrLS+616?=
 =?us-ascii?Q?BL99v+FQ50K6T8UlSvvIfIOU9pTLAwFeNATKZEvXTwUVo2cWKj2Hgrg1qGXB?=
 =?us-ascii?Q?VBcDKgWnYuVfb41uoVCCidabHxHA77vDE6Gb959z3+CzWHXOQgJwwTQoBPOd?=
 =?us-ascii?Q?a0oxBXPYfj5RdqDe8TvxP9eBZd8i1SGLbfH9tDfcTedz5CYHWBwS2kj3iV12?=
 =?us-ascii?Q?PvOOc7Tr5RsQXXxsqpiTaKtvgr3PKZQ7maFRU7HmfQTTIjbqs1KUqlTni9mO?=
 =?us-ascii?Q?ORT5+0fYxDTI5kXa91YpPfuSdB437hFjf71HBYlQeW4/UcovVIW2EZ3MME46?=
 =?us-ascii?Q?mS5RPu100Z4TE/8bnBzgihJZ8Tmscka/CKKIXNvrNn+hovR1r/2dJmw3GRar?=
 =?us-ascii?Q?ftqAWJ+tunBOlmVya522jqa20XoHGS1nrxO11z6lbMEiNfvWSTRHWbaiD9rl?=
 =?us-ascii?Q?6rDI73JcMYJlWNHO8Zu7bcQOQpODLuKg2zM74oy+y8BDWcG9fzgXIhI18wIK?=
 =?us-ascii?Q?gFR+iGPq6EM8DoYv0kJ/m/YL+8vA8n/FYZ/RK+0YGJYEnR8q8NtybsO8LCSN?=
 =?us-ascii?Q?sN+Ii2aXA47ACOabYqWuUHh4mwNkOqF7Ce57yRMng7PvXcTu3MAkiA0uVpEq?=
 =?us-ascii?Q?3+UPyDP8qI+x7m7V2gKvx/UaWvk49tvHN8UWvlX1x7p5uUVd34L+s3sHOA0a?=
 =?us-ascii?Q?aW/St3T4jsHPhdLc1NakXJ9Ed1c/ntCkzRUb7cSMEHDSqrNt2/6s9coaV0Xc?=
 =?us-ascii?Q?6jokWshGgamM2abJZ6wpsJuH3eRwo/yChwT/9f1dg53mrihmtczXM/oT3vSp?=
 =?us-ascii?Q?VaGrO1ess+nSL2POyNsRC28m6uMCT3ZhFeXb5zHXrE30n4G5du6Qx5BQnwUI?=
 =?us-ascii?Q?mSsIhUDrwPzPkqRWvj4FOss7R9nxud6VFrTSyGUquVQ3EyDX1NGoXZ24bToT?=
 =?us-ascii?Q?iBIZbjDqN2t3xHR18PqXwKWttiFamj5dl8OE399fnVCu6YwraZV2kTWXbe/O?=
 =?us-ascii?Q?5B5OWAdz7G0J5yUQJLf38dYhaV7CEZJr0ArnWB15TMiSK+HPuxiOeA55PjCU?=
 =?us-ascii?Q?YmYrrhgb24jTXlqUStlBuOU9O/UNU7U2j6JVgZeGauct00cWi1Mu4txf2aIz?=
 =?us-ascii?Q?IDYeyn6JhhGIcXMWtmjJ55XhUs4MGDlHI4dfRKT3qJP8hSgozr5OAjJ4CaJR?=
 =?us-ascii?Q?LGVQ/N185oHya2ytZrm/g91/Zj91NxXVCt3DFb5z7hWZskkSgGHX2OfdxrCt?=
 =?us-ascii?Q?MBy04cb2LL5LV/Jxjii3qfn/kEHWRAL3dpImRp7X/NoNoOst2R+8p6Dj7U9e?=
 =?us-ascii?Q?scDSwr2kjQ0Kd6UKjig6TDHG67DAoneOWkJsbqIGvA0lmdutWwS0JSP5fJ2v?=
 =?us-ascii?Q?PctVaIpecaGNV5YKYv58qGY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2491943-3b83-4a98-ab39-08dadf4f3897
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2022 10:20:57.0752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4jjBX1wYdWoSIHmQeVWJHLvHARa+n9AVqL8yZ5Wq6ReOquuvMCFf0/W8vv4JsTdYLQH+JACZsBJ+con0OaNHRbhWtMIfPH23o9jg2m3OrdvYWi/oUdQnE0vBvxMZ9gbc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6076
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Dec 2022 10:21:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10238

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 16 December 2022 09:38
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: Pavel Machek <pavel@denx.de>; nobuhiro1.iwamatsu@toshiba.co.jp; cip-d=
ev@lists.cip-project.org
> Subject: Re: [QUERY]: Avoiding tree wide changes
>=20
> Hi!
>=20
> > We intend to backport IRQC driver [0] to 5.10-cip but for doing this
> >we need the patch [1] ("of/platform: Drop static setup of IRQ resource
> >from DT core"). The problem with applying patch [1] means we will have
> >to do tree wide changes to replace platform_get_resource()
> >-> platform_get_irq().
>=20
> We would not want to do that.
>=20
OK.

> But... your platforms are already coverted to platform_get_irq() in 5.10,=
 no?
>=20
Yes our platform uses platform_get_irq() in upstream and shall be backporte=
d in same manner.

> > What are your thoughts on how we can get the IRQC driver to 5.10-cip?
> >
> > [0]
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/co
> > mmit/?h=3Dnext-20221215&id=3D3fed09559cd8be79568d368ce02bf7f2d56259b6
> > [1]
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/co
> > mmit/?h=3Dnext-20221215&id=3Da1a2b7125e1079cfcc13a116aa3af3df2f9e002b
> >
>=20
> Is the change in [0] really neccessary for your driver to work, no? I won=
der what happens if you
s/[0]/[1]?
> revert it on new kernel. Is there chance it will not do harm on platforms=
 with
> "platform_get_resource() -> platform_get_irq()" conversion done?
>=20
If we revert [1] the IRQC driver won't work as the chaining from IRQC to GI=
C won't happen. It won't do any harm to platforms which have platform_get_i=
rq() conversion done.

> Do you have an example of "platform_get_resource() -> platform_get_irq()"=
 changes?
>=20
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
?h=3Dnext-20221216&id=3D228662b074149e16949ab73205ac93b5ca2c3552
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
?h=3Dnext-20221216&id=3D3277e022a1c31f5041753942b3d9006174ca7aa2

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
?h=3Dnext-20221216&id=3D9879c81b680795b45a11894e48dfa9e4be2f4426
^^ and some special handling like the above too.

> One way forward could be introducing of_device_alloc_new and using it on =
your platform, but finding
> other solutions would be better.
>=20

One way is to rename interrupts property to something else for driver [0] a=
nd manually parsing it but that's no good as it will differ from upstream. =
We will have to come up with the better approach.

Cheers,
Prabhakar

