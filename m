Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6EBC4167B
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 05:24:14 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.47])
 by mx.groups.io with SMTP id smtpd.web10.77352.1701926592418899587
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Dec 2023 21:23:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=lYayQ7uy;
 spf=pass (domain: siemens.com, ip: 40.107.15.47, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCzcc7u0vlPPjsa17cL4u+QfUGQOX/tXua44XVrVJ8AxQj088k6YWk2k49En7B5QNuM1tMNIh7Vk7L6yVy3tHJKpIF1m1OhGRVxPczZNT63Dv4IQXiaS5bOsH+9HkhJWRIbssK0qCo/xvcF2O+6jvvAdFb9Trk5YeDwZdM8O20Y4T1fzyRrOtLrXrRtkaI25W1I3XkxbL0BUgZ/boZbkCuXK04LsRfCFwGLQ+wxqb+FOkgJvy4Pw/ldnIziaUJPVSQQsCgSPi6aJKl1PQRYvRLwrXD6P1psyx3JH4WDdHOdJ2qhVDuD6uvwHu+cYXjiMkZUZn4p5JDpkqqWcDxCotw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uusM8BUSzKaLtWPn3dNJiJqmxblQKuEjl5u2oDL0Kk=;
 b=inWeZ8knXhMg1tQ5xoQYwWc7i0BgjFXoqLhxrMqkv57xjiFdwtTSZINB1wgwPuDJuen69qhrQIOb906eP36qKyJ07b0bKGM5OfB8uIuozde+K1oSSVYmmIlUH5Q35R9FEAIKxnmxMvt0DVwTlegvbrU278r3WaXKXh5pPyR5nzYGbWmbLVf3C312gRh5LA3hn3Tm6OV53x5J/KSpzlnLKKgCvXssgTxp4H+ctwQjeq74NwHmnLHq2mbUoQsidjCW90wpDEG8GOMcb1pglm/s751b6Ibh0D6nBwWXfYO0moROyntyuB4Y8MS3eVw23O/k/YmD9VnzHH9aa+dyogN0Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=siemens.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uusM8BUSzKaLtWPn3dNJiJqmxblQKuEjl5u2oDL0Kk=;
 b=lYayQ7uyCfM8uPv1KctstLqczFK5HYeyT7x6vbrNLQc1xrcuxaS/DnkZREx1rDClqHEyrZv32fpIZHNu/7z79CMgp2oQKu24ZYzmCKQKOrrP51shgqvMjBW9XPnQjy7zp9/4N24G2mGsYJIheOhjLv+vDY80SHFCJ2+y1IBHy6ZS4XXaAbwm5t9pUoyilZEqeK60CIm1VcjZn6R7UWKYaRLj7fRzFtme6vWq6ybVIqzbQF05+YTXHt2Y6qgZvUTEA+6pZgR95kcOVT+wiV35FkZhcyZ1qFud78VuQUITEuJUFamOTxNY0xhQr5T9S0LiJIg65xM5hddlgHe6XZyGEQ==
Received: from GVX0EPF000013D5.SWEP280.PROD.OUTLOOK.COM (2603:10a6:144:1::d)
 by DU0PR10MB6755.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:473::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 05:23:09 +0000
Received: from HE1EUR01FT094.eop-EUR01.prod.protection.outlook.com
 (2a01:111:f400:7e1f::205) by GVX0EPF000013D5.outlook.office365.com
 (2603:1026:900:2::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Thu, 7 Dec 2023 05:23:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=E
Received: from hybrid.siemens.com (194.138.21.75) by
 HE1EUR01FT094.mail.protection.outlook.com (10.152.0.253) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.22 via Frontend Transport; Thu, 7 Dec 2023 05:23:08 +0000
Received: from CNPEK01M09MSX.ad011.siemens.net (139.24.237.227) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 7 Dec 2023 06:23:04 +0100
Received: from CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) by
 CNPEK01M09MSX.ad011.siemens.net (139.24.237.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Dec 2023 13:23:02 +0800
Received: from CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) by
 CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) with mapi id
 15.01.2507.035; Thu, 7 Dec 2023 13:23:02 +0800
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"Gylstorff, Quirin" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [cip-dev][isar-cip-core][RFC 0/2] Add Bootloader to Update binary
Thread-Topic: [cip-dev][isar-cip-core][RFC 0/2] Add Bootloader to Update
 binary
Thread-Index: AQHaKFF4d2lOAEPYL0adEdaYFomZi7CcbJmAgABXjIA=
Date: Thu, 7 Dec 2023 05:23:02 +0000
Message-ID: <e3bee025100366b12334ac2d707456d871027c12.camel@siemens.com>
References: <20231206143528.1900797-1-Quirin.Gylstorff@siemens.com>
	 <2be59100-035e-4008-9b41-a7758f811b0b@siemens.com>
In-Reply-To: <2be59100-035e-4008-9b41-a7758f811b0b@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
x-originating-ip: [139.24.247.31]
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT094:EE_|DU0PR10MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b7f8874-b019-467b-6bfc-08dbf6e4992c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	FgN/SfttJt/BBJ+Wmb1Dj8Ukt3WMgIW/bP2W26H8d68tzINMh+XWHU3oddOk0uwY7/mIzsf9S7bcLpMZ3ZtLPDQ4VtkmWJNuiNgUAkPqpAfXZo8rijF4zzk2qN5ITArEQLOHe7Zr4gMHfuaeDjL7/py+CSSmgAcB7Wabhbhrf2KcFkyCF5BhGiPe5ITe5atIk+x0yxEJEDiBMs3yTAXdvHDY2xK1LqUW7+b+DjoLBiNdl/XgbNk3e+EUbNbYZIz78N1HnYWIF7ElD7tsB94kMoTwP2EM4JjXXsFpeWgUcCM6bVCRoGnW6a25X/7WE5NL9cL8odeWSG3HUAmNJxzDk4Bv7xDrdavGhG63hCc1IR2k6/Hr4no3uPed4iSnjYf1/TEVV+f+kvPWLqlUPCY26o2XkvJWoJlyQl94xiFaf9OQ+6t8wqvOZWkq4L3Ju/b2E9ELuulASBALC9ov1ZkoueiwIFl57DpdyugbDilfS9ACwMZ+kAoSrhG51pn8QWxdUr2McPQ2jdY7HaxGqTj1morit8L/Z97WaXDhcEt3MfarRcq6a6SYVsri1NowL33LXv2/CcQMSearrK+BuU3t2ygMGWqJi8lf7Ch/Xu5xWy1KXaPA8u5URXrsrVy2w6kvFfZzJ0cSEdMwTQPyKQNBFoDnQl4TcIT9ZROjxx5zpD0eGTGgOaLkrczrdZjMoAJPPd4jEUVnJNMjwTdGtQ312Qk3DNkDUPCzkHrftvurcbk9kwAcaMI6Co6VD+aFRhxB77q6DuZhR+bmKiUW5W5LCQ==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(47076005)(82740400003)(82960400001)(40460700003)(36860700001)(83380400001)(41300700001)(36756003)(26005)(336012)(8676002)(110136005)(8936002)(86362001)(6636002)(70586007)(70206006)(478600001)(316002)(2906002)(5660300002)(15650500001)(53546011)(956004)(2616005)(81166007)(356005)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 05:23:08.5077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b7f8874-b019-467b-6bfc-08dbf6e4992c
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT094.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6755
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F35BCDE16CF8F4A93685FF7AA13399B@siemens.com>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 05:24:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13805

T24gVGh1LCAyMDIzLTEyLTA3IGF0IDA5OjA5ICswOTAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAwNi4xMi4yMyAyMjozMywgUXVpcmluIEd5bHN0b3JmZiB3cm90ZToNCj4gPiBGcm9tOiBRdWly
aW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29tPg0KPiA+IA0KPiA+IFRo
aXMgc2VyaWVzIGFkZHMgdGhlLCBwb3NzaWJsZSBzaWduZWQsIGVmaWJvb3RndWFyZCBiaW5hcmll
cyB0byB0aGUNCj4gPiBkZXBsb3kgZGlyDQo+ID4gYW5kIGFkZHMgdGhlbSB0byBzd3UgZmlsZSBh
bmQgc3ctZGVzY3JpcHRpb24gdG8gdXBkYXRlIHRoZQ0KPiA+IGJvb3Rsb2FkZXIuDQo+ID4gDQo+
ID4gVGhlIG5ldyBlbnRyeSBjb250YWlucyBmb2xsb3dpbmcgaW5mb3JtYXRpb24uDQo+ID4gwqDC
oMKgIHsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZpbGVuYW1lID0gImJvb3Qke1NXVV9F
RklfQVJDSH0uZWZpIg0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGF0aCA9ICJFRkkvQk9P
VC9ib290JHtTV1VfRUZJX0FSQ0h9LmVmaSI7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBk
ZXZpY2UgPSAiL2Rldi9kaXNrL2J5LXV1aWQvNDMyMS1EQ0JBIjsNCj4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGZpbGVzeXN0ZW0gPSAidmZhdCI7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBzaGEyNTYgPSAiYm9vdCR7U1dVX0VGSV9BUkNIfS5lZmktc2hhMjU2IjsNCj4gPiDCoMKgwqAg
fSk7DQo+ID4gDQo+ID4gU2hvdWxkIHdlIGFsd2F5cyB1cGRhdGUgdGhlIGJvb3Rsb2FkZXIgb3Ig
c2hvdWxkIHRoaXMgYmUgYSBvcHRpb25hbA0KPiA+IGFkZGl0aW9uIHRvIHRoZSBzd3U/DQo+ID4g
DQo+IA0KPiBUaGlzIHNob3VsZCBub3QgYmUgdGhlIGRlZmF1bHQgYXMgdGhlIEVGSSBCb290IEd1
YXJkIGlzIGEgc2luZ2xlDQo+IHBvaW50DQo+IG9mIGZhaWx1cmUuIFVwZGF0aW5nIGl0IHNob3Vs
ZCBvbmx5IGV2ZXIgYmUgY29uc2lkZXJlZCBpZiB0aGUNCj4gY29uc2VxdWVuY2VzIG9mIG5vdCBk
b2luZyB0aGF0IHdvdWxkIGJlIHdvcnNlIHRoYW4gdGhlIHJpc2sgb2YNCj4gbGVhdmluZw0KPiBk
ZXZpY2VzIGJyaWNrZWQgYmVoaW5kLg0KDQpZZXMsIHRoaXMgZmVhdHVyZSBzaG91bGQgYmUgY29u
ZGl0aW9uYWwuIE5vcm1hbGx5IHlvdSBkb24ndCB3YW50IHRvDQp1cGRhdGUsIGJ1dCB0aGVyZSBh
cmUgc29tZSBjYXNlcyB3aGVyZSB1cGRhdGVzIGFyZSBuZWVkZWQuDQoNCkhvdyBhYm91dCBhIHZh
cmlhYmxlIFNXVV9VUERBVEVfRUJHPw0KDQpGZWxpeA0KDQo+IA0KPiBKYW4NCj4gDQoNCg==

