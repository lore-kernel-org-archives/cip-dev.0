Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA94C25B10
	for <webhook@archiver.kernel.org>; Fri, 10 May 2024 10:56:32 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.63])
 by mx.groups.io with SMTP id smtpd.web11.9830.1715338587326743079
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 May 2024 03:56:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=gBlRb3zc;
 spf=pass (domain: siemens.com, ip: 40.107.241.63, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgmHNBjvwHxYLwRNE4NfW199FvocpCXnNPtDoGbdfO0R4/ffNs32OCaYryLSNnSyXiWD8ADPMyCS79+0NW/szrmK+Q0tuEcaTnltHaiaYvJYJ/325A10vyYnQfReWJTAsiSvDLHF7AtKkYevjaOyonrCKpe+CcUgKHmGs0C/8fIaefuQV+RbECL1ExUruelUKcHgerv0t5ZJXwlSO4sKrYCQHVIcviWmyRKjvGJX6WZUR2Z/72zA2lUMkku8NxijlzAQ3YDFR8hZbnmVuFzHdnO8f7BeQ1dghAPdyHc63CQPhGCl6CU9q8SxnOc7u0nB79GAW8ZZQt1urr1F+wWyIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKjfJ2kutFWROPOzeHZLHicJPoCGjGOy6vrfOyXlLwY=;
 b=HEKv1mgGAVCkt2ea4TXXzHzS3ca2Lt+R0xV/D2faHuAbwoWXnGJf5WmOOP9sCPldZB786BEkm6ieJGD60Nk5KSMO08S6jJwM1UPYVjZqSVOuGoMd6Em7AG2aodi5YipwwtB8G+iTldrsE2yLEFok3JXPk9FX8gBSjoLiljm2YLhRltMzKX8/4Dg8vYL4+uC8jvLWoS/+9f0fbhrZt8mptzfjTIb+SUW2LDi0wHNJV2ShgOko8WIlpIAdxB8qZGR3+7WXNJCy7vXxCWpz+VmNQbZgkj7ygqloYJxkOlKvkcdBCRNlOlm3IDAznknGCeufn3Q3fX/1JWUcu5rcHxdzlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKjfJ2kutFWROPOzeHZLHicJPoCGjGOy6vrfOyXlLwY=;
 b=gBlRb3zcvQx23lYWIguQj+WrkO71gU/2BqiK/0+ADQSDiAAUBJueOZrcD1Hqck5xReaySrGSysmPEHVCadxoVVXjVDlM1dsxBQON8N+LWI9DEcwEA6oZ6CbPEUgAYQpl0rJABlCWYoxwnezbaQmTf5z4D4MpwSttGHxjLHEI0f7nSVQKXkZjNOGHkW5enGjIG+mWvkxli0oIMXrI3/GuckMHy1ZajUB65jXEg8CWiwzrqksNvZY0ETW4GpeWJ1POjzCjNQuXD/pHAp7kJIo+3DbfUkWJHlDnY03W1IZYHf7XaTAoW9hwjTH5Vou7AuedKHdjsICZaxOpv4cMAotPQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB8014.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:509::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Fri, 10 May
 2024 10:56:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 10:56:19 +0000
Message-ID: <f2e17351-31c8-49ed-99b9-b3a050e4a8e0@siemens.com>
Date: Fri, 10 May 2024 12:56:17 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] ci: Append reproducible.yml unconditionally
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0211.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fa5875a-e168-43a8-efbc-08dc70dfd263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ekgzaUpwUDE2SUNQdkhDUHZNR1l2bUhaNFMyOHdYWDV3R2I5SktjMG5FQ1JR?=
 =?utf-8?B?MldROU82S29yWjRhc3RPTW5Xek1LTDlFR1JzcENpZHduVHkybXB6akErcHJi?=
 =?utf-8?B?emNzN2pzaXIvSEVSa1lQK2l2UTg5UU00QmlwNG1YZytyVVMzc1ZENWU5SmYr?=
 =?utf-8?B?aXZWNHNoZ1AweUFWcE0vRDc4RlFUTU9TUVRNK3E1ckhrcHhxZkxsaERQMVR5?=
 =?utf-8?B?WFVGaFl2NzhmUmR5aC9BQWtwaFc4WXZQZlMwUkZ3S3I3eDlZMkczSjhuazRG?=
 =?utf-8?B?Sk5UR1BkV08vVzhMNXNoTktyS2sxMUxoQW9PdTlKb21oT3orclF6YlhkWStM?=
 =?utf-8?B?Nml1VjZWSnF6SGx4R1o3TUNzUXJnazhON1NkRFhlODBTb1FQeE9aZTFsN082?=
 =?utf-8?B?MkV6K0VnOXJHbnU4RWF5SlFWQ05lbTFLNzREWnZOc1NTSE9FNWc3dGN0SGFz?=
 =?utf-8?B?SkI3ckJMR2NkeE42M3RVNnpody9JR1lJZzlJZ05mVlJxTlY0UGwwMEJQNHhr?=
 =?utf-8?B?ZkcwS3BNa01rSGdpMnI1MVROY05wZkVFUlNON3dKUVcwRG5WQmdVelliWmJ2?=
 =?utf-8?B?WTlEWlZPMTFBbmxnYmFrYzBFM3RUU1FMYXN1RWIyeXBOOVVoeVpGUHgySU1u?=
 =?utf-8?B?cXFzODlwZjdVbzV6TkVkMUxoMm1wa3lXdUNHWVMrUVZ0V0NnTENRRzgxT2hm?=
 =?utf-8?B?eEJEV1RtbUo0WUhRRVExb2hJOURuRGtSSmdlNUZZWXdGNmJYTU42bGVGRm9l?=
 =?utf-8?B?YTA1cW9abnZNcVl4NzVGcU9mUmxRQ1ozbnhjODBSa1NNRk5jZEw3STRiWlZH?=
 =?utf-8?B?ZUh0bDZ6UXVGd2RDK29tWmx6akFLOGZ6a1ZvUGo5NlRreGVVMnpFQU5XdU8r?=
 =?utf-8?B?Y0VLTDc5YSszc3BINmw2SzBwR3ZuQWg5ZnlOUXY4Zm9TbWoyVVNCaDlrU012?=
 =?utf-8?B?QnIvY0FzeEZ5ZFBIVkhFaXdwVlI3aUx2aUxRRDFSNTlPUVB1ZGp0d0llYnIv?=
 =?utf-8?B?WnA2SUVZWU9PNXZsVFFyTEo1Vk81SENIeTVEWjMrd3V6S1lqRVJzM21ZUmpO?=
 =?utf-8?B?VWM3TnBTRFJhOGdZdHFYSXJSZGF6RTZCY203RHNmZWlSa3VCZ0RaSkpoanU5?=
 =?utf-8?B?aGs2WUt3dThScG5xakUzM0ExY2tqMXRKbkM2U1RDbVNSL2pnYVl5TERjSE96?=
 =?utf-8?B?bStXRkYvaGpBdkhTVkU0VFdpdnR6UkdNSkJMVHFYdGVpOWxpb1NUZ2NCQUdD?=
 =?utf-8?B?S2wzMHU3SXdaU244VWJBanF3RjFHdUIvQnEvdGZ6SHhQSXRWQWlia2hHczdF?=
 =?utf-8?B?OGwxMXVDSEVnUzhJaW5nakRVUUR6eUNtNzBzZEZwOTQ0UUY2MWNJeVM5U0ht?=
 =?utf-8?B?QkNsNlh3czVZYVNVU3ducUs1OVd2d2J0QitOeVc1Z2ZKSDRJMDhGeWZhbnVk?=
 =?utf-8?B?L2t3VzRsTWkzU1Z5MzRwV1VZaHBNeklQbjJiMGEwNEFTMnQ3SlVwK2QrYitW?=
 =?utf-8?B?dWRrN05FU2R2S2NQa3pmNjdQUVlrWFBpdU5aR0s2eGoycDhzSDluRVZpYlNz?=
 =?utf-8?B?OTJWQm5aR0tkVmJrZXpDYkhLZ3J4YUxLb3BwN01Ld1NDN1BpNFR2RnMwZmVs?=
 =?utf-8?B?dUhzZ1prTU1tSzFVSEt1NmRBT0ZRSXhwT2hOeEhvREtVVE9aYU9XY0kxZlU2?=
 =?utf-8?B?ajNWTFlyNmRQNEJ1Q3Mxa1FZeTFHZUFLN0ZEODc5UFdFdkI3SGhxZURBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L2dBWkprS3BzV2NSR2dyWFdwRHJyUlhQYmZ4MmJFbzJFcWJvOUdZTHp3UGtJ?=
 =?utf-8?B?VjZ6Nm10Q1JvV0Zla2UyMW40MGVvbHlleHRUUnJ3NE5uZ2NHdWRMNk1FeGkz?=
 =?utf-8?B?Zk5PaUswRGRUSnBOU1FIOFZnaHEwU25XQUxCR0g0RklObWdXOCtqVmJtSy9O?=
 =?utf-8?B?eGV6R2ppVGNUcVp0ZEhIbi9uMXMxRnRQMWsrZWZKc3FBVExMYXNBc3krMkly?=
 =?utf-8?B?UkppSnBSQ0tudUlwTFZFNEduM1NNTDl4N0xDeFE2YzdCRTJNSURnWHlRVE5T?=
 =?utf-8?B?bFA4WXF3SXVsUHI0V216cVZUK1hhbUIrMkxON25ubXFENC9mMytHNTVXU3ha?=
 =?utf-8?B?S2hYZjcvL1JLU3hrbWwzWlJBNmtBcDNHOHBXc2dudTh1YTN5RkhFclRUSmI5?=
 =?utf-8?B?UGhZL1RNeGpLdXZqQlJ5VEVWbnlZWWk1V0NhTHlKNEdUUEFPc29DQ1JwK3Jj?=
 =?utf-8?B?Z1BkUDN3MGdNaUVVdFdVc1RPYkprc0Y1eFR4UHRLZXU5VkhjWXM3L0lqZVp2?=
 =?utf-8?B?cUFxNHd2a0l3MEl5eGdzRGRCRWl4NkQyOXNKZlc5V0lPazNwTVdYbEx5Rkdu?=
 =?utf-8?B?M3JMY2VtTnR2VXhHOFMyVE1kY0ZFTUVCU2JZSUY3OWl2TUNWMDRSdzJyQm5x?=
 =?utf-8?B?Tk1udVhpdFBtVlpxUi8rR1pXSWxMU0VOOTN1ZXFrK05KYXYyWmJSR1RWaTlI?=
 =?utf-8?B?ZnQvcXg5eG12MWYvbW45OHdRcXNOMStHb2tQcGZZZUxCTEpjaThaa1NWYjNh?=
 =?utf-8?B?WmFBTld6WXVadkh1eXRPWlFEWmdPRGhOcUp3UmtTUUhxWG5XV0R4dEFyUWRr?=
 =?utf-8?B?NXg5Tms1ME1WWUsySUdXbFBLRS9tTnVhcWpNN2wzQUNWcVk4cWUwSW1Rd1Y3?=
 =?utf-8?B?MnhzbzZ1ZjJQOU82MVVrTUE4RkFIQ2phL3V1WVhyTGhPbW04amdxUGZHaXdM?=
 =?utf-8?B?YzRqK0NHSTVMZnozK3FFZGtHSDRoWVRhcVRqb3VGd0h3ZkRMZXZOcnlYZld6?=
 =?utf-8?B?WGlQZHc4MGtaVk04d2tUcDcvd3JtV2QzSEVwS2FseDZDdFNkbGxQQUNFMnpL?=
 =?utf-8?B?dFVJcTJTUldlb1l4V2dUNUNYUzl3emFMUDk3bzhDanNwNW9xVExPZGVSaEpy?=
 =?utf-8?B?YzBlSmNRY1lNQi81L3lIa3NZYlJ4dVdmL05xdEdMcEpJV0xkY0Y3d3VISCt6?=
 =?utf-8?B?eXBXaDFuRFR3clY2aWx2N09zWFlyZ1lEeExCZnUyNGp5MVNyUkN6bzQ4R2R2?=
 =?utf-8?B?UTFjQStwckFQbEEyQjlZbkp0V25uNG5FRXU4Slk4emhMNm5XbUJhWVFrbkRw?=
 =?utf-8?B?MmE3QjR2elk2RnFqTkoyOFMyeDNPSWRPZXRkUnpMRlQ3Z05lVENQV01SRkdB?=
 =?utf-8?B?ZWVJYWN6MW5hZnJyRTZvSnY0VHc3bjJibUhBVVA5UUQzNkNqSGZ4dEdKT3N5?=
 =?utf-8?B?cHN1bmlqVG9tK2NmWGFxTCtzeU9hRlVWWXFMMjNhYTFUN1BlTFZwRkhDaXZ4?=
 =?utf-8?B?WUpONEVHdHpnNy9jQ0VENjRGaHpSQkhjdkRFME4wZkpFbFRMT1VINU56ZEVP?=
 =?utf-8?B?V0Jpck1xb0FwS05vMVBLUXZXb3BVV2c5ajMyOHc0VU5PNURGb2RhUDVmNFVU?=
 =?utf-8?B?NmdXMGdKaUR5dVRWNG9rUlpEQW4vNXdvMXNDdHBqUkRqRitXMERRV2ZwczFq?=
 =?utf-8?B?VVBrTW5OZTFGVFV5YlkrVk9kcEgyK3doaTZmbnpSQ2FVVTRyS1JodHhrOFox?=
 =?utf-8?B?T3VCRWwwcGg3UTJGQUdSOVcvSVNocDZCa2pMc2UwUCtoWm5qMjI1THN5MUEv?=
 =?utf-8?B?NkVGVHcxZVlsdE1CRlpOS2lzcTlDM2dSKzJWRmF6a2tMVHFoZjM0VmlQWUxL?=
 =?utf-8?B?ZDlvajd1MDJ4UUcvNGM1YnpKNWxYeTRObytQeWxteUdBQnVNNEJ1VEMrM0J1?=
 =?utf-8?B?eDNqdmRLb3MrRGNjK3VlcmJSN3BGZlVmZDJJRVNlYU1ub0FIODEvWUpjanMx?=
 =?utf-8?B?bE5JdVR4SWpVTFdVb3BKV1hFZkdXRnB6bHIwVkMxZmZCa0JHNm5yemROdnd5?=
 =?utf-8?B?Tjhvb0NSV0NvNlJLYW1UR2FmWmdPZy8zc0lMMVZPajZDOW8zVHlvU1NrQUM5?=
 =?utf-8?B?TW4rQ0FBZ29vOWUraFBETHUxdDVvaFl0ci9GZ3pLYjlrRXlDeWxFNWpCRFlG?=
 =?utf-8?B?Vmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa5875a-e168-43a8-efbc-08dc70dfd263
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 10:56:19.0355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hXgabmZl3ZGJwypKEBYYzy4LmmopndXGxBEfTL7LI3kGbnJ9LZ0rvjlo1xRLXrU2f8C0lkPiqa/eGlETipmcSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB8014
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 May 2024 10:56:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15873

From: Jan Kiszka <jan.kiszka@siemens.com>

It's always available in our repo, and when it is no longer, we would
change this ci file in lock-step.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .reproducible-check-ci.yml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
index a2695c98..aadbd42f 100644
--- a/.reproducible-check-ci.yml
+++ b/.reproducible-check-ci.yml
@@ -18,7 +18,7 @@
     deploy: disable
     deploy_kernelci: disable
     artifact_suffix: ".tar.gz"
-    base_yaml: "kas-cip.yml:kas/board/${target}.yml"
+    base_yaml: "kas-cip.yml:kas/board/${target}.yml:kas/opt/reproducible.yml"
     release: bookworm
     # This target include base + swupdate + secureboot + security
     extension: security
@@ -28,7 +28,6 @@
   rules:
     - if: $CI_PIPELINE_SOURCE == "schedule" && $REPRODUCIBLE_BUILDS
   script:
-    - if [ -f kas/opt/reproducible.yml ]; then base_yaml="${base_yaml}:kas/opt/reproducible.yml"; fi
     # Build 1st time
     - !reference [.build_base, script]
     - mv build/tmp/deploy/images/${target} image1
-- 
2.35.3

