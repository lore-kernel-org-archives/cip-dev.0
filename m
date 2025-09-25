Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F4FCAC5A5
	for <webhook@archiver.kernel.org>; Thu, 25 Sep 2025 09:53:48 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.7556.1758794013941557810
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Sep 2025 02:53:34 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 58P9rVFg284779; Thu, 25 Sep 2025 18:53:31 +0900
X-Iguazu-Qid: 2rWgzRRyL8hNiLlzQf
X-Iguazu-QSIG: v=2; s=0; t=1758794011; q=2rWgzRRyL8hNiLlzQf; m=E24R1SlsGfsvAUAX711/+fASXWa0UZNgIUAmGrLYhEc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cXTYk6gl3z1xnZ; Thu, 25 Sep 2025 18:53:30 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PzVq/ooZvo27nGMV/1ntQgpLYxLV8oM7/+7Zgt6CWIocCK1zb4EBS6CZWOIdBc26czNhntIHfhJ+DC9G7FkO5X4//NdorZeP2oyqA0FZoESZLAE/FFUHMTtJX/FBu21TI2bBAHnpRwW5YMmkDNduV84LybrsaMa5gDxA+uZmuCx+w34joCK+rXAek+Eo0NUvSuHr8UPocf9VWphO0DWfu8aMyLANeOAFj+aKx8GFYpoS9yFHTUwY4ADlYCPbTytZsnOF80W/vaILj0ZlRBd5ieWUmIYGNk/VIUVQpoNUUwrd5gxYlj9R6WVsq+Fmoa566YqXQgpOmmTidYrmddCm/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hsk4w0z9/yYQlR81ovcezdfAhK33LFEYoQzGwYCCdGk=;
 b=Jb4XXHepifL26ftHHA6vUSD5LqotVHhnZi+jIN4Vqi9XF4MvRM1dXslCoh55ChZxHmmAqYjL7nDqBeHcVcm/ViBe9rOJ6B/pcQVfk/M9JtSLUeIXYQlhTjj+da6UMazQ9jvTQn9Q6iVUpMCdNGH0vWurrfQJFYWI/DmkBGRMX69HnS9wSH4T0pvC1P0irAnbE/BbJdSWX1Kuqq/LUwTc0idPZ6V5SLcbTG139VPWuYN3ieEtNrjh9M6NtMT5O3j0/bCiswSB99iiBb+funcP35TeePtXwZLMb16xwZabX/ZBf0a2N3jN8RxTtSuCVZ+qEJuLuRDgVzZdmVj1ANJSkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>,
        <Chris.Paterson2@renesas.com>, <dinesh.kumar@toshiba-tsip.com>
Subject: RE: isar-cip-core: on-device tests failing
Thread-Topic: isar-cip-core: on-device tests failing
Thread-Index: AQHcLVNEloTXUwMEUEOFybgBc8TVV7SjpJGg
Date: Thu, 25 Sep 2025 09:53:27 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB11075F7F38A4345A60D5FF028C71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
References: <53fe043c-eba5-4d8b-826e-5846efce7d57@siemens.com>
In-Reply-To: <53fe043c-eba5-4d8b-826e-5846efce7d57@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|OSOPR01MB12219:EE_
x-ms-office365-filtering-correlation-id: 0f235220-46c7-43fd-14d7-08ddfc196061
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?RE0wQkZ0djJSem5SOGFJSDR3THlJKzdkSFUrR2dHbFg5VitmRWdEcXJ2bW1v?=
 =?utf-8?B?d1VuclFONUNacDNmbE5UYUlNbURjK2xaeTFNMkJkeERKUUU1dTJZb09TUDVD?=
 =?utf-8?B?VVlNZVByUWptU0svd1JjUVY5RUdWV1hmeFBJVWNGNlJjUEU0UnVacS8wdi9K?=
 =?utf-8?B?bTVDTVMvTThlS0lxQSsxMGluMjVyVTRLNUhrdEQ5V3o5T3VRTjZFTStDVm8z?=
 =?utf-8?B?eUpCcC81cjBUUTFkNkprakg5bk1OaHRTSTl0ZUZISC9KbDlXdkxaeCtpTjZ2?=
 =?utf-8?B?aHdIekpybWxUQmltMHJYZVQzam1USE92WWY4c1EzczVCclZkV241cGpReEJp?=
 =?utf-8?B?WTBBMG9Bbk9JMWJuZUVBWDhMemJwOVlyVmdnMHJFaU1ONDBRblBkbEJaNDJ3?=
 =?utf-8?B?UjliRVEvc2JSL29jSG1yRmlmR2pKbHdDZlBNanI1alZzL0s4VDlFZ1JSSkd5?=
 =?utf-8?B?L2kwbzhubWpFY0x2UlpobHQyM1R0dW9IRXllQ01Lb1VLa2o0eWY4d2lsZlVo?=
 =?utf-8?B?eTE3WmpSY1IvVkxUTUNOc2pWUmFoRFY2TlY0VzI3aFhXT3ptdllHYVVHZkEv?=
 =?utf-8?B?c0dKVGJBU0NmREFSSXVtK2ZpdjVmRTB6ZzlXSW5pNmQ4bkQ5em9rd2JwSUJw?=
 =?utf-8?B?VVVub2FTVXk2Y1VGZ0ZPUXlDbXFtNXVWQmlnc3dycWtkZVZrMGhQREpJOXcw?=
 =?utf-8?B?SmN6THRSOGRzVitWZ1ozQzVncnY5TVpRSi9OcHp6WWVlQ3c3Z3NtMHdGU2VR?=
 =?utf-8?B?eGVkaFRzSURqd1IvWGJBTGp2T3VJcTFPRzZLdndlVlRXcnJtU0hBRkw4NzMx?=
 =?utf-8?B?VGZWdFJ5eXlWZVVJRFErZER6U1VZY0xRZFlCYjB6TlVCRTdtYkVkcDBObFNj?=
 =?utf-8?B?NUpqdTRoaWdFdVd2OHNEWnZwQk15TFhMMy9DZVRMa2pVb09oeWk3YTdHYTdP?=
 =?utf-8?B?OExEZE9qaTN3R3FUTUhVQzZPQThERE1CYng5blBBOWRKUUVhNURibXo4UkY0?=
 =?utf-8?B?WDdJNDAyWGwxMEhHM0JFRlNXWHV3WjAyMWVCdTZDZitaY3VNTWdYZG9kS3lX?=
 =?utf-8?B?K2U3Ty9TR1hrMkhSVTQvZzh2NUEvQVlsSlhJVml1ODd0dGg3dFVHMmhXeHMv?=
 =?utf-8?B?TW1ackRtTldEWVVoMFp0aFRxblVDSStRYU12YUhHb0pkYXNMM01LbzBaYVd3?=
 =?utf-8?B?MUt1TUVFR3FuZWk3TDlOSHJLVHlxdjNiVzhmSzN4emhLTnZHZk9PNzFLTzNk?=
 =?utf-8?B?Y2dHYk1xdDU4MTM3R2ZxREZ0a05kQ1FLT01EaGw1VDZsK2hlb0hnZmx0ZUVQ?=
 =?utf-8?B?aE5oU0dwdDNTcjJoTnRpb09DcHhucXZsQ2x0Yzlad2NOSVBaZERVT3M4enJS?=
 =?utf-8?B?MjE1MXZhNUlCTWVYRUFlZGhFeGpQYWtnemFmNGNnTmRnUllkUWRPWWtwcVgw?=
 =?utf-8?B?ZFRyVUwwUCtteWVYUTV2dEwzR3A2YVNvbFVlckpaaTJKTlBEZDZNbjFuRll5?=
 =?utf-8?B?bGdqMlo3RkFSQ0FtVm1sMkRLVDcxT05xb2RWMm02UlI4UmFKcGgwclBSQUha?=
 =?utf-8?B?RnRQdWRnR0dzWlRMVjdLWmxRZ1JXZFZjMVk2Vy9Wc2ZaWk91M2N6MzAyWHdK?=
 =?utf-8?B?d21aTDBWVDNwTy9CYmw2QkNKbXliQnZUZEFDQmtYSzVZU0pJcjVJZXhxR3Zu?=
 =?utf-8?B?N29XSWgxMEs1Wk02aWNGVUlYaWpMYXFiUndtVG9CY0Q2TWFsdjdMY3lNWkhK?=
 =?utf-8?B?cGRScVo0aDZrSjNjU2svcm9jdlJhZHgyY3RzUUFUNEZoNkxydjJVQTZGOWlo?=
 =?utf-8?B?QmIyY0lsVnZnYlVmQmpXN25vMUk2TEQ1NkdWcTduWlBLWGtKTDJMWVgydHEz?=
 =?utf-8?B?UklXYnJqVWlaNEc5dHU4UVFoTnZFalFDVmVScW1xUHlkNm1mOFhLeVNEUFZB?=
 =?utf-8?B?Q1pqL1lmaFdrOTdQVDBBeElRZkNTRnlSOW4wSXI4MVNmWGhZeFBFUzZsVnpL?=
 =?utf-8?B?dTBJMDRvbG53PT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eUpxZmF5cUZBaUpxV0lQVlhxcGVlcmZWSEVneW00OGxrSnRIdFF2Z095Tkcy?=
 =?utf-8?B?UjNpc05nbW1KR1VCME1ZVE5pTFZoS3NVSEdmNWdoNE9oUHVValNHUnJ5ZHRF?=
 =?utf-8?B?UjBWTEtUclVqTEFtSkNSbnR4cHlSZWxwSTJIZVZ3V2Z4Y3lNL1NVNVpuV3Ry?=
 =?utf-8?B?Y3NDMFljQ2h3WExDT0VjaFZWUFhvMTNMNTdHWExtelVrWHFKeWdydXo4K0th?=
 =?utf-8?B?VHl4S2k5RWR0dUNkTDczazBTSWk5T2lXYmdqMWpoUVIyZCtYa0w3WFdVK0FE?=
 =?utf-8?B?ZWVTaUFVbWVwUkZrUjU1SHBpa29EY0kwR0ZZR0VnS0FMTE96VG9ydHhJRU9Z?=
 =?utf-8?B?NlJWbjhja1dWbG9TbHRFRmhTanNicVl1a0xsTnUwd3JrTXhobU04cGpJcjZV?=
 =?utf-8?B?ZHRsMFlNZDhVSEFselVRc3dxQ3VnclRHcjc1M0NJQVFZR1Nydkw2UGx5MWZk?=
 =?utf-8?B?UnozcmtJaXc2NzZWWnl2bzFtcEpRYnNYMXcxMmYwZXpvT2pVQmU1RDBGMFJz?=
 =?utf-8?B?bFRIVEZZbStqUUdEYVUweUpGVEoyZEVQQ2t0dXlqTCt5RHhpTlQ0c25kbDNE?=
 =?utf-8?B?MWxrdVljcUFCUlBDTHhQK1JFV0U0QXJOVk1RaHg4M3FUaXQzYnhZSlJLV1Iv?=
 =?utf-8?B?QXRkcENtT3NJcFhidVpnRjBHa2lPT1FGSVR4WnVjL1hRUWIxSWwzSDhpcDFS?=
 =?utf-8?B?KzBkN3VmNUQ0OUdzRnRMRXQ5L0hEWFp5eW9DalB4b2RlQ2JnTGQwMjRMZWxO?=
 =?utf-8?B?N2QwOHBrdzRSeGp6aktBRVpZUzBHeXFaQmJPTE81dTJCRUhhYThiTHpCbzgx?=
 =?utf-8?B?TyttRTZvWGFyNXhxaWtySzJCY3lhRGt0UERrS3J3RFJtVWdsU3llUWJ5cnc4?=
 =?utf-8?B?L3F5ZjEwdWhOaGpXa1c0UVRGQm1KZHQ5azYwdlEwRWFUOFdwS2RrMGZMZXRj?=
 =?utf-8?B?d0pKd1d0MGNDcGppUzhXS00zait2N3VBVTNSTFpOZXFXNjhQc3JQb3FEMUJD?=
 =?utf-8?B?TjRxcFpUMEt6aC9pQ1lWcklSdXllZyszOVlDa2JRaUJtbmxkdk5LMjJVYXNP?=
 =?utf-8?B?NDlicXExNXN5MCtKOFd2L21uVG54em5ob29sZUxZMWVZekYxNmNSWmpMbUJD?=
 =?utf-8?B?VGJtbmZDWUtnVzhFMjBzSmxZTksvUHZGRkR4bmM1cWpvMHNrQ21NNlV3U1Zp?=
 =?utf-8?B?YWZyWmQ3cjhXTkFNQko5TnUyUHd2THBvWEIzVzNuRG9zVUUzaENHd2NrREF4?=
 =?utf-8?B?a1d4QlhEY0lSY1M0WldNMTZ2anpobEdPUlRUdXQ0aVFsTUxOOG1FN2RqaFB6?=
 =?utf-8?B?YVI5anNsRStjYVo3NVI2cTFFYUREb2FaMENkMGxZc3VXR2dSbGFwRnc2cjcw?=
 =?utf-8?B?Y2JaSzJHbXpHcTlxc2VJSzVOazhWc2YwZ1FrRktEYTBvQ3hUYXI4MVNYbEgy?=
 =?utf-8?B?aHREakJQTU9nb2pUR1dvQ0EvR0hZN2p3ZnV2K0pqM3VueHdTQ3ZENGZoUnE5?=
 =?utf-8?B?RHZldXVGMTVYUGZBY0xSV1AxZXhHSnZYOW1KcU1qUEljWklVVjgwMGMvUVR5?=
 =?utf-8?B?SzIrWVRHYTdmcjJkYkxoUDJ6b1c0T01BZWEwUTdTVldNZHdpdUpMMTNwYmxS?=
 =?utf-8?B?NmNkNVVvVUpVNkVHcndNYnVQN09QOXlDSTdnbnVZeFQvNWlkeUpBUmNxcjRC?=
 =?utf-8?B?QTRocG1rK2h3Z1dGVExjbTk0eExvU3gvTStoNUtqenMwdDhZb2VTcmVvNU4r?=
 =?utf-8?B?Z2FTcXFYbUxQc2JYK2RBLzlBc2ppSy9NVjlZR3kzZ0RHS0Y4S0lkU1UrZ1k3?=
 =?utf-8?B?SmNmdWxNQVZzcUp5b1pHNzJrcVdodjg1US9IQkMya0EySldtbVVPeVdacG5R?=
 =?utf-8?B?NFM2dk55WWdNMDQyTjVEWVJHOEU3NlFYMWZzTWZiSnJTWGZ1WXBnUUtFVFJa?=
 =?utf-8?B?OEljK2NYMlhweklLMW1NRzZVT2dnbGh6blhrNXBOKzhuSTVTVHpTMDlNZFRH?=
 =?utf-8?B?NlR5b2FOcUpKQk94VkFOMUovZGlWekNmeHcyWmtHWXk1dTFidDBoWThyTjZ2?=
 =?utf-8?B?SVNuTHV1OVJPU3J0VlI1YW5xWkY4Y3FIOG5CTlVQN1p6c2F6SkRzQmJqTXNP?=
 =?utf-8?B?WjIyT3EzM1RUbHQyaW5HNXpFYnltVnNIaUhBSHcvRmFlYTU5OVV1NHhGZEVj?=
 =?utf-8?Q?5suwxwF3pepKYIkIqdMzuyA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f235220-46c7-43fd-14d7-08ddfc196061
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 09:53:27.7578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PMaAQsE+PD57XMuUYZGHpXaFobmgsBB2sYt6TiKruQOLCsMETgCOG+lZwEfmTps2jKi+zph4Zz699kw0rBbFsEEDzcgIp+mnss8iBp7AzULQLc69KFeNB7AxkTGaxaAk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB12219
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Sep 2025 09:53:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20132

SGkgSmFuLCANCg0KVGhhbmtzIGZvciByZXBvcnRpbmcgaXQsIEkgaGFkIGEgbG9vayBvbiB0aGUg
ZmFpbGVkIHRlc3RzIGFuZCB0aGV5IGFsbCBhcmUgcmVsYXRlZCBNLUNPTSBkZXZpY2UuDQpJdCdz
IGEgdGltZW91dCBpc3N1ZSwgMzBtaW5zIGlzIGJlaW5nIGFzc2lnbmVkIHRvIGJvb3QgYmxvY2su
IEl0IG1lYW5zIHRoZSBkZXZpY2Ugc2hvdWxkIGJvb3QgYW5kIGdldCB0aGUgbG9naW4gcHJvbXB0
IHdpdGhpbiAzMG1pbnMgaWYgbm90IHRoZW4gdGhlIHRlc3Qgd2lsbCBmYWlsLiANClVuZm9ydHVu
YXRlbHksIHRoZSAzMG1pbnMgaXMgbm90IHN1ZmZpY2llbnQgZm9yIE0tQ09NIHRvIGJvb3QgYW5k
IGl0J3MgY2F1c2luZyB0aGlzIGlzc3VlLg0KDQpQbGVhc2Ugbm90ZSB0aGlzIGlzc3VlIGlzIHNl
ZW4gZm9yIHRoZSBmaXJzdCB0aW1lLCBlYXJsaWVyIHRpbWVvdXQgaXNzdWVzIHdlcmUgcmVsYXRl
ZCB0byBleGVjdXRpbmcgSUVDIGxheWVyIHRlc3RzIGNhc2VzIGFzIGl0IHdhcyBub3QgYWJsZSB0
byBjb21wbGV0ZSB0aGUgdGVzdCBleGVjdXRpb24gd2l0aGluIHRoZSBzcGVjaWZpZWQgdGltZS4N
Cg0KQXQgdGhlIG1vbWVudCwgSSd2ZSBiZWxvdyBpZGVhcywgDQoNCjEuIFdlIG1pZ2h0IG5lZWQg
dG8gaW5jcmVhc2UgdGhlIGJvb3QgYmxvY2sgdGltZW91dCB2YWx1ZSBhbmQgY2hlY2sgaWYgaXQg
d29ya3MuIA0KMi4gSW4gdGhlIGN1cnJlbnQgaW1hZ2UgL2hvbWUgcGFydGl0aW9uIGlzIGRlcGxv
eWVkIGFzIHNlcGFyYXRlIHBhcnRpdGlvbiwgc28gZHVyaW5nIHRoZSBib290IHByb2Nlc3MgdGhl
IHBhcnRpdGlvbnMgL2hvbWUgYW5kIC92YXIgYXJlICAgZW5jcnlwdGVkIHdoaWNoIHdpbGwgdXN1
YWxseSB0YWtlIG1vcmUgdGltZSAoZXZlbiBpbiBRRU1VKSB0byBjb21wbGV0ZSBzbywgd2UgY2Fu
IGNvbnNpZGVyIHRvIHJlbW92ZSBkZXBsb3lpbmcgL2hvbWUgcGFydGl0aW9uIHNlcGFyYXRlbHkg
Zm9yIENJIGltYWdlcyBhbmQgaXQgc2F2ZXMgc29tZSB0aW1lLiBEYXRhIGVuY3J5cHRpb24gY2Fu
IHN0aWxsIGJlIHZlcmlmaWVkIHdpdGggL3ZhciBwYXJ0aXRpb24uIA0KDQpXaGF0IGRvIHlvdSB0
aGluaz8gUGxlYXNlIGxldCB1cyBrbm93LCBhY2NvcmRpbmdseSBJIGNhbiBzZW5kIGEgcGF0Y2gu
DQoNClRoYW5rcyAmIFJlZ2FyZHMNClNoaXZhbmFuZCBLIA0KDQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KRnJvbTogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4gDQpTZW50
OiAyNCBTZXB0ZW1iZXIgMjAyNSAxODozMQ0KVG86IGNpcC1kZXYgPGNpcC1kZXZAbGlzdHMuY2lw
LXByb2plY3Qub3JnPjsgQ2hyaXMgUGF0ZXJzb24gPENocmlzLlBhdGVyc29uMkByZW5lc2FzLmNv
bT47IGt1bmlqYWRhciBzaGl2YW5hbmQo77y077yz77yp77ywIERJVENfRElULU9TVCkgPFNoaXZh
bmFuZC5LdW5pamFkYXJAdG9zaGliYS10c2lwLmNvbT4NClN1YmplY3Q6IGlzYXItY2lwLWNvcmU6
IG9uLWRldmljZSB0ZXN0cyBmYWlsaW5nDQoNCkhpIGFsbCwNCg0KY3VycmVudGx5LCBJJ20gbm90
IGdldHRpbmcgdGhlc2UgdGVzdHMgdG8gY29tcGxldGlvbjoNCg0KaHR0cHM6Ly9naXRsYWIuY29t
L2NpcC1wcm9qZWN0L2NpcC1jb3JlL2lzYXItY2lwLWNvcmUvLS9waXBlbGluZXMvMjA1NDI2NDA0
MQ0KaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxlci9kZXZpY2VfdHlwZS9tY29t
LW10ZGENCg0KTWF5YmUgdGhlIGN1cnJlbnQgc2xvd25lc3Mgb2Ygb3VyIGxhdmEgbWFzdGVyIGNv
bnRyaWJ1dGVzIHRvIHRoaXMsIG1heWJlIGl0IGlzIHNvbWUgcmVncmVzc2lvbiB3aXRoIHRoZSB0
YXJnZXQgZGV2aWNlLiBDb3VsZCBzb21lb25lIGhhdmUgYSBsb29rIGFuIHByb3Bvc2UgYSBzb2x1
dGlvbiBvciBhdCBsZWFzdCB3b3JrYXJvdW5kPyBJdCBtYXkgb3RoZXJ3aXNlIGFmZmVjdCBvdXIg
bmV4dCBpc2FyLWNpcC1jb3JlIHJlbGVhc2Ugc2NoZWR1bGUuDQoNClRoYW5rcyENCkphbg0KDQot
LQ0KU2llbWVucyBBRywgRm91bmRhdGlvbmFsIFRlY2hub2xvZ2llcw0KTGludXggRXhwZXJ0IENl
bnRlcg0KDQo=


