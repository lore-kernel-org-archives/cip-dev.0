Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0BCE77188
	for <webhook@archiver.kernel.org>; Fri, 10 Jan 2025 06:29:27 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.67])
 by mx.groups.io with SMTP id smtpd.web11.13132.1736490561412662219
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Jan 2025 22:29:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=BunFrExJ;
 spf=pass (domain: siemens.com, ip: 40.107.105.67, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qOHcktCPI6dgoLcZbWTElmW+VsC/6oXCuy7kaeHmFrifLJK68SdvG7c6rsWJt9/38hvcJ6gX9yoyT/EKInI/xwhy/jrDObOjINPRtwlB45kHICmJ/ihFZfQZrkz85XVZcn9fkd7sHN6QLXgHq5aeHU270wTgQvErMiLdZ1ivs48dS4MA4WrwjgF/UOYi9nrOOlR7PeLw2JZ8vJALktVvBmjnMCVAAQ8M69nyRUiiO84F997HmQ/FcV5WO1KuPp6//w8lGD4MYUnATV+zd88LxneyIbNzNueer/Z0Qrecp0/QhiyWh2bqh5YRwYkNkfeTrUt6OOUjoV3+2D37eukYtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40sLoR0iCZmM3YMBJusUglpi/CwMb0imWgEG6gqhZOk=;
 b=n7RGPc6wPv4UduL4KpokDwo9SIr0EvAquQQCM7MfrfEocg0yF78EjXEKkpAUDmUTfz1l6Vivup/sAO3bIz95rjzHt932NBZM91w+T2nLAX0DOYs/lWAvmxvyzeev/BIhZCoYoYyPVI3m6XrJfkN7mJVkfJ/O/SBj6sr8yx6LzL3VBWx8K5POofD82gon1QUy2GYwZbBMkhDrUDS+SubQUzWEKD8c+dhbi7t4WeLctdFMrTQA/G6kJ7ocfu9JqqJ/2fs0J/h2GS4MYG/C2MLgAI938g6A2+ilacUIEa8qbv6UlAOYF/s6uSDj3CCdOtoqozIqTjVg9+/0jPceSzEShg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40sLoR0iCZmM3YMBJusUglpi/CwMb0imWgEG6gqhZOk=;
 b=BunFrExJdpBsnD687v2Gi3blh20pdbSJLS/zzs7QbFyZUvliYuNGWDvr3Iv7jSIHKNWkabKhInaUBsib+H3o6fLJKM059BQuMsyN6xPrCPdyx6YI8x3ZWemH40Vh8kUddeQdLoduP5t54iDOb2LRABQET0ZDzv1OxjrtrHy8aLZPdgdM69IVsG9k2obn8PbIKd1nsPYV7wGL8ISNglRzzC4tcywS+5HqqcWY1xAywa9vr00ys0ycaPgVm5p7d1mMyZZ9VB8O1T2TgKaj659I4+CGb/bJSXWUt2o7iP+U+rDu9+bzOO2Sj3+uUNPPRch4oFWFs39IJlAQdWMr/yuqow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DU4PR10MB8950.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:564::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.6; Fri, 10 Jan
 2025 06:29:18 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%6]) with mapi id 15.20.8356.003; Fri, 10 Jan 2025
 06:29:18 +0000
Message-ID: <d64afca4-9c2c-4078-8170-6dd3ed5d610f@siemens.com>
Date: Fri, 10 Jan 2025 07:29:16 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] ci: Drop redundant deploy_kernelci disabling
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR10CA0025.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::14) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DU4PR10MB8950:EE_
X-MS-Office365-Filtering-Correlation-Id: 77a870d3-3dcc-46ad-d5da-08dd31401c6f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WVdTUXR2eWZ6eTFCU0MybWQvZ0tjNzVPZWRmMkIzQlE1eHFmanExTTVPSlpC?=
 =?utf-8?B?cnBwMndLYTdONDJrSFFrVk1WNks5MzRQd1huMU5sUm9DemMvdmJXUGJWY2NO?=
 =?utf-8?B?WTE4Q0J5SHdSaWZscWhQRUplbXdOa0hxcXdWdkZBU1Rvc2daSjBHK29PR0Iw?=
 =?utf-8?B?K2VaWExHUXpsY3orN1pRK2E4Szh4allabWp5ejhyZ0o0N1lGYWNqMmY3aEZq?=
 =?utf-8?B?MGZyYUdVekl4R3J0UkwrUjlPR3YrR0lzNUJ2akhSTlBWVnBYMzNnb1lUWkI0?=
 =?utf-8?B?UE9UUGJWYnF5S25JNTlvUmZpZ1RSRE5Odkp3bFphbjdXNUNndkJlSUVrbVc1?=
 =?utf-8?B?Q0s1NENCaDN1MlMxTGhuZ1BPRDMxOHd5NDcrS2xSOWY0S3c0RXdMUjM4L0FF?=
 =?utf-8?B?emJNazdJNjRnUDFaUmt6UnpvUjNITWtUWk9mZmR0cVJZK1FxZXJzQ25XYi8w?=
 =?utf-8?B?R2FGcVlIaGt1by9Nb1Q0VzdpclIwRzhzT1lMWkRTT0RCNHpqbmFoeXd6UnMy?=
 =?utf-8?B?M1FDQ2cvc244ZDZuWXN1UjNMUXBwTUJMMVpyUDIrYmJyMUhtNHIwazQ5azRZ?=
 =?utf-8?B?dGhRaXN3RjFHU09kdm1MdllFRTVLVWRCdHVISFYxaFB6ek1EUDNqMjZaaEZV?=
 =?utf-8?B?SENhdldSSjVKUGZjVVNYM1kvQm4zSDFZY3RseDQvWjI1enJLei9nS0tzaWZL?=
 =?utf-8?B?N2o2emp1cWdrRVN2RVd6Q0J0RFZ0TklkR05ZWGc3U3NJTVZEY3YxbFZNNDIv?=
 =?utf-8?B?QUZwUTh5ckdqUFBkRzRMZ2V2NzF5Vk11Mk5hQVRpVG14RFlmTU1sS3ErRlNv?=
 =?utf-8?B?R0p3TE5qODBJNTdwVitjWmNHMDVISmU4SUZ0TFpacDFEcEVkRGFVcjZVMU9Z?=
 =?utf-8?B?QUYyMEpGL3BWQlNScUFNeTU5UmZOdlUxWXRzdTFTMGtrV0pXQWkrK0cwN3cr?=
 =?utf-8?B?bzMzL0FpY3BnTld6a1d6YlRuR1ZiV044SmhPdW4zZE1GckNycGpYMWYwU2cx?=
 =?utf-8?B?Q2pIak53N3FwLzl6ZjZERkkxZENBcUcxSTRKclNaalpUUmNzWnNDM2pJSEE3?=
 =?utf-8?B?V1B6ZWw4eisyZFdEUmVVSDBZVER4cW1paFVoTEU2SS85TVg1VDlZU2RFdXNS?=
 =?utf-8?B?MXIxTE1vT2tIRW1mR3FQSW5PRzNsRERFWEhySUcyZlozZzlOamdwaGJvOXRa?=
 =?utf-8?B?dFN5YUllRzVnSUtTMjZrWFpDY1lRTlJSUU41YWNsQUEzUmg5YldkZWFaMWtv?=
 =?utf-8?B?akFab3VzZm03N1lGc0c4dDQwam95UzY5NWlFTmRDMXFIYjl2N1BMV01UMlFZ?=
 =?utf-8?B?MitJcVMwdG51WC96YlNzZnJod1dXSlByZGJ0QUF5dm1hSzVrZGQvRXV6Ylh2?=
 =?utf-8?B?ZFVHMnUvQjg3SHVKTkZoN2ZsRm5HUG1SaGtiZk9pb3hPYU5IRmw1cXlRVW43?=
 =?utf-8?B?aUg4d0MwZTVNOXpIQ3NhWW9vRlk3Qnc0UlJUdlllNEhibEN5Z1RELzNvTXFa?=
 =?utf-8?B?L2orYndrMmJDZFRqbmxaVDN3VkFKMU5yZ0FKMTZwd1lIUWJyM0h0U2poT2Jk?=
 =?utf-8?B?THJzRVdhUUlKUnJBOVkrT0xwOGl4NnVBelV4VDVhVVNGL3kwWFdjaWVMZ2xU?=
 =?utf-8?B?a29YN2haNm1mM0pHd1MyZDJmS0JrTlFMc3l1clp1WVIxRzVxTEN3dUd4eW5z?=
 =?utf-8?B?SGpPTEpPbTlRVU41eGp6cGNkcWRibGR1WDEvMW1PQnRBS1k1Qi9MRldtYnJM?=
 =?utf-8?B?cEtyMFdRckVoTFd5S0ZsY2JkYVpGNlhYQUQrblIxVjN6V1NhMkxOa0czVUs0?=
 =?utf-8?B?RTVVTnJUcE04Q0dxaHNLK2NJS2xCUlA0eVpOMExsWnpCeVg1N2xTKzd6MDcw?=
 =?utf-8?Q?kKnaWPscU5KtG?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZUlyVFNlamRHbTF4ZkdxMUpSbitnUmtsZkZzU2xHMHhkdVloRytjOE9FS1JN?=
 =?utf-8?B?UXhpcGtBRDc5dk1BQXBjMG5PTGFUQW5RUlgwVXFwclVtdmJpR2I4MnRkRldM?=
 =?utf-8?B?RDRSelIwOTh0TG9JNHdRWG4yd1RmdHdHVFJDaG5obi9UbEd6clV0SEorbEN4?=
 =?utf-8?B?MDZ2cExEUkltM2FudVkrMmpOTDY3K3N0ZTBRNFEzUzY0RFVITTlQOVFrb1JH?=
 =?utf-8?B?WittUHV0bkFmTnFZM21nUjFCNjZoc0hjK0YwdXZ6S2NWdCtUeE1xOUdCOXpF?=
 =?utf-8?B?YXdnMUJ0bHJFdEJMT04xQlNNOE96N013N1VFc0lxeGZ5Z1BmdVZhc0Z5S2pY?=
 =?utf-8?B?MTl0Z1RRbVhpUXF3VmMyYit3cWJMa3lhblpJYUdGU0dFcHVEaEtmU2FFOXN1?=
 =?utf-8?B?bEQvbXpDYVBZZGJ3UW8vNEhhaGN5MVg0S2tUVHBDZ2V5L1k0SjRRcDhtQ2dj?=
 =?utf-8?B?YjgxTTREQTQxVXdYVTBJeXhpZjNleEtacnhBbUhLNkl5QytKUUNqV2o1SW5J?=
 =?utf-8?B?Wm9JT2trRjgrYTB2azBiSll4RHAvUzZPZUNYMHduZkpDYkFoL3UvMGlZdTl6?=
 =?utf-8?B?dFNTYmFpTGdxazkwNHdUZ0c3RUxuc2t6RHczNERCM1BuQTVuRUFEMk0yQlp5?=
 =?utf-8?B?ZzNKY1EvQkFMUGNmR21UWExwYWcyLy9jMHI5cmtHMHlUTEFSSXB2aHpHeXZW?=
 =?utf-8?B?KzdheWlMelhFeVArZnNzS0I0QkhOWGVOUlMwUTFYZHZ4Z2xhdEtWS0EzQnlj?=
 =?utf-8?B?R2ovVG5lNVhaUVJoQzRBWU5ESEkxbjFMcXJQWWVNbDNsSTNBRU1tb0lGM2FK?=
 =?utf-8?B?TVIzRUVyRktLdzV2NG9DaTJwaWVGbFBGcjdYRHFYVDYycXhNRTZPSk1SdnFP?=
 =?utf-8?B?WkRiQWFHZGdPb091OXRLUjAwRTlDbE5KcHpUUnRXaUJlUVJ3K3YzZXZKdU5o?=
 =?utf-8?B?TTk4OHNxTzd6bTJnVmJmYzZlbW9RWFJwNTByMURoMEFYVnRKbGlOWG1QRDIy?=
 =?utf-8?B?YUlDTUlkK3RHaW1aQUo4TXlsWFFRM1RxNWRMWWxMOTdVRjVOamdKUGtRS0w2?=
 =?utf-8?B?b0hTM3JBenVvbWJKaFhGdWhWSEhYbUpsLzk4VjVxcllwQjZPcTlvZ0ZWZngv?=
 =?utf-8?B?R3JGYVJnSXpmQ3RjTk1aSHZackkzZUdUT2NoZkpEN0JJVHl3Ulc1eU1lTzBZ?=
 =?utf-8?B?STB1aDFsdHFabDdDendNNXBLL1FrRHkxaFFzY2h0Qis4OGtKQUhSclYwK3VU?=
 =?utf-8?B?eW5pNit1YW9mVnFMN05FZmlySVhUcDY0ZHZmZmRvRm5uQm9sUmRMaUZpMGsz?=
 =?utf-8?B?SzB2VmVjNjZRaDVjdFpjNFJEQnhsRUxCR2w3L0RWQW9ZQjlPOHpsT2x0NCtq?=
 =?utf-8?B?ek1mSThYOWg3dEppYlM1L1ZPbnhmTVRSK2FJRkJVb3BabzlVVlZyNEkvazJO?=
 =?utf-8?B?bWIza0JNOWtqbDlSZjUyZlBBbVB5ZWpuTS9ncTBYT0V2QUJJR2tSRU1pNVYz?=
 =?utf-8?B?WTR2QmFnZ3FReTJqRzVQTlduY1IzZU54UEs5aENkRGxRdndoWFdOQjdqWTF3?=
 =?utf-8?B?QTFOOTBTSytTejhxYkxwNTNYbTMySGppSVN2OWF4WDEvandBSk1aQmRLY0hQ?=
 =?utf-8?B?N0RzSEZ1SGEwaWp6ZS9iYzZvSE01emVmNmJ5QXNFYXE0VGhpd2NWQXc4bkJq?=
 =?utf-8?B?VEZaaHJDVWxTVk00ODA4ZFg0MWZOb1NMS2NramJKM0JvaUxuV0FPWjFmRUMv?=
 =?utf-8?B?K0R1MVErMkt1aTJiK1VIdlE1b2doRkpGbXBnTGRWcTlEbUJDYTVIclRrSGly?=
 =?utf-8?B?aGt0Q1NKQSs5WjdDUTJRL1N4L1R0MWY2WExaMFVaK3RCVi9RV1Erd09IUEY0?=
 =?utf-8?B?cmV5b3ZVOGh6WXR3Yy9Cbm9LVmVDaGFXYXhXdzJhRW1BdVBDd01oYlNQVlRU?=
 =?utf-8?B?U0FzWnJRQnRTQ3c0bWlTam1hQjV6VEdQbUhCeHhVY3poSzY0U1JWMmpRNXRV?=
 =?utf-8?B?ZTkrMzV1b0ZvT1RUMUdxenNIMUV2MDg3ZjdNR2NWZnV6OGJrVklrd0pJNTlL?=
 =?utf-8?B?SUkyRi9JbHZJY3JIY0xCZFdIenN6WlRIb2pwMEQwMkpoM1owK25sc01jZmtY?=
 =?utf-8?B?OGZXby9SVmwyZk9QN1NnWG9pRjVRZ2JoU2VQTEU3YWJhZ1lrL0JRMjVZdy9n?=
 =?utf-8?B?VGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a870d3-3dcc-46ad-d5da-08dd31401c6f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 06:29:18.2397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VaBEjDb9CN1ifPccB5+GFmejtnZY9/APANyvGGAe8Nyy7jOF2lvzW9hgMkqypDl5y5sKLph2H+4k+3E2WxihkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8950
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Jan 2025 06:29:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17522

From: Jan Kiszka <jan.kiszka@siemens.com>

It is off by default.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .reproducible-check-ci.yml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
index cd518724..59fc2164 100644
--- a/.reproducible-check-ci.yml
+++ b/.reproducible-check-ci.yml
@@ -14,7 +14,6 @@
   variables:
     use_rt: disable
     deploy: disable
-    deploy_kernelci: disable
     base_yaml: "kas-cip.yml:kas/board/${target}.yml:kas/opt/reproducible.yml"
     release: bookworm
     # This target include base + swupdate + secureboot + security
-- 
2.43.0

