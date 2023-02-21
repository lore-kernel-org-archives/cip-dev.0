Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEF1C61DA3
	for <webhook@archiver.kernel.org>; Tue, 21 Feb 2023 20:37:49 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.46])
 by mx.groups.io with SMTP id smtpd.web11.54297.1677011860500285645
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Feb 2023 12:37:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=IL9sGuue;
 spf=pass (domain: siemens.com, ip: 40.107.6.46, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cY/I+41iFENX2y8RFmgW4lywzJWd2aSWgtOg4IG1P92BrLS9B3f0rh/IvPlopPI+cFUuKOcqt/+TDFqPk3ASYbq+9hTiKmz7ZHvNohXgTG4kzs6mOjxDfRJ/A+7x2Y2z1nR/thtqhqtTeH1NpB0x83ei7HOjnrRIauXMBtFPyagRVo4ZswGr+NmQCahtzW5LngUYx+zgXQ52ZPK4qyGHTmWHTocHaapI4JVGLA7z36lFgIOPQxX27ADkBAw4h00sBHnBbwt7o3cvkPXk4lMMf/jalDRkVqa4Z446dr4vgdX9XaVMaKg3sTbFScNggSeNGIwjhWC7ZsFZT0PSjqMFSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhkB+Gc6jf5M2dFlNPBxN+LLPj11imXq2+dCoL7qnCQ=;
 b=n80Ai/psJSayZaE2ftNtGxbKryC0IL1BjWh16XpIz4jHqU8InF3WwL1D4EMB5eD5Tv3aL5AheNnpH1hhnDNVFs971maJk7chYLCz4we923l6pKCjgojroCByFefO1sgFljQiNB04+C0VmC2OE5WG/P2OZydC/3uwZLA7mbIwv2gJ26oX/DXnMGnncVZjaHopmAKvnLY2WlbMYZ2a5OHjqAvHULnPrXqhYvDnQhpdYoeJw7Q8NjwHya+dc3Dr08k9KBIYrOk6UZ1MWc+sbJPKr5NPchq8ro6cR0n0fjcKpuPhXb7DWJm4GjbtKGR1wEqFgCuneLinWpjHbtqlHGLXUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhkB+Gc6jf5M2dFlNPBxN+LLPj11imXq2+dCoL7qnCQ=;
 b=IL9sGuuesLmPUfA0Tlp8AMxgVBNUd3Awoqrv+wQ690fSKnlj4ph7BdSi7WqT3lQklmISMoYk7wSvVUBiiS+C1L+yfMvhxJDPtMTVRHUzHZzaTh2pEQVgm1jOTfhyWYPf/tKKhQr18X1R6R3gD/iBT4Vv/7PM8DT7tsf5Q64v7rZf6gsKiUbRzpgII2Ey7CWOCuaWooBgN1OROhhGsjZ4jLzrfx6xK20s0nmswaiXwKFqoNGE88Qg4SF05ZfYvNU+98R02YtiEiv9wfHs70Qm7GGg5TjcJMz37GXjoeRha6D9XiJ/FeUhPG2GAS3hXdn6XPNFuIWPNJhbEkXWCF+Jmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3635.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:153::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 20:37:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.019; Tue, 21 Feb 2023
 20:37:38 +0000
Message-ID: <0e8ef8ee-0726-898b-f0a4-0b5efa22bde8@siemens.com>
Date: Tue, 21 Feb 2023 21:37:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [isar-cip-core 1/2] kas/opt/reproducible.yml: Add kas file for
 reproducible builds target
Content-Language: en-US
To: venkata.pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230221154138.15146-1-venkata.pyla@toshiba-tsip.com>
 <20230221154138.15146-2-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230221154138.15146-2-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3635:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b6b974d-5ea3-4153-71a2-08db144b7887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	S/p7rbPKJ/U9OrjC0Fi3nQVAazmJXCLlG6b7dRiP9v/H0BaXokkRRMfg5yqmSg8eor9kMhjDkhdfToddC+ZrmgwoRWF3XR8Avy3Ic5O/Spf+1PElpb+wErM8oJJ6+tmPp5xOsjQa2KvhcPWSXz3q232HH9Sago278BN0y2KIs27DMv25w7B8NrQYabGlQrvqHvrExRVDh+VNzdX9937sPuUdkD7c+lstYzQ4apLKupYoLjX2iRI2oVy6q7AnJ98yLkIp0Qs+34vgnqMRR6a5WPce6bRqr+wzYGUc5QA2MM5kTR8A1FgmT29VCJqi8NIMHbuRTV+kvIs5Q4mzJufxrMw6wae6oCHJZPn9OBasBh1Ag1srhNsAHmm4U33e6uUSRmCmDMzBaJIRlNCxv0f86tu3mZUEvov9EcMxh4Xi4rlt81bpzdk8JCcApjVlfbVwuitLS4dLL7sfrgoZZVf+6wS2rsw8Okz4gGPLk6cn3eUrKkjKkvUL3gOXdo0j+L5hwzKaroX/GycNN636BtVfl8F+dRVv4kCoMCELNRHAsT/+sYlByBwQ9bkpvJZclEXM6CCD/cDVZvCCGfPmRciJRyCgkpJfK1Sjiv9fmlYBJCYuSm3p1oPwIdDizsHyhzw32XUjiwRvECSBnl1BYyQTnAhM820Jw9enrXbo6qe85ohQeFFIgBGGIJZjQEuB99zKK8brXppsxG7gWoVpu9Pz9t42+7pwDo28UEBuI+bx1FQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(451199018)(38100700002)(31686004)(2906002)(82960400001)(8936002)(44832011)(5660300002)(26005)(6512007)(186003)(41300700001)(2616005)(8676002)(36756003)(4326008)(66946007)(66476007)(66556008)(86362001)(6486002)(478600001)(6666004)(6506007)(31696002)(53546011)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eU4zVDJ3bncrRzIvaWtqd1BZS3JCNmZ6TUN5Vy9EL3pQUWhMakt3RTVSeXVw?=
 =?utf-8?B?WGk1Z3gvNllVZ1IwbjZiaVhZeFdIRElDdE9YaWJTSjZWak9FY3pXTFJEcTVo?=
 =?utf-8?B?eU5xMmlZT25mVEV4cjBQa3RUdXN0WWdTTTNIMU5sUUdJdXZlT3FaR2RkRmIv?=
 =?utf-8?B?NlhOTlVmenNHcnJxVnc4OU5qQzRGbWJDVjFnQm1VUE81ZHFPTTUzVHplcEh5?=
 =?utf-8?B?Yy9CVEVPOU8zbW1ROVM1N0EwaXIvWXdLb1JjTFVaNDhkNnhQYTJzUkxvbGph?=
 =?utf-8?B?M0RHVHZ6b3FsS1pmTXRJcTRMeWJ1Sm9JeWdtc1FvUDBWY3lzRHZ5Z3lUSCtr?=
 =?utf-8?B?TDZwL2Z0Q3VHT05hbDhBdmlaYTFmVHNPa3FOVk8zanIyRzJSQnhpd2E5dzEy?=
 =?utf-8?B?SnhCOXVvcTREdmYvTDNBOElvakphdVlIaGw4UDFRcnZTUTFGams2SEsrYjlL?=
 =?utf-8?B?bThVdmpkeEE5Z3RBTWFkK3ZUK3pkWVpjbnJXRmd1ZGlKd0FGS0szcnIxYUtw?=
 =?utf-8?B?a3hIcisraGxZYlRNQmhDSkpWZnQySVdxZGdmRTdUUHl3dWxzKzM2NWNUemRl?=
 =?utf-8?B?WHU3MmEvTVdSQlRNdWFUM0lISGpTeTEzV0hQV3lhTklHalZwN2ZrZGQvQkdz?=
 =?utf-8?B?a0krUHU0NHpXTkVpYitxODBaRWUrUldTMEdYeVliUWE4RUJDd2pvSGdrcVll?=
 =?utf-8?B?Mml5SE1Kb056aXgzYVd6UER0SHhacUdaQkxVWTE3Wis5dGlWQi90UkR0Ymgx?=
 =?utf-8?B?dUlxMW5aL1pzeUJoTXVsTUJCcVkxTEJVeFlaQllRR0JWL0FDaVordkNsQzh0?=
 =?utf-8?B?Ri8xdi9mRitQcERWaEZINHNJRHA0am5PWmVkZnY5SUduVCtsdXFyWnk2UnQ2?=
 =?utf-8?B?UjRQcVRxL0JvNnBjbmpXbGt0VG1sY1pjcmwwYVhSckZxK2R6Q0Q4Q2ptdE1o?=
 =?utf-8?B?M1NtY2hSUnRyMWFJaHhucWZ6R2x6UlZ2TWJHNWx3UFQ5OUJJVk9OTWNVVDBs?=
 =?utf-8?B?bC95bW5rWEp4bmRiVlg5cUlFUklKQ3FzNys3T2VSVm1pcFJGa2MzdU5yR1By?=
 =?utf-8?B?bVpVeGFkOEN1SlQ3ZlJCS09VZVVyMmFEdVZKbnVNVWVodU5RZ1k5ci82aWF4?=
 =?utf-8?B?ekNnSXJ3aEV5WUcyMjBDMTdiTkhwdlFMdWZGVVlZRkxTdVYzNHA5MDhWZDdr?=
 =?utf-8?B?aUZiY1k2Z040NDJJUVNIeEpYZWdvVE1JR3RFR0o2VGpqMXJMekZlNG1UWTNi?=
 =?utf-8?B?NlZFeE1DTmxmL2UxNTdrMW1XWDVZUEZNbG5Jelo5M083czFPd3hlQVhIdllO?=
 =?utf-8?B?RW5JYXh0OElTcmpPenhyK0MzWXFEY3ZJZmpBT1VRUlNRbnZwdjlSY2QwS0FU?=
 =?utf-8?B?LzlkNXl2WVBKN201eFp3dW5uZFJwZlo4KzdVVHRLZnFXL01mZTVzYnNtemx2?=
 =?utf-8?B?ZExZRTRPaGoreTVsMUdiRHFwdlJxL3BpMWY2RXoxcnMxYm05ckRmYnFHcTVY?=
 =?utf-8?B?THBhZitib2tsT2pxN01USHJwYWtvOE5Tc3lSUyt3YkZEMENvcmFiaXgwcDll?=
 =?utf-8?B?Njc2c2pwa3IwdEFmS2w5ZWw5NWVQWXJyUlk2a0tXV1lRdFo1WmRBWjlUVUJh?=
 =?utf-8?B?ditzak4xNHFSYkdlNUFSYXBJNHRhZWVydUlZdTFUQTQySDFzSjNUclp6czR0?=
 =?utf-8?B?clNZSGxLS0lXWjNseE5LSFF5SWFOUXpzRWN5RHkxSUM2MmxhQVpHek9GaWs3?=
 =?utf-8?B?Q3d0K3N4Vk1JVDZETkQza3R6STBkL1hLV0FCcUcwQXNCclhJRyt4bGI3TEl6?=
 =?utf-8?B?UXkvZ294bmxSZ25PVEVFS1A0aGRkUFM5eFdUSlRTbmM4a1M3TFFpa1lUSTJq?=
 =?utf-8?B?WStRc0ZvMVZiVkJhTkMxMFpKanRCZXhnWXo3Mll1ejMwaXl2SzFlUXkyVzlM?=
 =?utf-8?B?WnZrRnJSdHZIaXl4Mm1kM2xaN0FhU3BYZEFTZ1U5TjBYYUl0eis3dGo4Z3Jl?=
 =?utf-8?B?MHhvazhoVzNCUFBVdDk0amovblVIKy9xcDd1NkJ0NWQwV3ZsU0NHaFJqZXRG?=
 =?utf-8?B?cVdKSVdKa25pNGtJQWp3TU82U2dKVlEzblAvUnUyYjlNRG9OOXhUcUdVcDU2?=
 =?utf-8?B?VkRMVzk4VjlBRnZOVVR2WHRIVFc0bDJOaXdEWkdCWTVNRk9EdG5FT2MwODZP?=
 =?utf-8?B?ZFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6b974d-5ea3-4153-71a2-08db144b7887
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 20:37:38.3271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1Kas9s3EA1oH6k0ITBMMt2qT8fUtkmQL6hd/i2RrAsSQMFpjr4VHW4IGO9BOkyPFP9H9GsbDVlXFZrwyOVKEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3635
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Feb 2023 20:37:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10762

On 21.02.23 16:41, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> This kas file set the 'SOURCE_DATE_EPOCH' variable to last commit
> timestamp required for building image reproducible.
> 
> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
> ---
>  kas/opt/reproducible.yml | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 kas/opt/reproducible.yml
> 
> diff --git a/kas/opt/reproducible.yml b/kas/opt/reproducible.yml
> new file mode 100644
> index 0000000..173c018
> --- /dev/null
> +++ b/kas/opt/reproducible.yml
> @@ -0,0 +1,17 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Toshiba Corporation, 2023
> +#
> +# Authors:
> +#  Venkata Pyla <venkata.pyla@toshiba-tsip.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +header:
> +  version: 12
> +
> +local_conf_header:
> +  reproducible-builds: |
> +    SOURCE_DATE_EPOCH = "${@bb.process.run("git -C ${LAYERDIR_cip-core} log -1 --pretty=%ct | tr -d '\n'")[0]}"
> +

Should we already make this available via Kconfig, or is this too early
as we only a generate reproducible rootfs so far, no device images?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


