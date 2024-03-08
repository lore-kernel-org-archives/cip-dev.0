Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66BFC5475B
	for <webhook@archiver.kernel.org>; Fri,  8 Mar 2024 15:19:37 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.47])
 by mx.groups.io with SMTP id smtpd.web10.18763.1709893730369448990
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Mar 2024 02:28:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=POFtGGl9;
 spf=pass (domain: siemens.com, ip: 40.107.21.47, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrDVl1NRioPn/U02eYWg254JFg7+QHcYkRiGsQi0DoRlm5PmFqPd6hkQMfVyWQwnx1vrRZrE3fsAoDdfUeud091WnHCbXKq2zez/hMNIJMPPfDF7rSTBHEC0Cw6/QUKhMlUL33Ttfy1LSsK3G/GXs4iNBowWXKN6SlsGCWx2hrjzgokM1Fxrd7V2uEDbGQpSuXc3hdLRPUylRriAajmEzv3XjAO1JKhr/nF7tOnJ3QCmR3OCkEmLDzK8AAmok3FjyvUIuhDcF/V5EDO5FfmcHRVixFXFHvTqYEivOn4I7G/divHLBXRTjGfDkZZBO0RCQHgKPEQBpvvUm/IVnjAqdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tegDZj/89OrQoDfrrH/k3WSwr9mmVFP+cvG3gpYMwIQ=;
 b=l0t78ZSdt+LrX+smlrm5V15BkfAlNCgJh0aVaf/NNkefkWMJsHYSdGGpDtwGdSe4VJSeMz/2tMdxauvxqbcR/Vi4PNNBMS7cWXDO+FPe4tk0xREmyCbA8gXqQFXm09Bxu5AJxDMked7IDDpgZv7AB9gpA6zU3cRdrrdQD/dsIG0dlkvRojinWlEm8hRJTFTNTU6UIfpawJchLE8K5k94MQCu/jaPFdB5nRJ17SHIm0wh2yx2NTPDLjWfITyTwdCxSRoYFEvY69VtH7aeAH7pStX+A/oKmu96KBY0SKUP5sUYMv7O/oqcbPpSFye185bANyx4Pvn3RiUxa9K8Q/758g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tegDZj/89OrQoDfrrH/k3WSwr9mmVFP+cvG3gpYMwIQ=;
 b=POFtGGl9iD/vL4nG+VYSt1Ia4wDh/xmi6wL9xxtMMNLz7Qu+gLrSl8myvQ7Ggx878Y2g93aS/MVVxFSDEGkh9Y5RkG6DFnfptDUWx+tc81G6QmZaO9iOdYN4eRbkEiiNNk0J11yToEsDAp1DAnN5n/KaWFi0xqVgmxfDileI0pkim04lOWEFDSBPUsGWLHuhCQMCn8zi5kk9zz+T2ae3y52BO216kyowSnhDEyjbbzuCdB1RqjFwgzWGsqL7WrM6FPPIa1Jbb21ymo2GOYaY5NPdsZYOm0G01USXygVaVo+hGjqtH4QDc2ZPuogVXD2Q22WW1drGUxYbzexd6Dzgcw==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by AS8PR10MB6699.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:563::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Fri, 8 Mar
 2024 10:28:46 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e0b3:537d:ebe2:c0a3]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e0b3:537d:ebe2:c0a3%5]) with mapi id 15.20.7362.028; Fri, 8 Mar 2024
 10:28:46 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"Adithya.Balakumar@toshiba-tsip.com" <Adithya.Balakumar@toshiba-tsip.com>,
	"Kiszka, Jan" <jan.kiszka@siemens.com>
CC: "shivanand.kunijadar@toshiba-tsip.com"
	<shivanand.kunijadar@toshiba-tsip.com>, "sai.sathujoda@toshiba-tsip.com"
	<sai.sathujoda@toshiba-tsip.com>, "dinesh.kumar@toshiba-tsip.com"
	<dinesh.kumar@toshiba-tsip.com>, "kazuhiro3.hayashi@toshiba.co.jp"
	<kazuhiro3.hayashi@toshiba.co.jp>
Subject: Re: [isar-cip-core][RFC v1 1/6] conf: Use bookworm backports for enabling delta handler in swupdate
Thread-Topic: [isar-cip-core][RFC v1 1/6] conf: Use bookworm backports for
 enabling delta handler in swupdate
Thread-Index: AQHacUNm7rqMkKe9OUK9bbXRMl0bKg==
Date: Fri, 8 Mar 2024 10:28:46 +0000
Message-ID: <5f953906f40cd9667c74919956827faea03dd3c0.camel@siemens.com>
References: <20240307074612.1996609-1-Adithya.Balakumar@toshiba-tsip.com>
	 <20240307074612.1996609-2-Adithya.Balakumar@toshiba-tsip.com>
In-Reply-To: <20240307074612.1996609-2-Adithya.Balakumar@toshiba-tsip.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|AS8PR10MB6699:EE_
x-ms-office365-filtering-correlation-id: 3e27517d-a0a2-4e0b-b745-08dc3f5a8980
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 NPxrPii58IIiTmMIZO+jdH3J0sT8Fq7qnut6CS06NLdcuSVS4e1I8Y9gmgL7GTyRBxGcF+iBvKauaMwXbaFGr0ttai5+YSwKbgHVNEqlqb9omVRW7Nev3w3T3OB246CezqH6EDvU6qSjxqPcWWoabr5F4f5XpNc2ZysDZOmCqNvPrlWT6l6jcW+AzV6XIHhn2VJ0AA9kYVxBMNNwevxHs1+Y8nH0TaAoXFEJqDBs1evQbCyv/pL0nNDMl48U5dkHtSdtbkSpNbuGlXIQU60Sg6dloJU2/jXgA/nuO4ejXRJi7y7lmkBrZNBKr64ll+hpsK3ec6KUMYZ0AcieUBHuG45gn4dSGkdtvk9Oj/UqnrkRxu+RPSWB6d4oRwMG6Y6trR+ZWpVfpkZ9O6xzDU8nrBoR6fRr8DLGSsc5rRF3n9d/uJmyGvaUQygiKh10BFU9Pj3skIWfwOVdhXN/r85iBrjuCbxd8IwWKbWYMglYuinGk9oiSVjEyqQ6wNfQVEocUBQrx6xyABJiEAb8H6SZj2XY4BxDP0MK58myac5dISZ8rGnspK+ZUhRR1LpJsSNoxW+EsHHNVDGApuqbrBQ1D4k6aKL+JK5MYoGQQM0G1BCM/Ijww/5OPn2cU7A0Xpl5ArnaCFsQwIkrPK8eUos3qJWDKK2C76/d+ch63eRKqkY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MUsvOWxGaXdlN2R6eXJjc3Zuc081Y3BjSERBVmlnN2tRR3dvL2ljeHIyNVFz?=
 =?utf-8?B?MEJuUzFBbms1T0hIazg3bzlyQWJHZlFwczhUcGo3NHYxUFFiVEFJUjgxWWpq?=
 =?utf-8?B?OFE3dFlPWGVPcUtBc3hJd2tVU1VXanR0ZlVwYVFVZkNFZnp4NUtXaVZacVlw?=
 =?utf-8?B?ViszV0tuL2g3NUZBZm5RbjhDdkxYL09Fb2JzNmdqV0NpWUZDTUpvc281bkxH?=
 =?utf-8?B?N3ZEaTNOdUR4QWpVVGIycllkaGlZTzZIRlJNWURkLzgvSFdWZjJ6dlFPbG54?=
 =?utf-8?B?L3hCNGI5Uzh5VHZvSkJQSUFJRGZ4ZjRpbGIvV2IrREl5QjA1MXQ5RnpCamRx?=
 =?utf-8?B?cTROZlNLY1UwS2JwZ3J5NC90WHd4SGkxaGtFSHlZblNyWTJaQzhucnNZVlZR?=
 =?utf-8?B?NlJxR2k1TUtxem9FQ3lBb2JhWDJ0M1hZcHVrL2tHenpSTzlldHowVEcwck1M?=
 =?utf-8?B?WFd2OHBNb0ZNWTBWdStMRVlvWU5oY3NnSmFTZXBRQzNZU29qV2prVk96bFZC?=
 =?utf-8?B?NzhtZE1YMzB2cllBekpTelF1NnovYk1RSHJBTnA0OVRoMklVUTNkcnNGRmJD?=
 =?utf-8?B?SzBVSHNmYjZHMytzeWtha3FvRHZPVHoyS0xEdU9lN0ZGNFRmUnFaMUJSU1cr?=
 =?utf-8?B?MHhiWWZrZ0d4Q0I5NUVKUktkcldKaTBmMkJuM1pLcDBTN2poMmVxMkVTVE0y?=
 =?utf-8?B?eVNlTE1McEVzTkJtYm0wNnNpeTFrenl3UVkyK25ySUsvcytVWWpoRzZmMHM2?=
 =?utf-8?B?S3g3UWFIRDgyKzdTSWs2Q0Jkc0dPMU1Db09rYjREUUc3YjJxUGRXQU9nWG5Y?=
 =?utf-8?B?ZWh1N2VoZUEyTW1GYlNCZjB4WlFPZ01iR21OM1h0TVFOTEFUMVZ3Rk9GU0hF?=
 =?utf-8?B?TEwxZTdVTWNiNjYzWitlMlY0cis3OWxPY2VvQVFmYnMycDlRNVFVMHNYL08x?=
 =?utf-8?B?RnB4ZEszN3BUYy9GWFYwU0ZlUnlkNE02dUJRdFVPbnVhUk1vSVdWcjVVcFFw?=
 =?utf-8?B?cWVEbHV2VlFwRUxkbiswNG1sVUZtZjl6dkJVRmF3Y041QVVnTG5EakVTWG1P?=
 =?utf-8?B?VjEwVGdOQWJvWXBCMlVWak9EeGV5ckNGRnU3dEhlRytPY2dVVGErbk04VXhT?=
 =?utf-8?B?ZG1lejc2RThPVGUrM3BGNDdmTGk3V2hJK3BQU2YvaklJUHVrbHIrMU5JMUcy?=
 =?utf-8?B?eTFCTXBZQXpGSGh4b3VVeUFJK1pCTzZFOFBuS1JaOW1NaGczQWc5QWxxUGhp?=
 =?utf-8?B?RE1tQ3Nuc0tMRmNtOUJkWFVxZk5NQWhSd1U3ZHZnMEtuOVV4NTdrZWNMajBq?=
 =?utf-8?B?YnRCWjRacGhjVlZ1S2JhUENIYXVnUk9HaVhJRUtOS2duOGY1b3RFWmN2V1ll?=
 =?utf-8?B?SXgyNTBDWXRJM0o4L29lbXlobEpKRE9VOGJERWJsWEtTT1F4b1lBc28wTGdz?=
 =?utf-8?B?MURjMmpVSXBXK0lMYllaRHduaFdmb1Q4bkRkbng4dTNZUE9venhYR2dlL0FG?=
 =?utf-8?B?cEtkWWpJVTVMRDR5SzEyVnpCOE9LRTVreEdpd3Q2cHRKMmIvam9KWDZONGdO?=
 =?utf-8?B?RDBKeTVxcmFKV2FzZTRHZ2gxM05ibVdwWDh3bTgzLytyay9zYy9QMzBpZUFF?=
 =?utf-8?B?RldSbW1QdDJ1cy9vVVlmZEc2cnUvempvbWZ0bXFKbXZ1c2ZLRFlVZzJsa2Q2?=
 =?utf-8?B?RjF2YlArckdCK2Nnc204cGgzUTdEWHB4Vmt5TGNRdmtKSmluTlZucFIyMFlu?=
 =?utf-8?B?N3dFS3I4N210eUc1WDB1eFFvWDduekpYMEVuTGhoU25zZ1psQUlodGk2eGFF?=
 =?utf-8?B?YklUNUtmdFB4ZjR6Ty9pWmhRSTEvSjdxRS82NGV0OHBSVDZ0YzVncWVHdUk4?=
 =?utf-8?B?YitaUEJhZGF1bHZmVzZGUlJodEpmSVUzOUppcmozcHQ2SThjekhLQTRFUHdx?=
 =?utf-8?B?VUpsdWFnOWNDRk1xRzNQd29mRll0RW5jS2h6eWRwSDBrNjIxNDNGem9HdXhz?=
 =?utf-8?B?Tm9BNHVXNkFuMk9ZVEhMSFpzTWFyWFhjY2tFeldoZytJS0hjSW5xNG95SWox?=
 =?utf-8?B?V1YyOVFCekVISFBLdkEwMFY1WlZQcStXTTYwWE9zQ2c1ays2RWR2K1RzUGg0?=
 =?utf-8?B?dmJWZlZoalhLMGVLTi9iTzhNZ0JMeHJ0a1NZMmpUMEo5U0UzbDMyQXduMy9B?=
 =?utf-8?B?ZjVMd2c5RUp0V3Z4QkY4U1RKVTR6ZVNLSFQxcTZxaDVNbU50blcyU2N6TDFy?=
 =?utf-8?B?SWpmeHBnZjhuNkRnOGZFQUJ0L3hBPT0=?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e27517d-a0a2-4e0b-b745-08dc3f5a8980
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 10:28:46.6014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QjVCEUN/3yYPBB2GFqa1x9v5UGOdWV4LbeCvKe0qNyNEkt8S4PN+FVrYAs9QoXwd1mGySfMHoDzfBuSdqSLhvTDdCMzeSwtLtfHHjOg6fwc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6699
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <F59C4C40319ACD4289BBE51F03A17D85@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Mar 2024 15:19:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15269

T24gVGh1LCAyMDI0LTAzLTA3IGF0IDEzOjE2ICswNTMwLCBBZGl0aHlhIEJhbGFrdW1hciB3cm90
ZToNCj4gRGVsdGEgaGFuZGxlciByZXF1aXJlcyB6Y2h1bmsgPiAxLjMsIGJ1dCB0aGUgcmVxdWly
ZWQgdmVyc2lvbiBpcyBvbmx5DQo+IGF2YWlsYWJsZSBpbiBib29rd29ybSBiYWNrcG9ydHMNCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEFkaXRoeWEgQmFsYWt1bWFyIDxBZGl0aHlhLkJhbGFrdW1hckB0
b3NoaWJhLXRzaXAuY29tPg0KPiAtLS0NCj4gwqBjb25mL2Rpc3Ryby9jaXAtY29yZS1ib29rd29y
bS5jb25mwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAzICsrKw0KPiDC
oGNvbmYvZGlzdHJvL2RlYmlhbi1ib29rd29ybS1iYWNrcG9ydHMubGlzdMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHzCoCAxICsNCj4gwqAuLi4vcHJlZmVyZW5jZXMuc3d1cGRhdGUtYm9va3dvcm0tYmFj
a3BvcnRzLmNvbmbCoMKgwqDCoCB8IDEyDQo+ICsrKysrKysrKysrKw0KPiDCoDMgZmlsZXMgY2hh
bmdlZCwgMTYgaW5zZXJ0aW9ucygrKQ0KPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBjb25mL2Rpc3Ry
by9kZWJpYW4tYm9va3dvcm0tYmFja3BvcnRzLmxpc3QNCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQg
Y29uZi9kaXN0cm8vcHJlZmVyZW5jZXMuc3d1cGRhdGUtYm9va3dvcm0tDQo+IGJhY2twb3J0cy5j
b25mDQo+IA0KPiBkaWZmIC0tZ2l0IGEvY29uZi9kaXN0cm8vY2lwLWNvcmUtYm9va3dvcm0uY29u
ZiBiL2NvbmYvZGlzdHJvL2NpcC0NCj4gY29yZS1ib29rd29ybS5jb25mDQo+IGluZGV4IDliY2Y1
NTkuLmUwYTRmN2YgMTAwNjQ0DQo+IC0tLSBhL2NvbmYvZGlzdHJvL2NpcC1jb3JlLWJvb2t3b3Jt
LmNvbmYNCj4gKysrIGIvY29uZi9kaXN0cm8vY2lwLWNvcmUtYm9va3dvcm0uY29uZg0KPiBAQCAt
MTIsNiArMTIsOSBAQA0KPiDCoHJlcXVpcmUgY29uZi9kaXN0cm8vZGViaWFuLWJvb2t3b3JtLmNv
bmYNCj4gwqByZXF1aXJlIGNpcC1jb3JlLWNvbW1vbi5pbmMNCj4gwqANCj4gK0RJU1RST19BUFRf
U09VUkNFUzphcHBlbmQ6c3d1cGRhdGUgPSAiIGNvbmYvZGlzdHJvL2RlYmlhbi1ib29rd29ybS0N
Cj4gYmFja3BvcnRzLmxpc3QiDQo+ICtESVNUUk9fQVBUX1BSRUZFUkVOQ0VTOmFwcGVuZDpzd3Vw
ZGF0ZSA9ICINCj4gY29uZi9kaXN0cm8vcHJlZmVyZW5jZXMuc3d1cGRhdGUtYm9va3dvcm0tYmFj
a3BvcnRzLmNvbmYiDQo+ICsNCj4gwqBQUkVGRVJSRURfVkVSU0lPTl9zd3VwZGF0ZSA/PSAiMjAy
My4wNSUiDQo+IMKgUFJFRkVSUkVEX1ZFUlNJT05fbGludXgtY2lwID89ICI2LjEuJSINCj4gwqBQ
UkVGRVJSRURfVkVSU0lPTl9saW51eC1jaXAtcnQgPz0gIjYuMS4lIg0KPiBkaWZmIC0tZ2l0IGEv
Y29uZi9kaXN0cm8vZGViaWFuLWJvb2t3b3JtLWJhY2twb3J0cy5saXN0DQo+IGIvY29uZi9kaXN0
cm8vZGViaWFuLWJvb2t3b3JtLWJhY2twb3J0cy5saXN0DQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0
DQo+IGluZGV4IDAwMDAwMDAuLmM0ODczYjQNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9jb25m
L2Rpc3Ryby9kZWJpYW4tYm9va3dvcm0tYmFja3BvcnRzLmxpc3QNCj4gQEAgLTAsMCArMSBAQA0K
PiArZGViIGh0dHA6Ly9kZWIuZGViaWFuLm9yZy9kZWJpYW7CoGJvb2t3b3JtLWJhY2twb3J0cyBt
YWluIGNvbnRyaWINCj4gbm9uLWZyZWUNCj4gZGlmZiAtLWdpdCBhL2NvbmYvZGlzdHJvL3ByZWZl
cmVuY2VzLnN3dXBkYXRlLWJvb2t3b3JtLWJhY2twb3J0cy5jb25mDQo+IGIvY29uZi9kaXN0cm8v
cHJlZmVyZW5jZXMuc3d1cGRhdGUtYm9va3dvcm0tYmFja3BvcnRzLmNvbmYNCj4gbmV3IGZpbGUg
bW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMC4uYjZlZmZmYw0KPiAtLS0gL2Rldi9udWxsDQo+
ICsrKyBiL2NvbmYvZGlzdHJvL3ByZWZlcmVuY2VzLnN3dXBkYXRlLWJvb2t3b3JtLWJhY2twb3J0
cy5jb25mDQo+IEBAIC0wLDAgKzEsMTIgQEANCj4gK1BhY2thZ2U6IGxpYnpjay1kZXYNCj4gK1Bp
bjogcmVsZWFzZSBuPWJvb2t3b3JtLWJhY2twb3J0cw0KPiArUGluLVByaW9yaXR5OiA4MDENCj4g
Kw0KPiArUGFja2FnZTogbGliemNrMQ0KPiArUGluOiByZWxlYXNlIG49Ym9va3dvcm0tYmFja3Bv
cnRzDQo+ICtQaW4tUHJpb3JpdHk6IDgwMQ0KDQpIaSENCg0KSnVzdCBwdXQgYWxsIHBhY2thZ2Vz
IGluIG9uZSBsaW5lLCBlLmcuDQoNClBhY2thZ2U6IGxpYnpjay1kZXYgbGliemNrMSB6Y2h1bmsN
Cg0KRmVsaXgNCg0KPiArDQo+ICtQYWNrYWdlOiB6Y2h1bmsNCj4gK1BpbjogcmVsZWFzZSBuPWJv
b2t3b3JtLWJhY2twb3J0cw0KPiArUGluLVByaW9yaXR5OiA4MDENCj4gKw0KDQotLSANClNpZW1l
bnMgQUcsIFRlY2hub2xvZ3kNCkxpbnV4IEV4cGVydCBDZW50ZXINCg0KDQo=

