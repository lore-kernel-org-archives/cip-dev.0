Return-Path: <muhammad_usama.sardar@tu-dresden.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61760CA6017
	for <webhook@archiver.kernel.org>; Fri,  9 Oct 2026 00:34:43 +0000 (UTC)
Received: from mailout4.zih.tu-dresden.de (mailout4.zih.tu-dresden.de [141.30.67.75])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.605.1791506082132938444
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Oct 2026 17:34:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tu-dresden.de header.s=dkim2022 header.b=BhLNlS8r;
 spf=pass (domain: tu-dresden.de, ip: 141.30.67.75, mailfrom: muhammad_usama.sardar@tu-dresden.de)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=tu-dresden.de; s=dkim2022; h=Content-Type:Subject:From:To:MIME-Version:Date
	:Message-ID:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eTAHwINPhJUhGOAClxMh4B1JV9xxOYj68HKbeTstxzI=; b=BhLNlS8rxEM7qohxsUB7IpqYRT
	C1ARWPRP+v5T1n2plKg7f1G78BNW+yxfRomJiJg0goRVEN7N3hjLIJdld6+xhv26+JLra6nSR8Hjm
	QtEXh31YRkj6SWTXEPMfz2+zJMdDFLLWo/aIjsMax3alDEJj1DrK73JqZuKHsT6fh4gH4xv8Y2ug/
	H8FC0LtT3uKpT2AIR89IcrEG8nSk84r48lRneteBPEGCkY07bBqVrOhQlExsivuBJhmlFjGdHl5Zo
	z/u1wU6R7szNE8YoJO4L+ZhKEsFC9K+o2j19l5amwG28gRu26eYlV9B3cHD/FgxcnAAiBH5RgzFVf
	smzZHJqg==;
Received: from msx-t422.msx.ad.zih.tu-dresden.de ([172.26.35.139] helo=msx.tu-dresden.de)
	by mailout4.zih.tu-dresden.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <muhammad_usama.sardar@tu-dresden.de>)
	id 1xEyZI-007N2A-0Y
	for cip-dev@lists.cip-project.org;
	Fri, 09 Oct 2026 02:34:40 +0200
Received: from [10.12.5.228] (141.76.13.149) by
 msx-t422.msx.ad.zih.tu-dresden.de (172.26.35.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Fri, 9 Oct 2026 02:34:30 +0200
Message-ID: <4c7d8498-b8d9-4cac-915e-874bbcfe6d97@tu-dresden.de>
Date: Fri, 9 Oct 2026 02:34:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: <cip-dev@lists.cip-project.org>
From: Muhammad Usama Sardar <muhammad_usama.sardar@tu-dresden.de>
Subject: =?UTF-8?Q?Contribution=3A_EarlyAttestationBleed=3A_Three_Critical-s?=
 =?UTF-8?Q?everity_Vulnerabilities_of_CVSS_=E2=89=A5_9=2E0_in_Confidential_C?=
 =?UTF-8?Q?omputing?=
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
	micalg=sha-512; boundary="------------ms050601000004070508050504"
X-ClientProxiedBy: MSX-L414.msx.ad.zih.tu-dresden.de (172.26.34.134) To
 msx-t422.msx.ad.zih.tu-dresden.de (172.26.35.139)
X-TUD-Virus-Scanned: mailout4.zih.tu-dresden.de
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Oct 2026 00:34:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24442

--------------ms050601000004070508050504
Content-Type: multipart/alternative;
 boundary="------------3S6qIdMu60lbWLDqEHoGjeGf"

--------------3S6qIdMu60lbWLDqEHoGjeGf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQojICpDb250ZXh0Kg0KDQpDb25ncmF0dWxhdGlvbnMgb24geW91ciAxMCB5
ZWFycyBvZiBvcGVuLXNvdXJjZSBjb250cmlidXRpb25zISBJdCB3YXMgYSANCmdyZWF0IHBs
ZWFzdXJlIHRvIG1lZXQgeW91ciBwcm9qZWN0IG1lbWJlcnMgYXQgT1NTIGluIFByYWd1ZS4N
Cg0KSSBzZXJ2ZSBhcyB0aGUgY2hhaXIgb2YgdGhlIFRydXN0ZWQgUmVzZWFyY2ggRW52aXJv
bm1lbnQgT3BlbiBTdWl0ZSANCihPcGVuVFJFKSBhdCB0aGUgR2xvYmFsIEFsbGlhbmNlIGZv
ciBHZW5vbWljcyBhbmQgSGVhbHRoIChHQTRHSCkuIA0KT3BlblRSRSB3b3VsZCBsaWtlIHRv
IHNlZWsgb3Bwb3J0dW5pdHkgdG8gY29sbGFib3JhdGUgYW5kIGNvbnRyaWJ1dGUgdG8gDQp0
aGUgU2VjdXJpdHkgV29ya2dyb3VwLiBEZW1vIHBhcnQtMiBvbiBzZWN1cmUgYm9vdCwgZGlz
ayBlbmNyeXB0aW9uLCBhbmQgDQpmYWN0b3J5IHJlc2V0IGluIENJUCBzb3VuZHMgcGFydGlj
dWxhcmx5IGludGVyZXN0aW5nLiBIb3dldmVyLCBHaXRsYWIgDQpmb3IgU2VjdXJpdHkgV29y
a2dyb3VwIFswXSBzZWVtcyB0byBiZSBlbXB0eS4NCg0KUmVsYXRlZCB0byBkZW1vIHBhcnQt
MiBpcyBvdXIgT3BlblRSRSBHQTRHSCB3b3JrIHRoYXQgSSBwcmVzZW50ZWQgaW4gdHdvIA0K
c2Vzc2lvbnMgYXQgTGludXggUGx1bWJlcnMgQ29uZmVyZW5jZSAoTFBDJzI2KToNCg0KIDEu
IFN5c3RlbSBCb290IGFuZCBTZWN1cml0eSBNaWNyby1Db25mZXJlbmNlIFsxXQ0KIDIuIEF0
dGVzdGVkIFRMUyBCaXJkcyBvZiBGZWF0aGVyIChCb0YpIHNlc3Npb24gWzJdDQoNCkEga2V5
IGlubm92YXRpb24gb2YgdGhlIE9wZW5UUkUgaXMgaXRzIGZvdW5kYXRpb24gaW4gZm9ybWFs
IHNlY3VyaXR5IA0KYW5hbHlzaXMsIGluIHBhcnRpY3VsYXIgZm9yIGF0dGVzdGVkIFRMUyBw
cm90b2NvbHMgdW5kZXIgY29uZmlkZW50aWFsIA0KY29tcHV0aW5nIHRocmVhdCBtb2RlbC4g
T3VyIGdvYWwgd2FzIHRvIGZpbmQgYSBmb3JtYWxseSB2ZXJpZmllZCBiYXNpcyANCmZvciBP
cGVuIFRSRSBhbmQgdG8gc3RhbmRhcmRpemUgaXQgYXQgdGhlIElFVEYgdG8gbWFrZSBzdXJl
IHRoYXQgbm8gDQp2dWxuZXJhYmlsaXRpZXMgYXJlIG1pc3NlZC4NCg0KU28gd2Ugd29yayBp
biBjbG9zZSBjb2xsYWJvcmF0aW9uIHdpdGggdGhlIElFVEYuIEF0IElFVEYgU0VBTCAod2hp
Y2ggd2FzIA0KdGhlbiByZW5hbWVkIHRvIFNFQVQpIGNoYXJ0ZXJpbmcgdGltZSwgSUVTRyAo
ZS5nLiwgWzNdKSBhbmQgSUVURiANCnBhcnRpY2lwYW50cyAoZS5nLiwgWzRdKSByZXF1ZXN0
ZWQgb3BlcmF0aW9uYWwgZ3VpZGFuY2UgZm9yIGF0dGVzdGVkIA0KVExTLiBXZSBkaWQgc29t
ZSByZWxldmFudCBmb3JtYWwgYW5hbHlzaXMgb2YgdGhlIGltcGxlbWVudGF0aW9uIGFuZCAN
CndvdWxkIGxpa2UgdG8gc2hhcmUgb3VyIGNvbnRyaWJ1dGlvbiBwcmVzZW50aW5nIHRoZSBy
ZXN1bHRzIG9mIG91ciANCmFuYWx5c2lzIHdpdGggdGhlIENJUCBzZWN1cml0eSBjb21tdW5p
dHkgZm9yIGRpc2N1c3Npb24gYW5kIGNvbGxhYm9yYXRpb24uDQoNCkFsbCB0aHJlZSB2dWxu
ZXJhYmlsaXRpZXMgbWVudGlvbmVkIGJlbG93IGhhdmUgYmVlbiBwYXRjaGVkLg0KDQojICpL
ZXkgRmluZGluZ3MqDQoNCk91ciB3b3JrIGNvdmVycyB0aGUgZm9sbG93aW5nIHR3byBpbXBs
ZW1lbnRhdGlvbnMgb2YgZWFybHkgYXR0ZXN0YXRpb246DQoNCiMjICoxLiBVbHRyYXZpb2xl
dCBDb2NvcyBBSSoNCg0KVWx0cmF2aW9sZXQgY2xhaW1lZCB0byBiZSB0aGUgbW9zdCBzZWN1
cmUgYXR0ZXN0ZWQgVExTIHNvbHV0aW9uIGluIA0KQ29uZmlkZW50aWFsIENvbXB1dGluZyBD
b25zb3J0aXVtIChDQ0MpLiBXZSBkaXNjb3ZlcmVkIHR3byANCmNyaXRpY2FsLXNldmVyaXR5
IFs1XSAoQ1ZTUyA5LjEpIHZ1bG5lcmFiaWxpdGllcyBpbiB0aGVpciBpbXBsZW1lbnRhdGlv
biANCm9mIGVhcmx5IGF0dGVzdGF0aW9uLiBQdWJsaXNoZWQgR2l0SHViIFNlY3VyaXR5IEFk
dmlzb3JpZXMgKEdIU0FzKSBbNiw3XSANCmFyZSBxdWl0ZSBkZXRhaWxlZCBhbmQgZXhwbGlj
aXRseSBjaXRlIGFyZ3VtZW50cyBhZ2FpbnN0IA0KZHJhZnQtZm9zc2F0aS1zZWF0LWVhcmx5
LWF0dGVzdGF0aW9uLiBTbyB3ZSB3b24ndCByZXBlYXQgdGhhdCBoZXJlLg0KDQpNb3Jlb3Zl
ciwgdHdvIENWRXMgb2YgQ1ZTUyA5LjEgaGF2ZSBiZWVuIGlzc3VlZDogQ1ZFLTIwMjYtOTI3
MDEgWzhdIGFuZCANCkNWRS0yMDI2LTkyNzAyIFs5XS4NCg0KIyMgKjIuIEVkZ2VsZXNzIFN5
c3RlbXMgQ29udHJhc3QqDQoNCkVkZ2VsZXNzIFN5c3RlbXMgd2FzIGF3YXJkZWQgc2Vjb25k
IHBsYWNlIGluIHRoZSBjeWJlcnNlY3VyaXR5IGNhdGVnb3J5IA0Kb2YgdGhlIFdpcnRzY2hh
ZnRzV29jaGXigJlzIHdlbGwta25vd24gIkJlc3Qgb2YgVGVjaG5vbG9neSBBd2FyZHMiIHRo
aXMgDQp5ZWFyIFsxMF0uIFdlIGFuYWx5emVkIGl0cyBhdHRlc3RlZCBUTFMgc29sdXRpb24g
bmFtZWQgQ29udHJhc3QsIGFuZCANCmZvdW5kIGEgY3JpdGljYWwgdnVsbmVyYWJpbGl0eSBp
biB0aGUgQ1ZTUyByYW5nZSA5LjAgdG8gdGhlIG1heGltdW0gDQpwb3NzaWJsZSAxMC4wLiBH
SFNBIG9uIHRoaXMgaXMgcHVibGlzaGVkIFsxMV0uIENWRS0yMDI2LTEwMDgzMyBoYXMgYmVl
biANCnB1Ymxpc2hlZCBmb3IgdGhpcy4NCg0KIyAqRGlzY292ZXJ5IE1ldGhvZG9sb2d5Kg0K
DQogICogRm9ybWFsIGFuYWx5c2lzIHVzaW5nIHN0YXRlLW9mLXRoZS1hcnQgdG9vbCBQcm9W
ZXJpZg0KICAqIEltcGxlbWVudGF0aW9uLWxldmVsIHJlZ3Jlc3Npb24gdGVzdHMgZm9yIGNv
bmZpcm1hdGlvbg0KICAqIFJldmlld2VkIGFuZCBjb25maXJtZWQgYnkgZGV2ZWxvcGVycw0K
ICAqIEdIU0FzIHB1Ymxpc2hlZCBbNiw3XQ0KICAqIENWRXMgaXNzdWVkIFs4LDldDQogICog
Q1ZFLTIwMjYtMTAwODMzIGhhcyBiZWVuIGlzc3VlZCBmb3IgR0hTQSBbMTFdOw0KDQojICpF
dGhpY2FsIENvbnNpZGVyYXRpb25zKg0KDQpXZSBrZXB0IHRoZSB2dWxuZXJhYmlsaXRpZXMg
dW5kZXIgc3RyaWN0IC9yZXNwb25zaWJsZSBkaXNjbG9zdXJlLyB1bnRpbCANCmNvbmZpcm1l
ZCBhbmQgcHVibGlzaGVkIGJ5IHRoZSBkZXZlbG9wZXJzLiBDb2NvcyBBSSBoYXMgbW92ZWQg
dG8gDQpwb3N0LWhhbmRzaGFrZSBhdHRlc3RhdGlvbiwgd2hpbGUgRWRnZWxlc3MgU3lzdGVt
cyBjdXJyZW50bHkgbWFpbnRhaW5zIA0KZWFybHkgYXR0ZXN0YXRpb24uDQoNCiMgKlRlY2hu
aWNhbCBEZXRhaWxzKg0KDQpQbGVhc2Ugc2VlIFsxMl0uIEluIGFkZGl0aW9uIHRvIHRoZXNl
IHR3byBpbXBsZW1lbnRhdGlvbnMsIFNlYy4gNyBpbiANClsxMl0gZGVzY3JpYmVzIGdlbmVy
YWwgYXJndW1lbnRzIGFnYWluc3QgZWFybHkgYXR0ZXN0YXRpb24uDQoNCkxhdGVzdCBzdGF0
dXMgb2YgdnVsbmVyYWJpbGl0aWVzIGlzIGluIFsxM10uDQoNCiMgKkFja25vd2xlZGdtZW50
cyoNCg0KICAqIENvY29zIEFJIG1haW50YWluZXJzIChTYW1teSBLZXJhdGEgT2luYSBhbmQg
RHJhc2tvIERyYXNrb3ZpYykNCiAgKiBFZGdlbGVzcyBTeXN0ZW1zIENvbnRyYXN0IG1haW50
YWluZXIgKE1hcmt1cyBSdWR5KQ0KICAqDQoNCiAgICBLYXlhIEVyY2loYW4NCg0KICAqDQoN
CiAgICBKYW4gS2FobWVuDQoNCiAgKg0KDQogICAgUGVnIEpvbmVzDQoNCiAgKiBCZXJ0cmFu
ZCBGb2luZw0KICAqIFJlYmVrYWggT3ZlcmRvcmYgYW5kIFRvYmlhcyBQdWxscw0KDQpXZSB3
ZWxjb21lIGFueSBkaXNjdXNzaW9uIGZvciBmdXJ0aGVyIHNlY3VyaXR5IGFuYWx5c2lzIG9u
IHRoaXMgdG9waWMuIA0KV2Ugd291bGQgbG92ZSB0byBjb2xsYWJvcmF0ZSB3aXRoIENJUC4g
Q291bGQgeW91IHBsZWFzZSBzaGFyZSB5b3VyIA0KYXR0ZXN0YXRpb24gcHJvdG9jb2wgc3Bl
Y2lmaWNhdGlvbiBiZWZvcmUgd2UgZGVlcCBkaXZlIGludG8gdGhlIGNvZGU/IEl0IA0Kd291
bGQgYmUgaW50ZXJlc3RpbmcgdG8gc2VlIHdoZXRoZXIgYW55IG9mIHRoZSB2dWxuZXJhYmls
aXRpZXMgYXBwbHkgdG8gDQpDSVAgb3Igbm90Lg0KDQpCZXN0IHJlZ2FyZHMsDQoNCi1Vc2Ft
YQ0KDQoNClBTOiBUaGUgbmFtZSBFYXJseUF0dGVzdGF0aW9uQmxlZWQgaXMgaW5zcGlyZWQg
ZnJvbSBIZWFydGJsZWVkLCB3aGljaCANCndhcyBDVlNTIDcuNS4gQ1ZTUyA5LjEgYW5kIDku
MC0xMC4wIGlzIHN1cmVseSBtb3JlIGJsZWVkaW5nIHRoYW4gSGVhcnRibGVlZC4NCg0KDQpb
MF0gaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC1zZWN1cml0eQ0KDQpbMV0g
aHR0cHM6Ly9scGMuZXZlbnRzL2V2ZW50LzIwL2NvbnRyaWJ1dGlvbnMvMjU4NS8NCg0KWzJd
IGh0dHBzOi8vbHBjLmV2ZW50cy9ldmVudC8yMC9jb250cmlidXRpb25zLzI2NDAvDQoNClsz
XSBodHRwczovL21haWxhcmNoaXZlLmlldGYub3JnL2FyY2gvbXNnL3NlYWwvQkptZkFGUXhh
cDR0RE5mTmJDYmhSZkd3SjNzLw0KDQpbNF0gaHR0cHM6Ly9tYWlsYXJjaGl2ZS5pZXRmLm9y
Zy9hcmNoL21zZy9zZWFsL29OdFRXblE0MDl6eHFZWWJXSE5lVWZsY0Mzcy8NCg0KWzVdIGh0
dHBzOi8vbnZkLm5pc3QuZ292L3Z1bG4tbWV0cmljcy9jdnNzDQoNCls2XSANCmh0dHBzOi8v
Z2l0aHViLmNvbS91bHRyYXZpb2xldHJzL2NvY29zL3NlY3VyaXR5L2Fkdmlzb3JpZXMvR0hT
QS00cHgzLXdqMngteHg0Nw0KDQpbN10gDQpodHRwczovL2dpdGh1Yi5jb20vdWx0cmF2aW9s
ZXRycy9jb2Nvcy9zZWN1cml0eS9hZHZpc29yaWVzL0dIU0EtNHI2Zy1tcDQ4LWoycncNCg0K
WzhdIGh0dHBzOi8vd3d3LmN2ZS5vcmcvQ1ZFUmVjb3JkP2lkPUNWRS0yMDI2LTkyNzAxDQoN
Cls5XSBodHRwczovL3d3dy5jdmUub3JnL0NWRVJlY29yZD9pZD1DVkUtMjAyNi05MjcwMg0K
DQpbMTBdIGh0dHBzOi8vYXdhcmQud2l3by5kZS9ib3QvZ2V3aW5uZXItMjAyNi8NCg0KWzEx
XSANCmh0dHBzOi8vZ2l0aHViLmNvbS9lZGdlbGVzc3N5cy9jb250cmFzdC9zZWN1cml0eS9h
ZHZpc29yaWVzL0dIU0EtbTJxZy13cnh2LWg4OTgNCg0KWzEyXSANCmh0dHBzOi8vd3d3LnJl
c2VhcmNoZ2F0ZS5uZXQvcHVibGljYXRpb24vNDE0NTI5MTk5X0Vhcmx5QXR0ZXN0YXRpb25C
bGVlZF9UaHJlZV9Dcml0aWNhbC1zZXZlcml0eV9WdWxuZXJhYmlsaXRpZXNfb2ZfQ1ZTU185
MF9pbl9Db25maWRlbnRpYWxfQ29tcHV0aW5nDQoNClsxM10gaHR0cHM6Ly93d3cuaWV0Zi5v
cmcvYXJjaGl2ZS9pZC9kcmFmdC1pbnRyYS1oYW5kc2hha2UtZmFpbC01NS5odG1sDQoNCg==

--------------3S6qIdMu60lbWLDqEHoGjeGf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
  <head>

    <meta http-equiv=3D"content-type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body>
    <p> </p>
    <div class=3D"moz-text-html" lang=3D"x-unicode">
      <p>Hi all,<br>
      </p>
      <div class=3D"moz-text-html" lang=3D"x-unicode">
        <p># <b>Context</b></p>
        <p>Congratulations on your 10 years of open-source
          contributions! It was a great pleasure to meet your project
          members at OSS in Prague. <br>
        </p>
        <p>I serve as the chair of the Trusted Research Environment Open
          Suite (OpenTRE) at the Global Alliance for Genomics and Health
          (GA4GH). OpenTRE would like to seek opportunity to collaborate
          and contribute to the Security Workgroup. Demo part-2 on
          secure boot, disk encryption, and factory reset in CIP sounds
          particularly interesting. However, Gitlab for Security
          Workgroup [0] seems to be empty.<br>
        </p>
        <p>Related to demo part-2 is our OpenTRE GA4GH work that I
          presented in two sessions at Linux Plumbers Conference
          (LPC'26): </p>
        <ol>
          <li>System Boot and Security Micro-Conference [1]<br>
          </li>
          <li>Attested TLS Birds of Feather (BoF) session [2]</li>
        </ol>
        <p>A key innovation of the OpenTRE is its foundation in formal
          security analysis, in particular for attested TLS protocols
          under confidential computing threat model. Our goal was to
          find a formally verified basis for Open TRE and to standardize
          it at the IETF to make sure that no vulnerabilities are
          missed. </p>
        <p>So we work in close collaboration with the IETF. At IETF SEAL
          (which was then renamed to SEAT) chartering time, IESG (e.g.,
          [3]) and IETF participants (e.g., [4]) requested operational
          guidance for attested TLS. We did some relevant formal
          analysis of the implementation and would like to share our
          contribution presenting the results of our analysis with the
          CIP security community for discussion and collaboration.</p>
        <p>All three vulnerabilities mentioned below have been patched.<b=
r>
        </p>
        # <b>Key Findings</b> <br>
        <p>Our work covers the following two implementations of early
          attestation:</p>
        <p>## <b>1. Ultraviolet Cocos AI</b><br>
        </p>
        <p>Ultraviolet claimed to be the most secure attested TLS
          solution in Confidential Computing Consortium (CCC). We
          discovered two critical-severity [5] (CVSS 9.1)
          vulnerabilities in their implementation of early attestation.
          Published GitHub Security Advisories (GHSAs) [6,7] are quite
          detailed and explicitly cite arguments against
          draft-fossati-seat-early-attestation. So we won't repeat that
          here.=C2=A0</p>
        <p>Moreover, two CVEs of CVSS 9.1 have been issued:
          CVE-2026-92701 [8] and CVE-2026-92702 [9].</p>
        <p>## <b>2. Edgeless Systems Contrast</b><br>
        </p>
        <p>Edgeless Systems was awarded second place in the
          cybersecurity category of the WirtschaftsWoche=E2=80=99s well-k=
nown
          "Best of Technology Awards" this year [10]. We analyzed its
          attested TLS solution named Contrast, and found a critical
          vulnerability in the CVSS range 9.0 to the maximum possible
          10.0. GHSA on this is published [11]. CVE-2026-100833 has been
          published for this.<br>
        </p>
        <p># <b>Discovery Methodology</b> <br>
        </p>
        <ul>
          <li>Formal analysis using state-of-the-art tool ProVerif<br>
          </li>
          <li>Implementation-level regression tests for confirmation</li>=

          <li>Reviewed and confirmed by developers</li>
          <li>GHSAs published [6,7]<br>
          </li>
          <li>CVEs issued [8,9]</li>
          <li>CVE-2026-100833 has been issued for GHSA [11]; <br>
          </li>
        </ul>
        <p># <b>Ethical Considerations</b></p>
        <p>We kept the vulnerabilities under strict <i>responsible
            disclosure</i> until confirmed and published by the
          developers. Cocos AI has moved to post-handshake attestation,
          while Edgeless Systems currently maintains early attestation.</=
p>
        <p># <b>Technical Details</b><br>
        </p>
        <p>Please see [12]. In addition to these two implementations,
          Sec. 7 in [12] describes general arguments against early
          attestation.</p>
        <p>Latest status of vulnerabilities is in [13].<br>
        </p>
        <p># <b>Acknowledgments</b></p>
        <ul>
          <li>Cocos AI maintainers (Sammy Kerata Oina and Drasko
            Draskovic)</li>
          <li>Edgeless Systems Contrast maintainer (Markus Rudy)</li>
          <li class=3D"normal" id=3D"appendix-A-5.4"
            style=3D"margin: 0px 0px 0.25em;">
            <p id=3D"appendix-A-5.4.1"
              style=3D"padding: 0px; margin: 0px; text-align: left;">Kaya=

              Ercihan</p>
          </li>
          <li class=3D"normal" id=3D"appendix-A-5.5"
            style=3D"margin: 0px 0px 0.25em;">
            <p id=3D"appendix-A-5.5.1"
              style=3D"padding: 0px; margin: 0px; text-align: left;">Jan
              Kahmen</p>
          </li>
          <li class=3D"normal" id=3D"appendix-A-5.6"
            style=3D"margin: 0px 0px 0.25em;">
            <p id=3D"appendix-A-5.6.1"
              style=3D"padding: 0px; margin: 0px; text-align: left;">Peg
              Jones</p>
          </li>
          <li>Bertrand Foing</li>
          <li>Rebekah Overdorf and Tobias Pulls<br>
          </li>
        </ul>
        <p>We welcome any discussion for further security analysis on
          this topic. We would love to collaborate with CIP. Could you
          please share your attestation protocol specification before we
          deep dive into the code? It would be interesting to see
          whether any of the vulnerabilities apply to CIP or not.<br>
        </p>
        <p>Best regards, </p>
        <p>-Usama<br>
        </p>
        <p><br>
        </p>
        <p>PS: The name EarlyAttestationBleed is inspired from
          Heartbleed, which was CVSS 7.5. CVSS 9.1 and 9.0-10.0 is
          surely more bleeding than Heartbleed.</p>
        <p><br>
        </p>
        <p>[0] <a class=3D"moz-txt-link-freetext" href=3D"https://gitlab.=
com/cip-project/cip-security">https://gitlab.com/cip-project/cip-security=
</a></p>
        <p>[1] <a class=3D"moz-txt-link-freetext"
            href=3D"https://lpc.events/event/20/contributions/2585/">http=
s://lpc.events/event/20/contributions/2585/</a>
          <br>
          <br>
          [2] <a class=3D"moz-txt-link-freetext"
            href=3D"https://lpc.events/event/20/contributions/2640/">http=
s://lpc.events/event/20/contributions/2640/</a></p>
        <p>[3] <a class=3D"moz-txt-link-freetext"
href=3D"https://mailarchive.ietf.org/arch/msg/seal/BJmfAFQxap4tDNfNbCbhRf=
GwJ3s/">https://mailarchive.ietf.org/arch/msg/seal/BJmfAFQxap4tDNfNbCbhRf=
GwJ3s/</a></p>
        <p>[4] <a class=3D"moz-txt-link-freetext"
href=3D"https://mailarchive.ietf.org/arch/msg/seal/oNtTWnQ409zxqYYbWHNeUf=
lcC3s/">https://mailarchive.ietf.org/arch/msg/seal/oNtTWnQ409zxqYYbWHNeUf=
lcC3s/</a></p>
        <p>[5] <a class=3D"moz-txt-link-freetext"
            href=3D"https://nvd.nist.gov/vuln-metrics/cvss">https://nvd.n=
ist.gov/vuln-metrics/cvss</a></p>
        <p>[6] <a class=3D"moz-txt-link-freetext"
href=3D"https://github.com/ultravioletrs/cocos/security/advisories/GHSA-4=
px3-wj2x-xx47">https://github.com/ultravioletrs/cocos/security/advisories=
/GHSA-4px3-wj2x-xx47</a></p>
        <p>[7] <a class=3D"moz-txt-link-freetext"
href=3D"https://github.com/ultravioletrs/cocos/security/advisories/GHSA-4=
r6g-mp48-j2rw">https://github.com/ultravioletrs/cocos/security/advisories=
/GHSA-4r6g-mp48-j2rw</a></p>
        <p>[8] <a class=3D"moz-txt-link-freetext"
            href=3D"https://www.cve.org/CVERecord?id=3DCVE-2026-92701">ht=
tps://www.cve.org/CVERecord?id=3DCVE-2026-92701</a></p>
        <p>[9] <a class=3D"moz-txt-link-freetext"
            href=3D"https://www.cve.org/CVERecord?id=3DCVE-2026-92702">ht=
tps://www.cve.org/CVERecord?id=3DCVE-2026-92702</a></p>
        <p>[10] <a class=3D"moz-txt-link-freetext"
            href=3D"https://award.wiwo.de/bot/gewinner-2026/">https://awa=
rd.wiwo.de/bot/gewinner-2026/</a></p>
        <p>[11] <a class=3D"moz-txt-link-freetext"
href=3D"https://github.com/edgelesssys/contrast/security/advisories/GHSA-=
m2qg-wrxv-h898">https://github.com/edgelesssys/contrast/security/advisori=
es/GHSA-m2qg-wrxv-h898</a></p>
        <p>[12] <a class=3D"moz-txt-link-freetext"
href=3D"https://www.researchgate.net/publication/414529199_EarlyAttestati=
onBleed_Three_Critical-severity_Vulnerabilities_of_CVSS_90_in_Confidentia=
l_Computing">https://www.researchgate.net/publication/414529199_EarlyAtte=
stationBleed_Three_Critical-severity_Vulnerabilities_of_CVSS_90_in_Confid=
ential_Computing</a></p>
        [13]
        <a class=3D"moz-txt-link-freetext" href=3D"https://www.ietf.org/a=
rchive/id/draft-intra-handshake-fail-55.html">https://www.ietf.org/archiv=
e/id/draft-intra-handshake-fail-55.html</a>
        <p></p>
      </div>
    </div>
  </body>
</html>

--------------3S6qIdMu60lbWLDqEHoGjeGf--

--------------ms050601000004070508050504
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgMFADCABgkqhkiG9w0BBwEAAKCC
DlwwggbmMIIEzqADAgECAhAxAnDUNb6bJJr4VtDh4oVJMA0GCSqGSIb3DQEBDAUAMIGIMQsw
CQYDVQQGEwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkx
HjAcBgNVBAoTFVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJT
QSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTAeFw0yMDAyMTgwMDAwMDBaFw0zMzA1MDEyMzU5
NTlaMEYxCzAJBgNVBAYTAk5MMRkwFwYDVQQKExBHRUFOVCBWZXJlbmlnaW5nMRwwGgYDVQQD
ExNHRUFOVCBQZXJzb25hbCBDQSA0MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA
s0riIl4nW+kEWxQENTIgFK600jFAxs1QwB6hRMqvnkphfy2Q3mKbM2otpELKlgE8/3AQPYBo
7p7yeORuPMnAuA+oMGRb2wbeSaLcZbpwXgfCvnKxmq97/kQkOFX706F9O7/h0yehHhDjUdyM
yT0zMs4AMBDRrAFn/b2vR3j0BSYgoQs16oSqadM3p+d0vvH/YrRMtOhkvGpLuzL8m+LTAQWv
QJ92NwCyKiHspoP4mLPJvVpEpDMnpDbRUQdftSpZzVKTNORvPrGPRLnJ0EEVCHR82LL6oz91
5WkrgeCY9ImuulBn4uVsd9ZpubCgM/EXvVBlViKqusChSsZEn7juIsGIiDyaIhhLsd3amm8B
S3bgK6AxdSMROND6hiHT182Lmf8C+gRHxQG9McvG35uUvRu8v7bPZiJRaT7ZC2f50P4lTlnb
LvWpXv5yv7hheO8bMXltiyLweLB+VNvg+GnfL6TW3Aq1yF1yrZAZzR4MbpjTWdEdSLKvz8+0
wCwscQ81nbDOwDt9vyZ+0eJXbRkWZiqScnwAg5/B1NUD4TrYlrI4n6zFp2pyYUOiuzP+as/A
Znz63GvjFK69WODR2W/TK4D7VikEMhg18vhuRf4hxnWZOy0vhfDR/g3aJbdsGac+diahjEwz
yB+UKJOCyzvecG8bZ/u/U8PsEMZg07iIPi8CAwEAAaOCAYswggGHMB8GA1UdIwQYMBaAFFN5
v1qqK0rPVIDh2JvAnfKyA2bLMB0GA1UdDgQWBBRpAKHHIVj44MUbILAK3adRvxPZ5DAOBgNV
HQ8BAf8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHSUEFjAUBggrBgEFBQcDAgYI
KwYBBQUHAwQwOAYDVR0gBDEwLzAtBgRVHSAAMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2Vj
dGlnby5jb20vQ1BTMFAGA1UdHwRJMEcwRaBDoEGGP2h0dHA6Ly9jcmwudXNlcnRydXN0LmNv
bS9VU0VSVHJ1c3RSU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5LmNybDB2BggrBgEFBQcBAQRq
MGgwPwYIKwYBBQUHMAKGM2h0dHA6Ly9jcnQudXNlcnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FB
ZGRUcnVzdENBLmNydDAlBggrBgEFBQcwAYYZaHR0cDovL29jc3AudXNlcnRydXN0LmNvbTAN
BgkqhkiG9w0BAQwFAAOCAgEACgVOew2PHxM5AP1v7GLGw+3tF6rjAcx43D9Hl110Q+BABABg
lkrPkES/VyMZsfuds8fcDGvGE3o5UfjSno4sij0xdKut8zMazv8/4VMKPCA3EUS0tDUoL01u
gDdqwlyXuYizeXyH2ICAQfXMtS+raz7mf741CZvO50OxMUMxqljeRfVPDJQJNHOYi2pxuxgj
KDYx4hdZ9G2o+oLlHhu5+anMDkE8g0tffjRKn8I1D1BmrDdWR/IdbBOj6870abYvqys1qYlP
otv5N5dm+XxQ8vlrvY7+kfQaAYeO3rP1DM8BGdpEqyFVa+I0rpJPhaZkeWW7cImDQFerHW9b
KzBrCC815a3WrEhNpxh72ZJZNs1HYJ+29NTB6uu4NJjaMxpk+g2puNSm4b9uVjBbPO9V6sFS
G+IBqE9ckX/1XjzJtY8Grqoo4SiRb6zcHhp3mxj3oqWi8SKNohAOKnUc7RIP6ss1hqIFyv0x
XZor4N9tnzD0Fo0JDIURjDPEgo5WTdti/MdGTmKFQNqxyZuT9uSI2Xvhz8p+4pCYkiZqpahZ
lHqMFxdw9XRZQgrP+cgtOkWEaiNkRBbvtvLdp7MCL2OsQhQEdEbUvDM9slzZXdI7NjJokVBq
3O4pls3VD2z3L/bHVBe0rBERjyM2C/HSIh84rfmAqBgklzIOqXhd+4RzadUwggduMIIFVqAD
AgECAhA/YCOTOabjcS/HTP8f2MRxMA0GCSqGSIb3DQEBDAUAMEYxCzAJBgNVBAYTAk5MMRkw
FwYDVQQKExBHRUFOVCBWZXJlbmlnaW5nMRwwGgYDVQQDExNHRUFOVCBQZXJzb25hbCBDQSA0
MB4XDTI0MTExOTAwMDAwMFoXDTI2MTExOTIzNTk1OVowgdoxCzAJBgNVBAYTAkRFMRAwDgYD
VQQIEwdTYWNoc2VuMSgwJgYDVQQKEx9UZWNobmlzY2hlIFVuaXZlcnNpdGFldCBEcmVzZGVu
MREwDwYDVQRhEwhHT1ZERStTTjEyMDAGCSqGSIb3DQEJARYjbXVoYW1tYWRfdXNhbWEuc2Fy
ZGFyQHR1LWRyZXNkZW4uZGUxDzANBgNVBAQTBlNhcmRhcjEXMBUGA1UEKhMOTXVoYW1tYWQg
VXNhbWExHjAcBgNVBAMTFU11aGFtbWFkIFVzYW1hIFNhcmRhcjCCAiIwDQYJKoZIhvcNAQEB
BQADggIPADCCAgoCggIBAKhTeUVDqbjfDFmkVrgQMFC3S4O0vjW9zjlrkD8FrZ2ipCLuiNE2
XHibuTw57N2lrcWMRqjw/Tv7WqpasIHjIlvE5SJ+VuOzu5P0xLqfroT4MSlKIq1LyXkL1u09
A9EuCUxhf4Uc3Ir17VYzjS7meqv4+4yoVhnL9zepze8f0FG3EJmGJlBSJ8sD6dVxGQkDLWMf
NNt/I8wkaQSFkzvd+KppPOjc4t4JtQWIHKPMKS3lbXv8RLO1jaPO9Fdfg4D/dq5I8fsnfg6y
gmCL+nTsHWAXqgX8vcDVG5tz5ONzHgODtItrQWO+m4d8W16JWCbMMCFIqscZ5weRfS5dSFZk
sptipqIm5tzUL3y2/VOFCiL/tofo7yA1bHnFXUGm2LkJVNx6pDZFh1G9OYPqmrjjSxL9E/ed
xQ1lIe3GmBJGBUFldlP8STm3WapaatgNcuQ6HXX1HexWF14NBIguNajgOR17JxX0JS4t9o5f
3Po+Nqa/Als1Mm9Q6PACcVRhm7yH4vj3UqGcjAps6YM/HDkNoA2qsHmqZ/ya15eIORADN+ZQ
O7hJYBH5TJprVdGXL7aTLNJh6xEn5V9TFcsT017ocQ5bJteN6caUay/0zPenwtabuSLR6y7e
gmx8gTF4oPDUlgkaNcKAmkyzwM+IzPNIJvyxq/NI1pQRyTGUQJYyExO7AgMBAAGjggHBMIIB
vTAfBgNVHSMEGDAWgBRpAKHHIVj44MUbILAK3adRvxPZ5DAdBgNVHQ4EFgQU4R79RPVSVexS
+el1ZxCchmYs1akwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYI
KwYBBQUHAwQGCCsGAQUFBwMCMFAGA1UdIARJMEcwOgYMKwYBBAGyMQECAQoEMCowKAYIKwYB
BQUHAgEWHGh0dHBzOi8vc2VjdGlnby5jb20vU01JTUVDUFMwCQYHZ4EMAQUDAjBCBgNVHR8E
OzA5MDegNaAzhjFodHRwOi8vR0VBTlQuY3JsLnNlY3RpZ28uY29tL0dFQU5UUGVyc29uYWxD
QTQuY3JsMHgGCCsGAQUFBwEBBGwwajA9BggrBgEFBQcwAoYxaHR0cDovL0dFQU5ULmNydC5z
ZWN0aWdvLmNvbS9HRUFOVFBlcnNvbmFsQ0E0LmNydDApBggrBgEFBQcwAYYdaHR0cDovL0dF
QU5ULm9jc3Auc2VjdGlnby5jb20wLgYDVR0RBCcwJYEjbXVoYW1tYWRfdXNhbWEuc2FyZGFy
QHR1LWRyZXNkZW4uZGUwDQYJKoZIhvcNAQEMBQADggIBAIxymCHDahevSfae44bVKxAKDRLh
ZVraNygdRQ2RQOkz8v8b/cl5yuWR/l3yMpIrwiDWT37UQibNuoPxaZeRBjDh8ItcUP51sOAV
7zd3GwfyUJNYKmgd6LjfE8+mkXrVU2JffVjRUgiyy7eBTzvTz5PFUQh2oqWfTh/Oz3pFXV+/
0K3eP+fNkr0gljmEZi/h0ici5cJ+Q9J/Zx6Vg9ke2qb6PIh+zeb5oL40i7FR875NX/WGKMib
ojTopS5xPbo0KmN64FqgasfJW03t0wyTtcYOap6tw2RcfVpjfsXQqEfjdjyrNHH6l/TDxUoL
cNlu0zkYHMYmJ6MJ6VwaHWB5hou9N0WWrcQotsfkpf7lGZSlum9jG5/uB+d3FLK00QM99XN7
RhLbLOKKuw2Xri3MEcN/LvIRDIHef4uoONAI+4bOW+1wFmGwqpHYxA/JoUXoRjojuAon8lCF
uVf3tFAkQ/V8zuPxCX36gEOsyQuK3IAeS8R8qhV5Cc+dcYDKid61AluluBcUSxfKxmoK19Mm
f39FTD+bJpBCiEAdJuZfP6TD0dtBVcgJ4dBLZ4H13WBeVZRDXcxghYJcNWFHPa/qi20jmuUs
CvcD4z2+LBFnVrwhOeBefYjm6zy7+9IbuomR11B4+AnLkjzTBZxcX17UMWyqVe4hZN2CsVS0
7doWTJJYMYIEWDCCBFQCAQEwWjBGMQswCQYDVQQGEwJOTDEZMBcGA1UEChMQR0VBTlQgVmVy
ZW5pZ2luZzEcMBoGA1UEAxMTR0VBTlQgUGVyc29uYWwgQ0EgNAIQP2Ajkzmm43Evx0z/H9jE
cTANBglghkgBZQMEAgMFAKCCAc8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG
9w0BCQUxDxcNMjYxMDA5MDAzNDI5WjBPBgkqhkiG9w0BCQQxQgRAIxJc0gzw7yAkDJAottHY
hwiVRO72o9zIHBrSTMPQDF4kcYseIOHHTM/Pi8yHk+LkOu66q78Z3cYjx8wj7cInOjBpBgkr
BgEEAYI3EAQxXDBaMEYxCzAJBgNVBAYTAk5MMRkwFwYDVQQKExBHRUFOVCBWZXJlbmlnaW5n
MRwwGgYDVQQDExNHRUFOVCBQZXJzb25hbCBDQSA0AhA/YCOTOabjcS/HTP8f2MRxMGsGCyqG
SIb3DQEJEAILMVygWjBGMQswCQYDVQQGEwJOTDEZMBcGA1UEChMQR0VBTlQgVmVyZW5pZ2lu
ZzEcMBoGA1UEAxMTR0VBTlQgUGVyc29uYWwgQ0EgNAIQP2Ajkzmm43Evx0z/H9jEcTBsBgkq
hkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYI
KoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMA0G
CSqGSIb3DQEBAQUABIICAFioZYwLKgxr8qZ/hCqitSbmjvytVRo4owLFiDJ1g6fcq03xhXXQ
AX1/DEjFbK9iPhHd0KLdVfj15o7vkZhHyTtaKcAoAzcaaR66irSLHcSYG/hYd8cRcx/DsCDn
yWXfygSLBDDEZ5PjT9HczTabUWjXpXCEpLnP7cdhwEiDIS4vCN7bFoNI4NaJjbo/jTi1J5Nf
UgO3PNX8rNFcIdTOnG6w+FKuB3Ic155ncvh1de/PotxNbHMs9OcCeBjqkIBQvlQeuUpcYQs3
2kC7zqwdEDiMEzog7zbeRnaq0GRcxBfsPFZE+uxvMvqn/G8C9C0jWUBagi1u2r8EBp/FbJbX
3TZXhM7FJGjpKGf3IlEmft+5VRQjhibIpqCCG50fCDE9iUu/g/5P288K8DN7luBFAEMZh7+X
MpjkO8D8hj9nIRYeqD4Xk4WSsBLk52eUEehW4TbQpAV79MHrjixilL+6n/BqT7PgkNaygJ/N
Rt0W8JnynmHywuMkc8PiNe5LDT8xVr0hzInnp5pMPZfpGcKj3mbmbRV1Uyjktq/iS2/hhD/c
wt1TSm1c7mYFnERAIWVxWjrN2CuAJZcKzXJyEXUKfGMYb3EKvfIMnnxMhSJlpPh/C2KoQKTx
Be/rTZ7U6OtEPTMTp+Vkz2eman5Q07BTJU5IXf4IUSLEe2NIl/6QELcvAAAAAAAA
--------------ms050601000004070508050504--

