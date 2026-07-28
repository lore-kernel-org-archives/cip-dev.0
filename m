Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D36C54F4C
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 15:29:23 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13981.1785252557380249747
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Jul 2026 08:29:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ZWuotE79;
 spf=pass (domain: siemens.com, ip: 52.101.72.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6mI88i1beUX6BuTv1Na4avNOexY4YFAqsqTI/vo/SW8MPBsK75CnEQ3pJ1pDBgJzs+22Rk5S2Rx8WhmwOWpKqhpBv5s+RANhtCB2lRwP0VxgSTGm4enO7hfPWs6NeyNm4Fy8qk5sTBOpW+UuzjU14TE20F9i0Kdgn1RgSg780R7WoNM3u7QAoGV91vfxQLCecxC/iWtgA6vEiwbwpMPbILy5BdpIxBQCn02n5KupN9S0OnaDpldr7T3+qdN7uam6U2e8b1CRIdHsW1TPyLzkzDhzUWlg57Qp5N104JieixRZmxqf+u/nUb59h7YcxttmlgW7sYaduZrdhZOSZWp4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lme2EQJWIWFlQICqSvyBBk1XFCnjflQ8bnmjkuPNrYg=;
 b=j6ijqxIIljeFnfmktDCO+GEW5CG8mEB55lLR6A/X9sXC2gIGTvEX4tldlkduJ0PdOE9M8TovNrlZKBS9t8RSzEeMDqFJrmkNVnaYm1PisDZ8GXpajkq+viAfv/VnUNpVcTccLPIO93D+mo4DiN1r97jgrEATu7iUMa43apS2bCKjjIf7AHzviokJqse3+pmOo0mZHnK1TRUVbjWEIMlHSJswxnDSmvZJkn2b+EHGEGnny6heIQ67BaWkw1JS0eiwt8UVA9BDA9mJNExP01p5Ll44IcoLAwAAwupBr3/w272gmYVRN2nPtVDpV7BL2aRA5spxFBHqqJ0TUHAK5d7zMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lme2EQJWIWFlQICqSvyBBk1XFCnjflQ8bnmjkuPNrYg=;
 b=ZWuotE79nxYlXe+GgWfdsB26qDwBmECLiIDoFsjoFelpv8swH/Dwny5thSHh14yKUGJ8QO/T17KQCF77iabJzG6/wsgeeoexjX1vlbyM9uMOR3jf/8npMtl7hvK22DiBdNwnosijbY865QB6aTWUAIANNr2jd+H+a32omDU0i9tqoVNqkqXLergWRmZGHap6QBt3vwW6hWeZ/RRM4lR/tVagM4d8aBuwF4NBL5e7nIBVdfsFhNUDZ/QkyizfLU+bG3R3tvoN71qEYjwbKwA5q5gqtaa8LnmNLvMgg2k0nkYLyw0vGebQvN1aIWiNVh+RMRecur5ic7XY+qccJ1s2ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3213.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:139::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 15:29:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 15:29:12 +0000
Message-ID: <1fc13594-a7c6-421c-82fc-e8953bd07458@siemens.com>
Date: Tue, 28 Jul 2026 17:29:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 2/2] Enable CI image build and test
 support for forky
To: Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: kumar.dinesh.h95@mail.toshiba, kazuhiro.hayashi.f74@mail.toshiba
References: <20260728085519.3615499-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <20260728085519.3615499-3-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260728085519.3615499-3-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV0P278CA0086.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2b::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3213:EE_
X-MS-Office365-Filtering-Correlation-Id: 881e24f2-12b8-48ec-cc86-08deecbcf9cb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|18002099003|55112099003|22082099003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	DTUZBxZrsTHwcP/m/pkRCKz4yzAtwYP8+yK/466yZRSOVAZRRVs/VlhInHTchCL+6FKAJKJHo6Sc/o86yGkJuNYEyDZoRKZBAr63fY6ITuPdyGCgQROSTDPKqeH4JHfp1OP8BXiroRJ/PM6kSOEq+E07NQ1F3pQdGu8YaC0hmHz1G1jiMX95LKJOZQGMcAJrWmZCaspRTEHO0hLZC7Fh0m0luwRp4PSzu0jUQbA+DSeek76JFgpZL1UZMcm1gyZUBgzaTwADwRgqjvMletyCYVEM9OXJkhlZZmKYYi9qruiLwLRtOZodrA4hBDkLPgZG0kUlxl6cRIiVmQe8mX6Wf+wgf+Y4H1T6+2RnRhBjhsBQLy+rPYcUk8oirs9FCdxX+lN/H5tL9HeEoFcQL2Sg8jOfRLmH7K8TqoJrwN9ZxSRtIcDubA42l4mZEMSSr4Rusz3crRhNbQ+dpTOoGDIZ/gAzKzIGog07sU4gzUyyvPY/1fhqT7mb3CgW1NAK98MRtLBBH0XSGHw3wgzgocbtSGWONkPb5YelLwaa2wI/Rl4XjoS6J8wZziN9q2UdUNV8e16ZR3aObmPRgC5CdnN9wxX70wNzfqxqKbT1oUAX5lxPShGw48eKtdUFRf6ALxvpk3GYgVO//wY6LUldAyxwhhGYtTQs3mhwAR2Pv4gGwF4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(18002099003)(55112099003)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cFBZZUExUmorTmUvbmNnR3BDamI5UWpIRm90aHJmaXA2eVlSSTRJMEpQU0RE?=
 =?utf-8?B?NllicVR5OUZ5MUNlMEc4Y0JYVllzdURoejdlakd1MFdERVZrYTVxRVkxYXFW?=
 =?utf-8?B?NzZ5djNoYUlWbVdRbURySWxjWGZwWFJSSjVaWWFzTHMwbFg3VHhnY3l3Qlo3?=
 =?utf-8?B?R3RNbkRDOEM0MUNUNmhra3Nob3IrSzVMK1lZNDYzSTArWko0WTB0M1hnVWs5?=
 =?utf-8?B?V3loRll4c0NtMmlDaU1mVUkvSzhmYnBJd3crclZvVVN2eDVTMHVKNkd3U2lB?=
 =?utf-8?B?SCtaRmVDa2NrblVqMG1MSGFTNnhqNmlVL0gzL1orVWdoU0NmRVpHOHc5Qmpu?=
 =?utf-8?B?NVJEU0h2Zkc3V21PWEhUaWRlZTd3S3ZPa0hXcHVVMkhWSUZtMFlJa2N4dTVi?=
 =?utf-8?B?ZXJiWEwrZ3RUaTY0SWlVMnBSVWw0YXRaVjNObnZ1ZDFMdWtrSDhuT0Vmc0tN?=
 =?utf-8?B?MXFYMFJxODNKT2IxdWdUakFqM1BZSGR1ZTdleWpqQ2hyekNBdDJnWlQ4b1N2?=
 =?utf-8?B?TjVxdFRyYjhhQjViYy9SRXVqcHRhRlBLWmlrWGRKbkpTYy9CQUExMHE5TFJp?=
 =?utf-8?B?OGNJaVZSRjA2ZFJWTUk4OXlaaFJFeGZxNXN5ZWs5NWE2TDBZZ2RUZUxRcUNy?=
 =?utf-8?B?ekZCK3ZSWngrRTZpQXRxaEVuc2hmNkYwaUVKM3IrcldkdCsyOXZnRS8xdVJY?=
 =?utf-8?B?b1hnbC9zajgyc1hyRVlUYnhmcmZJQXVqSHpzNWpvWjBSS1lwT3VuUUdDbGFx?=
 =?utf-8?B?YXBJRUcwNjFPQ1RQT0Q5UUY5dy9JYjdsN3g5eVd3TzhmZ1NIVGxieGRwaENt?=
 =?utf-8?B?MUxSeEk0ZW9CWkxJUzdMZmhmT0FHQW1JZFcrTzJTdzJMUU4wSVAycGI3SG5K?=
 =?utf-8?B?TVRtVXBRVXlWZm5WYU1zZGdPc0RrcEVQeGp2WjNWYmFNWmVNMjlaRVJzc3Yx?=
 =?utf-8?B?NUhVcmVyOGF5dm9WRW5xUXJkc2hrYXNLQUVxQWVSQ3hleTFrL1BncDl3M1Bt?=
 =?utf-8?B?eGNaOGVwNzhMeXF0amxaSHJYb1E5OU55RXVmN2cwNUk3ZXIvQlpFLytlWEdZ?=
 =?utf-8?B?RVJmZWR5ekdjY0JpZFdWN0l0OVprRmNzVHhNdUZrVUc2dXdWZTdJR3dWQWxT?=
 =?utf-8?B?M2Z1bHgrcXZjK1UzRWhNQTdNdVRiNmp2cjVKWFMrL3pSU2wwNDNiM3dWKzUw?=
 =?utf-8?B?ZVljczlhQlIxbU1PaXZOYlZieiticHNKZjE1a2gzbTNsQ0FwRFBiQ24vb0RW?=
 =?utf-8?B?cnhUTDRYZ3NBSVN1NTVoOXRnd0lTNUZVNGxDcXBXSHNOdVFaMEFLNzI1OHFK?=
 =?utf-8?B?V0dOVkltblc2ZzlSZmVlWUlEemdrdUxETFBEaGkrMDYvbnJ6NG5ZRWxaNVho?=
 =?utf-8?B?bWJYQWprVHJtTUdsRE9rV21DSEpvVk0vTDZ2cHBxN2Rid05ld2FQWGRkM3Vj?=
 =?utf-8?B?U3pjOFdQS3VBN2IyUTRqVldOS0ZUVEhhYkppRWZoTGh2K2NjU3pYKyt0STBI?=
 =?utf-8?B?VUJpNUtQSGZualptYzduUGRXNzBvNkg1elNUVEIrWmpNWTRJQm5qVWtBMzMw?=
 =?utf-8?B?L2RZOC9uNnRCcVZwSGtKQ1g0VVhWS3FUbmtpU0FBNGJnNFRDUk5iRmxqYlVF?=
 =?utf-8?B?TzRKd040RGZkN2dJODZtVG02RmRZQUxST29aMGdka1FscjVsTkFsOFlyR3or?=
 =?utf-8?B?K2RhcXVrQXBVUVMvMnk0eXNBOW1uRGJuS2dodm9iR2EyWnFxRWxuYThvRW5E?=
 =?utf-8?B?dGNVKzQ0YmxCY3plT1ZZT3ZJV0o4TTVzMWovcm9jQUhzZmw3aElrRG9Lcm5M?=
 =?utf-8?B?WEJob1lkUzluRURiQzNJNGsydVBGK0VsV05VVEZBSEFnK1VrcmwxSmlnOEhC?=
 =?utf-8?B?NVRxaklaUEdnWEJWenRGem9IUXVvbVBKMndtNHNlTURueVFFcXNtUHNOU3dM?=
 =?utf-8?B?cS9aT2czOWNBUEdWVzZIalV4UTVJMzBHV2cyTHBQYWdYMG1SK1l4WXRBT1Y2?=
 =?utf-8?B?by85cmplMHhpVEdDTk1HUUFRL3Y4anFrNk9IVUVDdktianQ2YkN1OG5kM3Bz?=
 =?utf-8?B?ZkQzYlcyZkFOQ1N4cXlib3cvNmd6QjU5RUplTVdZenBzR01OamVjOS83eHFs?=
 =?utf-8?B?QUJZMnErcTJjOWZ4ZjVDNC9lK3VNRm9ONlFDdkxLdC9BczFtbW1uOUZXdjB2?=
 =?utf-8?B?ekFMVFZwR3N0OTJieDNBa3RZdjJEclAxSkw4TUx2c0NiV08ycDB3NGtmR2ZL?=
 =?utf-8?B?ckJxNzZnZXZkakNHOFpyZE9QeEQyWWFPZGcvbGlYU0ZIL0wwTG1TS3RnejVH?=
 =?utf-8?B?UlVVbGpocUovcFdMbGdXTlVod1haTitNNnZmNERUZ1Y2SlgvTWdZRG5BaUNE?=
 =?utf-8?Q?kt33ctUyN4BPtWT8=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 881e24f2-12b8-48ec-cc86-08deecbcf9cb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 15:29:12.4438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: INQ91smg9vy3JHpElgg7rPdqSuhJ3achX4o/+XhPAojeFo1tiXjbyiXPs2fCObhfMzKOxC712yGnhmbybQtJ/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3213
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Jul 2026 15:29:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23804

On 28.07.26 10:55, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> 
> Keep these jobs as scheduled and can be scheduled to run every week
> just to monitor and fix if there are any issues.
> Also set allow_failure:true for these jobs as forky is not officially
> released and there will always be some build & test issues.
> 
> It includes SWUpdate, secure boot & RB tests.
> 
> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> ---
>  .gitlab-ci.yml             | 148 +++++++++++++++++++++++++++++++++++++
>  .reproducible-check-ci.yml |  72 ++++++++++++++++++
>  2 files changed, 220 insertions(+)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index b53def4..b15c5da 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -8,6 +8,7 @@
>  #  Jan Kiszka <jan.kiszka@siemens.com>
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  #  Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> +#  Shivanand Kunijadar <shivanand.kunijadar@toshiba-tsip.com>
>  #
>  # SPDX-License-Identifier: MIT
>  #
> @@ -63,6 +64,7 @@ default:
>      - if [ "${release}" = "bullseye" ]; then base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi
>      - if [ "${release}" = "bookworm" ]; then base_yaml="${base_yaml}:kas/opt/bookworm.yml"; fi
>      - if [ "${release}" = "trixie" ]; then base_yaml="${base_yaml}:kas/opt/trixie.yml"; fi
> +    - if [ "${release}" = "forky" ]; then base_yaml="${base_yaml}:kas/opt/forky.yml"; fi
>      - if [ "${release}" = "sid" ]; then base_yaml="${base_yaml}:kas/opt/sid.yml"; fi
>      - if [ "${encrypt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/encrypt-data.yml"; fi
>      - if [ "${factory_reset}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/factory-reset.yml"; fi
> @@ -399,6 +401,57 @@ build:qemu-arm-base-sid:
>      separate_home_partition: enable
>      deploy: enable
>  
> +# forky image builds
> +.build_base_forky:
> +  extends:
> +    - .build_base
> +  rules:
> +    - if: $CI_COMMIT_TAG
> +      when: never
> +    - if: '$CI_PIPELINE_SOURCE == "schedule" && $CI_RUN_UNSTABLE'

I meant we should migrate both forky and sid under this one
CI_RUN_UNSTABLE variable. Now we would still have two of them and would
need to set them both in the pipeline schedule.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

