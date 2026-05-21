Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CDBCD343F
	for <webhook@archiver.kernel.org>; Thu, 21 May 2026 03:45:11 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.28961.1779335105309831361
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 May 2026 20:45:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=pC1GHCe2;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1779335101;x=1780544701;bh=RTMncNrn33wn+ylAqfBTkZ++8Mn4eyABZhtI5
	lxjb8c=;b=pC1GHCe2o2XnoRjh8267hViV6si1v+y8KN6aOlGGMp7UOhW1nu1k8GDJjgLhqKe5x4x
	VpVHtCp1gz8HvB/QXBk3KvHff5NJjzbpQxWHQHNVp6K+8RAX5uXXdSMsP0NMXJApChrAOzz4vtUO/
	Vb6/UN23dBCFOhm3MEnXIv8bStkms19E59sRR98/TznNHvymsWmpFb0dt8r/+3/k+TcsmNVooN09o
	QRnjt+M9B/TCsCvlwM2IFgpyOZeS7Bg4Uhb8KDqltyjQfYP4+tmWuLwC3fBTqReadFI52TEZMb5+k
	LlEtZzxzE0nEsoNDiJy43+uUQKdH55dbz2yxovQ88Acw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 64L3j0GT1765573; Thu, 21 May 2026 12:45:00 +0900
X-Iguazu-Qid: 2yAamX3Xk0ONVKcc65
X-Iguazu-QSIG: v=2; s=0; t=1779335100; q=2yAamX3Xk0ONVKcc65; m=2CIJ8kF0pKXqMiUtHue2g5JLevmTwmZU+jtua11w2LQ=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gLZ6g3bdwz1xnZ; Thu, 21 May 2026 12:44:59 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kn+k7fXCBG0ouCr6FqH5U/z2zYJIx0F1hjmmJElfL1X1Z2f4SagmPkxb28TJhz4gUsm+g3QLhtNQNs8SePU2lh3yeoGhG9GjelYYJ23RxuVX5FsBe9vWKHwr76HPOWorLDfTzSXrEqejKnjKdaHvLkFdqAhsztLC9jhLMHg+vk58o7E3pPrAnzzizRcRij7K4BzqOiZL6aWG+mLi2NpZ/0hfUMItRvc85Idlz73qNJWPu/T8TGjDHsSdhriOvTrGD/TTPYZnYO630OHtzzB9Xh1SSPA9J1EfTMCoFkel7FKx84jegbs48JrkEDMHG6N+gTR8rdajgawuWrTisPS/Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdbz/lFEuOaESXNhIXZS6I1H7G3YNPBNug5vrr+pLvU=;
 b=F+uPLGJopZmMzSHjlfOSAntFxjfaAnx18e+EjoqmXutOQEqldc+pCldWBqdgdduott5fbn3aR95bMPP89awCEYg1t+zS0IL8dl63Ux/Gm007J+c1zZfd8XL8A9RkokSbeIFJmlT6it8HsDpZg76paZQ/3KsaKO4qRIeYoisSACfFyqTzbc2hMI0svyYrTxxwuT8/rvPeAzg9Cqh1VNjZ2g8PBkbIvRl6CBLhgz3+ieCCorzVp3xDQq2zum1t1pRWP83AqYOTIojH/I+2T5L8392AVVTYlJ+7NYSk2ggQzFul4G3VOV0wsc2R+51w1MAuH2LnrvpOpfxdxSOJfBpdpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <john.madieu.xa@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@nabladev.com>
CC: <biju.das.jz@bp.renesas.com>, <claudiu.beznea@tuxon.dev>,
        <john.madieu@gmail.com>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 00/17] PCI: renesas: Add RZ/G3E PCIe
 controller support
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 00/17] PCI: renesas: Add RZ/G3E PCIe
 controller support
Thread-Index: AQHc44YB22ldBFq4R0uQZZrEuIwlVbYX36qg
Date: Thu, 21 May 2026 03:44:55 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148184CC9DDA8E51E85ACB89ACD0E2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260514094152.2215176-1-john.madieu.xa@bp.renesas.com>
In-Reply-To: <20260514094152.2215176-1-john.madieu.xa@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYCPR01MB11991:EE_
x-ms-office365-filtering-correlation-id: d431b352-9e30-42a3-80f8-08deb6eb5304
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|22082099003|18002099003|56012099003|11063799006|6133799003;
x-microsoft-antispam-message-info: 
 qIJQpl7W4yZzGflTIGiMWvl/06lzoEAp0GAUGKAkFZGHDFdDNmy3ohZYr/TRa5xxl26t6+cptlWxGxN5uUNTwD0lPF8b/6FEraHZgkmkOJYglpo2a7aNRn9Jkqw2NBWEeCsJgzBtHCADneUD9Ro3XqqKDn/qD/nfiF8xEOOE2HqeWwWDV7JTtJGSGKLzug5hZDe3obIgDLMpcFjeUQUpyqPa1BHVJVXWvMiTzUUxpwpQQd9lGQ3Z/GOuqZTtvYLuDO/UsE/XaG1NAuhPSbKY/AvWKsrG2zRIpdHBXyxraiYZLMxL6Ffq1CIxK3DIrpv/b8zwKzCzfsnCnN4bgCXeBaHlVBD0gVlfNqBXu6l3H9yEmIwhNLhPwF+6NOibyT7ruPS4I/z/cEqiFTQaZwoR2RKANXlyu9AGwMvUjFGcWpw4alYmzYiuZ2vsodfAI8h7ycvDtiOEBG2ZOzbgjEm6ti3EfS+qbmdm+WlpIa12qDNQ9MnOe+W2bbgPs4d6RH/ZJp53AjYY/BgN+yl4oOiWSkqWptuWEnPbcaFS8P7Y+vYUrkpjDWGSlIWm/zyltPjE43OT0mPVPNX2q7yRWlu6QXTJdcOKRY+/bIMyrdenk6Y0tGXJjK1w4pMDqYKlSHtxontZQzXUBblDca+zY2oVkbWQ3ryQQAUBJ54B+mQK77zp1rURWb7Rvz8spdfxYd9Aishlsyw8fMw7DEjWR38PoyI+GsNoXpRMxABZO2pw4/1mMjZ4nlhKTqL0c0cP9eVx
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?TmdoaVRmd0RaZkdIMDlyNzExSFEzSHQ4bS9kMjc2bVYvL0ZaNkF1aXk5?=
 =?iso-2022-jp?B?WENiMVJqZ0NOV0VoVk1CNko3dUM1Rmg2aDlsaWxYK3IwT3lTemVUY0NK?=
 =?iso-2022-jp?B?SGFvdlN0cng3R3RrUjErSFZYNXdkMGsvNHU5VUtNOXNOeituK0dtQmdr?=
 =?iso-2022-jp?B?QkpMWDdmNmVSMFZtVVkvUTJjMmNmSHB4ZFBJbnZjMW5ML28vNCs4Zy9Y?=
 =?iso-2022-jp?B?R1dtVUtwd1J4eEhvRTF4RHJWUER3b2xTdFRYYmJtV281OFhFZ0VyczlG?=
 =?iso-2022-jp?B?OEY3WTl5blRvTHZDVExSSzI5Z0x2UjJyQkE4eU9kSnlMaUdYUG5GbU9Q?=
 =?iso-2022-jp?B?ZXhrak1PTklYVFhwUXB1dEFvVmYxY05lMGxPVzVuRGxJc2hMc2NOOTh4?=
 =?iso-2022-jp?B?NlVFNWR0eVNzTlY2TnNMYWc4L1ByTk9yL3JIWVdRZlgzMGhsY3daQlFP?=
 =?iso-2022-jp?B?TDlEL1hqZ0VSSmhiQ2ExN3BMN21KSy8xOWpKU3VYUm4rNG52STNWSlgz?=
 =?iso-2022-jp?B?MWN1dVZqcXR6ZjdYL1NyWUxhTmhPSEY4YndTbUdLZWJNb1owQ3U4OVVt?=
 =?iso-2022-jp?B?aUdjN2N5M0VPTUtKSjJYMGFEdVE2aEszdlJ5VU1Vd0hnUVBSbnJBNmFQ?=
 =?iso-2022-jp?B?UXIva0I4VzZod1A5TmtVdkRyYlFFTWRrU1RuSzFGemsyL0RNaXpGOEgr?=
 =?iso-2022-jp?B?UzQ1cDV0dFJwZWVXWUI1VlhsdWF6K3BpMXh4djZaUDhSeDI5OGV2Vmky?=
 =?iso-2022-jp?B?ekxCdDBkNEY4ZnArazI5UHpya3prTk5JMUdFdjI0TmtySzJ3NzlXMTcw?=
 =?iso-2022-jp?B?dDlaN09yTDAvYURyWHhxZ1FhUzhOekVxVXlXTkZ0ODBHaFR2M2dpdk52?=
 =?iso-2022-jp?B?aGRRNHhVNllORERGSDBrQ2FJeUNocVBWcjdkQUEyL1loeHM4TEJKOTBo?=
 =?iso-2022-jp?B?b1RzSFBxZEFUUVJ0cmFYYjlhMGZXK09GWkFGUEYyU2pZM0xNMU9BY3Rr?=
 =?iso-2022-jp?B?NDJsUDdqVnhPbTA3bTEzQTFJNGlYVFcvbUcydUZlRVRkRkZXZnVkT1hQ?=
 =?iso-2022-jp?B?dlp4ZjlxNU9UaVJiN2p4aVdtTlpwWjY0c1N3WWN3TThTL0VQNGRNN1RL?=
 =?iso-2022-jp?B?Z0tZUnVEMDJsOExqdXdXRk5yWXRmRVpQVVREeFN6NnFDMk1wc285Sk5Z?=
 =?iso-2022-jp?B?aFZLazZqU2I0djhCRXM1WEZzbWQwZnV4ZldjVSs4K3F5eHlQWGI2VDRQ?=
 =?iso-2022-jp?B?VE4zSFVZZXFZcVpoejUvMHVnSTNWdVAwL05abDNZYWd0R1ZyVkhTWGhG?=
 =?iso-2022-jp?B?bFFHam9XTWNqNENLNnA0S2prUHR5K3htSUZlYm9tV0tGcmlSZU5CUmht?=
 =?iso-2022-jp?B?b1BHSFN6SVJZUnJ5ODg3aElVcHU3bFpZaUlSdWtYMEVFSWxKQkpkYXor?=
 =?iso-2022-jp?B?K1Bnb1RGTnJKbGlQcEgzNnBQV3lzN2JPZndqRnJ6czdtWE85ZTgwcEFy?=
 =?iso-2022-jp?B?QVp4TUpmOVVyczI1aGo0eW0wWkJTdnVDY09QMTlhTXA0Q2xCWDdldWk3?=
 =?iso-2022-jp?B?Q3dzNWU5eGx5WUZMWitDOGVEdEllWFgrWng5M2hRVUxRa2x2a0JnWlQ4?=
 =?iso-2022-jp?B?eWIzem9VRVpQeGdKY3g3QVZKa3EwcDdEbFVqMDh1WXVKRE5MVEJCbVlz?=
 =?iso-2022-jp?B?YmNUUGJpMnoyOHkxazdDbFFpaXY1aWpSZk1FeHdxeXFTSEl3NTdWN2JQ?=
 =?iso-2022-jp?B?VTFBNEYzQk5nQTM5YVpOTDJqZmNxWUxHc0hHMmJRK1g4WkFOaGp5UGFG?=
 =?iso-2022-jp?B?Y0tSS3lwcHFhaEZxTlBkalNIajl2Mlp2WTY3U1ZkYzc1c3RkSkVUcXYw?=
 =?iso-2022-jp?B?dW5YR0UweHNPYjhyUkovWmhibGxaaUpqMFUxdUZ5VjFmMGpnak5hN2pq?=
 =?iso-2022-jp?B?QTY2MEVyUEtWT0ZSc1ZMbm5uQlVkVElwb1M5OVhWbEdrYTJJaVVPWkE5?=
 =?iso-2022-jp?B?SHJES2VGaU9QR1NFOWx3UkxzK0p1OGNIRmV2cG4ySE1jb3psODJFTXAx?=
 =?iso-2022-jp?B?VHVQb043YXQ0dnlLbmJRNHUrMEZDc2RzYy91Vlk5bFMwSTZONUhWajgx?=
 =?iso-2022-jp?B?bTRWb3FTSFUrWm92eTVUM0dsS2RhT0tPVkFpTmV5SCsyejhHcm9kQ0d5?=
 =?iso-2022-jp?B?ZmlweG00a3ZSNlQ5N09iTFNNaW1YQ0VZWGEyaFFHQ3NMT0pPU2U3akYz?=
 =?iso-2022-jp?B?dzFhR09jU054V0duQUd4MVd0Tis0ZFF6WWJoZE9kUFhCSjdvaU1Sb3No?=
 =?iso-2022-jp?B?R3BlQjFmYi9GYkVHUThxZUZUVnp5bnZnZHhwQ0hIMEZGVUVrdWRiTGt1?=
 =?iso-2022-jp?B?NFUxV2k1aTNnL0NYWVNsSHpIM1ppb2tYNVI2S05DVVNaZlh6ZTdZemJF?=
 =?iso-2022-jp?B?bVZnY1EwV0dJL1pkM2c4cXZKaS9JS2ZFNDdkNnU5dUViZ2NDaDhWa1lB?=
 =?iso-2022-jp?B?TjFYdVR6RE5qRzlSdDlzZUNGc3Y2NHpXbVZmaEFVVDU1dlUxcWNWRnNl?=
 =?iso-2022-jp?B?cWUydjEzWT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	fXEfIBw2eRlZVTP3ofzTa20Bz3V/UD78vYuyYM57w2OgnYpevDN6LY98ZGjjTacHSrL+hncmAS53y95DFAnrk43lgz+Q0dL5Hfz38fWIS8eoWtpEOs/FvOMN2zrVFe1vQeiUHeNIgLOy7J5zn0PFWxqf2IJ3mZa5eBiXjVYOD3+lxSm60dEENGtIEqHm477vPr9v7y1syyHj3bfWsNlTyjPm00Id0ckBQHbtpse6DTxLblrzzteDDmZpcDpbGuiPBYnIHYZk84yqmM/ruB4PMfZ6N4PuAT3LS2GlP9ZFVsQZMvWuP6yItoYWmQgWrMXSDHAsT6HZ8VTWvKQt/gVSTw==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d431b352-9e30-42a3-80f8-08deb6eb5304
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 03:44:55.9287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mBusBzvyzha6Roj7q3xT8ckiXkf82NIhc/cieIHUcRoZzb/wNMGFtI0meV9XFPIdp8MjjNtpmXIPVn3Ki3Nf49XVCuMGbcgE8f8RSToA/R0GoFihDdSqHANVLaEDbhiG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11991
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 May 2026 03:45:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22986

Hi,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of John Madieu via lists.cip-project.org
> Sent: Thursday, May 14, 2026 6:42 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek <pavel@nabladev.com>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Claudiu Beznea <claudiu.beznea=
@tuxon.dev>; john.madieu@gmail.com
> Subject: [cip-dev] [PATCH 6.1.y-cip 00/17] PCI: renesas: Add RZ/G3E PCIe =
controller support
>=20
> The Renesas RZ/G3E SoC features a PCIe controller that shares similaritie=
s with the existing RZ/G3S PCIe controller, but
> with several key differences. This series adds support for the RZ/G3E PCI=
e controller by extending the existing RZ/G3S
> driver and device tree bindings.
>=20
> Geert Uytterhoeven (2):
>   bitfield: Add less-checking __FIELD_{GET,PREP}()
>   bitfield: Add non-constant field_{prep,get}() helpers
>=20
> John Madieu (15):
>   clk: renesas: r9a09g047: Add PCIe clocks and reset
>   PCI: rzg3s-host: Fix reset handling in probe error path
>   PCI: rzg3s-host: Reorder reset assertion during suspend
>   PCI: rzg3s-host: Rework inbound window algorithm for supporting RZ/G3E
>     SoC
>   dt-bindings: PCI: renesas,r9a08g045s33-pcie: Fix naming properties
>   dt-bindings: PCI: renesas,r9a08g045s33-pcie: Document RZ/G3E SoC
>   PCI: rzg3s-host: Make SYSC register offsets SoC-specific
>   PCI: rzg3s-host: Make configuration reset lines optional
>   PCI: rzg3s-host: Add SoC-specific configuration and initialization
>     callbacks
>   PCI: rzg3s-host: Explicitly set class code for RZ/G3E compatibility
>   PCI: rzg3s-host: Add PCIe Gen3 (8.0 GT/s) link speed support
>   PCI: rzg3s-host: Add support for RZ/G3E PCIe controller
>   arm64: dts: renesas: r9a09g047: Add PCIe node
>   arm64: dts: renesas: r9a09g047e57-smarc-som: Add PCIe reference clock
>   arm64: dts: renesas: r9a09g047e57-smarc: Enable PCIe
>=20
>  .../bindings/pci/renesas,r9a08g045-pcie.yaml  | 121 ++++--
>  arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  69 ++++
>  .../boot/dts/renesas/r9a09g047e57-smarc.dts   |  16 +
>  .../boot/dts/renesas/renesas-smarc2.dtsi      |   4 +
>  .../boot/dts/renesas/rzg3e-smarc-som.dtsi     |  11 +
>  drivers/clk/renesas/r9a09g047-cpg.c           |   5 +
>  drivers/pci/controller/pcie-rzg3s-host.c      | 365 ++++++++++++++----
>  include/linux/bitfield.h                      |  89 +++++
>  8 files changed, 570 insertions(+), 110 deletions(-)

I reviewed this series and 6.12.y-cip, looks good to me.
I can apply if there are no other comments and no test issues.

Tests:
  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/254224840=
7
  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/254225732=
5

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro


