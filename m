Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7135.1794983034135972652
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 22:23:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=N7NXaD4E;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1794983025;x=1796192625;bh=WtQPRnlZBkHQ+zXyWaX6epHMVCoLg2Xe0UiGf
	u9l1Rs=;b=N7NXaD4EUsVgYCKi5vLb97cbu6VEqXkCcMlbnUv539rxrIcaCfPrwKUcid7U+VVEQEi
	L8yEOj4/mTEe53LwUvhMUEgGnkM9LdPVb5RZRLFm+rvFHicaQuxydranbsZFJrOgYqoO359DZmSv8
	hAJl4aJlr0VCXPopNYyBFAtB9Ey/vVs+MZ3lmzkYkgiOdQCJowSrgPjb/gqm0wwUJUqiUyYOvw2o5
	QsixF/Q/a8mq94qud/DKkDez/vcFYvuk2cQ4oLL3kHragGBpaTlzr4LTWpoh153m0Wv0Vebih66SZ
	/TJNSLcrKHI68BUQwiIqbPw+xLOjzGFO3ffF5C7su43w==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 6AI6NhGb2073227; Wed, 18 Nov 2026 15:23:45 +0900
X-Iguazu-Qid: 2yAbBL6ZOOTW2ZnaAa
X-Iguazu-QSIG: v=2; s=1; t=1794983022; q=2yAbBL6ZOOTW2ZnaAa; m=NlI5Qb+rbtUlTSTPMjMbn1kq4VdtxTdbGp977xyr7KU=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jTs4D6dRpz1xnZ; Wed, 18 Nov 2026 15:23:40 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RLYDF0PScTW2QGbNzZM4Qa6TkfZmSC+CC9ESdnTlvBeNPFTQz21a+3pKUXpJZzQkm7VVZRPMBtGbWz5arpJk7y4XmHnM2mWT1RI2dAyrFyTlAhM505K0c2g5rujoEJapARsHjdSbjK95qYQMF7xQxANVenQ1oqjPoWxi/nSr1UXazHZy0yPpJlmqvfvuGXrIBZDJFb8tZykFzjIch3wzYBhUB6ifd1mKqW7fg1rnbNccgyyjLmayKA4EmYxvQjvxIvwqdVRKcuUsSUdRCqDS4SwwvctQ/0HSG7DAHsglaa8aOsx5t4Cd8X4eRKqqnTCGiDnwP997wcnSfLsHm27MEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtQPRnlZBkHQ+zXyWaX6epHMVCoLg2Xe0UiGfu9l1Rs=;
 b=kjq039gzaajz30OP1hO7Px7CjtLZPpfgnuNMnPKKur9fvMRAHNnQesrfiGFTudUW6SRu2kKWukFesuDcpaqu3sU7oR1o1USebUl52WUwnOC5ziYIpIsVupgRWRcNmXXuF1biIu/QRVWN1UZHSKJtdddi+TG8AVz9mdXWiafAujZvSkv2C7gzuThBUxCZgRl1F3G/F+xy59etR5c/duG2yfD9EKf0KLiN+/O3JIWmYVQFGQ6/w7moO99035x8QdA9kAB11W6/mfQeobIrVMqJSEeNzuUFyUkc0uPsarswx8d6yF4JgttvjVj9H9hFxN8ai6JwsSzZAG8Q6bwVciMPGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <jan.kiszka@siemens.com>, <pavel@nabladev.com>
CC: <masami.ichikawa@miraclelinux.com>, <cip-dev@lists.cip-project.org>,
        <uli@fpond.eu>
Subject: RE: CVE-2026-99288: Re: [kernel-cve-report] New CVE entries this week
Thread-Topic: CVE-2026-99288: Re: [kernel-cve-report] New CVE entries this
 week
Thread-Index: AQHddf8kt9pQlXSsc0Ouo0UJR/DpHrcyyI0AgACSGQCAAAI8AA==
Date: Wed, 18 Nov 2026 06:23:38 +0000
X-TSB-HOP2: ON
Message-ID: <TY7PR01MB148186C947FE82E3094B8F4A4CD7A2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <CAODzB9rb+qvRFhe8UcFY2Pt-j82sqgpS=mfc4NbCrbdwww2Tpw@mail.gmail.com>
 <4b4745fa-2a9e-48ea-996f-fff98ffec832@siemens.com>
 <avzGdm2kkPzk8cLD@duo.ucw.cz>
 <63257a1a-dcbd-46ea-958d-fd4fc876cd2e@siemens.com>
In-Reply-To: <63257a1a-dcbd-46ea-958d-fd4fc876cd2e@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY6PR01MB17919:EE_
x-ms-office365-filtering-correlation-id: 1f988bbb-0339-4363-ae7e-08df453c7b9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|38070700021|10067099003|11063799006|56012099006|4143699003|261026121527099003|261026140227099003|261028144727099003|261022075727099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: pW1QmSe7b8ePF/ZrxmXTfAG6WsRTpUkBI18YhfX5ljM9YyJ8crcecxfWpLAfRZrGqTyeVaEOA8QsHY4dsGiKUrjMPH0KddfAiulRGPRP4fYkaFZEy2YLJ0ZQ61B57ak8RqIvp7Qv3ojigI+viEJBwS+P1d6duhJvf3TpQfHjL/K8oozNolQLU9YYj15LOCW3gghsKV4kzZVEWGIuYxLCO4z68jlSZ5eIcYpmB8pTm/Z47dqI9jXyXFPY9ZUmRNLS+igRbT2f+juozGRCetAprKIY91iJdEzKSvLCo3YxWxrKmuTmvwYc4MuU0wIIlwABCkZjd+X8GjdFSP1jpnrcPf9/CSxjMgBw9fRFcTOiKcLyjajz+OTeRSuaVwJWYDzWCwiWsxiE95u24r0KkQ2Bh4xbDi070XoWUJoAsgCdOvAQ10iwDf3VhbLG0gKoxQbGUHqlhP4Gwjp/4DfeZRmWDSTmaIxQzMDGAPrTseRn9pjAhNbaYMSecWUx2NToJH0NJWUWwkL/HdwuB81U8DXge2HYbYdAiSQdxHyK8Tx5xrcX1SECRPkaEPhmvUu1ZeS+iqbVELTQXdnZyXvYEaes+40fZfdn97cgqyMaQERXublM94ndVTK5/UbA2dkuwqi4TB22zggu1s2PiXlJdn8QzAl3X1s4uV0rH2XyB5LU2KAI8jAvWeBCPd5eiW+uRkAez9c7R6XqdlOw7PF85xPiCJwOns/VwnIqZOjUxFpvckw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(10067099003)(11063799006)(56012099006)(4143699003)(261026121527099003)(261026140227099003)(261028144727099003)(261022075727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXRvcXppdCtXNFBMT2VEVkhzenYrUklvcDV2VTk2QnBRMEVWSGlhWFkzSEdL?=
 =?utf-8?B?Z1ZYUGd6SDJjWkFXWHZiU2t6NDVRZlhRcE8xZjM4NUhrQ01BUitZby9WMFgx?=
 =?utf-8?B?R2tUUnhVc0hyTVo4a0Q1VXlyZlhxZlkxblhZVWtoUEpTek5QRTEzZXN5TzY1?=
 =?utf-8?B?RU9PbEhRTFdaSWRFYllRcnZwWUxpQkdkM0lNdXBYREQ0MVVZdkx5MVNvV3ha?=
 =?utf-8?B?dWxOR1hsTDBtZzBvdzU2TkhJSU9HV2hKS25aa25MNURXZi9SOWp2SmluNWVR?=
 =?utf-8?B?alFwZkhiRnV3eGVsb0Fvang4WlVwbThGVGZXWVM2WEVHT3NMU1d2L2Z0S0hw?=
 =?utf-8?B?Vmxwd3UyUmQ2Rk9ubDhGRzJSUFRqeTBWUWQycDBQODhyTW82TEZzcXZaQWZI?=
 =?utf-8?B?Ui9aUmVFT3dZdjhvNEtZRndyeVJoZGYxRFdCc2lWM3VrYXhGNG8rTnZqK1VV?=
 =?utf-8?B?VUpSYS9QcVkwSzBUdFNHSm5sdmVtMjg3cWZwRkJmQnlwVEpvNm51bHhtZ0lO?=
 =?utf-8?B?OWNBdmhLNERGNDNUbEFlUzViRi9ocUsyV0pRRlBuY1l1U3BmUFQ1Skpibzdl?=
 =?utf-8?B?SGNBRVJESEFsOG5PclhPSHFSZEZZVWxrb0tONHBPZjlZbTY4TTVobkRnVVVo?=
 =?utf-8?B?eXVoaW9ZdllGM2lpOTYxcWNGYlBUTi85ZE0vMHBPeHFWSUViUmwyZEJCc2lo?=
 =?utf-8?B?U1JKZWdLK3BLRmQ5OWlyWG56UjVTVzVoeGI0UWtzRHgrMzFNNzZQcFRsUGpx?=
 =?utf-8?B?WkhnN3BNS3VSakV0VCt4VER3ay9vTzJ2NDg2bllia3ZYQmZGMUFqcnMrejBv?=
 =?utf-8?B?MlJMaHZTdEhJSnJvQmhhYWlCaVNOQjhiNFBWbDYzZEFZbi9rbXMxcm95NHcw?=
 =?utf-8?B?NytUOEpoK0pDZ2U5MlkzNnlEUWxrcEdTeHI5elpvRVF0a2ZudW1lUEdGTVRL?=
 =?utf-8?B?TG1ST2haOXlSYk14Mi9TRG9udC8rZVBseXFucmQ4bjVyY3pzbGFxNkZIY3Zu?=
 =?utf-8?B?SU8wak4zM0pIYXlsbEord1ZqTE9tYnFMTE5FaitVSkhUYmZLTFc4LzFDbFlP?=
 =?utf-8?B?eUFCMHJaWmtXWG43aGVpRGkySGpPWmJQTXZQREY5VnhzYXA1UUhqQjdDejFo?=
 =?utf-8?B?N25wM1hOSHlyVUloL1FQeXpTMDM1VnZnMGZMT3pNZzF0aXVtY3l3REkrYUc0?=
 =?utf-8?B?UDZxdVNGOURFUkloTElVVUdIdGhyNlRvSC82M3JyWlYxZTM4WmtFL0xPV3hy?=
 =?utf-8?B?NzBCTWhQWThQV2JJdXZNTFo4emU1ZGRQdFJSc3F4YmJTZ3Eyd1ZPbnNxajQ4?=
 =?utf-8?B?b05zSURWTnV1U05keFlSU3Q5NkdsVm5SamFtdW5KYmYvbFpHeVFtKytoZ2Jk?=
 =?utf-8?B?WnZzVUJkL2dURk82VHhzYXZrNHFVZVUveDVVOTFiU1BRZWltWTU5VFV6UVIz?=
 =?utf-8?B?eDVhTGxPbzFmNHZVdVAwTGZKV0Z2UklmVGZ4T3lwclVKL2p2Q1dWT09OT0t3?=
 =?utf-8?B?NUo3dlB4QnV6d2x3TEFoY2gvdmRHOE9sbk1Yb0dzSFhjOVVVeWpVL2RxcUZ5?=
 =?utf-8?B?anFoY0dhT0ZwUnVOV0Q2MC9NSi9udDNJYnJaS0JvOHFPYUdaZW1qYnZNcmhu?=
 =?utf-8?B?NE1ZUGxrWjNYcGtrRkpTUkdMaTFGNWIyekpBaDZkL1ZLMENqSlhidU1rc2FR?=
 =?utf-8?B?MGRPV1BqSTZOcHNya3d2QlVXb1F2b3lQbWM4a0IwUGoyT0FJb2VJTWdOOG1B?=
 =?utf-8?B?eUZhWVFBbVdnL3dzUDBTMVE0S1ZGd1duR1VybHk2T2xISTRuY3N6OW1oL1I5?=
 =?utf-8?B?eEdhaVBCZm9DTlp6RlQ3L0VOZXV5eVR5bVhKaEM3VlhVcGFJWjFvLzcySFlT?=
 =?utf-8?B?MDFIRUlBYm9QQ3krVTM1WDA4VjFHd0VJdFh0Y3UwbzQ2RkN5ZEVLRkVRamV0?=
 =?utf-8?B?K2RlQUdRZ1hTRmlGamNJNWRzcWRRRTZOdithMmoybGhSbVBqeUlpNjhydGdN?=
 =?utf-8?B?Yno5K25TMnRIKy9wVEFxZmJYai9rdXUyTEd3MHhyeWdkTmhVTjZmVVNDRFJL?=
 =?utf-8?B?YmdxRFBQT1l2Tm9Bbk9KbXBjcXVJTW5rYVIzNWUwVWhiREF4Z3RBbGJvOXRL?=
 =?utf-8?B?R2g1K3R4UE5tSWt6QUpEWTNCVnB3ZjI2citVZ2hEeTlCK3huVi9VelppWklD?=
 =?utf-8?B?ekxFUFAyYUsyZjlqRFZPcVZtM3k4YmRxc0owZlArb3pTbHI2dU1Qb1Myc3pB?=
 =?utf-8?B?c3MzL0xiKzB0eHNScS9ZQkR6VU9GclVzdTFVdEpaUS9QSzJBRkpubHpGMWpV?=
 =?utf-8?B?U3lLZlpjTDFVSkNlVUszS0pXMG92bllUL1AwNHdQU041R0R4b3E1bllTR2Jy?=
 =?utf-8?Q?NXyu8piJ6tPB6Ukg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: snTikxwec3GuhmPhFLOaI36Cia2LwQra1Z6iR2i+otfw8W7zYOnKDmXAWgOzrTm5nS0ws/AfhnjsM6FmFEC9/xm4x7+2lPwWDzO5sC5GSooYAsOQqrusUmi1vm/HrlqCZtBlLcQW+ImzTVjFVWth0yyJMRSI6kyCGjHrhlyUCEeR4JPImw245AUg8j45wE3kzEZH1pY81FVec1Kivxbl7l1Fv5wV8hRfZjgTs8pgroDdftqPd/0QcOI4PkKkwbMBpExjzrLbw2kfxlJNTKYGURaSlwyHbWJl0Fiy5ZvyQd28QK5G3XvesRvJqLJIiPHTq+t8bQkk9yKzX8TX158VGA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f988bbb-0339-4363-ae7e-08df453c7b9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 06:23:38.3831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zoygF0l/UYqM8KBxT3cLVmzJCpbwQAptw7FUkpZLxZoUEWbZ2mAABZei+kRaCi4vJOqR8PkmN5LhtFbQNPsT5svXgyAF/bj6MWgDz3GH6onI9cvWDMKp0Aay71H5VCjh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6PR01MB17919
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 18 Nov 2026 06:24:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24951

SGkgYWxsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEphbiBLaXN6
a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIg
MTgsIDIwMjYgMzowOSBQTQ0KPiBUbzogUGF2ZWwgTWFjaGVrIDxwYXZlbEBuYWJsYWRldi5jb20+
DQo+IENjOiBNYXNhbWkgSWNoaWthd2EgPG1hc2FtaS5pY2hpa2F3YUBtaXJhY2xlbGludXguY29t
PjsgY2lwLWRldg0KPiA8Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc+OyBpd2FtYXRzdSBu
b2J1aGlybyjlsqnmnb4g5L+h5rSLIOKWoe+8pO+8qe+8tO+8o+KXiw0KPiDvvKPvvLDvvLQpIDxu
b2J1aGlyby5pd2FtYXRzdS54OTBAbWFpbC50b3NoaWJhPjsgVWxyaWNoIEhlY2h0DQo+IDx1bGlA
ZnBvbmQuZXU+DQo+IFN1YmplY3Q6IFJlOiBDVkUtMjAyNi05OTI4ODogUmU6IFtrZXJuZWwtY3Zl
LXJlcG9ydF0gTmV3IENWRSBlbnRyaWVzIHRoaXMNCj4gd2Vlaw0KPiANCj4gT24gMTcuMTEuMjYg
MjI6MjYsIFBhdmVsIE1hY2hlayB3cm90ZToNCj4gPiBIaSENCj4gPg0KPiA+Pj4gQ1ZFLTIwMjYt
OTkyODg6IGluZXQ6IHJlamVjdCB1bmhhc2hlZCBzb2NrZXRzIGR1cmluZyBlc3RhYmxpc2hlZA0K
PiA+Pj4gbG9va3Vwcw0KPiA+Pj4NCj4gPj4+IEFubm91bmNlOiBodHRwczovL3d3dy5jdmUub3Jn
L0NWRVJlY29yZD9pZD1DVkUtMjAyNi05OTI4OA0KPiA+Pj4NCj4gPj4+IEludHJvZHVjZWQgY29t
bWl0IGlzIG5vdCBkZXRlcm1pbmVkLg0KPiA+Pj4gSW50cm9kdWNlZCBieSAwNzkwOTZmICgidGNw
L2RjY3A6IGluc3RhbGwgc3luX3JlY3YgcmVxdWVzdHMgaW50bw0KPiA+Pj4gZWhhc2gNCj4gPj4+
IHRhYmxlIikgaW4gdjQuNC1yYzEuDQo+ID4+Pg0KPiA+Pj4gRml4ZWQgc3RhdHVzDQo+ID4+PiBt
YWlubGluZTogWzRlMmIzZWYxOWUwZTA0YWRjYTM4NDQyZjA3ZGQ2YmM5M2M3MTJiZjFdDQo+ID4+
PiBzdGFibGUvNi4xMjogW2Q2OTEwMDM0MGI0Y2FlMDhkNDBmODk4ZjFiNjAxMDMyNDAzZjZiZTZd
DQo+ID4+PiBzdGFibGUvNi4xODogWzhlNTE3MmNiZDIyN2ZhZTMyZjMzMTNjYmExZjNlMWI5ZWRi
NWM0ZmRdDQo+ID4+PiBzdGFibGUvNy4zOiBbZWI4YTJkMTU2ZjJjMWQ4NjJmZmZkZmQxYjM0MzJi
ZmJjZDkzOTg3OV0NCj4gPj4+DQo+ID4+DQo+ID4+IFRoaXMgb25lIGlzIGdhaW5pbmcgYXR0ZW50
aW9uIG5vdyAoIk5vaXN5VENQIikgYmVjYXVzZSBpdCBhbGxvd3MNCj4gPj4gcmVtb3RlIERvUyBp
biBkZWZhdWx0IGNvbmZpZ3VyYXRpb25zLiBTY29yZTogNy41LiBBcmUgaGFuZGxpbmcgdGhpcw0K
PiA+PiBzcGVjaWZpY2FsbHkgYWxyZWFkeT8NCj4gPg0KPiA+IEkgdHJpZWQgdG8gZG8gYSBxdWlj
ayByZXNlYXJjaCwgYW5kIHRoaXMgc2VlbXMgdG8gYmUgbW9yZSBvZiBzZXJ2ZXINCj4gPiBpc3N1
ZSwgYW5kIG1heSBiZSBoYXJkL2ltcG9zc2libGUgdG8gZXhwbG9pdCBpbiBlbWJlZGRlZCBzeXN0
ZW1zLg0KPiA+IFJlc2VhcmNoZXIncyB3cml0ZXVwIHNlZW1zIHRvIGJlIGF0IGh0dHBzOi8vZ2l0
aHViLmNvbS9WNGJlbC9Ob2lzeVRDUA0KPiA+IC4gUXVvdGluZyAic28gaXQgY2FuIGJlIHRyaWdn
ZXJlZCBhZ2FpbnN0IHNlcnZlcnMgdGhhdCBoYXZlIHR3byBvcg0KPiA+IG1vcmUgUlggcXVldWVz
LCBvciB3aGVyZSBSUFMgZGlzdHJpYnV0ZXMgcGFja2V0cyBhY3Jvc3MgbXVsdGlwbGUNCj4gPiBD
UFVzLiINCj4gDQo+IEp1c3QgdG8gYmUgY2xlYXI6IFdlIGhhdmUgc2VydmVyLWxpa2Ugc2NlbmFy
aW9zIGluIHNjb3BlIGFzIHdlbGwuDQo+ICJFbWJlZGRlZCIgZG9lcyBub3QgaW1wbHkgYSBzcGVj
aWZpYyBzaXplIG9mIHRoZSBzeXN0ZW0gb3IgcGVyZm9ybWFuY2UuDQo+IA0KPiA+DQo+ID4gc3Vk
byBzeXNjdGwgLXcgbmV0LmlwdjQudGNwX3N5bmNvb2tpZXM9MCB3YXMgY2l0ZWQgYXMgcG9zc2li
bGUNCj4gPiB3b3JrYXJvdW5kLg0KPiA+DQo+ID4gSWYgc29tZW9uZSBiZWxpZXZlcyB0aGVpciBt
YWNoaW5lIGFyZSBpbiBkYW5nZXIsIHBsZWFzZSBsZXQgdXMga25vdy4NCj4gPg0KPiA+IFdlIGNv
dWxkIGRvIDYuMTItY2lwIGZhaXJseSBlYXNpbHksIG9sZGVyIHdvdWxkIGJlIG1vcmUgdHJpY2t5
IGFzDQo+ID4gdGhlcmUgd2FzIG5vIHN1aXRhYmxlIC1zdGFibGUgcmVsZWFzZS4gQnV0IEkgZG9u
J3QgdGhpbmsgdGhpcyBpcyAiYXMNCj4gPiBiYWQiIGFzIGJ1Z3Mgd2UgZGlkIGV4dHJhIHJlbGVh
c2VzIGZvci4NCj4gDQo+IENhbiB3ZSBzdXBwb3J0IG9uIHRoaXMsIG9yIGlzIHRoaXMgb25nb2lu
ZyB3b3JrIGFscmVhZHkgKDw2LjEyKT8NCg0KRm9yIDUuMTAueSBhbmQgNi4xLnksIHRoaXMgZml4
IGhhcyBiZWVuIGFwcGxpZWQgdG8gLXJjLiBXZSBuZWVkIHRvIHdhaXQgcmVsZWFzaW5nIExUUy4N
CkZvciA0LjQueSBhbmQgNC4xOS55LCBjYW5kaWRhdGUgcGF0Y2hlcyBhbHJlYWR5IGV4aXN0IChi
YXNlZCBvbiB0aG9zZSBmb3IgNS4xMC55KSwgc28gDQpJIHRoaW5rIHdlIGNhbiBwcmVwYXJlIHRv
IGFwcGx5IHRoZXNlIGluIGFkdmFuY2UuDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg==

