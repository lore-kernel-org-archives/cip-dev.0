Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5D3C636CC
	for <webhook@archiver.kernel.org>; Thu, 16 Feb 2023 09:55:08 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.83])
 by mx.groups.io with SMTP id smtpd.web11.6708.1676541307344703704
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Feb 2023 01:55:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=AHb2pLYN;
 spf=pass (domain: siemens.com, ip: 40.107.8.83, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7IR8/AX+/0hCz1wIjZpI3/MsvTnTziEYH1CuX7aPz2VGvTnZk55+FcSqycLwJlvyP6AwW8JXgoyXCs3FrkgP08pY+QDHUaqWLG7QApWbzTX74MIqOeD+/yMjxMhe8d2sH5LijeqYJz6vVnL4+E5Hp/vBDn+pVtZquElAzPcTSovN84E+ESJCnf8+PVE7ygceZt+qLQMNAfiDDFtbQ3kP41HHVGZaqzv1QiUMhwa1hSFsaLt9jC80WK4jBnvOJ/dNoTIkoC8bhNCGrKSC4mfwH5NM0POjVj9xZ6Im24ltVBF5mp1oHaElC/1hW/21s6W7nE0TJ05VY1SAZAz0z1OQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okJ8KCoBLoEM9ysBxH/j9jrA6qGIbATn6zT45k6ILVk=;
 b=FZXzz8h+CY+48ELuDf1eMmRog11wXBcFJ5dZkraaAWzEM4YN2XqZ1fh9Da8cW/a2J09wGUecMYuQRlYDIhnnOtbcegvGDAnARO+dRAhVIpt+P80l+QWP7kXU3LNBMG9H3MLcRP4LUYmPUWZfgYOTKE1FviQxs9Km1TcrA3eeGlovopjICrUd6eC+rWFivZZ2Rg+yhWjFcdSXBxidP7koEOQtoHu8kmFQ9WN/9eTzpCEG/UoNhmDEvLAAxrBrtvoQfkKLdwCJiEl3ujpvOIij4lgxoozEGkRNyUnrD6TH1gdDd7ilZmbfLtcQZvM5lF7eLcsvvachIWJ3zB41DmJBzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okJ8KCoBLoEM9ysBxH/j9jrA6qGIbATn6zT45k6ILVk=;
 b=AHb2pLYNS577bUBIHmukQCf4x3TA8Dy61J9NghZogP/hKf4TCjODnVZovY9iF/Gyyoww9bbZFrBgnqPuVhPiHG5lRl04K6GhgJUs2LFlwCiba9Cpfjk2BB4Yd1VJn+bG7OsenUNqzpGurhaUWL59kITmGLATZHIgXqK6+zM50btidoDdI+xt15/czsOgqnQMWH3+VUraVnkDqlSpbli5knGQVYZN8RmRN7JkSiTST/muXZ43ghjOFs6sd2gj6/JJSroJEYRDgEZY4NS03ixJ2U664h6w9+v51KzMqAs2X3drPhK0no2f2KkImrXlp5ZW+JmVF8sfiLgUEKdKE7woXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3788.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:29::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Thu, 16 Feb
 2023 09:55:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6086.026; Thu, 16 Feb 2023
 09:55:02 +0000
Message-ID: <f4370fc5-b423-444e-5a3a-b77c13af7067@siemens.com>
Date: Thu, 16 Feb 2023 10:54:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [isar-cip-core][PATCH v5 0/8] Rework image classes
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: adriaan.schmidt@siemens.com, quirin.gylstorff@siemens.com
References: <20230216033544.1990604-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230216033544.1990604-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3788:EE_
X-MS-Office365-Filtering-Correlation-Id: fbee9294-61ef-45ad-230e-08db1003df3e
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	z2dVnlWZv9KlHFo/aRPIKmIz8+NORJkge5U0MCysmzT4tuKsmpfuSnUPHQ9HNZsOH3Z0DsFAXqR0ARxdKbcrhUFYP/w1zocVz5FLYoBKzhYd6a9WaPnlbQtqZY7txswclGHQH1UxGoyrHya34y4M3uqFt1VFNmViacxf0DnPoSC7bal2j8uYgng+BClQ+4KCj7vtXwpznq9L6qUK02q7bEuQi1fN5xPzaGFC+eUj1CHdRBTjJUt93EjMvrDddg4oyY4y4HqysG4Z8raPYHkqBX1JZhH55gnteEkynEaHG8aprMQJc4UYCnt/SAZ07mkqwUBjLQvxqgJp1nhJgW5fz8U1UCbFMcwoGTr8wJzh72LlJUQu5K+AZYjz68ndsJQgQCxtadPjB8/mEzdvUCfkRcNkAXSWflN2k8FCmqVNIj2jpjf21K/sgi3wMKfoYHMsy+bTDOqTPSs2LbelkLagr0hg40qs9zT+GjnU00hhE0QzCEj9PoXVaA5Cvo0ouplnXWHYs0m1RrfXmieDLCgt6DUYGN0tvFc96felmnbGMmygq++4sEE24theDPW2EiOsz+Rur8VC3NvkvDK6y3rGUDCFgAq7k6+Neg0bAsYlwSPXzymAwZnDTqCNhJKSaDpTunFXziTnErF53Sg+RosYLtLG94T6WwVjkpPTuiNaxEM/rg0fKvpqs0m7TrlP0uSvuNpF6xkXpKqFrcYGPiFkj2sA1+3Nt0i14k3IB2x/QDQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(451199018)(6512007)(26005)(2616005)(186003)(38100700002)(82960400001)(36756003)(44832011)(2906002)(6486002)(31696002)(86362001)(31686004)(53546011)(6506007)(478600001)(83380400001)(5660300002)(107886003)(41300700001)(66476007)(66946007)(66556008)(4326008)(316002)(8676002)(8936002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z3R6V0tTYjhWdEJSaUxyV1E4ek5FRVlJNjl0WUcyVmJ3K2c0ZytiSVNoWHZy?=
 =?utf-8?B?T2VjZzU3c3hkUWREcmx2NEhIVDNpd2haTEpsd3R4TEYxMDdCWVBTcTZKd3Yz?=
 =?utf-8?B?cXRxMEFDMVFKd202L2grTFZQV2hFaElsS1J3WFZrREMzK2dHVkdzRHZEN1lI?=
 =?utf-8?B?NkE3dnVHYzZCM24rZ0M5SFlKSkhiZFIzdXVuQ3RKa2RQazgwamJXeGJydWt1?=
 =?utf-8?B?NzdaYy9MVjNlUHg3NGx4SWNFbkViMDVraEEycjg4d1g5RFcyWVgxanREY01l?=
 =?utf-8?B?SG9YV1hRelZVS3djK1p2dEVwUy9USmpWcjFMYUR3dks0d25CRVNoczZUOWRJ?=
 =?utf-8?B?TWRyUlhsZkVXcjZVMHhZYWZKYVFveHpaeWhsaU1wdGxpQlFrQ2M0V3RpZnF2?=
 =?utf-8?B?SnZ2ZnAzd1ZpYlRLczVqU1lMbWVUL1VkeUEvN1h3Mm5OaE5RQjZVcG0yQTJI?=
 =?utf-8?B?RldxRnJoL3QyMUJhb1FwZmdieUY1bG9tM3ZXNTJUbEJUTEVxUmRqQmIyV081?=
 =?utf-8?B?SmVUdFNOZmVlWVhEVDdWSW82ZjBqbUd5NzBndjZSRCtzNlRiRFZMVjdkSkdX?=
 =?utf-8?B?Yk5TQU14MmF3VUpxTi93UlhZYlN1bFdqZ3ZaS0VadXF3aGY3SjVmbmhMT3Vh?=
 =?utf-8?B?ZmdJY3pIWGJ0bmkxWDRobktqOWI5R0J3TEJzbTVzSEM1OFBVdzFoayt4SVFN?=
 =?utf-8?B?NndxZUd1MnJKbEhvWFdwS1pOTWNaR3hIMFgwZkFFS09UWXVzWGNzZyt5U09z?=
 =?utf-8?B?OWZkdFFmYlBMUWtNVThreW9ESmVscmI4RkV4a1VhT0dDclJ5VEtyWm80ZDRZ?=
 =?utf-8?B?cis3cEoybXdhSTBuQmw5a2x1bG5uVDNOK3IwNXhuRTA1ajJocFlSS1RFTTND?=
 =?utf-8?B?WUJSZStCUGcyalRUN3g4eHFUbEpDYTR2K0c2WWlUV1hKQmVlY09IaU9EVnZj?=
 =?utf-8?B?TjRnSjlkR1ZTTG5TTUZIaXhiQWZOYi9FTnpLcGIzQWkxRnJsR2VsdTdoSmVq?=
 =?utf-8?B?MzJjcE02cEhTYUlxM09hUUV6cFFMRTdRM0x3RFgySG9Zbi9CbUhJNjRVV2dt?=
 =?utf-8?B?Wk4yOFZxbDB2aE9udDEzVkN0MGRLeGV5MmY5dVVDL1k5YzlkVXpHUDd2MU11?=
 =?utf-8?B?SXpiaDZlWFRKMlNDVlBhNzUxNkM4dXMvTFdYR1pjMmsyM3ZvZVZER29MelpO?=
 =?utf-8?B?L2JITkNvQ09KMjVMOElDaGlHbnUrTlV4Z2dJdm0yLzFqV25pajV3clNMZWxa?=
 =?utf-8?B?YVRqQXQ0VWYyUm81aVhpRXV2bUkrbmVtcktrRzhxbnlBVmNlRXZIQVpvV1Ar?=
 =?utf-8?B?RXJkRVR0MkU4QnVzaVpvekZiUU8vcmI4UG1ZeWtkbEFITk1ZTTFiMW85TGtF?=
 =?utf-8?B?ZEpmM09Camt2WDFGcmJFWWwyT2N6QXlyZGc5RExyZmtLRDdCVkZXN2FxZjls?=
 =?utf-8?B?WEIxK29mOFg5aDBrWTkwakNsZFptNEQ2ekZVclhWSW0weUIwbldRdjl2aGN0?=
 =?utf-8?B?OS85elg3MVNFYVFDNlpqVFg1a0EvcUZmM3ZLNXhxNmVqMzh2V2NsU2xvVGZY?=
 =?utf-8?B?QkZaSHc4VUNrM2Nxc2dXekpyWDIwK2thcDBwRi9GTFlvOU1mT2NkSmw4UXhH?=
 =?utf-8?B?andEWmREODdWTXI4Rm5SUk1YU2dmVUZXNW9FOUdwaXNyK3VmRU1yZVlIUzIy?=
 =?utf-8?B?ekhiemZsSWpicURsYkZGcExCZnJnK3pSaW5VejEyZ0hqT3ZTVkg2UkhyWnlJ?=
 =?utf-8?B?Wno1TUNQSmZuUkdzcTY0YVhhWDZDSnZaT2JlSWlpLzZGKysvUkplWnpOK0N1?=
 =?utf-8?B?SWp1SVZabmlVa0xsTWMvSUhoYmJzMGpBU2xlK1lEWEpwblhpMzVFc0NBUEtr?=
 =?utf-8?B?U0Vib1MyNVJBU2lWanB2enZUWk5UODBSZE43a3RYQTdGbm1HR3VSTVZZNVBs?=
 =?utf-8?B?VENVcy9XTktJNmJLdURTWHVyMzF0THM2TmpVYWhBaS9jUVY1Skx3OU9pdWpq?=
 =?utf-8?B?SGJ2ME9YTi9raGhGZ2Ntb2Y0clhHZmVlZHdhMFBnVWhjZERtWFQzSUhVMWw3?=
 =?utf-8?B?WHBLRGJMZGNuWDhvMDlzdzZxbHUwNkNIVVlUMS9ubVVqT3pCM3hvdVovSXpx?=
 =?utf-8?B?eHFVaXZQOHRFNWswQ1FnRENOenBhSktWbmZpS0h2ekhnL3drK09VcjFrcy9N?=
 =?utf-8?B?bXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbee9294-61ef-45ad-230e-08db1003df3e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 09:55:02.1092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OAr1oQ02rSAlL6YAINafRJV2DnLpJywW3LTSopabjFkIWK8QRrn2DaV6btzRPuc41IP57pE0SshCDyPnFu2gPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3788
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Feb 2023 09:55:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10712

On 16.02.23 04:35, Felix Moessbauer wrote:
> Changes since v4:
> 
> - append default sw-description path (instead of prepending)
> - remove IMAGE_CLASSES used in kas in correct patch
> - remove IMAGE_CLASSES from documentation (is now handled automatically)
> 
> Changes since v3:
> 
> - add patch to make sw-description spec compliant
> - replace hand-crafted swu compression logic with imagetypes
>   (+ support for zstd) 
> - prefix variables in swupdate class to avoid collisions
> - avoid double-inherit in swupdate.inc
> - explicitly add sw-description path to FILESEXTRAPATHS as
>   FILESOVERRIDES do not apply here (see comment for details)
> 
> Changes since v2:
> 
> - remove unnecessary dependency to template task (it is a dep anyways)
> 
> Changes since v1:
> 
> - separation of concerns: do not append to :wic typedep in :swu [1]
> 
> This series reworks the image classes so that they are fully based on
> the existing imagetypes infrastructure. Issues with swupdate on non
> default partition layouts are solved by directly using the underlying
> image / rootfs variant instead of a fixed wic partition. To support
> further customizations, an interface is provided to select the type of
> the rootfs image (e.g. squashfs). The verity class then uses this interface
> to configure the swu.
> 
> [1] As we now use the image (e.g. squashfs / verity) directly to create
> the swu file, we also explicity need that image type (compressed).
> For wic, we now explicitly have to state the imagetype again, as we copy
> that into one of the partitions (but this is not an aspect of the swu type).
> In addition, we cannot simply always add that type to IMAGE_TYPEDEP:wic, as
> otherwise always a squashfs is built when the swupdate.bbclass is included.
> One key aspect of the imagetypes is that they are non-intrusive. By that,
> the classes can always be added and only become into effect when selecting
> the corresponding type.
> 
> Best regards,
> Felix Moessbauer
> Siemens AG
> 
> 
> Felix Moessbauer (8):
>   register image classes via layer.conf
>   refactor: use imagetypes for swu generation
>   swu: directly image from squashfs rootfs
>   swupdate: only check partition uuids on swupdate
>   make sw-description spec compliant
>   swu: replace custom image compression
>   prefix swu related variables with SWU
>   refactor verity image creation
> 
>  classes/swupdate.bbclass                      | 73 +++++++++++--------
>  classes/verity.bbclass                        |  7 +-
>  conf/layer.conf                               |  2 +
>  doc/README.secureboot.md                      |  1 -
>  kas/opt/ebg-secure-boot-snakeoil.yml          |  2 +-
>  kas/opt/swupdate.yml                          |  4 +-
>  .../images/{files => swu}/sw-description.tmpl |  7 +-
>  recipes-core/images/swupdate.inc              | 21 ------
>  8 files changed, 52 insertions(+), 65 deletions(-)
>  rename recipes-core/images/{files => swu}/sw-description.tmpl (84%)
> 

Thanks, applied with the already mentioned series-internal fix-ups.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


