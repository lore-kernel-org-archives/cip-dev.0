Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C5BC77B7E
	for <webhook@archiver.kernel.org>; Mon, 29 May 2023 12:43:53 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.40])
 by mx.groups.io with SMTP id smtpd.web11.46783.1685355899204540076
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 May 2023 03:24:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=a3jWYgQL;
 spf=pass (domain: siemens.com, ip: 40.107.15.40, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHKk6qFoKzRehiGHisXRratpHMSe/TTx5b+XaJ7eFVer2TGae0nLC4dbGotabduycJ3/HRbDXMPvpF3ed7rU0nz+CzkypmyPK0MkwnMU9L7gKHGsx5ODWWPlHSV5Sp3mg9s6tiLiAwgJ2Zx0B9mS2AAop5PrWj/8Gp9BRnlzWUKvGSRputqzH46uV1e6AopV6b31yBggl9m032AuxK0OJWFx0CbtYUDy4gmGyzo5ORr41qATU5gs/+03aimS4Xi7MjuPiaOMF8ttTIzNllnYu53+dMhydZI+zDiiH2WLe80zLy35z09sQOYonKgi58RHw4C2M60GwblKwk6H7f1F5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjDar67fz33J18puZzjdGxUbghxhJfX4oj9S15y5Wdk=;
 b=AEhLG2Pczqb4ak6wh9FTMEm00Z/WtSKYI6eXSlF4Vvh6dFE/VQz22vxnSg6ZlisD7hL+8yTeadps2LeXt4KbVAdq+3NwEOQ1ooaDANXcKg5mbfwe7YsWUBd8NYRW2HKjusduA74ZDVbGkG0agSPnAypYWClxUTeyxQYuMr5sgvBWCNJFUpBj1dUYOaEfvgHeAmmwByjp3/TVUekShHpv3clAiqDthuGXHm8whxwOpuLG5ga/faTFyf1SnjOKRcgIxCRIwjGMeXhO9XJUNk0JU2ol7MV1m/goKCF22ib8FnlC7a8vND8Km5K0wlB2ph8WJMdm5nqqChSd2ZGlxoXxPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjDar67fz33J18puZzjdGxUbghxhJfX4oj9S15y5Wdk=;
 b=a3jWYgQLj67ytUgjh5fRaP6FdxepSTMdCuEnOHEM7063xZZPGaDB7woZ3TFNRXBfnFe0v0lCoVzab4mWc4XFQMGK6k0XjxGcix5lJTnvRI1UDbcAyveeWuLEqHEXM8zwBI90n/ykJCRBNG4fRl9RokkzEVQKHRpdI86EcmoHrtHXU8QgmcJt34zeFC0bb9V91BGOKo7ZFlWO4HUFUCPx3jnMBE8H6V76+LjTfjQJn2XtyVUSh+yuUVld90WOKzxvZElpWvpqKWhTtfs4S3ns1Ao7yCY+d/XAB/pQA/3cBINk6nXqzYoR53rF17ezkLDQmSTZnQ+R9JbflgjQX261HQ==
Received: from FR0P281CA0138.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:96::7) by
 PAWPR10MB7344.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2ea::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21; Mon, 29 May
 2023 10:24:56 +0000
Received: from VE1EUR01FT045.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:96:cafe::c2) by FR0P281CA0138.outlook.office365.com
 (2603:10a6:d10:96::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.20 via Frontend
 Transport; Mon, 29 May 2023 10:24:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 VE1EUR01FT045.mail.protection.outlook.com (10.152.3.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.20 via Frontend Transport; Mon, 29 May 2023 10:24:55 +0000
Received: from CNPEK01M03MSX.ad011.siemens.net (139.24.237.220) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 29 May 2023 12:24:54 +0200
Received: from CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) by
 CNPEK01M03MSX.ad011.siemens.net (139.24.237.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 29 May 2023 18:24:52 +0800
Received: from CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) by
 CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) with mapi id
 15.01.2507.023; Mon, 29 May 2023 18:24:52 +0800
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
Subject: Re: [isar-cip-core][PATCH] squashfs: Fix vardeps for SQUASHFS_THREADS and SQUASHFS_MEMLIMIT
Thread-Topic: [isar-cip-core][PATCH] squashfs: Fix vardeps for
 SQUASHFS_THREADS and SQUASHFS_MEMLIMIT
Thread-Index: AQHZkLrxiHvTJORhE0CQmZoj6co/Ja9wiAGA
Date: Mon, 29 May 2023 10:24:52 +0000
Message-ID: <f36525bc1cc242990263b839798c8977803d3d4d.camel@siemens.com>
References: <46e8b3a2-128f-c63a-cbfc-6d38a1792a35@siemens.com>
In-Reply-To: <46e8b3a2-128f-c63a-cbfc-6d38a1792a35@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
x-originating-ip: [139.24.247.57]
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT045:EE_|PAWPR10MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: b3b30994-d02c-4513-95ad-08db602ef23b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Wgo8PSM48wYSvxOvxlhCN9YTOPXl20736StxnUrcFyGaK7SqgvHpyL4AzVq75ioJkykJKhxoapgbMrIZTMu8/MlsVEcUGJpw0OTD92sBFm9gUi30/8Rftwjzo0bDTnExuoJANYMi8CyN4eztec135+egelBxyERTdNRMPrJTZgUyUr9wwChb7dzzslG6g1s9Nr1O/iLx73lFehPBEAy7+OOi7umPjSivBbIk/qxTkvc2Z7rg6bvXSRZuq1JErdzSq2vgKAifHcqZ1R4cMPItKsUIjQqaOyjvSVyaZQIu1C3mCtHlIBln0pUS8/Tw0wbDOJWQQmfQFUGabnN+NhcReiY0YXdwtpN3BeM2cAtXzGkOeHi6CbVS8TtGt/SVYKgvMBXbpGdQhAgnm9A6U5UT+R5Hz32mWayIima4dYnQ0zPCw/wL9/VlTJXQ5aWgKtMAdJ1CTFD1TS9Ph88p6HtR0JaccUzxSlg+cFVvHxRAlkGeFzfosHgHwcLhDl/cHiKBmDE01S2awkt92k7vQam2U993sJZTyrVBUyK/g6vdUWrjY5UNR1GxsNFF+IWSLf4kvBR+iE1/iveWxQON2iTJzNClWDJhAGFK85fa0MhvvDuFgiHtMMoSnuEov1/XZtHEFkJmeuzxDCX/2rJkLxB/fI8TwKXm63WZBkPQyi5a42/ZaYT2gdqx3NNsdDQY0h8L8eOtBw9INcAobqPY9oN5zUvZnXT+wKwoP5Q85udQnDZH65PSHEGZiqfQkiGOkikoEOCJfZYn07qQWPD8jSfTCA==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(36840700001)(46966006)(40470700004)(81166007)(82960400001)(2906002)(41300700001)(186003)(86362001)(82310400005)(356005)(8676002)(8936002)(2616005)(956004)(82740400003)(336012)(110136005)(478600001)(26005)(316002)(83380400001)(6636002)(70206006)(70586007)(47076005)(36756003)(36860700001)(40480700001)(5660300002)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 10:24:55.1029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b30994-d02c-4513-95ad-08db602ef23b
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT045.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7344
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE4C3AA1DBD3394EBFCB22B2FB73AEBE@siemens.com>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 May 2023 12:43:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11699

T24gU2F0LCAyMDIzLTA1LTI3IGF0IDE4OjQ3ICswMjAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBG
cm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiANCj4gV2hpbGUgU1FV
QVNIRlNfREVGQVVMVFMgd2FzIGRlY291cGxlZCBmcm9tIGl0cyBwb3RlbnRpYWxseSB1bnN0YWJs
ZQ0KPiBpbnB1dHMsIFNRVUFTSEZTX1RIUkVBRFMgYW5kIFNRVUFTSEZTX01FTUxJTUlULCB0aGUg
Y29uc3VtZXIgb2YNCj4gU1FVQVNIRlNfREVGQVVMVFMgd2FzIG5vdC4gUmV3b3JrIHRoaXMgbW92
aW5nIHRoZSB2YXJkZXBzZXhjbHVkZSB0bw0KPiBJTUFHRV9DTUQ6c3F1YXNoZnMuIFRoaXMgYWxz
byBvYnNvbGV0ZXMgdGhlIHJlbGF0ZWQgdmFyZGVwdmFsdWUgYW5kDQo+IHZhcmRlcHNleGNsdWRl
IGZvciBTUVVBU0hGU19USFJFQURTIGFuZCBTUVVBU0hGU19NRU1MSU1JVC4NCg0KV2h5IHdhcyB0
aGlzIHJlcXVpcmVkPyBUaGUgY29uc3VtZXIgZG9lcyBub3QgZXhwYW5kIHRoZSB2YXJpYWJsZXMg
YW5kDQpieSB0aGF0IGNoYW5nZXMgb2YgZS5nIFNRVUFTSEZTX1RIUkVBRFMgc2hvdWxkIG5vdCBh
ZmZlY3QgdGhlIGhhc2hlcy4NCg0KPiANCj4gQXMgd2UgYXJlIG5vdyBleHBlY3Rpbmcgb25seSBn
ZW5lcmF0aW9uIGxpbWl0cyB2aWEgdGhhdCBpZ25vcmVkDQo+IHZhcmlhYmxlLCByZW5hbWUgaXQg
dG8gU1FVQVNIRlNfQ1JFQVRJT05fTElNSVRTIGFuZCBkZW55IG92ZXJ3cml0aW5nLg0KPiBPbmx5
IFNRVUFTSEZTX1RIUkVBRFMgYW5kIFNRVUFTSEZTX01FTUxJTUlUIGFyZSBzdXBwb3NlZCB0byBi
ZSB0dW5lZA0KPiB0byB0aGUgYnVpbGQgZW52aXJvbm1lbnQgLSBpZiBhdCBhbGwuDQoNCkknbSBu
b3QgYWdhaW5zdCB0aGlzIGNoYW5nZSwgYnV0IEkgZG9uJ3QgdW5kZXJzdGFuZCB3aGF0IGlzc3Vl
IGlzDQpzb2x2ZWQgaGVyZS4NCg0KRmVsaXgNCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSmFuIEtp
c3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NCj4gLS0tDQo+IMKgY2xhc3Nlcy9zcXVhc2hm
cy5iYmNsYXNzIHwgOSArKysrLS0tLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25z
KCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2NsYXNzZXMvc3F1YXNoZnMu
YmJjbGFzcyBiL2NsYXNzZXMvc3F1YXNoZnMuYmJjbGFzcw0KPiBpbmRleCBiMTQ3NjhjMi4uMWYy
YTc1OTUgMTAwNjQ0DQo+IC0tLSBhL2NsYXNzZXMvc3F1YXNoZnMuYmJjbGFzcw0KPiArKysgYi9j
bGFzc2VzL3NxdWFzaGZzLmJiY2xhc3MNCj4gQEAgLTEsNyArMSw3IEBADQo+IMKgIw0KPiDCoCMg
Q0lQIENvcmUsIGdlbmVyaWMgcHJvZmlsZQ0KPiDCoCMNCj4gLSMgQ29weXJpZ2h0IChjKSBTaWVt
ZW5zIEFHLCAyMDIxLTIwMjINCj4gKyMgQ29weXJpZ2h0IChjKSBTaWVtZW5zIEFHLCAyMDIxLTIw
MjMNCj4gwqAjDQo+IMKgIyBBdXRob3JzOg0KPiDCoCPCoCBRdWlyaW4gR3lsc3RvcmZmIDxxdWly
aW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29tPg0KPiBAQCAtMTYsMTEgKzE2LDkgQEAgU1FVQVNIRlNf
Q09OVEVOVCA/PSAiJHtQUF9ST09URlN9Ig0KPiDCoFNRVUFTSEZTX0NSRUFUSU9OX0FSR1MgPz0g
IiINCj4gwqANCj4gwqBTUVVBU0hGU19USFJFQURTID89ICIke0BvZS51dGlscy5jcHVfY291bnQo
YXRfbGVhc3Q9Mil9Ig0KPiAtU1FVQVNIRlNfVEhSRUFEU1t2YXJkZXB2YWx1ZV0gPSAiMSINCj4g
wqAjIGRlZmF1bHQgYWNjb3JkaW5nIHRvIG1rc3F1YXNmcyBkb2NzDQo+IMKgU1FVQVNIRlNfTUVN
TElNSVQgPz0gIjc5ODJNIg0KPiAtU1FVQVNIRlNfREVGQVVMVFMgPz0gIi1tZW0gJHtTUVVBU0hG
U19NRU1MSU1JVH0gLXByb2Nlc3NvcnMNCj4gJHtTUVVBU0hGU19USFJFQURTfSINCj4gLVNRVUFT
SEZTX0RFRkFVTFRTW3ZhcmRlcHNleGNsdWRlXSArPSAiU1FVQVNIRlNfTUVNTElNSVQNCj4gU1FV
QVNIRlNfVEhSRUFEUyINCj4gK1NRVUFTSEZTX0NSRUFUSU9OX0xJTUlUUyA9ICItbWVtICR7U1FV
QVNIRlNfTUVNTElNSVR9IC1wcm9jZXNzb3JzDQo+ICR7U1FVQVNIRlNfVEhSRUFEU30iDQo+IMKg
DQo+IMKgcHl0aG9uIF9fYW5vbnltb3VzKCkgew0KPiDCoMKgwqDCoCBleGNsdWRlX2RpcmVjdG9y
aWVzID0gZC5nZXRWYXIoJ1NRVUFTSEZTX0VYQ0xVREVfRElSUycpLnNwbGl0KCkNCj4gQEAgLTM1
LDggKzMzLDkgQEAgcHl0aG9uIF9fYW5vbnltb3VzKCkgew0KPiDCoH0NCj4gwqANCj4gwqBJTUFH
RV9DTUQ6c3F1YXNoZnNbZGVwZW5kc10gPSAiJHtQTn06ZG9fdHJhbnNmb3JtX3RlbXBsYXRlIg0K
PiArSU1BR0VfQ01EOnNxdWFzaGZzW3ZhcmRlcHNleGNsdWRlXSArPSAiU1FVQVNIRlNfQ1JFQVRJ
T05fTElNSVRTIg0KPiDCoElNQUdFX0NNRDpzcXVhc2hmcygpIHsNCj4gwqDCoMKgwqAgJHtTVURP
X0NIUk9PVH0gL2Jpbi9ta3NxdWFzaGZzIFwNCj4gwqDCoMKgwqDCoMKgwqDCoCAnJHtTUVVBU0hG
U19DT05URU5UfScgJyR7SU1BR0VfRklMRV9DSFJPT1R9JyBcDQo+IC3CoMKgwqDCoMKgwqDCoCAt
bm9hcHBlbmQgJHtTUVVBU0hGU19ERUZBVUxUU30gJHtTUVVBU0hGU19DUkVBVElPTl9BUkdTfQ0K
PiArwqDCoMKgwqDCoMKgwqAgLW5vYXBwZW5kICR7U1FVQVNIRlNfQ1JFQVRJT05fTElNSVRTfQ0K
PiAke1NRVUFTSEZTX0NSRUFUSU9OX0FSR1N9DQo+IMKgfQ0KDQo=

