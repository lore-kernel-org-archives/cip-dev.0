Return-Path: <Chris.Brandt@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94624F4369E
	for <webhook@archiver.kernel.org>; Fri, 17 Apr 2026 13:11:11 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.22])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44573.1776431460665334603
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Apr 2026 06:11:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=Bevenq4G;
 spf=pass (domain: renesas.com, ip: 52.101.229.22, mailfrom: chris.brandt@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0qMBzokg6Vvweg0MUthJJQ02XreEKsvqwr0LLGSm5bkb7TRuOO+tewmmKhpO9uDL7k7tiuZ9VX0ztiAtMQwF1CDhVNL0CUppxt/qEyNoPF7pTZMqperOSgNoY6olSrxfeKSyAQ10YJIsfzn6blg/b0VU0CeeTCuKEUG/wf0fiG45uX9OSOR9BSda3VYcr8pQMxTQ4zwfcyzPG+dwHpGtG7/uCZP3cFEauqyGDEEluWNDaF+qwY1nhxClSjVClB0eQdQ8OuX7MZuOqGjr0mFy/EVIHonT3nfXkh5KhPYR6BUu2/sAMJGdDE/LFaxLSkHIY4F0YH4d+ZmMeIOkW6wYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7tXOH/w3r2KfS4+ECcD+atgpL2c0DXBQSCNZ0SBfzs=;
 b=JWywXcTh9PoO3Lz+ZQJLl0qEl23XtJO6wSIls/CH2uCPOFiwhCQ5qAoXnaj0A0j1GVq+fyUGmdNQ9RRVk9NKIRnA3MUeTMTsKavXGtswgrQe/DFIme6O8bnU9uR2tLQ3AbHUGRHSJXT94fvyuMd4NZ7VKXLt9wuA7TOOxqnkE0oa9am91GvPdQbQ6QQNvyA3DkF6nWdAYIUR/y/v/90C8yI8BkdgGOS1l4p3s7Qyews1QlQgZQQXCy5rC0FEcFlb77PgdP6erLQPovg1mPi4eEfZXANX8HxXk2ogN3rRPGl5xo1rD4FP77RKpFv2kuotZGQIAv4qLafToxp+HAlRtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7tXOH/w3r2KfS4+ECcD+atgpL2c0DXBQSCNZ0SBfzs=;
 b=Bevenq4GP8bIpQGjK3ffwFA20CKz3UP1vYEJtoKbtwL7lJTaCOf6XXzaFx6CzgvP/Z/x2WRI4yVQp24ZY08f/Qrx3ax8FRp7HHTI8D6+h7J4E4UDhU0zVUFUKrNyT2/l/AcWdWbqOm0AkPqT8BtV41EaSkPKW8sJHxh4y+isHUg=
Received: from OS3PR01MB8319.jpnprd01.prod.outlook.com (2603:1096:604:1a2::11)
 by TY3PR01MB9665.jpnprd01.prod.outlook.com (2603:1096:400:22d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 13:10:54 +0000
Received: from OS3PR01MB8319.jpnprd01.prod.outlook.com
 ([fe80::6473:1660:bdc2:c983]) by OS3PR01MB8319.jpnprd01.prod.outlook.com
 ([fe80::6473:1660:bdc2:c983%4]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 13:10:54 +0000
From: Chris Brandt <Chris.Brandt@renesas.com>
To: Pavel Machek <pavel@nabladev.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: RE: [cip-dev] [PATCH 5.10.y-cip 00/10] Add additional support for
 MIPI-DSI for RZ/G2L
Thread-Topic: [cip-dev] [PATCH 5.10.y-cip 00/10] Add additional support for
 MIPI-DSI for RZ/G2L
Thread-Index: AQHczeVQecJCV9ZUKEejnL38r+CBv7XjOQxw
Date: Fri, 17 Apr 2026 13:10:53 +0000
Message-ID: 
 <OS3PR01MB83192C24E7AD80BA25B8758C8A202@OS3PR01MB8319.jpnprd01.prod.outlook.com>
References: <20260415181810.4073807-1-chris.brandt@renesas.com>
 <aeFQCcJsg-z-IGN-@duo.ucw.cz>
In-Reply-To: <aeFQCcJsg-z-IGN-@duo.ucw.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB8319:EE_|TY3PR01MB9665:EE_
x-ms-office365-filtering-correlation-id: 0d0ba19c-1df5-47b1-25cd-08de9c82c18a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|18096099003|56012099003|38070700021;
x-microsoft-antispam-message-info: 
 sV+ql8WP9ZVE5lOR5atB69lQEVND5bbh+kJhDsd4eHulzXMEz96qx7FiaNylqbP2ptgnrpTmMaA+3H7gES3VAviotHyPhHkejH9v+x3fEZ4xwjE4SSVHMlQ7kaVcFuUFKWBGP8p4S9cbIrVyyoHAiVyLod3Xfo0W3yXpeszdMgtByyxThui/Td3XYmAdRzTiNc2VTRAzoqFcZbpc7PgoThpwGvGXcXI09PoRbQU8m1PcfDqdu4EgEKV08V/DhH+hvvd538ReOsGhIjZVtqznBN/QYjiyYHO5lvAX2+R6HStT0SSllQpc41NlhInUg5IAeWVn74uKAYCsQpU7LSdzKIVxf3I6bOzIlfnxvnSHC0zZD7XLkJUIYMCuZ6qT89GPK0O0dVhJfP+hf66lwgJZpiSNsQEaexwWVwrcpahbwOYaDUwfsrWN8LZS+9PLgpg2dSheZSA+6thHyD/tOM3e1AaHaLpOwY9xX5XVE1jbGYrvqPM+KwWKUeS51FSvfFk56GGP5H5Af5Bzhj+nwrg/1PVtVrhRiOElgNkyAHnQInvUbNbF3hnTPXYVxCz7Gf3dSUa0jebw7eqPOHDFszTObyA68MIl9UAD/syxT5SAwatNrBDlHung9t4nYEzoBw0RpwL5lGA5Aa9WDkmResUaoqJuqCzhO97MScBXDYcG8sdwqV8MR9nnDjaaBMucK+gyzPPdGxDtBIW2p6HGteYFcnDBMTQH28Ooja1j30DITznOK3GyNxOAlZJodexicpBfkLiIiBiL/pZd0KrkJdx/B7rfab8ZVbRJr4HXM75gNqU=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8319.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(18096099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?DTsk1Eq93X20By4qzBh9haE3oaARWu7ezQYLlH7xAITqhCKWlHLDDwiCVgSd?=
 =?us-ascii?Q?HrjNcjHcAG9ss2y1yzuRzfYWhe523fbQjYvpHEAnFikDvfrycmqEBRzsueMP?=
 =?us-ascii?Q?wRAHdtpq8/7ijcWYUm0NPEVO3r/fkXAWRbRVvAEBPmsb2Xfa+/RTvMhMhTy3?=
 =?us-ascii?Q?HBkH/VQ5uMgC/ZVuelA2eB9e4neTEylLq4brkrblghF45I+JhdrEN973nJ0B?=
 =?us-ascii?Q?mFpF+k8QtqbSC6MUjdErPgrNVaW2O/sMm4VMIju3WXTwrUSxYhnTsFBJGkD3?=
 =?us-ascii?Q?22STTHB73JXJCz4TvBn4wwQCG+vmKdb/m04Kz/kGif4h99+i1BjyOkgT4QMo?=
 =?us-ascii?Q?HxA6my+o+t0dFdk7i0Hnnex46Q2Eiqsz4P1iMFlp58PgX1thSdWFnn2g8vuO?=
 =?us-ascii?Q?l9ZdZbyM0MJJp/No994266wAL/Gbjt9TFudo+lOcqm7q0UsX5uZIhlLAaV0+?=
 =?us-ascii?Q?9zgx937QFm5W174ZA+hLMHtTVucQdF62omgnKSj2gsPjhxa64xovCGAxLGXp?=
 =?us-ascii?Q?67ZqHXx2v4T6WZflYcUDmbH3F+IrGD6qQrymNbazkgJTNrs7706uWsZuzl5o?=
 =?us-ascii?Q?+AuwChWBecRGpJolHO3D4dGETmF2aijbtRR8+pXmXdJazhldc9+xkakG5Edf?=
 =?us-ascii?Q?IllS4dr5mBiiq76YbzgAf6+dopwm1tbc5PfofcccOE4ubDlhwSqPvtOqOFuE?=
 =?us-ascii?Q?r3na9zp0Q/jBlbC6rM873/szuxsM1tRBiU1eHoxF5niAI5auAaNNC4W1+Xh9?=
 =?us-ascii?Q?MK51kHL3jbdy8B9FRAPtov63w2tRqTRe0zLYnTzdTFl11Vzol7Mxv+8QKMOt?=
 =?us-ascii?Q?vW0Scb5qEBg56Rjlk2oOdzCEhjZlIn2SgF2FwqfWACyh75rKGekV8M3gtwhE?=
 =?us-ascii?Q?NJX7X77lU9xsHnJscgVLbM+tZsZh6ItUAPXW+t0nUTPS0YexDPKKrDGNozfp?=
 =?us-ascii?Q?r3ojdIOsz7/oOofo0sDB51vJMd81MxIzV+GlLH0rkZTM/RKaqGfVn0Ei1310?=
 =?us-ascii?Q?SEikD92JZs7RoJa+s32tFl9NEfdQ3vFPxd7P4IRglgs20Hbp75Y6UVngN4Rh?=
 =?us-ascii?Q?4ZQ00olgciu33srbm3nwBiWs6D9tfB1ZlIqNhTue6Nr1HWe936gbx0GBytVf?=
 =?us-ascii?Q?MQ4sHtLmG0LrnliPGk4BnJf+6lRE20NPsladzGeRWOTmQwbs76UqAmaKuvB3?=
 =?us-ascii?Q?AVSrOHmqLLUGmPQO++lunV/i8psdQAWdHXp6pKBZ3lxYJT8thJhBC9AKljZy?=
 =?us-ascii?Q?MpwY+vzVphsatJr0qXRIZaOP8sOosuQEaxJzUlGgnpwTvlxJLSDg27iXQmNS?=
 =?us-ascii?Q?fvWmG4sWAMzvWsZ0f4EvB7SJ99idGByzm9R34jhgJD1epGJZ3sCwocNtoY3Y?=
 =?us-ascii?Q?fsjzRtSifcvL03zwvfZ6QoOYu+xty/Q0EtGUqSNWHLdErDADjkqXKhaoKbOy?=
 =?us-ascii?Q?iyJGzr6SGq5wjjBL/4pLtkRKHygs9pHhorK2al2TGyJ8hI1lFVmIo5ocjoP6?=
 =?us-ascii?Q?b7uOjPuAMJQiMs0+s+HRlzNQ5UAZ/ChqBfxyjcCd0IM16JpvF+niTf9lqPle?=
 =?us-ascii?Q?cdfeiX2Pf+XwAZV2gfacO/in52jwI3WPAW5ZEM791Djf3kvbpxVnrahzqMW0?=
 =?us-ascii?Q?3xljRC+Nlt6fNs6KyLEwH7T43wmQ8AM26+oIfL6H0fG/u7F0Z9BllvYQCpxO?=
 =?us-ascii?Q?kRbk0mtAJJ8scMpj0rHW0ljziWFMaseIIQpSNV8y2vau04DNljcvUGBKoWiT?=
 =?us-ascii?Q?gLjUFM5IAA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8319.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0ba19c-1df5-47b1-25cd-08de9c82c18a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 13:10:53.9314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hAKJ3GeV+Mz/OWvkqlMGqa0nIhZ9cLv26jdbPPZOrQi5VYmEwXFM+v/KxEUEX5OQA5ISDsrqH7iCGwW88rS01WAfwQzWoJTczVkbVpHSlKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9665
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Apr 2026 13:11:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22762

Hi Pavel,

> So MIPI-DSI does not work at all in 5.10-cip, or it only works with some =
panels and this adds support for more panels or ...?

The official Renesas evaluation board has a MIPI-DSI to HDMI bridge chip.
This works fine.

However, if you try to use an actual MIPI-DSI LCD panel directly, those LCD=
 panels require sending MIPI DCS Packets (Display Command Set) in order to =
configure the LCD before it can be used.
This is very common (almost all panels I've worked with).

The API and function to send those DCS packets were missing from the origin=
al mainlined Renesas driver because the eval board didn't need them.

Chris


-----Original Message-----
From: Pavel Machek <pavel@nabladev.com>=20
Sent: Thursday, April 16, 2026 5:09 PM
To: Chris Brandt <Chris.Brandt@renesas.com>
Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90=
@mail.toshiba>; Pavel Machek <pavel@nabladev.com>
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 00/10] Add additional support for =
MIPI-DSI for RZ/G2L

Hi!

> There is important functionality missing from the MIPI-DSI display=20
> driver and also the clock driver for generating the correct pixel clock f=
requencies.
>=20
> Since everything is now accepted in mainline, this is the backport of tho=
se patches.

So MIPI-DSI does not work at all in 5.10-cip, or it only works with some pa=
nels and this adds support for more panels or ...?

As with 6.1 and 6.12 versions, I had some minor comments, but those should =
be fixed in mainline, first, so they should not block the merge.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other comments=
.

Best regards,
                                                                Pavel

