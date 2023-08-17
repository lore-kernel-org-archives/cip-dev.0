Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEC1C2FC3C
	for <webhook@archiver.kernel.org>; Thu, 17 Aug 2023 14:21:49 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.55])
 by mx.groups.io with SMTP id smtpd.web11.188689.1692282099276075954
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Aug 2023 07:21:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pK9ijk6S;
 spf=pass (domain: siemens.com, ip: 40.107.104.55, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jn3JTX0Pn+BBJjxjCjl2MC2bRuz64ARPpOO42VjZigxPLRy5JdyUpxl2y0qTFwPjwV5VGR8VggKENWMxYRFW+1lO1umfdv0mIDxbNdM9k0BqUNvvz11yUpSzKnd6R3BXFwiNTaFwJc4Yk4w4jE2y6C+ttg/7qT3VD/3YEf3c4kfEI3CHi8TolVdva705xw1GqgiGuFaROVz8l1DMrRSUzyXown8A77aaV1jySSkv57q5/VLUwA7X1XoLvRg/hnDy4H1m0MiFutXDFOSgF62i4G6PQ935Xb9xQDizVRqAPK9PxZy7JwAxHWs6y2QRlyFudjE14/fwwNBOoosu5N8lAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQW6ITLutOnbaMjoYePCEo7QIZjnrVm2dYnxSw5DpUE=;
 b=bEbzdTcftx+NM1o2Cu730IKG2/skkPH0Y7g9j3n3j2rcjvyq/rAWoWUO5FeDXHCfjP3ANDVNMMWX/s5TBvhvCKx0D4SWLdPr1Z8257NojcexFH2HfAs07rSaX0rDEUBD3Y3Gd0HFD6gdfRxOTp8f4C8MCwsVGvodCVsLsj7fYnd3lxbDR/u5bTtJFiPBCVGG+aP5U0k5IF/xSgOTp4/F8q0OwIdJRfqig0TV6eSwG82qchjF01aqIWSuBT5ms0brPXdy9AnNqz6Bsz1x5FBrPtcQ220hkCACHuTiiuGtGc4yDRfLavE55u6gUG7I+cofsLQwcM0TwM4GYlEynmzMIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQW6ITLutOnbaMjoYePCEo7QIZjnrVm2dYnxSw5DpUE=;
 b=pK9ijk6SJpuBUtpGiIMsOk/O0dayQ6XC6uAt/jx9CNpDyoUwKKNhCzdOd9shoGTyuGfx8X55gQTWqJ4X9oB5SXSef8I/z1jMiu8yD/EgWzNdK5Wq6kRPSGoz05Wx1lQR5bZOovurWYg5a64OKP1FbIL24PdF7Mc0WWtUXcssCmdfQl/HqFmxhLUzrZe617H88Mq3W+CBaJKAZEqkfeoMcakZ+GtasQZPcXt7Hi5RF0toUJkr2HB/iCaBXHdUMh6tXLovge9F4qP5UtPLXhF0vnNBeDDCBb/N8Gr5lNZPBqeyVyuRv1sTW3F4l5N4kF+LbRAnNJPHK7eq27n8FGqgOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB6879.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:33c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 14:21:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 14:21:35 +0000
Message-ID: <c3591d1b-3d4e-4689-b0da-d5da5d8606c9@siemens.com>
Date: Thu, 17 Aug 2023 16:21:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core] scripts/*/efibootguard-*.py: Make FAT file system
 image create reproducibly
Content-Language: en-US
To: venkata.pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230817141246.2503-1-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230817141246.2503-1-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB6879:EE_
X-MS-Office365-Filtering-Correlation-Id: 431a5a01-70ca-4d1c-f353-08db9f2d4361
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	JwQAxq2zpl1B8D6KgyPL06Eth4ho9ZOjnvHZEl4KFHPNYqHgBWtsNJsgIex4oxaqBhLKfTy6758M2/WLur1r45MZXFpXZoLfBTcX6/ZSo/DCynGruu6gTv9mQGjhyCDQGCwMGN4JHwLTspI03GMX6Qoxc+a0Bw1t5p1t/XIwTnR1K33wSCDG9Vl/exNQ300oYp9AKVk6Duc33hsfTkpDeUCe5VuvkZvLEy6/KI8rJkXDW1QbgodACe1sns+o3ZOt9Gn5LwXmczBHee7JFipI8e3xh51MRdYD6kXqeMjQGXun50DcswY5R/tobwa6ygabOD1cuEV8TAPxNZltY0usVfO6l8MHxJ9qMFV9SZQzuNDJ3/CS2gwAYoF/f8kK5PVnnefX6etkHEctt/QH1KXiu4mpjKF0e0sK8pA3LbKh4EsKB9vtU39uM37OHMzK7mkiwfq0q0kg1U1h9pvt2/BIUYNuCeWc4jL8Lhhcj6+6Q9Xnfanna9QpbVKuz82RaTgnzvoAP7rkQgDlnnJqms4E/qACihRs/bGJQ9ynjFQOVQZSX6crtrsFUQxTCxY7zJu+sR+BavLUh3iTxzYBU/CDXghxbuv/r9DSSgrQGPJjJHCbNWu7b1rmSLxOAWMVKOa2P1Txm9ScZaIrhyU6paRQgA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(31696002)(2906002)(83380400001)(26005)(86362001)(478600001)(6506007)(36756003)(2616005)(6486002)(6512007)(53546011)(44832011)(5660300002)(41300700001)(316002)(66946007)(66476007)(66556008)(31686004)(4326008)(8676002)(8936002)(82960400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Vmcza1p3RzRjWGxzeXA4YVMwTzNpL0F5alk0dkNXVFdkcmhFWGRQbUdXLzF5?=
 =?utf-8?B?a24yL3BPdjY2YzNScW5sQ3AvdFNaWVFyNVlyQ1lpVFR6Z0RMTVErcFpiZllC?=
 =?utf-8?B?WVlVQU8zQ3F0alFTNjlRcWhNeGJFTEx1ejJpbTlyc2JYK1o2Y1dpb3VBOG9x?=
 =?utf-8?B?T0lhOXZZd0RhL3Bmbnh0ZDhPc2tsM2Rxd1BZd2c4TURMbXF6TWFXays3VnpL?=
 =?utf-8?B?c2pXWHhKSmo4S3RRYjVDNEIrbVFUaTVrU1dsYzdMRU1HMDRLUjVhcHI3NGNh?=
 =?utf-8?B?UkJFcjgzQnhmVVFFdjIyQkhnZ0RYZGVEY29wUEJ4ZWIvQXJ0WEQzend1UFVL?=
 =?utf-8?B?NVJWRmMrYUU4a09FNTJSMG1kNk1IbUsyKy9LUVJqTU1RbHh1dEVQVUoreWQz?=
 =?utf-8?B?L2hsRjVtbkEyZGFML1I0WmtVYk40UVFLWjZhNUVBL0VKTzlJaDNDWWY5ZzBt?=
 =?utf-8?B?dS84MGp1aHptOXVialAzdXc3Sml5ZkNGQlE0LzY4d1RQNHQvL3ZVNStBMHZj?=
 =?utf-8?B?eHRLTUIya29oN1JxZVN0MEhmaGNuZ041Q00vL1NtVGxxbEhrLy8vWFk3RFln?=
 =?utf-8?B?MHFYQ1ZoeitLajJITFJtcTdLcUpqQ0grSi83a2FKUnVTOUJQZFc1SGxxQ3VI?=
 =?utf-8?B?NVpMd09PSTdKdmMvaVY3SG56WVJuVTRNOE5GREdrYWNEUHp3WVpwWGtjbHNB?=
 =?utf-8?B?KzdVVVVWZTBKeGJJRG9ONDlXN0E0Rnd0UXZ6ODAxNHFHQjUrbnhiNkI1VEJS?=
 =?utf-8?B?Yzl5TnFxY09ZMmRYYTZrTVZsMkdrZjdGZy82NWE1M29sOGxFVlRjQTI2SlZi?=
 =?utf-8?B?WjY5UVZJcFdpRXI2ZmJUVnNMN0VIZGtYbm9KclZrdXBWdVltNUk3cnVNcEFk?=
 =?utf-8?B?MDNlQmd3V2pEekh4QjRqZ25IMHJhcEw5OU5EVTlrK0tUZWo5TFBTNEplSWlD?=
 =?utf-8?B?Vnl4VzlQM3NKb3RYRmlTOFpRUFhGVU1GcWtCcVNkcHhjVEVBVm9lOEVob3Y0?=
 =?utf-8?B?bDVYNkdZYUJ1L2pvaVh6OHMvMnBheVRwZmI5bU9sV1BiRXhXVzhTUXJoRGto?=
 =?utf-8?B?S3AyZGxuNlU0Ri9oYUFyd2JreXVuMTVid2E5bnFraTlGU1RzcGtEakt3ZnBM?=
 =?utf-8?B?bGpBcW5IZ3BaVStNajA5WWJ3bVFsd2xzc2k1b1V0TXZ5a3o3UURJK29VYVRD?=
 =?utf-8?B?RklteG1rbUpXRHZSeElKQkVsK0hXWnBNS1A5cW0yZjNKOUNLTnRqZ3pKM1dJ?=
 =?utf-8?B?THFEVnNsRHRvaWpVWjNwZXowd21leUdYbVRUMDJSZDhWR3krcDMxaHNGdUhD?=
 =?utf-8?B?WFV0TDZhbFRiZ1RSU29WRmhQRzAwZ2lwbExYVlRkVVlkREtFcnRNM2phSHRt?=
 =?utf-8?B?WlFPeHU4eG9EcXhRcXlreW9ERlpvWm5Fa1p1SmxpRzZxVGEzcS9yT3M5TGlY?=
 =?utf-8?B?VkFuWXVLSGc3VGR0bk5iQVV0cWhYVVo4VVAwNE5vb3ZwOWNSTE1IT3pKUUQy?=
 =?utf-8?B?OG54K1lzOE95aFF1R0IwTW90aWlnaWNFc0FzK0twdS9DRCt5eW1iaWhoTVZo?=
 =?utf-8?B?em9OTXZ6YU8ybzVjdUI1SlhhUW40ekliaHNZTFp2ODFqbG1PQ2pCM2ovTjgr?=
 =?utf-8?B?WFU5ZEg2ajFjWVQ4NUhBTTl1NmRISGpFVTkzaWNuZW1PVEJ1NVFaa0VwR3pK?=
 =?utf-8?B?azQ4bnJUdU5Pc2xMVUhhWk42S0toUUV1RHBlVTZTcExWK2N1c3BVWUJWQXNw?=
 =?utf-8?B?d2xiTFo5K2kvTDlZcEdzdVBTZ1Rtc25BWjl6a2xxRmxRVnU4cG9yU0gvM01Q?=
 =?utf-8?B?QXM2eTcrRm41bzIyWGZNOCsvTmxCU1EreUZOS083dkN3RHZJMCtPUWcrL2la?=
 =?utf-8?B?T05EYnl5TWpmNDcwQ3VCT1lKN3ZnOXNaa25XZFRBNVIycEZkUHl6Q0lGR2ZJ?=
 =?utf-8?B?OFRRcVhsT1MzZUpyK2VaS1pETVZkVWFHWWdZMTJuek1pSkU1dmFVWmMzQkVZ?=
 =?utf-8?B?UzhyVFBMemxBRTlEZk42dVdoR0s3bTRLcmY1eTlqU2NEUTkxYzBlZytjK0tq?=
 =?utf-8?B?QzNyYlE5QXJ1Q0Z4QXkyY1duWXRMSTcyVG1LMDNLcyt2Yk5FQ2NFM2FRNnlk?=
 =?utf-8?Q?fYdAlXulbOUgHYIvi6PyhnTBZ?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 431a5a01-70ca-4d1c-f353-08db9f2d4361
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 14:21:35.8083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ZJ0//63ddnnKgC74DePbPuOfwbMvKVnwZEpTARFLpHVmfaP/NFfOatYHYzwPDj+18L6gIYvz4fX84WRCgIW7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6879
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Aug 2023 14:21:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12769

On 17.08.23 16:12, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> The EFI and BOOT file system images are created non-reproducibly because
> when `mkdosfs` create FAT file system it uses random values for volume-id
> and creation time, this can be fixed by passing additional option
> `--invariant` to `mkdosfs` that uses fixed volume-id and creation time.
> 
> Fixes: #73
> 
> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
> ---
>  scripts/lib/wic/plugins/source/efibootguard-boot.py | 2 +-
>  scripts/lib/wic/plugins/source/efibootguard-efi.py  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> index 7435b22..490b19a 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> @@ -160,7 +160,7 @@ class EfibootguardBootPlugin(SourcePlugin):
>          # dosfs image, created by mkdosfs
>          bootimg = "%s/%s.%s.img" % (cr_workdir, part.label, part.lineno)
>  
> -        dosfs_cmd = "mkdosfs -F 16 -S 512 -n %s -C %s %d" % \
> +        dosfs_cmd = "mkdosfs -F 16 -S 512 -n %s -C %s %d --invariant" % \

What does OE/wic do for creating dosfs filesystems in reproducibility
mode? I do not find --invariant in their code base.

Jan

>              (part.label.upper(), bootimg, blocks)
>          exec_cmd(dosfs_cmd)
>  
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
> index d6cdf0f..2c69609 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
> @@ -105,7 +105,7 @@ class EfibootguardEFIPlugin(SourcePlugin):
>          # dosfs image, created by mkdosfs
>          efi_part_image = "%s/%s.%s.img" % (cr_workdir, part.label, part.lineno)
>  
> -        dosfs_cmd = "mkdosfs -S 512 -n %s -C %s %d" % \
> +        dosfs_cmd = "mkdosfs -S 512 -n %s -C %s %d --invariant" % \
>              (part.label.upper(), efi_part_image, blocks)
>          exec_cmd(dosfs_cmd)
>  

-- 
Siemens AG, Technology
Linux Expert Center


