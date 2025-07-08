Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0AFC8303C
	for <webhook@archiver.kernel.org>; Tue,  8 Jul 2025 15:52:55 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.70])
 by mx.groups.io with SMTP id smtpd.web10.22252.1751989964712343245
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Jul 2025 08:52:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=A5+Og/5Z;
 spf=pass (domain: renesas.com, ip: 52.101.229.70, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTCve7xOs3NA0aQlJ/iKA2imfNjRsLMtkMWBTILUMUrFPOH6LB4XhtCmoTRSHedkGFfVzoDLJGLFfxqZmAtclVwwNIJR817vjCdUi0yZ3Fg1I6VVcLhbQN0eahcFG7BYs+sdKe1x08mHBsZy9CFl1zRhtZ4HtByZTyUCubBqJVmLtOW/Yq+iZctsItYLUb8D7/4z36afIukDfwIyEYnr+Yw8ywuLPDnnur+Mw1tNY7ih3FUP2/IxHq4FB7nIfC6FxUS2zgKJxqBFixAfxcbybfE9bXyA0dQ3bsxdk0F+yIX1YytXw0zeiEBCSkWw1RIRiKMMasE+5HEGLMMYhljLmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kw5bQULmm1PK2os037FMznvdSENORBmUQG/ALy22NMM=;
 b=CxjDOke/7m2+takIJxNG6YulO7NGY25mrcRZaOlQeCtek7KHeBNdwEpHF5qyMX+82LSMfqbho7XUlEZCVrH6Yh7W6uLwOwfpl/sZjgRFS98hfKqxv82RKetViFKo+OWGIlPIuJSj2fE2CFx7fun0NncQ9QY0Vg4Z/IdMTM5LX/liAdCKWBCDFaRKIwFLM0l05f+hUEX/LDHXK7dCr80OYPZ4tE+iL9/aAfSXq08UBKliukUrw6A0jLORwXfQFIIq5IGZnLvGZjzS+saMRZ3SE3sKAKaexOtwZXCsnEHpTHkrLMAdMU9LWEIS9M7sAQyjK0LxgaUCdorRigG3o/lwfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kw5bQULmm1PK2os037FMznvdSENORBmUQG/ALy22NMM=;
 b=A5+Og/5ZJvc78h0dH5TEOEoid9mO9kaeFPQr2GJIKSpmdRQpqTo50iyioCEwreOAQ4lJxqapYAp9+80C3RaGfJXrRsPFEXNy14QXNWCkV1U+zhzghD+Uk+8tXPDAAXiMUgqkx9HNuKVeBEYXLVSytcoD3W9I1vGcRnoBhz4ptn0=
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 (2603:1096:405:1a1::10) by OS7PR01MB12065.jpnprd01.prod.outlook.com
 (2603:1096:604:266::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Tue, 8 Jul
 2025 15:52:40 +0000
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6]) by TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6%7]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 15:52:40 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev
	<cip-dev@lists.cip-project.org>, Adithya Balakumar
	<Adithya.Balakumar@toshiba-tsip.com>
CC: Nikola Trifunovic <nikola@trifunovic.at>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [isar-cip-core][PATCH] wic: Fix boot by PARTUUID for bbb,
 hihope-rzg2m and iwg20m
Thread-Topic: [isar-cip-core][PATCH] wic: Fix boot by PARTUUID for bbb,
 hihope-rzg2m and iwg20m
Thread-Index: AQHb6yAg0o3wjlJ9AUqw+x3uW67Io7Qoadtg
Date: Tue, 8 Jul 2025 15:52:40 +0000
Message-ID: 
 <TYYPR01MB151324A65957196E1E8306B5EB74EA@TYYPR01MB15132.jpnprd01.prod.outlook.com>
References: <a4b992d3-eb46-4cf1-8e22-87024d969618@siemens.com>
In-Reply-To: <a4b992d3-eb46-4cf1-8e22-87024d969618@siemens.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB15132:EE_|OS7PR01MB12065:EE_
x-ms-office365-filtering-correlation-id: 120df513-42f6-4b5f-1c30-08ddbe377834
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?eVRtbVJpanVNUXFqa2hnSWJoOTQvd243KzZySytjWGlnRk1FYWkxRVhMUi9F?=
 =?utf-8?B?dnVGMzNKcE5rTXl5OVo5MW1uR1pRSlhaWDA2c3FpN0V4bTIxb1hzMEdZdnp3?=
 =?utf-8?B?S3R2Ry9PbDV3WitnL2F1UmErNFdwb0pBSEowaHR3c1MvYW1GTUIxcnp5NzJR?=
 =?utf-8?B?UXVRN3hjcnRGRmtVSWZlbnVtOG8weWZTekhabS9zNWNqbmg4ZGpaR1k1UjZl?=
 =?utf-8?B?UEl2SzNBeWkrV1J4RGV2TVJmcXN6NnVWaVJ4REUyUHB5YzZNZ2k1UHlvaHVU?=
 =?utf-8?B?ZVpYQ2JBd3pHNkdOdDNGdUY1SXJtM0xWTmZkNE5XUkYyVWorc1g5eEVicU5r?=
 =?utf-8?B?ZlFpOTNTTWFUOXlpVzlwTThPa2sxYXNUcmRQR3N2bWlvYm9aRFFpSWdhemVh?=
 =?utf-8?B?bmcxQTQ2ZW1tc0huNUc1OFFXanVhOEdhdDlsaWFCYkpEWGUxUmt3WW5oTElH?=
 =?utf-8?B?VU14VXJtalVxNytscFZiZ0xEOWZIWkU1ZzR4cFF5L1NsU1c0eGJNM3dlOGJU?=
 =?utf-8?B?YkN1eDdxUDMrVWxHQUlWdGw2dk9aSXkrZW9jQlcwVGZzUzVTSFlKNDlENHlU?=
 =?utf-8?B?RnUwYkRmdnU3aUNzeG96cFpySHlvLzNhandhZlI1UXhGZFE4RU1ubTFyY1Mx?=
 =?utf-8?B?OEJYVWlZTFB4S2grY20xelV3STgzNU1VRWFhZFlXUlNHK25wVUdsUkRaeDk2?=
 =?utf-8?B?RGliMUFtYzFSQld4cjduZGVEUjdHZ0dZelRZbkFlRUNOQ1FsWWNncTF4K0Yy?=
 =?utf-8?B?MjhOdnBvTHNGbklkSGVRcUJYMFVFdFlKeCtXUDFkcmdSRkk0dFgwUmFDbUkw?=
 =?utf-8?B?QWJyT1luN0o0clZVdk1oalVWVFliVlpWK3Z2enBJVnVzRDdPNXNjSHBwenRr?=
 =?utf-8?B?cUl3RzR5SGdDcnUvZGhLd0pjbTRRSG5jK3hESFRDQmFPOUIzVjdjWGw1ci9q?=
 =?utf-8?B?MUQ1MzE3U2c2NDVLODQ3OXMzdTk5TTlaZWFYQUlzRnlNT1NnN21uVWw4b1FF?=
 =?utf-8?B?V0ZTajJWb2VURUh6bGJaaSs4NjMzcVR6MjhJb0RyVDBBaWJnRjlOWG9MZ3dn?=
 =?utf-8?B?bFV1N3lUSzZoRDI1SWtwVG5EV3gzKzBOR3BuRXlaMC9tUTE0OCt3WFhyOFhI?=
 =?utf-8?B?dkdzTWxkYk40Q1lncFRlK3I4U1lrWE9tTEg0VnNwN1ZxN0p6RU1JWFF5ZUND?=
 =?utf-8?B?WWorT2k1UUg4Q0s3enlScGZXeVhlMDVGdmtlSVhSVHhTZ1hBaG9Sdk84dHpE?=
 =?utf-8?B?UTJON05KaDZ2ZGxpbmdxc3R2RWVoUVFqeEtNMkoxdWN4aWd2L2tlYTN2V3hw?=
 =?utf-8?B?c01ZZzVBUlh2ZG8xWUR5OGZvMGZtUU1jcDdGSGdJMk81Z2ptS2lOOHpzZVI1?=
 =?utf-8?B?YUdDbGRGQW1PYmJJbDJobjRBb0Z1R3JNYzMydm0yRlBjNTRzMVBnUXZZZ2l5?=
 =?utf-8?B?SkZPVUZtbWFFQURUSE9qZGxpZ01yc0ZvLzlERUM3YWJZL2JwN3lTdWN1S09p?=
 =?utf-8?B?c0hpeUFEbVRuVFpBMHFnUHBFb3hXNXNEZGtuQ1kzR3FOTC9BQXc0dVJSTytP?=
 =?utf-8?B?VXM2QlY1cVJ1WjRtZWQ3aXZZc1hIamNnNDdsZGs4Y1RIQWRsdEpmYUdvZ0xl?=
 =?utf-8?B?QjNvWVJhL1ZoYVpEUVRiZ0FMT0pHTEw2cytKYkw0Y0Noa3M0bHNWQ2R2QVp1?=
 =?utf-8?B?eFlTblRQUjMxMzhMM243aEZIbUx6S0k1KzFUUVRUcG9XK1oxLzlwaS9wRnNu?=
 =?utf-8?B?MWN4ZXN0dGtYZVdzVllSaWtKOWdXbkhzbEE5NjZ2aEE2dGpQQ05UNzRST3Vv?=
 =?utf-8?B?ems4M3BSYno4TjlIVkpsQW9tRURpYkZqbnR0ZFZQVFJ0OGdjK0NqOE54M1Z5?=
 =?utf-8?B?SVBxUWtNV1ltdVFOcFpJK1lnNGd4MWkwVGhVTnNIaE1WNU1NUm5pNEhEZ1Zu?=
 =?utf-8?B?STJkOUIrajkxeFJMV3dUZThwSUpRZmhsMDNXZU5VajNXNFBDYjQxTEFzOFRT?=
 =?utf-8?B?SGlERlYxWERBPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB15132.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?KzRXMTdpWEFXWk1tbzdCaThNU2xuMmNzT1ZZMUR0bnY1UzBaeDMrQ3RhMnIr?=
 =?utf-8?B?UTFIWWxYNnUra243di8waU9nc29ydHVVSEJMb29ZbHJNWk1KZWFURFhkNWc0?=
 =?utf-8?B?aWdEWlJuT014c1FqdkNHWUJkTkJ6OXZPSjJOaW1LZy9RSGlqL28rd1dHbGZp?=
 =?utf-8?B?dTNReTZyajFacGZlUHcxdkRoVWdkYlFZNVpYSi95eGRRanRzdUo0R3VVVFh3?=
 =?utf-8?B?ZjlPRjdxQ3NKUDRuNW16N2J0eloxVjRqUVdLY2ppaFFOZndQU3dFbXNsVkM4?=
 =?utf-8?B?dTBPd0N4Y0s2aURneTBOY1dOSUFwUDB3TzRaMjhzSHZxQVF3SjVJdzFINXRt?=
 =?utf-8?B?c2lKVlVyUHJhbjUzS29RZXp0dWV6aGFhWUJkek5uL2lRdUFraUYvYkJSM1J6?=
 =?utf-8?B?RDU2d2sxenNXeHRQU1ljbHRkTmtlbzREMmJHL2hIeDZDMFFXSEFiMmZrWHJz?=
 =?utf-8?B?UXNSemxRV1RySmlOcEZPRGdDcTFkM3NPb25lM1VQTGUrZCszMFpDOXdlMzNm?=
 =?utf-8?B?VTVZRlpHaUoyV1YzWGdXd2lYcFlRcTRFT3BqV0xQdTgrbjFZWDM0TUZyR3Zj?=
 =?utf-8?B?ZHBXMjM2QnFRVXdEaWVTN3NJUXdJR3pRclFROE94RDR2L2sxemlDK3pIeFdm?=
 =?utf-8?B?Q0NlNjNkME5xRWdaTVVDbmt5SnlyTm9aeGF2dkNaZ1BBL1lzTlBQTVIyVU5n?=
 =?utf-8?B?K3VBQkhJUnZPanpjc1VDeUladlgwaHVwNFJ6WEZWd0wzZkZ4Y2hRb3ZWMlR3?=
 =?utf-8?B?NlNWNUY4OW1wWFArQnlVd0N6WGZqS1NVK0ZyR1lpSkpyVDN1WURYN1ljWURx?=
 =?utf-8?B?QlcxRmdvdkR2eEY1ZzZSMGdNamtvaWs4OThZV2V6Y0F2UHdUVDUwSWRQVXFO?=
 =?utf-8?B?S2NrR2hPYXpkY0d3dXo5enFrT1FIOUo4eEM2K1p4QkFZRm1QM1F0QjRNaFVh?=
 =?utf-8?B?VW1wYUNHdkljU1UxcVh5cWVrNWI0TUVlMUdPK1RhdGgxYmQ1d01sa1JaVDdH?=
 =?utf-8?B?SXJsc1dFMXF6ci8wNzZvWGpLa29VeGloeTVvSFRMcWYrd3c4NWo4TkY3TTI2?=
 =?utf-8?B?Zkp1MlhxU1MxUGh2ZVFvazBDN0FTZ0wyT3ZhelhseGErS0dES0JDOWZGSnZ1?=
 =?utf-8?B?VUhpMWkybkRQc2ovZ0poZGs0SWtKTjF1aGJOQTRUWTREOFBaRHNPR05PSmh6?=
 =?utf-8?B?QzlVTkM4OHF1MjZTNmRvNjU0WENsc1pQMTAyZzJKUkZWR2NrZU5ISlBUNzY5?=
 =?utf-8?B?c01ScENSa2ZlVjlac0RZV1Z0OHQySndzazgwSEQ4b0FRWVA2Mnc2TDQ1RlZ1?=
 =?utf-8?B?OWs3MEZTYmw3cTlDK1dMeVR6Sm1wRnRKQlJKMmtVeXU1RUtkaWwzaStiRHB1?=
 =?utf-8?B?emJaYW94OVVnMVYyWUtIVHhwYWF0bjdpQ3g1VHVMV2w0YmJONnJWSDdtTXo4?=
 =?utf-8?B?Z3FVZ3BrRGhTblgweGVoMiswMEJrd2xsdmdST05IcTY2aTN2dzVCdEJFd2xR?=
 =?utf-8?B?UWo5eS91MStXVnBFaURQZC9NRGNpdEYyejl0dWhZSFU1d0lCK3BMRkVQT2wy?=
 =?utf-8?B?Ylp1Y1g2WGlmSFNHVjdURFdzcVJmb1ZYQTJVNWN5SEVYUjhlUGhHRVAzSWwz?=
 =?utf-8?B?YUlVN2l3dEdIa1UxeE9lMEZqQnY0a3NJOHR6Y3ZaaEgzcTJOaTlPQTFUOGVP?=
 =?utf-8?B?WnI4c0sxMW01Ri9pL25MOEY2d2pLNHdMRHpodFcybGlIamN0UW1tcjNJMVJL?=
 =?utf-8?B?TEhYcWVNUEwveElWNUxMUkp6TFdCVG1nRkF5Mk92bUZVbk1Gb0E3eVVYeW5o?=
 =?utf-8?B?MTk3dTJPamNuSG1uUjFNeEM1VVNETHY5SzdoQko2SXd6eXBkVEtlbWJLeHA0?=
 =?utf-8?B?UHpRa3B4Vjk1dno1cSswdWNBMjFieGpCUmlXMmE3QVhrQUdJdVlvV2I2cnJK?=
 =?utf-8?B?WEFHWEo3RUtZQVJaYUlTVlBkQUg2V3lXWHRCV1pGSTAyLzVnaHBkemZiWWVz?=
 =?utf-8?B?Ynd3MS9rcngrZzlTOGJCTS9lSncyWHUrdTIzRUt5cWx1UzZzNlBlZnIxMm4v?=
 =?utf-8?B?N3lBMkF0RW9RQ0hEYm8xM08vY2ZJaW0zRHlyVjYyVUdlRWExVE9rcTF1SEZo?=
 =?utf-8?B?WXVIZHQybXpqOGlmTWQzVUxjSFJMaFhYSTNCY2l6dWhkR2pCWGZyclAvamxn?=
 =?utf-8?B?N1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB15132.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 120df513-42f6-4b5f-1c30-08ddbe377834
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 15:52:40.5406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NPt228mxM8Qrip4Jcj9ZoKcuOCEdUxLl5gmDkqPCib8sKWeT43Eilo6+xnlhI5swI9sMeNrve69ANBJNSLZm8U2cHsl4STlUZ2fJbYkvpgs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB12065
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 08 Jul 2025 15:52:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19388

SGVsbG8gSmFuLA0KDQo+IEZyb206IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+
DQo+IFNlbnQ6IDAyIEp1bHkgMjAyNSAwODowOA0KPiANCj4gRnJvbTogSmFuIEtpc3prYSA8amFu
Lmtpc3prYUBzaWVtZW5zLmNvbT4NCj4gDQo+IFVzaW5nIGEgZnVsbCBVVUlEIGZvciByb290ZnMg
c2VsZWN0aW9uIHJlcXVpcmVzIGEgR1BULiBPdGhlcndpc2UsIHRoZQ0KPiBwYXJ0aXRpb24gdGFi
bGUgd2lsbCBvbmx5IHN0b3JlIGEgc2hvcnQgSUQgd2hpbGUgdGhlIGluaXRyYW1mcyBpcw0KPiBs
b29raW5nIGZvciB0aGUgZnVsbCBvbmUuDQo+IA0KPiBSZXBvcnRlZC1ieTogTmlrb2xhIFRyaWZ1
bm92aWMgPG5pa29sYUB0cmlmdW5vdmljLmF0Pg0KPiBGaXhlczogMzg3MDNjYjhlNDRmICgid2lj
OiBTZXQgZml4ZWQgcGFydGl0aW9uIFVVSUQgdmFsdWVzIikNCj4gU2lnbmVkLW9mZi1ieTogSmFu
IEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NCj4gLS0tDQo+IA0KPiBJIGRvbid0IGhh
dmUgdGhlIFJlbmVzYXMgYm9hcmRzIGluIHJlYWNoLiBDb3VsZCBzb21lb25lIGNvbmZpcm0gdGhh
dCB0aGUNCj4gVS1Cb290IHNldHVwcyB3ZSBhaW0gYXQgd2l0aCB0aGUgaW50ZWdyYXRpb24gKG5v
dCBjb3ZlcmVkIGluIGlzYXItY2lwLQ0KPiBjb3JlKSBkbyBzdXBwb3J0IEdQVD8gSSBzdHJvbmds
eSBzdXNwZWN0IHRoYXQsIGJ1dCBqdXN0IHRvIGJlIHN1cmUuDQoNCmhpaG9wZS1yemcybSBfc2hv
dWxkXyBiZSBva2F5LCBob3dldmVyIGl3ZzIwbSBsaWtlbHkgZG9lc24ndCBoYXZlIHRoZSBjb3Jy
ZWN0IHUtYm9vdCBjb25maWdzIGVuYWJsZWQuDQpXZSdsbCB0cnkgYW5kIGdldCBib3RoIGJvYXJk
cyB1cGRhdGVkIGluIHRoZSBuZXh0IGNvdXBsZSBvZiB3ZWVrcyB0byBzdXBwb3J0IHdoYXQgeW91
IG5lZWQuDQoNCktpbmQgcmVnYXJkcywgQ2hyaXMNCg0KPiANCj4gIHdpYy9iYmIud2tzICAgICAg
ICAgIHwgNCArKy0tDQo+ICB3aWMvaGlob3BlLXJ6ZzJtLndrcyB8IDQgKysrLQ0KPiAgd2ljL2l3
ZzIwbS53a3MgICAgICAgfCAyICsrDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygr
KSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS93aWMvYmJiLndrcyBiL3dpYy9i
YmIud2tzDQo+IGluZGV4IGI0NjI4MmRkLi45YmRhN2MwNCAxMDA2NDQNCj4gLS0tIGEvd2ljL2Ji
Yi53a3MNCj4gKysrIGIvd2ljL2JiYi53a3MNCj4gQEAgLTEsNyArMSw3IEBADQo+ICAjDQo+ICAj
IENJUCBDb3JlLCBnZW5lcmljIHByb2ZpbGUNCj4gICMNCj4gLSMgQ29weXJpZ2h0IChjKSBTaWVt
ZW5zIEFHLCAyMDE5DQo+ICsjIENvcHlyaWdodCAoYykgU2llbWVucyBBRywgMjAxOS0yMDI1DQo+
ICAjDQo+ICAjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBNSVQNCj4gICMNCj4gQEAgLTExLDQg
KzExLDQgQEAgcGFydCAtLXNvdXJjZSByYXdjb3B5IC0tc291cmNlcGFyYW1zICJmaWxlPS91c3Iv
bGliL3UtDQo+IGJvb3QvYmJiL3UtYm9vdC5pbWciIC0tbm8tDQo+IA0KPiAgcGFydCAvIC0tc291
cmNlIHJvb3Rmcy11LWJvb3QgLS1vbmRpc2sgbW1jYmxrMCAtLWZzdHlwZSBleHQ0IC0tbWtmcy0N
Cj4gZXh0cmFvcHRzICItVCBkZWZhdWx0IiAtLWxhYmVsIHBsYXRmb3JtIC0tYWxpZ24gMTAyNCAt
LWFjdGl2ZSAtLWZzdXVpZA0KPiAxZjU1ZDY2YS00MGQ4LTExZWUtYmU1Ni0wMjQyYWMxMjAwMDIg
LS11dWlkIDI1ZDU3YjI0LWYzNGQtNDEyZS04Yzg4LQ0KPiAyODYyOWYyM2FhMGQNCj4gDQo+IC1i
b290bG9hZGVyIC0tYXBwZW5kICJyb290d2FpdCBjb25zb2xlPXR0eU8wLDExNTIwMCINCj4gK2Jv
b3Rsb2FkZXIgLS1wdGFibGUgZ3B0IC0tYXBwZW5kICJyb290d2FpdCBjb25zb2xlPXR0eU8wLDEx
NTIwMCINCj4gZGlmZiAtLWdpdCBhL3dpYy9oaWhvcGUtcnpnMm0ud2tzIGIvd2ljL2hpaG9wZS1y
emcybS53a3MNCj4gaW5kZXggZjViODUwZGIuLjFjMjM5Zjg2IDEwMDY0NA0KPiAtLS0gYS93aWMv
aGlob3BlLXJ6ZzJtLndrcw0KPiArKysgYi93aWMvaGlob3BlLXJ6ZzJtLndrcw0KPiBAQCAtMSw3
ICsxLDcgQEANCj4gICMNCj4gICMgQ0lQIENvcmUsIGdlbmVyaWMgcHJvZmlsZQ0KPiAgIw0KPiAt
IyBDb3B5cmlnaHQgKGMpIFNpZW1lbnMgQUcsIDIwMTkNCj4gKyMgQ29weXJpZ2h0IChjKSBTaWVt
ZW5zIEFHLCAyMDE5LTIwMjUNCj4gICMNCj4gICMgQXV0aG9yczoNCj4gICMgIFF1aXJpbiBHeWxz
dG9yZmYgPHF1aXJpbi5neWxzdG9yZmZAc2llbWVucy5jb20+DQo+IEBAIC0xMywzICsxMyw1IEBA
IHBhcnQgL2Jvb3QgLS1zb3VyY2UgYm9vdGltZy1wYXJ0aXRpb24gLS1vbmRpc2sgbW1jYmxrMCAt
DQo+IC1mc3R5cGUgdmZhdCAtLWxhYmVsIGJvbw0KPiANCj4gICMgUm9vdGZzIHBhcnRpdGlvbg0K
PiAgcGFydCAvIC0tc291cmNlIHJvb3RmcyAtLW9uZGlzayBtbWNibGswIC0tZnN0eXBlIGV4dDQg
LS1sYWJlbCByb290IC0tDQo+IGFsaWduIDEwMjQgLS1zaXplIDJHIC0tYWN0aXZlIC0tZnN1dWlk
IDFmNTVkNjZhLTQwZDgtMTFlZS1iZTU2LQ0KPiAwMjQyYWMxMjAwMDIgLS11dWlkIGI4YmJiYTNm
LTNiYTYtNGIyYi04ZDY5LTRhOTVmZDRmMzRlZA0KPiArDQo+ICtib290bG9hZGVyIC0tcHRhYmxl
IGdwdA0KPiBkaWZmIC0tZ2l0IGEvd2ljL2l3ZzIwbS53a3MgYi93aWMvaXdnMjBtLndrcw0KPiBp
bmRleCAyMWZjNDE5OC4uZjY2YTE5ZTQgMTAwNjQ0DQo+IC0tLSBhL3dpYy9pd2cyMG0ud2tzDQo+
ICsrKyBiL3dpYy9pd2cyMG0ud2tzDQo+IEBAIC0xNiwzICsxNiw1IEBAIHBhcnQgL2Jvb3QgLS1z
b3VyY2UgYm9vdGltZy1wYXJ0aXRpb24gLS1vbmRpc2sgbW1jYmxrMCAtDQo+IC1mc3R5cGUgdmZh
dCAtLWxhYmVsIGJvbw0KPiANCj4gICMgUm9vdGZzIHBhcnRpdGlvbg0KPiAgcGFydCAvIC0tc291
cmNlIHJvb3RmcyAtLW9uZGlzayBtbWNibGswIC0tZnN0eXBlIGV4dDQgLS1sYWJlbCByb290IC0t
DQo+IGFsaWduIDEwMjQgLS1zaXplIDJHIC0tYWN0aXZlIC0tZnN1dWlkIDFmNTVkNjZhLTQwZDgt
MTFlZS1iZTU2LQ0KPiAwMjQyYWMxMjAwMDIgLS11dWlkIGQwZmE4MzYxLTdkZWItNDNkZi1hY2Vl
LTE3MjVkNDBkNDAzZQ0KPiArDQo+ICtib290bG9hZGVyIC0tcHRhYmxlIGdwdA0KPiAtLQ0KPiAy
LjQzLjANCg==

