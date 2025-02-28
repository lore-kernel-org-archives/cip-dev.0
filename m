Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE61C282C1
	for <webhook@archiver.kernel.org>; Fri, 28 Feb 2025 15:44:49 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.58])
 by mx.groups.io with SMTP id smtpd.web10.18972.1740757485962725819
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Feb 2025 07:44:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=nhe5I6tT;
 spf=pass (domain: siemens.com, ip: 40.107.22.58, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJf2AkCJf85d1yRTZZ/ZVSvwFriQav5EZShscxk/4uH1XeKDTJt3iWCkR/nseKGTd8RcQ9Zxm6YknL120CvvSmNtSihea9fya2XO4keqhhg8m6g/cv8P1Z51BNx3ZvfW/6f0adSBAexbAjK3/b+jLSSovzHuLx1gTeGoikexbH32GUyjC0Pg4HI07mfSENdJEGwEPnLZ5h/0zPq21h+pzC5gj/6Bwg41ahD/+yBI0oyVIHvXla1q2hHZSsKxn0c129/1THJIahKDw1HbDtml0iWY51LG4r3Ahu+vHCnbrMCwr8J7rUoCfLnsODjRSN1ysM1ONIMW6fgjSF1Uyl+m8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/d32yFdJatjAZGnEGym8RoCwfXu2NA6FSCkFnGTJw0o=;
 b=d9vP7jI+OhfPoL3aDAeIw+/mQ16By3bMLdbfaceG1xb4GjD3saJp/vFBZEngWwkDcvw4E4F363AHmwomrXXwRUHqY/6BPCA3BsTkTORe+NNeTmvSoEswzSEl4nQv+uzKRyMYIZSG9iAfuNbCaKl6mcPSXB0yly94xfEnTl6LMQmVfIZiF6b3IXDS1oFC8HNTEaxu0yKsR+RoYxP2ATfjyHGAkpKRZAMQRkFZH7k0G/gu25uyvZI7xCOGoPcOR1pjNM1Qia8G69Sj5kkm/piPYsr1lGGXPb7RiMxqIMl9OKo1taPcIl7TJZKqqIGH5iarMcGSwKNwx3ai1BZXNddgbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/d32yFdJatjAZGnEGym8RoCwfXu2NA6FSCkFnGTJw0o=;
 b=nhe5I6tTZYnJA269DvpVljXA8TTgbfIFb0+eIxQRNO4biK2L7bRRL2+6lTCViIKHJ7wY+PVraHF4A4/CmAcwRVp72ONC2QYHAF6IDVvWoLZHceLV5Jdi8pBEbvdKeAHl/zBUAPD0QL/8+JLzcSeUT4DXObhJZ2zlkeTBckGh7Nx+KLi5zp2gUa+EvaU7RMKoNBPHw3UBh9dUbWqL2ipwJNg2QA4Fvl7giUDEhyHsFBCtnihdIjBluRMrba92VoWnBKOGqnlilc3JNXV84xlh9g12pxWsAYLPxfnhRTRXsdky8jPybp39TJHeRPr6XId93yct2a1nA4PnaEU1TAK5XQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8274.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:11d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Fri, 28 Feb
 2025 15:44:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.016; Fri, 28 Feb 2025
 15:44:41 +0000
Message-ID: <9886b452-8f45-4d42-ae83-fc7b5beac3f6@siemens.com>
Date: Fri, 28 Feb 2025 16:44:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 2/2] recipes-core: ltp: Update to 20250130
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 cip-dev@lists.cip-project.org
References: <1740727183-24538-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
 <1740727183-24538-2-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
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
In-Reply-To: <1740727183-24538-2-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0171.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8274:EE_
X-MS-Office365-Filtering-Correlation-Id: c9fea390-c63e-4b1e-b287-08dd580ed0fa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UVJhTHl6WmtZVFlXcFJZQ3p2R3pVWHhFUk5aMlVXaTBxS1NmaUs5MDN3UUpV?=
 =?utf-8?B?Q3FDMGRjUDdlK2k2d1NKMWgvQ1llb1kvMjhKN1Q3RW84cmNtMm9OdWZ2TGdX?=
 =?utf-8?B?WDFhOXdraldzZUdORzlkQnF2MnovMlo0TjZ4YzZnQjRSNlZ4aCtJSEt6WFVX?=
 =?utf-8?B?bFhRMVFsQkJKKzhLN2ZiOU1sWThQYnVxaWEzL1MxK2xVQjFaVEEzY0pIcGcy?=
 =?utf-8?B?Nm5aTGVrdTZvaTNvdFNnbm1Wby80MUhnbjYrZnlOYWZsaFBmZkowSlkrVStn?=
 =?utf-8?B?VkZGbWMwNi9EbGhZV3JGQkg3UmhWSkJoV05PWkJnODFXUEJLdFA5eEV2MTgx?=
 =?utf-8?B?RmxjNGhNVUF2bFZ1eVRxOWNDY28xMWp6elljSVB3OS8reWtCQThOdFFiNTdj?=
 =?utf-8?B?RVg3dzdYdm40RlYwbDdUOFVZdzNIWjdIK29kUy91eTRXTzgrTGFxekR0NkVH?=
 =?utf-8?B?RENwUGU2WDlmM1VVOHdCTjFFV1E5enZxQU9BcjBhMDFRaW1heGRiVUJ1Ty90?=
 =?utf-8?B?b0Q3SUUrNUtueFBXaHBnSHlUQi9xUjBXVU1MU2JWM2xPUUFjQkxtRFNzL29j?=
 =?utf-8?B?TlJuS3hvaWg3VDdpcEZaZVJjdWhyaGkvRHZpMW1HOWVzc1R1SnFPaUk5cHA1?=
 =?utf-8?B?ckdpdWFsT1l2Y3JDVGhiaHdnK3EwaDBaQk9MSytjZlJXTkpXc0YySVhuUjFl?=
 =?utf-8?B?TVQ3ZUo3Yy9IZXo4bVF4TDFjZTE0UGNvVGRaL25FSm05UGhYMWlDYlZ4WDMv?=
 =?utf-8?B?c0pkdXU4dUsrenh0NFpaYldxZkI1WFJLL0dVSVRGdXpid1JUdDc0cjE4V2Vu?=
 =?utf-8?B?QlhEOGZ4UFlPWmhrTVJwaWhLb21vMS8rRy83NnJVdXlLSWxzdENXSkQzdDJy?=
 =?utf-8?B?V0owejZ3S0VkTGhGeVNnRTBYb1RSTTQ2RGZNenc5RDZLR2lRVEcyMUJlbWg5?=
 =?utf-8?B?bk1QT292RDBDV0YxbzlWSWlwTnk0MmhGQUpLeFdoVTdkb09scmx0R3Vtam1T?=
 =?utf-8?B?NU53Z3ZuNGd3YVd3MVlSZFlyc2ZoNlpXRERIeXZlbmdHaWRjNDhXVVNOS3Ez?=
 =?utf-8?B?SmdEOTQ0OXB3ZnNRdVhGTmV0RDJhSXU4Y0w3dWFTWEJwNy9ONm5qUWpteFk2?=
 =?utf-8?B?NU5OYVcvYXp3Zi9zcW9icVFZRlcyR1g1bU1wTHlLSm9jY0Q0dHkrUXhFVWdF?=
 =?utf-8?B?MXV2ZHNyeVM0NndmMXNMTVI4SUVLMC9mbTJZeUVRMVYwUkxaNXdIK0ZwTkRJ?=
 =?utf-8?B?V2w4bWpSR0Y4My81L2s2RDdpYytoMWlBTjdDaEQvaG9zSXUwQWlIQ1R2VVd3?=
 =?utf-8?B?L3NTdEtRQ29NYVFBcjhqR0E5YlZUdHg2UmRMc2ZnVDA1b2V4YU02VGZjMTNr?=
 =?utf-8?B?dXMvVjY0NGwweE80OFROakV3OE9CZHpDTWtGZEtTOGFUYldJeFR5UllSQlF4?=
 =?utf-8?B?ZGZyalNKZHFla0UreFNFQ2hqQ1Z3OTRDcmwzVU0rUDZlNzBnOU5LZ2xQVjFq?=
 =?utf-8?B?YkFDWG03d28zaUdWVWFtQ016MmJ6N0FIOWhhZjVBclNiYmdBQ2FodUJ2YjlM?=
 =?utf-8?B?Ulk0OEJtM0RQTTViMWZOSnNsWldNK0ViYnFZcWNTbnJ6M3Z2OEFzNWVDbk12?=
 =?utf-8?B?Z29vT0VpWjdyODVBN2xueGlOU2QyK2NheDFDU2FsSnBwZnEvdkpHZmJ3TWxr?=
 =?utf-8?B?UU1jSzJKa3NlMURqdno2M0pJeE9rQzh0WGF3SHNiUzE2VXBtanRUMHNmalJG?=
 =?utf-8?B?RE9CMVJvRGpxcUJGUDdjNFFMTG1IU2xBSHk5aHFuYVQxVHFORVZyaWNKckFi?=
 =?utf-8?B?VHc1QVIrNGxaV05SUk9jbGJBWVJKZXhJRWEvc1F0ZzhYN2dqNmxRays0bW5U?=
 =?utf-8?Q?z/rQISFUkABde?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V0RKdGk0V2tGblhEUGFya1k4Sjcvb1RNdU1HRjBLTVFLWU9pZ1p2VklYa1E2?=
 =?utf-8?B?NFZ1ZGEyemNQREFHakQ0Q2FNSmZUblZyNGZ6ZEFwTTZ5a3B5ZGp6SklkTGYx?=
 =?utf-8?B?TVB4QjYrUjRXenI1WUpyNFlybXptV3gxY3I5THp3dU90ZC85eUhFazhSSEtu?=
 =?utf-8?B?T1BBcmw4dm5NTU5MaW9wVDF2TXdjRnlxNDVUalJtbXpNckFVY1o0N3p0cDlP?=
 =?utf-8?B?Sk1qUDVpRjRVUVd1cVRPTXhaeUFRdGJwYVl2a00yUFZrRkdpSm1pelRybGZm?=
 =?utf-8?B?Q1lNU2VXRzBSalRuNkFuLy9sRWF6b2htNHFORC9xSWRidlFEd2kvem5LaSt4?=
 =?utf-8?B?dU9vSU9Oa1BDejZiN0t1T0c3VWlkZStVSHJ6Qjg4Vi9mMjMxNWpKRzNjVCs3?=
 =?utf-8?B?K0ZYS29TM3BDdzh4Z1FrYm9RcTVBeDUyYXpoRHIweTZPaU9KQzBBcHhicjhq?=
 =?utf-8?B?K2pnUStRUzNhVk4vRXJQN1ZuM3hOelpBVjNvQSt4RUtYb0xDY3NoaHQzTXV0?=
 =?utf-8?B?WU8yMWZ5UzNGYzY0bXVIUU9nOTBxRi9vVldSN0tLZWpvN2VpYkx3MFVIWisz?=
 =?utf-8?B?QUtBZEI5RTRaQVRiZnlXS2h2TzdveFhJMkZWWDB1NlZPbHJSSlZXcTMyUENE?=
 =?utf-8?B?aWphbEtpaEpmc0dEYmkwUUdGd21CZDh1OXZLZlBkVUFuYTdzeFdTUVdVVFFa?=
 =?utf-8?B?aXBTRDM0Sk9KQ2dXWTZ0eEJHeW1ZdVl1a2Vmc1BNMlpBV2Zja3RDcEZtbmxH?=
 =?utf-8?B?WXV3WmZUdkNxanhMN1dFYlFmTHRadEdobHFvRVJFenlSdW5UQUNnTExBT2hU?=
 =?utf-8?B?WnBNN1hqR0s1ODh2Ny9RTUJjeUNkR0UrRFJqRWl6aHR1eERodEVzYWQ2enN3?=
 =?utf-8?B?UFJKbi9xMW5ybjB0SEJUUW91S1FCenBtdkVnNWcrU0I2YUtELzZORjdyU2xL?=
 =?utf-8?B?MDQ1UnlMRHFmb3ZEcEptSTlTcEtPMkY5dnIySFM2SG9JNWJpNm4vQ09yQXZJ?=
 =?utf-8?B?OWQ1dE00U1l6bGg1RFhtZjBxZUtuSnM3UjhBMXdxem1uL3Y1U2U4aXFjeXpi?=
 =?utf-8?B?dWNnTjNHeVJuZ20xbkZqdXBQU1FOT3pIRjZSOExzRmtVbmQxa05Sbjd1bFl5?=
 =?utf-8?B?YVFoeEhmS1JlM0FZMmhodmVEdEx6dVRITnRrQWNNWkxMaGJhL2gyeGZuVFJU?=
 =?utf-8?B?RjUvcWhnWGRlK2VQcFdSYXBTV05sZjdPYjA3Z3ZJK0ZjL0pzNVpZOXpRQ2ZC?=
 =?utf-8?B?THhEK2MrWVBYYkZ2YUNOQ2ErZ3FVa0ZEVWNUM3JlaW1RUTI3N2FBdzNUUHgz?=
 =?utf-8?B?VDVNZUllQ3pweTBqNWJpODBwMGh3M0NFOEVBZXhncDM2dktKcjc1by9IeFJZ?=
 =?utf-8?B?bENhaVJEcU05REdpcC9iSEtJWjVBaFdiWWg5aGhqdzA4bmswaFd4YXAwWUkw?=
 =?utf-8?B?VXZYYkpjTm5TNEkzME5QZXNabFFaQVc3SkhwcU0xZnNkY0FwL01zWTY3dkFB?=
 =?utf-8?B?dGpWR1Y5ZC9UU1NaWVlNODdMUGlNOUFTNWVneXlMZURvbnYzVFJwNnplNjh1?=
 =?utf-8?B?UU1MR1U2TnlJNEx2VEFFQ01UMmZjV2VPYVJjd05PbFJwS01WTDdkcW8rd3ht?=
 =?utf-8?B?U1h4UklpOXF3UlBFaFJqWjFieVZ3aUZqZHVmd0VsNDc5M3RubUtjQmtFdXZR?=
 =?utf-8?B?TjhQaXJBbWRUSktEcGNPanpQYlhQTm1HTVpYa3lpZkg0NmhEWjNSdU9qaEp2?=
 =?utf-8?B?cENKR2ROUHViT0c0WVNzTGVtNVJlYm5jSi91Wk84SGFVSTVJOE95WkE4dzRL?=
 =?utf-8?B?TTMwOWlyd1hMV3JDeGRuZWhCRk94Zm9JaW16Q2ZUMFZKUTIzUjJ0RGRJUm9W?=
 =?utf-8?B?RE9qUDNsSEhhZ0dHd2dLcDI5dWpBYThnU0RGSVM2QXg2WlczemdMNzBBS2pT?=
 =?utf-8?B?K1NpVnlHa21Xdkd5MngyTHRUdXJ5cDRaMUZRRWR6NHovZS9Cdi8rd3Z3WEx5?=
 =?utf-8?B?VXphZi9FYjJyanhBSG9McGFLMlplVjltR1JYYS94WlN0STViN0pIdUdqcXU1?=
 =?utf-8?B?UnAzbUlkTklPNzVjbG5qUEROcGhPbkpEYmU2VzhPUkpFTmRmQUlIR1hQZ05z?=
 =?utf-8?B?QlU0WndiR0t6a08ydXVHV1ZpL0FSdEdIaVJFSVVqYjlwZ3UyV0I1OGJteVFQ?=
 =?utf-8?B?eGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9fea390-c63e-4b1e-b287-08dd580ed0fa
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 15:44:41.6177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lwgq5TzXT434LFvR1AYBFM4dR1xFbpf3z2pbSTeIhhFd0BbhfBWmjUXUHzzaJoIaq0QmpH2hv7mb4Pj5+W1dlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8274
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Feb 2025 15:44:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17992

On 28.02.25 08:19, Nobuhiro Iwamatsu wrote:
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  recipes-core/ltp/{ltp-full_20240930.bb => ltp-full_20250130.bb} | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  rename recipes-core/ltp/{ltp-full_20240930.bb => ltp-full_20250130.bb} (69%)
> 
> diff --git a/recipes-core/ltp/ltp-full_20240930.bb b/recipes-core/ltp/ltp-full_20250130.bb
> similarity index 69%
> rename from recipes-core/ltp/ltp-full_20240930.bb
> rename to recipes-core/ltp/ltp-full_20250130.bb
> index 95828ee..40fdccf 100644
> --- a/recipes-core/ltp/ltp-full_20240930.bb
> +++ b/recipes-core/ltp/ltp-full_20250130.bb
> @@ -11,4 +11,4 @@
>  
>  require recipes-core/ltp/ltp.inc
>  
> -SRC_URI[sha256sum] = "3e9e806405aa602e2d21d221d885fd4914ff2da23eb8bba3d0f0f468bdf60238"
> +SRC_URI[sha256sum] = "02e4ec326be54c3fd92968229a468c02c665d168a8a673edc38a891f7395ae10"

Thanks, applied this already.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

