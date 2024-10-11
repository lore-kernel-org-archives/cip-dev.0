Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C37CFD308
	for <webhook@archiver.kernel.org>; Fri, 11 Oct 2024 09:12:59 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.54])
 by mx.groups.io with SMTP id smtpd.web10.7300.1728637973533917826
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Oct 2024 02:12:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=FeQ7JXan;
 spf=pass (domain: renesas.com, ip: 40.107.74.54, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/klP3askwqzgicbBI8CIMsAU0QjxWsJk0c0NNjOlHun1ayvk27KgJi5m2wKODa4tzNcUeNSWcKZn3n8WYGPQMX7mqA4Cr1Vc2ID9UeypS7jubuxiVddEptzgR9F9FMEtu/gNRSJKO1Bsx84Wqsb1ytUbkujz9+K7IuwmVpBfwDE+qMD5aIet3sv8UFVaNRQtVv5RFl3g/asA8/JZ+fZmJXwgFgaX0PkaK9pxz0IsdKdmLq7Xf1stLVehl2Brl4Sl4iZZa5UbYj3qaoMxJDoLF2Wcu2eG3cFnbnx3ovKLa36hHpWJk6tbOGJDCJkaGHC1F+DMYLlYpz7xbIptiIYsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DqalfXZPIz3e7VWUE4kIX24pqpnX6AnvIYjwJ6PAXC4=;
 b=zTRE7QJ6v8O5SjJPhAmZHINTbKcgL9hxgcppWZA5/L4xNnYypRl/mjqosMM+P6sncILchePhTCGdzfA/+UD7OG0hMbCeWjdlg7vttLNXRZDhMr2zuReZfH3BbinRhJVNXEVNOthNbai0qq4ynlsNpF20q1QSqkOPU2AGkfEYvc5zCuJEf7M6wzDMZTcpsbu/nPfIXBbtcEUuO1h0UjKVUOe+SHnjypnsmNUg2XkmZCngtCHaE/B52XOgYcQ97Hz0uXobzyiqq/+DP41jPc6UGJbcLAXpsskBqzeatX9787b51cNqENqv4zN/rBlHglsUM2QLgUJU2+uHWQy1dI8A6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqalfXZPIz3e7VWUE4kIX24pqpnX6AnvIYjwJ6PAXC4=;
 b=FeQ7JXanhe+IpqWU31Bh44XHWLahGZzv8eyag9u+GmFCu2o5QXS1Ce/HcOE0BywhDkdq0Qfafb5nwfiDcY24/yCeAM0zbgxRVUNaDk+xXNUBlmbSZLu4crocS9VKYKq9fNywDH1ZhhOSsXrzXIVNxuNk/HTie5n8pU3Olh1M9Ac=
Received: from OS9PR01MB12389.jpnprd01.prod.outlook.com
 (2603:1096:604:2e2::10) by TYWPR01MB10458.jpnprd01.prod.outlook.com
 (2603:1096:400:2fa::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 09:12:47 +0000
Received: from OS9PR01MB12389.jpnprd01.prod.outlook.com
 ([fe80::d85d:3169:70e9:6a3f]) by OS9PR01MB12389.jpnprd01.prod.outlook.com
 ([fe80::d85d:3169:70e9:6a3f%4]) with mapi id 15.20.8026.019; Fri, 11 Oct 2024
 09:12:46 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: CIP LAVA server in maintenance
Thread-Topic: CIP LAVA server in maintenance
Thread-Index: AdsbvaofWXTrh3nDT/GQbMaMBC5Hlw==
Date: Fri, 11 Oct 2024 09:12:46 +0000
Message-ID: 
 <OS9PR01MB123897F6696DC068E8651F46BB7792@OS9PR01MB12389.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS9PR01MB12389:EE_|TYWPR01MB10458:EE_
x-ms-office365-filtering-correlation-id: d153f83e-2528-47a6-b4b7-08dce9d4df59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?6MlpqRlH2S8rNDqRppuUpXLrlPyNcT35W0amLR35YZ1MkhzS4W6b3MFZa9?=
 =?iso-8859-1?Q?dzIHwFt8yxd/uMJ/pMZuFO+LNzbaM6ydmO2rdd9Plnt7GJaGWYi4tzzzSs?=
 =?iso-8859-1?Q?KmY32mbYDcp5mmEdGHd4hCUhto2rd/jt/df5Mk/tBysaLyCfqkNGpEnvK/?=
 =?iso-8859-1?Q?tuZPBZFR3ZYQxtheERMcz6Yz/ciWyTodDKu8RBa1PfLmpqjbdeRVH7TQEA?=
 =?iso-8859-1?Q?98xkRkV4pC/IX25sdS18B6U9tBv74S0KbJWHOgMhpS6Ur04vwhkrLdYe46?=
 =?iso-8859-1?Q?dntJxjw8vI425aaY06fHoDCNdBk+LS3g/g1HtG82nX2wA1PeTo8BSY3u8A?=
 =?iso-8859-1?Q?0dz1qNIk14OJn9cI71PfQOEapToOxpLCn3vgOqpqXxkjmqznsJ3NUp9V6H?=
 =?iso-8859-1?Q?VuZKWTLaGv3A3Dxv+G+QoHNNj9Ar1+8AC1rpN5oiLVAPbn62T2RENl1hgZ?=
 =?iso-8859-1?Q?La+RgdVCW+n1bzlMRHjPXhn37xTwPghr21Af79GylHOvqhqbPrX1u7KxaA?=
 =?iso-8859-1?Q?EmG3dosKOXqajAxSsu5Jkn+8xkEyiVm0zbFZNsyuc10pz2qIlZD2kLQODz?=
 =?iso-8859-1?Q?6THk00ZAputUVPfsDtsTIne48l6Vf5N8zX5a/xfrdY/K9Hfh2ReVGtHXsd?=
 =?iso-8859-1?Q?yNTuWTyDa7yRQ6vs/KO3m7RFZa83H7fsryKaAtuGr/MLIRkynoCJm0b82y?=
 =?iso-8859-1?Q?/dUnT7VtqHEqOwxcE6vTkkMsSuYb2SBpctSwlPaTKUJef0NToNPUdO4Vhk?=
 =?iso-8859-1?Q?ftCdGz11wOD3xkpABJH7hklf6H8g5MQ4cGmo8vgSGxXUK0oY5dhv8S6lnl?=
 =?iso-8859-1?Q?4CZMBMyyej9Docxwg8WbzeRsVFj/nERHrfj6iEIqnwKei4Bwv/SUmiR2Yc?=
 =?iso-8859-1?Q?VUpOX157GJgCnEjKFWqKyhyvkgfWMyXg1zMPzKMh1dDyQJWgoc67xqR/Qz?=
 =?iso-8859-1?Q?7ky+D7KcrCYORgTUpvh/s6CplxR5Pwa3y7uqHOQkWcvSabL4pOZeLpdjOE?=
 =?iso-8859-1?Q?2aGHK0vUmMPMNzGgSZIxZiXVKc8kPSmaurOgIpd4WJ/gGYYZEGILkRhbhD?=
 =?iso-8859-1?Q?gakuyR77ywXX7yKqa+l2tLbcBU9tB6F4/f186OtaGGF0O1/kzmLSGoWATP?=
 =?iso-8859-1?Q?0tU5WA27sRjQ0QLHfUIkW0HfAQio7ts3T4QxyPj3XfGWBgDkhajIlKOfsD?=
 =?iso-8859-1?Q?CTbVs69kcP7ZE4Syya1j13btRjQJPRnIFO6N/7Vu5+uz/jHXHS3dt0q22V?=
 =?iso-8859-1?Q?tV0BbN2esqI61oGshMgjo/nmZ2vjGVFJqMxsAVN00j8jmXcdlPUXign6pp?=
 =?iso-8859-1?Q?OXdxaHyuTT24r8RsW6yUF53r6YhfE9z3ubkMqyJoYxCZNwo7p81Vh4717T?=
 =?iso-8859-1?Q?n5lUeAEdCHZcFF9paz4Tx/gEfJiIqufw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB12389.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?1qDd7r1AoLh5bjf86CI3ooOqErNKizOQFBj1Kj9dqu+Yqa7DRvuIZdlblX?=
 =?iso-8859-1?Q?a+09qo/ocgA6ediRo+66iJ49gRWQdgt+HrhjVguaFfItmqiMRd1py9snAJ?=
 =?iso-8859-1?Q?IpDnYAu3sIcpkLyCggZISG+50JWKiBDNPyjdtegM/Twe6eEB86UQO9nvn7?=
 =?iso-8859-1?Q?+WYw/wmeUT6Rb2FpoZOGJN8Yb1/7vMLOI2i8ijakK8iirC2Lap62vnE1ow?=
 =?iso-8859-1?Q?oM3ufxlZ7cIkN8IsGUwjVdRVA5oEitBVLatksqa3oxydK+Z0aPNj3FiIZ0?=
 =?iso-8859-1?Q?7UCsfghgFLGMncVTH5eS8IJm7LYqpj6mlfuCaFgEgOrEgzi0X61wCFEs2r?=
 =?iso-8859-1?Q?xv1CpMrS3lM92C0FghRRiPvsyNnOgbofIQ4XswFwnY9i34j4XpS03Rteqf?=
 =?iso-8859-1?Q?krwiQV4mr2ekaswxrOoSS/syg5shEoeRlKfzsy9qRuEgIc4sKH4XUUxhcB?=
 =?iso-8859-1?Q?csw4KgwG80AyBvV4GzuI/UQdT6RM0b6bnXc9VthNwO96cf17ahReqCAsgq?=
 =?iso-8859-1?Q?elV7/3SSqKlRNBbm7M6qIi26fbYMMo3fD+fwgxJEQ/GPTA9EanaXdMCFmQ?=
 =?iso-8859-1?Q?nL9vyWEtoFPgqaTeAH5CGBztIRx8NjSmYqDnabVkB4d/DqTUIuN3lHbSbp?=
 =?iso-8859-1?Q?gdSB+a6ELUQGQncBAaUdnXQuX3T5y8eGaVdKCSC/ZsJ/XFp5e3k4ZjqG9k?=
 =?iso-8859-1?Q?pwV6l/4KjS8niY0xPOtXNnu1aHmoOvJGfKAnD2g31cFqkLSTALza58wg9S?=
 =?iso-8859-1?Q?3CmNhFiS9lWj7FcbjElldOWgvR92BKS86WfgtuYr3fRUiiIq0EtWe0OO2i?=
 =?iso-8859-1?Q?NTF6wrbwyLgz+wEwWlVW3dVUfyf+PbfxKm6JBDSGbP0K/nO6vlk8gg0jc9?=
 =?iso-8859-1?Q?bLAzZLIGSC1FaB2kg9YA+nZBb3GHigkS6QAFrncQw3l3r4ojMlPRlnYURy?=
 =?iso-8859-1?Q?dyb4rG8aNKTsl/VNsaeY8Rxu3PA8RMxHb6+NwQNyMKMHl147wp3kkHIgfQ?=
 =?iso-8859-1?Q?BvX/ChQKZwUgrcF2S9tf66/5XBQnvaks6l02hPNpYNhFTIV5VZ0kiMh8De?=
 =?iso-8859-1?Q?KOBmr843CD8U+EypQPYjm7bkJ/iKmOOuA+yHiJFjLTNfrVb7fFQEcPhpFq?=
 =?iso-8859-1?Q?U6QYTc70u6EHutrzMzBEi7wu9q2vxCGWX00mm3k2jmP5nSqOaLX1q4KeBu?=
 =?iso-8859-1?Q?1RQJ7UnUB1OM4/00Vy6dT6Fp6viTA1xI/YGtZU6UzrEdw5OgXM+xrpFiQC?=
 =?iso-8859-1?Q?3fwnYqE73ZlaMKIok9ej9/YFsox3cl7rT+3IyVXm5uz1nH89+61z8DHglR?=
 =?iso-8859-1?Q?bkaCvWNw610L9wELqennNw8O+YIvII3njl3uzTgOSeYdSz/IcmZ3qdhETL?=
 =?iso-8859-1?Q?raSk6tzJBPc6WCdSwf9Mu1enct0FKPROcdg2oxF0bLd0ZlCPL3umfna8W3?=
 =?iso-8859-1?Q?RJfoG2lFw+JbPkshpjkweNj3AsPlNDqZ0UzSUTyiAqfVSQPKXUXA3S9bso?=
 =?iso-8859-1?Q?Plm4vKUq7UO1RjKspRimn14HeHMyAB8lrrxz+CivTqI8GiFUL0A05b6lry?=
 =?iso-8859-1?Q?ZNKfyPUyfkR309/TzOj8vv46eHsTaepHO6jHH4twfAStwinfZWBtp482sP?=
 =?iso-8859-1?Q?AgXERVx4+wwqEHA/jaFDdy5F/YIuuZqiO2GX78BjtNsWWH5Bpn8+JhpQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB12389.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d153f83e-2528-47a6-b4b7-08dce9d4df59
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 09:12:46.9165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4yzEuJ3IQuusQuTPat5xLSyb5CkzhwzJnwMSfwTxry8lQySGS/6DkIF213ANDl+sPcJCUNiZpKELJ9d1sAfCxNbLghP6Zj2kbIPPM+ng1d8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10458
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Oct 2024 09:12:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17031

Hi all,

Sorry for the late notice but the CIP LAVA server is in maintenance.
It will be up later today.

Kind regards, Chris


