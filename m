Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCE0CDB471
	for <webhook@archiver.kernel.org>; Tue, 23 Jun 2026 22:05:33 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.33005.1782252325323718999
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Jun 2026 15:05:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=rXdsNwm9;
 spf=pass (domain: siemens.com, ip: 52.101.66.41, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZaA6dZtH/FBUgUF8zU0t/ZNNYyM3W96RKSMmeApzCuaisnLjMtIDWDDZZEeRo/vfPpZJVkeCvmFBFTS2zJuEMC7bBxGrnI9uc7nhlcH57f9lEu9XAfCx7aUekFI87wDdacB2fuMN1Hq/brG0ayH26PGv7GptKsw5hXQyQ1t6ZaTuZ/EH3MaLIqRSGyesH5eV83l3j9R/j3e1u1+s3TbRQFjo+wwiIX8S97ad3k5HX8CnNB8q/ySVl0MDWrSBwzoDMGxmHJffSAxDsm1x8bhc5Ob/YKZBcEDccqBnRJ+jR2UhPR82Sxp8NmYyQZBpHe6uEpBDXTo7wnhQhA1aWSIHOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgzFosNLCOcb54P847VFnHvizFXGN6KH9lfdaiweI0o=;
 b=N9PCLpoPas3rTtJhViZOdyRqyW5Abfs7FGVUAKFMeaqNhzX2Bw2Yws2cEA56Ud0mDkxms4Bb4FGlV4D7HJkcUgY/EYnq7jY95iy6rwK0TK8kOAroPjEUHEXAr6pMnBULigxMakwfNErCGfv14oOIBzJep5SzIDtirG5XYa4yLKhE2XqQx/4HjEIgIhIN7m8Ha1S7gnYDn/n+rh2iZykb3QAt6hgDkVMjrSPtihJJO9X/eHuBsh+GV8E86GHYrJ/9DNNcVRLhQPKrLm4DF40mlN+b2fvKEf7kl9xlBhLQ21vG20gh2b6+yByqgNo1od8KirFE0Q40LxHrLhGbW9I/Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgzFosNLCOcb54P847VFnHvizFXGN6KH9lfdaiweI0o=;
 b=rXdsNwm9IzgshVVFkBCaN7WzAhvju3qGDbzN15ePOvJ94cY5utXqmJnmUjrIipdTU01JZr41cHFaXapzzvx71u3sb8lnJTI6du6TusrHNRalc4DE6BnbXKM3KH0E8O4ECEW6BvenVGVK9NtyfbBtd1oh/y4GGijar+sUG1PSjkOxcB597NJX8Gqwog0ZcPH6k8C9ITRmeDNnyIBsJhIy2IT7A/grrC2ypGdRGf8amyaXu8Z+BxxqBHHg2ht23pTTg2Izk2gtrHfQY9evjV1vnAICdPoh/i2BmwY3McaxaxIerV25WJH6QkjyNmM/jokdl7AyOctkENIg0w9plG3/0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8129.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:115::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Tue, 23 Jun
 2026 22:05:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0159.012; Tue, 23 Jun 2026
 22:05:21 +0000
Message-ID: <d120e288-0bea-441f-b0fb-c4f4c730b25a@siemens.com>
Date: Wed, 24 Jun 2026 00:05:20 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] isar-cip-core v1.12-rc1
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
X-ClientProxiedBy: FR0P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: d9b922fc-e359-473c-6f68-08ded17384de
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|18002099003|55112099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	PH6Bv3/mXjs9NlHjGDSSfFy6sctCrArOFC3nbij1JqFDmk9bSa8TxlCwWvNIqDkj2WHK3x634eCds/g6DR8oAviEQ1QD36tOUGQBkguSU8VYm8cisZlQhp+NnN5jRT7PVHfMjp44KMK2q8lOrYzZXEyO3riijni2x11HyRFNM5lLioesDj9EhZj8mED1J1rzVAbE3Ws0Rj7VarUYyQq8v0or1jWtoN8FnsH9NpkiMyd1+kzr5t9DaA5TfoLvi8SzyjSaA/q+PhZ8/I4gJQjgbL/bZ2kemiBgAWW/ApB05K/zhIPknY/5ghl2xkeiqJCGBqZSSkvIHgG83CY6SM7VrbMUKcymtv+levbVOvartptpWdgWaF7kzDVApm0FD9hm9qFlzYrLLiB05nQO7XONLOmHE6gjpAZXwJJiPwcdr2Ny/Tc0rcVagK/43IntL2ram6DsZUEmLrcc7bBEOx/gs4fadlKdVSvFZtScFLtnXxCMAShWInj8MWnQOJUrjx1/Kmqzn4xF767Fr2I2++Lqyi+6nO+dzQoE1mjIwPvyZWk/SBIzw/V6fFRbp6sidB1BYbK47qeWTdM6RitUAcLe1iOb/3pORKf5sUL6o6wqAXJcNOejnv7+AVgoFeKPNN6c
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(55112099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NWJBeEZ3Yng0Mjg3TUhGN2RSdVJaNDByeGJZVG5mSHROSGlKVzhuVnFVUjRx?=
 =?utf-8?B?UWR1VjBUNWw2cWtCczFvLzJHbzE3aEpLbXlzQVg0NzJjM1dIRy9yWE5ubk9L?=
 =?utf-8?B?SldIQUZiTXBBSk5vZzFpRmtvM0dkRFF3cHk4UXU5U2JaVFptZDJ2a0NteW1q?=
 =?utf-8?B?cnJaWitpZkVHUjJENXc2eGJQWkNnMzk5ZjFnMmNQeFoxTVpYRDJvWVhPY2wv?=
 =?utf-8?B?L1h2R0c3VlhiRUdlRnRiYU44OFNwaDhmRVBFKzJWcFRLZ0xQOExROVVMeGtw?=
 =?utf-8?B?TzRxSndoWmpOekx4a0QxNjBDSTgzb1doZTg2RFVhL29ZWmRTb1FNOUJCZ0NN?=
 =?utf-8?B?anRnR2ZMWlg1Zm9nK2h2M1c1QTkzaDFWMUtTc2ZGaFRKZ2VybTdxUFc3Nll6?=
 =?utf-8?B?UE0yelYzMFI1VUZTQ1N2T3Zza0VyOFJBUWlQclZWZkMxVlhIbzJqaWlZTVN6?=
 =?utf-8?B?bmJWRkpaUldjTVdzdEJyVVVYNWlXbzZNTzd2RDNWVXJoWFpSODhzVHNBRmlD?=
 =?utf-8?B?RlRraC9zNVRtaVlEdmw4Y0dIQmp6YVhzVVZnOVRWaXUvc1ZJRDZOSktjTFZL?=
 =?utf-8?B?OWppaGhmQzJmZzA1RnJQN1M4K3VXUjg1L0p2QS9mV2ZNaU5UQkxpTG0wNElN?=
 =?utf-8?B?REJKVklpd3BLL0xGY0ZFSUkyUVpGUGJUSGY4cWdzYTU3eXZ3OGdjQVNnWERR?=
 =?utf-8?B?TXY4Sm1qdEx4cFRjSE1OYi9PbTNBNThKQm1oMEJJK1Q4bTUyUEszS08razJH?=
 =?utf-8?B?c0ttRzl3c0ZMV0Y0bXkrRTJtK0JNaWFoc01lckJQd2RYTVgwSUh2aDdBeW54?=
 =?utf-8?B?Vzh5akFnMUo3QjBpOElwOXg3Q2duRG42eDZCLzI4eUpwUlVTNWN4WjlUWW9y?=
 =?utf-8?B?QzBIRXpZbkdvSE85WVp6STgzNzl5eUdkSEtZc1dpNHE3c0xyQzMvdWkyeDhm?=
 =?utf-8?B?bEVJMVF6NUZNUWdYNjJyRzNac0J3V0tXRmU2S2t0Y0R0WFFJUnFIc2Izdit4?=
 =?utf-8?B?SjgvQStDVldqclZSR2xQdnVoTlJUTGpOYThRaWN2bGdublpscWxhWDFJamVv?=
 =?utf-8?B?azBnTjIwQzdQTHdoYi9JZkdNOEQwdlVjUURqYkdiMmtzRUl1M2pxNUlkM1Nl?=
 =?utf-8?B?bU1jWUR5cEU4YlVXVTZMblU5ai9ta2o3OGlpTkdnRTFWQjFyR3FVREFrankr?=
 =?utf-8?B?YUQrM0hhUTkyYlcycnQvb1pKb0RGa0tsMjJUdmh2OG9vWVpwS3FvWkNOWGNr?=
 =?utf-8?B?bVdlcTBmRmxEZVF1RzM5OVVxbUxTK3lpelR0ZHZmdzc3REdYVUlET0xPcnNm?=
 =?utf-8?B?cGo2WEp1R1IxNUtINUFTeTJHNnlWVm11QWk5U2k1ZEZCdEYzTEFLUkY3cW00?=
 =?utf-8?B?Skllc04yL3VoanluWjQwV2dsY2NuUlNUcUZBTVZlcWF3bTNEZDd1NHVzZTRY?=
 =?utf-8?B?eThTRGFyd1RSSjliUlZBaGRmcDBlVmRzdzkzNVNqeW83MmRSd0xteTBoWDV0?=
 =?utf-8?B?SFY2RElKaldibG45RUttcGdnRWlIZ2ZvQTFLUUt2NkY3N2NZRUlaTHZ0d2NB?=
 =?utf-8?B?WmxHUUxVQWhCaGhRU3lHZ0x2VkZ0Mkt5Yjk5SFpBWnNPNTZnOFN4MHNXYU5o?=
 =?utf-8?B?NXU5YjV5ejRZd1ZTbS9UdFN5MzZHTmdWek5sbzJyVkthcElyUGNvS0N6ZWZT?=
 =?utf-8?B?cXhMVUtVSW9XMjluNlBKR1ZyaG5haVVBVUZlbjhCZEgzTWNPS3pQKzBiakFa?=
 =?utf-8?B?cHkvSkFxTFFnbjl5dkxyUTQrNEpmNE1FcmE1cXoxMUdkcEU1MEc1WG9pL2R5?=
 =?utf-8?B?NWhjdlBFYmxBZENjUUY1a2h0Tk92QlpQbC9sbjJHVEpYZTBlZE1BZHJvWGxQ?=
 =?utf-8?B?b0E1V3l4Z2djR1lmRCtaUmREclVva0RJZUVhZ0dKbUluTmkyOFVLWnJKL3hz?=
 =?utf-8?B?MjBRNFU4ZE02dWpaWExGMkpYMkhmS2p6aGl0SzhHMU40b3NSYnI1RjhRN0sr?=
 =?utf-8?B?bHo4Z3hVVExPM2daM05QYXQ5OEJQbHB1TjFDNjdaWGZQZkpIRnhhcWdKa0FM?=
 =?utf-8?B?L0tYSDczTjhjVTZ1dTc4ZlhaaXZ6RUx2MWlYTjErc1NhR2dYb0ZlNTkvQzU4?=
 =?utf-8?B?bG95My9RdFAzMmdoM1JDa3ErUXFUYU5hNXVMNmtMRzNrblp2RmJ1a3BTUXgv?=
 =?utf-8?B?WEdsWUxseE9ncmhyVVo2UkFmYUZkT0FjNHFTR05zK0hBbVRaMzcwc0dwUVMw?=
 =?utf-8?B?MzkzOHJRMnRZSmRQM1FkbEduZEY5a1MrZldKRnFINHN6VTcva0NXL1ZyN3FX?=
 =?utf-8?B?YTlrekVac1FPcHdVTk9pckkvR3lGdlg0L2ZPQmdMbUh3dStQOTQxQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b922fc-e359-473c-6f68-08ded17384de
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 22:05:21.5278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nq04B1/fLnjKqyPf9iojCdBSHIHMVM2jPhA6AW/3OjIGdv0zBWPR71D0P+pouy6gE1oeybm3YVjz1KKNcsQ+IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8129
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Jun 2026 22:05:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23275

Hi all,

v1.12-rc1 is out for testing.

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/archive/v1.12-rc1/isar-cip-core-v1.12-rc1.tar.bz2
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commits/v1.12-rc1?ref_type=tags

Please check that we have no regressions. I'm planned to release end of 
next week if no issues are found.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

