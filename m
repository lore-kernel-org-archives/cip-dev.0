Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C90F3382B
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 09:32:46 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.71786.1773739962777841245
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 02:32:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=DJFW0sQa;
 spf=pass (domain: siemens.com, ip: 52.101.72.56, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abm3Z5mMUqVXNjxGSH+Ln//HDXOeNDLh6EK3wfgPYvyC/GjGTW+dD96IUlSZb4b7ddWMLeOnef7R63+7pdNUuvvsgKmOJOzn8zAI5/Ax28UhqS3zSFGO1ublD/kkbmi8aiU7fsG2UdlMG1NcFxewKTw+5xS9RRMeoZq2mrQRB1z6xPU5xJB6Zupn2q85PFKRWPq50Z6f1LGoFMKFWcyLAwIxW6m539/yP/bl/M9fcYoGLlOu72Glk4KfaFkftSJKwjh0AuTG8JUe1bZOcxAaivHp5/KnRAW046Ydoi33Iu+7gVlkxkOQxCCifRXDeOKeINKZiWxIgsjqxUuboXEDZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckqv5lNo23q+KaczBEZzuLXrAU9tMIMqeLmDJbUgsoA=;
 b=dNLo3Px1dBEV2PJ1X/3XZXULJHDOk8LvePYwyKqp73X54RhtO787QZ5vupk7Z39GCkCNt4u39xpNO+zT6kkOltUROEwlvlT+GsDTr28e3Ei6FSgJ7i2wq3hCzEve+Ju7JGCFqx/egCmAWhz33zk3PHNxuWFD29ml4i1aQaN9MI2L8eqdilH0mWl95A5N6xGTQJnByZPLCypCmNETzczfAT0zyigJYWWlBlJMoRgxZ8UDaUsANKrl9l4NSaVNsGbDOMoqMsSgZK2r56vIKyGQCneM6lgFChy+judOjV+Xthwu+joDaEnhrJxZeoJokVsPniLJKnBvSbsge3H7DKRPOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckqv5lNo23q+KaczBEZzuLXrAU9tMIMqeLmDJbUgsoA=;
 b=DJFW0sQagx9cwJucLHX5q/cgwXLjudTqe3s7duHFDeKQFEj8dGzF6dcKM5EGsacf3OJueD4idJgqysxxx6CYNrv4YDSbYmam7UlFDqLiNIvTZxJlL1w7yc4b6gVPayOoGrvYjl0ZgibQAkP0X4JNKvUsHqgWHAOmyfunw/YL/N04BwrONqFXew1y/r9KM7fVyc8h2KWzsOdJfXo9twq3FaHsklvafVoqrdwmA9LEbG0z+6zTh6a/dw7ztuKqJzrFG30JFStHrydYgc20cKsITpqWsE9xlphI//8x3r0qMXSsdxTJ3/5PpEGlowUNnjqVYltPSn1P3z2zdy/nsdrc5w==
Received: from AS8PR10MB7349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:617::15)
 by DU4PR10MB8832.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:560::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Tue, 17 Mar
 2026 09:32:38 +0000
Received: from AS8PR10MB7349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::900a:259b:ae7b:828]) by AS8PR10MB7349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::900a:259b:ae7b:828%5]) with mapi id 15.20.9700.018; Tue, 17 Mar 2026
 09:32:38 +0000
From: "Heinisch, Alexander (FT RPD CED SES-AT)"
	<alexander.heinisch@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"Moessbauer, Felix (FT RPD CED OES-DE)" <felix.moessbauer@siemens.com>
CC: "Gylstorff, Quirin (FT RPD CED OES-DE)" <quirin.gylstorff@siemens.com>,
	"Kiszka, Jan (FT RPD CED)" <jan.kiszka@siemens.com>
Subject: Re: [isar-cip-core][PATCH v2 0/2] wic: Wipe LUKS2 header of rootfs-B
 on bmaptool copy
Thread-Topic: [isar-cip-core][PATCH v2 0/2] wic: Wipe LUKS2 header of rootfs-B
 on bmaptool copy
Thread-Index: AQHcrXSkL7kB5ulDukesX+8pZCw6B7WhkD4AgBD2zYA=
Date: Tue, 17 Mar 2026 09:32:38 +0000
Message-ID: <0216f21e7481eb83ade9c3b56ffb4dafd16599f6.camel@siemens.com>
References: <20260306142213.1273718-1-alexander.heinisch@siemens.com>
	 <d4adc9e349cf327841c690df4fd167fe5401940d.camel@siemens.com>
In-Reply-To: <d4adc9e349cf327841c690df4fd167fe5401940d.camel@siemens.com>
Accept-Language: de-AT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-0+deb13u1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB7349:EE_|DU4PR10MB8832:EE_
x-ms-office365-filtering-correlation-id: 9af84906-a530-40c4-fbe0-08de84082121
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|18002099003|22082099003|56012099003|55112099003;
x-microsoft-antispam-message-info: 
 SM1VyBU9vD62FrJe8HXyE7sz5haessQOF9tUc9JUzRxwITssrobJxof0cjUMIsFyHBNGnqCw1KOs3ZsVGgFZMlf/LMoMqtIUmcQHRo5cFTQRQVDU5xeqrACGHgs7Kpw0IQ17t/xAyJDUp/EReYLDA0o09YBtfv0bhezpAXEjoYLs9qPUhEZqm5jiJicZZLznZWIHPHvNjT5kxk2SvLagTICFC9RQiZlBkkpaTzL6UWbVFif33BKlWL6yraZlnawU3UIYxMxEPv+fIEuQMDkdCjMqXkoDr9ZN2HS/lu6P5gD+7lLyLGAp+qn0DcRjEBSx/YgUn9FD9JW6I7njJJWQEga0ddw2w4mYNzGUNGvNszLyDZ1Q4sNs8XcVOvUmtLtTMvn2mrmEqDLeHy5MmUVySa1ycDIHsHkyw/HzE2LzH7nl5tXQXUmjTlVktFZoWLtFtD4qKwEusSCmTtNQuO4Z/a5CewMHumno80a1gv6Af745W1fsGZyS+HxWjdCKnEbrPfjMgqySiWTXPPEerymwOwOzmpZlnhPKr0QB2bbxVuWeH4Tw4oae42GNGX9hxZ7MF0i8+2dngcWd8W1S7Rig2PbJNda9Lp7emwU48uFa3rayzpwmqd2SIiJD5qxaZMuOgOX2cL0Fwlw+U3he49J3BXxKsFY88Lf+hk24ABrXRIcpNMg9vRlg8HJavGZ2ecqOtdBCz6eb01JBFhaPhp9JJuf0aMevuwuyXa3syBGSmq3Aa8JSVk3fKNeAovMOZTEb
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB7349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(18002099003)(22082099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?QTNBaDUxbmlFRkUvUmpQNmtDRjYwNkxJUkhNTkxRUGNkUmlEd1FBdHRhclo2?=
 =?utf-8?B?WXlKVTVOYVlvUHZmekQ1bjFJZHorQyttemVwQ1NsSWZnRGlMTVcrSkdrZ09K?=
 =?utf-8?B?dGVZenlwaVBWK3UvZlR2OWR3dTBPWVpTN3VhVmM5MXo4enRVNXdrRC9iSEJC?=
 =?utf-8?B?QWVBL3NWK2hJMDhWQ2p2Y1pReXpVOVkwVFQyMGlVUEFmM0Ivb1R6OFI4VWpw?=
 =?utf-8?B?K1BhS2tnRzRMNlZnSXVRUFhpcG5QeWpUZHF2eXQxREtuOTZjQjFOaTdUbkI0?=
 =?utf-8?B?WkE4WHBtM2Rod3d2ZHJzcHNiREUwb3l6ZlcyOTFpQU10aFhEbVI5TTdSTExo?=
 =?utf-8?B?OCtJOFNuVXRmRFllN1BkMElIRjBobDhLYWhEQ1ZRN1Rzdngrc2pCUWRlUFNx?=
 =?utf-8?B?eVBselE4S0l6RmZhV2pEVHdhcHhKd1NJbCt2Sm05dW5KZzl6N1lGdDFWdUlY?=
 =?utf-8?B?WURvbXdzRHZwTFF2SFdPUXpNUi9SRmtEZFJOd3lmWG45TXVYOWdoRjI0MkRB?=
 =?utf-8?B?K2xONk9NT0tORVNnUnFjditLK3NkcVovWE9kMVFNMGl6UkNHYlFKYUpiZXdj?=
 =?utf-8?B?emVBMi9ZNHkwa2dLMjlWa3IwaGFHQVFZdTZ3Q2wxbHVUZkV4b2R2QmlnNDVI?=
 =?utf-8?B?b0FLdU5pTHRqcmllOVNyVDFIbWhkek1MdzVEdHoyOFBScmthd29URmY2b0tn?=
 =?utf-8?B?cjFZUkdpcHIvT0xyVDZMazcyM05HUjMvd3VLWGs0bDZVcnVxNDFtWFRxa0t6?=
 =?utf-8?B?U1FPM0xpRUlaVW9QWi93MDlSRVBFNUhkWmZxN1NqdFdkSGcxWERVeWlxcytk?=
 =?utf-8?B?NUYxK0VyOEJCNzdUQ00wbkJURzRlak8yMDMxa2ZjV0pEZGYrNE9ycHpIUzJU?=
 =?utf-8?B?L0VwdFZZQ1F3WlVORUNsUHVQZFhEQ1FMS0RIRm1iTy9GdlhLYTRWbml5c2U4?=
 =?utf-8?B?Ykl6bGU0dnBxMGZwZVRFaFpzTEt2MGpyNDczYWJpYlkwSFZrMFJFOHdFZGhv?=
 =?utf-8?B?UFFWNlFQS1dDSUJNNEJPbDJ6NEFnTmF2SWFvWC9XaGZXckZwOVpCUjg2ZSto?=
 =?utf-8?B?NEJJOFF1eWFPNTNVOWVaUi85VC9xSmlpVkpzTi96RXVYaDZWQ1YvV1p3MW40?=
 =?utf-8?B?MEExWWFpQmRuVFRlT3Nac2Nqem5KV2oyWTgycTJQcDdjenp1NUYyYUV0bHow?=
 =?utf-8?B?WGFFOEpxbTZVcGw0MHVuRWlUc1NlanB3VlVsVlBYM2Z3NGNhVnJQVjMyT0N2?=
 =?utf-8?B?OHlLQnFUUjl3UEo2SEw1aDVVMVdYb3hFUVQrS1dYaFl3OC9JZzVTaFdzeUZZ?=
 =?utf-8?B?aWNwdXp6MXlKY0RKRFdENFk5OTFWcG9KM1NsT2h2VThOZE5rZWNKSzJZVDFh?=
 =?utf-8?B?RS8zdi9TWVg0cFdNTktPMEJhc1dISGVQeU1zejhKZHNuNkJ2ekhEVE1PQ3Ba?=
 =?utf-8?B?UjNrM2JNNTBSY01RaSs2YUVsaVZEWitSY3o0NXdrbUxvM0IvdnBLVFFxRUxm?=
 =?utf-8?B?L3czUk5PUkNEbEVncXBQSjhtMDBIdHZQQUZZU2xETTdPczQwak8xVFZwSVcr?=
 =?utf-8?B?a0N0ZU1GMWlKUUJ2SExxdjhDRklscmU0S0dWdVl6TkJ5aExpYTc2d21WYnp0?=
 =?utf-8?B?UGh1anIxL2NkekhkbDRReDdzZGc0WndkMGVwWXgvTlhuMmoxcXlDVUdTaGRC?=
 =?utf-8?B?dno0Q2pUOWVuWXJ1L1RGK0tFdC9VZTY4ZmpjeGhKa0M0NTBWclY2RmpsTUNP?=
 =?utf-8?B?ZGxiUVRFaGV4VnVscFNOL0NJdnQrOWhOajdwOHBWU3pzQWh6S2tDdkt6ZW5v?=
 =?utf-8?B?YUhNeUpIaFBCTTZXbnUxZkJwZUNUUzFlVnhJbmJveG02cG10NXJwS0dDemFh?=
 =?utf-8?B?emg4SlN5Wk53NElhemJvdUtXbnk1WnRCeU15bFFqMVF2WDFJTVpGMXQ2Njh3?=
 =?utf-8?B?dGxJdmRMWWVMa2UyT0p4cE1vUy84S1lrRE51QTgwOHdhZURPWTRyRW01RFI5?=
 =?utf-8?B?VGVlZW9qam93VHhSM0kxVW1TeDA0NkJWTGhrN0lEUWtzd2lpK2JmdTZOSWFC?=
 =?utf-8?B?L0pMUVQ5ZTFIamN6Tlh4cFRtOFg4ZnRINzNlSDFSNnJGalFYaWZEZzduNnVM?=
 =?utf-8?B?N3EwRzBsd0Z2V0dsWDZ5c1JLenhVQnF3S1I5dGVzOFZlRDNyMkpSQ28rQXEw?=
 =?utf-8?B?b3AwbTlIZG5nMitpZ1NBNmhVZnN6cnBtSEMrSGFkYTZDV2RNWDNRUjIzbkp4?=
 =?utf-8?B?OEptWktzSXJrVU01UWJONGJaSHc3c2ZXZ1JkaG1vOUMwWG1JaGJnMkN4Mzhr?=
 =?utf-8?B?Mnh2Y1dqbHhpN2dTVzZCWDR4azFoWTFlQ3ZMS0YwNE9RRWJDSkFCMEJXQTUz?=
 =?utf-8?Q?uOD+lOYVqJhiJkpJ/F1H6v1Ab8nmaS5FT2cT7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C92172A3272C8E459067DDAB16F35721@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB7349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af84906-a530-40c4-fbe0-08de84082121
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 09:32:38.3559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hDwI37vSLPPa8NCCFh2ry6Zne3KqCHFg8zf6V+sV1A3HRIlAAkIitp5SybSrN1NwoUoaLW9KnEcY6JATCnP1ssY4xDVvl0FCrSrt5teqXhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8832
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 09:32:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22431

T24gRnJpLCAyMDI2LTAzLTA2IGF0IDE0OjI5ICswMDAwLCBNb2Vzc2JhdWVyLCBGZWxpeCAoRlQg
UlBEIENFRCBPRVMtDQpERSkgd3JvdGU6DQo+IE9uIEZyaSwgMjAyNi0wMy0wNiBhdCAxNToyMiAr
MDEwMCwgYWxleGFuZGVyLmhlaW5pc2NoQHNpZW1lbnMuY29tDQo+IHdyb3RlOg0KPiA+IEZyb206
IEFsZXhhbmRlciBIZWluaXNjaCA8YWxleGFuZGVyLmhlaW5pc2NoQHNpZW1lbnMuY29tPg0KPiA+
IA0KPiA+IFRvIGNvcHkgaW1hZ2VzIGBibWFwdG9vbCBjb3B5YCB1c2VzIGEgYm1hcCBmaWxlIHRo
YXQgbWFwcyByZWdpb25zDQo+ID4gdGhhdCBhY3R1YWxseSBob2xkIGRhdGEuIFRoYXQgbWVhbnMg
ZW1wdHkgcmVnaW9ucyAvIGhvbGVzIGluIHRoZQ0KPiA+IGZpbGUNCj4gPiBhcmUgc2tpcHBlZCBi
eSB0aGUgdG9vbCBhbmQgdGh1cyB0aG9zZSByZWdpb25zIG9uIHRoZSBkaXNrIGRvIG5vdA0KPiA+
IGNoYW5nZS4gLSBUaGF0J3MgYWN0dWFsbHkgdGhlIGZlYXR1cmUgd2h5IGJtYXB0b29scyBleGlz
dHMuDQo+ID4gDQo+ID4gV2hlbiByZWluc3RhbGxpbmcgYW4gaW1hZ2UgY29uZmlndXJlZCB0byB1
c2UgQS9CLXJvb3RmcyBhbmQgZGlzaw0KPiA+IGVuY3J5cHRpb24NCj4gPiB0aGF0IHdheSwgdGhp
cyByZXN1bHRzIGluIGEgTFVLUzIgaGVhZGVyIGNyZWF0ZWQgZm9yIHJvb3Rmcy1CDQo+ID4gZHVy
aW5nDQo+ID4gZGlzayBlbmNyeXB0aW9uIHNldHVwIG9mIHRoZSBwcmV2aW91cyBpbnN0YWxsYXRp
b24gdG8gcmVtYWluIG9uIHRoZQ0KPiA+IHRhcmdldC4NCj4gPiANCj4gPiBUaGUgcHJvYmxlbSB3
YXMgaW50cm9kdWNlZCBpbg0KPiA+IDYzZWVmMmI0ZmI1ZmViMzkzZjk3Y2VjYzRmNDMyNjg4NDAz
ZGVkNWQNCj4gPiBieSBub3QgY29weWluZyB0aGUgcm9vdGZzIHRvIHJvb3Rmcy1CIGluIHRoZSB0
YXJnZXQgaW1hZ2UsIHdoaWNoIGlzDQo+ID4gYWN0dWFsbHkgZmluZSwNCj4gPiBidXQgbmVlZHMg
c3BlY2lhbCB0cmVhdG1lbnQgaW4gY2FzZSBvZiBlbmNyeXB0aW9uLg0KPiA+IA0KPiA+IEJhc2Vk
IG9uIGRpc2N1c3Npb25zIGluIFYxIHdlIGRlY2lkZWQgdG8gZ2VuZXJhbGl6ZSB0aGUgZml4IHRv
DQo+ID4gYXBwbHkgdG8gZmlsZXN5c3RlbQ0KPiA+IGhlYWRlcnMgaW4gYW4gQS9CIHNldHVwIHdp
dGhvdXQgZGlzYy1lbmNyeXB0aW9uIGFzIHdlbGwuDQo+IA0KPiBSZXZpZXdlZC1ieTogRmVsaXgg
TW9lc3NiYXVlciA8ZmVsaXgubW9lc3NiYXVlckBzaWVtZW5zLmNvbT4NCj4gDQo+IFRoYW5rcyEN
Cg0KQW55dGhpbmcgbWlzc2luZyBmb3IgdGhpcyBwYXRjaHNldCB0byBnZXQgbWVyZ2VkIGZvciB2
MS4xMT8NCg0KQlIgQWxleGFuZGVyDQoNCj4gDQo+IC0tIA0KPiBTaWVtZW5zIEFHDQo+IExpbnV4
IEV4cGVydCBDZW50ZXINCj4gRnJpZWRyaWNoLUx1ZHdpZy1CYXVlci1TdHIuIDMNCj4gODU3NDgg
R2FyY2hpbmcsIEdlcm1hbnkNCg0KLS0gDQpBbGV4YW5kZXIgSGVpbmlzY2gNClNpZW1lbnMgQUcN
Cnd3dy5zaWVtZW5zLmNvbQ0K

