Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF52C2BD09
	for <webhook@archiver.kernel.org>; Tue,  9 Jul 2024 17:54:59 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.41])
 by mx.groups.io with SMTP id smtpd.web11.8693.1720095362369496829
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Jul 2024 05:16:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=wjiYpI+i;
 spf=pass (domain: siemens.com, ip: 40.107.20.41, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csjNJ7bLr4GziBa+n2oV5USw0CgcCa70QhjhyHU2ipxS2mvt3ZD4TSFQ3NnwSnO6TIKk8GtSu0GjwlFnDNxmQdBkWHnh+XCP7OY3OBNgnRe4Bxy+iarE7zMboVApBty2ed2gyqWHozVCGuQMfGZqk4ONSY5XomkXqcs1earIWTatfMlo0qDZS9jbEPwP7wCgomjUMdyX4KKZKfaP1vZ08yXqTzSSbsnwp5LnXdmuWrrySFus+2CGw7AcwT+mw6g6O2svLxCqSzjQ1iTtN8uF3cuxF21cakgvd60XfUJBFZjvorjyl7vHzgo4HgAfMaWJPIvimZLLB3uE1or9kvjguQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZwyJJnzRPuf9OVxqxFZnMM5xKZG1j0rEw223QcZGwI=;
 b=JLm/eK46VJC+iPuXtHjHKHDGzTbwU4cYxrIWQQfmVMSjqYgGBKWJcOeEJ0vt+z0Ja2vHhYlVSS5PRLDh5iDbE0TZZocx50AC+EZgP0E06I9n/4r3B39eLKVwmDLKTScLV5e6H781nOR5Tw43Gc/W9d9hzncfhNsjdrB8myMvY7lQFXz0YC7wRqimhVkupUgwc6kRIi36xcT/RjhZZJQBgNusRO/P53pIe2ovCoybzvAD2OtJvsMizSXiSfDCYCWUM8IMm1DVTJkMrzioIWkckQHYyAaZ6waxuqoTMHUvWIazw2gnsPAutWkrHFQGMsfMLuc2dASLruBEgm4fWbxWRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZwyJJnzRPuf9OVxqxFZnMM5xKZG1j0rEw223QcZGwI=;
 b=wjiYpI+i2SwT9HG2s1t/WSVqysPExlSZFxiOL03hx2E6cHIofWtuFjU6tGf+32xzg5VN/fD1FFi8hWXoj/evjXqPHjA4TQeRQwUZO+tfex1ObXOsRM74JykPiGT2OGWNFlLS9+pqBErQabcROB9S41BvYZ6Z/rfRGGy5KqZvy5+ZTbUPgR07BGyflxa2myMYW/d5TJB5fQdN2VK7+maF3RYh+2IWLetZumC3nw9GopQYtscrcvqwXupdp7YW6M2tLulGErOSz5bS22WytQUGTAfWyeRV+vET9CRVyS/nIW8hYccteJ/6KhTrsFofkOYG+OLZEfpt++JQ7FEGPpD/kw==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by AS8PR10MB7873.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:63e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Thu, 4 Jul
 2024 12:15:58 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%3]) with mapi id 15.20.7719.028; Thu, 4 Jul 2024
 12:15:58 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "ch@denx.de" <ch@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: Re: [PATCH] swupdate.bbclass: make swu_files entries unique
Thread-Topic: [PATCH] swupdate.bbclass: make swu_files entries unique
Thread-Index: AQHazgvtp9Cm1bR3EkmH4ftc/P2uRw==
Date: Thu, 4 Jul 2024 12:15:58 +0000
Message-ID: <7a7ed1e59a5682144aaaad819fbbd1264f3ece34.camel@siemens.com>
References: <20240703114242.1896508-1-ch@denx.de>
In-Reply-To: <20240703114242.1896508-1-ch@denx.de>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|AS8PR10MB7873:EE_
x-ms-office365-filtering-correlation-id: b7ff3764-f4f5-420e-8db3-08dc9c231001
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?WVFKVkR4TVAwNmYvQTVjbnM3bnphVnUzMHJqdDFoRjVxRHVmL0liTjF3NTZB?=
 =?utf-8?B?OG1kNWRmZ3Ztem1nNlVVZWhoazc0SUF2b3phRjBXSEZyVHR1bm4vZWNxZkNB?=
 =?utf-8?B?bjV6T1BITFRpY3Z5TjU3RkRKOHhtckkvT3gxbHE4V2N6MzV0ZnFJSWJickdi?=
 =?utf-8?B?ZG5qS25QQ04yL29SL3RTZmZWa29LTjg2NUNBNWZIU0QxdHNHbFVVL0VReUJF?=
 =?utf-8?B?V3dxdlVzbmoxZys0SFdRMnIvNUwwOURRWm4rTHdhV1BtN0RITVpveEorSU00?=
 =?utf-8?B?eDRhdTBkVkZ0UmZMOFRxeGFPcHJzcSt3eVJKYjF6eThRQkxXdFdmSUFSNFV3?=
 =?utf-8?B?SVE0TjczRmRldGRZb0JtRGpmMGk1andzckRTMmNFekhHS0lldFVwelY3VGg3?=
 =?utf-8?B?ajE1Q01Xc3VEVHVXbDBjL2JnbEMveU8vSnF3eE83U1ZzOGNNSWhIWlhsRjFB?=
 =?utf-8?B?dXNWZFEzVXlyNzRldkNMa0hFelhWTTdpRDJiWE44ejhhbHF4eXR0ckdtaWdI?=
 =?utf-8?B?c2hVNUdoc2FLME9nOFdDZ2RWaHd2dmc4amFYZmRiTTBvSE5TNkZZbEV2TU15?=
 =?utf-8?B?N1BRYXAybjdITDdzSEZyNXM0cEpDek1xQW9GTXhSamRXa2F2cmRqcFY2STkw?=
 =?utf-8?B?UmVDTmtMc3hLQTJZLzUvdC9Bbm1zSkNZNzZRbXY2c0hWbDJkaE53NklGMEJQ?=
 =?utf-8?B?U0pkNFZWYkEvc0lWb0RjVjNKai9ab1hETzdYc0ZsMG11SHhqanhZbHpwbnNY?=
 =?utf-8?B?eHJSZ1laQjdLS3VsRjVXY21SRGtVZUVzbGlrV1F2QUlWV29LYkRLdW1SY2Rs?=
 =?utf-8?B?U0UyMnlrbndiS2UzWXc1S3I3RDhXUW5OZHI3UlUvMTZBdzR4bnlLSXJ6RjBP?=
 =?utf-8?B?YWJKNUJrdGV5bW5kMFBOOGN1Yk83eVRRQTUwQXN6WkNlRXhyYnRwTVpPWW9O?=
 =?utf-8?B?VVJYTUNwVlFVcG8wMDk5ZXg1R1NKT3NPNmhKUTFWQ2JSaXVZelFacGFROU1S?=
 =?utf-8?B?OXJpTWc4Rm15RUdESnliSXdnTlRobzVTWUc5Sm5WTFUrRnRZV2wyQytkSVpC?=
 =?utf-8?B?cFdLUXdDVStQTnhVdGhzdHhEc2c5djZkczVFVUVXRWpKYi9WbVMveVorK3Ay?=
 =?utf-8?B?c2ZIdHNHYlpPdGwxNGJKVU82Wkg3S2l6bm1KcmZoQ2RtblprZUE2TXBhV2tY?=
 =?utf-8?B?aTNRRFdTTHpreHh2WHE4Y1E0YjBUR0lxZWdBMHpoaHRIRFBPd2xSQjN2ZE02?=
 =?utf-8?B?Ui94blh4OXkxUllXeFFHLzV1Qmp3RkVwYUM0akI1cVNkMDdKQkMwU3B6REdR?=
 =?utf-8?B?MGt6WEZRQzJIdm9ra3FYTWcwcHFqa2VPMEx1SHVNSGdlUjVJVnBaZUJnQkx4?=
 =?utf-8?B?V1RHVFY2VmdQenB3K2Q4WmNBdU9YMGtSK1pmdS9MMjlQeVVMTnlWV2k0djhi?=
 =?utf-8?B?TmZINmZVWWdpdlJEZWxWdG1pTUc0QVFjUVpUTHhhWnl5OVh2emtQT1RXUUVH?=
 =?utf-8?B?VTZ1QlU3Yjh1RWtidzVCVHpvLzIveGZXbGZxelgwTTY4K0lnMjZ4UnpuSDhH?=
 =?utf-8?B?M0pLcHVoWWw0M3pEeGxMb28xVVVpUEJvT1hEUUdWZi95WUkxbXRNZzFDa3JT?=
 =?utf-8?B?R2NielVhNW1ZMzNLMi9lbEJ5RG80UXF4WEZYeTRPcmJ6dVZqeDFlTGRWcmlu?=
 =?utf-8?B?emJLa2kxSEdSWE1tL0QwT1dUelQ5bmZLdXBEUXZ5KzNvQ2J3dGJyYkRtdTAx?=
 =?utf-8?B?Ty9KNUtmNUtCSVc4RkdsWkE2aCt3K2xVQTZ6aFZ5QXovSzBLZG5FWnZWL0pU?=
 =?utf-8?B?NUppT3NSMlRidGhwVDllU1B4ZTdDdnV0YUFHWGt4WEVYQkIwNEt5dTJBWWdZ?=
 =?utf-8?B?dnB1NDZJQTV2M1Z0YmI4bGVib2lVSGU0MndRZU5xU09Lenc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VDRkRGlCQU1qQ3dEbXRrUlMxbnZEV3cvcU1FbVc1dVNJa2R1Q1NRTm9TWkpZ?=
 =?utf-8?B?YjJyYU9HUVJiZjRmakpOUTNjTFNXcXhJeGRCb2VFZjEvMGxqa2ZhWG9EZFNx?=
 =?utf-8?B?VG4xRTlkTHJjbk9kamtzSGFabHl2UGVFN2pwTjNiZUNLTW5IQlBXaFREWVpn?=
 =?utf-8?B?V1VSZ0tldkUzdjV6dk9mUUR4cFFONTVhdUt1dVByTVVrMXJCREgvZWJTNjI0?=
 =?utf-8?B?UlZsbVRkcHF1d0ZlRUV1R3Y2TmJ6TFFJSU9JMjlCeUowS3lZcGVUK1hiQURI?=
 =?utf-8?B?V05TUWRBSHdsZUYyNlRSK2hYRnYvYVNCNDlzTTNZVWFEMGNXWHIzcUd2bWxv?=
 =?utf-8?B?c0lxaE5nMGE5bGt2L1B2UUoxanlFOTczMStFSGpOSGJWcDV5aUZlNWgyTE53?=
 =?utf-8?B?TFlzb3BDOURUMFVVYUcyanBnRnhLS3Z4cktWWVoyK0l1SDAyOHdCaGFDVEpl?=
 =?utf-8?B?MktnUXhqN0FtNDFuZGNmVkxqSGZXZFpkcitvWHcwWk9pUmNaenRuOVNMUm9z?=
 =?utf-8?B?UUs1SE4vcnNVajB3Q3Y2M05pOHgxazVvQmpzZlV1NWtsUXp4RUl0Ry9uRzVL?=
 =?utf-8?B?SW1pbExTZCtwWW83eEZsNU5GaDFtU0pHVGdqRXMweTAwOE9xVlBNaGJXYzJX?=
 =?utf-8?B?aWxNOUdmSHZ1TUxoRVRsaUx6bW9zTUtXejZlV1VQalNhZU1ITnZIUENZVjQr?=
 =?utf-8?B?c0xMdFNac3kwRGlpMUR3eEp0VzFmb3llNS9rNHlkTHk2eFVoVXNEd3pBejAx?=
 =?utf-8?B?MFZCcFRYQkdHWDVlUTJKYmMwNEVjVGVlOFhzNzZQUXFkY3FBWUtTdmVtMkps?=
 =?utf-8?B?QWhEY0ErWXo3bGd3eldwc0JoZ1Q5TjdyZmxVWXlHR3BSejd3RlpzQWpCc2lZ?=
 =?utf-8?B?d3dzamZkYjBBdzRsSTA3YVVKb2ZOenNxb3V0dnVZeklEMHpZREpMYVc2c0Jt?=
 =?utf-8?B?ZkVYbXltbmw0MGE1VW9OYURRN1JTKzhUUEk1ZlFwTzljaThZb2QyWlZUUE51?=
 =?utf-8?B?R1pyWEZJdEJLRDE3N1BlOGd4TmZiZFFJK0I3ZTNsanRnYXBUaUxpTnFqWmJp?=
 =?utf-8?B?Mzh6MlZCL2RQM1BQUFYrbm00bm1wSjEwcVRSRkkwa3VFT0QxcUlsZ1NmbCty?=
 =?utf-8?B?YXZxUDBUVXA2VktDMnZFQ25HVUNQRmhnRVE3QmV6eUxpd2lWOWQ1V3ZqZHZp?=
 =?utf-8?B?bHpyRERMNzBZSVJkRFMyZmkzekJNdy9RMlVnVEVjTnhCb29YTmI1VGUrSTZi?=
 =?utf-8?B?K05oOHRNVVJ1azlXTmlxZjVQYmprekJjeGNEUk9jL0xIVzlNZmNmblVxYUpk?=
 =?utf-8?B?aitKTlZYSlgxNHZSV2YycEFWcHQ3b1pCZjROSzlSY3psdzNidVlUdmtPQkVW?=
 =?utf-8?B?ZXdDejFRRVZ0UWlmSEp4RjZZU1dTVjQxdkt3ejBNS08zN1NtOTg0VUFmYWpj?=
 =?utf-8?B?emZ4WFM1Y0xGZHlQOUFKTEVsZjRoOUphZEw0a09OYTNmVTM4c3VnRi94WUh4?=
 =?utf-8?B?T3dubVZ5cytVYjVQTHNSQlpWMlNCNExRUnhpKysyQysrTGkxQ3Q0RGpmcXF0?=
 =?utf-8?B?dEdGK2x4RlNpTnZsVmdoWGg5WjhTYlVBckNGejdxZ2NkeDdQQ2RjbU05dDZY?=
 =?utf-8?B?OUgxcWNTaVFMMHFZR2dYczdzdjMxQWQwUzIwdjdaRnZUNFNUTDZJYU92R0VK?=
 =?utf-8?B?SVlOVDlUNmQ2VFNiWGFsWDVlNk5HZjd4dUhiSUJQbTBQblhhQ0FiZHhMNEZE?=
 =?utf-8?B?Yk5WWlBwcFFwdDNydnpIN0VMRTdhcXBvbzdLZndac0tLV3JkdFg0Mkk3bEl1?=
 =?utf-8?B?eEllemRweWFrOC9lVU1aY0lqY29TMGRnL0l0QjRtVXZZOTdFbGFHMnlnQlZC?=
 =?utf-8?B?cHFQc1VKazJFVlQzdWswTld5NTJGVW9OZFZhcDNUM0RtMnptSVpMbENPWmJO?=
 =?utf-8?B?UStNN0JSZWwydFkrRC9UeFp3b3k2NDYvWmVNUkdpMFFqajRKTDUzaVNDZUV1?=
 =?utf-8?B?K1E1a2JNcGg1c3Y4ZkhXRktkTzI3SzRMQml5NEhFMFhiTXY0UzFGb2YzL2Zu?=
 =?utf-8?B?MUVMSDRqdVdLc1gxbzF4WlF5anhqcWV4TlZIcC90NGVuMWQwSHNSSkh1eGIr?=
 =?utf-8?B?bFJodlllR3AvMWxxYU5sekZrNjZsM0hNQmZpVktLc001Z3FrUjVxaFJ0ZVFw?=
 =?utf-8?Q?VGOodkuN32fF4m01emNLNeE=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ff3764-f4f5-420e-8db3-08dc9c231001
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 12:15:58.5644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hnTyGswV6t7K9+z7MyW9XrLnkgPx3XHyW7E8T0ocCyO3MXL6NQhNwotV804hN+F0rh/qLsezJjLmT3i1Ri4Rv5pvRMmAtW0FyoZP/4PksHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7873
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5A90E169C0AC340B0439033D1B596F3@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 Jul 2024 17:54:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16444

T24gV2VkLCAyMDI0LTA3LTAzIGF0IDEzOjQyICswMjAwLCBDbGF1ZGl1cyBIZWluZSB3cm90ZToN
Cj4gSW4gY2FzZSBhIHN3LWRlc2NyaXB0aW9uIGNvbnRhaW5zIG11bHRpcGxlIGVudHJpZXMgb2Yg
dGhlIHNhbWUgZmlsZSwNCj4gc3d1X2ZpbGVzIHdpbGwgY29udGFpbnMgbXVsdGlwbGVzIG9mIHRo
ZSBzYW1lIGZpbGUgYW5kIHRodXMgbGF0ZXINCj4gb3BlcmF0aW9ucyBmYWlsLg0KDQpIaSwgSSdt
IHdvbmRlcmluZyBob3cgdGhhdCBjYW4gaGFwcGVuLCBidXQgT0suDQoNCj4gDQo+IFRoaXMgY2hh
bmdlIG1ha2VzIHRoZSBmaWxlcyBpbiB0aGUgc3d1X2ZpbGVzIHZhcmlhYmxlIHVuaXF1ZSwgc28g
dGhleQ0KPiBhcmUgb25seSBvcGVyYXRlZCBvbiBvbmNlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
Q2xhdWRpdXMgSGVpbmUgPGNoQGRlbnguZGU+DQo+IC0tLQ0KPiDCoGNsYXNzZXMvc3d1cGRhdGUu
YmJjbGFzcyB8IDIgKy0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9jbGFzc2VzL3N3dXBkYXRlLmJiY2xhc3MgYi9j
bGFzc2VzL3N3dXBkYXRlLmJiY2xhc3MNCj4gaW5kZXggZTkxMjM4ZC4uNWU1NDg1MyAxMDA2NDQN
Cj4gLS0tIGEvY2xhc3Nlcy9zd3VwZGF0ZS5iYmNsYXNzDQo+ICsrKyBiL2NsYXNzZXMvc3d1cGRh
dGUuYmJjbGFzcw0KPiBAQCAtMjA1LDcgKzIwNSw3IEBAIElNQUdFX0NNRDpzd3UoKSB7DQo+IMKg
wqDCoMKgwqDCoMKgwqAgc3d1X2ZpbGVfYmFzZT0kKGJhc2VuYW1lICRzd3VfZmlsZSkNCj4gwqDC
oMKgwqDCoMKgwqDCoCAjIENyZWF0ZSBzeW1saW5rcyBmb3IgZmlsZXMgdXNlZCBpbiB0aGUgdXBk
YXRlIGltYWdlDQo+IMKgwqDCoMKgwqDCoMKgwqAgc3d1X2ZpbGVzPSQoYXdrICckMT09ImZpbGVu
YW1lIntnc3ViKC9bIiw7XS8sICIiLCAkMyk7IHByaW50DQo+ICQzfScgXA0KPiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAiJHtXT1JLRElSfS8kc3d1X2ZpbGVfYmFzZS8ke1NXVV9ERVNDUklQVElP
Tl9GSUxFfSIpDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICIke1dPUktESVJ9LyRzd3VfZmls
ZV9iYXNlLyR7U1dVX0RFU0NSSVBUSU9OX0ZJTEV9IiB8DQo+IHNvcnQgfCB1bmlxKQ0KDQpCeSB0
aGF0LCB3ZSBhbHNvIGNoYW5nZSB0aGUgb3JkZXIgb2YgdGhlIGZpbGVzIGluIHRoZSBzd3UuIEFy
ZSB3ZSBzdXJlDQp0aGF0IHRoZXJlIGFyZSBubyB1bndhbnRlZCBzaWRlIGVmZmVjdHM/DQoNCkZl
bGl4DQoNCj4gwqDCoMKgwqDCoMKgwqDCoCBleHBvcnQgc3d1X2ZpbGVzDQo+IMKgwqDCoMKgwqDC
oMKgwqAgZm9yIGZpbGUgaW4gJHN3dV9maWxlczsgZG8NCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGlmIFsgLWUgIiR7V09SS0RJUn0vJGZpbGUiIF07IHRoZW4NCg0KLS0gDQpTaWVtZW5zIEFH
LCBUZWNobm9sb2d5DQpMaW51eCBFeHBlcnQgQ2VudGVyDQoNCg0K

