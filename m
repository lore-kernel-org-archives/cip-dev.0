Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05669E7E635
	for <webhook@archiver.kernel.org>; Tue, 26 Sep 2023 13:12:33 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.18688.1695733945272639229
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Sep 2023 06:12:26 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 38QDCNo03439753; Tue, 26 Sep 2023 22:12:23 +0900
X-Iguazu-Qid: 2yAaOS3aFTnVkwCZBB
X-Iguazu-QSIG: v=2; s=0; t=1695733942; q=2yAaOS3aFTnVkwCZBB; m=SbJbmAeilRGulqlwMWROGC6+eP/noI5hD50XHq9Wwcc=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 38QDCMa91897936
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 26 Sep 2023 22:12:22 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXBLTKd5yIG5QIoLvaRbXqdW/3JvQ1yecNncu0tvy55820gQmdWPy2XgFW3EdH8HmQFyDkNbrnNP3ybUFwQV8Y+N4X0GhUTRd7AsTsOF3x/ZZPAzDZttmaRvxTOZYn2nhUnlOnQp2SsgwxbhvLQCRf2+NJzxPkqJkd/ADSZpIsqAFLzSj+EJzi6GGxMXIMm3Ri5ueuqViFeAnbkRnQFXFu9w2Y8A7ubXAWzhDQlzHPAL0D0stFrpXsxwCly4VuTLxukqixY00JId+PXAcy7TFTXufyZoo2DVzzhEmB0SMLNI7VjImsqczAa7UkTstV8IFIEKOm6uWEgU7fzUd5R0Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Me8d7vgTGsj5ofy9jFmqS+xJO7+AVVJepV2k7VnsTcA=;
 b=FkKEBo4Pv4duqsm5u2t2SF9fgIyQgX734t5YLml9OKh+U8l1xWMAlqSADLZ3sgeF2TZOX+N/kefnb2LiDzzPj4S2taUckrS08Ueb8qrR2rR6v4TCD/r8NuCce9CR2XGF9XxMWKWyfwKOQj3e1IwkZeb1jo7M4kUcAZkBHzKxCqxp8bv6sgAc0uc1aJ5U6j8nfBgtYCGZF+rJJ/sy+RbSREysfef0aDZB7RjQkqS+HicEmKtuVARRvw8RxZXC844XOC56YZEFXtxM99Hr8n9oF6wN7UTys4UpOGx8UrLr+E/eFmIIyFne+Ow51G1YJHrAeLQOxcwENo1tddD6mZ9MmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <kazuhiro3.hayashi@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>,
        <nobuhiro1.iwamatsu@toshiba.co.jp>
CC: <iwamatsu@nigauri.org>, <minmin@plathome.co.jp>
Subject: RE: [cip-dev] [isar-cip-core][PATCH] Add support Plat'Home OpenBlocks
 IoT VX2
Thread-Topic: [cip-dev] [isar-cip-core][PATCH] Add support Plat'Home
 OpenBlocks IoT VX2
Thread-Index: AQHZ1WgEo+n6V2/dOUC/h7tohapuXK//SywAgAAcyICAF+KgAIACp6IAgBNShHA=
Date: Tue, 26 Sep 2023 13:12:20 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYVPR01MB108285E9B1416FFBF656972B6E1C3A@TYVPR01MB10828.jpnprd01.prod.outlook.com>
References: <20230823021713.87089-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <e42fde0d-023d-4e03-a081-0d471172c6f2@siemens.com>
 <TYWPR01MB9420D3C6042C375FB255DE1292E0A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <TYWPR01MB94205EE74FE50218B3F3001B92F1A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <bd108908-8c22-4eeb-9a60-f386e300a2a9@siemens.com>
In-Reply-To: <bd108908-8c22-4eeb-9a60-f386e300a2a9@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB10828:EE_|TYCPR01MB8852:EE_
x-ms-office365-filtering-correlation-id: 369dfe3f-9a36-4674-7a81-08dbbe923729
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 wiNYoGLfGtNf6IA2BOo/4FdqD213Gj3RG+dvcTHmhX5Q7MWtkYByIYa93ao5R/znngEoi8Qqqdvn9Jdc2VlITlvaSEIbMcc/izjP2+bMbzIv+GWvSfclh9gNCLoGg4G9NSzszcQ2nlh3gnj8J7x2RKFLpteplytZO0RimtDxppO4QD3FGXYxRNLamMvs818LXG71jSqZOr83kTnYIkQHsCUZARZ628tjuON0eSRIHUFW48ILSoNVdIFitdG2IowJUDSL6hlLd2UkZ4pzKmaZ8afsRlfAOa8Ei2F8CKCWrHvzfOT4Qc3WwcoevWGwA91El0Rmb/xvzED7sULl5gUNU0i+GfNCmoVHLqWK6GENsehTxGaDSNXrpMTSS9sWOlGVL9GRa8mNH8oFWwrM38odwWGEzEDJFiSqXmGZ8bIJZmx+cnGY4EI+xFtJ1+lFqiG3A5Onj+T9MRDsJ1eIxxo2FTEUxceBs+bprE8vwI68Ot4fxu/71aVZgmyx3+euNk/ToZEaG4jSx0+jahdK4tAXbKRbWc81UhhmkXI746p3EXROhQVu2BfjTwcP8CHXqIAUaRddvUrUEQ0vXK8ryxxa8QGBW2QUz+xCXTY81JWpz9OwOHaPviIuttn361R3rw4Gs/U7gIO0T4uI1Ou8BCVCYA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB10828.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(366004)(376002)(230922051799003)(186009)(451199024)(1800799009)(38070700005)(38100700002)(33656002)(86362001)(76116006)(55016003)(5660300002)(2906002)(9686003)(66476007)(71200400001)(478600001)(52536014)(41300700001)(316002)(66556008)(110136005)(54906003)(64756008)(66446008)(6636002)(66946007)(122000001)(7696005)(6506007)(83380400001)(4326008)(8676002)(8936002)(26005)(151773002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aG5XK1lWaUR4dTJ6OTRFbkNJYU1ISjZVSlA1ZXc5UXNDTkw1Y24xT1pTZFUv?=
 =?utf-8?B?cGpRRGxJZjdPSy81bS9zaThSQlJhY0JZaEtzK3k4bFlOcTNPVWdId0E3dVNE?=
 =?utf-8?B?dG1VREVZS3JUU2dReU5XM3FHZnNQVm82V1NmNWhyTFRYcUo3NWk4cGFxbENL?=
 =?utf-8?B?OHZ2Rmd5WmZTdFVjY0Jzcy9MM1h0RGsva3R3TktrWHQydkpOaVRCQWlPdlh2?=
 =?utf-8?B?YlJIOGZqdTZleGVaQmNMdUZsdnFrM1FnVmcvK3ZPZUtQcUJCV0U4N3lZNW14?=
 =?utf-8?B?UTdOWjZ0ejM5L0c5dXhIU09mZVhCQnIyMmJ6amt3am5Mdlp3cUZyeE5HK1Fh?=
 =?utf-8?B?ck9Cd3NHTmZ1ckkvNmRkdm1oV21XR1htMVNXdjVqWCtJcTJnZXJaMXQ4K2Rt?=
 =?utf-8?B?VmkzREVtZTJ0WkpTOFFvN3FnUi8zY3ZJWlF4TXdNZWx3VW02OGZXWXRTZXlm?=
 =?utf-8?B?N2I1U1lycDBWdmxLYkNHb2c5Ulhqdk1vQ04wcHhqaklvNWRKVWlvemxaSkM5?=
 =?utf-8?B?Y1dRc2hWZ0FTb28wU2VDSE5aWmJWZzVJV0IwdGtNZDlBMC8vOWcxekJ3ZVZV?=
 =?utf-8?B?dXI2Znl0amJiNldNNGRWcFdqY1V5UFdhYTByM0dBTmlRQWhYRm5YTEg2UERi?=
 =?utf-8?B?aHpvUEtQaWFwYTM5YlV4eVpoWlVKazVwN3doUHg5bXVIZnNtakdxYzQ4NjND?=
 =?utf-8?B?VnBVNEx2djltdGdmK3kxSXNGYXVaVm1teDM5eHBObEx2cEZ3cEU5cnBtSlNx?=
 =?utf-8?B?M1BVYjQrNGN2OGFDeUtPT0J3YWl6WVZibEVOZ2Q0Mjd5eGVzYWJxTVRSaFNG?=
 =?utf-8?B?YXlsWTgweHgwNlo4dXBzODU0d0MyKzVVdmVRK0dSc3NFUk9nbWtwdCsxR2g3?=
 =?utf-8?B?OGJVdFZMZUN4ZzVZNkd1anFlbHkwTmxNMy9JTUxyYXFYb0ExMUVET3gvYTRS?=
 =?utf-8?B?L2cwSHd2d0hDQkNVS3FEdG9mWTFMU215QjNRT2hwbmovTTBGN2hSd3B0T2tN?=
 =?utf-8?B?TWNrbDVtTDlvM05MZ3Z2eFhJMVhzVmYySjBlSzR1YmRUN3JNUUkxb2dzTXFL?=
 =?utf-8?B?Q2d3TjRnUFVsZ2N2SWVuM2l1cE9ITnNSQlNnbTBadTluWldVTk9JdXhJR21Z?=
 =?utf-8?B?MHd3TXpWemtKUmFvelZiYXNFRWd0VDdqT0t6bmZTWW1PTS9LRENNL0Rkeml2?=
 =?utf-8?B?VHZuUkRhYmlGSTBBS0FJZkg2ajdSQmxGdkdQbWpJbmdmQXNIWFlvaDhxNXBt?=
 =?utf-8?B?bG4zVi9vWmxYb3VxVDZEWU5BSUliTTRQbVBxa2s3WW1sbWJNc2daY0dBTzkr?=
 =?utf-8?B?YlEwdWIzWjRnMDloUzNEQ0hDK0dmcWlSbmEwRVpJNTRSRG93U3pXVWtqSUd4?=
 =?utf-8?B?OUZFUFVML2lXNmJ2WkI3LzgzUHdoLyttT09UUHh2YjJxemgwOUV1SDNiTEJY?=
 =?utf-8?B?UDZPMUM2SFdTcE93TExhV2NIejJXYlNreVQrUy9ZMkZtS2JKUmxVS3g2b0Zw?=
 =?utf-8?B?N3UxbkU0N3djT0hZN0puVXRiTnZEdUUxUXhHL1lLTEdqVVBaQm9hOGxVaURB?=
 =?utf-8?B?NWE3WnNSRlVSalV0Smc1cXdhcER0Ym01Y2gvb0dvSkl4ck1YckpMMGJxVmpw?=
 =?utf-8?B?ZkRFQkZITENaWjRJQ1owU1JxL0Mzblo0dzdKMWJmMUV4blBWVkhSZUdqNm9D?=
 =?utf-8?B?djhTRXcxR1dnamNaUGVwN21GUnk0cURYSjlpS3JDNkMvNHYzUmtnajNKdjFj?=
 =?utf-8?B?bjN6eFdZalFLaG96WTRRdWhyWXJPS0YyTEdsNUZuanJHVnZMM0hqT0JUUVNE?=
 =?utf-8?B?d3JMMlF4aHEycHR5QTVUZ1g2TmdlcGM1Z2VIRWFKcHhEelozTjd3NmEzN1U5?=
 =?utf-8?B?MHp0QzNPS0hPajBjL1psRUVBNDRKbVluNUw0Q2VvdFUwUkdhbGU4aTRrek5O?=
 =?utf-8?B?MStGZjZMY2tBbjlQcGk0U3N2L092Z3VuUlNvTEphM1ZsWGx4WkV6MWN0bm43?=
 =?utf-8?B?UU91U0dPZ3V2bStlZmNSc1A5S3YrOW1qSmxWQlE0M28vUC9qblBidEJZbk4w?=
 =?utf-8?B?bU5uMVZxNWtHcGhyc2duenlMU2czbEFTUFFvK3NrNWlXOWpVVkV6NjdnZHl0?=
 =?utf-8?B?bzZCMDZRUzYySTk4Yk1icHFuL1diTkE0N2cvYll4dWhmZFE4V1ZtRG0xRTZG?=
 =?utf-8?B?cmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB10828.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 369dfe3f-9a36-4674-7a81-08dbbe923729
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 13:12:20.2791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0mKYS2fRnwNPuRfoZsEqxaDLTjL7QRhC1teAjvKhTry2WAIG1iYXATJlrKuAkmma11EUohQ4tgQJSHcbp9nmFVMGNEYiSuWQ351Fuo3oQc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8852
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Sep 2023 13:12:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13229

SGVsbG8gSmFuLA0KDQpbLi4uXQ0KPiA+Pj4+IGRpZmYgLS1naXQgYS93aWMvb3BlbmJsb2Nrcy1p
b3QtdngyLndrcyBiL3dpYy9vcGVuYmxvY2tzLWlvdC12eDIud2tzDQo+ID4+Pj4gbmV3IGZpbGUg
bW9kZSAxMDA2NDQgaW5kZXggMDAwMDAwMC4uMzA1MDY4NA0KPiA+Pj4+IC0tLSAvZGV2L251bGwN
Cj4gPj4+PiArKysgYi93aWMvb3BlbmJsb2Nrcy1pb3QtdngyLndrcw0KPiA+Pj4+IEBAIC0wLDAg
KzEsMTUgQEANCj4gPj4+PiArIw0KPiA+Pj4+ICsjIENJUCBDb3JlLCBnZW5lcmljIHByb2ZpbGUN
Cj4gPj4+PiArIw0KPiA+Pj4+ICsjIENvcHlyaWdodCAoYykgU2llbWVucyBBRywgMjAxOQ0KPiA+
Pj4+ICsjDQo+ID4+Pj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IE1JVA0KPiA+Pj4+ICsj
DQo+ID4+Pj4gKyMgQmFzZWQgd2ljL3NpbWF0aWMtaXBjMjI3ZS53a3MNCj4gPj4+PiArIw0KPiA+
Pj4+ICsNCj4gPj4+PiArcGFydCAvYm9vdCAtLXNvdXJjZSBib290aW1nLWVmaS1pc2FyIC0tc291
cmNlcGFyYW1zICJsb2FkZXI9Z3J1Yi1lZmkiDQo+ID4+Pj4gKy0tbGFiZWwgZWZpIC0tcGFydC10
eXBlIEVGMDAgLS1hbGlnbiAxMDI0DQo+ID4+Pj4gKw0KPiA+Pj4+ICtwYXJ0IC8gLS1zb3VyY2Ug
cm9vdGZzIC0tZnN0eXBlIGV4dDQgLS1ta2ZzLWV4dHJhb3B0cyAiLVQgZGVmYXVsdCINCj4gPj4+
PiArLS1sYWJlbCBwbGF0Zm9ybSAtLWFsaWduIDEwMjQgLS11c2UtdXVpZA0KPiA+Pj4+ICsNCj4g
Pj4+PiArYm9vdGxvYWRlciAtLXB0YWJsZSBncHQgLS10aW1lb3V0IDIgLS1hcHBlbmQgImNvbnNv
bGU9dHR5UzAsMTE1MjAwIg0KPiA+Pj4NCj4gPj4+IEkgd29uZGVyIGlmIHdlIHNob3VsZCAoYW5k
IGNvdWxkKSBjb25zb2xpZGF0ZSB0aGUgeDg2IGNvbmZpZ3MuIE9yIGRvZXMNCj4gPj4+IHRoaXMg
dGFyZ2V0IGNvbWUgd2l0aCBhbnkgc3BlY2lhbHRpZXM/DQo+ID4+DQo+ID4+IEkgdGhpbmsgaXQg
Y2FuIGJlIGludGVncmF0ZWQgaWYgdGhlIHNlcmlhbCBwb3J0IGFuZCBiYXVkIHJhdGUgYXJlIHRo
ZSBzYW1lLg0KPiA+PiAoVGhlcmUgbWF5IGJlIG90aGVyIHNldHRpbmdzIGFzIHdlbGwuKQ0KPiA+
PiBBbmQgdGhlIHBhcnRpdGlvbiBzY2hlbWUgaXMgYSByZWZlcmVuY2UsIHNvIEkgdGhpbmsgdGhl
IHNhbWUgc2V0dGluZ3MgYXJlIGZpbmUuDQo+ID4+IFRoaXMgdGltZSBpcGMyMjdlIGFuZCB2eDIg
aGFwcGVuZWQgdG8gaGF2ZSB0aGUgc2FtZSBzZXR0aW5ncywgc28gdGhleSBlbmRlZA0KPiA+PiB1
cCBpbiB0aGUgc2FtZSBjb25maWcgZmlsZS4NCj4gPj4NCj4gPg0KPiA+IFBpbmfvvJ8NCj4gPg0K
PiANCj4gU291bmRlZCB0byBtZSBsaWtlIHlvdSB3YW50ZWQgdG8gc2VuZCB2MiwgZ2l2ZW4gdGhh
dCB5b3UgY29uZmlybWVkIHdlDQo+IGNhbiBjb25zb2xpZGF0ZSB0aGluZ3MuIE9yIGRpZCBJIG1p
c3VuZGVyc3RhbmQgdGhpcz8NCg0KU29ycnkgZm9yIGludGVycnVwdGluZyB5b3UuDQpEbyB5b3Ug
ZXhwZWN0IGNvbnNvbGlkYXRpbmcgLndrcyBvbmx5PyBvciBvdGhlciBjb25maWdzL3lhbWxzIGFz
IHdlbGw/DQppLmUuIEludHJvZHVjZSBhIGNvbW1vbiBtYWNoaW5lIGRlZmluaXRpb24gbGlrZSAi
eDg2LWdlbmVyaWMiIGFuZA0KdXNlIGl0IGZvciBib3RoIElQQzIyN0UgJiBPcGVuQmxvY2tzIElv
VCBWWDINCg0KS2F6dQ0KDQo+IA0KPiBKYW4NCj4gDQo+IC0tDQo+IFNpZW1lbnMgQUcsIFRlY2hu
b2xvZ3kNCj4gTGludXggRXhwZXJ0IENlbnRlcg0KDQo=


