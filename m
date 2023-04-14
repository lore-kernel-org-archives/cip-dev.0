Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E021C77B6E
	for <webhook@archiver.kernel.org>; Fri, 14 Apr 2023 12:59:41 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.86])
 by mx.groups.io with SMTP id smtpd.web10.8373.1681476945846994822
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Apr 2023 05:55:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=T/je73BU;
 spf=pass (domain: siemens.com, ip: 40.107.6.86, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6V68Zj9/v4v0QRtZF/MrcD8Lg/inE82zICFK/u/OV+W8QW3srZHVULrcRwPC5Z0v2/6keB6yRV7g6L9v88D5f0mZolNf0YEaRB3T+Bl2YlJ9oaIbBwJBvA2CPSfdWP874XvM6i0gMa5afYcAndcgr/uRjVRskBNLLeEVcFKFPsdAxlj5EG36uYPKIuPE9uMfLXA2mWxMWweC93Yls/ANVmBItDt2pgkXQ7aysKU3dhvDSiWSWacK9z6L69vgdaqStXJaP+pGLBezbQ5+qx5OA/7BjO0BvU4xDxTk5AcvArPcfou9cfg78mD8tArnIH9o6yz3JHBB5jsWZUHWFmwPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZVf6KfkwsidBCvQdHPVQw1d66jGYnxJvvXet4ejPNk=;
 b=RwJsMAA6FQaCC96qFp861skSvqJSVc0yR85mJLCjChpBJp3DozuGELknC9VtmfIwvg5wq5IlmeTtwjaNgjSeUTSYkdkW09oEqsOZegNLAPqSsNFwDmvwFordsgx0rHst0+IMQxmZb3QcmMVwBjufDHnsTsU6YX859N7CHwgMGG/92yUpSWNMqdKPkrHVSTj4y0xV5piOSBKTd8T4qYLCy4LesVisb9ifvBIjkqaJiP1lHxyywZO02cBvtep5Nb/ky7KXB0Y2BMb+RUaJgqlX+o4/jBY0e7jgDxv3dHzvogEP9zCqzduKZq2Bb0yIQxpUId2dK8HHJlBG5M6K1sEokg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZVf6KfkwsidBCvQdHPVQw1d66jGYnxJvvXet4ejPNk=;
 b=T/je73BUV1L0otBcF10uykiUAzDa0Ax7I6ArUELjO6KHdPnjRkBQw039Rbp+Mv/C079YGFkl/j+lmDhcOZe1PZesUhNIdkton9MYV0vEOiMQXR/2FKyWLSz9RExl9as5BRO6XLuYtCXa7NBFkhHK5nwvvO41en6tAwa+VcbPPUFrO0ZB+aSgcIHh1LbKGSsR/UX2Gpj75/0zaLbCmUZPCMLOPNZdOF3kWQzCZfCyAiNzIFNBgdvAqYBafbWqyXRKcEIV1gq2YowOH1cFaSrMOYBdko1GaHz+EARS+0k/gGLJN/9OGkYkWgX6E+MCoiIl+vLohSg2o8xfmcwwpNNCgg==
Received: from DB8P191CA0007.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::17)
 by AS4PR10MB5766.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.7; Fri, 14 Apr
 2023 12:55:43 +0000
Received: from DB5EUR01FT091.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:130:cafe::63) by DB8P191CA0007.outlook.office365.com
 (2603:10a6:10:130::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.33 via Frontend
 Transport; Fri, 14 Apr 2023 12:55:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 DB5EUR01FT091.mail.protection.outlook.com (10.152.5.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.33 via Frontend Transport; Fri, 14 Apr 2023 12:55:42 +0000
Received: from CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1118.25; Fri, 14 Apr 2023 14:55:41 +0200
Received: from CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) by
 CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 14 Apr 2023 20:55:38 +0800
Received: from CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) by
 CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) with mapi id
 15.01.2507.023; Fri, 14 Apr 2023 20:55:38 +0800
From: "Moessbauer, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
CC: "Schmidt, Adriaan" <adriaan.schmidt@siemens.com>
Subject: Re: [isar-cip-core][PATCH v2] add support to limit resource consumption of squashfs creation
Thread-Topic: [isar-cip-core][PATCH v2] add support to limit resource
 consumption of squashfs creation
Thread-Index: AQHZbrLkuqE09YVNA0mGOy2U6VqLEK8qBNQAgAA4dQA=
Date: Fri, 14 Apr 2023 12:55:38 +0000
Message-ID: <115fb869e0b4e52ec477700057d14555e04eac96.camel@siemens.com>
References: <20230414092408.679342-1-felix.moessbauer@siemens.com>
	 <f9ae5295-5534-1ade-80e8-159f623d5e8d@siemens.com>
In-Reply-To: <f9ae5295-5534-1ade-80e8-159f623d5e8d@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-1 
x-originating-ip: [139.24.236.51]
x-tm-as-product-ver: SMEX-14.0.0.3080-8.6.1018-26498.001
x-tm-as-result: No-10--17.387000-8.000000
x-tmase-matchedrid: G9QKf9eUqNBwWrhivu9rXtplUyIIewbxuV9eQHCYbHq2DJSILb1B3uvW
	kvu/824/5jUYbw1Yp79iqTCaIpgXG+t2gGXLArR6i5zBIT546McRCjNaiW/UUU+0VUW65/MLrXk
	uON8pnlF65yXsx03DxJz+ZUWgONn9eS2H0TaQVSkKz+IDVz2UnoflQr2/kJT/AiwTe0IqjZcVk6
	x93IThSveufQfvx9csYU01lKCooiJbGM5QOQjnIHiF4U1w2AlQvUxpsK1XD0vM0ihsfYPMYfmoZ
	6x4ZgCUnF+Nm+WXvuJ8yt0Pc0hS+7Odh1ib0P7wIwCoQ/wyoCfgtW+yLXzaUspdsi/eZA1jljgw
	/8s6b3cHZBaLwEXlKGlF7OhYLlctbdThjFKJWjDTkirbYb1YYvvrTyS6MtS1RaPXfvn+keq1Tos
	Y7vKtY8dWIKdbPEfdMBRYei8i+TF9LQinZ4QefNZE3xJMmmXc+gtHj7OwNO0RTWyDkald5Q==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--17.387000-8.000000
x-tmase-version: SMEX-14.0.0.3080-8.6.1018-26498.001
x-tm-snts-smtp: 46BBA55B10AB044277511A77039778197968BF8E3914A48960841428920076892000:8
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT091:EE_|AS4PR10MB5766:EE_
X-MS-Office365-Filtering-Correlation-Id: 49af2015-2a19-45a4-b138-08db3ce78e87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9N+KUpq8RooKnMdFH//UzLwUeJkbHoQHyEo/I118V3PukxBPiLhQiNJ+Pvt92zGXnBrz3+kmjfXKP8b0G+TiibXHJwVV78FX7zCIpilPf+M5aAAb7akkg5ZAk3zOZZbSONy0KJhZyvVnH/1+oEYCzW41ud9ho1xlz2DoFAeEkSDzcKPWOKjIMqp/rKE4H+u2szMEkyVYjaiDzakIGnQpqj/i/S3BWDU8LnXj3MN1yP2F8z7lRZWMvonfhid/gD7URec1eFe8QK9PYpm0z3yt4Rh9Dr7bUaSyoZLUXMEj03Fl9yzddmk/XrCy7gYoFtY6faxsKHCoAiSM/WCUWgVtrIVN+lWXqSs4hT5dFlz9N30fuShBIRDDY7Zqs3tpFIB0VCzr7ls8Kyx+gYOxXRQ+AFvpg2N2Omi1+qfk7drdaSY/a58i95Mh9saPFMmn3AbAlU+zDjwwxKQqdzMEOzAL+W4ofqso62alhRgSMn51lwLKt3tLhwlVW8OyORGl1C33H0EXn+rkr8xbSEPnMb4X6zDnGRrnTZ+xoS8X+L4w5bfuo3J2O8/IudDB2thGGqgolAdO4cFX3xP0WBJn8fmwL9uElpdcPBEJaNGIWs7Cn1NuBNQh3a7eSl7Bh8WOyfHa1YnJbJfYpbnGf01859N4Dd/88cLX2bZyAtq8qstCaQLyrol1Fnb1849b+TNnod8c5pSgtnI8mG6lVgSXNjlMBw==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199021)(46966006)(40470700004)(36840700001)(4326008)(356005)(82960400001)(7596003)(7636003)(82740400003)(26005)(53546011)(107886003)(47076005)(83380400001)(336012)(36860700001)(82310400005)(186003)(956004)(2616005)(36756003)(40460700003)(2906002)(8936002)(6636002)(70206006)(70586007)(86362001)(110136005)(478600001)(8676002)(5660300002)(316002)(40480700001)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 12:55:42.8645
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49af2015-2a19-45a4-b138-08db3ce78e87
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT091.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5766
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <F46B81E5D89D4247AA6E06EACDCB8D79@siemens.com>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Apr 2023 12:59:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11223

T24gRnJpLCAyMDIzLTA0LTE0IGF0IDExOjMzICswMjAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAxNC4wNC4yMyAxMToyNCwgRmVsaXggTW9lc3NiYXVlciB3cm90ZToNCj4gPiBUaGlzIHBhdGNo
IG1ha2VzIGl0IHBvc3NpYmxlIHRvIGNvbnRyb2wgdGhlIG51bWJlciBvZiBDUFVzIGFuZCB0aGUN
Cj4gPiBtZW1vcnkgdXNhZ2Ugd2hlbiBnZW5lcmF0aW5nIGEgc3F1YXNoZnMuIFRoZSB2YXJpYWJs
ZSBuYW1lcyB1c2VkDQo+ID4gZm9sbG93IHRoZSBpbWFnZXR5cGUgdmFyaWFibGUgc2NoZW1lLg0K
PiA+IA0KPiA+IEVzcGVjaWFsbHkgd2hlbiBjb21wcmVzc2luZyBhIHNxdWFzaGZzIGludGVybmFs
bHkgd2l0aCBjcHUgYW5kDQo+ID4gbWVtb3J5DQo+ID4gaGVhdnkgY29tcHJlc3NvcnMgbGlrZSB4
eiwgd2UgaW5oZXJpdCB0aGUgaXNzdWVzIHdlIGhhZCB3aXRoIHRoZQ0KPiA+IGltYWdlDQo+ID4g
Y29tcHJlc3Npb24gaW4gdGhlIHBhc3QuIE9uIENJIHN5c3RlbXMsIHdoZXJlIG1hbnkgdGFza3Mg
bWlnaHQgcnVuDQo+ID4gaW4NCj4gPiBwYXJhbGxlbCwgdGhpcyBvZnRlbiBsZWQgdG8gT09NcyBh
bmQgcG9vciBwZXJmb3JtYW5jZS4gQnkgcHJvdmlkaW5nDQo+ID4gdGhlc2Ugb3B0aW9ucyBzaW1p
bGlhciB0byB0aGUgb3RoZXIgaW1hZ2V0eXBlIG9wdGlvbnMsIHdlIGdpdmUgQ0kNCj4gPiBhZG1p
bmlzdHJhdG9ycyBhbiBlYXN5IHdheSB0byBjb250cm9sIHRoZSBtZW1vcnkgY29uc3VtcHRpb24s
DQo+ID4gaW5kZXBlbmRlbnQgb2YgdGhlIG90aGVyIG9wdGlvbnMgcGFzc2VkIHRvIG1rc3F1YXNo
ZnMuDQo+IA0KPiBJZiB0aGlzIGlzIHRhcmdldGluZyBDSSB0dW5pbmdzLCB3ZSBzaG91bGQgYWxz
byBleHBvcnQgdGhlIHJlbGF0ZWQNCj4gdmFyaWFibGVzIHZpYSBrYXMgdG8gYWxsb3cgcGlja3Vw
IGZyb20gdGhlIGVudmlyb25tZW50LCBub3Q/DQoNCldlIGRvbid0IGRvIHRoYXQgZm9yIHRoZSBv
dGhlciB2YXJpYWJsZXMgbGlrZSBYWl9NRU1PUlkgZWl0aGVyLg0KSU1ITyB3ZSBzaG91bGQgYWxz
byBub3QgZG8gdGhpcywgYXMgdXN1YWxseSBubyBmdXJ0aGVyIGN1c3RvbWl6YXRpb25zDQphcmUg
cmVxdWlyZWQuIEJ1dCBpZiB0aGV5IGFyZSByZXF1aXJlZCwgcGVvcGxlIGNhbiBqdXN0IGFkZCB0
aGUgcGFzcy0NCnRocm91Z2ggaW4gdGhlIGthcyBmaWxlIG9uIGEgcGVyIHVzZS1jYXNlIGJhc2lz
IChlLmcuIHdpdGhvdXQgdmFsdWUsIHNvDQp0aGUgY29ycmVzcG9uZGluZyBlbnYgdmFyIGlzIHBp
Y2tlZCB1cCkuDQoNClRoZSBtb3JlIGltcG9ydGFudCB0aGluZyBpcywgdGhhdCB3ZSBwcm92aWRl
IGNsZWFyIGludGVyZmFjZXMuDQpBbmQgZXhhY3RseSB0aGF0IGlzIHdoYXQgdGhpcyBwYXRjaCBk
b2VzLg0KDQpGZWxpeA0KDQo+IA0KPiBKYW4NCj4gDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTog
RmVsaXggTW9lc3NiYXVlciA8ZmVsaXgubW9lc3NiYXVlckBzaWVtZW5zLmNvbT4NCj4gPiAtLS0N
Cj4gPiBDaGFuZ2VzIHNpbmNlIHYxOg0KPiA+IA0KPiA+IC0gYWRkIHJlYXNvbmluZyBpbiB0aGUg
Y29tbWl0IG1lc3NhZ2UNCj4gPiAtIG5vIGZ1bmN0aW9uYWwgY2hhbmdlcw0KPiA+IA0KPiA+IMKg
Y2xhc3Nlcy9zcXVhc2hmcy5iYmNsYXNzIHwgOSArKysrKysrKy0NCj4gPiDCoDEgZmlsZSBjaGFu
Z2VkLCA4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0
IGEvY2xhc3Nlcy9zcXVhc2hmcy5iYmNsYXNzIGIvY2xhc3Nlcy9zcXVhc2hmcy5iYmNsYXNzDQo+
ID4gaW5kZXggYTA2YzUwMS4uYjE0NzY4YyAxMDA2NDQNCj4gPiAtLS0gYS9jbGFzc2VzL3NxdWFz
aGZzLmJiY2xhc3MNCj4gPiArKysgYi9jbGFzc2VzL3NxdWFzaGZzLmJiY2xhc3MNCj4gPiBAQCAt
MTUsNiArMTUsMTMgQEAgU1FVQVNIRlNfRVhDTFVERV9ESVJTID89ICIiDQo+ID4gwqBTUVVBU0hG
U19DT05URU5UID89ICIke1BQX1JPT1RGU30iDQo+ID4gwqBTUVVBU0hGU19DUkVBVElPTl9BUkdT
ID89ICIiDQo+ID4gwqANCj4gPiArU1FVQVNIRlNfVEhSRUFEUyA/PSAiJHtAb2UudXRpbHMuY3B1
X2NvdW50KGF0X2xlYXN0PTIpfSINCj4gPiArU1FVQVNIRlNfVEhSRUFEU1t2YXJkZXB2YWx1ZV0g
PSAiMSINCj4gPiArIyBkZWZhdWx0IGFjY29yZGluZyB0byBta3NxdWFzZnMgZG9jcw0KPiA+ICtT
UVVBU0hGU19NRU1MSU1JVCA/PSAiNzk4Mk0iDQo+ID4gK1NRVUFTSEZTX0RFRkFVTFRTID89ICIt
bWVtICR7U1FVQVNIRlNfTUVNTElNSVR9IC1wcm9jZXNzb3JzDQo+ID4gJHtTUVVBU0hGU19USFJF
QURTfSINCj4gPiArU1FVQVNIRlNfREVGQVVMVFNbdmFyZGVwc2V4Y2x1ZGVdICs9ICJTUVVBU0hG
U19NRU1MSU1JVA0KPiA+IFNRVUFTSEZTX1RIUkVBRFMiDQo+ID4gKw0KPiA+IMKgcHl0aG9uIF9f
YW5vbnltb3VzKCkgew0KPiA+IMKgwqDCoMKgIGV4Y2x1ZGVfZGlyZWN0b3JpZXMgPQ0KPiA+IGQu
Z2V0VmFyKCdTUVVBU0hGU19FWENMVURFX0RJUlMnKS5zcGxpdCgpDQo+ID4gwqDCoMKgwqAgaWYg
bGVuKGV4Y2x1ZGVfZGlyZWN0b3JpZXMpID09IDA6DQo+ID4gQEAgLTMxLDUgKzM4LDUgQEAgSU1B
R0VfQ01EOnNxdWFzaGZzW2RlcGVuZHNdID0NCj4gPiAiJHtQTn06ZG9fdHJhbnNmb3JtX3RlbXBs
YXRlIg0KPiA+IMKgSU1BR0VfQ01EOnNxdWFzaGZzKCkgew0KPiA+IMKgwqDCoMKgICR7U1VET19D
SFJPT1R9IC9iaW4vbWtzcXVhc2hmcyBcDQo+ID4gwqDCoMKgwqDCoMKgwqDCoCAnJHtTUVVBU0hG
U19DT05URU5UfScgJyR7SU1BR0VfRklMRV9DSFJPT1R9JyBcDQo+ID4gLcKgwqDCoMKgwqDCoMKg
IC1ub2FwcGVuZCAke1NRVUFTSEZTX0NSRUFUSU9OX0FSR1N9DQo+ID4gK8KgwqDCoMKgwqDCoMKg
IC1ub2FwcGVuZCAke1NRVUFTSEZTX0RFRkFVTFRTfSAke1NRVUFTSEZTX0NSRUFUSU9OX0FSR1N9
DQo+ID4gwqB9DQo+IA0KDQo=

