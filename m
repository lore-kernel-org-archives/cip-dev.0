Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72A4C54791
	for <webhook@archiver.kernel.org>; Wed, 13 Mar 2024 09:33:10 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.12205.1710322380769187050
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Mar 2024 02:33:01 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 42D9WvFM906415; Wed, 13 Mar 2024 18:32:57 +0900
X-Iguazu-Qid: 2rWglQcuMCcTVT3ioU
X-Iguazu-QSIG: v=2; s=0; t=1710322376; q=2rWglQcuMCcTVT3ioU; m=7acNX/zjWRJpP4bZC1tvvVPghV+CTQeDxo/D5X6zUoQ=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 42D9Wtbw3165334
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 13 Mar 2024 18:32:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Of8sz7AoDXQyi944Q9ELMoVJYAuiPxbQ4dM3sdtoLUYstxk1HPxAIzRIkVtmNQ6E4u2oj4pBfBbDY/Ts1kDGhTVhK2vcp0qHl9aw9FSjsOeR4gI8Juvdaa0w6rqoCiF4jsQY3vxXDt8ykk4Z5K4eABh4SU5JjtmCPi1QzXcNSzzrTZfCvr6C8LZycYbTrIqpYQnDeXN6XAa67xgNzJ3kW5Xo9RsRRaDW7TpkH2dfdv55m1SbVwHq1FAs5kfXddr9e4aozAxesmzh21UtEQ+n7fwK3xLV+5c4ajTFgsLZvJDQPvhZyF2Y2fEvkntMxipZNpn0derigI13UE/gCwZrEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCFyiZwyaezJAK5GiTqbVjn7J7MN3jMeVHsCA8nWibc=;
 b=WJMEkx2tN9qzaqQmQX8VyUXbWlXr18FvUAAI6T7AzNalIEnoC+Y80bdByNvKk0M8KUXmuaKsxg79ntko3usUfGuvReC4OFRRCxhV2zrUNDctO0Zb2c7UU9WUTxBV6Q1j6YO7m48DpFOF8HTrwdzlzZUvCjzsz04+mZIPpeIPSs71p1VcN4qbxVO6barP4E59RNWrSMBKcf9gXgosD9nMlE/XT45fktdgtbfKRN7rL0+O+GX81O+Nh4a78yYgUq0mS1F0HHTCtJ4T12KSkB42tgwUtFLE3sj28K/r927olSncnjInWxdY7e1KPC9amivREz9f1fU4nCeMruYyFp5l7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <Shivanand.Kunijadar@toshiba-tsip.com>, <Sai.Sathujoda@toshiba-tsip.com>,
        <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [isar-cip-core][RFC v1 3/6] swupdate: Enable Delta handler in
 swupdate
Thread-Topic: [isar-cip-core][RFC v1 3/6] swupdate: Enable Delta handler in
 swupdate
Thread-Index: AQHadSls72HlFxDv/0G4clYTbycRrw==
Date: Wed, 13 Mar 2024 09:32:53 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB9669816609C10A53FB87C596C42A2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
References: <20240307074612.1996609-1-Adithya.Balakumar@toshiba-tsip.com>
 <20240307074612.1996609-4-Adithya.Balakumar@toshiba-tsip.com>
 <97facebf-c2fc-4253-927c-29831dab40ec@siemens.com>
In-Reply-To: <97facebf-c2fc-4253-927c-29831dab40ec@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|TYCPR01MB6352:EE_
x-ms-office365-filtering-correlation-id: c9f287d8-ecf2-484f-659d-08dc43408f3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 eJcx0y56KM+NwO4UbYnHQE1twDpj62qpqeyXjxI5mqvzyZ8TX9z4+VIEFvliWZD8NoSuFFNt6iEuxcmPUJV4cyDBY7WwQl3sVSq92Zm27llMkRWz14O7uyfO6TADbTeT/9rdmbMQL9DCypqHmECK6bqzlW0+sfWUPKEdBZJM7EWRA5Wjo7vQ6mN3ZujVTTbrXh7uOfQTHmmm20KrlvCT153uR1qf0ddwJQr/aT57sccoEG4JZGckMXcEyGOagC8Iwbg0f+QRS4ozbAMwabd5zRvedNRz1s+UXCmoXlpEL+sSOX+75rRa6WxmwkzLKxI7wRAOk/++H8vUBB5pCnlb6AXHA06RdMjXg5xjUeh6QFRanxm/FdjIrT0KWipptAa4ywLoX8A5fQU8Y1Qo4R9nwSGOlUCviTRszlZxKFW13zdUqS9lKgQ/R+XVdv6na3kezoG03zn7OHuyqU18QWDAShWx9MwLexfR1ntkcxFNbDSKIJe38ZWcdHjUIweqUqOE062CXG/YMRzCTGQsjk/p6JKL/Gb0otKaM6H72ZDmi6uHQgFv/c/98VivL9BUmo2jXNu1Sih5utltwDkK4KcrzGrwfHC6rBVCXGaBZVS9J78IN6yFfWCnZi9/eqWrV9T5pHgtV7lgXt6e1vk7sUGtHK89KcAK0ssaE2ZPebYlJHQ=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MUhEdVFJM1dybzBVd3d1QTNrOGIrcHM4cldUOGpYckgvUU1xeHVRMzZ6MFMv?=
 =?utf-8?B?a2dpbVkxS0tIVmFEU2YzS0xrZWNta21YOTAzZ25yU0ZEZFBjdWJDZUp3N2tm?=
 =?utf-8?B?S2U1ZzV5WGMzWlRTWlpaR1BqOFlOY3kvbG5objFDQkgrR0Fqd1lmWnFzM3ZB?=
 =?utf-8?B?TU0rRy9kQ0t4VVhTRm5vM1RtQkpCNUlyZTJhZW1JSVRhcHFmdHg1TUtGWlFC?=
 =?utf-8?B?QnJOU0pnMnEwcXpVOGJsaWN6QlFYckg1blNRZnhWRTloTklJdys4Y0YzZFho?=
 =?utf-8?B?VUp0aGRIU2RlaFhURE9kV0tLN0xRbFpXOEdLUis4SExreEZRbEVWZ2pHQk14?=
 =?utf-8?B?a3NxNUtIbVBEaGpBNUszNUtNOVZFdjJQWlI0UUJBM29lcFZwUVdvc211Nm1v?=
 =?utf-8?B?UldUQTdGUlNDbkV1dXJrZS91Tm53d210M2Y4SmhRUHNYOXBEdEgwbVA2Vkht?=
 =?utf-8?B?Sk8vOE83NlQ1OVRjd0xiUnBJSGFGakxvSlc3Z0RtQmcvZUhuSkd5SFRmSG5H?=
 =?utf-8?B?QnA4RnVDUFNmMlpSQm4zRHovMittUkdacjVueVJYWjVnWmppSmdzQU5sUCtB?=
 =?utf-8?B?OFZmVWt2d0VWTXFGR3lmeVZjMkZjbkQxUE9vbUF0aUt5ZjNZa3dNWjVVeWV3?=
 =?utf-8?B?ems0NkJuOHhaZExKTE9NRytKRmFDR1ovRitHVHJZOHZuTDhQYUhVdlY4aElw?=
 =?utf-8?B?emVXd1pzdm11Y0NoUlhhNVNLUnU5NzJmUXc5ZWpnYm9NOVJjdjQrelZUYjRC?=
 =?utf-8?B?eXhyaitjMVN4alRnQWVSQjVMemkvUUgrdDVBY2cxUXV3TTlXTUpqb2ErTEZZ?=
 =?utf-8?B?by82L2JRYXZKMnZCQy9TbVFSWlBmVWJWM0FCK2RpR1ViRkNvOHkyaVRZU3lW?=
 =?utf-8?B?ZElMcmYvalVWYUxSZmNONS8rdnovUXcwQ2Z3QTVHcWEwd2U0RGZFTDJ6bDBw?=
 =?utf-8?B?QjVIalY4NmdoUzdCaTU1eDhOYXpMRkE0cEdybU9Dek5aT3lQQXY0dDEwOEJy?=
 =?utf-8?B?VnllUDkxb0dpdEdQMW1BUnVlWk55MzlyTFZKYVBydnloaTRtdlJ4S3UyeTlj?=
 =?utf-8?B?ZWE3UFBQQ1YrQkFURGpQVGh2cWRLQTloWlpJMEdweEtic25mM3FHOWxpTjE3?=
 =?utf-8?B?bmVER25teHlDVzNmWnNOSFJNYVlra2pDTS9ic1dHUGN4LzdKNkkxL25YeFZN?=
 =?utf-8?B?QVRqd1JsMWFaUlJCOFE1US9MOXU0MndTS2JhTk4vaWUxemxXREltL3N0bmd2?=
 =?utf-8?B?VWRHaHNuWGQ2akN2Zmh0dzI1Qnc5a0pnWHFXcEh5NEFKU2V5aE5DaEFidldy?=
 =?utf-8?B?dWJZWHpJT0RuWUxuZEFnNFdiZEcrekQ4UGlZRkVzemgzdVpPaElzWUxkSTBD?=
 =?utf-8?B?Q3YrL3RJY2lFNWduOG5JOCtDUHVzWTFYSmwrYTRWMkVBYnFzQXVOZmx1V3NH?=
 =?utf-8?B?UnU2TzJ6aXFvdXFZVE5Cdm9rZGtPdWZSeldndThJVUxzV2RGZkplZ2JuK0lj?=
 =?utf-8?B?V2FmZjl4L0ZFVXk0ZGdtZTNZWVBGSVlBMkVIa3pyUE5PVFpwdjEvNllIN1l0?=
 =?utf-8?B?eFNic3kva2czSEtKaG1qNUxVck95UFhONDIwRk9jTVJ6OW11T1JneUtkeHRv?=
 =?utf-8?B?ck41c29iNXU3U1RlR2lFZzFEYTQ0MVBnMXdsUDhjZVZMdDZtdDBmT3NkSHQ1?=
 =?utf-8?B?ZlJXa2tpOUtZSlNLUDZCT01uZUpTMFhTWTdwYWF1YmFYK1JpTkpYbnZZS2Jx?=
 =?utf-8?B?YTNMK3h1alBaN1FkUC9EYjk5THVpTUg4aElmblRqL3pjVFdUbFo1cTRlZEZi?=
 =?utf-8?B?cXBmdTBlTU05NHUwSEdCdU9kbFpQVGZOc0dzSGl3d2tQSzRkL2FSbU5ZSE54?=
 =?utf-8?B?TU5tSmdpTTk3RzlJUVVmU1ZhMUFwcUd1c3IrNWt5dTk0S2x0OUViSUpXWStN?=
 =?utf-8?B?VHRpaHR3UVcvNStmeXlMM1RJei83RDhrL1puYWFYTnoxeFUxK3NyRzhxYjZy?=
 =?utf-8?B?YWRmZVJ6S0pPR3RVNnJNZU1sNTArQ2Jha1Y0MEprc0JiSjBlN1drRzkrRkpT?=
 =?utf-8?B?TjJuUmRRdW1UQm9FbFMvOWtVUER5T1hoRWd2QVlkTjFacUQ1NmV5bzZidXpy?=
 =?utf-8?B?MktITVd0TDlxS3kwYVNBdzJGWjFxeldnMjJBYzEvUnpLT3BOWkQ2TldEY3Mx?=
 =?utf-8?B?VHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f287d8-ecf2-484f-659d-08dc43408f3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 09:32:53.9421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tv+ACSziulDuuIpsHjy6AdQieA4ca47LeXxmIIjkgYSt230NNC7EHdLq+/XQI017Dr8rwCrx2oKqZuHKF5S7KZ/jgIeBB5WujCxf3kF6Yup2V1nj1VELqF+fAq4UA5ym
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6352
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Mar 2024 09:33:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15288

LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEphbiBLaXN6a2EgPGphbi5raXN6a2FA
c2llbWVucy5jb20+IA0KU2VudDogRnJpZGF5LCBNYXJjaCA4LCAyMDI0IDU6MDYgUE0NClRvOiBi
YWxha3VtYXIgYWRpdGh5YSjvvLTvvLPvvKnvvLAgVEVVUikgPEFkaXRoeWEuQmFsYWt1bWFyQHRv
c2hpYmEtdHNpcC5jb20+OyBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KQ2M6IGt1bmlq
YWRhciBzaGl2YW5hbmQo77y077yz77yp77ywIFRNSUVDIE9ERyBQb3J0aW5nKSA8U2hpdmFuYW5k
Lkt1bmlqYWRhckB0b3NoaWJhLXRzaXAuY29tPjsgYXNocml0aCBzYWko77y077yz77yp77ywKSA8
U2FpLlNhdGh1am9kYUB0b3NoaWJhLXRzaXAuY29tPjsgZGluZXNoIGt1bWFyKO+8tO+8s++8qe+8
sCBUTUlFQyBPREcgUG9ydGluZykgPGRpbmVzaC5rdW1hckB0b3NoaWJhLXRzaXAuY29tPjsgaGF5
YXNoaSBrYXp1aGlybyjmnpcg5ZKM5a6PIO+8pO+8re+8pSDil4vvvKTvvKnvvKfilqHvvK3vvLDv
vLPil4vvvK3vvLDvvJQpIDxrYXp1aGlybzMuaGF5YXNoaUB0b3NoaWJhLmNvLmpwPg0KU3ViamVj
dDogUmU6IFtpc2FyLWNpcC1jb3JlXVtSRkMgdjEgMy82XSBzd3VwZGF0ZTogRW5hYmxlIERlbHRh
IGhhbmRsZXIgaW4gc3d1cGRhdGUNCg0KT24gMDcuMDMuMjQgMDg6NDYsIEFkaXRoeWEgQmFsYWt1
bWFyIHdyb3RlOg0KPiBFbmFibGUgZGVsdGEgaGFuZGxlciBpbiBzd3VwZGF0ZSBmb3IgYm9va3dv
cm0gYW5kIGRpc2FibGUgY3Jvc3MgDQo+IGNvbXBpbGUgZm9yIGFybSBhbmQgYXJtNjQgb24gYm9v
a3dvcm0gdG8gYXZvaWQgYnVpbGQgaXNzdWVzDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBZGl0aHlh
IEJhbGFrdW1hciA8QWRpdGh5YS5CYWxha3VtYXJAdG9zaGliYS10c2lwLmNvbT4NCj4gLS0tDQo+
ICByZWNpcGVzLWNvcmUvc3d1cGRhdGUvc3d1cGRhdGVfMjAyMy4wNS5iYiB8IDMgKysrDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvcmVjaXBl
cy1jb3JlL3N3dXBkYXRlL3N3dXBkYXRlXzIwMjMuMDUuYmIgDQo+IGIvcmVjaXBlcy1jb3JlL3N3
dXBkYXRlL3N3dXBkYXRlXzIwMjMuMDUuYmINCj4gaW5kZXggZDFmZTFmYS4uN2EyMjk0NyAxMDA2
NDQNCj4gLS0tIGEvcmVjaXBlcy1jb3JlL3N3dXBkYXRlL3N3dXBkYXRlXzIwMjMuMDUuYmINCj4g
KysrIGIvcmVjaXBlcy1jb3JlL3N3dXBkYXRlL3N3dXBkYXRlXzIwMjMuMDUuYmINCj4gQEAgLTM2
LDEwICszNiwxMyBAQCBTUkNfVVJJOmFwcGVuZDpidWxsc2V5ZSA9ICIgDQo+IGZpbGU6Ly8wMDA0
LWQtc3d1cGRhdGUtd3d3Lmluc3RhbGwtRml4LXBhdGgtZm9yLWRlYmkNCj4gIERFQl9CVUlMRF9Q
Uk9GSUxFUyArPSAicGtnLnN3dXBkYXRlLnN1cmljYXR0YWx1YSINCj4gICMgYWRkIHN1cmljYXR0
YSB3ZngNCj4gIERFQl9CVUlMRF9QUk9GSUxFUyArPSAicGtnLnN3dXBkYXRlLnN1cmljYXR0YXdm
eCINCj4gKyMgYWRkIGRlbHRhIHVwZGF0ZSBidWlsZCBwcm9maWxlIGZvciBib29rd29ybSANCj4g
K0RFQl9CVUlMRF9QUk9GSUxFUzphcHBlbmQ6Ym9va3dvcm0gPSAiIHBrZy5zd3VwZGF0ZS5kZWx0
YSINCj4gIA0KDQpXaGF0IGFib3V0IHNpZD8NCg0KW0FkaXRoeWEgQmFsYWt1bWFyXQ0KSGkgSmFu
LA0KQXBvbG9naWVzLCBXaWxsIGhhbmRsZSB0aGlzIGluIHYyLiANCg0KPiAgIyBEaXNhYmxlIGNy
b3NzIGZvciBhcm0gYW5kIGFybTY0IG9uIGJ1bGxzZXllICAjIHdpdGggY3Jvc3MgY29tcGlsZSAN
Cj4gd2UgaGF2ZSBhIHVuc2F0LWRlcGVuZGVuY3kgdG8gZGgtbm9kZWpzIG9uIGFybS9hcm02NCAg
DQo+IElTQVJfQ1JPU1NfQ09NUElMRTpidWxsc2V5ZSA9ICIwIg0KPiArSVNBUl9DUk9TU19DT01Q
SUxFOmJvb2t3b3JtID0gIjAiDQoNClRoaXMgaXMgdW5mb3J0dW5hdGUuIFdoeSB0aGF0Pw0KDQpb
QWRpdGh5YSBCYWxha3VtYXJdDQpUaGlzIGlzIGJlY2F1c2Ugb2YgYnVpbGQgZmFpbHVyZXMgb2Yg
c3d1cGRhdGUgd2l0aCBkZWx0YSBoYW5kbGVyIGVuYWJsZWQgaW4gYXJtNjQvYXJtIGFyY2hpdGVj
dHVyZXMgZHVlIHRvIGRlcGVuZGVuY3kgb24gbGliemNrLWRldiBwYWNrYWdlLg0KSGF2ZSBhbHNv
IHJhaXNlZCB0aGlzIGFzIGFuIGlzc3VlIGluIGlzYXItY2lwLWNvcmU6IGh0dHBzOi8vZ2l0bGFi
LmNvbS9jaXAtcHJvamVjdC9jaXAtY29yZS9pc2FyLWNpcC1jb3JlLy0vaXNzdWVzLzkzDQoNClRo
YW5rcyBhbmQgUmVnYXJkcywNCkFkaXRoeWENCg0KPiAgDQo+ICAjIHVzZSBiYWNrcG9ydCBidWls
ZCBwcm9maWxlIGZvciBidWxsc2V5ZSAgDQo+IERFQl9CVUlMRF9QUk9GSUxFUzphcHBlbmQ6YnVs
bHNleWUgPSAiIHBrZy5zd3VwZGF0ZS5icG8iDQoNCj5KYW4NCg0KLS0NCj5TaWVtZW5zIEFHLCBU
ZWNobm9sb2d5DQo+TGludXggRXhwZXJ0IENlbnRlcg0K


