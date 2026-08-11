Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBF8C5B570
	for <webhook@archiver.kernel.org>; Tue, 11 Aug 2026 06:59:00 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.27])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.48743.1786431538879341483
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Aug 2026 23:58:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ZHAOeAZI;
 spf=pass (domain: siemens.com, ip: 52.101.65.27, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A1DS+rr0g4GaqoNphC9moi+AguegLohclhQKdjNI3PUvObmzT8CuOhu0y/Hlnt8wOWosxxCx7gXFgys0G4uL5LCiLa+pgqwkMW5yvyrDTKbAN3+XEk39+OJ4/JOIySsoToPBYHQynTJz94H2HfHA8Py0c0PBPQMzFrIva7ycoz2j6w2id4qlOI3u6Gw2E2YIgHDqWr3MN+ZOwIKXmYNDbeuBpAdtZhnbNOsIExJYCFwnBGCxyJlAeQhhnZJL0lYcxn6dzi6Tak4m9ux80tk/in864Nmsm+Kk5fguWvJ8gM9G/h+WSWgONJPiPlPD7Zpm0qdnt7s9fvwShighnq+Yog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3tW+F7JrH6xSX9ovSKtMJEBqkHoXOLLoLexEIYkPsI=;
 b=YBMHQXFp7fuHOPVU7RQgqSLiF01Y4ApG3jrWSFk62UYnexI0OTOJl275HcBxHEPNFywZ7yioBKyUZuNZv0v3fCYm9BIrWLfXC+w7YdMIGt7USyVhKjHyks0onqRzOwUPYDeJS7V9HSbdRr8b/6/R1N58CiS2w+bBq8foCHaQtOsla10nB80Yf/vYE58CqEBwTmbERPEIyetAXcsh2KyvsdexqBA2104xK44xDRuUpMDS12xRF+QwdJD0OonemfvFlHda3YVz+NA3PxOKZqsX1NaJb+jcMdM9OyrULnKfpX0oaobKZokZkfFCVPOvDk2X1Z53tNo0uomdl1oT1jMfnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3tW+F7JrH6xSX9ovSKtMJEBqkHoXOLLoLexEIYkPsI=;
 b=ZHAOeAZIgHB51LSWo4pBiMbo40Ul6O+WYAev5Cr7EH5hhzWnYzBihBQLbHbYuvYBUZ12jOKL/rfjSyawxllexusx+ia2t74tSnIRPvdFlaQlfTQGfATrEhY/KNqt1UwxTw5Gkpi+h1UZc/gGRkFHNsMQ2ijH9UT3fqsC+b/K5CkFAbt+gDXXxqmPexNdDIpw/3uWxg0KZ0VOhv4dRXfQlSwtCjOeSkfi8ncQtB/+vbyldip7xOaW1lC3gSyqu0895JNeRoL3puui+hHQThPvXpVlaNJVDvSHpyP8B8GjmMEJvbbT1M6xxm6u+Zd6QLqOpoNRjpWyVjbNDfHyQ3O8tw==
Received: from DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ed::14)
 by DB8PR10MB3242.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 06:58:54 +0000
Received: from DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2339:186:874d:c405]) by DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2339:186:874d:c405%6]) with mapi id 15.21.0315.008; Tue, 11 Aug 2026
 06:58:54 +0000
From: "Heinisch, Alexander" <alexander.heinisch@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"Gylstorff, Quirin" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [isar-cip-core][PATCH 0/2] Remove unsupported combinations for
 factory-reset from Kconfig and document them explicitly
Thread-Topic: [isar-cip-core][PATCH 0/2] Remove unsupported combinations for
 factory-reset from Kconfig and document them explicitly
Thread-Index: AQHdJoO2k7qw2xocSUyik+HCHaPcK7aW3YyAgAA+dACAABcegIAAEhmAgAErfoA=
Date: Tue, 11 Aug 2026 06:58:54 +0000
Message-ID: <caf1c704548f130911b872587c82d15441ff88d0.camel@siemens.com>
References: <20260807154439.625212-1-alexander.heinisch@siemens.com>
		 <31174e6a-78c9-4fce-8d1f-dff403e1f6aa@siemens.com>
		 <b45b4dd0-03cc-4df8-94e5-ca3405e2732b@siemens.com>
		 <4400621d4db82ea3313ff1907d4ef664ca0cdaab.camel@siemens.com>
		 <5eedc605-7ae1-425d-876a-62c183e3a79e@siemens.com>
In-Reply-To: <5eedc605-7ae1-425d-876a-62c183e3a79e@siemens.com>
Accept-Language: en-US, de-AT
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-0+deb13u1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB8045:EE_|DB8PR10MB3242:EE_
x-ms-office365-filtering-correlation-id: 9b92f06e-69d5-4649-3b83-08def7760223
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|22082099003|18002099003|55112099003|11063799006|5023799004|4143699003|6133799003|56012099006|38070700021|10067099003;
x-microsoft-antispam-message-info: 
 xOdL9T8S24QuzQU+8mDLwsrtezjQnqY2L42xybC0U4JqYbv/0/uVJjM7Zesm++5Z1QsJMwqJu6YBLJx9FKO0Fe2tKKn54fIw9Udu7Xgt7dJWQVqi1SgBNH8S7oYimrRDoJky4HVmR3JTtJiMmk1TwYTAmyd6R9kmp9JY7l5WQnjuhLgC+binI+SaBelYvxIWfr/ZFWMnqZpEVrQxNfbrqdSxWFeL+Fh3SST+050SjK6kBf+Jz1HhaqP0pUBsFCLbjSBF+KoAzaYkHixfY9MuAyvaDhrPqtmhywjPsYTYQGZQ0Z2yowEji1yqUHlb42fg+HHv/ddagirpr2gf47q6Ex0g+PbikIWVxbeG/OFfanbFnSFxMQNjMXCMQtV3Is/5wvP2QpHdcYuHZZ44bk4DxBJqhMc4LnECkiqGnESHnGXbIiar9iwp2gf4Q5lWPAd85iLooWDIR6ftp5sYtzZm7GC5GDQGOccLmf9bkUMlrY3DQMk2w2zGT7F4ifWKV7QyHVDEiobAQHVvfwfejRaMvTXkQ5C/he6Mlruzh2PODBqXQvCfHtkxCMvR405j7RFsZJQpPtYzidwdf7Sk55yR1BDGxKOjxQhNjPutd8ZhXbTFtBfV+wfV7o/I6uPS4ny940eXjmiqvsvDTudHQpZUY9vPOjxr//2Qp+VmwMjdGJ0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(55112099003)(11063799006)(5023799004)(4143699003)(6133799003)(56012099006)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UHJuMHMrcmF6YmN6cXg5aS9yMmZCNDRoNU1kRFh1QlNNeEpYUTlTYmlDa1Y2?=
 =?utf-8?B?VXlMTHZRMWQ4LzJ0eU0ybjFmYTRxU0lOTHpjblZZNUZWUjNjZ2FaM1p1UVoz?=
 =?utf-8?B?MGNwRUZ5TTFGMEZUcDFDTk13K0c3RFlMblA2NC9Icm41QzREWDdiQ2w3UHNQ?=
 =?utf-8?B?ak9Ibnp5SUdUcGMxVGtVTkJOSkFldEsvRi8vTVlxWGo4RzJrMFNMcEt0NG5D?=
 =?utf-8?B?d2FXTUVGZERqRFl6ays5eHBDOTh0NDM5TTdJM05laTNUcmx6b0tMVTM1bmZz?=
 =?utf-8?B?aFJQRjRZL0NHems4VCtsclJ5WFBXMHNqMFVyMzdLUENWbkdtRyswQWtqSHAx?=
 =?utf-8?B?eCtSTHI2TUoxcHN6UHo5RzhlRFpTNmtOT09ZekZNNlVVdG43SWRQL0JSSU1P?=
 =?utf-8?B?TEpCQ0xlVlFUUXM1TjhtY1dsTXR4aEpKVnZLN0xKelRCVzZNeTJZZ0NXWStD?=
 =?utf-8?B?UzBCbDRVVk1Wd1pXYlFiQUtWK29QYnFXdDBSMkZUV3lLYkkxVElFd1A4VHhW?=
 =?utf-8?B?VDJaRStJdWdCTzI4MHJCTXZkTXVyRFVnQzA5b3RLeWwyeGw2cm5mU3BxSmFR?=
 =?utf-8?B?Vmg1RlpUOGJSUXVGYzI1VGlCaDBSMUJQYy9FR1RJWVpWQUV2aDRCRktaY2Qw?=
 =?utf-8?B?QjV0aDhGWVBnTTVzdmo1TzBWNVYybEtTWUhmZ25OaEZydWN6Y1hhUjNFRU1J?=
 =?utf-8?B?VGlQQkVWeTJLNnJqY2hGdmtxNWdLNm1ENkVPZXdCUTlPSmFnVUtkYWNyQXlW?=
 =?utf-8?B?bnc2VGE4OFZSeG5IdUxGVWlvQm5RRXlUYStOaVBsN2ltNXRlTnVndUNieVlX?=
 =?utf-8?B?bk9xL0U4aldWUUl6OFVDazNSWUJEbnZWV2UxdU1JNmhKOW8xQWRCN1U3eEdX?=
 =?utf-8?B?Rkk2VXpSdFZUTktPRHZkRFZVWTQwUkMyZWl2RmhWMjB1TllYWEtRNk90dmlu?=
 =?utf-8?B?dW5LOG5zL3FSQ3VmcHJrY2NtMGJINWZrS3MxczJRRmo1RStVYUNid3cxa2pu?=
 =?utf-8?B?M1hHeW9OSDRtN0JoUVFGN09SaGY3YlE0dEdpWm1RR1lUV0ZvTWp4dVgvazRM?=
 =?utf-8?B?bWNjczRJWWptQ1Urc1JFNHdiN0FDcnZPOWV3eHV3UXEwZWZEY00wdXM3USs1?=
 =?utf-8?B?ZjRjWk43VnJIcjMrVnlzVWZHejBKUTJtNUZXemRzY1AwSVNRZTNnbTJ4M0k1?=
 =?utf-8?B?d1Azb0YyckdNK3BRenZIWDR4Nk5lV01HWk5aSGN1REtNQzkwTlBkeEl5VzZU?=
 =?utf-8?B?V21SUDNKcjFBTVlWT2E1TlRHZ3NlRk80RytLNGhvR0E1cEwwb3BCTU9IRHZR?=
 =?utf-8?B?YmZpcms1RkZ6eEdFMDdnVHZkNFRJdFVXb3VUVlBlcTRVUXBKT3hLZUhtaUg1?=
 =?utf-8?B?eERGYVR6cjJvK3ZEUU14ZGZNTjBmSXhGSFNNV1pwZk9YSGs5Q3cyUzRhNGxR?=
 =?utf-8?B?Nk8xbWM4UjV4VFk0Y09xK0toZDcvTkt1MnIwYmg1RysxTERzeXV3TWZndERN?=
 =?utf-8?B?ZWFBc1Q3dVRVVTAzMjRoMy8vQUVPcCsvTms3dUZ5cG1HNHFYVzV2Vko4T1g0?=
 =?utf-8?B?TG5jVHlGY0d3MDFXem83U3BvMXk0NGgxQkp4Rmk0TDc3UXozSHRnYkZvVEtQ?=
 =?utf-8?B?R0RxT0VBanlYK0VwSG9uVlZQd1FGVE8wbi9sdWd4b016eStvakdjODlmeFho?=
 =?utf-8?B?RmVnTUd6ZnhJaTl3L3JwNitwKzVVQ0pQaE5tSEFzVmV5TmFDY1V5WW04K1ps?=
 =?utf-8?B?VkFsRHVteFVPaXN5STk4UXNjbzNvL2RQR0FPQXMyUC9vYjI1L0tYbHJnaHhQ?=
 =?utf-8?B?bXp1MHpVL0hVem14Z0ZpMHExYTVVZS8zdHZwenlLUGlxZUNFNWdvQXRFcmJG?=
 =?utf-8?B?ZDJKNEpiU2FUejRRMWVtVk9mc3pUK3VwOGc4Z1AzMXdSeVYzZEVoK3dvRS9n?=
 =?utf-8?B?Z0RBdE5OT3c4cVEwd0IxZWM4dW5RRmdoc3BtOHRPRnJTcDJHbmhnRTFYanYx?=
 =?utf-8?B?TnNHMkg4OVB4cnhrMldLUjVUMFQ3TG9BUStDK0NxbkFxdnlvYnkvald3ZTR2?=
 =?utf-8?B?bVllcjNzelNlV3BqekxvUityb1ZTWFFPdnVPTjZic3dFZmQ3VkduL1BHSEZ2?=
 =?utf-8?B?Y0M3bHJLdE1BTGZ4M2E3bGswNHlSOHRCK3dCUXltS2V6OTVQdVRBSTFVWVZH?=
 =?utf-8?B?S0ZTQ1dDM0tyK3puVFdHVE5PdGc5OGVjRGRlOWVBdW1BMmFDU2dpYm1BQkV0?=
 =?utf-8?B?ME5ZNllkLy9XOVltZFBqQmpiUGZYSnVWblZjdk50Nk1Mbzk2bWJEMUxLU0tr?=
 =?utf-8?B?NmxvZGliWUoxZU9MOTBGWWdYc1A0enRaZXVFcHJXNnlVazZFOGV4S1QrZWZl?=
 =?utf-8?Q?F6Q+K8JQ2oHNJI/VrBdQqPakxBQsT23l7WuQx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <560DE1C288A9BE43B396BF716AD3993C@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b92f06e-69d5-4649-3b83-08def7760223
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 06:58:54.7173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1z1MltGimZajZx8BFeWSdHyYOpkkzu+L+nN2lNXRv4kso+yVZZbtr2SQaCvX+HLFIidiK87ULKNFZuMFUCEtEE9Psb35U0KKD7dccNnJ8PA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3242
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Aug 2026 06:59:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23889

T24gTW9uLCAyMDI2LTA4LTEwIGF0IDE1OjA2ICswMjAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAxMC4wOC4yNiAxNDowMiwgSGVpbmlzY2gsIEFsZXhhbmRlciAoRlQgUlBEIENFRCBTRVMtQVQp
IHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAyNi0wOC0xMCBhdCAxMjozOSArMDIwMCwgSmFuIEtpc3pr
YSB3cm90ZToNCj4gPiA+IE9uIDEwLjA4LjI2IDA4OjU1LCBRdWlyaW4gR3lsc3RvcmZmIHdyb3Rl
Og0KPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IE9uIDgvNy8yNiA1OjQ0IFBNLCBhbGV4YW5k
ZXIuaGVpbmlzY2hAc2llbWVucy5jb23CoHdyb3RlOg0KPiA+ID4gPiA+IEZyb206IEFsZXhhbmRl
ciBIZWluaXNjaCA8YWxleGFuZGVyLmhlaW5pc2NoQHNpZW1lbnMuY29tPg0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IEJ5IGRlZmF1bHQgZmFjdG9yeSByZXNldCBjbGVhcnMgdGhlIHRwbS4gVGhlcmVm
b3JlLCBrZXlzDQo+ID4gPiA+ID4gbmVlZGVkDQo+ID4gPiA+ID4gdG8NCj4gPiA+ID4gPiBkZWNy
eXB0IHRoZSBpbW11dGFibGUgQS9CIHJvb3RmcyBpbiBmdWxsIGRpc2sgZW5jcnlwdGlvbg0KPiA+
ID4gPiA+IHNldHVwcw0KPiA+ID4gPiA+IGNhbm5vdCBiZSByZXRyaWV2ZWQgYW55bW9yZS4gVGh1
cywgdGhlIGJvb3QgZmFpbHMgYW5kIHRoZQ0KPiA+ID4gPiA+IGRldmljZQ0KPiA+ID4gPiA+IGNh
bm5vdCBiZSByZWNvdmVyZWQuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gVGhpcyBwYXRjaCBzZXJp
ZXMgcmVtb3ZlcyBzdWNoIGNvbWJpbmF0aW9uIGZyb20gdGhlIGtjb25maWcNCj4gPiA+ID4gPiBh
bmQNCj4gPiA+ID4gPiBkb2N1bWVudHMNCj4gPiA+ID4gPiB0aGUgaXNzdWUgZXhwbGljaXRseS4N
Cj4gPiA+ID4gDQo+ID4gPiA+IFRoaXMgd2FzIG5ldmVyIGluIHNjb3BlIG9mIHRoZSBmYWN0b3J5
IHJlc2V0LiBZb3UgY291bGQNCj4gPiA+ID4gaW1wbGVtZW50DQo+ID4gDQo+ID4gUHJvYmFibHks
IGJ1dCBpdCB3YXMgcGFydCBvZiB0aGUgY29uZmlndXJhdGlvbiBvcHRpb25zLiBJbW8sIHRob3Nl
DQo+ID4gc2hhbGwgc2VydmUgYXMgYSBkZW1vIGZvciBpc2FyLWNpcC1jb3JlIGZ1bmN0aW9uYWxp
dHksIGFuZCBvbmx5DQo+ID4gaW5jbHVkZQ0KPiA+IHZhbGlkL3N1cHBvcnRlZCBzY2VuYXJpb3Mu
DQo+ID4gDQo+ID4gPiA+IGl0IGJ5DQo+ID4gPiA+IG1vdmluZyB0aGUga2V5cyBpbnRvIHRoZSBi
b290IHBhcnRpdGlvbi4gQnV0IHRoaXMgbW92ZSB3aWxsDQo+ID4gPiA+IGNyZWF0ZQ0KPiA+ID4g
PiBhbm90aGVyIGNhbiBvZiB3b3Jtcy4NCj4gPiANCj4gPiBUZW1wb3JhcmlseSBtb3ZpbmcgdGhl
IGtleXMgdG8gYm9vdCBwYXJ0aXRpb24sIGlzIG5vdCBhbiBvcHRpb24uDQo+ID4gSG93IGFyZSB0
aGV5IHNlY3VyZWQgdGhlcmU/DQo+ID4gDQo+ID4gQSByZWVuY3J5cHQgd2l0aCBuZXcga2V5cyBz
dG9yZWQgaW4gVFBNIGFmdGVyIFRQTSBjbGVhcmluZyBvZiB0aGUNCj4gPiBwYXJ0aXRpb25zIGhv
bGRpbmcgdGhlIHJvb3RmcyBhZnRlciB0aGV5IGdvdCB1bnNlYWxlZCBjb3VsZCBiZSBhbg0KPiA+
IG9wdGlvbi4gQnV0IHllcywgdGhhdCBpbXBsaWVzIG1ham9yIHJld29yayBvZiB0aGUgZmFjdG9y
eS1yZXNldA0KPiA+IHdvcmtmbG93IGluIGluaXRyYW1mcyBhbmQgcG90ZW50aWFsbHkgaGFzIHNp
ZGUgZWZmZWN0cyAvDQo+ID4gZGVwZW5kZW5jaWVzDQo+ID4gb24gY3J5cHQgaG9vayBsb2NhbC10
b3AuIEFuZCB5ZXMsIHRoZXJlIG1heSBiZSBhIHNtYWxsIGNoYW5jZSB0bw0KPiA+IGJyaWNrDQo+
ID4gdGhlIGRldmljZSB3aGVuIHRoZSBkZXZpY2UgcG93ZXJjeWNsZXMgYXQgdGhlIHdyb25nIHRp
bWUuDQo+ID4gRWxzZSwgYSBtb3JlIGdyYWNlZnVsIHJlbW92YWwgb2Yga2V5cyBmcm9tIFRQTSBj
b3VsZCBhbHNvIGJlIGFuDQo+ID4gb3B0aW9uLg0KPiA+IA0KPiA+IEFsbCB0aGluZ3MsIHdlIG5l
ZWQgdG8gdGhpbmsgYWJvdXQgaW4gbXVjaCBtb3JlIGRldGFpbCwgYWxzbw0KPiA+IGNvbnNpZGVy
aW5nIHRoZSBudW1iZXIgb2YgdXNlIGNhc2VzIGZvciBhIHRydWUgZmFjdG9yeSByZXNldA0KPiA+
IHN1cHBvcnQNCj4gPiB3aXRoIGZ1bGwgZGlzayBlbmNyeXB0aW9uIGluIHBsYWNlLg0KPiA+IA0K
PiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gV2UgYWxyZWFkeSBoYXZlIGFuIG9wdGlvbiB0byBza2lw
IFRQTSByZXNldCBpZiBub3QgZGVzaXJlZCBvcg0KPiA+ID4gcHJvYmxlbWF0aWMuIFdoeSBub3Qg
dXNlIHRoYXQsIG9yIGJ1aWxkIHNtYXJ0ZXIgb24gdG9wIG9mIGl0Pw0KPiA+IA0KPiA+IFllcyzC
oHRoZXJlIGlzIGFuIG9wdGlvbiB0byBieXBhc3MgVFBNIGNsZWFyaW5nLiBUaGF0J3MgYWxzbw0K
PiA+IGRvY3VtZW50ZWQuDQo+ID4gDQo+ID4gVGhlIHBhdGNoc2V0IGlzIG9ubHkgYWJvdXQgdG8g
ZG9jdW1lbnQgdGhhdCB0aGUgZGVmYXVsdCBmYWN0b3J5LQ0KPiA+IHJlc2V0DQo+ID4gY29uZmln
IGRvZXMgbm90IHN1cHBvcnQgZnVsbCBkaXNrIGVuY3J5cHRpb24gc2V0dXBzIGFuZCBub3QgdG8N
Cj4gPiBvZmZlciBhDQo+ID4gZGVtbyBjb25maWcgb3B0aW9uIGZvciB0aGlzIG5vbi1zdXBwb3J0
ZWQgY2FzZS4NCj4gPiANCj4gPiA+IA0KPiA+ID4gRmFjdG9yeSByZXNldCBoYXMgYWxyZWFkeSB3
YXkgdG9vIG1hbnkgbGltaXRhdGlvbnMuIEkgd291bGQNCj4gPiA+IHJhdGhlcg0KPiA+ID4gbGlr
dG8NCj4gPiA+IHdvcmsgaW4gbW9yZSBjYXNlcyB0aGFuIGluIGxlc3MuDQo+ID4gDQo+ID4gV2l0
aG91dCBtYWpvciByZXdvcmssIHRoZSBvbmx5IG9wdGlvbiBpcyB0byBkaXNhYmxlIFRQTS1jbGVh
cmluZw0KPiA+IGZvcg0KPiA+IGZhY3RvcnktcmVzZXQgaW4gRkRFIHNldHVwcywgYnV0IHRoYXQg
aGlkZXMgdGhlIGZhY3QsIHRoYXQgaXQgaXMgbm8NCj4gPiBjb21wbGV0ZSBmYWN0b3J5IHJlc2V0
LiBTbyBlaXRoZXIgS2NvbmZpZyBzaGFsbCBiZSBleHBsaWNpdCBhYm91dA0KPiA+IHRoYXQsDQo+
ID4gb3Igbm90IG9mZmVyIHRoZSBvcHRpb24gZm9yIEZERSArIGZhY3RvcnktcmVzZXQgYXQgYWxs
ICh3aGF0IEkNCj4gPiBkaWQpLg0KPiA+IA0KPiANCj4gUmVzZXR0aW5nIHRoZSBUUE0gaXMgdGhl
IHBvb3ItbWFuJ3MgYXBwcm9hY2ggdG8gZmFjdG9yeSByZXNldCBhbnl3YXkuDQpZZXMsIGJ1dCB3
aXRob3V0IFRQTSByZXNldCBjdXJyZW50IGRpc2sgd2lwaW5nIHN0cmF0ZWd5IGlzIHRvIHdlYWsu
DQoNCj4gSXQNCj4gaXMgbm90IG5lZWRlZCB0byByZXNldCB0aGUgZGlzayBlbmNyeXB0aW9uIGtl
eXMsIGFsc28gZm9yIHRoZSBkYXRhDQo+IHBhcnRpdGlvbiwgYW5kIHdlIGFyZSBzbyBmYXIgdG9v
IGxhenkgdG8gaWRlbnRpZnkgYW5kIGRlbGV0ZSBvdGhlcg0KPiByZXNvdXJjZXMgaW4gdGhlIFRQ
TSBpbiBhIG1vcmUgdGFyZ2V0ZWQgbWFubmVyLiBPciB3YXMgdGhlcmUgYW55dGhpbmcNCj4gdGVj
aG5pY2FsbHkgcHJldmVudGluZyBhbiAiYWxsLW9iamVjdHMtZXhjZXB0LWZvciIgVFBNIHJlc2V0
Pw0KPiANCg0KSXMgaXQgYSByZXNldCBzbyBvbmUgY2FuIGhhbmQgb2ZmIHRoZSBkZXZpY2UgdG8g
c29tZW9uZSBlbHNlPyBJcyBpdCBhDQpyZXNldCBzbyBzYW1lIGN1c3RvbWVyIGNhbiBzdGFydCBv
dmVyIGFnYWluIGNsZWFubHk/IE9yIGlzIGl0IGENCmRlY29tbWlzc2lvbmluZyB3aXRob3V0IGRl
dmljZSByZXVzZT8NCg0KQ3VycmVudGx5LCB0aGUga2V5IGV4cG9zdXJlIGlzIG5vdCBsaW1pdGVk
IHRvIHRoZSBpbml0cmFtZnMgaG9vaw0KaW1wbGVtZW50aW5nIHRoZSBjcnlwdCBzZXR1cC4gU28g
ZGVwZW5kaW5nIG9uIHRoZSBzeXN0ZW0sIHVzZXJzIG1heQ0KcmV0cmlldmUgdGhlIGtleXMgb2Yg
dGhlaXIgc3lzdGVtLiBJZiBzdWNoIGRldmljZSBpcyByZWN5Y2xlZCBhbmQNCnBvdGVudGlhbGx5
IHNoaXBwZWQgdG8gYW5vdGhlciBjdXN0b21lciwgZWl0aGVyIGEga2V5IGV4Y2hhbmdlIGZvciB0
aGUNCmRpc2sgZW5jcnlwdGlvbiBpcyBuZWVkZWQgb3IgdGhlIGtleSBzdG9yZWQgaW4gVFBNIG11
c3QgYmUgc2VhbGVkIHNvIGl0DQpjYW5ub3QgYmUgdXNlZCBhZnRlciB0aGUgY3J5cHQgc2V0dXAu
DQoNCk5vdCBzdXJlIGFib3V0IHRoZSBhY3R1YWwgcmVxdWlyZW1lbnRzIHRoYXQgbGVkIHRvIHRo
ZSBmYWN0b3J5LXJlc2V0DQppbXBsZW1lbnRhdGlvbi4gSWYga2VlcGluZyBUUE0ga2V5cyBmb3Ig
ZGlzay1lbmNyeXB0aW9uIGlzIG9rLCBhIGNsZWFuDQp3aXBlIG9mIHRoZSBjb250ZW50cyB3b3Vs
ZCBzaW1wbGlmeSB0aGluZ3MuDQpEbyB3ZSBldmVuIHdhbnQgdG8gc3VwcG9ydCBGREUgdXNlIGNh
c2VzIGZvciBmYWN0b3J5LXJlc2V0PyBzeXN0ZW1kDQood2hpY2ggc2VydmVkIGFzIGEgYmx1ZXBy
aW50IGZvciB0aGUgQVBJIGFmYWlrKSBkb2VzIG5vdC4NCg0KDQpCUiBBbGV4YW5kZXINCg0KPiBK
YW4NCg0KLS0gDQpBbGV4YW5kZXIgSGVpbmlzY2gNClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNv
bQ0K

