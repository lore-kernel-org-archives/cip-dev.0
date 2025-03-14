Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F24C28B2F
	for <webhook@archiver.kernel.org>; Fri, 14 Mar 2025 06:34:03 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.60])
 by mx.groups.io with SMTP id smtpd.web11.7881.1741934040433177765
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Mar 2025 23:34:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=NgVtDHW/;
 spf=pass (domain: siemens.com, ip: 40.107.21.60, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VL6e+BFP4G1mP3dAYo5vU8++4npKwVEMTDb1PZwi8Nrf/KI9EVu+6Z0VIVpsecglS1j3Q1XEVuN3J52kX3E9ln+eBfdKgm1HGxFdQrWAW1wotUmTTb68/NxtKR8aGhOUZZsV9zO3Uqd4cgs8yPeiSGkRlu2gVt7cIg0fvPXf7HDoTlNuR4fJbOSjNlTf0Io0g62I0bE6oZ+jI9v0/U0uMKdUMJhNEbOgrVeq6+p/J6/R2cJ1wSo2+OZlQh1N1RNz15uQKaEEsguysakHtMTaPjEJsZLslBpDBgYMQ9PGtIl/AtBBNnZJUIYpOAccmJ4lL4/pU9KBQ6xSWUcYtu8zZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=865l0N0zysTH1R8m+uu/Nay9wshjRt+mZtylVnsuGy0=;
 b=jps733jy3vfFDjPJdDA6x+BQ0uTpVAqkvPCCWEqvnt7okPCo1+HmH6jVV4T8OhDI1r6JArrkOsmQkAwjz1nGqYst9Jr5xoterlMfrJIdk8OStgagsZiYks8L1+F/Dn+FRGPaCeIJsw5Mu5BJfv/U4NPDV39giuTMC+X4KfKCSfV1tCSZbfseKcro+HYtdjyHxFHITj53fNYEyFzSqo4DRAvkxBvUXLVor0p7cQj1Wzjcxh7L+O2FHgz26gzIPnEhp/DMkms/9L/ln/rpXkAGmwH9REFwrT02nyx4dm4EW91epbqwJQamAETGeJs7QQxliTADaJluW3dQqZUftQ551g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=865l0N0zysTH1R8m+uu/Nay9wshjRt+mZtylVnsuGy0=;
 b=NgVtDHW/ZGAI0KQLzEWliJkLpk9vD/Lnf0u+nS7NSXyQbOeLO9s+IFq4SB0djTXcA5/ivOm7ITw6NBxXIdZwgngXbtux1UMYctgWGMJpTDIvVvIgWHh30MGFjbRE9iafSPEHfX3OalITw84xInzi1jysFUP6NXYgFaGfvvRvOtUz/LI3fgdl0Zjfpqras4HY6dTyGfeNgZhMr0D7LlkeZ/QswOUUSpHmIWRd4SLiWIdHM8GzgBzx/daKsrRg9VP16jGAkp9UMB+ElkNtRAAF0iyarqEiolmw+c/B4FBA1WMOJr4atb4VadEPSCR0QgasjAAq0VeWI/7bMPlFR0HC3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5595.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Fri, 14 Mar
 2025 06:33:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 06:33:56 +0000
Message-ID: <976fc8d9-fd6c-4a8b-8f24-da70f6e692a2@siemens.com>
Date: Fri, 14 Mar 2025 07:33:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] initramfs-crypt-hook patch
To: Claudius Heine <ch@denx.de>, cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Alexander <alexander.heinisch@siemens.com>
References: <20250313-initramfs-crypt-hook-patches-2-v5-0-fc62d4a2ad29@denx.de>
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
In-Reply-To: <20250313-initramfs-crypt-hook-patches-2-v5-0-fc62d4a2ad29@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0205.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5595:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f0f864e-5798-4b53-e3ae-08dd62c2326f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bGwwZ0FEZlhKL2ZxZTc1cUovMmRkbzZFcFdoNmlBRXNVT2NOV0hjZUlPSlAr?=
 =?utf-8?B?VjJsTlhyQ2ZHRHJVaVYyc3FhMWRybmRCNzBkbzM4cis3cjdiVUtEakNtT0pO?=
 =?utf-8?B?MGtMVXZ0S1BjOW1Cbk1zeHlrZnZ2NDlRL3g5a1FrMkdmaG1TY3ZoN3JTS2Iz?=
 =?utf-8?B?THViSHFIWURNd2NwQ3pXc2w1ZUFFdkcxazl6MVlaQVk4NlU5cjZzSC9LcitE?=
 =?utf-8?B?YzNMcHI1dDRXUzJaZHM3Nk8wcG5UQ3RXRjJoR0loRWZiYUpXdkZjOHd5UTEy?=
 =?utf-8?B?ekh1Vk5nSVIyWG1nUHpkeEhLSE5ndmZ6cnlva0pTdzZBelZRRnhHWnNPeXli?=
 =?utf-8?B?Vkl5MUczL1VvMkVUVTBlNlpqOUJONEoxdytlMG51SHMvY1dqZHM2ZVN1a3RU?=
 =?utf-8?B?TUEwdU1OcDFWdWwzSEVKTVhlSnZiVEtiQm1RRDR0K3RiVDFGd0tZWGJUREFp?=
 =?utf-8?B?UXNRUUsrQTU3QkpZQkF1U21hVDFsZjNoYWkxSGZNWjh6Ny9jRW16NjN5NC9J?=
 =?utf-8?B?RThIc3JGVjVoM3BZMVpyV0Q1SE56N2lwR0J0aTdLQlcrUVE0Mi9MRU1iNHZv?=
 =?utf-8?B?YzJ6eVpFNExIL3BDMjYvaENWLzRXSjh2OXp1bFpNZlY0d1IrWmJGZWlYcXZj?=
 =?utf-8?B?TlBNd25XdzMyQm1JSGY0b3lTaEV4L3Vmc2pVYlFpd3ZZRHZXdjU2WEhrQXhS?=
 =?utf-8?B?emRPc21KN2w3dzUvYzhKRVpDbEFHaHM0QWZBZVQyeUxGaCsrcFB2SkVzK3Fm?=
 =?utf-8?B?ckI0TmhiaWh6MHhCZjFZOUcvRlNSZE1HTGlLTWYwUEt0V3I0OFBzZWxGMnQy?=
 =?utf-8?B?MkxSaFN4WmNHTWNBMW02MFhsVXhqNHN3OEoxLzN2aXNLYis0R1dXSlRIQ3NV?=
 =?utf-8?B?YWlNWUQvWHdFNm9Md25UdVNJUmI0U05OYlU0MTZZakI1NThDeXNTZGF6c2VI?=
 =?utf-8?B?RHRPZStMVWxXRTBkTkRwQ0Q4U3BWSkF3UHFHZTVUQmV0RTdTZ0RMemlGS2hF?=
 =?utf-8?B?U0pNeXZGR1M1SzRiWDZWTXBZYjI2WU9EQWFrMUU3cjRJbmphbWp4aERTU1BW?=
 =?utf-8?B?U2RMVU8xeDRFYkpFU0pnQ1dTTEtvQW50c2lTQmhJdGwwV2lBVGRPOCs4Tmli?=
 =?utf-8?B?a1pFSTg5bC85bFN4VXU1VWdUM1lidjY3Z0M5QTVyMDVvM1kvZDR2WGlRWDVi?=
 =?utf-8?B?VXVuaXhxVU5NZlFkM3ZZR0FESDRhckt1VGZZUWN2Vks2bnFRdDB6THRPVkRF?=
 =?utf-8?B?YnVHemwzWElUeHp5cXFYdjluTTFoWEhtUFJ0dE5RZk1FWE5tVkZHQWlaVnMw?=
 =?utf-8?B?MThZYWZRd2ZNajRRSGkrcnllVVhlVmFpWFl0WXgveXQ1a0pHdmZ4dVY0ZVFy?=
 =?utf-8?B?NjV0OWZDL2hWM3RDOFR4aEY0RGQyeUhVTkNXMTNjSDZENnVwbmp3VjZXYXVK?=
 =?utf-8?B?QXB3TnRLUExDN2R0TDQ5enpiZGVCeE1GY0QxQ2hCelZ1cUdXY0FMSTZiaENS?=
 =?utf-8?B?U0FOdU4rRnJReXBTZlF2amtlVXppM2hiR3AwSm5qUWYwWDNRSUpPSUl3aVVz?=
 =?utf-8?B?MTZpSHorWXJuaWRDTWY3cGFpTDE2VHNsdEdWQklGRXBOYUZxSlh5dFZ1Zmk0?=
 =?utf-8?B?dm9XTUxMSmtmakpqdEMzdzg0MlhaTCswTTltNlBDV0twbDlTZmRGU3BucXl0?=
 =?utf-8?B?dmNYQ3RSQnU0WmF6dEEydit6WVhNQmh0ek9pa2ozV2lZSk44d3hjV2FHNjFW?=
 =?utf-8?B?clhETkt4OEdwa1EwbzQxbGFNZ3p2S1dQNUdDaFZJSnYrOFNtamNPOXhKK0pV?=
 =?utf-8?B?NGIydkRBbDJkTkpwTUxJbUErMklhQzhaMHo1WUJOZjV3VC9MbTUzRGVaQnZ5?=
 =?utf-8?Q?ug42tHFkpSWB/?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Tm15UytLT0NwZ3krTFM3djgzenAydXdVZTdmZ1NHRkU4MG5uYjZrY0hibGhL?=
 =?utf-8?B?VE9vWW9WdUxQay82QnRMU2d4Vndra2ZlVHFwMWJFcmN1dUgvTHIza2N5TGl2?=
 =?utf-8?B?WjVDejVPb2ZzbEZnWGpEd0ZybU1CS0cyN3lBanZtaHRPRjFneEZUTEloTDFt?=
 =?utf-8?B?SklQTjVlZSs0ckQyK3p6VEREamlhb2I3SVpBVXNna3g5OWsyVHBoek5aWExq?=
 =?utf-8?B?VkZPUHUzQjdTbHZKMEhSUGowKzhSUHE4eWtKKzIyV25SUFhMQmx0QzRRejJC?=
 =?utf-8?B?RnRMem80L3U0SmF0NGtUdWdkc1g3TllaMTNkTFkxNXg3Z1RwdUMyU3duQTdK?=
 =?utf-8?B?cWNXMjBZUkZHVlRPUTIycXlYMmJnK09Kb2FuY2hscmh3MlNkZHlEVEdDbkY5?=
 =?utf-8?B?MUVYUlRqZVVqTTV1OGsrMW5hV21kd0hka016NjNuQlVCcVZEZEN0eWNlWk5E?=
 =?utf-8?B?THVWbzV2VGRtWXd4UncyZ3dOSURpNFcyOU5TMHJWRlM0bjIycDhNaE1SMjZz?=
 =?utf-8?B?dWxZemxNNmd3SzNIbFdVaVZQQ0U2ZmxzNlpxY2kwa3ZMWWExYUgvQkdJVFk2?=
 =?utf-8?B?VUQ4WU5SOG1JRzM5NFhCR3RsaGgwQmV0ampyVGtIZmd0K2xReGZCZFY0VzhO?=
 =?utf-8?B?ajZVOGEveXVGTG5WaWcwSFdQR2FtL01DU0hFQUQwbmhCL2ZCTVBNd080ODhB?=
 =?utf-8?B?U0ltYjJoTEVpeXVXTWtpdGpVbVpMYXd6R2c1d1hpcVM0TWxDV1lvNGIwUzlS?=
 =?utf-8?B?WjdFZWpVZEV3QW40Rmd5bzkwTVJseUNLMVZOTVk2blBnZlFnMGg4cXBuM08x?=
 =?utf-8?B?bStqT0w0c0xGMndTZzhNSkJaWWFsY3pieEF0czZyeWMrNm9aQkxUV1lJUC92?=
 =?utf-8?B?SHpDRmsrWlRFSThlYU9NbmZWVmtCV0NiSWxoSkNyS2tSdmlIVmlNV2RLekFC?=
 =?utf-8?B?SnQ4aHl6R2hBYWsxblBybG92eFJIVkFYZzFGZzZ0NjlUdG5xT2Y5SGRBRWlw?=
 =?utf-8?B?R1FuTnRqZmQ2bUNwYWZBdS9LaGwrSUt0V1VpTlBWeVRHb1o2WEVaSnJ4RmQ4?=
 =?utf-8?B?azBHMXJCdGFEWDNWSzFMMEVZTnNSblVKS2JqWTNKa3JmSjZUN0ZscGFNS1pz?=
 =?utf-8?B?RHIwTk1CZWI1VkNyZnZnbzl6KzB0cnByWmhuMW8ycUxCaTVya0UrdWtWK2Fs?=
 =?utf-8?B?bE1zTzFpeEdrb0FrMm9reHl1eVc1dWlsOTF2ckZCTUhjcVQ3RU1UU29zdUQ2?=
 =?utf-8?B?UEkvY3UxVzZ0VmVVbEFjU2d2VVVnVHdjQko1VFBTdndabXU0S0RrSDVBQWI3?=
 =?utf-8?B?VTh1UjZVZFRFVmpHb0ZKTFBFVTJQNkdJbWhmR2djUFh6blVMQnlXVXJlZE9y?=
 =?utf-8?B?WkRUNHhBRzJScmZrZERtcFFaV3NuZERMd1lFVUpsOUozczdKbFdXaDJqS1dq?=
 =?utf-8?B?YUVoZVlFWCt4NUc1clh0a3MvQ0J1WElCZnhTREt6VWZkWHRsanJaWGtndmE2?=
 =?utf-8?B?NjJNK0FxcGZmYzVqWEorQmp1MTlVbTJaZnJpekhEa2RPNHErQ3A5Mm5MMWxn?=
 =?utf-8?B?eExyRjF3Y3UwTlk2YXNtWWNxc0FVeEtqeThQdGM5Z200UUQ0ZWtGRnVhZDJQ?=
 =?utf-8?B?eTNEUXgvUzBSclRvU3pTL3N0cWlKWkN0allOQjVZU0ptSlNNTU15MC9XWkh2?=
 =?utf-8?B?YUxOYlErYkZFQlk3T1JKZzdCNGZoc1RDZ1dlaGw2cXh6ek5vMW85bHIzcEhD?=
 =?utf-8?B?UkhEZlNmcDRQZ1N4Y1dOdzRjbVArVHkzQUVWdkgydHhhTXNndlNPQXc0VktP?=
 =?utf-8?B?NVNUZG1KOXNTMmtSTEMwc2lRSjJSVzRhTTdrdXN2eFpxSG5IS0p5VnZtMkNa?=
 =?utf-8?B?eHpmSUphZWdYNW5EYmJjSXdmRVdlZWRPOHpoak9tSlJuNysrZWdYeTcrZjB1?=
 =?utf-8?B?UkMxMjBVTDN0Z084UUNYMm5DWHZLZzN5K1R2Lzk2TW5aTXpOQmpVU1hDQ3d5?=
 =?utf-8?B?TkFFb2lPL1czdlRoYkhHa3orcVppbDYrT1h0MThObnNnZy8xZFhGU3JVa2pm?=
 =?utf-8?B?QUFhUkcxUlk5TzZFRENPbTFVN1g2NU13WGtVbzVxd1NNaWZPdzZXWktFUU84?=
 =?utf-8?B?eERPUGw4L3FQaEFYZTJldXpQTmpEK3Vvenp1dUxhcWJoMUlrT2JjYklEc0Vi?=
 =?utf-8?B?TEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0f864e-5798-4b53-e3ae-08dd62c2326f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 06:33:56.7036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z6xi65e85/ppKjRUa82yt6s3pJQG8+r50kE8mGz3/2Mu2txqcv2eAOEPKU20vk5BBR02/a3q75JSBxpOOjAoCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5595
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Mar 2025 06:34:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18203

On 13.03.25 13:35, Claudius Heine wrote:
> Hi,
> 
> here is v5 of my patchset.
> 
> I tested this on Debian bookworm (12).
> 
> This creates a different password for every partition, since that was
> how it was done before, but maybe it would make sense to have the same
> initial password for every partition.
> 
> It might happen that the fallback system needs to continue the
> re-encryption process, and using different password means that the
> fallback system as well as the update system needs to process the
> re-encryptions in the same order.
> 
> What do you think?
> 

Still need to look into the details. In any case, this is post-1.7 material.

Jan

> ---
> Changes in v2:
>  - Added more descriptive commit message
>  - Added more descriptive documentation about noencrypt option
>  - Fixed typos in documentation
>  - removed unecessary setting of /conf/param.conf in initramfs-crypt-hook
>  - added re-encryption recovery patch
> 
> Changes in v3:
>  - Rebase on current next
>  - Extended `noencrypt` documentation
>  - support clevis tokens for re-encryption recovery
> 
> Changes in v4:
>  - improve documentation and commit messages
>  - reorder commits, to put re-encryption recovery up front
>  - extract static temporary encryption key patch into its own
>  - switch from lsblk to blkid
> 
> Changes in v5:
> - Switch to use TPM2 protected password instead of static initial
>   password for encryption
> - Link to v4: https://lore.kernel.org/r/20250305-initramfs-crypt-hook-patches-2-v4-0-4170912e5261@denx.de
> 
> ---
> Claudius Heine (4):
>       initramfs-crypt-hook: store initial encryption key in TPM2
>       initramfs-crypt-hook: add re-encryption recovery
>       initramfs-crypt-hook: implement 'noencrypt' option
>       initramfs-crypt-hook: add 'format-if-empty' feature
> 
>  doc/README.tpm2.encryption.md                      |  25 ++++-
>  .../initramfs-crypt-hook/files/local-top-complete  | 123 +++++++++++++++++++--
>  .../initramfs-crypt-hook_0.7.bb                    |  12 +-
>  3 files changed, 142 insertions(+), 18 deletions(-)
> ---
> base-commit: ddc2f2500b8984aceef9cf4b884e69e52d515567
> change-id: 20250305-initramfs-crypt-hook-patches-2-9cc4a027c89a
> 
> Best regards,


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

