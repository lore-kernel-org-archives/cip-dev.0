Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D2AC25B75
	for <webhook@archiver.kernel.org>; Wed, 15 May 2024 18:33:24 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.40])
 by mx.groups.io with SMTP id smtpd.web11.1740.1715797998856329555
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 May 2024 11:33:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=zVmLp+ai;
 spf=pass (domain: siemens.com, ip: 40.107.247.40, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdPQEuTSepEUx/zL53qFK6l4pxGgYgSU73r5D0axycSzNNU0tSbf5s2VzJPDs2GJK10T+lDf+EnNLB/TFSTWkm57CcvvKIIe0MS6CS4xWUlLRTvoGqI1TdqHHGqrm57AYTEcL25K+2BK6rpQm1O0ra00VSVjBbxWWn+VrbM3lIEq68C13Lp5FU4N6s3FrFkz6vF1vjeEUhyDNSyeUPFvTK9duxAdojGpeFd8+umqkTmy+xUgzC/XFNaobcw6xTNAnLpOzD2ru1e1kj5/MLbCZ+YEyfqldfFeM0yB6kHGs9M4U64qPGi+aBJkA6rMh11P/HQ4cu3ao7x+Xz/cQXNA8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUEjQUCf+ByBB+orISupCbV613jHgxt/8+5VWVyyUc8=;
 b=Rjf4xmiANZ65+WMREyBh8rE0HdpAEwMrSFnKTUED99dvwdD4oP7EPFdD+u1VSfz43lidplBTI2bI+gFjoqSo53A2na+Qudv7U2aUTWq7JCtbr6+k9xJenxetCtquVVhJc3AqX5IeYGVaXRIp82SqtmtSkom1LVc+wXg+fXgVaJxf+QYIX2oJR7KynuN23epD8g4UgEveL2ZhfEfNlkxL297t3YLvAWofkCHbXCjRNRkcimNUDN9LIftgnLopRGwULHgsL4HiaUTkCUZ6PLHnfnu9fNQGVafsGCPfel3TwKvbhdY1KVksTZkQ4InpzxNXyscKGAdqclRuzJo+MCb84w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUEjQUCf+ByBB+orISupCbV613jHgxt/8+5VWVyyUc8=;
 b=zVmLp+aiSdV1knov/6KoDnBb7u6DFoMejojRmsqAp454J5dUWbxP3z10E/NhbEobqcf+rR1Fwlr4gZacqup2eB0dyAs65DcTju7T78agT8eAnSKManrmnL68ePIkGkrPEeFCFHuSp3WkhhK3VbwpScgHkfOKHNZgjLoxkj7zrrskXOrX/ibymGAjC3OgXuYiMBUS7Fa8S3M4lULc63I/mJv0G0ATTiHkfH67HZYPdabxO6jnDwOj5OW8D51Fy7CqnV+invPFXMgJVGXOtgGMvmfEX6OSeuJoXwUNY+Qu19GnD9ReMpGxFYs+p3F1uq5mB1RH5AsmGDDPGy08veqntg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB9053.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:23a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 18:33:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7587.026; Wed, 15 May 2024
 18:33:15 +0000
Message-ID: <035c94ac-4ad6-434b-9eb9-94fd92e80a07@siemens.com>
Date: Wed, 15 May 2024 20:33:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][isar-cip-core] kas/opt/expand-on-first-boot.yml: add an
 optional expand-on-first-boot
To: srinuvasan.a@siemens.com, cip-dev@lists.cip-project.org
References: <20240515075548.852777-1-srinuvasan.a@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240515075548.852777-1-srinuvasan.a@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB9053:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aebd0c6-6eb3-40da-fda8-08dc750d7c04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QU5MTEkwZ2orbUNvZjRvMXNtbEVDU1NSU256SkxYeVY1K3graWIzL2lydzBD?=
 =?utf-8?B?bjdDNTh0ZGZCWWo4cWphYTZSd29EeExnbmxCajY5VDBVZmdIbTdrN1VabnV6?=
 =?utf-8?B?c3dnNlVOR2NSNG14d0ptdmprOXdEeVp5czZwL0xUd2UwOGdqR2VkVXVxS3E0?=
 =?utf-8?B?Tm5BM28zOTRKMWVoZmdoWEloa0VDS1l5c0F1R0pXNitXY1ZrSkR5R0lnUUsy?=
 =?utf-8?B?NkNXYm85dlRyTjg5YkVKY3BBNkFCUHJKTXh3NEpxSFJKMHpYQy9EeWg1bUZl?=
 =?utf-8?B?b1N2K3JKYkZQQ3ZzOGI5ckdiOXhMN0NsbWk1T3UvT1V3UGloTmJTREpJZXRD?=
 =?utf-8?B?Y1ltell5N3lzN21ESTRFTkZnR09CK0dLWTUzK3lZZ3FKRTIway9rZ0NyS2ly?=
 =?utf-8?B?WVBkTG1jbjNYTC9MUXJlWW01dWJQZmhFQWljTXUvQitxY0pXMHZRMGwyNXgx?=
 =?utf-8?B?SThIRWRGeG1MYzFzSEFQUFJ5WUs4MXZmcEZIV3JKNVlUVkxHL0oxQThSOTY3?=
 =?utf-8?B?alpwbWNTNXd6TG1oN3BJSG9Qdyt3M3YvNjh2M3A2S2dsN3BaSDhlTW45Ky9s?=
 =?utf-8?B?OTRvekdoV25mb09ZSW5FUmJpQ0RjbFJBUEFVem1DY2MrblM5YXFwTHRlSTcz?=
 =?utf-8?B?Z0swN1FVRVJDOHRTeDdJb1BXRWxnbjYyTTEwa1l1NDBJdDAwTFpSaFhNbTRk?=
 =?utf-8?B?Vmp0YkxkaHlXSVY5bVU4YXNzSEFTOHNIS2REZjJ1bnpYTVhPUGdzNVBCbHZC?=
 =?utf-8?B?RjY0bUQyQjFQTkN0TGljQ2tzRFFEQUFma1JaVVkzNGppL2hBMXRQZ3pIVFZj?=
 =?utf-8?B?cyszZkRTVExlZFdOUDlZYlUrK3pSd2Z5dU96WmtsZW9QWUpRZEorVEhlNG5X?=
 =?utf-8?B?WEt3T01hYktFTWpFRmFuVTMvcDdiS0JITDM3OCtnQnFaUWxja0lCdkN0K0I3?=
 =?utf-8?B?NEVJL0JDVkp2aTlYM1V2TURNVk1jQms0am1lY1JoMHhIamlBMURQRko1TmZl?=
 =?utf-8?B?OE9oYUt1WGRpWWtmbkk3Z3poT0dUSFhpajhwT0tGb0c2SmhoRU5ZbjdxK1pz?=
 =?utf-8?B?T2pZNXFGZjE0ZmU0b3FFU3ZUbDVpbGFqaXoyMXpQWWpDWGxrN1RPd3YxbjVv?=
 =?utf-8?B?SW51UjFvNE9QN1dOalk1VmRsM1NKR0lBeVcvY3A1citNdElQaXorQTNHdHBq?=
 =?utf-8?B?VUc0bFVRTkRWeHlkcXJUdjBPZWI3SHpYdThBVkZoald2RS9WTUxaVUQ2Nmto?=
 =?utf-8?B?NEJnNEZKbURJZWFJYnlUS0pHN2ZvQUZsK0RkVWFpZ0hQM3lEN3pwcGxtSXp2?=
 =?utf-8?B?cUdHOEc5SjdTYlBTc0R5Q3lHQm1GZUZJZ1E1Zmh6Rm1VdDc2VitiQVF5Y1VD?=
 =?utf-8?B?MC9LSHBKc1k5RXBTSWpjMjN4RWorQjlRcmJDN0l0MGRXNUd1alZNNXlDN2FL?=
 =?utf-8?B?TEVyUjAwdGQ4b2dhLzI0cGk5MHUxTmpYSEhQRTFLR0lFZDRIUVlJdThwRGp2?=
 =?utf-8?B?NFJheS9ON3M5YmlldkU4aUZuY25iWERBMjBFSTk1cW1Rc1pSc3YrUXkzbWZ4?=
 =?utf-8?B?NzAvd001T1YrWXJvS0p1UWlvYVRab2VwRTZRcXZHWHFtMGo2UmZJd0VNT3hI?=
 =?utf-8?B?Z28zNmUxb3NFR05VOEZVeFo2U0xLN2xiem5HeGtaTEM0OWZlakhGOTJPNjhl?=
 =?utf-8?B?bUpTelU5Nno3R2I5S0duZUIrSkxUODVZcGlEWTBjeUR4QVJoYW53a3R3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TExhNEpnVlRrOHlCYmZmdkE5UkRMVVVnRXptRWRuOUdZYVlYcEtSZzI1c1Vt?=
 =?utf-8?B?bjZUbHlnSUdydDRuNDB1MDNMWU9rTUZJODduV2krUlRTeXcrNWErT3p5ZHBx?=
 =?utf-8?B?bVJ0RWJPd0dadHRuOFltaFlIbFlVaDF3dWFNcXhZdUFkdmo3eEFWcG12OXYz?=
 =?utf-8?B?WlVtMnpiTE9BRkc4QW5mZDl0Qk5QNXlBWGdlMlRnQk1wbVQ2Z0lMaDVXaHRQ?=
 =?utf-8?B?ZkdIellZR09RY1R1UVE5QVlhOEptcDZDS3ZUNXVTT20rYXl6V3pzeTRnNTAz?=
 =?utf-8?B?SzA3TjZwdXdTaUpQK0dwaHBJeWg2TDhyU2M0eFdHR0ZkaktyUlZISUdvRTRz?=
 =?utf-8?B?YzllNU1HdExRT0U0YlRpY1crODRhRDFNMnhzaURNQjFFazBvcHNqd0VXaGxJ?=
 =?utf-8?B?bVFIZXpCR2dDWGZBdld5b3d0SzJ0eG5vd0VYK2xYVk1SZ0x6L3lDNHpxeU9p?=
 =?utf-8?B?aWR6ZklNNm53WFhNbXlIeWp3cUE5RHpXQ3AyNGl0SzQ4dG9sUkpPMGF1blNh?=
 =?utf-8?B?bDB1KzRJL2Q2NkdVTVd4MGlEcFJIWGluRmRVQUtzdFlUUUFUN2YrTTJ0dzVh?=
 =?utf-8?B?MWVXUVVEOFhjVjhBbDRtMjVNVDNIUjJxcHZ4UUxjMUt4UEZUZ3VtMDdRUjRa?=
 =?utf-8?B?emZaM1ZNTmZGZlAxd0NKbEhac1p6N3VYbGZ2REk0azBZRk96dVc0ODFPeDFI?=
 =?utf-8?B?MmNrRmVscmQ3ZHAyRERleTBlY0QyM0tKVExHN2NmTlhub2xJTFFvWkFlZTNw?=
 =?utf-8?B?OTBGZlJtTEwvNG1xOVRXRnVJU2ZLTEtGNzhocXBPV0Z3ZjU1bkx5NTdpZm9o?=
 =?utf-8?B?WXpmT0dGcmJWMnMzcnhCT0wxVjFReHVMOGhzbGhyc1Y5OFJKVVpWZjVWVUxT?=
 =?utf-8?B?NU9LRmZ6YURwUTFJekdoRmVQZjY0NUJTUWlJM2dyY1B0VUVFTjIyaDdXWUF3?=
 =?utf-8?B?Z0Vna2Y1UEpSSGZZa0o1T2dqUVNrMHBTV2JuNVE0VGpKTDNCeFEvQ2cvTkJC?=
 =?utf-8?B?MXN0OVRpdkROb1F3SFVPdlA4UkRsTWppNmRabThmYkZTN1VsSWpiVE55Qm5U?=
 =?utf-8?B?M1FQVnhzVjJBclhWSUlsOHNPUWNZRVNXaWdQM0h5MFR2Z2NxemdjajVaYkM4?=
 =?utf-8?B?UUVwN1hKYURXaDlCOFpOM1VidnBzamN0MDU1L1hxZ21YeTRidFA2bFYrMFJj?=
 =?utf-8?B?U0d5WVB3dlVvR29lYmxmMmVsS2hUVmtFQ1k1MTN1MkFJaU5qUXN2bTAxcGhI?=
 =?utf-8?B?ZXhKWEQzVDU1RldNaTlpeThaQ3psR0kxQmt4Z2ZYUndqU01TemRjQ3JCdjQ3?=
 =?utf-8?B?RFc4QXI0MnZMRjFRc0psN25vcnlhWmJPQ0FsMjI0TnNpa09FbFZrdnB1WlR1?=
 =?utf-8?B?M0tQOGN2Vnc1U0dKL1lxWnptcnQyU2ZCeTZhL2o2aGE4eDMrMUJhcG0wNmRs?=
 =?utf-8?B?NWRBc3NkT29QWHZ3NGxqbVBJTEI3MjB1Q3ZtQWk5by9QY1JkZEFTeG0zVFQ4?=
 =?utf-8?B?QkVPWE5aMW8xeWhHNW9GNTZLMVAwUWQ0NS9IVVJ0ZVg1WWRyZmNMRUFWSGFD?=
 =?utf-8?B?WHB4eFhFWFVVeExkK2JuR3llbUdxbS9iV3h4a3pySzRud3FBdU9RVzNHQUFn?=
 =?utf-8?B?QjhQSHVkVjRlTnRGb3pXeWJUYjlON01ibE5GTGlYUkwwZmpEQVhTVnZYWDRl?=
 =?utf-8?B?ZzNrV0swTjhhV3c1U0hocWdkeUFVTksxU3hEWHRRUjZLVm1ycmdON3VXWldm?=
 =?utf-8?B?LzN0OU9wK1dlQ0ZkR2FtN1ZiNWIvUDNMZUlvMWw2anMwdlhiQTFaZGRHSWs5?=
 =?utf-8?B?RTVmakhkRXd4R3pNR3UxMTNWd3VGRTdsUzZJRnR4Nnl4TmhCZmJyZjlNVzRG?=
 =?utf-8?B?L3R6VS9iYzJFUFJ4aExQUWhxQ08vSnNLcXlQYjUxS0pXQlQ2amV0THV2Lzlk?=
 =?utf-8?B?UUc2NDA0REd6ZEhoNVFUdVZoOWRmZjhpNUxLTDBJNUtiVnNPYlRnTWRoWVVt?=
 =?utf-8?B?TnNIdUtXRlFic3NjamN6OHM2YVpmM3kvZFFKc3ZEZ3ZnU2JDQzVMY0pzbUMz?=
 =?utf-8?B?aThyM3RpZ1NTSlhFWXUya2kxcVU4WGZYR2hqNTVOT0VMdDJlZG1IT3VtSXpE?=
 =?utf-8?B?dm9uWnBaVVZSOUExMVRuS2sraUg5VEhwdVBib3VYZi85cU16TitYc0hVVXpO?=
 =?utf-8?B?R1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aebd0c6-6eb3-40da-fda8-08dc750d7c04
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 18:33:15.6561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qf2kHEYDuHxHa56W3bjc3WOA+QuIMCIbV26AWmqtDQKYZd3ygtz1T0QSdhCY9ckHfdLpUKJrcyqcAL/EeXH/Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9053
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 May 2024 18:33:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15899

On 15.05.24 09:55, srinuvasan.a@siemens.com wrote:
> From: Srinuvasan A <srinuvasan.a@siemens.com>
> 
> Add expand-on-first-boot package as an optional file,
> this systemd service expands the last partition on a the
> boot medium to the full size of that medium and then deactivates itself.
> 

So, what should this tell us? Given the complexity of the changes below,
the text above does not add information. At the same time, it contains
no information about WHY we want this change.

Jan

> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> ---
>  kas/opt/expand-on-first-boot.yml | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 kas/opt/expand-on-first-boot.yml
> 
> diff --git a/kas/opt/expand-on-first-boot.yml b/kas/opt/expand-on-first-boot.yml
> new file mode 100644
> index 0000000..03d666b
> --- /dev/null
> +++ b/kas/opt/expand-on-first-boot.yml
> @@ -0,0 +1,17 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2024
> +#
> +# Authors:
> +#  Srinuvasan Arjunan <srinuvasan.a@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 14
> +
> +local_conf_header:
> +  package-expand-on-first-boot: |
> +    IMAGE_INSTALL:append = " expand-on-first-boot"

-- 
Siemens AG, Technology
Linux Expert Center


