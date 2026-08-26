Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44F0C5DF97
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 14:06:19 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.36])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13399.1787753174880792483
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2026 07:06:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=fVfTypMR;
 spf=pass (domain: siemens.com, ip: 52.101.70.36, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gMsHORMYIU99ikycMDb7XlhW0dH5MCNtlP3LuV8Z6bWrNunqsL/OBRN9/BbC1/8LvO+gi/TEnqrSatHOHvftTOPNzXoCIi1HA/e/dE9PQaw2LlCpCo1mFHbJytMxiPkTMa9kjjA7aO+JJrFui2aCVwn3YZDuoKZZdhBYe1kihWJmLa52JJ9NG/o8K+4RTMo1CCCMvSmrHlbt+uWQUH8R+640SYWUv3HdmBANzz+qMGUlotRYDZ++Q/UBq10fxSOlhbNOEVdlDehh02L40GsrQTFXSyO9i0g0mD3Gg6y4s2ggV1/pRcrcaD/A+ivcyNDDv4fimNDklJp3t55pCtlaaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AD5phtA4gaRXX4icWdqhb5l7MQ/H9dRkOg//Cd0LXkg=;
 b=YD7kds0lV3/9PtvslzvdnczrE+50z4/YhEvvUkfJDVZlMz8FV2eEIgRzlWPFn4HwtcPXYvURx3kJLUqNk6H8VDUB+jrO3LhoO0Wtj61lapZ0s8gMch2ZQEM2JI5hKL6N3jgH1odmnks5Ev/ynx7a1b8Fnk/fvRzZzN+AdjkluMhpDm84QWyJHJfhlx0QBn6ubGVVRDJEXuUr5ZYTn2NdxsOVWier53iu9uB6nAtXDlxS7FT725pYDxpuClCq6UEwFEF9JAw0Fis57idndhm1kBzkCIdyWzTxd/nWJXva2YWcvIy4hHOQBt6SdtR/ah0eZ6wYkwEqmndIcIINW5scfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AD5phtA4gaRXX4icWdqhb5l7MQ/H9dRkOg//Cd0LXkg=;
 b=fVfTypMR+KI+FvxPqDbPJkJwDXnFhpfYRZWVDcPjt06sz6oblQLWFmsZq08pg0l0iWv820U5An0yeknXw1g748RWH2A3NrQJ/Eh1Oq35liUOpsKlIT/Ko1dFyUshQXjV7FGei1SYW+Y5FFmQw8/EXbwL0TCNQ4qWEX/OtdMbB1BKX1+2PBmS75szrWofWkbLx99J2C3rlJQgMYZiE3LofNhon3d2R3PNKVHPiRQiGIBuxNXTcAr8GRfuy4d2p8tLZvvoAwKPUdjQ1BEFYuHuAdFJchMBC9QfsDxnmpWxKrrw/EB4ln7xHg05Amej2AyVYDdk9Kwz0VYxKxlcJwlm5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB3PR10MB6881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:43a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 14:06:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 14:06:08 +0000
Message-ID: <7301aaf8-9369-4850-bbbf-c83aeacc23e6@siemens.com>
Date: Wed, 26 Aug 2026 16:06:08 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
To: Chris Paterson <Chris.Paterson2@renesas.com>,
 cip-dev <cip-dev@lists.cip-project.org>
Subject: Upgrading QEMU in our lava containers
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
X-ClientProxiedBy: FR4P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB3PR10MB6881:EE_
X-MS-Office365-Filtering-Correlation-Id: fdb9b6df-210b-4148-eeeb-08df037b2d54
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|56012099006|10067099003|11063799006|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	8IFWf96o5xOkFDkQJNu6gG8tS4szz925FwrDDFj3uF0SyfqJ6vZEKWBUbLL++rfp1V9X9AM7AnCCBeUCfdiARDMnnVbfosUkfEZGzvhKlQuOsZMADt5NjPJEEhR+7Ls90CyTrNOWXufhpQwh07OPrb9H6m3Ny/qH9E+PvgJg0j1f9mZo4vYSH7n/iomo441a2LO6onhapgIbT1P2t137yZAA9hRHFdgBYndY5zFUhB4MXkr7zmAMoo6HMjzqMeKcunfX9XSEazmaMfZucd6j5LWYWhp8e3gk8MYXuWXLA2SodnBWE2m006ED8keyeMVPtWHIqxqpTeVcMpER7AjCPNUdHDPpQWYQd0Z2cVPtQ9LUy7t/JYZSFI/8ZsD3chb34F8zCx1aX7wA8yW5iNaQZk0XAoSTK7VBmRBjsUWTW/C1tGf3O6kVMp8DL+uZklYwpuzcsNRnbvbg1gVvBr0PLy8CjQaya4N4lnTamhg/YUv/vVRvet7AcUT65116SjSeGPuPB6xq0ARpYB6aD3TaX5+4nWgGDYWSicVW7dEUjJcRqejjyYGDWreaRMe3INhXFPKiR97S308Aipz3SW3YksTbj20tYTuz2xal/aHGRBEK8kqR3Z86NAe73lf88uzn4ODmXE+XyhuyazpUXV8ly6iMh7jHkLe3Qanuxs++8yQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(56012099006)(10067099003)(11063799006)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?REhQcGUyMzd6TFRabWF0QmZmSDh3R1FsQ3RQdzFCb2VSNFBzWTIvUHA1RmQ2?=
 =?utf-8?B?aEtFbThzaHhhcG9IWWJCRWY1a0d1bEhWRDBpbFRyWWVYTHNvQmxVR2JVQXVC?=
 =?utf-8?B?L2Z6NlVjQTl0NUVRYWxQN1ZvZWcxZktlYzdjaFRxTzF6cVZ6ZnluMjZmZlZz?=
 =?utf-8?B?cVdvViszUHJEZ1JBcTBJNWhNUmpjMVpLbXMvZnprdno3aUhzMHJBNGZ6aEFI?=
 =?utf-8?B?aVZQTWRFTGFDclZjM3l6dzF1MmtJNGRWNTFBKzR4eXVZSXFaVnFHcEU1RHpQ?=
 =?utf-8?B?TlVmTlJtSzRhSzN3VE5STmllT2VzMUx3cndZNzI0cWU3THpLMzFuWHNtQ2xR?=
 =?utf-8?B?SldLWVNrRHlGVmxEZjlMVjNBT3l6T0VmaW5rNHAxbjdwaGp2R2R2amNHd2s4?=
 =?utf-8?B?SmI4Tng3eDZ3WjNkSXZSeDJDSFRLdjIxZHc2RzYyV3ZvUGVQMmV4SE1yYStx?=
 =?utf-8?B?TUxyQUpEWllZZHVkY2hBMHViNENwUG1KVlBBVjB1WFBpNDdpN2NLWHJPM2tU?=
 =?utf-8?B?SWRCN1hnNG1QZ0N1S2RTbkpnSGlxQmpSSFZsQXlmbDNLa3lLVDFRVVVpVWk4?=
 =?utf-8?B?b3c0UGludTA0M2pUYVVrS2pHUENZWmVWMDVqMWVjamgxSWNublFPSUswN0lP?=
 =?utf-8?B?WU55V2kvVVd2TFRhN3htRjJjWm9NcWRzcjMxZHI2NlJRSlNnb1IzWG8ydllt?=
 =?utf-8?B?NEIzTG1aVTBqSHlBMXlTZXJPMGdtbnpoYW5henFtSTBUQkZGRWtSTTlDd3Vr?=
 =?utf-8?B?YTNOY1JzdWlyQXpDd3dXNUw1QmlLTW5YUEpvbHhQaHc5SkZUNitZd0ZUR3Mx?=
 =?utf-8?B?RWZGTXNQb3NhTi9VWjBQbXJRQU10UGJpTmpVU2F6UzM2THdiaTE4ck9EV1Bu?=
 =?utf-8?B?QkpyZGpoTVNheXJ6ZVdvL1hLVWFhWlYzL2VhdTE0d0lVL0RPZklrdWdlaFVD?=
 =?utf-8?B?d2Zkblc2c29xREs5aW1BN3VvQ2FYTENwY3ZkK0NXVXNLNGhvVjdwVXF2ZkVC?=
 =?utf-8?B?clZNRWRWbDdlUzg3MnhQbzVjRGpCbUZtTkRVSmRuSmNHa082TSsyTXNxTzNI?=
 =?utf-8?B?YVJ1WTltQXNCNVFVRjFFL2JlLzQ0V3hDMWFGR05ORWNyZmFOV3R1dzRFRDlr?=
 =?utf-8?B?NDl4VS9tUDF5d1VUNElmb3dmdTZkellCZGkxVWRpS2dUZXhLZlZ1V3dCbWFN?=
 =?utf-8?B?cUtYeXhnNHg2ZVVhNGVacHBnK1lIaDM1czh6TXIwREphU0JmMzBvM2JhTm56?=
 =?utf-8?B?aGNkYklZSFRYbFFVY01XTmJwUy90NTVQWjUvVnYvOHJqN3FqcEJkdFdZcWRa?=
 =?utf-8?B?cGZxR3ZicERPR2M0d0ovS0pSSUxxSUFtdGRRa3YzOXY0ZGp4RG5MUDd2c2lG?=
 =?utf-8?B?Wnh2Zm9wQ0ptaFFibGJ2MkFxRnJyNUpRdjdNTEI2WHNTUWNVSWJQRlZXaG4x?=
 =?utf-8?B?ckNXYzhiVUNIT3IrSzlLWVoyWkJCcEdHSDdQM2l0Sit3QjFCWW1rMmNuNHZI?=
 =?utf-8?B?L2orZEQ5bDk3eDlPWjJ4YWMraDBZK2xya0hsZHREQ3E1Vnp2d2N3MVczMU1F?=
 =?utf-8?B?elFpOFEvN3NVN09yYnIrR2hCSUFOMTJEQlU0UE1pN2ZaYzJndXNGWkFvOE02?=
 =?utf-8?B?K2w0R1hKVnFjRXBJMmJMWlY1RTh0aVp3K0RVVXMvVDRkZVBubXRneFdMRjR3?=
 =?utf-8?B?bjZ2RWZQMVh0dExWdmkxOTkzYWtUNXI0TVlYWVVjbVJyTnBxODJuRDNUY0xQ?=
 =?utf-8?B?UGhpdDdkc25BSk0zYlJNejJOQ3crOThmWWVWTDJiU1VlMUxnQ2VBSXhnU0Fv?=
 =?utf-8?B?RWFhVUsyL2VBUm5nZVdwZk1RT3dBMVQ0YUlSRnpkb2NiY3RJZGJHMGNCbjNZ?=
 =?utf-8?B?UGVVcVVUcUljYWRaNlBMVHUxSmNOeG8rNGZpQnRaNEZYYzNwRmN6SU8rd3Y3?=
 =?utf-8?B?VTJBZm9vZEV2MVRmNlhLaDU4Y3JZMU5zY2RkRzY5OHZkSGVGWjdNT2lMaEE4?=
 =?utf-8?B?c3ZpTm1SQnRWeERFYUdWNDU1aS9Bc2t0a0M5aDB4K2xzMEswcXNIem1BVmZi?=
 =?utf-8?B?YWtvdkYzcEdVT1dlUW1YRG9ZeXA4WVk1VjdjZDBGNFBKTkJ2Qm5Hd0RKQmcr?=
 =?utf-8?B?ZlFrNmhsLzdDUm5GMjgzWmorSWFYRE51bDgrVkpHZmpSd0o1dXJQVUo2L3Nn?=
 =?utf-8?B?T0lWZDBCQlJzNHJPM0JHMVhqUURoRnpEVFdTV0NhMGdYWHYxSytMTXVVMGJn?=
 =?utf-8?B?cmZzajBpWW9zdGZxcmZTNmtqMk1CZWU5UXZBY25MQXZpQ0lOUHdKeENiVWJv?=
 =?utf-8?B?d28wZG1IOHBpdSt5U3ZFcHdUbTFuN0ljUmgyS2w4SjBWdmtpWGNlUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb9b6df-210b-4148-eeeb-08df037b2d54
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 14:06:08.7642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HkxpPmWrC7Mo7mlsA+tx5LqpxGejwRn/1WtspQfxJJtb2fKg/K2Nj5UDs4O/qAkyTgRL2BmJZd4IkmVRxLGgMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR10MB6881
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Aug 2026 14:06:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24022

Hi Chris and all,

how complex would it be to get our lava workers equipped with a newer
QEMU? My usual suspect to ask just left for vacation :).

Namely, we would need >=10.2.0, and if I look at trixie-backports, we
could even get 11.0.x [1] which works nicely locally. Background is that
I would like to enable full secure boot / disk encryption testing on
qemu-arm64 for isar-cip-core CI. But that requires a qemu update to get
RPMB emulation.

Jan

[1] https://packages.debian.org/trixie-backports/qemu-system

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


