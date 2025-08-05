Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F8DC87FCB
	for <webhook@archiver.kernel.org>; Tue,  5 Aug 2025 09:06:34 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.31])
 by mx.groups.io with SMTP id smtpd.web11.17310.1754384789874935329
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Aug 2025 02:06:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Bp7B0t4M;
 spf=pass (domain: siemens.com, ip: 40.107.162.31, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mnmbhnJOgnFmSW9JdIjGpeONonE9GYRExrzY3FCGu37nITbUpR2aEko3vxUNEAg14HIGkQtT3hGsRM0zt2gazap0S02HYHRE0+DQoC6zM4J24j32Osz2j2ONS3ZHzQHzpnXDrdL7Yuhojy+bBst1/AUShOaNYNo9RTsbYdy30NkZJR2wjvydY5XBxUZ2Wt3+ENkKym0m2OlwydYDFdRZETdOJhBsyAApPPs5LXCIbNZGXrso5/ViUiYKVobscW+kCj3BmZ+lQsePxo9l0oBAY4A1W7jC6A5Qqq8UMr9XO5PmFc7tGOtWpUYD7Q41vBY+lzPQ6pS+s+slBRuOY2ArVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9V/LAxo/7BTNasqqH/l6trMQWCwKTsIAD7nYLK+G7o=;
 b=VuuUJKeEku9pn+tiIFtlbbspjc3+8PRkKlDQOOZLGI7EhMGqxsN3URkbH9d5QFuHhkemcP7/QmjtXLyRmR2gKbmSq+U0Z7qZCcm6XHF2qQ873WJzYUfombiuNcoRpH9jZL3lxbmHrWlVxt/noiRDBw+T4vCFhygred49cUe4U+pfWArSu1pU988szuqZFKnolgvGd+uUhDUHROI2Xc5bo6M4mpiBGlaG4VyAAiyCAo2sPvYhKbijQWfI1Qkn+ApEqf/I8jL3RQ4uDwRNNTBKeFdOBcid36Kx9bEgMWG5q5dkphqrOk3MYl7mCm4NHJey3yliRJTm9SgyL73zN/R/RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9V/LAxo/7BTNasqqH/l6trMQWCwKTsIAD7nYLK+G7o=;
 b=Bp7B0t4M9oDVHp2CPRyF2eTBTyUxvXRtUrLU3XaD40ttmF3MH/2fFoSAzKf0j52R9R3h9R6CNlj0IEACNNvFIpHWHNtai14744V0vII6rwbCGctP8p2KRpDsrTH1haomWeWgYmlqyaEzkQZfwgyaRSL+JITkjdz2Hp0CFuJffinMf9VeqfNpCOfXk8ijP0dY8KBfVUurWsPph/g2Eo+LJ7FUzb/LANjud+5F/9ZvrKlkfvJmQfzD74iKkZQmGOOwBc+YEoJyKT86yk4KOKuZhZUM3m+VU1iyzflHuO6qWxJzq0SaiXsPfTrs8CJVmYUlr1LJqALtBwiDnHr/H40/Yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6827.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 09:06:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 09:06:23 +0000
Message-ID: <049a4714-982f-41fb-b4bb-4e65017148e3@siemens.com>
Date: Tue, 5 Aug 2025 11:06:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] kas/opt: Add option for not install kernel
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 cip-dev@lists.cip-project.org
References: <1753432849-18257-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
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
In-Reply-To: <1753432849-18257-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0044.namprd13.prod.outlook.com
 (2603:10b6:610:b2::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6827:EE_
X-MS-Office365-Filtering-Correlation-Id: afe96419-4f2d-40d8-00c2-08ddd3ff59dd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SkxNL2hjTElhelkvZDkrVTFIZHcxcU5LU2NVMmFaVzAwVnp0OEVmL0h2cEwv?=
 =?utf-8?B?YnQ0NzZMN0NFOU5FMm84eG8xaTlPK3hkUjUwYVNsM0M4NXRrU1FGL1RJb2l1?=
 =?utf-8?B?NVpSWHVzM1pGNnlWeCtwWmlFeXBhbktZZFcwUFh0SmM1bVZicWJOUkpWUmdL?=
 =?utf-8?B?Uithc2JGUnZMZnZxbXE5OUd5SXlIRVBSdEpOdUxUbk5ZenRaL2FvOFg2UWpa?=
 =?utf-8?B?Snk0VWNWVHNVRFJ0RUtvQWFBSTNGaTlzd0pTdEk1YlJvNy9xNUJoUW1tcS9G?=
 =?utf-8?B?ejF3ay9wVWdoNGR1Q0VabS94RVBYUDc1aFVpQXZTR0wwNDhnRjlKVU00MHNz?=
 =?utf-8?B?ZlVFNXkzNmkyWW4rNitId21hV01ESzdMZzZvUHRITkVoVWgrSjFyVUlzc2Vh?=
 =?utf-8?B?My9hcy92OG82eWFOWjdsdEkyNXU1TXp5cW5TckdQS2pzUWxHNFpNY2s3Unpw?=
 =?utf-8?B?NUhhNzl4OUFkNnZZalhXT0FCN2U3L3lHVXdnWjhOT0ZQeFR4ZFRUZnkvSTlo?=
 =?utf-8?B?M1RFQTJ1T01IWmFxaitkc1pvQXptUkM0R2l6bng2RUZwQVBRU2lVT21QUWNh?=
 =?utf-8?B?SkZYNTY3aUdJWHZmMmgrcm1MZDRXTEZPZmsxM2dBV1J5N3Mva21NdHJTcTht?=
 =?utf-8?B?VFByM0hvM1BwWGU2OXpkak5lMUxGTkQ1ZGVsemFMVUV0T0FWZVlGUDBNaTRS?=
 =?utf-8?B?WnEyeFpid0c2blhEN3FpOE5NZGZXK0ZHb0o4SVpHYTBCeTlHL2Job29pTWNK?=
 =?utf-8?B?eDVJM3dWTnJ5R1RYZHlwVUNFWmpHVXNHR2N2NUNuYzFOUWcvVDd0RzFGUGda?=
 =?utf-8?B?SVdZM3dvcHppS0xLZFNZTFoxYzJDUEVEVTBJZ2lmMUFxbmk2blo3RnZQb1JY?=
 =?utf-8?B?eEZKWFFzVXJaQ3I0cW5pVGRsRFZIdlNIMEJlcFZ5a3VWU2l2aGdobmlOcThI?=
 =?utf-8?B?THNVa2lja3RBMlVqVXNSRzlUckFkbCtJVElUK2cyNnVMTWJvajJFQXZtc0h4?=
 =?utf-8?B?akduZ3VOMG4wZU9lL3VrWmZjcmlSRjFkZHVSQ3A4KzJ0alIyUUZUdm1FQ2Q2?=
 =?utf-8?B?a1VyWitKckJsY3VFUzVqd0wzL2RZNmtzVDZab3Q4K1VHbEs5bnJXSlRNT1F6?=
 =?utf-8?B?Vy81c2I4Z3F2dVRwSjFZemVwellsM3FhaTBKRFg2bkxtRVJ2ZEU0dTg1NGpx?=
 =?utf-8?B?ck95VDJXTGNJaHJ3WXNQaktpNUZmb1ZkT3NVNml1QWlxQXBCZVdUSzJwcHVr?=
 =?utf-8?B?TnJoam05TzFtOGZMaW0yZkVxUXFqZTB5WkpGYXZDZFQwMDlqbmxtQ0hoeURD?=
 =?utf-8?B?QklnaktFV3dyVCt2VmNDOXJGSjhuOXprV1NmUUlEUkJ4VzRGcHFoT2dqWDRh?=
 =?utf-8?B?UWM3dDlTc0V3WU5kMXZGUUpaZ0psTW5JOVN5amVIaXJNMm85WGxsUmo0UytV?=
 =?utf-8?B?cENxYTJwc01Nbysyb3pEU0JWR3hGNGkxYTA1elBMSmJtSEVhbG5OWFo4bzdX?=
 =?utf-8?B?S2wyeTRVdHEvKzVjR1BUSnRZSHVPSTBweW11ZnVvd0QwdVFDSHdGazhrMWNp?=
 =?utf-8?B?d3BrMGpxZ1NuQXlyak1CVFlMTmFVMlBCS1dIaUhpQVpRL2p6VEF5U0tkZ1ZG?=
 =?utf-8?B?SEE4K1hxYjllZ1EzMjNCNTBubkxWRXZTbTNVaVRBTE45STE4RjViL3R1MERB?=
 =?utf-8?B?bzRpOTZpM01mSkptcnpjb0xhODNPTmFtWHFRQXE5MmRKVU5TeG91bC9HN1dM?=
 =?utf-8?B?bWZKWjhKOStXK3Iza3dZbWtZK0J2MFYrOUhEVjZkKzB3Ym9iVDMxSmljaHU2?=
 =?utf-8?B?VjJBaTdkRm1HMnl6aWNma1pIT3EzQzAwOHZmRk94czU1VGxBdk9yOGM5MEpH?=
 =?utf-8?B?OTcyQkkvQWdjbDJoRzF0VCtOdUIwWW95Qkp0T2VRUkJjL1E9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RldiU3hFRHZhL3hQWEQ2NDJ1ZEN0cEZydmIyRlFTU1ovYTlTZmx5bm1QTUk5?=
 =?utf-8?B?MXRzdXJLVVNsVDhZc2g3bFFEVjF2c0NNUThRcXdKejUxNFcvRUFkTk1CR21y?=
 =?utf-8?B?Ykpsc0lGZzQzZzBTU0xDUFFodzd6eW9DT0hIbGhhVEtYLy9VRzV2bENUcVhy?=
 =?utf-8?B?dFpXdEpiVThyOG5iM2VSZ0dHOUU1dE81SFRNWFN4RXUrYlk0akE1SGs5NVF5?=
 =?utf-8?B?cVFOUldWWStMNjhDaUEzTXhMSEY4Ump5bjljRVJORElteDRsM3dSK1RiN2xw?=
 =?utf-8?B?bjhPVFI5ZzIzeE9teWtOaC9qWjVvL0o2NTB6TmpYb3JvZmxYcmxETFpIRDVu?=
 =?utf-8?B?ZXUxYVRPRFFoT2MwYk1sd2ROMkVuWEVZRFkrd3JEcC9YRVprdFZPWU1tdytq?=
 =?utf-8?B?YjU0OWlucXQ3M1NuRE5FbUE4ZGFkaEYwVjBlMXE0bTQ0SEFOcS9HejY3d0FG?=
 =?utf-8?B?WUxJUzYyZHYvZk1sclZUNFNFK1NaNnlsRHl1Q0tHQzVMejNDbGxNeG9kc3V4?=
 =?utf-8?B?a0piQkVmeUU0NnpSYWI5VVVlaDJLVWZJMlBvRHh2NHpwb3lvZnVwK1NzaVJa?=
 =?utf-8?B?Q0NJTHhYdXZwd3BReFQwYmVwdWNLZi9VZ1lNeVRCZjFBVHRIRWVqL05Lc0xD?=
 =?utf-8?B?ZTR6aFJOUXpQZjJwZ2hyY0JmdnFoRWRITkc4K2FYWDhWOWF5MFBVVGpHY2Q3?=
 =?utf-8?B?dHlYQ3VQYlhZRGcvMGdIWGNKbjVoSmtxUUJ1eSs2U0pITldjejBFanQ0R2Zp?=
 =?utf-8?B?WllnYjdJVXBmTDZsTTc3N0NUcmdMVkhyQVUxSDNmRSswZE9XK1FpMEtJTm02?=
 =?utf-8?B?aElnOHpvOTNOenFXSm93MWNFV0RmR3orc0lZY053QlNHTjR5OGtpWnBxNVA4?=
 =?utf-8?B?SXNObklxUDk1NzN0ZjZva0dpa0ZZb1VlZUZQd21ITGIyUXN1V0V1SHJNS0pE?=
 =?utf-8?B?UVFhUnpRU2kyQWRHY3BZOFA4YWplcHBFU3Q2aERqM2JvMTRwRFJHdHNDT3Vm?=
 =?utf-8?B?TGZkRzZmWXhtTW1DWUlQMTI1enF0d2Z4cGpkUDhOSjg5TkhzT2xkS3JOTk1F?=
 =?utf-8?B?bnR5RHVRb2JodXZXakttL1JuWksvUXJIY2RKNWJiWDBiayt1ZWV0MkZQZzFV?=
 =?utf-8?B?c2YvWFV1dy8zOFA0bXJsSUVYRmN5U0N1NDgwWHFaV3M3Y1lxTlhIS3YwbjQ3?=
 =?utf-8?B?NVhhZWtzLzFiV0l6NThkZVZ5eW1lV01PaGM2UnYxcnNkTWUzRnZuYmlWTG9M?=
 =?utf-8?B?SjJXc1k2eS9PQzRERzJGRjlYS2VlT0VoMHFUNlZDT3NqdDVpMXhhTEhmZHQ5?=
 =?utf-8?B?VVV1MVhFUjdPbitpRWhnZHhMR09aSjRYbldHNk1RRmVjcjZUdEdqcW1NeU91?=
 =?utf-8?B?V2o4R3JIemZNSUJuSDFCUjExRUlnRi95aXRIcnQ2ZFFpZU01Ky9rVXN2ZXdP?=
 =?utf-8?B?eE5HekVPMFh6QVhXeWE3V0FpNC9yOGozUzRkSEVzU3ZkQXNuMzlsWjN3a0lp?=
 =?utf-8?B?RzY2RXlqRzZobVc1VTlOa3d5YW40ak1yR2cwVU1hdGdtRDBZQTQ4a0duRGxi?=
 =?utf-8?B?QjFBWDVZSHFNcG05Y21MMjdPVHkzYndJVFdQZDFYdGh6dUpHeDJSblF3dVhY?=
 =?utf-8?B?Rm4yZy9Ga1h2aHI0dHBoOVl0Y3M5eDNJUUdCODZUNTBGeEpWUDVsNzJXRWY4?=
 =?utf-8?B?UTZ2K2c2YlZvVDU2dUU1UUZDTWg4T2tYNVBNS2tEUzZIczZrUUgzMktEWlFw?=
 =?utf-8?B?UGRWZ0NVNU9tMmtqSUZHNFlvRGtrZCtrdUZtNkJRcGZld2M3YTVBTVVqc0tV?=
 =?utf-8?B?THVvVWdPaHRaVXlCRCtRU3p0ZXJmdE05bTdkZnhNOS9yYnhYOFUrVVZsZ1Va?=
 =?utf-8?B?L0ZPdkFySFV1UEVPK0NyVklDOTVjK0VHdHNaKy9BZWpGWDdtYjBGUWhhVk4v?=
 =?utf-8?B?RVgxcXAvY015cXA2bG1VMEtna1BmY3MyemczaFhwQy94L2lVRmR1eVhuRk9G?=
 =?utf-8?B?cDJVTVltN2gxMEduT241VCsxV2tRZmtMUmdVdXNYWEw3Z0d3YXVCSW1DR0VE?=
 =?utf-8?B?a0IwRGhaaDROc1BUQ3paMHVURGJTa05jSHpLVW5QTUNQVTI0cHdkT2lMV2V6?=
 =?utf-8?B?VVF4R0pwY0t6dlZVZTU4NmJPeGhHSWRZVXlqQWltay9rWWRhSVprV2ZwWWNj?=
 =?utf-8?B?OGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afe96419-4f2d-40d8-00c2-08ddd3ff59dd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 09:06:23.7240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yAcMqH1/fiHevnx4jW2BCB/vKQCRTAdCvAeoLfd3tas98v6xP8qi/wn39z6snw58ganGZE05rh5XxE1Eof6t2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6827
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Aug 2025 09:06:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19666

On 25.07.25 10:40, Nobuhiro Iwamatsu wrote:
> This adds an option to create an image that does not contain the kernel.
> This is mainly intended to provide images for kernel testing.
> When testing the kernel, kernel image files that are not used for testing
> are not necessary in rootfs. Providing images with these files removed
> allows you to reduce the size of the rootfs image.
> 
> wo_kernel is false:
>   -rw-r--r-- 1 iwamatsu iwamatsu 351M Jul 25 17:31 cip-core-image-cip-core-bookworm-qemu-amd64.ext4
> 
> no_kernel is true:
>   -rw-r--r-- 1 iwamatsu iwamatsu 275M Jul 25 17:09 cip-core-image-cip-core-bookworm-qemu-amd64.ext4
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> 
> ---
> 
> v3:
>   - Update commit message.
> v2:
>   - Use KERNEL_NAME instead of IMAGE_INSTALL:remove
>   - Add build:qemu-riscv64-test-nokerne; pipeline
> 
>  .gitlab-ci.yml             | 36 ++++++++++++++++++++++++++++-
>  kas/opt/no_kernel.yml      | 17 ++++++++++++++
>  scripts/deploy-cip-core.sh | 47 +++++++++++++++++++++++++++-----------
>  3 files changed, 86 insertions(+), 14 deletions(-)
>  create mode 100644 kas/opt/no_kernel.yml
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 7c05ad4..53c9a2e 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -28,6 +28,7 @@ variables:
>    swupdate_version: default
>    test_function: swupdate
>    separate_home_partition: disable
> +  no_kernel: disable

Here, we set the default to "disable"...

>  
>  stages:
>    - build
> @@ -69,9 +70,10 @@ default:
>      - if [ "${watchdog}" = "disable" ]; then base_yaml="${base_yaml}:kas/opt/disable-watchdog.yml"; fi
>      - if [ "${security_test}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/security_test.yml"; fi
>      - if [ "${swupdate_version}" = "2022.12" ]; then base_yaml="${base_yaml}:kas/opt/swupdate-2022.12.yaml"; fi
> +    - if [ "${no_kernel}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/no_kernel.yml"; fi
>      - echo "Building ${base_yaml}"
>      - kas build ${base_yaml}
> -    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG} wic; fi
> +    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_COMMIT_REF_SLUG} wic; fi

...here we pass "disable" (or "enable")...

>      - if [ "${build_swu_v2}" = "enable" ]; then
>            mkdir build/previous-image;
>            if [ "${extension}" = "security" ] || [ "${extension}" = "ebg-secure-boot-snakeoil" ]; then
> @@ -229,6 +231,38 @@ build:qemu-arm-test:
>      target:  qemu-arm
>      extension: test
>  
> +build:qemu-amd64-test-nokernel:
> +  extends:
> +    - .build_base
> +  variables:
> +    target:  qemu-amd64
> +    extension: test
> +    no_kernel: enable
> +
> +build:qemu-arm64-test-nokernel:
> +  extends:
> +    - .build_base
> +  variables:
> +    target:  qemu-arm64
> +    extension: test
> +    no_kernel: enable
> +
> +build:qemu-arm-test-nokernel:
> +  extends:
> +    - .build_base
> +  variables:
> +    target:  qemu-arm
> +    extension: test
> +    no_kernel: enable
> +
> +build:qemu-riscv64-test-nokernel:
> +  extends:
> +    - .build_base
> +  variables:
> +    target:  qemu-riscv64
> +    extension: test
> +    no_kernel: enable
> +
>  build:x86-uefi-secure-boot:
>    extends:
>      - .build_base
> diff --git a/kas/opt/no_kernel.yml b/kas/opt/no_kernel.yml
> new file mode 100644
> index 0000000..7bba6a5
> --- /dev/null
> +++ b/kas/opt/no_kernel.yml
> @@ -0,0 +1,17 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Toshiba Corporation 2025
> +#
> +# Authors:
> +#  Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 14
> +
> +local_conf_header:
> +  kernel-version: |
> +    KERNEL_NAME = ""
> diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
> index 6e4dfd7..6cb4968 100755
> --- a/scripts/deploy-cip-core.sh
> +++ b/scripts/deploy-cip-core.sh
> @@ -13,9 +13,10 @@ fi
>  RELEASE=$1
>  TARGET=$2
>  EXTENSION=$3
> -DTB=$4
> -REF=$5
> -DEPLOY=$6
> +NO_KERNEL=$4
> +DTB=$5
> +REF=$6
> +DEPLOY=$7
>  
>  BASE_FILENAME=cip-core-image-cip-core-$RELEASE-$TARGET
>  if [ "${EXTENSION}" != "none" ]; then
> @@ -29,6 +30,23 @@ fi
>  BASE_PATH=build/tmp/deploy/images/$TARGET/$BASE_FILENAME
>  S3_TARGET=s3://download2.cip-project.org/cip-core/$REF/$TARGET/
>  
> +if [ "${NO_KERNEL}" = "enable" ]; then
> +	__BASE_PATH=${BASE_PATH}
> +	BASE_PATH="${BASE_PATH}-nokernel"
> +
> +	echo "Rename from ${BASE_FILENAME}.* to ${BASE_FILENAME}-nokernel.*"
> +
> +	if [ -f "${__BASE_PATH}.tar.gz" ]; then
> +		mv "${__BASE_PATH}.tar.gz" "${BASE_PATH}.tar.gz"
> +	fi
> +	if [ -f "${__BASE_PATH}.swu" ]; then
> +		mv "${__BASE_PATH}.swu" "${BASE_PATH}.swu"
> +	fi
> +	if [ -f "${__BASE_PATH}.wic" ]; then
> +		mv "${__BASE_PATH}.wic" "${BASE_PATH}.wic"
> +	fi
> +fi
> +
>  if [ -f "${BASE_PATH}.wic" ]; then
>  	echo "Uploading artifacts..."
>  	if [ "$DEPLOY" = "swu" ]; then
> @@ -48,17 +66,20 @@ else
>  		aws s3 cp --no-progress --acl public-read "${BASE_PATH}.tar.gz" "${S3_TARGET}"
>  	fi
>  
> -	KERNEL_IMAGE="$BASE_PATH-vmlinu[xz]"
> -	# iwg20m workaround
> -	if [ -f "build/tmp/deploy/images/$TARGET/zImage" ]; then
> -		KERNEL_IMAGE=build/tmp/deploy/images/$TARGET/zImage
> -	fi
> -	# shellcheck disable=SC2086
> -	aws s3 cp --no-progress --acl public-read $KERNEL_IMAGE "${S3_TARGET}"
> -	aws s3 cp --no-progress --acl public-read "${BASE_PATH}-initrd.img" "${S3_TARGET}"
> +	if [ "$NO_KERNEL" = "false" ]; then

...but here we test for "false". Please only check for "enabled" and
consider anything different as "disable".

Jan

> +		KERNEL_IMAGE="$BASE_PATH-vmlinu[xz]"
> +		# iwg20m workaround
> +		if [ -f "build/tmp/deploy/images/$TARGET/zImage" ]; then
> +			KERNEL_IMAGE=build/tmp/deploy/images/$TARGET/zImage
> +		fi
>  
> -	if [ "$DTB" != "none" ]; then
> -		aws s3 cp --no-progress --acl public-read build/tmp/deploy/images/*/"$DTB" "${S3_TARGET}"
> +		# shellcheck disable=SC2086
> +		aws s3 cp --no-progress --acl public-read $KERNEL_IMAGE "${S3_TARGET}"
> +		aws s3 cp --no-progress --acl public-read "${BASE_PATH}-initrd.img" "${S3_TARGET}"
> +
> +		if [ "$DTB" != "none" ]; then
> +			aws s3 cp --no-progress --acl public-read build/tmp/deploy/images/*/"$DTB" "${S3_TARGET}"
> +		fi
>  	fi
>  fi
>  


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

