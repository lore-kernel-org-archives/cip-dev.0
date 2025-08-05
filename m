Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9444DC87FCB
	for <webhook@archiver.kernel.org>; Tue,  5 Aug 2025 08:56:24 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.17])
 by mx.groups.io with SMTP id smtpd.web11.17204.1754384175488964306
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Aug 2025 01:56:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ZT15mQto;
 spf=pass (domain: siemens.com, ip: 52.101.84.17, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvyBHoW/J4W3sXVm0gzXDn7/zUeWWr3/I8P1RaYaxBK/pyamqVLYzr9S0l1P3nMXfNbuBfCPRzQbrRuv9fuuwjiRlVJIC7Bpae8+Nk8OGge5MJCU6TEvqlMaUl/b6MmomKa+Mvgj2I4OeTL4MxkGim13PR53pywhlmKODafgc7gdb1BKKbAkE6QOBbotygyBbN5bjHzVn0NxF+PT7Hp5Uh+ihe18U8fgIAmzcr6y+eVwVc5PyI245E0P251iVh02eDWBPq5P4scLre4YVDbi7Ix/G3rAJ3vbiI6ux/n0T1xVa7nv7KVHGF8G0B69y02iLGOXOy+DJX5Ev/2MJiCk8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aiFCrH8LQgdTSvOyPzEZo6rw5EdB8cO09SMTuRkZBH8=;
 b=kPpYe0asZSi+/UQs6R57eXenpboKMlV2pNDQJe5RwGeJBxptOyDy7c+tPCRqZ2UQvzKGUrttsKkPMVeo5wDOV3P0rZ/QmTwkw+H3Th7lG4ChS5EUUgNPdm8db3gbYy4EElfCn1JllIlCOFW3FIXBZ4+s0/2iPvfcFgpYvK4IzKMqSPVGCNKN6mCuaocFNp8jkU4i2yxtzGEvTWnkKnbKkF6V1LWgopYuqAbPZTUF35n15psHokRpfhkLrFHF8MHJnFTceaa/V13K8naey+LBFagAAYtC2b2KRYfIve7nGkPNRbVb0S0yaHZUizQYXjhybId6RkHcgIBkrtJ5MS8f9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aiFCrH8LQgdTSvOyPzEZo6rw5EdB8cO09SMTuRkZBH8=;
 b=ZT15mQtoOd+gYu2DX6m/rvRxFEJd4pG57h1WaVKxbh9NwnSq4rPrWu0G28JQKC7PXWw+Dipz7O12rK5ik8O0nTd+R5CaKORyJ1/ik8Xw/Ygl+5YpG4zaG7bLJ3HXwEKf+Q9okau+T3fl8fGBJn2KEb+sW+5vsJOCy4FofezVD2ASj53xg0gos4gtfX5sservF0d67pBm+zMpTIF775r7f154NeFCpFaHySf2dbIFIw2MF1NkIf971Z8xfu7qa4yYuaT4zyjyLte0hd/gCni1Kaf2L+WXR05dSh2csAdB8Rc3AXXjwAtalyd1/pk4vLeYZZwEkGsQN3E0jq1JcOhyvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VE1PR10MB3887.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:161::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Tue, 5 Aug
 2025 08:56:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 08:56:11 +0000
Message-ID: <658285fd-72f3-4e40-8f00-eb780091e9cf@siemens.com>
Date: Tue, 5 Aug 2025 10:56:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 2/5] zynqmp-zcu102: add setting
 for kernel image and dtb
To: Hirotaka Motai <hirotaka.motai@miraclelinux.com>,
 cip-dev@lists.cip-project.org
References: <20250718100926.3151777-1-hirotaka.motai@miraclelinux.com>
 <20250718100926.3151777-3-hirotaka.motai@miraclelinux.com>
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
In-Reply-To: <20250718100926.3151777-3-hirotaka.motai@miraclelinux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::29) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VE1PR10MB3887:EE_
X-MS-Office365-Filtering-Correlation-Id: e30583c4-74ec-485d-7c81-08ddd3fded2a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UVlHMFpzQ21JMXM2NVJ3ckN3dlQwSjRmcU5GVWRhOXplU2NTT0s0S1J2b0NF?=
 =?utf-8?B?RXpJN1BQb0tCbVVBUDV2cU9CdFQ0bGoreHRQUGkwekVMd251UWJVdmJZUCsw?=
 =?utf-8?B?RXZyMUxhUG96YmZHQisyM3dIdTZhNWhvL014M1lYZi80UCs0eXN2Wm5QMVdW?=
 =?utf-8?B?S3V2MlhMVCt1a2MwZmd5azhOdFpKaVJsVEYvcURIYUtaK3JRSy93NmFzUDZZ?=
 =?utf-8?B?bytXd1gxZURJandQa1N4czVJbWcrbnlHOC9OVFdTSGVHR3BmQWRVeWZNdFpv?=
 =?utf-8?B?MEhhZFRlWVZycEMrQnB3N0pqOTF6ZWcxNTB5WjR3K05mV1ZrbEsxK0h1YWcy?=
 =?utf-8?B?b2JVM0xPRGcxWmp1RHE1MndLSVk4ejkvT0xySDQyQVZTR3JONnB5aXNWM08v?=
 =?utf-8?B?Ykd6VlJENzczQm5BSUJPRG5mNXpETitXMEkxbkR0UGV6Z0JEVEZpODNyTFlx?=
 =?utf-8?B?ZjVvMjROSzIxWXU5OVpsTHRQa1d3SVczUjJhK3E0M0U4bm1sV0x2Q2RYd25J?=
 =?utf-8?B?V2FoZGxXcm1tZlpGR3Z1NmVISUhZanNodC8rNDBodzRqOTd1MHJZdUM5Zi8r?=
 =?utf-8?B?azlOQ0hpc3g2MU9wTjRaaTRDbXBBZnhTQkZRb1JWNjlhalY4aTg0MGRNMjJ5?=
 =?utf-8?B?ajl0cmF6TVFZM1o2TVh2RXJHL0VqbEJjQ3JMaXJnSDdHWlNWMVhScmlXWmln?=
 =?utf-8?B?bFpGTG1hb3lEd3hhWVNRejBhWVB2cGZTRFE4aDJBVWY0M1NhOWxZNmUvTkpI?=
 =?utf-8?B?azY3UUlDbW9OSHU5Nmp2eEVKbjBha3FVZ284ZVpjQXR1NzhwZWJHV3BMTnVy?=
 =?utf-8?B?TWZQeGNLWTE1NStDanRTNEdGbzNhajNLWjVaYm5Pb1ZzOFVKbkVFK0FhekRx?=
 =?utf-8?B?T2lmc0VNMUhLRFk4dzQ5dWNNdHRia0YxNzQ0YWRZNzAzSmxvYjd5TU9iQWpB?=
 =?utf-8?B?N1U4dEVad2RGL2ZhbEFkdGFEckxoWk1ydlBia0E2T2ROQlVNcVQyZm1pMVMr?=
 =?utf-8?B?UGJ4NXYySUVaQ1JtemlQY2FJVi8vRERnWjJJWTFZQXQ2eUNvbkluSzkyd01w?=
 =?utf-8?B?Z1NEZ3FIWEdQT0RhNjF6T2VaQW1kQ1hBVnlKRS9hbGptRjNOTWxvSXJkaEdq?=
 =?utf-8?B?VkpoSndDREdBRnNKWUh4OStzcm1Gc3FoN01vNDYxenBtVFJRWXhkTVB5S0Fh?=
 =?utf-8?B?S3U5NXRMajhpeXFQY05XRmNDWmNLTlg1dG1Rb1BwZjBUcThTb3F4ejZ0NHM4?=
 =?utf-8?B?QUtBWDNFM3RRMFFaU2RxN1prMGttZTF4Q3N0cCtvTGo2NEpKelVodXUvOGE2?=
 =?utf-8?B?K1llMVByTTRsVklKUUEyN0JpRUttYVRNcWV3SDRic3pKZWVPaWJQWFZBTDJG?=
 =?utf-8?B?b045KzdMejVhcHhsVlFUZ0NvdUFxTVlDMjZFMVJHSEJXZi93ZUxKdHU4WVVi?=
 =?utf-8?B?TSt2NmFnejV4RWdPais4MHlGK1NKeTQ3bGpCT3BvM2JxdWxUVGF5RjROdy9H?=
 =?utf-8?B?N2x5T0V4S0pQYnprL0dYRHF3UWhoakxuSHV5Q1NkeVlKSmlwL2h3Q2Vyblpm?=
 =?utf-8?B?eFNqMXVsT015RGtRVlR6ZUxSTmx6bWdFYTFIcjdlUFJONzl6NjFzVkRBc2Vx?=
 =?utf-8?B?R1JxOGJxd2g1ZW00cW5zVjRKVnNDRE95czVUVlg5Q01TSmRmSElTMlZGM29N?=
 =?utf-8?B?bUhVL3NGTDF3YldZL1RqNXNMSS9pTVZOc3BTTmVkRWl5ejdUWFdWcGUwSzRU?=
 =?utf-8?B?VnJsZmhMajl1Wjh3MGRDKzVZZW8xWlRlQjl5cFRtTThnY0x5MFprUGNYQWRD?=
 =?utf-8?B?M0lUakh1OURwdkFoQ1RKc25SU1VoSmYyOVZadm9zdzBwL2RQZ0cwd0Y3Sy9j?=
 =?utf-8?B?azFLMWEzbnY1NGplZ3RpNjIrOHZQcXY3LzFjQmVPTFhObDlFNkNSWjRNS25u?=
 =?utf-8?Q?c55KXvBo/eA=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q3JJMzhEaEJVZkxrclFoWWVYWk0vbkJWc2Q0KzlvZmdDbXdHRGFIcVB1MFNB?=
 =?utf-8?B?ejBPVFVQelVpMEpnbVFjVzZ2YkQxUnFuQVdGZnVzRmd1cnBEOTlkMzdwdU5R?=
 =?utf-8?B?USs1RndzMVVSMzB0VHVGdGVQQ3VCYlpWYWFVelpFS2FqelMzamxHMUlmcWFa?=
 =?utf-8?B?cDBKK0pBWUFjdmJIZEYxWnF0Q0dtZkYrNlROSUxHakVMTlptVFoxQk5vSDdL?=
 =?utf-8?B?SnlZOU5BS1NCZ2hydGRYVFdwOURPMnBWR3NMT2M0dkFRbmZzdFRLTVUzQmNp?=
 =?utf-8?B?bm92K2kzYU5YYm1MaHNSYWFabTVYTUJWMU5KbDJoN2d0NUVDQnhnYlVoNlBj?=
 =?utf-8?B?MndtaGtheExlM3VUVTlaQXYrSG1WZUZZMGx0OEFZcWlQVXRNWjRmTGg1bHdv?=
 =?utf-8?B?eWNoNmZCeWVUbjd6dDVkWGdYN2dGcUExT1A4bXpYdVM4Q1h5SVRGaGU1WWRB?=
 =?utf-8?B?NmduTVhMZ2w5S3FmNk00ZkYyRGFxdXRzc0toUUxabUFHNCtsekFaVWNBRm96?=
 =?utf-8?B?QXZmUGdpbjhPU25mM1J2b2F0TS9yWDh4MmxsYkRSeFhLVzFCV2ZiVUx3MXFX?=
 =?utf-8?B?NkZHNXRJNzlmQUFaRElhaW4yM2l5aHduSVJCQ3M1TElNUHNDSmJKMXZCcDVw?=
 =?utf-8?B?aW40cGUxWUxRaTZzOW5mU3MvcnNaU3pYS3Z6THJDbTVxTHl6Q2JDL2NWQzlU?=
 =?utf-8?B?a3NDOWZrbkwyb3JWR3ZIZzI3M2ErMUZ1YmEzVjFiaW5SbnJUUHlZczF4VnZ3?=
 =?utf-8?B?NTRucFhCYnducUMyUE52TzNOZHQyWkFNNm9lZE0wTVJLS1ZIa3VPRk1vOHBv?=
 =?utf-8?B?QzBwTkc0VGcwc2s5UzltcmxCeDlGVG5DUHY3NzhzSkZDa00vQUJqbFRLZHZh?=
 =?utf-8?B?NU1aL2YvTUc5UWQybXBBbWptcHRPdVdHYjFoblowcExKdytHNFZJejY0dSt1?=
 =?utf-8?B?SSt6WXFSTStWaENtWlZnU2ljNUtZbW1LY3htOTBmbUpqQnAxa05PVlBhRU8z?=
 =?utf-8?B?dXY4ZEJWNFZBTHpKU0p3bmkwWkdPcVk1ZGR3UkdmSW56TUF4eWd3dWRaT3lr?=
 =?utf-8?B?eGplQ1JLN2Q1WFYzQXRQU0MrZituV1E4elJ5WWdaUG81QTVDSEZzanpLQjM5?=
 =?utf-8?B?aVVVV2FJMDdCaEN1L0dwU1hWS0h3MjZyTE1DdndFMGZ2eUxvV0k5emFldGFp?=
 =?utf-8?B?UXZkYk1ydVBGaDVOeDVqVmp2T3ozRmRqZHFUS1BTWnFHb2hPSU8ydjFUYmpP?=
 =?utf-8?B?SVI4OEdpZXd4bWhXYVh6d0RFYkcvRXJHM1V4N054WXlXM0ZnMG5ydlZKV241?=
 =?utf-8?B?QkV6LzNnMzZ1U25lRVJ0K1lxVVhLQ3hJRG5EcVFkU2x4bm1FcCs3ZTB3YVdY?=
 =?utf-8?B?cyttTldEZ2lrRy9XNzV0R0pXMmhwY3huT2tmLzAya2NCRDR3SnEreUhacGFz?=
 =?utf-8?B?UlcrMXc0MlhCSXBoSCtuMGhyRTg2V3lqRXA5bm5xZDgxWTZjRThUYzZ0ZnB2?=
 =?utf-8?B?Z1kxbHhGZTlSeVE4ZTE4ZnVnVlUvYzhPeUN2ZEFuNjd4QU1FVVpZelVEbnpj?=
 =?utf-8?B?MWphalBMbDIwaG9ra1RueTI5SC8xUWxiaDNpcVJ6VytYL2p3OVk3U09wWVhy?=
 =?utf-8?B?TG8raFpwdktDTE8wRllQKzVVcXE4aWdkQ3NFZ3FzU3krZ20rSkZRMXA3Z3Zn?=
 =?utf-8?B?bzFmTUJWNS9aajFFZmQxMjc3bTB5ZGNJV0c3TmY2cU8xVEtmV0tvbUUxVWg5?=
 =?utf-8?B?bVZYYUlEdlMvVHpvSTc3RzJmblBjK0lPNkoxbFdPcC9oYkRuWWxTWDd0TStv?=
 =?utf-8?B?ZkVkVWVMN1hPR0tPQlh4c1NxbkVhemJVV0d5Rk40WHhDSGw4TVpkMmloM3VF?=
 =?utf-8?B?a0VUYmJxaTA5bnRCRkNCV1Q1VmtrUG56VFFLSE44Nzh0UHBRWWtWQTZuNmRa?=
 =?utf-8?B?Z2QvNzVXbjBNZGJHU29HdisyUStFS2Y5OWdnVHVVaktBcVBJTFNrdWpGQURn?=
 =?utf-8?B?MkhCbkdVVm9pMFovUzFQTHlTUGJFYURZejh6R0hpRXh0U0NTVUM3eUVsdldx?=
 =?utf-8?B?Q20yY1lKcWNtQVR6QnVWeU1IdTNUQXVCN3V3SXE0WUJkeXNnQ2N0U1doa3Vh?=
 =?utf-8?B?Y2FVTUN1TWI2RFoySU5VNFdmT1FFUUQvVnpKQ3R1aFZvRS8rdVExRmUzRG82?=
 =?utf-8?B?dVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e30583c4-74ec-485d-7c81-08ddd3fded2a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 08:56:11.7771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kvvRyXixryNK4BJMYlcfhuLQaIdUDoSsc0YwmyFsurCQADjh3s8Ae4gcywFmRXGmdZp3PE9aGBZa47yk22Fdeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3887
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Aug 2025 08:56:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19663

On 18.07.25 12:09, Hirotaka Motai wrote:
> Signed-off-by: Hirotaka Motai <hirotaka.motai@miraclelinux.com>
> ---
>  conf/machine/zynqmp-zcu102.conf | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/conf/machine/zynqmp-zcu102.conf b/conf/machine/zynqmp-zcu102.conf
> index 4aa1b73ecc5b..b1df5f20bb92 100644
> --- a/conf/machine/zynqmp-zcu102.conf
> +++ b/conf/machine/zynqmp-zcu102.conf
> @@ -5,4 +5,16 @@
>  #
>  # SPDX-License-Identifier: MIT
>  #
>  DISTRO_ARCH = "arm64"
> +
> +# Setting for kernel and boot
> +USE_CIP_KERNEL_CONFIG = "1"
> +KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/ctj_zynqmp_defconfig"
> +KERNEL_IMAGE="Image"
> +DTB_FILES = " \
> +  zynqmp-zcu102-rev1.0.dtb \
> +  zynqmp-zcu102-rev1.1.dtb \
> +  zynqmp-zcu102-revA.dtb \
> +  zynqmp-zcu102-revB.dtb \
> +"
> +

Extra newline at end of file.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

