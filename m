Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1738CD4F5E
	for <webhook@archiver.kernel.org>; Thu, 21 May 2026 08:06:33 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.14])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31724.1779350789383960872
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 May 2026 01:06:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=PM3r3z7N;
 spf=pass (domain: renesas.com, ip: 52.101.229.14, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YeTidHVay8QNlgfii5xcFibJ7NaPXoP0K4tevlfWrqfDDoL9o+Z1VmMsASVJLFCB2DDzILXB5RmXOJnCU6fL+CU48LGBPJs4LYAK0jc+2Fc8YneuhViabXdxzqpyuxsVaOyjt7bfzyhFw7eufRHhF/zqhEj/Oy4txpZOtBP+G9MpBRT6VB/bhwcwHVe0unZtIZFU8YvLgn5ug7jTDzmMfW0oPlka3ERxZy0X6Q0yeyu5RTNQ4ILwsS3EM9cmbRJkRZj+m7IAQpsVjzEkmH95BZc5npBvQJuSFSHKJWguOrHWKWl/9KIBWw3KYUa8Q91f53r+aT7MtBel7zWduysxMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgAqCP77XxfDvth915JRVIkMI/1URvJ3Z6/O8WsDcvc=;
 b=glC8aPwb5aft/Ea5PYNkxOI8qoJPTrUDPWlsVtRQ+FXjf9jgJYPz2oTbDC9Nd1J9npy0IAGXVaRVbzk74/SBSnaTuuDxAVpmJ1DazOA8yLj4cyLr/q8zRvDD+4jFzga3YjFLHR9Qu2KtjEt542Hflc+I351522tOrbe9sTPzWY/VLJmbc34tD4tTj1Kk9L305f7xjE5e7l+U7wXrkK32MtpTPoF+guGeKCdlzK+077GhkeMpk+CrLuN548dFV7J2lSfNuqPkZWyutJ8Thi/DKEs01DX5xImOIJlvTT/93BFrGB1nWwc8b9rkq8Xp7BOJt0kAbYSLGVzEUtkSA6/l0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgAqCP77XxfDvth915JRVIkMI/1URvJ3Z6/O8WsDcvc=;
 b=PM3r3z7Nj+fe66rSgoMsnwlzDim8jOSXtIVyCfJnVaMe60y1s4ZEDgnWQ0Vk0SwsXdwFYeEMzCOHYEJ4o8y3etbS85iJCZuSmSlUhMKfqcjMxL+hC8KZRiYVvOMX4uUmyQ2vD5NxgvYUxlHcse5GLpEdQnkikeMnzCNncLGwkdY=
Received: from OSZPR01MB8123.jpnprd01.prod.outlook.com (2603:1096:604:165::7)
 by TYRPR01MB12332.jpnprd01.prod.outlook.com (2603:1096:405:103::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 08:06:24 +0000
Received: from OSZPR01MB8123.jpnprd01.prod.outlook.com
 ([fe80::f2ff:7635:979f:c31a]) by OSZPR01MB8123.jpnprd01.prod.outlook.com
 ([fe80::f2ff:7635:979f:c31a%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 08:06:24 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: CIP LAVA maintenance
Thread-Topic: CIP LAVA maintenance
Thread-Index: Adzo+JuHBZ5/iHf/SfWB9OFwxLDj9w==
Date: Thu, 21 May 2026 08:06:24 +0000
Message-ID: 
 <OSZPR01MB8123C7F4B0BA07FFEB1768DEB70E2@OSZPR01MB8123.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8123:EE_|TYRPR01MB12332:EE_
x-ms-office365-filtering-correlation-id: c5d53c5d-e95c-47e0-6fba-08deb70fd9f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|56012099003|18002099003|11063799006;
x-microsoft-antispam-message-info: 
 A4AIMTG6HlaNe0vkuzCYfoF1zQsmGAvxhbELwbpuKaw3p6Ncx9LFP+r6Ioxk1UkOEXKwMaa9Uj/HxxXISKUez35b1e9X3F/oZ60BdVj56fYOvVXWTgrm8+ya6MZ3OPIILjOK6S7MZZ1nDG//wV3LHYUdydx42A401lpV8WQnvGs9VraH//h26ehiTaksEaIDixKQFg16lFKE4TdHHIlm+CDKqB2lTiVup6CplKPkCw2PZXxF+/RGg9ivH6Tf2hrTYRH1bImwgQhDv0ZIhGXEBtD0XYtk2kaXMcUfl1uMXvKCbQuH096G6DyygSSE3PCCEJPKZUMpRyX9sfNiZ5hewy5+eXq74V+A8l0a2BKKso2NfZ843TOE0LqB5ep5BqvUm2TrQMfBObWSwr8ds+OTvio5I3ANFzF0tyrI8XO95FY/9gpsIdx77KFSrokLHDgF0IBh/9bbIpZSfyKRCpbE1BzAwLQwwFSo5DfS/rGGPWLCbyrJfEkuTRGXr95VzI9UB70BwoA7j9bjuPRYNkfS/EYDdaRxpF/BQBs1TVasrRZZc4JWROWDRYzj6faZ+9o7Hmw+1pLQ8NUXfeqGHB9sI5CyI6hc+DIaS195wXSMPjCFU1JheWD/Yorlx9QUmpaHN+1GFTWPnbOzp+XkMcjw/w2ZBJ6pLzM3cARawj6FpEvplwSv/q2k5OHN0zVGj6rv+KnMq/uNXU+VhRwOPQzrSbcZeoHGIYuLMj4SlZUg430sCNqtQDtsUMuCW8/Jav3s
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8123.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?ObCQqWMXPTSM4RXSRIVPzGICxhqurZftgTYuCkNYad/F565/PKDBOVVBRl?=
 =?iso-8859-1?Q?NQYHpXbR8Sap+fvdaaM6RRMxKJAKobGtMWlJCANn8C2RWHI1j1Lhl04ZMl?=
 =?iso-8859-1?Q?Hf9TxlpmmtzLUjQAXss1pLs0dgeuL2MzairqO0WyEMjCMpwdO8a/H6RMx7?=
 =?iso-8859-1?Q?DvDfbmViOGqVDZW+NfpvT0IGz/2H4/04q79Nh9e/DYtazuQx2FpQYhYTyp?=
 =?iso-8859-1?Q?AjRXFiFqSY2Er8Lv2YipyRAv9/XLjIIg/7SIMCAkzgPUUY9nq11hcuUKkR?=
 =?iso-8859-1?Q?v7GwY8ZTkbEQP0S02ciNeVKU5n4fa2Fglg3Ndfrak/LmL3dQ0biE7m8YpR?=
 =?iso-8859-1?Q?9J6ap5+2QEX4+gHykzKjzsJhJ5WiB7dUToDI8dG+0J2zyTzE2aqDtZU8Ju?=
 =?iso-8859-1?Q?9OeiivsFd+fnbHikRq9tWpEO3tSxts3bSR3B54cl+npDl8iZylPdJ/thZo?=
 =?iso-8859-1?Q?NkwuFazaEvKaajqcN7CKlgQmKSuK6BaT4PF7f8xrKgMQ0PMeNlaBLJzLVp?=
 =?iso-8859-1?Q?YE9VyemysXJuhxvf/Y1m6mrvuXEzIwVxDh42kmqPRYYxrRroG4mzyvnIkp?=
 =?iso-8859-1?Q?ei40nhQetjROoatDrFbpD3oRLCb8DGkKKncDWOoxkRnJqsIb+xWk+BUeqO?=
 =?iso-8859-1?Q?1c6aZ6MX52O8Qo2aH5FsESRR3dYPUesG96p5PkQG9diCX7xw6INU7BVJvW?=
 =?iso-8859-1?Q?dULNxDSG/bn1lNbVJ0vSDqcDovFR8PbGGUj3702IzfkZ13/uix7pUViUps?=
 =?iso-8859-1?Q?0j5orw4uMldjN2N5Cmm/3qHNHf5teMFTEY2gHgUnbABZ8CEwrNqNMu2CVg?=
 =?iso-8859-1?Q?ET6YCFrJEWDi7utHoZrzcC0SgFyiXFw6j4hObs4hzm2cnrLlvo+Eq4P3Fp?=
 =?iso-8859-1?Q?lheXRZoeoqQEduRzA037zRdkWXlOK7GArE0aV6nmrFHSDkSrSfuMCzFsTM?=
 =?iso-8859-1?Q?8IYvnxIjyHK6uLpDaGNdMKkcFO+3YtmWRtXA8DUslTvJY5gfHPwz94fGnG?=
 =?iso-8859-1?Q?6oKWaKrbtENZm4BkAf8swhhSJw3SopX0tfrjsHgLguZgNSmlujqCWOd9NW?=
 =?iso-8859-1?Q?frj4dPQGh60B7jwMCUS7y8pYZIfqtim//md4zdJVfV2KDorYjW3dCB0R6Q?=
 =?iso-8859-1?Q?oc6zNfPgydkqH5E3B6sd44sLGx33auQOn1WDOb5esXlyunQweCSuqB7zdz?=
 =?iso-8859-1?Q?PCgqYqWGipf+R2dTMIs3Zyqq2G2+w+efVabdv8gj9fpcrIOHbscOEnP1mE?=
 =?iso-8859-1?Q?iT3aR85vZ8WTQCWiDCqNhlu4DR1pkPSLCGzrqbQveC7U+3sRbAg8IKfBxQ?=
 =?iso-8859-1?Q?LJQUrQ/WbOAH9L1AY490OPMWddmXXsa+HyMG/aJdKdeNvG6Z9ui9bQ2kDc?=
 =?iso-8859-1?Q?8fFwkPFnKzGRoTclnMaCMkEDTYo/gpYoNPkcp72ntKxGcZBO+es/PNrIjm?=
 =?iso-8859-1?Q?Hw034l2qeX6x8/OupP4JIW0M1OoEM6mWHG5oZCaynvO07YYjnkmWGgMLaU?=
 =?iso-8859-1?Q?gfYMzBo9pwLJyRkEPFxiwVJl7cmwN9/yDpdBr7onOWrE/iGnbxNs+JEwXg?=
 =?iso-8859-1?Q?Jxg1yBDWN8zF/4QyoTbyhkzU6PTsEarKnOZUDrW/YLs/VDJYSlsBqaXG6/?=
 =?iso-8859-1?Q?Se/EyTHNrCUzfET9tUPz3gF/EhhWVkIgrDCfknPzVn7uNDgk8PiawcKASc?=
 =?iso-8859-1?Q?3sfH2tI33KjzcklbvZTLyjotRSGr/mvAW4/H/JAoLkik714kX/e+AxWPpl?=
 =?iso-8859-1?Q?HWqytLd7Slk3U+/UmHIAKfGztvVnT97zvTNwDonDhsJS9P1o15yLWmqqVV?=
 =?iso-8859-1?Q?BXlJ/Log2A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8123.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d53c5d-e95c-47e0-6fba-08deb70fd9f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 08:06:24.2237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gcmAF2WIlcnl7UVrOAVANgyImgrnh/OVXACy8ZiYTocYBP80WPBq/CDqv60tJswxiCCwh3GHENe0lpO94VHfIKfEqoo9XT9guhdPUA0lN6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12332
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 May 2026 08:06:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22988

Hello all,

Just to let you know that the CIP LAVA server will be down for maintenance =
and an upgrade, starting at 0900 UTC today.
Apologies for any disruption this may cause.

Kind regards, Chris


