Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94603C433F5
	for <webhook@archiver.kernel.org>; Thu, 31 Mar 2022 11:29:09 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.120])
 by mx.groups.io with SMTP id smtpd.web09.5863.1648726147178139057
 for <cip-dev@lists.cip-project.org>;
 Thu, 31 Mar 2022 04:29:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=CCYRr9u7;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.120,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzCbkPmxUVZNMv+27FxkBjaJft+ei/vgnZLq5wWG6nOz1Pw1QzarmSQv/W8nD2MV17/Ccu+Qr4AICJJs0ig+PogZg6bNsTk8TuvmY2dGsMjbUoI0Ku7abdK0PeqZco7T0/vRKW7qegsLan3kUfkiihW8U9GQvSTITWCe/YDYcgeQ4s7kV4wvakyNq/eTKAENtGHMaPmvKs4Jn/s5DQjk/8u5x6IrCpzXiRzmT3yQoC41bazjUq58ttTjU8mEw0nkd2KuT3uzvnor2MlNxJ16TCWB9kzq7NT0BYMlqawEa1TRnDFwgWVVLi/NPoVPmySMXacFJANEGWJeAJXWhEedkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NN92ewuZfd5vmw/ChGPkvw1Aw0RpFOq8MYsDs5WgpO8=;
 b=K9fe6c0dCKbqCKWfTkaQ6mmLQm05oLQQOVzB3GfVYmK3QkvKty0uLYvf6jL/5PRau3chO3dPjuDiKOrbg2f9JJtEIxukDl8N930OI4RPGiGnzMAmeX3qSB3DhdXmgxbYI8ad/jVZQZ307mPKaWkmr1QQFmy1m2TIPBM0oo8hW3bg1wYR7/mGlY7S5Up73wMsotjE4Nl3D/X6+dHfGHrEnZ6rNiDnLWeceJRZjjxxQoBDeX00RNu/DxrptXzAChXJYUov/9XNVNLc6umFylyyIRbq1aJ5IoqZOMkGzQocEGrBsPMslpM6YMcZIhoxtORZrIiO9yVejZONqDMwkxAKiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NN92ewuZfd5vmw/ChGPkvw1Aw0RpFOq8MYsDs5WgpO8=;
 b=CCYRr9u7uv73kmf2gfiR6XkYMFaXAl7AZ9vmKHxAsVsjtpkJRNyBKvE4vj5kLsZ0rg/HKrmdIDcTQAWVz38iA+qMa0SRgrtNU/BjCY1x3gGAzjW5l4r5/HyfC0tQPtnh8WuYb1qPej19p5T9uTagvKRWyFPuPL+E5VE2sWxGcX8=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OS3PR01MB6564.jpnprd01.prod.outlook.com (2603:1096:604:10a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19; Thu, 31 Mar
 2022 11:29:03 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::9dda:1c9e:4a15:bddf]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::9dda:1c9e:4a15:bddf%5]) with mapi id 15.20.5123.021; Thu, 31 Mar 2022
 11:29:02 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 00/39] Add SD/eMMC support for Renesas RZ/G2L
 SoC
Thread-Topic: [PATCH 5.10.y-cip 00/39] Add SD/eMMC support for Renesas RZ/G2L
 SoC
Thread-Index: AQHYROGhzuvU31rZKEOpst2SCZ9dx6zZWZew
Date: Thu, 31 Mar 2022 11:29:02 +0000
Message-ID: 
 <OSZPR01MB701991610B34316CAB5B2D90AAE19@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220331092808.GA20092@amd>
In-Reply-To: <20220331092808.GA20092@amd>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b13f01bc-35df-4d35-24c8-08da1309a843
x-ms-traffictypediagnostic: OS3PR01MB6564:EE_
x-microsoft-antispam-prvs: 
 <OS3PR01MB65642CEC3EB62C87DE1479C5AAE19@OS3PR01MB6564.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 f8O5rHuhNedAxXaGizzCJvWQNqYXK7CE8K85WTKNmtTI/Ofo0yhCDkSmDiuTGAIaxjVHcgJW6m+Gkd9P3+urMIKDAAUFK6GjRImKJOeLSCifmBMr2Gyy4UK+AseFAsvAxnK+5TxTWEHWUGqm/sDSEuhV6DzVPC5Qr5RJBu6p7fYW6CS6nN4o/CuycJ6PlqMYfshyYEihY4BdlTrXv8rNb5r0AZJzwQXH65TyPP+rMpTqEqRfFRXZzUxhUzpEtWeL+1npyOP+5Ddjhe3OIBovabpSxgldrJF/V2rx0UxqaTy91whexwY6cJV1Ed5NMCy9rPVq2BYxH2GeMuZhayDljMi/P/xvco2fw/n207ox1AiKij6gRaIP+d2noTfOZgDBdYLErNIqITkGBHCpS8zEXkWQZLcIKtelFJMFfTvGHoKxC/Izz7BI+NZ6IQTp4fKB1wFS0dh29rrHQelTlfJX/bOXzzwE3q+7M1xbXVB4/DRuWc9WmKtaczoar4trXoYOg8jdUtn9dIWH6dBTNxNwnolyILPBmLiaO2CKjTY0FThMEVJ9mLkS1R3QzK0ySlSVhRJHEa0x/9uIzdj50IedSu3iNA6XtDRhAg/9jK/hpEr+Ilm2PLcXMf1kgOZOCV4G8mWg5QKUPYNub2XAnC3CShmpN1nt1B0LsFM/2d5ZLdKHGozPfoetx9DkxyQzMQwz
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(7696005)(4326008)(55016003)(8676002)(122000001)(2906002)(9686003)(6916009)(26005)(66946007)(53546011)(64756008)(38100700002)(66556008)(66476007)(33656002)(66446008)(76116006)(186003)(83380400001)(52536014)(508600001)(5660300002)(107886003)(38070700005)(316002)(86362001)(71200400001)(54906003)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?b0vxRIJ737TbUf1Y5Lterwq7C/9Uo8LlfOUESEobg48mdlZsVbr1kh2a7Uiv?=
 =?us-ascii?Q?Yue9DZAvdsgjrxmXQQenQlOqe0cULzAxgqAkCJZYtrRQ3DX/+xVrFWcBDCYm?=
 =?us-ascii?Q?8nHgPFYeutCwEjuQGCUpKS7+t4gH3e0UiAoZqpdK7PPXHHVt3Non9AzoBhia?=
 =?us-ascii?Q?IlhMGcTW9qJTEzfqJKz0HRJcufeVZHK7i3iJGmM8qey9Ps+3d4hs9GGlbErf?=
 =?us-ascii?Q?dUsWE+Mj3wAqu5dZrsIqdYlGP8hb6iubZ1FqVz1iE4jxlrJAiNsKpMQA7R5T?=
 =?us-ascii?Q?c6Rxg7zzuXjiVJa/7LoYjlH0QmVdTR+52oSyOqbTkPnHBKwie6Ocg5GCEWmw?=
 =?us-ascii?Q?aTm6wBngqNnHixfg0iUzu0+DopjxqXVvNcTimezlp9MrFBA7dEgH5OEGlfYr?=
 =?us-ascii?Q?q6MCk8/AA3getgrB89Dn0kXQyQkvDNvc33SP+TM8p5k/X3osdstzQlp+IpNk?=
 =?us-ascii?Q?73xyfEQjlh+YAoUllz9YlYVNuYPLutXjmqHP6X3lpR3B1D9K+zusEys2qRr6?=
 =?us-ascii?Q?Fb/g34Syr+lagLmC7ii59FbZiyIIqpZF5C4yLtQG1311pcLM5Mmg+UXdFCuF?=
 =?us-ascii?Q?y8+QAibZVxNlZtrT4YDyr2yRiPiE30Rn3sIc2Ltk3auZ/YMVGKpusvyK/hxE?=
 =?us-ascii?Q?tUFd56vtD47RxlLaO/GqoAFJk1MzqKAk9V83/CtSmk7P+su2GQ9RVC0Y5bD8?=
 =?us-ascii?Q?he33HpfVLX1jaSaU5wIjY61lZltdVjg2YjB3nCzcdTrYaVa4DIMeRdNP/UHK?=
 =?us-ascii?Q?NM3/tXjoe8amphQtUn/hP2NcH2UZiuy4GoMozx0tpwJjazIZRfuXP+sws+Fo?=
 =?us-ascii?Q?maiAu3typmcOG4gAU0pWxUUQInpscY/s2E9nKGfqPlH+ZlAkw3p42kvqHsQs?=
 =?us-ascii?Q?ACFLircluKeKBqjUE5UBsM0dOKwnmInBzWSYFyFl3G4ZPn/6HbnLKB4oB+yM?=
 =?us-ascii?Q?CL5SMmzwqvu4ek1HyIiyldQCAWq7gEFWDXkjkAMBZY578IPEBhXl/qemPXGD?=
 =?us-ascii?Q?PTfxrCEHBOC5zNmovYiH4o7hsYCrpODFpi1IXgCXHScBdZu1UOxw5wTn5HcF?=
 =?us-ascii?Q?ssl1XXfxhaWz55M1QPMSl0poN9dvo451t0ShimYPjf8Oj5IvgoPtuuCcfkUR?=
 =?us-ascii?Q?jX4ucaoU8kUj3lELKJK/vg69fNzRv6zNkdbGvUocfg+61mdKmpQxKGUo5YHA?=
 =?us-ascii?Q?7BGtpRC8CR1OAcaAMROEhjZjqifW85QbsQ99j3Xnt8oICuQjqYMw3qS50Geb?=
 =?us-ascii?Q?SjTjvKG3yU6If96kVyjvHxBKUOIBIf73RkDtvrbhdQ0qck+z8LnFzc0DlLFP?=
 =?us-ascii?Q?s5y07RMwlKLdpKlGKlRlhkI1w24XZBt/Eyj7eYGyLkLQXtPy23ZkkBcf6Wfb?=
 =?us-ascii?Q?NagBlVzcq3EjX8PbwFFZ+BvRt2YGkb9aj7awcbkEPFq5hrr19vgjrhOXJES+?=
 =?us-ascii?Q?fKEwEv2zr1a8KFZwEvtnt+HPaNgPObYv+zamBEsv5XFMdHVLNdMPX9yl4fVk?=
 =?us-ascii?Q?nojxEbhJ7PfALL2b6xjlsN2WMSWaT+t7WbFmGmIZZmFuXDP73MnHrdUr9mvO?=
 =?us-ascii?Q?DYGyaEdBz0k/pCFmOXZ3ypihWopesiE/IjwP7IYvcjWuBgNKqbGVtD4rNnGO?=
 =?us-ascii?Q?pwzs9cCfe6SQg9Qy4XrOg/FmFb2HRC3aeliGOCQqsY7n2aD9Az2FXRgnKtG1?=
 =?us-ascii?Q?Rl2SSgldpntQ2d+8qXCX95nMMz+UfF9TFAJAiEPiThs4yZXrCJiAuAwDfi52?=
 =?us-ascii?Q?Repw/ia0bKSqtwH0eYBAtMFAlg7uldlJ7QjFsxpNMqMh66egUPwf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 b13f01bc-35df-4d35-24c8-08da1309a843
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2022 11:29:02.4328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 Vg7m6FWAs3no3eo35Z/bcrnCvisTwjn0EEGqIOzljp5wqZrCjmJlyJRNBfYiTs6m8Wh2/CN6XjJhqqUmjoqxoRh5YpWSajWcclHb06MxI/M1RFgbKr8hhjbqdH0zErp+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6564
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 31 Mar 2022 11:29:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7901

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 31 March 2022 10:28
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>; Biju Da=
s
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip 00/39] Add SD/eMMC support for Renesas
> RZ/G2L SoC
>=20
> Hi!
>=20
> > This patch series adds support for SD/eMMC on Renesas RZ/G2L SoC and
> > enables this interfaces on Renesas RZ/G2L SMARC EVK.
> >
> > All the patches have been cherry picked from v5.17 release.
>=20
> I tried to apply the patches on top of 5.10.106-cip4, and could not. Can
> you double check series applies properly?
>=20
I did cross check my base branch and it is 5.10.106-cip4. For some weird re=
ason patches 01 to 09 are missing in patchwork. (I can see the patches are =
in my inbox though and pretty sure you too have it as have received feedbac=
k on patch 04 and 09).

Do you want me to resend the series hoping patches appear on patchwork?

Cheers,
Prabhakar

> 8bb6e30b765989a3c0924158316d689e16317cd1
>     CIP: Bump version suffix to -cip4 after merge from stable commit
> 66f600a7a5460b6acab5272ac9f54f842927a50d
>     Merge tag 'v5.10.106' into linux-5.10.y-cip
>=20
> Best regards,
> 							Pavel
>=20
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

