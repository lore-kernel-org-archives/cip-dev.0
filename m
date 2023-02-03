Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8F2C636CC
	for <webhook@archiver.kernel.org>; Fri,  3 Feb 2023 09:22:59 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.77])
 by mx.groups.io with SMTP id smtpd.web11.6906.1675416167947164046
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Feb 2023 01:22:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=BYKKlYKk;
 spf=pass (domain: siemens.com, ip: 40.107.13.77, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMKx2JirRAvzwCPG1hb821TqMZ0BFtBxd0fGfqYH1dDz5whJuEgWnDjMEmC0EHavLVezyvol/p/pCZ5FyzwGc2WGL3Q+6U0v5A575OLQiR7y/vmPHXq8gja4lhtP5DEfRQRaUjPMuGuPeggww7/kaXm97inkZXDqRYJhemDIUQnAajIfcyZbOTsHAZuVFYFdshKgK/BmX+8brCNcwSeHUxbjNp3cZIhOWYqWyi2hyDSI2MQ4K/uVqjgnsWH6zR4PB3oIa01TSPU7nh1RPPJ6gVJYFJCdi46crKOzRRXre+TTW7aLFIaUJfnCyfW05dNSG0Xl3rdNfexJaoUu6QmdLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iajCEl+ld1jC9LX9j0FjJYoiJEbmdxLQ17xo+M0BzAs=;
 b=NoNlRRIBu+c2/JuxI/pkTTjOroxDVZxK7WQT9ot4cP6iFzmH4w94xSp1fvxfyKuP+7sSLslr3VTVYtm0FUg7FNwQg2/Wy0KKJZpCcr+v7x8O9cEyBu49XuA8Tx7W9ZhIdWv7PhHcs6sbJsKKFpekVg5IWoXsK0CUf+io6A13/yjA7n6moFWhS7JDwnx2sKm2ItkogEexiiRlEwFGR3NC2aKn7BfNwnhbk0bnqLVXdgOBBUw02J478SHBY8ajsoIPGCN0yd7FOYK6XYmB/2oxxma25V/0+4jlXdYjSpZt8Ko7U4QJWESovTLiuIEFPgEymSkZ99n0/FomsYLDDkQTNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iajCEl+ld1jC9LX9j0FjJYoiJEbmdxLQ17xo+M0BzAs=;
 b=BYKKlYKkZYlzBn3V5AMMJrSkD7/Az5x4JxnyQDRjVx/bfhSozTsT8rdVxsjrXnc1gpiafsKM9CoBCpgrd52HzGkOc5sjI2vOCJTLDrNuwkiPF+YL8eVqBxpwILsy0nzcT8kDTOjluZENBr9o42G8AcL2cuoYUTqdZWOTvrbTZIt+pFslf+qAfr3kySD84fod4l0FT4tMuFv6g3sp1YL+ViRiRhWdbkkgNyUEtQytrp1Ux4N4BFD1B6yWt1631C4MMb+ZTo0WebwD+g20C3h9Op/VD4XSu8pJizIdfjEa9XNo/8z2RF/9G/BA0HRTUL7lL/gYmNSPTuxvbH/WoARwJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB6766.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:32e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.28; Fri, 3 Feb
 2023 09:22:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%8]) with mapi id 15.20.6043.030; Fri, 3 Feb 2023
 09:22:44 +0000
Message-ID: <19c2419e-7a18-7c86-558e-7813d5000b9b@siemens.com>
Date: Fri, 3 Feb 2023 10:22:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 2/2] conf/distro: Rename
 debian-sid.list to cip-debian-sid-snapshot.list
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20230203082516.27690-1-Quirin.Gylstorff@siemens.com>
 <20230203082516.27690-3-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230203082516.27690-3-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ec21ffe-926c-4371-823e-08db05c834c3
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ki/7+7XNdABL7tJf8nL8EobJOx+LJbnRIAPgMH4rcWmtBTKX1cp83h/2E/jBJw2iuumgRtRrIehUsZxvF5FkZutO6UjihA352OkJY/4Kb45NaoTCvO66XYrwzIUKiBmRZcVORGQeHR99vRx2iKDW8xRHxcLZc1PPMm6Fei3rrjM9ffs2ABfAEWDobpgNGYw2Li9c35h8g/eSX564oMzifWoyV5NRvO+rrZik0nzqMWYGcddJj/y8tDKiNY+ffolfzRIiO+2dFhjsD6rFwdcrPhQLpe53V02WSIXuQMHkE9jeqrhqjdPtMk3MnB7vWOb2WQXDMl+6aE9r3hI4qQiQ4kBC7aGkzwoYlCW4H9XlaNpvqCAiE+hI0mXHfFvfdRSyy2moz8WMF8d1pJi4G1IMuxRwR/ilMhigzCAnBqQSBCvK+HLp8rCRnxj/j92CRT6BIMmBRJ/9/N7xbdSxhFLZ7QHkXplsMT/wqCZtIzm/+quTM43HL+BbN/0ioqTlht36BVoKfaKZ+S/8YNhvOQ5Vk28FQKpsaiql/nbbS8nRmgwkWDadGTrPo/m1JpFuvJw8eMT/xayxXhYULjsiYE7yhYYaFyfs5JFLA47i/yoLl4mnu+6hPNV8kmD6KPTvjjjzzRNdwmDaN3wyfc5CcJhzFc5oKssKg1DFLXCnDbpppL1U69FN2KaIkdkGpKcuBMNzROl7tmQkynDh8r5hww/GM/hspkhYHP9KQEd/lU0Q8UJYYgjB+ZPdNW6kRlWJozR9zyvQyWkwCiWcY3+vwiGngzgKNQ3HT4d5N5GgWm2/xbs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199018)(2906002)(31686004)(4744005)(26005)(53546011)(44832011)(5660300002)(41300700001)(8936002)(8676002)(31696002)(86362001)(316002)(36756003)(82960400001)(6486002)(478600001)(6666004)(66476007)(186003)(6506007)(6512007)(38100700002)(66556008)(2616005)(83380400001)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TnJhemduZ28zOHJIUzE5ellDYy9tdzEzTWZNQ2QzQTVmZFhNVDI1UGF6aFFF?=
 =?utf-8?B?OVJ5b2hrYjZpazV3TU00T3VXSWxJWkZjVUtkdHh2RnZKa2dHTVVRcG15WXJH?=
 =?utf-8?B?NzFBVGpHVHJ3OUtVZTZUMFRaMjEwaTZjaU9MSm04SkZNdU5pRUtyREYzTnZw?=
 =?utf-8?B?V3JpeW5qak1seHdWVUxBa0xUZDBHNnoreEJKUFpTeXpldlc4V3FZUjh0NjB6?=
 =?utf-8?B?QzVqdkc3aHh3UFo3NXR4bVpFeUt6Znk0QkUxZzUrOGNYSzkzVXVQN3V5Vmww?=
 =?utf-8?B?cjhEK1k2YlN5cWwrWXVCa1NESy9VS04wQVFGZy9jZ3JuUENCR3IzOERJNU15?=
 =?utf-8?B?VUR5T1hQeVhjSWZ5TFdJbnlaQ1JzMVErc0taT2dwVkNUWXJQT2xRaDZTbHdp?=
 =?utf-8?B?Wk52WTVoMUg3ZFd0QzhDdnNSL1pkUnRuQ0I1N1h3M0VCRno4VDd0MUthdW5L?=
 =?utf-8?B?eEtrU2FvNW15anJuSW90KzdCazdhNmRvZmdSNTkxQjhqUzRsNDJpa0FIczdy?=
 =?utf-8?B?OG5Cc1l1YWlOVXBuWXV4bFlGRHdYMnJvOHJTZzg5MHNDdTU1VVhqYVdJZnNa?=
 =?utf-8?B?VDloL1pnQnhDc0N1cXZncUxhV1RPTHE5elZCditmekkxaEVsMVR6YmFQbCtQ?=
 =?utf-8?B?YmdBaUJKNHVZeTQ0ZXVSdXBmY2U1WW56WkM3eDc4UU5LZFdpd3ErZDg1Um16?=
 =?utf-8?B?TGZVRFFzUHp4dDkwWnh2NU01WExOSEhFNFp0a1VpUlJocTUyTU1UaDZxYnZO?=
 =?utf-8?B?bTNsbTJvWkFQVTZWbHM4TjNYa3hQWTRabkUvVDVZaFAwUklUZG9VRVIwRUp0?=
 =?utf-8?B?Zkk0aU9aNWF5SEhscjA5a2dwdzdDamE2eXUwR2tOV3h5bHBGU1A3Qk9TNU1y?=
 =?utf-8?B?RDgyWG15ZzVwR2hybks3d0lsbDgvVHFNL0RUM21RZDdYUTljQUhqL0JyYmxZ?=
 =?utf-8?B?cTVheVhOK29nQ3pRWEp0MmhWSC9QM2NPRE95S0RFTlhDckZjanhKR1FYSnRa?=
 =?utf-8?B?LzMxQSszZzJ0bytWbE1RaFZadGRVaGV0TnQrdmtIMExSWlFNUHhKb1FYQk5n?=
 =?utf-8?B?K084emZNQUFGdVJnTFM1QmxwNzFldm9QL256MUNEaXFhdHZUeXVQWTJsdmNF?=
 =?utf-8?B?VXhZd1lWL2pJZzhDblhJM0xGYVVjWGhvZlpsRmNaak1rSUNaSVpKaHU3YlJ1?=
 =?utf-8?B?TGZrQTFQWVk1bG0wRHJxeC9tVlE3QzlvbDZqRCs5bWxLM2RvUmI1V0U1NG4z?=
 =?utf-8?B?SHlMWHNuczVpTld6SVlRMitqZnBWTW5oSkdFVzdoc1hkZlRIZTEwSFA2ZTdi?=
 =?utf-8?B?QmlIS2JrYnVZRWNUVWIvRjUxOHpVcGZlVGREdFlaUUJWdUxQaHdEVW1vcEVB?=
 =?utf-8?B?OVZhYmVla1oxQU13TWQxY3pLRmR6R1NzaU5JTG5nbzdHaE14ZWpkOUtHaTlh?=
 =?utf-8?B?TzlQL3kzT0J5VlpxRGs3eGJKcnBncjczakVkYk84cW12NXZSWmN2cDcvcm95?=
 =?utf-8?B?YTRFRFVycG84WDlRdUUxK1c0Q2YyR3B0cEtvcUpQemR3ZXJMSU9HcVB1Znlv?=
 =?utf-8?B?Mi9SRnJHMEp1ajkrOS9uUU1pdHVueEhUTHlhdTdJbC9HYzlKcW5xb1ZkcFk2?=
 =?utf-8?B?dzhvcm5jbHVJQkNIVHVheTdxWFVHMzVLb1pCYmZJckY4U3VCNk5tVnp3SnVs?=
 =?utf-8?B?cUJ6cmZwZDNqeEt4U0k0S2k3T0RkVzBKN0RsRTRpOEhkNjlDV09CeXpRY0ll?=
 =?utf-8?B?eFlhY0twbS9FeUtSd1lzclMxV096VGo2U0lqSWwwQXVwM2NaWVl4UkoyN1Va?=
 =?utf-8?B?TFJ5eXh6ZVE0Y0JiZnFxWVNGRjlyMTc0RTRjb0padXZQK3F1QXNNZGRDUGwv?=
 =?utf-8?B?RXVmanczRStoakcwbTVYakJDWW1ya1VnN28xQjJhVDJITmt3MU5OQUhKZHFu?=
 =?utf-8?B?YTdseWNSZm5SeUx1eHBSTzA5aUtVQmQvMkhKQW91MUd2ekg3d3ljMWlTUHpO?=
 =?utf-8?B?OXdnOCtaVUw3MjFCQTFpdnp5RXU5N1BPNjl4dmMvUFl1UStSNmJDdk41bW5O?=
 =?utf-8?B?eWpZNnN0Y2tEZzBPYTAyaXhSWVZ3dXBLa1EzZzdsWTB3RE1taTRod0VEbFJi?=
 =?utf-8?B?UnZCcFpJa0FKNXZFczF5OVlGYnNWcTY3a3Q2aVpkb0RVTnJlQS82L0htMjl2?=
 =?utf-8?B?ZFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec21ffe-926c-4371-823e-08db05c834c3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 09:22:44.1757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PEKWxRhHxWPOhsifyKYHs5w3Y5lrQDAjUXWonxe8S+qz+bLau5Ki9o8xh1GxBkLibhQqA19YNlsSw7TYxslFrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6766
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Feb 2023 09:22:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10582

On 03.02.23 09:25, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This is done to avoid infecting other layers with the snapshot version.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  conf/distro/{debian-sid.list => cip-debian-sid-snapshot.list} | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename conf/distro/{debian-sid.list => cip-debian-sid-snapshot.list} (100%)
> 
> diff --git a/conf/distro/debian-sid.list b/conf/distro/cip-debian-sid-snapshot.list
> similarity index 100%
> rename from conf/distro/debian-sid.list
> rename to conf/distro/cip-debian-sid-snapshot.list

And who is now using this?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


