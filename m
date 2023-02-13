Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC79C636CC
	for <webhook@archiver.kernel.org>; Tue, 14 Feb 2023 02:36:01 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.79])
 by mx.groups.io with SMTP id smtpd.web10.16722.1676301364634694806
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Feb 2023 07:16:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=o3hWVg0y;
 spf=pass (domain: siemens.com, ip: 40.107.7.79, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJP73olBpunH/s0qqeAru8LjWYuyQPyukgHgk83lvFA8Yjdp4uals8pddHlGoZ9awfmvGVBb3k4mLZJ3BX8Iwmz2QMUba05wCE3rWNBf3bu1oZgHtlVe2pkCXdrJ+PEAW9Alx1Vq5idHH/QQIgbw+PCyxzmd/ogkgfTrHz2UM47ZS+wonEshXZq5xY7nDnlI74iYS0FKsA9aTxTM5Pz4vb6fQ04ztqE7lFWWQs8M7r+OqMXdpRU1deUGrdl2Z7wL48LcuU7uJgqo6PUb3+l0kndIj0zJ+cDF+lkehe4kOSKfCLrPU15CYpBXkChZfFESHd+lB15IXGxIaW3ZieFCnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/ZW8uksYZhXRICgywoI+d47I4UaWDZXXdMXzWUkaBM=;
 b=Ina6uFDsPKBn1EozvNTYuMXaXGh16Rg9o4WiRNBVLz0c6zer/QXd6+eN2ls+l4r+7oBBrrpgbNfcHeocUGftvqJOSK8tIoKINpBI8bC488girXRG7ffbJTGcenpivEVbM8iN+bHSUHbuIy6NoVECsgoPflIqsBtvsxM9C+hCJBn9tIoV2ZBPyglBEyO+clAfROMWUHnc4d5W/+4FxLwT6b9Tfg/2TwpWABgd4x6fWGyIzpgRh79ed82ITYNx0tczoxbZLPtav028K/CWB4lQToLnoI1lgygKogB21Cfm+rXavMTbr6oyau9l0H4fth7eX/WCBgyCad8JmCgsrwRU0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/ZW8uksYZhXRICgywoI+d47I4UaWDZXXdMXzWUkaBM=;
 b=o3hWVg0ynKZf61ZDAIzIQIhJ9bniWEYkeN39DoIG9KsZzWP5VlO6hFY36uQE9Y7lsL09AmiET8kUyTTNWyg+u03kg4/lNwpg+zsC1euD4s/zai28DNI2dwh3cN2EcIjqDvRvVNDxoPIB/dnpqSiiAeOAp9AYYaC6SDjoSB6NYXBj5yD/7THU9rbIs+x7UqcmGhHkLamsqxUfXKpjGldOvXgbGJI0XbS0RUx0dwSCwG+BlXoE1QyMvLXWwiPYhzN4AEcIBrJX4XEeL/tlQG9MYUEWVt5Gqc+uxM2gH3EPWLW1KD8Pb4Qy/H7fIHdf56ynwc1rNUbQ7bbYgGbQxpA/Gw==
Received: from GV3P280CA0018.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:b::33) by
 PA4PR10MB5730.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:267::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.22; Mon, 13 Feb
 2023 15:16:01 +0000
Received: from HE1EUR01FT011.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:b:cafe::ac) by GV3P280CA0018.outlook.office365.com
 (2603:10a6:150:b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24 via Frontend
 Transport; Mon, 13 Feb 2023 15:16:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 HE1EUR01FT011.mail.protection.outlook.com (10.152.0.173) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24 via Frontend Transport; Mon, 13 Feb 2023 15:16:00 +0000
Received: from CNPEK01M09MSX.ad011.siemens.net (139.24.237.227) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1118.21; Mon, 13 Feb 2023 16:15:59 +0100
Received: from CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) by
 CNPEK01M09MSX.ad011.siemens.net (139.24.237.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 13 Feb 2023 23:15:57 +0800
Received: from CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) by
 CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) with mapi id
 15.01.2507.017; Mon, 13 Feb 2023 23:15:56 +0800
From: "Moessbauer, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
CC: "Bovensiepen, Daniel (bovi)" <daniel.bovensiepen@siemens.com>
Subject: Re: [isar-cip-core][PATCH 3/3] wic(ebg): add support for riscv64
Thread-Topic: [isar-cip-core][PATCH 3/3] wic(ebg): add support for riscv64
Thread-Index: AQHZP4lG/pcgrffMuUeIcSCG/+ZQQq7MbngAgAAIegA=
Date: Mon, 13 Feb 2023 15:15:56 +0000
Message-ID: <679d812c0080ab414f9167b00abed1fc080e897b.camel@siemens.com>
References: <20230213085741.1242658-1-felix.moessbauer@siemens.com>
	 <20230213085741.1242658-3-felix.moessbauer@siemens.com>
	 <938b99f4-a7c9-ed00-1005-0b2f0a489fbe@siemens.com>
In-Reply-To: <938b99f4-a7c9-ed00-1005-0b2f0a489fbe@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1+deb11u1 
x-originating-ip: [139.24.236.127]
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT011:EE_|PA4PR10MB5730:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a7c0d89-18eb-4ccd-c912-08db0dd53710
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6SZlQ1j/FytKRfmYLno8oZulSk5e5+s+BhrBPyevjnkti8nAioRjThWbD/z64C5dUyP1mgafTCD6pukeFQRl1u7VXmlJVVFxr5V5xiYcd8XnPSbOegSyLvu/HLbAsLlKz2lAPRSee48R4TPmDhePgqkDTvP3VZhCeT2ACTdrRB9bakWGs2JFy35BTi0VKnNPeJbc0DkiEVTrPpoJvIdErO4K9UcVtbB5W+y+sSM47ARvAzjGiB7qmNht8ft/Up3IuzoUYKttDQtpO9aowwePU3rwcrQVgirR7RN1yE1q2JTqPbq/EKRpChzgQp2f3qtqRjNOl/EUmQkD5PolDDkP/xw/5VXodSkMtcJFFRy6CI/1MSEeEM8fpSbWMmbaq2R6Qu7lFUeSJhxbPF4NiqVj4kAc8JVRivTKnEeLxXFbgJCUEz/Sw/evsiJPE1/mgpxYsZvudQodsn0HUXfl+mliLNiZ2jvun9BKnKqPFIm2G2ZqHDVBQN30iRZUcNwTQ8+EGFGX3ad8Eu/DcgMl5QfXgo2yUzPMu48bJIoEzaAr058VglkQhCHWg1kAg0qiUaEQ6qB5PWm+7wHyfCFWo+MTED2735Bd/j6/NCNZYotR4LhnfvHIq0+5ehQ8uNCs089o1DXEPqLdqRL0FeWXlGV3G0H5hK+sXO3AYi6eiWmmyFIR0NETi14ljw7XgE5jNU6EO6QlPrc4eFkTnFQnuGZ4Dg==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199018)(40470700004)(36840700001)(46966006)(5660300002)(8936002)(86362001)(70586007)(41300700001)(70206006)(110136005)(4326008)(2906002)(8676002)(316002)(356005)(6636002)(40480700001)(107886003)(7636003)(82740400003)(82960400001)(7596003)(82310400005)(36860700001)(47076005)(83380400001)(478600001)(186003)(2616005)(956004)(336012)(36756003)(53546011)(40460700003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 15:16:00.5005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7c0d89-18eb-4ccd-c912-08db0dd53710
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT011.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5730
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE7C933295C5E3488ED44C049A87198F@siemens.com>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Feb 2023 02:36:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10688

T24gTW9uLCAyMDIzLTAyLTEzIGF0IDE1OjQ1ICswMTAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAxMy4wMi4yMyAwOTo1NywgRmVsaXggTW9lc3NiYXVlciB3cm90ZToNCj4gPiBUaGlzIHBhdGNo
IGFkZHMgdGhlIG1hcHBpbmcgYmV0d2VlbiB0aGUgZWZpIGFyY2hpdGVjdHVyZSBhbmQgdGhlDQo+
ID4gZGlzdHJvDQo+ID4gYXJjaGl0ZWN0dXJlIGZvciByaXNjdjY0Lg0KPiA+IA0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEZlbGl4IE1vZXNzYmF1ZXIgPGZlbGl4Lm1vZXNzYmF1ZXJAc2llbWVucy5jb20+
DQo+ID4gLS0tDQo+ID4gwqBzY3JpcHRzL2xpYi93aWMvcGx1Z2lucy9zb3VyY2UvZWZpYm9vdGd1
YXJkLWJvb3QucHkgfCA2ICsrKystLQ0KPiA+IMKgc2NyaXB0cy9saWIvd2ljL3BsdWdpbnMvc291
cmNlL2VmaWJvb3RndWFyZC1lZmkucHnCoCB8IDYgKysrKy0tDQo+ID4gwqAyIGZpbGVzIGNoYW5n
ZWQsIDggaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0
IGEvc2NyaXB0cy9saWIvd2ljL3BsdWdpbnMvc291cmNlL2VmaWJvb3RndWFyZC1ib290LnB5DQo+
ID4gYi9zY3JpcHRzL2xpYi93aWMvcGx1Z2lucy9zb3VyY2UvZWZpYm9vdGd1YXJkLWJvb3QucHkN
Cj4gPiBpbmRleCAzZDZiMmQ3Li4wZGUyOGNhIDEwMDY0NA0KPiA+IC0tLSBhL3NjcmlwdHMvbGli
L3dpYy9wbHVnaW5zL3NvdXJjZS9lZmlib290Z3VhcmQtYm9vdC5weQ0KPiA+ICsrKyBiL3Njcmlw
dHMvbGliL3dpYy9wbHVnaW5zL3NvdXJjZS9lZmlib290Z3VhcmQtYm9vdC5weQ0KPiA+IEBAIC0x
ODUsMTMgKzE4NSwxNSBAQCBjbGFzcyBFZmlib290Z3VhcmRCb290UGx1Z2luKFNvdXJjZVBsdWdp
bik6DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJhbWQ2NCI6ICJ4NjQiLA0KPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiYXJtNjQiOiAiYWE2NCIsDQo+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICJhcm1oZiI6ICJhcm0iLA0KPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICJpMzg2IjogImlhMzIiDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgImkzODYiOiAiaWEz
MiIsDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgInJpc2N2NjQiIDogInJpc2N2NjQiDQo+
ID4gwqDCoMKgwqDCoMKgwqDCoCB9DQo+ID4gwqDCoMKgwqDCoMKgwqDCoCBkaXN0cm9fdG9fbGli
X2FyY2ggPSB7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJhbWQ2NCI6ICJ4ODZfNjQt
bGludXgtZ251IiwNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgImFybTY0IjogImFhcmNo
NjQtbGludXgtZ251IiwNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgImFybWhmIjogImFy
bS1saW51eC1nbnVlYWJpaGYiLA0KPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJpMzg2Ijog
ImkzODYtbGludXgtZ251Ig0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJpMzg2IjogImkz
ODYtbGludXgtZ251IiwNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAicmlzY3Y2NCI6ICJy
aXNjdjY0LWxpbnV4LWdudSIsDQo+ID4gwqDCoMKgwqDCoMKgwqDCoCB9DQo+ID4gwqDCoMKgwqDC
oMKgwqDCoCByb290ZnNfcGF0aCA9IHJvb3Rmc19kaXIuZ2V0KCdST09URlNfRElSJykNCj4gPiDC
oMKgwqDCoMKgwqDCoMKgIGRpc3Ryb19hcmNoID0gZ2V0X2JpdGJha2VfdmFyKCJESVNUUk9fQVJD
SCIpDQo+ID4gZGlmZiAtLWdpdCBhL3NjcmlwdHMvbGliL3dpYy9wbHVnaW5zL3NvdXJjZS9lZmli
b290Z3VhcmQtZWZpLnB5DQo+ID4gYi9zY3JpcHRzL2xpYi93aWMvcGx1Z2lucy9zb3VyY2UvZWZp
Ym9vdGd1YXJkLWVmaS5weQ0KPiA+IGluZGV4IDJkMTZmZTMuLmQ2Y2RmMGYgMTAwNjQ0DQo+ID4g
LS0tIGEvc2NyaXB0cy9saWIvd2ljL3BsdWdpbnMvc291cmNlL2VmaWJvb3RndWFyZC1lZmkucHkN
Cj4gPiArKysgYi9zY3JpcHRzL2xpYi93aWMvcGx1Z2lucy9zb3VyY2UvZWZpYm9vdGd1YXJkLWVm
aS5weQ0KPiA+IEBAIC01NiwxNCArNTYsMTYgQEAgY2xhc3MgRWZpYm9vdGd1YXJkRUZJUGx1Z2lu
KFNvdXJjZVBsdWdpbik6DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJhbWQ2NCI6ICJ4
NjQiLA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiYXJtNjQiOiAiYWE2NCIsDQo+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJhcm1oZiI6ICJhcm0iLA0KPiA+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICJpMzg2IjogImlhMzIiDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
ImkzODYiOiAiaWEzMiIsDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgInJpc2N2NjQiIDog
InJpc2N2NjQiDQo+ID4gwqDCoMKgwqDCoMKgwqDCoCB9DQo+ID4gwqANCj4gPiDCoMKgwqDCoMKg
wqDCoMKgIGRpc3Ryb190b19saWJfYXJjaCA9IHsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgImFtZDY0IjogIng4Nl82NC1saW51eC1nbnUiLA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAiYXJtNjQiOiAiYWFyY2g2NC1saW51eC1nbnUiLA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAiYXJtaGYiOiAiYXJtLWxpbnV4LWdudWVhYmloZiIsDQo+ID4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgImkzODYiOiAiaTM4Ni1saW51eC1nbnUiDQo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgImkzODYiOiAiaTM4Ni1saW51eC1nbnUiLA0KPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICJyaXNjdjY0IjogInJpc2N2NjQtbGludXgtZ251IiwNCj4gPiDCoMKgwqDCoMKgwqDC
oMKgIH0NCj4gPiDCoA0KPiA+IMKgwqDCoMKgwqDCoMKgwqAgZGlzdHJvX2FyY2ggPSBnZXRfYml0
YmFrZV92YXIoIkRJU1RST19BUkNIIikNCj4gDQo+IE5vdywgZG9lcyB0aGUgc3d1cGRhdGUgaW1h
Z2Ugd29yayB3aXRoIHRoYXQgYWxyZWFkeT8gQ2FuIHdlIGVuYWJsZWQNCj4gaXQNCj4gaW4gS2Nv
bmZpZyB0aGVuPyBPciBhcmUgdGhlcmUgbW9yZSBjaGFuZ2VzIHN0aWxsIG5lZWRlZD8NCg0KR2l2
ZW4gdGhhdCBwYXRjaCAyIG9mIHRoaXMgc2VyaWVzIGlzIGFsc28gYXBwbGllZCwgdGhpcyB3b3Jr
cy4NCkl0IGhhcyBiZWVuIHRlc3RlZCBvbiB0aGUgU3RhckZpdmUgVmlzaW9uRml2ZTIgYm9hcmQu
DQoNCkZlbGl4DQoNCj4gDQo+IEphbg0KPiANCg0K

