Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2785FD167FB
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 10:30:17 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7386.1767954607645109577
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Jan 2026 02:30:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=aSRR9qZC;
 spf=pass (domain: siemens.com, ip: 52.101.70.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mTZRoRDdidzpLb3sqa8VXXMEPq58U+o+ix8p7B6QuJsthHJGsnw1+zvKw/JL51xDhe/lWjkd2VozXwNO6UlDvoSlJjesc5Amuj+5BNoT0zgZljw6BvOrbefbibXufY+HnYl0EdlYGZxlQW5uP0DbSehKMjjp3cJJNtSL7vGrmeqG2KE2/CKStAYyi3kEYYvaaUbzL4qwjsGqIAIxh8i57Hu22KYjSVLoVZLfOBQNKIFV+BgvPpggVViPCK8ioI6Oerfl/hTM76ZQRwf+HWrNm8y+GjegGfpQhxox8eRl3BDcS/wY2gVOXZufhS4K3Kpm/3zc5uNiHLn8n6KXqqNJxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aue5yXOdqkcF4pZ3IytaaBKXnC8J2kysKzwH20W/ilc=;
 b=CHDjgB6l8aspDzgjuzwcJWXfWYXR55PkXTSxC9fkG+c3LiD63ELlfuA8AeBsRh5k73f/UKvSPOSLE3QdSHmeCbl85dn4FQk33OE5brrLYjxus2Rb2eGAiX+M8ZuKtLcqHmBKfnd7YI67twSmw3BmnV8vDedMuNhIUxkCrpmYrwjMrFmKYl0FtzoOUvTOKYu9GLGzPVRKRka8O9WVM5jb2sapP5kPp+CONWbcwrVetOw0nkMceKDlWskeJM6Iyp0wLRR23fURTtfa3mTzY6WWiQvqDa6gdAmGsE95BwyCDFne0Z43601iLqa4gDo84mESLTZZm+Q9ue9D3XoMqgm15Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aue5yXOdqkcF4pZ3IytaaBKXnC8J2kysKzwH20W/ilc=;
 b=aSRR9qZC/prso1xwJkm4nDpBFUJjgw9yxaS0tzk6YqJCSgOjgL1rOBeixmrO+cII3SI/oacPuELGqM16uOPWwLZitU1oS5tuzoPSMdGT01Edx4zN4/W0PourOJzZmky5jqaJSnqMiMB+h+++LV2jmpwo2DXc1fNCW0wz8WPdDdWsAVPXcL7qpAAGrCIpIn5H9dhnyKQ6D95nCErTq9qve0j0VVS9AoymPDzihn7l/+jqAEcGWFtovo5aj1z0f3mu/hpHluY2WNYRGp8ZMMpM+Cm5dFs82iKw3TwPexIApKC4ZXp6CecbSg/nMa3puKt+drCmcRCa4RBcGagyyxh2Eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VE1PR10MB3920.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:16b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 10:30:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 10:30:03 +0000
Message-ID: <c6775c5a-eeff-4226-99f2-09db9a507d61@siemens.com>
Date: Fri, 9 Jan 2026 11:30:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 6/7] Add documentation how to
 integrate isar-cip-core
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 clara.kowalsky@siemens.com, benedikt.niedermayr@siemens.com,
 cip-dev@lists.cip-project.org
References: <20260108151650.124306-1-Quirin.Gylstorff@siemens.com>
 <20260108151650.124306-7-Quirin.Gylstorff@siemens.com>
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
In-Reply-To: <20260108151650.124306-7-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0388.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VE1PR10MB3920:EE_
X-MS-Office365-Filtering-Correlation-Id: 4717ad56-d679-4a35-15fd-08de4f6a0cd5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RUlBNlZsTHB1YXMxNVZQYVlUNjFJQzZzdzhRQnUxcUdJUUNXbUdEcXVvLzln?=
 =?utf-8?B?dmZ4OFQ5Q1g4cVVvYXhzQ2hPOHVvZ0tuSHhYZjZtS3RBSUtLK1BVZTlvM0tT?=
 =?utf-8?B?LzFDekFVeWdMRm03dUtWMko5aXpMTklEMG9OVlN0dkpBbWhyMGZZa0REVC9m?=
 =?utf-8?B?ajNIb1pjUHVLK3ZReXNGZ2J6UmxIdGVRYkZvcloxSTBKbExZekZrUk5va3dy?=
 =?utf-8?B?QksvRjlINHVvQkxsenVBaGdYcUVOMlh4MG1nTWdGTkVONmthMklkTTJ6NWI4?=
 =?utf-8?B?eklVTXNNbkdnRGhEb1lEUGwwZEI0NmNtYS9XTThFZW5QT1hCR2c5NlloWXNC?=
 =?utf-8?B?TTJqVHUzNEFTVi9TYzc3VUtWVEFIcFdSbzFlbWE1OERDY3lYT1R6NzVJamV0?=
 =?utf-8?B?MHA1NkdvSVlPdTI5L1VDRDcrbEtzbjd1Nk5wMEs2SU1HRG0yZHNzcnMxUEh5?=
 =?utf-8?B?UVgxSmlieHZma3ZyeHlMbDhRUzFSSUlpQXhRKzRtWW9hdGU5Mi9RcXVWT09Y?=
 =?utf-8?B?cXpWS0s0Q08rZ2ZORE83U2FiUWE1aktsanVyY0NrS2Z5SmQrWjEyV0hZTTA0?=
 =?utf-8?B?WlJZbUU0NTUrOXpmL2tVYlFVeTJ4dWE5T3VZaE1acnYzY09IVGhoWkZVTW5t?=
 =?utf-8?B?K201cDBQNHRabndPTWYzbmNNYmxrSkZ5MGc3dkhINVhZR1VjWkF1UjR0c3Fh?=
 =?utf-8?B?azMxOGIzeFRXVkdKOFdJQnhIQUxpN2pQTi9BS0dsR045ODF4RzRsQ1hFUFZy?=
 =?utf-8?B?U3JGWHhvN1ZISlQwV0ZPWlBaNVViK3hSOGhEUHpjcXFtMmtpeFgzekZncU1H?=
 =?utf-8?B?Qkw2bWk3UXhHTWtKVEZpenQ4ZHFTeG5xY241anRvUjVLQ1IvTGVsK2ZibzVF?=
 =?utf-8?B?ZDdUc3pUaXBQLzVVQnRIR0krWmZpWnZOeGJpVW13R3YrMTVmUTBvM0k2VjR3?=
 =?utf-8?B?VENObFZUcUJXbGd4TDBETUlQaHdaT0FxRWtuL0RDY2UwTWdabXdQTnF5dDRm?=
 =?utf-8?B?RkFOaXFGZzFXZllDV2NKZ2twYVhPYlV4eHIxT3M4S3BMa2dUR1ltSEVuMDRv?=
 =?utf-8?B?SkFVNGtuWVRaZWUxVmxHZFRRU3JIVHJ1ZkFUT1ZvUGRUeW9XMXdGWlpwRXlW?=
 =?utf-8?B?UE8xdTlac3AxcmtaVzIzWkJWK2p3eDJGNUxzK0ZYQ05naFdxRDgyazF2aENt?=
 =?utf-8?B?Y25aNFhYaDVpeGk2UkZjdXZmMWNFdXZyaHNiQUxKV2VCazduUmJHUEtLbEgv?=
 =?utf-8?B?cDJ4RHBKVEJsYi9abkV3UUFKYU01YUk1RTYrOWdKY3hIaEZUMW9EeWhsVE9H?=
 =?utf-8?B?MWhJRDdaTEVzZzJ4VTF3NzI5TGR5YVdCbnBmbGtwNGVIVnlKSkUya21hejFv?=
 =?utf-8?B?RkluN2lSN2hNbmltbVliVXhzRDRnVk51NTNFeGVoV2dTS2t5TGRVeXEzS0hO?=
 =?utf-8?B?U1NmK25lWDZ6QmpqT2ZTUDIwVVdLcTNYanFsMm9vYnpSbExVRHU5MkpDUE1x?=
 =?utf-8?B?U28yRk96OCtMSFViKzdhQjQydzhzTEphbHZ5U2ZpSXlhRUUwdVMyRDdEZlA1?=
 =?utf-8?B?cmdDdjBYMUVJMHU3S0kyRTZBZjdsanlBbGgvMU1MdE9xY0lnTy9nL01HcVhP?=
 =?utf-8?B?Z0tDVUJSOTFsMlcyLzloWXhaV0EyUHo4bkppaUwxZFpWTXEzVTVBTmxLM0gx?=
 =?utf-8?B?dEVLd3dOUVhPN1dQdVcwZ0tGSjcrbWxpTjNCczYvemlGL05WaDZ5R08yanYw?=
 =?utf-8?B?MEJVek5uNGd6RGNnTTB4bUlWS1ZxbGRZUFBTRlFvRFg3Mm5hd0pIWC9TTlRZ?=
 =?utf-8?B?NkYrWGhnbmhxdGVHbTdWd3pGbFhxTkVnc0NxbVFNMGROWlY1cE1rU0xtaGg2?=
 =?utf-8?B?Rmh6d0VRckVJS0sreU51NFYrNitiTkgvWEVpdWVPazZIUElldzJEMWlRNUkz?=
 =?utf-8?B?V1BlVnZucDRMNHZNbE80bHFYZFhWVWlCQ3d0ckZKb0VYeCtKMDdKMjdXM3FO?=
 =?utf-8?B?WWorMHR3YlVRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MGJySGNCRjZNbkxLMGhwK3o3WGtWMGFPTHRFODVsQmRKaWVtUEx0WmdLc1BF?=
 =?utf-8?B?ZDk1eDd4NnM4eE1FRGNwdTQvQ2E3WGpDNmV4dXdFUWlMREpHb2FQVit4Nmd6?=
 =?utf-8?B?VDh2S0ZwcGVaUWVUTHlocVJmeDBIS2IwRDNjbEpiTFpRMnhXMTdXWjloYkF3?=
 =?utf-8?B?Ui9uMlUxMEZ0L1VzdmZzNGNhZThqRCs1SDcxeVl4OGpEaHBwOFMvcU01OGNh?=
 =?utf-8?B?NkVEV3dIMWtCdWhaNVpOQ3V2YjVUTnFENEJnaWR2M0NWdUMrQWwzMzB6TStG?=
 =?utf-8?B?SHZMckwyM1JFSm9zSis0U2ErdEM1Y0pMNUdkc2RMRkxTK01SamtyNjdRWUVt?=
 =?utf-8?B?eVJqalFzN2Q4TWJYdFVFS1JEeWVvOUlNZm1qYWhRNHpUNmIxb1Z6aWF1SE5V?=
 =?utf-8?B?cG51WmFOWGdrVDZWSExOeUY0S0hFazVTdklBYzUvTmZ4ZWZKUHJaalFibG1L?=
 =?utf-8?B?bjBIRVE2bi9memNoTVp2OG1xWTN0MzdwcFMxTm51eE1LVXhjKzVSbStVUUND?=
 =?utf-8?B?K3ExQkY4WllGZWxMUzdsOEpXeStVckZxV0dIbjUwL1hab3haY0dGQ3o0d2Mv?=
 =?utf-8?B?TS9RNHhxaWJUckdLWWM5WkF6WWE5V2s3ek8zNGsvbmV3Y2JUakVpOVJlSCtp?=
 =?utf-8?B?Sm5MeWI0V0RKTERDUk95dFZYaCs4N3dPdWVubGhDSnVoRVVSakRvYlhHTHB1?=
 =?utf-8?B?YUlLVjNMNU0yMTJhcGEyY2JUWXRhbDdoZnQyeXJUeWJEVHcrVVpqeUlnNlJG?=
 =?utf-8?B?YTI0K29TNHN5YVMvMElLQzZ2Y1NlTkJHRnFVcHd4dVZMZVM3N3owZTFBSzRS?=
 =?utf-8?B?djJPd1RyTHhhQyt3NmZIQ1o2cFV0OSt0YmsvS3I0UlZJWFRhOVNISjYwREJN?=
 =?utf-8?B?dkU0UWxyL2pUSzBZVDdsN3cwZFRwUWdTWXVvMmZEUUZZeklyV0Z5Ujd3S2Ex?=
 =?utf-8?B?TnVzVEhzampPKytGNXNhVkI4VWtmc1BnejRNTThITVVNVTcwa1Z1UmoxK3lu?=
 =?utf-8?B?L0FLUktiL053VXJLb0NRZEV0OHBPMWlHelFFazJ4QnVWcjNTVTRtaHg2V3Bl?=
 =?utf-8?B?cFlDVzZLcFNKbjZqVTB3Zjd1R0tISmp3QW9FYVZhRGF5bU96MmFyUHUydWlv?=
 =?utf-8?B?WTZuWUxPYjRsdnJHQVIvMzZiekQ2Q0lVYkhnRGRUL3oxRnZRS3FIOWlwUmNh?=
 =?utf-8?B?Q05sSEVoalJNSnhwak1BSWc1N0kxRFJ0TEVXNCtFTmNpNm1VOEFGbk5FRlJr?=
 =?utf-8?B?dnpZNmIyMjhDUjlIWDdSZTBBR3RhZk1lZjRNY3k5d1FjNWQybjcyajFQVm1u?=
 =?utf-8?B?QnZINlhJQWNZNnRLa2p1ajNGZHgvRGJTWmc2S2JsY1Y2OXZBT3RubDdTRm9Y?=
 =?utf-8?B?MTdac0ZiSkNYRXY1WXVFcGp5ZjhDdU04bWg0bXRuNkNrR0dDL1hqU2s5dW9i?=
 =?utf-8?B?d1NVUERidG9ZTzFySVRseTcrYmtucTBFSXJnSjFRTS9GcmRGajJuSDhNcnBj?=
 =?utf-8?B?dW1CVUc5bUNCREZWWlRCUXNiaVFuWjhCZlZWblZDRGhTWmsvMjlERGNLc29q?=
 =?utf-8?B?bVlENklSbkhnMG9BY0JVQmNtM0pjcjNxbzVxNGhXaitiM095Y1J6QWFad0hz?=
 =?utf-8?B?NythZWpEdmVzWVRLQ2JndktrY2trVjhXQ1J1RFBheTBvdWJRQ01tV0RxQXNG?=
 =?utf-8?B?Q2g5cHJmelkrbWxYaHlKamxjYzllcXB2MWVSdGgwRDBVcEdxbmE3dnpuSHRj?=
 =?utf-8?B?ejA4bGJnSDVkeDlpOUR6SFlHREVFbTJqQWJxUWV5dzMwSXY4bmszMXVOd0hu?=
 =?utf-8?B?bXFFNEFUVjg5TW9VNU0xVWtIejVnODI5RVZ2QnR2SHg4S0FTUjM2RGVZd2JW?=
 =?utf-8?B?U0FJVlc5ano2RC94S1NUcGFEaXEzYmVLWG1JMjNrNjR2OHR1cGlQMkdlSWZo?=
 =?utf-8?B?MnpEbGVIUUlqaU1PWHMvNk0rZXRSdU4wQmZwYXcrTm54TEhENGx5cTJqWUcy?=
 =?utf-8?B?TFptOHlTU2V6UFc0U0Y1Y3BIa21tUlhNeUt1alVFRk5kcUpNbzU5TlJQMDBa?=
 =?utf-8?B?b2FhU1E5UWNVaDNMVjQ2eDdsYlNodDFrbUhNeW9oRHdMci8xeFFvb3d4Wmoz?=
 =?utf-8?B?REFkaWxISzhlZEo2ZjN2WWFsWktlQ0tkY2diaEl2RFU3OGkrZVV6MXJLMjVp?=
 =?utf-8?B?dGgwTmpBSGRuYVhVVXZId01tWnJ5WFI1Nkc0c2FiU050Rm02RU5ra3RKdDNs?=
 =?utf-8?B?dWQyN0ZUSjh3RVdjSm5YKyt3SC9qN3dmclpyVzJOWG8ySGszaGVnd2R2NStq?=
 =?utf-8?B?VVRkc29hOHZQY3hZaVVTbTMzNVcrZFl2UHpnMnpSa3lYTDZjOVpuZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4717ad56-d679-4a35-15fd-08de4f6a0cd5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 10:30:03.6461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZBTDYRa+ihuxUUYygWsVwxk3YyrGa00TXzXPIMTmS9LEhMvxULR/jPQ7TsLX04vRv/cHIS/79Us4fsrW773DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3920
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jan 2026 10:30:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21498

On 08.01.26 16:16, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  doc/README.layer-integration.md | 51 +++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 doc/README.layer-integration.md
> 
> diff --git a/doc/README.layer-integration.md b/doc/README.layer-integration.md
> new file mode 100644
> index 0000000..1e1973c
> --- /dev/null
> +++ b/doc/README.layer-integration.md
> @@ -0,0 +1,51 @@
> +# Integrate isar-cip-core in an Isar layer
> +
> +This document describes how to integrate isar-cip-core into a existing isar layer and build a
> +A/B root file system which can be updated with SWUpdate.
> +
> +## Add cip-core to a kas.yaml
> +
> +Add the isar-cip-core layer to a kas-file:
> +```yaml
> +  cip-core:
> +    url: https://gitlab.com/cip-project/cip-core/isar-cip-core.git
> +    branch: master
> +```
> +
> +## Configure the root filesystem for A/B Updates
> +
> +Add this line switches the root file system to a read-only file system
> +with /etc as overlay. It also installs and configures efibootguard and SWUpdate.
> +An additional image type is generated with contains the update artifacts.
> +
> +```bitbake
> +require recipes-core/images/swupdate.inc
> +```
> +
> +## Create a image description
> +
> +Create a new wks file to describe the image. It is recommended to use
> + [wic/qemu-amd64-efibootguard.wks.in](../wic/qemu-amd64-efibootguard.wks.in) as
> + the base for this image. As all necessary variables are set.
> +
> +## Set variables
> +
> +Generate the uuid for the root file system partitions. These variables are used
> +by SWUpdate to select the update partition.
> +```
> +ABROOTFS_PART_UUID_A = "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
> +ABROOTFS_PART_UUID_B = "YYYYYYYY-YYYY-YYYY-YYYY-YYYYYYYYYYYY"
> +```
> +
> +Set the certificate source and mechanism to sign the update artifact.
> +
> +```
> +PREFERRED_PROVIDER_swupdate-certificates-key = "swupdate-certificates-key-snakeoil"
> +PREFERRED_PROVIDER_swupdate-certificates = "swupdate-certificates-snakeoil"
> +PREFERRED_PROVIDER_swupdate-signer = "swupdate-signer-cms"
> +```
> +
> +Set  the variable `OVERRIDES` to `:swupdate` to customize the initramfs:
> +```
> +OVERRIDES .= ":swupdate"
> +```

Applied up to here so far to give everything some test exposure while
clarifying my questions on patch 7.

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

