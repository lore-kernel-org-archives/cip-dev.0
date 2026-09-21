Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD91C982E1
	for <webhook@archiver.kernel.org>; Mon, 21 Sep 2026 08:07:32 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.10])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44264.1789978044770495659
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Sep 2026 01:07:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Fb89F0Dn;
 spf=pass (domain: siemens.com, ip: 40.107.159.10, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bvl1YjD0eQ6+ETlcbd9qL48wtSf0wca0SRnsxq9OkzssZz9iu/xboUmJARPQXaOGPI+NuDBqV726uAhjs3Y1bWTvVlXGd5UB0f57H3CAdOuTh/uhYxA8lH4HV1iN0MvW7wDWWblit5HzVLQxnEvo0tNMC+dZjtYHDZC6wx243BoPfpdWwgZPc1dClDSrFh2DGpjAsQqRczfthjlI9ICW/15xuQPD2oxhtVC1ATFUvNtuou8YvqYK+rdNbTJR6v81h/Rw7V6LXJtDib8XVOKJVEibL5EnqnopWlTjfRWp0bGBWBpYZP3fHyHnMQUyhPYHB0ccvNZTh5RBLczuOTXmSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NpfnGDEUNU7CMHt8VLjx1diIiT8JvuLKg+0FvE092t4=;
 b=QXqe+DbMcY3KT8nV2KTKrf7N0RcTuYGcgk1rocGA8/c+EXkYfyE7HenAYDSFeO17mFz/h6BLb/D2PiPU4F6ndjWOb9R2Ef/s9VbbXi6sviZ4QgFxS8gPReni+qYF8P0V1bAkVsRKFVx/NjQgkbZsagYlXXyeucpxKxxqbhwvkdCXSgBcx741kKTQpqPxqBokWLqJtijMLiQ8+Q3DIzpvCIaMjuNe6HqI3YVYL4T4s20GuX1GfmzJ28Xf+26g9KgYyiUeQ15ipGqkO3c+i7Zzw7b9K23/zgU5iUVYDgrNiQMmrJjkire2/fVrxBRxqMGgDSGGybHg+Bc7GomdXM2luA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpfnGDEUNU7CMHt8VLjx1diIiT8JvuLKg+0FvE092t4=;
 b=Fb89F0DnPO3ps7PsFyAyeRiFRqQhVMsd6out7HQiLPFAKZtRBo9uzR+iR1qAU2RT4c+uI8TGqvlt3ZDJOn2VGd41CGVf60CK52LLVFZsdHmdc4ybKNElzlMsjHjrTujnl0lM/mF+wXACG1c2SGBBpNM7zi55Tm3MzznA/VF6le+ph8ymKpwlDFjxU2qQnPshWjZV5r/OYMckynHIvb4IxeBgHB6sXu7Z1+PT/n605YaReJHB4afodxhAoEgdFeGna1BDx+vFW3UQlTbU+xEdUHvQWBDgeAma17au4GSFSE5w7jBOjMTkf6Af1peKSYsL1fgPi+RMEdsLCId1P//3xg==
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by GVXPR10MB8726.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 08:07:16 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%3]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 08:07:16 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, Kunijadar Shivanand
	<Shivanand.Kunijadar@toshiba-tsip.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: "kazuhiro.hayashi.f74@mail.toshiba" <kazuhiro.hayashi.f74@mail.toshiba>,
	"kumar.dinesh.h95@mail.toshiba" <kumar.dinesh.h95@mail.toshiba>
Subject: Re: [cip-dev] [isar-cip-core][PATCH] Fix file timestamps are not
 reproducible for EFI certificates
Thread-Topic: [cip-dev] [isar-cip-core][PATCH] Fix file timestamps are not
 reproducible for EFI certificates
Thread-Index: 
 AQHdR0zKDblqapHsykqKMBs5AKB3brbUKW+AgAAB+YCAAAWuAIAEUQ6AgAAnTgCAAANXgIAAAUMAgAABo4CAAAIlAA==
Date: Mon, 21 Sep 2026 08:07:16 +0000
Message-ID: <0fd15951a33172c365dd49862f371b3d6f533ca8.camel@siemens.com>
References: <20260918085031.2464429-1-Shivanand.Kunijadar@toshiba-tsip.com>
	 <88b6f524427c6415422dc6dba589b4cafb4cd439.camel@siemens.com>
	 <868cc7cb-d990-42a9-a759-05f7cfc22e36@siemens.com>
	 <004d186545ac4db6066399ccbc21cfe43a27cd66.camel@siemens.com>
	 <37f91186-518b-400f-a3b1-c61e0207630e@siemens.com>
	 <1b02da51fde7d2c2e71f33473ce6c933335df8fd.camel@siemens.com>
	 <9ac58ab7-f555-443a-b866-6ee083eeb1fe@siemens.com>
	 <639005687857cd59d75b22b7833f47bc68badefb.camel@siemens.com>
	 <545bf5e3-17e4-4092-8278-fbea9b293cb9@siemens.com>
In-Reply-To: <545bf5e3-17e4-4092-8278-fbea9b293cb9@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-10 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3956:EE_|GVXPR10MB8726:EE_
x-ms-office365-filtering-correlation-id: 71bbda3b-c23d-4cea-b375-08df17b75a0f
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|11063799006|56012099006|4143699003|38070700021|10067099003|6133799003|55112099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 
 6JwMEa3TWWl3nP/s1xUIgaogSsJH3aZivmm2g69V5GqKhxef0Xyg4bnhDR85J8EnyAMmH3N80MdxzvEf5f5t4eZTsnqWvJQ245dvOS44Qpdpwc4842NaxedhpnWbbu0D9HMltkqNSwoPcn7JYsgmz1pX179w4lOKyt7YWfZpthd5YUvCjaFdrR+RzZolbvl4uBdP6WIdPwKG8ZJML5nweJJr4iwXivXQ7nkJDJWq2gooIPmPx98lk9qOmefnoBGhz3NQlRpaqig5xAPhcjSJ1fHFIO4DtinmdDccS0DxOTCn8iI/au5jFaxJPEdWeIMLBlMUxK1hfypZ3rxKiMbwhy2GCWdl13OJzCgLaCCVRVB97NUebnzN2brygWE3aGzuNUGnO5uw9siqdp7FCezPZ7JStIIdb50Ke3FCDgAW1AuPZbunPep2jDEpVkd11MU0CgfmfSIyUBhnwtfAhXYxauFq8on+lMaqqjQF+HOX+ltwaT123ky/S0NuDnrRwqECLR3E9g3xM16LRg5HOJTLigWcOAhQVUteDMUpH5pzJ072ok1/pFGDYZlo0gXoBjzzbYL4ykMCw4z5jfzO6dLK6VARuoKHV77uFcl02MRZzZVTfodAq/YjFPJWcPtbT9XjxxTuXqG31cXcoCsasxy9RoIBLGejyRxXQrT4zg7rPaI=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(56012099006)(4143699003)(38070700021)(10067099003)(6133799003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eDZEUGNwNUtzQ0NxMU9KeWk5MUxnV29iWHpKQWJJKzd3Qnc1eVZsMXRCajRS?=
 =?utf-8?B?QXFCQmxyR1loaEY2OEw5Y2JGc0w1Z2Mwdkc0am81aHovVnZZTkpIMjArSkhI?=
 =?utf-8?B?WWxrMWhSZ1BYc1V0STJOOVNqOThQbzZMTTJaYU9UUVlKT3RxRXBRejREQlR1?=
 =?utf-8?B?N2dPdTdBaUdCUlBIaFZRa0xpTmJHMGxrakxRaVNvZUVLWTg2QnlIbVVWMC9V?=
 =?utf-8?B?clFjS01lMVNkeUJEVnN4SUprajUwMGFHSTZCdDRQUXhBZ2hPMTU2b2JxaU5S?=
 =?utf-8?B?WXA5Y0laZVpFeFNsUkRhQ3dQdzBFNXh1RXlWMnJOOHdvWHBjZU1pZUIzV3hL?=
 =?utf-8?B?N0QxOExodkhnUWU5QmlMK1R6b3E1eUEzU05HT2NIMmE1THZqenJHZVcyZTlV?=
 =?utf-8?B?dGQrMVJBUWpyRDIwTkRTT1VPTVV2N3kyY0wrMGprZUhUbzk4bllpYnVjR1cz?=
 =?utf-8?B?dVNYeTkySHlGc0I4SmVaeG1CelVNb01yOWlqM3VMSElFMnlKcWtOVnEvR21V?=
 =?utf-8?B?RW04MURGeVRQYTdDNHEycytub1hjOHZGcWkzSFRyVzJpN1hyVkc3ZU1kcnVV?=
 =?utf-8?B?SlFrdVUxRnptMjFYaUNBTGxyaUJ1N1VFYUhHcnpJRHZBZmxoSHNMYndJbU5m?=
 =?utf-8?B?d3NNUmVlVnpsenpwd05pSFhOaklsUlh1N1dHLzNjLzFpLzJCU3l2MThTN21w?=
 =?utf-8?B?OWdxdjR4KzJScVMyRTMrb2tteVJZMC9mTmphdE4zQ3ZNYmtYcmdZN0dnRkdw?=
 =?utf-8?B?MnVacGNlT0t0bDc4d1Qxc08xcjlCMWFKVTJnQS9ybEJLdHFoaHYrMkhMaXhn?=
 =?utf-8?B?ejdNVUs3dU5ZdFRGb0dOZ1MwbDhBTFlZNXNleCtPS1dYQkV3QTlVaXVEZXYw?=
 =?utf-8?B?SVJ4cDdiUjRNa0JZSHNsemc1alVPU2MvaG5rUFFOZDFnaDY4L1lBM3U2NG1U?=
 =?utf-8?B?UWxXRFF2UUxMTElWUTRLZFZ3V1c5VzlqVGc4SXpWSXNMN0N3ZHRFTGVoTXlL?=
 =?utf-8?B?MmM4Z1lTNWI1WGRiVUJnbFZIQTNpTlpOWW5QeEx2dGlVNWlSbWp6WFN0dkMv?=
 =?utf-8?B?Ykk5Z0llT0VCY2I5V01SM05ZOTJIUVBWb0pCbjBYS2lUWVB4YXZxSDlLQ0h3?=
 =?utf-8?B?UHZBbStaVmJXQUZFU1k0Vk5QNzdiWENvSlhzbnZmYkQ4Sk1Qbm0xYWgwU2NF?=
 =?utf-8?B?dlQ1NkEvTUtTSENFb1c1L2FLa25CQk0yTkRRVDBNVHlBZldBMG4xRzVZeUFy?=
 =?utf-8?B?U0pEQVZmczlLbU5uSmEvTUdoY1ZieXFjY1F0ajNlVVNSOFhtR0tDSkhJZ1hR?=
 =?utf-8?B?UlViQVRjaW9pSExvdDB3bHNpbkcrQStYdzR6THRuNnhLeHBjTXI5WExEOTU3?=
 =?utf-8?B?b2IvRFlDNWg1d2F6U3BhbmI0YWJMSFJ1Q3MzUytHbUF6Z1EzWjg5M1hqcEtB?=
 =?utf-8?B?NWJxWUo1RFhyd3gxQ2NlcXFkQ28zbmZOQytid3F5VGNOMERkWFZqaHpBa1Rz?=
 =?utf-8?B?UzVLR1pJb29Qbm5tTXJRclpkUTcvb1EvUHI3SWpSalljaDQyRU5YVk1maEpZ?=
 =?utf-8?B?MG5lV240K3lDekN4ZzM1dmx1ZVVyNkM2amVsa1dWUmxRNHlYQ1Q0cUZMWE5U?=
 =?utf-8?B?Y1MwTEFQRC9NR3V6TDR4V2paNW4zdTJQcTNvOGRZc0NvWkVvcWJxSzFkV2ti?=
 =?utf-8?B?bEQ4L3FhRXhQWnlWWXRyQzF5RERxdVorZjRjbEREZ0Ryd1huNDhKazR3SC82?=
 =?utf-8?B?RjBmSjYzYmMxZGhRbVkzeGhCVlVwRm1uQmNCRFJVZ05ta3ZKL3NWNDFMNkV6?=
 =?utf-8?B?OExFb2d6VWgyTWNpRWcvTzJnNnJTa2hkclhDK3oxU2ZvTzh3SjkvczhqcS9j?=
 =?utf-8?B?anc5NDY4NnpSUStiamtJQUNlbnZBOW15bVQ0alR6TnNhMzVJTTlqRGFGK1ow?=
 =?utf-8?B?R2dPaSs1WmY1VUpmYXRUQmpoODUvRUdKbkdFVzlYcHZnUEp5S1FjU1pNOTFh?=
 =?utf-8?B?Z3duRVN4Z1BnYnBBQXNIZkkrazdSbWt5Z01DdlM3ckFMUWlTSHJ1aVZqWCty?=
 =?utf-8?B?b2ZhM3BIZ3Y5UllCalp4WjNMaHk5Q1NXQklBSE1ZTXF5bEs4R3dLcVYrZkVV?=
 =?utf-8?B?NFhaY0pPcDhBSEVkZHl1dFlVV3htdm9OOHVTR3EyL0pGSi9KL3JtMzhISDJx?=
 =?utf-8?B?eVppZkIvV1hUMUlqTlczbzZVcWU3em9BcXE1azkrb21SdnFSdEJRdjY5RjQ0?=
 =?utf-8?B?a3gvZVBSNmszWWdjb1p4QW1aNWNPMUpWTUV6N1F0WWJUWEQ5UE4ra1IzWitY?=
 =?utf-8?B?V1EyZU9qYXp2ZUs0cCtLaGVZeGtVbDZSSllKZG9VQ1BPUTc0MFRYQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7B61A8934F6A246B4C71916A0AF5B71@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 71bbda3b-c23d-4cea-b375-08df17b75a0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 08:07:16.6726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fldbK2iEOfTQtk3rO18tH4CGCyftR1e03abvGN92AVUkoxL0Peo6ukdOkefbqN/P6R7qG0pedaj060k+qdwkE/IwrLe2D9V9eXM4/wj+BfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8726
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Sep 2026 08:07:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24254

T24gTW9uLCAyMDI2LTA5LTIxIGF0IDA5OjU5ICswMjAwLCBKYW4gS2lzemthIHdyb3RlOgo+IE9u
IDIxLjA5LjI2IDA5OjUzLCBNb2Vzc2JhdWVyLCBGZWxpeCAoRlQgUlBEIENFRCBPRVMtREUpIHdy
b3RlOgo+ID4gT24gTW9uLCAyMDI2LTA5LTIxIGF0IDA5OjQ5ICswMjAwLCBKYW4gS2lzemthIHdy
b3RlOgo+ID4gPiBPbiAyMS4wOS4yNiAwOTozNywgTW9lc3NiYXVlciwgRmVsaXggKEZUIFJQRCBD
RUQgT0VTLURFKSB3cm90ZToKPiA+ID4gPiBPbiBNb24sIDIwMjYtMDktMjEgYXQgMDc6MTYgKzAy
MDAsIEphbiBLaXN6a2Egd3JvdGU6Cj4gPiA+ID4gPiBPbiAxOC4wOS4yNiAxMzoyMSwgTW9lc3Ni
YXVlciwgRmVsaXggKEZUIFJQRCBDRUQgT0VTLURFKSB3cm90ZToKPiA+ID4gPiA+ID4gT24gRnJp
LCAyMDI2LTA5LTE4IGF0IDEzOjAxICswMjAwLCBKYW4gS2lzemthIHdyb3RlOgo+ID4gPiA+ID4g
PiA+IE9uIDE4LjA5LjI2IDEyOjU0LCBNb2Vzc2JhdWVyLCBGZWxpeCAoRlQgUlBEIENFRCBPRVMt
REUpIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gT24gRnJpLCAyMDI2LTA5LTE4IGF0IDE0OjIwICsw
NTMwLCBLdW5pamFkYXIgU2hpdmFuYW5kIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiBGcm9tOiBT
aGl2YW5hbmQgS3VuaWphZGFyIDxTaGl2YW5hbmQuS3VuaWphZGFyQHRvc2hpYmEtdHNpcC5jb20+
Cj4gPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gPiBDbG9zZXMgaHR0cHM6Ly9naXRs
YWIuY29tL2NpcC1wcm9qZWN0L2NpcC1jb3JlL2lzYXItY2lwLWNvcmUvLS93b3JrX2l0ZW1zLzE2
Mgo+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogU2hp
dmFuYW5kIEt1bmlqYWRhciA8U2hpdmFuYW5kLkt1bmlqYWRhckB0b3NoaWJhLXRzaXAuY29tPgo+
ID4gPiA+ID4gPiA+ID4gPiAtLS0KPiA+ID4gPiA+ID4gPiA+ID4gIC4uLi9zZWN1cmUtYm9vdC1l
ZmktY2VydHMvc2luZ2xlLWtleS10by1lZmktY2VydHNfMC4xLmJiICB8IDggKysrKysrKy0KPiA+
ID4gPiA+ID4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkKPiA+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9y
ZWNpcGVzLWRldnRvb2xzL3NlY3VyZS1ib290LWVmaS1jZXJ0cy9zaW5nbGUta2V5LXRvLWVmaS1j
ZXJ0c18wLjEuYmIgYi9yZWNpcGVzLWRldnRvb2xzL3NlY3VyZS1ib290LWVmaS1jZXJ0cy9zaW5n
bGUta2V5LXRvLWVmaS1jZXJ0c18wLjEuYmIKPiA+ID4gPiA+ID4gPiA+ID4gaW5kZXggMjYzZjc5
NC4uNmE1MzU3ZCAxMDA2NDQKPiA+ID4gPiA+ID4gPiA+ID4gLS0tIGEvcmVjaXBlcy1kZXZ0b29s
cy9zZWN1cmUtYm9vdC1lZmktY2VydHMvc2luZ2xlLWtleS10by1lZmktY2VydHNfMC4xLmJiCj4g
PiA+ID4gPiA+ID4gPiA+ICsrKyBiL3JlY2lwZXMtZGV2dG9vbHMvc2VjdXJlLWJvb3QtZWZpLWNl
cnRzL3NpbmdsZS1rZXktdG8tZWZpLWNlcnRzXzAuMS5iYgo+ID4gPiA+ID4gPiA+ID4gPiBAQCAt
MjQsNiArMjQsMTIgQEAgRFBLR19BUkNIID0gImFsbCIKPiA+ID4gPiA+ID4gPiA+ID4gIAo+ID4g
PiA+ID4gPiA+ID4gPiAgZG9fcHJlcGFyZV9idWlsZCgpIHsKPiA+ID4gPiA+ID4gPiA+ID4gICAg
ICBkZWJfZGViaWFuaXplCj4gPiA+ID4gPiA+ID4gPiA+ICsgICAgaWYgWyAtbiAiJHtTT1VSQ0Vf
REFURV9FUE9DSH0iIF07IHRoZW4KPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gR29v
ZCBjYXRjaCEgVGhhbmtzIGZvciBkZWJ1Z2dpbmcgdGhpcy4gUGxlYXNlIGp1c3QgdXNlCj4gPiA+
ID4gPiA+ID4gPiBERUJJQU5fQ0hBTkdFTE9HX1RJTUVTVEFNUCBpbnN0ZWFkIG9mIHRoZSBTREUu
IFRoaXMgdmFyaWFibGUgaXMgYWx3YXlzCj4gPiA+ID4gPiA+ID4gPiBhdmFpbGFibGUgYW5kIGFs
aWducyB0aGUgdGltZXN0YW1wIG9mIFNCIHBhcnRzIHdpdGggdGhlIG9uZSBmcm9tIHRoZQo+ID4g
PiA+ID4gPiA+ID4gY2hhbmdlbG9nLgo+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gCj4g
PiA+ID4gPiA+ID4gQW5kIHNpbXBsZXIgY29kZSAtIGV2ZW4gYmV0dGVyLgo+ID4gPiA+ID4gPiA+
IAo+ID4gPiA+ID4gPiA+IFRoYW5rcyBmb3IgZGVidWdnaW5nIG15IGJ1ZyEgOikKPiA+ID4gPiA+
ID4gCj4gPiA+ID4gPiA+IFdoaWxlIHRoaW5raW5nIGFib3V0IGl0LCBJJ20gd29uZGVyaW5nIGlm
IHRoZSB0aW1lc3RhbXAgYWN0dWFsbHkgaGFzCj4gPiA+ID4gPiA+IHNlY3VyaXR5IHJlbGV2YW5j
ZSAoZS5nLiBmb3IgY2hlY2tpbmcgdGhlIGZyZXNobmVzcyBvZiB0aGUgREIpLiBJIGtub3cKPiA+
ID4gPiA+ID4gdGhhdCB0aW1lc3RhbXBzIGluIGdlbmVyYWwgYXJlIHBvaW50bGVzcyBpbiB0aGlz
IGNvbnRleHQsIGJ1dCBJJ20KPiA+ID4gPiA+ID4gd29uZGVyaW5nIHdoeSBpdCBjYW4gYmUgc2V0
IGluIHRoZSBmaXJzdCBwbGFjZS4KPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+IFRoZSBERUJJQU5f
Q0hBTkdFTE9HX1RJTUVTVEFNUCB1c3VhbGx5IGlzIHNldCB0byAxaCBhZnRlciB1bml4IGVwb2No
Cj4gPiA+ID4gPiA+IChmb3IgdGVjaG5pY2FsIHJlYXNvbnMgMCBjYW5ub3QgYmUgdXNlZCBhcyB0
aGlzIGlzICJtYWdpYyIpLgo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gSWYgd2UgbmVlZCBhIHBy
b3BlciB0aW1lc3RhbXAgaGVyZSwgd2Ugc2hvdWxkIHByb3ZpZGUgYSB3YXkgdG8gc2V0IHRoZQo+
ID4gPiA+ID4gPiBERUJJQU5fQ0hBTkdFTE9HX1RJTUVTVEFNUCBqdXN0IGZvciB0aGF0IHBhY2th
Z2UgKGUuZy4gYnkgaW50cm9kdWNpbmcgYQo+ID4gPiA+ID4gPiB2YXJpYWJsZSkuCj4gPiA+ID4g
PiA+IAo+ID4gPiA+ID4gPiBCdXQgc3RpbGwsIHRoZSBjb2RlIHNob3VsZCB1c2UgREVCSUFOX0NI
QU5HRUxPR19USU1FU1RBTVAgdG8gYWxpZ24gdGhlCj4gPiA+ID4gPiA+IGNoYW5nZWxvZyB0aW1l
c3RhbXAgd2l0aCB0aGUgU0Igb25lLgo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+IAo+ID4gPiA+ID4g
VGhpcyBoYXMgc2VjdXJpdHkgaW1wbGljYXRpb24gYmVjYXVzZSB0aGUgdGltZXN0YW1waW5nIG9m
IHRoZSBzaWduYXR1cmUKPiA+ID4gPiA+IG1heSBiZSBjb21wYXJlZCB0byB0aGUgcmV2b2NhdGlv
biB0aW1lIGluIGNhc2UgdGhlIHNpZ25lcidzIGNlcnQgaXMKPiA+ID4gPiA+IHJldm9rZWQuIFNp
Z25hdHVyZXMgdGhhdCBoYXBwZW5lZCBiZWZvcmUgdGhlIHJldm9jYXRpb24gdGltZSB3aWxsIHRo
ZW4KPiA+ID4gPiA+IHN0aWxsIGJlIGFjY2VwdGVkLCB0aG9zZSBhZnRlcndhcmRzIHdvbid0LiBU
aGVyZWZvcmUsIHRoaXMgdGltZXN0YW1wIG1heQo+ID4gPiA+ID4gaGF2ZSB0byByZWZsZWN0IHRo
ZSBhY3R1YWwgc2lnbmF0dXJlIHRpbWUuIEFuZCB0aGlzIGlzIG9idmlvdXNseQo+ID4gPiA+ID4g
Y29tcGxpY2F0aW5nIHJlcHJvZHVjaWJpbGl0eS4KPiA+ID4gPiAKPiA+ID4gPiBUaGlzIGlzIG5v
dCBqdXN0IGNvbXBsaWNhdGluZyByZXByb2R1Y2liaWxpdHksIGJ1dCBpcyBpbiBnZW5lcmFsCj4g
PiA+ID4gcHJvYmxlbWF0aWM6Cj4gPiA+ID4gCj4gPiA+ID4gVGhlIHBhY2thZ2VzIHdlIGdlbmVy
YXRlIG11c3QgYXQgbGVhc3QgYmUgImxvZ2ljYWxseSByZXByb2R1Y2libGUiIGkuZS4KPiA+ID4g
PiB0aGUgYmVoYXZpb3IgbXVzdCBub3QgY2hhbmdlIGFjcm9zcyBidWlsZHMgLSB3aGljaCBpdCBj
bGVhcmx5IGRvZXMgaW4KPiA+ID4gPiB0aGlzIGNhc2UuIE90aGVyd2lzZSB0aGlzIHBhY2thZ2Ug
bXVzdCBiZSBleGNsdWRlZCBmcm9tIHNzdGF0ZSBjYWNoaW5nLAo+ID4gPiA+IHdoaWNoIGFsc28g
bWVhbnMgYWxsIGRvd25zdHJlYW0gdGFza3MgY2Fubm90IGJlIGNhY2hlZCAodW50aWwgd2UgaGF2
ZQo+ID4gPiA+IGhhc2ggZXF1aXZhbGVuY2Ugc3VwcG9ydCwgd2hpY2ggdGhlbiBwYXJ0aWFsbHkg
aGVhbHMgdGhpcykuCj4gPiA+ID4gCj4gPiA+ID4gPiAKPiA+ID4gPiA+IEkgd291bGQgdm90ZSBm
b3IgbWFraW5nIHRoaXMgcGFja2FnZSAoYW5kIHBvc3NpYmx5IHNpbWlsYXIgb25lcykKPiA+ID4g
PiA+IHJlcHJvZHVjaWJsZSB0byBiZWNvbWUgYW4gb3B0LWluIGZlYXR1cmUgdGhhdCB3ZSBlbmFi
bGUgb25seSBmb3IgdGhlCj4gPiA+ID4gPiByZWxhdGVkIHRlc3QuIE9yIG9ubHkgZm9yIHNuYWtl
b2lsIGtleXMuIE1heWJlIHRoZSBsYXR0ZXIgaXMgc2ltcGxlc3QuCj4gPiA+ID4gCj4gPiA+ID4g
Tm8uIFBsZWFzZSBqdXN0IGFkZCB2YXJpYWJsZXMgd2hpY2ggY2FuIGJlIHNldCBmcm9tIGxvY2Fs
LmNvbmYgdG8gcGluCj4gPiA+ID4gdGhlIERFQklBTl9DSEFOR0VMT0dfVElNRVNUQU1QIG9mIGV4
YWN0bHkgdGhlc2UgcGFja2FnZXMgdG8gYSB1c2VyCj4gPiA+ID4gY2hvc2VuIHRpbWVzdGFtcC4g
VXBkYXRlcyBvZiB0aGUgdGltZXN0YW1wIG11c3QgYmUgZXhwbGljaXQuIFRoaXMKPiA+ID4gPiBt
ZWFucywgd2UgYXJlIHN0aWxsIDEwMCUgcmVwcm9kdWNpYmxlIGFuZCBwZXJmZWN0bHkgY2FjaGFi
bGUgdW50aWwgdGhpcwo+ID4gPiA+IHZhbHVlIGlzIGV4cGxpY2l0bHkgY2hhbmdlZCBieSB0aGUg
dXNlci4KPiA+ID4gPiAKPiA+ID4gPiBUaGlzIG9mIGNvdXJzZSBhbHNvIG5lZWRzIHRvIGJlIGRv
Y3VtZW50ZWQuCj4gPiA+IAo+ID4gPiBTdXJlLCBidXQgSSBkaXNhZ3JlZSBvbiBoYXZpbmcgc3Vj
aCBhIHZhcmlhYmxlIGZvciBwcm9kdWN0aW9uLiBJdCdzIG1vc3QKPiA+ID4gb2Z0ZW4gd3Jvbmcg
aWYgYSB1c2VyIGV2ZXIgcnVucyBpdCB3aXRoIGEgcGlubmVkIHRpbWVzdGFtcCBmb3IgcmVhbCBr
ZXkuCj4gPiA+IFNvIGJldHRlciBub3QgZXZlbiBleHBvc2Ugd2hhdCB3aWxsIGJlIHNlY3VyaXR5
LXdpc2UgaW5jb3JyZWN0Lgo+ID4gCj4gPiBIbW0uLi4gQSB1c2VyIHRoYXQgYWRkcyBzZWN1cmUg
Ym9vdCBzdXBwb3J0IHRvIGhpcyBpbWFnZSBNVVNUIGtub3cgd2hhdAo+ID4gaGUgaXMgZG9pbmcu
IFdlIGNhbid0ICJoaWRlIiBhbGwgdGhlIGNvbXBsZXhpdHkuCj4gPiAKPiA+IFdoYXQgYXJlIHRo
ZSBhbHRlcm5hdGl2ZXM/IFdlIGNhbid0IHNhZmVseSB1c2UgYSBmbG9hdGluZyB0aW1lc3RhbXAu
Cj4gPiBUaGlzIG1ha2VzIHRoaW5ncyBldmVuIG1vcmUgaW5jb3JyZWN0IGluIG1vc3QgY2FzZXMu
IEFsb25nIHdpdGggdGhlCj4gPiBnbG9iYWwgdmFyaWFibGUsIHdlIGNvdWxkIGlzc3VlIGEgbm90
aWNlIHJlZ2FyZGluZyB0aGUgdXNlZCB0aW1lc3RhbXAuCj4gCj4gQXMgSSBwcm9wb3NlZDogRGVt
byBrZXlzIGNhbiBiZSBzaWduZWQgd2l0aCBwaW5uZWQgdGltZXN0YW1wLiBSZWd1bGFyCj4gc2ln
bmluZyBtdXN0IGhhdmUgdGhlIHRpbWVzdGFtcCBvZiB0aGUgYWN0aW9uIHRvIHJlZmxlY3Qgd2hl
biB0aGlzCj4gaGFwcGVuZWQuIE90aGVyd2lzZSwgeW91IHJpc2sgdG8gcmVzaWduIHNvbWV0aGlu
ZyB3aXRoIGEgZGF0ZSB0aGF0IGlzCj4gb2xkZXIgdGhhbiB0aGUgbWVhbndoaWxlIGRlY2xhcmVk
IHJldm9jYXRpb24gdGltZS4KCkZ1bGx5IGFncmVlLCBidXQgbXkgcG9pbnQgaXMgdGhhdCB0aGUg
dGltZSBvZiB0aGUgYWN0aW9uIGlzIG5vdApwcmVkaWN0YWJsZSBpZiB5b3UgYnVpbGQgd2l0aCBz
c3RhdGUgY2FjaGUgKGlmIHRoZSBhcnRpZmFjdCBpcyB0YWtlbgpmcm9tIHRoZSBjYWNoZSwgaXQg
aGFzIHRoZSBvbGQgZGF0ZSkuIFRoaXMgdGltZSBleHBsaWNpdGx5IG5lZWRzIHRvIGJlCnNldCBz
b21ld2hlcmUgdG8gZW5kIHVwIGluIHRoZSBiaXRiYWtlIGhhc2hlcy4gQW5kIGFzIG9ubHkgdGhl
IHVzZXIgY2FuCmtub3cgd2hhdCB0aW1lIGlzIGRlc2lyZWQsIHdlIG11c3QgbWFrZSBpdCBleHBs
aWNpdC4KCkZlbGl4Cgo+IAo+IEphbgo+IAo+IC0tIAo+IFNpZW1lbnMgQUcsIEZvdW5kYXRpb25h
bCBUZWNobm9sb2dpZXMKPiBMaW51eCBFeHBlcnQgQ2VudGVyCg==

