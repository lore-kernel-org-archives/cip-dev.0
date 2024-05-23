Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEB2C25B75
	for <webhook@archiver.kernel.org>; Thu, 23 May 2024 06:56:09 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.42])
 by mx.groups.io with SMTP id smtpd.web11.10983.1716447365788374359
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 May 2024 23:56:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=h+aDosK6;
 spf=pass (domain: siemens.com, ip: 40.107.22.42, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJWDt2RQwQ4XK0QYJcU/R1VnGFUWZZBx/sf/Afw0NmIeQ7ls0w+rkh0FDbtIcwdzXd9eIDGWCPIMw5na0I7dd1CY7zNQv6YZVyYHN6vLhG2Rpp42R1h9v+Wx0A5GVFWEKY6IUrM0kILejsQUb4JKnOQMKmv5jJ3xu432zU6ui1Kg6dBAFGmGRcY5Rh1JnHLYhct8dJe4Lf+VXZYAisV4G6p7ihbWol2TBlXrlaqnlBLUaessC+m7Z1K8AqjIyjzFwVDGj23jmvvud3ConeqCqvg1vmw4+y36PfYZhxrrjHfBQ/rhbSaDV5LM8hOqe0dZix8X6GQqeKUEZaGBgUWFCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UaLXd0HH/71XVxyD0hubHvqjxVbgo6SmuxogVY4o5bw=;
 b=LZSWP+KpOpaSrB47QeAo9nRGNUC7sKj2LPYWhC7AFOr/rneCy/SBYmNJWKsV91x8ZM1saRdM/pD9zKpOs+pIIzoDpdgztQhHKtO8ebcJ3ilnsWmCQmnj2dVGEd9XJhcKpmSYNs/49GT1yDMHhZOHVdwmvRK2XeEW15hPb5N1WZUf2ST/jqPyv5mz1JL+BWsw4FNiRwexnzTfrA4lvaSNvVQzoiGLjBCLSuoUg57H6f4K5qr1X1J7NOJdg1yycuOFQGL8c1Vi6ewQAXFzQGYo8wW9WxVB0nNjNO4Ytb354zjAB2tnlLQya3BOSlK2Z3Sk8iA4MXC2seFTlmpKjNAuPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UaLXd0HH/71XVxyD0hubHvqjxVbgo6SmuxogVY4o5bw=;
 b=h+aDosK6sXppVYxiig9f+gz4DJw58sYP5qx1kFmCTZ7nFFechXirAvaMK2KAqpGyqnghkgJvSOLS4xfoznC/lRnBAsdnzrSaE93Gic74J1AEAjzc9eYQv5NjWJjJBvciNXCARrfgTi7AR9CGtf1thPyILt1A4xvAmzY6whvIeHtlDReovdL9NUi+A0Q81erTlSBxnSlOBlyyC5NFud75xcwjz5wGCu7H0+O/xCewTiKezaZg7+qzn4xdP/SfacFjLSqIaZ+CHoNRl4fE9+z4awfrfljXrnOKZr3ZaxdHR6sJcdKUYlbooZsvt3BCvDsVCmaKvc1LEEzgfMg/+0CU6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB5794.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:61::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.40; Thu, 23 May
 2024 06:56:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7587.035; Thu, 23 May 2024
 06:56:02 +0000
Message-ID: <08635a42-49e9-4b68-b94e-1de8107195c8@siemens.com>
Date: Thu, 23 May 2024 08:56:00 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] ci: Drop obsolete setting from
 reproducible-check
Content-Language: en-US
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB5794:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fdd2e9a-f9fd-4b75-c1b5-08dc7af56902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?K0gzcy9NRHBOUHhVVWlWMFNVQXdVb0N3bUlZaWt3QmZsTjRGMWZwSFdMV2Ey?=
 =?utf-8?B?Q1JXOGo2amRBcmQwaC9mRklYTnZ0NFYvc1RrS21BVVRTLzBnTmd5S2tDdWx3?=
 =?utf-8?B?R2ZaL29reStMVFY4WlRXcHFIMkRDeFJ4Wi96bHhTYnVXRnNzMFY2MWxSYXpO?=
 =?utf-8?B?TlUxQjFJWm1XNitJbEV2UUlEUTVhN2oyQWFBdHUxaDM3a1dhN1IrLzF2bUw1?=
 =?utf-8?B?WGxsSGhlUWxQM0NSc1ZZK3BsbjBaK2hIUzU0ZWNHWVFxakZWU3IwU1ZJMTRH?=
 =?utf-8?B?K3lNUFljVXpZaEhkSGwvNmJ0eTNFL2xGQ0hDS1owTE9GYjBBQUMrQ2ZGdXYr?=
 =?utf-8?B?T0hJVTVjMzd0ZW1ZeWM5SERZeDZ2Vm9KVFNKa1lIZFF4ZHBOeXBhUWxIcmRz?=
 =?utf-8?B?Tjl5UHRNbUhLWm5qN0YxTlFZNWJRbW5aN1VEOUE4RDhKMnkxZW05VVZBbDNo?=
 =?utf-8?B?Z0FEVDFlbVp1eUVLbVFHZWQrMk5ScHRLL29yRTRTQXBMZTJkQ3N4M3pBWkU0?=
 =?utf-8?B?SDlkQ0xWV3hteDcyQWlhNXdQbHdFNjhTN3hEd3gzK2g3OTVUWjZkSHpvaTdw?=
 =?utf-8?B?ZExvSkp4L09oUW4zbC8vMzBPZUE5djRkMW9uay9NN2FKSm1uRjdOeDVtbUw3?=
 =?utf-8?B?QWpPcUI1ZTM0MmErK05PZHljdmk0RWxnZ0lPQjRRcEZqWTQybnVXQmlLbDhu?=
 =?utf-8?B?VWtwdGhmODNWdzBsOW9zeDhTR043Skhrbi9nRmMwUjZwc1FkbXFDVjYrUDVt?=
 =?utf-8?B?YUN3SFdmVmUxRkZkZTVpeGY5aVNCc1JiZnB0NEU0N1dCbnhycGtIdHZoeEY0?=
 =?utf-8?B?Zkw1ZDByRzFhcUNaOUZvV2RoOHI0em9zUnA0TUR6aHdjeHF0RXlzQmREMTJC?=
 =?utf-8?B?K3lzSmlJekR1Y1Q1S0Y5TVBnY0RrRVd4ZVpMTjcwRHBwRjRWVThXOUwzTkFz?=
 =?utf-8?B?dFU1RlpnZE1rMGZLSGRMclpNYjhuMW15Y01QU0lXWDFYZjFZQkFmWVZBWHll?=
 =?utf-8?B?VnVadW1tWDBmaTBtSXBnNWpPazhnTDZqdkhzUXdyT2w3akw5YVJsME9vbFNt?=
 =?utf-8?B?S3dlSTM3cFptdDd2Q1EwNWkzQWFUU3pDK1dsMm4rMVdXQk51NitUV2dCSUFP?=
 =?utf-8?B?cXFwallsakNjeEVlYlY3ckhNUUVLdVlOTUFzbDRlaXAyeUhHcGNVWHdCN0JD?=
 =?utf-8?B?RTVPSndETC85VzA4OXRxblM5a1gycjByTHRvYzJ4UUtPTEZhNHZLeEUvYnVr?=
 =?utf-8?B?WEdoMC9sR0IzdGpPeCswb094QnMxSnNiRjNROFczeHUyNkwxWmwzdWlMN2pU?=
 =?utf-8?B?RlFCNE5ZeFVRUFBVNE1WRHFTVStJdjVnYWRmSmlmclpvYmFyZEpxR3VnU3dv?=
 =?utf-8?B?WlZjbHRQYStpWVFpeEFocTZtSUdxYktRMzhzcXIzSmpJSGhGendVUSttUnlh?=
 =?utf-8?B?ZHl0VHI1NlNYaGg4eTMrWGpxRmNoU2g0dXVUb3kyNzJTVWtQMTdIUHptRjZL?=
 =?utf-8?B?MkI1bmpoRGFTR094dzJ4Vk1EQUNiTVg4azRKNXRWYzZrK0dKNTc0RW0xek94?=
 =?utf-8?B?SUJhaVN6MnhvcHZVVEZuWCthbUFLVmo3U1JLRng0a0lubUVqaUJnSkpkelNk?=
 =?utf-8?B?eCtQYks0VkZiY09CeDJkWmVNK1ArTGdHWGV0UmtxaFU5SGZZK2h2V01ReEpI?=
 =?utf-8?B?eStMOEZRRjJweDR4aHpVc3ljaWtJdmd5OG1jUlZRVmhqZnNJSEt3eEd3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VGZkNzNadlZVUXB1QWNWanppWWVHTWxxUnA5bDJCS0lycVBHNU1qUFQ4ejEr?=
 =?utf-8?B?NDVFdHU4eFJPTzYzeWtrVi9iSDZJak1KNWRXRDJjdWpCNCthMEVoSkZGQWVY?=
 =?utf-8?B?RkthbVJ3enpzQmV6RmtzN3AvYU5OQVcxTlF1Ti9yaGtzN0VhK1FpMkt4Mmg2?=
 =?utf-8?B?dDJDNDJpN1ovV3BwU3FQYXhnZ0VEaVo4L1dmRm1hYlZQdmxTOFlaVGxuQ2pT?=
 =?utf-8?B?ZVBWNkhLSW5RQ1h3Z0RPVTA1Rk1vaXBEbUE2WUllRnpvbnplTTB1a0FpRmJn?=
 =?utf-8?B?S2pSZkFvNGlOTHJURGhoT1AyWm9GZGp1UGpUcUo1TFNJM0tFbW5vR25pWHNz?=
 =?utf-8?B?K1JTSmJtTThqWExXYTNkUDNzc2hpbnQwVXM3S0xyU0wyczBDVklVTTYzMXhB?=
 =?utf-8?B?aHMwU09vMEhIeXV0QVpXdUp1eDNMVHVDUFlhUitRQ2psdXkreGdwT3ZMaFdm?=
 =?utf-8?B?RlNwSG9DZG93dnZCRUkrTDRvZmFkYmtaZy9Xd24vYWIxb01sQzlQRC92MVpn?=
 =?utf-8?B?ZXBhSWViT2FHY0ZTck1pMlhHNjRWTjVBRjFtWDZEY2pJWjRBNXppb2ZIam5M?=
 =?utf-8?B?N0JDK3BwUkNwUUg4N2ZlU1cvSHFqQmpCQUZOMFJZR2hNb3ZETEZ6dVgwbEor?=
 =?utf-8?B?OTlMZldaK3hJVDBxWjZZcnJuWGpQUG5FakY5TXdWNTJYeVVjVFh3eG5TQlBo?=
 =?utf-8?B?MHFzS0llbFpaZk1IM2ljNFIzL3ZtazNJYk12MVlWMnZ6NTJHWllzem5ML1RO?=
 =?utf-8?B?d2didk1Qa1haQ2V6aXZvVFlITmxFWlRIYUtZQjlkUTN0YzdtN05KUnB1TEd6?=
 =?utf-8?B?YTl0dXFnSityVXhxL01Ua2FkRUR5T3JWYWFHcHNqT2xnMVh0RVhYUGpLWE1T?=
 =?utf-8?B?TUUzNlJLdjJXUktLaWl3aGt0TjU3R0RGQ0RVUEVtNUlSTUtuK2FMYnFPLy9u?=
 =?utf-8?B?d0wyTzg3akNtTUtMR2ZoT1hvdURHbWwrWTNDM0VlM21vZE1pNDhkcEhscUZI?=
 =?utf-8?B?d0VmS3hYM2VGSVpwRHE5MUloSHhCbkIzQjNtNUp3bTZyNkhobDEwSkF4b2tv?=
 =?utf-8?B?MTlvVVh0RlhReUFPTUFTQXdEZ2ZuU3FvOGdtbGszY1plaCsweC9zUVpRdC8r?=
 =?utf-8?B?a1huNjNkWEJ3eU1penlNQUxwL09NaG1RM2RqSjh6SzVUeVZvaWZjNTZPZnM4?=
 =?utf-8?B?ZVBrcWJvTllSa0hNVVpFek14cS9MTFNQd2JXOUYreDEwTGFjNS9sZCtlQ2NG?=
 =?utf-8?B?ZytMRnIzZVd4cGJmSkFpT1hQWFJJemk2djlLcnplU1N0TzcxNkxlVjRqdEdn?=
 =?utf-8?B?SkFmZjdsNkVLeDhjNG9RT05zSm9nd010eStKaExJcVlsdCsydXVSTmhpWnVK?=
 =?utf-8?B?Vjc2bjY1KzdSU1ZIYlUxNVFCV1VFRnQ3ZkNxYjk1VTFha0hQQVZhaFJ0VXpR?=
 =?utf-8?B?dUdobnZpZXZFcnVFVWpkWVdNUlduMDNZSnhsb1RyOU4wMFNPWTVRc0NLQjVY?=
 =?utf-8?B?NUNuaU00RHBGMXFYWHpxdHkydjNSNXN5U2JBZDkvOUsvdzFFSFdBZ01QeXBy?=
 =?utf-8?B?WFVSWU45dFIrQjJITVhrdGxaWWg4b09VUzlESXBlUjhzRXZTaFRONzZlMkZ4?=
 =?utf-8?B?UzhyVGJ0L3Z4Y003Q0hLVkNKWFhXa2JWdU5ORGNZNTFYcnBOZFUvRjd3cW5m?=
 =?utf-8?B?RVV3Y3dmb2V0YnZkLzk4bDAwVW03VWlNWWZCMnVVZ0dpanMxTnNRbTBLS0Rj?=
 =?utf-8?B?a3pQWWo5TnZIMjJKcHJaRjc0WTBpNEpsWHBpQXhtNmpJcUkxZ3FTaGVHV3dm?=
 =?utf-8?B?M0JUVUpUdDlEOTFKQ2RVTG5xV0d4dWl6SnVFWkpaQ0FDSjZid095c0dMQlRm?=
 =?utf-8?B?RTR3WXZidGFGMHBJdVRIVTV4My9YNnp6T2lJMFI1YXZzdUo3Q2s2UWxCN0pJ?=
 =?utf-8?B?dFlJdng4T0pRNXpudG9XNkRoR2lrYng2UXdEMlBCMVcwKzhJWWdSTjQwZzM0?=
 =?utf-8?B?VTRxdnVyRERWSjdDbHY1VnNURDY0Zk9JckVKZ0N3aXdYRFgyRy9qWmYxVWc3?=
 =?utf-8?B?aTEzSVFuR1JaVmRRMGt0VUNoMTArQXVSSFRydEpWUkFTVEFkcjJhNGxaeTJw?=
 =?utf-8?Q?SyDkEwGVLcuIdLuXsMe8zkJmX?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fdd2e9a-f9fd-4b75-c1b5-08dc7af56902
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 06:56:02.8161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZC8jXILqeHVIf/t3WM58GoyXxNaDAq/b0yDeeY3O932TgRlcjVihaiO3YoOdZOQ4qh/Tr5CE7FXVStVva6YIUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5794
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 May 2024 06:56:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15927

From: Jan Kiszka <jan.kiszka@siemens.com>

We no longer use tarballs for the comparison but now work against the
partitions.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .reproducible-check-ci.yml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
index aadbd42f..cd518724 100644
--- a/.reproducible-check-ci.yml
+++ b/.reproducible-check-ci.yml
@@ -13,11 +13,8 @@
 .repro-build:
   variables:
     use_rt: disable
-    wic_targz: enable
-    targz: disable
     deploy: disable
     deploy_kernelci: disable
-    artifact_suffix: ".tar.gz"
     base_yaml: "kas-cip.yml:kas/board/${target}.yml:kas/opt/reproducible.yml"
     release: bookworm
     # This target include base + swupdate + secureboot + security
-- 
2.43.0

