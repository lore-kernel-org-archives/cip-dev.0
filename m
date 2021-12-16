Return-Path: <Vijaikumar_Kanagarajan@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F12BC433EF
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 13:25:21 +0000 (UTC)
Received: from esa2.mentor.iphmx.com (esa2.mentor.iphmx.com [68.232.141.98])
 by mx.groups.io with SMTP id smtpd.web08.10427.1639661119720401765
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Dec 2021 05:25:19 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: mentor.com, ip: 68.232.141.98, mailfrom: vijaikumar_kanagarajan@mentor.com)
IronPort-SDR: 
 7NG4d+k6+e8tX4oYzM9j+HBASz4BZY6bfkhgAuTb7ei5zCKjhmhJiOB2SYpkakxFzRYIzRh3lO
 DeiFandBnuJ8zRJtDCzqmRd0C7SWVmPxzE1+G2F0ms7ohwEOY2dynBxWUO4shwtq5swOAPsWsO
 NqXUiRN+NGAuxCI8r9gFs3ZKk6TRC/KY8zdmR3l44iRXTGRWEEs/B1KC4r/YmJmDsZJhchWERV
 wJraUHfpX7sbdsB22alZaSXPfCunN9ZQZU4RZtSApevUpjZW47HlKHkzV2jvJ7lJD3xNyoqVcb
 HurEtoBSZYGoHBy1LxoYqnoO
X-IronPort-AV: E=Sophos;i="5.88,211,1635235200";
   d="scan'208";a="69777755"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa2.mentor.iphmx.com with ESMTP; 16 Dec 2021 05:25:18 -0800
IronPort-SDR: 
 dXyDTkHngH46IBYeo/eQDgFwqhVL4O6MvkP7wKaYdWSOtFGieSDR/YQKqAjc4n0jW4DcpWVp//
 FEUlRRiC+oPMOt4lLYi0LBEqY3WxSfdDyVT5uK6AwgAtLp/Ru/bYBecCcNdwhIh36wrpevFSur
 SU1Zn9Yg1PUn8Q+z2Y4URbEw+yn8VZbBy6+cniIfPHwNW88l7C50HsCJyD3qysbq0Hz1QcLHZD
 updglhDEPBJs+SxdxZzLULo5YsKEtQTlomM+WWiGALw5oXR5bj7vfwyOW87lTo19iW+Hj812D0
 Xio=
From: "Kanagarajan, Vijaikumar" <Vijaikumar_Kanagarajan@mentor.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: [isar-cip-core][PATCH 1/2] Drop stretch support
Thread-Topic: [isar-cip-core][PATCH 1/2] Drop stretch support
Thread-Index: AQHX8n2QO006ZL7bHkew90dxzDx946w1oWsA//96NnA=
Date: Thu, 16 Dec 2021 13:25:17 +0000
Message-ID: <5f79c0463fbc471facff53aba9b37a06@svr-orw-mbx-01.mgc.mentorg.com>
References: <20211216130450.3402865-1-Vijaikumar_Kanagarajan@mentor.com>
 <20211216130450.3402865-2-Vijaikumar_Kanagarajan@mentor.com>
 <fd82da76-9435-4ff2-3172-3ccb9d5c2866@siemens.com>
In-Reply-To: <fd82da76-9435-4ff2-3172-3ccb9d5c2866@siemens.com>
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
 <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 13:25:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7154

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFuIEtpc3prYSA8amFu
Lmtpc3prYUBzaWVtZW5zLmNvbT4NCj4gU2VudDogMTYgRGVjZW1iZXIgMjAyMSAxODo1NA0KPiBU
bzogS2FuYWdhcmFqYW4sIFZpamFpa3VtYXIgPFZpamFpa3VtYXJfS2FuYWdhcmFqYW5AbWVudG9y
LmNvbT47IGNpcC0NCj4gZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTdWJqZWN0OiBSZTog
W2lzYXItY2lwLWNvcmVdW1BBVENIIDEvMl0gRHJvcCBzdHJldGNoIHN1cHBvcnQNCj4gDQo+IE9u
IDE2LjEyLjIxIDE0OjA0LCBWaWphaSBLdW1hciBLIHdyb3RlOg0KPiA+IHN0cmV0Y2ggaXMgbm93
IG9sZCBlbm91Z2ggdG8gYmUgZHJvcHBlZC4gU3VwcG9ydCB0aGUgY3VycmVudA0KPiA+IHN0YWJs
ZShidWxsc2V5ZSkgYW5kIG9sZC1zdGFibGUoYnVzdGVyKS4NCj4gDQo+IFRoZSBtb3JlIGFjY3Vy
YXRlIHJlYXNvbmluZyB3b3VsZCBiZSB0aGF0IHRoZSBnZW5lcmljIHByb2ZpbGUgb2YgQ0lQIENv
cmUNCj4gZG9lcyBzdGFydGVkIGl0cyB3b3JrIHdpdGggYnVzdGVyLCBzdHJldGNoIHdhcyBvbmx5
IGV4cGVyaW1lbnRhbCBmb3IgdGhpcw0KPiBsYXllci4NCg0KV2lsbCB1cGRhdGUgdGhlIGNvbW1p
dCBtZXNzYWdlLg0KDQpUaGFua3MsDQpWaWphaSBLdW1hciBLDQoNCj4gDQo+IEphbg0KPiANCj4g
LS0NCj4gU2llbWVucyBBRywgVCBSREEgSU9UDQo+IENvcnBvcmF0ZSBDb21wZXRlbmNlIENlbnRl
ciBFbWJlZGRlZCBMaW51eA0K

