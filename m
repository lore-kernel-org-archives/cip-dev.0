Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73A7C001DB
	for <webhook@archiver.kernel.org>; Mon, 14 Aug 2023 13:41:03 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.59])
 by mx.groups.io with SMTP id smtpd.web11.107532.1692020457217114293
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Aug 2023 06:40:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=EQqRty9W;
 spf=pass (domain: siemens.com, ip: 40.107.21.59, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMWu2YUzv2VESivjBEwD0ikS+qsgfjDXWkXW1xuUyCW/2GvGb8bR6/5s7+9Y7uI1zRTVptidgSeWzFjidLVGYhy61egpLqx/17ERsaAIYlUPd85tbOc7CROJAu8V/3CWjInwTqMhWpciaQnyhl1NF/N698C4j5c5Oig6O2EWaDc8iZhGjRCKMHLDXZkQdm8eJT0BQ/5y7ua0wavttrxG9uck1c+2krXUqsIanxNi9DFmAkD49P3MdHcPDzuz17wc3hsmU/jyKkuhtRIZCZU0FjuKlukr2YbhFQl3xUJxCYpBoDwaPHx7ANqPFBGJfVr4RgUEo8X4ikkN4cFvrbnU2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHizhtrVhDDkEj0y3lVW4nvUV5aCaPNBGk9vHPukY/0=;
 b=fuPauA7UCslnMKkY59q/7YIyEYAz+C4jd4avbJfW4h4M7amrhZaA2wmmuy90tTI1QKzzHpNj8/FgMubdUQG69t86VEBbbhS/o2rpVBZzuDFnQf0YUjIm+heBU+npVXjtNn6j4FtkjI5ZRpD3wFo2oZg+CaffIfdz4j1YmtOQo+SN4HOrMBQMJatINTov9H+Z92Z89Nh4OypycrESQ+DEF7A8WNMPWskO8PWn4IhqKkNtSHal5vasRd/pd556eAJ9DyhHtd8vFB+EpCmBa5i3FSvTc3LYPjB5TAmVmE/ZR6Whk02C+oTeB5Wn5rtmYIiOtHAdBp3zpgq1WDwtKjnHiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHizhtrVhDDkEj0y3lVW4nvUV5aCaPNBGk9vHPukY/0=;
 b=EQqRty9WEdhKCWhmrh+nDAOhXxdmy3sKKb/+E83fkdq3HHfgOpBOnsV/R80UMOeWj2N04FSxJq4u484r2SOHybMBMdbYfp8EbTJUoSCifrPvvgUR1wPQvPDrd5QZj9PwvTuE60ILMwNH8YlhD6wUNLg79NZdSvbR1aB+4TcNRz+RftQJus//zMJbVbleCyPwrxzowi9xLPYjLncinNRQ/Sj97zEOki6jraMjzIqe9MtkujPjGJbkcYwPPWek6xqd+dZlZbc5/ozeC6s3Vy/FlPDlPvX3QZ+w4E1Z1dTFBqg4q70UqA+Op+vBqjhWLaIFFtnd1ccgu45xN8G8VOESJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB7933.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:481::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 13:40:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 13:40:53 +0000
Message-ID: <802897a0-7125-48e8-b7d7-50c8b85f3210@siemens.com>
Date: Mon, 14 Aug 2023 15:40:51 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] secure-boot-secrets: Add missing artifacts
 links for sid and sid-ports
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: e2cd507f-fb22-4e23-5c3e-08db9ccc1495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3rN8QB+R9cjvtHhimRovcGZKVIcbFQ7jOLhhUDl9w4chIDdYCUIKad4KXeBXZRQLUzzOZIhKORh3WYPICS0Ty5pHAp3dx61wlVokwXLHZSnhR5rbLbnhgoMYsdGTdhYgHnLVK9G4o+4Zsdu+q4OQX8Hj0ZWOpJ54YB6M39Lk71taCbta/izIazhpOLp68+FUXJ12esRAhxQjFAr0Z4HoyY2ngWf4nUn/DvZD2bSSr9vhaasAG7+Kl9Yy6yyxrDUTY6tBnfF8RzAV44+TDM3KmnwnwSvCdNK3U/Ty3VaQF3ea6jlrsmEZi62W5rjvk5CN9Npz6sSio6xVAFmYWWajE2WE9c2muhAaBwZStSb3UvU//A5m8W3vJj0ddIJ2OVglYUzf8XKwdf0ClZOCvbyKTjHkYoG+ONv8BzBPCm5gh7QL3D+CebV3i3IyMI0LMo04wUnyN748Q7AWSma3AdV8ZdJ+qM5CaFwcjuxyqzrWOZGPCsDZcs2SIX9oZPn8vy801XfRAYzfmhT5YWY9g2zX7/IctI4fQD2YTZmpdVPJEByQ6za0Ffai74diGGTNWWrdcCd6L4PCtOgrnQQvhJjEvXWSBHktMZHH6VRfhrc+LoC7ijCRqrPcYJntdUSuWj7Hbjud/MrqHCQ221WbRfEamQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(376002)(136003)(396003)(1800799006)(186006)(451199021)(83380400001)(41300700001)(8936002)(66476007)(66556008)(66946007)(8676002)(316002)(6512007)(31686004)(2616005)(26005)(6506007)(6486002)(478600001)(38100700002)(110136005)(31696002)(44832011)(36756003)(86362001)(6636002)(82960400001)(5660300002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T2RWbVJZWlpOWVBqVGp3Q0xCRG9MVWJpc3dLVHY5SmlvMVE4cmROVCtkSG9s?=
 =?utf-8?B?YnpOdmI3dHI5VXEvL3Q1NitqaGczL1c2dHFGYllQMnhxR09COFVTZ0dZVElh?=
 =?utf-8?B?dHZnVno3TGlGcjZaazVFRmZRblVybmJlZUY1eDJvcXQ1QkVaVUIxNm14Wmhm?=
 =?utf-8?B?SnJwSmdYbll4TXA4Z0oxcUVSVVEvb2VhenlwWXV0MzdvZEtxRGNkTTBiMkY3?=
 =?utf-8?B?Y1dBYjlqcmZ5Vm93eXM1UzErWERHbGp5NXVPOXAxUnFzWUhzNUlXZnZqWWNM?=
 =?utf-8?B?NE5SUGFJVjZvMnJnUi9qYnp1NWJSMjFMcEVLRFZWYWZTZTlLaUkyWDNEbjlx?=
 =?utf-8?B?bGhZWTFJazNmYndUNlladkN1MHl0ak5Zc1htUGxuWTN3QmdWZFUyZ3NEWGVZ?=
 =?utf-8?B?OTI0YkY3OTZTQm9FRURHQ3VHWkRGYkpWMVFlOFJWUHRsZmh6dWplQlR3S3JI?=
 =?utf-8?B?YlIzN3VBKzNFcnU3U1hER3hFYnM0dEZnS05BR1JmQjVBQm10bHgzNyt0bmhs?=
 =?utf-8?B?OElPUFpiR0s4L0FDcDY3RHJ3citzNk45cE1XY09wVkh2ek9Ga1lyeGE1d1BC?=
 =?utf-8?B?Q3NWWWRZYVM1SlcxWG11VXIrcFBHMUZwZE1NKzYrUW1PajluRkREQ2E3TDJT?=
 =?utf-8?B?Y3FZTmUyc1o0dnhHbTFGK3g2MllObC9BR0FkR2I3UzJPS1ZyTll0YXBQVG5R?=
 =?utf-8?B?Rk13dVZudjhnWTVmaDV6a3ZmVGhjSTJKRUNQRjRMcmRQSjdLVWNDaDVjY2dZ?=
 =?utf-8?B?K2Qwdm9IdHVrZ0U3RllvSzNrUEprZjRGcUFpeWdGT1FEWHFHL2J4VXdScTE3?=
 =?utf-8?B?cHpUekhDM3dWbzdsUTVHc0lGT25WQkxKV1lxcjRPUk8rZmlwZnF3c2ZxRUZl?=
 =?utf-8?B?eCtKNjV0WXdwVWVZME1Rb25XMTN1ZTJ4M3kyeHEvNmZMT3laOGRkWklEZ0Na?=
 =?utf-8?B?N2N6cEdaNmd5dUtISlVzd2IwWXl4NzJ2UU1wOWd0UjFHK0VKazhFVlcxdUdH?=
 =?utf-8?B?RHVTK3R1MU85UDZ6WVNvNDFoSzRRY3FNV1FPdk5Oa0c3OThIeDVwMkFpV2Vh?=
 =?utf-8?B?d0U0L1BMT1pjVFJsNjdYVlRsc1NhZ0Q2MzJkczhtekdtRlhSRjUvekthMXBz?=
 =?utf-8?B?ejJQWkZQWEpkTENEQlBaR2w4UVZuQndEbVRpQmFWc2NQcjRIZytRc2lXU0lL?=
 =?utf-8?B?WEk1V05yUUgrelJVMC9CVVI0SDRhYjdiSE5STno4c0FPZUZkRGFTbktsSGt0?=
 =?utf-8?B?WFNIbVFwdlBORGJ2elhNODY5UjZMcXVKdzNvWXYrbHhLajVOVGNweUJCdTA5?=
 =?utf-8?B?ZFVPZjdic3RZcDdockZ6OUswSHYzMDd2SnIrQ3NjVkJLYTBNYW5peWFQSklv?=
 =?utf-8?B?cCtjNFFNLzY5N3grNjhIelhiVFdtaGg5dGdPOGVsbE1YY1BjcEFNSEREQStN?=
 =?utf-8?B?QWU3a01xaHYxUVladXZjRkVyRUk3QlFzdExOV0NDbzNDeE96SytJKzA3b3Nh?=
 =?utf-8?B?NXhIUG43Z3RzL1pJTjdXbGxjU2s2MTlBWFNidmwzUlZxNVJiQWlKa2tmRjdM?=
 =?utf-8?B?cHBhWlRpNTJzaUZTVzdpaGpxUmE4VUNsRmd6ZmFiQjZVTkp4KytyWXB2bnVU?=
 =?utf-8?B?NnJSSnorVFlDUndHMHJHQlQyd21yM0Z3KzhhZTlVQll1V3Q2ODFQN2FtZnpn?=
 =?utf-8?B?VXVOaDdRelFEK05uYlFBdTFGdHlidHFOMFh2RSthMzlBYTU3a0MzWTRsWU55?=
 =?utf-8?B?NFpUenNaTGxmeEtPTitqWlpVMW9ybDFhL2dnMjhOWWhsV1UyMEk5R2MwcjZB?=
 =?utf-8?B?WHRjSWZQaWRkY0t1Yzk4djJ1akRRK1Zxd3RtME1IZStPakZZdm1BUHBscjRX?=
 =?utf-8?B?UGI5VTR1NWhKV0IxYlZrcWNHTGttY2luV280UUpqdE1KMVY4WmRiT040WUNZ?=
 =?utf-8?B?Rkw1c0dIWG02QnowVDFDY2kzdG83TTU3RTFVd3Zua0krWGFLR2RSaEpldndq?=
 =?utf-8?B?MFVWaXoxU3JFZllDZ1NMTVJhQjN6RXg2dGNvZkh3Rktzd0gzMXV3RWlGaUd5?=
 =?utf-8?B?WFBTUTZGMnZETTFxbzQ0NVNCRkJZK0NtdHlFeE1JQXRYbDFMU0FuUEhtK2Mz?=
 =?utf-8?B?cGdTNERaeWxWMzZjc09hL3ErSmFmcEE5azdsMHpLcWVuS0Z4YlZYT1JSYnhY?=
 =?utf-8?B?NGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2cd507f-fb22-4e23-5c3e-08db9ccc1495
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 13:40:53.6535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qaUdAYmoL+Dax2L17JF64h1ba/kAccm7IaYUdFCtWj8lbueS9REhc4MtiySXMAR4hiLAnAGmpDynEljUQ3+FFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB7933
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Aug 2023 13:41:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12651

From: Jan Kiszka <jan.kiszka@siemens.com>

Fixes: 18e2d323 ("secure-boot-secrets: Use distro specific snakeoil certs and keys")
Fixes: daa9e673 ("recipe-devtools: Add recipe to sign SWUpdate update binaries")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-devtools/secure-boot-secrets/files/sid         | 1 +
 recipes-devtools/secure-boot-secrets/files/sid-ports   | 1 +
 recipes-devtools/swupdate-certificates/files/sid       | 1 +
 recipes-devtools/swupdate-certificates/files/sid-ports | 1 +
 4 files changed, 4 insertions(+)
 create mode 120000 recipes-devtools/secure-boot-secrets/files/sid
 create mode 120000 recipes-devtools/secure-boot-secrets/files/sid-ports
 create mode 120000 recipes-devtools/swupdate-certificates/files/sid
 create mode 120000 recipes-devtools/swupdate-certificates/files/sid-ports

diff --git a/recipes-devtools/secure-boot-secrets/files/sid b/recipes-devtools/secure-boot-secrets/files/sid
new file mode 120000
index 00000000..91bf492f
--- /dev/null
+++ b/recipes-devtools/secure-boot-secrets/files/sid
@@ -0,0 +1 @@
+bullseye
\ No newline at end of file
diff --git a/recipes-devtools/secure-boot-secrets/files/sid-ports b/recipes-devtools/secure-boot-secrets/files/sid-ports
new file mode 120000
index 00000000..91bf492f
--- /dev/null
+++ b/recipes-devtools/secure-boot-secrets/files/sid-ports
@@ -0,0 +1 @@
+bullseye
\ No newline at end of file
diff --git a/recipes-devtools/swupdate-certificates/files/sid b/recipes-devtools/swupdate-certificates/files/sid
new file mode 120000
index 00000000..c688dca3
--- /dev/null
+++ b/recipes-devtools/swupdate-certificates/files/sid
@@ -0,0 +1 @@
+../../secure-boot-secrets/files/sid
\ No newline at end of file
diff --git a/recipes-devtools/swupdate-certificates/files/sid-ports b/recipes-devtools/swupdate-certificates/files/sid-ports
new file mode 120000
index 00000000..7d00e075
--- /dev/null
+++ b/recipes-devtools/swupdate-certificates/files/sid-ports
@@ -0,0 +1 @@
+../../secure-boot-secrets/files/sid-ports
\ No newline at end of file
-- 
2.35.3

