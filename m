Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD6DC77B6E
	for <webhook@archiver.kernel.org>; Thu, 13 Apr 2023 19:17:10 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.50])
 by mx.groups.io with SMTP id smtpd.web11.343.1681413426211672355
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Apr 2023 12:17:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=fQjQvp+1;
 spf=pass (domain: siemens.com, ip: 40.107.8.50, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eABJZ6V6q0uNH+2baWfrw4zNV6WcbemKsfsz3L18jbCHqPgiopE1iEJxaF3Z9VNqCv/qM4PiWFWfiUfc3SIU+ULAjwUw31ym41lekNbbGSac0xcNaGjSvqrn7FdQQCqLtQERXq04xowXhO2+lPkknCVYntB4R7PAMZYJZ8sVZu2hCv12599M8a6fC1rDdh5VD+KLMDU9oIx+H7gO0p894wad1JDu3dz/BVyq9c7BlSBALQ8XOiOOKNmX66u4AAusuA7tzjU1IGmf6nf2ipgYvtxlDTu2qebWiYTr1ekziHqLXx26NfP11Ehs3y7amtqhV+T2Vdb/99Y7v6p2Cucv8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOUoMxigssT/3UwgJmjU9Wbxol3HzQuP+WEVokKVEiE=;
 b=N9lFmaV0mNjfQ8Iuei4mwul9uOLkMYI8Yh6I+Shw3zLg5zn7nQVQxlP8gMtFokrRCxVFQlL1h9UHvF33QZVGu3wH+Jlc+j6g24CNdmzkl7NAXq/LSMVWsV0TCCOoCgbliH/XPMSna24gqLFf0nk9f/hRcQq4Hp4nm9Aj1SW96Ipsf0QU7ePYpzgfF986ovHCSAiyRd6oUrx61YU9HMWJM8r/MXc9hUI18RUSxvDedC/EzGLJPhpSpEBM85j7T9rvzWW7QLiujedOZ8I88ChEdIFfFkHSMudLS+ufJm9R3FcGyYdV5QvIbFje9qfOZHnEHPtsLjQmmMhlphTO2sqBKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOUoMxigssT/3UwgJmjU9Wbxol3HzQuP+WEVokKVEiE=;
 b=fQjQvp+11OM0pX0dnNOt/Dn/SdZuBqdP555OHzDTWa+6WPBlbYXLygwlBMAPCXrzMAAv2ooZ6c8QuUB9iXL33Wnfgagq2pyyRoEjXrJVtDaTbkKZkjmPoM8z0kOlQo+IDD4ddfnb5xmut7aOMLzXZVxw5tGoYwZKepWWVV00myuk6IDWfd21+9kt/l1zvqz+rCIF3R7NZi8DlRfy+Id5C7eCf4qxeVldV/TSfdusSy2xmmm4dVv4XYez9gIMGbf/lmkGhRU3arkWVKpkDauiU6Y7maqXaVv6YXtEPV1uooax5QWzE5Cd1qIsZHmVCkKAGuQGi5Sy7TpvokJNKcb9kQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7523.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 19:17:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%5]) with mapi id 15.20.6319.004; Thu, 13 Apr 2023
 19:17:02 +0000
Message-ID: <03284a5d-6612-eef0-af52-f6ab03045378@siemens.com>
Date: Thu, 13 Apr 2023 21:16:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [isar-cip-core][PATCH 1/1] add missing dependency to template
 subst in swu
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: gokhan.cetin@siemens.com
References: <20230412064118.431415-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230412064118.431415-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0190.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::27) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7523:EE_
X-MS-Office365-Filtering-Correlation-Id: e684db6c-44df-47e9-e9b4-08db3c53a941
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	WBDN4rBYGSbLtRWwpRwEgGwGe9vxx8tnj6s6X/BgEA2hNGwgR7cyHdGkK/QgCdkrmsdG7ZBC61R7CHo24R/ueK7M1QbCiMW712I7+cfHljKw6wSoXRFAp7fpneuxAHRhtd0YFFZUeaJHBMDyows5tO8FN6FOv7yoVmvL0FBxB1q0sskfyIguAk4pjwIp5XvZrQbwEMoFoQUO+aEXcIJ3v5Mr8LzNxtGlZSaUoDX847QF4Z8WX5AQGNM80TtJK+sV6l4vZUINJX2x1qhDI8/TfzRh78iFQ/x9FG4s80sZ8Ki5NXYcRgPfNGBZeN44am156wyaMYrqy2i6M/hQyM8ZvMjJLCXmeo73do2KfZsdkEgxluf3aoTFAnEN/2a7t56WacEKugcSEuLQoUmWo3px4GPOMX9WvWxcL05qatKJQcA+kZ6ouSHDIqF490VHeW+Nw2N9gzm0/cDgEH/w9Dap3w0imUNjlndfridfIda1QhPkRYQCGdaaYh2PCfpeF7iLtIv/Wtr/J9zyW7nEHjns+7FMue/Ei0kvirtWTfw2ElqcTxIwEy978BfBNf9IbjCV3JzOIPPWc5I/TGIAERGsGExRKA+2AEncHYntYRJy+10fRPAPmcpvJtXELfXwNEK6Px3KEtprriaDNNkgtGTr+37lyy2HiflTF+LhTy/6xvHUVCtkbu0oafaDnYyUgF/5
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199021)(86362001)(36756003)(83380400001)(31696002)(316002)(41300700001)(6486002)(66476007)(4326008)(66946007)(8676002)(478600001)(66556008)(6666004)(8936002)(2906002)(44832011)(5660300002)(82960400001)(186003)(38100700002)(53546011)(107886003)(6506007)(26005)(2616005)(6512007)(31686004)(403724002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?M2M1UFluQU5ROFhoZTB5N2l1Q3ZNcEJYUERTdFJZaGlMK3BMcThwRDc0UU9Y?=
 =?utf-8?B?RUpkL0h5MXlBWjFOTXJvRFlHM1hOOFJuaEhjd2hOVTYxdmtiTWd5dmRmVmNY?=
 =?utf-8?B?NEJPblEvRVRSRFZaOVpISWNSNmowdVV6ODBoQVlNR0FITUJOeGEybityUGln?=
 =?utf-8?B?djBiYW1qY2UxaGozb2QzSWIwbllIa1lvb0o1R2ZieHlpY1orOUpaMkFUYkFG?=
 =?utf-8?B?T3dmWUIxYTFjd2FqQ0VwVjYzZ05wY0dVTndhaVExem9wd1lyc0pDSzR3enR2?=
 =?utf-8?B?SndPbXU1M0hYWHF5WkNVbStyMTJpVnRkeGRsbzhoc0gyUkN0ZjNXMTcvWW44?=
 =?utf-8?B?Sm5GN2YvZWc1MlkrVDlid2lXaitNaXlQWEZjc2d1R3g0U1lRK2xtSVJmQ2p2?=
 =?utf-8?B?akk4cWszVlBSVkVqa1lNODRuc0I2eW5BWnBqNmdaazNqL0dkaTR6STRESGNi?=
 =?utf-8?B?N0JCS1pVTGw3UGljN204Tmg2NDRsNTJlUFRMZW55S3I3VXoyZUVhbXpNM3lm?=
 =?utf-8?B?NzYzQjhXMVA1TW10bGJ1QkRIcVVTMTBuVFppRFJjY3E1Si9HWjg0K2NhUGwv?=
 =?utf-8?B?NEVTNzI2bm1MWTZTUmQ0RXBlaHdGRkNmc0QzWTBCLzQzWDcyMm53UHlQL014?=
 =?utf-8?B?WnpGUFE1cGtwZ016cnc3RjQvLzRwRDRkZ2JHeWlKc1ZvYzhMTXI2aGZEbFNp?=
 =?utf-8?B?WkwvK0J0aE9Dd040WHVaRWphbytNRURmZEVaMnFObkJGR2l4ZkdmV3RXNkl4?=
 =?utf-8?B?bkJuN29yS1lFZGJHNWRCMWVDbmM2RDdWdERqSnNBNUlTYlZJNEZDUXRXSFA5?=
 =?utf-8?B?Y3poVURxOEVwRkg3S1FqcUJKcXlqQU5BbVhMNVJyVzVNdTJCekxUNjViVVBs?=
 =?utf-8?B?MFhGWXdTamlMbTFDZG12Z2F1OWNIYzRqcU5PYjRTMzhWT0ZxYWUvRXg5NVpo?=
 =?utf-8?B?bmhoTmN1a3hvS1FRQk4zajYxanNkTzBHcHozNHVNMmJqRjdacTlJbGduazNO?=
 =?utf-8?B?OTJ4ZWRxbHZiVUl2bDl6MlEwSG5DT3JJTDNtWGpuVkQ5YWp0YnRaakZwUFEw?=
 =?utf-8?B?Y1ViYnNlbUVUanFxU0loTG9IOGJTVWNmUEU4Q2ZVVi9hYmFjNytBZ212R3JQ?=
 =?utf-8?B?Z0dqeWh2QXhURnByKzZIWnNlZEJiOG5kU2FGcUpxVUNJWlFOelRoa2Q1em0z?=
 =?utf-8?B?Zk1scW1WeXUzMDRvb3ZJT3RJQlE5QXBiTHM3REtSOFRMa2Y3TXFsVXhobXNr?=
 =?utf-8?B?LzlhR1RhaGlIS1lTTzNYT2J0dUpKWFFjL0wxb3cwS0ZQbkI3TzFqQzVHUzl0?=
 =?utf-8?B?VFZtTFJTd25DV0pTNnJld3FsTHZFa2JDWVpnU0NDNTNRaURPWUoxYllwZmRI?=
 =?utf-8?B?RXpoN2YrbitFUmNGRTdrVGdZSjJuUnRGRmltOS9MVDBINFZtTDg4NVkvZG91?=
 =?utf-8?B?VTJDZVg0UTQ0MlBYRlRjM1gyRmhKcGU2RUhqckRSU2F6MUhxdTRWL1RsSkQw?=
 =?utf-8?B?NzNHejIycmJJS3BwRGdKdEl2MHJ1aG8xd0dObmpvV2h6UVhGaEp3NHNXSUtS?=
 =?utf-8?B?QmVQQlR0L210aW9pVENYMTRrQzZRWDBSZE9yeTF5Ty9maHovL2R3NDhJdHJF?=
 =?utf-8?B?MFFESmx5UkNqSkdsS1NESDhOQXlic2d4dS9WZFI2ZSt4cDNqUDFveFRjbnZi?=
 =?utf-8?B?Mzg3UXk5WXhad0doSUZXWlVKWVd0anNHbmhMTkJwM0J6eGNGSzVWbVNncVdy?=
 =?utf-8?B?OXI0VTU2bEFOVTlEVjQyOCs2RllKYkJSbThEQXJnaFpQek1ueVhhQWxqdTQw?=
 =?utf-8?B?S3FvTUFQV2V3c05oK1RXdUdlWDkybDJNZkpJU0RnNFZDNWxPSGcvR3VjZkR1?=
 =?utf-8?B?OVlPQi84QndJT3FtSFd2V0ZxekltVWJhV1gxSWk3MTZyY1NVelNlNTRRenZo?=
 =?utf-8?B?UjM5c2VrNHk5VkFJOG1uejJmZ2xabkdSWERzSHh1Rnc0RCtWUWNyV0ZJTExu?=
 =?utf-8?B?cVhpWjdLY2FGQzkzQnV0UHR2eDRVeFdwZG5yb3c4dUREYlFYczZ6R2xWYWpl?=
 =?utf-8?B?WXJUTGpCc24vcWVxNlQ5Qit3U0hEQk9VTTcxQXFuQUd3bVZ0S3RiT0ZsdHZw?=
 =?utf-8?Q?cDQvJk5haFUQCukcv6oDb6Z1A?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e684db6c-44df-47e9-e9b4-08db3c53a941
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 19:17:02.5877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 71TN1VOH+LDDYsFE19gs3uDLTDuWSYu2zmuuirGry4uq95mVDoDeW+hquJuHmj+LDP9CjobAr0ldpg9IziEtdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7523
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Apr 2023 19:17:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11196

On 12.04.23 08:41, Felix Moessbauer wrote:
> Before creating swu files, the sw-description temlate needs to be

template - fixed up during merge

> expanded. This logic is also independent of the imagetype.
> Previously, only some image types had this task in the dependency chain
> before invoking the swu creation. By that, it was working for e.g. wic,
> but not for ext4 rootfs images (referring to the type of the abrootfs).
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  classes/swupdate.bbclass | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
> index 064d0ad..e12a4d2 100644
> --- a/classes/swupdate.bbclass
> +++ b/classes/swupdate.bbclass
> @@ -9,6 +9,9 @@
>  #  Felix Moessbauer <felix.moessbauer@siemens.com>
>  #
>  # SPDX-License-Identifier: MIT
> +
> +inherit template
> +
>  SWU_ROOTFS_TYPE ?= "squashfs"
>  SWU_ROOTFS_NAME ?= "${IMAGE_FULLNAME}"
>  # compression type as defined by swupdate (zlib or zstd)
> @@ -50,6 +53,7 @@ def get_swu_compression_type(d):
>  # We append to the path, so locally provided config files are preferred
>  FILESEXTRAPATHS:append = ":${LAYERDIR_cip-core}/recipes-core/images/swu"
>  
> +do_image_swu[depends] += "${PN}:do_transform_template"
>  do_image_swu[stamp-extra-info] = "${DISTRO}-${MACHINE}"
>  do_image_swu[cleandirs] += "${WORKDIR}/swu"
>  IMAGE_CMD:swu() {

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


