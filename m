Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C3BC3DA7D
	for <webhook@archiver.kernel.org>; Tue,  3 Jan 2023 16:55:12 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.77])
 by mx.groups.io with SMTP id smtpd.web10.69163.1672764909005708158
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jan 2023 08:55:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=GGQyB8uA;
 spf=pass (domain: siemens.com, ip: 40.107.241.77, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6hL7bnKJ/EqXQVnP6QHxycqMTx1YOdphdgmNCeZkMh5X3ODVoTAieYelWyk22ONZH9YRy0/JfPEuAVnig22BGitaXvu0f9CUiTvjw0nD6/HXBWWHnfDas3onmO/EMoTnrWUHcMl8AA9ASqFABEZpn2uPCgKd7Ffd7vuaqowrDMdAaM+tvU3AkxGFdxwZgOCk1YAkyowChFfwBNihuqheX+ugszzlM1sGmh+qtRjMqFxzz3WW7V7OkluBKt46Lgu1dw6SG1jGF26Tmdtg5n7R7SzIyUwwtVuEsmiGJHjrpUOh8QgwQFP52PPNCya8rhyO095DU9oX/Feqi2Lf/sELg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJu427F26fDz6Gllap5F7+qkBJcudgGzet7jA1FVdtc=;
 b=XrXNOtnBJIBRjGs9dWF3dIpMpmaxuB7nCuwhRzue8t7juBiNKUyLw7pZR53PmUzHiKAt6V5qgKQLz0HWN5yeoJcn8TSC+MfPMazCEAgUd9MNmXeSU2xOmXdj94G+MCVZuMvQDexpLHf2q8aw69LJG+S7NN0WAvZd7kYGWldGDo+URK/ueSOHQjdjfHFyoyHwj8kL3OwOwbGKJxyWBfX5HQ+tq7ny2g6X6Fcpx9BVyF0X+AgDp54Atnsg65X4aHucojzwmpilQHwOLMPy8t+uvfB1r41CQxFIuwe32xlm3LrL3TOmImjy5Mync2HHH2IWoaacu50koTcPvlrk/Zy2fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJu427F26fDz6Gllap5F7+qkBJcudgGzet7jA1FVdtc=;
 b=GGQyB8uAbRVhh9MEb6nNCeU79GoRt5HzTJFUOf+2SBqJK0KnKX/bAyo2wupJmKtrAOIV83GJHgoqouWjkNVShsMJ1X2TE3OW9c2jBmFGOd3WJGd57yENAEviRQSRmTz02vwHBdj+09/ilKsfTgmd4cZiwjrT4BH0q4uXfejI1ej/WyNiTlwqvJvJTciU8I4EZZDtwmWx/isyw49mFS/jDR6KXbu8mm0jolFxuyXw8sqVbSEnCD2oQHR6kJZcjrkdoGeUVncfNnPZpk9OzfOXZXHOjF4Drf+OCXIcT0teKqohbh3hOLcpfAgMtZuGLt7tuS5I1Tw+xshRK9qqdji6+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7133.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:61f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 16:55:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 16:55:05 +0000
Message-ID: <99ab1f3b-7483-36c0-dd7f-f5ce85d96f3a@siemens.com>
Date: Tue, 3 Jan 2023 17:54:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [isar-cip-core][PATCH 0/6] improve root home moving for layers
Content-Language: en-US
To: Henning Schild <henning.schild@siemens.com>, cip-dev@lists.cip-project.org
Cc: Wang Jing <wangjing@siemens.com>
References: <20230102170818.17689-1-henning.schild@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230102170818.17689-1-henning.schild@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0042.namprd13.prod.outlook.com
 (2603:10b6:610:b2::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: e994cb45-bf0e-4da3-50ba-08daedab4379
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UjCxX9MgdzLcfmu7bsJJZ3xxIKuOZCL3kz+3LMtAOIFHsnK7D8cft+2BXVE9WfZshnQaUx355lsrourtWHfL1cFs0bdOiFUi3SZUrAYZQyivTnN9pUetaBI4S2zFFgaBh1g3S5W/lGB6n7qOzffg313uO5fV1NjticVwNeCZva+/F10WfNzZ5e1hf0PeZ2TE+65o1xhzrIVPBnuJOeOH2zXVfajF77dwNl85R+fhs14IWHK5AHgTD1NKumu1AJ9jzFOPKTmbLrl8tTcBuZ3Hm6Ooxu44DLHKTiPCNTBhWYvVro0B212vvUK4PrGcICziCaAWRvuxo5LnTvPg/T5fVKQXzWwj7vh0kc/6hXKEp5CpNdE2ii+qblY7TRTkesnIIe5Ww7MuflAc5h1IDiS6ewcy5PXHDl5nTsz4Wyl0sugRAWR52VuyDqK9QF5opyK+eNs02eA+g6fKTbQeOJcJAti4/suM2OY7E6bLbUduemrNQud3uGEVSjBzgvw+PANOrMR8vPbj52PaECZ9ehJQOeG9COwTHNNhztQqmP3RPCJa7tuDRp7ebiQHnEVyLEqj+V6F52j1TyF3e0n/KI5sXKO/UIGlN8Me170Nwg3spWx74Zi5ieFYx4PPZB5ZuXPvzvED9CUucK+6mkXtb4+ojRa8etBRfOkMJ1eIXFJ+Ja46ycapYrn9cnAHAF+Wuut3znpXUOt1mxAGd9R//h5bXUZAA6GJnHg8/yRxb6TF1kAK9wOnNx/cUPHfUVNXvqvw
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199015)(186003)(26005)(2616005)(6512007)(53546011)(38100700002)(82960400001)(31696002)(83380400001)(44832011)(36756003)(31686004)(86362001)(316002)(41300700001)(8936002)(5660300002)(4326008)(8676002)(66556008)(66946007)(107886003)(66476007)(6666004)(6486002)(478600001)(6506007)(2906002)(22166006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bnlVSXI1N2FoN1RuZDZZUGZrWThhU0hIWDRsYVlSMURzV1ZLcnFENGM2UFFo?=
 =?utf-8?B?bWg4d0w5ME44TzlTYkdCRHhidmExb3ZHRThMdnhTcHk2bFRXVThjSnFPODNG?=
 =?utf-8?B?cFdwZVJjU2N1N0ZHTDNvR3BOaVZrYTZEbkhzUnMxTlZqV093QzZ0YkZBZGRO?=
 =?utf-8?B?YlNMS2dlTmwwMC9rYk1FRE5zVHR6YnVQaEtacXZpeWpwN3NIdWZvYjlYQUVI?=
 =?utf-8?B?TnFjZWRhZ0UvUHRvS2FXRlV1TE1xUUllVG9zZmJ1SDlBblJnVy9OYVZ2aXkx?=
 =?utf-8?B?b2dWcnZxdEVQc0RQVi9HU0FnT3BtVEtKV2dESkdqMER1ZHFhckRrM1dTSEhy?=
 =?utf-8?B?dkg2NGEzTCtOTW8wSGkyTkNSdEZtMk83d3B4Ym80YW9PeUFJZjg0cDdQNjBG?=
 =?utf-8?B?M0d6T3NuR0dKZVZNcjZtMGsxVzdyMmtZYmJxNGpUVVFGYkdBckRrNWZkdk9Q?=
 =?utf-8?B?MFdCd1gzNC9mbW04b0hRS2FYbFZkcENSM2JSSVB1ZDJoTm5GNUxoSkMzM2Uy?=
 =?utf-8?B?ZU55TXVyMllGY0lKbUd4akNjTUVMVExyNUp3QjVHdWU1bFlHbHk0b3B3NWZK?=
 =?utf-8?B?eU5YL1FVRnVDQXh6Z2EyRTJjc096TmhwKzhiTWJtSzExY0hBRGdPOG9rM3dl?=
 =?utf-8?B?eVFFZ1FSZU1HSWZ4QkVPTXhxVGp1a2dqcHY5NWM2R3VhaWM2S0Yvb1d2OCtx?=
 =?utf-8?B?eldacGVOWXpXT2QvRkhjLzhjcnJ2UFBFU2EyanM5L3VjY3NHcFQyMzZmZFBm?=
 =?utf-8?B?UlE4ZnRHZFJteXNlRHRyZ1dmNXNqT1pXTmVHMmFQb2tUNGxNZ3FSdllGNlFy?=
 =?utf-8?B?OHp1dmxTdlVVYmY3QVA2TjRpOEQxKzcrWjRYR3A4RnJZdzFDNjc0M2cyZWZD?=
 =?utf-8?B?NUJUQ0VGdXhqZ0IyOHhsUzZlaWlreThlYm55czZKYTN2dDk0cHRYMy9ndi9H?=
 =?utf-8?B?ZlBkNWlsS3l1cGw4Rkd5cEpHM012aS9sZ2luK05QRzJvbUcwV0RBY3l5ZXQ0?=
 =?utf-8?B?VGRzbFdheWtxUVhrR3ljM1RtL3JRSnY2NTl6Zzgxa2Y2SHBpU0N3ejZ4YTEz?=
 =?utf-8?B?d2ErNnk0dUlNQ0JDcHpvLy9wSER2NkU4NGo1dkhlTjE5ZWxWZ2RNY2cvR1Bp?=
 =?utf-8?B?dUtpTVNTQU5kQ2RudFF6YTlZY1JBWDEyMXJNU3J4MzFRODlQZ3ZMZ3BkekRv?=
 =?utf-8?B?bThVUk5IRDlaRGYzQW1TdFBFekZQNUNsODVkZUJlakNRdzYvelpCRGFqL3ds?=
 =?utf-8?B?RXJQSFRjOWZLRzNlbmdVeUxjckUzNWZ2bmJWSjZIQUVEM0xxRjVqYkx6QWZ5?=
 =?utf-8?B?aElsbS80OFR0aG9TdHlDcXNuck5iTGplRVp4U0Rqek1ySGJCTlg1bzc1bC91?=
 =?utf-8?B?V0tac3MxK3E1UWVDaFJ1TEdBZndTbGlOUHdkQWdtbXNibi9CYTJ1ODBEYlJt?=
 =?utf-8?B?dktLd0xCTCtjTjV2dTZnUW9YRUhXakhFdUFFUGFwOGRsSTVpbG1TWG5XVWpj?=
 =?utf-8?B?SXZvdWNKcG9MQlEra2RDR3JCZloxRHFlWG8wYW45djFIbVlzM1dUVnRVaUdK?=
 =?utf-8?B?TTVYK1czUzZOTEJwTlY3cFR1R2lpR0FoajBSTi9vMFJkME1Jc3VtZmdWRDR3?=
 =?utf-8?B?SFVGeDRGTmtLRGp3cnNSZ0JyWmpFWGF2NFI0SS9vaTBYVEdWVWNMNzNNUlBv?=
 =?utf-8?B?b2dQdDJBRmJjclVqdVNicUZjSElJNjFvTjFxbFF4b0xvVHpjRTQxQnFUOXN6?=
 =?utf-8?B?ZmdZbHBGYmtpbTdjZzl5bWlKZVhTNW9xVEs0MmFRdFcwaUl6TnNYNXZWYzdM?=
 =?utf-8?B?QnRNRzQ0ZWFTY1c0b2wrRm5aUTVFbWxCZllTWTJ2UE9oQ3FoaWVpMnFPcUNL?=
 =?utf-8?B?aWJRVzVXWFFaZ1pUeXdsaUVVVFJjRzlIU1U1UkxJY09xMlVmaDd0aDVDZ2Zw?=
 =?utf-8?B?Uy9DcHVucVcrQ3c1c0tRalZWc0RGOUwwNWhGQlJ0aWVVRnJEWmo0cHk3NUtl?=
 =?utf-8?B?NzNyaHJEQlZVVnZFOEtsVVo1aEo5Vnp4MnA3eDk1SjlHMEM3alNXM1llVWxz?=
 =?utf-8?B?MEt5bFI2VmNPa2xIZC9jZXd2TzE4MHNZbCtIeXlCM3FMK3JlNklSU2FmeTZn?=
 =?utf-8?B?SGZQN2kwVEIzcWRhQXBYMmU1ZzIrVlA3TXJ6bWtkOEx5OWY5NTE2ZFhsQ3FF?=
 =?utf-8?B?YUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e994cb45-bf0e-4da3-50ba-08daedab4379
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 16:55:05.6060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xMKdsm8hkjWH8/6o27WnE7Shw0SkSNXpVaJc873oMvrn1SfvCA5zw/43K8dvc1hgdKffM6LQZcUUfQRr1t4fYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7133
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Jan 2023 16:55:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10289

On 02.01.23 18:08, Henning Schild wrote:
> still v1:
>  - this was sent before but somehow did not make it, no change same v
> 
> The original idea was to make the rootfs home dir move and symlink
> reusable in another layer, while also playing back some findings from
> that other layer.
> 
> That is p1...p4
> 
> p5 and p6 are drive by findings, feel free to pick in any order i do not
> care about them too much
> 
> Henning Schild (6):
>   CONTRIBUTING: fix note on patch prefixes
>   customizations: make postinst idempotent
>   customizations: comment why we can not actually change home easily
>   kas: set clear text root password
>   customizations: make postinst script report all potential errors
>   change-root-homedir: split root home move into own package
> 
>  CONTRIBUTING.md                               |  2 +-
>  kas-cip.yml                                   |  4 ++--
>  .../change-root-homedir.bb                    |  5 +++++
>  .../change-root-homedir/files/postinst        | 21 +++++++++++++++++++
>  recipes-core/customizations/common.inc        |  5 +++--
>  recipes-core/customizations/files/postinst    | 10 ++++-----
>  6 files changed, 37 insertions(+), 10 deletions(-)
>  create mode 100644 recipes-core/change-root-homedir/change-root-homedir.bb
>  create mode 100644 recipes-core/change-root-homedir/files/postinst
> 

Applied all except for the last one where I had style remarks.

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


