Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA0BC7EE23
	for <webhook@archiver.kernel.org>; Fri, 24 Feb 2023 17:13:51 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.48])
 by mx.groups.io with SMTP id smtpd.web11.23848.1677258820911997535
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Feb 2023 09:13:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=YOEm0oVo;
 spf=pass (domain: siemens.com, ip: 40.107.14.48, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CoroezEeAIeBKXFHuaQJSOTyudxke+sKzJeEzUZQ9/JafXoWtjXv8nvbOQW+7V+VWhkjjB6HMsNlX3DHC/S2KWdIWMD17K9/GkF7Igokp5L6DHJKWb5C9E6S5RGNw9b2I6MUFNJ++iiY00+ir/OnV3vE3rVa6KWRsj/Ecgsw65H5j356yUDa6CyX1p1UudU75XX3B/OOjY5U0T9vAqzOznfOmv75sN9Q0XMqqvlybBr2lQwt7dBcQIUFIne5DA/eAw+m1h1q/f2UD31sgtQrXTrwbQbDOTI0btJNPYr6d3AD2oWLcmxL3I6h/bEQLKO1tQrdyn7X9Lyjqfjjq7UljA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJvUBhwc2uLPKRnLWvHTBcor10vvoyzmWyE0QU10T0E=;
 b=Q15PAL4b/mozdt1Iycg/ABUR2tfyHxCqXALRdCLTILr03SihgWMQONxDgdMQMQ82yLrsk8GANtN9dZwSlRRpwdYacP8TfhrfaNY+j/hhKNdx2ixEqONLS3s0UynBgoPIG2ozXvGPRM1PDRHFsN/sAUij3wSe/HaRitQqszsGaYLE2r3uvxp9a7iidrjPYfddqCv/27ZnyhhWRhh//7afu2HrVQz6wh6v07FzoMF4YEXkrob4LNgQi5DNZoHParmkbf/Y+1+KSjXBuwgI52OJpS86kNRTbdWjkBPG/HY1hqBY+DuqeGQb/vKYNLhqeJuPSIN00lPfAykbV5imr4DyWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJvUBhwc2uLPKRnLWvHTBcor10vvoyzmWyE0QU10T0E=;
 b=YOEm0oVoN1kSj7UcfgHsMcVaqceYjnL0xcaQyDXMGbcaGYv+/ipM7CIBUSbCasSJ6B/hUEtyBEadVDdV7eh00K9+zhyR10faAnk06hGdBREyi69s2gpB59H1LektMj+x/GWPfUTZZ3WSJA104fPL7cJLEJ64JKarpkX8naMqjfddAYJGHPC9uq1xwThyi5RWtYdOPHzgdzxWnExw0klK9xmecBThAISArZ6q9XeuAlbmkG6LGjmdy7pvylR69l/MyNHiwccYCWkJP+rVu7plBImjKncd8EV4o8TP+YIYsFD346K3v6FNT4zN4D09mj7aqu1X4qtknvmy2ItvenJboA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3473.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:151::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Fri, 24 Feb
 2023 17:13:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.024; Fri, 24 Feb 2023
 17:13:37 +0000
Message-ID: <0d7deb6f-6ba5-af8c-ccc9-e8a92e9b120d@siemens.com>
Date: Fri, 24 Feb 2023 18:13:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] ci: Add copyright header to .gitlab-ci.yml
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0101CA0062.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:1f::30) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3473:EE_
X-MS-Office365-Filtering-Correlation-Id: 4feb8a82-171a-49f1-9446-08db168a77cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7OJmnk4wDxKEy1/tjaeXDHvM2IaEJhh6RmeWFsaa87S/X0P5oK+NspAJbr8VSzeh4AfWd48e4mjnaH4LH2VYX34469eyL4F+6F1k+BUgj8U6LXSI2InG9oIc+btyrrZPv01Y9EfRIQwP9kCxkyTNhO+PD9x8xxH5K2oMIuMGkruqdWu9WnpdFkZod7yMm1VeH5s+sIblGwdaD8fvkp+DOzKK1EVNfzoEbdzESBhpUZ9IB5XzJB02VxZ8WZQGXQo34xrayW8r6u5f6D2QFJsoBF86coCafSJtuMFkZ65LGG7HreLdhJYlVGTZrfT15UKnQhFuuDGBhgUeSJAB5tobCY2eYLcgZHcGSY2MQ/IC5Fhs/U+W6EYy0DNVNP2iwVl/wAgGBRFas0N7+6NiZ2lDkqJDfJFnydCSsRIqKwSclTOVWbbxd9KKdtalhLBYMknVg/eVweAdalyRoJzlZm75CfUSHfFKwPR6RSAsAXbQQ8YgZseYh/QpAXrHQvdrPjgGAs5Ip1Gu5ZYSuMKeIxwMOPCopDK/Pd3QET2fUvvuEwLQk4nHKY8Bg6ckkVCKXjCP9M+B6WnO+5kI0I8I+XCx02byaD73pn7x68sKEyOpwkYrLirpcnKywEO6sYHZtfT4fcj4BG+BL6ash0z92py3BGffEGGaWZshM0Ueux5nZz3zOPo7ifY2mLXuBWFVpTj5CyGGPZzLHjWjMqyPPeYHenp7GCvXj1YGXEWyjM1qhfqkKP6GIxcyvEYqOg90yBDx
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199018)(26005)(36756003)(6512007)(6506007)(186003)(6666004)(41300700001)(2906002)(66476007)(8676002)(66556008)(6916009)(38100700002)(4744005)(5660300002)(66946007)(82960400001)(44832011)(8936002)(478600001)(2616005)(31696002)(86362001)(316002)(31686004)(6486002)(84970400001)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eW5udEx5U1ViOTZLTVpSeVVteWppZE5zUkRVQUJPMTdTM0tPU3M3dlZINHcr?=
 =?utf-8?B?VVhhdjRWT3BsT3NDUFdlTlF2aWc0TW9EeGEyK0U5eDA4UG1tWDVWVnZ2THpq?=
 =?utf-8?B?ODl1WDNWcG1mQU9mK3ZPT0h1S3Uzem9KcE1VcENHYmRDUTFwVHBQS1VVcFlR?=
 =?utf-8?B?TmE4bHgxRGpyVnFPdk1LeWFuSWVpR0hyenJnT2k3bjBTR2lMWGJ2MUxLek5P?=
 =?utf-8?B?U0J6VTBHSFhxZ0hFM3cwbFpBZ0VWMzN6TkY4VmVUMlMzOUhsQldnSFQ1SnhX?=
 =?utf-8?B?Wk9hcVFaYW1nV25wSksyM3U1NmNRTkFVSEQwZXJiZGZjMncrcEt0a0NGZzFx?=
 =?utf-8?B?enFTMGNlNGpOeElTMyszTDdac1p5V0lqazJINDRxdERlM3kydDduelRFSXFt?=
 =?utf-8?B?VUk3cktCbFFmTWR3bzBXVDJJdTZmUTlFYkgwa1pac2UyMGx4cThyZUZ2U3JJ?=
 =?utf-8?B?NGRZanJsR2kxZXlDcmxWQStvbTFkNmhmd29zZnpDQVFQNGJoYmIrVkFkSkd3?=
 =?utf-8?B?SXU3VmlTZm1hTWZWR1NFVW05L2lTSFdjakoxdjJUT2cyQzdvWkQrYlUrNlgw?=
 =?utf-8?B?eS9lUlV2bUNScXZ2ZS9rbWpic21zU2c5SzhiVTlac0lUY00vWlA5MnR4clVO?=
 =?utf-8?B?MEJ6UC9CWGlsVlRDb0NDWFJPRGNLNUk1ZEF5eDNGbFF4dmNocUpOK3FBMGJH?=
 =?utf-8?B?STJ4dzl0dzBreExFalBmWU9NOU1sYjRDbDFNOTVkTGhITCt5YlRXK3NKTC8v?=
 =?utf-8?B?aWhTMmI5K0JKZW5DaEdMLzgzRUVMMFNiSE4ydExKSWRVakRTcTNBdVdzNHVN?=
 =?utf-8?B?eDkwRko0U2t2aDkybDYvL2VUTzdUdVA4TUtSQmptTVZmRmJBdWRkZys2Q2pD?=
 =?utf-8?B?LzZGY291Zkt0S2F2b203M1VBYlNDZ2JUemlteElDWCtGK1A1NUMrbmNZYWlj?=
 =?utf-8?B?eHYyS1B3Z3Ixa2djNldOVnU3ZS9lYXRaQTJibDBHN2t1VUNzYWY5SFNCVGdZ?=
 =?utf-8?B?VnprMkRLUzVlcFBCYjJLYzErVUo5ZXlXbmxjRVhxSEt4TjdYdW80MjVaTkFo?=
 =?utf-8?B?NUt2bUY1ekRvbjRmcktrbGVwVXovY3dMVi9PT2RWcFNTcUl3OGFweXg0amc0?=
 =?utf-8?B?ZXZqcm0xbXZUY2FFaldOdit5dk9WQXExM1lhV3FXQ3FjZHhvSWdUWlFGMnBT?=
 =?utf-8?B?NEdhcmc2Sm5jTERHMm0zTENZbnhJUGY0akxxeDE3cjZkZ2t3Wkxwd2tHTUtM?=
 =?utf-8?B?T1ZWZkQ5dFVrUGd3UlgvVjFPWlVQQmkveTFkWVliUXhmdk12K1BSbXBvREVP?=
 =?utf-8?B?NWZrblY3M1ZmOVFKem1UQTNWZTlnVU8rOUloaGNJYVZxUjJsTDJnSXRtSCsv?=
 =?utf-8?B?cExWTWRnS1QrcituUkdGMHpBbitWTVBRaGwwb0pZREtWNHlzUGl3bDR1L0E3?=
 =?utf-8?B?ekRvMW1ZU1F0YlVwN1hSakR2MTh1S2JJL3dXNDZvTHBoT21pUnBVaFlzSzR5?=
 =?utf-8?B?bk9WSGpvang1b2FWNHRzRkViQUJQQzYrODRDUUZ1bkRZSnRWVGFlbG1MbGND?=
 =?utf-8?B?ekhueWRaSEczRHNjUjNyMUhZSUd0Z3FMRlJ4Y3B5SWFjQVlhdUFvWENKdE5G?=
 =?utf-8?B?ZzZibmFsSkpGQTZBSHl5YkJ5TTRueEdaN0sxM3NCSUZtYTNKaWNOMyt0ODVE?=
 =?utf-8?B?TzNRd0dJNlZaRUx2RDRTdGFaNkg3NXVjSnN2MWdNajlBc2R0K3kxSkIyd0RL?=
 =?utf-8?B?N0pydEg5amxLUncvU2dMMWRTRVJXSHU3dkM3Rng3YTgyRVRtcmcyZlJrSjNU?=
 =?utf-8?B?SE5USmQyeGdzMGNWbWI3Nk1RcWdpWDF6bXZvWCtKU2Y3ZW1STTVZdXpvbVNG?=
 =?utf-8?B?aDVFWTZqMXpjWEdZQnd5NEhYRjU1bzhKOW9kWG5wME1NUG5TTS9ZMjJ6V1hs?=
 =?utf-8?B?bm50a1ZSWHJ1aXVJTll4OUVnc3BXTWxTS0xhQUVsQVJvaytiNWEvclJsSVd6?=
 =?utf-8?B?dkNNcWViUUlCUXh0RFhReUtSVkhBT3RHcHlNTmwzaXZFdkIrQ2NRNHJjWmVR?=
 =?utf-8?B?Sm5rT2NFaWp4K2kyd3d3bEMzbGEzUG02UlNVamRhUlpVRVcrMU1SV09ER2JK?=
 =?utf-8?B?cVZ4N1BZOGl5SW9jQU1jL2J2YmhIZzhESHZiZkFMSDFIMUIvcGhCdlpZQWl6?=
 =?utf-8?B?Rnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4feb8a82-171a-49f1-9446-08db168a77cc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 17:13:37.5670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MkIiNe8xnLBPrBJpay0EmoS3ZYF+Rw1TrfLT5/Dc24MbQzn3z7kHLP1sIBGEd1Ym+NPTXNJX+yREO0eGpS7tQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3473
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Feb 2023 17:13:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10824

From: Jan Kiszka <jan.kiszka@siemens.com>

Based in current git history, top 3 contributions.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 3b0d8e3a..eaf2506f 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,3 +1,17 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2019-2023
+# Copyright (c) Toshiba Corporation, 2020
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#  Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
+#
+# SPDX-License-Identifier: MIT
+#
+
 image: ghcr.io/siemens/kas/kas-isar:3.2.2
 
 variables:
-- 
2.35.3

