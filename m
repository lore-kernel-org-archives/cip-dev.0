Return-Path: <Vijaikumar_Kanagarajan@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA74C43334
	for <webhook@archiver.kernel.org>; Mon, 27 Jun 2022 08:47:47 +0000 (UTC)
Received: from esa1.mentor.iphmx.com (esa1.mentor.iphmx.com [68.232.129.153])
 by mx.groups.io with SMTP id smtpd.web12.39424.1656319665053211240
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jun 2022 01:47:45 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: mentor.com, ip: 68.232.129.153, mailfrom: vijaikumar_kanagarajan@mentor.com)
X-IronPort-AV: E=Sophos;i="5.92,225,1650960000";
   d="scan'208";a="80561341"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa1.mentor.iphmx.com with ESMTP; 27 Jun 2022 00:47:44 -0800
IronPort-SDR: 
 gkMRGUSO3oLyC/Ondk+NgTM+fCo7Nf1bi0OYWo3l5p/XegkmU6VFx+RpsqDbCYd6JTLwnAMdDy
 dAOqbaByRgdSpC4nkC5/k9Wc9QhpTnqjXKbPrn1sU9w/l1IuhO36vhyaF7p9o9NO1lbnz9Q1Cc
 BWxx35vvxF8XVXZPUS4cI75/hzxh6QD0BpFM/Jd7wA9Cpwl85/EjS8nahMl+kxgS/LoHN1+eKh
 Lx/aJYQJItX84VysNB6pH5QPfro8lxAUTFH739v1Daem+W6HGx1H+06ZqV9eQgQQC3uZ8g+/WL
 /1M=
From: "Kanagarajan, Vijaikumar" <Vijaikumar_Kanagarajan@mentor.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "P T,
 Sarath" <Sarath_PT@mentor.com>
Subject: RE: [cip-dev] [isar-cip-core] [PATCH] scripts/start-efishell.sh: Add
 -nographic option
Thread-Topic: [cip-dev] [isar-cip-core] [PATCH] scripts/start-efishell.sh: Add
 -nographic option
Thread-Index: AQHYif3vcGBl5aRFc0u9xY4UdHVkma1i7y6g
Date: Mon, 27 Jun 2022 08:47:42 +0000
Message-ID: <54228d21f64f448a9e2bc77f9d975497@mentor.com>
References: <20220627071206.21277-1-Sarath_PT@mentor.com>
 <665fa99b-7ab0-1b8c-3662-c1f1ad7a8d4c@siemens.com>
In-Reply-To: <665fa99b-7ab0-1b8c-3662-c1f1ad7a8d4c@siemens.com>
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
 <cip-dev@lists.cip-project.org>; Mon, 27 Jun 2022 08:47:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8601

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0cy5j
aXAtcHJvamVjdC5vcmcgPGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPiBPbg0KPiBCZWhh
bGYgT2YgSmFuIEtpc3prYQ0KPiBTZW50OiAyNyBKdW5lIDIwMjIgMTM6NDQNCj4gVG86IFAgVCwg
U2FyYXRoIDxTYXJhdGhfUFRAbWVudG9yLmNvbT47IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qu
b3JnDQo+IFN1YmplY3Q6IFJlOiBbY2lwLWRldl0gW2lzYXItY2lwLWNvcmVdIFtQQVRDSF0gc2Ny
aXB0cy9zdGFydC1lZmlzaGVsbC5zaDogQWRkIC0NCj4gbm9ncmFwaGljIG9wdGlvbg0KPiANCj4g
T24gMjcuMDYuMjIgMDk6MTIsIFNhcmF0aCBQIFQgd3JvdGU6DQo+ID4gRnJvbTogc2FyYXRoIFAg
VCA8U2FyYXRoX1BUQG1lbnRvci5jb20+DQo+ID4NCj4gPiBXaGVuIHdlIGxhdW5jaCB0aGUgc3Rh
cnQtZWZpc2hlbGwuc2ggc2NyaXB0IGZvciBhZGRpbmcgdGhlIGtleXMgaW50bw0KPiA+IE9WTUYg
ZmlybXdhcmUgd2UgZmFjZWQgZ3RrIGluaXRpYWxpemF0aW9uIGZhaWxlZCBlcnJvci4gU28gaXQg
c2VlbXMgd2UNCj4gPiBuZWVkIHRvIG9wZW4gdGhlIE9WTUYgaW4gbm9ncmFwaGljIG1vZGUsIGhl
bmNlIHdlIGFkZGVkIHRoZSByZXF1aXJlZA0KPiA+IG9wdGlvbiB0byB0aGUgc2NyaXB0Lg0KPiA+
DQo+IA0KPiBXaGljaCBRRU1VLVZlcnNpb24/IFdoaWNoIE9WTUYgdmVyc2lvbiAoYnVzdGVyL2J1
bGxzZXllL3NvbWV0aGluZw0KPiBlbHNlKT8NCj4gSSdtIG5vdCBzZWVpbmcgdGhpcywgYnV0IEkn
bSBmYWNpbmcgb3RoZXIgaXNzdWVzIHdpdGggdGhhdCBmaXJtd2FyZSBwcm92aWRlZCBieQ0KPiBi
dWxsc2V5ZSAoYSBjcmFzaCkuDQoNCk5vcGUuIE5vdCByZWxhdGVkIHRvIE9WTUYgY3Jhc2hlcy4g
VGhpcyBpcyBqdXN0IHRvIG1ha2UgdGhlIHNjcmlwdCB3b3JrIG9uIGhlYWRsZXNzIHN5c3RlbXMv
b3ZlciBzc2guDQoNClNhcmF0aCwgDQpDYW4geW91IHNlbmQgYSBWMiB3aXRoIGEgbW9kaWZpZWQg
Y29tbWl0IG1lc3NhZ2UuIFRoZSBsYXR0ZXIgaGFsZiBpcyBhIGJpdCBtaXNsZWFkaW5nLiBQcm9i
YWJseSB5b3UgbWVhbnQNCiJvcGVuIFFFTVUiIGFuZCBub3QgT1ZNRi4NCg0KVGhhbmtzLA0KVmlq
YWkgS3VtYXIgSw0KDQoNCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogc2FyYXRoIFAgVCA8U2FyYXRo
X1BUQG1lbnRvci5jb20+DQo+ID4gLS0tDQo+ID4gIHNjcmlwdHMvc3RhcnQtZWZpc2hlbGwuc2gg
fCAyICstDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL3NjcmlwdHMvc3RhcnQtZWZpc2hlbGwuc2ggYi9zY3Jp
cHRzL3N0YXJ0LWVmaXNoZWxsLnNoDQo+ID4gaW5kZXggZDQ1MWY0My4uMDgzMWY4MyAxMDA3NTUN
Cj4gPiAtLS0gYS9zY3JpcHRzL3N0YXJ0LWVmaXNoZWxsLnNoDQo+ID4gKysrIGIvc2NyaXB0cy9z
dGFydC1lZmlzaGVsbC5zaA0KPiA+IEBAIC0yLDcgKzIsNyBAQA0KPiA+ICBvdm1mX2NvZGU9JHtP
Vk1GX0NPREU6LS91c3Ivc2hhcmUvT1ZNRi9PVk1GX0NPREUuc2VjYm9vdC5mZH0NCj4gPiAgb3Zt
Zl92YXJzPSR7T1ZNRl9WQVJTOi0uL09WTUZfVkFSUy5mZH0NCj4gPiAgRElTSz0kMQ0KPiA+IC1x
ZW11LXN5c3RlbS14ODZfNjQgLWVuYWJsZS1rdm0gLU0gcTM1IFwNCj4gPiArcWVtdS1zeXN0ZW0t
eDg2XzY0IC1lbmFibGUta3ZtIC1NIHEzNSAtbm9ncmFwaGljIFwNCj4gPiAgICAgICAgICAgICAg
ICAgICAgIC1jcHUgaG9zdCxodl9yZWxheGVkLGh2X3ZhcGljLGh2LXNwaW5sb2Nrcz0weGZmZiAt
c21wIDIgLW0gMkcgLQ0KPiBuby1ocGV0IFwNCj4gPiAgICAgICAgICAgICAgICAgICAgIC1nbG9i
YWwgSUNIOS1MUEMuZGlzYWJsZV9zMz0xIFwNCj4gPiAgICAgICAgICAgICAgICAgICAgIC1nbG9i
YWwgaXNhLWZkYy5kcml2ZUE9IFwNCj4gSmFuDQo+IA0KPiAtLQ0KPiBTaWVtZW5zIEFHLCBUZWNo
bm9sb2d5DQo+IENvbXBldGVuY2UgQ2VudGVyIEVtYmVkZGVkIExpbnV4DQo=

