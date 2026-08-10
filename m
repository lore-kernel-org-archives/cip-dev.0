Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5267C5AD55
	for <webhook@archiver.kernel.org>; Mon, 10 Aug 2026 12:02:25 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.29])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.27933.1786363337452490434
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Aug 2026 05:02:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=zvo3F6x2;
 spf=pass (domain: siemens.com, ip: 52.101.69.29, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKH26Eu8SYJ1ggornCmHkUpUHEeWy22+Jpmb/96X1jOR4k6ha62qEV7uoZPpdXbxR8lkM7ktq6ELo3C/tdmkUYr6ma6L7BbwRKEF1XWNH4B3hxDyXJJxFzM9hfDCmNmBWS7gt4W5eOGryHObOngKIevYlRdmuxEIrpTiAPgI/xptRZuVnGhBbNhW++J6qKkic+4/C79FZfDtZfMSnqn5vHKKCc/7VKjReVyhLqa0tC5o8jlSriWhBEg5PmB/m8ig0arwJkvunmhnsYymvRDsaZQePV1XUYnpZzAzg/bV0W8FmsYtBDPDqzvreIL3ElMkFT7j+6emRUnknsd2yV6O/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKeJ3aGR27sixIqFzbhIBTymAwxNzqhKM/9Ua2LiCWk=;
 b=YwDI7s/PaqLxfMBGbTqKZG2OhxVpOXPTuMiJ192xwxBxCay/QzO363s5oHp1ofXd0KWUrK5eheaSEiSkU5lv0Z9qaEtp0IbfNbmHkdPDHtbILNE7Ib+327u9Hb3alzkyWw0KYuq2bJah5DFKiAWriYSvyal3FukAB8GDANKz8a7qJI2ae582t0Zc/p5Co4rD98gnTjoNJDlsloni6q8j4n4DYI9OxJXWpHOXsrjRuwRjpPb2TKNpp947lEhSGhGSXMA4QojwGuf1VQxcu/dn5+jWrg9MKD1RZxn6aVKZU6DysMdottvxZl/ZpBzus+IlCWxUUmplwhRbdOW0WTePRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKeJ3aGR27sixIqFzbhIBTymAwxNzqhKM/9Ua2LiCWk=;
 b=zvo3F6x2XIxCUCvXr34bnnb7twbDYUZGPo8JsLzyeQGlD/MhCBW8qKwB7CXddLlld8mwrhY8XkYwbpu3a1H7OVP99EhWlQVok8svZ1Sup+hj67+OOqwGoAw0yNCioLib0VUu/pidP3ltQPkCCgq37ZLZOXaJWiQXShuD1hN4wMuHVmPcSBZ5PJr8c10y4bxcxeChIrpEeHwOu1BMOzz/0Kuy18X1enJMw6dC0w3sGko9KWT0hMJpwfejMi4hizrgaZt8e6BikBpRiSSsBf4wiiRJ77lvVy5GNf3RoKYJZDUpbXe2SOjNxcRq7viUSQWcv2/Kr2PGzeGcgBbXXgcprQ==
Received: from DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ed::14)
 by DU4PR10MB9095.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:568::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 12:02:13 +0000
Received: from DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2339:186:874d:c405]) by DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2339:186:874d:c405%3]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 12:02:13 +0000
From: "Heinisch, Alexander" <alexander.heinisch@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"Gylstorff, Quirin" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [isar-cip-core][PATCH 0/2] Remove unsupported combinations for
 factory-reset from Kconfig and document them explicitly
Thread-Topic: [isar-cip-core][PATCH 0/2] Remove unsupported combinations for
 factory-reset from Kconfig and document them explicitly
Thread-Index: AQHdJoO2k7qw2xocSUyik+HCHaPcK7aW3YyAgAA+dACAABcegA==
Date: Mon, 10 Aug 2026 12:02:12 +0000
Message-ID: <4400621d4db82ea3313ff1907d4ef664ca0cdaab.camel@siemens.com>
References: <20260807154439.625212-1-alexander.heinisch@siemens.com>
	 <31174e6a-78c9-4fce-8d1f-dff403e1f6aa@siemens.com>
	 <b45b4dd0-03cc-4df8-94e5-ca3405e2732b@siemens.com>
In-Reply-To: <b45b4dd0-03cc-4df8-94e5-ca3405e2732b@siemens.com>
Accept-Language: en-US, de-AT
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-0+deb13u1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB8045:EE_|DU4PR10MB9095:EE_
x-ms-office365-filtering-correlation-id: f1cae2fc-daa2-4b16-447e-08def6d736d8
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|38070700021|6133799003|56012099006|10067099003|4143699003|11063799006|5023799004|22082099003|18002099003|55112099003;
x-microsoft-antispam-message-info: 
 2lTAnv1gtj4gwHLASDs+X+0wfTkVr+nxK+tyH35nDZjCBZwIl4YiUuGoLgYovK4aYOOBX9U8pgwCcki4hi0ezRzAwGvvXsO/bxlvzgRqBPiczbV/fhavyg26ZOAi8RvQh1djgjQbnzd7nUGzs101dXsI95aMZspz4cf3Q6eoYti1s6agjlUDs/+3l6L817o4ytQd4EgcR4+e7Ngz3dyidzY2NaFWyVGWZdZa2DQoXulxdBToYogHqoAApqDwC+RHFyV+G9RT0CWx+lgqXfVDNrvntrLqYznAk8O7wnZcVcAYiSp7urqGDULkN6lqlMW/HQKcov9XZzOT24iXZwbIm+/5Sgdqn7KLRNAtXNKnqgY0ieyRfcOFyly51kMKMmIe2uKmAgMIvRKcxAEN4cymvoa3JjulfwPg1VFJyQGuUQehKk7f6xYPVwYAw4RN1C1rQwmy0aexPYg8YO37ZwGeijcgMlgXury7ZiAGV2YW2rdUVMh4q5EZ+fdhzNLElew3hPXMDZdO2e8gQuUbvRAViiRbgc721m0eApLWkq1wbk5S0dNKpq1o48yjqdTnkvW3GNkZsCW8AqA2xLZZLDaH9jQ5Ts7iHj+cbs0/H9E62vgb+fmA7QDjrHInwDjLFMv1f/KPm2TB7zdswLzQDj0ccHraQkoD5sKlRj6HfPF77Mo=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(6133799003)(56012099006)(10067099003)(4143699003)(11063799006)(5023799004)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bnpHNHp3TGhoZVZJVEYzRm40ZnN6QkdZemVTUmZQZXVSSU5LcHVTZzY0T3lY?=
 =?utf-8?B?ZEhlelJWZEwvaVI3QWVVZUxmeHpGU25JVUFROThEbDlIVFNNTkhCVEY0ZmpD?=
 =?utf-8?B?Ty9aV3lyQUZrY050SUgyamNKckxsNkpjdVNuekR5S1lQczdGQ2JSREFJZG5K?=
 =?utf-8?B?aE1wRVc1YWFxR21venN6M0U0UkMxb3huYW5JcVFMbW5LVjhkWjZTL2JOT3dw?=
 =?utf-8?B?RkYrR0ovUDFDaUJqMmhhamdmTEFkSHdHR3FWdHNHbEpXd1F4dXh6R0xqVjBH?=
 =?utf-8?B?MHhKRHhON3VEVFdxWlArTGJMVGRiS2tyTTByS2ptc3JieFdCc3ZjYXhUQUZ2?=
 =?utf-8?B?N1NUdkZwb2doa3p1alhXQmtSeVdlZS8rU0tpanZHRk5IaTg0NkN3WkNqNjBC?=
 =?utf-8?B?a0xxeU5jV2ExNVdoYUkyVFB3Y2VMUExqNXlxWTl3blJrelI4YkY1dmxjNGJi?=
 =?utf-8?B?cHZGRjBONG5hYzIxL1lJTmJxRHhETXRZa0greGZpZ2tjZ0RhL3JUcWRscHVS?=
 =?utf-8?B?SVM5M2c4RGxjMXBBc0JKZXUrYldyYnZoUDFkdlpMd2ovK0VIcG9HaDNwR214?=
 =?utf-8?B?ZEo0anVLK2ljUHNkRWVibTdRNmFUK0xOK3NNMVNaRnBaQXpCR2h2WkdmZ0V3?=
 =?utf-8?B?RkF1YnZpaXNuOW8zRCs5U3N1M0ZzODB2bDR0cTRLZ25mMENUUENzZjNhWTJZ?=
 =?utf-8?B?SmlCZm5iYkZpeE9MVlhHbCtMRVJMSUNYU2RnNmszU3FpVFZQKzRWSGpieUoy?=
 =?utf-8?B?NWRjd2tKa1JicEIvY1g3cVUvWEkxbEZsUm5hWEtuL0F1cTRKT2JpN3AxMjNv?=
 =?utf-8?B?RitzUDhUNEZ1UVNTQSthU1k3VzBYcjNhMjJHR3IxbFlENGdLUmUzcnNlWWw3?=
 =?utf-8?B?WUEvNWZzZzN6Z3A3bVcvZEdYQkFSdUh6V1U5cERRdXBMWkt1cUpYN3ZUOXpM?=
 =?utf-8?B?THcwMFRGbmJoVFR2M3pDeFREdStPSjFheFEvM2Z3Z3VTRGc0QkF0amRmSnpt?=
 =?utf-8?B?Skh5NDMwbHNhQUNqQVc3OEgxSHpHY0N5RXZsTnN3QThlek1FY2hjTG5yMzBP?=
 =?utf-8?B?MW53SENSZU4zUHk0RVR0RW9IVzNIZmVkU3Izakt0MWpDRVZ1VHlDVmI2ODRj?=
 =?utf-8?B?aEpsK0Q5WUtUNy9PMnJHOVpLMnYvUlhKL2JDSktpeG5SVmU2bk5pN1hXV0ZI?=
 =?utf-8?B?d3ZVMFJHRTJpeUNwbm1qYytaSnpoVTE0dDA1ZVdpekJDcUpuOEI2RUlIQ3A1?=
 =?utf-8?B?cElUNUJNNlJoejZxNlpUdXFTdkRyelBLUFBSMkhIdEZybEptV1NsdzdrMGp6?=
 =?utf-8?B?d2gvNXBQeWY5Y0FDMXpQZ1NPZ2JVUkxJTExKYnZ6a2J2NVlEaEZSZGtJMVdH?=
 =?utf-8?B?RDRpUGwwUncxUWhIbXRQQ0JHcmhvYlZSaDdzaXFpR2Qza2IySTlDVXV2dE9F?=
 =?utf-8?B?RXJxMkZQT2xVbGdkYVFEUUV1MlZ6QWtYZHZJNG5Jb1NWTlpVcWY1QUcxamg1?=
 =?utf-8?B?cXhjcEU1NFRTdTFEWGY3N2FTbGdLWk9mRTF0cDNCNU15VDZJSCt3alNDdnJt?=
 =?utf-8?B?QjhaalZYbnRUNFlYa3NIM1RRSE1OTmJpZVMxWUkyTXhVSGIrOUw5eE5SREtV?=
 =?utf-8?B?azZpYTZJRWNxMFFpQTdSdkpQQ3Vad1FaSHd3aEJIRXFoNG8xalE4TFlpMkIx?=
 =?utf-8?B?Mm1FVHNlM3pQYUpoZFBVNEppQW10ZlBuOS93bUpYVEtCM3lMMEtCUDI5MkxB?=
 =?utf-8?B?dkZXSURjZ2o5V3E0WUU5ZExUdHlHOTVjMGE3THlxYnBSSWRLNEN3VE9QWTdm?=
 =?utf-8?B?Q3VQNUw4WkJXRzdSRDN1aWtRMkE1ckt1OTJjMlFvQnJwRmh1UXhpRm0vb2Qr?=
 =?utf-8?B?MUJ0Y2NSOFVZYzBwck5UWDduQnlORFNXTlFRb1pHTVpCSFJuSmZ1bHBxVTRu?=
 =?utf-8?B?ZjR6N213bXdSVEYzamxUVGdhdmtvbEg3K29EbEFTUFFHQVJpaW9jVEQwcUov?=
 =?utf-8?B?NTNHZ0ZFNzhwcVQ3ODhNSWs1ZGl4eUIvZmRodTNUL3J1dE1oMTBtV0lZR1lP?=
 =?utf-8?B?THd2Nk1hVkNGaWNOMTFtTFh3UnU2bkV4RUtOV3BhWCtnd3BoTnlPdjY0OU54?=
 =?utf-8?B?ZHdMOTJRZ2MyQ0ZpM2NBSSt3WjNSaWNYZUxDbkRma1g4U09qbG0yU0JFM0Fi?=
 =?utf-8?B?M3o3ZndpN2dLcGFLRXhFZ3hqUEkyOERPZGlkdzltWktjb0Q2TXEwRDFLNVNL?=
 =?utf-8?B?aUN6RXc4NWNKS1JacVIva0RnZTlSTUpPYmRIMzlWK1dJTkUxQjJxelgrSUNV?=
 =?utf-8?B?OHFZYzhXdFVCeFgvdEJKeVNuOCtsUW9HbWh4VHRYVXpYWmN2REwxVHQvUlFp?=
 =?utf-8?Q?cYPhumGo6bYTS2Sk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E64B0B510822C6488005CF07D08FC94B@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f1cae2fc-daa2-4b16-447e-08def6d736d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 12:02:13.0804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JmS4hOMNuGudy+P8pgikrsRt/qWjertJYxmgV4+nj4Yg16OhRtBKBxoPoLTlZsR5y+C6vHr8zTdxifJSvacMdmRs2OShL+R/mA0cva0MEJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9095
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Aug 2026 12:02:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23885

T24gTW9uLCAyMDI2LTA4LTEwIGF0IDEyOjM5ICswMjAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAxMC4wOC4yNiAwODo1NSwgUXVpcmluIEd5bHN0b3JmZiB3cm90ZToNCj4gPiANCj4gPiANCj4g
PiBPbiA4LzcvMjYgNTo0NCBQTSwgYWxleGFuZGVyLmhlaW5pc2NoQHNpZW1lbnMuY29twqB3cm90
ZToNCj4gPiA+IEZyb206IEFsZXhhbmRlciBIZWluaXNjaCA8YWxleGFuZGVyLmhlaW5pc2NoQHNp
ZW1lbnMuY29tPg0KPiA+ID4gDQo+ID4gPiBCeSBkZWZhdWx0IGZhY3RvcnkgcmVzZXQgY2xlYXJz
IHRoZSB0cG0uIFRoZXJlZm9yZSwga2V5cyBuZWVkZWQNCj4gPiA+IHRvDQo+ID4gPiBkZWNyeXB0
IHRoZSBpbW11dGFibGUgQS9CIHJvb3RmcyBpbiBmdWxsIGRpc2sgZW5jcnlwdGlvbiBzZXR1cHMN
Cj4gPiA+IGNhbm5vdCBiZSByZXRyaWV2ZWQgYW55bW9yZS4gVGh1cywgdGhlIGJvb3QgZmFpbHMg
YW5kIHRoZSBkZXZpY2UNCj4gPiA+IGNhbm5vdCBiZSByZWNvdmVyZWQuDQo+ID4gPiANCj4gPiA+
IFRoaXMgcGF0Y2ggc2VyaWVzIHJlbW92ZXMgc3VjaCBjb21iaW5hdGlvbiBmcm9tIHRoZSBrY29u
ZmlnIGFuZA0KPiA+ID4gZG9jdW1lbnRzDQo+ID4gPiB0aGUgaXNzdWUgZXhwbGljaXRseS4NCj4g
PiANCj4gPiBUaGlzIHdhcyBuZXZlciBpbiBzY29wZSBvZiB0aGUgZmFjdG9yeSByZXNldC4gWW91
IGNvdWxkIGltcGxlbWVudA0KDQpQcm9iYWJseSwgYnV0IGl0IHdhcyBwYXJ0IG9mIHRoZSBjb25m
aWd1cmF0aW9uIG9wdGlvbnMuIEltbywgdGhvc2UNCnNoYWxsIHNlcnZlIGFzIGEgZGVtbyBmb3Ig
aXNhci1jaXAtY29yZSBmdW5jdGlvbmFsaXR5LCBhbmQgb25seSBpbmNsdWRlDQp2YWxpZC9zdXBw
b3J0ZWQgc2NlbmFyaW9zLg0KDQo+ID4gaXQgYnkNCj4gPiBtb3ZpbmcgdGhlIGtleXMgaW50byB0
aGUgYm9vdCBwYXJ0aXRpb24uIEJ1dCB0aGlzIG1vdmUgd2lsbCBjcmVhdGUNCj4gPiBhbm90aGVy
IGNhbiBvZiB3b3Jtcy4NCg0KVGVtcG9yYXJpbHkgbW92aW5nIHRoZSBrZXlzIHRvIGJvb3QgcGFy
dGl0aW9uLCBpcyBub3QgYW4gb3B0aW9uLg0KSG93IGFyZSB0aGV5IHNlY3VyZWQgdGhlcmU/DQoN
CkEgcmVlbmNyeXB0IHdpdGggbmV3IGtleXMgc3RvcmVkIGluIFRQTSBhZnRlciBUUE0gY2xlYXJp
bmcgb2YgdGhlDQpwYXJ0aXRpb25zIGhvbGRpbmcgdGhlIHJvb3RmcyBhZnRlciB0aGV5IGdvdCB1
bnNlYWxlZCBjb3VsZCBiZSBhbg0Kb3B0aW9uLiBCdXQgeWVzLCB0aGF0IGltcGxpZXMgbWFqb3Ig
cmV3b3JrIG9mIHRoZSBmYWN0b3J5LXJlc2V0DQp3b3JrZmxvdyBpbiBpbml0cmFtZnMgYW5kIHBv
dGVudGlhbGx5IGhhcyBzaWRlIGVmZmVjdHMgLyBkZXBlbmRlbmNpZXMNCm9uIGNyeXB0IGhvb2sg
bG9jYWwtdG9wLiBBbmQgeWVzLCB0aGVyZSBtYXkgYmUgYSBzbWFsbCBjaGFuY2UgdG8gYnJpY2sN
CnRoZSBkZXZpY2Ugd2hlbiB0aGUgZGV2aWNlIHBvd2VyY3ljbGVzIGF0IHRoZSB3cm9uZyB0aW1l
Lg0KRWxzZSwgYSBtb3JlIGdyYWNlZnVsIHJlbW92YWwgb2Yga2V5cyBmcm9tIFRQTSBjb3VsZCBh
bHNvIGJlIGFuIG9wdGlvbi4NCg0KQWxsIHRoaW5ncywgd2UgbmVlZCB0byB0aGluayBhYm91dCBp
biBtdWNoIG1vcmUgZGV0YWlsLCBhbHNvDQpjb25zaWRlcmluZyB0aGUgbnVtYmVyIG9mIHVzZSBj
YXNlcyBmb3IgYSB0cnVlIGZhY3RvcnkgcmVzZXQgc3VwcG9ydA0Kd2l0aCBmdWxsIGRpc2sgZW5j
cnlwdGlvbiBpbiBwbGFjZS4NCg0KPiA+IA0KPiANCj4gV2UgYWxyZWFkeSBoYXZlIGFuIG9wdGlv
biB0byBza2lwIFRQTSByZXNldCBpZiBub3QgZGVzaXJlZCBvcg0KPiBwcm9ibGVtYXRpYy4gV2h5
IG5vdCB1c2UgdGhhdCwgb3IgYnVpbGQgc21hcnRlciBvbiB0b3Agb2YgaXQ/DQoNClllcyzCoHRo
ZXJlIGlzIGFuIG9wdGlvbiB0byBieXBhc3MgVFBNIGNsZWFyaW5nLiBUaGF0J3MgYWxzbyBkb2N1
bWVudGVkLg0KDQpUaGUgcGF0Y2hzZXQgaXMgb25seSBhYm91dCB0byBkb2N1bWVudCB0aGF0IHRo
ZSBkZWZhdWx0IGZhY3RvcnktcmVzZXQNCmNvbmZpZyBkb2VzIG5vdCBzdXBwb3J0IGZ1bGwgZGlz
ayBlbmNyeXB0aW9uIHNldHVwcyBhbmQgbm90IHRvIG9mZmVyIGENCmRlbW8gY29uZmlnIG9wdGlv
biBmb3IgdGhpcyBub24tc3VwcG9ydGVkIGNhc2UuDQoNCj4gDQo+IEZhY3RvcnkgcmVzZXQgaGFz
IGFscmVhZHkgd2F5IHRvbyBtYW55IGxpbWl0YXRpb25zLiBJIHdvdWxkIHJhdGhlcg0KPiBsaWt0
bw0KPiB3b3JrIGluIG1vcmUgY2FzZXMgdGhhbiBpbiBsZXNzLg0KDQpXaXRob3V0IG1ham9yIHJl
d29yaywgdGhlIG9ubHkgb3B0aW9uIGlzIHRvIGRpc2FibGUgVFBNLWNsZWFyaW5nIGZvcg0KZmFj
dG9yeS1yZXNldCBpbiBGREUgc2V0dXBzLCBidXQgdGhhdCBoaWRlcyB0aGUgZmFjdCwgdGhhdCBp
dCBpcyBubw0KY29tcGxldGUgZmFjdG9yeSByZXNldC4gU28gZWl0aGVyIEtjb25maWcgc2hhbGwg
YmUgZXhwbGljaXQgYWJvdXQgdGhhdCwNCm9yIG5vdCBvZmZlciB0aGUgb3B0aW9uIGZvciBGREUg
KyBmYWN0b3J5LXJlc2V0IGF0IGFsbCAod2hhdCBJIGRpZCkuDQoNCg0KQlIgQWxleGFuZGVyDQoN
Cj4gDQo+IEphbg0KDQotLSANCkFsZXhhbmRlciBIZWluaXNjaA0KU2llbWVucyBBRw0Kd3d3LnNp
ZW1lbnMuY29tDQo=

