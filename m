Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49CCC54E65
	for <webhook@archiver.kernel.org>; Wed, 21 May 2025 07:04:04 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.8])
 by mx.groups.io with SMTP id smtpd.web10.5170.1747811035195479803
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 May 2025 00:03:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=DQI/YQxi;
 spf=pass (domain: renesas.com, ip: 52.101.228.8, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0fUn+BBixGMAB8vpnD+O51Lvq1Xcm3hAGOESuTcjLKGq/2/66l453nkUVHNARWVhp9UrYe1yb4tOWgX1UtHytJhApNMmlFitVYgZsHy8GM7A27W/Z+ZHTC2odSuQzLgIVFBv0WANwFLdaYK6U6h+lwIh+QNcbHxVTR/AtQsjPz9p3gaEK9vOEtpMS0umf9nYL7WB0I0ALf2cRdSdOy8uFkTOQpL79QIOm1dfSIil/02Qzv687VbSKvg1mTZC64/q/+oDciInKsq3xy6xBMMPMLbm85rl/hXb255PdDMyzqLcc9wzBi+w0Lpyulx0gveEcBojtalByJBt26xkWOyKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIfv1LP6DFbVoDt/vV3iSZTbybJDvKuKK2wTPPIEZvA=;
 b=QFco5oATtUxalg12TRN3sJN9foS6ZET6ou/V9/3hdZ1g3qjrMbgThgtPNuQTEbhmrPUQ8icPjbA249tZ83RBYXURZOtlHtGhqfjkBVEB83K7VYjsTW5MAnd5inOdjUjfdc3SFDPGi8XXyyIxiaO3EtnXhVduIQGlCP7IlEYJa/PSl/394bm/nc9rpKA/sP1VD8iH0X+V21voamkdC47dGBXs5U1FPokQxGptThpfpMBfaEwCXL1/ecB6nrfyRC/zPAphGTprGrKPLp5Cg0fH6gzrwohSjLxI+RPmmOMyfGqLgdC9aBKUG0CINYtYSeqpPfb1GVxmhAmSa9sPKrz++w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIfv1LP6DFbVoDt/vV3iSZTbybJDvKuKK2wTPPIEZvA=;
 b=DQI/YQxiLSn6G7DtlImamC0t1RJVEIh+g9tdKw3HkOHLNOYZexe96w1iH98psRbamM1RphnVyhyKXD3if+r/WEQ+7RiTILErXCmrsB4wg+8SP6rbJw3ZGEZM4IZBacmCBRI4P46rwqFveGZc7ThpBVmxo38PagoqL6MqVRl1A0U=
Received: from OS3PR01MB5896.jpnprd01.prod.outlook.com (2603:1096:604:c6::8)
 by TYAPR01MB6044.jpnprd01.prod.outlook.com (2603:1096:402:33::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.19; Wed, 21 May
 2025 07:03:50 +0000
Received: from OS3PR01MB5896.jpnprd01.prod.outlook.com
 ([fe80::1b62:57c6:c2cf:641b]) by OS3PR01MB5896.jpnprd01.prod.outlook.com
 ([fe80::1b62:57c6:c2cf:641b%7]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 07:03:50 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: -stable-rc kernels are not being tested?
Thread-Topic: -stable-rc kernels are not being tested?
Thread-Index: AQHbyhuQiJvOYqsctk2/TGcOOkCYerPcqA0w
Date: Wed, 21 May 2025 07:03:50 +0000
Message-ID: 
 <OS3PR01MB58962F9214ED7C7DB899B5C9B79EA@OS3PR01MB5896.jpnprd01.prod.outlook.com>
References: <aC112tFkcRZb6YAG@duo.ucw.cz>
In-Reply-To: <aC112tFkcRZb6YAG@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB5896:EE_|TYAPR01MB6044:EE_
x-ms-office365-filtering-correlation-id: d6804e3d-5add-4748-4510-08dd9835a38a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?Windows-1252?Q?8900vFZ5ovml0BZAFZ/R2wRCZc0wjUtJbfi8gZixJDe0Xp5IgTmggm5r?=
 =?Windows-1252?Q?TMb+0imo+8WKdIAX1BUX+AuaHDCPzv8zi5K/sY4hO63MlxheJ4W5newL?=
 =?Windows-1252?Q?bZN0OFYSVfXqr6i1s+iBWB4JgHe2xZXI6jHyqfYV+KJsDLN0++brzF8p?=
 =?Windows-1252?Q?9y/xAveXvEAxuXCqJmHz3TNutD8Zhp8iu96xUB+KixtPTPjjrpnn8831?=
 =?Windows-1252?Q?0ggMSeOgCoNnwBs6dt/GIL7yIz0vjCo/Ezz9+sWHUhr/bZulG3obBWCf?=
 =?Windows-1252?Q?RFjlNGGhuGe1wdQH2ymAiY7hr/MbGPRQmlfkfqyqr0SROLvPMuSCi36K?=
 =?Windows-1252?Q?ewdL6q7DdaZ+ddJ9FzEAdxynxm9O5bGF4trlFd3CusiaH70UoFar+Fz8?=
 =?Windows-1252?Q?CJEjBekGkR8h3WdiTVofUfbdINqA1IgpF+YegxEc48NmP6ZSwkNNjPp2?=
 =?Windows-1252?Q?vA6iykBIp6Y7CvgZKinBxh/2b0tpu214uxlzp1Ng/rjfra2ReuJsrXoo?=
 =?Windows-1252?Q?LMnQAeLEHjO66ZIZiXNoWfQ0b3BkDlcL9+RmWbqaTzqgCEggTLEuNXwB?=
 =?Windows-1252?Q?Hpcj9hYf895oPsUXipW3qYHFLBekKhbW+sk1sTlVColjBr7w82HyBbFr?=
 =?Windows-1252?Q?40cUmiIxYpq6Kz8vRgn2oKkBBQzo5BUwN6a08hwx8i+kz7u/5AosdWgn?=
 =?Windows-1252?Q?OqnnMwWs5a3gRHvTP0DokaBGLDiUKVlhWpdikSc3pFNvx24RrmTnmGTA?=
 =?Windows-1252?Q?7tYLI+ZENWa42F83CLnltE8hgPiCzKpJP0tKlEkazp2bpnagtYO0iazj?=
 =?Windows-1252?Q?xoowptjWqH6vWGMKkyr6kJgsIkY/PFdk9JN7lnC+5XJfDdNg7BLU9RnR?=
 =?Windows-1252?Q?tD9sS+pwkBotTeDPzflQX5Vu3bhSfSxAuqRCODHJznQzefAcQKdNS+wH?=
 =?Windows-1252?Q?Eq3aoBJlvdjdAjk2tkjw9anwYLuyPqs0SqGXEAReLKyJ59YFRinppLgK?=
 =?Windows-1252?Q?qOhKplcpOXGwY4Q1oMvudKVSbU3pF6FbgNFP7RseUZdU7qHgRFtwvXcU?=
 =?Windows-1252?Q?KIS3cfb/rsd0X4vNjRDd6fxrlymzyeQLPYrsKnt/qQ6Ah1G4hKcFdsKl?=
 =?Windows-1252?Q?FS0sen7oSmKLEcmMaPFyY3psMnCfK/+ciIOtvQFATJv+FpPYmO6aYoMt?=
 =?Windows-1252?Q?xJyI1OIK+ga5+zWOrtYhqOygo6aXMpcvfVanMH8dr3+edHdeqUM8Xo60?=
 =?Windows-1252?Q?pinaJUgl7jim4eM/lqTorxqrDQddu3lMiKr3GcGwC/N9aJBx9QKrNb4B?=
 =?Windows-1252?Q?9tDIp6zmVRNyVfvkjed9O9FO9HX8E8VozzGeBp+omk5H9tAsNDPOgPM8?=
 =?Windows-1252?Q?ThWC3N8e4lvBWOuzY5SNCQzc5epdsbMwcKN56A0cvgh2dZ3sHKd8ooLV?=
 =?Windows-1252?Q?ON2zGdwBNxO1DtptxN536LDCtUKLrSt5ge85CwIdFGuCUNjAJ4EZ/wZ8?=
 =?Windows-1252?Q?AtwW7DifWrXfWD6DGuH3DHeVUJSBF4NOiXrJgao+qGaKTkcw5Uk=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB5896.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?MiZCJf70DsupXSUMWj2BUe0PD+Q7Sfm1aM5Lte/gV34Vee0N3ezCSuih?=
 =?Windows-1252?Q?/62zk4wIikrYSX3H+p/GyFCAvdedhmNf5DzH7u1JKgWH/b1+kE3MDekY?=
 =?Windows-1252?Q?OH6XiTs/LLtbS0/TWX43d8wTIWkQdZTIbojAAk6y8CJbYiw8eZU40a8g?=
 =?Windows-1252?Q?JUHR3P46nBjQB8fkOUVvp3XnHFXT6vlrtcVCCY4aVCiMkeVJ8xi28HpO?=
 =?Windows-1252?Q?LkCgiZ43SUtyx1LQh/bOw6/yN3ENMh9VjUZHCWXSPOzBTKqCpVav7gY6?=
 =?Windows-1252?Q?zSCd7mS17fuyEJrDW/7a77i87WFpoEcRrtCY9kYcSq16xCmY1zyj37S/?=
 =?Windows-1252?Q?Sx6da5vCoF06uvK0aqm7CpmPf7XVrJG4KjY7Y7hdfMjnNI2xgjXs8R88?=
 =?Windows-1252?Q?4L7Hgg7pz5LtKntRW82gK+PXQ6vxvIE0IHFDeapWr0uZ84b1gvn/PIhx?=
 =?Windows-1252?Q?A2inw2rOrTuaHYTUMja1AU9MnjEG6uMc1afgMMbwus3qW0+yNt2+j9WE?=
 =?Windows-1252?Q?/NLuB/DB3F2QPDQ0BkynVbRbcilrv1OcrGHGHsDFWWd1UX0/s5h/WcIt?=
 =?Windows-1252?Q?Lx75OWic0h6B9Ue8X1AZItsb6jGrLJDNtK991dOGLXGcV54mazPp6kJN?=
 =?Windows-1252?Q?5IrB6CN0tKDFQ7/WzL8BRumqUZ1IsQVJw3KyQy5r0nzKymvJHCq8f1IS?=
 =?Windows-1252?Q?w3YrgfNzXZ3UIyQ1zSLessHkZh8gtFkqBqs8ljb7X2XLQtzXSajVdGgK?=
 =?Windows-1252?Q?8kfXbRF7fjbrtPSq0Mg1xBpRKb5X5ZFcbjIYsMpNHCmdYEoUrL3w0+XL?=
 =?Windows-1252?Q?o8HfJojRSAFUiTvjkOY4zJKwqjkYwAfpILQriQw+7eJLrSf739S+0Uuo?=
 =?Windows-1252?Q?Q4epF26I4qXkX7hOBWj4Xt8BaK3kYVXG43PG0LXo5rI36UUQtoY2+hbO?=
 =?Windows-1252?Q?GDlcOVUGOVyxR5fo8IL7YBUDU9vId1W/lbkQ1Dwq7ox/PU1T6HlHjlrl?=
 =?Windows-1252?Q?Eym1tNYrP3xegu+V5/Zj4hNDAM2zPIUFm73Rc4K/YWz7gQ/sniQDyyej?=
 =?Windows-1252?Q?SrP/MPf7FW37etIhUXi0Dr70BcuYE7mgzXuh9SThVf7uAegQ/P3USIJi?=
 =?Windows-1252?Q?HRIVVUBCbzIi2919x3KHhtqPLNtNdtHf1i9N0sTNRS8pkBVr2Z7X5adi?=
 =?Windows-1252?Q?LixQDnoo8hV9Qtw64WZW6Xle5kx68KGasHNL8bqaqVWwlSFPlYhl8Ehi?=
 =?Windows-1252?Q?LtRZ5JNZsysQ8HAAfBUwECMK+2mEKxDgqjf/Y379mig6nNfTH5XSZ5nZ?=
 =?Windows-1252?Q?WY+fdPDYx7fovedELs2BAONA2ad0aQGwjvasAQKgh3CqN7wGEPzQxDYE?=
 =?Windows-1252?Q?2Yph36Buu+bgMcHJt3K3Cx3Kw++gb0hxKO+4/jZ6F2B9th4tQ16y08ty?=
 =?Windows-1252?Q?Ub9/w6fkqMH5gJJ3SmRJhT8t/vqfQSTJuF15zL7svo52JIMzCOdgrHPK?=
 =?Windows-1252?Q?FPCmjib1HY0667A3kDJUIlfj6Y7s9l0mfjE8UOj+vh2hKZq4UzAAnvub?=
 =?Windows-1252?Q?PQIfcuRuhKs9lpd/g+h37W+s72YnotKRVvkwqU0Hzwbg0R/ZQhl3Ok0g?=
 =?Windows-1252?Q?ux6M+QLTmMqYgzN0hg5rsMR/jE9tZ5J4yoy3Mf8bHwle0kvSxcFNp8qP?=
 =?Windows-1252?Q?a0XI3OwaT9+Fvbo/NKOHG+HHa/KDlzFpRYFjebRCJLR7nY8nv7PEwA?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB5896.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6804e3d-5add-4748-4510-08dd9835a38a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 07:03:50.0867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YHlq1NBflONUmzMNxaonvihxq+hA53iKkq6RrS/pFH+jki1AKPgJZhix8Mp3C3BN4vVfRWw10fzYWicfgvMC+AamrDo7GITLSxdQt35O0YE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6044
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 May 2025 07:04:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18933

Hi Pavel,

> From: Pavel Machek <pavel@denx.de>
> Sent: 21 May 2025 07:43
>=20
> Hi!
>=20
> 6.1.140-rc1 should be out for more than 8 hours now, but I don't see
> it on our gitlab mirrors, so I can't get test results.
>=20
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-
> /tree/linux-6.1.y
>=20
> I tried clicking around to find anything obviously broken, but I found
> nothing.

Thank you for reporting this.
Looks like we had an expired access token.
All fixed and working again now.

Lots of new pipelines running (including 6.1.140-rc1) so there may be a bit=
 of a delay:
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines?p=
age=3D1&scope=3Dall&source=3Dpush


Kind regards, Chris


>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

