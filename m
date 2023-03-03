Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4BFC678D4
	for <webhook@archiver.kernel.org>; Fri,  3 Mar 2023 13:12:26 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.72])
 by mx.groups.io with SMTP id smtpd.web11.18964.1677832513694331170
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Mar 2023 00:35:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Ly/u/I2R;
 spf=pass (domain: siemens.com, ip: 40.107.247.72, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtOjvSNwKa8StKoZYBeZFDV06ugVFmejMeZh0z6Ex4sydcxWrkjdhTX7OkTWIx4CTaFGL1U2HWlgbP8yhpWIMRFrEeI2G39eimNMaqMCUQA2R8aOSN8Xrccpax47M5BBo/Sw6Ki+3lpP6GY+CUHw8GzfECulP0ssId0FWoVaGXm/40WpIxefVMb6dz3A9N+lHzsKL08FFTVn3lu+Kxk/FHmukbvVHZWqqRTuyV98cVVGjMLSTimqiPt4UQpYWJjSzbEFzEjRSPA1Tjvkl1POsAPab6y5aGIF43Bq45SFZOi+i5B9cGjpXqVtlMRv/QRRyZeEbj3Dt/a/dw1uWa+ppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LkJbLrNmMuO0EwZwdwMqpdHrPqZx4M4tyw7FCRB2wk=;
 b=cvJA3hrVDYMw8j5SqD1e1kXLdG8u1dyqt7Ut4iclmAj9G4ViMkTITZbx3QUutK09mrVfh3UYCWPKsiBtpWEGxSXKVMA/vrpRn23vQX1To2/fIs+TvpZR7nPWhOL0kF8h9Q4h5R17lFJBL4JpvU/bsZQfqJ7sGFARWqmTh/6uQOtkT8eXR99E+U4BUy4+9+yTem3/Ip2x5b7jS4kZb/35q72ugC7NvlfCYWBRsazD7UbFp9D4XRzxChFl+lkOVwC7wSxiod0UqX5RIh4IZPJiysX9FLE+lQ8Rbxd0c9O9OlKlZzXxf/TTLCoifDm0syKZIscXmRFGQsYGfgdBqY7kvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LkJbLrNmMuO0EwZwdwMqpdHrPqZx4M4tyw7FCRB2wk=;
 b=Ly/u/I2RzTItIeySOQEirPPqg62+ZC3BScYF5BdrHCJJgXIdKhcu9TLkY6+br497IVB5Yn8DIel9PSutbLTCpwVM/KPVwjvzOzaK+1NzgCGbQ9oqhah6Ciyomz0Vem/ePled9fCHkXBOaRyTgvFnEIWnVWymv26gm1veEQ+E1cvMQbkWCfdK79TRRbb8fBuACH00rNLLQAALv0QLpmEXaZV0m2INatzpWVOMRRv9iKtYOu44HpdI5TeFAB/QkZDUZeDyaypY9BUpbt8OHm+/HtPL83a5fjQGCeeICQ2V8uRcJ/WzNnfD5lGvpxUy64hsGf7LZW3fz3aCuy9cVcNNIg==
Received: from GV3P280CA0090.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:a::31) by
 PAVPR10MB6987.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:304::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Fri, 3 Mar
 2023 08:35:10 +0000
Received: from HE1EUR01FT046.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:a:cafe::f7) by GV3P280CA0090.outlook.office365.com
 (2603:10a6:150:a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22 via Frontend
 Transport; Fri, 3 Mar 2023 08:35:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 HE1EUR01FT046.mail.protection.outlook.com (10.152.0.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.19 via Frontend Transport; Fri, 3 Mar 2023 08:35:10 +0000
Received: from CNPEK01M10MSX.ad011.siemens.net (139.24.237.228) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1118.25; Fri, 3 Mar 2023 09:35:09 +0100
Received: from CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) by
 CNPEK01M10MSX.ad011.siemens.net (139.24.237.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 3 Mar 2023 16:35:06 +0800
Received: from CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) by
 CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) with mapi id
 15.01.2507.021; Fri, 3 Mar 2023 16:35:06 +0800
From: "Moessbauer, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
CC: "Bovensiepen, Daniel (bovi)" <daniel.bovensiepen@siemens.com>, "Gylstorff,
 Quirin" <quirin.gylstorff@siemens.com>
Subject: Re: [isar-cip-core][PATCH v3 6/9] enhance qemu-riscv64 machine to be testable
Thread-Topic: [isar-cip-core][PATCH v3 6/9] enhance qemu-riscv64 machine to be
 testable
Thread-Index: AQHZTRuUigT7mLWieEqsq3lM5CrrM67oHuOAgAAW4oA=
Date: Fri, 3 Mar 2023 08:35:06 +0000
Message-ID: <e4f08920de44bca9d04ed3b3fb6787d059480002.camel@siemens.com>
References: <20230302152659.2096307-1-felix.moessbauer@siemens.com>
	 <20230302152659.2096307-7-felix.moessbauer@siemens.com>
	 <ee664f4e-64ea-10d5-e53a-87b5773f90d0@siemens.com>
In-Reply-To: <ee664f4e-64ea-10d5-e53a-87b5773f90d0@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1+deb11u1 
x-originating-ip: [144.145.220.58]
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT046:EE_|PAVPR10MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c0b2e2b-d381-4eec-cc96-08db1bc23376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	zrkYlqZUWRTKVaDQ6YsR02ta24RQZufCLKHFoEQ8QiJtlHcw96UkaRtJSCK3tJaBCD1HlL81un/vkKypO5siO8LCb+IimP0ZhQIVBwMwO3jTApLgOdcegrgSgT30WpFG6nO+zkzcWpZO8fTKj5yQTyqnNIBFb+J2jKau0GQIPLbe/sI0M1mCEs+00w7NjXiNQ9QMPE5t81LOu5qkeR9GOMUtX6S9+5SKoDIHQZ3guDHbxJFxtskmGTAgZc04TTG84W5/TuMMeaeOY5YyQ/sx9nnBHhfN7tI+kVI5NEscbFv4fKUa5By3wSjBohP77V2wUcuc9FJcQK6kOTb0emnDQ5o0ihEITctoh/vJLLLucg7ST723A5Zw2zIoCXiuIa74iEqlRQKkJIl8UZP6srF+XfkedqHneLshp/sEXaXE5sVy2vZCj93ikpHXXilWXsOl5O3giTgqi4MeepsTzlwtZ9mthA+Lx3AI5UQLzf3duAOM4WfNFqDY4rXRTa/h4fY7d0QFvRGtBGki83PP307oV94ldnDY5kVVCY1M/dS40ZzirzbNMswLHIpPEhYgCzrnIoRE4uJj9iKJu70e+L8T1liMqKFpUdBAnJX24DRTpMdx7FzYDd/OGoCrez4RYOVrLIhkOfDxxAZ14atzTlOpcaK0uiyCjfJ7fru+yTUyQXhU5o02wb1zaZtKcqJEf7ZFHiOPJMD0aPrfge4uYI+xXw==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199018)(36840700001)(40470700004)(46966006)(36860700001)(82960400001)(82740400003)(7596003)(356005)(7636003)(86362001)(70206006)(36756003)(41300700001)(8936002)(2906002)(40480700001)(8676002)(4326008)(5660300002)(82310400005)(70586007)(40460700003)(336012)(2616005)(956004)(53546011)(26005)(83380400001)(110136005)(47076005)(186003)(316002)(54906003)(6636002)(107886003)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 08:35:10.2992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0b2e2b-d381-4eec-cc96-08db1bc23376
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT046.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6987
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF024A7A6BB7A44CB111ACB4C5262333@siemens.com>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Mar 2023 13:12:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10901

T24gRnJpLCAyMDIzLTAzLTAzIGF0IDA4OjEzICswMTAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAwMi4wMy4yMyAxNjoyNiwgRmVsaXggTW9lc3NiYXVlciB3cm90ZToNCj4gPiBUaGlzIHBhdGNo
IGVuaGFuY2VzIHRoZSBxZW11LXJpc2N2NjQgbWFjaGluZSBieSBhZGRpbmcgYSByZWZlcmVuY2UN
Cj4gPiB0bw0KPiA+IHUtYm9vdC4gRnVydGhlciwgd2Ugbm93IHVzZSB0aGUgcWVtdV9yaXNjdjY0
IGRlZmNvbmZpZyBmcm9tDQo+ID4gY2lwLWtlcm5lbC1jb25maWcuDQo+ID4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogRmVsaXggTW9lc3NiYXVlciA8ZmVsaXgubW9lc3NiYXVlckBzaWVtZW5zLmNvbT4N
Cj4gPiAtLS0NCj4gPiDCoGNvbmYvbWFjaGluZS9xZW11LXJpc2N2NjQuY29uZiB8IDkgKysrKysr
KystDQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
DQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2NvbmYvbWFjaGluZS9xZW11LXJpc2N2NjQuY29uZiBi
L2NvbmYvbWFjaGluZS9xZW11LQ0KPiA+IHJpc2N2NjQuY29uZg0KPiA+IGluZGV4IGYxZjNlODcu
LjhjMTc2NGIgMTAwNjQ0DQo+ID4gLS0tIGEvY29uZi9tYWNoaW5lL3FlbXUtcmlzY3Y2NC5jb25m
DQo+ID4gKysrIGIvY29uZi9tYWNoaW5lL3FlbXUtcmlzY3Y2NC5jb25mDQo+ID4gQEAgLTEyLDQg
KzEyLDExIEBADQo+ID4gwqBESVNUUk9fQVJDSCA9ICJyaXNjdjY0Ig0KPiA+IMKgDQo+ID4gwqBJ
TUFHRV9GU1RZUEVTID89ICJleHQ0Ig0KPiA+IC1LRVJORUxfREVGQ09ORklHID89ICJkZWZjb25m
aWciDQo+ID4gK1VTRV9DSVBfS0VSTkVMX0NPTkZJRyA9ICIxIg0KPiA+ICsNCj4gPiArS0VSTkVM
X0RFRkNPTkZJRyA/PSAiY2lwLWtlcm5lbC0NCj4gPiBjb25maWcvJHtLRVJORUxfREVGQ09ORklH
X1ZFUlNJT059L3Jpc2N2L3FlbXVfcmlzY3Y2NF9kZWZjb25maWciDQo+ID4gKw0KPiA+ICsjIGZv
ciBTV1VwZGF0ZSBzZXR1cHM6IHdhdGNoZG9nIGlzIGNvbmZpZ3VyZWQgaW4gVS1Cb290DQo+IA0K
PiBJcyB0aGF0IHRydWUgZm9yIHFlbXUsIG9yIGlzIHRoYXQganVzdCBhIGNvcHktYW5kLXBhc3Rl
IHN0YXRlbWVudD8NCg0KQWN0dWFsbHksIEkganVzdCBjb3BpZWQgdGhhdCBmcm9tIHRoZSBhcm02
NCBleGFtcGxlLiBCdXQgaGF2aW5nIGENCnNlY29uZCBsb29rIGF0IHRoZSBjb2RlLCBtYWtlcyBt
ZSB0aGluayB0aGF0IGl0IGlzIGFsc28gd3JvbmcgdGhlcmU6DQoNCi0gdGhlIHUtYm9vdCBvcHRp
b24gQ09ORklHX0hXX1dBVENIRE9HIGlzIG5vdCBzZXQNCi0gdGhlIHN0YXJ0LXFlbXUuc2ggc2Ny
aXB0IGRvZXMgbm90IHNldHVwIGFueSB3YXRjaGRvZyBpbiBRRU1VDQoNCkluIHNob3J0OiBJdCB3
b3JrcywgYmVjYXVzZSB3ZSBkb24ndCBoYXZlIGEgd2F0Y2hkb2cgYW5kIG5vYm9keSBlbmFibGVz
DQppdC4NCg0KQnV0IEknbSBub3QgYW4gZXhwZXJ0IGluIHRoaXMgZG9tYWluLiBNYXliZSBRdWly
aW4gY2FuIGJyaWVmbHkgY29tbWVudA0Kb24gdGhlIGludGVudGlvbiBvZiB0aGUgb3JpZ2luYWwg
Y29kZS4NCg0KRmVsaXgNCg0KPiANCj4gPiArV0RPR19USU1FT1VUID0gIjAiDQo+ID4gKw0KPiA+
ICtQUkVGRVJSRURfUFJPVklERVJfdS1ib290LSR7TUFDSElORX0gPSAidS1ib290LXFlbXUtcmlz
Y3Y2NCINCj4gDQo+IEphbg0KPiANCg0K

