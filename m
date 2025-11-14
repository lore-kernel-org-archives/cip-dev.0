Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9732CE7AA5
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 09:54:28 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.38])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14690.1763114059183015239
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Nov 2025 01:54:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=OYTtDZge;
 spf=pass (domain: siemens.com, ip: 52.101.84.38, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COR+AfcKbwId/7OSW3TRSymjLbrY2YBOIvFSKxU2WIerHqUxT3Cxx+05KwD6wa9WjvBKRo8xSXhVIOO+bp+gGaw8A3G1zkTraS8ee4B6EWg/Jyb8BAXEkFgE6M7OOYErDPP1eH9iMlFSYfJOPCLwi+iQtI2ZOJ7ufitZEoKoV40m15a9nU7lZXf7kuZJmRAB/O4nh+DcFPUj/I75P+mSjlopbN9kv0gyX2RaI8pUxxrTjuPxg+VeD+si1ZKb1Xym8yDSwRUqmU8XMP/zEx841Olj4YHxP5DJ8iP1K3ylJPQn7MogExmlQQyYZ8lXRKe10+ti6weKxR6AooQs543SFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqS0yQOXb5Z6P5AFmLo297rfJLTLV5gVozkb0tpMX2Y=;
 b=WWVmKLCZFlLRx03a4/Z6q1gsYZu/zn3D2ki/vv/TTx0YMQbDqHEsLNUZKHPGrhd8E1QL/GAvpssg76VhRAeACn0bxL3lfxPQJSoeILz2XM1BvSTmHwgGD6Va8ih0B6U1vUDuhvE3dc3CLOyU6Mrjqc6TSdLX2d15ToD/BT4uj5C6+TpHV33TZPJGt12TerrJ+U0wVIJSyIMfIzPFxqTasHhlIEOmDBJAxhoTVzM8Q99IeuQ4DrA6C4qpIWP5F0yAovpVlj9BKPy5zGteTlMorl9KuIbzAN0DvzFb+411GLh+tNK8DgrhVy8XgFFUeI2RhjewsAqaoIoV30UCswu7vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqS0yQOXb5Z6P5AFmLo297rfJLTLV5gVozkb0tpMX2Y=;
 b=OYTtDZgeypsi2EUbD28np0kIHT9WDH9zNraopY8UjKjBMGe4S9nhv0HMrGMVIQR0G/45VqT7Wtxn2xnoIhJoCHDbfXNK7D6LkrGCYHAnkOVOBCYy0LxSXNo7mBfFAeuAK82qHf6B8EWdRWYxl8cXIyRB18m/rWaZB0rMduRuTxXhH+zGO7VcFf743u11buek5aWb8tTuPAMJYtrMh7svr9PnL+iFs3FGTlrxa3UXRaBZNWdtwHeuk//xtc+Y4Zz/KVlxjOkZRlLQazjRIGKPLSGS4fHjZLmCmOgMtPOD+GCKSXkxA8DVggbsMf78RHmr+mroQDEPF9gdn1uSQV2I1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB5796.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:63::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 09:54:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 09:54:14 +0000
Message-ID: <52e217f0-5cbb-451d-ad56-4c30927b99f3@siemens.com>
Date: Fri, 14 Nov 2025 10:54:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] Testing isar-cip-core on the iwg20d
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 cip-dev <cip-dev@lists.cip-project.org>
References: <a0f4d994-2f70-4bad-b823-b3bf1a373fce@siemens.com>
 <5cd84b25-4709-4813-9d38-2652810874bf@siemens.com>
 <TY3PR01MB11346468D1012CFB886455D8286CAA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
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
In-Reply-To: <TY3PR01MB11346468D1012CFB886455D8286CAA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB5796:EE_
X-MS-Office365-Filtering-Correlation-Id: fd7bf508-0988-473c-3158-08de2363c485
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YXAzMDJtZFdNY2c3dTNPZW9ScTRJcVBFNzhBRFlJNlUrN0lYN1dRL3BzSm9Y?=
 =?utf-8?B?M1FkUDBUd0dYVlc0eXhpZmYwd0JObG1jRlVtY29xbUFOTmhIbmFzdHlJcHlh?=
 =?utf-8?B?RW84K2VibVFmYVJLZ3lidmxRS29sdGo3eFo3R1ErektSaUtyMmtOT2pCdFBm?=
 =?utf-8?B?aXBDZWtIb3E2dUpzWm1yRzdqVkhJOVVQR25HL01LbzJQcDZaVWo5ckdLcFI1?=
 =?utf-8?B?cEpOWEd0RjJ6MmhWUWk4Q3V5UU1aczRPbDNtMkcySTIzQVlaQWtDYnA1YU0z?=
 =?utf-8?B?eDJoQmVuYzZYdFRleGpJYzRaN3QwQmFYK1c3UFNmTWlxSlorS3RPSkh0NmI4?=
 =?utf-8?B?d2dHWEFjcTEvc2FtTGMwOE45c2U3Wm83eW9Rb2hpRzdCWUNMdjhJYTFoYW5n?=
 =?utf-8?B?RmlhRFpZdUtZd254cXdWR2UzSGxOZFVqVWtmMFhEYm01bHNsZkNqWHZiVTBh?=
 =?utf-8?B?TEF4eWJwOVlhQ0ZraXI5ekl6ZXhZckNFaVdNbUlGYy9DUmhkeHA4SGtXZ2xo?=
 =?utf-8?B?bU1YN3lhZkVaNENJQWcvMzc2MWp6bTlFYzVhSzkxVGZjTjExRWh3N1NjYnFV?=
 =?utf-8?B?Qm00L3JXcDkxVittdTU3d0VpQVVGMTByUVJVNHlCazRCOFZlTVZrOFl3Y281?=
 =?utf-8?B?V0FEalhJT1RhVkxVeXVOb3Jpak5mcDFlbFFZbFN0VnBWUEdHQjlndzBDTTRs?=
 =?utf-8?B?cFNnUWVCZUlCRXRsZGN6YnNZeHd3cWsyWGFyMVJvcFdQalhDMEpsamhzYkVn?=
 =?utf-8?B?ZHNkMVMwSDJlaEgwcEpEOVBQUmhmUy95R1BrUXlpeFFVb04wWGd5elJZOUJE?=
 =?utf-8?B?aDNoWXpRaTB0Q0pYd3JuZzNpcVFGWlBtaGk0VldGVnVZcDFuWCtBa2h1cG55?=
 =?utf-8?B?RXFKWnRtLzhoUmsycTN2M3RWNTlqTGRwdmpza0x2Ky9HMWNMWHBzL1NONU14?=
 =?utf-8?B?aDZvM2p1d08rLzVYQ3U5UXhsdG52N3FuTlhqcEJSczZTWUJwOUcxZUJSRU9q?=
 =?utf-8?B?b2ZNMnZNUmw3Y2pjR0lid1FqcUk2M3E4blNnek42amdLd29MOEl0RnloaGNF?=
 =?utf-8?B?N3dINE5nbDE0eFo4eXFUbDFFNzFWeWw2QWR5bjlONU1iQUJMWkVEYWFoS3pH?=
 =?utf-8?B?R0dSbENVemMzaHFhYVVHMDZHd0t0ZC90bXBHR3NEbGVsNm0xb09senJCUi9B?=
 =?utf-8?B?Vm01dFBpSFk3Y21oK2lYMlFhK2RuODRnWXVlWVRKR0lSbGNLYmw5SjVpNXR0?=
 =?utf-8?B?TFQ2aHgzRDV3S2lpKy9EY211QWw5WGs2d2JXRUV0alc1WkdOcmw1YlY2M0Fz?=
 =?utf-8?B?U1E5ZkQ5OU1waXZxQnV2NDlUSlgvVG92SERNNU9vVDFYT0FrMUNXWmxIRm84?=
 =?utf-8?B?emRnNWtLVlp5eGFkQ1VPeGV0azhvdTNjRXE0QzdOSXV6Y3pjOVR2ZzZSU2VY?=
 =?utf-8?B?ZkhLMkltRjFUb1d3WmFlZ3pHbEZINStsSCtjR1JOK2xnakNMNTBhMWV1ZTZh?=
 =?utf-8?B?cTBNcG9yb1hlSys3Y2UyV3RPN3AwOHlQcTJXUUFrQ1Eyc05BR3NtTU5lSEdL?=
 =?utf-8?B?TWZEZ3c2VVAwbmdWSy9tc0VpMHQ3M256bUhweStmd1JVYmZRRUh3dUh0cEMz?=
 =?utf-8?B?TmZJOUs1cHUraEF6V0VCaVhNNjl1Y0FyZlo5akI4b2loTnozVDRLMXE5dmVs?=
 =?utf-8?B?bEFqSW9uY3FKS2YyNUdTalN1TWJQRnFGWTk5TGxMRnZ4Nngya2ZxakJlZVcv?=
 =?utf-8?B?YlhXbFNwSm1DNVdOV3hNL2F6d05NL1F2ZVpLc2Z6bnFUdDhPTXFOaFNRVm1q?=
 =?utf-8?B?V0lad0syWXFNWExlb25DVksrVE8xWE9uK2xub3JPcFVvMXQvNjNFRERpb2Ja?=
 =?utf-8?B?U3hhdGovRlcyUDF3V1RIa295UlhocDF5OUJwVXNLK2VwVGd6M1M1NDNhaU51?=
 =?utf-8?Q?k9/1ZgsgY0cbBY4scU/hYRZKJdXlqyc/?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZXFSS2txUDR6alk3WjN1SUR5R0Fnei9PRUFJU2JEUDBTTHk5Q3AxZXVEZGti?=
 =?utf-8?B?emlMU1crU2NheHV2eGh3bjFWWWhRSU1IQ2l2NFN6NVp6OXQ2c0Jzd213SG5V?=
 =?utf-8?B?N1huWHp1YzFJUHNlN3RQR2t2V0xhSXluTEVYY05FZ01hZXdOcDZ3UXRQaTYv?=
 =?utf-8?B?VWE4T2VFaHloOXhxRlowWTBlOFpTdDU5ZmwzNWdUakdUMHZpMjEzbFJudUxh?=
 =?utf-8?B?V1U2V2tsTVl2Y29VNnFZc2tYT0Ywa2FsaWJHM2RZMXk5Nm1QMDVLUXVXRDNa?=
 =?utf-8?B?WGRNcVdxak9wZldmOEtoTDluZXBkUjFQaFRaMGdRMCtKYTVFQTNRYkJWSWNs?=
 =?utf-8?B?T3RnZGJwbHhvRU1OTmJIYm5QdzRLM3dSWFJ0eFVJQmp6SEhmVm92dStKOGtm?=
 =?utf-8?B?eFIrcHowUW5VNXM0b2hEWDNnbmdHZ1hrMVlMR2gxcGo0WnJjYkJSdEhFeVBN?=
 =?utf-8?B?QjB3M0dRdW9LT09IbzFJTHZpa051WHNUeVNOT1FRaWNwemo5OWJtYU53cW1S?=
 =?utf-8?B?a1NUdUVkcjZLTlhJd3NNeU1YSTFsMjZ4TUNvRXQ2QUFINEFwVlVaSGNUTkdU?=
 =?utf-8?B?N1IwS0dqbGtJMGw1NWhqaHRacGZJMnR2ZERiais3WHpaN2hUMGhZQ1BjaEVH?=
 =?utf-8?B?ZTk5cDY1RTJ0dlBQb1JmYVRpakdpVExyRng2QktiZkhnVGVLQlFkL2NsY2t4?=
 =?utf-8?B?YmdTWUJNL0JKQ1JWcW5qc3JxRmtlTGN5ZDlpS3J4OVhBZmJoUFRtWitKUHdz?=
 =?utf-8?B?b0wxNU1YU1hiVXhaV3dmcE45MDBVWWozNmwreUlid1p6cjUvUjQzUEhqZkZU?=
 =?utf-8?B?OWF5ODVPbTFSUmZQdWpDaVF2K3BnZjNnVlo1VnVuNUsyNHNHcng0MTVxaTk5?=
 =?utf-8?B?UE5NblZsNExwWHltdW82WXowSVgxa0ZUN2xGKzU2WnMzMFNNUUx1MmsyYkdH?=
 =?utf-8?B?NGtQTWxXS3A3K2RZbC9kajhKNnlWeTN3ekRIZDNMVnc3Vnc5d1NCQXlOby80?=
 =?utf-8?B?OWhWZmFGR2lyMlNBNDVlZlFTVTNubnpMQmdWaVNRaXphckdGeERiVmpuS0ho?=
 =?utf-8?B?cDMxSXlWUnphS2hXT1Frb2pZbXcrcTFKSUo3b1QxNnc4M2xrUmxmTnR0N1gv?=
 =?utf-8?B?ZHdmYVE4cEU0U1c2YXdiTWZaUUNnVEtWY0FWWmJURXo5TnM2d2ZUSVlQWGRT?=
 =?utf-8?B?TmsxL0JyK2lzanlJRlVYWVd2V3NuVThPajhWQU50USt0YmRmWGppTDdaV0Nx?=
 =?utf-8?B?SSt1ZjFLSmx0cnlnVUpjMlArdmRBY0loVmMxK3hjQndaQVRiV09aQVExZ01Z?=
 =?utf-8?B?VlBLV0FTQm15eEhUcVBMdjQvSFpPN1pieXRyV0c0ZmNpNTNGT2M5aTdvVUpP?=
 =?utf-8?B?M2Q4MjdhQnNZWUVHV3hKSVF2dUpwalZlSGhIamo3YkNFYXB5QjBnUm9xZVMr?=
 =?utf-8?B?MlhXR3Z1SlRGSXEyNC9SSlRrd29qZUx3b1R5NGE4Y2tzR0I2c0JrT2txcDQ1?=
 =?utf-8?B?czE0aUNzTy9MNkRVRXNuRC9tSndYTHk3M0k5bmdILzdRVFpZK3duYVZSVjIy?=
 =?utf-8?B?amY3aEZaR3NYTkdxUTVTOUc0YmZsT1NmWTFkcGs4RzlkMTQ0TXNZQWZNOXZz?=
 =?utf-8?B?UE9jOCtVcnRBcktSdW1lSU9jcFpSR1YxUnMrbmljb2Z3R1N3RDlhY0pVcHNn?=
 =?utf-8?B?SWo4S2d6czNEZTNSMlRuaXJVY05FQ3JjSEUyMndmNWhoTTRWeUJMK24rZGlZ?=
 =?utf-8?B?RDY3TGZibWR4MXpsa0lsL3RxcHVUdUlVZmVBa1FPcUVYQ3lmSjlYVHdnYTVQ?=
 =?utf-8?B?TnpRMUwwbkpwTWxzZUxKZE5kNEd4M3gyWG02cWozdldXU29BczlpWHIycHNX?=
 =?utf-8?B?L0VhQ2tHamZGRENaWDdDamVlSUttL0ZlQWRldU40NEw1RTM0N1p0cm0vY0Y5?=
 =?utf-8?B?OXlkTlZENmozSjVTKy8zR2FZRm5TRVYzRTd4VlJOVFQrOHRsWlNpOGVHQ3Zu?=
 =?utf-8?B?TU00MFViK1EzbFlLVnBmNTRMQW4rK0w2MEhPaUlieFdNb2UxeklLeDRkbmQz?=
 =?utf-8?B?M05MbkdlOEoxUzVkSVlEcHpRSkpuaFE5c0JXQTFzLy9La29jZWVHTEIvbGc0?=
 =?utf-8?B?dkZ0NGhaSGxPbENZL0xITEh5dnF5OXBJbjJqV0x5NkRkYTY1UDkrdnJwYTFE?=
 =?utf-8?B?cHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd7bf508-0988-473c-3158-08de2363c485
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 09:54:14.0045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H1p/M526hXOeBoBVF+kn0bViiCdxfM/2wdwNClR3GN0UyLiyg9Lj2IVp8VEz5VhZIZyMCHu+vYd3SQUS4czvaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5796
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Nov 2025 09:54:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20546

On 14.11.25 10:48, Biju Das wrote:
> 
> 
>> -----Original Message-----
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Behalf Of Jan Kiszka via
>> lists.cip-project.org
>> Sent: 14 November 2025 09:35
>> To: Chris Paterson <Chris.Paterson2@renesas.com>; cip-dev <cip-dev@lists.cip-project.org>
>> Subject: Re: [cip-dev] Testing isar-cip-core on the iwg20d
>>
>> On 14.11.25 10:05, Jan Kiszka wrote:
>>> Hi all,
>>>
>>> as I still have the boards with me, I "quickly" wanted to renovate and
>>> test isar-cip-core on iwg20d. But the board I picked from the stack
>>> has an ancient u-boot pre-installed (2013.01.01) and has no clue about
>>> GPT or the right name of dtb file to load etc. etc.
>>>
>>> Can this board only boot U-Boot from SPI? How do I refresh that safely?
>>> Or can I also make it load U-Boot from SD card?
>>>
>>
>> With some tricks, I meanwhile loaded the zimage that isar-cip-core is generating via the old u-boot,
>> but that is not giving any output during
>> boot:
>>
>>
>> iW-RainboW-G20M SPI_LOADER(DDR3) V0.20 2015.07.16
>> BSP Version     : iW-PREWZ-SC-01-REL2.0-Linux3.10.31-PATCH004
>>  DEVICE SST25VF016B
>>
>>
>> U-Boot 2013.01.01 (Nov 04 2016 - 22:21:05)
>>
>> CPU: Renesas Electronics R8A7743 rev 3.0
>> CPU: Temperature 50 C
>> Board: RZ/G1M iW-RainboW-G20M-Q7
>>
>> DRAM:  1 GiB
>> MMC:   sh-sdhi: 0, sh-sdhi: 1, sh_mmcif: 2
>> SF: Detected SST25VF016B with page size 4 KiB, total 2 MiB
>> *** Warning - bad CRC, using default environment
>>
>> In:    serial
>> Out:   serial
>> Err:   serial
>>
>> Board Info:
>>         BSP Version     : iW-PREWZ-SC-01-R3.0-REL2.0-Linux3.10.31
>>         SOM Version     : iW-PREWZ-AP-01-R3.3
>>
>> Net:   ether_avb
>> Hit any key to stop autoboot:  0
>> iWave-G20M > pri
>> baudrate=115200
>> bootargs=console=ttySC0
>> bootargs_base=console=ttySC0,115200n8 ignore_loglevel vmalloc=384M bootargs_mmc=setenv bootargs
>> ${bootargs_base} root=/dev/mmcblk2p2 rootwait rootfstype=ext3 rw bootcmd=run bootcmd_mmc
>> bootcmd_mmc=run bootargs_mmc;run fdt_check;mmc dev 2;fatload mmc 2 ${loadaddr} ${kernel};fatload mmc 2
>> ${fdt_addr} ${fdt_file};bootm ${loadaddr} - ${fdt_addr}
>> bootdelay=3
>> bootfile=uImage
>> bootm_low=0x40e00000
>> bootm_size=0x100000
>> ethact=ether_avb
>> ethaddr=00:01:02:03:04:05
>> fdt_addr=0x40f00000
>> fdt_check=if test ${fdtforce} = "0"; then dynamicfdt;fi; fdt_file=r8a7743-iwg20m_q7.dtb
>> fdtforce=0
>> kernel=uImage
>> loadaddr=0x40007fc0
>> stderr=serial
>> stdin=serial
>> stdout=serial
>> ver=U-Boot 2013.01.01 (Nov 04 2016 - 22:21:05)
>> vin2_camera=ov5640
>>
>> Environment size: 803/8188 bytes
>> iWave-G20M > run bootargs_mmc;run fdt_check;mmc dev 0;fatload mmc 0 ${loadaddr} zimage;fatload mmc 0
>> ${fdt_addr} r8a7743-iwg20d-q7-dbcm-ca.dtb;bootz ${loadaddr} - ${fdt_addr}
>> mmc0 is current device
>> reading zimage
>> 15151616 bytes read in 685 ms (21.1 MiB/s) reading r8a7743-iwg20d-q7-dbcm-ca.dtb
>> 41327 bytes read in 5 ms (7.9 MiB/s)
>> ## Flattened Device Tree blob at 40f00000
>>    Booting using the fdt blob at 0x40f00000
>>    Loading Device Tree to 40ef2000, end 40eff16e ... OK Unable to update property <NULL>:mac-address,
>> err=FDT_ERR_BADPATH Unable to update property <NULL>:local-mac-address, err=FDT_ERR_BADPATH Unable to
>> update property /iwg20m_q7_common:vin2-ov5640, err=FDT_ERR_NOTFOUND
>>
>> Starting kernel ...> 
>>
>> Tried kernel 6.1-cip and 5.10-cip already. I guess I should put this aside...
> 
> You need to load r8a7743-iwg20d-q7.dtb by updating u-boot env variable.
> 

Already tried that as well - same result.

Jan

> I already sent a document for you.
> 
> Cheers,
> Biju

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

