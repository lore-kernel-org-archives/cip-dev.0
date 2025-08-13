Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAC0CA0EC4
	for <webhook@archiver.kernel.org>; Wed, 13 Aug 2025 04:29:59 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.93175.1755059393188817685
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Aug 2025 21:29:54 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 57D4ToB72569753; Wed, 13 Aug 2025 13:29:50 +0900
X-Iguazu-Qid: 2yAbuzQy5mzeQdE1Rv
X-Iguazu-QSIG: v=2; s=0; t=1755059389; q=2yAbuzQy5mzeQdE1Rv; m=2kvJVE7ZVs3liESMy9sHhnxWe10N8AEYpYMzDerMD5M=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 57D4TnWV1858349
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 13:29:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbREr5GNZQZp4DThhbEJ0ZuqGpnkNq9u9svfEitNdTy6rJu1qf/usgU/btsfz4wI70FrkyHv2PNcCK/n0Y/1wr5+m2XF1dYYLURDOy679m6RRK82CeGd9h4VgFIyPD7vtY4YdK7OXHFx1hb9RDqEneYbkd1ZBqpk8ufi9kPb4wrzC7s4dE4Oq4PeEO913qAWNwQza/FneetK6n4cTq1Wim/s5ja2XmUbQYnHRpEQoUJErWF2T+988CjujAXtqO7eai/lFO73hEVPKRg9w8zs5vfyOEvUPz70oqyMmPDx/cbc/JnbnxKujonAFgSzKaKWJ1QdM8m40Jmz9ksrXAxCXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DadLbwmlvaexc5iU02k4PcL/n3kB8WZDW3fEM3cazyI=;
 b=S0kaBeEszjQi4rXTFVUDSlb6hRPrOH5Ozbu1S1UjIbAAzKuIGkfFzpfSzc7yGGqbyfb45TJlwFFHJGFRjTc0YWADcaycZqC0betzvrzC+Do9zJ4pNfFWftbnISIByN/rXpCGqNFJYPNqbf97qbEyebrI7FD8cFPH74qKLlZy5bqSpSeICeBQKlNy/stdneNsoLlZIk5Jd1ArfnsC3Qp6OiOKVox31WtY/Os9rfAslRWvh4mvmAlfP6gnVTXc/dFtt9zGz04umcE2mW/w2jMBY/ulHuVGLZt6zKngqljajeceC6/YZlCpBsU5r3YB3yqM+vSiUdyDu8wAsKgty2V7Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [isar-cip-core][PATCH] swupdate-handler-roundrobin: Update
 revision for rdiff_file handler support
Thread-Topic: [isar-cip-core][PATCH] swupdate-handler-roundrobin: Update
 revision for rdiff_file handler support
Thread-Index: AQHcC2zO1gJrNqTVuk2gCEwRuzUb0bRfdi2AgACHbPA=
Date: Wed, 13 Aug 2025 04:29:46 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB110752C228BA5A80A92B09B55C72AA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
References: <20250812092815.1282546-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <ec5c9daa-5dbc-4073-a0ff-228ab91444d5@siemens.com>
In-Reply-To: <ec5c9daa-5dbc-4073-a0ff-228ab91444d5@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|OSCPR01MB12567:EE_
x-ms-office365-filtering-correlation-id: de105aa9-21a4-490f-5896-08ddda22089e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?WVJyczkzS0VLVDJ0L0ROVVRRSElERnZsaE9RR0kyRHFUcGJtdzVocDhJc2R6?=
 =?utf-8?B?c1hkdmxTK09jS3JxaDNpam1oUlFmZ1ptSDc1d0FhQkw0eGlhb3ZBNkMrNGF1?=
 =?utf-8?B?V3Y3TDJFVW5aM1NleXdvKzBUcnlPL1lURnEzbzgxbmFmUnVwWFJwcmhubkNO?=
 =?utf-8?B?bnQ3TXZ5UHNHYTdlMXJ5TTBSeXZnWE9mcWZzY3RRRm84MTNvTXo5a3h3Nkh3?=
 =?utf-8?B?eTJ4djIva05wZHJGMTdHQU1DTktqS2pNQmdoQXB6ZVd2ZXVmYTBTOXl3d3E3?=
 =?utf-8?B?b1FEd1FsSklhdkI1SndOamFTYnY5SWZMa0grTHdPRnR5ZnR2aVo4MkhCNWEz?=
 =?utf-8?B?SGZLRm1lNFR4VDFJaVhOQ2JwWjlWeXZKd0twVjgyUyt2Q3RyUysvQnVQLzRu?=
 =?utf-8?B?K1NLOGNUVlI4TExUNjhXQzlDZHZZdFVCQmhyeTFUM3ZpS3YyN01xV2lxVVJk?=
 =?utf-8?B?QmthSmhQVFVXTVAzem1LVnd0T1o2Z0N0czNKQnZOQ3NXcCtqcXlYV3J6VGR6?=
 =?utf-8?B?eFRMbzkvcEQ4bEZ6TmdRVFVMNGRmeWpoL0lCWnBPVUZQNWl4QXVKRExINXF3?=
 =?utf-8?B?TzlOYThzSXRGaDdZem9HamUrOWtuU2lZeE8vL1dhUjhEVFltU2RSRFhrc2g3?=
 =?utf-8?B?V0UvdVoyenFGZjdvWmJCOTl1NVRORXpOaC9FekkwdVpkRG5tK2FFQXgwZ1Ez?=
 =?utf-8?B?am9kZlRYTHhDZ05NeHdtR1p4MUhJL0crWlJNYTFEU0didklNTGcwU2hQaUZC?=
 =?utf-8?B?RlRZc0hRSGZ4dlV1Wk1nUC9GTFpKRkIxUEJJejVYRzFhRGs3OFU1WFZ2T3Nz?=
 =?utf-8?B?WE02a1ZaV0U3ZXVSLzBxNzB4SnB0eElURDYxVVVqaG9OUmNsKzBXRVlDNWNQ?=
 =?utf-8?B?M0dheGxUZjRTN1dBemkwQlRIUUxvZEpOM29uN1c0ZVRLL1hiUWZxQkNSaTlD?=
 =?utf-8?B?QjA0cGMrcHhYZ2NtRWxOSnZyL1R4SmJibzFGbXU2eEdOUDNBQXFpelZCTWMz?=
 =?utf-8?B?NFhkc3pGRjNQb1NNNm0rWldPb2tnRTFqcDF6dlNyQTNVeTJScjNkcFZYQUxN?=
 =?utf-8?B?R21VZmRGUW4zSER0azhUbVl6RWxHdnlrQ0dBazJPSUYvTTI3ZUQvaElLdDJX?=
 =?utf-8?B?TnZnMlhYZDM3RitsamJWeU5sRVhnUWhuNFZsMmYxUi9nbDFzd1FKd0ttdmdh?=
 =?utf-8?B?YUhQRUpSOExYZGp5OXZsUTh3R3kweHdGN1NNU1QzelQ2VmIyY0NRSGVzbUp1?=
 =?utf-8?B?Vjlic1hJUnRIeVFHSHBtUVBaTWxkRFpuN1BrWG13Q2lnaHVabWxXcG5rZjJt?=
 =?utf-8?B?SEFBbllnN3Fub3Riam1idFpmaERxaHJjZGN2TTNmLzcreGFGMXQzTXVZeHB1?=
 =?utf-8?B?NDlhZ2Fiajg0WWlQMUpEWkY4aThpem45NmphSzlabzAvNTBQbG0wb0huYVcy?=
 =?utf-8?B?c29VeWhNa0cyZkxRSnpSS2N4YmtMeDhYK2lPZUxXa2hwQ2JqWi9BUk5xSUFF?=
 =?utf-8?B?U1lES08zT01pY0kvZnZwdCtwSGJWSVdIcXNZNmxlOGpEdHRpY3ZibEMwazdv?=
 =?utf-8?B?M0dTSlVsUEU0aDBJUDhKb1NDS0lsTUptSkFBZ3hqbS8weGxBanRxSitpL3Q1?=
 =?utf-8?B?TWwxOWFHTDFSQXVESVZiVVlZTjYzbnBCY0Fwdk1VZVRGS2JPYUo5LzNMSzBx?=
 =?utf-8?B?SnpXT2NFVExaaUdralR6aXpsWjQ4ZzBUcnVzUnRocndzVEIvSXA0clJDMVE1?=
 =?utf-8?B?RHlaeGpnbHNTZHRocU16VFJoUVhyNmtXZVEzLy9qbGtkRGhyaXgxd2VYT1VJ?=
 =?utf-8?B?dFEzTUpWWTlZWE1HSGRFYTdGbEV2MUdMQ3hpZ21FT3ord2taM2FVamczWVha?=
 =?utf-8?B?WUZZZGpQanZCeFZXektudEpWMnIrVWZrSWNRTkt2emRPVmhINUJBcEpVOWFT?=
 =?utf-8?B?M0tqV0JrMndQTEFIRnpqcnZicFNXN1psK3hZZzBJQzhjYXFKclZxTFY2YjBV?=
 =?utf-8?Q?aGW5Vmwie9inOYNzmg+arRWTVVoieg=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cVFrNjNJV3NqcTJFSEh1aUpFdSs0Yys4ZHlFa0U1cXM0d1VMS21CeUlJelgy?=
 =?utf-8?B?OWNpM0tQYkFyQSt1Rkp6ZjlsVkJLbVBRWG1iNy9iMmlMbFFnbGxKNnZFckpi?=
 =?utf-8?B?SDhyWlNua2hSdzk1UUVPcHI1UnVLTjBEcXM5ZUpDeEljUXhXdmJNUkppa1d0?=
 =?utf-8?B?aHZpS2ZhMnk4b0JGQVUrcG9FN3h4WUNMOXhvb0NWOVVWM1l5NUNNaGFVV0dB?=
 =?utf-8?B?QWFwekpNMzZUWndxNE8rRDdWcmNMaFhFT0VjVGtHV0IwYWlwckxrSXdtcElv?=
 =?utf-8?B?V3VXditiQ3BVL0loMUhIdldlZUVSWnZ6OHBrNHBqbXJHNVgyOVVldnFwUDlC?=
 =?utf-8?B?T0MxRE96cnc2Wk1lSThuSTU5aGJxRFJGdnF2Mk5CbjJvdmViUDJ0VEhUalhr?=
 =?utf-8?B?RG5LMU5UU2VhbE1WdzRFZzgyallBZzhGZUFDYnJxbE93TVVWUG4ydGJYd1NL?=
 =?utf-8?B?aHozeERaNUc3aWZ3dVd3SWRDYWoyckRvYWd4ZjZBN1ltd1l2UmdqTW9paXR3?=
 =?utf-8?B?OWQ0TGtEU1JUWFlueVNiR0ZPdFJ4MnYxWE02RTExWEhCZFhYQzNhY09tUXBR?=
 =?utf-8?B?QVpwek8yMTBRTlIwdHlya1lOdWhpdktEWkh6dEVCSldKaFdDQnloVVhTWG40?=
 =?utf-8?B?TWpYdy9tOWljcHN2N3pOR3VEakowbzcyamFDT1hzL3lqRWNFVGEydnd2NUJ0?=
 =?utf-8?B?c0R5MjFxK1kzZ25SZi9ta0REZlJIZHluNmJuOXg5TzBXWjFZRTcvblBGM0No?=
 =?utf-8?B?VWdIZkdPcXpoYUJVeTJzWFdISU9UTGpPRVFIU0RoaHpySlFxVjdKVzVQV2k5?=
 =?utf-8?B?ZzFSeDBuY29SL25va0drMkpqZzJKVmhpNCtWMFNhRzNSRUFTaUFhTmxUQVZT?=
 =?utf-8?B?UGJsTERndlh5OUcxTjgwYU9pWTBmTnJua3NzbDAxNVJsanpoSWsyUXlLYktI?=
 =?utf-8?B?U2l5NlA3Qm43VXZRSDZCbUJOOTdQRjNFaHd6WDhxVDJEd3k4cldweFB3Z1FB?=
 =?utf-8?B?L2xnSGN3eVlNU1NpN2RjZTB0VldPZEprNWlBeXpoa2RIbU9nWmdJOGdNRHcw?=
 =?utf-8?B?M0YvWDBJcGpRc2xtZDUzWXlUZk94SlFwMVRKKyswRlp4NXJIR3ErdUswOTdZ?=
 =?utf-8?B?cEcxbVR5eTQxN2l0RkY2VWFtUFJINmxQZTBDNHlKOHMwb1BjZTc4QWtNc0tv?=
 =?utf-8?B?TmxlL2RJcG9kanFGeDFkL1l4d3ozSGo2Y2lKc2ZPZ1hmemtrNUVEYmREajhD?=
 =?utf-8?B?eEZrZEVsTUxvRnZRczFtTk9NYVB3b0g5Y3NURkxMUTFiYnAxbGxWTCtpdEl2?=
 =?utf-8?B?cG53YTVISHlLTzYxQlR2Q2pXclBpeEZoeXZEMFdLMU9QY1oyazV5Y2JFQlBk?=
 =?utf-8?B?dW0zTzdhZGJsYUhLdDNzZHBYWEF2YWpxR3ZTeXpKS3NteGRLUVQwS20wQ0Vn?=
 =?utf-8?B?Kys0QnlqSXpLTnQ5ZEp6WnBjOUw0aU1Pbk1IRlhMTCtBbXZxWkNZL0pJMEVF?=
 =?utf-8?B?MnBkZmd1d2JsZFpPUVFJbmlCVERCUVNxYkJzYTNnditiZjZQcUt2M0UzQWQx?=
 =?utf-8?B?ei9vcTVuNzhWM3RtVU0xVmtlN004QzNxSXkzMUREbEhaVmExMktrNmNDQ2Y2?=
 =?utf-8?B?akJQZGNiWmNkZXduek5HcXZDV3E1WmdvdEEzeVpXb3duSmRkVmRQUWNIaGY4?=
 =?utf-8?B?Nk1MNStjR1ZwUDVNK2Ivb0FSSXRqSEMybFgwcFdGSlpQWTdsLzFhWHR2dGFL?=
 =?utf-8?B?UW5PY0t6dG1CVmx5c0VSV1JRRUdLUkl2S1IyNmhWSUVlRTJFSVBxQ3VrSkty?=
 =?utf-8?B?Y2w2RDNKbWRDZ3ZhQXVHQnZZRXYrNk1sSWdySTE5WnhzS3B5b3NXTHRyS0Ex?=
 =?utf-8?B?czdmb2JnK3VjRVlYc3YvVEFwUnNUZ3I2bVNFVEI3RVFoZXBkOWhRdEtmZXN5?=
 =?utf-8?B?ZEplNTQ0ZlFvNHJmTHRHL2V1NDN2L1k2RUIrN0pPVTFkUlFOTGRWTjBaQzg0?=
 =?utf-8?B?RVg5M0tYbVlFUmJhQVQ5UE8vb1ZDaHBFNjNMdUVtc1gyVW90TDdlVGFCQXZK?=
 =?utf-8?B?RnJkMmhScXRWR1h2d1g3WUx0N01aNnFvM0hjdnlxNllJYW01Z01kNDEyRjJV?=
 =?utf-8?B?cUJwb2d1cWM5M0htcjNjc0g4amZOajBMODRQRFZkK0dmL3M1SUdsNFAzN1JX?=
 =?utf-8?Q?9SPNh0oa3cNDvD7AktmwXJY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de105aa9-21a4-490f-5896-08ddda22089e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2025 04:29:46.4433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3O3eu+wya9NdKPuhuAAEmCJV/5s7E+PPDkC1YCar3oJvs90KIcnnlAJefy8D1rS0/CciRF0sp1APls16ciVtFjzdlr1AhOyYXta5qMC6YdjK+zP3sII4R5HogjNj0TTW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12567
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Aug 2025 04:29:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19720

SGkgSmFuLCANCg0KPiBJIHdvdWxkIGhhdmUgZXhwZWN0ZWQgdGhpcyB0b2dldGhlciB3aXRoIGNo
YW5nZXMgbmVlZGVkIHRvIGRvIGRlbHRhIHVwZGF0ZXMgd2l0aCBVS0kgaW1hZ2VzLiBPciB0aGF0
IGFscmVhZHkgYWxsIHdoYXQgd2UgbmVlZCBmb3IgdGhhdD8/DQoNCkFoLCBJIHNlZS4gSSBoYXZl
IG1hZGUgZmV3IGNoYW5nZXMgaW4gaXNhci1jaXAtY29yZSB0byBzdXBwb3J0IGRlbHRhIHVwZGF0
ZXMgZm9yIFVLSSBpbWFnZXMgYW5kIHRob3VnaHQgdG8gc2VuZCB0aGVtIHNlcGFyYXRlbHkuDQpM
ZXQgbWUga25vdyBpZiB5b3Ugd2FudCBJIHdpbGwgc2VuZCB0aGlzIHBhdGNoIGFsc28gYWxvbmcg
d2l0aCB0aG9zZSBjaGFuZ2VzLiBTaGFsbCBJIHNlbmQgYSBzZXBhcmF0ZSBwYXRjaCBzZXJpZXMg
aW5jbHVkaW5nIGFsbCB0aGUgY2hhbmdlcz8gDQoNClRoYW5rcyAmIFJlZ2FyZHMNClNoaXZhbmFu
ZCBLDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBKYW4gS2lzemthIDxqYW4u
a2lzemthQHNpZW1lbnMuY29tPiANClNlbnQ6IDEzIEF1Z3VzdCAyMDI1IDAxOjUwDQpUbzoga3Vu
aWphZGFyIHNoaXZhbmFuZCjvvLTvvLPvvKnvvLAgRElUQ19ESVQtT1NUKSA8U2hpdmFuYW5kLkt1
bmlqYWRhckB0b3NoaWJhLXRzaXAuY29tPjsgY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcN
CkNjOiBkaW5lc2gga3VtYXIo77y077yz77yp77ywIERJVENfRElULU9TVCkgPGRpbmVzaC5rdW1h
ckB0b3NoaWJhLXRzaXAuY29tPjsgaGF5YXNoaSBrYXp1aGlybyjmnpcg5ZKM5a6PIOKWoe+8pO+8
qe+8tO+8o+KXi++8o++8sO+8tCkgPGthenVoaXJvMy5oYXlhc2hpQHRvc2hpYmEuY28uanA+DQpT
dWJqZWN0OiBSZTogW2lzYXItY2lwLWNvcmVdW1BBVENIXSBzd3VwZGF0ZS1oYW5kbGVyLXJvdW5k
cm9iaW46IFVwZGF0ZSByZXZpc2lvbiBmb3IgcmRpZmZfZmlsZSBoYW5kbGVyIHN1cHBvcnQNCg0K
T24gMTIuMDguMjUgMTE6MjgsIFNoaXZhbmFuZCBLdW5pamFkYXIgd3JvdGU6DQo+IFRoaXMgcmV2
aXNpb24gaW5jbHVkZXMgdGhlIHN1cHBvcnQgb2YgcmRpZmZfZmlsZSBoYW5kbGVyIHdoaWNoIGlz
IA0KPiBoZWxwZnVsIHRvIHVwZGF0ZSB0aGUgc2luZ2xlIGZpbGVzIHVzaW5nIHJkaWZmLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogU2hpdmFuYW5kIEt1bmlqYWRhciANCj4gPFNoaXZhbmFuZC5LdW5p
amFkYXJAdG9zaGliYS10c2lwLmNvbT4NCj4gLS0tDQo+ICAuLi4vc3d1cGRhdGUtaGFuZGxlci1y
b3VuZHJvYmluXzAuMS5iYiAgICAgICAgICAgICAgICAgICAgICAgICAgfCAyICstDQo+ICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1n
aXQgDQo+IGEvcmVjaXBlcy1jb3JlL3N3dXBkYXRlLWhhbmRsZXItcm91bmRyb2Jpbi9zd3VwZGF0
ZS1oYW5kbGVyLXJvdW5kcm9iaW4NCj4gXzAuMS5iYiANCj4gYi9yZWNpcGVzLWNvcmUvc3d1cGRh
dGUtaGFuZGxlci1yb3VuZHJvYmluL3N3dXBkYXRlLWhhbmRsZXItcm91bmRyb2Jpbg0KPiBfMC4x
LmJiDQo+IGluZGV4IGExODVmMjUuLmQyZWRiYmQgMTAwNjQ0DQo+IC0tLSANCj4gYS9yZWNpcGVz
LWNvcmUvc3d1cGRhdGUtaGFuZGxlci1yb3VuZHJvYmluL3N3dXBkYXRlLWhhbmRsZXItcm91bmRy
b2Jpbg0KPiBfMC4xLmJiDQo+ICsrKyBiL3JlY2lwZXMtY29yZS9zd3VwZGF0ZS1oYW5kbGVyLXJv
dW5kcm9iaW4vc3d1cGRhdGUtaGFuZGxlci1yb3VuZHINCj4gKysrIG9iaW5fMC4xLmJiDQo+IEBA
IC0xMyw3ICsxMyw3IEBAIGluaGVyaXQgZHBrZy1yYXcNCj4gIFBST1ZJREVTID0gInN3dXBkYXRl
LWhhbmRsZXJzIg0KPiAgDQo+ICBTUkNfVVJJICs9ICJnaXQ6Ly9naXRsYWIuY29tL2NpcC1wcm9q
ZWN0L2NpcC1zdy11cGRhdGVzL3N3dXBkYXRlLWhhbmRsZXItcm91bmRyb2Jpbi5naXQ7cHJvdG9j
b2w9aHR0cHM7ZGVzdHN1ZmZpeD1zd3VwZGF0ZS1oYW5kbGVyLXJvdW5kcm9iaW47bmFtZT1zd3Vw
ZGF0ZS1oYW5kbGVyLXJvdW5kcm9iaW47bm9icmFuY2g9MSINCj4gLVNSQ1JFVl9zd3VwZGF0ZS1o
YW5kbGVyLXJvdW5kcm9iaW4gPz0gImU2OTM2YjhjMjlhMjBjYjZhNjg5M2ZhYWU1N2UxMjQ5OWVi
YmMzNDIiDQo+ICtTUkNSRVZfc3d1cGRhdGUtaGFuZGxlci1yb3VuZHJvYmluID89ICI1ZGViNzVk
ZjU0NjljNWE2NmNkZDcyN2ViNzJhZjgzY2UwNzg0MDU0Ig0KPiAgDQo+ICBTV1VQREFURV9MVUFT
Q1JJUFQgPSAic3d1cGRhdGUtaGFuZGxlci1yb3VuZHJvYmluL3N3dXBkYXRlX2hhbmRsZXJzX3Jv
dW5kcm9iaW4ubHVhIg0KPiAgDQoNCkkgd291bGQgaGF2ZSBleHBlY3RlZCB0aGlzIHRvZ2V0aGVy
IHdpdGggY2hhbmdlcyBuZWVkZWQgdG8gZG8gZGVsdGEgdXBkYXRlcyB3aXRoIFVLSSBpbWFnZXMu
IE9yIHRoYXQgYWxyZWFkeSBhbGwgd2hhdCB3ZSBuZWVkIGZvciB0aGF0Pz8NCg0KSmFuDQoNCi0t
DQpTaWVtZW5zIEFHLCBGb3VuZGF0aW9uYWwgVGVjaG5vbG9naWVzDQpMaW51eCBFeHBlcnQgQ2Vu
dGVyDQo=


