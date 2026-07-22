Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2725DC44539
	for <webhook@archiver.kernel.org>; Wed, 22 Jul 2026 14:37:05 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.64])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1497.1784731013458750189
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jul 2026 07:36:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=WcUQvupD;
 spf=pass (domain: siemens.com, ip: 52.101.65.64, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hde2w00UyWNZd5Ed5vCvW+4Ri3dP5slkFi2K+pe8DhAmPKy6R6Oe6Lo68WGQF1xHdx3ba6/jpXtoYpVOh+Bajbuo84zzs4eZEdtg/QU5mBSvCsRTOWdyPoLsljPXIgG1INOTRrdP/uAIYaqOieX61rQb1BfJfy28ifrAI7W7GS/jQk75J3/SHfY8ofNwdRsrXcl43Dj9okKG83io+CubYbF+qUPO6ZQc7w3yr5FWtPCD3g6ONtOy+rRQcoehU2ovYIJfCJxZkwZ+en3Fc/8YA3r/OqDT8F0vBCh6IgtJsbiabzQaLloXhPcMKjl+XSVfnoAEpuxJwRrTFZEbx6L/gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCYZOrX9oovQXHeXiM+MqrKKhSMQQ5Gs6/7i0h54XC8=;
 b=ZPXPIxhD7ik1gtvUukI8SUzKvcogc4uDe/3Qm+bjIPnZ2vjbfVceRcCHcgCiPgUtdKEaNt9abaoD+ngXZviq5j5bbnlwZ0zKbMp/L4NBTwTJoo9i6Qqd+cPFcti1vz0BoBz3yawZ/qnOPcPI7nY6koHy1EaYuDfiuHX2rA199J8wZMGRwWBI+yj4UL71iQVqXobKGaZAbKSKmO35mGxLo5aRVMjfamwr55wn+ajkQeRCYmPtbhNUpTMwmYK9WH7eFzD1l2d3kCItPzCm6qivIscBhe+KQLJpNQTLHCZTu7BlT+VzGzxdpJ4z2INEhkyR1zp8r/L6/wG+brHNjr61uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCYZOrX9oovQXHeXiM+MqrKKhSMQQ5Gs6/7i0h54XC8=;
 b=WcUQvupDwOYN+G9LHokBViEmGtwr0gFzh8/9WQ/NTuOp1XFvfEybyo86+6mvY2KR4UW/qCRo+nySR0xEv+okYiLWb/kRFeTF7Gf8j8gykyGnkxJtJmaUoO985Z8ZB7DKuELtLiX+WnuUIONl/5nCQu5huMzWoFSYf84/DGFGYCXiboeXZ/OMinhWEWYe0jPO9Cheq3Xzc4VcxaqmKbuXF5MZlujtzFXjTh5RdMAPuBUDhae29i5t4KtTlgHeKuv47Xi9jHT68CKkCCe3IsJ3Q1Mpy2yFuOKlu/qP7dStHYJjQfByEEoRwZbAHhJYNcnHRtUcxomPTiSZKnuCM1cGRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB7063.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 14:36:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 14:36:48 +0000
Message-ID: <63c02a0f-7f97-45c5-aadd-f189e8e5e089@siemens.com>
Date: Wed, 22 Jul 2026 16:36:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 1/3] swupdate-handler-roundrobin: Keep
 default lua version as 5.5
To: Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: Shivanand Kunijadar <shivanand.kunijadar.v45@mail.toshiba>,
 kazuhiro.hayashi.f74@mail.toshiba, kumar.dinesh.h95@mail.toshiba
References: <20260722114753.627244-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <20260722114753.627244-2-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260722114753.627244-2-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:79::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB7063:EE_
X-MS-Office365-Filtering-Correlation-Id: cbbe1920-f3e4-4f58-4482-08dee7fea97d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|55112099003|18002099003|22082099003|11063799006|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	vk504KjBsKITsza3Xe+kHoIh76J0S5cl/5yPNLdk+HZF547rcHS1clYo+cUnSJeIgphV6UyYYZwsPR+d4DI6ltPy/MY8vhR0RgrgSQs54qjWmPxdSqGh3yyuMTQZGzzHVEC1EQTyj5w8C/i/WxDyYhd1xTifeMqJ1RB95TkNfgDRZzkWQY1fhFROJ+PXvYLzfx94gaedp3e/5zrS6ApR609A+PZ6lFFp/5upBzApXAIvHdQKuVBABgyO2vJj/A+uPjqjU/B47y5r6QJSYD2W/N2Cp33V3V9lIzKg8aia7Qw62/YFt7flOO3AjZ4J1vaSW3abrmtoSR06FNUn/+x2W3/Mc0C8G8Z9HBkKL7y0MtxsrDJhFwIGYUf4L0ELNSoMWXyYI6CJzMc9g1GGWUbIRDTLSY8EIjXbNmnF9ktKQNIFs22n0NZow6QRm+Kcc6DgTm+GOuPcwb0SNVF087ApuOEO5/TcLQZEZY2hixWm1Hv2n556NkLcuXj3ZAvXvbyoyXJf2pV52tp1N5Vxi8562VtIWIgS+PeuoW5xIynyNfi5i0GCkpnggWXOrvlKc3rUGk7HlwkKrfEWga//tAm5/E6d/oVG6nR99jTzo99Z6bd3Fhl/IeMDI/ktjgKMIiMH7EYGKCLXqLE+mycergehtXxFMsTatHdcz2Pschqlcqs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(55112099003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OFJUcWJEZUV1djk0RUFDNjB5TTE1Q3U3enI4cjRTZUx4SytqeWFTNlppNWFS?=
 =?utf-8?B?TlZJNS96czVBWUV1RkhTNVhoMmJNeUdxK0Q3QkZGMTdmenhKaG9CaURueXVM?=
 =?utf-8?B?dFJHWE1ER0FEWTNGSEQ0VzgvdEJ1S1V6TFVBbklDbWFGQVJEWEUwaTNOVzFI?=
 =?utf-8?B?aHVONkplZkxjZXlqRndKYUIrbXZFckFBREFuWlczeWJuZERhL0lvb1NiQWxZ?=
 =?utf-8?B?OEQ4NzZiTFVpSmJLbzFVckE5a25sdXN0ZkJvR1ZydzZndFVGM2xVeTd1aWwz?=
 =?utf-8?B?UTZkcUdwMTFLY0ZVZTN3Nm9HUGRKS09wZW9POFJ0OVJHd2Y1ZVgvSGN1eVhL?=
 =?utf-8?B?NlJlZWNZM3V4N3RwRkJKWEpmZFNPZm1pM2w3S2FjenkwaHlIcnN1b3dRZFlv?=
 =?utf-8?B?Nm11SDRJZmdGN3JFNnVKeHVBSjRtMkkwMFVDckRldlpPbTlzbGIrYTJFWGtD?=
 =?utf-8?B?bTJhU1RWakRLRml3M3pUL3FMN1drTFZ1UWdTUGM4cEphSWJic21WN2tGUFNs?=
 =?utf-8?B?eDZXOVBwOElCQ09qSk51QlkrTEJaczExWFpzcVhHTmdXUyswbHFzTUwwV2hH?=
 =?utf-8?B?YTUzamlsajJRb0lJb29jbXN2RHRBdC9JZlBXWEMxdnlOZjlSUWkwaUk1VFZM?=
 =?utf-8?B?UU1tZ2VKZHpBaUs2TDl6aTlqanhnSXhENFhNY04vSktkK2o3NUkzNUdUc0Jk?=
 =?utf-8?B?Y3M3Y2hsTlNDSHpIYXZBU0VtMnFkSk4rZWtaNStRUU9HQng0NHk3R05FekFs?=
 =?utf-8?B?em04eW9CdGJVNDhoVnY2NkRRMzVKYmRJSkFia1JYSDVKWDlsNnVubERiRmJn?=
 =?utf-8?B?OTUxWXkrUWJiZEtUNk84a3dFVjRkOXFRdzNyekVSRHUySUV5WHhtWjBlSWhu?=
 =?utf-8?B?eFl4bmVSWGJvd0NlV2VqN0lmVHpFYlowZDJSQ0ZwZ3lseTQvaW9kU3RPa1By?=
 =?utf-8?B?RGFzVVp6VVZ0NU1aUXRXdVJ6U3A1UnVFUXVLUk9pcjBlVFN1S212KzE3TjVE?=
 =?utf-8?B?WElMcEVHQlc4M3VKcDNyait2QjlWa3NuYkZRTDJLMjQ1aFp5QWtVYVorU0Zr?=
 =?utf-8?B?OXNLU3Q4WStqWFAremMvbnd2clRGdHVhSW1VdkNBOEExYTlZait0RU9EYm9p?=
 =?utf-8?B?KzdTWjYzaE1TZktac1EydnJKdVF6SUxwcDBSZkl6RDEvSXdGZVNiOGw4dEJ5?=
 =?utf-8?B?bzQ1L0pST2ExR0M2WVZ0WXl3TlRjUUprZnNKWFkwa1FlTTZRVWZtbXdHcVEw?=
 =?utf-8?B?Z05CbXdQZitGN29aMGloWm8zSzBFY3RMdFY2aWlFaTFYMmtCRFh5dy9QanhD?=
 =?utf-8?B?ZldkU3FGZE13V25wSjJmWHU2UU11ZENjbENMUHpEU0htNElDNTVUanpSM1Vn?=
 =?utf-8?B?OHJBV2ZEdWZaVTRzYkJLcnhseVRqQmVWUkNNZ0Jjbk1LVTc3alU5eXNwS09s?=
 =?utf-8?B?THVKcU9EcTR4dkdWSUcrLzBGZ1dNSlgxSmRjNE9ESDFWVVBMRmg2V0FaaU9H?=
 =?utf-8?B?aGxRN0pBM1lFRTdyeVVrdmxJRktnMVB5Q1ZBYTNmenFQR3loL0VMSFhMcFcz?=
 =?utf-8?B?SXBweCsrQmRkdklPajg2YWRRdUtCYTQ3TXJyaG9ZRlRjRFBuZWhKbU4rMlIv?=
 =?utf-8?B?bUZ2ZHQvcGVxWHNoM2hQVWdJUCt1TGhlcG4va3p0d1ZFNGtIVm85RUhmUjZh?=
 =?utf-8?B?cHNPMDJGUDFhcTlRWWZCSGlXSjR3ckRMODZQQVBYd1ZTaFVYamVTY1YvaUV2?=
 =?utf-8?B?ZFIwUWxkYTh2WDFaNXNtSExMZjBHZlpjN0NaeTZZV25LRWtJaHA4eElMMEQr?=
 =?utf-8?B?dDcvRnJQT2U1Yks3Um9tZy84R0ZJVkRicW1nVDFuMkFxWmZQNStjUEVxWXhh?=
 =?utf-8?B?QnBUTUU4QUU2U3A3SXo2L09aeWdBRGNCWjZ1S1hCOVJqZzA1YVRsK2FrdXAv?=
 =?utf-8?B?QlFGV01YUVRkYjc4WXZ0WExWR25yRFNRQjZBTXAxOGZIQ1JIVVR0M0FRWFZ4?=
 =?utf-8?B?UVFZWmFDUHk5N29DM0lLeGlZNjdDNVk4RGh2a1BVa3NHOGdTKzBQY29GS0lI?=
 =?utf-8?B?VHJNNVlUY2hFMytDa3YzVU5kVU1NVnM1MWxVVCtGRHpmMGhnd3djcWpwTGlB?=
 =?utf-8?B?SlByMHI5bVp0TmNENkF6WWIxUlBISWpDOTlvZHdlK1o1d2JYTytYZTdMQnli?=
 =?utf-8?B?WVBPMnYrTjJ3MWYrRlJJTjNUQUpkdFJ0clIyM2lENVFJSW13Z3J5V05xZGdZ?=
 =?utf-8?B?aWl5ZHhuL1ZPRzNRbm5pZ3ZWMGZtVEpUOVoxcmpzckZpUWpqOHFweXVFT3JG?=
 =?utf-8?B?VCs3cU5WMnRNNmI0d0JheVNBOWpVVUNzVW0reUlVMkZVZkkxRjl5dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbbe1920-f3e4-4f58-4482-08dee7fea97d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 14:36:48.5419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZtKTkBf7gCVBw38fwFYIvPpmof8zHjnE4VNS1fAp3rKQTdl3qUmoSfifRiYPqrIyx+XCvJ/TTUgzApPrnwUobg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7063
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jul 2026 14:37:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23715

On 22.07.26 13:47, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> From: Shivanand Kunijadar <shivanand.kunijadar.v45@mail.toshiba>
> 
> Keep default lua version as 5.5 which will be used by forky/sid and
> add debian version specific variables for defining other lua versions.
> 
> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>

Signed and author address differ - what is the right one to use
consistently?

Jan

> ---
>  .../swupdate-handler-roundrobin_0.1.bb                    | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> index e3cc7f8..f991483 100644
> --- a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> +++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> @@ -25,7 +25,13 @@ SRC_URI += "${@('file://' + d.getVar('SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG')) if
>  
>  # The lua version used by swupdate to search for additional handler is hard coded in debian/rules
>  # see https://salsa.debian.org/debian/swupdate/-/blob/6ccd44a8539ebb880bf0dac408d5db5de7e2de99/debian/rules#L13
> -SWUPDATE_LUA_VERSION ??= "5.4"
> +
> +SWUPDATE_LUA_VERSION = "5.5"
> +SWUPDATE_LUA_VERSION:trixie = "5.4"
> +SWUPDATE_LUA_VERSION:bookworm = "5.3"
> +SWUPDATE_LUA_VERSION:bullseye = "5.3"
> +SWUPDATE_LUA_VERSION:buster = "5.3"
> +
>  SWUPDATE_ADDITIONAL_LUA_VERSIONS ??= "5.3"
>  
>  do_prepare_build:append() {

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

