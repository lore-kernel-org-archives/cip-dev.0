Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976C7C67871
	for <webhook@archiver.kernel.org>; Thu, 21 Apr 2022 16:46:11 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web10.17080.1650511555073245458
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Apr 2022 20:25:56 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.153, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 23L3PkvT007518;
 Thu, 21 Apr 2022 12:25:46 +0900
X-Iguazu-Qid: 34trMBIs3QhDxhuxiT
X-Iguazu-QSIG: v=2; s=0; t=1650511546; q=34trMBIs3QhDxhuxiT;
 m=mBg61+xEc5NKS6u5CwPMoOhRKni8sqcIUXPzsfjnj/k=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1513) id 23L3PjZc000328
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 21 Apr 2022 12:25:45 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRKSttU+W/puVuRFXmpgLbfSJOciBwxWvOpn7rASOqCBJXYZBqxJ84Qj5aHzoZP5zKd1GNO9yI3vzgC2lvi+dLzUG52LXWAmY7MxUP4BmqYPMIylFXJiJFm/X7wzNnDhSZGJqp78VGjfz29oULyLc1BosfNW9ml1LomvpQW+TBwaOvJnSPG5Tfut7e3n4AaMBGEWQc0Kp2y2/3htINWNtYv5+jIIop2zm08YQwHf1ejG7cQEwLluDc6qPGohmtdahN/jVFtnVw1pfYs0X87CQI9GbsgkpZJ8HiJ/os0NNZvnjOLdDyKUt90FJSxmyza/BWEmO7ERI5hjCtST/GB8Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIMIuseCVlDrVjJU+YUFzE5NTEqla5vt5JGmD08HsF0=;
 b=THzuC3sPP/29cHLGV8zTkLjM0iiMcW8Bq1bYeZbEC9h8c0G0xDWkF4A47NYV30Ge6BJ9Ezpdatar90TiFNQmM3FTU6ja0jxPVVOiEjHqY6k6OthbhejWaSZH3pTwaypoc1w2mUwT/fAQlhNwsFW2nFGgROPdMNbdxEdDCnjLpnOiM8haCzTYwTIOduncuCGnFVDTOhJwffa1HXdEOffEKz/dA1WUe5dyngxpBlqW+TxSpuMLvyN95dcaRfiToVzjFr3PwaMMExpzfPOVxbyFyNvnXYaalStvth6lX1T5wJzNC5sY7aMsvEkbkNoV6f/7RiuSTdq+O+nnKhvBg3N/ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 00/24] Add sound support to Renesas RZ/G2L SoC
Thread-Topic: [PATCH 5.10.y-cip 00/24] Add sound support to Renesas RZ/G2L SoC
Thread-Index: AQHYVP53PzDhpsg+5kqJFwxgPIQK36z5r8LQ
Date: Thu, 21 Apr 2022 03:25:42 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420C80542707FC4B160E5E992F49@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20220420213424.27837-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220420213424.27837-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 938c4e84-df6c-4ab2-8044-08da23469dbb
x-ms-traffictypediagnostic: TY2PR01MB2458:EE_
x-microsoft-antispam-prvs: 
 <TY2PR01MB245895878D19B36FAF259E1092F49@TY2PR01MB2458.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 areDdofV2IH3B0LJkJBk5ckvk7brN9wRgNdKgnEBv8qfg8gzOQuqO16MskMjR9miZG0r3pHO2UtWWURJzZntk2TnBZL1iywqavAKV6dI/Uky3EPlyWerKv8bbH9CsbtbVpM6jC00X8cGex7ICxqZ1/WvOrmJi5esgFosV73vAAZoLqJXulwgQtuxzIfrCWJklnpGQ4t3bzyji5GzHwNBwg7pE0H1zKI7F39c2Rc+C9xgu4goSuJ1cK6btkYHO7qAVk2uw6WEQrUaynMJSDey51jMzy2A/4TUZ+MbW27iC8inq4V2VDjShYBUdkQOF55ovR1DX2xEHsSpKfJPbIj0FtA1oRzCzuDCXAO495PL7mJiayxnum0s9OsMTgAuczNGwpA6P2Ea2CIil1bW4GI6TMM3M6q0IXxJgy9MzvDTwJkpdehuZCKNykbMvm9xjLqy544GRdAK6FdQ4TZYPPfYEyQNceL43BKdLiiDUF6+TfLYAOQrQ/0IAwMWWtTmaEBcZkd01nz5rP3WVrTWV9y6PBiuUtkWO5kM76MQwmL8wvTz3H6/5Xta1CVxut9hp1GYlX6gs3UMCuTCylGpYV3SK78FNPsTwPBsG506o8S3rWkHZuTcRfurdgLYD80yHpMhVwGdZ4cIwrGfZGZQ0KACS8g3x+9dqwUkKG6BxXT+oZDb7Qp/Ll6WIclYTivQaw+PR/+f2/2rJ9RFfwg16vHPHIRW0Pv3dSVJslR9Pwn775+gYQktLOjvII4bBWtbG2ua/qbOYgIqsTFqKjGLYp7v9xboooIprzgjYcjeEQ1MJG8=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(66556008)(66946007)(2906002)(122000001)(66446008)(508600001)(110136005)(66476007)(9686003)(38100700002)(55016003)(4326008)(8676002)(83380400001)(76116006)(33656002)(71200400001)(52536014)(86362001)(7696005)(5660300002)(966005)(6506007)(26005)(316002)(53546011)(64756008)(186003)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NnB6UndjQ09hNmU1MENiZmRhMERESnU2dU5ZNERmck5TbGVna2pwbGVVMDFy?=
 =?utf-8?B?ZTViWHJtMnFUa2ZZT0ZvL2E4Y2RnNTljUVlPUVgrbG91MkZyL3pqbjU3ZS85?=
 =?utf-8?B?L3MzaWV3WUNSMXY5enpTMldXTXRGYXY2QUFRdWZaSi9OQjdORkhTSHVwRktX?=
 =?utf-8?B?MnNiZWZzeVJ3cVFhRXNuSUlCMlBlNHY5TlJnUkNlQTlRUWUySVRTNEZHSG9S?=
 =?utf-8?B?OE5MeVE1aGxVcG52SmZWQmhQR1NrZ01sU0N5c3Y4ajJ2cktsNTR4WUF4ZVhm?=
 =?utf-8?B?Uy85YXg1NDRHbVJXT2JBTzZUZTN3MGpUUmIyc2orRjlIQmRDeWRYR1VJSzVk?=
 =?utf-8?B?bmd0Q3VsaU5NZUtTYUJuamZ5ZzBNV05ZWU43NUFlUmVhajFkSlNLR2ZTRjNE?=
 =?utf-8?B?S2ptbkFqUmNaYWFCeTk2OXErSHNURUM4TnRPaUo2YytmdUNqVlBlUUpKOGVs?=
 =?utf-8?B?VTZrZVJQZlc1dk5aTHozWmZwZUFmQndKU295RW9WMEZ0VzFveXBwbEN6NTk4?=
 =?utf-8?B?YjFpV2x5cmFpNlhkdlY0QUt0LytyMWJ0NThiYThGa2pVZmFheG1zeEZOVzJw?=
 =?utf-8?B?bTFlTHNpUHhZdHYwdEt1MXFlZjhTTTZ1dXhxczZtMTJ3WDhNNUYrZExRQ1Ay?=
 =?utf-8?B?cTFKVkpSeTU2eTFuNVlWS0doQUtsdFhyVjE4WGhzRjBHMHJVQVRVTjdVTThH?=
 =?utf-8?B?RkM1U0RidGRpV3d1WEw5UytVcjBnQzRzVG1mSnZVRk03b0dVNnBERjgybytz?=
 =?utf-8?B?cCtVbUhsL3hTdk90eGltNEwzSWhvTzY5YjJGZm9JVFl6am8zaDE2LzNEcmlC?=
 =?utf-8?B?ZEVmdXhQb2ZRUDEvMGVnaU5VWWxDMSswcnpTYmEwN01CMjQ5cWtLUGRaa05G?=
 =?utf-8?B?K3JTMm5qYU5rSFVXRjFVY3V0NGVaQStjYmQwYVpiUWl4V29pL3BNV2FVWk5T?=
 =?utf-8?B?UE1kYU16eHJTQUhlMUdKdkpPd0hxTTk0WkJvTFo0UERFc1ZncEVaM2RvdnRo?=
 =?utf-8?B?WHhKcTY4VEY4c1l3OWRYbVpIdVlOVW9yK1BVM3FJVlB6QnZ3bW9jN0NRWXZ0?=
 =?utf-8?B?d2pQenVEczVWRjBtYVppcW83T1htRVVUM1N4UGJFTEhJL3RvMFVjNEpPbnEz?=
 =?utf-8?B?M3FPYkxBZ2YrMDRnNHFJZWFmdlNJeEFjeHRvWHNlOFoybm4wZmVQTHdLRzZi?=
 =?utf-8?B?dEVMeVgzc0d6bnU5SnFKR1RJQUh2K3Q2K2I3QTVKSlR5OCtpNW0yS0svbUQ5?=
 =?utf-8?B?OTFqL3RpUG1USWFXYjdKYVdWQUVzLzcreEx1dHhSYWQyYytjeHlSL3IyQjMv?=
 =?utf-8?B?UHRyTG5TZzlMUGROUG5tUm1jaU05UnFQTEEyMzNTcTVXc1dnQ3dWL2s2ZnJs?=
 =?utf-8?B?MUpFc1diR0diZWhkYVQweExnV1FjSXQyTWpiYUxUTWNGUTkxNkEveEo4bld6?=
 =?utf-8?B?dGdTZjhVSjFWblVzamdUbEZQOVdrZFNIM1dIUndNT3hTNFJuS2p5Q2g5d21L?=
 =?utf-8?B?cTB3YUJSZHMyMW9mYWx1OTZVSDJmeVQ1NmthZ3doeUoxNXQ1M2s0OTRMOEtx?=
 =?utf-8?B?aVR0aHBXZU5WWDk0REFYUkwxQmJNTk15cEdmcDVBMDVEejRvYjJmeHA2SFFR?=
 =?utf-8?B?anJ0alRZQWlveWxNN2JicGtKZTRPdjQ4THdUeThRenJ1bmszKzhMUkZ4RDZt?=
 =?utf-8?B?WFU5SDhTZEVISExSSFpJYUF6YU55VG51R0pZaVdaSTZkdG91RHVseFdzUFU1?=
 =?utf-8?B?WE5PS08walg3d3FwR0NOQWxqTXBldnNCN0J5bzJUbXhPVnhlTzdqanB6UGYy?=
 =?utf-8?B?SEVGbUtaaEZYVEpYa2RwY0RwVC9DWlNJcXh4VkVYWDhNUzh6Z2dUREtsR0Np?=
 =?utf-8?B?aS8vWlBuR1JQdWtNQjRmcTRqdkJ2N2ZJKzVRYVZZSElrOERKclladmRzd1Jy?=
 =?utf-8?B?WDN5Qzg2SnMyc3Z1bG9jeVBURDZsQm1vblVUTm13TGZ4MEdiblJ4dDlaS3lX?=
 =?utf-8?B?R3pjRTJaRFdUa0pJMmQyZE9VWTNUWVN3RVR5MjdlWGNrcVBpUTZVY2NlQlZT?=
 =?utf-8?B?ajRzRldhQTFJNEJhYUs2UUxLMXYveHlGTUdhMFNHRE11Ty9DUmVjS0ViSjdN?=
 =?utf-8?B?Nkgyc0g0eTJSL2xRZ0R0b3JpYXY2cjYyUVA4SFRyNGRuVy96YS8wUTg0aGVP?=
 =?utf-8?B?ZWh3TlNpRlZUalJpd2dwRld4MEtiMEF2ZE00Qnc1dWdLeVhObHpRSzBEdTJ0?=
 =?utf-8?B?QWxESk1kRnVpUTNZbUFHems0akFMaWlINVZIdys0OGNEdms4Z09jU09LRG5h?=
 =?utf-8?B?eEtrT29iMVB2RGlJbEs4RTFsZVpKbkJwRjhTdlVId0NNUG1hTUtLRjdrNWJM?=
 =?utf-8?Q?aGU+gErKrX65hknE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 938c4e84-df6c-4ab2-8044-08da23469dbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 03:25:42.6715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 g+TwFuxLmsVZVlhbFrsP0qMkRAdscEaFqea0a6ymn6q1pBaLumEzoAIktCw4gEZgYvwyyx6IGg/rKF2WgUetjXieMu2u6R6Vg0BWS/fqp2ryg9Ea4joJUG9SkJ1CAvOS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2458
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Apr 2022 16:46:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8149

SGkgYWxsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExhZCBQcmFi
aGFrYXIgPHByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbT4NCj4gU2VudDog
VGh1cnNkYXksIEFwcmlsIDIxLCAyMDIyIDY6MzQgQU0NCj4gVG86IGNpcC1kZXZAbGlzdHMuY2lw
LXByb2plY3Qub3JnOyBpd2FtYXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKWoe+8s++8t++8
o+KXr++8oQ0KPiDvvKPvvLQpIDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD47IFBh
dmVsIE1hY2hlaw0KPiA8cGF2ZWxAZGVueC5kZT4NCj4gQ2M6IEJpanUgRGFzIDxiaWp1LmRhcy5q
ekBicC5yZW5lc2FzLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIDUuMTAueS1jaXAgMDAvMjRdIEFk
ZCBzb3VuZCBzdXBwb3J0IHRvIFJlbmVzYXMgUlovRzJMIFNvQw0KPiANCj4gSGkgQWxsLA0KPiAN
Cj4gVGhpcyBwYXRjaCBzZXJpZXMgYWRkcyBzb3VuZCBzdXBwb3J0IHRvIFJlbmVzYXMgUlovRzJM
IFNvQyBhbmQgZW5hYmxlcyBTU0kNCj4gYW5kIGNvZGVjIG9uIFJlbmVzYXMgUlovRzJMIFNNQVJD
IEVWSy4NCj4gDQo+IEFsbCB0aGUgcGF0Y2hlcyBoYXZlIGJlZW4gY2hlcnJ5IHBpY2tlZCBmcm9t
IHY1LjE4LXJjMy4NCj4gDQo+IFNvdW5kIHN1cHBvcnQgcGF0Y2hlcyB3ZXJlIGFscmVhZHkgc2Vu
dCBlYXJsaWVyIGFzIHBhcnQgb2YgYnVsayBzZXJpZXMgWzBdLCBidXQNCj4gZHVlIHRvIHNvbWUg
cmV2aWV3IGNvbW1lbnRzIHRoZSBwYXRjaGVzIHdlcmUgcmVqZWN0ZWQsIG5vdyB0aGF0IHRoZSBk
cml2ZXIgaXMNCj4gZml4ZWQgdXBzdHJlYW0sIHJlLXNlbmRpbmcgdGhlIHNlcmllcyB3aXRoIGFs
bCB0aGUgZml4ZXMuDQo+IA0KPiBbMF0gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9q
ZWN0L2NpcC1kZXYvY292ZXIvDQo+IDIwMjExMjI5MTAxNTMwLjIyNzgzLTEtcHJhYmhha2FyLm1h
aGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tLw0KDQpMb29rcyBnb29kIHRvIG1lLiANCkkgYW0g
dGVzdGluZyBvbiBodHRwczovL2dpdGxhYi5jb20vY2lwLXByb2plY3QvY2lwLWtlcm5lbC9saW51
eC1jaXAvLS9waXBlbGluZXMvNTIxMTE3ODMzLg0KSSBjYW4gbWVyZ2UgaXQgaWYgdGhlcmUgYXJl
IG5vIG90aGVyIGNvbW1lbnRzIGFuZCB0ZXN0IGlzIHN1Y2Nlc3NmdWwuDQoNCj4gDQo+IENoZWVy
cywNCj4gUHJhYmhha2FyDQo+IA0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQoNCj4gQmlq
dSBEYXMgKDE2KToNCj4gICBBU29DOiBkdC1iaW5kaW5nczogRG9jdW1lbnQgUlovRzJMIGJpbmRp
bmdzDQo+ICAgQVNvQzogZHQtYmluZGluZ3M6IHNvdW5kOiByZW5lc2FzLHJ6LXNzaTogRG9jdW1l
bnQgRE1BIHN1cHBvcnQNCj4gICBBU29DOiBkdC1iaW5kaW5nczogcmVuZXNhcyxyei1zc2k6IFVw
ZGF0ZSBzbGF2ZSBkbWEgY2hhbm5lbA0KPiAgICAgY29uZmlndXJhdGlvbiBwYXJhbWV0ZXINCj4g
ICBBU29DOiBzaDogQWRkIFJaL0cyTCBTU0lGLTIgZHJpdmVyDQo+ICAgQVNvQzogc2g6IHJ6LXNz
aTogQWRkIFNTSSBETUFDIHN1cHBvcnQNCj4gICBBU29DOiBzaDogcnotc3NpOiBGaXggZGVyZWZl
cmVuY2Ugb2Ygbm9kZXJlZiBleHByZXNzaW9uIHdhcm5pbmcNCj4gICBBU29DOiBzaDogcnotc3Np
OiBGaXggd3Jvbmcgb3BlcmF0b3IgdXNlZCBpc3N1ZQ0KPiAgIEFTb0M6IHNoOiByei1zc2k6IElt
cHJvdmUgZXJyb3IgaGFuZGxpbmcgaW4gcnpfc3NpX2RtYV9yZXF1ZXN0DQo+ICAgICBmdW5jdGlv
bg0KPiAgIGFybTY0OiBkdHM6IHJlbmVzYXM6IHI5YTA3ZzA0NDogQWRkIGV4dGVybmFsIGF1ZGlv
IGNsb2NrIG5vZGVzDQo+ICAgYXJtNjQ6IGR0czogcmVuZXNhczogcjlhMDdnMDQ0OiBBZGQgU1NJ
IHN1cHBvcnQNCj4gICBhcm02NDogZHRzOiByZW5lc2FzOiByOWEwN2cwNDQ6IEFkZCBETUEgc3Vw
cG9ydCB0byBTU0kNCj4gICBhcm02NDogZHRzOiByZW5lc2FzOiByemcybC1zbWFyYzogQWRkIFdN
ODk3OCBzb3VuZCBjb2RlYw0KPiAgIGFybTY0OiBkdHM6IHJlbmVzYXM6IHJ6ZzJsLXNtYXJjOiBF
bmFibGUgYXVkaW8NCj4gICBhcm02NDogZHRzOiByZW5lc2FzOiByemcybC1zbWFyYzogQWRkIE1p
YyByb3V0aW5nDQo+ICAgYXJtNjQ6IGRlZmNvbmZpZzogRW5hYmxlIFNPVU5EX1NPQ19SWg0KPiAg
IGFybTY0OiBkZWZjb25maWc6IEVuYWJsZSBTTkRfU09DX1dNODk3OA0KPiANCj4gSGVpbmVyIEth
bGx3ZWl0ICgxKToNCj4gICBBU29DOiBzaDogcnotc3NpOiBDaGVjayByZXR1cm4gdmFsdWUgb2Yg
cG1fcnVudGltZV9yZXN1bWVfYW5kX2dldCgpDQo+IA0KPiBMYWQgUHJhYmhha2FyICg3KToNCj4g
ICBBU29DOiBzaDogcnotc3NpOiBEcm9wIGNhbGxpbmcgcnpfc3NpX3Bpb19yZWN2KCkgcmVjdXJz
aXZlbHkNCj4gICBBU29DOiBzaDogcnotc3NpOiBNYWtlIHRoZSBkYXRhIHN0cnVjdHVyZXMgYXZh
aWxhYmxlIGJlZm9yZQ0KPiAgICAgcmVnaXN0ZXJpbmcgdGhlIGhhbmRsZXJzDQo+ICAgQVNvQzog
c2g6IHJ6LXNzaTogRHJvcCBzc2kgcGFyYW1ldGVyIGZyb20gcnpfc3NpX3N0cmVhbV9pbml0KCkN
Cj4gICBBU29DOiBzaDogcnotc3NpOiBNYWtlIHJldHVybiB0eXBlIG9mIHJ6X3NzaV9zdHJlYW1f
aXNfdmFsaWQoKSB0byBib29sDQo+ICAgQVNvQzogc2g6IHJ6LXNzaTogVXNlIGEgZG8td2hpbGUg
bG9vcCBpbiByel9zc2lfcGlvX3JlY3YoKQ0KPiAgIEFTb0M6IHNoOiByei1zc2k6IEFkZCByel9z
c2lfc2V0X3N1YnN0cmVhbSgpIGhlbHBlciBmdW5jdGlvbg0KPiAgIEFTb0M6IHNoOiByei1zc2k6
IFJlbW92ZSBkdXBsaWNhdGUgbWFjcm9zDQo+IA0KPiAgLi4uL2JpbmRpbmdzL3NvdW5kL3JlbmVz
YXMscnotc3NpLnlhbWwgICAgICAgIHwgIDExOCArKw0KPiAgYXJjaC9hcm02NC9ib290L2R0cy9y
ZW5lc2FzL3I5YTA3ZzA0NC5kdHNpICAgIHwgICA5OCArKw0KPiAgYXJjaC9hcm02NC9ib290L2R0
cy9yZW5lc2FzL3J6ZzJsLXNtYXJjLmR0c2kgIHwgICA3OSArKw0KPiAgYXJjaC9hcm02NC9jb25m
aWdzL2RlZmNvbmZpZyAgICAgICAgICAgICAgICAgIHwgICAgMiArDQo+ICBzb3VuZC9zb2Mvc2gv
S2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICA2ICsNCj4gIHNvdW5kL3NvYy9z
aC9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDQgKw0KPiAgc291bmQvc29j
L3NoL3J6LXNzaS5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgMTA3OA0KPiArKysrKysrKysr
KysrKysrKw0KPiAgNyBmaWxlcyBjaGFuZ2VkLCAxMzg1IGluc2VydGlvbnMoKykNCj4gIGNyZWF0
ZSBtb2RlIDEwMDY0NA0KPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQv
cmVuZXNhcyxyei1zc2kueWFtbA0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IHNvdW5kL3NvYy9zaC9y
ei1zc2kuYw0KPiANCj4gLS0NCj4gMi4xNy4xDQo=


