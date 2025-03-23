Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDE2C28B30
	for <webhook@archiver.kernel.org>; Sun, 23 Mar 2025 03:36:33 +0000 (UTC)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 by mx.groups.io with SMTP id smtpd.web11.9877.1742700987414535377
 for <cip-dev@lists.cip-project.org>;
 Sat, 22 Mar 2025 20:36:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=mynaoyRs;
 spf=pass (domain: ti.com, ip: 198.47.23.234, mailfrom: s-adivi@ti.com)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52N3aQOf596127
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <cip-dev@lists.cip-project.org>; Sat, 22 Mar 2025 22:36:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1742700986;
	bh=Yr/18Ytu+cgVemcL5Ra8UJP2XE4IDEkR67AK+plA6N4=;
	h=From:To:Subject:Date;
	b=mynaoyRslHJd6Xc2BDg8z4xv9cXfNmVll51M2Fmuvq++WW5qS/IyBB5W+z6szWWup
	 QAyObJS5Q9uVQeyVC9R9U7jUhnNSHr1LbTkM4kLsU8cWJwGfHQXIXuTcZo1FaJdaWQ
	 /5J74v8pB3B8+itpuc9mq7gxOkEL2mZ5jCjt+DSU=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52N3aQOL129473
	for <cip-dev@lists.cip-project.org>; Sat, 22 Mar 2025 22:36:26 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 22
 Mar 2025 22:36:26 -0500
Received: from DLEE108.ent.ti.com ([fe80::922:4dc:27cc:b334]) by
 DLEE108.ent.ti.com ([fe80::922:4dc:27cc:b334%17]) with mapi id
 15.01.2507.023; Sat, 22 Mar 2025 22:36:25 -0500
From: "Adivi, Sai Sree Kartheek" <s-adivi@ti.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: [cip-dev] help required to understand isar-cip-core for new platform
 addition
Thread-Topic: [cip-dev] help required to understand isar-cip-core for new
 platform addition
Thread-Index: AQHbm6TB3O2k5nD8sUeUxp23ki5Smw==
Date: Sun, 23 Mar 2025 03:36:25 +0000
Message-ID: <86937cf5-aa90-4e40-a24d-ab2eae156a3c@email.android.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-c2processedorg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
Content-Type: multipart/alternative;
	boundary="_000_86937cf5aa904e40a24dab2eae156a3cemailandroidcom_"
MIME-Version: 1.0
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 23 Mar 2025 03:36:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18333

--_000_86937cf5aa904e40a24dab2eae156a3cemailandroidcom_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgQWxsLA0KDQpJJ20gdHJ5aW5nIHRvIGFkZCBzdXBwb3J0IGZvciBUSSBBTTYyeCBTSyBpbiBp
c2FyLWNpcC1jb3JlLg0KDQpBcyBhIHN0YXJ0aW5nIHBvaW50IHRvIHNlZSBob3cgdGhlIGltYWdl
cyBhcmUgcGFydGl0aW9uZWQgYW5kIHN0cnVjdHVyZWQsIEkndmUgYnVpbGQgYSA2LjEgQm9va3dv
cm0gaW1hZ2UgZm9yIEJlYWdsZUJvbmUgQmxhY2suIEkgc2VlIHRoYXQgdGhlcmUgaXMgb25seSBv
bmUgZXh0NCBwYXJ0aXRpb24gd2hpY2ggaG9sZHMgdGhlIHJvb3RmcyBhbmQgdGhlcmUgaXMgbm8g
ZmF0MzIgcGFydGl0aW9uIGZvciB0aGUgYm9vdGxvYWRlci4NCkkndmUgdHJpZWQgdG8gYm9vdCBp
dCBvbiBCQkIgYW5kIGl0IHNlZW1zIHRvIGJlIHN0YXJ0aW5nIHRoZSBVLWJvb3QgZnJvbSBlbW1j
IGFuZCBwaWNraW5nIHVwIEZpbGVzeXN0ZW0gZnJvbSBTRCBjYXJkLg0KDQotIElzIHRoaXMgdGhl
IGV4cGVjdGF0aW9uIGZvciBhbGwgcGxhdGZvcm1zPw0KLSBEb2Vzbid0IHRoZSBpc2FyLWNpcC1j
b3JlIGltYWdlIHBhY2thZ2UgdS1ib290PyBPciBhbSBJIG1pc3Npbmcgc29tZSBjb25maWcgb3B0
aW9uIHdoaWxlIGJ1aWxkaW5nPw0KLSBBbHNvIGlmIHRoZSB1LWJvb3QgaXMgbm90IHN1cHBvc2Vk
IHRvIGJlIHBhY2thZ2VkLCB3aHkgZG8gd2UgaGF2ZSBhIHUtYm9vdCByZWNpcGUgaW4gaXNhci1j
aXAtY29yZT8NCg0KSSB3b3VsZCBhcHByZWNpYXRlIGFueSBpbnNpZ2h0cyBvciBndWlkYW5jZSBm
cm9tIHRoZSBjb21tdW5pdHkuIElmIHRoZXJlIGFyZSByZWxldmFudCByZWZlcmVuY2VzLCBwYXN0
IGRpc2N1c3Npb25zLCBvciBkb2N1bWVudGF0aW9uIHJlZ2FyZGluZyB0aGlzLCBwbGVhc2UgbGV0
IG1lIGtub3cuDQoNClBTOiBJJ3ZlIGFsc28gdHJpZWQgYnVpbGRpbmcgYW4gaW1hZ2Ugd2l0aCBz
YW1lIGNvbmZpZ3VyYXRpb24gZm9yIGhpaG9wZS1yemcybSBhbmQgc2VlbiBzaW1pbGFyIG9ic2Vy
dmF0aW9ucyAod2ljIGltYWdlIGRvZXNuJ3QgaGF2ZSBhIGJvb3Rsb2FkZXIpLg0KDQpUaGFua3Mg
JiBSZWdhcmRzLA0KU2FpIFNyZWUgS2FydGhlZWsgQWRpdmkNCg0KDQo=

--_000_86937cf5aa904e40a24dab2eae156a3cemailandroidcom_
Content-Type: text/html; charset="utf-8"
Content-ID: <DD4C88A626807E41A11A9AC82DF8FBB2@owa.mail.ti.com>
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjwvaGVhZD4NCjxib2R5Pg0KPGRpdiBkaXI9ImF1
dG8iPkhpIEFsbCwNCjxkaXYgZGlyPSJhdXRvIj48YnI+DQo8L2Rpdj4NCjxkaXYgZGlyPSJhdXRv
Ij5JJ20gdHJ5aW5nIHRvIGFkZCBzdXBwb3J0IGZvciBUSSBBTTYyeCBTSyBpbiBpc2FyLWNpcC1j
b3JlLjwvZGl2Pg0KPGRpdiBkaXI9ImF1dG8iPjxicj4NCjwvZGl2Pg0KPGRpdiBkaXI9ImF1dG8i
PkFzIGEgc3RhcnRpbmcgcG9pbnQgdG8gc2VlIGhvdyB0aGUgaW1hZ2VzIGFyZSBwYXJ0aXRpb25l
ZCBhbmQgc3RydWN0dXJlZCwgSSd2ZSBidWlsZCBhIDYuMSBCb29rd29ybSBpbWFnZSBmb3IgQmVh
Z2xlQm9uZSBCbGFjay4gSSBzZWUgdGhhdCB0aGVyZSBpcyBvbmx5IG9uZSBleHQ0IHBhcnRpdGlv
biB3aGljaCBob2xkcyB0aGUgcm9vdGZzIGFuZCB0aGVyZSBpcyBubyBmYXQzMiBwYXJ0aXRpb24g
Zm9yIHRoZSBib290bG9hZGVyLiZuYnNwOzwvZGl2Pg0KPGRpdiBkaXI9ImF1dG8iPkkndmUgdHJp
ZWQgdG8gYm9vdCBpdCBvbiBCQkIgYW5kIGl0IHNlZW1zIHRvIGJlIHN0YXJ0aW5nIHRoZSBVLWJv
b3QgZnJvbSBlbW1jIGFuZCBwaWNraW5nIHVwIEZpbGVzeXN0ZW0gZnJvbSBTRCBjYXJkLjwvZGl2
Pg0KPGRpdiBkaXI9ImF1dG8iPjxicj4NCjwvZGl2Pg0KPGRpdiBkaXI9ImF1dG8iPi0gSXMgdGhp
cyB0aGUgZXhwZWN0YXRpb24gZm9yIGFsbCBwbGF0Zm9ybXM/PC9kaXY+DQo8ZGl2IGRpcj0iYXV0
byI+LSBEb2Vzbid0IHRoZSBpc2FyLWNpcC1jb3JlIGltYWdlIHBhY2thZ2UgdS1ib290PyBPciBh
bSBJIG1pc3Npbmcgc29tZSBjb25maWcgb3B0aW9uIHdoaWxlIGJ1aWxkaW5nPzwvZGl2Pg0KPGRp
diBkaXI9ImF1dG8iPi0gQWxzbyBpZiB0aGUgdS1ib290IGlzIG5vdCBzdXBwb3NlZCB0byBiZSBw
YWNrYWdlZCwgd2h5IGRvIHdlIGhhdmUgYSB1LWJvb3QgcmVjaXBlIGluIGlzYXItY2lwLWNvcmU/
PC9kaXY+DQo8ZGl2IGRpcj0iYXV0byI+PGJyPg0KPC9kaXY+DQo8ZGl2IGRpcj0iYXV0byI+SSB3
b3VsZCBhcHByZWNpYXRlIGFueSBpbnNpZ2h0cyBvciBndWlkYW5jZSBmcm9tIHRoZSBjb21tdW5p
dHkuIElmIHRoZXJlIGFyZSByZWxldmFudCByZWZlcmVuY2VzLCBwYXN0IGRpc2N1c3Npb25zLCBv
ciBkb2N1bWVudGF0aW9uIHJlZ2FyZGluZyB0aGlzLCBwbGVhc2UgbGV0IG1lIGtub3cuPC9kaXY+
DQo8ZGl2IGRpcj0iYXV0byI+PGJyPg0KPC9kaXY+DQo8ZGl2IGRpcj0iYXV0byI+UFM6IEkndmUg
YWxzbyB0cmllZCBidWlsZGluZyBhbiBpbWFnZSB3aXRoIHNhbWUgY29uZmlndXJhdGlvbiBmb3Ig
aGlob3BlLXJ6ZzJtIGFuZCBzZWVuIHNpbWlsYXIgb2JzZXJ2YXRpb25zICh3aWMgaW1hZ2UgZG9l
c24ndCBoYXZlIGEgYm9vdGxvYWRlcikuPC9kaXY+DQo8ZGl2IGRpcj0iYXV0byI+PGJyPg0KPC9k
aXY+DQo8ZGl2IGRpcj0iYXV0byI+VGhhbmtzICZhbXA7IFJlZ2FyZHMsPC9kaXY+DQo8ZGl2IGRp
cj0iYXV0byI+U2FpIFNyZWUgS2FydGhlZWsgQWRpdmk8L2Rpdj4NCjxkaXYgZGlyPSJhdXRvIj48
YnI+DQo8L2Rpdj4NCjxkaXYgZGlyPSJhdXRvIj48YnI+DQo8L2Rpdj4NCjwvZGl2Pg0KPC9ib2R5
Pg0KPC9odG1sPg0K

--_000_86937cf5aa904e40a24dab2eae156a3cemailandroidcom_--

