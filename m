Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7DFC46CD2
	for <webhook@archiver.kernel.org>; Tue,  2 Jan 2024 08:09:16 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.62])
 by mx.groups.io with SMTP id smtpd.web10.24887.1704182953709554346
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Jan 2024 00:09:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=xPFqNcV7;
 spf=pass (domain: siemens.com, ip: 40.107.21.62, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jmd6bZ3jSlv2iwAlOw5xzN3XypxwtO8aZbSNgFDbabsbIOqm22iT+cEgxlp5uF9DZdWC0N0HxqUfO7/rFluIABpv9WZOXTOtxGBqeD5Xp8MQ9rwIZC+0BGiEmp+YYFKqWs7cCXxssopuP/5z7+uQnMgwIzHeK62fzb0pbXH89igl6wyyUV2LFaJHb9dM/2lrNfq12ruIjZn6gzuxNoVIs1ygdiQU+Ebtdg2loer5Aq9IhTKmC7/woojOa+9HrGye311EI4AlEKhk1U5Y26igD9OoaEq+GSSrNwXJ2PqCX5UrZSqlokbE9PuuNrQlYAK4B5J7ci+QV/GmltzC9osndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cy7JN7ZYAKrreU3oBCWHQOMT8PegdgWEpAex5VKv8h0=;
 b=lwuOaGFgJibNn722ms+gGbaAMl1IC7VwoVM7XXw6atjzCV6qfplK0BEeT7ZB3ZkbmYsHkFULkao2rQBxQYjC0QKEgZ3mGNIm+SpSRP346tqW5AlSl4doFLcCoGgr8sB+r/k8gPeoo0uPvpFdv5ErZtNrxuCjXNlLjj0aKyh5HjS9wOpRQ5p5+OX75WdrzSRKSttQetS+LI8oZA24Qj5wesfzRUXjq3OBGLZBTuPsZ6prmbCUm/nJ2bs1w+zmwBcv4rvf0N6KCi3V8+JAfBxg2tGp/ssZOymPn45ir8gjWQEY4LGXeUxA2xNVY4mhF88nGLndypDnQZoqhwK/dz7Xsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cy7JN7ZYAKrreU3oBCWHQOMT8PegdgWEpAex5VKv8h0=;
 b=xPFqNcV7oR+3ZGo4sv9O4nPl8lGfl//37vXxkdx/chdO4M/cIoGP/zMi2rtr5HNy7ZIiB6uy+/RKWQlmvV1ElQ//2SZJkPU+wT+YFgbv5ZTLgxz+d9w1oxa1xH4rCrfFwvlIdxcMlHBcXE5pRvZxPPAEZIg+uLnXtdsXWAhPtBz5dfuOIQO30P2XNU9o+HJOgPYPx0VSuL0UevpyN0sIfop6P6MbPvNW9AEkRcssnJCKaEm+36WBzAIDsqb595Dr3JFMHqWzCMPNCWR5sJtBia025KJyNdnv5QnZm3V0z58FckNLseJL9AH6/zWTwv1XbYka8cRVRK/ufrlx0DG//g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5898.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24; Tue, 2 Jan
 2024 08:09:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 08:09:09 +0000
Message-ID: <61b3ccc2-84c6-40cf-b1ae-fe2966c04a93@siemens.com>
Date: Tue, 2 Jan 2024 09:09:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/30] Add support for Renesas RZ/Five RISC-V SoC
Content-Language: en-US
To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Pavel Machek <pavel@denx.de>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 Biju Das <biju.das.jz@bp.renesas.com>
References: <20231220230646.219816-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ZYsdtS4UkTS/TUsH@duo.ucw.cz>
 <OSZPR01MB70190DB7501F1983008CD843AA9FA@OSZPR01MB7019.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <OSZPR01MB70190DB7501F1983008CD843AA9FA@OSZPR01MB7019.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0152.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: 33fe53c9-9afe-41d0-fddc-08dc0b6a1908
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3k2iyJH5b+TyJRzlTPS7IZb3k8jxnlcBe7yXCGbpam5WkfXiR/8/lvJFBNHN3ltRYn5ws0cYgO4aVlX7acmg8FABvfmwBD6qrFhxaHo3H3NQ3dIwAeLzMLE6v4rtHGsHNzh+ai/qURXUtYUDqNHYY0aaJ83TpqEnFI0cVKXJNU1aTt8wR2zqvoFX5cLzchsD358/auKvL/lP8gxk1YN/mjQxluuZoKRjikBBSKCzLfwZDvACHVa2YuW/K6C393Kyen76NErXlC/pS37M1B0goe46+zz5XisQtM4nQ6PFuVYieTuUGL2IASlYV/eLrvdQUh7uX4vQlNRiCKPxEgVQume58uiqkRzPArSBSGrR1WZrHGh0+yp51n+6tL6r+kE/wFzCFqN0xIy3NmZqUD2s9xIEJBlLXJsMCDPreaBoOE/foH9nzvASYja0q9J8koNUjUlghcF07X07UCooL3XRs8FPebdXRlligxErBVySoUufUN6zwC7QlW4hP+PAuLRFcwg0hNphFLOXz/uUM9mKN4+zPZy8WyAirjepGN4QwqkbywXDhM9dVrj+OBB7NwLoj1Zurdryo6gzdhqheR0htVwhXVT3dzGQ4sesoZF+Nobezw3wbAnKd9dGkFFQNP5R
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39860400002)(136003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(26005)(6512007)(6506007)(53546011)(2616005)(5660300002)(54906003)(4326008)(41300700001)(2906002)(6486002)(478600001)(8676002)(8936002)(66946007)(110136005)(66476007)(66556008)(316002)(966005)(44832011)(31696002)(86362001)(38100700002)(36756003)(82960400001)(6666004)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WGRDRGlvSmJNNUdpRGxrVFUzWENQcjNlaWpyM3ZsOHozRXpCcFVEaE1FS0E3?=
 =?utf-8?B?aWJBVnlGNlZjd3hTOG1kZU9JODFyUFpXRFc5WDUvNE9zMEJqNk05dzNJbmhW?=
 =?utf-8?B?TUNQMnVoa3c0bFhwYjZUTCtCbTVsN3hWSVNDZ0Vva21KUm5MalRIWjRGRERJ?=
 =?utf-8?B?VzNRTGkwcmxPdnJFUVZkRTdqOFI5cUd1dE1yOEsvM09nYmdmd0dja0xZSmFM?=
 =?utf-8?B?M0F1TnRhTkVITUFOakozUUJzQkRRSHJVVjkxeXZpS0dkVVRLaWNRb3JZaVJv?=
 =?utf-8?B?S0FwaERFNG4rKyt0TGhSZVI1bUo0S1FDMGRYWmV6bUhPaVNSS1piOE01cGYx?=
 =?utf-8?B?QjFQWEZiMC8zaDJrMlYrWS9OK2pMSjdleDB6Q2dOc1JDaVZwRTdkZkZjZHdL?=
 =?utf-8?B?TVVKZzdsLzYxZ2RvRzA5Ykg4ekJRY1V6Vzd0L2MxWmpQaVJpT1pPNXE5QzBB?=
 =?utf-8?B?Tk5MQjluRFdvZmRGQktuT1c0eEJyaldQaWI5bXR6K0VVSndZUTNSeXZya3RD?=
 =?utf-8?B?MjNNZHVHODVkR01LL2hrVkhuTFlDcHlBbUFzcWR1UTVKSGlyNEpRT2dlQjhI?=
 =?utf-8?B?d3ljaEpja3BkYlp0M2NQOTVVRkMvb3Y0QTVDcERDNWpYTU5uSTY0QlBwK09H?=
 =?utf-8?B?L3IxRXdKcExYdklaaXBNcWJPN1BjakZmNW1vMVVMMUFIY0NXTURJSC9uTFFa?=
 =?utf-8?B?ZlYwSUJOTEN1OFV4SGRxTHpVQWZ2UVlFeGQyVEtDQm8zdXE3UU9KWHhtUHdi?=
 =?utf-8?B?ZVFWemNjYVJLM21mTGQyY0s4YnJRUnBFQkR3OE5VNEdUYU5QbDJZYkN6Z1FI?=
 =?utf-8?B?UlRlYWhwZ2Q3a1o2ckNYMlllWjBvbE9MUEU2MFdLUndhVUZSRWg3TXMzSmV4?=
 =?utf-8?B?eTh0cEVMOGUzMGFsVGlPNTdIN3VEbTdwaVZycXpmTVllYkh3SXc5emxpajNk?=
 =?utf-8?B?MjZhOHgrQXd2MWg3cVJ0TG1FWkwzclgzYkVMUXNEb3JuWGlnUW92UVM1V1FG?=
 =?utf-8?B?NFNtcS8rSWN2NC9VcXVCTE52MVlwTm5tY1dCWUpwNTV4V1JZU1cwSlU5cUJ6?=
 =?utf-8?B?TFdkbkJHb0NOemI4d3ljK0FFeDJiUnBhbEptOFg5T1BrNTdIRkpIRk81anNT?=
 =?utf-8?B?TFNic1RqUnhrdEwyUFlDZ05TblFPb1lYbzRnREptUHlEMXFvd2tyd1lCUU4x?=
 =?utf-8?B?Z2Y2VmVGdE1wSzdaUnRLS2p1VWdOemFIQjB3M0JOYVNGRnMrb3p3SHFCL1A5?=
 =?utf-8?B?TXRWOXVLL3hYS1ZaZmNMcWg4dzZnMnFkZGI5S3o0a2JkZjBwcUhEdW50Yjd3?=
 =?utf-8?B?UTJjdWRXSkF0M0xKR29lNjhESVo0WU9jOFdVejJhejdoUU4yek8vV3B0Vzh3?=
 =?utf-8?B?WmFTM1FERi9uekpuMjFmaGxGakxHeTJkTUVyd0ZrRmhVUmpKM25URXAwb1hN?=
 =?utf-8?B?RFBXM3F3cFY3cit3cUJQWTZQM1BidjZabmNVZ3FVUTBXRUtkd01tckdDVU9Z?=
 =?utf-8?B?RzJObGFBOEgwMnRPOXpKWS9HZm1UNVdwV2JOS3J6VXRXWUMwMk9iaFV0OGlk?=
 =?utf-8?B?dUZ1elJOd0tDOEN6b0xDQmlYamEwUTBIL1M1bVdURWNtR0FSM0UwTzhZMlpB?=
 =?utf-8?B?NTRRcUNock9qRkpVM3lDLzdtNS9paW4ra2prK0pwZVl3UlU1UU8wREp5UDcr?=
 =?utf-8?B?dlhQbzZwaDVCUmg2N3lWMHBvNnFGKzJkcVgwRm9XOWZaSWlBcHA3UTl4dFBV?=
 =?utf-8?B?OWxiUG5PTWh4SDFtOUo3WEE3d2xQQm50bmNkcmNXZEI2RjljcDlZajRwSkNY?=
 =?utf-8?B?cWw5Y2NQN3g1dXU2OFhFeDQ0Sjd1VlBtRWhvcmp4WTRzeityd0h5NytGNGZz?=
 =?utf-8?B?aUNHbjRxS0lLVDJCbnhTR3NobHpNRXNzVTdxeGg2aUplQlZVR1c3ZnBha2Zo?=
 =?utf-8?B?bW8zYjc1RW9YVGdjVEdqWHlrSzgzOTg4VFNmK2dCYlYvdmRQcGQ5UUlCTmZ4?=
 =?utf-8?B?N051ZGprak40OXhJRzVMQTBMYzdLUmlJdjh6MzdHdTNMK3VaQXV3MEtLYUFl?=
 =?utf-8?B?cDBGRGNkWlhIVmdEMkdYQVQwaTFobitmejBaQnk2Wmp1Skg4SHhIL0t6TWls?=
 =?utf-8?B?b29ScTg3TFRQSHNJdXpEcW50engraDRycUl5Ymx2WnNjc3FTSFlNQkpZYXNW?=
 =?utf-8?B?bEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33fe53c9-9afe-41d0-fddc-08dc0b6a1908
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 08:09:09.9431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Txa6/7dmyR26msY/6FQpprd7jfmVWndXSgUVMhDlvLE5YeY1UNRAZw4qgkO0KLfCreYEHeP9raPLKWAzkERrUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5898
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Jan 2024 08:09:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14223

On 27.12.23 17:18, Prabhakar Mahadev Lad wrote:
> Hi,
> 
>> Hi!
>>
>>> Sending this series as an RFC mainly beacuse, as the kernel image is
>>> not generic to all RISC-V platforms as the HW is noncoherent.
>>
>> Does the hardware also have the "low memory does not work in userspace" problem? How is that handled?
>>
> For the local memory issues (ILM/DLM (Instruction/Data local memory)) we will need a similar patch [0] to cip-isar-core. Note the cip-isar-core image built with this change [0] can be used on other RISC-V platforms.
> 
> https://github.com/prabhakarlad/meta-riscv/commit/da749379155980d1f906d8632432f35a01a9c9a1
> 

Just to emphasize this (again):

Debian is not Yocto, buildroot or Gentoo, and we are not done by
patching and rebuilding the toolchain. Unless you can also provide a
reasonably short list of packages that require rebuilding after that
patch is applied to binutils, it will not be practically feasible to
address this hardware design issue via something like isar-cip-core.

It would be better - not only having Debian but also other distros in
mind - to look for a kernel/firmware-based workaround, even if ugly and
potentially slower.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


