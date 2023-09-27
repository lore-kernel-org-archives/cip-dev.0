Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B1FE80A9D
	for <webhook@archiver.kernel.org>; Wed, 27 Sep 2023 07:16:57 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.12228.1695799011879332872
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Sep 2023 00:16:52 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 38R7GntL1371528; Wed, 27 Sep 2023 16:16:50 +0900
X-Iguazu-Qid: 2yAaLCv84Lss0J4huv
X-Iguazu-QSIG: v=2; s=0; t=1695799009; q=2yAaLCv84Lss0J4huv; m=6M2k5A7+zXiY80e1TTnJTTGSp7yOx+7PDGS81jTgoJI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 38R7GmS42802496
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 27 Sep 2023 16:16:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aP/JFOQwgvgJCqfdbeT0rP5GKSGDyp7QTGXQi/EHdph0sSkhS5xsprB4G+DqLKkTnwI4uoauC4YyOSxwVxh0dZrZo0IwsXqTIOMcuaGM2eHGYngurKQLPmou2pW7ppVwkQaGLASFt1mJIlBcx2VckfAbASUUnIia4cje80kWXS3+eSbqXMDaVfDfVXqqVuMD+CWNwPPj1iL6oJsrQuAxwHKsOXblsxS/Q3BYgTaE+CdtnxxT/WZ5hVj1iVCpfCiHEtDNSRwA+mpzhAau22DrK24xOeJCkvGOV+GjzQE2lYEtQEr3qCF4i/FyFcJmbp14gxNjKEBoXmNkBYL86pqzjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+HrDzGKSGhewEv7rYPOPpMg4TMwFFFXuxhIUn7zFHo=;
 b=mu5/Fa8kf8hSgvtC+CtMi3TXwcoQW9s/Ae9s439W41EgxjvoZU/ATZGo0ziXX4zN5Y9WxUqKApBslS7iBpmteuXAvT5xR0KzUdDrRksfNiM9ZWUqZcXU7EkN03aFhPzB7TBZtoTmB7QOUVbCF2VjvjSvy9rvdd5f6UxuQxFU2YO8tXDHaigGB+O/wv/07kKf87kmXT9xgoj2ybjl1RYlFv5pwNPVx+FQDq0BVBWkpcB7IzEyGY3974/PtgcJlY48bNpHHCanWElaF9KNW3rxp3thLuSEvlKMpU1wsI3HoxJSKs1GDV/KzfhrJMrPl3BK2VYPO/3s747rnpatrAjCew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [isar-cip-core v3 2/2] conf/distro/cip-core-common.inc: Set
 dosfstools as build dependency
Thread-Topic: [isar-cip-core v3 2/2] conf/distro/cip-core-common.inc: Set
 dosfstools as build dependency
Thread-Index: AQHZ8JgmmNmEDpU6O0u4pJMJfsPV0LAuQHqAgAACpgA=
Date: Wed, 27 Sep 2023 07:16:46 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSYPR01MB5542D62C0F146939AFF637EBA4C2A@OSYPR01MB5542.jpnprd01.prod.outlook.com>
References: <e9aeb66d-91f3-40a3-8b5c-44b75bec3544@siemens.com>
 <20230926164021.30185-3-venkata.pyla@toshiba-tsip.com>
 <6a6e4add-e51f-46d8-ab52-f0793c569281@siemens.com>
In-Reply-To: <6a6e4add-e51f-46d8-ab52-f0793c569281@siemens.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5542:EE_|OS3PR01MB9639:EE_
x-ms-office365-filtering-correlation-id: e60885d6-0372-43f1-03bb-08dbbf29b599
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ggB0rvzECEomMe4NoTc0w/bf2844orZZobR/wc0QtYDC6hKJ9bC4u2F8BcOy3g1dypejpLtTCRuiJhdmvGakZikgvRrxYZhm+iEj4Mi1swrA3hlnO/CMS1y5NUaxjC2HjwYS/ZkAKB0Dl9/GhEivqICGHYIAva+N/BKLy/TDwhDLKvUzSJEwiaIXWtNcRXklZhU4gdrF3RC0ZmVwTYgb/5CyEE/KBIXmdiKcC/nfGBVSddhBnSEdeVOFgiCtvVLU7UPya9x514keduEDx4BKDksRqs4CesBGxViT3NRdTG8JggGSEbew79mdtbyGEv0+pk75KYcSJArL2Bh6sf5+et3kWm048zM/e3Wf2TCiDRhlylvYYufh6peNbyt/yO/dGCXzEupGIszQ7ibvn7p82L6P6zh0jJh7rbKEguAj0V4O37Dwwtq/Bb1U3jic2tLKrXDG6p0gr2W9EmlBvA0JTmDTzRq+/p3ZEqXF6GUKGZ2ZBqnaZ3WUtWMvIj7ggQ7HZT4LaOmWFXvI75nkzA9iTwppAm7SmZGm7eVmVHW20bKwFr/SJrDvdDpHhPuWdc4rRT83YfFx3wvHgi/7nTikMRaOlbGC9nKVRC5dXv+l9os=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5542.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(451199024)(1800799009)(186009)(478600001)(33656002)(6506007)(55016003)(5660300002)(71200400001)(38070700005)(86362001)(53546011)(38100700002)(7696005)(122000001)(9686003)(76116006)(54906003)(66946007)(41300700001)(966005)(85182001)(66556008)(66446008)(64756008)(66476007)(316002)(110136005)(2906002)(26005)(107886003)(8676002)(4326008)(8936002)(52536014)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UXZZSGR6a2huZGtDaTRVWjhlWWxGZjNmeW5lVmlGRlRkcllPSFpMdmw5R1hG?=
 =?utf-8?B?YTFNMDl3aml0L1lqZ1JSZTYyZm5OeDNnSWFLdlZ2L1JBUzMxdUpZMi9TdVAr?=
 =?utf-8?B?b3hEYkRWT1RpMlBsbjNlSEYvUm1jSTZ3TlpUNG5uVzBJN0RtaCtPdFFzZENI?=
 =?utf-8?B?ZDkxbmZQWTlQRk5wNEp1b1BQbm5Nd0N4c3V2emQvQW5uRnlLVHRva3VqNEo0?=
 =?utf-8?B?UWdyOWZqTnAxSmxiZDd4MHIzRVRHaGRvZmpYV0R2emJtdVZtcFg3RzNqVTVs?=
 =?utf-8?B?bzhQMVZqZnZWZUFURTJkVVI3T25yQzNFNW5LcGxHNFkyM2YrYVRGUEF0cmZ6?=
 =?utf-8?B?aEhUc1M0U0c1QWZNZFRJMy9aQ290MHJUTlZMUTJyRnZYbFV1V05iVEZ0cS9K?=
 =?utf-8?B?VHl6L2xKSkRBV1BuZEhhQ0JMem43NTN1T0k1RDdiQjRPNXo4TkhtK2xpcUtq?=
 =?utf-8?B?Zldjd1hGRG92VURwOEhTcUdCeDdUOHN4andDbDAwcENKNzI0aUNpWFFJckY4?=
 =?utf-8?B?N0JmL2dmU3VueGNjYlZGTm4vckszUkFjRDhRTVUrb1ZaeUZvZ0JXVWhEd1NL?=
 =?utf-8?B?QjRzN1drREpvbGtUQjRhc2U0TVVqK3Jha0g5UkZUbTFRdldGU3BTWTcrcUlk?=
 =?utf-8?B?emp4R2hQRXlWYjhBV2pUanh1L2JNZGZCNXlZREtHRlZnVmpmVlBuTkJpSjBD?=
 =?utf-8?B?V1FXdGlxWnJCN0lsUGk3dVBXd1gyRDUrM3hJWmxzbUFlWTZ2MGdVbjFIL1N2?=
 =?utf-8?B?Mlp5ZUxnOWFTcFlvak1NbHBTTXpuaHNUMjFYQ3lrYkV5S0pNMmxaOHRsZ2lr?=
 =?utf-8?B?RTA1ek9JdndCbTRuUmZsRTZhMm5LSTdVN3pPSUdZUktQc1FyWFUwelZxT1Ir?=
 =?utf-8?B?MEFwSkQzQncrVzhZSUpxMTNjZ3czOHpUbGVpRkl6Yk0zeldOa0lzSVByMlpB?=
 =?utf-8?B?SzZLNzBPbjZ3SDcyT1lQbGRPaWx4MFlISTdUd3dlQ1BkY1VyNFgwVlpxTnBn?=
 =?utf-8?B?Z1dOcWRkckxCdVJoNXVMa3NtcmpyVXpvRFFhWUdKdmhZSzRkTDl4Q3VSRVlD?=
 =?utf-8?B?TjBiSFBWejNvSHhqRDN5Rkpxd0ZrVy9UeTFOcjRXOHhNN002TGNCcjV3OVUz?=
 =?utf-8?B?OHZkSGdmbDRxNTk3Znpvc2ZkQkYvSnl5VkUyblM2eFNGUTRnUDdiL2Yxd1Jm?=
 =?utf-8?B?UjUwd3NneWszUG5lM0pTV2w2amxNZHU1RVV3YVRhYlloWS9zMG1ORmN0aG1m?=
 =?utf-8?B?UDUvZU9hT2lFckNQejd2OWFrRmcrNjdzL0RSZVdOUU1jemJUVEZzUmdUNzJW?=
 =?utf-8?B?UE1FMDQyby9RQmhBbE9Qdm5IMC90NDlDMUFaZU1HN0pIKzE1V3lhL3JpNGJ5?=
 =?utf-8?B?T2pvZzhPdDB5eGVrVDlxM08wd1FnTVNPUm5SS2VSTWVVSDZJQldvaVdiclFH?=
 =?utf-8?B?amJod05DV08rNkw1WEVwV2UvVTlabVY4MWJUQ2t2MnZjVW5UT3h0U24zS2pO?=
 =?utf-8?B?OFJEWjQyemhlK1dSVXhvb1hXOVlOOHloQzlIRWUzV3hlZE1uZnhsRTNsYUJi?=
 =?utf-8?B?UFRwL0VxTC9kT0dyanZINmZzNXNCUmFEMUR4dTJaa2EvREdxdFJ4bmVIRU8r?=
 =?utf-8?B?L3UySGpEZ1dobFcyWTc1SXFqSmp2cGcycVRBSHR0OUQwMkswbC92d01oUGVv?=
 =?utf-8?B?TTlMR1BTTmd5VEs1ME9LcmY3dkZlUHNzRzMyby9nNWIxT1ZLVmgraWJVRjR2?=
 =?utf-8?B?V2cvYktjRFNVTE1oZmw4elBzTzJpaTZ6ZEgvUkxTU0diZ0UxeDJxSEtnM3lE?=
 =?utf-8?B?L2loT2V5cFVZeFNUVWxJckpCZEVHV041NzVHU3VxeG1RSEx4dG54SXRkT2Va?=
 =?utf-8?B?S3l1Yk1rRm4waXJVMEFybW1GakxkZ1Q3VG5kemtmTWg1OFZURnZURk1qdVJP?=
 =?utf-8?B?REplbWRQUUkzUE1QeHZxVXlWYVQyNFVFcE9ZWHE2VEhpQXpTUFl1Qm5DYTE5?=
 =?utf-8?B?V0JUVjBCV1NhQTc5emxTL3kvekNOZmZWdkw4MFIrSVFFRmVOVE1LU2phc2JR?=
 =?utf-8?B?VkhEZGx5Y05jZHMrRmFuNGRqaGMwTzdPTHYyTHBsU0NYazdiWGZwT2phaE5o?=
 =?utf-8?B?aTIvclFUZVdtOVNXTi9QZXliTTh0NUZnc3paLzNaQWlXbUdTN3dkOWVCb0hJ?=
 =?utf-8?B?Z2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5542.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e60885d6-0372-43f1-03bb-08dbbf29b599
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 07:16:46.3757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J9bDEbY1fL7P2v8nI/fizYzRzGgJwrVmsgYn4CFAFHw+QjhgRXhZyGxjksgZUCqPtlriGGF7vwsuahAXzDQqjDOfVGcqGzwuSt+Xi6Y8I04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9639
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Sep 2023 07:16:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13236

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFuIEtpc3prYSA8amFu
Lmtpc3prYUBzaWVtZW5zLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMjcsIDIw
MjMgMTI6MzQgUE0NCj4gVG86IHB5bGEgdmVua2F0YSjvvLTvvLPvvKnvvLAgVE1JRUMgT0RHIFBv
cnRpbmcpIDxWZW5rYXRhLlB5bGFAdG9zaGliYS0NCj4gdHNpcC5jb20+OyBjaXAtZGV2QGxpc3Rz
LmNpcC1wcm9qZWN0Lm9yZw0KPiBDYzogZGluZXNoIGt1bWFyKO+8tO+8s++8qe+8sCBUTUlFQyBP
REcgUG9ydGluZykgPGRpbmVzaC5rdW1hckB0b3NoaWJhLQ0KPiB0c2lwLmNvbT47IGhheWFzaGkg
a2F6dWhpcm8o5p6XIOWSjOWujyDvvKTvvK3vvKUg4peL77yk77yp77yn4pah77yt77yw77yz4peL
77yt77yw77yUKQ0KPiA8a2F6dWhpcm8zLmhheWFzaGlAdG9zaGliYS5jby5qcD4NCj4gU3ViamVj
dDogUmU6IFtpc2FyLWNpcC1jb3JlIHYzIDIvMl0gY29uZi9kaXN0cm8vY2lwLWNvcmUtY29tbW9u
LmluYzogU2V0DQo+IGRvc2ZzdG9vbHMgYXMgYnVpbGQgZGVwZW5kZW5jeQ0KPiANCj4gT24gMjYu
MDkuMjMgMTg6NDAsIHZlbmthdGEucHlsYUB0b3NoaWJhLXRzaXAuY29tIHdyb3RlOg0KPiA+IEZy
b206IHZlbmthdGEgcHlsYSA8dmVua2F0YS5weWxhQHRvc2hpYmEtdHNpcC5jb20+DQo+ID4NCj4g
PiBjdXN0b20gZG9zZnN0b29scyBpcyBpbmNsdWRlZCB3aXRoIGZpeCB0aGF0IHdpbGwgaGVscCBj
cmVhdGUgRE9TDQo+ID4gaW1hZ2VzIHJlcHJvZHVjaWJseS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IHZlbmthdGEgcHlsYSA8dmVua2F0YS5weWxhQHRvc2hpYmEtdHNpcC5jb20+DQo+ID4gLS0t
DQo+ID4gIGNvbmYvZGlzdHJvL2NpcC1jb3JlLWNvbW1vbi5pbmMgfCAxICsNCj4gPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvY29uZi9kaXN0
cm8vY2lwLWNvcmUtY29tbW9uLmluYw0KPiA+IGIvY29uZi9kaXN0cm8vY2lwLWNvcmUtY29tbW9u
LmluYyBpbmRleCA1ZDNjZTEwLi41YTE1OGYyIDEwMDY0NA0KPiA+IC0tLSBhL2NvbmYvZGlzdHJv
L2NpcC1jb3JlLWNvbW1vbi5pbmMNCj4gPiArKysgYi9jb25mL2Rpc3Ryby9jaXAtY29yZS1jb21t
b24uaW5jDQo+ID4gQEAgLTE0LDMgKzE0LDQgQEAgS0VSTkVMX05BTUUgPz0gImNpcCINCj4gPiAg
V0tTX0ZJTEUgPz0gIiR7TUFDSElORX0ud2tzIg0KPiA+DQo+ID4gIENJUF9JTUFHRV9PUFRJT05T
ID89ICIiDQo+ID4gK0lNQUdFUl9CVUlMRF9ERVBTID89ICJkb3Nmc3Rvb2xzIg0KPiANCj4gVW5m
b3J0dW5hdGVseSwgdGhlIHBhdGNoIGRvZXMgbm90IGFwcGx5IHRvIHRoZSBidXN0ZXIgdmVyc2lv
biBvZiBkb3Nmc3Rvb2xzLA0KPiBzZWUgZS5nLg0KPiBodHRwczovL2dpdGxhYi5jb20vY2lwLXBy
b2plY3QvY2lwLWNvcmUvaXNhci1jaXAtY29yZS8tL2pvYnMvNTE3MjcwNjgxNy4NCj4gV2UgZWl0
aGVyIG5lZWQgYW4gYWRqdXN0ZWQgcGF0Y2ggZm9yIHRoYXQgcmVsZWFzZSBvciBuZWVkIHRvIHNr
aXAgYnVzdGVyLg0KDQpzb3JyeSBJIGRpZG4ndCBjaGVjayB0aGlzIGluIGJ1c3RlciBiZWZvcmUg
c2VuZGluZyB0aGlzIHBhdGNoLCANCkkgdGhpbmsgaXQgaXMgYmV0dGVyIHRvIHNraXAgZm9yIGJ1
c3RlciwgYXMgcmVwcm9kdWNpYmxlIGJ1aWxkcyBhcmUgbm90IGFjaGlldmFibGUgaW4gYnVzdGVy
IGFuZCBzbyBpdCBpcyBub3QgaW1wb3J0YW50Lg0KDQpMZXQgbWUgc2tpcCB0aGlzIGluIHY0Lg0K
DQo+IA0KPiBKYW4NCj4gDQo+IC0tDQo+IFNpZW1lbnMgQUcsIFRlY2hub2xvZ3kNCj4gTGludXgg
RXhwZXJ0IENlbnRlcg0K


