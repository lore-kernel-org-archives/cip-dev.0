Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C43C54787
	for <webhook@archiver.kernel.org>; Wed, 21 Feb 2024 12:27:27 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.56])
 by mx.groups.io with SMTP id smtpd.web11.8666.1708503887479999282
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Feb 2024 00:24:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=eQNNBSsA;
 spf=pass (domain: siemens.com, ip: 40.107.22.56, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKgQcHA9bNK7D5f9isEEoxERagsbOQPDSGWawha+//j381f9r2CoV97Spii8+jjzip3eg/b3dtH3I49IwE5LCszjp9xDsC3d0SujpDjdFMKyD8CBhGbUesd4Wu6kfPqRWWPbf+QNVER1+e/ocee2mVqlU8Ben+p6U+MeZAxDFre6ALyKdsBu0eIhjRxYdkkeP7KUF+Z0psFWenFPKsroMw2pXR0yCcR/i5IbCpIRw82hM1Q9gFwEsakVRAEsAbbH0P4A+pZl18WyiMzSSvWlZ+3c7P67XYZX/rqVKhgNDZR+w4CNOz7MSwxD5RgvVUG6QyR8JNhxR6OnpZDYGBUDFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83x25Wh28QMVwh9eJPg2lAG//WOKxOMvvxPK6ESiZb0=;
 b=GSQ7bhjwri8twLIB/eEHHHt6CX+lQd3y4tmI+icu6k07NqJ55xlaxGgigxDpGtZsaVI0KJI2WbudOaa6yaQlOClTqJ6gaUWIiQt2NF+ovT+SnkhjJ/JKq6x4W6pjHHlC05S7EdQ10reAQNkNdf13yr7IoPkpZ9WzZ0zu3y4wdQxD62WIWoGGb38niB15KB672SgOt4VYe6TyCYe+jdSY0E3xdn8KQ/79dT+GnHXAmnsXSbsWPIYEhPlDaeHsaZl1kMmwXprjWxPM9HC6dhdnTvpUV4J798t/eGJcWBtRFz4BdvMe8nkysnnDoBEUit7ENfsQJ6Boih/v1dLDpkiJDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83x25Wh28QMVwh9eJPg2lAG//WOKxOMvvxPK6ESiZb0=;
 b=eQNNBSsA7Hn4wFLSa2H+pHDatAlKBXmIdwbrwmsOSzcnFjuWPMU5fDQmAyKhwCIYJxIEnzkcIHJ5UYiS4yv4KrBRywsAyGSCe0NjA/Z5gbQffeKZxEjc+7KxtNMnFVF1D2RmdelPuS3a7PRjheyzhDci8B35+lfqM5uOl1P9lwNR0wXHVlObS8AdlJHhjyqm+E9OkisAbS4fzo3ufl0ZIjbOmsXvaLiw2YJ8+TlPI0AAqQGIGHXqxGyv76kyi0gy9G604RCgeuwqmnjMfIiC/0d8uEgs3TjyhiWW/t0HOlUQEMBAWBEnyQHXbiFE3o4knSplSVT0YNyj6SvrnIDQ3w==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by DB9PR10MB6403.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 08:24:44 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c123:2b7e:a12a:d53c]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c123:2b7e:a12a:d53c%7]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 08:24:44 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
CC: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>
Subject: Re: [isar-cip-core][PATCH v5] update ISAR to latest next for dh-compat improvements
Thread-Topic: [isar-cip-core][PATCH v5] update ISAR to latest next for
 dh-compat improvements
Thread-Index: AQHaZDPY2q/XaTGAMEGT1HWm+qHTzLEUdm+A
Date: Wed, 21 Feb 2024 08:24:44 +0000
Message-ID: <5ebbfdc68d19e9fc8610c239f26aef572129a5fe.camel@siemens.com>
References: <9592f3b5-5148-491c-be55-ea2c95cffdb6@siemens.com>
In-Reply-To: <9592f3b5-5148-491c-be55-ea2c95cffdb6@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|DB9PR10MB6403:EE_
x-ms-office365-filtering-correlation-id: ad5f84f0-3fe8-4524-7d72-08dc32b68eec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 bNI8/tZv6DC5YG+ggzfOc9uN6EjFl/4rg8kR/+Q8f051Ck0qPB+KDC9zFo+8tpCIv4lwL7D5vj2HPvG3lrrsB4wPj0V3Ain4PqejlAVKT9yv1LbNAduT/lwv2dO4ur5vLlauXCyfjP5JFvXtvqiKJY+XTBgfVQIx+675AiI+CqF5LSirTdKn8LrtA70xRGvu2LwdY0VoTbGBnGWBJPKsoGj03RRH6fEhCtBoei0jws0D3p2Lzx17QjKTu93Toq+h4DTqHFCwtzcLUhnEPdaIckqZTueQsHaYdIDoHqu1wpEdSPxTvCHj/ocaf2mv1ILw0EiX/O4fmwI6iTlcOLhCKG3Bmb7cjVzlbin4w+zaStkWe/xgtbRka2wbE47mhxFzMe5gEONXhRQzC6Z9liroROGJozdo7jnTNf4FfCw/yyPSowzMDyYc60moPjFuw/MFDFUBbV3C0HSay3ozmSAMh86Q8NcdwI0X/36/VYHbMtLIVTvmzxYFKROdDJoD4MzRVirrCJ8sDc5ipRNhyxVqIj77OzeD3F17ajU+L2WpSRj04kXHdvlKhNgYxvf53ClbNqc+8f7kDWy1jglx+fiJexU28Pk33aPZIbdS/CShkds=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Yit3VXlFSitOb2J5ZlhzemkxYjR0VlB1Y1VvMk03VUNzS21wcWczNWNoUnpj?=
 =?utf-8?B?UzJBSkNJZDlmcTIyL3pUQ0N2b0RmWCtJQzRZU3loVVpnUnlQTEUvQ1NTSnVS?=
 =?utf-8?B?RGNHYXBpSmljOEdET2dnSmpNdFNteXg5U2FiNm9rdXNiaGw4M05vVmpMNUZz?=
 =?utf-8?B?UGRwaWREbkxjbjZFcDNuQVErV1hSbWRQQ1lpbVFDRit1QVhHOEFEbWp0QnJj?=
 =?utf-8?B?djF6V3I0MVo3MEVkUnpIMkZ5V09RbkVIWFpFWmZBclBXMlVVeDN3WXJDOVNa?=
 =?utf-8?B?YTJXaWFBRWFBdjJHWjRVRkxxVXpLOW9SZklzMG80ZWxNeWYzNHowd1dZaUx4?=
 =?utf-8?B?cmN3dUdvRTc5RVdnakhibUdOQWdaRVRZb2lQK0o0bC9IYVBFb1E4cjA3dUlC?=
 =?utf-8?B?VHVnc3hiTVl1K1AyVTVrQVhvL0ZLeVEzc3VuZm5hbWlUL3Z4Zit0dmI5SllG?=
 =?utf-8?B?SHl4d1BqVkUxMEJWRTM5Wjd6S0h1Z0Z5Vkp3d3UwVjZZcDIzOHVyenZvSDVi?=
 =?utf-8?B?aEVGMDJwR0dWanFSNW9nRWpOWTZWOXZHRjduYkxJb3g0SVFUY1IvM2wrcW0y?=
 =?utf-8?B?dDZxcXR2bG9nYklDQ3hUWUJHeUJrTXd0VFQyNzU0TDQvT0ttREpmZTZvVGh5?=
 =?utf-8?B?RldyTTBJUnVrbTg2cjdkeTdjbmdWRlIyNzlONU9GU3IxNTFud1lJRUFQRDY1?=
 =?utf-8?B?cDQybnRvbWxmYUttWFJ1N1FSNWpjaXF3NkpCVU9MZnRmNHNwZmhOMG9EZytH?=
 =?utf-8?B?aGN0NS9hU3hPY0x6Mk1NeXAwU1RNWW96TDY4LzhKMmMwN1daK0NCZEJBSWhs?=
 =?utf-8?B?R1BkOVNZWHJDTGs1aGdscTNiRG0wY2krdUNBVFFPQWRkVEZxVUFEN3RCWld0?=
 =?utf-8?B?MFVQOVoraUJFNldoSDk0VFI3Wk9CdmN4VmxaL3dUSlF6elZsVkdmK1RWdTB5?=
 =?utf-8?B?MFVuemNlS1dObTg1cXhHM09QUnBkRE9NamdFMmNvYUhFYXR0WENDcGpZQ0NP?=
 =?utf-8?B?K1I1SFRCb0pDVElCbEVZZjJnb3FPUjNaaVZvZTRZbm5DZkVhYVUwS05NL2R2?=
 =?utf-8?B?RjRodllvOXRTTjhmZW9OKzRBa1E1am83U3BvM1JSVTUrUWN2N0JaQVJ3aVN0?=
 =?utf-8?B?MGMrTnNyR055andUQUhJdjk5Q2xsT09WOGxkOVM5S1NuWGxVNXNjWThzYk95?=
 =?utf-8?B?Wkp6TS9tTUVSaVN0d0hBbkdIUTJDK2JCOWxndzNtcTFqN29GcGZDdVQ4SU8r?=
 =?utf-8?B?Ry9IUHJzdDhocHo2WmJsc21IZ0JOR3dYT3crMmNpS0hnMEFSRU44NnFNM3p5?=
 =?utf-8?B?S1cxbmtzdGlVeEhxbkc1cXJSMm1RQnBIVkkzUW01bEpnSzR6VmIybFlqTlMz?=
 =?utf-8?B?M3pDVWRVTE1idkxxeFN5VzVZU280YUxTckM3cVZzeUpqVzZRWlJBbEt3VWxh?=
 =?utf-8?B?bGZHYWUySUV5VzZJaE5LVkJNaVFSRnRZSUVUbG1LbnMvZ3B2VStFQVJkZjYx?=
 =?utf-8?B?ZWNLaTlWUmJ5dFpmOTlNb2I4UHJXL3FaRFZjdzNtQXVTYzJkK0xlY2pETE02?=
 =?utf-8?B?aVR6TytZTnNpK0ZUbWZrdDN2Sjk0UHVONGNSMUQ1VWwvTk9icVB1N21nYVVI?=
 =?utf-8?B?OHBKQS82L3RxV0pLd0d4eW4wcFg3MVdDaUpiQThtV0RhN29OUTZoU21HQXp3?=
 =?utf-8?B?cHNVVnlwV0k1eVdUTU5IYVBaOXBYVVhCQkszai9RbkdObkZ4eXdUKzBvME9m?=
 =?utf-8?B?Z3N5NlRQWGp6VXJqYVdxUjhteVpLMks2OHhDVUpTZDZuUVYveTE2enV6S2xj?=
 =?utf-8?B?bU01NjlLcnZ4RFFwQlgzVjdrWlZVU1hDSUdQelhuZksyamVXSTJMNzUxL21F?=
 =?utf-8?B?QldXdTdWTjVDbWV2VTMwQ0lZK3JOSWx1Q3BiY0k1b0w0eTFTTE9xWjZGOFNY?=
 =?utf-8?B?MEs1YTBnQWVpakRIYis3dlNQalNVR0FEU2MvZENCTHp5ZXBCb0twaG5zVkhC?=
 =?utf-8?B?WVlOYXp2QjU3c00vY0g1QkN4NXE3OTdXSzhNd2hUd1V0SmhqYnYwT2pkK3d2?=
 =?utf-8?B?Y0xXZkVHbkhxZkZXSkw1RVRxRmFhcldndFN4WDhTQWYzdDlxZjIzaWQ0ZHln?=
 =?utf-8?B?ZWhkU0RscFhKYVlBVW83OTRCemxleTRONHdaRU9BVXBLQkxWR1dsZWxkbFJj?=
 =?utf-8?B?K0NDYm5DeXN6WFlPbnBSWWQwV3RLeFVrVHBPSjVydmhOdzIybWE3U256NjhU?=
 =?utf-8?Q?Q+QS01FOREOfotmWYWucGkAzaRwHS4RuOKOl/OJu1A=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ad5f84f0-3fe8-4524-7d72-08dc32b68eec
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 08:24:44.2437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9j70dFfucORRjsYtLLlnA7V++2MlquNXaf/VHrRoJsvK9hPLYCfJoHG55h/Wab2sBzThjW0neqbkWtLquo/MdycDK2iZvrNpHWT6zOcchEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6403
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <58955D0CDEA89D4890A2AD0323C3385A@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 Feb 2024 12:27:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15052

T24gVHVlLCAyMDI0LTAyLTIwIGF0IDIwOjM0ICswMTAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBG
cm9tOiBGZWxpeCBNb2Vzc2JhdWVyIDxmZWxpeC5tb2Vzc2JhdWVyQHNpZW1lbnMuY29tPg0KPiAN
Cj4gVGhpcyBwYXRjaCB1cGRhdGVzIElTQVIgdG8gdGhlIGxhdGVzdCB2ZXJzaW9uIG9uIG5leHQg
d2hpY2ggaW5jbHVkZXMNCj4gZW5oYW5jZWQgc3VwcG9ydCBmb3IgZGViaGVscGVyLWNvbXBhdC4g
V2hpbGUgZG9pbmcgc28sIHdlIHN3aXRjaCBmcm9tDQo+IElTQVIvbWFzdGVyIHRvIG5leHQgYW5k
IGFsc28gYWRkIHRoaXMgYnJhbmNoIHRvIHRoZSBrYXMgZmlsZSBmb3INCj4gZWFzaWVyDQo+IHRy
YWNraW5nLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRmVsaXggTW9lc3NiYXVlciA8ZmVsaXgubW9l
c3NiYXVlckBzaWVtZW5zLmNvbT4NCj4gW0phbjogdXBncmFkZSBsdHAgcmVjaXBlIHRvIGRlYmhl
bHBlci1jb21wYXRdDQoNClRoYW5rcywgYWxzbyBmb3IgYnJpbmdpbmcgdXAgdGhlIEFQSSBjaGFu
Z2UgaW4gSVNBUiBvbiB0aGUgSVNBUiBNTC4NCg0KRmVsaXgNCg0KPiBTaWduZWQtb2ZmLWJ5OiBK
YW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiAtLS0NCj4gwqBrYXMtY2lwLnlt
bMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAy
ICstDQo+IMKgcmVjaXBlcy1jb3JlL2x0cC9maWxlcy9kZWJpYW4vY29udHJvbCB8IDIgKy0NCj4g
wqByZWNpcGVzLWNvcmUvbHRwL2x0cC5pbmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDEg
LQ0KPiDCoDMgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2thcy1jaXAueW1sIGIva2FzLWNpcC55bWwNCj4gaW5kZXggYjI1
NWM5NzcuLjBiMjA5MTQxIDEwMDY0NA0KPiAtLS0gYS9rYXMtY2lwLnltbA0KPiArKysgYi9rYXMt
Y2lwLnltbA0KPiBAQCAtMjIsNyArMjIsNyBAQCByZXBvczoNCj4gwqANCj4gwqDCoCBpc2FyOg0K
PiDCoMKgwqDCoCB1cmw6IGh0dHBzOi8vZ2l0aHViLmNvbS9pbGJlcnMvaXNhci5naXQNCj4gLcKg
wqDCoCBjb21taXQ6IDMwNDcxYmIzZjc4N2ZiMGFhODIyZDE1ZTE0MWVjY2UyZjNiOTk4NjANCj4g
K8KgwqDCoCBjb21taXQ6IDA3NTczZDdhNjAzMGI4YjM4MTUxODM4Nzg2N2I2NDA2YjE0NDFmMDkN
Cj4gwqDCoMKgwqAgbGF5ZXJzOg0KPiDCoMKgwqDCoMKgwqAgbWV0YToNCj4gwqANCj4gZGlmZiAt
LWdpdCBhL3JlY2lwZXMtY29yZS9sdHAvZmlsZXMvZGViaWFuL2NvbnRyb2wgYi9yZWNpcGVzLQ0K
PiBjb3JlL2x0cC9maWxlcy9kZWJpYW4vY29udHJvbA0KPiBpbmRleCA5Y2FhZjM4ZC4uYjQzY2Q2
ZjQgMTAwNjQ0DQo+IC0tLSBhL3JlY2lwZXMtY29yZS9sdHAvZmlsZXMvZGViaWFuL2NvbnRyb2wN
Cj4gKysrIGIvcmVjaXBlcy1jb3JlL2x0cC9maWxlcy9kZWJpYW4vY29udHJvbA0KPiBAQCAtMiw3
ICsyLDcgQEAgU291cmNlOiBsdHAtZnVsbA0KPiDCoFNlY3Rpb246IGVtYmVkZGVkDQo+IMKgUHJp
b3JpdHk6IG9wdGlvbmFsDQo+IMKgTWFpbnRhaW5lcjogR3lsc3RvcmZmIFF1aXJpbiA8cXVpcmlu
Lmd5bHN0b3JmZkBzaWVtZW5zLmNvbT4NCj4gLUJ1aWxkLURlcGVuZHM6IGRlYmhlbHBlciAoPj0g
MTEpLCBhdXRvdG9vbHMtZGV2LCBwa2ctY29uZmlnDQo+ICtCdWlsZC1EZXBlbmRzOiBkZWJoZWxw
ZXItY29tcGF0ICg9IDExKSwgYXV0b3Rvb2xzLWRldiwgcGtnLWNvbmZpZw0KPiDCoFN0YW5kYXJk
cy1WZXJzaW9uOiA0LjEuMw0KPiDCoEhvbWVwYWdlOiBodHRwczovL2xpbnV4LXRlc3QtcHJvamVj
dC5naXRodWIuaW8vDQo+IMKgDQo+IGRpZmYgLS1naXQgYS9yZWNpcGVzLWNvcmUvbHRwL2x0cC5p
bmMgYi9yZWNpcGVzLWNvcmUvbHRwL2x0cC5pbmMNCj4gaW5kZXggZDMzNTBjYmYuLmM4ZjExOTll
IDEwMDY0NA0KPiAtLS0gYS9yZWNpcGVzLWNvcmUvbHRwL2x0cC5pbmMNCj4gKysrIGIvcmVjaXBl
cy1jb3JlL2x0cC9sdHAuaW5jDQo+IEBAIC0yMCw2ICsyMCw1IEBAIFNSQ19VUkkgPSAiIFwNCj4g
wqANCj4gwqBkb19wcmVwYXJlX2J1aWxkKCkgew0KPiDCoMKgwqDCoMKgwqDCoMKgIGNwIC1SICR7
V09SS0RJUn0vZGViaWFuICR7U30NCj4gLcKgwqDCoMKgwqDCoMKgIGRlYl9jcmVhdGVfY29tcGF0
DQo+IMKgwqDCoMKgwqDCoMKgwqAgZGViX2FkZF9jaGFuZ2Vsb2cNCj4gwqB9DQoNCi0tIA0KU2ll
bWVucyBBRywgVGVjaG5vbG9neQ0KTGludXggRXhwZXJ0IENlbnRlcg0KDQoNCg==

