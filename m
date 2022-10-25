Return-Path: <baocheng.su@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F54C04A95
	for <webhook@archiver.kernel.org>; Tue, 25 Oct 2022 08:41:07 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.45])
 by mx.groups.io with SMTP id smtpd.web08.4869.1666687259264650867
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Oct 2022 01:40:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=n3T/NX0i;
 spf=pass (domain: siemens.com, ip: 40.107.22.45, mailfrom: baocheng.su@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZiEpjYVEWew7r4T8TKvUbhqGznzpx9URJeHpLBoozVOOvogg0NOIPASC8ao4hZoEDZqeFnP/KFYm+R4hH3JJPbG/302caQ4VS/MIcUgyt5u1M9Unt6dFJr8L9LWot7MaL/G5qjn+sBavGTLDUoawJ6qisujGXMzkC84MmGETCN1g9yRuOQjqWgz2+Odf2dXVyxw6ht4sQwbaPfo2XO+ehxCKtEFcvwrAz/x96hUXMKqx+2qOWnKREsUta+STeJ8UFtrfPgD5hxHeU1mPc0h5bEphOSnvnRQZkOvdDTc7aV31uZnLPrtA/bzZQ0wasgPzNliqfsnM2mRLbSXQ20m2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ts/pe7NN4dNDkh61ryBwhR0m9xoHtVA2G3KCnH/vfWg=;
 b=BrzwH73V2Qtrqw0Qusqc3U/gTcoepEgJ42gOYpE+dwwNV34y4F3F3M+OQwv6TRQ7y4uYpeY+ZLmChlVgwtlz9AzmEGGVzckcHlYGltjgNPuSjYZ6uRm35cKmN+2P0P0oQLIO+4D3rukjiJ6egm45xnUEVOWbZIY//NhXLOpf4dkMKia/aLUIwYVe1N7vYFBTzh+y6U5YArCexr9mqHv7GdDZf5dh+Ae5dMEfUdOOVx/67Xr3aUvc/6TKjkZDxyEAV7fmIJqtuR5EluUtDxksHDLwT8UP14WAFYxaJm2GPFokA9jq7R2trMB5RDbMwKlipSY6Aknuq9SHUt8epGREgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ts/pe7NN4dNDkh61ryBwhR0m9xoHtVA2G3KCnH/vfWg=;
 b=n3T/NX0iWq95Ld6/O0YfOMgQaaLyMs8FOLIljmVpRSrFwuM0xwPyK7CSChciShq6Zo6KNOPsUsx19IoCM88BnPbSYC5ha1OQ2f1HwUlp76uKXar+LkDmY8vBq6FWzSbpS7xAretP4xMmYgNZ0zPjJ2NytFQOBUcMcOSk7u+Lw0L97pAj0JvZZPLhq1ROm1rVZja+OgpJFJhstKUjD7FI25fDAPypS7gbOwwbqVsBmEsdk5pnyjhfEnCotfWZb6PonYyMiwQGtAhtTyLuP/5smyQ2G21pQGVGQfbNb6kflb1qj3x3ziN8PE6NFiGzyixPLZS90MsfNynrC3gokiMKCw==
Received: from DB9PR02CA0029.eurprd02.prod.outlook.com (2603:10a6:10:1d9::34)
 by GV2PR10MB7607.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Tue, 25 Oct
 2022 08:40:56 +0000
Received: from DB5EUR01FT032.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:1d9:cafe::ab) by DB9PR02CA0029.outlook.office365.com
 (2603:10a6:10:1d9::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23 via Frontend
 Transport; Tue, 25 Oct 2022 08:40:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 DB5EUR01FT032.mail.protection.outlook.com (10.152.4.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.16 via Frontend Transport; Tue, 25 Oct 2022 08:40:56 +0000
Received: from CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1118.15; Tue, 25 Oct 2022 10:40:54 +0200
Received: from CNPEK01M06MSX.ad011.siemens.net (139.24.237.223) by
 CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.13; Tue, 25 Oct 2022 16:40:49 +0800
Received: from CNPEK01M06MSX.ad011.siemens.net ([139.24.237.223]) by
 CNPEK01M06MSX.ad011.siemens.net ([139.24.237.223]) with mapi id
 15.01.2507.013; Tue, 25 Oct 2022 16:40:48 +0800
From: "Su, Bao Cheng" <baocheng.su@siemens.com>
To: "Schultschik, Sven" <sven.schultschik@siemens.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: Re: [isar-cip-core][PATCH 1/8] add recipe for edk2
Thread-Topic: [isar-cip-core][PATCH 1/8] add recipe for edk2
Thread-Index: AQHY6EleXfbDKuaNBUyVXbAuNYr+Y64eREIA
Date: Tue, 25 Oct 2022 08:40:48 +0000
Message-ID: <ebe0cbb32e14fa62d3dd06663da58dd273b80c0c.camel@siemens.com>
References: <20221024122725.383791-1-sven.schultschik@siemens.com>
	 <20221024122725.383791-2-sven.schultschik@siemens.com>
In-Reply-To: <20221024122725.383791-2-sven.schultschik@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1 
x-originating-ip: [140.231.151.93]
x-tm-as-product-ver: SMEX-14.0.0.3080-8.6.1018-26498.001
x-tm-as-result: No-10--15.511100-8.000000
x-tmase-matchedrid: 0lZ3oI+t/5pwWrhivu9rXtplUyIIewbxuV9eQHCYbHq2DJSILb1B3kni
	I3oIYf8z5NZMkA6RI/AEPZ/FNtxg38qpEXapUp2qiEYLDGGVNQ48+glRcTaRJoSO7UPzxVPTP6T
	ki+9nU3+wb7hccmYAhbX9hnMqzl+7XyHSQ0JhhO076N13v0MpCWJZXQNDzktSD3uYMxd01bcBmf
	/gD11vZO+uPZ9E4AOJf5gsG5H5IcHN30P8hEuOaYUhAYQSt8PhTweK12oEGftYFJ8lPOIXH5yqU
	J2uHKFAhaXwkYh/sNJNOr2O2VM/5+IpJTkAlqvSGx3PE3xmHEgBFjsfGKOPCYIK2tjTqNot2FA7
	wK9mP9e8YDH/UBNnm3MS0jV6XsCHSzouVhtIPPBXfyJjJyOvlZpjs55FQFHA9u1rQ4BgXPLJ5SX
	toJPLyPH96zhMF86noQKhy6g+RoEl3q2mDd7Yjoad3d4g0e7YtkEL1EmUpaMCLBN7QiqNl1XgGe
	VUh3WdmyiLZetSf8my5/tFZu9S3Ku6xVHLhqfxIAcCikR3vq+5VpyQvF0/B2BjGZBgXwFJiyPss
	Hu/BvrJ647x2qaAUCfo3a/y7Qsb
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--15.511100-8.000000
x-tmase-version: SMEX-14.0.0.3080-8.6.1018-26498.001
x-tm-snts-smtp: 7354288CD7C6D2C729DC74D5C0BA6D8CA02542942A39FCA928EA827D23EC83E22000:8
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EA5A76BCD7DBF408F4BFFA501351190@siemens.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT032:EE_|GV2PR10MB7607:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e2c63a8-e170-468c-ba32-08dab664a23c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	I7A52ZIqhYT+GRoo1LhSlgVaBYjK0Rprt+UEH83uZY9uxr4qmkUwrTzxWKtZZbZFvG4jwTrhubgD5R2Y0QGTk9Dv11TlmxM75zWNMT20QtYshTwH0ImLOhL/qyGy+5YIFmwj25mr4FAl9kxGk3R5KzLnQ1yK9GrWJH9hkIfCZW7TNphm12pPEhEbLh4gSKH62bCJYgZKGqljG4Ylk286+Z1pDlFiPISFwL2tdvSpKv4MvXpjPYIgPOAwetMLnBm/2ia4Zp9iWGJTtdGLSrkwl4yTy4kp55uiyVuYRj+zkI6gPRU4xKeS0B0x7gy9RbFeAsjiiwJ25fhDcNRladQ1fvfCWxEXYplsTtRXV05+i7TE+eEahQiQ/0P0M4Cky7XRAulxdMX2mORG3fh6IO9WIfi8PUfOkyH0DrOg9Yw8Hje1qXaIwjnF0Pg6ghpTfhngQTzQylOClqKK5r+NS4Evi1BA7Ghj7s0iDxT6zZbpSd/g6irgrBC6Qqj/BtHlPS9YaQPOlPoplcLNyQCuWd1+D+/60fbsj3WetRlZN5MFsyTnYbs5mRpIYPI0v4bGrCIwwaRdP8I4ksncyGORUdeDgv+W9FNLxgfv462DcueqLjjxh1saqMRGuS+QmRSCY+TsnWvD/QJsBM2bUaKYO4VcXaQ6/3LlDmiSKGkJSzHG/DNnZWotNPnuMYiVtxurk4A6hCXvF1csFyrxrTULLKMV4bLDCRdejE7OsQfjgRjAPM0HVfwJ8B//n3nzk38QrthJunHWmHpKILYuaaaGB/ev+fbbPx2IdpSniAQXFGu5oC2jVGv1LUb3NHWl7hoEU+qjoE4YkmTEFW/dPws9bbqJYQ==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199015)(46966006)(36840700001)(40470700004)(82960400001)(47076005)(86362001)(356005)(82740400003)(966005)(36756003)(7596003)(36860700001)(4326008)(40480700001)(2616005)(478600001)(41300700001)(110136005)(26005)(336012)(83380400001)(8936002)(4001150100001)(7636003)(82310400005)(70586007)(316002)(956004)(40460700003)(2906002)(107886003)(5660300002)(8676002)(70206006)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 08:40:56.0438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e2c63a8-e170-468c-ba32-08dab664a23c
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT032.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7607
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Oct 2022 08:41:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9817

T24gTW9uLCAyMDIyLTEwLTI0IGF0IDE0OjI3ICswMjAwLCBzdmVuLnNjaHVsdHNjaGlrQHNpZW1l
bnMuY29tIHdyb3RlOg0KPiBGcm9tOiBTdmVuIFNjaHVsdHNjaGlrIDxzdmVuLnNjaHVsdHNjaGlr
QHNpZW1lbnMuY29tPg0KPiANCj4gcHJvdmlkZSBhIHJlY2lwZSB0byBjcmVhdGUgdGhlIEJMMzJf
QVBfTU0uZmQgYmluYXJ5IGJ5IGVkazIgd2hpY2ggaXMgbmVlZGVkIGZvciB0aGUgcWVtdSBvcHRl
ZSBnZW5lcmF0aW9uIGFzIGRlcGVuZGVuY3kuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTdmVuIFNj
aHVsdHNjaGlrIDxzdmVuLnNjaHVsdHNjaGlrQHNpZW1lbnMuY29tPg0KPiAtLS0NCj4gwqByZWNp
cGVzLWJzcC9lZGsyL2VkazJfMjAyMjA1LmJiICAgfCA0MyArKysrKysrKysrKysrKysrKysrKysr
DQo+IMKgcmVjaXBlcy1ic3AvZWRrMi9maWxlcy9ydWxlcy50bXBsIHwgNjEgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKw0KPiDCoDIgZmlsZXMgY2hhbmdlZCwgMTA0IGluc2VydGlvbnMo
KykNCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgcmVjaXBlcy1ic3AvZWRrMi9lZGsyXzIwMjIwNS5i
Yg0KPiDCoGNyZWF0ZSBtb2RlIDEwMDc1NSByZWNpcGVzLWJzcC9lZGsyL2ZpbGVzL3J1bGVzLnRt
cGwNCj4gDQo+IGRpZmYgLS1naXQgYS9yZWNpcGVzLWJzcC9lZGsyL2VkazJfMjAyMjA1LmJiIGIv
cmVjaXBlcy1ic3AvZWRrMi9lZGsyXzIwMjIwNS5iYg0KDQpXaGF0IGFib3V0IHR1cm4gdGhpcyBv
bmUgdG8gYSAuaW5jIHNvIGRvd25zdHJlYW0gY291bGQgZWFzaWx5IGNob29zZQ0KYW5vdGhlciBl
ZGsyIHZlcnNpb24/DQoNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAw
Li4wNTZiNjEyY2UNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9yZWNpcGVzLWJzcC9lZGsyL2Vk
azJfMjAyMjA1LmJiDQo+IEBAIC0wLDAgKzEsNDMgQEANCj4gKyMNCj4gKyMgQ0lQIENvcmUsIGdl
bmVyaWMgcHJvZmlsZQ0KPiArIw0KPiArIyBDb3B5cmlnaHQgKGMpIFNpZW1lbnMgQUcsIDIwMjIN
Cj4gKyMNCj4gKyMgQXV0aG9yczoNCj4gKyMgIFN2ZW4gU2NodWx0c2NoaWsgPHN2ZW4uc2NodWx0
c2NoaWtAc2llbWVucy5jb20+DQo+ICsjDQo+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBN
SVQNCj4gKyMNCj4gKw0KPiArSE9NRVBBR0UgPSAiaHR0cHM6Ly9naXRodWIuY29tL3RpYW5vY29y
ZS9lZGsyIg0KPiArTUFJTlRBSU5FUiA9ICJTdmVuIFNjaHVsdHNjaGlrIDxzdmVuLnNjaHVsdHNj
aGlrQHNpZW1lbnMuY29tPiINCj4gK0xJQ0VOU0UgPSAiQlNELTItQ2xhdXNlLVBhdGVudCINCj4g
Kw0KPiAraW5oZXJpdCBkcGtnDQo+ICsNCj4gK1NSQ19VUkkgPSAiZ2l0c206Ly9naXRodWIuY29t
L3RpYW5vY29yZS9lZGsyLmdpdDticmFuY2g9bWFzdGVyO3Byb3RvY29sPWh0dHBzO2Rlc3RzdWZm
aXg9Z2l0L2VkazI7bmFtZT1lZGsyIFwNCj4gKyAgICBnaXQ6Ly9naXRodWIuY29tL3RpYW5vY29y
ZS9lZGsyLXBsYXRmb3Jtcy5naXQ7cHJvdG9jb2w9aHR0cHM7ZGVzdHN1ZmZpeD1naXQvZWRrMi1w
bGF0Zm9ybXM7bmFtZT1lZGsyLXBsYXRmb3JtcyBcDQo+ICsgICAgZmlsZTovL3J1bGVzLnRtcGwg
XA0KPiArICAgICINCj4gK1NSQ1JFVl9lZGsyID0gImVkazItc3RhYmxlJHtQVn0iDQo+ICtTUkNS
RVZfZWRrMi1wbGF0Zm9ybXMgPSAiM2I4OTZkMWEzMjU2ODZkZTM5NDI3MjNjNDJmMjg2MDkwNDUz
ZTM3YSINCj4gKw0KPiArUyA9ICIke1dPUktESVJ9L2dpdCINCj4gKw0KPiArREVCSUFOX0JVSUxE
X0RFUEVORFMgPSAicHl0aG9uMzpuYXRpdmUsIGRoLXB5dGhvbiwgdXVpZC1kZXY6bmF0aXZlIg0K
PiArDQo+ICtFREsyX0JJTkFSSUVTID89ICJCdWlsZC9NbVN0YW5kYWxvbmVScG1iL1JFTEVBU0Vf
R0NDNS9GVi9CTDMyX0FQX01NLmZkIg0KPiArDQo+ICtCVUlMRF9ERVBFTkRTICAgKz0gIiINCj4g
Kw0KPiArVEVNUExBVEVfRklMRVMgPSAicnVsZXMudG1wbCINCj4gKw0KPiArZG9fcHJlcGFyZV9i
dWlsZCgpIHsNCj4gKyAgICBkZWJfZGViaWFuaXplDQo+ICsNCj4gKyAgICBybSAtZiAke1N9L2Rl
Ymlhbi9lZGsyLmluc3RhbGwNCj4gKyAgICBmb3IgYmluYXJ5IGluICR7RURLMl9CSU5BUklFU307
IGRvDQo+ICsgICAgICAgIGVjaG8gIiRiaW5hcnkgL3Vzci9saWIvZWRrMi8iID4+IFwNCj4gKyAg
ICAgICAgICAgICR7U30vZGViaWFuL2VkazIuaW5zdGFsbA0KPiArICAgIGRvbmUNCj4gK30NCj4g
ZGlmZiAtLWdpdCBhL3JlY2lwZXMtYnNwL2VkazIvZmlsZXMvcnVsZXMudG1wbCBiL3JlY2lwZXMt
YnNwL2VkazIvZmlsZXMvcnVsZXMudG1wbA0KPiBuZXcgZmlsZSBtb2RlIDEwMDc1NQ0KPiBpbmRl
eCAwMDAwMDAwMDAuLjBhMDljNTBlOA0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL3JlY2lwZXMt
YnNwL2VkazIvZmlsZXMvcnVsZXMudG1wbA0KPiBAQCAtMCwwICsxLDYxIEBADQo+ICsjIS91c3Iv
YmluL21ha2UgLWYNCj4gKyMNCj4gKyMgQ29weXJpZ2h0IChjKSBTaWVtZW5zIEFHLCAyMDIyDQo+
ICsjDQo+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBNSVQNCj4gKw0KPiAraWZuZXEgKCQo
REVCX0JVSUxEX0dOVV9UWVBFKSwkKERFQl9IT1NUX0dOVV9UWVBFKSkNCj4gK2V4cG9ydCBDUk9T
U19DT01QSUxFPSQoREVCX0hPU1RfR05VX1RZUEUpLQ0KPiArZW5kaWYNCj4gKw0KPiArZXhwb3J0
IFdPUktTUEFDRT0kKHNoZWxsIHB3ZCkNCj4gK2V4cG9ydCBQQUNLQUdFU19QQVRIPSQoV09SS1NQ
QUNFKS9lZGsyOiQoV09SS1NQQUNFKS9lZGsyLXBsYXRmb3Jtcw0KPiArZXhwb3J0IEFDVElWRV9Q
TEFURk9STT0iUGxhdGZvcm0vU3RhbmRhbG9uZU1tL1BsYXRmb3JtU3RhbmRhbG9uZU1tUGtnL1Bs
YXRmb3JtU3RhbmRhbG9uZU1tUnBtYi5kc2MiDQo+ICsNCj4gKyMgaHR0cHM6Ly9naXRodWIuY29t
L3RpYW5vY29yZS9lZGsyLXBsYXRmb3Jtcy9ibG9iL21hc3Rlci9SZWFkbWUubWQjaWYtY3Jvc3Mt
Y29tcGlsaW5nDQo+ICtpZmVxIChhcm02NCwkKERFQl9UQVJHRVRfQVJDSCkpDQo+ICtleHBvcnQg
VEFSR0VUX0FSQ0ggPSAnQUFSQ0g2NCcNCj4gK2Vsc2UgaWZlcSAoKGFybWhmLCQoREVCX1RBUkdF
VF9BUkNIKSkNCj4gK2V4cG9ydCBUQVJHRVRfQVJDSCA9ICdBUk0nDQo+ICtlbHNlIGlmZXEgKChh
bWQ2NCwkKERFQl9UQVJHRVRfQVJDSCkpDQo+ICtleHBvcnQgVEFSR0VUX0FSQ0ggPSAnWDY0Jw0K
PiArZWxzZSBpZmVxICgoaTM4NiwkKERFQl9UQVJHRVRfQVJDSCkpDQo+ICtleHBvcnQgVEFSR0VU
X0FSQ0ggPSAnSUEzMicNCj4gK2Vsc2UNCj4gKyQoZXJyb3IgREVCX1RBUkdFVF9BUkNIICQoREVC
X1RBUkdFVF9BUkNIKSB1bnN1cHBvcnRlZCkNCj4gK2VuZGlmDQo+ICsjIFdoZW4gY3Jvc3MtY29t
cGlsaW5nLCBvciBidWlsZGluZyB3aXRoIGEgZGlmZmVyZW50IHZlcnNpb24gb2YgdGhlIGNvbXBp
bGVyIHRoYW4NCj4gKyMgdGhlIGRlZmF1bHQgYGdjY2AsIHdlIGFkZGl0aW9uYWxseSBuZWVkIHRv
IGluZm9ybSB0aGUNCj4gKyMgYnVpbGQgY29tbWFuZCB3aGljaCB0b29sY2hhaW4gdG8gdXNlLiBX
ZSBkbyB0aGlzIGJ5IHNldHRpbmcgdGhlIGVudmlyb25tZW50DQo+ICsjIHZhcmlhYmxlIGB7VE9P
TF9DSEFJTl9UQUd9X3tUQVJHRVRfQVJDSH1fUFJFRklYYCAtIGluIHRoZSBjYXNlIGFib3ZlLA0K
PiArIyAqKkdDQzVfQUFSQ0g2NF9QUkVGSVgqKi4NCj4gKyMgZXhwb3J0IEdDQzVfQUFSQ0g2NF9Q
UkVGSVg9YWFyY2g2NC1saW51eC1nbnUtDQo+ICsjIHVzaW5nIGV4cG9ydCBoZXJlIGF0IFRPUCBM
ZXZlbCBkb2VzIG5vdCB3b3JrLCBiZWNhdXNlDQo+ICsjIEdDQzVfJChUQVJHRVRfQVJDSClfUFJF
RklYIGdldHMgZGVsZXRlZCBhZ2FpbiBmb3Igd2hhdCByZWFzb24gZXZlcg0KPiArIyBUaGVyZWZv
cmUgaXQgaXMgc2V0IHJpZ2h0IGJlZm9yZSB0aGUgYnVpbGQgY29tbWFuZA0KPiArIyBleHBvcnQg
R0NDNV8kKFRBUkdFVF9BUkNIKV9QUkVGSVg9JChERUJfSE9TVF9HTlVfVFlQRSktDQo+ICsNCj4g
Kw0KPiArZXhwb3J0IFNIRUxMPS9iaW4vYmFzaA0KPiArDQo+ICsjIEVOViBWYXJzIHdoaWNoIHNo
b3VsZCBnZXQgc2V0IGJ5IGVka3NldHVwLnNoDQo+ICtleHBvcnQgUFlUSE9OX0NPTU1BTkQ9cHl0
aG9uMw0KPiArZXhwb3J0IFBZVEhPTkhBU0hTRUVEPTENCj4gK2V4cG9ydCBDT05GX1BBVEg9JChX
T1JLU1BBQ0UpL2VkazIvQ29uZg0KPiArZXhwb3J0IEVES19UT09MU19QQVRIPSQoV09SS1NQQUNF
KS9lZGsyL0Jhc2VUb29scw0KPiArZXhwb3J0IFBBVEg9JChXT1JLU1BBQ0UpL2VkazIvQmFzZVRv
b2xzL0Jpbi9MaW51eC0kKFRBUkdFVF9BUkNIKTokKFdPUktTUEFDRSkvZWRrMi9CYXNlVG9vbHMv
QmluV3JhcHBlcnMvUG9zaXhMaWtlOjovdXNyL2xvY2FsL3NiaW46L3Vzci9sb2NhbC9iaW46L3Vz
ci9zYmluOi91c3IvYmluOi9zYmluOi9iaW4NCj4gKw0KPiArb3ZlcnJpZGVfZGhfYXV0b19idWls
ZDoNCj4gKwlzb3VyY2UgZWRrMi9lZGtzZXR1cC5zaCAtLXJlY29uZmlnDQo+ICsNCj4gKwlDRkxB
R1M9IExERkxBR1M9ICBtYWtlIC1DIGVkazIvQmFzZVRvb2xzDQo+ICsNCj4gKwkoZXhwb3J0IEdD
QzVfJChUQVJHRVRfQVJDSClfUFJFRklYPSQoREVCX0hPU1RfR05VX1RZUEUpLSAmJiBcDQo+ICsJ
CWJ1aWxkIC1wICQoQUNUSVZFX1BMQVRGT1JNKSAtYiBSRUxFQVNFIC1hICQoVEFSR0VUX0FSQ0gp
IC10IEdDQzUgLW4gJChzaGVsbCBucHJvYykpDQo+ICsNCj4gK292ZXJyaWRlX2RoX2F1dG9faW5z
dGFsbDoNCj4gKw0KPiArb3ZlcnJpZGVfZGhfYXV0b190ZXN0Og0KPiArDQo+ICslOg0KPiArCWRo
ICRAIC0td2l0aCBweXRob24zIC0tbm8tcGFyYWxsZWwNCg0K

