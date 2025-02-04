Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5236C02196
	for <webhook@archiver.kernel.org>; Tue,  4 Feb 2025 13:24:37 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.79])
 by mx.groups.io with SMTP id smtpd.web11.115662.1738675468945436127
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Feb 2025 05:24:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=oc3BydV8;
 spf=pass (domain: siemens.com, ip: 40.107.247.79, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PvLSMselomwfsZzznF/L9NDyPexWQ7pYLs7cI35+Lx510w8fDIOrJuRhIbY99JL379LwAATDuKkiz1a6jImhs0xYtOEYOh9SLDHDGL0/UKnvPef1aSt5dhCZHglRxpsBj4E5Y6O59XUvt1JKeGvTXgflIkeBNRDhd+Ubv0WsIfhOHPQavms1JF5hAcVmgMdLr3UQB3sx6cK65WCDXZzWrmxkdaH6fEOK5rTacw7ucE+pBLVUeTk4VRTOOSQ0FrzUo+zxtg1in4y687MmrvAev4Gq9/AtRKbj7+bquQ7GaneofM36fi3CG89jJAJt5IIJsHgoneZtQK/X6cQpbQJD+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXiXl8wx/2XV0VZfwvHveqo5dEmluTMugYQS12yHPmE=;
 b=FCOkfGTL2rHTK6X3Syjcl/btFS8nNeF0/oF64DwiiJ3JnsCoUbFLjkGP5rnHSNEHfYGugGA9sXssD5DkqY4iX1FuIpozFYpIv+RBIxVXqAAJfnVgVYtiGo6o7bup/MJBaRuGrpvkaMQLIyAoNtnTveIk94XPO+D8oSYuxVRE4A0x1XdveFeLrvDD8/GvJpAKRB4AkLOXr58b0IKVqnuk4QO8u9LWJEhN94+pBWgZhtRC1wGSzugHwsdvG/Jda4qm5B4U8EphsI+7SwCJ+K3wSQn8Eo8NyZsOlbGirbMyOcttGRroyZHUkc0qFru4y2u6FsrkkwD09yO54n/HJAp1eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXiXl8wx/2XV0VZfwvHveqo5dEmluTMugYQS12yHPmE=;
 b=oc3BydV8+2vFUNXMa8pkh2v7Sym2Hd98oHpnD0Tbgvk1cDUaBfAaPeXCTNvLmQohnays5z/4nmBXfWZTW3PYbO/a2jztpBeCNHGQtOt6R4r1yNfWF40e7J2hmprgAtwAofTFuzdmtv9SNloGulN8JQjXF4dDXSQQMLPs6g/q53DRsQdg1M5KJ4E9PHScUe04J9sgyVoY6+w3KSDFGeQrIJga2odjdWig005uQXqcqzk5Fw/MMRsqhXPkAE5r9GWIdP4N4nxPS3DGocXKAMNSfjPOd7ssqPFcifo5snHNjYW3PxJkCMlpP1rcbjjRRndPwHXMEBLaZNgklazujy+TGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8341.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Tue, 4 Feb
 2025 13:24:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8422.009; Tue, 4 Feb 2025
 13:24:25 +0000
Message-ID: <2334f4d8-34cd-4321-bda2-5bca552316a9@siemens.com>
Date: Tue, 4 Feb 2025 14:24:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 4/4] .gitlab-ci.yml: Remove
 unused build jobs
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
References: <20250131152553.270393-1-Quirin.Gylstorff@siemens.com>
 <20250131152553.270393-5-Quirin.Gylstorff@siemens.com>
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
In-Reply-To: <20250131152553.270393-5-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8341:EE_
X-MS-Office365-Filtering-Correlation-Id: 81950975-31ff-458e-231d-08dd451f3ec5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VTZyQ3MyNENaaGZUTTRmb0llUVhTalFQMDNCTWJGVExpSG0va1Nkei9zZXlx?=
 =?utf-8?B?Y3ljS1Zaa1pDSTM0OUZ5eXQ1MlFmRVprRXlFdEhOV001RmhZeElzbTdNQU4z?=
 =?utf-8?B?RHJ5OGRNV2xscmxCb3d4SEV4TEVxWDRoR3FCRGhXcHdCQXVBQVRXYzZLNnp0?=
 =?utf-8?B?ZG1Ob293bytseVdTVVlZZU9OelIvS1ZGZHNBVEw2WktaejRhQ3gxVUZnd1RN?=
 =?utf-8?B?eDBnbE5aUytRMmJkenM1ZnBWQU00WnJzKzdRenBia3pkcTdLWFAxQkFvK0FP?=
 =?utf-8?B?Nis5TjdORFErSU44WElaMGpWRi9wSG16dFU4eVVyOG5VNXBIeG9XN2k4enVG?=
 =?utf-8?B?RmlnMUhjZ29zS2hVeUJLWCtXMWpjeFN4ZmlxTGZGUHZ5RTlJbGpNL3ErQVd6?=
 =?utf-8?B?bVMwQmxOWFl6cFZhLzA5enMydWxsRjJZZzd1WnJ1TEhFdlFsNTVTaWdxYnZp?=
 =?utf-8?B?bEF1cVQ4M3k5ZXh6OWsyMnRUU2dIUkhOUlNSSkhUeDhpdVV6OHpWVFlnRU9V?=
 =?utf-8?B?NVBicFlpcDdYczNlUW1ZcDgwbWZEN0JHNUYrUkhRTFk0MzY3Sk5TVHJEbHhj?=
 =?utf-8?B?Y2JnK09tTkhQWi9lQWo1bVNBMXNtbWptRU81T2lGTDNlUmxmbmlBRWdrd1ZM?=
 =?utf-8?B?NzZjRzdTZVNUU0E1N1N3UDI3SUE3ei9RMUp3d3pIM1hEWUErcURvZ0MveVdN?=
 =?utf-8?B?Q08vVWk5YVFxZFJFOFp2TDFaSFBMQXpuMjdnSDU5VzVIODkwL2RmS216c1RB?=
 =?utf-8?B?dzBCazlIeGZrZXNDakI1RURWY3hSU2I4SFlURXp4djJ0ZWVud0RGeGVUODd5?=
 =?utf-8?B?YUJveTRROUxJZnhHVTBFckcwb1VvNE04LzNkN1lKUThsUGxpREJ0YXNsdm1j?=
 =?utf-8?B?eTBhNUJZL0NMc3I3eDNkZno4RTVZa3FhZDhlSTFFZTdLOFkzSCtUZnpUUmV5?=
 =?utf-8?B?MDNXRnBnU3lUWktWTWxIdDEzTXdjcW1KVjhPOWxEam1pNHlYQ3pWVWNaUFhW?=
 =?utf-8?B?TkRiYk5CK1ZhWjE0TFladWcvUTExV2hYZmJLSkxjVlJyMG5GVnZwNUU1aVVu?=
 =?utf-8?B?Wm9MeHhzcXJXQTd4Y216TUdPeDhjczBkTkQyS0IxVmJKSldBUWtZSVpjT2Va?=
 =?utf-8?B?ZGJlRExIMzY4b0xWTFpVNWhJUWRFa0pTYlJCVCszeWxyNGp0ZExpRkRXYlpP?=
 =?utf-8?B?K25BUndDaWpxSmVDZW04Si9zdGU1U1JKR3cwR3NqbU1XbCtNdmM5U1JBK3pK?=
 =?utf-8?B?dWFLN1ZVNjF6S2hmM2tTZVlJKzhrQW8zbldmQlc0M2IzbjVrcEthamtJbmlO?=
 =?utf-8?B?T0QzRWQwSytLbkRtYkdmYTB6U3dLZ1J4Y2xZakxjcWJBT3pKc3FpOUNncVow?=
 =?utf-8?B?a1BLR2tRaGRpUzRTUzcxWXc0VnUzWWU1NzY3YWxSeU9DTjJWNlhYTUlUODBr?=
 =?utf-8?B?V0o1dG1NMlRILzJCdldaNlRXZ3N0WGcwL3pzUy93aDFvUG9HU2xmZW5zMFd5?=
 =?utf-8?B?NmI1R0x1SEQzMjBuUlhOaHhpRHdYcDhMZG11bW9zNEUxUTdzUEc3aDN5dWgy?=
 =?utf-8?B?TURHZDRjbjlEcnlMMVJweG1rR1hzYys1WkF2R1kwVzNyZ0VrUDBES1A3dXdt?=
 =?utf-8?B?UlNiVnUyYmRObWlyZzd2dU1PaEpGUXlGTUZBdHM1ZTd6bHVkS1Fka1c2UVVo?=
 =?utf-8?B?RTBWMUtYbnQvckk0cklQZEpraFA1R0tHNjdSNm1CR2kwdGx1bWk0cThXSitJ?=
 =?utf-8?B?bUkvYmc4VVNXcHU1WEZVTU1HMDdpaXVjaytxTnpKc1BtMzI2RVNwcUw2eEs1?=
 =?utf-8?B?dGswclJ3M1U2SlZwTHNaNVd5eTE2OUQ5UytIaFR3WWVwcXFzSXg2WndrbU9j?=
 =?utf-8?Q?IEMEwVSss0ofG?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VWtOK3ljcUp3OVJLK21wWkQwTGJmdTg2MDZXVnZLSk55SkRWMjVKaitGc3gv?=
 =?utf-8?B?SVk2bStHcTRkQkhjVXJ3dnMzNjUwODd3ekRjTHhmM2RMa2QvK3loRzA4MVVy?=
 =?utf-8?B?cUI0QVVsbzc4dlRuYTNvQTZPTFhEenNVSTRvbDY0N0wvWGs1a01vYk5QOGF4?=
 =?utf-8?B?T082MS92bEhwK2RFNC8rNkwxMWo1NW9ERjdCTjZjSDdpMGdZR3M2cTVYRlpn?=
 =?utf-8?B?SlAxblIwSEdHdFgxRWZqcEkwL3AwSzNiRmNUYllHd01BNzFrM25mellOS24r?=
 =?utf-8?B?aGxVY3R0cktLelBsRkhVYzVzQTgvMG4rVjdPVWYvRHIvSU1ENnlTaEVLZ1I1?=
 =?utf-8?B?TFluRVM2cnNlMFd1TG1RaXI3SnhqOS80cTRBeE44SWo5WUNrTHhyT1pxbStO?=
 =?utf-8?B?eGFMcm55TUQyeThFL2FRRzJlU0lLRTlwcEkxV2tvYmNOanlQaEtCR1FXM25i?=
 =?utf-8?B?UGZTYVE5Q1NrazBSdnBBWE1MQnNXak42ckh2dnE1ZWc0UkVob0tYRldJYUJt?=
 =?utf-8?B?WXV3Q0pDQnJidnFIbGw3SHhXVmVUVE1wR2lMUmxhdFgzbWtnS2xFbGdvbFUy?=
 =?utf-8?B?MzNVY1MzTFBGazU4MHU3aXBtWm1lZGxpNUFEYStHU0NjR3Z4cHZqMUJxMUFa?=
 =?utf-8?B?Zk9qSHgxZkx0OVowaTkzSjlNeVIvekFMdC9zTXFoTjNZWEZNZTljWHpidXBv?=
 =?utf-8?B?TFI4bWNzQjFkL1dmUjJCNkU0OEhWUmQvOUpKbjNKK3N1OHFFbHJwdjE3Qndr?=
 =?utf-8?B?c051Nm9MbUZkZ3pTU2s4dThPR1JRNVF3Y013TWJ4SDUwOHUrWVN2cGV6RjBk?=
 =?utf-8?B?M1ZYTFoxMXUxQ3VKYWdIUDlyQXRkcWZnT1JKVVE4SVlhelJ4MEh4eW9OQitG?=
 =?utf-8?B?VzRUUzdXaVpWVkgzTHY4OGcreThQcnd6VGlGMHBpMi95NkczL09TNng3d0xE?=
 =?utf-8?B?bTl6TlRONU9zR3pBKzUzdmZXM21Pd3ROWGUwUGVOVGgrYlBnUE0xeU5oZXdO?=
 =?utf-8?B?OGRvdWJIRU8xdTFMTmNFaGlsNlByQ0VLMkxFL0pYcUpDSGRVeGxQZjZic2t1?=
 =?utf-8?B?YmNDTTA5TkRLMmcwajZHZDlaeEk3SUxXdk1nMHFGZm9uaThvZHdPbU1Kaldy?=
 =?utf-8?B?OVFuQ1NWck9xS2JkcUNYaDhXckRDaTJCVkxKeC9TQWFOWkQ5TmUyNTA3ZjFT?=
 =?utf-8?B?cHF6R1p1RnQ3WGpNekRzTkMwNURmUlhlOXY2VEptditmeHRtZFlJYVBIT1p1?=
 =?utf-8?B?a0p1Q2Yxa2pES3BNdzlCSEdWbk9QNmFIbDNXTGpjWFMrdGttZnV6NU9scjgr?=
 =?utf-8?B?Zk83WVdsUVV4UGJLR0NUTDJjZnVDVkp0T3J1Rmo5MFluZmxWSGpnWUp0K2xo?=
 =?utf-8?B?VzcrekhvRGVWaTFCdnRJNk9LVnZjeFdpTVNUS3B2YnJNOU8yUjU3VTRSVkFv?=
 =?utf-8?B?WmE0K1UvTExOOFp5OXE1MFF0Q2JFdVpDQ1FWSjgzVDUyT1E3ZzBUVTlYSTZ1?=
 =?utf-8?B?OUE4NmNWb2dKKy9HRndwZ1VUeEk4OWJCNDNrMGlFZFdscHVhTXJ2SFZUUjRO?=
 =?utf-8?B?cHNmdXVGS3ZJMm1RQTgwMVdMT2c4WlNXSiswakdKWkJwSXV4Nm9Gd1ZsdnVY?=
 =?utf-8?B?SkVyUUY1dk4yTkEycVcrUjhUK3h3d213alBzMGdXdWtBYzJPL0lGVnBWL2FC?=
 =?utf-8?B?WUxyZ1VSQ1NkNUVRU0RRS3NYSXZzcEJHZEVEbEZ2Z0hDREhPL2I1N05YSzIx?=
 =?utf-8?B?ckZpcG9wdmxsZE1CbWNKRldaVW0vYjhhZE1EOGk1TkNLOWt4a0t1dkJ0WDkw?=
 =?utf-8?B?VXlRVHJvQlF5OUYyamk0TXRCQ2YwQzlNazdxdklGYXpmZy8xMzdFMTVFYkx5?=
 =?utf-8?B?TVpEakFlaEFLSmtuRk5RZ1ozbW5jalJhc0VYV1AzR1RDWEJkRFlFa3Z6Zkgz?=
 =?utf-8?B?WXlFN0pHSGlBRkxiR0ZENGltdUxVTUVDRURGNGpZdWpyQWd2Q2pkblBmMXJr?=
 =?utf-8?B?YU80YmRtcTZhOHdwdmxobkNrSkxFbmovN3U4NkZqU2hyZ2VtSklaNFMwTkU1?=
 =?utf-8?B?czJPOXVFVFdySUxzeHVUY0Q3T2hHQUdWdmJ1OVFESjA4aUtabXVFdGRkcWVN?=
 =?utf-8?B?OHZmanRoUXQ3SW5qdnpVeTFxZ3prOTMyNHEwMmxQazV5THBKVzhVMUs0RFNM?=
 =?utf-8?B?cUNkSDdWNjdmQUV1cmhIUXc5aEdORUJDNWVPbUFGTWNDRVpzMStVcGlDZTli?=
 =?utf-8?B?K2gzUENvK3ppR1NVdXJvN1dEdUd3PT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81950975-31ff-458e-231d-08dd451f3ec5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 13:24:25.7054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W/BJ8PhMvlJNTTyNYIKDXvLRzxcQrZ+YM02IBUiFKnS6ejE8zZa5ozEfHvrF4AJ1STNeZ8bhoyQvxjQyfWYVMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8341
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Feb 2025 13:24:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17749

On 31.01.25 16:25, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> These jobs are not used for further testing. qemu-<arch>-base
> builds similar targets as the used security extensions contains
> secure boot and disk encryption.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .gitlab-ci.yml | 44 --------------------------------------------
>  1 file changed, 44 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index d7055f2..36f14db 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -221,28 +221,6 @@ build:qemu-arm-test:
>      target:  qemu-arm
>      extension: test
>  
> -# secure boot images
> -build:qemu-amd64-secure-boot:
> -  extends:
> -    - .build_base
> -  variables:
> -    target: qemu-amd64
> -    extension: ebg-secure-boot-snakeoil
> -    use_rt: disable
> -    targz: disable
> -    deploy: disable
> -
> -build:qemu-amd64-secure-boot-encrypt:
> -  extends:
> -    - .build_base
> -  variables:
> -    target: qemu-amd64
> -    extension: ebg-secure-boot-snakeoil
> -    use_rt: disable
> -    targz: disable
> -    deploy: disable
> -    encrypt: enable
> -
>  build:x86-uefi-secure-boot:
>    extends:
>      - .build_base
> @@ -264,28 +242,6 @@ build:qemu-amd64-swupdate:
>      targz: disable
>      deploy: disable
>  
> -# secure boot images arm64
> -build:qemu-arm64-secure-boot:
> -  extends:
> -    - .build_base
> -  variables:
> -    target: qemu-arm64
> -    extension: ebg-secure-boot-snakeoil
> -    use_rt: disable
> -    targz: disable
> -    deploy: disable
> -
> -# secure boot images arm
> -build:qemu-arm-secure-boot:
> -  extends:
> -    - .build_base
> -  variables:
> -    target: qemu-arm
> -    extension: ebg-secure-boot-snakeoil
> -    use_rt: disable
> -    targz: disable
> -    deploy: disable
> -
>  # bullseye images
>  build:iwg20m-bullseye:
>    extends:

Picking this already as it does not depend on patches 1-3.

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

