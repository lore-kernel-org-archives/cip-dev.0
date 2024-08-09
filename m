Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71295C52D7C
	for <webhook@archiver.kernel.org>; Fri,  9 Aug 2024 15:26:36 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.77])
 by mx.groups.io with SMTP id smtpd.web10.86624.1723217188812951730
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Aug 2024 08:26:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=do7aGiHX;
 spf=pass (domain: siemens.com, ip: 40.107.20.77, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMAYlHlffEXx49QNMhYgom8R2ofuYIWQskJW6/1Wu9xGepdQ/x8sScrSgBa22U90Nv8j9yMNhmlxQVfKZe3aSlQwoXT8ED5wB5SkwOjz7X/ghLykf68Id4lDYd8l5ExhFnAbQtqPKnrMNE0cuS54CFAwgeGRdfmMjOf5B0vhV9b09IEFodOyz78U8ND2D76kjTexlkRnDOYDQgWRfvTVPg8F37r/PYPWc97sed7Ye8iUOzR4CL3fZ1XWp9kVFN+Y85RMOzciPoxiL5hIbGODU76lJLNZn/iQc5yyhCd47LY7Ng//LdKjRm6TrtOi/tsiONvmfCLC3L3/3Tprs1P5+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBxr9mJ7aWUZIxG2QA736J0rlu8kPbrWrCkFDxP13nw=;
 b=NYYwhG47IL0SDTAp0iPMc+OrxQDzXs1xy67esIWUa1T5x3+LajXSL3Wvo5ND7eFf7pNLg6DI9WFkwo34uAXy2VF1Q99xEuQ8ZE3KuZt0W28ABTUkP+PYH3g8VjoYMjwXvV6cWJcY4ZlpEpKiylO9DkmFdYKFRGOZff3pSZRKsVePg39UsMtnmN40R923ZJmRicmFchPj0tLZl6HjvoDu97rzpYARMz5eudmPjAtksncqqTfP9PCkFbWHCTXbrY/4tylhYlwIfwW1BmQAg//pyR6fX7bEevR4Q6oITniQSJgexQThazw8xAtY2CN1JXhi7Dp+V1dwIjl2/e7X3FVDyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBxr9mJ7aWUZIxG2QA736J0rlu8kPbrWrCkFDxP13nw=;
 b=do7aGiHXAOYa2hjmQNK3skVj5VLcd0KzARMdZcuI24uIRu8bXPkUwlS5/Mml8dcprUZgR9n4amifgH9r60f2UbTDnFhjlSHbhrnM+0SChIYw0jXgpOQSiHCkBLMsvU9/8sCJ8lFbOHDLXX84E0HhhGPNTtPvCWA2lfUlT5U8PL1Wdb4oJQ1hU6aImfwG0/toZhKN2nR0MkQ0yh0T4BKxZ8fYIMq4K9NcGpEWaEfrMe1dK3oFTLDF4emS75RHGWkIjQ3yOaFtr6UCHAVp5xi6FAs4caxLHswknQA8vBxT/gbVcHYMDdqr70aHUQSEblfAs5oKV3m7oKsXN53E/ioJJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Fri, 9 Aug
 2024 15:26:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7849.014; Fri, 9 Aug 2024
 15:26:25 +0000
Message-ID: <b6f28434-01dd-4ad2-9fd6-a088be21c8f9@siemens.com>
Date: Fri, 9 Aug 2024 17:26:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 1/1] PREEMPT_RT: enable isolcpus feature
 set
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20240808143104.542740-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240808143104.542740-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6019:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b29400-a794-4e9d-c74d-08dcb887a1c4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?a0syd1ZjSk8zMkxNVU1xaEMyQjhscThYWThpYjcyZ2hzVi9valExK0JDb0wr?=
 =?utf-8?B?Tk5GSUY2LytwSW5CVThieVVHOGhkN0hHSndPaXJpUnNSbzZxTlNaNEZlMjFm?=
 =?utf-8?B?Mm5MeHBNL2sxamdxL2Z3NDN1WDFvK2dBVDZtT3NTd01nbmE3ZzNzT3NIZzVW?=
 =?utf-8?B?dVNzZkl0YmNLYnJpV1Zsc1R3R0NoekJLZkE3Y29SN3BrbERLcURTT3U4dEpk?=
 =?utf-8?B?RUl4Q1cyRW4xRlhKZVlZdGpVWHZEV3pzRGR0OGtNYUVadUhYTmpicWxNcWlm?=
 =?utf-8?B?SzIvaWNrUXpNU0tlR2JWajIvK3czWFkyN1Uzd1l0bnVhbzJERkxLbllJVjNG?=
 =?utf-8?B?Y05BRjV2VStIOVBnekhSSTZvb3JSOHkrdzFyMVBKZHY0S09OZ3QxdEZkNGF4?=
 =?utf-8?B?dWVlaWRZTkFINWNndnlJV2g2UFVjOUJPUUJsTXRSOTVEODJISDRTRktkQWx2?=
 =?utf-8?B?Y2s1bUZ4c3NxRXlmWE5CRWQrVTFBZGZ1eGhRNHkwdWVqaVh2OU9KM0RSNGJ5?=
 =?utf-8?B?QVdSR0VJV3I4WTl2TThLUUxjQnRJdDg1c3o2SHhUOXJTYmllSWdZN2laYlFV?=
 =?utf-8?B?bXh5OG5FRnhyUC94cmJwQkdHVUp0ZE1mMlorTjBDSk5qZjBiZVN2SVNtdHhT?=
 =?utf-8?B?akR4WGl3REFCU1B0aHNRSlNOYmhJRmNVRldsbFpCR3c1cHh4amRnSGhTT1Mz?=
 =?utf-8?B?U2lnTStuU3ZvYWN2blpCVzNsYmxaYzc1cURXVG9JNDJjczdHOTloUzdwaGY5?=
 =?utf-8?B?UjZuOWVXSlJZVHNCSnAzNktiWnkvYU51Z3dOemxPZzI0NzF4WVlyU2N3TC9m?=
 =?utf-8?B?MDVVMlhTL3FnSit4a0RDQXpURmJSOWJlNk4vNDd2cWhIcUhBb0o2UUlvLzV3?=
 =?utf-8?B?SlRVaHA5VStZTGlOeE96S25KUDA4WHhaL1NrWnJ1VGMya0h5VTRGNnBuaEFG?=
 =?utf-8?B?ZUxUYlhKTE9TRDlRcUVJOVhuYk1nWU9IUWdFWm9pQ2VHSno5OVlvY1NPRzdX?=
 =?utf-8?B?cmNEV2lzanJyTFdLZ1IwTUE4aEhITld6V0x3MnVLUjhjaWZ4bWNiTDJCNlZq?=
 =?utf-8?B?aDMrdDZTdmp3S2pzbWlyYm0xbmcrdUNkQ09PcjQxWkV3Ni83V205UWJHWlpq?=
 =?utf-8?B?d0pHQThhSHF0OTZqaHZFVjBDTFdEWWx2MGp5M1Mrc2htUDdIRzZXalFSanRR?=
 =?utf-8?B?cURucDNDYVNmbHN3T09pVzdDVmZ0QkJYV284aFJWLzRaUFp6dmVpQy82c0d5?=
 =?utf-8?B?czlLYkNLbzZBZ3NFemFoSldEa2trOTZXT05Yc05uQ29PTkVLUUROczNINmV0?=
 =?utf-8?B?U3VkakRlczFZdUpmNUhWSnF4QWQyMWFsVnA0K01yWitWanpxUmo1ZThTdStv?=
 =?utf-8?B?SFhIZG8xZS9vVnhhMG5wMCtXZUZSQlFHM0FiRmgrZ3NVRi9aYVZXT0FlTjdu?=
 =?utf-8?B?cURGNHhTT3BWeXhuNER4b2RCVE54VGp1WjFKTm5SSkhhNk84ZzdNWjQ3R1I0?=
 =?utf-8?B?bU9DN21yYUNGK044ZXA5bGdXaW1lc0lkOGcxOVdGZEtvYkhCUFNhVkNlOGZS?=
 =?utf-8?B?OWt3TWphSUJnRmVWOWZOOHFJSit4M216TXo3SStDZStPYUFGSEFVdThFZHZq?=
 =?utf-8?B?UmwzUG5BeHlxMkR4djRVQXBoalA1azAyK2pkRVlUQVlTd1VNNC81eEJqZWFz?=
 =?utf-8?B?a0pDV1ZNQURGcWFYTmoxYWNnbEhrMmVJREh2YlFvbEVSVWtYU1BMQVcrWEV0?=
 =?utf-8?B?UUt5NHJqRTZCbTRhSjJWSExqRUhhU3dGTTJ6T3k4dWZpbzcxT1VrMUpiR2dw?=
 =?utf-8?B?c3laU3QxVXZGeU43TlVIdz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dmRWMlUrRmk2N1lGOHRIY2J5WnZ1Z3hwcHVDUkR2dnJZZTRCU0ZLY2NqR3Ji?=
 =?utf-8?B?UEhocTZpWjNZWnhKT3FDRDJpcFdaYmtKK0FsdnRJTE4wci9sOEtEb2NGd0tP?=
 =?utf-8?B?TzNLODB5WUllaGNPYm1VN1c3VTFmbi90cWVIVXoyZk5uY2FTalRjdVBBby9T?=
 =?utf-8?B?YW5valdNekJnNmRyeFhoMSt6emZtelhUdEgxaU96dGdrNmV6dzFGd3gwMnIz?=
 =?utf-8?B?b01OT3hteVYxejFkdmVoT1RxQ1dGSUF4SVZxbUI1ckp6WmVJU29tYlJFMmZS?=
 =?utf-8?B?a1ZWUHMyZnFkSlV1RnJwdDZQOVkzckRkZkZNSzBwOXRQOXgycWxRdkppR1hL?=
 =?utf-8?B?K2ErTzluOHhPZ2c2NDlUaXFLMTNUbHR2ZjZMM3VHa0s5UHh2NEIrbDdFdVZn?=
 =?utf-8?B?elBJVXpZbmp0VjZVOHp2UXl3THAzdWl1eVhqRWlEWW1uZGhIeDNscERkNW0w?=
 =?utf-8?B?K1NoSU1zU0JRcmNYZzZyMDRsdGN4VVBSRklVa1IzMG03Mjkvc0ZHV3pHdmhU?=
 =?utf-8?B?OW5oYkpkUUpiV2R6V202OHJUcjNUb2pzTmYwYVhSejg0d1dEeWlSM2RSTGov?=
 =?utf-8?B?cytGYjhtZ3VEaGdGbVZNajZGSWluVXlRTElvMHJKdll1aTZGeE5pcEx6eWt4?=
 =?utf-8?B?elJMVWo2VnVTRmZvTGR0cTJjS29uK1dNaWk0K2t2RnlXVlA0Smh2eGJOSHZE?=
 =?utf-8?B?QmNKbFFPcGYxdG5WRlZrODdYR0R1OTN3ZzVPQW9Nc0g3SEZRdFJDdStLZjRQ?=
 =?utf-8?B?Mm5Tcmg0a3A5N3dsYmRBZk12ZVRTa25yeGMrYm1BU2FFbzIxeE1SaXNrMjd3?=
 =?utf-8?B?cWJ2dnJoQzZVd0UzNUNJbmpSYm1sMjJ0VnlZNVcxLzR2b3ZrVXlwdWlwd0Q5?=
 =?utf-8?B?ME5WYXFTeXM3K2Zmb0Fra0pDMlZ4MEVnZGJZTi9Mc3RzLzFLN3p0c244eFkr?=
 =?utf-8?B?N0EyMnpzcWRtSVdJeFdZK0czbUY3SDh4TG0xNThWY3BsQVhteVpjTHQzVytk?=
 =?utf-8?B?cGhrUlpTZ0wxb0dJM01kZWNHTWU0VFQ4bEpwQlBhcnlaVE03LzF6N0FqMitw?=
 =?utf-8?B?TlVjQjhicHZQVlZOclVOMHNKUnNHT2IwSUdXNEx2L3owZnlocENIdFVKNWJC?=
 =?utf-8?B?UnZZaGFhYUt2WE12RGlwRW1DSGo5cno5aUdQNENqYXk4dzdZeS9uYVdGMGZI?=
 =?utf-8?B?alFzcTRheElwYlpoVXhCNWxadXN3cHkwK0kzSGxOenBHUFk3eUZSckpMQ3lZ?=
 =?utf-8?B?MUd3alFGemZHcFJkVTVaKyt0dnJ5RHhqWXFPS2d0YTNNS00rRGpWc0ZmWWNa?=
 =?utf-8?B?Z3pFbHJTZlRYbUVIdFl1V0xqbVhRUFFiSUZJQ2c3aHU4NUVQaEJ3QmlPK0dz?=
 =?utf-8?B?b1paOUFDZFhzZk1JdCtLQlJZR1AySWR4VHZrUXRsUWVOdU1YdlltQldWSEl5?=
 =?utf-8?B?N3AydUxvM2JwdEY5L2NGT3JDeklISC9RWGhEMmE2UzFPdlZJM0J2bDlNT3Vu?=
 =?utf-8?B?MUQ0S2lWYnBKeGxHcnJVTmFPTkEyclhDcHJXVDU2RU1OWEhkUFh4Sll0TkVk?=
 =?utf-8?B?ajYzcjBvcUV0MWFHUGl6VGxQMyttaVIvb1BuRjFjdzkzbHlHK0s4aE5qbTdL?=
 =?utf-8?B?NStyNVE3TFQ5a1BGb2lCN1F1a05aNmhUMFd1QjVMZkdVZHhEdU9OQ0M4TG5B?=
 =?utf-8?B?UnFDZHBUQWh5TnpUZlJSTGI4d3A5T2FOM0VEVnRMMmp3SUJWV1NkUzU2QWsx?=
 =?utf-8?B?R1ZOVnVDMnhMcXlNNEJmVktyVVM4SXZMajBSclZITVM0bHBFSDkrUHljRUEz?=
 =?utf-8?B?cGlETHRvNnQxV0xBeTduY1E5K0RvUUpYY2J3TFJaT1JDdWlVQ2wzdHFrbVBs?=
 =?utf-8?B?eWNRWGpidzNPbEU2UVdLZUVoODExRWFBbXNQbU9GSHNDWEhVaTVlTEZMazJq?=
 =?utf-8?B?VUFhdStCQ1NsWjl5ekl2OSs2K3ZJWktHMFg1NHkrUmx2dDlITUlIeUN1OHJy?=
 =?utf-8?B?SXp4SFJvMDVhb0JpOHUwczN6RFVuZWFtWnRmM0hUSEZwS3AvRERxRHpXeGdN?=
 =?utf-8?B?anc3M1VCUjFYaWdXUHpvOGp5T2tYNHErbVBENVFtdEV1SzdHenhCU3FpZFNQ?=
 =?utf-8?B?SzJUbzNBbFdETE5WbmY1T1c3VWtxVkVIa2Z5T0tRUFVLdERCYnNZZlVQVDd2?=
 =?utf-8?B?cmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b29400-a794-4e9d-c74d-08dcb887a1c4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 15:26:25.4827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z2vyo1RPekzpc9yg99MNW2hMy65sU1LQvN8ojAMBLJPcoXp+/xwr8rbNB/zgbWBgtqWmKbFN/kzVOTo+lLHTNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6019
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Aug 2024 15:26:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16765

On 08.08.24 16:31, Felix Moessbauer wrote:
> The current cip-rt kernel config does not enable the isolcpus feature
> set. As almost all current rt deployments still rely on the isolcpus
> feature, we should also enable it here. It anyways only comes into play
> when setting the isolcpus= kernel cmdline parameter. By that, we just
> set the kconfig option CONFIG_CPU_ISOLATION=y for the preempt-rt kernel.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  recipes-kernel/linux/files/preempt-rt.cfg | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/recipes-kernel/linux/files/preempt-rt.cfg b/recipes-kernel/linux/files/preempt-rt.cfg
> index ea37556..afbf53d 100644
> --- a/recipes-kernel/linux/files/preempt-rt.cfg
> +++ b/recipes-kernel/linux/files/preempt-rt.cfg
> @@ -2,6 +2,7 @@
>  CONFIG_EXPERT=y
>  CONFIG_PREEMPT_RT=y
>  CONFIG_RT_GROUP_SCHED=n
> +CONFIG_CPU_ISOLATION=y
>  # <= 4.19
>  CONFIG_PREEMPT_RT_FULL=y
>  

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


