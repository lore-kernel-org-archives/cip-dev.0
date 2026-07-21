Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B0DC44512
	for <webhook@archiver.kernel.org>; Wed, 22 Jul 2026 03:32:18 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18737.1784626372946272796
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Jul 2026 02:32:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=shivanand.kunijadar.v45@mail.toshiba header.s=key2.smx header.b=P96+TUJD;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: shivanand.kunijadar.v45@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=shivanand.kunijadar.v45@mail.toshiba
	;s=key2.smx;t=1784626370;x=1785835970;bh=+nD5ghZuEZfSbtm/++E8VsSjBvWNsplcwfRD
	GOUo5lI=;b=P96+TUJDsbl31M/RHdcBulrN3aWll4XA7WCCJXqlKHc7cJc33mZaZ8+jSoq15ckIg2
	FGDTqGLtBQHp3D1Gy/6KtEAD26qoltNanP1tH9C2Zp2tsTTBegNz7+RFUQdc+mH8Lbp9XYqpUkelG
	2q+xrYkSzI4IeIFLL+PckRXjNhjUw3DPQAS2fyKgJDinNJrXDtvDWqFRijJSL4bBIJftBFB+pIME5
	GfT8HFWTfJGT3bRVRlWv9umei4hCf6xSBMhWMr+yRVwugQCqHhu72iuxPHq3z6lR+pJMKFGyJo2gm
	EdXwdmBc7iwpo0x08igOa12i17fp3XroA2Oq0feSozO4w==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 66L9WobC2347010; Tue, 21 Jul 2026 18:32:50 +0900
X-Iguazu-Qid: 2rWhJyGIBmtf2uR5aD
X-Iguazu-QSIG: v=2; s=1; t=1784626370; q=2rWhJyGIBmtf2uR5aD; m=l7YPjd419soWpFRnILRMUhDCutYO5AlArjvUXBWy03k=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4h4Bxs6DQZz1xnj; Tue, 21 Jul 2026 18:32:49 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1w+biUJoAP8I17XrCjXSmRsoLw91gSj4c9Hn2xL3GP8h2OO6JICZ8iSETok6RJ+u42tCVpOH+38sP946pwu4b9B70aDgS6RWdx0J/P6tjFN8GUWmNFbZMYKCLWjJAg2ldC67B+rOc0uAxXpHSK+dBPP+GCO/fbMLXmrmstAoW/SPFrkXAN2GBT/SOSX/IMfAfB6uPc8gW18vQjxV7rCE6xoOE9WyW2jdl0Mp5dG832F4sUO2hMUhsW0A07bpohDRgLGuTnuS2a0tf8Zpp7ce3ZDTfM3pfdqAGRt3J2C0Bz3BUvHK5+ZbrU5n/sCaoELg0rxbO6B1bj4M6Y71XJb7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+nD5ghZuEZfSbtm/++E8VsSjBvWNsplcwfRDGOUo5lI=;
 b=e6h8WdYW8STDcSRonNxaqc82iftOY5UV++Kc5ImZVbgH4qSF3jrPV30wPKUjLM15DL1PUsMGurMYfphrxg1rFafpNb1AVX7BV/Af+iSQ6Zp1+8jJtaMO4emqiGuNX7z01kU58yTtmoEBFFNPfPyHIhndmDqDW7dWwEmjCaGg68FICPp9VG6fgTdYf89MgsMybRCOxK2J/E5y8W1eA3A/I8VkFdtx/aplFV36bGXOuftsL2qkvuv4srMunyGXhV8lEWJnWfStR6V6fiM2rWpQc5dapkxSze14vnw0HN1w/aIkHSdZQBWH3vL+k98o5DCARuWxcUTdkV0iG/4C1JAxOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <shivanand.kunijadar.v45@mail.toshiba>
To: <quirin.gylstorff@siemens.com>, <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [isar-cip-core][PATCH v1 2/2] swupdate.cfg.tmpl: Add digest-provider option for signature verification
Thread-Topic: [cip-dev] [isar-cip-core][PATCH v1 2/2] swupdate.cfg.tmpl: Add
 digest-provider option for signature verification
Thread-Index: AQHdGAZYxu2eduKIlEC+RK6rRtM+6LZ2D9mAgAGnTCA=
Date: Tue, 21 Jul 2026 09:32:47 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB11063C941B71891D499DF5477C5C22@TYWPR01MB11063.jpnprd01.prod.outlook.com>
References: <20260720045903.733394-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <20260720045903.733394-3-Shivanand.Kunijadar@toshiba-tsip.com>
 <12faad9e-1d54-4c30-87cb-2279652ff72d@siemens.com>
In-Reply-To: <12faad9e-1d54-4c30-87cb-2279652ff72d@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11063:EE_|OS3PR01MB6659:EE_
x-ms-office365-filtering-correlation-id: e0fd5624-d0fc-4289-ed31-08dee70b0698
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|38070700021|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 
 ngjExLhEgM7fasUmhmsBhqwsTVgBGXA6f+PtHIzidjMUjfkVvwcYXgw2bU0Ez53HK5IUXWd0DQVzpwLhL/bU9yN4tcYws/9TOHn7NBa9BsQ1A66UerUghqbBqbkfWHA/iiNmMDyPK3CIoTX+svb3ChsATy2oSgdFtEiT6Q1mNZlCFpwk/MgiOIaM0OUdQNLFDoadW8rX/MsCAFKAlhA56X04crbrZVPWmRK0sD/6/59ZV21u5SG1rrFBcTo0yhVswzbvcrg0N9fJbwMsN0OnTVhi4ZkrfIvtqjpdL5tMfuLrIP/1rXFBthEQQMcUoGALxhqJPNTg56EHzLwGWENzTtDymTi8Xdhh8Hph68Qq1s3E8GRTPtb4rC8CLdtlXvmOcqZX4KZecLKu5Zytkmk+o2JTcg/MEjYVmm03rJd4iYuGPw70V2y6yK6nhzQxDXCvAcHv/ctZmtADokqhveCDlE5ovMZs9m+HOR0gbfXHjUvpc6mQFuC9q8r7UbCtressisFLEt8SI1qBVRt6o/hQLKCuWRflqeN+R+mnIBjIVJtrKkVCWm37Y+2021d5qSzQ1F5UlJBdmKb/lFI3zfGMA6xXAy93Ae0Y2/MYyuCngMv1dQ+mRwzNchTRFDEPrfXbA3bxJCBaRMIqNDDKsoKoaURtAJAmfEs546dBlkebtffV2IY9eD5cOwUem6XmCU4pT/i/iKhSqXgZiahTphk2FBAqCRgVb6OSZElM5D/YqtY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11063.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ME1QZlJCcElxdU9vcCtnK2RiZjVmRElRWTF5TFhvcTJVVUhuL1h3b21hRGk0?=
 =?utf-8?B?SER6UU5hRFhRaTd2RWpzN2lpOUw4c1RGelZ5V1RMVllubGlqUFZnV0lxR09S?=
 =?utf-8?B?SGJmYlpxaU9hSXh2bWxnSUc4dFBSM3dLQzYvSWVDUkI2bTJYeE1HNjdURXF0?=
 =?utf-8?B?QUdQRGc1V21BU2xNTXJwY1ZZb1NKWXhMSWVPa2JDSis1NHVDV0kzQ0xXTzNK?=
 =?utf-8?B?aktBa3BaSGtCU2RWRTlsZzg4QVpZSUd5RFRyYW9wKzB4R0lPZ2c1VHZKVjlM?=
 =?utf-8?B?VkNKQTlaS1V3emQ5eVZGeTREWHNUc3ByRmxWV0djQ2tLWkVkS2VKb3F1bEZo?=
 =?utf-8?B?ekM1MUExZ1FWT25nQ3IrZUhWOUNJSWhwY1AyWVcyRHZ0d2FBZ2UrNjhaMlAr?=
 =?utf-8?B?REFMRDNMK0s0QjFZQjhQWWR3cTV0U0YzWFM5TkYxazhEczNkTmc0RE9nLzBG?=
 =?utf-8?B?RTVlK0ZKZFlsQit2Q0pyQ1FwdjlrV0luc0x6S0Q0U0NLRFVOWWEvUTdkOURT?=
 =?utf-8?B?TXVUdG1lQW9pR3B0REpMM1ArcTVpTTU0WUczMElaTDR0azhwQ3pVaE14aVQ5?=
 =?utf-8?B?ZU4vT0ZTTUFJUVpuaml1empVU2wrU3BOUklrbVJEYTd4Y1NtanBjM1VKQjl4?=
 =?utf-8?B?SHo4aHBJRWFLaTA4aHVqcXUyeVlDdGhHY3YySC9hOUZCUU5Ycy8wMks5ZVFp?=
 =?utf-8?B?RVZkaHZmdlFKam9qVy9sdWNpcDVocnZnRmFFRXVxeHN1UkZrZk1jSjFGd0c3?=
 =?utf-8?B?MTlZN0sxNUNIZFdLUjRFZ1RLSVNtZS9LQlA0Y0ZXa0h0UmswMU4wOFlPQkEy?=
 =?utf-8?B?T2s2R2xEVlBPczhBbERXMlY2TEI0dEo4UENRSEZtNjN1dlhsRWRWVWZmOVZl?=
 =?utf-8?B?NzFUQVpRNzQ3QkxJVWkwempZQ2ovY0J5eHM5N2xta3FJMFpOT21EZlVHN0Y5?=
 =?utf-8?B?R2JKc0ZIYkptalEyekkrYXNLNzlQYklMbitnbnBJK2JoVkVFWHhKUmd2alc2?=
 =?utf-8?B?Y1lkbk82eTZDbFIxeFBDcEpDVVNDSWI2Y0dZbmswNWljVElCZHZMYmZDSG8y?=
 =?utf-8?B?K1JSVFArTzFEVjhEeUNpYXNkWGVIWmQydG1FNVcyZ0Nib0tYZTRUT00vMlR0?=
 =?utf-8?B?UmVWeGxwZDlWTUliK0o2ZkUzYm5PS3dkeXF4NUc1a093Zm5Mbk9WRFZXMElH?=
 =?utf-8?B?SXVYZnVKRjBMbTVYb2YyTk1HZ294dGRRN1NMNFVzSlJOcjZhdkd6TENxQk1a?=
 =?utf-8?B?YjRPdldrSVN0eUFFdGdxRzZjeU9lTDdmN2x0QTgvb0tHQWxJeEZYc3ZHNU0z?=
 =?utf-8?B?VjQwZGViMTNNT05OUzhVVlEyblZhbEpMY0Q1ZHV0N3FlTGRXWTc3K0NOU2tu?=
 =?utf-8?B?MWFmZERVV0toZHc1Yllwb0VFRGc2N0lndUZ6anV0RWEwQzRCVjlxcWxqdFdU?=
 =?utf-8?B?ZU0zaWtGYmE4L1RCaGpQMU5GV0NrYjFubmJ5WmFZbm00bXJ6d2h0R3Q4enht?=
 =?utf-8?B?OW9KcEZMSk1MVnluRWs2YzBMWi8yWGZROGpEeWlSNE9XRjE4L3Bja2JTQnFZ?=
 =?utf-8?B?d2Q2ViswOTNiNVZVVHpham9oMXRNT3o3czY5aXpuUlh6UElmZCtxSVRsQk9z?=
 =?utf-8?B?Vzg0S3hrTHAzaXZ2L0d2NjhqOUZ5OWFkM3lLNGgzU3BoaHJYUTJ2dkZhTnhr?=
 =?utf-8?B?bmhjdHgyc2JaVmowKzg5cEc4T014WTVxVjJsRUpianJtSWlrYmc4Si94TUp2?=
 =?utf-8?B?RkJEQzBhSkpIc0dyTnFFVUhHYTkyTi9WdVBZU3c2QUdPekpxcHU5VkVyaStL?=
 =?utf-8?B?S1VnUmQ3L1ZmVkNNeEloMHlsK0FzY0NtaUl0RjZNeHM5eFNzU2VBOVMyWWlO?=
 =?utf-8?B?SWZtSjllZGxSdHF0NUNqaXROZkNYbVA1T25GbGtMSTZHbDR2cEEzOTBzYUJv?=
 =?utf-8?B?WmllbVpwNThKNEpQaWE4dUdJRW9rdEp6Zm5kSW1jQlowOXZrVUsxL2dXL3g5?=
 =?utf-8?B?a3Q1Q2RuUTZKdkxTdHlwdC8wdUlRYmJtMWk3UGZWbmJwMEdqUFVZcXQrTzVa?=
 =?utf-8?B?QUh5dk55ZzJpNFpZbEh0NnB4SkMvMjFOalJPYmFtdFBITTA1MDZwSStVa2o4?=
 =?utf-8?B?OXM0VkZHbXZ6OWFmdEdoTmtnQnZFNFBpeHcyL2xqZXNqbWlEbnBQL3p6cTFs?=
 =?utf-8?B?WGxvZVhBdVBlOWlkeTVDbVFZUVZBQTJHYlUyZEFJNlNHejdXWHk2ZnRQY0pN?=
 =?utf-8?B?cEpFbThEOFAxVjhaaDAzTGJ0MEE3QmRtRjlqY2lsTzhNM3l1L3JzOXpEWmoz?=
 =?utf-8?B?SjgwUWtrY0I0a0dkMExFRkdzK0tFOGpkQUtVODhiQUMrZ2tuY1ZwdStKRi9a?=
 =?utf-8?Q?pKAoTCh3NBqT4BSE=3D?=
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	d6QMuQnyzrVil7Wv6dtZvKg6UvcnqAOm9+Z7QiSUdtGgU8S1RM3MX/8tUhmAegOJtnUOM1WuqaRH65JvQLRRLqSEALk0t0b9aktHUwLGKIiVeeSqBZoGeonh46B2y9KKR90ii4Ek2U2UBV26+VzJt1ftvAPw7S3d67Ab7dcmc02o1aO6Nx6Ze0DbekHziNJa+hDIWfKVRY/5JbQITQ/G/Gyedizd6oT7bqxPd9+AdCy/eZc5IT2w3KophLU6zkSRG1KPrk88nENbKxNM6o4d5MTr185sTLrmvcfB8NLEzQbfRCysGeNVv6LlAuNbHqT4S7AJLhGPHPdtf36Rl0dOQQ==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11063.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0fd5624-d0fc-4289-ed31-08dee70b0698
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 09:32:47.3834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ariNYQ+2fTAziIYJd45KAAo/PWc/jVUzx7NL8ISpyzZ1+kAXu8103FX9titig6aTGJpN6i6a1cNcfdgr5XrAdT6+ZpMexjnTrvm5WSm9PeM9vBiLHC3Xj21YS2gZGApa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6659
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jul 2026 03:32:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23703

SGkgUXVpcmluLCANCg0KVGhhbmsgeW91IGZvciB0aGUgcmV2aWV3LiANCg0KPiBJdCB3b3VsZCBi
ZSBiZXR0ZXIgdG8gcGluIHRoZSB2ZXJzaW9uIGZvciB0aGUgcHJldmlvdXMgdmVyc2lvbnMgaW5z
dGVhZCBvZiBzaWQuDQoNCkRvZXMgdGhpcyBtZWFuIGtlZXAgU1dVUERBVEVfRElHRVNUX1BST1ZJ
REVSID0gImRpZ2VzdC1wcm92aWRlciA9ICJwa2NzIzdtYmVkdGxzIjsiICBhbmQgYWRkIHZlcnNp
b24gc3BlY2lmaWMgdmFyaWFibGVzIGxpa2UgYmVsb3c/IFBsZWFzZSBjb25maXJtLiANCiANClNX
VVBEQVRFX0xVQV9WRVJTSU9OOnRyaXhpZSA9ICIiDQpTV1VQREFURV9MVUFfVkVSU0lPTjpib29r
d29ybSA9ICIiDQpTV1VQREFURV9ESUdFU1RfUFJPVklERVI6YnVsbHNleWUgPSIiDQpTV1VQREFU
RV9ESUdFU1RfUFJPVklERVI6YnVzdGVyID0gIiINCg0KVGhhbmtzICYgcmVnYXJkcw0KU2hpdmFu
YW5kIEsNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGNpcC1kZXZAbGlzdHMu
Y2lwLXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24gQmVoYWxm
IE9mIFF1aXJpbiBHeWxzdG9yZmYgdmlhIGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KU2VudDogMjAg
SnVseSAyMDI2IDEzOjQ2DQpUbzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNClN1Ympl
Y3Q6IFJlOiBbY2lwLWRldl0gW2lzYXItY2lwLWNvcmVdW1BBVENIIHYxIDIvMl0gc3d1cGRhdGUu
Y2ZnLnRtcGw6IEFkZCBkaWdlc3QtcHJvdmlkZXIgb3B0aW9uIGZvciBzaWduYXR1cmUgdmVyaWZp
Y2F0aW9uDQoNCg0KDQpPbiA3LzIwLzI2IDY6NTkgQU0sIEt1bmlqYWRhciBTaGl2YW5hbmQgd3Jv
dGU6DQo+IEZyb206IFNoaXZhbmFuZCBLdW5pamFkYXIgPFNoaXZhbmFuZC5LdW5pamFkYXJAdG9z
aGliYS10c2lwLmNvbT4NCj4gDQo+IFRoaXMgb3B0aW9uIGlzIGludHJvZHVjZWQgZnJvbSB2MjAy
NS4xMiBvbndhcmRzIGluIHRoZSBTV1VwZGF0ZSBwYWNrYWdlLg0KPiBJdCBzZXRzIHRoZSBjcnlw
dG8gYmFja2VuZCAobWJlZFRMUykgdGhhdCB0aGUgU1dVcGRhdGUgdXNlcyB0byB2ZXJpZnkgDQo+
IHNpZ25lZCB1cGRhdGVzIGFuZCBjb21wdXRlIGRpZ2VzdHMgd2hlbiBtdWx0aXBsZSBwcm92aWRl
cyBhcmUgYXZhaWxhYmxlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2hpdmFuYW5kIEt1bmlqYWRh
ciANCj4gPFNoaXZhbmFuZC5LdW5pamFkYXJAdG9zaGliYS10c2lwLmNvbT4NCj4gLS0tDQo+ICAg
Li4uL2ZpbGVzL3tzd3VwZGF0ZS5jZmcgPT4gc3d1cGRhdGUuY2ZnLnRtcGx9ICAgICAgICAgICAg
IHwgMSArDQo+ICAgcmVjaXBlcy1jb3JlL3N3dXBkYXRlLWNvbmZpZy9zd3VwZGF0ZS1jb25maWdf
MC4yLmJiICAgICAgIHwgOCArKysrKy0tLQ0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiAgIHJlbmFtZSByZWNpcGVzLWNvcmUvc3d1cGRhdGUt
Y29uZmlnL2ZpbGVzL3tzd3VwZGF0ZS5jZmcgPT4gDQo+IHN3dXBkYXRlLmNmZy50bXBsfSAoNzcl
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL3JlY2lwZXMtY29yZS9zd3VwZGF0ZS1jb25maWcvZmlsZXMv
c3d1cGRhdGUuY2ZnIA0KPiBiL3JlY2lwZXMtY29yZS9zd3VwZGF0ZS1jb25maWcvZmlsZXMvc3d1
cGRhdGUuY2ZnLnRtcGwNCj4gc2ltaWxhcml0eSBpbmRleCA3NyUNCj4gcmVuYW1lIGZyb20gcmVj
aXBlcy1jb3JlL3N3dXBkYXRlLWNvbmZpZy9maWxlcy9zd3VwZGF0ZS5jZmcNCj4gcmVuYW1lIHRv
IHJlY2lwZXMtY29yZS9zd3VwZGF0ZS1jb25maWcvZmlsZXMvc3d1cGRhdGUuY2ZnLnRtcGwNCj4g
aW5kZXggM2UyYjQ1Yy4uNDRkOGQwNCAxMDA2NDQNCj4gLS0tIGEvcmVjaXBlcy1jb3JlL3N3dXBk
YXRlLWNvbmZpZy9maWxlcy9zd3VwZGF0ZS5jZmcNCj4gKysrIGIvcmVjaXBlcy1jb3JlL3N3dXBk
YXRlLWNvbmZpZy9maWxlcy9zd3VwZGF0ZS5jZmcudG1wbA0KPiBAQCAtMiw0ICsyLDUgQEAgZ2xv
YmFscyA6DQo+ICAgew0KPiAgICAgICBib290bG9hZGVyID0gImViZyI7DQo+ICAgICAgIHB1Ymxp
Yy1rZXktZmlsZSA9ICIvdXNyL3NoYXJlL3N3dXBkYXRlLXNpZ25pbmcvc3d1cGRhdGUtc2lnbi5j
cnQiDQpoZXJlIGlzIHNlbWljb2xvbiBtaXNzaW5nLg0KPiArICAgICR7U1dVUERBVEVfRElHRVNU
X1BST1ZJREVSfQ0KPiAgIH07DQo+IGRpZmYgLS1naXQgYS9yZWNpcGVzLWNvcmUvc3d1cGRhdGUt
Y29uZmlnL3N3dXBkYXRlLWNvbmZpZ18wLjIuYmIgDQo+IGIvcmVjaXBlcy1jb3JlL3N3dXBkYXRl
LWNvbmZpZy9zd3VwZGF0ZS1jb25maWdfMC4yLmJiDQo+IGluZGV4IGI0OGUzZDEuLjU4NDcwNmMg
MTAwNjQ0DQo+IC0tLSBhL3JlY2lwZXMtY29yZS9zd3VwZGF0ZS1jb25maWcvc3d1cGRhdGUtY29u
ZmlnXzAuMi5iYg0KPiArKysgYi9yZWNpcGVzLWNvcmUvc3d1cGRhdGUtY29uZmlnL3N3dXBkYXRl
LWNvbmZpZ18wLjIuYmINCj4gQEAgLTE5LDEyICsxOSwxNCBAQCBERUJJQU5fUFJPVklERVMgOj0g
IiR7UE59Ig0KPiAgIA0KPiAgIFBOIC49ICItJHtNQUNISU5FfSINCj4gICANCj4gLVNSQ19VUkkg
PSAiZmlsZTovL3N3dXBkYXRlLmNmZyBcDQo+ICtTUkNfVVJJID0gImZpbGU6Ly9zd3VwZGF0ZS5j
ZmcudG1wbCBcDQo+ICAgICAgICAgICAgICBmaWxlOi8vaHdyZXZpc2lvbi50bXBsIg0KPiAgIA0K
PiArU1dVUERBVEVfRElHRVNUX1BST1ZJREVSID8/PSAiIg0KPiArU1dVUERBVEVfRElHRVNUX1BS
T1ZJREVSOnNpZCA9ICJkaWdlc3QtcHJvdmlkZXIgPSAicGtjcyM3bWJlZHRscyI7Ig0KDQpJdCB3
b3VsZCBiZSBiZXR0ZXIgdG8gcGluIHRoZSB2ZXJzaW9uIGZvciB0aGUgcHJldmlvdXMgdmVyc2lv
bnMgaW5zdGVhZCBvZiBzaWQuDQoNClF1aXJpbg0KDQo+ICAgTUFDSElORV9IV19WRVJTSU9OID8/
PSAiY2lwLWNvcmUtMS4wIg0KPiAtVEVNUExBVEVfRklMRVMgKz0gImh3cmV2aXNpb24udG1wbCIN
Cj4gLVRFTVBMQVRFX1ZBUlMgKz0gIk1BQ0hJTkUgTUFDSElORV9IV19WRVJTSU9OIg0KPiArVEVN
UExBVEVfRklMRVMgKz0gImh3cmV2aXNpb24udG1wbCBzd3VwZGF0ZS5jZmcudG1wbCINCj4gK1RF
TVBMQVRFX1ZBUlMgKz0gIk1BQ0hJTkUgTUFDSElORV9IV19WRVJTSU9OIFNXVVBEQVRFX0RJR0VT
VF9QUk9WSURFUiINCj4gICANCj4gICBkb19pbnN0YWxsW2NsZWFuZGlyc10gPSAiJHtEfS9ldGMv
Ig0KPiAgIGRvX2luc3RhbGwoKSB7DQo+IA0KPiANCj4gDQo+IA0KPiANCg0K


