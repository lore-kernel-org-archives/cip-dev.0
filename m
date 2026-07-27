Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352EEC531D0
	for <webhook@archiver.kernel.org>; Mon, 27 Jul 2026 15:31:54 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.61])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.33781.1785166309088651174
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2026 08:31:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=p9PmE0tm;
 spf=pass (domain: siemens.com, ip: 52.101.66.61, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kcCLPa3adpX2iWPG3cbX7ubSrRawt3ysekRygtwZdKSgO5lOUSg9smkr/j7g0tfIsF+wcEJ4foZxxNyeJommNphB2NH3FGio3hIT0Diok3FxqX4ldUDuN2k4+CdZFI9rhaLbfBGUEGXFsUn6XCETEwfr6THrCmPUELTXOxkX1Ezo/wfgYyQRVHrmOrbYUgcia9Du9c0YSr7rEd2WyKsZUEwsk7wMnoBxq/UsiHM509PeNkHcIuXbGxwDBle8DYHxXQbjK41IXivpYXRDvcOw7Ncl5zuzBY0gXIQsBJDpyAketM577Q4Kz+hCliWMMvVy44Au/UiC1UPIq5izGHhJ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnByar3RUB0u0j2+KQsm7phwbB+rnGtHYOxT970Ijg0=;
 b=ajWc4QlDwQd7gKQj0F+gm5VvRgI4T+ygSL3rI/ecyBc08BpahKisK+Znnje4HmEk14l/1E7jc7WKiXBsfADnUOrYCxAYa4/gsNt5i553/NmJfd8dQzNnBVypEJOS30NpPljzfkOX+6v75tcFXWrVcwhl2KhRdQkJLwgHkP0+8jTe/JdfUUf8qzW6MCSS8Mpp8FgsR1LXI2ZOKT2lmIxIC73WPY7JuSuNLX8T8GoehL72A7e9qyafUobhmxzk1q86tGL838e0u1E0sl/Om/RW4NEYY+Onb/aWw24IuYMPS0OOMz8uw6tJeuzlXDbv8mHpwWdM0wnBEvhTc3yjLr7uug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnByar3RUB0u0j2+KQsm7phwbB+rnGtHYOxT970Ijg0=;
 b=p9PmE0tmgxx5/sQ2LzmHsr6CR6x4alWehHpV4GT53Z/R6cd3bHMafnxQRE0hzGQzWv17pV7dd9JKNJCf821JbBQAdeBBETQTkXvqPNVOnT47O3+7zAuIdyBxxidy10YIZfruh6ChJrR0lgOpE/1csdQZCEm4L+/7wLJOw2J7YeRfGXJwV6ZT0r25q5J4Uar4IReNqiJ0ZF0wis0rBRbsHBcqhdqc7kXL5XIq5t0CQGfZRguVj8Fg5xcVeyBgUQPW4msC6veg7mKjNIBl34BAeeH4T2OySIBsHKjrUVO9HYnc5RFrsdjQpT9bJweqa71EV2tYZCuW4GwU8IXIwCZx6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6369.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 15:31:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 15:31:44 +0000
Message-ID: <c47544b0-fa4e-42bb-8be9-57e366bf150f@siemens.com>
Date: Mon, 27 Jul 2026 17:31:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC cip-dev][isar-cip-core][PATCH 03/14] Add cip-cis-rules to
 apply hardening configuration to the system
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com,
 christoph.steiger@siemens.com, clara.kowalsky@siemens.com
References: <20260724124038.3633611-1-Quirin.Gylstorff@siemens.com>
 <20260724124038.3633611-4-Quirin.Gylstorff@siemens.com>
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
In-Reply-To: <20260724124038.3633611-4-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6369:EE_
X-MS-Office365-Filtering-Correlation-Id: f997cc39-cb0f-43ef-edac-08deebf42a34
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|6133799003|4143699003|56012099006|11063799006|10067099003|3023799007|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	0qPnpvlPjYP2Be7XZFslU6bwNseQBG5YdDG7HVR2oSuGuZgMDzjLsOLxdd41xrFXi5jWMi0ht0GiKcJ9SBXkoDLPP8S7FRDNUVlxQZuum67dOuSzrMT+V9SAMt9kOMD9CWc23Jw7on4YMjA/mWj+icOvKLKJX6gGiWzo1ug10CoYNi9AaJURvLXd05Kn0ZlaA3ZvFKdSa7/9oNzjXrQQDOZmWxm76iTC7UKogcZJFjltDaxdFiewiOXK0n3+/Ww55NKmBuMz/wpFgCyMHZaOknc6jfWGikBE2dNJjvCYFXtLc/bjCCxn+Dgk26vE6fsZHwTKcvi8EqHheUu9STV6+xx8Fr1lRYn6WLrsRBH9Rx9XnWObnBLqi4ik821r+pWC/ZtwCQhxxDJquQ87VxHrcdl68NN4iRkBodbWqTqM8rpFBp5+qQipQPw+9zWL/q87DAFbF5efmJbNzJmFoL0lVEkWgU1qIsm6rukiZkE2vfppyLMnyGiIPKemdNwRzvo1BHaNkQJjbBKWGkv9HF+VlLVwjM5bW6NviHXgJEU/W3Zk5x3KyFKfJGGlQmZQI6vDzmltO1VOb+ZOWxdbO7GKhdpKkeQqtjR2PA28VkPB5KXRg3vA2BaRLrtxcLvXXuK3Of5DChcfkXZgHSFGSLnlJF5HkfysJbCdVJ4Ahd0y+dw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(4143699003)(56012099006)(11063799006)(10067099003)(3023799007)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cDhKcGhhaExMaDR4ZXMyaUUwUzRyRnc3eXVndUZSVDN4M2FIb1ZlbFZiOEpt?=
 =?utf-8?B?OGR5Q0h1eDFKdC9TSzhvelQvZ0lhRzBFVVQ1NWJLNHBIQXNRTmhjaXF1WVF3?=
 =?utf-8?B?cWQ0ZnpodXBMRDhES1RSaUgzRTN0eExYemtseDdiZStxVE1lZzBmeW1ScVFF?=
 =?utf-8?B?L1FMeWU0UWFpZ2lLWVJXZGVUeDNnNFljaHlxK3FtR08wY2lqTG1BaVFqZEY0?=
 =?utf-8?B?dU1wUWp1QUtMQUVpOXhoYWdCcXFYNkFCZmtSRHgwZUpyaW5kM3krM1MxMnJM?=
 =?utf-8?B?TmR0OFRJdEN0RUZ2cERTV0lWbkd0ejJOaG5xcjRiZ0lwdlk4dEgyeDM2eVRU?=
 =?utf-8?B?Y1BTMll6OFNiRXFaNDlXUUpXWHR1cE1jMmtJMkJkQWxRNHFRMjgyM2FrMjRV?=
 =?utf-8?B?Q0R5bVVvaWlqZXNNQXNaYTVPTXhOSkpiL2VOL3BrNGkvekdOYmRrQTZSWm5l?=
 =?utf-8?B?MlpxUTN6TndIc1BoQ2tTUER1NW91TjNXSldONUJaemdOSEFWa1BsNVJ3VTBm?=
 =?utf-8?B?MXpJN0x0akxhUklLVUlFaDlYMnlCNWNxQktURS9QTkRudlpUV0QyMEYwQjRO?=
 =?utf-8?B?NFpuRXJNMms5cWdVY0ZpaVdEbE4vZGVTVTBTL21HRUhncFZ3bjNXUEwzbEhR?=
 =?utf-8?B?LytwWXJnSXhHTmM2d0ZaSEx4U0ZhckQzNUs2UG5oUTM2eUc3UUQrWENqSElh?=
 =?utf-8?B?S2hBVGhNaVl3ODhjQ0VKdzRTaUxVeUFaMkpLZ0VyYzBDaTZ1WWNsSnhRZDVx?=
 =?utf-8?B?T2w4eVdkVGJHZmpnekNWdjFjZmxEMmxhelRKWW9SM2ZUY0U2dzdvZmZkWUpG?=
 =?utf-8?B?bU4wNmNEYm93UEplb3ZQYnk0dGlYOVAxUTBYYjRIUTViaUl5dURoVUVaNWZR?=
 =?utf-8?B?Zmdiaytvd1ovb3RBQzVmMGFTRlJNNzdZU2tFMGRqVEZ3QWcrbHdTOENpSDdP?=
 =?utf-8?B?M2dVMU13TVRJYllQNUgydTdKVEQ2bGppeXhTazFlM2F3Wkp0TFVkdkZGWXNS?=
 =?utf-8?B?WXFZVFdMQnNjUGxaRE5rUlZUVUk0aVlHeGRuaVNmK3Z3UFpXM1QyUlpCTFNT?=
 =?utf-8?B?OUloeXphWmZCTXpLS3d0M2VyNzd1V2h1ODFMekN5WTJvYk1rNHVaaUFPT0po?=
 =?utf-8?B?cW9Qcjc3dEU4VW52eEZ2dm1PZXBubFBmRE02T1FhOG9Dc0ZoVmZIaXdEZE5J?=
 =?utf-8?B?azRvSmMxQXN3eFdlRWNnUnk4WnFjTytVZTJhem9SSWVnYVNPRGhDTW5xZUtV?=
 =?utf-8?B?b2dMb255bUtveGpGUlZibnlIUlQzd0dRZ0gvRVU0Ti9wbmxkaGNPRDMxSFpr?=
 =?utf-8?B?ZDREc2greEVRVUtKdkFjOXB4MFJJeWFJZmZBSGxnUFFXSWRNSEtzazRYbm45?=
 =?utf-8?B?UnRpS1pheGFib204RFZza0UwejFxbjlJWXFpNjltQXV3dHlHVWJweVBEaGJD?=
 =?utf-8?B?ZkpRVUVObEI1WVMyZ2RoSFpYbnIzLzdjMjlvbW9oNDJkWWFMbTNGVnVuMXFs?=
 =?utf-8?B?dVdmNjdhOStlV0s3SFVVeGpnNFFBNTBibHdDbVpKRUZESUlEdzhKUnVmeFRy?=
 =?utf-8?B?TnZUK1FGeTl6WHlnaXp5QXFPN0JGcEtDMjF6Si9CNWhkNXIwUVVUakZNTE5h?=
 =?utf-8?B?Zmp5TmsxOENMako5VVJnWGxQRTArK0krdFJNSUFhVXFrVnJsS3JRMWhWdGsz?=
 =?utf-8?B?VHdsRERvYmhYUjNmZFBFTy81YzlvSVgzMm9oQzEydVhQODZQQTI0bTNtL2Zj?=
 =?utf-8?B?RWdyUjUzM1djN2toWTBoVHJsdVRVZm5NM3o5NHVqY3RNSy9vbysxektJdU9r?=
 =?utf-8?B?OTBZRGhWcWM3Z05na2xhbVdZczRaelMzaDVWUEI4K01DWFMzVjNlQ3BqWHNE?=
 =?utf-8?B?Wm1xWXNBbmtpOGRiQ0IvbzZYb3A1M2U4cFQ0Y2lFS2QvbkZjZXhkRndQVW1h?=
 =?utf-8?B?QTI4S1NDV3RBSVY4SWh6dUxxdGcwMTM2OXdyVkZwTWpFSzFOVCtTWExjb1Vj?=
 =?utf-8?B?Z0Q5SUwxeE1SMnIzS1Y3NEs5YllSMHkwWWlVZTVXZ2ZXdFJETjNjZXBOMmtw?=
 =?utf-8?B?VVp1YlhySnc0cnY4TVg4ZEZvSnpaRTJSbDhKaHNpbW9hN0JwS0FVSVZ3MWRQ?=
 =?utf-8?B?RDRSK0xOVU1DTG1PWE1QZjhQS1JRNjN4dnBPN3MwRHpVN255TXF2bElDT3Ey?=
 =?utf-8?B?czN2TGE3WEJHaUJLcjhTNjFqL3k2d3N2L0VUclAxaGVJU1NEVmhud1lzY1JX?=
 =?utf-8?B?NVZrZk9KVDRGUzY3WWZ0SXZVK0llUTNaZEtYbG14bHJRTDQxNVBRL3FWeFQ5?=
 =?utf-8?B?RkhIOEVnVGpIZEdaS1dEd21Relc3c1VtQmlMVGsvem92c0NzSWc0RmNDN093?=
 =?utf-8?Q?lq1lklJlJVxiqcJo=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f997cc39-cb0f-43ef-edac-08deebf42a34
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 15:31:44.7691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8GMm/kAUrGpfzoLpsMEXkji4yLy8ZPARG7CyIjgzSubvKGGx/GxQlapt3hH+kXz9p0y9T4M0X+7nwnMY92O2Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6369
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2026 15:31:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23784

On 24.07.26 14:39, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This package uses the configuration from `cip-cis-rules-config`
> to generate a Debian package containing the selected hardening
> rules.
> 
> Co-Authored-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../cip-cis-rules/cip-cis-rules_1.0.0.bb      |  19 +
>  .../conf.d/cis-2.2.1.3-chrony-ntp-server.conf |   4 +
>  .../cis-5.2.10-disable-root-login.cfg         |   2 +
>  ...2.11-disable-sshd-permitemptypasswords.cfg |   2 +
>  .../cis-5.2.12-disable-sshd-setenv.cfg        |   2 +
>  .../cis-5.2.13-sshd-ciphers.cfg               |   2 +
>  .../cis-5.2.14-ssh-cry-mac.cfg                |   2 +
>  .../cis-5.2.15-ssh-cry-kex.cfg                |   2 +
>  .../cis-5.2.16-sshd-idle-timeout.cfg          |   2 +
>  .../cis-5.2.17-sshd-login-grace-time.cfg      |   2 +
>  .../cis-5.2.18-sshd-limit-access.cfg          |   2 +
>  .../cis-5.2.19-ssh-banner.cfg                 |   2 +
>  .../cis-5.2.20-enable-ssh-pam.cfg             |   2 +
>  ....2.21-disable-ssh-allow-tcp-forwarding.cfg |   2 +
>  .../cis-5.2.22-configure-ssh-max-startups.cfg |   2 +
>  .../cis-5.2.23-limit-ssh-max-sessions.cfg     |   2 +
>  .../cis-5.2.4-sshd-protocol.cfg               |   2 +
>  .../cis-5.2.5-sshd-loglevel.cfg               |   2 +
>  .../cis-5.2.6-disable-x11-forwarding.cfg      |   2 +
>  .../cis-5.2.7-sshd-maxauthtries.cfg           |   2 +
>  .../cis-5.2.8-enable-sshd-ignorerhosts.cfg    |   2 +
>  ...9-disable-sshd-hostbasedauthentication.cfg |   2 +
>  .../cis-5.3.1-enable-pwquality.cfg            |   2 +
>  .../cip-cis-rules/configuration/cis-1.1.21.sh |   6 +
>  .../cip-cis-rules/configuration/cis-1.5.1.sh  |   8 +
>  .../configuration/cis-1.8.1.1.sh              |   7 +
>  .../configuration/cis-1.8.1.2.sh              |   7 +
>  .../configuration/cis-1.8.1.3.sh              |   7 +
>  .../configuration/cis-1.8.1.4.sh              |   8 +
>  .../configuration/cis-1.8.1.5.sh              |   8 +
>  .../configuration/cis-1.8.1.6.sh              |   8 +
>  .../configuration/cis-2.2.1.2.sh              |   9 +
>  .../cip-cis-rules/configuration/cis-4.2.3.sh  |   6 +
>  .../cip-cis-rules/configuration/cis-4.4.sh    |   9 +
>  .../cip-cis-rules/configuration/cis-5.1.2.sh  |   8 +
>  .../cip-cis-rules/configuration/cis-5.1.3.sh  |   8 +
>  .../cip-cis-rules/configuration/cis-5.1.4.sh  |   8 +
>  .../cip-cis-rules/configuration/cis-5.1.5.sh  |   8 +
>  .../cip-cis-rules/configuration/cis-5.1.6.sh  |   8 +
>  .../cip-cis-rules/configuration/cis-5.1.7.sh  |   8 +
>  .../cip-cis-rules/configuration/cis-5.2.1.sh  |   8 +
>  .../cip-cis-rules/configuration/cis-5.2.2.sh  |   6 +
>  .../cip-cis-rules/configuration/cis-5.2.3.sh  |   6 +
>  .../cip-cis-rules/configuration/cis-5.3.2.sh  |  10 +
>  .../cip-cis-rules/configuration/cis-5.3.3.sh  |   7 +
>  .../configuration/cis-5.4.1.1.sh              |  23 ++
>  .../configuration/cis-5.4.1.2.sh              |  17 +
>  .../configuration/cis-5.4.1.3.sh              |  17 +
>  .../cip-cis-rules/configuration/cis-5.5.sh    |  19 +
>  .../cip-cis-rules/configuration/cis-5.6.sh    |   9 +
>  .../debian/cip-cis-rules.postinst             |  30 ++
>  .../files/cip-cis-rules/debian/control        |  31 ++
>  .../files/cip-cis-rules/debian/rules          |  20 ++
>  .../debian/scripts/package-enable-configs.py  | 332 ++++++++++++++++++
>  .../debian/scripts/rule-packages.json         |  61 ++++
>  .../cis-1.1.1.1-disable-freevxfs.conf         |   3 +
>  .../modprobe.d/cis-1.1.1.2-disable-jffs2.conf |   3 +
>  .../modprobe.d/cis-1.1.1.3-disable-hfs.conf   |   3 +
>  .../cis-1.1.1.4-disable-hfsplus.conf          |   3 +
>  .../cis-1.1.1.5-disable-squashfs.conf         |   3 +
>  .../modprobe.d/cis-1.1.1.6-disable-udf.conf   |   3 +
>  .../modprobe.d/cis-1.1.1.7-restrict-fat.conf  |   5 +
>  .../cis-1.1.1.8-disable-cramfs.conf           |   3 +
>  .../cis-1.1.23-disable-usb-storage.conf       |   3 +
>  .../pam-configs/cis-5.3.2-faillock            |   6 +
>  .../pam-configs/cis-5.3.2-faillock_notify     |   9 +
>  .../pam-configs/cis-5.3.3-pwhistory           |   6 +
>  .../pam.d/cis-5.3.4-acc-pam-sha512            |   3 +
>  .../cis-1.6.4-restrict-core-dumps.conf        |   3 +
>  .../cis-5.3.1-enable-pwquality.conf           |   7 +
>  .../cis-5.2.10-disable-root-login.conf        |   3 +
>  ....11-disable-sshd-permitemptypasswords.conf |   3 +
>  .../cis-5.2.12-disable-sshd-setenv.conf       |   3 +
>  .../cis-5.2.13-sshd-ciphers.conf              |   3 +
>  .../sshd_config.d/cis-5.2.14-ssh-cry-mac.conf |   3 +
>  .../sshd_config.d/cis-5.2.15-ssh-cry-kex.conf |   3 +
>  .../cis-5.2.16-sshd-idle-timeout.conf         |   4 +
>  .../cis-5.2.17-sshd-login-grace-time.conf     |   3 +
>  .../cis-5.2.18-sshd-limit-access.conf         |  10 +
>  .../sshd_config.d/cis-5.2.19-ssh-banner.conf  |   3 +
>  .../cis-5.2.20-enable-ssh-pam.conf            |   3 +
>  ...2.21-disable-ssh-allow-tcp-forwarding.conf |   3 +
>  ...cis-5.2.22-configure-ssh-max-startups.conf |   3 +
>  .../cis-5.2.23-limit-ssh-max-sessions.conf    |   3 +
>  .../cis-5.2.4-sshd-protocol.conf              |   3 +
>  .../cis-5.2.5-sshd-loglevel.conf              |   3 +
>  .../cis-5.2.6-disable-x11-forwarding.conf     |   3 +
>  .../cis-5.2.7-sshd-maxauthtries.conf          |   3 +
>  .../cis-5.2.8-enable-sshd-ignorerhosts.conf   |   3 +
>  ...-disable-sshd-hostbasedauthentication.conf |   3 +
>  .../sudoers.d/cis-1.3.2-pty-sudo              |   3 +
>  .../sudoers.d/cis-1.3.3-logfile-sudo          |   3 +
>  ...-1.6.2-enable-randomized-vm-placement.conf |   3 +
>  .../sysctl.d/cis-1.6.4-suid-dumpable.conf     |   3 +
>  .../sysctl.d/cis-3.1.1-disable-ipv6.conf      |   5 +
>  ...s-3.2.1-disable-send-packet-redirects.conf |   4 +
>  .../cis-3.2.2-disable-ip-forwarding.conf      |   4 +
>  ...s-3.3.1-disable-source-routed-packets.conf |   6 +
>  .../cis-3.3.2-disable-icmp-redirect.conf      |   6 +
>  ...is-3.3.3-disable-secure-icmp-redirect.conf |   4 +
>  .../cis-3.3.4-log-martian-packets.conf        |   4 +
>  .../cis-3.3.5-ignore-broadcast-requests.conf  |   3 +
>  ...6-enable-bad-error-message-protection.conf |   3 +
>  ...-3.3.7-enable-source-route-validation.conf |   4 +
>  .../cis-3.3.8-enable-tcp-syn-cookies.conf     |   3 +
>  ...3.9-disable-ipv6-router-advertisement.conf |   4 +
>  106 files changed, 985 insertions(+)
>  create mode 100644 recipes-security/cip-cis-rules/cip-cis-rules_1.0.0.bb
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/chrony/conf.d/cis-2.2.1.3-chrony-ntp-server.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.10-disable-root-login.cfg
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.11-disable-sshd-permitemptypasswords.cfg
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.12-disable-sshd-setenv.cfg
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.13-sshd-ciphers.cfg
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.14-ssh-cry-mac.cfg
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.15-ssh-cry-kex.cfg
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.16-sshd-idle-timeout.cfg
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.17-sshd-login-grace-time.cfg
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.18-sshd-limit-access.cfg
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.19-ssh-banner.cfg
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.20-enable-ssh-pam.cfg
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.21-disable-ssh-allow-tcp-forwarding.cfg
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.22-configure-ssh-max-startups.cfg
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.23-limit-ssh-max-sessions.cfg
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.4-sshd-protocol.cfg
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.5-sshd-loglevel.cfg
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.6-disable-x11-forwarding.cfg
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.7-sshd-maxauthtries.cfg
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.8-enable-sshd-ignorerhosts.cfg
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.9-disable-sshd-hostbasedauthentication.cfg
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.3.1-enable-pwquality.cfg
>  create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-1.1.21.sh
>  create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-1.5.1.sh
>  create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-1.8.1.1.sh
>  create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-1.8.1.2.sh
>  create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-1.8.1.3.sh
>  create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-1.8.1.4.sh
>  create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-1.8.1.5.sh
>  create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-1.8.1.6.sh
>  create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-2.2.1.2.sh
>  create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-4.2.3.sh
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-4.4.sh
>  create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.1.2.sh
>  create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.1.3.sh
>  create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.1.4.sh
>  create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.1.5.sh
>  create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.1.6.sh
>  create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.1.7.sh
>  create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.2.1.sh
>  create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.2.2.sh
>  create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.2.3.sh
>  create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.3.2.sh
>  create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.3.3.sh
>  create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.4.1.1.sh
>  create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.4.1.2.sh
>  create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.4.1.3.sh
>  create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.5.sh
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.6.sh
>  create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/debian/cip-cis-rules.postinst
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/debian/control
>  create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/debian/rules
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/debian/scripts/package-enable-configs.py
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/debian/scripts/rule-packages.json
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.1.1-disable-freevxfs.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.1.2-disable-jffs2.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.1.3-disable-hfs.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.1.4-disable-hfsplus.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.1.5-disable-squashfs.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.1.6-disable-udf.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.1.7-restrict-fat.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.1.8-disable-cramfs.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.23-disable-usb-storage.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/pam-configs/cis-5.3.2-faillock
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/pam-configs/cis-5.3.2-faillock_notify
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/pam-configs/cis-5.3.3-pwhistory
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/pam.d/cis-5.3.4-acc-pam-sha512
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/security/limits.d/cis-1.6.4-restrict-core-dumps.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/security/pwquality.conf.d/cis-5.3.1-enable-pwquality.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.10-disable-root-login.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.11-disable-sshd-permitemptypasswords.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.12-disable-sshd-setenv.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.13-sshd-ciphers.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.14-ssh-cry-mac.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.15-ssh-cry-kex.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.16-sshd-idle-timeout.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.17-sshd-login-grace-time.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.18-sshd-limit-access.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.19-ssh-banner.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.20-enable-ssh-pam.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.21-disable-ssh-allow-tcp-forwarding.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.22-configure-ssh-max-startups.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.23-limit-ssh-max-sessions.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.4-sshd-protocol.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.5-sshd-loglevel.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.6-disable-x11-forwarding.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.7-sshd-maxauthtries.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.8-enable-sshd-ignorerhosts.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.9-disable-sshd-hostbasedauthentication.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sudoers.d/cis-1.3.2-pty-sudo
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sudoers.d/cis-1.3.3-logfile-sudo
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-1.6.2-enable-randomized-vm-placement.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-1.6.4-suid-dumpable.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.1.1-disable-ipv6.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.2.1-disable-send-packet-redirects.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.2.2-disable-ip-forwarding.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.1-disable-source-routed-packets.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.2-disable-icmp-redirect.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.3-disable-secure-icmp-redirect.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.4-log-martian-packets.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.5-ignore-broadcast-requests.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.6-enable-bad-error-message-protection.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.7-enable-source-route-validation.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.8-enable-tcp-syn-cookies.conf
>  create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.9-disable-ipv6-router-advertisement.conf
> 

I just learned offline that this huge set of file artifacts is actually
not necessarily limited to isar-cip-core. That first of all raises the
question if there could also be a useful separate repo for those that
assemble their Debian rootfs without isar-cip-core but would still like
to benefit from them.

The second question is if all of those rules are direct translations
from CIS, and just the filtering of what we implement is CIP-specific.
Or of some may also contain deviations from upstream CIS, and that is
what makes them CIP-specific. In the latter case, those should be marked
/ documented so that they become maintainable.

Oh, and it seems that are no copyright notices on most of the files.
That could make your next "Is this a proper OSS project?" validation
quite stressful [1]. Please check also the rest of the series again,
only released this here.

Jan

[1]
https://lore.kernel.org/cip-dev/42b19801-030b-40ae-b847-8a279a73a0d5@siemens.com/

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

