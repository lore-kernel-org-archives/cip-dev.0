Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4966FC77B7E
	for <webhook@archiver.kernel.org>; Tue,  2 May 2023 13:59:29 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.69])
 by mx.groups.io with SMTP id smtpd.web11.178.1683035960679525030
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 May 2023 06:59:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=f3dLRKkA;
 spf=pass (domain: siemens.com, ip: 40.107.241.69, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LThBXi2XgRIYIRCrwGbqAv3L4Dj4FS5297++u+9mBPtb4ZpYmbPW/qWWBPEB3EwY/UrYCaKh94D1mSA5ZETI40YFhZhPQ77QlQDgPESlUBm4TSaotHcbDBTUjsuAtAXBqp8Y8kOfGlAsEnqD6TeNrOYWZoXE8OFZ7CND5wDXWUFUy8mX4FJNE+vI1gs/gs0XKNopzFJCFQFzIc3vliShPzjh3VHy93sRy6vyzNeU7HUUdl4KVjwBlXjknCJSqeuRKkxB7VNTFwC+ebmUfNv2c7YDQz2CyqpqjEqlhcwilFJZJfNR4iK1kZsQ1fJ6ESWmU9TtH8xCLZURTpqGlu8kew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpbJrz7op9BY424FjNZpumojlj0P6AMEfjy7J6KKuXU=;
 b=jdY692NQdhZ+7MAipZzHp4mHBHBDnzjM+7fE1210VjVMnhFaQuLVoOX+28PYZcFutv1UJ1lxZK820UsVT/QJj5Cp1pVz7iFjN+ZikCaESuULS6GYlKs++sZWVYfanNOIskYZ6uBjJ4t7z3OLML2GYfKnbsUYaiT7m6Mb086Tb3YWfNikwcHWvSwsHMPSJVqfMFyx6vfadz+bzjQ125Qn1pwjEGB/F/v1fOeQe8bp85aLwCnolV+ek8DmnVd7VDAXAcDJrZFn283biDBMRP0QSk0zVCizJ5i6uQrqykxULjeT7DPn5LiAgqFI3rNUafozYhYRSCLF0YgULKnZV2JK+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpbJrz7op9BY424FjNZpumojlj0P6AMEfjy7J6KKuXU=;
 b=f3dLRKkAoOJgVpDNb/9jpsF/AICr8rOOGm2SxwQnEULK/FDPlheIdSf7Zwsko879lu1oq0mkwCrRGMQ7AKszPlikb2Rjku4enLbnSeDnkT+nsJnNEhnyogAjYn0rF8iRv1RGMtNviKq8V5QvtSos0t1eRZKpiwwlBiSGgxWPY6wF7DqXdP/LNKNejykEqPgwvwzQH6Tl9UAHWKIwnnB9lAMmPgUTYAL6DiRwSBtHq1Uosj3+0UOM85EgDYDCEXNO2LIdUOTUyT3vW1HU0InrPTPgSfiBFcT8lx6/obBuR5V7XafBXNIHZnm+wtIeHBVJ3zQwgRw54Y+bM1rPdF0AuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5220.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:348::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 13:59:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%4]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 13:59:17 +0000
Message-ID: <af817b46-e9b1-5a3b-a66f-3f677933c606@siemens.com>
Date: Tue, 2 May 2023 15:59:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To: Ulrich Hecht <uli@fpond.eu>
Cc: cip-dev <cip-dev@lists.cip-project.org>,
 Florian Bezdeka <florian.bezdeka@siemens.com>, Pavel Machek <pavel@denx.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Potential 4.4 regression
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0130.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::27) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5220:EE_
X-MS-Office365-Filtering-Correlation-Id: 69207c5e-60ab-4d5c-749f-08db4b156b16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UmGZJl0sAX/y160c1YX0uEBc7UEnT0jAMkkPA0ur88jzrTdBTwLH6+nX0F+K9vn4nzhxfW5J9gn0Hpqo9xIs9DGSueVweB35txRVxrRzdw4y92CQpILw+w5+iSSa0DZ52+KZDnfxE1V8gqX5S1g+FLr+ijeVE5v7B63qwRGTOdfuueaxW/iHm6iqPdbmhMK9XjDhWhM26O5LD6T5BHwBawhqeSlKywkhsQFo/ZmMokgS28LNVMdT7AOJVU/WHIvqppOgaoKjLvPoQeSQWyvRIPGaBl1KL8JmMZ5esIHv2o+84L7Sj1wz2CUgAV+8H/1+zPC7f7StqYYNsMLzWKx7zHzOiRLlZjAV6Cp24PeP+y+83WYhO0YL9GjZGjjBap4Y3btCWqqTWB4/D6sLi4UFS6J+NVP2KLjInbSTmL5zH/uCdUoFBICE+xzwpKCZy51qzE8F55IWZG1aREw2it8UiE70ofFkRzvZgAy9CYGUnI5qPBsm6GdMIUqYdAQpqZ8ugx/5+U3/sQUfwWwflOUN0RgBHHDhBNrTpyqFLK46ZgbysmWGF0sScQw9zYMJZjqjLlThJ3S1RTpfUdCPGNvIh9pXWpN/zdNbyuHzYkjSNKS51awHko4uWV4/MNiWEfhs8MGX8hHhHt1rt2in24AAYg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199021)(36756003)(86362001)(316002)(54906003)(66946007)(66556008)(6916009)(4326008)(66476007)(6486002)(966005)(478600001)(6666004)(4744005)(7116003)(5660300002)(8936002)(41300700001)(8676002)(2906002)(44832011)(31696002)(82960400001)(38100700002)(186003)(2616005)(6506007)(6512007)(26005)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RXQ5TEpLcGQ3dU1PYlJnVXU1R092Q054STF2OVVrbElGMzg3M2xKQml1bDB2?=
 =?utf-8?B?bjhIRURZUnNkN1lSeG5kOVd1M0U1UlRxQ0JER0Q2dzVDRkRCZmRtS3BPakQr?=
 =?utf-8?B?VURhY2RSZGtJNDkvVnovQlFIMEVkOUFuVE1hV01YRmxqL2gyQU5WcHE3Z0xL?=
 =?utf-8?B?VHBOekF0THNqOEF5Zm95UnJGdXpQcGM3UzJJOWNKdFZRZUJtcUJFVmJENkMy?=
 =?utf-8?B?ajIwdVVPN2drVGU0aTBRSGQ0b2d5RC9USE8vNjdQZ2kzejdvVjg4eW1ITEF0?=
 =?utf-8?B?UFpHNkN4bzg2YytJbHhYREZaeEMyemdaNTYwUXJPTXh5TzRvRVFaOTUxNVMw?=
 =?utf-8?B?Z1NvVWxaZTBiZGNjaU1xcGtXVkg4WXlRRklaSTNrdHhWYURJME5MMmRKdC92?=
 =?utf-8?B?VnU2cnpUTlRNWFJFK3J2U0hwMmE2M0JwN1hTekpNeDhaZUhLa2xNRW5ydHM5?=
 =?utf-8?B?Y1NSNjE3Mm1JUFRxalF6NEU1aUZiZXRMV2h4TU9uSzdWK0xodDlvdVd3TzB5?=
 =?utf-8?B?Rk0wZW1oZjc0bG04ZVFON2hqaVgvNnpTWGZNUlRtc1gyOThicERVRG1aVWVL?=
 =?utf-8?B?OThnNExXYlR0bkJ5RzRNd1pRbHVDWjlMcldUeDNlWVNpbHFTNXZRSHRUZzRz?=
 =?utf-8?B?SVV1a1UrcVdNWVJKNnZwZFJwL0JyaUwzUHNtdU8rYnUzaVFQdGVRSDg5ZUo4?=
 =?utf-8?B?NkM5S1psdFFodWRaRXhhQTBHU3UySnQrNU5rL0ZKd1BQRU9iazdleVd3dTNH?=
 =?utf-8?B?Y2lSMndCQVFKOS9hMU96OWhQaU95YnFqak01ZUllMzMzQ0owRURCS1pHbmZG?=
 =?utf-8?B?M2hQY3lnNXRORHJXWnFEeitFUnlEWmhlZHB0ZlBUMStpTlk0U1NZNFhBRStU?=
 =?utf-8?B?ek5JMmYremE5VHZlUkl4SUxvV2E5TVVrcWJEa08wNnozRngxL3J5VDNHcTJ4?=
 =?utf-8?B?NGJyVlBOVDgxaVEvTDZBVVBZTnJDRlR2Tm1Hckw4dDFUL011SmpZRUdUaHpt?=
 =?utf-8?B?VHBDazV6bDZvREl0aDNkbk1UTkdWTTQwQ3FLZ3IvL1ZBTk5BN1dFT2QvSHdX?=
 =?utf-8?B?OFpsQzJ1Z0VDSnJYZkNFeXFiR1gxUHNJYjBJTWMzRXUxM2M1SmlyalMrN3pi?=
 =?utf-8?B?bklrVjhUNENQaE1FbnR5QXBoaUpIMjJObHNmWU9mMmQzeUQzSkZBaVQwei9a?=
 =?utf-8?B?RnZYek91TFUwRWpnUHQ0d2I4Z29CcGpxOWtwMFJINUhGMHZjMWNjS2FkMkNi?=
 =?utf-8?B?RG9JTGFFdVJXcUU5RGJvYk10Q2F3dFNvWTBUQzNiMGZ4U3l0bHhRNFpNcTZp?=
 =?utf-8?B?Tm9GWWhBSXhSaFF0NkI1REkrdzcvaFo4ckM5SEhMYUVxNDg0SkpHWSt0cE5C?=
 =?utf-8?B?SHRLRzQrTDFYbHZWSTJncWljTGphbkxaOWliS0lBOWFaYVIzVUxWU24rV002?=
 =?utf-8?B?aHlFSFllZkVKSi8vSTkvYXoxSWJ4anRQcHZnaHFVZnVRTDZxN0k1MExzeSt1?=
 =?utf-8?B?SHdNak50MS9iWHVBK2NFOHhBN0ZsZ2RPR1BhSC96QzRNeDdEcFcrbU9McDNV?=
 =?utf-8?B?cWN4NnYyVm5CRG0wOXl1bVp5QUJVOEduYi9UY0ZjTE9SS2g0WkdOaU9aTlp4?=
 =?utf-8?B?TnlZOUdCUzU3ZWtIcExHVWoxajRLRTlFdjFjWnNtdUxKcmxNTjdWVG1YdnhC?=
 =?utf-8?B?UURJSm00ekZ0QzZlejdEdFlnMHBGUU4vS2NSTEc4TER2c01COSs2d0p2YzA3?=
 =?utf-8?B?N01IRVhlR29qci9zN3VEbG0xbUZXSWZpRXZaWFlQWi9EUm8yS0RxM3FqeE5m?=
 =?utf-8?B?MUlZNko4aVAwVEkvU0R4dC85aGJTaFlBbHdnOVBmSWRHUjNIZEdhaXpmYnRz?=
 =?utf-8?B?TXdad2JsMHFCcFp3QnhVVXkzdVNxVkNnd2Y5MEZsdVdsNXI5Mk4vT1YvaTh1?=
 =?utf-8?B?VzEzUTV2cjZWOEg5Y1dNUEdicFJaMVZjOUZTalhVQ3l3OEhEaEE3ZFJ1M1FF?=
 =?utf-8?B?Vldzby9nQUxkSkZyTUZBbFIwQVo4U0hwN0hyVkNTR0tXdUhVOWR0L0RiY2ZX?=
 =?utf-8?B?NGJHUGg3UWpNQUs0VS96UTNEclpyeGRvS3NtOThTeVM1eWZVaWZmemgyVVhw?=
 =?utf-8?Q?aZV1kIIZ10dgKdaMdGyhuRZNY?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69207c5e-60ab-4d5c-749f-08db4b156b16
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 13:59:16.9164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZdIcWZIzGJGJfUqyucnCql0IQ3fSJ3FGwyPnaFj4EZPrboi9N+xatsgQwDhfKWTkZb2R16pxRTl7IdR92QMyXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5220
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 May 2023 13:59:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11378

Hi Uli,

we are seeing

[   31.479488] ================================================
[   31.505101] [ BUG: lock held when returning to user space! ]
[   31.510778] 4.4.302-cip74-st39+ #1 Not tainted
[   31.518272] ------------------------------------------------
[   31.526443] systemd-udevd/207 is leaving the kernel with locks still held!
[   31.550597] 1 lock held by systemd-udevd/207:
[   31.560126]  #0:  (&dev->mutex){......}, at: [<ffffffff816cd4c3>] read_descriptors+0x43/0x120

since 4.4.302-cip74. -cip71 was fine. That kernel is patched (Xenomai/I-
pipe), but the error is rather pointing to a vanilla issue. How about 
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/?id=572efb3c45b5c741f0642c63553d3979b2cb27b6 ?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

