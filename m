Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BA2CE79AB
	for <webhook@archiver.kernel.org>; Wed, 20 Sep 2023 07:43:52 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.130])
 by mx.groups.io with SMTP id smtpd.web11.31787.1695195830410737357
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Sep 2023 00:43:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=ZRK4GzA0;
 spf=pass (domain: renesas.com, ip: 40.107.114.130, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5m7d7JiOP/SwgdfE0f1bBtsUUlLX9mdKQ5BLtsRT1sWmWYt6U70s/ZTkF+Xg3Eo47qYr2un6O9+O5N7rDYK02XaQHCyuAGYJOojJ3WNeP2JdqOwb8bbT0O4yfRS4H5qTwnNza8uhxG+9UQa4R3S6fuzuFbaw62VIoVChq+C7msFUYkeO9/QRHMmLm7gihdkcuBi70+lJD0FEmLxvPtCtbD+cZ0nOvzyNapJWgmgCb/kpiupnt1McsbWf18pa3LrCFzHk4Zm0AmYWTSht4R7f5UMg9be1iTRxRxTOu+6LKUazw92ayL7bcBt2drwJd2+oT/rfJzU6hdOfVSLK0fB2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDJ9nr7iqtQAxdiX6e1CMeAt9MLBanQ0/b4ql5Jb2U4=;
 b=LNJQK1Szmjt24kk6Y0bVeDhImmaf3CSY+6andijaeNOwnfGy7lW7zYW6/+IYAbFA7WEUhzIa4oXaqbFEeXOanzt0XYz2igtKJF/tUHqYvm5bI4AClUDlod7sCEBH5VL+DFRVjvrU1vhF77ZZ5yD1QhvdRpeMWnf/bB/ReLHEEL7NnzcggA6+H96CVN1t59N60ihzDyhopUXY5eBugid4zdFGjtZofWOBWN5RcNnepMwu5UocKO+hvdrDJIwQIzoBskGh6b51nm85RNylieEq2FSuvFVGfhO6zgIgtgfGL2iX6CEyfE9JVK7aPd1f0qnoiIwoR3KdaHOvNsoKiphTAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDJ9nr7iqtQAxdiX6e1CMeAt9MLBanQ0/b4ql5Jb2U4=;
 b=ZRK4GzA0Th/XCXlgJcl56VNJNTnhKrw/XntXY11ozuzErvxElsBANjcV4HsrYzOrgFAvcQd/iKn5VOOelqkn1VXustxttjNeUPTSU5/yb1ZuYb6IVhWPg2SWCEQi7HE1KnukjUfVzAl6p7I/uE2hMxkjSKAU/8bQUa/SBtJF4tA=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by OS3PR01MB9771.jpnprd01.prod.outlook.com (2603:1096:604:1ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 07:43:45 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::5cff:5d90:9b08:6a7d]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::5cff:5d90:9b08:6a7d%4]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 07:43:45 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, "nobuhiro1.iwamatsu@toshiba.co.jp"
	<nobuhiro1.iwamatsu@toshiba.co.jp>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: "pavel@denx.de" <pavel@denx.de>, "uli@fpond.eu" <uli@fpond.eu>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>
Subject: RE: [ANNOUNCE] Release v5.10.194-cip39
Thread-Topic: [ANNOUNCE] Release v5.10.194-cip39
Thread-Index: Adnq8bl7whuogWpjQ6GDs4st3ouSugAkxliAAABYEQAAA/k/0A==
Date: Wed, 20 Sep 2023 07:43:45 +0000
Message-ID: 
 <TY2PR01MB3788707B48F756B0D5F1CC5AB7F9A@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: 
 <TYWPR01MB9420C4F2D1A4D50470E0E5CA92FAA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <0de9f4af-bf37-4bf8-bf5c-28b2b6d7fda9@siemens.com>
 <9f3cfa5f-d448-4df3-a2df-d7d20af9b120@siemens.com>
In-Reply-To: <9f3cfa5f-d448-4df3-a2df-d7d20af9b120@siemens.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|OS3PR01MB9771:EE_
x-ms-office365-filtering-correlation-id: 457a317f-8c3a-4d69-7a8a-08dbb9ad51d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 DJ16Q/V+zkyBrCS9xwC0BrLHFAzv2M+FQdxNx8Yd0RNM87WJYkmUaaE//xYmUSoTXp34cbrAEckgu0SMpubkYBVlYRT8ETc3W77muTBMaqFkxlRmGPoLMzSEmFGxgGTU/65oKJEx46ZVmqUwBd4CMsJMhm6ZdXgaIxx02mOf3P3IWl8pD7m7/C1saJjdv+S8h90+N9qsc8uOmR5mo0kJ5ulQ76wpLkB+HqovMSU73D5aIBsRr2FKamU/dTvAK9mxgR7tpMC312WKQG6cAVfOJBXJHhKCuEWjeknX2PPv4930m+4yKrZjwTFl9kt8xzBB21T6B5vvKq0IYTB8Y7++9ispv05EQYEREqFDzi6x2FNzlkMW5yzqUJ5RHcFCU3MQNWx0Oy4dMf4F8gF/8UamAoD0rply9/bGlt2FuWV2xpbXnWm8vm096GchatvCovQpDuOJcY2WPNg3D6aprGtTFfEhlmLCAkbcUwTqUIjjnDIDd1xiN0OK3DjBpp/pHKc0UcUOotkleXRH4TCd3WPceFiNTOGyXqE1pPcY20+KpJwvrogHddA4S1kWZkLsjMUsE/9jhKjMAOGmpb1KgTU4VmazDEgH6UrFpHjEAF3XtWL3+YliKz2hLRHuvnpKe9rw
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(366004)(346002)(396003)(186009)(1800799009)(451199024)(7696005)(6506007)(9686003)(478600001)(71200400001)(2906002)(66946007)(76116006)(26005)(66476007)(66446008)(64756008)(316002)(54906003)(8676002)(110136005)(4326008)(8936002)(5660300002)(52536014)(41300700001)(66556008)(558084003)(86362001)(33656002)(122000001)(38100700002)(55016003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?ynYejctAIaRUM+P7LDM9ISzE+ugpXRPfgYvdUp+60DU3kIXKeCxNJQ/E?=
 =?Windows-1252?Q?p1RaFAQN6GZamb94iRXqwrYq+s546HTldU6aI1d4zBfy8yOt2KCXbHmB?=
 =?Windows-1252?Q?XfPVpJooBWHZ9jxm22QkVIUmtWFnExE1xbiu1xTOJSffHEiQE6VG/FoR?=
 =?Windows-1252?Q?gAFvDIFxg/oHO6tCDBPSp2fD8mHBqg4jHboA1DYjDliCC/5Wa1MAVgM7?=
 =?Windows-1252?Q?YvES27rZPgDI1Zwk8GHu3NKtJmsB1sPFs/knphsMkh7k1Xk+OWdlRi/B?=
 =?Windows-1252?Q?GOJVRO5qlndZz/94EuomgOqfQP+ovkmlh6qglZqIcaG1WTh5nxBY9O1I?=
 =?Windows-1252?Q?ZeN858YOCm8ndG8gbIJoT4zQ6jsWbbqyp4ypBlqWBsOXGsOasvjKGcMC?=
 =?Windows-1252?Q?4MpqetsXWQ4iCo08QwsmvXVEeq4bFW8Vy4TU9fA8LGJRYVEclW9Emn3t?=
 =?Windows-1252?Q?OPvKxtdzNJKdfD6WsO/JBN1PPdbVWS4vQyThkOpgs8bTYY4+8iL4NYzw?=
 =?Windows-1252?Q?CSzaECRUacV1DknoaIvEvNW6lMVz+toHCqn8bI3iMhHfpfLZBymLU6Dm?=
 =?Windows-1252?Q?lAQ7n6+8Kv9M8KDLzKQojNabFBOrKvLCee8JWNgM63nhD/WZKxZedz7m?=
 =?Windows-1252?Q?rrz1rWTE8ajVznu946qLOipDSeKJRtAY/Ag5ATg6TzBSqV3xeg0MkU0/?=
 =?Windows-1252?Q?OjgoLsAibEJ3zkBD0Wr95FFfP1VoqO3AFCXA6/kZbNhDvSmR4rz9d8lL?=
 =?Windows-1252?Q?hKrS8tOcOLXIo4GLpWEEavwo9FuZZ6318TdJe+GF4J2ODTp0kRBQhkAU?=
 =?Windows-1252?Q?SycAVMvFUPye4p0Ol/6ms7C+vB3jh3NtXXSNp4uc8yWjG0NRSSC0YCKh?=
 =?Windows-1252?Q?tAN3czq4+RALgo21eo0gKbw3Kzxz9FJSioTY1d5Jn2DzYdNFmEJHqIxr?=
 =?Windows-1252?Q?XmWzQPYPDYKvEM4edI8qEy7TLMhW1KbPSXhs6ug5fA4Hc21U5X2EH0OL?=
 =?Windows-1252?Q?XL08mIIe331Kl26HJW/79PXjZl8jAUXn1kzYOlvNpXakRX6NygXOgVto?=
 =?Windows-1252?Q?r9aWCGbQevwm10WuenD0pNlQ6yTSShkasszTc6ZDlxkGDPRpmtCqdDxx?=
 =?Windows-1252?Q?GnfCRUP4hCQzPmYfdjXPI7QdgPVVepTFFsZEFl9qYbWiAeNVw7yvR0Lr?=
 =?Windows-1252?Q?HRFkCd6mSDllbKXm1P5M3tvu1vL2wJk77d/GEB+iIpN0kvvL8mgYxg3f?=
 =?Windows-1252?Q?d0c9rcsAufwa1lNfetsuslxOi8iwQN2M0wJVfeucyPZ/4n/zn4+qY/Zg?=
 =?Windows-1252?Q?Yyu2ly9HMSENqrPpkLfSo2S9+Bvo+nnGBfzO0idaAhLtoUICwMm0f6pK?=
 =?Windows-1252?Q?hj3oCNx/iJCjQTSZnJ/Grkd957a3QvxvWOMs+fOwKEGtAG13LUWV/uug?=
 =?Windows-1252?Q?DIZTKoIiByXGAcW+g94Ke2Q+k3xZ1cixGyR2xRnIIzGTB3uhDh+BOM0H?=
 =?Windows-1252?Q?qZeDY7nYJ31JYPdULvlrS5woYraiA5sYkJhJrn9Zu75if1sOTmlMHL1i?=
 =?Windows-1252?Q?jEuaQGV4J1PlNdkFnzLGiQMBRaGa5eQNL7S5KtLPgZLZ3pn55LJ4oLok?=
 =?Windows-1252?Q?0Jkd3jKzlRQYa4nUiDUaSgvo+6D6Ad0M2oBhW0CGhQ7WTjDqr2gTTsRz?=
 =?Windows-1252?Q?k4+v/sDk5Xm0eqflDMxCsV/+NzuF2la42mlT+Rav1JbLeJDY38V3/A?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 457a317f-8c3a-4d69-7a8a-08dbb9ad51d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 07:43:45.6187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 54L+T6KZPgX+F/JU6Pg/KIEQSX0A5h5Dl+FB11eSMy23h6tpCwRYnutwsXPmUJ2JxVPua8Gj7++6GYaQz1tztyDM+g27ifkh1visLvHjA7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9771
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Sep 2023 07:43:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13180

> From: Jan Kiszka <jan.kiszka@siemens.com>
> Sent: Wednesday, September 20, 2023 6:49 AM
>=20

[...]

> Now that the folder is filling: Should and can we structure it in
> subdirs according to the major kernel versions?

+1

Kind regards, Chris

