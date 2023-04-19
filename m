Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB34C6FD18
	for <webhook@archiver.kernel.org>; Wed, 19 Apr 2023 13:18:00 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.84])
 by mx.groups.io with SMTP id smtpd.web10.37360.1681910274166163871
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Apr 2023 06:17:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=CugbgXwk;
 spf=pass (domain: siemens.com, ip: 40.107.6.84, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5FGs7cOnWVWNsXA2hbnUuYac+FGOmTGuvff/bEsEjEbslMunUGRZtmgyQK6F8b/A5NsKlvHJaAmhr6IiyFBPbY56bttrYuXlJ8FHye44jDFUKfdaJgLXdvkFc0xodPf+72eAqnlBDe2wZnAtfr5hJIGtlH3yIXLNL/8OPGoHVfyvVLlo52khhvOV9R6EHpkVKpU/D3n+ZZS+c0QBi7QhHjinVULrw181WKK9xQ+R+tdIPL5xALhrh22grow5LJGvuY7b3e0878Xnqb8bwn1yqEsJMI3hX94Ow6YZIqwDQv8dNgNmOwnAwbEVpEdEOKu9e2fjp/DTNHomaDPpkStjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2iFBOqda7uUwdwF8zwHs50vS+mxEKX4pOJyfKyTVzI=;
 b=UGzoHlHKnQ4lfJNRp1ac16CdlLgVww3HkgZAtu9NF36tQMi5KAS6oVQb4buWhSImo6Eo7PuOqlUi/QlW3gc/FKGzDOLpe70RIKXMzLfuT9LThsIJ8xOb8mM7MkLqXNsg/cJvw/Bplfh8EsUV9K+KathHx6LJB6jgvPn84qICuFqUNgn8AGIaSKhVi74iBRCPj5zJhKF1lwAJjO5I5bTkUx5CSWyYPkikUksIAVAOj7LvITsCFHHM9ZuLa22y8w2B2fGh44J31wdhu9xxEeH2zqngtL3FCjxIGgZ0y+sFYfE9MSmo8AiQVYlWuakN0urPBnoO4dsjt08Ocp6Lksd6iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2iFBOqda7uUwdwF8zwHs50vS+mxEKX4pOJyfKyTVzI=;
 b=CugbgXwkBMR4xz20lLf/d32U1HLXmfxJgdhe+WOoVrDDQho3rYFWuwDcU6CvCtKE+qGXgsHLFcESF/QYb7rDOIb2PqWClpDaB/vJI9hOHJRx84+XtQBq4a6ju6OG301m6e0rQ2E+UrdvdW/2zO7baPdfS25tRwzNf9AuKmEHgWt9zVE4xtOqXSn6M37z8NuSP1o5Y1eUzKLlEtN6V0te8FmzhddWjclu1dgF/8ZB3iKXyhRQFa0avyDT/ldaw/bvE0bJ/qlwZCFXRZEPbrFLzejmp/y3g8a0VfUnfxdxKLlZTLP6tpba3oUS+iEPI0uYsVy67Wybwz7WtATO82byaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7183.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:61d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Wed, 19 Apr
 2023 13:17:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%5]) with mapi id 15.20.6319.021; Wed, 19 Apr 2023
 13:17:51 +0000
Message-ID: <a8d632e2-6153-9846-3890-a10b37058e49@siemens.com>
Date: Wed, 19 Apr 2023 15:17:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [cip-dev] [isar-cip-core][PATCH] ebg-secure-boot-snakeoil: drop
 space in remove override
Content-Language: en-US
To: "Arjunan, Srinu (DI SW CAS ES LI PBU RSOL)" <srinuvasan.a@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <1749D0C69BA8621B.3736@lists.cip-project.org>
 <PUZPR06MB5747937D583ADEE275F79B6888BA9@PUZPR06MB5747.apcprd06.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <PUZPR06MB5747937D583ADEE275F79B6888BA9@PUZPR06MB5747.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7183:EE_
X-MS-Office365-Filtering-Correlation-Id: 45170951-c4f5-4a96-944c-08db40d87a5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7NyLNgyYjihV9x0qbtVb3jSA6VjrPRb+eAluYADzVOfpnVZj31dL6NhCUFujp8a963+dVz7pTz181QLFimVZddAU4dBG3m88Naj8SDBoho6EgVX28Gr1Wjkl7ypB9InX2tMeTNcMNqDxS40MQ7Nye+/kvYT1AlfX9sGIDSZOUXJwm2gfwxrC84hin5+3HsftASEjXNkxozCIa5jB6/2t9K9LAY8eCdQOPPzZLEEb4VJB5IQEfUDvNotbkK597dvbyLDaDdo/vnv0BnEaeD15XLpHIoeH0rbkq9y9lE25JmOabrAW/otawFAVGPf7xGOjbSMLKAFrD4A6N5O8ApdsZ8iz2xVQ1QqtbULCM/Wko7sSm/uDbQfouw/yKnvz7eey1dD/shvf6VUcVI9OT/toP1sTN2iOUb+N/Jr3Sfb77nktrq15QPo8RyisJe3qnq/wpFWOZ/t4/LbMwe6iZo+fb1Kj1nJ8i9ihQcdfsy/hLrAOetbfDPWksSBA+HccbggHMiPDif3PZK3KATrjbDuEw/GtpZal+HhFJQ3T00i19to5nAQlvn+Ub5deQ1JhgPEb6spFPQJiy2iG6Kptby5m61htp9y9ACMSQ0ZRewT2011fDfrv9SD/IF6/jc0dM4Wsh4znI6XO5kxVM4a5yBrsIg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199021)(83380400001)(6512007)(26005)(6506007)(53546011)(41300700001)(82960400001)(6486002)(2616005)(31686004)(6666004)(186003)(478600001)(44832011)(316002)(66946007)(66476007)(66556008)(31696002)(5660300002)(110136005)(36756003)(86362001)(2906002)(8936002)(8676002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TmswREV1Yng5MkRJVlBycDR4UkpEREhOWWhkT1ZVYWsxRnAxak13YVQwYXEw?=
 =?utf-8?B?Y293eGUzdmorbFhNZGFPdE8yWXBtcGpqZW1wSHZkdEFHanZNU1VXWStKSHlR?=
 =?utf-8?B?bmFSRkg2R09MbGZDOVBDaGc0SEMvaFN0U0VVcURaYTRxMFNnSC9mUEFqYy8w?=
 =?utf-8?B?TWpPbkJKRnpXVksyYklRdWdDMTR6bHVJdW5VTmYrQnFOVXdPZG90MHlTcEd1?=
 =?utf-8?B?VGN5L28zWnhSenYxd1BMV05OemdpMDRadDJkRnN0c1JCSTJrenVQNHJzMXpl?=
 =?utf-8?B?enBWdlcvUjBJNU5kUU16UytBdW5zNVFzNGgyNjFvaFhPSGdZSlJnSjFxT2k4?=
 =?utf-8?B?b29mRjVuVEE4QytTOEFtK3N1dGwyc0d6UE4wVlBaR1M2QzVhTU9PTHh6TTJp?=
 =?utf-8?B?dFR3REdLck44WnhrR29Pdjl1dXU0bnBpM2NsWkJ0VTBYMzBlUXM0MVdWaThC?=
 =?utf-8?B?Q1Y1T1ZpT3N6RVN3cThJTlp2U0FqVEp0RWlMSWp1ZVFvMWpHOFVhS0xnYVVY?=
 =?utf-8?B?QmpSSzV6YzliaFprZ1VoNUc0UVNnSS9Ea0RyTWFhZGpvMmEvalN0NktkbHhs?=
 =?utf-8?B?ODNoV0kzOWowK09sL011TG0rRExocTA1dHFNNmZEQXF6b2VEcUxTZ0lFUitL?=
 =?utf-8?B?cmIraFNUZ2tKUFNwaXdBRllyYlNwMlgxeEtLcjNjWkRkd1pxRFU0ZlViTTNR?=
 =?utf-8?B?MGw2eUtLOFBndUtXWUdXRUVPRy9QWkJYY1kxOW02WklrSnBUUFdodVZyWGJx?=
 =?utf-8?B?QzJWNFF0R2kxbnJIMk1vWnVad1ZyUUJ6QS9TQStxMkhTRCsvNXhaU3UwdEw3?=
 =?utf-8?B?YkpWd3JGK1hDeFVSY1NlRXVDR2tPWUhKTzdCY0hXSDhsSjAwRko2ZmlRaGRS?=
 =?utf-8?B?MFdUQlNHQnlGMW9zcGRxZTVxMkxud29Xa2JhanZaMmVqZ3FjWHRxVUY1Mmd2?=
 =?utf-8?B?L0JDYXRobVJQOTFsbHdKN0NuWFgxUmEybmNidHl1L2c1K1hKVlB6a0R3WGxW?=
 =?utf-8?B?NGtpL3Q4UmE3UGlkREoxTlpUeEs3MzFMRzNwS0w5czRqR3V2MC9jWlk3N2JP?=
 =?utf-8?B?SXl1enlzU1FLd2UzRHBVcGZNMDBnTjBsU2lDTFpOSEZCZ2IzdWdUeU1zY1BC?=
 =?utf-8?B?aE1DcXE0dnl6QnZkVWRYTG1xcDE3T3NCMHJtQThmdDNiSFYvVDFWdEVUWXhH?=
 =?utf-8?B?RmJZUzNDSFludlp1M1VHNHNGaDRnK1poWTBnejlHRUxjMnhLYTIyQUVXa0lN?=
 =?utf-8?B?ZXJtRFhLemlVa2gvOHhRWGQ0SExrWmFsTWg3QkFBeEJOSVRhOXY3b1BIOWVG?=
 =?utf-8?B?Sll3N3k5a3JiaERPcnZvVVltV215ZWpKVEY4RDR2ZERUK1E3aU1RNXg2dWVu?=
 =?utf-8?B?NUFEUndJMWNzRTVvTjdqNXRaNGE2VTJHN0VNOE1KRzhCMGgrajE0WnRHem9F?=
 =?utf-8?B?TG5OWWdCMWZUcVJyR0FwNHlQZ1FjWlVOSHBrcFdXNnFGY0RVbmxTbFQxZ2kx?=
 =?utf-8?B?Z1R3TmxxRzZDZU5yajdLNzFNTitPKzdEWG90ajNlZ2JBZzVnbmlOdWtKemRP?=
 =?utf-8?B?bDh1Zkk5ZFhFelNjSWdiZ29oMnRGa2dudlpaZlRsbUVCRlkyT2RFTG90b2cw?=
 =?utf-8?B?c0xpalBDU2duN0R5Wkc2bnpFVGVFSVlTalN5NG1pY0IxaVplVk9KaXU0K1Ny?=
 =?utf-8?B?aVRZKzM5TElqMW54NXVva2lCSk9HbjAwQ0JNd0VZeHFNVTNRdG9JMXhSa3dN?=
 =?utf-8?B?cEZnZjhzNUk3RE5XeENpbzNoWGhYc2o3Ulc5UWlLMkRGUnRJWlQyQ3pXYTdx?=
 =?utf-8?B?cjl6S2hXdFlsWTZ0UzBzNTdOOWFyUGU5L0g3ZG9QbGNKZXlsNjhQUXRoVURU?=
 =?utf-8?B?ZGZ1QVNSOGhTNnExdVhpMDVYdmRZazgyaHRDYmRTTGIyeTdGcXo1THdIR0h3?=
 =?utf-8?B?Rm1xQW1yMzdQSDRtSFM0UHFWOVZVVGl1ZnhuKzBYUDM2b0tIZUxFVVdXZWRa?=
 =?utf-8?B?NVk2VjZEMW53OG01L01FQ1o2bm0vbzhUWHZTNVdkblNDU01vaUZYRHVhaEkr?=
 =?utf-8?B?K29iZU5oblNweWFvNndSNTlUbXN5ckxXaVU1Y1BPd3htcGJKa3BEM2ErdHR2?=
 =?utf-8?Q?oMzNT4QQFvtSpXZRlsr1qKj37?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45170951-c4f5-4a96-944c-08db40d87a5b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 13:17:51.5179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iPupG8O3AXOysCrVP+Qf4U5rth4JAFu964wull00Qj59rLwjKSv+JwWzXuV84I2UZvGJZa/7awg4y9dPAOtWSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7183
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Apr 2023 13:18:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11233

On 10.03.23 10:26, Arjunan, Srinu (DI SW CAS ES LI PBU RSOL) wrote:
> Can you please merge this change?
> 

Looks like a reported this as merged but somehow lost that state. It was
still applying and is now truly in next.

Thanks,
Jan

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Behalf Of Srinuvasan A
> Sent: 06 March 2023 16:54
> To: cip-dev@lists.cip-project.org
> Cc: Kiszka, Jan (T CED) <jan.kiszka@siemens.com>; Arjunan, Srinu (DI SW CAS ES LI PBU RSOL) <srinuvasan.a@siemens.com>
> Subject: [cip-dev] [isar-cip-core][PATCH] ebg-secure-boot-snakeoil: drop space in remove override
> 
> From: Srinuvasan A <srinuvasan.a@siemens.com>
> 
> remove does not need leading spaces in front of the package, hence drop this one.
> 
> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> ---
>  doc/README.secureboot.md             | 2 +-
>  kas/opt/ebg-secure-boot-snakeoil.yml | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md index 54d67c7..bc238fb 100644
> --- a/doc/README.secureboot.md
> +++ b/doc/README.secureboot.md
> @@ -154,7 +154,7 @@ local_conf_header:
>      WKS_FILE = "${MACHINE}-efibootguard-secureboot.wks.in"
>      INITRAMFS_INSTALL:append = " initramfs-verity-hook"
>      # abrootfs cannot be installed together with verity
> -    INITRAMFS_INSTALL:remove = " initramfs-abrootfs-hook"
> +    INITRAMFS_INSTALL:remove = "initramfs-abrootfs-hook"
>  
>  local_conf_header:
>    secure-boot: |
> diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
> index 3d0e3c9..f787c82 100644
> --- a/kas/opt/ebg-secure-boot-snakeoil.yml
> +++ b/kas/opt/ebg-secure-boot-snakeoil.yml
> @@ -22,7 +22,7 @@ local_conf_header:
>      WKS_FILE = "${MACHINE}-efibootguard-secureboot.wks.in"
>      INITRAMFS_INSTALL:append = " initramfs-verity-hook"
>      # abrootfs cannot be installed together with verity
> -    INITRAMFS_INSTALL:remove = " initramfs-abrootfs-hook"
> +    INITRAMFS_INSTALL:remove = "initramfs-abrootfs-hook"
>  
>    secure-boot: |
>      IMAGER_BUILD_DEPS += "ebg-secure-boot-signer"
> --
> 2.34.1
> 

-- 
Siemens AG, Technology
Competence Center Embedded Linux


