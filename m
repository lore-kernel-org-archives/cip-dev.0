Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B945C4345F
	for <webhook@archiver.kernel.org>; Wed, 24 Apr 2024 11:38:16 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.82])
 by mx.groups.io with SMTP id smtpd.web10.12122.1713949620166585545
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Apr 2024 02:07:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=d5gS6Vys;
 spf=pass (domain: siemens.com, ip: 40.107.21.82, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdIQq0uykDT1b3pu+ckTYKhy4oNJ99mj6V7iIPvM+kaeDbeo0rZ1DYmynxfcwGSL+DYyiR7FQHK5CTG83uKTwQ2fNmc1djMW5WTBhVFhKyZeA173YsbWgjoyLXXccnMkUlgvdxv8JLuiVrVkup1kzI18YIHb2ho879rXheVmaXRQRDYwSYIanIgV1/nf049alFfOtwXmSgO+lnJdfMEGOTo81JTLBWfUmwYoIiY9R0Z16OM2NIsFBbdBYE619FZb+aM83T5KAKrZOQ+iy5OKPJYWHUYzI7kTOqqRoPp/vjKSvMmmArOJx+pGwZh3JpG1+v3ct5HiPDKyI3Pt3SuS0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tg8Ej6ALz/b8hgnlIQSOuotSdbdcYTIDhP+7qvzajfQ=;
 b=bbK4zx8ZNsgJqfrGXxxGA3smFS4ZsWvGFXN5kzacw5d93Cp+l4Wh38q6L8ly3nXg3kZJUPHrsRfcHIQoAiKFsa8ypz0nhn6IrehsovV59G4f9dIeZ1zVhlc/TiWocIMPDoutiH6BzSf40CyOvM0Rasc/3vtYAZL1x4Cct3Z+fdz9lsTlGKNz8E8bQKx5GlbIRIhQIZIJhv5qjWMRxkHlEF8DVkxbFlvE8AVJxdt4ejtOQ2byTglwomnW/Zytk7JHUvqRTBUrf4g7NkFAjPL4bRcB/pvswo0jBh+CbGMmfqEhIU5j2f2Viu+HkkeAgfMuPug14pNHHNe/n0qfr6zG/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tg8Ej6ALz/b8hgnlIQSOuotSdbdcYTIDhP+7qvzajfQ=;
 b=d5gS6VysOAZ/a2jPdnTSqSdDdFtP9o34XPEg/FO+KBehUuWmZP+m3bJflqtDh26rdkVw/sL9+/It/PGWRJ0i5658E4V1X29iA9zjlVWHi+4y41LuZnYd3joeZoIGfznj8gkcSrtvApT9F7KwsgbIMgOnBA6gxV/owADIh4lV+MEAdhlozwPgv47Cz9JZSB7mbbyN+Hh55i9IDFD9n09Wf6TWlMY4JQymbZDI0wiElCmixZSTY0IF4ve+/tu0z95gWDB1onqvgornfvsEOnwg6pJU9YT5wIiGKsxmAMVRMTnkWEHjNNLYUmdzf2+C9Bkj+Fu4m5NtqW2lxOWsHIpKTQ==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by VI1PR10MB3726.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 09:06:56 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%4]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 09:06:55 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "johnxw@amazon.com" <johnxw@amazon.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 4/7] fix: use luks2 to identify encrypted partition
Thread-Topic: [cip-dev][isar-cip-core][PATCH v2 4/7] fix: use luks2 to
 identify encrypted partition
Thread-Index: AQHalWGf3mtVU5Lzz0SMvFl7Y1ut7bF1n2cAgAFww4CAAAZDAIAADFAA
Date: Wed, 24 Apr 2024 09:06:55 +0000
Message-ID: <e5722a06576178117cb2d855475548bc8d5bf25c.camel@siemens.com>
References: <20240422141120.577573-1-Quirin.Gylstorff@siemens.com>
	 <20240422141120.577573-5-Quirin.Gylstorff@siemens.com>
	 <9154239823f08a82d34c8810a51290e8e557fb40.camel@siemens.com>
	 <69e0e19e-4600-4df6-b1f6-e159c71440d0@siemens.com>
	 <ab7a2cfe1fe1cfed3111c95e06e06b8bec217ea6.camel@siemens.com>
	 <48f21a43-2c6f-443b-a7a1-acb36eb16762@siemens.com>
In-Reply-To: <48f21a43-2c6f-443b-a7a1-acb36eb16762@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|VI1PR10MB3726:EE_
x-ms-office365-filtering-correlation-id: d638601e-fd42-4208-87fb-08dc643de3be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?utf-8?B?WmhKbm5ReXBXOEpFZDFYdHFwUUc4RXlKbzROdjk0ZStTZlNtTWVJSitGVWxj?=
 =?utf-8?B?R2d5N0NVdzQ1bFhHNDgvWDM4U2NJaGRaSjdTZU9NVUtObTZDd0hPU1FCZXlQ?=
 =?utf-8?B?QXU2eGk2UFpNNHExcEJjVXBoY2QrcUZjams4VmhCaTFob1ZiZmZoMEk0bVpV?=
 =?utf-8?B?NW10NXFyUTBYRE1DcThMQ1N4cGJVbWw2Tk41WDZueEo4dXZWZ2pPVzd1aFhF?=
 =?utf-8?B?WG5hbnVBbzBCU3V6bWZMdTBHbTF2R0RONXpYdm1wVzV1Zk5TU2JGYmRXaVpa?=
 =?utf-8?B?UVJqb1NRVFh2ZEZLdktXTVhXaUJ3dUFERk9DNlY4VVI5NkJYRzlWUGIwSEk2?=
 =?utf-8?B?OG9ualBVRlUvU3VpUW9qaGhZdzNRaGFjYTI4TVQ5VUZrbFliVFJVcHVUT2FT?=
 =?utf-8?B?SzZnQSt5d3ZFcnpJVTJPMVhxSW1zaE1pVFJ5cG9wbTNoZTFsd01YV0JrV2k5?=
 =?utf-8?B?bGJtTUlLRVh1di8rMXgweVRwNEh2U0FNUUhPSEp4SVlSVXlLbWpEZDNockJQ?=
 =?utf-8?B?aFJYNmdXVmNxSEdwWW1McnVhWi9SOEh1bGRIUm9IblR5d3YxdXpUSkJJTlFs?=
 =?utf-8?B?TFU1TWM0VzBGUnBOb0lZLzljMVBRSWFhZkZrSFZvcTBrT2c1YkZtUENSTER5?=
 =?utf-8?B?REdwWlpFSE1GcWgvdytEY3VRZzRUd3NxU2xzdlUxaGxiV2ZQSHdlMGVaUW1Z?=
 =?utf-8?B?S0preXlFeFRJa1JWZGRzdlRBZlFVSjVuMkpPY1NoQkRZQkJlNTNJQzkrR0FP?=
 =?utf-8?B?NE9QV3I4NUZGUzNSTUZsWHJxTWQyWFYrd3N1Nm9SRTc2US9vd1JZcjlYRExl?=
 =?utf-8?B?K0JTbG1icGVtTytMK0crREVCQkEvcE5kRzdDd0ttRU9Ia20xWWUralp6U0pI?=
 =?utf-8?B?bm9nbWp1bXYzVTdvUmh2Z2dvZGlXT0Rra2xlOHNGbGw4OERqRVhPYU5lYzh4?=
 =?utf-8?B?YzhRR3N2ZTQwRmtGeVBGaUdrUFhIeDA4T1o0OHhTbWdtVjYvNWN5Z1dpNDR6?=
 =?utf-8?B?WHZBRjdDdVYzU0JML1hMZVErVkE0THV6RkIva2dLMVRlWUVKQlFaMmsybXVH?=
 =?utf-8?B?VldEVUUzOU5rRXEyVitVRHc1VE9qMlBUSCtmNXk5N2FmUW43MGZpbXNFa3Az?=
 =?utf-8?B?RnFwa0dtVHc5MGRCWHY1WkVzQlM3ekZIVUR2TlRoZW1GSEp0MEFmbW04ZzN1?=
 =?utf-8?B?SXJjbFVoL09pUTNHcWZtd1ZMaXFWZnFlOGN4VnRwZm1EQ0VPU1FvT25lQnVU?=
 =?utf-8?B?Qm9kN3ZqUWRwd0UvK3dSSDlkQWdRMjcvaWJkMEdtQVFEbUh2TTdQb2YxRTI5?=
 =?utf-8?B?UnA5c3YrN0NKZGRGdUljZkdYSk9EaG1YNE9FNmdLK211QzRpVHJLZVFBWFdZ?=
 =?utf-8?B?d0U2ZkY1UnJGQmN0K2NOa1NKK0g2SUFWNlJwNVZZWFA0TmtZVmxHTmc1bWFn?=
 =?utf-8?B?TUlJd1o2KzhLODNkV0VscVlHRVpTVE5GT1pBbEVZdzZnc09lRXNoZDBWMGk2?=
 =?utf-8?B?eHVhT1hKUjZoMmxWNWRoTVVBd1pQQ0lTUHVJc0NKZUtXdlRmSGZIWUlnS2pO?=
 =?utf-8?B?cDVFQkozT2g5YXhINnB1Q3lYenBSRzh4elM2YlVFRHRDSk9mWjYyNjFFcVkz?=
 =?utf-8?B?WnVYcEpGZ2QzSHc3Y1pJMjd6Vm1nQjhzaHJ5eU9MUFVpam9BSzJuZU90dUFs?=
 =?utf-8?B?WlIyd1g2NXFWOW5uQnFHUDBuVWt1K0IzcGdhNmtPa0lxN1Y0OC9LZzBBPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VG4yeGJFNlNQemJIdE1ldG1VZndnbUZlRHZSUGFRQnYrdk9yNXUvU1B0ZlYx?=
 =?utf-8?B?NmxpWGFnTTZKRWoyVXBRMzJiMlpjbEo1N1ZHdVk2WjVlUEZHMzhSaktEMUx1?=
 =?utf-8?B?Y0lEZ2RUazV1VzFvQ0hYeVcyb0dtdG5xWHJxRkthbkRTVkNkU2JrTFNtVnJR?=
 =?utf-8?B?bXlCMkV3S0RRQ1REbXRkRXJKKzZkWlFUNU01T0ZEWEduMHlUQU02cEtOVnFJ?=
 =?utf-8?B?ZytGRktacUQzWlUzeFRtYTNSUkFhT25oc0xLK2UveE13ZWcvZ3lUc05aUlFn?=
 =?utf-8?B?d0JSdjVnMHVMYUxPY3pmSVh3WXhFbW5ObFhKYVBXdTBidVpTZmYxNldQUzZi?=
 =?utf-8?B?cVIxZHVtMEtSZjFvSEp0MWFOTzJqTTZTeVEvZkRQTE9Ia3ZnRTAyTDUwRElp?=
 =?utf-8?B?VGxzMnNnRFFTcWFrTU91MzMwazM1OUwyaGN0d0NPN0w0MHBSQ1FaSWJ6S0xS?=
 =?utf-8?B?MFJWa2g3K2pQWm5EWEIyc1BON0N1ek40amtQU0p2b2RXUXBuZmc3a01kVk12?=
 =?utf-8?B?S2taS1ZseTc4TTQraXhlTnkxS1FGYXFxMWFuby9VeWRZeEdBdFM5SEl5LzBL?=
 =?utf-8?B?cFdNNUhCenVkTmo2M3Z0QzRsMzFKdHc5NkloTDd2Z21RaTdVTHFvUU1qS05i?=
 =?utf-8?B?UDBTa1RPOHFCVUY2VXJ6dWJUWXpTSGUxdTlwUE4yUDBCVDdSejNHVktjekpP?=
 =?utf-8?B?NjZQS1ZXd1B0TkhrZEJETUxUUXBORmZ4VnZ0RVc1enFWUHB4aG1uZDhxWXdC?=
 =?utf-8?B?ajIyazlGUE4zNDFqcEZGWENGRXBtL3FHeGNUY29ZY1NXQytVa3BEb25wV1I4?=
 =?utf-8?B?YW1PdEZYTVp3RG9IN01kaEg0NVh6Ulp6L0c5S3B2eEc5NFh4Mmw1UDRxVG5I?=
 =?utf-8?B?Z0ZySHZpN1R3UGMySE1leDExelE1dmt5SEsvaG1GbGJqQlMzRTNBRmE0VUhB?=
 =?utf-8?B?WkIrMjlxMkpnUHJmWjZzckJTRFZ6S01XQTl6cmxGVGJscm5mOWJGZUgxM2dG?=
 =?utf-8?B?QmxmcjJnRHN4YzZKUTk2R1BkSWNDWC93YUJlVnc3MXVrUklnK0JuUkVpY1Bt?=
 =?utf-8?B?aDJZeThVcU9rZ3dYZjVVeERQS2M2Rlh3ekcrTjF1eGozRDh5TjVPdFpiYmlh?=
 =?utf-8?B?SFBDWkk5ZHZrZ2JIV0RwY2tlL1FLUHJyaG1IYTBORmU5QU5DelNXZWpib2tw?=
 =?utf-8?B?MDBBNmRmZTJMYjlwMHJlTU9GbHE3ekJEelNOZnBxU3RGUzZ3MU14Uy84YStK?=
 =?utf-8?B?Qkh3L1A3dWN4NG5ocUhIMjFSazJXdTI1Nm0vUXNFakYwVU9uRy9GSStYSVIy?=
 =?utf-8?B?TXRWMXdtUXdFWHNDN3hqYlpWWFJQRDZaQXdLNXNqL24vYkowMzZvTGVWN09Q?=
 =?utf-8?B?SE9nY1NHV3BUSW1DcFJmWXdISTVTM29VWUUvb0N4cVEzV3lzVXVtYkVIQnE5?=
 =?utf-8?B?Rng0Vk5GcnVjYXNKWVhyU1lPU1VMbTlxWEl1NWN2SVh0REpycVRvOUJyc25F?=
 =?utf-8?B?U2dQNFZXcENWSkFxYWxGVTRQb3dJNjZXZHF3eEU4NE1KQU13N3hoVnV0bzY2?=
 =?utf-8?B?RDQ0cHJWREt3Zm04Q2xzOE9Hd2RuTUM5d0JhWUJOSTZLT1FLRnQ4VXF3cnQ1?=
 =?utf-8?B?dzNZTmZWRVZrQWhYU1pyeHJzSDlhckQ3b0lDdFFLUHBtVGcyMHVKaU8rekNp?=
 =?utf-8?B?Y205aW5ZMnZaRjl0MDNKOVEzSHIzOWJHTC8vNUh4RldyMlJGS3g4eHg5ZVZh?=
 =?utf-8?B?VUcwaEJKMGZiVkhMOXpiZGJMY0prb3EzZFRMUzhCc2JIOTlDc3R3dXRoR253?=
 =?utf-8?B?a1QwNThDS0NhbnVOU1ZnRDNmdXNsaHR6cmtFYUc4bjZKMFV3ZzEvN1kwNlJD?=
 =?utf-8?B?VDZwUkVPYy9zOTNSU1FicTFibURMOVVOekdoRHpXeEhTajdyOE1qSzIvZ00w?=
 =?utf-8?B?WC9TazV3dGxtaFVQT3lQTTBYa1dFRzMxTnlUbFRublBVTmxyMlhtZkIyUVY2?=
 =?utf-8?B?V0JEbTlhS0U3QWlFUHZoSU9JL1hma09UUk1TVTcvUitJV21uNTdDWGlkSytY?=
 =?utf-8?B?U2RGcS9kdjRSVWx4eHpyWG1RbXlSaUNoaW9NbTVSajZsM1ZoL2NFdi9XclpT?=
 =?utf-8?B?WmNlRXZrRHlrUlYzMTl1a0wvdUNVODNWR0xZTTBMWnNPMmhobzE0RFpYOVE4?=
 =?utf-8?B?WDJ2b0hlSG8rOU9XRktFdXpiL3FUVXFHNXg0VEtKNTVwMGtyclNvdU5IRHFp?=
 =?utf-8?Q?35C44hv0fyRDLUvKs+iy3F7HKFeJzUzZvo9+my3ij8=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d638601e-fd42-4208-87fb-08dc643de3be
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 09:06:55.6317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IhYnftSzu0yBI83eQ8HtzgJB4IYEjDUw8+ymwNTLqg/vufDi7zhBcOnAraS5pei1qEXjru4lqbLV2LR+xdUY+koCDkeGWUnMvHYZ7A3ZO9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3726
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <3127390EDB82114C97A00E6B83177B93@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Apr 2024 11:38:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15743

T24gV2VkLCAyMDI0LTA0LTI0IGF0IDEwOjIyICswMjAwLCBHeWxzdG9yZmYgUXVpcmluIHdyb3Rl
Og0KPiANCj4gDQo+IE9uIDQvMjQvMjQgMTA6MDAgQU0sIE1vZXNzYmF1ZXIsIEZlbGl4IChUIENF
RCBPRVMtREUpIHdyb3RlOg0KPiA+IE9uIFR1ZSwgMjAyNC0wNC0yMyBhdCAxMjowMCArMDIwMCwg
R3lsc3RvcmZmIFF1aXJpbiB3cm90ZToNCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiBPbiA0LzIzLzI0
IDExOjM1IEFNLCBNb2Vzc2JhdWVyLCBGZWxpeCAoVCBDRUQgT0VTLURFKSB3cm90ZToNCj4gPiA+
ID4gT24gTW9uLCAyMDI0LTA0LTIyIGF0IDE2OjA5ICswMjAwLCBRdWlyaW4gR3lsc3RvcmZmIHdy
b3RlOg0KPiA+ID4gPiA+IEZyb206IFF1aXJpbiBHeWxzdG9yZmYgPHF1aXJpbi5neWxzdG9yZmZA
c2llbWVucy5jb20+DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gVGhpcyBmaXhlcyBhbiBpc3N1ZSB3
aXRoIGVuY3J5cHRlZCByb290ZnMgZHVyaW5nIHN5c3RlbQ0KPiA+ID4gPiA+IHJlYm9vdC4NCj4g
PiA+ID4gPiBXaXRoIHRoZSB0b2tlbiBvcHRpb24gaXQgY2FuIGhhcHBlbiB0aGF0IGR1cmluZyBy
ZWJvb3QgdGhlIG5vDQo+ID4gPiA+ID4gdmFsaWQgTHVrcyBwYXJ0aXRpb24gaXMgZm91bmQgYW5k
IHRoZSBib290IHVwIGZhaWxzIGluIHRoZQ0KPiA+ID4gPiA+IGluaXRyZC4NCj4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBRdWlyaW4gR3lsc3RvcmZmDQo+ID4gPiA+ID4gPHF1
aXJpbi5neWxzdG9yZmZAc2llbWVucy5jb20+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gwqDC
oMKgLi4uL2luaXRyYW1mcy1jcnlwdC1ob29rL2ZpbGVzL2VuY3J5cHRfcGFydGl0aW9uLnNjcmlw
dA0KPiA+ID4gPiA+ID4gMg0KPiA+ID4gPiA+ICstDQo+ID4gPiA+ID4gwqDCoMKgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gZGlmZiAtLWdpdCBhL3JlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1jcnlwdC0NCj4gPiA+
ID4gPiBob29rL2ZpbGVzL2VuY3J5cHRfcGFydGl0aW9uLnNjcmlwdCBiL3JlY2lwZXMtDQo+ID4g
PiA+ID4gaW5pdHJhbWZzL2luaXRyYW1mcy0NCj4gPiA+ID4gPiBjcnlwdC1ob29rL2ZpbGVzL2Vu
Y3J5cHRfcGFydGl0aW9uLnNjcmlwdA0KPiA+ID4gPiA+IGluZGV4IDUxYzgxZjMuLjY4NWQ4ODIg
MTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEvcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLWNyeXB0
LQ0KPiA+ID4gPiA+IGhvb2svZmlsZXMvZW5jcnlwdF9wYXJ0aXRpb24uc2NyaXB0DQo+ID4gPiA+
ID4gKysrIGIvcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLWNyeXB0LQ0KPiA+ID4gPiA+IGhv
b2svZmlsZXMvZW5jcnlwdF9wYXJ0aXRpb24uc2NyaXB0DQo+ID4gPiA+ID4gQEAgLTEzNCw3ICsx
MzQsNyBAQCBmb3IgcGFydGl0aW9uX3NldCBpbiAkcGFydGl0aW9uX3NldHM7IGRvDQo+ID4gPiA+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqBmaQ0KPiA+ID4gPiA+IMKgwqAgDQo+ID4gPiA+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqBpZiAvdXNyL3NiaW4vY3J5cHRzZXR1cCBsdWtzRHVtcCAtLWJhdGNo
LW1vZGUNCj4gPiA+ID4gPiAiJHBhcnRpdGlvbiIgXA0KPiA+ID4gPiA+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfCBncmVwIC1xICJ0b2tlbiI7IHRoZW4N
Cj4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHwgZ3JlcCAtcSAibHVrczIiOyB0aGVuDQo+ID4gPiA+IA0KPiA+ID4gPiBIb3cgZG8gd2UgaWRl
bnRpZnkgIm91ciIgcGFydGl0aW9ucyBpbiB0aGUgZmlyc3QgcGxhY2U/IElmIEkNCj4gPiA+ID4g
cmVhZA0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gY29kZSBjb3JyZWN0bHksIHdlIHN0aWxsIGlkZW50
aWZ5IGJ5IGxhYmVsLCB3aGljaCBpcyBxdWl0ZQ0KPiA+ID4gPiByaXNreS4NCj4gPiA+ID4gT3Ro
ZXJ3aXNlIHdlIG1pZ2h0IHJlLWVuY3J5cHQgcGFydGl0aW9ucyB3aGljaCBhcmUgbm90IGV2ZW4N
Cj4gPiA+ID4gdW5kZXINCj4gPiA+ID4gb3VyDQo+ID4gPiA+IGNvbnRyb2wuDQo+ID4gPiBXZSBj
YW5ub3QgaWRlbnRpZnkgb3VyIHBhcnRpdGlvbnMtIHdlIGNhbiB1c2UgbGFiZWwgb3IgdXVpZCB3
aGljaA0KPiA+ID4gbGVhZHMNCj4gPiA+IHRvIHNhbWUgaXNzdWUgaW4gdGhlIGxvbmcgdGVybS4N
Cj4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gV2UgbXVzdCBlaXRoZXIgaWRlbnRpZnkgYnkgVVVJ
RCwNCj4gPiA+IFVVSUQgY2FuIGhhdmUgdGhlIHNhbWUgaXNzdWUgYXMgbGFiZWxzIGlmIG5vdCB1
c2VkIGNvcnJlY3RseS4NCj4gPiANCj4gPiBIaSwgdGhlIGRpZmZlcmVuY2UgaXMgdGhhdCBVVUlE
cyBhcmUgKHNoYWxsIGJlKSBnbG9iYWxseSB1bmlxdWUgLQ0KPiA+IGJ5DQo+ID4gZGVmaW5pdGlv
biAtIHdoaWxlIGxhYmVscyBvbmx5IG5lZWQgdG8gYmUgdW5pcXVlIHBlciBkZXZpY2UuDQo+IA0K
PiBBbmQgYmVjYXVzZSBvZiB0aGF0IGdsb2JhbCB1bmlxdWVzIFVVSURzIGFyZSBub3QgZmVhc2li
bGUgZm9yIGFuIA0KPiBhdXRvbWF0ZWQgd2F5IHRvIGVuY3J5cHQgcGFydGl0aW9ucyB3aXRoIHRo
ZSBUUE0uDQoNCk9rLCBnb3QgaXQuIEJ1dCB0aGVuIHdlIHN0aWxsIG5lZWQgdG8gbGltaXQgdGhl
IHNlYXJjaCB0byB0aGUgYm9vdA0KZGV2aWNlLg0KDQo+IFdlIG5lZWQgdG8gZGVmaW5lwqAgYW5k
IA0KPiBpZGVudGlmeSB0aGUgcGFydGl0aW9ucyB3aGljaCBzaG91bGQgYmUgZW5jcnlwdGVkIC0g
aW5kZXBlbmRlbnQgb2YNCj4gdGhlIA0KPiBib290bG9hZGVyIGJlY2F1c2UgdGhlIEVGSSB2YXJp
YWJsZXMgb25seSBzaG93IGJvb3QgcGFydGl0aW9ucyBmb3IgDQo+IGV4YW1wbGUgZGF0YSBwYXJ0
aXRpb24gYXJlIG5vdCBwYXJ0IG9mIHRoZSBzY2hlbWEuDQoNClRoaXMgaXMgYSBzb2x2ZWQgcHJv
YmxlbS4gSSB3cm90ZSBhIHNpbWlsYXIgaW1wbGVtZW50YXRpb24gdG8gZGV0ZWN0DQp0aGUgImNv
cnJlY3QiIEVCRyBwYXJ0aXRpb25zIGJhc2VkIG9uIHRoZSBib290IHBhcnRpdGlvbiB3ZSBnZXQg
dmlhIHRoZQ0KQk9PVF9MT0FERVJfSU5URVJGQUNFIFsxXS4NCg0KWzFdDQpodHRwczovL2dpdGh1
Yi5jb20vc2llbWVucy9lZmlib290Z3VhcmQvY29tbWl0L2ZmYmQzNWY3NmI3YWU1ODcyMTFmOTk5
YThjYmY0NTE0YjBhYzRlZDINCg0KPiANCj4gQW5kIHVzaW5nIC9kZXYvc2RhWG0sIC9kZXYvbW1j
MHAxLC4uLiBpcyBhbHNvIHRvIGJyaXR0bGUuDQoNCkFncmVlLiBCdXQganVzdCByZWx5aW5nIG9u
IGxhYmVscyBpcyBhbHNvIHF1aXRlIGVycm9yIHByb25lLiBXZSBzYXcNCnRoYXQgd2hlbiBydW5u
aW5nIGNpcC1jb3JlIHRlc3RzIHZpYSBNVERBIGFuZCBTRCBlbXVsYXRpb24uIFRoYXQncyB3aHkN
CndlIGFkZGVkIHN1cHBvcnQgZm9yIHRoZSBCT09UX0xPQURFUl9JTlRFUkZBQ0UgdG8gRUJHIGlu
IHRoZSBmaXJzdA0KcGxhY2UuDQoNCkZlbGl4DQoNCj4gDQo+IFF1aXJpbg0KPiA+IA0KPiA+IEl0
J3Mgd2VsbCBrbm93biB0aGF0IFVVSURzIGluIHRoZSBlbWJlZGRlZCB3b3JsZCBhcmUgbm90IFRI
QVQNCj4gPiB1bmlxdWUsDQo+ID4gYWxzbyBmb3IgcmVwcm9kdWNpYmlsaXR5IHJlYXNvbnMuIFRo
aXMgaXMgc3RpbGwgYW4gaW1wbGVtZW50YXRpb24NCj4gPiBpc3N1ZSwgd2hpbGUgbGFiZWwgY29s
bGlzaW9ucyBpcyBhIGRlc2lnbiBpc3N1ZSwgdGhvdWdoLg0KPiA+IA0KPiA+IEZlbGl4DQo+ID4g
DQo+ID4gPiDCoMKgIG9yIGF0IGxlYXN0IGxpbWl0IHRoZSBzZWFyY2ggdG8gdGhlDQo+ID4gPiA+
IGRldmljZSB0aGF0IHdlIGJvb3RldCBmcm9tICh0aGlzIGlzIGtub3duIHZpYSB0aGUgc3lzdGVt
ZA0KPiA+ID4gPiBCT09UX0xPQURFUl9JTlRFUkZBQ0Ugb24gcmVjZW50IGVub3VnaCBlYmcgdmVy
c2lvbnMpLg0KPiA+ID4gPiBUaGUgZW5jcnlwdGlvbiBzaG91bGQgYmUgaW5kZXBlbmRlbnQgb2Yg
ZWJnLg0KPiA+ID4gDQo+ID4gPiANCj4gPiA+ID4gRmVsaXgNCj4gPiA+ID4gDQo+ID4gPiA+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgb3Blbl90cG0yX3BhcnRpdGlvbiAi
JHBhcnRfZGV2aWNlIg0KPiA+ID4gPiA+ICIkY3J5cHRfbW91bnRfbmFtZSIgIiR0cG1fZGV2aWNl
Ig0KPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbnRpbnVl
DQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqBmaQ0KPiA+ID4gPiANCj4gPiANCg0KLS0g
DQpTaWVtZW5zIEFHLCBUZWNobm9sb2d5DQpMaW51eCBFeHBlcnQgQ2VudGVyDQoNCg0K

