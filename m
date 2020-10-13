Return-Path: <SRS0=QJ+A=DU=lists.cip-project.org=bounce+64572+5571+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B694C433E7
	for <cip-dev@archiver.kernel.org>; Tue, 13 Oct 2020 14:17:02 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D730B247F7
	for <cip-dev@archiver.kernel.org>; Tue, 13 Oct 2020 14:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="PZm1C0DN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D730B247F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5571+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id SVK3YY4521723xuXdgWsX5rN; Tue, 13 Oct 2020 07:17:00 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.135])
 by mx.groups.io with SMTP id smtpd.web11.13071.1602598619010167726
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Oct 2020 07:16:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OzAS3mzEr77mOaz98hM4FmOv92rqjdBwI8FpV75IwtAUyTg42lXcsQYKWrxisMLSWJpu2IqlIwntL8Xb5XER+Nr0oZL5L9ZgNmhpxJ6U4U6NWxyFvAhZOGDj84gOweUNIpphuIL03xgTT+a7Sm6kvA0C0JGW+x/RZmjSXeb/1sFyoarVw6mcDfU/prrsMMRgaOKRLPpGXCKYpYQ8eH3+4EHwVuGO9jTUuhNVD9S3IVmkhbToYSorU6ezKCwgAfz7VhyAW8mPfq+uFkWSxv0BV3CusPqCTdyaoexVZG6W4xha4eFQiGOQ825s3gfU0z5lib7xF9d5Bu48M1H1cayH9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B59xo6yEHyPZs4TkNi1ns7DMJ/4xtggHpDEYyQ0wPsg=;
 b=JOmpRFvn56+1zbMabn5e8+kcMKRIGbp6beDDzShlDcyNHURu10Cr/iIlyE9RwSKAcBFFPcC+af95X/at3U6/wZ2gWd9mcbHYL0w8qi0OVxhN5pkaHtHL4jthkVSl8CLLGLbiggsNdlDBjevVBpQ9erShgOl0B9VAWUr789gu5sviY4iFUXel3oFvsAtT99p26D2In2yhFlc7/HW+0Hl8A3o0EUo8MptsfTlI3J6uktPrROxg8w/q9m3oTpsrcnZ3xaRReh5OD08xfCRnW5AAlR1eIv9RbbYKoOyXll4ToV6LjwTDsAX8VcnkaOhulvfVPbZOhR6h5H6pGH9Wsk1KSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com (2603:1096:603:37::20)
 by OSAPR01MB1490.jpnprd01.prod.outlook.com (2603:1096:603:2b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Tue, 13 Oct
 2020 14:16:55 +0000
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::6d93:a69d:8f48:6dc4]) by OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::6d93:a69d:8f48:6dc4%7]) with mapi id 15.20.3455.030; Tue, 13 Oct 2020
 14:16:55 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: [cip-dev] FW: [Automated-testing] RFC: dashboards, visualization and analytics for test results
Thread-Topic: [Automated-testing] RFC: dashboards, visualization and analytics
 for test results
Thread-Index: AQHWnNHy5nLQTL/V9UyZBPDXbiTNEamVnQCg
Date: Tue, 13 Oct 2020 14:16:55 +0000
Message-ID: 
 <OSAPR01MB23856A60BB2A154418B2A18FB7040@OSAPR01MB2385.jpnprd01.prod.outlook.com>
References: <7hk0w2c4i3.fsf@baylibre.com>
In-Reply-To: <7hk0w2c4i3.fsf@baylibre.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [86.164.44.115]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b2179ae4-b4a3-4600-cecd-08d86f82a3b1
x-ms-traffictypediagnostic: OSAPR01MB1490:
x-microsoft-antispam-prvs: 
 <OSAPR01MB149043638644FFF99DBEADEFB7040@OSAPR01MB1490.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 yC2S5ETaQmdFtUFkicOk7WL6G7pbTP3WSSs8Y7uX2xSMQtdQU6OCAWAijx7N/CD3obDdKnoYyRZGlzWSozwSc77cmZzSOuCRHNAYPblMbODdC6wnBQPzC7z43i4KnhAzlGCGuMuQdLqTw1RYoviSF2Xi2utFt38SJmQowmRl0Q8B7LiGDlTOn3CGw69bsz9NcnY2s9GPOy9zNbdaN3zPNtCJ8Kz873qE5lN0JGrjckGvxloamYgPT0Wq8BvALAeryK7T70Owc4aGk5FR69Ray5jnXChRwVgKvnldRxRDa0vsQoIq+ZvEZygQ26CbJ5Kf2yQdacIkr0Xu4jgi+EPqg8wG/t1Y2cVPctxeT34oTQIKUZAeV9Aq1on8Gq/3JU51p+8PSPOy+hakClw756iUFQ==
x-ms-exchange-antispam-messagedata: 
 smOFIFQz5Nm0olo/YWgMNrbWS35yXhWvRlf9SY7Th6zTzn9lXQQjLKZlpWQ0kwl4Z3I/GMkTd5Ywe8sMsU82XFjWl5pFwI7cjBWGPGxTPIJSniBUdslWeqksZ2hC4ukiUEP3ycobDGVYmIiKMkH03JLn/0Y4Y1yfwlCFkGGWz5m+vyTvPeHkryhRb7NlTGsLYjVmtDNcxQE80BFzaPnCjYSzDdXotJ2sdMEX8aO4Nufm6o7C9hsXC0g1hrms8F3eTSJyiE81vUh3PpQp9fNYw6v1QftCe2tgeqEzsiyohefX4clw8jSiDb1MaotSB436Vq2gFpNnnHwMkCvbZ8v2z5eMYhdTchK82636kPAt7Xn/JeqiVXl/pWkFnzmsTdSZRVWckCru9iJpS2GIMIGlYvL1UV5d4JxZzu2ZQFwIFeU2WQmeS8gZ7J9HS7r9LPJwljfjn5eAY38csmZ/GOpP190F2rn/JUPZIkdvDmIPmcADSS+8fFcrcQfqRJriHRRrzLSWwKCu4jwVtJuN4sQRQnr9Xe4OkS+5rG1Za9oAxHOoq1uuzgtrN8aJ6Isv/qyd9oH3bqAiposhFQFKHECk2myhhW1tcuBiM6aEfcoHw2wIRfVUo+8I7Y4ggAvqMcfFouGKh8lJoiEwyX3bSBIwpQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2179ae4-b4a3-4600-cecd-08d86f82a3b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2020 14:16:55.4726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OwYlgNllb7BAcmpILMceYU429yIP076g/ryFz+3hZQFWZNlDfZ8Mgp8O7UEBDGv01oVznBblyHe890d3cZj0fbMmUSfXG4jWIMcEHQmDDnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1490
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: NlMzbtXFKn8XqLweOcJMoM4zx4520388AA=
Content-Type: multipart/mixed; boundary="CgpN0LuzFvzIBhxFpJPe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602598620;
 bh=JUgzAXZL/81pvljaCZjsHA3dG1bRfh7qOOPrGgtbZ3k=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=PZm1C0DNYR1wWRf1A5ln84RkWi5HgbRk8ciyvqPFbXppMsI9jKNjW89foO9qOGxQ/fx
 wUm1uG4U5UodbLzUaTQvjiO+ZfHJ34mI9mWz2neJQzhy5NmnoFBWGZxBxFofUkwQz8XdZ
 drx80EsjuCp+ECCsabLytw/lhrgTWVQJ2Lc=

--CgpN0LuzFvzIBhxFpJPe
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

RllJDQoNClBsZWFzZSBmZWVsIGZyZWUgdG8gYWRkIGFueSB1c2UgY2FzZXMgb3IgY29tbWVudHMg
dG8gdGhlIG1haWwgdGhyZWFkIGJlbG93IGZyb20gS2VybmVsQ0kuDQoNCktpbmQgcmVnYXJkcywg
Q2hyaXMNCg0KPiBGcm9tOiBhdXRvbWF0ZWQtdGVzdGluZ0BsaXN0cy55b2N0b3Byb2plY3Qub3Jn
IDxhdXRvbWF0ZWQtDQo+IHRlc3RpbmdAbGlzdHMueW9jdG9wcm9qZWN0Lm9yZz4gT24gQmVoYWxm
IE9mIEtldmluIEhpbG1hbiB2aWENCj4gbGlzdHMueW9jdG9wcm9qZWN0Lm9yZw0KPiBTZW50OiAw
NyBPY3RvYmVyIDIwMjAgMTg6NDgNCj4gVG86IGF1dG9tYXRlZC10ZXN0aW5nQGxpc3RzLnlvY3Rv
cHJvamVjdC5vcmc7IGtlcm5lbGNpQGdyb3Vwcy5pbw0KPiBDYzogdG9vbHNAbGludXgua2VybmVs
Lm9yZw0KPiBTdWJqZWN0OiBbQXV0b21hdGVkLXRlc3RpbmddIFJGQzogZGFzaGJvYXJkcywgdmlz
dWFsaXphdGlvbiBhbmQgYW5hbHl0aWNzIGZvcg0KPiB0ZXN0IHJlc3VsdHMNCj4gDQo+IEhlbGxv
IGZvbGtzIGludGVyZXN0ZWQgaW4ga2VybmVsIHRlc3RpbmcvYXV0b21hdGlvbiwNCj4gDQo+IFRo
ZSBLZXJuZWxDSSBwcm9qZWN0IGlzIHN0YXJ0aW5nIHRvIGxvb2sgYXQgd2hhdCdzIG5leHQgZm9y
IGRhc2hib2FyZHMsDQo+IHZpc3VhbGl6YXRpb24gYW5kIGFuYWx5dGljcyBmb3IgdGhlIHZhcmlv
dXMgTGludXggZm9jdXNlZCB0ZXN0aW5nDQo+IHByb2plY3RzLg0KPiANCj4gQXQgTGludXggUGx1
bWJlcnMsIHdlIGxhdW5jaGVkIHNvbWUgZGlzY3Vzc2lvbnNbMV0gYXJvdW5kIGNvbW1vbiB3YXlz
DQo+IHRvDQo+IGNvbGxlY3QgdGVzdCByZXN1bHRzLCBsb2dzIGFuZCBtZXRhZGF0YSBpbnRvIGEg
cHVibGljLCBzaGFyZWQgZGF0YXNldCwNCj4gYW5kIHdlJ3ZlIGFscmVhZHkgc3RhcnRlZCBjb2xs
ZWN0aW5nIGRhdGEgZnJvbSBzZXZlcmFsIGRpZmZlcmVudA0KPiBzb3VyY2VzLg0KPiANCj4gU28g
dGhlIG5leHQgcXVlc3Rpb24gaXMuLi4gaG93IGRvIHdlIGJlc3QgdXNlIGFsbCBvZiB0aGlzIGRh
dGE/DQo+IA0KPiBXZSdyZSBiZWdpbm5pbmcgdG8gYnJhaW5zdG9ybSBob3cgdG8gdmlzdWFsaXpl
LCBhbmFseXplIGFuZCBsZWFybiBmcm9tDQo+IHRoaXMgZGF0YSBpbiB1c2VmdWwgd2F5cy4NCj4g
DQo+IFRvIHRoYXQgZW5kLCB3ZSdyZSBzdGFydGluZyB0byBjb2xsZWN0IGEgc2V0IG9mIHVzZXIg
c3RvcmllcyB0byBoZWxwIHVzDQo+IGJyYWluc3Rvcm0gYSBuZXcgZGVzaWduIGZvciB3ZWIgYmFz
ZWQgZGFzaGJvYXJkIGFuZCBhbmFseXRpY3MsIGFuZCB3ZSdkDQo+IGxpa2UgdG8gaGVhciBmcm9t
IHlvdS4NCj4gDQo+IEJlbG93IGlzIHRoZSBzdGFydCBvZiBhIGxpc3Qgb2YgdXNlciBzdG9yaWVz
WzJdLCBidXQgd2Ugd2FudCB0byBncm93DQo+IHRoaXMgbGlzdCB3aXRoIHlvdXIgaWRlYXMsIHNv
IHBsZWFzZSBzaGFyZSB0aGVtIG9uIHRoaXMgdGhyZWFkLg0KPiANCj4gV2UncmUgYWxzbyB2ZXJ5
IGludGVyZXN0ZWQgaW4gdGFsa2luZyB3aXRoIGFueSBiaWcgZGF0YSBwZW9wbGUgYW5kIGRhdGEN
Cj4gc2NpZW50aXN0cyB3aG8gbWlnaHQgYmUgd2lsbGluZyB0byBsb29rIGF0IHRoaXMgZ3Jvd2lu
ZyBzZXQgb2YgZGF0YSBhbmQNCj4gaGVscCB1cyBiZXR0ZXIgcGxhbiBmb3IgdGhlIGZ1dHVyZSBm
dWxsIG9mIGxvdHMgb2YgdGVzdCBkYXRhLg0KPiANCj4gV2UgYXBwcmVjaWF0ZSB5b3VyIGlkZWFz
IGFuZCBmZWVkYmFjaywNCj4gDQo+IEtldmluIChvbiBiZWhhbGYgb2YgdGhlIEtlcm5lbENJIHRl
YW0pDQo+IA0KPiANCj4gWzFdIGMuZi4gVW5pZnlpbmcgVGVzdCBSZXBvcnRpbmcgd2l0aCBLZXJu
ZWxDSSBmcm9tIHRoZSB0ZXN0aW5nL2Z1enppbmcNCj4gICAgIG1pY3JvLWNvbmZlcmVuY2U6DQo+
ICAgICBodHRwczovL2xpbnV4cGx1bWJlcnNjb25mLm9yZy9ldmVudC83L3Nlc3Npb25zLzgwLyMy
MDIwMDgyNg0KPiANCj4gDQo+IA0KPiBbMl0gRXhhbXBsZSB1c2VyIHN0b3JpZXMNCj4gDQo+IEEg
a2VybmVsIGRldmVsb3BlciBoYXMgc2VudCBhIHBhdGNoIHdoaWNoIGNhdXNlZCBhIHJlZ3Jlc3Np
b24NCj4gICAgLSBGaW5kIHRoZSBkZXRhaWxzLCBob3cgdG8gcmVwcm9kdWNlLCBjaGVjayB3aGVu
IGl04oCZcyBmaXhlZA0KPiANCj4gQSBtYWludGFpbmVyIGlzIGdldHRpbmcgYSBicmFuY2ggcmVh
ZHkgZm9yIHRoZSBuZXh0IG1lcmdlIHdpbmRvdw0KPiAgIC0gQ29tcGFyZSByZXN1bHRzIGFnYWlu
c3QgbWFpbmxpbmUsIGVuc3VyZSBhbGwgdGVzdHMgd2VyZSBydW4gY29ycmVjdGx5DQo+IA0KPiBB
biBPRU0gb3IgU29DIHZlbmRvciBuZWVkcyB0byB1cGdyYWRlIHRoZWlyIGtlcm5lbCBvciBtb3Zl
IHRvIHVwc3RyZWFtDQo+ICAgLSBTZWUgYWxsIHJlc3VsdHMgZm9yIGEgcGFydGljdWxhciBwbGF0
Zm9ybSBvbiB2YXJpb3VzIHN0YWJsZSByZWxlYXNlcw0KPiANCj4gUmVndWxhciB2aXNpdG9ycyB3
aG8gd2FudCB0byBrbm93IGhvdyB0aGUga2VybmVsIGlzIGRvaW5nDQo+ICAgLSBIaWdobGlnaHQg
bmV3IHJlZ3Jlc3Npb25zLCBzaG93IHRyZW5kcyBmb3IgcGFzcy9mYWlsIGFuZCBwZXJmb3JtYW5j
ZQ0KPiAgIC0gRG9lcyBrZXJuZWwgWCB3b3JrIG9uIG15IGhhcmR3YXJlPw0KPiANCj4gRGlzdHJv
IHZlbmRvciB3YW50cyB0byBrbm93DQo+ICAgLSBJcyB0aGUgbGF0ZXN0IGtlcm5lbCBzdGFibGUg
ZW5vdWdoIGZvciBteSBkaXN0cm8/DQo+ICAgLSBXaHkgZG9lcyB0aGlzIHRlc3QgZmFpbCBvbiBt
eSBkaXN0cm8ga2VybmVsIGJ1dCBub3Qgc3RhYmxlIGtlcm5lbD8NCj4gDQo+IFN0YWJsZSBrZXJu
ZWwgbWFpbnRhaW5lciB3YW50cyB0byBrbm93DQo+ICAgLSBJcyB0aGlzIGtlcm5lbCBzdGFibGUg
ZW5vdWdoIHRvIHJlbGVhc2U/DQo+IA0KPiBLZXJuZWwgLyBzdWJzeXN0ZW0gbWFpbnRhaW5lciB3
YW50cyB0byBrbm93DQo+ICAgLSBJcyBteSBjb2RlL3N1YnN5c3RlbSBiZWluZyB0ZXN0ZWQ/ICBI
b3cgbXVjaCBjb3ZlcmFnZT8NCj4gICAtIElzIHRoZSBrZXJuZWwgc2l6ZSBncm93aW5nPyAgV2h5
PyAgV2hpY2ggc3Vic3lzdGVtcw0KPiAgIC0gSXMgYm9vdCB0aW1lIC8gdGVzdCBleGVjdXRpb24g
dGltZSBpbmNyZWFzaW5nL2RlY3JlYXNpbmc/ICBXaGF0IGFyZSB0aGUNCj4gaGlzdG9yaWNhbCB0
cmVuZHM/DQo+IA0KDQo=

--CgpN0LuzFvzIBhxFpJPe
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5571): https://lists.cip-project.org/g/cip-dev/message=
/5571
Mute This Topic: https://lists.cip-project.org/mt/77483847/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--CgpN0LuzFvzIBhxFpJPe--
