Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723ABC83F26
	for <webhook@archiver.kernel.org>; Thu, 24 Jul 2025 06:16:11 +0000 (UTC)
Received: from AS8PR03CU001.outbound.protection.outlook.com (AS8PR03CU001.outbound.protection.outlook.com [52.101.71.51])
 by mx.groups.io with SMTP id smtpd.web11.5989.1753337761022213513
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Jul 2025 23:16:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=HbdlMrgc;
 spf=pass (domain: siemens.com, ip: 52.101.71.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gbiU77CdFBG+ytMMmuevvKvUrA6+Roa9N7FkuS7Um1JyODsIhm+aqz3lcx3V6ceokYB2u/3BKePm3l+/c7ko7SNbqmk+cIiBiPHPVdTHHuZ6EwGllvJWVaBfdpD0rIJvKYrUElvm81UHcSiTsRDSZfVHhv9fzoCehkxyhOiC9mB89Kv6rnX3khVWr+LkdDto1a6RrSvdW97MtvD79f2X4F1o3/GsCMldhIctcdXysDzAjjvVl332Y8cm3eGpWTQUnfMqrv8AaGzlGJUSR5OuUCHrV+BnM+4PL30eISObxnGAopqggEcT7MFQMm9uG2/ubd0AoGhFFgttrJF0wSby+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvXvr6/UgGMlJQ3WEEtKWnqbGMgvj5HKAj6trEpcG5c=;
 b=V1p4Lhhlckqz8vJJ5nCgwzncpCcIFLT6KO2fKz23pIg+l5OXdIEvgxFBIFCk9NGD9q6Vm+kY2+2hSfXSx7XE7fK26v8n6y3C3k/vkNNazuw+9tAMramvscneP+BdlAkv9j7yQVUNTTowpsI4kMuWDLNYTElAXIR3VH5d78TlNFRCiDw6RauzkkUL+XoTUsHr/mdL3IakMW0e/uzK18Lo/tMlZaYPgdcE4EfmhbAmMngACUT2d9TMo55izmGPFvXLnvd6IUvP8eysJmXrFxVPn+an2qO9hkF9kfkysRYCsBg0G+u5NsDSoPgvXV8tNEExnEGAsrKX9Qj/nUA0BVDuiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvXvr6/UgGMlJQ3WEEtKWnqbGMgvj5HKAj6trEpcG5c=;
 b=HbdlMrgcmcO7PT6hepamVprOlUqk8Y9BoNebP/1Mq4hDyXRMvNE+8b7ToZ7oEalHzderex2sjMOOUF26JHabj6Tupu4EdTyiKOgHEpG5fK0YZ07zUkYrgXMdd7frbGQQfGJUNzeWFfWRndIrnz/XxQ6LLLlYlFaHcKxfQmEfs9aHidFdHmK3oqMg/M1a4H9MGq531T0FjA7C7M9DDakQ6VMSZKU/w5k+VV+tRRvIyUwg2cKnDdc44QKYPuuEmF4zVKWDd9qWIB/At2YC/JBDcHB6nXRHoLDIVHL3OPLO06y+Uj2rYqqWZ+7jsfxSK+AkFR++NGKhcQXZ+nY8XiHFNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5647.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 06:15:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 06:15:56 +0000
Message-ID: <15afdbea-69e4-4054-8b24-f4dc3028b163@siemens.com>
Date: Thu, 24 Jul 2025 08:15:55 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update cip-kernel-config
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0123.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1a::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5647:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b7e1127-ecb1-48b8-8c05-08ddca798cfe
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eXJsUHBvMDRyWWJhNDhvbU80S29ySStQS2I3L0JBZDd1Z2JrQlRCSERtUk1u?=
 =?utf-8?B?Skt4N2pTOC9pQnJqS1ZKdXZWcU9kTW13TnZWWllTNEtMQ0tTQ2Qvbk9ObllS?=
 =?utf-8?B?OTJBQWlRRmU0S2RWWEh0aER1VG5hRUJEektmbEIySVlXMnJVakNmelFBZ210?=
 =?utf-8?B?TlZtdE05N2NCUER0aTA0V2hKSUN3bGxvOTh3eEI4emRDYlFRcFFnbmxIZlYy?=
 =?utf-8?B?aHl0QlNxVGtHK0VrbG1UU0FDNDRDNURWSTFxS2hSb3E1QitCY096TVNXMCtn?=
 =?utf-8?B?ZmdxajZRZk5wcnhzZFcvWlQ4MmFYTWRPYzVyaG1SeWpSZ2duUlIrSFlhWCsy?=
 =?utf-8?B?Qmk5MHRuMmZBMGhhR0FERjl6STV5RGhCcFBiVVB5UzBhVDgxcE1Mb1pKdDhi?=
 =?utf-8?B?bE0vN2V0TGxXRGhBcldGcEFqV0tFK3R1Tjg3UHI5M1RkN2tISWxHdnFBL0w1?=
 =?utf-8?B?OFlKUlZaa3RnZysrWGpVWTVYSkVQUzBHZnlmanBOSUJqdEl4U0lxb0dubXNp?=
 =?utf-8?B?ZityYlM2ZmphSEZvUGVPUndxcmUybEdVcCtHLzhVZFJJbGJPUFluK2htbURH?=
 =?utf-8?B?eTdtTWRVK2hReGhMUUlOZEFVeXkvbzVlNEx4T0ZwZ1ZIS0IxaHZVNkg0dnVi?=
 =?utf-8?B?NjNQYTdkL0NmeVhPYWhOWlFXN1R0a2lLQUhOZ0FDQ3dqTkVJMTY1Y0RKZW9O?=
 =?utf-8?B?Q2s4MHJHanduczNSeE85aEJMZ1BZTDF0YVB6ZFRZZVFSVTFib0ZoSVJEb09s?=
 =?utf-8?B?YjN3aFk3WU9EdVRnb2MrZ2FCV3cvZjE1VFJtUkVDWXNORnlxcHVRdzV0MW5J?=
 =?utf-8?B?S2o1bzh2K2Y3REhLRlk5M3V4ckNSdlhOMjJ5Yk9kcWdia2ZHWVJ2VnFFcHdr?=
 =?utf-8?B?M2lnUjJ0L2dtWCt3NXp4SW83OXBSa3JEM1NYd1hic1dyRGxnODZ6SmdXSnpv?=
 =?utf-8?B?bUNwUitTMnlqL1N0cXRkekc5NHRxUDFNMVFlL001eC92MFZ5MjV6VnlPMzVr?=
 =?utf-8?B?S3I1SzJsdUVaUTNLT3o1UHVMdmdDV0VRU3ZqVW9DMS9HZVc3cmdUdFpGR2dC?=
 =?utf-8?B?ZGtrS0Zmb1NCN05QcWlwTWFBSVR5YWkrc2VXTEJPMVFsbXJFTkF1RjA1MVhI?=
 =?utf-8?B?ODA5VDVqTVo3aFlHbURZNDh2NmtVNFJsQS9MTGN2Z1RHYnNVWUU3K3VzcW05?=
 =?utf-8?B?ZzRFbndPKzlCSzVOS0UyaFg0T1NSWFNuVmxydTVUUnJOZmgrNkQ0Ly9sSFVO?=
 =?utf-8?B?RkVpaWt4aGxTcEJvWXVheWZDVlVQYVErdy9ORzd3WHhRTDRZUENGYUFYV3Bo?=
 =?utf-8?B?OEpxZ0JSck9lelJJVzJxMTY1ZnRBWVlwVmpuSnozZWN4MzEwRWRHT2ZzRStP?=
 =?utf-8?B?dVI2Y012V3VJbVhvaHcwWUt4cHo4dUo0MjVLR0pBY2dvcGxQQlJ2VFNJNTB6?=
 =?utf-8?B?eVhzazlLN3JTNkxjNXFyOXczamdSZjNiSEQ5NngzWFljZVdWTFJCY1VETFRz?=
 =?utf-8?B?Y2tPNFFxZjkxS2NPVkdnTXZlblYwSyt0ZGJreHN5QVZ6ekwyM0pGbE1zUHVy?=
 =?utf-8?B?NmtNT0J6V20ra2pRZzlKZDRLUnN4TFFJZ1NheGlKZ3ZOL241Ym9FVE90NUVP?=
 =?utf-8?B?amRoRlAzaGozc1VLeDBsbFhjb05WaWpDUVc1QkIwbEJac3VIOUtZQjhlOFc3?=
 =?utf-8?B?bVR1akdZOE4xc2xKV09HUzlUQ0t2cExKWENwNkkvajhkd3BhelFtTThsbGdL?=
 =?utf-8?B?ejU3NEZLa1NHTG5qMnV0dkVJVkQvVDZJeWtsWVJkRWVrTFRRNW1senp4SXd3?=
 =?utf-8?B?bzNQeUwyandvS2Mreit2QnU2S3FWN0JmWEZRNzV1Tk82ZkhXYUJkVk1DTmlB?=
 =?utf-8?B?aUdBN2ZyOFB2VW9EU2F2QzR5UzV6VTJrb1FKeHV2QnluVGJJUk9SSmgxUzNp?=
 =?utf-8?Q?yXndpzcgeFc=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L0ZBbkkwRVExd2NBTjBLY0tqa2trQThnL1ZEcEZIdk5OVWs1QWY4TUpOVjI0?=
 =?utf-8?B?c0lOU1hoTERvQ0ZScWIvOFdXV2VsY2sxNzRaS2xJT3N6enFYdzJQbVpNSnFT?=
 =?utf-8?B?SW4vaHM3RG8zWGNzUCtaQWVhY3hOUDFFTW5VUTAvMmpxam5kdWhybDlJcjBp?=
 =?utf-8?B?L092TjlpaXUrWlFPRzhNUjhQdXR1TkM0QmdMMWhpLzhvZmxvWE04T0JidEZP?=
 =?utf-8?B?SFJzNUVzaUN6Y3VFNklwMFZyVHdDYVVGYnJTUDB6dUlYbmZlcnA3dnppczJY?=
 =?utf-8?B?V2VWWG1NUFBRVXpzZVJuVjkrOUk2ZEJGR3NEVjEzN0FGalFjaWMzMzcrUWo2?=
 =?utf-8?B?bThuWk1NU2p4Rms3Nkh5VHRkbWhsUzM2d0FxSm9xRzBCdnRpcDBzc1ArWWVO?=
 =?utf-8?B?NlU1aHNmTWE3YWVhTjB0K3B0QkVFcTRvQzlRVWhCeHdUbmNaUksrYWF3bmVW?=
 =?utf-8?B?RnVXcXRqZFNLeVZGSW1FcmVQTTdoaHU3Mys5TksxQlRoY1FtQ3gwaSthbjJ1?=
 =?utf-8?B?WTYxQVhZMG9kS1BTODNnY2FBQms3NGZSN0FUaDhidUZLNmZKbDN6UWlrVExs?=
 =?utf-8?B?L0FxMHFISjNPak5INkcyUEVsWFVRb0pTNWtENU11MWZzZmpqM0F1V04wS2FG?=
 =?utf-8?B?MlkrN3Q0aHNvVjNjSzAvLzFuN2xsditCUmx5Z2ttK083SUtGbVRaelN5cEcv?=
 =?utf-8?B?RU91ZWxMeFpNbElmVUJWaFNVTDQxazdZc1VnWnRYTjJlTGhQNjh5ODJkdGFj?=
 =?utf-8?B?dWJFUEd1TzhlRHhqNmw4M2J3bEhNbG1oT0N3SjhFbWlhOUFoSWJ4Z2lwOHcz?=
 =?utf-8?B?Y1F2WTZNeEl5czFJZXJieHZFT21vbDFoZjlobklzMkNBV2dPTVNadVlDRWo0?=
 =?utf-8?B?Q21zWUZEcndPYWJuMk5jRTI1L3A0N3ZpczNWQUNYbTFWYldINytpNnp6cHdR?=
 =?utf-8?B?Um1pUGpNdUlEcnlRK0RTREhDc0lNRUNXa2RoWXo0RjJMemgrQ1kyREEyYml4?=
 =?utf-8?B?ZktjS0RiN2JLd1dOODNMUlArQjd1N25WS1dSTi9TTlZod3lWYUxMYzM3bmxm?=
 =?utf-8?B?U1hoTEJES3VyenBzeE5wRDB0Y1J6dlpFMlJ1ZjF1U1pGZXNVbm1xWjh5eGFG?=
 =?utf-8?B?ZzVUMkFRSkpvUDlFd2Z4ODlkMFY4S1lNbmRwcFltVzc0eDdBNjdaT3NRTWlX?=
 =?utf-8?B?MjlKT01lMmZ3cWxkdElVcUNZOW9zMHJGUERjUnd0WFV5bEI2UTU0VFM5ZGZ2?=
 =?utf-8?B?QlJIOU9xdHFyeTU4KzkzR2trZEtqdTRsRDQ3NEUrc1FSWERacDZzWjZLZm1U?=
 =?utf-8?B?UER1YksyTldPTUVhVVZ4KzQwcHd4ZSs0bSt1TlZNckFUL1FlWUZ6cWY5WUcy?=
 =?utf-8?B?WkVkWjNIUlRoZE80cEgvL1BsSWxJOWtZWEdQWC9qaCtIdXBqcGxGMzRxYXF1?=
 =?utf-8?B?eGd4WVMvY1pzQkZLWWtuMWljd3Y2VGNRcEdjNFF0WkU4UGtVY2JNTTZzTzJV?=
 =?utf-8?B?M3lPU1NkU25mYnRaa2VYMEUyWjFDSkYwdW1kS1FQMlp6OHE0YVNteWgwa2Zv?=
 =?utf-8?B?M2RGdy80ZU90TUEzdzl0dnBQdFZmR1RZdlYxeFFxeUNBNkJ6VnpDZWJmRU8z?=
 =?utf-8?B?MGp4dU5lL2theHZSQzdvUDFUNWNnSjk4TlBUU0MvSkpkaHZ6SnVyQnJYUUxr?=
 =?utf-8?B?NmZXYzdpb1RCbkNnZCtrbm4zWncyZkdVeHVKWEJmNjNMa010ZkU3WXFjelFy?=
 =?utf-8?B?ZCtEaTZkR3NTMmJ5WXVPTGY5bGdBTk90N2Vpb2ZoWUxVU2RGMFFxYWw2TU12?=
 =?utf-8?B?WkhVdXVXaDQ4SXhWeloxNW9XMzc1UUg4bmVPK1hWQ2VHbXp6bVdrb3dPSDgy?=
 =?utf-8?B?bVoycHA3ZlpIa0UyRUIySXZZcHRHZlBTbnNydGNGenk0bjRyczdqZ1Rtc1pW?=
 =?utf-8?B?RVFKR1Z3YlZXODI4b3dSSVBIZ25QVmE4S2djWXJXVS9UeE4wWExLRFk1V1p5?=
 =?utf-8?B?NXFvaDdIMW9haG9mQ0IzVENaU29IaGFFaE9mZ1JYQU11L3VYS21tL1VDTmFO?=
 =?utf-8?B?ZDdPUHpocm9FK0xITHdTZG90dlhCVjN4NW13ZWxCbWZPZXF2R2pBY1dzSWpY?=
 =?utf-8?Q?uqzXFynq1seVwgBXIu2if8ca6?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7e1127-ecb1-48b8-8c05-08ddca798cfe
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 06:15:56.3514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qhNQnGE4A+npKEx2eoN5MifqSw5ugAZ5BDRuQoNnEE4r1jjJ41pMpfJJc8H9+Nu31FdCrAeyCu40W2BKHcpn2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5647
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Jul 2025 06:16:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19585

From: Jan Kiszka <jan.kiszka@siemens.com>

Brings erofs for 6.12.y-cip on x86.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

This is suppose to be the final commit before the delayed release - 
crossing fingers...

 recipes-kernel/linux/cip-kernel-config.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
index 842eb9cf..7ffeb195 100644
--- a/recipes-kernel/linux/cip-kernel-config.inc
+++ b/recipes-kernel/linux/cip-kernel-config.inc
@@ -14,7 +14,7 @@ SRC_URI:append = " ${@ \
     if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
     }"
 
-SRCREV_cip-kernel-config ?= "2349955d6d536980b78099d4d2bed5e86fb32cee"
+SRCREV_cip-kernel-config ?= "60f3454fe50a2faead9fe5f156ed1f89bd0cd99d"
 
 do_fetch[vardeps] += "SRCREV_cip-kernel-config"
 
-- 
2.43.0

