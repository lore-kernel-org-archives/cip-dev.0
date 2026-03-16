Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6330F013D5
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 08:47:25 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.46467.1773650838509233983
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Mar 2026 01:47:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kQ2YMbeb;
 spf=pass (domain: siemens.com, ip: 52.101.70.47, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQ1EXnm1DQMeBz//S4kbm0Ebc/qjDX6s7NXVRDGITK2RJyf4nUJ/kkh2ZtKpIXaphj6JENamK4bOVjC9vMNsO7fgmkDFaxykJLOiUJfSVmM7RPjo7rCCG1iDNOiwZQy6yjmfFvwtmt7PA8WQ0ChzTdUCjlyg8GeaqEdSJ38+F9tjVHEuv3g9/6MnCb2EhPuMN3MTthaGMHuy1yiHDZBiduX/sy2gtf5pmzIaq8gJcEcWhfsUAqWPV1KUxIQyERmjAN3guQ4Vy+AtxxzmrD2J15Wg05Py3FiA/In4Vs6+bIBo48QhPjP6qwMRQ7lm5dzqE8HF5o7uZVdwkrc9fPrRLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwGyLt7jbxuWDwVIy8/dCzIEcMgCvWxCIJRSe+3QesY=;
 b=KTCA0ZFj0Uu6H0vhgEb1P3PVXMF66oxOitYSmDcvWHHvvCtTEMK+W4QnQRbUV9szD212tVfSmTTrPCUdsUy82p8QJnlru01cj+kkI1LhTFPDLXqmK2ezTiD8cJas74bteGGWmnJex4ZIkAAXlSX0Bvpe4rA7tpp1spToX27H8WJEE6f5XaLqrWWR/mqBbNlp8igAuTOIKo266hQYqS6l7j1XjRdWPHeV7ZE+m3IKdOwHocUbYnQQWktgeaj7vbquuuq1GLkKvGdINrJSsa+zSDtZcBdXEfWNPFOF4n0bt8AVl2AUKh7RUKfnst/ghz5vxbSXKsAy6lM8X++cNeCP3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwGyLt7jbxuWDwVIy8/dCzIEcMgCvWxCIJRSe+3QesY=;
 b=kQ2YMbebxUZcj0fKE7nPTMdwTWEaUhmQUeovDrAORUqZTSzodbyrKjhf+ZMajkH+9XaJ/Egz4sy4nAY3r+uO4ncNS4A4ES7rq9/RzIofIsrtLFB6a0g3hjJaGUn6ASPnLvDWonB+jbILjd90pnO0yY+mXONzWuFiXLAFMH+9/twne+SXnAUm0oxEl9AMl/OlKbZF48zJOLPo5gkf/fPvtv2YdwcM1q01oRmzP0g0jhnCwzxcEk8HCUr65kLe57W8VoQHzma4uD1fwnu+/RrXQk0CEuVQckU61jFHIr8tVaeTxndhvB06cA3rNVJ92SpDbTagIyI5EF9/WvPQ5aN+Kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8476.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:445::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Mon, 16 Mar
 2026 08:47:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 08:47:12 +0000
Message-ID: <ff1b96aa-44e2-408c-85cf-abae3ae9593e@siemens.com>
Date: Mon, 16 Mar 2026 09:47:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/tests: Add SPDX-License-Identifier MIT header
To: Kamlesh Gurudasani <kamlesh@ti.com>, dinesh.kumar@toshiba-tsip.com,
 cip-dev@lists.cip-project.org, pavel@denx.de
References: <20260316-license-v1-1-5bb039f50c05@ti.com>
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
In-Reply-To: <20260316-license-v1-1-5bb039f50c05@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8476:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b84d3e9-816c-4939-5207-08de83389daf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|55112099003|56012099003|18002099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: 
	i8N7IUwhLCM7i7KlgCXzhwD0gT/n0gou33avKd58f5+09mvSCeGJ71Hx+CmVj9rbCaPT2bY8yus+u2e5wmPuMPD4qC61hw0T4agOZXWNBMIv+M43fmndbQNni/nwcEFDCapdIB12VXWG4se4UdXfa4syFrcP3sEyXiyg/BEMMuXZfZ1FeswZF5lFSkJV4ESVtNzGB3qwmhCXZLkfuLI+N/wMTyT8E7XO2PeQMoJu22FPuGoCNXzqBNSsz5xrYSDez7jBN74xS086nYLsMVZl+aRslEy65cc12RPGRyWnJehuWngVkAv5EodsyY/NUZTv0KiguQdGZ9+n3dpDnfbp2UycZ4s8gkYV+SiO3zk9UX8XPzP7bYhRb5aJp9w740AVrcdRCt0LAwS1uEeRrbvj+d6xdQsAymGJWZhwXKsNVYkmqhM3C6bviU3uPA6+k2Zt+ud2TfwLEAU9EQkZyurJWB8AqUc4TsqAICca9aUzBk+SpbEXIcTP9KG8caIzBL0H0yerbnNaFEkLXT0aXFWPB7VCrbYcTZ9acE67srcHB5mZq0k8kCty0w1JjBF7voeHH30g2apYb1lnVKp+UEq1Kd2iChZi02uR/q6Fzz4mpTzqhkjmYqipK1dWk9swr7fdQ3mZeq8ceszx0/Pv9LROVmE3Vv2u5TyRiPoIeFl+Mt+cijTLOKXd0KIqpW6Nb/1DX9pfp0gm/ywo4p7xEX8iBgSic4a8EQhk8oK7PozvIPk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(55112099003)(56012099003)(18002099003)(22082099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YUJhSTAyNUhZN2RhL0I2YTVFNGV3NHBXRVk2Q28vWnE5TmxUbUJGWlBueTAy?=
 =?utf-8?B?dmROZ0tTUFJ1M1JrRXJVdFlJSXJ0NUROOTlWMC9vTm0rR0dBNUpzbW1zMnQ5?=
 =?utf-8?B?WHROcVRPcDFHL3htaHZnL25aZGo2QVNYM2VpcURKcld5ejdVWWdlNkZGNWFV?=
 =?utf-8?B?NjlRby95TGRmWk1yMzNuZU5xMFVIM1A1eWtmc2xoTnc1aE5SdGc1dUZLMy9Q?=
 =?utf-8?B?SEhicEU1dG9kR1FIb0xxQVdVOHIycmoydkNHWFVoNnM4WUJKc3NaejVrY0Nt?=
 =?utf-8?B?QTZMSVkvaTlKTzcwVzFDTmIvMHF4SDBUWXhzWkovTzBISEFCWVBvR3l1V3N3?=
 =?utf-8?B?ZnZJemZ5b2VyakdKTnc1VkVVWWdrUnV5L0dqSW1pbDVqYmFIRXBKZVdMTm4x?=
 =?utf-8?B?Um44UE96RWkzbE5YWGhNVjZVMVVTemVDVHdqV0VEL3RYcjh1bWozMjRLUDRL?=
 =?utf-8?B?eW5aeFNqbVFYaEhmeTk4Qmxzc2JlMGNadmE2VmpmbFhUbGpybnFCdnpSeStH?=
 =?utf-8?B?N0p1ckp3L2o3N2g5V3VZOWM2c3hNUExlK1pxUjBmWFhIODArWVMzdzZFYVhI?=
 =?utf-8?B?VkRxcXVzSXpwaTYvS0N6WHUrQTRoLzcweFFEbWZZQmZUK3FFVzFoWDZ2Uzk5?=
 =?utf-8?B?elhmM09XTldES05oOHBHdmxGOUFMbzE1QnJ0Y1lGNnQxeERvVStUTWVPc0Qy?=
 =?utf-8?B?dkR0bjlqUTNyc2dUSS9PUmVSeDRTTm00N24zb2kwTG5WMkUwTmowQVQrZmhv?=
 =?utf-8?B?d3hYZTB2ZlRWdmlUYnkyd2lJZi9aU1IxZkMwRVBjcnRka3RzSVVXajZWUTVk?=
 =?utf-8?B?bGptWnNFdGpISldaNmRYQVk4Z2ltbEVFUXRmaXFPek0zS2x4TzNVdHFTQ1h2?=
 =?utf-8?B?OU1wWkVYaGdUSHkzQW5XeGg3dHhKWFVkNkE2WjdaZUsyNUhtc05mTTZSVUhX?=
 =?utf-8?B?NGhjbDBlK2xPNk1HSGpidlV6c29idUViT3ZnT2tsdTc0Q01NeVRzcy9wQmxO?=
 =?utf-8?B?anNoMDE4S1BSeWxSNHJrOE1MdTBIbEVxNjNEYmF4Sng0TXVDOEFzNHJTSjZz?=
 =?utf-8?B?b3lILzJUOS9tUGhHWkNqZytkVmZ6bDV5elNsNlA2UGR3Umt2aXZPZlJYekxz?=
 =?utf-8?B?VlhvN0tFcm1kVm11VW5DQXcrc1R0YW96VkZTU1dHb3pxMEVGeFNzVjNzU3BM?=
 =?utf-8?B?MHQyc05PeU9NMk1memtrS0JkY0EvWGFhTTNURUE5RklaV001NHhQNFNicTA0?=
 =?utf-8?B?UkQxaUVTR0ZiMkc1c09tU2Z2Q25RdEpUMzhwZWY2Vm92a0ZWQ1UxdXBXQjVx?=
 =?utf-8?B?VDJNeXJWYTJsODd1U1pic21GcllyNG1tcVJWcWpZNEo5SndhUThRd0FyQWVT?=
 =?utf-8?B?SEVadU4wd1hrb1QvbHhFdDFRL0VUNmdwMHZmYnR5dUpsMnVzOW5TbGxrNDEx?=
 =?utf-8?B?ZVNLWWEvZExYSzVuZ2hocVNTc05JcWxRQ0NnMnR1aUlZaDlxRTdaaXh2UWhF?=
 =?utf-8?B?VWc1OGlmbC9nMWpZNzFEWTRBZXU0UmVuaHJiaHJjMWJ4dS9ESmJRUGpxaStI?=
 =?utf-8?B?T2lha0FQcjY4R2t6K3FqbHUrSXU1QUF3VjhwUVVxaTRNUVErSmQyYy96d1ht?=
 =?utf-8?B?eUtIVGF2dmcyaWFlTmRKVUc2a0N5NDJaQ3pjYmhjaE54a2Q1bkRFcEMwTXY1?=
 =?utf-8?B?dEQxN1NGWjNSRUxrS1BUa1NnUVh1OU9jVEdaNEVHT0FJTjE3QmZHR1RFdlNR?=
 =?utf-8?B?cXd0ZVlGRkxxK1FxaFEzTmZ6ZTloeGUvb1BlcU8yQk01TUtaYnpmTW5OY0hP?=
 =?utf-8?B?S3ZGY1o3RmVBK2szS2o2cEJhNmFDb3c4emhmNWt2d1NncGhrbitVUUdsTjYv?=
 =?utf-8?B?cDBuWldsUlRPVGtQUTR3Sm5jbUlwZzBIeThJNFdSRHNDMVQzMiszOWJOcGQ0?=
 =?utf-8?B?TVYvWFZxQkR3cEhJUStTTWxIZkU1RGEzUW80c01QQk01c3c0U3ZPc1RadC9u?=
 =?utf-8?B?dGQrY2pSR0p2WGxBaWVYUlZUcHh0L1d0Q3NqczduWDhaQWZ0SVd4dnIzR2pz?=
 =?utf-8?B?cGg3d3NaMk5GMnJXc1RoWlNNWXVhclFnN0ZQYkh4Z3E1NzM1dEs3OXJIQzI3?=
 =?utf-8?B?RFliTHY2R1gySlcreTNYb2U4MG8rU2kyeTczYkxQYU5TRCttbWtaZG1pb0ZP?=
 =?utf-8?B?cXdRUWJrWDNjRWVSS2Y2b3AyV3BtaW9HVTIwOTM1eDRTUER2Tzhrb1laKzhO?=
 =?utf-8?B?MlBNVkRoeDVUZDViMW4wT2dkK3VmRGRvNWtMQm1ieG80VzVReGg3TTZIZ2xi?=
 =?utf-8?B?VmIzeHdPZ2NmZHlNUTUxSEZFMHRNdWJiTTM4dUxmYTdXc0tVRE52Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b84d3e9-816c-4939-5207-08de83389daf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 08:47:12.1378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IwVBjIhIYQgu8ZWrh5UaMMVsjBjkgFx181fbKJpKoV58B+Uwgt+ZAxS5U9Hs65FWTqU0NX7lsUTSagx7DOiR4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8476
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Mar 2026 08:47:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22376

On 16.03.26 09:34, Kamlesh Gurudasani wrote:
> Add missing license headers to shell scripts and YAML test
> templates.
> 
> Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
> ---
>  scripts/deploy-cip-core.sh                               | 3 +++
>  scripts/generate-sb-db-from-existing-certificate.sh      | 3 +++
>  scripts/generate_secure_boot_keys.sh                     | 3 +++
>  scripts/start-efishell.sh                                | 3 +++
>  scripts/submit_lava.sh                                   | 3 +++
>  scripts/update-linux-cip.sh                              | 3 +++
>  scripts/update-ltp.sh                                    | 3 +++
>  tests/templates/IEC_template.yml                         | 3 +++
>  tests/templates/secureboot_corrupt_rootfs_steps.yml      | 3 +++
>  tests/templates/secureboot_negative_test.yml             | 3 +++
>  tests/templates/secureboot_template.yml                  | 3 +++
>  tests/templates/secureboot_unsigned_bootloader_steps.yml | 3 +++
>  tests/templates/secureboot_unsigned_kernel_steps.yml     | 3 +++
>  tests/templates/swupdate-test-action-M-COM.yml           | 3 +++
>  tests/templates/swupdate_corrupt_swu_artifact_steps.yml  | 3 +++
>  tests/templates/swupdate_corrupt_swu_steps.yml           | 3 +++
>  tests/templates/swupdate_negative_test.yml               | 3 +++
>  tests/templates/swupdate_reboot_without_confirm.yml      | 3 +++
>  tests/templates/swupdate_same_uuid_steps.yml             | 3 +++
>  tests/templates/swupdate_template.yml                    | 3 +++
>  20 files changed, 60 insertions(+)
> 
> diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
> index 623c216..1e08e47 100755
> --- a/scripts/deploy-cip-core.sh
> +++ b/scripts/deploy-cip-core.sh
> @@ -1,4 +1,7 @@
>  #!/bin/sh
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  
>  set -e
>  
> diff --git a/scripts/generate-sb-db-from-existing-certificate.sh b/scripts/generate-sb-db-from-existing-certificate.sh
> index dddd9b5..42d09dd 100755
> --- a/scripts/generate-sb-db-from-existing-certificate.sh
> +++ b/scripts/generate-sb-db-from-existing-certificate.sh
> @@ -1,4 +1,7 @@
>  #!/bin/sh
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  
>  set -e
>  
> diff --git a/scripts/generate_secure_boot_keys.sh b/scripts/generate_secure_boot_keys.sh
> index 8be0569..28ae34c 100755
> --- a/scripts/generate_secure_boot_keys.sh
> +++ b/scripts/generate_secure_boot_keys.sh
> @@ -1,4 +1,7 @@
>  #!/bin/sh
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  
>  set -e
>  
> diff --git a/scripts/start-efishell.sh b/scripts/start-efishell.sh
> index fff8a6a..86e2ddd 100755
> --- a/scripts/start-efishell.sh
> +++ b/scripts/start-efishell.sh
> @@ -1,4 +1,7 @@
>  #!/bin/sh
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  
>  set -e
>  
> diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
> index b3180a1..a4d20ec 100755
> --- a/scripts/submit_lava.sh
> +++ b/scripts/submit_lava.sh
> @@ -1,4 +1,7 @@
>  #!/bin/bash
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  # Copyright (C) 2024, Renesas Electronics Europe GmbH
>  # Chris Paterson <chris.paterson2@renesas.com>
>  # Sai Ashrith <sai.sathujoda@toshiba-tsip.com>
> diff --git a/scripts/update-linux-cip.sh b/scripts/update-linux-cip.sh
> index 5fbfa57..df306b2 100755
> --- a/scripts/update-linux-cip.sh
> +++ b/scripts/update-linux-cip.sh
> @@ -1,4 +1,7 @@
>  #!/bin/bash
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  REPO_ROOT=$(git rev-parse --show-toplevel)
>  pushd "${REPO_ROOT}"/recipes-kernel/linux >/dev/null || exit 1
>  
> diff --git a/scripts/update-ltp.sh b/scripts/update-ltp.sh
> index dc8b947..321cc3c 100755
> --- a/scripts/update-ltp.sh
> +++ b/scripts/update-ltp.sh
> @@ -1,4 +1,7 @@
>  #!/bin/bash
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  
>  REPO_ROOT=$(git rev-parse --show-toplevel)
>  pushd "${REPO_ROOT}"/recipes-core/ltp > /dev/null || exit
> diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_template.yml
> index f8558cd..148f07e 100644
> --- a/tests/templates/IEC_template.yml
> +++ b/tests/templates/IEC_template.yml
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  device_type: qemu
>  job_name: #architecture# IEC layer testing
>  timeouts:
> diff --git a/tests/templates/secureboot_corrupt_rootfs_steps.yml b/tests/templates/secureboot_corrupt_rootfs_steps.yml
> index b6f6628..5c47b30 100644
> --- a/tests/templates/secureboot_corrupt_rootfs_steps.yml
> +++ b/tests/templates/secureboot_corrupt_rootfs_steps.yml
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>            - "apt-get update"
>            - "apt install -y fdisk"
>            - "rootfs_start_sector=$(fdisk -l -o Name,Start cip-core-image-security-cip-core-#distribution#-#architecture#.wic | awk -v name=systema '$0 ~ name {print $2}')"
> diff --git a/tests/templates/secureboot_negative_test.yml b/tests/templates/secureboot_negative_test.yml
> index 2fcdbfa..a8e4226 100644
> --- a/tests/templates/secureboot_negative_test.yml
> +++ b/tests/templates/secureboot_negative_test.yml
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  device_type: qemu
>  job_name: #architecture# secure boot testing
>  timeouts:
> diff --git a/tests/templates/secureboot_template.yml b/tests/templates/secureboot_template.yml
> index e29b64a..0a075e2 100644
> --- a/tests/templates/secureboot_template.yml
> +++ b/tests/templates/secureboot_template.yml
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  device_type: qemu
>  job_name: #architecture# secure boot testing
>  timeouts:
> diff --git a/tests/templates/secureboot_unsigned_bootloader_steps.yml b/tests/templates/secureboot_unsigned_bootloader_steps.yml
> index 8d64b05..f4f4043 100644
> --- a/tests/templates/secureboot_unsigned_bootloader_steps.yml
> +++ b/tests/templates/secureboot_unsigned_bootloader_steps.yml
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>            - "apt-get update"
>            - "apt install --yes guestfish sbsigntool"
>            - "guestfish add cip-core-image-security-cip-core-#distribution#-#architecture#.wic : run : mount /dev/sda1 / : copy-out /EFI/BOOT/bootx64.efi ."
> diff --git a/tests/templates/secureboot_unsigned_kernel_steps.yml b/tests/templates/secureboot_unsigned_kernel_steps.yml
> index f097ed6..6ab334a 100644
> --- a/tests/templates/secureboot_unsigned_kernel_steps.yml
> +++ b/tests/templates/secureboot_unsigned_kernel_steps.yml
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>            - "apt-get update"
>            - "apt install --yes guestfish sbsigntool"
>            - "guestfish add cip-core-image-security-cip-core-#distribution#-#architecture#.wic : run : mount /dev/sda2 / : copy-out /linux.efi ."
> diff --git a/tests/templates/swupdate-test-action-M-COM.yml b/tests/templates/swupdate-test-action-M-COM.yml
> index 56ff106..69c9cb7 100644
> --- a/tests/templates/swupdate-test-action-M-COM.yml
> +++ b/tests/templates/swupdate-test-action-M-COM.yml
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  # TEST BLOCK 1
>  # Fail the job if software update application failed
>  - test:
> diff --git a/tests/templates/swupdate_corrupt_swu_artifact_steps.yml b/tests/templates/swupdate_corrupt_swu_artifact_steps.yml
> index 2fad3fd..043867e 100644
> --- a/tests/templates/swupdate_corrupt_swu_artifact_steps.yml
> +++ b/tests/templates/swupdate_corrupt_swu_artifact_steps.yml
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>              - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAVA_JOB_ID/downloads/common/cip-core-image-security-cip-core-#distribution#-#architecture#.swu --output /root/cip-core-image-security-cip-core-#distribution#-#architecture#.swu
>              - mkdir -p swu
>              - cpio -ivd --directory=/root/swu < /root/cip-core-image-security-cip-core-#distribution#-#architecture#.swu
> diff --git a/tests/templates/swupdate_corrupt_swu_steps.yml b/tests/templates/swupdate_corrupt_swu_steps.yml
> index 74c9217..3cdb793 100644
> --- a/tests/templates/swupdate_corrupt_swu_steps.yml
> +++ b/tests/templates/swupdate_corrupt_swu_steps.yml
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>              - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAVA_JOB_ID/downloads/common/cip-core-image-security-cip-core-#distribution#-#architecture#.swu --output /root/cip-core-image-security-cip-core-#distribution#-#architecture#.swu
>              - mkdir -p swu
>              - dd if=/dev/zero of=/root/cip-core-image-security-cip-core-#distribution#-#architecture#.swu bs=1M count=5
> diff --git a/tests/templates/swupdate_negative_test.yml b/tests/templates/swupdate_negative_test.yml
> index bb79b07..250eaa8 100644
> --- a/tests/templates/swupdate_negative_test.yml
> +++ b/tests/templates/swupdate_negative_test.yml
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  device_type: qemu
>  job_name: #architecture# software update testing
>  timeouts:
> diff --git a/tests/templates/swupdate_reboot_without_confirm.yml b/tests/templates/swupdate_reboot_without_confirm.yml
> index bfad106..074eb1a 100644
> --- a/tests/templates/swupdate_reboot_without_confirm.yml
> +++ b/tests/templates/swupdate_reboot_without_confirm.yml
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  # qemu-swtpm.sock will be gone after soft reboot.
>  # So the swtpm socket need to be started again for proper reboot
>  # To start the swtpm daemon, first the existing one should be killed
> diff --git a/tests/templates/swupdate_same_uuid_steps.yml b/tests/templates/swupdate_same_uuid_steps.yml
> index 3ff2e02..8329055 100644
> --- a/tests/templates/swupdate_same_uuid_steps.yml
> +++ b/tests/templates/swupdate_same_uuid_steps.yml
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>              - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAVA_JOB_ID/downloads/common/cip-core-image-security-cip-core-#distribution#-#architecture#.swu --output /root/cip-core-image-security-cip-core-#distribution#-#architecture#.swu
>              - mkdir -p swu
>              - cpio -ivd --directory=/root/swu < /root/cip-core-image-security-cip-core-#distribution#-#architecture#.swu
> diff --git a/tests/templates/swupdate_template.yml b/tests/templates/swupdate_template.yml
> index e1f71a9..9a3366b 100644
> --- a/tests/templates/swupdate_template.yml
> +++ b/tests/templates/swupdate_template.yml
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  device_type: qemu
>  job_name: #architecture# software update testing
>  timeouts:
> 
> ---
> base-commit: e3158569eee297f1837a6d3fd7e0f1a0534c2b8b
> change-id: 20260316-license-c5fcde3618d2
> 
> Best regards,

Thanks for taking care! Here is the list of contributors to these files:

Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
Chris Paterson <chris.paterson2@renesas.com>
Felix Moessbauer <felix.moessbauer@siemens.com>
Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Quirin Gylstorff <quirin.gylstorff@siemens.com>
Sai <Sai.Sathujoda@toshiba-tsip.com>
Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
Srinuvasan A <srinuvasan_a@mentor.com>
sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
sarath P T <Sarath_PT@mentor.com>

All worked on behalf of a CIP member. Furthermore, the default license
rule from the README applies here:

"Unless otherwise stated in the respective file, files in this layer are
provided under the MIT license, see COPYING file. Patches (files ending
with .patch) are licensed according to their target project and file,
typically GPLv2."

So, I will merge this the next days unless anymore brings forward any
concerns.

Dinesh, the file list you shared directly with me is fuly covered by this?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

