Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.30])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14976.1795703436162261555
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 06:30:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kkGjUwZ8;
 spf=pass (domain: siemens.com, ip: 40.107.130.30, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LUTrKAZw3zKkHfRrMax2MkMHlPvxJ2uzZhRC2aas9NOquuV8yOx44nDkXrJfCiITqnHrDe5YpyNYIAIOQNc5lpfh7oD+TNl0WIGQacy94bGCUjPysW9cjv9MgS7y3rNnS5rme5XzXM0LNQqXQEjd3Iitlf4TvYG1nYD4cLCtf0Nb2btWn8uUCd/mkiH3/xpClE5Xbwr9ByHARmjzIA5NRcwwTntAp1Go5ELIlXNE19SLbGOteP+s5uoRLaaMEC4dHBmKaf+O/qGh1Jx8+ESPti320daHW0vwJedlgmIgsJGxo3JvgAw5TI6smu5uw2oPfTrv4p3jm03a1L2aIYq3Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/I+vBXuJjQ+ssECypyJ0AGhoIT10Ru44cis7pdQX+I=;
 b=ZoD4nsmHRwJbXP1kppmmMPzoT7Smz+2jG5tiRnZ0QsuxVjkNW9C11gdo8jLL2mUHYeo7B7gbF4Q+/+W3LBFHVNKuQBRoUacjgCfk9a34KGW4SkYmG95U0rcGf5HP1Z+vy737RVhoUFQrPBJ3iFS8JwIg45btXDnzDCgy43V/w/M1pmfGfsu+hI0TNzdIPXxvQZ9V6KJqaDUBeC7V33aPj5ERSnjVkafYaqgfvodf80ECBFoP4/ncGQmEkZfD8f2CaQYJlTNsS43UqhXvMzRIVhdH1AeKo1oYEpLPbyPRzpAhLlpx7Vdf5RwE04Av+ivoF4piXqAnF2IMH5zZGO/O9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/I+vBXuJjQ+ssECypyJ0AGhoIT10Ru44cis7pdQX+I=;
 b=kkGjUwZ8ZKR7ny/iuseH3YFyI00Trg5yegpEDo2UI191QAZoI1AnMLoWwXMQRHX08Iech8YYd/VxKwkr8NVSFVXupl8lRIstdXrQAxfdSWxUJnTWS7iru/yVzvhwlcbGXzdhHLE055IXh1Pbqzohr7Uqseoe4ypAIPXAd7L8PmDgNPIj7AZVGGEK74SQJ/HGYlcNli3ke7ATVXDoow/sep+GwIXh8jJE+UBQOhYu6VOdAD2lJSNkaj/vkgJa1yUIQJx5rjTMhxptabzQ8NclD0C95sgn9s8dcIfwFnzShfiXOPrZLoZSkXY/riQERWsPUFgdCqHzodq/5Tfu97JMcA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DU0PR10MB6300.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ef::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Thu, 26 Nov
 2026 14:30:31 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0688.001; Thu, 26 Nov 2026
 14:30:31 +0000
Message-ID: <dcda85b7-177c-4aa4-a158-dcf124915ae1@siemens.com>
Date: Thu, 26 Nov 2026 15:30:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][RFC][PATCH] swupdate: deploy
 SWU_ROOTFS_TYPE artifact alongside swu
To: cip-dev@lists.cip-project.org
References: <18EB9B2411C8B34B.1905714@lists.cip-project.org>
 <JH0PR06MB66569C8B9C7894C0642310F991422@JH0PR06MB6656.apcprd06.prod.outlook.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <JH0PR06MB66569C8B9C7894C0642310F991422@JH0PR06MB6656.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::14) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|DU0PR10MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: aa97f1b6-cbe3-4550-5078-08df4bc9d32c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|4022899009|366016|1800799024|376014|261102123227099003|261026140227099003|261026135527099003|261022113327099003|261022115727099003|261026130827099003|261022075727099003|4143699003|261022105027099003|261028144727099003|261026121527099003|11063799006|56012099006|10067099003|18002099003|261021121427099003|261021135927099003|261021130227099003|261021133027099003|55112099003|261021123027099003|261009223027099003|22082099003;
X-Microsoft-Antispam-Message-Info: O80OZVWwaA/EjEynpE+IqZ/1JX/Dq69P2Y78ZAIySeE2xZzp/TYeSUKBmAlJXK8rXtbZW83+ZZJvE9s3kLOijfQcy/dWUaMd+F4mcTM17IZ5vH19UOXKHsZSO2P0BrN32N14V5nDFwcoluZOvCfq80ttJf54exw16cC16qx9Z5MoUqKwdIyrVmSvVviBMg5YHeq/BFQFNntzVJWRg5nmumhKxGIMrcJwwr+IG/pOsT0gRAKrVvcPpKxq0fwpjfzG24L27fllzk9pOKHpVPWmzRjxEeLKRZltluoRnGhL02blwwRyvXu/gc4kKlVXsCm+UpuWpcuUAKSt5QNEJ/wxi71x4erCYvahPfDDTcKkMgN88tSHJVQfIIRxeHPcasN6+bS/ehFxtAAOpds0bLDOCwKRJBxlpO3FP67O8w9peRLkjaJzmr8Rpd/TvSVywT5FIXwk6D28uBUxEHbbZbfW18+fi/ap5Prs2OCFqx2cJ2mz7HDejEPRkSrCPGEOUlVzXSgk3gtRHh3rbtwT1S+7RaRTqOzfHcr5nkNpPlZ7Xu3HeJ1M116WsWkO1MgEuXMBSo1B+2zNYV65xE8ga4kZYlE6krCWpYPAQ1u2ctuYWWs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(4022899009)(366016)(1800799024)(376014)(261102123227099003)(261026140227099003)(261026135527099003)(261022113327099003)(261022115727099003)(261026130827099003)(261022075727099003)(4143699003)(261022105027099003)(261028144727099003)(261026121527099003)(11063799006)(56012099006)(10067099003)(18002099003)(261021121427099003)(261021135927099003)(261021130227099003)(261021133027099003)(55112099003)(261021123027099003)(261009223027099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0drR29GYnR1MkhUTkFSemlIODdWQ2JwZGpYRWh6Rm1wTnhkZVA2ZFFzSCt2?=
 =?utf-8?B?Mkt3TjJPTUlwaVNnWklmRjc1RGZCSkRCa3Vjc3NndGxQTjFUd0MzNWhweDdV?=
 =?utf-8?B?bDhOeklqYlJCckpzSUZQT29ySkJhUVVYOUNxZFZPeWszSHUvRVJDTFZFTU5L?=
 =?utf-8?B?bG05YTJGVWoyZEZUUnMwazY3akZnRHlVenBJUTFwLzB2bTFBcmZmVWZnaWtw?=
 =?utf-8?B?ekYwNnNLMUgwbXdndWpMckZ1dURqeS83Yzc5eUdicWlYMm8yeStHU3cxUXBD?=
 =?utf-8?B?RVhydFovUTZCZUJ6aDcrY1VsRGR2RFg1TyttaG5iVzc3UDVNckdmTllRVHZy?=
 =?utf-8?B?bzA1ci84c2J3YnhWUkFKbzAwK0IzTFhCY1EzK09YbU9ubXUzeW1JMW5rV0p1?=
 =?utf-8?B?SFM3T3ZEd1Y1Lzl2SXVVakxqUHN0dVdXUitSb0oreFlXS0NaZCtYdjdqam13?=
 =?utf-8?B?dEVmdG8yUzhDWWY2WElKTzVrb0ZhV0g4NGp3RkVUZzVUSWZ6Z3Y2WEtCYjFE?=
 =?utf-8?B?MHFQaVY4em14eitEMUlOVFhYalZPalgwR293OHNJWURkTGdrbnNWdGFKK0pq?=
 =?utf-8?B?dmpZZXhNelNmMU16Z21jRnE0enJjS1BLcnp4ZWtTZDNEcTZBaUpldDJsK1Fq?=
 =?utf-8?B?ZHlCUEF3Ukw4OGRudlk1L3BvaG5HWWUvSTdJRWVrb20wRDAyOW9LeVZLS0FP?=
 =?utf-8?B?d1lUWm1VUE8vUCtVNFJNZmJ1U3NCdW85TUY1bmk0RFE0Z0dMeDVITDJ0Vjk1?=
 =?utf-8?B?ZDdscWV0Ny9OV3BXZmloSGpvSHk0Rk16UmhZcHVDaWhpenFYazBlcXdGazJl?=
 =?utf-8?B?WXdKVnBDclhSZEYzdUZ1dWpPS3pONGMvc05hZDlFRFUwMVlNMC8reHFhdm0v?=
 =?utf-8?B?d1BEdk1tTGFEbGtxckpxRytrbTc3QVRWVnBIdHdlRUkwZHdsMWhEWTZKTmlU?=
 =?utf-8?B?a1hPMWNxUVJHRGUyWThyUmEzRXhGWlEydzFQYkk5OWZFVWY1akRFK1pZaDRI?=
 =?utf-8?B?TGRvYlpmWWJ6NUFicU9pSVE1dEVpQUtnZnpRUkkxc2QwelZ4cHB1WVpZMVFl?=
 =?utf-8?B?bDBDbkhiNkZZelE4ZmhpcEFBOUd2bVNteTFnejNqV2FJUXpUYk1ibHFiQVdr?=
 =?utf-8?B?Z1RYVVFYMzZFbE95VFFXVWlDZXNmZmpPb2s0c2FJNjhhZjVjU2k2eFB6MTRG?=
 =?utf-8?B?MVdwSUdnRm02NTNIdE95c1cyTEdLV1dPRERDUWpGVTNPbGNOQmRLdUlrd1RE?=
 =?utf-8?B?eEhNWGtLb08ydXVoWTZnZzU3RTMyQ0Izb0psa1pNMU1kZ2FZR3JKSElabm51?=
 =?utf-8?B?MUJ4SFpiYVk5STkrUEtzRElsOS9tWXhFdDZ3Ny9mSThEbDNHeFV6QVZCRzJk?=
 =?utf-8?B?WUR2ZEIzQ2w0bE5rcmhHRlA1YXBGc2JJZTIzc2dDNnZtYk12S2h1WDRDR2tV?=
 =?utf-8?B?Wjd4RUdPWDVQU0phUzNoVlA0S3hwZXZMUFNlZUtweUUyenB3bFdZeUhaT1JX?=
 =?utf-8?B?eHV6UTdJVVhIZERnWEJrdVlUMjU2dlhCWVl0TWE1N250R2N1S1hIdkRLM3Ez?=
 =?utf-8?B?STcyWkp0SXRFbmRrYmc2d2xsWEZqa0EzVUpWWlhBekNCTkdhYVEydmhOMXNM?=
 =?utf-8?B?bXBXNHhwWGpJdVNoMnhtK1JwZnJaZVV2OWlQUkFNZWJsUHVrc0cwbWxJMThn?=
 =?utf-8?B?dHpvYXRTYWMvNFRsOWZMSkF1MExLZjlpQ2xLc1JDWU0zQ0pLTHJ5VEhZZGtJ?=
 =?utf-8?B?MFNUUThmaGszZHJIbUxvTWduMkxCaXoxVHFHTU1OM1A5ZmthUUtmSGsrTVJF?=
 =?utf-8?B?SmtNU0NDM3NyQVo1UUtOeFVlWGxCdC8wd0g5Umc4KzVZbHVFNXNzVVZzaHVE?=
 =?utf-8?B?N1pQLzYza0VRNk9RdFZFNnVjZCtsbzdrKzNBTFlieHY5YUZDNFlRLzJjbk9C?=
 =?utf-8?B?b0tmYWk3Z2V1ZDE5UXJEaS9zWWdlTlFReWtUWmcxK1FiRmtRYWV6ZFVyM1Jr?=
 =?utf-8?B?NlJPaUNsUDFnODFJOWtUUTdIUC9yOGZSb1MvUXUxSGE1cUxTa2IvL2pnZHBZ?=
 =?utf-8?B?VzY5WnloVHJBbllrYVhKdjlyb2V2U0N0YkVJbUliczRCU0Q2cjBsRWs2YlFv?=
 =?utf-8?B?L2twck13T2NISzg0ZWd3dGhwTUxtWjNFUTAzSFdCQ1B3UEJuazFMaXF5MEh3?=
 =?utf-8?B?V09lcTJmSFZjTXlYbloraUlET2l4TmswU3RFb2FWMEFaY2RQWFhBSXBkcWFF?=
 =?utf-8?B?aEZFckExM2wrR2tlU050dUg3OWRnTUU3SGFDUCs3MUszU0NXa3FjNzVINk9I?=
 =?utf-8?B?OVNBbUkzVktGYUNjWjd1THpkR3hjVndaQkF6dk9kbFc4YWZlNGxzSzkzWjJr?=
 =?utf-8?Q?gS091XDEmMH9jINk=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa97f1b6-cbe3-4550-5078-08df4bc9d32c
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 14:30:31.4539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMW4RzfwA1UE4928wZCowaBZj5GJzFIb0Kz4OAUw3xm843Vh2CasP0MAoUY6QzFGnTMxyKpo6jdXDxwfROClWEfi0HnPkuMU8Bp3K0lXZLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6300
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 14:30:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25108



On 11/26/26 2:35 PM, Badrikesh Prusty via cip-dev wrote:
> Hi Jan,
> 
> In meta-lx1, we updated to a newer Isar revision and noticed that .squashfs / .verity artifacts are no longer
> retained in tmp/deploy/images/<machine>/. This is due to upstream Isar commit 63935232 ("image: remove
> unrequested intermediate image types"), which cleans up intermediate image types not explicitly listed in
> IMAGE_FSTYPES.
> 
> Because recipes-core/images/swupdate.inc currently only appends swu to IMAGE_FSTYPES, the payload
> image is treated as intermediate and cleaned up. This breaks delta update builds, which expect
> ${IMAGE_FULLNAME}.${SWU_ROOTFS_TYPE} to copy from DEPLOY_DIR_IMAGE to ${TOPDIR}/previous-image.
> 
> Since isar-cip-core is currently on an older Isar commit, this isn't visible on next yet, but it will be needed once Isar
> is bumped. For testing I used:
> 
> ```
> diff --git a/kas-cip.yml b/kas-cip.yml
> index 13251a7..6b03ff1 100644
> --- a/kas-cip.yml
> +++ b/kas-cip.yml
> @@ -22,7 +22,7 @@ repos:
> 
>     isar:
>       url: https://github.com/ilbers/isar.git
> -    commit: bbb81cd0eec51f224123efedcd7cd7c9f610a7e7
> +    commit: aabb66eb0170bcd623ee4987472afebbcadf8f50
>       layers:
>         meta:
> ```
> 
> 
> Please take a look at the RFC patch and let me know your thoughts.
> 
> 
This  was reverted with 
https://github.com/ilbers/isar/commit/26cd11a135ae9a64d99484973283c53bac203fac

Quirin

> Many Thanks,
> Badrikesh
> 
> -----Original Message-----
> From: Badrikesh Prusty via cip-dev <badrikesh.prusty=siemens.com@lists.cip-project.org>
> Sent: 26 November 2026 18:54
> To: cip-dev@lists.cip-project.org
> Cc: Kiszka, Jan (FT RPD CPC) <jan.kiszka@siemens.com>; Prusty, Badrikesh (FT FDS CES LX PBU 2) <badrikesh.prusty@siemens.com>
> Subject: [cip-dev] [isar-cip-core][RFC][PATCH] swupdate: deploy SWU_ROOTFS_TYPE artifact alongside swu
> 
> [You don't often get email from badrikesh.prusty=siemens.com@lists.cip-project.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> In upstream Isar commit 63935232 ("image: remove unrequested intermediate image types"), Isar began cleaning up intermediate image types that are not explicitly listed in IMAGE_FSTYPES.
> 
> Previously, swupdate.inc added ${RO_ROOTFS_TYPE} to IMAGE_TYPEDEP:wic, but only added "swu" to IMAGE_FSTYPES. With the upstream change, the underlying rootfs artifact (such as .squashfs, .verity, or .erofs) was treated as an unrequested intermediate dependency and removed from DEPLOY_DIR_IMAGE once wic and swupdate completed.
> 
> However, delta update generation (in delta-update.bbclass) explicitly expects ${IMAGE_FULLNAME}.${SWU_ROOTFS_TYPE} to be present in the deploy directory to create binary deltas against previous release artifacts.
> Explicitly append ${SWU_ROOTFS_TYPE} to IMAGE_FSTYPES in swupdate.inc so the payload filesystem artifact is deployed and retained.
> 
> Reference: https://github.com/ilbers/isar/commit/63935232
> Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
> ---
>   recipes-core/images/swupdate.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
> index 699c961..bbedbdd 100644
> --- a/recipes-core/images/swupdate.inc
> +++ b/recipes-core/images/swupdate.inc
> @@ -22,7 +22,7 @@ python __anonymous() {  include recipes-core/images/swupdate-${SWUPDATE_BOOTLOADER}.inc
> 
>   IMAGE_TYPEDEP:wic += "${RO_ROOTFS_TYPE}"
> -IMAGE_FSTYPES:append = " swu"
> +IMAGE_FSTYPES:append = " swu ${SWU_ROOTFS_TYPE}"
>   # input is already compressed
>   SWU_COMPRESSION_TYPE = ""
> 
> --
> 2.43.0
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#25106): https://lists.cip-project.org/g/cip-dev/message/25106
> Mute This Topic: https://lists.cip-project.org/mt/122460891/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

