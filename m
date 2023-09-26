Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEB3E81810
	for <webhook@archiver.kernel.org>; Tue, 26 Sep 2023 01:40:05 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.9617.1695692396480096863
 for <cip-dev@lists.cip-project.org>;
 Mon, 25 Sep 2023 18:39:57 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 38Q1drM53721330; Tue, 26 Sep 2023 10:39:54 +0900
X-Iguazu-Qid: 2yAa6hjhDNTHQoFZUA
X-Iguazu-QSIG: v=2; s=0; t=1695692393; q=2yAa6hjhDNTHQoFZUA; m=wlwSkVLPxfwvaPJgzTQszXyx0gSAUI5KRM/PHGXoJCg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 38Q1dqQX4037889
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 26 Sep 2023 10:39:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmugbD25U13FF4j4N51cAvby7M4kx3gUQopp/Ul0IAVoky7lZ6UUjBFBablVYuUV1tsQXjTE7mHpWkY1eGmuzbAdCC9nj4moTvcmoXPqG668jT+f9F2AbMkvkjMfey1AEgZmlksmRYD3uoxC3XHVwdPBdKAqKsYjhJ+aWAdaWiBIaC2h9CNvPyCOqhlusE4JuOymvN+4D0rmeEnTjKfYQlVcdlX5KATmpsgeSNR1cH0AaqHNuBL/GgY2Kp/xoMkli6eEgl2qhkRDE/JzKeRz2OC6M2V0lXN09mRZbEtkddW/uaVoce4TNRHczvi6zvG2H2Qz75zUtgSfiCK4V2KJJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B57ePOib6eSHlBNvfSzvm78lGdc5IzEfzJg42Da9FME=;
 b=fKbMWXuMZdcnWBzUvSElmU9cbfQ2iMUnAft/lcNt+9Y/pRzn/a53ZgS7732Vv6JNITqNY+qy7ceHpfE7beO8HHe3FPDQKJ/LWSdVwvnAoL9r8SzT+EP0KirghzcKyi580lFRn2t5Y3DHBqDbS105fwu7a1/h3J4sS+LDkptTCO6UoXakEK09puiQrZQ1zU1o8DVTkTcEi5in6esvrKMWgCyRpWVTF9Kp5zeSV4KtmmlTaaWbTEpS+EkSaPmoY/9p8G0NjTRDvNkJxJgwE7HK1DvoxQe7Pom45EPPd9z1gmvrMvMgNTnWfDcg5f4lVPEn8mVlbzDeGDyjeN3qFemWfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-dev] [isar-cip-core v2 2/2] images: Add dosfstools as
 DEPENDENCY to all images
Thread-Topic: [cip-dev] [isar-cip-core v2 2/2] images: Add dosfstools as
 DEPENDENCY to all images
Thread-Index: AQHZ79GGhLKVE9lXv0qVxVfC45Iv2bArx3YAgACLvPA=
Date: Tue, 26 Sep 2023 01:39:49 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSYPR01MB55424C7B8414E7DC51BA0B72A4C3A@OSYPR01MB5542.jpnprd01.prod.outlook.com>
References: <51a07da1-b0a1-4a3b-b463-739e3ea208f2@siemens.com>
 <20230925165833.2696-3-venkata.pyla@toshiba-tsip.com>
 <ce684bce-a09d-4313-b231-132737797f21@siemens.com>
In-Reply-To: <ce684bce-a09d-4313-b231-132737797f21@siemens.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5542:EE_|TYCPR01MB5630:EE_
x-ms-office365-filtering-correlation-id: 65d2910e-4da3-44e3-2c9c-08dbbe317946
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 7RJ/vY8GCGZ1Yn8TvTdbPo4T98BMsUMGzw3FjoFI9F9TbIX/q64/dlNvoSLayOD4pUGjib3s7xs9Jkd/JXF4oaCWu/8z6DNkGjSGyv76hydJnd7cbtbXZFNR9e16V6KfcG6Gyn2GKgbgnQBveqpi0AuQvYD4SzuCbXdv+KIpbgf6Cnp6DGF18F/0Qah3tMGQFQRSylFMyGB2OHPCRsefJ+hSjN2YU4MqlfzoOUQTwVnhFVHj22iskJ6kXHw31+d75o2ajles8ec8inP0gVQzb1h6/tGefpVGjm6T3aU0gstgp3Wat7+7PI7J1EWshFhQRgnkMlPGsPr8Az/XPhvFZPBovjVIbtkAbaAhy5mmrVmxXlUljH/nUhLw+oNr6gmEN64BIUpmVI1SKTaoBao2jxe3+Kpryhum/PndFJ+B0BeTekyh1707reCmkwJtUemLI+gXdqWf5LqVkpsWZnjVPoSM9+ZY6KroQfqkm2vpB8nCpM/W396d8ljRTVZtz6AXpRjiC0mXKBylFPhMG25aYpPCj1xeO3xMt/bi2h4vrPcJT9iHK1p79i3uhU20VX9pEHkrdz+xCAVQQ1p/GXX7VbvuQ1vtPvSQ2zEKiCOGe39zlwPHwgrQ8p30wtTU06es
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5542.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(346002)(136003)(366004)(230922051799003)(1800799009)(186009)(451199024)(76116006)(55016003)(107886003)(8676002)(4326008)(8936002)(316002)(66556008)(52536014)(478600001)(41300700001)(110136005)(83380400001)(66946007)(64756008)(54906003)(66446008)(5660300002)(9686003)(53546011)(2906002)(66476007)(7696005)(6506007)(71200400001)(86362001)(85182001)(33656002)(38070700005)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?clVqeHlDVmYrcEhrNmFIcXF2N08ya3NJK21qZWFCRTZFQlU0TTB6OXVWRVRh?=
 =?utf-8?B?YUF2elhXVGp6U25iYXY3aWZsQTBGMGVyWlF6L3VqeWZ5VU9tZEtzUkc1UzY0?=
 =?utf-8?B?b1pYNm45cVg5Q2tOR0Y4RnVTS0R2Mjg1Tk5GV21hMnNkY1MvWGczMHJ1MXpN?=
 =?utf-8?B?UjV5ZVhvS1pRbVhmWFdKRHQwUEN3RHN4QVN0RzFQazh0RUo3R0tTYmlpMDF6?=
 =?utf-8?B?RmF0dWJNbFVaZDVPc0Vua0tEb0g0NW0wYmRvWHgxYndRdUhodGJIdVVEYlM0?=
 =?utf-8?B?SXoyRUZwdmVEN1ZmNy9uV1JzMkg2TFoyL1RFbS9GR1FxajRlbzd2UHN0UEli?=
 =?utf-8?B?STRUMDdOMExxQUI3eVRleW50RkdrbEdMVFhVTmVRK3VHWUJ4dmo4NVpqL01z?=
 =?utf-8?B?WHl1OWtyc01NRHB3aDBqQ0M1OGx2dmE4a3BqdjB5SVBhTG9USDJoTUpaQnVl?=
 =?utf-8?B?UlJsakFZS3RPaWtMMTgxUDJPS3plc2xKSEwySkQwc1VYWjUzd25BcXNLMTVC?=
 =?utf-8?B?RXhUYS9iYUZNaytsTmwrRnBneEI2T2pjR3JnRHBicjgwWjRFV1VzNVgvRlpX?=
 =?utf-8?B?Y2pQZDArd0VrRjh6U3N2R3hhbVcycFRyeng2R2YyNHZ4QytPNGk0TVhyRnNC?=
 =?utf-8?B?dWRhUzRDQ2p0dkM5bHJmSFNqZ0FoZGdxdGlGRW9wWnhnMVEzUDZ4RWlNTXUz?=
 =?utf-8?B?QVBLUnoyaGxYVm9aTlVTbTZTa1NMMHFWSytKeUgyVFFPTWFiaXg0alpDeTlS?=
 =?utf-8?B?Wi9BY05MQVFkSVk4WXVsb3BCY1NyQzNJNVpRaEVuUWpJLzcrQXMxUGZFMFcv?=
 =?utf-8?B?ZDQ4MEg2M054YTU2ck12VHlVdnhpNWh0RUVidzQrQjVsUHNHNFFMLzlWZHZR?=
 =?utf-8?B?QnRDOTk0YUFxaURPUThnWnZhUTB0QzlWQXExK3ZTeFE0K0VPWUhHN1BZeUFM?=
 =?utf-8?B?Vlc5b1o5NGlJSnQzdGxYampYK09TNkhZQkFnWnc4dzM0RGZ0cG1IYVF5SXFy?=
 =?utf-8?B?cHFDeEI1bWlxT0pwS1QyRWZTT1hFNStwTCtyYVplYnZHaG1qRWxFZ2xOZ0lu?=
 =?utf-8?B?OTNZK1JWTnhPOEN4K1lMZUJhQkpKM24zTlhEaVZaQ3NsR2ZkTDRxZHkraDFa?=
 =?utf-8?B?SzhQa1d5QnFod2tRM09BbE1kQllGRis4VlE3OFBBMlAwbXRtQkJCTDlwNmcz?=
 =?utf-8?B?RFlraGhBeHlUVG1waWpjL2V6elVnK0VtKzdwcVNGeWdVdGhBbnFwTGtON3Bm?=
 =?utf-8?B?UWtwejBnelprVG1OK2lKaUx5MnBTdjUzWVowaUNGblNaUWh0aVJvQ1FQQ3FP?=
 =?utf-8?B?ZWJVVEdyOEQ5SlJMbmdYay9wdG55aHdNL3hNU1AyWEFxbk4xNkFKdUpNbm9v?=
 =?utf-8?B?ZWIra2VtOFgwYmRxKzRSZnQzUFFKTysxbFdQbHJ3QUdRYUgvZkhVb20waGhx?=
 =?utf-8?B?ekppVnJGL1ZHOW1DVHdJR1ZNMHRySEFPSjZTYm9uZlgzVmFCWUJXdGVDUUZH?=
 =?utf-8?B?MWpsZ2wzc202ZFNzVlg1NHlJaVI5UWV3QWsybk96dW45cVNYUDhQQ0lmTTQx?=
 =?utf-8?B?enUrNnkzWlhmamYzNDBOZkRGWmlaUVdvb2YvM1V3QU13M3g2RzJzK094TFhP?=
 =?utf-8?B?SncwRzh1eWI0THMxbUEzL3NRYXVuRWlYVXZpZ0M3d1BsL2xodThpd3gyRjBQ?=
 =?utf-8?B?TjJJRGloR05namN0RG9OMnhyU2MxWm9Eb2U1d2VNMG44SWlOaWxOS3ByQW5k?=
 =?utf-8?B?cVJEOEZ2dHdVWlZ1cGtJRTBTclZ3WE9tM0pFVDAySU9YcjFvVkl2c1lxanhK?=
 =?utf-8?B?SnRkc1RLM1dtR0FraVF6aEkxL2ZZU2c4M3Y1WjJ0Unk1WThjMnJHckdtNUZC?=
 =?utf-8?B?MjAraW9sM0paSHJCRSt3bFhKS1ZtdWxHL2QwZGQ2Z2pOMkpEd0UwdTN3RjhI?=
 =?utf-8?B?eGswWHlXRlVpUW5vRnBPNWhXVXlyYnB2MUhORkhzZTZ0YnpRbFhlTEgySG9H?=
 =?utf-8?B?TFRkV3A4YUI2RmIzL3psd0RWb3l3azlKS0VTR3M4azNZSlF0cGF2M3BOQVpo?=
 =?utf-8?B?OFFDSm14V1M4azUrM3RFRDV3WFpEUDFPYlNyc2llbnhYMDN4Y2trNWIyWm8x?=
 =?utf-8?B?QWlPQ1d3bzRPeDd0M2tzeTc2RzR2RVdvaWR1WlBsTGMyZ0pVQURMNjBIWnFW?=
 =?utf-8?B?d1FXU0FBU1BtQWdFNjdZRjZUaXRFV3VsZUdCUWpUM05QbUJTa0xRMGVDSEFi?=
 =?utf-8?B?Vi8vSW0xYmg0eDZRT2JwL3F6NVVRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5542.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d2910e-4da3-44e3-2c9c-08dbbe317946
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 01:39:49.9809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ef2hzkBdFPdf6dctEmvLsB0G2k/b03ygOyLMRZxz6BR4Gerx606d5rq4UEtYn16uGG4SC3JzKbntbYtd1T8i0+RJrAgd1aqR3U7CbhoH4Uw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5630
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Sep 2023 01:40:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13223

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0cy5j
aXAtcHJvamVjdC5vcmcgPGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPiBPbiBCZWhhbGYN
Cj4gT2YgSmFuIEtpc3prYSB2aWEgbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IFNlbnQ6IE1vbmRh
eSwgU2VwdGVtYmVyIDI1LCAyMDIzIDEwOjQzIFBNDQo+IFRvOiBweWxhIHZlbmthdGEo77y077yz
77yp77ywIFRNSUVDIE9ERyBQb3J0aW5nKSA8VmVua2F0YS5QeWxhQHRvc2hpYmEtDQo+IHRzaXAu
Y29tPjsgY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gQ2M6IGRpbmVzaCBrdW1hcijv
vLTvvLPvvKnvvLAgVE1JRUMgT0RHIFBvcnRpbmcpIDxkaW5lc2gua3VtYXJAdG9zaGliYS0NCj4g
dHNpcC5jb20+OyBoYXlhc2hpIGthenVoaXJvKOaelyDlkozlro8g77yk77yt77ylIOKXi++8pO+8
qe+8p+KWoe+8re+8sO+8s+KXi++8re+8sO+8lCkNCj4gPGthenVoaXJvMy5oYXlhc2hpQHRvc2hp
YmEuY28uanA+DQo+IFN1YmplY3Q6IFJlOiBbY2lwLWRldl0gW2lzYXItY2lwLWNvcmUgdjIgMi8y
XSBpbWFnZXM6IEFkZCBkb3Nmc3Rvb2xzIGFzDQo+IERFUEVOREVOQ1kgdG8gYWxsIGltYWdlcw0K
PiANCj4gT24gMjUuMDkuMjMgMTg6NTgsIHZlbmthdGEucHlsYUB0b3NoaWJhLXRzaXAuY29tIHdy
b3RlOg0KPiA+IEZyb206IHZlbmthdGEgcHlsYSA8dmVua2F0YS5weWxhQHRvc2hpYmEtdHNpcC5j
b20+DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiB2ZW5rYXRhIHB5bGEgPHZlbmthdGEucHlsYUB0
b3NoaWJhLXRzaXAuY29tPg0KPiA+IC0tLQ0KPiA+ICByZWNpcGVzLWNvcmUvaW1hZ2VzL2NpcC1j
b3JlLWltYWdlLWtlcm5lbGNpLmJiIHwgIDEgKw0KPiA+IHJlY2lwZXMtY29yZS9pbWFnZXMvY2lw
LWNvcmUtaW1hZ2Utc2VjdXJpdHkuYmIgfCAgMSArDQo+ID4gIHJlY2lwZXMtY29yZS9pbWFnZXMv
Y2lwLWNvcmUtaW1hZ2UuYmIgICAgICAgICAgfCAgMSArDQo+ID4gIHJlY2lwZXMtY29yZS9pbWFn
ZXMvY29tbW9uLWltYWdlLmluYyAgICAgICAgICAgfCAxMyArKysrKysrKysrKysrDQo+ID4gIDQg
ZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQg
cmVjaXBlcy1jb3JlL2ltYWdlcy9jb21tb24taW1hZ2UuaW5jDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvcmVjaXBlcy1jb3JlL2ltYWdlcy9jaXAtY29yZS1pbWFnZS1rZXJuZWxjaS5iYg0KPiA+IGIv
cmVjaXBlcy1jb3JlL2ltYWdlcy9jaXAtY29yZS1pbWFnZS1rZXJuZWxjaS5iYg0KPiA+IGluZGV4
IDQ3OWMxNGMuLjhhNThlN2IgMTAwNjQ0DQo+ID4gLS0tIGEvcmVjaXBlcy1jb3JlL2ltYWdlcy9j
aXAtY29yZS1pbWFnZS1rZXJuZWxjaS5iYg0KPiA+ICsrKyBiL3JlY2lwZXMtY29yZS9pbWFnZXMv
Y2lwLWNvcmUtaW1hZ2Uta2VybmVsY2kuYmINCj4gPiBAQCAtMTAsNiArMTAsNyBAQA0KPiA+ICAj
DQo+ID4NCj4gPiAgaW5oZXJpdCBpbWFnZQ0KPiA+ICtyZXF1aXJlIGNvbW1vbi1pbWFnZS5pbmMN
Cj4gPg0KPiA+ICBERVNDUklQVElPTiA9ICJDSVAgQ29yZSBpbWFnZSBmb3IgS2VybmVsQ0kiDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvcmVjaXBlcy1jb3JlL2ltYWdlcy9jaXAtY29yZS1pbWFnZS1z
ZWN1cml0eS5iYg0KPiA+IGIvcmVjaXBlcy1jb3JlL2ltYWdlcy9jaXAtY29yZS1pbWFnZS1zZWN1
cml0eS5iYg0KPiA+IGluZGV4IDM0MjFjZTUuLmYxMTQ5NzQgMTAwNjQ0DQo+ID4gLS0tIGEvcmVj
aXBlcy1jb3JlL2ltYWdlcy9jaXAtY29yZS1pbWFnZS1zZWN1cml0eS5iYg0KPiA+ICsrKyBiL3Jl
Y2lwZXMtY29yZS9pbWFnZXMvY2lwLWNvcmUtaW1hZ2Utc2VjdXJpdHkuYmINCj4gPiBAQCAtMTAs
NiArMTAsNyBAQA0KPiA+ICAjDQo+ID4NCj4gPiAgaW5oZXJpdCBpbWFnZQ0KPiA+ICtyZXF1aXJl
IGNvbW1vbi1pbWFnZS5pbmMNCj4gPg0KPiA+ICBERVNDUklQVElPTiA9ICJDSVAgQ29yZSBpbWFn
ZSBpbmNsdWRpbmcgc2VjdXJpdHkgcGFja2FnZXMiDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvcmVj
aXBlcy1jb3JlL2ltYWdlcy9jaXAtY29yZS1pbWFnZS5iYg0KPiA+IGIvcmVjaXBlcy1jb3JlL2lt
YWdlcy9jaXAtY29yZS1pbWFnZS5iYg0KPiA+IGluZGV4IDBlYzcyMjAuLjcxMWQzZDMgMTAwNjQ0
DQo+ID4gLS0tIGEvcmVjaXBlcy1jb3JlL2ltYWdlcy9jaXAtY29yZS1pbWFnZS5iYg0KPiA+ICsr
KyBiL3JlY2lwZXMtY29yZS9pbWFnZXMvY2lwLWNvcmUtaW1hZ2UuYmINCj4gPiBAQCAtMTAsNiAr
MTAsNyBAQA0KPiA+ICAjDQo+ID4NCj4gPiAgaW5oZXJpdCBpbWFnZQ0KPiA+ICtyZXF1aXJlIGNv
bW1vbi1pbWFnZS5pbmMNCj4gPg0KPiA+ICBJU0FSX1JFTEVBU0VfQ01EID0gImdpdCAtQyAke0xB
WUVSRElSX2NpcC1jb3JlfSBkZXNjcmliZSAtLXRhZ3MgLS1kaXJ0eSAtLQ0KPiBhbHdheXMgLS1t
YXRjaCAndlswLTldLlswLTldKiciDQo+ID4gIERFU0NSSVBUSU9OID0gIkNJUCBDb3JlIGltYWdl
Ig0KPiA+IGRpZmYgLS1naXQgYS9yZWNpcGVzLWNvcmUvaW1hZ2VzL2NvbW1vbi1pbWFnZS5pbmMN
Cj4gPiBiL3JlY2lwZXMtY29yZS9pbWFnZXMvY29tbW9uLWltYWdlLmluYw0KPiA+IG5ldyBmaWxl
IG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMC4uODYzZjgxNw0KPiA+IC0tLSAvZGV2L251
bGwNCj4gPiArKysgYi9yZWNpcGVzLWNvcmUvaW1hZ2VzL2NvbW1vbi1pbWFnZS5pbmMNCj4gPiBA
QCAtMCwwICsxLDEzIEBADQo+ID4gKyMNCj4gPiArIyBDSVAgQ29yZSwgZ2VuZXJpYyBwcm9maWxl
DQo+ID4gKyMNCj4gPiArIyBDb3B5cmlnaHQgKGMpIFRvc2hpYmEgQ29ycG9yYXRpb24gMjAyMyAj
ICMgQXV0aG9yczoNCj4gPiArIyAgVmVua2F0YSBQeWxhIDx2ZW5rYXRhLnB5bGFAdG9zaGliYS10
c2lwLmNvbT4gIyAjDQo+ID4gK1NQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBNSVQgIw0KPiA+ICsN
Cj4gPiArIyBJbnN0YWxsIGluIGJ1aWxkIHN5c3RlbSBmb3IgY3JlYXRpbmcgcmVwcm9kdWNpYmxl
IERPUyBmaWxlc3lzdGVtcw0KPiA+ICtERVBFTkRTICs9ICJkb3Nmc3Rvb2xzIg0KPiANCj4gV2h5
IHRoaXMgbm93PyBQYXRjaCAxIGlzIGFkZGluZyBpdCBhcyBJTUFHRVNfQlVJTERfREVQUywgYW5k
IHRoYXQgc2hvdWxkDQo+IGJlIGVub3VnaCBhcyB5b3UgY29ycmVjdGx5IGFuYWx5emVkLiBEbyB3
ZSB3YW50IHRoYXQgY2hhbmdlIHJhdGhlciBpbg0KPiBjb25mL2Rpc3Ryby9jaXAtY29yZS1jb21t
b24uaW5jPw0KDQpJdCBpcyBub3QgcmVxdWlyZWQ7IEkgd2FzIGNvbmZ1c2VkIHRoZW4gd2l0aCB5
b3VyIGNvbW1lbnQgSSB0aG91Z2h0IHlvdSBhcmUgZXhwZWN0aW5nIHRoaXMgY2hhbmdlIGZvciBz
b21lIHJlYXNvbi4NCg0KSWYgeW91IGFncmVlIHlvdSBjYW4gZGlzY2FyZCB0aGUgUGF0Y2ggMi4N
Cg0KPiBKYW4NCj4gDQo+IC0tDQo+IFNpZW1lbnMgQUcsIFRlY2hub2xvZ3kNCj4gTGludXggRXhw
ZXJ0IENlbnRlcg0KDQo=


