Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858E8CA5FDD
	for <webhook@archiver.kernel.org>; Fri,  2 Oct 2026 15:16:02 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.28])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14751.1790954156439133520
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Oct 2026 08:15:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=F+/8KJ4+;
 spf=pass (domain: siemens.com, ip: 52.101.84.28, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHvuOiHzDQ7Fs6WrMUFljKIm4N/1zFzsiDGa35Z+vQyinHjqIoMvV17oOJGM0CarWbZTQjsfwDHA/WfMqg1T4lCJc50jKzEBBGMyyJaUCmVHlqvHU+0IqIsy6+kzADNdhEV6A1lsUEgeN54FaWwGEIip/OBS/AEk+tWnMIL02rEHAfeat7zeKwxqhaRCyHyjciXLts/pvy9EEFk+i0p82qeDC2tV2JQNK01YnglyKBkNDG7aA+0D/8xJeFEBLcqobWGiphn/xWBV0kuZ5Z9rxngxR3VnjMaCaJnqVOY62EmD7ezB59L8jPU3ZAt3EJR+J7ubQNcPMBH1aLKD7RDq/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOjG71MMDBJGfbWngOJ6rRMy8Qr2zdHKhTBKYmBxp+o=;
 b=mnKNFFwFcgYtSZb2p5NA7RC1eROYopYjWG+BO8rYK/4KOP1rArFP5uwX2B3nh84A7VV1j1RQU57W5n+vbhg7jUXDPM8wfqR85dbe95TJeThwjyM5WgQ2DFgzbR79LebY2l7ch9RnQgdIYTv8Tbabn16mz40QU/sR9TSSPU0JJMZ+O8oq77SCRHXdgLpkTOZfiGXy/TwH8MUEoMiXEU8q2sQNtMb+4S54Q9hAVpqpCfSPVv+ew5FnhwzkRmHUU5y+fg6G/IxfhXmeWPWfCZaCQD5kquOfIrX9vcr6YcCIxQUDvK2dPVjXMJG7aDPjGagqJt6y1HYGrsr5y0qQHHzFng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOjG71MMDBJGfbWngOJ6rRMy8Qr2zdHKhTBKYmBxp+o=;
 b=F+/8KJ4++yHeGUn9FGOFCGGBVyl7r9KszQr1J+x17oO/bCV5mfpuwrO2oJZX9yI2j36OA+mzXvNTadY9Yc3znpXlUC0+aUUfIrn2n1qvFpMhhhnRfqmU6nePFc2WnZEJmfhBBW/zpkWtBfNuepmU1fYXnjvLeUtnMC1Psio7H8bdYVPvm3gLdceXOhBJ+En9zuwBcb2t/l6DX8hxvzrpXt0fLISQ5sWALJH15D0aocf2k8fX5OzCahe2OWAVUN0k6xJAXcP9th2KBf2xHaxquXK5qhQL/OcCUIV5pjSUnrklzHeVAYj+75vNjQ7tbPuDSjNoTIZtyceZDimeCOLIpw==
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by GV2PR10MB9801.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:329::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 2 Oct
 2026 15:15:52 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%3]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 15:15:52 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "Gylstorff, Quirin" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, "Hombourger, Cedric"
	<cedric.hombourger@siemens.com>
Subject: Re: [isar-cip-core][RFC 08/11] cip-core-initramfs-dracut: add dracut
 initramfs
Thread-Topic: [isar-cip-core][RFC 08/11] cip-core-initramfs-dracut: add dracut
 initramfs
Thread-Index: AQHdUl/zuordmtMoXUae2yiPwCH62rbqXRKA
Date: Fri, 2 Oct 2026 15:15:51 +0000
Message-ID: <406608c4c1988ae22f0f1a5561a80b3d588da250.camel@siemens.com>
References: <20261002111938.3600786-1-quirin.gylstorff@siemens.com>
	 <20261002111938.3600786-9-quirin.gylstorff@siemens.com>
In-Reply-To: <20261002111938.3600786-9-quirin.gylstorff@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-10+b1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3956:EE_|GV2PR10MB9801:EE_
x-ms-office365-filtering-correlation-id: 6f30fdc5-4c67-4122-ba9a-08df20980c1b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|10067099003|11063799006|56012099006|4143699003|6133799003|3023799007|22082099003|55112099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 
 jws2VuszbkKFcweCCDIakaN6GAJrvc19H+iTyJ4bulHE3TSvcSbBcV2kqL2JjUOat8iRtKwlFvbbcghVIog8P76ON0yMGD2eQovF8HrdzyvkH6POzOtcd0cdmRsoqL0xKkPmoj+ab/UOqRvDCkefLnM+CHjCWMzt9rRanRpzwI7icdDqovmqtZRA8DhT4rgmeBcLMKWjenItmj7LkFESgjB8B4dEMYn7Cb/zR8hFN+mge4i3qIyv9Bc49A7co5qrW6QbWTRQTv1UeHOglaQId5kYdjaExWtEXafjkb9TAQ4KV5B8GwE0kjc5w0bOoZ8a0vY8LLoKxQcXaNlEKN7K7ujrDac1H9CmeIfSiA6qZvF6SOwGa9TxG31gxB7Rd74Q7WfOvsiy2f+FGpTKI98lyfe9Zjl+OL4UNjy58BmgagOAJJzKKKDWaSxHbjOrEMxMM3fOSu2T78e1OMSVcEKbCGULfwYd/rzxok5ZVk5ADkYEbDFjRCH5v/vmYgVQgPAel/4FnoqMpubQDpoct/0P5YYRV7OamMSmw8pfEQaDhaoIbnPjqq5+cF00tSGSKoRyoSEFBGMkbEs51GIYJ0CTotJjwazITZpEI6E+KX4WXrDd5TtyzpFgxVSlNHjLJgoIgEro2cy1/e5RoozCIXdNnlJYJ+w1CE+zHOJNwip4RXwdvBa55BchMc7tBXZSHrItZnMCORcvb2d/xDNlPfMnrc0QFBAuBR2S7sQEDRiFgTo=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(11063799006)(56012099006)(4143699003)(6133799003)(3023799007)(22082099003)(55112099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?R216Z2M2czVPdCtSQW0ybXpJQzFmT3VIbW1CN1MwNWZQZm1nRmVWdVdSTmY5?=
 =?utf-8?B?Tm9FWG4wMFFKWW04MDhoZmRXRzJuWmhCK1JtdU9kYXhGWVlleHF1OTZwV0tW?=
 =?utf-8?B?eUQwOE5sMkxqZmVtVXpaZXJCalZkQzJSVGxjeG9uWW1UZ3ZVeWNRSzErMFFH?=
 =?utf-8?B?M3Z3c01HcHIySjRTV1duNXd6OXlwZUdqYWR4bklCMjdNem1Ka0RXazBaZ29V?=
 =?utf-8?B?d2xwYTJPeGxwK3pOWDFMdGFYL2FnQUh2b2NQTzJSMFJOZlVoSTlONFJRNThk?=
 =?utf-8?B?SDI4dk9xSmdjZ2xORmlyS0dLV0NjTHFaMnoxMFF1MHNhV3Zac0h0cmYyc1pm?=
 =?utf-8?B?VnpqRWY4ZGU3VkV2SXM4MEZuNjMrUEZmbEdSbVo3MVM5Y2pJdEJRYTczZkVq?=
 =?utf-8?B?YVl5d250cEs5NlFwcDVzbE04Q0xBdllweXEwdng0U3JSbXl0cjdvVnAzZ1pO?=
 =?utf-8?B?Ujlzb0g3TXN0aTV2N1QyczVNUXowbWJnMTFncnBUV0xyZ0ErYTF3eHJXNU9Q?=
 =?utf-8?B?dUt6NHpwbTlpQkpGQ1N3R1NpSFdwMG0vbDZkeVdwR1p3SU5NRWg4RFZPbGJF?=
 =?utf-8?B?cTlWcGo3M2VoNHBneHZxNFFIQnlIUk10VklVK1FLa1h3VW42eENDNnZOMzA2?=
 =?utf-8?B?NVh4aDdpR1pEYm5jU3V6bnhyMnhTb1NMZVpsdUozMlhqdnp3NGR6VlJ6UVpR?=
 =?utf-8?B?Wm1RYS84QjVTcHBKYVZUVDJwV0w4T1ZkU2ZGTFJ3SmNTMVRzbFBiRHlkYm9U?=
 =?utf-8?B?NnFVdXMzaW5FYitBdWgvOTIvVjhxRXlzbFZmK2YyUXhrWkZ0bFlKR2I0cEVo?=
 =?utf-8?B?VGtIeFdEWXJQdmtnTXl5SDE5V2xFdVR6aXFQUUFXV2tDRnQ4NlN1OTRFMVRl?=
 =?utf-8?B?am5KU2Uvc3FaV0RacHhweFBhbHJER0tRZVlQR0ZOWnRpZDJ1WGJJb2liaExy?=
 =?utf-8?B?SzlwajhoYStuK00xNVpVZGhoQ1JHZkxWL1JRdm82a0xBQ2lHOTR6WEVOY1pl?=
 =?utf-8?B?TERvRzBiQWw3NjYwVW1SalljUjc0V1VsK0NyTU1ZQjVvODlkS01iUmFkOUxN?=
 =?utf-8?B?WHlSZW5zaDJSRm0rWkdCWVhhdFc4TXdCKzg5WXA0NVM1V0Vrb3h0KzYrY0Fv?=
 =?utf-8?B?bG9SMUNiQTBxcS91V1o5Vld2dllVQ2lUMGZRQWl2Y2VSZFFZUHRCb3pPZVN2?=
 =?utf-8?B?b0FIRi9zVEJIYmJROHRUbHI4Ym0xaDdDS1ZFTzBrMURNeUNuR0lWQ2Vpa3pw?=
 =?utf-8?B?dTFLSDZRMGNGemhsZ0NZWm1tZUQxZGVqa2hXN2F3Qmh6dGY4SDJTYWdyTm1G?=
 =?utf-8?B?SkNTZ1g5TnA1c0VUY0F0NzdqQWU1UnNuU1NKMEFOK2tQelJGdG54VzB2WGxB?=
 =?utf-8?B?QWExTFNPNVdReFhiNjJkZVJhVFBNTWJqYVFQUHBGem1EV2g4cXlBVEpON3hz?=
 =?utf-8?B?Nk5DaGVQbnJsb3JJYlJTc2p2ZGVsUjkyaGd5WUpVQmtrTXRrM0NXZkRVNUFZ?=
 =?utf-8?B?akx2VnRQVlh3RmIyaTJURTh4R0FNYko5Um9PaUNBWXVkZHJ5dDljNGcwdjF6?=
 =?utf-8?B?TjFSTXRFNzI4NlBmN0o1RmlmbjNwaUNNenJDWDFVbFA0dUlqRU1xSzNJSDZX?=
 =?utf-8?B?S05ORll2THA2NTcrZjhIaHJ3YWRsMGV2cHNxM3FWQ1ZHMjdvWDE0bHpzSFZJ?=
 =?utf-8?B?U2diSTdJZkJwTTlxNVdlQ1RURFJRWGR2bHNuSG0vbDdLT20xMFJRaDFCYXZU?=
 =?utf-8?B?eEJsV3dDU0JwZnNkLy9xZnZ4MUVGZzdOdUV0REkzQzJwdm0ySXUxNklhMzd0?=
 =?utf-8?B?UWJEUEhPUFZqWnIwZXJPUDIwZEdNUjZQdjZtRGV6QjBjbnA0dUlkK3ZZUHJK?=
 =?utf-8?B?VTg3ZnV5bE9vZExPZXJyenhwK29XYkhLTDlOeVV6VFZFV3RIQUN3SEtad3Fu?=
 =?utf-8?B?UzNEZ1F2SjloVktYeE1QZko3eGNxYnNyM0lZUmlXa01oRTdXS2RPcXp4bHI3?=
 =?utf-8?B?cDVFRnJJQlh3Z3pLa0VzVldsemF4UHZ0eE54RUdOZzBQcTBMa0tHY3RwdlBQ?=
 =?utf-8?B?OXBuRlgrYzVEMlBxQzA4NGRvck5OQ21PQVZBZ3ozN0xVeXNKVkV0YTlxaUxQ?=
 =?utf-8?B?dWhtUG5SQjBUZVBFdUlZQW02MzJXRFEzV1BlYkhCVm9JMXk2VUxKR1FsSzlE?=
 =?utf-8?B?eGhVV1JEcDA3NzhIRFVnNTMwTVJkODlTcDZWTU56ZzRKTmJTZFY3azVYMXBu?=
 =?utf-8?B?YlI3WWFiRmFUcDRpR0tvUVVTQkViS3hJK2VZRDJYQUlwd3FhZzFRVEJISGN6?=
 =?utf-8?B?UjRTRGdqSERCZm1MSW12ME80M3Z2cHhwQ0kvM0J6S3UxY3pNZ240dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2BC01F83F7C2C4986D48C022A7BBE84@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f30fdc5-4c67-4122-ba9a-08df20980c1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 15:15:51.9968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +mgOszNd5YdIARP20b/oymwqcSLB633/sio/rDdBZ4kUwi98JEffuu9QoM6Br6GGeByBazFm1iRPpjcPDV2WFk3hgPcCyrIV5gdQwEybJF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB9801
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Oct 2026 15:16:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24425

T24gRnJpLCAyMDI2LTEwLTAyIGF0IDEzOjE4ICswMjAwLCBRdWlyaW4gR3lsc3RvcmZmIHdyb3Rl
Ogo+IEdlbmVyYXRlcyB0aGUgaW5pdHJkIHdpdGggZHJhY3V0ICgtLW5vLWhvc3Rvbmx5KSBvbiB0
cml4aWUuIFRoZSBvdmVybGF5Cj4gbW9kdWxlIGlzIGFsd2F5cyBpbmNsdWRlZDsgdmVyaXR5LCBj
cnlwdCBhbmQgZmFjdG9yeS1yZXNldCBmb2xsb3cgdGhlCj4gc3d1cGRhdGUsIGVuY3J5cHQtcGFy
dGl0aW9ucyBhbmQgZmFjdG9yeS1yZXNldCBvdmVycmlkZXMuCj4gCj4ga2FzL29wdC9kcmFjdXQu
eW1sIHNlbGVjdHMgdGhlIHJlY2lwZSBhbmQgdGhlIGRyYWN1dCBrZXJuZWwgY29tbWFuZAo+IGxp
bmUgc3R5bGUuCj4gCj4gU2lnbmVkLW9mZi1ieTogUXVpcmluIEd5bHN0b3JmZiA8cXVpcmluLmd5
bHN0b3JmZkBzaWVtZW5zLmNvbT4KPiAtLS0KPiDCoGNvbmYvZGlzdHJvL2NpcC1jb3JlLWNvbW1v
bi5pbmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAzICsrCj4gwqBrYXMvb3B0L2Ry
YWN1dC55bWzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfCAxNyArKysrKysrKwo+IMKgLi4uL2NpcC1jb3JlLWluaXRyYW1mcy1kcmFjdXQuYmLC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDQxICsrKysrKysrKysrKysrKysrKysKPiDCoDMg
ZmlsZXMgY2hhbmdlZCwgNjEgaW5zZXJ0aW9ucygrKQo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGth
cy9vcHQvZHJhY3V0LnltbAo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IHJlY2lwZXMtaW5pdHJhbWZz
L2NpcC1jb3JlLWluaXRyYW1mcy1kcmFjdXQvY2lwLWNvcmUtaW5pdHJhbWZzLWRyYWN1dC5iYgo+
IAo+IGRpZmYgLS1naXQgYS9jb25mL2Rpc3Ryby9jaXAtY29yZS1jb21tb24uaW5jIGIvY29uZi9k
aXN0cm8vY2lwLWNvcmUtY29tbW9uLmluYwo+IGluZGV4IGRiZDY1ZTNmLi5iYmNlYTFkYSAxMDA2
NDQKPiAtLS0gYS9jb25mL2Rpc3Ryby9jaXAtY29yZS1jb21tb24uaW5jCj4gKysrIGIvY29uZi9k
aXN0cm8vY2lwLWNvcmUtY29tbW9uLmluYwo+IEBAIC0zMiw2ICszMiw5IEBAIFRFRV9TVVBQTElD
QU5UX0lOX1VTRVJMQU5EID89ICIwIgo+IMKgUFJFRkVSUkVEX1BST1ZJREVSX2ZhY3RvcnktcmVz
ZXQtaGVscGVyID89ICJmYWN0b3J5LXJlc2V0LWhlbHBlci1maWxlIgo+IMKgUFJFRkVSUkVEX1BS
T1ZJREVSX2ZhY3RvcnktcmVzZXQtaGVscGVyOmZ0cG0tc3RtbSA9ICJmYWN0b3J5LXJlc2V0LWhl
bHBlci1lZmkiCj4gwqAKPiArIyBUaGUgZHJhY3V0IGluaXRyYW1mcyByZXF1aXJlcyBhIHZlcml0
eSByb290ZnMgYW5kIHRoZSBzeXN0ZW1kIGNtZGxpbmUgc3R5bGUuCj4gK0lOSVRSRF9DTURMSU5F
X1NUWUxFID89ICIke0Anc3lzdGVtZCcgaWYgZC5nZXRWYXIoJ0lOSVRSQU1GU19SRUNJUEUnKSA9
PSAnY2lwLWNvcmUtaW5pdHJhbWZzLWRyYWN1dCcgZWxzZSAnY2lwLWluaXRyYW1mcyd9Igo+ICtS
T19ST09URlNfVkVSSVRZID89ICIke0AnMScgaWYgZC5nZXRWYXIoJ0lOSVRSQU1GU19SRUNJUEUn
KSA9PSAnY2lwLWNvcmUtaW5pdHJhbWZzLWRyYWN1dCcgZWxzZSAnMCd9Igo+IMKgT1ZFUlJJREVT
IC49ICIke0AnOnJvLXJvb3Rmcy12ZXJpdHknIGlmIGJiLnV0aWxzLnRvX2Jvb2xlYW4oZC5nZXRW
YXIoJ1JPX1JPT1RGU19WRVJJVFknKSkgZWxzZSAnJ30iCj4gwqAKPiDCoCMgV2F0Y2hkb2cgdG8g
c2VydmljZSBieSBpbml0cmFtZnMgaG9va3MgZHVyaW5nIGxlbmd0aHkgb3BlcmF0aW9ucyBsaWtl
Cj4gZGlmZiAtLWdpdCBhL2thcy9vcHQvZHJhY3V0LnltbCBiL2thcy9vcHQvZHJhY3V0LnltbAo+
IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4gaW5kZXggMDAwMDAwMDAuLjk2OTM4OGNmCj4gLS0tIC9k
ZXYvbnVsbAo+ICsrKyBiL2thcy9vcHQvZHJhY3V0LnltbAo+IEBAIC0wLDAgKzEsMTcgQEAKPiAr
Iwo+ICsjIENJUCBDb3JlLCBnZW5lcmljIHByb2ZpbGUKPiArIwo+ICsjIENvcHlyaWdodCAoYykg
U2llbWVucyBBRywgMjAyNgo+ICsjCj4gKyMgQXV0aG9yczoKPiArI8KgIFF1aXJpbiBHeWxzdG9y
ZmYgPHF1aXJpbi5neWxzdG9yZmZAc2llbWVucy5jb20+Cj4gKyMKPiArIyBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogTUlUCj4gKyMKPiArCj4gK2hlYWRlcjoKPiArwqAgdmVyc2lvbjogMTQKPiAr
Cj4gK2xvY2FsX2NvbmZfaGVhZGVyOgo+ICvCoCBkcmFjdXQtaW5pdHJkOiB8Cj4gK8KgwqDCoCBJ
TklUUkFNRlNfUkVDSVBFID0gImNpcC1jb3JlLWluaXRyYW1mcy1kcmFjdXQiCj4gZGlmZiAtLWdp
dCBhL3JlY2lwZXMtaW5pdHJhbWZzL2NpcC1jb3JlLWluaXRyYW1mcy1kcmFjdXQvY2lwLWNvcmUt
aW5pdHJhbWZzLWRyYWN1dC5iYiBiL3JlY2lwZXMtaW5pdHJhbWZzL2NpcC1jb3JlLWluaXRyYW1m
cy1kcmFjdXQvY2lwLWNvcmUtaW5pdHJhbWZzLWRyYWN1dC5iYgo+IG5ldyBmaWxlIG1vZGUgMTAw
NjQ0Cj4gaW5kZXggMDAwMDAwMDAuLjg1NDE1NzRlCj4gLS0tIC9kZXYvbnVsbAo+ICsrKyBiL3Jl
Y2lwZXMtaW5pdHJhbWZzL2NpcC1jb3JlLWluaXRyYW1mcy1kcmFjdXQvY2lwLWNvcmUtaW5pdHJh
bWZzLWRyYWN1dC5iYgo+IEBAIC0wLDAgKzEsNDEgQEAKPiArIwo+ICsjIENJUCBDb3JlLCBnZW5l
cmljIHByb2ZpbGUKPiArIwo+ICsjIENvcHlyaWdodCAoYykgU2llbWVucyBBRywgMjAyNgo+ICsj
Cj4gKyMgQXV0aG9yczoKPiArI8KgIFF1aXJpbiBHeWxzdG9yZmYgPHF1aXJpbi5neWxzdG9yZmZA
c2llbWVucy5jb20+Cj4gKyMKPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogTUlUCj4gKwo+
ICtpbmhlcml0IGluaXRyYW1mcwo+ICsKPiArREVTQ1JJUFRJT04gPSAiZHJhY3V0LWdlbmVyYXRl
ZCBpbml0cmFtZnMgZm9yIGNpcC1jb3JlIgo+ICsKPiArSU5JVFJBTUZTX1VTRV9EUkFDVVQgPSAi
MSIKPiArIyBkcmFjdXQtY29uZmlnLSogcGFja2FnZXMgYXJlIHNraXBwZWQgYnkgbW9kdWxlLW5h
bWUgZXh0cmFjdGlvbiwgc28gdGhlCj4gKyMgbW9kdWxlcyB0aGV5IHB1bGwgaW4gYXJlIGxpc3Rl
ZCBleHBsaWNpdGx5Lgo+ICtJTklUUkFNRlNfSU5TVEFMTCArPSAiZHJhY3V0LWNvbmZpZy1jaXAt
b3ZlcmxheSBcCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBk
cmFjdXQtY29uZmlnLWNpcC12ZXJpdHkgXAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZHJhY3V0LWNvbmZpZy1jaXAtd2F0Y2hkb2ciCj4gK0RSQUNVVF9FWFRS
QV9NT0RVTEVTICs9ICJjaXAtb3ZlcmxheSBjaXAtdmVyaXR5IGNpcC13YXRjaGRvZyIKPiArCj4g
K0lOSVRSQU1GU19JTlNUQUxMOmFwcGVuZDplbmNyeXB0LXBhcnRpdGlvbnMgPSAiIGRyYWN1dC1j
b25maWctY2lwLWNyeXB0Igo+ICtEUkFDVVRfRVhUUkFfTU9EVUxFUzphcHBlbmQ6ZW5jcnlwdC1w
YXJ0aXRpb25zID0gIiBjaXAtY3J5cHQiCj4gKwo+ICtJTklUUkFNRlNfSU5TVEFMTDphcHBlbmQ6
ZmFjdG9yeS1yZXNldCA9ICIgZHJhY3V0LWNvbmZpZy1jaXAtZmFjdG9yeS1yZXNldCIKPiArRFJB
Q1VUX0VYVFJBX01PRFVMRVM6YXBwZW5kOmZhY3RvcnktcmVzZXQgPSAiIGNpcC1mYWN0b3J5LXJl
c2V0Igo+ICsKPiArIyBidXN0ZXIsIGJ1bGxzZXllIGFuZCBib29rd29ybSBsYWNrIHRoZSBkcmFj
dXQgZmVhdHVyZXMgbmVlZGVkIGhlcmUKPiArcHl0aG9uICgpIHsKPiArwqDCoMKgIG92ZXJyaWRl
cyA9IChkLmdldFZhcignT1ZFUlJJREVTJykgb3IgJycpLnNwbGl0KCc6JykKPiArwqDCoMKgIGlm
IGFueShzIGluIG92ZXJyaWRlcyBmb3IgcyBpbiAoJ2J1c3RlcicsICdidWxsc2V5ZScsICdib29r
d29ybScpKToKPiArwqDCoMKgwqDCoMKgwqAgcmFpc2UgYmIucGFyc2UuU2tpcFJlY2lwZSgKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiY2lwLWNvcmUtaW5pdHJhbWZzLWRyYWN1dCBpcyBvbmx5
IHN1cHBvcnRlZCBvbiB0cml4aWUgYW5kIGxhdGVyOyAiCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgInVzZSBpbml0cmFtZnMtdG9vbHMgb24gb3RoZXIgZGlzdHJpYnV0aW9ucy4iKQo+ICt9Cj4g
Kwo+ICtST19ST09URlNfVFlQRSA/Pz0gInNxdWFzaGZzIgo+ICtEUkFDVVRfRVhUUkFfRFJJVkVS
UyArPSAiJHtST19ST09URlNfVFlQRX0iCj4gKwo+ICtST09URlNfSU5JVFJBTUZTX0dFTkVSQVRP
Ul9DTURMSU5FOmFwcGVuZCA9ICIgLS1uby1ob3N0b25seSAtLW5vLWhvc3Rvbmx5LWNtZGxpbmUg
LS1yZXByb2R1Y2libGUiCgpUaGUgLS1yZXByb2R1Y2libGUgZmxhZyBpcyBwcm92aWRlZCBieSBp
c2FyLiBUaGUgb3RoZXJzIGFyZSBqdXN0IHRoZQpkZWZhdWx0IGlmIEkgcmVhZCB0aGUgZHJhY3V0
IG1hbnBhZ2UgY29ycmVjdGx5LiBJbiB0aGlzIGNhc2UsIHRoZSB3aG9sZQpsaW5lIGNhbiBiZSBk
cm9wcGVkLgoKQW55d2F5cywgdGhlIC0tbm8taG9zdG9ubHkgYW5kIC0tbm8taG9zdG9ubHktY21k
bGluZSBwYXJ0cyBzaG91bGQgYmUKbW92ZWQgdG8gaXNhciBpZiBuZWVkZWQsIGFzIGlzYXIgYWxz
byBwcm92aWRlcyB0aGUgZHJhY3V0LWNyb3NzCnN1cHBvcnQuCgpGZWxpeAoKPiAtLQo+IDIuNTUu
MAo=

