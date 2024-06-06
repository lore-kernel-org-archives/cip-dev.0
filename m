Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286F4C25B75
	for <webhook@archiver.kernel.org>; Thu,  6 Jun 2024 05:50:49 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.41])
 by mx.groups.io with SMTP id smtpd.web11.7310.1717653043413990013
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Jun 2024 22:50:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=rb1Z0QaP;
 spf=pass (domain: siemens.com, ip: 40.107.247.41, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwN57Z7fyYX/uQPVtF7y5mfIL41LrBFni9H7ICfCXaA9qJ8us+QMY3+iKCHdhvKx0Q4iSxQ4HSP95aia9KCWYuvutBK6GtBMCCq9Cw8GpUhPwHRTeR4YmP2454hXpbYiXD+Fy/1bnASNHS3KB/oO57U5h4YlnPtdoM1Y4T21CV8pGnU07Mu0C+wOjK37KUAAkZpMrdMdxsVOyad0Gp0JnYSZveCAzljjvRfEECq3MiVOEojHzf34UxOnngJmQhVRn41zO9oX40u9mlLJKGdurO/oGN16p/FoMknNe/5MOqgQU+W22qXitUDo8FCgvrB9yJ2sjTLx5v7NvwITpEMoBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvx4niuHsRnSkyrZpk6BGIYmNGY/5V+BBa+ZTp3o9/w=;
 b=OS1p81LQTnNU3YMa8D6CDdhmg3sSrp4qJlyT6SOa/ron3LhNrj30zqlwfE/yeWyUObkCLdP8M/bEmoM3Ht0ba5si+iwrP/GhBAM236LTfstwweEiJtNgjimtnXblyaWvq55LkF32RW/7yMf5/YKVbukrSUCDfGkDeq5mq1dsOvUW6NYGtmIWxng4NMfx4NeZMsx7KewO+IODNfIpVm4ILneUomVkF1UdnhJjPyFDZg6c+olPdLR6Ip/CWhw0XKBbgnvQGWCYFap+riElxrrx0Jk56PSnC5FqFfHmZzrPZ0YsoOalf0OI3OQawbG1+fpKAdgd7Lup0Fkmd896/PnplQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvx4niuHsRnSkyrZpk6BGIYmNGY/5V+BBa+ZTp3o9/w=;
 b=rb1Z0QaPedXMS+Gc7bPnATvrT5zP39NEBE69wQQJ3AseT+ypd3m+kM272NTtjC/Hd+pfC0q4Y85nq6Xsul5M89jyb+uBL1dJSRW7nSb4HLzNrZzhhw1s8bXinhe1IkhoCTiRfdL962HllFz7mSaUqnKv3csCj2mZfx9NEXaV+/aeFCkTb3waO+Akdr5IFXurKw8rU9HV7TuBL+mpR4YA9SAZF1w6DoYPYBDngCLBLHhj4PDYkMNUKz+Dk7PMxXGGBmT1+aSVpoVn0SzajAIGGnZ5gKWiL2rjx7B0kTrDn6coa6wMN4jldbCTdkLYuHVw8wVuZja9LVlJuD/zT37yrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6206.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:58a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 05:50:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 05:50:39 +0000
Message-ID: <72d9b500-2b21-4124-b71a-331d2a30a2ca@siemens.com>
Date: Thu, 6 Jun 2024 07:50:37 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update 5.10.218-cip49 and
 6.1.92-cip22[-rt12]
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0213.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6206:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bda7bb2-43e9-462b-ce2e-08dc85ec989c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UXBZTTU3T1BKbU1FTGpoR2UxUkR3MGJ4bTRFb1hkQzMwMjRRVE1tWVNET0Yx?=
 =?utf-8?B?cGZldktlcStkWG5sNkdCUWJOMUVGV0RhNS9uVkxaNUo1UFk2cGV6b1dnTDRl?=
 =?utf-8?B?Y1A4NXZDa3BZaTVTSVVKRnV5SHNrTGgzMkxNV2FlVGRiaEhKTzEwL3plYnV4?=
 =?utf-8?B?d0s4TXdYanRFQ2NpY1ZVMFFtcmNNTmQ2SHNrRmNFdFkzejU5VkVrK2tPTStC?=
 =?utf-8?B?bVRvS3pYMUVVRGlCRzBXOUJVc0NTczdDMVAxcWFCR1gyY2JwYXZQTEQxOFhX?=
 =?utf-8?B?U2VUTGRoYWY0MVV2U0hvUkZqeXhFMEtTN01qRVpCMlJVVytvS0tPYjRWQ1Uw?=
 =?utf-8?B?Nnh0cEorMTBXcjlmOUNBdmFMMGNwTWtWVmMrY0pMS2Q3QkZPWnZsdzJOeFZW?=
 =?utf-8?B?endydzBEczFPVTQ5WndwWWVRcmx1N1JDUDNQTXlBNGlpSmNpSXhsN2ZobFpz?=
 =?utf-8?B?YURLa200TldLT0xiZEs4cDlCK1JpVzd6ZldBMjBIMXE1ZGlMeGN6bm0vWE5q?=
 =?utf-8?B?TkgvYmZGb0YrMy9HWjI3L1dXMU5OcFhZbDNVT08wNHdtR3hZSXNEZFJIdUpP?=
 =?utf-8?B?cVlSZkg4Z1YvQ3YrVlhuMUluM3hDTFRaeDlNbUcyNDEyL2VYRytkV1ZTWWsy?=
 =?utf-8?B?UklZSGVOa21hcWhVWnJNVFp4WWhsQjFYZVNPZVVIUFY1NUE3VjJ1NG9vZm9j?=
 =?utf-8?B?K2hhL0Y1eC96dkNqOCt2MUQ2bHhEY3VYSWMxSFg4Q0QvQlh1bFNRZ2lrcHdC?=
 =?utf-8?B?UGJVTmlNb0hEdkpHUWRtVEZYbWt0SjlDR1dnT2F1WVpENDRPUnlJZy91Rlhs?=
 =?utf-8?B?WXNkV2NUN1paYmFydE5MTytwTktsdXZHbU9Ya2VmbWRTQUlkVFNLTGNmZnUr?=
 =?utf-8?B?VGx4TFRMcXRhNTZsK0pCVlJJZm44bkdOcGRvTDB2NEt3S05oNm1VSzUvVkFa?=
 =?utf-8?B?aEdUKzRwZTI0Q01HSjNVNHArTE1tWGZEMGJzQmJIYkNTK05mOTNpY2FROEpS?=
 =?utf-8?B?NjVWK2IwQTAvdDdBZVVTUmpYY2d2MnZDMnJ5OFNKYURlQmFzZTc1NjdKay9N?=
 =?utf-8?B?dDBBSHhEUXpBdHA2YStOcksrU0NiMkFhWVdrYWt3aEJjNXJJS01yL3lMWFJM?=
 =?utf-8?B?RnBKK1BMdmZZOEttREc5Y1dIbUo5L3Q3THNlSzR3clJGcGZneWpVZHgzVzQy?=
 =?utf-8?B?bjR4S2trVUQ2aVU0aEtYZEVXeWtZUDducEt5RC9Ud2o2ZDVOdEFWcE0yVUdT?=
 =?utf-8?B?VUxkdjN0SDdHTitOQTE2VTFReFhTL1lkOE1ZMTgwRzA3TENiN0RUSFJYNVp5?=
 =?utf-8?B?RGFxMENYalhrL1dXRGU4RUNxVHdyZTlQRmRvMGVza1VwTmVZa2cwQU5XSkM2?=
 =?utf-8?B?UnNzUmF3VnlDNHV4SHdrUDNSTUVhazVZQmtwTGN4U0l5REZIeFFVbzN1YTBO?=
 =?utf-8?B?eXJ5VEtzdTdFbkpSUG1ja09PT3lDYWNZSmpJc05qTUNlTVJzVGxPczJzSlhB?=
 =?utf-8?B?eWRaOUdqN3hKM1V1MGVjWkNJUUtwazM3WEJKRkdmbnRRamx5OFgvenIrOUlF?=
 =?utf-8?B?VVBWZjU5Rnd2VkxxVG4yUGRubFdVWkpycHh6TmpWZ0s1T0FKL2Y5alZkYisx?=
 =?utf-8?B?K1RuRWJ3MkJoMzhCWWxiNmxNUE1CSjVhLzU4Rm93aG9xZDQ3SFh4Wm1xclJj?=
 =?utf-8?B?a0tWOVBLbUNuWXFSbVdPVWFJZEFnWFV4MDVJQUtKOHdkQXg0MGNVNXRPODha?=
 =?utf-8?Q?EihExgbOvdM4O8rhwJOUi+SKlLoRVs1YWxrbl0A?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZFFkL2lJaW54cTZYNjFrNTlkV3gxVmtuTmQ5QjVERlAzZVZOaWc3a0lnbDZt?=
 =?utf-8?B?a2NzVmxMRHRjZzBqV1ZhRmxQaEJMVHRtSUc2OXMrSGhHSHM5T1oxcXBtbzdG?=
 =?utf-8?B?QU0vOVYvbjFPdURXZVFZLzFxN2dRQkM0RGRqNXNvNENFaHV3VXF6UzA5Z05t?=
 =?utf-8?B?TE9LTzliUnlxQnBMRE1aOWdEZTVFUy9LZm9TSFRrRlU2QVZiaHJSOFhBTUxu?=
 =?utf-8?B?N3Bod1liM3FaTVpSVVJvaTlibTVWdWNyK0FqNXF3U3I3NjZFSDNKbkp4VEtO?=
 =?utf-8?B?UC9XSmxMenU3bkhIREMybmx1bEE4WW1NbXFkUW1XTkljc09pTDV0Y2g1TlR3?=
 =?utf-8?B?WFpMYmxMcFVlMEdiUXFWeVJYL3NOT2dUUGhyN05PSlJoTUNjVjZQaUI3OHBX?=
 =?utf-8?B?djFCYjkzNkdZNytjakRrRi9hME1GY0lyYmJnbDBNcGhpaTJoL3BhbjQvNHQ5?=
 =?utf-8?B?dmNqUFBmQzNjUVcwRVVreDBmWTVSaWYrazNROW5UTU05OUFsendla1E5TXRq?=
 =?utf-8?B?NzBZUU1HeWtqWEpBUnZhMDlOcituS3hNM05GZ3ppUXptck5reFlHZHVibjZH?=
 =?utf-8?B?RzJOdDlLOWx3UklVL1lNbHorTW5QZkI1MW5ibEdlMVVHZHhVQnpkQTBwQ2tx?=
 =?utf-8?B?NS9rb1puOENwcEx0TzZTeklJYlFTcXdQQUpodWVRd0Z0K3NGYlpFdm01T0tV?=
 =?utf-8?B?Z0dMQkpBd0haQlZVUHNEdzF0R3BraGV4YmpRTitDTStGOGFKZ3p1T0NORTMv?=
 =?utf-8?B?eVdIa1dwVzVLRkdpK2s2dVJFMFVrNnpsbGdKNm5wWWpwbTZORFRVb1VZaUdC?=
 =?utf-8?B?RU1EcHQ1QWlKMC9TNnpYZVFGK0lvUXdtc2l5azNneUVSbVlHYk1QZ1RLRVNq?=
 =?utf-8?B?bjVVU05OVHZ0Z2ZEMzVwL0pFdXFoWXpnMzFSZy9oMjU2cGFJVXlpTXpDcVli?=
 =?utf-8?B?MkxrN0FxZGNjdkFDcktRVEVFRXhTYzlRTk1FdTVqdXdFclJDd2VRZVpLL3Zp?=
 =?utf-8?B?ZmxiMUdHc0V1RlpNOG1ybkZUVzkrR1d0R29lNHBDbUtxWTgybUVBUEN0ZTdL?=
 =?utf-8?B?VEZUTkw1eFhCMTJHSUtieGJ6eitsSnFNRHI1RlBVZHpLSmUwMVB4cUlaU0F6?=
 =?utf-8?B?WDJaOTFQZm1KUG1oZHJPdHgzNVNVaFNpS2hocXIvRjVJazBCbmNMRitGeWdh?=
 =?utf-8?B?M3BuOHFBdUZGSkZKSVFXOUtpcXpjWGVHTGlhWG52NTBVcjlac3Nwcm1OMTBM?=
 =?utf-8?B?SVljNVlBWm4rSEFwV0tWUzFKZGhGQkxWRlBMUHh5QmwxVXhPbzh1S1diUThM?=
 =?utf-8?B?V1hvQ1JLdWRiNVVnTWF0aW5PWjlNRjRpQkJ4bzJDajBoOURpYnhWSlE5S3l6?=
 =?utf-8?B?dXplU1FuVDlDdDVCdFZJMHpLMWE5SDZFdk56bXMrckw5Qll3NHJCb01Yemlp?=
 =?utf-8?B?YmFxeGZRd2FCbFlNUjdGaUtIZ2JlZzNpL1l0SEIzRXp2Qm8vOGl2N2xtYTJO?=
 =?utf-8?B?VHBMWUVLdjdkWFJMSGlFYnBldm9ZQjdsQlRyZjNDM1pKbzN1NFJTcUNJMVRj?=
 =?utf-8?B?SXEybTlNbC9keVBLVSt2M0djbEY0Tzk5VW0yVndlQVRBT3lhcFBUblZTUW1n?=
 =?utf-8?B?K0RGVklRWFcxK3IxRGF3SHFDdDQ3cW1EdzNIb0paYlFzcEwvVmVrOU9nZ3c5?=
 =?utf-8?B?bnhuSVRZSUNoNVpaMnFhVTEwYlAySGpjSDQ5cHFwZUpZODBlcjlIZkFjZEhU?=
 =?utf-8?B?ZERiVWltYjRnQjNieFUyd0NjSzNEeldveWtyS2JLRU9sTzhTZE9WSVRkem1k?=
 =?utf-8?B?cXlFSzdDYVFTSkJtUndudUNBeDN2eE10K0l4aG5GaDZVY05KblNzdW5VMldo?=
 =?utf-8?B?c01EWUFwT3lQTC9yMXhxNjFXbUV0LzVIRkttN0x4OFB5Y1FaaW80QkZXUEtP?=
 =?utf-8?B?aDFHalkza1VVTzZQSTdBcE41M2wweEtVd0NwT0xjZ1dDcEl0SXplTUtFdEdi?=
 =?utf-8?B?UXJmZXZiRkJiaTIyeEtmM0dpTituOHdoRkMzbkJnUWhQWXRlMjZkM2JQMVc5?=
 =?utf-8?B?amdDdEVLQnVzaTdMOUhMVVFPTkNiSUd3d2dMZmowVDdBbnR3V3RXd0k1OC9p?=
 =?utf-8?B?Sk9uNXhKeE0yL283TUEzbW1XN0FMZDdVNnd6dVFzVGZTU2ZjWGxHVno2WWtH?=
 =?utf-8?B?UWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bda7bb2-43e9-462b-ce2e-08dc85ec989c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 05:50:39.9600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sAcDPTZ6fsBN7PhQEJJ5Z5XmHfZIMQLXnHZESNvIEQfo/5WQCuRD2yZojhs0/cyzL5GvMJaSmsaFDw/3impgmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6206
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jun 2024 05:50:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16122

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...t_6.1.90-cip20-rt11.bb => linux-cip-rt_6.1.92-cip22-rt12.bb} | 2 +-
 ...{linux-cip_5.10.216-cip47.bb => linux-cip_5.10.218-cip49.bb} | 2 +-
 .../{linux-cip_6.1.91-cip21.bb => linux-cip_6.1.92-cip22.bb}    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_6.1.90-cip20-rt11.bb => linux-cip-rt_6.1.92-cip22-rt12.bb} (59%)
 rename recipes-kernel/linux/{linux-cip_5.10.216-cip47.bb => linux-cip_5.10.218-cip49.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.91-cip21.bb => linux-cip_6.1.92-cip22.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.90-cip20-rt11.bb b/recipes-kernel/linux/linux-cip-rt_6.1.92-cip22-rt12.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip-rt_6.1.90-cip20-rt11.bb
rename to recipes-kernel/linux/linux-cip-rt_6.1.92-cip22-rt12.bb
index 3a8f5720..86f18e12 100644
--- a/recipes-kernel/linux/linux-cip-rt_6.1.90-cip20-rt11.bb
+++ b/recipes-kernel/linux/linux-cip-rt_6.1.92-cip22-rt12.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "f26ae423970fc99cb4c4bc5f69052b39a7255212ae4790450eee935446f229b1"
+SRC_URI[sha256sum] = "bf7750b483488f7e272043a64c0075121f355c44d23ba7a35190e25fa7a6000d"
diff --git a/recipes-kernel/linux/linux-cip_5.10.216-cip47.bb b/recipes-kernel/linux/linux-cip_5.10.218-cip49.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_5.10.216-cip47.bb
rename to recipes-kernel/linux/linux-cip_5.10.218-cip49.bb
index 9d769a87..b532d408 100644
--- a/recipes-kernel/linux/linux-cip_5.10.216-cip47.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.218-cip49.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "aaffc76f59d327387e04c5bcd04e99bcfa8d0c692cb6190a30463eec2e6401b2"
+SRC_URI[sha256sum] = "b9ea6a4f6f7f18d3d1abad24be311e3dcbf4b1ce3d08e600eb100a46b069b0c4"
diff --git a/recipes-kernel/linux/linux-cip_6.1.91-cip21.bb b/recipes-kernel/linux/linux-cip_6.1.92-cip22.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.91-cip21.bb
rename to recipes-kernel/linux/linux-cip_6.1.92-cip22.bb
index a0095dbe..556a259a 100644
--- a/recipes-kernel/linux/linux-cip_6.1.91-cip21.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.92-cip22.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "fb1ddf33bdadf8a03a72824e3ed9a6e0f74247b8ed00ff41611d08ed3b31ee2a"
+SRC_URI[sha256sum] = "b0fed0f35225f0d80d6ae7781ca37d5bc88910b84d44d17518bf0d7aa111baa7"
-- 
2.43.0

