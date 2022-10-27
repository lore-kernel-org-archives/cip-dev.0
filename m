Return-Path: <baocheng.su@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309C5C38A2D
	for <webhook@archiver.kernel.org>; Thu, 27 Oct 2022 01:39:56 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.47])
 by mx.groups.io with SMTP id smtpd.web11.1834.1666834791846723441
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Oct 2022 18:39:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=swDbCHh4;
 spf=pass (domain: siemens.com, ip: 40.107.14.47, mailfrom: baocheng.su@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFvWhXT8q/uvT2Nk2ejiZBXJZsL2BaHIx01AbBQhaqMrX2uxkHVUn8+zpnOtMFDIM4ODppNAG0wjMHhvOvvjqmBxza7OKQ3o5OaTv4T73+Pb4eEaeKXwxJnxjdKTvCMlXbE6iNtPXtc8A1dkH2aBZERf8ENxe2DIF997Zj+wbsBh6X1xXf1gmAgaSer27E/Fzd5mIivg+2Gaef5ix59+e4NVc0+1mccakyDMa16D/KOVGGsKzuR+izkEWm6LPGK+de/zIrhqxQ3+RzSHKuepEPtoyI7mMq73XYqV9va1aIg7+JnkP9W8i3oWVAkKFWPSToI/2WvjP4pg/juGnHPdyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RW72+h4/covwyKR5Ke/+Gb+bmyG8e5CvJleL2IkKE4=;
 b=aWFA/dkpy5dybFkKAXtWVaZ5LOpNRta/SpfkbOfrfon36I6onbPZdcT8paRHrbhLYjPV15DZDJZUZ1ZnYQ6CmwU7mkn5F8WoKvJcEN56LfIo2Ix4fcLO8sqbPOoMLijHe+7VvMfGK65U3Hg3xKQVj8Hj6mSyIwzMxT8NoH0bK7EPG4y6dyqXiV6oYxqsU8LrX1yp+kwOiEsb2t05E89l6X+CRmzmph/yE9CSP2bkucxYeAH+B/sGoYOxxhLQRVN/+EtOGMplM7FWw7nKt3lQZBNMkTaqtQ2kXBI3uX2utfw9o3W06IMH3nsIm5lxdcVCTy+jEI+tzBsK6N+wsUtcAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RW72+h4/covwyKR5Ke/+Gb+bmyG8e5CvJleL2IkKE4=;
 b=swDbCHh4Z8k2Ym4kxAyhit00pj/nbldy9oY6s8thex9Fc2yWL3S2FcyHHlj7c4l1j7lTgyRM1hokFryrqlscYMLETns+dydQmbzffUFJh+lHp+EU7xLqvHEwaclaBFE2yyT+/ySj7S3ty+B6G2uzgupi4espsDEbIlEn6T84pbmMl+zYut+w0gl0o2SPxsH39hOUXLIq+zj92xQzk52MNW9FJRVQ/CXH5XaLePuX8y3eAqSHjHtpcj0Qu+p9mrZnkCCk1iixeuqsRRTB77KTMX7eGIMN3UHDFQIgn3qu7RejPHnOaQqOTx6BbVjhOVuMTqP1kIGA6MV3YZk+NB9M/g==
Received: from GV3P280CA0078.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:a::26) by
 GV2PR10MB6576.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b1::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.23; Thu, 27 Oct 2022 01:39:48 +0000
Received: from HE1EUR01FT020.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:a:cafe::be) by GV3P280CA0078.outlook.office365.com
 (2603:10a6:150:a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.29 via Frontend
 Transport; Thu, 27 Oct 2022 01:39:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 HE1EUR01FT020.mail.protection.outlook.com (10.152.0.171) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.14 via Frontend Transport; Thu, 27 Oct 2022 01:39:47 +0000
Received: from CNPEK01M10MSX.ad011.siemens.net (139.24.237.228) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1118.15; Thu, 27 Oct 2022 03:39:46 +0200
Received: from CNPEK01M06MSX.ad011.siemens.net (139.24.237.223) by
 CNPEK01M10MSX.ad011.siemens.net (139.24.237.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.13; Thu, 27 Oct 2022 09:39:43 +0800
Received: from CNPEK01M06MSX.ad011.siemens.net ([139.24.237.223]) by
 CNPEK01M06MSX.ad011.siemens.net ([139.24.237.223]) with mapi id
 15.01.2507.013; Thu, 27 Oct 2022 09:39:43 +0800
From: "Su, Bao Cheng" <baocheng.su@siemens.com>
To: "Schultschik, Sven" <sven.schultschik@siemens.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: Re: AW: [isar-cip-core][PATCH 1/8] add recipe for edk2
Thread-Topic: AW: [isar-cip-core][PATCH 1/8] add recipe for edk2
Thread-Index: AQHY6EleXfbDKuaNBUyVXbAuNYr+Y64eP12AgAH8ywCAALcdgA==
Date: Thu, 27 Oct 2022 01:39:42 +0000
Message-ID: <2b44a657cd32ba83a1427ed32090ac71da3fad5e.camel@siemens.com>
References: <20221024122725.383791-1-sven.schultschik@siemens.com>
	 <20221024122725.383791-2-sven.schultschik@siemens.com>
	 <677bccb9114b709612cfd7b404fecc4d0e8d8b56.camel@siemens.com>
	 <PAXPR10MB50374CAB4D5D604A25B7003190309@PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <PAXPR10MB50374CAB4D5D604A25B7003190309@PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1 
x-originating-ip: [140.231.151.93]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2942B1946B17D242B6AB0F653645110B@siemens.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT020:EE_|GV2PR10MB6576:EE_
X-MS-Office365-Filtering-Correlation-Id: 330b6daf-7f5f-419a-1b1f-08dab7bc21f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	iz0/72j4Rjp5qRMv7GvyhGWZncomiiacGmgXqCYiWPsLyvp3ahf9lo83S/DyH9xnb3g3Ta35pG3tOd3/pVYqRBwHWhxByz881mET0mwMavLKxHLH4Z+Y/hlqTT5HM+h4qZ4eOgIHznzSGtBmYO5Soc/Z6ohd+mY9uNq0yk+SBAxwIFV6F9JtP7Apx3/oSgpSoRHULBwLIaNHrgYGjLXB9bGwlw9NFBpoUAD1EOF9d8AttnnyhenFyyydguY6N2nIcjgdp0G9rU0bjEGC16kULWipt4BlacH0FP8k+Krk+ppEnE5WEusAGz4oDY672gUyKBxECfJXAJp1s0zYX060vaU8mXz98SjwrCmPKvSnwoYLsjxcspSMaeEJ9DlyH5JmbwfYzorUwpuuEmK/WBPHNTrUKb9OW34QTJOjz252c6P2J8w25uweBs3ovHzikeMbsPIvScWy5QBK5lP9GQKT16TebGhz9BJYLffivxFg1HdT7wvaQmOPfuZpbwvdljokwK4eyV/xuMpRiMj7yEAa915tMvdAS6dWstpmeVpmnyqVufAEcU5bG5PzddEsKyqt8pyyj63ybAE+7hFG+4HP6rXoD/6031eRaqs2NQls2WN/DcbDsmPKkDD6NjC+auiWYq68RXicdat9ZI6UiAurMKlP0Uc42Na9uQ1D/owxacX8u/U8rPKlIZQ1lD45ApZokxQ66mDaDCOtPTLmK5lkfEaQDNNV0Gfb/mWNhjsngYfOBXdc6UnlsYebFuaDwo1RAvQTiV2cRgfabQoIptByLhtCh1KwhUFOo0adhNMX6juQJgGpX6lUfjFiAQqiXYnlZ6cckDYjJsihGVHryvbJUQ==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199015)(46966006)(36840700001)(40470700004)(316002)(40460700003)(66574015)(41300700001)(107886003)(82310400005)(110136005)(8676002)(966005)(336012)(4001150100001)(4326008)(70206006)(82740400003)(70586007)(8936002)(956004)(36860700001)(82960400001)(2616005)(26005)(2906002)(356005)(7636003)(47076005)(7596003)(40480700001)(36756003)(5660300002)(86362001)(478600001)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 01:39:47.6436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 330b6daf-7f5f-419a-1b1f-08dab7bc21f1
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT020.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6576
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Oct 2022 01:39:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9875

T24gV2VkLCAyMDIyLTEwLTI2IGF0IDE0OjQ0ICswMDAwLCBTY2h1bHRzY2hpaywgU3ZlbiAoREkg
UEEgRENQIFImRCAyKQ0Kd3JvdGU6DQo+IA0KPiA+IC0tLS0tVXJzcHLDvG5nbGljaGUgTmFjaHJp
Y2h0LS0tLS0NCj4gPiBWb246IFN1LCBCYW8gQ2hlbmcgKERJIEZBIENUUiBJUEMgQ04gUFJDNCkg
PGJhb2NoZW5nLnN1QHNpZW1lbnMuY29tPg0KPiA+IEdlc2VuZGV0OiBEaWVuc3RhZywgMjUuIE9r
dG9iZXIgMjAyMiAxMDoyMw0KPiA+IEFuOiBTY2h1bHRzY2hpaywgU3ZlbiAoREkgUEEgRENQIFIm
RCAyKSA8c3Zlbi5zY2h1bHRzY2hpa0BzaWVtZW5zLmNvbT47DQo+IGNpcC0NCj4gPiBkZXZAbGlz
dHMuY2lwLXByb2plY3Qub3JnDQo+ID4gQ2M6IEtpc3prYSwgSmFuIChUIENFRCkgPGphbi5raXN6
a2FAc2llbWVucy5jb20+DQo+ID4gQmV0cmVmZjogUmU6IFtpc2FyLWNpcC1jb3JlXVtQQVRDSCAx
LzhdIGFkZCByZWNpcGUgZm9yIGVkazINCj4gPiANCj4gPiBPbiBNb24sIDIwMjItMTAtMjQgYXQg
MTQ6MjcgKzAyMDAsIHN2ZW4uc2NodWx0c2NoaWtAc2llbWVucy5jb20gd3JvdGU6DQo+ID4gPiBG
cm9tOiBTdmVuIFNjaHVsdHNjaGlrIDxzdmVuLnNjaHVsdHNjaGlrQHNpZW1lbnMuY29tPg0KPiA+
ID4gDQo+ID4gPiArU1JDX1VSSSA9DQo+ID4gDQo+ICJnaXRzbTovL2dpdGh1Yi5jb20vdGlhbm9j
b3JlL2VkazIuZ2l0O2JyYW5jaD1tYXN0ZXI7cHJvdG9jb2w9aHR0cHM7ZGVzdHN1ZmYNCj4gPiBp
eD1naXQvZWRrMjtuYW1lPWVkazIgXA0KPiA+ID4gKyAgICBnaXQ6Ly9naXRodWIuY29tL3RpYW5v
Y29yZS9lZGsyLQ0KPiA+IHBsYXRmb3Jtcy5naXQ7cHJvdG9jb2w9aHR0cHM7ZGVzdHN1ZmZpeD1n
aXQvZWRrMi1wbGF0Zm9ybXM7bmFtZT1lZGsyLQ0KPiA+IHBsYXRmb3JtcyBcDQo+ID4gPiArICAg
IGZpbGU6Ly9ydWxlcy50bXBsIFwNCj4gPiA+ICsgICAgIg0KPiA+ID4gK1NSQ1JFVl9lZGsyID0g
ImVkazItc3RhYmxlJHtQVn0iDQo+ID4gPiArU1JDUkVWX2VkazItcGxhdGZvcm1zID0gIjNiODk2
ZDFhMzI1Njg2ZGUzOTQyNzIzYzQyZjI4NjA5MDQ1M2UzN2EiDQo+ID4gPiArDQo+ID4gDQo+ID4g
Z2l0IGNsb25lIHNob3dzIGFsbW9zdCAzR2lCIG5lZWQgYmUgY2xvbmVkOg0KPiA+IA0KPiA+IFJl
Y2VpdmluZyBvYmplY3RzOiAxMDAlICg0NDk4NzMvNDQ5ODczKSwgMzQ1LjQzIE1pQiB8IDY0NS4w
MCBLaUIvcw0KPiBSZWNlaXZpbmcNCj4gPiBvYmplY3RzOiAxMDAlICg2MjE4MzkvNjIxODM5KSwg
Mzg3LjgxIE1pQiB8IDIuNzAgTWlCL3MgUmVjZWl2aW5nIG9iamVjdHM6DQo+ID4gMTAwJSAoMjk0
MTMxLzI5NDEzMSksIDM3OS43NyBNaUIgfCAyLjg0IE1pQi9zIFJlY2VpdmluZyBvYmplY3RzOiAx
MDAlDQo+ID4gKDE5Mzc0MC8xOTM3NDApLCAxLjQwIEdpQiB8IDIuNjEgTWlCL3MgUmVjZWl2aW5n
IG9iamVjdHM6IDEwMCUNCj4gPiAoMjU3MjA0LzI1NzIwNCksIDc1LjY1IE1pQiB8IDIuODIgTWlC
L3MgUmVjZWl2aW5nIG9iamVjdHM6IDEwMCUNCj4gKDI5MzEvMjkzMSksDQo+ID4gODI3LjMzIEtp
QiB8IDY2MS4wMCBLaUIvcyBSZWNlaXZpbmcgb2JqZWN0czogMTAwJSAoMzI1NC8zMjU0KSwgOTQ1
LjMxIEtpQg0KPiA+IA0KPiA+IDk3NC4wMCBLaUIvcyBSZWNlaXZpbmcgb2JqZWN0czogMTAwJSAo
MTQ4ODgvMTQ4ODgpLCA2LjI2IE1pQiB8IDIuMTkgTWlCL3MNCj4gPiBSZWNlaXZpbmcgb2JqZWN0
czogMTAwJSAoOTczNy85NzM3KSwgNDcuMjYgTWlCIHwgMi42OSBNaUIvcyBSZWNlaXZpbmcNCj4g
b2JqZWN0czoNCj4gPiAxMDAlICg4MzgzLzgzODMpLCAyLjI0IE1pQiB8IDEuNTcgTWlCL3MsIFJl
Y2VpdmluZyBvYmplY3RzOiAxMDAlDQo+ID4gKDMwMDMwMS8zMDAzMDEpLCAyNzEuNjMgTWlCIHwg
MS43MiBNaUIvcw0KPiA+IA0KPiA+IFRoaXMgaXMgdG9vIGh1Z2UsIHVzZSB0YXJiYWxscyBpbnN0
ZWFkPw0KPiA+IA0KPiBJIGNoZWNrZWQgYW5kIGluIG15IG9waW5pb24gaXQgaXMgbm90IGFuIG9w
dGlvbi4NCj4gRURLMiBoYXMgYSByZWxlYXNlZCB0YXIuZ3osIGJ1dCBpdCBpcyBtaXNzaW5nIHRo
ZSBzdWJtb2R1bGVzLg0KPiBUaGUgZmlyc3Qgc3VibW9kdWxlIEkgdHJpZWQgdG8gYWRkIGFzIHRh
ciBmaWxlIGFzIHdlbGwgd2FzIGdvb2dsZS9icm90bGkNCj4gaHR0cHM6Ly9naXRodWIuY29tL2dv
b2dsZS9icm90bGkvdHJlZS9mNDE1M2EwOWY4N2NiYjljODI2ZDhmYzEyYzc0NjQyYmIyZDg3OQ0K
PiBlYQ0KPiBUaGUgbGFzdCByZWxlYXNlIHRoZXkgaGFkIHdhcyBpbiBBdWcgMjcgMjAyMCBhbmQg
dGhlIGNvbW1pdCB1c2VkIGluIGVkazINCj4gSXMgZnJvbSBKYW51YXIgMTAsIDIwMjIuDQo+IFNv
IGdvb2dsZS9icm90bGkgd291bGQgYmUgYWRkZWQgYXMgZ2l0IGFnYWluLCB0cnlpbmcgdG8gZ2V0
IGFsbCBhdCB0aGUgcmlnaHQNCj4gc3BvdC4NCj4gSSBkb24ndCB0aGluayB0aGF0IHlvdSB3b3Vs
ZCBzYWZlIHNwZWVkIGFuZCBzcGFjZSBhbmQgeW91IHdvdWxkIGFkZCANCj4gQ29tcGxleGl0eS4N
Cg0KSSB0aGluayB5b3UgY2FuIHVzZSBiZWxvdyBsaW5rIHRvIGdldCBhIGNvbW1pdDoNCmh0dHBz
Oi8vZ2l0aHViLmNvbS9nb29nbGUvYnJvdGxpL2FyY2hpdmUvZjQxNTNhMDlmODdjYmI5YzgyNmQ4
ZmMxMmM3NDY0MmJiMmQ4NzkudGFyLmd6DQoNCndoaWNoIHJlc3VsdHMgaW46DQoNCi1ydy1yLS1y
LS0gIDEgKioqICoqKiA1MDFLIE9jdCAyNyAwOTozMg0KZjQxNTNhMDlmODdjYmI5YzgyNmQ4ZmMx
MmM3NDY0MmJiMmQ4NzkudGFyLmd6DQoNCkFuZCB0aGUgZ2l0IGNsb25lIHNpemUgaXMgNDlNQiBm
b3IgdGhpcyByZXBvLg0KDQotIEJhb2NoZW5nIFN1DQo=

