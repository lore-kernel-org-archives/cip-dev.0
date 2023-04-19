Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57C0C6FD18
	for <webhook@archiver.kernel.org>; Wed, 19 Apr 2023 08:26:18 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.79])
 by mx.groups.io with SMTP id smtpd.web10.32590.1681892757984075937
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Apr 2023 01:26:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=aV4LWT+U;
 spf=pass (domain: siemens.com, ip: 40.107.6.79, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5OHXzw6CzE5Qk8UWJUDPa8il3qjzXGelhzyE+nZ7JLy918nZQCoYviy2bjRER9iv5NucWpMovUGJJV589ubu5OY+sMO9wjrO54rum5KJnCxlBZvs721n0RTxoUluf7k1XTGLIdLfbxsTACkcUQAqeF5Ck8qw6uJ8tl4EZ6dvxnWVmhYMC5GQABIo0RizteaZCO6jsMgZAsoip5yUu3PnyezvhJwBYTR64StfgDFr9Mbkd/+WC4r5j0oJwyGJr5sq+yWb2I8A4rPRcBIEODDb7d4yAoyOfjcvDOtUEGJwwEcM3Lxuy5cNWBCx8L0gSytuJ7vD3pqQS+6eHvKKYNQUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJAoxvUgoFZQeU3Bar6C77yXRWpwFXL2aQw3qoFB7Xo=;
 b=PeW++4KI49mLBAYPjqmxvICTUMKjaYJejglY8JvzLZS8+6wCv5Tm4AMpdz0hMpcOiruDnpu2905NNE2wQwngQAFZlOLz1K5P9kvUYoG3VV1Q8zZjU8+9ftzP3b1cNJZllltuFvvuGCo2Q8Xq/g1ljHBll5heAhXX6tD9R5fX/a41YCklfgccnODISPb2gldCLBb7nssaOmbfCBAWK0XLREq/tLbuFPMxyooNkLyF12rihl++Q/UYhUHueQxYfOSUKi/MykuPgcg9MweWFyunDgewqgxlJBb3DnVo/e5ARRR0Z3fBP06tF37UKw/ShNwZwY+BdQzetM4GsC4ugZzrmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJAoxvUgoFZQeU3Bar6C77yXRWpwFXL2aQw3qoFB7Xo=;
 b=aV4LWT+UXEmCDLM/FihiOsCBbXNTFt3USxzUR7HJkJ1tmb+GKBGFiAT4A3v/PrRbXuGCK39P0u3HbGUrmbltjf2v4sWdHe2458lwT8VjVsk2IqMGNWFm3INdbI/Mt4pUdg9lLiFS/SzmHer2GUFRi5Zu6X4MN+U3MCX8CIosYdtg9caNdn4UffKPR3Cu6gPqS128uUH3wIGf2UID/amkwE+0uDDH40+BKbTQvGt1LkbXkgy3dzoSmsMK27npIPCfn22mr+/uu4wMJ5MUgWsEhY1kyqdWT0FzcBC+uBQiH/UQIZjsHSg0OxDZ6j3sVPFgtgXDDtFWF+vxG9UpCe6rbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB7968.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Wed, 19 Apr
 2023 08:25:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%5]) with mapi id 15.20.6319.021; Wed, 19 Apr 2023
 08:25:55 +0000
Message-ID: <b4de627d-61c4-8d6e-9a79-49d0889f6294@siemens.com>
Date: Wed, 19 Apr 2023 10:25:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [isar-cip-core][PATCH 1/1] fix operator precedence in ebg and
 swupdate
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com
References: <20230419024859.19550-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230419024859.19550-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P250CA0013.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: 209cc150-3d41-4c6a-6d42-08db40afb218
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ow1w/iV7WEDA5D7HhcH1SzcLTjASOHoPAmswOQweDvowRADQDJ3LvUKZGmbcRUU5B3unkHs96IfTXkdbh6sLgeWhDnDqK29x1u1femxLPCDlOgvLYDNQwIBuvr87ia1isu+izuTMdCDHyy8sLQA6VbcVSQ+oBdpuDlDmrD/AimjpPodpRpc84a4oJkrtPkHOYOXG1/8NAM5lmnuVPzdS8ploqRvhFcc/UZxL0z8Kk1VVRyCUDHUktBMUAvFgTz+9kgKa8kyZExNcSN7pFNxiNn3XEiZ7WR4ni/TPucI1XTXr9ZWiagHzM6DfHnMRrWs/A62N6I6MqkbuJck2Njv1oUjnxSF7EEfsS5d7BTcAiiByuN0WMiox+yPJx+roz04a23SZgvsG1QuddtbcLMM4ss0iZvu4LwTjxlv+KtMWgEeYi/l8cNnKTVFPzFg3hlr5IfVl3Po23m5zK6FnISRsHszsqjyhPuzUBXEwkjjmw4AeaaXBA835YGbYltRgo8Bx1ZgK8tu5bBIfcRY1R1lh+p8jUwVVDyI6q3iQhfrapAVE9BbboBgnMJZ+q6AJ8fWXzFR1u9mx2DnlnwDiXVlSsRS6JQT/SjLKKzjmgH3zZBWM4cRHUBJ3Yz+p69mw5cH6BIuQcia9YXZHp8HlHzob4g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(8936002)(8676002)(5660300002)(38100700002)(316002)(4326008)(41300700001)(82960400001)(2906002)(31696002)(44832011)(86362001)(53546011)(107886003)(6506007)(6512007)(26005)(6486002)(6666004)(36756003)(2616005)(83380400001)(186003)(31686004)(66556008)(66946007)(478600001)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NEdYR3ZYbUg5b2UzV05YM1V2b2tYUXBmNnR5VzdNS0VMZ0kvQUVleGZ1TVVY?=
 =?utf-8?B?NkY3dWgydzArSG1MUlpoNjVKNWRzSitCY3h1NXFqWXB1czhQMUNrTnZOZjNw?=
 =?utf-8?B?QmhBcVMzZlFUbEZSVjBJaWNmcUFRbVNHK3d6Qm9jK0hzV3p1NDZzZHYvazVM?=
 =?utf-8?B?MjR4Nm55RHZtVFlLb29OZ3VWZ0ZYc3JEc2RienQvL3RDTXVRS3ZwTHU2OU0v?=
 =?utf-8?B?dm1FRjVFQU5CR1E0ZHZjaTE2YXF1VHJ6WUoxQ25HNjNiN3dGR0xmRnZYSGhM?=
 =?utf-8?B?REM1NWlWT1dmYVVlRW5IV0pxN2h3L1Y1a3NQYlhOK2psemVOOXNCZkNJNXN4?=
 =?utf-8?B?eE96UDJRTzZ3SXJmTjk3UlZTWjI4bEFRbERqYVhkVzdSaUNxT29PaUxUZlRo?=
 =?utf-8?B?QlRUVXhQTmpYSFZSMGg4cjJCRjY3L0UxejBEYW1QRy9JaGlNVnV5RnFFcitV?=
 =?utf-8?B?NEMyYTRWUFMrQUVvRTk2UWxWZWdTcmN4Q0l6L0pNUFNDbmpFRHl0NXRnUDM5?=
 =?utf-8?B?NmR4aFEvRkVpTVZ6Y3ZtcE9Ub0NQZHk5dzRUNldXaGJuZkxacUlTYlNBelpi?=
 =?utf-8?B?WnkyeWFwZGV5cmk5TXlmVWVDMkRNbWpJd1k3ZjY3RFF3VXhrbjNKdEJycmt3?=
 =?utf-8?B?bmtOME9kVy9xdmdYckdXS1laWTlwRTBYalBLWnBhN24xS2ZtMElyNEQ4cDVQ?=
 =?utf-8?B?dWpjWXptUWZDaHQrRDlTMVFxWkd6ZFN0cjVLdEFLeWVtbGRqcVhpN0dhVTRQ?=
 =?utf-8?B?TTQ0blJCZTA1OC9KK1lPcGhhUk9NazU0QTFtUWduOE9UMlEwQW9yOGJjZGpY?=
 =?utf-8?B?NXVXZkd4bXRRMTQ0WDN0amFYVzhvcjRrQTFmRWdydUl2Mmg0N3ZydnVPbmp3?=
 =?utf-8?B?MnY0ZnZwYVVEb2c5aVIveS9pN1p2YndaaGdsa1pDOFBvdDZ2UjZRb1U1OWND?=
 =?utf-8?B?TmNVby9odkJHaksyQkV2YXVnZGNXdUZjT1piSkpPNnQyV2JydmdWS3h3Smt1?=
 =?utf-8?B?bDBIRVkrYVF6RjZXallYZWhYU3ZVLytod0MrdTBtZDFQKzFScVZqSytVQmlC?=
 =?utf-8?B?dnBGSzZxRngvK0EyaFZ0MSs0RjlZS212YUZjSTdpY2VUc1NtcGtFSDJ6V2NU?=
 =?utf-8?B?NkcybEFoQkpMQ3ZycFU1WC9mU01KUjk0dGVPZW5KSEUyRlNSaTRCeHBwK2pT?=
 =?utf-8?B?M1ZKeHFzWlZGWUhXMmNHdnA4T21jU2dYdi9KYVhzem1OckRiOVZuZys1N1Jo?=
 =?utf-8?B?Ky85bXN0TlRNY1Q4eGhOTDlkb0oxYkhWZDB2NmIzVWNWTTBabmhPRFlPQ2xl?=
 =?utf-8?B?VGZYZm52RTkyQjVJVnBLTXJHR0lES1FVeXF3Y2U1d0JRNHROa21qTDlrRWc2?=
 =?utf-8?B?ODFYNWVZeDZSTjRiNXFrVDVESGMrK25PcXl0SlN5cTRZWCtTaTMrbEV2UGVs?=
 =?utf-8?B?VHVEWDE2WExPTGJ1bnRaOWtiT0Ywcnk3VDY0aXhzVjcwUkFQTWdheUgyMU1O?=
 =?utf-8?B?WWNWWVJ0ZklDa0ppbXZCblBwV1l0T29PVjR5aVBPY1ZQNjFEa1Fiek5ML1lk?=
 =?utf-8?B?N3JnODgyWVNYY3h0TXdlenp2RGFvZlhNRGZqVnRlYURDOWxkajJlMVJ5aXRy?=
 =?utf-8?B?czgySDVjVForVWY0YlYzUytOTkJnZ2doWXFYM1kzaDZyNmpLa2sxdlgwSTQy?=
 =?utf-8?B?L2d0VFZ2QXJ4Yk5MaUZibEdTMk9rTG1SSllIOW56ODVXTEU1WklmT0gvYkJ3?=
 =?utf-8?B?N1ExTzZTdHBaSkp5Y3dxM0gySkxTQXJicVA1TUs2bjhmNlRUNURWL1Z4ZjF5?=
 =?utf-8?B?T3Q5QnZJZmJKbThWVDhmRkladjhwc3VnTk1Kc0cwRXRNY1dkSy91YThmOURy?=
 =?utf-8?B?Vm9oZ1hIdXk3STdVTTFwcmdDR253Vit2VXR1Rzc3VVFrMEZuMzZudEExQlBl?=
 =?utf-8?B?dWk1UndURXRnTlF0NUVOUDhURnNRNFY1ZXhsNFpWMTFvUjBwaUVmRkErM3Jn?=
 =?utf-8?B?YkJDdlREUEE4a0ZVY0x1SlVtVG5LbHJ3Vm9ITWtJUTN3VHlaZUwxR2NDTDhP?=
 =?utf-8?B?L1NnZXJlSG04U1FPKzlkNFBILzRnUG85MFUxdncwb1NFUWRyQlRIbjRUOGdB?=
 =?utf-8?Q?GkfuxAFRXPXB7yjRNDOdvYt8i?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 209cc150-3d41-4c6a-6d42-08db40afb218
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 08:25:55.5919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a2obWJep84/VKL1TxlbzSMQaekYkFNm1M1FuCr7u0Hz4baUSL21PcU32rmnXC0c+9SSSEAr2xXQ1/xlBXTQrIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB7968
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Apr 2023 08:26:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11229

On 19.04.23 04:48, Felix Moessbauer wrote:
> Instead of using the += operator, we need to use the :append operator to
> append IMAGE_FSTYPES to a target. Otherwise, the additional types are
> evaluated first and by that, weak assignments ( ?= ) are ignored.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  kas/opt/swupdate.yml                 | 2 +-
>  recipes-core/images/efibootguard.inc | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
> index 2899d6c..29b7dd6 100644
> --- a/kas/opt/swupdate.yml
> +++ b/kas/opt/swupdate.yml
> @@ -20,7 +20,7 @@ local_conf_header:
>  
>    wic-swu: |
>      IMAGE_TYPEDEP:wic += "squashfs"
> -    IMAGE_FSTYPES += "swu"
> +    IMAGE_FSTYPES:append = " swu"
>      # squashfs is already compressed
>      SWU_COMPRESSION_TYPE = ""
>      WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks.in"
> diff --git a/recipes-core/images/efibootguard.inc b/recipes-core/images/efibootguard.inc
> index bb1aa1d..23fb215 100644
> --- a/recipes-core/images/efibootguard.inc
> +++ b/recipes-core/images/efibootguard.inc
> @@ -18,4 +18,4 @@ IMAGE_INSTALL:append:buster = " efibootguard"
>  WIC_IMAGER_INSTALL:append = " efibootguard:${DISTRO_ARCH}"
>  WDOG_TIMEOUT ?= "60"
>  WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_IMAGE DTB_FILES"
> -IMAGE_FSTYPES += "wic"
> +IMAGE_FSTYPES:append = " wic"

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


