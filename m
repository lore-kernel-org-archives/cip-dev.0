Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1FBC5479D
	for <webhook@archiver.kernel.org>; Wed,  4 Jan 2023 12:37:02 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.56])
 by mx.groups.io with SMTP id smtpd.web10.4174.1672805364053858610
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jan 2023 20:09:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=iyPKL4tq;
 spf=pass (domain: siemens.com, ip: 40.107.20.56, mailfrom: wangjing@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XU+NMyfOHPITEVT+8czVcsrd8jkA46E3A1VezAx9V8TG6IvYqZGaAWeTwPUKvZdEDgFRJCeOBFwbMe4yWu6N17B4E4K7HGb1+IEL3sBpr8hKyC3hKybBkBmPxFYF/n2QIUjOsF8RZ4kfZFQpJ2Sw9QXOODbufqiw9CmcCdqHR/cf2mhRHv28+IsSHVlf/8CSBpwVsHZNMt9mbwjYSHez8TOovDAoXq7yTXl0jxvvxYO9/+56H+GB+eHX0w3MwZ2dIDzNGiD0QYQ4IzSLEAek+F2DPE8y7w5szNqcKbV1soy0Zdvv/XBz+CeJTgmJ5ecK6oNjq1clcTS9/rxSFNasQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caAQZZ1wqI6orxLZXBqRTBCD98TA0DI4i0VSErQfuCc=;
 b=HcLVW54nTsazz7OVZYWRFexHtWSjVF+ASQJ8A62Ue5MpcgXLHz7Uj7wG9m69sJNXprTGvGGIvc2HA9OcDosFTenA68i2EBVhh25EpzGShQfdzYaXvJNcNdjpBbXHoxj+DJpwDguGUNzn3E+rnqy032EzdsllzR8B22IeSs8jB0ECikgsT8Thhmq8O6W2HKDg03ghxCe76nCFeHqVnXAZpvbikY1VSEbQWqAaYY+ZvuFUoMWM7fCS8gAM7PVde1td9X68vbMp7xOFsZsFAZ6FWHTnWgKtqHt8hjQP7EqtGtJvr+/ZjuTP+ASWNt/nBuiSa3o34Ocns02HMe1kobupSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caAQZZ1wqI6orxLZXBqRTBCD98TA0DI4i0VSErQfuCc=;
 b=iyPKL4tqJCJ0EH9I/xFaI7CM99K7xnCYUEOB/rvVuSu3d8Nr1UtB1Fp4DbOKu4+OovlxezntakHkKyu16mBr9I74YIbQEZOiTp4LmFGvfymZtR7d+KPG/kEcrjJj/5WV/rFz+QA9ZgVN+i3D4Dpt8hpezyxxOR/brtDbb3pvmIcIlySRjPvZt9ZBUQtuVCeOU2FF0qAWJGtXnJofziS2X8SLjKl1LcyPFpk3C4geDiiDP1Kh+49Ksu15e2zwAO8PtcQ24vE9BlPrN1pUYlikgOFTmMNkUsi0jYYbm6ylxCLE972PvrTBpaQx9gWCztShJMh1GpQ+qvi7ItBFDMUjxg==
Received: from OL1P279CA0056.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:15::7) by
 GV1PR10MB6513.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:81::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Wed, 4 Jan 2023 04:09:21 +0000
Received: from HE1EUR01FT094.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:15:cafe::cc) by OL1P279CA0056.outlook.office365.com
 (2603:10a6:e10:15::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.14 via Frontend
 Transport; Wed, 4 Jan 2023 04:09:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 HE1EUR01FT094.mail.protection.outlook.com (10.152.0.253) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5966.17 via Frontend Transport; Wed, 4 Jan 2023 04:09:20 +0000
Received: from CNPEK01M05MSX.ad011.siemens.net (139.24.237.222) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1118.20; Wed, 4 Jan 2023 05:09:19 +0100
Received: from CNPEK01M09MSX.ad011.siemens.net (139.24.237.227) by
 CNPEK01M05MSX.ad011.siemens.net (139.24.237.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 12:09:16 +0800
Received: from CNPEK01M09MSX.ad011.siemens.net ([139.24.237.227]) by
 CNPEK01M09MSX.ad011.siemens.net ([139.24.237.227]) with mapi id
 15.01.2507.016; Wed, 4 Jan 2023 12:09:16 +0800
From: "Wang, Jing" <wangjing@siemens.com>
To: "Schild, Henning" <henning.schild@siemens.com>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: Re: [isar-cip-core][PATCH 6/6] change-root-homedir: split root home move into own package
Thread-Topic: [isar-cip-core][PATCH 6/6] change-root-homedir: split root home
 move into own package
Thread-Index: AQHZHszjnJCb/ULBNkOU+AuyFX2z4a6MZFuAgAA4sgCAAQfDEA==
Date: Wed, 4 Jan 2023 04:09:16 +0000
Message-ID: <78298bd0cf0942b19e1157eccd58fa7c@siemens.com>
References: <20230102170818.17689-1-henning.schild@siemens.com>
	<20230102170818.17689-7-henning.schild@siemens.com>
	<9ab8ffb5-cab6-3fe0-ae2a-df9c2e5f772d@siemens.com>
 <20230103211720.4e7ea875@md1za8fc.ad001.siemens.net>
In-Reply-To: <20230103211720.4e7ea875@md1za8fc.ad001.siemens.net>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-01-04T04:09:14Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=76d6fd44-0b40-47d0-a2bb-0ebad39ba527;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
x-originating-ip: [139.24.236.126]
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT094:EE_|GV1PR10MB6513:EE_
X-MS-Office365-Filtering-Correlation-Id: 130431bf-1f5e-4359-671e-08daee097495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	d+XOx4JiHllntqAcYemZx2QYO3ilyqYgEpL/B1eqjEGks3AF24MmhOns0BASPJxLDs8KUrJtdjni8FLmDiFBL6kXNfI1iHlnmm9Ku/lAbQDCxy1K9Wo3SMepXeNcUBOw5KM8s4rjuiAso+oVkea+6QrLMTK8uYPCc94G1b07snJF0/feHlCkF92vu8RQCn8UrW1+gspPhFXVgtlh36EI+odhsYRt0sUAsaIA8OCoSJQ+/G3ndwSxLzV5LWH1RShsLSOkvX4Gcm2KJVgFQwIJXcioEDF2Fv0Nr1uHkwSadwyd6HxkbPHEz5WOVnhXpLLLXWj333Vvo8GHCFkTt5f6IzHYij9z23TDN8+IZUiZiXjR51XkbDtyAWE8sRiIQLr5zL41z1ILjt7b8BdChNjbeESNKF4kvhNR8B6WGV1td69GkEf6cuUFfVDfyu4pTlXRdLujmIwNxxHWeCRnZPccUDXaON6kTx1ZN0z7jExozzHE9zzWD47MwZ5FP51KQN6OLEoDrYIP7N0Fp9WPe6h17h8wYgt8zj0bM8DziMGepSTqCzRz5QPtJvB7rvenSlUfn8A92V8ggpqS7DdFrOMkvOPS6gAJEyJNuJonKLHXiWWoeBMX6DQJl3VRP/PIW0Z+8QN325vhOUyLCXtaD3JZX4/+jsWXe6KmPkBm+kSRQGqvZasbJYAh4Skpb44iYsqF/MF8svEUsZ/77hLeZfnSnGV0Es+69V8RTG3D4PKOAtg=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(4326008)(8936002)(6862004)(8676002)(54906003)(6636002)(2906002)(53546011)(70586007)(70206006)(5660300002)(37006003)(316002)(478600001)(41300700001)(108616005)(24736004)(40460700003)(186003)(26005)(82740400003)(81166007)(956004)(336012)(47076005)(2616005)(83380400001)(82310400005)(36756003)(82960400001)(356005)(36860700001)(40480700001)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 04:09:20.3317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 130431bf-1f5e-4359-671e-08daee097495
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT094.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6513
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jan 2023 12:37:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10298

SGkgSGVubmluZywNCg0KVGhhbmtzIGZvciB5b3VyIHRoaXMgUEFUQ0ggaW5mb3JtYXRpb24hIEJ1
dCBzaW5jZSBub3cgSSdtIHN0aWxsIE5PVCBmYW1pbGlhciB3aXRoIGhvdyB0byBzdWJtaXQgaXNh
ci1jaXAtY29yZSBQQVRDSCBwcm9jZXNzIGFuZCBhbHNvIHdpdGhvdXQgdGhlIHJlbGF0ZWQgYWNj
b3VudCBhbmQgcGVybWlzc2lvbiwgSSdsbCBhcHByZWNpYXRlIHlvdSBjYW4gY29udGludWUgdGhp
cyBQQVRDSCB0aGlzIHRpbWUuIE9mIGNvdXJzZSwgSSdsbCBsZWFybiBob3cgdG8gY29udHJpYnV0
ZSBQQVRDSCB0byBpc2FyLWNpcC1jb3JlIGFuZCBtYXliZSBJIGNhbiB0YWtlIG92ZXIgaW4gdGhl
IGZ1dHVyZSDwn5iKDQoNCkFsc28gZGlzY3Vzc2VkIHdpdGggTWFydGluLCBzaW5jZSB0aGlzIFBB
VENIIGlzIE5PVCB2ZXJ5IGhpZ2ggcHJpb3JpdHkgZm9yIEp1cGl0ZXItY29yZSwgdGhlbiB3ZSBt
aWdodCBwaWNrIHVwIHRoZSBpc2FyLWNpcC1jb3JlIGxhdGVzdCB2ZXJzaW9uIGZyb20gbWFzdGVy
IG9uY2UgaXQncyBpbnRlZ3JhdGVkIGluIHRoZSBmdXR1cmUuDQoNClRoYW5rIHlvdSBzbyBtdWNo
IQ0KDQpCUg0KV2FuZyBKaW5nDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBT
Y2hpbGQsIEhlbm5pbmcgKFQgQ0VEIFNFUy1ERSkgPGhlbm5pbmcuc2NoaWxkQHNpZW1lbnMuY29t
PiANClNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSA0LCAyMDIzIDQ6MTcgQU0NClRvOiBXYW5nLCBK
aW5nIChESSBGQSBDVFIgU1ZDJkFJIENOKSA8d2FuZ2ppbmdAc2llbWVucy5jb20+DQpDYzogS2lz
emthLCBKYW4gKFQgQ0VEKSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT47IGNpcC1kZXZAbGlzdHMu
Y2lwLXByb2plY3Qub3JnDQpTdWJqZWN0OiBSZTogW2lzYXItY2lwLWNvcmVdW1BBVENIIDYvNl0g
Y2hhbmdlLXJvb3QtaG9tZWRpcjogc3BsaXQgcm9vdCBob21lIG1vdmUgaW50byBvd24gcGFja2Fn
ZQ0KDQpXYW5nIEppbmcgbWF5YmUgeW91IHdhbnQgdG8gYWRkcmVzcyB0aG9zZSBjb21tZW50cyBh
bmQgc2VuZCB0aGlzIG9uZSBhZ2Fpbj8NCg0KSWYgc28geW91IHNob3VsZCBvbmx5IHVzZSB0aGlz
IHBhdGNoLCBjaGFuZ2UgaXQgYW5kIGFkZCB5b3VyIFNpZ25lZC1PZmYuIFlvdSBjb3VsZCBldmVu
IG1ha2UgeW91cnNlbGYgdGhlIGF1dGhvciBhbmQgZHJvcCBteSBTaWduZWQtT2ZmIGlmIHlvdSB3
YW50LiBJIHRoaW5rIHRoZSBsYXR0ZXIgd291bGQgYmUgdGhlIGJlc3QgaWRlYSBpZiB5b3UgdG9v
ayBvdmVyLg0KDQpGdXJ0aGVyIHlvdSB3YW50IHRvIGFkZCBhIGNvdmVyIGxldHRlciB3aGVyZSB5
b3UgbWVudGlvbiB0aGF0IHlvdSBhcmUgYmFzZWQgb24gbmV4dCBhbmQgYWRkIGEgImNoYW5nZWQg
c2luY2UgdjEiIHNlY3Rpb24gdG8gdGhhdCBjb3ZlciBsZXR0ZXIuDQoNClBsZWFzZSByZXBseSBp
ZiBvciBpZiBub3QgeW91IHdhbnQgdG8gY29udGludWUgaGVyZS4gSSB3aWxsIG9ubHkgcGljayB0
aGlzIHVwIGFnYWluIHdoZW4gaSBoZWFyIGZyb20geW91Lg0KDQpIZW5uaW5nDQoNCkFtIFR1ZSwg
MyBKYW4gMjAyMyAxNzo1NDoyNSArMDEwMA0Kc2NocmllYiBKYW4gS2lzemthIDxqYW4ua2lzemth
QHNpZW1lbnMuY29tPjoNCg0KPiBPbiAwMi4wMS4yMyAxODowOCwgSGVubmluZyBTY2hpbGQgd3Jv
dGU6DQo+ID4gQ2hhbmdpbmcgdGhlIGhvbWVkaXIgb2Ygcm9vdCB0aGF0IHdheSBpcyByZXF1aXJl
ZCBieSBhbnkgbGF5ZXIgdGhhdCANCj4gPiB0YWtlcyBybyByb290ZnMgcGllY2VzIGZyb20gaGVy
ZS4gTWFraW5nIGl0IGl0cyBvd24gcGFja2FnZSBhbGxvd3MgDQo+ID4gcmV1c2Ugd2l0aG91dCBo
YXZpbmcgdG8gdGFrZSBzb21lIG90aGVyIGN1c3RvbWl6YXRpb25zLg0KPiA+IA0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEhlbm5pbmcgU2NoaWxkIDxoZW5uaW5nLnNjaGlsZEBzaWVtZW5zLmNvbT4NCj4g
PiAtLS0NCj4gPiAgLi4uL2NoYW5nZS1yb290LWhvbWVkaXIuYmIgICAgICAgICAgICAgICAgICAg
IHwgIDUgKysrKysNCj4gPiAgLi4uL2NoYW5nZS1yb290LWhvbWVkaXIvZmlsZXMvcG9zdGluc3Qg
ICAgICAgIHwgMjENCj4gPiArKysrKysrKysrKysrKysrKysrIHJlY2lwZXMtY29yZS9jdXN0b21p
emF0aW9ucy9jb21tb24uaW5jICAgICAgICB8DQo+ID4gIDUgKysrLS0gcmVjaXBlcy1jb3JlL2N1
c3RvbWl6YXRpb25zL2ZpbGVzL3Bvc3RpbnN0ICAgIHwgIDggLS0tLS0tLQ0KPiA+ICA0IGZpbGVz
IGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKSAgY3JlYXRlIG1vZGUg
DQo+ID4gMTAwNjQ0IHJlY2lwZXMtY29yZS9jaGFuZ2Utcm9vdC1ob21lZGlyL2NoYW5nZS1yb290
LWhvbWVkaXIuYmIgDQo+ID4gY3JlYXRlIG1vZGUNCj4gPiAxMDA2NDQgcmVjaXBlcy1jb3JlL2No
YW5nZS1yb290LWhvbWVkaXIvZmlsZXMvcG9zdGluc3QNCj4gPiANCj4gPiBkaWZmIC0tZ2l0DQo+
ID4gYS9yZWNpcGVzLWNvcmUvY2hhbmdlLXJvb3QtaG9tZWRpci9jaGFuZ2Utcm9vdC1ob21lZGly
LmJiDQo+ID4gYi9yZWNpcGVzLWNvcmUvY2hhbmdlLXJvb3QtaG9tZWRpci9jaGFuZ2Utcm9vdC1o
b21lZGlyLmJiIG5ldyBmaWxlIA0KPiA+IG1vZGUgMTAwNjQ0IGluZGV4IDAwMDAwMDAwMDAwMC4u
ZGM0NjMxYmQ2YjE2IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9yZWNpcGVzLWNvcmUvY2hhbmdl
LXJvb3QtaG9tZWRpci9jaGFuZ2Utcm9vdC1ob21lZGlyLmJiDQo+ID4gQEAgLTAsMCArMSw1IEBA
DQo+IA0KPiBNaXNzaW5nIGNvcHlyaWdodCBoZWFkZXIuDQo+IA0KPiA+ICtpbmhlcml0IGRwa2ct
cmF3DQo+ID4gKw0KPiA+ICtERVNDUklQVElPTiA9ICJNb3ZlIHJvb3RzIGhvbWVkaXIgdG8gL2hv
bWUgZm9yIHJlYWQtb25seSByb290ZnMiDQo+ID4gKw0KPiA+ICtTUkNfVVJJID0gImZpbGU6Ly9w
b3N0aW5zdCINCj4gPiBkaWZmIC0tZ2l0IGEvcmVjaXBlcy1jb3JlL2NoYW5nZS1yb290LWhvbWVk
aXIvZmlsZXMvcG9zdGluc3QNCj4gPiBiL3JlY2lwZXMtY29yZS9jaGFuZ2Utcm9vdC1ob21lZGly
L2ZpbGVzL3Bvc3RpbnN0IG5ldyBmaWxlIG1vZGUNCj4gPiAxMDA2NDQgaW5kZXggMDAwMDAwMDAw
MDAwLi4yMDVlZTQ4MzllODINCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvcmVjaXBlcy1j
b3JlL2NoYW5nZS1yb290LWhvbWVkaXIvZmlsZXMvcG9zdGluc3QNCj4gPiBAQCAtMCwwICsxLDIx
IEBADQo+ID4gKyMhL2Jpbi9zaA0KPiA+ICsjDQo+ID4gKyMgQ0lQIENvcmUsIGdlbmVyaWMgcHJv
ZmlsZQ0KPiA+ICsjDQo+ID4gKyMgQ29weXJpZ2h0IChjKSBTaWVtZW5zIEFHLCAyMDE5DQo+IA0K
PiBNYXliZSB1cGRhdGUgdG8gIjIwMTktMjAyMyIgYXQgdGhpcyBjaGFuY2UuDQo+IA0KPiA+ICsj
DQo+ID4gKyMgQXV0aG9yczoNCj4gPiArIyAgSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5z
LmNvbT4gIyAjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiANCj4gPiArTUlUICMNCj4gPiArDQo+
ID4gK3NldCAtZQ0KPiA+ICsNCj4gPiArIyBuZWVkZWQgZm9yIHJlYWQtb25seSByb290ZnMgd2l0
aCB3cml0YWJsZSAvaG9tZSBpZiBbICEgLUwgL3Jvb3QgDQo+ID4gK107IHRoZW4NCj4gPiArCSMg
dXNlcm1vZCAtLW1vdmUtaG9tZSBjYW4gbm90IGJlIHVzZWQgd2hpbGUgdGhlIHRhcmdldCB1c2Vy
DQo+ID4gKwkjIGhhcyBydW5uaW5nIHByb2Nlc3NlcywgYWxzbyB3ZSBrZWVwIGEgc3ltbGluayBo
ZXJlDQo+ID4gKwltdiAvcm9vdCAvaG9tZS8NCj4gPiArCWxuIC1zIC9ob21lL3Jvb3QgL3Jvb3QN
Cj4gPiArZmkNCj4gPiBkaWZmIC0tZ2l0IGEvcmVjaXBlcy1jb3JlL2N1c3RvbWl6YXRpb25zL2Nv
bW1vbi5pbmMNCj4gPiBiL3JlY2lwZXMtY29yZS9jdXN0b21pemF0aW9ucy9jb21tb24uaW5jIGlu
ZGV4IA0KPiA+IDExMjRmZjJkMzU5MC4uMjRjODYyYzMyZTNiIDEwMDY0NCAtLS0gDQo+ID4gYS9y
ZWNpcGVzLWNvcmUvY3VzdG9taXphdGlvbnMvY29tbW9uLmluYyArKysgDQo+ID4gYi9yZWNpcGVz
LWNvcmUvY3VzdG9taXphdGlvbnMvY29tbW9uLmluYyBAQCAtMjIsMTAgKzIyLDExIEBAIFNSQ19V
UkkgDQo+ID4gPSAiIFwgV0lSRUxFU1NfRklSTVdBUkVfUEFDS0FHRSA/PSAiIg0KPiA+ICBJTlNU
QUxMX1dJUkVMRVNTX1RPT0xTID8/PSAiMCINCj4gPiAgDQo+ID4gLURFUEVORFMgKz0gInNzaGQt
cmVnZW4ta2V5cyINCj4gPiArREVQRU5EUyArPSAic3NoZC1yZWdlbi1rZXlzIGNoYW5nZS1yb290
LWhvbWVkaXIiDQo+ID4gIA0KPiA+ICBERUJJQU5fREVQRU5EUyA9ICIgXA0KPiA+IC0gICAgaWZ1
cGRvd24sIGlzYy1kaGNwLWNsaWVudCwgbmV0LXRvb2xzLCBpcHV0aWxzLXBpbmcsIHNzaCwNCj4g
PiBzc2hkLXJlZ2VuLWtleXMgXA0KPiA+ICsgICAgaWZ1cGRvd24sIGlzYy1kaGNwLWNsaWVudCwg
bmV0LXRvb2xzLCBpcHV0aWxzLXBpbmcsIHNzaCwNCj4gPiBzc2hkLXJlZ2VuLWtleXMsIFwNCj4g
PiArICAgIGNoYW5nZS1yb290LWhvbWVkaXIgXA0KPiA+ICAgICAgJHtAKCcsIGl3LCB3aXJlbGVz
cy1yZWdkYiwgJyArDQo+ID4gZC5nZXRWYXIoJ1dJUkVMRVNTX0ZJUk1XQVJFX1BBQ0tBR0UnKSkg
XCBpZg0KPiA+IGQuZ2V0VmFyKCdJTlNUQUxMX1dJUkVMRVNTX1RPT0xTJykgPT0gJzEnIGVsc2Ug
Jyd9IiANCj4gPiBkaWZmIC0tZ2l0IGEvcmVjaXBlcy1jb3JlL2N1c3RvbWl6YXRpb25zL2ZpbGVz
L3Bvc3RpbnN0DQo+ID4gYi9yZWNpcGVzLWNvcmUvY3VzdG9taXphdGlvbnMvZmlsZXMvcG9zdGlu
c3QgaW5kZXgNCj4gPiA3YTBiMDBkOTg2ODAuLjdlN2VhMzY5MjMyNSAxMDA2NDQgLS0tIA0KPiA+
IGEvcmVjaXBlcy1jb3JlL2N1c3RvbWl6YXRpb25zL2ZpbGVzL3Bvc3RpbnN0ICsrKyANCj4gPiBi
L3JlY2lwZXMtY29yZS9jdXN0b21pemF0aW9ucy9maWxlcy9wb3N0aW5zdCBAQCAtMjEsMTEgKzIx
LDMgQEAgZmkgIA0KPiA+IEhPU1ROQU1FPWRlbW8gIGVjaG8gIiRIT1NUTkFNRSIgPiAvZXRjL2hv
c3RuYW1lICBlY2hvICIxMjcuMC4wLjEgDQo+ID4gJEhPU1ROQU1FIiA+PiAvZXRjL2hvc3RzDQo+
ID4gLQ0KPiA+IC0jIG5lZWRlZCBmb3IgcmVhZC1vbmx5IHJvb3RmcyB3aXRoIHdyaXRhYmxlIC9o
b21lIC1pZiBbICEgLUwgL3Jvb3QgDQo+ID4gXTsgdGhlbg0KPiA+IC0JIyB1c2VybW9kIC0tbW92
ZS1ob21lIGNhbiBub3QgYmUgdXNlZCB3aGlsZSB0aGUgdGFyZ2V0IHVzZXINCj4gPiAtCSMgaGFz
IHJ1bm5pbmcgcHJvY2Vzc2VzLCBhbHNvIHdlIGtlZXAgYSBzeW1saW5rIGhlcmUNCj4gPiAtCW12
IC9yb290IC9ob21lLw0KPiA+IC0JbG4gLXMgL2hvbWUvcm9vdCAvcm9vdA0KPiA+IC1maQ0KPiAN
Cj4gSmFuDQo+IA0KDQo=

