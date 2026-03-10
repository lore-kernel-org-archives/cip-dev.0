Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE28FCC9CE
	for <webhook@archiver.kernel.org>; Tue, 10 Mar 2026 06:33:54 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34214.1773124425582921546
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 23:33:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=V8UpUgCC;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1773124422;x=1774334022;bh=mcWd2J0p/Kc6ly0bD86t+4yxlSqGzchMs1gVu
	PwU7tw=;b=V8UpUgCCWuxjKvFhUSpgcyyOoOgTDIbJBaY+e3DRqfZhhqdbb0znFwKdMUWlKsWH4/7
	3t5TzquYEynTZiGw0pSkc/5Zl9UB2a+kXIV76cWjaRdTVdg3CNtxDEtvhzRz42DC5wmq3Rrrpq/MZ
	z6Hm0g53ja2C/g48iBZ2PHJnCTkpMBg463kR/DPnV6h1Jj9VqQsjpI7CLiDn+csFJtMpEMDTT6qJU
	96ZJyH66230cCL+vQW9xvptEvWkWiZYhNcNTrLm3pKZXPhiaDsxFA7QlEisXKq5zJESMQsZggfXU3
	/BK1KN5hnLzdWB0l93kKEYJAEQvGnOehZ/UlDuDGvSyQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 62A6Xg0q256108; Tue, 10 Mar 2026 15:33:42 +0900
X-Iguazu-Qid: 2yAaqAs08fH7RvQXrD
X-Iguazu-QSIG: v=2; s=0; t=1773124422; q=2yAaqAs08fH7RvQXrD; m=i9IdeN2hypIWa2zCxZ98t7Kkr41HhB9BP7kecWhF3qo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fVPGY4Zjdz1xnc; Tue, 10 Mar 2026 15:33:41 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zApRTKYdHNuZMSFRThJRkBfBblEXaJBuWXkAGtifklJrL4AJxLh4cN9W9PMWJizW1qSFEohSjgXVH3UayqM818/8Ika6mQYxCX1JWMem+mPVl94OAvSF62UM0BiNK4SBiJAdMzolA/5ctnk86HmSXvpKrPPzHDDjKR8HSfW38OuIgDWvWOLQTGct72h3iq5Vw9Q8xHAIGpr1QfOkVdGeLxyA90YxJaRscFP3AcyllzT4Ta46bYlK4uFLm/+e4xd4ZMlUR6+bAVJtkne3zlzoU8DkUIb9fP72bmGcCIQ4KIM6oTPrPfifJi9LB0BmYx/Wo5b6cSMfHDWZUr/bGZ0Yyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZM/6sa2RqLfLzykomMTyh0Ia4zxG6s0W3noz9JFK7yw=;
 b=sZA1uEE6ctSQlBmRqkCEqDN0lu/m9DChzqT6k+0ZWyrTDoE2k9/S8ULniyJGFHQMzX9hpJHGPw22jU/ef4sLS5wv16m9//0dmLR2yINW9MQ0WTL5tu5F90enJA2EKEYh0E4vsuPIaTrsij5c1GnJFboba+NSl1viOZShZcDZSQsjCneD7v/UEEpxwwiujIAO2xPWU1JXezKuEBi4iVaL/IN6aq0g0XJjrgv1FhjNAteWjyQbQrX30n7gHOvtSijkeVJ388QM6yJBh1M4JyffLf2jZBkztl2s7x0DsOFJ2v21dZCZNH0xBVjPo7arDPKnlijadh9KSfkW6Lrr+c+N/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <cosmin-gabriel.tanislav.xa@renesas.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 00/11] Add ADCs support for RZ/T2H
 and RZ/N2H
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 00/11] Add ADCs support for RZ/T2H
 and RZ/N2H
Thread-Index: AQHcqy50789Uy8ItYEWG6FgXqaOBbbWfookAgAe15dA=
Date: Tue, 10 Mar 2026 06:33:39 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818600E30378CE365EEFBC1CD46A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260303165351.914437-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <aalCtoFg4lm1b0jI@duo.ucw.cz>
In-Reply-To: <aalCtoFg4lm1b0jI@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS3PR01MB8748:EE_
x-ms-office365-filtering-correlation-id: 6b5d166d-a564-422d-1803-08de7e6ef73b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|14052099004|7053199007;
x-microsoft-antispam-message-info: 
 lVvgfmvH3T1IBNoAJT5c9U9DdV0ruRbAEOX0SROk6ucVPJPhmBV6dBbuJByeyyhWevgMDZU8veyBfvEAgXp2YlHt7DeZvRf8NVaFuwRNngGc4ZDtxu+77mLLFDLAzRDY3SEFQfDypJlSD/xHFzY9yBS1nbHVBabXe3X8yUOtXgTS1xkwydGpGgcYcHGf8VbijcXODpJX+8GZT0JAnYdcMny+phKHo2LWo3tQMuFVli5QjZQM4++EZEjnOJScwtgJwfRF7YHSZCnfOVfbPqZQ140qd5j5TMsMqJkZEPsqJOa9UA5sXVtAa2FcJYWwd1W5JsM8TCdDWqXnrtqMrDcdbcID3I3qAfVkjXh4CjtpbV3EKuIPF3lDJ4fR9BcBqS2YoOywunGDu+SejpksbBTOiYjPyDbJSPjLzmLXz7tgUm+8YoVg4TxgllHz6/40pmjcmo9rp5XrLUln1oqlpfKScAEnNsS8Mvy3Tbz1AaZ9iIkY3eQPtfqFniW+9rgL0UPEPb6IZlMP/keKv8GxZpc1kCPckIPVWoKpzgI6gZFNZhOnY5RwBNC84cEYzoXFbYnwQgsYV/AwccE0kdFC/hYM/oXZrvxx+fEz0g54eMN7JO7pHeUjU9de2/rBGFVX5xSoNNg+hYj8BwuMeonyfWpWrlV06ztUN4pJVUyPbfo/HToJk1fDUbLETPfzfpObQ66VWV+Ue5+nhLo+oCKDkVS6xuQIMcLX0Emvf00DpTrI6Id6U7rQ4NNuDpM17KogEaeGVGp4u/UP9NJnNC1kdbl8JFGhnICtO/nrocwx0mCBq/M=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(14052099004)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?TFc1RmNseHdValpEWElzQzBlUzdkeDJSL2U2UlZvNGpoRVJFemdzUWNQ?=
 =?iso-2022-jp?B?M2w5TUZLNUUzR01aR0pLV0hHemkzcmpnMkdqWXZKeEduRmlZa0lMNlhT?=
 =?iso-2022-jp?B?eUQ1VXdsZmEySDFGQ3ExVTVXeTBsVG9Rd2RqZGNyY2lUaHFjTjlHcVov?=
 =?iso-2022-jp?B?bXZtdVEyaTBndnlzaWt6cnBObjZvdnplbytMc3dTc1plcXdLMWxwSmtY?=
 =?iso-2022-jp?B?TndQK2JyR0NzNVJ2dUpWSC9WQnlqWnN4c1JMNnNGeEhEM1ZESEFpbFFY?=
 =?iso-2022-jp?B?cDVUdzB6UEJOSFVrYzY1Lzk5WHZHSEYxMkVKVTVHdXJyZG8wSTNJekda?=
 =?iso-2022-jp?B?TERLZjVnZmpQZkR1aHd3NDNhZG9PYVBEQlg4Ykt6Qm5KeStIS0xaSlZo?=
 =?iso-2022-jp?B?MStOeTEveWlsWEtOUGYrYXRKbW9yRE1MZjkwdmZmZXQvNnJXeDRLcVZ4?=
 =?iso-2022-jp?B?aUJrZWt1emxpN1hHaHpTaXdLdlZSU3ZGakJ0NDlOalNqTHN5UHVkVGJi?=
 =?iso-2022-jp?B?ZDFTY3FMMjBqYnpjSHAxeUZONTdYcTVoVEcxQ3RkcXh0SVhDZVhUbGd0?=
 =?iso-2022-jp?B?alNOeGJ4Q0kyZ1ZYWCsvNG12MVhuR0dmbkxxMEprOVphTTRKTFRHMys5?=
 =?iso-2022-jp?B?VzNvYzR6YXFEa2dzLzVCMnRUVEw1ajJZWHJTUExkd0xjQnhxdXNmWVo5?=
 =?iso-2022-jp?B?K216em12UHJySDFzTm5ZOCtvc2NnenV1WUYwVkg5aGg1L0I3RkY4Mk1G?=
 =?iso-2022-jp?B?UWxxaE9DMlNnK2x4cmdCNTBXc2VCcGc2a2ljQXYzcENZbzV0b2F3NWJZ?=
 =?iso-2022-jp?B?VUJoWHVYRkRvVU9MbUlyZUxOTlpaV2RIcGtnZXUyQmxqMDRHdVN6WUdL?=
 =?iso-2022-jp?B?WHhwaENYRU5YQUNnUmo1MXZuTjQ2dzNBcEFBWmhLN3p1aDh0bkJpYU1B?=
 =?iso-2022-jp?B?MEE2d0d2VXZPTk45ejVMeFlkTkQxSXZYVjk3cUdVMklySThXcXNBenlM?=
 =?iso-2022-jp?B?d3hVMnFKenEzayt0WDlWNDNYRVRkbmREenMzU3M0THZJOTFvVStjVUVQ?=
 =?iso-2022-jp?B?OElJWGYvdmNWL3dHb25MY2FJbmtkMThGTWoxUmxCYTZXNVJKN3l5UUt2?=
 =?iso-2022-jp?B?MzJDVEJzSmlOemhFbU1KanZJK1U0bkVzWVlhUjdrbzNMNnJ2Z3pWMVNK?=
 =?iso-2022-jp?B?aE8rc09FTXdWL0tQR3FlNTIxK3hjT2hMN2FBczFuYVdqUzR6Z1piY0xD?=
 =?iso-2022-jp?B?dm9wcEM5M1AyRGRUSjUrOWxmRWtScW4veHI1TEU0cllFOThRYnUxUTdl?=
 =?iso-2022-jp?B?bFBmVkg0WVo0YzVYUkc0WWE5cnc5TWJWbTV6cnB3R0RnQ2lGZ3FEOWl5?=
 =?iso-2022-jp?B?NTd1ZWdsWE5PNlkyRGc3SVZkUmdzNmdyTTFvNWxjZU93c0M0ZHF3bGFV?=
 =?iso-2022-jp?B?MXAvWVJ6K3d1Q2dDR08wVDludnA0eG0xa3N5ZmlUazNzYnlpa0wwa0dP?=
 =?iso-2022-jp?B?ekoxV2IzUWFmNG1QU2luRHJzclJGMUhudnJHZzViM0pVeGs5MWpOSTRm?=
 =?iso-2022-jp?B?bG80RmI5dmNvRkJ6TERJd3hjSUFSdlJxKytJemRMOGJGMk9GbDh5Tjh6?=
 =?iso-2022-jp?B?bGlDWmVyTHVVU1piendYeStwM0x1VnV1a05wNTFkdTl6SGJ0QW9iZHgr?=
 =?iso-2022-jp?B?M09FWGg5Lzl6QkpMYlUwU09vZ1dSdUtySnQ0THhycjRuVWlxVlhnQ3c2?=
 =?iso-2022-jp?B?RHVMQlpnaGFOZFo1aVJzWklSZVlycVRNc0VrRFl1RlNOOUJIWTRNVWdC?=
 =?iso-2022-jp?B?MElxcTBqbnN0anZDTTd4eVhOeU40dURUU3RPTTk2QnZRNngyK3BCbVgx?=
 =?iso-2022-jp?B?UTlxNi96MW0zdWowU2paSCtLTThFRUU5WVhZTUZVWElVVURaeUFuU2VS?=
 =?iso-2022-jp?B?LzFueWN3RUNiZHdkcFRQR1pmZERmOFgxREVqMXFNWDBpZ3NlcFN3L2Fi?=
 =?iso-2022-jp?B?TVo0NHdkOFlOUlB5ZVRsR3lEUUFjVmpMRE5qcnhKV3p3Q2dCZGt2MWww?=
 =?iso-2022-jp?B?TjlZWmF0MVA3VDlHbnhBT1dwRnhsclhGUmNoZUs1cmNYV3dKMS9oYnJa?=
 =?iso-2022-jp?B?ZmtGdGRuMkFCVXVCdnlBTUZ6SHVMK2U2c3VUYUtnZzQ5c1ZRdHpEdjBa?=
 =?iso-2022-jp?B?ZUpBaTdFa1RiQjhzYzU5MThlRStKZG9pL0VSNktONVMvMmw4R1cxd3ln?=
 =?iso-2022-jp?B?YUdGRjFlRGFkd0lFekgzdzdNaVp5KzhQSzZaQzhJZC96M3dkSFV3TTha?=
 =?iso-2022-jp?B?b3I0Y2Z6OHBCQ3h3QTVtQ2Z2YTdlUWIvRGhmMmVyM2tqUSsvT2dBMEx3?=
 =?iso-2022-jp?B?czZKb2hlQzQ5b2tBeXl4K0g4RWM5UHpqTldpeVkwSDZKWmVTcnV4ZTNa?=
 =?iso-2022-jp?B?VXNzdFFOelN2TE4weS9FaFN4eElFeVM1YzFrTDl2K01ralN2VFFpSVM2?=
 =?iso-2022-jp?B?bWdGNTFuZGNuTG5LODdxYUx2ZEN1OU9kdEJyeGxXci96TFBvQXYzRWpP?=
 =?iso-2022-jp?B?YytQVUo4Zz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	Zcnzwe4xyRpSBVrydtiz7xYgaI06WV433eLR+4BuNxh0ayv7M5oaV/7f+44bEKnFY5a7zKEP9zuFy7WGBli+RWECksWEQNU0PwAsx/FWg3ALtBXbN31yUj9TlIVqti2TGCxyhjvX5t5X6Can1SGsUDmOCPqwfSyu570ZBdl24+7bfAX/IcldPOh9uHgMDycNMxul8pI0jauBoQG/Bbxj0C9HizgC+QLKeFtElQCyHuVhF9gzdiL0xwjM5YTLPYttLNC+wZC7OHW6yufisJDKmHRtQ27uaZRxPZlikVIRZDuhbEDNIlrd7j03g2uAlAEiiBYpzl6OpKNILbp4wo6Dcw==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5d166d-a564-422d-1803-08de7e6ef73b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 06:33:39.2017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wg0Hn/aieTkux41d+jcSCzHDSTeHXT/Xx/M+Sl1OfhzMv+77Z/0Zkcjhvm0hwNHed85/wUi9zLzvIzvdlXMqSxLryP4Ab2Tj4ufPWWFUhljFJC/9Sm7Y5MlpSdkIv19E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8748
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Mar 2026 06:33:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22224

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Thursday, March 5, 2026 5:46 PM
> To: cosmin-gabriel.tanislav.xa@renesas.com
> Cc: cip-dev@lists.cip-project.org; pavel@nabladev.com; iwamatsu nobuhiro(=
=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/11] Add ADCs support for RZ/T=
2H and RZ/N2H
>=20
> Hi!
>=20
> On Tue 2026-03-03 18:53:40, Cosmin Tanislav via lists.cip-project.org wro=
te:
> > Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs include three
> > 12-Bit successive approximation A/D converters.
>=20
> I had some minor comments here, but those should be fixed in mainline, fi=
rst, so they should not block the merge.
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.

I reviewed this series, looks good to me too.
I will apply this with Pavel's Reviewed-by tag.

>=20
> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


