Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42963C71153
	for <webhook@archiver.kernel.org>; Mon, 28 Aug 2023 06:42:17 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.45])
 by mx.groups.io with SMTP id smtpd.web11.8117.1693204930379698053
 for <cip-dev@lists.cip-project.org>;
 Sun, 27 Aug 2023 23:42:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=AEA7sE7m;
 spf=pass (domain: siemens.com, ip: 40.107.8.45, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DlJ/vY0YBII2L5PPUB44365NcyF2T/qqKqhJEsjkz0hjTwVnEOK9UdYl+QNy9QIgckojDtwJvfyJh1oBKPHJaGXmGGRDr/D1SNaD6S7PeHjK/PLqR3Kkkwn7zIBMlRjYzptRM29kKhNzGEBzgIthoqyhRQERrciYLvRQUzl24GCccv/FKws0Hp0U31kOlzt1cpsSbdBoArNh90lPnXDAIhoPewQqN2eDP5LhYZ3a9GM0wn3cnj6DTKR80y34Hmv/XjC/xG0Z+Tzgx5idZFEkBMfH+Vvt8VkTX+1DH4HIvrAMNcLQO7b0E3jXanHdY8RckRimJcLh3/a5yM8Zw/qYag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AZkxPz986piB5jGniJsQK+CD0f95j4BzFC85OdPaOc=;
 b=evvtJuZZ2flI/8gR3l7TFAGDIG9Gub9Cy/zhtrMzApBgfMQMeAOpJd1/0Xe2MXafIw8eJSt2u07yZ/HjQ4rT4j/KOWek9VDLoOm+ybB9XRQYGlVLo04wT89ecZ8dQmOF+KmiKuXjrxB9B6bzNWNpqfNTgHz37Tov/SGlBvhTluVXWZYUlS8xVXAAEqYuwv2E59r0IKY5WUJNCvhWwrJ5T55iv6mtHiD0F2JYV3XuQ+UNZJXdxSzvi2KTc+wyU8zsYhzbApgNtQs+axdKizLdZryXM3ZfDuNQuFntbqhkmQ6BCKQlqeu8THpFrHbepUgfOGDzyZbFyiG5nZZfokQ4Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AZkxPz986piB5jGniJsQK+CD0f95j4BzFC85OdPaOc=;
 b=AEA7sE7mnHkao3UJIb58g6Iu2H8CUlIvj7N1xo298SNkZjpRCN/XXRfLrwRNtZV+fQ7g1C3kAd1+bIjvV7HX5s32EF+WvWTBO2Bh4iWGy/wJSiFurOE7d4YZL2EU+l66/Ft91oqW37Fae5LsHMFSXwFzUeoazAf8t7+RkunBBp07mmOY+ezf9tIWWduDsTs/y3BzQcUDYMPaC6SjOKzK8bpxl0NAkq5Ci0dGg1Ab6P8MRlpAoXLudIt/bTBHVRO6qVY7hN89pV7kN1teCLmZ1btrpj76MHsZ8QblEWh8bEUGgindoPal0MR1rsVmIOkzHceW2Prmdh8s42x5sintQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5401.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:336::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 06:42:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 06:42:07 +0000
Message-ID: <2b62c2f0-b763-43d4-a379-b278d8daae2e@siemens.com>
Date: Mon, 28 Aug 2023 08:42:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] linux/cip-kernel-config: Bump
 cip-kernel-config revision
Content-Language: en-US
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org
References: <20230823021701.87071-1-nobuhiro1.iwamatsu@toshiba.co.jp>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230823021701.87071-1-nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5401:EE_
X-MS-Office365-Filtering-Correlation-Id: 566d0924-a0ab-4303-1d9a-08dba791e5b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	SU1PBVhV3j3DQnUh6wZBdRxv1N9KosySUpbDJ325+3Wc9u/eZk8Z6v0+ZaHvd95t4KDrfgozlGvkakkK8+nYW+4TlWKsZnVUm4u8EPOlkX3zn6R68ApNcVQ5Nx2QrSmkOfHRDjaV9lNP/vZQb1tclpmoqVRWeDMSGTvNKmn1gsUfnGmPqJ3FbFLy8jpg/c4VZXCy3EJI8a375u4qkpHFP1naTbxx8SB9neXZH+X6Elt/+xaXrvy608shASsrB+yRIF+yjZ6iTOtK39lKWf7OqQQPzTvhe1XDg/1pHkdhk1okVQvrJkhyPhA9W7iOYAzArpqD3ofqp7IOzQtZIA7mjoE/B5B894k8ohyJAF0wuPRwI43M26w8x+Diyn4XKR5y+k5V3iLe5MDculixX60zaCeFsrJ0iWoldYgxNiKEsGTWmLJW4zZCzf0r9ID8UeXiQqp7OKFDR6ZTQ78z+OJ+39Jnuz0j2Km4MF+BYJa6XNQNV5Ur/3Dpd3P7QH2j8kWW8QxGkjVqbjEMFpYnlAR8Izxw3lXeFpldicWrEEE7Qz7X96jF7wtJXCkb/bKl3H4/5WWLNXCl7xiFUx5ynoLaVF6KDK5eKZpfh5wp+NkEX4jbgbVjqsHt4Jwk2fuVEx6hwEygJkK5v/9UTSOEybt1rQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39860400002)(186009)(1800799009)(451199024)(2906002)(4744005)(5660300002)(38100700002)(4326008)(8676002)(8936002)(44832011)(82960400001)(36756003)(31696002)(86362001)(26005)(31686004)(478600001)(6506007)(6486002)(2616005)(6512007)(83380400001)(66946007)(41300700001)(66476007)(66556008)(53546011)(6916009)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aW9NRFFXSFo0dmFJdXFDSG9NczcrTEFPcWppeENXdWxlWE1CblhEU3pRdTAx?=
 =?utf-8?B?WHo3RVIzY0pEL2dPUktxRnhxNk1BdHlteWx6TDU0elpKdkpzckwwZjlZKzBC?=
 =?utf-8?B?MmtaM3hPcHVZSEQzUFpRM1A3YjhoUkZHZmdLcUN2M29MbjBTQWp6MFZQK2Va?=
 =?utf-8?B?d0wrUVpvN0FNbEREZ1g2a3hXZzlaOVBJM0Zxdk5jalFxdWQ3bERhMUlnZWFC?=
 =?utf-8?B?ZW93QlpZUkdMQ3R5bDM2RjJQRkxIaHJDa2FPQ251SXpqVDNZRTBkSWg4THVx?=
 =?utf-8?B?a2VoSjR4ME9OTWhNUGZBTWdIYUQwbmtZbmhOVlhIZzEwKzRqbE9iVitvcjBS?=
 =?utf-8?B?K3k0Q3NtcGdadEg1bGtQNks1MmZ4M3hGdGFuQjdzSE9zczVLb3BUUzdyVW95?=
 =?utf-8?B?QkdQVHkraFNWdDhNT2ZXbFRFeXpvSU1udzRHaEdiYVpXT3NNcndTc2kwVDVo?=
 =?utf-8?B?czBNSDN1aXBGbmlTMm5FbklQOFEvRWpUVGFIQ3E0OFUyR1l0eVBVNmU2cVRT?=
 =?utf-8?B?SXpEalYzSlh5bHg5US91RDMvR1djUzBOZko4L3lFTHRjZ0doODZuVzBXTEc4?=
 =?utf-8?B?Qm4vbnZVRjZITGJQZ0JrREd0bXZXeUkzQkhtTU1UQ1hyMWl1TGUva2ZWWjNo?=
 =?utf-8?B?NXkvTEtETWVseWhsaG1LeVdKUUNHRk5obUFaYVdXSkdYZkZqbEZMMnFyQTVY?=
 =?utf-8?B?Y2tadXBEVElVNEtOMWl1Y3VXTUQ2VnFHTkYydDdHT3RBNnZTdlFPSjBieS83?=
 =?utf-8?B?eWh0b2tnUXBxRmt5L21ISlZCT2k2Q1Byai82ZEVaWUp3aG1EdjlrR3lOeVh4?=
 =?utf-8?B?TVl4c3pqWW9MR3hvVXVMYU1la3VpdXFRaFl2S1orR3IxRStkVm9lNTRmUmh0?=
 =?utf-8?B?RDRobnI1RjROTmVzbFIzZlU3UDNUejhGa2pab3hUdzYxbTBaclBUaDltc1Vi?=
 =?utf-8?B?T2pvK2ZMcytFcmdBajlhWmlpcmVBSXFQK1ZnMzd5ditFeTRwb3oxTHcvSU5v?=
 =?utf-8?B?VGEzZGFZNHF3empNMGdrd3pORkdQMGpFSXVabDFzR1UvbVp0RDNSMG5GOW93?=
 =?utf-8?B?K3lWd1BCUVR3bG82K2NDdTRuWnhyYzg1ZVpaR0RkVFRWc2pGMmRoR0NqdWEw?=
 =?utf-8?B?UTdXcVpnVkdmMTc5Z3lTbTl3UlVIMTNPSi9lQ1RBYzdibUl5dUpVOXN4d2VG?=
 =?utf-8?B?Z2FONzNNd05TQ0ZKV0lMRS9xMVBITlhlNW1iZWlXZVFsSWRzenF2TElNckpJ?=
 =?utf-8?B?ckVJbGlwMkpoRzJQSUFsby80TmIrUEJVNFcwNGhxMnUvVldQV2Exb0RUM2dN?=
 =?utf-8?B?aTJ3d0hNUUk1V1g0WCtKK2hNQTkwQUNwMk9zRUpNclRuRThzQTRvcG1waWlO?=
 =?utf-8?B?ZEp0VGNFK01CRHdVMnBmMVFnc2ZRcEh2TXB0TEVnZjVzMXZtQmJhZ2kxcHhQ?=
 =?utf-8?B?VmNaSDZoTmE3Yk5NcmVEZ1p2WURQcGtRMFErbWprNnAxbkRBVTVQOExCTjlm?=
 =?utf-8?B?dGFiTmJpMy9tUXpMTCtscmQxc0RBNnFPT0JWSWhTQ1daOTk4c2YvTkRqRHFl?=
 =?utf-8?B?dHVxYmE0Q1V0K2p1WTVsSStGWDBLZXUzTjEyaEEvL1d0L05oa2JYalJ0eFV2?=
 =?utf-8?B?SG80MVc0MzBEQURMV0lOTG9abmpFUFBnWEtYcmZnZmE1UjMydHlicXJaU2lO?=
 =?utf-8?B?elpZNk82VUhsRmgrQnB5WFFycVFyRUM3MUYzNWc0UkEyeElDeWhnTkVRejZ6?=
 =?utf-8?B?ME5mV3NlVDlKS2JZalFRN3RSbjI2U2FvQkVXRlBJL3ZXdVNGbEdsMXlzR295?=
 =?utf-8?B?Zm4rcEVnQ2w2bUd5N0NYeVkwLzJpc25mNGdUcVN3TDNMRFBBaytxTy9LWFZ1?=
 =?utf-8?B?UGppWVhIRExXY2xvcUNnZnVKL3V6UGFmMWl5RkRCTWFRcTZPL0V4ZWYzYmxT?=
 =?utf-8?B?NWVMUDk4Rm5zWWQ1WUFpUVpZdlRuWkIwYWhlbTVBcllZRVM4V01VbSthOHJy?=
 =?utf-8?B?cGI4WStEQ1dicmhaWHBjVktPZHpybGFpcXlKQWFoWGZSZlVoYjUzYjY5cUZB?=
 =?utf-8?B?MmYwdXJ5ZzhQNVNtSm9rdnh3ajVWYUJwT3JIQ2J6R0VJbnJ4Q0c0ei9KZjBj?=
 =?utf-8?Q?NjR52QBMe9k4mbUTrCTxrT5Ss?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 566d0924-a0ab-4303-1d9a-08dba791e5b9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 06:42:07.0867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IcDVX1p0J9g+a2Nk9Ilrz22Y65XXse7M5MsEtJaFpzNZpBdt3F3WouY7fDm+kEvkVZoi6JPXglke3rk1mvkQrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5401
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Aug 2023 06:42:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12875

On 23.08.23 04:17, Nobuhiro Iwamatsu wrote:
> Update cip-kernel-config revision to latest commit.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  recipes-kernel/linux/cip-kernel-config.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
> index e104200..51b17c6 100644
> --- a/recipes-kernel/linux/cip-kernel-config.inc
> +++ b/recipes-kernel/linux/cip-kernel-config.inc
> @@ -14,4 +14,4 @@ SRC_URI:append = " ${@ \
>      if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
>      }"
>  
> -SRCREV_cip-kernel-config ?= "a28b7a678418287b12161975fe8b9b04a3cc8c88"
> +SRCREV_cip-kernel-config ?= "aca5978b5abf93b20df4efda067c3a3f461476e0"

Thanks, already done via Nguyen's patch.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


