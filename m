Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81397C83000
	for <webhook@archiver.kernel.org>; Mon, 30 Jun 2025 06:18:56 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.5])
 by mx.groups.io with SMTP id smtpd.web10.32874.1751264329937562670
 for <cip-dev@lists.cip-project.org>;
 Sun, 29 Jun 2025 23:18:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=nrgLWddp;
 spf=pass (domain: siemens.com, ip: 52.101.84.5, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HN9Lspo7gZln+WOK/rix6FAhcKlXOwcR9eW+vL9srOUdVALQnQQ+VL/aCl0zzfKXy7z6qwZZSOOG7wxPHaRRkYOFCa5yVmgceSmzhcyL4YqkloWw/Hfr7Z80eRm0DuqbD/54Uppuw+uqL8zqjvuajj15r/fIjTA/Byu2moIPBja1FI5ujNxya36xwN4nDacWQx4RlaS4WUbhm5F8t2NBnSC1j2BYTDagyV6ll340RQi305CDOFAibF3nNn0RCxlRx3l9rqp7cE0+/39NhRHOks1SQfw7PTcpPZtSewKFdJOo9YHiUvQqSKMy/4XmyvWJ9Y/4jE1pvPWDrfCZMGiS+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPuvuxYXY9BN/JRLRmmZ3ND5U8Nd1k3PIxdNQkVTEf4=;
 b=KknTAXDEhRtmXNY3AGv7CPm/TYyi9Oo5LJciGOp65m6IUfNbVvWcqFSwyIYy4nqs5/IBwBX7pST19ILDEpW+vJnkyB4BdIZcuSdhiuBtbGiBq9N7XH3XycKaX3o/8scr8iFB0wSvpMj51GI+Ak74P4lzq3KfDBaUmaCruIdroy6vyAztetqW86dODC5K2fX4IRyhTrXs7EqTAUxUoLetBtv4NtewPVPgh5yhqGcor4HlZWPY47lQCOZuYI0L3l670kzbzBpQlXGHFBJCkQBSy265GkPbRa/CyH9xm8PfD9bBUE40d4OudFQ7alAwwN2DTnPW3N3VPDEfPHjWr9XOPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPuvuxYXY9BN/JRLRmmZ3ND5U8Nd1k3PIxdNQkVTEf4=;
 b=nrgLWddpxLXOVe/+z9+wf7deVV9ULrTRAwvdUci2BiI9t3nfRZMELrQ2TaY199e+woqLK+ApkS28NtelYnm5AvdxmeSQM3xaYINDqZZQXKK0lLT8LQVDVDN3TuaFx02wGsV7F56q/e7RS/PIRZIGyvsEYe0KjdTh0Be9i/hL/FRInA2bJMYXu3pmj1NhaBKxld9AKBuA5ZXp/wp2AMDbcBSoCmIjTVTeAfvNFJjxEf49Joph9e2j5EVlhqfgU116eWlKo+LKo/TgqQatD04ZXpUirrbnnCPwPwv25jX4QMFtPjLv/hJyD6tYDUVEZbVJs4+mcmY82lT0UcltbZlRuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8081.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:111::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Mon, 30 Jun
 2025 06:18:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8880.021; Mon, 30 Jun 2025
 06:18:46 +0000
Message-ID: <4354a786-359a-478e-bf25-fea8e35eaa61@siemens.com>
Date: Mon, 30 Jun 2025 08:18:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/4] initramfs-crypt-hook patch
To: Claudius Heine <ch@denx.de>, cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Heinisch Alexander <alexander.heinisch@siemens.com>,
 Cetin Gokhan <gokhan.cetin@siemens.com>
References: <20250626-initramfs-crypt-hook-patches-2-v8-0-46f000788686@denx.de>
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
In-Reply-To: <20250626-initramfs-crypt-hook-patches-2-v8-0-46f000788686@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8081:EE_
X-MS-Office365-Filtering-Correlation-Id: ec41ce4e-ca0e-49a5-2102-08ddb79df8a7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SW1Nb3VTOXcrNXFmL0NReDFzMzhWYTdMMlkwUEFVTnpYeTlYbVkwRWNXbVl1?=
 =?utf-8?B?WmlYV2ZyWXQvbXVOYmg1Z211ck4wdHVvTzE0ckVTSnFFS09jdUIxWVk0NUlt?=
 =?utf-8?B?ZEdOMG1WYU0zaWg4TWtCS2hIZXlqb1pvMVI1cmF2UDVFZUxPQ2pmczZrVW1M?=
 =?utf-8?B?K1ExYzNvcW5sY0xEc3kybHFXZENHU0ZWTWc2QnZGOWIxdXJ2UFlBZ1dmUGxh?=
 =?utf-8?B?RURjdUVWMW1JNEZLcU96RlJsSWNadFZyUXBpQnh4OXhmZVUyOUQ5SGtKU0VX?=
 =?utf-8?B?OWV3VFZRYmdiek1vc2lKN2llM25aMkx4aENyMnpaWk90NVVSdUNFRzd4a2Rz?=
 =?utf-8?B?Wlg0MjRsUUxzWHowS2p3SXZGbnNqUzV2TlZDbEJscTNsV041VFlPR0VVb01I?=
 =?utf-8?B?c0plVjJTQVFCOGFQYnJxb1BGRll0N1M2OW5qM2NqZzk5dVVrZE44aldFbytM?=
 =?utf-8?B?ekd0bE41cS9MazdwVzMxMmRlRXIxNU91T3Y1NEJlN0dVbm0vaFNVQTFCZ3Rr?=
 =?utf-8?B?cmVqK3pYSEI4QmVEVmNXSUNqREFvYjRGWURFaEN6UWFNblBvRDY0OVZWUjc1?=
 =?utf-8?B?UFdRR016bGpmMzFPWXFTajBXYlpJajhZT2U2OUNQZ21Gdi8wZko4NldKL1VL?=
 =?utf-8?B?Z3JRazdxdjZ4U2hSd3JJS3dzcDMyOEdjK05xdUhvc1cweVlCaS9JMHRpTHFY?=
 =?utf-8?B?UzNwbW9sL09XSCtuNWg3MzlJNWVaWHRQclRFWlNMLzA5Ti8vQVVNYWRXM3Zp?=
 =?utf-8?B?VWUvZEk3a3ZRcHo2UnFyZzJOZkVpeGpjV0F4S0RyektyYmhVRW4zS2VUbG9Y?=
 =?utf-8?B?Zk9majR4L2hOZWthaXBGTmpWa1Y3cTUrcjdDUnRENEF4NjlkRUNJSkZDUHpS?=
 =?utf-8?B?dlBmMUtGQlMreFIxQWt2ckZtemFLVndEeW9CS0ZLTGlCZHExckwzYmN4TjJN?=
 =?utf-8?B?cUdIVS9rQ2Y2WHZzQnNnZG9pNXhadXV1eVQzRGxsb3U5ZXpVbEJabUFNQngz?=
 =?utf-8?B?b3BleEFPb0hGS0NTUDkxTG1UUDlqdktMaW10VmcrdHkzVHlxZHdJT2ZxYkxT?=
 =?utf-8?B?SHhwTEwxWkFnVHRQMUliY1ZpbWxwZzI0V2NsWHN4N2FzRGhBWEFReGV0VnlJ?=
 =?utf-8?B?TUJCQXpVNVNHVW94OW05M1A3bEMzQWRMTjMrR1lwOVpaWUxibTZ0bU5qT1lo?=
 =?utf-8?B?elVuTzg3ODg4SnI5N0kvUmZ2L05jRnhTOEhqNGNOdGpJVDNtSFdBa0JpRnls?=
 =?utf-8?B?eEpmWWhGaFJXdTBiUnBJd0ZzMjhJZi9UTHVuU3IwbmFVckhkeHVuMHY1VnZw?=
 =?utf-8?B?dXh6eWpWVXh2Rm9pQ2V2S3BPUFA2THNwTXJidDVvL2EyRnVYTlphY1ZDQjZL?=
 =?utf-8?B?cVh5aFFKNURld2hxREVwSDdvMlJZa2NOM05adENoc0xmM3dSQ25jZk52TFor?=
 =?utf-8?B?U0Jvc0dPYnpXMGVTaitWRi9kZ0lZNFg4NXFBakNtbjFVMkhvY0tZOXNCQzYz?=
 =?utf-8?B?VkViTG5mNWxpbWNSVDdkTmtNV0FoTzNLbUdDb1hmVGlhZ2RHR21qSURaRVRE?=
 =?utf-8?B?SU1Id0dLR2RpVVRGclBreWV2dldYdDlDSnRWV0ZYNW1qRldUOWVaaVg4SzVD?=
 =?utf-8?B?eSt2UVl5Kys4YUFHSis5KzlFR0lKOWpqT092c0xlOXF5TjN1eTMwZEZOZVJt?=
 =?utf-8?B?R29hcENscHRIUCswcmlzYTNVclJ1V0RVME03cEh0OTBiVDNZN05YMXRtTVlB?=
 =?utf-8?B?cHhEMG0zUnVuNEd1VUxtOVJYU1JzTkhkL1ZjVGVwL0R4Tlo4MSsrbzY0YWdT?=
 =?utf-8?B?NURQNFpyUWJSd25aRHdjNHdEZ3B6NmFsa2lka0l1QUozekVUVDV4NDVQZ2VG?=
 =?utf-8?B?UGV0K1NrUGE1NlRveDJNN0JrRkZKK2JHbCtWdHNGdFJRRTNNRGNNWVJLallO?=
 =?utf-8?Q?3J2nd7YNRyY=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OHhRbS93ak5GemwxbTFIOWFKakZMRk1jVXVSckc4SFJPOGt1cnY3NUtLSVB0?=
 =?utf-8?B?N2NyeUhQK1dvMURNR1BOODBKc052cG5nMUtnVGkyNDk1M0JNQjd4cENlUTZv?=
 =?utf-8?B?RHhEU2FBN2FhWU9wd2IvNC9iUXArbHZZbkhEd1hmcCs5a1R5S1hIaUorRUly?=
 =?utf-8?B?S3JtcEJHcmRLWVlBRlZPQnd1cWtnVXIvUkFScWJjWnFVTEFoMk5pYjFZQmR3?=
 =?utf-8?B?emQ3ZHVzdk9qVWdTMDhvZzFURTA2bFJvYkVQTE1yOHI1d3FXc3JuWmJnbTl3?=
 =?utf-8?B?WUw0L3hudnJYNFlrR0NLdzE5THhIK1NWcDg1dTBGbmx4RlpLQjVnZTAzYzVm?=
 =?utf-8?B?UExkalVGNTVIYmlLV1BqWG9kS1pDVzN5RWlxdnhOVkMzMngyeTBoeUtCd21X?=
 =?utf-8?B?TXZIeWV4R0lwemFTZ2orTEdWM2cwUllEQzdUbmJkTUF2bjJ3dXhyS0I5N3I5?=
 =?utf-8?B?cklUZjgyMU01Y3R1TXlwTGNybnBKQ3Q0L1ZxQXUvRlF3Y0VKbWFTS3hVM0hC?=
 =?utf-8?B?SGhOeTZuYkNBd0hET2ZwemhTV2psVnhUREIxNGZBaUlMamlEL2NpT3gySDE2?=
 =?utf-8?B?RHNiRm5lUk9PaVRoQjhkM05uU0d4SFpNbUg5eEJ6UVA4QitsL0poc1VBRDhs?=
 =?utf-8?B?U1JEb08rSHNMSDVmQlJYYlhMeWdaaktaSk1MR09aUFBXUy9LOENOUmxhTlJI?=
 =?utf-8?B?cjRvNElIK2VsL25vM2dWeWZ2bkhkbnI5WnViV0RScHduRXZQLzMyL3h6eHZx?=
 =?utf-8?B?WjQ3SVF0VENGb1luUzE4K095VjJnckZ0UTlTZzVkdWprYjZ6ci9Dc1JYanFK?=
 =?utf-8?B?VEtzeFNVcmpuM2RBSGNzbDk1TFg2Y0JJdFQxSmlFQWxqMHliVGRaYkNrNFRT?=
 =?utf-8?B?TTJTZEtnelZiazdUOEtBV2QxUmxrUzNlVnJxVndqMGVMNWZmMGFHNGhTbkJy?=
 =?utf-8?B?dFp4aDYrWnVTL3U0WUMzeUFTMGg2VlFYMkVwWDRFUVhTSVRSLzdqdG4zN0tT?=
 =?utf-8?B?K09kV0VEU2kxUWorRWxOQUlKVTBPakJVMUo0UlpEclFxelJRNlczSmUxTlBQ?=
 =?utf-8?B?Tkp3elliTkk1QStMMktrZVBFR3RjMVcyekx0WUlzK0V5TW9WVzc2dit3cWow?=
 =?utf-8?B?cU5hcXRvZUdmVmhYaDFuaVFkbnc4Q3VtMy8yQkVOb3VPV3Uvdnp0QkhHWGVE?=
 =?utf-8?B?STVHT3ZPZncyUHhCR2h3SFFDR0NJTmoxcnNGNHFLelNQdUR6bUJYTkNDeGFy?=
 =?utf-8?B?alRGQS9iREF3ekJsTTVob1QvUklLKzNLSFlBMUFoZUxqNjRaMlVXajAxNjB3?=
 =?utf-8?B?dVJvd0JaRHFibHdEV3pmcXV1MFJrVndlMmxFd1B4THQ0dlNrb09DUVV5U05K?=
 =?utf-8?B?THdDb0VTSDZUUDRmZU9XcDVOQXV6MHh1dkw2Vnl6dHRJMk03cElFZnhBZlRi?=
 =?utf-8?B?N01tb3pIVmZsNnBjRXpnVk9RNVhNTWZ3MGNYVGx5RkUxRmFnQXZwTkJZSnV5?=
 =?utf-8?B?c3FVT0RmOVBMVUl0MUIxVnExZHljQ01vNjZpZzZrTlBES2x4KytEMjNWNmlU?=
 =?utf-8?B?eDVSYTE0OVZ1ZTFhUHl2aEJxeVJYOVgrcEdCc3RKN2JvUXFlYzhaS1VGbnZW?=
 =?utf-8?B?T3BXdHlkTHRWR240d0QyRXNVUzhBNndEdnpDZ2RQNGxYY1UxL1hMcnZzZmNT?=
 =?utf-8?B?QWhjZk53VTdSUDA4Q1B3VWJtZlJ2Y3VWZDEvM1NHRU1wblFDenFCQ2QxN1A1?=
 =?utf-8?B?WVJ4VHJ4WmYrU1p1R3QrSXFCTEdGbHltSlNvd1N1ckF0U2o4NmRFM1N6UTRw?=
 =?utf-8?B?cGhyQkdxakQxaHRiQkZhcDQ2UHlwWEIrcmlsTjVWanpKSHZFQm1wT0UxV0JB?=
 =?utf-8?B?MExJRlFiMjRreEdsWDNDQVNJL1dDZHpEUHZ6bTZHZExZcjd0QTN4VEZleGRR?=
 =?utf-8?B?d0NnS3dEcE9UdjZ1emk0UGpqZ2NNSUFlVTBxMVZpejlONjd2TmFKTytDbTlN?=
 =?utf-8?B?UmJEWncrdmRhNnZhS3lhZHc2Zm1LbTd6MVBuNVB3VTRBOWJWcnU5a3VDSXJ3?=
 =?utf-8?B?dmJrKy9ackJTVG5pNVorbDgwbThQN1AvMjJnajZJTEx2Z0ZPUDFDd3p4eHRR?=
 =?utf-8?Q?im82eDUnRe/lNoiFqlSFJ1Wzl?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec41ce4e-ca0e-49a5-2102-08ddb79df8a7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 06:18:46.9009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCTQvWCz3MqWNcg8rg/6CXR2njSam9EkKfgQtB5HGbM9lnsu/ZNzJfm/4l/ciyC7qq26HfYE7RQhrc5EjrL9OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8081
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 Jun 2025 06:18:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19254

On 26.06.25 11:09, Claudius Heine wrote:
> Hi,
> 
> here is v8 of my patchset.
> 
> Kind regards,
> Claudius
> 
> ---
> Changes in v8:
> - Rebased on next
> - Added documentation about the power fail scenarios and the LUKS header
>   example.
> - Link to v7: https://lore.kernel.org/r/20250616-initramfs-crypt-hook-patches-2-v7-0-82dc9d0dbbcf@denx.de
> 
> Changes in v7:
> - readded tpm2_createpolicy for clevis
> - Link to v6: https://lore.kernel.org/r/20250320-initramfs-crypt-hook-patches-2-v6-0-ef10c11cad94@denx.de
> 
> Changes in v6:
> - luks formatting of format-if-empty will now be redone when if it is a
>   luks partition without a TPM2 token, this makes it a bit more
>   power-fail save
> - Link to v5: https://lore.kernel.org/r/20250313-initramfs-crypt-hook-patches-2-v5-0-fc62d4a2ad29@denx.de
> 
> Changes in v5:
> - Switch to use TPM2 protected password instead of static initial
>   password for encryption
> - Link to v4: https://lore.kernel.org/r/20250305-initramfs-crypt-hook-patches-2-v4-0-4170912e5261@denx.de
> 
> Changes in v4:
>  - improve documentation and commit messages
>  - reorder commits, to put re-encryption recovery up front
>  - extract static temporary encryption key patch into its own
>  - switch from lsblk to blkid
> 
> Changes in v3:
>  - Rebase on current next
>  - Extended `noencrypt` documentation
>  - support clevis tokens for re-encryption recovery
> 
> Changes in v2:
>  - Added more descriptive commit message
>  - Added more descriptive documentation about noencrypt option
>  - Fixed typos in documentation
>  - removed unnecessary setting of /conf/param.conf in initramfs-crypt-hook
>  - added re-encryption recovery patch
> 
> ---
> Claudius Heine (4):
>       initramfs-crypt-hook: store initial encryption key in TPM2
>       initramfs-crypt-hook: add re-encryption recovery
>       initramfs-crypt-hook: implement 'noencrypt' option
>       initramfs-crypt-hook: add 'format-if-empty' feature
> 
>  doc/README.tpm2.encryption.md                      |  57 +++++++--
>  .../initramfs-crypt-hook/files/local-top-complete  | 127 +++++++++++++++++++--
>  ...ypt-hook_0.8.bb => initramfs-crypt-hook_0.9.bb} |  13 ++-
>  3 files changed, 171 insertions(+), 26 deletions(-)
> ---
> base-commit: cad5026bc860a2eefb828e03a9205ed8803cd958
> change-id: 20250305-initramfs-crypt-hook-patches-2-9cc4a027c89a
> 
> Best regards,

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

