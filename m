Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E72DC433FE
	for <webhook@archiver.kernel.org>; Fri,  7 Oct 2022 08:45:53 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.128])
 by mx.groups.io with SMTP id smtpd.web08.2212.1665132347801223943
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Oct 2022 01:45:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=iWiTjkAi;
 spf=pass (domain: renesas.com, ip: 40.107.113.128,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5XMKA0ObOtTQ5TkSWrMSEnSKRwGhZJw3l6CguBbedOcqaX81vYtMADD8t+nAtuxunLGHwaBidntFT7TylR2SqRY+PYLAwoOI2/AkWxbMg0FzoCOMea9iQ/LsuSn8JtRNgamZ3V3qD2BFRuiHxZlCjt6rla6fS07kJ7Xda7IUvjiWp1E4ntGb9j6Ny0v9irZy3aX1GRksgXQLP9jRO3G1MZiTCbBPDZ9fmFl8BOo0mfBYzftGGWv2iTsHXMnfWEnkIltYHfsaA/CDFxjjdczn9kVAd0MRhAZf+tdXacIOSJBOvzeHCPwNA1LzjlRkPC+fNYUhQZpYDwIlqagG/CS/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8eDd2zFSL9dRi85Ngtqq+jWablu+3iDOn5Ohv6O5M0=;
 b=jVkmv23Pz9OonyM0OwwAh/0wC1su7qLBZil0Z482YP1fuU5dItPIMczXAjzXynCjtkkqMHvOHCJLq5Ujq5pV7x4irA3ogbINXTOw5EgE1/85C7B8dzQnwZpay2A49zTkm+bm+t+taiqCGR1w5dQ7qikeuUgDDld+UFWLGPSVksS5f3LmsMaWjl1qB9eo1XvNHxaxfZC4AjLHyT8mYpu+9U+DZQBdBgbahJF3KrmR8DvPt0mj93KD6adDpo1Zrpq8zUSXJd/d8fJQ5u/iTNizReIfgcw7wj52RbmSH8SUAdguJ1HlVEIXLv4s765IprXosJ/78MNd4IDq4yD1L8sznQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8eDd2zFSL9dRi85Ngtqq+jWablu+3iDOn5Ohv6O5M0=;
 b=iWiTjkAiQ4ZX7sdpQQ5sr9Q0KuW4/XxH8BzpY+n+Ep8AK5xnNKgtRrJZwrDHxC5pFq4WrV8DPnDIaNftj7YSsI96IqD0k3QXZdUIxOeMypjWSSfmkfzwdurnNnC7D4yWWhf2VPTteQsqLtdaP3fo2bbeNPFsWhVsNe++T9fsnBQ=
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com (2603:1096:400:309::8)
 by TYWPR01MB9740.jpnprd01.prod.outlook.com (2603:1096:400:224::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.36; Fri, 7 Oct
 2022 08:45:43 +0000
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::f7f4:7059:2c92:75ab]) by TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::f7f4:7059:2c92:75ab%6]) with mapi id 15.20.5676.039; Fri, 7 Oct 2022
 08:45:43 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Michael Adler <michael.adler@siemens.com>, Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"alice.ferrazzi@miraclelinux.com" <alice.ferrazzi@miraclelinux.com>
Subject: RE: [cip-dev] gitlab test failures -- job failed ... pods not found
Thread-Topic: [cip-dev] gitlab test failures -- job failed ... pods not found
Thread-Index: 
 AQHY1LqD736Cemy9y0G88cTlOE3pAK331CBwgAAI/2CABgYSgIADZwiAgAFAkACAABeR8A==
Date: Fri, 7 Oct 2022 08:45:43 +0000
Message-ID: 
 <TYCPR01MB105886D9FCFBCD0D2338B3037B75F9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
References: <20220930105048.GA19081@duo.ucw.cz>
 <1719A05389EC9CB2.16804@lists.cip-project.org>
 <TYCPR01MB105888A4C268DD3DE0F5481C9B7569@TYCPR01MB10588.jpnprd01.prod.outlook.com>
 <20221004075301.etgur4dyb5dtrcct@backstein>
 <20221006115033.GB21855@duo.ucw.cz>
 <20221007065754.fysie7e4j2bvrvck@backstein>
In-Reply-To: <20221007065754.fysie7e4j2bvrvck@backstein>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10588:EE_|TYWPR01MB9740:EE_
x-ms-office365-filtering-correlation-id: 9f5d1eb6-ec81-43ce-eb5c-08daa8405200
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 kGzZKG9C54f0wj9pT14IbSfNfYFCgyTXxMyCWwf1tgf9e0tYNR++ZreGG4L7pfCqxzK82s77pi8h/EP0U8KX75n3av/F+ooDNjKsxA+U7P/rymnsBaZGhAXvONO7qiOHImnuUlZ4lKk6oikuKIBFxo/Y6v2ftcYmNY6ekcxvBZuPIIQYF4hrhj6oA2LA1QBYua4IcN886kRfKw+8Yp/JmzqYW6nTT/H4GI/9iBaCpxEivfNDpAonjdkHHdqwq8Vh+C8G5unHmeM8fcDbKnJq5JNkSggOteq9SNwbnVy/2q23UDNgyfwIL2e11pfpt5ZzDO3iHWjViE0V/z/gf2x+18/tCfjT10+6xx4c3Yt5mtIrGwRwCXo48LQslJn9RrrW4ARRiHLWwNMSNMH0ei5CizZwMernmLdJ2gF8qNvlCK60bhbKonLrLLVDzatfH4BLTfDtdWMo2J2GpFpBH0WdYTDKTrFYSE3Cux3yz5CwLcdSo/eMmsa0TPAt0wUn7758BldZhQaeFkqyiL9ukaKR7vzzAF9+qpE8Q2wo53N9qIB91RIfDwTYVJHnCbgU0ccXRe/6QT70cjwOdvgOCRwzp5/UoG8zy5iYBZMQntNpL7hrNGf2SNjn/KZBMFnV0iwzSpXWekjGp2QDG82NFsiDXhi27S4soC/Zg1N15LNek1qIubEn4RDsgKXOWQ44Q7l7izkMH2TRlRxW5rT5jLWWi2az9+7L3EGMLBbyYF1PoUklRSJsGuybCFYobvdXeZM/9DoHkhm+JE71Kx9Dt4fFXuxOlTuXt4ZWaDHKVQcWn3ei1mvehk0XSgWBcRJ5v5CDawhNngSJeUBVJwYYJKoYLg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(451199015)(33656002)(8936002)(76116006)(4326008)(66476007)(8676002)(26005)(9686003)(41300700001)(55016003)(52536014)(66946007)(64756008)(66446008)(66556008)(66574015)(38070700005)(38100700002)(5660300002)(122000001)(186003)(2906002)(45080400002)(71200400001)(83380400001)(86362001)(478600001)(7696005)(54906003)(316002)(6506007)(110136005)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?sLQvTT32i/VeNTAShn5dl5os00A58zEq7E/FkXXd+oPA2gUIy0VxPZ9a?=
 =?Windows-1252?Q?CGu8siX4PmUpFPx9lvAdKH+A+G2OeWetNpFsjS4i+qIcxni16RjbhAck?=
 =?Windows-1252?Q?N4YYiMNy1+GpyiYSgTrW4HyoWVIHzaooujii7XFSSCh7XhfPbJzu8gkn?=
 =?Windows-1252?Q?eIvN9EFhV0SwfrLgG5HxjCkW1M6cvq23aY5OgfqI8XCQj2XtaG0BNQXG?=
 =?Windows-1252?Q?w9QBGrzm/WqnJQmHEsWgSh+BRwUWzY4Pf05/99Cyd/g3SheBOu5ewceH?=
 =?Windows-1252?Q?RtUeGPofrd1bSiALFSQlQy+Plo8ZVYCL7j/F58SJDvqxVDZN1P4fhzZ8?=
 =?Windows-1252?Q?9YMbuvq1kGBeKE+qt4XJnMt3KABOlquzuwiblUp2YGhcYd9NAiWBc24D?=
 =?Windows-1252?Q?9KVTrh/oJ5onEm8Bh25Qb0cZeJoPW4aUKjzsPLULVpjvQHIXptXaOjwK?=
 =?Windows-1252?Q?iolpkH+pfxkV79EPUTekqtdOIje6T35YGH/9/veKU390oeiqx2P802P0?=
 =?Windows-1252?Q?Tdn85S8FpwF1iuBX0wgekXZW9wO3T5uJ+ccD70WjMLgDJfnubKR4GiHK?=
 =?Windows-1252?Q?+u2KJNdxpU96tzcp5+eM+daJrkhhVdoaWKH9a23Ueoo6KhM+WQrbbokX?=
 =?Windows-1252?Q?tUypSnBTymqq0nOgmr9+1lftrub4bfsL4jtikgrk2JsFE03+6KR+XTvB?=
 =?Windows-1252?Q?mBKOiFEKIASjNJhWVKgaK/WD0pC209YRcsHX5694i/pjlnldpdco3Ztx?=
 =?Windows-1252?Q?x0cNcaXLI5RiMmofxGaHOW/0h1DiKJ+5KLatNNl7IOVGHjI3eRXINL21?=
 =?Windows-1252?Q?1JdIYm9jPTCLQAWcELo+zQiboqFmC3+JgbPn8QqZ6LnuxLkVbXLCWxnw?=
 =?Windows-1252?Q?F136nNdTLCp1D+foK3zdBoSPjlD0sVrGmcouV1XNKEpFPmgDwFgMcAmu?=
 =?Windows-1252?Q?Fvwdn/ROKUIbHHieAAyrfV4q/pqbes055DWHClv9hByvd2Bmdc+fkEHP?=
 =?Windows-1252?Q?tFDv7s09XHVrSv4tUTcct7U6T/RUQGYidnoD/By+qSwPgVnqulGGRN7t?=
 =?Windows-1252?Q?ZPhklkw7qwy/aVElEXe3AI6dGHcIfs+oFmd9r0Mh7o/VdY4bOIh9Iw20?=
 =?Windows-1252?Q?IiZbWTKxvH9hy/IrA0hhsrEdAt9BLaXzPW53rkRymQs4ZF3dCHVziVza?=
 =?Windows-1252?Q?usfihBr5/o6bgQ3DCQ0VIlHQ1GIT5ZaSlfUigN4CV8ue1EI7LUMSZyBy?=
 =?Windows-1252?Q?leJocBnOPGqSr9oleD2hWIi/KSoggAqapAHW0VFom5LTZ7aAPLecPUvD?=
 =?Windows-1252?Q?6eWTNeOsCSlEb2oPtN1XdLGYDkbKhRSqqKpxkWIwlqroEY//+tsTWoOB?=
 =?Windows-1252?Q?mv92k9/foOYmPzpYXSbHydHjrPiWp/4cvhaQBwZ8qDHMKVN4cCxueBDw?=
 =?Windows-1252?Q?wa9fUaaQHgSe4rLmM/xT8tsZeJ6AIDBDBzLjZNqO62+HDNGGoo8m1VH1?=
 =?Windows-1252?Q?xM0NgstTlTfITh3mj16OalQ4VgRftRxcgBTuRkJkzgucw3e2E8xuCACy?=
 =?Windows-1252?Q?eViFN10zyFcYPDFL+kviVTeydrQTlFiG5CpsVxx7pveIkGmCNxlAX/Gg?=
 =?Windows-1252?Q?HUUuwFJQ1Hjv6BZWIFOWuYrPzoGXs/ef59hfbXmtqv3qhZSPoV8eitaF?=
 =?Windows-1252?Q?x9XkeBRm34iiYUfOCwD7xRH9fl+TYzBqbOIL1uBieBvd4x1wK5sNzg?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 9f5d1eb6-ec81-43ce-eb5c-08daa8405200
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2022 08:45:43.3355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 cMz+cJpu0PA7cjAfdhFLbw46A6v4q2fRPwEKhHnu/JNhNTJBEYj+uEogTYMDbYwywJB+1biJBpDMcGkeCkMLW6M+OLTfsfyxraerQQbXZ+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9740
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Oct 2022 08:45:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9670

Hi Michael,

> From: Michael Adler <michael.adler@siemens.com>
> Sent: 07 October 2022 07:58
>=20
> > Still there, I'd say:
> >
> >
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b
> .com%2Fcip-project%2Fcip-kernel%2Flinux-cip%2F-
> %2Fjobs%2F3123103311&amp;data=3D05%7C01%7CChris.Paterson2%40renesa
> s.com%7C6f9f909bd6244ce82bc908daa83148bd%7C53d82571da1947e49cb462
> 5a166a4a2a%7C0%7C0%7C638007226871934080%7CUnknown%7CTWFpbGZs
> b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn
> 0%3D%7C3000%7C%7C%7C&amp;sdata=3DzxHVVXOY0Xdh4qmQMVWTK27n47
> NeaESoLEaW2ho9Eyw%3D&amp;reserved=3D0
>=20
> Ok, I have restored our previous cluster (v9). Please try again and tell =
me if
> the problem still persists. If it does,

I haven't seen the issue Pavel reported yet, but it'll take time to be sure=
.

The issue I was having building docker containers for linux-cip-ci _is_ sti=
ll present though :(
The jobs get stuck on "Cleaning up project directory and file based variabl=
es" for some reason.
e.g. https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-/jobs/3140519=
507

From some debugging it looks like this is only happening when we use a kani=
ko container.
I've tried a handful of versions in case kaniko has broken something recent=
ly.
We use kankio for building the docker containers as dind builds using docke=
r weren't working in our setup.

> then I'd blame Gitlab I/O otherwise it could be a regression somewhere in
> the K8s stack - in that case, our best bet
> might be to sit it out.

We need to find some sort of solution for building our CI build containers.

Kind regards, Chris=20

>=20
> Kind Regards,
>   Michael
>=20
> --
> Michael Adler
>=20
> Siemens AG
> T CED SES-DE
> Otto-Hahn-Ring 6
> 81739 M=FCnchen, Deutschland
>=20
> Siemens Aktiengesellschaft: Vorsitzender des Aufsichtsrats: Jim Hagemann
> Snabe; Vorstand: Roland Busch, Vorsitzender; Klaus Helmrich, Cedrik Neike=
,
> Matthias Rebellius, Ralf P. Thomas, Judith Wiese; Sitz der Gesellschaft: =
Berlin
> und M=FCnchen, Deutschland; Registergericht: Berlin-Charlottenburg, HRB
> 12300, M=FCnchen, HRB 6684; WEEE-Reg.-Nr. DE 23691322

