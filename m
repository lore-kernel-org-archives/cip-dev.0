Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3694DEE49A8
	for <webhook@archiver.kernel.org>; Sat, 19 Aug 2023 12:20:31 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.79])
 by mx.groups.io with SMTP id smtpd.web11.8091.1692447624834850503
 for <cip-dev@lists.cip-project.org>;
 Sat, 19 Aug 2023 05:20:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=aoGZomQ1;
 spf=pass (domain: siemens.com, ip: 40.107.104.79, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIWS/sPUI4IGzXLHliOPV88bfqpDjCroyEKnfcAbMKRhF9dRepGx+/kQ655eaW0qlxOlyG9koeQskiG2UORutKD9bGxpzWOKepPainH5UpNB9p5gS19npwQC8QVTUHRwqcIVbSLLkcDkGbT2LbO3WYQou5sKd7ygU3Lx+UF2F5SL2tzD/lDbWDzSVg49BF+dJk//6yzJASmFlITI8cnz1lmWJ2o9zcBGvSHxeN5mNNcSKmbRbTiJCip3ZYjtFuTLdPp188YThaBfkdRlIEK3fa9iHsxA/jCnpg34Nt2JBlKHwm9bqYeq7vXm//9pRXJMHNxoGDE9O+vX9XHRF8dLcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qsOfeV4UZm041HV0Z6aSc5HRe9o0RDWa1YQ6xeOkAQ=;
 b=exr0aPpp39dELBxb1fNbhoGMGoTq6aAKoFsubFP9g4n6ZdCsTzBlJyxkBz1Bj7FolXHscIjcQ16OQNDVG6R67eZ8xI6CGcrsRVpqnpcsQBjdxpR8KXOyzgwMgYsDMRuJ+sf6LMq67L7iSztfvyeo4fPmc9LTWRhZjY0caat3aWnBpa/ywQS7lRUe5372nbHrIAWKj83xbBAytx1CwkfUy03sIvxFiGg6n6xWVTdzhnN4uK4NIgphUmMB4YtyEp/2ry0asHQWmNvtwZ6y130gSyZYsMyLGI+ciyyawRIP4nd0RtZCEOPoOtOX3ZQNZaKvsQEeW+uGu8U9F1YkFWdzYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qsOfeV4UZm041HV0Z6aSc5HRe9o0RDWa1YQ6xeOkAQ=;
 b=aoGZomQ1C7NCO7W7fTSPYeN3ONDsAk30Hk3EFE8ogMmcIHiVO/tnNzC8Qxp51NJfu86K82GoRJu5ZfGldreBTHF+G5PEzhoIt3RCOxk8as1KwWYPD+QD0FQ76iVc1a4PkZARZPczFvsl8orxI4jjlmlPbLJmhdNSs+QBdZtxTQzGztA08qx8wW3MNbZmeiwYgSeWcrfwlrrzEl1Ui9W6CcN4J0kQX1cOxJmkqlKNKPaTqRI4A5OsEj++u4EkESXSno7ddHoBFpnxM8KxZtObqNfpCe8sC8FcF3Xf8XhDtBWT5I7mq73I5e7C2HUBmIefmQc3UCdmeoZ2Q5HVo2VN5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5569.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:309::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Sat, 19 Aug
 2023 12:20:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6699.020; Sat, 19 Aug 2023
 12:20:21 +0000
Message-ID: <d68c845f-1ebb-42e8-913a-e94a4a2ebf74@siemens.com>
Date: Sat, 19 Aug 2023 14:20:18 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH v2] linux-cip: Update to latest releases
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5569:EE_
X-MS-Office365-Filtering-Correlation-Id: 28b3db62-e449-42d3-59cd-08dba0aea83b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sbSI+ohe19lOVMCMNgm+WiWVAaSjHZJvE9zws1jnb/ioWZLajuH1HjMIvBcKrufswGpIh7zOOfGHSzHOM1YfBOkO8eoiopcqRx+zFkZ7zzl4ZGXRt3oW/E+Z6l8vwH+Xc97Nsq9BsRCjd2m8VH6pUpiskG5tPsXo8T1z7mo3B3q8XjVdvq+62IvXXl1SdPp80y1o4eTg4XaZaVvE0N/hQRBlTAR0lle9XQm2buA3DdqSW0Ss07faRPrqlBuqskeBTMw01BbhjetEKznlfL4jAiaA90XVZVL35UrSdO22NOWqo7WDRlQNnKOTHn3cW/sMY8l8+BLnH5vo4zp2fTLNxot9DAaRSiRDAhpbr7L9pyVGoL7Ac838RvOylE2K2+qeGy4JkV01J+r/rdYt+/lCAw0jSZG9txVU1vf+MLNNeogglCuV1hAXYdh5PU1YV0DUjmzmPAGaNFWYvmQJIHUUE39Iydd3twgkuUYr9ZASz+gsqhD+3MfxL/MQCyx9rRhDzhvbtU1Mtqj9YxP3crmjq6nQdIBHi0luQWaqcxZbYvZKO1SLi90IcwT654G9IirBQxpNYdU3WTsTlQ8GpN8ADAkEs5PLNsHAmSTnMGHYFw8SUV7iLRgMhh3mlS2peOdxQw0/I6vP1PcKh5Y0zLACeA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(366004)(39860400002)(186009)(1800799009)(451199024)(66476007)(6916009)(66556008)(66946007)(316002)(6512007)(82960400001)(8676002)(8936002)(2616005)(41300700001)(36756003)(478600001)(6666004)(38100700002)(6506007)(6486002)(15650500001)(2906002)(83380400001)(86362001)(31696002)(31686004)(44832011)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dWlMQVlFYW91WU14UHNKZjA1U21FaldKcEV5UlcxTGg4SHMyRGVwcU1jczRh?=
 =?utf-8?B?L0dJNnM5ZjUva0VlaWZ6RVcxZTFjY3drV0E2L3VVOXVVWm93SjFUaU5NNXdG?=
 =?utf-8?B?MGJORW5aSnJ5UkJzTlZoQ0p4YW0xY3ZGYzJMdnlFK0ZTaGw4cFFscVFCeXl0?=
 =?utf-8?B?Z3k1RFI0djBvZk4wNW1iV0hDckVOcjVKY2pIUnFJMWJLeEs2dGF4c3N2NWJD?=
 =?utf-8?B?ZmVSQWRDMEphN3pzb0lGbXdxaDJMZWtmbk1MaGR5a1l2MVRXT3F5dkY2Z3Jl?=
 =?utf-8?B?ZUxLTDB3YTlCN3AvYWNIUDF0M2dsOWVFWHZ4M2NEMm1uUllaMy9aSVJUYkhX?=
 =?utf-8?B?bmdCN3o4SXZ6TUxiTUFoMXgvYXRnYm1YU3JpVVdxczk4VUt2MXdwcVJIMGVi?=
 =?utf-8?B?dUVWbHJJM0NNcE55L1h4Y2RoNjN5dmdidzNHRis2dWRZcnNJL05YVTB5UXVS?=
 =?utf-8?B?MmFwZTI5N2FlN1pjd1FXdEk5cXNPQmtpTGtKelZlM1hDOHlJUHYrczdzSnhz?=
 =?utf-8?B?em04MWNBb3k5eEZjZzd6c0xuL0tKM1lYWkhXOU1TZjQ0MjNaTlYyWGFDZy9r?=
 =?utf-8?B?cGhGSy9uMWd2bFdxdlFLdWljYzBEaWdKek1zQk9OMGVRQXlQNE5jU0ZnSytU?=
 =?utf-8?B?NXN2M3ZzNWF2WlRzYXlGRm1nMWxsY084WHZ2Z2NIcWVtY0cyMmxIRGJQRGV3?=
 =?utf-8?B?aSt0MnNwa0xWdkZ5bGJMVUV4UUF6ZzlDS1FKTUY4K29JczczdlV4RnRkcWhH?=
 =?utf-8?B?Y08xcXB6NEZYNm1URmtLN2h0SjR3OC90NlRMSGIrdE1QOXdQMW1GTEtQZDBx?=
 =?utf-8?B?M3FBMTBoSU55MjFWSjROWEpvdldWNnZqQmpRWGdrY1NQTVQyb0dWeXBNeml0?=
 =?utf-8?B?OWtXci9QcEFDME10alhDNXdPa2dEZERRem56UGgxMkRCcS93TGJUZ0VHdDNM?=
 =?utf-8?B?aWJYQ0IzV3JmUW9IYXRIbmxUcGd6MnBPYUhHZSsySHZvK2FaVXlSeEdUR3RT?=
 =?utf-8?B?SkhuZXZ6UldOMURaZkYrRFNjL20zSHUvTkNReXl0MUMraXlTaHJRUXRoTWpv?=
 =?utf-8?B?Ym1NamN1SVc5SEtmWGlhMXNsdWdhNUNYcC95bHAzNWVNL3lQa0lXU0V6MDha?=
 =?utf-8?B?Slcrd3h3dElpN3czQkp0Q1VCYk96UkVkZ1ErUWdIWXdpOWQ0VGRYN0pwQzRu?=
 =?utf-8?B?eStnMkJwUDU1Yk4rem1iUFB3UlpaRlVHT3BoVDNSRDE5aEZ3SzlnTzhXWXhi?=
 =?utf-8?B?MDR4LzZoNGg1VFJucnhHejJzMnZTWDBBcHdqTm8ySnA3RDJQZG95Vm1rV2hJ?=
 =?utf-8?B?TElseGQrZHhhUUVtTVZTSWIya1JZdmw0T1FSOEhaODlzNmlkWlhIMFZkRVBV?=
 =?utf-8?B?bmhjSUFPS25jRWE3bmo4dk81TzRJSXcrVFJGR3RjZzdFT3lvU1lkZnBrSUxn?=
 =?utf-8?B?eExpdStzaEtMZVVIUW42WFdaYlpiZ0lKNjFQUGZ0cGd4TTVjMUc2T2YyVEsz?=
 =?utf-8?B?VzYzcVFTN05nb25uQzd6ZE5wZ1loVjZhQm5mTjJSRnpvVW5KQ1ZJdVZaWkcv?=
 =?utf-8?B?QXRzNHNuN1VtS2kyUVZtQWNibXk1R2kxeE9VaHc4Qm1weFJCTjloc1lqcER5?=
 =?utf-8?B?T05Nek5CcWpic2ErSXR0Uk82aEphOFhiN29HQ0dDNTF1Q3AxTGM4RnNWTXRD?=
 =?utf-8?B?MVN5WjMwcExOSXpGb0VpRy9HQllvU2ZoSjUwZUFHU1dDOVJPNEFBN3g5N3ZI?=
 =?utf-8?B?UEtyWlc5WEpCc2h4TUt0SGhtOU8xNCt5OW1lWU9RU1pFSTFCTzBjWFRTeDRn?=
 =?utf-8?B?YWhFTTE5MGV1R3FoOGFNVmpKOTFJUWxlWEViRnQ3Rzh5SGRrZWNSN0NOUDBR?=
 =?utf-8?B?RkQxYmxOZG1IbFpDMFJvSHJrUDZjRUdqNjIzcUlEb241dkxUR0pVdzdiU0pI?=
 =?utf-8?B?Q1ZWY3ZPQ3poNlFFMzJzUWFZZHZhTEJ4OEVtcEo1RTJBVG8wRXU1bHp1RWdt?=
 =?utf-8?B?Z3dTMG1qTXgvM292Vmd2bzNxalFZSmtPeC8reTdRZ3JQTDZrbytUZnhpNHF0?=
 =?utf-8?B?eTRuVU1YMlpQR05WM2hEOXlJWDN3RmNZT2gvaDhGWHFhV0lWcUZLY1ZuRGwx?=
 =?utf-8?Q?svqQIzSG+REvrYmwLK+u/KNq0?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b3db62-e449-42d3-59cd-08dba0aea83b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2023 12:20:21.1394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ul9oZn/kBhVtuUC7nYauV5JbaOyM9L+TgFfILFBQ2zR052931OnY/etJhVypcxw6P+CrgGe2b5emkBZawv9U9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5569
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 19 Aug 2023 12:20:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12790

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - update SHA in linux-cip-rt_4.4.302-cip78-rt45.bb

 ...9.284-cip99-rt31.bb => linux-cip-rt_4.19.288-cip101-rt32.bb} | 2 +-
 ...4.4.302-cip76-rt44.bb => linux-cip-rt_4.4.302-cip78-rt45.bb} | 2 +-
 .../{linux-cip_4.4.302-cip77.bb => linux-cip_4.4.302-cip78.bb}  | 2 +-
 .../{linux-cip_6.1.42-cip2.bb => linux-cip_6.1.45-cip3.bb}      | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.19.284-cip99-rt31.bb => linux-cip-rt_4.19.288-cip101-rt32.bb} (72%)
 rename recipes-kernel/linux/{linux-cip-rt_4.4.302-cip76-rt44.bb => linux-cip-rt_4.4.302-cip78-rt45.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip77.bb => linux-cip_4.4.302-cip78.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_6.1.42-cip2.bb => linux-cip_6.1.45-cip3.bb} (65%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.284-cip99-rt31.bb b/recipes-kernel/linux/linux-cip-rt_4.19.288-cip101-rt32.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip-rt_4.19.284-cip99-rt31.bb
rename to recipes-kernel/linux/linux-cip-rt_4.19.288-cip101-rt32.bb
index 6a1ccea3..19c269b5 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.19.284-cip99-rt31.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.19.288-cip101-rt32.bb
@@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
 
-SRC_URI[sha256sum] = "a4984846d2a239cfe9ab8546dd3a692d8fcf6da60228b54b51a8abc5b0ce2fed"
+SRC_URI[sha256sum] = "e147634e8d2730f6b0ea0e192f50bc3e30205d0076c6f83adbef9e5eccafaf3a"
diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip76-rt44.bb b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip78-rt45.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip-rt_4.4.302-cip76-rt44.bb
rename to recipes-kernel/linux/linux-cip-rt_4.4.302-cip78-rt45.bb
index 43488ddd..0083be1c 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip76-rt44.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip78-rt45.bb
@@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
 
-SRC_URI[sha256sum] = "01260a42cf979e28e183bc2161a5885dfaae1628eefc1325438294f4def8adc5"
+SRC_URI[sha256sum] = "7b3efe2a56531eabd4ed0b9682d4713c3933341a357f47eb03bf2ec75f89db1a"
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip77.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip78.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip77.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip78.bb
index 0b87de57..bfe13e40 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip77.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip78.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
 
-SRC_URI[sha256sum] = "88686014daf17f1b2c64b24c36e1064b7dc1616a8a1ba4b3651362fb3b1aaa85"
+SRC_URI[sha256sum] = "9adec24bdedcedbd4bc975b592ad043d84abd74c03bd038b12b5c60c00871ff6"
diff --git a/recipes-kernel/linux/linux-cip_6.1.42-cip2.bb b/recipes-kernel/linux/linux-cip_6.1.45-cip3.bb
similarity index 65%
rename from recipes-kernel/linux/linux-cip_6.1.42-cip2.bb
rename to recipes-kernel/linux/linux-cip_6.1.45-cip3.bb
index 0b6ffaab..8124f1d7 100644
--- a/recipes-kernel/linux/linux-cip_6.1.42-cip2.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.45-cip3.bb
@@ -9,4 +9,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "6.1.y-cip"
 
-SRC_URI[sha256sum] = "70d05a84e8194a94dccbdce952a983466a404498fe59fb61fd3de1463322bb5a"
+SRC_URI[sha256sum] = "bef9588c018ef583303b288baa4eec3b0fc8a723058d52da7fd2fa27d6e619d2"
-- 
2.35.3

