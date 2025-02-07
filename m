Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5783AC02196
	for <webhook@archiver.kernel.org>; Fri,  7 Feb 2025 09:40:11 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.51])
 by mx.groups.io with SMTP id smtpd.web11.65748.1738921207129287573
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Feb 2025 01:40:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ZAlIJskW;
 spf=pass (domain: siemens.com, ip: 40.107.103.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+fByvfGT/73eclbLe09cEZuehwzEYL0Asoln89MLu9WWmFeNxEwwbqTK6I/pLvZ/ZV2JezmSFv5Nh34e+9+98ZDF6ennQBiHDUr4WjUnCSeKz2shFhxOOqPJou2Vj2Ok+0ybf3MoPhuGijAl0tcWvrkmIAsJqxwWRdwq2Q/pGNJ1vYnoiDVcjTJq2gHoLmTJbZsHhp98wWJVNFCsSegbOQmk7NPv4SzgcbIYhEPARiOSBHL8evD7Zs2fH9shTDjzqsf35AXgfedZXRcyVCozgOrZZtG07U3l44DR+tHOnUpGNpKZfqjaDywGqdra43GTMiOh9u34Uq0/TgXQYi+sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bs/Uj74t9QPnCoY9n2XOr2ysq6cTRyHHsOCOl9QGG7E=;
 b=oG/fh58051uLbNwLepellvYvyq8XmjNhGfG5otF9fqBXcpo3Udc4kJZ/ZfGtE6xT64g6x3spiHUw68mF9Ehc4QMRzGBVx1oXoTXxAL6FWsK99G9x6dhsc+Bf9wj55lh1PO2tRGsvf1asVoEbDJaBWm6aM9YiB7iyasMxgEnvGMWmUzPzluEPm6XE2PkXpdyHCgPdexWp3nQbCmOl/mgTVwsKNASLDoM7Suj8YP7DVvUypbg2BA8/1Y7W1gAslZwGXSmTLC7rCL36bFAbpYlk0N4KTjFVK7a8QhNtUpUt0yHHFoW+yf6yQrP2Ihay2LV/XEAuX3GB1e1KY6tzm+UYNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bs/Uj74t9QPnCoY9n2XOr2ysq6cTRyHHsOCOl9QGG7E=;
 b=ZAlIJskWbtil37rYBwhSzD7lDalYyC6yNLNQ8pscxS20nnFw4IpJmRoiS2gPfbokzj02IGgqVUtyj8skwPzF4DOumxO1eyImarV15aNoUH3ZaHkWeHcyfQc4qyDZPmld3svwXP5ygbK1y4f2Pp3YVb1l1UAetVFxMYH+6SiKwpzwmDUp4kqgDGGhUvVAwOBU14FcYgAkTSplrSRoM0bKOI/oBcYLJUtdK5qFYBWrwv+EDM9RbPUL/t4NbJ4WUwnxSokVsJU+o2548/ZK5xO06kMj0ffpDlyU3U9zJcOZQ/JhdXYWMOGudslfCyuKFrk4rholQ27gc1S8BKQKLswjZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3137.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:184::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.6; Fri, 7 Feb
 2025 09:40:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8445.005; Fri, 7 Feb 2025
 09:40:03 +0000
Message-ID: <8352ac9b-c559-4fc8-ac98-e05ff43e09da@siemens.com>
Date: Fri, 7 Feb 2025 10:40:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 0/4] Security testing with MTDA
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
References: <20250131152553.270393-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250131152553.270393-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0238.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3137:EE_
X-MS-Office365-Filtering-Correlation-Id: 906084b1-4268-4bc8-0cc4-08dd475b65da
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?M0MzUXVhT1RpT3BQK0JEMUVGWFo1c0t6dHB0Mnp1UkJGeVhDS3dXR1p0T3JP?=
 =?utf-8?B?ZVkwNWUyVjNFUVVkRDhnTm1LdVV6L3ZZSEpvRFk4VmxnNzhHMWRmR2o1VWtv?=
 =?utf-8?B?NkI4UkNTQkM4TVRTUDErZEV1T01Mc0phVDBNZ05DTWllbExuVzNKMG9aYXlH?=
 =?utf-8?B?a2FkNHk4aFQ3R0EwZWtjaTJDWEh6b2p0Q3hUelNNUHFvM3YvbEtUUzA1b3JG?=
 =?utf-8?B?aXZCc0p6akdRRk1oSk9VSHVzTHpqN2lPa3pIOWMzd3AwcU5DYjFsQ0FkTkJE?=
 =?utf-8?B?K2d4NitlRzc3aHJoNThXYmNvaHRxOVFERjlySk1McFVIS00vbjdMNUpTbmV0?=
 =?utf-8?B?eUs0RG9CQzJSVWtGZ3RET0FGUVp4NkFuUU1NbS9hdDMvVVptQTdBRFJaQlMr?=
 =?utf-8?B?M2lKUWt4QitOL2ViZXpDYmxQSC9xMUhGYjhHOFphVms0SWU2NmdRcC8xdTZa?=
 =?utf-8?B?SSsyREU5TmpCbWxNWkpqTEFiSEhzdEdML2VCV0sxZWFWL0dwUGgvNlhVSEFG?=
 =?utf-8?B?d285a2JreklEQ1dvSU5IeUovVjl2QjhCWWdQTyt2TXRyanJGMFJGNkl5NFp2?=
 =?utf-8?B?cjJoSXRtS252VUhPamVObmFTVndHc01VMXFuR1FGMG5OQzlHYzVUeC9TSTFv?=
 =?utf-8?B?TUkwa1ZRYjN5MUQxdmRzQ2lJTmlqSloxS2hOMy9BWHFPb2JreE95bXZSM3Ft?=
 =?utf-8?B?bUxGRlVKNDUvZjdiM1l0bWhUM0p2eHpUWHJCOW9kdFdEUlpoNzdFSytIelpn?=
 =?utf-8?B?TW9TSktXdCsyYTNOdk9PdGF3ZnBKTERNMHE2SG9xRDU1Sm1BUGxzd0Q3aW5z?=
 =?utf-8?B?SkRMaGpwMTVOT3ZLeGZTWnladFB6aTZLRWdubDlMREZpa0hiS0x6MS82cUFi?=
 =?utf-8?B?K1dYazhpak5mRFMvMCtnYmZ5SXUvRmxXSzI2QmFUT3JlY1E3YmExVzF3YUdm?=
 =?utf-8?B?MzJmRStaSzRmaUJEeU4xaUNDbnRQV3FMbUJrS3Qyb1FmUjNxNjZTRGVla0pI?=
 =?utf-8?B?RjBsb2hXV3JlcjhNWko3RmNmZWhqNlkyR1N3RU00SWd0ZHQxbHg2TDA0Qy9v?=
 =?utf-8?B?UCtZaUdFaVNqVlNnQy90NDJTYlYwbTUyVGVDcHJkbktxaGh6WHpHNFJpYjhn?=
 =?utf-8?B?SEh0Q3EwZVcrbVdYUW1pK1VHLzZxNXppQzNjZk1QWHowbzcxZjBOMGM0ZGVU?=
 =?utf-8?B?MjdWVklmc0lOU3V2SGRSc09zbnVYOFl0OGhHeEc0Q1UveW5GSzBWaVA5VkV4?=
 =?utf-8?B?T2RCNm9jeTdVSHprN0VWNU1Ua1F5YmhJekovRnF0ZE5nNWVYRVU2Z2c3RUh5?=
 =?utf-8?B?V1ZrczM4b1gvZnR4OW5DeCt0VWtEaXh6Y3pmc3lkSnNJL3lmVTh3LzBtdG1p?=
 =?utf-8?B?OFBpYnJoOVkzR3pxbExQMW80NXRWQXBRQlhLK1E0QkR3MmdIMEtiNW5zUzhE?=
 =?utf-8?B?MC9aVW5yaVFzdzQ3UDZRLzB0RnBtYlpmcUcwT3JFRXh0eU9HWWl4V3BYN0Qv?=
 =?utf-8?B?UWxUWTZmUzhvT2JsNUlSMUY2dDNaL084UHZPWEIvV2tTZU0rWjl1S1hIZ3Bl?=
 =?utf-8?B?QmwyeU44dThYdDFQTWpGUWlXTy95M2JtdUVlQWpLeVZDMDlZeFJJdTd5V0RY?=
 =?utf-8?B?STBwRlpjTTRBTXlLekgwZGMyS2VMcjNHOHRBYXlaU1pWc21tRzFueVk5bzNP?=
 =?utf-8?B?NHpZcEFLL0pwYTZCcm1EYlRTWGRCMFAyY1JVU25FR0o4c2tRZ3ZhZzJZaUtE?=
 =?utf-8?B?T0RaSUhVdEhGcjFYTUVrWHZBbFNJWUVQYno0dmdoeXg5TDV0SHBrNVl6MWk5?=
 =?utf-8?B?cm1NMzlhM0JuVFdSS1ZMVkJQcWlDZTZkb05hVUZ6VEM1bmo0cTJZb2dpckNJ?=
 =?utf-8?Q?IH0h8SuW1z2Cq?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TFgrQkVLbU9EcWtGMEh2c3lqZm9yL0p3YkJSQW1YRGhtTzRVMUhGcjlPMlMr?=
 =?utf-8?B?NGtwaDhHdkE0RXRhdW5UaDZ2VTVicHR0NUNDS0t6RnArakJ2M1E0clU3S3RY?=
 =?utf-8?B?OVJvYjU4MG9CMzUxUVJ3YzhTTUVmRU9mbGFBNS9NN1lveVBCVzhvUGJhdDd1?=
 =?utf-8?B?UlhFRWxFZ2RYZlRvcFZuWllVQTV5SnVnZklyZUNpUlFtbUh2dGdKTFJSMXZB?=
 =?utf-8?B?ZDYxT2RiMVZNMVBhelUzblBFN0s5ZW4vUHNrY0dwU2FGZWdDd245eXNHSXhM?=
 =?utf-8?B?N215OTBPU2lXc0NrM0JoZXhlTFdYSkRjaU9NcnIyaG5BUk53YktLa20rdG5M?=
 =?utf-8?B?L2JTQ3RYeHlVdXVLc3ZUa01yNEJ1dU5yQmpzQ1Q3bTUxUE1JeEVwS2hQM1Vh?=
 =?utf-8?B?REJtRTF3OEkrQ05nUllBeEVQb01nZzRnblhUamtleVFEWUlrMUNHZEQrd29n?=
 =?utf-8?B?TVRaeFpQQTJIblhFUDFiYktaWFREOXI5L1NsOTVSL3NUWmRQYjBKcnZjck5k?=
 =?utf-8?B?Q0Z2ejJKRy8zOWxrUzNhcG03V01nOXdjSkZOS3hCMWxYdUNGZHVtaDNRWDIv?=
 =?utf-8?B?STlJQmxpdmhnTjRRV1kvMmUzQ3p6R0ZoMGI1em55S2ZyZmxtWi9wYVpac0Jo?=
 =?utf-8?B?NVg3UWhYZW9GVDdZZnk5R08rdjFsS0lXNjZsTk1NWmNVdmZmWVJIUnM0U1dv?=
 =?utf-8?B?ZXJJcnBsRFZIVklRUXhjSXhpS3ZFZGdWVjBudUlIaFEwNXJJcHlndWxVL2Nt?=
 =?utf-8?B?VU1BRngvcTl5YjZPK0k5dFJrK2t0STRLYUZTZkJuaHBEYUhadjRnWVo2NG5L?=
 =?utf-8?B?aVRKWlF4OGxKUE5rODhZNDhHYzFTME1EWjdUczBvVWF0MHJYa05mVnJjeC8w?=
 =?utf-8?B?Si9ndDl2S0pGejI3TW5IYjg4TU8zWElyY3p4ZXVsN0o0VCtxdFZJWmdiaFlq?=
 =?utf-8?B?QkNZcVdUeGMxMkV6dyt3L0dZSUtGaE5VOGJMaGRMcDh1aWdpNTdWaHB6Kzli?=
 =?utf-8?B?VTNwQ1BBdEpiVGpjRHVqK3d2b2daRFdFKzI2RzUvb2dESFZDVmVpeFc1OE1J?=
 =?utf-8?B?SFNKNG16T0UveXhLZUkzdUIrUWVWNjJHbGx2VDVVekdxbWdGR3FWZG51eTJF?=
 =?utf-8?B?L3pNa01yR0pSZGlTc2V4S1o0Wjlkc0hiU3VtTW5sWXorR2FSV2RwWVBiZXVZ?=
 =?utf-8?B?czNkZFU0dEJOb1ZRd0hveUcrajZVK2pHNlpFaEEwZ0NVRWNRSit5b3Y1T2FN?=
 =?utf-8?B?OGpFQ2VMdEtVNWc1RlZ2M0R2Q01PS1hJR0hncXUzdG5GemZONDdjeEk5dU12?=
 =?utf-8?B?N2xSNkxvdUo5bVR2Q2s4cFlqK1YvRGQzVDkwYk5raGg3cU1CMjJrY01yQnl0?=
 =?utf-8?B?dVRLSk5KeWxWOGE5Tk1zM0VTOGN4SlhVYkVCWlFOWEsySFlUU216ZitsYnBM?=
 =?utf-8?B?cjJmaWZrQi9PMk02STM3eEp4bWdZVk16YkdxaGZiUDJZb0V1Z1FTWmhYZGEw?=
 =?utf-8?B?ZnJscEVUaG1PdE4yTG9aZ1ZoYXkvMW94blRZRkZLVGFsNTB6aVF1aHRtQ3cz?=
 =?utf-8?B?d1JuTFdEaTQ5SkcwYWZGa1dvRGRzd0h1eTRXdkgrWWQ1cndPdjIvQ1JmUDZk?=
 =?utf-8?B?aXNmY21MYXlFSWpQa2FMSThud3BxQy9XZnYrQ292SlJSTE9jeVhiM0ZWY2R5?=
 =?utf-8?B?a3FxTjVJV09zSy9lSlRCdzVSVVp5N3ZqN0p2UTlyeVJha2pPaEZ4WE8yYWdH?=
 =?utf-8?B?d3ZVWkVBOURuMk5RTTZ4OE0yOUh2cDUyd2syeWFoSHlmd3FCUVNwa1Y4eFlX?=
 =?utf-8?B?VHdlVTg4RUdUc0oxbGVyMjBvbDlPckJPNW84MHVMbEhyaXhOaEtzTDdnNVZO?=
 =?utf-8?B?TURTdk9xSUM1YUVmOFpYVjdLTVhQK1dJSTR5THNPczlyMnZPZ2dvd2ZBb1dr?=
 =?utf-8?B?VWVEZWRPWkpGT0hkU3dBdFhOU1lNdS9KZnF4R21QZDBmY1ZhekkyQzdGUmow?=
 =?utf-8?B?NExZMlgvRDdHbHRXZm9ZcnloNUJYSDhQd3ZMNzdiSFlCaHNPTWtrTFZRb1dh?=
 =?utf-8?B?d09jd3NIb2IyWGpzL0xJY2RsRHl6ZmNYZDc1azk0QkJzeGdmSkc1UDZpWG5M?=
 =?utf-8?Q?vnVDLKP6JWasn2yaDL9pmLTSM?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 906084b1-4268-4bc8-0cc4-08dd475b65da
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 09:40:03.4140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o6560ER/20x7+aT9J8fEF/CP4tPOe9nt6E2lz7OH5awFUMQyO8hzA2gilXYjMOaDQB7wZg6MAGRyivrJS3uKCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3137
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Feb 2025 09:40:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17768

On 31.01.25 16:25, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> 
> This patch set builds an image to test IEC on the mcom device with
> secure-boot and disk encryption enable.
> 
> Changes v3:
>  - use separate kas/opt/security_test.yml instead of test
>    as test.yml adds an extension to the image name and these
>    images are used by the kernel tests
> 
>  - remove qemu-<arch>-secure-boot as the qemu-arch-base contains
>    these options by including kas/opt/security.yml
> 
> Changes v2:
>  - move curl to kas/opt/test.yml
>  - add test option to gitlab-ci.yml
>  - rename disable_watchdog to watchdog
> 
> Quirin Gylstorff (4):
>   build x86-uefi with secure boot
>   x86-uefi: disable watchdog for testing on mcom
>   kas/opt: add new option for security testing
>   .gitlab-ci.yml: Remove unused build jobs
> 
>  .gitlab-ci.yml               | 45 ++++++------------------------------
>  kas/opt/disable-watchdog.yml | 15 ++++++++++++
>  kas/opt/security_test.yml    | 16 +++++++++++++
>  3 files changed, 38 insertions(+), 38 deletions(-)
>  create mode 100644 kas/opt/disable-watchdog.yml
>  create mode 100644 kas/opt/security_test.yml
> 

Thanks, applied patches 1 and 2 as well as version 4 of patch 3. Patch 4
was applied earlier.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

