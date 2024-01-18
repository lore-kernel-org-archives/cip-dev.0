Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB79C47DB7
	for <webhook@archiver.kernel.org>; Thu, 18 Jan 2024 18:57:51 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.42])
 by mx.groups.io with SMTP id smtpd.web11.1491.1705604269603244987
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Jan 2024 10:57:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=gDdETOhJ;
 spf=pass (domain: siemens.com, ip: 40.107.104.42, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JoW4ec5KdcSnPgFl0IrxcuMNBUkNs7RKhXpff+iMwMoGSVHWvY+CVOfr88x0ifNeZX2MTMnClUlZ10IU3z2GqQ6Iu5WJgu5B0c2PSPZYzXAaU5GuqZGSCgT8uiIJYME4suXu9uOc7G2kQnFbyqZ/3zQLJuVT4SsXGOvFWvjVPgUXQfR3sQtp+j2AbWO7benN3YnJSifCkXcCXpgkpS8OLnrhQGEMRqepg5cfh7ebIBDQ5QyILKpyLogj8rD+4A0p/Gu+6B1+iiEhsGQC39H7+eo5pLEvkAADD6xRO+r/J2iJO91braxTcqz4H0grOhfH39VbykJKLjHVVUmUx1coOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivk7XaRxjJ9Vzz8ddWbB7tnnPEsxSrBVs9BZID1MGgo=;
 b=YzfJjBZjskLXlZHWgvqpWfxaBUmGwp2ScMwFKaNuDmaWWmdjKiQEJ6kIwKkFgTJhZBjoeZu1i6pl0Xjk5Sfsrw5gA88B1s5cp1pYSXWyIbwplRKcHWMqBcuoO2gEIjR4AbbE2GUSs/wcZSZZ8EI6+wUk11WI4lCz9vLTMQOb51bOd0LgrR3+nK9aru+Z2qw5u/1v4TuFR1GPGk6NchxfI5yIloTS/hUMKqv4x3B9V7z1n1NsxcabhXNOxwndUwO00+fKQMZIgKSQqxI+9WGiMMUasIvJmw5rX2hNACyV0+dSRnk2CUeWNgmppuYg2v77cKrT1shQqCRepo7b8EaKtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivk7XaRxjJ9Vzz8ddWbB7tnnPEsxSrBVs9BZID1MGgo=;
 b=gDdETOhJKKmxokJoA241BwdFR+2LR25AexeDANpnn5EaIVJDwwmnFulSiTT9i71rI5fPHxrOKluXfKIIzY+fmlD2yVQ+ISqOWWXKIfRMbBme9vDCCW27V4YOIgbfpd7VjXxBbm9f1cuURXxcw/XiP56LwEn2t1miETecj5ei06L+KMSpoXy6T2PZzeGwPZc8I1Uqa4DhOMnY9huoRm9mcuyhPuC5H1pZc0YEn8dfkICXno7g5ALLwyhq9ouzqk1Ttt2xWGCA6U2f+if4fagjjRcMDFLOvlCSuRrY5/HtUQIVIFT9Rj6+yvvN76v4PvJhgQKyZZSurpJ5lmTWfj4akQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3907.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:178::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 18:57:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 18:57:46 +0000
Message-ID: <4c3c0db9-d5c5-46d9-b45b-edcd5093bc67@siemens.com>
Date: Thu, 18 Jan 2024 19:57:44 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] ci: Reduce build runs
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0164.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3907:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a3ac610-a82e-4991-fba9-08dc18575bd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ElD6Cjkl8IIoa5haLbARnwSadEyC80lFKi33oGWHxfljTzXyoBCSFzzolOvpnH2vvoYNIdcWeHydHF1C/nL26aoO9O3ybR/X14MecVa4BKEwJ+BY+nwdMmLjA3Z3uwqzaOrqsYl9pP+s8WvNgfFNkJrOveVYD7l1DRHRe8CebPViMZn0A9aEBvjEb+dq+ojQr7LU9z6ILlP/0oMOETOHUUO+OkW1Lalr9gay9XVZ7ijHqvYPbK0O9fP9lh2WCbTQYsq/uu2SKHO4cLZIOlQ9ms0CaXbmqfVYS+0ZWtbGesMZHTgnlGYuFjYhwwHXaYTDPXnkqzm0CQ6U/KJ4TRCkijoIDGGsJ6IpgH2Df5pI8NVEIyafDtxcluTTHEi0sqz2LpB7WsCFxYMVaHBnG1CHsjfPiYGFMtZ3p7huypiC6qgtAAqWAEaOZs0Bzm79qVmk5gPWVaA3CZLi+PJltRHh/45izSXWrjxZCXKgZQ8D2M6ggihHS4LHRQPyGEXtG6xcYk34QvCtWfKnbBSAxn8vDKGXu1XyHXuoy3X0aBu0v/M3Do6qsoyfCjId1BvN5b2nLpAX7fan32IgnmFJcapKPk2cjlLy5hJZ9dTaxPXFLd5WKMNooehr7uDODQgTEQ7TXa3EpPVkGwP9D4HsfsyPLw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39860400002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(8676002)(8936002)(4744005)(38100700002)(36756003)(82960400001)(86362001)(2906002)(31696002)(41300700001)(44832011)(5660300002)(6506007)(478600001)(26005)(6486002)(83380400001)(2616005)(6916009)(66946007)(66556008)(316002)(66476007)(6512007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SFgzRWVSUFVXTW1xd0d4SnNNRTNOd2lUOUpxWGZJK0IzYitXcHZhQUFhT0N4?=
 =?utf-8?B?T3ExeHdnTzFNRnVZTXdqYVNUSDc0emVIcG1ZZ3JoVG1pMWFoNGh4MWVxMUo2?=
 =?utf-8?B?dzZ3WUIveitoZUpuNGxMeC9QVkdkaERMYmNDRlBjRVZMRkgyS1YvelQ0Snpn?=
 =?utf-8?B?NHkzRGZKeFlqNjBLTDNrUUdhWGp2UHlrSlhYTWRQSzd1UWVwUlRGRUxDZ0lv?=
 =?utf-8?B?RmFuTjdMOUZ0ZWRTZzhqTUkvcDNRc0xxdktmM0dWR004cWlnZGpGam41bWRs?=
 =?utf-8?B?Y1dEOGx2Y1hLWDZ0dGlnOEFoZjFIc3N1b1FUL1UzbXhTK1c1anFQNXRwZkZO?=
 =?utf-8?B?VEREUFpGZEkxSEFXRFFTTmw0bWpJRWp0emxSUWtRKzlSRFBIWFNSWGthbkdI?=
 =?utf-8?B?L0xIaGlUTnZLSXp5Y045Yjk3WVhkSGh0TEJoNVRNdGlWaHBwL1E2bVVtaVpy?=
 =?utf-8?B?Mkw2dWc0Y1kvS3dveVN6RXk4c1BJZmJ5TjB2RWhkNjI1aEJSMzNOLzZadi9J?=
 =?utf-8?B?TkxSdzB0ZURYYlBiZTFoVnNWRm56dDVhOUdhbXFMclBHcUljZzFTb2lnK09B?=
 =?utf-8?B?OHl4UHoxMnhOaElsVGlYbFZhQ0RhSGFuaHNhZWk0K0ZsVU8xc3FuUDFLK0ZW?=
 =?utf-8?B?M3pvODRMMkF0RTFMd2ZyZllESGxkMVhrdjgyT2I3U3BtNlAzMzlkQ0pWd0lx?=
 =?utf-8?B?L2R3VzdycFlSMktLVG1BQTQ2NHVoV1RUWTRrMmZOVXpXVUl2SDNFUDBNNHha?=
 =?utf-8?B?b3R2Q1F5NjlZS3Fwc2gwdEF5NUJpa29kVDEwVi85TGhoMFNlN0VNTnBzcGIv?=
 =?utf-8?B?andZM056elRRQW5XOThGZ3VuWFZzVE05Q1o4bVhaSjdPcGlSUVh2Z1BIUHdP?=
 =?utf-8?B?ZlJsSEhsL1hvdWRrcTlFenZtZTVOZjJ5UkRmeUN5TnlQVm5RMXd6SDg3Y3E0?=
 =?utf-8?B?U3R5MUpscGV4NDhtV1JCSTZjRzJNQmV3K0ozcGw3aVZITW9HbnhNMTJ3SmtE?=
 =?utf-8?B?RHlWdytEYXlUNVJjbi9IVzVZenlVa2xSbnRCdUJ2Q2RQcStPQXQ1NytHMld1?=
 =?utf-8?B?cUVTNjlkaGdBdXZRb2Y0ekJFMS9KS0xpM0lZV3RMdVZCUEg1b3hwbzlPOHNu?=
 =?utf-8?B?RVBNVnI5dnVXTXc4ODdSLzVwODRORGRvaEFhSmRNOTBTQ2ZicDNSRVAwQ3ZZ?=
 =?utf-8?B?b2FtOVIreTRYNzRzdnZVVStEYzdPMmFrbjdWcU9CZDJqaVgrbzFVM1cwYmd4?=
 =?utf-8?B?dG9LN1ZkYWI3NnFOUyt2S3FaZHozeGZTUHlsSnlQdWRtYnNmVzZTWE8vNnpj?=
 =?utf-8?B?VlJnM0VpMDJnT1l2ZDVIcWg3ZTFtMWJTSEYycjY3N2ovZ3lrbXRxTHo4cDBD?=
 =?utf-8?B?RnR1WDltaU1VZjk2TXVheHBZQnhZemhRL2xDQ2s4a0JtMGxKY0R6MnpzajBO?=
 =?utf-8?B?bWdBSVZ2WTdJcVkyMjFlWUdxNjBiOFY2UG5kNVFIN0I1UnVESEhLRkhPa2h2?=
 =?utf-8?B?SzFpdGNKcmxCUWxCelNTQWNXY3FsdjFsNUlyTTU3cVpVai9OZHREcllUb3lu?=
 =?utf-8?B?VzU1cnJ5VHFkbnlrdnJhc05NWmZqMXhjeURrSVhsQ0RJaHRHRUF6cUhqaUYr?=
 =?utf-8?B?TURJTEVGTXV6cDhqZ0oyUnVRa3BVek8xOVlBLzFuTzNNZ1gxU2RDOTJMdjFw?=
 =?utf-8?B?Qnl0cy93bTczUFBBQWhwUC96SWppL2QvR1dlTVRmcjJpVXdWUmZXK1VlaUY3?=
 =?utf-8?B?dEcyWUVuYzFvTTBnNjBVeFFaM29SSHVvamJqRy84VTJ2YzlQOXJhYmxMNGZI?=
 =?utf-8?B?M3lWd1B3M0x0R0pYblM0Ujh2RmJtSVNOQjFxMzhWUlVHeHkzNEFhOTdzQmNY?=
 =?utf-8?B?dm5NQ1ZSei9ZSFo2Z2U0c2dLcDBJbWphWjcrVGtNcERXK2FJTnlkZHN3S1po?=
 =?utf-8?B?YktyUlR1bmUyV2NhdjVhaklJYXZJVU5PRzJ6K2J3TEd6ZWN6S3gyZy9ud01o?=
 =?utf-8?B?L0krYlRLZUVnT0gzOVRRRk51L0xzQlhuQjZFR0ljemFleFVueGVEOGMyM1Ri?=
 =?utf-8?B?bnc5dWxCY0NPYTRLQ250Mi8veXpyeG5qMXAzc2U3L0pVUkNCT0V5VUlNWk10?=
 =?utf-8?B?YjhPT2RPTVYwT2dQZ0tUeTU0aHQ2aXVJV2FkdlM0bnpBTlVkZm8vMUVrcGRy?=
 =?utf-8?B?aVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3ac610-a82e-4991-fba9-08dc18575bd8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 18:57:46.3058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zo4P3sSDwsE4xYcoS6c5AbTYIm1zWpOE7VZyqsEmj26tLP0bT7mWsAC4HdlMCjlHTc7tMYVftWh3fGitoOl/ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3907
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Jan 2024 18:57:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14407

From: Jan Kiszka <jan.kiszka@siemens.com>

Under the assumption that ever revision in master and every tagged
revision has been covered by a run in next before, exclude those two
cases from build runs.

The exclusion of scheduled runs is just translated to rules:.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index ba2cdb9d..4f87ec37 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -43,8 +43,12 @@ default:
 
 .build_base:
   stage: build
-  except:
-    - schedules
+  rules:
+    - if: $CI_COMMIT_BRANCH != "master"
+    - if: $CI_COMMIT_TAG
+      when: never
+    - if: $CI_PIPELINE_SOURCE == "schedule"
+      when: never
   tags:
     - large
   variables:
-- 
2.35.3

