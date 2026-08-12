Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BABAC5B56A
	for <webhook@archiver.kernel.org>; Wed, 12 Aug 2026 12:10:45 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.63])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6427.1786536638368426645
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Aug 2026 05:10:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=TWrHHILZ;
 spf=pass (domain: siemens.com, ip: 52.101.72.63, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eBPvsUrdRNOI5XWSeZmGr7oTE/fUvhXQ4x1gejCt8xWNslnIEprFaLCShNK6A89113TqbimR4AApm/G8CqH1ozxhJJw/CnUHR0pNy/LRjqg1pYtAP7CghyNXALcg3xmhHkk2UQWHyFe/UXgQAVzjJczZOdsDRTT+lsaHhfk1wSIVWLON5E1XxsTBXvojMB6SihnsSaPMGF8P/AK2Teyn8Wn0eRVoi3o2Mm5etnTa1XqQHD/WmZvYAbk5gUDUChGKrNnhZOFIVNGsuCZxN9/xeWinHR/YCFzpMAOD4KHoxvujUFA7srAWdHypNrxwDdvvFy2ttD43qm40xhdG1UI9+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n490xzFnWvW5Vg/DcK80nfvnHDt3A/E7LMUhHKXVCkk=;
 b=p85NFNyHqpNQk2H1HwA/tq5Ngennsao+4rYgs0qpQMWLiaYj9WSNQ6V2i5srzprOoBbX/JXkis6flvsy+lgvbIVJePdNBbt9bxEG4pzs5P124FQdVOa/XXbWPTgND1kHLWnwVHvpQMD1bsXg0fDa+5MkfIT1ehvYLRc9t8D+yLDGe9p1WXOHO2k5DT0MYgux3yzje5EHLYWQmiR1lvcDPxZlM8p2YUc4RTLAKuMqkcXpvABM0kt7TwLFfbqhxoACL17xZi8v3Lq6jbZQc1O0xpKFv0486YUiQeF8W9NgWEiZzayozHgZLpk1xTjZSCa7vq2oCO2TXGoGOQRecJ2NIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n490xzFnWvW5Vg/DcK80nfvnHDt3A/E7LMUhHKXVCkk=;
 b=TWrHHILZSokrLEBJ0O9Z5MzJMjm5/+18K+06vfEZ2EfaE4bySIBU8o+zCzOsro2OtpJ8EARLuaz45iRbyjw4/u8uy1S4kYmbVd9893eLyoELMJBETjiL4FpU8vxC3UsYkofvwQo4QNdc8PkZLKS3QN4DtH5vFLIsLiUt+Fl22/z2oTl71CUYwQnx2InWpRU8TUvgYFYB8oXbQWwN2x1e/COmj0j6vepJvpZT+o7eDRp4h9SIaCwWdpkFYfg5+NLqoUnPXpsXp688dxjd4R/zIFdcN8k3fn+FxEs4xg2fyjRWysNc9EBSkdyUD45C58fJNM0zXceZKyXiB18uVzulYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ef::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 12 Aug
 2026 12:10:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 12:10:31 +0000
Message-ID: <0f8dfe37-8856-4895-8cef-b40342339c66@siemens.com>
Date: Wed, 12 Aug 2026 14:10:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] recipes-core: ltp: Update to 20260529
To: Gourav Singh <gouravsingh@siemens.com>, cip-dev@lists.cip-project.org
References: <20260812071842.844364-1-gouravsingh@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260812071842.844364-1-gouravsingh@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6252:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e8897e1-d37f-4178-02ea-08def86ab4a6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|56012099006|11063799006|6133799003|10067099003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	xGPgzkjvsUtuvNGIKzuwVXaH41ASHMrJCls1QwwyjhusOD5CNdWFyl4v8m778AK5SVEC9k0hNPG1W1JDdI29pwB2dQnK2D8u09KlAFlc4bM32pPVqSSeF1NaoVwu+GZAZI4IQsRe/QLqdJaX6zYB3mX+noFwwGOvAlwQDn0JQ9/k+L38AqwVNICeKoAVc0rpeT+OgqjAU+MMAmyrceX7vxcBV6nqc5hICFhIRkTE+0v/2ac/qJWsLracHaJ5qDuQ4HtG5F/qwwM9DXkjM8q/qZi5BPDRK9k9vMj5lV4vGlOPUyPD7+SO/vdKch/+bxjYnHGkHSeKC+BWxImZJsKlj119ZB3cVObSxt73oMkh7SYzQVkat4ptySGYvhc0hKoysPR+/hZc8boTBjGn+cbdPVLuRDoE9Qfd+ZsVqA/0qvWzR/8wROJ7iUkSgVxlrLDIKGqAYQcf/OINn8MDoJyU+/kSiS7D7iutyBMH/4w9Y/zpUbSL2aNahDdaSKRe2y1K0lozigiXJS9SRfuINqBLBESeLwFh/j42DPOfiwvSClxB5jRPQSqgOWuq7jk4y35JK4fhpiHct+JLjAvH1LAMuwcK9Dh9LXM9RVvZzF7wwECOS9aUGN1DkGlLIZZr0FELREg7m1RcwRoNisrxA5KZR15wCALm0KidXYj4DnyqJY8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(11063799006)(6133799003)(10067099003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aXdmTkJySHpjNDJLWHF6aW1BQnIzRHRhNklmOE9tdmdhVU81aEhHTGdubFhT?=
 =?utf-8?B?bmk5V2ZIQnBDZ1plVGlDdEFpNlcrY0VubnYvbFJRSmg0NTRmWEtpbVRtRWUr?=
 =?utf-8?B?SkxzYlE5S2xpVFhqakpNZ3dJMVUxYXJ0KytMN1FsZVlnL0IxMjIxcU1INElV?=
 =?utf-8?B?d1I4RXRBSmltUy9LZURPZGVWcUpHU05mM3krekNzN24xUFFqcDBOREFmS0wr?=
 =?utf-8?B?SmtTNmxST3JyNTYvYVI5ZkpMNUpYeHBxc2dUSldlRnFORUZDd1c3Y0pjdWQ2?=
 =?utf-8?B?YXRRV3ZQMDFadFRqRENLRkdpaEZ3V0Z4b0U0a2pGS1RKM1RpVHNQVnBUSkhE?=
 =?utf-8?B?Yng5YTZZRmJFZk5SQXVXYlVnS2VBdEozdHcvVDRmbFBtSzV3dW5QZ0pQWFFm?=
 =?utf-8?B?R3ZwUEJ3Yi82SGU4K0w5a3VwV1c0eVFwQ1ZkQmJQUkU5VFkzTHEzNy8zb0Rt?=
 =?utf-8?B?TFJ3dlRLYkUvaC9uL2p2TThLT1YrM2l2L0EvdkI4dUxodmVBTGJQbnBMczB6?=
 =?utf-8?B?Vk05SlhQdHFjcUdJV1I4K1dMV3MzU2VSVkxNRHZUWlNwQTZYWlZOdktJSnpm?=
 =?utf-8?B?UkdMUVR5L2JuWnJEKzJjVXJIemZ0Wk5RRjZRNklMeDhTNzlHS0FXb1VnWGZo?=
 =?utf-8?B?TkkzekV3MTgvTnJleEx1VVJnK1dzUWljdkUyV3FJbmZ3YTBweGhDR3ltbm1q?=
 =?utf-8?B?NWpvbUhSQUQ3Wmp1S0NIb0VscFg4OWtISmJjaElSMStaTXc3ZitUWDBCMURL?=
 =?utf-8?B?SWdnWXZxalFKV0lJcnJkS0ZDdE5YTHF1TVJKMjdOOVNMRWtkM3EwQ2I4aVVa?=
 =?utf-8?B?Q3BDMkQ1TmgraXh2MGp2UE84dmdoSGRtelFXbWpKZ1cvWUUxQ01LTFlVd3hR?=
 =?utf-8?B?RlBVYUpkRjMzS1JLS2l6U1lrcXZFeFdSYVBKYnowTnF1S2IrRmdqT2Jrclpx?=
 =?utf-8?B?TmZDNHF4eXZWYlFrY3hSVFRkK3lSbmxnQWlabVJnSUlRWjBXM1NRaVpUQ0pN?=
 =?utf-8?B?MW40aytmNnUxM056cWJsUU12L1VHbkdneU9OaDVzZUQvdFJ3QTlKT0pQYjMx?=
 =?utf-8?B?MzliMmFLd3EvQy85ekI0MHhhaWpPUUJabTh2MEN2cEhnWThQQnNyc1MrMnMx?=
 =?utf-8?B?SHNkaGlla1E3UlkwR3hGREdPN0xNTXhuYnJ2aW9MR0IzL251enlDb0ZqcitB?=
 =?utf-8?B?bnMvQnE4MDBhcTdoT1dnazNwL3NtQjNkL0lVVkk5ZkpHZm9uVVVPRUlUMjNq?=
 =?utf-8?B?c3duMjVLMldJOUFwV3NZRHM4K0xJU1BxMXVkcVNaRUZZOEVMdlY0VStnNVJL?=
 =?utf-8?B?ZzZwb3NxZmRsUGp0dFFVUC9mWlZWd1E3akh4U3hQMVZmRldwOXFPMzZCZjZE?=
 =?utf-8?B?L3F5dndrd1VtR0ZlTHkyUWgyVUJSaXpaOHBRem9rOC9YWllBV0JEQkxtS096?=
 =?utf-8?B?WmhMTjQ5bFJFS0JMektjR21Hd3M0bDdDKzQxaUNMNXRCY3JWdUlkSXNKdUM0?=
 =?utf-8?B?NjV4d3NYbkd2bmd1cGJFMi9mQ0pyWEFlNEhsN0QwVkFVeUVVeVg5MXA3QUhS?=
 =?utf-8?B?MkhKcXo3VWhQM3pLK20wTmJxWGVzaldaUTZMTGNnNDlXYnFnNUJud3owSGFQ?=
 =?utf-8?B?TTZYbGdOajcwa2xreE9hbjlIVzU3UkFGbFQvb3NzaGswODJpb3UwTjRyK3JZ?=
 =?utf-8?B?c1NGeVlUNldXeGhGRmhNMk5FRG1EbUxGQ0lGd21JMkZjTkxId3FYYUdnZi82?=
 =?utf-8?B?dmhuVnlPdXIrTExXV0UzaDBxcVlQbWFrNGhGdlR6MEtLVnE2UnJVSUhMOE41?=
 =?utf-8?B?R3FLeUpuRWc1YjBpTzd2YzIzZWxxb05OZ1hydmwxNEVEZzlhMmJndW1jQUNX?=
 =?utf-8?B?MHF5R1RlM0FOYkpJci83TEVMTkpETXE1cDlaMks5d1NsLzkzQ3hHWWYvZ2RD?=
 =?utf-8?B?WWlVM2twUXN3ZmJlZ0txaU0vR1MvbzJkR1NndW11cTBRVVk2eDd2bkdub1V3?=
 =?utf-8?B?aUNWUzBIemFQZ25CRDUxa2NmSitZbHpwR1F4dWw4RXZOaHZ6aU9IWVprK08z?=
 =?utf-8?B?dWpTbUxtRjVValNNeHJxekhZckVwMVRxNkFDb2psVnpwbDBKVk9jOCtSZUor?=
 =?utf-8?B?YXd1OVJwZm9EVWZvUk4vdHA5ZWczTzNocnJILzk1QkVTSFRHMDFxSlBlRHY1?=
 =?utf-8?B?NS9DU0tXVmxRenBZWXZOMlFFUE5ta0tKbDhVQW4rSllTSGJrZFhLcWdLa1N3?=
 =?utf-8?B?OTYyVHduR1gySlhkNVlNZDlVd1orZ2NlOU4zTEhCN1M1L2k5Rll6S1BYZkFx?=
 =?utf-8?B?amRIL0hHeDdYc1YyMVU5bUFNVXNydnJVVVB6ZkJmR3RycHR6ZWNoQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8897e1-d37f-4178-02ea-08def86ab4a6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 12:10:31.6330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SbnqwRL7fbyLMY4iW4utzJcxmO5pUX7UNzzj6aNIK6/svnyLfWI/XcnaDnirY/t2hClnUQJ0wsIagdl4ZSBIlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6252
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Aug 2026 12:10:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23905

On 12.08.26 09:18, Gourav Singh wrote:
> Drop the local listmount04 compatibility patch since the fix is now
> included in upstream LTP 20260529.
> 
> The patch was originally added in:
> 2647471156b128bf8b0fb1d726bd05099fbbe1bd
> 
> Signed-off-by: Gourav Singh <gouravsingh@siemens.com>
> ---
>  ...date-struct-mnt_id_req-support-for-k.patch | 195 ------------------
>  ...-full_20250930.bb => ltp-full_20260529.bb} |   4 +-
>  2 files changed, 1 insertion(+), 198 deletions(-)
>  delete mode 100644 recipes-core/ltp/files/0001-listmount04.c-Update-struct-mnt_id_req-support-for-k.patch
>  rename recipes-core/ltp/{ltp-full_20250930.bb => ltp-full_20260529.bb} (54%)
> 
> diff --git a/recipes-core/ltp/files/0001-listmount04.c-Update-struct-mnt_id_req-support-for-k.patch b/recipes-core/ltp/files/0001-listmount04.c-Update-struct-mnt_id_req-support-for-k.patch
> deleted file mode 100644
> index aecfe54..0000000
> --- a/recipes-core/ltp/files/0001-listmount04.c-Update-struct-mnt_id_req-support-for-k.patch
> +++ /dev/null
> @@ -1,195 +0,0 @@
> -From 2d066ead3d6ef504c82551b12306e751d23ddb45 Mon Sep 17 00:00:00 2001
> -From: Wei Gao <wegao@suse.com>
> -Date: Sun, 14 Dec 2025 02:15:20 +0000
> -Subject: [PATCH] listmount04.c: Update struct mnt_id_req support for kernel >=
> - 6.18
> -
> -Kernel change from v6.18-rc7
> -78f0e33cd6c93 ("fs/namespace: correctly handle errors returned by grab_requested_mnt_ns")
> -causes the test failure with following error message:
> -listmount04.c:128: TFAIL: invalid mnt_id_req.spare expected EINVAL: EBADF (9)
> -
> -The fix require following changes:
> -
> -* struct mnt_id_req got new member mnt_ns_fd in v6.18-rc7.  That is
> -fixed in a fallback defintion in lapi/. If the fallback is used is now
> -done via typedef (that requires also update in statmount.h).
> -
> -* New kernels (>= 6.18) have also different errno. This is fixed by
> -runtime check.
> -
> -Link: https://lore.kernel.org/ltp/20251214021541.3256-1-wegao@suse.com/
> -Reviewed-by: Petr Vorel <pvorel@suse.cz>
> -Reviewed-by: Li Wang <liwang@redhat.com>
> -Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
> -Signed-off-by: Wei Gao <wegao@suse.com>
> -[ pvorel: Shorten TCONF, rewrite commit message ]
> -Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ----
> - configure.ac                                  |  2 +-
> - include/lapi/mount.h                          | 10 +++--
> - .../kernel/syscalls/listmount/listmount.h     |  2 +-
> - .../kernel/syscalls/listmount/listmount04.c   | 37 +++++++++++++++++--
> - .../kernel/syscalls/statmount/statmount.h     |  2 +-
> - 5 files changed, 44 insertions(+), 9 deletions(-)
> -
> -diff --git a/configure.ac b/configure.ac
> -index 0480f46ca..a0ebbb34d 100644
> ---- a/configure.ac
> -+++ b/configure.ac
> -@@ -262,7 +262,7 @@ AC_CHECK_TYPES([struct cachestat_range],,,[#include <sys/mman.h>])
> - AC_CHECK_TYPES([struct cachestat],,,[#include <sys/mman.h>])
> -
> - # Defined in <linux/mount.h>, but include/lapi/mount.h includes <sys/mount.h> */
> --AC_CHECK_TYPES([struct mnt_id_req],,,[#include <sys/mount.h>])
> -+AC_CHECK_MEMBERS([struct mnt_id_req.mnt_ns_fd],,,[#include <sys/mount.h>])
> - AC_CHECK_TYPES([struct statmount],,,[#include <sys/mount.h>])
> - AC_CHECK_MEMBERS([struct statmount.mnt_ns_id],,,[#include <unistd.h>
> - #include <linux/mount.h>])
> -diff --git a/include/lapi/mount.h b/include/lapi/mount.h
> -index 0f7bb5e43..3b296fc9c 100644
> ---- a/include/lapi/mount.h
> -+++ b/include/lapi/mount.h
> -@@ -45,14 +45,18 @@
> - # define MS_NOSYMFOLLOW 256
> - #endif
> -
> --#ifndef HAVE_STRUCT_MNT_ID_REQ
> --struct mnt_id_req {
> -+struct mnt_id_req_fallback {
> - 	uint32_t size;
> --	uint32_t spare;
> -+	uint32_t mnt_ns_fd;
> - 	uint64_t mnt_id;
> - 	uint64_t param;
> - 	uint64_t mnt_ns_id;
> - };
> -+
> -+#ifndef HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD
> -+typedef struct mnt_id_req_fallback mnt_id_req;
> -+#else
> -+typedef struct mnt_id_req mnt_id_req;
> - #endif
> -
> - #ifndef HAVE_STRUCT_STATMOUNT
> -diff --git a/testcases/kernel/syscalls/listmount/listmount.h b/testcases/kernel/syscalls/listmount/listmount.h
> -index aad927f71..e7ef375d7 100644
> ---- a/testcases/kernel/syscalls/listmount/listmount.h
> -+++ b/testcases/kernel/syscalls/listmount/listmount.h
> -@@ -15,7 +15,7 @@
> - static inline ssize_t listmount(uint64_t mnt_id, uint64_t last_mnt_id,
> - 			 uint64_t list[], size_t num, unsigned int flags)
> - {
> --	struct mnt_id_req req = {
> -+	mnt_id_req req = {
> - 		.size = MNT_ID_REQ_SIZE_VER0,
> - 		.mnt_id = mnt_id,
> - 		.param = last_mnt_id,
> -diff --git a/testcases/kernel/syscalls/listmount/listmount04.c b/testcases/kernel/syscalls/listmount/listmount04.c
> -index a6921a249..2b8b49101 100644
> ---- a/testcases/kernel/syscalls/listmount/listmount04.c
> -+++ b/testcases/kernel/syscalls/listmount/listmount04.c
> -@@ -14,14 +14,18 @@
> -
> - #define _GNU_SOURCE
> -
> -+#include "config.h"
> - #include "tst_test.h"
> - #include "lapi/mount.h"
> - #include "lapi/syscalls.h"
> -
> - #define MNT_SIZE 32
> -+#define BEFORE_6_18 1
> -+#define AFTER_6_18 2
> -
> --static struct mnt_id_req *request;
> -+static mnt_id_req *request;
> - static uint64_t mnt_ids[MNT_SIZE];
> -+static int kver;
> -
> - static struct tcase {
> - 	int req_usage;
> -@@ -34,6 +38,7 @@ static struct tcase {
> - 	uint64_t flags;
> - 	int exp_errno;
> - 	char *msg;
> -+	int kver;
> - } tcases[] = {
> - 	{
> - 		.req_usage = 0,
> -@@ -79,6 +84,18 @@ static struct tcase {
> - 		.nr_mnt_ids = MNT_SIZE,
> - 		.exp_errno = EINVAL,
> - 		.msg = "invalid mnt_id_req.spare",
> -+		.kver = BEFORE_6_18,
> -+	},
> -+	{
> -+		.req_usage = 1,
> -+		.size = MNT_ID_REQ_SIZE_VER0,
> -+		.spare = -1,
> -+		.mnt_id = LSMT_ROOT,
> -+		.mnt_ids = mnt_ids,
> -+		.nr_mnt_ids = MNT_SIZE,
> -+		.exp_errno = EBADF,
> -+		.msg = "invalid mnt_id_req.mnt_ns_fd",
> -+		.kver = AFTER_6_18,
> - 	},
> - 	{
> - 		.req_usage = 1,
> -@@ -113,7 +130,12 @@ static struct tcase {
> - static void run(unsigned int n)
> - {
> - 	struct tcase *tc = &tcases[n];
> --	struct mnt_id_req *req = NULL;
> -+	mnt_id_req *req = NULL;
> -+
> -+	if (tc->kver && tc->kver != kver) {
> -+		tst_res(TCONF, "Test not suitable for current kernel version");
> -+		return;
> -+	}
> -
> - 	memset(mnt_ids, 0, sizeof(mnt_ids));
> -
> -@@ -122,7 +144,7 @@ static void run(unsigned int n)
> - 		req->mnt_id = tc->mnt_id;
> - 		req->param = tc->param;
> - 		req->size = tc->size;
> --		req->spare = tc->spare;
> -+		req->mnt_ns_fd = tc->spare;
> - 	}
> -
> - 	TST_EXP_FAIL(tst_syscall(__NR_listmount, req, tc->mnt_ids,
> -@@ -130,8 +152,17 @@ static void run(unsigned int n)
> - 		"%s", tc->msg);
> - }
> -
> -+static void setup(void)
> -+{
> -+	if (tst_kvercmp(6, 18, 0) >= 0)
> -+		kver = AFTER_6_18;
> -+	else
> -+		kver = BEFORE_6_18;
> -+}
> -+
> - static struct tst_test test = {
> - 	.test = run,
> -+	.setup = setup,
> - 	.tcnt = ARRAY_SIZE(tcases),
> - 	.min_kver = "6.11",
> - 	.bufs = (struct tst_buffers []) {
> -diff --git a/testcases/kernel/syscalls/statmount/statmount.h b/testcases/kernel/syscalls/statmount/statmount.h
> -index d21d7f8da..4217a82d8 100644
> ---- a/testcases/kernel/syscalls/statmount/statmount.h
> -+++ b/testcases/kernel/syscalls/statmount/statmount.h
> -@@ -16,7 +16,7 @@
> - static inline int statmount(uint64_t mnt_id, uint64_t mask, struct statmount *buf,
> - 		     size_t bufsize, unsigned int flags)
> - {
> --	struct mnt_id_req req = {
> -+	mnt_id_req req = {
> - 		.size = MNT_ID_REQ_SIZE_VER0,
> - 		.mnt_id = mnt_id,
> - 		.param = mask,
> ---
> -2.51.0
> -
> diff --git a/recipes-core/ltp/ltp-full_20250930.bb b/recipes-core/ltp/ltp-full_20260529.bb
> similarity index 54%
> rename from recipes-core/ltp/ltp-full_20250930.bb
> rename to recipes-core/ltp/ltp-full_20260529.bb
> index 42a9632..994bd73 100644
> --- a/recipes-core/ltp/ltp-full_20250930.bb
> +++ b/recipes-core/ltp/ltp-full_20260529.bb
> @@ -11,6 +11,4 @@
> 
>  require recipes-core/ltp/ltp.inc
> 
> -SRC_URI += "file://0001-listmount04.c-Update-struct-mnt_id_req-support-for-k.patch"
> -
> -SRC_URI[sha256sum] = "048fa4d69ddbe8a94aa15da9bdc85713ab07a0abbc3de2b8bdd9757644aef1e4"
> +SRC_URI[sha256sum] = "685d83c6e370ac09201fb79593412f868fe031ee2890e204b5727fedcf51fb47"
> --
> 2.39.5
> 

Thanks for taking care! For unknown reasons, the patch-removal part did
not apply for me, so I merged manually. Maybe a local tooling issue.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

