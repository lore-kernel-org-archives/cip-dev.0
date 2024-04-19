Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3A3C4345F
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 16:29:13 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.45])
 by mx.groups.io with SMTP id smtpd.web10.25886.1713544150940487896
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 09:29:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=zdWjAzM7;
 spf=pass (domain: siemens.com, ip: 40.107.22.45, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsZyiLdgouFKYVjSf2uuZ8x0h39UqLBZy04K1VcMlMlGnQpQIcyU6i7PL/ip+PUbYQ5tW93nFbKHbSnMgaOTrk9L38PIVS2tQli0xXr1z/1WhSbFJu5TwncQcGeOPztzp5e6MO+x2ILA2ZY/DEEiLc2sgLmOrd49ezcoINMZYMpBSKqEGWNRIep2hnj4U6MDecctVLgbYYcnanfmsrf/sCxAP1cmhr2hAVBzvcuK+dipa66/outFOBvoOhuEAjDuNZomEuSS78XnVBZp8EGTG3fSnnomOjlJ1jnOXOgif39bPArQ+fFiq10shG0oBgrjlYfjjxXreGn8k4JhSAJWFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mA2Mz6Y7YCSlO+BzXGinhCvSk+SydU2TgBv5xVyVzGM=;
 b=TT4UeMEZTIL0YxMsIhIaIYQ3zeOUBPnALfVa83IiunIjYESil8mNQpPLF7K/kZ5houXQhNcl5IgkzKDzOQihReJ8iQdNiixkPfIsQ7vqipxvIsVai5dmVWmVmijTDNLx1sASvvizHfFNqvRUzuRsOg0203Aw4o07liHhdBqXnxRgLR6GSybA3IoBJGkUzadMXQJk+wHpGsQMKJQp786lCWENMKwTwWQa+pbsoMv7pkxzNGwn5ER4iq9+s4WLWhoOuERMpcW7MwyaP016oCYplR9fsGuyj4y0ifwftTzDFJxqGZWjU+f0Yx+qiOW3a9f5LCHl3ovy5+m8cLstjp2HbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mA2Mz6Y7YCSlO+BzXGinhCvSk+SydU2TgBv5xVyVzGM=;
 b=zdWjAzM7wCMVktHhcFnF6MOlklXKpKQXgmzgXhUxh9ByRYANDGe2x+8EJTZR0arVjisnekhXAN+z0jOlawKYXlo7xnLGtJaQt0SMYThBKSFx6cYi/5g/bzr+y8+qW3fPXXn6zd0YCy7qWQ3wTPNffK6RIPJzNtYH01gPGezJ+6+TY0mBlS7ACFC/bqeL9wh0ykn27MhUn8Xo3n/wHdw/yZ0QZvyJbDefxlIoJaM2ZYvX4HZuPCMcf/dBPlod5rWvtNKRLTzz6xeUrN9YNiSKKR7xacktSJHerev61eleVLBKem7XBuu9ABG1/nooGoFJADjLBzXm3JblprpfLqUSoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8630.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1eb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 16:29:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 16:29:08 +0000
Message-ID: <c782a132-28ec-470a-833f-8404e833ba5a@siemens.com>
Date: Fri, 19 Apr 2024 09:29:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 5/7] use luks2 to identify
 encrypted partition
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>, johnxw@amazon.com,
 cip-dev@lists.cip-project.org
References: <20240419082036.2389583-1-Quirin.Gylstorff@siemens.com>
 <20240419082036.2389583-6-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240419082036.2389583-6-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0004.namprd16.prod.outlook.com (2603:10b6:907::17)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8630:EE_
X-MS-Office365-Filtering-Correlation-Id: 53689c18-8a14-407f-74ef-08dc608dd646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?S0I3MVhUUy93OXF0d254N2JCbXl6bXVTR1c2QUhRRVppcUZiVU1Rd3V5UUFS?=
 =?utf-8?B?V3c1dFg2YTF0R3NZUUNyYTBFOFZjcWd5dFhESGgwVkNFUlphamlyNGlnQVFN?=
 =?utf-8?B?VFUzbHlLQ1VkQkVSM1ErMFViRk5sZHFraTNXZVoyNHg2SjhIa3VDVS9iblJY?=
 =?utf-8?B?VnZjVU5lZGFLQ3JWcEhWamJvRGpwSjVmRDhuOGpqcUVrazgrVkZ0Zk9razlQ?=
 =?utf-8?B?V2lEWmdqeEllbU51bGRSenRUY2trbEVtTmd2MDdRekU2ZjQ4R3hJMlNrY2xG?=
 =?utf-8?B?endLalIrRTlCYjNVOGwydkdKREM0aVp3Qm1ueElrWlpoTnRGU0VFZDJEY0JV?=
 =?utf-8?B?eUlRUjZYWU5Wc1l2dGFNTlhhaWw3cmFwSzFIczJ2OSs0cWZyQVFJck5VL1cv?=
 =?utf-8?B?WGxRSjBGN3p3aGNtaGt3ZzdRTXJIYWZmbTV2L1A3SXl5R2FTcTArWnhmOTAv?=
 =?utf-8?B?VHY3SnQ0eUxtbmR0Z3J1djVySmlZbnJ4ZVdtS0RYZU5MNThDZXhMclNtYVJj?=
 =?utf-8?B?QjRZU3FKQkpRdktWNHNrRzdRMDdwQ3h2RnQxbXU1bzc5K3BaZ1FWVDJoT2VB?=
 =?utf-8?B?enE4andhem96d0toeENwVVJVUjdZMWpTT0VrR3JBSXlqcWs2ZmUzd0JYeEdG?=
 =?utf-8?B?dWRjeDlEYUU3elpCUE9TNUtEYm5BS3JNTTBKWTNpekt6dk1ZLzk5RUhzdzV1?=
 =?utf-8?B?eHRlemJ0SVFiRDJVaXc4RXUrT0hqNUZ3SjNTOWFyTlRsVDhhQmFrNnZEazR5?=
 =?utf-8?B?MEl2NElZeS8yV01ycTJjeWVZenNlUzc4eTVIMUFoVGRqSTYzQjdnbktjMFRB?=
 =?utf-8?B?cXFOOWVpbXE5UmZPS1QydGlyUWJ2amlienRCa2d6bE1GQWlFSWZlOE52aUhN?=
 =?utf-8?B?ZnNFUDUwbVVJYnhyd2dlNU8xb0ZjclkrVlJMRUZwYUlRU3dIcHpQL1FUenk4?=
 =?utf-8?B?eGJ1R1dubjlCRzRaR0VDV1E3K3J5UGhBemVFbFJmNXkyOXJWMVBmSmZVYWUy?=
 =?utf-8?B?R2VXZFpLdU43aDZRNFhCMnFoRU1Uc2RXSngwWEw4blYrSk0zQ0xHbC9GVWo3?=
 =?utf-8?B?aWdNUml6dVNkb3haUXoxai9nbW1SY3RmRmRXM2ZMR3BhelExK3FkK29zMFE0?=
 =?utf-8?B?K1NUclFmUUhvcWR2cEt6bVNwWUw4Qnc1NkcycEwrQU12V21Tc2pmald0ZkZ0?=
 =?utf-8?B?UjVKNTR2TU5LRzBkZ3d6QWo2VnRNUm51SmdpallIR1p5dGlURUtRc1Y4T1Jt?=
 =?utf-8?B?Vi9mMk11ZUZjSkw0eHF4ZWpXU25VRmtVNkdUSzA1SzhCV2dCSjFSZzF4UFZI?=
 =?utf-8?B?ek9lY2xJcXVPRlBnWGRaelVmVWw2d09KM0VuMUVQYVY5VTRtNEVkcWwyTGI1?=
 =?utf-8?B?OHZDVlJnajZ4OU5kS2tSVHk2M1RPRWF5ejJLRDB2YlpWVlQ0UHRRWFhRRmRI?=
 =?utf-8?B?TnlhTWYwUy9rZCtTbG9kMW1IRTZrQ0Zjb1FJRTFkN0w1Rm5oY3V1eGxUQWlN?=
 =?utf-8?B?OHovYVlQY0tyUEZDYXFVbmViNSsyNS9Senp2M2JWRDdIMUNoU1gzcDFkbUZ2?=
 =?utf-8?B?VmdTQjNxTmk4V0lmOEE0S1QrTEQ2T05oNnBPZEx1V3FoMUJhTHBBSlQxUkxy?=
 =?utf-8?B?ZkNvMUU3YmE2V0YzQk9PQS9XTHdQekVTTkt5ckkzdGhyTEhZUXFhMEdSS1hu?=
 =?utf-8?B?ZmFXeGd6cGJsU1VFakhxM28ydUtteWlRVUVJSTdxY0lmc2Zpc1YwWG9nPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bGtOY0JzdXRoVzJVMTM5cCtvYXNwSUpIRTBrK0hvbmVjRkYzdzU5Rm5sVGVJ?=
 =?utf-8?B?TVVna25HbHBTZ3cvZFNaSS9TWE1tdk5waDdBaDQ3UjArK2gyUFNZcVJKbXF5?=
 =?utf-8?B?a0thVHMwKzd0Y0RzbC9qNWs4TFBjZEcxdVB2dm96MVRSRHNUVW5hQ1lJS1I1?=
 =?utf-8?B?bEFCOXkvMG1YaThnQmh0NVZnWFoyM3pzUU5EeGozc2FNaU1WQjNHMjd0eUtv?=
 =?utf-8?B?TksyRTdSekdQV2pyNGtsb0dzbWVtUFdIVUdUUTkyL1RvY0pjVFY4ZytFU1gz?=
 =?utf-8?B?SDBESGVTb2M5aHFqS0FhLzVmZ1RXOVZRMStzUHl3a2FmUDg4TzR3SkpjcXdQ?=
 =?utf-8?B?M1ZKTDZwcUZSVXR1S0kva1d3b3BtSU0wVjdmeWlmWTNHUWxiV01EQnpTL2Iw?=
 =?utf-8?B?dWEzNGsreG1XYStMd0RybFk1cnRNZU1uamZXbW0vNUY4aFNoK1RZUlZ2YmxD?=
 =?utf-8?B?UHNQamRRYTZ4UEsvN0c3SzVHa2NQYXZZanNST0xWdmptOGp2eXVTQmJPYWg0?=
 =?utf-8?B?Z3cxTytDY3QrdUJuNTB1MFJLeUhBYjV5YU1yNGcwcERSbk4wV0V3UTR4SUtn?=
 =?utf-8?B?UGVWZG5Kdy8rN2xMc0FQblNKQVlCQ1I1UjlNSjN3bStudTFFaTZwNFc0NmQ0?=
 =?utf-8?B?NmU2WURiVDFsNzN5QnZjN3lYc29XbTExVEloMFd1K0lvd242azNkc1ozYlkx?=
 =?utf-8?B?WGNCdzZuQUN6S2MvTGxVa093a3ZidE5lZ2wreHlYLzAreis4c3RXZEUyeVJV?=
 =?utf-8?B?aW9MVjhVQXZudk9HYUc4SnU5d0lyL3FvM04xeFhEM0oybTI3QTI4dVVoR0JC?=
 =?utf-8?B?TGZUTHlVTzlXeVFKOEtjMkNLZHhaalA2QkZ1WU9kdkFVck40YzlpVW5oOTlh?=
 =?utf-8?B?bnJTTjhFTnFmbVd6bjFzY1Y0WXBJTGtibFc0SzFlNjB2dHl1RHl1eGZlV0FF?=
 =?utf-8?B?Qnp6MnNoWlBHcko5bEFKMkRLYlU3d2xZb0JiNnpSazV6M0duVEIrTTBSOEJ0?=
 =?utf-8?B?V09DT3lpT1lSL1lER1ZBei9SZThNTzlOenVCVmdkcnNBMTBMYUhkalRpQlp0?=
 =?utf-8?B?RU1ENmVtNnpkMklNaU13d1h2T0ZtZU9BSTd6cFlqMHNEVkVrUS81TTByRExZ?=
 =?utf-8?B?VUViV3Y4VVpWcks1RENIVzJFVWRWaFJ5TWlFdTJWREEzSnJvUmxjeFVvRy9K?=
 =?utf-8?B?bnB3YXB2NzFneGZRUC9ESzVtRmtLSjIxZDRNK29iN1JCYXJhZ3NqNE9qRUZo?=
 =?utf-8?B?U3pZK29ESzEyempmbE5WaHpSN29BSDRiRG9hdWYvVE8ycnNiUG1Wa2haQ3I1?=
 =?utf-8?B?L09NOS9RRVFDallocXN1MWNVY3BUMDdYK09GK1YxVHBCTXNxZmR2RW0wUTBL?=
 =?utf-8?B?NFRIa3ozYUU5eHh2c2wyOFpuempPbGkzNFQvSnFWaFMzTkRlTjd0RGVYSzlC?=
 =?utf-8?B?NkxjM2YzMEt5d3lLTEZNRUxKd05EaFpNTkIyTmJNQ05mME5uT0dRbGhObFlq?=
 =?utf-8?B?NnpoVFF2Wm1tZmxJajRXWkM4RXF1QytjajYyOWV2M09FdHdLV1RwQ3dVM1RF?=
 =?utf-8?B?QUhuV21WNjNQNDNqclppRjZMdmd4TEJkZVVtSTc1MFlWQUdJcm8zSmhFMnl3?=
 =?utf-8?B?NDB4NkF6NTdjcVo4eWgwL043eWZkbDFGQnQrQU1ERUVqYVFkQnJKMEIyR000?=
 =?utf-8?B?MmMxR3pFdHVlY3dJZUtHaVNPcG1zZjl0S1RkU0RTbmNuM3ovNEVIZXVKMVJp?=
 =?utf-8?B?cVZjY2JoaTl1a3kvRUw1L2JyNjkzdjNPaEZBUlNZSVBtUk1Ca1hXTzNrSlJ5?=
 =?utf-8?B?WFNIajJSeEJOSWtrb2d6eHZ4OXdwc2JYOW9MMmVtbENmVThtY1ZZSlVTaWFC?=
 =?utf-8?B?VGFGQ1QyemVNa0FLamlraE04M1dnbGxNNjF6NnM2Tm9zMklLV3hScEM2WFk2?=
 =?utf-8?B?ZmpPaUg2VkpobmcwZWgrWVlobk9ONE00V0tid08yM0FaMHpkdTAwUHFNU1BG?=
 =?utf-8?B?RWxDektYZzBKRVdVU3FsREw0WGJnaVd2TWZhQnJpbzd1b1VISkJxRW9iMW1Y?=
 =?utf-8?B?ZUs1QUJFbWR5THBYbWZYUEJIM0Zvc3dLWGZPTUE1NmJyOHRORytBc1NTK0Mr?=
 =?utf-8?Q?QIqXj9b0Bbgnp7wovOOdAZoE5?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53689c18-8a14-407f-74ef-08dc608dd646
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 16:29:08.3631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g+pha0h6FtKBIseFgg0HpsgTdn606I8wmnSy3rKherL1qLoYQR1QLdNt7Ein7GltMQq0mZo3Lu4RrUbQz12/yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8630
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 16:29:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15702

On 19.04.24 10:20, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This fixes an issue with encrypted rootfs during system reboot.
> 

And what was that issue?

Jan

> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../initramfs-crypt-hook/files/encrypt_partition.script         | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
> index 51c81f3..685d882 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
> @@ -134,7 +134,7 @@ for partition_set in $partition_sets; do
>  	fi
>  
>  	if /usr/sbin/cryptsetup luksDump --batch-mode "$partition" \
> -			| grep -q "token"; then
> +			| grep -q "luks2"; then
>  		open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
>  		continue
>  	fi

-- 
Siemens AG, Technology
Linux Expert Center


