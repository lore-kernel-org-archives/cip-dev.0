Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDC2C4829E
	for <webhook@archiver.kernel.org>; Thu, 15 Feb 2024 13:00:57 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.13073.1708002053454333083
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Feb 2024 05:00:54 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 41FD0oPD1967626; Thu, 15 Feb 2024 22:00:51 +0900
X-Iguazu-Qid: 2rWgWcEMv1t6zJaYGf
X-Iguazu-QSIG: v=2; s=0; t=1708002050; q=2rWgWcEMv1t6zJaYGf; m=ac1d0SldNYZcGGwhB6y9pZ1q5aOPz6L7lQesB2BnMuI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 41FD0nMp1174587
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 15 Feb 2024 22:00:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEEfUhMalh1Hqc1EKWGTHi6K9tUFZYuEssZThLVgsAARxsiLBoWcXT837uQeHBtUIrG4dAwZZlVuiaOCDHb3ifXm7m7BB5Joqa7ZUFBbNWFZbnxtbG32cYdJaWNZ3oe0u/20BN5npvzb23nvwN2lsTTXM/pEAc/AW6WAxn9hYtED7iNuJp04fUOD1lfy9/zGIhafr3ZF+42nXLqFyE7MZ51d9epTKEgQ+5OcayeIVB21KIgPup9iCvJTp4TJN9NQ5T23pkgMrZA3hiEMUBrY+5TWm039kwwWSYF7bsDmcgW51rLjdtCwr23jNOgOMzj30dHXIjOfAZ23iE8Dq/WKmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTgWCu2RtejUlDSJ9qomPcm9FrfFv3J2vROCwONNCe8=;
 b=ShpFqrXqSRetcc/g176rz8e5Q2CxGMXqrT4Eit+UjGOhP0bqLNuHp8RytlLoM1hxuHk5p+bYEpwaqQGxQUeGPZLDcP+bLvwwwyn1Lsy+jGYJzGTW9/xOwd3BWruWD7kjcV4tfVUMsJovfmJ/4f/oNhWETfPR9AsIS6rhnTEFPcxooonOQ7xZCvnQlHwsM6D9HbxrK5ohEwGVnK0KvrYGTRcmRirjWPaD3vyc7+RIbaHyzLOjjNWqLf+dEokrQ+w6P9XmFnzRCMLreeeWN+Kud0ErTuNyqY09HsDCS18CSAMQRv/Nm02fQw3MZirSICR1bRzrih/Af3Ck+JjZi/kZ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Index: AQHaX+Atjwpk2gzk6ESWVkQ5orcYT7ELXh6g
Date: Thu, 15 Feb 2024 13:00:47 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388340A2E8A33A46C860213924D2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <35333ced-20d6-415a-b9af-fb363b53ab66@siemens.com>
In-Reply-To: <35333ced-20d6-415a-b9af-fb363b53ab66@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|OS7PR01MB11901:EE_
x-ms-office365-filtering-correlation-id: 1cf25ee1-be34-4f09-f0c3-08dc2e2620e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 OrsubHLDGy5qG5eq9f7xBxZ5ik3+P8VdY6PZPy570iinb7mRSf2OLvOaPqnY8ltH5ocPfbVfO/sRZI7cyHqWKSaXiQkTD6udeo7s1pmTfiuvP4wkghRSuMPASVDEGMcoA8gyU3XpTMbkuQsbUFr34cVQ3hnKEj1LjO7dcpl+zXj2Kz0Twdu6QWNdLj5MLr7SD3O2D9uMa7HNxwMz0Ei94Y9fpwkFOkt5fvyr+FFWW6piMhKbaiZ7zkbxv5IqCJRH5FOndrWCIb6XhVM3kdgLhHsuSdUW4xp6HncIu44L4zK3CCiTvzs3Yk7kgWwjHBOzUFKElTZAPj0wdB4G9NFRr9oG03xdtUCPZTHVcVtGSVT6HiYLYA1tQ3jm4LuXe21zm0XdODhmr/j3sMp0M21vLsqiTlBNJLnma9svj4cRMEtWf1RpB2sBzwcskQDgF5CfjoURzeoNpAl3y2Hd6HIHj+jdRnPARSukSGSqHaZqiTzIpZlsux3/51pGDtHPuA0hGfBuPXDQdV887J8y9LUSGvhACXxp4kBWnBvlOi40SLDelIEoYxUgzEtSZ6emK9J4pgjiSL/sDTilvJgVSo0H/CRADbLTD4Yjh9uq0gsbEyM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(38100700002)(55016003)(122000001)(2906002)(86362001)(52536014)(33656002)(83380400001)(64756008)(5660300002)(66446008)(8676002)(8936002)(66946007)(6916009)(76116006)(66556008)(7696005)(66476007)(71200400001)(6506007)(9686003)(53546011)(966005)(478600001)(316002)(41300700001)(38070700009)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bHZwUzlYSzQ4cUE2eEl1WUVZaWlZbnpSKzI4Z3NDelF6UUZNcXVPRkN4aVRH?=
 =?utf-8?B?QStDVnN6TnFLNGVoc3pJTk9Lc3lRNDlpY2JBTTNJdjRrS0tTa2ZEZHRxOHdw?=
 =?utf-8?B?eUo0a0J6L3VMelV6aytnY1psSEh1RnhtUFVhUENDRlREZEZTK21lcUVqS2VX?=
 =?utf-8?B?a3RhVUVRbTQxWXRnKzBhYlFXTHZZNE1ZdmpDM3hoQmRBUHFQSFlYKzhWdHQr?=
 =?utf-8?B?aEhUT0FQNjlVSGIxMVNjQmpJWnpUZWJpaHdZWkJ2QzZrWlc1WFJFZ3pYMy9x?=
 =?utf-8?B?c2cwMUNld2o3OXQrRTFnNWd1ZTEzMEZEd2xxcFlxNGVJKzR1c2w3THdpTDBT?=
 =?utf-8?B?YndtNVpVelR0Z3Y3N2hQdUQ0cmNGdUxzMnNKcmw1VXJUbG0rcjhDdjVibzdR?=
 =?utf-8?B?T2FBRkd2b2lHTmdwbUkxczJVY201K3NEMWpPUDIwdXZOYWtmR0hzUjEzcmpy?=
 =?utf-8?B?MlQ4S1RHbmxOOTJJQ0txUnlnc2t6dUt2L2Y4dXZqYWNzQTkxUk1GODRKbXov?=
 =?utf-8?B?UGZMUURZcXlaam5YcnorVC9HKzdJNHgxUzlOR3UzUUpLWklqRTdpWkg3SlZ2?=
 =?utf-8?B?M0NLNUVBc1lZVW1MUkpxSGJ0Rkl2aXNKVTZKczFrT2JyZFVEeUdnbUhDMzlk?=
 =?utf-8?B?cFJYVjNkNG9JeTlPMFhNN21WUDRFTG1yQndkK0NjSDJBQVpvbGtUNndqM1Ax?=
 =?utf-8?B?a3dMenZQTFRVcElGeEdkNy8rczQzQzAzNDJObEttYVJXbmpPWnkvWWIyQlc0?=
 =?utf-8?B?N01SZWI1Qm51L3ZQSXplaWVUOGNLMllkaW9GbmwwajdBQ0ZiVGU5alZZbnBX?=
 =?utf-8?B?UjZjZVVwVkE2UnVPMmdsajFEYmpMNFBXcmcwUVk0YUltQWh5NzBIRmtDMmhk?=
 =?utf-8?B?UGlOdzNzbXBDaFdyN1YwMEZQUXNhRkt2YnlwUENsNXdGQzgvdHBmVURuNlJ2?=
 =?utf-8?B?TlRPeXBFMWF2MHJNa29pNERIQUVVUGYrSXdaSDViN3FZUkxZVkZVZ0hlOElm?=
 =?utf-8?B?Nlp2OVVtdTFnNnc3eEg5M2E4QVpEV3RpZE9Rdkd0RCtjNTAxd2srUUlId0sx?=
 =?utf-8?B?ZmVhVE4xQzhOelN2aklNcUt0SU52RlAxeEdSUEo3dldEYnY1WVcvd3ZqbUpy?=
 =?utf-8?B?S2xsV1paZU9DNUd6dklHcVZ4WHA5UGdsWFY3Z05PeitBMDNuWjdSQ1hSL2pU?=
 =?utf-8?B?R2g3dXZyT1AyeXZ2VEVKQnRSQjI0UG9oZ3JqdXhVWk9La3NaQU5hcUZqaVV5?=
 =?utf-8?B?N2FOdEVLQVZyREpHeXE4aGQrckpuRy9WMDRYMlc1Uy9ERWp2T0paV1VHTS9H?=
 =?utf-8?B?M3kzMnVPM0sxbFJKRjd2cjJlTzN2bkQ3dWtMOFNpdnVMSkxKVEdnUmZiNlB0?=
 =?utf-8?B?SmdSNkFYM2gzTW9yYlBrRTJ5L2RIMHh4MzErRld5b3NTNVUwZ2lhSkFkQmIv?=
 =?utf-8?B?V285VCtwWnJGWXpKdTFKSDZpYWN3NzZ5V0R6d1lEazRLMWJrMlR4dmo2bWE0?=
 =?utf-8?B?S0FnS2MyUEgxYlVZcWhtbHEwazdTT052V3B0RUc3ZjcrRmVtTTY3RWEwTHZh?=
 =?utf-8?B?MlNHVkpvQUF0Y0pPTERKeXYxM1RFU3E3NEFsSi92MTlPWk9rQ2c2RnJYVVMx?=
 =?utf-8?B?NFRpeW9WN0R5Q3JqR1VYa3pvc1lDV2w3dmRZNGRRbm02RW1YOHRmMUtsR296?=
 =?utf-8?B?YXVNSkFrZmVSNCtlNnhaU3NHYy85UzlWOU5aa2UyTGRwVlp6UTlpR1FrVUVD?=
 =?utf-8?B?eHpUb0diUE9XSjNIVzBNQTBQTi81UG0xMFR5Y3lPWllOVkZNZDNkbE0zSnRs?=
 =?utf-8?B?ZVh0aFdlVlBiaDd3SkxFallNd3RxL1psQXc1ZFV3M2hSUU5HdHh3Q2xvalQ4?=
 =?utf-8?B?UVdZdWo4VHJ6dDVKMHhEQy9IMVUramhmSEh6VG5EQWZKd0owcWtaRVp2aWlt?=
 =?utf-8?B?ek9CUGxuNTk0RmhjOWFvc2JBaDJYYXZEUEJhM1RuNytjTlc5d21nN0lwNnJS?=
 =?utf-8?B?ZkpOOHc4R1pjUUxtM0I1K0F1aXhBTGVDQzBBSHNjUzdka3liM2szclNjcEdh?=
 =?utf-8?B?RmV6eTBzd2pxSGpPbHZ3VFZ6ZkdjaSs0cFNWNnRBNFFGWGU1Tm9FWnJuZDRx?=
 =?utf-8?B?QnovQWVOc0Z5WHZ5Mjg4aldXdFJJak1CZFlCemJJTEhveHBxc1NuOGNPNnlm?=
 =?utf-8?B?UkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf25ee1-be34-4f09-f0c3-08dc2e2620e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 13:00:47.5393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V9RelICvjuoU1wFXYGd3MRaOclf6z8twCseUCdp/cVCNgMmatQB9+cJ7naX+vWHtSx28hK3lN45JennMGgvcAvHjf69581UfJstma1kBNdxeGHug35xp/3lbXVS+uVa6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11901
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Feb 2024 13:00:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14994

SEkgYWxsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGNpcC1kZXZA
bGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24N
Cj4gQmVoYWxmIE9mIEphbiBLaXN6a2EgdmlhIGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTZW50
OiBUaHVyc2RheSwgRmVicnVhcnkgMTUsIDIwMjQgNDoyNSBQTQ0KPiBUbzogY2lwLWRldiA8Y2lw
LWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc+DQo+IFN1YmplY3Q6IFtjaXAtZGV2XSBDSVAgSVJD
IHdlZWtseSBtZWV0aW5nIHRvZGF5IG9uIGxpYmVyYS5jaGF0DQo+IA0KPiBIaSBhbGwsDQo+IA0K
PiBLaW5kbHkgYmUgcmVtaW5kZWQgdG8gYXR0ZW5kIHRoZSB3ZWVrbHkgbWVldGluZyB0aHJvdWdo
IElSQyB0byBkaXNjdXNzDQo+IHRlY2huaWNhbCB0b3BpY3Mgd2l0aCBDSVAga2VybmVsIHRvZGF5
LiBPdXIgY2hhbm5lbCBpcyB0aGUgZm9sbG93aW5nOg0KPiANCj4gICAgIGlyYzppcmMubGliZXJh
LmNoYXQ6NjY2Ny9jaXANCj4gDQo+IFRoZSBJUkMgbWVldGluZyBpcyBzY2hlZHVsZWQgdG8gVVRD
IChHTVQpIDEzOjAwOg0KPiANCj4gaHR0cHM6Ly93d3cudGltZWFuZGRhdGUuY29tL3dvcmxkY2xv
Y2svbWVldGluZ2RldGFpbHMuaHRtbD95ZWFyPTIwMjQmDQo+IG1vbnRoPTImZGF5PTE1JmhvdXI9
MTMmbWluPTAmc2VjPTAmcDE9MjI0JnAyPTE3OSZwMz0xMzYmcDQNCj4gPTM3JnA1PTI0MSZwNj0y
NDgNCj4gDQo+IFVTV2VzdCAgICBVU0Vhc3QgICAgVUsgICAgICAgIERFICAgICAgICBUVyAgICAg
ICAgSlANCj4gMDU6MDAgICAgIDA4OjAwICAgICAxMzowMCAgICAgMTQ6MDAgICAgIDIxOjAwICAg
ICAyMjowMA0KPiANCj4gTGFzdCBtZWV0aW5nIG1pbnV0ZXM6DQo+IGh0dHBzOi8vaXJjYm90Lnds
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWVldGluZ3MvY2lwLzIwMjQvMDIvY2lwLjIwMjQtMDItMDgt
DQo+IDEzLjAyLmxvZy5odG1sDQo+IA0KPiAqIEFjdGlvbiBpdGVtcw0KPiAgIC0gcHJlcGFyZSBi
bG9nIGVudHJ5IG9uIFNMVFMga2VybmVsIHN0YXRlIGFuZCBjaGFsbGVuZ2VzIFtKYW5dDQo+ICog
S2VybmVsIG1haW50ZW5hbmNlIHVwZGF0ZXMNCj4gKiBLZXJuZWwgcmVsZWFzZSBzdGF0dXMNCj4g
ICAtIDQuNA0KPiAgIC0gNC4xOQ0KPiAgIC0gNS4xMA0KPiAgIC0gNi4xDQoNCkZZSToNCg0KRGF0
ZSB0aGUgZGF0YSBpcyBjcmVhdGVkOiBUaHUgMTUgRmViIDIwMjQgMTI6NTc6MzYgUE0gVVRDDQps
aW51eC00LjQueS1jaXA6IGludGVydmFsIDMwIGRheQ0KICBsYXRlc3QgdmVyc2lvbiByZWxlYXNl
IGRhdGU6IEZyaSAwMiBGZWIgMjAyNCAwMzoyNzoxNSBBTSBVVEMNCiAgbGltaXQgZGF0ZTogU3Vu
IDAzIE1hciAyMDI0IDAzOjI3OjE1IEFNIFVUQw0KICBTdGF0dXM6IE9uIHRyYWNrDQpsaW51eC00
LjQueS1jaXAtcnQ6IGludGVydmFsIDYwIGRheQ0KICBsYXRlc3QgdmVyc2lvbiByZWxlYXNlIGRh
dGU6IFdlZCAwMyBKYW4gMjAyNCAxMDo1NDowNiBBTSBVVEMNCiAgbGltaXQgZGF0ZTogU3VuIDAz
IE1hciAyMDI0IDEwOjU0OjA2IEFNIFVUQw0KICBTdGF0dXM6IE9uIHRyYWNrDQpsaW51eC00LjE5
LnktY2lwOiBpbnRlcnZhbCAzMCBkYXkNCiAgbGF0ZXN0IHZlcnNpb24gcmVsZWFzZSBkYXRlOiBU
aHUgMTEgSmFuIDIwMjQgMDM6Mjg6NDIgUE0gVVRDDQogIGxpbWl0IGRhdGU6IFNhdCAxMCBGZWIg
MjAyNCAwMzoyODo0MiBQTSBVVEMNCiAgU3RhdHVzOiBsYXRlDQpsaW51eC00LjE5LnktY2lwLXJ0
OiBpbnRlcnZhbCA2MCBkYXkNCiAgbGF0ZXN0IHZlcnNpb24gcmVsZWFzZSBkYXRlOiBUaHUgMjgg
RGVjIDIwMjMgMDU6MzQ6NDkgUE0gVVRDDQogIGxpbWl0IGRhdGU6IE1vbiAyNiBGZWIgMjAyNCAw
NTozNDo0OSBQTSBVVEMNCiAgU3RhdHVzOiBPbiB0cmFjaw0KbGludXgtNS4xMC55LWNpcDogaW50
ZXJ2YWwgMzAgZGF5DQogIGxhdGVzdCB2ZXJzaW9uIHJlbGVhc2UgZGF0ZTogTW9uIDA1IEZlYiAy
MDI0IDAxOjA0OjAxIFBNIFVUQw0KICBsaW1pdCBkYXRlOiBXZWQgMDYgTWFyIDIwMjQgMDE6MDQ6
MDEgUE0gVVRDDQogIFN0YXR1czogT24gdHJhY2sNCmxpbnV4LTUuMTAueS1jaXAtcnQ6IGludGVy
dmFsIDYwIGRheQ0KICBsYXRlc3QgdmVyc2lvbiByZWxlYXNlIGRhdGU6IE1vbiAwNSBGZWIgMjAy
NCAwNToyMTo0NSBQTSBVVEMNCiAgbGltaXQgZGF0ZTogRnJpIDA1IEFwciAyMDI0IDA1OjIxOjQ1
IFBNIFVUQw0KICBTdGF0dXM6IE9uIHRyYWNrDQpsaW51eC02LjEueS1jaXA6IGludGVydmFsIDE1
IGRheQ0KICBsYXRlc3QgdmVyc2lvbiByZWxlYXNlIGRhdGU6IEZyaSAwMiBGZWIgMjAyNCAwNzox
Mjo0NiBBTSBVVEMNCiAgbGltaXQgZGF0ZTogU2F0IDE3IEZlYiAyMDI0IDA3OjEyOjQ2IEFNIFVU
Qw0KICBTdGF0dXM6IE9uIHRyYWNrDQpsaW51eC02LjEueS1jaXAtcnQ6IGludGVydmFsIDMwIGRh
eQ0KICBsYXRlc3QgdmVyc2lvbiByZWxlYXNlIGRhdGU6IFNhdCAwMyBGZWIgMjAyNCAwODowNjoy
NiBQTSBVVEMNCiAgbGltaXQgZGF0ZTogTW9uIDA0IE1hciAyMDI0IDA4OjA2OjI2IFBNIFVUQw0K
ICBTdGF0dXM6IE9uIHRyYWNrDQoNCg0KPiAqIEtlcm5lbCB0ZXN0aW5nDQo+ICogQU9CDQo+ICAg
LSBLZXJuZWwgYXMgQ05BLCBtb3JlIENWRSBhc3NpZ25tZW50cyB0byBjb21lIC0gYW55IGltcGFj
dD8NCj4gICAtIHR1cm4gb2ZmIGtlcm5lbGNpIGJvdCByZXBvcnRpbmcgdG8gY2lwLWRldg0KPiAN
Cj4gSmFuDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg==


