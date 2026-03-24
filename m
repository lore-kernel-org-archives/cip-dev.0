Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF92F532FE
	for <webhook@archiver.kernel.org>; Tue, 24 Mar 2026 09:10:40 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15724.1774343432891861752
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Mar 2026 02:10:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=ZrHbSyUf;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1774343430;x=1775553030;bh=xGRxASlT1kYAkMmfQvRcm8e9ea71zb5PiC+7P
	2xgV6M=;b=ZrHbSyUfC9hMCsWdzxZjUpBURuHY4QLxaB6wnYzF8UhFu4i2PvPItaoRVr1wEwMPmPF
	U5vGNLqKZjcASR5MKT5Pus7ALGks3m/3UksOs0Bozxqop8zU01nLrbhQtcZXcBcH9C53CbtBDmLjk
	+Z/U+IjMjmV2luRqsxfduR9iB6O7XZlcECva2hKfldJ1fAdShdk+zNht5HNmfrdiJ5e1eOQhmlegX
	rYGMrXkuJaaLXzOdp11kUoMp5YmAHLDZTIYXpEJwoksCFLquAramqxmMKYtrt0EjYlLSmklWgdXQh
	V1Oq5Pcxwkdo+kBH/ujJp38ZJscN6ta9C+jIOzj9Pq1Q==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 62O9AUTT385862; Tue, 24 Mar 2026 18:10:30 +0900
X-Iguazu-Qid: 2yAbMX92rYolXcBud8
X-Iguazu-QSIG: v=2; s=0; t=1774343430; q=2yAbMX92rYolXcBud8; m=JBzv14ybUUuVDj402V1uLEu8y9Fi55DmIr3EHdLfZNg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fg4514xMxzyPQ; Tue, 24 Mar 2026 18:10:29 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CDXkcyDZjwwXi7Cu2V405+hnqYeGqwIemyQ5wb4swskpW6IkkYR2c3/FOsQqNK3Vhz/u9hYqYCgGx1owQSkDQE3OKe9n5nqfx7sYS1SNtBf8Jc2NJqx7llesZDUFZjWM3ftfS+hgET4GEFrh7xrlaIeiCH2DJWHx1agwvHSP1Mb/M6tcmb/9aT3S4ZSqKGSCahUc3tU6YcWFd+b9wDZH1B38bEjQn6uFmZD0AI6Au7S7YoXEMoEyfdeoYArRQAB4fXwVJ5rYXHbWTSmmu56TIi3t0QxEYwMHB8Llyd4hySZmJ0yDM199IfwPwSsrQeojoE0eDu/mL2ECguLPpQbamw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGRxASlT1kYAkMmfQvRcm8e9ea71zb5PiC+7P2xgV6M=;
 b=ZUGJ/GIG3nCiCMo5nFUQ4uZLgp/yFc9ilAgxxudepN0Bg3z7A0mPP++IRBnJKcEdK4WvSvEtlhLC8UleLYg1elgoQdp5vvIseW492/uKUXMG5P1BnBKLgUi2eqg9sFL6Nambi58hhXKudYFodk/vneF7fwIFD1gxLm/izht6+qbKcohFw0No0XQk3wATS5DqbrCppiQJ4fr/Vpy/mBfxjCx/80+Riuxmn7d/dMA3csd24St1aUvsdwr8SUx5MJ+X2dge+tUpGZAD9s8ooTUL+GzVpgfdHn0mhQjG3qD+oXsbQt1TZx5GcxE6Y12+IMwULn3RF7au0nz764NalCH/YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <claudiu.beznea@tuxon.dev>, <pavel@nabladev.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 00/17] Add RZ/G3S PCIe support
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 00/17] Add RZ/G3S PCIe support
Thread-Index: AQHcurUEgTGpo9U8nkK25AEyWq+DcbW9ZYJQ
Date: Tue, 24 Mar 2026 09:10:20 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818E4EF12163C4F09CDE5AECD48A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <189BC4ACC53FCB81.1328210@lists.cip-project.org>
 <69b5da97-4fa2-4ce6-a1f7-74b9bce6712f@tuxon.dev>
In-Reply-To: <69b5da97-4fa2-4ce6-a1f7-74b9bce6712f@tuxon.dev>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY3PR01MB11560:EE_
x-ms-office365-filtering-correlation-id: c3ac30ed-2900-4f25-2285-08de89852ca2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 
 y1H0veFAyBR8zu8wg4aucpN1bS6MGZ/5FkF3oSCdWb7QFakXUIbr5O0ybaUGV4uWaN+Tazfqa4RYit2slFdhfOupi8yFAs5PMIlnVCbKMdtSaRV5MuyCkwl4weq6cER+tONCZAcvzPqhix/bKtF5QG9EY33rzOZcneOGYCPGhp4AzPt9Qic1dLVEVOIz19/jX7UJgIyjD+ryydzdgdTJvvaPA83PZZd6JDWwZIGEk+go/8rPLvPGVz6LL8A9UpiapypX0bS39C/Gaw83fsyshTwS2Ec03N7atuEP/RhlyoM8awLAzLJDAGp5C6/PMex+G/IpWvaxxysS8AYBjGbYR/EjG2h8KOxeezBlOi/5YK4Ao4w5Z24tU5gRUjnBZO8NroRGbl0+rFA8PKcBX32eWMlp1s/HfVy+benkz029vQULkhBZaLFQQ5EM6mdW116e/2ur7Wbo9DkbhzkAMUeYuYcFEPIQbsRyq1sCSkv93hBo5kyQ+IT/xnVUKTnok0brjvMK7waKhzDyc+FDIhD9YUNxseoN/moBUO3Fy4sur0hELkd+Nu/0+6y/DayZDUF2xDWl3YpnzZpSOltay57wNs0hCrtCJTc3/5UB0HBn4CRI9nAsZr8FV/SMvmqcxIQV8AZt7LXebUttzOUx7tpud3kghjqiL8obYJyg7966ZtZ+TRARFVGp3baFFn8aSSxFnsSDQKgCScXJjfr1v57KFfcA+TJ4ZhNrZyknyJfGPahShfN2DQ8yRwAT9KMxjKeNjCvYVf8KSTOx/Bq+/npgLJzgqojQHK6T/TQGXNLuqRE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NDMzSTEveWlvdWJoa29pcDZ3UXpiaGtjSVBZdVNqWGtLeHFzMmhGaDZid1dw?=
 =?utf-8?B?dzJQVTY1SU01amEzd2Q3aDBWWHpiVWY0ZmxUbDJ3UWE2TE1tU2hSU1BPT01Q?=
 =?utf-8?B?V21NdHNQaU53UStnUHp1NnhaeXhtaXNLaUtsMGNiMzVYbXBJdnJpMmJYOHBJ?=
 =?utf-8?B?eHJlQUZnL1EvVHNTY2V2QWx4NGFvNjFNR0lsVGtIRmQ2ZGpVb0RUdFQveGhr?=
 =?utf-8?B?VzVGbmZVZnJOL2tGbjZYOEtMZlhGMU5KSVd3Z0lEdmg2Z2gxRWZQQlJYMWVx?=
 =?utf-8?B?dGVGV20xQURQZlVkb01MS3JSK2Mvang5YURYd3E5dHFUTWQ5U2tMZkk1T1JL?=
 =?utf-8?B?SnhRUkJYeG5QU1VwQldDQjJGL2g2Zmw3RG9YZXFuRWtwTTdnUWliUmlMN2R6?=
 =?utf-8?B?YkdJQko3d2tZaXVlUWxtam5sVG12d2cxQ1pza3o4RnIrejRQUVFPNktHbU9K?=
 =?utf-8?B?OCtuVDg0VkxJb0YxUSt6bWVlcmpQdmFlK3pEZG4zS24xL1lxb2tvMlcxc1F0?=
 =?utf-8?B?ZmVsQlV4Y3F0akZiOU81VW9JemlNVjNFQmFwblI2SEdxVHZXUmpiSVVqYmxY?=
 =?utf-8?B?NHROR1ViU2lkNENtRlplWk91cjFKVUJGaDQxQnZOaXJHMGp4b0VlRnorRXBF?=
 =?utf-8?B?VEJHdUUxNlBQWTNJMUtUbVRnVk02VklmcUdxbHhsbmxZL0JwVGtCTXZibXhG?=
 =?utf-8?B?VC9pUDBhelZJN01KVFhOdTdpUXBLVXFDeGNzVldzSENuMHNQSzZ2NE1NMXhs?=
 =?utf-8?B?TWNucnBQd3JpbXZtMmxIYkNodXdBbThldUpBc3RJRHJ4Vm9Lb3ZaTzZFRVBB?=
 =?utf-8?B?OHE3TU1HRlgrSXYwUDFKU1dMZ2JlUkpPbWtjZXFZOFZ6dG9zaFBMUnlKMzBz?=
 =?utf-8?B?NG11bVltbzY2Si9oclc5TFdLYVQzRVd1enJ2QSt5eENPcE1hMFFOUVBFMEFq?=
 =?utf-8?B?T1lQSHBEWVZWUXNGcU1mMjJjTkhGQmt2VDRCSS9GTFVWZStKa1R3ZWV6c0pj?=
 =?utf-8?B?ZGErMWp3YjF2RGdYWHVTZmRzWm11Y2phUkNzaitYMWtjNzZJem5yVTBzNGh4?=
 =?utf-8?B?QlluUHY2VmNXaWhpc3JHUGRPMWJRcDRwakU4dHdqeUFiUndhTXd6ZnU1UWsz?=
 =?utf-8?B?NFdPYmtZdlhOcEhPWldWVTZUTGpqQ2orMklJaE80Z3hKaEpqZklxc3V4cDho?=
 =?utf-8?B?Uzh2MVhqdmw0VHhobUlqaUFFOHQ5dTJuRFlSZHVHRlBQNWlKcVlmajNsWVZu?=
 =?utf-8?B?YmFPVzN5OUtjamtwWllXRjZxcUlTUmFja2syMlRtdngwMGFSM0J2RnVTeUsx?=
 =?utf-8?B?bmROM1cyMk1oUUJ0N0I4aHBVa2ZxRnl2aTlEREJJcnpjb2J1Ny9KY1ZuR3Vh?=
 =?utf-8?B?RjZDdkNNQVAyQWsxaUZBRHFVNTZNOEk5MVRLbzlWRXZKM0ZmNWFqa3BjUytu?=
 =?utf-8?B?S08xWlFyTTJON1drd0tpOHBjcm5iTzVaTUM4V2Z4K01lVmwxbW5mekdLcVR6?=
 =?utf-8?B?bnlXS25UWkI3dUJGRXRtcE04Q3pFUWlmcEpkcndVUTVuTkZvb3hjTTlobk9Z?=
 =?utf-8?B?RzN6RzFpYkh5S3M0UDRwU3RMUGtUSWRBN1NIWjNuUStzdzRadk9aMDhJMVpl?=
 =?utf-8?B?S1A1a3FHTERRYUtkRGtOOHVRYyt4RCtnM3VKcjd0cUIxSnhpQTBmd3Ztb0Ex?=
 =?utf-8?B?YUVXc1RheHM0YWJ4aEV1OURBSjFid3V1QnFnSU5UcFlBaWlNZkVIS1NXeEgw?=
 =?utf-8?B?NzNqUGkrdXEwQmU2YUlMb2NFM3RtOTVmOEhYUFN0OHY3NTBaLzlPQ1hKd0l2?=
 =?utf-8?B?N0dwamdMbUdkd0R4cTlUZUdaNDNjcEdodytaUXRzaldlUW9rcEVmVmNEM0FP?=
 =?utf-8?B?UEVWUGNqTXpuSStIVFFRQ2JzdnR3bHhtQnZ5ZzdjVklpUVhxVXNPdHNIMDMy?=
 =?utf-8?B?Q0dGZVpiOFJnSzBxOWE3dDN4WnppTjhsR0RXeTF3TW9Nb3VsbzhNVFdhSDBP?=
 =?utf-8?B?UnlZY25JMXhHRnJGY0tRSTRwbXZkbmQ4R1l0VDdTbW4yYUxpNEVyUW15ZHpQ?=
 =?utf-8?B?TURWdFBIM1ovYjZzTTFmZVdwanpSVnJxeHJacm4rQWorUGRsVVVUaHdnTHha?=
 =?utf-8?B?SzQ3OEV3RVY2OWVKMDg1TnhlMzRRcEVHdmtleFB1V3creU1RMGdhY3RxbDVI?=
 =?utf-8?B?VU9NUk5oY2tMd2NWT2tCZjlJTyt3L0E1azlYREdpdG1ycmRmdWFsc3ZUUUd2?=
 =?utf-8?B?bGphWmtUZDM5TkRUdWdLRG5hVlF6dTN6aWFFeFpiQjY5aUxWdlVaV2hQZ3lQ?=
 =?utf-8?B?MGJGenVseFBoM1JxY09zMTlKclhJcGxpRXRqZ0xYejZabktZbWE0UUhhYU1X?=
 =?utf-8?Q?zPrnLbyecRcDXkFY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	QcRT91u/lAfArrYcNockNa/RIli41fjvG6oK652a+AjdS3Qyp6EWdk/VuVZYUomowtrQTLZgFEZP758rfHHjpbvbqs4hN3JsrfF8JMsMrI22Skx/q8/MQSMTZgiy8AGtgFxPMSZT6Wfl4R40T2ifJh1+zstlqgmt8KYSDx8wtOsFqUGMuojAHHk5Z6PEywMMASkR3smYXFeo+02RDkKzncd8geCz4hJJEmnT0veOvuJpAgBnaCGkg6OWnklA57D/Ati9D3eoiE+Xhw6vhxVY5dDhyCKzbaf9qRLIpJBMUYMUkQvuAvxZjsOXIQg7O6FVcZt9Yyj0G4Km58TXMBk3aw==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ac30ed-2900-4f25-2285-08de89852ca2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 09:10:20.5134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GxFOjoR93YDmusFpPW63dhR/xXi7d/0kaFcbgohOlCOVzuZmSynQXEUt8fx2ESq0OJ/sDFMmGtoR9FNzuE3QqgzV9LVfeikYbq//STe9MaDBY0cGwpeCK2XUEC5BHrMA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11560
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Mar 2026 09:10:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22534

SGkgQ2xhdWRpdSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDbGF1
ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiBTZW50OiBNb25kYXksIE1h
cmNoIDIzLCAyMDI2IDg6MDYgUE0NCj4gVG86IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6Hm
tIsg4pah77yk77yp77y077yj4peL77yj77yw77y0KSA8bm9idWhpcm8uaXdhbWF0c3UueDkwQG1h
aWwudG9zaGliYT47IHBhdmVsQG5hYmxhZGV2LmNvbQ0KPiBDYzogY2lwLWRldkBsaXN0cy5jaXAt
cHJvamVjdC5vcmcNCj4gU3ViamVjdDogUmU6IFtjaXAtZGV2XSBbUEFUQ0ggNi4xLnktY2lwIDAw
LzE3XSBBZGQgUlovRzNTIFBDSWUgc3VwcG9ydA0KPiANCj4gSGksIENJUCBtYWludGFpbmVycywN
Cj4gDQo+IEdlbnRsZSBwaW5nIG9uIHRoaXMgc2VyaWVzIGFuZCB0aGUgdjYuMSwgdjYuMTIgYmFj
a3BvcnRzLg0KDQpTb3JyeSBmb3IgdGhlIGRlbGF5IGluIG15IHJldmlldy4NCkkgY2hlY2tlZCBl
YWNoIHZlcnNpb24sIGFuZCBldmVyeXRoaW5nIHNlZW1zIHRvIGJlIGZpbmUuIA0KSWYgdGVzdHMg
YXJlIE9LIGFuZCB0aGVyZSBpcyBubyBjb21tZW50LCBJIGNhbiBhcHBseS4NCg0KUmV2aWV3ZWQt
Ynk6IE5vYnVoaXJvIEl3YW1hdHN1IDxub2J1aGlyby5pd2FtYXRzdS54OTBAbWFpbC50b3NoaWJh
Pg0KDQo+IFRoYW5rIHlvdSENCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0KDQo+IA0KPiBP
biAzLzExLzI2IDEzOjA1LCBjbGF1ZGl1IGJlem5lYSB2aWEgbGlzdHMuY2lwLXByb2plY3Qub3Jn
IHdyb3RlOg0KPiA+IEZyb206IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYS51akBicC5y
ZW5lc2FzLmNvbT4NCj4gPg0KPiA+IEhpLA0KPiA+DQo+ID4gU2VyaWVzIGFkZHMgUENJZSBzdXBw
b3J0IGZvciB0aGUgUmVuZXNhcyBSWi9HM1MgU29DLg0KPiA+IFBsZWFzZSBoYXZlIGEgbG9vay4N
Cj4gPg0KPiA+IFRoYW5rIHlvdSwNCj4gPiBDbGF1ZGl1DQo+ID4NCj4gPiBDbGF1ZGl1IEJlem5l
YSAoMTEpOg0KPiA+ICAgIGNsazogcmVuZXNhczogcjlhMDhnMDQ1OiBBZGQgUENJZSBjbG9ja3Mg
YW5kIHJlc2V0cw0KPiA+ICAgIGR0LWJpbmRpbmdzOiBQQ0k6IEFkZCBSZW5lc2FzIFJaL0czUyBQ
Q0llIGNvbnRyb2xsZXIgYmluZGluZw0KPiA+ICAgIFBDSTogQWRkIFJlbmVzYXMgUlovRzNTIGhv
c3QgY29udHJvbGxlciBkcml2ZXINCj4gPiAgICBQQ0k6IHJ6ZzNzLWhvc3Q6IEluaXRpYWxpemUg
TVNJIHN0YXR1cyBiaXRtYXAgYmVmb3JlIHVzZQ0KPiA+ICAgIFBDSTogcnpnM3MtaG9zdDogVXNl
IHBjaV9nZW5lcmljX2NvbmZpZ193cml0ZSgpIGZvciB0aGUgcm9vdCBidXMNCj4gPiAgICBQQ0k6
IHJ6ZzNzLWhvc3Q6IERyb3AgdGhlIGxvY2sgb24gUlpHM1NfUENJX01TSVJTIGFuZA0KPiA+ICAg
ICAgUlpHM1NfUENJX1BJTlRSQ1ZJUw0KPiA+ICAgIGFybTY0OiBkdHM6IHJlbmVzYXM6IHI5YTA4
ZzA0NTogVXNlIHN5c2NvbiBjb21wYXRpYmxlIGZvciB0aGUgc3lzdGVtDQo+ID4gICAgICBjb250
cm9sbGVyDQo+ID4gICAgYXJtNjQ6IGR0czogcmVuZXNhczogcjlhMDhnMDQ1OiBBZGQgUENJZSBu
b2RlDQo+ID4gICAgYXJtNjQ6IGR0czogcmVuZXNhczogcnpnM3Mtc21hcmMtc29tOiBBZGQgUENJ
ZSByZWZlcmVuY2UgY2xvY2sNCj4gPiAgICBhcm02NDogZHRzOiByZW5lc2FzOiByemczcy1zbWFy
YzogRW5hYmxlIFBDSWUNCj4gPiAgICBhcm02NDogZGVmY29uZmlnOiBFbmFibGUgUENJZSBmb3Ig
dGhlIFJlbmVzYXMgUlovRzNTIFNvQw0KPiA+DQo+ID4gRmVsaXggR3UgKDEpOg0KPiA+ICAgIFBD
STogcnpnM3MtaG9zdDogRml4IGRldmljZSBub2RlIHJlZmVyZW5jZSBsZWFrIGluDQo+ID4gICAg
ICByemczc19wY2llX2hvc3RfcGFyc2VfcG9ydCgpDQo+ID4NCj4gPiBLZXZpbiBYaWUgKDEpOg0K
PiA+ICAgIFBDSTogQWRkIFBDSUVfUkVTRVRfQ09ORklHX0RFVklDRV9XQUlUX01TIHdhaXRpbmcg
dGltZSB2YWx1ZQ0KPiA+DQo+ID4gTWFyZWsgVmFzdXQgKDEpOg0KPiA+ICAgIGdlbmlycS9tc2k6
IFNpbGVuY2UgJ3NldCBhZmZpbml0eSBmYWlsZWQnIHdhcm5pbmcNCj4gPg0KPiA+IE5pa2xhcyBD
YXNzZWwgKDIpOg0KPiA+ICAgIFBDSTogUmVuYW1lIFBDSUVfUkVTRVRfQ09ORklHX0RFVklDRV9X
QUlUX01TIHRvDQo+ID4gICAgICBQQ0lFX1JFU0VUX0NPTkZJR19XQUlUX01TDQo+ID4gICAgUENJ
OiBNb3ZlIGxpbmsgdXAgd2FpdCB0aW1lIGFuZCBtYXggcmV0cmllcyBtYWNyb3MgdG8gcGNpLmgN
Cj4gPg0KPiA+IFN5ZWQgTmF5eWFyIFdhcmlzICgxKToNCj4gPiAgICBsaWIvYml0bWFwOiBhZGQg
Yml0bWFwX3tyZWFkLHdyaXRlfSgpDQo+ID4NCj4gPiAgIC4uLi9iaW5kaW5ncy9wY2kvcmVuZXNh
cyxyOWEwOGcwNDUtcGNpZS55YW1sICB8ICAyNDkgKysrDQo+ID4gICBNQUlOVEFJTkVSUyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICA4ICsNCj4gPiAgIGFyY2gvYXJtNjQv
Ym9vdC9kdHMvcmVuZXNhcy9yOWEwOGcwNDUuZHRzaSAgICB8ICAgNjcgKy0NCj4gPiAgIC4uLi9i
b290L2R0cy9yZW5lc2FzL3J6ZzNzLXNtYXJjLXNvbS5kdHNpICAgICB8ICAgIDUgKw0KPiA+ICAg
YXJjaC9hcm02NC9ib290L2R0cy9yZW5lc2FzL3J6ZzNzLXNtYXJjLmR0c2kgIHwgICAxMSArDQo+
ID4gICBhcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnICAgICAgICAgICAgICAgICAgfCAgICAx
ICsNCj4gPiAgIGRyaXZlcnMvY2xrL3JlbmVzYXMvcjlhMDhnMDQ1LWNwZy5jICAgICAgICAgICB8
ICAgMTkgKw0KPiA+ICAgZHJpdmVycy9wY2kvY29udHJvbGxlci9LY29uZmlnICAgICAgICAgICAg
ICAgIHwgICAgOSArDQo+ID4gICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL01ha2VmaWxlICAgICAg
ICAgICAgICAgfCAgICAxICsNCj4gPiAgIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1yemcz
cy1ob3N0LmMgICAgICB8IDE3NjQgKysrKysrKysrKysrKysrKysNCj4gPiAgIGRyaXZlcnMvcGNp
L3BjaS5oICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMTkgKw0KPiA+ICAgaW5jbHVk
ZS9saW51eC9iaXRtYXAuaCAgICAgICAgICAgICAgICAgICAgICAgIHwgICA3NyArDQo+ID4gICBp
bmNsdWRlL2xpbnV4L21zaS5oICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAyICsNCj4g
PiAgIGtlcm5lbC9pcnEvbXNpLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDIg
Ky0NCj4gPiAgIDE0IGZpbGVzIGNoYW5nZWQsIDIyMzIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvcGNpL3JlbmVzYXMscjlhMDhnMDQ1LXBjaWUueWFtbA0KPiA+ICAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1yemczcy1ob3N0LmMNCj4gPg0K
DQo=


