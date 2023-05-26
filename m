Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A974C77B7A
	for <webhook@archiver.kernel.org>; Fri, 26 May 2023 16:33:28 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.89])
 by mx.groups.io with SMTP id smtpd.web11.2577.1685082963776751065
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 May 2023 23:36:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=VWjcrDHG;
 spf=pass (domain: siemens.com, ip: 40.107.8.89, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pev7yPG+5Z/YnWbeUpUO5FX17Zw3JgRvDu5lOCiU8lDpuKX+RRTGq85YW5hy9VoV1hsKPEOyJlGYcjjjiVshdNvpNbuaChm7uc3XaxPXbKg/t3ZUFjbjJNRFIqR+tgCOMEN4h6cXDrsFYQwlayqq/E/WJ8s7c1nmHX6gkewocCUx4KEUstTVRdIzLW8gPAS10JEghR+537og2KFTAzLDg/+B2s/HSJdOvNcncJ6jTWVzgPBcf03e+p/NoCbD3rm1S8sKsdM9vpFENUe4qUIA13OgZYiW8ZKWF60rqA3XhWPeIS0xzH05JuxlpSzoCs+isep3Rb1f8Mo5z1pC3Q1R+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zi8MmmC+7P1cIYLyq3X9W1q2I0g3Qj/SN6QnL9GuDRA=;
 b=USmlV6Cgv6r5ZESebIvQuwPjmNBFvkY50Kl2a1Q7jpZAxpw2sADD2oh4dCMdx0+IkPpz/ztf0f2j75er45YE220qAGFLwk9wNKDflxnE0cn6KhWM1Ol8QFtVGbCCxzBbF6CYejWAasn3eg3EqyegHN6lvMnUejKcswlaum4S1yVhft8Z/gZREr6CdjVc29jx4v0Zk+/y7mSa2nhX2iU0BHBto4jFSs4vKZHSKAm6K9VSPkS1rjAyWj1HOf2Oq3S3WD7bvILB2IBtQcbQkHLHNUktKlVc1E8/xSz2TJ0zxQh7C09LFydXCRikTXQaYwTHxAZQFr2NLpRF4yMJ8FiBTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zi8MmmC+7P1cIYLyq3X9W1q2I0g3Qj/SN6QnL9GuDRA=;
 b=VWjcrDHGEpdG6p4XF/XIWSUS8jzakmY9jrPLBp87Gdum691rN1IuaeWSXFbrmWTUeLZ/SQ27cjaJyYjw7uraDKDi0IwZF3GZ/xkaoZkCPedHrL1pFu/DwBsHRLPHPrmc7fidyE1PUOhVS0yo8GPWlRaVo3AfxG9PCKW9OM+xjlcYy9Ueu9WdB6EAEq6suXzBFcTFI4VH0TRkOJv3aNTomtmarmnHmf2z221RWxjWwUFXN1ETYDYgaGfbnDBrZf9z9nT3WBavAPCVDZ5FoN1Him0fxmujmZ1AWtQuN2RgY2SramVVkXSvosGzcqA+OAx2Zs5rUE2ujDB1A92Wi+KX1Q==
Received: from OL1P279CA0018.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:12::23)
 by DB9PR10MB5185.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:326::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16; Fri, 26 May
 2023 06:36:00 +0000
Received: from HE1EUR01FT081.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:12:cafe::f8) by OL1P279CA0018.outlook.office365.com
 (2603:10a6:e10:12::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18 via Frontend
 Transport; Fri, 26 May 2023 06:36:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 HE1EUR01FT081.mail.protection.outlook.com (10.152.1.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.18 via Frontend Transport; Fri, 26 May 2023 06:35:59 +0000
Received: from CNPEK01M03MSX.ad011.siemens.net (139.24.237.220) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 26 May 2023 08:35:59 +0200
Received: from CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) by
 CNPEK01M03MSX.ad011.siemens.net (139.24.237.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 26 May 2023 14:35:56 +0800
Received: from CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) by
 CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) with mapi id
 15.01.2507.023; Fri, 26 May 2023 14:35:56 +0800
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"srinuvasan_a@mentor.com" <srinuvasan_a@mentor.com>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>, "Arjunan, Srinu"
	<srinuvasan.a@siemens.com>
Subject: Re: [isar-cip-core][PATCH] Drop redundant expand=True parameter from getVar
Thread-Topic: [isar-cip-core][PATCH] Drop redundant expand=True parameter from
 getVar
Thread-Index: AQHZj5xTPb2oheSF8k6IRzKhJ9cbSg==
Date: Fri, 26 May 2023 06:35:56 +0000
Message-ID: <2ead9fdb5d6ad81b804c2c4b25624de1cd354904.camel@siemens.com>
References: <20230524094724.1953389-1-srinuvasan_a@mentor.com>
In-Reply-To: <20230524094724.1953389-1-srinuvasan_a@mentor.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
x-originating-ip: [139.24.247.52]
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT081:EE_|DB9PR10MB5185:EE_
X-MS-Office365-Filtering-Correlation-Id: af2edd27-ced1-43b0-ca1e-08db5db37837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	zt8JMx1Fy+u14UYOHQk5HukJe7npYrJV6zzfuvgJa7prdaOCSCwQ+2GgquE7/raCiY2W5JLErAV5GlSjfrWuZQXX1DtBygYLMnrs++ROg5PMD59U3j3pndulWrasqBTcBVdgZJnVy4X+1OILiSdLsnZflzJ1mob6NL05AdFHsf6b3ofmEYZnJYr10TtKjH9a+vcrqMDojHAXbVkYierehsJyqo2gDC0GAWVGrc+y/7gmG5oVq1ox9NAc3jXj/xt3qE+U0kWxFGKcm9Yrm8ZeOd7+/bkcw5v6D+Cve93MNE1kcgc/OByMSbAHq2YKOfpBvz11xc39e+5/k9GSIsJ+eoHvfpQreuX4ISkpg2x9D+VN2Zdc3GZ7AUARbqu0jLo0ognx9ZvJPrb4pfuAIuKu7Q61dddyKvwQZix2u+TleRsNn2YMhsk5VdcraIhOb8YloMUPiKB2N2SUsEGqGtjfIJK3av7hWn73xrWXcU3N4BTCpbf8TVShaiTn7aYRhb/Jd3zaybH3otQ5JuB9DQbaahKUfli682OsnB7rHOGABVPDpWEQncGYHwO2DDeonEUXq793MhWlPpoSF5N2BVb0el8bQGtvTg2YhwOdCyL896xpI6Q8Zy+wBtdU/eknD/stS3TeZ75VY6Lj4Jmm5tMNr4UYnmudKAsYTCIkBDjExOLEQ+pxV9be54xfHvz4svqTd7aaaJQ/UwMIYQPDwGKwtFGjf2qQOcacBFmH6aOB+9OiYami304ElQf6XPwyZn10ONJn/dusm3Udx58wI/20cw==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199021)(36840700001)(46966006)(40470700004)(2616005)(956004)(40460700003)(336012)(47076005)(2906002)(83380400001)(186003)(36756003)(82310400005)(86362001)(82960400001)(82740400003)(356005)(81166007)(36860700001)(40480700001)(316002)(8936002)(41300700001)(8676002)(5660300002)(478600001)(110136005)(54906003)(4326008)(70206006)(70586007)(107886003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 06:35:59.9570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af2edd27-ced1-43b0-ca1e-08db5db37837
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT081.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5185
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <3AC62BCEF125F14886200E09EA67CC29@siemens.com>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 26 May 2023 16:33:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11657

T24gV2VkLCAyMDIzLTA1LTI0IGF0IDE1OjE3ICswNTMwLCBTcmludXZhc2FuIEFyanVuYW4gd3Jv
dGU6DQo+IEZyb206IFNyaW51dmFzYW4gQSA8c3JpbnV2YXNhbi5hQHNpZW1lbnMuY29tPg0KPiAN
Cj4gSXQgaXMgbG9uZyBUcnVlIGJ5IGRlZmF1bHQsIGJ1dCBwZW9wbGUga2VlcCBhZGRpbmcgbmV3
IGNhc2VzIG9mIHRoaXMNCj4gcmVkdW5kYW5jeSwgaGVuY2UgZml4IHRoaXMgb25lLg0KDQpPaCB5
ZXMuLi4gVGhhbmtzLiBJIGFsc28gY2FuJ3QgcmVtZW1iZXIgdGhhdCB0aGlzIGNoYW5nZWQgaW4g
Yml0YmFrZS4NCkFja2VkIQ0KDQpGZWxpeA0KPiANCj4gU2lnbmVkLW9mZi1ieTogU3JpbnV2YXNh
biBBIDxzcmludXZhc2FuLmFAc2llbWVucy5jb20+DQo+IC0tLQ0KPiDCoGNsYXNzZXMvaW1hZ2Vf
dXVpZC5iYmNsYXNzIHwgMiArLQ0KPiDCoGNsYXNzZXMvc3d1cGRhdGUuYmJjbGFzc8KgwqAgfCAy
ICstDQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvY2xhc3Nlcy9pbWFnZV91dWlkLmJiY2xhc3MgYi9jbGFzc2Vz
L2ltYWdlX3V1aWQuYmJjbGFzcw0KPiBpbmRleCA5ZmZlMTRkLi5mNmI2MzFmIDEwMDY0NA0KPiAt
LS0gYS9jbGFzc2VzL2ltYWdlX3V1aWQuYmJjbGFzcw0KPiArKysgYi9jbGFzc2VzL2ltYWdlX3V1
aWQuYmJjbGFzcw0KPiBAQCAtMTgsNyArMTgsNyBAQCBpbmhlcml0IGltYWdlDQo+IMKgZGVmIGdl
bmVyYXRlX2ltYWdlX3V1aWQoZCk6DQo+IMKgwqDCoMKgIGltcG9ydCB1dWlkDQo+IMKgDQo+IC3C
oMKgwqAgYmFzZV9oYXNoID0gZC5nZXRWYXIoIkJCX1RBU0tIQVNIIiwgVHJ1ZSkNCj4gK8KgwqDC
oCBiYXNlX2hhc2ggPSBkLmdldFZhcigiQkJfVEFTS0hBU0giKQ0KPiDCoMKgwqDCoCBpZiBiYXNl
X2hhc2ggaXMgTm9uZToNCj4gwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gTm9uZQ0KPiDCoMKgwqDC
oCByZXR1cm4gc3RyKHV1aWQuVVVJRChiYXNlX2hhc2hbOjMyXSwgdmVyc2lvbj00KSkNCj4gZGlm
ZiAtLWdpdCBhL2NsYXNzZXMvc3d1cGRhdGUuYmJjbGFzcyBiL2NsYXNzZXMvc3d1cGRhdGUuYmJj
bGFzcw0KPiBpbmRleCA5YTRkNTA5Li4xMDU2YWI1IDEwMDY0NA0KPiAtLS0gYS9jbGFzc2VzL3N3
dXBkYXRlLmJiY2xhc3MNCj4gKysrIGIvY2xhc3Nlcy9zd3VwZGF0ZS5iYmNsYXNzDQo+IEBAIC02
Nyw3ICs2Nyw3IEBAIHB5dGhvbigpew0KPiDCoA0KPiDCoCMgY29udmVydCBiZXR3ZWVuIHN3dXBk
YXRlIGNvbXByZXNzb3IgbmFtZSBhbmQgaW1hZ2V0eXBlIGV4dGVuc2lvbg0KPiDCoGRlZiBnZXRf
c3d1X2NvbXByZXNzaW9uX3R5cGUoZCk6DQo+IC3CoMKgwqAgc3d1X2N0ID0gZC5nZXRWYXIoJ1NX
VV9DT01QUkVTU0lPTl9UWVBFJywgVHJ1ZSkNCj4gK8KgwqDCoCBzd3VfY3QgPSBkLmdldFZhcign
U1dVX0NPTVBSRVNTSU9OX1RZUEUnKQ0KPiDCoMKgwqDCoCBpZiBub3Qgc3d1X2N0Og0KPiDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybiAnJw0KPiDCoMKgwqDCoCBzd3VfdG9faW1hZ2UgPSB7J3psaWIn
OiAnLmd6JywgJ3pzdGQnOiAnLnpzdCd9DQoNCg==

