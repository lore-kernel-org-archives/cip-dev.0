Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C18C25B10
	for <webhook@archiver.kernel.org>; Fri, 10 May 2024 14:55:14 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.73])
 by mx.groups.io with SMTP id smtpd.web11.14754.1715352911833537063
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 May 2024 07:55:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=EmbFViQm;
 spf=pass (domain: siemens.com, ip: 40.107.14.73, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBi2fEYrILXa67eeZwZAcIE+CVCx4f2vouD3FH4ByD5CvQIAz7LElKP3T+gYzO9aJ/LhVQhl5Ivp9Km3g9Z2aPmxQhLRf6rqDTKYFjzkdzUehKquSIdiIjtaJsacM7OuXJ7kU1alDqdBrSSnZPyJHsbV7aI9lAumQUO4yt7BIszLDqhnAbC/Wtm5UfgDQmM/XZceNRBmnIlj74vdAWkmLbKcRU9qcDUEokQEMfsRvlZqH9187nkpYxXssF4LXgs/zA9TEuvE9E5ospmd4c5J6bdlk4MPGA5m+127Y5KkHr3F6Phl6rqVDWa8A4sEorILHJDIYevsER1Ygu+kpXV9VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qo5n7fLu9lZ7Gz7Eewh5MFG+Joe4/Jdf5usgk8yvnvw=;
 b=BpIsxLlDoyM/KzAk9JlAh9Ys8YY8QldZ4JtjHeFk8p76Ze8iJYPHq4rrhv595IjZYI7rodpRpsi+HMFTuqdj0RdFlX5mgOVpjIFod4jc3JFMAlvFhYKIYIC9kWNVewgCt7sigiFIyHlYEiPB9/Gcyz056pW8dKW0vFds3CMdKjdnHaTkRfXgaxj2OeXCocnU9fvFTfibq5PvOGTBxYAZuQSyVl4npRs1eZQ15o2fpcFt+yKHwK+q42d7V38ItmAfMGbiJcVBwYzgMmdAo2wymXTVaJ0ixLknCDx9Drdgn5b1lmLKecwbOIIDjvk8xx9utkPPtKwoBHvudWYWMH/gTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qo5n7fLu9lZ7Gz7Eewh5MFG+Joe4/Jdf5usgk8yvnvw=;
 b=EmbFViQmvgrfH85HvcvOg/HyGsiJXUrN0UXYChg7xBmP7Xai5qky1LYjrMSArnolrfY9euP1AfYM9IxUsfsiKXlvCy47JMbbf0DLo7IWhwD7h1goPhOZcDfJgSjwK5uX+wM70hWd7iwFQDRYr9EP4V0ZbL6IM7cDbn1AP0402v22qI60YOy47BJSmzU5wb+/OPiMVWtWkKlMPhZMl+27yaz2WhgB7BCdvpVAgqPTREG76st2mobEMzCTm56pc+eDfEQPTO1rcJ+6eNNMCeSfaEJ3cbg8CB1ldXgKO5B9ifxA+5wPcI2jNn1P934ycBcbzdeHNSySUdAFHZoYC9lKQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3336.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:106::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 14:55:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 14:55:08 +0000
Message-ID: <9521fcd9-6e54-4f68-bb3f-a7cd4e3f005e@siemens.com>
Date: Fri, 10 May 2024 16:55:06 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] ci: Require qemu-riscv64 sid target to succeed
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0230.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3336:EE_
X-MS-Office365-Filtering-Correlation-Id: 2549c269-553c-4e98-281e-08dc71012f38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZnkvVmJMTW4rVjFLN3JmVFJhM3JEWVVpV0dhc0tQcmJkUTJ3Z2prNkwrRkp6?=
 =?utf-8?B?Vy9VZ1ZyemhId1FwamhCTGtJMDNSRWJqaG1UekErUXQ1ZXkvWVlvOEhRTDdr?=
 =?utf-8?B?cFcyZEVYRHdYRlh6by9qTzg3MWQ0Q3hyNUN2eG9IM01ONk5ZRVhEbW4yYWNx?=
 =?utf-8?B?dlpDREIvVm1EMFNkbEVTYXp3KytySFE0T3ZXZFlRa0w1NGgxc3JSay9tR08v?=
 =?utf-8?B?K3EzSFRORTdUZWJPdzNXVjdqSWRXK1VuMWhjeEJ3dFZMUlVEWWtFLzdYL3NJ?=
 =?utf-8?B?MUhuUnkzTUNzdWM5MCsvMzhHRmpuSmNTVS9vZzkyVW1JMDNuRWhUVGdSZWZO?=
 =?utf-8?B?UERmejh6S1U1V2JGN2RWc1RFVW9rR29lV25oRzQ1SU56TXlKUzRkWmZpTHZY?=
 =?utf-8?B?QW0zeHErSEVyOEFBejZTQ1pRMEJrU0VzSngrUGdmMkdxT2Y0MGNWMmcrRkZP?=
 =?utf-8?B?NnlXUE9lVmVRNTh3R3Z3c2tNVFoxSGRkZTI4QlVBM2l5dzQyMTBqRGZJQ05H?=
 =?utf-8?B?UnBhUWNNZjhBeE4zOWV3ZmFVekpnOWMxQy9KWnRwR1lTVzlXNm14alZCRWpa?=
 =?utf-8?B?cm4xSksxT0lmNXovYm1ZTXRxTm5mcVBzNmQvNTNNbGRiVWNpMkRweW9UWTQy?=
 =?utf-8?B?Um5TMGkzY3p6RHcrN2RQZlpvQTRvUnRiZjhhVzNxeTZzTiszNHNBSlR5dkhC?=
 =?utf-8?B?Yk5NdHQ0ZndvaXR4a3lQWUJxbGM3djNTdnAycDE5bjMvejdkQVpYMVR2REpV?=
 =?utf-8?B?SUVTZWxOd2dFY1lFK0JxbkhZMUpteUJVTThrYXdyUHFDNVpnUFNiR2k5d2R1?=
 =?utf-8?B?RGxDVUdMTUNQZ0c4TVVIZ0pMUlVjcTg1cWxENkEvVW0vV3Y1TDQ0MFRublBk?=
 =?utf-8?B?d0RodG5ycUxJNXk2d2Q2dDNGMHpQcFJVeDBCZlM0eGpMZHgvMWp5RmVMcVEv?=
 =?utf-8?B?TFl5NDJ0UmZxZTY2a1A3WThydjRWbzgwMGtkY3JvcW5FYmhtWDlJSzNlUXBJ?=
 =?utf-8?B?UUlBbnlXVlJHWWRFK21wK2RVT1VSUnZMbnlVLzZHcUQ2U1lkV3dabldpRjd0?=
 =?utf-8?B?ZVdtZUVHeW82eUhhNm5kQnNKb2J0YUNEV0RBWld0Sm5YY0lTY09ncG9sYjBN?=
 =?utf-8?B?TTM1b1F5S3UxSCswWWhURWNvMGhZSy9iZEJyRzVuWkJKWVZGUnEwdXRkV0s0?=
 =?utf-8?B?Z3pWYm1kN204QVhiNFpTdmpmcG1JMUJ5dGUzT2ZiZ2VlSWxkMmQ0QWpMcmor?=
 =?utf-8?B?UzJyUzVyWjdXNHBzUkhjdkp5UXF1OTJyejUwWnRsZXM4TSsycDM4NWxXZUx4?=
 =?utf-8?B?OTdGclBGS1V5NjZTNTVQSklKZXJhK0hDeWlpUU5XY3Q5RUVBazNtRlErNnJX?=
 =?utf-8?B?UzFLZXoxTjlieTNSNE5XZVVjZ2lPbUJXbEdiUFFyTWtheVM4QUZYbGorR29X?=
 =?utf-8?B?aTdoOTBCVGRPOUxWV3VEcElxVzE3UU1nY0RlMFpiT1BDNnozM3pZQWMzRVdu?=
 =?utf-8?B?bExPZnhZUEpYSDAwMVhDS3BKMmdIQys3OTN5TlgwZVZiOGNZdXFVUkpMdnVy?=
 =?utf-8?B?am5wZURNekNORGRiZUFJNmVxcmFmYVhpbi9vWVJ0eHZDS1p4QjN5WTMyc2Zw?=
 =?utf-8?B?N2t1dmtrV3J3d25pekV1QUZXMFNucGtmYmNrVmJ0dlBhM0N4TXNZRENWWUgr?=
 =?utf-8?B?MUpuTXpib21SbW5sSEtVTmQvY3IxamxrRXRjcXBhbnNnbHk5UjRpcU53PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QnlYRU9xYTZWQXRFN29TQTN2RWFMbDJsTW9hVzBySlpCUzB5eTA1ajNZc3JW?=
 =?utf-8?B?WGxrT3R3Z1dyanpNcWRucExteDhMM2Y0dnhhK1FVRmxNdDdnZEtGNXo3Tk5z?=
 =?utf-8?B?OHl3NGdrYVUxTmxRa0VBb0JKeVpndjdzOGxFSzI0Ky9VbmVVY01TQks2dWdU?=
 =?utf-8?B?ZmQzdW0xVW96MnN5VS9FRUptWkZFenI5eG9rNWpDUnhjV0FoVDk2cTFpL0po?=
 =?utf-8?B?NkdEdXY2aHc2KzNmeHFOUmdHd3ZsNXNyaHdDTHZkN3NVNFFsckI4NFNoVitJ?=
 =?utf-8?B?N210MmxLSmtyQmFscDNhMWdvN2Njc212RGozd3NzOXlsWXRoMmZibEpHM1Y0?=
 =?utf-8?B?YzdvRUROR1pmcWJBbnAvYnVXMnliVFBGVW43TmlUa2R6U2N6azFRUDBtcnQx?=
 =?utf-8?B?ZFZzOW5hZFl6b3hrNzdNL0k0MWpBdytnRkFnZXBzWHNST3k0c3l2NWFFZFFK?=
 =?utf-8?B?U1kzc2U2N016SjRFTHpKaHFRbjhDaDhqUDBJZnN3ZFAwZHVEdk5EMEZjYmxq?=
 =?utf-8?B?MGRiem5ibndPMEZUOFFMNXhHQm9sVC9wY25vcmFpRnA0ZEVIVnRMOUNMeTZk?=
 =?utf-8?B?TGZtdmgycXp3WUFwUXhRMEQxalZhb3hjZmE5ZHcyc3A3TGVOZU5NM08yOWFo?=
 =?utf-8?B?ekE2UDVsdSt3bFUzenZFUFByZkV0L2FVbDdtKy8rVmJ1OWd5N0RIVlRXS2hk?=
 =?utf-8?B?RkhmMEROaGdkbkJ2ZW5XdWJxQktRcnhJOFlTWldIMnQ1bE8ya1A3enltWURp?=
 =?utf-8?B?VkpFRHZRQ0VFMzhmTnJWVGt1R3VOMXgrTkR0NUlQRVlQWU5nMEs3S0VMdWlM?=
 =?utf-8?B?bDU2NVFWWWNvWDR4TDcvN2pnb2prb2w1Q1NlZEJwRHM2bUJMTUlLNEN1QVZD?=
 =?utf-8?B?aTdoQUx6OWRhUERMeGZvMDRJcGRZTXNtblM3ZjJRRkxHZnRkejBTYWRjK0hZ?=
 =?utf-8?B?d1ovRWpYdElvNzBLSnNXaVdUT2FLVFg3MEdtTXdsYWY5Vk56UFpheGJnVm5v?=
 =?utf-8?B?TVFKdVNlQmZpUmp2SjZ2anRMdGRQWXVzUU81c01JSUo5OTI1K2t3eVBCUnNm?=
 =?utf-8?B?MzU2ejlFelNyRlBXc0VzUlNhQWFQQlBNb3VWbGk4Z2pIZS9TS0t1YTFFdHlG?=
 =?utf-8?B?dHVCcmFLMkdETERLNkdGYmdYSWUvbnlEL3FSeTB6a0NZdHlSNjRJNmdQUW1p?=
 =?utf-8?B?d1NKVXg4eGtvN0VHYnE2Z1RkWEQ5WGxkTlQ0YUlIeGh0ZTAvRjJUMi93QkFi?=
 =?utf-8?B?NWJTaDdJdnJLTXVuSUFrS0dPTlZtWm5DTWdZaGkrYUdSc0hTK210TW5pR21T?=
 =?utf-8?B?dHk3dDc5UmhxVFYvK25TYldlSUIyQ3pRS2NNRFY4T3ZuYWE2NkRaa21GdFNh?=
 =?utf-8?B?MWhjTEc4bnlIY0JMNStXcFhPd1MxL0pvYktKNXVsM0pwU3RLaGluYXZnd0Jw?=
 =?utf-8?B?UWlxVGJYSHA2SWc2ektUa2t4VWMzVkpVS2h0elIrYlIvRGE4QVlZVndrZU5o?=
 =?utf-8?B?cW5hUTJxRnJHcURnM0RXeWVjNEhBSVZ6a1dKUTVDa2JaNmNKbm5ObGJKcThV?=
 =?utf-8?B?YTd5b0x0VnBEWlRuTWF5RjVKTWpVTFltNTUvNHFPWkFueEp6MlJvTHFHL3NE?=
 =?utf-8?B?UVNqajQ5N05sckhuc3ZWNUNITlZFY1hDbXVOWXQwS3Q2VmNIWjc5MEVJMUw0?=
 =?utf-8?B?OG1nT2t5aVV1b3VZaFNGRFpjWG9adEEwZmFZcTIxRS9hUTg5eFBGRitZUUly?=
 =?utf-8?B?RW53TjM0anVBWFdMZVE2anI1RHlsdTNYbTE1Z0xIVjNISm81TDhFdm5mNkNY?=
 =?utf-8?B?YkdJVDRuUEpuNlpCUzBEbVMxV0dGREUxMnlRaTBJVTErKzZWdUx5YzdXaEk3?=
 =?utf-8?B?ZDFseVpkN0lKTllEZ21HV1hLSjJWNm5EdXlKbDlxVWNFWElwQmYwUTZjT01k?=
 =?utf-8?B?S2d3TUxBUmdUbjRZb3NmWVIrRUxjTUF6bXV6T3BlNnJHeXJtOVBHdXRPZHMy?=
 =?utf-8?B?T0Zwc3paYWd5ZkhPb1BYWXRIeHk1cENpZy9SM0xSMFFEd3ora3BpenpQN216?=
 =?utf-8?B?dnpkbXdHYTRabTcvYm41SEcvbmR6dUJrWWkwTndRUzNLSXpPbDFMelBaSCt4?=
 =?utf-8?B?Rm1LV3FLMHdZUk5jZTZLbVV0bmYrRzV2U2lqTHFtYUtIOEtEVjZrSnFjdk5M?=
 =?utf-8?B?d1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2549c269-553c-4e98-281e-08dc71012f38
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 14:55:08.1822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LxM/gQMWgOmeF1MQTKEUYrOS0fvfYQE4qlSv/H/WNKlRP3AuA8F82xMuRjmFFhIiS1OxLCGJEgLqhjYcuF3m3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3336
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 May 2024 14:55:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15883

From: Jan Kiszka <jan.kiszka@siemens.com>

We are building against a snapshot that is generally working. Basically
all disturbances are now coming from our own code changes. To avoid
missing a riscv64 regression, require this job to succeed as well.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index aab55be5..72084f33 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -356,7 +356,6 @@ build:qemu-riscv64:
     use_rt: disable
     wic_targz: disable
     deploy: disable
-  allow_failure: true
 
 cve-checks:
   stage: cve-check
-- 
2.35.3

