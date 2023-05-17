Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167CEC77B75
	for <webhook@archiver.kernel.org>; Wed, 17 May 2023 13:18:20 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.52])
 by mx.groups.io with SMTP id smtpd.web11.49193.1684329495819507612
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 May 2023 06:18:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=GGHWy4Z5;
 spf=pass (domain: siemens.com, ip: 40.107.13.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPjkuLqTXRuvto+r/EymqNP9xB538Izj1m3JmArfl0owuZHfZ13NwEvHHMODJHTiLa8S8McbHTWw8fGaAj8iBQvHd2fb1tAjqTiBDh6SHlmywqTEghrqK3neGHBcWWj4OfPGVcu/fbv9qN8pbQf/GTQGFGFGRafXj3wlbj+NnV4Sidtnt1ThAhsWQxkOiKEsHYg6NgDXrJ11QANEOLNxG6IwbgUYJPIG28nLEmAeAKiXpEiPU30nHt2uATgLRIEZzKVD+AGJILcbxFahg9dQLT1sV59V5tpU5wcSFGUuFSgoRr5pGoZPndQ49QXTYrsHB2LLEnW1Bi3szkqI1SvmGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VG2xsBcj53DZ06mZBQvyFjx/hjIHxMjOtV8Rc7v5Cs=;
 b=ccWoTOuB0Z0/yXWNIOJN3iLATwF7rj7DFReNOLcfZcuuL4+/ogUFBoK9tH+UQiCIPOiM11DB1rJrh7PqeTgPYczaELKmUfVOJYpwIuWh49yoaGfFa1aNjArgwBwSku5y1mCImMNW/6CLNkLRaltr/7g8IB8DGI9NPiBjMQwhVTatR/3clZb+sfwpubJwMSmRGmW/Zjyb7AsnHV1CJRttep1MZCZD7Zfs5ewxZWKYuiwOHrOH0Oxk3SrgANoQe527qWsea8fULHsCr2SRDJ/R/fmZOnI42xJVpd4ma49b+KRxAC+WxAoqpo48EdJZgkSOXoty9K2NOXK0fgFrBzCDQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VG2xsBcj53DZ06mZBQvyFjx/hjIHxMjOtV8Rc7v5Cs=;
 b=GGHWy4Z5HIwj5ARLqlMfga2JtOXWYmecKFoRZiKmDspwzXeoETLTQAuhBLVPVy/mriz/c7ow7Tzuv66cfaFGmYL6n/Z5IkuQchZ6M33xoT1G1DRjnNszR5xBjXdYpFkMwYoUn9/DfpFLs7tdw+ONd3tE6Sd3KLUpO0aw8KwNlIfXUIMki6GuOge7suygm7KpgXiQokHyIfSCFa0dqOFyID/5dWTO+x/1ramRk7ypjEaaKU4G1SqU1EZvmMRMJ9wywVVFq8LJitDNHPzQ5/kRg89q1/fX+QWzvln0qnp6sUiGmme5g3Zw3pYfLSbF3yiX+vPwMOJC3+NlhIj8LNZCnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7027.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.32; Wed, 17 May
 2023 13:18:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%6]) with mapi id 15.20.6387.032; Wed, 17 May 2023
 13:18:12 +0000
Message-ID: <ff5ca928-ae7e-ce92-4d87-6c3eb4203fbd@siemens.com>
Date: Wed, 17 May 2023 15:18:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [isar-cip-core][PATCH] Kconfig: disable RT selection for 6.1
 mainline kernel
Content-Language: en-US
To: Srinuvasan Arjunan <srinuvasan_a@mentor.com>,
 cip-dev@lists.cip-project.org
Cc: Srinuvasan A <srinuvasan.a@siemens.com>
References: <20230517125502.1516580-1-srinuvasan_a@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230517125502.1516580-1-srinuvasan_a@mentor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: 1979d497-79a6-411e-7fc3-08db56d92a1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Hn65owrG3dRooobIqj6hDRndVAzqgwKR7jU5xncFexE9K4aiTCeIjWA/Qj8AFEg/whv+yEqsPYEYMCkernP0lOh0+Q1tXRNe5CSLd5tca69XLOmcrUhHdv8RnD/pkeWE/8MKQ6w3BimIykM94DAPqqnNAuByGPWerVNj+ar1JroFEZEIdfGSaeDm7mYVxjiPljD//rsIR0O6lCdUBVj3OFpXFPNM0DPETwnmgcoDsKZGISZDlZ4cjk11cSY75Kp2dgOMxvlQhcOjUX8ZmEz2cTQjQO0+XWRo3nrpKp2byejaAgNzTFL8Dqb4p8nm+NIZGnUjGovN/CfCfPM+Y+52bGAVxS2RbRRGocNpUx8xp/2lye9jjKhak4HPCQktV5qI1qw5ZgtfPh+o5Y0SB4KaWbUHhYAuWIlZzRTB173cXxxliguPoaNFOkv2jO6RRnctG5ZHlNrHj6Xb8NVG9lu5qnru3XNtciYdCN/ZNZ5z1qwFuOBXBpqaFOaJWv55K2i0v7u7rxQRtJ7ijmLANbmmsl47Kwa773tkJd6MvVCKGJ1AG/jKgUr4VHfU7p1D11gOxIRUiLZodeILo3xW+7EOwdvcElV6gOEvTYSj3stxtd9AWIE/dxfZFJBUNih/rdYtxyOmyNI4p4dI9itmo7hdSA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(451199021)(66476007)(478600001)(66556008)(4326008)(66946007)(26005)(107886003)(53546011)(31686004)(6506007)(6512007)(6666004)(41300700001)(316002)(6486002)(5660300002)(44832011)(2616005)(31696002)(86362001)(2906002)(4744005)(8676002)(8936002)(38100700002)(82960400001)(36756003)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bGpIaWdRN2tnbHp5bzBOM2wwQnRnaUFkRHg3V0hoVy8zb3FXUVRtOVQvQVo0?=
 =?utf-8?B?WGxjUy9rczFHc1pxWlpSYUNHWVdaN1NVTHJNblVwSHFYWTFHdU9jRDFWblc5?=
 =?utf-8?B?U2dTbXNSNzNqUmtBSmxPbHZ4MmFzMmFqdkxBeE91YitRMUZjTnFOaDZrZ0ZZ?=
 =?utf-8?B?SjJqVVN6VElLWlZYdDA1VnJTR0dvb2dhRGE1cjRNak82WEVkOW1NU2RWdll5?=
 =?utf-8?B?ajFQSEVIaTJJL2ttOHJYMnBYMTJqbTdlRFdqY0E0U2JwTC8vclJuVE9VREpp?=
 =?utf-8?B?bEVaMUdNUUlIRzBXV3NMRVNBRlZ3OTVaa1YvWnYvWXRqU0tWNG9pMktpTDhX?=
 =?utf-8?B?bjFqTVN3VGh5aHFLK1ZJWDIxZlI3RVI4c3Jaa2l2VWprd0t5WXFZYWlLaVQx?=
 =?utf-8?B?dWg4QXZJRHd5K1RSV0VXVi9FWTZkbHR4WmtRd00wTmVJNHVNNTdPbk1xRk1q?=
 =?utf-8?B?Z0VNakdYWDZTaTJqTEFjVjlRdFllYitySkNSZmF6RnlhUG1LNUxPRkNyVzNF?=
 =?utf-8?B?VC9IMkNuV1hLVVcvVmdqMXAzVUVzTVI5LzFMRlZkbERhMnNyUnl2djVVUGJ4?=
 =?utf-8?B?eEhvb1g1a3BDeld2Wkt6dFVSeFo4ZmFpbktTckIzVlh5MzNhZXlOUHpselZV?=
 =?utf-8?B?TjdVeVJ2V3ZleFhsUmZyOC9sNm1tNkt6Z0J3RFRQdDFsUzh3d2FNQmtxdnRs?=
 =?utf-8?B?bldBZHc0NDJYMnBuMjNjMk9JR0R5cmdyTFduc2hBL1Z2Q2dtTEZYY0ZxV1Nh?=
 =?utf-8?B?M3RQdWwvbmYrUnAzZmdUOVpwaWU5dHBndk5Jd01oWS9kQ241L2JzUjZDRFds?=
 =?utf-8?B?UDV3V3NPRk9xaStxOGNkUTFuL3IvZ29HZENPaHNuRHljQnZkak9qUXIyRkRE?=
 =?utf-8?B?czBiZlJtTFc2QTdxWE1UWEUzWU1ocnVFbkIzMDFCK0dndDlOM2hmZkU2LzZw?=
 =?utf-8?B?K1I1WTN5OUJDNS9ZSnZJV3pQWUZHNVRxWDlZV2Iya2lMOS9YeERZdThSdWU4?=
 =?utf-8?B?ZDJrWEIwNFZzYkJsNmpEVEpVWnBQbkh1RDhHUFlEV0FRZ215VXoyejc0SytI?=
 =?utf-8?B?b01oaHhQdmpWZHRlTTZqV1pyTXY3c0dEdFpvTFVwNmg2Ni9GK1NsRGt1SjZE?=
 =?utf-8?B?dC9TZ0I5dGZOQWl4SHVFcExjSmc1b1NjYlBCcjVHMnF5M0MzQVNsdW1zVnBa?=
 =?utf-8?B?R3ArZDJPb0NxZHM5S3c3KzczcXdOY0ZZRDFQaXhpbVR2VEg4U2RJYWU4ODBs?=
 =?utf-8?B?Yk1jZWFOeW1zVWlzMHRDOEp1VzBJaFBsNHRUTFpJZzE1ejRTS0RTTlBOMWh1?=
 =?utf-8?B?Z1B6S2NXQ2s5K2l3NGh6Rk5mQXpIalIybVdwRVJmNGFMWVdRUDRJOWwwOTlz?=
 =?utf-8?B?WEJRQ0x6WDdNcklzSDB6VFZ5elRsVVVtVGx6cG91LzI3bmlrUkdnSjh3aThw?=
 =?utf-8?B?SUJYYy9GYjgvemJLZUpScmJEbG5oS3czaytmWk1zWm1BS0xXQmR0SzZud3Fa?=
 =?utf-8?B?MUZVNFFHQ0hrSXFaVnNza1pCU0h0YkxtTUFGbHpBdUJjZkVGRjRkNVpuQWJL?=
 =?utf-8?B?SThvT1kvUjVIWTlDWDhJSzh3TmZncmU3eUE5T29zeDMrc1E5WUR2VzQyN1o5?=
 =?utf-8?B?ZjZFRTVZTENDTDhBaTdYenJKdy9UY2JNWjJGM0xUS3NtYUJDemhRYzhuYWEw?=
 =?utf-8?B?YVR4SllvUExiVVd5aHBjTFZNc0ZzN1pxZlIvWHpwSzVIMnVJVThYaWR6c1Zo?=
 =?utf-8?B?V3hiM0ZTbElCTWRoU0piZHhUWG52VG1RbkFwbXhxSWhSU0xHM21VZ1JlbGlo?=
 =?utf-8?B?NE1ZREJaZXA3MU8zYzdQdW1aaXUycUw4c05YdHIyMkMwRlZqN014cWx5RlE1?=
 =?utf-8?B?cGtwbkJLNlJUOVJ0dWlPd21LSmJ5ZzhFSVQwZmY1anN2L252eW01amhqR2l6?=
 =?utf-8?B?Qnd4WDRTUCtVekhwV3poN05ILzg4Vnc3QlpQUEM0SkVhYndKSWJ6UEtGbXph?=
 =?utf-8?B?UzBzdm0vL3A2VFFBclc1c0Zja1drWVFDTyszL1hTM2YvWFBNdVpBY3ZSakR6?=
 =?utf-8?B?VTRFRUJJd2hBU0dYbjZFNGFZc2ttUnVvWHlseThRdnliY3ZsT1RaV1NxSXRQ?=
 =?utf-8?B?TTN0RWJ5emtmV2VIT0hOYzFOR2xpOS9GN240R2VmUFdnQjNxb0pQVUc4QmJQ?=
 =?utf-8?B?NXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1979d497-79a6-411e-7fc3-08db56d92a1c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 13:18:11.9964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SI0aFUm28+fB5OirwdzOciCigcByvgwXSb8agnGpPx0qSmo1qxFR8IvS3Ihin6jSVWb7INiqi2l3NvkK/gnh7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7027
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 May 2023 13:18:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11494

On 17.05.23 14:55, Srinuvasan Arjunan wrote:
> From: Srinuvasan A <srinuvasan.a@siemens.com>
> 
> Till now we have support for 6.1 LTS not RT kernel, hence disable this
> RT selection option.
> 
> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> ---
>  Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Kconfig b/Kconfig
> index d590cbf..a96ac17 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -112,6 +112,7 @@ config KAS_INCLUDE_KERNEL
>  config KERNEL_RT
>  	bool "Real-time CIP kernel"
>  	depends on !ARCH_RISCV64
> +        depends on !KERNEL_6_1_MAINLINE
>  
>  config KAS_INCLUDE_KERNEL_RT
>  	string

Good catch, will add that on top - but indention was broken.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


