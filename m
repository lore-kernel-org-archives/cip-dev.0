Return-Path: <Vijaikumar_Kanagarajan@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFDCC433EF
	for <webhook@archiver.kernel.org>; Tue,  7 Jun 2022 15:23:11 +0000 (UTC)
Received: from esa3.mentor.iphmx.com (esa3.mentor.iphmx.com [68.232.137.180])
 by mx.groups.io with SMTP id smtpd.web12.13977.1654615387698377227
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Jun 2022 08:23:07 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: mentor.com, ip: 68.232.137.180, mailfrom: vijaikumar_kanagarajan@mentor.com)
X-IronPort-AV: E=Sophos;i="5.91,284,1647331200";
   d="scan'208";a="76791593"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa3.mentor.iphmx.com with ESMTP; 07 Jun 2022 07:23:06 -0800
IronPort-SDR: 
 Jt+aKWxjBxXiH73BnuAqEhSXYewaKoPh8zQaBQ1JMcgO29FGQvPOoMRmQZV1SXGiYEGfsf07xa
 WC1fOFtljKbfb3rr/TVAMpyJjmQyYI/HcQnGf1tC62n22r8ttxYk7fETQBKy9DbJrBVzR9iluB
 nvOEr1IpyACaesz6xHS/n/h/jx0tOC0D1R/sSCJq3MxwsOHMv2+m6tuAnbcaUEJ9PQrSb+FOQf
 prBdWQMCAVnsKEfOTtZ6G2vhpr40CLhZT7glftSCxpzd6MOLpv5KesdncvZ2TV+mCKwfCVqP7a
 oWo=
From: "Kanagarajan, Vijaikumar" <Vijaikumar_Kanagarajan@mentor.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, "quirin.gylstorff@siemens.com"
	<quirin.gylstorff@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: [isar-cip-core][PATCH 3/3] recipes-core/ltp: Disable autotest
Thread-Topic: [isar-cip-core][PATCH 3/3] recipes-core/ltp: Disable autotest
Thread-Index: AQHYenWcRgx7Hiog6kiGRvHcdCvZZq1Eg12A//+K2yA=
Date: Tue, 7 Jun 2022 15:23:03 +0000
Message-ID: <d29949d0f6024531a8fe01299f8a25f0@mentor.com>
References: <20220607135016.1856603-1-Vijaikumar_Kanagarajan@mentor.com>
 <20220607135016.1856603-4-Vijaikumar_Kanagarajan@mentor.com>
 <ba27551b-f111-2cad-f479-0e734e4814a8@siemens.com>
In-Reply-To: <ba27551b-f111-2cad-f479-0e734e4814a8@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [147.34.91.1]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Jun 2022 15:23:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8513

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFuIEtpc3prYSA8amFu
Lmtpc3prYUBzaWVtZW5zLmNvbT4NCj4gU2VudDogMDcgSnVuZSAyMDIyIDIwOjQ2DQo+IFRvOiBL
YW5hZ2FyYWphbiwgVmlqYWlrdW1hciA8VmlqYWlrdW1hcl9LYW5hZ2FyYWphbkBtZW50b3IuY29t
PjsNCj4gcXVpcmluLmd5bHN0b3JmZkBzaWVtZW5zLmNvbTsgY2lwLWRldkBsaXN0cy5jaXAtcHJv
amVjdC5vcmcNCj4gU3ViamVjdDogUmU6IFtpc2FyLWNpcC1jb3JlXVtQQVRDSCAzLzNdIHJlY2lw
ZXMtY29yZS9sdHA6IERpc2FibGUgYXV0b3Rlc3QNCj4gDQo+IE9uIDA3LjA2LjIyIDE1OjUwLCBW
aWphaSBLdW1hciBLIHdyb3RlOg0KPiA+IEZpeGVzIHRoZSBmb2xsb3dpbmcgZXJyb3IgZHVyaW5n
IGNyb3NzLWJ1aWxkLg0KPiA+DQo+ID4gTWFrZWZpbGU6MjA3OiAqKiogcnVubmluZyB0ZXN0cyBv
biBjcm9zcy1jb21waWxlIGJ1aWxkIG5vdCBzdXBwb3J0ZWQuDQo+IFN0b3AuDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBWaWphaSBLdW1hciBLIDxWaWphaWt1bWFyX0thbmFnYXJhamFuQG1lbnRv
ci5jb20+DQo+ID4gLS0tDQo+ID4gIHJlY2lwZXMtY29yZS9sdHAvZmlsZXMvZGViaWFuL3J1bGVz
IHwgMiArKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvcmVjaXBlcy1jb3JlL2x0cC9maWxlcy9kZWJpYW4vcnVsZXMNCj4gPiBiL3Jl
Y2lwZXMtY29yZS9sdHAvZmlsZXMvZGViaWFuL3J1bGVzDQo+ID4gaW5kZXggYTQ4NTYxNS4uMDZi
OTA3MCAxMDA3NTUNCj4gPiAtLS0gYS9yZWNpcGVzLWNvcmUvbHRwL2ZpbGVzL2RlYmlhbi9ydWxl
cw0KPiA+ICsrKyBiL3JlY2lwZXMtY29yZS9sdHAvZmlsZXMvZGViaWFuL3J1bGVzDQo+ID4gQEAg
LTgsMyArOCw1IEBAIExUUF9DT05GSUdVUkVfRkxBR1MgPSAtLXByZWZpeD0vb3B0L2x0cA0KPiA+
DQo+ID4gIG92ZXJyaWRlX2RoX2F1dG9fY29uZmlndXJlOg0KPiA+ICAJZGhfYXV0b19jb25maWd1
cmUgLS0gJChMVFBfQ09ORklHVVJFX0ZMQUdTKQ0KPiA+ICsNCj4gPiArb3ZlcnJpZGVfZGhfYXV0
b190ZXN0Og0KPiANCj4gV2FzIHRoYXQgYWxyZWFkeSB0aGUgY2FzZSB3aXRoIHRoZSBwcmV2aW91
cyB2ZXJzaW9uPyBJZiBub3QsIHRoaXMgc2hvdWxkDQo+IHByb2JhYmx5IGJlIG1vdmVkIHRoZSBm
cm9udCBvZiB0aGUgc2VyaWVzLCByaWdodD8NCg0KVGhlIHByZXZpb3VzIHZlcnNpb24gZGlkIG5v
dCBidWlsZCBzdWNjZXNzZnVsbHkuIFRoZSBidWlsZCB3YXMgYnJva2VuLg0KU2luY2UgSSB3YXMg
dXByZXZpbmcsIEkgZGlkIG5vdCBkaWcgbXVjaCBvbiB3aHkgaXQgZmFpbGVkLg0KDQpUaGFua3Ms
DQpWaWphaSBLdW1hciBLDQoNCj4gDQo+IEphbg0KPiANCj4gLS0NCj4gU2llbWVucyBBRywgVGVj
aG5vbG9neQ0KPiBDb21wZXRlbmNlIENlbnRlciBFbWJlZGRlZCBMaW51eA0K

