Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1ECCEBF72
	for <webhook@archiver.kernel.org>; Mon, 30 Sep 2024 19:44:23 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.44])
 by mx.groups.io with SMTP id smtpd.web11.64622.1727725462355153016
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Sep 2024 12:44:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=z3UiiS+F;
 spf=pass (domain: siemens.com, ip: 40.107.22.44, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ElvZzPnd3DS5amTcBPZkscWmsdkLzWebarAXdS90a9lgu9wZIUNAlUTtByR5Kokw58YFCS7OVKyuVru0fOPoDmE52L8qaacWtW23DLUE4zFAXkv48rOwwG47N8JaQjit4nTUf+6wj87o9kB8I+JxG4G2cqpJHRaK+7JPr33T25SRlZ0/EKX5qx4g40Go3L5XN6E1XQ3hbDvYU7FSurnL73bwxckhCI58pqMvwrPhFt6a/JI3N6A4dabrjHeffYUz0BnJmHHf6xfOEKa6Z7nEkQUDLAt2HNKG3MWFbRbuyHM+C/YXJznrnO4Gc4TbDa6TgZ4Iyeu+9HMKuQEYlXIqSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYUUzIleib1TRPw/t8LBlBD0Tpi3MH6cv059t3mIsTg=;
 b=NazyIpx1kDa3aKDAQPTU8FEHC+YKh1vdNFF/cHiNjlQ3DlwaD7f1SHH/92VMlVP4VhVST/DB0xdLHspDG8ZZ2zoL1l1RU+WS8pD9fdCIus8QSwtT9L7rCHlbX0AjWptLmu1nLgVyISly0NSFlCSWk594QErZ3ZQ0CET8vGystr48qtTmhW7dsCiuzPbf8lLO8VYAwn4FWBgBGhXSJashPYmPKS8Y718ey4bHBYZwjH9dJb6ie6TyysdzVrrTYN4ypQoZ4quNZ3HSrDMqJbHJhjh2n4Dc9nvMqCnOp7ut6+UvpetrzDYQMbHCNzL8/F6XVjcK5Psfaq7162rxMdc0BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYUUzIleib1TRPw/t8LBlBD0Tpi3MH6cv059t3mIsTg=;
 b=z3UiiS+FOrqxteEtp+xPKxRdGnfoZYMH8UotlJDIlNGC/lt6LlsxJlLUZyCxsL4tWm9zxIbzcGKykUwyhH34r2nXeoPVTufY8XHchVtp7v+b3W4Wvla26yPFcqHMEmxf2zVKa3O90qWxRHZWt01TRIPb/PitXjPnbsZFxqm0oVrxOahaw/FjupvTwYSxGjrS9Lkuj8+Z4of64aIIZPmU7UTp6UQnEKMPp6UEZuXE8i6v44gINQh9b0CrArpW6HJID4C5RJVbDs79jAeHgrnO45daebHIVdcId0DHJDIVD+U4jDfxq+PdLEMhdId4OnNthpJeivJZde/FTbADegq5mQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DUZPR10MB8070.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ad::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 19:44:17 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%5]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 19:44:17 +0000
Message-ID: <50918343-84be-46a6-9c9f-26eacd979faa@siemens.com>
Date: Mon, 30 Sep 2024 21:44:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] Update isar to latest master
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
References: <67d44b1a-a1af-4a05-a5a8-20211a3d8095@siemens.com>
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
In-Reply-To: <67d44b1a-a1af-4a05-a5a8-20211a3d8095@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0386.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::14) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DUZPR10MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: f5f40e15-1710-49da-c101-08dce188450a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?T01wYUZTaWxBM1d1RzI1clNkSWRGRkIvS2Q0MlIwYlVjSnQvT1ViVXk1cWFW?=
 =?utf-8?B?L1pJMzNWRmk1SzlBclBEUFJhb1ozK0VZYjN2cU5FZ21hZ3VDK1FuZHhJbEky?=
 =?utf-8?B?ZFZ3QlJXektMQ3BsRlFQTm8xQzNyQTFCVFlMLzFOWGZ2ZTlxM2lCZkdkVGpu?=
 =?utf-8?B?aTFHemN4Yk1qai9hVFgybTBwSGJlalFjRjlGMmJ1ODhPdkFLRXB1cVRKUktv?=
 =?utf-8?B?a1c3WlNvcmRVQXQ2dFFQNlNDenhUUTJhSG5uVVA5MjBCc2pYL21LelNrZENR?=
 =?utf-8?B?UEpjY0toZDJMd0Q4N2tHcnJiNlFqZk1DakZMck4xYmhJdE5wNUN3bXJic1or?=
 =?utf-8?B?MitUWS8xOFlhTjczQndxV3Jib1hCY3cweTNMZzVIU2NDWGgrTEY0UUdJSUhT?=
 =?utf-8?B?cHBsNDBPTDNLVnNqM2Z4RWZBeG5heDZVMTRzaVJrQXNDaHhSYmpjWEhCU0hN?=
 =?utf-8?B?a0tFSGpVSVU0QjFqWnBNRjJmd3E1VjlNT2YzTnhvVEZIYXp0dnEvVTk0bkt1?=
 =?utf-8?B?TkxyN3VydDB0OGJkRk9KaHdBVHVHdGh6M3l4ay9lTHRjN2V1U012VHZQc0xi?=
 =?utf-8?B?SThhMlZMdGl1Y3lod2MyRmJYWUgrY2VIRGpicnpITEt2c25qZ2ZYVzJqWG93?=
 =?utf-8?B?ZWhqdVp2TXFHcjJiVWx2ME5naHZvbHlDY1l5cUdWNTY5R0FDQVRaQkZ0UXpH?=
 =?utf-8?B?T2tBYjhxRERGbVVqZlBmRk01cEVnRkJ0d3lEYjZuNnc5c1cxWUZvUlYyS3do?=
 =?utf-8?B?T2xKdEhHY1JPeGxGWjNGdWZyczRTSFNlM0FSVk5Kb1B2bVNORkhBWTNncURv?=
 =?utf-8?B?ZzFWdFYxaXhyVndHMHdnUDlTVVVSNGJCOHdkRWR2WDE0ZitqVTd6K3BMQzdU?=
 =?utf-8?B?cW1GaHZYaEZJZFl2WG5VVkU1NmloMHNxMHJ1N2s3N2hENlBPaUFtS1JSOWY2?=
 =?utf-8?B?Yjc5WXZZZ1AxYUNEUnhJd1ExUjZJMXdZeHdnemlmanpKQVloUXdKdmZEakta?=
 =?utf-8?B?bVV3a3RRMGV1M3B0citwYW5DeVJhWHAzL2MxL2hydUtHNGRVMHpWU3VVZjAv?=
 =?utf-8?B?RisxSytvZWhiUWdtSWIwajQxLzJQNkxGMU9NT0N5RnNLM1RIb1hwblQ3VjMx?=
 =?utf-8?B?dG9lWDNKV3VjVUJzRERaVjJ1ZzYvVHFkalhEczgvTURtZFc5L1NLTFpJeTFM?=
 =?utf-8?B?NzBEUGllVXFiOFc1VTdLaDJYTmRGU3llVlRTanA2QmRndHNzekE1NUxTeVFC?=
 =?utf-8?B?cGxVazBWL3NEOUN0RmNRVjd2SnVBS0RneUMvTk1XQ0Y1eGd4WFEvSlBaSnFv?=
 =?utf-8?B?clNZcGN0a2p6QmhKdFhqanBEbVkzaEdTN0hGeW9yTUIzVEhaRWlWUmxoNVRs?=
 =?utf-8?B?VjAzVUdpTE9yY0JVSVc3b0NmQXYvVTdoVkhoT3k4UXZZVy9zeTgveWlYNk1x?=
 =?utf-8?B?U0JaZ3FzRHhnMlZ5UGhoWmtjdDVlUHRLL2tLV295Z2kxUnN5RXpPRlpRc01B?=
 =?utf-8?B?cStBeWJENmVzc2R2TFFGengzZUFKL1ZZaEVONVY2aFpEaldHN211SEJaS050?=
 =?utf-8?B?RVRSUGlyQWVIVFBVR2RrNFFOSzd1MlZCQ2xJaWNYYUR5dVM5M001NFh4UVJF?=
 =?utf-8?Q?McXVCSIqQ0T35+fP18CnuRCERxdoaJwlcNkIdjJnepEI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U0VVelJxbUtGSzJiTDZBb3FGZ2JPa2x1WkZ5MGRDN0VFc2RvSDFyYThVL2NQ?=
 =?utf-8?B?K3g0NjJmQzhGcUR2ZVBkU2llMnRDR1BTWS8wTlE3MGpoRGpkdFNXOHpQU1BK?=
 =?utf-8?B?eEhUN2Y3a3gxVWk3UzkraE5oY01YM2lDQU8wZzFTbE1mNmpvRVhTbzJ4WDNY?=
 =?utf-8?B?QXNpYTVxbTRxdkJSbENwN016Rm9xZVI3bGdVM2xWZ3Z2ZVhCRHpxUzlGOUJv?=
 =?utf-8?B?b2xFaWlzQmUvUnZzRExFSUdlenh2WmZzZEduTDVrMFJ4WDVHbDM2UjdIK1g2?=
 =?utf-8?B?ZUdnNkJzR2RsOGhnc2tQQ1o3MkYwMmh5c1FtYXY1clYzck1SNHFVQVNwRGx6?=
 =?utf-8?B?L2Q1azRaTFJzOVRLcWlaWm56VDQzdmhQQ0xJS2VLY1VYc3p4Vjgrd3NsK0lE?=
 =?utf-8?B?YW5PMWpwUCs0djFDNVUxWHI5aVdja0t2bjM1d1hFUmRNNjdOVU53UlhIVnhZ?=
 =?utf-8?B?dlB6OUlsT0ZEZjhDMjBhVUJhNEh5c1NRalJpamdJVCtsd3owR294aUVrV1h0?=
 =?utf-8?B?OWJUaHVpMURFNUt0ZGxXRVN4bFJ2bDh3WUwwNTltR2ZyMXhDaEdiTDQxalpU?=
 =?utf-8?B?dG9hRWgvNmsvWTBORXRuOXVhK3FSb3B3RDVBbDhDZy8rNVg2cWZVOFNUREJK?=
 =?utf-8?B?aWI3ZDNmbDhpdUJxbGFPSTBKZFh1dExhenI3OStQTnM0QVhMdm1VUVlTRlk2?=
 =?utf-8?B?allLc3ZUYjhrdXBBR3NZWmpSUzBTN1I0bGRUNGFZNjFQdXQ0Tytlb3d0amJp?=
 =?utf-8?B?QWUzR2dmRVBIN085OWFGU2IxYWZRK3pWOXpXbXRSdnhiUWhFam9VZjhjZkt5?=
 =?utf-8?B?aDBSQ0N4MmtseEVRZmR4aXk4UkkxNFlGZkVraDRmS1VrQXkwekFZc2lGa2ZU?=
 =?utf-8?B?eDRnMVZLTEFUQk5DeWNlUGd0WTZBak9KVzVOazU0YnNrOHFsTUVoNVRYS3hF?=
 =?utf-8?B?bHo4TzNwU2NYODJwclo1WVpIMHZpQ0FwR1ppRU1aM0JJeHlrTEdpRTRVZlVu?=
 =?utf-8?B?R0luV3IvcmVvN3VoMkROMHRuQWZncVNqVWxYbGhUU2RVbG9pSElKY3pvYUR5?=
 =?utf-8?B?VUVwTWFHY0NFZURiV2xSQUxTUkVmdEpETTVvL0dHRUFZZVZ4RnVNRExwcUxZ?=
 =?utf-8?B?NG0yMlVwb24vb0RIL3pQYnlvdHdmbTV6T2VhZm5HMGhaU2lTTlRNM0hHRXlD?=
 =?utf-8?B?YTlmYXB5SUhtOHhxc3J5ZEtrU3Ixekhzbkx5eHZ5aHNMTjQ5WkNXaUdSaWlD?=
 =?utf-8?B?NXJ2a3ZnMTJ4dGFRMjdjV3NkVjA3M1YrOU1XaFdKVnZFZ3g4L3BHZjFWblZJ?=
 =?utf-8?B?MCtNZFpxa1U0dzFyVzRCQXlXdmRxbzVMMEVOeUJVLzQ1TVRpWis2WkFsSFo1?=
 =?utf-8?B?cDZ3Vk8zWVRNMGY1dXU0dk84YUF1dXBLa25DNGNpenpWQmgxNUEyS09ESFlP?=
 =?utf-8?B?TEZ5L05INUVwclhCVXRodjVzS3VoWGx2dnRNUGVDekk3WEFZbDc4NXRxSnU5?=
 =?utf-8?B?VnRaa1VQblZGc1dwSWsvdGdFV0VBVTQxajhvRkFCUm1WUWEvSklmN1NoczNS?=
 =?utf-8?B?NUY1TDVlR2xtUVRoVUhYK3dVeHFDTDdvbWR3K3hMUkc1WVVEQ1RyV00zZk12?=
 =?utf-8?B?aWVYZFVicmlGL1ZKa09pZ0RLdU84c1dBMXN4aHdXdjJMSmIzODliTjJBOHFX?=
 =?utf-8?B?MU4zZTNwaVZVb1V5cGFqZXN3eVJlZWFsdWpRWmpsTnhJQUZ1Zm1JNHZPcXRF?=
 =?utf-8?B?eUlaTXIvT21MNlhOMHBsc2M5ejVXUmY0Q2N6MHhlU3FRZHpxMzdiM0h1VnZL?=
 =?utf-8?B?ZThObnFGU2czMUhXb3BlNzRTY1IrMzFlOEVrTVN4ZlpuWFpyM1drazZRYjJo?=
 =?utf-8?B?S203b0pNVEl6K0piWmR5ZTdkMGRJc2NTYlJLSDBUWjVTdGYxWlVkSmVJUE42?=
 =?utf-8?B?MzlDT1krU1Vob05oUXhlaWhSbExSc2FJZmhJMC9lM2Qyc0NZbldBU01MVStU?=
 =?utf-8?B?TU5Ldi9NUGRKNGZkZkNOemt4ZXUvVXA2ejZkcGQ2ekU1clJYSlNXSGowc2tS?=
 =?utf-8?B?WjIvbTJBN0Y5MVFsVDl2bUd2VHo2dnZGSURjQ3UrYjVzWVZnbjVyMllsNjda?=
 =?utf-8?Q?H2xwg/PI/199vwx3XDCfv5gsb?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f40e15-1710-49da-c101-08dce188450a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 19:44:17.1254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZtrREG3qIqeZppfaHm+38eRlTbTUxUQJd8r/tZbIU3OX7jyxb2en7FQl3L7WRMbXERsV01L5FfcqFL8Mh/sCkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8070
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 Sep 2024 19:44:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16940

On 30.09.24 16:56, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This should resolve some reproducibility issues. Otherwise, no major
> changes for us.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  kas-cip.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kas-cip.yml b/kas-cip.yml
> index f00ad74c..611b67f6 100644
> --- a/kas-cip.yml
> +++ b/kas-cip.yml
> @@ -22,7 +22,7 @@ repos:
>  
>    isar:
>      url: https://github.com/ilbers/isar.git
> -    commit: d2d3b3e94874d62d48c0cafb99dfffde6afbc6ce
> +    commit: 51462e82e4a108c9c94ba4099465f5a19a7125a6
>      layers:
>        meta:
>  

Breaks the build, needs to wait for [1].

Jan

[1]
https://lists.isar-build.org/isar-users/1646de44-c244-43b3-ad57-b3bf702608b0@siemens.com/T/#u

-- 
Siemens AG, Technology
Linux Expert Center


