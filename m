Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEEECC6B1A
	for <webhook@archiver.kernel.org>; Wed, 14 Oct 2026 04:45:36 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6475.1791953127612769403
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Oct 2026 21:45:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=WTmSH9KT;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1791953124;x=1793162724;bh=ZedgSJg0RrCQPcSy3iz6A1oKJwW8ydCYBQcvI
	dk1zIw=;b=WTmSH9KTczXoiKcu5spjzBfyvV2fq2BXstU8pyiRW3K2nVcqcsUX0/uheMBBlVtG76V
	dZIoTq/fxCETelCyvjtYXc8sufPQLxSg1ZeixZGc8zxnFRoHx8bRvBlVpOQzPsu/WRE1LI4oIlLmJ
	flAwCqDuN0MWkNEyEwuXn/l/bghpzSw+oeuyoFffdxigP2ixcRzkYqZ/0S8um99uadivvuHuVmXuz
	ZsVXq79G3e+I59XVTqJes4y98CfQz9DSJXpeYW5EsXVWYrpFHqpXVZiistRWOIFzxiHVEp5zqKv3V
	aH1OJYrL9CuLr6XVVL8b1nNRb3dnrXod/DqIMDto9rQw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 69E4jNi91597647; Wed, 14 Oct 2026 13:45:24 +0900
X-Iguazu-Qid: 2rWgksCqkVKGoSBOQu
X-Iguazu-QSIG: v=2; s=1; t=1791953123; q=2rWgksCqkVKGoSBOQu; m=f/2PO++nB8aHr5e4jxmoucJzNsV1cDqkHVKbj6nollg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4j4JXz2wVMz4vyn; Wed, 14 Oct 2026 13:45:22 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=waCTL4JEXXvJ8bQmF+EyifkbAQ8sAXhtHrIS+cWzbCVHaQxJle8XRBis4lRZxaVFcwY/lUM88uvEeCU9RrOB7wE8xo4N8baMTlbR/FO0ubJb+AGom8PV61tQOhOum/Q82jCyvwV8YE0HOPEhaoXIeP+ScTFRUJAz153Zt1o+m/dxPQDTxCnfz/FTlKgakJaJaR/pwL9KQ6j6MQB10VWqg0u/SJNg+L3kessCmHViUGAdXH7tNv0Mf0jnMLhSbHZCmF2LM/A94ar0n4haQaep1luFt+1rb4xsiJ9LKQbh9lVNLrDgqUsXNeJg1WuCAV6M2eF7EDfUra92ZciSgNvMmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZedgSJg0RrCQPcSy3iz6A1oKJwW8ydCYBQcvIdk1zIw=;
 b=BCSvnHxqp0BHQWRMgHlHb4stVzaHnFdk55fzSCJW4i/7/xHvxaOrDVkqf8aUolVCww3mPFD0yN56eL72pa/YSy90/GkkxiBcUyiPlFEtRuiJ9DMk5vL2vr5DOs3L/y4BlE95hkcuj7jnTk12tRtog6BDvXFneWmP0WE/yvx0guRuiFtPCP22R9zXGhEuYUHiuzZ/ymVb6B5xAVbnohc+0ve3/wBZokY6NjU9k6D3AymlMAGNhAAPHlvqjtysSXOUwoeek/XMmHdSDNjle/50W25aCBonk3Rn7QNoMaKFBCfjz8HBEsPjAWxds4pI7HfZ6toxT2gMS2eAy88KRxqdfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>
CC: <claudiu.beznea@tuxon.dev>, <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 5.10.y-cip v3] PCI: rzg3s-host: Fix compilation
 warning
Thread-Topic: [cip-dev] [PATCH 5.10.y-cip v3] PCI: rzg3s-host: Fix compilation
 warning
Thread-Index: AQHdUnfx13PN1WwZk0S+JTT5w2z9J7b69+RQgACLr4CAAQT6UA==
Date: Wed, 14 Oct 2026 04:45:18 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS7PR01MB1480895A6E2506F3FA8396D1ACD9D2@OS7PR01MB14808.jpnprd01.prod.outlook.com>
References: <20261002141124.2402765-1-claudiu.beznea@tuxon.dev>
 <OS7PR01MB1480829D2B2DA4FCC97978D98CD9E2@OS7PR01MB14808.jpnprd01.prod.outlook.com>
 <as4t1cyscqLGSdg6@duo.ucw.cz>
In-Reply-To: <as4t1cyscqLGSdg6@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB14808:EE_|OS7PR01MB18199:EE_
x-ms-office365-filtering-correlation-id: 35d5b2e4-76ae-4120-38b4-08df29adf297
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|18002099003|22082099003|38070700021|11063799006|4143699003|261009223027099003|261009221227099003|56012099006;
x-microsoft-antispam-message-info: 
 kRl1S4ebaenrjA0e68p3yZEli9wLAyG/oHx3T1fiwdd6AN/xKYvHy804LIle6fT1tjTmKrCXTHRZ05ucdXwnuSl85sBY71MpOw5tBYeWCoOKIZaxloOGiu5StWtCbSvHODZ492kmwzoYwq6v2UAkVuBVqCfWVQHW4XLpaLc1uGkuC5sY+FmjFjHow8cik2JTM0PWvpI9hT/wMepyGnTHfw0zkxf4R5MKicpkSzAPs2Zbn9Qhj+Q9h3VjV78B5AqF57SdvoO41XzFRanf5F5E+Kn+Kt1C19uEY9ABik6K9qQJiDBLm6jJfxy7d7+e5I+qydGtM7v0X1CdjgoZtlmHkWhZ/XOHcVMFwuT7NKbWOVd6BnnrokhA4NOpGCavyPFE2qO2clq3QH4yDe02rlsVMEkUXxTCTnD37FbXtPBJUccOAMdhnT8oEKKWRzpy7drj/dAr3og5JyetI4i/YsIGp+RV2K9v91YThvD87UM3RY+qm/1Cnz0xN+DQ3yX0duXvbJLIeFGjbZwNOgM2Ug8A6EQFmv9rPINyMbMEwK0SBlGlm0Z2yitFlMCYNUWZtlem9QmYkyO9eQjEJYYMI3/+/yW5BMfzoxGsPt0dKy6mPVdl0kYavnMYLRcijM4laqArkxjvVZhoJKcIqkrT4A+uvE6J4OK8FG6PCSG3m3WK6I6Zip0RZKqKeiqJTsosFQlPXuajC0l6m6EIbCU5JAfnMIMzbRVk0bJyXED3/AfrcQQ=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB14808.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(38070700021)(11063799006)(4143699003)(261009223027099003)(261009221227099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ajU1VXhQSzhmcmFaMzltTzVlZ0krZnZVL0RKcXpHNUZLdjEreGFoMFpUeWVT?=
 =?utf-8?B?UXBKVnFmSmsrckMzSFN0QUlCbldoL0pFTXdxa0YycHhBREdxZVNlVTc5VWNR?=
 =?utf-8?B?bUxlRmt0eEpLYjB3K0NGbFRlTThhWm9FTUVVSDZRZ1VjcisxanVqVWJlMStF?=
 =?utf-8?B?YUpxY2xxV1QrV2d6eGhYazBTTlhDZ0NYYlhESDhwZ2RyeXJRR2NLYi9rZE9H?=
 =?utf-8?B?NlBaUFdBRFVTL2hvQUxDR1ltTkNkUVE2ZnM2Zy9FVEh6UWZJTVhXN0JvcHJm?=
 =?utf-8?B?dk9kVGY0N2tCc0xiMnd2RmNrWmtPcEpyV1pCd3JoMEtSaUFxeWZVNCt5TkpI?=
 =?utf-8?B?aTRvcmlZaTIvUnpZdDlqRm9MTkh3c0RtVGUvb3EzQ1pYc0lQdi9uQVFKNGRF?=
 =?utf-8?B?YWdwam1HWE1PSDhtK1grWXNvclNGSE4vTnJxYXZyOHhIMU9oRFhJWnhLZ1Ax?=
 =?utf-8?B?OG1DWDM1TXRkdFM1cldyTm5FL3VJUDZEd1FycmlsSytKZXlFSWNSR2tUZ0hD?=
 =?utf-8?B?UmM4ZGZMd2JxU3NycFEzNWUrUTdTVVloSVpDbEVYZi9pUjJHM1RSSFd4Mnhi?=
 =?utf-8?B?VkZrMWtQSC9Jb1hKZjNjNkszSHZuRWNEMlo0bGxGakI0QWpWMkpsTERNZmxm?=
 =?utf-8?B?QndPN0E3VU9GcWs2bUd5ZGVjYThkSGJUQ254a3BVMUN5cHpoSGEwOXRnOFNx?=
 =?utf-8?B?NEFmU0hTNGtod0UxWEJFbk1yOUVmQis0NEptb0JPb3FuTEcwN0UxcXpaK1Fq?=
 =?utf-8?B?M3Mvb21PUEtsWDQ0WnFPUHlzZ3oyRnVFb1hPV3hhOHlZT2M4LzJyaW14UlFz?=
 =?utf-8?B?dEFNODFpUG1tTFRlTk1abE4rYWxrb0R4alZobWdaK0k0L0pwbGhobk92VS9r?=
 =?utf-8?B?RVJ5N1EwaXhiYkVoOE1odDMrMHBncHNaRW5zQmVFZm1ta2hOcXZmd2o3RVZL?=
 =?utf-8?B?QmpySGpUK2RWV25jckpJNml2NTN3VWh1T2V0ZDh6WGMvVUdNSkl5SW91NzFF?=
 =?utf-8?B?SFEySFlJYm5ZRzlxbVNVbHRna1MxcTE4QlMraEN0UTEzeXUxb3BUSmxwM0d0?=
 =?utf-8?B?UHFUcFpWZENyVU84cFZSM3JicGtjZUsvMHRmL2MzWHMwdGhhaVV1ampZYVpO?=
 =?utf-8?B?cjltVDdpeEdpdkR1Mk1NaEczYmdnQXVpTTdGYkNvQUZNVUhQaUEyU1hYYXpi?=
 =?utf-8?B?TExpTE4rVmpUOHdmbk1UbCt4QUM3azl1VTZPMWVMbXZRQnRSRGN6cUJxWTJ2?=
 =?utf-8?B?NkcxZkhmcUs2YTFnWUY5alFhTTkwOE9RTXNyL1hyYkNzSFBQRVJtT2JUL2RS?=
 =?utf-8?B?WFhyT1UrVlhXSFFGdENZK3I4T2FzTzdZS0pxdldxenVySkR2VEllQk9XWlFn?=
 =?utf-8?B?TzBZNkJnSUFqZnlndUNzNTZQTmRwWnJBQm1pUnlMRmRLQUhnRFR0eXl6R0dT?=
 =?utf-8?B?UGNnNHh0a055UUMyWERwMXQ0MHlWUFlxMkVHSU14aWRGS3VudTVGTUVPRUJF?=
 =?utf-8?B?TGp3T08xOVRlTFA0aFY5T1I4ZVlIQUFUN3ZhSlhYd1l3VXpzQlRhVVB0NUtZ?=
 =?utf-8?B?Tm5aWTZ0SzlLUFVWRk9temx4MXRoWE5haGNvZ0JoNE9rZlpFVWdhN1l5clVt?=
 =?utf-8?B?ZmZiajh4MzBveW9Dd3R6bHJsVXZIbmdHaUpqMjRsRVlRbHlFTGJFclIyT2Rt?=
 =?utf-8?B?SXo1RDBLZk14RFljV3VDT1JwMExjbXFSbVQ5eWZac2p4SXI3RS9KSFVjTUdn?=
 =?utf-8?B?aWpMa05ldXcvemdEUjJxMWIvbnlZQnUvd0VIZjlmZjRuWThnSU4veXdCOW5I?=
 =?utf-8?B?RmRxSEowc0ZzZ25VQ3ZUOHMrOHgvT2hUdGdMemw1MFJMUHpQVXMyenFSR1hy?=
 =?utf-8?B?TDFHelNtMjBHZ3dRSTNaNFdZSzIyT3J0TjZQdFhlc3RGYmlOSGVLMk9ydklX?=
 =?utf-8?B?UDI0QzJwbVNLMXhtUndqWUhYZkgrRjJGU0huUndiR0pLcmlDeVgvdnFiVTlu?=
 =?utf-8?B?ZVBEQ1FhTVR3dEJYNnhsbFk3UENhYTJNRVVKMUlUeHZQbldXdmp3anNyL0Vi?=
 =?utf-8?B?dm0xeERSSFBCbFo5M1hHdlFoYWZnbGJBRDdQTnF4S1JuZ3VUeklQRTBnbFAr?=
 =?utf-8?B?NC8wMGw0TTUzWHlwcno2L2s5QTNkVkMrdFNnUWZhL0lJQjBpeDNXMjk0bDBx?=
 =?utf-8?B?S3NBWDJNaDlzZEc1QThidTh0NThxZVUzK3pWREcwd2U5ZHRsRXM3ZDVFRkhO?=
 =?utf-8?B?c3lVNGhFMHVacGoyRjVpa1RTZmVKTUNRQlY5dDNnckZabHN0TlhJcGl2ZmZn?=
 =?utf-8?B?Q0VpRXp1YmphZ2R1YSt5bmlxYXZPVjZrbllhUmhBT3hRRlFaUU9rT1FQNURz?=
 =?utf-8?Q?AuVRJo2v87AuRE+4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	E4EJlR4QJgNYMzKOdtg4xEI49LMIilU0ujobaOxZTVbq/M/vGajHe7GXxCwqYhUFDpwiNv45CjyVQxv6LK5Fc7SYWhytBx19GfPYZpDhv9LuILtlqCz6tiA7TelH14Bo3GerxVL/lXaVPO7L+pLEqHuYKLTgiNPIG8EGaEAZefgvJyefp5G7FB7PRxzMeTJaaxdVYs/AqlnvSL9Ujp3zP6Q8VID3U+v1qGATOwalQB0jHR4n0oHy95fc+ivX5f7X2StA/UhMGK3q3OBhYTejHLCEz30XE6fXEQHP4iTAGI5T4faW2+jN6no8qsqpYSjmdiR3Y94kYpNasTyP7MHruA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB14808.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d5b2e4-76ae-4120-38b4-08df29adf297
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 04:45:18.5029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BwomCTidYVAGsWDUjVxS4OcE+chZm+MR862Cq6W2n6AjZHsXak6LXJCr0Jak+kAx4lY+ChxOL8DmFziIPlYpGnQVVVpJXk3fcMxZDIYUNLS5orgdd0KC3aeAkIQzzytM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB18199
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Oct 2026 04:45:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24454

SGkgUGF2ZWwsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF2ZWwg
TWFjaGVrIDxwYXZlbEBuYWJsYWRldi5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMTMs
IDIwMjYgMTA6MTEgUE0NCj4gVG86IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4pah
77yk77yp77y077yj4peL77yj77yw77y0KQ0KPiA8bm9idWhpcm8uaXdhbWF0c3UueDkwQG1haWwu
dG9zaGliYT4NCj4gQ2M6IGNsYXVkaXUuYmV6bmVhQHR1eG9uLmRldjsgcGF2ZWxAbmFibGFkZXYu
Y29tOw0KPiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTdWJqZWN0OiBSZTogW2Np
cC1kZXZdIFtQQVRDSCA1LjEwLnktY2lwIHYzXSBQQ0k6IHJ6ZzNzLWhvc3Q6IEZpeCBjb21waWxh
dGlvbg0KPiB3YXJuaW5nDQo+IA0KPiBIaSENCj4gDQo+ID4gPiBGcm9tOiBDbGF1ZGl1IEJlem5l
YSA8Y2xhdWRpdS5iZXpuZWEudWpAYnAucmVuZXNhcy5jb20+DQo+ID4gPg0KPiA+ID4gRml4IHRo
ZSBmb2xsb3dpbmcgY29tcGlsYXRpb24gd2FybmluZzoNCj4gPiA+DQo+ID4gPiBwY2llX3J6ZzNz
X2hvc3QuYzogSW4gZnVuY3Rpb24g4oCYcnpnM3NfcGNpZV9wcm9iZeKAmToNCj4gPiA+IC4uL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1yemczcy1ob3N0LmM6MTU1ODoyOiB3YXJuaW5nOiBJ
U08gQzkwDQo+ID4gPiBmb3JiaWRzIG1peGVkIGRlY2xhcmF0aW9ucyBhbmQgY29kZSBbLVdkZWNs
YXJhdGlvbi1hZnRlci1zdGF0ZW1lbnRdDQo+ID4gPiAgMTU1OCB8ICBzdHJ1Y3QgcnpnM3NfcGNp
ZV9ob3N0ICpob3N0Ow0KPiA+ID4gICAgICAgfCAgXn5+fn5+DQo+ID4gPg0KPiA+ID4gRml4ZXM6
IGM1MjQ5YTY1OTRkNiAoIlBDSTogQWRkIFJlbmVzYXMgUlovRzNTIGhvc3QgY29udHJvbGxlcg0K
PiA+ID4gZHJpdmVyIikNCj4gPiA+IFNpZ25lZC1vZmYtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1
ZGl1LmJlem5lYS51akBicC5yZW5lc2FzLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4NCj4gPiA+IENo
YW5nZXMgaW4gdjM6DQo+ID4gPiAtIGZpeGVkIGl0IGJ5IGRyb3BwaW5nICc7Jw0KPiA+ID4NCj4g
PiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtcnpnM3MtaG9zdC5jIHwgMiArLQ0KPiA+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4N
Cj4gPiBMb29rcyBnb29kIHRvIG1lLiBJIGNhbiBhcHBseSB0aGlzIGlmIHRoZXJlIGFyZSBubyBv
dGhlciBjb21tZW50cy4NCj4gPg0KPiA+IFJldmlld2VkLWJ5OiBOb2J1aGlybyBJd2FtYXRzdSA8
bm9idWhpcm8uaXdhbWF0c3UueDkwQG1haWwudG9zaGliYT4NCj4gDQo+IFJldmlld2VkLWJ5OiBQ
YXZlbCBNYWNoZWsgPHBhdmVsQG5hYmxhZGV2LmNvbT4NCg0KVGhhbmtzLCBhcHBsaWVkLg0KDQpC
ZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQoNCg==


