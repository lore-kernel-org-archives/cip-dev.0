Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86A8C4332F
	for <webhook@archiver.kernel.org>; Mon, 13 Nov 2023 13:27:59 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.48])
 by mx.groups.io with SMTP id smtpd.web11.35577.1699878293631448904
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Nov 2023 04:24:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=f0/pzVJ4;
 spf=pass (domain: siemens.com, ip: 40.107.6.48, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9eAX7tUbGV+bY/3IGIik/VV7L7zct8OOC4zyHlesGWYvOtwI+i1K4BGwEncPPcVbk5TYcZRlIy4J31Yz6I27MQTLAtVclWhFg3EkEcDIL05MdJVXxZ14reY6kmk839UjCpWy+K+gyTHL6ZEoiCmbldqWtZjCMiZY7Kgr7JByxfUldLeD+unBNZU28tpjRI6vio2uoxH/XM7qGwyA08++Q4LRhyGwl2AYuQbXiiGx/V4kFpK+sZwwbLLzjY2XHRQWsOvBJEbOBCIFLkt3xnCn5fiOw92Pqj+gl1nUUP8IFBFpr7ritHost2VBEfaQ8iuiDYy7w/HhO+VpzJlbwawkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygd6Makxpv5gkyRlFvdUHzIfqNJvf7ALM+l/Vriji+A=;
 b=Q2Si14I1f5yM6szB0iEsckKYzDdkEEF2kksWLqYut0t2mttJ67o2blHuG7JaUa3TAtl5p8+xObWlzcwha2q50w7pbSlRrt1p+xAr5Kv6MIgvYIbjrr5n+fzbDxAflv1ATRvZyhI6sClVVVp7XEjuB4b0dmEBj15OOvfHOwWYjC2h/RD/PUfQ1SaxmvyRW3mEVw5fNEAkhU5JdJi7K49ZkJAU3ZjE94R165kfZiDFOVvNTvX9qNpjFOs3wlzU5FD6yYbMcv19rTOMihaQU4ja6WAj8vv2x6TUTcfIZu4Kslwn42jx3kziglyoBMrrugVmDoG9kW7FIVl0tZWUsff7iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=siemens.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygd6Makxpv5gkyRlFvdUHzIfqNJvf7ALM+l/Vriji+A=;
 b=f0/pzVJ4XNZpQesB6m18roON/sxvI6cNdZ9SHEfgbB74dCwr8UJTA/J8WQ5wg90O6KGgLdlIKNe94c4XmT5kY6+qqRqJ5ikyLekNBCJMa8tYPfhhx3i+PjU9ifPablXdiq4GIbopc/FKFVak4mA5YH84PVGS3eXgnIlKZ4HRaFtcnNE4NdZlpki8HLT3gMQlCoiTfunK2xKVJFqTg2Pcjw4yyGRfQoc26JmgyMX4pbtBGaK9VtwiMGa1MW0P4fs2WvT6s725/so/VoFeFlB0NlLlM2vpt0Ch6zapJQz5BZpOJxy+hzi0qDF/VtQ5siCJ9ZViApYVqC8xDZN+3aaAjg==
Received: from AM0PR06CA0129.eurprd06.prod.outlook.com (2603:10a6:208:ab::34)
 by DU0PR10MB7311.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:445::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 12:24:50 +0000
Received: from AMS1EPF0000004B.eurprd04.prod.outlook.com
 (2603:10a6:208:ab:cafe::64) by AM0PR06CA0129.outlook.office365.com
 (2603:10a6:208:ab::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29 via Frontend
 Transport; Mon, 13 Nov 2023 12:24:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=E
Received: from hybrid.siemens.com (194.138.21.75) by
 AMS1EPF0000004B.mail.protection.outlook.com (10.167.16.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.13 via Frontend Transport; Mon, 13 Nov 2023 12:24:49 +0000
Received: from CNPEK01M09MSX.ad011.siemens.net (139.24.237.227) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Mon, 13 Nov 2023 13:24:48 +0100
Received: from CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) by
 CNPEK01M09MSX.ad011.siemens.net (139.24.237.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 13 Nov 2023 20:24:46 +0800
Received: from CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) by
 CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) with mapi id
 15.01.2507.034; Mon, 13 Nov 2023 20:24:45 +0800
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"Gylstorff, Quirin" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH] efibootguard: Update to efibootguard 0.16
Thread-Topic: [cip-dev][isar-cip-core][PATCH] efibootguard: Update to
 efibootguard 0.16
Thread-Index: AQHaFixjOiYi+sGbLECxrX9iNXZMIA==
Date: Mon, 13 Nov 2023 12:24:45 +0000
Message-ID: <b34cd1faa0701a52cc442a10b8f893edc6b61c77.camel@siemens.com>
References: <20231113100528.127244-1-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20231113100528.127244-1-Quirin.Gylstorff@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
x-originating-ip: [139.23.72.41]
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004B:EE_|DU0PR10MB7311:EE_
X-MS-Office365-Filtering-Correlation-Id: 196a6250-ad71-406a-8e68-08dbe4438808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vjHhPBXGszd3dQaGPno/TC72sgNw4rEmMCLfzZXHIaM3CStS8qGzaAnvJbs6inr/N9qineik023ngq48kdyAjv6gvPHnq1kyrJ6xHa5vasfbSUnXAmEoo6GVZsM7YRwk98pZ73OMNhZvRSIWNbUU5gQb/iZADbwomFPdvxEpFjmxxU9aUi7VFiVo+rfdI7JqOClMzWzbKvEmPjc56ok+vgJR9v+KQW327OZNeL3glTFwAqhRuU77K1zsljnNmfnw72IqAQyZly5MWXnPzq3VlgrOQnPYcQvEvm6/edYcQmVJqDtFxcCfd6rhupS7+jZ5llF/ZfD6rISJ9iZepl+aQtEEFiClTEMNeBTeq/NOom6I3Rt3IEHWW8Ddj+kbPwEgXLibOR4Gue+KsF21FUWMB+s3Rr3KRyPCdGWpDjyuBgF0oDsNQhtbGS0IU0hVA9JUY+q/eJBEKVVrG5CxP+ocHXbls8qUKpjwsaWAXnI2rh/Um9oGgwXhtWuro/VbK/nXFVqGxmgWMMNIcOXb1RU55+ugckyL+DhoeR93PgO3X6sbETssso1YfAJ9y0jMMKgER7OU2hy6NDfDwuqqlcAS3mIbnCX6C2t9zwBDqTscJ9N9HONwKNjPtIieNw65Tfpc7kyfM8CzkMB+bKNpim2hAVJb8eBUVFKrPCchY/BP6WqKveFjBJymzlDBx4LiRXkHdrCQ0xoLyaZMkpUgznH5k4HBgkR/sHr8L5KR4nQ7HknhdVwfwcMKi2kGqQr0hjTb2UKE+WwXSlBJLmMwdXMcbUes/t2PITWe6lAz6oXUqPc=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(82310400011)(46966006)(40470700004)(36840700001)(83380400001)(336012)(2906002)(4001150100001)(40460700003)(47076005)(966005)(36860700001)(86362001)(82740400003)(82960400001)(356005)(478600001)(316002)(81166007)(41300700001)(6636002)(110136005)(70586007)(70206006)(36756003)(8676002)(8936002)(956004)(2616005)(5660300002)(26005)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 12:24:49.8792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 196a6250-ad71-406a-8e68-08dbe4438808
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS1EPF0000004B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7311
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <09475103CE04D04A844B78BBEA54D024@siemens.com>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Nov 2023 13:27:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13573

T24gTW9uLCAyMDIzLTExLTEzIGF0IDExOjA0ICswMTAwLCBRdWlyaW4gR3lsc3RvcmZmIHdyb3Rl
Og0KPiBGcm9tOiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29t
Pg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUXVpcmluIEd5bHN0b3JmZiA8cXVpcmluLmd5bHN0b3Jm
ZkBzaWVtZW5zLmNvbT4NCg0KQWNrZWQtYnk6IEZlbGl4IE1vZXNzYmF1ZXIgPGZlbGl4Lm1vZXNz
YmF1ZXJAc2llbWVucy5jb20+DQoNClRoYW5rcyENCg0KPiAtLS0NCj4gwqAuLi5maWJvb3RndWFy
ZF8wLjE1LTErY2lwLmJiID0+IGVmaWJvb3RndWFyZF8wLjE2LTErY2lwLmJifSB8IDYgKysrLQ0K
PiAtLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0p
DQo+IMKgcmVuYW1lIHJlY2lwZXMtYnNwL2VmaWJvb3RndWFyZC97ZWZpYm9vdGd1YXJkXzAuMTUt
MStjaXAuYmIgPT4NCj4gZWZpYm9vdGd1YXJkXzAuMTYtMStjaXAuYmJ9ICg4NCUpDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvcmVjaXBlcy1ic3AvZWZpYm9vdGd1YXJkL2VmaWJvb3RndWFyZF8wLjE1LTEr
Y2lwLmJiDQo+IGIvcmVjaXBlcy1ic3AvZWZpYm9vdGd1YXJkL2VmaWJvb3RndWFyZF8wLjE2LTEr
Y2lwLmJiDQo+IHNpbWlsYXJpdHkgaW5kZXggODQlDQo+IHJlbmFtZSBmcm9tIHJlY2lwZXMtYnNw
L2VmaWJvb3RndWFyZC9lZmlib290Z3VhcmRfMC4xNS0xK2NpcC5iYg0KPiByZW5hbWUgdG8gcmVj
aXBlcy1ic3AvZWZpYm9vdGd1YXJkL2VmaWJvb3RndWFyZF8wLjE2LTErY2lwLmJiDQo+IGluZGV4
IDBjZmI2ZGEuLmFkYTA1OTIgMTAwNjQ0DQo+IC0tLSBhL3JlY2lwZXMtYnNwL2VmaWJvb3RndWFy
ZC9lZmlib290Z3VhcmRfMC4xNS0xK2NpcC5iYg0KPiArKysgYi9yZWNpcGVzLWJzcC9lZmlib290
Z3VhcmQvZWZpYm9vdGd1YXJkXzAuMTYtMStjaXAuYmINCj4gQEAgLTE3LDEyICsxNywxMiBAQCBM
SUNfRklMRVNfQ0hLU1VNID0NCj4gImZpbGU6Ly8ke0xBWUVSRElSX2lzYXJ9L2xpY2Vuc2VzL0NP
UFlJTkcuR1BMdjI7bWQ1PTc1MTQxOTI2MA0KPiDCoE1BSU5UQUlORVIgPSAiSmFuIEtpc3prYSA8
amFuLmtpc3prYUBzaWVtZW5zLmNvbT4iDQo+IMKgDQo+IMKgU1JDX1VSSSA9ICIgXA0KPiAtwqDC
oMKgDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9zaWVtZW5zL2VmaWJvb3RndWFyZC9hcmNoaXZlL3Jl
ZnMvdGFncy92MC4xNS50YXIuZ3o7ZG93bmxvYWRmaWxlbmFtZT1lZmlib290Z3VhcmRfMC4xNS5v
cmlnLnRhci5nejt1bnBhY2s9MDtuYW1lPXRhcmJhbGwNCj4gwqBcDQo+ICvCoMKgwqANCj4gaHR0
cHM6Ly9naXRodWIuY29tL3NpZW1lbnMvZWZpYm9vdGd1YXJkL2FyY2hpdmUvcmVmcy90YWdzL3Yw
LjE2LnRhci5nejtkb3dubG9hZGZpbGVuYW1lPWVmaWJvb3RndWFyZF8wLjE2Lm9yaWcudGFyLmd6
O3VucGFjaz0wO25hbWU9dGFyYmFsbA0KPiDCoFwNCj4gwqDCoMKgwqANCj4gZ2l0Oi8vc2Fsc2Eu
ZGViaWFuLm9yZy9kZWJpYW4vZWZpYm9vdGd1YXJkLmdpdDtwcm90b2NvbD1odHRwczticmFuY2g9
DQo+IG1hc3RlcjtuYW1lPWRlYmlhbiBcDQo+IMKgwqDCoMKgDQo+IGZpbGU6Ly9kZWJpYW4tcGF0
Y2hlcy8wMDAxLWQtY29udHJvbC1NYWtlLWNvbXBhdGlibGUtd2l0aC1kZWJpYW4tYnVzdGVyLnBh
dGNoDQo+IMKgXA0KPiDCoMKgwqDCoCAiDQo+IC1TUkNfVVJJW3RhcmJhbGwuc2hhMjU2c3VtXSA9
DQo+ICI5ZDJkNDY5MTNlZDgwMTMwNTZhM2MyYjA4MGE5OTdlNjhkNzhkOTJhMTA1MWNlZDA2ZmJm
ZWZhOTMzNTNiYjdmIg0KPiAtU1JDUkVWX2RlYmlhbiA9ICJlMzk3MjhmNjM5NDZkMWFmMmQ1ZWRi
ZWNkODlhMzA3MDZkYzMxYTlhIg0KPiArU1JDX1VSSVt0YXJiYWxsLnNoYTI1NnN1bV0gPQ0KPiAi
ZDZkMzdjNTlhZWQxNzQ4OWQwMmI0ZjBiNjNkYjE2OTk0ZGZiOGY5ZjcwZjU0YmU0ZDY1YzM2NmY1
OGM2YmU5ZCINCj4gK1NSQ1JFVl9kZWJpYW4gPSAiMmU4MGZhZmE4N2Y4ZjZmZDA5M2Y0OWZmMzNh
ZDdjYWM2MTU5Mjg3MSINCj4gwqANCj4gwqBQUk9WSURFUyA9ICJsaWJlYmdlbnYtZGV2IGxpYmVi
Z2VudjAgZWZpYm9vdGd1YXJkIg0KPiDCoA0KDQo=

