Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F89C6FD19
	for <webhook@archiver.kernel.org>; Mon, 13 Mar 2023 13:48:35 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.62])
 by mx.groups.io with SMTP id smtpd.web11.20272.1678715309671612230
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Mar 2023 06:48:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pONaUWnN;
 spf=pass (domain: siemens.com, ip: 40.107.20.62, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHgfTA8Ffv3YsfAo5CY5wZ1J0K2p8VniqSJnjvaEDGb5Dl4gu0eHQ037np2azGPACMZw2c6BM4IKMzKhqxhnAUBoCwgzFLl3F8HgYlKWhdcJ491sHWVJXq2kuppJGGTjJJcJzEcCfF2UcTW4uBFhsurid2RAoObykpjhwzNXHNjsfZvKZcFhF66YebifQt+wrYCnesblZLUzbXhZ0uZiF/SAHG+uI7m3+AOJlAL8E/CY2r6Z6BDhpAI0LMWSSTadecq/ZMvMUAdQPLljFN7WCndQptqFtZvbOlHN5Yjwc7ox5+Bp8DRV2DdI/KCgX7ZAPUKveDrIzwaWHc6iuAE3FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40kcXxdxQ1ozvwi0YZkz75WOHjjr0NUmGCWG0GiXWeo=;
 b=bs319QWOqiipuydfWtAud/YirHkwiE0JWWY02amnUT4oviW35P1sKK4QDFkZP5LzaI0IaWiMbBgjoA/rrAor7Hcj2XsIY+XzeGuX6jvUFoCtyYfmBz7mkAxLyzEwLJlDGEJq7OStXnheSTBqAd/kx17c0ex6XxV3kHGnVjoD3fQ9mONuW+rpRgcyuXzEMEAfQ6viPx9Lui5CB3ilIzLCShOYRnImvnhkjbt5botUHQCcZ2ibVlVsxDOwlMAudETFxWUbnwFJL7QVKFDv8z6I5p3XacnRVKmKAZ0N5niRTe1nAC7Wgmv4hEszP911C3ZAiPNJcfQ05m5fvLQKP7vCew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40kcXxdxQ1ozvwi0YZkz75WOHjjr0NUmGCWG0GiXWeo=;
 b=pONaUWnNAHqF3xgMQdefDoSMi+DmaeHPb9r/sVilS8JD6PJwY6GUFqWQXvRq5YkSuOvGKlAVi6dfL/uj14uClYKhEssho2h9Hv6cSWvJu7SJjrCF4Czt1hqTTf3N5m1FesOyj5vDjBqNFNB7EwdeHVpKB+lZlijn5s0VtRuDYm/7l3pJrkbIx0zy5oNBE1LEUgSQYfa6WspD6/sXiOz2d8JeSSEn+l/ABc+9VvaOZQOI+suts1S6/LdYq5bH0zT+SPcKORFdhP+U2jUEIPiJWUIwSql79v8KrB9J1P9eYYkriXnvjLyXWn3wqct3qjB4zz+7v86NBhO86OQNDth1Bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3733.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 13:48:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 13:48:27 +0000
Message-ID: <888a5c9e-0e5e-2394-9203-8d9d7f163ece@siemens.com>
Date: Mon, 13 Mar 2023 14:48:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] Update Isar revision
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3733:EE_
X-MS-Office365-Filtering-Correlation-Id: 5862ae66-2f4f-43c7-2808-08db23c99f40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	GDfComnmKMf+WtLEvdvAoOWDH0jrT0Iv1eBoDbPGpdk6+Xo9n9iZllzZiOgR7JHkOoE5acuk3PlnGxzP3rszvFhxk9RkyMDw4sHmCvR0WFifWOHPvv8qJcPjKZ4LKerj+uCUikUg/z7vpjWmbc96MJ9KOTBpsdAgXeLypPJmguX9yIBnC9yuetaER/ZdicoCPD6N4UExLIU+/za+fcLoL8Fg0H9HLRQcObNVwQ/yntKQM5y1F/ukM1c+FJvUqERYzfl3ElGohiCkfL+7rgvNJXlAU3CWH+8Yk7H53rfn3pd80oF0NHs08rTviFqm9gGM7GAG6gYBwr5kVU5LvIVg9dTNv/FWGf1Ltcnt/07swIk5GC7v+0rdhtxc+b6YdU2ff4ypAAPvfTQK4fx2X5Y6mhF2hR4e/3+BdY7B1QSOE1U62HvrjV3Sgf9VXJk17kNNt0eAD7R9fgwvnrE99/JZ5o96JpuIn/BBIO41S5Ehe2JNF3bpPohtBTdAHkroJeeJMtXU+NOBcHpaHF/goLGJLxH2oqrUGB4xve2CkFzWTXKUZFtV2zDRRgwYx+27K4JsyGh5X6jhzK7l9O6nkLUlQED5449Ztuu/Ol1nkFWu8N5R4W2ML97abr6gfLgQLsH0Dp4JMPEZ4BAuQKcVg3C1OOX/psy/ZB+vVY3oEyTDhpEiNJfnpotqXz6rf+SzYyhqy1shGpn+f5QZzMbn/ufZnwRvXSV9QAceYfHmz2sX2YQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199018)(6486002)(83380400001)(478600001)(186003)(966005)(6666004)(31686004)(26005)(66946007)(66476007)(66556008)(316002)(6512007)(6506007)(2616005)(8676002)(6916009)(41300700001)(8936002)(4744005)(5660300002)(44832011)(38100700002)(82960400001)(2906002)(36756003)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QitpR2pYT1pteUZhMmwvU0d0NXczRElkSUU1eEo0c2ZwWGIvMis0OWJyWGk3?=
 =?utf-8?B?cVloNFFwUHc1OURBSG9hV29qdTN5NWkxay85ZW54RGwvWkhLRGtqUTEveHJX?=
 =?utf-8?B?R1VFMHVBcGhsWkhNNU5vcXVpZ21YRDJHKzFZWGNuSnBRdERYMlI5Z0l5ZjIv?=
 =?utf-8?B?dEpoTGxZOVlBcmVJNGpaZHkySnRMR2VGRDc4VFdpcEZ5K29HZzhLalhvZ3hN?=
 =?utf-8?B?UEF5Z1hSR0E2OE81MjNmR0dhMy80NjVSTW5YV3ROWk5BalpQYWFLY1VKRXFt?=
 =?utf-8?B?MmdIY0lWMGxtdjE5ZHpQdjRLcmVYR1l0RjNoNDkxZTZsUnVWaVN2TzNWL0NO?=
 =?utf-8?B?YUdEUGNiYlhwUFQwU3lKYjJpb1p4QUZDOW15NHlTWTk3SmI1SSs5dGZTZlBy?=
 =?utf-8?B?empYMDN3UmNZMGxKSVgxcUNheG5MSk0yWWEveVU1eXB1NWsyZWRwSGVubGVo?=
 =?utf-8?B?U0o4dUFYNVlWS29jVkcrYUh4cEl0OFlWY3JlU3JLRVJPSldPMDZOTVZwU3JH?=
 =?utf-8?B?OE1pZEExeFBHdGs3dFhpR0NmV25YbFRGNmJ0dldad1VpemRNcktKOHQyL3BY?=
 =?utf-8?B?ZEg0WkhsOWNFM04xWG01d2FjN1ZFT0ZGUE5CYzlJSUQwT1AxUkYydkJKQVpD?=
 =?utf-8?B?YkRXUGJWRTJNdTBxZ2Z4R1VTVjdnUVh6bUxGOElQSHlmZUNoLy9oSWkrK0FD?=
 =?utf-8?B?MEVLRmVhVUVlWHFZVFpMNVIvQ291UjN6dnpWSk5UMUdkSVFWWTFOSE5icTNG?=
 =?utf-8?B?SkUxZmNCdXlKNm9kTU9rWXJrZnlSNWM0dHArWWVKK0F1TGViVmFDL043alNX?=
 =?utf-8?B?d2prMldoOVEwR0ZISnRUMU9qOEdDdjFWUE1LZ3NQUWlWRkZEUitBTitFVUtm?=
 =?utf-8?B?dEhMWFJhRHl3YVc5eVhtK0h5UndBTTN5SStUZlpWaUpydjlQR3l2WTZwS0x5?=
 =?utf-8?B?Q21ZNkw5NzBsTndmUUpiL21TZFovVnU2a05GR0d3ZXorS0U1RnlkaHQwV29l?=
 =?utf-8?B?cDZNRzV2bVhrSXFWeTh4SlIwUDlnRzVqR1JmbTFmVXBPdS9XL2xoUnhBYW9H?=
 =?utf-8?B?MHpQWHU1YXNxQUJxVHZ4UG1zMkZkYlhadk9Tc3czQWJ4alZNV0VxU0F4ZUxZ?=
 =?utf-8?B?cnUwbXZrZG5BL2t1NzZ2U3RHNG5IQjVWczNISUYzd2JBUVFFTnp3M1pHcTV3?=
 =?utf-8?B?TXBBNHBaWWh6bHQxSXg1MGxiaVNJZDdUNlpMRklDdTkvaTcxaHErNzl1SkZ3?=
 =?utf-8?B?dENWZ3dNenIzNTd4QXNjYlg0UlFsK1h4OWZiYXF2QWh2MDNvL3dxTXdRYU1M?=
 =?utf-8?B?WGJTelJldzdYVnNzWVVsbjV3a3BWV2MvV25hL3c0aVZlVUFzZk93T3ROYzBQ?=
 =?utf-8?B?MGpBVE54bnhHQTM0VHBCWkZOTTRKT0VHaHNUTHpSWDgzK3E1QkxXaFZiRFFC?=
 =?utf-8?B?UnFDK25sbmUyb0tIa3pUR3AvM2x3RWIzeURGNEtETCtBNG5CZzJna0FlLzZr?=
 =?utf-8?B?SXY5WTlhdDhkMkhHMHBHb1BkalZncC9BTGNwQ3YraTFuV042REQwbDV4eUY1?=
 =?utf-8?B?TG5EbVlnOHYvREs0eFJxWk9zc1VkN0ZBUkxqdEFNTkhUVkoyUGlzKzV1RWdV?=
 =?utf-8?B?WVpLYjFVWkFsNWorNWY4QnI5RzczSkRDb1JuUThIaXZNZDBIN0tacXNJbndF?=
 =?utf-8?B?VTY1ZnRKdFdDRnVGL0VwWW9jNGZKbGpRM3ZlTXJqS2hZaVA3QllRNy9tOFFJ?=
 =?utf-8?B?NVJLSWh3Z283R2ZMSFoxY1VYRnpDY0dLa3dFZSszYmNMa3Q0cFJnNDlVOWI5?=
 =?utf-8?B?Z3d1VjErTEZoMGJkZ0ZkVWQ5NWhVSjB1Q1BuWGhuazk0WkRka0RhbVdYOWl1?=
 =?utf-8?B?cEs2MkhWckdXZXRua2NFL0lFa3E3QjQ5VThpZWtBdG1jRitZSHY3VzhHSjd0?=
 =?utf-8?B?cm5YU0ZRQ1Q0RktVSi9CYzVSOGczSFV1YTM5L3ZLaTRwc3Q2b2FJV2pqZDVr?=
 =?utf-8?B?ZmIwSUVBaEdNdGdkUWVGekw1Ui84REE5N1JEbEFOYVdDN1FzdXM5NmdXTDRI?=
 =?utf-8?B?N05hM0E2UGROOVJnS1YxNGd2SDJuelR6Q3lHOTV0Z0tuT1A2TWY4WTNJWldU?=
 =?utf-8?B?ZlhCNFZmRTNQa2NQVCtwektPbTNoT0ZpbWFSaGpLVGQzcEE5aXk1SDdScWlh?=
 =?utf-8?B?aWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5862ae66-2f4f-43c7-2808-08db23c99f40
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 13:48:27.1331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IJJekXtmbgr4ogNtgj32Tys+dazTMiHZbUvEH+IER26Qq28qvM9UG2rfDWZe6aE/iPcKaL5hfvbiKufeiq83JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3733
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Mar 2023 13:48:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11014

From: Jan Kiszka <jan.kiszka@siemens.com>

Brings a number of smaller fixes but no need to adjust recipes.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas-cip.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index e999fe21..73a4af9c 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019-2022
+# Copyright (c) Siemens AG, 2019-2023
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    refspec: 36ecd2fe9048829347225e90eb52ab0ca767b05a
+    refspec: f95f69d3b83cc28976ef81eeefb5ec5dd17e544f
     layers:
       meta:
 
-- 
2.35.3

