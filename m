Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7217CECAAD1
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 23:26:29 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web09.5981.1661988384852237404
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Aug 2022 16:26:25 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.154, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 27VNQEI0004746;
 Thu, 1 Sep 2022 08:26:15 +0900
X-Iguazu-Qid: 34tMLsHDkxgQFqUa2B
X-Iguazu-QSIG: v=2; s=0; t=1661988374; q=34tMLsHDkxgQFqUa2B;
 m=CQquv9BfUmTAqLuOhzRsDSopYlC8QoipMZ0BjrwYXiA=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1510) id 27VNQDfb012059
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 1 Sep 2022 08:26:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfQlEQ6vXF7LmJs8aELhMFnUJm9u+y5jWOk5+rIVu4mjVlRJ5YiexZebZig18wGwjBdiVuFJs5IaYKJ33Xdu4hT+MHvTxFxMfQPKucpQxGlPMDYBeT5w+UiNvaR1YB5Gw7ZKRD+2LuL66osHbEPGWjiSow+MJSDOZGj6kGCJY9eHnQoePV8icTLoVbZkgo8HE1MfIQc3PrfEzH6rrYx3W2tDCoCJrQee3LDoSjI3i8pGuSJHsIXl8CMRJFl3FwjNmEsf7IjaamvqPyhZU7Xq20123Au7KWoweg2Uvj99zl7+rkhrrE9iRiC1e+rMmTbk99gkThUC1czvN9ViD3YeFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3uBvE3HuY9Wsg5mRhwl4kqYKArphbeOpxYlVCgxsrc=;
 b=bSaM8AD81frICA4WuEdJs3QHRnhQqUGamLYkbhp6cvBQz8tF4Hs0awWy6QX8kALG9nUpb7SML1YTYprq2wIJfFP1/FdAX10nD3Ps8wOWikWuBQLR9GF9wMmApk26uCu0EkyCh+IkS3VaS04x1DFed5+JgiDSgkfoKXrCqoaYvLUVodMJJ5tODuwfLaWKgoPz+oN5VtTCIzSncflQ5qA4KhKKXiYtViGhM+8aJqQje5TOzbpwboAX/3xcwPDdhAcPVgqxNeq1i6UggYL5tjP7opSCzPIR3dc19CIjwfnyOjFeKOW+Wq/lSe5DAoD1UPaey8yKqEOj2l+2yKgEQHpY7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <chris.paterson2@renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip] drm: rcar-du: Fix Alpha blending issue on Gen3
Thread-Topic: [PATCH 5.10.y-cip] drm: rcar-du: Fix Alpha blending issue on
 Gen3
Thread-Index: AQHYvHvus7BQxJd7fECatwPPIO3KPq3JqMqQ
Date: Wed, 31 Aug 2022 23:26:10 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB942061A5BD6FE08C362CF81692789@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20220830142212.1269865-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20220830142212.1269865-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2fe731cf-da1c-4471-8cbc-08da8ba83045
x-ms-traffictypediagnostic: TYCPR01MB5757:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 UNAOI04vW0GnCiMaPeF2rIle9SOhPuOLSpc+4f2gvuKpPJ0C0kcFxU9NDWroIXw2lXTBKwmsG7tqTFs9ngyFsCnWV2gV+97jydyhOYQ5ouwK1n2m+5i+BQR1XSNPVdcyX88du2FRVYjp8M+5z9PbvWiT6ahcTv9T5PbrYtGLVO3yZlbEaRed4QsgEX1rTQkIe+ymZncvZj3P22b/VVG+qocFTh6SYJZrhsSQDCRf8nSFHHp8ITJJ+A+XxW2GbHXTc39ZGITN6OtUTfYEEd/LLQCDVE0pvTXmSAnfemmnzEUtMAka0ebt8vU0ln+wCzqGXIpLxlGPK52scaBPri6wWUfaKaR7+roJMYtIF+DkVKfN4K6E+lDCLr9OF+6BMi4hnLuasAVuxFlIis+afRk+qxGtTgpbd4P9/Vb8EPk+MRt54fIwmLbN70qFLUBsxdD4A4c9hZlgeAybGcPWf4rsx1Px0LFhpo+zHZJOTitzYkzLAH7XepqHorsH1N2F1M/RsKTcU9kNrmU4o2iitQadVbYoLieVIWdIHfZdrmJJ3yJDbnRE4yKfBjqEdtkNcheTehdC3xBI3uGibPSulpNSeC5ASX0kbC6Wwgc3Z+tDHYrm6Yrrpgnkl8lRm4B+StTXKbqbEjcn8yP8Du6JlbV4zv8oBKs5N7iJRDbCDtw+f+Q/wimGofgEXHsyp5EbyWBrEFAShQMJDAZxH4hadEJHR3TKklLrKhGNgM3JEWcFdtcwCj21Ed3osJIDIOVtSWYlnICozUn/Jo9B/FzS7J16tA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(38070700005)(41300700001)(52536014)(8936002)(71200400001)(86362001)(110136005)(316002)(54906003)(33656002)(66446008)(64756008)(66556008)(66476007)(478600001)(8676002)(4326008)(66946007)(76116006)(9686003)(26005)(186003)(53546011)(7696005)(83380400001)(2906002)(6506007)(122000001)(5660300002)(38100700002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?T0ZZcXJic2oraVNrcndhZVBrL3J0R0JCdzdWaDNaMWQ1SW1pNmhNeEM5K1d4?=
 =?utf-8?B?L05ERGJHbFpJbmZZc3djTm1XV3JoeWRpTm9weGIzeS9od3NDNnR5c3ZpWGlW?=
 =?utf-8?B?TjVPd3dYNm15QUY2Wng2eCt0TzJTdmV2U3lydjFCMlgyNG1YUjU3OWRyVnE0?=
 =?utf-8?B?a2RoMVo5WGJPdlplNGhLMUx4TWtQL01NMkJDaG5mbUc4dk5sUWt1QytjWEpD?=
 =?utf-8?B?dE9GMGxYYkhxVG03UXJJM3VKWUtNR0F4Y05KclF2d1NlcHlGMFYzU2ZWdUtB?=
 =?utf-8?B?UmlyM1NOU3NqZ3VQM09md3cyUFpUcm5DRkF4N0d2TUN6RnhmNVRIVmh5ZmtO?=
 =?utf-8?B?djJQcURvenNqUzhUTXBSWFBOZHRGdzdpVUlkNVdGOTFzQVVkYnNzaGNGWmh4?=
 =?utf-8?B?eDlVUlp0VzNzSUxMb2Q1cGw1aDM2bUxyZ3JGaHYxNEM4Z01OS0x0cWRBL1lI?=
 =?utf-8?B?ZitjTkZlNmJKL0VKNDduNGlyYXVRR08xUDhFK0I0d1ZRZm5wUy81MkNSZHkx?=
 =?utf-8?B?Q1BGdzU5K1A3S0VNQWVjdytRSVVJc2h1TUZ5NXFrLzQ0OVlXdUhkcE1uUlM1?=
 =?utf-8?B?Y05vc1hUQ3RPeU9QWUxPeDRQNUVONnhwVVdLaytHSWt1anZYS2FFT0tHa2My?=
 =?utf-8?B?aGRUc1ljNm5PcjVMT2NUZnNIenJ2QWxkNlBGSm1VSnZMRVNMM3lQM2dlVUVr?=
 =?utf-8?B?WGVsR0xtTFBacENDeXZwaHg3MjA0Y2d2MGhueklGREVwMFhoeTdDU0FhTW5p?=
 =?utf-8?B?aGMrK2pibEl6RW8wc3JTQ0ovcUFSSTgzZEVSNzhTdzFHL2tLWHRtNmpqMDd2?=
 =?utf-8?B?bTFWeFZUdkp4eHJrWkV2akp4RkRzMHZtZ3J5K3p2dnI3RFE0K2hyVEJrQ1lq?=
 =?utf-8?B?L1FOVTh2aWk4cEdKUHRYWGRocFBvbXEwWFNZZ1hPaFN4aE1oY2ZTRnpGdWFJ?=
 =?utf-8?B?dUx1QVJFMTMzVmJMQmt5VU1zaVVpTmxQazdXWmV1bmw1Q3liNHp6OUtnRFVr?=
 =?utf-8?B?NjVaWDhiaXhRZDY2V1NLNXdRVUpZdS91VTh5cTZWaXZwQmsySXhEcmUvVERR?=
 =?utf-8?B?Q016WlYvejluMG9yeHNCY1FyenE5VmZuRHZnbWpOWG9hYURKSHM0L0xuaHo3?=
 =?utf-8?B?QXpqWGs3MkJqK3ZkdWdEY2VSS3lBeUZEQnYzRlI1YlowZnAvN2JEczh1azJo?=
 =?utf-8?B?YUg0QTN1VnVHQzFueGFxckx2VWtIRzgrZlh5MWg1SHRlTTJsL1d4WjlLb0dm?=
 =?utf-8?B?Ly83S0xUWHFIdGZBaXhMRzY4Z2RIdjNLUFRZWHpWRjIxT2F6ZWtZeVg1ZzdH?=
 =?utf-8?B?clZxTkZCLzhiR1RsY2xXUVpFdUtqQTVQSGdJMjV2NUkzSVRvb2d5eXNoWmZv?=
 =?utf-8?B?Y3Roc01FdWgzc2tVM1hEMlhkRjMxNzlhRmJ1cU9HWEtyUGU3UVF2cTZoZW0v?=
 =?utf-8?B?N3R2MVJRZDBuRTRCRUJpWmY1b1pFeFJZTkRtUzcrTE5rZ2w5bEpkSzIyd1M2?=
 =?utf-8?B?aWFPOHBiSEkra2VqSER2R1FqZjFHRlc0M3pNZ09KRlBpZjBBbU5CN05yNTJN?=
 =?utf-8?B?ZnJaSFZTZW5EWXFKQVdiZ1ZPOENycmNGdVBCcVNiWXRYMjhLWFFEOVgxOW81?=
 =?utf-8?B?cTlVeGhxUnNOQ3k2cVV3L2F5MXJVYnRGakhSakdsbDNsZFpjMlpsVjhaRG1h?=
 =?utf-8?B?ZHVSVms2bjhOcm1jZmVZTW9mcDBFWmR6b0F5SXBiaVR3b2kxaUZQTGtMeTdo?=
 =?utf-8?B?TXBGT0JEUk5HU2F1dUdQcCtkODF6YU1PbmhkU0JLam1sd0daS3I1YUViS1d4?=
 =?utf-8?B?QVRucHBibHRqakJYOUJsOHBjY0c0d0lMUzFOd28wMzkxUlFtTTdsQmh6MGwr?=
 =?utf-8?B?NXdjcVpQVU85ajVEN3ZCMHQybkJWbldkMENxdTdQZDdZYkVybnlYU3JnN056?=
 =?utf-8?B?L2xrREh1TlYvUmZISGQ1ZEtHUC9XaWY1eGlGRkc3SWIvQ1lXOGtmN3RzdGp4?=
 =?utf-8?B?dDZ1ekVCdjBjVVhQRDVpZUJwOWNra3E1T1dOWHI3YWh0L1ZZUWFublo2QlE1?=
 =?utf-8?B?VHp4ZHdkY1VheFpNeCtsazBFSnliWkZXd2xEOWpOM0NLRHB3cUVxOEZENG8w?=
 =?utf-8?B?Z1RrbERrNTJZVDByWjRwQnM0VCsrU1RPdURBS253Z1V2S3VLcm9tT2RpQ0t1?=
 =?utf-8?B?cEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 2fe731cf-da1c-4471-8cbc-08da8ba83045
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 23:26:10.6352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 nZpODM9inF7mPqZN0byn92p+RigIt6Ampk4DF9OmbXaCidUfkgVEPS/klUwaEjFjaoYSBFiuFIoVkRAtk64SSv3DoMBQWMPevDd5jAoAzwlPL/D7MTGTznNJZor5f1CM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5757
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 23:26:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9396

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmlqdSBEYXMgPGJp
anUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgMzAsIDIw
MjIgMTE6MjIgUE0NCj4gVG86IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnOyBpd2FtYXRz
dSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKWoe+8s++8t++8o+KXr++8oQ0KPiDvvKPvvLQpIDxu
b2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD47IFBhdmVsIE1hY2hlaw0KPiA8cGF2ZWxA
ZGVueC5kZT4NCj4gQ2M6IENocmlzIFBhdGVyc29uIDxjaHJpcy5wYXRlcnNvbjJAcmVuZXNhcy5j
b20+OyBCaWp1IERhcw0KPiA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+OyBQcmFiaGFrYXIg
TWFoYWRldiBMYWQNCj4gPHByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbT4N
Cj4gU3ViamVjdDogW1BBVENIIDUuMTAueS1jaXBdIGRybTogcmNhci1kdTogRml4IEFscGhhIGJs
ZW5kaW5nIGlzc3VlIG9uIEdlbjMNCj4gDQo+IEZyb206IExVVSBIT0FJIDxob2FpLmx1dS51YkBy
ZW5lc2FzLmNvbT4NCj4gDQo+IGNvbW1pdCBiN2FhYTYxNzI2Y2JjN2I5NDEwMDdhZjE0YTlmOTkx
YTgyOGM2N2U0IHVwc3RyZWFtLg0KPiANCj4gQXMgcGVyIFItQ2FyLUdlbjNfQ29tbW9uX09QQ19D
dXN0b21lcl9Ob3RpZmljYXRpb25zX1YzMC4xLnBkZiwNCj4gdW5leHBlY3RlZCBpbWFnZSBvdXRw
dXQoc3VjaCBhcyBpbmNvcnJlY3QgY29sb3JzIG9yIHBsYW5lcyBiZWluZw0KPiBpbnZpc2libGUp
IGNhbiBoYXBwZW4gb24gdGhlIGJlbG93IGNvbmRpdGlvbnMsIGFzIFBuQUxQSEFSIHJlZ2lzdGVy
IGlzIG5vdA0KPiBpbml0aWFsaXplZCBieSByZXNldC4NCj4gDQo+IFdoZW4gYWxwaGEgYmxlbmRp
bmcgKFBwTVJtLlBwU1BJTT0wYjEwMSkgaXMgcGVyZm9ybWVkIGFuZDoNCj4gCeKAonR3byBQbGFu
ZXMgYXJlIGVuYWJsZWQgb24gYW55IERVbiAobj0wLDEsMiwzKQ0KPiAJCW9EU1BSbj0gMHgwMDAw
IDAwMzEgb3IgMHgwMDAwIDAwMTMNCj4gCeKAom9yIERVMCBhbmQgRFUxIGlzIHVzZWQgZm9yIGRp
c3BsYXkgYXQgdGhlIHNhbWUgdGltZQ0KPiAJCW9EU1BSMD0gMHgwMDAwIDAwMDEgYW5kIERTUFIx
PSAweDAwMDAgMDAwMw0KPiAJCW9EU1BSMD0gMHgwMDAwIDAwMDMgYW5kIERTUFIxPSAweDAwMDAg
MDAwMQ0KPiAJ4oCib3IgRFUyIGFuZCBEVTMoSDMgT25seSkgaXMgdXNlZCBmb3IgZGlzcGxheSBh
dCB0aGUgc2FtZSB0aW1lDQo+IAkJb0RTUFIyPSAweDAwMDAgMDAwMSBhbmQgRFNQUjM9IDB4MDAw
MCAwMDAzDQo+IAkJb0RTUFIyPSAweDAwMDAgMDAwMyBhbmQgRFNQUjM9IDB4MDAwMCAwMDAxDQo+
IA0KPiBUaGlzIHBhdGNoIHNldCBQbkFMUEhBUiByZWdpc3RlciB0byAwIHRvIGF2b2lkIHRoaXMg
aXNzdWUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBMVVUgSE9BSSA8aG9haS5sdXUudWJAcmVuZXNh
cy5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2Fz
LmNvbT4NCj4gUmV2aWV3ZWQtYnk6IExhdXJlbnQgUGluY2hhcnQgPGxhdXJlbnQucGluY2hhcnRA
aWRlYXNvbmJvYXJkLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTGF1cmVudCBQaW5jaGFydA0KPiA8
bGF1cmVudC5waW5jaGFydCtyZW5lc2FzQGlkZWFzb25ib2FyZC5jb20+DQo+IFNpZ25lZC1vZmYt
Ynk6IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gLS0tDQo+ICBkcml2
ZXJzL2dwdS9kcm0vcmNhci1kdS9yY2FyX2R1X3BsYW5lLmMgfCAxMiArKysrKysrKysrKysNCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspDQoNCkxvb2tzIGdvb2QgdG8gbWUgdGhp
cyBwYXRjaC4NCklmIHRoZXJlIGFyZSBubyBvdGhlciBjb21tZW50cywgSSBjYW4gYXBwbHkuDQoN
CkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg0K


