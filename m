Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C5AC5AC82
	for <webhook@archiver.kernel.org>; Mon, 10 Aug 2026 06:56:03 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.27])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24434.1786344961103511813
 for <cip-dev@lists.cip-project.org>;
 Sun, 09 Aug 2026 23:56:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=nI7/7k43;
 spf=pass (domain: siemens.com, ip: 52.101.84.27, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r6qO0fam4z75MizWTNeMfCX2JkPlvuqs2O/2BhYxNrT3tWVXUoS7ZjpC3L3WXN+Ut6s3ABn1LRcGXUQxACBfWd//l0t+qNuZ/yOOFPFIIRMkOaXwuBIQaCXsTufzxQzBBq62nX2OXHeK+f0kxIp3a+HyiFB1K5u8uf2ppVUuSkQFgvF9Tcu1vpp5Gvt8SIu0gKUVDVtr6n2VOWZnj62KfwPSdTjcPz0Ym+BoE9PdebRMUIqYLUWSV0acNqB3BRSZJ3WTCstvyzBLURSA5Ld69MBnBaoGnPZV1k+UWPePvzQLc2i+Hqw5ybO7kn2LwSaZky9vt5zLJjCgxOLbih9Oxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YeXZi+r8c7a3y1TwFpZNxAHP7AEAGFm5gaHojx+r6i4=;
 b=pdr9nQJOWI0LSexTi6q9KZRNON26oSKOdxk8X0PgTbx5UjFtW/FACxHtc0rV8zcP13VYjBMAdavohGjrF9sGtA8HDHk6pnaJiUKMAWnYSKNVzyuX2xEuKRF8dpk/foJ6HmcN+orHlfPy2mS9K3P56kBK4LD+aqHwtyn5GQ76E2MK4WfYVCMAIA3bSoWhqaRKo0YuBrvpzcpZUlxNL8QRAPrUgURqbe8BDu03B1Zukux6ZpKgpzH+mEc2Xjv2z9saKCjQMF3gGZM99tTzDrb24LnLTi/X9a5wT+qPkzHtGfSYtii2Sm2sFXQCOQdjYC7EgKJH6eAwK2WjPyg23g3tFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YeXZi+r8c7a3y1TwFpZNxAHP7AEAGFm5gaHojx+r6i4=;
 b=nI7/7k43FDVixXwZO4F1fXgAjpXBGxVix6v5R2yKg5NGFw7JOhTilBWmTdAeIORThjFEAjhuenB24XHm+TM75J+irNPs0XoGebm1T78fy4/iqM4J6BQC9K69l36bSONRvvI+Y7GZO4nanfY7Au1GgqAWKM0nHn7M09qmyMXqMnzqTPk6BiHo5VpBypruHIltP5zCavqaY0LHzOn4irXA7/5wIP3CrKO83OIR4QkGytpvWFMDKpC8STEGQ75O5/GqrE2bB75gshPemPLBa+DwW4QsbZxoP3KCaHPc1X7/1UNWqkyye9s9DQGDYjqTByhZIlXbzPIiyb7PMKUXMWnvZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by GV2PR10MB9772.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:355::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 06:55:56 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 06:55:56 +0000
Message-ID: <31174e6a-78c9-4fce-8d1f-dff403e1f6aa@siemens.com>
Date: Mon, 10 Aug 2026 08:55:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 0/2] Remove unsupported combinations for
 factory-reset from Kconfig and document them explicitly
To: alexander.heinisch@siemens.com, cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com
References: <20260807154439.625212-1-alexander.heinisch@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <20260807154439.625212-1-alexander.heinisch@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::12) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|GV2PR10MB9772:EE_
X-MS-Office365-Filtering-Correlation-Id: 222b0d0d-747c-406c-5157-08def6ac6d73
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|10067099003|56012099006|5023799004|11063799006|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	KZ/NN7fnySJSmDs0DpETiI+JWWiJmIu6m+dW9c65GInkNez9BSxBZAJ64jI9O9A+ZezqfWXeIFmFAckmfZYPunas18bLEiZjmSLHRcDHOHd7ca8w7aCxuhbbe5Eiv5LSJ8dnTl3gPR9RCGTnhPJg4Lx8LGZiA6+sKaIdGnW/lkow+cZaJbTtL0zyXsoQpwtxIT+vBLRY1rjCUtr8pXarfRl+wKHqfGg0/QkzdFbpBK+HIcWmy+UyyLFazCCLrJKLbv5nQTgKnsEvXOrCXwFJFUSJY/WRsZN3LHKOL7pRE0Gz0Z6cjTNOV6OuETOUA624WEh28rQGmn8BhMZfIUV4Y7GFV8q1kbobMXyi0FSr6HdzNZLeP5PSVkuHko8YPAH2sdkBtDzp12elXcBbT6hkwdHUMQ3PcHRTxcuVHpvX3jWufRKbfPnUe2e70tdWzHGJLk0VFl+mConoA9Gif55otAOfoodR0RBBt2SUxjjTzFrwuXz/DfSxKRznyTLxcjAuEwCQGWctAuswAkImddq71ZnO/bn97CLMhqWUIjTGb0DSK/FFYp0pt/lKrG322wZE1vq8f0fzgAEAwgKg8lm6jZaHIQkbC9iNap324cG4HeTfXEFpC0VjaSKu4ib1VfUUKeisxysycwDi8Q68zuaUn7/TiD0TVGNH7UAdkxASvt8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(56012099006)(5023799004)(11063799006)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eEIrK1h5MkdpUng4MEVLaHZ2bUd1MWtqaWZhVlZRTEM3M0c0YUNEekpDNXVJ?=
 =?utf-8?B?SWw0bDBXU2RKbXBHT3pCZXI1NjRyZkNranlwRS9zYStQWUR4d0NmcU50VEVV?=
 =?utf-8?B?Q09iMThXbHFnZUVRekd1QVpROE9qVVJVNGppa0hEbmllVEtsdDVOeUdPbFBC?=
 =?utf-8?B?QUZlQUhoVCt4b1FsamJXdUJ5THFxTkNSR2U4YzZyOUVLakFjY3dhZ01nNzRI?=
 =?utf-8?B?TXd6YnNJSzhoRlZFLzZjYVJ0UjNNV25ZdGozQWF4aVRCUUpFcGYwc1lHSTV3?=
 =?utf-8?B?eWE3N2xla2hjNDhsYWxibnJJNEF0dDRTcVp0eWM1MXVlV1RXRHFTcjVJR2RN?=
 =?utf-8?B?Q3NQMmJ0c0hSejhHRkc1SDBQcnpLQzZNbHA1ejVqdU03clRKcWFiRG02L3JG?=
 =?utf-8?B?Y0Rib1I2bHg2UnVvMEZhY2tjbWtiVUZWZWZ3S01TWEtKK3NkcjRLR1VKaXVK?=
 =?utf-8?B?RGU0TWpjdUMvUmdwZlZjS2tLbHZpRFQ3N3JReW5Dai9vQmllZERyalk1UkZ6?=
 =?utf-8?B?TzVST2lBREVDQXNTdHVNQTdKUktKRWYvWUVyaExFU0ljb2F5MlNPaXA5UFpP?=
 =?utf-8?B?OFIxYTk2YVBSYmdKdngvOFhlNHpiMW9DcGE2YnF6WU5rall5YUEzYnlza2li?=
 =?utf-8?B?a0hIUWNrUlF3SFFVdGRUaHphekxpS0Zvc0ZVck13L2Z2Mi8yQXhZRGlkYmpw?=
 =?utf-8?B?UzBLeUlHMk4rM2tyS0VDV3BvUXcvNWdRanNnaHZIZ1Q0d3I5UXErQ3IxbzBO?=
 =?utf-8?B?SkpsVWpOeGdiOGpveXp1SDQ4NDBUMkQ3RWJTdUtFZzlUUWYzMTFiMjRNdENH?=
 =?utf-8?B?Sk1ZMENwMlRaamdxbDl3b2x4K3p6TEpEOU9ENnFaSzdNVVh3SkdVTDZKdzlF?=
 =?utf-8?B?YmhsQzd6NUZad0RWelNJYVdSdC9zRldPUUFucXhwMUpPTGdUMjdWdDNmT2or?=
 =?utf-8?B?WWJTVE5CRllReVYwSytUdUUvZC9PdUVPbWtCcHIwREFUVnIreGNZVUNjM1J4?=
 =?utf-8?B?Ym5OTkZ6dWlodkhkQVlvNnpOUnhUMVhKcjJRQU9iYThIcDRnY0VYWjhJaS9o?=
 =?utf-8?B?d1VNeVk1QjdhU1p1OW10UUgvNUhpa3doQ0RLcWZLV1NEMFRtWXp5dDhWaG4r?=
 =?utf-8?B?TFV0N1ZNZFhVK2RERUYzK0lHa2xZb25oQllTUFdBUFpSRlByWkZHcVN4SGQz?=
 =?utf-8?B?NjV1SHhuZ3M2TUJhRlBpSGRTMUJLZ2VGaVJzM2Q3Vkk0SlNtc1hjU2NnVUxO?=
 =?utf-8?B?ZWswd3N2QXZYekNHakN2Z1BFYmZab2xFRmo2RUsxWlNlaWd3ZFdaYlpFcUgw?=
 =?utf-8?B?RDRMQUlhSVlWRldOeHBjQU5PUmpaZ2wrUXNDN1VuMDRNQXBiZ3c5dm9LbkpX?=
 =?utf-8?B?Wndqb09aYkFhZytSUVo3dFhXUWUwWDNwcytOMHZOUDJ2WGFYQXU3YWZlTnpm?=
 =?utf-8?B?L1VTVVhORm5SL3dNcTc3bEMzbFdEbVlEQnc5R3hyNU54Ym5XVnptY3lQVDRm?=
 =?utf-8?B?WHJ5WTJmRlIwTUhxZERlcmlmSWg0eVNMZWhVREtTVzgyK1c2T0tWaE9aVGtE?=
 =?utf-8?B?S0YrQlJPZndIUWwycXRySDRGRGkrTytUa254Wnh1WHNidWJSaFJ2R3dnU2dm?=
 =?utf-8?B?UC9HMzZUNDNZNmZyRjRCRzBzNGFCRm1aalZja1l1UG9Xd2ZXM0lTZmo0V2Iz?=
 =?utf-8?B?Ky9RbTNPMWFHSkJQK25rTTVJMmN1Z0dITm5CcHBTeEtROUt2MlZ6WWErRXZo?=
 =?utf-8?B?MzVyS1JaRjVyY0JJMVlrR2pZMUk1dGxET0hOd0V4SnZBaHgrRTA3enQ3eFhJ?=
 =?utf-8?B?MWxiSW4vUS9VTWJWUmdoTXhmYkJ1RjhUNjNUMy9OSjJUbjRLTnpMWnNmZWVT?=
 =?utf-8?B?YVlTcllRMXlQZmNzZlQ0ckZJSStCU1JoWkQ2Nno1UUxobDBpbmJjbnZnRFpu?=
 =?utf-8?B?bXU5Y0tUbnp4Mjc3ektpdngyTHZUWXdoZWtWSFZpU1BnZlBORUd1VUk5Q2xX?=
 =?utf-8?B?RGhNTFpJUVFJSUwyRHFzMm1BY0x4Q2RsMHVXeGZlNmRWYnVSYkdkcjdMTmhH?=
 =?utf-8?B?WjlFamxCV0UzaUVIUk91WFd3U1RYUmZLWDEycmE0ZFUvUThlTkh2L01wMjNG?=
 =?utf-8?B?bE1jUjdzQmNVdTE1TzhOTTU0SEZod2ZZcWtseSt2NnBCbjJiMSs4d2xDMjZU?=
 =?utf-8?B?c3dNN2lUZm85QVRTOCtlWVNmMEZCL0lPVXQxSDlHWEMwRzZLSWtTQkZOQllQ?=
 =?utf-8?B?ckhKblMyeDRnZjA2eHE0Z0xiMmhITzAwN1VWNHdob0FaTzBCNnduNWQ3dzBi?=
 =?utf-8?B?cWg4ZmxqOUhtV3NrWndXNHI1N0VVVU54eHFHTHNST1BlbXdKVWM0UUpEenRM?=
 =?utf-8?Q?G5+02WpwGUffZfRg=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 222b0d0d-747c-406c-5157-08def6ac6d73
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 06:55:56.6223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9oqm2LRzigbWJkz74yfN63GDpbZlRDrzu/WnRcYFk/NmqcQG4pDlbpBAJ+vqi7b2/43yk5BWBuXbIkSV6ZFOGrjWfr2MmqxCwBABTOVloo4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB9772
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Aug 2026 06:56:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23880



On 8/7/26 5:44 PM, alexander.heinisch@siemens.com wrote:
> From: Alexander Heinisch <alexander.heinisch@siemens.com>
> 
> By default factory reset clears the tpm. Therefore, keys needed to
> decrypt the immutable A/B rootfs in full disk encryption setups
> cannot be retrieved anymore. Thus, the boot fails and the device
> cannot be recovered.
> 
> This patch series removes such combination from the kconfig and documents
> the issue explicitly.

This was never in scope of the factory reset. You could implement it by 
moving the keys into the boot partition. But this move will create 
another can of worms.

ACK.
Quirin
> 
> Alexander Heinisch (2):
>    doc/README.factory-reset: Explicitly document full disk encryption is
>      not supported with factory reset tpm clearing enabled.
>    Kconfig: Do not offer factory reset with full disk encryption enabled.
> 
>   Kconfig                     | 2 +-
>   doc/README.factory-reset.md | 4 +++-
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> --
> 2.47.3
> 


