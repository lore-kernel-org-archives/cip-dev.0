Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4DEF46453
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 11:19:41 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.47994.1773659970780381322
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Mar 2026 04:19:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=qDT98ez1;
 spf=pass (domain: siemens.com, ip: 52.101.66.42, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=feFApizQYoOzAEeOlVdoqxFFAoeFokqPK7IjNvmnsZzipeVUpUZ/32QzKfAFxeP3hgfBpCkCt/WrQJWHi9m7tvdzi5BfL+Q0oBcmD3m5SiErzmzya2i1zTOL+6dOH6MGOU8TtcByThT0U4VUm/uSU6LI4GJyUF9sPL5DHvqj0PPxOnB1msYhv8IWS8E/e4dO9IyAFLMPFViErMtRkOcRHe5fQS8WGsHGlJ7ZYsrtBUnixUximhiFQoMy0XUt4Dp/M/U2rTOCZLuZPdPCqDto2Q/qHY9V9eD7+ts56CG4X9vxue1C30c9TvlAO0abJ8FLKGc88YErivVc8FonhIu4QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ic3b3COeUhM96Md6uSoXIMcAuxu7KfQ7alNEOeZzbTk=;
 b=LY//S5FB0AeTODJStyHgBfknrQ14dYk+7X920SGuvdP4AuxKXn0eS8YrXYlYJm0b3hSxfNhj5ApMhbQO+kbQLYxseghE7ayux22sx6/MHlrR+nnVKww2MmyXPnmicR+ZRrypUOOftYwd5SIkBxYBiWAxPJSgMdM8mTdqD3OR3UIq84kojIi0l25GNdo9qglhvKeJcZEQRiuM+B+xgD39ckcsgJP946gNHcRRC64aYNXNoEI3bamKnAwaCImOE9GUCO6VBd4QRpBoBoKn4Wjuz9cXonxjYdFW0Mp9+Ic3m7vuwBUdiL6xewq0OokUMuEDLFG+TuYKr8+OK0XU4DuXqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ic3b3COeUhM96Md6uSoXIMcAuxu7KfQ7alNEOeZzbTk=;
 b=qDT98ez1w6/oPsFpiq4QpwmXjGuGOfx5EEwzbzauAoJbugCxuldZ5EM4QlZwtTts5AbW0E2Dbg2Ux5bVpymXZjmGfinH8PRkBUPhpAa/vkcfiBbbyB/0Ckq6k0dD7xFZ9pSIICBmE7/1CiU+uwHlgT/19XsVdDzYJAhL9TPtIbm3UFDEqNSOjVXe0T5tSRyIRsVUcBXV8WC15yOf6l+T3UDZBiAK4DJuvUy+qZIqH4K0oDatCszOL/NzBOsf5W8TaqJSKdqDmnJDl6SAG/9GylPKC7WytZcwwUYotHdp47knqqcvMjv3QQ5fvfWXsnM4P1cPOySfjymiu0YUVan4KQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8427.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:21a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 11:19:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 11:19:26 +0000
Message-ID: <21ef6fdb-4f7e-4a4e-bc6e-490ccbd076e7@siemens.com>
Date: Mon, 16 Mar 2026 12:19:25 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip109[-rt60],
 4.19.325-cip130, 5.10.251-cip70[-rt31], 6.12.76-cip18
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CWLP123CA0030.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:58::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8427:EE_
X-MS-Office365-Filtering-Correlation-Id: d251ec9f-e4c1-4248-c7dd-08de834de232
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	CHjxNdtGIsKN7YEOEDY7/asnAN+ZiSpwMLF7Kvkcea937xjk/GmRgaLMTQPMInHNl8T0C6SDVYud8zFxuNA5uSyJP9sivWx6J2PODnrOG8yqLYfKYpza8vWC/ps2CXlb634FZcIViyDmTMHP/Q4QeAX2WRNuFxZhp21m+xVEfsFBQ4JeqMRLWB/1LxfhRkf0Hfrh1+JTS/SIKwK0Fg6TPLGgrSXb4nVBuXGFklt9IcqzEQdfIKmBtSRyc8QOpGEJxlSuSstG9VLoQ08cn+egBI01+ljzj2AHP7vxio2fAYAmKmR9JLmlcneIYwszhjz/WCn8FsytAOLSidQXBs4Gge9Mw++xZP0iLHwlkCRAgIZpvVOgBt6n/FyVoBOSNY0IJsx1oDgm6X+op2TlkJ/t/bbcNkPYOFOgxzOnnQRe7brdNknzWREs3u5Lk9JCmEsYffWYA3FW89knenhKiV1zhhYO+RrAsk6rRiR6SrHpRiivT6TNu7RWo32p2BEp4sBAIEsbT6iSrV9THuPIjm2EpNNb8l1rqEJozB8nuz1sHhQEvd8ZYfirJM1WeqUMfZoYITY3nqub6dikmW8DHdcxxKAcFOcIC7UQ16gUBusXhL7EKM9seCcKqGZKXj1M4G6rChdtBQHL5cxvvPNwaoHGSQ55ytC2d8TEJ8lVJPzLMWTva03slzF+NZ1yTlQ24ApJHbPdLXwSNZPyT0Lwn77j7P4ULxIvgB+Ptvc/GCRDkvA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aU9McWw4cHExVG9ubWNRT2lyMEFoVWpUUEZna0NXd2RIcDVuNlZNVCtaT2ht?=
 =?utf-8?B?YzRnWlQwYWVkY2QrcU9lRC9HRkpkTXFyRWc2bnU4KzdNYjMrODhXR05XNUl3?=
 =?utf-8?B?QytlNmJUUDdOTlB6UXM5WXRKMTNyZjRoYlBDQWZGeEFxRXF0NEQ3TE85Rm9y?=
 =?utf-8?B?UVBlTFVLTW1yd2Zkc1dmLzZ1c0JuamhrbXJOTmdBUGkvQVFvcXdIVDdtb1ZM?=
 =?utf-8?B?WHp4Y2huUUhlMWlJNkcxVElxa2E3ejVoelFVZEQ3QWhod1FQZk13eDFuZWkw?=
 =?utf-8?B?bDQ0Z2pNbW9KS0ZHNmErV2JBQTZmMUZQT3FWSFpXbmNWSTJHYjlXRGVWeTRo?=
 =?utf-8?B?ZXRuY2ZaTGxxQTdEQmx2ZTNNbFIwR3A5K1pqRjZudk9jUmZyTU82ZVZXb21i?=
 =?utf-8?B?QWd6cEx5NThVK0diN2tJY3YrMXZYeEhDWDcraW9QYTRkc3pyc3ZybVdpbTdY?=
 =?utf-8?B?RUtRMXhkMjN2bkFhWG1YUkw4TGVHUFpZV0E4TkVEbWpXYWRIbkZLZ3VFeUtm?=
 =?utf-8?B?bDB4ZUk2L0o3NTR0SkNuaFkvMkcvZmtiV3VRbzAvUzZLTUVpQ05uVXN3bmNk?=
 =?utf-8?B?aEEvcFhTZ1VGWEp3SlB2THpsNEdaaTRKWVl1V2IyWFdabG9WVGwvbkJrWXg0?=
 =?utf-8?B?L2F3QldkWFVwOHlYM3NKMkVnc09MSlVydy8zc3VzOVdXQ29mTHBqZlQzb2JG?=
 =?utf-8?B?MHRFVUVjQyt6dWRSbHllSDdkeitXV2JHeXRVc1ZIMXZCZXNHTEtZWTFNR0NT?=
 =?utf-8?B?Z01KcVRlQWJNbC9naFB2VHZ4a3J1SUJFTDlVenVNbmZpb1NvRWNpOXFlbzB1?=
 =?utf-8?B?RHVkTFBENit0eWl5cTM3bGJub1lHeWd5ekw0enJsajZ3aW1FRmZMdnJHQlJz?=
 =?utf-8?B?eDU3TDFGcUVUQWhNWllVOWhMVXNraEVJZC94MlRjZVp4MHgvQ21jc1hUSXFC?=
 =?utf-8?B?blo0a3lWQUlRYXFaQkxHbWpjRUZHYk9ZNzR1NFdXby9xZHZEbjVjK1Nxd0dS?=
 =?utf-8?B?aGNyS0Y3T0Rwb25pU0F0azQvTjk1eHlWTW1sM1loYlpmNE1xWHJDYU8rMG13?=
 =?utf-8?B?OEI1VnBnUmsrSGxyaiszVDNoc0pqQmg0ZFlWVVpGbzN2aW40d3UyRVhWL1BS?=
 =?utf-8?B?NXZZeE8xS2RBTlJSQ1pnSCsvNWdYdDdQQ2F5clZjNStFVWFDYndKdTRza0Zh?=
 =?utf-8?B?cWM3ZFRqeVdGeFlTMUxmd0pxWFMrSFpSZ3Y4eDFrL2dVeHpCNHkyMysxSSto?=
 =?utf-8?B?bXMrUnpzaWsxZkc0Z3I4QVh6MmpMcjZUalFrMmJLTVdCSTU4WVltNXduVk5F?=
 =?utf-8?B?SkcvZTZiZEo0MytBNzN4M3pMb293QkVGcHVQR2xXYS9ZQzZjQjl3bkdkUzZP?=
 =?utf-8?B?Y3hDU0hiMnZXaXc2bnZaNEV4OElNT3VNVnlWR0JPbUpub0ovdjNGRXdwSXJY?=
 =?utf-8?B?aEdic29aUUhoK3VmQXNWYldheXYreVdKSUhYdGtBSVhOWXIxWnJYQkdZMUVB?=
 =?utf-8?B?VEk1LzlVeS9DOUlJV3ZzTHdVRTlOMHN2V0JqWitJaXQ2QkgrMDlZWVpuTEdL?=
 =?utf-8?B?b0sxc0MxTHoybXNqU1daNUtXc3dQSjJNUXJlY2tIVVlrd1RUMWZuRDdOZ1Ev?=
 =?utf-8?B?TjBMNC93cDRUeHBYZHVVaWU2UUV2M1dMYkdtQWtRbllad2twMHU5VlJ1ZGtK?=
 =?utf-8?B?dGZxR2pzbXEzbDlxY2lzZFlYUXp2UFFsWmFqVDRWWE54a2llQnEwZ3dNZ0Rq?=
 =?utf-8?B?Nk5xZElvWTYxQlZWNFMzQnRrYXRDSHE4OFpnSmJ0eXhNVlBHY292azcxZjI2?=
 =?utf-8?B?U0dxbENIMjUrYmV1V2RseDFWSFNpSU93bmo2dmpmbHY4bEJ6OGdCcFdiT2NS?=
 =?utf-8?B?dEdjRHNEL2hBRnZ4eFpyRUhBeSs3N21KNXdoczhZVUMweklKZURqVHJ1Q0tD?=
 =?utf-8?B?OXJ2ZStRalRBYk13MHlYd2tUOFRqYkpGZTFqUExiVVZVcHRQSnRUUmR2cGwr?=
 =?utf-8?B?c1N2YmVwdVJzTE1JeXdKbVlKT3UxU2JoU3lrS0JDbkw1WGE1aWRITG1maEtJ?=
 =?utf-8?B?RW94SjN6ZTdhS2VuUzYrSE9zYW1DOExOK3NpRzlTaEJyQkJkczlhazRaUzJ6?=
 =?utf-8?B?MFJTSDVBdUJ2cHBmTnFremhDdmZEWmVwTWpIRjZibERFK1ZyckxDWUo4MmRU?=
 =?utf-8?B?MTM3OWdkeGJFcFNla3MrU3ZuYjJXSUVqQmMwQUpBZkJXQlpxNkxiQW9jckFv?=
 =?utf-8?B?dHF4Y1lOY2JvYndvd3d4NjFHQ0RwVHJFMFc5d0J1a3czeW9UanArb1ZUdm9q?=
 =?utf-8?B?dU5Qa0h0MnNJQktiY0RNTWV1ZE9VK3BlY2JhWU9JVHdqbkNad1Nndz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d251ec9f-e4c1-4248-c7dd-08de834de232
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 11:19:26.5808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qI1mHnwtR7tIrHaQnRswGrx4xxAh9I7ATGdNRrjor1zGrdscRNQBI/WDEBGxOtz/j8fNVw3h4HsptFaWDmdGCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8427
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Mar 2026 11:19:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22380

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...4.302-cip106-rt59.bb => linux-cip-rt_4.4.302-cip109-rt60.bb} | 2 +-
 ...10.247-cip68-rt30.bb => linux-cip-rt_5.10.251-cip70-rt31.bb} | 2 +-
 recipes-kernel/linux/linux-cip-rt_6.12.69-cip17.bb              | 1 -
 recipes-kernel/linux/linux-cip-rt_6.12.76-cip18.bb              | 1 +
 ...inux-cip_4.19.325-cip129.bb => linux-cip_4.19.325-cip130.bb} | 2 +-
 ...{linux-cip_4.4.302-cip107.bb => linux-cip_4.4.302-cip109.bb} | 2 +-
 ...{linux-cip_5.10.249-cip69.bb => linux-cip_5.10.251-cip70.bb} | 2 +-
 .../{linux-cip_6.12.69-cip17.bb => linux-cip_6.12.76-cip18.bb}  | 2 +-
 8 files changed, 7 insertions(+), 7 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.4.302-cip106-rt59.bb => linux-cip-rt_4.4.302-cip109-rt60.bb} (68%)
 rename recipes-kernel/linux/{linux-cip-rt_5.10.247-cip68-rt30.bb => linux-cip-rt_5.10.251-cip70-rt31.bb} (68%)
 delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.69-cip17.bb
 create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.76-cip18.bb
 rename recipes-kernel/linux/{linux-cip_4.19.325-cip129.bb => linux-cip_4.19.325-cip130.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip107.bb => linux-cip_4.4.302-cip109.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_5.10.249-cip69.bb => linux-cip_5.10.251-cip70.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.12.69-cip17.bb => linux-cip_6.12.76-cip18.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip106-rt59.bb b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip109-rt60.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.4.302-cip106-rt59.bb
rename to recipes-kernel/linux/linux-cip-rt_4.4.302-cip109-rt60.bb
index 1a341402..66a7fdab 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip106-rt59.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip109-rt60.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "ea483f4282489e517440d6919306f030e738953a21d7c7fd6647e4063429dc07"
+SRC_URI[sha256sum] = "8dd1e6aafa63695c51ea8d5712384881a2dfa19be8538688d779d66d207382cd"
diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.247-cip68-rt30.bb b/recipes-kernel/linux/linux-cip-rt_5.10.251-cip70-rt31.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_5.10.247-cip68-rt30.bb
rename to recipes-kernel/linux/linux-cip-rt_5.10.251-cip70-rt31.bb
index 0d2b2b85..06c77b64 100644
--- a/recipes-kernel/linux/linux-cip-rt_5.10.247-cip68-rt30.bb
+++ b/recipes-kernel/linux/linux-cip-rt_5.10.251-cip70-rt31.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "dd9b650b078df62ea129311028e8e67301fffebb157996e0404f40bbf42c270a"
+SRC_URI[sha256sum] = "0f2646b522468a95b5e0618ef12821ace79f08cd2c9011f4608544d7477fe7cc"
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.69-cip17.bb b/recipes-kernel/linux/linux-cip-rt_6.12.69-cip17.bb
deleted file mode 120000
index 96e4c4d8..00000000
--- a/recipes-kernel/linux/linux-cip-rt_6.12.69-cip17.bb
+++ /dev/null
@@ -1 +0,0 @@
-linux-cip_6.12.69-cip17.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.76-cip18.bb b/recipes-kernel/linux/linux-cip-rt_6.12.76-cip18.bb
new file mode 120000
index 00000000..e4d559c8
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_6.12.76-cip18.bb
@@ -0,0 +1 @@
+linux-cip_6.12.76-cip18.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip_4.19.325-cip129.bb b/recipes-kernel/linux/linux-cip_4.19.325-cip130.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.19.325-cip129.bb
rename to recipes-kernel/linux/linux-cip_4.19.325-cip130.bb
index b5a261b4..83a9877e 100644
--- a/recipes-kernel/linux/linux-cip_4.19.325-cip129.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.325-cip130.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "92a2610abe7bff4988b8d603d9e4d118b26234635048a1172ab74fbae5b36b0a"
+SRC_URI[sha256sum] = "756cb32219556daa2c2e2f87718c3ea4e561cefa5224e178810a58d542187349"
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip107.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip109.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip107.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip109.bb
index 6dca756d..9163c3de 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip107.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip109.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "24abafde968a6978fce5963cabae040825f891f463aef3d23c74d7263a6dd34b"
+SRC_URI[sha256sum] = "a836b062ee48b08cda5d06cd79e40a8eb05ab719e0da405b9243abc1a4d057a3"
diff --git a/recipes-kernel/linux/linux-cip_5.10.249-cip69.bb b/recipes-kernel/linux/linux-cip_5.10.251-cip70.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_5.10.249-cip69.bb
rename to recipes-kernel/linux/linux-cip_5.10.251-cip70.bb
index 13efcfa6..63c6716f 100644
--- a/recipes-kernel/linux/linux-cip_5.10.249-cip69.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.251-cip70.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "9e5342629465767c635f7afd2b9d0c60fa70204d9609da00021e307e306f443c"
+SRC_URI[sha256sum] = "c4553da39c63f299df7c9b86294fc821afe28bb623bf017ed72a76f47d96c134"
diff --git a/recipes-kernel/linux/linux-cip_6.12.69-cip17.bb b/recipes-kernel/linux/linux-cip_6.12.76-cip18.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.12.69-cip17.bb
rename to recipes-kernel/linux/linux-cip_6.12.76-cip18.bb
index 0fea130e..9d602245 100644
--- a/recipes-kernel/linux/linux-cip_6.12.69-cip17.bb
+++ b/recipes-kernel/linux/linux-cip_6.12.76-cip18.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "5185fc3b792317497c8eaf0796ae21bf6b6973655d9ad3c2f26feeb1f661b492"
+SRC_URI[sha256sum] = "c6287e9b9f77a2086f00a14613f8d3b613dba24ea75df71f60f9e82ff4de8152"
-- 
2.47.3

