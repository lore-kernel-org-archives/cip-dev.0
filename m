Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFB7C3DA7A
	for <webhook@archiver.kernel.org>; Mon,  2 Jan 2023 11:26:13 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.47])
 by mx.groups.io with SMTP id smtpd.web10.33701.1672658768919728782
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Jan 2023 03:26:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=sXFjrI68;
 spf=pass (domain: siemens.com, ip: 40.107.7.47, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXpByi6LOlSt8hdw7ivrropxskJFbiY74DMMdubONP5AFEIVr4xY/GRrfsbL/VR0puAxdWMulXhjCXhTY0pzagUm0lXbGTrbWE+WskxUIzASSbi8qrbuxhd3s/Lm7MGTINLvb0Ugbjd/D40MrdlI+67zF1eSHXHopvzfopZBY/crAFL7uzM4JnsNkau8w+1jzr/1y02OU1uDMGMsaEJ+YeM17a4xtJ5hrPslZfZ7/agbuTp7+dU3pIC4Zl+tLdpeDl7zJSz1lNsRbgchYReML3e5if5iQqzpvtomIhQTEa8nFAW+9R/qBuH4juti66Hri3ONpeSzpEJYN4igkSFYWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSNOq5TUfzEIZa2uY5f4D1RLbumodBaXFmrr6i6BUAc=;
 b=ZYbJVETXC3LpHZjkyU5ICZufKhDhWQ84DgIvtkD4El2U1HbgsMUqlKc3t+uEvRKcsq/0ZtPdJeIk68E3CcM9IqyoXJQz2VdZY3y5IqfL299qyWn2FEBBuhRnOG2wCWx7sj2QcQN1dYrus4f+4yHAv+jQlOzroW8ETUKMNT+PzXvBphqz3Kxh2DbLEHebfT6AmKonk3Yix/Zabl+gLP25NOUUBV/gO0yVj5b5SLjzBOnsNPGS+ujWiP1RBSE0F4+llzy9w7f8QCvmztlpmMpY9jWNBje7KvgjRFouD/eixXmHu8qdkCrQMZsn/jjCQ07joeUIa+je3HOcw97Du1aqKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSNOq5TUfzEIZa2uY5f4D1RLbumodBaXFmrr6i6BUAc=;
 b=sXFjrI6807gP5Qze9Pk1Qp2hzPQaFfHtqErmUmjj1xZ7ewd7EeR+JXaeyuA1srPGvtM1l5y9xwrFHL2FEFz2QfmoxS/Wie5IhgdAevoIJX3jb3h76ZrpTpf+K7RplNR3VSeGxegYWRpFWBdGge/TvJuXQhNacZl85rViZVPMl/J4ASC0A07UFSCfC2+dDJXqqxLCrLrZiBOhBxyTLkLE8/A4yvBhNVdJQjF+s2y8sBFhIGkMGnOe5e+SMnzW+DdVTfECWGCHIQg6vT6asoVzFYrOiQqgX7qMAlhniZntTJtyVfAsCEkYR0CQ8KuXJvTk6UZ6LxYBUotfbacZhbsu4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6389.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:536::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Mon, 2 Jan
 2023 11:26:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5944.019; Mon, 2 Jan 2023
 11:26:05 +0000
Message-ID: <7fc6354e-6981-a543-773c-624821658240@siemens.com>
Date: Mon, 2 Jan 2023 12:26:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] doc: Update link to unified kernel image spec
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: 69d0bdfe-82de-4833-3dc3-08daecb4233e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bYkXbwCN4Z0cUzDjl9Kfs0i2H5SdDZcIpf6OcjZrq1cuWEyOUwexZ+eqnA3I6usvN8dxynCoQNR0NzfFLteP3Cseb6cSapwdwO57BIfKmv50CcehGebQXkUjIMKPeneazNAYXmx1ILgTn9dCwj7P0ZiTYQu8qABxiTCQh+k6FVVfftNqE60Sewv/EXS45BkJnBJMcqwNEDITB/Zsjfcd3ZhmaC4NMXpw9N6+qkGjjFeLY3P4b/hEV1mcYA3XPnq61Fn3rqz7eC0Gxrz5V59t0D6cIlj8E/5aY2PG5wBQq8D+01ZlIrhcZhr+S7xpYORfACfAWSMokMh8f8lNK05+WdDI36VJlhgDfp0SFi7f230+Bh3vZC4l5K0b4ocjuvUvgXB4tAdQ2MTMgBxgerWjqb16UFu7Io5heTHnaaHWf4J7uvzGGLvDubFurrORS8/oULT5Zf4P1uwnqJ90zgJaMaYpypbDVp3w5OCNQ6vTqJBGit3fPBWlItsdymAEebQ8IaXEnxCLTy5Outq1C49dt0+qHoWlS9W0u/TSfSt3721SnJFjnol+JXA7VwW295AbnO8TqSmOzWLhNcAT/0+AZQr9n/mdEgu8Aod9Pf0PFdtA25lUubQriToRcB6jojDclyFlDr8AtVh2ntSPs3HFUzerqYIcQChLYEN+ksa1ALM7g17viCZ4WgCJaaCxEfrkaJZToh3DhStm72IpUsAd5DVsnmMm+1WyJO4YxMMEp5RgAnyDNuqWo4O2IVXGEkKecRKvYa0L74ea5yHFav3JD5IWmEe8SvKhidGWwRnjwfg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199015)(41300700001)(8936002)(66946007)(8676002)(5660300002)(316002)(31686004)(6916009)(2906002)(6486002)(966005)(6506007)(66556008)(478600001)(66476007)(44832011)(2616005)(31696002)(26005)(186003)(83380400001)(86362001)(6512007)(38100700002)(36756003)(82960400001)(22166006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SDlMSTh5ZG5JMXhSU3JnMGpQWEdoVlp5ejZpNnAwWStTV3VnZFhFZUVWM0k1?=
 =?utf-8?B?Zis4RGsrbWQ3SndsS1Y4alhOLys1L25YUUg1Y3lUUEphVWM2SmxFS3RtMm5C?=
 =?utf-8?B?cjZHcEtXYWFneFZkWFJiM0pYbWRKWWpNUlp5WGZFOC9sWjQrQWRQQXBoc1Qx?=
 =?utf-8?B?MDZNb3VGbS9nSkdrZmtPT2JobzBjaTJoN0N6dkErMmhlallVcjFtY1U3K3ZB?=
 =?utf-8?B?WnlGZFFxOHY0MTNpNDEzekZTTGUvc2VOUlB0aytqelRTdSt1cGlQcXNidVp3?=
 =?utf-8?B?RHBFSHpvOUlVMGhSZDFUMndFODMweVZBbHk4dXN4bzM0d2h5K0hHQW5yWncr?=
 =?utf-8?B?V2txSkxHbHlscnJQc1lPNXREcnM0UllyZFFxWnlZdSs4QnFpWk1QZVp6M3pY?=
 =?utf-8?B?TDJSbGlTUjA5QWVyUFZzTGIxdGoyZlYya0JYeUplQytlekJ3cWo4QkR6d25V?=
 =?utf-8?B?a3JCS3NSM0s3UmZnTStMSkY0ODlzdEE4ZGIzT1drVEIyanRPUmpnQWZCdjRv?=
 =?utf-8?B?eVc4cExlajlxZUZRQ0owalNjWmYzajBHa1JUTlIvUzdQNHVqZWlFY1dTenhP?=
 =?utf-8?B?TUZCVGt6cXZHSjlMUE9wakl6RlBPQi9nR3dGSm9UOG9KK2ZJbm1NekNCTWxv?=
 =?utf-8?B?VVVJTkptTGpiMzNkQ2xqcHZiZkVOV1E5dmdtZW1KQkEzRzM3M2JqZ3BvQjh0?=
 =?utf-8?B?TmR5VzlPUHQ5bi9WWmRQbjVVMVdRMncxbm9IRHhxa3pWQkppQmlQd1pXR2kz?=
 =?utf-8?B?blYrQkZib3RHOWJPTXFEdFk0ck5YNUFMMjdDZDlteHB1RnhDOFdqOEI5akN5?=
 =?utf-8?B?SDg2bDVOaW1tY2ZQaGxnT2V2bEFNRmF1ek5SK3ExdGpWWGZwT1lIcG9aS1pC?=
 =?utf-8?B?UXI5bGNtRU5TMkU1aGlqeFZoOVdYWVZucDZzRk9RaHMxMkpsU3IySzRBdEpH?=
 =?utf-8?B?aVZpb29YUUV0Mzc2WXp0Yzl6c1ZRWHBZWjdWdFRqVlhFNURGY0ROWXlUZGlt?=
 =?utf-8?B?Q3Qrb3BIWW5TaHpJTWZqQSsxT25oRjJ5TjFabTgrbGZsRU9PVGpOVUorbUxs?=
 =?utf-8?B?QTZYd2pUUDNGdldONnoyOVFBY0Y2Mnk5RXpIeHRIMktqb0JxbkR1bGgxZ1Nj?=
 =?utf-8?B?ay9JRlkwQWtqYUE3dTJzSnN1RGYxZGNkcFkzT3RNeXNPSGJ5SFd4bXZrK2pi?=
 =?utf-8?B?bXcwNmhiZk5VeE1lb21rWGNNaWNGKzJPeVZPKzlUQllOaUNnT1lkbWJRaXM1?=
 =?utf-8?B?c2h4TlNoWXdFd25GMG4rdHE1NlZGTW9zNHZZSVltcXJSYk5KcGQ4QVNzNmto?=
 =?utf-8?B?UWFPMEJQV0pFckxCQTQ4SHFURlBtY2l4T2RoVGhJS0hBYkRsdEpQNjB1N0s3?=
 =?utf-8?B?T1h6MzVoaFpqaUwwM1l3dmJGSTJtSjhub0hGSFNIYmxidmdGZTJKUHYvek9X?=
 =?utf-8?B?RDcvR3ZRU0FoalBsU09yaVJpdC9RYUpzSEVxa1dYckttRzhFU25SWUxnZVli?=
 =?utf-8?B?MjVEVGozTUQyN1dSS2s1NmxVL0JNamxMVDcrN2FwRzR5SjhNZXNUTWMzYXJu?=
 =?utf-8?B?aUkrdjEyeFpFOWxuU1dBWHZlbjIvZHlIaXpNTTJrUnJQSE1sck9jVGhJNm1L?=
 =?utf-8?B?T1lWTndKSFQ0T3BoZksyNEVMdDZoYzVTQU4xUHVRa1lieGt5eTRFdFJWNjdr?=
 =?utf-8?B?YmtabmpRYktMZzVVOXZrZldJUUR5cHp3UmczaTlwdTNrcFJCUFFjOTJEdE1p?=
 =?utf-8?B?bWpGT2xNYkUxbXJYMGZMUTQyY01ERGJITVdjSDhvakN3WEducjFGZFJuMGhH?=
 =?utf-8?B?VTRkVms0eE96V3VBTGVHRE1qOWdUVkdudHl6dDN0NUhuc3JHdFU3cnAvUmQr?=
 =?utf-8?B?QWhubGFqSUNHM2xQUVpxWmhZdjFHS0dUZk9BSWtybDIyajd6T3J4SlFzb3Yx?=
 =?utf-8?B?dzI0Zk0xSmFZMCs2eC8zTysxTHBHUmhxN3lMdWZ6ZGRERERBcDdyKzFubFZ6?=
 =?utf-8?B?aUk5YWNPWlRSSXdxQncvazRpbjFmbVpqN1VlNjFVV240MFZJalB3NzdlM2Nx?=
 =?utf-8?B?TUtwd0ZOSjBsUkJmdzRRSU11cjVJd3NoaklQNDFueWlVajh1SEhZSTVjRXpJ?=
 =?utf-8?B?aUNwUGIvNERleFNzclZ6dE9DNnNONFd5S0RHVHBHU2dzdXRzZnJQSGJTVlNG?=
 =?utf-8?B?YWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d0bdfe-82de-4833-3dc3-08daecb4233e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2023 11:26:05.6990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: px/wRMaoDn9SlJvzTKTw98KDUIuy3Cf3CegDM+zHNFbRPI0r5z4ev7OJaSxYzwtN4TRnDrlM+OK1l0ZiNu4x+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6389
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Jan 2023 11:26:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10274

From: Jan Kiszka <jan.kiszka@siemens.com>

Closes: https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/53
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 doc/README.secureboot.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
index 8c218d25..7dff37d3 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -6,7 +6,7 @@ This document describes how to generate a secure boot capable image with
 ## Description
 
 The image build signs the EFI Boot Guard bootloader (bootx64.efi) and generates
-a signed [unified kernel image](https://systemd.io/BOOT_LOADER_SPECIFICATION/).
+a signed [unified kernel image](https://uapi-group.org/specifications/specs/unified_kernel_image).
 A unified kernel image packs the kernel, initramfs and the kernel command-line
 in one binary object. As the kernel command-line is immutable after the build
 process, the previous selection of the root file system with a command-line parameter is no longer
-- 
2.35.3

