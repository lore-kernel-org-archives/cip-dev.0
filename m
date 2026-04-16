Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C70F8D753
	for <webhook@archiver.kernel.org>; Thu, 16 Apr 2026 15:47:49 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.17])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17848.1776354466924477843
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Apr 2026 08:47:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=n3BUsn/c;
 spf=pass (domain: siemens.com, ip: 52.101.70.17, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o8L6ijVPUwkqkNworBr0Nv1HqTF7khEPn8a0qZMA1SgT1mSZUpezZmLQBzLkAPGtLYByVxXYWiwnDCjHVxdC9s15NMXBskwIGMNcvNCabctH8PXdcqJWf3Y/u00kWapQ/05eQgfNkfVp3xccY9aK0hoXy9/eF1Wg6jelOIvwbk0amHvX9T3OZY0BXZZI60Izg/0NpzSJs/7f91jeeLUPpBNxarWz1q8pn1cnT1Rqa2OEJp2jx89onyUqSP4as9RC26ZveWgrDz83DB0cTgy3Vw5fPfthFRSZ+3beSRK3CYSWdk/wpcD2A2rXJnnpaQtAlE/mLT4Rah6+ZZO5jXda4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92ujmxJ394VxtffRsiqSTtL/+YFGupBiidYKH8CaRoU=;
 b=WoHK8SUfIyP1iclsfIecNcBGRPk1TxnUJRnexBVoZHXPeMeDUbUGsK5RNmFTxP0m0ot4nCMqRcwO4YLnDWA3q1D2BvRKadLufZP7BHLptCmPwCLxnL1A5F0RMkWZONi0fzrM0Oy9chProKi/CzwpZg6dGpaBiT2phelYULKU7+B7h568T2/KO040sZM4Sqv4tBIZ7YjUl8AVjnoKsQZZxks/ZupGEs2dPPfERb2BZuax6niqmsNZ4y/rLaQ3yDjEqXiEg1LvW3wvBmWClM7PSdZf3zT8BAHxPT3azcAEYcyuKxa/4bJX8VRnSTeAptdTHHvwhbnlpzILZ1O1FPHuLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92ujmxJ394VxtffRsiqSTtL/+YFGupBiidYKH8CaRoU=;
 b=n3BUsn/ced8B7DoAlLiNa/PrzNRVtnVwwyyBYuT+434LCGfSWPFdm1VUyzcJvqGgHR16tOn28xTL716YMDrW94fIquVqzY5LEIpOYNt8W35WRsG9e3hnKpPmy+kK4TEY/EZdCWJ5QgLTsXCT6GFb4yYntmWC1Eq6pXssOaotb9lSLekqeYTrvx4nKk7JfE/JNzqrGSRvtSta9VsVmHWgG5HE7OPsMblE3miNtFdbxwjySL5jzm2NQmWKXVEciKB+WmXp0g/WTCeLMmDO56K8bCS9XOxQLeysTJmSh8SJHRYhnu63gKsOJbrEW2nZU1pGNOyHo0knVCpLtUx4wSpAdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB9617.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:63d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 15:47:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 15:47:43 +0000
Message-ID: <a875389c-383d-4f6a-850f-ab40b1d108a2@siemens.com>
Date: Thu, 16 Apr 2026 17:47:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate: Set Debian build
 profile cross only if ISAR_CROSS_COMPILE is active
To: "Moessbauer, Felix (FT RPD CED OES-DE)" <felix.moessbauer@siemens.com>,
 "Gylstorff, Quirin (FT RPD CED OES-DE)" <quirin.gylstorff@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20260416083513.819854-1-Quirin.Gylstorff@siemens.com>
 <5677bfda-ba9a-4c69-8989-071b96cbc1eb@siemens.com>
 <c337c5cb16f6593dad1099972da23a374ccc1495.camel@siemens.com>
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
In-Reply-To: <c337c5cb16f6593dad1099972da23a374ccc1495.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0289.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::24) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB9617:EE_
X-MS-Office365-Filtering-Correlation-Id: 56b8aaa0-140b-4cf5-392a-08de9bcf7f93
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|55112099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	rJ+FLdHbqQaWRz8SNhaS4BoiF2u+gXlhzPuS3oSvqjLE7wizyCHYybucHQmzMDRPV0EdDx+DGP3ZJHm4qGXZe30bMTIe92GBBHzKQXlqjfm2OtBJr7xNYe8XZKHnD3X4xaVBrBTgIJIy8OsrdA/VA5n3JeOCouUZEtNPqFmlkJMxsmiXvfA15BuUug67/Yt08jG0twqcBaHD7qD7P714V9KE7VN3+O5uN36Wi6Jo3VLfk9A/aYmlpV+IGbRlYbvPikQW9JpSp1kZkz97RDv7o+YMrzg+G8ukg2GFXO8qEkxxvaatiFmvQTO6rwejLWRhZUX9G78eKHbSUSG+7XGcl33EwS4mAMv669gYePW6FuEnKq9hTpDGhz9ChcNn0JAjcDzEy4XNYcWlZggkkdC1cGuaIRqZpopu0prBZ0TnoSJHw+//Gkdh+F7GsALeLujySqrPvY7QKODV+koJ7SrD09pmP/Cloq1Se7M8JPXHhZQxqnBHq00itKNxDhLIjUvbntaOZ6KbDp5AGRikWpFH/laYh8zjNwICwy4thW8PW+Qw+CJifrmz8CIjLPEw4KoECm1ah9q6gB9TxJ+4kcLarvrdBVV3ld7kFMp1iWY1oxKABQjq/gsswV6efBBo48lIP59nKPG/bnusoDrUT2KZWc5ahylvWpjoetLA1rng+EMcEZLKYFkkDmiu1zaTFAh97BhxoIkZI5JPbGXQ6BeCKRszzsYSU9ZTpvwiiecuP2zNkXl8jNFRMYT2HmCanfgC
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(55112099003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c0ZyL011YzdWa0pFemV4UG5HMUx0NU5YVS9XYWZ4bmRBMktKZ3FVNzRsOFZ4?=
 =?utf-8?B?L2FpL1diaVBvTkFpRVg5SU50cnI0TzN1QmtYY1dOb1JnV2hrSFdCemVhc1pq?=
 =?utf-8?B?WTZodVlNUmdkb3VuYWpOWTM3UzRWV1VFc1JHQUh6VTRlY29Ca2NjaS9FekhV?=
 =?utf-8?B?b2NJYVVrMm5hbHF3ZHppMDlJZGZGT2Q5eVpic2tzdlloSnZCcmNkZURlNysy?=
 =?utf-8?B?MFFmMDRUWGFwcHBJQjJ5Qm01cGkxOU4vdGFSOEp4RGZldVVENFFHZDJ1QnRF?=
 =?utf-8?B?KzZmRnF0TDlJbnVkVTFJbGFxNFN3bWRGa2tvMFJ5bFRCRjFoSFpINUJwdnkz?=
 =?utf-8?B?QVgyTUVHbDFUOVk4ektYUktHWXpIR2J6RGQ0TmpRSkVsencrV0tkR2JzUElt?=
 =?utf-8?B?YURuQUtRTVBCMHI0T093M1ZWNFBURlFrTks4QWpqRFlPQXhCUnJMcTZxVDhy?=
 =?utf-8?B?MVArZVZxY2hKU1hUU3hGMFRVd3VKK0VrSFlYRmUybDNQRS9lZlVNQkdGNDdn?=
 =?utf-8?B?dU54UGNvVTZsZElVTjFRWkNpcDRlUmdjdWFuZlNBcmZQZkZSTkVCb2QwakVL?=
 =?utf-8?B?cmMyMW0rN3ZVSno3VG4xcTRRdFYzbFNZZldBeUNWRi9HNUJ1dkUxNkwyOFpw?=
 =?utf-8?B?TTFPcDFQdVFyZGV5Vi8zeXk0VS9WWmh5dWxGYmc2d1ljUXdtbHpHRE9obTUz?=
 =?utf-8?B?S29QdlRvdmNWREtIUVpDbHZDajJCb3NYTXd1MTNId1hpcEtCUHRIUXhpVHBW?=
 =?utf-8?B?NUk0QUtWT3dJNmFMMkk1RnNZZWJCWXpGRGtDcUJCb1AwUEh5T1V4Zk5DYWJi?=
 =?utf-8?B?SnVxbXZZUXNRR2t5aXk0RFRXRnVZYzM2M05WRFM5ZlkrNk5ETzgzSnNON01C?=
 =?utf-8?B?YS82cng1TmE1QnBEVGdWOVJHUGYrdmZacFVtMXA0b1VsS1E4Zld4ODVCMFB6?=
 =?utf-8?B?U1p1TDJjeXpZSEdPSmw2aEdDN25sTVB2OHhkTzlGZTNGcHJvRkR3c3llVjdL?=
 =?utf-8?B?UXZDL3JiTzBXUnlVOHNqYzBmY2hXZGkyS1J3aHdJZlNub25pNzVBQ0FtYVdP?=
 =?utf-8?B?NzhMOGJaRzZBd0hWL2YzSWtpVmMwM1hIeVBrd21KMHNycXcxWE1lTHY1OXVW?=
 =?utf-8?B?cy9tbUc2dXdBTi9KbTBQZ3pMbG1VaE1DTExsT1ZHWlYyQjg3TFk3ZEtjNlp0?=
 =?utf-8?B?aElZK0trSHRKWkR6bVdqRmFybDYwcnlXSFpIUE9HdUhzckh3ajRWT2Y3U09H?=
 =?utf-8?B?ZHl2QVNwM1lsZUtXc3RqZHRkV09IZ3BzdjkzQlBteXR5ZlZSMnNibDkrZ2d3?=
 =?utf-8?B?UlZ3eElHS2pKTi9hbmNEZDM3dy8zSWVUdmtxV0VaSHRUYnBxT2U5VHZuWkFK?=
 =?utf-8?B?d3hNa29HM09yMjJWckF0NzJRZG1jRDJOTHVjOERFTFl4MjR6NFdqMGVMOXI5?=
 =?utf-8?B?MlVXSVlHM3hobmpNMDk4QzQ0VUZsbXlFQjNSSDNqdlFQL0RRVWpvVG1KcHRk?=
 =?utf-8?B?ZUJsOHIvSGpTWHoxclB6MU9sOVcrL213aXlkMkRNZ0p5bjhQWmEveXNqUjYr?=
 =?utf-8?B?eGRjWTZydTNNWVhXazRzT3E1dnVZVmdaYnJNc0UvbTlzWTBlQm04QWc1SGQ4?=
 =?utf-8?B?VFowc0pXV0U4RXpyc1FzaTYxd2UrN0NobjdXc2N3SmMxQWd0a0ROWkZEOGE5?=
 =?utf-8?B?OEZvZXlmTGJQNi93VlJ5M1U1cUhlWXdnc2VHcUhGck1NZ2hhYmh3RGtuM1c3?=
 =?utf-8?B?TTFLQTNOekVWQk9URGU2TmNXWEhhVU5iQ2JzZGZUL1U0SVdsZWVhNjdwVkdP?=
 =?utf-8?B?aStaYm5ldUZ4NS9WV3RZV2NGNEI1QURZZitldVE4MzdJZ3BMQkRWeTBIVVpl?=
 =?utf-8?B?TjNBVjkva0NqTCtzczhqRzBqQ3ovWTRVZ08wVHRsVmVKaWlHTGs4RUMrekpQ?=
 =?utf-8?B?T3JZcUFDcjNEUHQwakZmanVsdHFkbE5QZE5VTjZ1dXFIWkRCNDZ1ajEyUVpx?=
 =?utf-8?B?S2tSeWZYU1VuVjZ2TGZ2cG9EeFhQRFU4Wld3WFJlMU5KTUtWZEZXMGhNck1L?=
 =?utf-8?B?ZHMxMWNVTURUcHdISGVjWGRsRTJRdCtkUVd1SE5YSVJGT0orSjFHcllVQUpT?=
 =?utf-8?B?WCt2b2tyZVpRSmd2R2lDQzFwT0lQU0xNWithaEFaODJGcXBtRDFnbVRxVGZR?=
 =?utf-8?B?WnZuNmZKZkVsaWp4MUYyVy8wazZFKzhpdGpWeEJ2TExUcDhYS1dkUzE1VG52?=
 =?utf-8?B?akUvWTRIWjkzWmRRTk9yeTBEODg3S3hJekl6WmZTeWlvZFBtSHVKNjVPQ2hn?=
 =?utf-8?B?dDJZQ0hEcTkxRW1EdzgzakhtK21ieGpPa3JuME9SbjF3aVF5NDdqZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b8aaa0-140b-4cf5-392a-08de9bcf7f93
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 15:47:43.5173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DLVpgi7mDqyEG3lxYuLzY/YGCx9QL6fO4wbkKJZmCsAp085f3QuMrkVAhScEaoq/ZyCQUUO3L/H6djZs/ZE5jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9617
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Apr 2026 15:47:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22748

On 16.04.26 16:44, Moessbauer, Felix (FT RPD CED OES-DE) wrote:
> On Thu, 2026-04-16 at 14:49 +0200, Jan Kiszka via lists.cip-project.org
> wrote:
>> On 16.04.26 10:34, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> This avoids the following error with building bookworm or older in
>>> trixie:
>>>
>>> E: The package cache was built for different architectures: amd64 vs
>>> W: You may want to run apt-get update to correct these problems
>>> E: The package cache file is corrupted
>>> E: apt-get update failed
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>>  recipes-core/swupdate/swupdate.inc        | 4 +++-
>>>  recipes-core/swupdate/swupdate_2023.12.bb | 3 ---
>>>  2 files changed, 3 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/recipes-core/swupdate/swupdate.inc b/recipes-core/swupdate/swupdate.inc
>>> index 497b1c2..59db631 100644
>>> --- a/recipes-core/swupdate/swupdate.inc
>>> +++ b/recipes-core/swupdate/swupdate.inc
>>> @@ -37,8 +37,10 @@ DEPENDS += "${@bb.utils.contains('DEB_BUILD_PROFILES', 'mtd', 'mtd-utils', '', d
>>>  SWU_SIGNED ?= "1"
>>>  DEB_BUILD_PROFILES += "${@'pkg.swupdate.nosigning' if not bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>>>  
>>> +DEB_BUILD_PROFILES += "${@'cross' if bb.utils.to_boolean(d.getVar('ISAR_CROSS_COMPIILE')) else ''}"
>>> +
>>>  # add cross build and deactivate testing for arm based builds
>>> -DEB_BUILD_PROFILES += "cross nocheck"
>>> +DEB_BUILD_PROFILES += "nocheck"
>>>  
>>>  python do_check_bootloader () {
>>>      bootloader = d.getVar("SWUPDATE_BOOTLOADER") or "None"
>>> diff --git a/recipes-core/swupdate/swupdate_2023.12.bb b/recipes-core/swupdate/swupdate_2023.12.bb
>>> index 6822153..89785b6 100644
>>> --- a/recipes-core/swupdate/swupdate_2023.12.bb
>>> +++ b/recipes-core/swupdate/swupdate_2023.12.bb
>>> @@ -39,9 +39,6 @@ DEB_BUILD_PROFILES += "pkg.swupdate.suricattawfx"
>>>  # with cross compile we have a unsat-dependency to dh-nodejs on arm/arm64
>>>  ISAR_CROSS_COMPILE:bullseye = "0"
>>>  
>>> -# add cross build and deactivate testing for arm based builds
>>> -DEB_BUILD_PROFILES += "cross nocheck"
>>> -
>>>  # use backport build profile for bullseye
>>>  DEB_BUILD_PROFILES += "pkg.swupdate.bpo"
>>>  
>>
>> I think we can simply drop "cross" here:
>>
>> https://github.com/ilbers/isar/blob/6504321e85b5fdc3bb5a83f042b77cb39cd11a6f/meta/classes-recipe/dpkg-base.bbclass#L149
> 
> Yes, as already responded by me, drop it. Both isar and sbuild add it
> (which is needed as the variable is consumed in different contexts).
> Drop it :)
> 

Was done in the final version.

>>
>> But good catch! Was already pulling hairs over this weird issue.
> 
> This rings a bell. I fixed the same issue in isar some time ago [1].
> 
> [1]
> https://github.com/ilbers/isar/commit/9d4b11dd6b723764dc5b0a6309f1858546a6d6f2
> 

Yeah, tried to trigger that bell earlier ;). But here we also had that
weird empty second arch, plus it really only surfaces with bookworm apt.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

