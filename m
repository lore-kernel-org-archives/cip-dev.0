Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20241C7EE23
	for <webhook@archiver.kernel.org>; Fri, 24 Feb 2023 18:09:12 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.73])
 by mx.groups.io with SMTP id smtpd.web11.25560.1677262143044908941
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Feb 2023 10:09:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=p2riRLiT;
 spf=pass (domain: siemens.com, ip: 40.107.105.73, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ve7sfZyrZ5sfd1SCu7COeyoTVU1jUGuFdqw24rAzMmH59UwRx2vfDE5a9CXmtZVFU/4j/fwwMz8bJut30InuSPJfxtRCS9Bcc+wHSnDm6wi26AjzjverkJTyE4rcouhGacGIfozd3BAUFzTpZz/jbShLoFr61GLSpEiVTPE756/thcCpQs3Aa+ms4TfRoGAkqKw0Tnr8d6duaGEQ4DP8eGLjhFSDb32HSCYxgIPxCX/ajJPTaP7k/PkIJOtHcF/iE4BNItBjQiJ4xFuFy/7GYpNv5l1H5ocWb6wczxsC0/VDl9A3rlpA8ScwxB2CWTCZtMZBEmLvZiS1Tn5dwuC5vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9B9rXoWGBGhthQiKXLMt2FVDVmP4YZfvIZRAd61RoE=;
 b=J8KfSo6rPtTjcjhRXmfhDA2zhj3pATEjo/yHgnb9Fk0ENa7FV4NGBw1mA3Uwsiaw7lLovSaLxlbwe88RfRuovPEBDI2l2FPnEY+IyUtRhCZa071ILnVXWyOG71irW7HERyeUg+O1LRAnTdDPiLtrS/UNjEKKgejhBJbo+OvFMFGsmaqMhT/OpcDYVlRPjkeadSZsIjLb/+CQOOUZt2iVpQKClFH89Vzwpg1nGcnq5oUzPxkuX2s1iKv4lA3QH5dZ3BXOFZpOzPNmkwxiWUGU06q4wxWi3wdLTrF5vW6x4/nEjhsOdwSv/Ju+e+KSU5T1LTW5VLwNbYcGxYLooTKKLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9B9rXoWGBGhthQiKXLMt2FVDVmP4YZfvIZRAd61RoE=;
 b=p2riRLiTNTPQCFqloJKlsc6IJpbRrkPh+bONWaUndo1WLt+kulzNDslm/wNdxQfeEClphHfiwoiTmJGAdTOZeKFqugI80oJRa/ZtZxkasPE9GfAe1pwRCCWIIuijO5U7fDl5igmtEboZllCktjQHAnT8eQKbM9mvVdoBKvEqB1QS8VoeKiDWjRCW4LU1qJVcx5RrvD56zuGx4JHpTQKFQvDo2zrC1zR5+qgftb1NEIEkehzf4iNGikEhz5E4l3Y2Njsi9XvjLAGOWbSk0S5Wq1C4+o1lEbrSsH0R9yLV6pwY/3q/8pw1y6/ugcVnLznRh2z09BGjiLWtqEsck1C9MQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB6913.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Fri, 24 Feb
 2023 18:08:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.024; Fri, 24 Feb 2023
 18:08:59 +0000
Message-ID: <c5b9bad1-e542-e2a6-66ba-d04015c7296c@siemens.com>
Date: Fri, 24 Feb 2023 19:08:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [isar-cip-core][PATCH v2 0/3] Add swupdate support for riscv64
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: daniel.bovensiepen@siemens.com, quirin.gylstorff@siemens.com
References: <20230214062730.1636598-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230214062730.1636598-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0099.eurprd07.prod.outlook.com
 (2603:10a6:207:6::33) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: 54d1edc9-8b5e-47da-216e-08db169233fa
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9AkHeS/tv+GPDxHhP4go1CUiw06T4VgDGjwQT9o+pC5Yatd3qHXcQ0OA+73WeSNFSQtAEqJYsy7zk4QZDtnXPIDO+Ee9UKzAfccnmPCS+QQHmfVKQaayanzN6ES1E5WLCLoOLu/7vuCP1fKtOBTbYxAn0fnLnYNRGzk1GF71v8GRbn8P/yMHuH0QvyKyl42cTVeZloIUAwIpGTStElCFB44G/yMvGIMWiRMsyslRFna1G82yYe+Xva7qVzBYYVoPHU7WyGKu5+7/ZHlM+KQN7pqFgtBvjoPrUFULr6U2dIO+yPiGdso4y4IhvzAzpGepBrlpYbVtgzCztjz9o9Z1C13e8TxwUyir4/i9C5Xfhwdww1dtDpI5i93qCJ5lssh6Uzxi5/ji0hVoiAyjzIpvTJwJnCacyJiZx3e0JiuM5B5n5RZqvIB0ISJ0dTGervwaoDwM7B7Lxcbae5pQGSt+YsQb0kNkdoIVjOvDau0NU3fE/sJ7sOoXZ4Y/xqlNrXxJVmxphEVDSUreNkE/cQ6oMBARFZ0JfPXNimphl9sj/VVHvEqWOTCE/W9FzIhLtPekzvp1iBFZoT39C2dAJvLTvmtitW+7ud4xESxE09LqM5MYc50QlYO56tZVVRHcTwO3PmxUEZbKs9OKhqKdUUAKdTsruUDKrPJL+fIftSbQ8G341j436PM38zMEz/Xh9o3YTObkdyqo2+KAyzRIGNHa2p0db0V4xAbCIL/YRULcoGQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199018)(44832011)(31696002)(82960400001)(2906002)(38100700002)(31686004)(86362001)(478600001)(66946007)(6486002)(53546011)(186003)(26005)(36756003)(66476007)(83380400001)(66556008)(6512007)(8936002)(6506007)(2616005)(107886003)(316002)(8676002)(4326008)(41300700001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cU82bTM4T3ZTK3pSYVpkRERjN1E2SkN3THc5QzhTTjd3eHRORHlpY3E4SW5r?=
 =?utf-8?B?U284MFZ0YXNHK2JPbmdUaTFWUC9BNE52QmJEbWIzRWdjd0xSbkVHVzA3eTVT?=
 =?utf-8?B?UE1UUWcrOFpYZFNzZFVQSjhmWk5EZEV3SEs3T0tRZXNLeHY4V0I2ZEdkRmRS?=
 =?utf-8?B?U01GUDJVL3BRaHFGdkloam43OGJVV3h3aE9aVjBRZnRTVjhxSUgxZnlES3lD?=
 =?utf-8?B?ZUZEekZ5ejRFVm96OUhPaGZUeDZUYU1SWDhLS28yYUwyaUFZeGRQRHNkaU9K?=
 =?utf-8?B?cGxmdE8xa2EzR0t2NCtId0hVM2QyMldJekhQdTZQSVpvRkd1b1FYQkxzSkVv?=
 =?utf-8?B?T1NxWmpoVEpzYnoxRVFMeVQxcWpUQVpyc2VwVUJiZGRaTDliVkRWeUpiMnhK?=
 =?utf-8?B?c2U3b0picldCZmVDTE9nZ3l0WGk2cUQ4czFBM0lzUVZoUE0yY0p5UlFEd3l0?=
 =?utf-8?B?TW12aU9XaDk4dFB2bklFd21TM0VBbWphZ0VqYTR2clQ3a1RVVmt3S3JlZWxQ?=
 =?utf-8?B?ZER5b20yUWJJU3d6U3hzUzBGRldpSW00bnJxSmpWMml6N214VU1GR3Y3TkZq?=
 =?utf-8?B?QzI1aVYvd3RwSTZPbXNuM2dycXBqcnJRMmMxQUsvc3N0Y3FWMnUyWkxsN2ps?=
 =?utf-8?B?RHVYbFI4ZDE5SFN1RjlWUWZhY1ppMlFGSHFiZ1lPdWkrek9IeGVSOG02OE01?=
 =?utf-8?B?QUVnY2ZxNFRDNXNNcE1veXBCMUE5M1NVUi80NzBQWXlWcHJaajhybUoxb2V6?=
 =?utf-8?B?RXFubmtlNXpyRHR3cUJhdkNMdDlKbUFDK0RoUGNob1cyQ2JzdXhVZVpSYlpL?=
 =?utf-8?B?NmdZZUcxZ2ZaKzF1TXNiNG5MVjdnVXo4OXUwNS9ZcEk3ZmNDd25HZGhEZnJL?=
 =?utf-8?B?VGpLR3pBZU13MFROKzZKRnJLa1ZPaEs3NnhPT3pyMVBHY3A5NnVHQnBhYUln?=
 =?utf-8?B?dzhidGI0WmN1OXRJemgwQkNRNi9qTFcxaWcyeEZGeU40eTZvcjgxTmN3QStX?=
 =?utf-8?B?NHJ6ZS9MbnJBUW1oOFF0N05CZXd3QVF1N2lBejI3M0pZNXAxdm1rNzlzMzM4?=
 =?utf-8?B?bStQVGJTdG1uZmRiek9oWGFtMUNvaGh0ZG9zUzBoNVczdC80T3FIdHluQkFP?=
 =?utf-8?B?dzU1bVg1WW5YVHltZTNOdGt0bG9kT3g4cW5YTG91RjVCd0wxVSs1RTg5cmlD?=
 =?utf-8?B?YVlsajFGM2QyY0twY05wR3lOZGR0QlA1VHFQYnhtTkg1Qkw0UUZobmJ3YW4z?=
 =?utf-8?B?VTM3VjBqSnBuRHpvaklkUmUwWkp1cVFCb1N1YW54aTdzbXhVUWJkRmNxNEFV?=
 =?utf-8?B?MDRwWmlkZjlLalQycVBsclA1cVJpWmVESytJbjhXOXNrWmttQ3ZMaDd6dHBo?=
 =?utf-8?B?MnozU2p1Nm8wYWZuY1FiNGI0SUFnZjB1RVdiT3EzSWJxQllQNzlORmpYYW16?=
 =?utf-8?B?ZTZqMys5U2Qxd0E2M1Y1c0dHenJtQzNYbGwvSGQxd1NsTjdNbzAwOVp6aEdJ?=
 =?utf-8?B?a2VJTGdyV21Xb3dJeDVWWGNPUzJORWx6T0NNSFFsRG5odU54bDhoaEZEa2dF?=
 =?utf-8?B?QVc3a2l0VnVrTHd5U0lrU25MZys1U1h1bVdqWmNsdnZjdUZRZkZoMGtUK1RY?=
 =?utf-8?B?ZVVNRG9Mb0pDbno4RzAvYVVVK3RzU1UvYU5Qd29aMjhHMU1reEM5Rk8vSXRx?=
 =?utf-8?B?RVhzalI2Z3V0KzQwLzhYVGRjM2ZFM2FRdkFoRVFLUndjMmtLN082S0NTYlpu?=
 =?utf-8?B?VnJXM0tlYlF2blZqanh2QzJnczBjRFV3cW9lVXVqc1VBbEdpYy81VzdYdnFJ?=
 =?utf-8?B?TzVHYVhEWGU1Rm5UV1RaUjQrSWZuemNBcGJJT1pvYzVXZHhYdTFqUTg2WDRS?=
 =?utf-8?B?emJxOEpPTjJGZG51MGhZZEZNYWRSM1ZLQUxGaUVOWCtNVnMvUlZtWVJ6V1FJ?=
 =?utf-8?B?aWUrZXJjNittb1FLMko1aXNILy96SExGWjUrT3BuUlBDQm05L1VOMGJyeXpN?=
 =?utf-8?B?cjZrMkhLekJvRkdPSHhwck1IbVhDckcxaUk0cU1OdlQvbjNMalVOWkU2RC9Z?=
 =?utf-8?B?UUdkZnFpdGpJcVFQSE5uZ1JjN1FrNnpmUWFXcnBaNThwb2c0Y0prZmdhYkVH?=
 =?utf-8?B?YlBWTDV2YkdQQUFyTW41TUR4akUvOFZDeHh6a3k0Y2NQTkdqbkJHR0hjcVps?=
 =?utf-8?B?bmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d1edc9-8b5e-47da-216e-08db169233fa
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 18:08:59.7842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dZPL4QTKMIDlvbcIDGgpB5KURIXdcXXcbZScZsL/0UT9TE4sm+q7SDBwn4IXYDvQOwlEA5AkYWP47RQTWpVtWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6913
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Feb 2023 18:09:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10828

On 14.02.23 07:27, Felix Moessbauer wrote:
> Changes since v1:
> 
> - rebased onto next
> - ebg: fix changelog version (no <orig-version>)
> - add swupdate support for qemu-riscv64
> 
> Please note: The EBG support in cip-core needs a major rework to be in
> sync with the upstream debian package names. Currently, sid cannot be
> updated to a more recent revision, as this breaks the build (multiple
> packages with different names provide the same binary).
> 
> Best regards,
> Felix Moessbauer
> Siemens AG
> 
> Felix Moessbauer (3):
>   fix efibootguard for riscv64
>   wic(ebg): add support for riscv64
>   add swupdate support for qemu-riscv64
> 
>  Kconfig                                       |  2 +-
>  recipes-bsp/efibootguard/efibootguard_0.13.bb |  3 ++
>  ...01-add-machine-type-name-for-riscv64.patch | 39 +++++++++++++++++++
>  .../wic/plugins/source/efibootguard-boot.py   |  6 ++-
>  .../wic/plugins/source/efibootguard-efi.py    |  6 ++-
>  wic/qemu-riscv64-efibootguard.wks.in          | 13 +++++++
>  6 files changed, 64 insertions(+), 5 deletions(-)
>  create mode 100644 recipes-bsp/efibootguard/files/0001-add-machine-type-name-for-riscv64.patch
>  create mode 100644 wic/qemu-riscv64-efibootguard.wks.in
> 

How should I test this? You forgot start-qemu.sh support, and that makes
we wonder if you tested this at all. Patching that script shouldn't be
enough. We will also need some U-Boot as UEFI provider.

Sorry, can't merge this way.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


