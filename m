Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE1BC02180
	for <webhook@archiver.kernel.org>; Thu, 16 Jan 2025 06:36:48 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.89])
 by mx.groups.io with SMTP id smtpd.web11.43142.1737009405594749618
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Jan 2025 22:36:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=OPU1xlkA;
 spf=pass (domain: siemens.com, ip: 40.107.20.89, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gMzvl9QYVeREIx8aq1iH7pXP0E4KOksxamBJYHSPmV7QxQkA9H+DswDTCtvEmN3fWf50ZuAw50TAQpsF6LTVC7H3ie2ZPA1LmINKvrDkxlXhEOUEoUr749uXNPqAlDt83iRQhnW3u1xJgIjwPqvQI2ljr+aqSdCwa37qoRMhJve/8xredAF5C/DDAH4r/W79UbM/URHf/Xl6VjyBWqx+e/3yeoUluyD3DYt38ktLw/1l1trpw7gKKHvTjPRRM1V3Jo1sEg2KJNTaAb+M/G26qXo5XqTOk/r+4BvGzvQAQ/7xBrjGvlhipZewIjEZ6495mAxTGV1WIaHMla6RQGNTCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lATtyieKibuRJitcsqtL3m9wO8zzIRKOqvRn8946quU=;
 b=n7QWNdkDaN04+fpkDOLU+/wgHfMsoj1BqzfZwhpgXgOyRnLdOrhgUEf+QBc3maxDs3Tmz5EPsEzaVLJZ9xhqZXLYpFllG1PdJJTUgJRiLwbRxc+OC7hMjfpRk7yEJYlSxlqQczt9PBPWkTkiH8Rf6t9QQGBcx1avVYQ7hoJWWXlTpdFSwsrY5BVd/ZqnajycwNUAA+7DHpZW6GkcaLtYZHgIMTZejdtKBIbXrRapd2yDKI/ly4c4RCPoLRTFR4Fk5tqVhX2i5oZI04buXwsuv+3Pzs2LAg9RC47i9XHBfVs3k6GQQ7AJA693kO3d+VXW0wAYH8HW+wtjbLw2+bmwcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lATtyieKibuRJitcsqtL3m9wO8zzIRKOqvRn8946quU=;
 b=OPU1xlkAgeOKdHjuv8vKr11rkcFoZopneZqb2mnE6aWr37hvkyolETH6qw8yGjZNw3PA0hMxXDU3RsnJpJCRNlPP1caRKlQN+aaoi7hvx5JrLmKkztQKXcGIZTutuxUN38ivsk2oPjCYMOKdL2ERV/lbvJgJ8TJAxG6cAnCSW0DgjBNTlY6kPEN/gENOL6k3r2qKdhlONJWj6QJ1KVTEG2VMhhS1hz/yolStX1PM0rKfwoDSe61iZFmxVj6DyKlbZiXkSP//V3qjgajEFA2B1+4y7yzoYrvgAOrZvTZLBhrmBOjktSFviiKLtulfFRKp99CLQajlYbr1XFYDCA66Ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6320.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.11; Thu, 16 Jan
 2025 06:36:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 06:36:42 +0000
Message-ID: <b72bff34-ee63-4b3d-8383-c4d8de52e5bf@siemens.com>
Date: Thu, 16 Jan 2025 07:36:40 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 xsFNBGZY+hkBEACkdtFD81AUVtTVX+UEiUFs7ZQPQsdFpzVmr6R3D059f+lzr4Mlg6KKAcNZ
 uNUqthIkgLGWzKugodvkcCK8Wbyw+1vxcl4Lw56WezLsOTfu7oi7Z0vp1XkrLcM0tofTbClW
 xMA964mgUlBT2m/J/ybZd945D0wU57k/smGzDAxkpJgHBrYE/iJWcu46jkGZaLjK4xcMoBWB
 I6hW9Njxx3Ek0fpLO3876bszc8KjcHOulKreK+ezyJ01Hvbx85s68XWN6N2ulLGtk7E/sXlb
 79hylHy5QuU9mZdsRjjRGJb0H9Buzfuz0XrcwOTMJq7e7fbN0QakjivAXsmXim+s5dlKlZjr
 L3ILWte4ah7cGgqc06nFb5jOhnGnZwnKJlpuod3pc/BFaFGtVHvyoRgxJ9tmDZnjzMfu8YrA
 +MVv6muwbHnEAeh/f8e9O+oeouqTBzgcaWTq81IyS56/UD6U5GHet9Pz1MB15nnzVcyZXIoC
 roIhgCUkcl+5m2Z9G56bkiUcFq0IcACzjcRPWvwA09ZbRHXAK/ao/+vPAIMnU6OTx3ejsbHn
 oh6VpHD3tucIt+xA4/l3LlkZMt5FZjFdkZUuAVU6kBAwElNBCYcrrLYZBRkSGPGDGYZmXAW/
 VkNUVTJkRg6MGIeqZmpeoaV2xaIGHBSTDX8+b0c0hT/Bgzjv8QARAQABzSNKYW4gS2lzemth
 IDxqYW4ua2lzemthQHNpZW1lbnMuY29tPsLBlAQTAQoAPhYhBABMZH11cs99cr20+2mdhQqf
 QXvYBQJmWPvXAhsDBQkFo5qABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEGmdhQqfQXvY
 zPAP/jGiVJ2VgPcRWt2P8FbByfrJJAPCsos+SZpncRi7tl9yTEpS+t57h7myEKPdB3L+kxzg
 K3dt1UhYp4FeIHA3jpJYaFvD7kNZJZ1cU55QXrJI3xu/xfB6VhCs+VAUlt7XhOsOmTQqCpH7
 pRcZ5juxZCOxXG2fTQTQo0gfF5+PQwQYUp0NdTbVox5PTx5RK3KfPqmAJsBKdwEaIkuY9FbM
 9lGg8XBNzD2R/13cCd4hRrZDtyegrtocpBAruVqOZhsMb/h7Wd0TGoJ/zJr3w3WnDM08c+RA
 5LHMbiA29MXq1KxlnsYDfWB8ts3HIJ3ROBvagA20mbOm26ddeFjLdGcBTrzbHbzCReEtN++s
 gZneKsYiueFDTxXjUOJgp8JDdVPM+++axSMo2js8TwVefTfCYt0oWMEqlQqSqgQwIuzpRO6I
 ik7HAFq8fssy2cY8Imofbj77uKz0BNZC/1nGG1OI9cU2jHrqsn1i95KaS6fPu4EN6XP/Gi/O
 0DxND+HEyzVqhUJkvXUhTsOzgzWAvW9BlkKRiVizKM6PLsVm/XmeapGs4ir/U8OzKI+SM3R8
 VMW8eovWgXNUQ9F2vS1dHO8eRn2UqDKBZSo+qCRWLRtsqNzmU4N0zuGqZSaDCvkMwF6kIRkD
 ZkDjjYQtoftPGchLBTUzeUa2gfOr1T4xSQUHhPL8zsFNBGZY+hkBEADb5quW4M0eaWPIjqY6
 aC/vHCmpELmS/HMa5zlA0dWlxCPEjkchN8W4PB+NMOXFEJuKLLFs6+s5/KlNok/kGKg4fITf
 Vcd+BQd/YRks3qFifckU+kxoXpTc2bksTtLuiPkcyFmjBph/BGms35mvOA0OaEO6fQbauiHa
 QnYrgUQM+YD4uFoQOLnWTPmBjccoPuiJDafzLxwj4r+JH4fA/4zzDa5OFbfVq3ieYGqiBrtj
 tBFv5epVvGK1zoQ+Rc+h5+dCWPwC2i3cXTUVf0woepF8mUXFcNhY+Eh8vvh1lxfD35z2CJeY
 txMcA44Lp06kArpWDjGJddd+OTmUkFWeYtAdaCpj/GItuJcQZkaaTeiHqPPrbvXM361rtvaw
 XFUzUlvoW1Sb7/SeE/BtWoxkeZOgsqouXPTjlFLapvLu5g9MPNimjkYqukASq/+e8MMKP+EE
 v3BAFVFGvNE3UlNRh+ppBqBUZiqkzg4q2hfeTjnivgChzXlvfTx9M6BJmuDnYAho4BA6vRh4
 Dr7LYTLIwGjguIuuQcP2ENN+l32nidy154zCEp5/Rv4K8SYdVegrQ7rWiULgDz9VQWo2zAjo
 TgFKg3AE3ujDy4V2VndtkMRYpwwuilCDQ+Bpb5ixfbFyZ4oVGs6F3jhtWN5Uu43FhHSCqUv8
 FCzl44AyGulVYU7hTQARAQABwsF8BBgBCgAmFiEEAExkfXVyz31yvbT7aZ2FCp9Be9gFAmZY
 +hkCGwwFCQWjmoAACgkQaZ2FCp9Be9hN3g/8CdNqlOfBZGCFNZ8Kf4tpRpeN3TGmekGRpohU
 bBMvHYiWW8SvmCgEuBokS+Lx3pyPJQCYZDXLCq47gsLdnhVcQ2ZKNCrr9yhrj6kHxe1Sqv1S
 MhxD8dBqW6CFe/mbiK9wEMDIqys7L0Xy/lgCFxZswlBW3eU2Zacdo0fDzLiJm9I0C9iPZzkJ
 gITjoqsiIi/5c3eCY2s2OENL9VPXiH1GPQfHZ23ouiMf+ojVZ7kycLjz+nFr5A14w/B7uHjz
 uL6tnA+AtGCredDne66LSK3HD0vC7569sZ/j8kGKjlUtC+zm0j03iPI6gi8YeCn9b4F8sLpB
 lBdlqo9BB+uqoM6F8zMfIfDsqjB0r/q7WeJaI8NKfFwNOGPuo93N+WUyBi2yYCXMOgBUifm0
 T6Hbf3SHQpbA56wcKPWJqAC2iFaxNDowcJij9LtEqOlToCMtDBekDwchRvqrWN1mDXLg+av8
 qH4kDzsqKX8zzTzfAWFxrkXA/kFpR3JsMzNmvextkN2kOLCCHkym0zz5Y3vxaYtbXG2wTrqJ
 8WpkWIE8STUhQa9AkezgucXN7r6uSrzW8IQXxBInZwFIyBgM0f/fzyNqzThFT15QMrYUqhhW
 ZffO4PeNJOUYfXdH13A6rbU0y6xE7Okuoa01EqNi9yqyLA8gPgg/DhOpGtK8KokCsdYsTbk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0P190CA0004.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: 7978c78a-2a61-46ab-af99-08dd35f82387
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QW8rTkU1MENxOTBEdXRqMFgxV0FKMkNKWlo0RWhWU1BoeEdYNjhlZzc3bDlD?=
 =?utf-8?B?bllPZkQ3cHh5a2dJM2JPQU55c0lBSXROWUY0Y1l4b1FQU3M4UHlWNkpNT1RK?=
 =?utf-8?B?NDkwUi94dENaRDdJa0ZnZUoyMzQvblpaQjZyUDFiUzhIZFJncFM5VHFXblRh?=
 =?utf-8?B?a1VGMWs3OG1SYTBMSE1YVmtUUkhmdTZBQXcyKy9yVnJ3WmExV2JpTjRiellY?=
 =?utf-8?B?NFR0UHg0RTJhMHcrc2orVGYxaG0zRlBTVU4xQVRrTWZxWFgvZGpJUHF6cFBM?=
 =?utf-8?B?YmtEYzFaaVcyTjQ3THQ0d2lJeGs0YVpURXBvOWFScUJTbWVQeDRaeDBVNUpz?=
 =?utf-8?B?T3RHcFp3SFUrOElzcE9nZWVsU2FGZWp6aUhqbk1wSHcrL3Qyd1FvOWJ2Q0ps?=
 =?utf-8?B?NkErWjlpQU4rUFpHN1MzbHkyNDlJTThZRmxvUnc4U0RYQzNsSlNnR3RZNlN6?=
 =?utf-8?B?RjQ2RC9oeVNYRTZZNGpDK0hVYnNhSG9hVmVYS1AzSXo2L2EwS2xZdkM0djIw?=
 =?utf-8?B?bUdTVDhlVENnQU4yZDNrT3NTcitaL08yQ09KTC9Rbmx1bEQxdkROZ1hqcHZ6?=
 =?utf-8?B?T0NYbmFpUjdtK25ZWlNLU0thcFJ1U0hZUCtma1NSRlJRN201VEY3YUhZdzlU?=
 =?utf-8?B?blB6MUVPdUwxNk54Wm43MWlpbEMxTldNZzY0cGd5RnpLODY0djgrS2JzN2NM?=
 =?utf-8?B?clk3ekY5MEFvR2RWVXN0NmxkUmZrTU1kNytpOEU0VlNlZzAxZXpWMm9ORks4?=
 =?utf-8?B?VlVJNERuZjdvUUVPQmhPU1VkeklRK3A4Q21GTk1URmozcS9ielZKL2lBZTAy?=
 =?utf-8?B?ZEpLQzNiTCtIM0p3MWU2TEVUelEweklNOHQrb0pqZkpGSEYxYVdGRVdoeVJo?=
 =?utf-8?B?U3JEellDQ1o2Q0NvNHZDdGxMbHlDY1hoZ1l1YXc4QWQ5dG9TT2ovR05HWm5T?=
 =?utf-8?B?QzdpeWgyaUVSaEhBalNaYzlYQWRranVkay9abnR1cHRQMUlLOW9HUkFVdFdN?=
 =?utf-8?B?QjhjcjFTZ0xFWFA0djVsTXQ4UUdiQklsTG5JMkV5ZmJPWExpMUNaWXp3Z3Zu?=
 =?utf-8?B?d2g1Mi91WVozMHRoRi9CaWpSQUJ6Z1pPdXRWVitmY2psL2w1RTVaWVp0VFJP?=
 =?utf-8?B?TEUwbitIbFFGek9SOTgvVmZNSVNsVGpzWkp4YkJEVnBjc1U0VTVLQTVIM1Jn?=
 =?utf-8?B?a2VkRnRDRW8xSjVjdmo1L2gyNHFNYlhlNVVKSWp2Z0RUSy9nbEIzNnVBeFNt?=
 =?utf-8?B?aDgzaDVGOFFnNFRnVVdlMG5UWGMranRhUlVvZk5RTlYvV0JNOURUU1NnT1JE?=
 =?utf-8?B?M2E1UHFoRDBZRjNkS0RuT3hmbFVtVjI3QjA5RXJGdzBjNlJ3K1BMUFZqSTJq?=
 =?utf-8?B?b3dzQ3FNVFhYRjA1aVNxT2c5VjNzQm55T2FqZ2ZwUElsYzlLajI4T1Fkc0lB?=
 =?utf-8?B?MHNNZmZHTGxZenYrWGs3ZFhBSCtPY1g5ZEVSSk5XMy90ZUZlMHU2V2drWC9J?=
 =?utf-8?B?a1dDYnNtTVE1enkydHlFZFlMOG5UV1ZyZ1Qra1dMemJLMzhiT0IrL0ozT3B0?=
 =?utf-8?B?Q0VKa2tET3dmZzBiSUFCcGxadjcraEw0Z3pkRllXaVlDdCs4YlV3UEtXSWV2?=
 =?utf-8?B?NnNmanplWnRBd3l2cThwSFFWSDR5TnJqYXZMMURPUmFXcllHTS9MYjRDOFV5?=
 =?utf-8?B?U1BjTzBZbkRsOW1vSDRWcUt2blJJcW1nSVIvWm5YZVJkMGdCOWtSeGJhYjdY?=
 =?utf-8?B?eUpEdmk5L1VVeERqNXFxQzNCVmRsOXA1amhXNG1DY1BaVjRlMDNzNHhFcEEv?=
 =?utf-8?B?S2FDbi9NSzdYRjhOWnRQUT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aUdydWFCR1NSZFpzNkpBQkg2cWNtc0Z6SklFMHoyWUczQVMvRHRzQXZvR0Q0?=
 =?utf-8?B?SEZtWVZiczJGT256VWViK1NaWEhPaUNKcmJrbnBNczZ5NFNHTmJFOEREczhZ?=
 =?utf-8?B?VG82d2VieTEvRlpqd1dOOHc2ZlBwOVFjNC9CTmlDY00yQWR0c2VKVzZpaVpP?=
 =?utf-8?B?NEF6L0lJbFpFbjJ1dmwzTDdZYm95N1pmZkFwVm1kMkFvajFrbmZMVkhYemlY?=
 =?utf-8?B?RFNGc0dRTGxJdE9MOVpZMEtnajJQd0xMc2xNZFBrSlcyNWN6TkNVdzlvcHBj?=
 =?utf-8?B?aktDaGFBdjRDNUNaN1dxVzZnYkRzbzRaVHlQcmVRcFZHcGZ4Y0tKN1IxQmF4?=
 =?utf-8?B?K0txdm1IUnREVzVZSFFuUU55UHpxczA0OVp4NllqL1I5eHBJVWN0a2RtSm9z?=
 =?utf-8?B?Z1hMZkpKUW1mcERuQlBYd2lTeEJGUEtra2ozZWl1cWlLa3J3WUhiZXYvc3Ar?=
 =?utf-8?B?RFZiTVNzbjYreXQxYXR5STBXb2NlL00wVVBpQW5OODRBcEllOVpLNEVFdldW?=
 =?utf-8?B?THJKVDAxQVFDMkRXOWJ5cGJSejZXcHo1c0IrZCt4U0xJZGlJYlR4QTJVbllD?=
 =?utf-8?B?MWFOWUQ4MGRkdnAvWllDeFhXTGdHSm5zYWJmeU4wYUY2OFE2NDVIdjluRmpL?=
 =?utf-8?B?QTA1bTkwd3ByOXd4SVNwZ1QzSmhYMUFxejNONURzOWZXVm5TRWVkS1VWc3Rn?=
 =?utf-8?B?cHFYb04vR0loZ3JnYVFPZW5EY3p6b25wRE5UMHhOa2V6UjF6SmVMcEIwTUU5?=
 =?utf-8?B?UXRqMERyeTM3NnFyME9ac0ExNm9jL2ErYTJDSXZvelNUeXRMcHRXVW8zRUk1?=
 =?utf-8?B?NkNpWDlsd1gzdW9XR3MvUFJkVk56ODBPamdjSW00eFgyK0xqR1orWVNqRmtF?=
 =?utf-8?B?ZmFlVWR2YlRuczJNRHQ5a2F2c0JXaG1qbllJTnJhSUhJTmZZK0dRK0thaFZh?=
 =?utf-8?B?UENBNWNHa1Iyek9ocllEcGlOYittRm5UZklVN2E1NXdUQVdHT2VqOHpXQ09a?=
 =?utf-8?B?MVRGNkRzQXpmalBTV0tSRTlFNXgwVzlNUERDakdHcmVsWnpRMmRJTnJITmI1?=
 =?utf-8?B?QUl0bmxRMjV5YUhSUENwbGxXMG5KRzB3V0ZzQ3d6QWV4TWkzQWJNamxZUW5n?=
 =?utf-8?B?eFJ0ZGd1YkIrdFlPWXFBQ0hJN2txd2VpZUplS01PTTZ5K21wWDBUendiSGlv?=
 =?utf-8?B?NW0vSXZRdVRHblhUZEZ4YzkwWndQMFFhWjhiQnhVUDVMdEJ4RWhYdDJoYzA1?=
 =?utf-8?B?c282MThNZWQyZWxHMVdBSU5QK3FOSVh3MU93cHVHU1Y4UytVOE9PbHF6L1k5?=
 =?utf-8?B?djNxaHpCYkY4MjJleDQ1V09vRUxhcHNWTS93VXdpYU5PZmdQbndDWVhDSDZQ?=
 =?utf-8?B?VFNGdU9PZW9Uclk3ZzEwLzFSZENad2ZmcGRmenNkMFFmQkFBN3RKQ3ZxNTY5?=
 =?utf-8?B?Ky9HdlRKOGNOQjF0MHNOenVPdXFEaFJLdXBUVDFueXQyVkRqc0ZFbDRnVFJR?=
 =?utf-8?B?SjVVZG9NT2R2cjZjTTRLcDN4ak1OZE0zeXFhcGdrSzBMMjN6QmlOcFdwM0Nt?=
 =?utf-8?B?OWpxWloydzdEOThTU1E2cVcxVmZuOWZnM1FINlZDWGpEbVo2NytNNU5uMXhm?=
 =?utf-8?B?T2lDVlhwVitISDhRaWVYcGNQK0hmdC9WQlNFcWFjS29iNllqMUREbGNuM29t?=
 =?utf-8?B?cVJ1R09nTk83R1c5NXZ1TEZUc0xFNFM0ZFFManlFZDl0azVhZHE3L1dFUzVH?=
 =?utf-8?B?Tk1OcnFEbmNIaW1XdVJpb1hKOXFNY2hlSzVTS2lmdllHT2c0aE5zYzhTVHo4?=
 =?utf-8?B?WTlwcGFHR3BNOWUrdnppMmR1Q1NFeFJoRm9tTVhuLzgyUVpqUlRkd3NXR2VP?=
 =?utf-8?B?VmJmWVQ0YlcvZU5vM1JNMWRyWm9XdWp0WmxVNEhicVp3K3JmSURETk9ZdURV?=
 =?utf-8?B?U2xsUktwREVDYWQrOWxmZ1ordzkzWTAzRUxEOElhTWo4czBLcWdNSDlhRE5i?=
 =?utf-8?B?RnJjeHEyajJiNk9JYnR0WmVxbnQ1MmZwcThCbnJkWkw0c3ladXZOT2hVMWtQ?=
 =?utf-8?B?eWJmV3NiT251MUtTQzJSS3ZtdGYwU0xGQXNvaHNnaVlsdlI5YkhhWUpDRXNl?=
 =?utf-8?B?OXdpdmFvVlkzK0YvandUdTdpVHFoajRTTld5MkFRR3JKYXd0eXNzR09wdUVu?=
 =?utf-8?B?TFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7978c78a-2a61-46ab-af99-08dd35f82387
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 06:36:42.1751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: afa2nYm7kCIRcme2yjOAIsTnquc651V4R+SXEC420/obKSozLgQDKmwUh2ACQ5xi2c8SGX8Fn5rApx8JFUZqNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6320
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Jan 2025 06:36:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17542

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=1&day=16&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/01/cip.2025-01-09-13.03.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
  - security contact for CIP kernel (alternative to security@kernel.org)

Jan

[*]
linux-4.4.y-cip: interval 30 day
  latest version release date: Sun Dec 29 08:41:22 AM UTC 2024
  limit date: Tue Jan 28 08:41:22 AM UTC 2025
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Thu Dec 12 10:45:41 AM UTC 2024
  limit date: Mon Feb 10 10:45:41 AM UTC 2025
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Tue Jan 14 02:33:46 AM UTC 2025
  limit date: Thu Feb 13 02:33:46 AM UTC 2025
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Tue Jan 14 11:41:15 AM UTC 2025
  limit date: Sat Mar 15 11:41:15 AM UTC 2025
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Tue Jan 14 02:41:29 AM UTC 2025
  limit date: Thu Feb 13 02:41:29 AM UTC 2025
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Tue Nov 26 03:12:05 PM UTC 2024
  limit date: Sat Jan 25 03:12:05 PM UTC 2025
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Tue Jan 14 03:04:39 AM UTC 2025
  limit date: Wed Jan 29 03:04:39 AM UTC 2025
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Thu Dec 12 10:20:12 AM UTC 2024
  limit date: Sat Jan 11 10:20:12 AM UTC 2025
  Status: *Late*

