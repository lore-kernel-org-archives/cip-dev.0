Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D266AECAAD1
	for <webhook@archiver.kernel.org>; Thu,  1 Sep 2022 00:37:19 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web10.6551.1661992635996775838
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Aug 2022 17:37:16 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.154, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 2810b6SU027035;
 Thu, 1 Sep 2022 09:37:06 +0900
X-Iguazu-Qid: 34tMX1gd6xfi8lJBSz
X-Iguazu-QSIG: v=2; s=0; t=1661992626; q=34tMX1gd6xfi8lJBSz;
 m=l/qvR9GUblQuk34nD2pj6yKLUJfbankSAzg8uXyWHw8=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1513) id 2810b5Lh013565
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 1 Sep 2022 09:37:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uiu+h1xRxW6C+P9WWsYE+bJXXNbJ+qBPpNtoBE9zFFZ44OtbaDCsaP+ev0/lsdtOR3WENdUOXS+/ffwiwDtNQNy2qmHwre1LEHji1BhVakgfSIXpYSPNzHqydVmuaEk2KyzeU09q4hgbWtPQqQG4/xqWhIBPu+DHwr6kZMDOh2T7W9cMuzXks4e3r/Y9qVNt2YmHqNJWrW99K6CfkmqisflC0Z0DqTs3+qGA9BPs0c/vYDl+us8qSNHFcgHXVK40VH3rLxu+3RK3+BNLjndF19Z3mstCIhLg3g6vs+YX/LvLgf0hwI7TgFNKnbmf8/aXTcp61G41Waj7N8s2LTT+SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cS1fU1jUHJMeMptyrQnwJcvs8Ccuie4Sg9+m6Nzc65k=;
 b=QewTGwpEe1145VhpbP2fN6s2Pl+iTYL71DtTW/7Hn1iOxe58ua7LZL44YlJqqqIykECYqhk4KyWmYU5hfSD3TLFr3u4M4vSL9E5CMlrNp+oy50G0C8n5NElWiNIufJTXZrD3/persQIDto4sO9NxaNlaS8WPhyNsWlEQp0WGbu6sv3NS1B0lc3M71A33YBVYrLlMl+JtJyOPPBKqUOTvp3+vFHJ/vykngu6WSza9mRwaX4yNdpeG5/SAz/oMYjdSTGnjrfby6kd4zOKMhTjwslfF2ldDTphsYgi4rxQRojhqoAprW4p0mKGZLdViGaCax3yqrhWMbeGLb9KQ9KKeng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <chris.paterson2@renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 4.19.y-cip] drm: rcar-du: Fix Alpha blending issue on Gen3
Thread-Topic: [PATCH 4.19.y-cip] drm: rcar-du: Fix Alpha blending issue on
 Gen3
Thread-Index: AQHYvIEpu9ocEGIRGUu4BFlknCw+bq3JvHqA
Date: Thu, 1 Sep 2022 00:37:01 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB94207DE8FE84D5DA082B73A0927B9@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20220830145938.1326295-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20220830145938.1326295-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fae42192-5741-4fa5-6035-08da8bb21624
x-ms-traffictypediagnostic: TYCPR01MB8613:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 YTcwkYtudI84xxUodEJtwQirTv8HeiJw132GBXVP7bDER+Rea9FDcDSq2N5TzK6jH6okHaDzuE5CyXE9PJXb2mvwV1Bt4zEWPzU0LhW2oAgMK6eyg0xUITGM9znEJJ/V0uZoBGQm7HUhgkbouh2/RdpITKhh2Qw2KujBGjGC3LHnk16a/GhJN0oVu1yh4zTTqXxLFp3X5kh+zKfaew4nZbnTSPGkCdoF+Dj4AXwSmy+qCe2mBlK8/+doCZUiwVS2FTe1KoXTMDROVQh6GpfO+V7B4xCKHTu18psxXBxrKmvXmB3sjMpMR07m8NstbmzDHtPUvls3ZpjomD0E5H7Cw2fAIfByUzXAg9wPlrmRPFrAz3JvWDsXXkkRX1OcXviL1iernWJPnt1IadsIBUqR7iRM0TWtW70gzGcWk8pjfApWm8MQvgZH/3oZ/lD4EGCz2hIN/VH9eW4ZZC+2GLWYoPf/BOk6fCVszRkT2CqdT0U60mTeI1gp4d08cG99uEs5GLJZCEivMPHMhsOmPebF7YZanoddiXQcH5KvYXzvgeDZmoH26SxXSENI7vGAj9+pXWselwVwczieTVVh38MI9H30qx1xJSSwkIRTvornw1pdmr6jyoQHpI+aKkXVY8J1/KCPCi4vrpJfDPjDPFhWuFfoCc80BzIclVdZ2jzPLDgUW8bNsIhiarCl4r8ZimeiIAYPdWe8bLWmiEtggeiJauukzorOwCVwIXWqqzlO6BlrcIztz8Hk/3qmxstppU4Z6cggNQCFLorQ283r5irX60y9tD66Cajx1RyHCmSxjuQ=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(7696005)(26005)(55236004)(53546011)(54906003)(41300700001)(86362001)(110136005)(478600001)(316002)(71200400001)(38100700002)(6506007)(966005)(122000001)(83380400001)(52536014)(9686003)(5660300002)(38070700005)(66476007)(33656002)(2906002)(8676002)(8936002)(186003)(66556008)(55016003)(76116006)(64756008)(66446008)(66946007)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UjVxREtjOGxUb0xyMVYzWVpWd1BMOElSWjZrQkhzN0RaNHdtbU9UZktzdXVP?=
 =?utf-8?B?cW5XM29GY0I4S2JidzR0bERxQ1VwZE5SS0JrZ2JFQkthUGJrcDZjUnRBbDlM?=
 =?utf-8?B?cFlUNkZYNS9hR3FzZHFXbE4zZ1JKc25VM0tYR1M5eE1oVFdDbDhEUDFma2xh?=
 =?utf-8?B?ZjVZNERQbW5UQXdtTXQ4aDRUaDd5RGJQaEtWd0NGN0Nydy9mM01LTWo1WVhI?=
 =?utf-8?B?UVFKSlJ6U2ozWnlRcEVzNmN2cW1OaUlBUy9WcUNhV29xNjhobVZjL3orZWh5?=
 =?utf-8?B?RDV0Y214SXNLQ0hOTm1vdGpNZy94Y0I1aXk4cWhJVTBWcUY0Z0tGR0NXbUJV?=
 =?utf-8?B?WVpDcC96UnVKUyt5VTIvQWIycTIrNE5wamdPWGN1c0t2UDNOSll2OENXcG5w?=
 =?utf-8?B?OVhzRUpaSXZoRC9PSmduVitMV2pmZmpOR3pkb05MRjRBVXNqQy84L3VUZkR4?=
 =?utf-8?B?NUx3RUliRXlRUUtIRWVRa2MzNE5ubUt1SFdMRHMzOFMwQUlVQ2VpcEtOdXBZ?=
 =?utf-8?B?a0hCR3dJY2dlcDV5R211dGtJQzZ4ZFhjaFg3bDVYQWcxbnhrWjJtRkFqY0tv?=
 =?utf-8?B?aTRvdzZNY1FXeTNzTjJZV1BxUUlXaC95NHVmdyswT1IxSkh6UWY1UnNnQ1RD?=
 =?utf-8?B?REJGeVdIL001RVFOd0xDSlJ1NE5MWHdqWHBHT25FcVZKaWUxR0p0TkZpTUx2?=
 =?utf-8?B?MUJ4MjQ5QjdtZDlhaW5TSmZUZjZxZjJVd2pjS25IdG5zaDFZUVFpYzdqR01P?=
 =?utf-8?B?UFMxT0xhaXR3cXlVRnFLQ3RRcUc2TXNlemtFWTRhb1pneEhHUkgwR3NleVVl?=
 =?utf-8?B?QmZtSGw3VEEzUW1lZ3JoYlVTVncyajZTeUlXRWVRaDBXRTJQQytkOHhSeTQx?=
 =?utf-8?B?ZHhzK3MvdkRxZUtPNUpSY1lQaTVQN2ZQRUN1ck45NFhFYmgrb0pIVmlZMVVY?=
 =?utf-8?B?ZlhNWTMzcWRDSmplQmZ3ODZiT2F6VHh1bUc0dEhjTmpLNFlMQzFCUHZBemh6?=
 =?utf-8?B?aFRHdHZFL2lDMWFPYWRMYkEyOHB6K2JiQUZnaHVlbU4yTjlPWmVDODZLZjhz?=
 =?utf-8?B?OUtnNE1XRnJlOEh3NjVMOVZKM2w4R0c0WDkyc1lXZGx6S01GK2JaSncyR1pX?=
 =?utf-8?B?U294KzdneTZGVGNRVWtlazh1bGUvQUtNWk9Yb3Zud0E3aHhNV21vNjRtblJW?=
 =?utf-8?B?SEtQcWtoWkxmQ1JzRWN0aVIxU3M3czE1YUEyd2ZUdG1ZdXNwUmdRVk1VbXNy?=
 =?utf-8?B?WmN0dk05c3JEeGhLN0hFSmlva09NTVc4SUU3V3daTm9vZ3hBaVJTczVuU3ZT?=
 =?utf-8?B?QjhVWHIwTHNHKzdsSVRteDVpSzJlUVlDT3RSeVNveWFWOUFaNUozQjgzWkFO?=
 =?utf-8?B?Z0t6QnBjdHF6WXJhbkdpbmNPTkVHWnN5VDZpUklVNVZ1eEtuY04vSFlPZUti?=
 =?utf-8?B?OUdGbktqMVFCWnVqcjN6QmdsaU40WGErKys0K1YwOG1jSXVTZ0RJWWR5d0x4?=
 =?utf-8?B?OUdIU2hONmgvaTJSQitPWXcyN0NONlc5Vnd0ZVlkSUd2SVNtMFNvclVzdjBG?=
 =?utf-8?B?WGJDRHk1ZzJLYjcwL0phTlJ5N3FGOXZKdHVULzlJdTVNaEs5YkdYRFROeEdi?=
 =?utf-8?B?MjJqN0c0ZDFLRWo1Vkk2NE5oeUJEaWxsdVJZM1hudGFVSktFQ1o0RkpVNHNr?=
 =?utf-8?B?YkdJUVJXRGhRRUxTVFR5QURwdjZwYkF2ZEhJbTh6U2pOTzNUYk1FY0lMZERh?=
 =?utf-8?B?cXFCTFBBQXpMZjdCNVFWNVI4MVJFMkxVbElLdlJObWZWcWZkbEtmT1plMm1a?=
 =?utf-8?B?b0FPTThWU3gvOEFJeTBwNlA4djh4VmJCdUp0R0ZvbWt0eVkyYURjMFNqUkNv?=
 =?utf-8?B?Q2Z0c3YrN3F3dHB5UGt0ZVhPR3UyeDBNR28wVmU4WkVQVUVWTUtsT3g4WHZP?=
 =?utf-8?B?M3M2ZlR1SVpHMFJzUXJsVmtWRGlhbWNTaHFoR29FYVNiME9zZTU5MUovSm5K?=
 =?utf-8?B?aXZuZFd0MDd3SUpGN3lzT0pvQlpTN3lKNGhLdWVNaTVrUWZ2QUZ0Z1FvTEpQ?=
 =?utf-8?B?a2JlSWN5cFdaQnFGcE1jckR4Z1FFOWI1TElVc0tlUENiTkZDZ3hVZTIrRzBQ?=
 =?utf-8?B?VjVINkhIVXI2T0lVWlhyQ1p5L29HekR3M29QV2dSNDVrdTZQYXJscSswNFpM?=
 =?utf-8?B?SkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 fae42192-5741-4fa5-6035-08da8bb21624
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 00:37:01.7643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 vTpfxTAb0Qpyqvlu4CVF4oRP8xLvY546ICO+sGcpnAaWW48sy3FbD/Uyf5KmKsQ+ZMh6axlZ30/h/SViOFpjm3gGQZEq3UeKrz9fJ9qCxEbb2hF3OMkaNv2y88IkK9dU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8613
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Sep 2022 00:37:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9398

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmlqdSBEYXMgPGJp
anUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCAzMSwg
MjAyMiAxMjowMCBBTQ0KPiBUbzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IGl3YW1h
dHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4pah77yz77y377yj4pev77yhDQo+IO+8o++8tCkg
PG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPjsgUGF2ZWwgTWFjaGVrDQo+IDxwYXZl
bEBkZW54LmRlPg0KPiBDYzogQ2hyaXMgUGF0ZXJzb24gPGNocmlzLnBhdGVyc29uMkByZW5lc2Fz
LmNvbT47IEJpanUgRGFzDQo+IDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT47IFByYWJoYWth
ciBNYWhhZGV2IExhZA0KPiA8cHJhYmhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29t
Pg0KPiBTdWJqZWN0OiBbUEFUQ0ggNC4xOS55LWNpcF0gZHJtOiByY2FyLWR1OiBGaXggQWxwaGEg
YmxlbmRpbmcgaXNzdWUgb24gR2VuMw0KPiANCj4gRnJvbTogTFVVIEhPQUkgPGhvYWkubHV1LnVi
QHJlbmVzYXMuY29tPg0KPiANCj4gY29tbWl0IGI3YWFhNjE3MjZjYmM3Yjk0MTAwN2FmMTRhOWY5
OTFhODI4YzY3ZTQgdXBzdHJlYW0uDQo+IA0KPiBBcyBwZXIgUi1DYXItR2VuM19Db21tb25fT1BD
X0N1c3RvbWVyX05vdGlmaWNhdGlvbnNfVjMwLjEucGRmLA0KPiB1bmV4cGVjdGVkIGltYWdlIG91
dHB1dChzdWNoIGFzIGluY29ycmVjdCBjb2xvcnMgb3IgcGxhbmVzIGJlaW5nDQo+IGludmlzaWJs
ZSkgY2FuIGhhcHBlbiBvbiB0aGUgYmVsb3cgY29uZGl0aW9ucywgYXMgUG5BTFBIQVIgcmVnaXN0
ZXIgaXMgbm90DQo+IGluaXRpYWxpemVkIGJ5IHJlc2V0Lg0KPiANCj4gV2hlbiBhbHBoYSBibGVu
ZGluZyAoUHBNUm0uUHBTUElNPTBiMTAxKSBpcyBwZXJmb3JtZWQgYW5kOg0KPiAJ4oCidHdvIFBs
YW5lcyBhcmUgZW5hYmxlZCBvbiBhbnkgRFVuIChuPTAsMSwyLDMpDQo+IAkJb0RTUFJuPSAweDAw
MDAgMDAzMSBvciAweDAwMDAgMDAxMw0KPiAJ4oCib3IgRFUwIGFuZCBEVTEgaXMgdXNlZCBmb3Ig
ZGlzcGxheSBhdCB0aGUgc2FtZSB0aW1lDQo+IAkJb0RTUFIwPSAweDAwMDAgMDAwMSBhbmQgRFNQ
UjE9IDB4MDAwMCAwMDAzDQo+IAkJb0RTUFIwPSAweDAwMDAgMDAwMyBhbmQgRFNQUjE9IDB4MDAw
MCAwMDAxDQo+IAnigKJvciBEVTIgYW5kIERVMyhIMyBPbmx5KSBpcyB1c2VkIGZvciBkaXNwbGF5
IGF0IHRoZSBzYW1lIHRpbWUNCj4gCQlvRFNQUjI9IDB4MDAwMCAwMDAxIGFuZCBEU1BSMz0gMHgw
MDAwIDAwMDMNCj4gCQlvRFNQUjI9IDB4MDAwMCAwMDAzIGFuZCBEU1BSMz0gMHgwMDAwIDAwMDEN
Cj4gDQo+IFRoaXMgcGF0Y2ggc2V0IFBuQUxQSEFSIHJlZ2lzdGVyIHRvIDAgdG8gYXZvaWQgdGhp
cyBpc3N1ZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IExVVSBIT0FJIDxob2FpLmx1dS51YkByZW5l
c2FzLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVz
YXMuY29tPg0KPiBSZXZpZXdlZC1ieTogTGF1cmVudCBQaW5jaGFydCA8bGF1cmVudC5waW5jaGFy
dEBpZGVhc29uYm9hcmQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBMYXVyZW50IFBpbmNoYXJ0DQo+
IDxsYXVyZW50LnBpbmNoYXJ0K3JlbmVzYXNAaWRlYXNvbmJvYXJkLmNvbT4NCj4gU2lnbmVkLW9m
Zi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiAtLS0NCj4gIGRy
aXZlcnMvZ3B1L2RybS9yY2FyLWR1L3JjYXJfZHVfcGxhbmUuYyB8IDEyICsrKysrKysrKysrKw0K
PiAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykNCj4gDQoNCkxvb2tzIGdvb2QgdG8g
bWUgdGhpcyBwYXRjaC4NCklmIHRoZXJlIGFyZSBubyBvdGhlciBjb21tZW50cyBhbmQgdGVzdCBp
cyBvaywgSSBjYW4gYXBwbHkuDQogIFRlc3Q6IGh0dHBzOi8vZ2l0bGFiLmNvbS9jaXAtcHJvamVj
dC9jaXAta2VybmVsL2xpbnV4LWNpcC8tL3BpcGVsaW5lcy82MjgyMTM2MDgNCg0KQmVzdCByZWdh
cmRzLA0KICBOb2J1aGlybw0K


