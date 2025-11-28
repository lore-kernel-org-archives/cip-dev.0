Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5323FD116EA
	for <webhook@archiver.kernel.org>; Fri, 28 Nov 2025 10:18:49 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.22])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13085.1764325121959846676
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Nov 2025 02:18:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=NTA7Qprq;
 spf=pass (domain: siemens.com, ip: 40.107.162.22, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWllLbYw4VEyOoXRMVqT325PQEJxwNNEOgvVZ1DykoBcaUDFKku9GXDRSW12YyEBdployHntTQme3k4P7J5AofWKDTLMBWka8XpH5g1VyUpyc5MnRElKR2ei/CG8LHcy1QtBttOLJjXRY4ViG4lyNQv59Q32DR9aFSowGolZtI1+s0jrtCq8doyg9LlkxvR1NZeW3Y6sn3hgnEyHIf/AuJzH/b1uC/AFRNUUtNQvbD6H6GyfjE1w3I59Q14ljiWwOQ6axQhY3muW52hkZRjIIy4JljvqN1v6bL0+UJvFwmFDmMRomX9bKbu65kCqnfSnWLZU+RdfJczjnEvxsiLezg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9XwTNEM8MpUwXObkd2arYLIi+kZ1hqZfopzHlGptGQ=;
 b=xKT4MV5ubbwqh8bRa7Te9EsxFuQHPMKsHOhNdsSJf7Vus0czmX/KAcYK0jVj177bIxRn542cJcdoZm/+ug7vLiZjv+LgyVI3KEfcbQkHldtim634KZQJgpJyZMVadCaVBrV1PlrDYc7B8nj/f9i7j4rozfyO/jNbL/1VWsNhoHSsAyK1bMLhllHnWFMEvPEL/KKXXcXqqK6NfG+GEtygSVpp5jLsAu0/C7o79XC5mA3UYXQTlsAq4stmIL7FgbecgdC277KyMynHRmukV5MBhHqm8KhVM6cdad5gIBW5O7fGv5Rcoxlnf4u6Om/y1WLiJstcPeMS2UDRrO4QPip6qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9XwTNEM8MpUwXObkd2arYLIi+kZ1hqZfopzHlGptGQ=;
 b=NTA7QprqtWLuhCIefAhNYsiSmyDPUHpXbnlox2WnOs/bLOSoJAFENMvmMf1xdj3GP68qEwsq9vUT21nUxNWf26628LswXg94GU0ebey7FrgrlGDDcBVdO3UtW+K7VsQ4FDN2czivyf/5Qr+JqIJHm25ftt5cCKWllXIfM2V8jfHXLP5rvXvAFgm+ZfcLU0n5zX/9IzxpEW7eK/EyyCQUNj0SgBtvrH3iSxelzSt8SATJ3EQWjUoPLA+z9faKHi/ISyUoNbh3IbDiEWNpAc6cOwxcgx/lJO8QJnhQsFEqNSSyGrybHdOlxjFyQSCIUTSrsJvu6GtGfAPNEP2iXjKYew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB9170.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:214::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Fri, 28 Nov
 2025 10:18:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 10:18:36 +0000
Message-ID: <d557dd8e-3f5e-403e-b741-7e4c32dee062@siemens.com>
Date: Fri, 28 Nov 2025 11:18:35 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Chris Paterson <Chris.Paterson2@renesas.com>,
 cip-dev <cip-dev@lists.cip-project.org>
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: Enable KVM for x86 qemu lava devices
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
X-ClientProxiedBy: FR4P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB9170:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a3a5dd7-28e4-4f77-ebec-08de2e677e33
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?N1VncmpoSWhYc25RSy9zTi9hZVhZVnRnUFBKZE51b3dNdUNDSmdYOXpPQ3pU?=
 =?utf-8?B?NnAvRE9ZSFhZdjVtaXBjWFIwbTgxV29abXBpTWZWdEVZM29YTHF1UnpCSzRY?=
 =?utf-8?B?WGQ0Z0tZOGNjZVRYekNTQXNoUVFLdC9RNkthSnN3R0VnNm9aSXhSc3J5b2RN?=
 =?utf-8?B?azJxTTVyaTh3ZTIvWkVYUGVxQUZNeVpTemF2NEZOWnJCWEhWUGlQR2YybWYw?=
 =?utf-8?B?WFFXRFRJekNteUkrbnZWZDRRVWd6RXZEL2oyNG5pcExxMFN6WTU0MjhQR3g0?=
 =?utf-8?B?T3RuVHlCdndoN1p0d2lLWXBxU1VTaDA3QXY0K1ZGTTI2YkYrbUxpakRmVHVS?=
 =?utf-8?B?dnYxSW5UdWZwYU5VV2tLNUJ5UVRVblYwa1VEWVRuNmFRTC9IKzE5R2V0LzNM?=
 =?utf-8?B?aDJnR1Rqa2piclJCQ0VSbWpjajlhak1jWGdUbi9rOGhnM3BSRi9ZYVRwcGhx?=
 =?utf-8?B?R0t1WHRiMWxsVWsxT3BHSjRzN1NyNzJhUmEzNDMzeVl6ZE5kem1pbXpDSUxX?=
 =?utf-8?B?dHdkMnoxdEhaclY4eTBOTzFtcEFzWGdMUkNjRnhSS203Zjd0Ni9Pa2c5eDJw?=
 =?utf-8?B?TytQM29KUTNPRTVnaGNqdjA4eUw2QjI5aTYxNnhUR3lzMkVESVFoOVhmckxN?=
 =?utf-8?B?NjNQN2Z6QnJsZmplYW93ZUdXSmhQc3JyclFQbkg0WkJZNFRjSUFnNWhIbC9s?=
 =?utf-8?B?VmdVeGo4UTlhNmVTd3MrNmVsbGwxM2ZPc0lpQTdVRjdlN1RwRUwvbWkxOVVB?=
 =?utf-8?B?bFRkRWdGbUx3NkRiK3FINTlmSlI5VklKb2NTWGFMd0RaL2J2T0RhUUdUM1lm?=
 =?utf-8?B?ZzN5REhKbDJ6cmIya0h4TE14T1lvUEJQaDE4NWZLbUd1aXNNWXRZa2dIcjdS?=
 =?utf-8?B?MFNTSnF6Q3FKSnE5YW5SeG5ocHhSMFVSRDV3Z2hvdHpRSUpGWFB3dUhrQ09k?=
 =?utf-8?B?SzRHZ1F5TFV3VW5Mc2ZIMEJXSnRaNWJLRDFrY2tibHBOVWlWU3BHNjl4TXJX?=
 =?utf-8?B?ZEtIZUt0cG1NNjJtRHl6aWFPMlRLNjFEUjBnMEd2N3UvR0dGT0RHaDRTMkp4?=
 =?utf-8?B?WUhxMWJHMStSWlVFdkQ0czNIK1hiWURUc3pUMEZkOU56V09jMElleFZYRHhL?=
 =?utf-8?B?NWZBYUNvSDdlQzFzaUhacXo1ejVjaTllWDI1TDJOd1UySEZLWTMvTThwL2Va?=
 =?utf-8?B?ODYyMDhaZ3M4UnJkbDR2ZnFzOXRXVVZLL2t3dGpqbkE2eXdTSG9VTjIzT1lP?=
 =?utf-8?B?TlgxVWRPT2t2MmpjNmhlb0QxVzZHVUFaQnp5Y0pJMEdwQnhEd1FvRVEzcUVt?=
 =?utf-8?B?S3o0V0F1bmFwaEpCek5mUUlQTHhRL2xaZk5STFpsalFVQnMwajdOajVseStW?=
 =?utf-8?B?cm1JZTVYY21wZEVqR0NXSXE3bkV0VVQzS01yeEQrbTRFK0dNS2RaSmdsOXU5?=
 =?utf-8?B?RHVXQWVKdzlYcVdsOWUwYUs3VUNhK1lCQm9KOGJEY3ZYbFBhRndQeE81M1Za?=
 =?utf-8?B?eEFXY0FZMStpbFZmZ0JKWGVpT3pKaWh1bzN3djFMSy83QkVUaENJKzZpejZD?=
 =?utf-8?B?WGw1ZlBNbC9ySGMvRVlXTEp6RjRVUzNkOWlBNEdUaXNoa2VRaTRUTW5ENHJB?=
 =?utf-8?B?VDRpTXhSV1daUlh5TURrUmY1dlJCR2NJSFVSczVRMDhOSjRNNGF0aldrUytt?=
 =?utf-8?B?eVRZSWJjNm1GVkN3ZlFXZlhzaFdsWGR0WG8rQXVEdDhDbDFiZnE5ZjZEVkV2?=
 =?utf-8?B?UVRrNWFZV3R6d20vM3d0SFF4VlNhOXQ2RHlqMDFDU01Wd3dYRlp0OUVSY1k5?=
 =?utf-8?B?eTY3KzFXZlhraEovUTNTOFhTNXVoRXlha1RjWmx4NEJCYUU5bWZXSCtDZmVR?=
 =?utf-8?B?RjE5S3RsOGV0c0EyTlk3S0FXWEZmTVlhMGJRalY2aHRDWThVTUt0SzhQZlVz?=
 =?utf-8?Q?VdGzA6J+FK4IlVZMpcVZKSJ9jT81xR0K?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aXFWUmx0ZVo2L2NGVzVVek4xNTN1VDNCU1l2Y2lsMzBab0Y3b2hZM2d6bGh0?=
 =?utf-8?B?VTNIYS9vYTRaU0NDazRPOWR4UkJCSitlSXl4UVZBRENUU1hEQ2RDZUNYMm92?=
 =?utf-8?B?OVk0VDNzaUFUZkVDMnZxTU1Gd2trcmc4M29VV0kxSHVvKzczVHNHRG5yUkFJ?=
 =?utf-8?B?THhSR2NrbVRTY0plRUtXTEozQmJoMmtrWkdOa21UTWZHSmxNM2ZUQjZtdDRM?=
 =?utf-8?B?eldEWUFoNWJiT1psOFdtUnBCb3lmYXBNTmdPcXp3LzBiaTJoVFcwNzZnTzVx?=
 =?utf-8?B?dWtkRVlGek5NYUJPemJUOE1ycHVqSUdxQzlLL3pzemdKam9sdCtaM09RVGR1?=
 =?utf-8?B?TElubHYrNHhoUUs4S1lvUmJsOGd6YkhYSTVYYjlDTHZIa3Z1UHpOcFVmbi9o?=
 =?utf-8?B?VnpJdUNEcGhNbGJpWXRUcDhTUnRXT2lWSWhvSlpCL0lOU0MyLys2aFNsajU2?=
 =?utf-8?B?b01sRHZmVVQyNDFlb3Y0dS82djJ4MHJJUEx6QVFtTEtuUXN1NU9KRDNXMHZz?=
 =?utf-8?B?OG1sQjdsanBoOVE1MnpYRmQ0MXV6WnVmMWFBQ0dFTTlURjU4SkpJQ3E0Tnc0?=
 =?utf-8?B?NmNZQ29kSUdQby9tSmpPeC9EZngvdlgvMWJtMFpMajBZeHdrem92Z2xTdFdK?=
 =?utf-8?B?ODR2TjBTOEYzWUN0d2tQbWJ1Q0R1ZVdJUWhnUS9xdG9VSjB5aENDVnNrUGRq?=
 =?utf-8?B?UjlpSk9NVDJ1NUdMRkM5VWpYRXlsSXNXUnZIUlFjNElUTjRRMmdDWUJMSDdT?=
 =?utf-8?B?Ymh1ell6Z2t2amZNL1l3RjRML1pRMjVvdDdzbnRUNkxGRWVOdEZKWjdYZ2My?=
 =?utf-8?B?aFBranAxcXhhZUdGUG5IWitBR294dW90NENneDVCRFpnUHVJTGF2a2hvY3VV?=
 =?utf-8?B?dVdDQkRaelpxNjhSbWU4MWlpRkdOMUJGUGRKM3lTSDd3dFZPRHdZeTZpTkp5?=
 =?utf-8?B?S2s3ZkY3ejQwTzE4SzBRRzR0Z0dlNXJlZGlINk9uQVdzTExYanRJY05QS2Zy?=
 =?utf-8?B?SUJkeWFoZUo2U1VISWhhQU1mRGsyNHBXMEZITWx4NU1NeXVpdXBtbm9jd3lQ?=
 =?utf-8?B?TVVLZGhLem41b2RCbk0xcHNrWlJRTTlPN3owYnhYVGtPcFBTQzFWQWJZTUg0?=
 =?utf-8?B?VWVzWXdjb2NqWUQ4a3BoYVVpc0szZDJTaVR2OVZ0dDM2VTdxemR4UUdLOWxi?=
 =?utf-8?B?WmduQ0N6SkpiZGpGSlowSGgxVFQ5eFI0UEN5RVBVVjlVVTd3bE1RSzh6ZmlT?=
 =?utf-8?B?NzFrbjVOdEtYV0c2YW9MMTVkczFlUUc4RG9hbjQzU1QrSDUzbnpmaGpac09U?=
 =?utf-8?B?WWdSUjJ3R2RwYXJIR2dWYzBkNnhrVGZMaG4rL3U2empxYTZwYW8zMWNHMDNa?=
 =?utf-8?B?MEZ1UUJnYm96a1RuY2F5bnd3R1JVZkU5N1JoeTh4NWlhMXF4N1U4Y2ZFc0Jq?=
 =?utf-8?B?U1JIelljRGhwemlKQ1hKM0oxemdnSUR5OWcvOCtUUm5EUTJxOWpKc0J6WkV2?=
 =?utf-8?B?TjZ4RE9qUkhFcHVWeldZNTNpcEFVZXJMcjVhTmhTVEkvU1dTOXJ4TXV3emV5?=
 =?utf-8?B?UHovZUpISm5FaVdtZXI5R283LzFyUjJPK3RaRWpMZ2lsOGpwRVBVT0tUSHQv?=
 =?utf-8?B?T1FNSUdpZCtyL01aVHRweUo3RWJ3cFFYdXpITW5FVkFKbVZNTEFHMVZhTnhU?=
 =?utf-8?B?YmJ6eXM0SnUyYS9oMGFpY1dCV3RyV0I0TVBiZHFxbE9qSmw4aFJ2NTNTdE43?=
 =?utf-8?B?T0tTN0hlOHo4eFJFUHNHNzJpYzRZaG1EM1pXY0V3dXVmWGVMeDJ1cE1zV0t2?=
 =?utf-8?B?Y1Y5bEIvTWVaSDllVENPZldiL0NTM0w5b0NpaGY3OXBCdElwdXpCdTZORG1y?=
 =?utf-8?B?M2dHdHQ5alpRYmNCbERBaWx6NGNmaExzd0ppTitsRFI1c1RVRENKTHFKYjdm?=
 =?utf-8?B?citCTjdxUURUbVk3SENXd2xVS3c1aENta2wzbTVic3VsMUNONVE1c1JSRDBV?=
 =?utf-8?B?aFg2YVhFRFFJY3JBYS9xMmRTK0RMdDduNnUyazZWWGlESkIrRHA2LzF4ODFk?=
 =?utf-8?B?SnVldi9oczBaaG1BUTAzRXdLUzZZaiszZG9LUUROejlGSW9ZdU0yNHNoSmRj?=
 =?utf-8?B?clVjMndnTGJkdHpMWjd4ME1pZVNTYmo2c1dHY2Z1c091QTBzTytNQVRWVmZ5?=
 =?utf-8?B?L3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3a5dd7-28e4-4f77-ebec-08de2e677e33
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 10:18:36.8339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o9mRoEZKdNPBQKnNtLFG7KER6/Nb6+B2+zsc4Iso2BUMWmlB+1HO5C7TGxgOzEf5qDxMXnEe9vDVhcRQWh9flw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9170
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Nov 2025 10:18:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20764

Hi all,

it's almost embarrassing, but we are still struggling to get our CI
running with trixie images. Another blocker was identified today, and
that is insufficient CPU features when running with TCG(!) qemu machines
for x86 in LAVA. I played with lifting TCG features levels up, but
didn't find a matching CPU model yet, and that might also be because of
missing qemu support in general.

Both from the feature perspective (forky will raise the arch level e.g.)
and the parity with local execution (start-qemu.sh), we should really
switch to KVM devices only (for x86).

Quirin identified that the following labs still have KVM off:

- https://lava.ciplatform.org/scheduler/worker/lab-cip-cybertrust
- https://lava.ciplatform.org/scheduler/worker/lab-patersonc
- https://lava.ciplatform.org/scheduler/worker/lab-cip-renesas

Can we change this?

Thanks,
Jan

PS: This one is currently under test and consequently fails depending on
the device:
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/321c401d1de763ab9b7c7afb0c13d26f0a70b7c5

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


