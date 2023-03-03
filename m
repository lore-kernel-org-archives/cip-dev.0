Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7B0C7EE2F
	for <webhook@archiver.kernel.org>; Fri,  3 Mar 2023 13:12:26 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.54])
 by mx.groups.io with SMTP id smtpd.web11.19121.1677833520190655893
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Mar 2023 00:52:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=WqIaAi1k;
 spf=pass (domain: siemens.com, ip: 40.107.8.54, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CmMjOoacSods1h78gS4B18aRAuDD6IPbJ2exhb2AIyzt3I0VzLVy4MrEZuMSUyBIXO+AEseivc6SeysUugOHEfULODjDNI0YHCTb3Mkfp0nKiHYS4oIPFIDyD/oGMELImE9PJKlcQmNCQUTFM2bYVKlH5veowDY8OzWHxUDqfm9WiAOgCYcRkJndqaICyMDuCQt3wYjoVOEiFcyyZDR9l8IR9ZjOL3AGI+uyGP35rG5gW631iaukqA003Abe8FUNWPY2CQNttEHSpffQ6CIO3Lpe9gDdI+Pm+N8op9lVKS3qvQz8W2ASm/G7qcYxoAgGYb5DhaTann1xO27A1KNkYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIIbS+e3x1qWx5r0vVp47sGe/YmuUttrKD6q27H8G2Y=;
 b=NxyWcmEU6hMvvIJXgyOO72GpkannDBDdQGojycU0ZEqz7vIzdS57fXVHsTaAyECq4+/wYT9kl3Rewsbyz7oqannE1vXMVUKv1R2gVZg9dZRtdaEzIMAbhQFhngYs0Apv7yQ3B56SsgnV0OFLpRv3Ljy6JxXcTdEfsZK10Cfmo+Uf1HwbPKcSJDqnJOhTJxTdqajelCUA98yrdgkw57LJHd9Ko4VBgO41i/xlIUhL/QEFq1tiWC8BhWgCp4ecf+wmr4Le9UQfPhDViT6NBitOlmwjk0B1Szx6EM49ABdebNHrnxrNdOACHJcLFyiXnCUJPkMaPnOEG39+e1OX6/LZng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIIbS+e3x1qWx5r0vVp47sGe/YmuUttrKD6q27H8G2Y=;
 b=WqIaAi1kNnH8MvydW329dWJX0p1QHE6wybgJ3cGUykPgLlJWzTAwgB02c0Ru+pAEUUuiWktY9iwZKLNVSL3SiIOqmW7Cd7+UyVoPMY/krAMLryv39JtUEr+rqIUUyOfqmOLmAzT4R4P1okMMoxJKWUoSF67unQ6BjvW9AHqOaZ5mfC7fzUzYaJgxul3CXRuPftx/yZPe7YTyqU62rvhiEfsXNA53Oipca3mFOake9lH9UCg/l7kbwrWU0N70Luwe+ExKNz9Ywid60qavEKxiEBIrYXyRwjSVONs1rIFpN8pMle7MoOOzBQRqogtjzy9qZsE5VUfEu0JsdWMQrBVgVw==
Received: from DUZPR01CA0049.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::9) by GV2PR10MB7438.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:de::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Fri, 3 Mar
 2023 08:51:56 +0000
Received: from DB5EUR01FT087.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:469:cafe::f0) by DUZPR01CA0049.outlook.office365.com
 (2603:10a6:10:469::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.21 via Frontend
 Transport; Fri, 3 Mar 2023 08:51:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5EUR01FT087.mail.protection.outlook.com (10.152.5.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.22 via Frontend Transport; Fri, 3 Mar 2023 08:51:55 +0000
Received: from CNPEK01M09MSX.ad011.siemens.net (139.24.237.227) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1118.25; Fri, 3 Mar 2023 09:51:55 +0100
Received: from CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) by
 CNPEK01M09MSX.ad011.siemens.net (139.24.237.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 3 Mar 2023 16:51:44 +0800
Received: from CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) by
 CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) with mapi id
 15.01.2507.021; Fri, 3 Mar 2023 16:51:44 +0800
From: "Moessbauer, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
CC: "Bovensiepen, Daniel (bovi)" <daniel.bovensiepen@siemens.com>, "Gylstorff,
 Quirin" <quirin.gylstorff@siemens.com>
Subject: Re: [isar-cip-core][PATCH v3 6/9] enhance qemu-riscv64 machine to be testable
Thread-Topic: [isar-cip-core][PATCH v3 6/9] enhance qemu-riscv64 machine to be
 testable
Thread-Index: AQHZTRuUigT7mLWieEqsq3lM5CrrM67oHuOAgAAW4oCAAALuAIAAAbiA
Date: Fri, 3 Mar 2023 08:51:43 +0000
Message-ID: <b90a5841bee0baa8adf3389f5ce8b83a479a6061.camel@siemens.com>
References: <20230302152659.2096307-1-felix.moessbauer@siemens.com>
	 <20230302152659.2096307-7-felix.moessbauer@siemens.com>
	 <ee664f4e-64ea-10d5-e53a-87b5773f90d0@siemens.com>
	 <e4f08920de44bca9d04ed3b3fb6787d059480002.camel@siemens.com>
	 <c58fda96-0e4e-e07b-d4fe-bf06370814f3@siemens.com>
In-Reply-To: <c58fda96-0e4e-e07b-d4fe-bf06370814f3@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1+deb11u1 
x-originating-ip: [144.145.220.58]
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT087:EE_|GV2PR10MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: e06a2e19-5778-487d-219a-08db1bc48add
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6N7GunJcqcDtFMH7TxhCf/nPZyaNmMAvle/aK8u1oHnvJ0TC+3DVGir7ri40q7o27NZQXg9eNgyDUjgaCtkrBNKO32zo+A4O5nYRu51YgkSJByp9ndykQMg2/v/vaqTRcl9o85/W/VbXP1I9ZJ0JvTVLjc2bgn/9BLk/4cTn4KzvHJ0eaDLoE2OgAk6uxe+isDOqaWVAAN7l9TyB2LA8VF4s+HRYWrhkzqe9F5AWCwFvc+5RQHRwH2TTYxhJE8A7Km71a3nTvDosDQ1PCKZogjYOZxpMbr/5csZh4uvTPROCOyIVa4laNJ5s7ljKhQR7guyyi3BX0OTt46wAmLWn5b+kdn55Is+xppQ9AYsRk57gGhGSDirfb1zrvaoSohRVS0Wyl92ZB9N2SNDF+mM9TMPTDsW6qVGtek6CCl61gEHn/a05EzlpcWGm/9FlTZx3IahaBWeS0S10Jy0P8v0505QeZsquiQKbF1FQVsrk0H6raKK7qls6NkDFxxy57ZAzuhWGcK0vrsRaQphMEYuj/jHAovFOpAPRQHrOucDWz6F8doxRlSi0wXXhegj/mOwliqQNMhLS5r3Efk9aujUmuh77soLAE4ina7bbmXWgPO80N1LVmsXcCmTzSNpCNZGw+HQ9SYEX6A9yo12WHJDRXLPZDQm8x61fOxnXEsIYCDYiWd4/RxEYm3/0cwJL3yCLUvBmJEROxRJX5I3W5u6ITqLaCgTloy2asCU/PIXpID8=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199018)(36840700001)(40470700004)(46966006)(40480700001)(36756003)(82310400005)(316002)(478600001)(83380400001)(6636002)(54906003)(336012)(4326008)(82740400003)(36860700001)(82960400001)(110136005)(8676002)(53546011)(2616005)(956004)(40460700003)(81166007)(966005)(47076005)(70586007)(26005)(107886003)(5660300002)(70206006)(186003)(8936002)(41300700001)(2906002)(356005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 08:51:55.9167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e06a2e19-5778-487d-219a-08db1bc48add
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT087.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7438
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <40F2A9FB1B8F1E4DB2836CFCE327EE5F@siemens.com>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Mar 2023 13:12:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10903

T24gRnJpLCAyMDIzLTAzLTAzIGF0IDA5OjQ1ICswMTAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAwMy4wMy4yMyAwOTozNSwgTW9lc3NiYXVlciwgRmVsaXggKFQgQ0VEIElOVy1DTikgd3JvdGU6
DQo+ID4gT24gRnJpLCAyMDIzLTAzLTAzIGF0IDA4OjEzICswMTAwLCBKYW4gS2lzemthIHdyb3Rl
Og0KPiA+ID4gT24gMDIuMDMuMjMgMTY6MjYsIEZlbGl4IE1vZXNzYmF1ZXIgd3JvdGU6DQo+ID4g
PiA+IFRoaXMgcGF0Y2ggZW5oYW5jZXMgdGhlIHFlbXUtcmlzY3Y2NCBtYWNoaW5lIGJ5IGFkZGlu
ZyBhDQo+ID4gPiA+IHJlZmVyZW5jZQ0KPiA+ID4gPiB0bw0KPiA+ID4gPiB1LWJvb3QuIEZ1cnRo
ZXIsIHdlIG5vdyB1c2UgdGhlIHFlbXVfcmlzY3Y2NCBkZWZjb25maWcgZnJvbQ0KPiA+ID4gPiBj
aXAta2VybmVsLWNvbmZpZy4NCj4gPiA+ID4gDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEZlbGl4
IE1vZXNzYmF1ZXIgPGZlbGl4Lm1vZXNzYmF1ZXJAc2llbWVucy5jb20+DQo+ID4gPiA+IC0tLQ0K
PiA+ID4gPiDCoGNvbmYvbWFjaGluZS9xZW11LXJpc2N2NjQuY29uZiB8IDkgKysrKysrKystDQo+
ID4gPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
PiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2NvbmYvbWFjaGluZS9xZW11LXJpc2N2NjQu
Y29uZg0KPiA+ID4gPiBiL2NvbmYvbWFjaGluZS9xZW11LQ0KPiA+ID4gPiByaXNjdjY0LmNvbmYN
Cj4gPiA+ID4gaW5kZXggZjFmM2U4Ny4uOGMxNzY0YiAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvY29u
Zi9tYWNoaW5lL3FlbXUtcmlzY3Y2NC5jb25mDQo+ID4gPiA+ICsrKyBiL2NvbmYvbWFjaGluZS9x
ZW11LXJpc2N2NjQuY29uZg0KPiA+ID4gPiBAQCAtMTIsNCArMTIsMTEgQEANCj4gPiA+ID4gwqBE
SVNUUk9fQVJDSCA9ICJyaXNjdjY0Ig0KPiA+ID4gPiANCj4gPiA+ID4gwqBJTUFHRV9GU1RZUEVT
ID89ICJleHQ0Ig0KPiA+ID4gPiAtS0VSTkVMX0RFRkNPTkZJRyA/PSAiZGVmY29uZmlnIg0KPiA+
ID4gPiArVVNFX0NJUF9LRVJORUxfQ09ORklHID0gIjEiDQo+ID4gPiA+ICsNCj4gPiA+ID4gK0tF
Uk5FTF9ERUZDT05GSUcgPz0gImNpcC1rZXJuZWwtDQo+ID4gPiA+IGNvbmZpZy8ke0tFUk5FTF9E
RUZDT05GSUdfVkVSU0lPTn0vcmlzY3YvcWVtdV9yaXNjdjY0X2RlZmNvbmZpZw0KPiA+ID4gPiAi
DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyMgZm9yIFNXVXBkYXRlIHNldHVwczogd2F0Y2hkb2cgaXMg
Y29uZmlndXJlZCBpbiBVLUJvb3QNCj4gPiA+IA0KPiA+ID4gSXMgdGhhdCB0cnVlIGZvciBxZW11
LCBvciBpcyB0aGF0IGp1c3QgYSBjb3B5LWFuZC1wYXN0ZQ0KPiA+ID4gc3RhdGVtZW50Pw0KPiA+
IA0KPiA+IEFjdHVhbGx5LCBJIGp1c3QgY29waWVkIHRoYXQgZnJvbSB0aGUgYXJtNjQgZXhhbXBs
ZS4gQnV0IGhhdmluZyBhDQo+ID4gc2Vjb25kIGxvb2sgYXQgdGhlIGNvZGUsIG1ha2VzIG1lIHRo
aW5rIHRoYXQgaXQgaXMgYWxzbyB3cm9uZw0KPiA+IHRoZXJlOg0KPiA+IA0KPiA+IC0gdGhlIHUt
Ym9vdCBvcHRpb24gQ09ORklHX0hXX1dBVENIRE9HIGlzIG5vdCBzZXQNCj4gPiAtIHRoZSBzdGFy
dC1xZW11LnNoIHNjcmlwdCBkb2VzIG5vdCBzZXR1cCBhbnkgd2F0Y2hkb2cgaW4gUUVNVQ0KPiAN
Cj4gQWgsIEkgcmVjYWxsLiBUaGVyZSB3YXMgYSBwbGFuIHRvIGhhdmUgb25lLCBidXQgaXQgd2Fz
IHNob3QgZG93bg0KPiBiZWNhdXNlDQo+IEkgd2FzIG5vdCBtb3RpdmF0ZWQgdG8gYWRkIHRoYXQg
ZXhvdGljIHdhdGNoZG9nIGRyaXZlciB0byBVLUJvb3Q6DQo+IGh0dHBzOi8vbWFpbC5nbnUub3Jn
L2FyY2hpdmUvaHRtbC9xZW11LWFybS8yMDIyLTA1L21zZzAwMTU0Lmh0bWwNCg0KVGhhbmtzIGZv
ciB0aGUgbm90aWNlLiBIb3cgc2hhbGwgd2UgcHJvY2VlZD8NCkkgdm90ZSBmb3Iga2VlcGluZyBX
RE9HX1RJTUVPVVQ9MCBidXQgY2hhbmdpbmcgdGhlIGNvbW1lbnQgdG8gc29tZXRoaW5nDQpsaWtl
IHRoYXQ6DQoNCiJXYXRjaGRvZyBpcyBub3QgeWV0IHN1cHBvcnRlZCBpbiBvdXIgUUVNVSBleGVj
dXRvciBmb3IgdGhpcyBwbGF0Zm9ybSwNCmRpc2FibGUgaXQiLg0KDQpGZWxpeA0KDQo+IA0KPiBK
YW4NCj4gDQoNCg==

