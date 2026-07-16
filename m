Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC42C44501
	for <webhook@archiver.kernel.org>; Thu, 16 Jul 2026 10:03:30 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.32])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9492.1784196208647246107
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Jul 2026 03:03:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=MHT3JTFZ;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.32, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rdTLE/Id2YCgQWM81Z/+PZBbdsPeOUxobx7nIlfkUUchMKl/DZN9tjdRkGT/yvj8EVssMfLsbXe6I5Ayb4lcI61p9HaomDnPCyKIlTyOkp57VDVUjRAVMK+zo5dSG/yY7JF81arpJxs0r3JGJwQtBHkeLltCVsqcTF0lEonJ9tDtYs5quItFNr0XxQqqVXAHZb6nFAmVJfwGfSSpZzLZqCg0HktR1IJPlJBCqtLySHErWx5Z3PJ6/hAh38JJROWI+XYxRf4CcsbeYw8lAu01uVqvQLe7X1eDFKNaxWXlSdzUqbzASMwSt+K5vI31BWSMpQU44R/SRyFDq1mMcgGKpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdFT9lZIGFHgfCpml7MH2L5HN7iEMz1OgAh+Tsmrl3A=;
 b=YvAR3CxuouDgNjOTc/1BmbqeYaaLq5pL51etl53Ff6GMerBhk2tmJU/1SltUfcrAPARXuzCdtzjUYnkNXAUk5JPmu5JObmTViNF8x9PuEfJzvfhXEnbbBjN/Ji+DV61bvRmfOetV8FuSt9tyURpxxOX9FAJhAT92jNyQ+QeUYIi9Yo2Y5xjayxIcCNUU9MpbfoxJ1QM2FDg/gC7jdYhS84Q4WrP24u/PJwBgmG2X780rPdDls5aC9rxUjVg5xZiIPX4LRQOob4+YSem8WoNJPcJSeQsvyG5E5lCWUzxWO2mh2QvyWIYn0LdVIL+xDCOG4P9nAomoNkNBAwyBls/CWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdFT9lZIGFHgfCpml7MH2L5HN7iEMz1OgAh+Tsmrl3A=;
 b=MHT3JTFZCau6/7hnTmlC7qtLHHg9393egg2jTC3AuZDlUW+zm7+qj0enczM6zw27bQkVvIymCy4C+GulolwdauyNxd+FlYxKY64UVLsztjDBj4plU1KkmUjjftedqVZdh1uT+zlX3YdNXimMnh949KRx46l1PLjRsdVm9Z2EzQQ=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSCPR01MB13532.jpnprd01.prod.outlook.com (2603:1096:604:335::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Thu, 16 Jul
 2026 10:03:23 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 10:03:23 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>,
	"pavel@nabladev.com" <pavel@nabladev.com>, biju.das.au
	<biju.das.au@gmail.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 02/23] dt-bindings: pinctrl: renesas:
 Document RZ/G3L SoC
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 02/23] dt-bindings: pinctrl:
 renesas: Document RZ/G3L SoC
Thread-Index: AQHdCtsHVHG60h936UCD1jvSKi0flbZubw4AgAD9qACAAJBBcA==
Date: Thu, 16 Jul 2026 10:03:22 +0000
Message-ID: 
 <TY3PR01MB113465350CAAF966182F658E786C72@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
 <20260703105923.251255-3-biju.das.jz@bp.renesas.com>
 <aldc9NpJgAOV7vA9@duo.ucw.cz>
 <TY7PR01MB148181F049410E17227C1645ACDC72@TY7PR01MB14818.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY7PR01MB148181F049410E17227C1645ACDC72@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSCPR01MB13532:EE_
x-ms-office365-filtering-correlation-id: b3b82e34-3c54-4da7-cd9a-08dee3217894
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|56012099006|11063799006|4143699003|22082099003|18002099003|3023799007|38070700021|10067099003;
x-microsoft-antispam-message-info: 
 RE7XMuRjdTSc8uu/Sf0cneicKZkfH1lcsE3tpC5IBCgExHSlLGPPSIWywky2mrkYk0K6FYcOJJI9dkrXBf/ZokV/LI6OnS267pVAlYsaBRqycvZSoc5yg3yQJfqaO4bj3a0P8QgkOCIvhru4+E4fvnAMg1zet/0tEiEDoUHnIhpl5ZJlZy0sBvirdIgWGWQkI0EUMCyPcZONrmXqBnja5mbR4cRO8EbMWaYNzNEVYDSmcDXKTvpACtDhL25I6jGPe7r+1eYTT4ZLIg9iH+hNJoNRHamp7aDXxKk94ZfCL3EI1K+YvLnhYCCTnke0nW/IyvaPFFMmQZ6hufqgX+mfGQVDcT3k4tmpUVQ33z/93AQrz2teFKlK2jd4IC0bfc/2NSBprUqyXyA/cF5zDUzV8S8SdY9FQzdjecm1BtYIvFrq08izmHdUmKG8KJM1p2X1tFu+MtxsYbm/Vhapq+b0d+jwwCTu2/JfXc163l31t6texaEEsb7Km2yIJciilRKCsPL0b9C+xnWDV/GqmKp3X/DdgM+ixJAVEAa8+TJP950FTFOZ2HQZ9E1IGgmkBB40bkuGXMI7PlRwgWaeQniPaDCChu2ptc500Z/NCw14dwXQGfCW3KL/OLinLQqlMtWqcsW1Tqr7lyKPCKy0S2vIfQo8lQT0a2R4L25x3v2x3cFvdLLSXfiQQMawqkv8ksSXsOomKeSN9HunDoCa0jho3MLF9b7OaKn///GUlixA1K8=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(3023799007)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?WkkxMkFSRm91ZUt4b1BpRVpQZENxSWVVZlVrY3NXU2xxbGsxVEV1TUxs?=
 =?iso-2022-jp?B?MkFSaStiZUo4d2E5ZDdVNHJ3azFHSlM5aCtFSGZtckpjL0RXTnltVStR?=
 =?iso-2022-jp?B?b1Z0OWp4NHlFalJnOEhndXpRUHh3c3lTMTYzeW0vV1lVVzhJelQrVGZO?=
 =?iso-2022-jp?B?NlVYcUloUVJaZWY5Rnl6NmhBWVFhdzRCY3A2OWpJc1BIT2RDbTdZeVNM?=
 =?iso-2022-jp?B?NHdWL1VkUzB3RHZOZFRZYWswTm1ZY0FPcFcrZ3phYzc0YWNvdTcwRGNG?=
 =?iso-2022-jp?B?MFN5K1JJU2dBNmZYMExpeWRuS0lhVlQ5TGVSZHlkTVROdmhXSWFVNzZV?=
 =?iso-2022-jp?B?ajcvbUNtdmNKRzBGQlBLaVNzQUlyTnAwTFFpOCtZQ0thWW5abjdSR0Iy?=
 =?iso-2022-jp?B?TFptSk9SbHNSVkxUaG1xc0xDT3Y2UWJyR1IzUTRrV0syRTgxSEZMaHpq?=
 =?iso-2022-jp?B?V3RMSG1jR3VpRmNPNGJqdzhqaHRkR3dUR1VMa0R1SjJVTjJsUmpJaEV0?=
 =?iso-2022-jp?B?NEpwVUhnQTJuZWtGVElTeUdBNFNRa0h0UkQ2RGtJSm95V21aKzBMSFVk?=
 =?iso-2022-jp?B?VGlWdGRSU1BiZm81TTY1eWFTZktIdTNNRFZFa3ZaMmEzNkJxejdPZE5K?=
 =?iso-2022-jp?B?VllPY1dVRVF2eFZReE52NCt2dnVlREdaSmhxU2tuYzJFZ3U1OWZwOEp0?=
 =?iso-2022-jp?B?UmZhdktXaWJnYnZFQTBUM2V5VmZyWnY4aFJ3cUhkeVM1dzV0KzBIMUJO?=
 =?iso-2022-jp?B?Rk8wTTQ5RGtoMjV4SEovU2pxS0tSQ21ISnVpTytSOE5UMGl6WmhDUVVn?=
 =?iso-2022-jp?B?M0lraGpJK2R0RVFnNUNnYmtwbGJBWjE5THVGOXZBZ2xmaE1HeFJhVUxX?=
 =?iso-2022-jp?B?STUyZXFRVitEUlV3K1o4Qkx3UitTayswNVlSQmxNaWkxVlB6ZjQzMDA0?=
 =?iso-2022-jp?B?ZGMxWWtRMWNqRGUvOEFxVVpUbkZnSEpxcXRKRGlWMEJuSXVnU09FZmdR?=
 =?iso-2022-jp?B?WGtGTk05cU1ucVN4c1VYclQyN0tFMDd1NDRaa3NKTm5OQXMxVjI0bVo5?=
 =?iso-2022-jp?B?ejZtYlRtcjJIOGxoMHdFZU9LRUYzUEllOFgrK3NnVHRNVmtoMFJjWTZq?=
 =?iso-2022-jp?B?Q2tSay9TSUY1STdkNG01NVdUZy9PejUwSVQyMzRSbXRWdzJSVEZRMGRC?=
 =?iso-2022-jp?B?cTE0R1lDbFhJUVZnc2FFMlE4S3ZVLzB2K2JWSDk1REkwWmhMRndlN3VF?=
 =?iso-2022-jp?B?dEZlM3dYNWFwcHYwYTB2ZVhyb0RtTDJOdmk4UWpPYklZOUdWV09malFR?=
 =?iso-2022-jp?B?THpjVzZVT3c4YlJuREZxVkRmL3ZXQ3FhYWE0ckdVZEFMOFBkVUxHa0sw?=
 =?iso-2022-jp?B?KzV3cE1kSHh3RGpNcXZKd05pUUtlbXVGdTJ3NkFMclBCR2QwSmlkVkRZ?=
 =?iso-2022-jp?B?RHRlb2svQXVIakU4bDhGSGRaakFCS1NuTmhGdEJxMUFYZ0U0OHgvNklM?=
 =?iso-2022-jp?B?WjZOeG9tVmsrVXlIYmZLcGcwdU1UNjJmSUR2YlI4cUs3dC8yOE03L0pP?=
 =?iso-2022-jp?B?dVFEQ3RiT3NKZHQwMENLYkdQQkYyTjg4anRzcVFsY2FtNlBCeXRpbkt4?=
 =?iso-2022-jp?B?OFY4bnBzOE5sSSt3TlcxWFN6ZXBnOUxCbEIzb2szYlRMdm85ajdHV1RN?=
 =?iso-2022-jp?B?aGszanRTV1ZLUE1TbmpSRUEzaHludUdCdWF6M3FMMWNEalBDaUF6YnFM?=
 =?iso-2022-jp?B?SFhWckVhV2JMbVpObnNrRE1oT2lFVE9zL1NZanlVcnJKbWVZb014a1RN?=
 =?iso-2022-jp?B?cWJvM3VRNmJKVi9weUtqTEhucExKbWtlWGZkMEhHN0o4VW9pb1B0Szkw?=
 =?iso-2022-jp?B?VmhXVm40VGF1cHpWVGJPcGJlMUtJQ2ZTc1NGZEhubDR6c2xxLzNxOXh0?=
 =?iso-2022-jp?B?YTdGYmZCL3R5Z1JYRFFWZWZSRFdqT1M1cEx0QkFGcEZ1dWczRU5XUXJE?=
 =?iso-2022-jp?B?c0hSbWhxQmtWa0JXNjRpbk5KVlZTa0JhN3F5RlcwbnV3Z0RMZ1Q1Y29I?=
 =?iso-2022-jp?B?bElWenBiK0RmUUFudWpMMkM1d2MvS3Y0TGlDdngvMWxFaFNmMHBleFpz?=
 =?iso-2022-jp?B?aXFSRWJ3YU81N3dMZW4zQlZHYUNHQ2d5Y21qZkJEV1RmQVZGZm13OTB1?=
 =?iso-2022-jp?B?Uk5YNzV0dDl4REdpWEhXUitjOWVKT1dyeFE2OVpWaXZYUk0zODlBRVZJ?=
 =?iso-2022-jp?B?RTBieVZ3REhnSWVLVS9YOTJSQVpIMXNVUWkwRVJNekY3bGJJSzk4aGx6?=
 =?iso-2022-jp?B?QStnYXFGNnFTeUszekRTaDJGbzlCNWh2a24zUUI0RGhrOCtpYjBkS3ZQ?=
 =?iso-2022-jp?B?UXV4UjlWQkpmc3Q0QjJZUDZLSnpjbDd5aUE3VkhqQUR0bE1NakhuanZl?=
 =?iso-2022-jp?B?UFVzUUxxdjFJMGQyZnRFTm9IeDNaNDFFWDN6WTA2RUZ5Vzd2RFBMVkVB?=
 =?iso-2022-jp?B?S3Z0YS9ZbE5xZWtoRkJRdlRsazNtQU9BRkFoZz09?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b82e34-3c54-4da7-cd9a-08dee3217894
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 10:03:22.9537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yctXmLw3WXsfivN5ZEg1YdA0b/7FYqkKTZ/v3O50aeSeqCOVvRZeVXRkQog/2p3P29v4DuLZhHU+CUP4SVrfQuep/r0JRUE/LoMUlUFV3XI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13532
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Jul 2026 10:03:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23611

Hi Pavel, Nobuhiro-San,

> -----Original Message-----
> From: nobuhiro.iwamatsu.x90@mail.toshiba <nobuhiro.iwamatsu.x90@mail.tosh=
iba>
> Sent: 16 July 2026 02:20
> To: pavel@nabladev.com; biju.das.au <biju.das.au@gmail.com>
> Cc: cip-dev@lists.cip-project.org; Biju Das <biju.das.jz@bp.renesas.com>;=
 Prabhakar Mahadev Lad
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: RE: [cip-dev] [PATCH 6.12.y-cip 02/23] dt-bindings: pinctrl: ren=
esas: Document RZ/G3L SoC
>=20
> Hi,
>=20
> > -----Original Message-----
> > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> > Behalf Of Pavel Machek via lists.cip-project.org
> > Sent: Wednesday, July 15, 2026 7:12 PM
> > To: Biju <biju.das.au@gmail.com>
> > Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B=
$B?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> > =1B$B#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek
> > <pavel@nabladev.com>; Biju Das <biju.das.jz@bp.renesas.com>; Lad
> > Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Subject: Re: [cip-dev] [PATCH 6.12.y-cip 02/23] dt-bindings: pinctrl: r=
enesas:
> > Document RZ/G3L SoC
> >
> > Hi!
> >
> > There seems to be something wrong here:
> >
> > > Add documentation for the pin controller found on the Renesas RZ/G3L
> > > (R9A08G046) SoC. The RZ/G3L PFC is similar to the RZ/G3S SoC but has
> > > more pins.
> > ...
> > > Document renesas,clonech property for controlling clone channel
> > > control register located on SYSC IP block on RZ/G3L SoC.
> >
> > Ok, no mention of deleting constraints for *57.
> >
> > > +++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl=
.
> > > +++ yaml
> > > @@ -154,15 +165,10 @@ allOf:
> > >        properties:
> > >          compatible:
> > >            contains:
> > > -            const: renesas,r9a09g057-pinctrl
> > > +            const: renesas,r9a08g046-pinctrl
> > >      then:
> > > -      properties:
> > > -        resets:
> > > -          maxItems: 2
> > > -    else:
> > > -      properties:
> > > -        resets:
> > > -          minItems: 3
> > > +      required:
> > > +        - renesas,clonech
> > >
> > >    - if:
> > >        properties:
> >
> > But now we delete constraints for *57, and add constraints for *46.
> > That looks wrong?
>=20
> This is a side effect by backporting.
> Depending on the order of commits, the contents of the commit log may not=
 match those of the patch.

The issue is we applied a patch twice in 6.12.y-cip which created duplicate=
 entries

Patch 1:

commit 64e2071b58f579b758c83ae3170f2eee5b46fb03
dt-bindings: pinctrl: renesas: Document RZ/V2H(P) SoC

Patch 2:

commit fb73d663b31398aea8528fb231e660c4958b29ff
dt-bindings: pinctrl: renesas: Document RZ/V2H(P) SoC

If we need a clean history we need to revert a patch or

Options:

1) Revert offending patch to remove duplicate entry and send new version

2) Update the change log while applying.

Please let me know how you want to proceed.

Cheers,
Biju

