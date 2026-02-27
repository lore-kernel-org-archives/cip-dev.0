Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDEBFEFB47
	for <webhook@archiver.kernel.org>; Fri, 27 Feb 2026 12:20:11 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.5])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.94436.1772194805677492784
 for <cip-dev@lists.cip-project.org>;
 Fri, 27 Feb 2026 04:20:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=zfYmqkuK;
 spf=pass (domain: siemens.com, ip: 40.107.159.5, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DtmE+Ez5kiR5CmEO/h/3dM/xwp+RVkxUzgRG/tHmcuzJIfWzIp27mNlSS10L/HZKhT3zf+6YKLaEqDGR88SErKEPiADowo1ewLeOy0LN5lKqT69xOeTO2s+QOH0rbuQm1S/XpJzX9JdmqXJexK3vMQLE8NFYNKCpoxc7tqSKZXngRaXh31q4a7sh+kFy/+0vf/rVTEoyOPBXjL8rQynczkOr5ri0qT/ynveWykeh0HcMLpV4HC9u7FDQpFwH32KKf4PaRx/VHfCexcCI3Rmf1LIU3cnQeU3fRHCg8+XdONu/ftFe3t2GHQ2PP+mQ/s5r7CiVkKpvRD1ZR4SXExGpvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0OP/fZGZn5CjcmCFpVLMK8pK6uja9TgfreYREltGyIk=;
 b=RLdEtoYTxqhAVCC4WgItG9p83Mwy007Kkj0UVkzpckBOiuEtUtCiUDJ2Uq2DQ9P6ix1YRNQOdthxJuQonPXlJ3j1OxPD+x0F+uLtDeh6HNnkqcAl0WC+SjWaKDM+jDa0mesI71xr5lRwuXVrJi+KxqkQYaxS412MZCCUpp5sNUGk9qDByDvEFdBa4BCPEbfxjF2CID7p/X/zfyHeWhWE7ArIRFHLHb0iEZeQ2S34JwH7INCmBF0nBhzEi9lRLRETKxNiFQwLbUe7s1ims3EDHwoGZEWDVpycPdExgId+pUSPPy4FtzCoGdbWo9UhNb+g3MgR6CvMaumyzp2BpUI9JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OP/fZGZn5CjcmCFpVLMK8pK6uja9TgfreYREltGyIk=;
 b=zfYmqkuKqbGq1nCrnJZa2eNB+nkO1mF9v8f1pO+cdsTj7l015K6thRBRWWQmZ/XFnxIvrKH9XiefTSw3moWgUEqqV58nbfZDhXOf29OT5H2sD6S5ZmoYOfsHDf16cAmz5Y85QsZE1glAm6/MJsRxSadWYPskvZP1XdvTqaWi+xY9CYsvH+ZPe+KzgozZIPACCWPssZo74dxhh4foG/96PM8aJRfu+3Vuxcb7eOokdviNifiUdEbm2wK+SE0REnRpAx9Dp1WcxFsv18qL7XT2qIfTRBd/+8oT+yg8AMahUQryXJimhrjQoCr+mHB8qD/27nW48bYIYWQFUTM4VUijKQ==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by AS2PR10MB6997.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:59b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Fri, 27 Feb
 2026 12:20:01 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9412:cd7f:3f72:92ab]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9412:cd7f:3f72:92ab%3]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 12:20:01 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "Heinisch, Alexander" <alexander.heinisch@siemens.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Gylstorff, Quirin" <quirin.gylstorff@siemens.com>
Subject: Re: [cip-dev] [isar-cip-core][PATCH 2/2] wic: Wipe LUKS2 header of
 rootfs-B on bmaptool copy
Thread-Topic: [cip-dev] [isar-cip-core][PATCH 2/2] wic: Wipe LUKS2 header of
 rootfs-B on bmaptool copy
Thread-Index: AQHcpzo89p9vUi1JwUGYO9XcZQMamrWWeFQA
Date: Fri, 27 Feb 2026 12:20:01 +0000
Message-ID: <e58b7fe3999ee8ffa337e956542243dd3ae0bbfc.camel@siemens.com>
References: <20260226160837.1107096-1-alexander.heinisch@siemens.com>
	 <20260226160837.1107096-3-alexander.heinisch@siemens.com>
In-Reply-To: <20260226160837.1107096-3-alexander.heinisch@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-8 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|AS2PR10MB6997:EE_
x-ms-office365-filtering-correlation-id: 8153bd1c-3ec8-4e74-4976-08de75fa87a1
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700021;
x-microsoft-antispam-message-info: 
 bVr19wLLARAlrUO8p2Xlw9++6I4YOcQs9SOkOLd740aqBDKk8/44PwfU1iODggDoDKA3ZyTYS9jA3LeD++cLLlEevZh7vjjGU1ATYbjMESQD7509wPpDv2ytR/sFnbSDUJYDdSTLuTet5z3oXlZjdln6DSw5/vzAHpCKqim0XxDpOYpg2rln0uVB7tvI4Fjh+pCBTctkbCFErb78d6/dr9DTHWoiDMPc4V5TQzWOTKDCatXvRFsiMwqXQkwATs5KBWQlzpxD+z+BM8qy1yHJgP522zCz6KySfcnxdx9MQRMmNBSdsTE+uri3rD8bnXD5PQ/GonbMeuKIPIatiANP7YEmsf4+hVO5Uke26XknvG+qTWvLGMxBHMqZUku5KPFTDnnK3+3WpgSQHmVgIY3Hs13Do1XMy1fI5zRjauIZv/UxluPqefOt8PrRuRkF1mhEfBEL9Pq8d8NEpaKH+kR4rhClcINPeeiNmdmZp/pMKEVvbHD+VH/IMzE2WXdHbdrgBW48zl1RBDecA481dvBML1CA70cQEBrkVenh0SHGA1AQgFs2nwBmZCG4weMirCOaFZyQc6kx/aRsYUnDISihqlU502JJPSeDrm7VlpGyU0rrQDG+e/fLtguo653TIdgGwVOR7uPpz6sB6YopNtNjER+y7Md4qMmbR+WsJDu/jsiOToEPWftmc+aF/JiQUZHXyxWEi2/5ZSGuvIpOiNAeBeYpYbnYtq4hKvnCKXbUEFQ9Euycr059FLMfnF3FxqQiYi919BWTZP35Yrpb8xKmJY1pjRfECjVjIw1UIewLd7c=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VU5xOWZKNkdPSElNVkYyV2xMa2trVk1IWWZ1dEhmUEpCYnlIYWdlU1M0cUUx?=
 =?utf-8?B?UzdBTVByWndDMXplcWNrTElFc1pzOU9uanVUdzhDNTZSbStPTDdFZXd0U0dt?=
 =?utf-8?B?bXIvQTg4dlFQTlVuUURCUmZiS1RGbHJSQXQ4Rng5c3p1YlNnb1VnSU1laHVU?=
 =?utf-8?B?MmI5d1MwRmlYTTVCeHl2QmdaamxxeklHRmdER2pVbHFrSTRyVWx4Sk5TbjZS?=
 =?utf-8?B?dFdDRU42NWUrSzNQM3VzQmZJdHROYmwvSE1rOUFCdFZVWnY5dU5XekVSbFEx?=
 =?utf-8?B?TEN1bkQxYnVNbXg1M0wyY2FHUlVhNmRhZno0bzdGKytOQWp1UTZWN2QxTFNZ?=
 =?utf-8?B?R3RCYlg5Y2VtTEpLNktra1JhMUMvbzFMbXgvOWxxL09rR281N3VISEh6YWV3?=
 =?utf-8?B?RTZzRWVzMjIrT3NFTjVERXQ5eHdaYUVUSmJTWHU0RWZPc2N0QTFlMEtiNDYy?=
 =?utf-8?B?cVhCRXFSN0tpblFWNzA1ZFE2ZStrdHVTSTAxODJUSitQNzZsb3IyNnBSMnBV?=
 =?utf-8?B?TzhIK2l6bElCTmo1T2dmaGsyaW9wN0xDdVNZTEtndm5lRXR5emtlNStvcGkx?=
 =?utf-8?B?aWV6VGxDbGtUZDRaQ3I5aVE4dnBwK1ZyRW1pTHhXUTZkUW1DeVdpSDd4SHZh?=
 =?utf-8?B?SnhTY0FuMXNNVlArYmlFanVhSS9rb0h4OGlUZVJhODBTVFNlUzVYS2VzeHBJ?=
 =?utf-8?B?dEtRdDRWZ1JJNFBJaVdXaVBjSkxoTEVYSkQydENYVEV3M0JsVFM2MkdGb0lw?=
 =?utf-8?B?TjhyWUI5Rk8wL3gwNTFFQmwyWkxtcUxRQUprWkNxWk1VaDVXSTdRMFBMRnc2?=
 =?utf-8?B?ZHExUkV6SVBUSitrM3ZXVEpPRU9EOVpsMTR2Vm43bFN2NXJGV0g3a0dWSGZ5?=
 =?utf-8?B?aHI3VnBhYkxzY1BUSGVnTUxjSlhJQWNUOGlZRUtOeXZsYVdSSEN6dDg1K3Vj?=
 =?utf-8?B?bFVKd2dsUGhDZDlNVkJQcEFxSG43dXZsVlVRalpzQnIxZ0pUVnpHU0ljN0Y2?=
 =?utf-8?B?TWJuN3VBRDkvdEhYRUtlN01wY0lwTUVjbTFjWktsS00rSTRPQUJ1bVVtNG01?=
 =?utf-8?B?SFoxMEpDR01JTzg4d1hOYURGbFFYVkRGZk9pNWxrek92aW5FQTlPK0FhMGl4?=
 =?utf-8?B?b1ZCQ0FCMll5WWdKR2VWeEtZSC9kQ0Zra1V6UWkvbU1WQXNJckZSdDhjQ3N5?=
 =?utf-8?B?RWFMWWhaeEhlZFhUYTIyZUNmbytaSG1nUXp0NUpNbEZXa1FxZ09rUENHeWNz?=
 =?utf-8?B?SjJQa25EcXFreGZ2QndGeUJPb3BaS1hyY3MxUDZhZVdiTDlDZkFuelMwVWpa?=
 =?utf-8?B?MHFHdGVZNXRLOGIwQnVFVXAvcWxmaEx6N2s5UDRVT2I3UEVleU1tQTlzZko3?=
 =?utf-8?B?TUVSNGJmUi8wSFlvNDRVT0VYODk0ZGVFc0ZMSDBvK213NmVRUjd1UWxuNFBs?=
 =?utf-8?B?ell0OVEwai9HM3JVWlBINlcrazNhNjVOUExxd1dXZDhWN3dzUmhPcmN5dHd2?=
 =?utf-8?B?R2wzZnhKakYxUHdzSnREUm5yeWpNTVIzNWxSRi9sTVEzUlRjMmQ2TWJndndY?=
 =?utf-8?B?cmRkMFBvTUFoalU2RVpZekREa0RXUldpczZnbk5ITGR1WkQ3eER4YktwQ1g1?=
 =?utf-8?B?Y0FkcGFHNGFHd0J3ZnlIUnltTVFNWXlHQ0xkZTZ0eWZCelZSdGtub0NJVlFi?=
 =?utf-8?B?N1ZWeXVyYVVPQ3F2ajVPSCtlMFo4bmhGV1dhU2kzSUhaNGV6ZGJPTjl6NGRm?=
 =?utf-8?B?SHh5WThobVQrNmpMQ3RXRnFnQlpQTGVyTzNlY1JZRkQrempOQlZiWnowcFU3?=
 =?utf-8?B?S1N6dEFtb0F5NGs1c25SUDg1bUpLbXcyOGZVR3c5RVRubXJDdHRudWxwZE1K?=
 =?utf-8?B?ZldDQ25WbS9VNENST3hEQ0wvS3JpQlBKbUllSk1FQVhDLzFnY2RLRTRmaVd3?=
 =?utf-8?B?YVEyRXZDWm1ZUDROSUdzdFo5ampGUUdJVnZYYytGUWFWL0Y1TGw0RzBYbGd3?=
 =?utf-8?B?L2s0bHA0cURkbEJUYWovS2U1Z1l2WXlZRWRmRDFtbXprZGsxODQxNldUemhl?=
 =?utf-8?B?REFRaVJYZnB3NTQ2WURsT2hXOTJvMGJ1QitJL3VRZnVMc0Fmc3hkWGtyRWRw?=
 =?utf-8?B?QVA0SGZaNFpYRTE1NW1FTXJXMVd3a0IrTTFZVENHcWR3N0hzUWl2bXpwNDhH?=
 =?utf-8?B?RzZ1T3ZvTERMR01BYlVjQUROc2dsQ1RiUXVTbDAwREVJMWhWaHN4bkZMZkE3?=
 =?utf-8?B?Q04rWmp3VW5DaFVDN01tamJOTGlDNjVUaS9oc1VkbFJCTU9sVEovME5qNWVz?=
 =?utf-8?B?Ky80Z0djUEZUNElMQUQxUXI1bWhaVHRSbmdLT2tKK0Z2UU9uTTZsRjUza3dp?=
 =?utf-8?Q?4GImCu7758zazRzbRU2BSIB0BFb6c3JNeGoyC/SGA3Fd0?=
x-ms-exchange-antispam-messagedata-1: 
 4R2E4x1zdeXc7QwTmXDumUGverEBVhI6zcmpX7iwJknmDL6V4UdbQ7Mu
Content-Type: text/plain; charset="utf-8"
Content-ID: <70E6C0E2FC12014598986CFD874F51CB@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8153bd1c-3ec8-4e74-4976-08de75fa87a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 12:20:01.0334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZRn4Bd+zlmwCWhT/mFVMLSmHOPpTypNvsk3vKOmIZ7DN3mxOoLhQEcKdVx9VUQ/qOOZQgDhB7sBHUp+8nhjH2hku2wNOjKy66N4h3zBU6rQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6997
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Feb 2026 12:20:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22029

T24gVGh1LCAyMDI2LTAyLTI2IGF0IDE3OjA4ICswMTAwLCBIZWluaXNjaCwgQWxleGFuZGVyIHZp
YSBsaXN0cy5jaXAtDQpwcm9qZWN0Lm9yZyB3cm90ZToNCj4gRnJvbTogQWxleGFuZGVyIEhlaW5p
c2NoIDxhbGV4YW5kZXIuaGVpbmlzY2hAc2llbWVucy5jb20+DQo+IA0KPiBUbyBjb3B5IGltYWdl
cyBgYm1hcHRvb2wgY29weWAgdXNlcyBhIGJtYXAgZmlsZSB0aGF0IG1hcHMgcmVnaW9ucw0KPiB0
aGF0IGFjdHVhbGx5IGhvbGQgZGF0YS4gVGhhdCBtZWFucyBlbXB0eSByZWdpb25zIC8gaG9sZXMg
aW4gdGhlIGZpbGUNCj4gYXJlIHNraXBwZWQgYnkgdGhlIHRvb2wgYW5kIHRodXMgdGhvc2UgcmVn
aW9ucyBvbiB0aGUgZGlzayBkbyBub3QNCj4gY2hhbmdlLiAtIFRoYXQncyBhY3R1YWxseSB0aGUg
ZmVhdHVyZSB3aHkgYm1hcHRvb2xzIGV4aXN0cy4NCj4gDQo+IFdoZW4gcmVpbnN0YWxsaW5nIGFu
IGltYWdlIGNvbmZpZ3VyZWQgdG8gdXNlIEEvQi1yb290ZnMgYW5kIGRpc2sgZW5jcnlwdGlvbg0K
PiB0aGF0IHdheSwgdGhpcyByZXN1bHRzIGluIGEgTFVLUzIgaGVhZGVyIGNyZWF0ZWQgZm9yIHJv
b3Rmcy1CIGR1cmluZw0KPiBkaXNrIGVuY3J5cHRpb24gc2V0dXAgb2YgdGhlIHByZXZpb3VzIGlu
c3RhbGxhdGlvbiB0byByZW1haW4gb24gdGhlIHRhcmdldC4NCj4gDQo+IFRoZSBMVUtTMiBoZWFk
ZXIgZm9yIHJvb3Rmcy1BIGdldHMgb3ZlcndyaXR0ZW4gcHJvcGVybHksIGFzIHRoYXQgcmFuZ2UN
Cj4gYWN0dWFsbHkgY29udGFpbnMgZmlsZXN5c3RlbSBpbmZvcm1hdGlvbiBmb3Igc3F1YXNoZnMg
b3IgZXJvZnMpLg0KPiANCj4gT24gYm9vdCB0aGUgaW5pdHJhbWZzLWNyeXB0LWhvb2sgc2V0cyB1
cCBkaXNrIGVuY3J5cHRpb24gZm9yIHJvb3Rmcy1BIGFuZA0KPiBldmljdHMgdGhlIG9sZCBoYW5k
bGUgc3RpbGwgaW4gdXNlIGZvciByb290ZnMtQiBpbiB0aGUgVFBNLCB0aHVzLCBtb3VudGluZw0K
PiB0aGUgb2xkIExVS1MyIGVuY3J5cHRlZCByb290ZnMtQiBpbiBsb2NhbC1ib3R0b20gZmFpbHMu
DQoNCkhpLCBub3QgZGlyZWN0bHkgcmVsYXRlZCB0byB0aGUgcGF0Y2gsIGJ1dCB3aGVuIGV4YWN0
bHkgaXMgdGhlIGhhbmRsZQ0KZXZpY3RlZD8gV2hpbGUgd2UgYXJlIHN0aWxsIGluIGluaXRyZCwg
d2UgaGF2ZSBubyBjb25maXJtYXRpb24gdGhhdCB0aGUNCnVwZGF0ZSBhY3R1YWxseSB3YXMgc3Vj
Y2Vzc2Z1bC4gRG9lcyB0aGlzIG1lYW4sIHRoZSByb290ZnMtYiBjYW5ub3QgYmUNCmJvb3RlZCBh
bnltb3JlIGFmdGVyIHdlIHBhc3MgdGhpcyBpbml0cmQgc3RlcCBpbiByb290ZnMtYT8gVGhhdCB3
b3VsZA0KYmUgYSBtYWpvciBkZXNpZ24gZmxhdy4NCg0KPiANCj4gQnkgc2V0dGluZyB0aGUgc291
cmNlcGFyYW0gc2l6ZT01TSB3ZSBlbnN1cmUgdGhhdCB0aGUgZmlyc3QgNU1CIG9mIHRoZSBwYXJ0
aXRpb24NCj4gYWN0dWFsbHkgZ2V0cyBvdmVyd3JpdHRlbi4gQXMgdGhlcmUgYXJlIGFjdHVhbCB6
ZXJvcyBpbiB0aGUgZmlsZSBjb21wYXJlZCB0bw0KPiBob2xlcyBwcmV2aW91c2x5LCB0aGUgYm1h
cCBhbHNvIG1hcHMgdGhvc2UgcmVnaW9ucyBhbmQgb3ZlcndyaXRlcyB0aGVtIG9uIGNvcHkuDQoN
ClRoaXMgY2hhbmdlIGlzIHBlcmZlY3RseSByZWFzb25hYmxlLiBJJ20ganVzdCB3b25kZXJpbmcg
aWYgd2Ugd2FudCB0bw0KbWFrZSB0aGlzIHVuY29uZGl0aW9uYWwgKGFsd2F5cyBvdmVyd3JpdGUg
dGhlIGZpcnN0IDVNQikuIFdyaXRpbmcganVzdA0KNU1CIGlzIGNoZWFwIGFuZCBzaG91bGQgYXZv
aWQgYWxsIGtpbmRzIG9mIGhvbGQtcGFydGl0aW9uLWRhdGEgYnVncy4NCg0KSSdtIGZ1cnRoZXIg
d29uZGVyaW5nIGlmIHRoaXMgYWxzbyBhZmZlY3RzIHRoZSBkZWx0YS11cGRhdGUgY2FzZSwgd2hl
cmUNCnRoZSB1cGRhdGUgaXMgbm90IGEgcGFydGl0aW9uIGJ1dCBhIGZpbGVzeXN0ZW0gKElJUkMp
LCBoZW5jZSB0aGUgd2ljDQpsb2dpYyBpbnRyb2R1Y2VkIGJlbG93IGRvZXMgbm90IGFwcGx5LiBE
b2VzIHRoaXMgbWVhbiB3ZSBuZWVkIHRvIGVpdGhlcg0KbWFwIHRoaXMgcGFydCB3aXRoIHplcm9z
IGFzIHdlbGwsIG9yIGJldHRlciBjYWxsIHdpcGVmcyBwcmlvciB0bw0Kb3ZlcndyaXRpbmcgLyBz
a2lwcGluZyB0aGUgYmxvY2tzPw0KDQo+IA0KPiBXaXRob3V0IGFuIG9mZnNldCBzcGVjaWZpZWQg
KGFzIGluIG91ciBjc2UpIHRoZSBMVUtTIGhlYWRlciBpcyBzdG9yZWQgYXQgdGhlIHN0YXJ0DQo+
IG9mIHRoZSBwYXJ0aXRpb24gYW5kIGhhcyBhIHNpemUgb2YgNGsuDQo+IER1ZSB0byB0aGUgbmF0
dXJlIG9mIExVS1MyIGl0IGlzIGhhcmQgdG8gZGV0ZXJtaW5lIHRoZSBleGFjdCBwb3NpdGlvbiBv
ZiB0aGUNCj4gYmFja3VwIGhlYWRlci4gVGhlcmVmb3JlLCBJIGNob3NlIHRvIHN0YXkgY2xvc2Ug
dG8gdGhlIGFjdHVhbCBjcnlwdHNldHVwDQo+IGltcGxlbWVudGF0aW9uIChhcyBvZiAzYjY3OTRh
MmEzNTgwNTU5YmNiYzNhZDBlNjdhYjQ4MDVmNDhmYTdkKSB0byBkZXJpdmUgZnVydGhlc3QNCj4g
YmFja3VwIGhlYWRlciBsb2NhdGlvbiB3aGljaCBpcyA0TWlCLg0KPiANCj4gVGh1cywgYXMgdGhl
IGRlZmF1bHQgYmxvY2sgc2l6ZSB1c2VkIGluIEVtcHR5UGFydGl0aW9uUGx1Z2luIGlzIDFNQiBj
aG9vc2luZyA1TUIgYXMgYW4NCj4gYWRkaXRpb25hbCB3cml0ZSBvdmVyaGVhZCBzZWVtZWQgcHJv
cHBlci4NCg0KTWFrZXMgc2Vuc2UuDQoNClRoYW5rcyENCg0KRmVsaXgNCg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogQWxleGFuZGVyIEhlaW5pc2NoIDxhbGV4YW5kZXIuaGVpbmlzY2hAc2llbWVucy5j
b20+DQo+IC0tLQ0KPiAga2FzL29wdC9lbmNyeXB0LWFsbC55bWwgfCA3ICsrKysrKysNCj4gIDEg
ZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9rYXMvb3B0
L2VuY3J5cHQtYWxsLnltbCBiL2thcy9vcHQvZW5jcnlwdC1hbGwueW1sDQo+IGluZGV4IGZhZjcy
MDYuLjc5OWY4MDQgMTAwNjQ0DQo+IC0tLSBhL2thcy9vcHQvZW5jcnlwdC1hbGwueW1sDQo+ICsr
KyBiL2thcy9vcHQvZW5jcnlwdC1hbGwueW1sDQo+IEBAIC0yMSwzICsyMSwxMCBAQCBsb2NhbF9j
b25mX2hlYWRlcjoNCj4gICAgICAjIHRvIHNldCBhbGwgcGFydGl0aW9ucw0KPiAgICAgIENSWVBU
X1BBUlRJVElPTlMgPSAiJHtBQlJPT1RGU19QQVJUX1VVSURfQX06OnJlZW5jcnlwdCAke0FCUk9P
VEZTX1BBUlRfVVVJRF9CfTo6cmVlbmNyeXB0IFwNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICB2YXI6L3ZhcjpyZWVuY3J5cHQiDQo+ICsNCj4gKyAgICAjIE9uIHN5c3RlbXMgd2l0aCBkaXNr
IGVuY3J5cHRpb24gZW5hYmxlZCBmb3IgdGhlIHJvb3Rmcywgd2UgbmVlZCB0byBtYWtlIHN1cmUg
dGhhdA0KPiArICAgICMgTFVLUzIgaGVhZGVycyBhbHJlYWR5IHN0b3JlZCBvbiB0aGUgZGlzayBm
cm9tIGEgcHJldmlvdXMgaW5zdGFsbGF0aW9uIGFyZSBwcm9wZXJseQ0KPiArICAgICMgb3Zlcndy
aXR0ZW4gYnkgYGJtYXB0b29sIGNvcHlgLiBCeSBzZXR0aW5nIHRoZSBzb3VyY2VwYXJhbXM9InNp
emU9NU0iIHRoZSBmaXJzdCA1IE1pQg0KPiArICAgICMgb2YgdGhlIHBhcnRpdGlvbiB3aWxsIGJl
IG92ZXJ3cml0dGVuIHdpdGggemVyb3MsIHdoaWNoIGlzIHN1ZmZpY2llbnQgdG8gY292ZXIgdGhl
DQo+ICsgICAgIyBMVUtTMiBoZWFkZXIgKDRrKSBhbmQgdGhlIGJhY2t1cCBoZWFkZXIgKG1heCBv
ZmZzZXQgdXNlZCBieSBjcnlwdHNldHVwID0gNE0pLg0KPiArICAgIEFCUk9PVEZTX1NPVVJDRVBB
UkFNU19COmFwcGVuZDplbmNyeXB0LXBhcnRpdGlvbnMgPSAiIHNpemU9NU0iDQo+IC0tIA0KPiAy
LjQ3LjMNCg0KLS0gDQpTaWVtZW5zIEFHDQpMaW51eCBFeHBlcnQgQ2VudGVyDQpGcmllZHJpY2gt
THVkd2lnLUJhdWVyLVN0ci4gMw0KODU3NDggR2FyY2hpbmcsIEdlcm1hbnkNCg0K

