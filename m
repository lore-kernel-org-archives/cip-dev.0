Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7332C43334
	for <webhook@archiver.kernel.org>; Mon, 27 Jun 2022 17:58:49 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.110])
 by mx.groups.io with SMTP id smtpd.web12.45285.1656352723296875925
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jun 2022 10:58:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=k0wmQcWP;
 spf=pass (domain: renesas.com, ip: 40.107.114.110,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zc6yyLnsl0fG6k9SZ5Lf+2xNFwtP/66ufv1xCb5iBXyChqayrmiHJKccJ9/JDWG+2XH7NkpHkGe7fX828UZlPe5TcylUyOMu0swRoPTgcvdVoIARLPC9bBw6/tQMDS7g92JP+IYpiUbSUM401m3UkisIzAKfFtSEAxwarNHglU6c71AkQYAyCYHY2w5UZHFFD7fOO9NMYs7iLMQi9wq2c77eTgV0TqccrVvCCLV7mZiPWBC5AbOWrBvDwEoSU3dgvgWo3PjJkzN2vMeiBciScEFkxByreBhnwoFrs08qvDZobUhGL1JbCyGiVFrlEn22MKcpfKHNvI+XTXUmOvxsJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHf8E1BOIO0os8/mXDMvKFhBTfNajF8SfpXEedjbM1o=;
 b=G51veMgb/GabvX4j7VMvOERGO35iDmpGDBL5oLY5yVc4tJ3tEmQ7QfQOMAAiezsOLfrurJibs2ju9d1xBcz6Z/catGhR97gZmOxwaEMKo2KYhUEtdGK+hz4DPC14gq1e6KP8VpV0TSeD9yh8KI6orthnOBmwD7TcYcWaDIEkIGxKj4FGVE2wsbDWH5lN0rF6NE+iWT+FmaBrkfpThyJ1zZJmChMNP6v5vfDEya+M6ePPn1Kvqw1kKK+7/b7nAjtV2lv/fSIfVHNXryddcQ4rH7w8TiyJHR9LB1Ymrz4HRTKnpKPq1iqqmqLYuNr1iw11H5U+uEMnqcENE3nO8RRNag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHf8E1BOIO0os8/mXDMvKFhBTfNajF8SfpXEedjbM1o=;
 b=k0wmQcWPwECBPv+3l63Um32R+eid9YIAoG4/gXpLNWsdTUzBTLVz0cX1m4IMmxH11xv8e33V3EhK2dr+3QLDcFswBJV9bgEU0Li043ZxG+29JsQmw0Tp8vldBkBqxkTodwfuoAQkbwTb//HkgcWG4mmyZv3U/2vpU3u9PHtrk3I=
Received: from OSZPR01MB8124.jpnprd01.prod.outlook.com (2603:1096:604:164::6)
 by TY2PR01MB2764.jpnprd01.prod.outlook.com (2603:1096:404:72::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Mon, 27 Jun
 2022 17:58:39 +0000
Received: from OSZPR01MB8124.jpnprd01.prod.outlook.com
 ([fe80::8ce:d371:61e2:eb56]) by OSZPR01MB8124.jpnprd01.prod.outlook.com
 ([fe80::8ce:d371:61e2:eb56%5]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 17:58:39 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, "alice.ferrazzi@miraclelinux.com"
	<alice.ferrazzi@miraclelinux.com>
Subject: RE: gitlab testing down?
Thread-Topic: gitlab testing down?
Thread-Index: AQHYiiUlLtqzvD52QEGg7MphkB9G0q1jijYw
Date: Mon, 27 Jun 2022 17:58:39 +0000
Message-ID: 
 <OSZPR01MB812483F8473B4E289574495BB7B99@OSZPR01MB8124.jpnprd01.prod.outlook.com>
References: <20220627125510.GA13594@duo.ucw.cz>
In-Reply-To: <20220627125510.GA13594@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccb61cc3-5f44-4893-0719-08da5866aa46
x-ms-traffictypediagnostic: TY2PR01MB2764:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 DPopHwKJ2+aCQbWhnnovQYB8EnkHGNtlVYa2meZ/RymS4k+nJ+2mI00RKqjj63B6RvDTwqZtbnq07eSLKvTpQVdgSIB7EDOuWFtDpTJgncRtuRsSthdEinltIIroZAi9lgmqQfmptQUUbMxzc3amPq+Y5dQ0g4hkDJoePzCxETv53e/ZZgJ+c2/U64cWxchC6+a7pNfIlfKpx0ips5p/kVv5bVE4WQCm/pp24MFr8J/o8zHq8xgDAqoY0xu15GpBURgqv+xJDX72XeNYC3u2GKLi09D2apWaM3XgBUawIOTtMzy3A60c5rJr+keDIWr9LjpQL3QjHMfpfWXOp+LohPSGmd6GzCO8Ij/QjregIc1aUwJV/gruI7jUFVeGC4qt0J14rqEE9J8+XfqO8Y+iPNMEgDwF2htvExTSkf90q7t2DiKaEYRWqt3oPBGwYJPkDwzk7sN3OfVLeZ2v3n5m+BFr31oscfwBxusu3I5PWF6imHCpy7JvGtY4tVUM2yEJ/FbsoacElAhrSV96yfF2L4XgoQYkvCglRg2i2eRk58TgveXKRbfS+Np6LDuUvpWitCShVB1zXaHPaedI49hAP/rLpZ1RkNkmVdn1nzb7IcbFsvEcU6baxjqwCIiDZkpfGnCU13Zh2cwYzGbT+z8lWpTq13z5r4bF26AeUGqjBLgGvXhFasT+X/Fi2eytOqtIJsqR8JgjyXEGNK1TLvFW8UbOqEvA+yqub/sylDNrJHBoDb5CnEA9j8b7LpjfYB4dD+QPmCVWVSuNl1wSVEUH+AW15q9/IyMupAjVuXlThoot+UmYXvdS6QsfFPPAPGTTsHmcmS7OsXH7rMfETfSyPnOivZ9g6XSZPYKQ8fYfzdL9d/X0SpEpM+YDg379izjr
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8124.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(55016003)(5660300002)(7696005)(86362001)(110136005)(9686003)(7116003)(33656002)(3480700007)(38100700002)(26005)(186003)(83380400001)(2906002)(316002)(38070700005)(52536014)(478600001)(66446008)(66556008)(64756008)(966005)(66946007)(66476007)(41300700001)(8676002)(76116006)(6506007)(8936002)(71200400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?ZEos8zZVGi1a0pXzLNpG+DHrR21IM14kF01Q4OgTdFu/lmCAdDiv6Q47?=
 =?Windows-1252?Q?5gBRUY9cjqYcW1GnqEqRwTmi2P6zrBlXyN0a7rTYjKQ6A/MlbIMNg27f?=
 =?Windows-1252?Q?tK9tAUgcplRH3Mhi2+3r82CwDIQ+SEaOYZRMTZgbQFGImKSBjb7z64Sv?=
 =?Windows-1252?Q?uVSvHO4uKdIJ9d7sLsjLfMUkN68RPZbf16615MdBvC4UHwHKLLcbndnU?=
 =?Windows-1252?Q?OZvzAs13z8foGgZ+TiVmYJ+2JVb8wDoJpov7pKyOJVbHyK3YmtLbtTfq?=
 =?Windows-1252?Q?B6yM383SvtRei8AkJrV77FI3ec8xWI6UwfInfGxgZHGjrKFA4MBzqh7w?=
 =?Windows-1252?Q?KnF28LymS5uR8wjEHK+5ZzEuxuclPYvSHUAfJ1jLMJ7V0D4RPCjN0o90?=
 =?Windows-1252?Q?M+hND9hWKRaIQzThw83tmc2R9f3DIie+eGnBPtd12WRxH8LjeMKn9Moe?=
 =?Windows-1252?Q?m4a97pCTC/Qkp2zhmNVPXVlAgB/oGMPVI4CeqVziS333QcYyuRwuhFsL?=
 =?Windows-1252?Q?TAlCdUaECAnnySz1tyV8o5lrxgLwNJsuKxwMu65fMgLCyjEoAnghPKoi?=
 =?Windows-1252?Q?VxjEuF7V9qIT9Bcczv3q82glHdHkT4jEFN6BAhKJI8vxh4t0b0YfxWBW?=
 =?Windows-1252?Q?7ZT/khClwOUflxmo8uFcrWg/HcY6d/mv0tuNaCovxXVeXEuGKMP4qoNY?=
 =?Windows-1252?Q?Rc4pgglqt6xitRYhQ0YzPnXRPX+aoV9ums0Bi3nsy1e2UzAREEdP3c5Z?=
 =?Windows-1252?Q?K6zqfBZMeaS8PuFT0oKeXJxoE4tRb0JnHojnNpeuE8s9NmSeC0EhtsAx?=
 =?Windows-1252?Q?75tnEOL06o+syuXjf7PDFIu9536iUfDNs/ywe5xQLUnFkuEEm8pM6Gt+?=
 =?Windows-1252?Q?prVRt3y+DB2fzfAvitG6Q/bPTD9wx8As7MWGMWQBgi5rJIAI6vh/uqPz?=
 =?Windows-1252?Q?xqx+oReLWBVCHoIp2LAK3tE6azYSiPSRElP7ONRDc/mBMBzGWSBFBJ22?=
 =?Windows-1252?Q?nnUhftqErGSSyDNeSMvu6pUrWbQe6tXieCEEuE52maN78sQGRFcvJPl3?=
 =?Windows-1252?Q?+ELMHTKuztLIj71mFhxdZHAnNazFpWKZNrw1wzQK+xUJTb+TGbFetTus?=
 =?Windows-1252?Q?KVXxnFvV40n9IuHDxZtR9q8Ubsrr572xvBk7ILUuEWian0xF9t1+L32P?=
 =?Windows-1252?Q?cRjUjWKH3TWKpvKs+rv/8ecYcQekkXp+ZpbXIbbA5KeKU50lG/x+k4zX?=
 =?Windows-1252?Q?jQh4YKsQkkoxIE+9MRYTPD+jNtTXaO7fupirbTQURI9l10Aw8lma739j?=
 =?Windows-1252?Q?UjJASHZt8iGZmUQbltqtZ1dpPzaCt06uhBoJU8SbT7U5m6oahXl4T0FD?=
 =?Windows-1252?Q?6J+TS7yHGipYLODB3kBH/8AMo2ZWFz03u2rA0S7MIsE+PRxf2vJi3goO?=
 =?Windows-1252?Q?hKYs8k4sZvTjfv1SB6QM5IAQI+jzYqQvMD6kErs9ZDkUDmczx53Z+M7Z?=
 =?Windows-1252?Q?RIi5XxewxcAHvzQGx3iCCpA3n4dX/tygwcBaT937WIhYPLQnnjfcWtqB?=
 =?Windows-1252?Q?GTua30IdrTqIDNJoIzesrT6BVJDr5JFyNAZXzcM+Dz2NTZyOWkRwKook?=
 =?Windows-1252?Q?w9urrNggBWLHNexXGjTCt7Wh9E1oUriTjpK4lfHOjQYcbRkSs1ddFy4w?=
 =?Windows-1252?Q?HVCviBhbrx1a0+v8bpzHFONUxIFpdsTs8qgGulfTpGtS+WoP9lstPg?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8124.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 ccb61cc3-5f44-4893-0719-08da5866aa46
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 17:58:39.2815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 vQpDTczExXCe0aLOrg5TIzNbQFoXEfiwaC9wqHJTPJgkKtVcOKNaTZS6XcjTAEzgIfSLNhUI61yF9Wlwr7seidzWsbghXDAHrfVM/wL5yOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2764
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jun 2022 17:58:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8607

Hello Pavel,

> From: Pavel Machek <pavel@denx.de>
> Sent: 27 June 2022 13:55
>=20
> Hi!
>=20
> 5.10.127-rc1 is out, but there's something wrong with the testing.

Thank you forgetting in touch.
Sorry for the delay, I'm on hols today.

>=20
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-
> /pipelines/573859895
>=20
>=20
> 56There are currently 0 "qemu" devices online.
> 57Refusing to submit test job as there are no suitable devices available.
> 58There are currently 0 "qemu" devices online.
> 59Refusing to submit test job as there are no suitable devices available.
> 60
>=20
> (and similar for all the targets and other trees).

The whole https://lava.ciplatform.org/ domain is offline at the moment.
It looks like the EC2 instance rebooted a few hours ago, but there are stil=
l some issues.
LF have said they are looking into it. I'll let you know if they get back w=
ith more info and/or the server starts working again.

Kind regards, Chris

>=20
> Best regards,
> 								Pavel
>=20
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

