Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10C9C4829E
	for <webhook@archiver.kernel.org>; Mon, 12 Feb 2024 18:19:40 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.87])
 by mx.groups.io with SMTP id smtpd.web11.14042.1707761979917738417
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Feb 2024 10:19:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=jKTtggj0;
 spf=pass (domain: siemens.com, ip: 40.107.241.87, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b68s7umHoMOe5uj4W+AZ1Hw1M1L1CNH8G31j2dclP3FhYZYGQ1T0CM3/UFfosAEfPDa80TLcxy0TdNdj+MdqxqPFCJLDY/2J7jmuqbcfWqNI70WK6Gw5y79us25+Rf9NgsczbjciAewVEZiA6NTNuA5jnNmIdz7H+kssg3qJHAFordnboj6OcajZv2+nR+CuRAlOARYgd2NGA0FSj6tCfilrePbBevzBU3R1NSvE9Tx9K7Vu32zj5Dr4otEmPwCTB/6qNpy3mSIC7dkuJwxBeTHhHTsPX6vjhh173+gxs4UVoUy81/f3luvAUf3+tTTBQGSjz5FCe/BNqHCWGgyZCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWeHQLZwgEfP33Gx29Zi3elKdg1P+g6bDy5j+X6bDUY=;
 b=VZrO+5KZi+q0ovLd/m9IQs3thDIfGTdMHwszW3zMLT8REn2oyLgqu3eimeqnpRx9mt7jsvl143xT7cr/wbzL3xzaaZSeqmsgHqHbRbSFanWob4qyFwKmodC9M8ojRqB0H3gcNqHR7p/y6XC0v34OYis7pYz2Yt/PjfmsPPdK8T53Y2iv0Ka267IsW9x2ltPxpVqsXXZvpFggZXxAa++Q9TBsQ06pdn091gToodIWs0lhBDiOUbsMm03bndUGlDSJ/SfnKDS36oixde7WV3reKjAcF8OYr2Z8IuZ+hEvN3L/UYKfF8oAjkak1FZvNwtsuZfpgcN3i3/hM3koHANuKlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWeHQLZwgEfP33Gx29Zi3elKdg1P+g6bDy5j+X6bDUY=;
 b=jKTtggj0r/qcJoedNU0LA51HjKPa3LWJPJuvWDPYHkXsaW/Ok7DwPSlGaNMYmg7+18MKNb1yxY7PT1dCnUzJ+4uZYg8VE+ak3dEqW/8cwnBd9DN2rQZVjZ70GfVmBYWqFas0qs3Vw2iF+8AqmQQ1Ut5zAbhG0ASWInF6Lf5Nhn4GQAfav1kI97zzzk1+u373d97UZ8rlIRLMBcwEfq5xXTofa7Mz/CoCuqJxaYv0T8FjS29CLTp6Nu0yg6hiDmTlm0KBgOrmTxO/XgJfONVuj8Q4ay/kJ1hSDeGvJs4uOYM199m5CnG7pjErbZxGHLd7H7sL7wmXHnTHyo5GTowIjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5750.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:313::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Mon, 12 Feb
 2024 18:19:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7270.028; Mon, 12 Feb 2024
 18:19:37 +0000
Message-ID: <afe9b752-fc8d-474a-8d8e-aab773f7b054@siemens.com>
Date: Mon, 12 Feb 2024 19:19:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC 0/4] Reduce difference to debian
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com
References: <20240122123751.83696-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240122123751.83696-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: bba72c0f-a455-4616-869f-08dc2bf72be7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	G5FYbjO0syIvW1iwCbRUTAY21ikMwjDMX14V26C804h/Q8AikmOmsKztp3GHeEhpCqIRz4co4UUH/yfdRkz98nnc4aMr5jpqYmt4EmK2pEwNo1HfTnoRtQXFjvifXt5XxzUD8uLGmMN1q4Z8/aGNaBUI9MZRSUadsschHKmD6nvFrSFc9PRt7oLg1YIDhbuQoWEdM5UMtp2HpJYMAYAjUvzuqEJfuJ7jn4wK6RlpSIvt24x76Cfw1f3uurTPLtpJahpPVLYD1i2nhzuYmepIjGnKJjH2csHEcO0Xv5uYC2PQw4Tag4BV7wULsfuA0SLwlZKBmtZmQ4BDKnJyNlvAfseNHbI0jVGoJykV5H+rRHBzh3Vd5xBxdaAv9op/VSA3nsoL9XlZX4uJzEJBgo4k7AUQtSwS77nSU/uQy08gFBlQApG2zCFaJLMTAZ/myHyyT4hPIXWQJwx+fDtHaf/3vGEWBVTY/3k8zCwR+zu0+cAqcHtAULAZQE6veVARieh6Atf2MZ3rnvD6D/mlSl1asNDPh9I5FRT79HQT81SqVf6HNVYp17p2dzCjDxYc3WZ0
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(31686004)(6486002)(6506007)(6512007)(2906002)(36756003)(44832011)(31696002)(86362001)(66946007)(5660300002)(82960400001)(38100700002)(66556008)(478600001)(6636002)(316002)(53546011)(83380400001)(66476007)(26005)(8676002)(8936002)(2616005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?emJEcHRRc3JwK1BTOUFoVkdPeUp4RmtiQUhpTXhHVDFQZ3FmdVVpM3lrOUQr?=
 =?utf-8?B?bWR5K0dRR0E5T292bGEyZDY0VFYvTWpEOXRWK0gxUzlESHExMHBkankzTmV5?=
 =?utf-8?B?WlFKMUdsV2ppd3FNQVJaR0xXdDhuOEUxMkZKRmlSWWszRjdvVHA2eTBMRldk?=
 =?utf-8?B?eUUwOTNhZU4ySERrVTY0SjZ0Q2VYT1p1eTdOckRZK2I1Q2xCQUhtTW9aczRN?=
 =?utf-8?B?WGN6eTVYWHFZRENjQ3dWT1RkMlBCbThUVDFiT1RWVDNDTng0bW9YekExdlJD?=
 =?utf-8?B?Zk1ROWtVS3pmeGdxUjhPN2VqejNkV0hMY3JjU3hHbFdNTnpGTWNCYkVLa2lE?=
 =?utf-8?B?L2x5UW1ncDNJNWU0Q0NPelllYk42QnBXUUROUS9IOTNPRkFuQkZFVWVncjdH?=
 =?utf-8?B?M0pPSWJzTTdaaW81QlpNU0ozQ3UzNWRYMHFDbkJ1WXhmdExyVlNTUDVETi8w?=
 =?utf-8?B?dGcwdkdTUmxyTU5yWVI5dEl3eFRoSnJETUtIa3V0VFNMcW9NRS9waG5vRVVX?=
 =?utf-8?B?Q25DL0RjaTRpY2hGWVk0eEo4QTVNd2ZwS0tqbFEyajVYZXFtYVZlVnZUZnpZ?=
 =?utf-8?B?QkdocUNMM24zaDdrUURRcWsydTI5bmFpcWxpS0VLTmt3WmdsSkRLQ29yTmc0?=
 =?utf-8?B?U3hBdzVSUEM0U1FBdTVVdkkyQTJDeDdLZFYwTEN0ZjNET1hFZ21UVnBBcFp2?=
 =?utf-8?B?eXpBdytjNUUyOWlrYlgySnFIRzhja1dQVUE4WEF6aEdVZ2FGNXhncFkrTGFj?=
 =?utf-8?B?SzhtWXZSUGhLZm91eWRVNEZxRXFpbFk2YmJDUW1obDRPVWlTNWpuZkQ1TzB6?=
 =?utf-8?B?V2dja0w5dGt3Kys3WHRmd0JiaDY0d055T0YvTkxaeDB3d3h1N29YcjgyVkhk?=
 =?utf-8?B?ZHFmaUxHQVJhNjc3dlhVWkx0bGVuZHRZaGEwVy95bXVBeGV1YWtDZzZrVEJT?=
 =?utf-8?B?N210UXRwZHZzUGVaelNZTXdxNnROTGY4allLQzdNS29peGl0N01xU0ZVOUNi?=
 =?utf-8?B?Z1N5VzEyVmcrTmZ4VGFlMFZzRnZzN1NLQ21sTnA3ZlJFdVdOTHU5RWZrTkVi?=
 =?utf-8?B?REVjOFdRMVlIU0hPdG0vS1dkN0t1TTZodmVmcG1PZHYvOEt0RmgyR3lGb3cy?=
 =?utf-8?B?MVZNODU2OFhkMVJqMGNzMXcwQ3UwQkFtMElsbnJoTEdEa3pQdlR4U21sVysz?=
 =?utf-8?B?TGZkVFdqRXFQN1BLa1VwTmZ4MUdLbWRIUjhIY0JRRnhyamFYQ0tFV0VFTTJU?=
 =?utf-8?B?b0NMajRRNGJXSUhySlZnWUs5WWJoTVN0RDFkaEJUZzJibElqcHFPazZvT2pX?=
 =?utf-8?B?NjNUSGFlOG4waE9kdjZMclgvOXFLQmpvbG1uUW9XS21QSkk1Q0lsSEtCcXgw?=
 =?utf-8?B?a2ROdXhGODcxbmw2dk9zTXc1ZWg3YmlVYmNXLzU0VFhQcXc4TDNqS0g5eEFp?=
 =?utf-8?B?TFZvck5HM2JLdnQybDFmNGxZSkRBRE13VklKQVp5NllHaVB2OTZacHk5ZExY?=
 =?utf-8?B?QjFHeEZRb0RqREFkVTVoWWtxbXNMNGtTVWY0ajlXS2pRYVMvQytVeWpnUU5l?=
 =?utf-8?B?NTh2RlVjWEJIbnNaZG1rQk5UVjAxQXVMcUFIeWNtUVNjamU1TFZIRGYyNldO?=
 =?utf-8?B?ZCtROE05aXllNnU4RnMxdlRkQWIyVXR2ZUxvUmdpcGdDRW1hcEE1VFFhMWdE?=
 =?utf-8?B?K2JaeGFocTdvZ2hlWUkxUnNBOHY5Z3lMSmlOVWJCOHpmczJqZVFHdHRMM2ls?=
 =?utf-8?B?M1o1MGUvNk90dEhzZnI0d0xWZU1SbHZ2bXFjWFFTQVR6akc2MUFqcjlPZjVi?=
 =?utf-8?B?eVQwWmtGQWxnb01obGh2VzVjZ1pKTHliUzhQUERCaGordnYycEx5ZllCOXY5?=
 =?utf-8?B?Q3h5WVo5VzNoY1YzRnlITlFlelJUbHo4WlVHZmJYbERvbG41WFNHaTNQdDJy?=
 =?utf-8?B?aVdsYjNEdk1XRkFqekViejdRR3VUVXdoK1RReEdWaU5UcnpobGhyR1dqdCtt?=
 =?utf-8?B?c012QXNjTkc0UWVBcjRFelM2dWJrZlpnN0x5dnMzWmpWbWdNYmtRbkQyKzFm?=
 =?utf-8?B?b3JnTTFuTmlxaGtmRjVpWVBRcjZFcVRuNHE1cGhjU2NydC92RHo5dXFZQlVF?=
 =?utf-8?B?WG9ETkxwTndIVW5WSEt2djNIZ1NQR3Q0aTRkQmlWd2N6U3VTVW9TQUhvaHA0?=
 =?utf-8?B?OGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bba72c0f-a455-4616-869f-08dc2bf72be7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 18:19:37.4324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aM2Z45K9/UnhKlIwUsJfMOn6XRICpqF/J0DXuioUhi8QLgd8I8JM8XAq61x292hcmbOX4nFPLYc91+YwO74meQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5750
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 Feb 2024 18:19:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14925

On 22.01.24 13:37, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This patchset introduces a new configuration package for SWUpdate:
>   - It adds /etc/hwrevision to allow removal of the
>     swupdate.pkg.nohwcompat build options
>   - It moves the swupdate.cfg from customizations to allow the reusage
>     in downstream layers
>   - It adds an patch for suricatta_wfx which allows to use wfx without
>     embedding the lua code in swupdate.
> 
> Quirin Gylstorff (4):
>   swupdate-config: move swupdate.cfg from customizations to own recipe
>   swupdate: set SWU_HW_COMPAT
>   swupdate.bbclass: weak default assignment for SWU_HW_COMPAT
>   swupdate: Add patch to copy the server_wfx.lua to /usr/share
> 
>  classes/swupdate.bbclass                      |  2 +-
>  recipes-core/customizations/common.inc        |  8 +---
>  recipes-core/images/swupdate.inc              |  2 +-
>  .../swupdate-config/files/hwrevision.tmpl     |  1 +
>  .../files/swupdate.cfg                        |  0
>  .../swupdate-config/swupdate-config_0.1.bb    | 27 ++++++++++++
>  ...rate-build_profile-option-for-delta-.patch |  8 ++--
>  ...tch-to-add-the-build-version-to-swup.patch |  6 +--
>  ...s-Add-option-to-enable-suricatta_wfx.patch |  6 +--
>  ...install-Fix-path-for-debian-bullseye.patch |  6 +--
>  ...tall-server_wfx.lua-to-usr-share-lua.patch | 44 +++++++++++++++++++
>  recipes-core/swupdate/swupdate.inc            |  3 --
>  recipes-core/swupdate/swupdate_2023.05.bb     |  8 +---
>  13 files changed, 90 insertions(+), 31 deletions(-)
>  create mode 100644 recipes-core/swupdate-config/files/hwrevision.tmpl
>  rename recipes-core/{customizations => swupdate-config}/files/swupdate.cfg (100%)
>  create mode 100644 recipes-core/swupdate-config/swupdate-config_0.1.bb
>  create mode 100644 recipes-core/swupdate/files/2023.05/0005-d-rules-install-server_wfx.lua-to-usr-share-lua.patch
> 

What's the state of this? v2 to come?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


