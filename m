Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1765C7619A
	for <webhook@archiver.kernel.org>; Tue, 11 Apr 2023 08:25:10 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.53])
 by mx.groups.io with SMTP id smtpd.web11.8748.1681201506587061085
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Apr 2023 01:25:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=bfMb+kSj;
 spf=pass (domain: siemens.com, ip: 40.107.8.53, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwfydTErxsxvHyolzT77ndKmYwK5vQBypmBxKU/vcuDM6SgOViOCnxLuP6Jul1MD8tOxRH2J53Enx+wF43hP+2E26ZWRq4GFBRVRqnUt0JmcQF6VVkZeWqGe6I7Yi0n6041pci9Oz1pVIvZsTlBmjwQIHSCXeCHI2AuNQx24qPqtoMR/GYr8/2Lc3/Gf+kDkfjlOBgptX2MQmgiOBSxuQ2oOzmb1Nt1VOLt+awQusbQOoY9tdw4M9ILBM2iGcrOZO8Kbscs+sckUNb6Y+c6lqTelDFMseOnIu+GjaxJHqQVI0fxzI8BYfxO8gsIIL20icwgu/8D7PMnAo6KGmHsY+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GI8vrnRDIdc5uGEcslm9pT/Z2Tenxu7xV6B392I4MXM=;
 b=gf/jqRRHMnCcDiIttOlWRBE2hYJ1Kgg55cUX8HvTxQ8Ddwo4nnOweH9CKt5BfCWgX1IhGHePOFcYhYHdQdFm/E1SqTyI9dcTKxzrVn33GTiC7wXCAuBvULcJmfMr0VsUnZUsfHoI19Q+2NN+xbQ/msIoWFA0joHym+2TnVdSaMUcpnJ8JRQiC28dcxRR4fivLRBs+BvH3bFNojIZRffy8dvRlRvkT0md2RmP8ymQ/MVC0nZgS5UL0Fwa4i69/u5a9xqtU0bSdD51+aO7sY/wSNyBFsBI1PcejciYGuHT3Cej0eDEvJkOfGT46cEg3gTlEUwn4MRhshB4HqAREezo8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GI8vrnRDIdc5uGEcslm9pT/Z2Tenxu7xV6B392I4MXM=;
 b=bfMb+kSjtrNb7/9ZKYtQVmIgybJy3Y+iKKx3b6M8wRMiiw5BGbtmz+cBioQgMaA5O8DbVXgPn5sswK0bH7h4qHom2/NRAEcKmvg4pTSV/HgHrw7Zxh402NM2Dp8Wh7srp6PoHX98U6W2sTPHHRI/NshcfNtm2LdwiEqh365fB50X4IJh91OH7EnhzFr81IYRxUljkjCr8MpdzysDFlsLkzfyI7t2XfUtRYs0bjDNkK8fw4snQKsxvvh0yzzGQ0IKyx2cqCqLwVUGVnstF4VsOibd4V1O6C9SE/I5Qw/an21siyib0uqxmx7379Vq0lVABulTygLM0iH5DcSwoAFNJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3458.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.28; Tue, 11 Apr
 2023 08:25:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%5]) with mapi id 15.20.6298.014; Tue, 11 Apr 2023
 08:25:03 +0000
Message-ID: <11c7a50f-4582-9645-ebc2-2ff2c8422454@siemens.com>
Date: Tue, 11 Apr 2023 10:25:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] isar-cip-core v1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3458:EE_
X-MS-Office365-Filtering-Correlation-Id: 71678067-261e-4a10-50ee-08db3a663fa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	V7hXNH0qR5MQmHOykHwHC85MZHs5BHT59JAMFKZx856eT9KStPoStc7HCBIqihWUJqZK+MUA0Pbc24ihI7QEGnt9yr16xK8M/byupvb/OGnBqS6sqaRhZh8xiN2w98WHCHJjbKZ2DA/CJXUYvtJ18xApPkA/rt7hO/w3niS6PkG15mQEw5744OdrvE2l4EydbRP3MbPV85JPzOr5d7Fg/GVNi1YezyFDkhAVssrIEp0m5LhMR2CEp/FQSP+MxBdspirXuEWs8Nt9hhByiZjI+yJ/a5JE4Xsnn0adyB8zIew6xVeaLujT8sN/AoaEZKBCyCf+xRpn59ltqhAem+cAlpy+bIh4jfoC4xiUJt/x17a0zYodT7MS2NyR4uc/mvOqvLUxMSS94jfkmEPLDRM6HxXfbFOpq5Y6de/GZNrgba0pRGNngFABji7WCKjIeWxlCisHdUO6KOmYF9NclfWxbtm38iDek+sxzdBzOV0fscYqaiinfl9jMe+R0F5IaibLFISc1B7IEJAAiziP8txm+Yam/dTJ04oc2BSnWagmVNL9onNcTgHIgLVM/v9Qz9naUbSxmkk3hFzKm2myTQEtV1i6eW434e8O5RsPOPORKZ77KAJ+rwAxLD5Xk6b4Rl9Ciqe5XTyG9ot5vk3yzppAZA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199021)(82960400001)(26005)(6512007)(6506007)(6486002)(38100700002)(2616005)(83380400001)(186003)(8936002)(8676002)(44832011)(5660300002)(41300700001)(36756003)(2906002)(31696002)(86362001)(478600001)(316002)(6916009)(66946007)(66476007)(66556008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N2hwd2NZdWpKZ3lSMUxiNHZhdGZYbnVkY2ZWVUhEbk5rb2JJUVl6ZUdOdXE5?=
 =?utf-8?B?a2dxNEdQVk9yejlST1dyOXpkQmtKZWNJUkhjMFVWZkRiNkxLNllPUlhLaUtV?=
 =?utf-8?B?SE5FQlhLVTgzMmpneE4xMk9hTVVJR0xDQytKb3A5eElnZjhZS2xzWkZxdDRQ?=
 =?utf-8?B?ZGp5RWZQT2JiOGdjNHZkNkluSStWRm1jWURNOGZhVnl1TUZaTGEyVGVNZGtm?=
 =?utf-8?B?U0tjbm5MOXFQRjFBVGlVU3dWU2VCWDFtUWRYdVFRakliTnZyK1JzNnpWcHRq?=
 =?utf-8?B?N0E0aUh2cUxoTW85T20xcExNSUQ3VjRLSnB3eVduaWVsN0FIR00yb2dvVEdV?=
 =?utf-8?B?V1NpT1VlWFdKQjB2eGJOdWFLUTNDTG92VTh5NHd5bWlseE1pVWJNNlMvd2Ur?=
 =?utf-8?B?UlNPSHhqTmJWdGZCUlEyVWFsUzNpc2RCL2RocURYRFhFck9OaXhqVm9VdlNG?=
 =?utf-8?B?Q3pyNTBmek5xVmZCQTZONG9ESWRKVU5obVNILzFnM3RVTHZnS1VGQ2RYTjMy?=
 =?utf-8?B?RXFSN1RxYUY5VG1icHdRUXQzZzlwZ09uaGtrMmY4TUxoSWFRajdpTFhYVTVW?=
 =?utf-8?B?RjJSWUYzZ1czTEMvY2N1OUlYRndYYk1RUjB2NGdwOTNpUkEyVkVJbExEa2JK?=
 =?utf-8?B?VjZSL01VTXQ4UFFwTnFDbENxa204WDRkN1N2bVAwa1IyQmpBSXJyWGFUOFhm?=
 =?utf-8?B?SDZKVkxTTm1rRW1Wc1dHaHVtWmxhbkdEd3FXemVndFk5ai9RK1BRcWlaSVBJ?=
 =?utf-8?B?YUlBeGR5VHoxMC8xTHoyVTlMcHJGL1ZrMU5ENTErM3BYc3d6MFRnSWc1Mmwy?=
 =?utf-8?B?ZG5VaW1STDJ1aFJqOFM1S1NrcGpkeUhIbWVjZHBaNHdhRElVc2FtaGZwRi9P?=
 =?utf-8?B?ZXd5bFYvVllMS1dZaW9LMUo4UVlXUE93WXMrM3h3QjVYRC9lN0xiaTRKMEd0?=
 =?utf-8?B?aEFhc1ZqcXVxM1N2U05JbFN5MUJBME9YNHdzdjBRd1ZmcFN4UUVDdTJ5Y24w?=
 =?utf-8?B?VjF6ZmF6alhITVpYOHR5N2FFZmtzbWpxcTY5ZmFiZVBBZXJBSys4ZjRlbkR2?=
 =?utf-8?B?eEZqMTE4Z1VNNVZxb3h3VE4vdmFhY2xZcGtIeDg4SmZ6MkxheHVSWEF2eUNk?=
 =?utf-8?B?aTc3TkFwMEkzL1RLa3hqTDhTT1JqNE5NSGsrMGI1RlVCLzVnYjFzNU85YXVw?=
 =?utf-8?B?YU55SDIxcDBheFZSUEp1RkpLZkU5L1R0QnRldDY3eW5DZVZIZzg5U01wYzdT?=
 =?utf-8?B?ellZd2xCNy85eExpM2I0NUhkNUVkdkJMYWFkUHNvL1ZRV1pwNi9PcFByQnps?=
 =?utf-8?B?bTRxS21oK3dZamZQZTkyN0dCdXQ0K01wUUMrb1NyUHV2L05vaGNadWszMXlY?=
 =?utf-8?B?WHBNY2Rvb3JobFY1a0dROVEzVitjOVBZejUxYkZ3aWRQOFhIRGk5WkhEOStl?=
 =?utf-8?B?UWNwLzBsZ0xWV25hV3g0Q1FpcDh4eVlvazFtR2FFblJaSlRzMU0wN2MzMU9U?=
 =?utf-8?B?b3NscEZldTdLb0REZ0poN3d5dTlrbmZvS1hZWTQralNiRnl2VG93Qnhja0ZL?=
 =?utf-8?B?KzBDVGU3U05CNTg3alR3b3ZxWk14ZTNmcVFlU1RVdkUwOUZCanUwYnVoZHBR?=
 =?utf-8?B?RmR6WUhCTUdCUmVXOWF2RGRVeHBGY2htdjlmV2xQMHN5UTVVZ1VlY0tVaHBa?=
 =?utf-8?B?aTBMVDdyRTZaM0MwOGVKdm1zeDRIUkxqY2Ntdm12RmlCVzhPd3JJVjg5ZC93?=
 =?utf-8?B?emhxSFo1K3VGck9HTGRMTXNiLzRyQlV0cjhXZTAwWUwzUVZoUUphZTVDVUY1?=
 =?utf-8?B?d1lMYUxhenZ6RkhvRUQ0aGxPbFhaYjNPTHpvOGlyeVp2SFF4WEZFaXREZllI?=
 =?utf-8?B?ejdaejVKR3hGdytWOW10RnRLMFlnUWVFbi8yb2dxTG14ckhPZXhBRGtrT0dX?=
 =?utf-8?B?RWtpaDNSam0xbVl4cy8wUytIWnVETTV1V0VmQkZxbkJnMUVvVXFhNGxyN3lE?=
 =?utf-8?B?V3pKT2dsbXhyWFlxclBHSWhpS0wrczlqZlB5M3MvU3FsWW5nczZHZ1VPeW1q?=
 =?utf-8?B?L1JCWEZUVFVXbEcxWnRzTzhJYVdqRkJmUlUzcUExZEFwOWNQQjB2T1EzemFr?=
 =?utf-8?B?azVBM0VkQjFXSFlEdjN6UGZxdERJS25xb2RZSXE5dUkyeE1kUlBRM0JrWEp0?=
 =?utf-8?B?OGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71678067-261e-4a10-50ee-08db3a663fa8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 08:25:03.3912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cm2hXN31u3Zc8kW5hKV5Q+mUPe8hTQHZGJd1dWpThNn65L2dRTXnYIaG2e65q/5Y74r3l3WmQzpy/LnGGG69Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3458
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Apr 2023 08:25:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11191

This is the first official release of isar-cip-core!

More than 4 years ago, this layer started with the goal to model the
Debian-based CIP images according to the generic profile with the help
of the Isar [1] build image generator. While the first commit only
supported the BeagleBone Black, we now have 8 targets for 4 different
architectures. The user can select from 3 different CIP kernel versions
(plus an upcoming one), with or without realtime, and from 2 Debian
releases (plus sid-ports for RISC-V). We have support for SWUpdate
images, some also with UEFI-based secure boot and encrypted data
partitions. Moreover, we and can add security and CI testing extensions
to the images.

Looking ahead, the next major step is adding support for bookworm which
will also allow us to reduce some custom packaging again as Debian
picked up where far isar-cip-core had to fill some gaps.

Last but not least, thanks to all the contributors so far!

Alice Ferrazzi, Chris Paterson, Claudius Heine, Daniel Sangorrin, Felix
Moessbauer, Florian Bezdeka, Henning Schild, Hung Tran, Jan Kiszka,
Kazuhiro Hayashi, Lad Prabhakar, Michael Adler, Nobuhiro Iwamatsu, Peng
Qiu Ming, Quirin Gylstorff, Sai, Shivanand Kunijadar, Shreyas Karmahe,
Srinuvasan A, Sven Schultschik, Uladzimir Bely, Venkata Pyla, Vijai
Kumar K, Sarath P T

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

