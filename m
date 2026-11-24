Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11797.1795497263072313162
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Nov 2026 21:14:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=O4+VSy4Z;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1795497260;x=1796706860;bh=xfl1vPYBgl49ijfeTwlMVvduugol7+Pg6OLDR
	svJltI=;b=O4+VSy4Zm67xckVfVLmHZ7/j+5Wn13OoTrV0C3bogT4jD7Imk9jHhkckpq23VFu7iPe
	5jFFw1Hh77SbhKOQ2hwko0Ns7yUSN3rLOU0V5rImg3Ohc/OgOyTpGPWEs99yxL7xpDN4Niynzrpz5
	V5PUatK3qDQ4yehjXYJlwjwLPZgWo09x/+I93l3zhiUr/8jGr80RR32Oq7FHqnyJb4JpgCTwVrqUF
	FpFgPQA2XUPrsCLn12jnPdKHTJuhKyXRquhQ9yWIJWPZgo5qPvbL6SdnPCvAyl8JTQNlJ15iv3eaf
	IxLWuFcG3YtG2Nvyz8FIcK6NQDGvDLwIg29POhRKWH/g==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 6AO5EK9f2657482; Tue, 24 Nov 2026 14:14:20 +0900
X-Iguazu-Qid: 2yAbBL6ZOYagNflCPB
X-Iguazu-QSIG: v=2; s=1; t=1795497260; q=2yAbBL6ZOYagNflCPB; m=YnVVY86vyTSC6/1I8XDovHi4xI09FPaeq1kPnfpx0lc=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jYWFS0QVHz1xnr; Tue, 24 Nov 2026 14:14:20 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MaHCm7vfxBPpuC6b5iw6NlHPLa/rBl1IkQtcinP0UkZswO0wkYwapIPzoEE07EVKRG1+ClIZ+/U3QXcGJypKNr05M+keWYYOqjRHjiwz1hjXzyt9wHMhMXPAm7Xj6IbsqaiUyvzSTfQBClqsnWp1cEb8/mnXPlQos8joVr+L0+TaYEFyd+Z2DWkyXPTC9hMw/bLh0BTvUgjJAJhHMF+eH6h0kUQzbgSWO8q3FWZtHF9eOi9TcFtJB14vCW8jfb5y1vcQ7Rx8Jx2pUXmXuaVxif2AqhlFB7v6cgaMDJmu/P9e3X62Ny/Rgwid34QSYZBl5rfNezDO7t0YbA5tgt5tlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPj2kB6NYiMxCKIZwdSf1UPQU4zwr0ILtTt6RJxMkyU=;
 b=S9eVkxsdqinXE7G/XFEssKd72Wet5U/CahvBkZ37tJTEnSfQ0EnVfOn283afFhdVdmWsUJsDd2q0HShz15+VxBO1MIONicKklNVOVA9Ibj0i5bNc5C28RJSPXRnJYrJKyd9iprnpVyEBh5X7MKn7IG56AN6t3sTXToOV22TKFykwuTxGQkyA6PMRS16AMnX7lpKFGr0b0TfCVtayto/81ydRlCA3jGFufVt32aCOXxFIxRjlId38gncdmHiWk5YUCMNnUPcYGXOLP0fuDgmBPbY7X45KjC3AcOpruZ9x34TgMdg7d0vuhNo8GqYHXLnZnQ9KL9Ptjd4RKVWh6sDJCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <claudiu.beznea@tuxon.dev>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH 6.12.y-cip 00/35] i3c: Backport I3C support for Renesas
 RZ/G3S
Thread-Topic: [PATCH 6.12.y-cip 00/35] i3c: Backport I3C support for Renesas
 RZ/G3S
Thread-Index: AQHddonjDnDaZR2k/kKvFN0BEE1LCrc8OnGAgAB9tNA=
Date: Tue, 24 Nov 2026 05:14:17 +0000
X-TSB-HOP2: ON
Message-ID: <TY7PR01MB1481855B15236A42E8F5B7FF8CD442@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20261117115038.1485554-1-claudiu.beznea@tuxon.dev>
 <awSzpbvC6xKPC5nJ@duo.ucw.cz>
In-Reply-To: <awSzpbvC6xKPC5nJ@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYCPR01MB18582:EE_
x-ms-office365-filtering-correlation-id: f48d9559-ab55-4d2e-8b61-08df49e9ca12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|38070700021|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: zUf+L6igvcNqRef/jhKWtiaxayV6lFdKTZSxovcYt/Tl9weKplcs/2T8rGUBzIl+YSW9qA7pI9f2u2Z9xNMw+2a9jBvcWUReGwhFF/t5z3bzseEgHkzW4pTu0bTGVtGv4es3oU54ptStvAFjO9ow23oWlO+QtQIl4Im38bo7FOpwAvt8+s8wFMSBejzSnvtn2i1IdRAifpUxs2K3Zix5RRMHJxFEjqpV93eNjC/Ic93Y2cGCvBR6HHTH+WkcVJhENEpEfkKgC2StKuHxQk1CByLNJasnyuQ3zimYgtoMDdYKyALBk7RpZ/UfJ4TazclmvLxTAAG/YGs329KFpPkSj53NruCZJaDh0+CeOx3iI9OPFHT4JlvLSmE7kydNDQuPMUTUcKqXdFXA1Wa1AaYP7UQJ3N7IHE8xPweDoue3ujPeu9Muf92NJbbnfrN16q9MQmAQXAFH0oY9cY/amK0m0Q2ViDheZ8eNYKdS9U59ECrbrAORjz0tBwT/BvRsH7c+CN/v9bNmInyhSkdHFf6sITQObZ0lCFFi1NfEHi0J72L+2Ju9dEa30pJiRXeIVDFnSVLAcVrqHNKEAeFg5s3dbnNKOiPrZHpZMLI2dln7aKAorOUKgixFWVzPNMKj1/Cv96T1Bk8FhPBJXmctaNWhRfOFEYO4spprqsr8dqe4+8QODCw1WcCAoBm2PXfbytkQ5ImfQGwfQFXO7ZJ+/XyaMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?Wm1XT3RPT0YxNFZ1VWFQb2VMQ3A1UTVqeEhJeWtKZlY3S0szVk5La2Uv?=
 =?iso-2022-jp?B?blZPNExkdkVOa2R6U0lzcFdQUzdqd1N6dUE0eEJjZkJ4YW4xRm5rR3BO?=
 =?iso-2022-jp?B?NTdYQk11cWxieU94elRVVW0rcXQxSktOM1hQRU1PYmw4OWVEaVdLOUZq?=
 =?iso-2022-jp?B?azBXOHVRc1VTVWdxNzQ1Z0U4NEtpK1AzcTVicEc3Q21GYlE3Z0RFc1dh?=
 =?iso-2022-jp?B?VFQyTjlUK3dIRXdlWmZNcFFMQ1hmdTc3TzJUZE1ZdVk0Um1jSWRSRjJy?=
 =?iso-2022-jp?B?NWNOdzB6UWhEbHZkWURsTWkwTDl4UEhYNmFCdlFZay9DTzdjRWh1S2pE?=
 =?iso-2022-jp?B?ZW1NV2xGU0oyUzZGdE9JL3B0YkZ3UnEyczdORGtTVGV3RnIrTWd0UTBx?=
 =?iso-2022-jp?B?OHFRY3VDTmlQamRpNXlBRjNoUlVzQmR4bWlHVUlwVEpzUmVPU29Mcm9s?=
 =?iso-2022-jp?B?Y1didFVIYzBWbWZja1YzbDI2RzByZm40OXJwMEYwSlQvSFU1MU1zSGo0?=
 =?iso-2022-jp?B?dzhVSmdLcEJuN2tUdGJSZWFCemM3bGR3emlQODliYWttT1Rxa2lWOWNT?=
 =?iso-2022-jp?B?U1E2TGlIOWhXcVpFdXRtZDdmcHhxM3RpTjdtZHpiRjVXQXRQMzJ4R3Ix?=
 =?iso-2022-jp?B?VFREbHJvbkNlakROWXhEYkxhejl6WklwZmdkcU5sYUJGbS9iUXBrbzdx?=
 =?iso-2022-jp?B?cldxOFRvc0NzRVZXUWM4MGR3RDltRllTWjl0elkyUGxwdXY5T3ArZmI4?=
 =?iso-2022-jp?B?VHR2OGF1WlRtRURTYmUvNUVQK25iVk5nRDJjS0p4MUd4NnhUaXBsanR4?=
 =?iso-2022-jp?B?d0RYdG1Rcnplb3JRbU9XZUxaVnNKSmRqTndadTB4NGFZVjgybHVMVTkr?=
 =?iso-2022-jp?B?T2F4c1RpRFk3d25xeDdIK2QrTFpxcFJzMXhvMXZDU0dYWXN0QTZ0SjJZ?=
 =?iso-2022-jp?B?ZGQ0NFZzUEdzN1cwbkFiclRQV0VzYnluZThab2xkVkRWRW8wQytabkx0?=
 =?iso-2022-jp?B?djJDTjI4RFlKNFpHQm5wQXZmQjF2c29SL294RUloTDB6czhXTUg4ZUFp?=
 =?iso-2022-jp?B?Y1pFWThIOHg3K1NtdXlWbStOb3F0SXROaFVrNFpaZUdrbFhhdWh5eTYw?=
 =?iso-2022-jp?B?SjdxWGRQOCtzd0wxQndHY3V4K3FrMmxzdHg5VkVNa0ozTTdkeUxFZnk1?=
 =?iso-2022-jp?B?ZnRvNmZOL1V1cllFell0Mm14anRWbTZLcUM3dGdsMTVUOTVPNU4yMk9h?=
 =?iso-2022-jp?B?RHFmc0luQTdrWXBldUJjcU5xMUx0YW5TcEhEbjdBQWpjUUVEM3NFUUlF?=
 =?iso-2022-jp?B?RWdKM2c0KzFFeUdFVStRNnJoTHd2OHY5REpNV3ZWcGMyVzFLT0dGdzQ0?=
 =?iso-2022-jp?B?MERXSlRPb3kyRmpWUEdDMDhpUlRUQnM0eFRTVE9QbStwR285bGpnbmo2?=
 =?iso-2022-jp?B?R0xKUms1MXRVMnBaM0ZCYWRNUTQyUFdqUy8ybG9ZTlVhKzZGbmpmZUFL?=
 =?iso-2022-jp?B?WGp3cHNtWXJFcHQ5ekJVL0cxQVJLcmhGWXl3dDhnVktWN3ByVzdadmJt?=
 =?iso-2022-jp?B?SGFhMHI1bnp1OGd4VFJWaW1hSUVmOCtMSDRQcUYrZmFhaWVUNVZ3VXZt?=
 =?iso-2022-jp?B?QVBtZ3lFbkhhSUJrK215b01FQzhGNUZQdGprVHlnTWtiUkVPM0dwT3pH?=
 =?iso-2022-jp?B?SU0yVlgrOEpTMHpJNWZQY2F4eVUrUW1vWlNIaVRlWU9BOHdRY2Q0dEFn?=
 =?iso-2022-jp?B?ZEI5Mm4wUElSOC81bFVNS3VKbWRDY0IzMEQrd1I1bnA0ZmhLRzRIc0JZ?=
 =?iso-2022-jp?B?Wm9BMW5kWFNLdVFENmRqSzQxbVNwWG5CY2wxUXREM1kzZ1BlRjdmR0d2?=
 =?iso-2022-jp?B?UXNzVzhSNGRDT0NWTmJWdTZUc00zSFJacTZVTllOYXllSDlBdzAxaEJk?=
 =?iso-2022-jp?B?dVQxL0w3d3BKOHNjcDkyTkFpbFpES0phblhaTmVuVEwwNjYvcjdtV0tl?=
 =?iso-2022-jp?B?WVJDRDJHRDZHNCtNU1R3OUREU0RUOWJDNlZiY2J5YW9tbmlhUkJkczNO?=
 =?iso-2022-jp?B?ZXdPTnRmYXVScW5wdzlYZFQxclp2TmhCQnkrT2pyOUE5aUp6OXR4aU01?=
 =?iso-2022-jp?B?NEJsZjArSUxMa0llcGVmb1g3WkJBeWdZWUwzVEFNbk80THdoWkMrUUYz?=
 =?iso-2022-jp?B?MzBBSnpYc1dGcUNPclFPYkJRU1Q2dmYwMHU3cW1pMmd2ZTdKNThXVmlU?=
 =?iso-2022-jp?B?Tmg3b2FpWHNqNXpuSElDd3VlWk9qWnhSaUNweG02dVJNY0NpOHV2WTZt?=
 =?iso-2022-jp?B?b1VHTTZqbFVZQnNaUk9TdjRROFFvNldmU2ZDalhQZjl0L2VSRkV0VklL?=
 =?iso-2022-jp?B?ZndBekx2SFp5ZzcxWXBDdmR0Q3ZCc2QzNFpWdllsS1R6U1NyVG9mQ3J3?=
 =?iso-2022-jp?B?bWp6UzdrNjBNVCtiV253aEI5RGdsWXdqRDV1SmxYZTN6YTdVWVpMcEVT?=
 =?iso-2022-jp?B?Zmg5ODU0dHRlU0R6cWF6dVNKVk0wcjcxVjI1UVU4SlIxdHdnWmMyLyt1?=
 =?iso-2022-jp?B?Y3BzVHJuYz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YDWLIx7OpE6SHrLyUGYPwUHE1F9/wpnJLA8nVSc+n0mDo5ZQeSpiZ2AGvXiLRzSi2cVbqvUVx6rieI8FQKVe5RsCob5Jo6a9r6V6m6tkdk0EDQMaHbxNiY+CdzB31PmAhRpuxy0uolhroXiiuiSkvqwOA2zz99rlbIwddKN5GjVj1JTSHiCqYxdT2X0VpZXwpFQs08RKWDB0/q9dDLXJf41JRGqcnFItk2y9xGr+KxRrpg7OX2QEdLG8N1pevLnbiHF/EZ4wLCU40Oy4/sl763N+s3mCg56HcmkojK1IDFlCRRyg9J+9yXjtxUCTaG8NhJNmo9gaKzqoQx/yeuRUDA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f48d9559-ab55-4d2e-8b61-08df49e9ca12
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 05:14:17.5187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K/vf10aFOwK8da9+mCxPzEh1TCWHbbfX5Ea0TvyAg7RlVtXvy7FbWq2f3cThI67m+KZrBTg3aFTMBN+d8ARjG95YAaJnVtDy+A0SOBcwsrSquTBXh6ezTkI+OlleMziW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB18582
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 24 Nov 2026 05:14:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25055

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Tuesday, November 24, 2026 6:44 AM
> To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Cc: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; pavel@nabladev.com;
> cip-dev@lists.cip-project.org
> Subject: Re: [PATCH 6.12.y-cip 00/35] i3c: Backport I3C support for Renes=
as
> RZ/G3S
>=20
> Hi!
>=20
> > Series backports the I3C support for the Renesas RZ/G3S.
> >
>=20
> Looks good to me. I can apply the series if there are no other comments a=
nd if it
> passes testing.
>=20
I also reviewed this series, looks good to me.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro

