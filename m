Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED27CDB47E
	for <webhook@archiver.kernel.org>; Fri, 20 Oct 2023 05:50:46 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.57])
 by mx.groups.io with SMTP id smtpd.web11.48576.1697781038207897918
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Oct 2023 22:50:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=XwiUrEU3;
 spf=pass (domain: siemens.com, ip: 40.107.15.57, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dO7xE3d7V58+k+nMOI1rAjjTpbS8NkRjEymw3ZnWT68reyav+gj9oAuhaeUaN2Frk/IP78kwyEsDJ/ESgEJgSKyfqYfduc0D9d1OCIozZ5DpHlzjeaqo3kIlmd8NLYyhNd/pViCO9og3hXRsBWETwGOH780RYqcYl6iWanjt55+rkgK6rtLfERAzKoQLHEpO19R57gFf7fwDBp8n6m1YTEf55za/DgmIs3nBMQ0VLlvfADk/E2eiRMy0oOZ5tK8vG+rjUEqU4trn2X20+fvLnbXaF6IDtYzBZVgN6v28u2h3rvODnfAQeC63tb5aucEkttCjhzY8Df/Ap+v1NPJbxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7lGxvYrJ4g3s8bkMkeks1zY8gCmNsIKYONUZqPYnfQ=;
 b=U90KHJDZywkue5Y00jKPK66wtCRl0S8tSa59i8El4P715ulxTIbbeD+wE6QujTya366OICemD4FrkkEkON7tmCmzMbc7xx5+7BSENWQjB0Xj/N8/qd2/0NpfV7Zvb7UWevUxgS06jgFnFTsX9PBSU6iKDlVWK8gHukeWMwQv5JVD9MlXGm2/iRutkoQW1RZN5L66T0zGgKyTfMYndbL0U3BQBBPcA00IjF6cOQabWOJAX6ziHHbU1ueONFpqwgo5lYaFatBx+KJvdPlFMUrh/rh5NWKVYC4NhNvsoQHPHA9gIg0DEtcvv48yC00GVTsSldTplS6vgpTrH4eifaTUPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7lGxvYrJ4g3s8bkMkeks1zY8gCmNsIKYONUZqPYnfQ=;
 b=XwiUrEU3t9OS74WEJ6pOVf2hL9gydv3myvsYR9oKuh1yRrV9ZVs6uUlZZY3r04m+qpCANM3iD/Qg80PDHGZUxZFSRuQaq6oa2EHwibYlda3LlQ5QYg5vKeKfhQvZ9WlNAqQdhFyRhx1jh+2E4bnRBdVa9sk+JFaU7XOhT490PrezSZy6UVGI7xbHn1Mw/Elhx7Nm9ELw23f12YAQ9/mabSt7Y/2UuIlCAUgDE2XyGhSEY2DpT6z/jndLGwwcLzf8UDub0yNo7H6DshoqTAuu24miAILWmheyOwyn5oyyymORr6/3kCAXB4qRN/9/GKxgiFaOjH+aIXq+HZ8DLwT0tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB5935.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 05:50:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5%2]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 05:50:35 +0000
Message-ID: <e3a81454-3e92-4f33-ac80-155358fc64fb@siemens.com>
Date: Fri, 20 Oct 2023 07:50:33 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip80,
 4.19.295-cip103-rt33 and 6.1.58-cip7
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0187.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB5935:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bed8dfe-01c4-44a6-83b7-08dbd1307ac1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	pSdPW0bj6PNfqbAlzEgQk81nZVmIMZwXlSQBg7f9t5VWOLPiVK4H4g0AGf2DQzSFs56UNg3k/b0zpA681g7q07oiKFHEILHeoWcygC03+taGUckNdyQd3WIT59B8/NvjFcPe0HEt2TQmFMnv9Q6gKnxW22Mosjpb27IeTmMuilvKUQhWkYwQycB5Cj/ejfvKUEsDWLwXqpyZV9W6gxFVQ+u2gFYxaA0nwWEb7LRqxH90RmQAbpwaofSzgofp8DDzRDeqPOCm61/JWW+ugr6djWiQVCAta+OgcuntAKdREodP9l/HgWjea1Air8QWHGgmQ6fv3MRXhYe+le1n6QqZsSIJ65nvx2tyn/s0zph500jpchSAYA7m+pFhD+cof1UVS0WgX/cDwFkGsA6A9BB75xT9nYdYbiW3G6KNYOO66gcLD8y67wRp60HTA0hjaRMsZvD42bEtmgJGczGbWUKXR5wLhEWxkGy/6hEStDq2W37sUVeDc7aeO4OBBzwzVri7R7XmpmTTn1JLfsYcT834oMC5zaR/4uO2HVBnZaDsaH6gjJXOWBEbWmvWVP3c+Za5uFbm+NMamHejB/YllXCW1Cq2qQ0iuhATerOspZSJo//QpE5ZJrq3mNOyRTpfcQcRUq8FgEGf8vlLkfGIkBwReg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(39860400002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(8936002)(66556008)(66946007)(82960400001)(41300700001)(66476007)(6916009)(316002)(8676002)(36756003)(86362001)(31696002)(2906002)(6486002)(44832011)(83380400001)(38100700002)(2616005)(478600001)(5660300002)(6506007)(26005)(6512007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YWxsa3ZWT25NNzUyRGdhb0JLSTduOUZYck1KVXZBQjNoUVdoV2RoOThCZnZ3?=
 =?utf-8?B?TnA1WUZReEdzZ2RrTHlWbU1wL0dZdFpHWC9FZE9QdFFiaTBjcVMvaHJ1d2tV?=
 =?utf-8?B?YktpWE1BOHN3blpiYXhBamxKZklBTEE1VmYwVnFzd0phVFgzeUtZeld2OG1M?=
 =?utf-8?B?a003dzRNQkJyZFhIUGpoYktZaWJWSVM1Y3Q3NXBMMzhVeE1Jemx4T0RlUWZY?=
 =?utf-8?B?THpRWFBZZDhHSWZLQ0dKWTZqdkJ5SjBBc1pRRThHMUYwanQvZ3lqRDZKNjZY?=
 =?utf-8?B?bXpLeHFxTkVrTzgvRERKZGM5dGhqNWUybHhXMm5YUnM4eEs3a1dEZGRSVVRq?=
 =?utf-8?B?VXdvVmZLUkNPb215VnhMalhTaVAxWk8wUmh5Y1RCaGR0em1ZOWJzYTF6d2do?=
 =?utf-8?B?ZXBlTnF4dVhPNEdDUk1DL3h6K2VibHFXSGRHeE5vbmk2TXY1R1RORGlXQVZa?=
 =?utf-8?B?RU9Ld1pqU1E4VWxRc0pZMmh3REo3SVFTN0dsc096NTVUV2ZMTndLbmRyRnV2?=
 =?utf-8?B?eXFFcFUxRlg5RXVxM0NPMFhHa0JUU043WEZxWjNyZERGbkVuUThuOGJWNHJo?=
 =?utf-8?B?YldnSUFtMXA1S3cybXU2V3hLUzgzK2YvaGpISTEvNGxDZFVJeEtwd1NJUlU3?=
 =?utf-8?B?N0NJMlZnZ0d1QitNTXU5L0pPTC92cjV4YTg4YXp0MW1JNWtvNlBhTFlOTEVz?=
 =?utf-8?B?YjRlSkJ2QVo3UmU5WVgrZ0lTWGFHdS9aNjJ2c3k3VVdId0Q2dnhaY05LT1dP?=
 =?utf-8?B?WnlQcC9jQ2U1M05NVVZkb1liSTJIRmFhRCtwUnh0R1BLTzJHejNENjdocmYx?=
 =?utf-8?B?YW1LQVJuVmZOVS9YYU5OZ1BrZ3NQd0loT2Q1eU9pTHAyUU9JUVFicnl1S0lQ?=
 =?utf-8?B?dGZkelRjSTFGYjVzVm5nNk84Y2lkMUlCWm9VQ1RMKzlxelNuMTBiTHVrbisy?=
 =?utf-8?B?OVkwSnFBUnRqL2QxRmJsRnUxMTNnRzRFRXE2d2lYS2hiaThRM1REQXhwTVln?=
 =?utf-8?B?eXpzLzFvQ3hnU0tPQTdaOEtIcnA3WndsclpuaURGUzdXSk83VDFhQzF6VEYz?=
 =?utf-8?B?ZGRHa1VGMURjNGZGVGVFOWVFdzhZcnlwYnVSbDhOWnpxTXlWZUplQmhTeVFT?=
 =?utf-8?B?TE5SQUw4NHhjeWJ3SEN3Qm85NGFMRXcrNFlQemJnbmF1Tks5VmxXcDYvampi?=
 =?utf-8?B?cGMvanJLQkxpWFIzcWtlRURXRWRYNDIxbkczR0p1OGlBRkhZZnJaMnlMUEhr?=
 =?utf-8?B?dlFRRDMxQk9hQ0RCeUFwYTFZZVpXbnpzcGNHVE1pUnVnYXJ4aTJiaXdqamxr?=
 =?utf-8?B?YzdlM3JMYXhrbWV2L29RWUFkN1gxUTlvVWxVVFZkcHlnb3FzQTFIUThvb1FO?=
 =?utf-8?B?U2EyRk1DTHFDSXNkVGxXMVhsNUtJbCtROGRsMFRJNFAxL3EvUGxGeDhCQkJ2?=
 =?utf-8?B?ZU5VZjJzK243OEtQeUxHUmM1K1VBNzZPQ2RlaWNsSHdmVlJmWkordzVvdXo3?=
 =?utf-8?B?ai9ocmI0cENLQzVQSklKK2hjdE5PeUV1SGF0Nnl3dHBoaEtwTDROM3Q2dXdB?=
 =?utf-8?B?eGhGdW5nTjZuWUowMXpmL0haeFBONzdFSm9VTHVTOTlKNEFJUUlISEtwQ25I?=
 =?utf-8?B?d2o0WGRSV3dGbEpCSG10NjNqSkNEYnpLZmgxNzQ4dXQ4VU5DR2FhL3RZOVVJ?=
 =?utf-8?B?RE16Y1RjVi9FVGZiWW5uVXRmWG5QUGo0VVRyUS9jeEtGMzVnZ3BmYkpBNUtX?=
 =?utf-8?B?ZXBjYmhHd2lNUk9Qb2E5MXNuTG90aElqS2ZLMW5tck5WM2pCQ2JwNGd3NS9u?=
 =?utf-8?B?ZkszZjRwU09sakkxbTJuQVpSUWZaR2tBc1gyRmlydjFqbFNYM01LOXUrUnpj?=
 =?utf-8?B?TDRCNjNpbDc4RWNmcHBtcnBrTzdRMWlkOWdEckhsVWFWL3JpUVRiYTAzZkVC?=
 =?utf-8?B?NVpwYUltS1JUTkNkWTBUOXE3M3RTUy9DYXQ5Y3R2aENRQzRldVVnODZiRTdv?=
 =?utf-8?B?ZlBUQ294Z1RSMDE0dVdveVZVTGt0Tk9qbFN6MmQ5SkxmcmpnUHdRa09peWw3?=
 =?utf-8?B?NktYVHBtSFVwNDdobS9Sa0dVNE53emFES3NKNUpGZmZHQ1VwWXA1aUpTTGo1?=
 =?utf-8?B?YkViY0pOd1NTcTVyR1RDMUlCZXdRWDRpMUlvS3hweHN5emY4bG1keUN0Z0VX?=
 =?utf-8?B?ZUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bed8dfe-01c4-44a6-83b7-08dbd1307ac1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 05:50:35.1971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ieDxPccH2kMrM9gV9VT2b9rO7GundwoWv1uDrEJKB7Te2JdaZdTn6yn/SDJJAMvvMUZP9NpKwo7QE6jBy5xH4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5935
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Oct 2023 05:50:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13406

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ....288-cip101-rt32.bb => linux-cip-rt_4.19.295-cip103-rt33.bb} | 2 +-
 .../{linux-cip_4.4.302-cip79.bb => linux-cip_4.4.302-cip80.bb}  | 2 +-
 .../{linux-cip_6.1.54-cip6.bb => linux-cip_6.1.58-cip7.bb}      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.19.288-cip101-rt32.bb => linux-cip-rt_4.19.295-cip103-rt33.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip79.bb => linux-cip_4.4.302-cip80.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.54-cip6.bb => linux-cip_6.1.58-cip7.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.288-cip101-rt32.bb b/recipes-kernel/linux/linux-cip-rt_4.19.295-cip103-rt33.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.19.288-cip101-rt32.bb
rename to recipes-kernel/linux/linux-cip-rt_4.19.295-cip103-rt33.bb
index a8e75020..407bbcb6 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.19.288-cip101-rt32.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.19.295-cip103-rt33.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "faf282166d669a1d4a044963199804b9cf7272041bf723d62a5162303e443219"
+SRC_URI[sha256sum] = "96ee568d51fc662ead73d0851fb0fcec043317d11c3f00835fdb09c7740e3131"
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip79.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip80.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip79.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip80.bb
index 68483c79..7ceb68d4 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip79.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip80.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "cc84633377b3e46e48b25fba7061fdea319a44b541d466221707a014c0136e41"
+SRC_URI[sha256sum] = "f0276dee4e4154003cf73bd9c515e437d1d5f79d6517d54689ad997d7c10ccb9"
diff --git a/recipes-kernel/linux/linux-cip_6.1.54-cip6.bb b/recipes-kernel/linux/linux-cip_6.1.58-cip7.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.54-cip6.bb
rename to recipes-kernel/linux/linux-cip_6.1.58-cip7.bb
index 07dea15e..823ebab9 100644
--- a/recipes-kernel/linux/linux-cip_6.1.54-cip6.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.58-cip7.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "83b2172ee00e0b1621c83567955c232488213d36486d77a8f90766f053b6f5de"
+SRC_URI[sha256sum] = "a83dcfe35b65485f9f433e0259dc3863ee5948ee425f15268069a60472d3c53d"
-- 
2.35.3

