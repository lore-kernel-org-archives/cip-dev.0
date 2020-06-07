Return-Path: <SRS0=53H3=7U=lists.cip-project.org=bounce+64572+4731+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C61C433E0
	for <cip-dev@archiver.kernel.org>; Sun,  7 Jun 2020 23:35:37 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46681206F6
	for <cip-dev@archiver.kernel.org>; Sun,  7 Jun 2020 23:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="dOFcYDPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46681206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4731+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id lXkVYY4521723x8bJMCxrTYH; Sun, 07 Jun 2020 16:35:36 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web11.19264.1591572932837869489
 for <cip-dev@lists.cip-project.org>;
 Sun, 07 Jun 2020 16:35:34 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 057NZMG6015872; Mon, 8 Jun 2020 08:35:22 +0900
X-Iguazu-Qid: 2wHHQAbmvaDg0i6YzY
X-Iguazu-QSIG: v=2; s=0; t=1591572922; q=2wHHQAbmvaDg0i6YzY; m=9YnNQWXABdBknxO7yz7y59N26/NhDGqZLuZHU8dZMrE=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1113) id 057NZKjG007868;
	Mon, 8 Jun 2020 08:35:21 +0900
X-Received: from enc01.localdomain ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 057NZKaG007862;
	Mon, 8 Jun 2020 08:35:20 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.localdomain  with ESMTP id 057NZKmY018994;
	Mon, 8 Jun 2020 08:35:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQKkQw8YIfs954Drk76uY+i2HnL9uYLJNQZ+fkr/mhydTO8YlgTsSKohWulM7AFtIuOhfFcWKRf7xMirqglGwx6D7R+76DNlSVylXmj1EWIDXZTUacqBMzbyq1hjzm+DVBEkyLlcA7dUdEgssGWN5Dd5ztAgEENFE3duNjOJ3sWVT84n/1t/T4v6QKh65cWuY9ofagWnrLmEn8aXZfh9oXqJMn/7+1IxxigOTSPgyrid9Y2ZiECO73aZj8ovn70LmlMiscgMnQk4SnYpK61rzpzv4CDZfyTjZzhPkzjWM3GUuZJWI8Dx/f5mTlZrOipbeXxx0fZQmrRwBGWJtDndQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UkktL3KR9jE4OhLCOf9EalTQTFsit3gyQoieWCh4xU=;
 b=EiGgcVW3/w6oe1srRrHiD+EGKZS41H0Kcwy+uxjOFcdLaoMWzDcKZe93/IQI4ISjL+f6M6pjfbw+EbB+8YNBkTSIOW/OzBM3Qi6UVsrCjsThqOg6z6uMkwBrFffEr4NbNlC3rl8Om0YOVbtAF7+ikfo0RNQ8NKD+wbJ2yIZpu7ovQENC6eiOfW6CP8GMg2A7rwAHfRtkUJQO4Ny9AS73+F8QIeOuGfMbxPV0Y15vbw0qN3w27kvYysWV/B7PWylVA73F5HUs2mIm2Erdh+13rLnHszlfs1G9xJEjwrCPIIlt9PLZTpLjCr2U7x6TdqRyYqSnXZZ5di8k+Rut319DdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <JohnsonCH.Chen@moxa.com>
CC: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev][PATCH 4.4.y-cip 1/2] ARM: DTS: am33xx: Use the new DT bindings for the eDMA3
Thread-Topic: [cip-dev][PATCH 4.4.y-cip 1/2] ARM: DTS: am33xx: Use the new DT
 bindings for the eDMA3
Thread-Index: AdY7G8WKfCaPk2RlSCampVV/E3SVxAAYwyCAAGkGEPA=
Date: Sun, 7 Jun 2020 23:35:17 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB29836250FB729954DEE8B3ED92840@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <HK2PR01MB32816B8BCBF222E046FE5524FA860@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
 <20200605211813.GA8852@amd>
In-Reply-To: <20200605211813.GA8852@amd>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e54b98a-d809-4b0e-18f4-08d80b3b6f7f
x-ms-traffictypediagnostic: OSBPR01MB3096:
x-microsoft-antispam-prvs: <OSBPR01MB309679499D99266BC52EAA2192840@OSBPR01MB3096.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dW+aPTgLLdYEj5uXVuOJsFBvU3Pm+6QMgyMV3c1WC7RpjcRFiJS9riULjFLg4F5Q6txV6CBBdGfyAptPM0XODiRAGdHzke49rYiQphU3bY6azMrdFmvSDLgA8NMOb4iCFXxdy772zGhF935sUGs45ZZ8PDNB2ZZ5C6HC9U79nTBoTaK6Io6LrKSPQm06BXGy5Ux4mmOVjZzlNkm+CGy+V56uPf84iZlt37bZmZzjzlp1atMl96M5mf8Z0OwHgvYjVLDLadBgTbblz+71wcEdiUAGXidRD27fYT7I9DzwaKYU2czoYUhMlh8EMojVHCQwBKV2eaOxTp1aWDQb0rK6kA==
x-ms-exchange-antispam-messagedata: 9xJX4AFwtpOqIEXpRNQTYNTpjDbdcuwosiBYs3cr5CPvVLHKW5e5cel8YOjrsMOrGlX4XTnRDj1brDVMlACTjY9xIF7sPK6pZtcew2FrpmVPojk6uG4uUbyj1DkEvTViYVn3QIVa+Mm0qVrK6DkLNPtawqDN3Y7ns+4ucW4t/o6e5pc1XoftTbmHKfWWvpZW5k0ulKrftecMqGettswIZGFnCQpjI9T6Jc7ZSyW4g3q101wpgrnCbQUxDJq0hdlPxv6tpPiMFJ3zRjiwXMvpjK+oofaLHX5WPu2oiSXm0DjclaRCYDptsI60ghM2bZ31XbrT6T4dXdX6SQqYTmWsFmUAvtI0PNwY3cByIUW3wx3AGmn7dBCHgwvW/ZDG9DRIW2k0e9Hs2BnAxThA9l/JztC6VNmkLKgchZPFOgg7tCnJdWtu06gGbUg0l5dhaSa3bam1YRbYZGZCUdFzaMTk3pMYr+aw7bragysSjPx2C/Y=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e54b98a-d809-4b0e-18f4-08d80b3b6f7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2020 23:35:17.4041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fRCurzaqN/G/XD9cfBrN+rHsMdmX8M5xD9assPwfK/qZspxqzUe/1fw+Ey3G0ESsLqb2HjpmZ252b2/dEExSLCjoxVbXp0NB9jOptNPG1s7sZ8MRVrrjkByTOdoK8yDv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3096
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: F2NgnrrdQn285EkSvDHNWqFgx4520388AA=
Content-Type: multipart/mixed; boundary="A54ajvKa8tH2KmHagRQ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591572936;
 bh=57jmzJ4kR8fFqTWWKTYnVUrgzi4sO1QILxlasK5LFdo=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=dOFcYDPFsP1CgiYN4PI6qPUQePzbo/vkYSPGFQgjEAbwdBuwCsvnKyVOuPzR29WK6I5
 S5BcXt7DRMEitRu57LBb6+YbdMMURZ6BFFi3IcJwLJIXDlJpFiGWUh3Vx+M55vTETz856
 CWYM+XBu0d8NRT8hKcLK/OIh9AHVyVpQV8A=

--A54ajvKa8tH2KmHagRQ4
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF2ZWwgTWFjaGVr
IFttYWlsdG86cGF2ZWxAZGVueC5kZV0NCj4gU2VudDogU2F0dXJkYXksIEp1bmUgNiwgMjAyMCA2
OjE4IEFNDQo+IFRvOiBKb2huc29uIENIIENoZW4gKOmZs+aYreWLsykgPEpvaG5zb25DSC5DaGVu
QG1veGEuY29tPg0KPiBDYzogaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDilqHvvLPv
vLfvvKPil6/vvKHvvKPvvLQpIDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD47IHBh
dmVsQGRlbnguZGU7DQo+IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IFN1YmplY3Q6
IFJlOiBbY2lwLWRldl1bUEFUQ0ggNC40LnktY2lwIDEvMl0gQVJNOiBEVFM6IGFtMzN4eDogVXNl
IHRoZSBuZXcgRFQgYmluZGluZ3MgZm9yIHRoZSBlRE1BMw0KPiANCj4gSGkhDQo+IA0KPiA+IEZy
b206IFBldGVyIFVqZmFsdXNpIDxwZXRlci51amZhbHVzaUB0aS5jb20+DQo+ID4NCj4gPiBjb21t
aXQgYjVlNTA5MDY2MDc0MmM4MzhkZGMwYjVkMWEwMDFlNmZlM2Q1YmZkNSB1cHN0cmVhbS4NCj4g
DQo+IEkgZ2V0IHF1aXRlIGEgbG90IG9mIGNvbXBsYWlucyBoZXJlLCBpZiBJIHRyeSB0byBhcHBs
eSBwYXRjaA0KPiBhdXRvbWF0aWNhbGx5IHVzaW5nIGdpdC1hbS4NCj4gDQo+IEFwcGx5aW5nOiBB
Uk06IERUUzogYW0zM3h4OiBVc2UgdGhlIG5ldyBEVCBiaW5kaW5ncyBmb3IgdGhlIGVETUEzDQo+
IC5naXQvcmViYXNlLWFwcGx5L3BhdGNoOjE3OiB0cmFpbGluZyB3aGl0ZXNwYWNlLg0KPiAJZG1h
cyA9IDwmZWRtYV94YmFyIDEyIDAgMQ0KPiAuZ2l0L3JlYmFzZS1hcHBseS9wYXRjaDoxODogdHJh
aWxpbmcgd2hpdGVzcGFjZS4NCj4gCQkmZWRtYV94YmFyIDEzIDAgMj47DQo+IC5naXQvcmViYXNl
LWFwcGx5L3BhdGNoOjU4OiB0cmFpbGluZyB3aGl0ZXNwYWNlLg0KPiAJZG1hcyA9IDwmZWRtYV94
YmFyIDEyIDAgMQ0KPiAuZ2l0L3JlYmFzZS1hcHBseS9wYXRjaDo1OTogdHJhaWxpbmcgd2hpdGVz
cGFjZS4NCj4gCQkmZWRtYV94YmFyIDEzIDAgMj47DQo+IC5naXQvcmViYXNlLWFwcGx5L3BhdGNo
OjcxOiB0cmFpbGluZyB3aGl0ZXNwYWNlLg0KPiAJCQkJZWRtYV94YmFyOiBkbWEtcm91dGVyQGY5
MCB7DQo+IGVycm9yOiBwYXRjaCBmYWlsZWQ6IGFyY2gvYXJtL2Jvb3QvZHRzL2FtMzM1eC1ldm0u
ZHRzOjc0Mw0KPiBlcnJvcjogYXJjaC9hcm0vYm9vdC9kdHMvYW0zMzV4LWV2bS5kdHM6IHBhdGNo
IGRvZXMgbm90IGFwcGx5DQo+IGVycm9yOiBwYXRjaCBmYWlsZWQ6IGFyY2gvYXJtL2Jvb3QvZHRz
L2FtMzM1eC1wZXBwZXIuZHRzOjMzOQ0KPiBlcnJvcjogYXJjaC9hcm0vYm9vdC9kdHMvYW0zMzV4
LXBlcHBlci5kdHM6IHBhdGNoIGRvZXMgbm90IGFwcGx5DQo+IGVycm9yOiBwYXRjaCBmYWlsZWQ6
IGFyY2gvYXJtL2Jvb3QvZHRzL2FtMzN4eC5kdHNpOjE2Mg0KPiBlcnJvcjogYXJjaC9hcm0vYm9v
dC9kdHMvYW0zM3h4LmR0c2k6IHBhdGNoIGRvZXMgbm90IGFwcGx5DQo+IFBhdGNoIGZhaWxlZCBh
dCAwMDAxIEFSTTogRFRTOiBhbTMzeHg6IFVzZSB0aGUgbmV3IERUIGJpbmRpbmdzIGZvciB0aGUg
ZURNQTMNCj4gVGhlIGNvcHkgb2YgdGhlIHBhdGNoIHRoYXQgZmFpbGVkIGlzIGZvdW5kIGluOiAu
Z2l0L3JlYmFzZS1hcHBseS9wYXRjaA0KPiBXaGVuIHlvdSBoYXZlIHJlc29sdmVkIHRoaXMgcHJv
YmxlbSwgcnVuICJnaXQgYW0gLS1jb250aW51ZSIuDQo+IA0KPiBBbmQgaXQgc2VlbXMgdG8gbWUg
cHJvYmxlbSBpcyBpbiBDUi9MRiBsaW5lIGVuZGluZ3MgaW4gdGhlIHBhdGNoOg0KPiANCj4gcGF2
ZWxAYW1kOn4vY2lwL2skIGZpbGUgLmdpdC9yZWJhc2UtYXBwbHkvcGF0Y2gNCj4gLmdpdC9yZWJh
c2UtYXBwbHkvcGF0Y2g6IHVuaWZpZWQgZGlmZiBvdXRwdXQsIEFTQ0lJIHRleHQsIHdpdGggQ1JM
Rg0KPiBsaW5lIHRlcm1pbmF0b3JzDQo+IA0KPiBJIGJlbGlldmUgSSBjb3VsZCBzb21laG93IGNv
bnZpbmNlIGdpdCB0byBhcHBseSBpdCwgYW55d2F5OyBvciBtYXliZQ0KPiB0byBjaGVycnktcGlj
ayBjb21taXRzIGZyb20gbWFpbmxpbmUsIGJ1dC4uLiBDb3VsZCBJIGFzayBmb3IgYSBwYXRjaA0K
PiBzZXJpZXMgdGhhdCBjYW4gYmUgYXBwbGllZCB1c2luZyBnaXQgYW0/DQoNCkkgZ290IHBhdGNo
ZXMgZnJvbSBwYXRjaHdvcmssIEkgY291bGQgYXBwbHkuDQpUaGUgbGluZSBlbmRpbmcgY29kZSBv
ZiB0aGUgcGF0Y2ggb2J0YWluZWQgZnJvbSBwYXRjaHdvcmsgd2FzIExGLg0KU28sIEkgYXBwbGll
ZCBhbmQgcHVzaCB0aGVzZSBwYXRjaGVzLgkNCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0K

--A54ajvKa8tH2KmHagRQ4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4731): https://lists.cip-project.org/g/cip-dev/message=
/4731
Mute This Topic: https://lists.cip-project.org/mt/74689397/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--A54ajvKa8tH2KmHagRQ4--
