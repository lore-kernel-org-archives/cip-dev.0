Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C630C7618A
	for <webhook@archiver.kernel.org>; Sun, 19 Mar 2023 16:22:22 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.79])
 by mx.groups.io with SMTP id smtpd.web11.20122.1679242935821920413
 for <cip-dev@lists.cip-project.org>;
 Sun, 19 Mar 2023 09:22:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=UrA21EyE;
 spf=pass (domain: siemens.com, ip: 40.107.22.79, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jy0KZfwxbWFQAFRAuFdXp0KpEbU4OkxrT5ZuWeqQxNG8H6O1/1bCkm9zyAdMT94bdA7opXkGVrqrk/QgKAETEzMhP0Mtkd5CVYkBdE2nQ6TxMS/6bhbvksVRBPqsl9vWeOZ7SCMF5enhnzPsy+Ng/0sZOSLbFkcigSrTcc9BCbiiquIhRvLrS0bSIAMpX+dwDqNNY6oXVpn9Xl1JLhYmvENcMEM6nlJLaRPN5IOyQRwZxiuXGLEFi/nOFI0N6PdLG3CUnRmjZtZHQ7gLHV/mtmik/pVD6ELAy7al/XcTk4pT3I1V+b6CZiOLelcTduFEosQ6ikdFS/H770ypQ/MDhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgSmaXa7ORLcJdu1a8Vudq+EFdE66HkefFruNcOL2a0=;
 b=SeUW63smMap25CLexi6x08u/TdpR0PF5MKEr71Hj4xE7thpK/RZPLW/XI0OE+KtOL9S6dwwP4kfeDjg1+Nns4bObEDOOkXl5aUKmizwIZQNeNDqGjL4BPLsJJ99tue4n54MCSd3RpbbDlqI8U8oGCrTJAXeyitmC+EGQjDKBS2an3XzUF0jTkVEKh3wB/SQT5i14ob74Tvo5OdyIHPvlNSPWlHjEnIDiYEm/FU4gRt0ez6kLvon6yq8yGNdUWqtzB4AvQHsArQ/j7VbdiKFLF9UmXg7tP6qIVJ/W3pN7tPj1paCBoKWAlUdM19ryX7Yz9ATUCXjhTrxrPJ48zfUzsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgSmaXa7ORLcJdu1a8Vudq+EFdE66HkefFruNcOL2a0=;
 b=UrA21EyEjGAburFYeG9jnqCNNuK0dsTyDYKW6xiFV+2L18mSOd564NZRgLJX62Ap9kZRtr0uAL4+kyT3Y6td9OfQo2QiaaHqboq4W1wJzeKo2EQr8cfiTWC7GJvnu+JEkFkqgFMJA6THpb32UHs6b3HHq9gmTyGAIFZOPcMUOrk1AacpWHWwCeC74U4b3fjKQw5KX5xKqWLYWVA9zheAFv681U0JRxmaVma82kWODWHNbFGJHYsGEZERGFAN/tJRRvhTi2Se00oHSoZkYc4k6W4QVRJ+Kvt9706cF5eWvTDS2vMUxrgVLf0BRUGvhFzH4C3YVwftKYY3L172Is6Igg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.8; Sun, 19 Mar
 2023 16:22:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6178.026; Sun, 19 Mar 2023
 16:22:00 +0000
Message-ID: <b50cd713-e5fa-0087-abf8-8dfefc1e1c2e@siemens.com>
Date: Sun, 19 Mar 2023 17:21:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] Enable ccache
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3873:EE_
X-MS-Office365-Filtering-Correlation-Id: 4354e346-a6ba-4c65-b586-08db28961099
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	TkYeXw6zZDiv8G+UT5chOIB3C12jd5JyOJNIOSF9GWfm+yA4l35dI+8XQHEIHBpnPKPPp/IQKURwWEyThkXJkMgXnSFC6eEJp3gD4hvrxibE3CY4l+aHCmaGrfr2CmuuLoU+20T2DYYRNkGM7Yrg7m75x8m5KKxMknzlr+c+iQLeTBxwzpuEmy/SdYBvSRUcB0stgmE7rkEUonOW8hUtJiomLigXp5u47/ST3c4RIrou3gdlhHiEnsSox0/rj/GaSBFXFZyb1SCjb7CowAHCBSCtbDW0XxbLiqLXKrVDOpDp2IzNpVmCQRNAaqx/Kc355VKzhR1F3nHOcE9Eq+aKKkCIvvG5wUn6WOIxhdQ3yI8Xy0QpUhnEvSMb8bVKLateAZbDqYHwg9Z9TgqcxPL+GQM77fuJ05KWm/c5+wYy07MabuMFdjTa7k6Fyt8/aqV5NyCaxJzoYDqPUfebTGmLZfTJRJoZWKfeYBZzlbaovr4z+xJCXqWq36PsAKelgPRrb0fdTOHpN6JSn3Uu6tktvs/1X+37N3tUNuNiYtgQ8zSEQ+/Dv2Np6UjkjcKMvCjjJkDYRAxBcrxOnEP3DV9Eany/1m5GTmKGtd8SswZ11lrJoUGt0aQACzSX3GiGv1r+2PH66soYQVH25RnL2V//cg+50mTZKwQZB46Dhiti4g5f2NkFmSsBPEJoWLAAGXt6dfn96nfZOw/R7fS8MFtM4I1Ef+ep3GcKUbyy+JSL+6Y=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(451199018)(82960400001)(6486002)(31686004)(478600001)(316002)(2906002)(8676002)(2616005)(44832011)(36756003)(83380400001)(8936002)(4744005)(31696002)(66556008)(66476007)(66946007)(26005)(38100700002)(86362001)(186003)(5660300002)(6916009)(6512007)(6506007)(41300700001)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eDFLVGFkZ1REUm0yWHBXa2ZSNzFZWmlXa0ZiZlpKcktWZXdIV0VUK25uMVJ3?=
 =?utf-8?B?cWlkd0RCQ2k2ZXdieUhrbi9idk5DWXh2ZzcvUHVpSHRNU1o5TG9LcTJDaDM3?=
 =?utf-8?B?YU5XTm1KZVd5T3Vndkp5enNERWdBYTg4SHRsTnJqL0xKTDJJcGJZTUhkNWlE?=
 =?utf-8?B?ams2TmpFTlFZMXBaY1RvS3F3RUlaaXQrdUl4aytGUStUamxJUHJJUThVRG0r?=
 =?utf-8?B?cHViNFAvb09sZE84eHB6cUFEc0Z6Qjl0MUhaZ1dkeWlLQ3gyQVd4TjNLL0Jt?=
 =?utf-8?B?aTB6OVhkbWU5WVpIc2pDd0pzWHRNRXZIOFdMcUlMOWlhNVkwU0IzdU9MQ1Yx?=
 =?utf-8?B?TkFTQkhGT25ZaXFXM1hndHpkODQ1aXNSTFhoYWhRb0hPelY5QWNMa3VKQUZm?=
 =?utf-8?B?Skc2NDV0Y1AvWGpiVm8yTUVEQTE2L1k3MXZJcTZ4RGJqR2FuNktSVzlHSXhI?=
 =?utf-8?B?THRDZFlxTzlwbXRMSWhaVHBnbjYwbE9xRlZ0NTRMMUYzV0NmNXZDMW9RdjBw?=
 =?utf-8?B?RjJpN2JzcXNFbjh6bUowbVYzZ2dZaWZCTkwrUHFOS0QvOHJsMmI5bitsNkM3?=
 =?utf-8?B?TGovMXduN3RxQXlLdUpJeHU2cU5COGtYeDQ3N09CdURzNFlyRTlweEh1T1Fq?=
 =?utf-8?B?NXA0YmRkYjVabHZnOXJxR1NkWjZ6TmFmOGFxbHRYaWZCTDBlUDE4Q0dWbE9E?=
 =?utf-8?B?aG5zeVRiWkUweDNhSFlSR3lwYVNrVEM1eVJGVlo3bjhiU25iY1lJdnF6dFpo?=
 =?utf-8?B?T2hPemw3RThxOFpKaVJJRVVNZTZaaEtFZFNNanNKZ2Y3bFJhSjB4VlhQVzA5?=
 =?utf-8?B?UW5QOWY2M3c2d0JWQlQ0dSsyVER3anM3THl4Z3JCYnFKMmhDWGU2SWJ3MDdM?=
 =?utf-8?B?MzVSdDhZSEl6dVgrYXkyQXEwUGxEdS9JQjViVXova29KUWNiVEF1NGdXeWJh?=
 =?utf-8?B?WkpoOVFCRThpNWdUWUZmSFVUQzJFQVFZUUtPSDlCS2tPUGNXQjQvZVh3WXAr?=
 =?utf-8?B?U21vdWlhOVdNSjBabzA5dGV3Y1A5NjBvNisxdmVVd3lWb252bXE0MkpqMFJH?=
 =?utf-8?B?WTFDNTlsL0pQUWo1ZU1iTjI3a3hVWTBrUmNIUy9veGd6Q2J4OUJRbGpTUkFV?=
 =?utf-8?B?OElKNUxZT2FGM3V4Mm9SZHZZdExlVElPQWlLL1RSNDZIbUgvNTZPaFpZNWJm?=
 =?utf-8?B?RzV1eFVCMWN4dThKT3RCUGFucWtXckhnR1dCc1gyQlYydXFqTVpLTitvK0NF?=
 =?utf-8?B?N0c5ZXlWRWwzMVorMXRxdHF4SkQwMURCUDR4eFB6czMvN1V2cC93ZU1BUUYx?=
 =?utf-8?B?UDJ6WUVSak9mWStqVUVYWmU3eWI3dDl1aEEwYTNYa3VPZTZrYkZtVjVmcVI1?=
 =?utf-8?B?RFpETFptbTd6bWhyR0JQL0ZqSzlqeU1VcnlVR2IxZjU4cGd0clFKc2dxcXZ1?=
 =?utf-8?B?K2oxWWh4RC9SV1NCdGlPN1pWbDdROFVicVlqc2w5WTBvKytyUCs1c3BjNmdk?=
 =?utf-8?B?b0xTU3Y2M3BiZzRMSDlFSERLbDdTMjFQQ1A1VXh1d1BmaUFJOWVsN3ZZbjk1?=
 =?utf-8?B?YjNvSVRMV0NXRmJjaTRrUzdQNW9zUVFCSm55NEo0d0p2YzRnVGZmSjFWbDNi?=
 =?utf-8?B?eVZIQmFUZ2F1emNZb2kzVFBSUGQ5NE84QXpPeHNmbHVaT2lHaHhkQUxobnFj?=
 =?utf-8?B?RWlaY3dzMkRKbVdQajJJNGErWGp6TjdrUGRxWHhyd1F2UkJGWTJWUVI0MzF3?=
 =?utf-8?B?TlVWVWFqTCtRVFh0dU9nOWdNT3h1STBUbzluRVZhM09mYS9tbExDbGhYdFgy?=
 =?utf-8?B?eDFFWjI2MW1oYnhMNzd3WENOd0NwUTBwZ3lwL0hIbDVBNGtlWEZmemVHRUV3?=
 =?utf-8?B?bFdiQkRDK1VBKzZjMDBPdGM3NU9qZ2EzVVE3V1paNTBxVUxsYzhmWVZVMyty?=
 =?utf-8?B?MjY4VDFxbnVWQk5MSlY0dms3Y21WY20xRll2SXF1ZlMzQlNzYksvaC9MdmRQ?=
 =?utf-8?B?R3E2TkpnWXF5OC9IYkhmemNqUnI5R2psdVd6T2RIWWdXeHdXNUIwbVVwVjR6?=
 =?utf-8?B?VEx2WkZ3RkUvL2p0bE9UQm1lclA3WlNyWmUxTkUwaHM1VytGUnhVNGdhTUxQ?=
 =?utf-8?B?VGFzVnBuejJJdkwxWkNvV0c4cTNQb0g3TTEvS3ozeHlPL01DdXBCQ1dUMWxz?=
 =?utf-8?B?Tmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4354e346-a6ba-4c65-b586-08db28961099
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2023 16:21:59.3489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JtZmzXZWeZnT0+ramNjDRQ740igYtl8TnHCsAHzLgrIoSsUtcQv/l/O0bvlxghwX+liGDos9a3omOrTImh/yOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3873
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 19 Mar 2023 16:22:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11034

From: Jan Kiszka <jan.kiszka@siemens.com>

Accelerates rebuilds, specifically of the kernel (e.g. with adjusted
configs).

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas-cip.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kas-cip.yml b/kas-cip.yml
index 73a4af9c..b6a3dedf 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -35,6 +35,8 @@ local_conf_header:
     CONF_VERSION = "1"
   cross: |
     ISAR_CROSS_COMPILE = "1"
+  ccache: |
+    USE_CCACHE = "1"
   root_password: |
     USERS += "root"
     USER_root[password] = "root"
-- 
2.35.3

