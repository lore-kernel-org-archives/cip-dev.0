Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACE2CF855E
	for <webhook@archiver.kernel.org>; Thu,  3 Oct 2024 06:59:42 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.34])
 by mx.groups.io with SMTP id smtpd.web10.5639.1727938775024409717
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Oct 2024 23:59:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=vxsm6W88;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.34, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TtlXa9PQU0Q20X4158e2MibuvnI+mdb6NgZIiHVnx6NBm++MaoA3XArr1/+DikFTH4jSiJOGFBmLL17DnFBiP6O/Cb2y4ae++gu36+WZGUTxOqXaATfb3LkBc+Z+MqG+wXbdf9YHNmrAu6qN1F6hxcmNzWayXDy+XCC/teAhMEaRGtHX27PxVmR/4g3tcl1AsZ0Qqw2DiGWgj94owVSgSCHvNQ5Y1B5elVcUCkspFjQJ+kIW7LxnCzYqyPst6aPC+pKUOm9acjPczC8FpWqL5OXyeX70i9JjMsDeh80fMb4WNzWnNePdgXEtPzIkw00lldxouds88+PeayyZkJh8XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1P4ZfuVgf/I7ONfoEh/Lfet5+I6NhstsUTgj+z+mz3k=;
 b=RuIkK59gvbnbzVjmviqHxhiyxPt2dDA9x+PhpY0YOTiBwJlyP3gPQidDFH2rClgdj6kfvgzOw0jCClFhvyz7PUhygz2xiS1KqCy6eFeofJH69IFrUxSAsKt6xp1Z2wenYf8xQPN99fPie/VorwwqvylIABql7yuL5SHreX12Ey2UXp8F4A9TynUOIpzVaeFjL4OfboE0hgZ/00m6RhYiHmOug+cFPTu70dfzyrPVwfNZM7Zxf6bWGnFBdfrImCFrov1uPIv1r+0f2zoZ1HG4jhfe+AR8c4N0HMDZFBIHiUnErjuzY+qa+GmLs9Bpgqly2IQVY7rikkWcIZd+4GfVfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1P4ZfuVgf/I7ONfoEh/Lfet5+I6NhstsUTgj+z+mz3k=;
 b=vxsm6W88J/QBgj0PvSaXMYKxlC2/DWi5U8bwChRdOTa6NmqMyG/oaIl4zj5OeaUb/thFEpc7Paz0B3C5JeoM7jw6W/a7Bp7i8kDOhVdHoDq/gK5gGtDTFDzSXUgINT/HjJH1tg8i4lOoUPcwULeE9uXnEsf2km7dzEpjdSndnFU=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYWPR01MB8741.jpnprd01.prod.outlook.com (2603:1096:400:16c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 06:59:30 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 06:59:30 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 03/15] ASoC: sh: rz-ssi: Add full duplex
 support
Thread-Topic: [PATCH 5.10.y-cip 03/15] ASoC: sh: rz-ssi: Add full duplex
 support
Thread-Index: AQHbFO2Zo5RDsBGV90qClx8ximlPu7J0jF4wgAAJw4A=
Date: Thu, 3 Oct 2024 06:59:30 +0000
Message-ID: 
 <TY3PR01MB11346D77ACA74093D61B9AD4A86712@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20241002170712.655449-1-biju.das.jz@bp.renesas.com>
 <20241002170712.655449-4-biju.das.jz@bp.renesas.com>
 <OS0PR01MB6388556A5A29232D4FB90B7292712@OS0PR01MB6388.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS0PR01MB6388556A5A29232D4FB90B7292712@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYWPR01MB8741:EE_
x-ms-office365-filtering-correlation-id: c875f9b0-12c2-4755-2c03-08dce378edf1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?QTZTZnNCRDJucjc0ZVJQcE1VeEpVNkIvSW5kRWtqQllkdXRmK0tzZ2o1?=
 =?iso-2022-jp?B?ODVlaGNtZzUxSm1EL2NYSWY5V2x0ZHhyTlB5WVNwTG1QTG9NendmdlhD?=
 =?iso-2022-jp?B?NFk3SFpiODl1M1ZTZTdKL0xWRzB0Yk5kcEp3VjZNRWxqL0ZMczZSUDJ0?=
 =?iso-2022-jp?B?MUREU2k4WjZ1SWxPNDErcEdrMWpNOHNCVTlZSHd3ekFzYzNwK1NmY1Z1?=
 =?iso-2022-jp?B?aGtNSE1iMjdTWWl3ckNJQ1M0WS9LbWZSVUpHMjRzTitITHZnbTJhd0ZK?=
 =?iso-2022-jp?B?RkoramFzMU5taUxiQU5EVmdEK2dTTEE0RnRrVDZzeTQ5b3JHdWVXUndv?=
 =?iso-2022-jp?B?bFpnMWtKa1Z4RnhNY3BlT2VhR2Y3aEd5b2lSZFVLdSsyVUh2OVNLUGVz?=
 =?iso-2022-jp?B?M3JoVGNZWmN6dzlxRStISkhGeVprbStXMUJ3UmJMK0V3YnV4dlFxMERj?=
 =?iso-2022-jp?B?NXRGelBiUXpkdFR0aW9CTDc1OHU2MHlPcUpVVHQ5Zlc5dERHWEIwWVNo?=
 =?iso-2022-jp?B?UTVvNzlZSEQxTms4VVBiUWw0emVnQ3lvbzZjZS8xeEEyaWZ4OFpCZ0pD?=
 =?iso-2022-jp?B?dytidkxhMlNqa2ZXMVNFcVFXN2dYQUE1VXdDMUlUUmIvTk5iSkdEcCt0?=
 =?iso-2022-jp?B?Z0tvSzR6b3V2SlhuTkhkR05qSHdoamYzQmNZeWhmcHoxdnNQTkovNFNr?=
 =?iso-2022-jp?B?Q1IwWTlrZVpMN2dzWTdGcmRYd1NHcDZZTDhZcHcycW1peElVS1pqeFls?=
 =?iso-2022-jp?B?czFURTJENU12SFlpdi9BNGFya0RvTjJTUStiY0JPSHZuVFhFekpZYXNR?=
 =?iso-2022-jp?B?Tm5MQ2JRZDNjQXYyUUQ1bWlISEJKQmxwcTBHRzdtSk9HZDJXa3RJa3Mx?=
 =?iso-2022-jp?B?TnBtZ2I5KzhvS2hwSW5ZWlpoZjY4UDB5TElaQldSQzlmZWJrUzFQbm9L?=
 =?iso-2022-jp?B?clBWdVB5NW9jYmwrNXlPcWFPOVpKVVcxV09sK1lJQTBCOFpNbXBaR3FK?=
 =?iso-2022-jp?B?RjNxMVpMSjhlLzllUFZJWXRhN29xbVNVZjl1ZEhNQ1BOSUZ0QW1ERmk2?=
 =?iso-2022-jp?B?TEZMay9zMTdVTnJpVGNMYWQwdUJRYWlibnR1bUE2T2NlSUtUYklISWhx?=
 =?iso-2022-jp?B?WVJGK1draFVmeEtROTRtNGZ4aStoUEtBWTZ6ZDJiL2M1TVhwZzhQTEF0?=
 =?iso-2022-jp?B?ZTE4bHlUaEFWY2hpdDdXbTNXSkhGNzlRWmFLZDdhandXSk4zaWZ4VlhS?=
 =?iso-2022-jp?B?UkhYNHpLbWNCcWpEMlFFSmRFcks1MEJZY1lTK2hRT1VGL2tHb3ZKZ25V?=
 =?iso-2022-jp?B?OGxKNFJQT1hCczNRK3JrZW5WWUJ6aDFjSkhTckFhMjQvSlJFWHJkNklu?=
 =?iso-2022-jp?B?Y1FWMnIxeXZqSkk3d3UzU2JvN20xV0lFNS92TU1tNGdTbUFLbVg5RmU1?=
 =?iso-2022-jp?B?L25rN3V5djl5U0ZIQ211TDhHeWZCZThpaVdJclg1TlpjSzlabVpROFZm?=
 =?iso-2022-jp?B?eXVYVklYVzJwbTlvWm5zKzV0TzVKZy84WklySFh5bXpMUzN3d2kwRW5P?=
 =?iso-2022-jp?B?MmxESkFZMjFQTWdrRENjMWREWmVUM3I3UWxXRUg3RkJBTENtd1lTMkE0?=
 =?iso-2022-jp?B?SWlxNTNHODNsSXhUTHJpdWNyejk3dk5HdW53dDhoT09PSlZMTzFTUWkv?=
 =?iso-2022-jp?B?Y0Z6eW1uNlEvTmFBZmFlVlNIZjJxbUh4Uml5UUpJSCtML1E3RkMxT3VL?=
 =?iso-2022-jp?B?TUZNOXBQN0ZKUEZCb2ttcVNZcVFNRDFGQVAxNGoxbnlxWEpCSkUzY1pE?=
 =?iso-2022-jp?B?azRvVVBiWHNsaEMvNytzTHBCMHRFWDBFL29nQVRmR0U0R3JMZnE4ajF3?=
 =?iso-2022-jp?B?PT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?TE5aMTRaa1B0S3E3RVcxUWlzeWZ1OXBsNXlYamZobXpJMHhTOE5BQTlJ?=
 =?iso-2022-jp?B?U3E1V1BKM1N4bFIwaWNKeithQTYycG1wTk5wYnhyYTFKcFg1UE8vYVl6?=
 =?iso-2022-jp?B?MmJaREp6YjZ1aXpxWnhNV2h3dkhIcTc0b0dYU1NKZ2N4Q0MyMzdwbU5v?=
 =?iso-2022-jp?B?NENFQnZabmsxanRIVDMyVlg1VWJUMUZ0RWVMaTZ5dm43bTRqcjlTRXU1?=
 =?iso-2022-jp?B?SnVjR1RUNUZYOENFem5kWFhxMFd2bzViOWlwZHlSMWQ3NVF3SlZYMXNM?=
 =?iso-2022-jp?B?UkxnMTVrTy9QYzNVTnhsZkhjUGhQQ0IyczJOUTM3cHBhVkxaOFJGOEIz?=
 =?iso-2022-jp?B?UG5SZTZhcXJLVVdRbmJOc1crOXVyL0w5MVE5cVU2Nk82enFMdzNtTnpR?=
 =?iso-2022-jp?B?OUk1OUNhTHRCTnNRcUpBOHhNMm9TM2I5WTc4TnRmS28vb2N3K0NTN1VH?=
 =?iso-2022-jp?B?QkVKK1UrNm5lbUJhdXZ5R3FTWnBYY2xPSmFoU0pqNEdvTUJPSmNCbTNE?=
 =?iso-2022-jp?B?Vm1EQUxVVncycDJENzVPejJUWVUvbFZQWDE1S1lNNUhJdFdZSTJzOFli?=
 =?iso-2022-jp?B?Ly85OUR3RWxYazZBelhzUUxnWTZxNHRBODFUR2hnVGkrQ3FlRXdHb3NG?=
 =?iso-2022-jp?B?ekV1N2hXSEtIOWFFcitod2hoY0IxVVBXNjArUlQ2NW1kZ3RJTkNOM0dK?=
 =?iso-2022-jp?B?SmVPbTYxeHVoOCtMQ0ZSUnhZV3hPRTBKbWRyT293cWpNTGRyRXNrbEwy?=
 =?iso-2022-jp?B?a2dUUFBrOVI1d0o1VXBPcEduMFBidVhid1BDQVE4Vk5sU0dZSGNUS2xO?=
 =?iso-2022-jp?B?bnIzVTJXODZlbnRaNFgyZnZzZkdkdUM0YVhoSktJNW1pMSt5K0pRQU1x?=
 =?iso-2022-jp?B?UytDMWRIVURGWHduUzBtRlVnc0ZpNkN1bk9ab0tqMUY5dWd5RTZVQ055?=
 =?iso-2022-jp?B?WTR2enJ0cEtrMU9LbTh4bXVtcE1NS3ViTWs2MGJPbE1JNG5qamNGTCtv?=
 =?iso-2022-jp?B?S0Q2OVRlU0hPeTk1Q0dJUEtGQzlwSCtMWGtUbmhGMWI4SGJqZnVZeWZx?=
 =?iso-2022-jp?B?ZXJZWFQxMkE0TlVEbWE1b0dyYU1NckhucGF2aXJRS3B2Mit2OVVJMVl5?=
 =?iso-2022-jp?B?NzJjSGJ2R2ZRMDhjZzF5eGtuZGFCM0VWeUdPd2tBdk9oUXdPbUtxRk1q?=
 =?iso-2022-jp?B?SWVpMkZ5MEJ5NDl1UGpZNlJlU3IreU1FUFh0UHFHR2JOWCtGZWpoZFFn?=
 =?iso-2022-jp?B?RUd1V0FHQ1BSa3Q5elQ3dE5RZWYrMFVxa1B1bzlvd25ZZHRLNnU2d2tY?=
 =?iso-2022-jp?B?VWdPSW41NlpBS2FOUjBwK2JyT1JEci9yVEx4UkxjTkxFR3RSNTMyZTFp?=
 =?iso-2022-jp?B?ZnpvUTFuWG5mWENzM1RDSXp6bjQwQzkra09qMXVadXVCVzRRMWxBVFlp?=
 =?iso-2022-jp?B?bXdQcnZxUjBqSk5Sa0NsVlZCMmpBRldjajJJeWhoUFhOalNpYWZMQlkx?=
 =?iso-2022-jp?B?Z1dJZ245ZnV3OHFpcVhPVm5DOWltU3V6bWZpQ25sTkFVTzlKeWNSazVB?=
 =?iso-2022-jp?B?NVlxdjZ0cDBTY2ZhYmcvb3MzM3dQU3VZQ215Q1Nrb1FJS3VJZGJMZFpM?=
 =?iso-2022-jp?B?UXFCcFFqak9WdVVtVFc1TTZjaVozWTBtRW14Z3NUQmdjVWYxSXFPc28x?=
 =?iso-2022-jp?B?OWtERklqdEJCOUE4OE13NUpuR3NsVEcvNlZHK24wei8xSllmZUZVUXNV?=
 =?iso-2022-jp?B?ZlZVa0F0TjN1N2N4ZWJKTHd1c3QzK1lSU2RFWFV1cVpVTk9oSDl4cmx6?=
 =?iso-2022-jp?B?YXRaVmMweVgrandXd2lsN3VJWFVtVHlJT21KN08xc3pXZEt0NFkwL2gv?=
 =?iso-2022-jp?B?dzBNaDZ2QnozTGFRaDF4TlJ3QXBIWXh2S3NTQ0hFZ2lEM1ZTWGxTNXlz?=
 =?iso-2022-jp?B?Q2hocWhLanc2djg4WTI3Zjd0UVd6WDAvMUoxTW14MzZ2TVgrVko1MWRC?=
 =?iso-2022-jp?B?WGJobGlXR3E2Y3RwTFUxMXJ3VjIxL2p5SWxwbG5qVkpON0FSMGtHVllq?=
 =?iso-2022-jp?B?anQ5ZnBDbytnMkVjTG9YbWRDZTArRVloV3FCMzNLb1JtWmNxV0ZIMEh5?=
 =?iso-2022-jp?B?WUpGRmtVL1pSM1N6ODhWRHNQZ3BBZEhIcm9BWkRmMklWcWI5SUVLbmRk?=
 =?iso-2022-jp?B?Z3lkZXlMeTJjbWR2THlseUlFT0JieFp2Nk9vNlRsYTM2Y045UWxqUlNs?=
 =?iso-2022-jp?B?WjMyRmNvT3Q2MmMyVnUxMjR5TjBhYnBkc0gxSkZpWHQwbE5JQitCQlFF?=
 =?iso-2022-jp?B?WmJzVXJJbGszcnZIYUF5alAyME55c2lkUmc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c875f9b0-12c2-4755-2c03-08dce378edf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 06:59:30.6775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wy6zjCkNGvkTZPITsAaPtCC0PMDZ/46tLD0C/LXfMbh25VdNJ3yW4ZIIFnYw4ApoL4wrwyJy1/4BzZdL3aYUX+n4/hafQWGDsF/NCFc1Pus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8741
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Oct 2024 06:59:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16989

Hi Nobuhiro-San,

> -----Original Message-----
> From: nobuhiro1.iwamatsu@toshiba.co.jp <nobuhiro1.iwamatsu@toshiba.co.jp>
> Sent: Thursday, October 3, 2024 7:19 AM
> Subject: RE: [PATCH 5.10.y-cip 03/15] ASoC: sh: rz-ssi: Add full duplex s=
upport
>=20
> Hi,
>=20
> > -----Original Message-----
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> > Sent: Thursday, October 3, 2024 2:07 AM
> > To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B=
$B?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> > =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mac=
hek
> > <pavel@denx.de>
> > Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Subject: [PATCH 5.10.y-cip 03/15] ASoC: sh: rz-ssi: Add full duplex
> > support
> >
> > commit 4f8cd05a43058b165b83f12f656e60415d2ff5be upstream.
> >
> > Add full duplex support, to support simultaneous playback/record on
> > the same ssi channel.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Link:
> > https://patch.msgid.link/20240715092322.119879-1-biju.das.jz@bp.renesas=
.
> > com
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> >  sound/soc/sh/rz-ssi.c | 257
> > ++++++++++++++++++++++++++++++------------
> >  1 file changed, 182 insertions(+), 75 deletions(-)
> >
> > diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c index
> > ff5a650ac2b1..ce0233e8879d 100644
> > --- a/sound/soc/sh/rz-ssi.c
> > +++ b/sound/soc/sh/rz-ssi.c
> > @@ -53,6 +53,7 @@
> >  #define SSIFCR_RIE		BIT(2)
> >  #define SSIFCR_TFRST		BIT(1)
> >  #define SSIFCR_RFRST		BIT(0)
> > +#define SSIFCR_FIFO_RST		(SSIFCR_TFRST | SSIFCR_RFRST)
> >
> >  #define SSIFSR_TDC_MASK		0x3f
> >  #define SSIFSR_TDC_SHIFT	24
> > @@ -131,6 +132,14 @@ struct rz_ssi_priv {
> >  	bool lrckp_fsync_fall;	/* LR clock polarity (SSICR.LRCKP) */
> >  	bool bckp_rise;	/* Bit clock polarity (SSICR.BCKP) */
> >  	bool dma_rt;
> > +
> > +	/* Full duplex communication support */
> > +	struct {
> > +		unsigned int rate;
> > +		unsigned int channels;
> > +		unsigned int sample_width;
> > +		unsigned int sample_bits;
> > +	} hw_params_cache;
> >  };
> >
> >  static void rz_ssi_dma_complete(void *data); @@ -209,6 +218,11 @@
> > static bool rz_ssi_stream_is_valid(struct rz_ssi_priv *ssi,
> >  	return ret;
> >  }
> >
> > +static inline bool rz_ssi_is_stream_running(struct rz_ssi_stream
> > +*strm) {
> > +	return strm->substream && strm->running; }
> > +
> >  static void rz_ssi_stream_init(struct rz_ssi_stream *strm,
> >  			       struct snd_pcm_substream *substream) { @@ -304,13 +318,53
> > @@ static int rz_ssi_clk_setup(struct rz_ssi_priv *ssi, unsigned int
> > rate,
> >  	return 0;
> >  }
> >
> > +static void rz_ssi_set_idle(struct rz_ssi_priv *ssi) {
> > +	int timeout;
> > +
> > +	/* Disable irqs */
> > +	rz_ssi_reg_mask_setl(ssi, SSICR, SSICR_TUIEN | SSICR_TOIEN |
> > +			     SSICR_RUIEN | SSICR_ROIEN, 0);
> > +	rz_ssi_reg_mask_setl(ssi, SSIFCR, SSIFCR_TIE | SSIFCR_RIE, 0);
> > +
> > +	/* Clear all error flags */
> > +	rz_ssi_reg_mask_setl(ssi, SSISR,
> > +			     (SSISR_TOIRQ | SSISR_TUIRQ | SSISR_ROIRQ |
> > +			      SSISR_RUIRQ), 0);
> > +
> > +	/* Wait for idle */
> > +	timeout =3D 100;
> > +	while (--timeout) {
> > +		if (rz_ssi_reg_readl(ssi, SSISR) & SSISR_IIRQ)
> > +			break;
> > +		udelay(1);
> > +	}
> > +
> > +	if (!timeout)
> > +		dev_info(ssi->dev, "timeout waiting for SSI idle\n");
> > +
>=20
> We do not need to process to timeout?

HW manual flowchart(Figure 27.57) mentions to wait for ever. So, I have add=
ed
a safe time out.

Cheers,
Biju

