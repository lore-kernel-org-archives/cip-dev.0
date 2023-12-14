Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C8DC4167D
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 08:11:26 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.42])
 by mx.groups.io with SMTP id smtpd.web10.17355.1702541485453266940
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Dec 2023 00:11:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=QurUPS7P;
 spf=pass (domain: siemens.com, ip: 40.107.21.42, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCHsRBuvkFYuHyv9LT1uMj6wVX2o3EqzxtEL7AEkQ7bJEHRE6D/5+5kYTgPyiAbSY0se7GkuPS7qNQXTlT+XPwgzIbcfeAqikAjQshTAGkyh6nq6yR6EBQ3mNOzUszAC5QI6b1M5/otjUMp7iNLyz8/nG2HDrS2XzOGODLUSqBEHfxSTaimh4fRJKn2MmVdw84c6pkTOI8k6aclYnx/FCcohavXylyW7B8xBwq/KZhH709z+XW3mW9upKUn4QmudjK/LgDGah75PpPQccDetJG4/a4JtbwJHEwY7zSUTQUUo8f443rX3qKDi+yKqjwtxcEDeNWqdB1wvp82EXlyBIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykT2Mu3oOeyE/gI0SjYm7QEKm6ThLjASH2yi3hHqCV0=;
 b=lDS60x6oSv0Alqpe8LOkZcPv+BoWTX14vKvhoq6PRfCjCKDnezl1xzNEiZze3l44PynkU2tw71euYwCo0ikXKgHnv4uM6R43WVfeQKkNfIMOFJoJ35XPI7meTJXb3cEDNBwir4KBGhHLdPYxeoulNDhRP+0S0vFacqgZq/2M0gHSYxuu0ZbdiyooBLP6NMg7sGUs+4tb4VrsgQSvQpP9D74hK0U6uebtD7UNvumex853JT4cLKZ+GUQWCG44ffRzbkFgDUIiozw1NQLYSlPv+EEDlTINLawK+lfB4QG6l+HYxZgVk5UAAvu/W0h21+/l9EjL3WFSN1esJHoIUbEaxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykT2Mu3oOeyE/gI0SjYm7QEKm6ThLjASH2yi3hHqCV0=;
 b=QurUPS7PevUNoJ02MNMCZ1Tr+sdfv7U+2MaBPk45pVgffasaaMFKo0KKJI3rhIcW5Jnsnw0Tqr0uurj8vgy9vKcXXFD5x1LCnIh4oBHtPOr91wYxOc/3OpGYco9PD93YGAyveNVB1o5AvL2dO0op7OIGjaEglVjCVVxdC3oYLooamtkPwHcYQ3CD01yitfRhkYbKa/SSkyumht3IADTfNT0UgnRxl2Wo6HMflcUeBKWL3cV3jSct4hgRMtBL7MZgQyS3rnq5dIAdN7MymUCP57nK8IqtUtUwIem0P03679jgZjBOGyEUdZv2FQCiG8EffJvNjY0E7QEmG4tNGQ40fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by GV2PR10MB6235.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:7b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.38; Thu, 14 Dec
 2023 08:11:22 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a40c:1061:b15e:cbde]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a40c:1061:b15e:cbde%5]) with mapi id 15.20.7068.033; Thu, 14 Dec 2023
 08:11:22 +0000
Message-ID: <f0838209-19f5-4e0c-941d-5c61822c7593@siemens.com>
Date: Thu, 14 Dec 2023 09:11:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate-certificates*.inc: Add
 missing FILESEXTRAPATHS
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20231212141556.1616031-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231212141556.1616031-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::19) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|GV2PR10MB6235:EE_
X-MS-Office365-Filtering-Correlation-Id: fae73770-315d-47b2-4df9-08dbfc7c422f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HPirUgCgIoxPRxvJi/nCMB9Q4PKQ5nC9K9AYY38NmlDnpnkP8cNlIjEp7jEM9mlVCR84l0tbORSBtw810lIktO81K7KKH7MlFrmxRYpjaOQhspzYWcWOWgR4O/LSeWPj8DYmq4Lgz/jDujMo/9dsGChwwBKYNEpJFnpFRBi1zbLWmPrr83/V5nSJrKDE+uzDx0+k7s84PhQxZ0prqpoSWLAFCiLRvGFVgQqXp/PGJG8vtp1u8Do8Kllc5OdVOxwHsOfKvgny4mdutkNmaiUcH/QcTHlN/+s9eIBkZoRXV4wRLU48spAt35ANgqYCDEWjOIeocH9HESD+2yFjfZLPUkGopfqTO4PtpaOx8yldUfhd3AJEHcUHhfzNepTesgzr7LK1wQl3JumzPwaGPeOmFGIn10KHYwK0TsL1otpLZM3pxnSarmb/XsG0b5MK0BqNyH8D+ssqjYqbI/YkOAQjGb6aXPO8bkicSNHHncjn1sEHvXqoDYbeWI2yUvePFlMAjIv57crqqPxrWNizb2Qlvq38CpbgrqBDSjwLosrVUtEOwAAx1ujt60kNxL6vLx4C+VNYrFz+Uxqxxrf/K2OwuPgRfkJ34aLGHPSsVq4rWwozJT34c8Os++61jiYVE8I5r5xL1yaxTpOvQ7hNXNfWoQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(396003)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(83380400001)(2616005)(6512007)(26005)(38100700002)(8676002)(8936002)(316002)(2906002)(44832011)(5660300002)(6486002)(478600001)(53546011)(6506007)(41300700001)(66476007)(66946007)(66556008)(36756003)(31696002)(86362001)(31686004)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UU1NNDN3U055VitDZjN5RFBjbklrQVVtQjhwWDA3TWM3TnpYQjcvRmFCK2lj?=
 =?utf-8?B?NnY1NGdNOVhnbFRZc0dLdllkYWo2ck1oWE14MEZQMGVFWHhpMG9KekxjY1R3?=
 =?utf-8?B?dWZOaGNUOTVkN0pQS2ZKOFBZSDVFWGgzeXFPUjI4aTVmcHllNklTNHNZYisy?=
 =?utf-8?B?TWdQMWhCMjAzTHJUUE9nanBBL2tkSks1aFBKZ3JqUHdRSitHVWgwSnJvMlhE?=
 =?utf-8?B?Tk45N1RmTFFJSngxaWViQ0ZZK3pxZXdnUjJLZW9GTzhIRzVJWFNWM2pnNk85?=
 =?utf-8?B?U0U5WG1rYmNHcFB0WnlRaCtTWTRTdmNKOVBaaWxCai9LQkE3czhxTnhTVlNo?=
 =?utf-8?B?LzBBUmllbER6VEVVZmRCSVVhalY3UTkzRDEraUFYaVk1TDg1N2tRdDBrYXFn?=
 =?utf-8?B?WXg0cGZtYmM5ODJCV2d6Y3pGUUdnR0Z4TE5EOUk0UVQvVUxJVTMvL05HdFpl?=
 =?utf-8?B?aGJJN2tPbEY3SGRkbW1mclhmT28vYVFrb1FPVm1iREtXU2t1MUJsdlFxc0hZ?=
 =?utf-8?B?ZW1Ecm45QlRXRmhwSFMvL2dSS29pVksxNEhzQS9KMHlNcW8wSk5Tc2JlYmNu?=
 =?utf-8?B?bU1VYlJCeUNNVXo0UGpGMTlieDQ4a0o0ZVBZUXRFSWRPYk1zbHlzV1pyTEFu?=
 =?utf-8?B?RlpVOEliUjdXSnorVjVBVVl4SEpwc1M5Vm1rTnVrR0Fra2g2cVdvVVdhV0h5?=
 =?utf-8?B?TmRCblRNTkg5U3NUSzQ2eUdNMnVWMzJYemo0V0FVSlQ1VlBnNlJLRVpLdGJK?=
 =?utf-8?B?OFVTNGplNUw5YnA3NnJuN1RTemp6Q2ZqSG93NGd5bktJa1RoQW02akFCUHls?=
 =?utf-8?B?dUdsUlZ6VFBXR1E4VXZuZTFPeE52RVNWVWcrOTlYQWR5N1FLMXliMWRST1BT?=
 =?utf-8?B?WG9vL2kvWk0zdTcyUVlZSEJmL1pWb0dycW9CTmlLRGVDTjh4aWJoNllQRzVu?=
 =?utf-8?B?K2t3U3pHMGtuLzNnUU9VYlZ3eUI5WXNZSGJMRDVZeFhYK2xYdU1vU09aS3k1?=
 =?utf-8?B?VS9BalN1VHFJTjlUTGRoSnNZRzFuQW1vaUpJaHdIQWt6VmhxVVhPL0RGaEhJ?=
 =?utf-8?B?QWdZWG5QREZldDNXeXJPWmNoUkxzek1GK01wellMWitZMC9XMHJrbkVUT1Iy?=
 =?utf-8?B?UW1BU2hqVFp3VmE3QW9GRmJRb0FMV24zRUJYV0E2N09RSGpHVGE4bHZRZ1do?=
 =?utf-8?B?YlpqZWJUZ3BaZS8yY1NYRVRiU0hnNXNYYU9NZXhTRW1WcWZOMlpOUXN1dC9Z?=
 =?utf-8?B?K1gyQ2kyRVlCTWdrd2w4dEJyd1hpY0RyOFRvVTBEbnBtZHVjY1NMMGZMSnlv?=
 =?utf-8?B?dXUxUXZNVUN4MFR0Q1h4R0dPbEppUzVRTlRVL1hHMGxvYXBtYkJ2eWxxSHhw?=
 =?utf-8?B?ZktOZ3FuRG1peFIwK0lueUZwYzJpTUFzOUFaUEdvbjVwTFZZVTNDVFZzbkNr?=
 =?utf-8?B?WXF5U2pwWndRdStMMlNST0VWVzFkcjJEUUlPZmd4WUhQbTAwSSt1TUFCbzVP?=
 =?utf-8?B?WGQ1cjNBVE1EWjBBVFFTV3RTNFo4OUNJR2RxS2dLU0Y4cUlaV29nNFJhek5D?=
 =?utf-8?B?UzJLbkE3R2RIYlVBM1piRnBiRCtHS0g1aVNkbmpIVEJsS1VuRlAxUWdEait3?=
 =?utf-8?B?TXp6YkZpWUUyUTdSN2s0eStMZ3JiVGZyY2pMdUROSTdlUzhNZTNTWklWc2FJ?=
 =?utf-8?B?UWhUakplSE5zakxLUnQvMWJ0UklSN2pyYlNZZjFXdjZwTWhKWEp1dksrRzdE?=
 =?utf-8?B?TVNkUVdUYWRBa1dMM3hWM0x5Y1JRZXpmYlh4MGQ3cFFKbHZaK2Z5czVnd2l2?=
 =?utf-8?B?MzBlTVRHak5YbW9odFJUbDFHUDV6bC8rMjk4cjNJcVMrcitkS1dndWVCMVlX?=
 =?utf-8?B?ajA4Y0I4YkpoRnhWQm1tR0oxM0pINlQ0aWNOVStxV1c1U1R5aHJzQStNM0Jn?=
 =?utf-8?B?cVJXcUlBWG9ETlI0Z0dtcXlicXM2d0JBMjlTZUxuUWVTWkhxanE2bVl4WDJD?=
 =?utf-8?B?NnZVZmFWck1tWXdPaWFFemRYTHh1YnFhb3dCSDhkNjA5K29DRFY1V3FrQThz?=
 =?utf-8?B?TVVxNG5mOHhBeEQvdFdLSWVXT1gvU2lhTUgzTkowTjl6Y1pOUEVzOS9ReUR3?=
 =?utf-8?Q?Du+H0Hln/jXijARV8eHbw/jHx?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fae73770-315d-47b2-4df9-08dbfc7c422f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 08:11:22.1001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FoVOfAvF5wDnpUuap3g7xmugDqmWD0ZH2yoXNtzrhMbfkMdRCQf40DFM3UbBqjqGM3u8Fpudjmfi2/NYHqs80Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6235
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 08:11:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14089

On 12.12.23 15:12, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows to include the files in downstream layers.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../swupdate-certificates/swupdate-certificates-key.inc         | 2 ++
>  .../swupdate-certificates/swupdate-certificates.inc             | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
> index d3d2e16..2c67e89 100644
> --- a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
> @@ -11,6 +11,8 @@
>  
>  inherit dpkg-raw
>  
> +FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
> +
>  PROVIDES += "swupdate-certificates-key"
>  
>  SWU_SIGN_KEY ??= ""
> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
> index 6673383..564dda4 100644
> --- a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
> @@ -11,6 +11,8 @@
>  
>  inherit dpkg-raw
>  
> +FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
> +
>  PROVIDES += "swupdate-certificates"
>  
>  SWU_SIGN_CERT ??= ""

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


