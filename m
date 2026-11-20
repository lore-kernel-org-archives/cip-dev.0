Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3366.1795171221847641854
 for <cip-dev@lists.cip-project.org>;
 Fri, 20 Nov 2026 02:40:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=I5MF59og;
 spf=pass (domain: siemens.com, ip: 52.101.69.49, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KSNB4uqywXSrEjIRru+PLGjEMliUDVvGV2UXoSRWuUsX6G0bXEdlUgGSotcu/hzxm7cpjWcUGh12aU8rI9myH73WoxcNLTs6MoFQjfl+4sk2aTLufvgVt4RtEtaBkJP3OWXKRsMXQwQwcpBoRIX7SlE6OJlbrRX+hez8TFcy7QqpCmo0nzZsB7bEHO0VzXCEUGEhYgmTF4CNmzPHOEPxe/pRfsc6e0rTQVRR+gGbdlVE8pg7/0OROWaZAy/xWDERuzJiu9+AS1PUbkTLWinkhuFMxK+Zh96KImHyU/Ypa9uwTJS1ddrdHmAaB154/XnWAEuh9VITy5rbnEDIQ+zTNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGLtR9c1rElzfRX1SJNxD3Oa3PX8ZGpxe3uLSXjcYUQ=;
 b=KPBm9J8TXQ4Vt6fTqx9krPr2SrBy9H7bypgp/itgfK675ncVcxnM0QcYkjX6xXRaKj8W3d2JzTGhq0kutvkPIWnJr2eVehIJuwYUEqQfrb8mDNgPXliEWx0PxiUe1wu+QI3Ui7YkjORmuT1k12+NGrfTj1BEe/kf2QSiNl6V4/x9gFGsu4KCsU+mDGERMSWeO3jX+/Fpv0EiS0JXi6HfvATD1lCtKFtmL3kNttZSSYOXoxvZ4bpZCMo0uPS1cOqWQU/RxgJ05PX0qVvRL8A25OQVJTPuRFbeUuKqK46hrc+xMqWThBdOSVznwRq4s9v/mJNLWerBFshCgHGmaZgFdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGLtR9c1rElzfRX1SJNxD3Oa3PX8ZGpxe3uLSXjcYUQ=;
 b=I5MF59oguPIUs/5MpTCTShYsYU9UkW/J4uTuFCL3Feam/GeObgGSJ9qeXJbBrFZ2izfo7dzBXRysr1jUkLvav41Bd2E6z6VvkX0HvFKi40wf+j1svJ4/0g90kQjlp2kRyg0j91E7PosAIf7ywPU4w2feOctEre53eAx46my7hm33F0B2H/fnW90R2cfnpQx92TBLdYY33fB6BN25qyoJxeXhjHGPBn3i8FtvC/rdnYSYOVIhp8gVUvXd3q9LJ7xy8BGupPFmhw0iqfV3ppUHYyzUBDF3nspWVtTAK5lIdRQn4ZA26y6oKhczw3kpPvGDBN/xj6G2gYo8kNqJdxxrSA==
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by VI0PR10MB9100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:214::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.2; Fri, 20 Nov
 2026 10:40:16 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%3]) with mapi id 15.21.0662.000; Fri, 20 Nov 2026
 10:40:16 +0000
From: "Moessbauer, Felix" <felix.moessbauer@siemens.com>
To: "Gylstorff, Quirin" <quirin.gylstorff@siemens.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>, "chris.paterson2@renesas.com"
	<chris.paterson2@renesas.com>, "nobuhiro1.iwamatsu@toshiba.co.jp"
	<nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [cip-dev] [isar-cip-core][RFC PATCH 3/8] ci: deploy zstd
 compressed wic images
Thread-Topic: [cip-dev] [isar-cip-core][RFC PATCH 3/8] ci: deploy zstd
 compressed wic images
Thread-Index: AQHdeMkrfGiVwMvjqU2g68qFY4jFc7c2xXuA
Date: Fri, 20 Nov 2026 10:40:16 +0000
Message-ID: <6a1f155c52deb5d2e23196e13254be69e9221eea.camel@siemens.com>
References: <20261120082554.375548-1-quirin.gylstorff@siemens.com>
	 <20261120082554.375548-4-quirin.gylstorff@siemens.com>
In-Reply-To: <20261120082554.375548-4-quirin.gylstorff@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-10+b1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3956:EE_|VI0PR10MB9100:EE_
x-ms-office365-filtering-correlation-id: 7986a7e5-9acc-4f10-2a41-08df46f2aa57
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|38070700021|261026130827099003|10067099003|261026121527099003|4143699003|11063799006|261026140227099003|56012099006|261022115727099003|261021121427099003|261022113327099003|261021133027099003|261022105027099003|261021130227099003|261021135927099003|261021123027099003|261009223027099003|261026135527099003|261102123227099003|261028144727099003|261022075727099003|55112099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 4ybbeV/n01i0iD43Q1pqWpg/Ml+dqv0atJRWm+12golI3Y4RXf+8l+pbajdcqWFXweehn8R9SFHO/MXTkfTZ6/oa8buumV4HT6WseMxcP/Goc8bFwTzgccPW8rIpicYf9VuL7Qw0mxkFe8Bx1wvG4c/e+Krl0sIJ5W9cPSuH8GxjUIT9JdLlNE/9qZ5X0u2T3IHaO0u8h6Yi/+Z6jXs/qQrQg3RXxJz9qkI3MhV2eQ9iLGcbPTpsx4/wz6aOSyCVV38jSixtxBHHwVpRp/F6mH4uI5Zzr1TYQSEX7VSXu17r3BnOzD6IqkpkE/UGx/tuiXoYeoTIOAslY7NXG9RR3nla3D28oR1cwiA+jE4YdeSxvfqIWSc48pSd0j7XNed2ooS3pLnc7g2horaN1vx/xg3OGJ/0ZwcN2wAxJpuuOgeUpqG3npyADS1pM3cOOLmrmQ2FCI1FA2Sd0twv7gVK2/WUw6QmQynP0QPmDKFmbblMr7cUXhN+ZbqrG3VGgdRMwfiJufMZTY2nu4S1/dbLLTz5oQuKCV4Y41HCxP1XpyqqiUkBpGxV66QgY0b5BVwBPBRzJZq/KawFJC7I1asAv+4+LvjdDEAktSZdVmfhfMTYwWOTwAXnrp9qYCPmn75CRL8Ku4KHaWiw/mWZSL7ASFSGfDfl4CxhK13oqRdPdNv0Vr9a7WH5JJR38tqYV02Sq+WV2VlJmXlm+ojP65txXoCpwj/j2TgRDfOdMYXjvQM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(38070700021)(261026130827099003)(10067099003)(261026121527099003)(4143699003)(11063799006)(261026140227099003)(56012099006)(261022115727099003)(261021121427099003)(261022113327099003)(261021133027099003)(261022105027099003)(261021130227099003)(261021135927099003)(261021123027099003)(261009223027099003)(261026135527099003)(261102123227099003)(261028144727099003)(261022075727099003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlU5cmR5SlpaVmJyN2RLcU1CbzBGVGM5RmRSbWNJa04rS3BRUHZ0ZkZaeW4v?=
 =?utf-8?B?aTJjYkZlejFkTzhJMzRMNUQzZWluaDMxYnl5RW1Ta0xCQkRzUkpNcERnY3RR?=
 =?utf-8?B?UVdrM3hWVWVUb0xmT1RNTzZTVGw1SkdCdzhhZEVOemRGUit0SjUzUFVXNFd6?=
 =?utf-8?B?d1pIay81ZWJBTnZkbnliZ05EbHhwdFptV3htOTBOQmE2aGpaQ1hWNUhiV2ky?=
 =?utf-8?B?Mm9MME82MEtpWTRjNC80WFVEQ1p2ZHdCZnRPZHpNSkZqZlAzMndsVkVGaFJh?=
 =?utf-8?B?R2s3QmtqSE9XOC83c0IydXVZT3NnUnd3TThxQkdwRmtnZWZYUjVZNDVveWtQ?=
 =?utf-8?B?SlJMQ083bmNZNWZXN0w3d1o2OGFJaVpnNnJmamJaWjJVRXRWTHdTV0pHZjJv?=
 =?utf-8?B?VU5qQmNqVXY5WGpmSmhMRTZqSzh5c1FZMU1OblhEK24xQjBQdDVXZmgyRnBv?=
 =?utf-8?B?MllaQy9VMjRZZTgxcnJFWjN5akt0MnhLVEFsY3FJc1FzK0g3TFBySkdYeEJG?=
 =?utf-8?B?NlIxOHFaaE90WmJiRWtFTnUyK3IxQWNwWm5kMlY4OENFa1FnaXBEbE9UdkVt?=
 =?utf-8?B?OU16NUJOL0VZYmZwV0Z4eE9pS0JzeUpaMUthcm9TdlRVYm5rUlRRaU50bWp4?=
 =?utf-8?B?TSt6eFBVMXhBY3pKaEhLK1ZORlhZS0lPTFduL21GNkZrZ0l1OHNISko5S0dM?=
 =?utf-8?B?QkhNQ09vVkdsam9CU0pIZXNhNmlkVyt6S2xuNlQvT2FETjdlSkNtYWM2aWU1?=
 =?utf-8?B?b3dRM0Fuajc4dWFiMmp6cFpueTMzWUdoNmdGaTlFL2VvT0h6RVdyVXpwVGVl?=
 =?utf-8?B?N2pZTmhnRlFWMHJxSmZUTEYwTzRqczQvWVRHb0Zrcm92Y1U3MFdCd1BKUjR4?=
 =?utf-8?B?OTBCMko0Vk11b1R4dnlPcEJVU1FYZUdWRXFLYklXL3diQWhPWjZvcEVUMTVN?=
 =?utf-8?B?aEFkYnE5TklIaTM1VWxwSWpwN1dSaW9hRytPUjArWlYzRnlRWlFJZ2srNlF5?=
 =?utf-8?B?Z2FtRGtNa1IzTHFpSVhtWUd3eEJVRWdlVTBuZzd2aGlHUzMvR0dja2d2ZTlx?=
 =?utf-8?B?elg3enJRd21KNm1ib29NYTQwait1eDJGb09nUC9CWUVNZmpiS1NHenNvT0Ex?=
 =?utf-8?B?ekdyS0wrY2FBOERNM1hmR2RFQVNtOEpPLy9hVStiUnJ0elRZQmRjWllLTTZj?=
 =?utf-8?B?c09ZL0Y4L3FQYXFyeGZBREdHTE1CK0xiMnpKYVRNRHYydDBya2hxanpOTmwx?=
 =?utf-8?B?M2JiRlg1cWZ2WWoyU0xWK0d2b0QvQUxlaUt0dFRJMWFVUWdNOHFvZjdYbzNN?=
 =?utf-8?B?bm5aL01qZURhMSszbE44OExGSTZYaTNTOUtPZ3grcXRLZTIxMW40V1Eza213?=
 =?utf-8?B?dTdFdjNoUWcwL081OUtNMC9QblhYUEg0NGpRKzBGUk5BQmpMRWZkM2ZQTysz?=
 =?utf-8?B?QVpvUXU1SGxXTUdUeG5mV3VJaE85OXpjb3J0TVRwS1Z3cnRHNGdxb3RJb0Ju?=
 =?utf-8?B?ZzdHUWVvMkF3YktQczQyRHhOSDVHMGVmOE9JeHJhY3dHQjhwMGl5NnpaY2dM?=
 =?utf-8?B?ZGlJUUtoczNKZCtJMmFJRjZCV0xoK1VuVlVuWHgyZTlYU3RHbi9IQ0VndW0r?=
 =?utf-8?B?MWRGSlFtWUxmOTNVRlZ0UTdmbzJhYi9zblFXTFJYREcwbCtYNFNyVTVoVWV0?=
 =?utf-8?B?TzdNYXNQMkI0ajQ1ejRBeVJwakhhWjl2MTRlMjlpeSsyMkF2TFl3cjRCczdJ?=
 =?utf-8?B?OUpFS2E0QzUxK0o4VXdIVWZOL21rcGJuYThabUNlbzhHQTdPVUlsbkJxamMy?=
 =?utf-8?B?RkZhWGNZYmxleXIyank1VHQwRDM3UGtxY0I2cDIxakE5SHI3WFc3a2lQZmI1?=
 =?utf-8?B?cEQyajZOK2tPcGRpbDRiZFVxK3ptcCt5Vm5IdnEwbktOaHdMZVFWRzZCWGJm?=
 =?utf-8?B?T3dzU3N2dFQ2d2M1K1J5aVo1KysvR0xPN3RrTmNwSjF3RFBVdTNLKzcxckpT?=
 =?utf-8?B?NWpCOGRMcDZzN2NLb1J3Mit3b0F3YW0ra0VyYkZHM2ovaDVqK01rMXhBaWx1?=
 =?utf-8?B?QS9zSkRmU2dwbnY1V0tSZDNRZndtcjV2anYxQklpbDJiWTFmaExnNzcyRkNa?=
 =?utf-8?B?bm1oaHJsd0gwV3czQzBwTTdHZW9BVXozeVo4NG91cEJ1NUtRcjFkcHJBb2dP?=
 =?utf-8?B?ZkFXMXQ0VW9aaEZIUkd4aGdxQVBaN1dLY0phWjQ3a09XZTNQR2tzbGdqOVRm?=
 =?utf-8?B?ZGNqU05OM0ZqSnRHZ05Ec2RQYVRnUkl4ZTN4N2pETTh6aEM3MWVQUEJLYkk1?=
 =?utf-8?B?KzAxS3RTZFdPdk9Oa1RGVkNyaU1qYWg1aG5SaFRlVlFwTUFxQzE3QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2798B32F887BED4B9DD9953CC700F776@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7986a7e5-9acc-4f10-2a41-08df46f2aa57
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2026 10:40:16.3724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r1OKkwm71DFWfbY0Z2kO3TTJAZq03QTEn2PC6/NIuOdQKdYj0JAJ8gFbr9BoRBO/5VoceaDGdIRfIrX65HQ2Sq1iNT5+rx43sSkeelBWu40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9100
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 20 Nov 2026 10:40:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25038

T24gRnJpLCAyMDI2LTExLTIwIGF0IDA5OjI1ICswMTAwLCBRdWlyaW4gR3lsc3RvcmZmIHZpYSBj
aXAtZGV2IHdyb3RlOgo+IFRoZSB3aWMgaW1hZ2VzIHdlcmUgY29tcHJlc3NlZCB3aXRoIHh6IC05
IGluIGRlcGxveS1jaXAtY29yZS5zaCBhZnRlcgo+IHRoZSBidWlsZCwgYW5kIHRoZSBMQVZBIGpv
YnMgZGVjb21wcmVzcyB0aGUgaW1hZ2UgZm9yIGV2ZXJ5IHRlc3QgcnVuLgo+IAo+IExldCBJc2Fy
IHByb2R1Y2Ugd2ljLnpzdCBpbWFnZXMgKElNQUdFX0ZTVFlQRVMpIGFuZCBkZXBsb3kgdGhvc2UK
PiBpbnN0ZWFkLiBUaGUgZGVwbG95IHN0ZXAgbm8gbG9uZ2VyIGNvbXByZXNzZXMsIGFuZCBkZWNv
bXByZXNzaW9uIGlzCj4gYWJvdXQgNC41IHRpbWVzIGZhc3RlciAocWVtdS1hcm06IDIuMi0yLjgg
cyB3aXRoIHh6LCAwLjUgcyB3aXRoIHpzdGQpCj4gZm9yIGFsbW9zdCB0aGUgc2FtZSBzaXplIChx
ZW11LWFtZDY0ICswLjcgJSwgcWVtdS1hcm0gKzAuNSAlLAo+IHFlbXUtYXJtNjQgKzcgJSkuIFN3
aXRjaCB0aGUgd2ljLXBhcnRpdGlvbnMgYXJjaGl2ZSwgdGhlIHJlcHJvZHVjaWJsZQo+IGJ1aWxk
IGNoZWNrIGFuZCB0aGUgTEFWQSB0ZW1wbGF0ZXMgdG8genN0ZCBhY2NvcmRpbmdseS4KPiAKPiBT
aWduZWQtb2ZmLWJ5OiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMu
Y29tPgo+IC0tLQo+IMKgLnJlcHJvZHVjaWJsZS1jaGVjay1jaS55bWzCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxMCArKysrKy0tLS0tCj4gwqBjb25mL21hY2hpbmUvYmJi
LmNvbmbCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAy
ICstCj4gwqBjb25mL21hY2hpbmUvYmVhZ2xldi1maXJlLmNvbmbCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHzCoCAzICstLQo+IMKgY29uZi9tYWNoaW5lL2RlMC1uYW5vLXNvYy5jb25mwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMiArLQo+IMKgY29uZi9tYWNoaW5lL2hpaG9w
ZS1yemcybS5jb25mwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMiArLQo+IMKgY29u
Zi9tYWNoaW5lL2l3ZzIwbS5jb25mwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8wqAgMiArLQo+IMKgY29uZi9tYWNoaW5lL3J6dDJoLWV2ay5jb25mwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMiArLQo+IMKgY29uZi9tYWNoaW5lL3RpLWFtNjJw
eC1zay5jb25mwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMiArLQo+IMKgY29uZi9t
YWNoaW5lL3g4Ni11ZWZpLmNvbmbCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fMKgIDIgKy0KPiDCoGthcy9vcHQvZWJnLXNlY3VyZS1ib290LXNuYWtlb2lsLnltbMKgwqDCoMKg
wqDCoMKgwqAgfMKgIDIgKy0KPiDCoHNjcmlwdHMvZGVwbG95LWNpcC1jb3JlLnNowqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTAgKysrKy0tLS0tLQo+IMKgdGVzdHMvdGVt
cGxhdGVzL0lFQ190ZW1wbGF0ZS55bWzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDQgKyst
LQo+IMKgdGVzdHMvdGVtcGxhdGVzL00tQ09NLXg4Ni55bWzCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfMKgIDIgKy0KPiDCoHRlc3RzL3RlbXBsYXRlcy9zZWN1cmVib290X25lZ2F0aXZl
X3Rlc3QueW1sIHzCoCA0ICsrLS0KPiDCoHRlc3RzL3RlbXBsYXRlcy9zZWN1cmVib290X3RlbXBs
YXRlLnltbMKgwqDCoMKgwqAgfMKgIDQgKystLQo+IMKgdGVzdHMvdGVtcGxhdGVzL3N3dXBkYXRl
X25lZ2F0aXZlX3Rlc3QueW1swqDCoCB8wqAgNCArKy0tCj4gwqB0ZXN0cy90ZW1wbGF0ZXMvc3d1
cGRhdGVfdGVtcGxhdGUueW1swqDCoMKgwqDCoMKgwqAgfMKgIDQgKystLQo+IMKgMTcgZmlsZXMg
Y2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgMzIgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdp
dCBhLy5yZXByb2R1Y2libGUtY2hlY2stY2kueW1sIGIvLnJlcHJvZHVjaWJsZS1jaGVjay1jaS55
bWwKPiBpbmRleCA3MjA4OTY4NS4uYTE1NmVmZGMgMTAwNjQ0Cj4gLS0tIGEvLnJlcHJvZHVjaWJs
ZS1jaGVjay1jaS55bWwKPiArKysgYi8ucmVwcm9kdWNpYmxlLWNoZWNrLWNpLnltbAo+IEBAIC03
NiwxMiArNzYsMTIgQEAKPiDCoMKgwqDCoMKgwqDCoMKgIGxvY2FsIGJhc2VfdXJsPSIke0JBU0Vf
UzNfVVJMfS8ke0NJX0NPTU1JVF9SRUZfU0xVR30vJHt0YXJnZXR9L3JiL2J1aWxkJHtidWlsZF9u
dW19IjsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqAgbWtkaXIgLXAgIiRkaXIiOwo+IC3CoMKgwqDC
oMKgwqDCoCB3Z2V0ICIke2Jhc2VfdXJsfS8ke2ltYWdlX2Jhc2V9LSR7cmVsZWFzZX0tJHt0YXJn
ZXR9LndpYy54eiI7Cj4gLcKgwqDCoMKgwqDCoMKgIHh6IC1kICR7aW1hZ2VfYmFzZX0tJHtyZWxl
YXNlfS0ke3RhcmdldH0ud2ljLnh6ICYmIG12ICR7aW1hZ2VfYmFzZX0tJHtyZWxlYXNlfS0ke3Rh
cmdldH0ud2ljICIkZGlyIjsKPiArwqDCoMKgwqDCoMKgwqAgd2dldCAiJHtiYXNlX3VybH0vJHtp
bWFnZV9iYXNlfS0ke3JlbGVhc2V9LSR7dGFyZ2V0fS53aWMuenN0IjsKPiArwqDCoMKgwqDCoMKg
wqAgenN0ZCAtZCAke2ltYWdlX2Jhc2V9LSR7cmVsZWFzZX0tJHt0YXJnZXR9LndpYy56c3QgJiYg
bXYgJHtpbWFnZV9iYXNlfS0ke3JlbGVhc2V9LSR7dGFyZ2V0fS53aWMgIiRkaXIiOwoKV2h5IGRv
IHdlIGV2ZW4gZGVjb21wcmVzcz8gVGhlIHpzdGQgaW1hZ2VzIHNob3VsZCBiZSByZXByb2R1Y2li
bGUgYW5kCmRpZmZvc2NvcGUgaXMgYWJsZSB0byBoYW5kbGUgLnpzdGQgZmlsZXMuIFdoeSBub3Qg
c2ltcGx5IHBhc3MgdGhlbSBhcy0KaXMgdG8gZGlmZm9zY29wZT8KCkZlbGl4Cgo=
