Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3251CD80BA
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 12:04:27 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.52])
 by mx.groups.io with SMTP id smtpd.web10.82028.1696903571804080652
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Oct 2023 19:06:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=wQqiIIRc;
 spf=pass (domain: siemens.com, ip: 40.107.8.52, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlVzs6xWqAIRO0njKgoHVHniUgt4tyPRzECx3JJds2zGAOsO+kAt4v5p706yclZ9Ql0W8cu8UEzvNPpS7XRvtfFn8/kwkoUqlEWMKlRoZuYlsWDNOvg/Nf+Lemf4G2xeXQZWja2faKdpWcWq9fOY4r6P44em2VidqplPW5fC2kyjbZKgtfYv1rXawVmeS/33gakWY0Xn4EhcgLQcGYfJs3PTCVr71jOHBYQN8VrL0QKbSSPyzy9wUlams5n6vO85aaFLmuBTRSrPODF+mv+UnArsSmmoD3lit142ZNlLjMB7vnuhsKX76st3cXPfEwtTcfbs+ppZDziufs4wTv4g2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yUnUD7KVXq4EURjw4AU7T1ZLkvHfwdsxhoX52tarrw=;
 b=UQASkW3d5KAoZduK8XmZzU3gg/zO/f4p0W5tI/AVoDflZviEg9T8xoUpxNvlFonJ5dg1aVcFtJfqEQP/ZztS49dpJPQX88K5cQ6vEA9R1F28Sw9MrnvFcF4/c3icexNf2XCsw4yCCG+iwAJxzJC31282J3vPGkPGomSqEPAtb6eN8HR9u5ylXuynnMzwm6jHGI6p0umkYNeCMVW/VkAkYAwGRzuhXw88meITU9BESKPLJ3USo9XsVCZhP0Yp10EZUkGRQMGGtkqE5g/J9U0R8KPKpGFbynfDKlETdR5iwcXYgeRSbzMtDgS1LZ/SDNtN+Aj+O69ppljw3ttpAEHuZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yUnUD7KVXq4EURjw4AU7T1ZLkvHfwdsxhoX52tarrw=;
 b=wQqiIIRcQXCkLqCQgH9yE5tJ0+1QLB6GVISQ+MoPjcdby7zuFOjvMk03dlPFwt9Ztpt+AY1GUbKNlzKC4/nxTEyMw3Lkz/aJ472ks79GU0ct3DbzhIQp6EaA4fg/qhT+p5b+dDxQ2y/xUVWpMirIUZWgKWO4YQOlfT48+6LCvR9eW+kQ4XzBGxNcJx6jUtA7QEt1g5a2DDD9pNMuuoOah30K1hRmDmNI2G1kCfS+24f3Nfii+qW5Zmbf8e8nkBKgz4byAwx6/49rqX25+XsgBxdW4sffwVMae3clPNHH2B4dmecxJ5J5KA2BpYf8E1Lx1Ndirwd4o6Of9rz7gJrZaw==
Received: from AS8P250CA0008.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:330::13)
 by AM7PR10MB3288.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 02:06:08 +0000
Received: from AM3PEPF00009BA1.eurprd04.prod.outlook.com
 (2603:10a6:20b:330:cafe::9d) by AS8P250CA0008.outlook.office365.com
 (2603:10a6:20b:330::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37 via Frontend
 Transport; Tue, 10 Oct 2023 02:06:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 AM3PEPF00009BA1.mail.protection.outlook.com (10.167.16.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 02:06:07 +0000
Received: from CNPEK01M06MSX.ad011.siemens.net (139.24.237.223) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.23; Tue, 10 Oct 2023 04:06:06 +0200
Received: from CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) by
 CNPEK01M06MSX.ad011.siemens.net (139.24.237.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 10:06:04 +0800
Received: from CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) by
 CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) with mapi id
 15.01.2507.032; Tue, 10 Oct 2023 10:06:04 +0800
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
CC: "Gylstorff, Quirin" <quirin.gylstorff@siemens.com>
Subject: Re: [isar-cip-core][PATCH v3 2/2] update ISAR to latest version on master branch
Thread-Topic: [isar-cip-core][PATCH v3 2/2] update ISAR to latest version on
 master branch
Thread-Index: AQHZ+qdVsRtvSDF/0kCRRp63lR8mtLBA2IkAgADosIA=
Date: Tue, 10 Oct 2023 02:06:04 +0000
Message-ID: <36519c4c5fc8ae484c9499ac9af3de1bddfaa856.camel@siemens.com>
References: <20231009115344.746642-1-felix.moessbauer@siemens.com>
	 <20231009115344.746642-3-felix.moessbauer@siemens.com>
	 <7b17dabb-9bec-40ab-90a2-8771ffe20cd8@siemens.com>
In-Reply-To: <7b17dabb-9bec-40ab-90a2-8771ffe20cd8@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
x-originating-ip: [139.24.247.175]
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA1:EE_|AM7PR10MB3288:EE_
X-MS-Office365-Filtering-Correlation-Id: 495a875a-8605-4156-96c8-08dbc9357769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	BFQbl1v+dOoPkJOUzHvbuN2eEtmxbpA11Zhlw+eAjMBGBVhuSIQKSxiX2iIwgOtlJBM/KF72eBqh6qPVhxisIuI5/Cb33EaL9oAZsnghcycBh6/ECZXFHZsEw4St48zqxSA62hSk64DOYKRhbJR6jzSvij1UDNVdc/I/bNof3haze6Y4wDIIHCCwwYsBTKnrQSTJuHaku9b58hyv1T+XitXGPmvEof0agNNOD0UV0VU+qeQZS6hyynStiUc9q4LiFjk30OZL9QVgN5yieXNexvdHpy2YOi3R+6zvku8lqlUWKXCNcvTjtXX7z7SXEmyXMGIG4p0Oy3WtuUgx14BVUiqqoUJv2m3lezGlSZJN/PMMZ+6x8Lz1fQiksoLf6LGWKPQObJU5OdpImBuc2HXRMAjP7AWxqWhBe7qdMEC08ewNMi/sYp0A4HivnTI0TobDmBgGXkAvxo9eUyXZYz2qirG8We8VEBqRI72hpY915WFuJTgljS9c1qJQrsPR9iAD9T8sz+TNfEcJcAImWQD343fnulvJFfGdNGOSu5MmUiX01CNU/VDa9veq+IQHy3t4aHIsTvR+s3VBdfuQcRfQfxLBeA0F7GhPFRneUDBZ8UnvLKBC+e7s0mK8WuZ2oRs/y+Dunexj5ANnaUlpciQulTcx8hVugvveltSBFLfFbSL6JSw7VkqOA8bUsZjYJVecdLr8Dr/WWieIduyI5yZlJLGTDkYywN/vzWs6/+NMj2NLQGr4xgiz32f8eo0zPnwD
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(82310400011)(451199024)(186009)(1800799009)(64100799003)(40470700004)(36840700001)(46966006)(36756003)(40480700001)(40460700003)(966005)(53546011)(83380400001)(336012)(26005)(107886003)(2616005)(956004)(41300700001)(4326008)(478600001)(8936002)(8676002)(5660300002)(110136005)(2906002)(15650500001)(6636002)(316002)(70586007)(70206006)(47076005)(82740400003)(82960400001)(81166007)(356005)(86362001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 02:06:07.6290
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 495a875a-8605-4156-96c8-08dbc9357769
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM3PEPF00009BA1.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3288
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3C57AF5EED6FF499BEB45D23F838360@siemens.com>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Oct 2023 12:04:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13363

T24gTW9uLCAyMDIzLTEwLTA5IGF0IDE0OjEzICswMjAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAwOS4xMC4yMyAxMzo1MywgRmVsaXggTW9lc3NiYXVlciB3cm90ZToNCj4gPiBUaGlzIGluY2x1
ZGVzIHRoZSBmb2xsb3dpbmcgY2hhbmdlczoNCj4gPiANCj4gPiAtIG1ha2UgZGVwbG95LW92bWYg
Y29tcGF0aWJsZSB3aXRoIHNjaHJvb3QgaW1hZ2luZw0KPiA+IC0gbWFrZSBzd3VwZGF0ZSBjbGFz
cyBjb21wYXRpYmxlIHdpdGggc2Nocm9vdCBpbWFnaW5nDQo+ID4gLSBhdm9pZCB1c2Ugb2Ygc3Vk
byB3aGVuIGNyZWF0aW5nIHNxdWFzaGZzDQo+IA0KPiBTZWVtcyB0aGUgbGFzdCBjaGFuZ2UgZGlk
bid0IG1ha2UgaXQgaW50byB0aGlzIHBhdGNoLg0KDQpBY3R1YWxseSB0aGUgbGFzdCBjaGFuZ2Ug
bmVlZGVkIHRvIGJlIHJldmVydGVkIGFzIHRoaXMgbGVkIHRvIHRoZQ0KcGVybWlzc2lvbiBlcnJv
ciB3aGVuIGNyZWF0aW5nIHRoZSBzcXVhc2hmcy4gSSBqdXN0IGZvcmdvdCB0byB1cGRhdGUNCnRo
ZSBjb21taXQgbWVzc2FnZS4gRmVlbCBmcmVlIHRvIGp1c3QgcmVtb3ZlIHRoZSAiYXZvaWQgdXNl
IG9mIHN1ZG8NCndoZW4gY3JlYXRpbmcgc3F1YXNoZnMiIGZyb20gdGhlIG1lc3NhZ2Ugd2hlbiBh
cHBseWluZyB0aGUgcGF0Y2guDQoNCkZlbGl4DQoNCj4gDQo+IEphbg0KPiANCj4gPiANCj4gPiBT
aWduZWQtb2ZmLWJ5OiBGZWxpeCBNb2Vzc2JhdWVyIDxmZWxpeC5tb2Vzc2JhdWVyQHNpZW1lbnMu
Y29tPg0KPiA+IC0tLQ0KPiA+IMKgY2xhc3Nlcy9zd3VwZGF0ZS5iYmNsYXNzwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8wqAgNSArKystLQ0KPiA+IMKga2FzLWNpcC55bWzCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDIgKy0NCj4gPiDCoHJlY2lwZXMt
Y29yZS9pbWFnZXMvZGVwbG95LW92bWYuaW5jIHwgMTAgKysrKysrLS0tLQ0KPiA+IMKgMyBmaWxl
cyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRp
ZmYgLS1naXQgYS9jbGFzc2VzL3N3dXBkYXRlLmJiY2xhc3MgYi9jbGFzc2VzL3N3dXBkYXRlLmJi
Y2xhc3MNCj4gPiBpbmRleCBhZWRhZjAyLi41NWRhZDMyIDEwMDY0NA0KPiA+IC0tLSBhL2NsYXNz
ZXMvc3d1cGRhdGUuYmJjbGFzcw0KPiA+ICsrKyBiL2NsYXNzZXMvc3d1cGRhdGUuYmJjbGFzcw0K
PiA+IEBAIC0xMDYsNyArMTA2LDcgQEAgSU1BR0VfQ01EOnN3dSgpIHsNCj4gPiDCoMKgwqDCoCAj
IFByZXBhcmUgZm9yIHNpZ25pbmcNCj4gPiDCoMKgwqDCoCBleHBvcnQgc2lnbj0nJHtAJ3gnIGlm
DQo+ID4gYmIudXRpbHMudG9fYm9vbGVhbihkLmdldFZhcignU1dVX1NJR05FRCcpKSBlbHNlICcn
fScNCj4gPiDCoA0KPiA+IC3CoMKgwqAgc3VkbyAtRSBjaHJvb3QgJHtCVUlMRENIUk9PVF9ESVJ9
IHNoIC1jICcgXA0KPiA+ICvCoMKgwqAgaW1hZ2VyX3J1biAtcCAtZCAke1BQX1dPUkt9IDw8J0VP
SU1BR0VSJw0KPiA+IMKgwqDCoMKgwqDCoMKgwqAgIyBGaWxsIGluIGZpbGUgY2hlY2sgc3Vtcw0K
PiA+IMKgwqDCoMKgwqDCoMKgwqAgZm9yIGZpbGUgaW4gJHtTV1VfQURESVRJT05BTF9GSUxFU307
IGRvDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNlZCAtaSAiczokZmlsZS1zaGEyNTY6
JChzaGEyNTZzdW0NCj4gPiAiJHtQUF9XT1JLfS9zd3UvIiRmaWxlIHwgY3V0IC1mIDEgLWQgIiAi
KTpnIiBcDQo+ID4gQEAgLTEzOCw3ICsxMzgsOCBAQCBJTUFHRV9DTUQ6c3d1KCkgew0KPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZpDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZWNobyAiJGZpbGUuJHtTV1VfU0lHTkFUVVJFX0VYVH0iDQo+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBmaQ0KPiA+IC3CoMKgwqDCoMKgwqDCoCBkb25lIHwgY3BpbyAt
b3ZMIC0tcmVwcm9kdWNpYmxlIC1IIGNyYyA+DQo+ID4gIiR7U1dVX0JVSUxEQ0hST09UX0lNQUdF
X0ZJTEV9IicNCj4gPiArwqDCoMKgwqDCoMKgwqAgZG9uZSB8IGNwaW8gLW92TCAtLXJlcHJvZHVj
aWJsZSAtSCBjcmMgPg0KPiA+ICIke1NXVV9CVUlMRENIUk9PVF9JTUFHRV9GSUxFfSINCj4gPiAr
RU9JTUFHRVINCj4gPiDCoH0NCj4gPiDCoA0KPiA+IMKgcHl0aG9uIGRvX2NoZWNrX3N3dV9wYXJ0
aXRpb25fdXVpZHMoKSB7DQo+ID4gZGlmZiAtLWdpdCBhL2thcy1jaXAueW1sIGIva2FzLWNpcC55
bWwNCj4gPiBpbmRleCBjMzI5MjQ4Li44NGI3NDQxIDEwMDY0NA0KPiA+IC0tLSBhL2thcy1jaXAu
eW1sDQo+ID4gKysrIGIva2FzLWNpcC55bWwNCj4gPiBAQCAtMjIsNyArMjIsNyBAQCByZXBvczoN
Cj4gPiDCoA0KPiA+IMKgwqAgaXNhcjoNCj4gPiDCoMKgwqDCoCB1cmw6IGh0dHBzOi8vZ2l0aHVi
LmNvbS9pbGJlcnMvaXNhci5naXQNCj4gPiAtwqDCoMKgIGNvbW1pdDogYmY5YzlmZGQ5OWJmMjZk
Y2EyNWZkZjllNjNiN2ViNWIwNTNkOTYyZg0KPiA+ICvCoMKgwqAgY29tbWl0OiBkZmY4YWQ1MDRi
NTRhNGUyOTJhMWI5ODZjZGM3NGViYzllNmUxNzdhDQo+ID4gwqDCoMKgwqAgbGF5ZXJzOg0KPiA+
IMKgwqDCoMKgwqDCoCBtZXRhOg0KPiA+IMKgDQo+ID4gZGlmZiAtLWdpdCBhL3JlY2lwZXMtY29y
ZS9pbWFnZXMvZGVwbG95LW92bWYuaW5jIGIvcmVjaXBlcy0NCj4gPiBjb3JlL2ltYWdlcy9kZXBs
b3ktb3ZtZi5pbmMNCj4gPiBpbmRleCAwZWM4NzYyLi5kMmI4YTI3IDEwMDY0NA0KPiA+IC0tLSBh
L3JlY2lwZXMtY29yZS9pbWFnZXMvZGVwbG95LW92bWYuaW5jDQo+ID4gKysrIGIvcmVjaXBlcy1j
b3JlL2ltYWdlcy9kZXBsb3ktb3ZtZi5pbmMNCj4gPiBAQCAtMTEsMTEgKzExLDEzIEBADQo+ID4g
wqAjIFRoaXMgcmVjaXBlIGRlcGxveXMgdGhlIE9WTUYgYmluYXJpZXMgdG8gcnVuIHRoZSBpbWFn
ZSBpbiBRRU1VDQo+ID4gwqAjIE5vdGU6IHg4NiBvbmx5DQo+ID4gwqANCj4gPiAtSU1BR0VSX0lO
U1RBTEwgKz0gIm92bWYiDQo+ID4gK0lOU1RBTExfZGVwbG95X292bWZfYmluYXJpZXMgKz0gIm92
bWYiDQo+ID4gwqANCj4gPiArZG9fZGVwbG95X292bWZfYmluYXJpZXNbbmV0d29ya10gKz0gIiR7
VEFTS19VU0VfU1VET30iDQo+ID4gwqBkb19kZXBsb3lfb3ZtZl9iaW5hcmllc1tjbGVhbmRpcnNd
ICs9ICIke0RFUExPWV9ESVJfSU1BR0V9L09WTUYiDQo+ID4gK2RvX2RlcGxveV9vdm1mX2JpbmFy
aWVzW2RlcGVuZHNdICs9ICIke1NDSFJPT1RfREVQfSINCj4gPiDCoGRvX2RlcGxveV9vdm1mX2Jp
bmFyaWVzKCkgew0KPiA+IC3CoMKgwqAgY3AgLXYgJHtCVUlMRENIUk9PVF9ESVJ9L3Vzci9zaGFy
ZS9PVk1GLyouZmQNCj4gPiAke0RFUExPWV9ESVJfSU1BR0V9L09WTUYNCj4gPiArwqDCoMKgIGlt
YWdlcl9ydW4gLXAgLWQgJHtQUF9XT1JLfSAtLSBcDQo+ID4gK8KgwqDCoMKgwqDCoMKgIC9iaW4v
YmFzaCAtYyAiY3AgLXYgL3Vzci9zaGFyZS9PVk1GLyouZmQNCj4gPiAke1BQX0RFUExPWX0vT1ZN
Ri8iDQo+ID4gwqB9DQo+ID4gLQ0KPiA+IC1hZGR0YXNrIGRlcGxveV9vdm1mX2JpbmFyaWVzIGFm
dGVyIGRvX2luc3RhbGxfaW1hZ2VyX2RlcHMgYmVmb3JlDQo+ID4gZG9faW1hZ2UNCj4gPiArYWRk
dGFzayBkZXBsb3lfb3ZtZl9iaW5hcmllcyBhZnRlciBkb19yb290ZnNfaW5zdGFsbCBiZWZvcmUN
Cj4gPiBkb19pbWFnZQ0KPiANCg0K

