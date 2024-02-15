Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6639DC4829E
	for <webhook@archiver.kernel.org>; Thu, 15 Feb 2024 07:21:55 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.63])
 by mx.groups.io with SMTP id smtpd.web10.9073.1707981704888424590
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Feb 2024 23:21:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Q57S27Mi;
 spf=pass (domain: siemens.com, ip: 40.107.22.63, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZG+joQOjaWWGcU3G/+Uv9s2bdpUeOQrE6bs0hmiY9tiGk+k2jafAMc6qXIqIALf3ssnn4Bea6X9w9Zfs+6GhvI0lMXudNCy4TG+wQvPGkl7L9qJV1XGK+6SiJARc7PiVu6eAJvktLfxnhQaAoYn4Y7sQfzH3/cQNESqOuRXCczLdOoLaG9DS2kB5xGtDry4Q1kUC9/iYMspzlTQZPqcnIY4IL4l7zQ/hRRuZo1zEvHy5C/ytLdltSutelwuJvkoUTDOsrYOGEaM/fbFdX2c7XwknUS+OEkd9GEfWwidYsrxwYprvOpa7JuibPXJK82HixG2TbZaLP/uqyqtgnEdqDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1iieuXUpopWj1Bxv3ptmCnc5v3uZuD8ZibJ+SYlxQg=;
 b=E7XxoEt3cGJ4bbhbieNPeiv0GcPJsvlhKg/W6mxcOT7Nhq2a5ccJZuzN8Mj8Fbi098n4QFCGTADX3cBnDdDSbWVUGqKIXtstPu8JTPolduyRxEiZj1vhfbUsP7R6x3zHmDT2CJ081NvVKIFm7h8x0F4xjue2l9LC9KZPFuTY3N3p7l+CND1U/SeXVhi0jLlP4iJgjY8EqsQzAZP9BI3DmjWLODQipKSLEzh6UF/q3snDavnouZ8a7BQPKzl71olRodBWJH51khuPVMwv9Sqr3FEs1pqkE6kgKafDIU31G/T5Bvk0eplU299VhMNJOAxQcOOaPsyjvhldP7mQcx/gpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1iieuXUpopWj1Bxv3ptmCnc5v3uZuD8ZibJ+SYlxQg=;
 b=Q57S27Mi9vdeWKlG3DLxM540s9ZdlMJ9gdJzctXkSzunee/xBpfbtToyoS8xxTSRwk/gi7l+/Sw0m+EoxnLVD/7ug4h8D90jqgsm/QF2EksoCJv1v5YGimBAgdPATnat4l8oTwTuU2yyjyYlGSJFpP91JfUMLcjdp49XYzFcuC66DxrbKe4Rn+GDpsMgtGcnJTPtV2gELCjCwJdPhA51Rnx7nwmecn3jdtWg7XjnFr1C+yr+5CHQ0Eb6PoEHWkijdM+rj609soRo4FWGPnXPGdu/zIq/2TpFqMYJL/JyKcDIs4UC9McHGiRBWNK9J3LwqTbkRafvZMM1Ewr+LzRDqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3309.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:13b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Thu, 15 Feb
 2024 07:21:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 07:21:41 +0000
Message-ID: <4fdc80a9-f3a0-4d5f-9da8-c6c497fb4d12@siemens.com>
Date: Thu, 15 Feb 2024 08:21:39 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] swupdate: Use prebuilt version on sid
Content-Language: en-US
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3309:EE_
X-MS-Office365-Filtering-Correlation-Id: 466fa5a5-8b37-482d-30a1-08dc2df6c186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ACspOzT0PG8Wapycdp7gHTVb5OJ6HEb1uh5fRFlX/CuQu8fbP+eFLzNXI/EU/1Llxk7xrAbmODf8Un+N1+ktHcL1B3Wh23hBe/3l1i/RzJ2FoTAvc7MdmHAhOYso73kQZIxgmZJGHID/890yBgRW4zWQuVE+3AD5KA852an8Ew4GXlEcDkeRU6MG35vlfyRgzdcYXZ53haNKB50MYBraG77sCWfpXmivaVs7GAdfAUoFGx0PJOCtdju3qSbIuJZZmu22+kMxzJHZ9/91b25mfHALZFo1DB0mgfTLl4gMTwx2xxdfRabJ51TM2yv9iHJZPVtWZTKH5Q9RumPW+Cz2R/p8jA2Jxz8XqHnMkvA0LD61FqLXJr0R/qjLAkjAdrH4wy6iWtsgfHAwwGSWeOMNKunvXBsN7mjcPc/LzShw9tb6vy4lXODAni6T4cXrIXtoRY6hCKoeKLjZTMS3LSxZZIEL+W8kD2nVm7AQ+xT19tbh5g1oCwacBA8lOQfHWAODQeCC4+MpnDP2qkRg/WtkE5kh7xEqTkpf0mq/4Gb8WXke1GlS4+VOuRoK+sHs53Qd
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(346002)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(31686004)(478600001)(6512007)(2616005)(41300700001)(107886003)(44832011)(2906002)(4326008)(5660300002)(4744005)(8936002)(6916009)(66556008)(66946007)(66476007)(8676002)(6506007)(6486002)(316002)(26005)(83380400001)(31696002)(38100700002)(36756003)(86362001)(82960400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NzVhZFdJVjZhdHNMbi9DTFdHRk1HRmV3dUxzSXpNRE4zOGtiT2NFN1BiWHNa?=
 =?utf-8?B?RGtPektSaUR4c2krbnFGR0o3bXJhNU1BcEdmTVBLSFpuRXZqc0hOUTI1UWpG?=
 =?utf-8?B?c1VVeXphNVp1ZkJyTWJrRTY2TkRRc2RZMFM2cHp6cjNLaVE0V2hHMUQ5bmlp?=
 =?utf-8?B?OFhxSmpGN2FuYmo4QnRSMWMrSEVnNlhrZjhLMWllb1ZoTkwxcm93L0kxWU5U?=
 =?utf-8?B?RHY4a3BkOGg3RVNJRTI0RkZxMkN5QzJ0QzF0Y3Q4VUdXS1NwVXB3WnFnMUhQ?=
 =?utf-8?B?WDdlNmg5ZVVpUS9veS9ReFJocEI0U2d5UkpHYVJoaUNLTDVxWVNEbFJsR0l6?=
 =?utf-8?B?K0U1VUFXZ0sxVmRhbzJ1OHlmMENvKzFWa2F0VzNqcW1UenI3T1FjWTJuU25y?=
 =?utf-8?B?eHA3T3E4VHBJVnEyRTFheFFzM0xMRjNNVmlXWUZ3c2ZBSWNKRFhxcXo5c29R?=
 =?utf-8?B?Yjg5WGN6R0NWN2ZsYTVxV2J5clBLb3B6aVFlaW1nVHpLeDZJdlN1bUdjMkJM?=
 =?utf-8?B?ZFpqYUxlWERid1ZPc0JGR0dSOWpEalpqMkp4NXRXK2tWeUtVRjRlWWVxMnp0?=
 =?utf-8?B?Z0d6MHRKM1JhWjBTZE9QR1RuWEUzTUVxYTczWUt3dUZhYm5TSDFpcG9USDEr?=
 =?utf-8?B?RkJGVUQ1K1NQR2Rxak9lcDMwRDFHRnM4ZkVYYkRmTFJCMlVkMTRsWDdpQWFv?=
 =?utf-8?B?TG4xL0UzVlY5OGxEUkF4STN4UjNocklJQmxTRlg3K1h2MUlWYXRPckcrenpk?=
 =?utf-8?B?M0JPaTFaS1o4NTE0Ry9HdnFsd0szYTRWenBUUnNnNGZCVGZnUFVLemhSaG9O?=
 =?utf-8?B?MWdkNWVkTTVKUEhwRWtyTThZT3hYWHFOQlY2cGpTRVVrUkM1WkZaZGtsM0ln?=
 =?utf-8?B?WDQ0OXhVMW1uUzBuUVNNYlBWQ2lSSjU4MVZKMk9Pd2NmdGFybldXSEZza2VJ?=
 =?utf-8?B?cFIwdkNRaVpnUlMwOXc0Y1RNa2JQUzQ0V0I0NG5SNGVRVURaUjgvQlFMeVpt?=
 =?utf-8?B?WDRqQSsvcGtHSUN3MkQzN1BaOWRvcVBiNHRtOUFXd2M0MENJVURmSk5KZHFs?=
 =?utf-8?B?dk0va3liT085cGdZTDRkNlR3YzFaYlFnMzFDNE9TdCtEeUdndllCeGdoUnFP?=
 =?utf-8?B?NlNoNjE2WUQ4cStOMEo3RXo5YjlwU1ZjS2FvNWlnVVU0bHFNdlByYnMyYlpT?=
 =?utf-8?B?R3U0ZXFIcEl1d1ppV2JsMmozZHliTlU1N1Z4YTRMaWNaSUVPQWZYcHNyaTI4?=
 =?utf-8?B?QytweU1mdE1ZVzMzN0RraHR6RldaSFlYMFppRzlhZC9mWU1kbFlBRXhMTkhm?=
 =?utf-8?B?QlYxdkhhTXlJblAxaWVKbllaazBWTjlRVlRqTmZ1bElqVndUNmgvTERxWkI2?=
 =?utf-8?B?NjlhRWxnM2FiT3pXMEdVUFpJQmlkMWJnMHlRZHgzS2RNN2hUM2xPclp2dFZB?=
 =?utf-8?B?TmdTbG5kSG9uYnJjK1BnVTNhSlV1UGhkdkRrWWVmdXdyb0hDMTNCYWx1UnFt?=
 =?utf-8?B?a3VacldIVkYyMFloWndqZi81Nnh0N2xhRmV5WWhuRXRKSEMrVkFsbElLdVV2?=
 =?utf-8?B?cWtGanNhdlVNbGlHdU5wNDAyRGptMFMxSVdKWHk1U2tBb3pNWjdtRkVZTUlU?=
 =?utf-8?B?RmJRUElmM29CM0ZLS1BvNUdLT0lpWFJSSHhFQmdTNWU2dmdxL3JOanFNRDB4?=
 =?utf-8?B?Q0VQTlEvT29WSkpTcWNpRVViN200OTFWWTZMd3JkcFRyYTBlR3ZBV0V3b1pS?=
 =?utf-8?B?d1plS3dwS2RTNlhsWEQxTldiUmkvZEF3aXlNZEhuQXkvQ2JoTVBBNHJUdkdn?=
 =?utf-8?B?ZHVDbTdRYzZLdHdpQm5jcFlmeEp0eVdDTDdnNWt6SytWZHppcVB5c3pEVk4w?=
 =?utf-8?B?T1RNNFliRE0zTUZXeURyYWpJbUU1ZjR6a0YvdGJ3NXZkWjBFbVBtNnJrWEVy?=
 =?utf-8?B?dWJxMFU4L1JRSFBzWXBSclovOVlROFlWdmFwR0h2NXg1Uko3d2dWU2Yrbnps?=
 =?utf-8?B?dkNIMGh6eVZJSDMyOEFleERWQ1pid3lBQzF1TVhteEQ4MDAxbzBydTE5Yjhx?=
 =?utf-8?B?ZTZXdDE3M1dtbmFGSmZ2NCtINGhNdkdYZVZ4QS9MMzNoUlBIalZlWVkvalQ5?=
 =?utf-8?B?MVpsY0QyMTFndXNhOHhYWVFwZWc4V1F0WUdOTUhyaVZzQmlRRmQzclUvR2Z2?=
 =?utf-8?B?dnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 466fa5a5-8b37-482d-30a1-08dc2df6c186
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 07:21:41.2758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6JFYfuXh+MNtnXdJvWWDdddUnjYicHf8AAus5m0h4bU3caQ9mz13kDy/PFePEUr29d2DZXy38mOINAnB6y92WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3309
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Feb 2024 07:21:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14987

From: Jan Kiszka <jan.kiszka@siemens.com>

Not only because cross-building swupdate for riscv64 is still broken,
but this also allows to check that the upcoming trixie package will be
usable as-is for us.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-core/images/swupdate.inc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index 4983f7c2..213b97f2 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -16,4 +16,7 @@ SWU_SIGNED ?= "1"
 
 IMAGE_INSTALL += " swupdate"
 
+IMAGE_INSTALL:remove:sid = "swupdate"
+IMAGE_PREINSTALL:append:sid = " swupdate"
+
 IMAGE_INSTALL += " swupdate-handler-roundrobin"
-- 
2.35.3

