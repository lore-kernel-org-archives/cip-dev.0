Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74A1C5CFDB
	for <webhook@archiver.kernel.org>; Fri, 14 Aug 2026 13:03:07 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.60])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12273.1786712581501574439
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Aug 2026 06:03:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=JxjCm1qQ;
 spf=pass (domain: siemens.com, ip: 40.107.159.60, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CNBryiY9xoOoJ1seihkSj8LrX+HHoEMhvHfIHmTE8OL8+97dY0wYriAflxA6vSv6j29HT3yLiM6U8RPxE9SZlIEAZSUFcxAP459QfhxLQRnQYob9mloR0sMBTLLfsGHD/KxT31qTTN6G+uDX/Vk93/skUAodPNLbpNq8Pkw9vuyXFsi3RdpAjCnSQZQLXQulmpIs6cydH64IAD1Drc4YO/1j81MDMU/xXRwpomWReKYAkzVcjK2FMPSpFLAVl002EnHXj5XY1yaZjgOicbxfHiO3U/J+H3j2lpTvgDE06G5f1/k4kWRC8BFgWBhyfSkmoay/GGoozTW+16ZLu1vqXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpNRtfr1PxxakyWUPveTs3vS+sMDAsqzUB9YbvTHOD4=;
 b=hN+M0U8NIXTnCjuAGgA6yGQVOaB23N/EvpHtI6nTTR2dyC2czRgIqLB+MCJnr0NVNsi+npon+8VasFJWLSda+lzoDpnCHCdRwqbKOPAW7zyFceGXrgxrmaZqk+QGS0S+fhbU3+lq75blMSSH+AhexJU4xUhlthhtMCXXTnBgVu/Khxc+004FgiCqTWXJhdW0plHB6lgBeY04vJ2B7t589CnelJBtccgcpTrgFWCOYBtSVWwdTBpkUIWoqtOCviFhKKFZz0r9MdxgIAFlqO5M1oK93Li4lHvksE1nfg9aRXM+ml8BXsXYfeLViY8Ccpt2CjuBTyx1UNnQGBluO0721A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpNRtfr1PxxakyWUPveTs3vS+sMDAsqzUB9YbvTHOD4=;
 b=JxjCm1qQC0d3iDMDRmLxUdpi3lBPO3dwuiIdaS+Efpu+8+W+PmQgtmtCktAl5OqEHB/0bLJmQtXKIVUkn+MLK2mwCi49TEplo91qt68YEMQxgjtBhxkt/7wB3X694gOopwffqXHGQZNM6fxKge/QGomZpyzVROPk9mHvcTCyPPPT/Nm9ZeGHu9JgaCZO1WeUexDtGO9V5lHRlt+nDFyPqcU7qVbiiLciT1RYGq8QwVxY3FdIFlPxC9r0jNbiMORqIdNzgKDnNngGvVizkNWWWmvwcY3Ig2/2NXV1KWVuTAW9eTShhyx/Uakfy07v5Lty4hUCHqlvXG5pmZ2BS193sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB3PR10MB6906.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:43f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 14 Aug
 2026 13:02:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0315.012; Fri, 14 Aug 2026
 13:02:55 +0000
Message-ID: <319652d6-f0f4-48bd-9321-e06517580fea@siemens.com>
Date: Fri, 14 Aug 2026 15:02:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2] recipes-core: ltp: Update to 20260529
To: Gourav Singh <gouravsingh@siemens.com>, cip-dev@lists.cip-project.org
References: <20260814120649.905245-1-gouravsingh@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260814120649.905245-1-gouravsingh@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR01CA0023.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::28) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB3PR10MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: 69d80cb5-5986-4d80-b66f-08defa045b45
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|6133799003|22082099003|18002099003|55112099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	RdhJir3j/OV3sEOTfqqtKTKF7KHUOq0D3gqhgupNU6vo37AvESBrBeXttjF03W7iaARijI/tiGQ+haSDFT0Mb5QMGfg6icUxzLuWz6qC4z+QU7WchGgYzQkE2GfkzmJUR+osjjCXu+97hECgLge6gvwHSmjMNliropK6pBWx7bZ2wBAYBXL4sHtrMDDYVpgfkkTp+9WFPMHW6OSTtsIsJ2vPXUm+zeNAZqmeWts7gS0KT9Yed+IZO1gnACnCDhGWvhc02BKzu6V5MuXiqEKg2BWRjwWX5eORJWK7Pt4LcMM5xooZAPitl1qQ2xb9u20Rg7fX1hVPzzf/VeFz73fA+nchkriLZeqaB25W3UyBFIePtS9GCQ5oMhPC8P6RGtspkt4bJAviEd2m3R8sOx57vra7iHIXth/uI3KdjXOSffGWUwQb/Fmo0sA0IRRTpoBuFMBFagLwJwViYZDmfJ0t3HuyG3SPfSeAROq++kedPGlFtu//ebvS+g+ddv5SEWF7qPNLt7vtISa38xaEgGpSqkq9rAzNlJIXFlfamQwA3H989oXiBVzv7X2/Qu1EZTxFlEQCLk9CS4smAVn/jHZ6zLxuS3tx2cMc1FgpmYwZbhU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(55112099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VDJMY1Y4TlE1QkdVYXlXNzQxb21JSUNLaXJRcnViU0hmUnlOUEE2OEZiOEJO?=
 =?utf-8?B?NlBjNDJWTWJzVkp1Y2dUNzlhdWh4SUJ0bGlyWUNuWTdFdjFIQzVFbjlwdzBs?=
 =?utf-8?B?NkxvK3lUdjlCR2ljT05kakc4alFsc0VuUGZnN2tBK3J0QU1JNXg2WVI2ZFkx?=
 =?utf-8?B?ekIvYklqdnVDYVIwUjB3dk5rUG1PdWpzdjNGVXpyUzZQVFpDUzIyY2plK0J6?=
 =?utf-8?B?NFBGUGVveXQ4ZTZVemFlWHpVSFlKbHRLNEZqRjdPZm9na0x2VGpQczBVcE4y?=
 =?utf-8?B?Mk5tUlBIOWl0Q0E5VlRtc2J1d20rb0ZPU0hIL3ppeWxPbXk0YUFBKzdhd2dz?=
 =?utf-8?B?SFl3RGpQc0JXZlk2bzFnRVBtL3d2RXlCWXpIeXVOZlpIUm1nYWpNUFpEWUQ5?=
 =?utf-8?B?WmNIL0V5MHBzVmRNMVNGVjltTVVHSTZVYmpDSVpNVXRjcXlEOWZwbWRaeFln?=
 =?utf-8?B?L1VYZUN1eHlwL0h4aklrd283V3pmWEM5Vng0WEhVZTNqaG54WjR1TVUzdU9O?=
 =?utf-8?B?b2UvQ0V1QmxEQ1JtTldXajhXaGFad0FJcTZYNU52eGh4ZlB0V0FRNTJFNndX?=
 =?utf-8?B?emk0RVZ6RnpCdzdJbU9qQ2hyaGNlaU5yZHpITENRaW9YM2hZUzdVNXhVeTdT?=
 =?utf-8?B?N29lZGIxVFV4K2xNbXFBUGtZakRiVWY2MjRqK3Mxc1BWQkY1TzhVOE5iRmdO?=
 =?utf-8?B?ZXlqdTJLZWtLZ1ZKZjZrRHc0UUVZN3g1N1huelRrRUJwY1JFcnp6RG55ZW9x?=
 =?utf-8?B?VWliYnpTQ0JUaWh5bFFyU3JpSHhHQVBjR3FhWnJ4WWpwQ1ZFOWJTUlZVVmhi?=
 =?utf-8?B?TFZVazBSMWFnMFFNdjhIVjRoTWxyZXBEVnoxU1ROMk93SlFJSkZZSXpWMDcy?=
 =?utf-8?B?c0FuRFBGRTlGSlA0SFJybzBpdVVHd2xXZ2dGQVZGY2JmYnpNckxuNzNPcnVF?=
 =?utf-8?B?aTlIekQzUm0vbHBwOWR4clBiblhaaW5KeStpSURWbmJ1NUhrQzdzYnBoV2g4?=
 =?utf-8?B?UTFsQThSTjJsczhLc094S1p3dVAvK0t1dlJqbUY0dUllSmdPVU9wZTlycTBQ?=
 =?utf-8?B?Vy9RR1FDdS92UEQ1TUkrTFhBbnJsODRyYTU2bUd1K0RzQ21YVENXc0JkOWJY?=
 =?utf-8?B?UWVXZnZuRDhIdDJCd0d5c0FnZkxlaFRPdjRlS0dmNnV4KzZ6V21rc0ZBSytB?=
 =?utf-8?B?VDRNajA2ek43MVFhakV5dmpMNmhtR3VnelF6VUpVMzVUbHQxQlNxTXRkbUhj?=
 =?utf-8?B?Q2pISmh5ZEVBZnQwQ3VqVWszR3JNMzdkM1NqdnVtVVE4Y2hWMjhERDNXQ1Na?=
 =?utf-8?B?Ymo2TEt5cXJKL2w5c1VtcHJJWlJmU0hjY29pbkZtZEF5eGZWSjZZcWxnMkQx?=
 =?utf-8?B?d2I2QmtsUGNPMWZzWGVFd1VxS0U5WlVCOGFESmMzTldzWFhpTy9PMytIRDlY?=
 =?utf-8?B?Wk1PTHpvVEdreHNWT3FaclI4NnZ3eW9tQVF5YWRaRWJPaEMyVEN1M3IrbHZH?=
 =?utf-8?B?bE5INjlZbnFERWRTWlU2YVArTmJPRVZtendHdXBkY1FQeGVxYVlPR1dwVVlD?=
 =?utf-8?B?TDhwaGJZUmM5OFIxZmNHVEVXL294RE9YcGRQTlJMU1NDTTl1VkJRT0RnRWFE?=
 =?utf-8?B?OEpOQkZXWmtkbFg5QnpPM3V6RCtWRzREMlo1YTJ4N09rUFFEODh4UkdkSjNZ?=
 =?utf-8?B?SG1mQ3J1clBLSTRYRk1TZEIxdzhmZ01zeElJYjUyTGYxZjlucEhNVFQzYzFq?=
 =?utf-8?B?QkxIazc3V043Y1NRcWJ1WVNYcEhsd0hPMVppQkFRd3ZVQUhPWHFVblZhU0Ex?=
 =?utf-8?B?ai9WdXg4akVUMHovM3F5ZzB3V2d6alloWW1UOWpxZnlrZjlHQkQ0UTZoWWIy?=
 =?utf-8?B?ei9qdTdjZ2wybnR5OFdlVXRTRmRLbFNwUXU3Z3JtRStkZko4L2xqUXJaRVFN?=
 =?utf-8?B?T3JaMEoxQVBWN3FiQjlDZGlORG1zVU5rSnpTZkF0ZmFRSmFITjUra3huUG9q?=
 =?utf-8?B?U2RKMjBrbDZQSE5VQUVQQ3pGRWttWm5aWjVZVHQvTVpmYndNcVFxeUgyR0Zn?=
 =?utf-8?B?R3p6eFJhL1ZFR1paK24yWmgxaGRScjhMVFVaUUxUMUVXbEg3c2I1Y1hLZlJp?=
 =?utf-8?B?UEp4NHVjTlk3ZldRZEVqa1FLOHMxOVRJQkNLbWo3QWROTkpTVzBiNHl5NUxq?=
 =?utf-8?B?cDYycWNMUk5LMWhtb0RZRFNBREx2d3dsbFNMZHhScjhtbnFsdTFCTFZESzZx?=
 =?utf-8?B?eVBCMHNyMk40QnhzYTZJeFAxTnM4b3dsbXZSOFdDbS9iRmFZNmJYUzNEelZO?=
 =?utf-8?B?M3VzS0ZQaEExSVRZUnZQdVlCWSsyeUdobWprUXF6YThWZWk4bmtoMVJYN2Zr?=
 =?utf-8?Q?juRBTHD4nxfPdw3A=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d80cb5-5986-4d80-b66f-08defa045b45
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 13:02:55.3650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GA+Qc5GdFELmmMjtq2ysMypQ4lQX0/TchjsrrkfNq7W53Va6AEW1wTEKXuBotURq26lIGXkGRlpzXlTZk5kLIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR10MB6906
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Aug 2026 13:03:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23942

On 14.08.26 14:06, Gourav Singh wrote:
> Update LTP to release 20260529.
> 
> With this release, runltp is deprecated and kirk is the recommended
> runner. Kirk is Python-based, so python3 is required to execute
> /opt/ltp/kirk. jq is required for parsing/inspection of JSON reports
> produced by kirk. Add both as runtime dependencies so LTP/kirk usage
> works out of the box without manual package installation on targets.
> 
> Debian buster compatibility is preserved: buster provides Python 3.7,
> while kirk requires Python >= 3.6.
> 
> The listmount04.c compatibility patch is no longer needed, as the fix
> is now included upstream in this release; drop it.
> 
> The patch was originally added in:
> 2647471156b128bf8b0fb1d726bd05099fbbe1bd
> 
> Signed-off-by: Gourav Singh <gouravsingh@siemens.com>
> ---
>  ...date-struct-mnt_id_req-support-for-k.patch | 195 ------------------
>  recipes-core/ltp/files/debian/control.tmpl    |   2 +-
>  ...-full_20250930.bb => ltp-full_20260529.bb} |   4 +-
>  3 files changed, 2 insertions(+), 199 deletions(-)
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
> diff --git a/recipes-core/ltp/files/debian/control.tmpl b/recipes-core/ltp/files/debian/control.tmpl
> index a7d0087..039c6d0 100644
> --- a/recipes-core/ltp/files/debian/control.tmpl
> +++ b/recipes-core/ltp/files/debian/control.tmpl
> @@ -11,7 +11,7 @@ Homepage: https://linux-test-project.github.io/
>  
>  Package: ltp-full
>  Architecture: any
> -Depends: ${shlibs:Depends}, ${misc:Depends}
> +Depends: ${shlibs:Depends}, ${misc:Depends}, python3, jq
>  Description: A collection of tools for testing the Linux kernel
>   The Linux Test Project is a joint project started by SGI,
>   developed and maintained by IBM, Cisco, Fujitsu, SUSE,
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

Thanks, replace v1 in next with this one - and this time it applied
cleanly :)

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

