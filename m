Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D40CC3063F
	for <webhook@archiver.kernel.org>; Mon,  3 Jul 2023 17:17:13 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.54])
 by mx.groups.io with SMTP id smtpd.web11.39004.1688404624826641006
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Jul 2023 10:17:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ZjWJaqSr;
 spf=pass (domain: siemens.com, ip: 40.107.8.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBNZTeXjI1xByEnQUX2LzqqGKa6ECpjzS6vPgSTWqBV8j6QdFjswswgAa8fj7fw6rdN+Usdgvn9xpfBmAHJFFCLBkLKXT/FBJlA8VTM5gJfQr0plPmZtu5YmyQbVhy9Arm7TFt9pJ6/+2sZJpahD5Sio7hFFhZXBCqbuyZXYoFor0lXgFCyvbS9OYD+cSTAHrfM1Waha9KN3U5er+iqX1vKJN+X9tW4FCphNhasYkAHr4BEZDJ4P8nwSBODH0AlSwyqEw80CaeBk/jIeOfkjE2WYITBjzE0E0/x6aM1VyQZnSyaLVX6Q4nzhvZqgyZdsXaSwsucg77NfneHi3GHZig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPdm3hhXeDF24N9umE8YsqUNmLJVzVtIizQ/vJ89kVs=;
 b=OqSVNuxbTDUjy9QmS11koXRm+/KiCf0PZFxt33ioiXq9bZAcyFb+eHwlJcH03cumnTZOBillxFDW23qF9hxApZOLIww1V6ChED6hFcbA914xHV7SzlDR+5DX1hSQ+koxHo2ixP2kqCbfU1HtsuH5bc4Ph5Y0MkDm1mX85xxJO8Wc7V3jeY6gmvp5tDBGtPYgCy92+p1CRtXYA9DFbFTdP3vte6jqYQjT5zeCbBiliHqgzdnsCd4c5f2OQj/46NxypFnRCh81v1umHZBgwjg+OzjaL8ovXQHJ6whIOVNSNFSrHDU3DrtWBut5yUSXAF65w8TM3kHQoEKbOfZb8L4LyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPdm3hhXeDF24N9umE8YsqUNmLJVzVtIizQ/vJ89kVs=;
 b=ZjWJaqSrl51uzXzl/bflGdtniRSXB6vAVBw2KuUbgM4mJQvP0ryW1gxuQKAZ4l2nmNwkut8jajAhb7Hkdt+ppqHgVAEvf4j5lls8ijn8IvkracFMKFdH9gatRDtrda8aWXW8Wfh+z3d3s6m6zGeq+CgZq3hmk782UC+bGTXzf0wsppAdJ/RgMcDmqw3Zfu/kmbCcVf0mFQp0HprVhLwD8Xsu8ZDowoxsg5TKSGT4wc4mRVf7ovSOJmh/yeiMbuSgktXLmv6r3xZeI9hlOw3iD6dGLJgR6jS4mVkay+MAunXB6qY84yWpbncJF8LVEhrZHlMyeqwcnXS7BXiVE3X1Rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB7933.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:481::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 17:17:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 17:17:01 +0000
Message-ID: <99667736-0756-1be0-38b2-3d4e05fd3877@siemens.com>
Date: Mon, 3 Jul 2023 19:16:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] Make CIP_IMAGE_OPTIONS reusable outside of
 isar-cip-core
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Cc: Srinuvasan A <srinuvasan.a@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ef9d1ff-457f-45a2-98b4-08db7be950ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	c2Mi/zn1A2ViuKjwVwg+cwJL3G15GJ6NHkulsf0B85JFC4K+ZHIEe6j4RoAMpls5TzOCCtDZJX0XxX2Urg0Lzsj5yDxX1B6wKCijriqw9jstBMcHo5W4mmFh+pE0lL858CX8BitICu/k+o7Galoij0oBqZ8WQK/WCMXI4bSx45rF90kmByyNLvRBNjEATZO9Ehz39zu+hWgEfspIltqCz0irYnxmMX2+ZZMPqDueKTb+aVEQJ6NYA1YD6qYm22Zkn3Pwu7TDnO0enwDffPIB/xG2YyHS0VrCQ347mphC4MftRDuNctDj43t8Iwx/yqNHvHnWFT0w2ZUnSXPR5lZmDk++tq0Ytw+YYDO+KAA0Pzw9XiZazqJJeK7NVR47eX4aSvHWQ+o5ERpSpRNOMrcOUcxufDj3nCbPMmRZD9k4heLg/QVuSZZ5oQNfxAvLPyYKPH7mTdOC8ftRjAKfc1aZHyEU3G5nkJxFTwBj1eYn8PTrADe/6ZS7Qc1BqTjD+OejHGLWZ5OSjiCWcgj/XyBebArqBMAMoprdM2oLLLx38HOWZUJpBGF8405iZfFS/3/roxPgXRm0I3CHa25Fbw8+dD1qYtLA8JKVbeMPjzBHr98CQmR2ipEs9SXmz0ONBZy9ld52hWrowRseNjIWrfpvUg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(451199021)(4326008)(316002)(31686004)(66556008)(66476007)(6916009)(66946007)(31696002)(6512007)(6506007)(26005)(86362001)(186003)(107886003)(83380400001)(82960400001)(2616005)(2906002)(6486002)(38100700002)(6666004)(44832011)(5660300002)(478600001)(8676002)(8936002)(41300700001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SUNyTGlZdGFJRlp6TmhXSWFLT241U1dob0JPV1Bja0VBaXNnMnJLY2pweUJy?=
 =?utf-8?B?SVVlRE4xeXd6M2h1dHg1bFlnMlpWaUVlUHNZMDNzM1BlZEdrL0Z4ZjhaMnFS?=
 =?utf-8?B?SHgzQktPTE9RbUJScEI1aXowN29wUlJ5eUdVc3VIZHZaOWVodDJvWGsrSGQ1?=
 =?utf-8?B?MU1OR2QwWlI3ZDFQQ2hJUURObzIxVjFHeGxCd0tORHRBRzRYVXMvVlB5UmJ0?=
 =?utf-8?B?aTlTRUJkT09qa0twZm1WR1NIZE1LYVErTkdmTEVuandWNTZ3MUxFa3JSVHAx?=
 =?utf-8?B?UE96bEYyM1U5cnNDWXBXTEI1eWtiK21BSGZ0OUhNcjFoSzJvTXlNbWFTLzR6?=
 =?utf-8?B?aEdxbUJ6T0x1UHdxU1lzM3UvNytMWUtKR0N2dGdIV1ZLNkZRZGhQbVBhY01Z?=
 =?utf-8?B?c2NLWktTL2hOWGVVU1hhK3JxTDRPODBxNHYrZEUxbkhwUERqUnVwcXR5dDN5?=
 =?utf-8?B?T3pYQ0U2TnR1L3hsUTVaTFNLRmNpaitHNUxsampXMUhDNlF4bHhmejBWKzZJ?=
 =?utf-8?B?TWpWNUtmUnhqZHRkUng2ZlJ4U2hZeWRLT3ZvN0dCSzBOcHEvY1JrSkh5QUdG?=
 =?utf-8?B?NU96UFgvbEhoaWdia1F6Sjc4R1o5OHd3YVBGMlFwdWM3M3A2QnlaMENkQkgz?=
 =?utf-8?B?YXdZbnRnLzl5N1dzTXJCTEpNc1ZqQXRKemJqN3dEb0h1WDlwNitoUEF5SWx5?=
 =?utf-8?B?TU9QZi9GT3cvNm5ENk5LUUZ0emFTUFJLRzZSVGdKaGwyMjArSi9CSVMvUjcx?=
 =?utf-8?B?N284K3kvUGZWOTZuVXo1Wkg4ZSswNFNNUGJvVGh2Zm5FZGY4V1dMV3J2MFNL?=
 =?utf-8?B?N0gvWVZpbk1xakFyMHJUZVZEcWpNemRwRWpRVzdlaFpXZElzVFA1czQ4WGZS?=
 =?utf-8?B?Q1JKYTJLUGZMN3p2VEJLK3NmTGl0MVFhdjQzR1g4d0tKdmJaQkJLc3ArTmps?=
 =?utf-8?B?QUc0VFllbDdMT0ZwdHVieWZQZE43MkozaG93U0YwUjlqbVVQOUIxSHRZRDc4?=
 =?utf-8?B?ZDZaSERtd3FFWDJUR0RRWXdqeFlFMnpZUm9abHlldUJMT3BiVUhTajNmbS9m?=
 =?utf-8?B?OVRDU2RETlBWc2J2cVU5Z3ZDaHJzOWwwdGJXblI0ZUYvM255Ty9xTHpYRlBx?=
 =?utf-8?B?dmNsMWU3VGtJazZ4THpCZnJLMFgwT25FOGt2NUw5U1U0bEZydWMxcm1zSFA3?=
 =?utf-8?B?Mk5wdGE1T1RSQzFJTVNtN0VqaFFlMS9NVUt4dkdwQUV6UjNlV01NRCtaWkoy?=
 =?utf-8?B?Y3NsZ1NvbEpsaDhWSHVLbkRWYzZ2d0tLZWtpWEpuek5aZW5oTU5nZzROalVs?=
 =?utf-8?B?c0tZeDlKRGFwNG9BZmljSTFKeTNZUytVdWF6R25kYW5ZbUZVa01uMGpSTE5s?=
 =?utf-8?B?ek5odkJsTndLc0F3Y0dwcXlUc1g4U0drcWJncWEzVXlKMGdVVkJtaDFuWU9u?=
 =?utf-8?B?bFhTQU5ma3VteFo2V0dRN3liMy8waEM0L3FKZnQydXc4RGNaSmN4OG1xQm1O?=
 =?utf-8?B?K1JORGpaSEtCemxBR0xpVit3czMvTGlsN3lPZHlvNGlMdEd2d2JzVlZpN1Mx?=
 =?utf-8?B?TW5YR3FZam9wMWVXRHJqbTRtUmJ0dzUzVWVlU3hyT2NsM3M1OEoxcmJlVkRP?=
 =?utf-8?B?c1d4OEpaZFB3MTR0TWZubnYvRHVGTmtrS01ZNWkrclNmYVJwbUowZmVnY25q?=
 =?utf-8?B?NkpwMHR6Uld5RGsrMGZpNU9CZVhITkUzS0ZTKzhjakk2dlZaN04zdUFsZ1pZ?=
 =?utf-8?B?UUs5eG5JOE5EdktIM09YWEc5SEM4bzJSUWVYT25pWnBEVE8yYjkxTFA1Tk8z?=
 =?utf-8?B?eUhBUm9OaFNIaFV5RTNYdDM0WEpDWUc2bUxYMmRZaUpURHlxTnB0NDFkSjJq?=
 =?utf-8?B?aGdHbXg4dEk1elg5TytmdEVJMUNZY2FIdkRtUVJ2WjZJUGRMZG03YkYzZHVu?=
 =?utf-8?B?Um53d3pRNnI5RXY0dVlFcTEwdjFrb0YyRjE2QkpoWk1ISmdoeG5LOFlvaHF5?=
 =?utf-8?B?eWF1TnJEbGl1YlRRaXY3ZEwzV29yVXBRUWFWRzVwcVY4TFlMRHkxTFdScnZ5?=
 =?utf-8?B?aXBrSWhGUkFUZi8zVjBxT3Vkdk9ZV1hublhkZ1lqY2ZuYkUxVFp5U0t1TSt0?=
 =?utf-8?B?Y096aGRtaEtESnJWK0pQaWVpUG03YW5ZM1RvVUpvUEtrbWMrWjBrRmdMV0Q0?=
 =?utf-8?B?YXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef9d1ff-457f-45a2-98b4-08db7be950ae
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 17:17:01.5468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cr161EfzWJuLW3AAPGTiQ0rCo8pKBdn7LGpwwCb0aNExSkLIRHx2vbT9ALmC2eURW1Z2il56ThB5tOTG0ZaiZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB7933
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Jul 2023 17:17:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12195

From: Jan Kiszka <jan.kiszka@siemens.com>

Prepend the needed recipe paths so that downstream layers can use kas
fragments and also include CIP_IMAGE_OPTIONS. Move the default
definition of CIP_IMAGE_OPTIONS to the common config file so that it
does not need to be set in downstream as well.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/distro/cip-core-common.inc       | 4 +++-
 kas/opt/ebg-swu.yml                   | 4 ++--
 kas/opt/swupdate.yml                  | 2 +-
 recipes-core/images/cip-core-image.bb | 1 -
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/conf/distro/cip-core-common.inc b/conf/distro/cip-core-common.inc
index 5cd1603e..5d3ce106 100644
--- a/conf/distro/cip-core-common.inc
+++ b/conf/distro/cip-core-common.inc
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019-2023
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -12,3 +12,5 @@
 KERNEL_NAME ?= "cip"
 
 WKS_FILE ?= "${MACHINE}.wks"
+
+CIP_IMAGE_OPTIONS ?= ""
diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
index 1c12ad56..c90142ba 100644
--- a/kas/opt/ebg-swu.yml
+++ b/kas/opt/ebg-swu.yml
@@ -20,12 +20,12 @@ local_conf_header:
     SWUPDATE_BOOTLOADER = "efibootguard"
     IMAGE_INSTALL:remove = "u-boot-script"
   ebg_swu_image_options: |
-    CIP_IMAGE_OPTIONS:append = " efibootguard.inc"
+    CIP_IMAGE_OPTIONS:append = " recipes-core/images/efibootguard.inc"
   initramfs: |
     INITRAMFS_INSTALL:append = " initramfs-abrootfs-hook"
   firmware-binaries: |
     # Add ovmf binaries for qemu
-    CIP_IMAGE_OPTIONS:append:qemu-amd64 = " deploy-ovmf.inc"
+    CIP_IMAGE_OPTIONS:append:qemu-amd64 = " recipes-core/images/deploy-ovmf.inc"
     # not needed for Debian 11 and later
     DISTRO_APT_SOURCES:append:qemu-amd64:buster = " conf/distro/debian-buster-backports.list"
     DISTRO_APT_PREFERENCES:append:qemu-amd64:buster = " conf/distro/preferences.ovmf-snakeoil.conf"
diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
index 1528b090..b0293cef 100644
--- a/kas/opt/swupdate.yml
+++ b/kas/opt/swupdate.yml
@@ -16,7 +16,7 @@ header:
 
 local_conf_header:
   image-option-swupdate: |
-    CIP_IMAGE_OPTIONS:append = " swupdate.inc"
+    CIP_IMAGE_OPTIONS:append = " recipes-core/images/swupdate.inc"
     OVERRIDES .= ":swupdate"
 
   wic-swu: |
diff --git a/recipes-core/images/cip-core-image.bb b/recipes-core/images/cip-core-image.bb
index 0ec72208..f7370c49 100644
--- a/recipes-core/images/cip-core-image.bb
+++ b/recipes-core/images/cip-core-image.bb
@@ -16,5 +16,4 @@ DESCRIPTION = "CIP Core image"
 
 IMAGE_INSTALL += "customizations"
 
-CIP_IMAGE_OPTIONS ?= ""
 require ${CIP_IMAGE_OPTIONS}
-- 
2.35.3

