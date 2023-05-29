Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B3FC7EE2E
	for <webhook@archiver.kernel.org>; Mon, 29 May 2023 12:43:53 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.89])
 by mx.groups.io with SMTP id smtpd.web10.46654.1685356089302700393
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 May 2023 03:28:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=J3vjh1pp;
 spf=pass (domain: siemens.com, ip: 40.107.14.89, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/KxkENhMkSl/8ms0KFgyvsgj/2sYaxoijS1pJg9UBjY8OJm8xOmwXvgUsrIO1OoS3mxGZc4jWrz0uQ47YyZgqTm1y64t4zJJF3tEd7tKjmPZo+ndhCwoox2SyK/sBz6OERrCxlvtlPFLCwyLV5dYkTjTrTMkwMkTZChsa+GHy3kQjBdSHV2gFXpcPx8yslo1buaRGjXq8VMPiIzJ0aCa2seRuzM3j7viuEZC6DGZEMq+jBHSlxCllT5Lw+qlSuSann4HGX7vBN6WHu3/kZkjVZgscLuGl144o/Q0KdBkGYuwxo7FQnVBXmho97LLAh2f2sM6QZRTP2plPUMXRMXtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XHPSk+xC0rA3tjGWruPXxqO1SRkdcc4VeUSdsIGCbs=;
 b=U4CLB98Nxj3aAK94vAxNNXCtyV6JzD+uOiAlFlIoGkyszeJ8T/ISm32TS24jDnuiCrHG9UjjifwIppsLILPUbuVeQdzQ4fpfGiWrdz8HhzEY2jcOZ41IjhdG1K9+n3QzdTWfFScrqksKM8vAlgMJ0VVbFLoHSEYGrnvAeKraRvqccGiZBeu2a2M35z2RTVOJip0SKzxOmFyxogPuLruyE73huT+rLg71ZOYTKi4U+NLSIIpLXqrCm56nBc1WQvoHIKjK7ia1vnPYb7bkbB3a3CwkZynkvjTLE17jksTKIlpoBEn1EHvPT/yHpCGTx9/rRLIP1lRi7lPtZz2KQyisKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XHPSk+xC0rA3tjGWruPXxqO1SRkdcc4VeUSdsIGCbs=;
 b=J3vjh1pp38lQVNISk9gEbdeQ/x0Uvf5i4mbfspx2bT1ECLBXcApHOahX4FG7aUkws8Qy6/L8MvogR/2NF9WVkt0FJWtdyuQnRWUZdFFSHnRRJHXYtdTFjkyPOrGVjwSNw8gkrXAkPzS++YKZHDfMRpseCVU4oppcDgG6NkiULMaXFnCGApv9+NeZlVJ/74umFBEMKoLg6PA8xiShMI9ZJLo0JCtvrPVSbpY0JCM2Isv3Tvz6539CGzF9ZlGzKn4Tj3kjVCHbDShm5sNcJ3Flqc/v+2IFFUvJWPS4zn9iMa287sj3z0Heu2fepRqfMNGzD1rUhPMRsuA/Mzq5+oubzA==
Received: from FR3P281CA0109.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a3::9) by
 DU2PR10MB7884.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:49b::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.22; Mon, 29 May 2023 10:28:05 +0000
Received: from VE1EUR01FT023.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:a3:cafe::8a) by FR3P281CA0109.outlook.office365.com
 (2603:10a6:d10:a3::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.20 via Frontend
 Transport; Mon, 29 May 2023 10:28:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 VE1EUR01FT023.mail.protection.outlook.com (10.152.2.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.18 via Frontend Transport; Mon, 29 May 2023 10:28:01 +0000
Received: from CNPEK01M10MSX.ad011.siemens.net (139.24.237.228) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1118.25; Mon, 29 May 2023 12:28:00 +0200
Received: from CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) by
 CNPEK01M10MSX.ad011.siemens.net (139.24.237.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 29 May 2023 18:27:57 +0800
Received: from CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) by
 CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) with mapi id
 15.01.2507.023; Mon, 29 May 2023 18:27:57 +0800
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
Subject: Re: [isar-cip-core][PATCH] squashfs: Calculate a smarter default SQUASHFS_MEMLIMIT
Thread-Topic: [isar-cip-core][PATCH] squashfs: Calculate a smarter default
 SQUASHFS_MEMLIMIT
Thread-Index: AQHZkLsXtklrDI4e1k2Pn9hwY6qRW69wiNyA
Date: Mon, 29 May 2023 10:27:57 +0000
Message-ID: <77f15adc8c93fcb3542abb215f00a7ec93f1bf17.camel@siemens.com>
References: <46e8b3a2-128f-c63a-cbfc-6d38a1792a35@siemens.com>
	 <5728b6ca-8c6a-9eb3-3926-e99cf7081414@siemens.com>
In-Reply-To: <5728b6ca-8c6a-9eb3-3926-e99cf7081414@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
x-originating-ip: [139.24.247.57]
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT023:EE_|DU2PR10MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a34b740-b3cb-479f-f267-08db602f6126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xinpq1J3ddB9fx8Zsk860IGoJwoKvyv+n6W5GFYikhICQ+hCmrnWKa5DMj/NtrYt0Ijt5Fx4dzt++RQvfnzlcbVErUo96YccRNgJ20s5YnSyrZhQBDrQqeHyf8Bza9SxIgV4iAPVEtqRgCNOkqUd4ZmAprGDqU71ioTnEJtquJGNpgjbcnESxRtmB3rw5hu6qWQU9ZYAkctTzsH4agYmiFq9MIhqbE6CsxTP9RiT3eIzeU1GzZ3aujGeAigSo9apoffw3pryN2WZfpukXRXkDBYK5scQUnaDdoewJsavFJc8Bg5ikRA3HR7yoUKhDzDyT8eQd+Fmbo4JuxkxMhpn6dV5GWvSbWqXrDGBM16Ch6s5x8XHO5TUhW73+Z5sYflZfyIhX+YFRzrC2asG71c/i9A5AdF6oBb3SC2FEewJacNnyAbs++v8uux+b06x1EDcrn36CPmFIjexRqStKeUSRN/DlnQ/vqYxnbrZHzPE83mh4n4OsneQeDKmlkN4TFP3LYvPSg+fBR1EbbcnfyBPABHYtF38Id3O+8V6CqyBV/5egEVPcAERfo0mZ/sUpQUIXX5WxlpKL4s/c6Cc7cd4OZLB099rXBVAwjR4rzH7GUBsv5lZqQao2zhfdLKHXo1cxKuvwS+FjTlA06DsrgLbaWZvSGWWIVJecwhP5RwQsxPu8+O+FqAZQMq+t/ZYzPvc7WeqdJbUIS8BWN72hQL9D2cygZU6tPuqueQibdrochWieKiQhtGQVQgs7vZPwJTr9Tjtxo4fr/X7gZ3eRp1Guw==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(36840700001)(46966006)(40470700004)(47076005)(36860700001)(26005)(186003)(41300700001)(956004)(2616005)(83380400001)(336012)(478600001)(110136005)(40460700003)(70206006)(70586007)(82740400003)(356005)(6636002)(82310400005)(40480700001)(82960400001)(316002)(81166007)(5660300002)(8936002)(8676002)(86362001)(36756003)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 10:28:01.1947
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a34b740-b3cb-479f-f267-08db602f6126
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT023.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7884
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <94EF12118F12124F8459446A2A4E28FC@siemens.com>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 May 2023 12:43:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11698

T24gU2F0LCAyMDIzLTA1LTI3IGF0IDE4OjQ4ICswMjAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBG
cm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiANCj4gVGhpcyBzaG91
bGQgb2Jzb2xldGUgbW9zdCAtIGlmIG5vdCBhbGwgLSBtYW51YWwgdHVuaW5nIGluIGNvbnN0cmFp
bmVkDQo+IHNldHVwcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEphbiBLaXN6a2EgPGphbi5raXN6
a2FAc2llbWVucy5jb20+DQo+IC0tLQ0KPiDCoGNsYXNzZXMvc3F1YXNoZnMuYmJjbGFzcyB8IDE0
ICsrKysrKysrKysrKy0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvY2xhc3Nlcy9zcXVhc2hmcy5iYmNsYXNz
IGIvY2xhc3Nlcy9zcXVhc2hmcy5iYmNsYXNzDQo+IGluZGV4IDFmMmE3NTk1Li5iMzliZTBjZCAx
MDA2NDQNCj4gLS0tIGEvY2xhc3Nlcy9zcXVhc2hmcy5iYmNsYXNzDQo+ICsrKyBiL2NsYXNzZXMv
c3F1YXNoZnMuYmJjbGFzcw0KPiBAQCAtOSw2ICs5LDE3IEBADQo+IMKgIyBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogTUlUDQo+IMKgIw0KPiDCoA0KPiArZGVmIGdldF9mcmVlX21lbSgpOg0KPiAr
wqDCoMKgIHRyeToNCj4gK8KgwqDCoMKgwqDCoMKgIHdpdGggb3BlbignL3Byb2MvbWVtaW5mbycp
IGFzIG1lbWluZm86DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxpbmVzID0gbWVtaW5mby5y
ZWFkbGluZXMoKQ0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmb3IgbGluZSBpbiBsaW5lczoN
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiBsaW5lLnN0YXJ0c3dpdGgoJ01l
bUF2YWlsYWJsZTonKToNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHJldHVybiBpbnQobGluZS5zcGxpdCgpWzFdKSAqIDEwMjQNCj4gK8KgwqDCoCBleGNlcHQgRmls
ZU5vdEZvdW5kRXJyb3I6DQo+ICvCoMKgwqDCoMKgwqDCoCBwYXNzDQo+ICvCoMKgwqAgcmV0dXJu
IDQqMTAyNCoxMDI0KjEwMjTCoCAjIDRHDQo+ICsNCj4gwqBJTUFHRVJfSU5TVEFMTDpzcXVhc2hm
cyArPSAic3F1YXNoZnMtdG9vbHMiDQo+IMKgDQo+IMKgU1FVQVNIRlNfRVhDTFVERV9ESVJTID89
ICIiDQo+IEBAIC0xNiw4ICsyNyw3IEBAIFNRVUFTSEZTX0NPTlRFTlQgPz0gIiR7UFBfUk9PVEZT
fSINCj4gwqBTUVVBU0hGU19DUkVBVElPTl9BUkdTID89ICIiDQo+IMKgDQo+IMKgU1FVQVNIRlNf
VEhSRUFEUyA/PSAiJHtAb2UudXRpbHMuY3B1X2NvdW50KGF0X2xlYXN0PTIpfSINCj4gLSMgZGVm
YXVsdCBhY2NvcmRpbmcgdG8gbWtzcXVhc2ZzIGRvY3MNCj4gLVNRVUFTSEZTX01FTUxJTUlUID89
ICI3OTgyTSINCj4gK1NRVUFTSEZTX01FTUxJTUlUID89ICIke0BpbnQoZ2V0X2ZyZWVfbWVtKCkg
KiAzLzQpfSINCg0KRGlkIHlvdSB0ZXN0IHRoaXMgcmVnYXJkaW5nIHJlcHJvZHVjaWJsZSBidWls
ZHM/DQpJJ20gYWxtb3N0IGNlcnRhaW5seSBzdXJlIHRoYXQgdGhpcyB3aWxsIGJyZWFrIHJlcHJv
ZHVjYWJpbGl0eS4NCg0KRmVsaXgNCg0KDQo+IMKgU1FVQVNIRlNfQ1JFQVRJT05fTElNSVRTID0g
Ii1tZW0gJHtTUVVBU0hGU19NRU1MSU1JVH0gLXByb2Nlc3NvcnMNCj4gJHtTUVVBU0hGU19USFJF
QURTfSINCj4gwqANCj4gwqBweXRob24gX19hbm9ueW1vdXMoKSB7DQoNCg==

