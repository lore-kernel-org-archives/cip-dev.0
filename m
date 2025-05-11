Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E86DC3ABCB
	for <webhook@archiver.kernel.org>; Sun, 11 May 2025 17:37:17 +0000 (UTC)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 by mx.groups.io with SMTP id smtpd.web11.33100.1746985030047585463
 for <cip-dev@lists.cip-project.org>;
 Sun, 11 May 2025 10:37:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=CWfECKIS;
 spf=pass (domain: ti.com, ip: 198.47.19.245, mailfrom: s-adivi@ti.com)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 54BHb8SB1797454
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Sun, 11 May 2025 12:37:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1746985028;
	bh=WrdOMV6qSIMC5eP6ukQX6x0DmR/7+ne356sXUH79TAk=;
	h=From:To:CC:Subject:Date;
	b=CWfECKISzBjtTb+OYMtk5T7hWs/eDGNsK5tXVN13cVqArmD1YnVKudvg+9nEuHYz5
	 DG9w8c4VENmD4nY1rmPkIvbMbsI9aD+G4kI/U9LHXYG71e7QT9dCmAsquW7OZZDM28
	 tmxmnYF+idu7fE0qZF0Hh3GhPkSIxWN5966aQGm8=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 54BHb8lf000564
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <cip-dev@lists.cip-project.org>; Sun, 11 May 2025 12:37:08 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 11
 May 2025 12:37:08 -0500
Received: from DLEE108.ent.ti.com ([fe80::922:4dc:27cc:b334]) by
 DLEE108.ent.ti.com ([fe80::922:4dc:27cc:b334%17]) with mapi id
 15.01.2507.023; Sun, 11 May 2025 12:37:08 -0500
From: "Adivi, Sai Sree Kartheek" <s-adivi@ti.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Raghavendra, Vignesh" <vigneshr@ti.com>,
        "Khasim, Syed Mohammed"
	<khasim@ti.com>
Subject: Support for TI AM62P SK in isar-cip-core: U-Boot and Kernel Version
 Plans
Thread-Topic: Support for TI AM62P SK in isar-cip-core: U-Boot and Kernel
 Version Plans
Thread-Index: AQHbwptRHlTwHHRHQECI3rMBEmGeKA==
Date: Sun, 11 May 2025 17:37:08 +0000
Message-ID: <3574c4cc-2ab7-4e97-945c-24c959891eb6@email.android.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-c2processedorg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
Content-Type: multipart/alternative;
	boundary="_000_3574c4cc2ab74e97945c24c959891eb6emailandroidcom_"
MIME-Version: 1.0
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 11 May 2025 17:37:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18887

--_000_3574c4cc2ab74e97945c24c959891eb6emailandroidcom_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

RGVhciBDSVAgRGV2ZWxvcGVycywNCg0KSSBhbSBwbGFubmluZyB0byBhZGQgc3VwcG9ydCBmb3Ig
dGhlIFRJIEFNNjJQIFNLIHBsYXRmb3JtIHRvIHRoZSBpc2FyLWNpcC1jb3JlIHByb2plY3QuIEhv
d2V2ZXIsIEkgaGF2ZSBhIGNvdXBsZSBvZiBxdWVzdGlvbnMgcmVnYXJkaW5nIHZlcnNpb24gYWxp
Z25tZW50cyBmb3IgYm90aCBVLUJvb3QgYW5kIHRoZSBMaW51eCBLZXJuZWw6DQoNCjEuIFUtQm9v
dDoNCkN1cnJlbnRseSwgaXNhci1jaXAtY29yZSB1c2VzIFUtQm9vdCAyMDI0LjAxIGFjcm9zcyBh
bGwgc3VwcG9ydGVkIHBsYXRmb3Jtcy4gVGhlIFRJIEFNNjJQIFNLIHBsYXRmb3JtIGlzIHN1cHBv
cnRlZCBvbmx5IGZyb20gVS1Cb290IHZlcnNpb24gMjAyNS4wMSBvbndhcmRzLg0KDQpXaGF0IGlz
IHRoZSBjdXJyZW50IHBsYW4gb3IgdGltZWxpbmUgZm9yIHVwZGF0aW5nIGlzYXItY2lwLWNvcmUg
dG8gVS1Cb290IDIwMjUuMDE/DQoNCkFsdGVybmF0aXZlbHksIHdvdWxkIGl0IGJlIGFjY2VwdGFi
bGUgdG8gaW50cm9kdWNlIFUtQm9vdCAyMDI1LjAxIG9ubHkgZm9yIFRJIEFNNjJQIFNLIHdoaWxl
IHJldGFpbmluZyAyMDI0LjAxIGZvciBvdGhlciBwbGF0Zm9ybXM/DQoNCjIuIExpbnV4IEtlcm5l
bDoNCkkgbm90aWNlZCB0aGF0IGEgYnJhbmNoIGZvciA2LjEyLnktY2lwIGhhcyBiZWVuIGNyZWF0
ZWQuIFNpbmNlIFRJIEFNNjJQIFNLIHN1cHBvcnQgaXMgbm90IGF2YWlsYWJsZSBpbiB0aGUgY3Vy
cmVudCA2LjEueS1jaXAga2VybmVsLCB3ZSB3b3VsZCBwcmVmZXIgdG8gdXNlIHRoZSA2LjEyIGJh
c2VsaW5lIHJhdGhlciB0aGFuIGJhY2twb3J0aW5nIHN1cHBvcnQgdG8gNi4xLnktY2lwLg0KDQpJ
cyB0aGVyZSBhIHBsYW4vdGltZWxpbmUgZm9yIGludGVncmF0aW5nIHRoZSA2LjEyLnktY2lwIGtl
cm5lbCBpbnRvIGlzYXItY2lwLWNvcmU/DQoNCg0KWW91ciBpbnNpZ2h0cyBvbiB0aGVzZSBwb2lu
dHMgd2lsbCBoZWxwIGd1aWRlIG5leHQgc3RlcHMgZm9yIHRoaXMgcGxhdGZvcm0gYWRkaXRpb24u
IFRoYW5rIHlvdSBmb3IgeW91ciB0aW1lIGFuZCBleHBlcnRpc2UuDQoNCkJlc3QgcmVnYXJkcywN
ClNhaSBTcmVlIEthcnRoZWVrIEFkaXZpLA0KVGV4YXMgSW5zdHJ1bWVudHMNCg==

--_000_3574c4cc2ab74e97945c24c959891eb6emailandroidcom_
Content-Type: text/html; charset="utf-8"
Content-ID: <A4B7E8CB7D3D4047BFDE204389D97052@owa.mail.ti.com>
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjwvaGVhZD4NCjxib2R5Pg0KPGRpdiBkaXI9ImF1
dG8iPg0KPGRpdiBkaXI9ImF1dG8iPkRlYXIgQ0lQIERldmVsb3BlcnMsPC9kaXY+DQo8ZGl2IGRp
cj0iYXV0byI+PGJyPg0KPC9kaXY+DQo8ZGl2IGRpcj0iYXV0byI+SSBhbSBwbGFubmluZyB0byBh
ZGQgc3VwcG9ydCBmb3IgdGhlIFRJIEFNNjJQIFNLIHBsYXRmb3JtIHRvIHRoZSBpc2FyLWNpcC1j
b3JlIHByb2plY3QuIEhvd2V2ZXIsIEkgaGF2ZSBhIGNvdXBsZSBvZiBxdWVzdGlvbnMgcmVnYXJk
aW5nIHZlcnNpb24gYWxpZ25tZW50cyBmb3IgYm90aCBVLUJvb3QgYW5kIHRoZSBMaW51eCBLZXJu
ZWw6PC9kaXY+DQo8ZGl2IGRpcj0iYXV0byI+PGJyPg0KPC9kaXY+DQo8ZGl2IGRpcj0iYXV0byI+
MS4gVS1Cb290OjwvZGl2Pg0KPGRpdiBkaXI9ImF1dG8iPkN1cnJlbnRseSwgaXNhci1jaXAtY29y
ZSB1c2VzIFUtQm9vdCAyMDI0LjAxIGFjcm9zcyBhbGwgc3VwcG9ydGVkIHBsYXRmb3Jtcy4gVGhl
IFRJIEFNNjJQIFNLIHBsYXRmb3JtIGlzIHN1cHBvcnRlZCBvbmx5IGZyb20gVS1Cb290IHZlcnNp
b24gMjAyNS4wMSBvbndhcmRzLjwvZGl2Pg0KPGRpdiBkaXI9ImF1dG8iPjxicj4NCjwvZGl2Pg0K
PGRpdiBkaXI9ImF1dG8iPldoYXQgaXMgdGhlIGN1cnJlbnQgcGxhbiBvciB0aW1lbGluZSBmb3Ig
dXBkYXRpbmcgaXNhci1jaXAtY29yZSB0byBVLUJvb3QgMjAyNS4wMT88L2Rpdj4NCjxkaXYgZGly
PSJhdXRvIj48YnI+DQo8L2Rpdj4NCjxkaXYgZGlyPSJhdXRvIj5BbHRlcm5hdGl2ZWx5LCB3b3Vs
ZCBpdCBiZSBhY2NlcHRhYmxlIHRvIGludHJvZHVjZSBVLUJvb3QgMjAyNS4wMSBvbmx5IGZvciBU
SSBBTTYyUCBTSyB3aGlsZSByZXRhaW5pbmcgMjAyNC4wMSBmb3Igb3RoZXIgcGxhdGZvcm1zPzwv
ZGl2Pg0KPGRpdiBkaXI9ImF1dG8iPjxicj4NCjwvZGl2Pg0KPGRpdiBkaXI9ImF1dG8iPjIuIExp
bnV4IEtlcm5lbDo8L2Rpdj4NCjxkaXYgZGlyPSJhdXRvIj5JIG5vdGljZWQgdGhhdCBhIGJyYW5j
aCBmb3IgNi4xMi55LWNpcCBoYXMgYmVlbiBjcmVhdGVkLiBTaW5jZSBUSSBBTTYyUCBTSyBzdXBw
b3J0IGlzIG5vdCBhdmFpbGFibGUgaW4gdGhlIGN1cnJlbnQgNi4xLnktY2lwIGtlcm5lbCwgd2Ug
d291bGQgcHJlZmVyIHRvIHVzZSB0aGUgNi4xMiBiYXNlbGluZSByYXRoZXIgdGhhbiBiYWNrcG9y
dGluZyBzdXBwb3J0IHRvIDYuMS55LWNpcC48L2Rpdj4NCjxkaXYgZGlyPSJhdXRvIj48YnI+DQo8
L2Rpdj4NCjxkaXYgZGlyPSJhdXRvIj5JcyB0aGVyZSBhIHBsYW4vdGltZWxpbmUgZm9yIGludGVn
cmF0aW5nIHRoZSA2LjEyLnktY2lwIGtlcm5lbCBpbnRvIGlzYXItY2lwLWNvcmU/PC9kaXY+DQo8
ZGl2IGRpcj0iYXV0byI+PGJyPg0KPC9kaXY+DQo8ZGl2IGRpcj0iYXV0byI+PGJyPg0KPC9kaXY+
DQo8ZGl2IGRpcj0iYXV0byI+WW91ciBpbnNpZ2h0cyBvbiB0aGVzZSBwb2ludHMgd2lsbCBoZWxw
IGd1aWRlIG5leHQgc3RlcHMgZm9yIHRoaXMgcGxhdGZvcm0gYWRkaXRpb24uIFRoYW5rIHlvdSBm
b3IgeW91ciB0aW1lIGFuZCBleHBlcnRpc2UuPC9kaXY+DQo8ZGl2IGRpcj0iYXV0byI+PGJyPg0K
PC9kaXY+DQo8ZGl2IGRpcj0iYXV0byI+QmVzdCByZWdhcmRzLDwvZGl2Pg0KPGRpdiBkaXI9ImF1
dG8iPlNhaSBTcmVlIEthcnRoZWVrIEFkaXZpLDwvZGl2Pg0KPGRpdiBkaXI9ImF1dG8iPlRleGFz
IEluc3RydW1lbnRzPC9kaXY+DQo8L2Rpdj4NCjwvYm9keT4NCjwvaHRtbD4NCg==

--_000_3574c4cc2ab74e97945c24c959891eb6emailandroidcom_--

