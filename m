Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464E6D24475
	for <webhook@archiver.kernel.org>; Fri, 11 Oct 2024 05:42:28 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.86])
 by mx.groups.io with SMTP id smtpd.web11.5019.1728625336301374406
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Oct 2024 22:42:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=JXb0Js3T;
 spf=pass (domain: siemens.com, ip: 40.107.21.86, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GAxu6QSlxVwGXSEtjdyLKHDQDgfvNcX4T5TCRT+dprUNXk+9Ozj/1G/XAvqiWudwmVd5O9gHKBOJMWzt38I70dfuE07rjUeEipCHcIxsb1WJ7FhJHaw89CB6tDFNEQ0TFzDv9dgtUA9sQBoyQl2jBfwcTD0HS42xZt+Qw1xdHxQu7H8m0hwa++gRsM5vga/7rObPUVzAWcNtle1snTZOuyVu6wkrwWAGRaqKLU2wnAI7xNRgfrOutyDcN+tLPiFfPc9sHsM9HuCHPUhYzyLBwgnn16TExU78HLJ08l7dmEUT/u5d1jXMAS4AoNR9gCzlWZ8HhC1vys2DunzRloWSQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0VfV+WaZ9j5Yn0s08/yJe+YZyp6KY4y1AFBBTsI6M8=;
 b=PHnzoA2r7dJ4W1oJzhmtOH1AMy+8/QB4992VelvdReAxQg2MLlWyFsSrMLKCxoClUitqDwza+ZWwB5sGWU4sMG8c8xE4r6svFQH84dNUJgNXh7RlDRUmrBhJfIcr4NgyoQKuqziBhb0pZ1wXfDUHuPZw3c5O7RN3Hg+0NS/Of8vpN86CRBOoOW3jHLl7f7sWC/UJn1EqMC8PZt9OwC+ngFXsLcvsnFjGCjFpZ7t1rYIQdNZPQt3kwWGbmdascF6opbFTuZ6EBq62mqL8J3w8meSpgvovLsRv2JESUV6QUV3xZmMT5ylpXA5pTNEyUwxCFu0KKYAuBqSljozIVSgV8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0VfV+WaZ9j5Yn0s08/yJe+YZyp6KY4y1AFBBTsI6M8=;
 b=JXb0Js3TYC8RqPvFR4Zf1edIvcStNbnRrBp5N72xdTy9RNbLL+vpkfiJVuVzjTP9wsQMSEv4Wjqj8m5BVnljMTI35sPY0SdAuRSzMqnQwC+neTxMHCOugxAKAEHf8e6UT4rpEvCp+IDmUIo+NzUSGog/dvQd5+wtEq7nME7bRgPrR4hOQsE56A0JfWb1hY/eCvR1k2gO7beD5Lv4jz4x5hxB8iXAXMqEI303x2vD2Vc+jf0oiLwpZU0rKJUF+kH1D86nKPPC3mMMQlF3axWLXMOiNE36rkKO4pSa6jBj4fDU9ld1KnP4D9/U9cLiZO9EItLhgJgIejbGcBzd2NOD0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3520.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.6; Fri, 11 Oct
 2024 05:42:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 05:42:12 +0000
Message-ID: <f1511f78-82c5-46ee-b283-22d972dfb199@siemens.com>
Date: Fri, 11 Oct 2024 07:42:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip92,
 5.10.226-cip53 and 6.1.111-cip29-rt16
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 cip-dev@lists.cip-project.org
References: <1728611681-13614-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1728611681-13614-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0211.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3520:EE_
X-MS-Office365-Filtering-Correlation-Id: 4958faf8-bfe3-450b-e631-08dce9b7747b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bW1mV2V4bWpLeXRwY1U3MUJkWlF3TlZ0MjZDTmZySmIwR2Z3SmRQbGx2Q2J5?=
 =?utf-8?B?WEpxa3czRGtOVWJCSDZKSnRHcDhoWkQ3UVZIZ29kZ3VJZVBQVlZiTnpzWWR1?=
 =?utf-8?B?TVBTYmpPTjNDSnZEeUMxd05XUDJ3dno5OFdOc09CanFBeUVWVmV4amI4emZ3?=
 =?utf-8?B?akJYUnZMcGhlbFBPYWJGMytBZUo3TG9MVkdJNXNHRG55TEg2NUdqaGhrQnRT?=
 =?utf-8?B?L3B1NndQQ0xiaURDS3hFdnFITUVXMXl1MGVieEJwSzV1U0FSSmpVaW1HeGph?=
 =?utf-8?B?Q0tsQTRoai94S05tU2FrY1FNSjd6dk5hL3FjbjFIdVMyS1F0YzU1dEZLOGZx?=
 =?utf-8?B?dGhDbnFHaFc2RTQ3aEJrSnFSU2thSG4vWUU2S0g3YXJ3QXFJK1JJcG1kay9h?=
 =?utf-8?B?TjVsWm5nMllENm9ncG00M2JTS25KUVl3TWZ6OEg0dVhjY1ZHck1tZGRIYWg1?=
 =?utf-8?B?VGZFek5YRGJ3bUh0QlZiQ1YrcmJmL1RiTlVHNTVWUTltMDFobnJlWEFVM3Zu?=
 =?utf-8?B?UzN0MmFRNm9ONnpWRlMvMmEwZENwTDdrTHBkMkpmZkcvNHVqZUJwaHRndG94?=
 =?utf-8?B?OUs2d0FOS3R3c0F4UG1TMjloSGZBeDdiYnVYZ0VMa1NMWW1YaHB5VWlxczJR?=
 =?utf-8?B?LzZSWGRRdlhzbjh5dUlkcmF3Q0E3dmtaZHNJdm1Pc0VsSUlkL1ZucDBhcFk4?=
 =?utf-8?B?M3I4UmYzOHFwRHVSTzE3a3ZPeXBJQkpsRDl6Y1ZNZlpuSTVrWEZsZ2tJL0M2?=
 =?utf-8?B?cmFtZUVTaXM5OGxOQkc1VEVCN3VtV0MxSFhPa1V2TjUxbU53MC9penJSUkRY?=
 =?utf-8?B?bW1oOGpmNzJacFFtZGdZS0MwWFpQemZ5eDUvUFhnbWFSMEtIR0QvZVl3WUxQ?=
 =?utf-8?B?VUsxWDk4dG82Z2ltNUI3Uy85eU5RZ2YvMVQ5bTZoTWYweG5waDcvRDRqK1RU?=
 =?utf-8?B?c2FEK1pHRzZVeEd1MFFvY3dFNjNOb1Z5UUgvd2ZtOGlqUi84ZjM5TEg5alJT?=
 =?utf-8?B?emtibGNHWU93RStuQ2FCV21Mb0MzdTJZZENmVGdlcEtSV21YMDEzWElONjdN?=
 =?utf-8?B?WlI2K0tlWnVIQitQNkpSSndEUGJxald1S3I0TEYwcDhSTmhTSUtwWXd4K1pr?=
 =?utf-8?B?OWJiSSsrMGNpUyt3RjJLKzNwK09DS3NmUDhnYlduYUZHcWx6R3R4RjlKblRE?=
 =?utf-8?B?N1pieVdUUUVDeitJQWVWZzR0RVZ1ejlSWjBNbTEwSkhlUEQwZHJzUjgxK1RM?=
 =?utf-8?B?dUt1c2N4RHhCNFZuUnUzbThKUFMvOTlZSE82VUFWWGt3blNKUWU1RFc0VVox?=
 =?utf-8?B?bm9HN0paSDMvZTN5djZFUENRSU1ZOFRrUEF3aWVKVXJhRGtzU2taK09QOERP?=
 =?utf-8?B?cTA0ZHJwV1duYW9adWR0WnBnOTdvUGhVM0ozZ2hWdExvenRzUFZtK01zc1VO?=
 =?utf-8?B?b29UdG85Z0I4Q3dnM0twdmF4TXg0T1RMQSt6cjA1V1ZackZhQ0dhWktaTWpI?=
 =?utf-8?B?a0JJZkpydEFQY0FwS09vVS8yeEZhd09GNDFaV2NxMTgyczUwMmltNDR5NGdR?=
 =?utf-8?B?VTZ4cDJlU1lLaCtEdHh1eWY1NSs0MXluUlVwMmNvWVI4UDlkVkJLTjlWa1Ro?=
 =?utf-8?B?ZSt5VXdteWhtSDlZcnY2cEpIKzc3dmJtUWhDMjUzeGpENllpWUZtMm8rT3pm?=
 =?utf-8?B?QlZPVThsbVB3V0wwTCtEQUQ3T3ozM0E2VEQ4ak9lRWgzZFRwTTBsZ05BPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a2RSeFpyUmw3amdYOVVkaVQxNGV2SjhmN2FpUGZwOU83UytiSHdTT3l0TGIx?=
 =?utf-8?B?U3BuZnpjSW5jN3Ixd2FwdHZBTUlYVTQwZWNGSXRGenpoQ1dqRUtQcCt6RVpn?=
 =?utf-8?B?aDY1eVg0S0gvanlYcjQzTTh6SlZvT0lRQmhtTzJSYmpQZVBqbmFzSnh1UW0r?=
 =?utf-8?B?ZWJ1K3JRN2RTZjNjVUFmanZGUHNYYVpsYm00WVNmU2tCeVh5NUQwenVHSjZ1?=
 =?utf-8?B?TG53T1NvcWVuaVpmMDdhYUFIR0phNnZSOXVVU3VZb0xjZE1pRlhMNGs3TCtl?=
 =?utf-8?B?M1lVS0RzeXJySU1vQWxaNHRWRDRESFo5WDA0TUxyT0x4OFhrL1g1empFNUg2?=
 =?utf-8?B?dnBqS1lxVmlUTitvZlliM1pYNnB6a0JvT1I4MUdaVjBQTlpMc1J1bWY1NEg4?=
 =?utf-8?B?VjVUc2VxaVFuOU44ekhPRnpjZ1BnSEpQdnhGbW0xTFVMMUI1UExTSFZYM3hp?=
 =?utf-8?B?Kytjbkd5UVI0Q2hydnhleVhDYk9hRzlwWU1CV1NrTjJmZndUOERXL215MFR4?=
 =?utf-8?B?QVpWQmYvQVllMVlzSTBlVWRVYy9SZm83NmdrS2JaMElGcVFxUjNZL3prcGYr?=
 =?utf-8?B?MjBqYWdCSDNnQ0pQYTlFL3dBcUd4eFFnaC8xRkpUSm8vOUdrL3VrV1J4blQz?=
 =?utf-8?B?b1JvYVh5Ry9EN0xXNktiMUlMWHNjM29jNmlLM1piaDRKZ050MjBJLzlBZlk1?=
 =?utf-8?B?TDJXWmdaKzlNcUNOSG1aVzJLakpQaHBFdDZvVUVpQXZMRUEyVnliQmd1YlRP?=
 =?utf-8?B?YWZmaVVpOHVMdlFEWkxQbzFtNVFhSHlwZitwNkQ3QmlhVFdBRE1RV1NtaFJW?=
 =?utf-8?B?blZJdG9wRWtBbXVNR0taR2hFSnM4YnkzNnNEOHN4OElVWkVDMEtIUGNUTkFY?=
 =?utf-8?B?SUxUaElmVFdSaFpPWXMrYTFJRFFyejd2NFlWSlQxVDZjVXk3ZXRRRnYxL1Ev?=
 =?utf-8?B?Vncxb1VlQTYvdWN2VEpoNFdNL0tYVUJZWDhLUGd2Q0ovQzc1VkJEeE0zL21M?=
 =?utf-8?B?UUhvcW5yMlNURGRkYnNWdGtYT2R6SC9QQVFUY0ZNUURqc0hxVVp6ekZwZkc3?=
 =?utf-8?B?NHI1M2hLRmpFcENiZ3JOaGN0ZHkralBNNlN2SitUWHptNCsvcWVhZVI4MXVZ?=
 =?utf-8?B?YjZEcWo4ZE1TVUN2NmVBeHIvZDZVd0VCNlJPUHVlRmFoL2VGMWNBSThRakZo?=
 =?utf-8?B?WGpqdmlFaXdjSVlEaGVacmlNdWxDMDJRU2RTYnB6T3VZaDI4dlNwOGlRL2Mx?=
 =?utf-8?B?V3Q4YkVWQVZyeVJXbWtFaERaQk5sY1JvNFVINUt2dHpmTHdJOXltei9oMXJ3?=
 =?utf-8?B?ZEg3TU9aWjZEajFSSVFOeVRXKzRWTUNCNFJjZ1NtMURvUmRZcDlsQmxueUhq?=
 =?utf-8?B?YVRHZU56WitCNDFJYk9tMktOZFpXb1FjZmo5Q0FNdklQNVFtSzRrWDJCbGVp?=
 =?utf-8?B?dHRNZVkxNFkxU0REM1R3dk1ibFoxai96N1Evc2MxZDd3MmxvdmVBRS91Vitx?=
 =?utf-8?B?OXdiUlRMUStuaWEyK09OWXBDVkNpSERDbHVTa2hrbm9nUStMaWI1ZWhqUSsx?=
 =?utf-8?B?cCtwTjJ6ckVHTGlTOW5EemU3eSt6a0pFMHozZWwxeDJZSFYxaWRCT3htRENh?=
 =?utf-8?B?SzM4MUx5d1psa2ErY0Q4clMzSDVBRmYvL3ZvaFd2M2dDZ0xHY0Fsai8wdnhW?=
 =?utf-8?B?UE0rNEhEbjdwTlU0YVlZNUZ4SDBINnVuSzd0cTNPaTZGYTByZkMyM0pONS8y?=
 =?utf-8?B?L0xLU2V0RWZqK3hYS3E3SkhkM0QreUU4TjhIak1jSkx0VFdCelYyTk04bFhj?=
 =?utf-8?B?ZzQ5a1hKZ01JQjFGbU1CQTQ1SzJ3bEdRVjlnQWVjcGh3T1JrbW1PZjJ1RGNL?=
 =?utf-8?B?ci9Ic1RmL1ZpZkZ4aW10TVA5M1M0am1iUmNSWUtOc1JieTBCVFRmOWdxZnZh?=
 =?utf-8?B?SG5DVUVuYjk1TVdramlYUXpRNCsxaWp5aEhzaktQRUlWU3Z0RTRoNVpjNlJQ?=
 =?utf-8?B?bkZZNDRRNTRabDJIUDZBYUV2MDlFdlJWRm12RkY3TTAxdVIxVW5PTTdoc3R2?=
 =?utf-8?B?UmZteGtlY0QyMWhGZWYvVnZIR05vZ1VqbWNWRHZVOUo0UkdPTjIxd2RDZEVU?=
 =?utf-8?Q?bcSWLkY6W/DDacwZ0/OM8loPQ?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4958faf8-bfe3-450b-e631-08dce9b7747b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 05:42:12.3346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tVKtwx8y1c+WgylPzX+2/81KjTvHOxja/YUrNXQKY4JznR5pbnd8QgfKJBB8t8b2mvkYBUdFA6II+l0fyOkT1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3520
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Oct 2024 05:42:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17028

On 11.10.24 03:54, Nobuhiro Iwamatsu wrote:
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  ...6.1.107-cip28-rt15.bb => linux-cip-rt_6.1.111-cip29-rt16.bb} | 2 +-
>  .../{linux-cip_4.4.302-cip91.bb => linux-cip_4.4.302-cip92.bb}  | 2 +-
>  ...{linux-cip_5.10.224-cip52.bb => linux-cip_5.10.226-cip53.bb} | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>  rename recipes-kernel/linux/{linux-cip-rt_6.1.107-cip28-rt15.bb => linux-cip-rt_6.1.111-cip29-rt16.bb} (59%)
>  rename recipes-kernel/linux/{linux-cip_4.4.302-cip91.bb => linux-cip_4.4.302-cip92.bb} (68%)
>  rename recipes-kernel/linux/{linux-cip_5.10.224-cip52.bb => linux-cip_5.10.226-cip53.bb} (68%)
> 
> diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.107-cip28-rt15.bb b/recipes-kernel/linux/linux-cip-rt_6.1.111-cip29-rt16.bb
> similarity index 59%
> rename from recipes-kernel/linux/linux-cip-rt_6.1.107-cip28-rt15.bb
> rename to recipes-kernel/linux/linux-cip-rt_6.1.111-cip29-rt16.bb
> index ee3bd93..f424735 100644
> --- a/recipes-kernel/linux/linux-cip-rt_6.1.107-cip28-rt15.bb
> +++ b/recipes-kernel/linux/linux-cip-rt_6.1.111-cip29-rt16.bb
> @@ -7,4 +7,4 @@
>  
>  require linux-cip-common.inc
>  
> -SRC_URI[sha256sum] = "5296cbb13076f4b7ac24fcb9220f1be5bcf1f28c7e5a00a71b84f67d5f85b35d"
> +SRC_URI[sha256sum] = "486d7c3dc921101a9ec29e829b9d31dd0c1f46533591c7ace572cf201939e2cb"
> diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip91.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip92.bb
> similarity index 68%
> rename from recipes-kernel/linux/linux-cip_4.4.302-cip91.bb
> rename to recipes-kernel/linux/linux-cip_4.4.302-cip92.bb
> index 1d76094..223dcbe 100644
> --- a/recipes-kernel/linux/linux-cip_4.4.302-cip91.bb
> +++ b/recipes-kernel/linux/linux-cip_4.4.302-cip92.bb
> @@ -11,4 +11,4 @@
>  
>  require linux-cip-common.inc
>  
> -SRC_URI[sha256sum] = "25b3bf1d260185ca61de9c13dc3bda6d179c07f992a6511adc504b35bf915801"
> +SRC_URI[sha256sum] = "5eae4b20ea63eeaacdeb11fa8ba17a7beb965711ded3e8bc316ca8250b807cb4"
> diff --git a/recipes-kernel/linux/linux-cip_5.10.224-cip52.bb b/recipes-kernel/linux/linux-cip_5.10.226-cip53.bb
> similarity index 68%
> rename from recipes-kernel/linux/linux-cip_5.10.224-cip52.bb
> rename to recipes-kernel/linux/linux-cip_5.10.226-cip53.bb
> index ccc8b77..59aed56 100644
> --- a/recipes-kernel/linux/linux-cip_5.10.224-cip52.bb
> +++ b/recipes-kernel/linux/linux-cip_5.10.226-cip53.bb
> @@ -11,4 +11,4 @@
>  
>  require linux-cip-common.inc
>  
> -SRC_URI[sha256sum] = "7c3538b79831741991ffe373261264c313c712b9520e746f8336356a621d3246"
> +SRC_URI[sha256sum] = "d85672e4b94d54c9e79dc7f35942354efbb5b463ee6be067bf36eb220f187f02"

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

