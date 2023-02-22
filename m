Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0665C6379F
	for <webhook@archiver.kernel.org>; Wed, 22 Feb 2023 09:18:25 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.80])
 by mx.groups.io with SMTP id smtpd.web10.4772.1677057503889035137
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Feb 2023 01:18:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=AjuD1Suh;
 spf=pass (domain: siemens.com, ip: 40.107.247.80, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FW+LwfZzNX5SKsURtV/G4PynxgyheCMN5uBPVlbpH7TFA1V9/yDB037c0b9/DJI9pdFlubSML2bJsX4ljXkSH2Y/o3UYVLdHDQdXoEWVna2gw9I9/ZlDI90O1qvLRS/3SmTKZGcQ3JWNtxBJjAue3DxuDT7v6me9m/eL6NQaE7xqYvC48rI0jiSzHpq6CmRx7/JOcVXsS2C8tTSqzuHRsRwhHswF4nsJk6yZwyz1cb7N7wfm01WARj1wRtOQ0D10w3sqcbq78Bz1+wchPuk0FwOH0DlOY2SUutPd0U6GJ1vRnby19kQwguAc6xt6dsXUsgP/C0vkxharnfOqUw09MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1pab5lOhq1XLQgGO5ZVDu04R1GiDlGylSCCTpDNUQs=;
 b=kHe/mI517x4H2JxthvW6iB8EVhiN85EuzWwil3BzKfHOEduxlJxzt675qLUArn//KhG/cnCNiWWyqyRrDKsb8bFe9jZhz/I6Gt3FGD17UGIRQGMEjSC9LZHqR/6IkkqhMUszrOf5uWqhiDla8KvdkobqkvGDWAYxC3oWg4tEiTZVCSQjQEcVcvl1DJIlzGMolfQJJKH2/vJh/oBMYv0Nvi5W47k3G6h2Nd2nFOjaifMuEyTwFvvIzh4sC9gX+l6qpneoYoQ/KJyWFqzdGiRC987s4WdnoI9b4ApdxTe74EAR4rxN4ewODiRUNkdEA9Ukl6v+UcXZxRGiUhvNveQiNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1pab5lOhq1XLQgGO5ZVDu04R1GiDlGylSCCTpDNUQs=;
 b=AjuD1SuhGhM6txCJWvtAFvVDw9nD6OK9vSxIIPo61z7XL8aOdFqCcP1OxFefruU5ivQuiFaxLaRYqjL8Wsi/LcYpoReb0J8oQYg55kC9Wj2PftJojjIp0EfncLwEqyq0tGv4j8JOvNzOIaazoZDHwOlMl4FVCb7XuYCavO85v7eQZihd5IFQl59bIxEXiO1GL/2bu206AC4U2RwNQlSm2W0Eal+TPh76Rrn2+J4nn9MkApy28Bp+X+vyX86Pb4K/S3/VOO9kcWBp0ctGg2qWMCwiBFmfkJ81A8KowVnWK6YZkSw00LrHgJmWz6uUsCz8IzhkYmMJhci6T9xYzCbHFg==
Received: from DB6P192CA0009.EURP192.PROD.OUTLOOK.COM (2603:10a6:4:b8::19) by
 PAWPR10MB7128.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2eb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 09:18:21 +0000
Received: from DB5EUR01FT070.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:b8:cafe::86) by DB6P192CA0009.outlook.office365.com
 (2603:10a6:4:b8::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.15 via Frontend
 Transport; Wed, 22 Feb 2023 09:18:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5EUR01FT070.mail.protection.outlook.com (10.152.5.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.17 via Frontend Transport; Wed, 22 Feb 2023 09:18:20 +0000
Received: from CNPEK01M06MSX.ad011.siemens.net (139.24.237.223) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1118.25; Wed, 22 Feb 2023 10:18:19 +0100
Received: from CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) by
 CNPEK01M06MSX.ad011.siemens.net (139.24.237.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 22 Feb 2023 17:18:17 +0800
Received: from CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) by
 CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) with mapi id
 15.01.2507.017; Wed, 22 Feb 2023 17:18:17 +0800
From: "Moessbauer, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
CC: "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
	"kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>,
	"venkata.pyla@toshiba-tsip.com" <venkata.pyla@toshiba-tsip.com>
Subject: Re: [cip-dev] [isar-cip-core 1/2] kas/opt/reproducible.yml: Add kas
 file for reproducible builds target
Thread-Topic: [cip-dev] [isar-cip-core 1/2] kas/opt/reproducible.yml: Add kas
 file for reproducible builds target
Thread-Index: AQHZRp3CVrneAJGaHk6L0QQisubpOq7aKdWA
Date: Wed, 22 Feb 2023 09:18:17 +0000
Message-ID: <2e6c36f78e3873f0627fa5c3912108fe1283438e.camel@siemens.com>
References: <20230222091159.18216-1-venkata.pyla@toshiba-tsip.com>
	 <20230222091159.18216-2-venkata.pyla@toshiba-tsip.com>
In-Reply-To: <20230222091159.18216-2-venkata.pyla@toshiba-tsip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1+deb11u1 
x-originating-ip: [139.24.247.56]
Content-Type: text/plain; charset="utf-8"
Content-ID: <459BABA892566C458B9A4D5827499D0F@siemens.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT070:EE_|PAWPR10MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: 39f88cc6-bdbb-4707-317e-08db14b5bdc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9GnTu0PGIMyWz3/zoReFPIxqlw0Zj1cenE/mxECK+dXI2iIglb9nSPqFddTJgqRJiChILtDDs0SU0UzUSxvb/N5hW5MwzWj2FrN9QvUfj2ZkSh+azj3580hV/2khvHdigRttCe7H99T/in0ac8TLiwZClKAGxnpgxT76lDDTlVPpq6VswTgaRpeIdPWzRUhInUXp6SGFYFn1pGnqrNKM1Mz3HWlqdKD/KE14g871TP+bAwDM3Oy99Ur6WwThTM1SLpow+NgT/f5zT4BtfkqGi5fANcGesIN/wXJhprcVV7X9gC6CUO4QVNR+UD84joca71c8GxcnaAhrwGYJOqOCzkDu+twX6Tu8nJmU76ATjF4xoQ8t9N7lBGmdR4c45BvSQQueaDC3E1ENECWvJVlgTgJukyUnweKcAcO4ZLfPLug6SF1Hh8ddsMYAnLBKtbRCMHj9hmgvDvzdL3Ku9uoJtFrM4tdmO+IC1vMZ5DTq4MvyMcHAlmCJaZX3bjk0jLV33kfJCTk1HzRqV+cnYyZ//4m5HCPgA3m9zhtCnfBI5Vtqwvtq35PeBCMDDiez6YCnF7/mr4u3t15xl3dgE4gysiaGcdm322EmqE4juIjcqaKWaYGAa1GrFK5azkSDiyJDq0sCeMWXE+J1TnoX7Qcs2wTEuuPzKHLKTXfW56nzSB3QCtYMv8mT6FFP0pkDJQtfH8gGJaBQlFXflUD0wF8qFpeC7bn5MMv5BtZDNpwITcc5EcmdGN3JsD2dQ+M+o6a01py+/5UyX72IxYKDXGbygQ==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199018)(40470700004)(46966006)(36840700001)(316002)(86362001)(26005)(186003)(2616005)(956004)(5660300002)(66899018)(110136005)(6636002)(54906003)(40480700001)(336012)(8936002)(478600001)(356005)(47076005)(83380400001)(966005)(2906002)(41300700001)(36860700001)(36756003)(82310400005)(40460700003)(70206006)(70586007)(8676002)(82740400003)(82960400001)(81166007)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 09:18:20.7991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f88cc6-bdbb-4707-317e-08db14b5bdc9
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT070.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7128
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Feb 2023 09:18:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10776

T24gV2VkLCAyMDIzLTAyLTIyIGF0IDE0OjQxICswNTMwLCBWZW5rYXRhIFB5bGEgdmlhIGxpc3Rz
LmNpcC0NCnByb2plY3Qub3JnIHdyb3RlOg0KPiBGcm9tOiB2ZW5rYXRhIHB5bGEgPHZlbmthdGEu
cHlsYUB0b3NoaWJhLXRzaXAuY29tPg0KPiANCj4gVGhpcyBrYXMgZmlsZSBzZXQgdGhlICdTT1VS
Q0VfREFURV9FUE9DSCcgdmFyaWFibGUgdG8gbGFzdCBjb21taXQNCj4gdGltZXN0YW1wIHJlcXVp
cmVkIGZvciBidWlsZGluZyByZXByb2R1Y2libGUgaW1hZ2UuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiB2ZW5rYXRhIHB5bGEgPHZlbmthdGEucHlsYUB0b3NoaWJhLXRzaXAuY29tPg0KPiAtLS0NCj4g
wqBrYXMvb3B0L3JlcHJvZHVjaWJsZS55bWwgfCAxNyArKysrKysrKysrKysrKysrKw0KPiDCoDEg
ZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspDQo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGth
cy9vcHQvcmVwcm9kdWNpYmxlLnltbA0KPiANCj4gZGlmZiAtLWdpdCBhL2thcy9vcHQvcmVwcm9k
dWNpYmxlLnltbCBiL2thcy9vcHQvcmVwcm9kdWNpYmxlLnltbA0KPiBuZXcgZmlsZSBtb2RlIDEw
MDY0NA0KPiBpbmRleCAwMDAwMDAwLi4xNzNjMDE4DQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIv
a2FzL29wdC9yZXByb2R1Y2libGUueW1sDQo+IEBAIC0wLDAgKzEsMTcgQEANCj4gKyMNCj4gKyMg
Q0lQIENvcmUsIGdlbmVyaWMgcHJvZmlsZQ0KPiArIw0KPiArIyBDb3B5cmlnaHQgKGMpIFRvc2hp
YmEgQ29ycG9yYXRpb24sIDIwMjMNCj4gKyMNCj4gKyMgQXV0aG9yczoNCj4gKyPCoCBWZW5rYXRh
IFB5bGEgPHZlbmthdGEucHlsYUB0b3NoaWJhLXRzaXAuY29tPg0KPiArIw0KPiArIyBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogTUlUDQo+ICsjDQo+ICtoZWFkZXI6DQo+ICvCoCB2ZXJzaW9uOiAx
Mg0KPiArDQo+ICtsb2NhbF9jb25mX2hlYWRlcjoNCj4gK8KgIHJlcHJvZHVjaWJsZS1idWlsZHM6
IHwNCj4gK8KgwqDCoCBTT1VSQ0VfREFURV9FUE9DSCA9ICIke0BiYi5wcm9jZXNzLnJ1bigiZ2l0
IC1DDQogICAgICAgICAgICAgICAgICAgICAgICBeXl4NClBsZWFzZSB1c2UgaW1tZWRpYXRlIGFz
c2lnbm1lbnQgaGVyZTogIjo9Ii4gQnkgdGhhdCwgd2UgY2FuIGVuc3VyZSB0aGF0DQp0aGlzIGlz
IGltbWVkaWF0ZWx5IGV4ZWN1dGVkIHdoZW4gYml0YmFrZSByZWFkcyB0aGlzIGZpbGVzLCBub3Qg
b25jZQ0KdGhlIHZhcmlhYmxlIG5lZWRzIHRvIGJlIGV4cGFuZGVkLg0KDQpCZXN0IHJlZ2FyZHMs
DQpGZWxpeA0KDQo+ICR7TEFZRVJESVJfY2lwLWNvcmV9IGxvZyAtMSAtLXByZXR0eT0lY3QgfCB0
ciAtZCAnXG4nIilbMF19Ig0KPiArDQo+IA0KPiAtPS09LT0tPS09LT0tPS09LT0tPS09LQ0KPiBM
aW5rczogWW91IHJlY2VpdmUgYWxsIG1lc3NhZ2VzIHNlbnQgdG8gdGhpcyBncm91cC4NCj4gVmll
dy9SZXBseSBPbmxpbmUgKCMxMDc3NSk6IA0KPiBodHRwczovL2xpc3RzLmNpcC1wcm9qZWN0Lm9y
Zy9nL2NpcC1kZXYvbWVzc2FnZS8xMDc3NQ0KPiBNdXRlIFRoaXMgVG9waWM6IGh0dHBzOi8vbGlz
dHMuY2lwLXByb2plY3Qub3JnL210Lzk3MTU2Mjg2LzY4Nzk2OTYNCj4gR3JvdXAgT3duZXI6IGNp
cC1kZXYrb3duZXJAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IFVuc3Vic2NyaWJlOiANCj4gaHR0
cHM6Ly9saXN0cy5jaXAtcHJvamVjdC5vcmcvZy9jaXAtZGV2L2xlYXZlLzEyMDU0MjI1LzY4Nzk2
OTYvNjMyMzUwNDc5L3h5enp5DQo+IMKgW2ZlbGl4Lm1vZXNzYmF1ZXJAc2llbWVucy5jb21dDQo+
IC09LT0tPS09LT0tPS09LT0tPS09LT0tDQo+IA0KDQo=

