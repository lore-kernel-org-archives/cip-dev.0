Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFDAC55182
	for <webhook@archiver.kernel.org>; Mon,  3 Aug 2026 05:56:57 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.11])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5350.1785500470188638159
 for <cip-dev@lists.cip-project.org>;
 Fri, 31 Jul 2026 05:21:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=GkzRq3QO;
 spf=pass (domain: siemens.com, ip: 52.101.70.11, mailfrom: christoph.steiger@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xgJUhTzQcRUl/BCFc8bYetFFOG7lKqEpcDVGXtynBolALkbaahdw4ck5Xj9Uwy56LmUAJEmIZOEjCrmv7alSMTOThbj66PU+f+OBpitMtejimEJ/1kwoLFhnLh24kk8CJUbIDRBf01A75wSF9DnucYdSl1uLeQz5lKiMkpWiTHSa1ZIcs+e2fMk+w66e9oKGhwf+yPX2JzzY9AscN1nxqlOiH4yVcOw+eMU3sos3ckbdMacrAhbS+MOdmhLWaa1zHAZWxIckJ7muAK1hxuaMxDoRqLeBnR2VDw91RGU84WghAfEzMgfHM/bZ+7Ziy0wDNa7DtqaPsm9ze8FpmUXCJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bVX8EGr+AdFLyh6oaqX0InNpgM8MyF5sLHEy0fEupA=;
 b=So/hQ9yIIsot++VBtDtB3ibixxf629g9psMtWdhtYjth3zdZuiVS5WI/2rqBmmQmUipvLkefxW+yLosDTjSKLuvwGPpJEJlaYmVyQyYuYZYoLIifHymzhfeXpRpwUarzegSwQ2Y9NT37Vxugsu2o2E+UPn1WNXiwhNQ6sRSBHqr/2yKAY4xVty1V/Mdhr2dE54ci/HqxuRguCZp7Xvte9IYg+BjnWnSEbf8+b9PPh5HP367E+QrIxeLkxKX07klhFHhgQ9FjW0qTsvcBWoqVp8wC3LiyqFGRMlWLV532YTgICUORhcsNrwl7e4zD64vKBI16dro+MZKP/yldhIqMIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bVX8EGr+AdFLyh6oaqX0InNpgM8MyF5sLHEy0fEupA=;
 b=GkzRq3QOtY+g0dZu5sQwMKC3Me+egX6N06gapdoo/6wfa4Vly9lpCz0D3JmyCwUcZyDscxVDM/xyuVaTWdMr6V99iiWAu6DavmhXSRnoo1deD47UHuyDl/17RC8gmyKOwlZC1uihsmovxAtJGrKjZIKoItky2P8eIGVEvtH/p7YV8AtZY1Jrvqkqvz0yBABgIIJx26cZbjTxvYwsuAInOshpaE2j/pCk7ieyrOnufZujaQU9UJlELk/jcBpk4cwa9oKbM6PDzjItvmQeYoxG5tnLl+DnNdv/jccD3G/dRrpFHPGzapUT20UzG1Ec9GFmKEWz06nVahm/T3tS/0XLPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS8PR10MB7136.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:61c::5)
 by DB4PR10MB7446.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 12:05:47 +0000
Received: from AS8PR10MB7136.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::eec4:8dfa:81e1:1bdd]) by AS8PR10MB7136.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::eec4:8dfa:81e1:1bdd%4]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 12:05:47 +0000
Message-ID: <943afddf-f520-450a-82e7-3d33450fd189@siemens.com>
Date: Fri, 31 Jul 2026 14:05:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC cip-dev][isar-cip-core][PATCH 06/14] Apply hardening configuration to the kernel
To: Jan Kiszka <jan.kiszka@siemens.com>,
 Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com,
 clara.kowalsky@siemens.com
References: <20260724124038.3633611-1-Quirin.Gylstorff@siemens.com>
 <20260724124038.3633611-7-Quirin.Gylstorff@siemens.com>
 <db84a10c-e0ef-4ae3-820a-3bb5198b263f@siemens.com>
From: Christoph Steiger <christoph.steiger@siemens.com>
In-Reply-To: <db84a10c-e0ef-4ae3-820a-3bb5198b263f@siemens.com>
X-ClientProxiedBy: FR0P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::12) To AS8PR10MB7136.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:61c::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR10MB7136:EE_|DB4PR10MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: f9fca8bb-b7b2-4ced-9bb9-08deeefc0e2e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|55112099003|22082099003|18002099003|3023799007|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	2v6I3KzFrRgU9yxjf+w4AZn/4kVcnExwy/pTX66NyX3YXOgPgKsYJ3iLloF++89z+afaBDHak6ReB5am4rjkE8sc3xFSEFmc6+vpZezrvfRndSszR1xWbRAyudY4T0v6bQb38FF+ZD0bnIuB2wzGyJNBTC/WGI9CqQLJpTs2eg5kwBjcjge53erQjRyeSq8W946HJOZ8WYXy3VowwLEkzoWbTQ3MexCIBsftg5qyPyXQp/StEcWfY91m/PGR3+3fqjm5AngcyaH1buv0xH6xOKwGeyXn4w+XK8GUQOkXlzN2QiANmLz2YgryyaQu6RMAE/+NG0y+Jf2+lcD31X+gdFEYEapPnx0iLdVZEUbriNjeM+XkBytpQcturY8BBuoCPeHAxLp9FoqrdVvY/IPBijlz1O0Nyue5Oup3pcMbGXaZEu3mSCDUHr0XbnqJgjtiS9viLO6T5DS/+u0Hu1wb8iD0/OGazdJZwefOY8WZbjd6E7ZmE7S0SQidIhPajX7Wh0sSm7PuQvRo/0kpk9ZbgcFtvhcd8si/4H0yMkBZ9re0uIAE3RENeoaWR48bqljTz6V6xFk6laU2rLwp/+jwgAuWfpekwkmi0dztP5e9/oIqioKs3KzO9iPJMvOO9Ds6yy/nUB1C5j+OdZlEjUCGD5sTsvNmH2Xq5a/aa4GNgbI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB7136.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(55112099003)(22082099003)(18002099003)(3023799007)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S1g1cGhtNjV4NHBQdzB3TlcxTlVVcWZmbjdvcm8rTU53ZkhFZE1ZNHltQ01P?=
 =?utf-8?B?ODhPVThWWUExaDJYSDdsZ2gvbEQ1eVJlWFNtbkROU3lDa2Z6eUd5Y2xMdkww?=
 =?utf-8?B?WWFVeTRFeVUvR2drdmRhOU1hSXE2NHlwZUVQeGlIeXVPbEh4Z0J0M3lpTitX?=
 =?utf-8?B?QXMrZTNaNXFJMGlPYThCaFpGcW83K3hyZkZhbmNoMWova0RqQWJ1R0ZidW9w?=
 =?utf-8?B?RWR1VXBycmxlMTJ1OU43MjhFNXNwZkViazdYbk5xNUZVS05PcG1oNm5SK3Bw?=
 =?utf-8?B?aTN0VHEvb20zOXZQQXJQSjZJT0JrVG1RQk12dndsaWJWL1JBS2tQcGg5cmRL?=
 =?utf-8?B?RmM4TWRJa3JWRGxuWkFLY1RJbUh4ZzluR0NKeDJFUWx4cjdLMGVjeG5uVHpX?=
 =?utf-8?B?SjZIS2hsR1lUSkJ0L1NSaEVxMW56bUljbEkzSThxUi9VOFcrR2Q4bVBBVGh5?=
 =?utf-8?B?ZEI0RXJJUjV1aGxTWVhFSFIrbHpZbVI4NnN1MVJYTytrWUZlVTVUL3p5VUM5?=
 =?utf-8?B?anZOZFA5bEZqWkNPRG1JbTFWcjFOQStsZUgrQWlyVlRxN3lGVnhxUm56bm1j?=
 =?utf-8?B?ME5oWHorMTgzVzluKzJIb2tBNko0a1drUW0vT00xcFEvRmlYOUk2UXhRS0Rj?=
 =?utf-8?B?aGVPWElJRmIzWTdhM0FIY3E3ZHo2TjQxZExLenA1UTlJaFpqN0JzTEI2N0lv?=
 =?utf-8?B?UkJyc3Y4Y1VzcnFabzcwOStlejJkTEFKLzFYVFd4OUNvNzJNYkgrYk9iMS9G?=
 =?utf-8?B?dzJWNDFXcHF6SUlPWVlDZWlUVTlibDQxV0ZJQlV3anRWNmVwSm90Qk42SkhY?=
 =?utf-8?B?SUtlZi9xN1BQdUxnS1VaOHoxWDJ6bEJOamVpSS9FMFlsTjI4VjJpc1ZIS1Jq?=
 =?utf-8?B?WmIydEFBYTFPbTJUait2SndHWWc1K2JhdEdNOXNkaGV1SG53eUUyMXZST29w?=
 =?utf-8?B?ZHYyMTVCS0hleDFpM2FKVHR4RHZaelZWM0sycVZvc01oaHM3SDF4bUlOR2l4?=
 =?utf-8?B?UlRLdk04VGhoUU5HVi9DamVIQ2llakNHSFk2QjhWWDlSck9FTlMvdlpXRElG?=
 =?utf-8?B?bEJTN0NLWDBHRm1UdWJOR3FoSlNnT01pemJBUkQ5TnpNV2xkeEpnckI4Ympj?=
 =?utf-8?B?YUdsQ2t0cE5FcGtVZ1ZEaFFoeTRCUzdYdFErNlhiMUtueUllRlNUbHh0TmFV?=
 =?utf-8?B?Sy9aeVFVOUNmc0xVMk1mTjA1dDJ2bmhVSWFORzFiT3ZYcU44NTlTZ0NGWFhW?=
 =?utf-8?B?eHFxbll0anZPa1YydG8xS3hUOWFYbUt1K2MzeVc5UjFJa29EVHRwdElKTDc4?=
 =?utf-8?B?NzhoYUJ4OTdIUFFGaE5WUi8yRUxHd0I5RHFOMTJtZFJUZmdrMHVxL1F4NEk0?=
 =?utf-8?B?Z0I4SURHMGtxK3JMVTlIMTAvZk02VEs0YXNjaDVBYUNwZnVKSEtZeFljbzly?=
 =?utf-8?B?U1RXRUpTMHB0aCtrTFY0VEJ5U3M3UGdCNmxCdmdUTHc5dEt2VmgrNWRxY0FC?=
 =?utf-8?B?b0Fhd016d3BMdFh3bWFFdHdYWENMYzVjREtXaWZ6MHcxNTdwVU4wcnVZN1ow?=
 =?utf-8?B?YTIvQUtzRit4ejZQaHgzWmx1Nm84ZUNTdXBXemo3ZFZZblZEQ2xCbmUyaFhP?=
 =?utf-8?B?WSswN1RmcTZhNkxiSVVOWlYzbk95OWNYWmlma2F6d1dZRnpXUEhzMXhNbHlz?=
 =?utf-8?B?VFdFalN1VlluV2hNSFZoSzM2SE9HakcyeDRYV2tzWWRNOUJnUmN1V3JlbDEw?=
 =?utf-8?B?ZXhKM01OdG5adUw1dzBzK2N2S1l4QWxDZnc2ZndVU09YbTlNQmphY2pTYXRD?=
 =?utf-8?B?Q2JraXVPM0FSdjFORDFYdG5QOVhFU05MRUlRMHd1U2NnQ3FvQ2NLbk4rY3ls?=
 =?utf-8?B?OFdBYWZKQW1oZnJRcTJaMThvdUhSaS8ydGlicStzVmRSQlE1MzJTa2dwT29z?=
 =?utf-8?B?YjNEREdVb2NtWWpZWWhZRXBtbGZMaVdnd2Jlb3lhVktPSGhRaGNpRHhZenNZ?=
 =?utf-8?B?bWNobVd6NXgyZXdkS3Z3NlhSN2NOdXYzVmJnTDJRZVZEUEdLTmxrQVlTaXp5?=
 =?utf-8?B?ODVuUXBZc0pXb3BHR3JDS0xKUGdIdEFtTmVEUVQ2K3BrY1Uwb2xDaUdEYmZH?=
 =?utf-8?B?bXB2UU1xcGJvb0RDYzIybmJCU2ovd0JVQUhPay9RSzdSdjZ5eFlQMGV2Y0hT?=
 =?utf-8?B?cTk2L3ErVkxsaWJYUVhLZnpXaVlvSkhQRGVCRForejlVMnZnS1hqaVJTb3Vp?=
 =?utf-8?B?SU83QjZ4NDc3ZTlIZkFYQWtwZm5nQ2UvVEFwTmRBclhNM1lFYXMzY0tZMjBL?=
 =?utf-8?B?TnRRQy96RzRDVkd4Q20renlrdmgzQmYvbVozcXRIVkVmMmxUUTFMdE5IZ3NE?=
 =?utf-8?Q?cWjCv4yEp6Rz+xMQ=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9fca8bb-b7b2-4ced-9bb9-08deeefc0e2e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB7136.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 12:05:47.2092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8IBf4i9bCDtrFyCuGh7Wfss1kkRS0mugCIXoN63oFBH0MXq2aWqml1KQD30nOT5AB6kmBp5ewXKwyqyvjmDQNT2OF2lv6+2FPOVIBh5A210=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7446
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Aug 2026 05:56:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23848

On 7/27/26 4:21 PM, Jan Kiszka wrote:
> On 24.07.26 14:39, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Use the provided kernel hardening configuration options in the kernel
>> build.
> 
> Err, no, this does not do that. This just drops a dead include that
> could be used in an own kernel recipe, and only then it will have a real
> effect.
> 

ACK, we will move the corresponding changes and fix the commit message.

>>
>> Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
>> Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   recipes-kernel/linux/kernel-hardening.inc | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>   create mode 100644 recipes-kernel/linux/kernel-hardening.inc
>>
>> diff --git a/recipes-kernel/linux/kernel-hardening.inc b/recipes-kernel/linux/kernel-hardening.inc
>> new file mode 100644
>> index 0000000..2b22fca
>> --- /dev/null
>> +++ b/recipes-kernel/linux/kernel-hardening.inc
>> @@ -0,0 +1,16 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# SPDX-License-Identifier: MIT
>> +
>> +OVERRIDES:append = "${@'kernel-hardening' if bb.utils.to_boolean(d.getVar('CIP_CIS_HARDENING')) else ''}"
>> +
>> +KERNEL_CONFIG_FRAGMENTS:kernel-hardening += "hardening.kernel.cfg"
>> +
>> +do_dpkg_source[depends] += "${@'cip-cis-rules-config:do_deploy_hardening' if bb.utils.to_boolean(d.getVar('CIP_CIS_HARDENING')) else ''}"
>> +
>> +do_dpkg_source:prepend:kernel-hardening() {
>> +    cp ${DEPLOY_DIR_IMAGE}/${DISTRO}-hardening.kernel.cfg ${WORKDIR}/hardening.kernel.cfg
> 
> Why does this need copying? Can't we just reference the right .cfg file
> in SRC_URI and let Isar do its magic?

The copying is required since having the config snippet in `SRC_URI` 
makes it required at parse time. The snippets are created at build time 
by one of the cip-cis-rules recipes.

Either way, we are using most of the magic already by simply adding the 
snippet to `KERNEL_CONFIG_FRAGMENTS`.

> 
> Jan
> 
>> +}
> 
> 


