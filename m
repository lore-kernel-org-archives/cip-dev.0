Return-Path: <Vijaikumar_Kanagarajan@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FA3C433EF
	for <webhook@archiver.kernel.org>; Tue,  7 Jun 2022 18:10:55 +0000 (UTC)
Received: from esa1.mentor.iphmx.com (esa1.mentor.iphmx.com [68.232.129.153])
 by mx.groups.io with SMTP id smtpd.web08.776.1654625452620187998
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Jun 2022 11:10:52 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: mentor.com, ip: 68.232.129.153, mailfrom: vijaikumar_kanagarajan@mentor.com)
X-IronPort-AV: E=Sophos;i="5.91,284,1647331200";
   d="scan'208";a="79584258"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa1.mentor.iphmx.com with ESMTP; 07 Jun 2022 10:10:51 -0800
IronPort-SDR: 
 kG1xJD8GUYMwtSa5iyJXGNcPohaI2ShdnME6QFp0qwgqvwoG8G25n4XERILVrtx0+ZELPuVHoB
 wEupSAZ5xbAmvrS2CjU2omwfOTeAH8O+4qJ2LZ7xfUx2bougtiwcCV0/ksuddHtugzaVXQ9Q5y
 4C/Ng1sYffARAezuxiHE218B5igZRNfKwFLWXuYn2KsZOrMQxyuqweYTOqUO9UU8BsDykInXxt
 poRp+PV6t+RJbnwvo22rdvWA7BNNzRXYgdZiHyst9herix08scnCP2NX2Xi1rnV3vajcHop0Ko
 5co=
From: "Kanagarajan, Vijaikumar" <Vijaikumar_Kanagarajan@mentor.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, "quirin.gylstorff@siemens.com"
	<quirin.gylstorff@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: [isar-cip-core][PATCH 3/3] recipes-core/ltp: Disable autotest
Thread-Topic: [isar-cip-core][PATCH 3/3] recipes-core/ltp: Disable autotest
Thread-Index: 
 AQHYenWcRgx7Hiog6kiGRvHcdCvZZq1Eg12A//+K2yCAAH9XAIAABhqAgAABF4CAABZZAP//k6Mw
Date: Tue, 7 Jun 2022 18:10:49 +0000
Message-ID: <14a27ae2e19d460da6e03286dc103304@mentor.com>
References: <20220607135016.1856603-1-Vijaikumar_Kanagarajan@mentor.com>
 <20220607135016.1856603-4-Vijaikumar_Kanagarajan@mentor.com>
 <ba27551b-f111-2cad-f479-0e734e4814a8@siemens.com>
 <d29949d0f6024531a8fe01299f8a25f0@mentor.com>
 <1e74163c-3e62-f15c-9710-9b29f876782d@siemens.com>
 <09fe54b6-73e2-66f5-a918-82e45e21b338@siemens.com>
 <f8d994c9-6b47-e89c-e8b0-bd873deef763@siemens.com>
 <7f92b230-df1c-6b7d-3c8e-3ff29840730d@siemens.com>
In-Reply-To: <7f92b230-df1c-6b7d-3c8e-3ff29840730d@siemens.com>
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
 <cip-dev@lists.cip-project.org>; Tue, 07 Jun 2022 18:10:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8518

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFuIEtpc3prYSA8amFu
Lmtpc3prYUBzaWVtZW5zLmNvbT4NCj4gU2VudDogMDcgSnVuZSAyMDIyIDIzOjA4DQo+IFRvOiBL
YW5hZ2FyYWphbiwgVmlqYWlrdW1hciA8VmlqYWlrdW1hcl9LYW5hZ2FyYWphbkBtZW50b3IuY29t
PjsNCj4gcXVpcmluLmd5bHN0b3JmZkBzaWVtZW5zLmNvbTsgY2lwLWRldkBsaXN0cy5jaXAtcHJv
amVjdC5vcmcNCj4gU3ViamVjdDogUmU6IFtpc2FyLWNpcC1jb3JlXVtQQVRDSCAzLzNdIHJlY2lw
ZXMtY29yZS9sdHA6IERpc2FibGUgYXV0b3Rlc3QNCj4gDQo+IE9uIDA3LjA2LjIyIDE4OjE4LCBK
YW4gS2lzemthIHdyb3RlOg0KPiA+IE9uIDA3LjA2LjIyIDE4OjE0LCBKYW4gS2lzemthIHdyb3Rl
Og0KPiA+PiBPbiAwNy4wNi4yMiAxNzo1MiwgSmFuIEtpc3prYSB3cm90ZToNCj4gPj4+IE9uIDA3
LjA2LjIyIDE3OjIzLCBLYW5hZ2FyYWphbiwgVmlqYWlrdW1hciB3cm90ZToNCj4gPj4+Pg0KPiA+
Pj4+DQo+ID4+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+Pj4+IEZyb206IEph
biBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+ID4+Pj4+IFNlbnQ6IDA3IEp1bmUg
MjAyMiAyMDo0Ng0KPiA+Pj4+PiBUbzogS2FuYWdhcmFqYW4sIFZpamFpa3VtYXIgPFZpamFpa3Vt
YXJfS2FuYWdhcmFqYW5AbWVudG9yLmNvbT47DQo+ID4+Pj4+IHF1aXJpbi5neWxzdG9yZmZAc2ll
bWVucy5jb207IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+ID4+Pj4+IFN1YmplY3Q6
IFJlOiBbaXNhci1jaXAtY29yZV1bUEFUQ0ggMy8zXSByZWNpcGVzLWNvcmUvbHRwOiBEaXNhYmxl
DQo+ID4+Pj4+IGF1dG90ZXN0DQo+ID4+Pj4+DQo+ID4+Pj4+IE9uIDA3LjA2LjIyIDE1OjUwLCBW
aWphaSBLdW1hciBLIHdyb3RlOg0KPiA+Pj4+Pj4gRml4ZXMgdGhlIGZvbGxvd2luZyBlcnJvciBk
dXJpbmcgY3Jvc3MtYnVpbGQuDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gTWFrZWZpbGU6MjA3OiAqKiog
cnVubmluZyB0ZXN0cyBvbiBjcm9zcy1jb21waWxlIGJ1aWxkIG5vdA0KPiBzdXBwb3J0ZWQuDQo+
ID4+Pj4+IFN0b3AuDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogVmlqYWkgS3Vt
YXIgSw0KPiA8VmlqYWlrdW1hcl9LYW5hZ2FyYWphbkBtZW50b3IuY29tPg0KPiA+Pj4+Pj4gLS0t
DQo+ID4+Pj4+PiAgcmVjaXBlcy1jb3JlL2x0cC9maWxlcy9kZWJpYW4vcnVsZXMgfCAyICsrDQo+
ID4+Pj4+PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiA+Pj4+Pj4NCj4gPj4+
Pj4+IGRpZmYgLS1naXQgYS9yZWNpcGVzLWNvcmUvbHRwL2ZpbGVzL2RlYmlhbi9ydWxlcw0KPiA+
Pj4+Pj4gYi9yZWNpcGVzLWNvcmUvbHRwL2ZpbGVzL2RlYmlhbi9ydWxlcw0KPiA+Pj4+Pj4gaW5k
ZXggYTQ4NTYxNS4uMDZiOTA3MCAxMDA3NTUNCj4gPj4+Pj4+IC0tLSBhL3JlY2lwZXMtY29yZS9s
dHAvZmlsZXMvZGViaWFuL3J1bGVzDQo+ID4+Pj4+PiArKysgYi9yZWNpcGVzLWNvcmUvbHRwL2Zp
bGVzL2RlYmlhbi9ydWxlcw0KPiA+Pj4+Pj4gQEAgLTgsMyArOCw1IEBAIExUUF9DT05GSUdVUkVf
RkxBR1MgPSAtLXByZWZpeD0vb3B0L2x0cA0KPiA+Pj4+Pj4NCj4gPj4+Pj4+ICBvdmVycmlkZV9k
aF9hdXRvX2NvbmZpZ3VyZToNCj4gPj4+Pj4+ICAJZGhfYXV0b19jb25maWd1cmUgLS0gJChMVFBf
Q09ORklHVVJFX0ZMQUdTKQ0KPiA+Pj4+Pj4gKw0KPiA+Pj4+Pj4gK292ZXJyaWRlX2RoX2F1dG9f
dGVzdDoNCj4gPj4+Pj4NCj4gPj4+Pj4gV2FzIHRoYXQgYWxyZWFkeSB0aGUgY2FzZSB3aXRoIHRo
ZSBwcmV2aW91cyB2ZXJzaW9uPyBJZiBub3QsIHRoaXMNCj4gPj4+Pj4gc2hvdWxkIHByb2JhYmx5
IGJlIG1vdmVkIHRoZSBmcm9udCBvZiB0aGUgc2VyaWVzLCByaWdodD8NCj4gPj4+Pg0KPiA+Pj4+
IFRoZSBwcmV2aW91cyB2ZXJzaW9uIGRpZCBub3QgYnVpbGQgc3VjY2Vzc2Z1bGx5LiBUaGUgYnVp
bGQgd2FzIGJyb2tlbi4NCj4gPj4+PiBTaW5jZSBJIHdhcyB1cHJldmluZywgSSBkaWQgbm90IGRp
ZyBtdWNoIG9uIHdoeSBpdCBmYWlsZWQuDQo+ID4+Pj4NCj4gPj4+DQo+ID4+PiBPSywgdGhlbiB3
ZSBjYW4ga2VlcCB0aGUgb3JkZXJpbmcuDQo+ID4+Pg0KPiA+Pg0KPiA+PiBIbW0sIGp1c3QgcmVh
bGl6ZWQgdGhhdCB3ZSBhcmUgbm90IHRlc3RpbmcgdGhpcyByZWNpcGUgaW4gQ0kuIFdlDQo+ID4+
IHNob3VsZCBwcm9iYWJseSBlbmFibGUga2FzL29wdC90ZXN0LnltbCBmb3Igc29tZSByZXByZXNl
bnRhdGl2ZQ0KPiA+PiB0YXJnZXQocykgdG8gY2xvc2UgdGhpcyBnYXAuDQo+ID4+DQo+ID4NCj4g
PiBFcnIsIG5vLCB3ZSBhcmUgYnVpbGRpbmcgdGhhdCAoImV4dGVuc2lvbjogdGVzdCIsIHNlZSBl
LmcuDQo+ID4gaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC1jb3JlL2lzYXItY2lw
LWNvcmUvLS9qb2JzLzI1NTQ0NzM5Ng0KPiA+IDQpLiBOb3cgSSdtIGNvbmZ1c2VkLCBzcGVjaWZp
Y2FsbHkgYXMgSSd2ZSBzZWVuIGJ1aWxkIGlzc3VlcyBsb2NhbGx5IGFzIHdlbGwuDQo+ID4NCj4g
DQo+IGJ1c3RlciB2cy4gYnVsbHNleWU6IHRoZSBmb3JtZXIgd29ya2VkIChhcyB0ZXN0ZWQgaW4g
Q0kpLCB0aGUgbGF0dGVyIHdhcw0KPiBicm9rZW4uDQo+IA0KPiBBcyBzdXNwZWN0ZWQsIHBhdGNo
IDMgbmVlZGVkIHRvIGdvIGJlZm9yZSBwYXRjaCAxIC0gb3IgZm9sZGVkIGludG8gaXQuIEkgZGlk
IHRoZQ0KPiBsYXR0ZXIgd2hpbGUgbWVyZ2luZy4NCg0KVGhhbmtzIEphbi4NCg0KQmVzdCwNClZp
amFpIEt1bWFyIEsNCg0KPiANCj4gVGhhbmtzLA0KPiBKYW4NCj4gDQo+IC0tDQo+IFNpZW1lbnMg
QUcsIFRlY2hub2xvZ3kNCj4gQ29tcGV0ZW5jZSBDZW50ZXIgRW1iZWRkZWQgTGludXgNCg==

