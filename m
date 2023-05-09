Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C551C77B7C
	for <webhook@archiver.kernel.org>; Tue,  9 May 2023 06:41:50 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.75])
 by mx.groups.io with SMTP id smtpd.web11.25576.1683614506864171927
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 May 2023 23:41:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=mXPyhoDO;
 spf=pass (domain: siemens.com, ip: 40.107.6.75, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NloLQRouQfEFNU7G29luGkDYk+OA+UdMBJj5KzZnbN0BUGsLf/XJToDURaMuexnyD0jpuBhpOFNFB9M36LVkIotIZt+i94s2yZDqFHsJAYvm6ceNfQx8uDh/E2eoMr1T/+FkcjsAYjfjxLPvbDS1u5sqwDHZ+Xkp4xp1a15Sevik/zgxnkJvb7iW2XKxinRl3zjRRsJfNCEEWk1xIbqwzfQjiLuZP2KqhozazBUnq3bUPxv66B9P7Bj8Uij4vsh7sYAC3Q5i9sGn6G33Dw7s2LLCaFzyd7u5OFFzTj7Q6GjbpaJWjv0a2zlQz/6d0mIjd0bOYBqaadSEHIqGqkLhjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nM6nhuZG9NdkQvovR1awhsVLfXUx9Wr/wcEZiJRH7MY=;
 b=mibvP5JEFLGCQErrWakDpIFsYEY44j1MvelyeEVKi0hDeoC0Lrl6k1GmWI84s4l0zUv3dYax2ms29n+7c8A4jFs2oaZb1QPJIUkvC+ZLnAr20vxCGRQQ2EPgStsqiESf2KEPe8MO7WNUJtY0Cm9Op3hvEcXisAjl2cmwagmCr+ZKQXB1lxWu/m+g2hZUSqgibekbUrnrQuyh7n4J+55xVEwU9k73Tafoh8GvfCRAz4W/ksW/0Jl/tmqNgbFqgKd9G1A9vHOu9/Qb/LNXzSJUO3f8EGBnwotiZSZOXvQt8VKir0qQDDi+CiQd9vQ6Z60orwbyXYz/Kg5fjeX0LVzb/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nM6nhuZG9NdkQvovR1awhsVLfXUx9Wr/wcEZiJRH7MY=;
 b=mXPyhoDOAKrA/qQf2xwTqWX0h5TdgbkciUPOFi6JBrJE7VLW+Ac4hxUfJZ75Ld4LhlywEIyG7vMkUxRt8tFGni4kPmchTQDWQsnA/0d0XqWB0ADcGB1Xvw7xWr+M/5Puaq8unK7g36M72+6hcwaHFxVf/WYH8oJ7pxlEEhdKviPddXCTasdMJ/aNTv93f9lH2WDBPGvzOef/5rEuHQIRLJ/c8FS9uzSG5ulOP3ysyvk6imd6PoszykPpOZfKMQy3XV4564m698GKVaOLebqu6XOKfPtXkAK6GIUUI9CqXfYMqy95CwPPd8ynnP0/aUxgvNbN0rAnZ0RSV2Ny219m8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7412.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 06:41:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b50a:c627:3d12:6f04]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b50a:c627:3d12:6f04%5]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 06:41:43 +0000
Message-ID: <85222c09-ad62-f939-dc26-b090e9a57339@siemens.com>
Date: Tue, 9 May 2023 08:41:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: Size limit in the cip-kernel-sec repository?
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Masami Ichikawa <masami.ichikawa@miraclelinux.com>,
 cip-dev <cip-dev@lists.cip-project.org>, Pavel Machek <pavel@denx.de>,
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 Ulrich Hecht <uli@fpond.eu>, Chris Paterson <Chris.Paterson2@renesas.com>
References: <CAODzB9oaJ73uvgppYvcOBbM2xLNB1LQW34TZbjA3gd+bkAKaVg@mail.gmail.com>
 <63fb0d57-3550-1188-8243-7ea8c8b5ab5b@siemens.com>
In-Reply-To: <63fb0d57-3550-1188-8243-7ea8c8b5ab5b@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0666.eurprd06.prod.outlook.com
 (2603:10a6:20b:49c::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: 13d53c14-3ad1-485c-273c-08db50587410
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	r24wem2fNON8pgj7nrem+FY5NtDwqli4GVw3OFMx2zj4JkBFVz99/BHuW/fuB6ISqAEEvay5LqYldap014gKrwcElzF2QwWzTU+Eub529JMxEGjTGNCpsG0+aoheY611XRJF/8BeTURgS5cE/JRUzSZC8djz66lazKZBNDQTrOvwVcdYKt1cWoFSFlBb2oEvO8rQBqv41y2TRHJdc9NWqkRUmrUnTMJ3kiOI5vLEE2MSbfhLuJBez1Gtdmh6ZcMF2bbap+5kT6CyTtZUj29+hJBYyJpfWBICibbTOfNDb9rTBKUGt46TWrU7QoI48d+FLkwPQBp+mBujQt/ZWG0DHmsjkDOafLSGjd9YydPRj+MIz7Yu8zy3jKaYZSsbAjZARmzSANuFZq5wl7svaMImuhjtKZAEy3m7WvyOzrjPkmyG0e3h+sesn8snfP8R2p5bmjC3MU8t70Gu/IzxOGERiOF+Q4XP9q/FBxPYgwGRuG/MqeCzGu1O2/HOIcNI+pqT3FAq+i0R+OOmbCQ0AFPGlXJGfP4bCHMMR4ixif1nTY5qnEL3xdBE7JV0WoOUEv7fWq7xybu9mHhusu5drrozoJksME0LxJLpQfKbXOIL8p53WY/R4xC0ODqB3OrwbC7ail5cC01hSG3oTLrZdF/fRjG7WpbY0ajVwpNQ01LXYSCMGhNVYW9mqnTrIwtaqi3z
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(451199021)(31686004)(2906002)(5660300002)(36756003)(44832011)(316002)(966005)(41300700001)(8676002)(8936002)(66556008)(66476007)(66946007)(110136005)(478600001)(86362001)(83380400001)(38100700002)(31696002)(82960400001)(6506007)(6512007)(2616005)(53546011)(186003)(26005)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NHc3S0lnU1llakdIN3VzcVNoajJTQW1YZThrNVlaWlZxVzZYYzI1cjBXd3JV?=
 =?utf-8?B?c1ZWc0tPUTFSaVhVUGVKcnMydEZsQms2blVhYUpiejM4dlBSYkR1VHdjT0V3?=
 =?utf-8?B?RmlaMUJEWWx3UzFGVitRV21ZZEc2VVY0T3lVYmFiL0RlanVQTzRMUUZHcDhx?=
 =?utf-8?B?RWJraTlkUForU2pxN0ViZE9MTHlRbDRFMEFFbEJVd1lCelF1L3dkT29IOVpI?=
 =?utf-8?B?bUJ0WnFqdlJJSkkvZStmeEtxZWxhMW4zaDNNUzZDZU8xckdqeks2Yy9BSDJ5?=
 =?utf-8?B?RHJ2YTFmS1ZMYytKNjA5RzFYclhVOHpORCtPeUxlYzNhSWVCa01KSzU5THFS?=
 =?utf-8?B?cUtjSGNRUnBJWm91YitOb0EzQ2dUNmhHSUhkUUQ1N2NwZGpVWitmQ2kxUTlE?=
 =?utf-8?B?RTNMWUlLZzlDVmlLaW5xd2VRUU9RVEJTVVU0a1hjWVA3dGhLTldtSmNhM3RT?=
 =?utf-8?B?bzhYd0NSNlcweGRjdjBVYWNuKzFTcktDZUdyeHRZOXJqcWh2UnZMTkxoZVdu?=
 =?utf-8?B?djF2ajNRZWR1QytkbGFlT3RWa0ViWlhhMHg3MHNVR1lOS2pRT0d1RW01R0hm?=
 =?utf-8?B?WmxvN0x3cnpZRFNlYlI0RWREdXpWd1dkUDFzVVdzRVFRWlFMVWJpL2pHMDdJ?=
 =?utf-8?B?SnBSQTFEM2RpMy8yMFVOQjZ0ZUR1VktQMUhqcGpDMFhIK0xxZlRZOCtVaE5x?=
 =?utf-8?B?RGpTVEZKOUNpUDdkbG5vVmExbmMybVg1cnhJckNaRHRDZWYwM1dXMkJFTWg4?=
 =?utf-8?B?ZFoydkxsTzFPMEtNNDZXMGx4YXBnT0ZvMW1tQ21IMGpqblBrRER2Mk9EeVk2?=
 =?utf-8?B?SEJHMzg1dWVISkdVVGlSRkIxUUllbVVsWGhEOWJMdUNXVW5ZMkF6bmhnTEtZ?=
 =?utf-8?B?c1JlR0czT0xHaVpacGh1d1RZSmhzbFhTNzR1OE0zOE0rVGU3NWdvcFB4c3lw?=
 =?utf-8?B?Y3lRb3JOeUx0NUJKMzVrOHhDcjZaSHVkWldhRjZ2S0w5MlY5Sit2VmZURW0r?=
 =?utf-8?B?UUJ1TzJzREV3YjYrdGRDYkp0Tll4Q2l5S3g2Y2RlNzF2VGV5ZStVUWEvUXE4?=
 =?utf-8?B?U0k0R2pDSy8yTDBPV3BwTkIrLzBuU1V3Wkg2TVVTMkdMcWdqem9OWmlRMGlC?=
 =?utf-8?B?WndFMWM3WFc0SUh1WmxiZiswMXN2R0EzcWhtK3RHbXJnRUFqK3BybGQraTcz?=
 =?utf-8?B?dVExaSt2aG0wOGdxSnhpNmVKQ3hOR0U3WnNhWUJnZGc0OTdVZWprY3NETFpv?=
 =?utf-8?B?L3N0MUJ4WEsvLzFXdG9KWkM2RE1LS3dENG5JWDViZk9uTDlJb3lCOUZMUlQw?=
 =?utf-8?B?Z2lvbElLaTlrZE16K2hsZVU3a2VRTDcrODlqcTBrT1NLZFJwTjVmV2lSYUVU?=
 =?utf-8?B?U1NUdnVwN1praUJJSFlyS3dpMTVRWWcyNzlkSGRYbHRvZjZGMTg3WTh3K2Jr?=
 =?utf-8?B?anRtQUwwRmRvVWsxVWM3WTRLQy9ZZ1A2UW9lTjJmWWRkMWZtdkFHaUJNYW5m?=
 =?utf-8?B?ZGJjalBwK3RMLzZPeThyYTJuenJOT0duek5sZ2s4TnBqbGdsS2VtR3A1alM3?=
 =?utf-8?B?Z0d1ZERacndkSU1HMTZ2RjVJM1E3LzRrZVRMa2s5QmcyRzhUUFlQSjNVT3J0?=
 =?utf-8?B?anlzYzhUUWNGMkFTR3ZFV2tweXJobnJPRnFsb2xRMjc1RXR2MmhLNzFMZ0J6?=
 =?utf-8?B?MmI0dWdQUDZtQlV1cmFZZ2VOdTZSUW54dzFQNXN2R2FKNW45bVJESVRkRlV3?=
 =?utf-8?B?dHNzRkdua1JnYllmZEErS0YvQml2dFIzbVFQZVNWaUgvTHJzMEdpL29FdVNC?=
 =?utf-8?B?WkxiOXhPRlY1SFMrUUJ1bHF4YXZScVEvM0FLZnU0bDlNVlpwWExuOHB6ekR1?=
 =?utf-8?B?UXE5Lzd1Tmg1MC9CT0FXWmVwcm1JVEJnUlhpa2d1SmJzK3loaEU4UHZhck1L?=
 =?utf-8?B?NzBsV0pVb01JOC9jOGVLdnhSSWc0RnArOHNNQk9jdURqSng3ZzF4bkRKZVVS?=
 =?utf-8?B?OVVaZHZRZ3RtcEtsL1pORDFLVDZEdUJhbEFsMHFMaks3bVVGQmhWVjRnRk4w?=
 =?utf-8?B?Z3RXaFJXNGoxZGI3ZFRJOHVEU0R4dDFvV2QxcWJrUGI4TUhBQjBoV1htM0xX?=
 =?utf-8?B?MStZNitxcmFIcm5IMnN2b0IrZVJxVmxwZ0dNcU9KV1lpMytqNDhvWVRTbnBZ?=
 =?utf-8?B?MWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d53c14-3ad1-485c-273c-08db50587410
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 06:41:43.8907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DkGVcPstR6IpLqFWvszjTAuGx5WClMoVV7ZuENfEcGg5ULw78LMQlxIfhTJMglD+/AUgTL3HQeQ2WSMhEMZnpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7412
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 May 2023 06:41:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11421

On 09.05.23 08:39, Jan Kiszka wrote:
> On 09.05.23 01:34, Masami Ichikawa wrote:
>> Hi !
>>
>> When I push commits to the cip-kernel-sec repository
>> (https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec), I get the
>> following message.
>>
>> $ git push cip master
>> Enumerating objects: 7, done.
>> Counting objects: 100% (7/7), done.
>> Delta compression using up to 4 threads
>> Compressing objects: 100% (4/4), done.
>> Writing objects: 100% (4/4), 457 bytes | 457.00 KiB/s, done.
>> Total 4 (delta 3), reused 0 (delta 0)
>> remote:
>> remote: ========================================================================
>> remote:
>> remote:    Your push has been rejected, because this repository has exceeded
>> remote:     its size limit of 0 Bytes by 400 MB. Please contact your GitLab
>> remote:                   administrator for more information.
>> remote:
>> remote: ========================================================================
>> remote:
>> To gitlab.com:cip-project/cip-kernel/cip-kernel-sec.git
>>    78850bfd..92d679f5  master -> master
>>
>> Even Though, I get the message, commits are pushed successfully.
>> I can see commits in the gitlab's UI.
>>
>> Do we need something in the repository setting?
>>
> 
> This issue affects the complete cip-project. The reason is likely
> 
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc
> 
> which hit the 10G limit, see
> 
> https://gitlab.com/groups/cip-project/-/usage_quotas#storage-quota-tab
> 

Wait - I only looked a the repo column, but there is way more,
specifically under "Jobs". Are these artifacts?

Jan

> Folks, can we avoid this?
> 
> Chris, didn't we apply for an OSS project rank on gitlab.com?
> 
> Jan
> 

-- 
Siemens AG, Technology
Competence Center Embedded Linux


