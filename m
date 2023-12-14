Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB4CC4332F
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 08:10:46 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.73])
 by mx.groups.io with SMTP id smtpd.web10.17345.1702541445102388699
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Dec 2023 00:10:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=hVDpD5DD;
 spf=pass (domain: siemens.com, ip: 40.107.6.73, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lj1pX4Gy2mzHLtEvJmV1wlDg3tM7VQ2w+xdNtokUETejfcx+Iv3K+mLP79lRomwmVB1TgL77jyLpvasRVNIf2mc03gLhkrofFGmBCIwAEf/2sd4mDg0zGz7BTAX3anPQt/za9jkZoMMGWgRsVNaMLdeuhusy4tmCjoEaVHHi+3djCRJ7KGgAsxA4mrau0SmYLUCXAmf4yHqbCI+CxgW/BFHh5SV5SwjfAWO046lxqPDsHq8gP9jofVeN4Af3QiR+ZWvRZAJJEz8sUYgQGJWuRKVGTHYqABOaWxzhEv35uWMMp2/gqQt38PvM1ZCUo+60lcPW5HYZlGDJfvHhvZ2+Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SP241afDQSp0RIpOmyYZ/JgfptKt01xrW+naGOLfGpo=;
 b=cLHB9BcMXaA3GH2366+XJeXp1nrz6DHdKWh6STHHvCp+6/QRz9gbjYRsZpi6kOBj0g3wsMr/cQW3PyD0IjCaW5mMe05HjxyYtYvbBIWC+qoWz2JWRHg+ZwkmrhEs0+bJnEdG7PnHkfEHkGDjYjCVMFuN/F8BZCgzU9IKVL9HmQGo8LMyiU95HHyO1isPQf05a6eU/64gGr+c7lT3h0WG1jStsottAA4slKgHiT9UvMPUQoApsQd/6ZIAgsKmMVCbidCA1cN54kJ8oMqx+fDvXZeFolrVuI3l27yyr6QFyj92q2XFQjpTWPxFBVPwFlo12mBk/aSEMoEgyckxBMcKjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SP241afDQSp0RIpOmyYZ/JgfptKt01xrW+naGOLfGpo=;
 b=hVDpD5DDFLzCuA/lpAPFpdKdgqBa0P+MaVUxgsqlPwYsuwOk2atP7thzMnKbX+iaUARlHu/IAGf+apI+PX5QE6oA+4fKV0Nn2XDpa1ft5SPvXCkpyoOVijwAkeoDdt+O6uJVkQ/kLb6e7Wa4al4Ko/8GXbF4+vlIMYBNXpcDiY5a7BKfNXDFATJ1OqX1ALXCMzJL1IrbVWoHgTIA+luMxWB9Gk02ybtB1kYb/MSDdZUGYdsbtXIFakl8tdQvMP1A2aUmCIfVjuKHpIAwj41KLzx0scVUBfc43Tf9W/afmxuqBiGSHp2lSCYhdrx5X1kMUnABFeNd/mTv0SJi2SBe/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PAVPR10MB7378.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 08:10:42 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a40c:1061:b15e:cbde]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a40c:1061:b15e:cbde%5]) with mapi id 15.20.7068.033; Thu, 14 Dec 2023
 08:10:42 +0000
Message-ID: <074a334f-436f-4ed1-9350-bad0e212573d@siemens.com>
Date: Thu, 14 Dec 2023 09:10:41 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 6.1.66-cip11[-rt6]
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::19) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PAVPR10MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a3a6b79-d414-42d5-6fe5-08dbfc7c2a5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	N4HWLF4ifSyOEpU5pVuoVitYFZBtWIgq61f/rWtZcxzEQ0dvl5qFiXLiSXVku6GQlWn2wQAhKniI7JN66gaykmyau0XgajvkXzw39u9PlrBMGYua6itNU8ehdpR4ZMpoWeXkPC0WbcUodbw56Ouwgl1uFOTn9oArB+WzAVZXdfDPYTlQR7H/sw9xFyajQgOKoWpBHlk0clexCihhLERqzh2xte3uK+xiiTmpHTHMSQsJQo84M2jo/PRBmok3drPsuwo9UR6QeBuu3I7V/PZojSWzJAJ2H1W8y7OiLPS4WJpfGNzokMtiCl3Etc9NQAfOdWJ6Oijfey0JXGN8wMWU1N6sH45MptvskoLB3rdvfnQoGIh1vL62YCSeTjhJKxCMk//nb8Qoftm+351BKzQQ+j/kb7zH/cIvtF088ggx+pVjy9s0uMOsOyBenMDjYKkOehesyjO7DZMCXeWl7byGRhZKKOixKbaMYQYrNBYB0GxC8erALt05aM2WhO6wLMv7NsltgQqvyEJPtmFRIJIQegrRtMqWv5UPi9WHiz7iUvTUHpviSaZ/oWC6gAv0Zpq8dvrFj0SX2a1/UFA4IuoF7cm6gZ6TlC7pEIdxJWPUHSWs0jcOyhpuOzgo3xJFdyFRft1y+O452lqYjzyhKa1zPg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(396003)(39860400002)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(66946007)(66556008)(66476007)(316002)(6916009)(31686004)(478600001)(6486002)(5660300002)(44832011)(2906002)(8676002)(86362001)(8936002)(31696002)(83380400001)(6506007)(6512007)(26005)(82960400001)(2616005)(38100700002)(36756003)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L2Zid3kyQVRPMHZreFFvanNkdFk4R2JxenZkalQ0RURMU3lVZnlvb2NVcDBj?=
 =?utf-8?B?MExpRm56aHgyZnZBcmhLTEhTNDBBMmlQQUZUZCtESWo1dHhDZjc4RzZtZnhD?=
 =?utf-8?B?Y2Z2Y3B0VkI4b2RyeDBVbVp1OGkwK1YwYWJzaW9uOUcwWmdPU0Z5NXA2QmtH?=
 =?utf-8?B?ZmQzR0pSa0M2aThPaE1Sc3NndkZ6M3pNZjl0dFMrMi9STWFBQXJxRDNRT0Vm?=
 =?utf-8?B?YS9TMytERGhLNWJIcHozajhHSHk3YkN2ZG5VWkQ0dllnaERVaEN2YzRDMHc1?=
 =?utf-8?B?Z2Q4NmhYR2M1OEI1OFR3TXdhNGQxZ3ZvdXNuUk5EYjd6VjR3MHNzaEVqbUVw?=
 =?utf-8?B?MG9UeWxDMDZZM2hNUTdTMCt4eUhSUjRONEdidDk1b3N2Y2RUTnViRUlOOFBk?=
 =?utf-8?B?VjBZQXBxeHA3QWpQeFpiNEJlMHF0V3B1SUQxbE82cjNkcU9FSTRLNnpVcmM2?=
 =?utf-8?B?bytJU1ViMGFkTTQ0ZFhPQm4wV1BmZGJLSnhnODUvSEc4ZXFIL1RPejhFdjVF?=
 =?utf-8?B?L0FPTXBkeVFEWFN0TmdrL3BLMHVOVFZvRWZKUFUzM0gvL0ZWUTJtQkdQOUZ5?=
 =?utf-8?B?MXd0Unh4cUVEbHFucVhKNmFseXN5L1lGVmk0MEhRWHBCMU9sRWlNL2xYMEpY?=
 =?utf-8?B?eHVmRVFiVjBKNmQ0RkRsSVFTSEVqUGFYeHRTYlhmVmpSMW5nbkhNWEJZMmNX?=
 =?utf-8?B?WjAyRkphR2Rla3NEeDh3dlc4akpuVzEwcGZ4VEd6WFVaQ3hsZ0t1VlVISlpo?=
 =?utf-8?B?VWpqQ1BEU04wVXNLOWtsS3RvWUhKUlFrbmJHcmVwbkxlMzVnYVhDenFKR053?=
 =?utf-8?B?Mk0yZWc5a01MRWxXL0ZuSGNweTUxRGJhcllxN1B3RklWcDVOVHg3N2VBNVlU?=
 =?utf-8?B?YzY2K0Z0NGlNZjVFOVBFcUppYXhkOThFN1M1UEVKeitVSUVabkhqdjBkVFZY?=
 =?utf-8?B?dEZjaU1wWTFhYVBQWlZsc0dpVktjNUVZamtzV25sM2VzSkpvMkREQytXdWIz?=
 =?utf-8?B?VlBuRTJUN2IwbkN0LzBOa0ozMzdIL2xYcHRlTG41bks2NGNHTVBVd2lWM1Nw?=
 =?utf-8?B?aCtvcDhaaHNNM0Y1Y1c5R1Z5Y2dCQit4WWV5TnBhZTdESUZiUk94cmtud1li?=
 =?utf-8?B?U1k4ZVlKQXQrMGFRNDZkUmxiT2pUVFVram5nWUh0RVVwT1AyQWFLcGZuSnFo?=
 =?utf-8?B?YXhyanMxZVp2TWJ4dTdFbkVRd1VFM25WUEpJN1Rvc2k2QWFETzJUN1ZiSEQz?=
 =?utf-8?B?MnkvQ3ZPOW9BNy9wbjZ6MkZKTXN5V1NRRFYrSXZoQUpqejZCVlBWcnZKYmVX?=
 =?utf-8?B?ZXlmZWlWUGVBeS92MWttdWdqcko3NXN5WnpmOVNHQ3lPOENNa0ZDV0hXM0lM?=
 =?utf-8?B?WWN4WERzaWZkVEQ0TTJSTnpvTkwzMkJlUnBvOE1MTktXMHlENXI1aHAzRHAx?=
 =?utf-8?B?MUlTczhaNWVnSURtdCtraytuUnlmcDVZekNPU21PLzRqQ29ERlZYUmFvanRh?=
 =?utf-8?B?RUZtZmFFbWZqbGJGcEhEZU8yaGpkWm5neWxsL3MvMW4xZWMwOFVHbzc1cHQ2?=
 =?utf-8?B?QlVsNXdkNDVBOGdNYi9JM1ZxVG1sTXN3L2RObjkvOVhGSzBydkE0YkMwY0RO?=
 =?utf-8?B?L2dkczUxVlg5SEMwRDhjUk9CL3FnaXg2M3VEOXdGZURiRmtNOVJKRlU3cjNY?=
 =?utf-8?B?V29Tb1VuSFV2TnE0dHlhWHcxYURHTUxCak1KYW44U3IvcVBkRng4RDdlWWRP?=
 =?utf-8?B?czRsVVhpN1cxdmk1V0luSkNmMlJ1YkpLSFB4SnNxUWpJQ2dFQ2NYdVJwMnJN?=
 =?utf-8?B?L0lQa3NPY3Z6UndEb1VyNS9odjF3Y0VMK3RHS2FzbVZMUjZFc3RWT09PeE5Z?=
 =?utf-8?B?dHJnbWQ1c0hzaVoxcElPS0ZKeHErb1FUWlFWWmtxYi9WT0wyMmVhMVIrVy93?=
 =?utf-8?B?cFRYT0hLVkpQc1NBckFtUGJDOXROYlBJMW5naVA0eTRxVnV3bm1VUS83dThB?=
 =?utf-8?B?TDRxVHlwM0hGd3ZhdlY5U01vUHZtT21sVVNxOGh1bTNKZnMrbklVUXdMU3lr?=
 =?utf-8?B?MVgxYUVpRDZjdk1XWDVCcnFSbXk4N2t4Vi9kbkZ0WERzekRWbThKRjdyaURw?=
 =?utf-8?Q?PSH3y5msRdi189g3TlxVPIFKW?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a3a6b79-d414-42d5-6fe5-08dbfc7c2a5c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 08:10:42.1209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hrvFaZHHxwQkfeWaEwvDVX153S2zPjqlBJZgavhNFhbCVsZ5a5jXZFRcsewbWxhtFeBYhF7GiqsgNiL+n8K3qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7378
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 08:10:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14088

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...-rt_6.1.64-cip10-rt5.bb => linux-cip-rt_6.1.66-cip11-rt6.bb} | 2 +-
 .../{linux-cip_6.1.64-cip10.bb => linux-cip_6.1.66-cip11.bb}    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_6.1.64-cip10-rt5.bb => linux-cip-rt_6.1.66-cip11-rt6.bb} (59%)
 rename recipes-kernel/linux/{linux-cip_6.1.64-cip10.bb => linux-cip_6.1.66-cip11.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.64-cip10-rt5.bb b/recipes-kernel/linux/linux-cip-rt_6.1.66-cip11-rt6.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip-rt_6.1.64-cip10-rt5.bb
rename to recipes-kernel/linux/linux-cip-rt_6.1.66-cip11-rt6.bb
index d5285c27..f9a43458 100644
--- a/recipes-kernel/linux/linux-cip-rt_6.1.64-cip10-rt5.bb
+++ b/recipes-kernel/linux/linux-cip-rt_6.1.66-cip11-rt6.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "9dfe41c5975565094399798d715bf0c246b318348b600c480eaeb87f0668cc39"
+SRC_URI[sha256sum] = "83c8303cafe867cbebe770e542bdcacc6d60bb6fae93de665a8cf13742349722"
diff --git a/recipes-kernel/linux/linux-cip_6.1.64-cip10.bb b/recipes-kernel/linux/linux-cip_6.1.66-cip11.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.64-cip10.bb
rename to recipes-kernel/linux/linux-cip_6.1.66-cip11.bb
index de65b6bd..7989e6d8 100644
--- a/recipes-kernel/linux/linux-cip_6.1.64-cip10.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.66-cip11.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "4439d9cadbe7dfa91490d883270636e6f8f2fb8796dbd4e01356e851f106d90e"
+SRC_URI[sha256sum] = "6ad2551a89b955c6c78145295675418f384136fe6e6e6ad07373af6209261af1"
-- 
2.35.3

