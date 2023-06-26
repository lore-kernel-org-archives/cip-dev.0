Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E19EB64D7
	for <webhook@archiver.kernel.org>; Mon, 26 Jun 2023 05:13:11 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.1435.1687756384666661056
 for <cip-dev@lists.cip-project.org>;
 Sun, 25 Jun 2023 22:13:05 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 35Q5D1Rl385776; Mon, 26 Jun 2023 14:13:02 +0900
X-Iguazu-Qid: 2rWgXcqnznDohvqiun
X-Iguazu-QSIG: v=2; s=0; t=1687756381; q=2rWgXcqnznDohvqiun; m=HXZvzSlPJ/u9UY9EHLMDkQWkv0ZMhupsv/6UzQvRp1c=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 35Q5D0ei2035983
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 26 Jun 2023 14:13:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROdIo4kwvzWV4xiwoZxX+9neiA363Y7yeC/soEERLwecpTes65o+9z14TY/OqOx+5xVT1GLzF7OB2DWINxtohG7N0o2w10dUILHFDlDYCTLR5KGehjUauslQWmkPT7QJJdiHcQc7RUTRHawOjqH4aCRxvpEMv3bQzU6MS/9XuifV/aXThWXvMKD/rQAiSIjvSB2MYlJPVMkqopgRmCL0XR417d+qV4dXGhQTH/6O7r5caNGvVIPwd5rHOyH4RJZ0j8uk1ZhBBhz5q9r9K0iV4RfaA55OqD8s79h0yuuztxaaM/ZNle5vJtQmLsCpyTNCUXNGRpM7V4itDA9NOVE9nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNpf8i5DwScwaN3/QKL1kNBq+2oSUk6Z5Prt5ygC6a0=;
 b=D71LNe5mTbX2RHqRNdX1xm4OGCDy2G1hyypjQQYmASsycbU1oHX5iHB2POnQL1sdD96JHBtPaG0HSm5U0pIC/I8BPl8oeJGUnmMfAZc60Hl0Lnvjdy5mXaKAz+geX2R0SZuazLXdDtAhAb20RxI/OpGwt6eLAYXpNsU157DrYswJdZHAMUaCyel6fw+i6RdtYCW/Fg6XnGWE/WH8PsakurqCQsuTUHfndfsdDbV+Y3WSIRwoJd5xithic0MAEU4XDzbknvOfKByJJy7BGOP9VNCgwF8I6c+ftQvhL7n+SR0j1rmNeuLQ102BjtUp1KpoBJ0Q3IfTx8HtEKcHXlvyBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-dev] [isar-cip-core 1/3] .reproducible-check-ci.yml: Add
 swupdate targets in reproducible check
Thread-Topic: [cip-dev] [isar-cip-core 1/3] .reproducible-check-ci.yml: Add
 swupdate targets in reproducible check
Thread-Index: AQHZpdvYVyUBxWUzukeNbnllEglKHa+bM1OAgAFQ53A=
Date: Mon, 26 Jun 2023 05:12:57 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSYPR01MB55424DCDB3D42B32B0E33896A426A@OSYPR01MB5542.jpnprd01.prod.outlook.com>
References: <20230623140555.11428-1-venkata.pyla@toshiba-tsip.com>
 <20230623140555.11428-2-venkata.pyla@toshiba-tsip.com>
 <3b7b1d9e-01fa-e9c8-063b-d44c4636dbe0@siemens.com>
In-Reply-To: <3b7b1d9e-01fa-e9c8-063b-d44c4636dbe0@siemens.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5542:EE_|OSZPR01MB7914:EE_
x-ms-office365-filtering-correlation-id: ea0920fc-5e09-4b8a-0a96-08db76040154
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 z85xFuSvC/L5EM582HXDxu0VOF/j0UTvhlpbuOEZ0XTffPuqvJWIPcQhOMzNaftmISjqehT5reXC8OIuphMqMl69sjft/iHNHAJEQobR9jb1E53vcZOQPnoAgS1wQ0EjD87xcfMvMa9aZzKYX0p9fWeSkqPVlrnyZ8aZvFiLPfLbRzwfH2k8JGB24gqro1UR7bd0KoWRFFeDFKrva8csrZ/+L7H6VVIUzKdqqYnOHoCQzym9HwyxGBYXjSkMbXpVH9W72O8r4d1Ml+pZiBTx0ZWN3xgxMXFyYVgmd7NdgBWU42gxzt9t9wlmtKfPI4UMEqoMNRidLN5A2DCl6znpNfS6zJ3KIl+8CZfmt9pq7lXHMb5A1js3jQ3moQ96gdjfjbQJKyyGe10wJoLj3lsq5V4jdxMtQdfccS9qMiBiFj3MQYLEhh936q9ZDd/bPrjS0yj7swIBkYcHhSzXjWVllThv0ghtsIxDNmk513sNxMF14WSjhyxsT3ZcWPUmE+4u2aDFCUHRJ4QA+fkPJvLSWXWYDg1RexrN+8V8jK36lOh58w+CwGgAwENgovqnSRyJea/fJ1GoSS1E2wE+qrGlSHznIuRS+pX7IzMWOgh8TZkS+nMqAdVHZF+gH93cIR01
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5542.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199021)(122000001)(38100700002)(38070700005)(83380400001)(85182001)(33656002)(86362001)(478600001)(54906003)(7696005)(71200400001)(41300700001)(55016003)(66476007)(66556008)(66946007)(316002)(8676002)(76116006)(8936002)(66446008)(64756008)(26005)(6916009)(4326008)(6506007)(186003)(107886003)(9686003)(2906002)(5660300002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VGNSWDNUQldFSTVrYkQ5VHZZWEhRS2JmM3A1VGlKOGZxZlBZYWxRalJVQjNR?=
 =?utf-8?B?S0hQRUM5NnIxREZpNHhYWGVvVlBGRmh6eWk1N25kZWxabDJlcWZLaEE1WkIv?=
 =?utf-8?B?V0FxYXBoem8rMHN5bm1kOFB3Y1NZTVd6NnovaCtRZ3hoYmRiTWdzaEtKQVF3?=
 =?utf-8?B?d0pCdzBOWVZ3TS9aT2xBbGZmTWpxaUhRbVZ6YjdxZzlyTm5RODJuQUtHc0tB?=
 =?utf-8?B?enA4U0JOZ2t5WWlUUWNNVytIa3pmdWtaSnFYWWMxcGhZY3Z3dVdlT3JtYmRp?=
 =?utf-8?B?TWtCOFUxRzc5MzZuRGpIZ3FDZE85TGdHUFN2UmpWdFYyVVYyRlNmODBrMUV6?=
 =?utf-8?B?ZFRiUlJ4eE1RWjdyYmtSdmxoTU82b0JPNUhDNzAvejVCMllkaGRCbkRLZlZQ?=
 =?utf-8?B?Q1hIcDNNUlFsbWRlZ2YyTmEzN3Y0aVhiUWtWWnI0MEJ6Um1kb2lrRUhzZXNz?=
 =?utf-8?B?NW1Vc09VZkprVkdFMFR4MWJWa1dudFZhaisvN1lpZm1XVUlaUWMxTkVNdkgx?=
 =?utf-8?B?T3dyWGlpOW9veEVsZVo5aFZRSWFML1JjMDlWaUllK2hsbUFlZmZpVGpUeGJt?=
 =?utf-8?B?OUtBNGRyYVVjdWl0V0w3MW5nOGUxaDFMQW8vaDBVRUNJZHhwdHl1UlJISXRY?=
 =?utf-8?B?OFB3a2xoZGk1WUVFMTM4TmJSNXJaeit2eWNYRFZkSlh2dnBReG82cEFmS1BH?=
 =?utf-8?B?Q0VkYlg3RVB2b1NpM2dLcDRxYUhZN05qaVZ1WGlvN1lvTXExdmUvQWVOMXJn?=
 =?utf-8?B?U092akFLb1ZJWVNkZDNrSjlWUDRKS09rMmVoUitRaE5vc3ZGYXNGMkZocFhR?=
 =?utf-8?B?NDBEY3dIS0RkOVlSNjFzTlJFT2tIOXRkWDc4cjUyTE55UFY3bkcyY1FwM0Ju?=
 =?utf-8?B?QWdVellxVDViVms1TzF1KzRxVWN1anM4NTRYZzVKU2xucmh6NWwwTlRXL3FZ?=
 =?utf-8?B?QitEaE5CbUFTMXZ5QjdTWithSlVwTEd3MVJ0ekZQUy9hRi9tbmtsUEFKaFdU?=
 =?utf-8?B?N1RRalVLOHNZQnBraFpEYTFMK0lWOFREYjg3MzVDWXVJTmJzenZBdDU5NnJP?=
 =?utf-8?B?UTFQazlYNE96bnNHU1cxSjVmL29CRVhnTFdPSTNQWDgzZTdFRlZpUVlEUGIz?=
 =?utf-8?B?N3BZekZIblJCOGRKaGl3ZnZrWnM3T09KYlhjbEtLaXFYdUJXRGlsbjYxdG9E?=
 =?utf-8?B?d01LU1BZZGJjSlZ1L1F0SXNMdjNYK29VM1lGaE9oWVNCN1JhRUdoV2tCNmxB?=
 =?utf-8?B?cUd6dk04ZExNVERYYmZFOStpK0k0eU1lZzRzTUgyN00xQndVT3RmbWtGVU9B?=
 =?utf-8?B?eUpCRW9SU2lXdzFjTVdWSndnWjk2UXpnZitRRHU3TFRjYy9oZ0k3dU9SeURP?=
 =?utf-8?B?dkhOdVEvL0JjM1hYVWpWMHdpTmUySXZnNU5sV3dDbkxTVkc3Wm95NWdCTU90?=
 =?utf-8?B?OFFUSGg1QlFhRmFDOVA5Nis4T2toaVUrUE9samlhY0JaM1FuWS8zL2tiaFZI?=
 =?utf-8?B?SDZWZGwvMmpEVmxqejJHYUhuWktWbUE2MUM3T3RuSXlOZ3ZqWEVyR0dyQ05k?=
 =?utf-8?B?Sy9tNkROalgyNEV0YmJxcTFNemtYUzI4MTloR3hYRDZDeUppbDIxaVhEaEln?=
 =?utf-8?B?bzNqY3dKT1lEQ25NNzNWZUxORlZEc0hWcXBvS1IycjY5b09kUUlCS2N5R2dL?=
 =?utf-8?B?dmgzRlRxMlpKdmVpUzF3akZySUdiLzZvTnhrNlpOdkZaeGV6Wi9Fam9TMU1U?=
 =?utf-8?B?ZWhnZ2o4ZXZjOTVlcDdYalM5SXpwT2JUTDhXWkZveXRoWDY4RXBSdTNUNW12?=
 =?utf-8?B?RXlSTS85TzNiUnBTMG9sNnVzT2RVa1lTZG5OM1h6ZmlxWVJKek1zM3dtODEz?=
 =?utf-8?B?V0N3bGNNMVBlblA0SGdiTkVRN3ZBYWVmR0FKeTlyVlJ1VHRmcjBmWmE1WVpD?=
 =?utf-8?B?cHppRmIzRm02bUlRWnB0cDdEMXdkb092VmlDWDBBMW9yUUZJazhSS3dFaHpW?=
 =?utf-8?B?ZEl6REQ4U1NwL2FHLzVQRHpnS3R5aVpoNnR1MzkzaEhZRWU1NSs5aXdmbThp?=
 =?utf-8?B?eTdsSlhodVdCdTlGSmhtSjJsRG80SHFrcnFINSt1aFBsL2oxUmlnWHVXL3Ja?=
 =?utf-8?B?UFpHVTJjOTBNN1Q1WmYxTHhSajdsdG44aFdHcW5QSENKM2ttY0ZlYWkxZHRi?=
 =?utf-8?B?ZkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5542.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea0920fc-5e09-4b8a-0a96-08db76040154
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 05:12:57.6942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /38Qo+rRHy+vi7BIpa1Pg0sjrwQlQKhFyhK6dnxOduaRH0ekOAQUqNuQritiZss2LirUU6il01lXTdHJyIFV2TRFJfqU4OuqztYi6o/mkZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7914
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 26 Jun 2023 05:13:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12152

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IGNpcC1kZXZAbGlzdHMuY2lw
LXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24gQmVoYWxmIE9m
DQo+SmFuIEtpc3prYSB2aWEgbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+U2VudDogU3VuZGF5LCBK
dW5lIDI1LCAyMDIzIDI6MDIgUE0NCj5UbzogcHlsYSB2ZW5rYXRhKO+8tO+8s++8qe+8sCBUTUlF
QyBPREcgUG9ydGluZykgPFZlbmthdGEuUHlsYUB0b3NoaWJhLQ0KPnRzaXAuY29tPjsgY2lwLWRl
dkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj5DYzogZGluZXNoIGt1bWFyKO+8tO+8s++8qe+8sCBU
TUlFQyBPREcgUG9ydGluZykgPGRpbmVzaC5rdW1hckB0b3NoaWJhLQ0KPnRzaXAuY29tPjsgaGF5
YXNoaSBrYXp1aGlybyjmnpcg5ZKM5a6PIO+8pO+8re+8pSDil4vvvKTvvKnvvKfilqHvvK3vvLDv
vLPil4vvvK3vvLDvvJQpDQo+PGthenVoaXJvMy5oYXlhc2hpQHRvc2hpYmEuY28uanA+DQo+U3Vi
amVjdDogUmU6IFtjaXAtZGV2XSBbaXNhci1jaXAtY29yZSAxLzNdIC5yZXByb2R1Y2libGUtY2hl
Y2stY2kueW1sOiBBZGQNCj5zd3VwZGF0ZSB0YXJnZXRzIGluIHJlcHJvZHVjaWJsZSBjaGVjaw0K
Pg0KPk9uIDIzLjA2LjIzIDE2OjA1LCB2ZW5rYXRhLnB5bGFAdG9zaGliYS10c2lwLmNvbSB3cm90
ZToNCj4+IEZyb206IHZlbmthdGEgcHlsYSA8dmVua2F0YS5weWxhQHRvc2hpYmEtdHNpcC5jb20+
DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogdmVua2F0YSBweWxhIDx2ZW5rYXRhLnB5bGFAdG9zaGli
YS10c2lwLmNvbT4NCj4+IC0tLQ0KPj4gIC5yZXByb2R1Y2libGUtY2hlY2stY2kueW1sIHwgNDkN
Cj4+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgMSBmaWxlIGNo
YW5nZWQsIDQ5IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvLnJlcHJvZHVjaWJs
ZS1jaGVjay1jaS55bWwgYi8ucmVwcm9kdWNpYmxlLWNoZWNrLWNpLnltbA0KPj4gaW5kZXggZDhi
ZmI0MC4uNWVhNzg1NyAxMDA2NDQNCj4+IC0tLSBhLy5yZXByb2R1Y2libGUtY2hlY2stY2kueW1s
DQo+PiArKysgYi8ucmVwcm9kdWNpYmxlLWNoZWNrLWNpLnltbA0KPj4gQEAgLTgyLDYgKzgyLDMw
IEBAIGJ1aWxkOnFlbXUtYXJtLWJhc2UtcmVwcm8tYnVpbGQ6DQo+PiAgICB2YXJpYWJsZXM6DQo+
PiAgICAgIHRhcmdldDogcWVtdS1hcm0NCj4+DQo+PiArYnVpbGQ6cWVtdS1hbWQ2NC1zd3VwZGF0
ZS1yZXByby1idWlsZDoNCj4+ICsgIGV4dGVuZHM6DQo+PiArICAgIC0gLnJlcHJvLWJ1aWxkDQo+
PiArICB2YXJpYWJsZXM6DQo+PiArICAgIHRhcmdldDogcWVtdS1hbWQ2NA0KPj4gKyAgICBleHRl
bnNpb246IGViZy1zd3UNCj4+ICsgICAgd2ljX3Rhcmd6OiBlbmFibGUNCj4+ICsNCj4+ICtidWls
ZDpxZW11LWFybTY0LXN3dXBkYXRlLXJlcHJvLWJ1aWxkOg0KPj4gKyAgZXh0ZW5kczoNCj4+ICsg
ICAgLSAucmVwcm8tYnVpbGQNCj4+ICsgIHZhcmlhYmxlczoNCj4+ICsgICAgdGFyZ2V0OiBxZW11
LWFybTY0DQo+PiArICAgIGV4dGVuc2lvbjogZWJnLXN3dQ0KPj4gKyAgICB3aWNfdGFyZ3o6IGVu
YWJsZQ0KPj4gKw0KPj4gK2J1aWxkOnFlbXUtYXJtLXN3dXBkYXRlLXJlcHJvLWJ1aWxkOg0KPj4g
KyAgZXh0ZW5kczoNCj4+ICsgICAgLSAucmVwcm8tYnVpbGQNCj4+ICsgIHZhcmlhYmxlczoNCj4+
ICsgICAgdGFyZ2V0OiBxZW11LWFybQ0KPj4gKyAgICBleHRlbnNpb246IGViZy1zd3UNCj4+ICsg
ICAgd2ljX3Rhcmd6OiBlbmFibGUNCj4+ICsNCj4+ICAjIHJlcHJvIGJ1aWxkIHRlc3QNCj4+ICB0
ZXN0OnFlbXUtYW1kNjQtYmFzZS1yZXByby10ZXN0Og0KPj4gICAgZXh0ZW5kczoNCj4+IEBAIC0x
MDYsMyArMTMwLDI4IEBAIHRlc3Q6cWVtdS1hcm0tYmFzZS1yZXByby10ZXN0Og0KPj4gICAgICB0
YXJnZXQ6IHFlbXUtYXJtDQo+PiAgICBkZXBlbmRlbmNpZXM6DQo+PiAgICAgIC0gYnVpbGQ6cWVt
dS1hcm0tYmFzZS1yZXByby1idWlsZA0KPj4gKw0KPj4gK3Rlc3Q6cWVtdS1hbWQ2NC1zd3VwZGF0
ZS1yZXByby10ZXN0Og0KPj4gKyAgZXh0ZW5kczoNCj4+ICsgICAgLSAucmVwcm8tdGVzdA0KPj4g
KyAgdmFyaWFibGVzOg0KPj4gKyAgICB0YXJnZXQ6IHFlbXUtYW1kNjQNCj4+ICsgIGRlcGVuZGVu
Y2llczoNCj4+ICsgICAgLSBidWlsZDpxZW11LWFtZDY0LXN3dXBkYXRlLXJlcHJvLWJ1aWxkDQo+
PiArDQo+PiArdGVzdDpxZW11LWFybTY0LXN3dXBkYXRlLXJlcHJvLXRlc3Q6DQo+PiArICBleHRl
bmRzOg0KPj4gKyAgICAtIC5yZXByby10ZXN0DQo+PiArICB2YXJpYWJsZXM6DQo+PiArICAgIHRh
cmdldDogcWVtdS1hcm02NA0KPj4gKyAgZGVwZW5kZW5jaWVzOg0KPj4gKyAgICAtIGJ1aWxkOnFl
bXUtYXJtNjQtc3d1cGRhdGUtcmVwcm8tYnVpbGQNCj4+ICsNCj4+ICt0ZXN0OnFlbXUtYXJtLXN3
dXBkYXRlLXJlcHJvLXRlc3Q6DQo+PiArICBleHRlbmRzOg0KPj4gKyAgICAtIC5yZXByby10ZXN0
DQo+PiArICB2YXJpYWJsZXM6DQo+PiArICAgIHRhcmdldDogcWVtdS1hcm0NCj4+ICsgIGRlcGVu
ZGVuY2llczoNCj4+ICsgICAgLSBidWlsZDpxZW11LWFybS1zd3VwZGF0ZS1yZXByby1idWlsZA0K
Pj4gKw0KPg0KPlRvIGtlZXAgYW4gZXllIG9uIG91ciBudW1iZXIgb2YgYnVpbGRzOiBEbyB0aGVz
ZSBuZXcgdGFyZ2V0cyBoYXBwZW4gdG8NCj5pbmNsdWRlIGFzcGVjdCBvZiBleGlzdGluZyBvbmVz
IGFuZCBjb3VsZCB0aGVyZWZvcmUgc3VwZXJzZWRlIHRoZW0/DQoNClllcywgeW91IHJpZ2h0bHkg
cG9pbnRlZCBvdXQsIHRoZSBiYXNlIGltYWdlIGNvbnRlbnRzIGFyZSBhbHNvIHZlcmlmaWVkIGFz
IHBhcnQgb2YgdGhlIG1vc3QgZmVhdHVyZSByaWNoIGltYWdlIChlLmcuLCA0IGluIGJlbG93IGlt
YWdlIHRhcmdldHMpDQptYXliZSB3ZSBjYW4gZHJvcCB0aGUgYmFzZSB0YXJnZXRzIG5vdywgaWYg
bm8gb2JqZWN0aW9ucyBJIHdpbGwgdXBkYXRlIHRoZW0gaW4gdjIgcGF0Y2guDQoNCjEuIEJhc2UN
CjIuIEJhc2UgKyBzd3VwZGF0ZQ0KMy4gQmFzZSArIHN3dXBkYXRlICsgc2VjdXJlYm9vdA0KNC4g
QmFzZSArIHN3dXBkYXRlICsgc2VjdXJlYm9vdCArIHNlY3VyaXR5IGV4dGVuc2lvbnMuDQoNCj4N
Cj5KYW4NCj4NCj4tLQ0KPlNpZW1lbnMgQUcsIFRlY2hub2xvZ3kNCj5Db21wZXRlbmNlIENlbnRl
ciBFbWJlZGRlZCBMaW51eA0KDQo=


