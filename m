Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B08AC35FFA
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 16:44:32 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.47])
 by mx.groups.io with SMTP id smtpd.web10.13064.1742402667447003165
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Mar 2025 09:44:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=li/diUYs;
 spf=pass (domain: siemens.com, ip: 40.107.20.47, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7ZxKDAjNm1rW3EF/8s0rXhnOEyFhuoRm9ALxXqe1edX5bbjHJxZi2KES66xRc3y0OqF+rr3I8RhrukuqbZ/Er7+W0ma9E1TXFs4URhdwTycwulvE16tpgzYMtN1/URGeQkDF5Hpv771mqdS6FsTpUu8g820cjB4kjOVxOXSPwwirtrtrBytMBddCqE6jZzohcknnid6Q/ve1mB/Y58m1JQhXr14Nbqw862LhenE5mhTHPXyKc+CkdA/4O0YjQLTkdFwAjQg9sWEXy9JXGViWLY60KV5jlsAivCZ4fxlToLzE9SYEJMZmjRpc8epVqcZxgSUAjJb0iPFyY2jEAkOwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abLFmuNtKuaiOkFEl7dA0yvDezgOnNluS/q6j0TAou0=;
 b=W9NeCLCTjzbtWXniSU31cBepY9jHM5bryeNxJ6keXwzFl3igWkX0HP3e6gRurGyYWj8TFLYUYSvkR2FM2oXDG39nAiXUMx6gP0DmPAEA9HqjFbziqweurQKnazGtRGDZbnlJfrwcy8OOs/556UNX8nW1kMHHfYTe4qCRSypgGhr8NMvC76I8yoPHNUGPI6y0Hf7+jGdMR5gc/du7ZS3RTDhRfVx9WIeJrsqbKYr7Bz/M+xuM8nBKfEsON4cIBwXYFd5F98ajhpvyzIddY0hurAIOnDILAyX9E/kKXxK3DjAjtHB51TWVMKnpmHmWwwrNSGs/aMlIdLphI7Q7go3Wnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abLFmuNtKuaiOkFEl7dA0yvDezgOnNluS/q6j0TAou0=;
 b=li/diUYsG9y9liafOgvsRr6umoEcJBy8QdY5yQ5XErAiKyr9kpS4/XUszHzSU8lscjn+2XfPyzi79I5mUrG1+eCiA5gDxSnQ1GKl3vmgcRllKl9FvHz7HPZhuwNUBvnjN8zBooGP7aJ3tb51345p8hBJtY386qfhels7RdLQ+TPBtnOzc5JwY7HkYArYyFoadyFarkjBLAjgrpW+O02v70x5fNcw2vyPXDZMGRuzpkobwar4Mm0lR6c00qlmoDgC9OLvH49rZrJYO2vF0MbYyYKPoBPIYLpcArx5zNydfB4FHCvMgCSYSwKCvNUt0CBubkdIXlObA8+8fUA0m2JTCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6628.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:562::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 16:44:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 16:44:24 +0000
Message-ID: <e40c4cc1-b0c4-45bd-8004-368434ceb948@siemens.com>
Date: Wed, 19 Mar 2025 17:44:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v1 1/2] tests/templates: Move smp option from
 templates to test job submit script
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20250319092440.1328092-1-Sai.Sathujoda@toshiba-tsip.com>
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
In-Reply-To: <20250319092440.1328092-1-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: b9fd62a3-09ae-450b-e05b-08dd67054e55
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NHNXRXY2MnpTV2FUbVNDQndjVFVUTFBjejROL05OcldxQWxjYWVaMUFLdmZY?=
 =?utf-8?B?TDYrdXdFR0JjczlXcTY2WUt4WXhpMTErMnBIaktJejVINkUyVkZtRURxcWts?=
 =?utf-8?B?Y1RtbVZFZXpwejA0MjlWSU1RVDdCWWhJUlpCQzdZRlhQUjMwWk1KdVhucTRX?=
 =?utf-8?B?b1JRMTJEYmxIZ0U3RzFMYmlQNjRXZ3pQRTA2Z0FhamxvMHB4K2MwK01sVzFh?=
 =?utf-8?B?Nmx1cFI2QU92Sk5TWkoxbjdXOER6NE0vaDZjckJpNm9ISVlRL3ZLenUxb1A4?=
 =?utf-8?B?Mmt1WXdWamtCczdWTmFzVWcrVlRYVlloNDRxMUtSZm56bmQxeWM5RFJrOVQ5?=
 =?utf-8?B?ZndYMEJoY2xkRWVHQXAyMXVFVVppZWE2SVkwQkNsK2RTTWZqbXlMQXdPU29z?=
 =?utf-8?B?MURZNUQwRkkzenpHc3U1aHNteG90aWZ4YmRVbS9MTzRaMVkyc1ZucFJoelhH?=
 =?utf-8?B?NWRhY2Rtc0grdWFRQUsrV29rb2RoNHltSEdlQXJyODB2Q0c2VXFRbWw3N2ZK?=
 =?utf-8?B?dng4WWFNMWJCRmwxREtKZzVkdGRkNUJld0lVQUJMYXExbm1KY3NQaUY4MDJk?=
 =?utf-8?B?ZDMrRDF3S2FqeDhWVEVGTmVNUVdDaVF0L1k0QWtMcHJqeG03Nk1YWWh3L2Q4?=
 =?utf-8?B?ZHg5ZGF2RGpEcndNdmRUVHMxSUZJY1MwbkIrTHdQaWJSSEVSd3QvalM0bVhW?=
 =?utf-8?B?K1ZBc1dzODdwUURCN3ZJbkkyR3ZWVnhhaVFnWE5WYXN5QlAzWG02U1NvWWVw?=
 =?utf-8?B?WlRObVZadUpuRFRYbjJnZ0pDRjdJdUJZUC9kLzRnT1RURTc2NUpNeXFRcnVV?=
 =?utf-8?B?ZGh1bGpsenJhSlp6MGVOTnQ2aWh2RWF3RVQyMXNrdyt1L05ZWkdJZ2krKzNm?=
 =?utf-8?B?NHlxcG1HTlVjKzkrcE1GMGNLMm5MUTFFV3FkVDR5YlJOcUtrTldOeUxldGY5?=
 =?utf-8?B?WEw3Uk9qVzRmKzhvT1ptZUxRV0hPMEFhZS9UaGk0Wm5BajlueGE5NWszRzhj?=
 =?utf-8?B?b04wWW8wM2RoZkJBMEtXVW50eXZGMjE2Y1ZxY0tSUnJZNFF4QWZnWXNuTjdD?=
 =?utf-8?B?SDZRNW1yMXBjK1VHR21rcjBMcm1sMVBkRDJYQzBTOHFDVk9OUy8wQW9aRDVB?=
 =?utf-8?B?YjhjdGF6ZndvSlVNZ1VDeGR0ZFRQZUNTUk1mN2NXWHp5WWdqQUNGYlhhUHhW?=
 =?utf-8?B?c3UrbmVEUlpMWENpcGtrVFdrWlhZejkwMHN3RE03UFlsZjNtMmF5OUFBTEhK?=
 =?utf-8?B?enZBTUVXdDNWWTdMaEkvZHhoSWwrcEdLbUY3OXhCY2JKdjE0aXp1TWtkOHVx?=
 =?utf-8?B?YWVpSTdqNkJvWUxqNHNDMU1zWmk4QXV6OHJhc0J5SGtTdEZsejNJdnp3RDZC?=
 =?utf-8?B?cGdZYVpaZG5CemtXUHQwR0YxR1FXQU5HeTljc3FSZ0E2WEtCZE5vSStFcFlU?=
 =?utf-8?B?TEZ5TG5Va2FJZVMvSU9UTjlUQ0ppeCtyWmh3b08wNUhtM0JvUFhmcGJvV1N5?=
 =?utf-8?B?blBKcEYvbXdrUjdZN2k5T0x3R1AzREptNGNLUFlzbCs0NUtBR1RFNklVS3Qv?=
 =?utf-8?B?MEZNUlp6b1RIZ0lOb2dza2luM2lJZnVWQms2LzRnRWhnWXRPZmlBMWhGTjFS?=
 =?utf-8?B?enNCMnl0R2VQTmlid3pBRlU1UExDa0psbGs1UG50MzkvZ251VWV6RHVuSy9r?=
 =?utf-8?B?VDZuaFdRSmNRamN1NFM3S2lCYi9oQlRXdzFzdGZ4bGNvWFUrZWVKczBwN3ow?=
 =?utf-8?B?RHI0RDY2ZEVHTjgwV2hkdHJBUmp4enppM3FxaWN0a09IOFJSNWFQMEN3UGtw?=
 =?utf-8?B?ekszWjlYaFlucUFlMSs2aFRkdzljVDVPelZVck5mN1RYdjhRUVE1R0ZqZ1BL?=
 =?utf-8?Q?yIJiUkpKTAAvY?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WUc3MkRkRzZaSU95dlljYUlickFQZmhVcE5xT2VxdXhvS1hVZVJhM1pYQjhG?=
 =?utf-8?B?ZUJSaWtXODVYQ0ZKRVRZcUJVRTZuck44VTE1OU91T2VOaEVwZzBKM1J2ZWxU?=
 =?utf-8?B?U3c5cTZGbjFRREV1VUZvMmtuUWdCK0xLbE4xdkVNU0JpSkFxRmRVWGZVYmJH?=
 =?utf-8?B?cldjS09TT3ptWGhoV0MremMyblF4L3Q3cEhVWFY5RmQwWjFYZXJZRVJIeGZ6?=
 =?utf-8?B?dS9JVERxTjZ4U1FuY2dtSnQ4TjZyVEY0SHdyOWYrTGhvT1lEWGJkM2Y4WVJr?=
 =?utf-8?B?R3IxWlNjbzBWQUo5VzVTNTlPN2N2Q3NDOVhkN05IcC9UNXlBNnNlTlEvdnA5?=
 =?utf-8?B?M3JCUnBvOGxXbkhZZTU0ZE5DdmUzMTZrVWxmOExLY2QvZXFaNTdzVm9HYk01?=
 =?utf-8?B?cWtHaFAwVThLQTNmZWhNNXNYcml1OFRwdjA1VmFZUlpBNEM3S05oUnVyRS9D?=
 =?utf-8?B?c1ltbGFhUmdYK2VDUURvWU5MMlBacnlWMFFnVzEzaVlScDFyQWltMFJmWllq?=
 =?utf-8?B?SnBvakdrUFJ3QTMxaUhLREJNL2wwS09VS2tacWNTMHJHZi9lRVZVMzdUd05O?=
 =?utf-8?B?Ti9TakdWOHVjNWZkVzJPNjlaeTNSWGhwTkN6Y2lXejFldVExQnNRTjVLbGts?=
 =?utf-8?B?dlNqTFhkUkdiRVNMcWlpMWpnZjkzQzl0b3VLVzNJaXVTdW9LVHcydFd6UzNn?=
 =?utf-8?B?dkU2aWl4VzVlR3h0Z3ZNOGJQRWkrOE1ITkpUTW5semxxb0hjclluY01rRTlS?=
 =?utf-8?B?NjR5R1FVanBLMGNiS3RoYTRsYm9KRllkN29Kc3dZbzQ1UTVQWndQYXZBTWYw?=
 =?utf-8?B?YUwra3RvaWhIRVJFeUJvb0YwdmpvbFVrdjMwa2RibEpRc2ZoK3Nic1F0aGVw?=
 =?utf-8?B?cFdwbDRsYkdsQy9MelhOWUFLTEkvb3JIR3UvanZwalZsZTM1bktaMzVDT1o3?=
 =?utf-8?B?SXZEWUdTVFVIWjgxMmZBa1NLbElrdEM5VEtLREp5Mm42NmJJZlhxT3pHVXhD?=
 =?utf-8?B?M1ZVUmVYY0NaeGF6QTJqRkNuT2VQWnlYSEIwMW8vem4xNlpFZTg4M094NEtX?=
 =?utf-8?B?ZjNqeXg0Z3lSYnNRbDB4eVZFWDBlVW1rcExIM3MwL29iTmZwUm8wUmNFVndG?=
 =?utf-8?B?b3VsbmI2YzNWUzVDMFZ1Snc1cFE0a0Q4RS91REF2M25LUVZpcUVVOHBQUlVQ?=
 =?utf-8?B?eXp2UjkwQkVTUDV3ektQQjJCc2MvRUJUWDhCYlcrYklVbnZlbFBnRWVxRjJR?=
 =?utf-8?B?NHRReUNpa3ZONkRrYnV1czEwNjVJU0VpeDdVY2huMnNuUFpUdHN5K1UvNFVK?=
 =?utf-8?B?UFcwYytoelJVZHU1Ty9CUzNNVXNSNlNra3cwemhjVWdQTGlwNGVYWXhycDNY?=
 =?utf-8?B?NVdiT01WUldoSGF2bmJHUUNCSkQ2ZGR6OGVFQVBFcFJzR3lsMnpmeWE3S0NP?=
 =?utf-8?B?WHZVWmJxb0pDQzd4bW5SZkhHUVZIa0dab1ZwaUtjUkJZdThQWVdOdkZtVUc0?=
 =?utf-8?B?WS95Ung4L3YwZFFxc1p3VDVHVU9nTkFocDlRYUpLSmZvN1hyTWczMVgrUlB6?=
 =?utf-8?B?TzFsMllGc0xQK2hLYlJ5QWRyVEN3SVVCalgzckxKcEgvUm1KT3puc1Z6aHIz?=
 =?utf-8?B?c1lOVTZnSDEwSmxaRjZSNGJSQm5QMlJuaHdHNHBNcHpqOEFNNWJqVUxWendw?=
 =?utf-8?B?WVhoU0tYdXFJeU95M3FMajd5M0dHRCtpY2hTQ2FyVjdsWVdxNnJ2aWxBOTdT?=
 =?utf-8?B?RFVVRks1Yk5YZTJWNGFzYUd3NWxRbVlyaEpTV2tIZzdsNWhhUjNoTUI2L2cw?=
 =?utf-8?B?OTZSalR6VVUrUXArdklYVis2MGp0Tkd0MCtuYjhDRVFFbzFSamhSSXpkNldB?=
 =?utf-8?B?OEV0V1p4bFdhTkExdmprVXplZld0RjFPd2lvbGwxRW9HVm1GamVDM2ZDR3BR?=
 =?utf-8?B?bHByMGlDNEtJZU4wcEU3RWFaMjJiL0s2cnBjS082Q0Z3TCtMZlJ1OURVWVRv?=
 =?utf-8?B?bnc4cmdSVUFwWTNveWlDNDBPZExGd1oyZDlwQlVqMU9uOFFzMU9KSTZVNkVU?=
 =?utf-8?B?d2p5bFdjU2ZzeURoMklOVGFRbVV6MWdhR0p0QnZJNmRUcTQxZnBuSlU1Umh4?=
 =?utf-8?B?V3NQTlRjSVBoSTlhK1IrQkZnMnRCd0RvTGdPT1VneW1yZm1rTHl3bWY1cjg4?=
 =?utf-8?B?UkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9fd62a3-09ae-450b-e05b-08dd67054e55
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 16:44:24.5446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kCVgwikCZmjickaBLtBuJbGZUtvXQ+K494gzlEqywf5lVWiUU+PVFwxFtb+Xj9rRrVWLdv9CJf+elzS6rvCZTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6628
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Mar 2025 16:44:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18279

On 19.03.25 10:24, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> 

This likely needs an explanation why simply dropping "-smp" from the
tests leads to "moving" it to the script because the script is not
touched here.

Jan

> Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> ---
>  tests/templates/IEC_template.yml             | 2 +-
>  tests/templates/secureboot_negative_test.yml | 2 +-
>  tests/templates/secureboot_template.yml      | 2 +-
>  tests/templates/swupdate_negative_test.yml   | 2 +-
>  tests/templates/swupdate_template.yml        | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_template.yml
> index a196bb5..3c33773 100644
> --- a/tests/templates/IEC_template.yml
> +++ b/tests/templates/IEC_template.yml
> @@ -34,7 +34,7 @@ actions:
>      to: tmpfs
>      images:
>        system:
> -        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio -smp 4
> +        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio
>                      -nographic -netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 -chardev socket,id=chrtpm,path=/tmp/qemu-swtpm.sock
>                      -tpmdev emulator,id=tpm0,chardev=chrtpm #imageargs#'
>          url: #project_url#/#branch#/#architecture#/cip-core-image-security-cip-core-#distribution#-#architecture#.wic.xz
> diff --git a/tests/templates/secureboot_negative_test.yml b/tests/templates/secureboot_negative_test.yml
> index 568b5b6..2fcdbfa 100644
> --- a/tests/templates/secureboot_negative_test.yml
> +++ b/tests/templates/secureboot_negative_test.yml
> @@ -51,7 +51,7 @@ actions:
>      to: tmpfs
>      images:
>        system:
> -        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio -smp 4
> +        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio
>                      -nographic -netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 -chardev socket,id=chrtpm,path=/tmp/qemu-swtpm.sock
>                      -tpmdev emulator,id=tpm0,chardev=chrtpm #imageargs#'
>          url: downloads://cip-core-image-security-cip-core-#distribution#-#architecture#.wic
> diff --git a/tests/templates/secureboot_template.yml b/tests/templates/secureboot_template.yml
> index 1b8e882..e29b64a 100644
> --- a/tests/templates/secureboot_template.yml
> +++ b/tests/templates/secureboot_template.yml
> @@ -34,7 +34,7 @@ actions:
>      to: tmpfs
>      images:
>        system:
> -        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio -smp 4
> +        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio
>                      -nographic -netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 -chardev socket,id=chrtpm,path=/tmp/qemu-swtpm.sock
>                      -tpmdev emulator,id=tpm0,chardev=chrtpm #imageargs#'
>          url: #project_url#/#branch#/#architecture#/cip-core-image-security-cip-core-#distribution#-#architecture#.wic.xz
> diff --git a/tests/templates/swupdate_negative_test.yml b/tests/templates/swupdate_negative_test.yml
> index 42297a8..bb79b07 100644
> --- a/tests/templates/swupdate_negative_test.yml
> +++ b/tests/templates/swupdate_negative_test.yml
> @@ -42,7 +42,7 @@ actions:
>      to: tmpfs
>      images:
>        system:
> -        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio -smp 4
> +        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio
>                      -nographic -netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 -chardev socket,id=chrtpm,path=/tmp/qemu-swtpm.sock
>                      -tpmdev emulator,id=tpm0,chardev=chrtpm #imageargs#'
>          url: #project_url#/#branch#/#architecture#/cip-core-image-security-cip-core-#distribution#-#architecture#.wic.xz
> diff --git a/tests/templates/swupdate_template.yml b/tests/templates/swupdate_template.yml
> index 67bee03..e1f71a9 100644
> --- a/tests/templates/swupdate_template.yml
> +++ b/tests/templates/swupdate_template.yml
> @@ -34,7 +34,7 @@ actions:
>      to: tmpfs
>      images:
>        system:
> -        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio -smp 4
> +        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio
>                      -nographic -netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 -chardev socket,id=chrtpm,path=/tmp/qemu-swtpm.sock
>                      -tpmdev emulator,id=tpm0,chardev=chrtpm #imageargs#'
>          url: #project_url#/#branch#/#architecture#/cip-core-image-security-cip-core-#distribution#-#architecture#.wic.xz


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

