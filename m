Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE86C43458
	for <webhook@archiver.kernel.org>; Mon, 29 Jun 2026 07:14:41 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.32371.1782717273873583572
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jun 2026 00:14:34 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 65T7EVdG1437026; Mon, 29 Jun 2026 16:14:32 +0900
X-Iguazu-Qid: 2yAaj7rWyIwQOqOlkd
X-Iguazu-QSIG: v=2; s=1; t=1782717271; q=2yAaj7rWyIwQOqOlkd; m=5uie7r5DQAQ78ciFHC087GJZ1PJxTiM3OelyfILMCeM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gpcwR58GCz1xnZ; Mon, 29 Jun 2026 16:14:31 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GtmwWPykt15z5viYiet9d2ooaargQ5V+v9k8js1VWKxlpLFY+UEOugadTEb8B+IrWEBVV//FZ8fysz60uxXX4IZ54yzqkeccgx3r6VgJ/kjrugvM4BTPSVw16RZOcZzl26ySHecCyr89GWcRYbz/VcBbmPW8aEoAp4wSPNfcHwt57fdBCbVMn/XZnqCHlKeO3iFaWWSmWOGLvuSCRzJjKqeREmJ6HuqKlDwoQNmQu88/iAE4v0HRVhWXuWJo4whoYS+71138ARcCY7zxCmqUc1uRQLpguC+hGtqXp8yTHp13crG/BqVC0CpRRcLbPX8KGOSRnFiBJk1LX4edPH7Wdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGiIEh5gXz10354T1x88qdKuc6iT28/VlctZ88tETXM=;
 b=PK7sb31fQmnSuR4KyH2jqrTSnBAtfRTbLE7BD59S+EggFUwRIUMZhzRUd5Ffs3RkpRZgmJOEPRPKa3BlS2LOvCOW/3PmJQwrg2b3GDckRDTLkrLX5g/G98kPl+vb99m9/xU4jcd/7GgM7zy90ruBS/AT8IGPs2412kc62GiiWZvFxmfQlFRKgaE2lKdL2obb6Si1lDp4Okya7BeQeyFEzww5U1gn5ENXmyCIOICGAsnJMl7gl+uO5jURCcNgjNeOvpq4/m8H1jI0+PL+2tcfqhAcaLAO9/hOmKiM7vC2HIdJdJ0WWz2/5WXZT1A+nPI4TmvjlXAXdvWF+HEt3EbQug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <Adithya.Balakumar@toshiba-tsip.com>, <dinesh.kumar@toshiba-tsip.com>,
        <kazuhiro.hayashi.f74@mail.toshiba>
Subject: RE: [cip-dev] [isar-cip-core][PATCH] Revise README files to reflect
 the latest changes
Thread-Topic: [cip-dev] [isar-cip-core][PATCH] Revise README files to reflect
 the latest changes
Thread-Index: AQHc/9wX8akHVB2NLkytfu/sGsJQbrZItVEAgAFYFMCAAfWWcIAAFXiAgATO8NA=
Date: Mon, 29 Jun 2026 07:14:28 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB110758EEF7898CFF2649036BDC7E82@TY3PR01MB11075.jpnprd01.prod.outlook.com>
References: <20260619105617.1891671-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <8b2cfa70-08fe-45ff-8695-7564b37f36b8@siemens.com>
 <TYWPR01MB11063B595D1725A7B252067EAC7EF2@TYWPR01MB11063.jpnprd01.prod.outlook.com>
 <TY3PR01MB11075F67BFD39AEA29DD9D095C7EE2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <38ec0a76-9e33-4976-a6a4-612b4c12d935@siemens.com>
In-Reply-To: <38ec0a76-9e33-4976-a6a4-612b4c12d935@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|OS3PR01MB7078:EE_
x-ms-office365-filtering-correlation-id: 3dab0837-b91d-4f0b-ecba-08ded5ae0f0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|23010399003|376014|10070799003|366016|38070700021|6133799003|22082099003|18002099003|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info: 
 y8qQyQeXzcrUYItrHavuPbQpjkadRrJmBBJddRbiSIwoGc6zMuXEIP8vHqaHsZ67ya12oQIULEoWbMl0Du2VXAcTPM/Vvmh+Jk823brNcvbxkw8v6JPdPX2d8sc4PrvtaCm3uDSQVUxfudsj1qWuxsOWx0n5L9got5Qbp4QT9TFS8AJzsMu4hzO0HSnVV84rSi0VOM8dBeuS7AZbalte+9iKLG0a4NV7+H7+vFVymhELhR0zemYQWt25GDF8SrPbXNjK5rST7LypJr2et5eRyv7fCuHyjSpvO9jegVDAHeBFd6fnjtJjAC+0y/CMXDjZtn2ORdZ3O6deRrQi3nE3Em/S71XWjgoKJAhkiUW/xzcZxDnkwQ6IIYMGnh3LuKlTT6jgUlpHYam2WCiy3hI1p3qC+53Q9R8Ndwz48y+bz3mdM8iRHajndtWfZ3e75S0yIh36N8ZVIykASKdBMBvcqHftRhM0Q8mo4zlFWThsydRSzhHf56cqyo7PGmAJHdpl9cocGix8Ur4iKUMjM7Z3Cwp6qXn1KaRjwa9H0JXSX+8mKwp8hIZATn8uhAp2H7wC4OPYDtKICqnMQF/J5PeISOEk69PlagaoXWDeihEj8jvTok0ndmo4r4f0wpiXxbC90wuI3xwnH2vx91J7ghaygjt+W1sD+vfAI658CKpt/OxmbEPbb0Haxk/83S76wqkCP4D9TXizTPl4J0rd0my5FYLJXonxOL2ww9QuhdlRZeM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(10070799003)(366016)(38070700021)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VzdremdLREE5RnNKYWpnN3BJdDFqVzl1Z2k4WG9vRTg1ZjY1bjg3Qm1tZkhx?=
 =?utf-8?B?Z3B3UU43WlliZjdVdWRFdms4S3VtblZXVk1SRzMwNmpPMzZTTTZHREUrWDBR?=
 =?utf-8?B?OXYwQzE1N3ROM3M1dlNISWtaK21hUDdBTUdOOWphdzVsRVM4TkMxdkt5SllU?=
 =?utf-8?B?WFp2YmlXNlRlSXFZRmtNUnFVWENuTDUyVVFidmhlZ3gxSDhuZkRYd2dsTlh6?=
 =?utf-8?B?WDRHdHEvQ1k2a0xMWHdoSVJLdHZZbE5BSjFDWTgzMU9SWmlCUldaTVhpYW52?=
 =?utf-8?B?Qjk4dVlXY1p2alEydGFXOFJjanR3cVBEWVAvNUNpOWQrY0E4Z053cjRwQTgv?=
 =?utf-8?B?SHhhK3M3WkN3UDdmdnFwaEtFY0hqRzJOQytoMlQ4Q1A1WTRoTGpUcW1NOXhl?=
 =?utf-8?B?TWE4bjlkL3FUcW1SRkRWTDRMaVpnRG9lcGdwMkFlRVNBUU9aTXptSWQzMzE2?=
 =?utf-8?B?Wk1CaDNZdGtaVHh0L0JYeUpyWW5SakRZOUR4ZUZ6cDNEa0kzSU84aGJCQUFx?=
 =?utf-8?B?Q2sydTZqQ3RMSytBWXJLSHduRWdFd3p4N1FoSDlSQkhlb0J0Z2Iyd2dWcith?=
 =?utf-8?B?YjY5NzFRRTdLekNlZnRmdGM3ZGZ6bDh1N1NkSmFYYmt1UVJaZWZaRExmRWxC?=
 =?utf-8?B?aXV2d3Qyd1h0c3ZxZi91OXFZZTZadXJQbVlVZ1l1VDVHZmFzUWZReGlvQzNi?=
 =?utf-8?B?UldNMzJYZmJiNlNGT0hobHN0OTN0S0lNdkQ2NUhhUjJMWHBacjgrVUpHRmND?=
 =?utf-8?B?RmdJb2pMa29qUHplR3B3TE5HN29hOVorMW1aWDNqaW96ZlkzWXFnRllNQzE4?=
 =?utf-8?B?UUlJazcwbmliOGc1NXluNEc2YjNxeGRFVGpxZ3pONUY2L09aTzZBTU1Lb2lM?=
 =?utf-8?B?djJReGYwcmV0RHl6eHFiV2FjZ1R5ZDlBeFpsYUVFaE56K3pVZ1NMYXBqNTMz?=
 =?utf-8?B?RjhnMUJGRUVjM0JKWGlpWjhURUUyZElkdWRrMXZGT0JrVVUvbDB2MjVBMVd3?=
 =?utf-8?B?anJzU2tnV1Q4cXhTd2phRTgybTl0USt1SmljeU9weEFTUlBuTGFpTzBObHJt?=
 =?utf-8?B?S0c2OHdmZEZpZU5ERGJMdjE2TWxvdTRqYkU1WUc5ck4zQTV1b1ZpbTVjQzVw?=
 =?utf-8?B?d0R2dFpzeE1oN3BzdDVVeHdBWUxOUG95L1hIUGJQUXhsbFArUktJSDJOZGw0?=
 =?utf-8?B?S1d3dDFKMWg0TDRyZGdCVzUvdDFRN3orZWlMTThqbGxLbTNERlVCQmR5WUpZ?=
 =?utf-8?B?WHpTKzc2bHEvdHducUl6T0pYVTNwNDVHQmpYQm96MklJM09kTkNyM3hIUnBZ?=
 =?utf-8?B?SWlEWDN2WUQzdk9QMFhhcGZiTWphWEF2eHdnRTJKR3FUZjBlNXF0SERoSmlF?=
 =?utf-8?B?S3NMdVo5OXhGckhIY2Y0YkdjeWEvSExsYnFqSkM0NDhMVGRrMGlpc1gxdG1D?=
 =?utf-8?B?TGhlazlyZkFyVjVhN0tBdm9TbUhDVTFXQ0hrN1J3dTFaK3JOdnJjdDBETFNt?=
 =?utf-8?B?NFdCMUZNK2dwam14WW9LZTVKV3Y4d3RUWG5QdHFGWUkzV0ZmSTBhTTc4Tlcr?=
 =?utf-8?B?WXB4U3ltNm5VKy83Y2VXN1M3KzNJNVN3VVo4NlBQYmQxend1VTlJdmYrQUl6?=
 =?utf-8?B?citKbFRWQTlSSFUzMmIzNnQ3ODlkbTlIckZ5K3pjR2FxeDZ2Z3pRN0c3cy9m?=
 =?utf-8?B?Tnk3eEdrM2tsWW9la3MyL0FucUVOM0ZHQmN3OUFPblVLMEZzNng3LzFaM25s?=
 =?utf-8?B?MlUxYTlMU3JvbU1HNnppaEQvaTZwSlZ5RnIvREF4ZitGbkUzRDBpQnovREFJ?=
 =?utf-8?B?NDVPZzdzR0tYbzE3ZGgyQ1NkcFU1VEg5VHl3MzUzM1RjMG1XNFFXNlpISEpq?=
 =?utf-8?B?QzZ4NUxCZGdkV0Q1VEVOa1hCcXNWZlI1NzNOS3NxQlViZXZIbWt1TFlLMmVF?=
 =?utf-8?B?NS9BcEQrNUk3TDZYRlN3QU1DaGhiZGJqa3RpVCsvTk16ZlZjUVU3ZnJaMXdq?=
 =?utf-8?B?UENRRmVaTkNESEJ6ZGRLeG1MQzhobmczdlBsYTFSUG1wOE1WMHVRWTIxVTFU?=
 =?utf-8?B?QkJ3WnpDSkRSRml2UHFjbWpFekkxM3ZGdEdZRGJaUnJ1c0YrSVVOMFdudDlV?=
 =?utf-8?B?S2UwejFIR0lLWHBuMEtub1YrNWpvMU0vNUhWSzh1eXVpRHhmTmtXd0liNFJp?=
 =?utf-8?B?elhMRVR2YUoySENpYytWdU43SUJIY01SLzM4dGU5d1lmWndYSkQramhvcS9M?=
 =?utf-8?B?L3pJb28xcEZET1VXTndYWkRlNURLN3hCMU5pMmdFZjhaSnBZZWJCYWRrZWdh?=
 =?utf-8?B?aUNnMk5kS2xoSXA5S3NSck1ZaktEVHN1dmN5YWUzRVlOQjhpK24vc0hDMWxH?=
 =?utf-8?Q?svt+T2mkicgQeKRbqLtHf2I+K6wpzuaeCtcGoH87gqh2v?=
x-ms-exchange-antispam-messagedata-1: 
 q2D+J+JsYVfajPQW2VBGRq0Pb/8mq3RNNJ6g6W08dg39GkhzLF7qKZCD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	ElGJ2Pat1BfcHtRVfsqQk0Mxr/zqt0hcXfD6UNjrBab93lkgVxEgVVKAro5febo1EWU+55QIy+i9sCUTgjpCgIj7OV28YvcaUNkeeAGIgnh+RFGBrxAVeJlxvIgWQhJ2EhCg67KOA+XzGaoRhnG8Huj6PH3aYfiZJUyDA58CNm95UO9X9vrc63Gz0M8UxCnkuEs7f6kfL7GqRN6Y4NVMQnctbrH0UxLMfiXbAlax2MfYPUDu858SNq1E9BSV0fTkUj06+PMp3DWeE3p0cJQZ+WsSwcxD4kGgJd9asIrZZqpBd+rH703/D2n7IK3q/WiILCqPENC+SvdHV/SyNmeGVw==
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dab0837-b91d-4f0b-ecba-08ded5ae0f0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 07:14:28.6512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZbOipTFLvKNlCW+zjcvpccuVxXESmjt/6sGpGJJuYnei/3FHjhEqpz1b7Ac6Yl3Oms4uoMjm/AVapD7wuKt5DGklImZvf0h6eLavASKbBppQ25gb8nVh9DnEcBycOtTs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7078
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jun 2026 07:14:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23298

SGkgSmFuLCANCg0KPiBJZiB3ZSBuZWVkIHRvIGluc3RhbGwgdGhhdCBwYWNrYWdlIG9ubHkgZm9y
IGhhdmluZyBsc2JsayBzaG93aW5nIG1vcmUgZGV0YWlscywgSSB3b3VsZCBub3QgY29uc2lkZXIg
dGhpcyBhIHdvcnRod2hpbGUgc3RlcC4gQW55d2F5LCB0aGUga2V5IGlzIHVuZGVyc3RhbmRpbmcg
d2hhdCBpcyBoYXBwZW5pbmcgaGVyZSwgdGhlbiB3ZSBjYW4gZGVjaWRlLg0KDQpUaGUgaW5mb3Jt
YXRpb24gYWJvdXQgd2h5ICJzeXN0ZW0tY3J5cHRzZXR1cCIgaXMgcmVxdWlyZWQgaW4gdHJpeGll
IGlzIG1lbnRpb25lZCBoZXJlIGh0dHBzOi8vZ2l0bGFiLmNvbS9jaXAtcHJvamVjdC9jaXAtdGVz
dGluZy9jaXAtc2VjdXJpdHktdGVzdHMvLS93b3JrX2l0ZW1zLzgjbm90ZV8yOTg2MDU0NjQwLCBw
bGVhc2UgaGF2ZSBhIGxvb2sgYXQgaXQuIEFzIG1lbnRpb25lZCBoZXJlIHRoaXMgcGFja2FnZSBp
cyBhbHJlYWR5IGluc3RhbGxlZCBhcyBwYXJ0IG9mIHNlY3VyaXR5IGltYWdlLiAgDQoNCklmIHdl
IGRvbid0IGluc3RhbGwgdGhpcyBwYWNrYWdlIHRoZW4gdGhlIGxzYmxrIGRvZXNuJ3Qgc2hvdyBh
bnkgaW5mb3JtYXRpb24gYWJvdXQgdGhlIGN1cnJlbnQgcm9vdCBkZXZpY2UsIGluIHRoYXQgY2Fz
ZSB3ZSBzaG91bGQgY2hhbmdlIHRoZSBjb25maXJtYXRpb24gbWV0aG9kIChyb290ZnMgc3dpdGNo
KSB0byB1c2UgImRmIC1oIiBvciBzb21lIG90aGVyIGNvbW1hbmQgaW5zdGVhZCBvZiAibHNibGsi
LiBQbGVhc2UgbGV0IG1lIGtub3cgeW91ciBvcGluaW9uLiBJIHdpbGwgY2hlY2sgaXQgZnVydGhl
ci4gIA0KDQpUaGFua3MgJiBSZWdhcmRzDQpTaGl2YW5hbmQgSw0KDQotLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KRnJvbTogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcgPGNpcC1kZXZA
bGlzdHMuY2lwLXByb2plY3Qub3JnPiBPbiBCZWhhbGYgT2YgSmFuIEtpc3prYSB2aWEgbGlzdHMu
Y2lwLXByb2plY3Qub3JnDQpTZW50OiAyMyBKdW5lIDIwMjYgMTg6MDENClRvOiBrdW5pamFkYXIg
c2hpdmFuYW5kKO+8tO+8s++8qe+8sCBESVRDX0RJVC1PU1QpIDxTaGl2YW5hbmQuS3VuaWphZGFy
QHRvc2hpYmEtdHNpcC5jb20+OyBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KQ2M6IGJh
bGFrdW1hciBhZGl0aHlhKO+8tO+8s++8qe+8sCDvvKTvvKnvvLTvvKPvvL/vvKTvvKnvvLQt77yv
77yz77y0KSA8QWRpdGh5YS5CYWxha3VtYXJAdG9zaGliYS10c2lwLmNvbT47IGRpbmVzaCBrdW1h
cijvvLTvvLPvvKnvvLAgRElUQ19ESVQtT1NUKSA8ZGluZXNoLmt1bWFyQHRvc2hpYmEtdHNpcC5j
b20+OyBoYXlhc2hpIGthenVoaXJvKOaelyDlkozlro8g4pah77yk77yp77y077yj4peL77yj77yw
77y0KSA8a2F6dWhpcm8uaGF5YXNoaS5mNzRAbWFpbC50b3NoaWJhPg0KU3ViamVjdDogUmU6IFtj
aXAtZGV2XSBbaXNhci1jaXAtY29yZV1bUEFUQ0hdIFJldmlzZSBSRUFETUUgZmlsZXMgdG8gcmVm
bGVjdCB0aGUgbGF0ZXN0IGNoYW5nZXMNCg0KT24gMjMuMDYuMjYgMTM6MTUsIFNoaXZhbmFuZC5L
dW5pamFkYXJAdG9zaGliYS10c2lwLmNvbSB3cm90ZToNCj4gSGkgSmFuLA0KPiANCj4+PiBZb3Vy
IGR1bXAgaXMgbWlzc2luZyB0aGUgdmVyaXR5cm9vdCBjb250YWluZXIuIERvZXMgbHNibGsgbm8g
bG9uZ2VyIGxpc3QgaXQgYnkgZGVmYXVsdCwgb3Igd2VyZS9hcmUgdGhlcmUgaW5jb25zaXN0ZW5j
aWVzIHdoYXQgd2FzID4+Y29uZmlndXJlZCB2cy4NCj4+PiB3aGF0IHdhcyBydW4/DQo+IA0KPj4g
SSBhbHNvIG5vdGljZWQgdGhpcyBtaXNzaW5nIHZlcml0eXJvb3QgY29udGFpbmVyIGluIHRoZSBp
bWFnZS4gSSBjb25maXJtZWQgdGhlIHNlY3VyZSBib290IGlzIGVuYWJsZWQgZnJvbSB0aGUgYm9v
dCBhcyB3ZWxsIGFzIGRtZXNnIGxvZ3MuID5Ib3dldmVyLCB0aGUgImxzYmxrIiBjb21tYW5kIGRv
ZXMgbm90IHNob3cgdGhlIHZlcml0eXJvb3QgYnkgZGVmYXVsdC4gDQo+IA0KPj4gUHJvYmFibHkg
d2UgbWF5IGhhdmUgdG8gaW5zdGFsbCAic3lzdGVtZC1jcnlwdHNldHVwIiBmb3Igbm9uLXNlY3Vy
aXR5IGltYWdlIGFzIHdlbGwsIHNlZSB0aGUgZml4IGZvciBzZWN1cml0eSBpbWFnZSBoZXJlWzFd
LiANCj4+IFRoaXMgcGFja2FnZSBpcyBhdmFpbGFibGUgZnJvbSB0cml4aWUgb253YXJkcy4gDQo+
IA0KPj4gWzFdIA0KPj4gaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC1jb3JlL2lz
YXItY2lwLWNvcmUvLS9jb21taXQvMzZiMTExDQo+PiA5MjY3NDA4MmFhYTEyMjhjNjBlOGMwMjM5
ZmE3Yzk0MTExDQo+IA0KPiBBbnkgY29tbWVudHMgb24gdGhpcyB1cGRhdGU/IA0KPiANCg0KT2gs
IHRoYXQgd2FzIGEgcXVlc3Rpb246IElmIHdlIG5lZWQgdG8gaW5zdGFsbCB0aGF0IHBhY2thZ2Ug
b25seSBmb3IgaGF2aW5nIGxzYmxrIHNob3dpbmcgbW9yZSBkZXRhaWxzLCBJIHdvdWxkIG5vdCBj
b25zaWRlciB0aGlzIGEgd29ydGh3aGlsZSBzdGVwLiBBbnl3YXksIHRoZSBrZXkgaXMgdW5kZXJz
dGFuZGluZyB3aGF0IGlzIGhhcHBlbmluZyBoZXJlLCB0aGVuIHdlIGNhbiBkZWNpZGUuDQoNCkph
bg0KDQotLQ0KU2llbWVucyBBRywgRm91bmRhdGlvbmFsIFRlY2hub2xvZ2llcw0KTGludXggRXhw
ZXJ0IENlbnRlcg0K


