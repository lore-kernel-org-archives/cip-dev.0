Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF01C83F26
	for <webhook@archiver.kernel.org>; Thu, 24 Jul 2025 17:53:58 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.50])
 by mx.groups.io with SMTP id smtpd.web11.237.1753379635828293556
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Jul 2025 10:53:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=W80JgZ2w;
 spf=pass (domain: siemens.com, ip: 52.101.65.50, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJl5KapGAcJUT9wc23HCXyJOg6FxwpHj5pld+BzQLtZ04HaNXDCXkL7xWoJmRG3TWdvJQ0suKO4K+zAstRxXVLY7uV3RgFIUXxZmA9Pr34udpXPDTHLQeffixCskVBtFdIZ/0HZxxJNiTLcJKhwVsltX/q+Cg8TDSYyerJjP0lQKRy07SAmBWEOwgcRjDxpIn9HjMHf81WIpuiMB51Bjn2wRhF8JyXk6IadZveJp4lNmfeAaSN9u1kmywnAQjheg7ShO754qNrr5i1U+st/i/VqDvJMDKLDmc1FO+yb2ayBgEZjENs0iEQXJLsOYBb3kVmZor77NG82gAdaVfQsyrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rU/jUf65dX14NhZRKmhlJgNLPDS3ZOWE9p62TETGrNE=;
 b=YpKwqOz5nm+WusSWuo0rJWO7H+pD7gkYnmm4dl2Z5q42G2MHP+5C0XAIK8WRXDTz3ku9eDQLiUq3FuTDXChMzH6hAK+D13XbtQL0mS1EOTxcVA677aMW1YoSdv5p/tcEtp1fy9NNMcQcpJwAbzTgTsBa61xnmv/QAzDWVoGNoEsYMaxYlo4SSVZmGm4MfC3Q1o5spF51H9EuLLp6xpne9FB67JNRDfPKq2QvF5xyA9fx5y+cC8H7LppN6NndVrIpn4zVJkGtgo2TFdIMsgGZA/SrEnWIM0M8153LSy/R0NstTcfO4Qv/3qppJgMdFDkFW4SdRV9LUD41TFSyaojJbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rU/jUf65dX14NhZRKmhlJgNLPDS3ZOWE9p62TETGrNE=;
 b=W80JgZ2wQk96KyNHs+AMakONlhmhPLH/NCM0ky15aZOuZj3G1L4y9AltQAVTtp3WtP9LhX5oY+3oiw0Xu1KiPsYFGrgkFgnvMLh+S2O173+BinbmeGdkssWYF3eNr9UhIf1jmdQP5VQUmyk3fMXsQLZqFJ/+hqeS3s2APHCrdvKVS1nxWQDy2ziAkG2SefmqmGLla7kxoelSt4qw2CWG4A8G6dJ/mQyG9FGGy9NwXoQCvJv12mTUUtOc9bfB8x4FdmCiIdB4C81TT9gfc7xKYXjYu1Sc6/ctpu4IJz1n0O5IBxZpnxOe1rJpIl5AE8E1Fmkrn/uFtUah+Q5WB+RpAg==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AMBPR10MB9338.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 17:53:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 17:53:52 +0000
From: "Kiszka, Jan" <jan.kiszka@siemens.com>
To: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"cedric.hombourger@siemens.com" <cedric.hombourger@siemens.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: Debian: kernel 6.12 breaks cgroup awareness of openjdk 21
Thread-Topic: Debian: kernel 6.12 breaks cgroup awareness of openjdk 21
Thread-Index: AQHb/J2Ab3cwHKWQ8EqReeoTvWH1N7RBjpp0
Date: Thu, 24 Jul 2025 17:53:52 +0000
Message-ID: <806C5BA3-1862-4C96-A026-CDD1735F9E32@siemens.com>
References: <dc63acc86c4e9a343a783682225ff849095bd547.camel@siemens.com>
In-Reply-To: <dc63acc86c4e9a343a783682225ff849095bd547.camel@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR10MB6181:EE_|AMBPR10MB9338:EE_
x-ms-office365-filtering-correlation-id: 8479a982-97a9-4acc-c488-08ddcadb0d3b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?R2IwSDRlb2pxeGZhbnlhNDUxbExvZFNYMTJXUERCc0NMTVZsNHI4ZVhhYXVG?=
 =?utf-8?B?Qkdod2d3ejBjZWlLQmFXL0RRb2NSTVVDakJ0cWpBWTZCaEh1MW5xZEtNaVkx?=
 =?utf-8?B?ZzZiV2s4bE1SREdCK3VIREVIOCtiWWl3MmxzdG9wQSt0ajk3RFlUQlloVUQ3?=
 =?utf-8?B?ZWRGK1YyNmJhQWFUZE5PTGNLYWJVZFNrekcxNElLd3JTOVd3a2o2Y3FpbER2?=
 =?utf-8?B?UVIrUUUxaUVMQlFOZEZtZ0tET3NLbEJQdEwvYkI2R3h4NmVLMXc0bmhzUWZh?=
 =?utf-8?B?V3RsbkxqTjJNNExYUFRzNldjVW5ITitST2E3Z05IR005RkZJZ2xhQXpEbXY0?=
 =?utf-8?B?OUNHL0VFYy9qWXh2Z0JyU1hBVkZLanpSd3VHZmNWYkN2aTEwWWd4Uk9JMlJ0?=
 =?utf-8?B?OTBlN0hQUnRlWnc4dEp1WXo1ZFJrTWJqenF4OE4yM3BFajhDNExpR2VUSGVn?=
 =?utf-8?B?emg5YVR3ZDh5ZFZIb05QKzBLUUNsYWlkZytCdTY5QU9VdFN6Y0MzcUhzd0x3?=
 =?utf-8?B?SVJucjNoeXhhSGZrK0Rac3IxQ1kyejA3R3BKaFQrd21EK3pnU0hUM01Pb0d3?=
 =?utf-8?B?SnM5R3NHb1dyT01ESytkaHVIT1dLUkZHMkc0V2tDbElPOW1MY2JhYWNWQnJS?=
 =?utf-8?B?d1FyV0h3MUhGM0w5MU9PdzdUdkpuT2JkS0g3VnFRcjlBUlgzVGdaZ0F4VWNo?=
 =?utf-8?B?Q3RtdU5WYnlLamU0Y3RXWU01U3ZodkZXZDdnNFdhMHFUaCtQQTZZNk5ZVVVo?=
 =?utf-8?B?ZVBNRmhWd2Uxaks2UHRPNXdZMjZGeWQ0QjBISGUyTjNmWXJHY21lcENFS3hI?=
 =?utf-8?B?VlRkNVFqWGRuUDJZNnZaQVc2VG1KUGg5QWJsdndVTDRqQms2ZSswR1RySEIv?=
 =?utf-8?B?Ukc2ajd6dDk1bGFoaEhsWFVmaUdwQVVSWnRjUUVTSGpSM0FDSGlMcHhoQzRD?=
 =?utf-8?B?dWF3RWVjZmViTElmNXd6T2tOOHVkVUJtZ2oxN2QwN0JZaWJ2VEo0K1NnOHVh?=
 =?utf-8?B?TnNLVUFuMkFidDBzaGZTbzFqc0ZHYTl2aEpEVEhxTnFVc1pVKy9maHlWNytu?=
 =?utf-8?B?V1NUWlBFVnZGRmJDSVdlTEtyU0d2d3I3S1hxZnJ5cU1jdXJvL3BHZmxDa3Ew?=
 =?utf-8?B?QklPOTFXd0NCSzJlMzdpL2hoWERwK3QxNjRsQ2htYjhqZ2d3ZkhUdFZ3Yk9Y?=
 =?utf-8?B?UkhSemZGdWhQb2Y5UCtHdWNqd1RUYkVuM0JzQWtzRU1tVmZvMzdJakprTFNE?=
 =?utf-8?B?MXJ2NFA1Vnh3RERtb2ZIRnpXM1FpcWQxcHNSRFIxZzBIc0Q5RDFGMTJKb0dS?=
 =?utf-8?B?eHNrT3pEOFcrVFZZYVVmeWl0RUpmb2c1YmdaNEVIUXh5U3ZmYjFUNGhWSDcz?=
 =?utf-8?B?T25CcGxtc3ZRczBSb2EyeUhlejRBSFFMOU5ubjNkamY2MTZYNGZUMlMvNG53?=
 =?utf-8?B?QlJ4NHptc09YQlNqaXBEOXJrWXJqRU52cFBRakluQUl6a1RnUUJCV1lQc0F0?=
 =?utf-8?B?WVJaaFl3Uis4MmxvTFVoQVdmRVJlQjhGbFNpbWU1VHRBNWZXREhOTHUxWEVU?=
 =?utf-8?B?THI2NDZESkgrUUJKSHRkZTltMjBxQnVVSEY4K0xqdmVQemNXK1VWd1BETFZv?=
 =?utf-8?B?a3RsaGJhR1UzNEF6TzRMZktXQ2J4cHZBYWxCdVBGUVZwYW1zRGRlTFZieko3?=
 =?utf-8?B?blRzWFg0UzBzcHdIKy9iNFNZalZMK0pMcFhQb2xhWkxTdzJ6cENHLzdydHRT?=
 =?utf-8?B?UVYrZDlNdUVSTWg2akhDS3dFdUU3WE9CekliRmo0TmgxQi9DK1VlZWdvb3VG?=
 =?utf-8?B?SUhFMlQ0eGwyaU5yK3E5a2FSV3F2U0Fqa3VaTlI3eTF6T1lrUjNGcjJPdkY4?=
 =?utf-8?B?cTFvdUpKUklNK3V4VFB5eEpaYUg3cXhEay9BTXdhaWZrUkVkbzh3bE1xRDdz?=
 =?utf-8?B?bHA4VUIwc3BFZDNvalZpcXd0K3NIemJnRTVoa1k4VE5HZysvNkJhblIxWkxk?=
 =?utf-8?B?d1JKZkc0VkxBPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cmdJWUV3UG85VU5kdGZ2NjR1dFNXZzRzYk1DYklrNnV6TUEycFpTVDhoOHNP?=
 =?utf-8?B?ODhJY2h0TTVaZmN5MHZkQkpJYkxkNmFFWjhqU0dOamp1OXVsT3ZjbWJ3azJ6?=
 =?utf-8?B?SWk1NUw3N0xSMld6UVdmZ1lZdDBGWnVKTHpDYVdDVWh0S3ZPelZIUDFyaFhP?=
 =?utf-8?B?S2YvaG9Dek9JbG1oTUZjMEZxWWE2MjE5Q2c1OFByRmprVStSNzNqM1huTGds?=
 =?utf-8?B?RzdwZE5tZjBjZjJnbE1veUN5OVNsTWMxblVkMkZNWklYaC9wa3E5MVA1cGps?=
 =?utf-8?B?c3I1KzJRTFpaUWZIOWRsb2xtMGEvUEpiL1AwcFp6eTdZd1NtS3gwUzc4dDVk?=
 =?utf-8?B?eUV6MXBmblJxcjl2Z1JVUFYvOU1TbTJ2czF1WmVMZG5oSE1yVk16aGZVNEg0?=
 =?utf-8?B?anVock9KcTFKN3FNT3oxQ3VpWUJKT3NYai82alJUQUpHQ1hsZ3RSRHc1ZkpY?=
 =?utf-8?B?NWdON3Y0MlNvMk9QOUMyYjJJUncyQkVUaWt1SEJTb0V5VVR5RmJFRnVURHhQ?=
 =?utf-8?B?RXFOMFNOSkxSZC9XUUFIOWtPclBPdUFML1owSGgrOXljckxwd096a2MwSG5T?=
 =?utf-8?B?TjhSMm5SZjhyUHdXWXd3UkFCeW9mSE1KWWNlWUxLWkg0blBYTWNHaUwreW1i?=
 =?utf-8?B?YXhmMWcra3hseXRvVjN1RlptdWRKdUlQY21UNTV6eEZUazdIS2RQU3NHaEpD?=
 =?utf-8?B?TThHMFhrUmZuVk9xM0hjdHBDN1JZK1hRSWplQUNNeWlJb3NlOWhVak1GMUNt?=
 =?utf-8?B?RlNuYzBHdGxXanJTSGdXMkJsazF1ejdlT2FpK0xSK0IvdmtkeksyY1ZRbk1x?=
 =?utf-8?B?NWQ2YUF4TnlROTZndmQ4Y09yTEMrVVN6aDJUUmhCNGpYayttWWpHNEg4RGlw?=
 =?utf-8?B?eHVOTnJMYUFTbHBRdS9KVkdKZUo4OUljOW1uU2FvTzdSUWloOWx1b2JEUHF1?=
 =?utf-8?B?ZXVWQjFPTC8ramx6Qm5kL2FlcVlrdVlyaWJJYlB3SWd2eDFoMndPa1lsU2tr?=
 =?utf-8?B?SGY1Q2JRWTdZNzA3dTRRMC83ejExUDVKMlRleTRJWXVYWE40dTFwVXBocDNx?=
 =?utf-8?B?SmN3ZlE0a1U5eGtrN1dOMGg0b3hra1h2RU9UNUdNb2tFcy9uNHZYa1Z0TERS?=
 =?utf-8?B?Zm5MdnpMRThSVndxR3J3RmhydG5CdzdjU0kvb0MvOGRnM1NER2ZJbkN1TlJU?=
 =?utf-8?B?OElxZ1dOQ1dlcnVwMVhPY0VUeHAzRHY2bVZqNXN2azJVYjlXTEZOcWpMT2Zl?=
 =?utf-8?B?bm9Wd25rV2NMaDlnT0owYXBQckJIN1ZaQ2xsUGJBbHhDVFJGKzR1WUVudHRD?=
 =?utf-8?B?M0FWcmc5cUpCZTlsTXZsK2c5QjkrRitHd09vdW5hcUVIaHBQbnhYWjBLSGVu?=
 =?utf-8?B?eTNuZmEweG82TFNaT1RjeUlnR3dkcGlpZGYvYm5TNHFYOWFMK0ZoV1VpRXJz?=
 =?utf-8?B?NFZtWDRUai9LYkVtVWlrazVQTERJTUc5a0dzaDNZL3RRUEdXc09BTXJyb1hl?=
 =?utf-8?B?b2QxenQ5cnZua2FBaXhwYlRYaGsvYnUvTEZzWEI5cHdwazNrSVkvRmRHTGxO?=
 =?utf-8?B?N0I3L1d2cXV4MFZwNnZrYlk5MVNsQnVaaGMyYVRLSGlLeWNrQ01IZmlUR3BK?=
 =?utf-8?B?a0g5dEZCZlVpYjEzWWZDcEF6WHpodzJqWU5qM2hnb0dKQUY1YkFMYjFkeWNR?=
 =?utf-8?B?cFpwbEFEN3VtV3p4dWw5ZE1wVmdkc2x1bVlTdVVQZ2Z2QWdrdWVsM2NTcm9v?=
 =?utf-8?B?dHB6SElKU0xHdGxCcGRVMEZPVHJvSkRGWlEzeEhWa21IbE9zVm5aekdwV0M0?=
 =?utf-8?B?RHVJUEhzTHVqcHNsNDVkTi9nNFh5aEVWbVBZcHBDMkZ3TWhQL1VCYU13WC9z?=
 =?utf-8?B?ektBbzJ2Nm41MHB6RzFaN1N5TVNPSEZBbVN4c1Yzajh1S252UmdtaWVmZjlM?=
 =?utf-8?B?ZkNQSFJrdVB1cU0vS2hRYjZMNXA0cW9ITkRwOS9RdU9XaUFpcEdxV1lDTmwx?=
 =?utf-8?B?cHlrK1lIS1RqTzR4aEFwd21BMVJYZ1RYYzduTEZzbTNad3RMVmFkTVpyQWhZ?=
 =?utf-8?B?Q3REdFp5NXZYTEE5d0N4NFM2dzV3VE1HaDM1QmlkUXpmeU4vclc2Zjd1S1JR?=
 =?utf-8?Q?qCLwWUtbzGR9JWrvw/q/sEJYp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8479a982-97a9-4acc-c488-08ddcadb0d3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2025 17:53:52.4648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zvQ79NnLGoARH6w43oLeKkrBJ9C0R2EqyNPAAOVlEeOJpUjdoCUDchPPGwTWVpqPS14zI5OkIhhbrKLB/YBTKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB9338
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Jul 2025 17:53:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19587

SGkgYWxsLA0KDQpTb3JyeSBmb3IgdG9wIHBvc3RpbmcgLSBtb2JpbGUgdG9vbGluZyBpc3N1ZS4N
Cg0KQXMgdGhlIGtlcm5lbCB0aHJlYWQgc3VnZ2VzdGVkIChhbmQgYWxzbyBCZW4gY29uZmlybWVk
LCBjaGF0dGVkIHdpdGggaGltIHRoZSBvdGhlciB3ZWVrKSwgdXBzdHJlYW0gaXMgd2FpdGluZyBm
b3IgYXQgbGVhc3QgRGViaWFuIHRvIGNvbmZpcm0gdGhhdCB0aGUgcmV2ZXJ0IGlzIG9rIGFuZCBt
YXkgYXBwbHkgaXQgbGF0ZXIgb24gYXMgd2VsbC4gVGhlbiBpdCB3b3VsZCBhcnJpdmUgYXQgdGhl
IENJUCBrZXJuZWwgYWZ0ZXJ3YXJkcy4gSSB3b3VsZCBwcmVmZXIgdG8gbm90IHNoaXAgaW4gaXNh
ci1jaXAtY29yZSBhbnl0aGluZyB0aGF0IGRldmlhdGVzIGZyb20gdGhlIG9mZmljaWFsIENJUCBr
ZXJuZWwgLSBhbmQgSSBzdXNwZWN0IHRoZSBDSVAga2VybmVsIG1haW50YWluZXJzIHdpbGwgbm90
IGVhc2lseSBwaWNrIHVwIHRoZSByZXZlcnQgcGF0Y2ggYWhlYWQgb2Ygc3RhYmxlIGFzIHdlbGwu
DQoNClNvLCB5b3VyIGhpbnQgc2hvdWxkIGp1c3QgYmUgdGFrZW4gYXMsIHdlbGwsIGEgaGludCBm
b3Igbm93LiBEb3duc3RyZWFtIG1heSBkZWNpZGUgb24gaXRzIG93biB3aGV0aGVyIHRvIGFwcGx5
IGl0IGxvY2FsbHkgdW50aWwgdXBzdHJlYW0gZGVjaWRlZC4NCg0KSmFuDQoNCj4gQW0gMjQuMDcu
MjAyNSB1bSAxNToxOCBzY2hyaWViIE1vZXNzYmF1ZXIsIEZlbGl4IChGVCBSUEQgQ0VEIE9FUy1E
RSkgPGZlbGl4Lm1vZXNzYmF1ZXJAc2llbWVucy5jb20+Og0KPiANCj4g77u/SGkgYWxsLA0KPiAN
Cj4gSSB3YW50IHRvIG1ha2UgeW91IGF3YXJlLCB0aGF0IGNvbnRhaW5lcnMgdXNpbmcgb3Blbmpk
azIxIChpbiBmYWN0IDw9DQo+IG9wZW5qZGsyNCkgb3IgZWFybGllciBtaWdodCBPT00gd2hlbiBy
dW5uaW5nIG9uIGtlcm5lbCA2LjEyIGFuZA0KPiByZXN0cmljdGluZyB0aGUgbWVtb3J5Lg0KPiAN
Cj4gVGhpcyB0b3BpYyB3YXMgYnJvdWdodCB1cCBvbiB0aGUgRGViaWFuIGtlcm5lbCBNTCBbMV0u
DQo+IA0KPiBBcyBvZiBub3csIGRpc3RybyBtYWludGFpbmVycyBhcmUgZXhwZWN0ZWQgdG8gc2hp
cCB0aGUgcmV2ZXJ0IFsyXSBvZg0KPiB1cHN0cmVhbSBjb21taXQgYWYwMDBjZTg1MjkzYjhlNjA4
ZjY5NmYwYzZjMjgwYmMzYTc1ODg3ZiwgaWYgbmVlZGVkLg0KPiANCj4gSSBwcm9wb3NlIHRvIGFk
ZCB0aGlzIGNvbW1pdCBhcyBhIGxvY2FsIHBhdGNoIHRvIGlzYXItY2lwLWNvcmUsIGFzIEkNCj4g
ZXhwZWN0IHRoYXQgb3VyIGRvd25zdHJlYW0gdXNlcnMgcnVuIGNvbnRhaW5lcnMgd2l0aCBvcGVu
amRrIHVwIHRvDQo+IChpbmNsdWRpbmcpIHRyaXhpZS4NCj4gDQo+IFsxXSBodHRwczovL2J1Z3Mu
ZGViaWFuLm9yZy9jZ2ktYmluL2J1Z3JlcG9ydC5jZ2k/YnVnPTExMDgyOTQNCj4gWzJdDQo+IGh0
dHBzOi8vc2Fsc2EuZGViaWFuLm9yZy9rZXJuZWwtdGVhbS9saW51eC8tL2Jsb2IvYmVhZGY2MzVm
ZDA2NTJlNWUzZjI4NWU5MzE1ZTg2YjIxZDkwYTg5Yi9kZWJpYW4vcGF0Y2hlcy9kZWJpYW4vcmV2
ZXJ0LWNncm91cC1kby1ub3QtcmVwb3J0LXVuYXZhaWxhYmxlLXYxLWNvbnRyb2xsZS5wYXRjaA0K
PiANCj4gQmVzdCByZWdhcmRzLA0KPiBGZWxpeA0KPiANCj4gLS0NCj4gU2llbWVucyBBRw0KPiBM
aW51eCBFeHBlcnQgQ2VudGVyDQo+IEZyaWVkcmljaC1MdWR3aWctQmF1ZXItU3RyLiAzDQo+IDg1
NzQ4IEdhcmNoaW5nLCBHZXJtYW55DQo+IA0K

