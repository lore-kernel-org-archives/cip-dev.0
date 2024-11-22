Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96285D75E28
	for <webhook@archiver.kernel.org>; Fri, 22 Nov 2024 11:10:35 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.65])
 by mx.groups.io with SMTP id smtpd.web10.21571.1732273829914264312
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 Nov 2024 03:10:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=NGeO55B4;
 spf=pass (domain: siemens.com, ip: 40.107.104.65, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wdodpH8/mMz2FF6IP74JGOACQlCKNmF+WMx3vlwv1ThzEzdcYdODG5rDndAW7vI5DRrHiyLWA4bZjYYq0d6VuqJf4NfEgE8c4bydgZiF0LvFVY9LA4Mq+0T96T1LcRfRbFafDPxj29gfQpciQrpd9c0AIVRgWC5wTyqKDMtyV8Dk1uU6fIHaeXkhkeqlepFX9eSlddhuOljrsczJVhPPAn83GydR0r4DGfzVr//nl8FTJLsaCeAv4C3Mlf4tGS+8MPfEG346ShEK3RwqC680X42D2v45iFsmKDJxtoM9Bbxmx4Jw+2LGqSfOQWwnXAH7pIMKTd0UX+R81lJW/9oTUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIDzqpwI6YZrNO0qb/H9XN1iKMA6WiLYFH5JwW8YR1s=;
 b=QCH2xyXWlqxr7P5UG/sVGsRDb0mnX3gBnFJnZBo06bpzAm6LPYDze7eeMIAzA/mLS9PKHRQJd+f2IKx33Cwr7NshGzMNmdy+0rJyfhghzvRfxdKLMp7eBdPZAJeqpMNBJmTW04k+ZpIjgUlDwQTIO7WTGqz0TyPqT3Ut79q53+rv5r9RNc8VX02ewasm+2nD8xd1dOJE3KwK+AFtoelxYIM6R/sqlnsob2LL5DzsI5pbyt+wXm6eqqdsyj2JuKqiNF68ss5/yAdh/lv4PgVcd/1ZDaVs4dM+HsdbRGl8K22/8xYwlEfzRXTRY9Ya6uyc1Rz2wnRnNnSaaHnKhswsug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIDzqpwI6YZrNO0qb/H9XN1iKMA6WiLYFH5JwW8YR1s=;
 b=NGeO55B45pdvbHD0xL7Y4CkL53yXsmpNz2RRAifZiW6KDqluJE/3I9+a5tYBcwvUZrus9hZNF0fUUpNO8WVZGkWQGz8OXB5zIc/GsfihSHq6pSIAFhuVOFmq+NLKmemzEDaEu9tSSLiZzncfrVAcVE9U34OtkpHcGNdqA2QubGnloqHxQhdAiEm4//HkSXXMGjmsvaUFM+vw+ZZisHrE/QBzmJrX+MrREIMHoWs7bjvJbjgbCK6L5aGRUkdAdbsDiT2Y3/JShIJy24xfDof7suAYpdpVqIAh7JJGlTbso3s8m0YU+mgm/3k1gUXA9VFbN60SleYH8I7cEfg1bT0GYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3168.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:133::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Fri, 22 Nov
 2024 11:10:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8182.016; Fri, 22 Nov 2024
 11:10:26 +0000
Message-ID: <f92ff6a7-4101-4ba9-8070-95caf507218a@siemens.com>
Date: Fri, 22 Nov 2024 12:10:25 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Switch buster-backports list to official
 snapshot.debian.org
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0029.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3168:EE_
X-MS-Office365-Filtering-Correlation-Id: 08edd8ba-2cef-4713-96cc-08dd0ae64463
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SE1WbUhIOFJwa0x2Z0xiS3NMWVZTR2FUaWs5ZkFTbXFaOXR0ZjZBZVdqWGVp?=
 =?utf-8?B?VlZSYXhaUGE3ck9sSUxHejJOTUl5Ym82RWNTemlDc0t1R2NEMm1nb1U2c1Aw?=
 =?utf-8?B?QStXYUh2UlNEbWxVemR0WlFtUDBmekl6UytXVkgrMW1PeUd6aVZaVC84SHV1?=
 =?utf-8?B?SU5iUE9jcVN6TXdCczNtODA5UHo3dG5HMGJ0QnVEbTVTZXkzRmo1QTdZRDZw?=
 =?utf-8?B?b09uRTBFUDR0VFp5WjUrOEtDdVNNNG1LcXplVHhRYnBEcEkrSEZBMXROWE5G?=
 =?utf-8?B?M045K0htd2NwYXZneGxqS3NHZ1FHVjl5L245NGdoRTdtS25mZHVhNnV6TUht?=
 =?utf-8?B?ekdOWjJWSzZ0S1BBRHphNHY0b1JBb0ZtZ09GdzZtQURZak05SVFyMnVZU21I?=
 =?utf-8?B?cUFlK1h1NGV2eEZCbDdEWVY2UzZsdXZ5QStGNEZ6ZGdIbjhycXVaMjByVCsx?=
 =?utf-8?B?RTFLWXpDZFdZYzJPSHRXTlJkdlA0a1lvZG9Lc3lVYlY5VVBQWkFLem04ZGZB?=
 =?utf-8?B?RTNqYlpRSktzZDNMMzMxcjJSTGJVNlhQekZJV0hURkw1YTM4UDkzT2RnVENT?=
 =?utf-8?B?L0tlZnZya2lQempaY0YzY25VbmJ4TWd3TWxINHE2V3dLUnFLb09maEtSMXZ4?=
 =?utf-8?B?Y201ZXdLdEZTSVZjYmdxbmJSR2U4OWFlb2U5cEdtUUZ6VDNXU1R6bnptcVJN?=
 =?utf-8?B?ZVdCclBndVNmQ2xrOGJabm52V1RBcktVZVF3RHJQbVVnaHVSSkpUYUZNcndY?=
 =?utf-8?B?c1J2aTY2RDZZM2dtT0FJMjBzbnlsTTZ3TnBwZEQvVFB2cGhsei84SjhZMGsy?=
 =?utf-8?B?eGZYMUQyT2VNcm03WXpqcC9BZnkyb2FVWkNyY0hCT1lIWkZSajJ3RTc2ejJh?=
 =?utf-8?B?SWQ0UWFHNWlhTUZVazQrUDBpN0Q3YVZxUGVnWUxEaWZGZlo2eUk5U08zMllI?=
 =?utf-8?B?NithYS9RTlViUlhHQXo2aTJvUFJpak9pQ1JXQVd1dFFDeGgweG1NdE1PS01u?=
 =?utf-8?B?NXI5SkRNbWpCcDVnNUZiWUZhakNNVG85US9zblZKd3AzMDFnRENFNG9KbjBS?=
 =?utf-8?B?TUxaOHdvdE04b0h4eVVqOG83SWg5RzJPRkhoZGNsQmthWWxndTRCd2FvdERU?=
 =?utf-8?B?ZXVKWVN0RDV3eEwxZTlnTWJTcWFGQTdRTEFBUkwvd21jaW12NjZBTjFpMElD?=
 =?utf-8?B?bWt5RWh4QlJyeWhXR28rTUdZU0JCMHd3aWhzYkdHNnliWWwzQ1JCdkdvRXRk?=
 =?utf-8?B?TWQ0YVFBS05LVVBJbEpORyt0L09EZ2RKMytyOTZQV3JjdUdTalo3WXFJemJu?=
 =?utf-8?B?TXQ5bXNSUSt2K3lKbFFVR1ZsMmpQQVB3c015TlNLWDExa1FhdFF2cVltQUpn?=
 =?utf-8?B?TFV5U3Jld3RHZlBPYUc0UjhBU1BIV2RZcXZLbjYvcXlEd2hPNFJXRlpFbGIy?=
 =?utf-8?B?Uk5zNDlKSkJWVS9TMU1LOVdRTzRoa0ZXTmhpQnE0ZE1CSHpCZGlReGh1dkFK?=
 =?utf-8?B?VExOS0NFYndLQ0VlNWNMbzA1VzNxTnpTa1NEbnp6dGxBZng3M3hvRHlDQUFQ?=
 =?utf-8?B?NHhUN05seFJUOU9tWW1KeXRXcE9wN0lES2Vsc0JlS3dUTmtNM09oYm1NekxE?=
 =?utf-8?B?akNqWGhIOGZQUnFNTXFURGM4bUtjWmNMeGRIbjlqalkydzdtL0VtaE5NMUdZ?=
 =?utf-8?Q?IZJokQSGaeVQtl5IwsMh?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aXlzYVRNa3haMTF0OVJhREVYTGJMS3VtTXhxaHF3bXFoWFpMTkZUd2czVms0?=
 =?utf-8?B?OWlxN2FOZ2xrNEF2MDBxU3dyUUNZN001a2tiTVljYXk3L1UvN3dyS0g4UVdm?=
 =?utf-8?B?ZU1uL0lwV0FiOGsrNDYzYjRuaHc3ZVFWdE0xOGMzMmR5M3VXaEcvbGUvbjFs?=
 =?utf-8?B?aGtsT3QyQ0FSdzNQNlV1TFV1aW5SWFNRSGsvakZaVWpyV081cEZsbmlqSFU4?=
 =?utf-8?B?QzRHWjVXNTd4VDQvWlp5RWY0ZFhqc1FvYTUzODlyaGYyQTBKM1pKVHNrZTVv?=
 =?utf-8?B?UXhJQURYS0Vud2kycDZIZzJ3QmNrVnAxQ0wyM3BILzBwS2tnczBjaTk5Mm16?=
 =?utf-8?B?RW5SalRicmVZNlFXRjVGYkFrV3dSU2VVeldPaHFibXFVUU8rVlI2a3c5Tm1V?=
 =?utf-8?B?alR5ZFdPakVvZjRURDhac2ZHUlN5eWZLc2o5cFFwZ1BsNjJvM3NuUndJN1lW?=
 =?utf-8?B?OFBuWDFHdWk3QVNhVTBYSmNMNFF1Z0ZyWHRhNHJpSTRjcjN3R2JrUmw3SFVr?=
 =?utf-8?B?L0Npczc4Z0dXUmNpQk1DaEt6OTFxRlZ6UExQN08rNlVyWVlzNE9aZG9DL2Vs?=
 =?utf-8?B?bTdua1pqZlhtMCt2V2EvNXJpUWl4cnFhaXdvcno4M2RQRkRMVndUZnJacUtM?=
 =?utf-8?B?a09EMFErSnpjb1kwaGdhSW9RaXNVVDEvdXBkUDV4dTRsYlV5TmRpd3d6QVg5?=
 =?utf-8?B?WHoxaWpXRmh0bXZlYXFrNjhvQk85K3lOMXNGZXZwNUZRcWZhZXlvTTJkOWxJ?=
 =?utf-8?B?eXZTU1NmQVJDZVVhVmZDK0k1azlGTC9uUHpZc2Q1T2hBa3hnU1JjeFFkRXJu?=
 =?utf-8?B?QWRaSGgzSVJJVitLOUcrSWZuYzlWQWcrOGtXSlducFJIdHMrSXh1OEp1U3pv?=
 =?utf-8?B?dmw1b2Jld29qRVl4Nm1ZUDZJS3I1S3JXSE44QnRFT2RpSHE1UlJKU0FqM1du?=
 =?utf-8?B?Zm8vQ0M0c3JEWUdldFFDd29vYW82SHMrNU4vbG4wbHV5SFRlN3JxSDFZbElM?=
 =?utf-8?B?WDBQZnFwblp2SXBuZVNET2xncGpHMFYwMGJCM2g0ajFORjdLcWw0cmxWeU9t?=
 =?utf-8?B?VzZIejE0dUsxa0I1WDFzUmxNMG1vMjlHRHRUQ0tubVpFNzBIdXRjYmhzakFW?=
 =?utf-8?B?VFlaRkh3blR1RHlocWlnYUQ3Sk5rMDRMZUtVWHdGeTdVSVhERzlZYnNxK1Nk?=
 =?utf-8?B?Rk43YVhEN0IxSExCd3cxTFF1WFNlRlM4Yjd5QS95aWdXa2xIWVVUbmtSaEc1?=
 =?utf-8?B?anlqQitYTGxObkhzM3hDRGhINzBSV09XZTRhcXhHMzR0VnA0Wkt6ckwzZ0lt?=
 =?utf-8?B?SnUzakhUZVluN0pldmlueEFNL2ptcVExMUg3bTZTc2ZQZUc5UEpCTm1iVU1J?=
 =?utf-8?B?SUYzRUlvbGVpRlZ6bnByTEY2TkxDbmRSU0dCelZNQjhsMHVhUUZsNjcwY0Ro?=
 =?utf-8?B?KzFvYU0zWDJIdjF0RVJTcUdTWmN1ZzFpSmRBVFdZZUxjMHp5UnBoQS9uQ2ow?=
 =?utf-8?B?Sy8wQk1IQzAvSWlXb1VLWm1Ia2pCTFNTT2dIZXM4WkpiZkpIcEpTTzJVN3Yw?=
 =?utf-8?B?MmhEVzNGQURPSEN3d28zc0xZemZaVnpjRXgxWFdtSzhtOTBFelZCdVZmSzJp?=
 =?utf-8?B?dGd2KzRCanMyN29FQzN1SnBtS2VPVDkvUFo0bjNFR1dKUHdENkg5QTVXNVFl?=
 =?utf-8?B?ZjhzdDd3L3dXSjVKRTZCdElyelVzYzRlelprQm5vazQyV3puNjViK29lcS9s?=
 =?utf-8?B?Rnd1d051bkg0bDk0cXFMaXgyR2h4aDNxejAyVWxUUFBpWmYyY0NubUJsdE9p?=
 =?utf-8?B?aVRkMTFmL2c2YzJzdUIxdldRVWV6dnE2ZSttQ214WlZNQVl5dnVxMDVOV3pv?=
 =?utf-8?B?MEl4OFVDZGxCN0RkMlp2dkE5NWtnZkZ0TTRlV0hUOUZaTFdpekxnV1RCbXRO?=
 =?utf-8?B?TVkzRDRjbGg5MTM5UVhsS2MvTHEwME05czBpNXo3L3VEcTFwSnJWaTRsVW9X?=
 =?utf-8?B?V1BCdXBTaThUUmxpU09MeVp1YnZvZHRZblJ6YW9DdnNkMHhZMmYyN3R5VXFv?=
 =?utf-8?B?cWNqckIyTnhkTzBFT3ZyWFR2cXJLZlBMUUVRY3EvWFpkTFdESk54MzRzRTdX?=
 =?utf-8?Q?XzOb2v90OslkIZPKtq/ckoEXt?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08edd8ba-2cef-4713-96cc-08dd0ae64463
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 11:10:26.3741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4HkPAc+spHJ1UxTaDtm4vO4PuC9iugMLGonZMRIlDDUOuP/FF1vdV7kW2BClDJ9m30J70pGczRT+UAO27sZVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3168
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Nov 2024 11:10:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17268

From: Jan Kiszka <jan.kiszka@siemens.com>

The cloudflare link is now obsolete.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/distro/debian-buster-backports.list | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/conf/distro/debian-buster-backports.list b/conf/distro/debian-buster-backports.list
index 0691140c..7dd98095 100644
--- a/conf/distro/debian-buster-backports.list
+++ b/conf/distro/debian-buster-backports.list
@@ -1 +1 @@
-deb [check-valid-until=no trusted=yes] https://snapshot-cloudflare.debian.org/archive/debian/20240411T000000Z buster-backports main contrib non-free
+deb [check-valid-until=no trusted=yes] https://snapshot.debian.org/archive/debian/20240411T000000Z buster-backports main contrib non-free
-- 
2.43.0

