Return-Path: <SRS0=6CaM=6T=lists.cip-project.org=bounce+64572+4614+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5C9C47254
	for <cip-dev@archiver.kernel.org>; Tue,  5 May 2020 11:05:45 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F8F206D7
	for <cip-dev@archiver.kernel.org>; Tue,  5 May 2020 11:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="P07wTLO7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F8F206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=moxa.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4614+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id RU4uYY4521723xcsyr3AYSHG; Tue, 05 May 2020 04:05:44 -0700
X-Received: from APC01-SG2-obe.outbound.protection.outlook.com (APC01-SG2-obe.outbound.protection.outlook.com [40.107.131.71])
 by mx.groups.io with SMTP id smtpd.web10.5420.1588676742837999631
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 May 2020 04:05:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyHArj4003g9YH+QcAfPt9VqedkfNIjZ1AOo4Kxp+xoyplc0w8Wc1EzQYcRkNQjUikKQqfR62CPUuHnhUnAZY5X2Zv1ahh4PpfobZjdJ/hRX1DCB7OMhzhDpu8AL7e/prZ65WCFtxk356hZW0uV+QpGaUD/yJlDD6lpHy+EjCvZ4a3n5oBBs+P+ImqT0SUvC/LPZsEbPRPkAxaCLAM8sU4psSinX+1VXXyxyhxBaEoxzZ2/D7zZLPNAV2kxJfqiU1sgtIyEeKD5ojYYQ+dz4rMufx0gXDFLhI4lGWv/nFg+7HjwQ8iYQDMo6g3oeytPIaN/m1YOmJ86R7q2foOBdTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hp1loAvR5oebXRuU8T7j5L0i3ubxpyeDT1Q+BbmsIQc=;
 b=myfsINx2FagYkGrm2eP/A22mkl8cfas10V3CjiBSlMUVeavfNWOpen1YRI1bNK+t62dN0yZFXh51W/Z3POMqxxicFOK98YwbCvneabHC4Zg/S5Mb0zmRMDvK28SZqM7kU7G7l5fZ6OFMGwhBedf0rj2stYIf72s/HFwDOMI9BCwIZYUP7nl1CDG0hZL1mNUozZ8yuA6q2AGFUeUlpJlzMU06fZ2sbbMSzWkOjyGUorajacMLGkRypoi4k8igHp1lnxe6ckqtSBToEnpIcMTNT5chz6VbyIeRWAj7xxPzdfjpGEj/xuKKTy+w7fJ7G0fmmFAWYjr2bNZ2VQohs55eaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
X-Received: from HK2PR01MB3281.apcprd01.prod.exchangelabs.com
 (2603:1096:202:22::12) by HK0SPR01MB0011.apcprd01.prod.exchangelabs.com
 (2603:1096:203:5e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Tue, 5 May
 2020 11:05:39 +0000
X-Received: from HK2PR01MB3281.apcprd01.prod.exchangelabs.com
 ([fe80::712b:170d:f873:68a3]) by HK2PR01MB3281.apcprd01.prod.exchangelabs.com
 ([fe80::712b:170d:f873:68a3%6]) with mapi id 15.20.2958.030; Tue, 5 May 2020
 11:05:39 +0000
From: "johnsonch.chen@moxa.com" <JohnsonCH.Chen@moxa.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"pavel@denx.de" <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 3/3] cpufreq: ti: Add cpufreq driver to determine available OPPs at runtime
Thread-Topic: [PATCH 4.4.y-cip 3/3] cpufreq: ti: Add cpufreq driver to
 determine available OPPs at runtime
Thread-Index: AdYelqlUPJYYZ9pGSFeLKUKE4WiSEwBBKnaAAHhQLrAAU+1ckA==
Date: Tue, 5 May 2020 11:05:38 +0000
Message-ID: 
 <HK2PR01MB3281E10CB1D93D1B63186D6DFAA70@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
References: 
 <HK2PR01MB3281A0A027BAB0F4F036AC7AFAAA0@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
 <20200501093143.GB11782@amd>
 <OSAPR01MB366796B3E21B6E23A8B394E592A90@OSAPR01MB3667.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSAPR01MB366796B3E21B6E23A8B394E592A90@OSAPR01MB3667.jpnprd01.prod.outlook.com>
Accept-Language: zh-TW, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [123.51.145.16]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: efdb1d42-cb61-40de-e9de-08d7f0e43ebb
x-ms-traffictypediagnostic: HK0SPR01MB0011:
x-microsoft-antispam-prvs: 
 <HK0SPR01MB0011754EEF901A05381F864CFAA70@HK0SPR01MB0011.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 HTVhqFyCnxs+oVmEr4tv42LBf086ALAMm9MaGmhRIZ3mnoQ6tg7WxgNPJj9Y/yn5+EPDLk66SWsEDc8YmtpV6FT3CWzVvm3dVLUF2iaANZrxiC0vCk7kGBHfzXz9uBBbprNKG5PoV67GUEGfh6AfdLqlUhI+bDPAxm0ZW1Sia7w8udmmnAa7fowXEyNyOH4r5yU9cu9QLsQkPf+QC+h62PWb1ty6MamA1DgVFmGPbpYBM7kdupI9UeWaixQ8swEoIq/bHbs/bhySKMOeNXe+0wku1eLW3Ap/Xrq7HvThm6sQb7OXcJLtgGQnAnH2QGwHIyd+s7ukPkTpVQ+veCT+bLkJVWO3RXWcIb1tonb+iPKrUlJ4yqgDpf/b9ocJ2O4YiQWLgkXZolZ+MZ9p8um5ug6mgtv8+09RAX+T68zoQUkjyBRjyXWqD3JFhLvBNiZjnCwCrN8LU8jFqA4DEPPIeqdrVFb2DoqEd7nfLlJE08jqEnDP0XoXo1vWgcYvDaEjRdSwvWr5Gpz5wwa7qE3PLYHxLh0C3zgqruS42uUGLQs=
x-ms-exchange-antispam-messagedata: 
 Wvm+UABNnTCKsvYIF3t1IASy2I+9mskpgS5ASEYDVShYCh6DxJFZ0R3SKJraLqqf/nJB31dk67xZWfILunC81KQjnqiy17X3sQKdC8nU4CujlQwGxhLRTBb6elkwrMnTz0UcF0fhetZ0pE+l5aylPTsGpMT4rcRywPPz10h8oDwCM2cmA7sKJsd9G19SG0lNy84r1XN20VCeHulMsgHHx2QqZWwfujTG0/Z3JLtq+tog9+MajngnydtdVNiHr2R0sTBHJ/CN6UI0dfCMheyReyzjqtm8Xwfl+V/DE8a5sFkl8Ua+VivtjGaHFsXupPSQtK9HEqgtLGhkpR5KcpvVzN/XtcZjIGkkBfd0LTlZnbI3CgQ5ozVrAsU66YIggPQZAY66mxfM11DaucX3pXkgYOczVTATJ9KIHshYcrcOwl9i+uTBNYTMLvOsTN6jp6pWrMpKls1R9vRrjm/G8hSkkzwEMal5EWspHBO0TD5nqgpc87Lgm7BWmc9KZ52IM3UWIR0wKEVm2f11mt8jOFgrsXkJM5pjdIC57I9PFXXBiL9UyvbYdQ2lklKIiAlaRjXuKhMyqDM+6FvZ0pgKs5n0y1m7jNLOGfT3TxXtdX+pgphSMCfMQgMUxSGKEsH1u5WPnM5F3wb+PECGNTEtKx0x7a/UU59Yr7jE4GSNsPef54KkF7O4gbXMGVBXGxIt0IDMAp7cIp2MaNYAWPCkhiCT0c3eL2cyUn7T4tv/fQcD/9lVD3DYtoV82t2v4pP8AEDuwKhDG6LnsoYHclT7mOH7fxdv8v9Zn3Iz+5dVwcanM8A=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efdb1d42-cb61-40de-e9de-08d7f0e43ebb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2020 11:05:38.9588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cdNrosEy2YueNG+r3agOHYzOVU8erf5PamPn5jc620S+no/YN/xieeASMB/ZugS+zRtTncZeGFzc2FIUpvUM2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0SPR01MB0011
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: R5pEPkKTKl2lm6fn3FMPqEgJx4520388AA=
Content-Type: multipart/mixed; boundary="TPfCMvLpfD1OfrLkhxOd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1588676744;
 bh=Io7fmoEAB7j5GqSL5S3U47bUqF0id3KMZBxKfVW4W6Q=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=P07wTLO7kJ8EBsrbMYkSUXFBlqfBjqYmW65SVlIQMJkWVYJVju8DyBdmy98DIC9ABfg
 kISbxTaKf5wlhVeV/+H01oVXqtBpC8aYpIUepuFCfVGiFhKnaO/N7uTp1+Sk0twP1UHDZ
 ZzSQ7DYBjTaMBXmGjbEa3o7sggO87KR2twI=

--TPfCMvLpfD1OfrLkhxOd
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4NCj4gSGksDQo+DQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBG
cm9tOiBQYXZlbCBNYWNoZWsgW21haWx0bzpwYXZlbEBkZW54LmRlXQ0KPiA+IFNlbnQ6IEZyaWRh
eSwgTWF5IDEsIDIwMjAgNjozMiBQTQ0KPiA+IFRvOiBKb2huc29uIENIIENoZW4gKOmZs+aYreWL
sykgPEpvaG5zb25DSC5DaGVuQG1veGEuY29tPg0KPiA+IENjOiBjaXAtZGV2QGxpc3RzLmNpcC1w
cm9qZWN0Lm9yZzsgaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDilqHvvLPvvLfvvKPi
l6/vvKHvvKPvvLQpDQo+ID4gPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPjsgcGF2
ZWxAZGVueC5kZQ0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNC40LnktY2lwIDMvM10gY3B1ZnJl
cTogdGk6IEFkZCBjcHVmcmVxIGRyaXZlciANCj4gPiB0byBkZXRlcm1pbmUgYXZhaWxhYmxlIE9Q
UHMgYXQgcnVudGltZQ0KPiA+DQo+ID4gSGkhDQo+ID4NCj4gPiA+IEZyb206IERhdmUgR2VybGFj
aCA8ZC1nZXJsYWNoQHRpLmNvbT4NCj4gPiA+DQo+ID4gPiBjb21taXQgZTEzY2YwNDZjZDcwODk0
MzkzYTEwODVjYTM5ZGE3ZWY3NTEzNTNmYiB1cHN0cmVhbQ0KPiA+ID4NCj4gPiA+IFNvbWUgVEkg
U29DcywgbGlrZSB0aG9zZSBpbiB0aGUgQU0zMzV4LCBBTTQzN3gsIERSQTd4LCBhbmQgQU01N3gg
DQo+ID4gPiBmYW1pbGllcywgaGF2ZSBkaWZmZXJlbnQgT1BQcyBhdmFpbGFibGUgZm9yIHRoZSBN
UFUgZGVwZW5kaW5nIG9uIA0KPiA+ID4gd2hpY2ggc3BlY2lmaWMgdmFyaWFudCBvZiB0aGUgU29D
IGlzIGluIHVzZS4gVGhpcyBjYW4gYmUgDQo+ID4gPiBkZXRlcm1pbmVkIHRocm91Z2ggdXNlIG9m
IHRoZSByZXZpc2lvbiBhbmQgYW4gZUZ1c2UgcmVnaXN0ZXIgDQo+ID4gPiBwcmVzZW50IGluIHRo
ZSBzaWxpY29uLiBJbnRyb2R1Y2UgYSB0aS1jcHVmcmVxIGRyaXZlciB0aGF0IGNhbiANCj4gPiA+
IHJlYWQgdGhlIGFmb3JtZW50aW9uZWQgdmFsdWVzIGFuZCBwcm92aWRlIHRoZW0gYXMgdmVyc2lv
biBtYXRjaGluZyANCj4gPiA+IGRhdGEgdG8gdGhlIG9wcCBmcmFtZXdvcmsuIFRocm91Z2ggdGhp
cyB0aGUgb3BwLXN1cHBvcnRlZC1odyBkdCANCj4gPiA+IGJpbmRpbmcgdGhhdCBpcyBwYXJ0IG9m
IHRoZSBvcGVyYXRpbmctcG9pbnRzLXYyIHRhYmxlIGNhbiBiZSB1c2VkIHRvIGluZGljYXRlIGF2
YWlsYWJpbGl0eSBvZiBPUFBzIGZvciBlYWNoIGRldmljZS4NCj4gPiA+DQo+ID4gPiBUaGlzIGRy
aXZlciBhbHNvIGNyZWF0ZXMgdGhlICJjcHVmcmVxLWR0IiBwbGF0Zm9ybV9kZXZpY2UgYWZ0ZXIg
DQo+ID4gPiBwYXNzaW5nIHRoZSB2ZXJzaW9uIG1hdGNoaW5nIGRhdGEgdG8gdGhlIE9QUCBmcmFt
ZXdvcmsgc28gdGhhdCB0aGUgDQo+ID4gPiBjcHVmcmVxLWR0IGhhbmRsZXMgdGhlIGFjdHVhbCBj
cHVmcmVxIGltcGxlbWVudGF0aW9uLiBFdmVuIHdpdGhvdXQgDQo+ID4gPiB0aGUgbmVjZXNzYXJ5
IGRhdGEgdG8gcGFzcyB0aGUgdmVyc2lvbiBtYXRjaGluZyBkYXRhIHRoZSBkcml2ZXIgDQo+ID4g
PiB3aWxsIHN0aWxsIGNyZWF0ZSB0aGlzIGRldmljZSB0byBtYWludGFpbiBiYWNrd2FyZHMgY29t
cGF0aWJpbGl0eSANCj4gPiA+IHdpdGggb3BlcmF0aW5nLXBvaW50cyB2MSB0YWJsZXMuDQo+ID4g
Pg0KPiA+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi4zZGJmNTcxNjRkZWQNCj4gPiA+IC0tLSAvZGV2
L251bGwNCj4gPiA+ICsrKyBiL2RyaXZlcnMvY3B1ZnJlcS90aS1jcHVmcmVxLmMNCj4gPiA+IEBA
IC0wLDAgKzEsMjcyIEBADQo+ID4gPiArLyoNCj4gPiA+ICsgKiBUSSBDUFVGcmVxL09QUCBody1z
dXBwb3J0ZWQgZHJpdmVyDQo+ID4gPiArICoNCj4gPiA+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMTYt
MjAxNyBUZXhhcyBJbnN0cnVtZW50cywgSW5jLg0KPiA+ID4gKyAqICBEYXZlIEdlcmxhY2ggPGQt
Z2VybGFjaEB0aS5jb20+DQo+ID4gPiArICoNCj4gPiA+ICsgKiBUaGlzIHByb2dyYW0gaXMgZnJl
ZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yDQo+ID4gPiArICogbW9k
aWZ5IGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UN
Cj4gPiA+ICsgKiB2ZXJzaW9uIDIgYXMgcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZv
dW5kYXRpb24uDQo+ID4NCj4gPiBJIGd1ZXNzIFNQRFggd291bGQgYmUgYmV0dGVyIHRoYW4gdGhp
cy4NCj4gPg0KPiA+ID4gK3N0YXRpYyBpbnQgdGlfY3B1ZnJlcV9pbml0KHZvaWQpDQo+ID4gPiAr
ew0KPiA+IC4uLg0KPiA+ID4gKyAgIC8qDQo+ID4gPiArICAgICogT1BQcyBkZXRlcm1pbmUgd2hl
dGhlciBvciBub3QgdGhleSBhcmUgc3VwcG9ydGVkIGJhc2VkIG9uDQo+ID4gPiArICAgICogdHdv
IG1ldHJpY3M6DQo+ID4gPiArICAgICogICAgICAwIC0gU29DIFJldmlzaW9uDQo+ID4gPiArICAg
ICogICAgICAxIC0gZUZ1c2UgdmFsdWUNCj4gPiA+ICsgICAgKi8NCj4gPiA+ICsgICByZXQgPSB0
aV9jcHVmcmVxX2dldF9yZXYob3BwX2RhdGEsICZ2ZXJzaW9uWzBdKTsNCj4gPiA+ICsgICBpZiAo
cmV0KQ0KPiA+ID4gKyAgICAgICAgICAgZ290byBmYWlsX3B1dF9ub2RlOw0KPiA+ID4gKw0KPiA+
ID4gKyAgIHJldCA9IHRpX2NwdWZyZXFfZ2V0X2VmdXNlKG9wcF9kYXRhLCAmdmVyc2lvblsxXSk7
DQo+ID4gPiArICAgaWYgKHJldCkNCj4gPiA+ICsgICAgICAgICAgIGdvdG8gZmFpbF9wdXRfbm9k
ZTsNCj4gPiA+ICsNCj4gPiA+ICsgICBvZl9ub2RlX3B1dChvcHBfZGF0YS0+b3BwX25vZGUpOw0K
PiA+ID4gKw0KPiA+ID4gKyAgIHJldCA9IGRldl9wbV9vcHBfc2V0X3N1cHBvcnRlZF9odyhvcHBf
ZGF0YS0+Y3B1X2RldiwNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdmVyc2lvbiwgVkVSU0lPTl9DT1VOVCk7DQo+ID4gPiArICAgaWYgKHJldCkgew0K
PiA+ID4gKyAgICAgICAgICAgZGV2X2VycihvcHBfZGF0YS0+Y3B1X2RldiwNCj4gPiA+ICsgICAg
ICAgICAgICAgICAgICAgIkZhaWxlZCB0byBzZXQgc3VwcG9ydGVkIGhhcmR3YXJlXG4iKTsNCj4g
PiA+ICsgICAgICAgICAgIGdvdG8gZmFpbF9wdXRfbm9kZTsNCj4gPiA+ICsgICB9DQo+ID4NCj4g
PiBUaGlzIHNob3VsZCBiZSAicmV0dXJuIGVyciIsIHdlIGhhdmUgYWxyZWFkeSBwdXQgdGhlIG5v
ZGUgZmV3IGxpbmVzIA0KPiA+IGFib3ZlLg0KPg0KPiBPaCwgdGhhbmtzIGZvciB5b3VyIHBvaW50
aW5nLg0KPiB3ZSBhbHNvIG5lZWQgdG8gYmFja3BvcnQgdGhlIGZvbGxvd2luZyBwYXRjaGU6DQo+
ICAgOWE2ZTkxZDA4ZTc3MDdiYWEyZjgyNDI1NzM0MmNhN2VmY2IxOTliYw0KPg0KVGhpcyBwYXRj
aCBjYW4gZml4IGRvdWJsZS1mcmVlIGlzc3VlLCB0aGFua3MgeW91ciBzdWdnZXN0aW9uIQ0KDQo+
IEFuZCB0aGVyZSBhcmUgb3RoZXIgaXNzdWVzIHRvbywgc28gSSB0aGluayB0aGUgZm9sbG93aW5n
IHBhdGNoZXMgYXJlIGFsc28gbmVlZGVkLg0KPiAwNTgyOWQ5NDMxZGYxYmY2ZGU5ODY3OWZiY2Zi
YWQyODJjMWM1NWE0DQo+IGU1ZDI5NWIwNmQ2OWExOTI0NjY1YTE2YTQ5ODdiZTQ3NWFkZGQwMGYN
Cj4gMjQ4YWVmZGNjM2E3ZTBjZmJkMDE0OTQ2YjRkZWFkNjNlNzUwZTcxYg0KPg0KPiBQbGVhc2Ug
Y2hlY2sgdGhlc2UuDQo+DQpUaGVzZSB0aHJlZSBwYXRjaGVzIGNhbiBzb2x2ZSBvdGhlciBpc3N1
ZXMgZm9yIHRpIGNwdWZyZXEgZHJpdmVyLg0KQmVzaWRlcywgdGkgY3B1ZnJlcSBkcml2ZXIgc2hv
dWxkIGJlIFNQRFgsIGFuZCBpdCBzZWVtcyBubyByZWxhdGVkIHBhdGNoIGluIG1haW5saW5lIGtl
cm5lbC4NCkkgd2lsbCBpbmNsdWRlIGFib3ZlIHBhdGNoZXMgYW5kIFNQRFggaW4gcGF0Y2ggc2Vy
aWVzIHYyLg0KDQo+ID4NCj4gPiA+ICtyZWdpc3Rlcl9jcHVmcmVxX2R0Og0KPiA+ID4gKyAgIHBs
YXRmb3JtX2RldmljZV9yZWdpc3Rlcl9zaW1wbGUoImNwdWZyZXEtZHQiLCAtMSwgTlVMTCwgMCk7
DQo+ID4gPiArDQo+ID4gPiArICAgcmV0dXJuIDA7DQo+ID4gPiArDQo+ID4gPiArZmFpbF9wdXRf
bm9kZToNCj4gPiA+ICsgICBvZl9ub2RlX3B1dChvcHBfZGF0YS0+b3BwX25vZGUpOw0KPiA+ID4g
Kw0KPiA+ID4gKyAgIHJldHVybiByZXQ7DQo+ID4gPiArfQ0KPiA+DQo+ID4gQmVzdCByZWdhcmRz
LA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgUGF2ZWwNCj4NCj4gQmVzdCByZWdhcmRzLA0KPiAgIE5vYnVoaXJvDQo+DQoN
CkJlc3QgcmVnYXJkcywNCkpvaG5zb24NCg==

--TPfCMvLpfD1OfrLkhxOd
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4614): https://lists.cip-project.org/g/cip-dev/message=
/4614
Mute This Topic: https://lists.cip-project.org/mt/73369237/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--TPfCMvLpfD1OfrLkhxOd--
