Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA52C3DA42
	for <webhook@archiver.kernel.org>; Wed, 17 Jul 2024 14:56:26 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.76])
 by mx.groups.io with SMTP id smtpd.web10.570.1721228182896545428
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jul 2024 07:56:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=UsMxR/QI;
 spf=pass (domain: siemens.com, ip: 40.107.20.76, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VSnUQS4ed6E1IVbufkltbgH53Z0b9N0PUEXeG8JB2nOTc+V+N3Kfrg4Gbe63OezRRKHWRjDvYWsGr3jv66ByExVJnJXESds5AO5q5kMMR8SX4Kg2i4twmzkAsyJF6Xcl/OZM0Y1Cxp7CdP7eeJzNOkFxTKGOfo2gAAp3ZIS2PQyJdz4SAGVS+C88QnY6ncL19lXqp2jsSvdax3CWYFtaUkoLSGO2O7GVImM/LCbi5kNUWkxqPzoKFA/+ORjC7CbtNov1F6YauPtm26nivmOr1GP0oGK8SO9tlaFoXHmlZYp3SW7No1qvjDHGXzmcDPPpanN3Vyyr2kX3+JJL3eJA/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTQ4dvgPwomvd1A7YD3sI8kiNFR4Bv4C3IBaS+cusXM=;
 b=Vp/J4hARI2nprtRb2AlAeQlpdjklPFObkPf/KuxLhuPUDVAgTjvQZlKS66oSZiYErcEzprbyrhr0iu4rR58FcQ26xc/Z8hAhGOKreGH5i09DSGNXlbbTc/lCSUxmfpJ7mY1U7qNgQXwQv9GzxDX7uaanI1cjp1RwjV4EL6r/jDsXNH81yvPuODFlRo0uWo7qctlixBCvGYm5I8JXDKqVBVMB6oRrzlw4qhfP+WTFAYJa2sCNhyBvayGTvpebDY186WDDVIqMDbrBBuT+Rq+HbIEc5Cicw5o6GPsVDlqwkfjfuT7g4fix2gJXNOLEAg6fJbpMivVwkwJWQ/BU0Kstfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTQ4dvgPwomvd1A7YD3sI8kiNFR4Bv4C3IBaS+cusXM=;
 b=UsMxR/QIk2r9vbAEn3S18hbvMUxye35ebpPlO0QxIO9yx/93RyYRf0eznkqTAegR96WIQqmNMh08DRJTGyqmPBF3d+OMV0MWclwRsKQaG7A3bN4EN0IUg8O13yQi4bjxLctAG0qQ7HxUZWgiWqfQgYcD/aJSgUjRI2ZzB++WAPS+o1VgXvbnUiQ4l5L9ZBzYStLhNuFCBX0ADuRMJZDFXFz14sq/KmP4nONRestHdDahTNdGgU5VmvkQHsI+QiajhM7ioGifyyqULMvoMy4TSTkT7hpJ3BOjZ/EYqMaq6hXy8sdUWSTCJqZfCJLFYo7LfsbY6Mh5wHCSj9BLDe29pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5382.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:286::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Wed, 17 Jul
 2024 14:56:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 14:56:20 +0000
Message-ID: <642a1dad-c83e-49a1-9f11-c9b51d29e45c@siemens.com>
Date: Wed, 17 Jul 2024 16:56:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH v4] initramfs-overlay-hook: Check
 file system of INITRAMFS_OVERLAY_STORAGE_DEVICE
To: Clara Kowalsky <clara.kowalsky@siemens.com>, cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com
References: <20240715135258.902008-1-clara.kowalsky@siemens.com>
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
In-Reply-To: <20240715135258.902008-1-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:610:b1::35) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5382:EE_
X-MS-Office365-Filtering-Correlation-Id: cea1cae2-55d3-4506-fccf-08dca6709e24
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UW5kcHVKNmxsV2R2ZDR1WkVkZkRCdHl2SHRHSDdwS25kUlM0VlJwcHcxcUF5?=
 =?utf-8?B?UmhGVXpPY2o5bjZGSmNkdHhUTDNRTDlVUDdWS3JCbUdpYVhYRFpVRndzdGs5?=
 =?utf-8?B?MENpdnJGTTJOYmxmZjhxTGlJUDd3VHZrcUR0RVo0S2JUSXRCUzdJRFVXMktj?=
 =?utf-8?B?RmJNZWNVbW1Td2pQOVltQzBLMVNkNjM4MzhQci9mZzlROXRaeDVLUytvVGUy?=
 =?utf-8?B?dmFpMW8wQTk0WXdJVEhwK0tGQWNUbUpkTm1lbHlzcjByeDNlUmVMd0p4Y0hi?=
 =?utf-8?B?bnJFV3MzNVErSzhFMFdadWZ0bjRRWmhVV0dySXU5dGtxdlc2ZWxSV216UEN2?=
 =?utf-8?B?NkV3eThYa2RxbnBNdlphVjdRVnJxUGswdmlXSHlDNFczejltT0JFZ3JCWGdR?=
 =?utf-8?B?TmVqaUkwc28raDF3N2RtdjBYTVYxQWlIZm1Tc2lvWDUybUxOYktPUFZ3cFk1?=
 =?utf-8?B?MVpJSVQxRU9GcEsyQkw4ZGcvcGMvR3BGeXBmcWxXK0t1M2RIRTh0VE1aSFg0?=
 =?utf-8?B?bnltQ1RXakJWWUZCaHhvZW1KQ3FJcGttbXhxQURqVy9QS3RUM085NUVIV24v?=
 =?utf-8?B?dEpKRldIVEVabWFpZ3NPSjA0QVd5TGt2YlRFWUhrTUZ1eG1DeC83eDBqYWxt?=
 =?utf-8?B?ckpCUFVRczNWMUNTL3plbDlTbVBsNVBKeHJONVZYN2RRSGNMT3d3VkZHaXRK?=
 =?utf-8?B?UDZqVXhaTGJENzRDN3NzeStBYnRRZWxneUdlSnYzcEZjZ24rOEw1akRQbXJS?=
 =?utf-8?B?YUhFWUQzOG1VN2VKeXNlYUpra2tCMVFmbGxSYXJ4WmVWTTFkTlpISC9MeTZ3?=
 =?utf-8?B?L0Y2aWIvR3VMMDFuR2FWbFYwS3JoZy9wTmIyOXJzdkNXU1RqWWl6b1I5R2t3?=
 =?utf-8?B?SjQvSmlXOW1pa2hOenlhajljZDVhZkxadFNVb3Z1WkJQb3ZKZjZVd0s4eWc3?=
 =?utf-8?B?dG1RZFdGM0hRV253NzAvOEJGM0xsd3pxSFZXYzNycmp5RHg3UUxDb2lqazd0?=
 =?utf-8?B?TkUzUm1WcjRpQXk3WDJXcTl1d2lJZkxMTjlqZlJrR21PanpwNStJenR4WGRJ?=
 =?utf-8?B?UTVhNGd3VmR6Q0RRclRSM0hJREVvY2lLTDN0Z0s1K3JYVFVwUjJDeU9ZQUNv?=
 =?utf-8?B?R25IMzYzQTNPRTYxUHZlNnA1T2oyeXg4a3EvWGtsYWpVU09JcmtQZ1J1TmJk?=
 =?utf-8?B?a0YxUWZxajBTeTlKU1plR0xHdnpPZURQcC9TZEZVdFJLdEtNVG1wY1cxa2w5?=
 =?utf-8?B?eVlxOVUrdzVQemtLaStRSm1tYnpZSURxaXJkY1A3MFVXdlg1b2dWRUJUdjh3?=
 =?utf-8?B?Nm9IcFlTbWROUlc4aGxuUzVkWXVoVllvb0prQ09jekVMTXJxcUt3RUs0cXpJ?=
 =?utf-8?B?QnljTTNlOGNGaHJjYTJWYWRqQzZ5MXhTV2pWejhQYWk4aThjWnVJK1hKTDQx?=
 =?utf-8?B?RTRUYXVlcXgvdW1ZMEQ1WTkvd3BhbFgra1JYQkN2SVAxQWpySVpta3loam1u?=
 =?utf-8?B?bkJSdXgydEFrcXloWGFrOVY0a0NsL09zYXhCUGJZcWo4d09qMHh1dVI3YjJl?=
 =?utf-8?B?cVR3ektuaUh2b3pCM045VlZrb255dlJHN1MzWWNjTEZQSmJPNDIyQUJwYTBG?=
 =?utf-8?B?QXdaRUhhSkFqcnZRT0NseTJZc3FScUpFUWwwUGdhUSs4aEExVEc4VmVqRS8y?=
 =?utf-8?B?bjhZS3F0TUFOSFEwMWpodHVodmw3RC9oeEV2czFTZW10WWVLSjJxNks3dkJM?=
 =?utf-8?B?VmZhZThKUlBVd2o1VW1ZUW1HK3BtS1lyVnNFMHRhU1VhYng1QUtneFpGY3ll?=
 =?utf-8?B?bTIwTnNZT2lMdytST3ZEQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U3IwaGx1WGJRRm9nRGM3d2JEUUJ2K1lrL3JQV1JjTk5YSmdUekZiSlhRKzVa?=
 =?utf-8?B?SmlMUlVzcWVGUC9GYThUbGZ5UHVoYzdodWZsb0IyMWZqTGVySk5BakVrWUVU?=
 =?utf-8?B?dFFaTDhyT3BEbmFXSDZFaW1uMVJZRjY3TjFRdmpwM2h2dUpRK1lxSlFRNFRB?=
 =?utf-8?B?Y2QyY0NwODN1MFBBdHdrYXEra0loNlhYWEpMdGhqZkJPOXQrNmFzeE9JUi84?=
 =?utf-8?B?WmFHYUtrVFd0RFNrTCtNL0Y0bnJZWEpTS0Z2dUFiQVN4TXFKQy9PN0RxdU5X?=
 =?utf-8?B?WUFPd2NYMjUwbXJlSnprbjh1eXJMc2I4dkVQdERZRkdyR1orWitxUTFwOERv?=
 =?utf-8?B?Z2tPRXBmVTJhV3AzU1oybXRhdjZLUTF2N3hwalVqMHNHL0JFdTZOQS85SVgz?=
 =?utf-8?B?cHEvdlV6M0grOFZKdzJJd3ZhQ1NuTnVlZ3RUVHd2UlRzVUJNaW5zb1p0UGUx?=
 =?utf-8?B?aDFTV1R5RG1tbEtmSmVTdGY0ZGY0NUNKVFEydEhFSkc3QlFOTGlXU2hmcEI1?=
 =?utf-8?B?SzdrZGRYbk03Q0l5cUlPaDFNbEhVOFg3UGtWR0lpQ2hIYTNZWllrRDY5cEJw?=
 =?utf-8?B?NXFoVlZWN0dkN2JsU2xmQlV6S29sMlV5elc0K3ozZld6c2dTK0tVZnpXQTBw?=
 =?utf-8?B?RjlZc2pUZk16Vm13VUhkZG9UZkJsS25rNDN0bC9seFFsbW1uaGpFSjdPZ0N5?=
 =?utf-8?B?Ym5DMlpLZDlMSUp6bXFkeDAxYlkzcTJJTjB1dGpQVzZKS0VKQ1Voc1dqSXNE?=
 =?utf-8?B?UlNRc1dicWVWMmVSc1o0cHI5aU8rQlg3eDdXYStmVmNVemZWdEZFemRSdGph?=
 =?utf-8?B?TEVLU1BkWEJMbW8zK21mL1NROGVkdmFQbmlwVmc0b3NWYW1wMERYaGE4Nk5t?=
 =?utf-8?B?aElVajJCNFpRT2pLbGdGZ1dFVDBUNEF5Y203NCtmcm5zaXZOaS9jTTh3bVNM?=
 =?utf-8?B?U2g4QTJSRnhBTFFQMnhOVnRsbkVTTVp4SEliOWh3UmYxSWpFVnAxNTdtZmRo?=
 =?utf-8?B?ODBkcWV4WmRCTERIaERSdXhRa3V2a1NaVzErUlFyaTlVaUlsTjNmeXdzKzV3?=
 =?utf-8?B?dTlheGpuYVVLZEJrdjBybUdVNkNoTXpvblJVdkQ1SEd0VnA4emRFYzNoTXJ5?=
 =?utf-8?B?YnNVVGN2T0l5dldyM3NPYTR4K1M3amEwR3AxMVFLbFB4SjdXdnltMWpqZjBR?=
 =?utf-8?B?TU55a0pxOHZqK0xrWWZaRGVrMGZlbVNaUExzbWNNYzJsK0JFU2RYb0hQRFp1?=
 =?utf-8?B?NCtMNlBFdHlIVFU4RENlTC8rVUUwbjc3ODNVMWdwSW1IcDVWaTBQdVhORkFQ?=
 =?utf-8?B?ZmQ5Wk1QOVNJZ05yM2gzVDZVZkJkbFZ1N3NxTUQ3a0cvNUpBcDFnaHhzTzZq?=
 =?utf-8?B?RHU4emlmZW0rUStrQTdEYnRaczYzcmpoUm8yQkFtaU56V0dqMUhTck95cUtj?=
 =?utf-8?B?WFR1T1o1VVRGM05zbytKaVg3MzA2SnoxS01tcG41N0k0eVd3SUd0SVR2enJ6?=
 =?utf-8?B?cHk2VTJvcUtrUDlaQXBJSnVybnNVUXNZOFl1WVZuZGFKbXkrSDRPYWhFTE00?=
 =?utf-8?B?Z2ZJN2lnRkdnb3hFQS93V1JCdW9BaDVRQ2I4SS81R1dNTC9Jd1RReEZNWk9v?=
 =?utf-8?B?eDNtbGo1NFdxVCt6OEZOUkgvQkc0di9ra3BiMVpuQmRKSFVNanlrWG93UW11?=
 =?utf-8?B?amJ6T3kvZG1oYlI0ek1relBFRHNjU29SVm0yaFN2NXZtdXpkaFZzVGlNVGIr?=
 =?utf-8?B?cWN2VEljT3JkTW1UOXJXRTRJbWNwWVNJRXBsTmZvb2g3MDJyeDNqako1Wmlv?=
 =?utf-8?B?eHVJVWNlR1F4OTlSSmlnVGNzcUZhQTJtZFR5Nkk2Q2F0ZTdnZnpYanJMOWYv?=
 =?utf-8?B?Wml1dHcrVmFMYmZhYlQxdVd0dytCMzhXT3hCb0Z4TzJERExUcXBJbTc0blky?=
 =?utf-8?B?UXNGdkRPdkJTYWtmRVlqK3JFUTlybkxHWjFsNkNOemg1ZTJ0MDF2TllWRGJ5?=
 =?utf-8?B?TjFHVVpKK1hnN25XTDV5c2FveXZOcHgxOWpieWZkR0ZJb250R3JXWEhQMk9O?=
 =?utf-8?B?djRaWG5za0hYYUtsY0xlcGhNaTM5ZVJTdE1FR1lZTkdva0E2d1NIODFlQlhJ?=
 =?utf-8?B?T0ROSjR0Q2JUZGxEeUxCRHN3UDl2RG1lS1VXQ3BPc2F5ZEhhMVUzcEdjS25H?=
 =?utf-8?B?a2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cea1cae2-55d3-4506-fccf-08dca6709e24
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 14:56:20.1872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1eYmrpKBUM2vRLS7gWctFrKnbKKKF0ed/+z2IspW1+fMOlGZqR+hLiyypHIP8L3vOYew8fEu/8L045EFcAmoBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5382
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jul 2024 14:56:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16568

On 15.07.24 15:52, Clara Kowalsky wrote:
> In case of ext*, this detects and fixes file system errors in the
> partition device before doing the partition mount.
> If the partition turns out to be broken, the factory state is recovered.
> 
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  .../initramfs-overlay-hook/files/overlay.hook      | 11 +++++++++--
>  .../files/overlay.script.tmpl                      | 11 ++++++++++-
>  .../files/overlay_recovery_action.script           | 14 ++++++++++++++
>  .../initramfs-overlay-hook_0.1.bb                  |  8 +++++++-
>  4 files changed, 40 insertions(+), 4 deletions(-)
>  create mode 100644 recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script
> 
> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
> index 8b00ecf..6f634c5 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
> @@ -22,6 +22,13 @@ esac
>  
>  . /usr/share/initramfs-tools/hook-functions
>  
> +hook_error() {
> +    echo "(ERROR): $1" >&2
> +    exit 1
> +}
> +
>  manual_add_modules overlay
> -copy_exec /usr/bin/mountpoint
> -copy_exec /usr/bin/awk
> +copy_exec /usr/bin/mountpoint || hook_error "/usr/bin/mountpoint not found"
> +copy_exec /usr/bin/awk || hook_error "/usr/bin/awk not found"
> +copy_exec /usr/sbin/e2fsck || hook_error "/usr/sbin/e2fsck not found"
> +copy_exec /usr/sbin/mke2fs || hook_error "/usr/sbin/mke2fs not found"
> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> index 42eb59c..deda034 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> @@ -31,12 +31,21 @@ ovl_partition_device="${INITRAMFS_OVERLAY_STORAGE_DEVICE}"
>  ovl_storage_path="${INITRAMFS_OVERLAY_STORAGE_PATH}"
>  ovl_lower_dirs="${INITRAMFS_OVERLAY_PATHS}"
>  ovl_mount_option="${INITRAMFS_OVERLAY_MOUNT_OPTION}"
> +ovl_recovery_script="/scripts/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}"
>  
>  root_mount_storage=${rootmnt}${ovl_storage_path}
>  storage_mount_point="$(echo "${ovl_storage_path}" | awk -F/ '{print FS$2}' )"
> +partition_fstype=$(get_fstype "${ovl_partition_device}")
>  
>  if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
> -	if ! mount -t $(get_fstype ${ovl_partition_device}) \
> +	if [ "$partition_fstype" = "ext*" ]; then

This will never be true :). You want "case" so that matching on * works.

> +		if ! e2fsck -p -f "$ovl_partition_device"; then
> +			if [ -f "$ovl_recovery_script" ] && [ -x "$ovl_recovery_script" ]; then

If you combine the three conditions via &&, you save two levels of
indention...

> +				"$ovl_recovery_script" "$ovl_partition_device" "$partition_fstype"

...and this line become a bit shorter.

> +			fi
> +		fi
> +	fi
> +	if ! mount -t ${partition_fstype} \
>  		 -o ${ovl_mount_option} \
>  		 ${ovl_partition_device} \
>  		 ${rootmnt}${storage_mount_point}; then
> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script b/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script
> new file mode 100644
> index 0000000..4ef0148
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script
> @@ -0,0 +1,14 @@
> +#!/bin/sh
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2024
> +#
> +# Authors:
> +#  Clara Kowalsky <clara.kowalsky@siemens.com>
> +#
> +
> +ovl_partition_device="$1"
> +partition_fstype="$2"
> +
> +mke2fs -t "$partition_fstype" "$ovl_partition_device"
> diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
> index 955748f..7097130 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
> +++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
> @@ -12,9 +12,12 @@
>  
>  inherit dpkg-raw
>  
> +INITRAMFS_OVERLAY_RECOVERY_SCRIPT ??= "overlay_recovery_action.script"
> +
>  SRC_URI += " \
>      file://overlay.hook \
>      file://overlay.script.tmpl \
> +    file://${INITRAMFS_OVERLAY_RECOVERY_SCRIPT} \
>      "
>  
>  # The variable INITRAMFS_OVERLAY_PATHS contains the directories which are
> @@ -35,7 +38,8 @@ TEMPLATE_FILES = "overlay.script.tmpl"
>  TEMPLATE_VARS += " INITRAMFS_OVERLAY_STORAGE_PATH \
>      INITRAMFS_OVERLAY_PATHS \
>      INITRAMFS_OVERLAY_STORAGE_DEVICE \
> -    INITRAMFS_OVERLAY_MOUNT_OPTION"
> +    INITRAMFS_OVERLAY_MOUNT_OPTION \
> +    INITRAMFS_OVERLAY_RECOVERY_SCRIPT"
>  
>  DEBIAN_DEPENDS = "initramfs-tools, awk, coreutils, util-linux"
>  
> @@ -48,4 +52,6 @@ do_install() {
>          "${D}/usr/share/initramfs-tools/hooks/overlay"
>      install -m 0755 "${WORKDIR}/overlay.script" \
>          "${D}/usr/share/initramfs-tools/scripts/local-bottom/overlay"
> +    install -m 0755 "${WORKDIR}/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}" \
> +        "${D}/usr/share/initramfs-tools/scripts"
>  }

Jan

-- 
Siemens AG, Technology
Linux Expert Center


