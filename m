Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496DCC44507
	for <webhook@archiver.kernel.org>; Thu, 16 Jul 2026 01:20:20 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3432.1784164817092092232
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Jul 2026 18:20:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=ceJ372n2;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1784164809;x=1785374409;bh=rORwxnRCJTj8eJIw2daLwBV0xwEBvuXDFfyM4
	/1gPo0=;b=ceJ372n2s2zASmsOteSGjhW+UfltryWW/7ouA0Tlakx2MkoPE/rrNP0ggrzbfQreIBv
	OdUgCy4jdQ0oW/4QvA0rRy5VWrAMSjQuFPhFiNM5xEUr/4Na9BgWTjDna38caLfJpu9ukHCZnatnF
	skfU0oQbljE5+j5601Fh1s1Df48bIBWfRpCa3C2owMXON9ETXdhNjTU45dCy5woQYYJ3J+tKvcjZB
	R7OWdMf+tIQmxh3R9HhaQ/XYHxDprjZTN1G9t4i0wub5kbhl8DVrNR7PpgkzqozOsUDs0bhxaCHJD
	Kcx6M4xUWhpEgLrfF2nPZuwaKQ+QW1VHkDIexGtUZKWQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 66G1K9Gf3334921; Thu, 16 Jul 2026 10:20:09 +0900
X-Iguazu-Qid: 2yAbM4cowtbFgVnZXE
X-Iguazu-QSIG: v=2; s=1; t=1784164809; q=2yAbM4cowtbFgVnZXE; m=IlsCoh8SdLlPGFRamtUhR/L6MosG0tmIgiv3/0PkXmk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4h0wFh2HZFzyPZ; Thu, 16 Jul 2026 10:20:08 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpschlxBWX4VYnkFVu+6prwGwRqTmjHYk/pod5oPdMzpxEzLigUuBeosEjizubvezF4aH04OIuyiJ4yWomEjKNJjsi/ecj6d8h8nU/x7Kz9f7H8+5jAyfka8HCrkrP9gYN8TsvFbM7Kl9w+50XG08Hzt+ndyrGiDrA3NJ9gDQxfC2nWVAENGhInQ7fRdZtzpgMlDqScbzURUHrNhJfsL0h4C9aFAuHgqUu65PDZ4n3MngxPcXbc8pJqm8aqa/WSSL6as7nkfSthciQ0UPgDRPr5L6U0J/FAxE6BciSHomb9RrPjqct5Gwgk0l+C2ftP7kNkNsGRCB1IKpAIFRREOEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDR3DIzm3JOK+Ot8QxpURFljQXUwcsscBraW6k6xdIE=;
 b=ke2ZN4C0h7D4wtNqY/d8g/9ca6pZ8/He8TyM/rBDDzXeZLodPShAYjbhi9xjv6za5WJ9tsSDwEMHCgyuyv7zjFcp+c5Vl2wfbaZZ4AK7GuGKE/lAtim4wZhuA8o7Wj7AkK5zCdN1k19O/8F+qdsZuosjm9uZKS/OiJFKzBsV6D1TQLUMjXEwJ9J1jYDKiBRyACd53dOVKC4JOLzOtlODiEuQQZQY7uCmue5wgR1FzOosjf7/AAwEVsbbGPthv6FFalL+qFDeAar5zD+I/zx7qQOrJ24y8E9Fk83yFHNDO+CV/q5FroCxFXuC7NA7I5yAjqMZa5bKpFTxubxmeg7rUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <biju.das.au@gmail.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 02/23] dt-bindings: pinctrl: renesas:
 Document RZ/G3L SoC
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 02/23] dt-bindings: pinctrl:
 renesas: Document RZ/G3L SoC
Thread-Index: AQHdCtsJe7GInM0nEU+C4CtTNdpzorZubw4AgAD8oJA=
Date: Thu, 16 Jul 2026 01:19:56 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148181F049410E17227C1645ACDC72@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
 <20260703105923.251255-3-biju.das.jz@bp.renesas.com>
 <aldc9NpJgAOV7vA9@duo.ucw.cz>
In-Reply-To: <aldc9NpJgAOV7vA9@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSZPR01MB8082:EE_
x-ms-office365-filtering-correlation-id: 3e3f11f4-e5f8-41a9-cafb-08dee2d858ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|38070700021|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info: 
 0ovKBkJqxxTVn75drgFgT0lHxG5yskm1lQCFkyftaagb6aXiQsXDaeQn78FkMBBu5dGJlTHnM5j6+wOwphk6BiExi4MOjencEICo1seS+ug0BNFUGmarF2RKy+taI6vbNAVAALLR1dSs1F5Ws3UmD+czlDqnoFq3jiklmis7fp9Fdjkdhv7pXYqqAjq4pA65VGhKnaxBttMQ3GnyX9v/El91Sp/zaUn+yiw/PEmN7vq+hdiHbluNS4b4asfZ2ehTDq0OA5xR6aPm2QnAJifwlMuFEJ73eOX9zE/Uqkz6aqYj3ypjjqqEIawHONFY09lwg+VV/f76i8KHMUxqiJubHVEIfRMb6WgbZ+2djw2nluuNpZMAFM61OYDXvyu81cCEawe6sMaQ708jCmh6yrWeyTX43W7jPd7L3n1894gHtmxA/yqNmlKIhBTcTkpVdI4Ej/15eLNlfwN1BmkxE8oVAbxt6kYMYN82gDN9cVWv2yZFb2CINHx1SeruPIIQZLLt6vURM+0SLNjSNWVj/Y0mpK3v917ODEZi9DpykyulTMqWT3l5U205vapuIY7Bogl0UUcKa2nqecsu2sFx3QW/+LNXJZAb/I25x9yhY6d+X8F1cZAh6HMVroefLXaGob53Jy8pWat1eFMiuzOhIVva9mRNcnhQAzkkrCXD1z+4Ct0OTzbh+cMZAhflmTRqmc1SyFXw3Gj4aBin9SyOTSQGH2Q/dJZbax3foikSXKY+DYM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?TnlWaXdxRUZvUDV3ays2T1RBR29yNi9TMllDYUZNRUd3N2tpRjE3UTFK?=
 =?iso-2022-jp?B?cWpJc0hjUEhVb2U0VmVVeW9vMDlMWkdyb25obUYxTTFGWDJ0KzVRbHJy?=
 =?iso-2022-jp?B?bHRFOHRVeW1LeE15TDV2SXgxdVQxaEZmcWVwenFmNXRFWGNIN3JzTm9k?=
 =?iso-2022-jp?B?bEhTUkdhVzhNcUNiZFgySzZUQVZJS0F4eUZGelIycGlGZ0IwV0JNZURu?=
 =?iso-2022-jp?B?WmhYQ04wZWR4Yk9OWmh1QURGTTJzNWw2b3hxdGgrc0pRdFZ1cmQ1NFVT?=
 =?iso-2022-jp?B?aTBaS3RIU3NQaW1Yd2hBd0FIVlBYWkZ3aHlzLzZQOEdQdE5QN0NFOExj?=
 =?iso-2022-jp?B?T205TzhpTUpwS1YwZER2ZW5JbnIzN2ZyeGtOWG1jY3pZTWJBeFc4M2h0?=
 =?iso-2022-jp?B?OGRmcStTOFo3U2RKRjBqbjlOZGtFd0xWODFaek45QWtJN2I0cGxBS2I4?=
 =?iso-2022-jp?B?R3B2WEFBdGV5dTRwZGg3eVlRZWtGRnVVYlNQMWRheWFiNUdESC9oeGs0?=
 =?iso-2022-jp?B?SnJXc1BwblBaaUF5bXk2S1Z5eklyVmxLcmhuTDNSLytSSkIvYStZZUZX?=
 =?iso-2022-jp?B?eDQzVUlzRVVjQlpGdGNxdVdzK2ptOUd3ckljaU8ybWNYcklSYkhIbXo1?=
 =?iso-2022-jp?B?T21nNFZMQllwd2xUR09wNW93c3NtT3VvU1h4THF3cXV0N1hFV1paU0F0?=
 =?iso-2022-jp?B?dHlGa0tRaEZ5ZmlFSjIxMHR6UVY4YkF4L2txMU1nc3pFT2VVR0J1TFY4?=
 =?iso-2022-jp?B?OWdUSEJqYk9INVZ6RkdQQkNMMk1sWnlSN3BKbXZYZnZZTTNyVU9YRWJ3?=
 =?iso-2022-jp?B?S2xDOWRsa0ZaMStxakRWYU9PakVaSVU1MUVEbXVOcGdrRVVtYXp6Q1RW?=
 =?iso-2022-jp?B?ckZHaHJVd2FwOXNldFZxMDBNYlExT1BzRHdQNTFheHN4YkhXYkpuSyt3?=
 =?iso-2022-jp?B?ZnFzS3R4SHRGeTNpQ3JaQUw4T1BNSjhJalJ1MTQ1cjZiRkxzeWdHV1lX?=
 =?iso-2022-jp?B?cU5uenF5azkwTnlaQzhObXBDUEZNTkhLcThZSXhZeXNvVmcyVEJXUzc0?=
 =?iso-2022-jp?B?azRmWkZyTEtWWFczS3Baa0RvbkREL1J1cE12MURCdFlneXJIY2VkWHA3?=
 =?iso-2022-jp?B?eXJCNjdicXNwL0l5Zi9NN1lsYmZnckw5YzliK2pSMDhpbzNLTUZFSGdP?=
 =?iso-2022-jp?B?VjQxU3liR0NkQmFmVjYvVEI2bWdRWklkZEtpV3ZOUXlLZW9UZm1wWkF6?=
 =?iso-2022-jp?B?SCtsemV1eEp5Qi9abW94UVFQTnNPa1pXRHovaGp6RUs1VGMreHl5bGd1?=
 =?iso-2022-jp?B?dktFK2RKZG9BMmMraWdoeWR2bkZ4K2V3VUFvcVUzb3dmVWJPZXZvVGxk?=
 =?iso-2022-jp?B?UTl3Z3ZLOEszK0VQOEZIMTY3dnVGcC9Sbm1ObGVQVzBPZSs5SWdQZ0F3?=
 =?iso-2022-jp?B?YVJ2SFE4eUpNOWVPWjJIenpibVhOdjJtSktIUVJoOVJwWHRGZW9ndzdq?=
 =?iso-2022-jp?B?YWkveGdQS1dvcDlHV2FmcndQN2hpYms3NmRCbnd6QTBHZlVXMTBDQlBS?=
 =?iso-2022-jp?B?SU1WVGgxNFpDYU40NFZKbUpBUWZaRjlobHBuVmJqWWdUSm4zOHdxS09H?=
 =?iso-2022-jp?B?Y2NDb1czUUttQ2JwNkE1aUZlN05XVUhUcldDNWVNUHUralEzSFV0R3g3?=
 =?iso-2022-jp?B?SE1qaFgvVmRBeDd6Y3ByRzJBYkdXdlI4M0lCM09XdG9ocnZWM3lpdUJa?=
 =?iso-2022-jp?B?TEd4VlFNZWY5NmRMMGgyZFZOZWUzWUVmTCtKVWg0eElITm5rN2M0SVBu?=
 =?iso-2022-jp?B?NGZuUllKRTB0QW85dG1uT0lyQjdFRUhTZ2ZjMGJPeTF5K1ltYTh4dkNk?=
 =?iso-2022-jp?B?U3Z4VElqQm5vb29ZQ29YRXBSRmpzTko3VG9WNTFkRGgrL2RJLzJNd1E1?=
 =?iso-2022-jp?B?TGJoY3NmcGQ5NHhWM1BTL2M2SUlEU0FDSkZUNzBGa3Z0enNlQmc0WDV4?=
 =?iso-2022-jp?B?SFhxeXVuZEJtcGs3cG5IMkpRSHJMVkRNWHdNbUhUVk52Q2REbEIvL0xO?=
 =?iso-2022-jp?B?WjBGWnNCQkNmVmNXZi9NbzNGQ2lPN3pXeHNqcXI2OGF4Tmc2QloySUls?=
 =?iso-2022-jp?B?V1ZpYnRUMUM2VjFPd1ozYVVvMXpmMUo1eHRSYi9KUkJtcnZwaG1YN3R1?=
 =?iso-2022-jp?B?ZnljZVdZbE5Ia2FRaG1FZmh1TU82SU5aNU44L0FFb056TWd4dTlSb2Ju?=
 =?iso-2022-jp?B?amRzTFM3WXR1ZlYrNHNVWXMrYWVqb3FhbFdialpPTWtENVZtbGtWMHl4?=
 =?iso-2022-jp?B?Y1kwcUlnN2dmMDBybFhTQ0NSY1RYVERlelk5ZjZaaFJDSGlWMC9kSUhX?=
 =?iso-2022-jp?B?Y2dndlVuZjlXY1lwd3BVRk1WekhFM2dSZ0l0UXMrSVFUb1h1dng1SHBa?=
 =?iso-2022-jp?B?Y21SdVg1bSt4M1U0bzZMZjNzNHpIbEM4ckxTRUl1WmhHWmR2Wk03Wits?=
 =?iso-2022-jp?B?UnFOSlhUa1RPY0E2K2tteUpTeDJiOCtudFpVem1EVGE3ZlVNVnRvSzNZ?=
 =?iso-2022-jp?B?bjBNR3BDcz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	hk9GKhDdJm0PWijyyMkZw/8krrDc1s8Gou0x+pp6Qjzn4eqS+JYCf5XAAb2OdhS+j8J5ZuvNd84nNciCUqYVVRpex73TLssGK84BSi7l1fNvPEXY4sGoTTykwQFeMlQ3rmZZldc+uLGhtB9EdFfGGnpfn/6SqJcLxfN8WhzFqsETFQg8KaQZUpAF9+ny0tuUZyvxtn2y94g6cWpp0LAbI02lY/qdCKl0l/m6vKz7XokuEBdbC8W8TpGGI72GkMPsgKIJEUXpSKLmnn0Qeeqnmdlc3+Hlm79VMn/03gN1jFYh+RlVlrP6SVrZe00XwPkmZ/odaStEJeIgmMYnYrviXg==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e3f11f4-e5f8-41a9-cafb-08dee2d858ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 01:19:56.5879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u6aoWPx6C+Ybk+259RJg3kGvfZ4ekEuIfwDkfYS0+dkDRIHE8LN4/6pEhfgRankm/lPXxzHOFTgpDtnwa7N+l1DPlv/7HnBMbUIcO2kfKkBTyaPpYk1iyBlieXWTH1f8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8082
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Jul 2026 01:20:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23601

Hi,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: Wednesday, July 15, 2026 7:12 PM
> To: Biju <biju.das.au@gmail.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek
> <pavel@nabladev.com>; Biju Das <biju.das.jz@bp.renesas.com>; Lad
> Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 02/23] dt-bindings: pinctrl: ren=
esas:
> Document RZ/G3L SoC
>=20
> Hi!
>=20
> There seems to be something wrong here:
>=20
> > Add documentation for the pin controller found on the Renesas RZ/G3L
> > (R9A08G046) SoC. The RZ/G3L PFC is similar to the RZ/G3S SoC but has
> > more pins.
> ...
> > Document renesas,clonech property for controlling clone channel
> > control register located on SYSC IP block on RZ/G3L SoC.
>=20
> Ok, no mention of deleting constraints for *57.
>=20
> > +++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.
> > +++ yaml
> > @@ -154,15 +165,10 @@ allOf:
> >        properties:
> >          compatible:
> >            contains:
> > -            const: renesas,r9a09g057-pinctrl
> > +            const: renesas,r9a08g046-pinctrl
> >      then:
> > -      properties:
> > -        resets:
> > -          maxItems: 2
> > -    else:
> > -      properties:
> > -        resets:
> > -          minItems: 3
> > +      required:
> > +        - renesas,clonech
> >
> >    - if:
> >        properties:
>=20
> But now we delete constraints for *57, and add constraints for *46. That =
looks
> wrong?

This is a side effect by backporting.
Depending on the order of commits, the contents of the commit log may not m=
atch those of the patch.

>=20
> Best regards,
> 								Pavel

Best regards,
  Nobuhiro


