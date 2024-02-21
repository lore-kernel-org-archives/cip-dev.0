Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDAFC48BC3
	for <webhook@archiver.kernel.org>; Wed, 21 Feb 2024 12:15:57 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.48])
 by mx.groups.io with SMTP id smtpd.web10.11591.1708517753281749693
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Feb 2024 04:15:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=d1ElCeDF;
 spf=pass (domain: renesas.com, ip: 40.107.114.48, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJ3yjOuUqZl2TgPlfHH9UU9F6+F0CI3xCzLyIib+QI6c7qM5A89bBs6zz0ZT7qJ6j1mhMNSTMWYyBgIPdaa11v69Urr4J0AZOwpp44dwnVanvHV81kDMUgR0mWt/feQRxRe+CyHCkv/Gzm3YoModlNLgZuFVJpRJ+SrvPDJIHQNhiSDLkDvJDRpIY28Uvf7x4XCN3K+ngXvYASdBDxtwgk7W0SwwcOYDyW2zAypidyFuBiLxe/z2RPLUfwLujUEjPS/DV9hfp/GxjIeIHZ+LEGeLU9ipuWnwzjQ7rwbIjGU1GMtTeC0Axop3/u53pTkISxXghyxPo0swSKEmL4uZpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgIjLEmLV9CpcUjhHUiGqa5xuJEVTPebuS+wduqZoAs=;
 b=j4nQ41NxalsaGDfxvtnb7J22DSYwXj6tGB38lx+h04fk7WHgZFpJeVkiWh4DoRXeg/tCc/B/DNN3AXvxsxjQwFO7Sqxgp1U9Md29D/I6MR3UOHUUVFu2lxtHI2hNfT79n5+5rRsw7AgFEJy6PfF+qFmX01QJx3JUMpBvgD4bVphjDeJQU8HZvdAXrEErNUGGBdmzehktLpm7XRyTfE6nARQU0X5Jo3Tn7BQOCAQYQkvv2ADhmzzbnWOV8wfrIGe5Jpr/WWawF8HlXZvN/A2f3MBW3ixdl9MZ81rRF6mF3cc0mMlbjL4s+sNMUx7FMf1d7V9BGTr3Qusrjx3lIiar+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgIjLEmLV9CpcUjhHUiGqa5xuJEVTPebuS+wduqZoAs=;
 b=d1ElCeDF4N+LVve7JFs9z6E1EWuhHTghCLq1gi3MiBDnCnTPWODk484qam5Rr9duxOqLhKzqTTdJPRsRGvUoQY+vEUsvAFUqHO0FVYxnDrRVlnx97pfW84zCcOs8YKHjRr41lh1nU4cmW1gVUsg5YAtq/FkK+1f0rGwmuz8BXfo=
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com (2603:1096:400:3fc::6)
 by TYWPR01MB11017.jpnprd01.prod.outlook.com (2603:1096:400:395::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Wed, 21 Feb
 2024 12:15:47 +0000
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::d543:aeea:6f7b:2a47]) by TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::d543:aeea:6f7b:2a47%5]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 12:15:47 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "Sai.Sathujoda@toshiba-tsip.com" <Sai.Sathujoda@toshiba-tsip.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>,
	"dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>
Subject: RE: LAVA test job definitions ( software update, secure boot and IEC
 layer testing )
Thread-Topic: LAVA test job definitions ( software update, secure boot and IEC
 layer testing )
Thread-Index: AdpYW/mgLfuVvDVHQv2V4kqjG1tanACcarPQALyDjoAAT66ioAD7Ws/gAHPcRqA=
Date: Wed, 21 Feb 2024 12:15:47 +0000
Message-ID: 
 <TYWPR01MB11862816FF930969C5B302BF4B7572@TYWPR01MB11862.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103A1EC373CEA6213199114C2472@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYWPR01MB118625EE66B03E0DE98380BDFB7442@TYWPR01MB11862.jpnprd01.prod.outlook.com>
 <OS3PR01MB610381F654F75EE67B00D02BC2482@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <OS3PR01MB6103E2D6E60760A098F979FEC24E2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <OS3PR01MB61034E05C271281A1CD2FE78C2512@OS3PR01MB6103.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB61034E05C271281A1CD2FE78C2512@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11862:EE_|TYWPR01MB11017:EE_
x-ms-office365-filtering-correlation-id: a59514ff-4aba-425d-2f9c-08dc32d6d62c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 W5Ajfd1aypz1tiY64kHYJZ12+8g7OW86xMx2Omb1aon9rIebOnF0s2mOgR3Ee24KWibOmTAB+GWRIOSo2G9do3eNQEtOsnI7P2g9lmorQ3GlHC/Vobfmkcr6eWifFzQ6wLI6CCcRBsyy1Tuhh6GvsPxRoAA22I9yM1RBCYdUeE8QWzMYEkB3gDZPHPIlZAtCZ3WIk9kmtGJNfRNfb4l30WEh0Or0WCLeHLqNbfaBCOh11a4ZHCyl2GimXGbLcHPDY4+r1+/L0VeB7d0C5b5muEdFD7RJQI953BjVNDX8shNULRXknHs9M6dF9LkLBNnO6C5AfLTMOeNoXHDdRKwBUahMgIFYgEYQatyadQy88ELRrqAcGTVjvNOPuBZ640kYns9rheykmjd0iq3DuoqvF0Ti2JDwsXki71suwsJ4AwqBsFWPKAfIe0ZGdHghQJNm2CCC45Lsvn6ceDgUX8610/4y0h4UdvkLPdFGYOd/pVwq4x6dsMDg502QN5AegwDJ7kIhdkHI0MawnJfKzG0B5NUzecmteWjiYnvJSXVvHgiWvj53pp1JE7IQmUbvEBZgvIVdUuPiJGD85B9risjXKpfj7a+Q9P9Nth5op7SUDEo=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11862.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?ks_c_5601-1987?B?akhzVjllM3VwTzJzOHpZT1MwN2hhM0hRSVVVc0p1TWxXL09BQTdW?=
 =?ks_c_5601-1987?B?b20yRGtlTDlGS3ZQVmFFYTBTYTJmRHhKTWNqRTd1SmR6d2pIa2E2?=
 =?ks_c_5601-1987?B?NlE5VkhrcXZBRnZsL2V1ZktmdUJ2bjV0OEg4YlF3M094NTNRZVZL?=
 =?ks_c_5601-1987?B?elNQdmN4bDdDNytVRzVBaElzRU9Lckk3MGx1bFhCdTZnOUh1eU5q?=
 =?ks_c_5601-1987?B?Z1NWQVZoRFR6VklTNkxwbzV3SURzaVdmK2t3RlZQVThNT2pnWGQz?=
 =?ks_c_5601-1987?B?UXVzbjF6d0RCU2ZBdWRpOWlrTnpaQkZaalNPZ2RBSE05bmxCNXNX?=
 =?ks_c_5601-1987?B?RGhGdmg5VUhITzU2SFV5eEZRWXZSaUdsdkpzVWcwazFqMmlDaHdL?=
 =?ks_c_5601-1987?B?dGl5czZJdDgyNmFpQnIwK0tNRzN2anRsNyt0M2NLU0ZnWk1ZNDRL?=
 =?ks_c_5601-1987?B?SFl2SDVCMVpGWVp5MDFha2drVmU1dXkrTVJTbHFhSno2QW9vanF5?=
 =?ks_c_5601-1987?B?UUhxU3JoUnYwSktpMGNIc1FIUTIyTXVpQ0lDdGt1dmQrV1lneCty?=
 =?ks_c_5601-1987?B?UE9JMmxYenFLcnRQbFNod1NKQlhiVCs3NWJaaEJlVVBLVGpqdUZa?=
 =?ks_c_5601-1987?B?S2hZT3g4WjlXTWpRUGZYZlN5NFZXN0p5YytyTWowSUlhaWdFbS96?=
 =?ks_c_5601-1987?B?OThjYmgwUDlEeXF1OVVIRDFJTHRtZjMweldvcGVDTnZ0dEVhWGts?=
 =?ks_c_5601-1987?B?cnZBTW84N1B3OWJ1djFyM2trb1lHRW9PVUNjQWM5aG5NbzdsV3Vj?=
 =?ks_c_5601-1987?B?Mnk3WFBxbE0vMEhFNnJYcjhBMjUva2RYUWNtQ3lGTVhJcDRoODFs?=
 =?ks_c_5601-1987?B?UnJ4ZzB1djFvUzNZRmdNb3dGb1c2VVBTbDJCQk4xM1pIMGgyT1F5?=
 =?ks_c_5601-1987?B?TmpXcWNBN2xDSVVsU2t4U3hNQkxkUkFjdDI2M1ZIZHdoblgwMlhV?=
 =?ks_c_5601-1987?B?MzE5eFg1REVVTk13ZFI5ME93dXdOYk4zMjB4NjBzaTZHL2JkeXNQ?=
 =?ks_c_5601-1987?B?UHhhMjNrRFF1UXQyb0NGQzhNc2JEaTRUK1JtUWxwbStJTVRaNnBr?=
 =?ks_c_5601-1987?B?cmpzQXpkVWhMaS80dmVXOThCOFY2NEJTRFR4VE5xZjA3dEJyeVhG?=
 =?ks_c_5601-1987?B?UlZ5NzlhY0VkYkxKQTVPaWdSWm5la1N4N2hmcXkvWjVWaDhZbUF5?=
 =?ks_c_5601-1987?B?OWhWVGNVZmI0bE9LenIvOUpYUUtLYkdtS2JHbWRwcG94TTk2dDdX?=
 =?ks_c_5601-1987?B?UFlPampPWEJiYmRuZ2pZQ2Z2NVNsaURQeUFQSDNQbW0zeWsvTnYr?=
 =?ks_c_5601-1987?B?aHJiTldUVEFYUWszK1ZWM0xLdWFicHhVME1ldStQb05nc1d5UFN5?=
 =?ks_c_5601-1987?B?bjBtOS9najQveTM2alNCRk4wSjZuKytndTNCRVphQkdYYTVhRmZq?=
 =?ks_c_5601-1987?B?cmhrbC9NTnlhb0JUa0RETHdEZXhDU2s4RW16OTkvNzBHU0hTN3JC?=
 =?ks_c_5601-1987?B?THNkaVU5WG9qV3hLbGtEZHZPa21sNGtwQXd3VExHZ2VCdjdHSElj?=
 =?ks_c_5601-1987?B?MWdNY1h2ekxRY3AyZ21mZDJiN2FvajhpTGI3SmJXV2o0eVJEcnBw?=
 =?ks_c_5601-1987?B?WFhYdk43U1c5NExzWnM5SldxeW83RGcrNlpuSTcvd3B3Zm84L21y?=
 =?ks_c_5601-1987?B?RjhPRmYvNm94ZzJIUjk1azdaRDBNOFg5b1ZXRnRsK3ZDTzBXWUNQ?=
 =?ks_c_5601-1987?B?a3l2TzhXUEVTSWJtNVpKcXR6aEtDaUxJcTBiQUh6TEw1Y3pWd3BG?=
 =?ks_c_5601-1987?B?NmE3NGJWWGh6OVJiQXIzeHVQMVdsWXpyb0prUjRtaDk5c01tZ2Zq?=
 =?ks_c_5601-1987?B?Mzhtc2N5dG93RW9BaERkQ0pKb0h3NE0rSXU5VThGZUtDWVhMOWx6?=
 =?ks_c_5601-1987?B?NVRwNmdydDhHSC9CcXhSUkphYktvSnpqZUp0bXlCRGFmUFNVeFdO?=
 =?ks_c_5601-1987?B?dFNtd25sUXk4dDdnRnkwaWxnWlRHMXBObTlkNHNSdHZkL1lyMlZO?=
 =?ks_c_5601-1987?B?UWFGcEJLOWNIZ2ZEVGd5c1VDVk9GUW5LOTNmOC9reG11RTJaME9s?=
 =?ks_c_5601-1987?B?VjMwRjJtR2Z5MjFtZjQ2K2M5a1E1eHIybDJtU3RiYlEvcVpKR0di?=
 =?ks_c_5601-1987?B?MjRYN3krNnhDbVVVd0FBY2kxREQ5THMvT0gwK0FScGpOZFNhWHdl?=
 =?ks_c_5601-1987?B?ZEhpU2pKTEp6M2g1enRWSHc5VkN2cUFTdVN0eFUydEUwK042aVBG?=
 =?ks_c_5601-1987?B?OVRtSTBWRmVtTlJlbWJvVGYyR0JlUjBWNGxGNHRlajBaaVVPRUNu?=
 =?ks_c_5601-1987?B?Zk54MFlwekM5OXdFekIzWTllZHBQeUR0TDJwbUExWDFrSUpxd1F5?=
 =?ks_c_5601-1987?B?RDY5MXhSaE90cVBRUFpUYUZWNW8vRlE9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_TYWPR01MB11862816FF930969C5B302BF4B7572TYWPR01MB11862jp_"
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11862.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a59514ff-4aba-425d-2f9c-08dc32d6d62c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 12:15:47.7015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CjvLIooIofIH9nfFuQHT4wSv/G44jwIqh4+MzBKe4gtjfngZx2VhJ8uMe9KxP4mZWZyyH55a+xtkbeSuUNRv+EheRUrDVk9bNLFQN2EEx+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11017
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 Feb 2024 12:15:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15049

--_000_TYWPR01MB11862816FF930969C5B302BF4B7572TYWPR01MB11862jp_
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: base64

SGkgU2FpLA0KDQpTb3JyeSBmb3IgdGhlIHNsb3cgcmVwbHksIEmhr3ZlIGJlZW4gcG9vcmx5Lg0K
DQpJdKGvcyBjZXJ0YWlubHkgYW4gb3B0aW9uIHRvIHNlcGFyYXRlIHRoZSBjaXAtY29yZSB0ZXN0
aW5nIGNvbnRhaW5lci9zY3JpcHRzIGV0Yy4gZnJvbSB0aGUga2VybmVsIHRlc3RpbmcsIGhvd2V2
ZXIgbW9zdCBvZiB0aGUgZnVuY3Rpb25hbGl0eSB3aWxsIGVuZCB1cCBiZWluZyB2ZXJ5IHNpbWls
YXIsIHNvIHdloa9sbCBlbmQgdXAgd2l0aCBkdXBsaWNhdGlvbi4NCg0KRmVlbCBmcmVlIHRvIGNy
ZWF0ZSB5b3VyIHByb2plY3QocykgaW4gY2lwLXBsYXlncm91bmQsIHRoZW4gd2UgY2FuIG1vdmUg
dGhlbSBhY3Jvc3MgdG8gY2lwLXRlc3Rpbmcgd2hlbiByZWFkeSAmIHdlIGhhdmUgYXBwcm92YWwg
ZnJvbSB0aGUgVFNDLg0KDQpUaGFua3MsIENocmlzDQoNCkZyb206IFNhaS5TYXRodWpvZGFAdG9z
aGliYS10c2lwLmNvbSA8U2FpLlNhdGh1am9kYUB0b3NoaWJhLXRzaXAuY29tPg0KU2VudDogTW9u
ZGF5LCBGZWJydWFyeSAxOSwgMjAyNCA0OjMyIEFNDQpUbzogQ2hyaXMgUGF0ZXJzb24gPENocmlz
LlBhdGVyc29uMkByZW5lc2FzLmNvbT4NCkNjOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9y
Zzsga2F6dWhpcm8zLmhheWFzaGlAdG9zaGliYS5jby5qcDsgZGluZXNoLmt1bWFyQHRvc2hpYmEt
dHNpcC5jb20NClN1YmplY3Q6IFJFOiBMQVZBIHRlc3Qgam9iIGRlZmluaXRpb25zICggc29mdHdh
cmUgdXBkYXRlLCBzZWN1cmUgYm9vdCBhbmQgSUVDIGxheWVyIHRlc3RpbmcgKQ0KDQpIZWxsbyBD
aHJpcywNCg0KSG9wZSB5b3UgYXJlIGRvaW5nIHdlbGwuDQoNCkkgcmVxdWVzdCB5b3UgdG8gcGxl
YXNlIHByb3ZpZGUgeW91ciBvcGluaW9uIGFib3V0IGNyZWF0aW5nIGEgZnJlc2ggcmVwb3NpdG9y
eSB1bmRlciBjaXAtdGVzdGluZyB3aGljaCBzZXJ2ZXMgdGhlIHB1cnBvc2Ugb2YgY3JlYXRpbmcg
Y29udGFpbmVyIGhhdmluZyBDSVAgQ29yZSB0ZXN0aW5nIGxhdmEgam9iIGRlZmluaXRpb25zLCBs
YXZhY2xpIGRlcGVuZGVuY2llcyBhbmQgYSBzaW1wbGUgc2NyaXB0IHRwIHN1Ym1pdCB0aGUgdGVz
dHMgdG8gQ0lQIExBVkEgc2VydmVyLiBXZSBzaGFsbCBpbnZva2UgdGhpcyBzY3JpcHQgaW4gYSBz
ZXBhcmF0ZSBhY3Rpb24gaW4gLmdpdGxhYi1jaS55bWwgZmlsZSBpbiBpc2FyLWNpcC1jb3JlLg0K
DQpUaGFua3MgYW5kIFJlZ2FyZHMsDQpTYWkgQXNocml0aCAoIFQgUyBJIFAgKQ0KDQoNCkZyb206
IGFzaHJpdGggc2FpKKPUo9OjyaPQKQ0KU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSAxNCwgMjAy
NCAxMDowNiBBTQ0KVG86ICdDaHJpcyBQYXRlcnNvbicgPENocmlzLlBhdGVyc29uMkByZW5lc2Fz
LmNvbTxtYWlsdG86Q2hyaXMuUGF0ZXJzb24yQHJlbmVzYXMuY29tPj4NCkNjOiAnY2lwLWRldkBs
aXN0cy5jaXAtcHJvamVjdC5vcmcnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzxtYWls
dG86Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc+PjsgaGF5YXNoaSBrYXp1aGlybyjX+SD7
+s7bIKPEo82jxSCh26PEo8mjx6Hgo82j0KPTodujzaPQo7QpIDxrYXp1aGlybzMuaGF5YXNoaUB0
b3NoaWJhLmNvLmpwPG1haWx0bzprYXp1aGlybzMuaGF5YXNoaUB0b3NoaWJhLmNvLmpwPj47IGRp
bmVzaCBrdW1hciij1KPTo8mj0CBUTUlFQyBPREcgUG9ydGluZykgPGRpbmVzaC5rdW1hckB0b3No
aWJhLXRzaXAuY29tPG1haWx0bzpkaW5lc2gua3VtYXJAdG9zaGliYS10c2lwLmNvbT4+DQpTdWJq
ZWN0OiBSRTogTEFWQSB0ZXN0IGpvYiBkZWZpbml0aW9ucyAoIHNvZnR3YXJlIHVwZGF0ZSwgc2Vj
dXJlIGJvb3QgYW5kIElFQyBsYXllciB0ZXN0aW5nICkNCg0KSGVsbG8gQ2hyaXMsDQoNCldlIGdv
dCBzb21lIG9waW5pb24gZnJvbSB5ZXN0ZXJkYXmhr3MgQ0lQIENvcmUgbWVldGluZyB0aGF0IGl0
IG1pZ2h0IG5vdCBiZSBvcHRpbWFsIHRvIHRvdWNoIHRoaXMgY29udGFpbmVyIEZpbGVzIKGkIG1h
c3RlciChpCBjaXAtcHJvamVjdCAvIGNpcC10ZXN0aW5nIC8gbGludXgtY2lwLWNpIKGkIEdpdExh
YjxodHRwczovL2dpdGxhYi5jb20vY2lwLXByb2plY3QvY2lwLXRlc3RpbmcvbGludXgtY2lwLWNp
Ly0vdHJlZS9tYXN0ZXI/cmVmX3R5cGU9aGVhZHM+IGFuZCBtb2RpZnkgdGhhdCBieSBhZGRpbmcg
Q0lQIENvcmUgam9iIGRlZmluaXRpb25zIGFuZCBzdWJtaXRfdGVzdHMgc2NyaXB0IHNwZWNpZmlj
IGZvciB0aGlzIHVzZS1jYXNlLiBEbyB5b3UgdGhpbmsgdGhlIHNhbWUgPyBJZiB5ZXMsIHRoZW4g
ZG8geW91IHRoaW5rIGNyZWF0aW5nIGEgZnJlc2ggcmVwb3NpdG9yeSB1bmRlciBjaXAtdGVzdGlu
ZyB1c2luZyB3aGljaCB3ZSBjYW4gYnVpbGQgdGhlIGNvbnRhaW5lcnMgYW5kIHNjcmlwdHMgdXNl
ZCBpbiB0aGUgQ0kgdGVzdGluZyBvZiBDSVAgQ29yZSBmdW5jdGlvbmFsaXRpZXMgaXMgYSBiZXR0
ZXIgY2hvaWNlID8NCg0KUGxlYXNlIHByb3ZpZGUgeW91ciBvcGluaW9uIG9uIHRoaXMgQ2hyaXMu
DQoNClRoYW5rcyBhbmQgUmVnYXJkcywNClNhaSBBc2hyaXRoICggVCBTIEkgUCApDQoNCkZyb206
IGFzaHJpdGggc2FpKKPUo9OjyaPQKQ0KU2VudDogTW9uZGF5LCBGZWJydWFyeSAxMiwgMjAyNCA4
OjI3IFBNDQpUbzogQ2hyaXMgUGF0ZXJzb24gPENocmlzLlBhdGVyc29uMkByZW5lc2FzLmNvbTxt
YWlsdG86Q2hyaXMuUGF0ZXJzb24yQHJlbmVzYXMuY29tPj4NCkNjOiBjaXAtZGV2QGxpc3RzLmNp
cC1wcm9qZWN0Lm9yZzxtYWlsdG86Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc+OyBoYXlh
c2hpIGthenVoaXJvKNf5IPv6ztsgo8SjzaPFIKHbo8SjyaPHoeCjzaPQo9Oh26PNo9CjtCkgPGth
enVoaXJvMy5oYXlhc2hpQHRvc2hpYmEuY28uanA8bWFpbHRvOmthenVoaXJvMy5oYXlhc2hpQHRv
c2hpYmEuY28uanA+PjsgZGluZXNoIGt1bWFyKKPUo9OjyaPQIFRNSUVDIE9ERyBQb3J0aW5nKSA8
ZGluZXNoLmt1bWFyQHRvc2hpYmEtdHNpcC5jb208bWFpbHRvOmRpbmVzaC5rdW1hckB0b3NoaWJh
LXRzaXAuY29tPj4NClN1YmplY3Q6IFJFOiBMQVZBIHRlc3Qgam9iIGRlZmluaXRpb25zICggc29m
dHdhcmUgdXBkYXRlLCBzZWN1cmUgYm9vdCBhbmQgSUVDIGxheWVyIHRlc3RpbmcgKQ0KDQpIZWxs
byBDaHJpcywNCg0KSG9wZSB5b3UgYXJlIGRvaW5nIHdlbGwuDQoNCkkgd2lsbCBzdW1tYXJpemUg
bXkgdW5kZXJzdGFuZGluZyBhbmQgYXBwcm9hY2ggdG8gdHJpZ2dlciBDSVAgQ29yZSB0ZXN0aW5n
IExBVkEgam9icy4NCg0KU28gY3VycmVudGx5IHdlIGhhdmUgYWxsIHRoZSBsYXZhIHRlbXBsYXRl
cyBpbiBsaW51eC1jaXAtY2kgY29udGFpbmVyIHdoaWNoIGFyZSBwcmUtcHJvY2Vzc2VkIHRvIGZv
cm0gZmluYWwgTEFWQSBqb2IgZGVmaW5pdGlvbnMgdXNpbmcgdGhlIHN1Ym1pdF90ZXN0cy5zaCCh
pCBtYXN0ZXIgoaQgY2lwLXByb2plY3QgLyBjaXAtdGVzdGluZyAvIGxpbnV4LWNpcC1jaSChpCBH
aXRMYWI8aHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC10ZXN0aW5nL2xpbnV4LWNp
cC1jaS8tL2Jsb2IvbWFzdGVyL3N1Ym1pdF90ZXN0cy5zaD9yZWZfdHlwZT1oZWFkcz4gc2NyaXB0
LiBBcyBJIHdlbnQgdGhyb3VnaCB0aGUgc2NyaXB0IEkgdW5kZXJzdG9vZCB0aGF0IGEgbG90IG9m
IGxvZ2ljIGlzIGludm9sdmVkIGluIHByZXBhcmluZyB0aGUgam9iIGRlZmluaXRpb25zIGZyb20g
dGhlIHRlbXBsYXRlIHNwZWNpZmljIGZvciBDSVAgS2VybmVsIHRlc3RpbmcuIEFuZCB0aGlzIHNj
cmlwdCBpcyBydW4gd2l0aCBhIHRyaWdnZXIgZnJvbSBoZXJlIGh0dHBzOi8vZ2l0bGFiLmNvbS9j
aXAtcHJvamVjdC9jaXAtdGVzdGluZy9saW51eC1jaXAtcGlwZWxpbmVzLy0vYmxhbWUvbWFzdGVy
L2xpbnV4LWNpcC1waXBlbGluZS55bWw/cmVmX3R5cGU9aGVhZHMjTDY5LiBJIGZlZWwgaXQgd2ls
bCBtZXNzIHVwIHRoZSBleGlzdGluZyB0ZXN0aW5nIGJlaW5nIGRvbmUgb24gQ0lQIGtlcm5lbCBh
bmQgc2hhbGwgYWxzbyByZXF1aXJlIGEgbG90IG9mIGVmZm9ydCB0byBpbnRlZ3JhdGUgY2hhbmdl
cyByZXF1aXJlZCB0byBwcmVwYXJlIGpvYiBkZWZpbml0aW9ucyBmb3IgQ0lQLUNvcmUgdGVzdGlu
ZyBjb25zaWRlcmluZyBodWdlIHZhcmlhdGlvbnMgaW4gdGhlIGZpbmFsIGpvYiBkZWZpbml0aW9u
cy4gQW5kIGFsc28gc2luY2Ugc3VibWl0X3Rlc3RzLnNoIGFscmVhZHkgd2l0aCBldmVyeSB0ZXN0
IGFjdGlvbiB0cmlnZ2VyIGluIGxpbnV4LWNpcC1waXBlbGluZXMueW1sLCBJIHRoaW5rIG1ha2lu
ZyBjaGFuZ2VzIHRvIHRoZSBzY3JpcHQgdG8gc3VwcG9ydCBDSVAtQ29yZSB0ZXN0aW5nIHdpbGwg
aW1wbHkgdGhhdCBldmVyeSB0cmlnZ2VyIGluIGxpbnV4LWNpcC1jaSBzaGFsbCB0ZXN0IG91ciBz
b2Z0d2FyZSB1cGRhdGUsIHNlY3VyZSBib290IGFuZCBJRUMgdGVzdHMgb24gUUVNVSBpbWFnZXMg
d2hpY2ggSSB0aGluayBpcyBub3QgcmlnaHQuDQoNCk91ciByZXF1aXJlbWVudCBoZXJlIGlzIHRv
IHRyaWdnZXIgYSBzY3JpcHQgd2hpY2ggc3VibWl0cyB0aGUgQ0lQLUNvcmUgcmVsYXRlZCBMQVZB
IGpvYiBkZWZpbml0aW9ucyB3aGVuIGEgY2hhbmdlIGlzIG1hZGUgaW4gaXNhci1jaXAtY29yZS4g
U28gSSB0aGluayB3ZSBjYW4gYSBzaG9ydCBzY3JpcHQgc2ltaWxhciB0byBzdWJtaXRfdGVzdHMu
c2ggbGlrZSBzdWJtaXRfY2lwX2NvcmVfdGVzdHMuc2ggYW5kIHNlcGFyYXRlIGZvbGRlciBmb3Ig
TEFWQSBkZWZpbml0aW9ucyBmb3IgQ0lQIENvcmUgdGVzdGluZyBpbiBjaXAtcHJvamVjdCAvIGNp
cC10ZXN0aW5nIC8gbGludXgtY2lwLWNpIKGkIEdpdExhYjxodHRwczovL2dpdGxhYi5jb20vY2lw
LXByb2plY3QvY2lwLXRlc3RpbmcvbGludXgtY2lwLWNpLy0vdHJlZS9tYXN0ZXI/cmVmX3R5cGU9
aGVhZHM+IGNvbnRhaW5lci4gV2Ugd2lsbCBydW4gdGhpcyBuZXcgc2NyaXB0IHVzaW5nIGEgdGVz
dCBhY3Rpb24gaW4gLmdpdGxhYi1jaS55bWwgSW4gaXNhci1jaXAtY29yZS4gSW4gdGhpcyBuZXcg
c2NyaXB0IHdlIHNoYWxsIHN1Ym1pdCBvbmx5IHRoZSBDSVAgQ29yZSByZWxhdGVkIGpvYiBkZWZp
bml0aW9ucyB3aGljaCB3ZSBhZGRlZCBpbiBhIHNlcGFyYXRlIGZvbGRlciBpbiBsaW51eC1jaXAt
Y2kgY29udGFpbmVyIHRvIExBVkEgbWFzdGVyLg0KDQpJIGNob3NlIHRoaXMgYXBwcm9hY2ggdG8g
bWluaW1pemUgdGhlIGVmZm9ydCBhbmQgYXZvaWQgbWVzc2luZyB1cCB0aGUgZXhpc3RpbmcgaW1w
bGVtZW50YXRpb24gd2hpY2ggaXMgaGlnaGx5IHNwZWNpZmljIGZvciBDSVAgS2VybmVsIHRlc3Rp
bmcgYW5kIHRvIGFsc28gdXNlIHRoZSBleGlzdGluZyBsaW51eC1jaXAtY2kgY29udGFpbmVyLiBU
aGlzIGlzIHRoZSBmaXJzdCB0aW1lIHdlIGFyZSB0ZXN0aW5nIENJUCBDb3JlIGZ1bmN0aW9uYWxp
dGllcyBvbiBMQVZBLCBzbyBpbml0aWFsbHkgd2Ugc3RhcnRlZCBzbWFsbCB3aXRoIFFFTVUgYW5k
IGluIHRoZSBmdXR1cmUgb25jZSB3ZSBzcHJlYWQgdGhlIHRlc3RpbmcgdG8gbXVsdGlwbGUgZGV2
aWNlcywgdGhlbiBtYXkgYmUgd2UgY2FuIHNldHVwIGEgbmV3IHJlcG9zaXRvcnkgbGlrZSBjaXAt
cHJvamVjdCAvIGNpcC10ZXN0aW5nIC8gbGludXgtY2lwLWNpIKGkIEdpdExhYjxodHRwczovL2dp
dGxhYi5jb20vY2lwLXByb2plY3QvY2lwLXRlc3RpbmcvbGludXgtY2lwLWNpLy0vdHJlZS9tYXN0
ZXI/cmVmX3R5cGU9aGVhZHM+IHRvIGJ1aWxkIGEgc2VwYXJhdGUgY29udGFpbmVyIG9ubHkgdG8g
ZGVhbCB3aXRoIENJUCBDb3JlIExBVkEgZGVmaW5pdGlvbnMuDQoNCldoYXQgZG8geW91IHRoaW5r
IG9mIG15IGFwcHJvYWNoIENocmlzID8gUGxlYXNlIHByb3ZpZGUgeW91ciBvcGluaW9uIGFuZCBj
b3JyZWN0IG1lIGlmIEkgYW0gd3JvbmcuDQoNCkkgYWxzbyByZXF1ZXN0IG90aGVyIENJUCBtZW1i
ZXJzIHRvIHByb3ZpZGUgdGhlaXIgc3VnZ2VzdGlvbnMuDQoNClRoYW5rcyBhbmQgcmVnYXJkcywN
ClNhaSBBc2hyaXRoICggVCBTIEkgUCApDQoNCkZyb206IENocmlzIFBhdGVyc29uIDxDaHJpcy5Q
YXRlcnNvbjJAcmVuZXNhcy5jb208bWFpbHRvOkNocmlzLlBhdGVyc29uMkByZW5lc2FzLmNvbT4+
DQpTZW50OiBGcmlkYXksIEZlYnJ1YXJ5IDksIDIwMjQgMjowOSBBTQ0KVG86IGFzaHJpdGggc2Fp
KKPUo9OjyaPQKSA8U2FpLlNhdGh1am9kYUB0b3NoaWJhLXRzaXAuY29tPG1haWx0bzpTYWkuU2F0
aHVqb2RhQHRvc2hpYmEtdHNpcC5jb20+Pg0KQ2M6IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qu
b3JnPG1haWx0bzpjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz47IGhheWFzaGkga2F6dWhp
cm8o1/kg+/rO2yCjxKPNo8UgodujxKPJo8eh4KPNo9Cj06Hbo82j0KO0KSA8a2F6dWhpcm8zLmhh
eWFzaGlAdG9zaGliYS5jby5qcDxtYWlsdG86a2F6dWhpcm8zLmhheWFzaGlAdG9zaGliYS5jby5q
cD4+OyBkaW5lc2gga3VtYXIoo9Sj06PJo9AgVE1JRUMgT0RHIFBvcnRpbmcpIDxkaW5lc2gua3Vt
YXJAdG9zaGliYS10c2lwLmNvbTxtYWlsdG86ZGluZXNoLmt1bWFyQHRvc2hpYmEtdHNpcC5jb20+
Pg0KU3ViamVjdDogUkU6IExBVkEgdGVzdCBqb2IgZGVmaW5pdGlvbnMgKCBzb2Z0d2FyZSB1cGRh
dGUsIHNlY3VyZSBib290IGFuZCBJRUMgbGF5ZXIgdGVzdGluZyApDQoNCkhlbGxvIFNhaSwNCg0K
Rmlyc3RseSwgbGV0oa9zIGdldCBzb21lIGJhY2tncm91bmQgZm9yIHRoaXMgcmVxdWVzdC4NCg0K
V2hhdCBpcyBpdCB5b3Whr3JlIHRlc3Rpbmc/IEFuZCB3aGVuIGlzIGl0IHlvdaGvZCBsaWtlIHRo
ZSB0ZXN0cyB0byBydW4/DQpJoa9tIGd1ZXNzaW5nIGlzYXItY2lwLWNvcmU/IEFuZCB3aGVuZXZl
ciBhIGNoYW5nZSBpcyBtYWRlIG9uIF9hbnlfIG9mIHRoZSBicmFuY2hlcz8gRS5nLiBuZXh0LCBt
YXN0ZXIgb3IgZmVhdHVyZSBicmFuY2hlcz8NCg0KT24gdGhlIExpbnV4IGtlcm5lbCBzaWRlIG9m
IHRoaW5ncywgdGhlIHRlc3QgcGlwZWxpbmVzIGFyZSBkcml2ZW4gYnkgbGludXgtY2lwLXBpcGVs
aW5lczxodHRwczovL2dpdGxhYi5jb20vY2lwLXByb2plY3QvY2lwLXRlc3RpbmcvbGludXgtY2lw
LXBpcGVsaW5lcz4gdXNpbmcgdGhlIHNjcmlwdHMgcHJvdmlkZWQgaW4gbGludXgtY2lwLWNpPGh0
dHBzOi8vZ2l0bGFiLmNvbS9jaXAtcHJvamVjdC9jaXAtdGVzdGluZy9saW51eC1jaXAtY2k+Lg0K
SG93ZXZlciwgbmVpdGhlciBvZiB0aGVzZSByZXBvc2l0b3JpZXMgYXJlIGN1cnJlbnRseSBzZXQg
dXAgZm9yIGNpcCBjb3JlIHRlc3RpbmcuDQpXZaGvZCBuZWVkIHRvIGFkZCBzb21ldGhpbmcgdG8g
aXNhci1jaXAtY29yZSB0byB0cmlnZ2VyIHRoZSB0ZXN0IGpvYnMsIGFuZCBoYXZlIGEgd2F5IHRv
IGNyZWF0ZSB0aGUgTEFWQSB0ZXN0IGpvYiBkZWZpbml0aW9ucyB3ZSBuZWVkIHRoZXJlLg0KDQpU
aGF0IHNhaWQsIHBlcmhhcHMgdGhlIHRlbXBsYXRlcyBhbmQgc3VibWl0X3Rlc3RzLnNoIHNjcmlw
dCBmcm9tIGxpbnV4LWNpcC1jaSBjb3VsZCBiZSB1cGRhdGVkIHRvIGJlIGFibGUgdG8gcnVuIHRo
ZXNlIHNlY3VyaXR5IHRlc3RzPw0KVGhlIGJ1aWxkIHNpZGUgb2YgaXNhci1jaXAtY29yZSBjYW4g
b2J2aW91c2x5IHN0YXkgYXMgaXQgaXMgbm93Lg0KVGFrZSBhIGxvb2sgdGhyb3VnaCB0aGUgYWJv
dmUgcmVwb3MgYW5kIHNlZSBpZiB3ZSBjb3VsZCBpbnRlZ3JhdGUgeW91ciBqb2IgZGVmaW5pdGlv
bnMgaW50byB0aGUgc2FtZSBsYXZhIHRlbXBsYXRlIHN0eWxlLiBPciB3aGV0aGVyIHlvdSB0aGlu
ayBpdCB3b3VsZCBiZSBjbGVhbmVyIHRvIHRha2UgYSBmcmVzaCBhcHByb2FjaCBzcGVjaWZpY2Fs
bHkgZm9yIGNpcCBjb3JlL3NlY3VyaXR5IHRlc3RpbmcuDQoNCktpbmQgcmVnYXJkcywgQ2hyaXMN
Cg0KRnJvbTogU2FpLlNhdGh1am9kYUB0b3NoaWJhLXRzaXAuY29tPG1haWx0bzpTYWkuU2F0aHVq
b2RhQHRvc2hpYmEtdHNpcC5jb20+IDxTYWkuU2F0aHVqb2RhQHRvc2hpYmEtdHNpcC5jb208bWFp
bHRvOlNhaS5TYXRodWpvZGFAdG9zaGliYS10c2lwLmNvbT4+DQpTZW50OiBNb25kYXksIEZlYnJ1
YXJ5IDUsIDIwMjQgNTo1OSBQTQ0KVG86IENocmlzIFBhdGVyc29uIDxDaHJpcy5QYXRlcnNvbjJA
cmVuZXNhcy5jb208bWFpbHRvOkNocmlzLlBhdGVyc29uMkByZW5lc2FzLmNvbT4+DQpDYzogY2lw
LWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc8bWFpbHRvOmNpcC1kZXZAbGlzdHMuY2lwLXByb2pl
Y3Qub3JnPjsga2F6dWhpcm8zLmhheWFzaGlAdG9zaGliYS5jby5qcDxtYWlsdG86a2F6dWhpcm8z
LmhheWFzaGlAdG9zaGliYS5jby5qcD47IGRpbmVzaC5rdW1hckB0b3NoaWJhLXRzaXAuY29tPG1h
aWx0bzpkaW5lc2gua3VtYXJAdG9zaGliYS10c2lwLmNvbT4NClN1YmplY3Q6IExBVkEgdGVzdCBq
b2IgZGVmaW5pdGlvbnMgKCBzb2Z0d2FyZSB1cGRhdGUsIHNlY3VyZSBib290IGFuZCBJRUMgbGF5
ZXIgdGVzdGluZyApDQoNCkhpIENocmlzLA0KDQpIb3BlIHlvdSBhcmUgZG9pbmcgd2VsbC4NCg0K
UGxlYXNlIHJldmlldyB0aGUgam9iIGRlZmluaXRpb25zIGF0dGFjaGVkIHRvIHRoaXMgbWFpbCBh
bmQga2luZGx5IHByb3ZpZGUgeW91ciByZXZpZXcgY29tbWVudHMuDQoNCkRvdWJ0czoNCg0KICAx
LiAgRG8gSSBuZWVkIHRvIGFkZCB0aGVzZSBkZWZpbml0aW9ucyBpbiB0aGlzIHJlcG9zaXRvcnk/
LiBodHRwczovL2dpdGxhYi5jb20vY2lwLXByb2plY3QvY2lwLXRlc3RpbmcvdGVzdC1kZWZpbml0
aW9ucw0KICAyLiAgSSBhbSBub3Qgc3VyZSBob3cgdG8gc2NoZWR1bGUgdGhlc2UgTEFWQSBqb2Jz
IGluIENJUCBMQVZBIGxhYi4gQ2FuIHlvdSBwbGVhc2UgaGVscCBtZSB3aXRoIHRoaXMgPw0KICAz
LiAgSSByZW1lbWJlciB5b3UgaW5zdGFsbGVkIHN3dHBtIGFuZCBvdm1mIHBhY2thZ2VzIGluIGxh
Yi1yZW5lc2FzLWNpcCBzbGF2ZS4gQ2FuIHlvdSBpbnN0YWxsIHRob3NlIHBhY2thZ2VzIGFsbCB0
aGUgQ0lQIExBVkEgc2xhdmUgbWFjaGluZXMgQ2hyaXMgPw0KDQpUaGFua3MgYW5kIFJlZ2FyZHMs
DQpTYWkgQXNocml0aCAoIFQgUyBJIFAgKQ0K

--_000_TYWPR01MB11862816FF930969C5B302BF4B7572TYWPR01MB11862jp_
Content-Type: text/html; charset="ks_c_5601-1987"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dks_c_5601=
-1987">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Gulim;
	panose-1:2 11 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:"\@MS PGothic";}
@font-face
	{font-family:"\@Gulim";
	panose-1:2 11 6 0 0 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:JA;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:36.0pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:JA;}
span.EmailStyle23
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:#7030A0;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:39207333;
	mso-list-template-ids:381990112;}
@list l1
	{mso-list-id:145242541;
	mso-list-type:hybrid;
	mso-list-template-ids:1258724112 67698703 67698713 67698715 67698703 67698=
713 67698715 67698703 67698713 67698715;}
@list l1:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-GB" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US">Hi Sai,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US">Sorry for the slow reply, I=
=A1=AFve been poorly.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US">It=A1=AFs certainly an option=
 to separate the cip-core testing container/scripts etc. from the kernel te=
sting, however most of the functionality will end up
 being very similar, so we=A1=AFll end up with duplication.<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US">Feel free to create your proj=
ect(s) in cip-playground, then we can move them across to cip-testing when =
ready &amp; we have approval from the TSC.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-ligatures:none;mso-fareast-language:EN-GB">Thanks, Ch=
ris<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"mso-ligatures:none;=
mso-fareast-language:KO">From:</span></b><span lang=3D"EN-US" style=3D"mso-=
ligatures:none;mso-fareast-language:KO"> Sai.Sathujoda@toshiba-tsip.com &lt=
;Sai.Sathujoda@toshiba-tsip.com&gt;
<br>
<b>Sent:</b> Monday, February 19, 2024 4:32 AM<br>
<b>To:</b> Chris Paterson &lt;Chris.Paterson2@renesas.com&gt;<br>
<b>Cc:</b> cip-dev@lists.cip-project.org; kazuhiro3.hayashi@toshiba.co.jp; =
dinesh.kumar@toshiba-tsip.com<br>
<b>Subject:</b> RE: LAVA test job definitions ( software update, secure boo=
t and IEC layer testing )<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">Hello Chris,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">Hope you are doing well.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">I request you to please provide your opinion about creating a fresh r=
epository under cip-testing which serves the purpose of creating container =
having CIP Core testing lava job definitions,
 lavacli dependencies and a simple script tp submit the tests to CIP LAVA s=
erver. We shall invoke this script in a separate action in .gitlab-ci.yml f=
ile in isar-cip-core.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">Thanks and Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">Sai Ashrith ( T S I P )<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"mso-ligatures:none"=
>From:</span></b><span lang=3D"EN-US" style=3D"mso-ligatures:none"> ashrith=
 sai(</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,s=
ans-serif;mso-ligatures:none">=A3=D4=A3=D3=A3=C9=A3=D0</span><span lang=3D"=
EN-US" style=3D"mso-ligatures:none">)
<br>
<b>Sent:</b> Wednesday, February 14, 2024 10:06 AM<br>
<b>To:</b> 'Chris Paterson' &lt;<a href=3D"mailto:Chris.Paterson2@renesas.c=
om">Chris.Paterson2@renesas.com</a>&gt;<br>
<b>Cc:</b> 'cip-dev@lists.cip-project.org' &lt;<a href=3D"mailto:cip-dev@li=
sts.cip-project.org">cip-dev@lists.cip-project.org</a>&gt;; hayashi kazuhir=
o(</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans=
-serif;mso-ligatures:none">=D7=F9</span><span lang=3D"JA" style=3D"mso-liga=
tures:none">
</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-s=
erif;mso-ligatures:none">=FB=FA=CE=DB</span><span lang=3D"JA" style=3D"mso-=
ligatures:none">
</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-s=
erif;mso-ligatures:none">=A3=C4=A3=CD=A3=C5</span><span lang=3D"EN-US" styl=
e=3D"mso-ligatures:none"> =A1=DB</span><span lang=3D"JA" style=3D"font-fami=
ly:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none">=A3=C4=A3=C9=A3=C7=
</span><span lang=3D"EN-US" style=3D"mso-ligatures:none">=A1=E0</span><span=
 lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-lig=
atures:none">=A3=CD=A3=D0=A3=D3</span><span lang=3D"EN-US" style=3D"mso-lig=
atures:none">=A1=DB</span><span lang=3D"JA" style=3D"font-family:&quot;MS P=
Gothic&quot;,sans-serif;mso-ligatures:none">=A3=CD=A3=D0=A3=B4</span><span =
lang=3D"EN-US" style=3D"mso-ligatures:none">)
 &lt;<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@t=
oshiba.co.jp</a>&gt;; dinesh kumar(</span><span lang=3D"JA" style=3D"font-f=
amily:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none">=A3=D4=A3=D3=A3=
=C9=A3=D0</span><span lang=3D"EN-US" style=3D"mso-ligatures:none"> TMIEC OD=
G Porting)
 &lt;<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar@toshiba-=
tsip.com</a>&gt;<br>
<b>Subject:</b> RE: LAVA test job definitions ( software update, secure boo=
t and IEC layer testing )<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">Hello Chris,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">We got some opinion from yesterday=A1=AFs CIP Core meeting that it mi=
ght not be optimal to touch this container
</span><span lang=3D"EN-US"><a href=3D"https://gitlab.com/cip-project/cip-t=
esting/linux-cip-ci/-/tree/master?ref_type=3Dheads">Files =A1=A4 master =A1=
=A4 cip-project / cip-testing / linux-cip-ci =A1=A4 GitLab</a> and modify t=
hat by adding CIP Core job definitions and submit_tests
 script specific for this use-case. Do you think the same ? If yes, then do=
 you think creating a fresh repository under cip-testing using which we can=
 build the containers and scripts used in the CI testing of CIP Core functi=
onalities is a better choice ?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">Please provide your opinion on this Chris.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">Thanks and Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">Sai Ashrith ( T S I P )<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"mso-ligatures:none"=
>From:</span></b><span lang=3D"EN-US" style=3D"mso-ligatures:none"> ashrith=
 sai(</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,s=
ans-serif;mso-ligatures:none">=A3=D4=A3=D3=A3=C9=A3=D0</span><span lang=3D"=
EN-US" style=3D"mso-ligatures:none">)
<br>
<b>Sent:</b> Monday, February 12, 2024 8:27 PM<br>
<b>To:</b> Chris Paterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com=
">Chris.Paterson2@renesas.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.c=
ip-project.org</a>; hayashi kazuhiro(</span><span lang=3D"JA" style=3D"font=
-family:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none">=D7=F9</span>=
<span lang=3D"JA" style=3D"mso-ligatures:none">
</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-s=
erif;mso-ligatures:none">=FB=FA=CE=DB</span><span lang=3D"JA" style=3D"mso-=
ligatures:none">
</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-s=
erif;mso-ligatures:none">=A3=C4=A3=CD=A3=C5</span><span lang=3D"EN-US" styl=
e=3D"mso-ligatures:none"> =A1=DB</span><span lang=3D"JA" style=3D"font-fami=
ly:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none">=A3=C4=A3=C9=A3=C7=
</span><span lang=3D"EN-US" style=3D"mso-ligatures:none">=A1=E0</span><span=
 lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-lig=
atures:none">=A3=CD=A3=D0=A3=D3</span><span lang=3D"EN-US" style=3D"mso-lig=
atures:none">=A1=DB</span><span lang=3D"JA" style=3D"font-family:&quot;MS P=
Gothic&quot;,sans-serif;mso-ligatures:none">=A3=CD=A3=D0=A3=B4</span><span =
lang=3D"EN-US" style=3D"mso-ligatures:none">)
 &lt;<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@t=
oshiba.co.jp</a>&gt;; dinesh kumar(</span><span lang=3D"JA" style=3D"font-f=
amily:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none">=A3=D4=A3=D3=A3=
=C9=A3=D0</span><span lang=3D"EN-US" style=3D"mso-ligatures:none"> TMIEC OD=
G Porting)
 &lt;<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar@toshiba-=
tsip.com</a>&gt;<br>
<b>Subject:</b> RE: LAVA test job definitions ( software update, secure boo=
t and IEC layer testing )<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">Hello Chris,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">Hope you are doing well.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">I will summarize my understanding and approach to trigger CIP Core te=
sting LAVA jobs.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">So currently we have all the lava templates in linux-cip-ci container=
 which are pre-processed to form final LAVA job definitions using the
</span><span lang=3D"EN-US"><a href=3D"https://gitlab.com/cip-project/cip-t=
esting/linux-cip-ci/-/blob/master/submit_tests.sh?ref_type=3Dheads">submit_=
tests.sh =A1=A4 master =A1=A4 cip-project / cip-testing / linux-cip-ci =A1=
=A4 GitLab</a> script. As I went through the script I
 understood that a lot of logic is involved in preparing the job definition=
s from the template specific for CIP Kernel testing. And this script is run=
 with a trigger from here
<a href=3D"https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-=
/blame/master/linux-cip-pipeline.yml?ref_type=3Dheads#L69">
https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-/blame/mast=
er/linux-cip-pipeline.yml?ref_type=3Dheads#L69</a>. I feel it will mess up =
the existing testing being done on CIP kernel and shall also require a lot =
of effort to integrate changes required
 to prepare job definitions for CIP-Core testing considering huge variation=
s in the final job definitions. And also since submit_tests.sh already with=
 every test action trigger in linux-cip-pipelines.yml, I think making chang=
es to the script to support CIP-Core
 testing will imply that every trigger in linux-cip-ci shall test our softw=
are update, secure boot and IEC tests on QEMU images which I think is not r=
ight.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Our requirement here is to trig=
ger a script which submits the CIP-Core related LAVA job definitions when a=
 change is made in isar-cip-core. So I think we can a short script similar =
to submit_tests.sh like submit_cip_core_tests.sh
 and separate folder for LAVA definitions for CIP Core testing in <a href=
=3D"https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-/tree/master?r=
ef_type=3Dheads">
cip-project / cip-testing / linux-cip-ci =A1=A4 GitLab</a> container. We wi=
ll run this new script using a test action in .gitlab-ci.yml In isar-cip-co=
re. In this new script we shall submit only the CIP Core related job defini=
tions which we added in a separate folder
 in linux-cip-ci container to LAVA master.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I chose this approach to minimi=
ze the effort and avoid messing up the existing implementation which is hig=
hly specific for CIP Kernel testing and to also use the existing linux-cip-=
ci container. This is the first time
 we are testing CIP Core functionalities on LAVA, so initially we started s=
mall with QEMU and in the future once we spread the testing to multiple dev=
ices, then may be we can setup a new repository like
<a href=3D"https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-/tree/m=
aster?ref_type=3Dheads">
cip-project / cip-testing / linux-cip-ci =A1=A4 GitLab</a> to build a separ=
ate container only to deal with CIP Core LAVA definitions.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">What do you think of my approac=
h Chris ? Please provide your opinion and correct me if I am wrong.<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I also request other CIP member=
s to provide their suggestions.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Thanks and regards,<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Sai Ashrith ( T S I P )</span><=
span lang=3D"EN-US" style=3D"mso-fareast-language:EN-US"><o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"mso-ligatures:none"=
>From:</span></b><span lang=3D"EN-US" style=3D"mso-ligatures:none"> Chris P=
aterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com">Chris.Paterson2@=
renesas.com</a>&gt;
<br>
<b>Sent:</b> Friday, February 9, 2024 2:09 AM<br>
<b>To:</b> ashrith sai(</span><span lang=3D"JA" style=3D"font-family:&quot;=
MS PGothic&quot;,sans-serif;mso-ligatures:none">=A3=D4=A3=D3=A3=C9=A3=D0</s=
pan><span lang=3D"EN-US" style=3D"mso-ligatures:none">) &lt;<a href=3D"mail=
to:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujoda@toshiba-tsip.com</a>&gt;<b=
r>
<b>Cc:</b> <a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.c=
ip-project.org</a>; hayashi kazuhiro(</span><span lang=3D"JA" style=3D"font=
-family:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none">=D7=F9</span>=
<span lang=3D"JA" style=3D"mso-ligatures:none">
</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-s=
erif;mso-ligatures:none">=FB=FA=CE=DB</span><span lang=3D"JA" style=3D"mso-=
ligatures:none">
</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-s=
erif;mso-ligatures:none">=A3=C4=A3=CD=A3=C5</span><span lang=3D"EN-US" styl=
e=3D"mso-ligatures:none"> =A1=DB</span><span lang=3D"JA" style=3D"font-fami=
ly:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none">=A3=C4=A3=C9=A3=C7=
</span><span lang=3D"EN-US" style=3D"mso-ligatures:none">=A1=E0</span><span=
 lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-lig=
atures:none">=A3=CD=A3=D0=A3=D3</span><span lang=3D"EN-US" style=3D"mso-lig=
atures:none">=A1=DB</span><span lang=3D"JA" style=3D"font-family:&quot;MS P=
Gothic&quot;,sans-serif;mso-ligatures:none">=A3=CD=A3=D0=A3=B4</span><span =
lang=3D"EN-US" style=3D"mso-ligatures:none">)
 &lt;<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@t=
oshiba.co.jp</a>&gt;; dinesh kumar(</span><span lang=3D"JA" style=3D"font-f=
amily:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none">=A3=D4=A3=D3=A3=
=C9=A3=D0</span><span lang=3D"EN-US" style=3D"mso-ligatures:none"> TMIEC OD=
G Porting)
 &lt;<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar@toshiba-=
tsip.com</a>&gt;<br>
<b>Subject:</b> RE: LAVA test job definitions ( software update, secure boo=
t and IEC layer testing )<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US">Hello Sai,<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US">Firstly, let=A1=AFs get some =
background for this request.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US">What is it you=A1=AFre testin=
g? And when is it you=A1=AFd like the tests to run?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US">I=A1=AFm guessing isar-cip-co=
re? And whenever a change is made on _<i>any</i>_ of the branches? E.g. nex=
t, master or feature branches?
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US">On the Linux kernel side of t=
hings, the test pipelines are driven by
<a href=3D"https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines">=
linux-cip-pipelines</a> using the scripts provided in
<a href=3D"https://gitlab.com/cip-project/cip-testing/linux-cip-ci">linux-c=
ip-ci</a>.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US">However, neither of these rep=
ositories are currently set up for cip core testing.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US">We=A1=AFd need to add somethi=
ng to isar-cip-core to trigger the test jobs, and have a way to create the =
LAVA test job definitions we need there.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US">That said, perhaps the templa=
tes and submit_tests.sh script from linux-cip-ci could be updated to be abl=
e to run these security tests?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US">The build side of isar-cip-co=
re can obviously stay as it is now.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US">Take a look through the above=
 repos and see if we could integrate your job definitions into the same lav=
a template style. Or whether you think it would
 be cleaner to take a fresh approach specifically for cip core/security tes=
ting.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-ligatures:none;mso-fareast-language:EN-GB">Kind regar=
ds, Chris<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"mso-ligatures:none"=
>From:</span></b><span lang=3D"EN-US" style=3D"mso-ligatures:none">
<a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujoda@toshiba-tsi=
p.com</a> &lt;<a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujo=
da@toshiba-tsip.com</a>&gt;
<br>
<b>Sent:</b> Monday, February 5, 2024 5:59 PM<br>
<b>To:</b> Chris Paterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com=
">Chris.Paterson2@renesas.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.c=
ip-project.org</a>;
<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@toshib=
a.co.jp</a>;
<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar@toshiba-tsip.=
com</a><br>
<b>Subject:</b> LAVA test job definitions ( software update, secure boot an=
d IEC layer testing )<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi Chris,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hope you are doing well.<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Please review the job definitio=
ns attached to this mail and kindly provide your review comments.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Doubts: <o:p></o:p></span></p>
<ol style=3D"margin-top:0cm" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0cm;mso-list:l1 level1 =
lfo3"><span lang=3D"EN-US">Do I need to add these definitions in this repos=
itory?.
<a href=3D"https://gitlab.com/cip-project/cip-testing/test-definitions">htt=
ps://gitlab.com/cip-project/cip-testing/test-definitions</a><o:p></o:p></sp=
an></li><li class=3D"MsoListParagraph" style=3D"margin-left:0cm;mso-list:l1=
 level1 lfo3"><span lang=3D"EN-US">I am not sure how to schedule these LAVA=
 jobs in CIP LAVA lab. Can you please help me with this ?<o:p></o:p></span>=
</li><li class=3D"MsoListParagraph" style=3D"margin-left:0cm;mso-list:l1 le=
vel1 lfo3"><span lang=3D"EN-US">I remember you installed swtpm and ovmf pac=
kages in lab-renesas-cip slave. Can you install those packages all the CIP =
LAVA slave machines Chris ?<o:p></o:p></span></li></ol>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Thanks and Regards,<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Sai Ashrith ( T S I P )<o:p></o=
:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_TYWPR01MB11862816FF930969C5B302BF4B7572TYWPR01MB11862jp_--

