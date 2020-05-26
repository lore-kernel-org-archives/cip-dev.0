Return-Path: <SRS0=i5s1=7I=lists.cip-project.org=bounce+64572+4643+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE750C433E1
	for <cip-dev@archiver.kernel.org>; Tue, 26 May 2020 13:25:50 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3356B207FB
	for <cip-dev@archiver.kernel.org>; Tue, 26 May 2020 13:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="pZGgms8q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3356B207FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4643+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id cml3YY4521723xUacb5TK72S; Tue, 26 May 2020 06:25:49 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.134])
 by mx.groups.io with SMTP id smtpd.web12.50222.1590499548264173133
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 May 2020 06:25:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqt5RBzVlptxQ8lqGfAalt9W/VL395Pg3fSFGmLUyExUtahjPS4YwjOav13wzNIhXnEKiO6FAPnq6qeIFTWbtnJRBStEnyNXELslFiFr+zQENHe0LMIcRZKaXKg1GJQyDUHY7JnstXiSLlAQmY3T6zRFOOBwhP3fpKiNVkVode4B7UjSbX5NTsrEBqfyge203hVnAXVIqaJE/ydqVcKI8lxZLUVjEspNbapMPGC/RNU32vOAnDCTp2a4kBR6GAjJ68Ntyt9ISTXgNmVIzifHXqnoBZ9e9AIG3/CWdeBwpZn5sNImZVe38yUraRFKZ+0fGsP9JDRDLptOGe7CrYjUjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EM0kTfY7GCUPzVUAXX27PO0WdM86eGMB6t5kN05GjaA=;
 b=lJFOj/YphVgWgrUMTypNxNnq90l3Z3NS4oFX1lclGnglFv6LhcQDlNV2EEeCKlIyXNPFlycjLgVNlTz77D2DXDc44ou+0MZx8X7uN+uY/rV5AmMUdcn29txi8w8+lU0Xot5E28x7SsBjQR+xWHr5RYM+ujcBdyZXfSOlrGZuOaPqdifV3XkRsH2CLN3Wvny6aWitXHEhv5Cs5qgiI2FouM6GpRw7ziAdWMX5zWmuwSB3Nv6UWfbU3FgA451SDJQmIujYfcbr02bjAENGZ3s0zrXnfKKWfq4hP7pMU1BZKqCOy1BJAoQMBI3emO9KV+T7fFfh1wiIJSQfbgbt/ha5cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com (2603:1096:603:37::20)
 by OSAPR01MB2578.jpnprd01.prod.outlook.com (2603:1096:603:3b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Tue, 26 May
 2020 13:25:44 +0000
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::c44c:5473:6b95:d9fd]) by OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::c44c:5473:6b95:d9fd%6]) with mapi id 15.20.3021.029; Tue, 26 May 2020
 13:25:44 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: "daniel.sangorrin@toshiba.co.jp" <daniel.sangorrin@toshiba.co.jp>,
	"ben.hutchings@codethink.co.uk" <ben.hutchings@codethink.co.uk>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>
Subject: Re: [cip-dev][isar-cip-core] version management
Thread-Topic: [cip-dev][isar-cip-core] version management
Thread-Index: AdYthqu0kcefdkDOSNuvyCjETy2KPACst5AAAJlXsdAAMHv0wA==
Date: Tue, 26 May 2020 13:25:43 +0000
Message-ID: 
 <OSAPR01MB2385A022918A24EBC98F9E45B7B00@OSAPR01MB2385.jpnprd01.prod.outlook.com>
References: 
 <TYAPR01MB2064041238490898AD56BF62D0B90@TYAPR01MB2064.jpnprd01.prod.outlook.com>
 <15ecf2778057028f916e644742e6a66ed115f052.camel@codethink.co.uk>
 <OSBPR01MB2053A08090E5533C7323928DD0B30@OSBPR01MB2053.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSBPR01MB2053A08090E5533C7323928DD0B30@OSBPR01MB2053.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 14401c35-c653-49f5-8bfa-08d801784b19
x-ms-traffictypediagnostic: OSAPR01MB2578:
x-microsoft-antispam-prvs: 
 <OSAPR01MB2578F23B92FE2E14600B21E6B7B00@OSAPR01MB2578.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 wE4aXC/9K4d7JC3oovgZ349hz7ICzA47k7TuAqU2YuVr71kZIJGRvq5sexytBvdIkPkS+vgJpFCRMDxeb6UA8rd6jxC0Q9JxiFubsqKckKkaGy1i4lRN8aAUx6d+0YHeIAIqCvlUUEDBO+q9waRcACHLOixGHVfw9MGQZqSMxWPFCPnoGn8ZcWJkgyzGPAUB8Ei7pBYGb9VHF1dVEOU8Bu4dXg2yuR/vHOCNUBEB2/o8Z9GTo5pE2RtDZl6YmKGT5f/zkQUQKZOwsnOH6LqN9feu3Kx16OZnqbVg4V8W39v4nehsMwpf4fNznJIIRdA517XSh/ahLRS59nSOtIJmxf8V7sa19hOuaxvZc6LrtUZPJmedoD863quMNNelPOHm/Yj1aDJ7iXcSQauQvDkQhw==
x-ms-exchange-antispam-messagedata: 
 1Ph1Es5RbIuWil4q0EESckllGj+Onqm+Hv8ciuTkx+mXUpay/hxajZK4ghYvjkEoYfuDFFeQDZJqBjpA9NEfUg//6qfQq4WWF4rCsZAcM6Spw1JEDlaOXEp/6+dijuzzt/rFIPKUuPKKwE4PVI9ay9ldDbst76d7JaIH6r+sP0gKWtotcqNRnjfPY4XAOihrDgvQcIxSlQJx6+ccUzDy7i3o5/sE2hSA52T2a4W5bxPuRLWnXAsv5S67dTfKXd/T07Z4q7LMhwWzTBdmbDA0LXnlqacJgnAUwlUL4V1BjKwwwHwYViwf0kW3o1nbHsPQirP4Ajw4aCdBH2+cpvrHNHT+kUvn1NlX03yarwcC2hWSY85rKDbTARuVdAR+ExlIJAgHIHG3MVm0DZdW0EO1xO/Fy5N1Yln4vgcR5tAc9iUnyPl9oU+qto1hA5BZBswlDAMYdzgaUzokkbFYlz18bHrZqTptURyUFrkZSwdnNSxDaGMGjE4c/oH9IlvOUlJZ
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14401c35-c653-49f5-8bfa-08d801784b19
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2020 13:25:43.8675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gUl4wbSdgXgp2jp0qWd6kbQjqfSMCcftT9R9xR3pegX0iO2MAUxQtJeC6knISmv+SOiaNHDoBU4oAKhECNIcc6rAHiGIZOxnfY2A5MSvMtk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2578
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: iMyWonIWrWf3O0uRDs5lkVogx4520388AA=
Content-Type: multipart/mixed; boundary="nXvPCbd0HXfQY2Bjp9TI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1590499549;
 bh=g6yUVRlNRGsYT27eqzNjS39r8+JmwOmTCK2fJS6d2Ss=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=pZGgms8qOnjrqcTWnZF0a+8lUyyNxhe57PanTf37ruC0d2uEmmhbBm1C55UC61oYd3J
 MLzHif8O9Ch68yv7mktTAeqhi2Tnsk62zDp8d8HQ2k3CNXI4yqxixU4Bi+CT5K5/8zYv+
 HreMD30lqL3iuN7I7vUFfIZqaeXTfmuRVOc=

--nXvPCbd0HXfQY2Bjp9TI
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGVsbG8sDQoNCj4gRnJvbTogZGFuaWVsLnNhbmdvcnJpbkB0b3NoaWJhLmNvLmpwIDxkYW5pZWwu
c2FuZ29ycmluQHRvc2hpYmEuY28uanA+DQo+IFNlbnQ6IDI1IE1heSAyMDIwIDE1OjUxDQo+IA0K
PiBUaGFua3MgZm9yIHlvdXIgY29tbWVudHMgQmVuLg0KPiANCj4gPiBGcm9tOiBjaXAtZGV2QGxp
c3RzLmNpcC1wcm9qZWN0Lm9yZyA8Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc+IE9uDQo+
IEJlaGFsZiBPZiBCZW4gSHV0Y2hpbmdzDQo+ID4gPiBJIGFncmVlIHRoYXQgd2UgbmVlZCB0byB2
ZXJzaW9uIG91ciByZWxlYXNlcy4gSW4gRGViaWFuIHRoZXJlIGFyZQ0KPiA+ID4gcG9pbnQgdmVy
c2lvbnMsIGJ1dCBJIGRvbid0IHRoaW5rIHdlIG5lZWQgdG8gZm9sbG93IHRoYXQuIE1heWJlIHdl
DQo+ID4gPiBjYW4ganVzdCB1c2UgYSBudW1iZXIgc3VjaCBhcyB0aGUgZGF0ZSBvZiB0aGUgcmVs
ZWFzZSAoZWcuIDIwMjAwNTE5DQo+ID4gPiA8LS0geWVhcm1vbnRoZGF5KS4NCj4gPg0KPiA+IElu
Y2x1ZGluZyBwdW5jdHVhdGlvbiBpbiB0aGUgZGF0ZSBtYXkgbWFrZSBpdCBtb3JlIHJlYWRhYmxl
LiAgQWxzbyB0aGUNCj4gPiBkYXktb2YtbW9udGggY291bGQgYmUgb21pdHRlZCBpZiB0aGVyZSB3
aWxsIGJlIG5vIG1vcmUgdGhhbiBvbmUgcmVsZWFzZQ0KPiA+IHBlciBtb250aC4NCj4gDQo+IE15
IHByZWZlcmVuY2Ugd2FzIGluY2x1ZGluZyB0aGUgZGF5LW9mLW1vbnRoIGJlY2F1c2UNCj4gYSkg
dGhlIGtlcm5lbCBzb21ldGltZXMgZ2V0cyByZWxlYXNlZCBpbiBsZXNzIHRoYW4gYSBtb250aC4g
QnV0IHRoYXQncyBpbiBjYXNlDQo+IHdlIHJlbGVhc2UgYXQgdGhlIHNhbWUgcGFjZS4NCj4gYikg
aWYgd2UgcmVsZWFzZSBhIHZlcnNpb24gdGhhdCBoYXMgYSBwcm9ibGVtLCB3ZSBjYW4gcmVsZWFz
ZSBhIG5ldyBvbmUNCj4gcXVpY2tseSB0aGUgbmV4dCBkYXkuDQo+IA0KPiA+ID4gU29tZSBxdWVz
dGlvbnMgcmVnYXJkaW5nIHZlcnNpb25pbmc6DQo+ID4gPiAgICAqIHNob3VsZCB3ZSBhbHNvIHN0
b3JlIG1ldGFkYXRhIGFzc29jaWF0ZWQgd2l0aCBhIHJlbGVhc2U/DQo+ID4gPiAJKiBhIHBhY2th
Z2UgbGlzdCBtYW5pZmVzdCBmb3IgZWFjaCByZWxlYXNlIChkcGtnIC1sKT8NCj4gPiA+ICAgICAg
ICAgKiB0aGUgY2lwLWNvcmUgYnJhbmNoIGFuZCBjb21taXQNCj4gPiA+ICAgICAgICAgKiB0aGUg
Y2lwLWtlcm5lbCBicmFuY2ggYW5kIGNvbW1pdA0KPiA+ID4gICAgICAgICAqIG1kNXN1bSBvZiB0
aGUgaW1hZ2UNCj4gPg0KPiA+IEFuIG1kNXN1bSB3b3VsZCBoZWxwIHRvIGRldGVjdCBhY2NpZGVu
dGFsIGNvcnJ1cHRpb24sIGJ1dCB0aGF0J3MgYWxsLg0KPiA+IEFueSByZWxlYXNlIG5lZWRzIHRv
IGJlIGNyeXB0b2dyYXBoaWNhbGx5IHNpZ25lZCwgYW5kIHRoYXQgd2lsbCBwcm92aWRlDQo+ID4g
YSBtdWNoIHN0cm9uZ2VyIGludGVncml0eSBjaGVjay4NCj4gDQo+IEdvb2QgcG9pbnQsIHRoYW5r
IHlvdS4NCj4gDQo+IFdlIGNhbiBjcmVhdGUgYSBQR1Agc2lnbmF0dXJlIG9uIGdpdGxhYi1jaSBh
bmQgc2VuZCBpdCB0byBTMyB0b2dldGhlciB3aXRoIHRoZQ0KPiBPUyBpbWFnZS4gU2hvdWxkIHdl
IHB1dCB0aGUgcHVibGljIGtleSAoYW5kIGZpbmdlcnByaW50KSBvbiB0aGUgaW1hZ2UNCj4gcmVs
ZWFzZSB3aWtpPw0KPiANCj4gQ2hyaXM6IHRoaXMgY291bGQgYmUgdXNlZnVsIHRvIG1ha2Ugc3Vy
ZSB0aGF0IHdlIHJ1biB0aGUgcmlnaHQgdGhpbmcgaW4gTEFWQS4NCg0KSXQncyBhbiBpZGVhLCBJ
J20gbm90IHN1cmUgaXQncyBzb21ldGhpbmcgdGhhdCBMQVZBIGN1cnJlbnRseSBzdXBwb3J0cyB0
aG91Z2guDQpObyByZWFzb24gd2h5IHN1cHBvcnQgY291bGRuJ3QgYmUgYWRkZWQuDQoNCktpbmQg
cmVnYXJkcywgQ2hyaXMNCg0KPiANCj4gPiA+ICAgICogZG8gd2UgbmVlZCByZXBvc2l0b3J5IG1h
bmFnZW1lbnQgaW5mcmFzdHJ1Y3R1cmU/DQo+ID4gPiAgICAgICAgKiBtaXJyb3IgcGFydCBvZiB0
aGUgZGViaWFuIHJlcG9zaXRvcnkgKG9ubHkgdGhlIHBhY2thZ2VzIHRoYXQgd2UNCj4gbmVlZCkN
Cj4gPiA+ICAgICAgICAqIGNyZWF0ZSBzbmFwc2hvdHMgZm9yIGVhY2ggcmVsZWFzZSBpbmNsdWRp
bmcgdGhlIHNvdXJjZSBjb2RlDQo+IHBhY2thZ2VzDQo+ID4gPg0KPiA+ID4gU3RvcmluZyBtZXRh
ZGF0YSBzaG91bGQgbm90IGJlIHRvbyBkaWZmaWN1bHQsIGp1c3QgYWRkIHNvbWUgc2NyaXB0DQo+
ID4gPiBjb2RlIHRvIGdpdGxhYi1jaS4NCj4gPiA+DQo+ID4gPiBLZWVwaW5nIHNuYXBzaG90cyB3
b3VsZCByZXF1aXJlIG11Y2ggbW9yZSB3b3JrIGFuZCByZXNvdXJjZXMuIEkgdGhpbmsNCj4gPiA+
IHRoaXMgaXMgbm90IG5lY2Vzc2FyeSBzaW5jZSB3ZSBhcmUgbm90IGdvaW5nIHRvIHJlYnVpbGQg
aW1hZ2VzLCBhbmQNCj4gPiA+IGlmIHdlIHdhbnRlZCB3ZSBjb3VsZCBkbyBpdCBzb21laG93IGZy
b20gdGhlIHBhY2thZ2UgbGlzdCBtYW5pZmVzdA0KPiA+ID4gYW5kIHRoZSB1cHN0cmVhbSBEZWJp
YW4gZnRwIHNlcnZlcnMuDQo+ID4NCj4gPiBXZSBzaG91bGQgY2VydGFpbmx5IHJlY29yZCBhbGwg
dGhlIGlucHV0cyBmb3IgYW4gaW1hZ2U7IHRoYXQncyBhDQo+ID4gcmVxdWlyZW1lbnQgZm9yIHJl
cHJvZHVjaWJsZSBidWlsZHMuICBJZGVhbGx5IHRoaXMgcmVjb3JkIHdvdWxkIGJlDQo+ID4gc3Vm
ZmljaWVudCBmb3Igc29tZW9uZSB0byByZXBlYXQgdGhlIGltYWdlIGJ1aWxkIGluIGFuIGF1dG9t
YXRlZCB3YXksDQo+ID4gZWl0aGVyIHN0cmFpZ2h0IGF3YXkgb3IgYXQgYW55IHBvaW50IGluIHRo
ZSBmdXR1cmUuDQo+IA0KPiBUcnVlLiBJIGd1ZXNzIHdlIHdpbGwgaGF2ZSB0byBkbyBpdCBwcm9w
ZXJseSA7KQ0KPiANCj4gVGhhbmtzLA0KPiBEYW5pZWwNCj4gDQo+ID4NCj4gPiBCZW4uDQo+ID4N
Cj4gPiAtLQ0KPiA+IEJlbiBIdXRjaGluZ3MsIFNvZnR3YXJlIERldmVsb3BlciAgICAgICAgICAg
ICAgICAgICAgICAgICBDb2RldGhpbmsgTHRkDQo+ID4gaHR0cHM6Ly93d3cuY29kZXRoaW5rLmNv
LnVrLyAgICAgICAgICAgICAgICAgRGFsZSBIb3VzZSwgMzUgRGFsZSBTdHJlZXQNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTWFuY2hlc3RlciwgTTEgMkhGLCBVbml0
ZWQgS2luZ2RvbQ0KDQo=

--nXvPCbd0HXfQY2Bjp9TI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4643): https://lists.cip-project.org/g/cip-dev/message=
/4643
Mute This Topic: https://lists.cip-project.org/mt/74318282/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--nXvPCbd0HXfQY2Bjp9TI--
