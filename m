Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810B5EEB58B
	for <webhook@archiver.kernel.org>; Sat,  9 Sep 2023 11:51:47 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.53])
 by mx.groups.io with SMTP id smtpd.web11.15127.1694260302936001993
 for <cip-dev@lists.cip-project.org>;
 Sat, 09 Sep 2023 04:51:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=w323lbCz;
 spf=pass (domain: siemens.com, ip: 40.107.22.53, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtfuWNFa/6iaoNQwGPLNo2TK5gSkt3aMnDt6CCh0DtcSSnn/GCkwFUd9WJrjSjKkYuDAxNJTxiPjrr+Tz1RkjpyJ9xrf74f9v7dZh7td0zPM+UPiVHa/8pOoSTIxp7LuSpeEKRb3jveqp03dnjJHQRRZ80opn8XX8BxKHhUIvR4VfXS7ENTdH12PRD6PVgPWFVDaEdW7yIhuzhyyb0leO6lEhu3XVBj2WoV/Dwd5httF/cyqAf0QMNQQ7ZtXNKXWJUecEaUDryAm70SNcrd/rivfQssrbWybX0DdhTNihFl1GOZ8ucKSN7atp+hNvTl+VzrpsscA3AeZxTzd7EtThg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QqtALCZikJwP0iBABm2zLwy8OSvQeB96HAEDipYv4GQ=;
 b=mvgr+q0/Y+U3ZOtk54xMOKztVe5PGBmMmuoz+2vNEVbBTmhVj+pHJBtqbaBK+BG28SvQmnWxUos71csUfywo6YLkvhSfvepY3p1qr7sbzh5/e7Awn/RhNkE0h3kGiXFwrUsO7qWoCsbHmyZZfxaG9gaPR/b8WsKWbHQzf8jJXqOhjE+4JLOGflNdL3sTEE2BiaVxUdmHm/o5lPCoCS1UxBOnd6QegaPEXiFPjRRLUhEDLHuSFTc4V9l2O8Vlbn12BfunEiM1MPTATpm2kCDiKzmFc6xGvv9NElNsfH0+bB3p/MLCEmfPBJlwdhSiNRMsNYAOnn2/9GNREs2EWZE/cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqtALCZikJwP0iBABm2zLwy8OSvQeB96HAEDipYv4GQ=;
 b=w323lbCzZLjI75AlX6cUQksN9US11vKLHbtcs0Mb0F3PXZ1TfIF+vjXE6ekH7dInL4tDChiAlhBvIUmCrcjc5Z3qF0o+ZEgI6eW3kOOLsRtW4A3UjFRDYsMPu0eBIG7WG+NJRNvo9exTXPplST+X3OlQnhrtsIjWtFMBrrbgWqfKycMsVKx8CdMKF5du7LptVbYSVah1nYN5TLAOjYQJdm0O3vSw4lXMDSIenT6rUu84OzZxvQaL5e9lJ4oLqMn1PJRZTs6/E+hB3i5T4NS7Kt+MYGmctjMxQt0qpo2BHxDJNYBpwoipFsrtA7JP2OeL+WSjOeGURjXgMQVirgpUwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB4045.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:aa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Sat, 9 Sep
 2023 11:51:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6768.029; Sat, 9 Sep 2023
 11:51:39 +0000
Message-ID: <1bb4508c-9e4b-47b1-87ce-7cab50ad92d7@siemens.com>
Date: Sat, 9 Sep 2023 17:21:30 +0530
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip79 and
 6.1.52-cip5
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0063.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB4045:EE_
X-MS-Office365-Filtering-Correlation-Id: 592e3210-2fe7-44b6-0768-08dbb12b2027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	I0sfk8rVqAmIWmgzE4HalVC0y6IsMFGB+/JYjCMZ3KIuVmwKKDDeSSvoVJIYe5uSY8FW/DHGsgyRjo278APuQsQyXBHSYXkWRPzOkL15dVCRHtERJPyapgzsH1ehxBqR7GpqN0T98Q2q8jJ2fBGvdZNUXqwoHN7KUDXNKjqnLcq2qvMSn1fQyDj+wYa84n7+dLN+sdkQuhVaK6OaJhPKoOG7VJjuBoiU31YUd0C7pSsHtQTKnOrnGNeWc3kM0qjaWgU3twiXINuuG08Zm98/Jsax8wJ9bbjwaENEa69lWka/BF27bXVXghp3KGyYD11n3gH5dRH3g7tmgBMDsffd/jevgARi7yQyR6Jl6jRdmXg89Uk9NIglvFOc5ledqJq5YQyWSArKIhWoCzhUc/u3A/Ei1vRUrM+r5lGbZMqnKfAKQ0uck1hrCzXhNToq4xnhWBDY7UxQEvdVq1qIa3F/NF0YRDCoec8QPiYHwmu7frAYd8lUOl0PXzpXgxrTaS5YBpzOmOmPG+gBXHWsJeqBUyctCHmf1AjHHr1dE9wek5vUGnNVw+PTXZhX8mAFJkJF7kMgpuwhgo883XZpi98bVocSH7KG9gBIvkVSEMxQdJhLrcXzQejpSuMyjdeElGbEvz4RSFOFhCeoNVS9zxLNPRF/5OWrrH4d+hSKveLFkT7Y4rX9TdLEcGtrNDAV5BuExcKieX7egtJV3iMvF5dCOQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(186009)(1800799009)(451199024)(6486002)(6506007)(6512007)(6666004)(83380400001)(86362001)(31696002)(82960400001)(38100700002)(36756003)(2616005)(26005)(31686004)(316002)(6916009)(41300700001)(2906002)(8676002)(8936002)(66476007)(66946007)(66556008)(478600001)(44832011)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VUgvK2lVWHViSmE0dFQySXBtdnhlRGxwNVpCMm9zK095ZUkrQko1UDREUkMx?=
 =?utf-8?B?MnpFeEkwb2ZJdDIxMHpMaVVoVWliOWZhUVlYaDdwNDFKVEdINkFhV0kyWDc5?=
 =?utf-8?B?UGpnWUo0YlMvK2hmQXhWMVYzYnE5V1VIVEJ1OUhLYm9STElWK0pLTVVtWDI4?=
 =?utf-8?B?Tkc5MVhBcjBoRWZVRTlLOHRHTFo4OGp0dFVVeEMwYmwzTVJ3VGJsYm5rY2dW?=
 =?utf-8?B?dDVuMnhxTzhUZHFsQzEwSEpIemdWNjNoaTdheldINnNhdU9RclRxMmlUREE0?=
 =?utf-8?B?VjlzQ2V5T0dhRGxWY2VKU1c1dDYzZWhPOWJrSXdmUWtUeWdmd3JTNmRwTEQr?=
 =?utf-8?B?ZWdwVEUwazlhajlFb1pEbDBaQm1pb1NCREI0Z0U0anVSMGJRYzJheXVEcVZX?=
 =?utf-8?B?UHo5TUZ5eVJQUmltSWhZL0lhQnBaY2xxeVQ1N1ZEVlVWeHRIdkczMHVyTHg0?=
 =?utf-8?B?a25jYlJSZGZ0WHplRE9OMWN3Vi9NYUhDWkdVOHhPaDdaNitFWTl1cGhyS3k2?=
 =?utf-8?B?SVFDMWNObEdxSnkvSTVVOXJTMXVpZmQ3a1F2WUU0YUNDNlhVekQ5MUNRQkx2?=
 =?utf-8?B?QUNBMm8rc2pST25MNFM0VGkwcEIrSHZxUmxnaTM5cnJueFI1Z2NkZVYrUUNk?=
 =?utf-8?B?SHNGY0Yvd2dMTnlaZlVPYXd1TE51U2wxYkFheUJmOVBaVWFoM0M2akhBVzlo?=
 =?utf-8?B?cDNxNzI2K3FmaXJabjNOVlJjeFloT2RnK2VMbmhYM25LT3dKMTl6SkNZRHZQ?=
 =?utf-8?B?YlB1N2daVkhxbG9sZFBpazI1RmM0cGJRTU0zMmovSTdGaVErcG96ZXFKUHI0?=
 =?utf-8?B?dXNPOE1NNjhTZThGdm9tUFB2OXNaZlZXRVBkZjNYUWtlc1VTREMyNTdOakpV?=
 =?utf-8?B?Rm42Vnh5U3p3UVpmbzZUNFpXTW1SelN4Zys1OGpocU9QR1RWek45MDZjcHk0?=
 =?utf-8?B?VFBUQUtLN2NObks3ajNWSXVlRmpna3RnS1dxMlJJSGRROFFBdjFURFBLRTB6?=
 =?utf-8?B?L1VpNGg5QzBlY0dLSS9Cc3dCbm13bzk3aGhCZW5NV2gzWEp0VFJLU29PNmpB?=
 =?utf-8?B?eDdBaU5mbU1FdnJtaVZwVGxlN1lHTGxMazZ5SXd4UmQvT0NEYUQ5YkdpMkls?=
 =?utf-8?B?SktETWU4V21TRlRCcFJxOWxZaXBHdGNaMHZRdE5JSlRlSDJLUXNGWnVlS0F3?=
 =?utf-8?B?dEREblRvdldPUVplM2hzN3UvMDE0dVpNd3dnY0p0QzViM0lyNHZTaGwrWG5K?=
 =?utf-8?B?TUpUUE1qdEtBUnRmOUZvU3c4WnY4eW9mVmQwd1NFbUVOalVTenZnVUlETDEv?=
 =?utf-8?B?RWlYUkMyVUhRcVJVSW4wQVZOSXg4VXNCR0piNFVpMWpSTlJiUjlaSWNnQlFF?=
 =?utf-8?B?UURVOG44VW53VmllSFFDZHJSL3F0dmRNSGw5R0JBVm95QjNIUEZSUDU3V0Er?=
 =?utf-8?B?Zis5b0RPN1czM0hBRW1makRHUnkwdGlMaEpCOFVxOVBVZjJVMlBhRkg3L0lH?=
 =?utf-8?B?Z256UTBKS1hWcFBUMVgvVWJjYjlyRmRTdFVicVZaZm1IRmR3VSs5Z3ltMmdr?=
 =?utf-8?B?MTI3QWNrOG8wNlVoalpvU1ExNUI4aC96bnAreTN0RUpBVlQ2bElNYVVKcFRB?=
 =?utf-8?B?UjR0MC9HMVRHVnBDUDRhS2RNK1pxcTcwakVEeW1HVGovRlJwNlRXSkpybVdP?=
 =?utf-8?B?UUFPZkx3UGZzMUtqT21XV054WUxnK0pmMjRjZTJlMk5lRFhtZk9GWjZjSmc1?=
 =?utf-8?B?SDAxLzgyaFZzem9nUkxtMHdoYjJNQ3Z4SkNhL2xhS1VqVUUyWktzbi9BNlRq?=
 =?utf-8?B?TTFKa1NHSjVUQ1A4SkhsK3p1NHQxdVdndkxIbzN4UksweGZnVGR1VXFPc09k?=
 =?utf-8?B?c1lYZHovZHFiSldWaWtZM215NG9tMlNzckFlYit2RjFZdThvc3diZTlWQTRC?=
 =?utf-8?B?NCs1Tk40VkQ2T0NNTmZyeU5QMWVOaFZVWGU5QW05U0pEeHhFQThzNWlYVVRj?=
 =?utf-8?B?TVAwcDMyTjB4OExWZWVLdTBaQlJTRGlFVFdiaFk4S1c4dDVJOG5GMmV6NWNs?=
 =?utf-8?B?Ky9sc0piMG96SGxOb3o0enhwbmR4OFpUYTlRQTlpNWtSbkpwejJCYkJNNXpT?=
 =?utf-8?B?OHJjbVhBM2gxVUtONkJtTit5NHk0QkRvbE9xaVNiRzlLL1Y2a0poNVlLZ1Zv?=
 =?utf-8?B?RUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 592e3210-2fe7-44b6-0768-08dbb12b2027
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2023 11:51:39.2441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QvNZMm2NKI5sox+qJPdJuLEGH9urxAcm8azmVZ2Z5625VDpKCvRsZ3exxUQenE1YF39drsSosfENiSLHFYYDPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4045
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 09 Sep 2023 11:51:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13015

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../{linux-cip_4.4.302-cip78.bb => linux-cip_4.4.302-cip79.bb}  | 2 +-
 .../{linux-cip_6.1.46-cip4.bb => linux-cip_6.1.52-cip5.bb}      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip78.bb => linux-cip_4.4.302-cip79.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_6.1.46-cip4.bb => linux-cip_6.1.52-cip5.bb} (65%)

diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip78.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip79.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip78.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip79.bb
index bfe13e40..58ef7d26 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip78.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip79.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
 
-SRC_URI[sha256sum] = "9adec24bdedcedbd4bc975b592ad043d84abd74c03bd038b12b5c60c00871ff6"
+SRC_URI[sha256sum] = "626c3f29ed71fdef637d69938d885a54c6516d41f44a17f1a4e2dd405fd543c0"
diff --git a/recipes-kernel/linux/linux-cip_6.1.46-cip4.bb b/recipes-kernel/linux/linux-cip_6.1.52-cip5.bb
similarity index 65%
rename from recipes-kernel/linux/linux-cip_6.1.46-cip4.bb
rename to recipes-kernel/linux/linux-cip_6.1.52-cip5.bb
index fef2d05d..77b3760e 100644
--- a/recipes-kernel/linux/linux-cip_6.1.46-cip4.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.52-cip5.bb
@@ -9,4 +9,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "6.1.y-cip"
 
-SRC_URI[sha256sum] = "691c4e52281e47d324c4c9b840cba7050e42147a05342ce4cfe1ece40fb9c27b"
+SRC_URI[sha256sum] = "6d06628abc5eb30301d3bf0abfbfd90f7ceb01d24170e39d02adc8b730332d76"
-- 
2.35.3

