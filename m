Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D78D116E2
	for <webhook@archiver.kernel.org>; Mon,  1 Dec 2025 08:05:38 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.26])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16539.1764576331678683561
 for <cip-dev@lists.cip-project.org>;
 Mon, 01 Dec 2025 00:05:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=hazZxmhx;
 spf=pass (domain: siemens.com, ip: 52.101.83.26, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HAV8w4f6EFID6Em0DGLo7ryXhH09C5y1VwoXdux4OmXAF0OtnMsG/ciyPJQ0CUhWsgu/7EvMEBgFnjF5JLqA7QpIP65//NefQ2YaN5FP5W+WsBs2Reu29X6kqPGOxASVX30QuWTQyxqGKBT3ThxyF9OfTiDtUP8zfLSKOjk+knK51ala2qnwgqv68KNekHoG3pLjto6izmIN9TGdurVgv6vSQ1j70DNKiBK4pzZjliOsSV33XjBnVpOpin+4UiTnSoD+PRQnRwjk6em3b2FhxnSLFpz+TW/GyiV7yWmO1LyMfR9WnPI0/g/C4pMkSKkTpn27WCJpJOPlzvYzgTg2KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSHG31o40WBIPO/uwbbLc98JheUQu7asdKRTN4hk+aI=;
 b=A6E36y4PvrNNPCva0sMlussHUE6UzKsQwKqNGCvD4o3r3esrNqDxuupIOHD6ysiWPD1OVhWSzb/0KiSpONrgQ4HnANKEAaSz68pw9zuNN68wGD2rbdJodf6R5NjVOpFE/ANn6Grc5KTiNmy/h1pWS/ImEQBo59PXgPRodTeV2TG9828HFGK8dbAf/4QtVwvZTpfYmcNr3fkkyfSowVyL4afNdjhtSf7RqA3uQoCKgxk7wzjX3nms6v/3Ne/zVXCj2d2Owz/mUcOrwylbRRk+f+7LttRGG0yfEAzRc+b6DPpuRVQ5ZCSm0D6jDAcXRuARwBvn+jTiLXHhFEwr+2jQZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSHG31o40WBIPO/uwbbLc98JheUQu7asdKRTN4hk+aI=;
 b=hazZxmhxcrtQSw7DCGkh38y5dzdYHY30Wshht1VIYf5MWcN9c2hUfAqM4VpPR2EFeewl5ZEXSVVg69rSpX0r6DXZZzatR5sGT9Unew4rSLDJvdmm76U+hIUpjgJGpiihYE2xoQ4ZDRL88Jo+SUU6vSi3NJuTmt5/lcda5PeFMoJLN0nfyP8o4Gj5diMJo5szV725dT5ldUoAasxpV5w1ldQMQLSEJKrZpv1HPIX40AtRjxC/zJvZcXfXbgKEYEzjzEVxAtRDlZhj4cnvr6b4iz2aly58Jy4TehJmj+olKuWMC53SPfOXUBoMdvKX96MKkdFpQac8eP3CiL57RFjRtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB8187.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:391::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 08:05:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 08:05:14 +0000
Message-ID: <a974d20a-48e1-445e-8bd8-b00d0eb4c6ee@siemens.com>
Date: Mon, 1 Dec 2025 09:05:13 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Update isar revision
Content-Language: en-US
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>
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
X-ClientProxiedBy: AS4P251CA0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB8187:EE_
X-MS-Office365-Filtering-Correlation-Id: a834b199-669a-4677-cb97-08de30b05bb8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SWJ5cE1vcXErclNOclZJUmhyaW5lSlRaUWNTRy85bEF1T3JXbGJSVDlRZHVM?=
 =?utf-8?B?Y2plVllmbGRIM29oZXE1QjZVdFYvNXVmVUx1Mm1Ddjl4dGY0Ykx6b1RWNVha?=
 =?utf-8?B?dlBnWjRqUExPZ2l4ck5wODRKTmdMMUxyQTVLM2JWV2ZlN0tYTWxEUFZoZ3Vv?=
 =?utf-8?B?dmpVYUd1bGFNdVdzT3A0Q1o3cTdKSjdzS1RXVnAwN25nVzlyV2tYeUNjOS9B?=
 =?utf-8?B?Q2o5dGdFRnN0QnVUbjc1ZHppbWN2QzNYc1ZKWkxveGhzK3BYOUkzYUpzMzJL?=
 =?utf-8?B?SzFjRHo5YkhXZi9Nbjg2VGRhek1VY3FmUHR6TldCQlZuRlpsajBKSG5XUmZ0?=
 =?utf-8?B?UFRWZGRHZFQ5YlhJZnhicWJjbm5Fa0pGRDNZUExkQi84UURZQ00vN01xNlpC?=
 =?utf-8?B?L1VyeXJiWVdOWHF4M3JzQW9oQzhVK09zWkl5U1RXUjlhN1lKbTNlWENaRGdW?=
 =?utf-8?B?R1U0MVdvMTdPVjFBVzhDVXVEa0Q2VTVvSlhULzN0c3B4SGdvYXpKWWJqYVNt?=
 =?utf-8?B?eGhXSkJHRGZSMjRLRmMxbGk1REJEeHdDdXdpb3dtbkxJeU10TFdxdjBLYmp2?=
 =?utf-8?B?NXRrL203Y29lL0xlY0drcVFlWUNwMjRkcVZTeGltKzdKeHZIYXphNElDUkho?=
 =?utf-8?B?MldMRlozOFlCMlIzR3lQdk5uNENwMGR1NVpIL1QvWUZUTVI3Lzd0VGtmRTM3?=
 =?utf-8?B?UmNiOEFjRUFza25aeU9TS0cxSnFsUUJNd0Q0S1BSN0Z4bDJsN0U1Z0srd2x3?=
 =?utf-8?B?dzR6YURIZWZGYzEyV25CcTRCZ1FvdU1VNXJ2a1JnZjQyOERzNVM3N0hBM1pC?=
 =?utf-8?B?YU5aNDllS0JGV3J1YXNDbmVzelgvSnlNT1VlTDdtK2liVEZkOFFHUE9heHVF?=
 =?utf-8?B?Ym85SXIxVTJtODBoWEJQNUZUWXNWdWUveU1kV1NHZENKWDB3SUkvS3NCSjFZ?=
 =?utf-8?B?cG9GQ3paSDdLSTA2eGpjcGtLS0RUZjJUd2FtdFZNaWh3SncveGFNVXhINFZj?=
 =?utf-8?B?OWlEa0xWNzNxcW9kdmlNZTBTYUpDM0dLU2tDcXRqMk5zYTZqNzdPUnBDTlFG?=
 =?utf-8?B?Vjk0eEJSeEZYVW13OEE3Q2c5OFVvMGR0SWswRlNkVlRKKzlyZXVOeTJ6Sm9N?=
 =?utf-8?B?eE5Fc0hlQWNuWlVOOUJlQndDc21zeEhMcHVMd0pBRnlrMXpTTVNQUWNyRHlD?=
 =?utf-8?B?RzR5Z05kMlRudlNiNUhXU0xwRmtNdlkvVkhST0d0akpGV2RwMEFlMkxKcm5Z?=
 =?utf-8?B?QUxSU3lPbGhveUw0dXdHWFRmNUpMOXhYTDlQcXljamZ0c0N4RnFqMkdlaU9t?=
 =?utf-8?B?SlhqazZZOGlIYTJySnRnVi9iRjBPa3p0Sk5URDl3ODJoMzhZTWJ5Q0lhYTJj?=
 =?utf-8?B?RjJ6bnM5U0NPSDd2NEs3cGJ6S2EzOER6Mm1jL28zWEY1Ym5PZTY5RUE0WHdV?=
 =?utf-8?B?dldsajNyNHlhL1NEWmpmQ2dPeW9KR05TUmx6WkhxTmxEcG9jWnExeW14RCtD?=
 =?utf-8?B?a085TEtETTB3VHg5UklIWGtwTENDYjhmN1VoS2N2WForNFhlV245d3JvSzB2?=
 =?utf-8?B?SXFTYklVWGhyRmE4dXk1UTNxbUFrYmd5c0JTQjFocThFY3RjeDYvcXZJbk9k?=
 =?utf-8?B?WE5ZZzJQZkNMNWFRaWMxS1V2dFBvaGR2dy9CMFUzdXFwaTV2ak5MTmpYbjJH?=
 =?utf-8?B?cXV1TGh2R0Z0cDhJL1k1dlZNS0hDNkZCd3MvRHlWaXBqQWgzU0NMN0QwS3dL?=
 =?utf-8?B?ODhsT293eW9sODRMbnc1T3Byb0tPRytCOVZodG51eVE4ZkpzakFFSWExbFRv?=
 =?utf-8?B?UlZoVjAwemY3SDZTbzhwMS9nYi9MM2QvOW43aXhpK0c3bDl3VDVUaFluNXEv?=
 =?utf-8?B?QmJ6cGZxbitubERQMXVudStRaHBVQVVyKzNTbGprZGRoVkxtZXBFUFA0ZHV5?=
 =?utf-8?Q?JhRFWLibkrw+e98KU0nNtFX87QeOWJ1L?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UXI0TTlLbWZRcE1vdlpZdC96ZlgydC96NDNlQUVCdWpwWUxxNHAzcmM0Wm4z?=
 =?utf-8?B?aytZWERBVWNCNS9aOUdQMGRCSUdhZjMvU2JSWWN5bExhSENPU2FGNTJtVEgw?=
 =?utf-8?B?L2hTNlRZVS8wWk1IU05KWVFZZkFRTWZLTnJOc25IK0JXNTc1dlZsTGhhYTA4?=
 =?utf-8?B?MUNXRFArN1NVajQvQ2VFU1BKbVZYYUFjemxhNTIzbUV1eVM4MWZFcXVwRTBR?=
 =?utf-8?B?MmNVSDFqUzlYRXVzTGRObGpsdHJNRUxZeXFITzY1TG1QbFAvWk5JQUg1d1dG?=
 =?utf-8?B?bDhsSDhsQUhXRmsxckZOemJ1czZldXN1MHlJa2RobzUxREdrMS9sVEczS1Fh?=
 =?utf-8?B?bFhjTWQxTmt6QUI1VXAzb2VsdnBCMmM5RGQ4VW0zT0Q1MVZDZFMrck9lNk1q?=
 =?utf-8?B?WWVScVhWbXNYRUZEd21KU2M4WlpucUlSdDY0NWNiL0M5aUUyOG9yRnMyNnVt?=
 =?utf-8?B?dlRCK0o2aDFlR2FERkt4Q21GZG5CbnFMUU1UM1BZbUMxWmNoZG00blZiMllI?=
 =?utf-8?B?SjMvMy9lREg3MzFuaDcwbXRQajl6WGl4NG5ldWY5TUJDdGorNUZKbzV2OGU0?=
 =?utf-8?B?S0pjMzBmVlFrS2FFMGtVWkU0Rk1aVGdIdVlEMThHYnV0ZlJZQU82cGJyZkVx?=
 =?utf-8?B?VGdzRU0yRjVZNnBTQ3NwMUhEWVFXODhxSy83aGNQL2dESExMb2E4dW1PQVh0?=
 =?utf-8?B?MmdRTVVvSkdpWjhiUndVVThWSzdWMzVwRitRYy84MUViQ3kxYXZ2YnRYM244?=
 =?utf-8?B?Zzd2TWd2UUVkQ3NMclVUYm5BcDJmZzNHMVViRjJMWXRJTjZRL29YTk0vbXpq?=
 =?utf-8?B?QnpJa05BVmdyWlVEcE9vckhDTnlwcmdwZ3Mra1pkZzU3RENCMENmWDhMVldq?=
 =?utf-8?B?YXBOQ3hkaTNycDg4Wks2TnlrVm9ac0dTSTlub2JzRjU4VDgrbW9wcXp3a0VY?=
 =?utf-8?B?RitGYWl5dzc1RDRoVWZZcE9MOXFRV1dCWURNUk40ajhBam1kckxiN3VWMUZU?=
 =?utf-8?B?TVFjaU5Uc3VFVFRXSkFDRnpXVnZmdGpOT0tNZGRicTIrbTl4RVpCK1pwbEVE?=
 =?utf-8?B?dzg5NmpmK093ZVBrTGdpOWZsaEErbWZhZWRrSXBpakdqbVczRlZCMVV1QVZO?=
 =?utf-8?B?OGZmUW55bllEdWwwbW03QVIvUTdhZzB0a1AxTldmY2tyQmNlVTY0YkJkOW5p?=
 =?utf-8?B?djVrRjdSbnJyWUJnTVNrNjhnMHJqam5OTGJFWEpSRnhsd0xBaW5iSnNoMllE?=
 =?utf-8?B?eUFzWmZjSk5hR0IxYVM2NElpZncvV1lGTWpWeVhpbUlaSFBLVVhSSWsrYURI?=
 =?utf-8?B?V0RGalJhbS8zQUhoWXFySGo4bmNlTHhBRHN0UTJ5NG5rd0Z2UjlvU0FJOEhQ?=
 =?utf-8?B?VERNdisxOWtFa1QxMDFjcVVlalVCUUhrR2F5SFhyb1BiRFY5OEtzWDJieGZD?=
 =?utf-8?B?YnViRU1DUDZXVmVROUJNYWFzWVRGS1Y2ZnRDbis2N2VxSUQ5TDRKUnNKeWpD?=
 =?utf-8?B?THhwTEJsVzBpaUJ3ZW9qbVp1cHZiSE9LYkxBVlVQU1lGUnlvME9ZYlc1Q0tp?=
 =?utf-8?B?RzZ2RWMzS3VGU1BpeU9wVHp5YnNFVDd1cHJxeDJUcDhFR2V1NFdJTHd1Y05a?=
 =?utf-8?B?UEFuekliNE9vQ1dUdlFub09yNUltU0tsTDIwbnBJaXJsWG1qNGhYbk43cER0?=
 =?utf-8?B?bXUrY0psZGRtUWdmTXM2MnNrUCtBd0dKMG55T3FPY2ZESDlMMmw0b2w5bi9M?=
 =?utf-8?B?WHBLK1AvY0pPZVZlbGlGd0swVG10OVFEMElDOHRsbVUvNVdoN0VRZnVYTW05?=
 =?utf-8?B?THBQSk5xd3ErV09ldmZsQW1QbjJwWDUxckszUHNTUU5GQjhaYmpKZDRtaER5?=
 =?utf-8?B?NmpTUTFPaFVUc1REQlpUSzlqeGhPZTlrb3c2NXRZbHgrRG5xM3dsSUU0bSs3?=
 =?utf-8?B?V3ZabUh4dytCeGtUSDRLaWF5cVY5YWNnV1VSeWI4Z3VEWFZwcnNPczh2Q3Ja?=
 =?utf-8?B?QVBmU2drNnQ3dXN2US9sSkdsK0hocGxJQU9XYlVuVGh3TTd5KzhtMEcyTncr?=
 =?utf-8?B?SUtYYlp4RzI2citxZ1Z3NDN1MVpNYzlwSXZ6aEJQRmtQK0MyNUV4ODcwUm5m?=
 =?utf-8?Q?SyegreIqhP+DiIoxtQg9pn1Ec?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a834b199-669a-4677-cb97-08de30b05bb8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 08:05:14.6200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sIm+UNuDbdIY0q3W7gQaT1kXoVMdtKPy5gX9I0xfkw2+1quiakl98YNpLexkg4Icxgh+h4W/6egZBc7b68mOgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8187
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 01 Dec 2025 08:05:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20775

From: Jan Kiszka <jan.kiszka@siemens.com>

Brings some smaller fixes of which we specifically need the one for the
ftpm hook to ensure reliable booting on the TI AM62Px.

One API change comes with this version: INITRD_IMAGE was deprecated, and
the new IMAGE_INITRD is takes now INITRAMFS_RECIPE directly. That change
came with several issues, the critical ones are temporarily addressed by
two upstream-pending patches.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

I've queued this into next now, right before the merged defconfig 
switch. Should resolve the issue seen so far.

 classes/read-only-rootfs.bbclass              |  2 +-
 ...ling-of-initrd-generation-if-there-i.patch | 39 +++++++++++++++++++
 ...revious-naming-scheme-in-INITRD_DEPL.patch | 32 +++++++++++++++
 kas-cip.yml                                   |  9 ++++-
 4 files changed, 80 insertions(+), 2 deletions(-)
 create mode 100644 isar-patches/0001-rootfs-Fix-disabling-of-initrd-generation-if-there-i.patch
 create mode 100644 isar-patches/0002-rootfs-Restore-previous-naming-scheme-in-INITRD_DEPL.patch

diff --git a/classes/read-only-rootfs.bbclass b/classes/read-only-rootfs.bbclass
index 054f2725..81e747c9 100644
--- a/classes/read-only-rootfs.bbclass
+++ b/classes/read-only-rootfs.bbclass
@@ -10,7 +10,7 @@
 #
 
 INITRAMFS_RECIPE ?= "cip-core-initramfs"
-INITRD_IMAGE = "${INITRAMFS_RECIPE}-${DISTRO}-${MACHINE}.initrd.img"
+IMAGE_INITRD = "${INITRAMFS_RECIPE}"
 
 do_image_wic[depends] += "${INITRAMFS_RECIPE}:do_build"
 
diff --git a/isar-patches/0001-rootfs-Fix-disabling-of-initrd-generation-if-there-i.patch b/isar-patches/0001-rootfs-Fix-disabling-of-initrd-generation-if-there-i.patch
new file mode 100644
index 00000000..9b8e7a67
--- /dev/null
+++ b/isar-patches/0001-rootfs-Fix-disabling-of-initrd-generation-if-there-i.patch
@@ -0,0 +1,39 @@
+From 1d31b8e84b8d802b7d2028112b10c7130f671fba Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Sat, 29 Nov 2025 15:12:20 +0100
+Subject: [PATCH 1/2] rootfs: Fix disabling of initrd generation if there is a
+ custom one
+
+The variable is now called IMAGE_INITRD.
+
+Fixes: c3c4e72cbfc4 ("image: introduce IMAGE_INITRD, deprecate INITRD_IMAGE")
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+---
+ meta/classes/rootfs.bbclass | 4 ++--
+ 1 file changed, 2 insertions(+), 2 deletions(-)
+
+diff --git a/meta/classes/rootfs.bbclass b/meta/classes/rootfs.bbclass
+index 70d4bfb8..eb5645af 100644
+--- a/meta/classes/rootfs.bbclass
++++ b/meta/classes/rootfs.bbclass
+@@ -23,7 +23,7 @@ ROOTFS_INITRAMFS_GENERATOR_CMD = "${@ d.getVar('ROOTFS_INITRAMFS_GENERATOR_CMDLI
+ ROOTFS_INITRAMFS_GENERATOR_CMDLINE = "${@ initramfs_generator_cmdline(d)}"
+ ROOTFS_BASE_DISTRO ?= "${BASE_DISTRO}"
+ 
+-INITRD_IMAGE ?= ""
++IMAGE_INITRD ?= ""
+ 
+ # Features of the rootfs creation:
+ # available features are:
+@@ -33,7 +33,7 @@ INITRD_IMAGE ?= ""
+ # 'clean-log-files' - delete log files that are not owned by packages
+ # 'populate-systemd-preset' - enable systemd units according to systemd presets
+ # 'generate-initrd' - generate debian default initrd
+-ROOTFS_FEATURES += "${@ 'generate-initrd' if d.getVar('INITRD_IMAGE') == '' else ''}"
++ROOTFS_FEATURES += "${@ 'generate-initrd' if d.getVar('IMAGE_INITRD') == '' else ''}"
+ 
+ ROOTFS_APT_ARGS="install --yes -o Debug::pkgProblemResolver=yes"
+ 
+-- 
+2.51.0
+
diff --git a/isar-patches/0002-rootfs-Restore-previous-naming-scheme-in-INITRD_DEPL.patch b/isar-patches/0002-rootfs-Restore-previous-naming-scheme-in-INITRD_DEPL.patch
new file mode 100644
index 00000000..9570597f
--- /dev/null
+++ b/isar-patches/0002-rootfs-Restore-previous-naming-scheme-in-INITRD_DEPL.patch
@@ -0,0 +1,32 @@
+From 9e64d1bfadc310540be73b08b58db67eef207c66 Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Sat, 29 Nov 2025 16:03:24 +0100
+Subject: [PATCH 2/2] rootfs: Restore previous naming scheme in
+ INITRD_DEPLOY_FILE
+
+Might have been accidentally changed, specifically as initramfs.bbclass
+was not updated as well, and that broke downstream users of
+INITRD_DEPLOY_FILE via wic.
+
+Fixes: c3c4e72cbfc4 ("image: introduce IMAGE_INITRD, deprecate INITRD_IMAGE")
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+---
+ meta/classes/image.bbclass | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/meta/classes/image.bbclass b/meta/classes/image.bbclass
+index b030024f..d367d8c7 100644
+--- a/meta/classes/image.bbclass
++++ b/meta/classes/image.bbclass
+@@ -29,7 +29,7 @@ INITRD_IMAGE ?= ""
+ IMAGE_INITRD ?= ""
+ 
+ # Name of the deployed initrd image
+-INITRD_DEPLOY_FILE = "${@ d.getVar('IMAGE_INITRD') or '${PN}' }-${DISTRO}-${MACHINE}-initrd.img"
++INITRD_DEPLOY_FILE = "${@ d.getVar('IMAGE_INITRD') or '${PN}' }-${DISTRO}-${MACHINE}.initrd.img"
+ 
+ # Make sure dependent initramfs recipe is built
+ do_image[depends] += "${@ '${IMAGE_INITRD}:do_build' if '${IMAGE_INITRD}' else '' }"
+-- 
+2.51.0
+
diff --git a/kas-cip.yml b/kas-cip.yml
index 806ba182..8e26d89b 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,9 +22,16 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 5bb743ad0ae4e87ef5a14ce4897c14694b46d0c5
+    commit: 2efd5d4ca3b4abf2386fe0089594029becdf2801
     layers:
       meta:
+    patches:
+      p1:
+        repo: cip-core
+        path: isar-patches/0001-rootfs-Fix-disabling-of-initrd-generation-if-there-i.patch
+      p2:
+        repo: cip-core
+        path: isar-patches/0002-rootfs-Restore-previous-naming-scheme-in-INITRD_DEPL.patch
 
 bblayers_conf_header:
   standard: |
-- 
2.51.0

