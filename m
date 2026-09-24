Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF94FC9830E
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 16:56:58 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.23])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3147.1790269011988709345
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 09:56:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Z/62FQnZ;
 spf=pass (domain: siemens.com, ip: 52.101.66.23, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okNGSnzcx0aRiY8nTNJq/XIjsZbCJFICBH2lRJxatEBRGNL8F2mP4q7NW6VuulcCCncY91qhTmB4gwv3EVi826FLIJQmq+ZdPXTQn4PbrwHjmO7z2H42/9pw6p+Oue/8y2lScAXr37UMmP+rhj8RirUISPXKISNYJ0POH8P1eeiETUh4e3Jz+j/f/dZ0siKJ4b2emPCZuaxmhLXldmsXOE+TFVZc0R1bG5qdicv7JfRh1ejmJ7XSgFMX0l5f1rpYz4TSAggIkO2FOhoxZ2WGpKQhzl5v17u0hmOSeeou4TtqwUxUb0+BNu6Pty78j6uQuSCyzpLC7eEHZo6wR/ixaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edxLFDV28qyl7YYbE5inMuY0fNXdUVgHqGzW+eSLOFY=;
 b=kZi3tZCuJb2uRo2PWQKCjvg+1VxmRNYlLi/+fQRNZvl0aNalRqML5TOo5P9VhKjADs496Obkeuxa2zR4QHTLXA3yLHGxmhOX1IYysUqJNoqAzQeMaOrODlrowKLc/g8BLtnKtnRmw+8iSVJSff3B93eDILUWsaDT9YAv7BTCpsbU5oW5rOXowZB1QdSYtmuf6fO2WwNm1L8YHNNXmD3UTwLGX2i6t+B50w7vJJBsIbsvjvj9OupPpG7vfgKk2OqHVXOgl1VumjHiULWS8bFj2ng4Xz5DDvHcRQ5nb8rk5i6y0klYu8QV4GnzIstkWrgsCyJx0tQr3kcBLmVcziwUMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edxLFDV28qyl7YYbE5inMuY0fNXdUVgHqGzW+eSLOFY=;
 b=Z/62FQnZ4KRA2n+OLjc/Hs0eIgl6zmLKLgBh97lSyzDa4i/R6ut5QpisWg66axS03SzPYhjCeU3dDO0wsIuf0fUBFo6OSvAyS72P40h2xnSfT9YqyCtdSU8YnXMcTQJOte4IrMXF+I8Bi03AwICj3rTLRoz3LSsvYsoIbWInjnghOgMYSJH0r+jiQAJWxE/3ECXL//mzvdB9pLR+s5IoOVo4CCw44vNMhmxFYfZoXPjcptr8NIB/bC3WtU5ygsRhIxl/J1xNgqKjsf1VAeGcflCHR9X6lZ9+E6gCEczYI+YCeUMDOClAQwIWuL6hwZ6pgydX5QolTiimaS04b13pfw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB9123.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:443::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 16:56:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 16:56:43 +0000
Message-ID: <9ef15d55-630d-4a8b-860b-5cccd33b2a59@siemens.com>
Date: Thu, 24 Sep 2026 18:56:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v4 0/4] Add wiping of hard disk to
 factory reset
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 alexander.heinisch@siemens.com, cip-dev@lists.cip-project.org
References: <20260924113844.3192747-1-quirin.gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260924113844.3192747-1-quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0218.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:88::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB9123:EE_
X-MS-Office365-Filtering-Correlation-Id: cf1a1b95-4a7b-4a6c-0047-08df1a5ccfe9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|5023799004|11063799006|56012099006|3023799007|10067099003|6133799003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	bjBKbzN5pKb2Cn5gyd7y+oiJkN+eWgmwq4JICHedu1C4jFD9mFaqfZ1XWVfIwhoY4Y8dy/p4Eofwk1VaXfXlYtr23SDFhm1xT3Tlz0eJyjUUa9onxK7YXy7G5YNBSaYmWHyBzpGFAYsZIIkXxA9XZZ4Si8RVOnl4AlvdKzWbZNTUdrddeDgm0JaZu3n4ZAoeaHNemyoOEYIoz1IzPZYZyED+3wrnGbrnMA+cAYofykeWSJfQ8xOO4p83LluZW0MgHfBxXtTXQoRmDdWwDLiL3LlZRRTcgC3fNgS0cQd5M6/jkT299i4JLP9xpAzhx1SKszl2Tz726o6YP0VEkTshHpCjQe6cYbDi2OB42PkfWBjscqN6vZs+CSG27HHuuBS4FP0bcp7qKd7MzkrloBtgVUi8EodpeYZdr1IqhWYpyrdW31JKhfOiM1Sa50hgyXkhfj4wSlaveYY6woRp6yh0agDwp0D4WkumhE/V2Be57o1cACbZ4CLMjaWdxQBgH5xCAiCyPnCLBnsDXVbxFrAwYWSRvppuSSIKQVaIz2ufxY2M4HruD6Ui5iZvGrl8aBMT6ljm92ZBWCUROzb9jjC/RhYR36pCgJR6GgCn3xOeX80+N4oPd/xdbtOddNWNr1z1
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(5023799004)(11063799006)(56012099006)(3023799007)(10067099003)(6133799003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WEhiRVEyMlNUU2dZcGNJQk1jdDdaN1Q4MDBzQUgwcTdaYVYzZVM5cG5OWTQz?=
 =?utf-8?B?ekt4UEhoWS8yN3k5aDExOUEvdVhmUVc5eHR4VkhDeWlQZmtTZU0xSUtqdUQ0?=
 =?utf-8?B?bncxK3BXRGwxT214V0loUVhPNFBtODFPQjJVM1pEci82WE5rRldueW51a2Y0?=
 =?utf-8?B?dzU1MXUzNlpZN1F5MVM1eWxKNkFtTklUdVA5akp1TU40OW5uQTU1N0pMYkVs?=
 =?utf-8?B?UmlMQnNpZElkMStzeVhOVVdjSjBYbEFsSFRIWjBDaVQ2dy9DSGpYTTdMNmtp?=
 =?utf-8?B?WkVtYnpPcTNocTMzdUhmSkUzQnUvclhQeGNIUXJ0cWI5Rk5hOWRPSVA0L0hE?=
 =?utf-8?B?Z2hNQUVDblBXaURYN0s2cGU4cWlHTlJyOGJ5R1B4NlJhZDJyWjZGMVU3c3ZN?=
 =?utf-8?B?Q3BVUkJWWEhWcWtJTHd1SGVVOEh6aDZGa1dtaEN3a3luQkdYRHF5c1FmelFw?=
 =?utf-8?B?cWFrTmw2Znh0TmVyU3BWTEdiVzZQc1ppcUN6YWE1R1ptTnN1QTNDeHd5UDZX?=
 =?utf-8?B?RlFza2U1VDVTbnJBdUwvQjVHVnhCd3VzZ285R2hpVnE4TzZKeHBoSWhGbzRP?=
 =?utf-8?B?NjFnbDdENVFLaW1KSzJiSHRKY29zckRKajNjMXB2YWgzS09pMHplNm9udXdJ?=
 =?utf-8?B?a3k5UjRuOXZha0hrNG5nR3lCVnhmNTl2MzBBdjhORk9EUjYvdG9zRSsxSTl6?=
 =?utf-8?B?V1NTM2lrTzc1bUtiZ3FTRVZpNjY0Q2FnWGtrbHJOZzhoZ1U3RUozeml6THJ4?=
 =?utf-8?B?eEV2TnZ1QTJGcFJ1eWMwNkU4Uy80eVZmT0RIV3Y1cHp1cnZLWURBSmNWYjlE?=
 =?utf-8?B?UkgraU1zZEN1aitXZzNxREFVS2hHRDZYeFRYckFpc0V2eFQ2czlPVU9QazZl?=
 =?utf-8?B?d2wrTklTQ0ZtNUt2eUp5b0h1ckhsaWxCZy9LNTB2MC84K3RJRmdiclZTbkFI?=
 =?utf-8?B?VTJwV3MxTGdCa2hlR203Ry9FV0N4SjlYNm5Xbm44Qk1oeWR4SUMwbEx6ekVp?=
 =?utf-8?B?UVlqNE5EbFdiUHgzNC9pODUyZFlhNjMxaXZ1WDRNZmJXUXJyZHBQKytvTmRW?=
 =?utf-8?B?QXFBczZqK1FSNFFPUnBadEsydXZrMDB4Rnd6S21vWi83RkQxcnRUVStNZ3hG?=
 =?utf-8?B?RW1uVWRkelFkN0xJNDNXRmJmaXdjZVZGbVM2Z3ZtQzVlZUJNYjYzY2ZiNnBH?=
 =?utf-8?B?TFJHb3dLWnlZdjhGbTJ4MTdDcGpFSWJqemJ1RGx1aXYvSnh2UUc1R0FvOU03?=
 =?utf-8?B?MGZPOEZBQmhrbUNJMXlKdHF3VUZaTWdITE9xSUtVcnZqME1vSHliNVhreGhq?=
 =?utf-8?B?byt3QVJNS3lQcGh6cWJiZERITmNFcmtNY0haRWlWVDVUbjlhVHNKOFJuVEpQ?=
 =?utf-8?B?amVuZVMwdDJNbnBHNkJuRDB4NWhPV3JPdnRaU2U5SVo0ZkZHNzNuM29QdU5n?=
 =?utf-8?B?bVhGWitqRlNXRlhMZnNISWptSDNRT0JsNXBHL0lJaHBOeExUVjE1NUhEbTc5?=
 =?utf-8?B?MFE2MGV6WGluY1NvWWVoeUtFZzc3clNLNnZmaFpBYjZuL1dpWERDdmNFTVc3?=
 =?utf-8?B?UUxyUTdPQkNnYVdpTk9nUWtoMWNxYU9hRGcyWWdnSjR3U2hzTVdoV09ScVBn?=
 =?utf-8?B?c2ZEaTBIUG50K0JYbmtETnp5WWFtaG1zbEhVZHlvbEkvTVRBL1NBUTBmemUw?=
 =?utf-8?B?N0k1VnZnaHhJeXFYdnZmRE9BQlNKeWJtdVJBVjAvdEJZRlFrS0gvWE8rSXhn?=
 =?utf-8?B?OVZWVXFtOGZUbjBHUWJjY1dERWowV3JBb2E5VDRhRUxodFFRNVp1TEdHNEFH?=
 =?utf-8?B?U1hZdGUwa3J2QS9JOUlBZUU2ZHE2VU9IRnRORmFFSlVyOXkvTnZGY05DTysx?=
 =?utf-8?B?dHFtdWUzRjFrM3Zxa3NwSVV0a2k2L2RGeWVhbVdicXE5YzlmZEcwQXJJeXBl?=
 =?utf-8?B?V0VoQUNoNGcyZERqb0JvbWt6eTJRNmxacG1aRnBXWWl6a2E4RW9ESHVzRGpO?=
 =?utf-8?B?UUN2d29zSGFYWUovdkRld0FZK2RLM0F0ZWJBdm4yQitjZ3pHTG9Yb2xPL2py?=
 =?utf-8?B?aGNOVU02cjJBdWpUWEdRRitmQmMyOHcxWXIva0lKZkNpay9Nb09ic2Z6bXVS?=
 =?utf-8?B?eFhCeCtVbmlmc2RRMU1LbmhIKzdYeHpjdGNhMDdjdkczVUpjWVhkbTdUb3U0?=
 =?utf-8?B?Z1ptcDFHVVlPQWhMamh1TTc1ZFpYN1VyNmNhK0h1RW1sVTZ4ZWVxeHd0ZUw0?=
 =?utf-8?B?TlNMOG9oNHU4K0YrdVFQejRESTV1TDZQUUhWYW9vSDhGb2dIZ0ozZ2ZEdUh1?=
 =?utf-8?B?K25kTFZBN2VoQjh4T3VEV2FJVHAzN2dXWXJrc0lBSDBUc0hXcHpTR09JeTBI?=
 =?utf-8?Q?NDC2nyLMKMgRJYVg=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1a1b95-4a7b-4a6c-0047-08df1a5ccfe9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 16:56:43.8543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XSjystb19XzRjzHxVRJPsT6qKf+KzVLGOx8kHvhkS1Ef6ZBWLXjEkIdDqZkgJ4iEHhvILNij111Rgkob5/Lp3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9123
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 16:56:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24339

On 24.09.26 13:38, Quirin Gylstorff wrote:
> With this patch set a partition marked for factory reset is wiped if
> - disk encryption is disabled, or
> - disk encryption is enabled and the TPM is *not* cleared.
> 
> If the TPM is cleared, the LUKS key is gone and the old data is
> inaccessible anyway, so the partition is only reformatted.
> 
> This fixes the missing wiping from issue [1].
> 
> [1]: https://gitlab.com/cip-project/cip-core/isar-cip-core/-/work_items/164#2-no-proper-wiping-of-disks-if-not-encrypted
> 
> Changes since v3:
>     - rebase onto 75c3ed7cfebf8ec5c79329abaeb7a9a50ca546b1
> 
> Changes since v2:
>  - Move the TPM clear fix to the front of the series and rename
>    INITRAMFS_FACTORY_RESET_CLEAR_TPM_VAR to
>    INITRAMFS_FACTORY_RESET_CLEAR_TPM_BOOL.
>  - Keep CRYPT_SETUP_TIMEOUT instead of renaming it, it now defaults to
>    the new global INITRAMFS_SETUP_TIMEOUT (fallback 600). Documented
>    in the recipe. No deprecation warning needed as nothing is renamed.
>  - Add INITRAMFS_FACTORY_RESET_TIMEOUT, also defaulting to
>    INITRAMFS_SETUP_TIMEOUT.
>  - Move the INITRAMFS_WATCHDOG_DEVICE default (including the ftpm-stmm
>    case from b31ad236d5d9) into the distro configuration so that both
>    hooks use the same logic. Recipes only keep an empty fallback.
>  - Split the target -> target_device rename into a separate patch.
>  - Fix commit messages.
> 
> Changes since v1 (RFC):
>  - Wipe automatically depending on disk encryption and on whether the
>    TPM is cleared, instead of requiring an opt-in ':clear' suffix in
>    INITRAMFS_FACTORY_RESET_DEVICES.
>  - start_watchdog(): check both parameters, use log_warning_msg()
>    instead of echo.
>  - Drop /run/watchdog.pid, the shell variable watchdog_pid is
>    sufficient as start_watchdog() and stop_watchdog() are always called
>    from the same script.
>  - Do not add the psmisc dependency and do not copy fuser into the
>    initramfs, both were unused.
>  - Keep the blank line after wait_30sec_for_condition.
>  - Add fix that the TPM clear was enabled instead of disabled when
>    setting INITRAMFS_FACTORY_RESET_CLEAR_TPM to '0'.
>  - Drop the RFC prefix.
> 
> Quirin Gylstorff (4):
>   initramfs-factory-reset: Ensure that '0' disables the TPM clear
>     instead of enabling it
>   initramfs-crypt-hook: Move service watchdog to cip functions
>   initramfs-factory-reset: Rename target to target_device
>   initramfs-factory-reset: Wipe partition before creating a new fs
> 
>  conf/distro/cip-core-common.inc               |  9 +++-
>  .../files/cip-initramfs-functions             | 36 ++++++++++++-
>  ..._0.1.bb => initramfs-cip-functions_0.2.bb} |  0
>  .../files/local-top-complete                  | 23 +--------
>  ...k_0.11.bb => initramfs-crypt-hook_0.12.bb} | 14 +++---
>  .../files/factory-reset-script.tmpl           | 50 +++++++++++++------
>  .../files/reset-env.tmpl                      |  2 +
>  ...bb => initramfs-factory-reset-hook_0.4.bb} | 17 +++++--
>  8 files changed, 103 insertions(+), 48 deletions(-)
>  rename recipes-initramfs/initramfs-cip-functions/{initramfs-cip-functions_0.1.bb => initramfs-cip-functions_0.2.bb} (100%)
>  rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.11.bb => initramfs-crypt-hook_0.12.bb} (92%)
>  rename recipes-initramfs/initramfs-factory-reset-hook/{initramfs-factory-reset-hook_0.3.bb => initramfs-factory-reset-hook_0.4.bb} (72%)
> 

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

