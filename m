Return-Path: <Vijaikumar_Kanagarajan@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F58FC43334
	for <webhook@archiver.kernel.org>; Mon, 27 Jun 2022 12:57:28 +0000 (UTC)
Received: from esa1.mentor.iphmx.com (esa1.mentor.iphmx.com [68.232.129.153])
 by mx.groups.io with SMTP id smtpd.web09.41292.1656334639727064210
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jun 2022 05:57:19 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: mentor.com, ip: 68.232.129.153, mailfrom: vijaikumar_kanagarajan@mentor.com)
X-IronPort-AV: E=Sophos;i="5.92,226,1650960000";
   d="scan'208";a="80572723"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa1.mentor.iphmx.com with ESMTP; 27 Jun 2022 04:57:19 -0800
IronPort-SDR: 
 0eAxbnV7c3o40c94hFS1VRhycx2yJeCFJAIk6igufGaK0VKVvFQPvdTzdCMOXLvcsqs0ZeUn9D
 P1oMLzrjVLsayHtWR9PgQgcgVI65cUtICRHBRDsQi4erxOYcI5y+ir1JE+Eh1L9pigMEjGkrAC
 4+rluj084ODndP1RtdbIYXNFr4eLzdQ+H4kqfQuydRf6XihxTYhigoBqIeP0mPAL6roaBair8c
 eWfbUu7MWmWvx3JZN1Q9F2e3u8Lkz4qGjx3YQKewPLohfcjDMKVBt2AKkNTWR0DIJ0NqoVjT0N
 kQY=
From: "Kanagarajan, Vijaikumar" <Vijaikumar_Kanagarajan@mentor.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"Gylstorff Quirin" <quirin.gylstorff@siemens.com>, "P T, Sarath"
	<Sarath_PT@mentor.com>
Subject: RE: [cip-dev] [isar-cip-core] [PATCH] scripts/start-efishell.sh: Add
 -nographic option
Thread-Topic: [cip-dev] [isar-cip-core] [PATCH] scripts/start-efishell.sh: Add
 -nographic option
Thread-Index: AQHYif3vcGBl5aRFc0u9xY4UdHVkma1jX6WAgABLKAD//4t5kA==
Date: Mon, 27 Jun 2022 12:57:16 +0000
Message-ID: <e932eb87b7564592bacdc82aa1fae449@mentor.com>
References: <20220627071206.21277-1-Sarath_PT@mentor.com>
 <665fa99b-7ab0-1b8c-3662-c1f1ad7a8d4c@siemens.com>
 <95a32358-94ab-d9c3-c0ac-df0258e2bacb@siemens.com>
 <fef66432-ac36-9e2d-7813-5e123d919bbf@siemens.com>
In-Reply-To: <fef66432-ac36-9e2d-7813-5e123d919bbf@siemens.com>
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
 <cip-dev@lists.cip-project.org>; Mon, 27 Jun 2022 12:57:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8605

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0cy5j
aXAtcHJvamVjdC5vcmcgPGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPiBPbg0KPiBCZWhh
bGYgT2YgSmFuIEtpc3prYQ0KPiBTZW50OiAyNyBKdW5lIDIwMjIgMTg6MjINCj4gVG86IEd5bHN0
b3JmZiBRdWlyaW4gPHF1aXJpbi5neWxzdG9yZmZAc2llbWVucy5jb20+OyBjaXAtZGV2QGxpc3Rz
LmNpcC0NCj4gcHJvamVjdC5vcmc7IFAgVCwgU2FyYXRoIDxTYXJhdGhfUFRAbWVudG9yLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtjaXAtZGV2XSBbaXNhci1jaXAtY29yZV0gW1BBVENIXSBzY3JpcHRz
L3N0YXJ0LWVmaXNoZWxsLnNoOiBBZGQgLQ0KPiBub2dyYXBoaWMgb3B0aW9uDQo+IA0KPiBPbiAy
Ny4wNi4yMiAxMDoyMywgR3lsc3RvcmZmIFF1aXJpbiB3cm90ZToNCj4gPg0KPiA+DQo+ID4gT24g
Ni8yNy8yMiAxMDoxNCwgSmFuIEtpc3prYSB2aWEgbGlzdHMuY2lwLXByb2plY3Qub3JnIHdyb3Rl
Og0KPiA+PiBPbiAyNy4wNi4yMiAwOToxMiwgU2FyYXRoIFAgVCB3cm90ZToNCj4gPj4+IEZyb206
IHNhcmF0aCBQIFQgPFNhcmF0aF9QVEBtZW50b3IuY29tPg0KPiA+Pj4NCj4gPj4+IFdoZW4gd2Ug
bGF1bmNoIHRoZSBzdGFydC1lZmlzaGVsbC5zaCBzY3JpcHQgZm9yIGFkZGluZyB0aGUga2V5cyBp
bnRvDQo+ID4+PiBPVk1GIGZpcm13YXJlIHdlIGZhY2VkIGd0ayBpbml0aWFsaXphdGlvbiBmYWls
ZWQgZXJyb3IuIFNvIGl0IHNlZW1zDQo+ID4+PiB3ZSBuZWVkIHRvIG9wZW4gdGhlIE9WTUYgaW4g
bm9ncmFwaGljIG1vZGUsIGhlbmNlIHdlIGFkZGVkIHRoZQ0KPiA+Pj4gcmVxdWlyZWQgb3B0aW9u
IHRvIHRoZSBzY3JpcHQuDQo+ID4+Pg0KPiA+Pg0KPiA+PiBXaGljaCBRRU1VLVZlcnNpb24/IFdo
aWNoIE9WTUYgdmVyc2lvbiAoYnVzdGVyL2J1bGxzZXllL3NvbWV0aGluZw0KPiBlbHNlKT8NCj4g
Pj4gSSdtIG5vdCBzZWVpbmcgdGhpcywgYnV0IEknbSBmYWNpbmcgb3RoZXIgaXNzdWVzIHdpdGgg
dGhhdCBmaXJtd2FyZQ0KPiA+PiBwcm92aWRlZCBieSBidWxsc2V5ZSAoYSBjcmFzaCkuDQo+ID4+
IMKgPj4gU2lnbmVkLW9mZi1ieTogc2FyYXRoIFAgVCA8U2FyYXRoX1BUQG1lbnRvci5jb20+DQo+
ID4+PiAtLS0NCj4gPj4+IMKgIHNjcmlwdHMvc3RhcnQtZWZpc2hlbGwuc2ggfCAyICstDQo+ID4+
PiDCoCAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPj4+
DQo+ID4+PiBkaWZmIC0tZ2l0IGEvc2NyaXB0cy9zdGFydC1lZmlzaGVsbC5zaCBiL3NjcmlwdHMv
c3RhcnQtZWZpc2hlbGwuc2gNCj4gPj4+IGluZGV4IGQ0NTFmNDMuLjA4MzFmODMgMTAwNzU1DQo+
ID4+PiAtLS0gYS9zY3JpcHRzL3N0YXJ0LWVmaXNoZWxsLnNoDQo+ID4+PiArKysgYi9zY3JpcHRz
L3N0YXJ0LWVmaXNoZWxsLnNoDQo+ID4+PiBAQCAtMiw3ICsyLDcgQEANCj4gPj4+IMKgIG92bWZf
Y29kZT0ke09WTUZfQ09ERTotDQo+IC91c3Ivc2hhcmUvT1ZNRi9PVk1GX0NPREUuc2VjYm9vdC5m
ZH0NCj4gPg0KPiA+IFRoaXMgc2hvdWxkIGJlIGNoYW5nZWQgdG8gdGhlIDRNIHZlcnNpb24uDQo+
ID4NCj4gPiBAamFuDQo+ID4gVGhlIDRNIHZlcnNpb24gZG9lcyBhbHNvIHRyaWdnZXIgYSBjcmFz
aD8NCj4gPg0KPiANCj4gWWVzLCBpdCBkb2VzLg0KDQpXZSBoYXZlIG5vdCBzZWVuIHN1Y2ggZXJy
b3JzLiBJZiB5b3Ugc2hhcmUgdGhlIHNldHVwIGRldGFpbHMgKFFlbXUgdmVyc2lvbi9ob3N0IGRp
c3Ryby9PVk1GIHZlcnNpb24pIHdlIGNhbiBnaXZlIGl0IGEgdHJ5Lg0KDQpUaGFua3MsDQpWaWph
aSBLdW1hciBLDQoNCj4gDQo+IEphbg0KPiANCj4gLS0NCj4gU2llbWVucyBBRywgVGVjaG5vbG9n
eQ0KPiBDb21wZXRlbmNlIENlbnRlciBFbWJlZGRlZCBMaW51eA0K

