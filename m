Return-Path: <SRS0=w9d6=7D=lists.cip-project.org=bounce+64572+4638+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5E9C433DF
	for <cip-dev@archiver.kernel.org>; Thu, 21 May 2020 07:12:38 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4682220759
	for <cip-dev@archiver.kernel.org>; Thu, 21 May 2020 07:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="IL5hFnh8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4682220759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4638+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id QBwcYY4521723xoRVTPNEmFZ; Thu, 21 May 2020 00:12:37 -0700
X-Received: from APC01-HK2-obe.outbound.protection.outlook.com (APC01-HK2-obe.outbound.protection.outlook.com [40.107.130.108])
 by mx.groups.io with SMTP id smtpd.web12.1291.1590045155938909154
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 May 2020 00:12:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BChFE+nCC1Mt/LKKw7OR/OHfUn8LMrt8kIPWQ07vkpcIVu4rN8Rpx0Pebos5GnuVmeRJc8lp0ragWAH+pdIB9POp5PX7S5+UT7ynLfii49TN8WjQvv21JXZsFn6iOtM9N9g9+rNrotHzrFgi52TPY3Q3b1GfkXLgpkPNlrdsqSN9wQs+bmMS7BxYIfzm7v/6FM0UUCOpS4OhLsTNVdaPghB8ANAsZDQYDBYfQQfsFECYIg27NmbgG8wssH+Edr5k73PBMUGBZ5fBOpC5FV4WU8A09NU/Tzff4+eCB1UqUqQjxgIVrdhFM+gS3OfVLZQI2yhniOQHYjF3I5nLxuNMGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBxY7zhc/3eByeuWxEM25lJA+cLMtn4v7RAa2tZi5w4=;
 b=nKAtlXGM1gKX+2u+GTqEO01D3sCI5DslENHxkaipwk3v2mW3yeXOn4et73Arzm7ota1AFLIUvEoyuss07wET87XMAGMrroLje8BhmnWGz858W1NBWWXsoTkEfbx3eum+wK+8jvb9n+kcWWZ21QsBD7kUL4TutSSPwk9lWSuDZIS4/CWVPOWUpKzS5j8VuDXtETAwCzSFcrHeXX844z10PckmMDNsbIz9C4Aq7vVKtnwychNwfHbV3MBc8HNaOm7FGy+kRp+t709oq4AzRTEeOy9W673NaphW9YSmHD6kNpwX6QV4J0BsLQWRc90cBZUB9Dpuq8gIfarz0to9wQGupw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TY2PR01MB3257.jpnprd01.prod.outlook.com (2603:1096:404:6b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Thu, 21 May
 2020 07:12:30 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752%4]) with mapi id 15.20.3021.020; Thu, 21 May 2020
 07:12:30 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: [cip-dev] CIP IRC weekly meeting today
Thread-Index: AdYvB7QVKLJJTSekT7GTmv8mJ06fZwALeVzAAAJXMJA=
Date: Thu, 21 May 2020 07:12:30 +0000
Message-ID: 
 <TY2PR01MB49725A90E09EB47786F9AB3EA0B70@TY2PR01MB4972.jpnprd01.prod.outlook.com>
References: 
 <TY2PR01MB4972A13626095E5A9810C62AA0B70@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <OSBPR01MB2983629D897D216A673CFB4F92B70@OSBPR01MB2983.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSBPR01MB2983629D897D216A673CFB4F92B70@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3790ffae-3445-4eb5-2723-08d7fd5653a3
x-ms-traffictypediagnostic: TY2PR01MB3257:
x-microsoft-antispam-prvs: 
 <TY2PR01MB3257F04C1D527D60504FDC3CA0B70@TY2PR01MB3257.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 o4eKumW5ZmQGtjQSjVwKxNisBzFL9ttIquQnhWtuT/M0xxTiPnFCcNpna+iiYk064zpu+PlpSeSGagAlrT7D8SzjmKUcb1u31M50h5/31U9ScEwTmbRSCNtkZ6gkmM9kF/bAuP74hlOPGfpdu8W+vwBO4wHDdhv1+1sfzs4wbOIsqkZX1a52A3oRC7XYtp3iIP2EjBxbA7AoAGUW173M37q0LFaIAAIhxalZTrGMgvh1AcA4vmGJD+TZ1o+2NRwkk3V9zXx25jO6uw6QpP/wPlWy2bnFFAAizArD/B9QyL5zy+AYqXnzXczedm1nVd2th2umZXhu3rZM7BM71OIrFJIFCGNAHuW5QWVYMi5CBhZC2MSOazZkD9vs3W5UA476Az8Eq9CC9Yte3GLtRiOrihYZv/ner3U2XA7UH0vFXQcS9cR6ez1RPkgcbIeboo2Y7wTXRoXSf/enSwe1FhVYwgpaPdCmOM0hNcJpHMCbwLPDxai29qWUXiBaoyCUNsWfJP0nexEvUd0xVR4iE9MRbg==
x-ms-exchange-antispam-messagedata: 
 +BxmEaRT5fHhMgcWuArwcXxE6aofz8EoRb4efHD+KijDyyWRA4LFNFVPx80iGqtUY9YsRYs+08nNqK5/vdV4bGXlTlWeB0Tb8TJMYw5Oqb5wJapgVfcrdOFnyOSPGJSJmA2dm53fgFB7hZ3cFkL/IPZWYSK9siTGgLqVLrY+C1IionnH5b9tg3ve98OWjbi6lctx3+qhrn67mzNeLEyuL3w42Xa0aAwf4CbdnJwfFtmqtYXOdCv7lB3tUXfIqKxZaPslBWhDqxBzpEX+1HtFNYdQTLxai29jtz2tBK6WFHGHqSa2ovetbi/k9GPHe9/iJ+CSB8rP47Am1mYEnGg/Jv2fC/VWSgMc2Tq6TFrreu79GszxLsQSQepmJB2SLvqwDPHBryKYOZr46CyCYq1p+UkMJlJybAaZpdnGILzvfnmkT0r/FxojMYc23+rOzc8E7L7cyfXFo1wK+N0q1G/fp14JaVWa3VyU0IaHzDoLAYnczO/mQe13v3wxVcJcIM7S
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3790ffae-3445-4eb5-2723-08d7fd5653a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2020 07:12:30.8020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LS1JsRWBPJzHQ9P4uEmzqbNdo4yECxtUM27zFlK/7k1ycMNjik277I3rWil4xcEMu91VHw7U7iyQrsO18BPPW+M/Va+ay0WF1e3HVtTfmEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3257
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: N84glikX4YaakO7XXW5NInJex4520388AA=
Content-Type: multipart/mixed; boundary="pM3z7W61xUkjw6ZDeqF3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1590045157;
 bh=k07bJxZJCEmA09nTNSY33qyOHxr+A4jI4XTsuqJmi80=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=IL5hFnh8TCCZNU5cU5IEyysDQ7cl1JofsB2ZmjaHLSqMxdJl28HnRQYaIue62tFZ1F/
 pEMoWz0CrgIdOwA4Vp9IvJVLHJx+oFtT5lEIkSudAdKS64CYJ7FHEiz0/EZKWGL6/oReT
 ZgLTt5axSQAylVrV0M1SmO05DQ6YhyD90Rg=

--pM3z7W61xUkjw6ZDeqF3
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksIEl3YW1hdHN1LXNhbiwNCg0KVGhhbmtzIGZvciB5b3VyIGVtYWlsLg0KSSBub3RpY2VkIHRo
YXQgeW91IHB1dCAoQ0lQKSBhZnRlciB5b3VyIG5hbWUgd2hlbiB5b3UgY29tbWl0dGVkIHRob3Nl
IGJhY2twb3J0cy4NClRoYW5rcyENCg0KQmVzdCByZWdhcmRzLA0KLS0NCk0uIEt1ZG8NCg0KLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qu
b3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24gQmVoYWxmIE9mIE5vYnVoaXJv
IEl3YW1hdHN1DQpTZW50OiBUaHVyc2RheSwgTWF5IDIxLCAyMDIwIDM6MDggUE0NClRvOiBjaXAt
ZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KU3ViamVjdDogUmU6IFtjaXAtZGV2XSBDSVAgSVJD
IHdlZWtseSBtZWV0aW5nIHRvZGF5DQoNCkhpLA0KDQpTb3JyeSwgSSBjYW4gbm90IGpvaW4gSVJD
IG1lZXRpbmcgdG9kYXkuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcgDQo+IFttYWlsdG86Y2lwLWRldkBsaXN0cy5j
aXAtcHJvamVjdC5vcmddIE9uIEJlaGFsZiBPZiANCj4gbWFzYXNoaS5rdWRvQGN5YmVydHJ1c3Qu
Y28uanANCj4gU2VudDogVGh1cnNkYXksIE1heSAyMSwgMjAyMCA5OjM3IEFNDQo+IFRvOiBjaXAt
ZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTdWJqZWN0OiBbY2lwLWRldl0gQ0lQIElSQyB3
ZWVrbHkgbWVldGluZyB0b2RheQ0KPiANCj4gSGkgYWxsLA0KPiANCj4gS2luZGx5IGJlIHJlbWlu
ZGVkIHRvIGF0dGVuZCB0aGUgd2Vla2x5IG1lZXRpbmcgdGhyb3VnaCBJUkMgdG8gZGlzY3VzcyB0
ZWNobmljYWwgdG9waWNzIHdpdGggQ0lQIGtlcm5lbCB0b2RheS4NCj4gDQo+ICpQbGVhc2Ugbm90
ZSB0aGF0IHRoZSBJUkMgbWVldGluZyB3YXMgcmVzY2hlZHVsZWQgdG8gVVRDIChHTVQpIDA5OjAw
IA0KPiBzdGFydGluZyBmcm9tIHRoZSBmaXJzdCB3ZWVrIG9mIEFwci4gYWNjb3JkaW5nIHRvIFRT
QyBtZWV0aW5nKiANCj4gaHR0cHM6Ly93d3cudGltZWFuZGRhdGUuY29tL3dvcmxkY2xvY2svbWVl
dGluZ2RldGFpbHMuaHRtbD95ZWFyPTIwMjAmbQ0KPiBvbnRoPTUmZGF5PTIxJmhvdXI9OSZtaW49
MCZzZWM9MCZwMT0yMjQmcDI9DQo+IDE3OSZwMz0xMzYmcDQ9MzcmcDU9MjQxJnA2PTI0OA0KPiAN
Cj4gVVNXZXN0CVVTRWFzdAlVSwlERQlUVwlKUA0KPiAwMjowMAkwNTowMAkxMDowMAkxMTowMAkx
NzowMAkxODowMA0KPiANCj4gQ2hhbm5lbDoNCj4gKiBpcmM6Y2hhdC5mcmVlbm9kZS5uZXQ6NjY2
Ny9jaXANCj4gDQo+IExhc3QgbWVldGluZyBtaW51dGVzOg0KPiBodHRwczovL2lyY2xvZ3MuYmFz
ZXJvY2sub3JnL21lZXRpbmdzL2NpcC8yMDIwLzA1L2NpcC4yMDIwLTA1LTE0LTA5LjAwDQo+IC5s
b2cuaHRtbA0KPiANCj4gQWdlbmRhOg0KPiANCj4gKiBBY3Rpb24gaXRlbQ0KPiAxLiBDb21iaW5l
IHJvb3QgZmlsZXN5c3RlbSB3aXRoIGtzZWxmdGVzdCBiaW5hcnkgLSBpd2FtYXRzdQ0KDQpObyB1
cGRhdGUuDQoNCj4gMi4gU3RyZW5ndGhlbiBzdXN0YWluYWJsZSBwcm9jZXNzIHRvIGJhY2twb3J0
IHBhdGNoZXMgZnJvbSANCj4gTWFpbmxpbmUvTFRTIC0gS2VybmVsIFRlYW0gMy4gVXBsb2FkIGEg
Z3VpZGVsaW5lIGZvciByZWZlcmVuY2UgDQo+IGhhcmR3YXJlIHBsYXRmb3JtIGFkZGl0aW9uIC0g
bWFzYXNoaTkxMCA0LiBQcm9wb3NlIGEgcmVkdWN0aW9uIG9mIA0KPiBrZXJuZWwgcmVwb3NpdG9y
eSBtaXJyb3JzIHRvIFRTQyAgLSBtYXNhc2hpOTEwLCBzemxpbiA1LiBQb3N0IExUUCANCj4gcmVz
dWx0cyB0byBLZXJuZWxDSSAtIHBhdGVyc29uYyA2LiBBc2sgYm9hcmQgb3duZXJzIHRvIHJldmll
dyANCj4gcmVmZXJlbmNlIHBsYXRmb3JtIGNvbmZpZ3MgdG8gb3B0aW1pemUgYmFja3BvcnRpbmcg
LSBtYXNhc2hpOTEwDQo+IA0KPiANCj4gKiBLZXJuZWwgbWFpbnRlbmFuY2UgdXBkYXRlcw0KDQpJ
IHJldmlld2VkIHY0LDQuMjIzIGFuZCAyMjQuDQpBbmQgSSBzZW50IGEgcGF0Y2ggZm9yIGZpeGlu
ZyBDVkUtMjAyMC0xMjc2OSB0byA0LjQsIGFuZCA0LjkgYW5kIDMuMTYuDQpUaGlzIHdhcyBhbHJl
YWRseSBhcHBsaWVkIHRvIGVhY2ggTFRTIHRyZWUuDQoNCj4gKiBLZXJuZWwgdGVzdGluZw0KPiAq
IENJUCBDb3JlDQo+ICogU29mdHdhcmUgdXBkYXRlDQo+ICogQ0lQIFNlY3VyaXR5DQo+ICogQU9C
DQo+IA0KPiBUaGUgbWVldGluZyB3aWxsIHRha2UgMzAgbWluLCBhbHRob3VnaCBpdCBjYW4gYmUg
ZXh0ZW5kZWQgdG8gYW4gaG91ciANCj4gaWYgaXQgbWFrZXMgc2Vuc2UgYW5kIHRob3NlIGludm9s
dmVkIGluIHRoZSB0b3BpY3MgY2FuIHN0YXkuIE90aGVyd2lzZSwgdGhlIHRvcGljIHdpbGwgYmUg
dGFrZW4gb2ZmbGluZSBvciBpbiB0aGUgbmV4dCBtZWV0aW5nLg0KDQpCZXN0IHJlZ2FyZHMsDQog
IE5vYnVoaXJvDQoNCg==

--pM3z7W61xUkjw6ZDeqF3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4638): https://lists.cip-project.org/g/cip-dev/message=
/4638
Mute This Topic: https://lists.cip-project.org/mt/74364606/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--pM3z7W61xUkjw6ZDeqF3--
