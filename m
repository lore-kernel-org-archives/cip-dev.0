Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8000.1795479578441900342
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Nov 2026 16:19:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=bk7hhQs5;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1795479572;x=1796689172;bh=V1/Aps8f56zTlXtalq6tONEaTgit67KXIeVxx
	qoJG9Y=;b=bk7hhQs5X+vfDyx/otku7ovFVGN3+yCbCWn9OYQz7X7zaKiwp+GiKDwoFpMapHGLh+4
	iSJriBZFzfnFS3pJWBKQ8iudxyDivJbaeUfzzHEzFoGWQuHvPe426GrGW0isG+/m34HirIDLKtTSt
	jxVg8WIFGUWJSl6fm6zSTSjUs02YcHK9myvLmV2/XAw2U9axzSrFM8AglL7u44ASJtZFKaweUQvlz
	JmgrcIfjmSn/pgKSTDRxTC7C9NnLqXQIoE/ThbuVk8erRD6NcaaPOByX9/CUALKjg35/ZnidpqBFL
	ceimIYqonW/P4ZEEctivdLzUOR4eaS2xibLa9C4mp4Ug==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 6AO0JVJn413308; Tue, 24 Nov 2026 09:19:31 +0900
X-Iguazu-Qid: 2yAbd8Qg7H6VXdGjBR
X-Iguazu-QSIG: v=2; s=1; t=1795479571; q=2yAbd8Qg7H6VXdGjBR; m=vnwZTjuigkY/6wSRBVv1Y/ElYQMjCz9zD0g/ITWErvY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jYNjG27Psz1xnr; Tue, 24 Nov 2026 09:19:30 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWo6RDAwjKW+kbFhg8Bt4syW6jyemE9WNOilzNKddSmzB0OcwdLZeNm/N4ZkHHi5xsskNivQuSzvE8R78OvpduXajDFbRR5N3teWdpBK9HixAixeIqLctqclPfowl6ZeLsARo6vp4JrV/yX9s3TfWyPKYIQ0jI5yS4lYlNxqTfgfIDW9sImPiyVJN5nHdLLGCz6ISteYvW9MaO0PbqQKwlabdIYQlAVDoPv3PSVrtdaLJDR0Bhq7KGGVwEE1+xY4bLU7TmW88wjflaSaV6q4DnXPrfMcaJrtFsqReJpWL3locb8uwz7j/9ybJOojtHq/Ryy3sGLfqIlKdyH3NvwE4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1/Aps8f56zTlXtalq6tONEaTgit67KXIeVxxqoJG9Y=;
 b=lls8ZZIMRdp+d1zKuqiZZTsFL6fjRw8pIfsqVYGalnU2i42ws90VRN7JPvRZBI+QmRlkk9tuaMG8Z8d0W5D/i5PBl9v46xSVCdipJCB5UgggVkzgsJ8F91R3rzMzLSYyAGuiNCzbOlzajTFdLzq/eKW05b4wCQnzzLJm5fuJPRBkFThmxvD4t88usxSgMO+5Eg+OlmOT/Rud34IDX6G6PyAwDR5nEsa/yOODt/ZTIk9V6V6fc3iqa+/wJjOcHOCFEct3z00uZpKUb3kKYkPDN7+ATvi9ngSRSMrgZ4R5qwBamUJ8lCwWxsFEIkPnRMw9oXP0rOlev9OpCdrQ6725sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <luca.weiss@fairphone.com>, <cip-dev@lists.cip-project.org>
CC: <pavel@nabladev.com>
Subject: RE: [cip-dev] [PATCH 4.19.y-cip 0/4] Backport sign-file,extract-cert
 patches for OpenSSL 4 compatibility
Thread-Topic: [cip-dev] [PATCH 4.19.y-cip 0/4] Backport sign-file,extract-cert
 patches for OpenSSL 4 compatibility
Thread-Index: AQHddml9k5d/QM96VEmPk1E+q5fEf7c8ZJBA
Date: Tue, 24 Nov 2026 00:19:27 +0000
X-TSB-HOP2: ON
Message-ID: <TY7PR01MB1481885D09B5B068BCC637120CD442@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20261112-openssl4-419cip-v1-0-2f56859669bb@fairphone.com>
In-Reply-To: <20261112-openssl4-419cip-v1-0-2f56859669bb@fairphone.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYCPR01MB11766:EE_
x-ms-office365-filtering-correlation-id: 4994d819-2889-4624-655d-08df49c099cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|6133799003|18002099003|22082099003|261009223027099003|261021123027099003|261021130227099003|261021121427099003|261021135927099003|261022105027099003|261022113327099003|261026121527099003|261102123227099003|261026140227099003|261022075727099003|261022115727099003|261026130827099003|261028144727099003|56012099006|10067099003|38070700021|5023799004|11063799006;
x-microsoft-antispam-message-info: a3fA/+L/AvpWaFjcwMMY8WP4U7I4fU2A11C+/dYpwbSq/OsgIE1scSbByZlGDyRTQp6Y8l2rBJXWkoDPARbZL8+n/thOWNsi/fRYr3pkuL6lsyk5ZkZOVK5P9foMdFKAM7YqiXL+WUHrMbeCdiwwQL0Qb7du+ivExtXBTGB6Ug4Q4mbngWT6nC2Q9t4gz4lkEEUpEVv8dmR1INT7s6u3BaXaHeqJtxlymXNkzydcn4Z2XDz7zTLHmr5nqs+k/YiH+8PRj679KpipiFO92ApH8KebwmWFtDhpf0eePVlUGD8aUAGzX1S66W7/yexVEqhGK/dhJPglOScdDrhHN1kqyDB3UMeuCTulNcoLJuOh7eyZrLoNg8/5MuoxqLgL7Hd7aEcctkwDq0q9H/xCLdSQWxz0JizmIHWluNl3BQpmX1kWc5tCO+0+ZfLRLrbmdmn8tOXKkwQWVSG6hkDVAcn6qYWbVpNyANwxP7h0HzLoo4//2vBh+ZGnNefy/xqyZYmCFYoLh35KBH5SjmqLiVZn3Q8g1GIz6JnQv1u4D2Pea7WMXxBGKbUxbWmIKHYaSbcvU+peMa96AzieBG2ct2XSWYgOv7+2D2oQKiFO1L6r2m/zlOXLJzBWPJeEWDC6GSn2K/9OnLgzxmzlPMtd1cNDNahrJWZ9jeF6p9UOnD1602mVEoVEP3vin7snYyvf/jwcL33r9YXTGv2LaZvSi7U1cWsUwH1s3bX8M4MlrJnbU7M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(261009223027099003)(261021123027099003)(261021130227099003)(261021121427099003)(261021135927099003)(261022105027099003)(261022113327099003)(261026121527099003)(261102123227099003)(261026140227099003)(261022075727099003)(261022115727099003)(261026130827099003)(261028144727099003)(56012099006)(10067099003)(38070700021)(5023799004)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXEzbHdISjFMRFRZVXdJWUxHZnM3aEdyOGgrR29xam9qdGxpMUtSdVZZa2Y3?=
 =?utf-8?B?TUlLN2RJYWpyU1o4SnR3cTdWSU9zR21yOHBncTlOZDFBWTl1WlFxaTAzd3FI?=
 =?utf-8?B?Y05RWkhiZG9YY1grTTJHZ08rRFZnay9HNkMzdVdVMzFCL0x1L01iWDZuaUdH?=
 =?utf-8?B?RHZqK21wNm1DWlhDTFBoVlNQWXUrVmJBZ3NkTjQ3S1F4anRoV3IvTVY4aXNI?=
 =?utf-8?B?RmtFS2F2ZGptQWIwYXNZR3JCR1NOYVNvOGZRZmRXblFBbmxYZzlvRXBoMUpF?=
 =?utf-8?B?NkpCTEM2dllkZDB6SHdNYkgrWVpIUHdRYUkveGtoK1d3WE1KN3lWQm9BSmx0?=
 =?utf-8?B?a3prRjk2RDdWa1Rad1NWYlJ1L2k1dVBQclBaLzdCY0IycFdXNVQxbFVGSTVN?=
 =?utf-8?B?cTlxdWUvUm05R2JBcUtXV0RSdUIveG85dFRUZFZ0NUJVOGRNL3BqT29mUlVv?=
 =?utf-8?B?SWFnZ3VlK0FITldwRmFJZDRWcFRyaWlwNnNrdU4rTGY2M1pNS1FScFF3NE44?=
 =?utf-8?B?ajNXdHowYXRyS0dKOTRDQkE1QWZaT05DdnBmcWRMTGR0MmlJckFlbzRESWto?=
 =?utf-8?B?T28rZG9UODZoTWZVL1hLMnZVWWgxQ3pRZVFST1BVTDV0L1VpclRnMDFsQ3Jz?=
 =?utf-8?B?SmphYWgxS0pBRG16aUl6WE4xeCtsRVFsT0Q4NXFYbHRLTVdmaVp1L1Nuajli?=
 =?utf-8?B?U3pRcTJuMzgxT3Jpc3M4MmIxQXdoZG9NS2lFdkxEc3dYbFNmaUVtaFlGVjdV?=
 =?utf-8?B?QkdyR2JIbmNGVURQUE9leVBia1dVY1BTMWFnVnV5cW9EUzBNdWZkL3Y0UEFk?=
 =?utf-8?B?RlRWdlV0U3NyV2pQblVubTJIaDZlSW04M2NQRzVmV3QyS1Ixb29Kek1LWkxv?=
 =?utf-8?B?NHpMN3JEU0R1NjVoSkcvM3YrWWZ3WlJza3FWVXRqRnkraFVkV0dQZE9sQkk1?=
 =?utf-8?B?UHhuNnZJWDJJMWpuZWFVa3JiUVBYUGR2aW1xc0pHdFV3bWhnblh5a1ZiRWEx?=
 =?utf-8?B?dlc3dnZtazNkcFNUa1FuSzYyWHd3Y1B6NWh3MXFNb1czRmlDbVhsc1FyVStx?=
 =?utf-8?B?SkdGNTduTmw0MDFTRHpTai9VcldqM0p3NnNINmg3WGR4VSt5V0VvTnZYaURD?=
 =?utf-8?B?eG9RTUtBYUpMdk9PSDdEZjVKaDIrbUpraDNjMUNpYktLTTZrYXVLWUZ3Ly8x?=
 =?utf-8?B?VVdXSjYxRys5cTZlNUhPY1pXa3VuM1YwY0VkYnpBUjZheHdna0laZElqcS9a?=
 =?utf-8?B?UUphUEh2OUdTdzRLeWlwdkowSzQzMjhFWFN0emcrWFhvVy96VGxOcmpwc0VI?=
 =?utf-8?B?MWk2eFBmdjBKckhXbjNMSlZ3bmtRblVFNWExM0drNTIvMUE3a21Rb0VpRXNa?=
 =?utf-8?B?VkZFaTBGRjdoTmJrR1pwSis1Zld3VEJ5b1praFcxNjhtUHIxQUp1VGhZUFRm?=
 =?utf-8?B?TWVhNUtMcnNoVDU1eHl2MjM4ai9OalduREFlV2RMYVUweDFxREtST3dHM0Vs?=
 =?utf-8?B?Z3FtVFFkRTN5RTBtTlRTU2FlWE80eFZ2alRzR3Z6QTkxdmdiMkt0Q3pSRkJH?=
 =?utf-8?B?bWl1RHBka2d6OFdGVG0wN0h5eTVZNHB1Q0pCNytLS2R2VEM4aTV6ay9hWENt?=
 =?utf-8?B?c3BQa0lTK1N3NDY3S0NvUVQ5aC9uQVVmQ2pIZXpLUUtTVnRKeXNCVzFWYnk1?=
 =?utf-8?B?cEoxRkplbWlxRUZFOXJzVjUxL240UVZyRmw4VmlPSzBoTUVtbzdtcUVUaWJv?=
 =?utf-8?B?dVlKOXYvZTVIRkxHaEJlUFBlZkw1aUtsN2ZEUmlyNFpJVnhyYjM5aG1uTzBk?=
 =?utf-8?B?NXBxSnFUeTFsTkhjOVUvR01zVVl5cURQajU0Q3R4WVk3QllSUzZoQ0pFR3Fx?=
 =?utf-8?B?YUlCUWtRbWdYcStMTXJGTDFVbUo0ZDlZK0podk94a2hRRmQ0ckVyZzFsa0NI?=
 =?utf-8?B?Vm8vTFA5NzR6SnlhUzVCcFlXMkhFdFBobVZDKzVKSlBxVWMzNmJ4Ui9teWxR?=
 =?utf-8?B?SWo0Ni9XdnJqVXgweFY1OTZRcEZ0bjdNbUc5d1RCZkVWSlJrK041emdnU0RG?=
 =?utf-8?B?OE80UVIxWjhyckQ5eGIxTWI0NXJ2KzdPY0tXb2dtem9NbjFEeHhodzg2NWp1?=
 =?utf-8?B?S2czSmRzc1M5c2tEYkFmSU5TTGovS3FPMEErcHdGZis4djQ3UkRQRWt5a2Vy?=
 =?utf-8?B?dkZpVDVVT0JOSjdqTVVValBTekdzNk9SQ1RFQVppOWEyeGNVK25HVkFBU1dQ?=
 =?utf-8?B?Sk9Qdm13TXU5N0h4Q3VBTjFlUjl6OG5Sa1ExRzlOVjhQenVGZ0V4ZlRXeVdp?=
 =?utf-8?B?MTFDYVJJeHFqVSt4bzNydFRLZEFmSUxBcEJXZGRBSkNCV1pHaVdRdFNBUXRX?=
 =?utf-8?Q?b7bI9U2rUSQvb5mQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: k93XebrLXXmAQZwm3O19Mh+28NIMmeQsFot+kcQD7tPqt8jSypmiIUKKScUtiqm0D6B/LfB27sM6WTGMqy4sR69B1RMXlvm5B8sJFeU0xTPS2bO1pEQ2f0XGfD+jqhkQDWM7ZD2WTpuSi1lKFrDjFt/M5HsZTA0M+UITcP1pnNEbXwBU1bEmnTVNrSWdzYWWyxf/FZVojEl6S8y472VPvXLdEDJPoT8DCEUoO6xAIPcrPc/jm0MjAjMbYeQIGJF4WVdWX7jo2zQxndXlFDFjQfDn2Nq1UhL2Lcx+/FXB3Y+j51ouZwZlOZcSSmUkF0ip5vD28i6ba2A2Ge6zpF9O/Q==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4994d819-2889-4624-655d-08df49c099cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 00:19:27.1763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HVogLGF+YYTQ2+53H4hqvAvqzcCoNANBaahPIbTbj+w0loMxs3zY/oDaSSnS2dyPC2DfIcChcOXBkSMOcqgrqIMaL3YEn66B3nMjQvjgSWRq9TtSpROBbo1MuNh4XFdB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11766
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 24 Nov 2026 00:19:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25052

SGkgYWxsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEx1Y2EgV2Vp
c3MgdmlhIGNpcC1kZXYNCj4gPGx1Y2Eud2Vpc3M9ZmFpcnBob25lLmNvbUBsaXN0cy5jaXAtcHJv
amVjdC5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciAxMiwgMjAyNiA5OjUxIFBNDQo+
IFRvOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTdWJqZWN0OiBbY2lwLWRldl0g
W1BBVENIIDQuMTkueS1jaXAgMC80XSBCYWNrcG9ydCBzaWduLWZpbGUsZXh0cmFjdC1jZXJ0DQo+
IHBhdGNoZXMgZm9yIE9wZW5TU0wgNCBjb21wYXRpYmlsaXR5DQo+IA0KPiBPbiBBcmNoIExpbnV4
IHRoZSBleHRyYWN0LWNlcnQgdG9vbCBmcm9tIDQuMTkueS1jaXAgZG9lc24ndCBjb21waWxlIGFu
eW1vcmUNCj4gZHVlIHRvIE9wZW5TU0wgNCB1cGdyYWRlIHdoaWNoIHJlbW92ZWQgc29tZSBBUElz
IHVzZWQgaW4gdGhlIGhvc3QgdG9vbHMuDQo+IA0KPiBCYWNrcG9ydCBzb21lIHBhdGNoZXMsIHRh
a2VuIGZyb20gbGludXgtNi4xLnkgdG8gZml4IGNvbXBpbGF0aW9uLg0KPiANCj4gTm90ZSwgdGhp
cyBpcyB0aGUgZmlyc3QgdGltZSBJJ20gc2VuZGluZyBwYXRjaGVzIHRvIGNpcC1kZXYsIHNvIEkg
aG9wZSBJJ20gbm90DQo+IG1pc3Npbmcgc29tZSBjb250cmlidXRpb24gZ3VpZGVsaW5lcy4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEx1Y2EgV2Vpc3MgPGx1Y2Eud2Vpc3NAZmFpcnBob25lLmNvbT4N
Cj4gLS0tDQo+IEphbiBTdGFuY2VrICgzKToNCj4gICAgICAgc2lnbi1maWxlLGV4dHJhY3QtY2Vy
dDogbW92ZSBjb21tb24gU1NMIGhlbHBlciBmdW5jdGlvbnMgdG8gYSBoZWFkZXINCj4gICAgICAg
c2lnbi1maWxlLGV4dHJhY3QtY2VydDogYXZvaWQgdXNpbmcgZGVwcmVjYXRlZCBFUlJfZ2V0X2Vy
cm9yX2xpbmUoKQ0KPiAgICAgICBzaWduLWZpbGUsZXh0cmFjdC1jZXJ0OiB1c2UgcGtjczExIHBy
b3ZpZGVyIGZvciBPUEVOU1NMIE1BSk9SID49IDMNCj4gDQo+IE5hdGhhbiBDaGFuY2VsbG9yICgx
KToNCj4gICAgICAgZXh0cmFjdC1jZXJ0OiBXcmFwIGtleV9wYXNzIHdpdGggJyNpZmRlZiBVU0Vf
UEtDUzExX0VOR0lORScNCj4gDQo+ICBNQUlOVEFJTkVSUyAgICAgICAgICAgIHwgICAxICsNCj4g
IHNjcmlwdHMvZXh0cmFjdC1jZXJ0LmMgfCAxNDQNCj4gKysrKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgc2NyaXB0cy9zaWduLWZpbGUuYyAgICB8IDEz
Mg0KPiArKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIHNj
cmlwdHMvc3NsLWNvbW1vbi5oICAgfCAgMzIgKysrKysrKysrKysNCj4gIDQgZmlsZXMgY2hhbmdl
ZCwgMTgwIGluc2VydGlvbnMoKyksIDEyOSBkZWxldGlvbnMoLSkNCj4gLS0tDQoNCkkgcmV2aWV3
ZWQgdGhpcyBzZXJpZXMsIGxvb2tzIGdvb2QgdG8gbWUuIA0KQW5kIEkgaGF2ZSBjb25maXJtZWQg
dGhhdCB0aGVzZSBwYXRjaGVzIGhhdmUgYmVlbiBhcHBsaWVkIGludG8gNS4xMC4yNzUuDQoNCk5v
YnVoaXJvIEl3YW1hdHN1IDxub2J1aGlyby5pd2FtYXRzdS54OTBAbWFpbC50b3NoaWJhLmNvLmpw
Pg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQo=

