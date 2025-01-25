Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382A6C02182
	for <webhook@archiver.kernel.org>; Sat, 25 Jan 2025 06:34:14 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.66.48])
 by mx.groups.io with SMTP id smtpd.web10.6046.1737786849748771446
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 22:34:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=yvZ8jGtH;
 spf=pass (domain: siemens.com, ip: 52.101.66.48, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M9fMVg/Qj41tdlsEdbIdQwY0hZlotIBxCcPDfwPJ1fU4y1lCkW9MQgTBlshUPrKE64HxUhvkfOff9HPfSjkEgaalrfSN4qaObIeNT3jmv2URtubzuj153YbKU1JZgEogtCvpbKHNacVvzjj/bOKmfDYaGgh1mm5lMC+9AzMvxR87BPovGPGcLczAZ5NV49ph0huwrBnkHrPxbU4QK0pO6QsyHEjx1ny2QEJeDNmJ7COJB7NJ+U8kCrPs9V8rGdMuTnZaQ4zYl309bjRo6rf/04Onog8RoaLZM5qPNfO2hDYEl/B1LOjC06qrOXw+fGg7M69AJFpTWwPI+dwYfl1kbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lqwnYROkGzHgof+HUoybfsq1TFknCk9LPoAcC+0F6A=;
 b=SZA8fAs519QHzzQFdITLFTWSJ1cwy4EC5yGGqQQsadyfXE6gKD7oPYKLGwU/OQ2vrgElxHF6UKslrzswp/hLS5OpuJi4NZmjf8AK/4qpQWi0rhUKdw2mEbST2qJvmqoGyKd/aKxZOXN0DzLpe6/QtWuhoUjn8YoUe0QiFGP83xcLJJjLAwHB7Mc6kR0JfURQGrD9og4I/DPPPrDK5bwZooOb7ASHxnYyewfR4Zoy9J6pQ5Da7U7RAgfHwouonl5IjdnVKQizpjY0GpNL5pT4lwUrD1V1raGQbqfg/reF4lgJ8vSyS6mrT31ZNbtaIamGwEYa5I28hoR3okGSCb7j4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lqwnYROkGzHgof+HUoybfsq1TFknCk9LPoAcC+0F6A=;
 b=yvZ8jGtHPz/qf5BaLs5kabb29/6TBjtL6KmtwwC1/xOCt9ef8rM8n2KGW9pnWHxaJQS/STn9gPTh3fg/RNfwrQvQW5t9ac0jAqQWZH5bn57v2Tcktl/ICAwMDhM+RzFeMU06suwDaKREPmr6rpv+oFea+BnxVb+8oOtJ0J/PzUKSNsqmiVG7KBSzZE07c5QdrYNFBT0WcdXQGL0tkj6yY3JDklgoj8lJv9Sg4WoNdR58wYOPqumuRDavox+NSmDXixuOp0eDBs8Zs/KOGFfCz9IMOy+0tyOpkx6VL2v7h1/MSyS5zEwW0f05SstNzYqun4b/Ir/U9tmtYs/qXlm2uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8814.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:232::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Sat, 25 Jan
 2025 06:34:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8398.005; Sat, 25 Jan 2025
 06:34:06 +0000
Message-ID: <3f9c2d56-72e5-4ca5-b8e3-2cb9fb5341c2@siemens.com>
Date: Sat, 25 Jan 2025 07:34:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Questions about SLTS v4.19
To: Luca Weiss <luca.weiss@fairphone.com>, cip-dev@lists.cip-project.org
Cc: karsten@fairphone.com
References: <D78HLVUGEZ2B.19ENWIOOSFW5A@fairphone.com>
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
In-Reply-To: <D78HLVUGEZ2B.19ENWIOOSFW5A@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0034.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::27) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: c8cddc6f-4a11-41ae-5351-08dd3d0a4469
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MjNxK2NRZ01xWXVZY1BjaHdTZ1FjS3pKQ0dFZCs3QTVIZXA1TFUwSWk0b2dS?=
 =?utf-8?B?UHN1U3NOTENuT2ZFcVFYNHNrbmhodURrUzBldkEzMU14OWpvU2hzYTRQSHBO?=
 =?utf-8?B?Skx0SVI1RXJwMXVOWkl1Tmg2cmNQZCszZ1NIUzRueXZPczZQdVM0dWZmTkNj?=
 =?utf-8?B?QzQ3UnZ4STh1Z01nT1BUWXhYSUszdjF0YXcxblh5cU13SnBYdXVOSTBBUnZz?=
 =?utf-8?B?ejNQN2hHT0JGRVV2bTZLZ2praTNSbWQyY1ltTXFhT0sxZkpzcWhHc2orSlNP?=
 =?utf-8?B?TkZpRHdyWUNwZ1ZIQkhsc1NNQ0hoV0szaVVBMGtralJXOGExTkhpZWpBRHR2?=
 =?utf-8?B?MkZaRlVDTUhhNEtVYlJHQXp6b1QvbzJoY1BiL3Q1SW9nMFh0VDNWK1BPWDU1?=
 =?utf-8?B?VUlaN01Vb25uUEYwK1RPWVZBcWd6UC9MWXl5aHdibm9zMDU4aC9NR3FBWWYz?=
 =?utf-8?B?SFJzc2hlQmh4R0I1WUtPZVdST2U4c05IckxsYXNwMUl3UlNhbTBndFFxOEE3?=
 =?utf-8?B?ZTk5NHBtMHc4UGhSNFN2WnJUcnc0ZmxPNVlOckptSDRhYklVc29nSjlqejk3?=
 =?utf-8?B?NUVDZkVMT0pJelVZbGlNdW5mL0VCaFJWeWQxcVNGbHBlZyt1VEVmb1NLYW1j?=
 =?utf-8?B?d2N3SllJdTRIZjdoMEZOODBwYVFvbi9HZ3Y1V292cHord3pGbGJaWUxSRGVy?=
 =?utf-8?B?ZldlelE5R3UydFpralVJOE8yaW0xWkVBb3Qvalg3V3RlbWlVUGRFblF0cmNn?=
 =?utf-8?B?d0FOcVo3ekhDL1dNQk5JVFo1OExCeTl2RnZFUll3QThtTlJad1RnYzRkNU5W?=
 =?utf-8?B?cGtYY3JENnlPTjBmeFZlL1JuYTVJeW9heDZpZ0x1MkJaTExINnV5b0dmT25G?=
 =?utf-8?B?L2Rqckcya0QxRE55bWI2eUFsd2JWblZLT0dSUUJVYzlEMGFNa00xSGtnckdL?=
 =?utf-8?B?NForSy9QdFZwYWxmeEdZam03a1lRY3QvRzlMNGp6c0Ryb0F2MzV3a0xVVzAy?=
 =?utf-8?B?OXkvZmIrZzdsby9xVHk4ZzJOdURwWWc2dDVnU08vVU5GUlBnN0dwQTFreEVX?=
 =?utf-8?B?cFdjZGs4bGdjTmpseTRHd0lQd2NYQTVlZ0xQcEFMUXpHNzg5T0Vwb1hoNGZi?=
 =?utf-8?B?UXFtcnhONUwyUEZzaytYdktmLzMraUpjMlJmaXVHK0hla09IWWo1T1p4QzIx?=
 =?utf-8?B?MXFmb3VxYk5NRGpRRDQ3cUFMMkY0bVo1MWdWczFnWlhqTzdMOXRsN3BYb2hX?=
 =?utf-8?B?OWoxZURsZm1zMkRiVVNLTmZ5NzhBd0F4ZEUwS2RKNU9uVWFZUDFzZEhWdEdk?=
 =?utf-8?B?enhkWG5jbXJCTTNXZ1JXWFRnV3Y5K3E2dFMwNDRkTmZkNnRoeUE4elhMbXFp?=
 =?utf-8?B?RzFBbkttSEFHVWxFOGVjT1FQK3VzbEdaeGxHWFpmenhDaGsyL3o1T296SUk2?=
 =?utf-8?B?R1VKMEhXL1l2U0draDlLM1huMU16ZU1iM3VLb3hKZ2RxZUZNMmVQc09HSStC?=
 =?utf-8?B?Z3VmSWRQdFdNenJKdDU4K3BwT25aUTk4K3ZFeWFmQWgwc1hFYlJyZVhNcGx5?=
 =?utf-8?B?bTdMcU5kd1BqcE5MT2d5aG84dXhwTjZIajFvelJtS05PVkdPczZWM20wTENS?=
 =?utf-8?B?TlVjVzhZUE5xL3praWFtQzBLaEY3MURlcFFqQWxERkJFU1VHWGUybmU0NFFZ?=
 =?utf-8?B?eTRuMWRPOU5jY1BKdVRTM2tuTi9xWHBIREZ1czJSUldXbUZOUEJsM21ic3Vl?=
 =?utf-8?B?T0xSRjgzdU5Lb1lDbFVzbGk2MWJObm92SnVOMkMxUno4S2V5K2pMTEo5a1RE?=
 =?utf-8?B?UlQzUUZuNkVUb1JiUFpjdz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ejFocTBtR21NcVdSZEIzaTdUc1JYTit6RXFKaVZtZTZKMmt5TUluWnAvSk94?=
 =?utf-8?B?THRMQksvdkZtNlloZDJ5VkpLckNnNDdJVVh3bVNqdzlBa0N1UW9yRUFzYmFG?=
 =?utf-8?B?bXkySzRSaTVyYUhhRjFxdSsvVGRCNzlsSEUwengya3dlVjZ1NTZRZlFuT1M3?=
 =?utf-8?B?MGRFMWl1YXBiQzV5TXg2RGV4cEJBV1JqSlJ4N2V1YVQzaksyaVdFYjZ4NUlD?=
 =?utf-8?B?dE9VaEtFWkp4c0w1MVl6T3g1anE4L0NIYXFQUndOZDlmTm5TN1U3RGNoNHZY?=
 =?utf-8?B?Z0U1NEZtMlZvZStPUXlZNURUZWplaGRXcXlhRE8wbkxlbWtPMkN3MlJWN2l4?=
 =?utf-8?B?Wno3Qmhid2lZNUEwTEQ0Z05uM3ArS3FkNkd0M0hCZFVOSXBweHBIQzAvQjVC?=
 =?utf-8?B?SWRJWGZRNDBHdzhoaTVrOU1MejljRDlJNHBCMzZjL1d0OU1sMzRDK1VuQm9m?=
 =?utf-8?B?Y0t2ZkpvYUVVYklLN1hINmY3UVFEVHh2TlN1TGRBcWw1SW1TcTZWN2FCS25l?=
 =?utf-8?B?ejIzdDkrRjNkRmpBNEo2OWRiRlNab0lvMFFEclVxMllEbEtTbVNkN2ZIUWQw?=
 =?utf-8?B?UGVLUmc0M2x3M1NmdzMrQ29TL1B1Q2NHeWxwdFNLSkJab1pjakhhZkNTbUNu?=
 =?utf-8?B?cnRlTkExYVVtY0R4TVVSaUxHcUlNSmZ4R2hXTDYvNGYwNXdIQ2hmUVFCMjFo?=
 =?utf-8?B?b09Qa0NPQnNlRktqWHg5TzVuWEg2T3RPb2EvZmpuWFVCMk1WSE9Tc0x2VEEx?=
 =?utf-8?B?RmNqYnB1TDY2VHJTNy9rMDNWeWFIaEI4d3IvS1ZQd1B1eU9EN3JOK0FQMkh1?=
 =?utf-8?B?R2RSYjFIQmVZZFhPZXFFY0tnK2h1OXk0VkowMXFpMnBkQ0xXNGVLdXFLckxU?=
 =?utf-8?B?bEpnK3VSOGJEVzBVUzVJMDg0KzJRcUJuMVBDQXArWDRsTkZHWTR0SnBpd25B?=
 =?utf-8?B?VGdoZ1A5WVlVUkM5cERlUWlwaFBBc3UrUzM1TUJRUHQ0TGIvaHQ0VVJBWm1B?=
 =?utf-8?B?K1U1T1FGOEFFR2ovQ0xsZ0dESGtMbGZxVVFFeU9CNlE3MnY0NXYvS0JqSTlx?=
 =?utf-8?B?M1RrWU02aFcrR1MxRGRkNFpjb1hYSk80aktpbGZVUjR6TGRySHIyeCt6T2RM?=
 =?utf-8?B?ME8yZ25qL3lsWlhMbVYyS2V2cldYc0lDSElQSnZVaGFPd3NIaXFsdU4vdEg1?=
 =?utf-8?B?V3ZWSFZoMHVCckVONFZhbEsvWGZEQXI1dzhremFqWmlwRHJEdXpMRGVKd3hz?=
 =?utf-8?B?SmE0WE03Misrek13SkRDYW1odGxxNmJpS083TElOQ3dtUlpnOGxwTWtyTU5s?=
 =?utf-8?B?N2JteFJYcHhGa3pxNmRKRDdQcFdUc2lZejIrd1k4T3VZM0E5WXlWdjVwcG44?=
 =?utf-8?B?ai9TeGlTL2NkWVE4ZUtwR0FlV2R6bVFvZTEvVHpqRDl2Sm5ETVptQ0dBUmhM?=
 =?utf-8?B?NFpEYkl6TjBGNmJnUHhhTm4zdXhpVlRIWXRzY3ljTE11YjkrYktCRVJxS3Bm?=
 =?utf-8?B?ZEh5K05BcjM3dFk5V3RSTzBEeVNDRzk4T0hWQjEvK2hxajhBMUFyeUZmNS9O?=
 =?utf-8?B?RHJXWnlPT2FlVVNLNFBFR1pSa0l5U29DRnJDZXlWdDl0bjN2M1Y5NjA4dExu?=
 =?utf-8?B?T2VQamJNWHNLaW8wTEhHY1Rha3FISXNnWWlkQXBwU0VsRDlTSHRwaUVYTk5E?=
 =?utf-8?B?aXFFOVUwQTRlZEJxa0JCdTE0L2dHVHA3UXhBdjZrWDBwM3NZTnFLNDB6UnVw?=
 =?utf-8?B?emxLcmIzYlVCcUVyVWZEMkZ3Z3Z3L043NFhHWEE0d2pzMUFtT1NGVWhWdUQy?=
 =?utf-8?B?UkkxN2kwTEZ4VDBCT1dTYnEzdi9ER1MwbTBXRE5hSWFEMHhPTi84U29UTkdT?=
 =?utf-8?B?U2c3L0h5NmF5bFlVNy8zMW5uZkVqQk90end6Rm11cjkyVkZiRHlKTWRhbVpO?=
 =?utf-8?B?cW9zMlZwUGJ0TFBPd3cvOExzTC94M0Vva3F2dWdiVlpVYXVyVFBJeXdWK0hV?=
 =?utf-8?B?SW9UNXc3eU1xOExNa2w3VWNQaXFVSnp1Q1Rnc3lURTBEVDdqaWY5S2hzT2pZ?=
 =?utf-8?B?QjFsWDIyV0JzTVhPZHhjS2Vzc2hoOSs1dnBCdXhoV2t6TWo5OU1RalAvSENu?=
 =?utf-8?B?NWtSWmNmQno4TWVZZWY1TjZ2QWdZMXh2cFducGFDWlowam9JZnY5REY3R2Zz?=
 =?utf-8?B?SVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8cddc6f-4a11-41ae-5351-08dd3d0a4469
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 06:34:06.4782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AG/znetk8GTYs3QQ/8KekkOLShAXPUUm4VkGBWyICNkSKcUcYh5/Y/CeHDDPtDdqVuyk/ZJk7111m1PfkQ/Oeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8814
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 25 Jan 2025 06:34:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17661

Hi Luca,

On 22.01.25 10:16, Luca Weiss wrote:
> Hi,
> 
> I've got some questions regarding the SLTS v4.19 tree which I couldn't
> find an answer to on the website.
> 
> As Fairphone, one of our Android devices, Fairphone 4 is running on a
> 4.19 kernel fork which was provided by Qualcomm. Unfortunately
> linux-stable support has run out and while we're looking into upgrading
> the kernel to a newer version, for now we're stuck with 4.19.
> 
> Since CIP will continue maintaining the 4.19 kernel for the foreseeable
> future, we were thinking about starting to merge the v4.19 CIP releases
> into our tree, and continuing to do that for the foreseable future.
> 
> But it's not clear to me what is actually in scope for the 4.19 branch.
> At
> https://wiki.linuxfoundation.org/civilinfrastructureplatform/cipkernelmaintenance
> I see the text "For the 4.4 branch, the architectures we've committed to
> so far are arm (32-bit) and x86_64." but no info about 4.19, whether
> arm64 will be included, which is what our device is running on.
> 

We started to support arm64 with 4.19, see our reference hardware matrix
[1] and, more importantly, our configs [2] for the various versions.

> And also while we're not a CIP member we'd like to know whether we can
> consider the CIP branches to be reasonably equivalent to the
> linux-stable branches, for example where we can assume that all known
> (security) issues will be getting the fixes backported, or how else it
> might differ from regular LTS.

The CIP kernel is not a direct continuation of the LTS kernel. As we
have limited resources, we focus on configurations and, thus,
subsystems, drivers etc. that our members bring forward as relevant. If
you are lucky, you already have a large overlap with a checked-in config
[3]. If only little is missing, I would still suggest to openly discuss
this with us. The privilege to decide over expanding the support is with
the members, but maybe there is some common interest nevertheless.

Another difference, though no longer relevant for 4.19, is that we
accept non-invasive backports of hardware support that was merged into
mainline, just after a specific CIP kernel series. This helps to bridge
the time between two CIP kernels (usually 2 years apart) while avoiding
ABI breakages via downstream patches when moving to a newer mainline or
CIP kernel with your device.

You should also to have a look at what we just wrote up on the CIP
kernel ecosystem at [4]. Feel free to follow up if you have further
questions.

Best regards,
Jan

[1]
https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting/cipreferencehardware
[2] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config
[3]
https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/tree/master/4.19.y-cip/arm64?ref_type=heads
[4]
https://www.cip-project.org/blog/2025/01/13/kernel-6-12-will-have-10-years-support-via-cip-are-all-your-maintenance-problems-solved

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

