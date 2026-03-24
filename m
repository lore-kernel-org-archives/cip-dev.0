Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E2CF54AC9
	for <webhook@archiver.kernel.org>; Tue, 24 Mar 2026 14:43:18 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.35])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21182.1774363389095361973
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Mar 2026 07:43:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=OmoBOc/v;
 spf=pass (domain: siemens.com, ip: 52.101.69.35, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MYg/5ogvA9ryEtixKd0mkFeBVIJEqiicvi5gEppLMyxXksxLRIY6IaFZzoiqTQS04DDp3hpZKmeEAzEumcnD8pYK9tW6xYjS7/+FMWyZVvhopCWzTg6JqsEXgawK2VKuUe8yd/Asgb8gOweoVedkdFRWwepjdDpwYSI6R521yzwXNFzrHGoFbiZ01BMuWxOSxF7intJhN5ECb6PzvZWEx9W90pJ0rgOFu4WTyv/5q58n9ZsdBBaYYDDqCaMzmCNTTE84S6/Ha5CvahXCngkmVNGscnIxdsD49AC7wi4SekBR8oLQ/adRFMPtnYAm6F3afgaDVOXkrXjvKiSupdxrlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ye6ACTEVRPGsFBjXpg3O6X/RhP1aMMQ85E+v2Gou1TQ=;
 b=lWMO74gR9c7f2oN6bhaANUM9ZJgy/adk5OgzMb649c2qJssf2h3eZkFd0vrkqzrrqhiSEVi7f8quVI5YLwpsVmlgcGl0czg9YcoidPTva1w3fcMpD4C7q64CeNF8kYbxWCBRvWwUKUmBII5L5u3yLhy2zsqiY2mOfxb8NlCbJSBsEfBuNntk7zCwrbdA/TIm5U4E6dsGXzmF/QeP7pa9iQPlCVmwcMxbvTZ5ujNUv6DK9MgDkasMwd5JXO76R0hc8r7Y6SxgVZqJOIAPqPve5L24YWOTJWvdtxCpmhzn1H+AAHR3iocI5DyhzjwoiQGwfZXSUQXqc8jC4UuwBbeSNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ye6ACTEVRPGsFBjXpg3O6X/RhP1aMMQ85E+v2Gou1TQ=;
 b=OmoBOc/voRxClz91k25z8bn8vZ7Q+A1NCbuidSpU1RTWwoM08XFGdixTymsSGp5tXvCYXLG3zxTQ7+ggzMhK+trhLZ8RC5aaj/CaIffJczajGRsMh5MQzjLIH+H14vQwxpvN4xlzCvQDyeNG+6DB8F8sy9Z1zYWAs6PCu8kFVHZLET/SCt5vXJmJiED1Ea6z3W0nUDzpD5xAlthNFpaiMcKgzTjw4BKz246XLsODTe9TiwppJ1YNzwaCHrInN2gxAJNzOtRYQ40tRTCgAhGNjQjqHAnazBs52k62O/ZuIEyAgBqXTy51bLUtczk53lZ2L1dNdnIRfzLQf6D9aWCaYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7831.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 14:43:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 14:43:03 +0000
Message-ID: <993ad024-7fcc-4598-9bec-dd7c845a3d0d@siemens.com>
Date: Tue, 24 Mar 2026 15:43:01 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] tests: templates: Update SPDX license
 identifier
Content-Language: en-US
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0330.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:39a::24) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7831:EE_
X-MS-Office365-Filtering-Correlation-Id: b7ecfe82-e79b-48e0-314f-08de89b3a786
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|55112099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	nc7DHaEmeBKj1M9F49EuZd7XgAeb5UveKBg0ir1nrfZArbOE/a8HVH/61nPX/QpjlpSyTpw4xv1fxywdnUd38L3/lx6Kcb/0P1aqj6dWDCMBsddlxku4bBUWcRi0yiyQTNFRiymScOOY0Y2ly+WAUDWCoKTPGEm3bbmF8vMnPNSJqmmSd7xfIFLSnYsxb5Ib8p6xQwqJFjv9PBs1Z1LiG2mNpqZC34JqU1ejtfEDFnvzZ48Ix2RQ9V1ui30rGJ90dv/z97A9JC0b90vGRn6ROIi5RNqnPYzMCM2I6UTQtGh5dIOYFTwBwV0oB9if0T8qw1oH8UMdLSN7rtzamLWLDG3XRGaMVu5eUjpGI/0VfY+s+cDRYRwB0cPC/GTfEtjD/mtRh3fcVR7IqY/MyFKMD0z8tIFCsr1DB4YwZILgPV8TppofaLPZ6usiH8ByOFjNrij1vX5JsErHAwfdgxNNe9XyweCZmTUEUZuah35WiSbfJgio6/vNTfa/h6jfZfXMjPCqcTKbZSxjWNVPlUhHIgcdi0KCpu3SOONjCcXghEYs9yMhFfYRLxSKft4ku7LroKaMz3p25syzv7rg13QSca/ZMb+41/jA5P8Pooni3E7pUXYSWEJBvPSQx8UBqErn6ygowQ5XPlnMQhO3v9IGZ2UGAq7bvI6fUm3n3zkFo/vTc9dnTlPvRMcavINGIRzqMtdFh9nbljG1vnOYGzT8GwHd5/ZV0jfaYft/O4GTOC4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dVJKeFRNRVpqa3hiTVY1QkhSNXhXZWNnc1NOb29uUFh6RW93WmZJWlR1TjF2?=
 =?utf-8?B?V2tLYzUwUitJb0JyOWRQZUkwb0N0UWt4TzJOQlpCdWIxdzJaWkhPVnpuK1Zj?=
 =?utf-8?B?M1E0bE1XVmdHL0lYOU5mUVRjamZOU21NTUZkQzJ1N0ticXNMSktkOThCN0VJ?=
 =?utf-8?B?ZCtaTmxHRGNTNVNHckdmanE4UFcyRmtuNTRvZFpYbnpDcWYxMzh4cmdnUkFJ?=
 =?utf-8?B?R0orQ25WcGJlYy9WL1J4QlpIMjdrZjJsb3lGd0I3ZEhDTFVlWEtnTkFXWlFD?=
 =?utf-8?B?MXcrK0h1Wi9KT0paZFgrZ1B0Z00rc0lPeElIRzQyNlNKb3NXdEJHekVGWk5D?=
 =?utf-8?B?SkFHd1FwUUg2eU1XNFVjbzh3OTZld0x5NFdoZDdFUG9SSUtMckVQOWErWkVR?=
 =?utf-8?B?bnZCR0IyWVQ2WUwwTzE3MkJYeTR3dkxvcFd3L3lKYlVMQjBua0krT0d0d21V?=
 =?utf-8?B?UHR4YWJMOVUwcys5ZERNWmZSV0lMMXlHakRDZytxdkFFUWxLb09NMjJia2Rz?=
 =?utf-8?B?MTk2ZlM5Qk5iOHFhSlk5UURoTlduVWJqM1Z1SVA3R0tjdlM0SjBqbVd5cGpa?=
 =?utf-8?B?dGZXaW9NUjBrL0NtNzJyMDJNZytKemV0LzZ2RnVRcFBRRkVmeWdzcmlYQ1Rv?=
 =?utf-8?B?MjI4N2ZXbkE2WDVkRGxkci91WXJETTBwcDUvbVBFY3FkZWVJbmg2a1hCTmt0?=
 =?utf-8?B?WjB3VEQ3WEhkaWR3cCt1Zll5Y2lQN0xxSFRyeVA5NFlHcEE0czdUVFFZV0c5?=
 =?utf-8?B?MXhmOXhibUpmQW5Qb3lVbXluUWRkZHhkMXVmekpoSytTNUNPOGdsZEFhVURm?=
 =?utf-8?B?d1U3L0Q0SFN6UXA2N3VLTnNJSUpWT0owcTdPbGNoc3h2SFFOcVNoMDJGNDAz?=
 =?utf-8?B?Mnl2QURKMXcrcUdTMVlBQ2dlWHQ3ZFVleUNDdXpPNVVYQmpPUDVkV2RpS2Jr?=
 =?utf-8?B?SW12SzArek9Fd0k4TzkxaFVEMjRxWWVQQ2k1SElsVVdMWW1JMEtWZDNqeE1q?=
 =?utf-8?B?STNid0VLVjNLSkZETHBvQTZqUXN2ak9Ba28vZzJCU2wvbzlsNERFREtHR1Bz?=
 =?utf-8?B?RWl4NlVrVklzamRLM05yTmthdU4ydGVORGJCdHNLVkt4VVI3MXBVb1FyZy9F?=
 =?utf-8?B?ZDJZNHB6RERZcC9RbmptRTE3MjN5QlR6SnJPREZaRW5xc2JPT0pBSTFWYTVq?=
 =?utf-8?B?OWNWblEyMmpBRktyVFFDcVE0cm5oQlhvNzhVeWhCVm1YMW5LYUZJemF1TXR1?=
 =?utf-8?B?dmVtbFEwZFcvK2dSYlRiK2NxdXJxSjFBM1d1cXJRMXJQajJZa2pERHZzcHRq?=
 =?utf-8?B?L3gzM0ZOY0YrTVhSWmRWTEFFbkFyMnBYc0dQWDlvK3drWVdzYXQ0T3FOZGwv?=
 =?utf-8?B?YVZ1MTVjR0lhK2RXYUcwRFh5NnZydFBLZmVXNXlLYkQydllzM0N1LzY1WWlK?=
 =?utf-8?B?NDFLbFVaUm9oOHZDQjlmN0t3VEdSMko3WVQxZk91K1A5UFFLVThyR3VEWHZ4?=
 =?utf-8?B?SkJFUDZrYUNXaEVXWGlodzFQc0ZuYnBNUHd0RmZiOUE5TStxQVFKbC9heXZn?=
 =?utf-8?B?Q3hDVmVJSWFXbVBQVVNTVnZadXdFZktqY0hFbWJBcVVjMkIzYnlTcGNmQmpm?=
 =?utf-8?B?VEQ5R290alVQcHV2NHNVbE5DT0VWSFlOU2NVUC95RHF2ZGRRenArVVBDc1Jl?=
 =?utf-8?B?Z3lvK21OSTVEZ2kxbG01STlRWU5HcFlTZkw5VmhNWnJyZkNhTWc2ZElTemNa?=
 =?utf-8?B?Y0t0WmNzdVFFMFZIK0p6a1Y1bVZ2K1Joc2pjbEtMWlFEZHA2Y3VsbUdYakNH?=
 =?utf-8?B?eGkxV2x6b1lMUGUzb25LWVNRcW9BdzgrSDlkZWhWWWtFb3drSExET2RTaUVa?=
 =?utf-8?B?QzEwV1ZZOHpaOUJFcCtrdUdGRk9wSEFwSDdFd2FEV2ZaZVlPK2FnNGtSRmZO?=
 =?utf-8?B?M3JmWm9CblZLQjB6by9sRUZqdkt2RnMrTXo4TnlmVU9sZmQrSGRaUEFJamM0?=
 =?utf-8?B?ZVdhVHYxR2x1ZTNCbFpjRkhqWXdCT0paWTkzUUtUakRUVWpaVnBmTCtPc0th?=
 =?utf-8?B?dlRYbVNXQWlpNi8vWDFES09VazY1YkF2U0FKRXRwMDFhSW5MZkNSMEh2Y1dB?=
 =?utf-8?B?bFM3c1J6SFlRVzFNNTVrZFpWUjVSbmtGd1pCK0t1Z2FlQWlQQXlXNEJwWmtI?=
 =?utf-8?B?aSs0RW11M0x0aGtYYnJURWl3Sjdkb3YvSVdaWkV4K3FlZEZ6OWxBNFpmS0ov?=
 =?utf-8?B?bEFQczFDWTQzRGtQRndkanc3dUo2djQ1aXlKbTlGcEptR3ZxRHZZMWxQcy9S?=
 =?utf-8?B?RkRPdHgrSXQrS1FMK3k1cks4SjBsVWY1aTg5Y0R1Si82OVF1UnlTZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ecfe82-e79b-48e0-314f-08de89b3a786
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 14:43:03.8029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mtjK+mfB78NeU/5sQaRzyVQmV71yCb7OdI+qcxeG35+vMfaLqhba7poHbwXyMMWzQKglI7lJlEgevK0/C0z6Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7831
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Mar 2026 14:43:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22554

From: Jan Kiszka <jan.kiszka@siemens.com>

AGPL-3.0 is deprecated. Clarify that this is 3.0-only according to the
header text.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 tests/templates/M-COM-x86.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/templates/M-COM-x86.yml b/tests/templates/M-COM-x86.yml
index 466a5d0a..7cb6cc2d 100644
--- a/tests/templates/M-COM-x86.yml
+++ b/tests/templates/M-COM-x86.yml
@@ -1,5 +1,5 @@
 # Copyright (c) 2025, Siemens AG, Quirin Gylstorff <quirin.gylstorff@siemens.com>
-# SPDX-License-Identifier:      AGPL-3.0
+# SPDX-License-Identifier:      AGPL-3.0-only
 # This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, version 3.
 # This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 job_name: mtda-mcom-#test_function#
-- 
2.47.3

