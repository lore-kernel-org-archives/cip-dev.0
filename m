Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E0DCD5BD5
	for <webhook@archiver.kernel.org>; Thu, 28 May 2026 22:05:06 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22041.1780005900843687082
 for <cip-dev@lists.cip-project.org>;
 Thu, 28 May 2026 15:05:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=cl5KBeLR;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1780005898;x=1781215498;bh=7NxgeAJTNzdfZtFcmVHm3zhusHuad4349bgX4
	1Q3IlE=;b=cl5KBeLR93csGArvqbiOd73eiIj8eZmBpN7i9gHdXYI9DZDblMRqrIXNY84hIcxn/kr
	R9pIex498+3PGs8R6Wls62toQCOWi5eD3dCJvM5Gm0MKFsgXEXlOehZtPM0NnuJJjJmQpkKBXydxg
	fucDVzQQVhsmXH9YoE+6ygmYJjITPU+z6MzX2yPSvW+SsSGqOkxKoUkJgekASax5Tk6GT5nRSuuh6
	m41qKfQOYQ5XJVDYT+cCQEv0E158IV9bg5w6OVE08zuvW+mb8B8JauinaaGDoWJiTwLSzMfaWjNXz
	0ROeQ67WkbXXiTe7W1eaKeZ/7WC+uIV+YvN+OBAFwAag==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 64SM4vS83737829; Fri, 29 May 2026 07:04:57 +0900
X-Iguazu-Qid: 2yAbL1s9g0QzRlq8Vk
X-Iguazu-QSIG: v=2; s=0; t=1780005897; q=2yAbL1s9g0QzRlq8Vk; m=SLRKc/bq9dRpj1GWQeIHGW6AjH1d3mXD3BosbeWWY64=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gRLBc6kxcz1xnZ; Fri, 29 May 2026 07:04:56 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+NWUmjRy8xir2pfqM3C//3+1piO28L4oWLevOgT/7ZjGQ6bJWwqGJ73YuYuR48bipH7bZ6rL4BrE9/pqM+5qBZ07LAFVTue/tc+JL43AqJasLNiQCW7b1QiFPggU9yDiKYl/HLwz1PBftsUeHnwhmP9q6JbstD4KFMGGagnJBypZSON5B2ndAneWZjHHBmmOshN0l/KRDhm0LdHAQI019uIZ97y7WGfyeGv5rnOSJKQEZHlWFouLBAo+AzF64MDcaWigepxNNg3gRqt+rP5PDcYZ0VwEUaguiRaxzNuLpT0pq8szZ7Rytu1EVZGxkrKcXQbbvCRBSVrxxz6X5qEIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wl4XvurkZFlfYyNK3Bc7MGIXdsDl4L1ArtpLwRLSVBA=;
 b=E8SxCrhhDi6P9MVQFa78afu27DFNDY/A1UD5mUeZswfJbPgach1JpyARB0qwsx8Ijd8Z/rne1htE0F8Zo2thsleJZALRlWBJwCLIRGOS3zT3WK8bclP8vzCyoGjsxzfiUbrAQvR1wQxkNCe868aNGQ3vBRqk76CMyi+92OSjp2W28ptzzmQX4UOfF43UQwSxl6UOedNY9jr0bI0ZLFRWjgBZp8vSb4KctKJNLSWDEhCv+zw2EbY5xq31nq3EV6IJceuWxuWqz8YtQ0wMop6nhRQvvEqvF4dk+FW7s3cp8Typi6S/Ls1tbclap+jsWshXa6aFgqfFqFKTzKU65WLvBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip] i2c: riic: Implement bus recovery
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip] i2c: riic: Implement bus recovery
Thread-Index: AQHc7fTjQsFZwnOFvUK03klPmNjpArYiXc8AgAGiDCA=
Date: Thu, 28 May 2026 22:04:54 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818BAA71D95339A00ABACB2CD092@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260527162119.52245-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ahddIAv7e7UneixV@duo.ucw.cz>
In-Reply-To: <ahddIAv7e7UneixV@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS3PR01MB9914:EE_
x-ms-office365-filtering-correlation-id: 78d723b4-f698-4f5a-acad-08debd052644
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|56012099006|11063799006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: 
 AfUL3OESi+6obXPkdotKTFgcBYfY5HIoDuoqeFMXCOovfjKQ+Uwlf4fz7suLX1GLpbQtH/l6LHlZU+NjYtCaxbjIYFqkhfF7sEVitCmnu0gdHhgFzPGfC4q2bu4WLaHvZxOqhueyVm3ZuBTEuAn00KwksgJEa6znmSwud3RyJn/hoqsnQbEz3Rm7CSXQXTEIT93MnJnJGTh/vqLxP16rlTQtxuYDXS5Yv5Uu3BSHOJ+9rv6W0kWwoB0KQYnBidoRbz+R6WBIRMek1Wic9/HVB/CqOZe8Pfz46CI8kchTY1gXH/0NDOxuayjpUw2aA5+G9B7ALGC6tKBrnMHVEMm/MV0z+JpxX5xhQyu3J3flmSqCJdpFa4WOq1RtY5i3iKPs14miWm6PrmTPh0nQgEkG3NpM3vgjctO1+2c76ONk1Fi+uSLQVcIGPnKgeZII1QhCeKs/n/oyvmlXkaU/qJEuOYMQTJqt3sgT2beusZ8t6XwmQ5am5B1xa8lWm/7F86P3N0jQqsZlsUSfyniccBlQmKMehT8S7HuNpyNJG8xLtaMNXczzT1A6KyuQVgHAPE1M1Y7Ew+cU1oG5VOE5mTXQoXXXljWwNYnxrYni8JQXYATxzjhf4UVBYPM2Q5HgZy/C8ElzQZkysLibdZ6clP5AFnqlHacnlxAyqiL5khtkjaj7ZfXgGYoH5LOSl+b3iX46Aq4qQpLm+SKZT+aBwLkGEN1wXKgLVjgox9jdO/n+Po0v/SWMCP04jy7Pmqg6VOfP
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?REtqc0dVN09DQkdWQTJTMUtDcCtFRTJQa0JCY2x5dGk4SlhKMHVVZzFU?=
 =?iso-2022-jp?B?VjgxclFqQWw2SC84d1hrN1NqL203TlZwQ3JCbERlUWwvSHJ4OXRMSnh0?=
 =?iso-2022-jp?B?OTMraG5xWXo4WnFQSGF5RGNYUWhGRDVMZEt5RjZVdWR1MzJFZU1XcGNo?=
 =?iso-2022-jp?B?TFd3Z29vOFdoQ08xdXdBdXJodE5xWVdkZDU5Q2Q0L2dpMUZSc2dISFRR?=
 =?iso-2022-jp?B?eWpJQlBNbEFKdFlKUko1QlFnYlNySUkrSGlDaHdpcHNtc096Qk12OEth?=
 =?iso-2022-jp?B?NFpwQkp0eHkzMzlMRXd3c1BVZW00NnE0OUtXaE1kVURFQW1HMCtNQjFM?=
 =?iso-2022-jp?B?TTNuVC83aW1BL0xqbm91ZGxFQzVTVXA5WXBvS2g2bnhNL0ExVVZPRGk0?=
 =?iso-2022-jp?B?Z0tTOU1WMWJkWFBmb2VoRHdWS3kxdXh2QmV6Y3V3K0JSUnYwOEd1dVFR?=
 =?iso-2022-jp?B?Slh4OHBHRVMxaFF1N1Z1Tnd3UnNnVk9mL1hqZVQrS0lScVBLL1R4TE9Y?=
 =?iso-2022-jp?B?VTBIeEN5Z1ljUFZyRi9uQUlBdlduMjlrTFphdkR5d2k1ZHNuMGtXZ2FY?=
 =?iso-2022-jp?B?WEI5eXlXUXNOUytMV2tzYzA0Zko1Z3daWmpRZS9mUzJ6ZXY4bTkzSURw?=
 =?iso-2022-jp?B?c21CSDV2aXdNWGZKOGpKUDZQOUF1THVPbkNnRTNVUnIralRhRExGdU5v?=
 =?iso-2022-jp?B?ZzNwT2c3YVA1VXVOTkFobnB4NHIzbm9pVlhuRW42TkVOUVN0K3pmV1Rw?=
 =?iso-2022-jp?B?MTV5NE1KbXJxc0lyMmtzeERuVXd5WVk2blJCYzJDem5uMkt0UmtnQTlv?=
 =?iso-2022-jp?B?WkpIZTVQSFRjUjBnSlBER3BWRENVaGp3TW1DUUMzR0Fkdzc3UkgyMnlI?=
 =?iso-2022-jp?B?VThMQVhLc1VyS29MOWdnUE5FVHEycjVpY3VIU0ZZK0xWMVlNV1BQT2tk?=
 =?iso-2022-jp?B?bXpiSmthRE5Pc0RaV1ZyTUZOY2ZPMDNaaGUweE93eFBwcDdpNVh6d09m?=
 =?iso-2022-jp?B?ZENmM0RPQnVIN05JTVhjbU9SbVVuVlR4RThvdDhNOTNPTmtuMkV4NHgy?=
 =?iso-2022-jp?B?N1pZSlU4N0RkaGRyenQzL0ovYXlMRTFJTGk4UFNtUmN3VkVoYjhWcGpz?=
 =?iso-2022-jp?B?VHNMNXJwZTZocFZncFB2eVdaWHp4cG9CcmRDTFJoOEpSOXM5SWV0MFVY?=
 =?iso-2022-jp?B?U080V3Nudm8rdk5QdUZNSldOc1RTUnV2cDhVQkhubzhWQ1ZROTBIVURx?=
 =?iso-2022-jp?B?TDBtT1Qxb1UrN0xwQ0p0ZitxNmVxM2s4cnFYWGxaSDQweW15d0g0ZzV4?=
 =?iso-2022-jp?B?UnRFRWpEK0JoQzVkYlhQak8xSXVVMzRGdGU0aHhkQ2c2dTRhTmFFUWJ4?=
 =?iso-2022-jp?B?RlJHdGVPMUM5Q1I1Wnd0RFRIdk9wclZ2VU14bFZCT0VqYVZCQ1lST1R1?=
 =?iso-2022-jp?B?NGIyc2V3UjdmcHp0ajZKY0FlVGJTTXAzN1doV2RlR2hGZ0JBTDRQai85?=
 =?iso-2022-jp?B?VXJmRUQxU29iWkdGR00rZys0TTJma21QWUpLVVFSZjdBZnJYaEM3NGtr?=
 =?iso-2022-jp?B?VlNTRnAzYXFRZk9NMjhUeHpYSDRkVmtxQy84M1h3VFhBZ1doRXNrVE5o?=
 =?iso-2022-jp?B?bGxWWHd0eDl1dUgrNDVncFBJc2hsOWxJOFRwV1dFNGx3WU9OVnRZL2tF?=
 =?iso-2022-jp?B?RzRmcEtNYThxMkJsRWkrMGoxSzR6NXpKSGxQOStHY2hZRTB4WXJpZHlr?=
 =?iso-2022-jp?B?eGhsdkpCeEVKd2liZ3NnMzRrVlNYQU9Qb3VKTnpXa2NwYW1hZmFHV2hT?=
 =?iso-2022-jp?B?L0Y5aXBvOE1wcHRCRDF4Snl5dG9sWFlBa2FWZFovOXRhbFpuYzZCU1VJ?=
 =?iso-2022-jp?B?SmI4T280Q2xTSERoenlWQjU1b3VhaTBRVTBUY1lwaTZDL3dzVXVObjhY?=
 =?iso-2022-jp?B?UHNLS3pBM3lpS0ZMbklIV3NuT3hQTm5pcTgzVHo2NzZ5dWtqTmZDZG1q?=
 =?iso-2022-jp?B?MUtsL29rd2pldWpEMVlwZUFJbTB2SmxCRnFpOUlkdzFSL2VSS0ZqdFB3?=
 =?iso-2022-jp?B?T2V6QmF6aFRpNFVDREswQjBPM0JUdFpscEZyTThua1lsN1dKTU1Sam9T?=
 =?iso-2022-jp?B?VURhL00rV1hUVHJTY1Z5dkQ0cXAwWFJPa1g2a1o5cUx4WGppcGxCS3U5?=
 =?iso-2022-jp?B?WEVCa3h4MkZ4blhhNVFDZU5qMi9uVzIzWGxkUjhIbWdxUXphL1ZkV2lG?=
 =?iso-2022-jp?B?c21BcjErT245TGk0SjNRSGZxQVJxNDZoVENKZkEzL1hGZ0hVRjdtRG1B?=
 =?iso-2022-jp?B?dU5MOFVZd2NnbVNsNEdjTmg0NFJ4b3N5eGVhUzhQdlhVRE9yUkkrUm91?=
 =?iso-2022-jp?B?VERXR2ExT25YNGZqcXl6bXdGUmw5Mi93QXhaQmFOOC9WVEtTZ2M1WFZK?=
 =?iso-2022-jp?B?Yi9SYUU2TS82MHBzcG9jejZ1VUtnU0ZLOXE0UU5CVEMyMFRvYzRqeUlL?=
 =?iso-2022-jp?B?RSs2QkpXS3RRWms4MUxxR3BaYVVKdVBQWTNvTU5YK1ZTb1FnWkpKTVFE?=
 =?iso-2022-jp?B?dGlLL0lsUT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	A8E/ksbCNsPOT0Ke6y9+OA8DN46MSp/KXbH+yTooIXHMAXiUIUqk01eVh+iBGNKQO2/ekaDjuoc+E5QfBRRvIRNr60Gy7VVPao0qNCtBBpuirmI5nsPlfPuWnzwh8RVjO6RVLnTWlDHC/+u2u7AHCvykY7XxkpSXhw1EjnB5s+Qvow8gTSpOp2D/pEo49H+b795PQ/QS4AC9zcySkL3qP1/oVVpjISairvuIusn8Tx63zC8iGAIdIH15ZBTmrg1ugYy/+0Bm5HXhrLpettAdr3fR3kvq6oJtz5RsAwxhbgvYNEJOC2FqhxYnsT6GCzVl46gNRMXawZZU5LQyrzCEGw==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d723b4-f698-4f5a-acad-08debd052644
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 22:04:54.7321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mO9YqD8tNcKgN5oXj+icfUmfHgarh0BP0Rf19JB4GBmcO0PUPo0p5e8lz1CFNWEp3dUaV/+JRxaRNMmKAxKuX9hTHE4kInT432R3RWnUFE/5mf/SG43WgRduB000JMTO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9914
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 May 2026 22:05:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23037

HI all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Pavel Machek via lists.cip-project.org
> Sent: Thursday, May 28, 2026 6:08 AM
> To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek <pavel@nabladev.com>; =
Biju Das
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [cip-dev] [PATCH 6.1.y-cip] i2c: riic: Implement bus recover=
y
>=20
> HI!
>=20
> > commit ba9e1b5254783528e10b45b1f0fb40e21f4ff88a upstream.
> >
> > Implement I2C bus recovery support for the RIIC controller by making
> > use of software-controlled SCL and SDA line manipulation. The
> > controller allows forcing SCL and SDA levels through control bits,
> > which enables generation of manual clock pulses and a stop condition to=
 free a stuck bus.
> >
> > This implementation wires up the bus recovery mechanism using
> > i2c_generic_scl_recovery and provides get/set operations for SCL and SD=
A.
> >
> > This allows the RIIC driver to recover from bus hang scenarios where
> > SDA is held low by a slave.
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply this if it passes testing and there are no other comments.
>=20
> Best regards,
>                                                                 Pavel

Applied with Pavel's Reviewed-by tag, thanks.

Best regards,
  Nobuhiro


