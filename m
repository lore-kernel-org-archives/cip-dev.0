Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7532DC7115B
	for <webhook@archiver.kernel.org>; Thu, 26 Jun 2025 05:10:40 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.55])
 by mx.groups.io with SMTP id smtpd.web11.1422.1750914629464596233
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Jun 2025 22:10:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kU66Lios;
 spf=pass (domain: siemens.com, ip: 52.101.84.55, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UalnwAUCq62m1Lb2rVLwnhUmDecFDVr/U5OklStFTm5LnLLQT1gFf9ljVB5YKttZuUjpoy69aridjFVLaWXZeujN4zQpvoqKMcRXdrrLVIWDtldtQxFDCkcDxBWrPv3E053iUCQ9F6fO2Vz63wEX32EFB0Cj4DqU6bmGgGsjtQpbd9r4/tGFL49oVPg3fcu89Xbj/qtbQ5sExxiKNX3pZzHfC3WrFTzuR5MrCKthZ+qsycofmjG+d0NFwRoDQJ53PLb4M7bNmhZlssFsYh23UCF9xtO3RxNS1Y9bn55fXuGALASN+aQPH6HMsQmahgl5f2s2Ktk5nXunYEuFoQFy/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvKflHSNGC+C67AmL7ZwBg+7IltJqI3qmqAdDRX3LGc=;
 b=wXutLTg6W+D1hXFWL2gT1M+cznmmaGJvkZ8bb70xnqJ3pENatwnJjc9r/x30lxUWui3W11FVxxy3yAmVzukSEpNI1AFvBL17b79qJGZCBCRyejVA1ZnVNNooN5Y2To6LGIGY22OGnYKu0BUC8Tv0Fbxcmt5+/0fWN/vuPRR4ebtIb0Hr1iJRcFQkx7vvyD9ZAzNotnmp/nfJM+eu4eKE+1ovsE//MpfABgNCtCEl/TgQdIgHCjvEj7thzGLAtp6AOqpPStogq39iuFeOZMI2bbroPbGFBkNzQANASlukI4E0NeTSGl/Kl8/hWzLOGTLYC7JyjNk0qHFVRCvuZ3mPMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvKflHSNGC+C67AmL7ZwBg+7IltJqI3qmqAdDRX3LGc=;
 b=kU66Lioso6IH+Nu0dyORmFa52PwDQx4OrQ9LB4yAfd1ceYLzTE0bsRIjkO6ZG0fI9nbixPEhVQmsGUyPWbtRE/RCaKiphYj5jX5PkvExOhJe5SNXFUwqREEhu83217DXjRosY5ctCpfUe5Lmt98ZgV+OzkUyVV3VvMlZteLqN8s1mC9HXGGPW+WtHuQ0CfQ9xepXxHBbmIujukzVFMFtE7P02fDS2loZcbffHgB1cVE3tZn0TOljS1Lxuef8R44wO6Rk0D5yBqSDiAMEoqXSijyNhAxXQZYXTc74KjnHjP51khKTq4+brRZNvXyePQjmP/gM/pD2fkcB6L6TKVG8Jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5308.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:336::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Thu, 26 Jun
 2025 05:10:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 05:10:24 +0000
Message-ID: <b96b9a14-95d3-409f-ba47-3202b68f7022@siemens.com>
Date: Thu, 26 Jun 2025 07:10:23 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
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
X-ClientProxiedBy: FR4P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5308:EE_
X-MS-Office365-Filtering-Correlation-Id: 55ff8129-28fc-43c3-e7e8-08ddb46fc1b9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UmxpWEpGY1FGdVY4dkhkNGNhQkZ4YW5IdnJoTStPVUg0MUllYis1Qk8vb3Zj?=
 =?utf-8?B?VVRIMGxNMHZDTVp1ekc3T2hxSkJZS2tKcDlyM08xLzRHUEZ1S2dqRCtNNnp2?=
 =?utf-8?B?VDFwWEZYTTZtdGM0WWJPck5ocExNWW5wMVdkeFpvSXBVV1FDbjhxZTFaUytO?=
 =?utf-8?B?cVVIbXpmelpBd2tqcTc3YTZWeGZhb000TmJXSGdOaUJLcUVOR3AxTW81Y3FT?=
 =?utf-8?B?cHF6Wnk0QXNsT1BkZWtNZ0tlR2ZWMXY3RVpZbjFVZkY4NDliWHJYK1o0Z0FJ?=
 =?utf-8?B?bmNtT1E3aEZaWExBMFk3RWw1cFFjVnJtU3plcklrUlFIVFByZklDVDJ4L0lB?=
 =?utf-8?B?Z3dKaFRJd0ljU0Q1eC9veGNBek1UOURUdzBidW9tMFlVbUtiZ0oxcndmZnI0?=
 =?utf-8?B?bStSc01rbEZ6NjYwajh1aG5iZU5rSC9mVGNxdzlyQnJwS3c4THh1TlcyR2d0?=
 =?utf-8?B?WnhDWmlCbllXcmhDV1N2QkJCUWh4UmFCWkxOQmE2QVhIUzVaMHFmeDZ2VCtX?=
 =?utf-8?B?alMycmlPQkVCaWwzYTE4c1Z4T3UrS1lQRUh1bnJVdWVZdHdab2lVRFRUalFB?=
 =?utf-8?B?aTdVNFB0SFJwcEZyMFkyRnUrMGRVZ0JVL3E5anN6c1NOb29oaFdMTFlWc1ZM?=
 =?utf-8?B?UUxNQlk0bURJVHBTczlMWDFKY1d6VEdvL3BubzJ0ZVowWnBUc2NZdk9vMmNn?=
 =?utf-8?B?dzFnd1BjZWFZVHFESTUyNFVuclNla1JoNjVWYzFEY0cwNUJLeW9LNE9HQVVO?=
 =?utf-8?B?NFVmanZ3WGt6cGZHTG42YStYMVFjZHBad2VvMEZJNnROSkdqTjNaZDFndXB6?=
 =?utf-8?B?bmdoL2ltaUVxQ04yakwrRTQwYTkzd3dMNVFiWEdwQndzZFNmQmpxV2I0MHlD?=
 =?utf-8?B?KzcrODhxRUErb296T2I0alpVWXpMTHI1RHRpT1ltSkcvZWh6VzRsOTQySUY4?=
 =?utf-8?B?cGtqczlwQzAzUVExYVpzR1NKeTh0MFdCOTNRYysxS1dpRWNQZUw3WlR4NnJZ?=
 =?utf-8?B?bWxqL0ZLNTVCMjBySmVBQUEzaFpSSWFhRHFLaWVWNzI1R2hHRjcyWklIdHZG?=
 =?utf-8?B?NHc3U0FzTDB4RytlL2ZuME44QmRBNE5qUzJ4Q0U3R0lhSHRKak9TY2c4SlFO?=
 =?utf-8?B?ZDJlYXo1cXRMNmtEQ3ZlMmdVQ0wvekxlWXZJRmEwSWJVV0piTEI4bWVsVHg3?=
 =?utf-8?B?Y1pldGloNWR0a1RoMDV0VXFjdFc0YU9iNkJMckN6TzlIdVovZU4wM01QamM3?=
 =?utf-8?B?YmlZTjgvQU9iNmpxNndSZVYyNHlkZk1tSmFONDZBZ1dmY09YNlIzNDBmbjc5?=
 =?utf-8?B?WndqcnFqenJZU3A1c0g2NFVrRmdOemxSWUd3OXFheDFYVzdtV1hiL1MzYmFy?=
 =?utf-8?B?RkYyZEpkV0RpeXcvQ3ptRUhFQ2VBdmcvakJMRHYrU1RzMEFHakh4OUUxa2Jl?=
 =?utf-8?B?WSt6R0MrWjRSN2gwZFJEUVZoZ2ZyZzlmN1JCT1BSNFFmWWRDS2FHTzY4bmRJ?=
 =?utf-8?B?am1KSnErRXYraHJHcUMzVXB1MnNCc2REQko3cUJtVlduQzNGQmp6NjFiTms2?=
 =?utf-8?B?a1ZBOHk5SVBIbWt4aDJhVmYrNjBGNTl1TU1lR29OVlVBSy8zM3AzdXlNR1pH?=
 =?utf-8?B?QzFLNWNwdi9UcE12MVNPZ05HNjdxdlVHRHJDbUJnNjZkWGN4ZUpqVTZsbzRG?=
 =?utf-8?B?TkRXR3h3QjFvWFUvS1g2US9wZE53OVdKYnB0QXV6QnNRcFRSMWZ5Q2xZY01V?=
 =?utf-8?B?dFpOU1NxY25yR00yRUtKK2lVZEZmRlBLQ25lMCtFK01Nc09lMFRsQmphU3c3?=
 =?utf-8?Q?aeJEUgFMT+4q3+ersaBnwxlQb8kYaNJLQ/fvs=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NTlkSHlSUWVwL1ZtemVjL0JBM3ZvUEhiRnJmQ0J3eUdJOHhuaEgweEJPeE03?=
 =?utf-8?B?dWk4T2t0d1NxOTFkVm9lWldOUGJuWmQrRnlHd3BFTlRWNG0wcXdDS1k0TDhM?=
 =?utf-8?B?U3REY2Q4Q09CZ0dsTldTM3d2cmd6L2VjQXk4aW5sMmNKL0pZWldOR1pkckcx?=
 =?utf-8?B?MXdYV20xbE0wNUljYlJZN0gzSnZWSjR4TXRLQTV3dUJIL3UyYzB3ZlE5VEJp?=
 =?utf-8?B?QWVxZkJBTGU4UHFyeXNvSk5NWkh3UGRhTFQ0MUFCVi92QUxTNHVkWUJmcnlu?=
 =?utf-8?B?bnY2QmtJNVdHOGVnSFFSOWFSOTJ2YitwSWJoUzNxR2pHY0Q0R29IZFFZbmJS?=
 =?utf-8?B?STdjaXZYcmo5N2poQnM1d05EOUFLV2Y0bXIyc3ZKcnVxbklrdW9HQWZwcXlD?=
 =?utf-8?B?OXdTTUF6YmFZZVB6cjllOXN0ellBWFJBeXNrQWdaaWU5UUYrWm9BYkRISFJU?=
 =?utf-8?B?SURubUF6TFo1bXlhZWN5d2pmSVB3SkZheEQ1bWRtN0JFWDNYQVRnUllUUmFD?=
 =?utf-8?B?YVJtL1ZnQjhHbERHakNxOVU0TGlFbEt5Nkxka0NYQktvMTF2UVlEM0NuOU93?=
 =?utf-8?B?cGtpWlAxWEdsV1hyaTJxOUpCNnc3NlBoUFp6VTlrTGU2VmFMOVZYS2x5RDlq?=
 =?utf-8?B?NG1id09LcGd3ak5RRUt5eGpwUjNwMnZrWjJCODZudUhlVU9uS3haY1dxVFAx?=
 =?utf-8?B?TUZtSFZ2Q2NaZ29qWWo3NzhBLzZZMHgzNTFSU0V3NjVmZ20xV2g2Z21LeFhX?=
 =?utf-8?B?bDZ6dGNyK2paVzhuU2k1MmRjdWRvaCtSWno5b2d1elhnM2JXZUoybUhINXh3?=
 =?utf-8?B?SDE1UmxTcEJGc0tucS9hZWN4Mm5qYlRDM3FybnRzYm1qRmo0MFFDZnZTYXM2?=
 =?utf-8?B?bkljTDArcHUzM2J6RHR2UUlpVHVHZlV4ZFpMb2t6UEJVK3FtVkFsSlF4dG9C?=
 =?utf-8?B?OGlYaFNjZ3pmU1hqV1VtS2M1ejJveDA3VmR4aXY1UEdvTHlHTE50dS93YStp?=
 =?utf-8?B?eHVwSDN1R05vLzFiRVZtNlhObVo4aGdEcVUzUmlNVjdTc0RxVWF0UE5XU3N2?=
 =?utf-8?B?cGJwT0dxVCs4UEVYenhtbXYrNWFNK3NoNGpFTWE0Tk04ZllDSDEybXNNS0xn?=
 =?utf-8?B?d2toa1B2WGNZMVJRNGZSbUJwZUYvVElsTG93M2hBZXRxbEN4eE8yUWlnTzk4?=
 =?utf-8?B?V0M1bHcxaEpySUVSQmJGNWxYTjR5a3RkdE8xVGxqZXdNQ1I5NDdxcHg1Y1pZ?=
 =?utf-8?B?am9yWVcxeHRvcENETjJ2LzIrNEpjblBwSjdEZndvUFRQRHM0ZVVsenlMWThE?=
 =?utf-8?B?dXA5aFBUTDZKeHY0Zy9zRlNNK3ZrNi9MditzQnNLWjd2SVRJVlpzcW9TVy9o?=
 =?utf-8?B?OG1XQlF0WFcxRHQzakRFQitYOUFaN280NVBVL0huTDNhY0ZPWWpOKzFacVlo?=
 =?utf-8?B?TzR1VXNsdUU1UGNkSEk4UjBLeW96V0VFMjdENXVLQS9Pek0vanpxWkhUaHZ2?=
 =?utf-8?B?S3lmM1RqN0NhaHdtZFc5OHBEU2ZsZ09oS2RralBsanMzTlVkVXhvUVFmTU1o?=
 =?utf-8?B?QmRaSVdxYzY5cS9WRE5xSExYdFVwSGg0Y1I2RUowaS9oeklqME5sbFFGK3Jj?=
 =?utf-8?B?MVErL0FWYkxhalFxOWM2M3ZTc2EybkdYM1J3MnA3a1NteE1hNWZFaWY2ZU5m?=
 =?utf-8?B?VzdPQkVVdlkybmY5b1pyQzVzTTF0TEt0MWtVWVhUY3E5cjBQNkgyQms2RTRK?=
 =?utf-8?B?dEg4YzFUVHllSUp2L0ZpdlVrSzFSbDBYQWhLSUdhZlV3VWFtSDh0S2c2M1hu?=
 =?utf-8?B?UENQV212YU1rV0FCVjVrOWxUL2hac3RaMkZTT3hiV3NEb01ZNlRJQXp0ZlZM?=
 =?utf-8?B?WFI5am9mYm1FWnJxc0tkNE1zL09qVjF6YkRkd2d4UE5DMjZsY04wU1ZRZHQx?=
 =?utf-8?B?ekhVQkpaZTA3UklzN1ErQ3kraEt6QUxMKzlHUGxUOWRJdjAraVUxZ1pqTTM5?=
 =?utf-8?B?U0xhYUh2NENSWDhNTDYyd3Q0b1BqYVViRklqenFiMHdhbHVvMTJEMVc1NkpO?=
 =?utf-8?B?N1A5Smg1c0o4bWpNb29hbTgzYm85VnZPN2JYMGpQVGsvaHBjdEJoZHY5NzBQ?=
 =?utf-8?Q?C+VAAXXtuCMVeyu+8+ZxVrSNl?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ff8129-28fc-43c3-e7e8-08ddb46fc1b9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 05:10:24.3284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ENvy7wj8ghN43QQ6n2+BQlbrdGn0KnhiyG5T13Pv0tp49Hh9/KoEbGL9rbiQlkIyMKpLBd48A698S+8qlvoezw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5308
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Jun 2025 05:10:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19235

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=6&day=26&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/06/cip.2025-06-19-13.02.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
Date the data is created: Thu Jun 26 05:09:58 AM UTC 2025
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed Jun 18 08:46:56 AM UTC 2025
  limit date: Fri Jul 18 08:46:56 AM UTC 2025
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Tue Apr 29 11:30:23 AM UTC 2025
  limit date: Sat Jun 28 11:30:23 AM UTC 2025
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Wed Jun 11 08:39:43 AM UTC 2025
  limit date: Fri Jul 11 08:39:43 AM UTC 2025
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Wed May 21 07:22:16 PM UTC 2025
  limit date: Sun Jul 20 07:22:16 PM UTC 2025
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Mon Jun 16 10:52:06 PM UTC 2025
  limit date: Wed Jul 16 10:52:06 PM UTC 2025
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Thu May 15 12:41:24 PM UTC 2025
  limit date: Mon Jul 14 12:41:24 PM UTC 2025
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Wed Jun 11 02:12:44 AM UTC 2025
  limit date: Fri Jul 11 02:12:44 AM UTC 2025
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Mon May  5 07:36:59 AM UTC 2025
  limit date: Fri Jul  4 07:36:59 AM UTC 2025
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Wed Jun 25 04:54:15 AM UTC 2025
  limit date: Thu Jul 10 04:54:15 AM UTC 2025
  Status: On track

