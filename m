Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7CDC6379F
	for <webhook@archiver.kernel.org>; Tue, 14 Feb 2023 02:36:01 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.77])
 by mx.groups.io with SMTP id smtpd.web10.12669.1676290208652286753
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Feb 2023 04:10:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=e8NEjQuJ;
 spf=pass (domain: siemens.com, ip: 40.107.247.77, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsOL54TxgmyhSsSIzbGBwNW/TFKPesvMDd/tATsBVVeMZJatfNAtU3NSMWuB1dQrkNqNnZwREcVRHTIUyftqI1mGyW9I5WT1UY9NLwXhJWU5gQKfUyMHkrgx7eqyBlx72J/b79O8EaZgj4EghmYcGJO94wWk3/UmfNWY3rK7dD9xlewsM0Op8bnX2EQEXeX4nGUJK8fg8F9iUVmM4Zu70e+RemVrx9lzHZPHzGYf7Rqt0NdqR9Yh33Q1J5BNjnpLKCAXOB5j19Aw2q57Y7t7jP8MLWap2VPeCh9xxy6CgZBUT09y2ucMMcigao93gVDXeN/wxubFp5RrrCyN6j1HJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWKfj0aN4D/FYLLri7+L64rWMXKHzUGLX7phtnReq7A=;
 b=BdpOlM+T90RS8bCipqLMp+Z/jSJWWpk16JXztjh2XWJ42XhiNLihR2r2qLE1WZq9VYjbO/kLKz21MqKOhsrs5VExUsQCAiQZzH4zxoGIdJ/zJdBtyClpX4P8O6NCK9N2UIiw7QoLKL7qepasYmH54Ggm5lR0xozvhT4EgF5sa6A+PA8XlQVjgFpT8y3I1R5835LtdNSoIc2GZsmnR+u+qQkItD/vTtQuUJ7lxPQN+tbt09mnZZ8fGlBLNnrg5Ynu2elp+Up6LI7qpYwXoIBrwoeS4kvTsId17eW82i6aGSjP9JRutepgTB38VmBaBCvTFhv2VD89O1eanXl/jMlojw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWKfj0aN4D/FYLLri7+L64rWMXKHzUGLX7phtnReq7A=;
 b=e8NEjQuJM/VLCWQ/HqLx3Fo1aPmBtVHg0Q+wPdWc3OT6ZvlRN3nebQaIuWzpnoK3zJIgjC0t0mAybE/AmUg5tp+FSn7dnRiAf2fV30WDxGC6aM3y1Ap2WW31A+mkB2wm4QIqix8OhjqFZk1yz/mO0Wo/omVHSamUhZ4IwoLYtAAOtBsJua3bJ0HZwM3EF41cLrCqJPVJez/ukyAajUDgoZCMy0HIP/W9TIepdqrSuHTD+id0OorqNEWpVgUUjD8ZKX3pM2mYtuJ/mzcQcgr9I6Jq8a4HJYimLu0Ru4H+qhlid8Waa0vGqsXUEU38fjJkeZu1uxQrt7/AvYeSRtkwRA==
Received: from OS6P279CA0113.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:3c::14)
 by DB9PR10MB5380.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:333::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Mon, 13 Feb
 2023 12:10:05 +0000
Received: from HE1EUR01FT041.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:3c:cafe::69) by OS6P279CA0113.outlook.office365.com
 (2603:10a6:e10:3c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24 via Frontend
 Transport; Mon, 13 Feb 2023 12:10:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 HE1EUR01FT041.mail.protection.outlook.com (10.152.1.3) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.23 via Frontend Transport; Mon, 13 Feb 2023 12:10:04 +0000
Received: from CNPEK01M08MSX.ad011.siemens.net (139.24.237.225) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1118.21; Mon, 13 Feb 2023 13:10:03 +0100
Received: from CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) by
 CNPEK01M08MSX.ad011.siemens.net (139.24.237.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 13 Feb 2023 20:09:58 +0800
Received: from CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) by
 CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) with mapi id
 15.01.2507.017; Mon, 13 Feb 2023 20:09:58 +0800
From: "Moessbauer, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
CC: "Bovensiepen, Daniel (bovi)" <daniel.bovensiepen@siemens.com>
Subject: Re: [isar-cip-core][PATCH 1/3] ebg: install for correct distro-arch
Thread-Topic: [isar-cip-core][PATCH 1/3] ebg: install for correct distro-arch
Thread-Index: AQHZP4lErCah5/awu02AlghTh0Tgjq7MN5WAgAALZoA=
Date: Mon, 13 Feb 2023 12:09:58 +0000
Message-ID: <b0784e004e1ea88e77070d7e01ee048758b02605.camel@siemens.com>
References: <20230213085741.1242658-1-felix.moessbauer@siemens.com>
	 <f2a2f503-c85e-bd28-aae7-4624283f018d@siemens.com>
In-Reply-To: <f2a2f503-c85e-bd28-aae7-4624283f018d@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1+deb11u1 
x-originating-ip: [139.24.236.148]
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT041:EE_|DB9PR10MB5380:EE_
X-MS-Office365-Filtering-Correlation-Id: a00471cf-3586-4f2a-c6fc-08db0dbb3dad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	annvlcBpFTgJGCdZTcWnrarnrogTCRqOkAcIHTtBhLlNSbc37NP8AiMIvALHyE3VnIK7+gOffwDemT/XKDjsiupshn3vG0SNjf0gVjybYv/N/IqUf/8z1aefv2pn1m0trFLO76kQ3EzUDZ3s7/QL0cEVdbhnCvzglJsnYUhrKd66AVjq1fxU3N/Ter6PumEjTnGw6or12r/EVGpPYUCW7ne/4/4eAWHOVKRaqD9gjAU3quTCgKE0L21E0S5zUd7NBK0cjRc4DXy3vn+suKmgNBVrjyaqS6eMiwtX1zGRyH/8X3KB8W0Uj7EPuTTryRMIV2jYDdJNGghSOgVb1fCgCP0rFrYhReVD0XaP0ngfmtlI3T7AWrkmJrBSqT8pLzLw29ViAkG/EDGqzXXlU/K2QH2ki09wRZwSovlT4zbVsr4v8EgwcBZuFuBtEPmVJ1fGzDSbscxLg6dKMjwYhas+dZPO5FUz0duZTjMYfUQstJ8G5WupVol/e1U/hmCXeZPKRc/wvK6iZK2S+iOSLZgk+/vzqPDBceorqilSS+aQApKVpCLjVlHbJGGgWWEYTRvD5ZVFpBu5ZknJWvd/HT1v1kMDJr+y/6d0J9vEV1kQl/kOx9MbLNbLIQP3FPiBmeVFkTeEYiQR5n13bua8caWzzgMGu/4BNZ/cA3vHtHbzSGlfq31w1lgE7jMKQVwEQArnm8gw18wedWy7UkDt01RHcNm2iL+kdpjWgevvWVGdZos=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199018)(40470700004)(36840700001)(46966006)(36756003)(41300700001)(40460700003)(110136005)(6636002)(356005)(316002)(4326008)(8676002)(70586007)(70206006)(36860700001)(40480700001)(82960400001)(86362001)(82310400005)(82740400003)(81166007)(53546011)(107886003)(186003)(26005)(2906002)(5660300002)(8936002)(2616005)(956004)(336012)(478600001)(47076005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 12:10:04.6893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a00471cf-3586-4f2a-c6fc-08db0dbb3dad
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT041.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5380
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <17E4C9063D08C1469EFA95297342DA93@siemens.com>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Feb 2023 02:36:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10687

T24gTW9uLCAyMDIzLTAyLTEzIGF0IDEyOjI5ICswMTAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAxMy4wMi4yMyAwOTo1NywgRmVsaXggTW9lc3NiYXVlciB3cm90ZToNCj4gPiBUaGUgZWZpYm9v
dGd1YXJkIHBhY2thZ2UgaXMgYXJjaGl0ZWN0dXJlIHNwZWNpZmljIChzaW1pbGFyIHRvIHRoZQ0K
PiA+IHN5c3RlbWQtYm9vdCBwYWNrYWdlKS4gSGVuY2UsIGluc3RhbGwgaXQgZm9yIHRoZSBkaXN0
cm8tYXJjaCwgbm90DQo+ID4gZm9yDQo+ID4gdGhlIGhvc3QgYXJjaCB0byBtYWtlIGNyb3NzLWlt
YWdpbmcgd29yay4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBGZWxpeCBNb2Vzc2JhdWVyIDxm
ZWxpeC5tb2Vzc2JhdWVyQHNpZW1lbnMuY29tPg0KPiA+IC0tLQ0KPiA+IMKgcmVjaXBlcy1jb3Jl
L2ltYWdlcy9lZmlib290Z3VhcmQuaW5jIHwgMiArLQ0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL3JlY2lw
ZXMtY29yZS9pbWFnZXMvZWZpYm9vdGd1YXJkLmluYyBiL3JlY2lwZXMtDQo+ID4gY29yZS9pbWFn
ZXMvZWZpYm9vdGd1YXJkLmluYw0KPiA+IGluZGV4IDI2MDI2ZGMuLmIzZmU5MTEgMTAwNjQ0DQo+
ID4gLS0tIGEvcmVjaXBlcy1jb3JlL2ltYWdlcy9lZmlib290Z3VhcmQuaW5jDQo+ID4gKysrIGIv
cmVjaXBlcy1jb3JlL2ltYWdlcy9lZmlib290Z3VhcmQuaW5jDQo+ID4gQEAgLTExLDcgKzExLDcg
QEANCj4gPiDCoA0KPiA+IMKgSU1BR0VfSU5TVEFMTDphcHBlbmQgPSAiIGVmaWJvb3RndWFyZCIN
Cj4gPiDCoA0KPiA+IC1XSUNfSU1BR0VSX0lOU1RBTEw6YXBwZW5kID0gIiBlZmlib290Z3VhcmQi
DQo+ID4gK1dJQ19JTUFHRVJfSU5TVEFMTDphcHBlbmQgPSAiIGVmaWJvb3RndWFyZDoke0RJU1RS
T19BUkNIfSINCj4gPiDCoFdET0dfVElNRU9VVCA/PSAiNjAiDQo+ID4gwqBXSUNWQVJTICs9ICJX
RE9HX1RJTUVPVVQgS0VSTkVMX0lNQUdFIElOSVRSRF9JTUFHRSBEVEJfRklMRVMiDQo+ID4gwqBJ
TUFHRV9GU1RZUEVTICs9ICJ3aWMiDQo+IA0KPiBXaGVuIGRvZXMgdGhpcyBiaXRlIHVzPyBDdXJy
ZW50IG1hc3RlciBpcyBub3QgYWZmZWN0ZWQgYXMgaXQgc2VlbXMuDQo+IEJvb2t3b3JtL3NpZCwg
d2hlbiBhbGwgZWZpYm9vdGd1YXJkIGFyY2hzIGFyZSBhdmFpbGFibGUgYXQgdGhlIHNhbWUNCj4g
dGltZT8NCg0KWWVzLCBleGFjdGx5LiBXaGVuIHdlIGJ1aWxkIGl0IG1hbnVhbGx5LCBvbmx5IHRo
ZSAiY29ycmVjdCIgcGFja2FnZSBpcw0KYWRkZWQgdG8gdGhlIGlzYXItYXB0IChiZWNhdXNlIHRo
ZXJlIGlzIG5vIG90aGVyKS4NCg0KPiANCj4gSW4gYW55IGNhc2UsIGFub3RoZXIgcmVncmVzc2lv
biBmcm9tIHRoZSBzd2l0Y2ggdG8gYnVpbGRjaHJvb3QtaG9zdA0KPiBpbg0KPiBpc2FyLiBJIGhh
ZCBmYWxsb3V0cyBmcm9tIHRoYXQgYXMgd2VsbCwgYW5kIHRoZXkgYXJlIGFsbCBzdWJ0bGUgdG8N
Cj4gZGVidWcuIE11c3QgYmUgZG9jdW1lbnRlZCBpbiB1cHN0cmVhbSdzIFJFQ0lQRS1BUEktQ0hB
TkdMT0csIHdpdGggYWxsDQo+IGl0cyBhc3BlY3RzIC0gcGxlYXNlIGZpeCAoeW91IGNhdXNlZCBp
dCBpbiB0aGUgZmlyc3QgcGxhY2UgOykgKS4NCg0KV2VsbC4uLiBpbiBteSBvcGluaW9uIHRoaXMg
aXMgbm90IGEgcmVncmVzc2lvbiBidXQganVzdCBhIGJ1ZyB0aGF0DQpzaG93cyB1cCBiZWNhdXNl
IHdlICJjcm9zcy1pbWFnZSIuIEJ1dCB5ZXMsIHRoYXQgZG9lc24ndCBoZWxwIG91ciB1c2Vycw0K
bXVjaC4gSSdsbCBhZGQgYSBjaGFuZ2Vsb2cgZW50cnkuDQoNCkZlbGl4DQoNCj4gDQo+IEphbg0K
PiANCg0K

