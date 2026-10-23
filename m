Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5450.1792757338489602001
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 Oct 2026 05:08:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=UZm26Pcm;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1792757331;x=1793966931;bh=ZY3tj2a0l/WBVsVZte1hVJH56vUplG+26rscU
	9SGQzo=;b=UZm26Pcmulf9Yuv55apagtezVJjtUj2qbZKeNjmqdcewT0N3rDWKt0LrdfzxPq67B2s
	5vArZ+v9VkUHKWY+bRRPjdNtwm7yAgm17d9Zd7BqKyJ/9WLzBQZTbVgU+qEBCy9aG95iIKoCSGSCn
	30kcmizVXKKI/zi9h7616LZGVD+BeqD2m81OV3GT3eZdbS1PTYLARYxmMXXzHha8+toyvrl8vnGL8
	w9sH0HwXx4pVwkh5BVxtqPZXRG24+Z+Og5heDT2kFulQTKSHpnZONPHS3+f+vt8CbsmPonqrAUxTU
	L54r2jAYnS4xlatsMJZsCwDAiKrGb1Vdx+QqlNWARMgg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 69NC8pUB882955; Fri, 23 Oct 2026 21:08:51 +0900
X-Iguazu-Qid: 2rWgRCuG54xva6I4WX
X-Iguazu-QSIG: v=2; s=1; t=1792757330; q=2rWgRCuG54xva6I4WX; m=eVValC0me6Swsa5haguVe+VvGJ7dQiLDEiUDmXnVNr0=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jB1yV3HsRz1xng; Fri, 23 Oct 2026 21:08:50 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BdRv8HSlA5uyvh7XNMaJInntw+Cj3ujeJgDmpIbLMdoQIffQEi8l7k8hZf3gYh1Nr2gF0onc+QPPsQd+Dn61XATuFoIAfIhmRFbM39/ojDybYd9T2eU0mkaluDTWI9SltaB6BVh/9LLVrjYjokiRHPWOyYfw0L3rGvbFDGIor6ltwktOKkYYgZau+bcqh46jIvHTCmAcwRAcHiA3rOi4Ol8rPZEKMKU9BvH01C/HlOWMkO2ajPlmhLHQP2lgI4/0oqPHvi48VKGIAQcQvI7mqwD9sUlCqlZ9IBP66XFJvsaksoA+s2oM7f5rhxrjw2AHl9Ptuc8dspZThQqHfqwpHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORlmBkSk7775h/o2KCM2Z5+X1WJ/xW4Do0g0uAjZfug=;
 b=djQGvC0zGIxfVxiG/AHsIwhmNhKm988zsCxIiVf7+9H0XW0Xa/DscrEemYnhIGzu8TNd/9pmn1os7Auxnghp5i2vjCR9ZtHd6u+CFXR+BL2F2LoT0QwxfB/Y5KZBO58zRee/DKfoytHWMih6eqPefKjUvRCCcvftV38Ec8OUnn9JAZvsd2m3h6SAnV7zpGCRJ0hRWA6wXH/t4Eg/OPYIc0tjvY11z5qTezeqdtMbNV4HS5TasvC2MDpoxsI7KNm8bqQXifBX2XsZ1guH/tBa6J1pVp9QwjUA8d8N2QKm1L5YcJpWg9JSyUdhEFnca2v8SL9kVSnCy1VsUpPXhewy1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <biju.das.au@gmail.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 0/5] Add RZ/G3L RSCI support
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 0/5] Add RZ/G3L RSCI support
Thread-Index: AQHdYirsV8NRckXVlUWhip11ezb8vrcJ/DmAgAENlRA=
Date: Fri, 23 Oct 2026 12:08:42 +0000
X-TSB-HOP2: ON
Message-ID: <TY7PR01MB148186B8C06F49B31B84D9366CD642@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20261022134021.217964-1-biju.das.au@gmail.com>
 <atpr2xe3h0fPVx3X@duo.ucw.cz>
In-Reply-To: <atpr2xe3h0fPVx3X@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY4PR01MB14719:EE_
x-ms-office365-filtering-correlation-id: 9418cc8b-4de5-4695-bb72-08df30fe61cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|38070700021|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|261022105027099003;
x-microsoft-antispam-message-info: KMqSNrS+Nj7bKcAMz2roVfO5W9jf5Zq8J5NvVJKTNEPR8jZ310Iq6vBHD+k+gxJAhGVHAFmvPV57EMAUoqcXs7UMQdQceaxthYrGFDsz3cbAZTiLVoG5/PJTGvhAKrHCoaYXAstO40HR92PWfVWHrRyObLyaL1vLY1FpNfDpbqPFbGLTkdqQB2rZof02WoxRquoq0qtZ94re9WLBlaxkCohTjUeseP7zrS3ZqLLjo8XIKo7td6euAjcSu0LpEJhg0+ll+PxjBOvcwpwg9/K+NERvJtYnrCnBQwKmHx/tVtObihhZ2fdTrfFmaJKk5bYpKxI4bKedlBP9mgBxkecYr/gYoS/4y1Pqm0Q4sHjBGClFcu4gmX8BZBU1/bUtqHNbTRtibK7j3jaSh3tqzykUas/lVM1JfjkMbWMALFQukRnTpVDkeLq1cYJv1FD+leVm+rUU45cnCKwTByevZHWflrBI6JTe7iJEaFIrHAuAf7wxiaycFw7nroDzIJ7+9sB4uj/qMMOZ3kAM2oRp4GjU1f3nOmqOsEiADCD69Z/cZv8cX+1pFAWoV2bXB/EoIdDGqJ3G/H4/rb92kXxOkumgFTtdvpBvd5OPwKDE5cFPeNjVQUc79dgzbChbFmGto/DqwybveQ1Fv8ZU0/RPMxec5ViF4Tu2GT67T2stgkxoAOenuJB+/vGemRe/w7cRqUZVxts6iM4ocTKoBGafOExYcGdn+tBMuEGOQg9bXp+zVPE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(261022105027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?K1NPcUhjN0pEOWtiajBJU0Q3NmpKdHhkeWdhZnRGa1hqT09TNEF1WXEr?=
 =?iso-2022-jp?B?ckZPd2NLL2hxTXVaRWdhRWRSek1iSEhuQmVrYTBHcVMzN3VsNUp6Qzhl?=
 =?iso-2022-jp?B?dlB5M2NNdGVZQ3NaV2RUbmNWRzY1aGRiV1RIalBCZy8xRWQwMDVtN1hM?=
 =?iso-2022-jp?B?em15a1VXZGlhTHA1ekxLK2h3WlB3b09BdG9OcDJWdlp4WXQ4M3ByUGVz?=
 =?iso-2022-jp?B?ZUM3WG91Y2FxZjZVUjVqQkFoSXVCQm9QbTQ2VitQRjI2Q0NJSTZCL2hB?=
 =?iso-2022-jp?B?OE5PSGMzbkZ6eXdFNzJoUlJ6ZXczN284aW1YSnU2cldMMmh0K2M1UUpy?=
 =?iso-2022-jp?B?QThwZXlmS2l1dHQ5RENUdGE1dHM3TXJ0aWRxTkJkcFloRHhqY2xYVFJ6?=
 =?iso-2022-jp?B?Mm1seDlUUHd3QTFDVlBMbW5pY1VVVkJjNmJXcmgzbnBFOE51WVZTYlJs?=
 =?iso-2022-jp?B?L1czQ203STl3ZHVqekFWQzFRT3VqUGYxc1AyZHcrWVlOMVF5TFkvS2NQ?=
 =?iso-2022-jp?B?Z3lzeG1UeTR0TVdIVHVsaFFSVDdMNkpwKzhrV3cxeDl6VmxHWlJ2cjQ5?=
 =?iso-2022-jp?B?dTNCWDd6VEpNUGFqamFjakwrRm1mOUxSRzQ2R2ZIaXpLWlUrb1JCSHor?=
 =?iso-2022-jp?B?V1cwbDZncG9sTlVtL21FYnhoNDJpOTAxNGN6cnlMN1hXRVNDUGhqNUFP?=
 =?iso-2022-jp?B?Ni9uanpoZmFBZTdtN2ROdEV3bHZ5cnhaQkJwOEdBWk9RTVZKY3FqV0xL?=
 =?iso-2022-jp?B?TkJtd2tsZkxBQ2NZVmZhL3QvK0RWcWtKd3NjZTdGbGpuWTBOWlAwcUx2?=
 =?iso-2022-jp?B?bkxvRFA0U29oWG5jS25rd0k0Tkg3VVJhQ2lGWCtlNklhZFNIYk1oQ08r?=
 =?iso-2022-jp?B?WENPZ3d1RnAxOUFrQk9pKzg2OHBPNis2dXcvb1g4VjRUM1MwV1JXYUNE?=
 =?iso-2022-jp?B?cEFUSXRrWFArTDA1cHRvNGNSNC9hM2M0MU0xRHg0dDBvVHhkOTU5MklK?=
 =?iso-2022-jp?B?a1hNWTRtZ1NDOGFCNksyZzR5allRNUE5WEhwVExZSFo2QjZ3RHZ1Q1F0?=
 =?iso-2022-jp?B?UDdiUEFvZzMrWW9xSXdjaVFsa2piVWxHbU84eDNqNWZldktPR2JtMGF2?=
 =?iso-2022-jp?B?TTVQUTBoUlR6amF1YUtLL3YrenM3WldpTTZNNXc3UkhqdkcyYVZCMXdW?=
 =?iso-2022-jp?B?dmxaRmpKeTd5SzNTSGJyNytPd1FETWxEUlhxR0VEVGxHdEx3RGpDRHQ5?=
 =?iso-2022-jp?B?Uyt0eHlMcENQZFUrWXZ1c1F0d0ZEVE12cFg0MHo1UHFjSmVtb2xtUmdl?=
 =?iso-2022-jp?B?dVZsSy9JR3VFdVRiNnVRMHBmdGp6eU9mYnkvZHJVdnoxV0hsZjhlVWs4?=
 =?iso-2022-jp?B?Qllab05TYzFuNk4yRkhGemV2UHBPSlY3Q0JaYmgxRldnUHh5eHBYZUth?=
 =?iso-2022-jp?B?Q0wvcVRReWlyMmRGN2dVWWtFbjNNSGRoQjFpYjlUemlaaEZqQlZRNEUr?=
 =?iso-2022-jp?B?Z0JIWG5QK2FWeTNEc0VpcWJDQmVaOXUxR2FzVGR2NFdVM2NjZW81WWtR?=
 =?iso-2022-jp?B?dFAwK1Y0RlJieWZuMWpvc0ExcjNYUE9NUzN5eTd3MXpPRyttcGwzMUFj?=
 =?iso-2022-jp?B?OWY3R2hZVEtVS0lvUFllVis4VDlsSExpRDZjZ0pqckNacDczSUEwdTdT?=
 =?iso-2022-jp?B?eW95SjdLb3JsZmQ2RUxOOUQ2RFBCK3Nvb056VVk5clRSUTlLa3RsYXYz?=
 =?iso-2022-jp?B?RHBrQXlxQnl6SisvYXdJdjdrcWRGSjBrQlZKb05VM3VWU3BvNlVwT1FH?=
 =?iso-2022-jp?B?RGFtMnlzcG9zeldPMDNpRTdaMWxLZ1M5YkpOSW1FVGNNS3lDWmNQUmZy?=
 =?iso-2022-jp?B?cTNUbExTMUFibklVcVkzbkxYS1BKMHNwbm50eHpjS0lCQmIrb0pZK0M2?=
 =?iso-2022-jp?B?ZkxPRm5kTFBrK0hqQ3A4a3oxUGUwNGM1MEVMV0UrYnVyM01QUVRUL1Bt?=
 =?iso-2022-jp?B?blBhVHBFeGUzS29WSUZDVWdvSi9GUjBSVDdld3VWMzB0ZTU4NTlkRXVH?=
 =?iso-2022-jp?B?dWRTcmFqOXhiWXF0MzdaZFVWbWordVRvZDBUYUQrRjlueGVGcHR3QkdQ?=
 =?iso-2022-jp?B?SGlFajVGYjloTnJGUVNtNzFnaUo2cFFlVmlQZ3NkZDlqbmJkRTlxbVNi?=
 =?iso-2022-jp?B?aENSMnE3YTRtR1BrdW55bDhBaTY3RFZoZnJnTW9oQ2R4OWpydlpoQTVx?=
 =?iso-2022-jp?B?OUVSUFpoMVRQcW1pdjB3RHJDWHRHdG9SbzJRN1RlZTFWZXMwVGhZMDJQ?=
 =?iso-2022-jp?B?ZVFHaDMxUFU1cEttaFd0V1hjVUhoSDR1aFlWWk14b09GZXVIaDgyM29z?=
 =?iso-2022-jp?B?Q2hOcWRpVFhhK2hzRGFpZjJ5dkRpMnBLTG4reE5NeU9SaTZTd0xpYi9q?=
 =?iso-2022-jp?B?bEN2RzVBYUhlSnY2SjViTGwvckFDakJidGw0emRWZC9LakRxdXZWK3RK?=
 =?iso-2022-jp?B?ZHhTQlMwZjFTOFhCenlnSThWUEhXY05BaEZpNml5SUpYZHQ2S0dCWVlQ?=
 =?iso-2022-jp?B?cG5sSTRhaz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FJ+EJhLxn1eAQ0+UIB/H3SCUimp+hEuea7N34XDcSGQmF6AJg8rhGPXOHB8mSy7mzeBUlpwsrhfCjvojSlEaHNVzsa9jAEP3EjgvDgz5jxNI0ZKtClDxLgXOMeKOiTRg26en2yzhjPPYIFqUuvby6WUfSS33998T07ZjjnQyM55QvKgg+zDWhldWxqYxmn9uk4+ZIfI7ZIhYQTSHcsi9Dnt94VyaFqckeawMKaD1yc60dQKbR+GW8k9dbpECzfonFiraGF+bkYd5HXymCb9Ga75I2P4QfjZJYaZEy0gug2BmUYLyrShhlNo3NxZET6Nx2TAhkR/P0kgxovvIWECTPw==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9418cc8b-4de5-4695-bb72-08df30fe61cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 12:08:42.9845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KBI+fj2RpGxkR8AWHD8u44+fxyIKQTo3WQ2IwQRvwBHQXI5jJzBiBo8i/F5flezv/YdVjte2CAy3I7euEDlt7wFsn02PldhXDjAtD64EJ8zb62cxEwTQFPUlDux+OSVR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14719
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 23 Oct 2026 12:09:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24519

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: Friday, October 23, 2026 5:03 AM
> To: Biju Das <biju.das.au@gmail.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek
> <pavel@nabladev.com>; Biju Das <biju.das.jz@bp.renesas.com>; Lad
> Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/5] Add RZ/G3L RSCI support
>=20
> Hi!
>=20
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > This patch series aims to enable RSCI support on RZ/G3L SMARC EVK.
> > All the patches in this series are cherry-picked from mainline.
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.

I reviewed this series, looks good to me too.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro

