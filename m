Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6339CC4332F
	for <webhook@archiver.kernel.org>; Wed,  4 Jan 2023 13:58:13 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.89])
 by mx.groups.io with SMTP id smtpd.web10.12527.1672840687965876750
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Jan 2023 05:58:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=PS7Qqp78;
 spf=pass (domain: siemens.com, ip: 40.107.247.89, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJHvJTWyMTvTV1goYBeTYNmt6dWvrRZJtt7G37JVHlwlputv03hpPOw2ggfwU+prjOxvupL7ChjDUCdPFq0WDWJHaExlHm2u/N0gEX2JRu0r6RoSalZqwvAnIkCGmKNFMdZiBDKjOkapHidy2mfnH/DkTFe6E/D8ig70msZYQkFT5iyrmhD0j2S02ChyGUl9oHplINwQ/n6gz/wEaexsInbuYRgEqxfs30JRo+cpND1vDvH4Jtjk5QoBTHcrNw1w4HfSj0tmR5HTYcb1Z/9J/roLvNf5imwFwqxipBb4QnRG4aimYXMWeyrkWOo2Ci3yCQ5gJyPQbZugkIyFzM0n4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yeOJ7Y7f4xlaPpw4PiowYNhlKVhC67JTxQ7gbTt71t0=;
 b=LYjSJlCpVtx2x7L8rsgfQb3b68TqkXnNpKzdKAZtQoN3nK1DAo4SIeEGjIGgby2x3rNykg6CdKIDqBsAem17V/H1yKl+z3rX46cpW5lmpW42oLkjiP9GEDrrTswO2BGBK5OwO+w+rqhPf3krkn3U35JTxgmHyxWMv2CyZ/RyfauVo6zm6xo4yglq5tln4/hZfx0cZzOiUXRb3FF+WH0oFP66k7Akq8nyTmojoLVOKM8yxKWM+yYreW1w7FOKtzyTF3Vapaoc/w/9Qbz3gypCFGoqc2jojNDEPAzjY17jDTN4Ch0s9mvo7lI9r7Dp6Pf7vYzgjbza6GpRe+Iqq2nB5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yeOJ7Y7f4xlaPpw4PiowYNhlKVhC67JTxQ7gbTt71t0=;
 b=PS7Qqp78581bDZPQJEJyCEW/0ucVmxE060kHIqc2RPnQVZjOocj4CqSpw4nx6pOo0S60fDqab39aF2bbv2qghlC+zEPNdLzaqJRM3SF+JgNMlEuLe6wxkbN/aYEvShdQBhib9FGDwsoocqHzqvvbjRHfhBVQofEcxiRNFOjpnpzZ/2v1BGw3eHxDZ8SZxI/Ao9DM9KCUwC9eaFMRYdc5qepn79v+wwDPfZb/2uHFiFPbnbmV/TknDTRm+ohVNoWtB2TptXWPdmbPZiXBv2l2XyhLTlufI5C4+p8jIktuFuV1n141+lHF/GsZwCeuO/8lkXZcutSECs7dS/NyTPMnwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3804.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 13:58:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 13:58:05 +0000
Message-ID: <bf6f6eb3-371e-af77-0c9b-62be17b61082@siemens.com>
Date: Wed, 4 Jan 2023 14:58:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.19.269-cip88 and
 5.10.161-cip23
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3804:EE_
X-MS-Office365-Filtering-Correlation-Id: 7364363a-a1fe-4edb-b9c7-08daee5bb396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	trderSE0jl+owCp9OSKL2clNuPP5XjHuMLpUjwNnqbI+bWuCQOIVF38QgtcWtuSaNkHeoh1vH9VmDxwgr4FpdUV/A/YTTBVIcACKovTC4QZEAgkr3axDVBzS+xBXQUNaZwGIS10Vj400YUEvVhjvO64AqY0islnLHsDIl/Z7ToCWhHyrjXOo3Hk6hXgrdXMfvL4GBVUsNF+yg9bOu8XfuBFxZJWprCvxGkMMhGKCrAK6BBCguN6ErOkO64djZA2DJEmXCZPqtym6IKqBJqFeCA16TpwBGYfLXQGT4ytrC1ALHcvuK4iN3y7Pt2wgXDPd3vjVIzyK82XsS478V9TckJov0Jq0Yx6Iy/ebPl609Sonk19vYLWHOZYzECrv3DgjA8/7s3eX2cpYO/gDGkROulWj9yk3DDM1d6T5G/pXsf/l/3+S19RQezq8db+HsGqUVtaa3dUsE1PDTkP2CHcNh8CNfiak6kF+5HsXM+pK7iH8c5ZvuLGOph0KrhCk6iyeYG1RatOnWdSA1Fv47ouTQItNmSaS7eMP3il/4tvNiEj7yde9VyOHvQSQ8I/zzLyKTCxO/sWrSKmYEFUvC7zI28IuCBpP+UPU0Yu4DIWO6ttGMjhy2SRWTK1YQfTq451xwsrmK/4o3oQrEeEkjrcsIZWIcEVClkGl/34xKS5Xx5lE+ILlbRcfM6xv0/C0QFycUuzg6MsOZaV1gDQeM7OVW10qSux9h2mSRVABA6OUMHM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199015)(5660300002)(41300700001)(82960400001)(31686004)(38100700002)(8936002)(66946007)(8676002)(86362001)(66476007)(66556008)(83380400001)(2616005)(6506007)(44832011)(316002)(6486002)(6916009)(2906002)(26005)(36756003)(186003)(6512007)(6666004)(478600001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cmVKRUhRUWYvZ2NKMmJKVlE5UHZGZS84UGQ2elpOdm1WRUxxVlFBVStYc2Fv?=
 =?utf-8?B?azBLM1BZVHZnRTNzdDBmWEYyakZvYTdhWjlwdnN2aE9XZUQ2STQ2OHo3UVRK?=
 =?utf-8?B?bTlxeCtCRXQyV1NidTlNQm05QnNIdm5NOEJBU0pvcGJsWkloWXQyZ01kWThT?=
 =?utf-8?B?bzZKMmpZQ2VBTUl6N2lZNDJTVUF6dTB4Wm1xMmxFRWZPOVBwN3NxNVRWRGlO?=
 =?utf-8?B?VHVRL2JCUk9ZSXJMclAwdEx1RGoxaWZFeGJwTGJoV2tpVTZGRU14VzB0SWcv?=
 =?utf-8?B?dXZ2a0NvTjhzaDFZZUZIQUI1UXpYTlBPMEN2TjRmdDhjcHpzaHd5bThBU2RI?=
 =?utf-8?B?N0RPeVlET05aQ2p1SUJYNlBHYndCY1NZSGk2WldNK2hiVCtCM3RsK2sremE1?=
 =?utf-8?B?VWFsSGVrdWhVbGxzcUxhOWdYU25mT1JESmJBMWJQQnpYY3M2TGg1N2U4Z1pS?=
 =?utf-8?B?czVUQ2t4TjJoZU4wS3hrUTJ6ZzRXcE9ZVEl0T2ZSbTNQVjNXeFNzQ3pYclRR?=
 =?utf-8?B?OFZKMmJ4TVMzeHZrZVJaR3g1aTJWK2NWMHdSYVhIY29uUkJaemx1SzlNVGdt?=
 =?utf-8?B?VTdUaDRwOTVkaTBzZll1RTBwdnZKU0UxSTcrQkF0bnZJbnd1Y3VVck83ZXBM?=
 =?utf-8?B?TTVKQWNvcFRyWUhTUmtzaDFzd0dqSVQrNHBVUFQ4czRxSjcrQ1hXaFF5QWhQ?=
 =?utf-8?B?VWZ2SEFoNmlNR2JpQkJQZ3BDZXFNNVZNUW5PQXQ5aDljWHpHSUhLN2VxK2Jj?=
 =?utf-8?B?WXRpQWdkYWpTbmhya1owbE0zZkRqSGtpNVZzMzNwMXgzVkVFa2dMak4xZ1Qz?=
 =?utf-8?B?eUhaSmt0ekkwbmNxUzNacExSajY1Zk42NWMvOGRKcW1ON3NXSUlwN2J5YWRZ?=
 =?utf-8?B?d1YreTZrdkRJdVhHd3plTk1LM2JYOWoya0IweXU1SW1QcW4vVlpBdzFGbjJs?=
 =?utf-8?B?R0FwcS82clRxakpSN0UyV3BiQmxCVXBkUmcvWkRnM1NPMnBZdUZTTEg3bEhN?=
 =?utf-8?B?RXVMR2xSNGJ4anJlV3ltLytOeWIwZFJDQkV4ODRiblFVSFR3ZU9Pc1FyaG9j?=
 =?utf-8?B?SmFTczRtR25WZzQ1UmgyS2gvVlFpbzVIckpZanhVVDRmY0ZWLzJZNWhQd21l?=
 =?utf-8?B?QVBBWTVZZktnZk5scjQ0TUFibHR5eHFqczBCcUhkQ1V1V1R1TllEeEhpdUdV?=
 =?utf-8?B?REFYZHdrSUdwVGh4WXBXM1dYNDFxN2xnS0FGY3A5amEyeTNXU0kvR0k3ZUFI?=
 =?utf-8?B?ZEJ0cUZPY3JFTFdyck5KdW1NWnFBMkJpczVnbFJ1YTVIMS9EdUJNWmNRUjUy?=
 =?utf-8?B?ci95Wk5pVmxJdFhaUmF6RXF6a1FXSXRPeUFpTURTMWtmdzdlQ1ZKQmRWRkpi?=
 =?utf-8?B?amx6cWRpL1ZJUlRCTEpxcm56ZkRaWDF2OEgybXQ5Nmg0WEZmeGhaTDBrY2ht?=
 =?utf-8?B?RTAzZ3dwaUhqZFFSQThZNnZqZ1hkLzQzeDNyWTZqU3FOdHd0WW5IeWxvQUdF?=
 =?utf-8?B?V21KVUtLL1lHWjlGaFhrb3dxSytxc3FnK3gxWmw1c1I3SHV0UDFKbHBJa2ZR?=
 =?utf-8?B?eXhya1BxUFFNY0srbldPR1EwbmFtQWJOS3NuNExYaFh3anpmdUJBcUZqaHcw?=
 =?utf-8?B?QzBMY1FwYnYrbEc1L1BYSXZSaXl4ZHNnWEJMMVVrMnJ1ZjlwWFRES0UzQkI3?=
 =?utf-8?B?MUk4ck5QWlZ1c0pxb2hUVDdiVFh1WVdQZU9scGU0QUhxWTdGRlBDVzdSRWZP?=
 =?utf-8?B?cjJUMVI2YTEwejBFSjV3RWZBdnRYekc1ZVZKdUloNHRkY29yVnI0Mk9DUGlQ?=
 =?utf-8?B?b1F4d1pPOUNkZWpzbEErU3RkcVQ5cmRMRmo4SlhKbXczZTBublE1djcrcEFp?=
 =?utf-8?B?dG45T29LRWNnbGpqY0ZBcG5BUmd2THdJcHc4SGp1NnhpSW1DRWtxcDBTN3ZT?=
 =?utf-8?B?bUF1THlZd2dqSUlhSFRtZ2tCd2JpS0RSSWoxdllINk10QWx0a1JqaUxucDBB?=
 =?utf-8?B?ZWlFN3NVK01IZGNjdE9EU0MxSGRqMmxHL1VKdmVYait4TFFoU2tNK0RxMWFW?=
 =?utf-8?B?azZUMDBNT1lKVmsxU3NnZGRiMm81NG14ZkYwSmpLanF0YWtLbXNXRW1NSjdZ?=
 =?utf-8?B?dWxqT3lObG5jZlByaUhqd3dheStSeU90RWxCbGR6ZzB1Unpzcml0WmdHZmQv?=
 =?utf-8?B?K0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7364363a-a1fe-4edb-b9c7-08daee5bb396
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 13:58:04.9717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJ5cuRYHcfs4G1/JS5mP60gvtmNdNd2BaST7vytCYxBlbDnRphqsgR3vdujcDXPrG+KHCHxYgKyMfQtxt7OEzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3804
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jan 2023 13:58:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10318

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...{linux-cip_4.19.268-cip87.bb => linux-cip_4.19.269-cip88.bb} | 2 +-
 ...{linux-cip_5.10.158-cip22.bb => linux-cip_5.10.161-cip23.bb} | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename recipes-kernel/linux/{linux-cip_4.19.268-cip87.bb => linux-cip_4.19.269-cip88.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_5.10.158-cip22.bb => linux-cip_5.10.161-cip23.bb} (72%)

diff --git a/recipes-kernel/linux/linux-cip_4.19.268-cip87.bb b/recipes-kernel/linux/linux-cip_4.19.269-cip88.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_4.19.268-cip87.bb
rename to recipes-kernel/linux/linux-cip_4.19.269-cip88.bb
index 94f9f989..8957c375 100644
--- a/recipes-kernel/linux/linux-cip_4.19.268-cip87.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.269-cip88.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
 
-SRC_URI[sha256sum] = "49c0acce195c42b9d987be48ada6e64bb7226e6acd0fe9e257d1b0470dc8279f"
+SRC_URI[sha256sum] = "45280ef125d1a4dcd7a94b5ae66e4401d999abedf7f8bf9be9ff8e22ff42b192"
diff --git a/recipes-kernel/linux/linux-cip_5.10.158-cip22.bb b/recipes-kernel/linux/linux-cip_5.10.161-cip23.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_5.10.158-cip22.bb
rename to recipes-kernel/linux/linux-cip_5.10.161-cip23.bb
index 54dd870d..81c39da1 100644
--- a/recipes-kernel/linux/linux-cip_5.10.158-cip22.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.161-cip23.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "00745cadd0c555f69acd48174ddd484bdf6f9db2cac39429c7b7352134187abd"
+SRC_URI[sha256sum] = "a622173fa0a2104b1c3aa51012cb32a1c3eede559b7b6026106de287a46003c8"
-- 
2.35.3

