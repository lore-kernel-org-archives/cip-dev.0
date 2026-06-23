Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41963CD98F2
	for <webhook@archiver.kernel.org>; Tue, 23 Jun 2026 12:41:45 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.20])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19720.1782218498945138042
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Jun 2026 05:41:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=gNb5tK/g;
 spf=pass (domain: siemens.com, ip: 52.101.84.20, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cB3628ZoG9hAzCywLVjsQJIwrRAAe/qjnubHi9WEXzoE9YpXOZVgIW3gKUcrcuznpT3gd9D4/diNAF1LqmsdovH0X11VcNS3iBzOQ884zPsTnRYONyHZYS87m3/QP283jv4REPJUq+p5XdYbQ5sx0TUOE5MLrH7HIcHBS0Rulb1WrhKqQXrkOB7Ldwi0Bxg/T94aWxRJWYPyDPCDka71JijDprauE7UnQ3GAykflmkzOfIJ0x+JI+CxCW/pMtw6r9/F1Sx5L3OMwyRcOoFaylTzs1bWoyOdIZ4xGCL6zxjLSXml6LkaNflgNbphu71OVF92wdZgEvqUN6J388myeJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xi0/MzS0MTB2CRfvWD+9LhQGCvEiV5mtMgfsEY8IOgE=;
 b=mXLJGcdxPTpo7YQnwp6CQEUKnc3QbnFQTbjVRHgIUlqpKffM83GwheutxxWakGZjARPUnguJwbVWwSajiAAXoKgba1ghqT/aViRtSqLji8uOL53Mfi9amkXc//r1apB6DVJkV6o3/AQggvGJgd6Yyk7hFyv2EqBYYM4pSUpmD5h0+soyTlguC7ZNMWr3b7SOUV0p45tUXAq4rf7je2lzU1n78U4V+r6fpcaD0g+6mtAGumRNSz+IrCwHxk3gHjHu5wG7bQ6gdhZn8GzCN2YkEodT9e7+E9ACGaFB63dF13DTm+fQ8RwYy5AwnjtqbdQXEIR172lnlFlpc3rDUcdJ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xi0/MzS0MTB2CRfvWD+9LhQGCvEiV5mtMgfsEY8IOgE=;
 b=gNb5tK/ghOAP3t+9gUxR2QN+BxPevV+WwYaiAJ6a7XXnP0tS8FyZI8zBWx+4r8Ho9kvN9QluiLCU0xCC90PU2lMdrXwHYICZDQN8Oz6hgNv3GfLzuRODi1VBzn5uqmlUoWE6pxs6S4vKKWIgWpHQb7KK9EdnmmIxSPSJhg9DQSb/CT7GTWC9Jy+GdBj3U5G6FsjcvgHXgRhqPnF5SdRqxz0zq0J5XJvoKgy8zBXbXn5ubSP69lYYh31Jnc4VKiUG619SZc0rhnsJbxTsatSsoTEshkgI0WgYR8iG6X8/RVZTWXpnxgAEyiluc9OYk1lkVqleC/V2I7dAmZMhPiIr6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3511.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:132::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 12:41:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 12:41:35 +0000
Message-ID: <fd407f79-72ca-4da1-8937-9ab989c3a1cd@siemens.com>
Date: Tue, 23 Jun 2026 14:41:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v4 0/3] Enable Debian Sid support
To: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: Adithya.Balakumar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp
References: <20260623105234.972121-1-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260623105234.972121-1-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0426.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3511:EE_
X-MS-Office365-Filtering-Correlation-Id: d38b0e96-150e-481e-0bda-08ded124c2ed
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|55112099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	vYKUz28ZIk6IOilu+Og6YPk/wSbm1QT3VqCJ3WuyH+DM8ML3/UCVmstc2bck5ffRBlpkWfSo1pK/Ij4yqHWKSZagNlb/0elIHFcFHYoklQdtL0D9Yy3gAdNYmwZ5QVyc9Ny9M34pWCUm5kNC4Mrg6hiOsLjEP38ipXtT5zGtGWJZto9C4gJbpVF0umnxVXjZDKmAzsyDCcTeSq21YeLvns3VltruyYGg9vShP1XKFTNN8r+ACClty3Eswc/6xahgjEodslFu5MJmxqvNwAbUrDt0mOPOtNj1M8vCJrG4GdkMBu3KYTCRD5duD9YvzR/appAaTRwHZz5pUJ9ft4Aw/WKrdVW+Neo96gCTtKve4w2mN0xe/Qmj1G/Etv3++HfwhBelv1LyF+7IG5UjUTM/Yd+ciBYuGKXQHcTnJkLTE51nQgfbnYIMzwFbzKaEukNP7eBiYhwYjKiuLjD9k+QqSWU6nQHybpKLvz/OjXa0Elvr7SoKTPi753DMP/iurUsnycebhxwb/+gO7XZgpu2hp17V8vyOHGYVpAxZSfkS/9TLzkjd2+lp6Mfnx5RnMmyQPtwoLbM41xn325/gzvntXT955oaYBjHDLghI1phfexIJH93QpYRwT0LAFQHMoV+nyNGLUeXBlj9M6H+xE3zUin3fmbrug28A1ZfE0Y3CIAg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(55112099003)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZXhKOFJrTXplTW44UFd1TmkvWUc1YUZjY0dCV2FBN0Z6cFhuUDZidmhJWHBY?=
 =?utf-8?B?UzJnN1BQSXdhOHg5QmVXZU1zN3RpSlZoT2xrVzR4NFR1SS90NnJlS2hsbldk?=
 =?utf-8?B?amhrajVjVGU4cjhYMXhQbjU2SEtHb2t3dEw4a1Q1blVsVkNWOGl2cmJ3SUlH?=
 =?utf-8?B?TzZHNDFISkkvMS9kRDhWaWVZTFVPejFLL1p3M2VUVS9WREttYXV3cHp5c3pk?=
 =?utf-8?B?UEdsNkZZTHFTR1ZUKzJwc0E2TGxialJRZWhsMWZrSXExQWpzRHRQTjArQ21y?=
 =?utf-8?B?S2VFbVVPY0tzWThuSlV5c3ExYTIwcVFJVE5RMndoR1VaRWhrTVJBTEg3L2JX?=
 =?utf-8?B?SHpIaTNhOTZjaXI1OWVpd0h4RjhyMGlyWStvYzV5WW1ObjRNL3M1YnNvTVRL?=
 =?utf-8?B?VkV0aWRQdnd1OS9LQ2d5YkUvUjZPYnE1bjA4USsyaE9pbVd4Rzl4anE2OVo2?=
 =?utf-8?B?UlVCNXM3eFFjSDZRTC82V25TQ0J4dkxWYVhxSkYvTkZSa2Z1bng1eVhoV3Fl?=
 =?utf-8?B?aDhDd3Q5RzFmTzRwSVRKTE52YWRnOVpZQS96WDhPZUV3cmE0aVlENXBBOXJD?=
 =?utf-8?B?a3prMDNPeHoxRk4wei9Ed1NhMUNFTVVMdk1FdjRFR010MFN2V1lXYWo0Q3F5?=
 =?utf-8?B?LzNhRUxaUjhzQ1VRR0dWNWpEWGpsbDRXYXlIZi9XSGZYVTZJU1NibTVaUkhm?=
 =?utf-8?B?eU1jZEllbGVoa2ZuWk1CaFQ1b1Zua25KUHVWd0tTKzFldW5HTnRhTDFWWTNQ?=
 =?utf-8?B?TEZBTWQ0VEtRdHdwR3llWEsvYVUzNHMwS0laTHJWam5HNS9sa0x2ZC9mNzZB?=
 =?utf-8?B?L0FFUWRObDBYeUNzMncvR0ZqbENoS3ZaMTVpSjlVdWQ2QjdvZmNpb3lsZlpT?=
 =?utf-8?B?dWNhZzZVdHlHN1RrL0JGMkIrdU9VU05vZkJnYTdzeUYrQ2pqY3pweGdweGd6?=
 =?utf-8?B?RVhhRTg0bmdjZzdKMGMwRlAxTTQvdnE0U0pDSGtWTWIxcjBOUTB1TnE4d0ZV?=
 =?utf-8?B?WC9xNnBkTVpiSTZSVTZJVk5UN284ZGtMVTdXbThoaUZ2aWMvcFJxRmxGZ2J1?=
 =?utf-8?B?dFRZTTFncXVZSzQzcG5GQ3ZzZUQ3RWJUVHdWM0pHU1JGNGZCS1Y5dHhCMVc3?=
 =?utf-8?B?c1dtdGxSTG1Hc1ZPeS9kb0tTOStjTTQrb3d6UXViL3dWTVR1dTRsYTJBR25U?=
 =?utf-8?B?U1hzZkF0OUxMaTZGUFdVZjFuc01RK1dUVk5qMXV1MlBHcysreU45UjBvYm5Z?=
 =?utf-8?B?Kyt2WjNPTnlHSXpDNTkzWEdyQ2IwaElFQ2ZBZmFjc0p6cHVwQzNrZlk1c2lw?=
 =?utf-8?B?MUREMG5GelBiS2JrV1B5TUgxYzZRZ2FOd0Fmc3ZRcGE2T0ZoV0hPY1c5NnZ5?=
 =?utf-8?B?bzlxMWtqbDBZcFJQdDFYb2E1clhZNURsY1BKNjl6dVFwTkJaRHZ0MUxpMlNB?=
 =?utf-8?B?b3gyQ2wyOVpSaTN5NmVLVm5VVFRDeEYrUDRXQ0s1aTR4c0M3Z0F4UzltSkgw?=
 =?utf-8?B?ZjhUSHBnVXQwS3JucVhBMnJ1T0YwaFdqKzlXbm5EUkFyd1dzb2xCQzlTMlVC?=
 =?utf-8?B?eHEreGJUQ2JmV1BOek5oYS9pVzdOUjc0NENSNUMyYVBBUUZYSUhIbmxKY0lV?=
 =?utf-8?B?UUNKSkVjdHZnVWJmK0c1Vll5NFFVaHhYSzlvK011dWRKL1ZLSnJPMWREYVBW?=
 =?utf-8?B?RHVlOGNHUWpCYTRVTlY1Qi9GS1lLVy9LRzFoQ2lsSTErWmJWN0lGVDdabDZ6?=
 =?utf-8?B?ZUcwa3psM3FTMWc4WSs1QVdEQTNqL25wcGIvMU5JbWlVMGp6Nk1DaFhrYW9U?=
 =?utf-8?B?QXRmOTlBTEZBaVpnUXVQci9meW9hK2l0dFZ4Y0trUnFHMU0wZ3FZUXRlYjBM?=
 =?utf-8?B?STYrS0c5amhUdzlRU2F5cjYxREFucmIwK3JHWTRkMThGZkxRZkJ0RXFSekNP?=
 =?utf-8?B?UjJvaWxzNGhDZlp4R2ppVmtLNmpOdlYyUDBEOXhJZHNZN05KVlRsOFBCcTFy?=
 =?utf-8?B?SXYvVHkrTy9RZWFHdlJRVGx2MXVob3NISDZJcEp3UmYwUXo2TzY2VHYrSHRC?=
 =?utf-8?B?MkM1a0FEMHEwdXc4eEMrb09QUGEwOWY1OEdvdjNzTG81M3B6TVR6OWpwZzVW?=
 =?utf-8?B?bFI4VlArY1hmMjZWNjJDNHN5MUtvSzF3VnFaRThvV3lhNkUwVC9DK0J4Wnlh?=
 =?utf-8?B?SXVaYUtCSFBuaEFuTXVDZXN0UThXS1dQWW55QTF3akQ5WlVLR0ZIOFN6YTBY?=
 =?utf-8?B?eEh3L0pXM291QlZGY1ZTUG9SZXhjVUQxM1FoajVCa1BZdG9jRlBZZ0pXQnZr?=
 =?utf-8?B?a1J5SzVjZFBWVW5nT09LTzBENlV4TmlPc1FoczFEVmk3cXdEZXY4dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d38b0e96-150e-481e-0bda-08ded124c2ed
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 12:41:35.4288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RyqLNorscTLEyzxqOZhiqmDKg1IVLP8AHylR6rTFQbXof8XKZEAzjop19DCH0SPYwjKvd2XZFYplxe8LBCEOIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3511
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Jun 2026 12:41:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23272

On 23.06.26 12:52, Shivanand Kunijadar wrote:
> This enables the support to build Debian sid based images in the repository
> including CI (scheduled jobs) which helps to detect the issues in advance.
> 
> I've confirmed the Sid image boot works for SWUpdate & Data encryption enabled images.
> 
> The scheduled job is created here https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipeline_schedules
> and confirmed the jobs are getting triggered for "Weekly Debian Sid build
> & tests". Once this series is merged we can change branch to "next" and
> update the interval if required. please note that a new CI variable is
> introduced for these builds (i.e CI_RUN_UNSTABLE_SID) and the same is
> being used in the CI jobs.
> 
> For the sid, I selected IEC security image as build and test targets as it includes
> all the features (swupdate, secure boot, data encryption, factory reset).
> The idea is to have minimal jobs to test more feature. I understand that in the IEC jobs
> we will not test swupdate, factory reset explicitly.
> if required we can also add swupdate, secure boot job targets for sid as well,
> please let me know your opinion.
> 
> At the moment, the security image build jobs are passing for amd64, arm64 & armhf archs.
> The test jobs are failed as it needs some adjustments in the `submit-lava.sh` script
> so I plan to handle it in a separate patch. I hope this is fine at the moment.
> please let us know if you have any different opinion.
> 
> Shivanand Kunijadar (3):
>   Add the default kernel verions in cip-core-common.inc with extra weak
>   Enable Debian Sid support
>   Enable CI image build and test support for Sid
> 
>  .gitlab-ci.yml                                | 90 +++++++++++++++++++
>  Kconfig                                       |  4 +
>  conf/distro/cip-core-common.inc               |  3 +
>  conf/distro/cip-core-sid.conf                 | 13 +++
>  conf/distro/cip-core-trixie.conf              |  3 -
>  kas/opt/sid.yml                               | 15 ++++
>  .../initramfs-crypt-hook_0.11.bb              |  2 +
>  start-qemu.sh                                 |  2 +
>  8 files changed, 129 insertions(+), 3 deletions(-)
>  create mode 100644 conf/distro/cip-core-sid.conf
>  create mode 100644 kas/opt/sid.yml
> 

Thanks, applied with that tweaks on patch 2.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

