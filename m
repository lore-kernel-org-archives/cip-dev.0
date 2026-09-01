Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FC9C61DD3
	for <webhook@archiver.kernel.org>; Tue,  1 Sep 2026 14:06:59 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.68])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8991.1788271611862717839
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Sep 2026 07:06:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=hOofIGtm;
 spf=pass (domain: siemens.com, ip: 52.101.72.68, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JhsxZU0sWfpAQ5hh0hfEVoLT3JHX1UxadK7RNzYvUj1ecscqq2pyR76KTdBJLIrhM1M830tzhXTPCbvVcaxnTOepvtMA7kbdG6yafdfgWpyIA4ARL1V6QsYIdpsoexMnlnj0V5oB5sjoc5nRZ5198Jo1yKaYKOUV7UA6bC5kM3eWke27XpwTW4yWOsDeyews1Y8gPvDmWAvd8yaVhUP8j40FGfbkWtiSuEpHiAcvOEeTNJcS9Bj2shjETaAMR+iF+ILXJlpCyZICNgUykFCyE75BroqQCkjmDwLZuvRjccKEGEe49HQ+1EBbpWCfKJChd+zOpF6elZEj/egP6dMgOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23WksMyQUFCv9FUWjKCHE7WFcWYPlQhHasrm4+wb9jA=;
 b=JInAyW+KZKTpMp9KE75DCpUGwgEGFfoUrNvE1kApbToDT71AksCMRPo9eJEfZJOe946M0oO03INlURzTPZjTMifjcdUtXxryX1sJADRc5t4sVJpOiyU4sZgc98OncwDy8eHwigYblwhbr7eJAPT3FGBor5X3hyF6SApEaCDptJBGzNBdT0rbHDaYHDOr5koQeNWOCk1fHd/F+cPGvgMBQUsRhjKM+JR5FPlY+EikOhUXCVtYl1OI2VTqagTAXxjyJmI5kVqakhVE8NtOo3pkojm+Y15jzOYkUakwZweOtOQOmU3NCUbgY+Y2yFyINxwL1Dcfz5S2hMVqyL9dHf31SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23WksMyQUFCv9FUWjKCHE7WFcWYPlQhHasrm4+wb9jA=;
 b=hOofIGtmvimMlojbhiIiAgxIawCEpR5E4xayr+MTD8FqVTPeAXfsSwSm6lomNiCYzlI3hUatqbc+rs7jgr8iW5oqUTqlmEOa7AniV7ZWpp0+Z0+KffltJVcspndHU5iqP8dROqW6WnZ7N/9LGmF2Wp1XVvlpKdoiGTHXRg+DSYaFwuCcF4C3i2OEckrcyCbqONnE/SCYwbnOgAdlzOnhxquZEh/vevarM92VWRvS7wN+8ixsSOlF8afaFoM85X0JUY+1WEkV5f2WfBSaT4+OTKhkNQqvOkauo3231EP9IG9UwV2yOu+7JKswUX/hLFp9tMWjNID06nSafaeb1qtvwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VE1PR10MB3965.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:16c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 14:06:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 14:06:46 +0000
Message-ID: <13c244fa-ffab-4950-acc6-c21126fd6eb2@siemens.com>
Date: Tue, 1 Sep 2026 16:06:45 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH v2] ci: Fix and improve lavacli container
Content-Language: en-US
Cc: Michael Adler <michael.adler@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0419.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VE1PR10MB3965:EE_
X-MS-Office365-Filtering-Correlation-Id: f51b7a69-86dd-4320-e552-08df08324244
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|56012099006|11063799006|10067099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	owfPZYqa7fV7FyhIvSHTSRvx3Q7Y4HhoTgofFqgd0C01ps7wA9ZlvaaF3ARvmsqapAHwJlgr4NZTPlHxAeZg3n3l+7CRlA6DUzTFdRcMvDHH9HrEx9U5s0CVcQXL4t9fsV6nm9wefkVwhtMKxt6uWU6m0cCjF4MXFHuHuxd3ql6/1YGnM/+g9xljVuhusRzDG+vyHKbmNyhX4ZjkYQ9775LxuDMDE+rXB4LP8GJKA3U1/HA1cMzv35NQlkcnGKlhBE3T68y7FX8uG+MSsINIlN0n2d4K1EL4AaKPpBZxPAV/vXOKgK9GAinHvzVkZjLa2LPQpifn+3kb6KK/BQLON6BLzdTjdQ8BYUEtKi1t9s3d5TNyhxu3ISEvbsiH/tKQsstjjG9NJGivjsr6fHR3EYwByg0HZYexxdtTlPmPh43MKfmi4zY7MyMVlyaX2SX1cDGuEMEujStFLWhUU37lU3/6yQCfk7SbLyAtaT+TyWen3dXonyJIJDJ0cmUslr4M9RlDhJNDGO3t48XPVVja2YlA0WHqUIxZLOVcLif6Ib7z+/mdpyhiYKzixKmh/rTpl5WLVpNJwiZVAxqA/gAHOdSqSa5MPwtDjuN3T/A9AYPL9qNZO2165z28tOUhoOTg
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(11063799006)(10067099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N1ltcElqQk5nckgwMVVZcmhOTjRUbzZ3aTJzNklKWE12L1ovVUQ5cUFRN2VM?=
 =?utf-8?B?bUdXMzlGYjEySnhVNjNkUndzamZFaXZjcm9EZXNLZUxRUWx2OHNTS0lNakwv?=
 =?utf-8?B?a1N4YmM2M1I1N2pGcTB3a3BPNlQzZjhuemhxbm9CWE9VTDdKSWZHL0phc2Ux?=
 =?utf-8?B?bFkzNTMvZG0yb1RMTC8yUnBEdlh0MUlvOU9hWGtnd1d1VEx5VUtuYVVDMkZy?=
 =?utf-8?B?Y1lxcXpGNGQwT0RnZDFrOUh3KzYrQm9TVnoxMVV1ems4MlZUYkJnWllvSWVM?=
 =?utf-8?B?UldqQkRvNHFNS3pZdTJYTVpoTTJjNEYyMEp3MnNtMlVKZXBxcWc4ZFVHQklh?=
 =?utf-8?B?b21NNnFpZnp0NnBFMDNFemE0clQ0RSsxUHo4TGJNZ1Zja01XS0swNUQ3VmMz?=
 =?utf-8?B?b3VNdWlDcnY5SkVVTHliOHNwUUFsblNJUnVsNzlnS2c4aHN6SkF6SjJsQmx0?=
 =?utf-8?B?MHNNek9KR29mTDZBTm1NTzBLalZwcmN5aGlDcTZPOGlzNStMdWNjMXZtcWZk?=
 =?utf-8?B?VkZLWGZoSnBFZ1MvbU93aGIvRzJKcjFsaHJCWk1ndzA4cUE1VzNFUmJseDBW?=
 =?utf-8?B?dW5aZys1QUp1ZkVQb3NyWVA2cW1UN0NhdFNRWVJVTUpEUUliek9vVjFaOW9l?=
 =?utf-8?B?ZGRoeEF6c3FEQWhzQ3NqVnljenVPOHk0bjM5aUdSWXAwL3liZXN0N20vWWha?=
 =?utf-8?B?dE0vazdVR2pRckRoL0R0N2hjQjJ1RDEvNmI5Q0xSOURackYybm8zVU5vWXkz?=
 =?utf-8?B?TmlEVldveTFjUkhnY01PcVErd2FCeGd3U1dZVEhqUktyYTE5cUlPakFtYWp4?=
 =?utf-8?B?OU9ZSDJ4bndMdEdrbUpnUEhUYnNSbXJMYW52UEdTbThoM2F4ZVV2YjdseklU?=
 =?utf-8?B?bGpCRkc5L3RvejMwZHRpNWdpdTRSVVpJSnFzRmlCYmhwRTFjTUFYVW5UMGpO?=
 =?utf-8?B?eHhFUTFlbnowdGQwMmlDL1lhWURTQ1N4bmdkUTRmdWRBc0NYRmpEemZGSWlK?=
 =?utf-8?B?OE44MWFQTTRaZk5HZ1ZLbkM2NmFEMG1mU0dmVXhWV3pabWdHNzdmYmw4alZh?=
 =?utf-8?B?alBxRFZ3ZDl1Q2JiUkNhREJNT3dMRXNjUDRHYnhSb2ppNFBWRXBuTDN6QWYw?=
 =?utf-8?B?UlNpdW92VTdCbDF2b1BVU1pnUy9vTXludWhNWTRBa2tZei80SjhCOU1uV255?=
 =?utf-8?B?ZklvcDFUVnNpTmZJbHJSTGU5Y0x5Vjl1eFIwSXdLNS9NWnhnRTI2czRnYW1P?=
 =?utf-8?B?bnFhbkJkVDZPT01hY3hlbWgrUGh1QWNmZGtHb1FaMC9mYXZOb3F4QTVrclNS?=
 =?utf-8?B?UmFwamM4VStwTDdRallicjdSa0JhRUoyUXY2NTFQTU9mZ2srVlRWczRydjhk?=
 =?utf-8?B?NktzOFZhY3FVZ1pIL21RV3B6aFpteVpWZnNpaDMvTnpBSHJ1eGRQY2crZitK?=
 =?utf-8?B?NTg0UWZEdC8zUXRxdXBqcE9DRDNnbFovR3FHM2QrNUlQdC80VjBZVStuL1RR?=
 =?utf-8?B?bjBFYmlCazV2VVl0RUUvL3VkaWRUTnJReUh1VGpXWDY5NjY2Ti9odEZKYWRZ?=
 =?utf-8?B?YTV1TGpaOGo3bW92MUlUdmlUOFk4R1Y3TkdhdjhrTVpTNTRzMElnc25BQjFz?=
 =?utf-8?B?QkRGZW1seVhBQngwcnhjekVJMnRzNVN1dTlaRUdQV0M2SWtZUHd0OUhkcVow?=
 =?utf-8?B?NTIwRU9meU0wblVRRHhQSGljWmhBRURZY2RNekNDQzZ4QVN4d1BWUXl5dVZy?=
 =?utf-8?B?TzB3M0dSaUNxMWNJWUZxRXB0bDJqa0NCUWRGbGtWNlJFSDZ1cm85cGIzYXVr?=
 =?utf-8?B?bktNeXpST1lIdUFDbmFuYVJJSFBwSzFzbEVmU21LSUJnaEVrdEUrNWdGV1F0?=
 =?utf-8?B?empOVDB4LzJYZy9JeG9QU0VkNy8rdGViMWRCemJtQ01MSEpleHRuUUZqUUpl?=
 =?utf-8?B?K0VpdUpZVjg5RnlLc1Z0NUlSUDU3RFNCSE4ydHNQakQxQVJnUXRWTk1Cb0dL?=
 =?utf-8?B?TXZOV29PckU2eGw3Vm9vM0FsNTl5L2EwdWwvaVY5T090Vzkrd2hiSGFzZlh3?=
 =?utf-8?B?Uk9DRGFoMUdLZnVLRWtURXdJVjFza0M0a1QwTmVXZFBLa3QzWnMwS3NEYTBS?=
 =?utf-8?B?RUtIblBickpRcjc5VzdrZ0pKM1V0bElNTEcxQlNqTlBDaG9BQTJjTlpxYldt?=
 =?utf-8?B?S1ViTThNOFNtdFpHTVhuSGlXK3pSeUc4Y1I3MWpsbmNwTDBnTUM0eFE5dEVK?=
 =?utf-8?B?ZzlVQmM5WXNpVWhQajhsRS90Wmtodnd4a2xuNWIyOXRhd3FZcXV6aTBoTmpB?=
 =?utf-8?B?Q25aR2FENVdEbVNlK3pYaGl2N3JGSDRZVzVCRGJ0N3o4SEZCNTl1UT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f51b7a69-86dd-4320-e552-08df08324244
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 14:06:46.4764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kt+5c7YNJOkw+9wq/1hxwUci1d9FgVn6aQRH7DyfoA/q792gZRocg4iomavFqq274UKqznoF3e/68vBGiy2wzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3965
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 01 Sep 2026 14:06:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24053

From: Jan Kiszka <jan.kiszka@siemens.com>

We have to set the STORAGE_DRIVER to vfs, now that we are running in an
unprivileged container, either large-rootless or small. As the latter is
enough for this task, downgrade.

While at it, update the buildah version to latest stable and harden the
security of password injection according to best practices.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - use small runner - now possibly thanks to Michael's work on it

 .gitlab-ci.yml | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 8dbe62d2..10f97843 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -934,11 +934,13 @@ include: '.reproducible-check-ci.yml'
 
 lavacli-container:
   stage: build
-  image: quay.io/buildah/stable:v1.41.4
+  image: quay.io/buildah/stable:v1.43.2
+  variables:
+    STORAGE_DRIVER: vfs
   tags:
-    - large-rootless
+    - small
   before_script:
-    - buildah login -u $CI_REGISTRY_USER --password $CI_REGISTRY_PASSWORD $CI_REGISTRY
+    - echo $CI_REGISTRY_PASSWORD | buildah login -u $CI_REGISTRY_USER --password-stdin $CI_REGISTRY
   script:
     - buildah build -f scripts/Dockerfile.lavacli -t $CI_REGISTRY_IMAGE/lavacli .
     - buildah push $CI_REGISTRY_IMAGE/lavacli
-- 
2.47.3

