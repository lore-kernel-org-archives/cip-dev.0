Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483A7C47DDF
	for <webhook@archiver.kernel.org>; Tue, 30 Jan 2024 11:58:56 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.111])
 by mx.groups.io with SMTP id smtpd.web10.16669.1706615934199391524
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jan 2024 03:58:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=m04Klqr7;
 spf=pass (domain: renesas.com, ip: 40.107.114.111, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1lgEGdUzyGpU7igc+a2czw0fdu1dsLg44Bxo2M/HDhe3uB97eiVTRj3Z8BQMM4bBnvXEE+oEEmz/PyNjwx5/pyHxh5gJ8Pmuw3mccgWsqzv+iTXytXmOmbQWJAt7JzX1ScEGQB1PD3F5/syn+9AiMiNY8LHD6ajPe1uaKDRC6IYpCSt+XG+ivFIo1Iz1aag8EXzRf6thlm9b8zS4mmLTapIccEw2I+b2EohbyBFVDvMzMBSc3kSPyBSk5uolYsxSnMV/a2aDedjt+j4Hmf3ODaNQ2N/8cKnbr5GEGNm8JNn9GetmPJfkNYCfnC2w3Q8Jz842Q3Cu1u9kg+eCsQDEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mY5yYdXRfvwlsZH8gjMKHgQNsx2G8nXT9NTW4OBqaVU=;
 b=QVAU93aixo4DU6hdCbyq1HMs3Lv1rDtuwFpU+ZC7u8lxqjxds1bXkKF3WqnaS0uAj2K4nXHTxcFR0ycmBrlZ3hLDnKI8yIQ94GWZt/9m/tfzgNL0SlTurz/xmcnoar7oZv5zVFUwK/hgH9IXY9GiW/J8NR1oz+GHe1OMj1mViNFopXXy3q/CDpq7ASRnvUxmdkM8LM/2Fd2efTwAqwOBaHdVYlvqe+Ybeo7Ih3yDV5jiJncoOFOxhzUxuGuFz/8nVfjHrcDk81jXtBO8tKmOfYnsUmp535KnhoUYhkp5ThYDn5sGpLQ2lnKJDzWnzjttsFS8BKiaYqaIUeWu/5jItg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mY5yYdXRfvwlsZH8gjMKHgQNsx2G8nXT9NTW4OBqaVU=;
 b=m04Klqr7R9kUUwjCzCtbvCDRf3aop2jp9gaotxaU2Hjclhs0fL9WlKrfKhFhMzl4R0J98oxwwAUAJb6aGbvtNAZo5OoR7YCRheuK6cSKRutanyG1FqSw4/80D3gk+6i232y7rxwtwbu+mZ/ZUhAPI/vqam1g9K6hbY4pcM/89es=
Received: from TY2PR01MB3209.jpnprd01.prod.outlook.com (2603:1096:404:71::20)
 by TY3PR01MB11241.jpnprd01.prod.outlook.com (2603:1096:400:3d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Tue, 30 Jan
 2024 11:58:49 +0000
Received: from TY2PR01MB3209.jpnprd01.prod.outlook.com
 ([fe80::4a73:f955:2b4c:5ef9]) by TY2PR01MB3209.jpnprd01.prod.outlook.com
 ([fe80::4a73:f955:2b4c:5ef9%3]) with mapi id 15.20.7249.017; Tue, 30 Jan 2024
 11:58:49 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, "nobuhiro1.iwamatsu@toshiba.co.jp"
	<nobuhiro1.iwamatsu@toshiba.co.jp>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 0/2] Add IRQ affinity support for IRQC
Thread-Topic: [PATCH 6.1.y-cip 0/2] Add IRQ affinity support for IRQC
Thread-Index: AQHaU1yAXJizu+cQ2EmWUol2srIimLDyFNVA
Date: Tue, 30 Jan 2024 11:58:49 +0000
Message-ID: 
 <TY2PR01MB3209DAF580A7B848FF2D9F7CB77D2@TY2PR01MB3209.jpnprd01.prod.outlook.com>
References: <20240129191829.45687-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB6388181EE39FC04C88103D58927D2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
 <Zbi9j7QrnxocN+af@duo.ucw.cz>
In-Reply-To: <Zbi9j7QrnxocN+af@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3209:EE_|TY3PR01MB11241:EE_
x-ms-office365-filtering-correlation-id: 7b55eec0-69d0-4135-806e-08dc218ad21b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 6kqK7HqAWx9vdb799WZPazkDTTZpB8athgflLN+254qUMNibWd2vEto8Q6ErHizmPACVHQQPppVtUp80S2sCS3t1YdL3Z+KDQnMsaq082P9b4PKqP8wwhoWfjqZaf8Hcn57bfnyJT992Ve8UKeyR/oo1f+YOsT9ccIkUWXiBZS7dLY9xUG27X/XABKSUFJNwzNq0+qzner7EhUhpeJQKFwXA2kdcSRWQa9B96N1MJNqLTS0I/EQmptcxodMUjVjbs8TLn7xEIrXR8A5Aa6lNBpTG2ZXhSvmC093MQ36aU6BGc+y1ipSuJpemk/2Fd8KGcN5z9uCtJW+kcYEQLpKWXpRp6d7+n9dYvi++w5TuUenpkztmQbI84K9KFi/cYsPlM7Ay63UtgiIhrqOACC95CBDtpnjjT5W/by7//eZGGgAh+Xe3RBQCbZEo3HnflgW2MxO7Ce3iMJGNAbU9RTeExxdgII19v1MPaiKPfbcirY8wsi0DCOdtcc5BupNpW4UMuWeEjNjetAE6tsFiGT5BQMDjBZJ6l4arG1pM/W/QqxekLPj4q7D3+ebfLatcR6mS0GPkI0TRdpWxdbo02zevHdI1PpuIieze+fSvTMDlUD0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3209.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(396003)(366004)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(86362001)(76116006)(110136005)(64756008)(66946007)(66556008)(66476007)(66446008)(9686003)(6506007)(54906003)(316002)(7696005)(52536014)(8676002)(8936002)(4326008)(122000001)(5660300002)(478600001)(966005)(55016003)(107886003)(38100700002)(71200400001)(38070700009)(33656002)(41300700001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?XD8IExTih2evWzYHrnqWqiwDoMH88tNBNr3eNbKu+67ge87P45vG2rsU?=
 =?Windows-1252?Q?wMs0i29wQYiGmhBVJhCLLVnpAmEBItWcOi5rrURrsDmrM1OPWeEMoud9?=
 =?Windows-1252?Q?jl4oa4mxcTXH6LognURkQfDVZa5sKjoJBWD42ZHTgms0RD9og/1mj8g9?=
 =?Windows-1252?Q?BduHz9+ZzAPZkfXRq5AKorsrdMe85xnvg1r0e25doN6U9H0q3830qYKA?=
 =?Windows-1252?Q?vkOuw8XW/bz0Zn5cSQCnfc4UmP1c7vHRKUJuizbnqUMnzsRjfZc4eAQw?=
 =?Windows-1252?Q?AhlrH/Wy9ewDUtHHyVB1QEoh+BgIL/2KGiFApyoGdw2T3MZHt48MXXbY?=
 =?Windows-1252?Q?y19fVnwvbXD2q+oi/gYw+5NAbBDrNUcfJ+YO15Q8nJkBv94ELiOTEpTS?=
 =?Windows-1252?Q?jxXdbwz1Map0TsYr0wqZpunpAvr8dbMbfn3eSPE3ePQQ2V7edKlpohYy?=
 =?Windows-1252?Q?8queNQoYNyJDpLAlVI3SoJgTyZTJV1MoqOnP31iGx/KqUjYEZGE9Z6+h?=
 =?Windows-1252?Q?SCsFqxGBVLVR068/LSAI0sbVbcakSd0ezmHxLD7XKsyOxIAlx2dNSWvC?=
 =?Windows-1252?Q?X4HfZpKJ7kWEUr64J5odZzVQnoUrDidIjM5FO+bOYqPHGhSWSdV7byw5?=
 =?Windows-1252?Q?cUnl8KNAZC3roTc+NAAQI63whJaOdRWa3tklz03xiDrFWnVuQbegkGq7?=
 =?Windows-1252?Q?QG00GLeoWUXLBpv3IndJoMlrh9MS8Qv4NpQLEICtzzC1vm64DtrzlUG+?=
 =?Windows-1252?Q?HSbZekQyGAIVjObNWoOpj0esRB3dVM/7iB/2IFhOqTdoJB+l692eeu/e?=
 =?Windows-1252?Q?dNRwAWJri84rH9dbRFReIPQQpXlJb5/R02SUICk1XzpWKBa9CuEUz1XH?=
 =?Windows-1252?Q?aFHo0AJ4OBe8BsVmmUcfdUl/0TaOAMdjVxFpCk12OfifJerxDiu++nOn?=
 =?Windows-1252?Q?bdeiaIQ//6goPKpMBWwl+K8OVlDlw7pWlEKEfmwfp248qtSPQACBOxxB?=
 =?Windows-1252?Q?I09Zn4lZEG8Ad0OcmdoO4WFmrtPyPQLSxzkUGFk8+9E7NPZuYCJoZAZi?=
 =?Windows-1252?Q?JiDjf8UBx0GBWaxhQUMEYOVz6TX/3A9Xg0b9h4QSSdi0iEfvx9PCIsed?=
 =?Windows-1252?Q?1PPBNMo1LDH+BiOYmBG40rUceMbmP+F1gE89ShNhZVm30vBViDISdGb8?=
 =?Windows-1252?Q?nnpdGcYxIrsIi8vyKd6HFoBLai3fqqwYdyuP9AiBr9Cp7G0+5pilY67q?=
 =?Windows-1252?Q?xEbG0TKN0GvJd9SNqth/arHsO9SL/8HhEHxmGc5DuB209yEQXSwh5syq?=
 =?Windows-1252?Q?8raVBuCRw9I/sUuahlO6IHt5GrdePtf82IVcLVWR/S0cqIUnxHtuzjCF?=
 =?Windows-1252?Q?ROH9sTL736fBOAzQn0F2dWDEUwkEJIHvorz8vIYy0RbEeqBGl34ms2l+?=
 =?Windows-1252?Q?WAnOofyfbKLbJptKXT18NtFMk5PhEl3OjUo8GXWRifPTKXl1OSuCK2JR?=
 =?Windows-1252?Q?dst9qng6p0WDvtKbP6X86vKRWRN/JljvdDqllQMUYY1k/4z8O9c71WaF?=
 =?Windows-1252?Q?4Q95+CKt9r0NKgcpD8mLdcHSCBHLEXBTTC59gyAHerXyr7u4wMWARhaD?=
 =?Windows-1252?Q?azFgBdbNq3KF/rJf83tZulOBrnnU/xm9ulnmgOR2AJkaVknqY/FeAOPq?=
 =?Windows-1252?Q?G2S813gnrzQ=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3209.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b55eec0-69d0-4135-806e-08dc218ad21b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 11:58:49.3675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oxuqj/kri0Lqc3XXX+BhXe7OrZpX9ug6tu5AUDIl6nAJI2QyM40EnF2ncAm64AdxJoxki2z2OYMlsw9twvOr1E/a7PBiCib3xUOkXVrPr4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11241
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jan 2024 11:58:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14495

Hi Pavel,

> From: Pavel Machek <pavel@denx.de>
> Sent: Tuesday, January 30, 2024 9:13 AM
>=20
> Hi!
>=20
> > I reviewed this series. LGTM.
> > I can apply this series, If we have no other opinion.
>=20
> Patches look okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@ucw.cz>
>=20
> > Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-
> /pipelines/1157000194
>=20
> But the tests are failing, as is 6.1.76-rc1 test @
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linu=
x-
> 6.1.y
> .
>=20
> It seems to be testing problem, but it would be nice to get the
> testing fixed.

The job that failed was an arm64 defconfig boot test on hihope-rzg2m, due t=
o missing files in AWS S3.
It turns out that this was because the actual build failed, but GitLab CI d=
idn't realise.
I've found the issue and fixed it.
Now the CI correctly reports that one of the modules isn't building for arm=
64 defconfig:
Job: https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/6=
051686728
Pipeline: https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/p=
ipelines/1157421884

Note that the same bug was causing a false-positive for the latest 5.15.149=
-rc1 build as well.
This is also now fixed, showing there is a dtb build issue for arm64 defcof=
nig: https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipeli=
nes/1157441161


Kind regards, Chris

>=20
> Best regards,
> 							Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

