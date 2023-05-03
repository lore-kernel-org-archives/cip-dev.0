Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F61C77B7F
	for <webhook@archiver.kernel.org>; Wed,  3 May 2023 08:05:28 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.88])
 by mx.groups.io with SMTP id smtpd.web10.13683.1683101121404536415
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 May 2023 01:05:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=jXxQDbYM;
 spf=pass (domain: siemens.com, ip: 40.107.241.88, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgHyuYm5Wtwas0VVkjXm2q97cOjw2Q2F3eVnYgqe4+nK/nshgr0cv8KWEJ2rrWOifoGmlF1rlmbjjXzUILz0OCNtUQy9Uz9llrgB35b+ACkNwE/h7n3OYT1WQb7qrzC5k81aMmhT3EaVdCqHTAXpDdJO8oAEWHRz7tw1lMTMN2Z2U19OM6HMfB/4U5njgPnbwT9dN3dZaYOgQDEY0pGVXP2v3nS+pbjKaR0LktYW8NoPOM34hMz7HbjBfIJ8ZIijaN5718UnoupBv0O9GdPdmJ1kuJgb91m15vZAGp0WzrJD4dTRxxgxAMZdgUaxt2wqwthnPQACMkPoLW3pHyrIGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgBLFGhY1nX2e50KI2FKutetmSyIkNIIhD+Mg0G7fbs=;
 b=I/tQz1OErLTE3RoUiEgtls62QKEgU5BVIDCXDfyjH36gEEMAcyUsWEXyAhN0MbS4Rj/aeCbG1/UZ6OY+TDqLFRedPunN2LRTsTEsd9C2nUvoHLVH4GSgRFyFpyQjwFzBo44hpQ6hP7RcgKVD0tIyELIcpnqGGJxRWtPhDE6x++kOTBpxUhSrOaqytSeilWb0/F9yLdh8SZUteo6tzNg5pt/yEEGMqGtAaWKHsOe0ooJDULA3fVBaURdjo6Nfi8LuSVAB/6fNaK7LGdYJum9DQNy9eY2zjsCPrZJ1KH0DIuFATWTbgqDwOqq7Sv+tnvYK+RSKPzhucZR0xTY4F6wvvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgBLFGhY1nX2e50KI2FKutetmSyIkNIIhD+Mg0G7fbs=;
 b=jXxQDbYMMTQnDAPA5V1MwYXt2jlx504yR9Df5RO4KMCzyFULkQZJejuGgZ6jFYdWGTvrOAXmFV0eXkR2TiJc1fOf6wKNdkYuamKGxIOaa7mea2nB3vyb9y4zuV/5ASV1RdvZSyRlFPmA2WTuJk98i64U4AYwJXBiD+aDnS+u7aZPOW/t/tnecXo70FxY6Vn+heDyOwKXU79I29cFBgglN/KtbLvauogFeRcLyju8bUKZCwaUvLmfCcw5w9lt2o/khktfwp96w7AHFrtSh10D+8GkL9U5ZWyAAaZKHpDNcYHy9KuKsDCrWSH9dKxt/JTAMgeRV18uxHxrZj7MBaLCTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5150.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.29; Wed, 3 May
 2023 08:05:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%4]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 08:05:18 +0000
Message-ID: <23e4e9b9-bb47-a84c-b52b-ca7528d4f269@siemens.com>
Date: Wed, 3 May 2023 10:05:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [cip-dev][isar-cip-core][PATCH v4 0/7] Fixes for secure boot
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20230502153759.1284906-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230502153759.1284906-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5150:EE_
X-MS-Office365-Filtering-Correlation-Id: 2255446a-ed7d-4ada-0a1a-08db4bad2244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	GJTnyf4VdmvYtEhM0rLwFl+PJTODwIJ2ABHCULpCvFkEfKLZDy10ONBZUTPMQ9Xon4FzkFxQ7D3QKaGBaXj2PRU0U9dwzdRn3pBZ8QSUDu8BFemJfAY3Yvu0Jm7J1ncM4Ihxjn8DsymV+ABHeXgklPjmPSR+OQATOHPnIvAD2y6P0TrVA/zza5Jm18L4LmnFBU0IyIlaG52AwRKrXkRLRnkoIhaRTTQPs6Q62q0qOTmS0IZUS74qPPpPEyCIzPzooRS/AFAQHN/AIYHO1aNKjnC2Mh/4dW6V/6xUDB1XFjS8hlvLB6ZZ390Jzx4uQ5RrcSPwDp3NFLdgAudsLbxcEhRZK9b6nNnHJWZMG4aUsqSYYCX9lnubqhXSq5/ng7mJYeKuOzJBhqybZTM/LCzhvbwoM6y+1+rPr4FH95IhgB4sJgexeugPpZ9MRjbfoRJpICqgxC2Qt0CM2ib/cde3FLQDRA5sfAlHN5occSrEfiKkYY/F/BEthBKMoSJJfqBNRs70esGVephLUYwnMJmYkc5Mxvv6cDgDWRdm+yfYGkgb7zuX8/MoqANpfU1n2A55V1qdUo5rNBRis9uXe+RLQm8jk9zoBo2BfZaHd7RQxfxeL1XEMpusj+tq33U6ryMXryjZY/lOZMKTVsNVEMqo8g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(451199021)(31686004)(6486002)(66946007)(478600001)(66556008)(66476007)(6666004)(19627235002)(86362001)(316002)(36756003)(83380400001)(26005)(53546011)(6512007)(2616005)(6506007)(41300700001)(8676002)(44832011)(8936002)(2906002)(5660300002)(38100700002)(186003)(31696002)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WHIxMlN3VnRvMHRDVDVRbnJyZ3FjSVYwc0Z1V0x5dWFDWExmeHpZQTRiRVBY?=
 =?utf-8?B?T2xjS1JuVlNOZjBFaXlSSlJaRGNFLzhCSkdQVm53emhaV2x1bjFZWjFmcmZH?=
 =?utf-8?B?QnU5OExkTFJBNEYxbGpWY3FuSmpNWFBlaHBxMzJIaGpEKzZqSDFXTmQ1TVdm?=
 =?utf-8?B?TVpwS0Q0MnljZGlEQjM5Q2tlY1NKRWZQWUxwU0dwc3FCMUFkUTZXSjJlWDIv?=
 =?utf-8?B?NytVVDR4NzM5aGhnV1hqdVQzVmF0YVFNa0JXS0RyMkhvSlQ3Q2Y5OXZ3SmdN?=
 =?utf-8?B?VzNQVWp6N0FXOXBadkRQUE81K1A1eVA1NUNvanpXOCs1akxTcWpoNDJ6bWxj?=
 =?utf-8?B?L0JxVC9mWXEwaDAyM3JzKytkbEpidjBLTCtzSk9XQ0Y5SC9nSERHVzFXM2dM?=
 =?utf-8?B?d3dhMzJoY3RKQnRsbGU4UEdsVnRBVzZJSU1sU2RmVmxrMUtxb3o0VEhQZXAv?=
 =?utf-8?B?QkNobGUwRHhQYVVCUis2OURnSXR2YklxdDVEalJzL0c3OGlPVlNOL3N5OUxR?=
 =?utf-8?B?U0xlamRjZDZETE9MRFk3SWp5UGhCOUZnRHhrbFNrYnNYSXpPYU1Cd2RpK3pW?=
 =?utf-8?B?MmVDSU41Z1VqZ0JKcExiYlVvTjJsMGllcnRrK2dlNlRKS3BBaHpBSGtIZm1B?=
 =?utf-8?B?eDA0SThUNDUzUmtkcENYbHp4T051UFdhV1BkY2NzTjdWOVdtaWxHeWpZeVRF?=
 =?utf-8?B?Nmo5TjdPbGtIUURSQ0RETTBzTTYvQ0xkVEJJWUl4NDZPenN2aTdTbitCYVI2?=
 =?utf-8?B?Um9lN05MZGFobnlqNFFWS2ozTytIQ3FSNWN4S2x2OUFFVW9jT0NvN1R1OC90?=
 =?utf-8?B?amJMODVvaEJHQnFONlh2REFFK2ZOb2RvVm5rSWVqTytSVG1FVkRQVTNjOGlp?=
 =?utf-8?B?bnlybTB3ZXhZdnA3enFZc1R5SmlPM0tlOUNkY3FveEZWZEVCYnRDOUdZQk5v?=
 =?utf-8?B?OTQzaUZaSEx0TlRHR000dGZvSDRPL0F5Mk9wRG1MaEpTRTNMaTdPNkVCY3Jm?=
 =?utf-8?B?NHhyaVprdVRvZTdzZ3JuL3pTSlRNdGczNUk2V0xpYlIzUFhYZ0I0UWdrQ0pZ?=
 =?utf-8?B?MnVqY0xTWDFROVUwWXB3WEN1RG1xcVg3RzUvYXd1NzRHRzgwcVplTDM1TVVs?=
 =?utf-8?B?Y3dhVnFCaW93bWtyRVd5VlI1bDh1TFdpQUY1Y2lqSEY4ZFVERExtdWxMYll5?=
 =?utf-8?B?M2loNmJYSjFDcUlHUU5ZbWZ3UC9xRUR1NEFtYkx4SDBFdDVFS0dqU0VCK1o4?=
 =?utf-8?B?alJSdk1UNmlVektidjk3Tml3ZGRBRUpJdFQwR001MVJkdE5VWGdWQUFXbjdm?=
 =?utf-8?B?MEFVV3c4N015NEwvOUE4MERQWlU4WkdYYWYrZjJNZ3AwR1pTVHJnajNBRmw4?=
 =?utf-8?B?K3hQU3UwN1p6Z1RFbkdYUnFsbndyU09GVU93d3ZMbmFrUlhBWXRLSGRsSEl6?=
 =?utf-8?B?WTljLzBBS3NZWUNqbWMyUHhwL2FueFg3M3UyWUI5ODRreGpGbk02MEVWSnIr?=
 =?utf-8?B?S3BHemRxREl5dkZDRnNJUk16SFE3SzBNKzU2YnpnQWlxOEtFME5VZ3BGeU5V?=
 =?utf-8?B?S09YQXdWemNjK0N5TGlBYVUwK2h4bWtaN0tQVStkUGgwQ3BvVWg4Zlc2TnRC?=
 =?utf-8?B?N1VFbW9TQzZuZjFoNVZRazh4eFJhUHJ0S3N5em01M3lWZHVoSlFlbUdpd2Fr?=
 =?utf-8?B?bWdZekIrcDlZWHJJS2VWM085NlpQcC8yT2VvNVRQTUZhM0NBcjRtOU45b3Rx?=
 =?utf-8?B?ZVNiRFBIZWh6SlpmNzI2dFFkblhuOXJFMzVVampnaUxJRzVGVHdqMldFUWlJ?=
 =?utf-8?B?b1plVlk4aXVGeUlROEZYdUtyQXBZaHdlNGY1M2VVV2l2SGtaTjE0K0FrTEQy?=
 =?utf-8?B?ZzVkUkREdk1rK2w4TjdQbTJCendTK3FTcmpoRWNxa0V1RnpZRGJVd0FBbEJi?=
 =?utf-8?B?R05xSlR6Q0lFQWRGa0JMRTZxVVJDaktlV2haa09TeHRiQTZRSWozRndhbmpJ?=
 =?utf-8?B?STRTcDNoWDNkTk9oWGt0RVBkcFVDaStwK1pVcDMzY3FUS0taaTFkMnRCZW5C?=
 =?utf-8?B?WFBObmRFY0hTZFYxMlJEK3NwT2g0UFl6eUtrZVVBc0k1aUtzYUtmRFBCRjlB?=
 =?utf-8?Q?ZZW7HnXtR1SgAG51OVaGrI8lC?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2255446a-ed7d-4ada-0a1a-08db4bad2244
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 08:05:18.0952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xVNXkQ4fsfaI4edWHPts2vA6EiyagIxLLKkwVn8Hb12tB3xQ9XxRxy73Afv3syil7Fnxe/bVK1jnAtT+YYxldg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5150
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 May 2023 08:05:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11390

On 02.05.23 17:37, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This patchset fixes secure-boot and disk-encryption for Debian Buster
> by adding the debian buster specific certificates and ajusting the
> binaries and dependencies for clevis 16.
> 
> It also fixes the disk encryption for Debian bookworm by adding a
> missing dependency to libcryptsetup-token-systemd-tpm2.
> 
> 
> Changes v4:
>  - Correct kas command line in README.tpm2.encryption.md
>  - Fix build of ARM64 and ARM for buster with encryption
>    This fixes only the build - currently arm64/arm with secure boot
>    enabled on buster fails during boot with the following message:
> 
>    TFTP error: 'Access violation' (2)
>    Not retrying...
>    EFI Boot failed!
> 
>  - Update Linux kernel config
> 
> Changes v3:
>  - Activate encryption for buster ci job
>  - Adjust whitespaces
>  - Address shellcheck findings
> 
> Changes v2:
>  - use OVERRIDE and add missing space to linux-cip-common for
>    encrypt-partitions with Debian buster
> 
> Quirin Gylstorff (7):
>   secure-boot-secrets: Use distro specific snakeoil certs and keys
>   initramfs-crypt-hook: Add support for buster
>   linux: Add missing kernel option for LUKS2 encrpyted partitions on
>     buster
>   initramfs-crypt-hook: Add libcryptsetup-token-systemd-tpm2.so
>   initramfs-crypt-hook/systemd: Address shellcheck findings
>   .gitlabci: Enable encryption for on buster
>   doc/README.tpm2.encryption: Correct kas option
> 
>  .gitlab-ci.yml                                |  1 +
>  doc/README.tpm2.encryption.md                 |  2 +-
>  .../secure-boot-secrets/files/bookworm        |  1 +
>  .../files/{ => bullseye}/PkKek-1-snakeoil.key |  0
>  .../files/{ => bullseye}/PkKek-1-snakeoil.pem |  0
>  .../files/buster/PkKek-1-snakeoil.key         | 28 +++++++++++++++++++
>  .../files/buster/PkKek-1-snakeoil.pem         | 19 +++++++++++++
>  .../secure-boot-snakeoil_0.1.bb               |  4 +--
>  .../files/encrypt_partition.clevis.hook       | 28 +++++++++++++++----
>  .../files/encrypt_partition.clevis.script     |  3 +-
>  .../files/encrypt_partition.systemd.hook      |  3 +-
>  .../files/encrypt_partition.systemd.script    | 28 +++++++++----------
>  .../initramfs-crypt-hook_0.1.bb               |  5 ++--
>  recipes-kernel/linux/linux-cip-common.inc     |  2 +-
>  14 files changed, 96 insertions(+), 28 deletions(-)
>  create mode 120000 recipes-devtools/secure-boot-secrets/files/bookworm
>  rename recipes-devtools/secure-boot-secrets/files/{ => bullseye}/PkKek-1-snakeoil.key (100%)
>  rename recipes-devtools/secure-boot-secrets/files/{ => bullseye}/PkKek-1-snakeoil.pem (100%)
>  create mode 100644 recipes-devtools/secure-boot-secrets/files/buster/PkKek-1-snakeoil.key
>  create mode 100644 recipes-devtools/secure-boot-secrets/files/buster/PkKek-1-snakeoil.pem
> 

Thanks, applied to next.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


