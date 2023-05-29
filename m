Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39745C77B7E
	for <webhook@archiver.kernel.org>; Mon, 29 May 2023 12:43:44 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.89])
 by mx.groups.io with SMTP id smtpd.web10.45864.1685352568603561346
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 May 2023 02:29:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=xmPuoAat;
 spf=pass (domain: siemens.com, ip: 40.107.249.89, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MyLtvQSpkz+sCcnwvdsAyA8tA2d/oJmU1kBaOY4KSZoEhnnnFNVma1G0mdieIRyaGtFCkvwrW66c2WHRZ+0PB2wpmCIO75nYRhatcawBQBxIPpTawhR1IZgxqUMlNop5yPvwXq81RKc56f4xlIUvD2jKvo4jx+MIU6gn74b9s8J1s/E26cxyvHih2KlaYWnIQEBZ37PEuD0GYhLpUXHiyOlkz02INvQfx1k5WcitCouTDIP4kbU0O0d9euUJCGmhdmDeJJWwC6xtXye6CEIOqpN1apjrneuZhlglOydA1XQcLw9Q/9YSF1B4SBotIctEfamWCM24cKjxdOXq5f9zYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dc/5dtArJ0uyyZ8N9PcYSboXUU6WV3VoT6n+fVJTLHY=;
 b=kYtPZOB3qgWNGY6T3L8xon/z5ZbhCqGecdnotXxI1mrU2SCcTksCq2exLhrXngEsLYVjSEFm+wO/qaPxsbcvSDS9MBEspeTPWKHCxtVQ3SvZGlq7hLOCPSKVUv+Hjy5q5B7PQw+tcHanDn6vHPizEuEaBNTYXfniDw9Y+X6f7TRqDQ+lLVb74E6j+CLn5qntZCPfkbHG2JHsKqfF4lILAQ2/jlclIPSuXQxns9G4a7FoHoRTGBZys1Z5qxRh7oldF1KFrxjBOOHrFpRv2WLdUJ/fNlF0en+j2TACMiRCdZoInUAsTdEfVv3EifbW/rlK/hyLFu2yspwYD46ZB37hGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dc/5dtArJ0uyyZ8N9PcYSboXUU6WV3VoT6n+fVJTLHY=;
 b=xmPuoAatLXBBsT93BPwJtz6QDycKbjnwk67a2ODsAsYuaLvl0FYJW8xH87yqd40rZWdf5+y7ja/banuk2OUqtBe2P97kGkkkE6NbrWhJt+Cba1HMKzKKQ89AW27XLV/1gY2LupRtk5ReqFFv6d8xIFuCPEeW3IocmGfNnVCigOgGa2JKEbWuxQ5dUxteyoscX10fPDwWN1wQVlU/lH4F8YAE3BNw+rCyJAXyOQRgz0TFq8IS8Rau0m62lNrDm9x4Vxkh1yueHVCWpmjFerm0NgdbAWDzmK9fAKPWhbtuh7vbjYcdQkJyf23qKinicyHqkQ5gdrYjRlhl0wgJGAUwuA==
Received: from DB6PR07CA0109.eurprd07.prod.outlook.com (2603:10a6:6:2c::23) by
 DB9PR10MB5210.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:324::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.22; Mon, 29 May 2023 09:29:25 +0000
Received: from DB5EUR01FT028.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:6:2c:cafe::fd) by DB6PR07CA0109.outlook.office365.com
 (2603:10a6:6:2c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.15 via Frontend
 Transport; Mon, 29 May 2023 09:29:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 DB5EUR01FT028.mail.protection.outlook.com (10.152.4.237) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.20 via Frontend Transport; Mon, 29 May 2023 09:29:25 +0000
Received: from CNPEK01M06MSX.ad011.siemens.net (139.24.237.223) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 29 May 2023 11:29:23 +0200
Received: from CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) by
 CNPEK01M06MSX.ad011.siemens.net (139.24.237.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 29 May 2023 17:29:21 +0800
Received: from CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) by
 CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) with mapi id
 15.01.2507.023; Mon, 29 May 2023 17:29:21 +0800
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Su, Bao
 Cheng" <baocheng.su@siemens.com>
CC: "Storm, Christian" <christian.storm@siemens.com>, "Gylstorff, Quirin"
	<quirin.gylstorff@siemens.com>, "Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: Re: [isar-cip-core][PATCH 2/2] initramfs: Add recipe for optee based ftpm hook
Thread-Topic: [isar-cip-core][PATCH 2/2] initramfs: Add recipe for optee based
 ftpm hook
Thread-Index: AQHZj506G/ph5dw1tUWcf/tXablGBK9wYr2AgAAX/AA=
Date: Mon, 29 May 2023 09:29:21 +0000
Message-ID: <e8ffddc06094fb8513ed49c40b9fcee5771fb4ed.camel@siemens.com>
References: <664ef5ea0fa832ff709718b249a93864f98714c6.camel@siemens.com>
	 <92b92c22a0e0daa636398ebca60945fb087b5555.camel@siemens.com>
	 <7047e533b93015d8be1b9ff6043f562a9cb8ba7c.camel@siemens.com>
In-Reply-To: <7047e533b93015d8be1b9ff6043f562a9cb8ba7c.camel@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
x-originating-ip: [139.24.247.57]
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT028:EE_|DB9PR10MB5210:EE_
X-MS-Office365-Filtering-Correlation-Id: 20cfdb44-5a0f-42ae-a8fa-08db60273156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	AAv0YBWLbrRVYBTqs+inmHOeqGf7/G/ekSrgzhuJX9EbDCb5lqQhwTbLPswe7ESvrFuJUlUep9M6rChKs6O3N/dK5Zf0xGpankhKtaFmf1bcOYQwlQ2hT2lHD/2Rg0/3PlJH23U8wZVeSFBrdCWW2cc6LLU9fDgb6JFhxmJUHUpdm8xIOC+tbHn8bN3A60+X0VB0AubvCDFF1enCrIcDQ2JOxnThEi4SiE4dtre95lXudbkazGbYsJIflkodwMFqi3TiTUOG5GVLtfIl1jhMIQaJVZSiDO5uPSXSSAAeanKZN/EXJCqS07DR1T3IZzsY6pL+f+l+S7sLDkWMF+0Wq0dBTU0wvjDwNGiWCUuGvJbYVnvvVD3wrZfATPqTfWWMrgZeFhBERArBEQUTGWoueSIXGlfFVmrQ2iH7jcis21GcUk/v3WHvOuX6a5zv2Bu7oYhvN6LUBXB+DdBNA7FDgDsmaTNasbOQTCStf98NkPsFIMouAYqcpGRiJTvCCInGBOJX69z5PorIZBNNO+bTwjxhzsESZxCWWqVmUghbNNWsQJALiGeR+syr8+sLjAZJeKzd6cwyfW0Gzj+ZnFBQNhOri0CfufsWYbNaFt9e75/A3THt9pqDiTFbRKkLqn/ZpzKrXz6usSMqioQnXRgvgDZQyMpGurC+MwEOts63q2NtmwbMO+g32mKrNkJIU4Nan0d+X4b5p1b5QPdFacNeX2MWDDGPNHNugDX0SvaVs7RtmSO13m+s3EKs8zlwbjEqErRiiuYPQPv4d9qy7TcpnQ==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(36860700001)(40460700003)(47076005)(5660300002)(316002)(70586007)(36756003)(70206006)(107886003)(4326008)(6636002)(82310400005)(86362001)(82740400003)(82960400001)(966005)(81166007)(8676002)(356005)(41300700001)(8936002)(40480700001)(110136005)(54906003)(2906002)(956004)(2616005)(186003)(336012)(478600001)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 09:29:25.0032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20cfdb44-5a0f-42ae-a8fa-08db60273156
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT028.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5210
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA5D60DF689A5C418A5EE331CFD17E20@siemens.com>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 May 2023 12:43:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11697

T24gTW9uLCAyMDIzLTA1LTI5IGF0IDE2OjAzICswODAwLCBTdSwgQmFvIENoZW5nIChESSBGQSBD
VFIgSVBDIENODQpQUkM0KSB3cm90ZToNCj4gT24gRnJpLCAyMDIzLTA1LTI2IGF0IDE0OjQyICsw
ODAwLCBNT0VTU0JBVUVSLCBGZWxpeCAoVCBDRUQgSU5XLUNOKQ0KPiB3cm90ZToNCj4gPiBPbiBX
ZWQsIDIwMjMtMDUtMjQgYXQgMDM6MTUgKzAwMDAsIFN1LCBCYW8gQ2hlbmcgd3JvdGU6DQo+ID4g
PiBQcmVwYXJlIGZvciBpbml0cmFtZnMgYXBwbGljYXRpb25zIHJlcGx5aW5nIG9uIFRQTSwgc3Vj
aCBhcw0KPiA+ID4gY2xldmlzDQo+ID4gPiBvcg0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBeXl5eXl5e
Xg0KPiA+IEkgZ3Vlc3MgaXQgc2hvdWxkIGJlIHJlbHlpbmcgLS0tLS0tLS18DQo+IA0KPiBZZXAs
IDopDQo+IA0KPiA+IA0KPiA+IEZlbGl4DQo+ID4gDQo+ID4gPiBzeXN0ZW1kLWNyeXB0c2V0dXAN
Cj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQmFvY2hlbmcgU3UgPGJhb2NoZW5nLnN1QHNp
ZW1lbnMuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiDCoC4uLi9pbml0cmFtZnMtbXMtZnRwbS1ob29r
L2ZpbGVzL21zLWZ0cG0uaG9vayB8IDM2DQo+ID4gPiArKysrKysrKysrKysrKysrDQo+ID4gPiDC
oC4uLi9maWxlcy9tcy1mdHBtLnNjcmlwdMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8IDQzDQo+ID4gPiArKysrKysrKysrKysrKysrKysrDQo+ID4gPiDCoC4uLi9p
bml0cmFtZnMtbXMtZnRwbS1ob29rXzAuMS5iYsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDMw
ICsrKysrKysrKysrKysNCj4gPiA+IMKgMyBmaWxlcyBjaGFuZ2VkLCAxMDkgaW5zZXJ0aW9ucygr
KQ0KPiA+ID4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZz
LW1zLWZ0cG0tDQo+ID4gPiBob29rL2ZpbGVzL21zLWZ0cG0uaG9vaw0KPiA+ID4gwqBjcmVhdGUg
bW9kZSAxMDA2NDQgcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLW1zLWZ0cG0tDQo+ID4gPiBo
b29rL2ZpbGVzL21zLWZ0cG0uc2NyaXB0DQo+ID4gPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCByZWNp
cGVzLWluaXRyYW1mcy9pbml0cmFtZnMtbXMtZnRwbS0NCj4gPiA+IGhvb2svaW5pdHJhbWZzLW1z
LWZ0cG0taG9va18wLjEuYmINCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL3JlY2lwZXMtaW5p
dHJhbWZzL2luaXRyYW1mcy1tcy1mdHBtLWhvb2svZmlsZXMvbXMtDQo+ID4gPiBmdHBtLmhvb2sg
Yi9yZWNpcGVzLWluaXRyYW1mcy9pbml0cmFtZnMtbXMtZnRwbS1ob29rL2ZpbGVzL21zLQ0KPiA+
ID4gZnRwbS5ob29rDQo+ID4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+ID4gaW5kZXggMDAw
MDAwMC4uOTk4YWU2Mg0KPiA+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ID4gKysrIGIvcmVjaXBlcy1p
bml0cmFtZnMvaW5pdHJhbWZzLW1zLWZ0cG0taG9vay9maWxlcy9tcy1mdHBtLmhvb2sNCj4gPiA+
IEBAIC0wLDAgKzEsMzYgQEANCj4gPiA+ICsjIS9iaW4vc2gNCj4gPiA+ICsjDQo+ID4gPiArIyBD
SVAgQ29yZSwgZ2VuZXJpYyBwcm9maWxlDQo+ID4gPiArIw0KPiA+ID4gKyMgQ29weXJpZ2h0IChj
KSBTaWVtZW5zIEFHLCAyMDIzDQo+ID4gPiArIw0KPiA+ID4gKyMgQXV0aG9yczoNCj4gPiA+ICsj
wqAgU3UgQmFvIENoZW5nIDxiYW9jaGVuZy5zdUBzaWVtZW5zLmNvbT4NCj4gPiA+ICsjDQo+ID4g
PiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogTUlUDQo+ID4gPiArIw0KPiA+ID4gK1BSRVJF
UT0iIg0KPiA+ID4gK3ByZXJlcXMoKQ0KPiA+ID4gK3sNCj4gPiA+ICvCoMKgwqAgZWNobyAiJFBS
RVJFUSINCj4gPiA+ICt9DQo+ID4gPiArY2FzZSAkMSBpbg0KPiA+ID4gK3ByZXJlcXMpDQo+ID4g
PiArwqDCoMKgIHByZXJlcXMNCj4gPiA+ICvCoMKgwqAgZXhpdCAwDQo+ID4gPiArwqDCoMKgIDs7
DQo+ID4gPiArZXNhYw0KPiA+ID4gKw0KPiA+ID4gKy4gL3Vzci9zaGFyZS9pbml0cmFtZnMtdG9v
bHMvaG9vay1mdW5jdGlvbnMNCj4gPiA+ICsNCj4gPiA+ICtob29rX2Vycm9yKCkgew0KPiA+ID4g
K8KgwqDCoCBlY2hvICIoRVJST1IpOiAkMiIgPiYyDQo+ID4gPiArwqDCoMKgIGV4aXQgMQ0KPiA+
ID4gK30NCj4gPiA+ICsNCj4gPiA+ICsjIEp1c3QgaW4gY2FzZSB0aGVzZSBtb2R1bGVzIGFyZSBu
b3QgYnVpbHQtaW4NCj4gPiA+ICttYW51YWxfYWRkX21vZHVsZXMgdGVlDQo+ID4gPiArbWFudWFs
X2FkZF9tb2R1bGVzIG9wdGVlDQo+ID4gPiArbWFudWFsX2FkZF9tb2R1bGVzIHRwbV9mdHBtX3Rl
ZQ0KPiA+IA0KPiA+IEFyZSB0aGVzZSBtb2R1bGVzIGF2YWlsYWJsZSBpbiBhIHN0b2NrIERlYmlh
biBrZXJuZWwgYXMgd2VsbD8NCj4gDQo+IEFyZSB5b3UgcmVmZXJyaW5nIHRvIHRoZSBvZmZpY2lh
bCBhcm02NCBrZXJuZWwgb2YgRGViaWFuPyBIYXZlbid0DQo+IGNoZWNrZWQgaXQgeWV0LiBGb3Ig
YW1kNjQsIGhvd2V2ZXIsIEkgZG9uJ3QgZXhwZWN0IHRoZSBvcHRlZSAmDQo+IHRwbV9mdHBtX3Rl
ZSBpbiB0aGUgc3RvY2sgZGViaWFuIGtlcm5lbC4NCg0KWWVzLCBJIHdhcyByZWZlcnJpbmcgdG8g
dGhlIHN0b2NrIGRlYmlhbiBrZXJuZWxzIGZvciBhcm02NC4NCklmIG5vdCwgdGhhdCBzaG91bGQg
bm90IGJlIGEgcHJvYmxlbSBoZXJlLCBidXQgd2Ugc2hvdWxkIGF0IGxlYXN0DQpkb2N1bWVudCBp
dC4gSSBob3BlIHRoZSBDSVAga2VybmVsIHByb3ZpZGVzIHRoZXNlIG1vZHVsZXMuDQoNCj4gDQo+
IEFNRCBhbHNvIHByb3ZpZGVzIGEgVEVFLCBzbyB0cG1fZnRwbV90ZWUgbWF5IGJlIHBvc3NpYmxl
IG9uIGFtZDY0Lg0KPiANCj4gPiANCj4gPiA+ICsNCj4gPiA+ICtjb3B5X2V4ZWMgL3Vzci9zYmlu
L3RlZS1zdXBwbGljYW50IHx8IGhvb2tfZXJyb3IgIi91c3Ivc2Jpbi90ZWUtDQo+ID4gPiBzdXBw
bGljYW50IG5vdCBmb3VuZCINCj4gPiA+IGRpZmYgLS1naXQgYS9yZWNpcGVzLWluaXRyYW1mcy9p
bml0cmFtZnMtbXMtZnRwbS1ob29rL2ZpbGVzL21zLQ0KPiA+ID4gZnRwbS5zY3JpcHQgYi9yZWNp
cGVzLWluaXRyYW1mcy9pbml0cmFtZnMtbXMtZnRwbS1ob29rL2ZpbGVzL21zLQ0KPiA+ID4gZnRw
bS5zY3JpcHQNCj4gPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gPiBpbmRleCAwMDAwMDAw
Li5jNmVlMmRkDQo+ID4gPiAtLS0gL2Rldi9udWxsDQo+ID4gPiArKysgYi9yZWNpcGVzLWluaXRy
YW1mcy9pbml0cmFtZnMtbXMtZnRwbS1ob29rL2ZpbGVzL21zLQ0KPiA+ID4gZnRwbS5zY3JpcHQN
Cj4gPiA+IEBAIC0wLDAgKzEsNDMgQEANCj4gPiA+ICsjIS9iaW4vc2gNCj4gPiA+ICsjDQo+ID4g
PiArIyBDSVAgQ29yZSwgZ2VuZXJpYyBwcm9maWxlDQo+ID4gPiArIw0KPiA+ID4gKyMgQ29weXJp
Z2h0IChjKSBTaWVtZW5zIEFHLCAyMDIzDQo+ID4gPiArIw0KPiA+ID4gKyMgQXV0aG9yczoNCj4g
PiA+ICsjwqAgU3UgQmFvIENoZW5nIDxiYW9jaGVuZy5zdUBzaWVtZW5zLmNvbT4NCj4gPiA+ICsj
DQo+ID4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogTUlUDQo+ID4gPiArIw0KPiA+ID4g
K1BSRVJFUT0iIg0KPiA+ID4gKw0KPiA+ID4gK3ByZXJlcXMoKQ0KPiA+ID4gK3sNCj4gPiA+ICvC
oMKgwqDCoMKgwqDCoGVjaG8gIiRQUkVSRVEiDQo+ID4gPiArfQ0KPiA+ID4gKw0KPiA+ID4gK2Nh
c2UgJDEgaW4NCj4gPiA+ICsjIGdldCBwcmUtcmVxdWlzaXRlcw0KPiA+ID4gK3ByZXJlcXMpDQo+
ID4gPiArwqDCoMKgwqDCoMKgwqBwcmVyZXFzDQo+ID4gPiArwqDCoMKgwqDCoMKgwqBleGl0IDAN
Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoDs7DQo+ID4gPiArZXNhYw0KPiA+ID4gKw0KPiA+ID4gK0ZU
UE1fREVWPS9kZXYvdHBtcm0wDQo+ID4gPiArDQo+ID4gPiArLiAvc2NyaXB0cy9mdW5jdGlvbnMN
Cj4gPiA+ICsNCj4gPiA+ICsvdXNyL3NiaW4vdGVlLXN1cHBsaWNhbnQgLWQNCj4gPiA+ICsNCj4g
PiA+ICsjIFRoZSBmVFBNIFRBIHdvdWxkIHRha2Ugc29tZSB0aW1lIHRvIGJlIGRpc2NvdmVyZWQg
YXMgd2VsbCBhcw0KPiA+ID4gdGhlDQo+ID4gPiB0ZWUtc3VwcGxpY2FudA0KPiA+ID4gKyMgMTAg
c2Vjb25kcyBzaG91bGQgYmUgZW5vdWdoDQo+ID4gPiArd2FpdF9zZWM9MTANCj4gPiA+ICt1bnRp
bCB0ZXN0ICR3YWl0X3NlYyAtZXEgMCB8fCB0ZXN0IC1jICIke0ZUUE1fREVWfSIgOyBkbw0KPiA+
ID4gK8KgwqDCoMKgwqDCoMKgd2FpdF9zZWM9JCgod2FpdF9zZWMtMSkpDQo+ID4gPiArwqDCoMKg
wqDCoMKgwqBzbGVlcCAxDQo+ID4gPiArZG9uZQ0KPiA+ID4gKw0KPiA+ID4gK2lmICEgdGVzdCAt
YyAiJHtGVFBNX0RFVn0iOyB0aGVuDQo+ID4gPiArwqDCoMKgIHBhbmljICJDYW4ndCBkaXNjb3Zl
ciB0aGUgZlRQTSBkZXZpY2UgJHtGVFBNX0RFVn0hIg0KPiA+ID4gK2ZpDQo+ID4gPiBkaWZmIC0t
Z2l0IGEvcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLW1zLWZ0cG0taG9vay9pbml0cmFtZnMt
DQo+ID4gPiBtcy0NCj4gPiA+IGZ0cG0taG9va18wLjEuYmIgYi9yZWNpcGVzLWluaXRyYW1mcy9p
bml0cmFtZnMtbXMtZnRwbS0NCj4gPiA+IGhvb2svaW5pdHJhbWZzLW1zLWZ0cG0taG9va18wLjEu
YmINCj4gPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gPiBpbmRleCAwMDAwMDAwLi5mZWNl
NmZmDQo+ID4gPiAtLS0gL2Rldi9udWxsDQo+ID4gPiArKysgYi9yZWNpcGVzLWluaXRyYW1mcy9p
bml0cmFtZnMtbXMtZnRwbS1ob29rL2luaXRyYW1mcy1tcy1mdHBtLQ0KPiA+ID4gaG9va18wLjEN
Cj4gPiANCj4gPiBXaGVyZSBpcyB0aGlzIHBhY2thZ2UgYWN0dWFsbHkgdXNlZD8gSSBjYW4ndCBz
ZWUgdGhhdCBpdCBpcyBhZGRlZA0KPiA+IHRvDQo+ID4gdGhlIGluaXRyYW1mcyByZWNpcGUuDQo+
ID4gDQo+IA0KPiBJdCB3b3VsZCBiZSB1c2VkIGluIHRoZSBkb3duc3RyZWFtIG1ldGEtaW90MjA1
MCwgc2VlDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9zaWVtZW5zL21ldGEtaW90MjA1MC9wdWxsLzQ0
Mi4NCg0KVGhpcyBpcyB1bmZvcnR1bmF0ZWx5IG5vdCBzdWZmaWNpZW50LiBXZSBuZWVkIGEgdXNl
ciBpbiBjaXAtY29yZSBhcw0Kd2VsbCB0byBtYWtlIHN1cmUgdGhlIHBhY2thZ2UgZG9lcyBub3Qg
YnJlYWsgb3ZlciB0aW1lLg0KDQpGZWxpeA0KDQo+IA0KPiAtIEJhb2NoZW5nDQo+IA0KPiA+IEZl
bGl4DQo+ID4gDQo+ID4gPiAuYmINCj4gPiA+IEBAIC0wLDAgKzEsMzAgQEANCj4gPiA+ICsjDQo+
ID4gPiArIyBDSVAgQ29yZSwgZ2VuZXJpYyBwcm9maWxlDQo+ID4gPiArIw0KPiA+ID4gKyMgQ29w
eXJpZ2h0IChjKSBTaWVtZW5zIEFHLCAyMDIzDQo+ID4gPiArIw0KPiA+ID4gKyMgQXV0aG9yczoN
Cj4gPiA+ICsjwqAgU3UgQmFvIENoZW5nIDxiYW9jaGVuZy5zdUBzaWVtZW5zLmNvbT4NCj4gPiA+
ICsjDQo+ID4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogTUlUDQo+ID4gPiArIw0KPiA+
ID4gKw0KPiA+ID4gK2luaGVyaXQgZHBrZy1yYXcNCj4gPiA+ICsNCj4gPiA+ICtTUkNfVVJJICs9
ICIgXA0KPiA+ID4gK8KgwqDCoCBmaWxlOi8vbXMtZnRwbS5ob29rwqBcDQo+ID4gPiArwqDCoMKg
IGZpbGU6Ly9tcy1mdHBtLnNjcmlwdMKgXA0KPiA+ID4gK8KgwqDCoCAiDQo+ID4gPiArDQo+ID4g
PiArREVCSUFOX0RFUEVORFMgPSAiaW5pdHJhbWZzLXRvb2xzLCB0ZWUtc3VwcGxpY2FudCINCj4g
PiA+ICsNCj4gPiA+ICtkb19pbnN0YWxsW2NsZWFuZGlyc10gKz0gIiBcDQo+ID4gPiArwqDCoMKg
ICR7RH0vdXNyL3NoYXJlL2luaXRyYW1mcy10b29scy9ob29rcyBcDQo+ID4gPiArwqDCoMKgICR7
RH0vdXNyL3NoYXJlL2luaXRyYW1mcy10b29scy9zY3JpcHRzL2xvY2FsLWJvdHRvbSINCj4gPiA+
ICsNCj4gPiA+ICtkb19pbnN0YWxsKCkgew0KPiA+ID4gK8KgwqDCoCBpbnN0YWxsIC1tIDA3NTUg
IiR7V09SS0RJUn0vbXMtZnRwbS5ob29rIiBcDQo+ID4gPiArwqDCoMKgwqDCoMKgwqAgIiR7RH0v
dXNyL3NoYXJlL2luaXRyYW1mcy10b29scy9ob29rcy9tcy1mdHBtIg0KPiA+ID4gK8KgwqDCoCBp
bnN0YWxsIC1tIDA3NTUgIiR7V09SS0RJUn0vbXMtZnRwbS5zY3JpcHQiIFwNCj4gPiA+ICvCoMKg
wqDCoMKgwqDCoCAiJHtEfS91c3Ivc2hhcmUvaW5pdHJhbWZzLXRvb2xzL3NjcmlwdHMvbG9jYWwt
Ym90dG9tL21zLQ0KPiA+ID4gZnRwbSINCj4gPiA+ICt9DQo+ID4gPiANCj4gPiANCj4gDQoNCg==

