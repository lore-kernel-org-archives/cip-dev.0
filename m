Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D895BC636D4
	for <webhook@archiver.kernel.org>; Wed, 15 Feb 2023 09:37:25 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.45])
 by mx.groups.io with SMTP id smtpd.web10.11311.1676453082779610013
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Feb 2023 01:24:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kcYfLac9;
 spf=pass (domain: siemens.com, ip: 40.107.14.45, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a70R2leRyEbhHbLLxsM9AQP/yu/c8AUvCQJzaisLWyV0PM07Xp4Blkau1FwJ7RbujYCp+/yJL5TPBqIB8tGPfD2LDoQcI0HZmx2QnLv44x2TAeirkINOPoqhEwHY/GLiSXfvX5ARWazsNf8OOuqfye4D38vk8uLlFasaSDJWksM3PjpWUg/cYYfXE6vW9d59nlGL0YQJFsURrzRZ7DXlpexUayqB9/sAiDZX/U7YcjjQ6Q/o/op8S01t1s5WTOAvkLCvaSV0cB+7A4kaJYDvM/Iwm+5hcrQ1rJiLTqrlcKlJSNASSXRP2EYhMO6x6JAgUS69oUX/Bu6X1XccmTZfog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNpLtm3gNGECw01zcyuXpQF4zEVTi6aPCDs8z7TZhsQ=;
 b=QEYVkHGanr/IlZQVVJsubgQaeEiUn800uVgGf90F2E8U9NZawpEs5WZUswVFKylNfJeZYpcrEAIIQ00zezTPseKb3PwwUxGBcSGFRdgY2bDPixURO1x/lKInGutPucK42M++TKYh9fncOD/UrS3u6/+Xnm0NGpvS0Mqd2ppJCvCk3EEmbLm7SCyGBEazf5KW0ul0A6WBH65C0gPvhwpQgtuS47oDgzwaSgU9h2RQzYs8f/S5P0UyC/ZSYpiXQuLuCgtziBb2Bs8zCCLyDkMaohhchaVUD6+Qt342ytXIUdvJ1yv919CSXTvOuMa4npOy+oOPXhm3nIRDzEsR/k3v5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNpLtm3gNGECw01zcyuXpQF4zEVTi6aPCDs8z7TZhsQ=;
 b=kcYfLac9dz7fIyvg9+ONJ+5JWGyn34adsg1pUc64ibkkXLiCNNXA98SYL403jvaIruJ2rKjDVF5cgoOB3Mpkm/Aijr+ZCZPDErBpsvuIrDdK6a6ezN+yp+rquCX28AysRvwnR6EvedCWfIM9/pEKbs0dezyS8OxPe/6kc29afTbJi+s5md7/5fieMzIqGCLvak8DiOSQNfmGmZa3s7EQEJNbvN3IVStBSNJ+SWVKrt5mXtPwZ34yDr5NVRFW/bviF5XYETih3LlgLai0h7HsyFLPBPelj7D/UVAOE38plQpVvJxEnMk9tEZWIz8tq8wIb1Q3rSRG0BAwJUD8LTckgg==
Received: from DUZPR01CA0060.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::18) by DU0PR10MB7073.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:420::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 09:24:38 +0000
Received: from DB5EUR01FT013.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:469:cafe::b2) by DUZPR01CA0060.outlook.office365.com
 (2603:10a6:10:469::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Wed, 15 Feb 2023 09:24:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 DB5EUR01FT013.mail.protection.outlook.com (10.152.4.239) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24 via Frontend Transport; Wed, 15 Feb 2023 09:24:38 +0000
Received: from CNPEK01M03MSX.ad011.siemens.net (139.24.237.220) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1118.21; Wed, 15 Feb 2023 10:24:37 +0100
Received: from CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) by
 CNPEK01M03MSX.ad011.siemens.net (139.24.237.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 15 Feb 2023 17:24:35 +0800
Received: from CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) by
 CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) with mapi id
 15.01.2507.017; Wed, 15 Feb 2023 17:24:35 +0800
From: "Moessbauer, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
CC: "Schmidt, Adriaan" <adriaan.schmidt@siemens.com>, "Gylstorff, Quirin"
	<quirin.gylstorff@siemens.com>
Subject: Re: [isar-cip-core][PATCH v4 2/8] refactor: use imagetypes for swu generation
Thread-Topic: [isar-cip-core][PATCH v4 2/8] refactor: use imagetypes for swu
 generation
Thread-Index: AQHZPrv2aX6VlpVBKESjeBCORJb0Aq7Me+4AgACzgoCAAFYiAIABtXkA
Date: Wed, 15 Feb 2023 09:24:35 +0000
Message-ID: <6aba9d52586d1cb4cd303aa63bf2dfcc1f7e3adf.camel@siemens.com>
References: <20230212082758.1166262-1-felix.moessbauer@siemens.com>
	 <20230212082758.1166262-3-felix.moessbauer@siemens.com>
	 <3dbb9c71-f5bf-56e4-6f9c-66e6d42f9049@siemens.com>
	 <e06cb90bf0652ea1035149cbf8d30c7dcbaba314.camel@siemens.com>
	 <49e13754-7e50-7bd3-e2a0-c19f6bf31bfc@siemens.com>
In-Reply-To: <49e13754-7e50-7bd3-e2a0-c19f6bf31bfc@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1+deb11u1 
x-originating-ip: [139.24.236.148]
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT013:EE_|DU0PR10MB7073:EE_
X-MS-Office365-Filtering-Correlation-Id: 7183f86e-4a07-4984-7611-08db0f367602
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ZnTyn0s09+LPd00OKkjChbJ3HxjP86GTUswoq+IqFz2w/LHv+X8YdrI29kBV6uGBNLitlGSpdtthqHomjQsVRRBcVs5d3EtEo9ravSkWr4TciZtNRnMEkDRvdEq6OsoBbglDpkUbLlktyLFFIzYtlQ5WrgOWH/KKp+oQRzaE0HiqKvCOZwk4lvCDKbmYHFFgod39CNXO9hdN75n2C+zMYZYQyQ03GSz758CGMB1EuwU088VWKzXzicYVPmVjqm4abcYXTy3hI4EKzFhW4Zx2EO085wQqKI9lPjQGUSVc7b3InpYMpgHZARo8jVBOgr1FVOYnvyUVzIwT6ppwArsFc4IfbbwT81wea7+7JUsfsvw7vbAueZTtBaXL+S95eUlxFqSgyPnMc1ovJH219yop8tWoAcrlRJv/CSnOi7lLBdeY+gKckVlXbYxay/9nKFSFZs5AGV5PyhAfZ61QyM++C1vJ29tp3ZJDALwGubM2DmLssanzB2TbCYkvDPMS+QCL7gHMiwrdNnkQcR186EDGnckSXMeEMNH/lUdFFg9JzuD+SgJYaXWQFGy0UXbIDJwQdVMmmmJk6iUH0hkrEwJkH39eXDS9qrm3U5AnWyXpKvx2rG6VyG3jUEMaRgrdJM8CZZtd+vhSZfh0W/Kg6FtJGNP/Lr2+s6NGWHhH3Aui+sp+Z0bVYtoVFRiRV9/y7a4O92O/QO6mdM4TYKuKx66Z1eB5bjpNAaP0ohn1eHiEW9w=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(316002)(53546011)(41300700001)(70586007)(26005)(40480700001)(66899018)(186003)(70206006)(8676002)(5660300002)(8936002)(54906003)(4326008)(6636002)(110136005)(478600001)(336012)(36756003)(40460700003)(36860700001)(956004)(2616005)(107886003)(86362001)(2906002)(47076005)(83380400001)(82740400003)(7596003)(82960400001)(356005)(7636003)(82310400005)(403724002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 09:24:38.2611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7183f86e-4a07-4984-7611-08db0f367602
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT013.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7073
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <5640A98A4777AE45A9DAA2C2025EF89D@siemens.com>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Feb 2023 09:37:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10699

T24gVHVlLCAyMDIzLTAyLTE0IGF0IDA4OjE4ICswMTAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAxNC4wMi4yMyAwMzoxMCwgTW9lc3NiYXVlciwgRmVsaXggKFQgQ0VEIElOVy1DTikgd3JvdGU6
DQo+ID4gT24gTW9uLCAyMDIzLTAyLTEzIGF0IDE2OjI4ICswMTAwLCBKYW4gS2lzemthIHdyb3Rl
Og0KPiA+ID4gT24gMTIuMDIuMjMgMDk6MjcsIEZlbGl4IE1vZXNzYmF1ZXIgd3JvdGU6DQo+ID4g
PiA+IFRoaXMgcGF0Y2ggcmV3b3JrcyB0aGUgaW1wbGVtZW50YXRpb24gb2YgdGhlIHN3dXBkYXRl
IHR5cGUuDQo+ID4gPiA+IEFsbCBnZW5lcmljIGFzcGVjdHMgYXJlIG1vdmVkIGZyb20gdGhlIHN3
dXBkYXRlLmluYyBmaWxlIGludG8NCj4gPiA+ID4gdGhlDQo+ID4gPiA+IHN3dXBkYXRlIGNsYXNz
IGFuZCBtYWRlIGNvbmRpdGlvbmFsIG9uIHRoZSBzd3UgdHlwZS4NCj4gPiA+ID4gVGhlIHN3LWRl
c2NyaXB0aW9uIGZpbGUgaXMgbm93IHJlZmVyZW5jZWQgdXNpbmcgdGhlIGltYWdlLXR5cGUNCj4g
PiA+ID4gaW5mcmFzdHJ1Y3R1cmUsIHdoaWNoIGF2b2lkcyBtYW51YWwgYWRkaXRpb25zIHRvDQo+
ID4gPiA+IEZJTEVTRVhUUkFQQVRIUw0KPiA+ID4gPiBhbmQNCj4gPiA+ID4gYWNjaWRlbnRhbCBv
dmVyd3JpdGVzIG9mIFNSQ19VUkkuIFRoZSB0ZW1wbGF0aW5nIGxvZ2ljIGlzIG1vdmVkDQo+ID4g
PiA+IGludG8gdGhlDQo+ID4gPiA+IGdlbmVyaWMgb25lIHByb3ZpZGVkIGJ5IGltYWdldHlwZXMu
DQo+ID4gPiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBGZWxpeCBNb2Vzc2JhdWVyIDxmZWxp
eC5tb2Vzc2JhdWVyQHNpZW1lbnMuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gwqBjbGFzc2Vz
L3N3dXBkYXRlLmJiY2xhc3PCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfCAyNg0KPiA+ID4gPiArKysrKysrKysrKystLS0NCj4gPiA+ID4gLS0tLQ0KPiA+ID4gPiDC
oGthcy9vcHQvc3d1cGRhdGUueW1swqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfMKgIDUgKy0tLQ0KPiA+ID4gPiDCoC4uLi9pbWFnZXMve2ZpbGVzID0+
IHN3dX0vc3ctZGVzY3JpcHRpb24udG1wbCB8wqAgMA0KPiA+ID4gPiDCoHJlY2lwZXMtY29yZS9p
bWFnZXMvc3d1cGRhdGUuaW5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxNSAtLS0tLS0t
LS0tLQ0KPiA+ID4gPiDCoDQgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMjggZGVs
ZXRpb25zKC0pDQo+ID4gPiA+IMKgcmVuYW1lIHJlY2lwZXMtY29yZS9pbWFnZXMve2ZpbGVzID0+
IHN3dX0vc3ctZGVzY3JpcHRpb24udG1wbA0KPiA+ID4gPiAoMTAwJSkNCj4gPiA+ID4gDQo+ID4g
PiA+IGRpZmYgLS1naXQgYS9jbGFzc2VzL3N3dXBkYXRlLmJiY2xhc3MNCj4gPiA+ID4gYi9jbGFz
c2VzL3N3dXBkYXRlLmJiY2xhc3MNCj4gPiA+ID4gaW5kZXggNWViNDkzNi4uOTY2ZjdjMCAxMDA2
NDQNCj4gPiA+ID4gLS0tIGEvY2xhc3Nlcy9zd3VwZGF0ZS5iYmNsYXNzDQo+ID4gPiA+ICsrKyBi
L2NsYXNzZXMvc3d1cGRhdGUuYmJjbGFzcw0KPiA+ID4gPiBAQCAtOCwyMyArOCwzMyBAQA0KPiA+
ID4gPiDCoCPCoCBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29t
Pg0KPiA+ID4gPiDCoCMNCj4gPiA+ID4gwqAjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBNSVQN
Cj4gPiA+ID4gK1JPT1RGU19QQVJUSVRJT05fTkFNRSA/PSAiJHtJTUFHRV9GVUxMTkFNRX0ud2lj
LnA0Lmd6Ig0KPiA+ID4gPiANCj4gPiA+ID4gwqBTV1VfSU1BR0VfRklMRSA/PSAiJHtERVBMT1lf
RElSX0lNQUdFfS8ke1BOfS0ke0RJU1RST30tDQo+ID4gPiA+ICR7TUFDSElORX0uc3d1Ig0KPiA+
ID4gPiDCoFNXVV9ERVNDUklQVElPTl9GSUxFID89ICJzdy1kZXNjcmlwdGlvbiINCj4gPiA+ID4g
LVNXVV9BRERJVElPTkFMX0ZJTEVTID89ICIiDQo+ID4gPiA+ICtTV1VfQURESVRJT05BTF9GSUxF
UyA/PSAibGludXguZWZpICR7Uk9PVEZTX1BBUlRJVElPTl9OQU1FfSINCj4gPiA+ID4gwqBTV1Vf
U0lHTkVEID89ICIiDQo+ID4gPiA+IMKgU1dVX1NJR05BVFVSRV9FWFQgPz0gInNpZyINCj4gPiA+
ID4gwqBTV1VfU0lHTkFUVVJFX1RZUEUgPz0gInJzYSINCj4gPiA+ID4gDQo+ID4gPiA+IMKgQlVJ
TERDSFJPT1RfSU1BR0VfRklMRSA/PQ0KPiA+ID4gPiAiJHtQUF9ERVBMT1l9LyR7QG9zLnBhdGgu
YmFzZW5hbWUoZC5nZXRWYXIoJ1NXVV9JTUFHRV9GSUxFJykpfSINCj4gPiA+ID4gDQo+ID4gPiA+
IC1JTUFHRVJfSU5TVEFMTCArPSAiY3BpbyINCj4gPiA+ID4gLUlNQUdFUl9JTlNUQUxMICs9ICIk
e0Anb3BlbnNzbCcgaWYNCj4gPiA+ID4gYmIudXRpbHMudG9fYm9vbGVhbihkLmdldFZhcignU1dV
X1NJR05FRCcpKSBlbHNlICcnfSINCj4gPiA+ID4gK0lNQUdFX1RZUEVERVA6d2ljICs9ICJzcXVh
c2hmcyINCj4gPiA+ID4gK0lNQUdFX1RZUEVERVA6c3d1ID0gIndpYyINCj4gPiA+ID4gK0lNQUdF
Ul9JTlNUQUxMOnN3dSArPSAiY3BpbyAke0Anb3BlbnNzbCcgaWYNCj4gPiA+ID4gYmIudXRpbHMu
dG9fYm9vbGVhbihkLmdldFZhcignU1dVX1NJR05FRCcpKSBlbHNlICcnfSINCj4gPiA+ID4gDQo+
ID4gPiA+IC1kb19zd3VwZGF0ZV9iaW5hcnlbc3RhbXAtZXh0cmEtaW5mb10gPSAiJHtESVNUUk99
LSR7TUFDSElORX0iDQo+ID4gPiA+IC1kb19zd3VwZGF0ZV9iaW5hcnlbY2xlYW5kaXJzXSArPSAi
JHtXT1JLRElSfS9zd3UiDQo+ID4gPiA+IC1kb19zd3VwZGF0ZV9iaW5hcnlbbmV0d29ya10gPSAi
JHtUQVNLX1VTRV9TVURPfSINCj4gPiA+ID4gLWRvX3N3dXBkYXRlX2JpbmFyeSgpIHsNCj4gPiA+
ID4gK0lNQUdFX1NSQ19VUkk6c3d1ID0gImZpbGU6Ly8ke1NXVV9ERVNDUklQVElPTl9GSUxFfS50
bXBsIg0KPiA+ID4gPiArSU1BR0VfVEVNUExBVEVfRklMRVM6c3d1ID0gIiR7U1dVX0RFU0NSSVBU
SU9OX0ZJTEV9LnRtcGwiDQo+ID4gPiA+ICtJTUFHRV9URU1QTEFURV9WQVJTOnN3dSA9ICJST09U
RlNfUEFSVElUSU9OX05BTUUNCj4gPiA+ID4gVEFSR0VUX0lNQUdFX1VVSUQNCj4gPiA+ID4gQUJS
T09URlNfUEFSVF9VVUlEX0EgQUJST09URlNfUEFSVF9VVUlEX0IiDQo+ID4gPiA+ICsNCj4gPiA+
ID4gKyMgVGhpcyBpbWFnZXR5cGUgaXMgbmVpdGhlciBtYWNoaW5lIG5vciBkaXN0cm8gc3BlY2lm
aWMuDQo+ID4gPiA+IEhlbmNlLCB3ZQ0KPiA+ID4gPiBjYW5ub3QNCj4gPiA+ID4gKyMgdXNlIHBh
dGhzIGluIEZJTEVTT1ZFUlJJREVTLiBNYW51YWwgbW9kaWZpY2F0aW9ucyBvZiB0aGlzDQo+ID4g
PiA+IHZhcmlhYmxlIGFyZQ0KPiA+ID4gPiArIyBkaXNjb3VyYWRnZWQgYW5kIGhhcmQgdG8gaW1w
bGVtZW50LiBJbnN0ZWFkLCB3ZSByZWdpc3Rlcg0KPiA+ID4gPiB0aGlzDQo+ID4gPiA+IHBhdGgg
ZXhwbGljaXRseQ0KPiA+ID4gPiArRklMRVNFWFRSQVBBVEhTOnByZXBlbmQgPSAiJHtMQVlFUkRJ
Ul9jaXAtY29yZX0vcmVjaXBlcy0NCj4gPiA+ID4gY29yZS9pbWFnZXMvc3d1OiINCj4gPiA+IA0K
PiA+ID4gVGhpcyBtZWFucyBkb3duc3RyZWFtIGxheWVycyB3YW50aW5nIHRvIG92ZXJsb2FkIHRo
ZSBzdy0NCj4gPiA+IGRlc2NyaXB0aW9uLnRtcGwNCj4gPiA+IG5vdyBuZWVkIHRvIHJlZ2lzdGVy
IHRoZWlyIG93biBGSUxFU0VYVFJBUEFUSFM/IFRoYXQgYXQgbGVhc3QNCj4gPiA+IHJlcXVpcmVz
DQo+ID4gPiBkb2N1bWVudGF0aW9uLiBPciBjYW4gd2UgYWxzbyBkcm9wIExBWUVSRElSX2NpcC1j
b3JlIGhlcmUsIGFuZCBpdA0KPiA+ID4gd291bGQNCj4gPiA+IHN0aWxsIHdvcms/DQo+ID4gDQo+
ID4gVGhhdCBpcyBleGFjdGx5IGFzIGl0IGFsd2F5cyBoYXMgYmVlbi4gQnV0IGRvd25zdHJlYW0g
bGF5ZXIgaGF2ZSB0bw0KPiA+IGFkZA0KPiA+IGl0IG9ubHkgaWYgdGhleSBvdmVycmlkZSB0aGUg
U1dVX0RFU0NSSVBUSU9OX0ZJTEUuIElNSE8gdGhpcyBpcw0KPiA+IHJlYXNvbmFibGUuIEkgaGln
aGx5IHZvdGUgZm9yIGtlZXBpbmcgaXQgbGlrZSB0aGF0LCBhcyB0aGVzZSBraW5kDQo+ID4gb2YN
Cj4gPiB0aGluZ3MgYml0ZSB1cyBhZ2FpbiBhbmQgYWdhaW4gd2l0aCBlYWNoIGJpdGJha2UgdXBk
YXRlLg0KPiA+IA0KPiANCj4gSWYgSSB3cml0ZQ0KPiANCj4gW215LWltYWdlLmJiXQ0KPiBpbmhl
cml0IHN3dXBkYXRlDQo+IA0KPiBhbmQgcGxhY2UgYW4gb3duIHN3LWRlc2NyaXB0aW9uLnRtcGwg
aW4gbXkgb3duIGZpbGVzLyBmb2xkZXIsIHdpbGwNCj4gdGhhdA0KPiBiZSBwaWNrZWQgKGFzIHRv
IGJlIG5hdHVyYWxseSBleHBlY3RlZCkgb3IgdGhlIG9uZSBmcm9tIGNpcC1jb3JlPw0KDQpUaGlz
IHdpbGwgbm90IGJlIHBpY2tlZCB1cCwgYXMgdGhlIGNpcC1jb3JlIHBhdGggaXMgcHJlcGVuZGVk
Lg0KVGhpcyBpcyBpbmRlZWQgbm90IGlkZWFsLiBXZSBiZXR0ZXIgYXBwZW5kIHRoZSBwYXRoLCBz
byBsb2NhbCBmaWxlcw0KYWx3YXlzIGFyZSBwcmVmZXJyZWQuDQoNCldpbGwgY2hhbmdlIGl0IGlu
IHRoZSBuZXh0IHJldmlzaW9uLg0KDQpGZWxpeA0KDQoNCj4gDQo+IEphbg0KPiANCg0K

