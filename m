Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1ACC30653
	for <webhook@archiver.kernel.org>; Wed, 26 Jun 2024 13:20:30 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.72])
 by mx.groups.io with SMTP id smtpd.web11.26536.1719408020557553428
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Jun 2024 06:20:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=TwHCFU4m;
 spf=pass (domain: siemens.com, ip: 40.107.105.72, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWeDV5+NyiG++uzy0FbRBm0mwtTXsFMx9vYumISsj0XCy31ixcIff/uNRgNw/VeIXvSHgr2w8F9t8pZWYzTw6HeEs6sB96HrLln14ExUCNHC8TW7oKo4YvQDyGYBQlM3bDGDMPXWZ4Pz2o8PXRH3VXiRef26c0FA9wOn3sJLt1cBVp38JabR6b4OZEr4Guvi6jbVlp8dKvolq0IkrtADLIjSgu7oXC/1q1YBLLQYvWCtVcwwU+wuYzzFpJuhqcjj6DlGypg+RvGk+RuTp0eJbLRM/V5ZbrgzSObizZ4RvLF0YxkWXVOOx1mE09sM0sbQ7K9325+tpmge0OLOcdq6JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxHfC80Rj1pWNYefrC1OEQP2vMJY8OTr5alATANtL+g=;
 b=V8Bo4H+qf1ZE/O4LQXE26WrMGMiC93HNYLFKJmpJ8dMrLP8+JMG7u/qmfIrpjvd4ptdg5ecAoZ0d+A7ta+ZzgRNsetMwlKHfbIEd54nUxEcvJ92F0/BI/44FTy41/Q5pktnZMZfFci/p+pq3gtQo6L98GPoRUdMqXYfk0J0oncAlcDZtTNNh0NCX7P8gsWZ/5HEum1liOSedqa9eY6WV7ouZF61DUpHFHimfr1iQKAu857AroHutDn8amp+HLpXaqkn7AwJJgmebJQMrZEnr0OK+fdU5wmf4lQcRf0G7cI8MM0EApnxCwM6XbegVFIfT65IrmaBXZldT3WXiiiqxGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxHfC80Rj1pWNYefrC1OEQP2vMJY8OTr5alATANtL+g=;
 b=TwHCFU4m8o0zeeq8E6S5uztDGrS95iR1KRt6uNYsi9FMFPXLHoxxAQvnXhW76hg6h35zXB1IZI8dhHAQJPq1JT65YCGNQNQ5sl1XELldHVGWs2VrrH++oKMqxXKJnbm/IHS4zEXOSTr1gGnD/HoWKoL/KY6hILmUYbW9fER8bxgsDx5GU6qRjyYAFMKK7nk8ATFQG1UYeazihaK8qfpw8p8w3GRTeKuQe1puclhCeaSQn9jpFFBdYFU8QSY5+7V62l12RGZDVaMMiASqtIZeatEum7tBeRE88efqx2WNqwjRgX3Yawyh54byHuxZSlhvE8m2aSUw3ngfGf8NDrY4Eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PAXPR10MB5709.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:245::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Wed, 26 Jun
 2024 13:20:16 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%7]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 13:20:14 +0000
Message-ID: <ba0d9144-d183-4e1b-a46e-7f6c47140c38@siemens.com>
Date: Wed, 26 Jun 2024 15:20:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 1/2] initramfs-overlay-hook: Add
 INITRAMFS_OVERLAY_MOUNT_OPTION
To: Clara Kowalsky <clara.kowalsky@siemens.com>, jan.kiszka@siemens.com,
 cip-dev@lists.cip-project.org
References: <20240626114715.70823-1-clara.kowalsky@siemens.com>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <20240626114715.70823-1-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0102.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::18) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PAXPR10MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: fb90f754-aea9-4c32-3d23-08dc95e2b6d6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|1800799022;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MjRtU3ZVZ2tCbXIrZ1NDekwzYWd4dXpOTTJhU2N2Sm8xZjRqU0FjRm5VbGMv?=
 =?utf-8?B?aC81L0txQ2E0TEU1b1EwWWZqckd3NHN6WGd2b2xCREJURHFBeG9HWW1lT2E4?=
 =?utf-8?B?MDZzVDEzUGVWVlZJamptTWV0cG9uY2pwYmcwSHdTcUdyYWZ1M0xuRktRelNH?=
 =?utf-8?B?WVl3ZExtU0pIODdWTDhSK0JDRE5MU0dKUm55OC9XZEZYN3BPU0ZEU0RZZ2NE?=
 =?utf-8?B?bE9sdjA0TGliWnRrS1JNNmNRbWdpUUZSNEg1aFAwemt1TVhNb0ZFZ1dXVFB0?=
 =?utf-8?B?VUFNcEVtOUVmNUlJWlJOMm02T0RoVW5CWEwvRS9CaFhycHBaMS9xQndFQUlt?=
 =?utf-8?B?djRFOUF2bGtCdU5IdjFhSEF5MWJ2QW1RTDZMVmlJMmVhb1ZhMGJWSW1OR1lD?=
 =?utf-8?B?a01MK1oxaXVhZ0dvYzFkVitUMS81UmVET1hjSkZ5R2R2V2VzMnNCbmkxOXJk?=
 =?utf-8?B?UzJxbkE1ZUswSkhLdGw3dXY4VFlBNUlIREZkUlR1OEk3S0lOR29PZFNYM0Q5?=
 =?utf-8?B?eUlPTE1ZR0lUUWVvK1VOSnNIeHdXNVdBYzZPemlnUVNxNGZ6WmxFODU2ZjJ5?=
 =?utf-8?B?akk2bkI3UHNUV2hveGYyOU5TeW5QdTJ2QW83UWhTV3ltNGJ0NjNkZ1NINXZE?=
 =?utf-8?B?WFBkQXBaZXFPajJWMC9JZVdMUy83Q29FdmNmTUpqUzFiRjRtZTlib1ptVWsw?=
 =?utf-8?B?dGNubUViaUhtN0xGalJoUGh1OW1xNDEzL1FTMDAvcHBpd2ZYR2s2QVNncjVQ?=
 =?utf-8?B?WGo0dm1wVWkyWUhQOUpZV0FmaU93NDQwaVp5ci9Ed0pXdm9jajVLK01qalg1?=
 =?utf-8?B?RVZxbVlUbG9Tcmp1N2RzaDlxN1VXdXpCY2ZTTmxONmZHbkt1bFM2OFYwdFdX?=
 =?utf-8?B?bDZZLzFPTzljY1dGRWhLUFY5eHdudnAzVkRPWjRxWDZtKzJsU2p2Rld3cFpo?=
 =?utf-8?B?T1NRaFVEajhLUU1jQzdEa2ZydjNiZ0YxRDhkeEtLMzdRdXZHR2U5Z1J0NkZG?=
 =?utf-8?B?UXlrNnZ0MmxvLzlXVkJvWFFsaXQ1a0daVWlKZWlYT1B1WUtEdlFkT0VJWXA2?=
 =?utf-8?B?VUYrY0dLcENETEZWWmhKT2hCUVdwRkxQNWdoODVGcjdLNDZGdVNTN3lJUDRk?=
 =?utf-8?B?Q2hyUHBLdld1ajhNSWVSb3JHMVRBSHNneTNVdWp6R1RuWXlUZlFmOFpicGlx?=
 =?utf-8?B?ZEswOVlWOURIVjRVNis5UzJHMzFtMnRBK2Ntdmk3ODdHZDkweFgrZGQwREZB?=
 =?utf-8?B?SjFObWhOc2pOUzRjN1lRTlZtMmF1eWN4RDJ3a0pxNit0OFQzK1Q1UmFHR2w2?=
 =?utf-8?B?WVQ1KzRCbWtLbFBSaklYcmZ4a1JpT2lINDVpVFVIN2NqV2JIV1U0bFF1R094?=
 =?utf-8?B?dFBNYy9UdlRFb1duYTl1OGVSZVA0ZVlvb2J5UUZXOS9mVHhYUW02aG9pS2lO?=
 =?utf-8?B?OUQrN21uRmkwakZBbUlid090T292YUVMeitYdXgzcjFESUlHZWV6TDFJNjN6?=
 =?utf-8?B?N2QxYjR3dFJhWGhlRktxVW9tdFVUcWJ4YjJoalozZDBlUWJwVC9QTVdlR1lp?=
 =?utf-8?B?Mlo2MER6d0llTU42ajN1NmEvUEFGOURzcDhNZWliYjBKSnY5cFZ0b1QvcXlv?=
 =?utf-8?B?bm94UVhieEpBMVZ2T0xjZkYvYjBLN1R1ZXprNzNrbUpxbEs5bHprazk3dlpV?=
 =?utf-8?B?QzlWU09PY0FnM2U1VDBSRk0rRTFhbFNSa1hZQm1EY0J5Ym15UUczeHB0VXQv?=
 =?utf-8?Q?jRtYlLIIkemH4Q7J51gkGNbIJQoVS/ifVqoGcCe?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NFRqSVJzR0JmdVU1Qk5lWGhtOWlSMndpbHYwOEpQc0FGVjNwMmtqd1ZCZUt6?=
 =?utf-8?B?MUl5cE9PMzZpek9zNTJqSVhBTm11R1laKzRSYnJBMVV5RW5zNkNKdkxnOWM2?=
 =?utf-8?B?YSt1alF0dHpFZEZralY1Y1JhQTNYTEFHVzQrejhwekVuM3NvMnpvTUQvUkI3?=
 =?utf-8?B?QlpoZGlpdGp3Qnp6RzRDWk9Qd1U1dlFLN2lWb252UXVXdHY0emhwTjc1K3VS?=
 =?utf-8?B?TE5ad0ZXeWx4YlVFUmxRSGU2ck9xNWNSTG1NbnZjYlFEc1FBM1ZMTk45cytL?=
 =?utf-8?B?ckV1ODJvSW9URFFVT2VsNlFOSnFRWVdOV0Frdkk2TlZ4VXpMeENSMzFWTDZ4?=
 =?utf-8?B?b1JsZ1Fyb3RJZGRTaUxGb1Zqc2JGZFpuaWR5UDhFa0lrMFo0QU1nTVhDRDlR?=
 =?utf-8?B?cndsZndGeGpndVdNc1V1bGo5Y2d1U2JLVUswQ0c5cjJlQU4vRE5zZk1HR3ky?=
 =?utf-8?B?Ryt5WEQ0V1FQenBzaEFST2RQUmppVE8zQVU4QlpCMUUwOXZYc1FQNUFSSDQ5?=
 =?utf-8?B?LzNrN20wNWdNT3FzN2tLcVBrSkFaVkJwQnR5UVNoemF1c2dveU1SRG9rTEZC?=
 =?utf-8?B?a1BiVmxua1drNWNKQjVnWGRRd1BKNkd3d2JmbW8zVGFEYmlXanZLeWZ6eTdE?=
 =?utf-8?B?NXQyMThxS083L0ZJMzh3L21QTUVvTFRnMzBPRTVCSWZRQUJoMnJiTHBTMTRa?=
 =?utf-8?B?dnFza3V1eU1QbzNBOEs1UXlFZkJJL1RjaEliVElrMVVGWjF0VDNrbHJ2Witx?=
 =?utf-8?B?NXh6eDBYWjVhZ09JV2tscUMrTThrTlN6WVNhZ0dWL040UWxxVFIxUEJZL3ln?=
 =?utf-8?B?KzUwUWFpM2xaSURvRWFtS3k2aDFkWDh3TytlZC9lWEY3eEFJNHNxZVc3VThy?=
 =?utf-8?B?b1RDUDhuQjJJSjE2bnpUZUFqdFhFeTVmWFFjS2FVYmY2MWtjY1hJS0YvMzI0?=
 =?utf-8?B?MGZMRitoY3VrM1VlNTZiNGF1bktUMVc4YSt3NHY4S09YYTdXVGFHNUVteHY3?=
 =?utf-8?B?VE40Z0Y3R3p5eHl6QWdZZm9BRnFmQnJ3U2VNZXFqRkZKSTRQNERTYkJIYnN1?=
 =?utf-8?B?b3N5RHRFVDZSNXVrMFZYbzhXQ2l1V2szKzBIMmhpTGxGOTU3NUtVQmpRdzlF?=
 =?utf-8?B?c2VGL0RzdHovRGhwS2ZOdm9PSlNZTHlEcVNlUTlMc3pDRTRZT2duNVR1cmxl?=
 =?utf-8?B?Z0JzVTNSaVlLNkdjMks4TTdWMnczR2VKWHRxZDVzQlZpbENqeDRxQ1E3QW9T?=
 =?utf-8?B?WGJybnlzaHRrK0o4dXhmYU50UnBYTkF2bTZHa0wzL1BiT2ZBWjVNN3pwK3ZF?=
 =?utf-8?B?cTFiQUg2MjJXSFVNRjV2OFlYRWtFbGhwakVrbmZoL0hyNUppMVdkbkd6d1pQ?=
 =?utf-8?B?cXUwbW1DV210K1k4ZHNrUlhReUczeUR6TC81ejBPZytjRE5DOXJFRjhHS1pE?=
 =?utf-8?B?VkRjNXBwNjVPSUE0Rldtd1lLaFltR0s0d0xHN3YyOWRkS3o2dnNtd3FkRHRM?=
 =?utf-8?B?eG5tM3VDWHF5V3BLQUxkdGI3L2E4Umtpc0g5akNvaGwyK1FNOVplRXo4TWlm?=
 =?utf-8?B?YTVxUmdsMTljYTBGc2k5SVJaVjd5RkswUkdpdHZIYmxWWlJBTTBHVlJPdXR6?=
 =?utf-8?B?eUk1dTJDL1NUT3ROL1dkY05QQU5qVWlyTDd5dlk2c1ZiUC9CV0Zsd0orNFpj?=
 =?utf-8?B?ZHFVNGphQi93T3dPR3JBR1ZGeEhMOUFzanNsblZnd0dMclNvT252ODZHNzZl?=
 =?utf-8?B?eEpOOVNvbFp1L2hVaFlVWkxEK3JIZHFrcjlVNERhVTdRRHRuTzlzTWxGVUw5?=
 =?utf-8?B?N3o0Ni92OGJZRWxoNjlWTVI0UDh4dFU1clRvN3RpR28rV0dDZldBTkd3NUgz?=
 =?utf-8?B?a1l1dTkzbHZ2anYrQzl5b1ltd0xpdmQyamVMV25nKy82R2FDRmUxUDIwRDFv?=
 =?utf-8?B?NGF0MTZWMzJNMDhXRTFrSHZkVWVmeExPYUMwS2dCU1lBQ3JGYUd1NE9Yd2ww?=
 =?utf-8?B?STcyK0w4UUpYcGowK2VpNHhqeDh1V2FjZ2YrRm8rbWd3VzlBNTV0c0NxcjNX?=
 =?utf-8?B?N3BBYXFUNjV6VGQ3ZDZhbVY2UE9PMlpYUlJUNUp6WklQUGNaUG5hRnZaMlJP?=
 =?utf-8?B?R0dCcUhPdGhua1VmbXErVFV1T0o3Y2FEdjVvYVlIV3U4TXJQMTQ1Q25pUmxp?=
 =?utf-8?B?elE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb90f754-aea9-4c32-3d23-08dc95e2b6d6
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 13:20:14.3042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+4HPhdavKQqwuIH1rqOgj4t+9HfzfDrHK3Wue9w2GyBTbojWOc6Zl7kDvrf5d3KzT87ab4LvnllhJlz3+89Dp4Dh8CWnl0cWPXi2yMB1ZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5709
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Jun 2024 13:20:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16327



On 6/26/24 1:47 PM, Clara Kowalsky wrote:
> This allows to override the mount options from fstab.
We don't read the fstab. This allows to set options during
the mount of the overlay storage device(/var as default).

Quirin
> 
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>   .../initramfs-overlay-hook/files/overlay.script.tmpl          | 2 ++
>   .../initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb      | 4 +++-
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> index 2563dfd..42eb59c 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> @@ -30,12 +30,14 @@ esac
>   ovl_partition_device="${INITRAMFS_OVERLAY_STORAGE_DEVICE}"
>   ovl_storage_path="${INITRAMFS_OVERLAY_STORAGE_PATH}"
>   ovl_lower_dirs="${INITRAMFS_OVERLAY_PATHS}"
> +ovl_mount_option="${INITRAMFS_OVERLAY_MOUNT_OPTION}"
>   
>   root_mount_storage=${rootmnt}${ovl_storage_path}
>   storage_mount_point="$(echo "${ovl_storage_path}" | awk -F/ '{print FS$2}' )"
>   
>   if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
>   	if ! mount -t $(get_fstype ${ovl_partition_device}) \
> +		 -o ${ovl_mount_option} \
>   		 ${ovl_partition_device} \
>   		 ${rootmnt}${storage_mount_point}; then
>   		panic "Can't mount ${storage_mount_point} partition - overlay will not work!"
> diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
> index 2694766..955748f 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
> +++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
> @@ -29,11 +29,13 @@ INITRAMFS_OVERLAY_STORAGE_PATH ??= "/var/local"
>   
>   # override this to switch to UUID or PARTUUID based mounts
>   INITRAMFS_OVERLAY_STORAGE_DEVICE ??= "/dev/disk/by-label/var"
> +INITRAMFS_OVERLAY_MOUNT_OPTION ??= "defaults,nodev,nosuid,noexec"
>   
>   TEMPLATE_FILES = "overlay.script.tmpl"
>   TEMPLATE_VARS += " INITRAMFS_OVERLAY_STORAGE_PATH \
>       INITRAMFS_OVERLAY_PATHS \
> -    INITRAMFS_OVERLAY_STORAGE_DEVICE"
> +    INITRAMFS_OVERLAY_STORAGE_DEVICE \
> +    INITRAMFS_OVERLAY_MOUNT_OPTION"
>   
>   DEBIAN_DEPENDS = "initramfs-tools, awk, coreutils, util-linux"
>   

