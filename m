Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1C0ECAAA1
	for <webhook@archiver.kernel.org>; Mon, 12 Sep 2022 05:41:07 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web11.4325.1662961259953224170
 for <cip-dev@lists.cip-project.org>;
 Sun, 11 Sep 2022 22:41:00 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.155,
 mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 28C5evx3006612;
 Mon, 12 Sep 2022 14:40:57 +0900
X-Iguazu-Qid: 34tMQIIQxmb4soEW4a
X-Iguazu-QSIG: v=2; s=0; t=1662961256; q=34tMQIIQxmb4soEW4a;
 m=KCSbGiQkMr2cceDRnOluBpXQtx/U/D6l+DPEqtfurHs=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1511) id 28C5etsY009231
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 12 Sep 2022 14:40:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJqdm6u7PuG3nwFpUSG1QHC2ex/aVi9TwRFw+mGp+lOkzFB6B4cq9Kw2TZQJO3U5ojARG+K8k0moR6E8TEl2St0EjBv4iQCZqmHYsJfUHFORAH4JmY0xh6EdUB4eIR2Mfo+q9pDnSp5/skfg/OSxhjr3eCvouL9vt4YuJXKZ9QPMLHZnMXqYauZqiFVjTemkhX69sA33k0fwGK6j5Dd8o/v4vcha8idZaQgtdEUVyVVqFcGr6TW7kZJ6dyY58tTTvPlWphYcM3oNAyUGAzMqymB4NZIO4tRRhDDFW66HBvtnm7efoCkut0noI09LQHAgttesbzUHmCn/npsLauGmHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AWGuXwaewo2ilo0QSpn5a1O+lPtcyejHOmEp1Onsc0=;
 b=TYDThlvM28bd75bsJM89arh+mw5+uJBTSdgJa76zgMElJMO3y74C3kjWk+t4KTcFFGjTlCLAMGBPpGuElxwA1D9wjnOVSiTDxCiR203OE0uFNSG1s6qMxSxG969h40XapQaYwdqPNsUlb2/a3pBWFhKaX8wqTn82okZ597Z/Bx3hv2uish2qTTN3RKZ4Qz9P2LNHblvaYzPC381JEraY8kJM26q0nHwS68frZu6yLxz/veeaNrL0S2cMDqQxUbwx6/HEuGK8PiokYIh+aeARIaOjzRHuMnQE0s5DzCIDQlnpFkpmFiTWw8I9zKXkUGA6S70gLTRhHzO/o3iIGV/JKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-dev] [isar-cip-core] README.swupdate.md: Add steps to verify
 SWUpdate on BBB
Thread-Topic: [cip-dev] [isar-cip-core] README.swupdate.md: Add steps to
 verify SWUpdate on BBB
Thread-Index: AQHYxFDTIKg1DzWo70mJgFaLKjhef63XXfgAgAPtLNA=
Date: Mon, 12 Sep 2022 05:40:52 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYAPR01MB615442B769A2DE090F3AEB71C7449@TYAPR01MB6154.jpnprd01.prod.outlook.com>
References: <20220909132535.3671-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <d98e57e9-2219-6e09-582c-b465e9295193@siemens.com>
In-Reply-To: <d98e57e9-2219-6e09-582c-b465e9295193@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6154:EE_|TYAPR01MB5705:EE_
x-ms-office365-filtering-correlation-id: b3a04f50-5bdf-4659-8ab6-08da94815b57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 h8YzuoN3YsCUge77ijxixz2VMC0XhiUCICz4t7Ey9TZvhW81l7jYU/3Xw6MJ0fdO6lzP8YLCg5uTiSa6lS7/8tVpaThMw+k5i79pqKjNSp6xqxeonN9EBrNy1Bf2N7LR9y6sWU7u7umGjRQtIRS8Ir63MaA7sSJNRiVnkogCraGjSyuECQNyQR5GSJ/QLUqnLUq6icOWemnGh9NDcSCETXwkiuSCdZ4DOq55zhB5UOszAzCjH3X6k4mgc9J41BVw5WYZGa3oPHzYITgCS8LUGV/tHpmfBqTD+hE+ksDwQyHk0nt8L+B7vztB871bjnHusvGWxYmqQcODZKLzNK+py7HoGyodMgM2KQbg2R1rJ1ZIymA+6uOGv6+06obMrg8b3pRfE8TWEqqWcrv4IJMFAxkjk7J+f/z+Q94KEdrmC74lBOhDC2nIDTXmXEgfDyQ62j1gGBOmxlDcvmXIHd/9YptRHfaTFNM79qKnk68b5SS0rNAIA/aVKTy21hQarPp8nxqb4durhVTn/cD9R8kFGpi8TTlqKOw2hUZFcY3VXpptrXf+4AkuKpejRAFgmy8d1gp8Y1KqwY2FwZD5rU6z+lZ14RqC3TQgd1O3IDEsbKjfrx+puYlX/AWTn/qaNzf4dOKvFfXZWrbunYwk6KnRYAveOVvQ2+61kmLQH2vp7SgKZEdgyfJd71UfprkM+ibGxVTg6NqMA/vdoMmS3vVl/3/2xPlAHCUCPvjsBuTrL/zGm8WM/40PAZXMJYTVpEpi/t1Odw/bro/VR2TX1kZ8zn4RDqLSXfAWwWmarm74bA4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6154.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(86362001)(76116006)(66476007)(38100700002)(66556008)(38070700005)(64756008)(122000001)(5660300002)(15650500001)(66446008)(4326008)(8676002)(8936002)(66946007)(52536014)(2906002)(6506007)(26005)(53546011)(107886003)(9686003)(7696005)(71200400001)(55016003)(41300700001)(478600001)(316002)(186003)(54906003)(83380400001)(110136005)(33656002)(47845001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TU5uaCtOQmxDNE1tU05NbDlIYmFEaTlZOHduRGxFLyswRDl2Y0h2Qzd3dGYr?=
 =?utf-8?B?cVRIeVh4c1BmQk42MUNLQzExQlJBdnVnVmhIcFRPYW5lMktXdGZnU0owWWZ1?=
 =?utf-8?B?cXRVRjBuVlRkUHk5T3BQaHQwdllzRkttNGozdXBraHgwMmRnbkpvOUFjRTVW?=
 =?utf-8?B?VEd4bFZsTjlidHMwY2trQmZ0Z3pBSTJxbFo2SmFESHFvRm0wWitpZUhON3F3?=
 =?utf-8?B?bGF2RDlodUN4dnlnck4xTGdROHQvOG5pbzI2U2Q1TFVoTEZIbWpROXFQSlI4?=
 =?utf-8?B?YWlvUXl1aitCODQ5QXdBcWZXc0d6d3JHR3JvUXQ1SGN0SHZGbFpKTHpIcjVT?=
 =?utf-8?B?TlpMUnNUQ0RFcUpMR0Z1aVZVRkZBV21PTktDU2tjU09sWnVNNSt3U0liS2Zz?=
 =?utf-8?B?aTF0bk8rRHVZdnB6SmhNMGlXTG9xSmJCczhjN1lxTUNkVXdwcXVpUXN1bXky?=
 =?utf-8?B?eEExcGkzcGpYdk5tbDBCc0srZlBvWjBtK1NXV2pjVTNmQXRvY2U2VVVVdFZJ?=
 =?utf-8?B?K1kvdFArR3V2V1FKUWQrMjdaOGg4T3hLS2N0NEIwRCtzMXpKNzM1WnYyaDYr?=
 =?utf-8?B?OUd3RmtjSWc0a0NMclM5TTF5bW5vbnRGSVFaUDhUODgySk9BMVJOdHAvckpn?=
 =?utf-8?B?TStpTXA1VzdJeHp1a0ljbDVBNko3MWQ3elVjZWl0TENHa2MzeThpZnVvWE5W?=
 =?utf-8?B?TmhBS1g0bnNPWmM2cUtLNllSZ0pLMDJ0Z0ZGK0I0dW0xdUJkUTM1aC83OUlP?=
 =?utf-8?B?RjlCTTliMUp4SVBNOUQrNjdHM3IwZ1FQdllTc2trbkM0clJpcEFiWGtaT2xJ?=
 =?utf-8?B?VVBkZlBKOGRDald3aXhBZXdjekgybjhJaHcxWUxkeEhvaG4zMUxIcE4rQlVp?=
 =?utf-8?B?OTNnaWx5SW52cU9UNDlENUtZNkRwTmhpNDVDdHNEYTZ2YXhwaE42S3lkKy9v?=
 =?utf-8?B?emtHOWg2ZElaNjRteUg1UzFqNjVjeUxxV042YU9jMG5qaGswSktIcVhiNXRC?=
 =?utf-8?B?L2ZIT0dJZmZJNHJHSXI0V1ZxNDRpeW0wVzN2M3lNWUJWK1NpUHFDQnVFYXg1?=
 =?utf-8?B?TDdmL09sRkxoa0I0NksvK09vNXhEYjVhOFFJclQ5S3lyNXdKTktyMmxtd0NW?=
 =?utf-8?B?UWNKQ0hkaEo5WjRFTUpTUkVwNXB4cUFQWC9teHJyNWJ6dVQ3QXVuTzlLK1JO?=
 =?utf-8?B?SVkvZVNSS2FILzR4Z3JTSGYzb0RUeEk0aDl0TE03bThCZk1rRkR5QjZCRHE0?=
 =?utf-8?B?MFFCYlp1WVYzb2ovc2JNVDZJYmw5eitZUVV3SkJFTEZhT2M2RHVXWlhycVdo?=
 =?utf-8?B?UkR5NHVNTGZyM3VUOGZBYjhGVWRISGk4YkxlZzZrUDRTMHAydTRYaHBOeHNy?=
 =?utf-8?B?eVBwc1RidytLWE5xQkpRUTJESVE2NXVqNEdjNmRENGNGdnRHbnEyQzdBeDV0?=
 =?utf-8?B?T3N0OW5kR3poeCswR1dUTWQzTytUa2Z1Tmw0azc0VXEyeWM2YlJrNHF1Mml0?=
 =?utf-8?B?SVkvRFo4UThPYVRuRUJuRG5sQTlNN2VsOS9kaW16ZXFrY2l0a2R0Y1pneml3?=
 =?utf-8?B?THk4TmlKV0FTOVgvcFpMR0NPM05BbEg0UVBYN2l4aC9jOGwyZWs2THVSQlZS?=
 =?utf-8?B?OWlxTnRlTURVWnhVYk41Uzk0eXRVbms1aVZQSjkyNllWZkZxRmtraEFURGhY?=
 =?utf-8?B?aHhkUi9oZjZPNklQcEhqdktpdnJkeFV0SEk3dFJnc0VPWm45TnZqRlpJdXla?=
 =?utf-8?B?RjkzRVZrOTA3L2FxdkN3bzJIeDV4QzczeVpLUnpPSDRoN0M5SDQ3TjM5dG54?=
 =?utf-8?B?aE9XNlhYMk55UndGNndma2NjTUc2ejNBdjBaL1dyenZhWXhsV0NHUE5zWlRq?=
 =?utf-8?B?aXdGRXRGRkE3TFdBL2JRRnFrQ0Y2b0tEMUVsSkY2MTAwVnVXOUNYZHVvRkJv?=
 =?utf-8?B?WW5qNUZISFRzdWJVb01lcHhYSWV3K05zVlFHUUpHZzlxSWtMdTIzbUF4ZXRH?=
 =?utf-8?B?UTBld0gzL0piNmlQUGV4ZnJsZlR5bUVqaWQ3cG1ReGlwWFpkT1QyWnJVL3hh?=
 =?utf-8?B?SDhzMjcyZWwwU2w5dTkzUzNxMW9vbUlxTXpPYkZFS25wZmd4UkQyclBZVVZo?=
 =?utf-8?B?Rm1tb21ON2V2U0xkaXdnMWhGaHNMQ0NaZTdjWGZZeGZHUGpFSXFPYXBiTEpU?=
 =?utf-8?Q?c0MxtzPxUZuqxG74Eke9Bec=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6154.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 b3a04f50-5bdf-4659-8ab6-08da94815b57
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 05:40:53.0346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 Q8a1Dl1RkmQ8gP/ucbjbGYN4fh0PbEIo/g3NsO0kk0Va4DM5RLzWeubnnlhl6rRywBL/UJ1zAn75u1Pu4bTgJGnIlPn/RPaxIbItWeHYK5oSQnt+w8g8m2AC+nbeTYQz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5705
X-OriginatorOrg: toshiba-tsip.com
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 Sep 2022 05:41:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9487

SGVsbG8gSmFuLCANCg0KVGhhbmsgeW91IGZvciB0aGUgc3VnZ2VzdGlvbi4gSSB0aGluayB0aGUg
YXBwcm9hY2ggeW91IG1lbnRpb25lZCBpcyBtb3JlIGRldmVsb3BlciBmcmllbmRseSBjb21wYXJl
ZCB0byBtaW5lLiANCmhvd2V2ZXIsIEkgd291bGQgbGlrZSBrZWVwIGJvdGgsIGxldCB1c2VyIHNl
bGVjdCB0aGUgcHJlZmVyYWJsZSBvcHRpb24uIElzIGl0IG9rPw0KDQpUaGFua3MgJiBSZWdhcmRz
DQpTaGl2YW5hbmQgSw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogY2lwLWRl
dkBsaXN0cy5jaXAtcHJvamVjdC5vcmcgPGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPiBP
biBCZWhhbGYgT2YgSmFuIEtpc3prYQ0KU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgOSwgMjAyMiAx
MToxMSBQTQ0KVG86IGt1bmlqYWRhciBzaGl2YW5hbmQo77y077yz77yp77ywIFRNSUVDIE9ERyBQ
b3J0aW5nKSA8U2hpdmFuYW5kLkt1bmlqYWRhckB0b3NoaWJhLXRzaXAuY29tPjsgY2lwLWRldkBs
aXN0cy5jaXAtcHJvamVjdC5vcmcNCkNjOiBkaW5lc2gga3VtYXIo77y077yz77yp77ywIFRNSUVD
IE9ERyBQb3J0aW5nKSA8ZGluZXNoLmt1bWFyQHRvc2hpYmEtdHNpcC5jb20+OyBoYXlhc2hpIGth
enVoaXJvKOaelyDlkozlro8g4pah77yz77y377yj4pev77yh77yj77y0KSA8a2F6dWhpcm8zLmhh
eWFzaGlAdG9zaGliYS5jby5qcD4NClN1YmplY3Q6IFJlOiBbY2lwLWRldl0gW2lzYXItY2lwLWNv
cmVdIFJFQURNRS5zd3VwZGF0ZS5tZDogQWRkIHN0ZXBzIHRvIHZlcmlmeSBTV1VwZGF0ZSBvbiBC
QkINCg0KT24gMDkuMDkuMjIgMTU6MjUsIFNoaXZhbmFuZC5LdW5pamFkYXJAdG9zaGliYS10c2lw
LmNvbSB3cm90ZToNCj4gRnJvbTogU2hpdmFuYW5kIEt1bmlqYWRhciA8U2hpdmFuYW5kLkt1bmlq
YWRhckB0b3NoaWJhLXRzaXAuY29tPg0KPiANCj4gTW9zdCBvZiB0aGUgc3RlcHMgYXJlIHNpbWls
YXIgZm9yIGJvdGggcWVtdS1hbWQ2NCBhbmQgQkJCIHRhcmdldHMuDQo+IEFkZCByZWZlcmVuY2Ug
bGluayB3aGVyZXZlciByZXF1aXJlZCBpbnN0ZWFkIG9mIHJlcGVhdGluZyBzdGVwcy4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IFNoaXZhbmFuZCBLdW5pamFkYXIgDQo+IDxTaGl2YW5hbmQuS3VuaWph
ZGFyQHRvc2hpYmEtdHNpcC5jb20+DQo+IC0tLQ0KPiAgZG9jL1JFQURNRS5zd3VwZGF0ZS5tZCB8
IDUyIA0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDEg
ZmlsZSBjaGFuZ2VkLCA1MiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZG9jL1JF
QURNRS5zd3VwZGF0ZS5tZCBiL2RvYy9SRUFETUUuc3d1cGRhdGUubWQgaW5kZXggDQo+IDFiMjQy
YTIuLjcyNjkwZDYgMTAwNjQ0DQo+IC0tLSBhL2RvYy9SRUFETUUuc3d1cGRhdGUubWQNCj4gKysr
IGIvZG9jL1JFQURNRS5zd3VwZGF0ZS5tZA0KPiBAQCAtMzIsNiArMzIsOCBAQCBDb3B5IA0KPiBg
Y2lwLWNvcmUtaW1hZ2UtY2lwLWNvcmUtYnVsbHNleWUtcWVtdS1hbWQ2NC5zd3VgIGZpbGUgZnJv
bSBgdG1wYCBmb2xkZXIgaW4gIGhvc3QkIHNjcCAtUCAyMjIyMiAvdG1wL2NpcC1jb3JlLWltYWdl
LWNpcC1jb3JlLWJ1bGxzZXllLXFlbXUtYW1kNjQuc3d1IHJvb3RAbG9jYWxob3N0Og0KPiAgYGBg
DQo+ICANCj4gKyMjIFNXVXBkYXRlIHZlcmlmaWNhdGlvbg0KPiArDQo+ICBDaGVjayB3aGljaCBw
YXJ0aXRpb24gaXMgYm9vdGVkLCBlLmcuIHdpdGggbHNibGs6DQo+ICBgYGANCj4gIHJvb3RAZGVt
bzp+IyBsc2Jsaw0KPiBAQCAtMjE1LDMgKzIxNyw1MyBAQCB1c2VyIHZhcmlhYmxlczoNCj4gIA0K
PiAgDQo+ICBgYGANCj4gKw0KPiArIyBCdWlsZGluZyBhbmQgdGVzdGluZyB0aGUgQ0lQIENvcmUg
aW1hZ2UgZm9yIEJCQg0KPiArDQo+ICtGb2xsb3cgdGhlIHN0ZXBzIG1lbnRpb25lZCBpbiB0aGUg
c2VjdGlvbiBbQnVpbGRpbmcgYW5kIHRlc3RpbmcgdGhlIENJUCBDb3JlIGltYWdlXShSRUFETUUu
c3d1cGRhdGUubWQjYnVpbGRpbmctYW5kLXRlc3RpbmctdGhlLWNpcC1jb3JlLWltYWdlKSBmb3Ig
Y3JlYXRpbmcgaW1hZ2VzIGFuZCAuc3d1IGZpbGVzLg0KPiArLSBSZXBsYWNlIHFlbXUtYW1kNjQu
eW1sIGthcyBmaWxlIHdpdGggQkJCIGJvYXJkIHNwZWNpZmljIGZpbGUgaS5lIA0KPiArYmJiLnlt
bA0KPiArLSAuc3d1IGZpbGUgd2lsbCBiZSBnZW5lcmF0ZWQgaW4gdGhlIGZvbGxvd2luZyBmb2xk
ZXIgDQo+ICtidWlsZC90bXAvZGVwbG95L2ltYWdlcy9iYmIvDQo+ICsNCj4gK0ZsYXNoIHRoZSBC
ZWFnbGVCb25lIEJsYWNrIGltYWdlIGludG8gU0RjYXJkIGBgYCBob3N0JCBkZCANCj4gK2lmPWJ1
aWxkL3RtcC9kZXBsb3kvaW1hZ2VzL2JiYi9jaXAtY29yZS1pbWFnZS1jaXAtY29yZS1idWxsc2V5
ZS1iYmIud2ljIFwNCj4gKyAgIG9mPS9kZXYvPG1lZGl1bS1kZXZpY2U+IGJzPTFNIHN0YXR1cz1w
cm9ncmVzcyBgYGANCj4gKw0KPiArUHJlcGFyZSB0aGUgaGFyZHdhcmUgY29ubmVjdGlvbnMNCj4g
Kw0KPiArLSBDb25uZWN0IGEgc2VyaWFsIHBvcnQgY2FibGUgYmV0d2VlbiBob3N0IFBDIGFuZCBC
QkINCj4gKy0gQ29ubmVjdCBhbiBFdGhlcm5ldCBjYWJsZSBiZXR3ZWVuIGhvc3QgUEMgYW5kIEJC
Qg0KPiArDQo+ICtJbnNlcnQgU0QgY2FyZCB0byBCQkIsIGhvbGQgUzIgYnV0dG9uIHdoaWxlIGFw
cGx5aW5nIHBvd2VyIHN1cHB5IHRvIEJCQi4NCg0KdHlwbzogc3VwcGx5DQoNCj4gK09uY2UgdGhl
IHN5c3RlbSBpcyB1cCwgZXhlY3V0ZSBiZWxvdyBjb21tYW5kIHRvIGNvbmZpZ3VyZSBzdGF0aWMg
SVAgDQo+ICthZGRyZXNzIHRvIEJCQg0KPiArDQo+ICtgYGANCj4gK3Jvb3RAZGVtbzp+IyBjYXQg
PDxFT0YgPj4gL2V0Yy9uZXR3b3JrL2ludGVyZmFjZXMgYXV0byBldGgwIGlmYWNlIA0KPiArZXRo
MCBpbmV0IHN0YXRpYw0KPiArICBhZGRyZXNzIDE5Mi4xNjguMi4yDQo+ICsgIG5ldG1hc2sgMjU1
LjI1NS4yNTUuMA0KPiArICBuZXR3b3JrIDE5Mi4xNjguMi4wDQo+ICsgIGJyb2FkY2FzdCAxOTIu
MTY4LjIuMjU1DQo+ICtFT0YNCj4gK3Jvb3RAZGVtbzp+IyAvZXRjL2luaXQuZC9uZXR3b3JraW5n
IHJlc3RhcnQgYGBgDQo+ICsNCj4gK0luIGhvc3QgUEMsIGNvbmZpZ3VyZSBiZWxvdyBzZXR0aW5n
cyBmb3IgRXRoZXJuZXQgSVB2NC4NCj4gKw0KPiArLSBJUCBhZGRyZXNzOiAxOTIuMTY4LjIuMQ0K
PiArLSBTdWJuZXQgbWFzazogMjU1LjI1NS4yNTUuMA0KPiArDQo+ICtFeGVjdXRlIGJlbG93IGNv
bW1hbmQgdG8gY29uZmlybSAxOTIuMTY4LjIuMSBpcyBhY2Nlc3NpYmxlIGZyb20gQkJCLg0KPiAr
YGBgDQo+ICtyb290QGRlbW86fiMgcGluZyAxOTIuMTY4LjIuMQ0KPiArYGBgDQo+ICsNCj4gK0Nv
cHkgLnN3dSBmaWxlIGZyb20gYHRtcGAgZm9sZGVyIHRvIEJCQiBmcm9tIGhvc3QgUEMgdXNpbmcg
YmVsb3cgY29tbWFuZC4NCj4gKw0KPiArYGBgDQo+ICtob3N0JCBzY3AgdG1wL2NpcC1jb3JlLWlt
YWdlLWNpcC1jb3JlLWJ1bGxzZXllLWJiYi5zd3UgDQo+ICtyb290QDE5Mi4xNjguMi4yOi9yb290
LyBgYGANCj4gKw0KPiArRm9yIHZlcmlmeWluZyBzd3VwZGF0ZSBvbiBCQkIgdXNlIHRoZSBzYW1l
IHN0ZXBzIGFzIG1lbnRpb25lZCBpbiBhYm92ZSBbU1dVcGRhdGUgVmVyaWZpY2F0aW9uXShSRUFE
TUUuc3d1cGRhdGUubWQjc3d1cGRhdGUtdmVyaWZpY2F0aW9uKS4NCg0KSG93IEkgdGVzdGVkIChp
biB0aGUgYWJzZW5jZSBvZiBhIHRlc3QgbmV0d29yayBhdCB0aGF0IHRpbWUpOg0KLSBtb3VudCB0
aGUgZmxhc2hlZCBTRC1jYXJkIG9uIHRoZSBob3N0DQotIGNwIHRoZSBESUZGRVJFTlQgc3d1IGlu
dG8gPG1udD4vcm9vdC8NCi0gYm9vdCB0aGUgdGFyZ2V0IGFuZCBydW4gc3d1cGRhdGUgLWkgL3Jv
b3QvPGltYWdlPi5zd3UNCg0KSSB0aGluayB0aGF0IGlzIHNpbXBsZXIgaWYgdGhlcmUgaXMgbm8g
Y29tbW9uIG5ldHdvcmsgd2l0aCBkaGNwIGluIHJlYWNoLg0KDQpKYW4NCg0KLS0NClNpZW1lbnMg
QUcsIFRlY2hub2xvZ3kNCkNvbXBldGVuY2UgQ2VudGVyIEVtYmVkZGVkIExpbnV4DQo=


