Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D511C4706C
	for <webhook@archiver.kernel.org>; Fri, 12 Jan 2024 18:45:15 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.43])
 by mx.groups.io with SMTP id smtpd.web10.107.1705085106564562893
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Jan 2024 10:45:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=VqhTOQhX;
 spf=pass (domain: siemens.com, ip: 40.107.241.43, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlIL+HCvh1+Djg4KFEgAWFx7VJrrGNBFfdkHdQftwBAktpDWjEB2jiJkihl+Mb/psrOeAsjrfz8R9BGw3YfgyTzpbhJWUcI2JxHIbNXTrf+HL2OBZfsojbX5Q0BIqb8qiXIBzlRWukZSrktyAzTnhhot0R1jajwwozb00K9h2r+qNYd3Wu6o/d8q3+/KDEDis+b/k34X954mpNBF6dcCMu910iqcxZWoHI6I2GhlAwbgly1HnyMV5WjzXg2x9HobKvzHmQzn+PxnIRKiy+U0WP54jPYCh3onf7oQILuU5YgRPWC7EdPXknga8ZzbaM4ZzxIPCeitTSZ4NiiMb2g9kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfoJ9FsOKVJf/T3FdZqPjlo0eHWvtHOp5Eh4IADT/y4=;
 b=dBvWKuUXOwnA4oPjE89yxTjXNgJ4/RBcX46IQOEwB/NIb5X31JKEZ8XynaHsjCm8/Sz5KCWuQv5JKz6GATmqU4OHlM1xt5bNz+r74sQTclU26FAChMCMzslFUA9WY9JVPsjwxxqNi+3loTOR3bgGvsPWczfBuBUdM7sXd6piDG+aRIeVY6Ge3VWz0AEpP6gb5lXGMHsi4675W82hoRC+h7dmxFam41vCqw4KZSSO54cgHRDvkdsTiZ7DHXLgCYeoOy2Bv1oPM0DyfhNOqJMAX4Nlmbx0l9WW9wrtQF61lqNMagdVtGX+YhvVREYUC2X8xQR17iz4NzL72fg7ni261g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfoJ9FsOKVJf/T3FdZqPjlo0eHWvtHOp5Eh4IADT/y4=;
 b=VqhTOQhXbORmtugxfrYidOYoKnXikqXPTccLsix7lebcjBw6OQQTTl2UL8BpwoaCVNXpxPnzOcbYIMphnvtrDsDFAkMZTk1xzcCsgVZyYSn0uvVrSMu1Aq/9olMQOuRBZ8cAxSlkZbBKFW8QCSIPvQeiBNLwdbHYeCP/WbOMfueeaEqQo+DQEx+RlWw3p76yoIaqFIE+Palmlkprr4cneViXDnoUKAaLM2uZuVtByk0JBS9iiuEp1gAfxXmeaF9y7CdceKd1wvdGn22yt3hwCYqTybQfxOwRsiP+K1m2RQ9pEWezIaESwhM0LKY48SBDoHm6j8yAKaFAx7FnmmzfJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7001.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 18:45:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7181.018; Fri, 12 Jan 2024
 18:45:02 +0000
Message-ID: <b025585a-8e8e-4738-bb4a-c046483fc68b@siemens.com>
Date: Fri, 12 Jan 2024 19:45:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core]: kas-cip.yml sets a default root password
Content-Language: en-US
To: "Koch, Stefan" <stefan-koch@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Adler, Michael" <michael.adler@siemens.com>
References: <4a567492e734697fa059a6fa03328b6592c7d96e.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <4a567492e734697fa059a6fa03328b6592c7d96e.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0197.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c663643-c366-413e-a623-08dc139e960f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dLc+J51fN0zXnJFo105+bNuBRkLqJt1ziLqA0m98j/ZHiOVNaSPqRPMCiD9bpiSXcOeAN7VeFiejrPjAwX1WBhF+j03as20zJhQtOYxbw2K3DO8kRez/YpuEraZH78FoC/hYoBDtumg4yUN+KbR7UIyQtqff18Guh1zUPK7wStFUnpmdxE2QhDIkGh9RJXMXKHGFuR4luQdGjr+DTKgTsym4G1oOnyx69VT7O8ROUQ2haW96t/07MtkZoc7YMSXuifElKn454dsnGOEQilG4SHdW+P3YHDYn95w4UMkxUPZebKYN+Df0A//UztdZv9wJRclqRR6PdBU4vjzqQOCso1IOeAcbnU17sv5MIVlV+fyrGkLZEByToCv6e/I7xoHFGHsDtbe7OJBL2jsgjDkVzItSTrej7fGXXZrh2XmD8NG9Qi0ni1RWdXsLHbo/PSFthBBG6kHCLnUIKMun0tAswp98VQTD6+MPHUFzEtfLp6UptxBnS/UbNE8Shr1THe0bs5S7qPnF4eglif56AHu8K7FahVgYPaGjf6UK34q+bdH9/wf4kjtZaiuukVZs62iFPLNI7aAySF3RAsPGmQqURnVlfI0tqNkg632RBdqq04TemaxKh/G0Ri3dcRCXcqLtVw9Je5p2nm2cyLTmiDeHMg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(346002)(376002)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(5660300002)(4744005)(2906002)(44832011)(38100700002)(26005)(6486002)(86362001)(31696002)(82960400001)(107886003)(478600001)(6506007)(83380400001)(53546011)(36756003)(2616005)(6512007)(316002)(8936002)(8676002)(66476007)(4326008)(41300700001)(66556008)(110136005)(66946007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cVRZT1lSaE5RZ0llMzBTM3FRNHZSakQyV1R4dnFGTmF2UlVQL0VNNTk2WTJC?=
 =?utf-8?B?Rnk1NEdUWnp6Q2UxbjZDVEVSUU05aTdnWmpyMXVPMzQ3SnFDRjhJVisxQzRr?=
 =?utf-8?B?Tm82Ukkxams1QVQ2S0l2MXgybnh2RjZsemVibi9KTzI1RW1nWWlqb0NsOUlI?=
 =?utf-8?B?T1JKNldUVXZBYmtMRWJuRUNIaG5tWG1ZTUJUR2NKVFVhTlh5Vm1odVZITlNm?=
 =?utf-8?B?OEN5eXRJYzBjTW1jeEpSQ0xYTHlmL2R3ODl3b3hZZS9QY1BCYllpYzRpNlZo?=
 =?utf-8?B?S2R0YU1jVTFaZk1UbGZXQU5UcWNPbk9udTJxdndFK0l2UXIyRjliUUtwd2N3?=
 =?utf-8?B?MWtDVjZoOVpJdTdEWW9TbjJHSUVmb2EvaVdUQTJEbUNXdE1uallCYVNLNDV0?=
 =?utf-8?B?eElkZWFNSEFGenhQdmVORFd4a0Z5ZWN0Vmpja1NFRDMxZkE0UFRnMXJqM1ZB?=
 =?utf-8?B?Qms1cmtRQmU1VEVBSm5VS1owSzFzd0VlMmt6ZmFWVmJLMmN6Tlh5aWpKZkVh?=
 =?utf-8?B?Y1dROGRCUjExZ0UzL1lGQXpCUCs5bnJaeENLUXN6K1FGOVBpajZ6SFRyL2ow?=
 =?utf-8?B?M3REU0NEQ0tNOURBb0hkWit4MCs0UlVQMmpoenFHWC9FaG5PdkdERzVBbi9Y?=
 =?utf-8?B?NmtjOEVqdjBRRTFlQkp0T0RkUVBpWHBLdllMSXpDZjVRc2p0YnZ5SFA1SXF1?=
 =?utf-8?B?UThYeVpQbUI1RlZKdFN5Vy9TbVIvTDByNkpsV3VkYlg5Vk01M05KT1Uva2pi?=
 =?utf-8?B?a0lOMEpCUGNnc2xqeUNCNFgra0R1TTREUFFwVnlDaUdnckJ4YTdJWGpPNEtT?=
 =?utf-8?B?ZEo5cXBtUEV1VFJzYU5Tb0R2T2ZrcXJqTEU0U2xuTTQxRCtsREtqaG5OcVhF?=
 =?utf-8?B?MjZWQk9ZaEhqbGN4VUVRZWR0UHE2UDNpOEdtNkltR2I4Ykx5c3ZFNmJ1RytY?=
 =?utf-8?B?Q0Job0hTUVFSdDdpQ2hYLzV2TXFaTFEwSkFCSktYa25oYldKK2dTQk9ZVnRB?=
 =?utf-8?B?ckFLdlliVU0wcVFOOUJobDhnU1JKdnpRQi8xdzFyWGJ4ck51b2FDdU1xWWk1?=
 =?utf-8?B?Z0xVam10di9zUmk3QjJKSVZyWGhsRWdvUXdvU0YrMGc4aGtxVXFFNmZRMXN5?=
 =?utf-8?B?NXFSQmpLVXMrRzZWZHV2cHpLazBWNHJxNUpTT0hQeTNpTGdVK3FyUmUyUFJK?=
 =?utf-8?B?U2djMlJYUHBOYmdwMXpiWkxyUWpnOStTR0NHZG5SbjhWbXk3L1V0ZkhYdjhD?=
 =?utf-8?B?a25DbzN4Q0ljbXkzOVpoTFFxcU8xNVdzSWExNGg0eVVjcHRjbTBvUTNEZFcx?=
 =?utf-8?B?WXZSUjFhRHFackllajR4bVBjNERESDA2N01KSG5PeHRYdlVyQVVxdndTZjh2?=
 =?utf-8?B?SWRVYVEvMUplWE5KYXNJU3FHZUhWVXZGVnVYRllSN0kwalQ2dWpFY3FoUlMy?=
 =?utf-8?B?NGpubHN1RzMweGxnc1FBV2dCeU9HODdCQmI2R0VaNjhjOXlNcGNsbW9UdDBL?=
 =?utf-8?B?dVc1TERteHAzOS9UVnhmVjBscWhLNTlzWXJqaGlSZG1WQTQvS0hZdzF3V1cz?=
 =?utf-8?B?bExvT3dvRjc4ZzV1NlZQVGVXNTZmTnFBOXdZZkhBUnVnVTQwajg2UFNldmNt?=
 =?utf-8?B?QlJzMVE4cDIvWkhVSHFEeU0zeHJHK2JxQlpIbmlBVmNKMHZCV2k2K29XaE9w?=
 =?utf-8?B?a3V4RkJQaVliMklMcmczN0NmdFJXRXViZlR4enNNZGNud3RUUGt1RllrcEFB?=
 =?utf-8?B?SlRwYSs0STcxTHlSdktuZWRZanVtcTROMFJKZ24xeERJeXVQekljdmhuY2pM?=
 =?utf-8?B?RkdPdVg5dHFneFplaVNWUUt5Rzl6bWxWbzVSSGxUM3pwZmpsbzhpTjE3elZu?=
 =?utf-8?B?QWpaejg3Z254OEJzWUUrMDM2cGVCWTE2TjVnK3A1a3NEYjUyZ25VeERYUTlY?=
 =?utf-8?B?ZERZc3ZTZW92WHkrSHN0aU1XVTZNT1dPczR5OFI3d3ErRysvclhaZVdzclhs?=
 =?utf-8?B?KzZIWVZlR2NVYVVib0FMakpFL2FobHA5MXFxZFFpZmplRzUwZitoSVYxMXRE?=
 =?utf-8?B?RkR5MTlwRlhLTnhYeHNBTmRqVG14dGYzcDhEV1Z3cjVldFdiOWVCcExod0NX?=
 =?utf-8?B?WndDNjJmcVd0UHlIelF1QU9FMW1naUJPUVJ5bjZ5d3pjWW42eGhXNnArcS9i?=
 =?utf-8?B?dVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c663643-c366-413e-a623-08dc139e960f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 18:45:02.4495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2B3wuTZE+TQ/CFpMMzOCUtOIKS8LJd8aXfofh6hgSL/w0yrYGi4IxVDi72y+NJ1A0ChwFk3MpQqs7vyXWXRGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7001
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Jan 2024 18:45:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14354

On 12.01.24 16:45, Koch, Stefan wrote:
> Hi
> 
> The kas-cip.yml from isar-cip-core set's a default root password:
> 
>    local_conf_header:
>    ...
>      root_password: |
>        USERS += "root"
>        USER_root[password] = "root"
>        USER_root[flags] = "clear-text-password"
> 
> I want to start a discussion if this is bad behaviour from security
> perspective...
> 
> This kas-cip.yml file pins the recommended isar version for isar-cip-
> core. Someone can use this for pinning the isar version and set a root
> password accidentally. That could result in a MCA when a product would
> be released without checking that. It's a potential risk factor.
> 
> The kas/opt/security.yml has the same issue.
> 

We are not aware of any downstream layer including kas-cip.yml. So this
configuration should only affect our own testing and demo images, no
production image.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


