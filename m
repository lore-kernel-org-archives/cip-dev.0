Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F2DC41513
	for <webhook@archiver.kernel.org>; Fri, 10 May 2024 11:19:43 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.50])
 by mx.groups.io with SMTP id smtpd.web11.10137.1715339978680993538
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 May 2024 04:19:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=B74aFWzt;
 spf=pass (domain: siemens.com, ip: 40.107.6.50, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKTOhilB9xoWYV5sFlRN54M2luHz0U4vw/kFcw08kAuoWQnSBzPXCx8EmNuyC4Z4rAucagVXdFXMUb1kS/eYDt11Z5hfijaDLsPdMAnc+hN6EUwzwXZSrkdQd0IiTEWCGDEqaeRCtPxddeZ2lOc3w/LdG7zspkVVkpvR+ZzlFDd9er7O8CAhuCQUEmxXAO2P18j2+6oXfVG6PsApkRP2tvnCRnJVmKKhdEOFMhgcPdbGrvizw3xJOGf5DsJVWmH5++UNNJhyQgRLhqCbylblDiM9hMy935WzsMBYbzIl1LMjkz2uyV9r+57ghXg8mreNjAdMvddUFOnWWFTb5kJgnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZzaBikPVahQ9BK+RUlk4cpge+iqM7GU2hSIQQE1Ggo=;
 b=ImrSO7TsqSbtaQdvVspDbEYHjsm/Q+VIF2tBJbUq/fD1K+WbRmw4HN5Ik3MoS1JdX6+RACKvRwcDHIHdbEMqbM1yiDTzRbe9Dqrdp/Hmw71iGrKjOd5U+LKM5CLPevU3BjTvT7CDyh88uNaJbRpb4fta51lNDQjkfpTgNwHEgm+dVf9q4erqxBI3KWQ5w6Mm9VG6J4zh87OqnEl/6hMKjOrjlmVnJLJO9tH78yOAZclNk+B0hP0y2F84Vq6RPCP+zBqzpdbEZEedOn5U7bjqMLZMVX8PQXQsIpXMYFoJSSaJcxOBYSt3KRC50PYecArQvjgBtHjCfIJG8qBFwTLGiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZzaBikPVahQ9BK+RUlk4cpge+iqM7GU2hSIQQE1Ggo=;
 b=B74aFWztGsaLAMWjY5d3GK2w83glQ5RILuMlscxldcTXSTLnKiFLlc/KBpLRi0jGdhjQ9B7juvWhT1GJPTc3XLFwWpk5qdU7+QWdIwageQ25VuVjYlJAHoGz3FJIPj+Zo2EHA8EXeRaP1mwGWX0Dqj87lVmcIaaqMfBOtZ3qHmMKENlt3vCAuvU78kjzTqDuVfAlz3YRJ4lYrlFvzepugF36fXvIiVH858uJZXEiFYLobZ2kfNnDpLEDILxGrzw4Tbmr1jg9r4uF4I6GUANRcTCsZCfmhioqABCFepinV9wtdr0aKFbFBNax+vI5vqHw5m0qR/uHGrwDTO5uF3z08A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6140.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:79::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 11:19:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 11:19:35 +0000
Message-ID: <3f91291f-7e40-4060-b66a-90a135bb6015@siemens.com>
Date: Fri, 10 May 2024 13:19:33 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH v4] Update ISAR to latest version
Content-Language: en-US
Cc: Rakesh Kumar <kumar.rakesh@siemens.com>,
 "Moessbauer, Felix (T CED SES-DE)" <felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6140:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c63a24e-b982-4648-b6eb-08dc70e312bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OWIraXFUSTRMU3dzbHFYRDZaVzNhdldkaVYzVzFjMzM2U0FSNHV1MDVrYThh?=
 =?utf-8?B?UWU1TDFSampCdGVDWVYxTG1wbjRseEtuazRsM3RDSE1jL3FxNGwzK2FGczBN?=
 =?utf-8?B?Y1M4bmlpK1dTdUh6dWZ1SmwvRFgycnh1Y3FJVjAwYStpQ2tqV3FFWDNQRytQ?=
 =?utf-8?B?SkJDM0xPeEk1Qmpqa2dTUXlpVVVUdFYweElxTHY5Uk5zZ2FmcWtsWUVtNEth?=
 =?utf-8?B?TEw3NFI2Z0VQTXA3VG9aK0JNcWdqZEtQdGt5MnVTaEtDR1VaYVBmVFlObGU5?=
 =?utf-8?B?UkFEbmlDWHhkdjNIalZzT29OYjZNV2VwTUtUNTlyVldON3VJbkdQb0RWVGpM?=
 =?utf-8?B?ZXQ2MGlzdlMvNE1lUlJDbVJtU0tQY0EwK0Yybk9icUJCalZJQkZ2Tll4eDJW?=
 =?utf-8?B?Q1RsU0ZudVFPR0Uzd1k1c3BiSzBaS2hjc29GaktGRFJtY2EzSlFlL3dreldk?=
 =?utf-8?B?cTUvanpNUmxlUjN5WGVmT0REZ2hIZTFPd0dNcjRDbnBKbmVhOVRDRzVON3di?=
 =?utf-8?B?RVJaQWd4bGhXUkRzazMwY3BGdnh0cHZ6a2N6NXpJaXBwWDBHN0dyYWg5b3g0?=
 =?utf-8?B?NEFIK3Z2TC80ZStxdFZsdmVISVlTVy9Cdy9iS3NsL1R2QnJPQkc4ZE5wS2NF?=
 =?utf-8?B?UzE5NEwxeDBucXJoRFNyVmpyR01rRkx4WW1FdlpLOENmeGpOYnJKbUZ3ZGx4?=
 =?utf-8?B?K1N5UHFjSzNTaEpXOUhLWTNiQ1puS1NZeHVXaGtWQmRIdkJwdnRmaW1FeXZZ?=
 =?utf-8?B?VklUL1ZnNEpKUStOc3ZrUGt2emFoWlE0Tm8zenVyeXA1Ymd1UVBpbzA0MmdB?=
 =?utf-8?B?b0RxMTUzZ2RobWtvV2JnSU13MHR5cGs5Yy8rLzlrM1dDYk8xeGltN1FjeEtD?=
 =?utf-8?B?a3NCZERFN1crNVRTYXk3UG5mMEpoYldkSkZVOWs1RkgwaThLS25TdXdvdE1O?=
 =?utf-8?B?YW1Nb1ZsYzNWYlZxSXFOYlZnZkRyOTJFUWZ1d0hIVkpmMW41OHF2TDR0eURw?=
 =?utf-8?B?OHFtSkhlSFlBdmlaM092cTB4d0Vvenk1ejl1M3ZFL0ZVM2RDbGN2blRnUFVT?=
 =?utf-8?B?QXgvT2pxaXJhWHcwWlNvTitXVitRTHVqTU5mUWwyN3NhSk1ZT1h0ZlYrYU1U?=
 =?utf-8?B?ZTVHVStKU2xYRDJxY0lzRW1SUEZUdkJvT3NPYlcyRHhUYmRmN1JFdWh6STRW?=
 =?utf-8?B?NWFHUjVqVWJtVENMcW5uVlpIaXJ1TFNJZlF2VWlkRURldW5lY0EwNzdqdnhu?=
 =?utf-8?B?ZlBQWW1ZbUxRdFdscC9hbzdESnZuUDZkOExNalBYeTZUaExnc1FpblQ3ZE5M?=
 =?utf-8?B?WVhhZGRuRm1LeHhUTi9rVG5TNDV5SXNBSTRGM1FlVDVzMFZKbWxNZjdZa3A3?=
 =?utf-8?B?UVowTTF2Y3RDdHM4Z0MxdEMwdkhZWWpZK0VKR3hUamhGc1FiUURtZUJHa3Az?=
 =?utf-8?B?dFUwcGlJM3NiRkZvUlBtTm90ZEJiLzR5cmhMOEx3N0dPa3BlZ3FLeHc4ck43?=
 =?utf-8?B?UEdLVFVscWN4MW4ySHVqS2g3aWkvb2VQcEozUFp5M2hRRTN6bzlEck9OaTN3?=
 =?utf-8?B?dWp0c1ZLYWRFanNwQkRSSThzU3FpU0ZBd05aYUtUanpTZVBWTTF5QVBoS04z?=
 =?utf-8?Q?MO1SlSw7I1H3Q8TR8SItLiKQ6Jpka3wT9KdheXyCfPkI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SHNVZm81bndhWVN0bXh0MzVZZ1BFTFhFSEFYNnp2L0lqTWJEUXFDbk5JdDdU?=
 =?utf-8?B?czRIOGZqUVpRdFFQRXhkdDk2bk1VczlhUFVpeVFDK0R2d2pXbytKdFJ1dm9x?=
 =?utf-8?B?V01pZExJdktCRkVJWW4vZkRsUm9nV01ma0l1WWNTM2srSDlNb2lEdVU2cm9t?=
 =?utf-8?B?dzJyd1lHWW5DQWQwYVZQNWRxR3BMSHB6RUxRb0FsSkthTlhwdnJXM0QwVkQw?=
 =?utf-8?B?c21RWFc2d1pxZE1NVFB3UGd6WjBld1JWL1dIRStLcE4zM2d5RCthZFRKU1lk?=
 =?utf-8?B?ZitMeVd0RllQUnoyMytCZTl2T0gvK2htK2EwTFI3L25tQitvRTVSeG0ydmpx?=
 =?utf-8?B?Q1MxYnpFRVdqSEF1M1Q3WnR2WnlKc3ovSVhpbitJZUVHdzZEMnUwVzdEcFFj?=
 =?utf-8?B?SHhFQWdYc2U5QW82bGcyZXRjVnhCdml4NkRWbm5KbDNlLy9QR0lHVTBaaVVs?=
 =?utf-8?B?VGJlRVVXRDNIV0wwaHhPeDdHRW9jTk9yZk82NVhWd0x6eHpQaW5rUHBoR1cy?=
 =?utf-8?B?NlNMQmJWU1R2WWdjQ0NHVjBIQmRHdTNxU3Z2QjVSY2dJbm8rZnFNSC9KZzJY?=
 =?utf-8?B?T1VNN3duSVd1ZGZxYlB5OVE1Yng3RTRtQ2svYTJuM3dES0I5d2dsOWw0S0JF?=
 =?utf-8?B?cFJIVmwzNXVaYnY2MU0yOWZrZjJ2cEswV2dCOTh4SS85d2dPWHJGemcvQmlj?=
 =?utf-8?B?bU1rR1FSalh0c29SRC9tdFgxNWRJRmVxQ2ltRzBVZThWcm1sa3M0dFpwT1pW?=
 =?utf-8?B?SEc3SnBMT0tveXhQaDlKdDhpbGtKWU0yaWhKM3dGNktWam5vMXZuK3EyaGtB?=
 =?utf-8?B?V20xZVN1bkJLb0RBa1dSclFvUkgwaXVlT2VxYTU3dnUvNXpYcENvSkFTNlRn?=
 =?utf-8?B?MG9hY1M5TXY1VytjalloOTJOTVpOc3NnT0pLbFBVWG1rZTZZSUFnYi90c0Rq?=
 =?utf-8?B?c09qbEh3Qlp4eG9Xb1N3TlNYNmtock5PanFmYW9kWmxZZE1XTkpGRUtwenpO?=
 =?utf-8?B?dnp5S1dKK1l2d015dTRwMlZqOHlnbk9JdEZjQWpBd2NsdU1LK1JGU1R2czM2?=
 =?utf-8?B?N0hnaDlLZTdVcDlxa1cxUmlUenQ5TzRJUHVhdVN1TUViQWQ1a3l6VXIzL0d2?=
 =?utf-8?B?aW9nS1RRNkhMeUIzN3FxcXdIeE9jQjdSZTBHR2RwbzJXQ096Vk5jTm9aV3hk?=
 =?utf-8?B?Y0xVOVh3OWFDNEhSM3J5TlRPNmVTbkwvVm1veld0VzFWYlQyS2xiOGpxbUVr?=
 =?utf-8?B?VHg2TllUR09yVG1oYUxPQWNRQkcxNUc2akdlbzFySHRDb2UrUWdQSlZYTE5H?=
 =?utf-8?B?WGsvSDE4ZENBSjNqMG9SMThVdUdITnB5U0Njc1Y5OFQwR0lISmlPTkU4aTQ4?=
 =?utf-8?B?ZE4rOFlUUFlDMktydWdpV3JUK2RlZ1dGNGxzVTZ1VUtkRTBjeG9sVFRNVlZx?=
 =?utf-8?B?UzhYdnAydkdHUzc4ZUZIUlk0ZStPeEZOcHNYNmNGemJMTjBQbXl2MURkOTU0?=
 =?utf-8?B?OHhpenY2WmxZTnpOcHZNbnk1T05ZbDZuTjZZQWR0OXdhTHhzdWJPZGQrZjYw?=
 =?utf-8?B?YTdiVzNyRzk1VjZuZFp6bUs4QXFweTZFdTd0VERRd0Q4blQzZ295aEZrZzdM?=
 =?utf-8?B?RXZnU3NOZEFIMGZhL3VmZngrQVVPbmNtRWI3YlpiUElXa1VzdHROd1FqWW9I?=
 =?utf-8?B?dkkzZW0zeENxZW9lSW9zbVV4T1BrWVZqT2pLT0sydTBsb001WFVnVm0yTWhi?=
 =?utf-8?B?MjVFa0ZWWnlGT3I2ZTFHTHNDQUJsYk5HYTdJS1Bmb2s5NWgzVWJnRFNoMXpt?=
 =?utf-8?B?Zm9DQW1TMmpuRVdSQkZSTDU4NjZ4R3hjRFZUUEpVMkMwUThlT0xkSWNpWVBK?=
 =?utf-8?B?anRRVUFWTmJBdUVnTDF0ZTF1SmN1c09RbnZ4ZWd0R2ZCVTFzOFRWS2FidTZI?=
 =?utf-8?B?N0hweThHVEsrUkNOQXBSNFhmTGMzcUM1MkF3bHhobk13MkNibXdpT1RRbzV2?=
 =?utf-8?B?eE9XWWNaVmNvVFprd1NHd0ZWQU5JS2l2endKQ1VzdmNFYi9pUXFtSWVOYURs?=
 =?utf-8?B?YUUyNDhLQTRjNWhtT25TaXk0YkU0ajdZMlhNck9pcHU0TWpUZlAwejN3a2Jx?=
 =?utf-8?B?NXFaNDE0RVJTYmV4aU1ReVJCR3VWSW1BR3RObzU1MVhrWG8wSTdKVkhtTDNY?=
 =?utf-8?B?K0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c63a24e-b982-4648-b6eb-08dc70e312bb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 11:19:35.4834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 07+2RPgX37ve6LIHPBGcLliDnQQr6USiZlSYvCQKe4fhTRQJ90Png+4F7SilUlWBpwpgpjMrjeqQ0gIuT5ACJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6140
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 May 2024 11:19:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15874

From: Jan Kiszka <jan.kiszka@siemens.com>

This update requires to resolve duplicate "Provides:" statements in
secrets/certificates recipes (based on original patch by Rakesh Kumar).

We furthermore need to drop the now obsolete SOURCE_DATE_EPOCH variable
injection in squashfs.bbclass and define SOURCE_DATE_EPOCH_FALLBACK,
rather than SOURCE_DATE_EPOCH directly as this is now handled by isar
itself.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v4:
 - bump isar to include required fixes
 - fix DEBIAN_PROVIDES
 - address SOURCE_DATE_EPOCH changes

 classes/squashfs.bbclass                                    | 6 ------
 kas-cip.yml                                                 | 4 ++--
 .../secure-boot-secrets/secure-boot-secrets.inc             | 4 +---
 .../swupdate-certificates/swupdate-certificates-key.inc     | 4 +---
 .../swupdate-certificates/swupdate-certificates.inc         | 4 +---
 5 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/classes/squashfs.bbclass b/classes/squashfs.bbclass
index bf72133e..b39be0cd 100644
--- a/classes/squashfs.bbclass
+++ b/classes/squashfs.bbclass
@@ -31,12 +31,6 @@ SQUASHFS_MEMLIMIT ?= "${@int(get_free_mem() * 3/4)}"
 SQUASHFS_CREATION_LIMITS = "-mem ${SQUASHFS_MEMLIMIT} -processors ${SQUASHFS_THREADS}"
 
 python __anonymous() {
-    # Set file timestamps for reproducible builds
-    source_date_epoch = d.getVar('SOURCE_DATE_EPOCH')
-    if source_date_epoch:
-        args = " -fstime {time}".format(time=source_date_epoch)
-        d.appendVar('SQUASHFS_CREATION_ARGS', args)
-
     exclude_directories = d.getVar('SQUASHFS_EXCLUDE_DIRS').split()
     if len(exclude_directories) == 0:
         return
diff --git a/kas-cip.yml b/kas-cip.yml
index 2c3c8b0b..52e53061 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 9dc362cd7115074c0f60843e687ed89db5c9339a
+    commit: 3d863aad5e12c7bef382cb6fb3f1f5e18b236156
     layers:
       meta:
 
@@ -42,7 +42,7 @@ local_conf_header:
     USER_root[password] = "root"
     USER_root[flags] = "clear-text-password"
   source_epoch: |
-    SOURCE_DATE_EPOCH := "${@bb.process.run("git -C ${LAYERDIR_cip-core} log -1 --pretty=%ct | tr -d '\n'")[0]}"
+    SOURCE_DATE_EPOCH_FALLBACK := "${@bb.process.run("git -C ${LAYERDIR_cip-core} log -1 --pretty=%ct | tr -d '\n'")[0]}"
 
 env:
   DISTRO_APT_PREMIRRORS: ""
diff --git a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
index 2164b121..f11e93d2 100644
--- a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
+++ b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
@@ -14,6 +14,7 @@ inherit dpkg-raw
 DPKG_ARCH = "all"
 DEBIAN_MULTI_ARCH = "foreign"
 PROVIDES += "secure-boot-secrets"
+DEBIAN_PROVIDES = "secure-boot-secrets"
 
 SB_KEY ??= ""
 SB_CERT ??= ""
@@ -31,6 +32,3 @@ do_install() {
     install -m 0700 ${WORKDIR}/${SB_CERT} ${TARGET}/secure-boot.pem
 }
 
-do_prepare_build:append() {
-    echo "Provides: secure-boot-secrets" >> ${S}/debian/control
-}
diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
index 944c2dce..93cf255e 100644
--- a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
+++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
@@ -15,6 +15,7 @@ FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
 
 DPKG_ARCH = "all"
 PROVIDES += "swupdate-certificates-key"
+DEBIAN_PROVIDES = "swupdate-certificates-key"
 
 SWU_SIGN_KEY ??= ""
 SWU_SIGN_SCRIPT ??= "sign-swu-cms"
@@ -35,6 +36,3 @@ do_install() {
     install -m 0600 ${WORKDIR}/${SWU_SIGN_KEY} ${TARGET}/swupdate-sign.key
 }
 
-do_prepare_build:append() {
-    echo "Provides: swupdate-certificates-key" >> ${S}/debian/control
-}
diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
index dec9a836..2532de6d 100644
--- a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
+++ b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
@@ -16,6 +16,7 @@ FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
 DPKG_ARCH = "all"
 DEBIAN_MULTI_ARCH = "foreign"
 PROVIDES += "swupdate-certificates"
+DEBIAN_PROVIDES = "swupdate-certificates"
 
 SWU_SIGN_CERT ??= ""
 
@@ -30,6 +31,3 @@ do_install() {
     install -m 0700 ${WORKDIR}/${SWU_SIGN_CERT} ${TARGET}/swupdate-sign.crt
 }
 
-do_prepare_build:append() {
-    echo "Provides: swupdate-certificates" >> ${S}/debian/control
-}
-- 
2.35.3

