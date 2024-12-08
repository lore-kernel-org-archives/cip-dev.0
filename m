Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4968E77173
	for <webhook@archiver.kernel.org>; Sun,  8 Dec 2024 09:20:53 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.62])
 by mx.groups.io with SMTP id smtpd.web11.76001.1733649651818394137
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Dec 2024 01:20:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=l/OlS3oI;
 spf=pass (domain: siemens.com, ip: 40.107.247.62, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UAEF+PsNSKzk+NniW4jPwzPVG3LgPh4qbu6QDRc5F6jW9FbLddo9pCJpmDNDRGoeBSKqNXGnKA6XINCRk+DhdQc6bwTL+DWgcrgefU0hMI0UvpOMOlkeFevmh45cmFJX//6BWwR+EAeWMxQqYKfmGFWQRLFVHtUyIy1NhP5plnxfM2b/LcYuDlpaQWMTqacGdcLpTFf+atD2trpY2+VZepfJjhoPyKlPofJVj3p1VPs4IPyN2ggha4imD1K66727h81nZmR+84BOEldvmt2vvkJZk/mmwQh6rrIEEhkSAxQXSRcfw0aQSmYy7z0P3tCnneS0SmWZAFtEt1BkhjEsow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgiK+YgUNRxZFqtbPKGVwjpP9PLuTo7lc9ThBxRpK1Q=;
 b=K2WqO5zyyhLnFtjFMpHrukJZdnpJgu3Pj/jBW8ic8ouKI0ffQIQj+3VMD5xhIaSgNs8fcpf8XwqulA+iH2fNWJ6ezK2oKhb4Ax9gDDZreazShYfCnNrH6zsVKHgm5ZAz2wREOBt1QU7DFUik4LwQ25k6dOjbeoTSuDHbbM0qjOqA9EjamRY7E++AjhdLBg1NkpLOAKGoUWg5yyhPyJ/hpxiOCMmQh3VdwIxzyMLau6m39tKzYkRaTvoUk/R4/kVzkNnFEblbsx6PcMJMAyMCUPllOOPi8+T7xkTly1oBysYlVrnZpphc10SKN/s3oIYzxxUa0byssVMLW6y2C6DRAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgiK+YgUNRxZFqtbPKGVwjpP9PLuTo7lc9ThBxRpK1Q=;
 b=l/OlS3oIbuQ95/URhmymiJ6DhXRFlKwRNmWR9NunT0Q3gj/d0E6Rt6SiDBu81/EMWJBGoKxc99aFe9bpTxJ/YL0Xf2T4A64kRVhadJ+0i5RsjIPijn5DtHie7YbfuCX0Zb/dj0DdX+jpYipWVzJDUuH1nGLXinnz4mR4HMoTeP9XQbriFo2SYmY23pCkAfHUKmz9jtFW2+5qVnDpJuz5sPd22nMXEv7gJ4J98IdFcXtIeVbhZUuZ+gf9vv67PvpQkURewOMgweIXBhoeEmEOKjvpMCQvNA886HVhaQ7aZwBd6oN7myp4iBYgxLxFB/3vr85IvzomuFeDNeIJkNfhqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7203.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:609::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.9; Sun, 8 Dec
 2024 09:20:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8251.011; Sun, 8 Dec 2024
 09:20:48 +0000
Message-ID: <882f21fb-670b-4b47-8280-fcca5c25d656@siemens.com>
Date: Sun, 8 Dec 2024 10:20:46 +0100
User-Agent: Mozilla Thunderbird
X-Mozilla-News-Host: news://nntp.lore.kernel.org:119
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [ANNOUNCE] isar-cip-core v1.6-rc1
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
X-ClientProxiedBy: AS4P190CA0047.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7203:EE_
X-MS-Office365-Filtering-Correlation-Id: 41543ff0-324e-4254-c086-08dd17699a3a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aHA4TDBUOG9nN3lVMTFFSlNOM3FDbWM4Sm1aL29pU0oxMnpydmhCckNyaXQ2?=
 =?utf-8?B?bldicU1MNmpVUXRJMXlkc3F6WFROc3BlMmczTEhnMjFsZ1l2NkIxbjBMc3d2?=
 =?utf-8?B?bzFHeDZvSVAvTk05N0FRbUtNKzUwa2RsSDRvOGYydG9nM2lqUG85UFVFSlBO?=
 =?utf-8?B?YVZpRHRHdnAwVTZJSWxRbGhIdE1sdkZTdTJ1MXI5bEJTaGIwL2xBb3RHeFlQ?=
 =?utf-8?B?OFBISGxORGVhYjVNMnIzL0RFOFQvUHR3djRWWURNV3NjdnhXdXBYSTFqbmp2?=
 =?utf-8?B?aDRLa3Y4amJmSElYQnFBWXcwcWVVelFFMWt1U2l5VXlZRlZtZWRwdzZlUjRz?=
 =?utf-8?B?cWM2b0ZoaUFvNURUM2ZBVXFqU1Z2NVA0T2YxMVdkOGtLM3hBcDErMUVOWUFh?=
 =?utf-8?B?bHF2TVJKRkNDS05YQkw3d0hsczhiVEo0Q0tjZFRtaUNiUEJJMGRGN1NJU2hC?=
 =?utf-8?B?UUliUnBuTFVQZkhLWlpKZzUzVHBRM2NKazdjaHdHL21CTzFiS3VXV3lWaG1Y?=
 =?utf-8?B?aFRpTTlaakluUnAwamtrNUQyMDZoNGsxNTJ1KzZxVHJMRm5kTm1QbkxnWGY2?=
 =?utf-8?B?Z3Vmb3E3NlkvL2djUUVxd0RaNDMrYnBROUtJQ2o1Q0ZXUExzUkk4T1FzNngy?=
 =?utf-8?B?NE1pbm5WSjkwZlIvaDBDTkdqR20xWmMyYTN3cElRNzBya0JROVVJRU15Und6?=
 =?utf-8?B?S05Fa2YrM2tMVjBYb1VRdHU1bUtIakNVa2hNcU9ycTV2ZlpxcENpTWxEbXpI?=
 =?utf-8?B?QzlMaWhZSFZVVTI5b1JNUUJzQ1NES0VscUkvejM3cW53QzFkb3JRc2I1aExh?=
 =?utf-8?B?bmNCTEdnSllkNGVxcVh1cDBhVDU4bmd1T3l2djZtMVdNSDRZc0xsQ2lSMXJa?=
 =?utf-8?B?WUd6ekhkbFpEaG9DK0dyODkrM1ZRR2MwUkxLbHFUam5kV3Y3SVZmRmZzazEx?=
 =?utf-8?B?UThCZkZTendpVGl4VlZRVEdYMnZDTkZPT2c4NG9CS0dnTFZ5bmdyRkJBZFV0?=
 =?utf-8?B?U3Z1bXpwamNWR1ZhM1hFeWNITmhGWlA4VlZiWU0zMDczbnJpZXUwUndJOW5n?=
 =?utf-8?B?OFJWMno5UGcvWlRhMEpEWmhHRWpnRXkvMzBMSGFoMmFnRTdLUldtM2VYVjdN?=
 =?utf-8?B?MTV2aXFaZjQ4bCtXa08vZWRuK3dyTlJmOUVpQ3VtV09wam8yYU93NzRFWWlq?=
 =?utf-8?B?ZjJ6RnYwWmJ5UWM4UFNqM1k1MXVXakw5ZVRiaGRRMlUrTHI2dmk4S045QVF4?=
 =?utf-8?B?WWFGNXRpTDNTMWlObjlqYy9tN3ZuTmYxdVgyL3BKY0NWd2dHNnpzc1JnZ3pi?=
 =?utf-8?B?RXJLeWZML3QvMnprM3BHZ2hMRCtjRlh3aCtYZU9NenpaeUk4elhPN3BQRk5t?=
 =?utf-8?B?ek5Od0czb0VBd3BjRTRiTGwyMVIrL1NPRzIrL0JRWlBISUJHMzAzbDU1VEpX?=
 =?utf-8?B?TjFBMi9RWmpneWJKaGxXUU5FQzFIcUhuQWZQeTNsTGxudlBmd2hvMkozYVBz?=
 =?utf-8?B?NDJsbFB1V2V4U2lZNzRvcXdyRTlBNWErd01acHVRMjBuL2E0dHRJQ2YwZk82?=
 =?utf-8?B?WmZmWVcrcnJaVXNTc2docUkrYlFZZkRHWXJ1WWxzcFo1U0pIZTA4M01UMjVy?=
 =?utf-8?B?ZTRxZGcvV1JJd0ZzU1hqeTBWSzluWGt2Ni9JNGZRS3pKc3BnWHBLUHZMT1pj?=
 =?utf-8?B?U1NTeEs3UTArOFlyNWR0S3NscllUN1AxVVFYeFRoaXJLZExvb28yWk9HTDha?=
 =?utf-8?B?bTZzSU1kYU93aWZLR3F3azhYVXU5U2F0RWVMeFpxTkJQUlN6cDFQcWovdU1m?=
 =?utf-8?B?Q0RZZXI2bWlwbC9MQ0QyUT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VVpiN3FZZ2QwSnZpQUJkejBSdnVLOGx1NDdIUzVpUk8xcnRhQWZZNlFmVzZT?=
 =?utf-8?B?UFkxWUN4TkdvNFozUW85N0xicldXSU9ZZXFnb1c0ZS9LWEYvWElaQ2J4NTNB?=
 =?utf-8?B?N3FaSXhZemdMVHBkZmorY0JiblIrRGJvRzl3alNmV20vcWxQcWlQM2cybXRI?=
 =?utf-8?B?cFJjK2xHaS8yWVNxWm1wSHR4RzZlNm9VL2FXTndBVk1seHMvQS9sNUpwZ29l?=
 =?utf-8?B?OFhGNXVreUVXRm9LYzZIZ2FzcStJSXE2RG9QdTdCREl3UVVBV2NYYVJGSU4y?=
 =?utf-8?B?TEkxdkl6SzcydFYxVEMxOHFUVDF3cURzU2hCSEdJNThCdXU2YkRoYVU3MDhs?=
 =?utf-8?B?bjZ0RURTSmtqZkF2SHBMdDJHenFxZVdnbUFkK1pCTjBiM0JXVmZkVWFCU0xu?=
 =?utf-8?B?SmhPTWJMdm1aY2pTck05WFBtWStGZkExR2JiTGtTaFEzREFPS0R6NHdPdGpk?=
 =?utf-8?B?VUNRMEZlSTdxOGd2K2lzVm9kUU9sc0I4Uk15aGxYVFN4Rzd5dE5uVFdSWTc2?=
 =?utf-8?B?Ni9nMkdNK3ZHNWZCS1MvVEdyOXNxdnpDc0NJbUxZZUcwV1VKL0dHVzc0VDRQ?=
 =?utf-8?B?TitIbUlrSEdSNXV5UU56S09IZElYSXh5cDhrSVg1Zy83TzFSUUdtV2pCR3R6?=
 =?utf-8?B?bGx0NXlreHhZSmhzZWorUTdoNFYzMzdRSFZ0Z2xEdDJ4YmZMV1A1Mm8zbFZl?=
 =?utf-8?B?ZTFnOVlPV2NpcFkxTGJGeS9KekVNaSsyRVMxZmxRSUQ0L3E3bnREalhvVXBQ?=
 =?utf-8?B?ZDl5N2tOMlEvU2xodGUwWGZNeFA1S2RzaTd3b1hDVmdTTG9nWFRBK094YmRB?=
 =?utf-8?B?cTIvNlVLdG54ODExRDFCR3ZvMlhJY0V6LzRhTzBPMEIzc1JvUnVzZHV1VzNY?=
 =?utf-8?B?TFh3dzQ4V3c2dU1DTW11Q1Y1T25aKzRPR2creWpUQ1hsSnRUalBzTjhydFRU?=
 =?utf-8?B?V0xEQ1BwK1RIOVU1VkswSVNRWWdBZjZCeWxsZ1JqMUhvK0hrN2NYMWNCdXpV?=
 =?utf-8?B?dVdneGpxSkVuOGlreUdKUjF0ZTBkb0IwSmV2UDZ0WVhmajJNTG1IWFdRaU5R?=
 =?utf-8?B?MkV6Z3FyeG9ValBJNmc4U05Na0orMm0wcmJnb204bGdFOVlMTFZsSHdqNXBT?=
 =?utf-8?B?WUFBeXVMRGphenhWMnlBTU5hWHFVZmkwcXRZV2xwVFR3c2VQcWlUOWlaQVR1?=
 =?utf-8?B?MWZLK2w4YWU4NlVBNmpTeFphVHdncHRwOEVTY0hVNG0rM2w5OVRLWjdtNnFl?=
 =?utf-8?B?RjErKzlhTUFJNHRwVU52QjdhWmxBS1BlQUw4d3E0Sk9ZSEI4ckVUSzNvYnRn?=
 =?utf-8?B?WFhMSzhRU1ZzZ0c1UUFKNEJOcU1wdlE3UXlvYXZNNkFBNHlWOXdKeVlIMjBR?=
 =?utf-8?B?bWxEdFRSNDFCNjhGNFNDbWRaS3JsVjJKeUNsYVFtN0dTL0dJbVI0T3BFL0JB?=
 =?utf-8?B?cm9rSHdQU2dFWmZRZXpweHloS0YvMXhGZGpVWjVyNUQrNGFDN1ZJYk9CVzd3?=
 =?utf-8?B?QWRMcjI0R1MxbXVjMkgvK0ZuRWFNaDl4NkRmUzcydWNzWStKUzc4V3Zsc1Bh?=
 =?utf-8?B?bHl1cTl2K2Z4UDhFSXVXeDlneC9Va0N2YVgxTGUxaVR6WGVURlpYVm1QYysv?=
 =?utf-8?B?Q0xyeW1uNjVtY0srYVlVRTR2NkVJbUxtR2kzQi95U0pGZ0Jnc2kwNVFzbWRz?=
 =?utf-8?B?L1lnT0hkaFZKWFVsKzAzNGhXTmViQWxxdE5LY2lQdU9xaG9QcitObVkrOWc2?=
 =?utf-8?B?Sjh5V01TQkxoMFdPS1ozQ3dhU1FHZE52NjNLNmtqaEMwRmgyanM1N0VISWdW?=
 =?utf-8?B?L01Ka3cxdzNEZEhHRmEvQVNwT3F5RnNRWWxrMURhM21NRUMrS3lZN3luWmho?=
 =?utf-8?B?K3VDd2NSNDFXY1d5alpXY2s4bnBKRERtY2ZUUjYya1h3STBrZXdZTTFsQzJC?=
 =?utf-8?B?bzJUNHlJbGVDaFF6anowM2syYW1KVzFJaWltNWlIYlZQakd5UWFQQlVTK0Nn?=
 =?utf-8?B?NmJzcHJpNWRSNjVnNVArUlJ1OHNpYVB2VkkrekdRTHIvUXNhSXRtYmNOdE1B?=
 =?utf-8?B?c1JHWUxwMGY2L2pHMVA3Q3o2T2VZZEZLcEhJRjYyRUJYSGIvb055UzlIazZF?=
 =?utf-8?Q?GzZ3u/yrEpWGuZmNlUcIJD4jl?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41543ff0-324e-4254-c086-08dd17699a3a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 09:20:48.4162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ySygm+eyj4LfkqNLAxAo0LSly36K8zKCyoO6I5SP9flxSfnaTnPEn+lsCd7XuFw6Fs67fEL+gCmfc2pGtrE5tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7203
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 08 Dec 2024 09:20:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17372

Hi all,

here comes rc1 for the next isar-cip-core release.

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/archive/v1.6-rc1/isar-cip-core-v1.6-rc1.tar.bz2
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commits/v1.6-rc1?ref_type=tags

Please test so that we find any remaining issues and can ideally roll 
out the final release before the upocoming holiday season.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


