Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF1AC531FC
	for <webhook@archiver.kernel.org>; Mon, 27 Jul 2026 06:13:31 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.35])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.25130.1785132802020058990
 for <cip-dev@lists.cip-project.org>;
 Sun, 26 Jul 2026 23:13:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=oX/lWiwr;
 spf=pass (domain: siemens.com, ip: 52.101.72.35, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKxt2EkD3KMns7ODS421I0ZOqwxgg9IvgMk6r4ywKO73l3pGjRUo03eSVO/CH63dZacmL605GPeWXNTUCEZDnLNLUQXUtGLf6++1O1EbOoMYhFN/VifmAIUiXPrqdY6tYz5fnylUjmPFVvt51AJiz2R4s30ag1zOWaicI0XQfjNvfeN50HUzrYy2tCwq6cvJICxDgwg95Rnd3IcZtV8ruuIyu0j5Fd+Z+kWh0XYOzPqCnclsN51bXRqaDNwwBV1EDUyuZZ49oC9wNQaJwfEuSkOEfyyCKsmsYBck2m9OPAqinM1wLwXGhW8C1kP8752HHiDjDL203Eg/TEJoYmX3iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbCiVKcV/N0no8epEHX0yOjViM+WFsjNo1kkYSioSIE=;
 b=tDtCq7DMvchTG3gv+aWqG492/kdPcnlza127Ja/5pKvoY06KZoEaaKmg3MBzTsaiJFMv6RxS0NEZyllO8WB3e7JSiFpsl/LmMIOe7Hn84DVZLiWrLtsNCZv2qE1BwHoOQsAw6GkxeYgMK4JA1JpInRqao19bYBkEsxuPgSEwbyN3edSxeSBIM9I7+JHm+UUcEk5h2uzJH87vXskCbbJ0DnxgyFTbMaWkeyRrbKTtK4LA2al3BGPUpFlK3Iu/iAOHd1yrIhuLDrFeNwvDWqh3M1ErpEWOI4magFA8Ai9hD1g8w+UUj6ypbcx6l34Ls5/maCavosPfDPMcRcN2l1dwow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbCiVKcV/N0no8epEHX0yOjViM+WFsjNo1kkYSioSIE=;
 b=oX/lWiwr0BrzyLSnObR9eS+ARQpl1/4rC0wjXLBQRnMz/amHWCNW9RfNqX8qBWvOzR2EJ3IzlcCmH5NxoRz25WBfLkHSRiLxpSwgkuAb2DrnWR9tqeWZcA0ePP0cGZvWcjFUSsmSQ0ch/K/rhzXwCyBfKlP6gYXzDUQ8FBTDzNSAKhh0IjYX7ct+Z/vbUct+cNRADfgG89PjIHmV0boaBNORJuyj/tQTOkBWxvE79AGLQ17bR/DJDNMp0+MakpUYP2mLKVwMImCJPgacqjVs+HAFS+gPsfJnw6nw6McyiN8TeBPemaYz2mEXkAjB5KcTY9KoJmwVcHHYXdfAuCM50Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB9124.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:453::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 06:13:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 06:13:17 +0000
Message-ID: <d307dc69-ab0b-42e1-9e48-f78cae03bdfd@siemens.com>
Date: Mon, 27 Jul 2026 08:13:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC cip-dev][isar-cip-core][PATCH 0/4] switch to rootless build
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com
References: <20260724105116.3575045-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260724105116.3575045-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB9124:EE_
X-MS-Office365-Filtering-Correlation-Id: e7398481-0cd9-4a3b-c641-08deeba6262f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|6133799003|18002099003|55112099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	trswqR/mePlTYp5iitch5hv9xohMSn0J9HipK76yhW9Y5EOCoHwna+CjhrA1fuBTp9E5zS5LlAkp3qx6yF1N1KyD6Bl1N+rAHQ8Z87WIkqaDszqt5f9OfEu/g4LiaU3mWQFysLIqz0YzwMyqbdeKeDc2Gbf5gIgV8KRZnR23LTTX6g9WYSiujMk1nex522BT0HjSrO3TyVCvzaYTFLI3iR0mgXB4X2IAe/xrA2spQ/YO09KSzm5OrlksjGWtd8zPYlf2KMCifce/uaPbj3i8y+L8lioWifdtyettkx1Em2YWHU90jSeoYoBandYe7axc4i7wntHc9CzlhGcbbWMZ6BwA9MqD44eeV83ihT9gAsrVesxd/V5M8GTxxlfrwTDwojNKrnaTqe6IUj8kWxC75rqUBCv+HqjXwaIKJ8td0ArC97nUqraKpQijzyrgwM7u3MBI2R2OVMvGiWn/0X96Ns3m7aBDBTCx/xSlBIi+eZeSlPV6z4cfw+z1gqRChx7K3A+xlEsWKa0Pwts0/d7Q60aB3SmdVbTo6La3dqJqzSU82jRU/FIyRyGp5boP7JjLuIEs2SkxQqwtEusKjkJC1WVsBgU58NH2aau0KKXKAHDbE5tB+1MfFRgNMnxkyn/zpufOdDYxU31w9tnjB6zUvLijFKJvQRHy1+SHJmbsEx4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(18002099003)(55112099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SjFRYmxOaGZvTWVIdHl6QklSWjN2SDgxcDl6MmcrbFlCU1FlRzc4ZGtldnZK?=
 =?utf-8?B?S2ErdThpdXdOOVNqQWw4K09kMDF0ZHVkOVdvWHV1bk5mcjk3N05QanFIWGNO?=
 =?utf-8?B?akxPRDdZTEFpdFduaUF5ZFFHQ25PYnhNMG0wRDdkTWNnVFZqWGNaQjRjWW1T?=
 =?utf-8?B?RDFkVGtoR21lZ0M0dzl2UW44Y2FyWUhLVVV5VDNGU2plZmNUd0FVRmUwNHUz?=
 =?utf-8?B?ZXd3ZXJoRCthYnB0NDVEaTRaTmJ6b3NYR2NBUEg3L2ZudHNWd3g4UnN0WnZh?=
 =?utf-8?B?b0R0MFJUZlRFRVVxbGZwV0tXMElvaGN1RUlMZkg4UW1MWHFkVXFWOExzMW85?=
 =?utf-8?B?UytZTXBIMkgvVDAxWXhTK1krbUhpK1RMMFU3cmhxd0pYWWtUSWkxV2huZG1N?=
 =?utf-8?B?NUFrQWVjZHZmYlAyMWVqZzZGZXB2NlhJVWRiVS9DcmtISWV1T1YybGxxQlc4?=
 =?utf-8?B?aW9KaFNZY1o0TmVZZEVyMUZka2hjYTFGcEo1a2dzb1dYNXg2dTU0WmNxd3Nj?=
 =?utf-8?B?VjdZUE04enNocUZIMVkrRTkxcXZQSWZhaTN5QVVnYzV4Ynk5ZVNRS0owZjJ3?=
 =?utf-8?B?WFBIeFFRQWhZVDJpR1pZeTdPTG0vcXN2N3BtcFZ4ZXoyL2JzOFkxSDN2L2VN?=
 =?utf-8?B?bkJSd0R2amNxV204SVpDUWRvRHRodlF4WkRDTVJzNUdzOXowM3V2ODh5YTNW?=
 =?utf-8?B?WFpRVVYvM1daNXNRdzNrVk5zYURlYTN4YndKWjBTd0UvaUpTb3F3YllGMXZK?=
 =?utf-8?B?R0R3MHhDWWxHNTh1MDRmMVFoVUVoZWhsZWdjZEcyQS9tbzVIL1I5Z3oxZW1n?=
 =?utf-8?B?bTFPZTI2MlNMSTJwRkpNMFVOU3FyWU4vaTNIWDFiaEYvdzJaL3plbG1KSkxm?=
 =?utf-8?B?R3FMbElrS1d2TzhFUmRhKzhCRjB3TkliTUFRTDkvL0xma3dUTFpuMDZYaUNF?=
 =?utf-8?B?RnNITkJONHBBS1NsOHQ5Q0VIKzZyZ2Z5YnVoTVg1eFo0cWtiMGoyTnRnQUty?=
 =?utf-8?B?RW1BTTZaOFBkV2xvNm9oNFNwNmRqUEY1ZHJDUEliNnVaNkhmUFQ1NXJlY2FT?=
 =?utf-8?B?VnhsUEFiSDM1MEVvaWRDcnR5a2FIRXJhRG1XUU1VbG13VC9reDlEL3o3Z1Uv?=
 =?utf-8?B?S3cvVzIvS0ozcHpra1BNTlljM3dxNGRRM200Z3lPKzkwc3dHYVd2bkRRZmww?=
 =?utf-8?B?MHhXNDRDbzB6NlRsak8vYnFZUmhEODFaMTNobXM3WmFnNGFldVJNajFnaGpW?=
 =?utf-8?B?bjF4OTBzQzN2RkQyQ2FoNnR5MTVCWWIyb01OdUxxZFlvUTBZM2FsMXJzTml2?=
 =?utf-8?B?VXo3QjRQWUlOMk5ObCtFdDBlbXNhODk2S0ZvNVQ5WXg4V2xtbEtJM3BxUTJv?=
 =?utf-8?B?Qm1MTXZscEZSSlpkbTh3S2h5UU1PNmhFUUh1TlNyeXNLaTh4ZUk1SERwMUJP?=
 =?utf-8?B?ZU1MS1dNc0YyTlU3Mi90L3RXUG5qMGhZZWZleWFwNWRaSUtnaGk3OWlsaWdW?=
 =?utf-8?B?cTJPMWY0OHh6SXlsZDJrVzJBMzk4MEQ4dDRoSXF1TmorN01Fd3RkK3dvNmQv?=
 =?utf-8?B?TnVKa2d2RUxRRG81K1h4ZWloNkpvS1hNb3RRRmlyeUlxQlFlTERPRU9tUUhK?=
 =?utf-8?B?WTE3dHRHbGRsaDFUUFBhRWZtbnZaWjd5cGM5RE84ZC91cEgwenJTSHN4M3Zw?=
 =?utf-8?B?K0lYRzcvMk5LclZ2d3FOSm5jWHpQTjdVaFJSQnIrcGZiTlB0WGg4VGxaeXlG?=
 =?utf-8?B?QXIvcFNCODNraTFlNEtJS3lsSHM1ZzUvbnBock9aVDg3WFgrUG92NnBUSElQ?=
 =?utf-8?B?UDljTlE4a0NvRkl0WCtiVURaQm5BanRjV3NWUFo2bHhjMkNZTC9rTktCUkpN?=
 =?utf-8?B?dUxqS2x4SXl2ZDJLbG9TSUZ0cW5HRmJyK3BwNWUxRHc1aXMxY2dGVUgxeWU3?=
 =?utf-8?B?V0pKN0N2dk1UbGJvMjZkTEdpeWxzVlBZZXluRGFTWmNPOHVvaHR3YzFERktt?=
 =?utf-8?B?TG1wZjBtYm13bXROSHJLQjRFVFNXb3Y0cmJnbG01YU90aWh6ZnNWeTdHSThu?=
 =?utf-8?B?UWIrWGNDeGV6cEJSazkvZEd0QnM0WEtlTHdoTnZZaElVZ3hkUSt3Smc2d0hT?=
 =?utf-8?B?MTNLT0RJdHVwOXFLK3Q5cXcydXhIWnlpTjJ0OC9ObjVTV3psdUdaV1JEZm9K?=
 =?utf-8?B?TGdSMmpqN1B3L0NMb0ErUnp4eWRYRDVremRrcDJUTkVpU0NaMDNrR3FRM29u?=
 =?utf-8?B?QWtwK1FXKzBDS09UQ3lRa3ptTUtOTlkwYWFVNUFkdGg4T2I2b1gxTG83Mkkr?=
 =?utf-8?B?N2NBaG53b2cyaVJXT3JqNkluTEI2R1R2RWloZEpGZkc3YUVKQWM4Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7398481-0cd9-4a3b-c641-08deeba6262f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 06:13:17.3180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 04z3/xoY7qcF4QWJSJe7dECUlFq1K1K8JPn7RLMHuP237/PKjp2w8KWAJs2NgPbfjN94tqd+E200IPKwWZ2jyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9124
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2026 06:13:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23752

On 24.07.26 12:51, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This patchset contains the necessary changes to switch
> isar-cip-core to the new rootless build.
> 
> This has an impact on downstream as the classes need the new
> rootless changes. So this is no longer compatible with isar before
> the rootless merge.

But this remains opt-in for downstream, except for updating Isar to a
compatible revision. That alone is not new to isar-cip-core. However,
this change also demands kas to be very recent. That is a not so often
the case. But we need to do this step at some point, and we are still
early enough in the release of the next version to move forward, I would
say.

> 
> The patchset is build with the following pipeline
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/2702946001

And that means our cluster is recent enough to host this. Downstream may
not yet, maybe worth to point out in the README.md as well (if Isar has
some info on that, just link there).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

