Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB01C25B79
	for <webhook@archiver.kernel.org>; Thu, 16 May 2024 08:20:06 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.86])
 by mx.groups.io with SMTP id smtpd.web11.8352.1715847596089198614
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 May 2024 01:19:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=ET1AXxrl;
 spf=pass (domain: renesas.com, ip: 40.107.114.86, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5zT1CmKo1d/2M9gGJKxfSrTtwCkA5Q5FQa+xNKDs2Wvp+njli41NNIXb9SLakO433ZOsEPt5ESPLrQ5jo5OYGdzPa7+wBTdxbJgMjO8afRinw5IJcefmhdwbfSjH5KjXdvnTdVvnRIWgQf3qW2bMi6X4S8BHkPfdHiTyreiA/nuUnAJQdZ3oh8ltuWAN+jtPqCV3dnl0ZKJ3w5S6F9OnRX79IC+GUIokHXgW0aCoPP5Kv/SdA7VtbseGFfsL78FrtksF+21rpOfp7E5SO375+1/mTi7DnetqFtRl+9s9eyeGZlQ0kAe00RtZMN9GSzqrzT6YZQwBxrJq1Cy+THYuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8v4hxtZbALt/7rmxZHn0K/NeO1t381/cBOhttYw/0Q=;
 b=ZS3EntgRb+y3E0H2H2VbxaXugaKJbsG+AsyaA+nHrwq/BTJmc2lmEmDNwIdBlr1e1DzkJa+BqyNpBYocX/Csbbg2aF2iXvcoRN35zu01chDeATUe3E0ME1rWzeaIWtos7cLgzn5hcsJjkjfXY02cgPi02j7feiGRnvocTYpDvciXlWhtxj+jmxJej79e346WC6c8liZzPT48A8ta/CmQ6bg+ESE5mExRiZkhX2TFxhU2l+ru8IFW7KgALbSQzTUHAsylanVQ+1msE0do9XkbpmxN6FZj3VPwyRh13SSD3Fagb7A28q2b80V6WGw7QRUdOXJ5Xm0DLR7zAsShh5eNnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8v4hxtZbALt/7rmxZHn0K/NeO1t381/cBOhttYw/0Q=;
 b=ET1AXxrlhuyPdYDm3dhPw+As2Ytziy7z+Gmu8vLmsIzAZj5Mg+KUbiMySwIRE8BAbfGc7XicoY6xbIvsH95PcdJENb1pc/PGjln1iZFfLfF5ZxkSavzVq/7WkaD+MZEpm0QoxQ2PYPHWBdYLuMJCujOgAAx5EAG3p2Vu4650IdI=
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com (2603:1096:400:3fc::6)
 by OSZPR01MB6597.jpnprd01.prod.outlook.com (2603:1096:604:f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26; Thu, 16 May
 2024 08:19:52 +0000
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::fbad:9a9e:9e5:7cfa]) by TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::fbad:9a9e:9e5:7cfa%6]) with mapi id 15.20.7587.026; Thu, 16 May 2024
 08:19:52 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "pavel@denx.de" <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] gitlab -stable-rc: mirroring not working?
Thread-Topic: [cip-dev] gitlab -stable-rc: mirroring not working?
Thread-Index: AQHapuzrvr46zaW5HUiHSrZakm0AcbGZhBNQ
Date: Thu, 16 May 2024 08:19:52 +0000
Message-ID: 
 <TYWPR01MB118620EFB0163032D2062BA13B7ED2@TYWPR01MB11862.jpnprd01.prod.outlook.com>
References: <ZkTwEKwobEIumswy@duo.ucw.cz>
In-Reply-To: <ZkTwEKwobEIumswy@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11862:EE_|OSZPR01MB6597:EE_
x-ms-office365-filtering-correlation-id: 5aa29ccb-d9a6-42d0-6d02-08dc7580f5f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?Windows-1252?Q?Erg/yWF+Nq9EVCPX8/Ivrx9FLxeV5PAOzS81lwtkAdqlluZRu0PDLM3G?=
 =?Windows-1252?Q?DSRExR2L7Ls59sQN4+AJ8u3PA/Bep27k217A0V6+RtFJBh2ZLgpfDuN2?=
 =?Windows-1252?Q?uWopAhoCyOG3yWL1Uv8LtLYdWRMIyoy1mxR5bOBDhZKiwb93xLItB2uD?=
 =?Windows-1252?Q?71VHGl2FO4BEFdvvX7H65/DcnqjoyQhONTu/DbdmZ+wnRHB2e/P/Nr/5?=
 =?Windows-1252?Q?shZaX7QKaXk2A6oja3SKfqi8yCmAP+pr+/rk2d4LZwbTOFA07ButmtnE?=
 =?Windows-1252?Q?1QVXrQ7221WIdNNpKDi4FRccdSmewazfeVN8a++sSxygDfbzQH1F5hSv?=
 =?Windows-1252?Q?SGczytEbsUXYWlK+XsomDbMawE5vyupMl+CgAA6dMc4cK8C8o1E4iqGe?=
 =?Windows-1252?Q?clXmy0rRvhmGFtiN0SgBSXm/wocDS2aYKFAzboOfuNgtdIaIrArc7BEy?=
 =?Windows-1252?Q?o8I2MjvVuvG9MP9OTpGz0/8sqRckJdNPTVkaz+hHoCVo/4LJ3rDW8edH?=
 =?Windows-1252?Q?11suHdm8vxfTGBKdE+5EgP15p3/TE9KbEopLhWAncx0eJoTjoTlyGlCJ?=
 =?Windows-1252?Q?zQxixB8PYy9+PyjhPYxPrQ9KjX++43iYQYPUUM5cqmvXkQiBZWJc4TUk?=
 =?Windows-1252?Q?xC72MhBnX+Ik+CMQjxJ+eJ9ErQT+8d44PIjhCK3cFdevX6hcZfY8X5+o?=
 =?Windows-1252?Q?y2Blutvsi2CguvT4kYwi+dREboOjC6cCwlybrGF32ZJo+qlgy+Rhpnaj?=
 =?Windows-1252?Q?wj995fJaYEV4To7skwVcwYtZx6e6ryRTv9AN/4iAtXYX2EHyb4dZVU0l?=
 =?Windows-1252?Q?jLOSCLXaR2rP84cENa5VwlhVtrmD52ighoMVLaUT0pLHDmlB3fXdPfgM?=
 =?Windows-1252?Q?4NWCC5XKfIumNgrjWc0HlvRXvHAkoFj8vnSkxN2gN9Hu0cPlWiOoxKhq?=
 =?Windows-1252?Q?P4Rx+MgCLkueGFpokHtu7CHVLFx2hU3/Znp9WLtM37RKyBz0tH/Qe7N4?=
 =?Windows-1252?Q?T8/bNbZwckk5kIa6sa1amVK0BiSyF3w+DLESV+R5mBGiqfY9R3kNIhot?=
 =?Windows-1252?Q?KBikFQKDGD7MtgLOZbNMyELCcRI40IkRxOZn8PE+6x4Q3w+xyzNDFPf0?=
 =?Windows-1252?Q?tQse1ynZReTepnR8HYacroPeFHFIgGQ885nrlmnt01Ee+DpLsLR9Hoj/?=
 =?Windows-1252?Q?NlIkyFmWGmyRRqp05MfzbGduBf3ve01VHXO0wcWCTNYrnXmODFWRUZbR?=
 =?Windows-1252?Q?rJ67XPNMZRNeijPTh+L5wYPCc2iNBk89hjsmX+8vRKIbgDYEIHR7XKwM?=
 =?Windows-1252?Q?Bbzx2AIJEwPQhhzSQm6Wjoz1EdRt4Zzj51byBX9hh/owl25X1uQz9NEH?=
 =?Windows-1252?Q?SEBnXyG/uXvWow=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11862.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?O0V9Q/Ic8/I/Aj+6wK7L7LOvLzY6aa5zJci2J/i4nI7croE19g4X4Yoo?=
 =?Windows-1252?Q?2li/y8v9/dsVCf7LFBiLMxlWkvh1PF7+D/ilxcZytvlG4PNu7QjMrns8?=
 =?Windows-1252?Q?m/t3lKCqve3XDf2M83+BDPMjQOvRTFLTYo/J2vgqbL0AhXobP8K9qFJD?=
 =?Windows-1252?Q?bGc6HzuVUQoa+G/SHWyyi2HRWPriVg5tfhEz4PDPCbjOc5IXfO+1rdK7?=
 =?Windows-1252?Q?WH8PGjlP3Q+zcfHTUo8pOOukAf8W/ceiXgEFHN1V5WGW2epkyKXuu+cO?=
 =?Windows-1252?Q?ziOh3R4VwonKmalf689DaprvLM93TO7M3K6Ao6ZVMJNUED9gwUYWLJVP?=
 =?Windows-1252?Q?YYSIcm9iFbDSQTJqu1Spdg/Qg/XF5tDto6bvbOwht6zxv9plJ7y7wn83?=
 =?Windows-1252?Q?Eai49cIxJ4eeZknWtJJlqAxmHJ7BLAulrftbnP71QEUYGxMXlQ4wsjDS?=
 =?Windows-1252?Q?bUb7dJYeb4PUlCgfitYaV+Kc9xVE/00dlTDD20SzpXL0bm8qctgq1gMo?=
 =?Windows-1252?Q?MOiXy4FTgEePrVTd1jU/avILRIhis6FW1D4zNikQbSwlVJZkkX1D+vzD?=
 =?Windows-1252?Q?elIgMOY9JXqj9rLaQuuycW0iEYfpQSgWE0pVE/093Ml1zR61vK44tKJH?=
 =?Windows-1252?Q?xE8dVYAOMd26CVYVf5nNXXBg1WOJ7kfNp1l2DbDVnkYQLS26UXt7mU7V?=
 =?Windows-1252?Q?LYHxPt4Vcfhpru2UqgyXvRbVt56lK+YJ6GxFeSAPmcc89kAvkPOD0erS?=
 =?Windows-1252?Q?PBy945J17zqcwKfqLK1a0LKdBJQL8FTUeHkLAt/B7XLujv++xMVyS2EY?=
 =?Windows-1252?Q?kRWUHtz4Ir3sUzaaZScJN3P/0jXmQrDhYtUlVVcP8qte2+098PFdOF7W?=
 =?Windows-1252?Q?dWf1qE5BasujJzPj/esxhWmcY8qG4W/9TgxEixgjnZZUa9xwjUY6/5uN?=
 =?Windows-1252?Q?gqzqJ252dnztsSq+I+GBXHMCVpy8gotnBV8tOM2hVUBk/vkRFwcqRJvl?=
 =?Windows-1252?Q?lyI8LQrw0OLiMTlJOKKAeqG6DkgCc59RSKHkrtWgyYtK1FV+PWubJwl3?=
 =?Windows-1252?Q?DVlG6hII8PXT2AOqInL+4vEfomoEsURh0syQcW41kvQc/4VSZ8335+3m?=
 =?Windows-1252?Q?JhSgkSVCdEmi9KhE6LVMbiciGtTKDkW8mA0yA2wMi1yd0CDEBqZ2shQH?=
 =?Windows-1252?Q?17zlp9yu6wX59hR/wbU6uHZar9+rtXpspO7Ofbyela4N2ur+2F/2c/md?=
 =?Windows-1252?Q?a0QH1AGH8ozr9vhkCDAwL4AcLPxhiC6vfVL0zxjkLAs9zd6ELNHoWW9D?=
 =?Windows-1252?Q?zbs5065gfghJ8P6nxFTMcv3YBY0nFBjUUJo/8Kht0zvJuWCupEdUP0gd?=
 =?Windows-1252?Q?o3OD646OULgTtKxaUZvwjTSqwkMDEatJtT7F2Fts395ih2cuX2qwldDc?=
 =?Windows-1252?Q?q9CabQt01NhtF2/Pw88gIeFVJiuJ/K7Nq4WZrFnXSUD1JhMprxFtSkJw?=
 =?Windows-1252?Q?x7wXYfqoRa0kNEcITBvQzwDjSM4Vnqy0Xuwy4WZIDGCJDcDQZjI5OLEX?=
 =?Windows-1252?Q?jGRNy+Yz6f7/n85jKw7ldBUs/yQnc9puoYUvnnp2uEO3zBZxZPvPZE7t?=
 =?Windows-1252?Q?7ehHuGh+9/enckrYdpNKTkGXCOFj0BNTo9EIEpueED1WVh98IfpzNUI0?=
 =?Windows-1252?Q?VtqxN4SAaUdcQnjk0eXTpmuk55kkktk/0kDIB5+7HuRJzMK4VLOzrw?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11862.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa29ccb-d9a6-42d0-6d02-08dc7580f5f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2024 08:19:52.2362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dsPmCNDvyEfKDG4LJ2SA+rTslCsLKc6JTx1QnhtRGNmgmY81zXvuvZXpdkHifjiaDLGjlLSEnf/UKnKOJNnDIfwZpSoIyihLEqkxg0X4smk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6597
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 May 2024 08:20:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15903

Hi Pavel,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: Wednesday, May 15, 2024 6:26 PM
>=20
> Hi!
>=20
> I'd like to test 6.1.91-rc2 and friends, but gitlab still have -rc1:
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-
> /tree/linux-6.1.y
>=20
> Can someone take a look what is wrong?

Thanks for reporting!
It looks like the token on the cip-ci gitlab account expired, so our trigge=
r jobs couldn't push commits.
I've fixed it now and the new pipelines are running:
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines?s=
cope=3Dbranches&page=3D1


>=20
> Plus, it would be cool to start testing 6.9-stable branch.

Yea I'll get this sorted when the first -rc is out.

Thanks, Chris=20


>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

