Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7B0C64ED6
	for <webhook@archiver.kernel.org>; Tue, 28 Feb 2023 09:21:07 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.81])
 by mx.groups.io with SMTP id smtpd.web11.19442.1677576057946369414
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Feb 2023 01:20:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=opDBW5bJ;
 spf=pass (domain: siemens.com, ip: 40.107.14.81, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VsBrcjxVlakTBo1WbP3NJXuTfvOoS6CN61abw4SiisA68Oap/lstcFzhXqTRQkI10RB7y7N6YSNvNx+AoXNWmrdl8EWXjVeyTCXHbxzGZ+lu1gk4buaVD8vxNgSfveuTUWqyHLK+HqA6xeYcSODlgi1Pk/V3p6owT98LhlTHRUcV9g7oC8jXu4vvfdABDL0g/IDS5bYTQKwDuJq744MtWDwvKmDe56QstK6XIOurkiZOuMp6CXE1Pr4sDQ1XpEFr0zW0R3DcPioO4VwdT8N3sSSHMJ69Ado+GdvQVmwuPnTBx9w+tdMVoa96tM+U1BURoTuk0ZWpy1ywaKASY/uCIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NigeASH8khMLDvbBnF3pFG6swFPfp3ZrYXenj6DTFZg=;
 b=c8lZJqkFv2tzJWBYsI6Vy8ceYWHS+ccZnxsmQjlH06zJPllXmjbmUqbuDVZafmwuXQeFkLDGTSg9eOB2f/9jXu0oN41rktegy27qT1aWko5zPLq6SUxcCX2xN0egTO8MepjAXi8pZfnjeWdpL2xe+G9aNkenGGZSy3nWPpKuyEUmOEqpCt+GBI/EdOxbSlJWpliH9xQJmIRSsolVpfo3A5zINEUt8OHJPjLiZ0asWv7gRB8/jlnLJPpTUbLgO7Kczuc8eM3dPxiTmVUqEEYVn5xetuJydThvbv4RxiP58oRVJvr8KRAShw1g11STYGNip2YKSZasR51gPWrbwG8yvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NigeASH8khMLDvbBnF3pFG6swFPfp3ZrYXenj6DTFZg=;
 b=opDBW5bJc8uPfu4fKDt1o76tTg+2NgMF+TnagNu/9U283UH3x0zW67kYuwGx5cuccX7h25A1WFl7ZFjmqGFzRxXpMs7OiL4P1kiINKGhd4zszuK6qTAil9Y3ErQdePWH1Us/lElp+msuavo/aASMnVuUQkL5tW1jzfZgyQQyc1oIwHn1biycs0558j3AzyexuiHxT17uq8TqQFxRhIDGLAliqDjVF3to89hzamAru+1bG2qdKnXL7NVlG310wIHPO6ni5iTGXFdz4bAhASIwZ1os4j85X05uHNLYh4LvnFPA2khIh3tjIGbhi7y0nsJJJA+neO0YQDre2SD8YrMeRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB3PR10MB6810.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:434::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 09:20:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 09:20:54 +0000
Message-ID: <9b75d165-3fef-f2d8-2d79-72e952aec8d8@siemens.com>
Date: Tue, 28 Feb 2023 10:20:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: isar-cip-core: Heading for a release cycle
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
References: <56d6a637-5654-7923-4f47-e76b554d578f@siemens.com>
In-Reply-To: <56d6a637-5654-7923-4f47-e76b554d578f@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB3PR10MB6810:EE_
X-MS-Office365-Filtering-Correlation-Id: 443ba199-1c28-4bee-26c1-08db196d17ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2FjLv4jLpjxJpRnQZiwWA3Rp8PlzHnwgsWgtde7S6XR7E1U+qe6OmtO9E/MhEjxwotdzNX7PQ2boVCX/xQ27EF1DxdswpW9KZrDhBy1dTGQj3LFvOT1RcZOQFTflC5f4mK48aWlxS5PMSR64aXSR3bG7Ttl4TWceXcPTEZfMRwCzSEKW489jKhDBlHTdBAa2AcWhL+iIQ4rdZgD02QsiNmOOgOk3kxby3rYSBsyiwRKb5JrfW9OjmNp27yEidZ/111xEVKAyo75LobFKhvWrTiN5eHBkuuDO1/Fe2jqah9uXBresBA9pM8OqAN3QXROhQ7vR/XpjdymGny4Ei/XAuSaVUpsrxb77dG8CmXTVdPVmdJbL2WCt3sRuJJZxCfE0IG+bvzND6fwoU1+PT0g/65aOMuimAS2/+8v7I58O30hDQFZjenyjSdvbbrjxOTlroc7KJW1tZ0sZmgwuYqiu2uNCreXTVKAU+YBc7aZY77p58kebfTo+evtL29XRfienKhzuALdEwuR4aFFiXsl2oW1YBca0adQFJhKSEWGAbz11axGwLUv9hPyqOv9EWhEwooCiNRfCI7f6JK/YXIvxoyEiHOb+X/Te3GixYoPiyj4FC7+8oAVL30yDWtx80Flo0qWNDnDnWH3nkDJebFtzI+MboT/3oyfJzJ/ABDWEISatfchGoxnSnsfDQR/gQKwF5cl9DJOn4j6zW784mOfHzs+iS0uIPg+3faVmwQ8vmI2kBJ7pV++ZzBuhfS4uW6iKrZqe25fZ+acjM+IlDW237KLfYNfueo1vFf2rxhlgBzc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199018)(38100700002)(82960400001)(31696002)(86362001)(5660300002)(8936002)(36756003)(2906002)(4744005)(44832011)(8676002)(66476007)(41300700001)(66946007)(66556008)(6916009)(6506007)(2616005)(53546011)(6512007)(186003)(26005)(83380400001)(478600001)(316002)(6486002)(31686004)(66899018)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N3NYd1ZubGV5YmRLOStieGprenV0b0QyQnU4VDJWQUF3YU5JVXBXTEc1cVlj?=
 =?utf-8?B?cU00L3V3Yk1sWnZyc3A2V1lxRmZ5d3RadDdwVHJ6MitBQmhScHFlci83bFJt?=
 =?utf-8?B?T3dhS3RUZnVFemk1bXpraGQwV2NuckZYMERjSG5WTHBRaWduSlJ4ZVJrMm1k?=
 =?utf-8?B?RWlIOTRWSExhNGgxdjJYd25lMmlFeFdGd0JxYWFycGhHSi9lOERlbWhzaUp4?=
 =?utf-8?B?WmRsREJESnBGelc4emU0OUFZVnJYa0RFeUtEYVRUVG5UUWNiZzRBLzBqcmI5?=
 =?utf-8?B?QkJOb2xyMnZYOEcybjhTZTBnZnF2aWd1dkZqbTZORnRhK1dYVnVpNDE5eXFs?=
 =?utf-8?B?NFNHZVh2RHRyTVp3aHoxQVRrSFVMZXhRV2dLSzBUc2dVZEd2NmJteXI4M0Mv?=
 =?utf-8?B?ZlNIRi9CWXpyWDdGQzRSODFiNWF1YVZYaURkSmxlZDNNM3p6UGkrWG5HeC9Q?=
 =?utf-8?B?dEdSY28vLzF1RXlZRmdoRm42c1dhRVViRGdwRFZMdEEyUW1YUmRjazBjY09j?=
 =?utf-8?B?eWFZWllQU0hhOEF2U2lJUWRlNW9PdWtYTjM0UkZJUWlmV2JCT003M0NaeE03?=
 =?utf-8?B?UHhxTnJJVXVmS3BuNU96d2hvemlkby9jck0wYTJXNE9VdE9uNVkzRTM0TmVP?=
 =?utf-8?B?TzBQK1hIdXF3SVo3azU0UDd5UkVzazFRVHMrelZMRlo0SWRYeEVQaUtvd0o3?=
 =?utf-8?B?NEFvdE9EM1lpR3l6NGxwdkMyZ0dDemx2dnZjK2JLWENOelZycjNpMDR1SE0x?=
 =?utf-8?B?U01xbjlTS2d2elQwZmhSTUI2RW95aVJqNVJsTC9zMU00NTVYU3BkeEZXV1RS?=
 =?utf-8?B?WDcwSU95ampnb0lhZWJNdTIvSlZVYkJCNEJIb0tjZklNbnF4Y1gxNE1iRmZt?=
 =?utf-8?B?dzlpSkZCSWxQcXloQlBsaWs5L1M1clhPaGxKcDJFRVVHdkh2NHYzMGorTkdv?=
 =?utf-8?B?VE82cStXc0I4N21vdFNiRjlSVGQzRTNha3ZtdW55UE9BM3Y0NUh3OGxhMWxY?=
 =?utf-8?B?NXUrOFc0Yjk4TktxUTZBYmh5czB0aUtUZWZDdklHLzAwa1Q0ZUM0TEplbmhK?=
 =?utf-8?B?YUg2Y1c5NjNTVUp2Q3pPSERSbGRzUk43KzJnbnlYZzUvRmZNQ1dsQXVZdkQx?=
 =?utf-8?B?dWRPZHo3Z2gzbUJpTVk2cWFWVEhIRmVSTjBobitHeUxRbGtKbGhEUTk5SWVq?=
 =?utf-8?B?M3RCZlBldzFYUnN5NlRNalBJRHY5NE1NbjRNZi9rT1U4cFBsVlFXb3NTekpO?=
 =?utf-8?B?Tjl1UjQ5U1dXMzc4aUZxZXhYRnFnMlBlTW5VaWszampIWmI4UTBHV05zaC8z?=
 =?utf-8?B?OVQ3dVYvR2VzeXFYeWl4dWpSWlVvVGhCS2UwR0d5UXh2WGk2N0lGdkM4clR4?=
 =?utf-8?B?U1FtZjJtbDNGdzFIc1ZjRVgxcWlMeUZGZ051dDVrRjVkaE5QM1ZITmE3ei9s?=
 =?utf-8?B?U0M2Kzgzbnp6ZnRWbzZGd0M4aWJtdnNybE56cVMvdjU5emxCQ2tMTzM2djkz?=
 =?utf-8?B?SENVMmtGUzhMUmduUDJ6eHZmM3FHUmcvK0l3MWkzZUVXUXFwdzllYmhqZTBC?=
 =?utf-8?B?Q0ZueFhhRndzLzFaMmszdnJLYjVYUVdoelZsNkdZU3NuQUFQSndIV2FnaytH?=
 =?utf-8?B?OWhlWmZlZFhpWE1WUEZ5TmpFR25wRVIzL3BoSmlsNmxMNHFkaWl4enR2SVdK?=
 =?utf-8?B?VWp2N2UrSkxCemZoL1ZjdkFSb0NML3d1cTRHaks2ZXZVRi9DdzFyVTYrTWpV?=
 =?utf-8?B?WjE5RjRsSmdMTjFvb0pkdGRWM1hjYnBCbW44VFM4am5ZRnJkK0lMTnJPTis4?=
 =?utf-8?B?TktBdFZnajRqSWVkR1dJdk9KUnZjanl4Q2NhMEFKaFVBS3BjdWhSQUR3NFNm?=
 =?utf-8?B?VnV0b1Q0NE5zaWRxbFlTRk0ySUNWZnRndEpURFN6bFBRTEx0a2tNL0Z2aWxv?=
 =?utf-8?B?NVkvc24zVkRRRnlXdUtQSWZmQ2d2MkNOa1Q2Q1VDTENxeUFOL0VXaWpxcUlS?=
 =?utf-8?B?SWpzVEEwOEovRVE3elo5VGpsTGIxV0Y1MnBzeDFIUTRyN3I4SnFmUExFUkYy?=
 =?utf-8?B?aUMyV01yeE03UTZEa0cwQkJGMVlBUVN5MFZXMXY4MHpQeDZBNTZCOEN1VTZw?=
 =?utf-8?B?RmdtNWtOd2lKaW54c1AxU0lmbTJjMFo0Wngwdm8rZ3RCZGN4RGRRMndqV3pS?=
 =?utf-8?B?WHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 443ba199-1c28-4bee-26c1-08db196d17ba
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 09:20:54.6087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EIpLQuswjsCGwi0ccZGCjuQHIe9pLQgy4EGBtef1jORMXKr1atG7cr0fLUqlXvoalBvJyUzW3RiWTaynEoBkJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR10MB6810
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Feb 2023 09:21:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10864

On 31.01.23 10:38, Jan Kiszka wrote:
> Hi all,
> 
> at least some of the isar-cip-core users are in a need for formal
> release of the layer. The plan so far is to follow the Debian
> point-release cycles, means basically having one every 3 months. First
> one would then be after 11.7, likely mid to end of March.
> 
> What all that would mean for the layer recipes is to be defined. Already
> clear is that we will offer snapshots of the Debian package sets via
> snapshot.debian.org as build option. Beyond that, I plan to declare a
> feature freeze at the end of February and only accept fixes before the
> final release.

Reminder as it is end of February now:

If you have any features to go into that first isar-cip-core release in
March, please push them now. I may grant some extra time till the end of
this week, but that I will feature-freeze.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


