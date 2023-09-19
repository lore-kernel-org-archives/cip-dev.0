Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6F7CD54B0
	for <webhook@archiver.kernel.org>; Tue, 19 Sep 2023 10:13:51 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.81])
 by mx.groups.io with SMTP id smtpd.web10.4949.1695118420328038623
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Sep 2023 03:13:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=NBCu+bOl;
 spf=pass (domain: siemens.com, ip: 40.107.8.81, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzGTmb8hG7wc8aoCgOuLNO8jGvJ2WIkuNXwS1XgeNbY0c9FRe4SRwRr0OjFPvR6jiQBWvLjlUNW3OM3+rgmHMzFldBql3zF39aUaSHyEcfIbquyBVmiTbK3L5HLe1dKTk0kWi39ukLATFPXRdGabr46/YGkBJMgSo2OiQm/5ZNjfrvXZ3vsYSa2Ua9csACDXSczxbgTa/XD2RyQkSD3N6Ncyz+I8I5XAnBpSDCxo7EaN10tZaJrRaNMVH29dsVBCwCSKEUyDfy2kjOcKdeRSFUgSch7WlEmUgL7JnawN0H9mrO9xt3X/78hPrdZgQAyrSV5j2Tjic3I/31kJkqhzHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LW6zHUjCddoE9ZlqLtxRhpogxdEv8bFRcmv2fjJ5OY=;
 b=FGy5cuLwTbkUVE1nl9bBqezL5Cmx7EdyLn23Kw6PTm73bRhljLmcVxmAMXAJD79RrKbY9FCY6gpS6HHiUCNnvvw/pwRu21+jB8UiOL3IZgfmo5C6vrxAbj4VLa7yK/Od65K8pvj31JtFkanmbmHo+2IQw/4UnRCfzMw+d5KohwdQuGJ5EaechEWiKbX5wfDtREByT78T5uX0MytcRjPzCyRtnr6lKnzDhNAkByRtPLgk62Trr6fpcNoZSr7+n6BUab9PL8DbryJhrMzVgfOnR+HHhFpfTapf0oSNiC2oeq2YzwXCTyDEb6pbKfyVdgwzMI42st4VNH6K+JTfMhXYVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LW6zHUjCddoE9ZlqLtxRhpogxdEv8bFRcmv2fjJ5OY=;
 b=NBCu+bOlcPY4NgaFoBjnZ4QbO/OY/GO4pYKWNcDpNEq5tTSIoXfRW3S+a1K2CsmGxDg8jb6xRQfEiGkd4ICRR4R6+v0bAadiNIy0oa8u141tWNabY9Z7plVvTN9Ox0f+N9rjtxBImt2DfrdKOBZ2eLVyXo5q+rZ/ynZOOpT1htjbp1rUbzjErgfBbkDtKeXkUxZFrU1hA6ALmE/+XGxaPvr18PXOYqgr08iMKldq4gJ4R1rVUdWeZWBbZfK3k8Cm9vWDt42UD9rRT3w2HL5vqVfVo60NooRq4JbP1Do7bdgqCG3HRkhW8ABuYN4tpYwPFAhCdMTqZYZrA9jb7De0XQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB8210.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:386::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 10:13:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6792.021; Tue, 19 Sep 2023
 10:13:33 +0000
Message-ID: <58dd05d9-d5f8-48a8-8cf8-935de77e4dad@siemens.com>
Date: Tue, 19 Sep 2023 12:13:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][isar-cip-core] Update kas config file version
Content-Language: en-US
To: Srinuvasan Arjunan <srinuvasan_a@mentor.com>,
 cip-dev@lists.cip-project.org
Cc: Srinuvasan A <srinuvasan.a@siemens.com>
References: <20230919100732.67656-1-srinuvasan_a@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230919100732.67656-1-srinuvasan_a@mentor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0009.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::19)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB8210:EE_
X-MS-Office365-Filtering-Correlation-Id: f384614c-5f45-4e11-2b34-08dbb8f91479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	oDIJvDBUWBer43P/zp3kCWOoXOk03UiuqN59dQiHrIfOMc9j9MYR+G7+s010HaIp1MpxR01YdMYJqUkcuvjCDPqTQ3cfyNNzaL3gIW043a2OWZ3h2K8Jvu4VG13oLRbjQXrc0ahZ416muW3Y9HqbZhrIz8S6M5O5pFhJBE2cbtL7M+NDyAE6gtkDWTxR52YU44QhAoRwxY67BA3Q1woCOwhcIPnDKiWBsnlRvIxi993ustGs+8O08TaHnu26vIcnkiNq+bO/JdQvMupQzvOnaE4+q9Q2nLczG4kf0Q9/+ij6lR04JDeP5rcWJS9qClGrJrb7ba1ihEHXMJTWiG0bIYZVaQuLRN63ZEz8d9h1YbLiu14XNYO/+N7X8YfG+ZKl7ZceQZSdlF74aOref+zScYXzLTMG44J3HxVItQ2p/TyXaR0l8HTxclcp8MYwfYTjUuk62PlQZqY0677GXW5JX4zW1zJ/VoFG9szsdzPi8lYwmpTKlJ+c5ugvcFsYkBOBdKETR0I0oyBbMBHFb4d1Ora1e0jHjWxN1efQl81R0P1//hUj6/+HrvGNq5ph4kY6ZR1Zrf/56cesvof0pSPn0spwPul3fDDpF/H4dq0DGiGQlk2Dzg8kBaqkx0P/V56R/ePainDJV/8tsXOdybO0qg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(346002)(376002)(396003)(451199024)(186009)(1800799009)(41300700001)(31686004)(8676002)(8936002)(4326008)(107886003)(2616005)(82960400001)(38100700002)(66946007)(66556008)(66476007)(316002)(6512007)(83380400001)(478600001)(44832011)(5660300002)(26005)(53546011)(6486002)(6506007)(15650500001)(2906002)(66899024)(86362001)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R1RVYU9IUXp5VytBakozY3pvZWYxSVZ0K01RZUd5WVFhWG55bWtGckY5QzBj?=
 =?utf-8?B?VmtxdTNBZGVzc3ZhdzkwcXZ5bmlPWCsyRnd0dGVFYjhjRkR2d25iK0pIb3hO?=
 =?utf-8?B?OG56bnY2MC81MDBWcFptM1p5VDY1UXhYRFg4dFhCOERzVTNob08wd3l2NnN0?=
 =?utf-8?B?RWtIcDVEL2JvSmJBVmRkYnRhM1BWZE9aaFl5dTRlR1BzRnFTekhiYUdRSHZW?=
 =?utf-8?B?djJSQWJ1ZUVuV2NEeDZjcEl4WlZDc09MMmdQQnpvemhzbE80LzRuU3B0elZE?=
 =?utf-8?B?OS8xWVZaY2VjdXZ3UzVmSTZTbDRMcEhMOVMxMXE3em1NUlQ2YlRMekgwc0Ev?=
 =?utf-8?B?Ri9kTGE2UEttSG10ejFnVWkvOW1DSEJCcVY4cjBLcndqS0RWcThLd1l1dFZ0?=
 =?utf-8?B?UG1rWnNKVDhZdldlbXNYYnZnNXhBM0xMUHNKaFc5TVY1U2FLbURDTWZYL3Q3?=
 =?utf-8?B?K0lwRU5zOXpmZm5KWXVOcjhZc0lxYUMrMHUxSWd2cFhtQlZtai9EM1NJUjIw?=
 =?utf-8?B?YytHMzRMb2QyUSsrQTVTRTZFQS9RZTR0V2RSUXZibHF6cG5OS0RsQkM3TWVM?=
 =?utf-8?B?QVVDbUg3UXhlNjFnN091bEpXdTlhaEMxQXNwdS9od0ZDTWxKb1dsOEhVb1Bq?=
 =?utf-8?B?Nk1DdHlsbCs5enVuc05qU0xnb2ZlWmZ0WlhRNkZFeWMzNGZQbjNWVlUzMWVL?=
 =?utf-8?B?VVFIVmc2MGxqckRremt5K2lXcFVKUHBWTWdnREJDUDhWd3kvZHRCeFU0dFRl?=
 =?utf-8?B?N0tCbjg1UG5mb3pOZU9nUm1yaklKeDJlTTZ2ejFEdzFUYUI3MVUxQk1RQS9E?=
 =?utf-8?B?MFBXVXJxR2QrYWg0Z0Z5M0tvRDJhQUpWSWw5MCttTFJ3bGE2NTVib3dHaGJr?=
 =?utf-8?B?dURaSjEremdRbHFYcHppSlU0bGN2Ky85a2Z4QXNhYnB1N1VYRmdpaXQ0cW9q?=
 =?utf-8?B?dHdVajAwMDIwOVNQUlNEQ2ZuS2V5QmJnZ3BUZlIxNGQwWFVvb245dk1maE1v?=
 =?utf-8?B?M3FBQWxmRjRQN2pOMGhXZDgvNGdKYk8xbUFqdmo4WkFZT1U2OXdVdEwyeFdj?=
 =?utf-8?B?MHhkSGhZU3FYRkhnWkNHMi9UY1VhV0c0TGxPY3ZNY0FRenBPdVJDOXZvV2s1?=
 =?utf-8?B?ejQ0VDdncFlYdm1iQXRiRWlSUUg3U080ZVdQRTBnZjlPaFgvMEUzSWhnQi9Z?=
 =?utf-8?B?MzFGcENOM2VPMW04YnBPSDVTNVlRWVp2WitpUGdkeS9takVDUFF6eWt6U2dW?=
 =?utf-8?B?T3owVVJzMFNiODR2OFJNMXRWVUEveVZ2aEJzczAvSHkrenBMN3NhVExjeE5T?=
 =?utf-8?B?UHN6NlFHdWx5QmQvN3E2N3hQKzV6clhoTDM0b0RwbWVqWXhJbkNzbzRrSE4z?=
 =?utf-8?B?NEtObnRpWWdwaXhOS3NhTDhLbElmRW9xdDVNc0VFY0JyN3U1dWJIeG91QUhH?=
 =?utf-8?B?cFcxTXFzT1BjdTd3dEh0VXZ6ZWUvdWgwKzRWNjdwYTNWenFpbm1qeVlQUHZl?=
 =?utf-8?B?UkVvck1xbUZ1SVZROGxKTG5SbzRJR0Nwb2pVcmU3RGtMazVzeEhzdXowRWtv?=
 =?utf-8?B?TzZUUzNQQVVEODNKR1FIWmtJUE03anB5R2hTUHBIakpCTlQwREVTRlVPeldH?=
 =?utf-8?B?Qkh1RVRBeFI1REg4L1Awc3g1MDNpZHlUd0dXQzRZaW5EZmdyNGh3MzNMVUtk?=
 =?utf-8?B?cW8wT2FPSm1ybHdmU0RKZDJnTU9zOStqSW1DRHF4RCs1VmlYbm9KMUFhaU1J?=
 =?utf-8?B?Y2hzeStxbkJxcEMyamQzcERLSWJNcG9YcUU5U2h2R1VOeVRaSHZ6cWtPc01i?=
 =?utf-8?B?cVErOG9yOHB1S2dKQU50bWw1VlRvNHFIai81VUtkTVM5eDdTVXphYi9hMVVX?=
 =?utf-8?B?anFnOUpnVW5NMnZRTDd2NElPWVYvRDl5MllRQXh1WVFBcTNUMDFTMXZwSDUw?=
 =?utf-8?B?b3VYd0o0UXBBS0lpaGYxNVg4R1BGRzdLYjk4VkhwNTRPNXBlM1d0dEliZjJx?=
 =?utf-8?B?elczTUxxVDJmS3Q1bHE2MU1VRURrRmp3SDdSMFZXYTlJMFhJZXNlWmpiOXl3?=
 =?utf-8?B?aCtkM3Uvb3Z5ZnFYNURRZytsSE5xVkNqbjdWekkrK1ZlbWY2MGdqdG5OaEZ5?=
 =?utf-8?B?VkJXM0VZYnREWnJYNWlKWVpqYklSNEhRWkJVMHJabEV3N1pmbUswbmR4VlJy?=
 =?utf-8?B?T3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f384614c-5f45-4e11-2b34-08dbb8f91479
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 10:13:33.6605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6pzcPWvjMiHSgpq9zBBSbSw0ZsP7HwOxRoRgzsM1G0Wh8MAnBhmjGpGjqCcxJfVlPsM53o6T0PcsgieiOukSeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8210
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Sep 2023 10:13:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13143

On 19.09.23 12:07, Srinuvasan Arjunan wrote:
> From: Srinuvasan A <srinuvasan.a@siemens.com>
> 
> We need 14 since we switched to 'commit'.
> 
> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> ---
>  doc/README.secureboot.md             | 2 +-
>  kas/board/bbb.yml                    | 2 +-
>  kas/board/hihope-rzg2m.yml           | 2 +-
>  kas/board/iwg20m.yml                 | 2 +-
>  kas/board/qemu-amd64.yml             | 2 +-
>  kas/board/qemu-arm.yml               | 2 +-
>  kas/board/qemu-arm64.yml             | 2 +-
>  kas/board/qemu-riscv64.yml           | 2 +-
>  kas/board/simatic-ipc227e.yml        | 2 +-
>  kas/opt/4.19.yml                     | 2 +-
>  kas/opt/4.4.yml                      | 2 +-
>  kas/opt/5.10.yml                     | 2 +-
>  kas/opt/6.1.yml                      | 2 +-
>  kas/opt/bookworm.yml                 | 2 +-
>  kas/opt/bullseye.yml                 | 2 +-
>  kas/opt/buster.yml                   | 2 +-
>  kas/opt/ebg-secure-boot-snakeoil.yml | 2 +-
>  kas/opt/ebg-swu.yml                  | 2 +-
>  kas/opt/encrypt-partitions.yml       | 2 +-
>  kas/opt/kernel-panic.yml             | 2 +-
>  kas/opt/kernelci.yml                 | 2 +-
>  kas/opt/reproducible.yml             | 2 +-
>  kas/opt/rt.yml                       | 2 +-
>  kas/opt/security.yml                 | 2 +-
>  kas/opt/sid-ports.yml                | 2 +-
>  kas/opt/swupdate.yml                 | 2 +-
>  kas/opt/targz-img.yml                | 2 +-
>  kas/opt/test.yml                     | 2 +-
>  kas/opt/wic-targz-img.yml            | 2 +-
>  29 files changed, 29 insertions(+), 29 deletions(-)
> 
> diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
> index 6546095..2b73d10 100644
> --- a/doc/README.secureboot.md
> +++ b/doc/README.secureboot.md
> @@ -151,7 +151,7 @@ For user-generated keys, create a new option file in the repository. This option
>  
>  ```yaml
>  header:
> -  version: 12
> +  version: 14
>    includes:
>     - kas/opt/ebg-swu.yml
>  
> diff --git a/kas/board/bbb.yml b/kas/board/bbb.yml
> index c99d9bd..f2e701c 100644
> --- a/kas/board/bbb.yml
> +++ b/kas/board/bbb.yml
> @@ -10,6 +10,6 @@
>  #
>  
>  header:
> -  version: 12
> +  version: 14
>  
>  machine: bbb
> diff --git a/kas/board/hihope-rzg2m.yml b/kas/board/hihope-rzg2m.yml
> index 7b80de7..8d0136b 100644
> --- a/kas/board/hihope-rzg2m.yml
> +++ b/kas/board/hihope-rzg2m.yml
> @@ -10,6 +10,6 @@
>  #
>  
>  header:
> -  version: 12
> +  version: 14
>  
>  machine: hihope-rzg2m
> diff --git a/kas/board/iwg20m.yml b/kas/board/iwg20m.yml
> index c873b98..9c9ef4b 100644
> --- a/kas/board/iwg20m.yml
> +++ b/kas/board/iwg20m.yml
> @@ -10,6 +10,6 @@
>  #
>  
>  header:
> -  version: 12
> +  version: 14
>  
>  machine: iwg20m
> diff --git a/kas/board/qemu-amd64.yml b/kas/board/qemu-amd64.yml
> index f9f57be..c27ed8e 100644
> --- a/kas/board/qemu-amd64.yml
> +++ b/kas/board/qemu-amd64.yml
> @@ -10,6 +10,6 @@
>  #
>  
>  header:
> -  version: 12
> +  version: 14
>  
>  machine: qemu-amd64
> diff --git a/kas/board/qemu-arm.yml b/kas/board/qemu-arm.yml
> index fe03028..969fd5a 100644
> --- a/kas/board/qemu-arm.yml
> +++ b/kas/board/qemu-arm.yml
> @@ -11,6 +11,6 @@
>  #
>  
>  header:
> -  version: 12
> +  version: 14
>  
>  machine: qemu-arm
> diff --git a/kas/board/qemu-arm64.yml b/kas/board/qemu-arm64.yml
> index 55690b3..1a1eb0d 100644
> --- a/kas/board/qemu-arm64.yml
> +++ b/kas/board/qemu-arm64.yml
> @@ -11,6 +11,6 @@
>  #
>  
>  header:
> -  version: 12
> +  version: 14
>  
>  machine: qemu-arm64
> diff --git a/kas/board/qemu-riscv64.yml b/kas/board/qemu-riscv64.yml
> index 0de158a..e8272b0 100644
> --- a/kas/board/qemu-riscv64.yml
> +++ b/kas/board/qemu-riscv64.yml
> @@ -7,6 +7,6 @@
>  #
>  
>  header:
> -  version: 12
> +  version: 14
>  
>  machine: qemu-riscv64
> diff --git a/kas/board/simatic-ipc227e.yml b/kas/board/simatic-ipc227e.yml
> index 82b0ff7..cf27058 100644
> --- a/kas/board/simatic-ipc227e.yml
> +++ b/kas/board/simatic-ipc227e.yml
> @@ -10,6 +10,6 @@
>  #
>  
>  header:
> -  version: 12
> +  version: 14
>  
>  machine: simatic-ipc227e
> diff --git a/kas/opt/4.19.yml b/kas/opt/4.19.yml
> index 5e79223..bad4293 100644
> --- a/kas/opt/4.19.yml
> +++ b/kas/opt/4.19.yml
> @@ -10,7 +10,7 @@
>  #
>  
>  header:
> -  version: 12
> +  version: 14
>  
>  local_conf_header:
>    kernel-version: |
> diff --git a/kas/opt/4.4.yml b/kas/opt/4.4.yml
> index 970351a..c0c5c05 100644
> --- a/kas/opt/4.4.yml
> +++ b/kas/opt/4.4.yml
> @@ -10,7 +10,7 @@
>  #
>  
>  header:
> -  version: 12
> +  version: 14
>  
>  local_conf_header:
>    kernel-version: |
> diff --git a/kas/opt/5.10.yml b/kas/opt/5.10.yml
> index 2258575..f3a6d86 100644
> --- a/kas/opt/5.10.yml
> +++ b/kas/opt/5.10.yml
> @@ -10,7 +10,7 @@
>  #
>  
>  header:
> -  version: 12
> +  version: 14
>  
>  local_conf_header:
>    kernel-version: |
> diff --git a/kas/opt/6.1.yml b/kas/opt/6.1.yml
> index ac12adf..7ac2735 100644
> --- a/kas/opt/6.1.yml
> +++ b/kas/opt/6.1.yml
> @@ -10,7 +10,7 @@
>  #
>  
>  header:
> -  version: 12
> +  version: 14
>  
>  local_conf_header:
>    kernel-version: |
> diff --git a/kas/opt/bookworm.yml b/kas/opt/bookworm.yml
> index 8b4431b..dc0e0a2 100644
> --- a/kas/opt/bookworm.yml
> +++ b/kas/opt/bookworm.yml
> @@ -10,6 +10,6 @@
>  #
>  
>  header:
> -  version: 12
> +  version: 14
>  
>  distro: cip-core-bookworm
> diff --git a/kas/opt/bullseye.yml b/kas/opt/bullseye.yml
> index b08e0e4..0614c92 100644
> --- a/kas/opt/bullseye.yml
> +++ b/kas/opt/bullseye.yml
> @@ -10,6 +10,6 @@
>  #
>  
>  header:
> -  version: 12
> +  version: 14
>  
>  distro: cip-core-bullseye
> diff --git a/kas/opt/buster.yml b/kas/opt/buster.yml
> index 9b0b530..3f19310 100644
> --- a/kas/opt/buster.yml
> +++ b/kas/opt/buster.yml
> @@ -10,6 +10,6 @@
>  #
>  
>  header:
> -  version: 12
> +  version: 14
>  
>  distro: cip-core-buster
> diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
> index f787c82..e083304 100644
> --- a/kas/opt/ebg-secure-boot-snakeoil.yml
> +++ b/kas/opt/ebg-secure-boot-snakeoil.yml
> @@ -10,7 +10,7 @@
>  #
>  
>  header:
> -  version: 12
> +  version: 14
>    includes:
>      - kas/opt/ebg-swu.yml
>  
> diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
> index c90142b..61a8eee 100644
> --- a/kas/opt/ebg-swu.yml
> +++ b/kas/opt/ebg-swu.yml
> @@ -10,7 +10,7 @@
>  #
>  
>  header:
> -  version: 12
> +  version: 14
>    includes:
>     - kas/opt/swupdate.yml
>  
> diff --git a/kas/opt/encrypt-partitions.yml b/kas/opt/encrypt-partitions.yml
> index 2fe38f8..3de76ab 100644
> --- a/kas/opt/encrypt-partitions.yml
> +++ b/kas/opt/encrypt-partitions.yml
> @@ -10,7 +10,7 @@
>  #
>  
>  header:
> -  version: 12
> +  version: 14
>  
>  local_conf_header:
>    initramfs-option-encrypt-partitions: |
> diff --git a/kas/opt/kernel-panic.yml b/kas/opt/kernel-panic.yml
> index fe17982..f966779 100644
> --- a/kas/opt/kernel-panic.yml
> +++ b/kas/opt/kernel-panic.yml
> @@ -11,7 +11,7 @@
>  # This kas file adds systemd service file to cause kernel panic during system boot.
>  
>  header:
> -  version: 12
> +  version: 14
>  
>  local_conf_header:
>    kernel-panic: |
> diff --git a/kas/opt/kernelci.yml b/kas/opt/kernelci.yml
> index b5fadcb..ec90792 100644
> --- a/kas/opt/kernelci.yml
> +++ b/kas/opt/kernelci.yml
> @@ -11,6 +11,6 @@
>  # SPDX-License-Identifier: MIT
>  #
>  header:
> -  version: 12
> +  version: 14
>  
>  target: cip-core-image-kernelci
> diff --git a/kas/opt/reproducible.yml b/kas/opt/reproducible.yml
> index 9b56b28..5d6a896 100644
> --- a/kas/opt/reproducible.yml
> +++ b/kas/opt/reproducible.yml
> @@ -9,7 +9,7 @@
>  # SPDX-License-Identifier: MIT
>  #
>  header:
> -  version: 12
> +  version: 14
>  
>  local_conf_header:
>    reproducible-builds: |
> diff --git a/kas/opt/rt.yml b/kas/opt/rt.yml
> index 4b2519f..ab43a84 100644
> --- a/kas/opt/rt.yml
> +++ b/kas/opt/rt.yml
> @@ -10,7 +10,7 @@
>  #
>  
>  header:
> -  version: 12
> +  version: 14
>  
>  local_conf_header:
>    preempt-rt: |
> diff --git a/kas/opt/security.yml b/kas/opt/security.yml
> index 67bf4ff..d87235a 100644
> --- a/kas/opt/security.yml
> +++ b/kas/opt/security.yml
> @@ -9,7 +9,7 @@
>  # SPDX-License-Identifier: MIT
>  #
>  header:
> -  version: 12
> +  version: 14
>    includes:
>     - kas/opt/encrypt-partitions.yml
>     - kas/opt/ebg-secure-boot-snakeoil.yml
> diff --git a/kas/opt/sid-ports.yml b/kas/opt/sid-ports.yml
> index 2e89f2b..b11a1c2 100644
> --- a/kas/opt/sid-ports.yml
> +++ b/kas/opt/sid-ports.yml
> @@ -10,6 +10,6 @@
>  #
>  
>  header:
> -  version: 12
> +  version: 14
>  
>  distro: cip-core-sid-ports
> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
> index 0e30e89..ef61e4e 100644
> --- a/kas/opt/swupdate.yml
> +++ b/kas/opt/swupdate.yml
> @@ -12,7 +12,7 @@
>  # from the first wic partition
>  
>  header:
> -  version: 12
> +  version: 14
>  
>  local_conf_header:
>    image-option-swupdate: |
> diff --git a/kas/opt/targz-img.yml b/kas/opt/targz-img.yml
> index 8283ef8..fd8303e 100644
> --- a/kas/opt/targz-img.yml
> +++ b/kas/opt/targz-img.yml
> @@ -10,7 +10,7 @@
>  #
>  
>  header:
> -  version: 12
> +  version: 14
>  
>  local_conf_header:
>    image-type: |
> diff --git a/kas/opt/test.yml b/kas/opt/test.yml
> index 7dd5536..4a60ad4 100644
> --- a/kas/opt/test.yml
> +++ b/kas/opt/test.yml
> @@ -9,7 +9,7 @@
>  #
>  
>  header:
> -  version: 12
> +  version: 14
>  
>  local_conf_header:
>    testing: |
> diff --git a/kas/opt/wic-targz-img.yml b/kas/opt/wic-targz-img.yml
> index 3d908de..74053f5 100644
> --- a/kas/opt/wic-targz-img.yml
> +++ b/kas/opt/wic-targz-img.yml
> @@ -10,7 +10,7 @@
>  #
>  
>  header:
> -  version: 12
> +  version: 14
>  
>  # lava uses nfs to deploy the image. For this we need a tarball instead of
>  # full image

More a consistency topic than a hard requirement: kas does not check if
included config files also have the right or a consistent version.

Nevertheless, thanks for the cleanup, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


