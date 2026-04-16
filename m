Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2E8F8A16D
	for <webhook@archiver.kernel.org>; Thu, 16 Apr 2026 12:31:33 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.66])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12807.1776342690694048560
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Apr 2026 05:31:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=hoq35Ows;
 spf=pass (domain: siemens.com, ip: 52.101.65.66, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bUdFjwSCERZOjgzhE9Lhl/jH14IVXuTvN9zoTX8Nj2ZPDaTNhf4kHXM7YHdaJawVHt0mLMIssaGlVHtuYJhM3JGS6WEItpr/t2tKhIcdz355zQqCQxbMJrM02lmpNWDbrOdKtP6ZzUiF5BWRKsFzkkLdmoQ+nvBAXh+IfzhyghU13fog0v9+IWgILhg57FO5ROHoqrirO5ik23JMPNbGou+BWLY0FlQnAgtfBGgTT7Gq7mq9aZ9SAJao3DKbBntWr4A8JJsEhbplyFHM/IFPO/FSpTQ9nP6k48tQtcvTXtAeynbRt42/KPXZiyqGUPCCKXGhuGaHFXoDkVwMFdiyaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xcz/V5QqxryW0Y2qBzLaTMLmQ/rEKslcv5tXPCaVhM=;
 b=kVySPBWW1TNeudZUZqp+nR6UX/4iWsqd5xAfCE5p9Hvpwo5rFwJGtRKL5LyL+afv8JYyVyfdhMSS+cSlUhEBSgOi6ghOVZcKgzmpejq8h3s/hhVtFfU0sBihw9kebsTVtpLZ4kWS39kGKSYWMf2/o/4nsHVym2me34sp1XFYzQnyAmg1Q9tGpdmRfIf1ECu4psB59XwQ6AYZMdtU6/XPrOQhjK4Qr5LKhN8h/SmTFWst+ojDcL6QaiBLGP61G+HcdEEUU0HRNseL1K+T7ctX+38fh4w8iNdCWJW5BjegPM9NsDsHzdqkzk2+VNQpDTuwJtms88ZrS5UOc2CV+gZY5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xcz/V5QqxryW0Y2qBzLaTMLmQ/rEKslcv5tXPCaVhM=;
 b=hoq35OwsO2B4hgPagceJV6Twy4LDxXyvWWKYjI0brN2xLQOJvlLDC1Oru3NsqlXFKBv9YeoTNHNpYurPsCJknZG5WsY9XJhV6QImV0gLUb5lMKGMX1fWsfAn/vbJDiu9ViPdAJwwA9OXfkabYrB+IyHhPi+DW9gCvOLyogAm5tGWP4sw4IpjeHJ1vf3Bz9dqz9t2DwBdd22KWlftSkBaEB9t/WB83MrPdUpz3OnZKJnKfWEw56KoRpYRDGjwGoe9EHO8tFI+w0TxhS2uaOorI3zKMseuI/uvMHzqrfDe7uuwn9Smg1+Q/fy977jG6jwHbcFjAtgtdsbG2cTKIRwqyw==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by GVUPR10MB9933.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:346::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Thu, 16 Apr
 2026 12:31:27 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9412:cd7f:3f72:92ab]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9412:cd7f:3f72:92ab%3]) with mapi id 15.20.9818.023; Thu, 16 Apr 2026
 12:31:26 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "Gylstorff, Quirin" <quirin.gylstorff@siemens.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate: Set Debian build
 profile cross only if ISAR_CROSS_COMPILE is active
Thread-Topic: [cip-dev][isar-cip-core][PATCH] swupdate: Set Debian build
 profile cross only if ISAR_CROSS_COMPILE is active
Thread-Index: AQHczYb8SuvmblhF4Eq88KRGtBwGQLXhntQA
Date: Thu, 16 Apr 2026 12:31:26 +0000
Message-ID: <c8a2c673b124c18de0d0638121832d436c512e49.camel@siemens.com>
References: <20260416095328.964484-1-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20260416095328.964484-1-Quirin.Gylstorff@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-9 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|GVUPR10MB9933:EE_
x-ms-office365-filtering-correlation-id: cb84f8a0-41f7-42a9-fd56-08de9bb4143f
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|55112099003|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: 
 EMn/IBErjDefIq53W/xDI0k8yWPo9Vtku3oLY6DILTNJngqc1q2XCwQR862CNsL+H34Cp387sxFKxd4XiubfPqja6AAAK0r891E8lHdmDd0b4w3bJHSnqCLQHM8MVarhk+5lHPCtjSOWZt6gTeaOP5TxZBykUMH0h3HG8U4Yj5bcTW/wxvneoA1KYRDHJ0ZRpkt1TeULHScIlvDUvvNMUXHvhoZRw+3odXinQ9Co6XX/kTS91ojhLJpZF897Is/8COLti6FSW6SIlomwqYFjwINsPD9EoNDr4K2f7kasV/BIHlO6qs4iRGx+woQ1qDcD0xjshqcJlzChMqI3U4HOw8/BSzNCw1nbmftvDFzmAw+k7NKMeJHwkVP9m04xYBvgZG7W3SvU8/TlpnOoqAnaRegkluobYpVWJaLvcfV5/hv2S4CcNzFe1Gn/LO+up34jLF4IgIIRrVtSPsCAptb55mHC/Upd+hrrLWJKHW0nY1PrmIj1rLXmK1ZAoGyTcQasGWgyloIoRVRRKKU4AMhiawzkmxSnGTe9a7Du6VecAw2iLcZVK+CrjWcF+Qnkvwg+IcaTNtzcCsaDqyzPGDvvgtbLxZCk9qekccD0dximdswKQUALbY3uGCxU3xO4Q8uFEv6YlkC5W9BB35ifPlUulsBtWoDjdhVSxIJ9IXKMrvkQfzO+hQo8+HWlviCNGqXsrc4kGQi7g2GazsZzVz3SoHs+zFG2GzkFeDiTm32Jr5lKlMHr1HSutVpm7QvN92uekOKALOXys2S1BeszlOp+zkYuyrfNFKTf6nAlTPDNJHw=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RnNkVW4rWm16UVBzSmlKYzMyWXdJTGpXS0ZIbGcrTmE1TVoybWN6elJGZ1Iw?=
 =?utf-8?B?a0NzblVROE56SFhwQmQ0b1dKd1lBUnB5VUdVRGVvSkZDNHBUL0ZPWHlvN3BF?=
 =?utf-8?B?TzRPNzFmWWxzMnErS01qSFdibUg2dUpjNU9RL2pmQ2lCdGpVTGo1eWN5bmRQ?=
 =?utf-8?B?a0FROHpIVFdHTUtzUmNEbzJ6b2tkZm5nVjhnVDJ5NnRTNmgzWFJvK1ltS3Rk?=
 =?utf-8?B?TTlIcmZRZVYrWDF0SVBwb2dYN1RxcUZrTXpCK3RGOW9PY0FVZmxheHJ4T0VC?=
 =?utf-8?B?Z1lCYjkvWTJEeDJVSjFzdmdvWGNHS09SMFRPSXNKV0didUZZb1JyQjR6cVEw?=
 =?utf-8?B?K0FPQ2YvS1ZvajhSNmpnMWpSa3RnZDV0T0VuZ0xDVlJ4M0hOaEN4eThwSnVm?=
 =?utf-8?B?ekgwLzFUUHZraGFFdG9yMTRBMVZQTFlmSk9mNHpYcGlMSFF4c3BtRDRZbGNm?=
 =?utf-8?B?dklBTTF3bFg4Zjd4QUpYT0xTVHhORnNoTHNIRTYzZnVPWXNNcFJvTXV3WGps?=
 =?utf-8?B?NHFEaEIyZlAvRXExdUJQYnNweU51cFMxREJ1RzRta0lMQVo2R0JrY0Z5TDU5?=
 =?utf-8?B?bDVubXdtNEcwaXQxYTFyYzU1RUV4ZDJMdE9qb0ltdEF6MSs4RlA1Z1VaRVZK?=
 =?utf-8?B?d0hnRUVOUEIyQUQ5UkpnT1plN3hKb2QrOStrOVB4NldXZ0lLRktic3Fad05K?=
 =?utf-8?B?ZUovSUV0TVk5L1QrWGVPU0pLYU5SRi9Oc2VBamJ3WnY5K2dWS3E5Q3VUVzdQ?=
 =?utf-8?B?MlByNHVTUDFYUnQzcWQ0Z3o1cVVDZWNTV29YaUVtNk5wdkwrbm1sOFdlZkJm?=
 =?utf-8?B?VUEzVi9zV3ZkN2VQRytxYlZSUVBSc3lENWErSUVYTUdLanRJSlowc0UxV3dD?=
 =?utf-8?B?UFE0TXdzbDVDbG5raWxuUDBvSFBHNGlzVEFuV2FiTW10MDh6dWtVTVlYYU5H?=
 =?utf-8?B?eVpIa3gyaFlZUzl5WEVFcW55aVQxWkF1aWQzaFR0ekh6VE1sZFJIOEdSQzQ2?=
 =?utf-8?B?Wk9mYXRyK0ZVU09rL2lVQTI0c0toTk5UTmxkNjhxWk0xMjJyWjR3aUQ2K21D?=
 =?utf-8?B?RTJHdHhQL1NsTWwzWUVQZFN1bTBVRWxNdnEyZnhuNUY3OEtvbnBYdWxBUThU?=
 =?utf-8?B?V3pCV2p5SEprMEpwVk1yOHRVOW9pYmNQTmc1T0JueWkvTUlqSkVFRWQ1RTd1?=
 =?utf-8?B?M0k5VHhhZm1JK3dpem9wcDdVY0JZcEp0RW9zKzhJcGREOUdTNkVhQWZrZzdw?=
 =?utf-8?B?SGM3WlZNV2xPcDA0QnlpR2VEN1ZOU0hJSUQ1RFByaCtmalFmdyt4bTVqTjJM?=
 =?utf-8?B?cHc4NmpOaVVqN1MxV1FCVHBuU1N5R1JxQWJEaEtib2dJVVB6Wmc1U3g3UzBv?=
 =?utf-8?B?bUtQdkVaa3lrK1N5MmVia0plZHo2cGplUUxIRDdEK1NUaDlxZndSU3N5UlpH?=
 =?utf-8?B?RGEvYjVzeUdVbnhEVzFmeDRwMDFwckhFMXpESzNpUG5aTkg5Zm9URGFWZ3p6?=
 =?utf-8?B?MCtoUDVEeDNRaHhtQ0k5UE1lOGhXQjB1bUVVVkk1aHZnWHNGQklEc0diNWFG?=
 =?utf-8?B?OVJ2cmNUemlkbXhUL2RRNXUxbFJPRmV6d3dsa3hRblNvbTRmaTRnSmlYOXYr?=
 =?utf-8?B?RWorYU54d2RRcW16U29CQmZWSWdpL3pyaVhtTlBLSUJNUUxIS20zUnI3QktS?=
 =?utf-8?B?bTNCQnVkcEVrNmxkUG9XOTVqUStJZjZXM1E3Y3M4azdjeXYySmRIeFo2Tjhm?=
 =?utf-8?B?Qk5hdEJINGlBd2h0QmtKcWRjUm5zQU1Sb3FqRnNXRFdpcnhwS0tOc1pKOVQy?=
 =?utf-8?B?UE5NMXZ2N1QzeVZqVmNlaFVmSjJCNWJiaTc2NWpnQklSeHN5UHdwbjZvU2d5?=
 =?utf-8?B?SjJrcXlRNlNRRGVwU0YvN3MrUGpCdUlmY0JteE9ZRWpZK253NFR0c2RDS3d6?=
 =?utf-8?B?ci9MMzIzMG5pTVkwVFYwZ04ydTVwLy8vT1NzbHFsQ0JoNFpJVTV6SGtnL0px?=
 =?utf-8?B?SlI2bmhNQ1hYYXNBazU3dmlMOWpoN3NFZXRoOWNHMjZ4eE85RWJOWExWSG1F?=
 =?utf-8?B?RGJNOTF0UWVhQ1FyVHQyR2tGS1FrZENKWEVydmZNZDhsUDRScjZ1eWhBUjBy?=
 =?utf-8?B?R2lsdENvWlJ6akhjUnlidjZVdDFpaGh5azVKU0s5QitGVzBVTG9uaFgzM0pN?=
 =?utf-8?B?MnRoN3hDSVZuMXhDR01UVmxrNWRpMmdpU2ZHeXlEM3Q2RTh2N0V6NUh3TU1K?=
 =?utf-8?B?UHVSMnJvL1pGUXJjZCtEY1pUQU0zbjZUL2ExSGY5KzR1NFkvUFNSbmJOeHhz?=
 =?utf-8?B?VEk2eVM5aVJpQ3FyMW5IZFhNcUJLaWQ2bmtVVmJPUGFVdkg0K1NpQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B04DCCEA1C32DD4B849774B37020C731@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cb84f8a0-41f7-42a9-fd56-08de9bb4143f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 12:31:26.8822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BznPcjDYN5tiLuVT1nBtOrc5Tka8iuxfBW8hfsMyv/J/TTiFGwT7hPdPMe+DQdLDUjk3IiHiQzUfx4wedXJWyrhLN/qlfhYULFsq+x/WfCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVUPR10MB9933
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Apr 2026 12:31:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22737

T24gVGh1LCAyMDI2LTA0LTE2IGF0IDExOjUxICswMjAwLCBRdWlyaW4gR3lsc3RvcmZmIHZpYSBs
aXN0cy5jaXAtCnByb2plY3Qub3JnIHdyb3RlOgo+IEZyb206IFF1aXJpbiBHeWxzdG9yZmYgPHF1
aXJpbi5neWxzdG9yZmZAc2llbWVucy5jb20+Cj4gCj4gVGhpcyBhdm9pZHMgdGhlIGZvbGxvd2lu
ZyBlcnJvciB3aXRoIGJ1aWxkaW5nIGJvb2t3b3JtIG9yIG9sZGVyIGluCj4gdHJpeGllOgo+IAo+
IEU6IFRoZSBwYWNrYWdlIGNhY2hlIHdhcyBidWlsdCBmb3IgZGlmZmVyZW50IGFyY2hpdGVjdHVy
ZXM6IGFtZDY0IHZzCj4gVzogWW91IG1heSB3YW50IHRvIHJ1biBhcHQtZ2V0IHVwZGF0ZSB0byBj
b3JyZWN0IHRoZXNlIHByb2JsZW1zCj4gRTogVGhlIHBhY2thZ2UgY2FjaGUgZmlsZSBpcyBjb3Jy
dXB0ZWQKPiBFOiBhcHQtZ2V0IHVwZGF0ZSBmYWlsZWQKPiBTaWduZWQtb2ZmLWJ5OiBRdWlyaW4g
R3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29tPgo+IC0tLQo+ICByZWNpcGVz
LWNvcmUvc3d1cGRhdGUvc3d1cGRhdGUuaW5jICAgICAgICB8IDQgKysrLQo+ICByZWNpcGVzLWNv
cmUvc3d1cGRhdGUvc3d1cGRhdGVfMjAyMy4xMi5iYiB8IDMgLS0tCj4gIDIgZmlsZXMgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9yZWNp
cGVzLWNvcmUvc3d1cGRhdGUvc3d1cGRhdGUuaW5jIGIvcmVjaXBlcy1jb3JlL3N3dXBkYXRlL3N3
dXBkYXRlLmluYwo+IGluZGV4IDQ5N2IxYzIuLjU5ZGI2MzEgMTAwNjQ0Cj4gLS0tIGEvcmVjaXBl
cy1jb3JlL3N3dXBkYXRlL3N3dXBkYXRlLmluYwo+ICsrKyBiL3JlY2lwZXMtY29yZS9zd3VwZGF0
ZS9zd3VwZGF0ZS5pbmMKPiBAQCAtMzcsOCArMzcsMTAgQEAgREVQRU5EUyArPSAiJHtAYmIudXRp
bHMuY29udGFpbnMoJ0RFQl9CVUlMRF9QUk9GSUxFUycsICdtdGQnLCAnbXRkLXV0aWxzJywgJycs
IGQKPiAgU1dVX1NJR05FRCA/PSAiMSIKPiAgREVCX0JVSUxEX1BST0ZJTEVTICs9ICIke0AncGtn
LnN3dXBkYXRlLm5vc2lnbmluZycgaWYgbm90IGJiLnV0aWxzLnRvX2Jvb2xlYW4oZC5nZXRWYXIo
J1NXVV9TSUdORUQnKSkgZWxzZSAnJ30iCj4gIAo+ICtERUJfQlVJTERfUFJPRklMRVMgKz0gIiR7
QCdjcm9zcycgaWYgYmIudXRpbHMudG9fYm9vbGVhbihkLmdldFZhcignSVNBUl9DUk9TU19DT01Q
SUlMRScpKSBlbHNlICcnfSIKClRoaXMgc2hvdWxkIG5vdCBiZSBuZWVkZWQsIGFzIGNyb3NzIGlz
IGF1dG9tYXRpY2FsbHkgc2V0IGJ5IHNidWlsZCB3aGVuCmNyb3NzIGNvbXBpbGluZy4gRm9yIGRl
dGFpbHMsIHNlZSBtYW4gc2J1aWxkOgoKLS1wcm9maWxlcz1wcm9maWxlWywuLi5dIFNwZWNpZnkg
dGhlIHByb2ZpbGUocykgd2UgYnVpbGQsIGFzIGEgY29tbWEtCnNlcGFyYXRlZCBsaXN0LiBEZWZh
dWx0cyB0byB0aGUgc3BhY2Ugc2VwYXJhdGVkIGxpc3Qgb2YgcHJvZmlsZXMgaW4gdGhlCkRFQl9C
VUlMRF9QUk9GSUxFUyBlbnZpcm9ubWVudCB2YXJpYWJsZSB3aGVuIGJ1aWxkaW5nIG5hdGl2ZWx5
IG9yIHRoZSAKY3Jvc3MgIGFuZCAgbm9jaGVjayAgcHJvZmlsZXMgd2hlbiBjcm9zcy1idWlsZGlu
Zy4KCkZlbGl4Cgo+ICsKPiAgIyBhZGQgY3Jvc3MgYnVpbGQgYW5kIGRlYWN0aXZhdGUgdGVzdGlu
ZyBmb3IgYXJtIGJhc2VkIGJ1aWxkcwo+IC1ERUJfQlVJTERfUFJPRklMRVMgKz0gImNyb3NzIG5v
Y2hlY2siCj4gK0RFQl9CVUlMRF9QUk9GSUxFUyArPSAibm9jaGVjayIKPiAgCj4gIHB5dGhvbiBk
b19jaGVja19ib290bG9hZGVyICgpIHsKPiAgICAgIGJvb3Rsb2FkZXIgPSBkLmdldFZhcigiU1dV
UERBVEVfQk9PVExPQURFUiIpIG9yICJOb25lIgo+IGRpZmYgLS1naXQgYS9yZWNpcGVzLWNvcmUv
c3d1cGRhdGUvc3d1cGRhdGVfMjAyMy4xMi5iYiBiL3JlY2lwZXMtY29yZS9zd3VwZGF0ZS9zd3Vw
ZGF0ZV8yMDIzLjEyLmJiCj4gaW5kZXggNjgyMjE1My4uODk3ODViNiAxMDA2NDQKPiAtLS0gYS9y
ZWNpcGVzLWNvcmUvc3d1cGRhdGUvc3d1cGRhdGVfMjAyMy4xMi5iYgo+ICsrKyBiL3JlY2lwZXMt
Y29yZS9zd3VwZGF0ZS9zd3VwZGF0ZV8yMDIzLjEyLmJiCj4gQEAgLTM5LDkgKzM5LDYgQEAgREVC
X0JVSUxEX1BST0ZJTEVTICs9ICJwa2cuc3d1cGRhdGUuc3VyaWNhdHRhd2Z4Igo+ICAjIHdpdGgg
Y3Jvc3MgY29tcGlsZSB3ZSBoYXZlIGEgdW5zYXQtZGVwZW5kZW5jeSB0byBkaC1ub2RlanMgb24g
YXJtL2FybTY0Cj4gIElTQVJfQ1JPU1NfQ09NUElMRTpidWxsc2V5ZSA9ICIwIgo+ICAKPiAtIyBh
ZGQgY3Jvc3MgYnVpbGQgYW5kIGRlYWN0aXZhdGUgdGVzdGluZyBmb3IgYXJtIGJhc2VkIGJ1aWxk
cwo+IC1ERUJfQlVJTERfUFJPRklMRVMgKz0gImNyb3NzIG5vY2hlY2siCj4gLQo+ICAjIHVzZSBi
YWNrcG9ydCBidWlsZCBwcm9maWxlIGZvciBidWxsc2V5ZQo+ICBERUJfQlVJTERfUFJPRklMRVMg
Kz0gInBrZy5zd3VwZGF0ZS5icG8iCj4gIAo+IC0tIAo+IDIuNTMuMAo=

