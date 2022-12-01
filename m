Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50C8C43217
	for <webhook@archiver.kernel.org>; Thu,  1 Dec 2022 09:19:10 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.115])
 by mx.groups.io with SMTP id smtpd.web11.38564.1669886348628362901
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Dec 2022 01:19:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=p8WEh8Ea;
 spf=pass (domain: renesas.com, ip: 40.107.113.115, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKLRdD3uTAEvGW71xc4xpbMWFS0C+96h8/1Jem22P2a5mT0ShN0b3+VasxSYr1VAdAtyIiQXtI1vehKSA4WGNnzqY3b0EhWFlHVioaIYRGg+KDoL3Myu+h/iT2VWRH8BnmUExU0aOGW1aFWeyWwhDB4/W9Qkixzsx9naxIuNiMKdigmsKS98EWSRqedjgpgB5DpvslXCVX+scnML/NIbtepCfwQYl88lWmBnnlCKffHPq9Ynp3sa/WfbncNezPtSIqhLMotgNT5keCg/3A28FwOpl4pLmxhAWAYoUcHQck7V4xujGSjZGmE5B8hb8iSVJSAZtC3pNBd6vJYZsgPonQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7JfZm8Wrtd6BGF8wdZ/xohORrcxJ7pLZQO+REI/kuf8=;
 b=n//9IiE5iZA/dBCzY2Eu6IBJLTCqYiV00o7DC/NQ57L0nLrymfHxCVMe3zgG0EeoYCg1ezuJcoiXokx7NFxomN1UiWFQUqeFE1N1Fo6EC3hafSVoQi/sI1yLyK4VB35Al+ZmB//YN7ku0f0DLcdFGvk2cksiHUpcvqrYdLnzQsy1HkuNa4pS7H45JxlrSkhLjUPYPPcrO7/hA2Joclq61fFid/Bq1sy6IO1tL9qk/LPPQ5qXN6CaSALJZ4oISnP8R/cMvv1ifo18QQ8u7RZ85wnJWddBT2HrBQgpqxwFHDij+wFwM7OBJHzQf25xGlzGOxyfAwfvMf9QnqDoXQztmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JfZm8Wrtd6BGF8wdZ/xohORrcxJ7pLZQO+REI/kuf8=;
 b=p8WEh8EamkI9OciCjUW/NT/AW0v9T5u2czaY2MVoQMhGI9U8BM2nsyj7o7GT3o1Hs8rgjK5ZVOg3Ep1ylvGKgn0xG5DEd0VGJFVRjbBitoZCIwLi1H2b/cJJX/PAh4wEslBpsH9uqyIzg1UG28R3os8WjFDsLSYaPZp4rEcpE4s=
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com (2603:1096:400:309::8)
 by TYWPR01MB8806.jpnprd01.prod.outlook.com (2603:1096:400:16a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 09:19:04 +0000
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::a71c:a2bb:affd:2293]) by TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::a71c:a2bb:affd:2293%8]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 09:19:04 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: RE: [cip-dev] [ANNOUNCE] 4.4.302-cip71-rt41
Thread-Topic: [cip-dev] [ANNOUNCE] 4.4.302-cip71-rt41
Thread-Index: AQHZBQb1n+olfJ1SzEe/vBr7AvGaxK5YL/4AgACMKYCAAAHVkA==
Date: Thu, 1 Dec 2022 09:19:04 +0000
Message-ID: 
 <TYCPR01MB10588B8990D584470ABF8C379B7149@TYCPR01MB10588.jpnprd01.prod.outlook.com>
References: <Y4fSIdKnyVeYN1+D@duo.ucw.cz>
 <TYWPR01MB94201038D0EAE900A607518B92149@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <Y4hsv1cMA1ZvoY67@duo.ucw.cz>
In-Reply-To: <Y4hsv1cMA1ZvoY67@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10588:EE_|TYWPR01MB8806:EE_
x-ms-office365-filtering-correlation-id: 1af389c0-78b7-4f45-f29c-08dad37d177b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 WOCqnTQ/DYnWv9saSqmWmOeqBctTAeDOBV3D16LYfWY4bniI1Tp9tncKzQJsCdAURY4sF4gidqKtVu3cfaiH7xGuUVXocHlu8PTkbEVysHZDmLylt8udv1t5xQBOt5XBWfp7arlITRT1eFUNS7PPRusH2SAzIlhp8CWQFW/i9aF/285ZjrmWYznimDH4E8vDJYWeC/+iwLMh8K3B2ofpIiCAIaQxsf0ssa6KYDYWqWrQABhYfb3Yn7uHYvve6A5xzSpddF6gVZ65ht4EXYb4UJ5tQV6B1kRvfxlecLReFYC7taO2LJVFBM4a3ZwIXXAlBreS42LJ7gzsPq0fDD2j9CPuM/vsOG7zEQgdIEgQTxWC8USbHCOPkr4WtSvHUO2C/1PRXBsVhBMCAKtSksll1zoyKmuvKXPBEoxKbV/bCUUx1xhsejVKQhhX4HM7HVnOsGA+Ajl9YY2u1GeGGfgDGr6anGf6xhNhS71tUWj87ClWcTZmlF6TuOy11iEmhDpsDdq0jqix5vA/bh8AK+wcgRcqknmweH8bpBnoscBDYp8qEQu7rDv+ubyL9vs3kkZV0f0U0Dozj9Hh+uzqs6xTDKG8c+/T3uu6UZlsT+B6VrCJJ7ti49YScCRIZKN6xWyL507DkyWjnVEOO36FGir6l4HW/Djz1ZoK43onMmxxh8MxFhWfegj7y/u3q5Jz/F5EEaLsvLlqMnsk0PnwAOD01puUzK5PXBzNl58yAzkdEXZUFcWm86Vv3rCKY4NDsN8UA1NCbFXR8tue1RbvRy48rQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(451199015)(316002)(6506007)(7696005)(966005)(86362001)(478600001)(83380400001)(26005)(54906003)(110136005)(41300700001)(52536014)(33656002)(55016003)(71200400001)(5660300002)(9686003)(4326008)(2906002)(8936002)(8676002)(38070700005)(186003)(66446008)(38100700002)(64756008)(66556008)(66476007)(66946007)(76116006)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?SmKrczKSuYbYPTyuVZhcgALLd0Ih1KCWkUJHsY5Dwl/8FlEfDz8WxwGk?=
 =?Windows-1252?Q?WbVkHlo0YGHzk3fZ24zvzqUuxt3sG2R9ZyfTu4o9xRPdhWRoVwahlkIY?=
 =?Windows-1252?Q?cj6uoHuitCq73W10SkoHavNZWwlrw8C0AyfvnDjO3HRRS3VvAUoLNKK+?=
 =?Windows-1252?Q?BbYzzCB70JwCqz3yuoru2fIyt/FsEN/5HP03sMZRhWXdu3ug9HB9CFlo?=
 =?Windows-1252?Q?iAi2aKxLi9hpjmfaq9RUyOsMcBpmewjF7OjMZaBzza2NDkSWP1R7UWYf?=
 =?Windows-1252?Q?wD+XeWrnf3fsQg4XRlKeyCLsuIfuoaaADa8cMWZwJ30IZrj7RQDuYJZj?=
 =?Windows-1252?Q?YrCbXDU73LUegOpICPou7Z4haJltYFmu1ngZfMgSU5MLJnZkEMPh5x/i?=
 =?Windows-1252?Q?2TspMxTXAljz8s0IF0DCaPprijuR+Jr/vGbr1eJcdmSIuW/LxaJhpQdy?=
 =?Windows-1252?Q?3QmoJelq3i5xmUFH894nCSm1gdZG9AJudICGhW1VbA/wEuy/gqrUZ46p?=
 =?Windows-1252?Q?riLsFsWrCclaA7M62KFYlYGf/0c1nAGOAibn2mT+DUqruJRSnPxQvYPz?=
 =?Windows-1252?Q?c+VTLuCmKxL3EwsSzXUirTqGUxMr0GymFU1/Kmf1fxr6fScTsJwYbWhF?=
 =?Windows-1252?Q?+C2cS6pq23Kn+70GhpxJzJ6kzrtPAQ9+GMq/IYsxemT4i4+ega6Ctya0?=
 =?Windows-1252?Q?DIQ1q9/Pi3NZcDFpQkdh9ebiG1VD/URAUbls/Zy04DiM+W6nYfvjfbiE?=
 =?Windows-1252?Q?ygueBQ+USNvgwkYaXK7RMS0wjzvvXN/hhkPPgLjLt3Ux94vaMhhzpHZY?=
 =?Windows-1252?Q?o+2eR0tKj71vna52bCHe+zkaXoXg067KmWZ/4zAYEUTpN9QPneB4onm8?=
 =?Windows-1252?Q?SNnVbtp0af8183FH3cgfe92W0pb5cxbIwDbqxYHJdgGS03Q2nalQE6mM?=
 =?Windows-1252?Q?b5vdu0FQZdY2haj3zcEGXyc73uX5BAeHYt8wuSwtxvGxHlxgTsIYfgaF?=
 =?Windows-1252?Q?pkRkRnwS94tHeiN2DD/NDXIy+QmOijolbwf42OQ1lQZv5ozEvilytewJ?=
 =?Windows-1252?Q?XdR1ueIF18FVSryy81cMbkRisxBohT2AAg21uUu4l7ojUdKd7lyV/csf?=
 =?Windows-1252?Q?IU1WXNcg+RHiKOqnHWgpIhyqd00kGBuM9xTIJyx1mmIIYCZ6jDWal5yw?=
 =?Windows-1252?Q?/IMqEYAV52Sefp5zM59z25UNnjvs3F/XUmg/LTeNIzEWcd++TtrlwYmQ?=
 =?Windows-1252?Q?y7cybHft4ycpel9kgbN08pjcpOEPM3u2xPjNP/gd6Q1ntaS7tZGxpeGV?=
 =?Windows-1252?Q?9vRej1I9CrmiKMrz/Ws0QMrS3LJbb/ipXbUWMA+bov3VWTqAnpOHUJue?=
 =?Windows-1252?Q?aH8rq8KVCUSv4imZ/JyQrHf/Cjb0dxZDzISYd4NjnjCpZ6keWHR1S0KQ?=
 =?Windows-1252?Q?DSoi0UfLYwqMrO91xFo5SsavHN/grCjjHta0S9uLaGP5lF4iA3GjYsKr?=
 =?Windows-1252?Q?tl+6qUnSinkt2PXS77CxrGziebpjPSkW1/WpO183UVtW1DIu0aDR1Nb4?=
 =?Windows-1252?Q?SeV+5X53IL9ejaZ14n3AFXqCdi/qMeSuo6byVVEVKYQJPrkJUlAAFRgN?=
 =?Windows-1252?Q?lw54XvYP0DXxlJHoLddFahfT75sZ/fpm+5FQqM0Dr3ZyqRZTr1d+H9gh?=
 =?Windows-1252?Q?LRFjm+BfXVWO8PfTyavNjmmt+0s5VEOLjIOwnitQewirG6lAtWLdfA?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af389c0-78b7-4f45-f29c-08dad37d177b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2022 09:19:04.4249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xaE0lum/mPV86JwmZnBQQsZDcJ45yvVx9GQQU4pXQeE9nWeIXYCnRocH2HeV9WXKz2Pn9Xr7jcZgeziLEUX8FYKF/MQI4CcgTyGu/KdSKt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8806
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Dec 2022 09:19:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10151

Hello Pavel,

Thank you for the release!

> From: Pavel Machek <pavel@denx.de>
> Sent: 01 December 2022 08:59
>=20
> Hi!
>=20
> > Thanks for release work!
> >
> > BTW, rt_x86_siemens_i386-rt.config is the build error.
> >   https://gitlab.com/cip-project/cip-kernel/linux-cip/-
> /jobs/3405080634#L4519
> > I'm posting a patch to cip-dev that fixes this. Please check that.
> >    [RESEND][PATCH for 4.4.y] extcon: adc-jack: Fix incompatible pointer=
 type
> warning
>=20
> Yes, will take a look, thanks for noticing.
>=20
> I tried to run tests before release, and they succeeded
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/709907648
> :
>=20
> 1) Any idea why my testing differs / how I can properly run the tests
> for the -rt branch?

The CI pipelines look at the branch name to determine what builds/tests get=
 run.
For example [0] , RT build configurations will only run if the branch name =
contains "linux-4.4.y-cip-rt".

This is why Iwamatsu-san got a different result [1] on his "ci/Iwamatsu/lin=
ux-4.4.y-cip-rt-rebase" branch.
It obviously leads to lots of "ci" branches [2], but it does make tracking =
build/test history for the different kernel versions easier.

Would it be possible for you to switch to a similar approach?

[0] https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-/blob/m=
aster/trees/linux-4.4.y-cip.yml#L130
[1] https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/7101407=
50
[2] https://gitlab.com/cip-project/cip-kernel/linux-cip/-/branches?state=3D=
all&sort=3Dupdated_desc&search=3Dci%2F

>=20
> 2) Should we have config similar to rt_x86_siemens_i386-rt.config for
> 4.4-cip, too? The -rt bits will not apply, but we should be able to
> test the rest.

We currently have two -rt specific configs for 4.4-cip, renesas_shmobile-rt=
_defconfig [3] and siemens_i386-rt.config [4].
Both will get built if a push is made to a branch name containing "linux-4.=
4.y-cip-rt".
RT specific tests also get run on renesas_shmobile-rt_defconfig.

[3] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/blob/mast=
er/4.4.y-cip-rt/arm/renesas_shmobile-rt_defconfig
[4] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/blob/mast=
er/4.4.y-cip-rt/x86/siemens_i386-rt.config

Let me know if there's anything else I can help with.

Kind regards, Chris


>=20
> Best regards,
> 								Pavel
>=20
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

