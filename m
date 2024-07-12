Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3E8C2BD09
	for <webhook@archiver.kernel.org>; Fri, 12 Jul 2024 14:16:12 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.72])
 by mx.groups.io with SMTP id smtpd.web11.8847.1720793764099635589
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Jul 2024 07:16:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=GxY4Ir4j;
 spf=pass (domain: siemens.com, ip: 40.107.21.72, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bhmtS/xdqCRom2udQHJdYWnorDF6HlcJEyZybG6maAR/4l68vYjUhzGpdM5TkvmN5ooysL8EZ78VYGrAPGnvHy0v9Ahn9y6I5ooxUDyIRQyQHl7ifRNEHJFaazrYPdgcjQxj7YH1HY2ATQdUIl3ikGquL1OeRxPqXgcSJFwz0Sx0mGuwO2foSrSRnCy1PanvacutOweJdI35gq38pbsPQLjLEisI0H30qGLivam1XVJG72UQxDVnq0jgYVLOsMtLgXTQ+VIDbk30QEn7Wy2r109PKPWQ3boL0YBqD8ZfXf2K2EUkT3PcPChYzzJkIZYa8mxTVwK4sZEPHWyz97PFKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFETG0pXJMPGBBwX9hN/cVlBJwPE12h658XIeTjLjLY=;
 b=A32N1lHtnsYSvIzwkUgQz1CFtZ27Q5cLs4OVFg4k0jTFqxtFFG58uDLoCVZLZCJyFA5YwEwYlwlZ19tTmXQx2ky01uQjGHaN6RpGvkqVQNz1cezxidy1T2RFBKRZfoAKJQXVT000qLlpGywcxunoMIf7DJIgLdP4EvRY1A7n5RIObaZmkCKnBXg0rTufM7Gzp8vGoqoebUlWhVTSDcDIS2K002ZAL+kBMJ0gBfuDZI3IPmZMuBSaewRUx5sK/on9kSU/Kka3byPJ8Tanv2fejqXYOn4Bz5rvorMkKoj1xEQWPg3tdqZQIhcRgZkJGYhfDa3s+PedPBBEvHmvrjvh6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFETG0pXJMPGBBwX9hN/cVlBJwPE12h658XIeTjLjLY=;
 b=GxY4Ir4jsFQgJjux/ZEPZAdgHdxzcgegrQ2XixKMgzi9zVMqj29HVCGphL1mpEqjopGJYcJxGgItncvVK6I2Vo8EB3MLst9japDmLl5N243O02hXv8RiWAdsv4KzFoS+d5G3yBmnm3cOTZNHay/g+5OiP1z+qNvHSx2APwOUZBrgxXldsr40Mep3fjqeK+ZhZgEmA9Fc6swWe3F/xt/xzc4sb84iBA3WHf71VfNNcAuLcytwr8cqx1BiUVBOiKFEUTuUb51RcQEv50A1eezApJdMcEENE3e2IuEOw3d6FHlQjWm/erFnQi9TVM7jvzLB+9wW9AdI5D+c8pBHIAM8Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by GVXPR10MB6005.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.21; Fri, 12 Jul
 2024 14:16:00 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 14:16:00 +0000
Message-ID: <23950d10-39e4-4ed5-a531-28b7ade848b3@siemens.com>
Date: Fri, 12 Jul 2024 16:15:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] initramfs-crypt-hook: Ensure that full losetup
 executable is provided
To: Stefan Koch <stefan-koch@siemens.com>, cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com, christian.storm@siemens.com,
 michael.adler@siemens.com, simon.sudler@siemens.com
References: <20240712125713.2066512-1-stefan-koch@siemens.com>
 <20240712125713.2066512-2-stefan-koch@siemens.com>
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
In-Reply-To: <20240712125713.2066512-2-stefan-koch@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::10) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|GVXPR10MB6005:EE_
X-MS-Office365-Filtering-Correlation-Id: 715811ed-d25c-43bc-76af-08dca27d27d7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?R21GajVOZnBMRXZLVm5ybjFvak9pMnBhOENVMGMwZkQyVnpka0p1d1ZyUnJ5?=
 =?utf-8?B?bjZGNHBrOXFqMXR3cDlIc1BFS2tSVllnV05WQ20wTlZJd1VRaDZVVzZHeS9G?=
 =?utf-8?B?Rm5MUlJreU5iaFliVGR2dmlscUxwRVlYaTVkV2hBN1RBejAyQ3oyOGMyZE9t?=
 =?utf-8?B?WC8waXlKZkk4Y2VlSm9kMGorb3lldE9YS3JNQlY3M2N2U01nSWhpWFVXNmtm?=
 =?utf-8?B?MXVRS0JCaHNtZmpDU1pYTk5kdExzZDFkanR0UVRJaS9heG5RSTE3VjArM1J5?=
 =?utf-8?B?czliWjZ3WlFmTjNhajVzVk1FQkJqMmsrUzBOaXJ1SHplSGQ4ZktoTlIvM2RS?=
 =?utf-8?B?U2tBWnFZT3oyZkpEVENPaVZORTZlQ09NYVEzZmJiK0kzQm40Q2pSdHlRdW50?=
 =?utf-8?B?ZnA5bGlIcDVjUkw5cExOMm1VVm1FOThna2UvRWJuaDFPSDNCUXZQbStnbXVl?=
 =?utf-8?B?aC9taVU0RU1KalFPZG1UdHFoamM3UGR4d25RUDNrVUhDRitvL0N3eVFtM25O?=
 =?utf-8?B?UE5qZWc5blNWVm5mNW10RDVoUmI0V3A0MWIxSGpJUEtvSFkrWHdJWWR6cVRu?=
 =?utf-8?B?aVh4Y2w0UXJ1QWZKd29pYy9sYWxRNHZQTWpPRGU1TUhaTXp4NVFmbEFGK1BK?=
 =?utf-8?B?QnoxQy9vTWFUd1hCQi83WTQ4d2d0dGlEemRVWTBFclJWcnFtMVBJa29OeU1O?=
 =?utf-8?B?ZkJ5dFVCbytCOWgrRThKM3psMjFXNElMZUlFaGp5M3Qza0pGN1FYTzl6OUQ1?=
 =?utf-8?B?aGxPS09LL09KQk1EaG5wd0NzaXpWc1g2RU55clpMUFNWM0s2cjYrTTFGUHUv?=
 =?utf-8?B?NlRSQXVUMUl0YkFVVVdSZEpuNUx3ajFDUEJYdFN4T3VoMWwrNnBOdDRZLzRk?=
 =?utf-8?B?SDYyNkZKUVd4N1RqWnZXRjIrSk4yY24zbWNNS2hkWmNTR25UUmFnaitZNGU1?=
 =?utf-8?B?WHZ4VU5UVHU3ZlpsZXcrUC9hZzVBNzR2OVJlV2pRMG1SRm1UL1R4ZGxGOFAr?=
 =?utf-8?B?NTFPeHRhUHZuSEV4YXVLekw3Y3JmeEpVU3lUT2o0ekdPNHd5QmZXSDJsdTg4?=
 =?utf-8?B?NTRQS0pQRlpYMWlGZ1JtNHlRWHVRNWdQQWRpbmdaaXd6eXl0NVhNK1JSb3Q2?=
 =?utf-8?B?dm1lSHk3aFNSc2VkZm0vQnFkWUNuMnlJWnJUWm10VUVIeGo3SWFjL0Z4YUVK?=
 =?utf-8?B?UjdBdG5RaEpiTkpHNFNkS1pweDRiQzlISEsxNkoxb3NpaTBBcDhkS0pReVpC?=
 =?utf-8?B?WUNEb1NYQkRnMG1HT2pYQm1WNmxXY0RYelZmSkNHclZWTTJCSWlkM3RXVVBn?=
 =?utf-8?B?ZFp2WHpraEZ0clVTSTQ0YTVOb2JWOVpKVHpmREQ0YUFYWDd1OHBBK3d0LzVQ?=
 =?utf-8?B?aU1yK2NWbEVzOVRtZzh0eWZxUldsZnlhYStGejQ2d0MzLzVTNWQvZUZ4VDEv?=
 =?utf-8?B?R3V6UWwrL3lqTi9wb1psQmVVWGRmZWRxK3p4elZrUWRsZkFtWHJlZTVRZ2tr?=
 =?utf-8?B?UDg4R1R3WlpaZ3VSbk03V3dCSFBsbVRzZmJjcTJnZEYzZEkwellQUHpPRW00?=
 =?utf-8?B?V1pUTXdkQ0l1RWdOWC81SHF2dkJ4N0dHdXJlUVY3SHBPek15TFpKQ2o1anhh?=
 =?utf-8?B?TGYvNzdSeUlnbnl3MENGZXhVamNwYkE0cFZYcEt4MitZMGQyZ2ljTHNjc0xo?=
 =?utf-8?B?UmZ0cUozQkNPRDdKd3lNZFlOOGhZdXg4Sm5pL01lWWtob0YvVHNQL1hlbnZJ?=
 =?utf-8?B?RS9VNSsrVTl5ZExFQUtkakxCeTBMQktpMGhsMnRwcThWVzBXbmlOL1lZRVFt?=
 =?utf-8?B?SWdlREtTbDlRUkFUQ3Nidz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?M3lyaG9VSkV6S3hZdlYwTlJ1Mk53TDMrUk9XckMxQkk0bTdNWEU5UklNVnN4?=
 =?utf-8?B?ZFcvazBDZ2VRaVZ1RkZCWW5xdUZTQURUMVE3a3V1SlpQaFk4Y0hwYzN3QWUz?=
 =?utf-8?B?WUVodGFYOVAveWxBbzIwcGR3RmxjYm51TVdiTWVWYUlYa1RZUUxNbUhrVC9x?=
 =?utf-8?B?RWpzbSs1Zk40a1VUNDdmR2tQWTVaRWVyV29oQVFIQmNXMGU1aGRXQlp5L01v?=
 =?utf-8?B?MERBNXZXbElBYU1lbGdCZDd0RThBcXBiK0NuUElabWJnZnM5NklJV2YrY0I0?=
 =?utf-8?B?WlpBVEEyVUdBUHV2eTdjSWtYdXA4ODIrMzF5MHNJeEZ5ejZqYXlJbVVtWHNS?=
 =?utf-8?B?NDNCQ2I0TVhNZkZSTTdpNEcvMXhraVRPK0VpbEN0RWpQL0hMM2NUK0ZRQy9B?=
 =?utf-8?B?K05JbkhyUStyMmtJNjNOa3plMG8wMDRMYnFJOGpqd0pUK1hadU0xOHBZNk5P?=
 =?utf-8?B?a0xLaWNHdnhXODRMZ2lzRGIrbmJXMGtJYmpoVkZIVSttUHFBOXZlZHJXVlZM?=
 =?utf-8?B?NlhvNUIwSmRBS1JSL3NtQzhVNTFhN3BQcFRKTEYxOEZzbU9GaGhxcWNrWmtx?=
 =?utf-8?B?dTAyYkZlTDRrL3pwYnp1WDNkckdoTkZ0cENCZEVUeWsvZVVxVEdSMlptdFpD?=
 =?utf-8?B?bzBQVDBxejBxWDdldVlMWnY2eWVjdHBYYWJkei9CRUgwWmozK2NYNFNQUFV2?=
 =?utf-8?B?d2hWOFE3c3kyeEJJSVg0bEI0K3AvM0hpZGhmeDBOdGJrVEp0NEVNakhzNTJH?=
 =?utf-8?B?eStTNFBEUnNYVVRyZHVSYVlYR2xDMHlrVkM0Z2hzSnZpRHJHK3Y4cVVsZW9m?=
 =?utf-8?B?MDdCeEVYVG0wbENkVzcrK0N0Y1FUL1VKVzY3ajZKSkhMSkxXRUJmS3BlbGtJ?=
 =?utf-8?B?STVkWFBNZkhhZGJ4VkZYQ0NrSWpZN3pIWHRRUDVVdzZHMFYyeTBua1BnMld2?=
 =?utf-8?B?K0RHdlRtaEUrbHR5Vkx1dmh4Y05Ybi82Z3pkdEZjVVZsU2h3MUN0QUhVOWdo?=
 =?utf-8?B?NmQ5QWdOVTAwdFd3MkJ2T0V2N0VPNnBPZVFFaU5oS0w2L3JWdVJ4K0JiTXc1?=
 =?utf-8?B?NEJjMGNOK3ZIcHZZbHRQYmNTblIwdFplQXZxeEVrWjZ0WUdZamJDVThtMGNN?=
 =?utf-8?B?Q29qRXUzOFhGQnA2UGJiR2ZMb0lISWN5VDB1WWZuelNOdFFHV1cvRUlpTkdD?=
 =?utf-8?B?WTU0UnpJSUdycnZBR0dJRTdnUEVVS3c4SmFCWmpFdGVtNmpkSnZNTXozOUdn?=
 =?utf-8?B?UnIvM1F5cit2U2N4TVZ0K1pxQ09UbG5MWUI1TDVYUWwrWXFVOVlSVGJSbmdE?=
 =?utf-8?B?L3VpSEIwK2dDMk45Ty9hQ05QSTFxakw1NksxUlF0NmFBNjRMZUwvZk9DaTFl?=
 =?utf-8?B?SXhheEhsNi9mK0xYV2I2QjQzbTN2NW1FR1MwellYVW85bWxSRFBwNTdhSENV?=
 =?utf-8?B?TGFTSzIvY3lGQkdiNFc5Z3RlTzA5VmREUTZlOFNwa3MwWGNDVmQ2Q2l5OFNs?=
 =?utf-8?B?NXN5REx3Q1pWU2lSYkVvR2FPYmhJZ3Q2Z2djS3JpVVpTVnQ5bEdpUUhseWdC?=
 =?utf-8?B?VWk3NnNCZDZQWGVJNERidTNxa0N1Sk4vejBxVWVYWTdzY1o0NlRReEZGTERB?=
 =?utf-8?B?eVVnN0lDdmpqUVcyT1gzcG1sbjh2K1dEdndCQmw1NThZTDlVSnprcDNTVFNq?=
 =?utf-8?B?UDNGZnp2L3BxeHhGNzNWVlVpOVVoNmlYZDBBdVVPMngvTWUyL0xHUjN5Qzc0?=
 =?utf-8?B?ZEl1NWl1RnlodmFhb2FSdEN4cnNCS2taL3NYVUZBYnJYQ2lyVVErSXZuTUp4?=
 =?utf-8?B?bGMrYXFYRkIvTm1udHhIMGswN1Bna3MwY0daRVhWdC9ZKzhvUnozS3F6OG0v?=
 =?utf-8?B?MEgxaDVGbmYwNjhVeld4RW1vcFFjNlJ5NjdaQVdzUi92VjhOMXlpUnlwd3Fs?=
 =?utf-8?B?RkUvQUR6ZGI1SnpFc3BEaElXNDZ3ZEhKbW9qdnM5OTBvQndiS3RPRmRaMnky?=
 =?utf-8?B?R0ErdkJKMVd5MzFZR2xwNzV2dUQ0NTJRdFUzZTFkeE1yZC80cTZBblBYT1Fi?=
 =?utf-8?B?Y2JWWXNxZ2xDUTI4cmVTQkZmcnJobDI1QVlCM2VsVzU2c0Z0eGhleU9YdDRo?=
 =?utf-8?B?d3ZHQ0RuTTFkTG9lT3pmUlczaEgyanFkMVp2bUhudnAwcktiSHFiU2hxU0VI?=
 =?utf-8?B?U1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 715811ed-d25c-43bc-76af-08dca27d27d7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 14:16:00.3741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wCskSFWJDkxFHudixgn+vRnAQv9+sg38UKGw5ZpHnu55HirYPFh+vqcuu+oVm/N3Bd3CAecOj5uF1wM9K+PDFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB6005
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Jul 2024 14:16:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16485

On 12.07.24 14:57, Stefan Koch wrote:
> - Avoids that busybox losetup is used that
>   doesn't support the "--sizelimit" parameter.
> 

You didn't address my comment on v1.

Jan

> Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
> ---
>  .../initramfs-crypt-hook/files/encrypt_partition.env.tmpl    | 1 +
>  .../files/encrypt_partition.systemd.hook                     | 4 ++++
>  .../initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb         | 5 ++++-
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> index bb93361..72033d1 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> @@ -5,3 +5,4 @@ WATCHDOG_DEV="${INITRAMFS_WATCHDOG_DEVICE}"
>  HASH_TYPE="${CRYPT_HASH_TYPE}"
>  KEY_ALGORITHM="${CRYPT_KEY_ALGORITHM}"
>  ENCRYPTION_IS_OPTIONAL="${CRYPT_ENCRYPTION_OPTIONAL}"
> +LOSETUP_PATH="${CRYPT_LOSETUP_PATH}"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> index be8c117..2ace533 100755
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> @@ -19,6 +19,9 @@ esac
>  
>  . /usr/share/initramfs-tools/hook-functions
>  
> +# get configuration variables
> +. /usr/share/encrypt_partition/encrypt_partition.env
> +
>  hook_error() {
>      echo "(ERROR): $1" >&2
>      exit 1
> @@ -47,6 +50,7 @@ copy_exec /usr/bin/sleep || hook_error "/usr/bin/sleep not found"
>  copy_exec /usr/sbin/e2fsck || hook_error "/usr/sbin/e2fsck not found"
>  copy_exec /usr/sbin/resize2fs || hook_error "/usr/sbin/resize2fs not found"
>  copy_exec /usr/sbin/cryptsetup || hook_error "/usr/sbin/cryptsetup not found"
> +copy_exec /usr/sbin/losetup "$LOSETUP_PATH" || hook_error "/usr/sbin/losetup not found"
>  copy_exec /usr/bin/systemd-cryptenroll || hook_error "/usr/bin/systemd-cryptenroll not found"
>  copy_exec /usr/lib/systemd/systemd-cryptsetup || hook_error "/usr/lib/systemd/systemd-cryptsetup not found"
>  copy_exec /usr/bin/tpm2_pcrread || hook_error "Unable to copy /usr/bin/tpm2_pcrread"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
> index 72de5b6..1679133 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
> @@ -9,7 +9,7 @@
>  # SPDX-License-Identifier: MIT
>  
>  inherit dpkg-raw
> -DEBIAN_DEPENDS = "initramfs-tools, cryptsetup, \
> +DEBIAN_DEPENDS = "initramfs-tools, mount, cryptsetup, \
>      awk, openssl, libtss2-esys-3.0.2-0 | libtss2-esys0, \
>      libtss2-rc0 | libtss2-esys0, libtss2-mu0 | libtss2-esys0, \
>      e2fsprogs, tpm2-tools, coreutils, uuid-runtime"
> @@ -57,6 +57,8 @@ CRYPT_PARTITIONS ??= "home:/home:reencrypt var:/var:reencrypt"
>  # CRYPT_CREATE_FILE_SYSTEM_CMD contains the shell command to create the filesystem
>  # in a newly formatted LUKS Partition
>  CRYPT_CREATE_FILE_SYSTEM_CMD ??= "/usr/sbin/mke2fs -t ext4"
> +# Path to full (non-busybox) losetup binary
> +CRYPT_LOSETUP_PATH ??= "/usr/local/sbin/losetup"
>  # Timeout for creating / re-encrypting partitions on first boot
>  CRYPT_SETUP_TIMEOUT ??= "600"
>  # Watchdog to service during the initial setup of the crypto partitions
> @@ -68,6 +70,7 @@ CRYPT_ENCRYPTION_OPTIONAL ??= "false"
>  
>  TEMPLATE_VARS = "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD \
>      CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE CRYPT_HASH_TYPE \
> +    CRYPT_LOSETUP_PATH \
>      CRYPT_KEY_ALGORITHM CRYPT_ENCRYPTION_OPTIONAL"
>  TEMPLATE_FILES = "encrypt_partition.env.tmpl"
>  

-- 
Siemens AG, Technology
Linux Expert Center


