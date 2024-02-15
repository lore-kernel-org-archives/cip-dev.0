Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7B7C48BEB
	for <webhook@archiver.kernel.org>; Thu, 15 Feb 2024 07:29:15 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.42])
 by mx.groups.io with SMTP id smtpd.web11.9266.1707982153629367779
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Feb 2024 23:29:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=F2bacBvy;
 spf=pass (domain: siemens.com, ip: 40.107.21.42, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOcifjHFDx1EdrM1qHf51uHddFDZi/fvDYJ3cQlngQp3tTbfCju2SKd9U82+nW/x6rHBn1a7CRxn50GQEA4t43FXlKE2PvG6enngT85RhYsnFSrI1RA15g/Jzv4ajXHLAs0F1Phbi3CiPHXsqXlRcFufm0bFIHwS7wUlNYFRnCsSrdLzeRcJWHKXlBuFAyDDL4gOzXPNeLqDkUpwoB+U8Jzr0sBeYscfd9p/rSvbJLqddYzThcSmd86RmNJa9JRm9JeNTNB+QWtUUQiUkxMJLnrlFienrqIUbBZ9TfFbrR6KPRNUYrXy/uSXCN7DgeR2onjOztPh91PrTgZRXTkuyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXLn34+uOVQj8eDUxtVLp7vjMLM2gYsh3kc0fo3Xyzc=;
 b=gMDHKX+Vn3klwV3cVH35NdJuXCC1a/Dh0G+uelYPUaOgccH4mDudwUyA+xg+iEEN5F05vEXYCJ2geQfyj6KTRAT+j4aye2SARmk07dC3NSEX88hlFdiwq2ACD0+O2Uq2HFMhGf4fcpX2aa0MUAxHPyX5BcC8CgjyHOt/4J1HM/vQf3LKveDPB/ubjU/gNu3XsxHW0sYHlqJuq3DJ3mDfs4yCK27dekc10iDlmrgxLo9II9rUnOYI8ieme+DQ8Ee3EfjOsAQMtb/m+f1LuqW9TK3zIp7VLPUSm18h/7gs3A92vgYJeJTZieE2xSRyCMscfOI4gHGt6UIG+542hOL8Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXLn34+uOVQj8eDUxtVLp7vjMLM2gYsh3kc0fo3Xyzc=;
 b=F2bacBvyC0rEppoCMnP5obESoQ8uCYYiHdqMaGHFl5jTGe5z/LSiLPm4OyyZ7YVPDi/PpDBXBaEm0ldRmr/fXDccjlgvfJlsxk5sWoF0qtdmCWtg397mSz9YXF3rb3lCqHEg92KxEJDJMojePLo3P6ory0oQJhU4ZNtFpSQOoNz8V8hR+Sofoimm4N5qzEG9TBrVbiaiJIBGwTXxh5HiM+e+/cQ6yLVfQVNvJCBN1SnatuIGQ/JFuAvm8oqEfBLjRK1BFsODW6Cqq5nx3NLP4YSY2TSnizEnmYfKSk3VTu4OqKJFDr5VtazHvM2wVD6HGXkAFH9KfPHfpZ8EDh43Eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6875.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:464::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Thu, 15 Feb
 2024 07:29:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 07:29:09 +0000
Message-ID: <05cf8378-99d5-4e0f-a4a9-762a3ec4cf9b@siemens.com>
Date: Thu, 15 Feb 2024 08:29:07 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] ci: Reorder rules to ensure they are all
 evaluated
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0429.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: 03551bd5-9e68-4e68-dc4d-08dc2df7ccdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	lthFbBpghByJ/5+6wExjNtJ2IqPV+6wWhqup241FLYOBqrATfd/Ku81Qr+vAhIIM9RPo/NL0N7XCy/36bBhhLpda2FjX47Qam1NxD8t7hoKiUqSKDYPz2k4ETfXV43DGXtocknMrsErrQc3sLFTy2+eqBYYQXPGilzUbSTlKxVmxsBQd4SToHhSiCOHhBAMzSEyYEDol9nBIKyOOr1nHZR64oUysbctiMPzos96rsgwUEzuPtoQZOwDUm1YEWnIYE8zrvOdp5bwr3YRYl8pRIqJYVuSGeCnCLuh71M7C6NMkRyzLgPRZPoL6X3qZWNXsJfLIb/aZBvEdF3iMR1uAagdJ9tiDZDOe84H5SmlVrWb4GCm1VqZ84rvWJHR4pMmF5V1xHvdFVpAbAW19coArJ3qB7pyapeYNtyG1hwuwuFBAjpzNdOTdcb2yirPc4z5BmrdJZ/NR4kHRIZNSf531wycjyqT2kqLh5ChKeILu6vx9eTBqici7AMYCWGimgU57CwId8THDLm/O4ejSNscPsra417IYW/Tf1S9TYhsP1Nlq5t3gtdgI6mLuJ1FrlmF8
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(31686004)(82960400001)(86362001)(26005)(66476007)(66556008)(36756003)(31696002)(38100700002)(83380400001)(41300700001)(316002)(2906002)(44832011)(5660300002)(6916009)(8936002)(4744005)(8676002)(66946007)(2616005)(6486002)(6506007)(6512007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MFdTSmhBVEZGNjJ6ZncyZEhJNVVCQ3lPZE8yblA4RkpZZndkZE05NUlJb1hV?=
 =?utf-8?B?SVFMNW92YmxPMUQ3blZwREpKTkFSTnQwamEvMmtwOHhUOXJyMTg1V3hiLzdK?=
 =?utf-8?B?cWpDNG1RSzdPdVROVGRWVzRjb0JHeHFYeFIrTFRuYnRVT3A4RVdCU0hTek1L?=
 =?utf-8?B?OExtaklIOFNWd0ZYQkhISUVhRGxJNUhaMjVVVTd5VzZ3MnBBNHVBTmZuS0V5?=
 =?utf-8?B?N0F1b0RMblF3MytlbDhtMVJXcm9iQU1FS1hDd2dub2ZYK3Z0UnBxK0hCazJ4?=
 =?utf-8?B?TnBTU0ZFZXExbnJ1MHYzc0k5NmxrVXNPZkU0N1hwSkd5bmlKK2NoZFRDYmlo?=
 =?utf-8?B?bWpLNURmdEZJL3ptUTRvUk5YVWpZY1hDVENuR2JYQnJqL0ZCNEVaV0s3QVZo?=
 =?utf-8?B?MzJWUU9UcS9KZ0t2ZjE1akR5VEk5MTdNdU0xcDdOSnQ1UDI2d0tkSUNhUVdl?=
 =?utf-8?B?ak45T0FkRVQyTXBoWTJOemxnUTVRSnNHWlIzd05kejBOQjZOUWZJNm9RZjdE?=
 =?utf-8?B?M0p0bWtqbTNhKzZiVXFGZE9ZMDltV1hFQmRWTURmb0NFcDNDenRvMVV6R2NW?=
 =?utf-8?B?VjVkVkNqaVNHVzhncFk4eDhFRTBXZnFpY1ZWSlUxZ2Njbk9IRTNrc1JnTFEz?=
 =?utf-8?B?b1Z2ZTRoamFDRS85Z3F0aDhYQ0pqbGlmVjg2NWtXckZlcEdtdWlkdkxRTVha?=
 =?utf-8?B?cm9ZMVFkQ0hSSHN4N25VVUcvQkFsM1cwcUFIMW5hN1RmYXQ4QVFoTFhqelkw?=
 =?utf-8?B?RGNRMmtEVHBIU2Y5RmVIK210V09NRk9VNVNQbEdvNXA5VmVkZEk4aWNjMkNi?=
 =?utf-8?B?MHRkMmtvNlJBdmNHdXRXTktwNS9JdU51STBNSGFlbm8wMU4weUZEVCtKUzla?=
 =?utf-8?B?L2o2aGdZbEh3bVoxR3NTeGs3TkkzY2ZraEdpTktMRVhjeVEvQ1h1TGZwRWVZ?=
 =?utf-8?B?Znd4aFlJUlNKRHFmQ3ZDZ0hYYzExWkdHcnE5c2I5UFFmY25odmo0MVBQSVJB?=
 =?utf-8?B?cHdVd1FqOTIvTVVPRkN3WTFDRXA2ajQzMEhibmZEOC9yY0pCUFZsR3ppeWdq?=
 =?utf-8?B?QngrSGNEMDFrZHlxS2d0d0VDTXN1YzVCcWNycVQ4YWRSSjlmYndIdUlsN1dE?=
 =?utf-8?B?cG5heDZsL1VWbnNUZWoxVTdFcG1sT1cwa29MNjhMWVdPU01NUHY5OFhSbEpw?=
 =?utf-8?B?aTlzdDlYeVc4cjRXS2dCYjZ3R3A3QUF4NncxWkZPTUtwL3hsOGtxK0lSU0dQ?=
 =?utf-8?B?OVFHSzFROWlOK0Jhc3hQdFE4VGE4d3FvV3BYNndPSThJZ0h5REdJcC9CRWJK?=
 =?utf-8?B?Y1VBT00vYkhYbnR2d3dtY1hMdlpNL3FLcWt6QTZsTStZV2RyRFU4bnBDNWJ1?=
 =?utf-8?B?VkxPbS9nSGZwZE96Vk9BTXBha29Rd2FoRkFEMGRHbVEwQW5JMDdDenlXRU1O?=
 =?utf-8?B?alZPbkN6clA3cVBqWFhSRUhOTzVINWQwU3p5V0kxc254WjgxNzRFS3Fjbms3?=
 =?utf-8?B?SzArZllZazBXNVNqWU1NTnlIbXN5aGFHZ3lzOGcxWmZrRE5kNFQ2OWpkczRm?=
 =?utf-8?B?QnNzUENtK2UvZVN0OGdiZUtyTjc0cnBkU2MvelJTZjZlOGpMYndyQWk5RWZI?=
 =?utf-8?B?a0xydndMTisydHdONlJVNGV0ZU1LbDc0enhQSWJQYy9Uc1Z4NWM0N3BkZG5B?=
 =?utf-8?B?TjZ6SmtqTzFXd1NVeHhjczlMa3VMalBCSDRTcU9sclE4UDN2aGFZN213V20z?=
 =?utf-8?B?K0dhcG9WWFdVVjBjUEJFYitORmw2VUdkZk56eG9rWHhTZ2lsTlRLZDhiU3kw?=
 =?utf-8?B?dlNJcnV2N091QTNsdjdTNEVvTytsWG42SnROMWh6NzZNQUhrSDVLR2s3TWxk?=
 =?utf-8?B?L3FhejZES0R4eUVBbkI3WDZaN1l6bkp4SzhyZTdvTll6aStMK3VwemMzS29V?=
 =?utf-8?B?R1plM01BREVkS1BwUTNucHhUV3JYK3dtN0Z5bnExRUh0ZTAyaXFQbFVzeDBX?=
 =?utf-8?B?V2Z3dmx1NDdkcDlEQjh3dk5VV296bmxtTGdTWG13bTdHZkdyTVNiWTlCcmpV?=
 =?utf-8?B?TzhteEM3WkpVNjllUHdlMkFjVmp5U0RiRHNFY0dkZVRvR2hGWnZmZlhCNW9N?=
 =?utf-8?B?bWQ4blpqTW9ZZVdOM3o1S2kvUXBDdDVGb3BpQzJ5UU9TR1FlRmRWK0hMOWd4?=
 =?utf-8?B?clE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03551bd5-9e68-4e68-dc4d-08dc2df7ccdf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 07:29:09.8129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R9zitlLerObchSqSWG0/ZGshd6f9w9USeMgk8FWWmsd0ytRbPGdh7MM2Zh5DzNKEyPHbxxB3Su1yewVijUOSKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6875
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Feb 2024 07:29:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14989

From: Jan Kiszka <jan.kiszka@siemens.com>

Evaluation happens in the listed order, so the branch test was masking
the other rules so far.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 4f87ec37..9c3ee0f5 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -44,11 +44,11 @@ default:
 .build_base:
   stage: build
   rules:
-    - if: $CI_COMMIT_BRANCH != "master"
     - if: $CI_COMMIT_TAG
       when: never
     - if: $CI_PIPELINE_SOURCE == "schedule"
       when: never
+    - if: $CI_COMMIT_BRANCH != "master"
   tags:
     - large
   variables:
-- 
2.35.3

