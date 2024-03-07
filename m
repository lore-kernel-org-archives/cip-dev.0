Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166B2C54E55
	for <webhook@archiver.kernel.org>; Thu,  7 Mar 2024 09:29:39 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.58])
 by mx.groups.io with SMTP id smtpd.web10.19448.1709803768895973929
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Mar 2024 01:29:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=Ruj2GKWi;
 spf=pass (domain: renesas.com, ip: 40.107.114.58, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SxQCYpYjtuywTHEbgIvgwUG93FJ1guFsOY7J22ohznjfj63sgHD5VJiZa4ePMzjycyyULZuDZxKKZC5EkAF7p+1kvJcpyh844sETExZBaLGSsV6QV5FndCzkRnJ1m3LK9wNr6UYLIntt79MKK6R9ucsJDDxt4J22zVUdHE8DX9tG+xU2qkqeMeMGanh8wbuT+05YaJ1W1zt+0Sz/bWDycEyJo1qG0Z28Iqa1B/AarRHATtAZcafcreCM2GbyLO5IEGUffG2f50Ln67b5yoTwHtMRg19XR3JvCkmahnKAn6fvQXqWWTlW0imP5OV1SJEkCLaZ8x1GVOxjC51v1JHA4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UPW9AzJEndxJxaqEZt4JaE7/a8VcRlslhviT4D3j9Q=;
 b=JZOYG0E3/0WvMmPm9mhXZsKJmUH6lyARDudLQEc7Ds5c4I7DvDdfgN0ykAtm4G+taLR7A6xxJu/jdDgm3OXtl5jIQtBAPYGxX+Ph6BiBOaFRdTiQQqqFn+yTtRzdmXDfI9mQO3bUw8fzlIkc4Yqra+7cV5BZbSiJQs0pNJNMmQsR6nZhh02DYrBnyG90xM1RTym0C590y7FFW2axtR/E8/jXMoKKvWE+GMp2NBU+HzTQMRTaiUj8mlMJ+nkZsE/2VL7YAfrJFa+VXZMGsxra0Vn1Mokm4RUJcMs9owvJN0kPgQ34/6Jc5/B9oWJBqHoSHf7ZTuDq0KyecP08lQiljw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UPW9AzJEndxJxaqEZt4JaE7/a8VcRlslhviT4D3j9Q=;
 b=Ruj2GKWiWHKnGbm88v9YLk5OxKiXsi15TH2fd07CZEUPVAQEbL2XRAuRc/38L8MgoCy5D7Cc4rbL/SDpswqihqeWWyB5UkLM+QN1wTWZyeNssaPV60HvYW+NDgwlGQyybl/LsnmBC7tx4O7Yk9uFhWDpRt5KVf3GOTtAxDL0Zq4=
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com (2603:1096:400:3fc::6)
 by TYAPR01MB6025.jpnprd01.prod.outlook.com (2603:1096:402:36::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 09:29:26 +0000
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::ec68:1357:d0c9:ad1a]) by TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::ec68:1357:d0c9:ad1a%3]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 09:29:26 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, "jan.kiszka@siemens.com"
	<jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, "nobuhiro1.iwamatsu@toshiba.co.jp"
	<nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: RE: [ANNOUNCE] 6.1.80-cip16
Thread-Topic: [ANNOUNCE] 6.1.80-cip16
Thread-Index: AQHabVTM4h192S6QPESv9fD2IPdUMbEsCK1Q
Date: Thu, 7 Mar 2024 09:29:26 +0000
Message-ID: 
 <TYWPR01MB11862B960B961A3A80CBD02D7B7202@TYWPR01MB11862.jpnprd01.prod.outlook.com>
References: <ZeRPi27MT7Mg/Ecz@duo.ucw.cz>
In-Reply-To: <ZeRPi27MT7Mg/Ecz@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11862:EE_|TYAPR01MB6025:EE_
x-ms-office365-filtering-correlation-id: 7a37efd0-e956-4729-3ab5-08dc3e891504
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 OwM5SdQvJbuVComdoGg6sUGIlcsucZ2/tls10zMrsw9SsgLpEZN10/3fgcWEZdEjLpvbTQdylvEH62DWFhkL7sBKrSTH9VFsgU3Bl3lUQO9k8tP0EPtxCqn4FVVqo5crs89jhHoY3D0NaJMJOFHiabG6Ig8YNWkXn4KG3Ye0L8tyccZkKM3M/XHIJooHZ+TblTqu9WfFFjbo0cKUOz5mIZKc74HCTEeMGeptRYCY/xLvfwiMnzGoEKpE+lC2njtt5r4j15TS8dMGw3XnEJzkIXx1KufamCDKIdzxzhAxtJQgyfeYv/nHwzike+DwKzxtiL0TlIDdxmzcPqr2PfTOAdDWwMAnBCOElT8+tEoFqz5FPAiikSKAZ4s2D0AGT3+xB6oeyZ8jk7lW8+/eWP0g5hlJRrwtS1L65+wpkHM2vayuqHFLfr+4gbbDPzJGUXhGBUDnerY7kO8HczS8xuCj1mhMbRz1+3/4aN+tDK95Mfj1JdEOzmABjr/BAOGd8Iu50ek7/OZFl2vVZ16jxT4z9wj0jXYIPU+l9CnFwoshiP048pfTLLrI/j2hgPGY8omV9CnX/BbgQqvtesMWleufQCjUHfnqvHyXxRQrUVCHoUYp9fgUmGdGWQDLxRz65+R6Y3fIEvGdlGp+/QnaVnitbU7zbczEAympHQAtfLl3f4g=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11862.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?y4ctQeDj6gu0/4LSwid6+GB0ZYdylNAbaILO9Qluqw4CrcEi09FzKG8X?=
 =?Windows-1252?Q?40BJyntBNZW+kUEZGtoV0yUaL5UUfBobvYihlBjHc7/wNHbcmVFlXPa4?=
 =?Windows-1252?Q?MbtbBBWeVBGRZ9Bvw10EsKUb2jHp/R6tczLcX+l360PZKy8bErS+ZknH?=
 =?Windows-1252?Q?0nUsnG9LrAM7VRz+xL1sueLK8DCznMTui5uZF8lKRjM4DjeP5vbyctwp?=
 =?Windows-1252?Q?tLp+OPWQN7apfom098CZdQuKbvmBDHfEJbXh7r0avldjbXoRGIH8xZKw?=
 =?Windows-1252?Q?KyA8vSH7A17VpNApBjuhubPa88qNQOD7bpdNXmB6pPmE4JzDKF291EgT?=
 =?Windows-1252?Q?Cn97lrIg+eEt/nR/68oNj/nXeQEoZpuyhBTinjVET5glx576x71s+ZPJ?=
 =?Windows-1252?Q?qlsA5tLcHTTCLf3IftcKgyuaNU6JO2kz2EDuk59IgV7hoM8LNWeHWJPW?=
 =?Windows-1252?Q?ZqBEpOqvHQ/LQoVNECCb1NiPAMHLvkqZ8VpsAA5dKZDJZ/g6rJfx8x9H?=
 =?Windows-1252?Q?0LwzcILgVr3t5EBBaVyVGsAC2t3rG85lCdsUTfQewP4vVO3QtG3rhQqt?=
 =?Windows-1252?Q?GzYEaEkkyRIAgcrMEi+ZxIM7HSKjrZmF2cndE3yCnngSL2z5cxNMdzrx?=
 =?Windows-1252?Q?rIoERCU9LrCDj7DdujjtlOAqZ5vi2NL5hW7AwXHX5XkLUBs4m9NloWhd?=
 =?Windows-1252?Q?MI+hC+vCdcXJBUP2mGnYYnUNIDnIpv014RwpOHdaB//mNdFSE7UEL7+e?=
 =?Windows-1252?Q?TpCvQf7AItRltsk5pTANh0lptZhegOxKBMOtn/WWxFF6tgnV57hz8HDY?=
 =?Windows-1252?Q?3BxGY3CY4/eCyS7MrL0318+6Zf0/AyTzbLmMImYp6sOwOxI7/RKg6wzv?=
 =?Windows-1252?Q?sTOdw9D16j0wK/nj6M9XtZ1eY2w/TuCqR9cCTXIvvhA6MY6jJRrHs3ut?=
 =?Windows-1252?Q?3yl9fL4PA2ivRYrlIXDR3G913PQa29GlmXM/37NnR+lY2sl1o8vyjUmz?=
 =?Windows-1252?Q?ti9PXu2UClUEAG9yAjU9OcaEXnw+kCqDBv1cwSR9jdZDAJJGjshpcGHi?=
 =?Windows-1252?Q?hziioQ4fIhcQ/YJmRugYJk+2jbejQaEbpYFuehAJHjGnJvuApcjXAWg6?=
 =?Windows-1252?Q?AiMiAwvKVGnqORGoc46RtmHEmuMGuj8F/Uw7Rbdw57LfQ0+ft2cwOwUG?=
 =?Windows-1252?Q?GbotQMJIgEEb9rBU3jSBIMPbCvyHJxOsaTXKjdi+wFbmWSsKZnanlPM2?=
 =?Windows-1252?Q?c8UPkl2QSOuaDPyrWejXUvLnuIGrfFxbUuoIzMFQbp6EwT/WZMC6RjCH?=
 =?Windows-1252?Q?O88TqUlac3KRVqPrJQEn/eNK3fhs6NClJMxnycOAgLLe0PIsk9J7oWgs?=
 =?Windows-1252?Q?3TGZWaJ6srD5iP8Rj6nrbubLIBFS+pdghmwDVW0GkEUtZ98JnFP6nadQ?=
 =?Windows-1252?Q?zdpVBB6HikbeXRMR4cetu1r2dtoxZizJqcNyA+QlpHTMEYFVzUY2OtQ2?=
 =?Windows-1252?Q?7XWu4FSsZA6jvhb+OxvkjWCB6GZN6tMeijb7l25pRhY0oUTOFCAQT789?=
 =?Windows-1252?Q?m57+ifVHmLpBYhX1lQNrVkFdmhkEd8/YgUIYuMutFsqH+bw33fF8j2Px?=
 =?Windows-1252?Q?Kyv+LxfAUcOBlJxDTqEiYIktRUYuzqctY2LWCfxumT/uleF+enJpcg76?=
 =?Windows-1252?Q?Gb3X548Vx9kwiGqwmzVfzIKu6SfPydGFxaqQh2xJ6hZ2EmQABa/V7g?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11862.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a37efd0-e956-4729-3ab5-08dc3e891504
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 09:29:26.3634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fNqd+jug6Y0xXl12anvb5SfNSwkDln2/wuLCR+zoC8QrNsSmYN0N1mVX5Snm9X6lYqTyGOnHLXd+ypwH1kB2xM8PApG5JsWM0HpyeeRC/98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6025
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Mar 2024 09:29:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15261

Hello,

> From: Pavel Machek <pavel@denx.de>
> Sent: Sunday, March 3, 2024 10:23 AM
>=20
> Hi!
>=20
> New -cip release should be available at kernel.org. I'm doing it to
> make -cip-rt release easier.
>=20
> Trees are available at
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-
> cip.git/log/?h=3Dlinux-6.1.y-cip

Test results:=20
- Dashboard: https://squad.ciplatform.org/linux-cip/linux-6.1.y-cip/build/6=
.1.80-cip16_c4a8a3898/
- Summary: No new regressions

Kind regards, Chris

> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-
> cip.git/log/?h=3Dlinux-6.1.y-cip-rebase
>=20
> And their content should be identical.
>=20
> There are also tar archives, at:
>=20
> https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/
>=20
> Best regards,
>                                                                 Pavel
>=20
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

