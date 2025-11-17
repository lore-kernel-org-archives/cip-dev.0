Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3E7CE8D6B
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 15:35:04 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.40])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12370.1763393693203925468
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Nov 2025 07:35:03 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=qY6CpgmQ;
 spf=temperror, err=temporary DNS error (domain: siemens.com, ip: 52.101.72.40, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fWuTGHcWx/0FCZdXdBvbKy1I5kFP3hh1Zg0x9Ca8K6d9HlnMELoRDxNVzWMXI5gNs5wur8hXCDZVMDvNU3QRNnmP9yThPN7N2Ad+iOBCBm124EB0102bQnjTzA6vvYj8XW3iizeEILwP5FQAWiGPPnlUw3h7mb2sQUFVVo0044nhvNKc/2+fVvwxtqFtYvWby4BAvvBHusRq/8TdUEA+o59x1zGnqc2a1QNooTDhs1ju9aM5r90IrBx4b+gzN3Mc4goXB2yD3ltkO63vmuoGgPZ8eHQLYKY4Ccytgw7Us1KE4ZRoc8VvW7WRfBUn6wsMfaeWuUdLTscCsXE/Zqe2yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pz2ozDiKlb95t706HMbuPCeOBh4zArCKrw5gMpfnTtU=;
 b=p2ny3sbJXpT6cLe0AfTWCIIuZUKJcGsl5IObTC2PGWekt6GNVz9qi+/VjajzkvtorNyvLMe0epf94oZezXfEVU5P28jLeNLJihIJzhXXY9tKMZurJdA2w7z2W6RXpaMvgE/cIVScKmPxGCOL1OsOOoYKc7jJXv1+PyOeJXI/PCONpOSTuu9P3JYovP0mYXo1V0R2rwMKsuD9oEH5wmLG6rDBNW1N3Bz0rcWTw+G3ZIJNjU9yi3pfwSU3RkB/3WYQ9p/+1uYHYvNGV4hsRQxvCVUd1+Qvb8GLzNYARLbyWwzEm8Md3iIA+/4ik23DakMxHYp0pjdQ2RyCQc4fEI4Gfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pz2ozDiKlb95t706HMbuPCeOBh4zArCKrw5gMpfnTtU=;
 b=qY6CpgmQTGrXER9n2zQYQk7ec4sOGL0Ax3Q3wHkIDiOEe1m7VHK4U+d5fVmUTw7v95dm3Q0/TMoPWjm+zL93Z8ELzqopNIRw0ruk8symYdo0kdifP3qh7SUWFjK39pk4L0shShWn+X48o38OpyafnUk742dpBt3VI2hsiwt8ygB4Z5rC09FHtELZDdZ0f0aGZItHZT5x0S0iXLy0Rt+Ap0jQ3oxyfNewQrRLLMDo0P3nVeGh4+3g483D/n2k55kKfVL85RkTP093zHjbbnQ78wrpK+RCXzswDqZD+i1MforfgUwW+1PBA6FGYheatAFUaFCJg18QL1kVRKlRkyLICg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3801.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:49::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Mon, 17 Nov
 2025 15:34:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 15:34:46 +0000
Message-ID: <ce277bc4-bdaf-4afb-ae07-cfa26b9bc1aa@siemens.com>
Date: Mon, 17 Nov 2025 16:34:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] Testing on hihope-rzg2m
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 cip-dev <cip-dev@lists.cip-project.org>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <a0f4d994-2f70-4bad-b823-b3bf1a373fce@siemens.com>
 <52e217f0-5cbb-451d-ad56-4c30927b99f3@siemens.com>
 <TY3PR01MB11346CDEF02F029DD1B64560786CAA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <70790d7a-1ac9-4c7b-acc6-2ee4edc4a472@siemens.com>
 <1877EA27D24C204E.1114802@lists.cip-project.org>
 <TY3PR01MB1134685CE8A4BD38F73A0C1D386CAA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <80ecb9cb-2b48-46ec-b92d-090898097f5b@siemens.com>
 <cbf91714-ab26-410f-befc-f43ae2840b56@siemens.com>
 <TY3PR01MB113465454940A82FAC538AA8A86C9A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <5d00d5d6-5b13-4ecb-bb9f-e3724d96e6da@siemens.com>
 <6917d2e7-3445-46f8-b2f5-16e2054f232c@siemens.com>
 <TY3PR01MB113469798E540974DD8DB122286C9A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <3c30e594-f15d-4ffe-9bfd-dd3106eadccf@siemens.com>
 <1878CF846EDE16DE.1122728@lists.cip-project.org>
 <TY3PR01MB11346F3057953F4BA3E2496D986C9A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <14aaf102-4691-4db4-8be1-7aa636037edb@siemens.com>
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
In-Reply-To: <14aaf102-4691-4db4-8be1-7aa636037edb@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3801:EE_
X-MS-Office365-Filtering-Correlation-Id: 17f534de-bad3-46ce-960d-08de25eed66c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?fQ6tWBZmnsDtElQl97IzMx5kv9DRkiGf7CW8/OznwQeXE2pMTHnGCQLWmIP2?=
 =?us-ascii?Q?80rglTAn0yj00umD53Yk26wHZBjKVhalcDlpptRKR2S42uuHemzfRbMTzGx5?=
 =?us-ascii?Q?vemHXeFFxp0YY2D885eq7inpiqEtKyEJCiLScEOyG8fGw1arNXEKB3rO3fiv?=
 =?us-ascii?Q?vmUMllQW0BHY8yBFi39ZdRZIsWX12p6ZLeKFIOU3c83Fy07gryiSKbm8hg10?=
 =?us-ascii?Q?nb30xdbVxJcBrNkO497nGjHapggOBkjA7dGQLJ28Uqyj9jMhISXBpo6NDXRW?=
 =?us-ascii?Q?UCeaa0OfpWaFV+jHXg/V6OQtEM6oVIRSsJK88ndYkYaNti2eHltP3ZtlbCw1?=
 =?us-ascii?Q?IVCSvwJyU8+UtyxW0bvvOv3xRCeSQrfdsV+uzhdb1Hsk1BFxLfaap5kZVTOU?=
 =?us-ascii?Q?KwBkf7v6S8xVgVDFjKRjBRzWEOWBQURrCv9Lr/h1ePIJ5m3cLVrUvrLmHieT?=
 =?us-ascii?Q?h2OtNpyU6VkSbxKi7SoZ5yfy9u+cZdyg/Vk1YByuOCc/Q9hCTvhHGPrK84c/?=
 =?us-ascii?Q?cVdBS3W3CqptCURtaZRXAaplzbPiDxu6p8zoJ1PanB+f9fUvNbNphv1eOd7/?=
 =?us-ascii?Q?MJCA1wfMalCmQw+P8QSOj0i82PS8pJWDPUgH87rkAU8yuXUGG/ZvdJDAVzgR?=
 =?us-ascii?Q?IMgJBTn10M8w63zuDQfTEjY3PYuMNYtfqolyVK8jm10qf3Z2kwwjbs4t87z/?=
 =?us-ascii?Q?pkG6t/GG7y4bC3ctNn4UfDYBsFD60JRf9xbrgqvTPwuQ2WhQjLytrcWhuDZc?=
 =?us-ascii?Q?O+fBRmNEoYB3BRGaUiznlW7niBh/jim6CGI1/08dGOmhdzUtd3D3jgEI7cRu?=
 =?us-ascii?Q?laipsvyCpWtFXcKDWOqzfaoz9E8bDypXJA+NbBw/aCbFSP7xoeH+N4VZ/byC?=
 =?us-ascii?Q?t/iLPMMrnapzdNl99EBC7vcJHk/Dzlld4tDoJ7WszWfM9Gkp55GqOOr+QhLU?=
 =?us-ascii?Q?zYaUtP22VeV+pvohOmCBCFc6ILjvJwMp2KEFSlrGCIvO5ADKTMu4lXYSVHpf?=
 =?us-ascii?Q?kx16THHYDIeZlUgE2P/ANMIWQHQRIqPnrzMT7RVLaHvFb8k3Lx3x0X9x6Wwi?=
 =?us-ascii?Q?YkG+L8DfwP4XYawKcZx+hTylomHEJPMkbvpyPQMboG6k2qI6DYuYNLOp4Ug/?=
 =?us-ascii?Q?j+g/bCm2VqRYxu0jBPUDrAp5nnCQGBr56t4f4FS1QJlGoWFav/7k9SM+heme?=
 =?us-ascii?Q?gcSGXpjFEAMcjW6qUU72ODLoGDD1/o5+HdCStA+L2vDHszNGbJsuj2g915n+?=
 =?us-ascii?Q?BgDlw0xQYI1oFbsHTyfKI26E+2bOV+AF8N5sL67+GUyJKbGhfffMb43B56eF?=
 =?us-ascii?Q?+cjxJq28eoZ4Ng1QJp22AIk2NuxNg6h4zfnNETUw7R3C12b29bqa2TmJinqA?=
 =?us-ascii?Q?Zd1V34nCa+TVL5ymXW+JhdOBA+C1uH87ifD7XiC1S/sQkS7gbA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0KbXHSuiwZZzRoN8r09OAvheuyLq4HqsldSapBQKATg5uTiMmAjbDbrNEVqz?=
 =?us-ascii?Q?L93m1l5Wm0R6M/jkfuzq+Lb35vTLghMB1Bwz5HnOZ9sxP6YwMezzfz9VnO0u?=
 =?us-ascii?Q?MYr2NglPlYuuVuaSllMgTnZPSM14gqPTrGD0KzX3NwzLyCqaYnmyIC+C9Eey?=
 =?us-ascii?Q?4QMg20ecBIEzqWrYFZnRaTGPDp05DxWKex9HqETDis66eBTkiBTArnW4otBu?=
 =?us-ascii?Q?GFWTPAGbDqYHT75vNp1yg09JeyA2efgg6s3Lf92F8BFyngwdRNlzcoUIZ650?=
 =?us-ascii?Q?y07qw6ZgU5rPtnpDie17C8BwtygiUN1/S08wYop9CMezPQsyNeQR5Kr6ctNc?=
 =?us-ascii?Q?cNcwPaUm0bejQ0hMNLgrd6Zco2ZPd4IQOMmrbjXKKx4+X2dXfB62ZcbgE5Rs?=
 =?us-ascii?Q?+q6SBfBRImm3R8G6gvLJSWbAinB+ogsBh+neIM+IesxzDzpsmnqMj3E1fkh5?=
 =?us-ascii?Q?HxiGqMiLcjmNFOr638pN/20+Kg5/042U9ImfnwCAHqqKQUHGIJKpzKxcwy8N?=
 =?us-ascii?Q?2zZSlzQ95xpf9K6JTBOqROG4J74SvKoxxXpB1RhtjL5G0z5umtXgNN+llMEF?=
 =?us-ascii?Q?h7fMv4qafeYTou9KvSSmccAWXXCeeuslJXuCz/O23u+wVANvz6G76LfdIitl?=
 =?us-ascii?Q?5s9ztQqynVXyr31FoSZUnYm2ofzzDTMpTznBZtPtPU2ZnhfOvjPgbyZpMQV2?=
 =?us-ascii?Q?BT/EUSvhdKV0RYBOrZPZ/AkR5EE0aK/guJjAJd6WWN2UQ+3c2C0fff4N7TsE?=
 =?us-ascii?Q?kpHOU/3moNpEZgjlVSorPAyDKFiGWFJ0lorySJzEDH2ZzfjqZ58aD6tRmRi1?=
 =?us-ascii?Q?qPaPfn/LQxC78cxWMkuV+yB+9wjgCkpgoQCJj6Vb3qad6JOu50XeNgrb7V67?=
 =?us-ascii?Q?bl1PSNn+l9LQfyOrFPLLt1V8oKpQHa7Qhxs4L9s53hEqoglMFNklYwarp+Ih?=
 =?us-ascii?Q?9oWKWr19AxNq10fFBfUP8FqeCANMmoMqaen8/kfzXfUos78dCHbkHBX9Hchi?=
 =?us-ascii?Q?CfWLiWvOqOVjKtY7pkixRX31OACixduKBkLf6vzFbH+2pq9J2mG5OG3eZ8tc?=
 =?us-ascii?Q?iKdUJ68EwoI1mvbUDFzhCYuatqTnilWhzyqBhBCsGRev2JJ20PEhOh5hpQ0W?=
 =?us-ascii?Q?bZtRqLMBhtqgxqepgLCxmft235xvMG4m0ij0L/bL1ZNuHgUtr+h0KLIav3gx?=
 =?us-ascii?Q?YyVOaqAogpsdSTqOMqRF9cXGx34fNGhcWf4DVmvGa0pB4gDzrFQgXDHe+d/d?=
 =?us-ascii?Q?0108TcIFVdN3ehP1un8pl8WK8cJmJkt8dAVdPC6OrpA4uZXepuUZp3bIo4nP?=
 =?us-ascii?Q?DXOuojkT4lKiZU678VOScqlUQ3RiNkWINJMGYzuOFlGAHwbLewnOKALXj4I9?=
 =?us-ascii?Q?C3G8wv2bNtJxx7KJQ4Z+sq6h0KbJuJ2S4UrbDiCT/uv2Bi3Ui/zB06Cura4r?=
 =?us-ascii?Q?ZdbodoO/N7EUCZKN0a8swphCI9qUp0fPuM91+AaNu4obrapYtOZTtua0oT2M?=
 =?us-ascii?Q?vxRs798J/B+4oIm2rDL16Gh7+vEeUnprVpTCWhLurRAlcEO/N9GxzYjmVmsI?=
 =?us-ascii?Q?YFAAbbXoXvfhhHkD3PahJlMfm94Z6wQr0Q53T4GmPAMqyuBa6bgwqCfZtOX3?=
 =?us-ascii?Q?0Q=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f534de-bad3-46ce-960d-08de25eed66c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 15:34:46.5729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P6oL8z9LAKuunE9TCt5PkILj3mZQBQzvH2KmOjmXEiw11dlua1jHzUuclg4/X/R8y4AHKgW+0E+VhrvGDElxIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3801
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Nov 2025 15:35:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20589

On 17.11.25 15:26, Jan Kiszka wrote:
> On 17.11.25 15:02, Biju Das wrote:
>>
>>
>>> -----Original Message-----
>>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On =
Behalf Of Biju Das via
>>> lists.cip-project.org
>>> Sent: 17 November 2025 13:50
>>> To: Jan Kiszka <jan.kiszka@siemens.com>; Chris Paterson <Chris.Paterson=
2@renesas.com>; cip-dev <cip-
>>> dev@lists.cip-project.org>
>>> Subject: Re: [cip-dev] Testing on hihope-rzg2m
>>>
>>> Hi Jan Kiszka,
>>>
>>>> -----Original Message-----
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>> Subject: Re: Testing on hihope-rzg2m
>>>>
>>>> On 17.11.25 14:42, Biju Das wrote:
>>>>>
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>> Sent: 17 November 2025 13:17
>>>>>> To: Biju Das <biju.das.jz@bp.renesas.com>; Chris Paterson
>>>>>> <Chris.Paterson2@renesas.com>; cip-dev <cip-
>>>>>> dev@lists.cip-project.org>
>>>>>> Subject: Testing on hihope-rzg2m (was: Re: [cip-dev] Testing
>>>>>> isar-cip-core on the iwg20d)
>>>>>>
>>>>>> On 17.11.25 13:22, Jan Kiszka wrote:
>>>>>>> Now I have a somewhat similar issue on the HiHope V4 RZ/G2M I unpac=
ked:
>>>>>>>
>>>>>>> U-Boot 2020.10
>>>>>>>
>>>>>>> Wanted to enable EFI booting, but U-Boot is likely too old for that=
.
>>>>>>> If you happen to have an image for that thing as well, that would b=
e great.
>>>>>>>
>>>>>>
>>>>>> As that u-boot lacks distro-boot support (sigh), I had to emulate
>>>>>> that manually. But then I got things booting on 6.12-cip
>>>>>> (cip_merged_defconfig), though with quite
>>>> a few warnings and delays:
>>>>>>
>>>>>> Starting kernel ...
>>>>>>
>>>>>> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x411fd07=
3]
>>>>>> [    0.000000] Linux version 6.12.57-cip12 (isar-users@googlegroups.=
com) (aarch64-linux-gnu-gcc
>>>>>> (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44)
>>>>>> #1 SMP PREEMPT Thu, 01 Jan 1970
>>>>>> 02:00:00 +0100
>>>>>>
>>>>>
>>>>> Old log from 6.1.y-cip:
>>>>>
>>>>>
>>>>> NOTICE:  BL2: RZ/G2 Initial Program Loader(CA57) Rev.2.0.6
>>>>> NOTICE:  BL2: PRR is RZ/G2M Ver.1.3
>>>>> NOTICE:  BL2: Board is HiHope RZ/G2M Rev.4.0
>>>>> NOTICE:  BL2: Boot device is QSPI Flash(40MHz)
>>>>> NOTICE:  BL2: DDR3200(rev.0.40)
>>>>> NOTICE:  BL2: [COLD_BOOT]
>>>>> NOTICE:  BL2: DRAM Split is 2ch
>>>>> NOTICE:  BL2: QoS is default setting(rev.0.19)
>>>>> NOTICE:  BL2: DRAM refresh interval 1.95 usec
>>>>> NOTICE:  BL2: Periodic Write DQ Training
>>>>> NOTICE:  BL2: CH0: 400000000 - 47fffffff, 2 GiB
>>>>> NOTICE:  BL2: CH2: 600000000 - 67fffffff, 2 GiB
>>>>> NOTICE:  BL2: Lossy Decomp areas
>>>>> NOTICE:       Entry 0: DCMPAREACRAx:0x80000540 DCMPAREACRBx:0x570
>>>>> NOTICE:       Entry 1: DCMPAREACRAx:0x40000000 DCMPAREACRBx:0x0
>>>>> NOTICE:       Entry 2: DCMPAREACRAx:0x20000000 DCMPAREACRBx:0x0
>>>>> NOTICE:  BL2: FDT at 0xe631d8b0
>>>>> NOTICE:  BL2: v2.4(release):v2.4-234-gf9bbb5d7b
>>>>> NOTICE:  BL2: Built : 13:21:17, Jan 18 2021
>>>>> NOTICE:  BL2: Normal boot
>>>>> NOTICE:  BL2: dst=3D0xe631d000 src=3D0x8180000 len=3D512(0x200)
>>>>> NOTICE:  BL2: dst=3D0x43f00000 src=3D0x8180400 len=3D6144(0x1800)
>>>>> NOTICE:  rcar_file_len: len: 0x0003e000
>>>>> NOTICE:  BL2: dst=3D0x44000000 src=3D0x81c0000 len=3D253952(0x3e000)
>>>>> NOTICE:  rcar_file_len: len: 0x00100000
>>>>> NOTICE:  BL2: dst=3D0x44100000 src=3D0x8200000 len=3D1048576(0x100000=
)
>>>>> NOTICE:  rcar_file_len: len: 0x00100000
>>>>> NOTICE:  BL2: dst=3D0x50000000 src=3D0x8300000 len=3D1048576(0x100000=
)
>>>>> NOTICE:  BL2: Booting BL31
>>>>>
>>>>>
>>>>> U-Boot 2021.07-rc5-00010-gb7ad721c83 (Jun 30 2021 - 20:43:24 +0100)
>>>>>
>>>>> CPU: Renesas Electronics R8A774A1 rev 1.3
>>>>> Model: HopeRun HiHope RZ/G2M with sub board
>>>>> DRAM:  3.9 GiB
>>>>> MMC:   mmc@ee100000: 0, mmc@ee160000: 1
>>>>> Loading Environment from MMC... OK
>>>>> In:    serial@e6e88000
>>>>> Out:   serial@e6e88000
>>>>> Err:   serial@e6e88000
>>>>> Net:   eth0: ethernet@e6800000
>>>>> Hit any key to stop autoboot:  0
>>>>> ethernet@e6800000 Waiting for PHY auto negotiation to complete......
>>>>> done Using ethernet@e6800000 device TFTP from server 192.168.10.1;
>>>>> our IP address is 192.168.10.5 Filename 'RZ-G2M/boot/Image'.
>>>>> Load address: 0x48080000
>>>>> Loading: ############################################################=
#####
>>>>>          382.8 KiB/s
>>>>> done
>>>>> Bytes transferred =3D 37292544 (2390a00 hex) Using ethernet@e6800000
>>>>> device TFTP from server 192.168.10.1; our IP address is 192.168.10.5
>>>>> Filename 'RZ-G2M/boot/dtb'.
>>>>> Load address: 0x48000000
>>>>> Loading: ############
>>>>>          381.8 KiB/s
>>>>> done
>>>>> Bytes transferred =3D 57904 (e230 hex) Moving Image from 0x48080000 t=
o
>>>>> 0x48200000, end=3D4a630000 ## Flattened Device Tree blob at 48000000
>>>>>    Booting using the fdt blob at 0x48000000
>>>>>    Using Device Tree in place at 0000000048000000, end
>>>>> 000000004801122f Overlap found: 0x600000000..0x67fffffff /
>>>>> 0x600000000..0x67fffffff
>>>>>
>>>>> Starting kernel ...
>>>>>
>>>>> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x411fd073=
]
>>>>> [    0.000000] Linux version 6.1.31-01333-g486caac40d06 (biju@biju-Vi=
rtualBox) (aarch64-none-
>>> linux-
>>>> gnu-gcc (GNU Toolchain for the A-profile Architecture 10.3-2021.07
>>>> (arm-10.29)) 10.3.1 20210621, GNU ld (GNU Toolchain for the A-profile
>>>> Architecture 10.3-2021.07 (arm-10.29)) 2.36.1.20210621) #41 SMP
>>>> PREEMPT Thu Jun 15 10:35:42 BST 2023
>>>>> [    0.000000] Machine model: HopeRun HiHope RZ/G2M with sub board
>>>>> [    0.000000] printk: debug: ignoring loglevel setting.
>>>>> [    0.000000] efi: UEFI not found.
>>>>> [    0.000000] NUMA: No NUMA configuration found
>>>>> [    0.000000] NUMA: Faking a node at [mem 0x0000000048000000-0x00000=
0067fffffff]
>>>>> [    0.000000] NUMA: NODE_DATA [mem 0x67f7eba00-0x67f7edfff]
>>>>> [    0.000000] Zone ranges:
>>>>> [    0.000000]   DMA      [mem 0x0000000048000000-0x00000000ffffffff]
>>>>> [    0.000000]   DMA32    empty
>>>>> [    0.000000]   Normal   [mem 0x0000000100000000-0x000000067fffffff]
>>>>> [    0.000000] Movable zone start for each node
>>>>> [    0.000000] Early memory node ranges
>>>>> [    0.000000]   node   0: [mem 0x0000000048000000-0x00000000bfffffff=
]
>>>>> [    0.000000]   node   0: [mem 0x0000000600000000-0x000000067fffffff=
]
>>>>> [    0.000000] Initmem setup node 0 [mem 0x0000000048000000-0x0000000=
67fffffff]
>>>>> [    0.000000] cma: Reserved 32 MiB at 0x00000000be000000
>>>>> [    0.000000] psci: probing for conduit method from DT.
>>>>> [    0.000000] psci: PSCIv1.1 detected in firmware.
>>>>> [    0.000000] psci: Using standard PSCI v0.2 function IDs
>>>>> [    0.000000] psci: Trusted OS migration not required
>>>>> [    0.000000] psci: SMC Calling Convention v1.2
>>>>> [    0.000000] percpu: Embedded 20 pages/cpu s44840 r8192 d28888 u819=
20
>>>>> [    0.000000] pcpu-alloc: s44840 r8192 d28888 u81920 alloc=3D20*4096
>>>>> [    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5
>>>>> [    0.000000] Detected PIPT I-cache on CPU0
>>>>> [    0.000000] CPU features: detected: Spectre-v2
>>>>> [    0.000000] CPU features: detected: Spectre-v3a
>>>>> [    0.000000] CPU features: detected: Spectre-BHB
>>>>> [    0.000000] CPU features: detected: ARM erratum 1742098
>>>>> [    0.000000] CPU features: detected: ARM errata 1165522, 1319367, o=
r 1530923
>>>>> [    0.000000] alternatives: applying boot alternatives
>>>>> [    0.000000] Fallback order for Node 0: 0
>>>>> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages:=
 999936
>>>>> [    0.000000] Policy zone: Normal
>>>>> [    0.000000] Kernel command line: ignore_loglevel nfsrootdebug root=
=3D/dev/nfs rw
>>>> nfsroot=3D192.168.10.1:/tftpboot/RZ-G2M,nfsvers=3D3 ip=3D192.168.10.5
>>>>> [    0.000000] Unknown kernel command line parameters "nfsrootdebug",=
 will be passed to user
>>> space.
>>>>> [    0.000000] Dentry cache hash table entries: 524288 (order: 10, 41=
94304 bytes, linear)
>>>>> [    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097=
152 bytes, linear)
>>>>> [    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:of=
f
>>>>> [    0.000000] software IO TLB: area num 8.
>>>>> [    0.000000] software IO TLB: mapped [mem 0x00000000ba000000-0x0000=
0000be000000] (64MB)
>>>>> [    0.000000] Memory: 3848660K/4063232K available (16128K kernel cod=
e, 3714K rwdata, 8856K
>>> rodata,
>>>> 7552K init, 609K bss, 181804K reserved, 32768K cma-reserved)
>>>>> [    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=
=3D6, Nodes=3D1
>>>>> [    0.000000] rcu: Preemptible hierarchical RCU implementation.
>>>>> [    0.000000] rcu:     RCU event tracing is enabled.
>>>>> [    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=3D256 to nr=
_cpu_ids=3D6.
>>>>> [    0.000000]  Trampoline variant of Tasks RCU enabled.
>>>>> [    0.000000]  Tracing variant of Tasks RCU enabled.
>>>>> [    0.000000] rcu: RCU calculated value of scheduler-enlistment dela=
y is 25 jiffies.
>>>>> [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_c=
pu_ids=3D6
>>>>> [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
>>>>> [    0.000000] Root IRQ handler: gic_handle_irq
>>>>> [    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on con=
tention.
>>>>> [    0.000000] arch_timer: cp15 timer(s) running at 8.33MHz (virt).
>>>>> [    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff =
max_cycles: 0x1ec02923e,
>>>> max_idle_ns: 440795202125 ns
>>>>> [    0.000000] sched_clock: 56 bits at 8MHz, resolution 120ns, wraps =
every 2199023255496ns
>>>>> [    0.000175] Console: colour dummy device 80x25
>>>>> [    0.000383] printk: console [tty0] enabled
>>>>> [    0.000455] Calibrating delay loop (skipped), value calculated usi=
ng timer frequency.. 16.66
>>>> BogoMIPS (lpj=3D33333)
>>>>> [    0.000471] pid_max: default: 32768 minimum: 301
>>>>> [    0.000521] LSM: Security Framework initializing
>>>>> [    0.000612] Mount-cache hash table entries: 8192 (order: 4, 65536 =
bytes, linear)
>>>>> [    0.000638] Mountpoint-cache hash table entries: 8192 (order: 4, 6=
5536 bytes, linear)
>>>>> [    0.002022] cblist_init_generic: Setting adjustable number of call=
back queues.
>>>>> [    0.002053] cblist_init_generic: Setting shift to 3 and lim to 1.
>>>>> [    0.002122] cblist_init_generic: Setting shift to 3 and lim to 1.
>>>>> [    0.002271] rcu: Hierarchical SRCU implementation.
>>>>> [    0.002281] rcu:     Max phase no-delay instances is 1000.
>>>>> [    0.003558] Detected Renesas RZ/G2 r8a774a1 ES1.3
>>>>> [    0.004756] EFI services will not be available.
>>>>> [    0.005069] smp: Bringing up secondary CPUs ...
>>>>> [    0.005550] Detected PIPT I-cache on CPU1
>>>>> [    0.005668] CPU1: Booted secondary processor 0x0000000001 [0x411fd=
073]
>>>>> [    0.006207] CPU features: detected: ARM erratum 845719
>>>>> [    0.006223] Detected VIPT I-cache on CPU2
>>>>> [    0.006358] CPU2: Booted secondary processor 0x0000000100 [0x410fd=
034]
>>>>> [    0.006814] Detected VIPT I-cache on CPU3
>>>>> [    0.006881] CPU3: Booted secondary processor 0x0000000101 [0x410fd=
034]
>>>>> [    0.007310] Detected VIPT I-cache on CPU4
>>>>> [    0.007387] CPU4: Booted secondary processor 0x0000000102 [0x410fd=
034]
>>>>> [    0.007841] Detected VIPT I-cache on CPU5
>>>>> [    0.007922] CPU5: Booted secondary processor 0x0000000103 [0x410fd=
034]
>>>>> [    0.007998] smp: Brought up 1 node, 6 CPUs
>>>>> [    0.008054] SMP: Total of 6 processors activated.
>>>>> [    0.008061] CPU features: detected: 32-bit EL0 Support
>>>>> [    0.008066] CPU features: detected: 32-bit EL1 Support
>>>>> [    0.008073] CPU features: detected: CRC32 instructions
>>>>> [    0.008140] CPU: All CPU(s) started at EL1
>>>>> [    0.008165] alternatives: applying system-wide alternatives
>>>>> [    0.009890] devtmpfs: initialized
>>>>> [    0.015549] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xf=
fffffff, max_idle_ns:
>>>> 7645041785100000 ns
>>>>> [    0.015583] futex hash table entries: 2048 (order: 5, 131072 bytes=
, linear)
>>>>> [    0.016468] pinctrl core: initialized pinctrl subsystem
>>>>> [    0.018065] DMI not present or invalid.
>>>>> [    0.018538] NET: Registered PF_NETLINK/PF_ROUTE protocol family
>>>>> [    0.019270] DMA: preallocated 512 KiB GFP_KERNEL pool for atomic a=
llocations
>>>>> [    0.019514] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA pool for =
atomic allocations
>>>>> [    0.019670] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA32 pool fo=
r atomic allocations
>>>>> [    0.019731] audit: initializing netlink subsys (disabled)
>>>>> [    0.019855] audit: type=3D2000 audit(0.016:1): state=3Dinitialized=
 audit_enabled=3D0 res=3D1
>>>>> [    0.020894] thermal_sys: Registered thermal governor 'step_wise'
>>>>> [    0.020900] thermal_sys: Registered thermal governor 'power_alloca=
tor'
>>>>> [    0.020956] cpuidle: using governor menu
>>>>> [    0.021094] hw-breakpoint: found 6 breakpoint and 4 watchpoint reg=
isters.
>>>>> [    0.021200] ASID allocator initialised with 65536 entries
>>>>> [    0.022440] Serial: AMBA PL011 UART driver
>>>>> [    0.029355] sh-pfc e6060000.pinctrl: r8a774a1_pfc support register=
ed
>>>>> [    0.034772] platform ec500000.sound: Fixed dependency cycle(s) wit=
h /soc/hdmi@fead0000
>>>>> [    0.040013] platform fead0000.hdmi: Fixed dependency cycle(s) with=
 /soc/display@feb00000
>>>>> [    0.040784] platform fead0000.hdmi: Fixed dependency cycle(s) with=
 /hdmi0-out
>>>>> [    0.042535] KASLR disabled due to lack of seed
>>>>> [    0.047435] HugeTLB: registered 1.00 GiB page size, pre-allocated =
0 pages
>>>>> [    0.047449] HugeTLB: 0 KiB vmemmap can be freed for a 1.00 GiB pag=
e
>>>>> [    0.047457] HugeTLB: registered 32.0 MiB page size, pre-allocated =
0 pages
>>>>> [    0.047464] HugeTLB: 0 KiB vmemmap can be freed for a 32.0 MiB pag=
e
>>>>> [    0.047470] HugeTLB: registered 2.00 MiB page size, pre-allocated =
0 pages
>>>>> [    0.047476] HugeTLB: 0 KiB vmemmap can be freed for a 2.00 MiB pag=
e
>>>>> [    0.047484] HugeTLB: registered 64.0 KiB page size, pre-allocated =
0 pages
>>>>> [    0.047489] HugeTLB: 0 KiB vmemmap can be freed for a 64.0 KiB pag=
e
>>>>> [    0.048889] ACPI: Interpreter disabled.
>>>>> [    0.052814] iommu: Default domain type: Translated
>>>>> [    0.052828] iommu: DMA domain TLB invalidation policy: strict mode
>>>>> [    0.053008] SCSI subsystem initialized
>>>>> [    0.053139] libata version 3.00 loaded.
>>>>> [    0.053303] usbcore: registered new interface driver usbfs
>>>>> [    0.053330] usbcore: registered new interface driver hub
>>>>> [    0.053354] usbcore: registered new device driver usb
>>>>> [    0.054245] pps_core: LinuxPPS API ver. 1 registered
>>>>> [    0.054255] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Ro=
dolfo Giometti
>>>> <giometti@linux.it>
>>>>> [    0.054269] PTP clock support registered
>>>>> [    0.054373] EDAC MC: Ver: 3.0.0
>>>>> [    0.055956] FPGA manager framework
>>>>> [    0.056014] Advanced Linux Sound Architecture Driver Initialized.
>>>>> [    0.056752] vgaarb: loaded
>>>>> [    0.057006] clocksource: Switched to clocksource arch_sys_counter
>>>>> [    0.057167] VFS: Disk quotas dquot_6.6.0
>>>>> [    0.057201] VFS: Dquot-cache hash table entries: 512 (order 0, 409=
6 bytes)
>>>>> [    0.057333] pnp: PnP ACPI: disabled
>>>>> [    0.061785] NET: Registered PF_INET protocol family
>>>>> [    0.061987] IP idents hash table entries: 65536 (order: 7, 524288 =
bytes, linear)
>>>>> [    0.063912] tcp_listen_portaddr_hash hash table entries: 2048 (ord=
er: 3, 32768 bytes, linear)
>>>>> [    0.063955] Table-perturb hash table entries: 65536 (order: 6, 262=
144 bytes, linear)
>>>>> [    0.063974] TCP established hash table entries: 32768 (order: 6, 2=
62144 bytes, linear)
>>>>> [    0.064125] TCP bind hash table entries: 32768 (order: 8, 1048576 =
bytes, linear)
>>>>> [    0.064688] TCP: Hash tables configured (established 32768 bind 32=
768)
>>>>> [    0.064792] UDP hash table entries: 2048 (order: 4, 65536 bytes, l=
inear)
>>>>> [    0.064862] UDP-Lite hash table entries: 2048 (order: 4, 65536 byt=
es, linear)
>>>>> [    0.065059] NET: Registered PF_UNIX/PF_LOCAL protocol family
>>>>> [    0.065342] RPC: Registered named UNIX socket transport module.
>>>>> [    0.065355] RPC: Registered udp transport module.
>>>>> [    0.065360] RPC: Registered tcp transport module.
>>>>> [    0.065365] RPC: Registered tcp NFSv4.1 backchannel transport modu=
le.
>>>>> [    0.065377] PCI: CLS 0 bytes, default 64
>>>>> [    0.066217] hw perfevents: enabled with armv8_cortex_a53 PMU drive=
r, 7 counters available
>>>>> [    0.066500] hw perfevents: enabled with armv8_cortex_a57 PMU drive=
r, 7 counters available
>>>>> [    0.066917] kvm [1]: HYP mode not available
>>>>> [    0.067702] Initialise system trusted keyrings
>>>>> [    0.067851] workingset: timestamp_bits=3D42 max_order=3D20 bucket_=
order=3D0
>>>>> [    0.071358] squashfs: version 4.0 (2009/01/31) Phillip Lougher
>>>>> [    0.071764] NFS: Registering the id_resolver key type
>>>>> [    0.071797] Key type id_resolver registered
>>>>> [    0.071803] Key type id_legacy registered
>>>>> [    0.071869] nfs4filelayout_init: NFSv4 File Layout Driver Register=
ing...
>>>>> [    0.071880] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver =
Registering...
>>>>> [    0.071997] 9p: Installing v9fs 9p2000 file system support
>>>>> [    0.097939] Key type asymmetric registered
>>>>> [    0.097955] Asymmetric key parser 'x509' registered
>>>>> [    0.098005] Block layer SCSI generic (bsg) driver version 0.4 load=
ed (major 245)
>>>>> [    0.098017] io scheduler mq-deadline registered
>>>>> [    0.098024] io scheduler kyber registered
>>>>> [    0.107668] gpio_rcar e6050000.gpio: driving 16 GPIOs
>>>>> [    0.107979] gpio_rcar e6051000.gpio: driving 29 GPIOs
>>>>> [    0.108212] gpio_rcar e6052000.gpio: driving 15 GPIOs
>>>>> [    0.108440] gpio_rcar e6053000.gpio: driving 16 GPIOs
>>>>> [    0.108665] gpio_rcar e6054000.gpio: driving 18 GPIOs
>>>>> [    0.108888] gpio_rcar e6055000.gpio: driving 26 GPIOs
>>>>> [    0.109048] gpio-1906 (usb1-reset): hogged as output/low
>>>>> [    0.109171] gpio_rcar e6055400.gpio: driving 32 GPIOs
>>>>> [    0.109412] gpio_rcar e6055800.gpio: driving 4 GPIOs
>>>>> [    0.110999] rcar-pcie fe000000.pcie: host bridge /soc/pcie@fe00000=
0 ranges:
>>>>> [    0.111044] rcar-pcie fe000000.pcie:       IO 0x00fe100000..0x00fe=
1fffff -> 0x0000000000
>>>>> [    0.111068] rcar-pcie fe000000.pcie:      MEM 0x00fe200000..0x00fe=
3fffff -> 0x00fe200000
>>>>> [    0.111086] rcar-pcie fe000000.pcie:      MEM 0x0030000000..0x0037=
ffffff -> 0x0030000000
>>>>> [    0.111103] rcar-pcie fe000000.pcie:      MEM 0x0038000000..0x003f=
ffffff -> 0x0038000000
>>>>> [    0.111120] rcar-pcie fe000000.pcie:   IB MEM 0x0040000000..0x00bf=
ffffff -> 0x0040000000
>>>>> [    0.180633] rcar-pcie fe000000.pcie: PCIe link down
>>>>> [    0.180793] rcar-pcie ee800000.pcie: host bridge /soc/pcie@ee80000=
0 ranges:
>>>>> [    0.180824] rcar-pcie ee800000.pcie:       IO 0x00ee900000..0x00ee=
9fffff -> 0x0000000000
>>>>> [    0.180843] rcar-pcie ee800000.pcie:      MEM 0x00eea00000..0x00ee=
bfffff -> 0x00eea00000
>>>>> [    0.180860] rcar-pcie ee800000.pcie:      MEM 0x00c0000000..0x00c7=
ffffff -> 0x00c0000000
>>>>> [    0.180873] rcar-pcie ee800000.pcie:      MEM 0x00c8000000..0x00cf=
ffffff -> 0x00c8000000
>>>>> [    0.180889] rcar-pcie ee800000.pcie:   IB MEM 0x0040000000..0x00bf=
ffffff -> 0x0040000000
>>>>> [    0.248601] rcar-pcie ee800000.pcie: PCIe link down
>>>>> [    0.250286] EINJ: ACPI disabled.
>>>>> [    0.267824] Serial: 8250/16550 driver, 4 ports, IRQ sharing enable=
d
>>>>> [    0.270221] SuperH (H)SCI(F) driver initialized
>>>>> [    0.270645] e6540000.serial: ttySC1 at MMIO 0xe6540000 (irq =3D 28=
, base_baud =3D 0) is a hscif
>>>>> [    0.270841] serial serial0: tty port ttySC1 registered
>>>>> [    0.271322] e6e88000.serial: ttySC0 at MMIO 0xe6e88000 (irq =3D 29=
, base_baud =3D 0) is a scif
>>>>> [    1.473185] printk: console [ttySC0] enabled
>>>>> [    1.478260] msm_serial: driver initialized
>>>>> [    1.488277] loop: module loaded
>>>>> [    1.492487] megasas: 07.719.03.00-rc1
>>>>> [    1.500948] tun: Universal TUN/TAP device driver, 1.6
>>>>> [    1.506792] thunder_xcv, ver 1.0
>>>>> [    1.510065] thunder_bgx, ver 1.0
>>>>> [    1.513315] nicpf, ver 1.0
>>>>> [    1.517043] hns3: Hisilicon Ethernet Network Driver for Hip08 Fami=
ly - version
>>>>> [    1.524274] hns3: Copyright (c) 2017 Huawei Corporation.
>>>>> [    1.529634] hclge is initializing
>>>>> [    1.532961] e1000: Intel(R) PRO/1000 Network Driver
>>>>> [    1.537842] e1000: Copyright (c) 1999-2006 Intel Corporation.
>>>>> [    1.543609] e1000e: Intel(R) PRO/1000 Network Driver
>>>>> [    1.548574] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
>>>>> [    1.554519] igb: Intel(R) Gigabit Ethernet Network Driver
>>>>> [    1.559920] igb: Copyright (c) 2007-2014 Intel Corporation.
>>>>> [    1.565510] igbvf: Intel(R) Gigabit Virtual Function Network Drive=
r
>>>>> [    1.571779] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
>>>>> [    1.577998] sky2: driver version 1.30
>>>>> [    1.583033] VFIO - User Level meta-driver version: 0.3
>>>>> [    1.590446] ehci-platform ee0a0100.usb: EHCI Host Controller
>>>>> [    1.590607] ohci-platform ee0a0000.usb: Generic Platform OHCI cont=
roller
>>>>> [    1.590985] xhci-renesas-hcd ee000000.usb: xHCI Host Controller
>>>>> [    1.591000] xhci-renesas-hcd ee000000.usb: new USB bus registered,=
 assigned bus number 1
>>>>> [    1.591240] xhci-renesas-hcd ee000000.usb: Direct firmware load fo=
r r8a779x_usb3_v3.dlmem
>>> failed
>>>> with error -2
>>>>> [    1.591249] xhci-renesas-hcd ee000000.usb: can't setup: -2
>>>>> [    1.591256] xhci-renesas-hcd ee000000.usb: USB bus 1 deregistered
>>>>> [    1.591297] xhci-renesas-hcd: probe of ee000000.usb failed with er=
ror -2
>>>>> [    1.591740] usbcore: registered new interface driver usb-storage
>>>>> [    1.593945] i2c_dev: i2c /dev entries driver
>>>>> [    1.595936] cs2000-cp 2-004f: operating in static mode
>>>>> [    1.596155] ehci-platform ee0a0100.usb: new USB bus registered, as=
signed bus number 1
>>>>> [    1.602853] ohci-platform ee0a0000.usb: new USB bus registered, as=
signed bus number 2
>>>>> [    1.604384] cs2000-cp 2-004f: revision - C1
>>>>> [    1.604453] i2c-rcar e6510000.i2c: probed
>>>>> [    1.608397] i2c-rcar e66d8000.i2c: probed
>>>>> [    1.608922] ehci-platform ee0a0100.usb: irq 30, io mem 0xee0a0100
>>>>> [    1.614877] rcar_gen3_thermal e6198000.thermal: Sensor 0: Loaded 1=
 trip points
>>>>> [    1.616968] ohci-platform ee0a0000.usb: irq 30, io mem 0xee0a0000
>>>>> [    1.619042] rcar_gen3_thermal e6198000.thermal: Sensor 1: Loaded 1=
 trip points
>>>>> [    1.623039] rcar_gen3_thermal e6198000.thermal: Sensor 2: Loaded 2=
 trip points
>>>>> [    1.625993] cpufreq: cpufreq_online: CPU0: Running at unlisted ini=
tial frequency: 1499999 KHz,
>>>> changing to: 1500000 KHz
>>>>> [    1.626092] cpu cpu0: EM: created perf domain
>>>>> [    1.627347] cpufreq: cpufreq_online: CPU2: Running at unlisted ini=
tial frequency: 1199999 KHz,
>>>> changing to: 1200000 KHz
>>>>> [    1.641018] ehci-platform ee0a0100.usb: USB 2.0 started, EHCI 1.10
>>>>> [    1.645298] cpu cpu2: EM: created perf domain
>>>>> [    1.651771] hub 1-0:1.0: USB hub found
>>>>> [    1.657822] sdhci: Secure Digital Host Controller Interface driver
>>>>> [    1.660611] hub 1-0:1.0: 1 port detected
>>>>> [    1.668416] sdhci: Copyright(c) Pierre Ossman
>>>>> [    1.724974] hub 2-0:1.0: USB hub found
>>>>> [    1.733929] Synopsys Designware Multimedia Card Interface Driver
>>>>> [    1.737451] hub 2-0:1.0: 1 port detected
>>>>> [    1.749018] sdhci-pltfm: SDHCI platform and OF driver helper
>>>>> [    1.783950] renesas_sdhi_internal_dmac ee160000.mmc: mmc0 base at =
0x00000000ee160000, max clock
>>>> rate 200 MHz
>>>>> [    1.806425] ledtrig-cpu: registered to indicate activity on CPUs
>>>>> [    1.814031] SMCCC: SOC_ID: ARCH_SOC_ID not implemented, skipping .=
...
>>>>> [    1.821194] usbcore: registered new interface driver usbhid
>>>>> [    1.826778] usbhid: USB HID core driver
>>>>> [    1.833900] optee: probing for conduit method.
>>>>> [    1.838373] optee: revision 3.11 (d541c4fa)
>>>>> [    1.838642] optee: dynamic shared memory is enabled
>>>>> [    1.848005] optee: initialized driver
>>>>> [    1.854491] NET: Registered PF_PACKET protocol family
>>>>> [    1.859675] 9pnet: Installing 9P2000 support
>>>>> [    1.863997] Key type dns_resolver registered
>>>>> [    1.868561] registered taskstats version 1
>>>>> [    1.872694] Loading compiled-in X.509 certificates
>>>>> [    1.884540] mmc0: new HS200 MMC card at address 0001
>>>>> [    1.890297] renesas_irqc e61c0000.interrupt-controller: driving 6 =
irqs
>>>>> [    1.890323] mmcblk0: mmc0:0001 S0J57X 29.6 GiB
>>>>> [    1.903540]  mmcblk0: p1
>>>>> [    1.906931] mmcblk0boot0: mmc0:0001 S0J57X 31.5 MiB
>>>>> [    1.913486] mmcblk0boot1: mmc0:0001 S0J57X 31.5 MiB
>>>>> [    1.919903] mmcblk0rpmb: mmc0:0001 S0J57X 4.00 MiB, chardev (234:0=
)
>>>>> [    1.922951] renesas_sdhi_internal_dmac ee100000.mmc: Got CD GPIO
>>>>> [    1.933030] usb 1-1: new high-speed USB device number 2 using ehci=
-platform
>>>>> [    1.941041] ehci-platform ee080100.usb: EHCI Host Controller
>>>>> [    1.946727] ehci-platform ee080100.usb: new USB bus registered, as=
signed bus number 3
>>>>> [    1.949037] ohci-platform ee080000.usb: Generic Platform OHCI cont=
roller
>>>>> [    1.954690] ehci-platform ee080100.usb: irq 43, io mem 0xee080100
>>>>> [    1.961448] ohci-platform ee080000.usb: new USB bus registered, as=
signed bus number 4
>>>>> [    1.975374] ohci-platform ee080000.usb: irq 43, io mem 0xee080000
>>>>> [    2.007516] renesas_sdhi_internal_dmac ee100000.mmc: mmc1 base at =
0x00000000ee100000, max clock
>>>> rate 200 MHz
>>>>> [    2.050955] renesas_sdhi_internal_dmac ee140000.mmc: mmc2 base at =
0x00000000ee140000, max clock
>>>> rate 200 MHz
>>>>> [    2.071178] renesas_sdhi_internal_dmac ee140000.mmc: card claims t=
o support voltages below
>>>> defined range
>>>>> [    2.071755] hub 4-0:1.0: USB hub found
>>>>> [    2.081017] ehci-platform ee080100.usb: USB 2.0 started, EHCI 1.10
>>>>> [    2.084450] hub 4-0:1.0: 1 port detected
>>>>> [    2.094394] hub 1-1:1.0: USB hub found
>>>>> [    2.095297] hub 3-0:1.0: USB hub found
>>>>> [    2.098474] hub 1-1:1.0: 2 ports detected
>>>>> [    2.102043] hub 3-0:1.0: 1 port detected
>>>>> [    2.107346] mmc2: new high speed SDIO card at address 0001
>>>>> [    2.114978] Trying to probe devices needed for running init ...
>>>>> [    2.693038] usb 4-1: new full-speed USB device number 2 using ohci=
-platform
>>>>> [    2.893034] usb 4-1: device descriptor read/64, error -62
>>>>> [    3.201035] usb 4-1: device descriptor read/64, error -62
>>>>> [    3.501034] usb 4-1: new full-speed USB device number 3 using ohci=
-platform
>>>>> [    3.701038] usb 4-1: device descriptor read/64, error -62
>>>>> [    4.005035] usb 4-1: device descriptor read/64, error -62
>>>>> [    4.117056] usb usb4-port1: attempt power cycle
>>>>> [    4.693037] usb 4-1: new full-speed USB device number 4 using ohci=
-platform
>>>>> [    5.117033] usb 4-1: device not accepting address 4, error -62
>>>>> [    5.309031] usb 4-1: new full-speed USB device number 5 using ohci=
-platform
>>>>> [    5.733033] usb 4-1: device not accepting address 5, error -62
>>>>> [    5.738944] usb usb4-port1: unable to enumerate USB device
>>>>> [   11.999825] ravb e6800000.ethernet: deferred probe timeout, ignori=
ng dependency
>>>>> [   12.010590] ravb e6800000.ethernet eth0: Base address at 0xe680000=
0, 00:11:22:33:44:66, IRQ 47.
>>>>> [   12.020946] rcar-dmac e6700000.dma-controller: deferred probe time=
out, ignoring dependency
>>>>> [   12.034282] rcar-dmac e7300000.dma-controller: deferred probe time=
out, ignoring dependency
>>>>> [   12.048278] rcar-dmac e7310000.dma-controller: deferred probe time=
out, ignoring dependency
>>>>> [   12.061724] rcar-dmac ec700000.dma-controller: deferred probe time=
out, ignoring dependency
>>>>> [   12.075487] rcar-dmac ec720000.dma-controller: deferred probe time=
out, ignoring dependency
>>>>> [   12.358479] RTL8211E Gigabit Ethernet e6800000.ethernet-ffffffff:0=
0: attached PHY driver
>>>> (mii_bus:phy_addr=3De6800000.ethernet-ffffffff:00, irq=3D53)
>>>>> [   15.033078] ravb e6800000.ethernet eth0: Link is Up - 1Gbps/Full -=
 flow control off
>>>>> [   15.057032] IP-Config: Guessing netmask 255.255.255.0
>>>>> [   15.062103] IP-Config: Complete:
>>>>> [   15.065344]      device=3Deth0, hwaddr=3D00:11:22:33:44:66, ipaddr=
=3D192.168.10.5,
>>> mask=3D255.255.255.0,
>>>> gw=3D255.255.255.255
>>>>> [   15.075808]      host=3D192.168.10.5, domain=3D, nis-domain=3D(non=
e)
>>>>> [   15.081658]      bootserver=3D255.255.255.255, rootserver=3D192.16=
8.10.1, rootpath=3D
>>>>> [   15.082230] ALSA device list:
>>>>> [   15.092536]   No soundcards found.
>>>>> [   16.157094] VFS: Mounted root (nfs filesystem) on device 0:20.
>>>>> [   16.164899] devtmpfs: mounted
>>>>> [   16.170876] Freeing unused kernel memory: 7552K
>>>>> [   16.185088] Run /sbin/init as init process
>>>>> [   16.189210]   with arguments:
>>>>> [   16.192180]     /sbin/init
>>>>> [   16.194899]     nfsrootdebug
>>>>> [   16.197791]   with environment:
>>>>> [   16.200932]     HOME=3D/
>>>>> [   16.203302]     TERM=3Dlinux
>>>>> [   16.561527] systemd[1]: System time before build time, advancing c=
lock.
>>>>> [   16.720037] NET: Registered PF_INET6 protocol family
>>>>> [   16.726453] Segment Routing with IPv6
>>>>> [   16.730209] In-situ OAM (IOAM) with IPv6
>>>>> [   16.822556] systemd[1]: systemd 244.5+ running in system mode. (+P=
AM -AUDIT -SELINUX +IMA -
>>>> APPARMOR -SMACK +SYSVINIT +UTMP -LIBCRYPTSETUP -GCRYPT -GNUTLS +ACL
>>>> +XZ -LZ4 -SECCOMP +BLKID -ELFUTILS
>>>> +KMOD -IDN2 -IDN -PCRE2 default-hierarchy=3Dhybrid)
>>>>> [   16.844941] systemd[1]: Detected architecture arm64.
>>>>>
>>>>> Welcome to Poky (Yocto Project Reference Distro) 3.1.14 (dunfell)!
>>>>>
>>>>> [   16.943204] systemd[1]: Set hostname to <rzg2m>.
>>>>> [   20.981008] random: crng init done
>>>>> [   20.986592] systemd[1]: Created slice system-getty.slice.
>>>>> [  OK  ] Created slice system-getty.slice.
>>>>> [   21.010009] systemd[1]: Created slice system-serial\x2dgetty.slice=
.
>>>>> [  OK  ] Created slice system-serial\x2dgetty.slice.
>>>>> [   21.033760] systemd[1]: Created slice User and Session Slice.
>>>>> [  OK  ] Created slice User and Session Slice.
>>>>> [   21.053378] systemd[1]: Started Dispatch Password Requests to Cons=
ole Directory Watch.
>>>>> [  OK  ] Started Dispatch Password =C3=A2=E2=82=AC=C2=A6ts to Console=
 Directory Watch.
>>>>> [   21.077282] systemd[1]: Started Forward Password Requests to Wall =
Directory Watch.
>>>>> [  OK  ] Started Forward Password R=C3=A2=E2=82=AC=C2=A6uests to Wall=
 Directory Watch.
>>>>> [   21.101190] systemd[1]: Reached target Paths.
>>>>> [  OK  ] Reached target Paths.
>>>>> [   21.121213] systemd[1]: Reached target Remote File Systems.
>>>>> [  OK  ] Reached target Remote File Systems.
>>>>> [   21.141115] systemd[1]: Reached target Slices.
>>>>> [  OK  ] Reached target Slices.
>>>>> [   21.161143] systemd[1]: Reached target Swap.
>>>>> [  OK  ] Reached target Swap.
>>>>> [   21.184024] systemd[1]: Listening on Syslog Socket.
>>>>> [  OK  ] Listening on Syslog Socket.
>>>>> [   21.205508] systemd[1]: Listening on initctl Compatibility Named P=
ipe.
>>>>> [  OK  ] Listening on initctl Compatibility Named Pipe.
>>>>> [   21.231678] systemd[1]: Listening on Journal Audit Socket.
>>>>> [  OK  ] Listening on Journal Audit Socket.
>>>>> [   21.253634] systemd[1]: Listening on Journal Socket (/dev/log).
>>>>> [  OK  ] Listening on Journal Socket (/dev/log).
>>>>> [   21.277653] systemd[1]: Listening on Journal Socket.
>>>>> [  OK  ] Listening on Journal Socket.
>>>>> [   21.299810] systemd[1]: Listening on Network Service Netlink Socke=
t.
>>>>> [  OK  ] Listening on Network Service Netlink Socket.
>>>>> [   21.325055] systemd[1]: Listening on udev Control Socket.
>>>>> [  OK  ] Listening on udev Control Socket.
>>>>> [   21.345582] systemd[1]: Listening on udev Kernel Socket.
>>>>> [  OK  ] Listening on udev Kernel Socket.
>>>>> [   21.389594] systemd[1]: Mounting Huge Pages File System...
>>>>>          Mounting Huge Pages File System...
>>>>> [   21.415019] systemd[1]: Mounting POSIX Message Queue File System..=
.
>>>>>          Mounting POSIX Message Queue File System...
>>>>> [   21.442597] systemd[1]: Mounting Kernel Debug File System...
>>>>>          Mounting Kernel Debug File System...
>>>>> [   21.473538] systemd[1]: Mounting Temporary Directory (/tmp)...
>>>>>          Mounting Temporary Directory (/tmp)...
>>>>> [   21.500835] systemd[1]: Starting Create list of static device node=
s for the current kernel...
>>>>>          Starting Create list of st=C3=A2=E2=82=AC=C2=A6odes for the =
current kernel...
>>>>> [   21.527211] systemd[1]: Condition check resulted in File System Ch=
eck on Root Device being
>>>> skipped.
>>>>> [   21.558000] systemd[1]: Starting Journal Service...
>>>>>          Starting Journal Service...
>>>>> [   21.592092] systemd[1]: Starting Load Kernel Modules...
>>>>>          Starting Load Kernel Modules...
>>>>> [   21.642177] systemd[1]: Starting Remount Root and Kernel File Syst=
ems...
>>>>>          Starting Remount Root and Kernel File Systems...
>>>>> [   21.672022] systemd[1]: Starting udev Coldplug all Devices...
>>>>>          Starting udev Coldplug all Devices...
>>>>> [   21.698059] systemd[1]: Mounted Huge Pages File System.
>>>>> [  OK  ] Mounted Huge Pages File System.
>>>>> [   21.720907] systemd[1]: Mounted POSIX Message Queue File System.
>>>>> [  OK  ] Mounted POSIX Message Queue File System.
>>>>> [   21.748815] systemd[1]: Started Journal Service.
>>>>> [  OK  ] Started Journal Service.
>>>>> [  OK  ] Mounted Kernel Debug File System.
>>>>> [  OK  ] Mounted Temporary Directory (/tmp).
>>>>> [  OK  ] Started Create list of sta=C3=A2=E2=82=AC=C2=A6 nodes for th=
e current kernel.
>>>>> [  OK  ] Started Load Kernel Modules.
>>>>> [  OK  ] Started Remount Root and Kernel File Systems.
>>>>>          Mounting Kernel Configuration File System...
>>>>>          Starting Flush Journal to Persistent Storage...
>>>>>          Starting Apply Kernel Variables...
>>>>>          Starting Create Static Device Nodes in /dev...
>>>>> [  OK  ] Mounted Kernel Configuration File System.
>>>>> [   22.023001] systemd-journald[246]: Received client request to flus=
h runtime journal.
>>>>> [  OK  ] Started Flush Journal to Persistent Storage.
>>>>> [  OK  ] Started Apply Kernel Variables.
>>>>> [  OK  ] Started Create Static Device Nodes in /dev.
>>>>> [  OK  ] Reached target Local File Systems (Pre).
>>>>>          Mounting /var/volatile...
>>>>> [   22.251839] audit: type=3D1334 audit(1600598643.683:2): prog-id=3D=
5 op=3DLOAD
>>>>> [   22.258575] audit: type=3D1334 audit(1600598643.691:3): prog-id=3D=
6 op=3DLOAD
>>>>>          Starting udev Kernel Device Manager...
>>>>> [  OK  ] Started udev Coldplug all Devices.
>>>>> [  OK  ] Mounted /var/volatile.
>>>>>          Starting udev Wait for Complete Device Initialization...
>>>>>          Starting Load/Save Random Seed...
>>>>> [  OK  ] Reached target Local File Systems.
>>>>>          Starting Create Volatile Files and Directories...
>>>>> [  OK  ] Started Load/Save Random Seed.
>>>>> [  OK  ] Started udev Kernel Device Manager.
>>>>>          Starting Network Service...
>>>>> [  OK  ] Started Network Service.
>>>>> [   22.929588] CAN device driver interface
>>>>> [   22.991089] renesas_usbhs e6590000.usb: host probed
>>>>> [   22.996295] renesas_usbhs e6590000.usb: no transceiver found
>>>>> [   23.010888] rcar_can e6c30000.can: device registered (IRQ137)
>>>>> [  OK  ] Started Create Volatile Files and Directories.
>>>>> [   23.053276] renesas_usbhs e6590000.usb: gadget probed
>>>>> [   23.058902] renesas_usbhs e6590000.usb: probed
>>>>> [   23.097761] rcar_can e6c38000.can: device registered (IRQ138)
>>>>>          Starting Network Name Resolution...
>>>>> [   23.197705] rcar-fcp fea27000.fcp: deferred probe timeout, ignorin=
g dependency
>>>>> [   23.207835] rcar-fcp fea2f000.fcp: deferred probe timeout, ignorin=
g dependency
>>>>> [   23.216663] rcar-fcp fea37000.fcp: deferred probe timeout, ignorin=
g dependency
>>>>> [   23.216944] Bluetooth: Core ver 2.22
>>>>> [   23.227933] NET: Registered PF_BLUETOOTH protocol family
>>>>> [   23.233527] Bluetooth: HCI device and connection manager initializ=
ed
>>>>>          Startin[   23.240056] Bluetooth: HCI socket layer initialize=
d
>>>>> g Netwo[   23.246378] Bluetooth: L2CAP socket layer initialized
>>>>> rk Time Synchron[   23.246876] mc: Linux media interface: v0.10
>>>>> ization...
>>>>> [   23.252689] Bluetooth: SCO socket layer initialized
>>>>> [   23.258027] rcar-fcp fe9af000.fcp: deferred probe timeout, ignorin=
g dependency
>>>>> [   23.307555] rcar_sound ec500000.sound: probed
>>>>>          Starting Update UTMP about System Boot/Shutdown...
>>>>> [   23.322917] videodev: Linux video capture interface: v2.00
>>>>> [   23.338165] renesas_usb3 ee020000.usb: probed with phy
>>>>> [  OK  ] Started Update UTMP about System Boot/Shutdown.
>>>>> [   23.436454] Bluetooth: HCI UART driver ver 2.3
>>>>> [   23.443307] Bluetooth: HCI UART protocol H4 registered
>>>>> [   23.450195] Bluetooth: HCI UART protocol LL registered
>>>>> [   23.485848] Bluetooth: HCI UART protocol Broadcom registered
>>>>> [   23.495308] Bluetooth: HCI UART protocol QCA registered
>>>>> [   23.503486] rcar_fdp1 fe940000.fdp1: Device registered as /dev/vid=
eo0
>>>>> [   23.507358] rcar-dw-hdmi fead0000.hdmi: Detected HDMI TX controlle=
r v2.01a with HDCP (DWC HDMI
>>>> 2.0 TX PHY)
>>>>> [   23.512057] Bluetooth: HCI UART protocol Marvell registered
>>>>> [   23.524699] rcar-dw-hdmi fead0000.hdmi: registered DesignWare HDMI=
 I2C bus driver
>>>>> [   23.617637] hci-ti serial0-0: Direct firmware load for ti-connecti=
vity/TIInit_11.8.32.bts
>>> failed
>>>> with error -2
>>>>> [   23.627741] Bluetooth: hci0: request_firmware failed(errno -2) for=
 ti-
>>>> connectivity/TIInit_11.8.32.bts
>>>>> [   23.637067] Bluetooth: hci0: download firmware failed, retrying...
>>>>> [  OK  ] Started Network Time Synchronization.
>>>>> [  OK  ] Started Network Name Resolution.
>>>>> [  OK  ] Reached target Bluetooth.
>>>>> [  OK  ] Reached target Network.
>>>>> [   23.777554] [drm] Initialized rcar-du 1.0.0 20130110 for feb00000.=
display on minor 0
>>>>> [  OK  ] Reached target Host and Network Name Lookups.
>>>>> [   23.792569] [drm] Device feb00000.display probed
>>>>> [   23.797897] rcar-du feb00000.display: [drm] Cannot find any crtc o=
r sizes
>>>>> [  OK  ] Reached target Syst[   23.808607] hci-ti serial0-0: Direct f=
irmware load for ti-
>>>> connectivity/TIInit_11.8.32.bts failed with error -2
>>>>> em Time Set.[   23.820293] Bluetooth: hci0: request_firmware failed(e=
rrno -2) for ti-
>>>> connectivity/TIInit_11.8.32.bts
>>>>>
>>>>> [   23.830790] Bluetooth: hci0: download firmware failed, retrying...
>>>>> [  OK  ] Reached target System Time Synchronized.
>>>>> [  OK  ] Reached target Hardware act[   23.857243] cfg80211: Loading =
compiled-in X.509
>>> certificates
>>>> for regulatory database
>>>>> ivated USB gadget.
>>>>> [  OK  ] Listening on Load/Save RF =C3=A2=E2=82=AC=C2=A6itch Status /=
dev/rfkill Watch.
>>>>> [   23.908591] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9c=
ea7'
>>>>> [   23.915404] platform regulatory.0: Direct firmware load for regula=
tory.db failed with error -2
>>>>> [   23.924155] cfg80211: failed to load regulatory.db
>>>>>          Starting Load/Save RF Kill Switch Status...
>>>>> [   24.000118] hci-ti serial0-0: Direct firmware load for ti-connecti=
vity/TIInit_11.8.32.bts
>>> failed
>>>> with error -2
>>>>> [   24.010227] Bluetooth: hci0: request_firmware failed(errno -2) for=
 ti-
>>>> connectivity/TIInit_11.8.32.bts
>>>>> [   24.019498] Bluetooth: hci0: download firmware failed, retrying...
>>>>> [  OK  ] Started Load/Save RF Kill Switch Status.
>>>>> [   24.188198] hci-ti serial0-0: Direct firmware load for ti-connecti=
vity/TIInit_11.8.32.bts
>>> failed
>>>> with error -2
>>>>> [   24.198252] Bluetooth: hci0: request_firmware failed(errno -2) for=
 ti-
>>>> connectivity/TIInit_11.8.32.bts
>>>>> [   24.207498] Bluetooth: hci0: download firmware failed, retrying...
>>>>> [   24.209068] wl18xx_driver wl18xx.3.auto: Direct firmware load for =
ti-connectivity/wl1271-
>>> nvs.bin
>>>> failed with error -2
>>>>> [   24.225615] wl18xx_driver wl18xx.3.auto: Direct firmware load for =
ti-connectivity/wl18xx-
>>> conf.bin
>>>> failed with error -2
>>>>> [   24.236423] wlcore: ERROR could not get configuration binary ti-co=
nnectivity/wl18xx-conf.bin: -
>>> 2
>>>>> [   24.245293] wlcore: WARNING falling back to default config
>>>>> [  OK  ] Started udev Wait for Complete Device Initialization.
>>>>> [  OK  ] Started Hardware RNG Entropy Gatherer Daemon.
>>>>> [  OK  ] Reached target System Initialization.
>>>>> [  OK  ] Started Daily Cleanup of Temporary Directories.
>>>>> [  OK  ] Reached target Timers.
>>>>> [  OK  ] Listening on D-Bus System Message Bus Socket.
>>>>>          Starting sshd.socket.
>>>>> [  OK  ] Listening on sshd.socket.
>>>>> [  OK  ] Reached target Sockets.
>>>>> [  OK  ] Reached target Basic System.
>>>>>          Starting Save/Restore Sound Card State...
>>>>> [  OK  ] Started Kernel Logging Service.
>>>>> [  OK  ] Started System Logging Service.
>>>>> [  OK  ] Started D-Bus System Message Bus.
>>>>>          Starting rng-tools.service...
>>>>> [   24.724566] audit: type=3D1334 audit(1675175570.446:4): prog-id=3D=
7 op=3DLOAD
>>>>> [   24.731577] audit: type=3D1334 audit(1675175570.454:5): prog-id=3D=
8 op=3DLOAD
>>>>>          Starting Login Service...
>>>>>          Starting Permit User Sessions...
>>>>> [   24.774068] wlcore: wl18xx HW: 183x or 180x, PG 2.2 (ROM 0x11)
>>>>> [  OK  ] Started VIN initializing setting.
>>>>> [   24.790478] wlcore: loaded
>>>>> [  OK  ] Started Save/Restore Sound Card State.
>>>>> [  OK  ] Started rng-tools.service.
>>>>> [  OK  ] Started Permit User Sessions.
>>>>> [  OK  ] Reached target Sound Card.
>>>>> [  OK  ] Started Getty on tty1.
>>>>> [  OK  ] Started Serial Getty on ttySC0.
>>>>> [  OK  ] Reached target Login Prompts.
>>>>> [  OK  ] Started Login Service.
>>>>> [  OK  ] Reached target Multi-User System.
>>>>>          Starting Update UTMP about System Runlevel Changes...
>>>>> [  OK  ] Started Update UTMP about System Runlevel Changes.
>>>>>
>>>>> Poky (Yocto Project Reference Distro) 3.1.14 rzg2m ttySC0
>>>>>
>>>>> BSP: RZG2M
>>>>> LSI: RZG2M
>>>>> rzg2m login: root
>>>>> root@rzg2m:~#
>>>>> root@rzg2m:~#
>>>>> root@rzg2m:~#
>>>>
>>>> I can try 6.1-cip as well - but does it mean that support for this
>>>> target is limited to up to 6.1? We declared it supported here:
>>>> https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptestin
>>>> g/cipreferencehardware
>>>
>>> It should work in 6.12 as well. I just want to make sure you get simila=
r results with 6.1.y-cip with
>>> the board that you have.
>>
>>
>> Log from 6.12:
>>
>> [    0.000000] Linux version 6.12.57-cip13 (user@runner-sdmvrzcda-projec=
t-194-concurrent-0) (aarch64-none-linux-gnu-gcc (Arm GNU Toolchain 14.2.Rel=
1 (Build arm-14.52)) 14.2.1 20241119, GNU ld (Arm GNU Toolchain 14.2.Rel1 (=
Build arm-14.52)) 2.43.1.20241119) #1 SMP PREEMPT Fri Nov 14 10:08:05 UTC 2=
025
>> [    0.000000] KASLR disabled due to lack of seed
>> [    0.000000] Machine model: HopeRun HiHope RZ/G2M with sub board
>> [    0.000000] efi: UEFI not found.
>> [    0.000000] OF: reserved mem: Reserved memory: unsupported node forma=
t, ignoring
>> [    0.000000] OF: reserved mem: Reserved memory: unsupported node forma=
t, ignoring
>> [    0.000000] NUMA: Faking a node at [mem 0x0000000048000000-0x00000006=
7fffffff]
>> [    0.000000] NODE_DATA(0) allocated [mem 0x67f7f15c0-0x67f7f3bff]
>> [    0.000000] Zone ranges:
>> [    0.000000]   DMA      [mem 0x0000000048000000-0x00000000ffffffff]
>> [    0.000000]   DMA32    empty
>> [    0.000000]   Normal   [mem 0x0000000100000000-0x000000067fffffff]
>> [    0.000000] Movable zone start for each node
>> [    0.000000] Early memory node ranges
>> [    0.000000]   node   0: [mem 0x0000000048000000-0x00000000bfffffff]
>> [    0.000000]   node   0: [mem 0x0000000600000000-0x000000067fffffff]
>> [    0.000000] Initmem setup node 0 [mem 0x0000000048000000-0x000000067f=
ffffff]
>> [    0.000000] cma: Reserved 32 MiB at 0x00000000be000000 on node -1
>> [    0.000000] psci: probing for conduit method from DT.
>> [    0.000000] psci: PSCIv1.1 detected in firmware.
>> [    0.000000] psci: Using standard PSCI v0.2 function IDs
>> [    0.000000] psci: MIGRATE_INFO_TYPE not supported.
>> [    0.000000] psci: SMC Calling Convention v1.4
>> [    0.000000] percpu: Embedded 25 pages/cpu s61784 r8192 d32424 u102400
>> [    0.000000] Detected PIPT I-cache on CPU0
>> [    0.000000] CPU features: detected: Spectre-v2
>> [    0.000000] CPU features: detected: Spectre-v3a
>> [    0.000000] CPU features: detected: Spectre-BHB
>> [    0.000000] CPU features: detected: ARM erratum 1742098
>> [    0.000000] CPU features: detected: ARM errata 1165522, 1319367, or 1=
530923
>> [    0.000000] alternatives: applying boot alternatives
>> [    0.000000] Kernel command line:  root=3D/dev/nfs rw nfsroot=3D10.226=
.35.4:/var/lib/lava/dispatcher/tmp/11950/extract-nfsrootfs-_zkvprbm,tcp,har=
d,v3  ip=3Ddhcp
>> [    0.000000] Dentry cache hash table entries: 524288 (order: 10, 41943=
04 bytes, linear)
>> [    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152=
 bytes, linear)
>> [    0.000000] Fallback order for Node 0: 0=20
>> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 10=
15808
>> [    0.000000] Policy zone: Normal
>> [    0.000000] mem auto-init: stack:all(zero), heap alloc:off, heap free=
:off
>> [    0.000000] software IO TLB: area num 8.
>> [    0.000000] software IO TLB: mapped [mem 0x00000000b6ec7000-0x0000000=
0baec7000] (64MB)
>> [    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D6=
, Nodes=3D1
>> [    0.000000] rcu: Preemptible hierarchical RCU implementation.
>> [    0.000000] rcu: 	RCU event tracing is enabled.
>> [    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=3D512 to nr_cpu_i=
ds=3D6.
>> [    0.000000] 	Trampoline variant of Tasks RCU enabled.
>> [    0.000000] 	Tracing variant of Tasks RCU enabled.
>> [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay i=
s 25 jiffies.
>> [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_=
ids=3D6
>> [    0.000000] RCU Tasks: Setting shift to 3 and lim to 1 rcu_task_cb_ad=
just=3D1 rcu_task_cpu_ids=3D6.
>> [    0.000000] RCU Tasks Trace: Setting shift to 3 and lim to 1 rcu_task=
_cb_adjust=3D1 rcu_task_cpu_ids=3D6.
>> [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
>> [    0.000000] Root IRQ handler: gic_handle_irq
>> [    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on conten=
tion.
>> [    0.000000] arch_timer: cp15 timer(s) running at 8.33MHz (virt).
>> [    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max=
_cycles: 0x1ec02923e, max_idle_ns: 440795202125 ns
>> [    0.000000] sched_clock: 56 bits at 8MHz, resolution 120ns, wraps eve=
ry 2199023255496ns
>> [    0.000212] Console: colour dummy device 80x25
>> [    0.000223] printk: legacy console [tty0] enabled
>> [    0.000512] Calibrating delay loop (skipped), value calculated using =
timer frequency.. 16.66 BogoMIPS (lpj=3D33333)
>> [    0.000531] pid_max: default: 32768 minimum: 301
>> [    0.000588] LSM: initializing lsm=3Dcapability
>> [    0.000715] Mount-cache hash table entries: 8192 (order: 4, 65536 byt=
es, linear)
>> [    0.000743] Mountpoint-cache hash table entries: 8192 (order: 4, 6553=
6 bytes, linear)
>> [    0.002810] rcu: Hierarchical SRCU implementation.
>> [    0.002838] rcu: 	Max phase no-delay instances is 1000.
>> [    0.003025] Timer migration: 1 hierarchy levels; 8 children per group=
; 1 crossnode level
>> [    0.004480] Detected Renesas RZ/G2 r8a774a1 ES3.0
>> [    0.005701] EFI services will not be available.
>> [    0.006021] smp: Bringing up secondary CPUs ...
>> [    0.006534] Detected PIPT I-cache on CPU1
>> [    0.006633] CPU1: Booted secondary processor 0x0000000001 [0x411fd073=
]
>> [    0.007289] CPU features: detected: ARM erratum 845719
>> [    0.007310] Detected VIPT I-cache on CPU2
>> [    0.007414] CPU2: Booted secondary processor 0x0000000100 [0x410fd034=
]
>> [    0.008001] Detected VIPT I-cache on CPU3
>> [    0.008057] CPU3: Booted secondary processor 0x0000000101 [0x410fd034=
]
>> [    0.008633] Detected VIPT I-cache on CPU4
>> [    0.008689] CPU4: Booted secondary processor 0x0000000102 [0x410fd034=
]
>> [    0.009203] Detected VIPT I-cache on CPU5
>> [    0.009260] CPU5: Booted secondary processor 0x0000000103 [0x410fd034=
]
>> [    0.009396] smp: Brought up 1 node, 6 CPUs
>> [    0.009455] SMP: Total of 6 processors activated.
>> [    0.009462] CPU: All CPU(s) started at EL1
>> [    0.009487] CPU features: detected: 32-bit EL0 Support
>> [    0.009494] CPU features: detected: 32-bit EL1 Support
>> [    0.009502] CPU features: detected: CRC32 instructions
>> [    0.009552] alternatives: applying system-wide alternatives
>> [    0.011192] Memory: 3841224K/4063232K available (17664K kernel code, =
4904K rwdata, 11924K rodata, 2880K init, 743K bss, 183336K reserved, 32768K=
 cma-reserved)
>> [    0.012007] devtmpfs: initialized
>> [    0.017949] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffff=
ffff, max_idle_ns: 7645041785100000 ns
>> [    0.017988] futex hash table entries: 2048 (order: 5, 131072 bytes, l=
inear)
>> [    0.018698] 23168 pages in range for non-PLT usage
>> [    0.018706] 514688 pages in range for PLT usage
>> [    0.018883] pinctrl core: initialized pinctrl subsystem
>> [    0.020732] DMI not present or invalid.
>> [    0.022836] NET: Registered PF_NETLINK/PF_ROUTE protocol family
>> [    0.023489] DMA: preallocated 512 KiB GFP_KERNEL pool for atomic allo=
cations
>> [    0.023624] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA pool for ato=
mic allocations
>> [    0.023774] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA32 pool for a=
tomic allocations
>> [    0.023827] audit: initializing netlink subsys (disabled)
>> [    0.023956] audit: type=3D2000 audit(0.020:1): state=3Dinitialized au=
dit_enabled=3D0 res=3D1
>> [    0.025280] thermal_sys: Registered thermal governor 'step_wise'
>> [    0.025286] thermal_sys: Registered thermal governor 'power_allocator=
'
>> [    0.025356] cpuidle: using governor menu
>> [    0.025505] hw-breakpoint: found 6 breakpoint and 4 watchpoint regist=
ers.
>> [    0.025626] ASID allocator initialised with 65536 entries
>> [    0.027292] Serial: AMBA PL011 UART driver
>> [    0.033541] /soc/sound@ec500000: Fixed dependency cycle(s) with /soc/=
hdmi@fead0000
>> [    0.033801] /soc/interrupt-controller@f1010000: Fixed dependency cycl=
e(s) with /soc/interrupt-controller@f1010000
>> [    0.033888] /soc/hdmi@fead0000: Fixed dependency cycle(s) with /soc/s=
ound@ec500000
>> [    0.033909] /soc/hdmi@fead0000: Fixed dependency cycle(s) with /soc/d=
isplay@feb00000
>> [    0.033943] /soc/display@feb00000: Fixed dependency cycle(s) with /so=
c/hdmi@fead0000
>> [    0.036213] /soc/pinctrl@e6060000: Fixed dependency cycle(s) with /so=
c/pinctrl@e6060000/scif_clk
>> [    0.036611] sh-pfc e6060000.pinctrl: r8a774a1_pfc support registered
>> [    0.043821] /soc/sound@ec500000: Fixed dependency cycle(s) with /soc/=
hdmi@fead0000
>> [    0.050491] /soc/sound@ec500000: Fixed dependency cycle(s) with /soc/=
hdmi@fead0000
>> [    0.050551] /soc/hdmi@fead0000: Fixed dependency cycle(s) with /soc/s=
ound@ec500000
>> [    0.050599] /soc/hdmi@fead0000: Fixed dependency cycle(s) with /soc/d=
isplay@feb00000
>> [    0.050897] /soc/hdmi@fead0000: Fixed dependency cycle(s) with /soc/d=
isplay@feb00000
>> [    0.050947] /soc/display@feb00000: Fixed dependency cycle(s) with /so=
c/hdmi@fead0000
>> [    0.051704] /soc/hdmi@fead0000: Fixed dependency cycle(s) with /hdmi0=
-out
>> [    0.051763] /hdmi0-out: Fixed dependency cycle(s) with /soc/hdmi@fead=
0000
>> [    0.054283] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 p=
ages
>> [    0.054298] HugeTLB: 0 KiB vmemmap can be freed for a 1.00 GiB page
>> [    0.054307] HugeTLB: registered 32.0 MiB page size, pre-allocated 0 p=
ages
>> [    0.054314] HugeTLB: 0 KiB vmemmap can be freed for a 32.0 MiB page
>> [    0.054323] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 p=
ages
>> [    0.054330] HugeTLB: 0 KiB vmemmap can be freed for a 2.00 MiB page
>> [    0.054338] HugeTLB: registered 64.0 KiB page size, pre-allocated 0 p=
ages
>> [    0.054344] HugeTLB: 0 KiB vmemmap can be freed for a 64.0 KiB page
>> [    0.055940] ACPI: Interpreter disabled.
>> [    0.060698] iommu: Default domain type: Translated
>> [    0.060721] iommu: DMA domain TLB invalidation policy: strict mode
>> [    0.061124] SCSI subsystem initialized
>> [    0.061398] usbcore: registered new interface driver usbfs
>> [    0.061430] usbcore: registered new interface driver hub
>> [    0.061457] usbcore: registered new device driver usb
>> [    0.062409] pps_core: LinuxPPS API ver. 1 registered
>> [    0.062420] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodol=
fo Giometti <giometti@linux.it>
>> [    0.062435] PTP clock support registered
>> [    0.062534] EDAC MC: Ver: 3.0.0
>> [    0.063056] scmi_core: SCMI protocol bus registered
>> [    0.063944] FPGA manager framework
>> [    0.064017] Advanced Linux Sound Architecture Driver Initialized.
>> [    0.064905] vgaarb: loaded
>> [    0.065247] clocksource: Switched to clocksource arch_sys_counter
>> [    0.065486] VFS: Disk quotas dquot_6.6.0
>> [    0.065514] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 b=
ytes)
>> [    0.065812] pnp: PnP ACPI: disabled
>> [    0.071447] NET: Registered PF_INET protocol family
>> [    0.071653] IP idents hash table entries: 65536 (order: 7, 524288 byt=
es, linear)
>> [    0.073570] tcp_listen_portaddr_hash hash table entries: 2048 (order:=
 3, 32768 bytes, linear)
>> [    0.073650] Table-perturb hash table entries: 65536 (order: 6, 262144=
 bytes, linear)
>> [    0.073670] TCP established hash table entries: 32768 (order: 6, 2621=
44 bytes, linear)
>> [    0.073826] TCP bind hash table entries: 32768 (order: 8, 1048576 byt=
es, linear)
>> [    0.074392] TCP: Hash tables configured (established 32768 bind 32768=
)
>> [    0.074504] UDP hash table entries: 2048 (order: 4, 65536 bytes, line=
ar)
>> [    0.074579] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes,=
 linear)
>> [    0.074760] NET: Registered PF_UNIX/PF_LOCAL protocol family
>> [    0.075103] RPC: Registered named UNIX socket transport module.
>> [    0.075123] RPC: Registered udp transport module.
>> [    0.075129] RPC: Registered tcp transport module.
>> [    0.075135] RPC: Registered tcp-with-tls transport module.
>> [    0.075141] RPC: Registered tcp NFSv4.1 backchannel transport module.
>> [    0.075160] PCI: CLS 0 bytes, default 64
>> [    0.075513] kvm [1]: HYP mode not available
>> [    0.076456] Initialise system trusted keyrings
>> [    0.076683] workingset: timestamp_bits=3D42 max_order=3D20 bucket_ord=
er=3D0
>> [    0.076932] squashfs: version 4.0 (2009/01/31) Phillip Lougher
>> [    0.077147] NFS: Registering the id_resolver key type
>> [    0.077180] Key type id_resolver registered
>> [    0.077187] Key type id_legacy registered
>> [    0.077208] nfs4filelayout_init: NFSv4 File Layout Driver Registering=
...
>> [    0.077217] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Reg=
istering...
>> [    0.077371] 9p: Installing v9fs 9p2000 file system support
>> [    0.111329] Key type asymmetric registered
>> [    0.111347] Asymmetric key parser 'x509' registered
>> [    0.111404] Block layer SCSI generic (bsg) driver version 0.4 loaded =
(major 245)
>> [    0.111417] io scheduler mq-deadline registered
>> [    0.111424] io scheduler kyber registered
>> [    0.111460] io scheduler bfq registered
>> [    0.123005] gpio_rcar e6050000.gpio: driving 16 GPIOs
>> [    0.123384] gpio_rcar e6051000.gpio: driving 29 GPIOs
>> [    0.123696] gpio_rcar e6052000.gpio: driving 15 GPIOs
>> [    0.123989] gpio_rcar e6053000.gpio: driving 16 GPIOs
>> [    0.124280] gpio_rcar e6054000.gpio: driving 18 GPIOs
>> [    0.124551] gpio_rcar e6055000.gpio: driving 26 GPIOs
>> [    0.124854] gpio_rcar e6055400.gpio: driving 32 GPIOs
>> [    0.125143] gpio_rcar e6055800.gpio: driving 4 GPIOs
>> [    0.127451] ledtrig-cpu: registered to indicate activity on CPUs
>> [    0.128142] rcar-pcie fe000000.pcie: host bridge /soc/pcie@fe000000 r=
anges:
>> [    0.128187] rcar-pcie fe000000.pcie:       IO 0x00fe100000..0x00fe1ff=
fff -> 0x0000000000
>> [    0.128214] rcar-pcie fe000000.pcie:      MEM 0x00fe200000..0x00fe3ff=
fff -> 0x00fe200000
>> [    0.128234] rcar-pcie fe000000.pcie:      MEM 0x0030000000..0x0037fff=
fff -> 0x0030000000
>> [    0.128249] rcar-pcie fe000000.pcie:      MEM 0x0038000000..0x003ffff=
fff -> 0x0038000000
>> [    0.128267] rcar-pcie fe000000.pcie:   IB MEM 0x0000000000..0x00fffff=
fff -> 0x0000000000
>> [    0.180189] rcar-pcie fe000000.pcie: PCIe link down
>> [    0.180372] rcar-pcie ee800000.pcie: host bridge /soc/pcie@ee800000 r=
anges:
>> [    0.180404] rcar-pcie ee800000.pcie:       IO 0x00ee900000..0x00ee9ff=
fff -> 0x0000000000
>> [    0.180426] rcar-pcie ee800000.pcie:      MEM 0x00eea00000..0x00eebff=
fff -> 0x00eea00000
>> [    0.180444] rcar-pcie ee800000.pcie:      MEM 0x00c0000000..0x00c7fff=
fff -> 0x00c0000000
>> [    0.180459] rcar-pcie ee800000.pcie:      MEM 0x00c8000000..0x00cffff=
fff -> 0x00c8000000
>> [    0.180476] rcar-pcie ee800000.pcie:   IB MEM 0x0000000000..0x00fffff=
fff -> 0x0000000000
>> [    0.232291] rcar-pcie ee800000.pcie: PCIe link down
>> [    0.259541] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
>> [    0.262929] msm_serial: driver initialized
>> [    0.263262] SuperH (H)SCI(F) driver initialized
>> [    0.263934] e6540000.serial: ttySC1 at MMIO 0xe6540000 (irq =3D 22, b=
ase_baud =3D 0) is a hscif
>> [    0.264136] serial serial0: tty port ttySC1 registered
>> [    0.264791] e6e88000.serial: ttySC0 at MMIO 0xe6e88000 (irq =3D 23, b=
ase_baud =3D 0) is a scif
>> [    0.264864] printk: legacy console [ttySC0] enabled
>> [    1.555087] STM32 USART driver initialized
>> [    1.566514] loop: module loaded
>> [    1.570891] megasas: 07.727.03.00-rc1
>> [    1.580524] tun: Universal TUN/TAP device driver, 1.6
>> [    1.586578] thunder_xcv, ver 1.0
>> [    1.589862] thunder_bgx, ver 1.0
>> [    1.593113] nicpf, ver 1.0
>> [    1.596924] hns3: Hisilicon Ethernet Network Driver for Hip08 Family =
- version
>> [    1.604161] hns3: Copyright (c) 2017 Huawei Corporation.
>> [    1.609507] hclge is initializing
>> [    1.612855] e1000: Intel(R) PRO/1000 Network Driver
>> [    1.617743] e1000: Copyright (c) 1999-2006 Intel Corporation.
>> [    1.623519] e1000e: Intel(R) PRO/1000 Network Driver
>> [    1.628488] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
>> [    1.634432] igb: Intel(R) Gigabit Ethernet Network Driver
>> [    1.639835] igb: Copyright (c) 2007-2014 Intel Corporation.
>> [    1.645436] igbvf: Intel(R) Gigabit Virtual Function Network Driver
>> [    1.651707] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
>> [    1.657959] sky2: driver version 1.30
>> [    1.663442] VFIO - User Level meta-driver version: 0.3
>> [    1.670722] ehci-platform ee0a0100.usb: EHCI Host Controller
>> [    1.671292] ohci-platform ee0a0000.usb: Generic Platform OHCI control=
ler
>> [    1.671652] xhci-renesas-hcd ee000000.usb: xHCI Host Controller
>> [    1.671671] xhci-renesas-hcd ee000000.usb: new USB bus registered, as=
signed bus number 1
>> [    1.671731] xhci-renesas-hcd ee000000.usb: Direct firmware load for r=
8a779x_usb3_v3.dlmem failed with error -2
>> [    1.671741] xhci-renesas-hcd ee000000.usb: can't setup: -2
>> [    1.671749] xhci-renesas-hcd ee000000.usb: USB bus 1 deregistered
>> [    1.671795] xhci-renesas-hcd ee000000.usb: probe with driver xhci-ren=
esas-hcd failed with error -2
>> [    1.672265] usbcore: registered new interface driver usb-storage
>> [    1.675027] i2c_dev: i2c /dev entries driver
>> [    1.676415] ehci-platform ee0a0100.usb: new USB bus registered, assig=
ned bus number 1
>> [    1.677217] cs2000-cp 2-004f: operating in static mode
>> [    1.683137] ohci-platform ee0a0000.usb: new USB bus registered, assig=
ned bus number 2
>> [    1.689157] ehci-platform ee0a0100.usb: irq 24, io mem 0xee0a0100
>> [    1.697283] ohci-platform ee0a0000.usb: irq 24, io mem 0xee0a0000
>> [    1.714784] cs2000-cp 2-004f: revision - C1
>> [    1.721258] ehci-platform ee0a0100.usb: USB 2.0 started, EHCI 1.10
>> [    1.727770] i2c-rcar e6510000.i2c: probed
>> [    1.734151] hub 1-0:1.0: USB hub found
>> [    1.789248] hub 1-0:1.0: 1 port detected
>> [    1.792138] i2c-rcar e66d8000.i2c: probed
>> [    1.799702] rcar_gen3_thermal e6198000.thermal: No calibration values=
 fused, fallback to driver values
>> [    1.807958] hub 2-0:1.0: USB hub found
>> [    1.812811] hub 2-0:1.0: 1 port detected
>> [    1.813487] rcar_gen3_thermal e6198000.thermal: Sensor 0: Loaded
>> [    1.826965] rcar_gen3_thermal e6198000.thermal: Sensor 1: Loaded
>> [    1.837160] rcar_gen3_thermal e6198000.thermal: Sensor 2: Loaded
>> [    1.847117] cpufreq: cpufreq_online: CPU0: Running at unlisted initia=
l frequency: 1499999 KHz, changing to: 1500000 KHz
>> [    1.858046] cpu cpu0: EM: created perf domain
>> [    1.863447] cpufreq: cpufreq_online: CPU2: Running at unlisted initia=
l frequency: 1199999 KHz, changing to: 1200000 KHz
>> [    1.874361] cpu cpu2: EM: created perf domain
>> [    1.881203] sdhci: Secure Digital Host Controller Interface driver
>> [    1.887420] sdhci: Copyright(c) Pierre Ossman
>> [    1.892698] Synopsys Designware Multimedia Card Interface Driver
>> [    1.899627] sdhci-pltfm: SDHCI platform and OF driver helper
>> [    1.907553] SMCCC: SOC_ID: ARCH_SOC_ID not implemented, skipping ....
>> [    1.914995] usbcore: registered new interface driver usbhid
>> [    1.920583] usbhid: USB HID core driver
>> [    1.927648] hw perfevents: enabled with armv8_cortex_a53 PMU driver, =
7 (0,8000003f) counters available
>> [    1.937583] hw perfevents: enabled with armv8_cortex_a57 PMU driver, =
7 (0,8000003f) counters available
>> [    1.953046] NET: Registered PF_PACKET protocol family
>> [    1.958212] 9pnet: Installing 9P2000 support
>> [    1.962549] Key type dns_resolver registered
>> [    1.973580] registered taskstats version 1
>> [    1.977879] Loading compiled-in X.509 certificates
>> [    1.987935] Demotion targets for Node 0: null
>> [    2.001560] renesas_irqc e61c0000.interrupt-controller: driving 6 irq=
s
>> [    2.041290] usb 1-1: new high-speed USB device number 2 using ehci-pl=
atform
>> [    2.046664] ohci-platform ee080000.usb: Generic Platform OHCI control=
ler
>> [    2.046706] ehci-platform ee080100.usb: EHCI Host Controller
>> [    2.046750] ehci-platform ee080100.usb: new USB bus registered, assig=
ned bus number 3
>> [    2.046917] ehci-platform ee080100.usb: irq 42, io mem 0xee080100
>> [    2.061286] ehci-platform ee080100.usb: USB 2.0 started, EHCI 1.10
>> [    2.068569] ohci-platform ee080000.usb: new USB bus registered, assig=
ned bus number 4
>> [    2.075401] hub 3-0:1.0: USB hub found
>> [    2.080906] ohci-platform ee080000.usb: irq 42, io mem 0xee080000
>> [    2.088699] hub 3-0:1.0: 1 port detected
>> [    2.175898] hub 4-0:1.0: USB hub found
>> [    2.179697] hub 4-0:1.0: 1 port detected
>> [    2.206708] hub 1-1:1.0: USB hub found
>> [    2.208817] Trying to probe devices needed for running init ...
>> [    2.210556] hub 1-1:1.0: 2 ports detected
>> [   12.255412] rcar-dmac e7310000.dma-controller: deferred probe timeout=
, ignoring dependency
>> [   12.270296] rcar-dmac ec700000.dma-controller: deferred probe timeout=
, ignoring dependency
>> [   12.285155] rcar-dmac ec720000.dma-controller: deferred probe timeout=
, ignoring dependency
>> [   12.301454] ravb e6800000.ethernet: deferred probe timeout, ignoring =
dependency
>> [   12.312377] ravb e6800000.ethernet eth0: Base address at 0xe6800000, =
2e:09:00:01:01:02, IRQ 91.
>> [   12.329128] renesas_sdhi_internal_dmac ee140000.mmc: deferred probe t=
imeout, ignoring dependency
>> [   12.338042] rcar-dmac e6700000.dma-controller: deferred probe timeout=
, ignoring dependency
>> [   12.346358] renesas_sdhi_internal_dmac ee100000.mmc: deferred probe t=
imeout, ignoring dependency
>> [   12.355228] rcar-dmac e7300000.dma-controller: deferred probe timeout=
, ignoring dependency
>> [   12.355610] renesas_sdhi_internal_dmac ee100000.mmc: Got CD GPIO
>> [   12.363511] renesas_sdhi_internal_dmac ee160000.mmc: deferred probe t=
imeout, ignoring dependency
>> [   12.411894] renesas_sdhi_internal_dmac ee160000.mmc: mmc0 base at 0x0=
0000000ee160000, max clock rate 200 MHz
>> [   12.426930] renesas_sdhi_internal_dmac ee100000.mmc: mmc1 base at 0x0=
0000000ee100000, max clock rate 200 MHz
>> [   12.465913] renesas_sdhi_internal_dmac ee140000.mmc: mmc2 base at 0x0=
0000000ee140000, max clock rate 200 MHz
>> [   12.486534] renesas_sdhi_internal_dmac ee140000.mmc: card claims to s=
upport voltages below defined range
>> [   12.492301] RTL8211E Gigabit Ethernet e6800000.ethernet-ffffffff:00: =
attached PHY driver (mii_bus:phy_addr=3De6800000.ethernet-ffffffff:00, irq=
=3D97)
>> [   12.510345] mmc2: new high speed SDIO card at address 0001
>> [   12.513340] mmc0: new HS200 MMC card at address 0001
>> [   12.521530] mmcblk0: mmc0:0001 S0J57X 29.6 GiB
>> [   12.527601]  mmcblk0: p1
>> [   12.530603] mmcblk0boot0: mmc0:0001 S0J57X 31.5 MiB
>> [   12.536557] mmcblk0boot1: mmc0:0001 S0J57X 31.5 MiB
>> [   12.542508] mmcblk0rpmb: mmc0:0001 S0J57X 4.00 MiB, chardev (234:0)
>> [   12.693396] mmc1: new ultra high speed SDR104 SDXC card at address aa=
aa
>> [   12.700807] mmcblk1: mmc1:aaaa SN64G 59.5 GiB
>> [   12.707625]  mmcblk1: p1
>> [   15.798075] ravb e6800000.ethernet eth0: Link is Up - 1Gbps/Full - fl=
ow control off
>> [   15.821297] Sending DHCP requests .., OK
>> [   18.673234] IP-Config: Got DHCP answer from 10.226.35.254, my address=
 is 10.226.35.26
>> [   18.681116] IP-Config: Complete:
>> [   18.684355]      device=3Deth0, hwaddr=3D2e:09:00:01:01:02, ipaddr=3D=
10.226.35.26, mask=3D255.255.255.0, gw=3D10.226.35.254
>> [   18.694649]      host=3D10.226.35.26, domain=3Dadwin.renesas.com, nis=
-domain=3D(none)
>> [   18.701978]      bootserver=3D0.0.0.0, rootserver=3D10.226.35.4, root=
path=3D
>> [   18.701985]      nameserver0=3D10.226.36.10, nameserver1=3D10.226.104=
.200
>> [   18.714990]      ntpserver0=3D10.226.36.10, ntpserver1=3D10.226.104.2=
00
>> [   18.721613] clk: Disabling unused clocks
>> [   18.726116] PM: genpd: Disabling unused power domains
>> [   18.731257] ALSA device list:
>> [   18.734385]   No soundcards found.
>> [   18.758751] VFS: Mounted root (nfs filesystem) on device 0:22.
>> [   18.765003] devtmpfs: mounted
>> [   18.769171] Freeing unused kernel memory: 2880K
>> [   18.773808] Run /sbin/init as init process
>> [   19.050109] systemd[1]: System time before build time, advancing cloc=
k.
>> [   19.196399] NET: Registered PF_INET6 protocol family
>> [   19.202881] Segment Routing with IPv6
>> [   19.206648] In-situ OAM (IOAM) with IPv6
>> [   19.269634] systemd[1]: systemd 255.21^ running in system mode (-PAM =
-AUDIT -SELINUX -APPARMOR +IMA -SMACK +SECCOMP -GCRYPT -GNUTLS -OPENSSL +AC=
L +BLKID -CURL -ELFUTILS -FIDO2 -IDN2 -IDN -IPTC +KMOD -LIBCRYPTSETUP +LIBF=
DISK -PCRE2 -PWQUALITY -P11KIT -QRENCODE -TPM2 -BZIP2 -LZ4 -XZ -ZLIB +ZSTD =
-BPF_FRAMEWORK +XKBCOMMON +UTMP +SYSVINIT default-hierarchy=3Dunified)
>> [   19.301677] systemd[1]: Detected architecture arm64.
>> Welcome to [1mPoky (Yocto Project Reference Distro) 5.0.11 (scarthgap)[0=
m!
>> [   19.329785] systemd[1]: Hostname set to <hihope-rzg2m>.
>> [   19.340417] systemd[1]: Initializing machine ID from random generator=
.
>> [   19.633282] random: crng init done
>> [   20.099102] systemd[1]: Queued start job for default target Multi-Use=
r System.
>> [   20.170270] systemd[1]: Created slice Slice /system/getty.
>> [[0;32m  OK  [0m] Created slice [0;1;39mSlice /system/getty[0m.
>> [   20.191718] systemd[1]: Created slice Slice /system/modprobe.
>> [[0;32m  OK  [0m] Created slice [0;1;39mSlice /system/modprobe[0m.
>> [   20.211687] systemd[1]: Created slice Slice /system/serial-getty.
>> [[0;32m  OK  [0m] Created slice [0;1;39mSlice /system/serial-getty[0m.
>> [   20.231032] systemd[1]: Created slice User and Session Slice.
>> [[0;32m  OK  [0m] Created slice [0;1;39mUser and Session Slice[0m.
>> [   20.249889] systemd[1]: Started Dispatch Password Requests to Console=
 Directory Watch.
>> [[0;32m  OK  [0m] Started [0;1;39mDispatch Password Requests to Console =
Directory Watch[0m.
>> [   20.273712] systemd[1]: Started Forward Password Requests to Wall Dir=
ectory Watch.
>> [[0;32m  OK  [0m] Started [0;1;39mForward Password Requests to Wall Dire=
ctory Watch[0m.
>> [   20.293656] systemd[1]: Reached target Host and Network Name Lookups.
>> [[0;32m  OK  [0m] Reached target [0;1;39mHost and Network Name Lookups[0=
m.
>> [   20.313391] systemd[1]: Reached target Path Units.
>> [[0;32m  OK  [0m] Reached target [0;1;39mPath Units[0m.
>> [   20.329416] systemd[1]: Reached target Remote File Systems.
>> [[0;32m  OK  [0m] Reached target [0;1;39mRemote File Systems[0m.
>> [   20.345387] systemd[1]: Reached target Slice Units.
>> [[0;32m  OK  [0m] Reached target [0;1;39mSlice Units[0m.
>> [   20.361408] systemd[1]: Reached target Swaps.
>> [[0;32m  OK  [0m] Reached target [0;1;39mSwaps[0m.
>> [   20.433440] systemd[1]: Listening on RPCbind Server Activation Socket=
.
>> [[0;32m  OK  [0m] Listening on [0;1;39mRPCbind Server Activation Socket[=
0m.
>> [   20.453661] systemd[1]: Reached target RPC Port Mapper.
>> [[0;32m  OK  [0m] Reached target [0;1;39mRPC Port Mapper[0m.
>> [   20.472294] systemd[1]: Listening on Syslog Socket.
>> [[0;32m  OK  [0m] Listening on [0;1;39mSyslog Socket[0m.
>> [   20.490149] systemd[1]: Listening on initctl Compatibility Named Pipe=
.
>> [[0;32m  OK  [0m] Listening on [0;1;39minitctl Compatibility Named Pipe[=
0m.
>> [   20.511569] systemd[1]: Listening on Journal Audit Socket.
>> [[0;32m  OK  [0m] Listening on [0;1;39mJournal Audit Socket[0m.
>> [   20.530333] systemd[1]: Listening on Journal Socket (/dev/log).
>> [[0;32m  OK  [0m] Listening on [0;1;39mJournal Socket (/dev/log)[0m.
>> [   20.550462] systemd[1]: Listening on Journal Socket.
>> [[0;32m  OK  [0m] Listening on [0;1;39mJournal Socket[0m.
>> [   20.567292] systemd[1]: Listening on Network Service Netlink Socket.
>> [[0;32m  OK  [0m] Listening on [0;1;39mNetwork Service Netlink Socket[0m=
.
>> [   20.588216] systemd[1]: Listening on udev Control Socket.
>> [[0;32m  OK  [0m] Listening on [0;1;39mudev Control Socket[0m.
>> [   20.606311] systemd[1]: Listening on udev Kernel Socket.
>> [[0;32m  OK  [0m] Listening on [0;1;39mudev Kernel Socket[0m.
>> [   20.622858] systemd[1]: Listening on User Database Manager Socket.
>> [[0;32m  OK  [0m] Listening on [0;1;39mUser Database Manager Socket[0m.
>> [   20.673935] systemd[1]: Mounting Huge Pages File System...
>>          Mounting [0;1;39mHuge Pages File System[0m...
>> [   20.686309] systemd[1]: Mounting POSIX Message Queue File System...
>>          Mounting [0;1;39mPOSIX Message Queue File System[0m...
>> [   20.711844] systemd[1]: Mounting Kernel Debug File System...
>>          Mounting [0;1;[   20.718583] systemd[1]: Kernel Trace File Syst=
em was skipped because of an unmet condition check (ConditionPathExists=3D/=
sys/kernel/tracing).
>> 39mKernel Debug File System[0m...
>> [   20.740767] systemd[1]: Mounting Temporary Directory /tmp...
>>          Mounting [0;1;39mTemporary Directory /tmp[0m...
>> [   20.757804] systemd[1]: Starting Create List of Static Device Nodes..=
.
>>          Starting [0;1;39mCreate List of Static Device Nodes[0m...
>> [   20.783941] systemd[1]: Starting Load Kernel Module configfs...
>>          Starting [0;1;39mLoad Kernel Module configfs[0m...
>> [   20.807786] systemd[1]: Starting Load Kernel Module drm...
>>          Starting [0;1;39mLoad Kernel Module drm[0m...
>> [   20.832697] systemd[1]: Starting Load Kernel Module fuse...
>>          Starting [0;1;39mLoad Kernel Module fuse[0m...
>> [   20.847083] systemd[1]: Starting Start psplash boot splash screen...
>>          Starting [0;1;39mStart psplash boot splash screen[0m...
>> [   20.882353] systemd[1]: Starting RPC Bind...
>>          Starting [0;1;39mRPC Bind[0m...
>> [   20.901102] systemd[1]: File System Check on Root Device was skipped =
because of an unmet condition check (ConditionPathIsReadWrite=3D!/).
>> [   20.950041] systemd[1]: Starting Journal Service...
>>          Starting [0;1;39mJournal Service[0m...
>> [   21.000927] systemd[1]: Load Kernel Modules was skipped because no tr=
igger condition checks were met.
>> [   21.016510] fuse: init (API version 7.41)
>> [   21.022903] systemd[1]: Starting Generate network units from Kernel c=
ommand line...
>>          Starting [0;1;39mGenerate network units from Kernel command lin=
e[0m...
>> [   21.082147] systemd[1]: Starting Remount Root and Kernel File Systems=
...
>>          Starting [0;1;39mRemount Root and Kernel File Systems[0m...
>> [   21.095990] systemd[1]: Starting Apply Kernel Variables...
>>          Starting [0;1;39mApply Kernel Variables[0m...
>> [   21.126863] systemd[1]: Starting Coldplug All udev Devices...
>>          Starting [0;1;39mColdplug All udev Devices[0m...
>> [   21.153481] systemd[1]: Started RPC Bind.
>> [[0;32m  OK  [0m] Started [0;1;39mRPC Bind[0m.
>> [   21.171817] systemd[1]: Mounted Huge Pages File System.
>> [[0;32m  OK  [0m] Mounted [0;1;39mHuge Pages File System[0m.[   21.18218=
8] systemd-journald[225]: Collecting audit messages is enabled.
>> [   21.200007] systemd[1]: Mounted POSIX Message Queue File System.
>> [[0;32m  OK  [0m] Mounted [0;1;39mPOSIX Message Queue File System[0m.
>> [   21.218407] systemd[1]: Mounted Kernel Debug File System.
>> [[0;32m  OK  [0m] Mounted [0;1;39mKernel Debug File System[0m.
>> [   21.234455] systemd[1]: Mounted Temporary Directory /tmp.
>> [[0;32m  OK  [0m] Mounted [0;1;39mTemporary Directory /tmp[0m.
>> [   21.254382] systemd[1]: Started Journal Service.
>> [[0;32m  OK  [0m] Started [0;1;39mJournal Service[0m.
>> [[0;32m  OK  [0m] Finished [0;1;39mCreate List of Static Device Nodes[0m=
.
>> [[0;32m  OK  [0m] Finished [0;1;39mLoad Kernel Module configfs[0m.
>> [[0;32m  OK  [0m] Finished [0;1;39mLoad Kernel Module drm[0m.
>> [[0;32m  OK  [0m] Finished [0;1;39mLoad Kernel Module fuse[0m.
>> [[0;1;31mFAILED[0m] Failed to start [0;1;39mStart psplash boot splash sc=
reen[0m.
>> See 'systemctl status psplash-start.service' for details.
>> [[0;1;38;5;185mDEPEND[0m] Dependency failed for [0;1;39mStart psplas=E2=
=80=A6temd progress communication helper[0m.
>> [[0;32m  OK  [0m] Finished [0;1;39mGenerate network units from Kernel co=
mmand line[0m.
>> [[0;32m  OK  [0m] Finished [0;1;39mRemount Root and Kernel File Systems[=
0m.
>> [[0;32m  OK  [0m] Finished [0;1;39mApply Kernel Variables[0m.
>>          Mounting [0;1;39mFUSE Control File System[0m...
>>          Mounting [0;1;39mKernel Configuration File System[0m...
>>          Starting [0;1;39mFlush Journal to Persistent Storage[0m...
>>          Starting [0;1;39mCreate Static Device Nodes in /dev gracefully[=
0m...
>> [[0;32m  OK  [0m] Mounted [0;1;39mFUSE Control File System[0m.
>> [[0;32m  OK  [0m] Mounted [0;1;39mKernel Configuration File System[0m.
>> [   21.621103] systemd-journald[225]: Received client request to flush r=
untime journal.
>> [[0;32m  OK  [0m] Finished [0;1;39mFlush Journal to Persistent Storage[0=
m.
>> [[0;32m  OK  [0m] Finished [0;1;39mCreate Static Device Nodes in /dev gr=
acefully[0m.
>>          Starting [0;1;39mCreate System Users[0m...
>> [   21.839024] audit: type=3D1334 audit(1748544504.783:2): prog-id=3D6 o=
p=3DLOAD
>> [   21.845781] audit: type=3D1334 audit(1748544504.791:3): prog-id=3D7 o=
p=3DLOAD
>> [   21.852531] audit: type=3D1334 audit(1748544504.795:4): prog-id=3D8 o=
p=3DLOAD
>>          Starting [0;1;39mUser Database Manager[0m...
>> [[0;32m  OK  [0m] Finished [0;1;39mColdplug All udev Devices[0m.
>> [[0;32m  OK  [0m] Started [0;1;39mUser Database Manager[0m.
>> [[0;32m  OK  [0m] Finished [0;1;39mCreate System Users[0m.
>>          Starting [0;1;39mCreate Static Device Nodes in /dev[0m...
>> [[0;32m  OK  [0m] Finished [0;1;39mCreate Static Device Nodes in /dev[0m=
.
>> [[0;32m  OK  [0m] Reached target [0;1;39mPreparation for Local File Syst=
ems[0m.
>>          Mounting [0;1;39m/var/volatile[0m...
>> [   22.228187] audit: type=3D1334 audit(1748544505.171:5): prog-id=3D9 o=
p=3DLOAD
>> [   22.234971] audit: type=3D1334 audit(1748544505.179:6): prog-id=3D10 =
op=3DLOAD
>>          Starting [0;1;39mRule-based Manager for Device Events and Files=
[0m...
>> [[0;32m  OK  [0m] Mounted [0;1;39m/var/volatile[0m.
>>          Starting [0;1;39mLoad/Save OS Random Seed[0m...
>> [[0;32m  OK  [0m] Reached target [0;1;39mLocal File Systems[0m.
>>          Starting [0;1;39mRebuild Dynamic Linker Cache[0m...
>>          Starting [0;1;39mCreate System Files and Directories[0m...
>> [[0;32m  OK  [0m] Finished [0;1;39mLoad/Save OS Random Seed[0m.
>> [[0;32m  OK  [0m] Started [0;1;39mRule-based Manager for Device Events a=
nd Files[0m.
>> [   22.760883] ravb e6800000.ethernet end0: renamed from eth0 (while UP)
>> [[0;32m  OK  [0m] Finished [0;1;39mCreate System Files and Directories[0=
m.
>>          Starting [0;1;39mRebuild Journal Catalog[0m...
>> [   23.038406] audit: type=3D1334 audit(1748544505.983:7): prog-id=3D11 =
op=3DLOAD
>>          Starting [0;1;39mNetwork Time Synchronization[0m...
>>          Starting [0;1;39mRecord System Boot/Shutdown in UTMP[0m...
>> [[0;32m  OK  [0m] Finished [0;1;39mRecord System Boot/Shutdown in UTMP[0=
m.
>> [[0;32m  OK  [0m] Finished [0;1;39mRebuild Journal Catalog[0m.
>> [[0;32m  OK  [0m] Started [0;1;39mNetwork Time Synchronization[0m.
>> [[0;32m  OK  [0m] Reached target [0;1;39mSystem Time Set[0m.
>> [   23.664909] renesas_usbhs e6590000.usb: host probed
>> [   23.670786] renesas_usbhs e6590000.usb: no transceiver found
>> [   23.681784] CAN device driver interface
>> [   23.715954] renesas_usbhs e6590000.usb: gadget probed
>> [   23.733490] rcar_sound ec500000.sound: probed
>> [   23.733530] renesas_usbhs e6590000.usb: probed
>> [   23.750887] rcar_can e6c30000.can: device registered (IRQ158)
>> [   23.803934] rcar-fcp fe950000.fcp: deferred probe timeout, ignoring d=
ependency
>> [   23.818884] renesas_usb3 ee020000.usb: probed with phy
>> [   23.819530] rcar-fcp fe96f000.fcp: deferred probe timeout, ignoring d=
ependency
>> [   23.837170] rcar-fcp fea27000.fcp: deferred probe timeout, ignoring d=
ependency
>> [   23.845703] rcar_can e6c38000.can: device registered (IRQ159)
>> [   23.849742] rcar-fcp fea2f000.fcp: deferred probe timeout, ignoring d=
ependency
>> [   23.859370] mc: Linux media interface: v0.10
>> [   23.862059] rcar-fcp fea37000.fcp: deferred probe timeout, ignoring d=
ependency
>> [   23.872076] rcar-fcp fe9af000.fcp: deferred probe timeout, ignoring d=
ependency
>> [   23.963233] videodev: Linux video capture interface: v2.00
>> [   24.010975] rcar-dw-hdmi fead0000.hdmi: Detected HDMI TX controller v=
2.01a with HDCP (DWC HDMI 2.0 TX PHY)
>> [   24.022393] rcar-dw-hdmi fead0000.hdmi: registered DesignWare HDMI I2=
C bus driver
>> [[0;32m  OK  [0m] Reached target [0;1;39mHardware activated USB gadget[0=
m.
>> [[0;32m  OK  [0m] Listening on [0;1;39mLoad/Save RF Kill Switch Status /=
dev/rfkill Watch[0m.
>> [   24.100239] Bluetooth: Core ver 2.22
>> [   24.101314] rcar_fdp1 fe940000.fdp1: Device registered as /dev/video0
>> [   24.104595] NET: Registered PF_BLUETOOTH protocol family
>> [   24.116226] Bluetooth: HCI device and connection manager initialized
>> [   24.122792] Bluetooth: HCI socket layer initialized
>> [   24.127834] Bluetooth: L2CAP socket layer initialized
>> [   24.133098] Bluetooth: SCO socket layer initialized
>>          Starting [0;1;39mVirtual Console Setup[0m...
>> [   24.205664] Bluetooth: HCI UART driver ver 2.3
>> [   24.211420] Bluetooth: HCI UART protocol H4 registered
>> [   24.217347] Bluetooth: HCI UART protocol LL registered
>> [   24.224737] Bluetooth: HCI UART protocol Broadcom registered
>> [   24.230799] Bluetooth: HCI UART protocol QCA registered
>> [   24.236598] Bluetooth: HCI UART protocol Marvell registered
>>          Starting [0;1;39mLoad/Save RF Kill Switch Status[0m...
>> [   24.369729] [drm] Initialized rcar-du 1.0.0 for feb00000.display on m=
inor 0
>> [   24.381653] hci-ti serial0-0: Direct firmware load for ti-connectivit=
y/TIInit_11.8.32.bts failed with error -2
>> [   24.391870] Bluetooth: hci0: request_firmware failed(errno -2) for ti=
-connectivity/TIInit_11.8.32.bts
>> [   24.401719] Bluetooth: hci0: download firmware failed, retrying...
>> [   24.410336] rcar-du feb00000.display: [drm] Device feb00000.display p=
robed
>> [   24.421545] rcar-du feb00000.display: [drm] Cannot find any crtc or s=
izes
>> [   24.430636] rcar-du feb00000.display: [drm] Cannot find any crtc or s=
izes
>>          Starting [0;1;39mStart psplash boot splash screen[0m...
>> [   24.556773] audit: type=3D1334 audit(1748544507.499:8): prog-id=3D12 =
op=3DLOAD
>> [   24.564822] hci-ti serial0-0: Direct firmware load for ti-connectivit=
y/TIInit_11.8.32.bts failed with error -2
>> [   24.575030] Bluetooth: hci0: request_firmware failed(errno -2) for ti=
-connectivity/TIInit_11.8.32.bts
>> [   24.584323] Bluetooth: hci0: download firmware failed, retrying...
>>          Starting [0;1;39mNetwork Name Resolution[0m..[   24.595776] cfg=
80211: Loading compiled-in X.509 certificates for regulatory database
>> .
>> [[0;32m  OK  [0m] Started [0;1;39mLoad/Save RF Kill Switch Status[0m.
>> [[0;1;31mFAILED[0m] Failed to start [0;1;39mStart psplash boot splash sc=
reen[0m.
>> See 'systemctl status psplash-start.service' for details.
>> [[0;1;38;5;185mDEPEND[0m] Dependency failed for [0;1;39mStart psplas=E2=
=80=A6temd progress communication helper[   24.672548] Loaded X.509 cert 's=
forshee: 00b28ddf47aef9cea7'
>> [0m.
>> [   24.680777] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248=
db18c600'
>> [   24.752421] hci-ti serial0-0: Direct firmware load for ti-connectivit=
y/TIInit_11.8.32.bts failed with error -2
>> [   24.762635] Bluetooth: hci0: request_firmware failed(errno -2) for ti=
-connectivity/TIInit_11.8.32.bts
>> [   24.773223] Bluetooth: hci0: download firmware failed, retrying...
>> [   24.937456] hci-ti serial0-0: Direct firmware load for ti-connectivit=
y/TIInit_11.8.32.bts failed with error -2
>> [   24.947708] Bluetooth: hci0: request_firmware failed(errno -2) for ti=
-connectivity/TIInit_11.8.32.bts
>> [   24.957022] Bluetooth: hci0: download firmware failed, retrying...
>> [[0;32m  OK  [0m] Started [0;1;39mNetwork Name Resolution[0m.
>> [[0;32m  OK  [0m] Finished [0;1;39mVirtual Console Setup[0m.
>> [   25.081164] wl18xx_driver wl18xx.3.auto: Direct firmware load for ti-=
connectivity/wl1271-nvs.bin failed with error -2
>> [   25.092966] wl18xx_driver wl18xx.3.auto: Direct firmware load for ti-=
connectivity/wl18xx-conf.bin failed with error -2
>> [   25.105459] wlcore: ERROR could not get configuration binary ti-conne=
ctivity/wl18xx-conf.bin: -2
>> [   25.114417] wlcore: WARNING falling back to default config
>> [[0;32m  OK  [0m] Finished [0;1;39mRebuild Dynamic Linker Cache[0m.
>>          Starting [0;1;39mRun pending postinsts[0m...
>> [   25.618454] wlcore: wl18xx HW: 183x or 180x, PG 2.2 (ROM 0x11)
>> [   25.633795] wlcore: loaded
>>          Starting [0;1;39mUpdate is Completed[0m...
>> [[0;32m  OK  [0m] Finished [0;1;39mUpdate is Completed[0m.
>> [   26.582972] audit: type=3D1334 audit(1748544509.527:9): prog-id=3D13 =
op=3DLOAD
>> [   26.589729] audit: type=3D1334 audit(1748544509.527:10): prog-id=3D6 =
op=3DUNLOAD
>> [   26.596626] audit: type=3D1334 audit(1748544509.535:11): prog-id=3D14=
 op=3DLOAD
>> [[0;32m  OK  [0m] Finished [0;1;39mRun pending postinsts[0m.
>> [[0;32m  OK  [0m] Reached target [0;1;39mSystem Initialization[0m.
>> [[0;32m  OK  [0m] Started [0;1;39mDaily Cleanup of Temporary Directories=
[0m.
>> [[0;32m  OK  [0m] Reached target [0;1;39mTimer Units[0m.
>> [[0;32m  OK  [0m] Listening on [0;1;39mAvahi mDNS/DNS-SD Stack Activatio=
n Socket[0m.
>> [[0;32m  OK  [0m] Listening on [0;1;39mD-Bus System Message Bus Socket[0=
m.
>>          Starting [0;1;39msshd.socket[0m...
>> [[0;32m  OK  [0m] Listening on [0;1;39msshd.socket[0m.
>> [[0;32m  OK  [0m] Reached target [0;1;39mSocket Units[0m.
>> [[0;32m  OK  [0m] Reached target [0;1;39mBasic System[0m.
>>          Starting [0;1;39mSave/Restore Sound Card State[0m...
>>          Starting [0;1;39mBluetooth service[0m...
>> [[0;32m  OK  [0m] Started [0;1;39mKernel Logging Service[0m.
>> [[0;32m  OK  [0m] Started [0;1;39mSystem Logging Service[0m.
>>          Starting [0;1;39mD-Bus System Message Bus[0m...
>> [[0;32m  OK  [0m] Started [0;1;39mGetty on tty1[0m.
>>          Starting [0;1;39mIPv6 Packet Filtering Framework[0m...
>>          Starting [0;1;39mIPv4 Packet Filtering Framework[0m...
>>          Starting [0;1;39mTelephony service[0m...
>> [[0;32m  OK  [0m] Started [0;1;39mSerial Getty on ttySC0[0m.
>> [[0;32m  OK  [0m] Reached target [0;1;39mLogin Prompts[0m.
>> [   27.096029] kauditd_printk_skb: 17 callbacks suppressed
>> [   27.096043] audit: type=3D1334 audit(1748544510.039:29): prog-id=3D23=
 op=3DLOAD
>> [   27.108223] audit: type=3D1334 audit(1748544510.047:30): prog-id=3D24=
 op=3DLOAD
>> [   27.115100] audit: type=3D1334 audit(1748544510.051:31): prog-id=3D25=
 op=3DLOAD
>>          Starting [0;1;39mUser Login Management[0m...
>>          Starting [0;1;39mOpenSSH Key Generation[0m...
>> [[0;32m  OK  [0m] Finished [0;1;39mSave/Restore Sound Card State[0m.
>> [[0;32m  OK  [0m] Finished [0;1;39mIPv6 Packet Filtering Framework[0m.
>> [[0;32m  OK  [0m] Finished [0;1;39mIPv4 Packet Filtering Framework[0m.
>> [[0;32m  OK  [0m] Reached target [0;1;39mPreparation for Network[0m.
>> [[0;32m  OK  [0m] Reached target [0;1;39mSound Card[0m.
>> [   27.255468] audit: type=3D1334 audit(1748544510.199:32): prog-id=3D26=
 op=3DLOAD
>>          Starting [0;1;39mNetwork Configuration[0m...
>> [[0;32m  OK  [0m] Started [0;1;39mD-Bus System Message Bus[0m.
>>          Starting [0;1;39mConnection service[0m...
>> [[0;32m  OK  [0m] Started [0;1;39mTelephony service[0m.
>> [[0;32m  OK  [0m] Started [0;1;39mBluetooth service[0m.
>> [[0;32m  OK  [0m] Reached target [0;1;39mBluetooth Support[0m.
>> [[0;32m  OK  [0m] Started [0;1;39mUser Login Management[0m.
>> [   27.533604] audit: type=3D1334 audit(1748544510.479:33): prog-id=3D27=
 op=3DLOAD
>> [   27.540524] audit: type=3D1334 audit(1748544510.483:34): prog-id=3D28=
 op=3DLOAD
>> [   27.547773] audit: type=3D1334 audit(1748544510.491:35): prog-id=3D29=
 op=3DLOAD
>>          Starting [0;1;39mHostname Service[0m...
>> [[0;32m  OK  [0m] Started [0;1;39mConnection service[0m.
>>          Starting [0;1;39mAvahi mDNS/DNS-SD Stack[0m...
>> [[0;32m  OK  [0m] Started [0;1;39mNetwork Configuration[0m.
>> [[0;32m  OK  [0m] Reached target [0;1;39mNetwork[0m.
>> [[0;32m  OK  [0m] Started [0;1;39mAvahi mDNS/DNS-SD Stack[0m.
>> [[0;32m  OK  [0m] Reached target [0;1;39mMulti-User System[0m.
>>          Starting [0;1;39mRecord Runlevel Change in UTMP[0m...
>> [[0;32m  OK  [0m] Started [0;1;39mHostname Service[0m.
>>          Starting [0;1;39mWPA supplicant[0m...
>> [[0;32m  OK  [0m] Finished [0;1;39mRecord Runlevel Change in UTMP[0m.
>> [[0;32m  OK  [0m] Started [0;1;39mWPA supplicant[0m.
>> [   28.234025] wl18xx_driver wl18xx.3.auto: Direct firmware load for ti-=
connectivity/wl18xx-fw-4.bin failed with error -2
>> [   28.244822] wlcore: ERROR could not get firmware ti-connectivity/wl18=
xx-fw-4.bin: -2
>> [   28.742510] wl18xx_driver wl18xx.3.auto: Direct firmware load for ti-=
connectivity/wl18xx-fw-4.bin failed with error -2
>> [   28.753354] wlcore: ERROR could not get firmware ti-connectivity/wl18=
xx-fw-4.bin: -2
>> [[0;32m  OK  [0m] Finished [0;1;39mOpenSSH Key Generation[0m.
>> [   29.266013] wl18xx_driver wl18xx.3.auto: Direct firmware load for ti-=
connectivity/wl18xx-fw-4.bin failed with error -2
>> [   29.276801] wlcore: ERROR could not get firmware ti-connectivity/wl18=
xx-fw-4.bin: -2
>> [   29.284679] wlcore: ERROR firmware boot failed despite 3 retries
>> Poky (Yocto Project Reference Distro) 5.0.11 hihope-rzg2m ttySC0
>> Matched prompt #12: hihope-rzg2m login
>=20
> Yep, this is basically what I got now as well... after switching back
> from cip_merged_defconfig to renesas_defconfig for 6.12.
>=20
> We /may/ have another config merging issue, adding Quirin, but maybe
> you, Biju, could help us identifying the config options that flipped in
> the wrong direction. My first guess is that something which needs to be
> built-in is now a module (or worse).
>=20

Or are we enabling more, but maybe not enough?

+CONFIG_DWMAC_GENERIC=3Dm
+CONFIG_DWMAC_RENESAS_GBETH=3Dm

Those match on "renesas" and "difference" between the two configs. Then
our merging of configs would not be the one to blame.

Jan

> Keep in mind that this is not only important for the rare tests with
> isar-cip-core. KernelCI is using the merged defconfig now as well as I
> showed in the cited boot logs from lava.
>=20
> Jan
>=20

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

