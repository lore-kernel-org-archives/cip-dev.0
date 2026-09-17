Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAC3C982D0
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 10:11:46 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.5])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.35743.1789639899183942991
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Sep 2026 03:11:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=IfAXeihQ;
 spf=pass (domain: siemens.com, ip: 52.101.69.5, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qu25nvAHjcbngfhTdyHSx74RjlcBo+1PAHVZ4BONbKkZEckxaRySEjla6K4C3L0/u9QhrQDYH9e4ZprD34IqZdLXKwBbpWsTGXdpCnozzkKkESpforzhAbjYpZ1Qs8RWafE+GCl1HiidgTfslByWe2jC5se+cXbL8skuieuWAZITFnQMyk4GZET0zgMQZDjx3rmrN4u8A3N7e6pUH8ew1PfZZWfAKbdd1dwwQ2k7NlEesKGuBG8hTzSZmktF77dGe+eh16++l1/qFqL3+pOffLwf0Q/qJUgPoa/CkFVcwzGSOb5NBEX8gEa9JkqhpfYbjRJvN83tEAUl+jn/y2GYIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOtZ/Ba3gD0dFl/dbB4X8Sy+EYKdx1I5ThXLr7v+WKQ=;
 b=DvMK72nMah2NRn3ns0vJnks/wVsVwHo5H5S0DwdNY0gUKHXz+ue/cZJRkE49EO4OUOxo6bWDqldVKAgcjSCKjmoOEZEumNC/FCuZoiuJ7bAus+o0AgDJGU9VVFYUw9yLqa33tebwM+iKBEhfbvZXTryOvfOYpvk8DSS04ErMV+kmMdfCc/AUvXlebaa461q+cvdcfCPLhJnzYJvsep9RZTYD5rKKeZyi8+f4aHWNvGdFdHTPpdTmZEzPxMGiCJV3W1sLv9xxdrX2xoKaC3DavUaE04zVD4UJpWssZ4Z21qQGBHBNuOxhO/qr34UYNpzaYTACC3cry21Bpn+jDoqiVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOtZ/Ba3gD0dFl/dbB4X8Sy+EYKdx1I5ThXLr7v+WKQ=;
 b=IfAXeihQAmDTqik80S3v3Wmls/58A4yLPuO3x6ogkJDrqC2ThOQyWebbbeWeYZPtRtgaAQb5dZgvwk4WJUN5RFZbmIEwBcabmW3yWPLZd+EWdfgRUugh0Lz71tjgaWbm/MGjgzIxa/LHFpWGHeiCHCNeOAs5hwLDKHKZgKexkt9PN7c86OVY2eTTW/bHonGK8vCpuF3IOpxcJABugWdfht+kQNnJ06ANHn8i0Ha9njoCsXEP+4HEhsqD/PT9oYnM144xSCr2cpmbofMxs5tnf2oAkcK9UNYjulsN3Jb8uAxSp6UNKK54j+XSXGlab1F3SJXwjie0H0nnqVNSEFp7RA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB071704.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:80a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 10:11:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0428.008; Thu, 17 Sep 2026
 10:11:35 +0000
Message-ID: <272d0de6-7827-4cdc-b886-8003a966e41e@siemens.com>
Date: Thu, 17 Sep 2026 12:11:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] remove do_rootfs_postprocess from task
 dependencies
To: srinuvasan.a@siemens.com, cip-dev@lists.cip-project.org
References: <20260911025945.739807-1-srinuvasan.a@siemens.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260911025945.739807-1-srinuvasan.a@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0311.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB071704:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bf0d756-ad4d-400f-8b9f-08df14a40dea
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|56012099006|11063799006|6133799003|10067099003|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	xT9SutnDbDp3WOmbmm86RfBQTBS3GrkHa8dZELA8OKa8OPzCGxl69RqycBKL1dt5ppAnvbMmUvXoEoNBqxqaoqm/hzZXeJqjicaDFhCis6knt1LMLrwTZ0Q4SePex6QAPinX6cb58ctSabvuApLTx4YzVGhUHzNbo4FzDy33a8FOYGHDPrjoV8lapE2mPizvC3F1YqXcWag/40wBdDg8L8He54SDHWc7GugI6nXdD+BqLpySoYdZ+8p4QckpGfFb554VXLzYtQd9dgmCqRcrwQXQNCVXJ0J3/vwRxiRQ7oWoDdjhWas8yjWnO23baDQ6DIMHBjgJCSwUTNN62gLLK6TnhdDWOGuw8MNtzoZ78m+t4Rb+hi3AHGG+yD1dGehw+oDfKGpC7FaqSFPPRoQLY/jbXa2BGp2Dl3327t73nxwb6guMHj37PRH5ytgx6Nvq0q4aLrMzFKoaIV8pLLkNyMJE1J9h4uyLfg+pQYPlHJdNS67acgO7Rm1gdZgmhE4zxKExhtKWPLqQlyTJpoCRaa9bwqWWYpYebLqpV6m4pjhH6kf1Vzh6e6XseGauR1hBUqwjsZu8j5Jdz5AFzqD6eft3TXCvTgpynBoskNVeiE/sZkeDV5K6cHP7NiR44fBDmg861CZnRRNAMdWpaijmQk/emJ9wpgeiSqVhHx7Qm3c=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(11063799006)(6133799003)(10067099003)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NFAycG5uNDRKckgwK2JUd1hCZUpDWUZOR2RFcHlWQlg2YlZVMnl3b3NQUVdV?=
 =?utf-8?B?VWxTcFcxUzY2Tm5CY2pMRTBjU1Z5dmR6aUxDb25vNTg5UmRMZEdsR3BMeFkz?=
 =?utf-8?B?VWRxY20weEtXNjlQL3pNbVNjS3BKb1h2Z0lBMDBOS0VuVXlBNVhPYnhkYWNt?=
 =?utf-8?B?eTZDanNWanNvUDdnZTlzSnpwUWJ1K3Z1OXdtdVhVZmJTeHlxQ2hPN25NOVov?=
 =?utf-8?B?Skt5S1lJRHd2Z0tsUTR5dzZBRzdva3kwTGJKRjJnNDVvM1NDTlE3Vm54UXNh?=
 =?utf-8?B?Qk94V0xoQnR2dGxLL1RjdVF1V0hldGJqay9la1ovMG9TNGdFU05oeEx6Y3J5?=
 =?utf-8?B?eFVLNkR6WWpTeTB1elJxRjVtMkp5aGdRbmwzK2xqaVBzRzI4Z01XdC9WeC9o?=
 =?utf-8?B?R3FKcUU3STVGRUs5eHNxQ3JSYkZHcTBJRmFzNjBQTWNNa2JGRU5sN2FqMnNG?=
 =?utf-8?B?dEVVOFVzVWxSSGI3djJGYlUrVWVvN0h2VzhLMVdHaFlxTFVHbGppQTNwM3Z4?=
 =?utf-8?B?UURGYzdoVEkxNjI4M3pxRDg3eXhvQUEzMGpGNTU5b3FqMWVQR3lZek9qSWsr?=
 =?utf-8?B?MFVtVjVCRlJ2OVZqVmZJMkE0aXVEV1J6a1VaVElTM2J0aDN2WXNuT1pIN0dT?=
 =?utf-8?B?QytpT0ZEbVZnWGtSWXIybmJLQmxKUUt0K0lSQlVFTW54Qms1cU9qTURGQ1pq?=
 =?utf-8?B?K2QybVp3Ujh4cXM0cTBXNjdNVFYwa0xSZ1Bsb1dmUlJpM3pobVVaKzhtT1Nm?=
 =?utf-8?B?ZFJRaFRtd1FRVU5rczlRSXF2U09XWStPb3Vpc3F1WmVjYlU0RVNIdDlqKzJk?=
 =?utf-8?B?NWJza2E4NEREbzBQemtQMnBXQXpyMEw2TUFKcDFqZ2E0NkEvL1lBeVVzOUxN?=
 =?utf-8?B?bDI3OTVReWlBRXI1dVk3aUl4aGpIWkFqRVF4ekdkcjhFY2lMVzJMT3VsY1ZM?=
 =?utf-8?B?VUZTc1NTbzZvcDBjSm1Ga2lWcHA4Tkw5ZkN6U1dHRkg5Rkc5YWNVR05NT1NK?=
 =?utf-8?B?eHcvWHovcDdndHJjb3E1Q2E3OTdtOHpVOU9hQkphT3d0czFqRk5TenlYUkR1?=
 =?utf-8?B?TG9nd2k2NHFSdkpxR1BhWWcrc0JxZ3FmTThMRktSNVVPOHBWRlpTQU9IWTNr?=
 =?utf-8?B?NjdkWEs2cFl6R0RISDRwbkM4bjc3SlFoNFBsZklGOWk0c2YrZy9FN3hxb2VE?=
 =?utf-8?B?Q3N6LzdGQmMxWUlnZlVsRXVuek1YUldQOFg3LzRCZjRrd25MN0gwc3dSVVNF?=
 =?utf-8?B?SnR3N0xCMXFCYmNIb2pXVEh6WXQrTk5Obyt1c2NmRFloSkpKd05EVTNlTCtI?=
 =?utf-8?B?Tkh0ditGVlRqWUVxQ3lDQUJtQnhZMHc4SWZza1pmQitDMEdDdlRUV1lxNk9I?=
 =?utf-8?B?MWRmay9wU1YzZE9xV291N0JYdWtqSXFva0ZTTEtnejI0QXQvWkFVR3ZHVHdJ?=
 =?utf-8?B?elNrTnc1YUJ3QSt5RjZxRWM2ZEZrRDl4SUFaS29TcklzLzU4bGIrMUFwdlg3?=
 =?utf-8?B?Yk9odVZ1WHREbkg5Umg2UE90SnljTElTZ3pvWFNrR25zbHA5YmgrYlpZcDAx?=
 =?utf-8?B?eVowQTQ0SWh1N0FpUGJ0WndvMEhqb0krRHR0UHo4cUpXR3NQTmh4U1hqejBh?=
 =?utf-8?B?ZEdqclFZUDI5RUQzN1A0UXBBMVY1SEc5T2pRT1JqUmVEUHFxbXNFWHgyWFE4?=
 =?utf-8?B?TCt5bDRXMytNTmlvQ2lpdDVyTk1xTXNsdW5lZ2t3WnFmZUZ2N2RSeE50VEdN?=
 =?utf-8?B?VHZTSUZOUHVkdUZRT1Ntb0JjQlJmVTNybTJkejVOaVlrL0E3dWhJcFNJazRl?=
 =?utf-8?B?WFBXdnhYcm5PaE9TMjhXNTQ5WXhTRWtVOC9hSVQvTlBqMEppWExPaTVudXNi?=
 =?utf-8?B?aUh1WExoWmJiZnhJUU5oR2V6Nm1yZkV0ZVVvV3lmRlJ0RHhsbXpKMXJHOTh1?=
 =?utf-8?B?dytlbGFvak5yWkp4TUcvQnc3TUxtTjFYTTh4NnJsWjUvTWx5NUJPMUtWU1p3?=
 =?utf-8?B?b1kxMmZ5VlovNHFCVlRWS2NYZnhlY3VzSmpKcUx4VU11SlJ3OUlKdWd5SytS?=
 =?utf-8?B?VjdMSmcyVG1mbkh5SkN4Y1phL2hCdmlqN1dFOFJnU3hlUlNLSmtleWJhZEcz?=
 =?utf-8?B?akNoZVd2cUVCTHVmSTluM1hUVjh4OE5qZG8wZ0FxZ1ZwZTVrOVJUbS9mVlJq?=
 =?utf-8?B?K3YyUkhVRTk5aEErSjVzd2hzcTh4NmlvSDZFdXd0ZmxKWm8zSFIrVXlyM2Zw?=
 =?utf-8?B?WDRhcFdWMldZVllUaVY4TnNtQkhPZTVCUWJtS0pLbDJCV3huaS9mRlowbjRW?=
 =?utf-8?B?YitnbHNjYnVvT2dGVUE1ZDF6d1hvNUdFU1AwUFpMdUVjSnlPcG91UT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf0d756-ad4d-400f-8b9f-08df14a40dea
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 10:11:35.2500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ul1wj1eJR+4TIKi+hOGXbsNFb4GNdUXi8NpxSNJ46gmF76K2oMUEIhr7YC1z38KcD3Zr2yZBpMQDBIrJrCQ5qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB071704
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Sep 2026 10:11:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24221

On 11.09.26 04:59, srinuvasan.a@siemens.com wrote:
> From: Srinuvasan A <srinuvasan.a@siemens.com>
> 
> Latest Isar has merged do_rootfs_postprocess into
> do_rootfs_install.
> 
> Update tasks depending on do_rootfs_postprocess to use
> do_rootfs_install instead.
> 
> Ref: https://github.com/ilbers/isar/commit/c7a63750
> 
> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> ---
>  classes-recipe/image_uuid.bbclass | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/classes-recipe/image_uuid.bbclass b/classes-recipe/image_uuid.bbclass
> index da54625..247f272 100644
> --- a/classes-recipe/image_uuid.bbclass
> +++ b/classes-recipe/image_uuid.bbclass
> @@ -52,4 +52,4 @@ do_generate_image_uuid() {
>      echo "TARGET_IMAGE_UUID=\"${IMAGE_UUID}\"" \
>          > "${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.uuid.env"
>  }
> -addtask generate_image_uuid before do_rootfs_finalize after do_rootfs_postprocess
> +addtask generate_image_uuid before do_rootfs_finalize after do_rootfs_install

Thanks for pointing out! To keep bisectability, I've merged this into
the last Isar ref update, though (with credits for you).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

