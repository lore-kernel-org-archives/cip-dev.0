Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5658FC3ABA9
	for <webhook@archiver.kernel.org>; Fri,  2 May 2025 07:59:57 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.65.15])
 by mx.groups.io with SMTP id smtpd.web11.14417.1746172789921511858
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 May 2025 00:59:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=lyMtemyx;
 spf=pass (domain: siemens.com, ip: 52.101.65.15, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pBvTovTK7pAIuvMb7tpdZ4tK8HGWFoNApm8jHnDRbkvcDayA/0Mq6z8YTCIGt46Eer3iyzBXdWI1ZvwD9o7Be0xA9xQLakM9qWFwpvodGMUkeQ6HGL/gmOuv8/mIUZjsvDkKmOZvrR4JuiDEWcm7ew+cXL4+c1XQAewf06k8KOj3ULElmXy7uxMVn91uqycaGMJaY3+VQM7X/2zQ7EWOMGp+6w8Fv5zkpr9+A5TxeZB3f7jhxOzM3J3heHa4w+cszEbKtzX+wP0QXsgUh6zdYt05nsJXrn/02XM8IvuVHhxbUBGpcO6iDL9wOtu1D2l18ugUT7sDuyFrhLijzIV2Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jD+OQLMvxc8rXYvbigqoysz7pjXhDa/HahHO+DIMiQ=;
 b=SH+XPy+DteCEtyS5E247l/kxz39CyBU80thKmp4UZgZTBqEf6yP5LebgWJoyjqXolXy8xt6SuozCrY+NUJ0dGUF8Y7TCGN3rdJmwdLDhNe4NW45Xh/18lPUcI8ie4ahMPbr4MqRro2PZ6GZ/rwArGxSeFVFG675/QuxbXGfADdg6szx7N5HCB9S5YOCaWIEePVUAiHCqy/Unlsj5mFZ4zzaKPQXSpM2esq02/yshWnrm69UJ6Opkdp2vCrpkPamR4+XqsQCtdNIuvGTVWUyb5P0wbqwh+EWMCkzDb+jvsz7ElHbpCLkxo7mt1GJJ/l5cdvAYMk5he4XQNGvX5O7zqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jD+OQLMvxc8rXYvbigqoysz7pjXhDa/HahHO+DIMiQ=;
 b=lyMtemyx76u8HQ/EdQZv80t45Hra3nk2lieoQmciHNS9uX63dlFFdSI5JJjXk7SP3a8zoV9Q+EdogT1gvaS7kFEPbFEK8YW+IQ1sUTCAu9iLe/oBxZvuYpAoawXI3C2DGrRJ9JRi7CSiVH0fKLRyC28Sj9sHDE/6B8vCtUIWl6mICQh/SDYvZMWptvrKf0imk3QJWPDEksb1tZYzOmndqnjNBsRsT/HxKf7FZBnTT+hObq3EOn+CzOLU1/fF0Yd4siYDBT3Bt+OWl8BDzY5W8CthkN6pUtCMFayUTWM6ipVuIMPhIbtC3Q1PJqaLudtLFHDpycHNzLIqHvvgY7duLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3469.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Fri, 2 May
 2025 07:59:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8699.019; Fri, 2 May 2025
 07:59:46 +0000
Message-ID: <24992418-f286-4c04-a3a5-9417a0aa4e24@siemens.com>
Date: Fri, 2 May 2025 09:59:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 4/4] port abrootfs env handling
 to new kernel cmdline infrastructure
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com
References: <20250428113325.3208873-1-Quirin.Gylstorff@siemens.com>
 <20250428113325.3208873-5-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250428113325.3208873-5-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3469:EE_
X-MS-Office365-Filtering-Correlation-Id: a98a855b-93c9-40c6-74cd-08dd894f4e30
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?S1lzK2psdzdBNHpNR1R0TlJCT29LdjlqbmJVc01HL0VSN3F6c2lPUXI2aktJ?=
 =?utf-8?B?dEFzM2xEYlU2RUxwMmhGaGFEWkppV2Fkd0Zkem1CdlUvNWY5SEdpS0hVZ2p1?=
 =?utf-8?B?empGY0lnOVJJd29MS2NsRkd2SWRUYURQMWplZmRyc01FcUkwa1h4NXBLNUNL?=
 =?utf-8?B?Yk9tOElnVVpQQWNIWFFqMmkzVlF3RHpibzdoMno3bjhGbWwvVTBQMVdoclVL?=
 =?utf-8?B?dzZINEYzWGZKSU14eENObEtPcUdCZjQ5ejJxS2hkcmdWZncvak5SRXdubW9q?=
 =?utf-8?B?VUhBWlRiMXgyczNoeXV4cmhhQlpxTGhKSzFoNTBkZ1AxOTZQNmErS1lVeDZX?=
 =?utf-8?B?dFR2TTJmTkgwMU5yWDJmWGx3eDZMUEV3VHhYUDZjRUo4d2JaT0lKY0lTbVNo?=
 =?utf-8?B?K3VjdkRXUDRKcXFURTZiTUNsMzN4blZlemxHcG1xTU9rOWcyWGZKM1Z1ZkVM?=
 =?utf-8?B?eDlYZVRISWZYOXc0dHJIQlVIdXVwUEVRNHhGQUtPVW9sWDBQSE5tU1VsQzBV?=
 =?utf-8?B?VkVxSDZockVueUFCZmdVaFVvQkRBZlRtZ1NsQkZEdTZVcTVkdDQ2TGYrTUsv?=
 =?utf-8?B?UlJiMVY2TVBhNkNmV3p6eENWbStOemJhdUtHZGpkT1hvNmtwOU1rcVRLb0gw?=
 =?utf-8?B?WXVFTGpjaDR3U0JQenRzUktzS2o1b1d0MHdDYzRkTUFpalJBTTlCR0YyT0kv?=
 =?utf-8?B?T3UyS2VidWg1YWZ0ZnAxRG45SmR4clVXUVJCcWFNSk9nZHdzbkJoY1UyQmY2?=
 =?utf-8?B?Z3UvYUc3OHNpUzl2dDRLcXFLK1hjNmllSm5FOCsvMmVlYUpGejVrR2JqdS94?=
 =?utf-8?B?TmhtYmFlYW13ZDVNVU9YWjFiVThzOGZNZ2xUYVEwWHZzZ1VtVWhieDNqNXVL?=
 =?utf-8?B?bm0zV0g3aEFYKzhtRkJtRGhyaEZSMWdmWW1wTGFLK3I2UkNSNnR1cEZwSkho?=
 =?utf-8?B?cENpKzlUQ3F5ZnpYeVhhRmFVZkM5ZGhYcUF3Ylo3TjNkYmVUbzZCd3RkbUIw?=
 =?utf-8?B?WS92cmF0dk8zSDRNa1lCeXdod1FQcG4yWXEveXBxTFJiTUtKemUxVzBpdmpL?=
 =?utf-8?B?Y3pHdGVqK0gwSzhnWTJiTklKVUh6VmVGZWdjRGNVRTdtZVhVN3RmcFV2OEJN?=
 =?utf-8?B?L2JTeHBFL0JuLzhnS0JjMmJEdFJXU20wT3ZUNzFxR0dSYmlRRkpSTlZrdnRI?=
 =?utf-8?B?VWVMUUNOWGpUQ0Y0MURRKzhud1EzbDBVK0xLaTliSnN0aDR6S1hGZUdkRXhW?=
 =?utf-8?B?eTdBZysyMXpQU2hWVlY4STQ3cHc0WEczMk5pazgxU2ZTc1luaGpBcS9mUHhG?=
 =?utf-8?B?aFhqaTNlNlUwMlppMGdEUE8vV2VualBLM1NYKzhKUkZEZU11SUdxUFBlSHRq?=
 =?utf-8?B?N1VpOEc0N05lMXIzQ29RZk1XVE8yV2dqSWtqY0QwTzd4cU9aTlN5MVFNTWVv?=
 =?utf-8?B?RllmakhuaVgrbUhLdWxxaE9qWjI4ODNIWVZxU3Z2aGppenl1azREeVJDYkI3?=
 =?utf-8?B?Vjd1Tmc1ZjBxQ3VRRjVVZ011aFJEQXJzNWxJL0VCaEJXcEFZdEVNb0FPTDJB?=
 =?utf-8?B?ZzVVWnVHRWNyclBTcWlIazVWN0tHV09qRDExYlVDWmcxRXFwWXVmOHpVMlhs?=
 =?utf-8?B?MXNURlJwQi9SYURFSTNLdkowbE00Y2RPQTJZaFBxY2tNcW1acjVIL3R1YkxV?=
 =?utf-8?B?QnhtYUNXK1FwOGtmdVpoRmdRcXdvMHQ3V3Jvb1pvYlZTRzQwV1lVU2NhcjMr?=
 =?utf-8?B?N25aOHpYek5lOC94WDhkem45b2E3TnhsajV6cm9Ublk5blFOZU5tVUw0cUJu?=
 =?utf-8?B?UmVrN1VUQjFLVzNtc2RWUncwYkNUQ01hREl4NDdIQVZmR2h5V0g1aVpUVnJ3?=
 =?utf-8?B?YXp1cHZqelZsUDF5eUxOSFNld042ZDFOSGtsTG5WOTVUNU93MTZJS2NUVTI0?=
 =?utf-8?Q?jEB6SWQ1n5Q=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZEFTa2ZnTVZwanQwZStlYWg3eFRPcXhtZElYT2owSHhkYjB5QTcxVXM3NVNh?=
 =?utf-8?B?VzJ4U1NVTE8zVktIbkhtUFoyRVFHcU9kTGVLUXQvTWNRbU9GSVhhcnlGejBP?=
 =?utf-8?B?ZytkTzV6dmp3aVl2S1VlWU9BaU9FL1pFNXRBV0FqRDVjdXptRUFTc29MUU1K?=
 =?utf-8?B?THZuSFFjVUFPMnFueVJ2Zlk5b0RRY2dJcDk1SVVNNkg0bUE1MkNHTHdVMWlC?=
 =?utf-8?B?d01pN1Bjd0dKOUt3cE5BOWc4emt6a055dzhkMkRWTnBndjFsa0ZRcVk5WEFU?=
 =?utf-8?B?UnJqQkxEQTlZVjNmNERSYU5jQ1Z5K0VEcUlqMW42b1lWTDgxeElSMVNTcUFn?=
 =?utf-8?B?MUEyanlpVTJuM3hURFRHRGlra3dTT0l6OUdvdXNyYkhwSmR6azIyNXFjQldI?=
 =?utf-8?B?ano5NHZYelhpZHc2dGtWYkh1cHI4WEp0b0JuUDZxMjdPVHBJejBsMnFLMWx3?=
 =?utf-8?B?djI1WEh4ajRNYXBrNnl1c2Y0WEVVd0xETFhsWkFQZHV4T010SG5senNLQzFZ?=
 =?utf-8?B?WFJsQ1VOaVZLeXdMZ2VLNi95dSs0b0JDSjNic3NJOE9ZTWNVMm16VTNIelBN?=
 =?utf-8?B?cTA1RkpCWm9Qb3gwRGNVb3dKbEpwb1JYMnFuM2xGa2xhVktjc1QzL1Q1SlRp?=
 =?utf-8?B?MGtqVkN4aHQ5SmpJZmk5VEd0dXNrRy8raklNbE5TQjg5ODVRRTJxaE10a2FJ?=
 =?utf-8?B?TkJjRzhYdVpTOUJMWlVKT0hmQUpRdEQxeW5KeWNiYmx0a2ZyTDBxUmFJVENz?=
 =?utf-8?B?ZzJnRVZzaG9WaGRieWd5YmUyZGRtUzkramJhWENTQk9VQU9uSkY4USs0V1BE?=
 =?utf-8?B?REQyVURpQXY0aEVxemNKbS9lOE91anFpbUV2dXA2Q1k5NXViaDh1ajU0Qk5p?=
 =?utf-8?B?VnowNFZpS2g4N0VyTk5ScW9BQVRCREF3U0YrM0xEeWRCS3N5VElZYWFZdGhL?=
 =?utf-8?B?c3hsdDhPTTVnV3RBdjF4WHZHbkExT1RaUTFIRytMdUdHRlp0UFQ1bWV0WEZt?=
 =?utf-8?B?bFdsYThUT0JjVFBuQlc2ZWhuVVBEZWVYd1c4KzExMll3RW5aYndWbys0Wm9h?=
 =?utf-8?B?TkJtR2ExaHdLK3VPeGtEQTh6dC9KVkd5ZDBLZXJwUUJCWWRMMWJsRUM1bFgx?=
 =?utf-8?B?Z0RIQ2l1SVp1djlwN0dIc2wzWGlacWN1L3hLN3ZTTm1yOGs1MGRYQzRvNVI5?=
 =?utf-8?B?eXBYNjFSVjBSb2dnTTRWemVDdFIxVXhJZDYydnhTSUx5KzBXM0o2L1VTZlc4?=
 =?utf-8?B?Slp4YldtZ1hkZThUTm1tM1dKOWxkemQ1cnB3MTI0NXYxak4zaThJOHhpaUhn?=
 =?utf-8?B?K1hCNlhzVy8wZHkrcWoyK3VFSCtSOEg1ZmlxbkN0di80MC9rKzk2RGFCdTZS?=
 =?utf-8?B?dGhMSFpodWJKd1FNdlZmRVcyb2NyWmxaTEN1VW5MVC8rcFJoRHpxVFV0NmpZ?=
 =?utf-8?B?VUd3MENwTFdVeEtvbTFjek5nbGFtUUhDM1pEeGRzL0twWHJ3OHEvUVVSSlVo?=
 =?utf-8?B?TDhRa0J6VmI1ZzV6eGxNV3hZdGk3OFNHR0llWS9yYTQyUHJ6dWNzWGpzV01v?=
 =?utf-8?B?R1krc3dFVmJrdldXenJHeWxBM1hnWWwycHRXMUJadzQraXVMOHkzRFI2TFE0?=
 =?utf-8?B?OWkvbTM4TEdBcmY0OW1jeGQxUklYcjlCOEVMd1hJZWJUTHVrVWo0Y21VMWZo?=
 =?utf-8?B?L2V3d210bk1CVVJXejN4ZlZtS2RKMU5RcGZHTUJDS201WjN0eWZJbVVlRWtP?=
 =?utf-8?B?M05tcytNN3Z4M2c5NWpDc0M1VXEzK0k4VHZnUER1Z1RxbXp6QWcvMWkxdUI3?=
 =?utf-8?B?VnJDNmZIOTEyd0t0Y0duNHlUdU1nUGdVNldIOWU0aktqbk5LSFhQV3NRbkV4?=
 =?utf-8?B?SVcvOWdZYi9OSnFoalNwZ2JaT0E1Y0dJTjVjalNQV0Y1TkxKa2Ywd0tYRnVu?=
 =?utf-8?B?Z09kUnUrUUNVU0s1a1V1NnZVdmFNYnNBZXRicndNQmZNRjhNQjF3MElUL3VP?=
 =?utf-8?B?ek82MzFMYVhCWTFXUkliM2FlR1Ewby9lZGRTWXdTaUkwNXhabVVMTUl6Yy9o?=
 =?utf-8?B?QXhubVRYc3djZ1NOdXFqZHhISDFjMlhSc010ZFBFU0loalY1Z3NjQk92OHpX?=
 =?utf-8?Q?v8ihTi2l/aKxRXdX0ouToAyYH?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a98a855b-93c9-40c6-74cd-08dd894f4e30
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 07:59:46.5306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CL5XHIhHocF6hAVFEtg3sEWMiqjP7eZsNzSPhXB0C5paONwCLh3ODFSPwFgDjLO5vYVAG15id/TgwyRXETUkdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3469
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 May 2025 07:59:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18752

On 28.04.25 13:32, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Previously the abrootfs env was injected as file into the initrd and then
> sourced at runtime. As we now have infrastructure in place to add the
> abrootfs env to the kernel cmdline, we replace the hard-coded values with
> logic to extract it from the kernel cmdline. By that, we also remove the
> dependency between the initramfs build and the abrootfs creation, which
> reduces the set of dependencies (good for caching), as well as increases
> the parallelism of the build.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../initramfs-abrootfs-hook/files/hook        |  5 -----
>  .../files/local-top-complete                  | 21 ++++++++++++++++++-
>  .../initramfs-abrootfs-hook_0.2.bb            | 21 +------------------
>  wic/ebg-sysparts.inc                          |  4 ++--
>  4 files changed, 23 insertions(+), 28 deletions(-)
>  delete mode 100644 recipes-initramfs/initramfs-abrootfs-hook/files/hook
> 
> diff --git a/recipes-initramfs/initramfs-abrootfs-hook/files/hook b/recipes-initramfs/initramfs-abrootfs-hook/files/hook
> deleted file mode 100644
> index 6d4a612..0000000
> --- a/recipes-initramfs/initramfs-abrootfs-hook/files/hook
> +++ /dev/null
> @@ -1,5 +0,0 @@
> -# Copyright (C) Siemens AG, 2020-2022
> -#
> -# SPDX-License-Identifier: MIT
> -
> -copy_file library /usr/share/abrootfs/image-uuid.env /usr/share/abrootfs/image-uuid.env
> diff --git a/recipes-initramfs/initramfs-abrootfs-hook/files/local-top-complete b/recipes-initramfs/initramfs-abrootfs-hook/files/local-top-complete
> index 7048ced..c6095d8 100644
> --- a/recipes-initramfs/initramfs-abrootfs-hook/files/local-top-complete
> +++ b/recipes-initramfs/initramfs-abrootfs-hook/files/local-top-complete
> @@ -30,7 +30,24 @@ prereqs)
>  esac
>  
>  . /scripts/functions
> -. /usr/share/abrootfs/image-uuid.env
> +
> +load_abrootfs_env_from_cmdline()
> +{
> +    set -x

Debug left-over, I assume. Removing it on merge.

Jan

> +    abrootfs_opts=$(cat /proc/cmdline | sed -n 's/.*cip.abrootfs_root_options=\([^ ]*\).*/\1/p' | sed 's/,/ /g')
> +    for opt in $abrootfs_opts; do
> +        key=$(echo $opt | sed 's/=.*//')
> +        val=$(echo $opt | sed 's/^[^=]*=//')
> +        case "$key" in
> +            target-image-uuid)
> +                TARGET_IMAGE_UUID="$val"
> +                ;;
> +            *)
> +                ;;
> +        esac
> +    done
> +}
> +
>  
>  find_root_via_image_uuid()
>  {
> @@ -57,6 +74,8 @@ find_root_via_image_uuid()
>  echo "ROOT=/dev/null" >/conf/param.conf
>  wait_for_udev 10
>  
> +load_abrootfs_env_from_cmdline
> +
>  case "$ROOT" in
>      PART*)
>          # Root was given as PARTUUID= or PARTLABEL=.
> diff --git a/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.2.bb b/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.2.bb
> index 592f305..f7569e2 100644
> --- a/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.2.bb
> +++ b/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.2.bb
> @@ -15,26 +15,7 @@ DEBIAN_DEPENDS .= ", util-linux"
>  DEBIAN_CONFLICTS = "initramfs-verity-hook"
>  
>  SRC_URI += " \
> -    file://hook \
>      file://local-top-complete"
>  
> -ABROOTFS_IMAGE_RECIPE ?= "cip-core-image"
> +HOOK_COPY_EXECS = "lsblk sed"
>  
> -HOOK_COPY_EXECS = "lsblk"
> -
> -# This is defined in image.bbclass which cannot be used in a package recipe.
> -# However, we need to use IMAGE_FULLNAME to pick up any extensions of it.
> -IMAGE_FULLNAME ??= "${ABROOTFS_IMAGE_RECIPE}-${DISTRO}-${MACHINE}"
> -
> -IMAGE_UUID_ENV_FILE = "${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.uuid.env"
> -
> -do_install[depends] += "${ABROOTFS_IMAGE_RECIPE}:do_generate_image_uuid"
> -do_install[cleandirs] += "${D}/usr/share/abrootfs"
> -
> -do_install:append() {
> -    if [ -f "${IMAGE_UUID_ENV_FILE}" ]; then
> -        install -m 0600 "${IMAGE_UUID_ENV_FILE}" "${D}/usr/share/abrootfs/image-uuid.env"
> -    else
> -        bberror "Did not find ${IMAGE_UUID_ENV_FILE}. initramfs will not be build correctly!"
> -    fi
> -}
> diff --git a/wic/ebg-sysparts.inc b/wic/ebg-sysparts.inc
> index ab6c817..7052813 100644
> --- a/wic/ebg-sysparts.inc
> +++ b/wic/ebg-sysparts.inc
> @@ -4,5 +4,5 @@
>  part --source efibootguard-efi  --fixed-size 16M --label efi   --align 1024 --part-type=EF00 --active --fsuuid 0x4321dcba --uuid c19e7e9f-bacf-49a6-b43d-2fc18d2a8d03
>  
>  # EFI Boot Guard environment/config partitions plus Kernel files
> -part --source efibootguard-boot --fixed-size 64M --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2" --fsuuid 0x4321dcbb --uuid e8567692-2dfa-459a-be15-f6e5ddcc8f49
> -part --source efibootguard-boot --fixed-size 64M --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1" --fsuuid 0x4321dcbc --uuid 94b2174d-c792-4e8e-8a34-b506e2927937
> +part --source efibootguard-boot --fixed-size 64M --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2,abrootfs_root=y" --fsuuid 0x4321dcbb --uuid e8567692-2dfa-459a-be15-f6e5ddcc8f49
> +part --source efibootguard-boot --fixed-size 64M --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1,abrootfs_root=y" --fsuuid 0x4321dcbc --uuid 94b2174d-c792-4e8e-8a34-b506e2927937


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

