Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B317105D990
	for <webhook@archiver.kernel.org>; Wed,  8 Apr 2026 00:54:26 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.96082.1775609664136232525
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Apr 2026 17:54:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=wJaARIHs;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1775609661;x=1776819261;bh=XHeBWQWNbpyiMQx7W+Ov/x+gQQvpWlDPxgVEa
	G2sZN4=;b=wJaARIHsl1YnYFT7bxXBDQngkQKfdL8K/7DPm/WAQfhlj6NEHVPMLxTIiVxRBJ7W2JH
	miMbW3YemyUyNgXe7t+UpNv49hTSqHfUTPqXdnSIzSxfKoArn1po/GkdRphO8EHdFf6WQPjrqaWUb
	D/+Oaq/kDhTu9ZXFQ1EIqPGero/J8iuAXnW8vQ5CM0+MxfErH0oqwQgI1XRLCyKYjYslWsV0+q2lt
	8NC8ahP4lL5ayxHmi6mUht7Ze5JVlSnP6e7lWuwOTrDyxCC0LTO/Ermi1olwjDOXfSI8wlPiqqsxj
	L0ldGCxEPzyzf3pJwfVeTXZqyvWexWDWyTWu7LoAGFFw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 6380sKK23330433; Wed, 8 Apr 2026 09:54:20 +0900
X-Iguazu-Qid: 2yAbIfFomGXVu8K0G1
X-Iguazu-QSIG: v=2; s=0; t=1775609660; q=2yAbIfFomGXVu8K0G1; m=asszxvfn0Bog+n3YIP6HGGQ/zcjjjYH5kPG0Z1YYAFo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fr4Mc0Sqlz1xnk; Wed,  8 Apr 2026 09:54:19 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZVclCTeaijI4zDU2z2wQbqvms5HA/yita9lpPLF32d+DyHYkfsRCqndUqwgllu5u8YZDDbL3IYiGFGCXiWvSkLdKWb2K1J4ddUE9dx3w0+NF+YNnU9YPvfiBHvIj1QqvBAVDnNhQhl73t+r2b+5+BtVTg87NRPnenvsqTtp/sMVum5tXWOWw1mE2wF1f5MJ6J+wYw0A3JYg+MZaUxk9KKEIZM1AERouxyLGrVM3ybmz6VZ0aTbD/JJESrkeF/zUAAiFMoqjUMWW0t0l2HK4jTgi6Eu974WeNZ641AdZZgx6tkYKMo1PpkTmdxT3VW7H2lH2O/ud2fofVLZGeQgJ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlbERUQHU3YIlov7RWQZX8I4KL4UFernRA0uo8BIdYI=;
 b=zMXuqv7yYyG+6dNO5/TqYz6/1T96EA0+rhq1ygHnmke29eAm3zBPinqzjHirSkFM6L2QD/GkrfEjSLb6q1dTmE1tWGOLpHS94fWP+MZ8OjOmSy3HqUrWghZ+TRTX7lOJMj5OlgygsAcHIlqzqU044BGiNZfTadvR38BluaHVmaUAYHnfjQWZp0B4DChScTeOYKXtRMsqxK3Iidy+9icjHRRCZUlaEksQQGxtKwSJ/k4aQ6EvOvA3lmYEyl1yrQFj4M7rA/otqfrr7VXnRlgQX8eQaSV4DqUQ62dr2aXoKH0euasuo2q7iFP7gaa4dC+3nxgmodsE1UAt87A9hIiliA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>
CC: <claudiu.beznea@tuxon.dev>, <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 1/1] arm64: dts: renesas:
 rzg3s-smarc-som: Set bypass for Versa3 PLL2
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 1/1] arm64: dts: renesas:
 rzg3s-smarc-som: Set bypass for Versa3 PLL2
Thread-Index: AQHcwrsk4bgLoXg6LkGNf00OktvHIrXSw+YwgAC8HYCAAN7NQA==
Date: Wed, 8 Apr 2026 00:54:17 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818422FF975952DC966BBC0CD5BA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260402160937.2002534-1-claudiu.beznea.uj@bp.renesas.com>
 <TY7PR01MB14818351766CF1AF2A8D2C3BECD5AA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <adTsLWXKfaKFJV8l@duo.ucw.cz>
In-Reply-To: <adTsLWXKfaKFJV8l@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS9PR01MB17481:EE_
x-ms-office365-filtering-correlation-id: b506096c-01be-4fdc-b8bc-08de95095cf9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 
 mni66yEPTh3wU0aDvGI4tP7oRCG2FKxe/Yxjoadj9BEkxWlXi2nIPZO3IhJVi+AkgTWM746qeYlMZhivTHf+OMa5NJkubT+TOeHlSIQDRbDlm149kf3+nEmNPJ3kD1+R8pKcVFzxZkRGlTakB1RZgMv3ByM0aP6eMbY37Q3fv6RKzzyRf82vtvuaWUlnqGVcKbhr+mcd8sbp+CJdGbZ4qB4T6jKmZu8j4AIsCHQx8q0xWjcfUSHrWqITXykxWWo8sBT40Mic8ketqKu2Y6uCGkDy8eY3jQMqGbFCEIUeotOTgbF76D6M+ljdVaYHVlqYQYdJV6ZPidazSZw8Jl1bvjxJCfX0CanTjD6TPDp3RP7FRoA38Ckm0Bhr9aivKjaC2+Nu/7WqzuWenKrYGaULBg7tAGNbYnJOvDqAXYRqyzCYdny42XAE7rF0hlYmhp/nGqPNu/vnKUWruKNtyfYnjk9VuKAOpRrcLvs/9gzWAlEZ1hpUzXQR2HCdQBKqxNx6HJjwVTqNFzD5tNh4ShlMTwqeE+Q3NgYmM6k2a/dvvrllY+DNrIqf3o+fCl0V1N02m9qB/UpUvBpy38TAfvCnE5w8PkycZ7h2a9MLb8EBuHuEIbOrxpwhp2adQfsYR962JgEw78so97TXXuKLIXOMC3n5lyero9B4B8aXn934jhRZQACKcVPovc4fFT8s6feK7x53vxyWCpRHxpiUYGXv/fLvQyDX3YB/ibYJDaQN+SwkCGonRkzz6lRgOmbws9bm
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?K0RqdGwveVRGK0xGRmxUUm8zNEMrYW5ick1lZU9zQUtyazl6VWpReG44?=
 =?iso-2022-jp?B?ZTJTay9vZ2xRSmNjQjRCaW5iSkhJNEFpTWtHMk9rMFpXbFIrUFFNUTYr?=
 =?iso-2022-jp?B?bSt3b1cxTkNRaisyMGxQMXIyV21JT0JRekY3Rkp1YW1mRHNjejU4WlBw?=
 =?iso-2022-jp?B?dVNIT05jVWd6OG5RemxUMjFqZmhTbjF1WGFsS0sxbE95cXBXOENtY0N5?=
 =?iso-2022-jp?B?MTQ5WXlUVjNVWDJqeGg4SXVFZ2NCdlUyVk55eGJPbnM5ZmU4eVcxdzY5?=
 =?iso-2022-jp?B?c1E5NzVscDlydTVlSHlWeEpsTDE2akVrM0pydUZqL1BqOTZ3WUFPWUph?=
 =?iso-2022-jp?B?NDNCZnlBcFlFUVZzK2g2b2RPZmxiRUxJaWlUbC8rOFFvbWx0bjZjd0Rn?=
 =?iso-2022-jp?B?RDc3Q2EwQXR0MllwMFgvSFpuWmxiR1ByR0trUG9ycG9nSWlpdHZNejFJ?=
 =?iso-2022-jp?B?WEtpcS9Pems2YVB0OHN3SnUxeUVkY0pST2ljVEtZQ0FsMk1XMzlVZzdE?=
 =?iso-2022-jp?B?WWcvRUdHNXRXV0FzQ0lZbjkwVEZYbkp1TElwNm1DSnI1alJQR3NLb215?=
 =?iso-2022-jp?B?L2EzZDNId1BLNEwzQXZROFJmQUJjSHE1QVhRVGVqUUtVVmRWOHRqUjc1?=
 =?iso-2022-jp?B?VFFENmdhNytBa0c0ek0vOUsyeG1nQXZpUmpyVHNyUldEWDBWazUxU1Ns?=
 =?iso-2022-jp?B?NVkxeXlqZVpqdXIvMldIL2xmRkpmL1F3dWNhbUlBWlk1TURDVDl4Unkr?=
 =?iso-2022-jp?B?NGxEMWx4dDR1R2pJVE5qOGhGWDEzZ0hXMkRleUJ1Sk12dVgwcGRkMGVI?=
 =?iso-2022-jp?B?OXh2elRTN1c4eFBNU1J4aWc2c1YzOGdBdTFTSmd3MlRxRXltZVJJN1lD?=
 =?iso-2022-jp?B?bnNtZ1o1Wnl3ZjJEM2JobjkyS1k2NDlrSlFrclpTeHJIL0pnQ3RINlEy?=
 =?iso-2022-jp?B?SjJ3enZuK2c2cExVK3B0OVRyVHhFakIrYjZRVjczdlhpZ1BUb2NzVE1l?=
 =?iso-2022-jp?B?SDFodms3WStKNzBMOWxmK2ppMEFGQ1RVMlQycjZpeGdxVk5QQy9rSEV6?=
 =?iso-2022-jp?B?THhRNGl5Y25jTmIrS2R4MU42dGQyZDFLOWVTaGxNbUxrckFFOUZqSFNU?=
 =?iso-2022-jp?B?MmlwUHBhZHU3T0VaMkhOMzFINDlPN2U3Qm1rcFRQRTJOM1Bkdy9DS3dG?=
 =?iso-2022-jp?B?bE03d2JWOS9FYkhlOC9pMDRUVUJ6ell3MjRobHFsNkxLOFBEb2VkaEhy?=
 =?iso-2022-jp?B?NVI0KzNoRDhMVWVMVTBHVzU5ZnR5NldFc1RUZmMwc3JsakdQTWhQSm9W?=
 =?iso-2022-jp?B?NXZteHdaUmdLdmtNaklzNE12S2g2SkFuZGRQb0ZNaFZqemRDTkxCUmJu?=
 =?iso-2022-jp?B?a0hxdWRuaWF4bkVuZXdRRmQrcmpDUnVxQXlXL3Z4Y3JHTEdxRnpsd3lk?=
 =?iso-2022-jp?B?OElmVkdKM09tS2NTQ1FHa3VsWjFrWEdzekdxT2VpWnNTaEYranRqejFN?=
 =?iso-2022-jp?B?SmhvbnRrQzNTTCtmVUtPLzdrRVpTeFZJRGU0MlhTNFdrWG5uR3c5OFpD?=
 =?iso-2022-jp?B?bE5SZzlqNU9XcFZJbkM5bWJiM01ndE52WXg1T3hwdHprMk5jL01kOXN4?=
 =?iso-2022-jp?B?eVMxQXNmaW52ZzVsQ0hGbUtNcktEZnBYaDhjalRCeGxJNERSM1hWRCtQ?=
 =?iso-2022-jp?B?dDJ3VW10ZXFaM0JtTEk1LzU2REZva09NM1UyTFMrVDNsQUxkQjFMcUhQ?=
 =?iso-2022-jp?B?N25acWZUcVJXOTF6Zmh4ZTVMYzNZa2xLRytoMVp1eDR5aks5dUVTNDc5?=
 =?iso-2022-jp?B?MlhXVG9ZcjFkRDhLMnFTQ0NUbjFkM1ZaR1Bzc21qdW5BL3ZocGR6c3l4?=
 =?iso-2022-jp?B?bnVIbXFlbVJYVFZqNUVDLy9RN0NTenZtR0x4OEVmQ2RmVmUrcSs4dFlh?=
 =?iso-2022-jp?B?blBoRTZNbXZJK3NiMWxGUVVEdXFrbzFwQTljUThGbE5uSzM1NHMxdHdz?=
 =?iso-2022-jp?B?SGNoMFdINkRnenNvWGFWNTdoL3FqbUduVlpFWXUvZlI4dEExMEpNVUdI?=
 =?iso-2022-jp?B?OWhLd1FQcVFxMnc3NWJpUmdPdjVuWWx2Y3JWWkd3MUQrOEFycUNEMTkz?=
 =?iso-2022-jp?B?Vm8zamxKY1htZ0NlUGMxaG1hMTU4VVdqTlhNMCthWC9jRVBHWHNzdWp0?=
 =?iso-2022-jp?B?cHYvU2ZnY1A4RGI3d0d5OCtaR09VVVcwWldZRm9MMkJ4QUo3UDY2WE9B?=
 =?iso-2022-jp?B?cFY3c3dtWkRSTHF6bk4yYlJuUEtkMTRFOUgwVlNPL0YxeXYyaGJBWmJ1?=
 =?iso-2022-jp?B?REN3NGg2VE8vWXZ5ZTdVSS84bUx5RnBZMDlmUm4ySnc0SlcxOTg4N0dE?=
 =?iso-2022-jp?B?YU90VllJMWViMENra0s5S3BJSTV5UlhHVW91Rlh2S0NZZ1dhTmF0aU5m?=
 =?iso-2022-jp?B?blFsT2s0WVlKTlFYUGdmZlordUtQaTAxSEk2QUZjSzQzWVFUZFFzTGhF?=
 =?iso-2022-jp?B?NkFVYWUwazlJamVzeVdVcktuaTRlQUduWk8xMjZOdHBzOXYxTmVYMFNm?=
 =?iso-2022-jp?B?ditDREpIZz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	i6qOzgjWtDVvLzpKC47/oLXylYQ1j9LgOrZlsqIRGId9gNJbRl3TgB+gqYpLmp4aIaMI7pmGqyOAeJVvXFAIiq7Vja6Fl7JuYyBHLc6Lu1GEz6XjZkQtqIO2n0154u3dVB2Pz0C/yedHNs3DAUDwb5hpSGDSybh0/CE5udmFgc7K0KEsexaheEtUMJWECJ4wMiyzxz0Sci8cYO1+N8SdVCpnSjABFyNZPm6icwzwqVT9xUIyUnp63nZTVKZfDNB028zg8xeyqurORq/4AMjh2Bj0AtxBHV/5F0NUPi+/ZEdNfzU663WMEgnxV5dkxLTxlNtKYz0gGFFABC/14hWP8g==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b506096c-01be-4fdc-b8bc-08de95095cf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 00:54:17.9898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lhUqr+jN+MpYUfk6LO3BpZ/QKZ2c/bTQolVCWf5Xo8QAKU/gNK5IS9SiXjaO7gZpgDS0q/3kYUcSg29JBtGIuEJTXKs/YrtGOU4RWBwxTgdiCqHZUQrwXJxslyYGOaCn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB17481
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Apr 2026 00:54:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22634

Hi Pavel,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Pavel Machek via lists.cip-project.org
> Sent: Tuesday, April 7, 2026 8:36 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>
> Cc: claudiu.beznea@tuxon.dev; pavel@nabladev.com; cip-dev@lists.cip-proje=
ct.org
> Subject: Re: [cip-dev] [PATCH 6.1.y-cip 1/1] arm64: dts: renesas: rzg3s-s=
marc-som: Set bypass for Versa3 PLL2
>=20
> Hi!
>=20
> > > commit 6dcbb6f070cccabc6a13d640a5a84de581fdd761 upstream.
> > >
> > > The default settings for the Versa3 device on the Renesas RZ/G3S
> > > SMARC SoM board have PLL2 disabled. PLL2 was later enabled together w=
ith audio support, as it is required to
> support both 44.1 kHz and 48 kHz audio.
> > >
> > > With PLL2 enabled, it was observed that Linux occasionally either
> > > hangs during boot (the last log message being related to the I2C
> > > probe) or randomly crashes. This was mainly reproducible on cold
> > > boots. During debugging, it was also noticed that the Unicode replace=
ment character ( ) sometimes appears on the
> serial console. Further investigation traced this to the configuration ap=
plied through the Versa3 register at offset 0x1c,
> which controls PLL enablement.
> > >
> > > The appearance of the Unicode replacement character suggested an
> > > issue with the SoC reference clock. The RZ/G3S reference clock is pro=
vided by the Versa3 clock generator (REF
> output).
> > >
> > > After checking with the Renesas Versa3 hardware team, it was found
> > > that this is related to the PLL2 lock bit being set through the renes=
as,settings DT property.
> > >
> > > The PLL lock bit must be set to avoid unstable clock output from the =
PLL.
> > > However, due to the Versa3 hardware design, when a PLL lock bit is
> > > set, all outputs (including the REF clock) are temporarily disabled u=
ntil the configured PLLs become stable.
> > >
> > > As an alternative, the bypass bit can be used. This does not
> > > interrupt the
> > > PLL2 output or any other Versa3 outputs, but it may result in
> > > temporary instability on PLL2 output while the configuration is
> > > applied. Since PLL2 feeds only the audio path and audio is not used d=
uring early boot, this is acceptable and does not
> affect system boot.
> > >
> > > Drop the PLL2 lock bit and set the bypass bit instead.
> > >
> > > This has been tested with more than 1000 cold boots.
> > >
> > > Fixes: a94253232b04 ("arm64: dts: renesas: rzg3s-smarc-som: Add
> > > versa3 clock generator node")
> > > Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > Link:
> > > https://patch.msgid.link/20260302135703.162601-1-claudiu.beznea.uj@b
> > > p.renesas.com
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > I reviewed each version, looks good to me.
> > If tests are OK and there is no comment, I can apply.
> >   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/24331=
01088
> >   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/24331=
02394
> >
> > https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/243310
> > 3164
> >
> > Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
>=20
> Looks good to me, 5.10, 6.1 and 6.12 versions:
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>

Thanks, applied.
>=20
> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


