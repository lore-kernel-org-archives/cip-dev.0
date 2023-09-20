Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5C4CE79AC
	for <webhook@archiver.kernel.org>; Wed, 20 Sep 2023 05:53:30 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.30776.1695189208896513341
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Sep 2023 22:53:29 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 38K5r7eF2068222; Wed, 20 Sep 2023 14:53:07 +0900
X-Iguazu-Qid: 2rWgDRdQ1aOy2m5Tve
X-Iguazu-QSIG: v=2; s=0; t=1695189187; q=2rWgDRdQ1aOy2m5Tve; m=rgdPcaaOBtuFPyq28xgCayS54mVstilVFkQKHryMTfQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 38K5r3xs4117693
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 20 Sep 2023 14:53:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIbuGKLiO+/U9RxnhzUqAcOIOreE9EgATsQ9KF/1EDQfTd2m6SgdM8oN/I9nbGZhChbF1yJgVAlspFJfsglw8zeV7mr4biPnHSv76Zwx7LRi5AXvjL4TCNffvvOM37rzjn7NIYmocVZ+2lSv9IINGqUGnWFh5ap+3aZrkvxr6RGUwhv1o1QlWH1Nx15ScOgKyjw8ehHIJ/JJw+x5DLT2X+Ji5w1fwy6VGv+MVMYRs6n5zfbxNpGQdd63dGalSsOnht5gPjc1ZUzjdd0XDP/3cuyspNfkMNlN0HvFGZ132W5ikTcckOKKGNTTDejmad8Hc2lYd2WPTrkNlVOy4XuopQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hpv7EweftrN94ImE43ZGGqz38NEtgWyrc/H8XSzxZg=;
 b=jE7BQvoH3ooRMtRS+fHBGIMsfwESpvadTOrqi3eeq8WQMVCMO/OV5tp3pSCtISyoHIUSMW6EUWIdrM8Zv4l28fFVrpYMlI7LM0NIZEgvqD/R8EGPGE1zXwh+F1nbZf9tm2wln1XaLgdQR9nBvgYCCOgwx+15KSEXZyq2FXXgWULX5l5BDO21AfTbwrdhYHS4bQJ+u3P5V8LoV8KMTDKcRvh7mRzgXwAwvj6WRkJozucBXbE1SVmGDcUL2YiyRYP5NZUYcKtI9jdtHFw2R1M57oxmJOB7tWorjnBaVCQ02ft814IOsfKmIq1mKQwOVoIKBBilyK94qNkG0v+vHxyIMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <uli@fpond.eu>, <masami.ichikawa@cybertrust.co.jp>,
        <Chris.Paterson2@renesas.com>
Subject: RE: [ANNOUNCE] Release v5.10.194-cip39
Thread-Topic: [ANNOUNCE] Release v5.10.194-cip39
Thread-Index: Adnq8bl7whuogWpjQ6GDs4st3ouSugAkxliAAAAKN4A=
Date: Wed, 20 Sep 2023 05:52:59 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420875F144F17D9F36CE3B192F9A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: 
 <TYWPR01MB9420C4F2D1A4D50470E0E5CA92FAA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <0de9f4af-bf37-4bf8-bf5c-28b2b6d7fda9@siemens.com>
In-Reply-To: <0de9f4af-bf37-4bf8-bf5c-28b2b6d7fda9@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYCPR01MB8517:EE_
x-ms-office365-filtering-correlation-id: c091364e-991f-4c47-26a5-08dbb99dd8b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 3kK2hNWVkK+E3f7Hh9LSF4wYipnz7NM4q7w4LQBo6WPRgG8FaPwcysulYmUDG0JjLRhTp/JY01Iu7KCDsytwVaMZj+dxs9SfU1Y2WEwwSMQ5IRHXHtyRrqiaaKH6dUxZJcWqxkkavk92Csb45CqR9eButJ1cqJ3dcavUxm9WARDYdIFQtca8/gwixM4gryLo6f2YBiidKd/V29QjA0tpMIgMjKjLsjV4byGWytOl0M1kHRI49esrtQm43HfzIExhUhowrv2ohD91AscjYvjPT+Y8qXXKkvDtMMYhZnKi/EdW14t2dSEIJXHyBiBBeOg3W6wk2rK2PTkeKtMdz5QskqK7l2Y7xUuj3c+y6kPhK/MRoWNrUE/syQptFLnpffLq0ZXdsbp3lnGNde54jhecO0MSAIvyF5DM24xWMDhjI9Qbn2Lkuy8LWJUE4E0r6j2kKLpKkYH1V0cSYldg9JyDksGdaALy2WRWPAiCyWmPKKoJ0U7bKhGV4rD9fy5lMZMKJVqP4tzTKwW+iYE8jCbeiJuKnkvC5ydIuhJ8JjW//mUKkB9XD9+seH0oVBtQhoStqKd1OCU32hhqr5oS9+m0eaftBZUKJyyCuzMPf3je8rE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(136003)(376002)(1800799009)(186009)(451199024)(53546011)(7696005)(6506007)(9686003)(478600001)(71200400001)(83380400001)(2906002)(66946007)(316002)(76116006)(66476007)(64756008)(66446008)(54906003)(966005)(8676002)(110136005)(4326008)(8936002)(5660300002)(52536014)(41300700001)(66556008)(86362001)(33656002)(122000001)(55016003)(38100700002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WEdMODBsaWNDTDl5REI0U0VESHFmNGFDOStwanhoK0E1eGRRbm5sc2ZOeURm?=
 =?utf-8?B?ZE42eGtETFdHQ0VFWWR2aTdSb2I2MnFHWDV3a25CU0JUN3lmOElEREFDc1Zk?=
 =?utf-8?B?cEdGUkpJTmdhZHg4VUhaT1R0UVRvOE5wYWJ3ZFZQenVnS2RiZyt3enRTdEh6?=
 =?utf-8?B?ZlpZMFRXYVNIalg3RlVWbG9CdjZwempTbk9JUllPRlBlUk5CbUlyem52c2tU?=
 =?utf-8?B?bWZVbmNoTGtoNlZRZlk5QUl0cDdUeGdWUk5WWmlETEsyRXd2eU1NU004UjZG?=
 =?utf-8?B?em1GL003VzNsN29JN3lqMmZhcjM5SjRpdUJUNkV0THVScUZyWGxZYWlDTmND?=
 =?utf-8?B?UjQ5b2F4THdYNzdJOTN6MGVFTjVIbEdJTjJGQzJxbWZMUDNQRWl0cFlZMlhM?=
 =?utf-8?B?Y1JRTzN6djJ4dEdPS2xlMkdxNWk3WmlqTG1VeWVwMVV2amVUYmYxVTQrb2Fl?=
 =?utf-8?B?RDFrTk9UTlVIa1JjeWlyYkFuSFVhVlJPYXpOZDVNZ2dmTkUwQ0ZhNS80LzZn?=
 =?utf-8?B?cFhzVTNyN1d4dnF2R29OWWN0a3haWnNGemJxNXk5VnBXRWZPUDdTVHBNRE5v?=
 =?utf-8?B?SzBQWEIxQWlBNGhUTGxmdGlVMHZ2OWE0OHAyUGFKcUEyWlgyNno4enA0TlNl?=
 =?utf-8?B?dUx4dlpKVlpUUS9YcDhidkhFRjd3aTNsdmtJWHkzQW1PRU55VEdSbjV2ZVhJ?=
 =?utf-8?B?SFpMYVdXeWdRaW1KWlpCVTMrSE51OEZuNTI4TVlNQjRuU1RUMWJwckRQNEdX?=
 =?utf-8?B?aW5uN0RqNU1mekhuK0g1UXpHQ2RnT3NxMWRlYkd3cmZoTzY3TXFRT1prb2JJ?=
 =?utf-8?B?cGcwSE5oeVRTbGpZYVJoOW5vOVMrV0dUUVEybXlWNlhwelFnUlkrWkFVYnZP?=
 =?utf-8?B?cTR6NFFkVk13clFQbFJyNmd6UlNUci9rYTk1OWFZVXdSaXIwODFoM0JrVXAv?=
 =?utf-8?B?RkJyS0c3TTlkZHhONHNOVkRzSkREcm9BY1BmSnpOUFg3TTJuZHQ2UGZlb2Nl?=
 =?utf-8?B?R0N2ejBRdFpjcHVtb1FjL0M3YS9UNkR2WHNpb3I5RVhPbGN2T1lKc2xYTEhi?=
 =?utf-8?B?YUQ5MmhoUDF1RThMdVRrN0tiRE8xNlhhaitHVHAxd0FtbmNFWjYrbjZmZm0x?=
 =?utf-8?B?Q1d3ZDdwTmJMWWZjL0xITkNXNzJFclNrQTFOdEFSa1JLS1A3Z1AxZFZFcXpJ?=
 =?utf-8?B?cnVEOFQ1dXRoQ2c1QmtBRE5sM0dIV0FpMkl0WUtJZGdGZVZSajZzejB4V2tr?=
 =?utf-8?B?QVBNSUJsMVg1N1FrTURuQllxejgzTnFqVzAzRWliU05UNGhwTExJTzVGL2tR?=
 =?utf-8?B?Q2Q3dUZ6ZFZJODFJc0JhSnU0T3lDb1BTWnByMnJHYkdnQTdKZklUZ3JYd1ZT?=
 =?utf-8?B?RlhrTGpSekI1dW4vVkVvOHhMaUp5QUNPWUJCYWI3UnVadVNHYmM5aGI2Q2Z6?=
 =?utf-8?B?MkhTSU83Q2RKc3hJc29ObWFSS2I4TlpYbytCYzRlYVNSUFFuZkVXeDhRS2Jm?=
 =?utf-8?B?YjFHc1VjeUp0Y25FSFdLQXV2VnR5enAvYkEyMXZacGl0ZDF5UXE0ZHJFbXNU?=
 =?utf-8?B?ZTVnQTlhVENrM2JERmdERENMYUU0a2VDT25VNFQxVk5WSFRRY1BTUHBDeXJB?=
 =?utf-8?B?OVdrUCtIbHh6eWoySEVodGN6SjNpM3VNUnJVOFJXamtlaG5CVWs2OGVKL3Yw?=
 =?utf-8?B?VmswWWRaTjNDcksxcjQ4dE5qdk1wSmt6NS90OFYrSUMvY3VRME1JYUJlOHB4?=
 =?utf-8?B?S2ZQa1BPQU9RTlJudFNhcmhpVzQrUjVleDZJVCtxeWlOMHR4VjZNai9nNGVy?=
 =?utf-8?B?VXF3QURZYkhBYjJKeFBvRmNtN1pNYUpzakF1ZENJRnM3ZVRTa2pMcWw5aWNR?=
 =?utf-8?B?UndjWVd6eDBJZ08zdFgzUzRWdXhwdVE4K3g5ZXFRTDhpMXVKcFZ6cCtLR2Vh?=
 =?utf-8?B?UjhmU2VJNTdwU1AvMlZMTk9NT042K2FVOUV0bStEMmRyTlhRaWo0ZDNPY0xp?=
 =?utf-8?B?R0RDRmNrR25FL1pIOGFuQmNEUDJ3R2p3ajEwM1VsVkZOdE9kVDZDcWpZWjh4?=
 =?utf-8?B?VVZ0andBMDMrK0Y4T2tTdW5GZWE5RXVtMktucDVlVDNVbXdlVEF5NUNSMzJ5?=
 =?utf-8?B?QldJemN4SGs3TklydENvQTFPQWhDM3dzTS9RU0pnSUZUK1hpYjlHcVpkL3l6?=
 =?utf-8?B?RFFOajloRTNROGJ0NWJVQldSR3pPbmtEREY3N0FUOUV2NFV3TGFXVU15ckVl?=
 =?utf-8?B?ZlFXS1dvVVFUcjlQZ2V0WUQ4Z0VBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c091364e-991f-4c47-26a5-08dbb99dd8b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 05:52:59.9512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LcwFvDKwyIPcm1z7jIeApByLrTiS1JvzWtq1E4472k5lqRbIQ2gUOF4HBL/+bdqFIh8FOfaoOycaNH/+6kwQscg8u4NayRFnoQMPzX/LU8BKzVROsUQDONySs35YjY0j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8517
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Sep 2023 05:53:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13178

SGkgSmFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEphbiBLaXN6
a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVy
IDIwLCAyMDIzIDI6MzkgUE0NCj4gVG86IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg
4peL77yk77yp77y077yj4pah77yk77yp77y04peL77yv77yz77y0KQ0KPiA8bm9idWhpcm8xLml3
YW1hdHN1QHRvc2hpYmEuY28uanA+OyBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBD
YzogcGF2ZWxAZGVueC5kZTsgdWxpQGZwb25kLmV1OyBtYXNhbWkuaWNoaWthd2FAY3liZXJ0cnVz
dC5jby5qcDsNCj4gQ2hyaXMuUGF0ZXJzb24yQHJlbmVzYXMuY29tDQo+IFN1YmplY3Q6IFJlOiBb
QU5OT1VOQ0VdIFJlbGVhc2UgdjUuMTAuMTk0LWNpcDM5DQo+IA0KPiBPbiAxOS4wOS4yMyAxNDow
Nywgbm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanAgd3JvdGU6DQo+ID4gSGkgYWxsLA0K
PiA+DQo+ID4gQ0lQIGtlcm5lbCB0ZWFtIGhhcyByZWxlYXNlZCBMaW51eCBrZXJuZWwgdjUuMTAu
MTk0LWNpcDM5Lg0KPiA+IFRoZSBsaW51eC01LjEwLnktY2lwIHRyZWUgaGFzIGJlZW4gdXBkYXRl
ZCBiYXNlIHZlcnNpb24gZnJvbSB2NS4xMC4xOTENCj4gPiB0byB2NS4xMC4xOTQuIEluIGFkZGl0
aW9uIHRvIHVwZGF0aW5nIHRoZSBiYXNlIHN0YWJsZSB2ZXJzaW9uLCB0aGlzDQo+ID4gcmVsZWFz
ZSBpbmNsdWRlcyBidWcgZml4LCBSVEMgYW5kIE1UVSBwYXRjaGVzIGZvciBSZW5lc2FzIEFSTTY0
IFNvQy4NCj4gPg0KPiA+IFlvdSBjYW4gZ2V0IHRoaXMgcmVsZWFzZSB2aWEgdGhlIGdpdCB0cmVl
IGF0Og0KPiA+DQo+IA0KPiBQbGVhc2UgZG9uJ3QgZm9yZ2V0IHRvIGZlZWQNCj4gaHR0cHM6Ly9j
ZG4ua2VybmVsLm9yZy9wdWIvbGludXgva2VybmVsL3Byb2plY3RzL2NpcC8uIEknbSBzZWVpbmcg
bW9yZQ0KPiByZWxlYXNlcyB0aGVyZSwgYnV0IG5vdCB5ZXQgNS4xMCwgYW5kIHRoZXJlIGFyZSBt
b3JlIGdhcHMuIFdlIHJlYWxseSBuZWVkIHRvDQo+IHN3aXRjaCBvdXIgQ0lzIHRvIHRoaXMgc291
cmNlIEFTQVAuDQoNCkknbSBjdXJyZW50bHkgcnVubmluZyBpdCBmb3IgZXZlcnkgcmVsZWFzZSwg
YW5kIHRoaXMgdGFrZXMgdGltZS4gSXQgYWxzbyBzZWVtcyB0byB0YWtlDQpzb21lIHRpbWUgZm9y
IHRoZSBjaGFuZ2VzIHRvIGJlIHJlZmxlY3RlZCBvbiB0aGUgc2VydmVyLg0KSSB3aWxsIGNvbnRh
Y3QgTUwgSSBjb25maXJtIHRoYXQgaXQgaXMgcmVmbGVjdGVkIG9uIHRoZSBzZXJ2ZXIuDQoNCkJl
c3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg==


