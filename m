Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB27C9830E
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 17:29:29 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.16])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3803.1790270968342121356
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 10:29:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=eFyLGo37;
 spf=pass (domain: siemens.com, ip: 52.101.70.16, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HoJd5Uwjsi3dI8X3rjui9+e5U+SqYLlvMBwu1ohpCu2/6+xR9eyiwuCCd5WEWDa5hGRToEnaACoJ7bdohGQP+yj9/n/UwMPC96g0j5i805EwKsZUsoqVDWH0mlW8wDPsQUPZmC5HokoKhItg7cRUYrS2LFmPxp02KtHU7fDeYokwhfcXSexAe/rVwht7ApXTwboxtDJhR5vPv4XBlvrxZ3H6UvYNotPcCVYZ0jj25YO7cwKr6eL3MJyTHs5M1Zj9wEmNWOj7HFDqomUZoJu3rgKAvn8vEDwdxKfmMAUJdIRa7ehfN1RhQG0Xt7Fhjg2wf0G6kvF2wcFaNN3uqZsFvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZS+/I1reAHmkkK9NCibn/MUn+U3hj95dtiMUdGlGf4=;
 b=IdbRK18qYZxGHMHyuZwHJGv5KEiFGTEn4hiZROdBls6Rd4mHFLREVtQp1XX5eiKWlF6KdUPgSBFWYa5uNfslXa4ibRB7O3G4tfzZ4yjxDBJAlG3XGPIjsiaCHl++bonB8vLz/U291GJKQNbh8Q4JGnZaj+O7Z77hCZ7BcK+w+2kpHyDsstLVeRGZ567ups6Zlx/138i8TRCgnLWFzrDpCK3pkiEr6dR1mQFIuMCNJIlrm3jgWPq7vYZxcB6xPMBjkryIgqvNWYnKECScagZhiroTqgozqOwOWFJQwDoWvD8fDcOsEJnLuRWDrs5sHQpoSDCk3MVCvnsBsRdwBU4U+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZS+/I1reAHmkkK9NCibn/MUn+U3hj95dtiMUdGlGf4=;
 b=eFyLGo37elsz7+wqUccvkHSof4lkeInzvQ4syB7qXwbMUloXH42ZOlwApjTL1XVWUYq4yHzZR9a2uSO840icO27Bi4B65BWyGnFgKH3DT+1Ap71x7++VWmlLWp8LSi9eKKpYIy6cMHSLRBI8RjZrNIQJ6pd5h3mPlQYilJzJLOERJkBqms97xOtLH766hmAC4Er3uLImDSJkG5dAjcMZk+C+bKcOWgjoT0vY6xsmjYBy+qIGIcG7h9DUNMVxvhqUNjXSdBFZp6pjRfyQNKrFeidPucjAuZidvWrls+D1Ib815x7a0Eq8jblcOmpdaNmBFTbHY6FAlR3hM/pe92pIhw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8818.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:426::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 17:29:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 17:29:22 +0000
Message-ID: <025b1ab2-1377-441c-8fb3-de47b7816fe2@siemens.com>
Date: Thu, 24 Sep 2026 19:29:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v5 00/13] Add recipes for image
 hardening
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com,
 clara.kowalsky@siemens.com, christoph.steiger@siemens.com,
 Hirotaka Motai <hirotaka.motai@miraclelinux.com>,
 "kumar.dinesh.h95@mail.toshiba" <dinesh.kumar@toshiba-tsip.com>
References: <20260924113557.3191996-1-quirin.gylstorff@siemens.com>
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
In-Reply-To: <20260924113557.3191996-1-quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0437.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8818:EE_
X-MS-Office365-Filtering-Correlation-Id: 33fafc9c-2fea-4aa9-9b63-08df1a615f53
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|56012099006|10067099003|6133799003|3023799007|18002099003|22082099003|20046099003|55112099003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: 
	cVU1R8K1fr6zJChYJnjok9JUoJmmHt2TsYK/GKd1XrLq1nrkzWxSkgoHyStWwbx8aWhqOkjUt7O++IOaUtDkUenEeJTsJEFGR868S0TPF1SOWbCh10TaG2inZnyerjLO+1sxdneaWAdyGsZ7nE4cU+sVg80ZB4j3/KrpAtTyg6uM6nn5wjPpPtYp1L21I7Jf9tTcbSY9iKp3rUFeRyb29sX6D2Q09Q5gUsOIyhKZgxvwKuPK1LQyD9KvVBtHM+ZWWmr2Z/PDFUHk1P0nGe1d0O7ul1hG8aK+6NHyc/VCv5uIDJepTvFfL+fouRiAYKOHTBKeG6U2pXLjYtg2cF3ifXHRTmhvCJYg+twO0qDm18gYidZFV8pFG/Pj4iMM+Xe/x0Ft3Y9QpDQrVkARZtDfOs04yQMRNXIwDQFQ/a+nPuE2riarka9hE8YLD1g46nuq+9ia0Xj0RJIuWbTNQ4lLHmGLxbop9sqWwGgVVTbnl/jkwbS6cmn+SN4OplXuChYkkA3akcA1MkEjKbiUoHTKWQS+6q5Bar0PmLMqwBvsEYbv79bdiXzzALT2XKKmQv7iPAekj5yUeL7NEtZBihsIFUuVyjdZT37MmU2bees7r/B63UOLmjLXC2NFf9Y7Q1NjyFyfdI+rYZ9J+GJwadDWZP7OC9rMGacswnWLpGXgIAc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(20046099003)(55112099003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WVhUVGJjVDdpSGFvM050NG1WeGFJY09vaXZZeHpIbTVOelgvTCs3dXptSVVj?=
 =?utf-8?B?Q3NGTlR6NzlsNysrQ3FjMHJ3SkJQUFdSdE9hWHRjMFlFRkNoR2hPeVhBdXNh?=
 =?utf-8?B?blVaMnduRUFLaDhUZ003SU1OazlLdGYwMlRZZDE3YnZvbVlCQ1pvUmdmWWQ4?=
 =?utf-8?B?cWpDcGNKamx0dUVoT2RGQjR3dGdXUExjbGR4RTdJVEhranJWZmxQOUQvc2xj?=
 =?utf-8?B?cFdPbEdGK2pTKzE1S3dVc2h1dHZXWWw1SGg5WklxWFNtaitqTitkS3ZRN0FB?=
 =?utf-8?B?aU85WkQ2UHNpbjcwR3RqN0NWNTB6QnBMcU05eVIxRSswak1EWHVKZkg4cXRy?=
 =?utf-8?B?bkNQbEZqQ2REMzJoUUI3RGdsUzFuT1B5SUdZRFdEeHFtRFJ2Ly9rRUk1Wmhj?=
 =?utf-8?B?SmZYS25JUkRkbmJwSnV3UWR6NzYzVytSSHJmY1VhQ3ZBb2ZCbkQ5dzVvbnc4?=
 =?utf-8?B?VFNEbjlsRkFhdFRTS1h2TXcwRkxhVVl1YW95cktBQi9EdXBKWVFpRit2VGVL?=
 =?utf-8?B?cm43WHZ1K3RCMW5sNUdpOG15eDEyb2RTZnV6eWdXdWlwb1JzN3hEaHRiSzRs?=
 =?utf-8?B?NElHMGRwSVhsT3lVdElQSE80RlJwTDV5SVNudHVHcVM0THBYQURKSzJBTzM4?=
 =?utf-8?B?RWE2MzZyZG5LcFBrb0tvQS9iTHhsazJpVTRLQnBibm1EdHJnWGU4YmNFa0Rk?=
 =?utf-8?B?N3kvWXlSd0hvTWxVOVBVV0trZXVYNWkvcURqbXdtTHYzQVo1QzR5ODdia2F5?=
 =?utf-8?B?M3ZzYk9RbEpNTW8vNDI3a2Y1RFBuOCt1M1Blem52NHZoOTMrMjhrQ3ZsMDR4?=
 =?utf-8?B?Q2RiS3J5RDdZVXNmTkc4VTIvdTJqNmJZR2t0L1c0d1RoZmhYYUJhQzRxVER0?=
 =?utf-8?B?azdRQzI2emRlcjBPbU5YNjVtY0ZZdmZrNWQ1elRxVnh2WmpyL1hzU3ltemhX?=
 =?utf-8?B?ejJ0ZkcvQXRuRUdLVWlML1BMb096T0dyYzZSRXJCOVBsYzdMcVg3WVZxL3Fy?=
 =?utf-8?B?ZE56bW1uQU9SNnZNRkk4OG1wWlA2ekUvT1RCOGI2YUVYbHo3T3FTQzVOMENm?=
 =?utf-8?B?enBKM0lKc2FZdUFlTXhYaklndE1VMUY4SjJ5cThTN2IvS3M5TW1oN1pPaG1I?=
 =?utf-8?B?NlM3cXJyNHo2UnNrbG1GbnRVa3dkRndtbmRPRUFNVDRycGFob2hHcDlKVHRr?=
 =?utf-8?B?aTJvZzJENGtqejl1S0VUZXVRaUVYVHlyOHdQdmwyaXFabHFRcm1nUkFpb1Rw?=
 =?utf-8?B?QldWaTVvMXh1SXpGdWMzdjVMYVJnMGk3YnUrd1Z3NEZFSFcvV0s1SkQ4YjRJ?=
 =?utf-8?B?bHRnVURkRWR0UUVXbmNsSkx5bVVkQ2FRd29JZGxaYitMcUhJbElYbUlmWTM2?=
 =?utf-8?B?MmFLZFgvVDg3SVg2SkpKdC92L3pnRVBCUDZ6TFhQWENrdFZvUzZ3VXQ5R3py?=
 =?utf-8?B?VHBycDNWaWRDUFVESURuMi9jeU9IZEdKdkU3N2ZlT0QwS0NnZnEzV0VhMXQ1?=
 =?utf-8?B?TEdnWXZvRGwrbW1zMHRHTzdLM3NieTJmNUt3TkdSNmNvaVBrblowaUZiUmVo?=
 =?utf-8?B?a2VNMFBPTzFLWGZjU3gzVGVKZlhVN2tVQ1BDNGZZVDBlNU5md1VSWXNzMGpN?=
 =?utf-8?B?SWExeVB5YVhBOTFFNGdRVmNVcHl3Y01UeExNeFNEM2IrVXJ0MUZoMm9QazBk?=
 =?utf-8?B?OGdaM0prRWxaMzVDUDdRMkUvQ2NKdUVLakwwOEJpWjNwNk1zNmJxQUVWbTdz?=
 =?utf-8?B?YkhqcUJxNFBFUnRuZ3lKc1F1c0diZk1jbEk3U25WNCtOOXFYS2tuTkdvK0tQ?=
 =?utf-8?B?dU41NFVxNzN2aVdBNWZ3dXBFTzk1VFEzRjcxd2FTQ0hianRkSjNrczRzbkE4?=
 =?utf-8?B?K3dibkdkZTVwVUZyR1I0cFgyS2lnaHRCQlphTUFoRm4yekJEZzFYbkpOOStF?=
 =?utf-8?B?SnZaa1ZHb2EzVnFtNzlKNE9Ub1VuZEEyZWxwLy9BMjQrT2JsZzNuRldOdHI2?=
 =?utf-8?B?ZXNkMnZlR1hQcTdGU0dCN1V3NHZrcHYvUk9KcWg5S0h3YXVaMHkyU0srdDJ2?=
 =?utf-8?B?NEdVaCs5ZWRsVGxiWXdSU0Jqa010RklXOEx5WUdnWVJ0b0dTbzE3VWxQc01O?=
 =?utf-8?B?UW5FYzJDT1VTNmVPb1JWcGVoNTJzT0xmZUo0RnNpZHB2bS9KbUlZS0xPampm?=
 =?utf-8?B?ZVVydUxmMGR5cFFnMFlDSWg1bmdjQ3puVno4a3dNMDBUZ1lLa2pJbGg3anRn?=
 =?utf-8?B?SHhaelhHU1pydVFIL2VFUlhkQTNlMmpkSzY1QndjTWI1amgzNk95ZmlINXpa?=
 =?utf-8?B?MjNQYXkrK3lGdDViMERnSWJTbGtXVmw0amMvb2NON3NiMmJoVkpWUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33fafc9c-2fea-4aa9-9b63-08df1a615f53
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 17:29:22.4886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qDe3Ft5JvkkNz01jyhyPsygjrRWnUapJqgYooya+miT7jZ1+dCAIHPNSg/R3JkNyiZrh2TcCZzxy+iKfyhsl0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8818
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 17:29:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24341

On 24.09.26 13:35, Quirin Gylstorff wrote:
> This patch series adds the option to harden the build image according to
> the guidelines published by CIS. The patch introduces the following packages:
> 
> cip-cis-rules-config: user-facing configuration, stored in .config.json and
> configurable interactively via Kconfig.
> 
> cip-cis-rules: uses the configuration from cip-cis-rules-config to generate
> a custom Debian package containing the necessary hardening configuration.
> 
> cis-validation: an optional package to validate the hardening rules.
> 
> Additionally, the kernel configuration is checked against the hardening rules.
> This patch set is currently developed and tested for hardening level 2.
> 
> Changes v5:
>     - rebase onto commit 75c3ed7cfebf8ec5c79329abaeb7a9a50ca546b1
> Changes v4:
>  - rebase onto commit 6ced51c2993421738c86838832fcf37b9b2076f3
>  - Remove redundant addtask for prepare_build
>  - Switch cis-validation.service Type from oneshot to exec
>  - move validation to kernel recipe to avoid issues with kernel config not
>    being available during rootfs install or validation of a upstream kernel
> 
> Changes v3:
>  - switch cip-cis-rules-config to dpkg instead of dpkg-raw as it allows
>    better task dependency management
>  - remove json schemata validation during menuconfig read to avoid a
>    issue were outdated config cannot be updated.
> 
> Changes v2:
> 
> - rebased onto commit 73d8558efc2fb49436aafac36126564c6a725565
> - reorder patches
>   - README is now first to explain architecture
>   - layer.conf before arming
>   - kernel and image are armed together
> - use external repo for cip-cis-rules https://gitlab.com/cip-playground/cip-cis-rules
> - menuconfig now uses devshell to be independent from kas environment
> - generate config.json and kconfig on the fly
> - bugfixes
> - rename cip-cis-validation to cis-validation
> - remove CIP_ prefix from variables
> - rework readme
> 
> 
> Clara Kowalsky (2):
>   Add cis-validation to validate the hardening based on the CIS rules
>   Add kas file for hardening configuration
> 
> Quirin Gylstorff (11):
>   Add doc/README.cis-hardening.md
>   Add cip-cis-rules to apply hardening configuration to the system
>   Add github.com/ovh/debian-cis for the hardening validation
>   layer.conf: use variables to control path of hardening config
>   Add cip-cis-rules-config to configure the hardening according to CIS
>   Apply hardening configuration to the kernel
>   Add class for validating the CIS options in the kernel config
>   Add class cis-hardening for post rootfs generation fixups
>   Integrate cis-hardening into cip-core-image
>   Integrate kernel validation into linux-cip
>   Kconfig: add option to enable CIS hardening
> 
>  Kconfig                                       |  13 +
>  README.md                                     |   1 +
>  classes-recipe/cis-hardening.bbclass          |  52 ++
>  .../cis-kernel-hardening-validation.bbclass   | 260 ++++++++
>  conf/layer.conf                               |   4 +
>  doc/README.cis-hardening.md                   | 283 ++++++++
>  kas/opt/cis-hardening.yml                     |  19 +
>  recipes-core/images/cip-core-image.inc        |   3 +
>  recipes-kernel/linux/kernel-hardening.inc     |  18 +
>  recipes-kernel/linux/linux-cip-common.inc     |   1 +
>  .../cip-cis-rules-config.bb                   | 157 +++++
>  .../cip-cis-rules-config/files/postinst       |  31 +
>  .../cip-cis-rules-config/files/rules.tmpl     |  19 +
>  .../files/scripts/cis-hardening-to-kconfig.py | 350 ++++++++++
>  .../files/scripts/config.schema.json          | 124 ++++
>  .../files/scripts/enable-cis-rules.py         | 333 ++++++++++
>  .../files/scripts/gen-kernel-config.py        | 165 +++++
>  .../files/scripts/select-hardenings.py        | 616 ++++++++++++++++++
>  .../cip-cis-rules/cip-cis-rules_1.0.0.bb      |  23 +
>  .../cis-hardening/cis-hardening_4.1-6.bb      |  17 +
>  .../cis-validation/cis-validation_1.0.bb      |  52 ++
>  .../files/cis-validation.service              |  11 +
>  .../cis-validation/files/cis-validation.tmpl  |  65 ++
>  .../files/generate-overrides.py               | 103 +++
>  .../cis-validation/files/postinst             |  52 ++
>  25 files changed, 2772 insertions(+)
>  create mode 100644 classes-recipe/cis-hardening.bbclass
>  create mode 100644 classes-recipe/cis-kernel-hardening-validation.bbclass
>  create mode 100644 doc/README.cis-hardening.md
>  create mode 100644 kas/opt/cis-hardening.yml
>  create mode 100644 recipes-kernel/linux/kernel-hardening.inc
>  create mode 100644 recipes-security/cip-cis-rules-config/cip-cis-rules-config.bb
>  create mode 100644 recipes-security/cip-cis-rules-config/files/postinst
>  create mode 100644 recipes-security/cip-cis-rules-config/files/rules.tmpl
>  create mode 100755 recipes-security/cip-cis-rules-config/files/scripts/cis-hardening-to-kconfig.py
>  create mode 100644 recipes-security/cip-cis-rules-config/files/scripts/config.schema.json
>  create mode 100644 recipes-security/cip-cis-rules-config/files/scripts/enable-cis-rules.py
>  create mode 100755 recipes-security/cip-cis-rules-config/files/scripts/gen-kernel-config.py
>  create mode 100755 recipes-security/cip-cis-rules-config/files/scripts/select-hardenings.py
>  create mode 100644 recipes-security/cip-cis-rules/cip-cis-rules_1.0.0.bb
>  create mode 100644 recipes-security/cis-hardening/cis-hardening_4.1-6.bb
>  create mode 100644 recipes-security/cis-validation/cis-validation_1.0.bb
>  create mode 100644 recipes-security/cis-validation/files/cis-validation.service
>  create mode 100644 recipes-security/cis-validation/files/cis-validation.tmpl
>  create mode 100755 recipes-security/cis-validation/files/generate-overrides.py
>  create mode 100644 recipes-security/cis-validation/files/postinst
> 

As usual, one thing is always forgotten: I didn't ask for CI coverage so
far, and it looks like this has none, right?

Other than that, this looks technically OK to me now.

But before merging this feature into isar-cip-core: What will this imply
towards users regarding future maintenance? Right now, it is constrained
to Debian 13 due to the availability of rules. So, this version would be
the minimal one to maintain, at least as long as we maintain trixie.
Does this / should this imply support for forky as well once that is
released? Has this been discussed already in the Security WG or the Core
WG (don't recall for the latter)?

We can - and probably should - make this a topic for Prague as well. But
then it very likely be a feature for the next-but-one isar-cip-core release.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

