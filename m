Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2369.1793956403267334253
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Nov 2026 01:13:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=qC2eVx1A;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1793956400;x=1795166000;bh=qlE1UCgxcogIbFGp/ICqAKkuvY13IoTn1NF7N
	YAFriI=;b=qC2eVx1Apt0nx3Jtx7WOLh8ayKRoAk6M4xh0Gux5vWbk7WGIEVJgKL/ddjFyWENJkbX
	gxiB5Xg7Rkj+08A9+zwfFOKDPGqJz08EVR6r8GiZGc/CdSthCJIa9NqiERxnF+3FY3SFkaPMzCdA/
	oeb93UJ5reUSLZfDI1tj6UHUxvTLSffxtQTQee/R18cYgvjgAcVizvE/N+oRp3hTMQlx50DcebTn0
	tx8a0LySadQwxKUW7jRUp8snyn79TQ8xokYaewueSNWSUG+jExT6aANAWkw0aSCmxXQm6ssgdIwTD
	dgOiilGPWwIwBFKmAJyYoXuloNwZUVrSMoDwIeAalfkQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 6A69DK0w2503785; Fri, 6 Nov 2026 18:13:20 +0900
X-Iguazu-Qid: 2rWgRCuG5SYJd1MyJu
X-Iguazu-QSIG: v=2; s=1; t=1793956400; q=2rWgRCuG5SYJd1MyJu; m=fM2hUMPJou+qblEJPRC0yhVDI4BIAF8y9Zgfdthyaac=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jLYPX1hlKz4vyn; Fri,  6 Nov 2026 18:13:20 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3hki8bUb7Pvl8qimsRxKNH/L3Z3AI2XWxUs5XN3pBVZgqmdtSvx91aXzPM403tW2FYHZxoYNdxF/OjSOxCji6av7s/DA9teBSOcbY7tCB8cseauXX2jEaiE2SOjeVzsP25DmOu9ypL0CuA0WWojdpYbDaUyNLzDgSP3w4Ei/IvqVxGp6gYQyrJyLn56bKPMM2mRNnC/o9OzKyY5CKLNlEaTplJcfcWfnDX0TKcy67NTPFiNdijah3ynLx1fpDL8QZ6JBKqNbdmJvvlgbDHh9Q1kmflH7gZM3m5QHmynocZacpsrMcUnzIveSIO9jkyUTbuXlr/6U45wOF8qFso+YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlE1UCgxcogIbFGp/ICqAKkuvY13IoTn1NF7NYAFriI=;
 b=QiOs9qoZoDjSDxA6Z1vHbRBy3utfdgZnkcNz+rtVc4fooANKjhG7eGvlAtVI6v6pBB7UJTLtKNLXN7sXwSNphuJZk/r8SXArSrePDBgWQ/4gmdmzBEOw+ZnSwbXr9No0Wm5jT3745N9l/YCOBd/yQoNWRqFSThfZlpVE9M00VhO/MuMt8S8VYxiBS/OpSSAPWBTSzTcIounyynATjlYM2gyiTIBsOlugib3E4PgZfj2PYD5knpO/LI4sO4N3ei5VVF6zlzbrY4uowY43spvjtd8XLmYVWmszLCQkCEgj2GuEya2K37a/50WlBSy3V3VOuiZVWQwgi1izoggrqR75lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <jan.kiszka@siemens.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [isar-cip-core][PATCH] u-boot: Change the mirror URL to
 u-boot-project.org
Thread-Topic: [isar-cip-core][PATCH] u-boot: Change the mirror URL to
 u-boot-project.org
Thread-Index: AQHdbO8brdXF3XCkF0K3KjYhx0kUsbcfB++AgACfpACAAJaHgIAAfkEAgAAGe+A=
Date: Fri, 6 Nov 2026 09:13:11 +0000
X-TSB-HOP2: ON
Message-ID: <TY7PR01MB1481876B57D2ABFD456CDCF4ECD762@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <1793860204-10428-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <427d1f20-29a1-4772-81f0-35eadb4d7f81@siemens.com>
 <3013916d-0b1c-4976-87fd-1bd2c8414ce6@siemens.com>
 <TY7PR01MB14818EA78FCE275C31089389BCD762@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <3ff69438-414f-462f-816d-5c79dba37cc5@siemens.com>
In-Reply-To: <3ff69438-414f-462f-816d-5c79dba37cc5@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY7PR01MB13706:EE_
x-ms-office365-filtering-correlation-id: 46a5ca97-a909-4c72-0d78-08df3be62e1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|10067099003|22082099003|18002099003|38070700021|56012099006|4143699003|11063799006|261026140227099003|261022115727099003|261028144727099003|261022075727099003|261026121527099003|261102123227099003|261022105027099003|261021121427099003;
x-microsoft-antispam-message-info: zTCKbtg85R7QKxkmpExJjnyfBUuKaMDPxHEwbJip7k+yPORlwe/tFxcSyiK6Z7FfevlwM+IJnQTG+zL+QeYgJLM03vcTfTTFHKB2dB37Q5acpz92dYIg3iwqYY6vOV8m/i/zEVSKzUosodsy/E9StOuRYPhwRUo1bXQRJwOCcr7w+TrqWYMAIWw85Kk16LAebHduz2hyKPkfjhK+nVFP7DyeBwnOfMkl4NctZWVMX40r8DQ8bBpNi+BuS1l/g3+w3z9NhG7y9NvLYy7AUi8W78DqF51k3zD5mm9+Oj9RaWGF94TScz/RvA8qZTuOXg32wWw3+EWBVa8asMNHVYhfIxGjCGLTqOcgf2vYSapUUM93GH6vACVu5K+98UhbIa7tIKaez2k24mYfWEtjUJUtG718IBKHm+XT4o2RMEU8+gkPHuz9VV3N/Y9Fjr2xXZteaOxdC0sIHHf8bTLQKhAzfKGt1iro+96PtRua/ZdcXyqDHfZ00z1pVp+CIy3dDPa5i7NKeNPW9FCun+BvhuVWzhK1GCUtgoqLSAjCiUjkbcB0ATBL36NgM8Ui6uTKr8WtGyZUFglHRJiF6LfikccMP/mb4pMsimirBBaET4DiLKnR2ic3Gr9UfEQ7X6HgdpnqSUPhD+VYKgmtdcubaY3QAOd156DcacJBqQcFiCvvbgsuiZG94uwWz2TSOvUDncWGBcPTMK+crGUmghlLeOvVgfTdOzAOZO+4iKpowy7GV4I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(22082099003)(18002099003)(38070700021)(56012099006)(4143699003)(11063799006)(261026140227099003)(261022115727099003)(261028144727099003)(261022075727099003)(261026121527099003)(261102123227099003)(261022105027099003)(261021121427099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmZ3WnUwdC9TT3YxUUJTVUx4ZmlvUXNZNGt5VzlSNERuUnRhNXd2YWJocTU5?=
 =?utf-8?B?ZHdVb2JjN1I5bGhEWGtPNVdiMG5YTDR1RVRkOENaYlRraXRoeWhtN0dEbTRm?=
 =?utf-8?B?TWpXK2todllUL25FYlNDSkdETXJ4L3N0a3lNWTg4TnVCRlB5bXFMQW5uZTR6?=
 =?utf-8?B?ZEJSdkVoVmdaYWZHcXJ5S3dKaFlxdkdJbUJhN0R6ZHFlNVZRYXZsbitlV3NL?=
 =?utf-8?B?NGovUGZMTURwdlZVb1dGbGhmeFR4enlqWFFkQzRFSytWKzAvbjhlRU9GNFdT?=
 =?utf-8?B?YnJLMDh3VXBOLzNwUkV3WTVMdjdiczd2SnROelRKK2hWWjRFR0pyVnJSSXIy?=
 =?utf-8?B?cmdGUlg4SUZTUjdVclJObFVENXZyRkRka0pKWDVId0hOWVNReFZYdnNleVhv?=
 =?utf-8?B?RWlkVHhhRXF5M2dBS05ZRUtYWEk5eVpNYlJUTWE1Z2tvbDFqOUVzbmtDUENL?=
 =?utf-8?B?U0k2TUFlOE02VVJjdUJsVG1nckU0cGp2eGxYQ21RNEFyK2hFVURZL2Fnc0Zp?=
 =?utf-8?B?V1NMeXpPekdDN0RwMGVLZnM2djNXWjF6VnJCSm5MZ1FnRjQ3TjVrUDRjS0x0?=
 =?utf-8?B?RjAvSjVURHpPVnd6ckZJdXJvYmNzK1BSY0pqSDF3azVYOXlKd1ZRZnBDSWxt?=
 =?utf-8?B?dGZRdU5ROURHemNHWHRhaklNSm10Tk9HU09GTzVLUE5lOXRaZ2dkZ3BEVU9r?=
 =?utf-8?B?RXY5cjN1Slp3MHZWQ1plT3hsU29FMENsMlQ1ZkZhVUt2TXJCblRpREVIZUxV?=
 =?utf-8?B?UzZGSUtmRkRtZkRUdFdIQkNNaWhWaStSWVpHQ2NVaU5TRDM3aDJFL3RoMGYy?=
 =?utf-8?B?QWV1bnJSOEFnaFFMK1RqTmNMbzV5UHRFMStDTmtBZlpWY2h4TTBjUDRzMmZa?=
 =?utf-8?B?VTFuUE5GYkdIMWd0QmlsWGV1Y1M5M2syaThSbllsdGJKMXgrZzNtSmNTTFBG?=
 =?utf-8?B?ald1OTRUNGtOSldxczVZYTRiSWFpZVB0cEVCNVB2YmNXYlJZQnlpa0xyazNQ?=
 =?utf-8?B?Mms3bmJuUmJ0dzFKMno2d3UvVWhwaElVYjFJdlBGTVI3UHZzaDB1NkgyN2c1?=
 =?utf-8?B?M3RZQ1NqSXEyMEY5Y1d2WkVQZERqcnQ3NWwvY3RuTURtbXpkN3M4bXNJeUVN?=
 =?utf-8?B?WDljRFdkdFdleUxjNHZuOGVyYWhYenpkRFA5ZDVCSzBxOUJoc3lSRTVpT0I0?=
 =?utf-8?B?WS8rbDFCZm52OXl2bkxHVmVJSmpWN0k5cllweTdmZFk4dGV2WnN4ZXVtUVNX?=
 =?utf-8?B?UHRHWGRuQitKVWhZZytabFpCd3BsNFYzVDV5bWE0VnJrNm1NckRXemowQ3g3?=
 =?utf-8?B?ekxLYjJIN3c1KzMweU1ILzVZTElJMVR4RHN4RjFaRjY1Mi94Tkp6aXQ3Q1dj?=
 =?utf-8?B?UlU4MERNb0JEUVJneGFqWEVLVDV3SFFOTWFDemtZZ2lvWFRGNGk3NFhCYjhF?=
 =?utf-8?B?YXo3cEJudStJYXF4MFpQS3lrMnFMRXJWOCtwV1hrYUZPZllHN25PYU1GYU5K?=
 =?utf-8?B?Wjltd3QvaW1scFV6ZW4ya1RSWnJzUitiNnEzNnhITnNWeHdITkw4RFNacW1U?=
 =?utf-8?B?NzcvQ0RoZkFReDkzM2tBdlhRbjJtbk9SbEpuY3h3UVprOENYTVg4U3pHQk1W?=
 =?utf-8?B?NGpSV0JVa0FUU1hKRUFNY2RINUN5ek9WbGNjUVI0VW84R25Na202NEloOXZx?=
 =?utf-8?B?azJlRlBtZDYvRTM1RHF4bkpHbGQzNVkwSnRCam1YeHU2Rm4vd2FJVDFyZnQw?=
 =?utf-8?B?UVMvUW1haTNPTnBEcnFrdm85cTkyVjBaR1NHeHdrTnBwMkVQdG5TQ3ZiaGMr?=
 =?utf-8?B?Y0RKcWs3WUUvb0ZYWnAyVE5yY0l5UzY5ZTJ4blczOE9PMC9lT0Y2alQ2NFF4?=
 =?utf-8?B?S2huL2VBekFWc2d0OVZGRXZBUENRS0d4VzNvR0VERHprWU5WYVZzRDNVSkps?=
 =?utf-8?B?RFV2TmZ0bkhVb0NGcVBzT1NXZE5vQnU4MUMzUUNvNXRBa0d3SmNhZ0xKdTZj?=
 =?utf-8?B?UTRYQUJwVXBac3RBTDA2Z293VkY3SzdnRGFZUWI0azV6aGtubERZUytGVXlh?=
 =?utf-8?B?UFBBVGRYMzdmRCswZEJsRlM1eFdFbGRXNlFYNFI5TXU3ZXV5UXRzS1dIcGdN?=
 =?utf-8?B?VTZWWk1TcWcvbklJQStXWlF1Yy83anExMDhZN1BhRk56VjJ1WXRQa3pPYzNi?=
 =?utf-8?B?WHF3Y0huNXNRaE1wWlBxejJlckJvYVJ4c2MvczY2YW83WHJQZ3l4VHZrbTZi?=
 =?utf-8?B?ZTMyV2ZUV1ZHRnFDRDBIUW41MGFBTWdoWkQ5TTJMZmNHTHNYczFJc29BT0tP?=
 =?utf-8?B?aXlMd0dvUjhsTzhaR3FDREM1VWpYTWpITFNhVWgzQjM4VDRJbXlPTytPbzVZ?=
 =?utf-8?Q?2T6vNuyTbfBq8B70=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZS0S6fCfScQ+GDO+Io+dVd3649fJQw1RBlIYJwMwmy1suVCMzJI3ARSBpEjKRBwpKilYwRqeMcbxSBe1rXYijBBrC6N2wXI8mHCk1R2DNXU8g9b9rG+VgXdeJPs6yF6AbEQ4CH11LekrlBVaWkgFAMVF8/RAzr5ySAn6F/3jMCTNhIioSQhsWKEGxxNI8eyB1WuEytbx7RQTLFQavRxW5EGR7b/vBXB2gmKvRIJLMIKKHPvZ1Z0N0xkDUICBIK8O/VTFr4mVdAQiEceYbrGmqPG2RqZI0BAvs79FU5BQl75nUjAAbC4kay3OBmb3fOftjnFen0GWJg3f0Qz+ddMmEw==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a5ca97-a909-4c72-0d78-08df3be62e1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 09:13:11.1982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mL5lSKlsIXBQdlNgUuMtkP13lgrZbI+mWlr5ifHPX++TuJ11qWeQ9K//A41nNFIkH+gqhqz9ZaG6u2GqT4pgbBRHpqfYyeLia/60R7mna5MYX35Kn0N47bRtIQv4KCf4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13706
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 06 Nov 2026 09:13:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24661

SGkgSmFuLA0KDQo+ID4gQlRXIGRlMCdzIHUtYm9vdCBidWlsZCBmYWlscyBpbiB0aGUgRGViaWFu
IDEwIChidXN0ZXIpIGVudmlyb25tZW50Lg0KPiANCj4gUHJvYmFibHkgdGhlIHNhbWUgaXNzdWUg
d2l0aCBiYmIgYXMgd2VsbC4NCj4gDQo+ID4gVGhpcyBpcyBiZWNhdXNlIFUtQm9vdCBkb2Vzbid0
IHN1cHBvcnQgb2xkZXIgR0NDIHZlcnNpb25zLiBJIHRoaW5rDQo+ID4gaXQncyBuZWNlc3Nhcnkg
dG8gaGF2ZSBydWxlcyBsaWtlIG5vdCB1cGdyYWRpbmcgdGhlIG92ZXJhbGwgVS1Cb290DQo+ID4g
dmVyc2lvbiBhbmQgZml4aW5nIGl0IGZvciBlYWNoIE9TIHZlcnNpb24uDQo+ID4NCj4gPiBEbyB5
b3UgaGF2ZSBhbnkgdGhvdWdodHMgb24gdGhpcz8NCj4gDQo+IEhtbS4gTm9uZSBvZiB0aGVzZSBi
b2FyZHMgYXJlIHByZXBhcmVkIHRvIHRlc3QgZnVsbCBpbWFnZXMgaW4gb3VyIGxhYnMuDQo+IFdl
IGNvdWxkIGZpeCB0aGVpciBib290IGJ5IHByb3ZpZGluZyBsZXNzIG9yIHVucGF0Y2hlZCBvbGRl
ciB1LWJvb3QgdmVyc2lvbnMuDQo+IEhvd2V2ZXIsIHRoYXQgd291bGQgbWVhbiBtYW51YWwgdGVz
dGluZy4gSSdtIGFsbW9zdCBpbmNsaW5lZCB0byBkcm9wIHRoZW0NCj4gZnJvbSBidXN0ZXIgYnVp
bGRzLg0KDQpJdCdzIGVhc3kgdG8gcmVtb3ZlIGl0IGZyb20gdGhlIGJ1aWxkIHRhcmdldCwgYnV0
IHdoYXQgYWJvdXQgbG9uZy10ZXJtIG1haW50ZW5hbmNlDQpmb3IgcmVmZXJlbmNlIEhXPw0KDQpJ
IGNyZWF0ZWQgcGF0Y2hlcyB0byBzb2x2ZSB0aGUgcHJvYmxlbS4gQ291bGQgeW91IHJldmlldyBp
dD8NCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0K

