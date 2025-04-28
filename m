Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46819C369D5
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 12:19:59 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.58])
 by mx.groups.io with SMTP id smtpd.web11.46745.1745842795822733078
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Apr 2025 05:19:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=GnaNeZSB;
 spf=pass (domain: siemens.com, ip: 40.107.247.58, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y4rzW80ztFVFgrwerfahiPF2t1PngUHR8FWSfaQ/sKzeiurtwTztFMl6EkVvSzml0g4DI6EvU/6Y0uUgAdA3t2oBFESLLUHqygjhG2ZZcAp9rrHr+WM/Y+fzpTYtpDls65gk1KE1Yr0SGIQuhEpmKQzpIsQHBSR13B/SplgCimWjKcJy7hA8t5b8C3zS9ALiqeRLA+QBjIDcH44pZlCymQRRsINtR5UH/n2lfP4PsrC0KEElTaWciSn3vnPxy2yx0nUuKFbXw6E5LY1fM+RSd/HSaVnNq09xMNCsMraYCzKOG1dkPqWHUTxf0Wa7+pX6SRWdTTbe90y6URyo1w1R8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnJ8/v5cOAG7SPEzCJU1KbW/JuS7pyL/LK+iJGbqn9Y=;
 b=fF5eNldy+BlX0Ri4CEmEpNZFhA7yrRYyU1N4btbDMchGMOZjMJgnqkW1/swLKRmu/IH9J08heq7nBniNEc+Vp2pWXboxq68MlVJWd3+d2opfN7nVcLM6FXu6VJqphjrbhwfGhXC6crpXvmdtvm+KH5sr3GGOCuYyve94abNvIwBq2CC3VJ4CMEMZOBpbCfCS/MghxG08Z/TAAT06FIt58XeWUCC93Ao4eusSwjBbsV8/wasX6BqO3tUCV52pfODmnZ72XdQohCRbgKIcG4Qk/Q/x+7Epbhcpxn/WxT8oxXtnxk8dQNTqdr0Wb5IBedWaee/bwkqYcRtYZZxsA6hx+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnJ8/v5cOAG7SPEzCJU1KbW/JuS7pyL/LK+iJGbqn9Y=;
 b=GnaNeZSBNQNVU1rt9VO3immI0+CBGuiAYVVjj1xbOdFnqP6WEOFh8RRIPO4YaTfVDCKhXaOMS+ZW/8QusrFgHGj7H7kA17vmZtiE1TAGIkzgb+mgdwTEma4cFrYnz7mAQqTxzzvOp0WQP08Fg0n5/3BHDU8rFKBmEm3o2MQEBv1FCLlFyyTpFVsf4ZLOKzLIy3BVXmQKWPaS9+9XAdZ6RD9C97kATTDQK+/VJ50kwmsEjLVjDnx9MyzP0yfuKiIF4bb3LMGyO6AJOHQ5a+gKUo3ihEjgHjKgJ7IFQKsMnmwYxRdli70gizM3Pv4GKeUoDqrYeoq7NvAyWBnjzzNhrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DB8PR10MB3960.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:14b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 12:19:52 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%2]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 12:19:52 +0000
Message-ID: <229d8f0c-0dd4-41c2-a377-eaf218cd7293@siemens.com>
Date: Mon, 28 Apr 2025 14:19:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] wic: Allow to set the binary name
 of the unfied-kernel-image
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20250428114201.3210740-1-Quirin.Gylstorff@siemens.com>
 <dcbe3ee5-7b4d-465a-9742-9660ce673aec@siemens.com>
 <eb95a2ac-f002-4e9a-88c6-aa901be15850@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <eb95a2ac-f002-4e9a-88c6-aa901be15850@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::17) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DB8PR10MB3960:EE_
X-MS-Office365-Filtering-Correlation-Id: 934f8dbb-c2f2-4b28-a1f4-08dd864efa51
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ajFrcEtaY0l3ZHR1dEJYanlHMTJpSThzKzRaQkZFNzBGQ0lqNnVYamcyMVNE?=
 =?utf-8?B?T0Z1RHdwcllrWVE1YTZ5WWxUbC9vNCtEUENZNEx4MjNNejdEaWtyWHVKcWRZ?=
 =?utf-8?B?SHJYOUZiN3g5VFlxakxtc0U3NDFIRUZ6N1VMR0s0OWk1RlZxUXBCVGNJV01T?=
 =?utf-8?B?S3VwUFM1a2lPQ1ppTmw3MkFPYVRNK2F0Z2lYcjFSeHF1RWRYUEdIZVZKSkFB?=
 =?utf-8?B?cTFKc1hNODBBR0F4TVJ0b0VWcVpPMWQ5Y1FqaU1ZV21xTzVXayt0SG1mc1pI?=
 =?utf-8?B?cjBmQU1oZnBhUWNGR0xNd2JvN2dlemIwK1FMa2tmQnA1amVWekI3OHowNG1u?=
 =?utf-8?B?bWpPUFRWRlRCMERXWFEwOFNZWi8rcjhMV2xvQkJiOXMrbEczd3AyRzIxd0hS?=
 =?utf-8?B?YzZKc1J4RXkxUnc3RkhMZ3RHMUdyMDRaUk9pbndKZjlkZmJTWFZsRTZDUkNW?=
 =?utf-8?B?R3ZKV0dWbzV5dW5hbXV4NldQSU4zLzZIZ001OTdYQXVNOVJtOEhqeGlZaXRk?=
 =?utf-8?B?T2xoNUJ6LzVDTDhEcy9NTHJJYTMwMS8wcHk3ci9HNzVhNlFKVktOWmRXeDl0?=
 =?utf-8?B?VW82ZHRXRFdoR0IrMzZrVVQ0L05Kbkw5Rmo5ZWxUVnlpT1V2NENiMWFKSE5W?=
 =?utf-8?B?bEtGNnlMTzVDbmcxSjZFT2M3aDM2ZkRzMFBMamhuWW1aRmlRb3I3citrRDFw?=
 =?utf-8?B?Y2w2TmxQT0JDb1BTNUd0T3N6cWVIajhlWWFtQW9mTGFWdUxPcy85RlAzY3Zl?=
 =?utf-8?B?QTc3Q1hETjhHbldXNUE3ak5Td0JWS1d1Q3NYc1dsVnhMMGpnRWF5SWFCK3BL?=
 =?utf-8?B?QldOUm9kUVZyMkJScUFoS3htKzExWDZjMCtRbUJKT0NGZWZHc0NlR3ByWW1C?=
 =?utf-8?B?UndicnNLM2FveG9ENS9TNFdRbWJ2UTdQUDRnelRmdk0vTHN0bDcrVTIvcjdp?=
 =?utf-8?B?Yzc1VnZ4eWp2aTZYNG90TEMzVWtNT0JuRUkyWGE4RDZPM1JGN2YyUzk5ME5D?=
 =?utf-8?B?NUFqcEtmcldMdEk5UXQzMDIwKzNNVkpiaEVmeGgzUkJsb3dIQS9tWnhBR1Ri?=
 =?utf-8?B?dXBmWm5ldVkvMVVJVXRibFNVNC82SmhESWtLbDVKL0xCTG1zVWN4MW9RTm9k?=
 =?utf-8?B?a0dOckRFOEFVR1JHZUJOZDc4ZWN5U0FPckZPS2RITkFrT1dJTHNwaDZMTi9L?=
 =?utf-8?B?MTI5VXkwUkROaUsyazdpQ1lIVjhPTHczRXhSMjZBMnJpeEdINUNnb2k5KytD?=
 =?utf-8?B?UkV5NDZ6WkoxNHFjMWVQMGpYOTRlTVZBcjNsM3hrUFZXYmtVekRBam5hTHIw?=
 =?utf-8?B?RWcrbU1HZlQwUVZsWkYxWERvcnBuQTRGK0sxWHp6Z1R2VHoyeFFrK1ZlVk05?=
 =?utf-8?B?ZkhxbWo5RVAyTUtadVM2OEs2YVdqS2ZCUXpnRmpvVnpBWC9ibTg1QkgvK0ZK?=
 =?utf-8?B?NjFSRmdYdHFDKzFtdDRHVkhyWG5HSG1NaGY1T0s1ZDFCOGJXZ3QrekhQd25v?=
 =?utf-8?B?RUJBNm1uYnJFRXUxWVdocXErc1laVDF1VG9rMVNQcVZ0RDkzZEFPR3hSczA0?=
 =?utf-8?B?RzdGeDZ0dnFWWlI3Yk5ic0FxN0VoZnlqYUorSlZMUnFNTGdrVzdGTTZNL2J6?=
 =?utf-8?B?V3NYNG95dXNFYU52SmFkQStacmFaaWFVUlJKNTVGU0pvUVd4RDAwcDk3TXpH?=
 =?utf-8?B?SUdnV0VvU1F6eFN6TmFCblVuK3d5YW1BV3BBZWZMK25OWXh3ZmxpbDFMVDB5?=
 =?utf-8?B?YVE3ZVBTMlF4MThKcS82ZHJqZHl6a2kzbXBYNHFnODlKMWIzVVEzU3JZSWE0?=
 =?utf-8?B?c29nbjVxZm5ZcGZTdnRIU01QVVdsN3BzUWI3ZzFVK29Hb3dmR241US9Bc3Qv?=
 =?utf-8?B?SDVZR3ZGVHBxd1plSnlUL3hmYjRUekJuL1dUUDFRVUFUcmd3alE2eVlHaTdk?=
 =?utf-8?Q?a5ikjHa7iSM=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OUNCeTFyVUROVm5rZFlQM3NPWXQ3c3VqMHFSUE9OeHEwZmpVSVRSS29oVGpG?=
 =?utf-8?B?aU1CUUg5UEdmSHIyWVFXYTd3b0ViVThub3g0OVFkY3Zlb2pacHZwVlBPY3ZM?=
 =?utf-8?B?Mm1sWm1kNlg3TTZOalR3UTFNNlJET3hzRmh5Y3RWSEdRVXluSUdmcXd4UnhS?=
 =?utf-8?B?VlZqYXk0ZUNhdlNlVXdMdGU0YWJtUzlBRXpqWWsvWVZENExaZWlMQVFUcVc4?=
 =?utf-8?B?Z3JkL3RvSUVyWldNTk9wbFBVaDdLZkpUaHdJZXFyRXlMbTFnZzd3Y2V1MXNy?=
 =?utf-8?B?OFllU2swTThPZ1g5STUxZ2xlOW1Pb3lyQU5Wdm5iOUVVU0tlTGQ5em9YdHV4?=
 =?utf-8?B?bEZweEhsZkhRSmw5c2dteHdsRE1jQjEzUEZlRDNIcTNPV2d0Q3RoSTNEZG9X?=
 =?utf-8?B?cklEbjJkSldLUWsrcVhoektuSEppbDZEZWpJbTVJRm96dkN2NEN2OEZlcDVS?=
 =?utf-8?B?WTlvSUJodDBLQzdoUEtuMWZCTUZMM3ZWT0ZoeW9SWm5aLzd1QTdCQm1MSkRV?=
 =?utf-8?B?NFN5NXBYQWpJRTdVRXV4WWFrVHBTSSswVnZydmFPMVpGVjd2T1kzRjkzVHZ6?=
 =?utf-8?B?cENCRVErbHB5ZmpMSDJHNXlORmYxeHVldC9nK3JaMnFVV2hHY0N6ZUxDK0Vj?=
 =?utf-8?B?RWpRc29XUG9ySFBnaGFiM3p2c0drK3lubVBZN0NsYnhyVGhBN3V6RDJIUGJQ?=
 =?utf-8?B?Yktrak5DTU9aZXpLMjZmbmlRNHVYZ0srbzRuczFSTGlPT1YweHVlQmdIQ1Bh?=
 =?utf-8?B?d2psYWdhWkRxVDNjbFZURlFmTmkrUDhKS3I1WkNYMDRPMUpubFFwRFRKK25Z?=
 =?utf-8?B?YlpFdjVvbDQ2MkNmQ0tZcGNyZW5FdS8yRHlFWEJsS1JDTitSTlc5b0IvK1V4?=
 =?utf-8?B?U2RUL0lRZXIzY1lrMWJZTFlBemprU2xFNXRnYm1oTml3ZEpaZzBPRkp3eS9m?=
 =?utf-8?B?TDczYTYyWkFnZjRHSTFJY3IzaTJIUmlsU1lGcCtRSkN1RG93bDFGTTJyOFFv?=
 =?utf-8?B?bWRuOTZFazZMRmVrb1EyeStzbmUvSWdFNWRXc0NjMzZKZ0x6UGVvbmx1NHVS?=
 =?utf-8?B?ak81QVpxTWU0dVhOVnFHM0hvR0dZT2U1VWF5SXpxbUIycnZENjZUTjlKaTlE?=
 =?utf-8?B?U3pGNjFoNHZJSUI4Q0d4NHh6TG8xcUlYNjh6V0h2bzl5RmtzYnUyK1FGTE5s?=
 =?utf-8?B?MUNwTHoyR0YxMnJlS05KQ2RaeGdBcTRVMXk0UDAwVDVJS21Sa01YQmVSc0h1?=
 =?utf-8?B?TTljc3VJUHRmK3FvMU94azdORVRlLzM2OEFUNlR6bWJFYllyS0hkT0REeVRt?=
 =?utf-8?B?Zmx2OHJFc09mZEFBNTJFTGRvMmRNSFBsT3JuWWVhK2ZXNUhsL2p5YUYvL1dV?=
 =?utf-8?B?dnBPSWZTL05oWGpzekhHZTJTVjNHR1o3aGxwRWd4WjB6Uk9rSmFkN1NsbHM0?=
 =?utf-8?B?SzFlS2l1TTVxbzNXSG9ZZTFHa3M5WEJSOXE1UmVJNnA5TW92TElsVWxmNHZj?=
 =?utf-8?B?VzlIa2IvRkp6ME9vRmpraVgzVUcrQnZZRWYyRVAvSEtDbG04R21ZbHFkeExX?=
 =?utf-8?B?UG9CR0llY2ZkWTg2WWNDUXF2YWZHSDNLU0R3YmlNN09hTHRiNnJTU3ZtOFgz?=
 =?utf-8?B?dHBaVDU0bDRtVGhQd253cDdGcC9OeFFkYjZmRHF3NDVYOVNmWW9HK1VhNWZZ?=
 =?utf-8?B?ZE50L0V6T29OUUdDZ1l3YlpLcXRBU1pIOU1SN28wZ3lJYWZJS01TK2d5dTZV?=
 =?utf-8?B?eVJ6VENsS01OSDYyZ0EvQkNXc2ZQUjNjZVVhTExHN0tZNUZtU3kvWTFxVE9h?=
 =?utf-8?B?cExVUGJ0VHhhWDZHMnB4MjFXSFE4QUFON3lDTENQOVJwMWhScW5vRW9pYUVO?=
 =?utf-8?B?Qm54ZGxSVTQrN1VkRFcxUUdBVklrSlg0VWhZdXZTMnArSFkxaWY3cFFpR01u?=
 =?utf-8?B?SmhubXNZYUl4WVF4MHJyWnpTYjg0ZEhCcVAvb3ZvVExON3pLcVVBSXJ2UDRE?=
 =?utf-8?B?QjAveTg5bnVkanFGay9ld3RhdlU5YWF3U2xpcm15enQ2dkFxTUU4R3F2Ujlx?=
 =?utf-8?B?Y2FkQnREY1pGUnNrNWgrWTBaVlZyMmVXL2dpcmEyYmI4YjlMODJRWFBsSisx?=
 =?utf-8?B?bDUxKys2Qy85MzZIcmVOZHc3NlNEUWd1cHBva0ZkRDFFQ00xUm9qZHRDQzNV?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 934f8dbb-c2f2-4b28-a1f4-08dd864efa51
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 12:19:52.3336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3hrkjAoX5Yxjh7vB3OV972H5ng3kHgBrStoJWxVq/VYZgPn8aXNrHzFa+KjBK4cSoYx46VtXQYBMRz4GKByfbfzev3QbNTLUhfcsyo7HFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3960
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Apr 2025 12:19:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18701



On 4/28/25 14:01, Jan Kiszka wrote:
> On 28.04.25 14:00, Jan Kiszka wrote:
>> On 28.04.25 13:41, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> This allows in case of a unified kernel(UKI) image based installer
>>> to differ between the installer UKI and the target UKI.
>>>
>>> It also allows the build of multiple images for the same target
>>> architecture or update file.
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>>   scripts/lib/wic/plugins/source/efibootguard-boot.py | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
>>> index 8b1097f..310d2cb 100644
>>> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
>>> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
>>> @@ -178,7 +178,7 @@ class EfibootguardBootPlugin(SourcePlugin):
>>>               .format(rootfs_path=rootfs_path,
>>>                       libpath=libarch,
>>>                       efiarch=efiarch)
>>> -        uefi_kernel_name = "linux.efi"
>>> +        uefi_kernel_name = get_bitbake_var('UNIFIED_KERNEL_IMAGE_NAME') or 'linux.efi'
>>
>> Is variable name anything we should sync with other plugins or OE?

I checked it and will rename it to `UKI_KERNEL_FILENAME` as used by 
poky. Also side note poky removed all the uki stuff from wic and uses 
now a uki.bbclass[1] see [2].
>>
> 
> And what about extending WICVARS?
I will add it.
> 
> Jan
> 
Quirin

[1]:  https://git.yoctoproject.org/poky/tree/meta/classes-recipe/uki.bbclass
[2]: 
https://git.yoctoproject.org/poky/commit/scripts/lib/wic/plugins/source/bootimg-efi.py?id=2f0ef8cd0e61c34e67ad9c7508094da3c23f5fce

