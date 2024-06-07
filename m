Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CCAC27C53
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 13:15:10 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.40])
 by mx.groups.io with SMTP id smtpd.web10.41389.1717766107981749342
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jun 2024 06:15:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=yR8ffbU2;
 spf=pass (domain: siemens.com, ip: 40.107.8.40, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APW4LcLjer1/Ih/QsHoRKnzyVgSn+GhireKapT7nz6P0+hvWcWOd9CT3iPNHFvuw2YIWn1hu+ErwuA8PrJ8V/JTag/5vs3aHPQgY9vgva2Iid+2WQV4Ft7wo934G1J42RQrJt+lBAU4Iy4/GYEDYbpcnxQuqWFB0+alA14/NWI7+npQ4b+LUEdhMunvZwTPw04UxJtBLhUuyTvC/o+PSKt+f5mBQ3EJ/z0Q1yBplX7LZOVf4/qkOCgzr/rb4i8bmOT14wDO/UUaKN51FRLTyvDwEWU04PFpk9QLVF1iSFI9V3Q5gGDFazmjIJsCbyerdoBNeOsnvHdXQYJwEfTlVEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arSfC5o3LFI8JHKVKuhpEU26blQ9BgBCw6VAWv43zq8=;
 b=flNXU1jF0Dr5HUp+H4PQ08lcbHt/Z+jh3CsC2JisRk6m3eLBU8YoOHzZKSZGupH80n2TwfC1v8x9Wg8yFbwxARvng6HMZ/HqnMQv2n6W+FUlUXzL+y4l5jAXZCX3PABRva2LBpkKpXO283SYCgvgwXb/MrVv/v8jRvRJjwtZCMRtNBEafMH0YRrPTfshF/y900ndlUt4sUG6vLJyZbbJ/M0llelhir5ItTghorubCNTtS2LhHluvNDgUkGg/I7OCBHdt67PONMLg8AdG/ex35unW6HIpsw8T+EizJGYSxQGM5joT2XThOBgZNZBzg6Ch2wx2aqsAGQv/2vddgfrD6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arSfC5o3LFI8JHKVKuhpEU26blQ9BgBCw6VAWv43zq8=;
 b=yR8ffbU24/C04x6IvDPKwbGlEYDTebsPRFVFtIBK8gGQR5wsQ007e5RpwYiB4W+rBXe1sVU2oSU0BOxKfLfQDacys6fTq4O3LbiQzSli7gyuU4xeQb8vXpEWmnHjkTObae7lMM+OON0ZPoQVHQjLKTpX13UDRhxaP11LvdVLmbsJu5wTREFTVTfjy8ZJmk1oJGRcqsMJe7x3pPSGOZj53Kj2J0BcppscU7SeRTslLtFQWzMl/iOu42XlUvdgJYGwm3o3qfi6QAXx8KYmgtpQTKRIG1z5AqKeCcxvuBfSS1nQvJ8xKFFtP1gxIg5poTKDQRMnzuo3+IVgtjPMhZE1pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3973.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:135::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Fri, 7 Jun
 2024 13:15:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 13:15:01 +0000
Message-ID: <54c18d2a-fd3a-4a6a-bcc6-aa3b1ad3338c@siemens.com>
Date: Fri, 7 Jun 2024 15:14:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v3 0/4] Trigger CIP Core testing LAVA jobs
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240607095229.490871-1-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240607095229.490871-1-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3973:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e73bb54-0b83-49a3-0895-08dc86f3d640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YUVTSlBLbDRtT3dybVZRQ2FOcWo4SEtaNzdzSHVoWDFKS0pBQURYalRKMU5S?=
 =?utf-8?B?NHdNbWF0RFIvRVJSUkdUY2tuREozR0xGK3E1cWdUUHJIWS8rbUQ5VmNrbGJo?=
 =?utf-8?B?R2p3OGN1T2xqTzZjdVp6a0dtb3NYTlBkVitRU0dWK0ZWelZpYUt6VEFKbm1T?=
 =?utf-8?B?Q0o1SGpPYVdPYTlZNnRvR2lEQ2ZwMnd0dWpKaTlhVFhzNVRjbGNHN1NscGpI?=
 =?utf-8?B?MXhoR1FxWGZzTWhoSFFEb2FSZWJ6b0FkSEVyNzU2R2tBL2tiL1FSU1Evd00w?=
 =?utf-8?B?K3I5UU5hemI5d2FqNGRNRnRDSzZkRW42d2d6cWkzYXV2WEhXYm5RRGhwUEtH?=
 =?utf-8?B?U0tkejZBS095Ykd2dkREcENDd3c3ck0vSHhISDN1QWk3bVpMeFVKNW1MWVBn?=
 =?utf-8?B?SERSL1hPcTlwWVBCNVl0Vk9TWnQrcklJVzU5SzRWbXM4Qm5Jc1QyL0pDRTNC?=
 =?utf-8?B?UEp4MlNmMU1MZmRMd0hHakFBcXdZMGlocG83MHd4Ri9RN0VEYjg5MWhiZU9k?=
 =?utf-8?B?Qys4bnlqeHhlbUF0UmpoNm9jWDQxNmMwbU43ODJxTDNtVVZSc1pNN3J1cFlR?=
 =?utf-8?B?NCtwcG85czhtVkxUUDQ0WjBJcEJ3cVcwNjN5dU9HR3dlRjhNT2U0ekFTTFhk?=
 =?utf-8?B?bWc1RzdjS0p5YTdFRVVIaW4raStuMUEyTldpeEdhRWF5R3l3MlRhdW11Q2J6?=
 =?utf-8?B?QVVaUTFxNkVNSFN1TDJWMkRwNkQ4M1hRV2tXbFEwZDQvZmRSTFhXcnFRTDAr?=
 =?utf-8?B?UDNYaTJOVHZBZWoxcGx0ZW9EdUlYUnU5U1A1WUt5ZzA2ZUpNb2Z1RDM1VUp6?=
 =?utf-8?B?TjZ0RW1MWjMwdkFmY0xTd0ZSWU1sRTgvREVqUTY4YnhQaFkxMHZONXV1T296?=
 =?utf-8?B?QTFGRDJIcEI5UFgySUZWdlIxeWRSMGQyTUUySEFJTUdZTVpZaXBoNjhDdlZB?=
 =?utf-8?B?NHVqUXo0WDJsQUxJcldVRXFJNldMbjlDZUF4czE5R1g0NlpjVnRnZkJpQzhG?=
 =?utf-8?B?MFZRT1loaWdwRGUwd1FzWkNiYzVmcDBMa1lteWZCTTdQS0ZkK0tuUUhvdlpL?=
 =?utf-8?B?RkJDNXhiRlYyNGZWV0thbnRNQ3JDY0tXaWxmakQ2L0YwVGJKcjhtNWsyRVp5?=
 =?utf-8?B?Ym1wU1hHd3VrM2N1R1ZOK0dibmJzSWMyOHFodTVMWFZWRmJhK3FGdGJubVVs?=
 =?utf-8?B?L1hjUS9iMlZJRFp5YjUzQVlaSS8ySjBYWW5KV0Znd3phb1REZFl3bDZRWWFn?=
 =?utf-8?B?WFBZMWNjSm9IU09JODNKK09jOWw0TWk1Szd4MzMydHZYM0FyNHd0K0VhYzkz?=
 =?utf-8?B?N2pZa1A5c3RBRGZYaS85a2g0cFY2c2JScEE0L1R1dkRtMVJKSGxONGZsd0c0?=
 =?utf-8?B?MzU4emt5WkRPM3RpRG5GL0l4SjNLclJvTy9CUWkxSjFhbENSNEg2dEc5WWZP?=
 =?utf-8?B?c21CY0w5OHV6MU1XQ3NicVkyZW9hM1ZITG43MnRiTEhOaUNXYUc4WUVxMUxw?=
 =?utf-8?B?VTNob2lnZnYyc2hvSFAvV1ZMM1poNEowbjFDQlIvU1FUNU10TG91clc3allv?=
 =?utf-8?B?cmtrbitDcnhEODgwVVc4SGRPUFhvdXlPNGRkZzlGL1dzOUpibVdMSXRWUnNz?=
 =?utf-8?B?M1hKcFAzYXhvZDgzNWdtY2oxa2tTbDY2bW1vM3J4NGx1WGY3d09nRHRFVU44?=
 =?utf-8?B?SmRqYU93QUJMM3JVVVhaNW9NbUVvTXhqdUJwK2t0M2p4SUpyUmN6bGxRR2JS?=
 =?utf-8?Q?yevWrcRRPe4mjBUyjEDT4pYJ/YJAqD2XwUEpfMx?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TjM2d0dZWFJVY3UyK1NwMVhlbzdzdk5xVm1FL3Y0NWVSR1U5T2xtYkxDMDNo?=
 =?utf-8?B?K0hwOFErQ0JPQkJzNTdwWDF4akw4VUxJTm9odUg1cUhjeGRId1A5Nm9hVjla?=
 =?utf-8?B?UDNXV3R2MHRVMVdvNnhCMkRndGR0UHZCSHlxUGtTRFF6VHNqN0V2Z2doVHdn?=
 =?utf-8?B?NE9TcTVmeXNQeVhhZzA4aGl0emVESExZYUFqRVhuNW0xMUZ5VjBtTzBHRHVi?=
 =?utf-8?B?SE1SSGR1aC90aVJXNlRZRit4R01xdTBadCtBZWMxTHVpUmF3U082aGIvZ0F1?=
 =?utf-8?B?SGRvK3NvOS9wVlkzREExT0FweUVJdnNObWlxZ2l2cVhybW9VYVEzQzdFLzht?=
 =?utf-8?B?SUd4eG5IUVUvZ3BVSTFqZ3lFLzU4bVVUWEIyRkNvUFR0SXlhMlp5YXkxTVVL?=
 =?utf-8?B?VEFqOEtBQlBmR0x0Q0lVRm9TcFhqczJicEpLL3A5WnNpM0d5Tit3Z3hKcFZu?=
 =?utf-8?B?STZ3dUJuWGxxNUtqdk1rY0dDdEpMY09IVFpZS0lyRWxXQk1nSkpUQXp0U3RZ?=
 =?utf-8?B?QmhOdCtDSVFYdDhLdk10S1R2VzNMZXd1bW5jUzF1dnBMc0ZCYWJYZHJPMXcz?=
 =?utf-8?B?Z3k5ZVoya25ad2tFd2xxZDRqc25Sb2xQdHZ4VmR1cjIvVi82V1lrK3YxQU8z?=
 =?utf-8?B?NXYvaWJ6Y1pTZVNMSzlZSVluTlROU3NGdWMxTXVNZ3VoYjVlVFZJZXlUNlpp?=
 =?utf-8?B?Ymg3T1JpU3FxckhmUWhYTjR4NWZpRnY5R1gvMWhMZ3F5VDRianRRTDhZdC9E?=
 =?utf-8?B?bE5QUHJ4RS9HRjI1OVZuazBFaDd0VEwwUUVaemM4UTJ3ZTZxeldtaEhtaDkr?=
 =?utf-8?B?VWRXd1pqaHlodCtxSWh5cEVMbUZiTmlVOEhmZkNST01rSlRyWEZPSlpUcVQx?=
 =?utf-8?B?YWI0bENqTGdadGVuYWRCNTMweE9NVHFjTVBUZE1lakJCL1J1ckQzKytTczBS?=
 =?utf-8?B?emRFNlBvZFo1dGNPbXM0T1NQSEJIM2phN0dIa1BLbG83TVZydUNXd1gwRXRw?=
 =?utf-8?B?ejNNdzNIWmVKRjlkcDRhTGZEME9EQUJsM0ZjWjRpdXJjbmNFazBBQnU5VnZX?=
 =?utf-8?B?TXBJZWcrdFllYkV1UVVpZHM3MHNFQmV4NEJzTGdwcnF2K2FvUWZjNS9pdUUx?=
 =?utf-8?B?MUFrT2QyeVVBOUVUUmpRRGptTkR2cVpBeDhKZFJPVVNKTG5CTlkzVzVPWEtx?=
 =?utf-8?B?U2VzcWdySlJScGpGSEVQaW04b1p0RzVNU05xNCt4OXVIRStJc3R6aFI5NFM1?=
 =?utf-8?B?NjZHcWFrVHo3bUlKcm9wdGVFclVKcHhqSUZyZFlIemczcnVFRGk1b1FQN0c1?=
 =?utf-8?B?VWc5N3FVZmRnVm1wanpjU0xZaGZVenQ1NkhEZmtvdDhOQjhvYll3dHV4azZh?=
 =?utf-8?B?MUJkY3hScWxuMGxQTjJFWlZ0cHFFV1ZuTjFSZ3EwdlJvSGJ5UnlNRU5oM3Q4?=
 =?utf-8?B?M0NzWlRUQVJ0Rm1JS0ZZRVBEN3RmOExJMG1sRzA2YlNUMHNVQnZlNUIyZWNF?=
 =?utf-8?B?aVNITEhvZ0hiQUU2YlpCM1ZpTjNYakpQdm0zM0hab3g1OGYxdEVWMk5RVnho?=
 =?utf-8?B?Mk9UT0tDOFJUZmJra2JtQ3E5OC9ROWtoN3p5RmhWMkhVbHNWWkh5Y3EyOUtV?=
 =?utf-8?B?VjNHMy94VzgwcUh2SEdpd05yY2VnZXNEVzNJN1NKVDBXQ0hKMHQxNk1pd1px?=
 =?utf-8?B?eVg0cVZjdklXZ3Frb2o2VXVqTEUydXd4QTJOcTRjWkxkeGNYQzBLallOV1lJ?=
 =?utf-8?B?L1pvWnY2YVdXNkRWL2JjQ3N2ZnQrbVhSVDU0SmpOTk1LRW9ERCtubmxreGdC?=
 =?utf-8?B?NDg0K3JDUkh2V3F3Wm5OdW5maVY5QzY3N0pydHpOQzVBYTJXSEdXbDVDSmI2?=
 =?utf-8?B?dXdrbVRlcndrZWJsSnZ1VEZZd1NuL2FNRWduYXp2K2o0ZmxQUWx5NHplc1VI?=
 =?utf-8?B?MlpYMU5VeXZ4MHkwRlFkdk5NWko3b0xucWJ6K3BSM1dpMGVRdjVLTjYrdU9Q?=
 =?utf-8?B?cXNvWUZzaFNlRkNVMVZ6YW9XZkpUdFJPeGxxcUlTclI5UmhWelhYY3k5YlFt?=
 =?utf-8?B?dlU4bHdmK20vd0tOUXA0WkwwV0lIR3M0MWs0bldSVXhCSjhkT0xKK2IranVy?=
 =?utf-8?B?T1o5YU9aM1pqdGY1cFdGWmQvWnV0Sk1GVmROaUR1blFrUGNrL3hCTnlJMlNv?=
 =?utf-8?B?dEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e73bb54-0b83-49a3-0895-08dc86f3d640
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 13:15:01.0333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pjju7GBbW1LELjYAR4GFbPfkxO9pkP9B6g6ThLD0/PV2azp9C2ibqm9x6HvLSjFntWRQhWS5AyFj5eNApH9wbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3973
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 13:15:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16140

On 07.06.24 11:52, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> 
> This series of patches will trigger LAVA jobs which test swupdate, secure boot and IEC layer.
> 
> Changes in v3:
> 
> Corrected line difference in [v2 2/4] patch
> 
> sai ashrith sathujoda (4):
>   tests/templates: Include functionality based templates
>   submit_lava.sh: Add script to submit the jobs prepared from templates
>   .gitlab-ci.yml: Add test targets specific for CIP core functionalities
>   doc/README.lava-testing.md: Add README to explain CIP Core testing
> 
>  .gitlab-ci.yml                          |  33 ++
>  doc/README.lava-testing.md              |  30 ++
>  scripts/submit_lava.sh                  | 464 ++++++++++++++++++++++++
>  tests/templates/IEC_template.yml        |  74 ++++
>  tests/templates/secureboot_template.yml |  65 ++++
>  tests/templates/swupdate_template.yml   | 125 +++++++
>  6 files changed, 791 insertions(+)
>  create mode 100644 doc/README.lava-testing.md
>  create mode 100755 scripts/submit_lava.sh
>  create mode 100644 tests/templates/IEC_template.yml
>  create mode 100644 tests/templates/secureboot_template.yml
>  create mode 100644 tests/templates/swupdate_template.yml
> 

Thanks, I have applied these patches to next, and the pipeline is
apparently running fine:

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/1322502481

Note, though, that there is cleanup if not fix-up potential: Please run
shellcheck against the script and address the findings. This should be
done on top.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


