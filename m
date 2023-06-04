Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C114C7EE29
	for <webhook@archiver.kernel.org>; Sun,  4 Jun 2023 20:17:04 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.73])
 by mx.groups.io with SMTP id smtpd.web11.24637.1685909819349829236
 for <cip-dev@lists.cip-project.org>;
 Sun, 04 Jun 2023 13:17:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=CQDh98bt;
 spf=pass (domain: siemens.com, ip: 40.107.6.73, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjj2g8EvOE7vusZQXDFBwmznlrW3OYs7v2kAybjrdtFbdCpFzr3eeSZ+Urs6iEN9YC3U6bsr7jx/WE1LCAk4SVZpMaJJEUuKDh4xbBpuJ8qFVAgny5uJRMpmx192ih6flfTE+J6St+mSWhDYfL6wlU71jFPycl5oK0UROftkukHzUUA3ffK0yKBmHK/VkGgVTrilaFxCcn2ozhyTrHdeqfnsIOL+1KK6n18kiZDwh5IbR4I/CgW1DtTojPr50uW31xo0M9B692DXdfRHwvUhEyStZFJ6aU9a3naNPGbiofJUDg+6mqGsSiszmNFNxsRPnJ201JqlXfE6Glii+Bxa1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtiG1d3kECJnTlMCL0hcN13u5nLl3e6zaQy+zyRYXY4=;
 b=f0c+sF5i3clDhoubPALW5Kux36TT+KLBBZd642bBrxubd43kzYnKnzug50rs0TF/spjqU/lunW0VzkHaimMVSemnZpBKy7MgXQprux2MupnO9cvnyjjyZ+QjVFxIUirDo3p4f3znVO7Fg+zuQoP/U1ZlEOPStCq9IdtP3Xm+DZupona5NPNFxooZJUSq2n3lS3qYrpcX8CnOr50ySewtDCtFck4qLMwPHf2UFkkmYb/a3QSeyUITnym8oPs9ePG1+YZWZNm7bdjGZ2mfV6cTqksRn4dRhZbI/1wXXsGuZj3eI5jZLhBiKPCLtFaIaSqbtf5Pe83l3OliwhRWsrSv5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtiG1d3kECJnTlMCL0hcN13u5nLl3e6zaQy+zyRYXY4=;
 b=CQDh98btAVyz0m+/M37TLDCkfOsW5Bx69rSNlDCyVxke51unz1escEXPQf2Huhf9Dsmx6n5i+pumy2CDPWMHEnNQ8iR7GsQ0akXhqopRUIYrmDsnlnKKEd7/KxHn9kU9sFvgwpC583UdrnVIgcpPLUHmDmK+ifhjy4GNJG3ZP8j74SuY9pkhS5WYd4Pq2+JpJ9jO+r7Da97kn3tEho+nqpenTQ00YeSO+4HZ3XfmbTe5T0gPplHk4WBa5M1fst2zulf9UiDQ2PT8RzNYUrqhF2HFh5MYB2XYacu/EVhxS70ZttnF/S+erN6KD71Q1NUHElpxJqea/Ui7f3NhZ5Y/0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6368.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:40c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Sun, 4 Jun
 2023 20:16:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2ecd:9a8a:5601:47e4]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2ecd:9a8a:5601:47e4%6]) with mapi id 15.20.6455.030; Sun, 4 Jun 2023
 20:16:55 +0000
Message-ID: <9ac4b690-e712-6896-f392-b2e6ab817b1e@siemens.com>
Date: Sun, 4 Jun 2023 22:16:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [isar-cip-core][PATCH] recipes-kernel/linux: update cip-kernels
 to latest one
Content-Language: en-US
To: Srinuvasan Arjunan <srinuvasan_a@mentor.com>,
 cip-dev@lists.cip-project.org
Cc: Srinuvasan A <srinuvasan.a@siemens.com>
References: <20230603080941.454533-1-srinuvasan_a@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230603080941.454533-1-srinuvasan_a@mentor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6368:EE_
X-MS-Office365-Filtering-Correlation-Id: d8e99c9b-84b0-444e-d42a-08db6538a46e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	I58G4wW0VBSmbxczfqVZVeHXtLwoAGMfbnHl3OW8Hzu/8l6M/O37YuwxbaleP2jf84TBhDh9TA4RgWbpXGLR/s1vuTGMqBLkFtJ7FmDN8jd/8yJ8MLWbBZHeht+Ehg2gAAdCFJrQD5EgL4yI7JBJBf3tJSjPzQu75+dqAoUmpU9ySx7dLVXdraSGCxPE993hWJ7K7r06wRSJ0qv5nutYhnx7gq5802VNIKBVEnMq07aTcYzxoYgmjkqzuRdhDM+jnPvEkvQeB2owtkCuVQZ/v2BfzT4Y7mQhpUu1hEgn0MG/yZAsv2VQsTCfGyBzY8wluQ7tfZbYFyQ4AnpGrDfNt0rz1T4jO9JNwXCAMfj/NnCTkuxO3ZhBlk9k+uf6pD9xtZwb+HKcghnthbHy1X0mF39Shb7+t9V2K1YqvVBRC3mUZK/Hce4D0gx7CzC7iGs99xguiAJ9e5OuZW8cUftW+RaalMhyiZm39MXOJY0fBRNkDMJp7QgsQD9/WxsGVW0iKU6ZfhZQ7IKbXt9trd3vpeb1vSwTh62/VPlCbHWJUTVe+a1UtLLGL0R+9XjoSkGYW0c7ObG8gvUZSR21cvV1wzHi26pTemqpYDejTIREuGYM7MaAYciR7H/uqeIrRvXAqb5+nzkGL8ZL0K/YokMV3g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(478600001)(8936002)(8676002)(5660300002)(44832011)(36756003)(15650500001)(2906002)(31696002)(86362001)(4326008)(66476007)(66556008)(316002)(66946007)(82960400001)(38100700002)(41300700001)(2616005)(26005)(107886003)(186003)(53546011)(6486002)(31686004)(6506007)(83380400001)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ck9IODA1R3J0MjRTM0tvNnc3VGhmUmxFdHYyYWZ5akc4eHVpdE9jSS9FS2Qv?=
 =?utf-8?B?YXV4eUxaK2JPUjdheHQ4Q3Z0bDJmNHBpRzRUQUF5WVArYnRISDhCTnhJbDFp?=
 =?utf-8?B?NVBLUXdjTUtNMktOMXlUaDJJL1B3dUE0amUxaml2Q2laY252eFdOU2hBVUxm?=
 =?utf-8?B?RmdZQ3F5VGV2ZEZlOTM0VDJuK2g0M0dUK0k5amJxQ3NQOFl5c2gvQ0RqMVIy?=
 =?utf-8?B?VGFWTWRTSWplYm4yc2VyYTN6MG14TjdDOHh0QWJ5N0tNSktkenhNMWRVMDl5?=
 =?utf-8?B?NUdSdEtJWDYxUVA2M0ZpR2cxbkNtcG9nZ2JrZ3Z6MWw1aXZuY2l6Z3pScnBJ?=
 =?utf-8?B?ZFU2SVIyZ0hrbDJDTmM1UG9pN1B5Nk9uSVZqdkUvY3lId0FmTEk5b3MzdUFS?=
 =?utf-8?B?U0RGRTVORk1UeG15RlRhT21ra2VQTjIwVzQyWFh3UUNFVnAySTdYNlJsS0RG?=
 =?utf-8?B?eEFPUXhWTVlDS1YyaFpuT0l2MThHNXpLeW91eStnQlQzdmJFL3VZRUhZVjB1?=
 =?utf-8?B?TENSVHE5d1ZwOVYrMldYWFJSVzFaYTZFQzBJTXV3VGQrZU1HNCsxWkgxR3Rl?=
 =?utf-8?B?NzdNUmh5a25KNDRrMGYwN1ZJSVl1L0pibGFlZHlwUnpNc3JpQVV1Y09qTnRM?=
 =?utf-8?B?bzQxbEZKN0R3NnExMjRQaHZ5SmxTVGNyYVFrVzI5dmVxS0hqczlLRTVnNW9S?=
 =?utf-8?B?aUUxaEJ4Yk0ycjZNMDg3UmJBdFNvSS9saXZGUXdOTmxxMk1UQWk1U1RUeXFK?=
 =?utf-8?B?WE9HaVRBWldJVGhPbjFjckpPUys5dkVBOGdEVTIwY2RueHZpNkU2YjZGZ3Vh?=
 =?utf-8?B?NlVMTlhhQ2J1RVoyRFd2bHUwZlVaUHUxenBXYWp2eDYxMG1hRlFUelVpbTc4?=
 =?utf-8?B?d1dSc1JINzhUTk5CanZsdnFJeHNQeEkzZDZObzIxTFVjblVIYmFkajdOcWE2?=
 =?utf-8?B?UUlYTmpUY3pzR0ovRzhVNGxWWmlaV1FydU9QbVd0Q1Vuc3lEUHh4SzM1Qkd3?=
 =?utf-8?B?WGdMVHo0WVVib2FINHE2bnNaM2xreUdmd0lRREpwdVZiTUcrTncwbElYKzl3?=
 =?utf-8?B?cWRsdytEMFY3SXRIeTBNb2JsZ2plbFlsUDRuYmJhNHdKUTdpRmVEeUY0VWpq?=
 =?utf-8?B?a0oyWk9MZFBCaWN1RzhmTFN3cDBMWXlIVTlrYnBPdVlkcGQrZ1dzSGorczdP?=
 =?utf-8?B?OTdkUVdielk4WFA2YmxYZDJ5MGFJZjR5LzhrT0xOdzlNZklGbFlHU0lqR3Br?=
 =?utf-8?B?dDBRNEM4QVRkQlcxZEFUNThXdlZlR0JDYlptZzdVSzhpVGpjdkJ5blRjNTE1?=
 =?utf-8?B?K011WkpoOGVBUHBGekRrNzd1WFZ2YTNObERpMEV4dCtiZCtaTks3QnRmY0ky?=
 =?utf-8?B?Z0FzZmp5NldRdDR3YllsdmxKa05EWVNRRlNKbGZuN1BhVys4TUNVNGY1cU1K?=
 =?utf-8?B?RG56NW5Nb2hrOUJlZSsrSFh6ZU43YkVKUUFqZ2FsVFBYWGhINURxeWNrWkVE?=
 =?utf-8?B?QkhMSmhMdko0RVpKMStmNFZ4YWQzRlN1b3RIZU5Ebm5DN1lBOGtTM2plVkYr?=
 =?utf-8?B?V0NGbGVWRGM3dit6WS90ZDI5dnhBaUZpSkhweFdzaEpsNU5YekIrcWZoMzF3?=
 =?utf-8?B?cEFxTnh6SThvcVptQjltWHFoVUY4UGwzeGVwSGZnaUtZS2VRRjUyUHJGR0o5?=
 =?utf-8?B?dTNSVVNPNnlPYjN0ZVMvcHYyQzA1SkZtS2tZaXJ2YzRhNEdJcUg2L2RrV1F2?=
 =?utf-8?B?RUdHNWQyVG9MU0YxYWUyRjVjUk5yWFczUU4zdTlWTEpjUC85eW44eGl1NEVO?=
 =?utf-8?B?Q0xLOHFrL1IyS1R3UW9Oaml1QmsySUhPb3VOU21HWWlvTGRqTzZuK25LakFY?=
 =?utf-8?B?Mitoa1M1V1JiOXVGTk82cUk1cSt2VTU1dzVVNjJZcjRtdzBWS09CdDJoRDNS?=
 =?utf-8?B?Vk1MR2Zhc2JJd05BVlhBNExOSW5ITG1SMTVVZjRvR2Z6TWVWVVlCT21NalR1?=
 =?utf-8?B?TkMzVkdCRHpuVFlUK3pzZ0ZuYUdMUFV2d2swbVZ0dnV0MWFTcmNoTEJqSjhv?=
 =?utf-8?B?b2RpWUJ1dmNZTy9uNWtLZjkyTGcwS01qYUhPOWZNR2JTZ25Cbzd1ODhRQ3Rt?=
 =?utf-8?B?VVNJNVk3am1hVE1HdWRCdXpBY1o2ZXR5QisvSjVMc3hrcWt6aFIrK21qMzNL?=
 =?utf-8?B?cUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e99c9b-84b0-444e-d42a-08db6538a46e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2023 20:16:55.6541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ik8GzYc1DHIMoQQhdzeoxD1XLD4YkUD8JPbk1SpM1AcEaGxEc+dhdFSmb9eyzLBzfzOP4XZJ66d8uTwhGxKYZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6368
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 04 Jun 2023 20:17:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11759

On 03.06.23 10:09, Srinuvasan Arjunan wrote:
> From: Srinuvasan A <srinuvasan.a@siemens.com>
> 
> Update cip-kernels to latest one.
> 
> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> ---
>  ...19.277-cip94-rt29.bb => linux-cip-rt_4.19.280-cip95-rt30.bb} | 2 +-
>  ...10.175-cip29-rt12.bb => linux-cip-rt_5.10.179-cip32-rt13.bb} | 2 +-
>  ...{linux-cip_4.19.282-cip97.bb => linux-cip_4.19.283-cip98.bb} | 2 +-
>  ...{linux-cip_5.10.179-cip32.bb => linux-cip_5.10.180-cip34.bb} | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>  rename recipes-kernel/linux/{linux-cip-rt_4.19.277-cip94-rt29.bb => linux-cip-rt_4.19.280-cip95-rt30.bb} (72%)
>  rename recipes-kernel/linux/{linux-cip-rt_5.10.175-cip29-rt12.bb => linux-cip-rt_5.10.179-cip32-rt13.bb} (72%)
>  rename recipes-kernel/linux/{linux-cip_4.19.282-cip97.bb => linux-cip_4.19.283-cip98.bb} (72%)
>  rename recipes-kernel/linux/{linux-cip_5.10.179-cip32.bb => linux-cip_5.10.180-cip34.bb} (72%)
> 
> diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.277-cip94-rt29.bb b/recipes-kernel/linux/linux-cip-rt_4.19.280-cip95-rt30.bb
> similarity index 72%
> rename from recipes-kernel/linux/linux-cip-rt_4.19.277-cip94-rt29.bb
> rename to recipes-kernel/linux/linux-cip-rt_4.19.280-cip95-rt30.bb
> index 1a26973..d973b94 100644
> --- a/recipes-kernel/linux/linux-cip-rt_4.19.277-cip94-rt29.bb
> +++ b/recipes-kernel/linux/linux-cip-rt_4.19.280-cip95-rt30.bb
> @@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
>  
>  KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
>  
> -SRC_URI[sha256sum] = "1fa134ac4daa88ffb2c787d05358c1039df1f350b3953b879b6ffb207d3374ea"
> +SRC_URI[sha256sum] = "dfe9992d937c47f2f5a79ddd2156fd4ab749c9d82ef04506dfa8da6cfbb594b0"
> diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.175-cip29-rt12.bb b/recipes-kernel/linux/linux-cip-rt_5.10.179-cip32-rt13.bb
> similarity index 72%
> rename from recipes-kernel/linux/linux-cip-rt_5.10.175-cip29-rt12.bb
> rename to recipes-kernel/linux/linux-cip-rt_5.10.179-cip32-rt13.bb
> index c58e8b7..83f387e 100644
> --- a/recipes-kernel/linux/linux-cip-rt_5.10.175-cip29-rt12.bb
> +++ b/recipes-kernel/linux/linux-cip-rt_5.10.179-cip32-rt13.bb
> @@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
>  
>  KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
>  
> -SRC_URI[sha256sum] = "60763c904a70b1596deb5d65a3260de2e8dbe0583b411b55a5b9a90edce16104"
> +SRC_URI[sha256sum] = "2106be5c70ee7d0074fb6767265a3613ce593dc4a5a46dcc6bf98697f251ebfd"
> diff --git a/recipes-kernel/linux/linux-cip_4.19.282-cip97.bb b/recipes-kernel/linux/linux-cip_4.19.283-cip98.bb
> similarity index 72%
> rename from recipes-kernel/linux/linux-cip_4.19.282-cip97.bb
> rename to recipes-kernel/linux/linux-cip_4.19.283-cip98.bb
> index 6585a58..b12fb6b 100644
> --- a/recipes-kernel/linux/linux-cip_4.19.282-cip97.bb
> +++ b/recipes-kernel/linux/linux-cip_4.19.283-cip98.bb
> @@ -13,4 +13,4 @@ require linux-cip-common.inc
>  
>  KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
>  
> -SRC_URI[sha256sum] = "823a355cf0d6bf39c5ad96cfd2a6dacf652ac445d61bf61b0dc3754e7a24dc05"
> +SRC_URI[sha256sum] = "6d8474aad8621163f1478fcd110f391863ee2ed5180fccb4613c2e3eccc2e4e6"
> diff --git a/recipes-kernel/linux/linux-cip_5.10.179-cip32.bb b/recipes-kernel/linux/linux-cip_5.10.180-cip34.bb
> similarity index 72%
> rename from recipes-kernel/linux/linux-cip_5.10.179-cip32.bb
> rename to recipes-kernel/linux/linux-cip_5.10.180-cip34.bb
> index cc06549..9b812b7 100644
> --- a/recipes-kernel/linux/linux-cip_5.10.179-cip32.bb
> +++ b/recipes-kernel/linux/linux-cip_5.10.180-cip34.bb
> @@ -13,4 +13,4 @@ require linux-cip-common.inc
>  
>  KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
>  
> -SRC_URI[sha256sum] = "526ce38dfee520233b9af1ff714ee69ad528c986c7d051aabe6b3726ea53832f"
> +SRC_URI[sha256sum] = "6b715945aa287b93fa8e69086988a76b3d0f1e5da82caad47dd653baac3bfd55"

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


