Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E98C46467
	for <webhook@archiver.kernel.org>; Tue, 29 Nov 2022 06:57:35 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.72])
 by mx.groups.io with SMTP id smtpd.web11.143164.1669705053404210035
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Nov 2022 22:57:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=BgOx2/Sw;
 spf=pass (domain: siemens.com, ip: 40.107.20.72, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3zk/k/vOXbYEZqqozG+Ck+4rszhYgpkB0rq78i2K6HWqnijCLxkZf4Gpnl3Du4pHhumnw8M21Ascyu31Ix6TEWUJLDITMEol96ObNK2Z9DOSb0r4QWROYeM6KYsEYVIoNESSE809brPnSVPye6vqm1RIkfmqvluUYlLDkxK+kyZKf+s7lLwqgHQ6euLkMZUxL+eFShR6bfj1NOzo68C6uv9qzBZvbG+eRhe8JswrrHtPNR9Yzxc6iJayZ5fzL6iNmq2HgipkOHFFRU84yKL0nq9QIppCoaGSCaw8Bi228DubvgYi6nkMVsCv3hTYpgHqJAbE2o4xsPzh9a/Y7ngTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhJHxPyypkvDdQXZAVWl9Y27MUIvr2lCCOXe4CesFHE=;
 b=mB5HSDFlSn698osgHMNsfteRWoqjrsuG3OzYb94xzQuqwEdMJ+8zOhf/9xowlSn7be8IY9igdcT9G1I+GEzV1UTahZeryMu774PSK5IJ3f03ZC0sUJJEDP4a4sJ/aP8/Evfr9EH5BPgEGsMWIYN+DlRRtDWmsz2xMdvJXrRPJMc8wVtVFHjxIMBf+rkC7cEgLeYLJPQJApLhFfTW0dRQPumhZuzcnvbFDBh9KMR9syVVTV2LEz7ykMcnCqO/VOIhL0Knz9XSWQghB5X4WtVXwKDiB2W8dJSdHTItWfS+npv7pDNqoRPxqTP7b/4NaJcSiLbXfp76+i0uh3QlXoqrig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhJHxPyypkvDdQXZAVWl9Y27MUIvr2lCCOXe4CesFHE=;
 b=BgOx2/Swgrmofh81AaPGN+8V92vO50/d/YS63l0CEUdRxU1KnGWbWmHMSDXpgOYOvoIDz/tzBZa4W+Zqal6jsNYP5/YgZ3e3YXqgBZUu9wsipo7kES7TzZNhjexf0vGttUjyAmNFapc0Ds3Qfu9lHmjR18TIHrjCk7ufSfHTtbNZ8V73BfMlkd6mnAz3POND+C+2/mIsj1blGO0TNwaJedeuyOPA0I8q214iYj+GlVxhftJvbma4YwC5DctsZD/Y/u2K22tEHTzfKtWUjr4MWI7OIuI/v9VnXzp4iHLigJ4CPi6E6bUEde2kev00CVP430dottZ/Xya0pMJ7LdC7fA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB5PR10MB7654.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:48b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 06:57:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%8]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 06:57:30 +0000
Message-ID: <c8dcd413-8d1a-b6b6-2c39-2c340a5c23e3@siemens.com>
Date: Tue, 29 Nov 2022 07:57:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [ANNOUNCE] Release v4.19.266-cip86 and v5.10.155-cip21
Content-Language: en-US
To: Pavel Machek <pavel@denx.de>, nobuhiro1.iwamatsu@toshiba.co.jp
Cc: cip-dev@lists.cip-project.org, uli@fpond.eu, Chris.Paterson2@renesas.com,
 masami.ichikawa@cybertrust.co.jp
References: <TYWPR01MB9420817574A7EE194819701E92119@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <Y4T0kfkdeWj/UmF4@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <Y4T0kfkdeWj/UmF4@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB5PR10MB7654:EE_
X-MS-Office365-Filtering-Correlation-Id: 63f011df-97e6-4b99-672f-08dad1d6fbe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xuq9fNJCE4ZzpentvlszXsVTkd8Vi52SMBJETWDgZP36ESpzH4nFD1MChl1qffM1HwCs7WwNiR6+LFIE9W2DTuFfhers5WKTQ7JcoyMN1Pg75JfdY82Wv3BT7IieE1Sh4Jv8vF75zf7f87hiJF5h3P5ZMfW72hP8IhiqeiPQmswgXdECtoxAbTRLgUC0lr6MOV7nGzUpZUxDs3vsByp66BWEDtvWdXCYHyh/kfTMMwczpQWiA1tshyI/Ei9DB9gNg7hb1Fy/v4ebOBoLYkgkoh69z+6io0Y04Y2APjnMKJXKn3Gm7W5h2eQNOgWuRkmxvY8EZfyvULe8I7c2i1NFSsh1nq3wZFZLeFD9ojHnD0+Bsu3FdJmBCXcG+KCS3QXnNN7dVctBx++u7ss/10dBpz9etXSfVwlxPvf3rW5ZH+leWm3sPQ1fwd4svabyFT5bWqYGZdv1aWvVlaH4dj9E+LSmmTn6I9mRiY1hFXzk+6LsvvZnLLwjNkjaRf9d7hulupsvnBHTffZ5fY+KX9/HYiqWpuJZ8TUoigVBE6OZ6XxN+s7l4ia8cbBhEoiLXK1eiP/LCo27RmKX4qz6V6nduDR+yzJZARw5Bsk+S/+nZr0ygY3haT9WOVsUs71hJDgTkszWTWhvsF4/HGU5rjKPp5Z8GR/I6mvSp1X54bfiaxq7dgenQkmipfH/fWOuhSwP5errw6kUByuzTyrtJMphGGWedBukW8DCbtdLaJHBCsk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199015)(31686004)(186003)(2616005)(478600001)(316002)(31696002)(86362001)(82960400001)(36756003)(38100700002)(83380400001)(53546011)(26005)(6512007)(6506007)(2906002)(4744005)(44832011)(6486002)(4326008)(5660300002)(41300700001)(8936002)(66946007)(66556008)(66476007)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TXlmWTZiZWlEN0RHcnhCaVlCaDQyK25sNEdyZVY0ZWUvYnBYbnAyRW9QRUQw?=
 =?utf-8?B?dTc1ODVuNXZuc3lKaTEyKzhGd2dYSEtOdXhPYkU5WVFmZGhsVjVJaUdFdENl?=
 =?utf-8?B?RUFJdTJQU3pMVllqeVYxU0p0QllUa1daSzN5QUhMek1vYlRjeXJkZlhzS1VT?=
 =?utf-8?B?S3dtYStFVkZYWVJqZUlUbFFrWmVCbTlqY1R4eUVqS1lkcFM1V3hiR25BL2VU?=
 =?utf-8?B?WmFuOGQ2eXcyTUE4enBadjhuNkRsZUhiTUhTeVlLaDJ6UkJ2T2t0QVpTRlRi?=
 =?utf-8?B?VDhSRjZMTzlrcU9jRjNaVEh1em9ONmpCZFJFbHFsb0FzOStPRWdxbXpxVjBQ?=
 =?utf-8?B?a0VPMDBhZ2xReGxPcERGK3psNUJWTUM3R0kxTWxESVlWWnBnSXdPZDBLUjRt?=
 =?utf-8?B?NldyRmFrQW1pY1V1UmhPd2hhSkFnSEFvRWFGTkdldE12U1M3UVdBOVlRSGxR?=
 =?utf-8?B?WjZ1VFh0cXByYkt1cXZsMTFNQ0I4SFVYbUxmKzhPYStkL0tpaTNDZS8zTkNF?=
 =?utf-8?B?dS9VRzJCSUhYZ2V6V3VKNzZYTldhd3RvWlhGRFYxTlk0aHhaclhmblN4Q3hm?=
 =?utf-8?B?eXRURWJmUVJJbGFnZ1NITDRtMitsR3RVdU5rTHY5Uk9pWkpSYWZVbGpKVFFj?=
 =?utf-8?B?Z3BpRlBnVHZzUktGZG82Q0VneVdKdGdQajRnaW55eDdmNjQvbE5KSW4zT0Ex?=
 =?utf-8?B?S1R4MXYxVURUK2I2MzIxdTA3TkVZdTBucmgrdlpHWEpaMXd4b2NkOUFUMUlQ?=
 =?utf-8?B?Ykp5TkFaRWZHaVVBTkVFdmFWUVhyZTVSTzZ0TWtHbjk5QzgyaEdFOHN1aWFu?=
 =?utf-8?B?LzJFUXRML3c3T0QwQmNzVmNZcGg0Z3Bib3lpbTN5c2JNOWlOQWtGL0ZhYldQ?=
 =?utf-8?B?MzZna1Qyek5yMjEya1JUU290d1JXc29nU2xpVFV0czlQSC8wbE9qM2lOZ09y?=
 =?utf-8?B?S2dCSk5IeUdiWnE5azBDRU44ejZuYkgyTjB5RCtvU29Ybi9Ma3A5RUJBSFhw?=
 =?utf-8?B?WG01aitvcWY2TG1iTzA0dzRZZVZscFhOMlVab2tGdWVSYk9JeTZqdDk1VGhB?=
 =?utf-8?B?WEViQlJGRVBMalRSVld4ejM3THpCK3d4S3AvWFlBajMwWEl5R1RkS1dWZ0sy?=
 =?utf-8?B?eWVVb2N6OGRxRnZHcklWcUlEaktFcHlxN0tEMGwxVVBOdFl5Skw4VXhEY0JS?=
 =?utf-8?B?M0hrTG1sSGJ5ZWxVV1E1SmVoK1JETGp5bkNyYzRFYUNDcUpvbzg5eVZQVkVq?=
 =?utf-8?B?ajNmTDhBUHlCbzJmU2V4YVhramltMTBHeHkyT2RUUUVYTnlncjZwT1h3cldB?=
 =?utf-8?B?Vk5KbkZKY2IzNjJNUDdPaXMzR1RBUDFNTlZaZnp2cjl2c2U3ZVB1ZW9yMVp1?=
 =?utf-8?B?T1ViTlZrL09BUTlvWWRtWjBtNWhwcVlaaVhlZXdLelIvL2cxSVVuVU1IdVdO?=
 =?utf-8?B?em9laldzNUM1eW1pR1NMSTByVkNBdkR6YVViSWxWd3lCMDFDWkx5UDVhOEUw?=
 =?utf-8?B?VW4xaTc0UzhETGsvQ1hEZHJxVUtxaFp6Q0lGdGsxazNseVphdVlYd0hsMlk0?=
 =?utf-8?B?eEs3QlZhTzFqWit6bDhpY3lNd0tkTzdoK3NlajBZd09sRGdBSmwxczFScnNW?=
 =?utf-8?B?a0JPTE9ELy9RbVlEbElrT28zalJGL2QrYnNOM2pVZzNBSzY3ZldiR0JWYWVV?=
 =?utf-8?B?MDNrUlFZS3NMV2VnelFNdUZpM1g3eG56ZXBhM0dlemZ2UC81U1VkU3RiQXA0?=
 =?utf-8?B?TERITy90T2U3Nnd6OG8vZjNBam9LWGdnY3Bla3hQR1hLVytMaHhPSmRKbHpC?=
 =?utf-8?B?L0dqcFM5bDF0TzluTGpXS0JnSXZYUkxrazM4TWdKbjVmYmtDZzFTelFtZ2V5?=
 =?utf-8?B?OGlNaDZ1QWdqa0p5MXpud2pvZ0Y2RlBEYlY3b29MbU9FVXYwWEdmOGdldk1i?=
 =?utf-8?B?enRsMFdNTnMyK3RBdGFBak1qTUJlWm5jZ0tFaFVoTFhBcll3L0JVeVZkNTBB?=
 =?utf-8?B?YTB5M3NJWlVPN1NXVEZEWVVZZHM2QnFUT0EzR09DUDlqWUxQUVphUGtMUG04?=
 =?utf-8?B?YUYwS3J5WU9JaVd5cVk1UGlJVjZPODF3VlJNZDlJT1dxaVh3a0tJd0dHRTR1?=
 =?utf-8?B?Vk5ZWEtnNzV5c3l6aHFyTU1TaG9Ca0dGMWVUMit2TjVNTVNpcjNQNmpIZlNr?=
 =?utf-8?B?UUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f011df-97e6-4b99-672f-08dad1d6fbe1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 06:57:30.7124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CriUevaNBniAPhR6HHuB/iZ5HSWJ3/7S/cdIBE0SdI/UXOpKlbAySCVtHFr0iGF4XzNwzqXBCOexeU94OzUD7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7654
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Nov 2022 06:57:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10127

On 28.11.22 18:49, Pavel Machek wrote:
> Hi!
> 
>> CIP kernel team has released Linux kernel v4.19.266-cip86 and v5.10.155-cip21.
>> The linux-4.19.y-cip tree has been updated base version from v4.19.265 to v4.19.266, 
>> and the linux-5.10.y-cip tree has been updated base version from
>> v5.10.154 to v5.10.155.
> 
> Thank you. Is there plan for 4.4, too?
> 

Would be great to have that released really soon now, unless there are
technical blockers remaining.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


