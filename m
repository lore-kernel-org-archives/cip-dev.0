Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EF3C77B7A
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 05:40:29 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.57])
 by mx.groups.io with SMTP id smtpd.web11.2351.1686030026132101785
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Jun 2023 22:40:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=KRswCKhd;
 spf=pass (domain: siemens.com, ip: 40.107.6.57, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2mPskCGjR7b77CSqkqKDXqAu++T2PfkEwFx+Yc2tkHNC6CpXOK1kG9nIQ9DqeuFAK8qd7rvp87gdLC++5lafWQkFjdmJbCiNc+17mouSzud37MqGOo+0RnxwzGqH6H9AZEsisyNJ9r5w8rc9ugl/OTBRWcRFMTTvMolM9nkQifcX2s4kVsW8cNyDxUN9l95T7hWeEHuLBUPbW0SuzE4Rkb9E447o3FViGrUNUp51nwPizhzAR8bwXEJBKPHoIA2Ra1DqTfSjE5eea6cFa0/u9efH50LeSrxQZzfHVibqaU0HXHeJXp1rsFJ4QiQi2pHu4n4z/GMqtJ0YEwEtDCMAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ArIyBkJ4X9kMqii3ksJ6sc0TUIidsiTNKFsQqtZEyg=;
 b=HFUqcGS9AMcpjvog4gvT/WDInxHRGWemZ90XBiJnMFrXUiKREh9qE40Ilnzkg25qBBWlZI+4jaZ6DJ2KUeIrP6aBF51qsKrVLtXBwjcL2JxSRaTYBNnV6/gt8TH25HskNsp6Vc4EJ5Gbc8GP/5qm288M1ZyEUlYj5rrpP6MaL0eD0mqyfzHrz8VNznj6BqK8xYTDBsUY3Bp/ICeN5P14EJvAYy78SiwwbMrJPr9KjG4cFwfqVjAsSl4rsQswMcrqJut1pgT5+rmeDqO+TrEuvDlTTZFzL3B7xi8QSchKiV5IQKG8Z+nbrRAdRgCtoNOh96iLsQa/OwaN64qXF6ZuDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ArIyBkJ4X9kMqii3ksJ6sc0TUIidsiTNKFsQqtZEyg=;
 b=KRswCKhdi2WXk2aQCd0gHEQXrci0q2Ys/mIgZtzY8NyQ0Gixnetst0mJfrwolbaT3GLfvZbrgcRpddVz037fEGs6C+bEHFws9eVuEBRXDQM894TyvHrERoc/79uzXTzzTgbqEYsjJopcgZEBYO1YTTOiij/8DK6BPikMBekdHVRBe7V4daATjPe7izXjMaXZ3dk3sucT6fSbYwpbid6dzXbYl6TS7lNBBgd6Z4Icszt1BGmfky/8QJu5cAO+NxfvDypaK9wsibkAiYH+Hqy02uekim1KSHv1aHQUrcWa9JE0bK7FOE1E0rOB9gNTVoZrg866J18UFP33Bom0dw5qqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DBAPR10MB4058.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 05:40:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2ecd:9a8a:5601:47e4]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2ecd:9a8a:5601:47e4%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 05:40:23 +0000
Message-ID: <97730d79-ff61-a0bf-165b-1b36366793de@siemens.com>
Date: Tue, 6 Jun 2023 07:40:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [isar-cip-core][PATCH] linux/cip-kernel-config: Bump
 cip-kernel-config revision
Content-Language: en-US
To: Srinuvasan Arjunan <srinuvasan_a@mentor.com>,
 cip-dev@lists.cip-project.org
Cc: Srinuvasan A <srinuvasan.a@siemens.com>
References: <20230605083508.1297159-1-srinuvasan_a@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230605083508.1297159-1-srinuvasan_a@mentor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DBAPR10MB4058:EE_
X-MS-Office365-Filtering-Correlation-Id: 3279d73c-dae5-4107-f9d7-08db665085f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hb2E5Mwn0JMK28OtXEzAlUR27osTzSjf3Q5plSafzlIVYAcisV91bMjEMmTCn0/YEOygcqS+yjXjzUVzLC+iztu2uXf5hlcjuerXCYg8FdRDzy5cKu/RYWo9iYSPc227jwB+2fgbgAyjqaDM7YhrkWKh4CLOFYwjJXcQlp65lNxrs0SzLWErPfZeMO61+qb/JJKFk7y12Y/quvqww70QkZ4svE3CnEUUzgQf4zV12mVDgbisMjMpO+Ihhu5fDbQfJu4Kn9JliWIf1enRkLBr2Ok5BgC7kwKN8vyrXpVS/O2ExjpceFf7cbCxz0xxhBwJ2lGAx8teXMbFYEooNQ+m/KmcU7OGwR49ULRwnPH3K1LG4mdycMis2Djzps/Bxlh5o9+VUgKwfyfTxMy/FXFBw3jfdcK6lCE5C3nfxnEe2sVhtTUaJwrbwEOicIB6glbj2dmExqYgBWKUoTZJpI4paQ3GNjreLCcmkU7MkP4i51+F0yBRrrxRbqVG7B+6yrJQTFfGtSEAifKZGJ6ZjRH3kHPsZQWtzw6OyyOoDEOyCRQb9kGKCrUYLxYEmGUPi3UvQ42sKQPJ+2LCGQGqCJS2ydt0ExukfRG8QdcuhY2Q2e1TknJQ6MLq1N91d0JOlZHNz3gKHnEr4HTT8lxqRgxXTQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199021)(66556008)(82960400001)(478600001)(8936002)(8676002)(4326008)(66946007)(2616005)(38100700002)(41300700001)(316002)(66476007)(6486002)(186003)(83380400001)(53546011)(107886003)(26005)(6506007)(6512007)(44832011)(31696002)(86362001)(5660300002)(2906002)(4744005)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bSsweVZKR3J4ZlhMZzBLQmtqYytFWjMrak00VkRTRmsyYlRhN3FsMURtbFRQ?=
 =?utf-8?B?TysxcU4vdmJqTEpod3lPQWxLWHVJaWEvSmJUa1dsSCtpVjNWbHRWVUFyS0Nj?=
 =?utf-8?B?NEc2VGl3cGUzbFBTdWpyTmtRRWlkOGdtYzJIZlVlbEFHY01Ca3FpMVF2ekdk?=
 =?utf-8?B?dk45QndHcTlZSUFEREY1dVh0TVhuelcvaG5qU2Q5T1l0dklhaDhsRWdzRG9n?=
 =?utf-8?B?QkVDNFg3MTBCdnFmODVnVkZmQVZ2Ri9GR0hqakJRamlMeG42WnZjSVJWLy91?=
 =?utf-8?B?VW15OFBTdzNuTkwyWFM3RTNKNWZzZnJnazlUb1lzWlNBNDM4TEZkc2xCYjlP?=
 =?utf-8?B?VHRFSUNEbW1qTlJPakxwRnJ3N1RwbTJ3czNYM1dQODlTeDNKMHh0UFo3VG10?=
 =?utf-8?B?MnlRaW80SDVGZlh3Wlh1elFXK3JPK29OZ1g0eWlZRVowQTU4bUlJaWM1Y25N?=
 =?utf-8?B?YnZSVWJZc0RTV0k4OWxNTCtFcU9IdE1SQ0ZVU1hDbkhva2M5TkpEdlNZUjdj?=
 =?utf-8?B?MEkwam5FeWZyRFBNaG5IL1V0ZmI3RUh2OUxJbjUwWi91WjFxbVZaVEFaQzFO?=
 =?utf-8?B?WURRT3FUd0RiT21IeCt1NWdKeW9FSklVSFlIZ3M4L3hzRHQ1OHNXWHcvdzFm?=
 =?utf-8?B?UjRKa0FpUVNVNmVCRHdkVWhVdHczRmx2bWIwOEZVSzFob2ZJZ3NUTUV0Ymdw?=
 =?utf-8?B?ZUFzcmhBUGhkNU15N29jUHlhdS9kdDJubVFrYWVwVFhtN0RWRVR1YmhoSVlY?=
 =?utf-8?B?bGJOenREOHF0WHFMNjhOOGJIUUtWZVErQTZoeEx2UEx2MnJqSUtncEpubVBB?=
 =?utf-8?B?ZUFtWllDbHpWdHIwQTdjWTJjY2x2bWEwRzV3VlNNRldodVlZeGREbFYrZkNu?=
 =?utf-8?B?Vkk4T2VFVkJpNmpFV2h0LytjS3g4OGM3REladVUyZmJIUmVwcmtCVno2bGk4?=
 =?utf-8?B?blNyS3NXVGtSNUhKK21qRWx3WmpLdkNrRUdVdnZ0anFpaXBVcE85VllMMDhC?=
 =?utf-8?B?dC9hYlJJNFJPb3BhY2JmQ1VwVmpvbjlMTklkQnVZNUZqYjJIUzNXWjZraUZS?=
 =?utf-8?B?b3JXM09SQ283eGw5OHprZ256TlVJL1V2RDhqNTFRWFB3U2YyNjJEL1RqUFpY?=
 =?utf-8?B?ZzlaOFZ5TXZYWUY0YTZFMGtlMm1EM3NpT0RDaVpEMGtwbERXYm5hMjVJdkVp?=
 =?utf-8?B?cWIycUg4Q21EWFBGbXFhRURMV3lrdXhhY2tJOEYvanZ1dlo2TExpaGw5S0tq?=
 =?utf-8?B?bkU3VTJSZkRYSFM3R2FNUWhJK09IQVBTaU02djB0UVY2bjdTT1o2VzhvbVBY?=
 =?utf-8?B?VlllUjNSVkwrL09zMEVLWTRIY1AwNEtVcklWQ09MenF2UWxIQ3E3a3dtQ3oz?=
 =?utf-8?B?c01IbWVFTm1oZGJOejVOdTY5U1JEdS8raGMwRUxMVSs5c3NzVHc1NEtvUWtm?=
 =?utf-8?B?ODZoMktPNXVrUktBdnlhdmcrbDg1ZWJBaWZ0QnJlNVpDbmk0TWRrdGMwSG82?=
 =?utf-8?B?Q1M2M0NKb05IdFFwdk5qMHhVREpVa3k1MmtqTXczRDdkL2traXJDRzJqZjM2?=
 =?utf-8?B?Z2FrN09EZ0dXNzZmbi9lTXlOWkZOZlRyc1Z4SzdtNmhQZUhtRjcvVnA1TlJi?=
 =?utf-8?B?WlBkSzNUNG9RKzJpNFBkZ0hIU3pLbXVWOUZmNUpWNnRsdkM5NThtRUs0Q21N?=
 =?utf-8?B?YlFKKzU2dEhWT2pVRU4zamc5dmxCcit0YkhMVWJMUGN6L2pTVEtqNHFaS1Zx?=
 =?utf-8?B?a0YyNkpJVUg5UTAwOFBDN3cxanF3cFlNdGp6NzdwUVdQcFJJTEJ5T0pOMFBT?=
 =?utf-8?B?Yi82Rzg3QUdKR0RxL2RCRU4yMlBtMVFmbGRsR1BMUnBKTzF4VXJ0NGpjaTVz?=
 =?utf-8?B?dHhzbXdoMUhkcEFGblROekpNQkEzMm9mazA0RzBFK1B0T0xtOGdRbi9nWXdt?=
 =?utf-8?B?alE5dnltdDludHVKZklYNCt1UFBldGpVVlVVZGtmVTE1dVhSd1RicVhjZVlv?=
 =?utf-8?B?ZXYzK1Y0L0YzWHhkbFF2T3ZoS09KSUJrQ0lXQk5ZUUd4cDdMaWRTWlpxMDRE?=
 =?utf-8?B?MjhmY2FnTEJCdWlwRE1RL2FqeHRHNUdGYk9OK0NtK3RhU3k0aDZVekw3NkRs?=
 =?utf-8?B?K2s1cCsxZ21WNVBaWnlFSnFTR0duWVRFczlrQzZJYmVsQzlscEtwTlBaUFRZ?=
 =?utf-8?B?QkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3279d73c-dae5-4107-f9d7-08db665085f9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 05:40:23.5624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RvowjVnBIBviotSx2ZlFxUXBdBNLZ4c0WuZuDZCC9P20JiApc20+akXKHfOuRvoB0nizc7HTTc6VTUec/VvO5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4058
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 05:40:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11838

On 05.06.23 10:35, Srinuvasan Arjunan wrote:
> From: Srinuvasan A <srinuvasan.a@siemens.com>
> 
> Update cip-kernel-config revision to latest one.
> 
> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> ---
>  recipes-kernel/linux/cip-kernel-config.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
> index 329b9f7..e104200 100644
> --- a/recipes-kernel/linux/cip-kernel-config.inc
> +++ b/recipes-kernel/linux/cip-kernel-config.inc
> @@ -14,4 +14,4 @@ SRC_URI:append = " ${@ \
>      if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
>      }"
>  
> -SRCREV_cip-kernel-config ?= "d1efa37258380c7f4f39a8dee1bdb4d85f1c0199"
> +SRCREV_cip-kernel-config ?= "a28b7a678418287b12161975fe8b9b04a3cc8c88"

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


