Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E13BC43458
	for <webhook@archiver.kernel.org>; Mon, 29 Jun 2026 12:03:54 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.90608.1782734628714563879
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jun 2026 05:03:49 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 65TC3kHv2431709; Mon, 29 Jun 2026 21:03:46 +0900
X-Iguazu-Qid: 2rWg6M5Yh9ZS89f1Tk
X-Iguazu-QSIG: v=2; s=1; t=1782734626; q=2rWg6M5Yh9ZS89f1Tk; m=tHNnEiAnFl07amK3yYEP2W12m16TlwCNb6nO/5QP3Cs=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gplL972zkz4vym; Mon, 29 Jun 2026 21:03:45 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oT5UNwC13kUNI9O1NGL6ErELUrDnasrce6T23+VHMLak0oebFXYVQWhfY8TgR8Anb4pd8X9Okox5/Sl8Pvu/cdfSN6YxFDUe/lLOWWHkGGYLsUn9GMNq0kQVPvRYHq+1EcZlbhSPO2xJ9QPwLLua93EdUEpNCvERepWHFaYeBgu9oq7FUPZr8Kea72RL8JVuXnZOv7VpAyhANNlyAHge9GY/3CpH6RX74bB/7ZwlQz/y6ZeJpLjiEYEjkZUBRSJBm+JhIJyupc0ZmRiPuDY5Fh8FnvIp1KHWIKYbWaVKsF9EpYO6AHBhEo4yDJz29mX5jVpdLUBIe+zhoq3xsXgGDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yE+uWHHiUxLWtU4ULJxxnDCtsYhUFOqko71Y7CV87Fk=;
 b=QHfTG4sXPgQ4PfvDpu+sUFfcMQOVf/uohvIgxOfpjanbUfzzIz4CJ4mihfc4VppCB3I91jn8lqBltNU+8dSLv+HaY6WZgpRp/xqGHdzw2ycPXu0afijhwqSNUvdxHUaPu7wMtnTNu83odzGVTvj+cGsytL3B9nRdGJq8df4YEdEw4QmPJM/Xi/LfLP1GYnVVmyB7tS167JFylrwisrhglgs6LfjkpywkO4omjlHE0+DndC4waoDFlV5/5saLi4zHHQP/5UuMBtBgJaGcXG8bIdJ+4MZ3evCwWmw5GAXQqeRz5fdmX5Pfjv933iOSEzS5CywdJYOy4NA7UgibALSSmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <Adithya.Balakumar@toshiba-tsip.com>, <dinesh.kumar@toshiba-tsip.com>,
        <kazuhiro.hayashi.f74@mail.toshiba>
Subject: RE: [isar-cip-core][PATCH] swupdate-handler-roundrobin: Update
 revision to latest master
Thread-Topic: [isar-cip-core][PATCH] swupdate-handler-roundrobin: Update
 revision to latest master
Thread-Index: AQHdB6cstVOlP/8TbEaxdJZgLjd9drZVXPIAgAARoxA=
Date: Mon, 29 Jun 2026 12:03:42 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB110756C7AE76A510DFB14FC4EC7E82@TY3PR01MB11075.jpnprd01.prod.outlook.com>
References: <20260629085730.416650-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <4c1fd724-0093-4b33-80f7-a4acb7e65506@siemens.com>
In-Reply-To: <4c1fd724-0093-4b33-80f7-a4acb7e65506@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|TY3PR01MB10385:EE_
x-ms-office365-filtering-correlation-id: e423d3e4-782a-4c7b-05a5-08ded5d676c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10070799003|38070700021|3023799007|22082099003|18002099003|11063799006|4143699003|56012099006|6133799003;
x-microsoft-antispam-message-info: 
 rW4x4HowtP3ncBtuZTIOIr0vyTLV63Kn0lWBPQXCmLO57+d4mylXIPhtMYG4hjPgP9ixPM5lJC/Z6hYtC+jxHSEyix20u+wEZ67+T9qQI81tVkafkcpqhQPCpU2JELM+ok/fuIwBdBz3r8L3AV2OTTXp3r0esAp9t4KDBj52GDkiNlgmNi5e6+smGH4x5GEOuGEDn23v5AY04jX7BcnZdhmGJcUlCyHbZ34TclzRkvNX9lg/vz3CP7fPcv02uQCrd9c/VIeuelx2hojm2nbzeYWFfIrC0xqoWdEVer6gHsTVML3s4MAP4uqywmiaXP8XRNf8nt9oHfPCDNLZk25np5+Tkn4qU2CzUpEYGWJRsn8ZGwxRXYaQazaGJ+1slPhZC3DDrKFxSpQNY0CksGCWOqMR0fSePdaqff5T3toKF13SmGPvgoSEFvPn//NYutn4bF6mXPJlOfrxibD5nfCuiTaws85KlhoW1l5TYqxW6JBXhEEbYwMnnC04stdsbviWfjW5gRh61/rVd+aoq40qAMqv/9F+JPO52+8r/lGwvvHc9h9aaWKttBjlThjhOnBCT3bjD0AxdJmyKqJN/vYTiLzkTX18ewB5Aq44Gb1GnM5QHylWYShSIn5OqjiIOPVJSM49j9owUQoi4DIVSchzZ4AoR+Vpfd0or6VQXdcmqirU9inBH7amuLyZ/MBj9iaSvAA6H0dQuUKJI5Vxf5R8NpdRb6jTwp0kAtyEYaOADak=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10070799003)(38070700021)(3023799007)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?T2NkWi9yNkZXRFhxUDlQT2RXQXp1cG5CQ1ZCcjQ5R3pUbkRtaktvaHoveVN0?=
 =?utf-8?B?RmNsMkdpUFFsU1RSTVMvb0tERWEvdXFIaVFIelhKcmt3anZZc2VJc0JyNVIw?=
 =?utf-8?B?VkVmc2NxcHNCbDVEcUZucVBuMlJPbElEUk9IRkxOZE53Y09QYnJJYTVnR25S?=
 =?utf-8?B?bjNIbXVaSFkzTHlUU2ZCeUNBYStzcktrVEM3Q2JMSmRzUVRoVHlQMDhxTW4y?=
 =?utf-8?B?Uk4zbjJzOHdNcUV3Zm51K3dpY0lDejdJZmRIem5FWEpySmZxR0daVlRJTTJV?=
 =?utf-8?B?WGh1Qk42T2l0UmpuRFVTcFVsMlR2c2w4TUpjUjhLblFhK05ZMDE3UWc5VUhF?=
 =?utf-8?B?NFE2Uy9EK2taK0xZaWk3M2FxcXZnT0ZPTHFENkZjRFNLUHlxazhSTGQ5TDJC?=
 =?utf-8?B?QVZkSVJxVFNsTWJwYTFrOXJyQUxsQ3hpVjhzVndXcFIwS2ZWd1ZUT2NZZmRH?=
 =?utf-8?B?RWpQdy9HSUVDZW1XNFJOZlhmOU9ZS2d6dytDeHFaenVHR05uS0JyN0JsNVor?=
 =?utf-8?B?SHByZkU0L21CTGg1cGdFUFk3Vy9DOEFLdnlpTmZyT08waW9xVDVDRU5FZ1FZ?=
 =?utf-8?B?QmNKN3k0NktCVmxzRGtVWHJOQ1V1bDZGNjU4VGZRdldQTnB6clp4UHNpN3k2?=
 =?utf-8?B?ck9MbndldkVScURxaDh6RytBRjNsTlF6VVNDd2F3dmZxdG02cjNkenVaRlVh?=
 =?utf-8?B?YlJzbWY0UGl5OHkyem1Ca3ROVC9LbS9xRHhISXI4WDlobkdxRmNxc2lETFNj?=
 =?utf-8?B?aGRaL0tOaG0yd1BQSzVLaWlTaTNKdk5YbXc4WU1NOXFEd2xxRS9aeTlaaHdW?=
 =?utf-8?B?YVNqKzI1eE5tblpJbzk5V2N4R3Jubkl5SzhpaVVGMWZCY1hyY0pRemlMUFZn?=
 =?utf-8?B?dlE4c0hZdWlqY3hJcGJhWGlpWlVFeGwyV2ZjSGkzMWVsZVFtQjE2NEhSM1Av?=
 =?utf-8?B?R3hmcms3bU5RK1R4bFdRSzhqNXZtajdPZTVQTHZwUXhWNHZiU3pubGhPaE1E?=
 =?utf-8?B?Z2Rzc0hxd09hM2ZKc3A4TVljWVlSeHIyZ05qUmpYRnBWMXg4cFk2S1JWcXcw?=
 =?utf-8?B?ZVJGRHp4YXJNL2MrdVZRUmVhajQ1eTZ6VmgzMDNoTTZMd1N1bUdTZndqeUNL?=
 =?utf-8?B?VzRWQXFwRERKQ1lqeVZEUjVnajRRTlJIY1dOT2RaWDNjb3V6SWNIc1pGTU5U?=
 =?utf-8?B?NGxQWG1nbXEvYlBoVU5MY040M09yOWdXNHMyS1N4dHNHZFNFVmNZVVVYK1Jk?=
 =?utf-8?B?dWpFMjhLOFR5cWZmcVNZMytETklPZXY4Q3NqbjdTd3NxZXNKTDh1RHFZTzBH?=
 =?utf-8?B?Yk1HQjRnalpGTm9qeWpURTNGMm5EemNnV2JiaUZILzY2cjQ3UUwzTWQyUTF0?=
 =?utf-8?B?Y3V3Z21IVXFzYW5kMjNUR2QyTG45N2NNVU1zZUpNMFpCTEo1MjNWQmlXMC8z?=
 =?utf-8?B?aFdzc1dCM0xCeWp1dHdYK0VVL0RQMnQ3LzYzQlNqK3g2aUNJOUVGUklaYnJu?=
 =?utf-8?B?WEhsOTRpWjZQK2VlbTVDcHNHNDIxbjRuam1Hd2hKU3llNnhUL1JYeTc0ZGhK?=
 =?utf-8?B?dHFTY2Y3K3FRbldkcU9td3JubmluQ3FEWFphek1pR0UvNFdFZzY2M1lTT1RP?=
 =?utf-8?B?TUEyWjEvYlRvS3V5aFFmNEpGdlFEamduNmxpeTZzTUpLQjdjL3BZeWsza0lx?=
 =?utf-8?B?WGtFeVJSRkFXWUhBMFB3NzEySlg0Y3hCcThlcHBmMmdkY0lQdStEejlvc0dS?=
 =?utf-8?B?clhDMTlQZGFNallDaWJ2bFVwb1FscVl3UUtEazc1Q0IzRmhSNHh4ZGdjdVdM?=
 =?utf-8?B?ZG5veW11emI0bkhHd3Z5NUQvYlVMT3pLd21nS0E5TEk5cm4rdEtUampiVU8r?=
 =?utf-8?B?d2FiU0lCQU5ZVk5Uamc5WEpLSkNNbkUzZ0E2bWJMQnhuOUNSZElrY2czelFh?=
 =?utf-8?B?eGoxTzZnVnppd1N2RlpUUm4zRzZIRVY3bWhLZ3hVbVI0dkp2OExLdUJHVUtK?=
 =?utf-8?B?MXpkLzM2SEQxdnhISUlrZ3B1WkNuQUJ4bHpCZWU3L3hudDJjZjlGOUI2cHZm?=
 =?utf-8?B?NGJDY0Z2OEhXN3BTZHB0aE8vb2JZSnFza2JVcVZaYjRCVU9EVHFZYVBvQnpR?=
 =?utf-8?B?ZUYxaWg2aklIdzZnOWZRdDJvMDRFY1pjQVZnODNCTkM4MUdCYXhFOXVmc2tJ?=
 =?utf-8?B?ckFGRXFSQ1ZkUkFKcS82WTdtU2x3a1h4czBzNzB0NDRNZWVZYWZQYlVkUVJz?=
 =?utf-8?B?cUxWMkRrNkQrTTc4eno1TFFZdWNIbER4dmNVbFlKNFMrOXlkTS9PMG5UTUdH?=
 =?utf-8?B?cHlPa24zbXFrRVlaNElVSDR6TUdPWlRmcjJpOFVMSWtMVWhpVWk3eUNRMTEx?=
 =?utf-8?Q?e+Kxql4cdierN7oaZ1A1RpV+AgXQJeVCpG/BFCQHTR/Zq?=
x-ms-exchange-antispam-messagedata-1: 
 TvwXbLkciYtcmy1dofBea/qFFokEao/VkEmppRFefL+w+F1AtcS+DfEK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	nCRmQlhvwOGvvs+vq9eg05MrW84TfbVPaKCFkTWVeV9Qq8qXvD67ku8UugMvPGetnrxHAAk3ODsF0E5XK6BV8uu4VH3rRqXHrAdKqsLs5eWBS7ylgQ6dfnoq/AVdqJaZ3JNKgglcSy2VnMX61JQSecomZfH/bxkXejstHVh5V7uLVxkyj8mgiwOcpMET7dBvhFtF6W17RNrXsZuXyyH4BNeKhIMev7eo66yBIakdWju5rrwwY4llpKNMx2xWdOBATBu58v1oA/wy9ktQ5kIQbzTJesd6hvqndfp/aKiGAdrsbBsYcFibFGJouL7lD1eYTU02L4CVKVswnKLxbYWLkg==
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e423d3e4-782a-4c7b-05a5-08ded5d676c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 12:03:42.5222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VKU5mfwIJYScHfAkyY5aOO3ojepMxYKU91KM7DAnzXJGSJnRchX4XZdWw2czRHb5qrLhhYBYxLVvizmtRjgPB9ApVRzZHDSQ5QDb1NqaR6VeA/Yky2gGVOrj6CJaxxks
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10385
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jun 2026 12:03:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23306

SGkgSmFuLA0KDQo+IFRoYW5rcywgSSdsbCBtZXJnZWQgdGhpcyBhZnRlciB0aGUgdXBjb21pbmcg
cmVsZWFzZSwganVzdCB0byBiZSBzYWZlLg0KPiBQaW5nIG1lIGlmIEkgc2hvdWxkIGZvcmdldCBh
Ym91dCBpdC4uLg0KDQpTdXJlLCB0aGFua3MuIA0KSSdsbCBzZW5kIHRoZSByZW1pbmRlciBvbmNl
IHlvdSBtYWtlIHRoZSByZWxlYXNlLg0KDQpUaGFua3MgJiBSZWdhcmRzDQpTaGl2YW5hbmQgSw0K
DQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogSmFuIEtpc3prYSA8amFuLmtpc3pr
YUBzaWVtZW5zLmNvbT4gDQpTZW50OiAyOSBKdW5lIDIwMjYgMTY6MjgNClRvOiBrdW5pamFkYXIg
c2hpdmFuYW5kKO+8tO+8s++8qe+8sCBESVRDX0RJVC1PU1QpIDxTaGl2YW5hbmQuS3VuaWphZGFy
QHRvc2hpYmEtdHNpcC5jb20+OyBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KQ2M6IGJh
bGFrdW1hciBhZGl0aHlhKO+8tO+8s++8qe+8sCDvvKTvvKnvvLTvvKPvvL/vvKTvvKnvvLQt77yv
77yz77y0KSA8QWRpdGh5YS5CYWxha3VtYXJAdG9zaGliYS10c2lwLmNvbT47IGRpbmVzaCBrdW1h
cijvvLTvvLPvvKnvvLAgRElUQ19ESVQtT1NUKSA8ZGluZXNoLmt1bWFyQHRvc2hpYmEtdHNpcC5j
b20+OyBoYXlhc2hpIGthenVoaXJvKOaelyDlkozlro8g4pah77yk77yp77y077yj4peL77yj77yw
77y0KSA8a2F6dWhpcm8uaGF5YXNoaS5mNzRAbWFpbC50b3NoaWJhPg0KU3ViamVjdDogUmU6IFtp
c2FyLWNpcC1jb3JlXVtQQVRDSF0gc3d1cGRhdGUtaGFuZGxlci1yb3VuZHJvYmluOiBVcGRhdGUg
cmV2aXNpb24gdG8gbGF0ZXN0IG1hc3Rlcg0KDQpPbiAyOS4wNi4yNiAxMDo1NywgU2hpdmFuYW5k
IEt1bmlqYWRhciB3cm90ZToNCj4gVGhlIHJvdW5kIHJvYmluIGhhbmRsZXIgaXMgdXBkYXRlZCB0
byBzdXBwb3J0IERlYmlhbiBzaWQgYnkgbWFraW5nIA0KPiBtaW5vciBjaGFuZ2VzIHJlcXVpcmVk
IGZvciBMdWEgNS41IHZlcnNpb24uDQo+IA0KPiBDbG9zZXMgIzE2MA0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogU2hpdmFuYW5kIEt1bmlqYWRhciANCj4gPFNoaXZhbmFuZC5LdW5pamFkYXJAdG9zaGli
YS10c2lwLmNvbT4NCj4gLS0tDQo+ICAuLi4vc3d1cGRhdGUtaGFuZGxlci1yb3VuZHJvYmluXzAu
MS5iYiAgICAgICAgICAgICAgICAgICAgICAgICB8IDMgKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IA0KPiBhL3Jl
Y2lwZXMtY29yZS9zd3VwZGF0ZS1oYW5kbGVyLXJvdW5kcm9iaW4vc3d1cGRhdGUtaGFuZGxlci1y
b3VuZHJvYmluDQo+IF8wLjEuYmIgDQo+IGIvcmVjaXBlcy1jb3JlL3N3dXBkYXRlLWhhbmRsZXIt
cm91bmRyb2Jpbi9zd3VwZGF0ZS1oYW5kbGVyLXJvdW5kcm9iaW4NCj4gXzAuMS5iYg0KPiBpbmRl
eCAyYmExOTJjLi45ZDlmNmQ3IDEwMDY0NA0KPiAtLS0gDQo+IGEvcmVjaXBlcy1jb3JlL3N3dXBk
YXRlLWhhbmRsZXItcm91bmRyb2Jpbi9zd3VwZGF0ZS1oYW5kbGVyLXJvdW5kcm9iaW4NCj4gXzAu
MS5iYg0KPiArKysgYi9yZWNpcGVzLWNvcmUvc3d1cGRhdGUtaGFuZGxlci1yb3VuZHJvYmluL3N3
dXBkYXRlLWhhbmRsZXItcm91bmRyDQo+ICsrKyBvYmluXzAuMS5iYg0KPiBAQCAtMTUsOCArMTUs
NyBAQCBNQUlOVEFJTkVSID0gImNpcC1kZXYgPGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3Jn
PiINCj4gIFBST1ZJREVTID0gInN3dXBkYXRlLWhhbmRsZXJzIg0KPiAgDQo+ICBTUkNfVVJJICs9
ICJnaXQ6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC1zdy11cGRhdGVzL3N3dXBkYXRlLWhh
bmRsZXItcm91bmRyb2Jpbi5naXQ7cHJvdG9jb2w9aHR0cHM7ZGVzdHN1ZmZpeD1zd3VwZGF0ZS1o
YW5kbGVyLXJvdW5kcm9iaW47bmFtZT1zd3VwZGF0ZS1oYW5kbGVyLXJvdW5kcm9iaW47bm9icmFu
Y2g9MSINCj4gLVNSQ1JFVl9zd3VwZGF0ZS1oYW5kbGVyLXJvdW5kcm9iaW4gPz0gIjVkZWI3NWRm
NTQ2OWM1YTY2Y2RkNzI3ZWI3MmFmODNjZTA3ODQwNTQiDQo+IC0NCj4gK1NSQ1JFVl9zd3VwZGF0
ZS1oYW5kbGVyLXJvdW5kcm9iaW4gPz0gIjEwNWJhMTRkY2E2ZmJmMTY4MjkyYTExODJlOGMxZTE4
YTcyOGJjZDQiDQo+ICBTV1VQREFURV9MVUFTQ1JJUFQgPSAic3d1cGRhdGUtaGFuZGxlci1yb3Vu
ZHJvYmluL3N3dXBkYXRlX2hhbmRsZXJzX3JvdW5kcm9iaW4ubHVhIg0KPiAgDQo+ICBTV1VQREFU
RV9CT09UTE9BREVSID8/PSAiZWZpYm9vdGd1YXJkIg0KDQpUaGFua3MsIEknbGwgbWVyZ2VkIHRo
aXMgYWZ0ZXIgdGhlIHVwY29taW5nIHJlbGVhc2UsIGp1c3QgdG8gYmUgc2FmZS4NClBpbmcgbWUg
aWYgSSBzaG91bGQgZm9yZ2V0IGFib3V0IGl0Li4uDQoNCkphbg0KDQotLQ0KU2llbWVucyBBRywg
Rm91bmRhdGlvbmFsIFRlY2hub2xvZ2llcw0KTGludXggRXhwZXJ0IENlbnRlcg0K


