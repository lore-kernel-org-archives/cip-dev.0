Return-Path: <Vijaikumar_Kanagarajan@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFBDC433F5
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 14:23:10 +0000 (UTC)
Received: from esa3.mentor.iphmx.com (esa3.mentor.iphmx.com [68.232.137.180])
 by mx.groups.io with SMTP id smtpd.web09.11044.1639664588883150778
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Dec 2021 06:23:09 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: mentor.com, ip: 68.232.137.180, mailfrom: vijaikumar_kanagarajan@mentor.com)
IronPort-SDR: 
 ZV8R2hqk0BArLpOWn7cLzmJ+Z1enUUjiGKIZQA9zsKKOnVDWUS39za9YUNcgTsuMGj0nzaloTr
 7A35RNcLIZY0KRM2wn5EEDm56pzsXw5Ndtx77saTFFHUpZ22WsXbB+DUKW73eciafYQZQfp0Z/
 kMaa0xTd2H1WGim/61w+3kkE6WZZY6ca6bHM91bDUV/qWbhgy2YvQ15kulJhHKiE0L+r4INHgS
 W33wIQbRSiEVu8ZPUK1CYmiIQJsEOOtyWgIiRJ4HsGooG7JZKrK+XbV+j3aFxMFXsAQD6zMskd
 K4lyRwF7NBqgr7NvR3OibKX6
X-IronPort-AV: E=Sophos;i="5.88,211,1635235200";
   d="scan'208";a="69635116"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa3.mentor.iphmx.com with ESMTP; 16 Dec 2021 06:23:08 -0800
IronPort-SDR: 
 CRHwqcunQdRM21hPqHFq6mCIrtOWftr2Z7QjwQ6G7v10mkJVauegjniMS4IeueNzWjJaKsCJMX
 w3B/EuOCNjuL9S/s21wQIvbFN8x49XiTSw6Fz16Pok8apMgDvRGo0Jah6PDB2trVCE7bZ2vHr7
 38jcormVIeWjHzyIj1k3n6u3FCz9mgs6B3cHcrvdmnSv2kog8L4vtzSikpFEeADgIcS/SYvdGm
 OygfoIH371nlqXOwfPlwAMSMIUlLSXtOe2NCDHayN1hqrE3jBrmRjFi9Uu0q01fQBAC1JL07zk
 5Jg=
From: "Kanagarajan, Vijaikumar" <Vijaikumar_Kanagarajan@mentor.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: [isar-cip-core][PATCH v2 2/2] swupdate: Drop conditional includes
 for buster
Thread-Topic: [isar-cip-core][PATCH v2 2/2] swupdate: Drop conditional
 includes for buster
Thread-Index: AQHX8oH1DIJsgZtsbE2CkS51ZplTUaw1pYWA//+FpJA=
Date: Thu, 16 Dec 2021 14:23:05 +0000
Message-ID: <518bb7da0c0a4e70912e3dcbcdcad06b@svr-orw-mbx-01.mgc.mentorg.com>
References: <20211216133617.3403412-1-Vijaikumar_Kanagarajan@mentor.com>
 <20211216133617.3403412-3-Vijaikumar_Kanagarajan@mentor.com>
 <2ce1cbe9-8950-f136-d7a5-b97b455e8105@siemens.com>
In-Reply-To: <2ce1cbe9-8950-f136-d7a5-b97b455e8105@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [147.34.91.1]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 14:23:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7160

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFuIEtpc3prYSA8amFu
Lmtpc3prYUBzaWVtZW5zLmNvbT4NCj4gU2VudDogMTYgRGVjZW1iZXIgMjAyMSAxOTowOQ0KPiBU
bzogS2FuYWdhcmFqYW4sIFZpamFpa3VtYXIgPFZpamFpa3VtYXJfS2FuYWdhcmFqYW5AbWVudG9y
LmNvbT47IGNpcC0NCj4gZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTdWJqZWN0OiBSZTog
W2lzYXItY2lwLWNvcmVdW1BBVENIIHYyIDIvMl0gc3d1cGRhdGU6IERyb3AgY29uZGl0aW9uYWwN
Cj4gaW5jbHVkZXMgZm9yIGJ1c3Rlcg0KPiANCj4gT24gMTYuMTIuMjEgMTQ6MzYsIFZpamFpIEt1
bWFyIEsgd3JvdGU6DQo+ID4gU3RyZXRjaCBpbiBub3cgZHJvcHBlZC4gVGhlIGNvbmRpdGlvbmFs
IGluY2x1ZGVzIGZvciBidXN0ZXIgaXMgbm93IG5vdA0KPiA+IG5lZWRlZC4gVGhvc2UgaW5jbHVk
ZXMgYXJlIGFwcGxpY2FibGUgdG8gYnVzdGVyIGFzIHdlbGwgYXMgYnVsbHNleWUuDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBWaWphaSBLdW1hciBLIDxWaWphaWt1bWFyX0thbmFnYXJhamFuQG1l
bnRvci5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9zd3VwZGF0ZS9zd3VwZGF0ZV8yMDIxLjA0LTEr
ZGViaWFuLWdicC5iYiAgICAgICAgfCAxMiArKysrKystLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDYgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9yZWNpcGVzLWNvcmUvc3d1cGRhdGUvc3d1cGRhdGVfMjAyMS4wNC0xK2RlYmlhbi1nYnAuYmIN
Cj4gPiBiL3JlY2lwZXMtY29yZS9zd3VwZGF0ZS9zd3VwZGF0ZV8yMDIxLjA0LTErZGViaWFuLWdi
cC5iYg0KPiA+IGluZGV4IGE0ZDY3ZmUuLjUxYWFjZmUgMTAwNjQ0DQo+ID4gLS0tIGEvcmVjaXBl
cy1jb3JlL3N3dXBkYXRlL3N3dXBkYXRlXzIwMjEuMDQtMStkZWJpYW4tZ2JwLmJiDQo+ID4gKysr
IGIvcmVjaXBlcy1jb3JlL3N3dXBkYXRlL3N3dXBkYXRlXzIwMjEuMDQtMStkZWJpYW4tZ2JwLmJi
DQo+ID4gQEAgLTQ0LDEyICs0NCwxMiBAQCBTV1VQREFURV9CVUlMRF9QUk9GSUxFUyArPSAiY3Jv
c3Mgbm9jaGVjayINCj4gPiAgIyBtb2RpZnkgZm9yIGRlYmlhbiBidXN0ZXIgYnVpbGQNCj4gPiAg
U1JDX1VSSV9hcHBlbmRfYnVzdGVyID0gIiBmaWxlOi8vMDAwOS1kZWJpYW4tcHJlcGFyZS1idWls
ZC1mb3ItaXNhci0NCj4gZGViaWFuLWJ1c3Rlci5wYXRjaCINCj4gPg0KPiA+IC0jIGRpc2FibGUg
ZG9jdW1lbnRhdGlvbiBkdWUgdG8gbWlzc2luZyBwYWNrYWdlcyBpbiBkZWJpYW4gYnVzdGVyIC0j
DQo+ID4gZGlzYWJsZSBjcmVhdGUgZmlsZXN5c3RlbSBkdWUgdG8gbWlzc2luZyBzeW1ib2xzIGlu
IGRlYmlhbiBidXN0ZXIgLSMNCj4gPiBkaXNhYmxlIHdlYnNlcnZlciBkdWUgdG8gbWlzc2luZyBz
eW1ib2xzIGluIGRlYmlhbiBidXN0ZXINCj4gPiAtU1dVUERBVEVfQlVJTERfUFJPRklMRVNfYXBw
ZW5kX2J1c3RlciA9ICIgbm9kb2MgXA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBwa2cuc3d1cGRhdGUubm9jcmVhdGVmcyBcDQo+ID4gLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBrZy5zd3VwZGF0ZS5ub3dlYnNlcnZlciAi
DQo+ID4gKyMgZGlzYWJsZSBkb2N1bWVudGF0aW9uIGR1ZSB0byBtaXNzaW5nIHBhY2thZ2VzICMg
ZGlzYWJsZSBjcmVhdGUNCj4gPiArZmlsZXN5c3RlbSBkdWUgdG8gbWlzc2luZyBzeW1ib2xzICMg
ZGlzYWJsZSB3ZWJzZXJ2ZXIgZHVlIHRvIG1pc3NpbmcNCj4gPiArc3ltYm9scyBTV1VQREFURV9C
VUlMRF9QUk9GSUxFU19hcHBlbmQgPSAiIG5vZG9jIFwNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBwa2cuc3d1cGRhdGUubm9jcmVhdGVmcyBcDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgcGtnLnN3dXBkYXRlLm5vd2Vic2VydmVyICINCj4g
PiAgIyBJbiBkZWJpYW4gYnVzdGVyIHRoZSBnaXQtY29tcHJlc3Npb24gZGVmYXVsdHMgdG8gZ3og
YW5kIGRvZXMgbm90DQo+ID4gZGV0ZWN0IG90aGVyICAjIGNvbXByZXNzaW9uIGZvcm1hdHMuDQo+
ID4gIEdCUF9FWFRSQV9PUFRJT05TICs9ICItLWdpdC1jb21wcmVzc2lvbj14eiINCj4gPg0KPiAN
Cj4gU28gdGhlc2UgdGhpbmdzIHdlcmUgYWN0dWFsbHkgYnJva2VuIGZvciBidWxsc2V5ZSBzbyBm
YXI/DQoNClllcy4gQXRsZWFzdCwgdGhlIG5vZG9jIGlzIG5lZWRlZCBiZWNhdXNlIG9mIHNwaGlu
eCBkZXBlbmRlbmN5IGlzc3VlIGluIGJ1bGxzZXllLg0KDQpUaGFua3MsDQpWaWphaSBLdW1hciBL
DQoNCj4gDQo+IEphbg0KPiANCj4gLS0NCj4gU2llbWVucyBBRywgVCBSREEgSU9UDQo+IENvcnBv
cmF0ZSBDb21wZXRlbmNlIENlbnRlciBFbWJlZGRlZCBMaW51eA0K

