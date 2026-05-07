Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41575CD343F
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 14:51:33 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13986.1778165488671641816
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 May 2026 07:51:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=xuo0oQSy;
 spf=pass (domain: siemens.com, ip: 52.101.72.45, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWlfuGJEMjEFnCHQl4VJEKkMibr57sfKRUIKT7sdc7SPp5MvJPse3qr9UKP/39WoGm6QVAMsPAwxrsxnBzkrr0/jZER5mIodVbvok7G69hlKyZ0eEd9riLLuxzX1J8usscXgwefAw/F/PFbzIzppT7DZ1CNHVQ3Gu3hs8GR1oebCBQtxjGws42E7o3ZLlBGjUCO7cgze96AtdRWPZ4OMwYROyyGJdP6hCynpf0VCg7M7d0JGRe91qyVkYbGjG9LDevzAleelNK6QJBI1wF89P2ijFUF6Aalsrpj8nccMD11LH1C9FxeaaaXtsZc1UmfWDP2CwaEhBeFzC3oXoEf21A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLueZ+PGExa/DlxqBmdkC6IZLQo2H41CFkzs4vQZr9k=;
 b=VcPWdYu1tWzdJldDuAmXKs+dSI+6VeZO9y6aBGO4Ua4UmJZsW1jJcnIZP3PI5T1mlHA5QfoYeqVmRPUTYKn3+hVgwvf7oLOYtGSdcOEK0dtXuiWliq395aV5l/xkBZOkYrhjWcDjOEVHqAAWlXrtiw5frS1UfMa4YXJdN15QtLP620zmytJ9X65yVQjmjeuu/qQ0cMBZq1R4EPkS2r3xkTCeT8sNsXtJ2rvmQnTQWwIThwFvGYaz7pvRI31QawGg6RyH3aDl9nNeY0vkvFZHRZS9W+PlKw7ZwuUA+rbs+rhBAihkeOVRvBJAaeg6mUFPWBKiDOJKjZ4JNx7I4+pLqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLueZ+PGExa/DlxqBmdkC6IZLQo2H41CFkzs4vQZr9k=;
 b=xuo0oQSyUELRKwuAJ9qQsGyz8l/43nz1eDM5i6oEEZr+M+atAXdu+430gH2UK4srK+pUUiOo+Ba2WH8Ms1B3dPmUYGXRiYJpHu8cGr9rzYy6IUMPNG9zB3U/sdjJMS13YdXLGXnyFHvUNib1IfmXXTVNtu88bQVIe/fLTEklK3HyWsBnJzFR1Cf2IxBmo/la+CUBj5yHQOQPcTDSehikEyC9OO7eutfchS6h+wDk1p5BSUOeH+6tRSnGDPFU5O0MXC1U9v2ToxQSwsuWkC0T9NQt31NuiC2Q42nwCnprEYghyvdNUo93lutsIsYfQwo0knx/Kiv3FZ4lwPNUHbEgmw==
Received: from AM0PR10MB2546.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:110::12)
 by AS4PR10MB5523.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 14:51:24 +0000
Received: from AM0PR10MB2546.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c5a7:ac4:db6a:4599]) by AM0PR10MB2546.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c5a7:ac4:db6a:4599%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 14:51:24 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "Gylstorff, Quirin" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev][isar-cip-core][PATCH v8 3/8] Add factory-reset
 initramfs hook
Thread-Topic: [cip-dev][isar-cip-core][PATCH v8 3/8] Add factory-reset
 initramfs hook
Thread-Index: AQHcLeHcByP91m7yMECWlRqz8nRGY7YEBi6A
Date: Thu, 7 May 2026 14:51:24 +0000
Message-ID: <357ee0ef6de6cea2e0a7eceedbe6aff35a122315.camel@siemens.com>
References: <20250925060009.1711605-1-Quirin.Gylstorff@siemens.com>
	 <20250925060009.1711605-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250925060009.1711605-4-Quirin.Gylstorff@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-9 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR10MB2546:EE_|AS4PR10MB5523:EE_
x-ms-office365-filtering-correlation-id: 9baeec94-4cc2-469d-41b8-08deac481c27
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003|55112099003|38070700021;
x-microsoft-antispam-message-info: 
 hVsvekdz5IwR6d1X519VFBOXkMEfss4GNUsQHDtSzY0zu+Kzl7xHxAaVNK/qV9eYhr2Fw07dAWHFCtoriv41QgQONq1e5+fXslUphpDDyzDGlF0bhUdCUlZz2ymn+lB/LsRln9mQWzFqN9ev1o8fhBOTUagf22rRW/TFT+sYldm6g3sTHhLQt8jqc0wC/yWUmbRsZmBYtRogg400phl8u0Y7dy9/KAQyz/LWDhUcGNGTM3WiPXxJpokVjdktbn91P5j8MEnDKiL6CSNtM1xBavezEZy39iOyE5DCjXIkUoTzlhEOHo+jmFtGIrVhrkorpyGdLchrqMjGuuPN+VH38fVBcy26N12QaX6wWaZAX6e4PcfmpcoZmCv0uZx9teLHccTq3k6obf3MsExABC68xEn87W6PbKQ2pIbOIidjTyZiwspwz8b3ri7VIKv2Bsd91YDer1DDGWjKx6fUpbUXk2aPgLq5yV4b7GPk0Ndt1PORQLkLkoVYZp7/Qsjqv6yj7Ddpbo8LwdS0p5bFw8l5zqfhcZMD05g9zNmEP+S60c4F4AEKVeiV8IlxZoKmXTVOJYzEPMQmKph0n2LWKGS0XlCtQWjp5egfytISAuBysuCcKgcHX8Z6XKXhF9CYH2KnBcNenyb/EhWWyYMemncqfMHmIy5KRXbp1uUmSOfS36gKr9nIMTVS2sFAS3+WaI+ndCwy5bMhFhMAMrXtguIph6JHhlLeqwJ2JBbDSgQTD21p4apyv2RYoTUACywp948O
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2546.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003)(55112099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?OTc5aU4rajh3SFk0ckxkZG9EV0ZmUTYzbVUrYk9ndW9EbXdSd1dHajBDUXlJ?=
 =?utf-8?B?TDM3a05IWVFXSldHY3FOQjhSNlJIZ1NPM1ZPdzB0aHhUYjFvZDZLTjY1SS9F?=
 =?utf-8?B?ZlpuanJxQzF0WlV6L2d1Ym0zWmhKWUFaS1pLRnh1eWVrL01zcWM1L3ljUUQ2?=
 =?utf-8?B?Tm1QaS91U2VObnZSbDRGUldaVHZXazlGWTgwZGRtaFFkWE45Y2NySEJQSEgv?=
 =?utf-8?B?VkkzazBlUy9SR0VHZlVjY1h2YUFkNmFtMDFmNmVLcTQxRE1oRjdBRDcrU1NM?=
 =?utf-8?B?VjhxL2lLRmkrVFZvWnE0VCtFWHRTWGxhaEorWTcwYURSWUtqR2VEYjFMOVZD?=
 =?utf-8?B?aUVKcnRtalBaUVkrSzA4RnFOcGoyVGhGRUJ1dVAreHRkMXRINWsxRjlhMHli?=
 =?utf-8?B?YWx5ZWMwS0JhMkMxczZYQlgyc0MvTjBMUmFGMFd3aENmaFJVOTBaaGkwakdl?=
 =?utf-8?B?Zno4VlVJRWNCeXNTOVRmK3VOMDBuRVVqME43aVM3ZUtQOWRrc3NlZDZDSEtt?=
 =?utf-8?B?b2liMFAvODI4UXJhOUJUV3g0dmJKcTJFaUNibG82RHhEUytOMGxvNVZkZTBV?=
 =?utf-8?B?WmVIa0FGeFBySDJrNTg2dnNraTZ5aTFjTVR1aWRFbEFLUXM3UTIwZmZ6ZG03?=
 =?utf-8?B?dTduaHBXcGtXb0oycklsUllYZXRKUzY3ckdpclpDcUljM0NWR3JsNHBaUzJF?=
 =?utf-8?B?N2lsOHlXVXpaK0drNnduYjM2ZU90UFBxMC85SnIvSzZtRTlzcE1Gc1JwbllL?=
 =?utf-8?B?OSsrK3doTmdJRldtbHRRdnJSVTBJcnp0UEJJV0xUeEdtdTJBbzQxcGdNQWJn?=
 =?utf-8?B?YUtEOFVmL09zTGNPL1pScWRpU0twOGZMSEtpaXVLV0N2eUNSR21MQy9mT0dO?=
 =?utf-8?B?Q1lKRjF3dkw5Qit3VlVaUVFNemR4SEEzcjY1bWV0ODkyUGJXeThuT3hwVC9i?=
 =?utf-8?B?Um4ycUpUeU1OMGU5K2dMRmhlZXRtQkNvYUNIa3lqN1B5R1ZUeGRyRmxNRHZD?=
 =?utf-8?B?dzVFbk5aMWZISzRLRjRydVBEQlgwejZsOURFMlcvSWhiZ1B4bWV3RDJIMldR?=
 =?utf-8?B?c1lUaE9FSDZFYnljNDVqcEs2Slgxd0tKYU1MNHlTQ2RLK2lsc3hLUGVqTGto?=
 =?utf-8?B?YXVGc0xsclp6SFdKMUJ1d3RMS0hzcjNuNWEzS2crZytSMnVIRFNGNlU1SC9Z?=
 =?utf-8?B?VFlVNWNjUDJQTUNMWWE4S3loVWwvWEdDZE5iK0pSVEloZmxkQ0VhZ0U1SFdF?=
 =?utf-8?B?VURPVWJCdklmdHdzZmd5VmNFL2FseXJRY3dCR0diSnhibCtibm5kUnlQK3ow?=
 =?utf-8?B?NU9vUGxpbVJjYXBhNzRLSWVWandER2xlcEYwZXBReHo4RE96UXhIOVkwdWYw?=
 =?utf-8?B?NE5BejVlWHNPRVpSN2V3RktubXVndy9qaTEzZzl0d1VhQ3VCdFlOVkphLzJp?=
 =?utf-8?B?QWFCakExYUpGbTFwTWNxZFh0dUxHWmFzY29valpOUncwMWQ2OEoxT3dQK3Ns?=
 =?utf-8?B?NGtCZzcvcGVxellpdXZuMCtpVzR4Z1dFK21BWldjYmRmbk5VNXE0dlJtZXlL?=
 =?utf-8?B?Q1BLVXJBTWJUNzZuNGh4OWdCcG1qaEJBdmFFYThpeE1xTk9kZEIvMWNrOUZv?=
 =?utf-8?B?bno5UkVQNVFvRmNqeWFXZFc1c1VzaHdQU2cwL01reW9vOXBRWWdSME9JTG16?=
 =?utf-8?B?eWtvT25mNk9ZaFJaS2FRdi9YNTdqTUFIUzRLTXRwcTZnNjlwRG5iRExqd1da?=
 =?utf-8?B?YUM3dndpVVlvMFd3bFBqU1VpQlFuK05hVjFNSStMQjlvU3NmNU1OdFRCdUNW?=
 =?utf-8?B?SlQ4Q09RYXJzN1J0djhZalYzVlBRYzV0S2pvWFFLRVdZVDRjZXJONTJVOVd0?=
 =?utf-8?B?dTUyK01jVGp2cUxHV2FHWEVDMnE1K09CNjlvKzc4eUNTblh0VE9sa3U2T1ps?=
 =?utf-8?B?SUxOQ3ZhU2FhU2xvWVJjM1dVYWFqdGF1TDh4aVBvcCsrNFp6OEZXWkxwY2pV?=
 =?utf-8?B?TkMxQXE3dXZmRDI4emN3OWJQYVBVUWxCdE50dmE2Vlpudm9TTzlvL0hWV2w0?=
 =?utf-8?B?eEt3ZDdmVU55Rkg1UjFDS0wvSWpuR0pjSGxBUEVCblB1K1BwNXJHV0c4K1Ju?=
 =?utf-8?B?ZHNjeHZ6clVwTXVrbTlyRkRKRkprU3liV0o4N2hJYjgxOGNLOWtiWmhDK25k?=
 =?utf-8?B?bWlRTnhHOXVHajNaOG5WUlh2aTMrcmcwOFBya3VFb2Qxa1J2MUhJVkw0VEhO?=
 =?utf-8?B?MGZubk5EU0ExK0JncXpRazBhZW16ZStNQTlPbGpCZ09yNFNlWVh5M0Z2VFpB?=
 =?utf-8?B?NDUyT0N3WXJBTTAxQU9sNlgwZHJ3Q2ZtSVNKb0ZnSzl0SXZ5VGovUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <550C8B041AD2444B876EC454583D92B3@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2546.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9baeec94-4cc2-469d-41b8-08deac481c27
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 14:51:24.2959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: amT6Ot5/GigZGLB9sBjIUuQGcNQBX+jLMvwAjH6PYJUUMBgKNDeCIa/q2hF1GG7znOVrMLni5pQdMb860kdfcqKi+HHGqO7/kDidsvFpqgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5523
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 May 2026 14:51:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22905

T24gVGh1LCAyMDI1LTA5LTI1IGF0IDA3OjU5ICswMjAwLCBRdWlyaW4gR3lsc3RvcmZmIHZpYSBs
aXN0cy5jaXAtCnByb2plY3Qub3JnIHdyb3RlOgo+IEZyb206IFF1aXJpbiBHeWxzdG9yZmYgPHF1
aXJpbi5neWxzdG9yZmZAc2llbWVucy5jb20+Cj4gCj4gVGhpcyBhbGxvd3MgdG8gcmVzZXQgdGhl
IGRldmljZSBiYWNrIHRvIGZpcnN0IGJvb3QgYnkKPiBmb3JtYXR0aW5nIHRoZSBwZXJzaXN0ZW50
IHBhcnRpdGlvbnMuCj4gCj4gVGhlIHJlc2V0IG9jY3VycyBpZiBhIGZpbGUgZGVmaW5lZCBieSB0
aGUgdmFyaWFibGUKPiBJTklUUkFNRlNfRkFDVE9SWV9SRVNFVF9NQVJLRVIKPiBleGlzdHMgaW4g
dGhlIGRldmljZSBJTklUUkFNRlNfRkFDVE9SWV9SRVNFVF9NQVJLRVJfREVWSUNFLgo+IAo+IElu
IGNhc2Ugb2YgZGlzayBlbmNyeXB0aW9uIGl0IHdpbGwgaW52YWxpZGF0ZSB0aGUga2V5cwo+IHN0
b3JlZCBpbiB0aGUgVFBNIGlmIElOSVRSQU1GU19GQUNUT1JZX1JFU0VUX0NMRUFSX1RQTSBpcyBz
ZXQKPiB0byBgMWAuCj4gCj4gU2lnbmVkLW9mZi1ieTogUXVpcmluIEd5bHN0b3JmZiA8cXVpcmlu
Lmd5bHN0b3JmZkBzaWVtZW5zLmNvbT4KPiAtLS0KPiAgLi4uL2luaXRyYW1mcy1mYWN0b3J5LXJl
c2V0LWhvb2svZmlsZXMvaG9vayAgIHwgIDUgKysKPiAgLi4uL2ZpbGVzL2xvY2FsLWJvdHRvbSAg
ICAgICAgICAgICAgICAgICAgICAgIHwgNDggKysrKysrKysrKysrKysrKysKPiAgLi4uL2ZpbGVz
L2xvY2FsLXRvcCAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgNTIgKysrKysrKysrKysrKysr
KysrKwo+ICAuLi4vZmlsZXMvcmVzZXQtZW52LnRtcGwgICAgICAgICAgICAgICAgICAgICAgfCAg
MyArKwo+ICAuLi4vaW5pdHJhbWZzLWZhY3RvcnktcmVzZXQtaG9va18wLjEuYmIgICAgICAgfCA0
MCArKysrKysrKysrKysrKwo+ICA1IGZpbGVzIGNoYW5nZWQsIDE0OCBpbnNlcnRpb25zKCspCj4g
IGNyZWF0ZSBtb2RlIDEwMDY0NCByZWNpcGVzLWluaXRyYW1mcy9pbml0cmFtZnMtZmFjdG9yeS1y
ZXNldC1ob29rL2ZpbGVzL2hvb2sKPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IHJlY2lwZXMtaW5pdHJh
bWZzL2luaXRyYW1mcy1mYWN0b3J5LXJlc2V0LWhvb2svZmlsZXMvbG9jYWwtYm90dG9tCj4gIGNy
ZWF0ZSBtb2RlIDEwMDY0NCByZWNpcGVzLWluaXRyYW1mcy9pbml0cmFtZnMtZmFjdG9yeS1yZXNl
dC1ob29rL2ZpbGVzL2xvY2FsLXRvcAo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgcmVjaXBlcy1pbml0
cmFtZnMvaW5pdHJhbWZzLWZhY3RvcnktcmVzZXQtaG9vay9maWxlcy9yZXNldC1lbnYudG1wbAo+
ICBjcmVhdGUgbW9kZSAxMDA2NDQgcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLWZhY3Rvcnkt
cmVzZXQtaG9vay9pbml0cmFtZnMtZmFjdG9yeS1yZXNldC1ob29rXzAuMS5iYgo+IAo+IGRpZmYg
LS1naXQgYS9yZWNpcGVzLWluaXRyYW1mcy9pbml0cmFtZnMtZmFjdG9yeS1yZXNldC1ob29rL2Zp
bGVzL2hvb2sgYi9yZWNpcGVzLWluaXRyYW1mcy9pbml0cmFtZnMtZmFjdG9yeS1yZXNldC1ob29r
L2ZpbGVzL2hvb2sKPiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+IGluZGV4IDAwMDAwMDAuLjVlYTMy
ODgKPiAtLS0gL2Rldi9udWxsCj4gKysrIGIvcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLWZh
Y3RvcnktcmVzZXQtaG9vay9maWxlcy9ob29rCj4gQEAgLTAsMCArMSw1IEBACj4gKyMgQ29weXJp
Z2h0IChDKSBTaWVtZW5zIEFHLCAyMDI1Cj4gKyMKPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjogTUlUCj4gCgpbLi4uXQoKPiArUkRFUEVORFMgPSAiZmFjdG9yeS1yZXNldC1oZWxwZXIiCj4g
K0RFQklBTl9ERVBFTkRTIC49ICIsIGNvcmV1dGlscywgdXRpbC1saW51eCwgZTJmc3Byb2dzLCBi
dHJmcy1wcm9ncywgYXdrLCBmYWN0b3J5LXJlc2V0LWhlbHBlciwgZmluZHV0aWxzIgoKVGhpcyB1
bmNvbmRpdGlvbmFsbHkgYWRkcyBhIGRlcGVuZGVuY3kgdG8gYnRyZnMtcHJvZ3MuIFRoaXMgaXMK
cHJvYmxlbWF0aWMgZm9yIHR3byByZWFzb25zOgoKMS4gdGhlIGRlcGVuZGVuY3kgYmxvYXRzIHRo
ZSBpbml0cmQKMi4gdGhlIGRlcGVuZGVuY3kgcHVsbHMgaW4gYSB0cmVlIG9mIHRyYW5zaXRpdmUg
ZGVwZW5kZW5jaWVzCgpUaGlzIGlzIG11Y2ggYmV0dGVyIG1vZGVsZWQgaW4gaW5pdHJhbWZzLWNy
eXB0LWhvb2ssIHdoZXJlIHRoZSBidHJmcwpkZXBlbmRlbmN5IGlzIGNvbmZpZ3VyYWJsZS4KCk5v
dGUsIHRoYXQgd2UgYWxzbyB1bmNvbmRpdGlvbmFsbHkgcHVsbCBpbiBidHJmcy1wcm9ncyBpbnRv
IHRoZSByb290ZnMKdmlhIGV4cGFuZC1vbi1maXJzdC1ib290LCBidXQgdGhpcyBjYW4gYWxyZWFk
eSBiZSBjb25maWd1cmVkLgoKRmVsaXgKCj4gK0RFQklBTl9ERVBFTkRTOmFwcGVuZDplbmNyeXB0
LXBhcnRpdGlvbnMgPSAiLCB0cG0yLXRvb2xzIgo+ICtIT09LX0NPUFlfRVhFQ1MgPSAibW91bnRw
b2ludCBmaW5kbW50IG1rdGVtcCBybWRpciBiYXNlbmFtZSBcCj4gKyAgICAgICAgICAgICAgICAg
ICBta2UyZnMgbWtmcy5idHJmcyBhd2sgYmxraWQgcm0gZ2V0LWZhY3RvcnktcmVzZXQuc2ggXAo+
ICsgICAgICAgICAgICAgICAgICAgY2hhdHRyIGdyZXAgZmluZCIKPiArSE9PS19DT1BZX0VYRUNT
OmFwcGVuZDplbmNyeXB0LXBhcnRpdGlvbnMgPSAiIHRwbTJfY2xlYXIiCj4gKwo+ICtkb19pbnN0
YWxsW2NsZWFuZGlyc10gKz0gIiR7RH0vdXNyL3NoYXJlL2ZhY3RvcnktcmVzZXQvIgo+ICtkb19p
bnN0YWxsOnByZXBlbmQoKSB7Cj4gKyAgICBpbnN0YWxsIC1tIDA3NTUgIiR7V09SS0RJUn0vcmVz
ZXQtZW52IiBcCj4gKyAgICAgICAgIiR7RH0vdXNyL3NoYXJlL2ZhY3RvcnktcmVzZXQvcmVzZXQt
ZW52Igo+ICt9Cj4gLS0gCj4gMi41MS4wCg==

