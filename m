Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11120.1793928070356471435
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Nov 2026 17:21:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=m/d6CCGT;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1793928067;x=1795137667;bh=cHMjKmwg28mPUz7B13iJcxzMI2nUI64V5aHhl
	QysleY=;b=m/d6CCGT7Xy7tNdDA5+HldTLC7mZ6TUi1sKqHOYFsXVCxQrIUW6kiqLlkIiR1dbH3xG
	KLBnuwRInyJo/vLcXI3PPJhB9OS33zzR4HTRcFGjAXyspIpvBbY5AcSgQ73/otNZjElhIFpVw4W82
	dy29LT9XYm1Aj3Ed1YVTym57BsY9qVCze0rRrCWc0l6aC3Hc6e2/z9pcjCsKnHG1e6PHMhsx1M52E
	kswQh+VV/aMdgAYnsHkq5rRyQw8NFjsz7j84H7/1QAGUcqpNdBe/GaUfabRT/mGdeLcE+L62xTm63
	vt5yrFTeuUtRa5pak7N3yGkPJTozXI8Q7uG6uih4Xz8g==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 6A61L7nO753693; Fri, 6 Nov 2026 10:21:07 +0900
X-Iguazu-Qid: 2yAakicNrFAyTW5Md2
X-Iguazu-QSIG: v=2; s=1; t=1793928067; q=2yAakicNrFAyTW5Md2; m=e2Y8XhbMDoxVbCtqbY6sDREJ4yuIvqcvi9uN8g34hd8=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jLLwg26nLz1xnk; Fri,  6 Nov 2026 10:21:07 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NNLQ9KcJ0yDATZAYtNrZ9PCeMmro9rMl4aJ3n/FYbzBgH4TPUqH29RhJQZQrxGHGAFE7zknRnoMB9bOQwDGs5v5Dvdm6ZeEeNXtV4knVSNyhr08YsORCfh9AKxnepYp0rdgh6dUxCE/dRH+IR2ufSaQiudK52zj8hDjwSGFO1WUKZrMw2KVeq4fZb5pa8oNAA+gTSZbYSfeacsdmTT8sp9LkuYmj4DLxOvgD3vHKLQlcBERYwmBf9VYQv6IRyfaXkLj8u51gw4q+9lWKGSDH4GL0lw9KbWE9ZLbGvCinAEJe0dspvdsR1Hk+GbRyCkKNEUHc8Yq+ocD4+HD+umHf5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHMjKmwg28mPUz7B13iJcxzMI2nUI64V5aHhlQysleY=;
 b=mzbxITvHk+JwZVRwI2vfjFJeqThCe3qbN3xk/C2slHUIcNZd6JQLKP+i6N+1xm7ms9ZMwSvAaSXLV2QatkRHRm/5Wq+DO/WkJgiF3ZoZU/h7uHq3080Aozrx0v7M20YsocetSqtIjK8xbgxb4nixcVinb5WXDb93WX+g9hpGTSAgT2fglorJZqkr42b3zeNpZYZkaWwTjaHXJFj2INhFPIUjSGDjk488giejw27ApkAAt+moweFWq1fEZ80+MkhU4p3IB8CQyACJeJuwHihKVp28KPGiyndyBs53j9BsWtqL8LxSx1LYhQwnFf2ycsAisyHQvwQfcpGJPySiWQc2tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <jan.kiszka@siemens.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [isar-cip-core][PATCH] u-boot: Change the mirror URL to
 u-boot-project.org
Thread-Topic: [isar-cip-core][PATCH] u-boot: Change the mirror URL to
 u-boot-project.org
Thread-Index: AQHdbO8brdXF3XCkF0K3KjYhx0kUsbcfB++AgACfpACAAJaHgA==
Date: Fri, 6 Nov 2026 01:21:04 +0000
X-TSB-HOP2: ON
Message-ID: <TY7PR01MB14818EA78FCE275C31089389BCD762@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <1793860204-10428-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <427d1f20-29a1-4772-81f0-35eadb4d7f81@siemens.com>
 <3013916d-0b1c-4976-87fd-1bd2c8414ce6@siemens.com>
In-Reply-To: <3013916d-0b1c-4976-87fd-1bd2c8414ce6@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS3PR01MB8620:EE_
x-ms-office365-filtering-correlation-id: a6e689cc-bb7e-4fed-0ac3-08df3ba43a52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|261022105027099003|261009223027099003|4143699003|38070700021|261028144727099003|261026140227099003|261022075727099003|11063799006|10067099003|18002099003|261026121527099003|22082099003|56012099006;
x-microsoft-antispam-message-info: IeXVmIvR5759DazEzIf9vqW7EPlXflgC+bYGOBxHDMlt3KWGlY07wLYfNtmNfgzVXj1djR317ruuTK3vFZ29xSusbbZ+HTUckldMAlZ/5+PK7KW6Mt2zp91+0RKzzQogA++44S6aHbfYugRU50VWSxdobYOccfkRPgr5GNxXGi4grX37AHyk9VsaA0oIJvsyfEjzkVK6/A15LKSYeAw5OaguHI8YrB5IIypgq+oSsqkBhUxdftLHvCLbVJg8I2ryVg5tnCCQaFPicLCAamxRbNBhy2p5DzT4/FaolxTXehrO1XT8qL4mkFOoUFOYRhw2XwbcICs6rdRZ6lVLMQ9nyR6CzQKi8MH9xuxu/yrs1wdTO4QZdeblMnJwL6dR0+FPHhW+dTkAZxiLo7z1kc39XnvWCwn7u2HtSIo2tpx/ofSkQbQNrP8as/tOtsY8usTGi6UX4RYp0i09V/24AsClwlc1VZp/fS5LjO644tXmyoF3sY2/BxFQSHyqu07mBUlngyhqByqHRlle9FXP3a2TfIdlFz+USSRxoxGxsH0PrFVoy2kj2B+PC8EEcWmiQHMpselQmHAWOlcTq6jOLX6RQ3ZiPcrWobBe+BTksblWxwK9sluon75JAbyOzHuf+ZtEAiFs0Y7vZLCRdkjU5JIDF2waLMGVnKBWCNPi2ag5EvByHf9TFPMvUmM55bEWGRUV8wTVW16xbdcUQCHL9osAL52DOEP1qODaZX1RmZmLmX4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261022105027099003)(261009223027099003)(4143699003)(38070700021)(261028144727099003)(261026140227099003)(261022075727099003)(11063799006)(10067099003)(18002099003)(261026121527099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHN3cWRyNEwvQ0haTzJXMjhCT3FIRXZNVmNpdk93RzdSN1dSdnJCUEpXL1kz?=
 =?utf-8?B?Kzh1RUpMdkdaZXJ4RDlsbjBSU1lGdEgxcytwUVBXTGN5WlB6TXQyMVlhZThY?=
 =?utf-8?B?Nk92enZhTUU4YVJ0WTkyZnZiLy81SC9BZ0hXMGRTcXVTaCtQZHFXSy9tODcx?=
 =?utf-8?B?aXgzVExhV01MWEo4Vkp5S1RsWmk4R05PcXJJTE54eGpMT1pQeTRIcFF0UXJP?=
 =?utf-8?B?YjRKa2xwVXpxMnhLSGI1SHhpbUw4djFQaG5oWldRUkQwcEx6YUxkdFlGRXZT?=
 =?utf-8?B?dk1aQ1hmbXJwVURxVkU0cyszaEJISWZzck1OYytEQzlxM0pnY2hGdzJTL2Zu?=
 =?utf-8?B?amNTQzZLOUlITitOZEdDNjlhcytLYVMxUFFZekhPbTBlQisvTVVZSVMwOHBq?=
 =?utf-8?B?ckExNzlieG83a3lZdFNWc25kV1FQYXo3Q1MvNU5aQk40bjVyajk4eDlIajRD?=
 =?utf-8?B?eUgvTGo1S01HT081REpRM25TRWNudmNMODlUSm5FdHVoT2owNVpLcDRNT3Nm?=
 =?utf-8?B?Q1E0cjhRSG9TTEtlNnNsb3hYaXB2ck1hUndJcEFzMzd0VitJa2M3elgzZThB?=
 =?utf-8?B?UUJUZ1hpQmhYZk5oNTU1VWFXc3hJai9PZXVjcWRXdGltV0hUb01JdU80VEJl?=
 =?utf-8?B?SGhIbCszNkJzaGRsZ3hoSFZwUFVvSnNvRzluUUtaQUNDWGR6ZkE0cXM3VjBR?=
 =?utf-8?B?bk8vOHZxYzNSUEpPbURMMXhCQ0lCT0JjeUNFMlRpcTdheEovKyt2ejZvQ1BF?=
 =?utf-8?B?N0ttWXEyU0dsMXVpNm1mODJ3ay9sNDFkTGg3cXNFSkR3SmFiTXk4cGg0dHMy?=
 =?utf-8?B?RTJESW1sWmx3a08vOWtlQkRvemw3VC9CWTNseTlZWXZ6UEIxMHFlb1RQMW1W?=
 =?utf-8?B?OWlsZDk4SDVCL0JtQ3Z1dU93Sm9WaGs5cWc4RnRaK285czhHODROSjVCajkv?=
 =?utf-8?B?TmxlU0NGZUt3N0p6a1ZuVUw1SU1RMWplbGVWS1N0UndaU1VuQlRNYU5PKytS?=
 =?utf-8?B?WGhJbi9XUklqc0NvZ1FqUXRBazE4bnRjeE4rVGEwWVZSUHp1NklmM3F2eU81?=
 =?utf-8?B?d3pzY2Npa29mNmpWbnJzSzJFUkZqYm1ZekEzc3BKV2lIVlo3d3JkcEVnV2xJ?=
 =?utf-8?B?WVdBS2hxaUIvQkd1eG9zQXRDNkF0YzFxbFpPSHJsbUxRZUtBeDVmTDA0bDRa?=
 =?utf-8?B?R2NsT0RSbHd4OWVDeHl1T1MrZUd2ckkrbjV1L1JFY0Naei9QRDdaNllSZSs2?=
 =?utf-8?B?L01vSlEvV0NFTFlsT2tDaU1SblFqaTNabDgxOVRLc0U1Q2Q1dnoxMzAyNHh5?=
 =?utf-8?B?ZSsyUUUrQ0Z3bzFTVXhrVmxVWWt5cmVQUEJsSjdRa1dUNEVCYzRBSzc0czFp?=
 =?utf-8?B?ZzVYNGNVZHRJakg0UzVxQVk5YnhUVnRUTGVUS3MwakRSRlEvVktXMkp3TUQz?=
 =?utf-8?B?OCtHNURKODlpZHVzTFF2VGwzT0daM1o2RUppQkhwRVZGR3R5YU1GNFlpNDkx?=
 =?utf-8?B?UTBDc0Q0a0NqOG9BeE9xTVZZR29mbExYUFkrRVJBRjlIeUtEYWhHVU15VUQr?=
 =?utf-8?B?aGdIYm5wM2wxSC9EdFpLQmhXbk8xNmQ4dXVVYUwwdTQ3UENaRndJZHdYcWtx?=
 =?utf-8?B?V0dmT3d5K2RkUXNaNE5iQlE3dldMVTFKZk9lUVBQcmduVnUvdjJyeWVxdnJP?=
 =?utf-8?B?L29aUjJHalpON09UQTZ1RU9WcVlnTVkrREpGWmRNNzRmYWh2UitPMm5vc1gz?=
 =?utf-8?B?WXorRkljZkJRdW1JeWNQcDBKbXVZK29aaVFUQnpHY0JxTjJ4SjdHWXNYTEhx?=
 =?utf-8?B?NzRHSjlCakV6Qm56UzdUZS81eUcvWWdzcVIzYmFrMElVdDRFamVNSVpVUE1v?=
 =?utf-8?B?MXQ0c3B0NGJtWHVsb1lCWXhJQWhTVWI1aklpQ1R5NitucTNwTzRNZXBGb3hP?=
 =?utf-8?B?ZFg3ZGFOanQwd3E3eWxac0tmUkFqWkJKditvcEFWSmRXQWlVS0M0ZEVCK0U0?=
 =?utf-8?B?d1lUYU5kZWxLWExKb1lFcnduYjVadnNuN04wTzl0M0hGY1BQRDY1RVhWSnBi?=
 =?utf-8?B?OXkxRnlrQ2IwclMwQm5uYUNkMStDcGdYZnpxZ29GM0syVzdpWXJYazJnSElz?=
 =?utf-8?B?cnZJYVdQeGp0cW1EbllFb20wUGQyQU5HZGFNR0E4RVVDTzV5MjVmcFE2MGlj?=
 =?utf-8?B?MDFuVzFOeVAxL0JzTmROeS9aR1dmVHVtMktjRW04VEtkRVdVcHNrZmJja1lP?=
 =?utf-8?B?c1lKR2FIM05sNEVEQkU5REJVZldZVkpyMzljR1k2RFFoTVBCL3MvajlCdXhT?=
 =?utf-8?B?VjB4YUY3QVU1WGpXWlVZTEpzYTNFbWhVVWY4ZzRWZlJTbEFodG5tQWhJYlhv?=
 =?utf-8?Q?5FAYNLayGd1E+znU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: sg9unQriR319+4X6ckY0FOD0IGWNnM1JhiB2WneZvjjjxPbzzGXq75hfWsdJlKJZldNlVH4n0I05DKT2bmVW6F/4Cr2YD2UeBidCNC+SedaZsaBXZNVnyBkYIup6UghTiWKYvWOmuVqWHQv7qU2wYjZqBlJP4v7WmddXAurhKosmw/K2wWCPuDamaivIFudvsje6H8MqpvyciUmmITfC8hbCnTG9eN4HLmv/xO1qORTfq28zlcdWKeOr0i6g2JlN2PfklJ3odZTzFBU5N+Ma4/DZ6GBAklnPJ8K/IfiGGMrIuoJEU6g2yKkSb0e+3xR5tOH7DdbnTb3FH52nEp6GKA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e689cc-bb7e-4fed-0ac3-08df3ba43a52
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 01:21:04.8514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2GvaKdFnj4oSJHvDHtZTFaEGNCZVjXNMBE9qBbb1xZ4yG+a8KhTSH0GRq7SaJsiwejD+iAFLlXfyA3/oN836S9TBmxqlQsbt3AkGPWY8Zox4TW7iI4vjYMFXf4+0aP6F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8620
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 06 Nov 2026 01:21:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24654

SGkgSmFuLA0KDQo+ID4NCj4gPiBUaGFua3MsIGFwcGxpZWQuDQo+ID4NCj4gDQo+IEkgYWRkaXRp
b25hbGx5IGhhZCB0byBkcm9wIHRoZSBvdXQtb2Ytc3luYyBhbmQgYWN0dWFsbHkgcmVkdW5kYW50
IFMgYXNzaWduaW5nIGluDQo+IHUtYm9vdC10aS1hbTYycHgtc2tfMjAyNi4wMS5iYi4gTm93IGl0
IHNob3VsZCBidWlsZC4NCj4gDQoNCkkgYWxzbyBub3RpY2VkIHRoYXQgbGF0ZXIgYW5kIHdhcyBh
Ym91dCB0byBmaXggaXQuIFRoYW5rcy4NCg0KQlRXIGRlMCdzIHUtYm9vdCBidWlsZCBmYWlscyBp
biB0aGUgRGViaWFuIDEwIChidXN0ZXIpIGVudmlyb25tZW50Lg0KVGhpcyBpcyBiZWNhdXNlIFUt
Qm9vdCBkb2Vzbid0IHN1cHBvcnQgb2xkZXIgR0NDIHZlcnNpb25zLiBJIHRoaW5rIGl0J3MNCm5l
Y2Vzc2FyeSB0byBoYXZlIHJ1bGVzIGxpa2Ugbm90IHVwZ3JhZGluZyB0aGUgb3ZlcmFsbCBVLUJv
b3QgdmVyc2lvbiBhbmQNCmZpeGluZyBpdCBmb3IgZWFjaCBPUyB2ZXJzaW9uLiANCg0KRG8geW91
IGhhdmUgYW55IHRob3VnaHRzIG9uIHRoaXM/DQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8N
Cg==

