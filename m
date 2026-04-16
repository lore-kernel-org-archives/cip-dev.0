Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E010F8D74B
	for <webhook@archiver.kernel.org>; Thu, 16 Apr 2026 14:30:27 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.16])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15649.1776349820268722280
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Apr 2026 07:30:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=QYZQMctw;
 spf=pass (domain: siemens.com, ip: 52.101.69.16, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JjrMZJbcofJrsnG8knrQRFVJ85Sc/6DnhYZb1nc/D9TvufPf2hHDqd/Zi+UF5ydatMMFty8r8LMFwQhkbg9MynfzreYi05w7PEHJbdmFJqwUc4uNsoQ/da+vz0qeVA0Kvnv9vrfyMCsu3hsrcgM7e6qQhsxS+P/KLJlYN7OE029QdTGcco50BUHkFL3TC2vMVN+7PiL0B/Y06xALZc/ykc6EQ4SEBf241wuZNX8SYFBvm4bAQKQSRwY4GHQ9mV9MpvljajGVG8C2566k3NlXBPzJ3f7oLKYg+Tbo8SMH7EZbzG1fPHXeaoxyV84TMefSngIaWu+114bFoJWvSp+dgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4sO66J2H0e7qvqR4hN3NNiqvZoA7dN/35fxRkJNuCk=;
 b=pnJ7pn851llbpanWCkrq2j2tU8/alrGaUQXOyL9uS2gTbH+KnL2Guz5BjxxjYsCY0RvcM04i8ha1FsJKL+dAjaJPKA0k+N/5qXC7qds7xM3UWU3t15yB0e8Z0xygxrufBFchRBZLYnRemZNDm6w1dKzWy8pAYOp730F63gsyQlbfhcExEBY/5xm2+C6XdCLCLKkwnLspdlGdpnRG0fh4SFy+G3UR/p6dKj3sG4WiP+6w8TmmKwq5vGVjijhdcM9QjQ27vmFiQzrfQf1c84MzKTTC4dVQZOMvBDJ+DkYh3xFi1Svg8IpGiJTDG3G89kRlvmHemhv8bq3YpAmskbf9kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4sO66J2H0e7qvqR4hN3NNiqvZoA7dN/35fxRkJNuCk=;
 b=QYZQMctwp9xqLMw2t/wqA3z20lbz+sBMUCQ87R70fIBW7y8T3ij5qEMknpbR6+y6Vjr/zwDHysaUtZDtHtEbuztXSU6GFVKSy5wmdb/3Da32IBgDBhbVovjoLEhB4iV5q1LKKtjgRuBTn4iRCOFLQzhvmtEC5nxV417wgj+VeEWETQ/0nNUSHIU+igtwrElg4MDvvxf7bnF+l/FaQhzre+5y1V14f3onsWZ4fmI/rdh6Cyg7GvPPew5MUvMsMheoQKiBUJ6VWPIhleik+otwUqWjNjOdE+T3El+NW9z8+tHseBkrei4xV78ws4U5rl4AP71hBJWwf5a8+iydSki+Kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7689.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 14:30:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 14:30:14 +0000
Message-ID: <9171aea6-f54d-401f-8fcd-92a902b3ec16@siemens.com>
Date: Thu, 16 Apr 2026 16:30:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] encrypt_partition: evict stale systemd SRK
 handle before enrollment
To: "Sari, Sercan" <sari.sercan@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Gylstorff, Quirin" <quirin.gylstorff@siemens.com>
References: <DB9PR10MB6643CE84D750B5014B3606DCF05DA@DB9PR10MB6643.EURPRD10.PROD.OUTLOOK.COM>
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
In-Reply-To: <DB9PR10MB6643CE84D750B5014B3606DCF05DA@DB9PR10MB6643.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7689:EE_
X-MS-Office365-Filtering-Correlation-Id: 3effb05d-8117-4ca7-c750-08de9bc4ac9e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|55112099003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	HIvw9hQFU1FZ6o8Lwj+QRBeED4lO5+RHyJ4vhkmR+dqoc2KIY6rZ5ZFQ5ZE0PJBOx/mmDhKVsADs+DyZwbxh0CSpAxbS+2vOudUtf4+MqVsLVMsi6Gsc9DkL7icfkkkuStj5zORe8ezCY5wLp73HE+X7YVYJx5JSkutRY3GN7hlFdILID5jWkyyRpQXmAyHdGlaLNG5wzCTl1OUaoyGrXkuna9LKjeU8D3RqRUTwvC4jcHdHXftn6QndsID7FMnoaNOH4TDM8r/7ZomXmWhOnXiYGVvwGcvIUt6zadpGerycCTiJJLX0IFWpeakf1sK31NU2Eu5gWR01dkxicRmWB2rEKfCxKrEU22XAaiouLzRrYOgWX4235MNd4/pYYn5zn0yHJkkDFGafUmAgpiWMsa8rRbcMx0InVN72/rmAnznyfHPgYwxJj4DX8exUjSEIgCtYGJYELsfRVQ38yJLX72kVGHqneyPJFfY109wdUNemMJ/lGcAUOAg5dqCmzRdKaIhFikrnRX/ke2JGxiFvBYCliRkEv6OAvZThelhTIcO0OwLQW6ItTfFO85Np7UbX9CPoOhaBM7JpWjgpmzhZEKCBFLkmMrI0JIL8NeXepFrk67RbaUjtIQ5cg0O4+DmWR6wpYENUClmw43TnqLWHKdEfVOnEBZeN6f/JyrZwQ5fNnDKwDwhUH76y2VbGeCeux7A1flJhC3hJ0th3hIQah6ut0cbX9xym2l68hijxWNU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bU93MUJoL0l5alVKc0RkeDFkeENNRVlVajVqQXNNZ3JkTk9STGcrcHZQTmRY?=
 =?utf-8?B?ck4ycURndnlvVmZKeVhUSVJrZ1A1ZnhjcDhrY09xQ1VobHorVTk3cERnUzBm?=
 =?utf-8?B?d3BSeC9vY01kcGZMVW14eEgwTlN3aVQxeHJJTVIxUHBrcUJXMGRXaDJPaVY1?=
 =?utf-8?B?dzB3MEh0cWhvbHFuVTJLRWxCdzdjaVJGa1RVNTNRc0NST0g0OS80NmpoemdR?=
 =?utf-8?B?Nnc1MFQ2SEZ1eEZrMmxmZ0tsOHFOWnNweHNwRWJRakU1RXdnOGNsdDNzNUJS?=
 =?utf-8?B?emQ5WUxpblI5Q3F6QUN1bTNXcldoTUV5a2ZpQVI5UTdQWHNWOXZiRlhnQ3Vh?=
 =?utf-8?B?VXVvSmd2RXIxUFMzQlN5S1oxVWgySjRBQ2VkbzBWbG9meS9ZUlpkTTRPUmhU?=
 =?utf-8?B?ekMrOUNWZERlUTUzeGZDZXBHRVNuakNNMUdlMVBneEFuRVV2Q3lXQXVDRVd5?=
 =?utf-8?B?RWVGUCtLd0J2WEFKR1VyV0xaVk9sOUloMkRqMTJKRUVyZEc3akZIU3RQZTFs?=
 =?utf-8?B?cFRJMnZDWDFRVjYzZ3lhUWV0K0p1M295TWZQTnRYaXdJVzc1L0FyNEFUay9F?=
 =?utf-8?B?NHlMKzNiTzFUN2FYeHM0enhrWGUxdm9LSVM2aE14U0RqVDdHRWJMejNITFBQ?=
 =?utf-8?B?aXVKTzZEbFpJaXlsSWJlWDdrV2pMYU9uUWpRdG1UU3hxSEcxWUdEMWtJNmI3?=
 =?utf-8?B?Zkp0VkRRdkFVNVU1WTRBOXp5dmFQTFZwbS90R1RsZEMyVnFxUnRIUUdhTWk2?=
 =?utf-8?B?R2xiWXBtellSS05EZDNDVEd1SjhzclM5OS9xc012M0h0OWxxL0pqQWZyZmpE?=
 =?utf-8?B?eDl2cmFlRWw0NEVZeFd6dzE0UGV1T3gzOVFMRGVNSklPYzZLQVMwMi81aUxI?=
 =?utf-8?B?azRodGZoZFBNQ1ZadVBnMDh6WW91Z0s4UWlpSUY2T0t4d3JXRG9PanArYmkz?=
 =?utf-8?B?N3dvNUJMakpLRHRZWXE0RVdpcEovd29yR21LYW1HQ3A2RUJiZDhOT21SV05N?=
 =?utf-8?B?cERPN2o5czIxSG5CNXJyV1dFZkRINzVwQmlwVHV4QUlSOVZWZ1V3bzc2SnZ4?=
 =?utf-8?B?WWd3bFErY3VKYm1vVHJKZ2VsTjNtYUtrQitsN2tsT2tXQTJnTU5TMDZmSXNW?=
 =?utf-8?B?Wm9TQjB5RTY5MndFWk9LdkdmaHFOK012VXBYQWV2MXdzL1pESVkxUlNkc1Fq?=
 =?utf-8?B?bXRYa1dIOFVHeTBCTEgvNHVXSHJWSlA0WmZRd2NSV3FDTW5WMUJMalBsYWJW?=
 =?utf-8?B?RFJyRGI2dTVmRFVHVGZFMmlYUlFlRUN0MnpHMU5xRFNieG9oSktnWjJPOEQ5?=
 =?utf-8?B?c1hMak1sQjhmbTR1OGhYOVJ4NmNoRk1Zb2YwQmgvZGFCdVJmZXhyNWNEQkNx?=
 =?utf-8?B?SnJHOVBIbGNqRFhqbFliUm1GMjJCcHN3SnJlVzJ1TWwwZ1hyY3FLZmQ4WnJq?=
 =?utf-8?B?OVNPSVhmOEdRbWNXL1R3aEE2Q2xJRmRPY0pSRWRVeHFKNnViQ1RjOHhMSHRs?=
 =?utf-8?B?YXdzeDFUcCtVTE56MkhKeFQ4QXpCZmx4dHBCeXZMNnlwODR3ZG1MVkpnZWxC?=
 =?utf-8?B?Q2ZLcW01STd1T0RYREVWUDlUR2pHdS9oZk9taWQ5YTRDcTV1MWNaZW5uU01R?=
 =?utf-8?B?T3NKV0JacHdCa2s0TGJxbkhvRzBDelpVK3BqWXFBeEN5b1BXaXhtQXRHK3lE?=
 =?utf-8?B?NVJIR0RLbWRqTzRVM1RPazNJT20vR09wOENLek9ROXQrTVhsc2YwTDFjNmJx?=
 =?utf-8?B?azZGUVpiVUd1VWtuZ1VORExzU2FxRWFGeGwwMnNPZjE3SExkOWVOcE9QR1Nr?=
 =?utf-8?B?M3FRbWJjYS9rSFlGakR2QzlONmhuQ1lJVk5xQXc3cU52SHdkTGUrTWE0UXpP?=
 =?utf-8?B?c1RJdmErb1h4NSt5SGV5cmI2d0IrcEZLREZwakhNbzVtVHF0MnZySU93NGJ2?=
 =?utf-8?B?TnRWMGt1bDVOS2dvck0yNzJyT3RyWlV4ZHZ2NXFjVVNiVmpMMS9HU3UxVk5Z?=
 =?utf-8?B?SE4zYVd5YkNqNzRSMDFORzl3RUZYekFscVA1VlpFYmYrVG5JRE1pTVRJbzBy?=
 =?utf-8?B?czVOV3Iwc2tVTG1PRzgrVUtPRENKdEREZEt1QnRpemVTcGk4OVJodGF4M1dH?=
 =?utf-8?B?cGZQTi9kNnl2Szl3UjRBNU45d2QySTNxQVV5ZFN4Z3NQb2c1Vklvb1VqWnhh?=
 =?utf-8?B?SlJmUDN1VEgrMzhkR2puL2RCVldsM3UySVRaelBPYTIwdmpQNC8zZkhXbC9k?=
 =?utf-8?B?YmtoT0lEKzh0dUN5cHEyQ2RXTHhhRkVFQlNTazV5QnBueWQ3MUxqc1lhRUdi?=
 =?utf-8?B?VTR3RjJoTzRJbHNTUnNhSHRDaVRXQ2I0RGJrSGFkcHU5UTd1RnFHdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3effb05d-8117-4ca7-c750-08de9bc4ac9e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 14:30:14.7612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSxIECcbn7BLtou+w2hWKgc9eQRt9zBJ3RR7RAgy6uJ4YejKCT332jJyCRbGcjK8bhtzM8kgAhQvS1cM1UTWjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7689
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Apr 2026 14:30:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22742

On 06.04.26 15:39, Sari, Sercan wrote:
> systemd-cryptenroll persists its TPM2 SRK at handle 0x81000001

Is that handle number officially documented? Or was it retrieved from
the code?

> evict any stale handle before enrollment to avoid
> "Failed to seal to TPM2: State not recoverable".
> 
> Signed-off-by: Sercan Sari <sari.sercan@siemens.com>
> ---
>  .../files/encrypt_partition.systemd.script                   | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> index 1b7c83b..841219c 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> @@ -26,6 +26,11 @@ enroll_tpm2_token() {
>  	#tpm_key_algorithm="$4"
>  	#pcr_bank_hash_type="$5"
>  
> +	# systemd-cryptenroll persists its TPM2 SRK at handle 0x81000001
> +	# evict any stale handle before enrollment to avoid
> +	# "Failed to seal to TPM2: State not recoverable".
> +	tpm2_evictcontrol -C o -c 0x81000001 2>/dev/null || true

"|| true" is always a bit fragile and bad for debugging. Can't we test
for the handle first and actually fail if eviction is then not successful?

> +
>  	# check systemd version and export password if necessary
>  	if [ -x /usr/bin/systemd-cryptenroll ]; then
>  		systemd_version=$(systemd-cryptenroll --version | \

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

