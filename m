Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28473EEB560
	for <webhook@archiver.kernel.org>; Thu, 12 Sep 2024 08:26:01 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.74])
 by mx.groups.io with SMTP id smtpd.web10.43221.1726129558328557116
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Sep 2024 01:25:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=GSLv2y7Y;
 spf=pass (domain: siemens.com, ip: 40.107.20.74, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3OQAiMbe6+UVV4vDKjj4DD//WYbuXewwLA9jzo9aAnzBmJ3OecNc6YrtDX31ervAHMgJzMS0Q+rKJlZ8FTeNmD1ngSaHkFguRQvv0dTAoviVlv01e2Eqy4JbPjhab3oPK+JIju5xMw6ou2mN9bfYSU/Elhq8UzjJVLkX3sKnpFsmDr+5IfZyvvK3GxEZjct5l/RrXhT00BvjT0dq3y/hD5yRS37sbE0EHZ+nQNiKdYUSr/6whq0mIutSvtk9heV0NE+lI83jZKFqvJdi5pR2kQGnb3u0UzI+NwF7y8JtCueUBo3m3YukjrTO25KdHEDmNy2YkM3FlPg5P4AxStdhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rK3ccjugCOEQg8FwgdCXjqd9Ve3RuBN8wZaOthz3F/c=;
 b=aQRSGYGIgXtPmx2NZqo4Cr3SkNXgx9gQJ/etR67i0igDBGlVym8FwG7nxwy2Go4uVI5T6UB4sjuLQ9LbIJSdimPzQ6BYzqais3pJtMgkDaKn8kBtAJzUTaK7LjpDPMc05x2c1MH9W5z5E8t1tf+SQA2NBoNcALbjEaJ7onjk4rLsdRTk4KipUlQKX4nU9opUD02+Bi2kNENjPfYfAFBdIM+Qrm135ew4RR8IfYvc3Olk/iaysXDyoZE+muKz+c8QAocuTph+wvj7RicBfHXT+8W2EvBirtE5sg2fL9em3ir4lcBOSuZZ/naWJ4EBdZ95uIsYAcTL2x5GTmDeTZ8eKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rK3ccjugCOEQg8FwgdCXjqd9Ve3RuBN8wZaOthz3F/c=;
 b=GSLv2y7YN2MLE/JpF2k9fk6ZyX6GgPKIZ7tEzdlcWFM226AStpGqIEncIIrOdOUKpv/3VpwS88LhRcgr0b/gHOCJPghc+oDYU0VjveH6TwtlAXcuXzaVd8xUa4rs9GDZO6oV2+pDV4A2IG49ACb+kmi3t9C7ghNZEoNq0TrYr6K2BJd4Dk7l0tlVZFo6RBhYG6eYQrnL0S63gqytc9rE721QNIJjn5DQiDwfpqBw/YMO5UPa9jGXYKYu9g/OaNJftHjoMRr58Bo5Tkeg5jzBglR6vtB08Q+nKBcBi1ZcIsnMIQYWpVwvm7VkwyaLFTqiqICwRj0LhKk7orJt9cuR7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB9046.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:563::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Thu, 12 Sep
 2024 08:25:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7962.016; Thu, 12 Sep 2024
 08:25:55 +0000
Message-ID: <0869e12a-1bfd-4e41-a22b-d273c596d8da@siemens.com>
Date: Thu, 12 Sep 2024 10:25:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Please enable CONFIG_PID_NS in cip-kernel-config
To: "Moessbauer, Felix (T CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <d2aba9628d363afe28efc0ffcb6596c4fa0eed33.camel@siemens.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
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
In-Reply-To: <d2aba9628d363afe28efc0ffcb6596c4fa0eed33.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0382.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB9046:EE_
X-MS-Office365-Filtering-Correlation-Id: a6871700-da75-409b-8fc9-08dcd30485bb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WlcxOEVuNno1ckZKNnZWQVg5ZU1Nb05iT3hYTTR5QS8zWFZYQmswY3JtUGJw?=
 =?utf-8?B?d0d0ajYwcGdVdkR6MlRONXFlbU1YNDBTSUFrWUY2YWt2d2dMcndrMWU0eXhi?=
 =?utf-8?B?YVB5ZVJocXVkRllsTlFqRGR1VHR1ZEpFMVZOTExRV01CSUJVL0pHUzhoOUFz?=
 =?utf-8?B?bFJ2UWhQWVNBYnZlY1Y5OWxVdHZRS2FpNCtEeWJZS2o3UWZmRzZ2bGdNYXJm?=
 =?utf-8?B?TmpZOUtjRzhlRmErTTYwR1BUY3ladjFPS3ZINjdzeWsvOHhDZE5Pelo1cEgv?=
 =?utf-8?B?WEVDSENvdnF0c2hncWg3dGVmbFpHeG5nMXMyQmxySnM4L3pBVFh3SmZrc2lY?=
 =?utf-8?B?cGg5L0VmbExudTJXVlViMVB5Tlh0d3N0dkIyTTlGbUtSZFJkcWpZSWhPV0c2?=
 =?utf-8?B?b1BiL1F5cWVDbmZFRmZkTnpRVUQvNmlZK0ZEeHR5Snp2cndleFlVTThMVXVy?=
 =?utf-8?B?VmhrNENvei96aGlxZkdjeEhFWWJBS2RJZnpxdEltcFYvdzZnWmhjNUo3L001?=
 =?utf-8?B?ajFwbStUc2dBdU9NRWNEb2FHcjM2Zk1obnJXY3NBSUVIUmozaVg0NXV6MHRq?=
 =?utf-8?B?ekJvdEpNRnhwK1Q4WWQySWcrSnpsbzRuM25tTlZhblA3Ujl5WllqZ2ViVERx?=
 =?utf-8?B?c2hwTTU1bWtQUzlERXlqaGNWZlJmRlNTdkQ1YTRSMFRlOHE3R3RMa1A2bHdG?=
 =?utf-8?B?Y0JYbkRBd2hxSDlSSzVVcjVzOUQ5L2s0aFB3TEFyYWpUc2M0UTJoU1JQaitp?=
 =?utf-8?B?ZDVGVzB5SDcrbkVydEs1d0xEbGVacVE2YUttV3QwWnUvajNwejZGYzRwVnJM?=
 =?utf-8?B?SnpscW1rUHBHaDdiZ3RVWS9VZ0w1MlMxV2pzS3g3NUxGS1dTcWU0elhQNDRw?=
 =?utf-8?B?UWlvUGt3YTQwd2ErZjNJZXhzdVlkVlJzTlJrdEp2VWh3d2doTWlIWW9sbXhE?=
 =?utf-8?B?VXJ5aW9CUnRqTjJzbUpuenZpb2V0M09wcko0WFNiS3ZOUStjc1ZJenpKbkdI?=
 =?utf-8?B?Yy9NZ1BtU1ZocjFRQjhqbnBQeXcwUFJORWIvTDBRcDFmeVVUZUtpNnAzZVRF?=
 =?utf-8?B?c2M2T3cyZXRieVZkZDBsNkZRRnFnTm4yNVBkVGlXU2YzdGJqN3Z5ZE1jMmVY?=
 =?utf-8?B?NmU1N0hSRk4yZXd2OFN6OTNVdWRGVThWL0tRR1NRY01jWEYySFJLakJpT3VM?=
 =?utf-8?B?TFlVWTZQUkRtbERCZmhhNVI4SnRvT2w4ZUo0Y1BzYmU0ZVhoajk1NzJiSUo2?=
 =?utf-8?B?b3BUUk9QeE1YR09LaHZMeFdqbTh6RHZhcGF2dlZJbXczUU1pWEFrd20vcXlY?=
 =?utf-8?B?TFRvU1AxcDkzcWRacW8vYkFxS1BvN2JoeVVWcmFCMktrUnVhR3FjbGoraFV4?=
 =?utf-8?B?aUZrZGY1MDNKTzBqV0hXZFF4Vm13eW9kTVVuVTBWTGlIT2c0STExUFlFdWRi?=
 =?utf-8?B?dExnQXFzRzVBUHJpNWYwUXhPbnE2Vi9uL0o1WlA5MUZzTnRsaUM3T1VtN0E0?=
 =?utf-8?B?K2o0Uy9TL0RmekI4dmc0bVhsNEJPVkk5TUEyNUVhRmdZS0hjVFF4eWJnL0wx?=
 =?utf-8?B?WWhyQzdJQWc2NjlVNTF5WE5vNlhqRFR5L3BqNmVIVkxWUG5jS0FXNmt3RS8y?=
 =?utf-8?B?Y1l6aTBaa1BjbzQ4eUk5OVVpMWYrTVhlNW1vN0hxNlU4RCtidkxuUUlySzFs?=
 =?utf-8?B?U2grV0FpVFB2WUxCSiszK1UvZUd1WTZaeDVsT0c5MGMvcXl2YklCeE1JcEtU?=
 =?utf-8?B?SnRGMFJRVzNNZTFvaEpjeStoVzMyNHkzWnJ2eG5DTzk5RFhwZWQvcDJrcHhJ?=
 =?utf-8?B?SUZKQlpMbVkwNVVFRFRyQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NGdnOHc2ZFk4Y21ZOXFHUStKOG1PTTVZSU1KamNTNUx3VzBrdktpVTVyMy9Y?=
 =?utf-8?B?QjA0bFhjUTYvaWs2Y0tQeVY1MHVkT2VDZnZBTDlkNUtoc2hDRytBNzUzazdr?=
 =?utf-8?B?VGM3b2VqWG1IQ3lZeGdzVFRCa0IwdHh4aDVabktBMk05dUJpaENpSFBPUWts?=
 =?utf-8?B?Y3BqemxYVk5NeGhSWjJVWTUySHlHRFFxQWp3QXQwR25kOWp3SDl4K2RQRDdp?=
 =?utf-8?B?SjhEUG5jYUJkQ1FTNlhSTkEwamxKYkRnb0Z6cEFFRSs2ME1nWkdiT1dwUFZ5?=
 =?utf-8?B?ZUdhZ3d0OERhQ01RN0U2ZGZZUUdrMlFNd0xlSWRDbVcza2lkM3F2NzM0NlFP?=
 =?utf-8?B?VWFCSnpQaHI5MmFMcGNmOVpnN1hzRFNqQ2IwanFTNmpDa0g4S0V4VWF2VnZB?=
 =?utf-8?B?RU50K3RpRGkwS051ZjFyUDBMZ3dIT01WRzVoTFFzdVJiQjJuVkFHOWRIVzdt?=
 =?utf-8?B?SXViMmhKQTNoYUF2S0crMjFCYmQwYUdyK05BdjVRd3hWZzBPRS9BV0VHQzhv?=
 =?utf-8?B?ZjNiSEhMckFMNTNsbVM2MHAvY2Q3MWI3NkxuZ0w3TVlsejRpRk5uOFJlQjZM?=
 =?utf-8?B?M25nS2dnWmpDckFSLzVha05pK3VVWVlWWklXUGVjaUFPYUVzSDlqSk15RGlK?=
 =?utf-8?B?TXhhckFSamNqQm45MXJHcmh5d1pLcUNBUk5tNGNzOUozZFNIbXlkd2FRSWtG?=
 =?utf-8?B?WllOT2NLZFFWRWRHMWhLcTNxVlAzNWF0ZEFKUmF4RXRpL1l6TnJwN1dpS01p?=
 =?utf-8?B?VUlEbjd4QVNkWVBFR2ErQzhRM0NjelVmcFRrRCtVNGljYi9sdjRSQVpzM2tL?=
 =?utf-8?B?UTl0d0NJYVJtZ0hvMWo1TEgxdzRSYytuZVhCbXIxOU52TWtMK1hpSzRGZ1Nr?=
 =?utf-8?B?a2RpWFQzRS8xWWpUMVZCS3FGK0ZjNlRsbjlERkxhaTdyTWtQdDJRMkFYdkgw?=
 =?utf-8?B?d21NNEZ0ckg1NDR3dXlPaGFNdmNhK09ZNitHNGlFK0w5ZnNWRWhTVU12Wjh2?=
 =?utf-8?B?eFpXbFhlTmdTanBDNjRKaDViaWJUenl1UTVkMU0zakFRSElWMDloYTM1VkN4?=
 =?utf-8?B?eXdKWms1K1BEVUxLdjhSYXl1QWpqUm5HdWRoOGxhZUpGMXZYdWtoWVpLbHB6?=
 =?utf-8?B?WFJoYmZCcjFiMkJNMGd6R1FKcGN2UDdWaGhGL0NsR2VEdGxyWG9sN0VpUXRE?=
 =?utf-8?B?eGFSNUV4VnBlRFFrWHhUNVZFeVlCbklJbndaL1JmeVJ2a01COWd5aVU5Njdn?=
 =?utf-8?B?MWo2RlpVMm1iUlNjb2VMTktJdUZjSk5FdW5YTjJsZGRaeTF5eTFSL0JsbURK?=
 =?utf-8?B?dmREM2M5UXYwNmR0MUtCYU02VU9vOTEwbEwxL3VKNXRtalFUbExXZFFMdmRP?=
 =?utf-8?B?cVRoY1YzVVVDME1yU09RcDNkbVJpdDFaMkVDQ3lwK1Y4Z2tHSHFtUkdZUXhu?=
 =?utf-8?B?Y2x4MHQzNmNuQjIrWjczTkI0elZIMmNvL2FDUnhnYnk4ZmNUTW10R3VFcVhD?=
 =?utf-8?B?Qmx1b3Vjbk5nT0pzcWE0UERaZmJidFgyMnlzNlZpdTl1c1MraWlEcG5NZ01R?=
 =?utf-8?B?YVhrZEgwejh0VjZENlRVUjFMZWsvSko4ZDlWVXRpa21vK2VlWHdEaHBqckxt?=
 =?utf-8?B?aFM4STlobVdmM0FOQXNKcEJVTDcxRjlRUVlYTDlJY2dlcG9SSnM4bGR3TmF4?=
 =?utf-8?B?TmRrS2h1OHNNTHFIUk9kSGZmOFd0TzhMSnIzTmcwRWdicTdxcU0vVjc3Q0pM?=
 =?utf-8?B?U3lEU055VFBSMkZFakZpRHlxYkNzdnpVdlVPOEpKOVlVR0l2RFZFZ2VQKzhD?=
 =?utf-8?B?VWM5aHNpNXZxR3lmS1REc0pZK2hqRXplM1U3Z29LbGwyaWhZTUdJRjBuNTRZ?=
 =?utf-8?B?OGJkalBxUEJRamMzV1hBRUF4cGFreFpCOU1qZ2FyRHZYZVlNS1BVWElFWC9x?=
 =?utf-8?B?RUtINVVLMW9haFRVcHZ2TVFXWHUrS1VvbzlMdFFybjQrVUlReUZ5NFBXdUlG?=
 =?utf-8?B?MTJtWm55TWtKLzVZd3hQUkhadWhFR3hNOGZ0cmpEalFWNkpzc2NMbEx6dHMr?=
 =?utf-8?B?QVRqcW5vazcwZE5qVE9nbVBXamlML1FZMkVEZy9TZjhhQ0F5YkZFN3hTV3Qv?=
 =?utf-8?B?WUJMZHBBbWwydDE0R084MWw4Vk9xcERVRjlJZkJLYkRVRklyWHo1RXVqeit3?=
 =?utf-8?B?RWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6871700-da75-409b-8fc9-08dcd30485bb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 08:25:55.8059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UXAJd+FeRFtOypu969DLmp82l+xbsDJZ1rdVZe1ouO/OpyK0ZIXFfgAHU/DUZ7BIPzLzisi11JshibIXyj15RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9046
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Sep 2024 08:26:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16887

On 12.09.24 10:18, Moessbauer, Felix (T CED OES-DE) wrote:
> Hi,
> 
> running container workloads is quite common these days.
> To allow rootless containers, the CONFIG_PID_NS needs to be enabled.
> 
> Would it be accepted to set CONFIG_PID_NS=y for all kernel configs from
>> =6.1 on?
> 

You should know the process already.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


