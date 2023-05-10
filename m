Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CBBC7EE23
	for <webhook@archiver.kernel.org>; Wed, 10 May 2023 14:41:09 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.85])
 by mx.groups.io with SMTP id smtpd.web11.19182.1683729660959081958
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 May 2023 07:41:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=v6IGSmLG;
 spf=pass (domain: siemens.com, ip: 40.107.21.85, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUACry2g0Q5KOyWFQd8SQbxa3ZDrxGRKi2WUt5C7o+WrVxzdGul1kXFZ2Qd71xsO6SnZZNDIihJBRVFB5lsO05tPN/9ZXB1xpmtt68LPLZH7YO4Z9lCXJaUP/w6bn793dGWH9TvvLx4Ns/XbdsShFww/lW7nC/MOThXQju4rp/UH4u0NAZgzKghaeXAKYKMfo+Vfglq9H6DyxX9ZGLbuYiC0AmCocMLRLB9hV2mOrltZuh7xavgQ+yh/kLSNkyJzRI3yd9CjO7FHovUpv/Ramfs8BLI5nV/9dWKTv5NMORtG5JykgmjGFaCVRhr4ONTGwvgXlwKuPJBob/p+DhQnhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XeC1DT1gdfS9tOBCOuQ2EDVLVwatBnjjZAkY4JJHdIA=;
 b=aO6yanJMqCHVQ/1jSletPp0QsOhuy/8qgLyZSlJh3ROAmym/UfLMfKFvlSEUwK1gbl1P9VACYVHviPWPCWv8hB6W8dqI4p8hB1Rf/b8xGMIj3SQQyMdk88Cghc8Wy3PsIRHiUZI9opHeebb1dc3w8vEktEEO1DWlSnh7DejL5FrASqIT2WMLhWN7QKTu+UH6EpsuHqXh2pYVrHwsFAB+besWmxQKG1Qe3PC7NjeitZzOIVMd3QM3fOL8CB66YEdkIKWi/sAIBzwKmY2WJzAwXlmANNUBCuEhx9Rmm3x2NiAwlIz704yq9/ipC0qVkLAYTOpYXdJ6VJkggpGr4RXjYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XeC1DT1gdfS9tOBCOuQ2EDVLVwatBnjjZAkY4JJHdIA=;
 b=v6IGSmLGK0XywSSZ3hYEzLQA+R2UXOq8tBzSrUW/3qGNda/6za/NlvUMNYI/5uQ/Vs5+2VeW7TRVPavnqOdTOdFy0BsNlTmQEKD0yuqpenQfFn96Zr3O9fEV/zVsg5Z9AsPM/PgZkI7gYmggPlgqYpTBwg741SeaDCWiqaWwamWvmJZwbKutNa4MHKe0H8mMKE5sRiy/aVqspzmS3iLL5GRhxDTZPgf6P+pQa4Q59HWwHm00B8EBpNkn1JQVIOws/pGpLcdDiVirhS57CD4iQf136WNvUmMBaFog4nA80+co7uYFxucceGTSn1PWm4UZj1err3BHgbRd5zJLf2kztA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB5949.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:528::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Wed, 10 May
 2023 14:40:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b50a:c627:3d12:6f04]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b50a:c627:3d12:6f04%5]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 14:40:57 +0000
Message-ID: <6fa6a61c-f99c-e703-d281-160ee769ee15@siemens.com>
Date: Wed, 10 May 2023 16:40:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [isar-cip-core][PATCH 1/1] use cdn debian mirror for backports as
 well
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com
References: <20230510135913.854211-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230510135913.854211-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR08CA0004.namprd08.prod.outlook.com
 (2603:10b6:610:33::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB5949:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ec6af06-e01e-4764-a0af-08db516490ee
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	y4kXOzD8j95mEkrOJTBZy3d1E4O3PS3KVdn411sVL/sSbBYBc8TyrdVdopujxtQ10sYcjAh1n/WGrJjwEUp2fNcvP0km9nGy8WAShiLI3V6cd22COjPgvnMR62XvCcweNlcHW2pKp4BTm1++aDR/cyuxe+ok6G7uJaCoOOTkiMomi/QV0hvWvmXgoyK28uf19+tsylVaAcwM+1hC72TwKMO4xKXSPJVCH1kgTqo4doTEB10Y+iqlhLNgF8w/s4Vzdpz/lEQU2v6C1EyzE6dTFN9V/W3jh8uvoPyY3R+fz5FUp2k+E+ScpORjCeDxL1sVARPpl43tm7P4zIQwtEsZE8Q0tsF4PfQxfXPU3a/YacdQLq1rnbBndl4xMOO+4gXwX1TlrSIF9UWFdopeNYzIthNtbxkE59BoHsFNbjE9QXHfpOnQkrEQkdRO7JclJxY37fG0pvU3yS4rSn2otAy3rOXN1LsqaB5eM9ABpCHzb5fDENijeb0/ksgtwbTEB0bd/pbo7momoJhxm2J9/mp2ExjdT/GdXZNXPiuNCn6hNlS3iE6ix3ozf50QAYEsMMdNh45ySWXOx3CXyKjJkdJszaxgN+H/Zp/0lCqeZiEUqJcY/OqeJLJWIsY/5Jw05ZLKzZstLnHMhHNZKj0BrqSSCg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(451199021)(6486002)(6666004)(966005)(2616005)(83380400001)(6506007)(6512007)(186003)(26005)(36756003)(53546011)(107886003)(38100700002)(86362001)(31696002)(82960400001)(66946007)(66476007)(66556008)(2906002)(4326008)(316002)(8676002)(5660300002)(8936002)(44832011)(41300700001)(31686004)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bTdHTDBYaVlOT1Y3K1dMOVpLMzNTMThBdThXeEZudytSNWFGVzBhbHFwNDBK?=
 =?utf-8?B?TkMvRGhHY1lZNWg0MGdwWEgxb080S2t2aUZ2bm9QbXlVYVhnZ2ZyWExxMURK?=
 =?utf-8?B?QWIvNmIyaEhxWm5PRWZxb1A1MVgreDNmazh0T2RkdW1yOUNqSHVFZW0rR3hW?=
 =?utf-8?B?WkI5c1hJb0dxUUtDaGhxSU5PY2JSemcvMkN4TnRWT0VZZisvSXdGQi8zZzFD?=
 =?utf-8?B?T0xwRGdDcXVFa2ttUy9oZ05SLzVRNHIxWDBGMkREYkxHWCthY1k4VlpVTWhE?=
 =?utf-8?B?bVpWMXZ1OEtoRjVqbHFsS1hJdG9jTlBOaUJaOHhLK01kUUx0UFgyK2ZwNXcr?=
 =?utf-8?B?OXlMMDdUTHlmQmxhTGdaRll0bENhb2k4enV4MFVzQVNDeDVNZkJabE5YV0ZM?=
 =?utf-8?B?SXV3aWNsQk5wa05LcU9Ec1h1Z2JUSlk5VGRKVVhVcW9ZMCsxTzN4VEJrVzFJ?=
 =?utf-8?B?TnJJYlN1WlFRRWtUcnhhTXdTbGZFY3pjek9xSDhIODlsSjBVYVNmK0ZEc0NH?=
 =?utf-8?B?bWQxeHg2blNWbm9UZ2RyWFE3ZjFBOWk4bjVaeTR4djNFdlZNWWtCb05vMWZB?=
 =?utf-8?B?b215Q3ZheENqZG04clZuRFdwaHRMSDA0dGlRSVNtTjl6OGd6eVJTMVZxcy9U?=
 =?utf-8?B?S0dDeW1Yak1XNllvWTdDcTlkZkwzZGUwRXFXM3dHUHpsYnluOVd4QWZwYnNI?=
 =?utf-8?B?cjlNaDdvZVJHazdNU3phVVliaHdCS1gvbU9KRnRaNHVMenBUcjEybVBwRGlC?=
 =?utf-8?B?eERFdU9XdlhVU3ZKRU9JTFZhV29hWElpZWZjZXNsc0JtWW5nMmNrdG9KdG9z?=
 =?utf-8?B?QkhJcjBWaFlhL2dFR0xCVTZldVN0bkNKWnVyZnNySmlQZjM2dTNvU0wwKzhP?=
 =?utf-8?B?RlhCYmwvUHNBdFpPa2JPUEs2UWZFTXR1VDZNeW1DdUtaSkJYSFRhaC9SRnZY?=
 =?utf-8?B?bjhQNzdhQk95VmVDdHBvU29GVGtLMTlhNUFFaEN3U2xkUy9zRzUvakdOMnFo?=
 =?utf-8?B?REtTUkpFN1Vid0VkN0NjdUs4a0lEazBDbHpZUXMrdWp5OC9QcFNSYzRWeEVk?=
 =?utf-8?B?OXNlaWVFb0pHNU9IUDcrSW9jc0NYblJrV1F0czVSS0JwVG80NzJUSFVRTVpa?=
 =?utf-8?B?aWNzaXcwbGZWQWt1L2YxSzZNZ0c4RVNTS2lEWFZtSU5wSFdCNlBoZE1IZys3?=
 =?utf-8?B?Q3J6SHZmOU5ucjZ3bE1pK09OcGNQRjNqS3lQZktOT3lpdnNEemtQd3Bxd0lP?=
 =?utf-8?B?QnBLY0pPYjRaZnBWMlY0c094UUF0My94VlVpbVo4cDBkNDNkejBlT0EzTDA0?=
 =?utf-8?B?UjZpZXFEZ2tuK09tUXhwMi91OUdGRGJqUjhCYlJ4dGJwaEJKMUZURGhTTGhU?=
 =?utf-8?B?T21DZ2w2SlFtUlk1N3pKZUNWcUJxNkpwdVUzVWUzT2I1SlJPR2NVR01wVUpZ?=
 =?utf-8?B?M2VPaDhNOERLTVZ2TFV2WDZ6MGtXZ1RkbWRaczdlRVhoSWZ1TXFRMTVmS1Nm?=
 =?utf-8?B?ZjU1MnZ5ZmthWkYrNjRzWDBZWVBvNzBaK0ZZTlJaak9zREl3dFFGUWh3Y0xZ?=
 =?utf-8?B?MUd3UUh4UzAxSGF0UjdESkFGTERDSHRJb2NZZmVTL3ptazNqTjFjQklsd3gz?=
 =?utf-8?B?bTZvSHJyTkV6Rm5FTmlqM3pCcWRnV2hKSEdhQVk3ODBMYk00V2xHTnM1SE5O?=
 =?utf-8?B?NkxPMFVJQlZoSTk1OUk2QXgrb3pGUWczbm9qUWd2anZlWFFsbFUyTUNSUlg5?=
 =?utf-8?B?eDR3YU9XemVFNkt2amU3WVNpM1NYeWxpQnNNZ1hpOGt1ZG81dkc4OS9tQWxY?=
 =?utf-8?B?T1RJZ0JDcVVmdURQSnBRYlBIZlovVkVTbTBDOWRGS3NpT01NcmhJMnFCaDgy?=
 =?utf-8?B?dnplRGFOeXFXTFhNVEJ2N3RGQ3NBSDNGd3A0TzQ5UmdwNjJFS0R4SXVJVElL?=
 =?utf-8?B?WUhDcU9mdldtaGZlK3JYN0tCTXVadFRQbUtRVGhnY1c0eG92U0lTSUhCSXlu?=
 =?utf-8?B?amE3QTU1RWlUVVhTR0NDdUYwWGJNeGZZemxHRTJIVTdHalV1Y0diSnQxYkF3?=
 =?utf-8?B?bFdDaDMwK3ZyU0dlRWRNSEp0VWtTZDVSQTdneFh0cVhoTWZMSnRFRFBlZTFl?=
 =?utf-8?B?QTRWZXBUd0RmSmNnNUV6aUYxVU9BVTNBSGRFODhkeFMzU1VvVTFhMTZEWHF0?=
 =?utf-8?B?TVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec6af06-e01e-4764-a0af-08db516490ee
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 14:40:57.7634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2xDlScdlD4VGSg/cgnBeOIBCmTqK8fMlK0V4vzkXmYLwTWop0u/fZyeL0rB4xjbhorbIExfZoNnzTqDV0+N2aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5949
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 May 2023 14:41:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11433

On 10.05.23 15:59, Felix Moessbauer wrote:
> This patch replaces the location specific ftp.us.debian.org repository
> mirror by the deb.debian.org version which is served via a CDN. This is
> also needed to enable location-specific overrides of backports using
> DISTRO_APT_PREMIRRORS. These usually only override
> deb.debian.org, by which the packages from backports significantly
> slowed down the build.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  conf/distro/debian-bullseye-backports.list | 2 +-
>  conf/distro/debian-buster-backports.list   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/conf/distro/debian-bullseye-backports.list b/conf/distro/debian-bullseye-backports.list
> index 3a55e4c..f1461ab 100644
> --- a/conf/distro/debian-bullseye-backports.list
> +++ b/conf/distro/debian-bullseye-backports.list
> @@ -1 +1 @@
> -deb http://ftp.us.debian.org/debian bullseye-backports main contrib non-free
> +deb http://deb.debian.org/debian bullseye-backports main contrib non-free
> diff --git a/conf/distro/debian-buster-backports.list b/conf/distro/debian-buster-backports.list
> index f2dd104..e333156 100644
> --- a/conf/distro/debian-buster-backports.list
> +++ b/conf/distro/debian-buster-backports.list
> @@ -1 +1 @@
> -deb http://ftp.us.debian.org/debian buster-backports main contrib non-free
> +deb http://deb.debian.org/debian buster-backports main contrib non-free

Uh, looks like historic left-overs.

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


