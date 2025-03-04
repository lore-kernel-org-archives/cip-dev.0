Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E3AC282D2
	for <webhook@archiver.kernel.org>; Tue,  4 Mar 2025 15:11:46 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.77])
 by mx.groups.io with SMTP id smtpd.web11.24077.1741101097128509591
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Mar 2025 07:11:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Cxh1P55e;
 spf=pass (domain: siemens.com, ip: 40.107.22.77, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+4lA83fE5e0WLCGp1asJ8BnDcyJrXYbS2TuZsBpf8WnQhfkr2i9GVzYwPhuYyDk5MO7v0C4lOSHFzMK+Fpar5cBtG5AT5FG60rtSRFZTJt/Q0t996vqf7lkVKCx0Afmc4frr+4jrVejiKvZMeDWHahsUp4N5Ef1ik3bjFeYCJkL46IvjvIfJ2H3Bny+5FVJIrmm1a8da3e74G4X7fuQs32N1McOHOxRlUwe4nZR5fYsw9OQojG7IPMmuP/Wzz8BSLLE85mK2+UhRYoBXtwYgPBj3Okr4k+Nt2ZZ5cXiFpSRHQDuoKdAG5mjqoNwWtTKWLRRYdMvSwEFzS1IsAi6JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYvg4c4+CmgFfsEa0Ie1kO1MJYVqfGBtBHLjru1CsQk=;
 b=HhqJsHTlMr0HZGb/dNYQrsbWNbkVqzC/cCSy1z7Zky56UREhs1i6zEjlzNXj5SkXB0xLp+EQkqQAS0yqBMFXh77ETyYops6g2GxQqKGfBRBfOm2VjlJ7w850Y2JEu0vFHJ8JbddlPuEjJPUIIYgKir2iacZmQkZeLYLcckcKt32Y867amtO0iRCRiPIbpODFtAaYgVZgpZpJiqjgzbpLIkEsOJwSTZw/kTstcZKZxSdIklB4L28RT0oTn5s11PzGJJ9aJYtgMJa2UnJgkx7wzEl65wrQ63l3BKgGlTg/FpknuxCvcrR23D5u6NCiUQ61LurWMJW5UKo4W9rpCkP5pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYvg4c4+CmgFfsEa0Ie1kO1MJYVqfGBtBHLjru1CsQk=;
 b=Cxh1P55ePE0z/F0RDt9q2bwpalV4ZgH3GveD67tTc4GId/I4mNsd16Z79LItfx+M43VjCEYT02/nUpdhsczGKPa3rcxC0Yjw1utq8XH0ui7X+sxb56Aq6HFkxstSjJUnMaSIbBfRuwSDSwpQEYKyLrlvZaq8DybkCxt17sfvmXCtccAC/Am2HgFFPLG3F7m6pxxIMcX02sIO4oAS9tlAfe9DdxFcRku3pPvCKlH7Grn1Mqqbs6xkrq3IJB36ab3dDteLjt7PhkEseQFxvNmy1q2TvMtRUxGXfNguKqHU/plvVIS8UwS2P4e3HmiTkcrJY9J1e67nu/ZgY9KXvM3LiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7530.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:425::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 15:11:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8511.015; Tue, 4 Mar 2025
 15:11:33 +0000
Message-ID: <c98de579-e33f-486f-b964-4f4a0aebd1d5@siemens.com>
Date: Tue, 4 Mar 2025 16:11:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] initramfs-crypt-hook: implement 'noencrypt' option
To: Claudius Heine <ch@denx.de>, cip-dev@lists.cip-project.org,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <20250304130743.2812183-1-ch@denx.de>
 <20250304130743.2812183-3-ch@denx.de>
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
In-Reply-To: <20250304130743.2812183-3-ch@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7530:EE_
X-MS-Office365-Filtering-Correlation-Id: e018c449-c850-4c36-a25d-08dd5b2ed9d2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dmNaZ2tVSERFS1lyWUl5bndrcTlLYkFLWHJteDlDbzg5YkNaSnpQbXA1VTRC?=
 =?utf-8?B?NVJoZ3lrOXVlc0Y0VU5RTWMzdStVOE9ONzRiOHlzUUJHVXduYmQ3RkpscTFl?=
 =?utf-8?B?SmFLeG9VUWhDZXRqd2NuQTJWckp5clZYMnliTWYzTmp3NWJhTVBBZ1NKUmdG?=
 =?utf-8?B?RjR2TFN2YzhFYVhqR0tUZmNUVEJhcDV4KzhYZVNsNkN2dHJIWTZCSUFQUm1a?=
 =?utf-8?B?bVZnZzJHT1BWcXRna05CNkpuUmswaUdzbmYxUU5ZRWUrOFc0ZjNjcXVic0Z6?=
 =?utf-8?B?TkNzdG10Z2I5NW1zYTN4OFhKc0ozdTlrcll1S1FHYk8zNjlkdmNLeGswWVZj?=
 =?utf-8?B?NlhCTjZUdi9zbmkzeDFVdVdJWm1RY21SY21aaXprTllHRVNpai9ESVhxYWZh?=
 =?utf-8?B?TEtZTWIrVWMwN2h4VWxuK3hMTkRLRVhEdW1nb2ZLeG5nVkhYQ1hHUU83OVhR?=
 =?utf-8?B?VkMvZktBUlQwbDVGOTRyN2lyWXZ1RHFZVzN6UU1tOXJLWEpkSllFYkpXNlZn?=
 =?utf-8?B?UGwrNFlNWXA4SklhVVhVNjhhRWNJclcyKzRSODN4Q3VNSTBvZXgySXZXNFpH?=
 =?utf-8?B?MlJNNlFLa0NUNktSbjBCcGxOTWJ2NGNYS0ZWYzRtVVdCM0JrN25lMktpR1hT?=
 =?utf-8?B?VTVIdTY3bXUrYkxEMUpITTdacHQ0Tm54NndvQVZtM3RrUjZYcDk4UjYvT0tp?=
 =?utf-8?B?NmFYdXlSblRGVVJBNDJEcHJZUnhNUEh5cEp4bHpqRmpkYU8wT2V5YTg2dHBi?=
 =?utf-8?B?dU9XdVdlcGVmcGg4NWpNWWZKa3oyNVVXS1pTc09xZHV1dEY3RUZOQW9wNnk0?=
 =?utf-8?B?YlloQ2ErQi9vais4M0U0cTFTWUVtaGNjWnpLeFo3OG01Wk1kTnN6UVJYdEVa?=
 =?utf-8?B?YnVHSnYvV3EvUWlncHNjSEVpMXAvWUZXVHUrVlQ4OE42QzJJZU5YWWlYQzNt?=
 =?utf-8?B?NzYzbkhPV28wUmVQR1JRQ1c0NGtiRFRlREhlVCszT29qK2RTbGF4Y0M3bUc4?=
 =?utf-8?B?WFNhY2lmM3BlZWFFeTBNWmRldnBLUXNLbVJzbGFYNWV3bUtNWHBoVmxNQnc1?=
 =?utf-8?B?T3ZGS3hPVjlnWnU5dFVVWDd2cmpxV1JPN25HblZtbFY3T25SZUNCTCsyQTBi?=
 =?utf-8?B?UlJVUEdzeUxVTkcvQllrR2lMNG9JaGRtYUNhVWd1cHUxVFBXTm5VanE0TmR3?=
 =?utf-8?B?V0o2cWFINVcvM3VDdm1vSVdiMkp6ejVDNkZvTkUvNXphcm5CbDdsSzRiaGZT?=
 =?utf-8?B?T0x2RWdhZUNtcGNzOFMzc204dFNDMGZBVE53N2RjcXdjWHFRaVVvS1dGbVo1?=
 =?utf-8?B?ekVKZHRsd0pzODZwM2NhNTA1SlN5MktWRkdnZGpCSURQRm05SWo1R1hpYjZ4?=
 =?utf-8?B?c2lzZzFsTWkrQUdIM29XMnBqWklqNmhXL3JlNGo2dHhDVzIzRTVhT2w1dHpI?=
 =?utf-8?B?emZ5NldtZ1ZjOXVDU0g4MlIvb0dhcTBxNjdIQkRkeEpsbTEzMGk5VXNhSE93?=
 =?utf-8?B?ZXpVS0g5MzBnTHZUYzJzci9vblBNcEhmVGN0UlMxd0s3bVZ3cjdESVN3TE9G?=
 =?utf-8?B?ZHUrUUozVXEwR0p2b0VqV1VQd1FjWTBFU0wxdklxZkJVSE5WQVRFbTZta1c4?=
 =?utf-8?B?ZHIrR0JwRE9UWnpja2VyUlhnNjZOZGNieFRyZTFpcGtKTWJza0JwZ0hVbnBY?=
 =?utf-8?B?SGpOL1ZUNHY5T1FXYUNZUnZzS3ZzS2ZJMEoxdWdiNktRc1NuWGIvMmJWUkQz?=
 =?utf-8?B?U3FZVE12TVFWWFBCNTZPVjFidGw4TlkrcnliVDAzejNJOG1jeEFLNXFwMjJ3?=
 =?utf-8?B?bXcweHFIN0N5ZXd5ai91cU9YL3gzU2hqeUIxOWlGRy90TGhwU0ZNRElBbUY5?=
 =?utf-8?Q?2tGfej8Wi+s92?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dXA0Ni93SjJWaCt0ZG05eGdnUWRiRWFKQjhDQUtpVDFXYXk3UTBOak56T3Vh?=
 =?utf-8?B?M292VDBKOG8xOTMxU1ZQUmRaZWNpYmgycThFZFNSM2l4alRWczM0T1JKcW40?=
 =?utf-8?B?K290a2F6MWc4TjZ4YnJNKzRxRjhXVkRDVlM4RWdqR0FCRkh3bWJIUktoN3J5?=
 =?utf-8?B?RGw0alBSdi96QTh1VVA0WmFzZjQ1T2hLVGRQRjBQQnpGMnpDelhRcUpVcHZY?=
 =?utf-8?B?ZEVldXBMZHE5UUh3NjVrcCtjVXNXMUxYZ2U0UmpxVTZjSXBNVk9nR281RWdF?=
 =?utf-8?B?ekQrb1FtdkFDUVlvcjVrNWtsZlg5NTFFWDE1djZpSmw4cGxiSGxkVWdPMXcw?=
 =?utf-8?B?WTVCeGNDZEtaUk9mQlpHY2ZJRWg2dmQvcDNyRTRLekFhL0J2TXZUaG9vQlZX?=
 =?utf-8?B?SmZHcVJldElXUHpDaVBSUjZRNkxlUE5DSDN2NnNGS3c3SncyZEo4WkdBaWtu?=
 =?utf-8?B?bjlIV1ptRGZsVGpNaEZzeHNDOFk1NUpBK2d4Q2pSVmpoUWNpTmFDYzFLVUo5?=
 =?utf-8?B?R1BJN3FOT25JYnIrSUN4NFZxN0hORGtKSFV0N2lxdXpqVkdPS3ZvcldDYUpL?=
 =?utf-8?B?SDhEeTNwT3pIamI5WW8ybWFXZ3A2dURHUzZDdmVGU280a3l0Z01CcnBHTWdI?=
 =?utf-8?B?dFZ5d3JLUGl3cGZhejgrelQxUGY3WEltR2FOaE5Pb0RLMTZWaVpmZDlzZ3Nh?=
 =?utf-8?B?QWhzR3ZNSFpudjVnRnl3Ung5L2JJbU96N1FEWkVBQzFGMDFnRFZDbVAxSnNH?=
 =?utf-8?B?UytmUEdjTUhQblN2WnZ4NHpNK042bHZuT25qakQ1QzFFZXRzMFIyVWhsUkM4?=
 =?utf-8?B?SWNJcDhIZ3BDU2lCTXpHOGhxQWo0K1duejdqU1NnaDRjS3JWT0V4Q2tPbnhn?=
 =?utf-8?B?S3lDc3BXVnBYQTBHMjF5dW9WNTRxYXB3RitLNi9VNHJ6VEQvK21sZWhYMEF5?=
 =?utf-8?B?NEdCQUc5OVlYZmdoUTZKZUlSd3hCZGY1aTJlbzUrZVVVbEhvTVpjTHNYNzdT?=
 =?utf-8?B?SjlFMllYUGdCUWE1NFp1ckZJTEMvRUd6WmliK2FBVks1MlVhdlE5L09vdjhH?=
 =?utf-8?B?SzZIRFlQVTEveHM5NEErcEh0ZkpURmlTR2VMRFRqdFBobFZBL0ZFRDRsTEhE?=
 =?utf-8?B?UXpJS0xHSUo2bkE2M2N5aXVXWmJtNVdmTHlHZ2RadVpnT2d5ekQxVlRtSVlW?=
 =?utf-8?B?UlZLTXluOFNZVVl3cHpZdHkxOGtTVXVydS8xSXNBdktqZllBR1FJZEIyUTZs?=
 =?utf-8?B?N0JKVk5OY3FGWGdrWDZRbkpaRXF6VGlaTDZVeEx2RlBWbk9PSUluVEIrbHV5?=
 =?utf-8?B?QnErdnlFU1hyWlJpd042ZG1TNXJ5bFBUWmlyY29IZ2t3ZG0yMWFIMGJ4bEFR?=
 =?utf-8?B?QkZSUHRTdzBtb2QrL2ovMUx0NWxSdVM4MFNSVURCcHNwWTc5Z05XTEJYSUtj?=
 =?utf-8?B?d2hlWWJ6L045aEFCNG1wbHNLb2JvVEhUS1RMWC9UOVRlblpFTm1IeUMrZUNa?=
 =?utf-8?B?bnBtZHBLQXgwSVljQmtoMnNUMUJuUlpBaHE0ODNFRzI4ZldmRVFTeHlHK0s5?=
 =?utf-8?B?NDVqaUZuSHBnbEhXRTNCMGpPUWl0WEhGVUU1M2hwWDgxRlRBWHdpZHVXZVRL?=
 =?utf-8?B?S3VtMzlvSDMvUHk5Q1RkcER6Rmdaa2d0SWJlL1BGV1FDb05TVHBtalFjbXFN?=
 =?utf-8?B?RFRXc2NXSlIvMWdrZ0RGQ25HNi83SWg5WlcwdGEyWmpNTkVPVE41dXhtWXkr?=
 =?utf-8?B?a0gwS2s2Y2Y1dDdxRXN6S1R4SUZGV01XMnJkMG1JOFZvNVpDMUJPd2IwZUVG?=
 =?utf-8?B?UjFBV1Q3c2l0MnlRYXJ6RDY5WXptQmZBRFBNL01jaTBXS2JqaUpSZE5RTWpC?=
 =?utf-8?B?d2VDVDZhZCs5N1FrNzVaR2Y1ay8wZHlYNnFKQktST0JvbW02dUVZQ2p3Tk40?=
 =?utf-8?B?MW1iODJzdGZLYnFBWndFbHhBNFd4STRaWktOOHJKeTlqVURxeWRoSUpHSTJE?=
 =?utf-8?B?d05WbEt6YmFQeWd4ZEw2Qys1eVc5N0poelB1cFpKSThJbDltVFVBeERWZ3VN?=
 =?utf-8?B?Q0VER3lkd3dnd042QlVKeHB1UTh2dFhpZDd1aGpPUjFYMjVKYmY2SkpsbVBx?=
 =?utf-8?B?djJsaU15YVZlYzZhTVpFYUhjcmM5eEtCZGQ5ZVZWZkRxT0Z6WlRXUnVMcTY3?=
 =?utf-8?B?aFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e018c449-c850-4c36-a25d-08dd5b2ed9d2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 15:11:33.8948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: po+PGH78CDNSxy+/XVpxUceHH7rnFl6y2UjCsrEni8rpCePEuEL7XBmmu8uFuLTFHO4kriJwZQPZJqHqZcxBEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7530
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Mar 2025 15:11:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18023

On 04.03.25 14:07, Claudius Heine wrote:
> In case encryption needs to be enabled via an update, while still
> allowing the update fall back to work. One update step where encryption
> is supported, but no reencryption is taking place if the device is not
> encrypted.
> 
> For this the `noencrypt` hook is implemented, which requires some
> restructure/reordering of the `local-top-complete` script.
> 
> Signed-off-by: Claudius Heine <ch@denx.de>
> ---
>  doc/README.tpm2.encryption.md                 | 22 ++++++++++++++++-
>  .../files/local-top-complete                  | 24 +++++++++++++++----
>  2 files changed, 40 insertions(+), 6 deletions(-)
> 
> diff --git a/doc/README.tpm2.encryption.md b/doc/README.tpm2.encryption.md
> index 3f7e89f..a97425c 100644
> --- a/doc/README.tpm2.encryption.md
> +++ b/doc/README.tpm2.encryption.md
> @@ -42,11 +42,12 @@ The initramfs-crypt-hook recipe has the following variables which can be overwri
>  ### CRYPT_PARTITIONS
>  
>  The variable `CRYPT_PARTITIONS` contains the information which partition shall be encrypted where to mount it.
> -Each entry uses the schema `<partition-identifier>:<mountpoint>:<reencrypt or format>`.
> +Each entry uses the schema `<partition-identifier>:<mountpoint>:<reencrypt | format | noencrypt>`.
>  - The `partition-idenitifer` is used to identify the partition on the disk, it can contain a partition label, partition UUID or absolute path to the partition device, e.g. `/dev/sda`.
>  - The `mountpoint` is used mount the decrypted partition in the root file system
>  - `reencrypt` uses `cryptsetup reencrypt` to encrypt the exiting content of the partition. This reduces the partition by 32MB and the file system by a similar amount
>  - `format` creates a empty LUKS partition and creates a file system defined with the shell command given in `CRYPT_CREATE_FILE_SYSTEM_CMD`
> +- `noencrypt` will not try to encrypt the partition, if it isn't encrypted already, but will open it if it is. See the section [Encrypting the shared partition via an update](#### Encrypting the shared partition via an update) for more information

"...encrypt the partition if it isn't..." (not sure about the second
comma as non-native speaker, though)

>  
>  #### Encrypted root file system
>  
> @@ -58,6 +59,25 @@ The mountpoint is empty as the root partition is mounted  by a seperate initramf
>  Both partitions are encrypted during first boot. The initramfs hook opens `${ABROOTFS_PART_UUID_A}` and `${ABROOTFS_PART_UUID_B}`
>  during boot.
>  
> +#### Encrypting the shared partition via an update
> +
> +With the following requirements, special handling is necessary:
> +
> +- A/B update scheme is used
> +- Both slots have a shared volume, that needs to be encrypted as well
> +- The system in field is currently unencrypted and encryption should be added via an update
> +- When the update failed, the fallback system needs to deal with an encrypted data partition
> +
> +If this case the fallback system needs to support an encrypted shared data partition, but would not encrypt it themselves. For this the `noencrypt` flag can be used.

"In this case"? Sounds strange.

"themselves" - where is the plural coming from?

> +
> +The data partition in the fallback system will have the `noencrypt` flag set, while the update system will set the flag to `reencrypt`, this will handle the following case, for example
> +
> +- Un-encrypted system on slot A is running, shared data partition has set `noencrypt` flag and is not encrypted
> +- Update for enabling encryption is applied to slot B, where the shared data partition has the `reencrypt` flag
> +- System reboots to slot B, encrypting the shared data partition
> +- Update fails at a later point and is not blessed, system reboots into the fallback system on slot A
> +- Fallback system now needs to be able to use the shared data partition

Where do you describe the "format-if-empty" usage of patch 3? Seems that
is an important element as well.

> +
>  ### CRYPT_CREATE_FILE_SYSTEM_CMD
>  
>  The variable `CRYPT_CREATE_FILE_SYSTEM_CMD` contains the command to create a new file system on a newly
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> index cf49e63..1ef784d 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> @@ -240,18 +240,32 @@ for partition_set in $partition_sets; do
>  	if [ ! -e  "$part_device" ]; then
>  		panic "Could not find device  mapped to '$partition' cannot be encrypted!"
>  	fi
> -	decrypted_part=/dev/mapper/"$crypt_mount_name"
> -	# check if we are trying to mount root
> -	if [ "$partition_mountpoint" = "/" ]; then
> -		echo "ROOT=$decrypted_part" >/conf/param.conf
> -	fi
>  
> +	# If partition is already encrypted, decrypt and continue with next partition:
> +	decrypted_part=/dev/mapper/"$crypt_mount_name"
>  	if /usr/sbin/cryptsetup luksDump --batch-mode "$part_device" \
>  			| grep -q "luks2"; then
>  		open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
> +
> +		# check if we are trying to mount root, set ROOT to decrypted partition:
> +		if [ "$partition_mountpoint" = "/" ]; then
> +			echo "ROOT=$decrypted_part" >/conf/param.conf
> +		fi
> +
>  		continue
>  	fi
>  
> +	# If partition should not be encrypted, continue with next partition:
> +	if [ "$partition_format" = "noencrypt" ]
> +	then
> +		continue
> +	fi
> +
> +	# check if we are trying to mount root, set ROOT to decrypted partition:
> +	if [ "$partition_mountpoint" = "/" ]; then
> +		echo "ROOT=$decrypted_part" >/conf/param.conf
> +	fi
> +
>  	# service watchdog in the background during lengthy re-encryption
>  	if [ -z "$watchdog_pid" ]; then
>  		service_watchdog &

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

