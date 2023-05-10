Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D762AC77B7C
	for <webhook@archiver.kernel.org>; Wed, 10 May 2023 07:01:47 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.49])
 by mx.groups.io with SMTP id smtpd.web10.10593.1683702103969385894
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 May 2023 00:01:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kzyRZ1Mr;
 spf=pass (domain: siemens.com, ip: 40.107.6.49, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E513GP4pjU3E/D3Xwxyqqr6LJi+A5HMemPD7KiTejiW1itg9x9KL78l0uRTayf5eldcygZB+2vNMqnBZ1T/tPT2IRWjcFixzhnY8y3XMd1m0U7RkZWjmUFW3r9j7d4gaiEa6DbawBEHShl5by5rcWD7ZqsqFv9T6zawpkHlfQAeAw90MTokI7GBW9n9y13b23zGC8LYsBuwGF/uZL/stEH9G/lZmTWK3tyB+sjmyjrQizKVoH9GnA65jrNMucbGEBgAVMb0vyXbC1QU0mJUY4irQyDNdXCe++ctNpLUJSqpCGab5DxYXRb6DXPkMUU95y59bX7ACRSyvqsAO2aju7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwY4Z0kUoJPOIfwtwhpeYZ/PuSi5c5zMiA+HfIQ6zz0=;
 b=jTEPy3U7nwv8/v89BfChOgJC+1pbckS5o6OKfND3SW4/aKDYKcKDwjRIyce2FcNnti04zx0vbBpPApzam0xPXFgUJHvXQkg0tj88N+VDWsPgZdMBAQTWqoJnc82fgenm5RbnbS9GFUAQLDFaQGxO7XR88jmVErIP+yG0uz0GLuj13sE35wWrcdTCI/97dLGii8GxtJx5A4LRhl9cxcEXyANMykj09dN9N6mVCLwx+4261ML5q6kEB0JVgwbJ2ynhO+/IerDtegqNDqIDFGOo4F+JvIVhw6K9TXBbFFYeo27DbPcwuuIxaEK5v14jnWVHNx6UioXmV0UT4hzZbB9VmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwY4Z0kUoJPOIfwtwhpeYZ/PuSi5c5zMiA+HfIQ6zz0=;
 b=kzyRZ1Mr/SsGHUpvadIc6SxgWWoLVjUH6N8q4YOgSu2EMXwkkHLC+JWHmaTHdETfM13Lw3/hgkGCSoDhnMZcpA9wh5AG+uy4RN+HfeO6mTfrg9WhoLjh1IuknRPHKQUiUSdh0OU0QZX1f7pPgcBwDwip+UQPdfWexihrTKf2dQ72OjTybY57cnISvpnOuT80Y97YjcrSWmRWvFuAm3hWcvfcb/c97Ckt0YlY0/xu1fGN4Yt9e7hxeFcu1dgYZC6CicxjsPDRuvmM64Nm8U/VsY3d0A3lZMsUq8SwbidcXlSclTDRir3fdkqds5mFFziWxsjN20lexbdRiVGA4lDFCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6294.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:54f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 07:01:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b50a:c627:3d12:6f04]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b50a:c627:3d12:6f04%5]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 07:01:41 +0000
Message-ID: <a7f4a174-6a3e-1cfe-2c7d-895ad11338b4@siemens.com>
Date: Wed, 10 May 2023 09:01:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: Size limit in the cip-kernel-sec repository?
Content-Language: en-US
To: Chris Paterson <Chris.Paterson2@renesas.com>,
 Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Cc: cip-dev <cip-dev@lists.cip-project.org>, Pavel Machek <pavel@denx.de>,
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 Ulrich Hecht <uli@fpond.eu>
References: <CAODzB9oaJ73uvgppYvcOBbM2xLNB1LQW34TZbjA3gd+bkAKaVg@mail.gmail.com>
 <63fb0d57-3550-1188-8243-7ea8c8b5ab5b@siemens.com>
 <TY2PR01MB37880583E930BBEC98A5803EB7769@TY2PR01MB3788.jpnprd01.prod.outlook.com>
 <CAODzB9rdcjQKhj9a0a6igrjHCbMwo0Qy=xenxmTXFryMkOhVUw@mail.gmail.com>
 <TY2PR01MB3788F4587077708C078522C1B7779@TY2PR01MB3788.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <TY2PR01MB3788F4587077708C078522C1B7779@TY2PR01MB3788.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6294:EE_
X-MS-Office365-Filtering-Correlation-Id: c1ae2bc9-a08c-4496-6615-08db5124681b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QPL8mk/ReXEK/iM7UAKtNJW0FfiNxBfiELqB4DzsvrxhJ1P2Ipk2eDoLkt9bF5l+VfkLcRbvlzTcx6tgXHlb7gi7ntW661uIfkQCn/AAP60ROCRp967lYSLiXRn8ov7loRTvvOFXkAfQyvUEQ0lpiGo987Imy5LZHXg4hjlS4JsxUCYND7wStufakxEXrFOJJR0kflNolfiFWiz6ttgDV4+LBppITcnAyVcb33jt8lrDQqKteHKrgNyohl6S0YC76PA036mFjeowk/5nUB3+88oJgLGIB6Wspk8DS/N4BhTEKj5lP6V3b0Gtef0C5j+xTs4m5T5mnoAPo42eyVweHVHDmcV2Nsr5JlIWmbPFiYsxolBpgaLJ5i5QurYXbsOeoq4qAIZkyqHlo3epNg4PfLHaw3QkmD2liexeeY2G6Mxo5t1P0/dRLOa4ek4cMKRUlyksC8DTn5KmNXRn2O+OavJj5kUOQYNu2yCTjJkULO8voqb/8wdebapKv/jv46tirIHEBmoXINt7soG9X+uRg2ISk4meBta5XJajaVzZfYcV0ML+piCErL/ChUW/yfE4XqJJi9ooc309swjm3kf82ytuXVmdSHIaBy+JQMM8wTWxyGPTIrIKNQ6JZO11yA/8AVVlr/uQrqE10gxDBZU3Pw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(451199021)(186003)(316002)(36756003)(8676002)(8936002)(6666004)(44832011)(83380400001)(2906002)(2616005)(6486002)(5660300002)(31696002)(86362001)(41300700001)(26005)(82960400001)(6512007)(6506007)(110136005)(54906003)(478600001)(31686004)(66946007)(38100700002)(4326008)(66476007)(66556008)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a0kxcVVwRUtvMTQwaHh6VFduL3lpWG9DUFdNMHRHdXRpUmVZN1hudmRXVGQv?=
 =?utf-8?B?bWQzdzQyK3NDUWNBdXpvUFh4Wkc4Z1VSb2Rzc1ZvY3g5ZHdrZmt5NnlHRkxy?=
 =?utf-8?B?Z2VzclNweURoSFNjRWtpcCtlbjRsWTlOUTI1MVJZaVZSUUd6aTZnWVl2d09m?=
 =?utf-8?B?OXRSeDFFaHVQbW10dVJ0YUsxdUloS3VKRnQ1bGZlcDByNFkzenJXaEJBU2hh?=
 =?utf-8?B?b3ZCZFpoanhHakZ4UlFLd1J2L0FYREhXWnJTbHhvWVNmdkNzRnl1RnZBeXli?=
 =?utf-8?B?NU1UcXA0Qk5TQnoyaDlKa3ZranBrL2ZpN0VSZmVZNEpCY09RVkpqRXduZnc5?=
 =?utf-8?B?MzJMSUlqR3JGblI0azExbEg4L1ZyUHJVTmxjeUpadFR1eXIxQlF6YzQydVZW?=
 =?utf-8?B?MlZpRlFsa2txdGZUUmFzRFZDSWVneHNuYUhBdnYxNFVCOVg2WmwwaFFBMDdS?=
 =?utf-8?B?alE2SUp4aTc2SlVuVnZkZlRSU1Brc0lCb2xDdy84aTBjdnNVeHF1U2NJZjBt?=
 =?utf-8?B?WXo1QnIvaEhuZm1rNHVoMjdjMjdOaGpWRTh6YWxIRStmMU1xbUloZXlmL0RR?=
 =?utf-8?B?eHczRkU3Q3ZhQlEyeFFOeER0YWVCZndtdkprM0RxT1NHZUFQelh3ZUpBQ1dw?=
 =?utf-8?B?dGtqSHBvQmtLeVNXalJBT3VUSWdpN1QrNmZDcCtwQmV3ektyWUxxNUZCWElu?=
 =?utf-8?B?NGpOMGkvUU1SQy9ESGlqWXQzalFDTlU3dEpERFAvdWxuTUNuVUhZRjJXakRI?=
 =?utf-8?B?UExhRDdFQjBxd09wZW9wbDhHT0IzZHEyWVRXWTg0dVY0RVVRbGdpa0tOYmZi?=
 =?utf-8?B?ejY5WVZFRkJkdlRteXhJQVBwV1lYbGxUNlhoWFMzODRhQk1wYkhabzkwOVNW?=
 =?utf-8?B?U1ErLzZFWXRyMWJQdWg3YTFzYVFYTW1XWUhZNkljMUJnS2dRanhjRmRKREVr?=
 =?utf-8?B?M0w1U21xN3U1bnJNc2RRamk2V3hzWTFxazFTQ2tVVmNHQVpseVNEUTRQQk5U?=
 =?utf-8?B?V2swTGVHNkJmQndTMHhEODFlVWFuZ0JVaW9oY2hnZWxaVHdwUVRlLzVKc2tt?=
 =?utf-8?B?Y1ExbFJLalZocHQxcGs2SjkvMnkzTEVMbnUzZzVzVHRuSTN3R2NvSTV0RDFr?=
 =?utf-8?B?S1Bub0F0aTVMV2pkcElkb0kzWFpyQVowSXNwblVxZzdWM2U4NkExOTNhTGdQ?=
 =?utf-8?B?RjdhUU9wUmpaMmkvYzl5V2xYYnZTc2p1dzhyNmxqSGlGMytCd2JabXRlbk1T?=
 =?utf-8?B?a2Q4NFVTTWw1OEI2NVdzTVNUb3JCc2RoMVFhQXFkZUFPa08zcXFPakpyaGty?=
 =?utf-8?B?bU1YSlVTUVArUXpZN05pa0FYa0U4VEdzQWF1cXhBMkVlTEpWTmhic3ZzM1RS?=
 =?utf-8?B?ZVhjNFAvbnZKZTBZZnFPZnVnM3ZuYXFHZzA0SldKVGFyeUFTYXdBMm5zMmUr?=
 =?utf-8?B?SWFnY1E1YXBjMEpCZTBKeG1UakN5eWVPUTNjbTJ1VEx4d25PMFFNL0ZmN3Fi?=
 =?utf-8?B?d1ljQnE4cTE0TEFjSDNhN2drL2tBOVJhWnowTDIwL085TVl4ZElIU0xRSnc3?=
 =?utf-8?B?U0NKQ2xIb0xLRWZiTzVQQmJGTDhCZlloMlRLbkJNQkExYyt2NUc5RWVSNWQx?=
 =?utf-8?B?UFNrZmVFNDNtMURORURjVHppd0JGZW56RkIxbTRqWW13aDVHYTBGbzAzcllE?=
 =?utf-8?B?Skxsb2hjQk5yRkpCV1hWclNjUUFCVnJYdkFZczZRUTY3Qm5CR3lWcUNSTzVw?=
 =?utf-8?B?UHhsYmFNakRlQUVsdFFlZ0k4SjlhQmdxYnBjaysxTndxcStDcWlJL3QwWmc4?=
 =?utf-8?B?NHg4RjhzNnA1bFJ5NnNWckgyUjNRdGlRZ3puNURQS3BXdVpqSmxKRml3ZFFS?=
 =?utf-8?B?WUxLSDNKSWwrWXRQeHFtcmtqK1gyUUwxcUN4Q3BMVnhWdHEwazVaU2RDUEYr?=
 =?utf-8?B?VzBUZHlBdEtySmFuUjAzbjZsWmpQcWI3ZW1TbzBsMlExb2xHUEpCdUg5Vy85?=
 =?utf-8?B?dWdTYlFQSU11VjNKUDNkaHd4b3Ewd00rT3RhMjdxeU9UVmsxbll2TmhZK2Qz?=
 =?utf-8?B?OG1BMWdRMmZIQ1Nxb2Q0TXlhbnRVcGs2UFRxM3ZUV2ZPUkozVWJiei9iUDEx?=
 =?utf-8?B?MzUycTBHN3dTbEdoaTJsN0JIbkk2VkhxZ3o4M2Q2MEMrOURYbXFHY0Z5a0t6?=
 =?utf-8?B?TFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ae2bc9-a08c-4496-6615-08db5124681b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 07:01:41.1607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nrXN+Bx9pGZQjUbA3Uc+1J2GpqsDv0Tsn5PM9UTFKfATQHepYNxX3QCXTH+Ob+AQqR9VnopSOxeohDs9QJtAeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6294
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 May 2023 07:01:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11429

On 10.05.23 08:58, Chris Paterson wrote:
> Hello,
> 
>> From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
>> Sent: Wednesday, May 10, 2023 12:12 AM
> 
> [...]
> 
>>>
>>
>> The warning message disappeared today (Tue 09 May 2023 11:09:07 PM
>> UTC).
>>
>> Enumerating objects: 12, done.
>> Counting objects: 100% (12/12), done.
>> Delta compression using up to 4 threads
>> Compressing objects: 100% (8/8), done.
>> Writing objects: 100% (8/8), 1.02 KiB | 1.02 MiB/s, done.
>> Total 8 (delta 6), reused 0 (delta 0)
>> To gitlab.com:cip-project/cip-kernel/cip-kernel-sec.git
>>    92d679f5..ef1cf1be  master -> master
> 
> Huzzah.
> FYI I went through and removed all the tags and branches we don't care about in our linux-stable-rc mirror, and set the mirror to only pull branches we care about.
> So the repo is now only 4.1GB :)
> 
> In the meantime GitLab got back to me and basically said there is no way to increase the storage quotas, unless CIP wants to pay.
> 

So the issue was really only this single over-sized repo, not all the
other artifacts we have and that accumulate to hundreds of GB?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


