Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3838C77B75
	for <webhook@archiver.kernel.org>; Tue,  9 May 2023 06:39:30 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.52])
 by mx.groups.io with SMTP id smtpd.web11.25558.1683614368967852677
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 May 2023 23:39:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Gxey3S7X;
 spf=pass (domain: siemens.com, ip: 40.107.22.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERddcDBq74ih52uqO+2gchLAsStaoL6+HzbxDhQui7uefKmk9zpFYSopYnc2+jJNM5Op0ZtqYpGEHy5cSV1Tdq2uCA3TDj7qC6ZClOZr2EmUUsq0E9kW3aitaB8ugj5nW6CDfbNTziQmI7/muTN15bpjwXP/cVw4A8JR3QQ6MqCVmZm6EcQmaQvPRl+sqWxMI19R6AQvNnxLoj9MVNZXELJuLLuR6OqG9GTS3fD6I99QOwuhx82uVgwzyr9HIUn7yMh/a5Tu7/2QUPwC5iKhpka67DjOVisOju04nx4g+PVw/vS4KFDFNmL5dx4awJy4crx6DKUNZRvDOv2bKBiRgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yh+auxoSnuRN4OdHmeZrKj1amV6D+p2rsurStw95qk0=;
 b=DZQ8Z0Zv5OYrQdXI4UOiwNZLXntM5jkhaeIcTD0JcEGrLdZeqFwoSADiVHOdWqJDFuMYVRhVkY7Tj/Qkj0sgppsaYvOfJqTM6U+GxZt+L17qufymKHAiFyqJ6CEGjVyir6CF2qRO7Eb2aIse4XC7ujL17aE79mX0zOe+jX9en5xtqIHzN7KEcggkS6cHri1rolFh/355rcQqrjIk4kQM+a3Juqa9Mh5sl+0Di/3h3rDuNFVEolnVwODH42QhT1gY8rM3N+LgpM1A+mMs8xSPE3RTy+pNOCMb98DPb5aAijisPt2jAVQr6Zq4pNWtGJwqkcO+1C9ym2dWa7rAlm5Kcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yh+auxoSnuRN4OdHmeZrKj1amV6D+p2rsurStw95qk0=;
 b=Gxey3S7XvJ6+yAz8b2AJV1VzBwiNT7oL9JcrquLJII8Q5P9zh06a6F3kS6kg8cxXOuD1zeqhbJSRkmRrpnqIsbT2YKnLp9w+Y+MlvYMyixH68h7K8dQvbwHaoS83Dlt/cKhN0/saDV0lpKUy1h9QBwSx+j3rwSB2hCn4GcyPgvKSMm8mPP+TIc662haMT4S4nhM0hk/7sLcRHixBFE6nztl1/4+mKq7GX17um5aybq5pl7iwn9zQbsFoyxfEHgSFHlO7UtaPfR++YWOj2Li95iBoIojTEAbPFH6vVfHB85q2a3N2pZ+8BzSXB4Mko3Gol/qHgzkqhquL4D9X1kcWfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3781.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:167::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 06:39:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b50a:c627:3d12:6f04]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b50a:c627:3d12:6f04%5]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 06:39:26 +0000
Message-ID: <63fb0d57-3550-1188-8243-7ea8c8b5ab5b@siemens.com>
Date: Tue, 9 May 2023 08:39:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: Size limit in the cip-kernel-sec repository?
Content-Language: en-US
To: Masami Ichikawa <masami.ichikawa@miraclelinux.com>,
 cip-dev <cip-dev@lists.cip-project.org>, Pavel Machek <pavel@denx.de>,
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 Ulrich Hecht <uli@fpond.eu>, Chris Paterson <Chris.Paterson2@renesas.com>
References: <CAODzB9oaJ73uvgppYvcOBbM2xLNB1LQW34TZbjA3gd+bkAKaVg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAODzB9oaJ73uvgppYvcOBbM2xLNB1LQW34TZbjA3gd+bkAKaVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3781:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cf7ff8a-1aa2-4ba3-650d-08db50582215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tzRAiVn0EoX05yARlD9Qz3aybldfAnpWxKBk3x1Q1I5NtTG3N1p1DLRL22vu8us/KrJ9faxM18SSMHW6OdKRXmjqGYStkiyPr7voO/38GlqOlZdzfzheNDb+vi48Aj4s49bEDn3U5ITIQ0xb2zrNMs/dANXjfoFWqKmW6fWWHMnbW+8asmPTpPJWdsLgNX8zEPE/DG3g3TLH1VlnpzlGoywgt7wHMtMlXAhLu2PxWXsXdxQYm8JO/U8FJwBaBcbd9Q815OzwD8ijrnBsMP71pAQO11BZRNIWNerDDdAYvZLjnOBiFtY9txz4+jaqFBAkeXj6dKx9qLRdA3yT+cr5awogAHDoHtS4DMwRkOW3awR3L1rR+tUUoVoE1OmlGZOOR6jhoZqQg0lwMB0FBXFdiMpqM+N79RLHekhz3cJrgCTjnRzgeOWO4YSEUXg6w0lFpY1Q5Op0+J+PYpXDHp3TahKBm6uvqljQML2yKR9+JoV0MSI2pm+EmN63rX2koPq4BcPq1fRPWkKf9eovg61fOZ2xlhzkvz5pSuP+rO7RTUyqosj5m5rP5LrV/k3iX2ewM/BqnBZxno2ek3NM5W6EjdsZwJYSrZsIj3e1nmznhzFVdHoyZ5AOJOlifrNTHNX9fvBuz6ZcNsW39fi881U/MjuSW70aDafAAhbHcr8hMxiBAava31hs6w9Dfbd9cJaY
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(451199021)(31686004)(966005)(478600001)(66556008)(66946007)(66476007)(6666004)(6486002)(316002)(110136005)(86362001)(31696002)(36756003)(83380400001)(53546011)(6512007)(6506007)(26005)(8936002)(41300700001)(8676002)(44832011)(5660300002)(2906002)(38100700002)(82960400001)(186003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NW9EcWIrSEN4VkRsWHZtTFZvOFJOUS9EN0FHVDJhRWc5MnFOUXZLT1JnYkVy?=
 =?utf-8?B?MVF6Sk9CMjg1WHVaZWNIdTNyZHdENlozbTE5NDNvVzZEYTBOY2hDaGo0eUxI?=
 =?utf-8?B?aXh5a08vOHEwTHR2UU51L08yNTg5YTRuVnkwNWJRTGgrWWd6ci9rZ2wzNFlW?=
 =?utf-8?B?S0ROQk9QbTc5bVhDU2NOeEF5aWNrMWZkTzd4OUpTVm9rNFZlZUhLeE15Qm11?=
 =?utf-8?B?VTB2c0pYQTVTN2JVWUJMYTYxRkpkSHB3TkU0UXI4b2ROdnNWV3lGQldqZkJK?=
 =?utf-8?B?Vk1yVENHN3g5VHNOaklXd1h6Kys4RWJBTEg0bUwrZzI1clpCL3ZjNnkzdENu?=
 =?utf-8?B?TWtBUnljMmswam5XaDBjSzZ2THVJaUMzZ3ZWVjJtbDhvcmFyRi9Yc0NabE56?=
 =?utf-8?B?cHNidXJZTElsbm5oeHRrM2NLUFF4SHkzU1J0SkF2bkFpaE1MRkJMWUlkTUtF?=
 =?utf-8?B?MGJ4SHB0UkozZ0RQTU1BZHY1c0VvY2hsYlNySWc1WjRuWU9kU3FiZWwyTkNq?=
 =?utf-8?B?T1ZwK3FJMGtVZEZ4Qmw5aERFUVc5aGxROXdJL2tGcUIyWTIvcFNtdHlEYWpL?=
 =?utf-8?B?MnlZVm9BVFZhS0RIczdsQi9hQVZ3T1Z3VXYvZUNGZW5YVXR6KzA4T3ZjQm5k?=
 =?utf-8?B?b2FpOFhZYVFMYldKS1hYeHg3M0xGSGhMMld6T2lwelRWRE1INWR5YVhjc1NF?=
 =?utf-8?B?azVvaS9wN0U1WUxRZ3IrVWE5aWlRN0ZoS2Jjd0I4VTJ4UmI2UTJ5dkRoRnFN?=
 =?utf-8?B?b2Vzd1o3TVViUTEwSnMxOGtDRWRQQjlxbXY2WVlIekpLK3lra1JjWmprYUNu?=
 =?utf-8?B?bVdNY0o3UERVYjkzNjNiVHh4bGJSZEVQNGNtZTNEaUFNNXdJb2o5bDUxSTNH?=
 =?utf-8?B?ZktGM2c1MFVzd3lNWm9IYTNsSG1NS0FzdmhFU1lCZjZHQWtMSDMwckI5MzhW?=
 =?utf-8?B?aWdYYzg4S3NENUFpYXlaVVZKUGlJNUlXM0l5TElsQzYxbll1RkxTa1g3SlNo?=
 =?utf-8?B?cUZ1QlR5WGVwdXNkcWQwNldmc1FrMVE0d1lBczVhaFAxMTBmVTM3dENQWkl5?=
 =?utf-8?B?ZnV6VXQxQ1pLRjBpaC8zWXlhNzBHWndTK3pwc0ZNWkJqM011RFV2MjM1SWU2?=
 =?utf-8?B?VWViMG1pTjEwNDNtMEdZMmZBdVJaeTJuWVZQUncybUNSbGUzcjB1QWFmWDFE?=
 =?utf-8?B?cy9aNWNDQlhMVlBVSS9qVXdpNTA2OE9vdFlpUHVRaDRWUWR0eVVpR0ZOY2cz?=
 =?utf-8?B?ZFhvT1pzWmdtRFMrbmwyVGEwUVRFL2lSNW1QbnpZeHFoM1dJZFlDVUo5ZlBU?=
 =?utf-8?B?ZU9XMXVxaVIrMUUzTnZZcUFIQjlmOHZJNUZsVXlxZWhUa2gvbG05VUpQUlFj?=
 =?utf-8?B?VVY2Mnd1TUg2WmYyRVdqMVl0YWhXQzVITEEySjJDeksyWTBuS08vV2YvY09a?=
 =?utf-8?B?VjArYitva0hiRTRoNDdJOC9tVGc1VUlyR1pudFJLUnhXUVBmbFdsU0hQK0xQ?=
 =?utf-8?B?N2ZPWkRTK2g1NWV3bEc0bmdhVVJWNkhmVk9uVUE0WmRTWjN2VlUxNnhSWjFs?=
 =?utf-8?B?bzVHUUNxd0tHK1NMMndHak4zYk1Tc3VhS3lOcTh5NmFVYURrTGo3alZoTjk3?=
 =?utf-8?B?Y1phSHduZTYzbHlwRm44S3dCQ1d0SXF2YUp3Y0Eyd2JIbGxVN3l3YjRWYkVH?=
 =?utf-8?B?Q2M0R2FKSzc0aFphQ0dWcmVEMTI3aTVQbC9RSFpPVWgzWmpTRFRDakl6dlJ1?=
 =?utf-8?B?eXlsWTI2YjA2Y0hOZ3lFdWpEdEVVaHFoODgwV1ZWQWFXU3ovNm1Gd2ltdE5z?=
 =?utf-8?B?SkJKMmNuUEhTd1pEMlBTNVpqTVk2N1ZpN1dvSXRxb1RBUlpicVBDdTFiSHc4?=
 =?utf-8?B?bklxRWxLcVZnc2xZVWdxTFZ6UVN6Y2x5QVBQeklQUmp6V3pLN01US3JRTFpE?=
 =?utf-8?B?aEhQN1IybytjRkE3bUJ4STRKcHJhbHhTSHh3dXRJc29jQVVIYkZmQTNzYzFE?=
 =?utf-8?B?c2dBaDV5UkZLYTg4Lysyc1JGZmovdzBBd0xxNU4wM2RybkZ5dlE4SHR1WCtJ?=
 =?utf-8?B?T1E3ZU5vOHVQUVBPMU1OTkoydWZ6Vm9pV1BLdzQyYnlrL0hHcllUZlE4cjlw?=
 =?utf-8?B?L0FsbUd4MU9zM1FKQ3p0NXd0NHYzZ0RZN241emxIaEVhSVhZTGFRbTJwU0hZ?=
 =?utf-8?B?Y0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf7ff8a-1aa2-4ba3-650d-08db50582215
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 06:39:26.3890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vkWapzuaXfdoCeD//o6MyaIMUbFLG9v4Zcrm+/Urv9A5fNT+/2PTe6eCOhzuRYuO0aEQMifJhcH+5dM1AE5vlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3781
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 May 2023 06:39:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11420

On 09.05.23 01:34, Masami Ichikawa wrote:
> Hi !
> 
> When I push commits to the cip-kernel-sec repository
> (https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec), I get the
> following message.
> 
> $ git push cip master
> Enumerating objects: 7, done.
> Counting objects: 100% (7/7), done.
> Delta compression using up to 4 threads
> Compressing objects: 100% (4/4), done.
> Writing objects: 100% (4/4), 457 bytes | 457.00 KiB/s, done.
> Total 4 (delta 3), reused 0 (delta 0)
> remote:
> remote: ========================================================================
> remote:
> remote:    Your push has been rejected, because this repository has exceeded
> remote:     its size limit of 0 Bytes by 400 MB. Please contact your GitLab
> remote:                   administrator for more information.
> remote:
> remote: ========================================================================
> remote:
> To gitlab.com:cip-project/cip-kernel/cip-kernel-sec.git
>    78850bfd..92d679f5  master -> master
> 
> Even Though, I get the message, commits are pushed successfully.
> I can see commits in the gitlab's UI.
> 
> Do we need something in the repository setting?
> 

This issue affects the complete cip-project. The reason is likely

https://gitlab.com/cip-project/cip-testing/linux-stable-rc

which hit the 10G limit, see

https://gitlab.com/groups/cip-project/-/usage_quotas#storage-quota-tab

Folks, can we avoid this?

Chris, didn't we apply for an OSS project rank on gitlab.com?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


