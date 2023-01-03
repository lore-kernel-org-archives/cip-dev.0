Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6BDC46467
	for <webhook@archiver.kernel.org>; Tue,  3 Jan 2023 18:03:27 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.87])
 by mx.groups.io with SMTP id smtpd.web11.538.1672768997659746129
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jan 2023 10:03:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ZVYm8EjE;
 spf=pass (domain: siemens.com, ip: 40.107.7.87, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdFa+WYJ6wKldDGa8huKuLloDOvd2MgYcCdnw6heM5yLXYoAD3O+38iLuYeDt/hMpuJYzl6p0u9ch8/pyc2aQEpOX2piHATZR75hUfuaTOc1RI5IxspO0l39s0orN+U/fH1DnH0DG84NvEyQLutBkdb+ujYq/mhNeVCkqAPIOFiS8Vv7+PmGm4rRmOb35rs9SyZwDGbPWwfoelpFo8uDC1bUFiQVb81Lm3YhISWdKaJi/2tTXtVBcuANL3H+foTLkTI+nG9VUqmQA857gQ08tutiV+eeXBnt5ASqqXUMXZZWObbxUyWDbNBmh3DfVkh9aPbaakUelX1PKvtSdkeeOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXTGimRDeNynPHHa7XnDFQMv5AohA9OGQQZN0a8Zlvc=;
 b=ILw5/majnSz74gL7OhNlEfqYHd+c78mUtwbrnvUS4k1nHYDuShu7G16bguZmZif67yrnYYJv/lOmO4H9uUUvvcW0YgKJPdAmHbwy5O8gg20IrciLRhREFH1e6fBnLrsmzDwjFawfOyGRkZ4UPj2J/YpevBkN5tJ3IOV9PWVaNvJp+DyL5m7eOqaHkNxgBQx/DUwPS3K8JMr+IgJo8PZKU4PHfupgSgTeoJbACaVrAZVaB6J0+BoPnSCpBjZC0KlsV8OwDmKvup8amzJcMYlSl8hd5/qGXdM+nYB/tcDbUIbRGYhy1+0Y2KJ0GipKazYeXFDmzyhXv9D3xQJsKYt39Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXTGimRDeNynPHHa7XnDFQMv5AohA9OGQQZN0a8Zlvc=;
 b=ZVYm8EjEn0iILN8rVsfySEA8hdIZucvVlxCXziAC/H3V0QxL70pZQ8R9SW8GjGfFWS0tXXRVJ9UI8HtGrt4pnMm/TqDV35ZQDmuN4tvyxW+8ZvCg4xzwkOI27hSm0kyXYIg0v470+sTmi6fqSSPWUZkJ3Bhmaz/P02ZkSw8DiQmVifMdrgvHAl7z+vPiScq47Z20n2eRRtE4mzAsMMVr5yhkzttrZ5015aYPGeQW8clUQfCCN9EZLUAKajlbcMzk74t/CW9fWydsUojOhp7TXumqsIO+cHuDFQZiHPuRvbKD9q0x7AYfgx4iPjvqlddpxmPOTQBlNnYV3SGwMGwUdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3332.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 18:03:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 18:03:14 +0000
Message-ID: <56ac1818-f754-ae13-ba5b-203d0a13725b@siemens.com>
Date: Tue, 3 Jan 2023 19:03:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [isar-cip-core][PATCH 4/6] kas: set clear text root password
Content-Language: en-US
To: Henning Schild <henning.schild@siemens.com>, cip-dev@lists.cip-project.org
Cc: Wang Jing <wangjing@siemens.com>
References: <20230102170818.17689-1-henning.schild@siemens.com>
 <20230102170818.17689-5-henning.schild@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230102170818.17689-5-henning.schild@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3332:EE_
X-MS-Office365-Filtering-Correlation-Id: 4729405c-173a-41ee-0a6a-08daedb4c8de
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	mtfGQDJGNhkRVQAEYe/FnDjK+V7nNUZ+chmqRB+Ov2a2e5coSHh78fHUTCeGE+A6Ei3vERKqkpPXs9nLk9eoUNgVn26w6/G350gp0rh0/ds/AepZjHVPX4YtavJCeCRhdlsfxuB8QwaOiisnxd84TeWGKzxv3OMpNQnjp9GJK+oiGh8zBCZBr0AsVxQEYlsFV+Zc0UtloJMJMJ3j6tEK02bJEon0hfosuXbsCDhM3nYbB78J9yxeR5DiJ3alrBo5oxKtW9ZkckNBvAUyv3PfW17EflbkWSw2Bu+wbreK4ADG3wPnrJVX7QibRxGYRBZs64BTUEgvC+uBjOFi6U0qJL74EDoy6uuZHoA5EaM4dYR+MmVwjLRGCHApr5TXk4GbgpmUJ6djSl+v0ybzjMSF1kmGP79bFmyU1fryYcmsPTS/dHnbb/zCYKx76rnDfz3Qxs7xVbPGudKXYrxtGseolmJlAMzqRsITLLPHyeKJZUKigTfMH4xdQgxIiV+70zl+b1+dhh1n5x+uxX/SA3C2X5Agk7Zi0UXOQ8lAfC4BaqbsesI88yDnFHree0GPkqvJAV1zZnfG6TylU+1ELFx8CK8pR91OSUfo2aIYXLKYev0MOuBl80XY+qk5UuvNBFxpoS4CYSS9Xx/oSNIL4y9lnSSotxXopEkV/8esjV9y35TTsq+X+EwDrCWURcbFWJsLhXcbQh1Rv1wIKVThVm/wTa07F3AkgxUMKVi4Eva7QwvpDEBKWfP0bTQGyxbIs7mB7LpwHs7BMYngIshiEIux2wvVjdWqmPL1mDDyf/+oIO0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199015)(83380400001)(86362001)(31696002)(82960400001)(5660300002)(8936002)(38100700002)(2906002)(44832011)(4744005)(41300700001)(26005)(107886003)(478600001)(6506007)(4326008)(53546011)(8676002)(2616005)(6512007)(316002)(186003)(66476007)(66556008)(6486002)(966005)(66946007)(31686004)(36756003)(22166006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cmdWL2QwRURvbzU5dU8yZ29qWGs4bWZJQmdRYlB4WnhpNkJCeVUwclcxQkxv?=
 =?utf-8?B?YXhJVjlrM1FrOUFqTDhqWW12M2x5SjJoNzN6ZzBiTWExbVlKTDBpV2dGNitk?=
 =?utf-8?B?VUQwWThJVUlKN3h1dC8xT043ZXBaanQ1akFtYndDRVBlVDdITXExZHhjTFRz?=
 =?utf-8?B?aitSUjk5ZTZwcGtsVGQzS0RqMm56NjRDbzZDeU51K3JmU3VpMWVNZTdSb00y?=
 =?utf-8?B?NzlRbnQ0OHcyOUR5Mi9HVzNaQWNVYldROVFiSDA2bmRiYVJEdlpEVGZrU3Nw?=
 =?utf-8?B?N255Rk9KL01FeXlBWWNTT0svdGtvN2w2UXZuNys0OFVjNlU0U3l3L1FMbCth?=
 =?utf-8?B?aTMrTVB6R1MxclYyZWNHdkduYWRoVWplYy9WcER2ZWh2VkNoWXgxY3BSOHFw?=
 =?utf-8?B?MDRKNGErZzNGcFI0Q2RraUpHekRrNFpxbm1KREpSeG1HeW02NHlnRnhnR3FX?=
 =?utf-8?B?TS9jSzN6SUs5eE9IUVlwWjBrU3JHamxYeEdqakxCakk2TVFzUFlkdy8yMmJJ?=
 =?utf-8?B?UkxPTng4WTFqK3B0TmlXNDY5SllLaGJNcVFEclU3czNJaE4zaGlnSlNPQlpS?=
 =?utf-8?B?THpHZ08zVDYvQzdMcE1YUEIyZStyYkZTWVZwRWwvb01RU2dPM0hwbEJRQUpW?=
 =?utf-8?B?R3pCcmJxblJmN0R5c3lCT0x6djhJM1NoRFpYRVdsUmw2RjRNN3dEaXJLYXpC?=
 =?utf-8?B?Z2VMcVZUOTNnS2srMit5ODFpMEEyMGxndnN6YU16YmNPd2xWcDFKL0hDWjZN?=
 =?utf-8?B?OW5LVzRaTk5VU095dTFzWmpGa1dCMFdueHpkZFVleVFQdjFTcjJnQy9pbFNl?=
 =?utf-8?B?bXZqbUFhTVNxTlVOMWJ1OVpxc2FicGdTd3lXVnVqNTE5K2lza2IvL0pGRyto?=
 =?utf-8?B?c3gzelFMeWxiVjZjUVdET1NZc25vQzB5UXRQd3BlMklvYnhiQlJsTWFmWUI5?=
 =?utf-8?B?WXdSTUlvYWNJMUFyY3BObFpXYmo3WEVUcW5JSkY0YUExQndTSkRpbTkyYlRO?=
 =?utf-8?B?Y3hzcENDem9od3FNL21UcDA1SUQxL05qK2NGTzNlUzJOc0FpVWpaL0Y4cC9a?=
 =?utf-8?B?VmdwL0Q2K3diK1pLYlAyN3NUWHhablZTaVNvQlRQT3YvQTFqanlRT3BjT2E1?=
 =?utf-8?B?R01NRjZ6N2xiT2tyNWgxN0tvaHorTjNWY29LVWJBeWhQZElHVHNpNnAzR3lW?=
 =?utf-8?B?YllGMkFUU0xxcitzWlFZVTIzYUdacEtTd0RiM0lNaDRtVWpBM1oveHF1YzBI?=
 =?utf-8?B?MTdrdXE4dE5UVGVQKzBZV29HNlZYY1pHQitjc0tRSVN3VTVDN0prNm51VTRu?=
 =?utf-8?B?TlFGZkdGckltNmdVYTkyTzhXS1RFKzhLRDkxaWZVMFJ6YytBWk1OYzF3SWVS?=
 =?utf-8?B?cUVTblhFVElSMEhsUCtzd3dxQUpKOURkbHk4WEV0RlJrc25OdUNxekgveWh2?=
 =?utf-8?B?Y2hBZmtnMjdJMnJKeVB3Z00yWFpEOUhGcityU1o1dnZ1K0ZHVElsRHp2UlBx?=
 =?utf-8?B?NXg5bVpNUEl4R2R5cnlmeXloREN1blExU044a2dQSEJHMzlvWUdick5WV1JV?=
 =?utf-8?B?RGFZdUZySHFpb3d1MWtkVzFGZXJFTW5UTUt5dEZMeVA2M0RRVktwR0dHRlph?=
 =?utf-8?B?bjJNdVc4S0lDbENKamlPbzV4ZFE1bFppSEhtZnl1THJiYnVGOVFWWTBFWkRx?=
 =?utf-8?B?TnR4RUFMQWFFY3JybWQrL3ovMnAzMnZoQnRMWWoyR1NPMnhheUZzSjViYUIy?=
 =?utf-8?B?ZHdLVk1OUlBYS0tyM1Uxc3ZQNElZY1N6M0xZaU5HS1lMdnFOYVN4aTNraDU4?=
 =?utf-8?B?VDR6cG5EOUdsM0luUDRsSjZLaWtpV2ZKUERxNU1JYjlVZkduTCtkcnhOOElR?=
 =?utf-8?B?Rk45UGpZNGkzNVE5MlN2VHJMaEgzSzE5ZXdiaGxxcnJydTIrVEJ1enlsUUdW?=
 =?utf-8?B?bzBZQ2RSVGlKOW0yK1F6UWJKRjI2Wm14SEk3WkNEZ2YyMzlnSS85REFuVjNr?=
 =?utf-8?B?OVdJaGVzL1NGSDJoRzJPNVBZTXdnNjQ0OTdwLzkrUXRCRVZGbHhTR0NyeHl2?=
 =?utf-8?B?VnF5VmoxY21rd3loTlNNQmVwekZSZFo5ZlBtQjB3eHBUb0JXSEErUlFJcjEz?=
 =?utf-8?B?VEh1THRlV3JCd1hQczY5OTROMy9MZFB4Q1hXMStnR1NWdnNnTTN5UHBKS1M2?=
 =?utf-8?B?MFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4729405c-173a-41ee-0a6a-08daedb4c8de
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 18:03:14.7486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2vZQM4NrfJSULT3fS76FDIrYhWdEuygWeml+sTca3R+m2kbgI0865jr46J5fA8NSeVl3r2vv2q4GPLvah7SEtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3332
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Jan 2023 18:03:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10290

On 02.01.23 18:08, Henning Schild wrote:
> The comment above the hash looks weird. Might as well write it human
> readable.
> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  kas-cip.yml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kas-cip.yml b/kas-cip.yml
> index 10f4594334d6..b970f39ccb13 100644
> --- a/kas-cip.yml
> +++ b/kas-cip.yml
> @@ -37,8 +37,8 @@ local_conf_header:
>      ISAR_CROSS_COMPILE = "1"
>    root_password: |
>      USERS += "root"
> -    # 'root'
> -    USER_root[password] = "oC3wEGl799tZU"
> +    USER_root[password] = "root"
> +    USER_root[flags] = "clear-text-password"
>  
>  env:
>    DISTRO_APT_PREMIRRORS: ""

Seems we have some conflict now with settings of the security image:

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/3548200620

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


