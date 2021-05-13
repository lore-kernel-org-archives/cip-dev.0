Return-Path: <SRS0=ZqHU=KI=lists.cip-project.org=bounce+64572+6453+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AC4C43600
	for <cip-dev@archiver.kernel.org>; Thu, 13 May 2021 01:11:21 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18503613FC
	for <cip-dev@archiver.kernel.org>; Thu, 13 May 2021 01:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18503613FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6453+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id bz6vYY4521723xw7z9CUkrC1; Wed, 12 May 2021 18:11:20 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web10.7158.1620868277922460068
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 May 2021 18:11:19 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 14D1B7M2006241; Thu, 13 May 2021 10:11:08 +0900
X-Iguazu-Qid: 34tKJKyAD9Csv3aLPs
X-Iguazu-QSIG: v=2; s=0; t=1620868267; q=34tKJKyAD9Csv3aLPs; m=rVGCFfHqdXxjMfVDSbN2IaOg+miUa7OnjiV18UxD6G0=
X-Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1513) id 14D1B608013612
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 13 May 2021 10:11:06 +0900
X-Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 6C7331000D4;
	Thu, 13 May 2021 10:11:06 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 14D1B6NB002340;
	Thu, 13 May 2021 10:11:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CmrR9U7BNGzrAWWJl9WNtW+OTRtC0QpRe+nqgKEwX1/nOH80QDhQkjpalSbVtRQYdq0yV3GDMP0DJRpy3byZksbqI3FuumC/IqVy3i6F/oeB78g7s9mANH8pleiKz+4P66+ijuvt5BY9nGkjoENaGRTHvh8Xq8/n+bcl1+6aDVK9IbMKyBu6fT9tiqexLleJAMwaAGaL0PRvcuILA+1+gA4ONw4lxaMGK1g5QCkiAnDaTBTXfbujRlMhz0dNcx+j9W1VYxi8lBhxNR8/kxZ8VOXEvRxl5yVzeRBSR5YHtrOI5sqDgZ2xmTWVvFiXSnGEoZvcGNGjt6lMm3D66nZHFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rl2jGx3TVpgIZrjcIWX1YpMigHjxeTLmaAtzlHZn/Os=;
 b=n6P4nfKcnI2elqJsVdjF9v6ZaRuDLi7W9+1W/h1UYPxUYLBYcSY6VnouN0VmR1xp3wbd565Hr2646JU1R01iyvI/YY+ZSzfF5321NSDemc1OGXsLN7W3Els1vaw5LllgAntBOtIzkAeCqI3PvQPrEJ1TbYflHQN2Hsn+YQSjNaCJNr2T9LYo06wSGOCi49mmnfOhUhYr3AgtFR9EvUf/r4qQ20pohouTKfkBxgZCtENlaobfmEkWse3gDzvZQb8LIjDx/dEWzuz2c4Yc3dcS4krIq7c4KA7NOSM2bHlXd/izHyYFshuIqMtF8HjfGi5I8FQtmBtGmtj2BPFckJ/Khg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 0/2] media: i2c: imx219: Trivial Fixes
Thread-Topic: [PATCH 4.19.y-cip 0/2] media: i2c: imx219: Trivial Fixes
Thread-Index: AQHXR1CDV6lqGbY78kCKuPKj+0dLFKrgfnaA
Date: Thu, 13 May 2021 01:11:03 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB6252C74E1E344EC9F27BCB5192519@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: <20210512170127.16390-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210512170127.16390-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41268b88-3222-4f8a-8486-08d915abfab1
x-ms-traffictypediagnostic: TY2PR01MB4730:
x-microsoft-antispam-prvs: <TY2PR01MB4730633176173EF11110CB5892519@TY2PR01MB4730.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1kgn0QO4/DS5WoiCw+ufDnuF+/ux1Jwk94W31BSnbOTptyjdPjqIH2kBwfwxA3/WhhNSWdUbEyoy7n5fDj0cXkrp7tn/s2f9U+nfWtqnr/HJgTP2/7+0PWBzXwLLNLWwxn9h1tlC1TVmn/ZLIvy2++VlRZnU/HUgYXbf96ykFEdpsC6d7p3xdSLkwF4kAAAgUMtEfmUuLMJ2DsWleBnLctRJhoxRLExi6gX1aO7CwocA2STFNGgITTsjJpWPdh4g5cU7E+xCr9uRo5Nn8pd3NEoGaYmJDY60qZMVOvmSj6Ly/MAfF8xPx8qjo5eq6et3SvZgQestVihQUwAgHvKIFt99H2rMixbLzzAkNQCVYn+BB6y1s8B4IGf4Nu/NsZwFYqDLO8m5M+Ofm9aQ+cIik2XornY7gUbbXIPDIQa/GBEOWZ7zN1IhaVQe4TXXfEta25PNG2BaxQbaCIEYHYjmrM6Jifgox8LtzsaPTQxFm6oY9l2fHxOFI3PU5zwFmGOZjRJTrZAzb+GK3XmuIyCrPhlXcH4lhqc9iqsalT9Ej0pqJTx+K198EVn0hmWsFgYpS+pgV9OAiQAPfvwz/e1+cEqy5FQFTFYMoV35GNLgO3U8jZgu/1Fi4YICMao5a3l7HoGr/89pST0T1pmx/I0Tyfa+vq63xF/UHUEhqjTPPz01oO74qyBYI6eJxUmku132
x-ms-exchange-antispam-messagedata: =?utf-8?B?MkpqL3RlaU13N0xvS0FQb0hTQVlhREl6RmNNVWUwRElPdEszWjgramwrYWF5?=
 =?utf-8?B?bXF2bHJkUjlTRXJOQlZjU3k1VWx0K1ZFMFhwZFNhUWxHSm13MVJSK0dESU5t?=
 =?utf-8?B?UWJsNjFWQ2E3dktveitsWEJJeHBkMWJEdnVLVmtqY3lBS010ZVZuZmhDMWJ6?=
 =?utf-8?B?cWpWSndmMUZxVEk3UHZtOVBacGhVTmpseW9VYWJUQlJ2SGdaMlpaQkwxNEpU?=
 =?utf-8?B?Rkl3Q0cvZU9NTEFjUHY2MFhXVzFBN0NCSlgyYzhGZkt3MU15RW85ZXI0YmFN?=
 =?utf-8?B?MzlieS9KMVptd2hFUk9TNHY0NDJyNFBQaUo4Ky9KRG5MMHZvZlN5R2FmWUVZ?=
 =?utf-8?B?NW5WOXNuUERWckF5dnpTalVsNlZRRVV6VzVQZ1pZcjByVlJQdWE5VitUcWE1?=
 =?utf-8?B?QitUM28wRHNIc25kVWNUMUsxRnk3M3VuREwvTXMxcllBRGd6ZzlHRXU0emdn?=
 =?utf-8?B?Z2liNU5IaFI3RTkvc0M5enkxUXpTcHBjc1ZWZ3l1THpzMDdBRTdpN29SUVFn?=
 =?utf-8?B?T2hmZ2RNZS9GQitpNGFQNTluelQ3ZEpHdkJRNloxRmZIOEhzYVRJUmt2Z0VP?=
 =?utf-8?B?d3R5bWJPSi9rMkZFTnlIRnBINGJrT3VuM1ozN1p1NDdCSDFTSDdLU1NTbzJK?=
 =?utf-8?B?VVp3aHc1Zzc3VzBGQXFBOGpkelFwTGZMamF2Wkl6THJaem8vZ1NxbmMzT1Jq?=
 =?utf-8?B?TVB1YUxkdEpkV1N0MzkyRGNvMDJtSncxb3FBT09XYzFLYi9mT1ZGaml5UGZ2?=
 =?utf-8?B?N2tQSmJDWkJvTG0wbytJVWsxOEIrbnRCMmdwT3RjdENjVmdwMVFMWDhpeVly?=
 =?utf-8?B?V2ZnYUEyeGpCYUtaRlBJZVBzbmN3R3Q3Q3R2TXZGMlE1Sk0xWmhHUlk3QkFT?=
 =?utf-8?B?eGsvOWdpSUl6WnkyQkV0NG05Z05GMjM3YnlQR3hOVWE3TmkwN29IY281bU92?=
 =?utf-8?B?ODRWazlES2RySDBIS2c0RFc1T1VEdVYrMXlZd3R3UENYM1FqR0JjRS8zUTh0?=
 =?utf-8?B?dytGV1o3ajhSdXBBbXFMaERkN3EzeVpGUE1vZGZ3U1lVWFlLOXJYRVpOYjhh?=
 =?utf-8?B?TmlETHEyRGM5eW14QkpYY1VoR2EvbzBHZEt2RVJSSXBWMVgxLzN3SFJTZFVh?=
 =?utf-8?B?MzYvRmxNb0FWT29BN0UyMVBuUW4wNCtYT1RrQ2dSMXkxVkdOMG55RWJFNnVM?=
 =?utf-8?B?TmZnSXFzUnR6bjl6RC9XK0JJZGdQRlo1cXVUcHo1ZjRCY3F0clFPdnBjY2NL?=
 =?utf-8?B?a1oycWZ1WXdmR0piSzB1NlhPakRwOUpJL3pRby9DQTdsSC82TFpFRjhXUHg0?=
 =?utf-8?B?ZDRjUU9RcGJRcGxMZG1FcDkwcER2L3phQUlJWGl4STY4aEgrUVNGQ05sSUZ5?=
 =?utf-8?B?eUVWV2c0L3V3aE02S1doQzQycGxtV25DUkNBSWdUSkJ1QVdrWm9wNXVpcTJW?=
 =?utf-8?B?QUI4VmNqRkVTbmJLcUx2eStQcHVQc21BemhZS2UzUFJLZHdzRGx2SkJSWWcw?=
 =?utf-8?B?dVA0MDdhM3BVbE5tb3puVDhNZ0U1Qi9iYk9jUHJtSFpIeHVJSHk0TWtNUUdY?=
 =?utf-8?B?aEVyQTZ3TUZyQnlOeTFaMFVMUzJvcXpoVU1HejU2ZU5OWUdxdVJoNzVBWlkx?=
 =?utf-8?B?RGtHOURvUlpiMnE1c0x5aUlONTZRRXIwRm9zSFRYaGJET20rUHd0UUljYWJV?=
 =?utf-8?B?Z1FacVdKcEpOdnNaV3g5ZW1ISy95Y05BbkRUa0piNU1EWlJncTk0Z205dUVR?=
 =?utf-8?Q?X09Uu9ycJceymi7DA4=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41268b88-3222-4f8a-8486-08d915abfab1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 01:11:03.7870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZGkgbXmi5eDwevfOKF2vy4cZAmXk1da7glE5pyMrS+I/ICqoQRO5Wr+ONsv6z63vRoUskbvwwpLnoyaHognAfV5ylhJq1uq0Oi25kpRfPUHcxzRaVEN3PA0Tgf/BJLYZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4730
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: FpaaUMGrK760IvNilVuTrKCux4520388AA=
Content-Type: multipart/mixed; boundary="nZLJGnBvygshTUb9eCzW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1620868280;
 bh=EwnUSST2JzalQ2+SWwhd74Tn9amCjn7S9SOIK4pAMAM=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=WTMyLH0k8pWaM0xnqot0XrYsAZN70FnrlYYu/KBg9YZVZxff+v0o3craQ4R62gGaD7P
 I4LOhVQtp4e0pysrDXwqnMa3FpKmE+uhFvZCZe1W5A1TUdjplGZwS33BdxKFEIkIzJ0vR
 THFmrACtRuNDbfJ9XBhKg1eLR54qFxhd7+0=

--nZLJGnBvygshTUb9eCzW
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGFkIFByYWJoYWth
ciBbbWFpbHRvOnByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbV0NCj4gU2Vu
dDogVGh1cnNkYXksIE1heSAxMywgMjAyMSAyOjAxIEFNDQo+IFRvOiBjaXAtZGV2QGxpc3RzLmNp
cC1wcm9qZWN0Lm9yZzsgaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDilqHvvLPvvLfv
vKPil6/vvKHvvKPvvLQpDQo+IDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD47IFBh
dmVsIE1hY2hlayA8cGF2ZWxAZGVueC5kZT4NCj4gQ2M6IEJpanUgRGFzIDxiaWp1LmRhcy5qekBi
cC5yZW5lc2FzLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIDQuMTkueS1jaXAgMC8yXSBtZWRpYTog
aTJjOiBpbXgyMTk6IFRyaXZpYWwgRml4ZXMNCj4gDQo+IEhpIEFsbCwNCj4gDQo+IFRoaXMgcGF0
Y2ggc2VyaWVzIGZpeGVzIHRyaXZpYWwgaXNzdWVzIGZvdW5kIGluIGlteDIxOSBkcml2ZXIuDQo+
IA0KPiBCb3RoIHRoZSBwYXRjaGVzIGhhdmUgYmVlbiBjaGVycnktcGlja2VkIGZyb20gdXBzdHJl
YW0ga2VybmVsIHY1LjEzLXJjMS4NCj4gDQo+IENoZWVycywNCj4gUHJhYmhha2FyDQo+IA0KPiBM
YWQgUHJhYmhha2FyICgyKToNCj4gICBtZWRpYTogaTJjOiBpbXgyMTk6IE1vdmUgb3V0IGxvY2tp
bmcvdW5sb2NraW5nIG9mIHZmbGlwIGFuZCBoZmxpcA0KPiAgICAgY29udHJvbHMgZnJvbSBpbXgy
MTlfc2V0X3N0cmVhbQ0KPiAgIG1lZGlhOiBpMmM6IGlteDIxOTogQmFsYW5jZSBydW50aW1lIFBN
IHVzZS1jb3VudA0KDQpCb3RoIHBhdGNoZXMgbG9va3MgZ29vZCB0byBtZS4NCklmIG5vIG90aGVy
IG9waW5pb24sIEkgY2FuIGFwcGx5IHRoaXMgc2VyaWVzLg0KDQpodHRwczovL2dpdGxhYi5jb20v
Y2lwLXByb2plY3QvY2lwLWtlcm5lbC9saW51eC1jaXAvLS9waXBlbGluZXMvMzAyMDMwMzAxDQoN
Cj4gDQo+ICBkcml2ZXJzL21lZGlhL2kyYy9pbXgyMTkuYyB8IDQ5ICsrKysrKysrKysrKysrKysr
KysrKystLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygr
KSwgMjAgZGVsZXRpb25zKC0pDQo+IA0KPiAtLQ0KPiAyLjE3LjENCg0KQmVzdCByZWdhcmRzLA0K
ICBOb2J1aGlybw0K

--nZLJGnBvygshTUb9eCzW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6453): https://lists.cip-project.org/g/cip-dev/message=
/6453
Mute This Topic: https://lists.cip-project.org/mt/82777615/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--nZLJGnBvygshTUb9eCzW--
