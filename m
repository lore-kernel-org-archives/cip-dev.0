Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7667CD98CC
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 14:21:30 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.64])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.46916.1781187687228345114
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jun 2026 07:21:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=CNKoaEvS;
 spf=pass (domain: siemens.com, ip: 40.107.130.64, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hdlG5xLZ6Tur1u1jbcoYrm3vfZCCLrnffEOfEXj6kZ63F8HDRiG9Mrnf4bb5XJDBvK764o2zmv9IJGPUTvGOccBOjYeFXoC8/wVXP5XehJ1jmn1adiX5vtklx9S495c/V2l2Y9o0vUevuHFEmLr62o/pUjEInoDwNy4PbnhkFHFmX+6QKpl1hXDBfnwUKfpVG+0a6qjJp0AJx3/lzaxblhjlQ+rOJ1Oz0AHQW8Ni398ySZxfGxNplUlbm3seoFsJ3EOfoQVT0Bri/BM0pJOKDL5mSLHJNkvyK8bUTsxKwIeMjy1S6YFQZfs5FnzkUfjGJ5CzVPkxIvAfyB+AcmBAqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRzvAH+t33gw67CvQ3KGvgHXyVdjRlCbzBF9ITb1ZNM=;
 b=cPzJFZocJ4yzADJH1g8nLajaBd48JqKH4ud3xIPIGzH9c7nLy6RPR+c0EmBpNmkfwTf+zno9paVD1D8zYYiBuTLZ8/qn8AwaCsEKw/HgvFJQtxFoyJVejSyTolI2ajzG6PbMid6P+TKQWBwK15EU+o52o82N38TylxykkQG4wwk8jVWVScCadKBYqoUJ2VI3rXaNDJbbhrm2t6LrJJ+/cRcMgMs90v4GG9Fc5PeiGQkRTrJBBH0ZxbR6+c71ApKYg0rUFAwPNf5dxoYqlLotsTcYrmzBoD/uFpGqxmLlvOelPTSRDGzSn1te+XAnP4ls23YxUePsVW3Y4XowcLeCKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRzvAH+t33gw67CvQ3KGvgHXyVdjRlCbzBF9ITb1ZNM=;
 b=CNKoaEvSPc1zsVGPfdCDelE8xuaZn3T2QPOYTgtSbTSDuS6WfMMTAAQ4S381GmxhEFq/YNktmlRFcYWKb1Yr0LFbVcKfHRjcLMjCt4xmJJRvOhGliOOfuYZW2OKrqntzkWyoXpMFdj+3Vec58CVKTx8vbfAF2zIDyA+GKftryWkdhdJs2qFuyjDuGXM3glj62rZyZtKmusE9VEtwbnm78SQt4c5tInrpjZvXbGMdGwI4NRBrKmsYnduWIqrgpRF4k9dokMe6Ti3NgQiyFSuGf8a7Y9EIm7FbeFM9TwSccYTLVOpBVVy+aD/R2gD2UiFzXsxhd5pM9DxYYJIUzt/tyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB9089.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 14:21:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 14:21:22 +0000
Message-ID: <14484e19-d677-4bdb-9b25-4cdd1f841bd0@siemens.com>
Date: Thu, 11 Jun 2026 16:21:22 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip112,
 4.19.325-cip133, 6.12.92-cip25
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
X-ClientProxiedBy: FR3P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB9089:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c1e610f-1625-4d6e-8a45-08dec7c4b6d1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|55112099003|6133799003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 
	eJdkJFQ7P+ObgDetczziJJBqsufVzaufH2OMp1qSNKjCTpVvK4cisv+XFgkA1qAkM13OP8qQ5Izm5Pwk4/HS/EllFbdKPWWj1o6eU44XKYvYZcNcT5DYM+4x9RUierAi3WNEZZome3+DjSgEkUx85r6h/QLaCHPfwYc/6YtHlxV10vLKTgHpDk6yW5sbnLN2Y9Cc37eRLMs5wByJedaPHuYekniQ3K5h7q7pIDvaLg5arvf++NoVRA6E+ycPGbQuQHP5ubUub1fmdOaW5ycZ+jRODt6y/pBAPj3Hx3FINQOq/YW+kFS2kcgBwpI9LSArDp9HU6VIOx2agphI+78lLqHL+wAIugRR10LJnAzO7lTc9HAtytJKFYhbaBuVgR4/GjW+T9j3egnvvIMZzK1wX6joIHiGpRj9Lio7aqGxMEg3r63E9w8UOhtFb3BdqBnpjLBrIDi5iO68MJfX/sX5w4R2MkMF0fmp2oSudom50af+zmLptqVbuUn84pzW/XCnw809UFpPUG6LLTfkCRtr+IP3PA+xal3mLAjYnt+CKf00/VVo0X0KqASv23/VbCaHe12/R0Eb/VpWMjGFjBMKAoXwngA66lxhyHShU6FU8PKxOAK7bMY3dvaVgIBwGnsJGkkm2+IRtBOUeH1b4qkeL+1Qm593yCsB/HGgGQ1XFFOHlFqfPVupsVdMHMMDGNu8
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(55112099003)(6133799003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V2lLeW5xZVJUaGZUM2U5WlhPOEsybkhwN3NnbVpCQXQ0WVJUdzlZQXlqQXBj?=
 =?utf-8?B?YzcwMS92V0NVdWtiSnVSV3doenRPMC9vUWN6SUErMVdjWnhuSUFhdjR0eDkw?=
 =?utf-8?B?eFAraERnMzlXVk5PZXpRblFJNlZzZUQ2QktrT0hadnppbEJiQlFPY3pMWDln?=
 =?utf-8?B?V2dXRm9rQ0Z3REU0MDhEZXRQTDQrQlV3SSt6NE9WM3gvRjQ4S21icTlld3ZF?=
 =?utf-8?B?L0JNTE0zbjk0RFFGZU1iV21Ya2pCV0E3dHZ5dFplVFVuajduYWZFeXY1Zk9N?=
 =?utf-8?B?aUZmeU9FaWViSVVuOTRhdHBXQ252enhDRXJ2aDBpQml6THM5NnZQckRTTzNk?=
 =?utf-8?B?SnR2Nkh0ZUQ4WXZkcHhwVlNBNVhheG9iYnlrRmpnUHJHTm5wSVh6Lzl2SmFN?=
 =?utf-8?B?NE5sdlRtamlTa0t1MXpFcjE0US9UNlRkSUtpUFdqU2owOE9UVk9JUFVoR2hU?=
 =?utf-8?B?RUVmbitaNWdjS0dvNk5nNGZzTml4elBnaHNlUm9kaUNhL2FYdGxKeUtkdmhz?=
 =?utf-8?B?MGpFbEdXVHdIVGdWcDlqUEg3dGtSNENwcWpHRmF4V3hXZTNNMU5WRFpwWjUz?=
 =?utf-8?B?TE1CdnZnVGNtOTZvamxVV0IwMlhudVpJaHB6TnB2SGtxYkxRVnVpZDR5aXdi?=
 =?utf-8?B?VDRlcUFrL0ZNVXZPVzI0SzUrUFNqc0h3RlhEZ1JmL3dQQkNYMnlMdFFVSmlh?=
 =?utf-8?B?R0k5amJ4Z2NSRGRPd3pWY1RaMkFvOEE3S0ZVMTFXaEpmRC9UdzNoSit6aTYr?=
 =?utf-8?B?MURpSVNLejNBcFVteFJBQmNtOEtxVVdmQXBsdVNRcURnS2xXeTJoNFFIQysx?=
 =?utf-8?B?NzJlcGxVc2VIR3EwMEp2eTdZYW1rQmVlK2YrczNxSmk2eXN1Q3F4dDVYeUV3?=
 =?utf-8?B?b2poQ1c0NWt0aHAwM0ZrOEdURVNxZ2tVRmd3YlBmc1VIUFQyOUdkSmdvQzYx?=
 =?utf-8?B?WXRZcElsNFlLT0kxL0NJaklUWndJV3pkcjBMYjA0NXVyQncrNmtqR3VsN3VE?=
 =?utf-8?B?VUgyU3Vxc00rWVEyMnRxZTVQS1JGUStVYTN3WGNMa2wwMk5FY1h6ZVllOWFY?=
 =?utf-8?B?NmpHSGNGeDVRclIvYnVEMlFVUDBONGcvSXVxa08ydUxUUGZNY2Z6MG13eUlF?=
 =?utf-8?B?blc5QXlOWW8rd29oZWYxUmpGV2h6OEJ3eDZlVE5JWEJtaVIrMTVXTUZMY2tF?=
 =?utf-8?B?N0NDT0VIY1h0K0FseUs4ell0ZUhXdHdoRWdyU08rRkl5aHVEZE1OdmJ1dVNm?=
 =?utf-8?B?d2hScEYwbWxBWWZQc21xMmxtVXJOOGRscUVYRkZVUjgrTUdIeTd3RS9vNFA5?=
 =?utf-8?B?RFBkZklOUW9FdDdLYWQ2MzRXWGZ4TUZRL0xVbGY5ZkpsdGl0TXhlRTZzUG1l?=
 =?utf-8?B?bnRTNC9yR2VQdXl6R2t0S1AyanhxcDZsd3p2ZGZMS3IxYzJPanRWOTN2VUhn?=
 =?utf-8?B?WWJFVzJWOWdob0RMaWovL1QyZkpFWVgrZzZsemtBZ0tqZ1p5S0YydFhaQ1Fs?=
 =?utf-8?B?TmxiYk5xY2JTWEp0SlNxNEk1aUliSStoVkJpTVdRK2hROFFNSzdkUXNlTjZK?=
 =?utf-8?B?UjdabU1pbnJTTkhJOWV2L0NxRWx4SkZxblliUXF4T0VsRHRMZHJCem9MbzlD?=
 =?utf-8?B?cDduYU94U2g5ZUZCdU9FM1pvWmtzWE9vY0ZvNXhoNnBkUHI4ZzQzT0IyRVU0?=
 =?utf-8?B?QlBVMmFRd2JNS3VDVWt0akFCZGRhUjZLd242U1lMSnVidTFWVzhObFNDZHFY?=
 =?utf-8?B?amNFS0NXa0IvcXVIUHFjdk1FUEhYdkRubXFtZU40a2Z3UzcyL041dkdVcitQ?=
 =?utf-8?B?WXZKRDByR0kxVi9VeHlBR0M0TUhwZnI4SnBMYkZLbjNtd2p6UHdQdkpWNEdi?=
 =?utf-8?B?eHdFK0FWMXpCTkpRVncyQzExNFNOb1RYd3E0UHl3cVZtM2xiOE9haGJDUDgw?=
 =?utf-8?B?UmwwWTIxZTdxNjF5clRDU0NaYTNiTHBCU2x0dEhpb2RnQ0N2eEllcG45SFJP?=
 =?utf-8?B?bis3bXZJcUVlVnNxb3dpTk1IWWtQeVB5cEFUeWRLTi9CMEdIQitGVCtLMkQ5?=
 =?utf-8?B?eHpqaElDazZUK1ppeFBUTFdxM1NGdWdERWZFT2V0WnhuTEltamFEeklZUVpi?=
 =?utf-8?B?UE4zSGVPRUYyTnZ2elJrTG5xMEZiWU9tZ1NuaDg5WHpMZFlzSkVjMUdvNTQx?=
 =?utf-8?B?UkFGc3Q4aTlVaWRkMlJmS1RSZlNlRmhsSVIxRGgzUW9TWnBlK093dUx0dVZ3?=
 =?utf-8?B?QXhoS3puUGU1elhQemdXUmVZSDNyZzdRcGJvaWU4U1lhTCsxcTJxTG93RjFa?=
 =?utf-8?B?Q0tnclNtbDJocTl3bG9idWE0YmZNZnUwRDNRb3pndWhpSDQ3OXA4dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c1e610f-1625-4d6e-8a45-08dec7c4b6d1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 14:21:22.9406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATj6V2VCBXUZ6YB0vOAGijedCLiLuY+p5zW8GgnyqFRyhJH5a8CTN/3BEJ3zJMWKJIKXuTGBf383SYQuc5np+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB9089
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jun 2026 14:21:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23130

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-cip-rt_6.12.90-cip24.bb              | 1 -
 recipes-kernel/linux/linux-cip-rt_6.12.92-cip25.bb              | 1 +
 ...inux-cip_4.19.325-cip132.bb => linux-cip_4.19.325-cip133.bb} | 2 +-
 ...{linux-cip_4.4.302-cip111.bb => linux-cip_4.4.302-cip112.bb} | 2 +-
 .../{linux-cip_6.12.90-cip24.bb => linux-cip_6.12.92-cip25.bb}  | 2 +-
 5 files changed, 4 insertions(+), 4 deletions(-)
 delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.90-cip24.bb
 create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.92-cip25.bb
 rename recipes-kernel/linux/{linux-cip_4.19.325-cip132.bb => linux-cip_4.19.325-cip133.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip111.bb => linux-cip_4.4.302-cip112.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.12.90-cip24.bb => linux-cip_6.12.92-cip25.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.90-cip24.bb b/recipes-kernel/linux/linux-cip-rt_6.12.90-cip24.bb
deleted file mode 120000
index 0bbe9619..00000000
--- a/recipes-kernel/linux/linux-cip-rt_6.12.90-cip24.bb
+++ /dev/null
@@ -1 +0,0 @@
-linux-cip_6.12.90-cip24.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.92-cip25.bb b/recipes-kernel/linux/linux-cip-rt_6.12.92-cip25.bb
new file mode 120000
index 00000000..1afb3642
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_6.12.92-cip25.bb
@@ -0,0 +1 @@
+linux-cip_6.12.92-cip25.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip_4.19.325-cip132.bb b/recipes-kernel/linux/linux-cip_4.19.325-cip133.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.19.325-cip132.bb
rename to recipes-kernel/linux/linux-cip_4.19.325-cip133.bb
index 4133ec71..6dbedc2d 100644
--- a/recipes-kernel/linux/linux-cip_4.19.325-cip132.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.325-cip133.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "3b3eb046d0ffefc4fd85406d835cac737095a1c8f4941013057e45f72abb881a"
+SRC_URI[sha256sum] = "7f3b7d51b94d7c5696f0403d2467908891d4b97abb3abae01582b8415fa0832d"
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip111.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip112.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip111.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip112.bb
index 1c00f30e..82c6785c 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip111.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip112.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "d3cd13883e8c7f39613840594ae37dbe6ca5a6e0c368082e95554b0d043968b2"
+SRC_URI[sha256sum] = "6ab9517bb87496d1cac7b1ae5633eba01ab840b115454b4c71def3ee1a890077"
diff --git a/recipes-kernel/linux/linux-cip_6.12.90-cip24.bb b/recipes-kernel/linux/linux-cip_6.12.92-cip25.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.12.90-cip24.bb
rename to recipes-kernel/linux/linux-cip_6.12.92-cip25.bb
index 4f129f45..fe2ca8ea 100644
--- a/recipes-kernel/linux/linux-cip_6.12.90-cip24.bb
+++ b/recipes-kernel/linux/linux-cip_6.12.92-cip25.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "acf2bc2fa5d793849b97bd32cd6274ba45391464492be52a2036ba8bbdc64247"
+SRC_URI[sha256sum] = "c29d46ea7b96b4d0f3ee8d39d73067b977747ec46331a9f8e47a1db272dde9e5"
-- 
2.47.3


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

