Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAD2C982D2
	for <webhook@archiver.kernel.org>; Fri, 18 Sep 2026 05:57:17 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5021.1789711031824706217
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Sep 2026 22:57:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=I12mV25v;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1789711030;x=1790920630;bh=B20dwgRujOAx9O8CwcgTImO3bCA31P2nJMGsN
	dq+7qA=;b=I12mV25vHtNo5Jr9CCYIiLBQnvxdCoJCSV1XJ9RQUye74wzPpSx1661u1TkMTEHmPdI
	8VTdquy8D3GQ6mOaBLdYYXASZxYDoSX2gr9cYDT61LtYw/njBIsdRHtF87tkG6feqjs6HQtENwYnl
	2+uyKh23V2WN4vhbSTisZ67SZQm33UkJAPUbxRDL3Cl4bRiPO+kEB/6zwBVxe3KeTVYXQEr0+GrOn
	ScKQ1AgHArHnP5lUzx/KzDoZQ4OAocwNwNRZjOE+iGzlWVpWp+mHRF+9LzUlLOPKTpBuYGCiqibe+
	h9xmfpdYQgbahvUxzsz4t5GlZU+g1tKEETSVgNgODeVA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 68I5v9xQ1320440; Fri, 18 Sep 2026 14:57:09 +0900
X-Iguazu-Qid: 2yAahSAkWa5pyU30Qq
X-Iguazu-QSIG: v=2; s=1; t=1789711029; q=2yAahSAkWa5pyU30Qq; m=/Cy3Bt1MtylDO3ZE9xNh/3RBpE7c0G85MzWGxJyVKNU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hmMMn3MFjzyPZ; Fri, 18 Sep 2026 14:57:09 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHxbAZidIhdK0Ftgqr0wT1AmpJdJtdJM8vBqhrc0hgCvwce3ZMP/PJAs6pRBoloGyie5rriR0Ieve6zyaoBgyb63FySh54giK+bPKgAfW5UD8YiqDUQ8SuM8Wze0A4vqdbPHfFv2hZHv1E2hHhTu7Nta4/PaEgOKhegL6Oqo1PJ3e/fdK6IqeU2ABa1CkymkIEEpwJN63y+l/6RMHsVR2HpzxH8CvqVsxpCVQlEEttGY8oE9ulzkDwTJ8QO2QTL7yWZLycu4lpLiV0oEWTsoPGU2+8wcI3EUsh8xJOeIGR4Jq0ALxzFt6euZv4V+z9vkTNFbOU+acIZQq0YZYVroPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lmUrx2EOeb3rrAVwc5s73fgTpOdRPVhJ2VbwTnmxaA=;
 b=O+HorkmPhCx/v7IMm9tH/s8+OVUuUESKGcqQ+nmSPiDGRRT9V2GlpLhggbOd696yCySEsfivNurk71UwsrT87dqx2xbeVd2W914dxTKjLv2PGCUPlmnhc4O50/VEO/OqDa+dBycB7qpF5s6v11I6KeiBVvE7AP/njRdchlJWH9/aPRKRyptUp0FcTslkFrg0S/g4AWqRXCvRjQtLFlhkcb5jLwA2+Wjhrm4AW8LHHVlPq5c31Olik/I21vQIkqQuo4KREzGUw38MM3+10sCSlDzZmXeraiRsQ8L3KNTUqlMNes/iwVEPdpJmv5ay6N4s9CrYFfP/mDZlikJ32+gxVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>
CC: <claudiu.beznea@tuxon.dev>, <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH linux-6.12.y-cip 0/2] mmc: renesas_sdhi:
 Backport support for RZ/G2{E,N}
Thread-Topic: [cip-dev] [PATCH linux-6.12.y-cip 0/2] mmc: renesas_sdhi:
 Backport support for RZ/G2{E,N}
Thread-Index: AQHdQfZO6OPfuj3fSE66J5FNRZDwWrbNmc6QgABmDICABeFAUA==
Date: Fri, 18 Sep 2026 05:57:07 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818DF6E9C6872863CAF9704CD872@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260911140311.2119765-1-claudiu.beznea@tuxon.dev>
 <TY7PR01MB148188FD3311B30DB2C98085DCDBB2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <aqfj98a8wtQw6a-w@duo.ucw.cz>
In-Reply-To: <aqfj98a8wtQw6a-w@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYYPR01MB15189:EE_
x-ms-office365-filtering-correlation-id: 1d9064f8-34be-4127-345c-08df1549ac03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|38070700021|18002099003|22082099003|11063799006|4143699003|10067099003|56012099006;
x-microsoft-antispam-message-info: 
 5xm1Sxkt8htidKO//DX9ROIm5W2RARzCxJSJpIV+czRodfm5JPso8wfpGWEfwvPe/uFs/wF4rqes1Xn7l7aLnMepC7ZYxrffzT4tkhkeEnHoEYPX+IWiUf3fVn7w7TFmmjFTNM6x9g1kIVqoOqHIWOKy1SDjAjMcs0rFuHbjuk5vZ9YyrDeT4OV7VjN7wYenSb6fZmI/jOEi1gdbuzBVVD56PLiLMZX2a2m6eCmOedqr1vPjOp5hvVDxpmUE4km31SqKPXR3pf0P7WbqZ2vhf1L/YTE+Nuti8+rRs/xOOtf/BvsiyB5eG0OoIp6Kpz1KwP7w0rZOAH0k3f+KfRcr5NNd3BzBue8rq9d+MYbv8677zivUe7eujRlBqm0MOs8+baAR5flCVGfvxN8zi+LO4dWCLJPm5ZQq4VIgnMKBQAOw98OrKXu78qs9EJNID2CVVRMZQuiTtpGaC6GiLvrbgIha1gNrhjLOSBM8+jf9dVyrRuMiXWHQl45zOfPl7cxqrfEfKbdRImKOdnGoP4TN1snmrMLDntrik/Rlb85DQWbXG9LnAAZ1nqfgjYRpw2YCBydNcqHPRymwq5OLTge/0kj0m39VXAcs7+vfYQNgyN3Hek5nFRip0bZPJ2Dd8o3atSsfdvZ8OqHGtxJ0eAov9PEX4YiQ8dHPO5eqv0Md1ufvWScm6gw9NEP920Frquo6GWbvYQHa6IJeGudEgariDRTkY+yoLzLLzaRsqKNnvvg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(18002099003)(22082099003)(11063799006)(4143699003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ZlhmZHlTei9QWHIrOU9TajE5cXZQZkptSGNEM0JoWVZwMFZSRXU2RUlM?=
 =?iso-2022-jp?B?SzNvVGFvOG9MK2dRYXR1M1k3SW90MUlqZ1dRVFJCcUpBb0pkN3prR1R4?=
 =?iso-2022-jp?B?YytPVFdpOVdrbVRHb3RTMDNRcCtHMUFjVWJrdzJUL1lZNE90NENVeC9S?=
 =?iso-2022-jp?B?NEtrZHZWMkh6ZVJHSkxWaXdYU3lNY0xUalExeEZwenRnTng4eDdhRURO?=
 =?iso-2022-jp?B?eG1zVlhxMm1zbmlzaXQ4a3U5VWtvYjdDNkxCVG5TWTR0VmNiTktaWEZ0?=
 =?iso-2022-jp?B?WmEyWHM1MURmWE04aG81ZGtyWGswMXB0WWNhSU1RSEc1WW5vbmpWaFJI?=
 =?iso-2022-jp?B?RElZdTJBWXVKZW1ZYm1rYnROTHVqT1RwcVhwL0h6OVIrMm5UdWhyTDlZ?=
 =?iso-2022-jp?B?M1ZGUGdJaW1nNWg4aEt5TXd3dy9SRkMxU2labGxtZ3NSY3R1Z1JsbkRE?=
 =?iso-2022-jp?B?dWVXVmVrQno4TFV2ZlhnNWhWWkl6SS9sQkNKZGJVMlc3WCtDcklHVm54?=
 =?iso-2022-jp?B?NU52cFNWeUJxL0xpazBTQnpSNVR1dWVYVEh4WENmdVJuQUl2UnhDemJo?=
 =?iso-2022-jp?B?ZW1uRkJHclFFWTJYTzg3TVNrNmJ3WCtQVzdBQzNtVC9PSElzbktDT1E1?=
 =?iso-2022-jp?B?U0tHMStzdXpBSFcyZjZoUkFic05OcTV2T2hPUmo2T0lTbnRuK1k1N1Ey?=
 =?iso-2022-jp?B?cTYraTBWYlRrRjBtd1YrakJ6clU5c1VNdnFCay8wNDVLdWhIY1Q5RUgw?=
 =?iso-2022-jp?B?WXM5NG13eFZGL0JqemtGeWd6RktCQkl1WUlhVDdLMVRpc3ROK0JiU0hy?=
 =?iso-2022-jp?B?bkgvSGNhOUR3b0ZDNDk3Z2l4Rk9WRDhJbWpnYWk3TFZaZEVQdWtFVzVl?=
 =?iso-2022-jp?B?Q2E0dWhybXM1QmxNMGpiZXVtbmYxcUp5VlZTQUNDRU9LU3hrTHlnM1Ey?=
 =?iso-2022-jp?B?MnhkZmRnT3R0MjMycG82TUFsWUZrYmQ2Yk5xcmJmZmdUNy9tWWtXYlN3?=
 =?iso-2022-jp?B?S0xPR0k3Q08xb3JFYXIycjNjYTcvNy84cVlMc0kvcG5oTmxJc2Y1bTJL?=
 =?iso-2022-jp?B?Y29lTWpDQW12RXFZNVBuWlpZaVQwK3MyUlhkWk8rbGRCdGtadjlkNjBr?=
 =?iso-2022-jp?B?RVFIaGtLZmJJQVhNMDRSUkhOWmxoRHZnZWl6Uy96RjhTc3U0ZkVObkVX?=
 =?iso-2022-jp?B?KytadXNYMGFMeVhOYlRhanpXVHBYWjh2QitPR3FISGFpYkw1MXJjcTlY?=
 =?iso-2022-jp?B?Ym8rb3k0RnUwYjFnb0E0bkZ6clFJZlcramYwcGRQZ2hhVFM4RDNwS0h6?=
 =?iso-2022-jp?B?ZkhoRzdyN09teFd6YjM0bWZEbGdzL0RVMEVaUUdVRVdMRFkzV1pRc21S?=
 =?iso-2022-jp?B?YW5STElib1NpUitQU0dVME5lbHFhMzMwMXo0aGQzZmdiS3FkSmliWWlr?=
 =?iso-2022-jp?B?ZUNVUzVPWisyZ29hT1FuR2tpWmtKQXd4OCtUaWF5NURYMnRkWnJzUGdm?=
 =?iso-2022-jp?B?TWFCYjRlaXk2U1cwTHk5WDVIYnQ5MUVDOWNFcVEvYTRKdU1oUnc1U3Bo?=
 =?iso-2022-jp?B?V2RzUDhwR1I4V1NHNDUwMzREeVBHWUlBbnpVNEtZS21ENzdVZkFhTzRV?=
 =?iso-2022-jp?B?cUhWVjloWkJ0eFczYzlkQzZIMEhDN2JzckVwRHdRbHRncmZ6L00zSnNI?=
 =?iso-2022-jp?B?WFJ3amFTbWxFc2VlSHRKeTQ1RkNvMTJEcStycmxTdVJZbTlPcE81bDZV?=
 =?iso-2022-jp?B?cWlYTzd1VnArREJ0YjhIeUljMUZEOG9kUllRVkx5U2E3THpsdzY4Q2ZD?=
 =?iso-2022-jp?B?K0xGWDlYSjZaZWxaRkRQY2tSOEFRbUI3TkpqSU1DWUFXRkNpNW9ndzdW?=
 =?iso-2022-jp?B?MGtXM0FPYnBhck16ZUdkWERQb1I0N2MzaG1MV0QyQ0t4dTJYL1loOHJ1?=
 =?iso-2022-jp?B?Z2lRWkgzUXdTSVVLMUx2ZHBoMlMxdnhQa0RFY1R2Rk5mbHFJOHQxM1dR?=
 =?iso-2022-jp?B?U1R4ZDkvaTNaeGpXYjZKWjRqS1pFeTlYeWo3cGlBMVJ5bDhmRjlPWWRP?=
 =?iso-2022-jp?B?bHRoMUV6R3oyVGVQa1ZQSUVzWnBNZUNjTGFhYzdnZHI3RXR5emZvdGF4?=
 =?iso-2022-jp?B?UUxnd1dLUjZ1ZkZLK25nRVZXZExJRXdFSUtxSC9JRWk0b055Q1htYTdU?=
 =?iso-2022-jp?B?bnR6aElBSTJhb1pPZ21sVTFhbUZFa1Z4alZGMTZzNUJNWE5IYzgxYnFv?=
 =?iso-2022-jp?B?K25MV3dNZmhvanUwcXpHYkwwS1Nhbmgvb0lFN3ZpaEtSTE5Pd1gwSDMx?=
 =?iso-2022-jp?B?M2p5dnkwN2lBSmwxZnA4YWw0VWRraHdvZUY4Mmhzb0dQMWt2dWVPVmEx?=
 =?iso-2022-jp?B?S3A0TUZ3NG40ZVhOKzhXNElybUNhNDNEMlNyWm9vcUdhTjcvTEUwbC9Q?=
 =?iso-2022-jp?B?L1MwUUJGeE02cjV0QmlVVWx4ZTdDcDh6UlNmQlBlQUZ4QlYzdG9OeVl3?=
 =?iso-2022-jp?B?dFdJVHI1ZE9EUlBmTGdUQTgzVlNNMW14dWd3YWhibTB6RmZZV2FWVjQx?=
 =?iso-2022-jp?B?dlNiYWNKTT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	Fkbc6a58Jlq1T07eBgeQzARwWxf9UDrU6THV/+nfRmM0ARdtJlljXdu//8Zk0+ZCu02I2/FjNmYmFIgjDkHdQPUsdUle+69LgYpN9jjiB9LglslKkKE8iiZ8nQGd682dpvpGuzfDRvdc6xTK8LIr7UGERefyVXjfEQk1r8hd7M07fnfYvPMlm+Nsuhue4XAGthJCqpBNS0IrvCDO2uwHB0drg1Ddx6MZ81vK9gyMq9YG28qSpflt3KKORuceK2cB9OKR3u2r4tE+cROyoG9p8mPi5nTafNHLKYltPIO5JshKyPS9qsX15HAZUgQtcUIWpVFAIpvOrYiCPo9CQHFWiw==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d9064f8-34be-4127-345c-08df1549ac03
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 05:57:07.2572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XYMhkbqy60y8ySzDPgISiw3LM8FfME7/ZMI6JLN7HF/k2ZwdeQRhAcLs9enXPIrXqBylzjYYCJ2kOZJBI0/FDDxy/VS6oqdgSR6BNtc/L6VCceiViPKFDi+flR324t9g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB15189
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Sep 2026 05:57:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24230

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: Monday, September 14, 2026 9:09 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Cc: claudiu.beznea@tuxon.dev; pavel@nabladev.com;
> cip-dev@lists.cip-project.org
> Subject: Re: [cip-dev] [PATCH linux-6.12.y-cip 0/2] mmc: renesas_sdhi:
> Backport support for RZ/G2{E,N}
>=20
> Hi!
>=20
> > >  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > I reviewed this series, looks good to me.
> > I can apply this if tests are OK and there are no other comments.
> >   Test:
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/284575090=
1
> >
> > Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
Applied, thanks.

Best regards,
  Nobuhiro                                                            Pavel


