Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14ADE68960
	for <webhook@archiver.kernel.org>; Thu, 31 Oct 2024 09:22:45 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.44])
 by mx.groups.io with SMTP id smtpd.web10.8429.1730366558523195402
 for <cip-dev@lists.cip-project.org>;
 Thu, 31 Oct 2024 02:22:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=RPcfKlEF;
 spf=pass (domain: siemens.com, ip: 40.107.21.44, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eITTPZT9jIQzbsxqtEiWAwyLXIC9JUQ/YPKh4/flb070gQAvJD+rojVRzDoOQPcN3KqDQ/mhg8+1aDw+5nEfYRgrJt27KNhTLpQzN3U15ofUJgwIf4UDOnPZ2QBZ/HYacAq7eAQOSjn68uzYDUjQrgWcuQYiWSrvWCR0lbpZ2YnVW4rYxJJCGb+f5iSI+tJhRI+oeSjRQ8QHvUZrmyku6XcnJgQTYsUNnftTsHhweHCevEMido+X8DG9xTzdQgjtOEkIhknhQL/FPfcTEjkqlCpJHRhy1k98GzuHPlSJ44mW96Ug9tQIUz/ZenLRGSrMKS3vXy7VWD1ycgAGQLoLSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Gowxv0tduy2YqNBrnYBd8+lI6yBFGdGfoq2BbNOPVY=;
 b=vAKqck2g0wsO6HijqJ8r7xSJfeYP32Dy7v3iTkDFYEsffwMjEHz9YwbMzBcQiAmGBH6HOWOS2uI/gV91dq3LLEKknvDJiVc9sH+dVVt8Ty17uEhwzvtgd+NmFumZgncyjv7fczC0VntY2lLh3UykR+TAbfgNA2XDDpFMrUQ1gqSgcI5fdH73WHAzO+ff8nMdhY6Q5Q1yoJcgdKFolcrGR+kwPmoAfzYtHc7HCKar8kkqvWxLZen6iItpoDcgQ7Oo0mGHCrC1C5zWvhFOWzwNkP86X3RzErZxNu3DEsXc25Kkc3JWPWJvjoLiESCuIrdVy63KyHgaj56dbb9F7YRp7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Gowxv0tduy2YqNBrnYBd8+lI6yBFGdGfoq2BbNOPVY=;
 b=RPcfKlEFIFWyOrcaInrMfy4bnS84ZQ7C7El+rfH1pU89jhSixzHj5zLQUX0KWg3/YSflZqrru9u2/J3k5WCTw1uPXER/PMoYgfXUvjywoLCzkAhgpJJGufgFt7pYuAd29rl8Xe+8MULHj7Fr27aRK3+EQty+Qr3Kpu+9sfsnXqmTmIzCcXpl+HWoPE0xTP9N08gO/0kh9qrsfiiqsWS/qHHf166+hS+S7wBHqKbOUvfuFa2VnEgBRsV+OSb7Od5TuKgZ5G9J0l6TEe9LLmdwSwSHGt8zSSkxwi/IJFM453JjKOXeE+Ml13BswxNBLYZMrClFsk0M6pXjJXuDvEobIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB9016.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.18; Thu, 31 Oct
 2024 09:22:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 09:22:34 +0000
Message-ID: <db161c4a-12dd-4a2a-b891-fd19547d3568@siemens.com>
Date: Thu, 31 Oct 2024 10:22:32 +0100
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
X-ClientProxiedBy: FR3P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB9016:EE_
X-MS-Office365-Filtering-Correlation-Id: c9bff8d3-11c1-4935-4254-08dcf98d8dbc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|10070799003|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?b2VLanRYVERtZEZENjh5UXlXRUFCd05UOUZ4K3lyWnZZZndTUkpMaitnK3Vq?=
 =?utf-8?B?MFFxaHgwNEJXQ081N2pybW9TRWw1QlF0WmdCSTB6VGNpOFFxWGFZTkgxV2ZT?=
 =?utf-8?B?OUZOeEZZVkJwbG5pSkV2N3NKNEkrTW5NOHB3cmZVWUtFbWpoQUpLUU92aUgr?=
 =?utf-8?B?WFZQaHpVZVQ1RTNOUjdIdi9lRFcyWHVrcm9QMmluT3N5YTQwR3ltSXBuaVFH?=
 =?utf-8?B?Zy9WYlBtcm80RVFIYlRzTkdIeGpPbXRlQTM4OHl0SDZSNXNhUHB1b0pzQThn?=
 =?utf-8?B?bXpiWDdqUklUUmRxU3hiUUpodkRNelpCeGhPYVltSVAwUGtDb1NheXNEc1M0?=
 =?utf-8?B?RFliaHdxNGpaRldsUEw4Q3hndm9QOXUzV2NNQzRxVmd1REd6UHJMcUZsWXFo?=
 =?utf-8?B?cGxFMk5GTjRFMEF1TWtWSnR6THI5Q3ZXU1NDeEEvZ1o2NnNyMkk1WC9FckRq?=
 =?utf-8?B?bmNtUlhkMUtBTHRxTFNwOFdyVDkvM2NCQTZhSHEyaVhTNUovTjFQS0V3RFJ3?=
 =?utf-8?B?MkhSamY2azBBRUo4QmxwOEZYa3RRZThETW5TcEovazJMZ0w4bTZybG56TzZO?=
 =?utf-8?B?aFkzMmpyN28xd3g5RUdjb3h3OXJFOUV4TWpQeFVDbXhWVTlWUGxJTTh5a0VH?=
 =?utf-8?B?TUJVT1BNci9FdVByU25iSEprblAwM0U5RDk0cnBHMy90K1FQUjNkWVI2M0E5?=
 =?utf-8?B?OXRpMkprakMxSC9aanBhWmFySlVITXl5NU1iMXlWdm1qZGJvVXRrVTBFRTc4?=
 =?utf-8?B?ejRRVHhraHBXTmxVWUZPZVhNcEZHamJ4WUJlMDF4cU1XUXpIZzlxOFlJN0Qr?=
 =?utf-8?B?UHJqM2p6UkJ4dFZ6eFlmU0xEUk1NRmZYMmYrNzJ1VVVwMm0vZlQzbFJBQk01?=
 =?utf-8?B?T0NWYVNXdEVwbjkvOGNRYlREUjhxd1QxR3pOMnJJSFZWZlllYmxFOVprdmt1?=
 =?utf-8?B?S0dsYzF3SndSWVVIMmpVYmlUdWllU2lyZTBoUmtPME5reGFyNkJFclY3L1g5?=
 =?utf-8?B?WWk5VGpsZzluZElkWnIzQVdOSW5CS3RGN0NEakNjcktvMElNVnlHVCtEbkVz?=
 =?utf-8?B?REpZRHQvY2hrdHFqM1llWDh2QTAyM0IyMUJodHhhaW1PSWdFQlp3NmJPZm9y?=
 =?utf-8?B?UUoxM3FpWm4yZjFOcVhVblQ1NUpyQkRnTHRzVnExUE50N1RJMjNOaU5LSkxJ?=
 =?utf-8?B?MjYzeTVVTE9sdmhaNnd1bTBJTzk5aTZua0RJMTdSTWhRYnVjekZJekd6TEFF?=
 =?utf-8?B?Sno4WFc4eEs1OEI4OUdzTzJRVEJkMEhnU3hTQnM1N2xDY1NYNGJQZjFqZ1NJ?=
 =?utf-8?B?NkRZcmkyWExsYlhEYTVibnVXc2d5L1BVRnRMcUJmS2VWQVJoU0ovM1JnSE9H?=
 =?utf-8?B?cTVOOTlwdTgyTFc2L015QkVUVTMvTkcwWlBmV0ZldVBpSldKY2h3L3NXRmhv?=
 =?utf-8?B?aGlXbWVNK1BsSTFFSzVoSHI4SVVaZklWUE1UWXB2aDBEajZRUHFjUENtd09o?=
 =?utf-8?B?NkRLQkZMaXhiempFcWpST0xwRDdtWDVWYi9xZGdSUzdXaUJ0M0tOWUZSVHdy?=
 =?utf-8?B?Q3k4YmdlOWhnMVZnYkIwa25wNWNoYXA2R0MzQWJ1Qkl1ditnVnJHRXg0b1pF?=
 =?utf-8?B?YVAzeVFDdFYxOWZmNEFtN2NKOU1tT0VCSC9jOWRFZmZIWVB6VzNjWFJTSGl0?=
 =?utf-8?Q?eZMsREEPKJ7D+aqvoF0y?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Ulg4NzE0QWNjc01WOEhCVWkyMGtKck5tUHB2aGRJdStQVU1BSmhvWjlVMDZK?=
 =?utf-8?B?NEVLTE1MNUo2RDMxTzRwZlROQUM1OWcyVFBlNjhiRDlkWDVzUXdDSndscnVS?=
 =?utf-8?B?QmRPRmp0aFJKazFkaUhxSDF4Wk0xRDNsbko4RHZ3bnl0S3N0SnlqTU9ndSsv?=
 =?utf-8?B?V0JTRnN2UUVKbjJ5dzFrOWZ0MTRPSUpqRktFNDVnNUhEYmR6eU5sVUtvNysv?=
 =?utf-8?B?RFdzeExtQUsxeHRBdkF2UFdRcnJaRlRuQVV4dktoandYSkZsM24zcU05QTVw?=
 =?utf-8?B?S2pmYkRIZDBzWjNRM0FLbWpCZVZlaHBpaVJ0U1RFYXNWRURaTG4ydDhHRVlT?=
 =?utf-8?B?Y0xhSjVtaUR4ODBGL0NpSm8xeWVKSkx0NDlkSGdMN2huKzd1VWVta1o2Y2Nm?=
 =?utf-8?B?eTJ3R292bUZqT2hFYnROTEZvVU1mSDZqV3pobENVTG5PQWpTcXczSVdoWDdt?=
 =?utf-8?B?TVRQWkc5MnlOcG1MT21OSjNneXpZclJpTU5JamU2ZHVHTjFMNERsa1U2R2Qr?=
 =?utf-8?B?dzhKVG5VWm9RSHdHam5BZlEwOStURjhQSm53b3lPM1ZSYUlYWnR1UkdZZHBy?=
 =?utf-8?B?Y3NUMTdTdFhjNks0TmRLQXRhQWtPZ1R1aTIxbWs3d1ZnL2FEZC83NjdQVEdx?=
 =?utf-8?B?OUtPVmY3TU50TjhvVGluR08zdXRYNFZFREJzYXdmRnpDRG1rQW0zU2NDNDNM?=
 =?utf-8?B?R2ZQQ0hMcDROYmhFcDIxZ0VRRGZXbG01dU5Tc1gzVW5UZHhVanlPdmpKdy93?=
 =?utf-8?B?U1AvSUc2K3pZWXQxZ3N3b3YyWHpRWkh6cWExU1JTeS9rRTV1Y2xDc1pNT0Vu?=
 =?utf-8?B?NHNGejFWMW10VHg2dzRGK0gxUnVQUkhWUEtYOU83MWluclZWdkpsVUR5a3VZ?=
 =?utf-8?B?a3hncFBxOVloOWFzMnp1cVVGUG1PMW13d1ZBcXNmbjV2Z0NwMElXcHlZUGJv?=
 =?utf-8?B?NldkUW4rUmtZZHN3c1BnenFobUVLcjh4MTBRb2FmMm9kSmhEMTI0VGFlcEdh?=
 =?utf-8?B?VmovWFl0NG91VlVnVU95aitpM1BMczZrd29lSFMydDcwSzFMVS9oTFRlcHVP?=
 =?utf-8?B?ZytseDFaZlpRek5adGlnMEtwbkNJN1laRi96cTFNdXNNUzU3d056bzlTSGVS?=
 =?utf-8?B?OTh0T1JXcEhiUkJ1NVhYWVhqc25ZUE1EN2lnUTRhbVBnM1ZnVVk0NjQ5ZDg0?=
 =?utf-8?B?NVJxckZqLzBJd2R0VEplejNaeW03Um5DS2cwWXI1MnZMeWlyMndZbmg2TFV3?=
 =?utf-8?B?STg0akthTjdML0N5MnNuUTliTk0rWlZOcFl2RHZESEd6YStzbkwybFREOWZs?=
 =?utf-8?B?ekZ2ekxQVXFnMDdaa0pFbnlINE5pdHNqelVRZHBMSHBMSU9qa295SElOL2hN?=
 =?utf-8?B?ajJHMFlGT1V3aE8xUjRzdzZhYXRZZ0QxMk9SQ3JYeVdvYTRRbXpUeVE4MVYz?=
 =?utf-8?B?SFh4U1ZIdHBIcDJ5YWgzaTU3VncyYmFyaE0vSUdnaUoyVE0ycWh2NlRFcFZR?=
 =?utf-8?B?SThGQ293VGZ3SFRvdXFNbi80dzhDVWhlbkdwYWdDOW1Xd0UyRFdXL3VBcXpD?=
 =?utf-8?B?QnlXMm1lZWd1MU9yWW9Fb29JS3NWcWZNcTUxY0trYnFkUkNIYVhDcVNxTCtr?=
 =?utf-8?B?bTdFRlZaMU50RGIzUGNtZ2FUNXRjMTZEem9CMWNOd0Voc2o1VnNySFFHYkFm?=
 =?utf-8?B?U0dGbUZhc3FOeTAzRmxJaDV5YWQ1c2RzTnVtU0UydmhEUHJiY3VTZ2lQeDBS?=
 =?utf-8?B?K0c3ZGhKNnUvdGxLTVhKZUl4NWRzc3cvL09RTDJEcTVDT0dEUURUM3dmR1dz?=
 =?utf-8?B?Q3FzeWQ5Tm1NZ3o4b21NZlRSNDBRK3F0YWw2bk9lYUt5TmVrSi9FaTY5cFJi?=
 =?utf-8?B?SzExZ3pUeUR6cmlyNFFHaDcwM0kxZnI1YWU3SlVscHpFOW1keE56OTB1Y0xU?=
 =?utf-8?B?ZnlEdjVwTkZWUEpaNnk1SEFPVmFNcTE2Z0ZTQktJTHhCL0xaSDl1eUp1aUFk?=
 =?utf-8?B?MUcrazFQdSt5cEVJR3NhcUY4YkNEK0VOYk9WUnlOWTRjNHpzRnVOZ0hTOWov?=
 =?utf-8?B?WkFPSDAwVVRMMU51ckM1L2hXM3B4SjltVFhTaDRIWlFsdTZZbWd2d2svSGhM?=
 =?utf-8?B?clovbjU0bS9oalVDd1kvRXI0UCtxNzhwRkJYazh6UkhaWU5BY2FFYTJFV0VU?=
 =?utf-8?B?YmNyN2c0UitFa0FjZXhla0NoZmU2TTFhdHkvTlZxM1VPNEJQa0g0bEdtdWlR?=
 =?utf-8?B?aHVzVkg2UXJWN0pmS2dKS05meFlRPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9bff8d3-11c1-4935-4254-08dcf98d8dbc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 09:22:34.4683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/LEKugtowOKKtMnLq3c1W8uLNuLAq3EXue39AcNQXnYuoa1TuiDkVnhT5HGGVlAVgIBrPuKcaef6tmzMndiBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB9016
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 31 Oct 2024 09:22:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17127

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&month=10&day=31&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/10/cip.2024-10-24-13.04.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed Oct  9 04:23:37 AM UTC 2024
  limit date: Fri Nov  8 04:23:37 AM UTC 2024
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Mon Sep 30 09:48:28 AM UTC 2024
  limit date: Fri Nov 29 09:48:28 AM UTC 2024
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Tue Sep 24 09:32:37 AM UTC 2024
  limit date: Thu Oct 24 09:32:37 AM UTC 2024
  Status: Late
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Tue Sep 24 10:34:04 AM UTC 2024
  limit date: Sat Nov 23 10:34:04 AM UTC 2024
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Wed Oct  9 10:54:23 PM UTC 2024
  limit date: Fri Nov  8 10:54:23 PM UTC 2024
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Sat Sep  7 01:56:36 PM UTC 2024
  limit date: Wed Nov  6 01:56:36 PM UTC 2024
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Wed Oct 16 09:40:02 PM UTC 2024
  limit date: Thu Oct 31 09:40:02 PM UTC 2024
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Thu Oct 10 09:13:53 AM UTC 2024
  limit date: Sat Nov  9 09:13:53 AM UTC 2024
  Status: On track

