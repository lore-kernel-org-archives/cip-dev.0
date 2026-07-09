Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCBFC43458
	for <webhook@archiver.kernel.org>; Thu,  9 Jul 2026 09:07:54 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.21])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5055.1783588072367936794
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Jul 2026 02:07:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=mccyx6gF;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.21, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLupRf623502SIZW0RoPhUBd+puTavj/jAvTbYhxuLRXLAixnt0RPr3Q6nv35ayTJUZBynNUkvjc8FVlX+H+l+1S/Ri2KU3Mlj3KprhvmFZYuvaU2owyEj9XejgTAo1RJhhIODj0UqoIOeP9CIKfUPi09lIoQESbaFzAA0YMaKHQHZKioM+ftEcdLAgT84i4wFvK310AMrV2ZpnAFN93xg7FiBzn/WjfOsCpBGUxNmgCH3gSvlTFekJ97wx/RRbjObnWqi4jqzL34h9/3JirgepFyVf0+ZGvig4H36T9I6X0M0n69ekBHM99csvCIsvRmDuk2iWfYbotnnoPaqjZCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9K9+pbPooX9m2DyHkrI+Mz0BiiWeArLX4KSITuQzRI=;
 b=GFbRfBJjL0N5HKl0UlKggNeDs3EfdB4IDZiFzL1Fcq17o4o+hW4Y9+dOyhnbxUR5Lc3boUhxSbE/pwlP/I3tK6M69UlQsaAckIUB5wBli/GAAvSvHQiFQKGCpCOj3F2BNNktDp2FsOjyFVtcxLAzWXaeav96+0CTRzAtGpXwCpnALHPlQtHqHe1+AP2dtHuMycrfZMAx7KpdWmcmC+WjDi6Nc5BWIOy2CJnXbniZHEijO7iiGnASEgOVqzd+qR0N6JwsbcaAzWpKL12f12oknwhPoWYWIRcH74GyRloSy2tC3wXfPBQjbEJ5gOwFkEcmJGWcN33GazcQcv8FJrPVsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9K9+pbPooX9m2DyHkrI+Mz0BiiWeArLX4KSITuQzRI=;
 b=mccyx6gFIZR45mIfs88k2bx+evM7OSuF9SQns32gMLr6sWOznODYv+V98Jm1JmC89c1PinafYXi0ruVT5MUE6DWMH8pldbptS8aGN0ghjVQqoc+DA88t5BMKuEmjyrJ5DPR5fzjxuFbwzh8txw8IUGZPRPJhNsdPIC1iZRR/dgY=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB10327.jpnprd01.prod.outlook.com (2603:1096:604:1fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 09:07:46 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0181.009; Thu, 9 Jul 2026
 09:07:46 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>,
	"pavel@nabladev.com" <pavel@nabladev.com>, biju.das.au
	<biju.das.au@gmail.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 00/26] Add RZ/G3L IA55 support
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 00/26] Add RZ/G3L IA55 support
Thread-Index: AQHdCtPWsMs8VrsotkWPsXOF4HAik7ZkGlaAgAAV2wCAAL548A==
Date: Thu, 9 Jul 2026 09:07:46 +0000
Message-ID: 
 <TY3PR01MB11346A89A4DE6D65B750D61AD86FE2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
 <ak6yWxbsPgT8X18c@duo.ucw.cz>
 <TY7PR01MB148184C559B9FCE4ED0F456AECDFF2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY7PR01MB148184C559B9FCE4ED0F456AECDFF2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB10327:EE_
x-ms-office365-filtering-correlation-id: 1a4c0a97-7d48-45b3-9fe4-08dedd998afb
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|56012099006|11063799006|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 
 oLOcXWNxW0ZuP6DZ7koq4o2e0ruAMIGNL5u5SYrCfYScoqcoQlPoE7BEc09U9E605JKtItbRyovxI2jvTcs+j9I7RkrUWAhdjjaDpzkVqVM50Pkh6a59Ph4j26OqmEiShzwJT4s1OrpYUM5RHY6sJGgnc0Eqc0C1BX9R8m/GwrjU9IFMIWV0wZKlzYueKuUNJqbuDg6ABlabNPQ+kbPeCozqlIunzearXP2xAh7ne2N4toISdLephPO9x/sf6VhJuL/DNw26N7Q/stlsX7wQVO7dnOyUqWdB5LtoNreXtVidEzKX/w9qxxM/VMic13R8DoGZeF2ffgN+z48/QylDEy5PeD/33ZWV20vMPc/TU31MugE3ZKI8LXX0l2QnQ85CSVp9HE5JtwTdUmNRvs7mY7NU/26j9T0RYsQrGvdnps2F0UWa2WCpe2tXGrumKMltv33M+23o4WUTqXSTHBfXEENhEWtGlPZ29i3ZRrXVzro1i2srJ50Kv9RBXKbNHXwegA91N+7sm71IbzF39j6NXOILOGg2gATnSbWjWGDFeZHqM1us5SSVOclJz0Fi9qm3hsIJuJ2D+THQaE4jYLRIWYDo97mrfXGbiSuxMtfu6fAfqyi2RmadaZUHFqX3NuYx+uknG+ydE0R7O+J/odMpQHTGRbTu1ER+SeLjSk8bko85AUD8/1lZl+xKEslxUoqA68Tl09ms0tsP01qNtJHmung1r6ZU0j8z839/xPzcEeg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?QitSdno1cXBJd3VRMEt0REtwdkh6VTJzQjZDWlJqMVhUcGhoZWF0cDQ0?=
 =?iso-2022-jp?B?WE8rT1dGcm5KT0RyUmFPWVlnTWoyTXYvTGpVR2I3QjZFMlovRlN0OUF1?=
 =?iso-2022-jp?B?bTdORUsvbERqZlVSYXNsWXo1TjBtMzA1SGpaRWRpa0IxOHlLeEVEZERy?=
 =?iso-2022-jp?B?LzJ4bFhEK0s1djRrK3pRYXk1WFJZeVNXUHBJSGNEazEzUnM2a0tiQ3VW?=
 =?iso-2022-jp?B?VVY5WFdacy95eDMvR1JLcXNXcWYrcVRPSDRhZytFdm9GTUlzUXZWSVlj?=
 =?iso-2022-jp?B?dXZXSEVrZWtveHh2L2NnQ25YTDZLMkU1K05nV2J4Y1c3ZGRhaHhpL3A3?=
 =?iso-2022-jp?B?NUJ0TGgyYUtwdTZ1WEg4aEtGU2ZqL3J0UHZ6Z3dObzJyUHhtcEZWN3Zh?=
 =?iso-2022-jp?B?cWFLaVQybUxYa2lESGJQbG1Pd3hIcmRHL2NkTjFEdGY2VDZqeDZNdk0z?=
 =?iso-2022-jp?B?UkhLc3gwbloyb3V3RlQvQUdQV055THhXL2FOM3h6NElVTWVVNnkrUVow?=
 =?iso-2022-jp?B?TVZqaERWbENBNEJrWjhUN050K3ZabndDT09BWTZ6SGcreW5Lby9xUWVm?=
 =?iso-2022-jp?B?WUN1cnpKNTRTdFFLQmczdXVtbUpZNnVhcTQ3UW8ySDZzb0w4d0duV1BF?=
 =?iso-2022-jp?B?RldPUmpiN3ZkNUs3Ni85VVJNWk14OWgrNU13eVNuMmQ0VjBGOVB3aXZB?=
 =?iso-2022-jp?B?RXlXb2tyZ3BtZlk1cFhwaVJlTCtCa1FyR2xITG0rVVZYaDJ1M1VyTEVM?=
 =?iso-2022-jp?B?dmwrRUZWVk1WaXRyUVg1MjEralNjMUhOQ0FrSDhnanFwRnUvTjBWY2R3?=
 =?iso-2022-jp?B?QzZPenpHQjQwTUFOcjNaanliK3FiWm0rM1JiNXFuN0g2Tm1LNFVLb3hN?=
 =?iso-2022-jp?B?TmFBek1FSUxYUlQzWUJVcEZNT2JVaktLRFBkSGxxSnd6NzhGVnppVVo2?=
 =?iso-2022-jp?B?YWtkSHU2a1FMWXQ4L1RQOWxiQkxTamNNMEovYlZ6WDc2TkZvQkZtaEYz?=
 =?iso-2022-jp?B?MnI1anJYUDhPZjNObUxHeXN1aUVzOEhXYkFLakc4bVdHSGJNN0c5R0tC?=
 =?iso-2022-jp?B?TjRRdUhlMllwOEFPNkowVXhTckx3VmZsOVpNcU9xemVyWGlZL1VyWGJh?=
 =?iso-2022-jp?B?a0M3eUZVMzNFOFNxUkVKeFFpazBoNjJFUEZEcDEwRGFVVHBrNFlMVy90?=
 =?iso-2022-jp?B?Y3NiRGdlYTZvci82WkNpNzFqY3M2dm80QVlJR1pwRUR0dElYMk4zS0dT?=
 =?iso-2022-jp?B?VW55WWNHdWdOT0Y5VCtNZDkzQ0VDWnVZT2Y3VUpYSFhoaGo3U1EzUUdS?=
 =?iso-2022-jp?B?UFRMYS9obFQwUUV0K3pORk1VWm1rR1NqL2tjS1RMNkRCYzhXSkRpSUtr?=
 =?iso-2022-jp?B?c3d3ZGt1NWJ0RmxaRkkvWXg0Q1kxVEY0QXk5OWZjWXJyTERUM25JeC9F?=
 =?iso-2022-jp?B?djJRVVdLc3pCZ01KTzhiV2Jqdmd5WnlMeEREZElXUWJ4OUxHUy95aXNJ?=
 =?iso-2022-jp?B?NjRlREZ2YUdaSGVnWU1wQ0lJak1vaGo0WVBtb01mZSs4cmhJSWxLNzA4?=
 =?iso-2022-jp?B?Wk1lKzh5Y1k0d2ZkbVBIVmRGcDZOWFpocnp3S3VLNmxSZURvbmdvbUly?=
 =?iso-2022-jp?B?TzdRV081ZHJ5K1hwbW02M21SNW93UXgweU4yMW54czJLdHJFSmVaNFRy?=
 =?iso-2022-jp?B?ZjhSTzlVOVZUSFhtN2Q4ZlgxdjN6UGlSM2hKeTZ2MUZoK2hHb0ZKVjA2?=
 =?iso-2022-jp?B?RnhOY0E4U2I3V0d5NVJROWVZVzhPbndHN1YwQlNrOHRUTzZlVm12cFFL?=
 =?iso-2022-jp?B?ZmVFengrbFlSckJxUmlvVEs4eFM1bUtENDdCcXEyNlFxemdQZTU1a1FO?=
 =?iso-2022-jp?B?SW42aG41cmVPRllhWENqV0dsaE81WDNxMHh4UmJjc3pYMFZVVFovZk9r?=
 =?iso-2022-jp?B?NkJQcEdiT21kOUVhVTdXVlVVQjZQTVNndEMvU1VtSnN1enI2cllqWGpO?=
 =?iso-2022-jp?B?L2t4ckRVMWd2ZHlRc0RYcHJEOVRNcVJoUW01Z0NZa2w2dWExNG9PWEt4?=
 =?iso-2022-jp?B?TUE1a203TjVWRTROczR6aE04OGhGSXZXc1FxaFJsVVkxQUV6MDE1Vktx?=
 =?iso-2022-jp?B?ZjVaWW9FcjE3S2ViaUswZXl4V2tDYjd2V21iRFRnQjhlbU9YWDFTVzll?=
 =?iso-2022-jp?B?TFdpeDV5eUxYQnVWdnFJblZZZytLNUxEbklwRG1DN0FSWkZSSnpSbERR?=
 =?iso-2022-jp?B?QWRDVlk5ZzFYTVJ0ZGEyWXRyazgwVTlzb3BKQzFEb21LY3hJN0VFL3VY?=
 =?iso-2022-jp?B?U0s0M1YxTStRMkgvTmZOeGpuaFYyMnBMUzlkeXlyS05Gem9aa2VnMGwv?=
 =?iso-2022-jp?B?d01UL2xXMG1ydFFrUTBmM3cwdXExOG1ablVYaUhCSXU4b3NEeEIralpU?=
 =?iso-2022-jp?B?ajBlaWdkT3lQd2d4RXpLUXIrRUhERUh4Y0cxQ25NUldudmNhZlRHb2ps?=
 =?iso-2022-jp?B?U2ZLVGtHOVZ2Tmh2SktmSU80alBEVkRZOHBIQT09?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4c0a97-7d48-45b3-9fe4-08dedd998afb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 09:07:46.4476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1NLc3BUkWsbv1i6RLW01PtlH6M2sZrL18gNk/jH9745fGi1aYRxLEpxT+7zF5tl1y6Ul8VGoxpnx/6AvdqMQXpV2XLAS3WcY2U3K1Wt9RHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10327
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Jul 2026 09:07:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23556

Hi Nobuhiro-San,

> -----Original Message-----
> From: nobuhiro.iwamatsu.x90@mail.toshiba <nobuhiro.iwamatsu.x90@mail.tosh=
iba>
> Sent: 08 July 2026 22:44
> To: pavel@nabladev.com; biju.das.au <biju.das.au@gmail.com>
> Cc: cip-dev@lists.cip-project.org; Biju Das <biju.das.jz@bp.renesas.com>;=
 Prabhakar Mahadev Lad
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: RE: [cip-dev] [PATCH 6.12.y-cip 00/26] Add RZ/G3L IA55 support
>=20
> Hi all,
>=20
> > -----Original Message-----
> > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> > Behalf Of Pavel Machek via lists.cip-project.org
> > Sent: Thursday, July 9, 2026 5:26 AM
> > To: Biju <biju.das.au@gmail.com>
> > Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B=
$B?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> > =1B$B#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek
> > <pavel@nabladev.com>; Biju Das <biju.das.jz@bp.renesas.com>; Lad
> > Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/26] Add RZ/G3L IA55
> > support
> >
> > Hi!
> >
> > > The IRQC block on the RZ/G3L SoC is almost identical to the one
> > > found on the RZ/G2L SoC, with the following differences:
> > >
> > >  - The number of GPIO interrupts for TINT selection is 113 instead of=
 123.
> > >  - The pin index and TINT selection index are not in the 1:1 map.
> > >  - The number of external interrupts are 16 instead of 8, out of thes=
e
> > >    8 external interrupts are shared with TINT.
> >
> > >  .../renesas,rzg2l-irqc.yaml                   | 157 ++---
> > >  drivers/irqchip/irq-renesas-rzg2l.c           | 627
> > ++++++++++++++----
> >
> > This looks okay to me.
> >
> > Reviewed-by: Pavel Machek <pavel@nabladev.com>
> >
>=20
> Thanks, I applied with your Reviewed-by tag.
>=20
> > However... this is unused for the moment, right? I don't see dts
> > changes that would actually activate the support.
>=20
> That's true.
> We do need an update commit for dts. And this is already in upstream.
> Biju, do you plan to post for this?

Yes, It is already posted [1]
[1] https://lore.kernel.org/cip-dev/20260703105923.251255-19-biju.das.jz@bp=
.renesas.com/

Cheers,
Biju

