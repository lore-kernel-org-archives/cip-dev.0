Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D767FC79FAD
	for <webhook@archiver.kernel.org>; Wed,  9 Sep 2026 11:57:45 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.68])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10219.1788955064714847828
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Sep 2026 04:57:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ZIOFSK0t;
 spf=pass (domain: siemens.com, ip: 52.101.66.68, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTpqQH0Ro18uKI/I5UHA11JTFBJwfIZxVJmzIjW9c4x62SBXfJ6b1PVkFU0V514m5vM2Z/yrhiWRsd/lw0iprLmOWeqQbMg/jBszwRSGx5SL35PAWo2AVgFoiJvz6PXsPxF0mCt0ZJJ70m3B7pTnububCoiPIarf/DGFuK/BVOwXroAAIPDGJR3np3fywOEjrqqPyLOu+Jc3PhIbLQrToXq5qYDmsoabHrac91Bvssd0/DIhbCQgf4ghZL1ZTVIPSXoSdb1iyWmG0qXD1hAQKGOyLxfOwlxWZrLtum5zjIYkW+GjCxxxn6jkHxrxdqC89TNWruzl2GGNuSzqwblEOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGo0lsYq3GWm9IxdniGEJ0B3682ATWNusPMRfLoO6yI=;
 b=E8hIvPWJvzy4I7wbnv9taJrK7GmqBQrdEgKqYdx4VSumJ8fs5r5LyGnwr31nY5dhxP60W1YSYOPA2m+6HxhIL4NOkcTQX0o/w53z74Lm02YyPTgN37ptBOzoKRQj4MRPHw/4d7FxEaMybbvQD632zvUTquzgYoJkeDbQRZwRqoIjKqUFiwfbpeRZN3YuHXD+XXeixlxFHyKUOfKQX5fD/LMzHVVaxResorMy8661w3XgSv4NeF1Rfvyro+H2wytW7GDu/TIvSM1N9GbtqFVe3hF7D/SPa2B+YfZvaHsEL6fsjuRI9KwatdL52GUphMUZixRMjMi4VfnQ+B8uevcPPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGo0lsYq3GWm9IxdniGEJ0B3682ATWNusPMRfLoO6yI=;
 b=ZIOFSK0tYhM0ccxNVkhIPHSSbao1eThxFn7b+HDGIosdo+H7I2vnZVvTn740e16MQKle56P+UeyD1oGoSLJfEoe0TW1Oh8tydD7nYxLfyMvJrO39ZxWdU4xzeDszgGrD/eM8PQ27DOI3hpGdlvMsZRIA7pdNTVuzHwvYz+tdfptHAWc2nlJO+42dECssdWYK1XTQ1IcowDJOSvO/GIoxhTW+j2cljA41FknY14GFd4tHW0P2cmNoT2TEBU+SeS7nMoAsiosODgfxt+dNyMI8UKv0kzwy97enoXJEraLHg0HW8xmUgOuIGiiJAWmeR6lsCuK/urb5KDyZpVeeVi7C2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7664.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:639::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 11:57:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0406.007; Wed, 9 Sep 2026
 11:57:39 +0000
Message-ID: <2ffed3eb-e025-4425-96d9-315ae2d97077@siemens.com>
Date: Wed, 9 Sep 2026 13:57:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] linux-cip: Update to 6.12.108-cip31
To: Badrikesh Prusty <badrikesh.prusty@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20260907094846.359272-1-badrikesh.prusty@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
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
In-Reply-To: <20260907094846.359272-1-badrikesh.prusty@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7664:EE_
X-MS-Office365-Filtering-Correlation-Id: 671c1194-6296-4526-49a7-08df0e698bf2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	BWs8/D6E27vOEIB+0u3Iap0kwULO22pjXx1b1l9meJBSEbazPMWjE5oIBUlVQgF4JVkMTjfF2LoYGxR0Pf9Kr+C8RJKnb73nPmnxhLY59DP2MCl0vv10/bZ62TtdyIwWuc9ea8L5M17CGrjJfJ/6cwV4E2V4mKwUdGwpuxSvmCrMq5i5cvy/Qc+MPjtPgBafeQI5n6qAYRd7hmFEEwZcE7a7BtByMYpF5nCVWyH0DyHDoqR1xHY8NiwImnOkVPOrFvJCIe53yOgljBsQqC2w2QKGQeG79ra58My2vKiJjpm2Ip27j9/u5Xzx+nx/3tYwWS1wBw68KyWCkK4C1jKtI9xARozGMmAcjRI9YccKUrhLJCSv8W3Bwg/AfMwTiOrYcFBBEq2TGoH+KDHsO9PJt1Al8mNNM+o5Mh0InjGI3tO/mRHwbzW0dXkLg1DYq8o29vq5piPNv8bwxl5K+MPPFRd7evAl9+j4/HMAyDaj2bye0caBZ2hrdJDl753SyQJIomwrrKYfQvL2iXmEYPQdF3qCD92XbcrCjlXqbIvNz0CvX0JCKP4QMa9zqVdgB0gJsbwSs4XOXZ+HSMTjiFyn66SNncMzEI/6MO7ie4cRr8IGECToaphaFD8+m6pVRUTTNOqFo2l2KMqXYWZSJIePqxXtEe0bDQD/xqrrAIVUZGs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NDROZklBNHo4ZVMrQU9BTXQyb1NyRXczNGZZaEN0ZjArQ0JEc085TkJXWlYw?=
 =?utf-8?B?MytLNmtCTldKRnlheWcwYUhITG12cHJkcVlaTEs3ZFhHVm9SWGQ0a3gxUmpr?=
 =?utf-8?B?L0E0ZUFYSXlEcGdGOFplZWZKemNud0I0VHhaNlU5R2NxOVJkOEZUdHltRjJU?=
 =?utf-8?B?S0ZnZFVxNExINFJVY2J2VFVlb084MHBCVndVMm8wK0hPN0d2WGdybW51cldE?=
 =?utf-8?B?V05OTHZRdHBFSEFRS25OOGU0N254d2JHMjA0TDZIUkVtTzRXckJxTDVXZ1ZQ?=
 =?utf-8?B?bzJyUjFISU9rVXlXZEduMkpETGs3OXNRUFpPaTRUNW80SW9JcERJYXlLcVNI?=
 =?utf-8?B?dzM4U2F6Z1g5UDNVNEdROTE4U0JpY2NrZGhQS2ZDZEFuajZ4ZnFva3d6YXV4?=
 =?utf-8?B?Q2F1a2VUVExhaEp2NGg1akpzN0NWdXN0bTFuT0ErQmRMMlVzY055ekd4bk56?=
 =?utf-8?B?QkoxMXg5a0VENTBtaUJLZmlYY1FUUmIwRWg4anQxdFdtVFFDQW5iNUVUSU5E?=
 =?utf-8?B?bEpxNGVvOUd6YXdpVDNTbDhBMHdSY1VpQXJzZk5JTFUrSjU2QVlncjhUVWQz?=
 =?utf-8?B?MjFhUklkelk1YjNsUFl5c0pLNWw0dUljMzFlc1owVWZXTCt6VURFM1RiUXdr?=
 =?utf-8?B?ajBwcGhJdGh2MTIvckZ0SnYyNWx2czdTWjFZdHBjUUE2QlAwTVRHdlNlR0o3?=
 =?utf-8?B?MlN2ajdvR3h2TGN3NUZxRFNaMnFlWjYwaWhSVnE0TVc3RTJVYXhZNVdpRHM2?=
 =?utf-8?B?SGkxYTF4WnJmZitZdjIzTyt5K3dDajhDSzhZbnVjVEJyWG5nU1FzdEZHTklT?=
 =?utf-8?B?Z0dHT2c3WVlkZnhtdk9VL29qd01oUjNQTnYzdDRkUGRPRWhDYm93Zk9hRDlG?=
 =?utf-8?B?YnJPSWJJVWY0L2Q4RzNtRWpEM2VKY3dERno4UldGZkFONUdQQktPQU54cTIv?=
 =?utf-8?B?RGhTWXpMYm9wdEErcDdSSTgyMHZlc1JyT1lUQytNa3d2VXl4UTgyYm55bFl6?=
 =?utf-8?B?THlscktIN2RsSHFHSTVOMlZGeEQzVS9zdDdzOW9KcEc3UWh5ZTRHbjkxUlRR?=
 =?utf-8?B?Vlp0d2cweHB4cDNDdEh5QjhrbUJ4bHBYTVZZUjVsNDJFcURLeDFoZUtjczNz?=
 =?utf-8?B?aXhiWml6WW4rNDY0RkIrWjNoUFp1bzhka29JOHRHcTcvQzBMU092RW0xd1pt?=
 =?utf-8?B?WGJKdFZTY2d5cTZuWDZVV1E4L1NWRjN2Q3hwbFR4SDl5OS8ycm96WWdZempG?=
 =?utf-8?B?cEVVVVB6TkJCM3pDK3EyTnpZRzFlS2ZJL0I1THRlQmhhTXIwSWg4RTN0YWt6?=
 =?utf-8?B?S2kwM05UUkhGWTBWT2lndFRobko0Z005T051a0prQjhuRkFsS0EwQkNQQzdX?=
 =?utf-8?B?NXV0Nmx6eEpvWXA2bXRrUHdaeUFQUWpQMVJoT2RCWnlUVGlZdTBwSW5vWTNx?=
 =?utf-8?B?ZXlsZ29HRSsza2l6ZnoxNUJXdkdzTUZEdWpOMkN5c01WaU9zcGlpeitySEQ0?=
 =?utf-8?B?bGxyaFNucUtmc3FHT051NWxqK3F1N21kSWtsdzJ2d2E5R0FlU2hjNjMvU3hm?=
 =?utf-8?B?QnAwWFhqVzlOaWVGVkNKK3BFYlFCRFgxZFRMNUZ5NGlEanJYdzV3K3hDQTVH?=
 =?utf-8?B?STBvV0pKLytuOXFWUHRPN1h6UDVHeUZoSDI4QU5GeFpYeU9naVVDUnpuU0NU?=
 =?utf-8?B?L0JWZkYxelpsbWdlQytEMDMxVmo4dG1YaDNZaGtBdExNNGl1RTNOOG1wVUpw?=
 =?utf-8?B?YWhoSTBPWlBwNkQ1dmRQbVppSkpTM0RNS2I5cVpUTW5oVVdkaFpJNWQ1NWFP?=
 =?utf-8?B?U3FwK0t6Q2RKcHV0VGQvTElidVN1ZnVjMjJiQUVGOFhaN2NkMk5reUcwaXQz?=
 =?utf-8?B?TmROOFFrNUljc3I1NTNuaFZlU2xhZ2dCWHRnYlovTVNGaGhwS0VvZDdzc0h4?=
 =?utf-8?B?a1k4ZGVzbnlLMmZ0eWhsUEZUbTV2dHNHRm9NT2FRdlJHZk5xUHpOTDdlSzE4?=
 =?utf-8?B?c2w4U282bUV3YW56czVWbEhOcFJMTmpsbzgzS3JPRVY5cUpSbXNlV0xiKzVR?=
 =?utf-8?B?dTNvK05MNk9uclJOK0dyRjNCckQ2M3g1c3l3KzAyY0FJbVk3cE1VaGp2NEt6?=
 =?utf-8?B?Q21ENFRLNzR6aEF2b2NOT0ZWMVhmNWRMckRKR0I2U3hHekhNek1FRVVZVE1n?=
 =?utf-8?B?bjNPWkVsak5PTC9qTU93TzBwcWxNdjRFekxwUURuYUw2Uk5GdTM2Sy9XVHZq?=
 =?utf-8?B?NVYrVFh4b1dSYTlQSXNlZE8zRWpCanQ2a0Y2N2lpTjJRMGxsL1pDRldzejNV?=
 =?utf-8?B?V2I3T2JOS1NTRmtyS2ZFWGNycE9UZm9KdFFrM0RQZ1UrTlZtc2hZdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 671c1194-6296-4526-49a7-08df0e698bf2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 11:57:39.3292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +caOw8KMauXKiwguWzFWaTz7a25vq0eoNmH6t1p1+3lW0GqfoGAmSMcXuZwmDzW1i/amS921zAEOp5QodoJxnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7664
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Sep 2026 11:57:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24110

On 07.09.26 11:48, Badrikesh Prusty wrote:
> Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
> ---
>  recipes-kernel/linux/linux-cip-rt_6.12.104-cip30.bb             | 1 -
>  recipes-kernel/linux/linux-cip-rt_6.12.108-cip31.bb             | 1 +
>  ...{linux-cip_6.12.104-cip30.bb => linux-cip_6.12.108-cip31.bb} | 2 +-
>  3 files changed, 2 insertions(+), 2 deletions(-)
>  delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.104-cip30.bb
>  create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.108-cip31.bb
>  rename recipes-kernel/linux/{linux-cip_6.12.104-cip30.bb => linux-cip_6.12.108-cip31.bb} (59%)
> 
> diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.104-cip30.bb b/recipes-kernel/linux/linux-cip-rt_6.12.104-cip30.bb
> deleted file mode 120000
> index e767cba..0000000
> --- a/recipes-kernel/linux/linux-cip-rt_6.12.104-cip30.bb
> +++ /dev/null
> @@ -1 +0,0 @@
> -linux-cip_6.12.104-cip30.bb
> \ No newline at end of file
> diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.108-cip31.bb b/recipes-kernel/linux/linux-cip-rt_6.12.108-cip31.bb
> new file mode 120000
> index 0000000..6b45063
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-cip-rt_6.12.108-cip31.bb
> @@ -0,0 +1 @@
> +linux-cip_6.12.108-cip31.bb
> \ No newline at end of file
> diff --git a/recipes-kernel/linux/linux-cip_6.12.104-cip30.bb b/recipes-kernel/linux/linux-cip_6.12.108-cip31.bb
> similarity index 59%
> rename from recipes-kernel/linux/linux-cip_6.12.104-cip30.bb
> rename to recipes-kernel/linux/linux-cip_6.12.108-cip31.bb
> index 8b7671f..7373de3 100644
> --- a/recipes-kernel/linux/linux-cip_6.12.104-cip30.bb
> +++ b/recipes-kernel/linux/linux-cip_6.12.108-cip31.bb
> @@ -7,4 +7,4 @@
>  
>  require linux-cip-release.inc
>  
> -SRC_URI[sha256sum] = "d4fbae6f58c86c1a1da3c23e013eab54caf57aa11efb323b98150298cddcbb18"
> +SRC_URI[sha256sum] = "baf5969362189174c1d0b3480bc33defd3b9ccb73af768b811c117c2e16f8244"

Was hoping for more CIP kernel updates, but as these are not ready yet:
Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

