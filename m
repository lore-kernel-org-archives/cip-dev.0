Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9554AC369C4
	for <webhook@archiver.kernel.org>; Wed, 16 Apr 2025 15:58:45 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.57])
 by mx.groups.io with SMTP id smtpd.web11.22703.1744819114811748139
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Apr 2025 08:58:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kzgFB+db;
 spf=pass (domain: siemens.com, ip: 40.107.247.57, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ca9+BRiuK1+MgsG6yohRMgpd8LORpZhF1ZhPxULQJyedpVaIDdefWRyx2SeoMuWVoZCfAYvwvwvMjX4LPWWHgU3rHIKt6BO12kxRx904GHwji8Dyixv1KVwQjOLs8NMeYAMsFZ1shgX+4VEHI4hwEVZvzzORb4+ITdpUPXGqYR7X5C1ThEpYtqT/QwS+pFZXx5nRvvkWe7qVfqSoRcbjP/FU8SMlwAVPjzjuX8EgVjZeCZcic+buNGunf99IOB5NPeg+2glr05LOjlOzWb4qMNJXnn4RJrnzCLSAv8Juz26Ia2038Hd04a6oMiiB8JwvNh6N0m7Am6Sul/8PCGUQSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7J8tNYQWMsbRuAZ2p47Ysazo1WNe00QpLoK15SOF3Y=;
 b=QszOLMmen6nkSGX5jrrQDLHLmKu54RcEYZPrjBoJnBLW9ZR0gEN//+rmkfR4QP/Sw65RPYvMH4kMYp0x3y1zSBjbhwRv/CmC03+DRKOFwcRq6cuDxyuGnX3+UqUe7CoDKVcTNtWs4IpGTvl5UyXLpp62FUtl+uDM5ZL0p50TjoU/pY6HtYgudK+eYz2DdmrEtJEaXygOVuuPrD8s2/brDcjfXTuP8QnYlMgsXHVM8la2ypGqj9AlYZflH83E1H8go8hNh6OiMoMe/aAmvKSUwaLoC5MUXRgtmjcesgYnqXw2YGl8JN2il5UujA5yOD0EYTcofqUyJZ4Dn/e+OirBlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7J8tNYQWMsbRuAZ2p47Ysazo1WNe00QpLoK15SOF3Y=;
 b=kzgFB+dbeFVjUHTH6BBaI+dlljH/Hl3muqQzqSq9LFA4MgKU1Hikbgg9VPWBxuXP7d0+yoIq+qy1u8/Xd27oXEVjeSZ96MCqxVJvfdzV4eZlHk0cj9Gtb8r8M6UbMfHqn29PYze7nKJKKWA0GLP9ve2CezfHATKISfm7zdoLoDf8APhjYqnqahDVeY45yrMIUGxRi+E+FVBMaKEgyFr8t+wL/7p1Ye0yHMbOk17GSHNtJgjfuQJ0ukOElm1SXbJzQ8mKFZJBwYK/2NyjwZD4y1833fsTSOzDdnOaiNTWgm3sWhYqqwy/o1nYE+CjTm8uIVRAHHTQs03EFc6gxQvZ/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6874.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Wed, 16 Apr
 2025 15:58:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 15:58:31 +0000
Message-ID: <20681ac7-eff7-4eb7-a666-805607d99f82@siemens.com>
Date: Wed, 16 Apr 2025 17:58:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v3 1/2] .gitlab-ci.yml: Set timeout value to run
 IEC layer tests for different targets.
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20250416145141.2678093-1-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250416145141.2678093-1-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::11)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: e7851ce4-5fbc-421e-5e96-08dd7cff88b1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?a2czSkpxa2tqcVZMcjJaeU1ZdU8xRGlkemd3NkN2QU5xUUNUeHI0aTJBaFJa?=
 =?utf-8?B?WXNNWDB0QjNiYjdLVGlzR3NqR0hGak5QeGJSTUxCcmRHWWtwTmpUUDBJNDJL?=
 =?utf-8?B?eW9naGlDVDhzVVpXRFNLMnc0UVNVR1BqQ3ErYjgzK2IzU2M5TGkyL29KZ2lF?=
 =?utf-8?B?Z2dEVEcwbWEyS0x0UUt2SkpLZ1FBeW1DSW81NGZ6U0FmK1JkY1NSWmJMbGZ1?=
 =?utf-8?B?T3ZnL1dmZm1RcVVCY01tT1ZXTnRneEVSMkhNK3pzQTMxQlVsa1RPRkY2TXox?=
 =?utf-8?B?SjZDMXdmdXJFa0duWlhHRUd6dWtVTjZtU050N1dERU5WdmpmV2Y3blZvV1dE?=
 =?utf-8?B?UTFqVlQrRFBVUWtOWXRCN3JqU0JrWEwyL0t1dHFnVDgvdEFkSW02WU1sM0Rn?=
 =?utf-8?B?YmtHTVZHY011MlZOaktQcnh0OVZuLzUyUzN0cktWbFAzQkoyaDlKYjNCSzc1?=
 =?utf-8?B?a2hoMVVuTEIzZ1lpeDNscFRXTkJtREk2cnBER0llT3FpdUgwOUVVeVoralM4?=
 =?utf-8?B?TjRvMnN5WjNEaGxHSzVhdUNiU05CVGlaZnBHQkRmL1NXeFl1VlJuekdFWnJP?=
 =?utf-8?B?L1VQQkd3V2dDNVlCQWRmT2lnVmVUenltMFRndEtFVkZsd3kxazBXK2tYQ0dC?=
 =?utf-8?B?YkF2anV2UXU3clVsL3VKSWxLNUZabkZUUlFhR3ZudHdFaFBQeTBxZStnWVVj?=
 =?utf-8?B?MnpLUGFHdkIzeWl2WFZVcWpkeGZjcjVhczd3eHhUdlROSzI0MnlJYmRzVXBu?=
 =?utf-8?B?cXAvUUkwOTRYYlJzZkRHS1N4NFRnVzd0ZFEyZmhTb3BnWGxrREFyaVJaMlhl?=
 =?utf-8?B?VDMzcFd4bEhibmRORjNXc2piQnlidkk3eFRISmtBMFkyZy9pNEZseDZTMTJu?=
 =?utf-8?B?OEFsbC9pRFV5UVM4Z0ZZRHd1aXNyY3ZaMEtDRHRnSUU2RVMzOEhNRC81eVdx?=
 =?utf-8?B?Y0xOd2VlR1RnRFZROHRHZVcwbXpLM1lGVnk2VTJRbU5BcGUrZXREREJHSTlM?=
 =?utf-8?B?M2Q5SzFFQ2Z4THZRaXpBUCtlNDloS0RhbDlnRFpNOXMzVFpaa0RMN0gwYVI3?=
 =?utf-8?B?a3R2elhoeXZ6ZUQrVjBmdlEwNWIrV1A0cGRpVWl6MDg0c0c3eGpSZi8wN3Bw?=
 =?utf-8?B?d1daK2lLcGU3T0tVcmI0czB4UlNMbmFuYzEwK3NWNlorWHZRU3NIb3poL1hT?=
 =?utf-8?B?amdpTzBhSVVGQW0zK0l4UGF2ZUFDeng4V0RxclRLc1RGK2diQk1TaVBJMTBi?=
 =?utf-8?B?c2l4VUR4VXNGTThTd3BuUGZpRjdoa25oUGorV09DaGZZbUVDMDJlR2loY0pn?=
 =?utf-8?B?R2lYUWRQT1ZPZWhxSTFxeEhHYVNGWFhmaytEVjdVQ3d1MFc0ZTg4MmFlVWo0?=
 =?utf-8?B?YUxCd2tqdUN3VjdIb0hQbkFJQ2k5ZHI1WDBnU2h5NWlJTlF5RTZlcTlpa3Bk?=
 =?utf-8?B?M2pqamhiSU82TWdrNS84ek5mZmxXVjF3OU9tQzdKQmtZUjI0ZFVBWVZIUWF3?=
 =?utf-8?B?TnV2RWJscUV4b3JkQXp2RWhUMXRSalhPQVdIZ1NNVE5Fdmh2QXV4bmxiTW9Q?=
 =?utf-8?B?ZGNHSFdpcG8yV1RjOFRkR2Ixa1dkeTdYZHdLc2JBaUJwekNnR1ZNeTZ2SmdK?=
 =?utf-8?B?cllkRWJ6cE9DSjZ4MnU5dS8yazFoY3dmTVI4QWprZWd3VkEyMHJVVkVxS2RY?=
 =?utf-8?B?QnNNRnJJeER6bVhFQnVkc0x1bkRWS200VXV2WjQ2QnB2U2lxaTlkelFMNmVW?=
 =?utf-8?B?ajYwZ3JtWXZmR3hLSTJLaGxpa2lHZDNoNVVkVkRDZyt1amIwR1BoMEJ1TC9R?=
 =?utf-8?B?R2Raam1xWkZJbzlaYkhBQ1JnM0hHdzhWOEV3NE1EL09DeTJRSDZjN3BTR2hO?=
 =?utf-8?B?MHc4dCtkTzEwd00rMTF1a3dMREJSWmw2VXcrUXhZWmcxdFBVSXNFK0JvRUV4?=
 =?utf-8?Q?O9hwrg1LW+I=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VTJXbVBUN1A5Y3BFdkUvdUxsWVdqYlM1SDlnYmJCSWV5WnA4VFdDS3BJT21Z?=
 =?utf-8?B?ZjEyenJldERDMEhRUWRzd1l4cERWVmtrYVFGUjRZTTNRd2pjejBKdVJOek5q?=
 =?utf-8?B?dllJUFJJQ0lhZEQxVFlmNXZ5NFlEckpCQ2gyNWdRY08rcWVNTWJGSXhJM1Q2?=
 =?utf-8?B?YzkwR0VjT3hVSXRpYUt4Y1hzcDNxakRlUVNHQmY4Q2dzeDB2d1NETmt6TjFD?=
 =?utf-8?B?NG90R3l3dVMzNXkyZDFmeTRkNzlWUEdFcEp0R0RmSXd1QzNNMHN1akd5dW13?=
 =?utf-8?B?cWJKNzV6MTdocVBibDg2NWdpTk1YV3pidkJpbUk1ZmxlYW9xT3dQRyszUWsr?=
 =?utf-8?B?bFRjczlDY0NGbC9oR2N1NGFITHBNaEJyY1g0aHV3djUzVGc3d3RsTHplTVIz?=
 =?utf-8?B?UUxHelhOMUg1eHI3SlNKdXhjRHBQUG8zNFdVemcwRjZzVmliZWd0b0NScG1L?=
 =?utf-8?B?NDAzeXlZOUtwbTlOSm5oZGpBMkRnY0tVdW1XeFFYczRJMzFpSFRoVFZkOFl0?=
 =?utf-8?B?bHJkNnlSS3VrU2cxaXFYeUIrWWlpRkN4RGU4VWNTOXVqbE9EYWJQcE4rS095?=
 =?utf-8?B?WXhKR0hDdGNOKzdJTnE0RXliSytWS2x5TzRTaE9zK2tzbXhBRVRyV3lPalNh?=
 =?utf-8?B?S0Z4bGhsaUZkanprNyswdm1GVXIwWFhtRk90WTRjaFZ2NnIvMkJyTFNPY1Iw?=
 =?utf-8?B?c1NpaW1IRWFRWDNXNFNrelA3L2VvTG9NTWlPeHZMS2lwRFZPeTBrbWVIcVVm?=
 =?utf-8?B?VG5NOFZ3WmQwWDByQTQwd0cwanhBemZzbXhaMERnZDJwYWRVSGlHdzloYWlJ?=
 =?utf-8?B?K3kxSHJ2QVdJdDZJUzhmRzBickdVRExoMDVvUXowQUNoZzY5Ny83UUN2MmhL?=
 =?utf-8?B?MXVaQUljSkdUMXJQMThkSDJtbTErQzQ3eGQxaXpBMTUwaGdOc25mdWZVSThF?=
 =?utf-8?B?ODhFZFJMWkdVWHUvNXcxdDE5cFBhOG9VNS9rSHBZaE9ySFZxSEZSMDZDRXhi?=
 =?utf-8?B?eDBDQ1pZNlJiYXdoeGQyaFM0M3pka1hUNmYwbEZ5MitEVDZzbXU1VTNwTUhz?=
 =?utf-8?B?aVdBTWZhQ3lGN3BsL3M0Uit2SzFMWCtpNTlhTTRtZUoxQ2FYZllCcVJtaTlK?=
 =?utf-8?B?QUdYbXJyZlBzaUVCODJITjN1aFluWjYvR2V5N3pvYlZNSUZlZlZLRzNENFJC?=
 =?utf-8?B?K0Y3UzczdDNwc05ybmxReDRvNVRzVnVtZUpzTThsa094VjdBeWJsOGJQRXcz?=
 =?utf-8?B?elRodUxTSmJuRlY4U21obTByaHl4cGwvZjZCUGlTRkZodlFteEQ5SmhDaUxi?=
 =?utf-8?B?K1R0TzFBZVFvK2RNWXNVWHNZWklhNXVPWmJYUFpFeFRkc1pwc0ZUNGVUYXRs?=
 =?utf-8?B?YzdpdEQ5Q21lRldRclRwNnUxbFJZemhhcE0wU3hoZVFOYmh0SWxNdVdmNEVU?=
 =?utf-8?B?cFBYZ0U5RXRhbk1pSWNpNEphdk9VQVVCcnB6S1h5SE91dzlBOWRGWHBIZDMv?=
 =?utf-8?B?aEJvYmdabm4xL2w0ZDFtNEtSd2RNRDhzN3paVHhUSnFGQXQzOFJaazJiSkJp?=
 =?utf-8?B?VlRpbEVMeGZlS3FCanRIQVM4VHZjTTV3SXBXZnFoQzViOEtXRlZvQm5hTkdv?=
 =?utf-8?B?eHdnblV1TUJ6YXdDN2tEVlFzNWZmbDljbEdXY0F5bjN1UFhWUDdicXFpTVA4?=
 =?utf-8?B?a3BlbFVzRW1KYmI1R1ljWUg0cmJia2lDczJzN0RvbFZVcnNqUGRUeU1QcUdM?=
 =?utf-8?B?Y3ZOcHkyUUx3TXRwQjlLeWd2aDI3MHZaNkg2NXhBNDhnMVduWU5BNUl5eFVa?=
 =?utf-8?B?ZDVaVUl0QjEvcGZEU09ER3BKYkEzTVp1aFBEVjhacDF3K2lXQVR3UFNwRWtF?=
 =?utf-8?B?a3RIWnpOUTh5YXdjK1JEUXdwaGF0VUJvSFhrV1NXQ0xDTDJid2Y0bnlwRTNT?=
 =?utf-8?B?Tkpqa0pFdWpnWVNSRVlPMGZ2bU9TSVBoUTlTRVRmOHVSMjRPMndzNXBjMkFC?=
 =?utf-8?B?V3hnY1hLeHhJcXlHUEhka3VGQXRkNWhsMmwxTnRjdVFuTDFHZjBWREhBeHp0?=
 =?utf-8?B?b2VTM1A0bnJOWjRyTDhNSGZJUlVmYnVxR1Z1cXd6VXN0NlYzUlM4WU5TSHhC?=
 =?utf-8?B?VmozbE1nVjZwMTNuVkVSZXBQVEdOeGVKU1BlYjloYlBOSEFkVkJ3WGlrRnFr?=
 =?utf-8?B?K1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7851ce4-5fbc-421e-5e96-08dd7cff88b1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 15:58:30.9414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ag8E3IY1RC3jw1ZK9hrk0umf8rNY4c/AvZe5duJmgq06Y3Pt1qFhPFreexANVAolRf3sttxt6CA47FcrwqNnSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6874
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Apr 2025 15:58:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18513

On 16.04.25 16:51, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> 
> Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> ---
>  .gitlab-ci.yml                   | 6 +++++-
>  scripts/submit_lava.sh           | 5 +++++
>  tests/templates/IEC_template.yml | 2 +-
>  3 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 146eb33..2c1deaa 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -334,7 +334,7 @@ build:qemu-riscv64:
>    tags:
>      - small
>    script:
> -    - scripts/submit_lava.sh ${test_function} ${target} ${CI_COMMIT_SHORT_SHA} ${release} ${CI_COMMIT_REF_SLUG}
> +    - scripts/submit_lava.sh ${test_function} ${target} ${CI_COMMIT_SHORT_SHA} ${release} ${CI_COMMIT_REF_SLUG} ${iec_test_timeout}
>    artifacts:
>      name: "$CI_JOB_NAME"
>      when: always
> @@ -431,6 +431,7 @@ test:qemu-amd64-IEC:
>    variables:
>      target: qemu-amd64
>      test_function: IEC
> +    iec_test_timeout: 40
>  
>  test:qemu-arm64-IEC:
>    extends:
> @@ -439,6 +440,7 @@ test:qemu-arm64-IEC:
>    variables:
>      target: qemu-arm64
>      test_function: IEC
> +    iec_test_timeout: 40
>  
>  test:qemu-arm-IEC:
>    extends:
> @@ -447,6 +449,7 @@ test:qemu-arm-IEC:
>    variables:
>      target: qemu-arm
>      test_function: IEC
> +    iec_test_timeout: 40
>  
>  test:x86-uefi-IEC:
>    extends:
> @@ -455,6 +458,7 @@ test:x86-uefi-IEC:
>    variables:
>      target: x86-uefi
>      test_function: IEC
> +    iec_test_timeout: 60
>  
>  test:qemu-amd64-secure-boot-unsigned-kernel:
>    extends:
> diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
> index 9da083a..028bad8 100755
> --- a/scripts/submit_lava.sh
> +++ b/scripts/submit_lava.sh
> @@ -24,6 +24,7 @@ TARGET=$2
>  COMMIT_REF=$3
>  RELEASE=$4
>  COMMIT_BRANCH=$5
> +IEC_TEST_TIMEOUT_MINUTES=$6

You can export already here.

>  
>  if [ -z "$SUBMIT_ONLY" ]; then SUBMIT_ONLY=false; fi
>  
> @@ -55,6 +56,8 @@ add_firmware_artifacts () {
>  create_job_qemu () {
>  	if [ "$1" = "IEC" ]; then
>  		cp $LAVA_TEMPLATES/IEC_template.yml "${job_dir}/${1}_${2}.yml"
> +		export IEC_TEST_TIMEOUT_MINUTES
> +		envsubst < "${job_dir}/${1}_${2}.yml" > IEC.tmp && mv IEC.tmp "${job_dir}/${1}_${2}.yml"
>  
>  	elif [ "$1" = "swupdate" ]; then
>  		cp $LAVA_TEMPLATES/swupdate_template.yml "${job_dir}/${1}_${2}.yml"
> @@ -163,6 +166,8 @@ create_job_mcom () {
>  	cp $LAVA_TEMPLATES/M-COM-x86.yml "${job_dir}/${1}_${2}.yml"
>  	if [ "$1" = "IEC" ]; then
>  		grep -A 9 "# TEST_BLOCK" "$LAVA_TEMPLATES/$1_template.yml" >> "${job_dir}/${1}_${2}.yml"
> +		export IEC_TEST_TIMEOUT_MINUTES
> +		envsubst < "${job_dir}/${1}_${2}.yml" > IEC.tmp && mv IEC.tmp "${job_dir}/${1}_${2}.yml"

Can't we avoid this duplication? How about running envsubst
unconditionally on the final yml, just like xenomai-images does? That
will allow us to use this pattern not only for the IEC cases.

>  	elif [ "$1" = "secure-boot" ]; then
>  		grep -A 1 "parameters" "$LAVA_TEMPLATES/secureboot_template.yml" >> "${job_dir}/${1}_${2}.yml"
>  	else
> diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_template.yml
> index 92944da..c8efe40 100644
> --- a/tests/templates/IEC_template.yml
> +++ b/tests/templates/IEC_template.yml
> @@ -60,7 +60,7 @@ actions:
>  # TEST_BLOCK
>  - test:
>       timeout:
> -       minutes: 40
> +       minutes: ${IEC_TEST_TIMEOUT_MINUTES}
>       definitions:
>       - repository: https://gitlab.com/cip-project/cip-testing/cip-security-tests.git
>         from: git

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

