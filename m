Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEB9C4167B
	for <webhook@archiver.kernel.org>; Fri,  1 Dec 2023 11:19:06 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.20599.1701429541752652731
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Dec 2023 03:19:02 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 3B1BIxsm360131; Fri, 1 Dec 2023 20:18:59 +0900
X-Iguazu-Qid: 2rWg5n14g0qCB5nI1I
X-Iguazu-QSIG: v=2; s=0; t=1701429539; q=2rWg5n14g0qCB5nI1I; m=BfZlzXX8zI/VmN8xna43sn5BswfvYlZwn3h/JXfeyt0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 3B1BIwsZ1691977
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 1 Dec 2023 20:18:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSpKMNbvn0DoBFSuxYsEz8VmMp8rV7S/+883osRCWhZ0frKoh6rOquH7I3HFmSq08ZscMcIBMYNzaHu9QYplz8ZYkEbbC8pK8gKBKEJ0gbm64v21ysG0GEsS+XdzVnrwbbgMpVPscu47wl+KS3rGI06rUSQahJOsDc0UjuT9lfHuSrQ+CNActfUHk+hy6hs/ClNoZ067iXH4nNQnt3qvtvkK8Y3Li46Vq/ge7KGFOfVZ4El0wFuBr0lV5tyhVuIBpbiKLGS+vJxBX/PaH5K9Cue0NlGoym0EyJ39F4St8zAcMxnze7o2I8r1kX/RbhLNzBj/rp9LkJn/064a8vHezg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mz2tjXQLOXC2REHPwiiVDL78p8CVDU8VFFs89p0ElKs=;
 b=ntouBPFABNlYKG8ul87SB81iKkb1PUlK+e06cHKQnNGJyiP6jGxLySNLxqlV6Qno1zmGPBjxREGEx9OV5Yr0hSGNSeC2E3OtOC0xpXM/UhTzEQTwqPGOJew6xcfbBLDH4WY9Wp3i7tQQXgYnYwGyv1LdRKiSXrqlyrqyVLJ/Fltyk1ECTgVhUpSzybYIYeQIIqxagwcSF4wprwU5pc0JzOSOL1UwjqlDtlWF6z5TpbaYCP3earkg4r0D/m/9ColbzleKKJDWTEwB5roE9RTRUJ5CgluhUhB6NjNQRCZyf6lnoycP0KVgjioBOHOG/h4Z1Yz9xu7dyfrJLEc8uaKRew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-dev] [isar-cip-core v1 0/3] Enable CVE check in
 isar-cip-core CI
Thread-Topic: [cip-dev] [isar-cip-core v1 0/3] Enable CVE check in
 isar-cip-core CI
Thread-Index: AQHaHRG0G9jQLxZLpkKzgaKcimZ/QLCJEggAgAtAgsA=
Date: Fri, 1 Dec 2023 11:18:56 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSAPR01MB49456D20C59D55AE80AA7B2FC281A@OSAPR01MB4945.jpnprd01.prod.outlook.com>
References: <20231122070121.326276-1-Sai.Sathujoda@toshiba-tsip.com>
 <2eb2c44b-01b8-4f30-aa2e-2d66e889a421@siemens.com>
In-Reply-To: <2eb2c44b-01b8-4f30-aa2e-2d66e889a421@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB4945:EE_|TYCPR01MB10745:EE_
x-ms-office365-filtering-correlation-id: 8e3f5927-6d89-447c-a87a-08dbf25f4ed1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 QLVPAchSsfYbhXqUCYjXGOiAa/4kv29QDcWvPaHd0I+34DLD2CAeGSSwnFq/eLp4paJkgC1EIT5j6KeuvpsKQzHUIB1TgNMcHlKohp/W6D+W9ak0klaxRn03juvvayYWYp+/4ZX2CkIJvAmC//k+bvrJfykEuShnopsnqbKESGAIwEd94vpGS+IeHA3539T9wJRLnQGqoWJlLOqf8on1xYPfdcBzmkb63d8IzG0eLbwEut+OLgv1IMPxEMMjApNClXEopLEzS3hAHkN6Lmke26RUhbh87LOoBbniUUsEQ3C3R2jHCnv/khB9tFSeOHQWK0R0+PBkcDHPSbNuOGKlhl+UD0x72GcVUru5dbA7hQeDVPPz3NASBGHgq+BV8bUisJuhni3h/a2MPMVTqVBvbqQ7q9KegyurRtKmSam89yYpuYj/gbQKfE20Rt5O8IcB8ewUocJW+ZA26X76CzzoYoXrkI8TxUFhyTdKLfK1NkmF100pqb+jNvRKh/8WVyC2LM4KANv0wDunOWejjkph7pri5vfxHlM3zkhfRfedZ3R7R9Szmw57agpiPjcrAPt0Wl5zkFi1VOuu85y1PQQwvuAsATsocoiuevEJSjEAB0CEiipVoA8Sl+yu6ubo0VrC
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB4945.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(136003)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(66476007)(66946007)(66556008)(54906003)(66446008)(64756008)(76116006)(110136005)(33656002)(316002)(478600001)(71200400001)(5660300002)(85182001)(38070700009)(2906002)(41300700001)(52536014)(8676002)(86362001)(38100700002)(4326008)(122000001)(107886003)(8936002)(55016003)(53546011)(6506007)(7696005)(83380400001)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?d1V2aFJGWTZ0SEdEdGVnV2w1czlTTHJ2a0VwZ0ZLNkF1bFFXKzVXNUVWbkMv?=
 =?utf-8?B?YzFjNkJtcmdBbVdtR2x4amZwVVNuRjZlb3RISmRlRWdGaDR0U29RN29mTHpo?=
 =?utf-8?B?OWJodTdSQ0FPWlFQdlFQQVZLTkozRG9IMitlbEFtZ0UxUS9oUUJrMmdOUnV6?=
 =?utf-8?B?NG1GVUlJMVhLQk9MZk1tRzE2ZUdHaHZSMytjVlhMVFBpbGN2aXdiczJVQ21j?=
 =?utf-8?B?VXNCaXFPZExyYkFwb1k5WEs3T2FlNDRxd3huVDQrNDF6c29sbFF3QXMzUDhB?=
 =?utf-8?B?a2MybXZMeVl0UlE1b1ZpWk5TZklZTEFBZGd2VkR4dWZISmJyeHc1ZTIrUFJl?=
 =?utf-8?B?QkpWa0RUK2UzbDJnYzNKU0dVY0Y5dDRHWGtwYTA5d1dCSlVlRWF5aVo2RW9x?=
 =?utf-8?B?c1N0ekM3WmJCY3FNcGhwN2JsU2NoTzQ0ZGFQbXcyY3lGWWZQNkRFc3RycWF4?=
 =?utf-8?B?WitRNHhvdTlKSWlxeUc5dmE1ZndkajQ3N2VwNllPMVNCVmdKWXFaTXhicjNE?=
 =?utf-8?B?N1p5TU10Q01ETFFRdU1UZ0VTU211aG9RQzBVODV6bklGNHZSdXJmYVlxdXp6?=
 =?utf-8?B?bHJEREd0MU1RVXoyYWU4Y3RCU1p6M21sTDY3YVdnNHR1YUs0dlR1djJCRi9r?=
 =?utf-8?B?TzFJT0Z1M0lvY0diV05xQW1iTlV5OWdSYkJVL0RMbDFlbE9NcXhVbVgwVlZ2?=
 =?utf-8?B?VkprQUZNQnd1aEw3bGFsSEk2dzVrL08yOURETmlOdys5UTJkZGtqYVlvc3Zr?=
 =?utf-8?B?THQ4M0oyUnRDMm9GZUNuU2l0a2VQdmg2WEF5ekFSSFBkUGFpUHkwdW1HNnoz?=
 =?utf-8?B?YUVKRmtGMnZHVjEyNEh5MEtrTCtvdlpoZERVSGhTMTVxVE5SN1VSZmoxeGZq?=
 =?utf-8?B?a2tLS3NJR28zTmowb1VXSTFpRy9ranJUOC92WXVWdkE0aDRaT0YwcUFjaUps?=
 =?utf-8?B?eE5BbEl5WStOL1FJTitIZWxWamRZY3BpZVZzS0s2end4ait3cXYvNytqTnRp?=
 =?utf-8?B?c1JJQVhlVks5WEwwbjFkakR2OEhHSTFwb1VkdFRxcW96S2VuTlNmSTM0NDlz?=
 =?utf-8?B?VThhVVUrN25VdDJlbUVxM0oxc1l3M01wNVgzMmF5ZVRHQkRGZGxGZUt5S2lr?=
 =?utf-8?B?VTlaWHBlRFFiY0MvbURPS0hnWXpKVDFSZFZLdGRTcTBwdFBjR1dIVCs4UWdi?=
 =?utf-8?B?Skhoa1BxRDF3Q2VRL1Zld1ZIVys4QkQvWWkyMnIxRGpXOHJjMEFCS3NQV1Vs?=
 =?utf-8?B?SWI1azd2ZWNNWTA0QVhlZWVwMXNEdUY1UzhjVGtBQStYWFliRlp5RzVlcDhG?=
 =?utf-8?B?SzQ4b0c1NnkweHJzWUtRNWlCbnVtWjA5UWxFLzB1UjBnS01vTUNuTlZRZEdw?=
 =?utf-8?B?RWhOWG1tcS9qV2ZJTEk4QlZObWFESTZMS0VUK29xSXRXakkyM29rVGplNXJM?=
 =?utf-8?B?RnRtQld4Z1UydkdreXBGWWFpWXI5Nmdtd1pvQ1lsSkg5WmRMZk9ZdVpjMDBr?=
 =?utf-8?B?ZWVWS01uSWJ2ZGdzRlBEdmViOCtyK1kybVkwWUxWM1Y2SDBjWnJkN0dZSmVp?=
 =?utf-8?B?SWwwaklNRk5lTlFDMHZBMWFBNGxYSXpyRkFpTmJQcUJaS21jdG5CYjJpVGN4?=
 =?utf-8?B?MzFNSm4zRkwvMCtSU2dOekMrUGc2OHVnR0hkTFlnYkpHTGllM0pCd3RBWm9B?=
 =?utf-8?B?TVZiZXNhbCsrSEFIcS9OR0M4Rmw1ZDFZRExIOXpJSDgvd0hTUUIxeHl4S0Jx?=
 =?utf-8?B?N2FOdVltd25mQS85T053cENoeWE1U1BqV2IweUNhU0tQNmhSdVROMm5ldjRI?=
 =?utf-8?B?WmxYK1FKUUkyaHp3ZXAzd3l5RDJRYnJxQTkweEdMWWhlck1nQzNQaWpHcmhw?=
 =?utf-8?B?bStSaVNKQXZhb1FLT01WdjRNK0NVa2VKa25SVjAyd1lmZXdSc2krL1JOYXpk?=
 =?utf-8?B?Z290TVNjTC9ta3pVVjFja3Q5bUpoWUhWTUh1SGY0OXgxNmROSlJXZG9OUFNw?=
 =?utf-8?B?Vyt3VG4xWW9qdnJwU2dDRjFWWjAwVSs5MHFGMkg4emtFaGFqTEd4amYrWmNZ?=
 =?utf-8?B?d0F1ZFhlMlZjeU41UUtJSGNaNmV5TVl6SkQzL0tJa01zQ0tPNExKSXppL2xN?=
 =?utf-8?B?UjRGNWwxamtzR290a2pwTW10SXdJUkk0ZFVkYVJhUnNyZEdscXlubC9SaU04?=
 =?utf-8?B?bmxMY0NTOThwQ0tWNGROVTE0Ym5ySDJTVjdKb1gzam1sWUJzSWs4VEg2NXpS?=
 =?utf-8?B?dUwvS1BrbkxOL3dYOU5sMVoyU3lRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB4945.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3f5927-6d89-447c-a87a-08dbf25f4ed1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 11:18:56.0921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QKhteiPrREhG95lBtOsESVoCyVrF3q2jxeFk4uWt4WIU+olBThhLSQn6cWfWV0TA7mvAXP2FX2KGUNApu6vaZjisH/0aZZMERH2E7/Eg8TU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10745
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Dec 2023 11:19:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13767

SGkgSmFuLA0KDQpTb3JyeSBmb3IgdGhlIGRlbGF5ZWQgcmVzcG9uc2UuDQoNClRoZSBpZGVhIGJl
aGluZCB0aGlzIHNlcmllcyBvZiBwYXRjaGVzIGlzIHRvIG1haW50YWluIGEgbGF0ZXN0IGNvcHkg
b2YgY3ZlLXJlcG9ydHMgZm9yIHRoZSBkZXBsb3llZCB0YXJnZXRzIGluIGFuIHMzIGxvY2F0aW9u
IHRocm91Z2hvdXQgdGhlIGRldmVsb3BtZW50IGN5Y2xlLiBIZW5jZSB3ZSBhcmUgbm90IGZvY3Vz
ZWQgb24gZ2V0dGluZyBjdmUtcmVwb3J0cyBmb3IgYSBwYXJ0aWN1bGFyIHNuYXBzaG90LiBJdCBp
cyB1bmtub3duIHdoZW4gYSBuZXcgcGFja2FnZSB3aWxsIGJlIGFkZGVkIG9yIGV4aXN0aW5nIG9u
ZXMgd2lsbCBiZSByZW1vdmVkIGR1cmluZyB0aGUgZGV2ZWxvcG1lbnQgcGhhc2UsIHNvIHdlIGFy
ZSBqdXN0IGdlbmVyYXRpbmcgYW5kIG1haW50YWluaW5nIGEgY29weSBvZiBjdmUtcmVwb3J0cyBm
b3IgcmFuZG9tIHNuYXBzaG90cyBvbiBhIHdlZWtseSBzY2hlZHVsZS4NCg0KUGxlYXNlIGNvbmZp
cm0gaWYgeW91IGFyZSBjb252aW5jZWQgd2l0aCBteSBleHBsYW5hdGlvbi4gSWYgeW91IGFyZSBP
SyB3aXRoIGl0LCBJIHdpbGwgcmUtb3JkZXIgdGhlIHBhdGNoZXMgYmFzZWQgb24gcHJldmlvdXMg
cmV2aWV3IGNvbW1lbnRzIGFuZCBzZW5kIGl0IGZvciByZXZpZXcuDQoNClRoYW5rcyBhbmQgUmVn
YXJkcywNClNhaSBBc2hyaXRoICANCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206
IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0
Lm9yZz4gT24gQmVoYWxmIE9mIEphbiBLaXN6a2EgdmlhIGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0K
U2VudDogRnJpZGF5LCBOb3ZlbWJlciAyNCwgMjAyMyAxMjo0NiBQTQ0KVG86IGFzaHJpdGggc2Fp
KO+8tO+8s++8qe+8sCkgPFNhaS5TYXRodWpvZGFAdG9zaGliYS10c2lwLmNvbT47IGNpcC1kZXZA
bGlzdHMuY2lwLXByb2plY3Qub3JnDQpDYzogZGluZXNoIGt1bWFyKO+8tO+8s++8qe+8sCBUTUlF
QyBPREcgUG9ydGluZykgPGRpbmVzaC5rdW1hckB0b3NoaWJhLXRzaXAuY29tPjsgaGF5YXNoaSBr
YXp1aGlybyjmnpcg5ZKM5a6PIO+8pO+8re+8pSDil4vvvKTvvKnvvKfilqHvvK3vvLDvvLPil4vv
vK3vvLDvvJQpIDxrYXp1aGlybzMuaGF5YXNoaUB0b3NoaWJhLmNvLmpwPg0KU3ViamVjdDogUmU6
IFtjaXAtZGV2XSBbaXNhci1jaXAtY29yZSB2MSAwLzNdIEVuYWJsZSBDVkUgY2hlY2sgaW4gaXNh
ci1jaXAtY29yZSBDSQ0KDQpPbiAyMi4xMS4yMyAxNTowMSwgU2FpLlNhdGh1am9kYUB0b3NoaWJh
LXRzaXAuY29tIHdyb3RlOg0KPiBGcm9tOiBTYWkgU2F0aHVqb2RhIDxTYWkuU2F0aHVqb2RhQHRv
c2hpYmEtdHNpcC5jb20+DQo+IA0KPiBUaGlzIHNlcmllcyBvZiBwYXRjaGVzIGVuYWJsZXMgQ1ZF
IGNoZWNrIGluIGlzYXItY2lwLWNvcmUgQ0kgYnkgDQo+IGV4dHJhY3RpbmcgdGhlIGxhdGVzdCBk
cGtnLXN0YXR1cyBmaWxlcyBvZiBkZXBsb3llZCB0YXJnZXRzIGluIGF3cyBzMyANCj4gYnVja2V0
LiBBIHdlZWtseSBzY2hlZHVsZWQgcGlwZWxpbmUgcnVucyBhIGN2ZS1jaGVja3Mgam9iIHdoaWNo
IA0KPiBnZW5lcmF0ZXMgQ1ZFIHJlcG9ydHMgb2YgcmVzcGVjdGl2ZSB0YXJnZXRzIGJ5IHVzaW5n
IHRoZSBjdmVfY2hlY2tlci5weSBzY3JpcHQgaW4gZGViaWFuLWN2ZS1jaGVja2VyIHJlcG9zaXRv
cnkgWzFdLg0KPiANCg0KSSB1bmRlcnN0YW5kIHRoZSBzY3JpcHRzIGFuZCB0aGF0IHRoZXkgY2Fu
IGJlIHVzZWZ1bCBhdCB0aGUgcG9pbnQgd2hlcmUgeW91IGFyZSBhY3R1YWxseSBpbnN0YW50aWF0
aW5nIGFuIGltYWdlLiBIb3dldmVyLCBJJ20gbm90IHlldCBzdXJlIEknbSBnZXR0aW5nIHRoZSBp
ZGVhIGJlaGluZCBkb2luZyB0aGF0IHRlc3QgZm9yIG1vcmUgb3IgbGVzcyByYW5kb20gc25hcHNo
b3QgZXZlcnkgd2Vla2VuZC4gQ2FuIHlvdSBlbGFib3JhdGUgb24gdGhhdD8NCg0KQlRXLCBwYXRj
aCBvcmRlcmluZyBpcyB0aGVuIHdyb25nIGJlY2F1c2UgcGF0Y2ggMSB1c2VzIHNjcmlwdHMgdGhh
dCBhcmUgb25seSBpbnRyb2R1Y2VkIGJ5IGxhdGVyIHBhdGNoZXMuDQoNClRoYW5rcywNCkphbg0K
DQotLQ0KU2llbWVucyBBRywgVGVjaG5vbG9neQ0KTGludXggRXhwZXJ0IENlbnRlcg0KDQo=


