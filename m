Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10147.1794574191067574959
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Nov 2026 04:49:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=G+V2KY/1;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.31, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QA5ctMYFo7shbmr0U2wjPHIvZbE+Tl98mRvGpmvqS1wyQRSnEbrRT+cmGpFQRTn2iAf8jepUV/4c4Mo/5N3WR+ipGZVZAQSbUXTSKW4VXnaf+97CTFzKV+Rzx21sRix7iY7n/e6UppCsqcBfEQF2DVESxWglWUySCreEVTDQtUwat4yGCf5Gtmk8qfuoCHH+aE9bBoneyfUv1C0zrzilgJpizJ84U8leIEWr0P5FaMf7jHluBN3jxGV9Pfbw7eS1i7bpWhxbQAEgKTaHRvxutG9kNFC1NDtACu4GrqSaZv2JUxxQQ1MaUd1Z4s0KXzZFaHOt7DHlgimLEmzkoUPyPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Olkp9JLJgSGk9gC0/9W6iXcAdBdjk1VlMpNy9RBlseo=;
 b=s5/0ak6y7lyQoeSHJ6ohknmwsRub9mwM/RtMxPmw1iABgKXNYE/qPCJeBWg8BGqd5QRHL/Zrq8p43559k6dztzPPUhoHp7a+W67QvOBT7Owd4FKzhlneRwkDnOxx82f7hu/v2eUED5ulX5uD4kCn7DVDEkeKrXX6rHP9CrcFrX5KSFbGzCeHe2zDUf02tHlLAblQgtnbyO0CNcj7IH4WcU0hmvu6BxRaTUKfyjF1M41bcGsrihUXE8RfNNOrnhU5XzBMIC+TMrOY5Ktl3c6hwaPrI/LVJqq6iumqzLf0ETfxQuc0Dp+P9tCHDWMEVMwF3+/30IG4q5EiuzItNk7eQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Olkp9JLJgSGk9gC0/9W6iXcAdBdjk1VlMpNy9RBlseo=;
 b=G+V2KY/195w5cEAJgxRiFIzoohNwNTB+q+H9FZbNM0K7kFXuukFKkvwKUtzhKUGUODtK/ns9g+8ZKdqTGhxUoDioIvKPIauJMY1Q7UD4FHVc/rtL5a6atNYHfCKQpiRQzL5A7A6qpWjo0gX8TBR5HlsRvNELBXeGDn0GtZp8XP8=
Received: from TY4PR01MB443929.jpnprd01.prod.outlook.com
 (2603:1096:403:707::18) by TY3PR01MB10012.jpnprd01.prod.outlook.com
 (2603:1096:400:1df::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 12:49:42 +0000
Received: from TY4PR01MB443929.jpnprd01.prod.outlook.com
 ([fe80::82b2:2570:827b:3e2a]) by TY4PR01MB443929.jpnprd01.prod.outlook.com
 ([fe80::82b2:2570:827b:3e2a%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 12:49:42 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@nabladev.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip 10/24] clk: divider: Add KUnit tests for
 clk_divider_bestdiv() ULONG_MAX handling
Thread-Topic: [PATCH 6.12.y-cip 10/24] clk: divider: Add KUnit tests for
 clk_divider_bestdiv() ULONG_MAX handling
Thread-Index: AQHdcxuVfzvBPMww9Ea0IA7mENGC/LcrsZ1ggAA9nICAAAVQQA==
Date: Fri, 13 Nov 2026 12:49:42 +0000
Message-ID: <TY4PR01MB4439293AE6E5C6C868DCACE0F4AA7F2@TY4PR01MB443929.jpnprd01.prod.outlook.com>
References: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20261109121451.6042-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <avYagTe3duUCQ328@duo.ucw.cz>
 <TY4PR01MB44392967D341C138EC7EAAE395AA7F2@TY4PR01MB443929.jpnprd01.prod.outlook.com>
 <avcC0dSGw7kk-uUc@duo.ucw.cz>
In-Reply-To: <avcC0dSGw7kk-uUc@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB443929:EE_|TY3PR01MB10012:EE_
x-ms-office365-filtering-correlation-id: fe64bbe0-3d4b-4289-b2f7-08df41849665
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|261009223027099003|56012099006|11063799006|4143699003|261026121527099003|261021135927099003|261022075727099003|38070700021|10067099003;
x-microsoft-antispam-message-info: xI2q6tp+41ac811cd6ZEBMiBfrnQdKKkfFMug0okGwlvgS7DMQ3fLVQmO2PZXvCMO/QFiy2YD3CYxgPEknLPV/rIblhYhNRmKJRpDSnW53Qmkg9NS5AWIIyp2jYqsiJ6/tX1n6APGt6IfJ/LbjySN2oTruK8TOwwyOSg/zJI55g785qwQ+EKqk8zIFvQRKf8lHPFKpjyIgnLMIYSlPlIkyvUNNBT6qG1eQJJ/8QcEnLR4aEijVYBKABFwJyPaBX6RkwbgTHWWrUvdHFdNr+MH1ApQYykc71Cx3UWxODnpeX+7oMaWvNPPrh/T0gsOkTas+pktUrUjHmgjovxMwsQpBvF+tTwG83Z5N47wZ/Qe/EANAqrr2cyHorm3f1Vqhw+YvB9ybIt/hygAeTUY9vQyr9zdsLcTtr1ts+GQB3s/bbZfTU1GeEiTzoxLywMN+vV7qkVEdo3pnNW1u1Ff9o95TMqwxM9uoamjYy9bIYRhQbf2F9GdK8D47pBXW2/ujeuNzpzb8oYrixdKbik1rFaNjHrEe7cpFR0GgpYD8FpAFkcdBwKJFiJaH5D5NWwTkVf3i/6fdthz9FD8zOhaBFueBlhTtzwbW+2TkQcFIWWXVpb5O/3jZW3QgiJrvCtYUELpj/N9/4llqKqazaeT9XxXdaXZ9w024IxWSFiedOPc66bK2ziljXKaGeeCvWJpcAwNLDnzQ83PsGy4wg7hX4HepG9NB13IzG5WrmnyMeK5Kc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB443929.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(56012099006)(11063799006)(4143699003)(261026121527099003)(261021135927099003)(261022075727099003)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?okSYoIM0MKxlSdAjEQMTIDb69bOxg1FXrCsbRKvvU3ewAg/Lo4layrkZgiEu?=
 =?us-ascii?Q?L19fDxcf0QwF9bL2sfcC6cJyNUS0Ncuc4ITqIeAXVE9tdRaI4OxlHkR60k+R?=
 =?us-ascii?Q?ejONVKw+kSDp11hQ+nq4vAkfaVDccyvBudaa4/FnQ9pAbLcyZq33vJiqkZF9?=
 =?us-ascii?Q?N397SjtuhJBm0ezP4oINqniOGiKhvHxpiA6HZJu2FysqIyiMUA5kyPwDlXvY?=
 =?us-ascii?Q?4QM0dLwthAJ2DV4rJucfLVXBCgvt2ZF7pLWpOZUaclMs/YCxfZLVG7QucraV?=
 =?us-ascii?Q?zcY/WIvYZxuCmN4TrHd8WCbjOSq/yNIzmASYtREYWJvDQErcY7F1WUraA99B?=
 =?us-ascii?Q?D26FWtHyxrEnZCIJZSq6zKz+5rWss2rQQJ9bDNKBabZ95iKBt1vLFBuTrZEA?=
 =?us-ascii?Q?/c4tCwz70sjx68/oO9NKWNOPIPuY5TjL9X03ALqOkvv3P69h2qYFf0klcRCs?=
 =?us-ascii?Q?LiSp7bkk/vX9ByRh9wrgpWfjye4YJJd548Ge8FJQdYavTZroVWdIusjNcfMz?=
 =?us-ascii?Q?ukTkzGV4yAa5Q0oYi99N3cmGQClnspZmxHKbnMEnBdqWvjB7avmeY88t5+ea?=
 =?us-ascii?Q?/QAsoKZq9JR53VLMD2CyVVNJeK0RGHfA5CxTptsVWWazQ4BS3RjrU795o64v?=
 =?us-ascii?Q?JvbBK4rJBM3OA74gBAI5AerOAAkFjIlgG6uTk50CKazFyneccEAzG9CPtOeh?=
 =?us-ascii?Q?A6bVD2GGPc/x3nIgS/A6Kwq3r3ir0SPhiaU0hzj5hKpHVXrtBwwr69lNByA3?=
 =?us-ascii?Q?3JIIWt4lvl5bq57/TTBHkE5ylN5QC89TpSxMvbhzpO/eQaTh4p1FFD8DVJsw?=
 =?us-ascii?Q?lAt6vTqeaLSnAp764nHTucKmSqyQMpWRZeTtHmmKcqutikX1rRG8AVc24yUW?=
 =?us-ascii?Q?jLjn3ueENPu/rzW1ZnGsBxmxD6IwoI2KwVHBo1K8K+FzIuvZH3/EH10Yf8C7?=
 =?us-ascii?Q?RlCCfN820GkPa9QIUqAr2J8vNeQRG33d0R1NmpAmHpiyldY16Xpsg0aVTCpN?=
 =?us-ascii?Q?u2SfSO9mwVb7C6RiZxU3RUJYuzt0ODPM4fZiDqQB4rWwNwEy86fr6J8iATyD?=
 =?us-ascii?Q?uGUR9WRqjkRvqXO9+rDTcuXj6nsFUlszrmTLp4FI9KzLDy8SJcy/egmrf6ye?=
 =?us-ascii?Q?zWNdlR3oUCEjsrbR7GWVnoTd8BK75KrL+wz5m9mBkVlCyxK1x4XShdERV0GN?=
 =?us-ascii?Q?zZ4AyDiuyVeE/cOcqbHS64hYFHLNiB4PmOs8gwYowT9amxN8hz5bzT8ziAk+?=
 =?us-ascii?Q?D5kicxgpjBqJ4YWuVpTC2742s/0RdY07kj4HLXBdEVyXl0NTcPUpCf8qTg+6?=
 =?us-ascii?Q?eVJBAOEJW3S0K4TjflhNVMWjTIO6x7L+MLBVZKK18LU1eQ9uVeInE5LGcAxl?=
 =?us-ascii?Q?2BZGS4v38lclZvrN5kekyPZu2uVGGRTxafOge3t5iBhrWJfAJMKs08mvFRSH?=
 =?us-ascii?Q?9ukoyqhW8MLHCVXF111sdrt6TD0PTnBpV6e5XDK2mpsFZ/IxQ3cEFDSFUVPh?=
 =?us-ascii?Q?2yYexTuqSz8TRgVpbl1/k/Tmsf4z8hh/FxZzKIahy55vrE5e5T2TsAxcek9M?=
 =?us-ascii?Q?YrzApldQfmdQpsXpeXMSuev3qyJfbZjIhZBuIhMK2pfkHBUfY4spKMcgWz4p?=
 =?us-ascii?Q?V8OfQa4vEcmMPZ2wZeokF22WLq58PGXkW098omQvJuRBEaA9ozN7Hr8Avtwf?=
 =?us-ascii?Q?nf5LGRDR8OYME/g+VuZ0cwjzhyTwjVUxDTa9GCR4RFNLp8a36AOnlz6F6gHC?=
 =?us-ascii?Q?dNxI4YfGctTIN41FRchpgs5iMIAcnGpGvQXWsfW++euQWmM/C0d5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB443929.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe64bbe0-3d4b-4289-b2f7-08df41849665
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2026 12:49:42.4618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IjouYTxgUwJEfGCE5ddVL3NKBOb8kZz9EUivCbDewaJW1eQGlvVrMO5/vfwXW1XUuCv1+w4y4FPWPI+lbDS8mM+Fh6oZRvcRpG4qWr1A5uLgMCYCXo4vJZVT0mDXhOgx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10012
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 13 Nov 2026 12:49:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24800

Hi Pavel,

> From: Pavel Machek <pavel@nabladev.com>
> Sent: 13 November 2026 12:30
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: Pavel Machek <pavel@nabladev.com>; cip-dev@lists.cip-project.org;
> Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>; Biju Das
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 6.12.y-cip 10/24] clk: divider: Add KUnit tests for
> clk_divider_bestdiv() ULONG_MAX handling
>=20
> Hi!
>=20
> > > Hi!
> > >
> > > > commit 50ca555d6ae8205374e406b411ae0e8e9447568d upstream.
> > > >
> > > > Add KUnit tests to verify the behaviour of clk_divider_bestdiv()
> > > > when
> > > > clk_round_rate() is called with ULONG_MAX, which is the canonical
> > > > way to probe the maximum rate a clock can produce.
> > >
> > > Do we strictly need the kunit tests in -cip? They should not be
> > > required for functionality.
> > >
> > Agreed, I will drop it.
>=20
> I'm now in the middle of the testing, and this will not hurt anything, so
> it is easier for me to just keep it (unless something else happens to sto=
p
> the merge). Just remember it for next submissions :-).
>=20
Thank you. I'll make a note of it!

Cheers,
Prabhakar
