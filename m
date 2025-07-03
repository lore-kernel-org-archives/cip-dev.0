Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B44C83030
	for <webhook@archiver.kernel.org>; Thu,  3 Jul 2025 12:17:36 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.50])
 by mx.groups.io with SMTP id smtpd.web10.21058.1751545051679996291
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Jul 2025 05:17:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=HTga6vh/;
 spf=pass (domain: siemens.com, ip: 40.107.159.50, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9fWakV8vZ+EqFmNwZb1sbOHe/CPPWsDoQfMALj1pPcf6yJOZePeYqK91qHHedmGQxgFGNt8j39HYPsjFjjEmZfI9ywR/KREc0Iv4QP0CfwALnsybw0AFtlhhCjuUWNCxk2KTVli6B6ZM13yn/jXNjKjysXFpzm5PEV4vwcc+ELCqfv9l9kzKCtKFvykSft7eGKcH0Ib1ENjQXHZKjK5Rz/W+OhGhePWlSVsfnMCO1GBwPFedVCB9mPIe/4rJU5u2A3tCKHRM1KbgJdq8JiymLheks5nNC9VQ0xqMuWhbFdjceuWI9dKO1Vn5CbCRVYWDZDopcgZmSRt4/0N4MM+oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/VEjpQhmR7xD2jfOuQ9A/+A2aCAekpKFwAjq9tdaWE=;
 b=yZQRZJ3QuXo0zBRX6LimuqcIVFUQu1H210w3IGOmaVbT7FCSFSiw66YE/DLeBoC7kfw10QXAtMRX3G46boxNS31CQq7/hsUjVgQTsvNQ44HLpQXDkZUD/47eAtT7bzdTD7l7KIDZDEJEKy4u4a/OYsumGB8Sies508S+jll9W1KDq/GKBfbHe06iZoTQWRPANuI1KsfXPDHdX6BBy/TDzmFVUm6izYjZebXvQ/WcWv8CngS3JbktvqwazeTl5atdlmbGtWIhmACGzvRGx+/mBQG3Q4lWDhuetb8RcNqMvG3KSF3mjo4x6kylx5GNSzzxU4mtEqI16dR2G8dyTqLemQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/VEjpQhmR7xD2jfOuQ9A/+A2aCAekpKFwAjq9tdaWE=;
 b=HTga6vh/7lpo9toVpUG3v4KM+kgbqoPeP+qmZoHYd7grzP5fr0ND3gqIE94avjKoN0RqNHwDSJkOU9g04uFi3nvjzVQQmKg0RkXr0DPsMD7wxI61n6Pog4dHxp75BkVQ5An5FwUAMEp0mB7dlnUOBMUOnuDswsfnCSJ8tiq/yvwHoY3nHJjbRMwW4aBXQ/W4cP4FLgUBUnTOS+wfQrmWDxZnt+0Oce7bMWFOjemHTzEMW2rxAFmC3Qu/hYu12Mx1N2VmJSKbtiK80jyEfINz6SUEX4H1bLK5l/sBPU7caq3gvzow2XmiJZ+paiaixTgYESxa3r8zPWG3XnnHyCxEDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7479.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:591::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Thu, 3 Jul
 2025 12:17:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 12:17:33 +0000
Message-ID: <308f130f-519d-4bd0-8a33-46fdf490b90d@siemens.com>
Date: Thu, 3 Jul 2025 14:17:32 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Update isar revision
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
X-ClientProxiedBy: FR4P281CA0299.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: a486830f-ecd4-4f23-9dab-08ddba2b9683
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SXliektVTU1HMC8yK0RmVmZzM21Id05ybU5IRC82L2p0aHMzd3ZrbS92OUxE?=
 =?utf-8?B?RWFMaXlxUk13Znk1YStmMFRsZFJCdzRjYjJtR0RwaFE1SFRqamt5cDVVK3VQ?=
 =?utf-8?B?Y29TTTRuWmgzWDhRTldvenI0c1J3bGhhVlZOZXg4L1FFYi9OSnllR3pML2dI?=
 =?utf-8?B?ZE9ERXRFVTArUXBUL015SHM4bnpwSitOK2N6OE9Xc3E4cUF3ckI3dE5Od1N5?=
 =?utf-8?B?cllOamRxZmhrOVNBZjZjQlArZG1sc0hEbDc4SFFTbmx1WlZ1RmlrZ2thVjFr?=
 =?utf-8?B?TitBMnRpVHpxR0RMQnJrbWFtZm4vTWxrY2RrSzQvcWpZbHpqL29TMHBFck0w?=
 =?utf-8?B?MENwM2FUWmFFRWR6SlFLTzJzQ053aWEwMXc1K1VpRVFRTFVOK1RpQlRoMFk1?=
 =?utf-8?B?N05ta1lXLzMzdHhWNjlZVWVnQnFwdUpMZWVhRThlOXBQcG96Q3FQWVhzOGha?=
 =?utf-8?B?b3U5TUMzMXZKNGp3NENBL3RIZDBNMS9RUjl0OUJDa3BaU3lCYXRnanVqc3E1?=
 =?utf-8?B?eHA5aHR5eVc2bTByeDdoa1YzZWdvcVU0dStNVDV1VW1GUmtmZ0lsekNNQ3dx?=
 =?utf-8?B?VUVUY2pnREU4Vng3am1STXJqZTlTdnJ2S25wdDBtakxUbkxmRmpyK3BQZENj?=
 =?utf-8?B?cXdZZHJvUEdrS1RaSmlqdWdkMFJiOGtrVm1pcWordlJKVStpU1hvU3FDYVV1?=
 =?utf-8?B?TXpZZUNsWStDUklyaFhsVlZKU3FsTUhuaVZtdmlEMVhyTWFRZGpSbkxPS3dj?=
 =?utf-8?B?c2NISHN6cXpGemdOZkI3YlY3VG11WlAyOHZRcTk5OVA0UW1PLzlkVXVSQmpQ?=
 =?utf-8?B?dTlUUVRCYzBQOVorVENCMW1yMVZlYWliY1I2ZGNscFJ0TnFBSms3clJqcG80?=
 =?utf-8?B?b2RhdzlyaXRmRytDMjdhMDR3ZzJ2bnBKQ3QyMkM3dUpaOGdWV0xtWWR2cVBU?=
 =?utf-8?B?dU1yaGMrdDVsWmFFK1Q4NmYyeUY3ZmFqOEhnY0U0amdzRC9OU0pFdmJibnJZ?=
 =?utf-8?B?V1FSVGRiTFFhZGlUd3pZakJGWGd5a2YwczZOWkxCL2JGUnhuOWNFRVhrT3hV?=
 =?utf-8?B?dDZ0N3Zad1RxbVBYazhPZy9XWTRyRllZZVBYdVZRdHVFZkRPM2ZBaFBZZk5T?=
 =?utf-8?B?b0NaaWJydzdQNC9jQTVqTEdDZ1FzVHFMZFA2TzB6UThkMDJyYjdBSHdBdnZP?=
 =?utf-8?B?M2d3UnBuTldOU0ZWejljWmQwOGZxUzA3ajhtRUo1aDFPVXRmSGpzc3BTRmVu?=
 =?utf-8?B?NFdScjhWWWJpazEwdUkwZzB4SFFqVUxVdjcvMlo2c1RRa0IvSlFrT0dGWUZG?=
 =?utf-8?B?ZzhLcEp5Zi83eC9ZSE9oTWJHZk9uKytYdHd1MXJRU3dRWlBEQUszV21hclNn?=
 =?utf-8?B?cFJtR3I3YjJYY2FLRjhsaFJpUkxWQ3dmQ1dsU29SZ0tJYlgzRUVIMjEvUUhZ?=
 =?utf-8?B?ZDNoYXFRNkExWnZLWXdTOGVaZ2N0eEpTT2h5M0FmSGN5aFgyb2I2Mkttd0lY?=
 =?utf-8?B?RURkNyswcUpYSGZlZlhia3RzRlUrMzhEOTU4dnYvMWtnbDI2ZVhSNTAwNXBn?=
 =?utf-8?B?b2J2ZGJicjhaWFFkZGtOc3E2NjREYjR0bzdjSUVpTkpYbFVQQjUzZjNEQkps?=
 =?utf-8?B?aDFFSDBZMWN4SFJCMnBEa1BQVm11VlJQTnJJazhKazVZdG5wdmNFUi9XcmdC?=
 =?utf-8?B?QnNGZkhUa3dPTEhvV1dmZndHMGhKdVJ6SlR2OFQ2YXhXYTZDMFJpOENpVDBx?=
 =?utf-8?B?VVM3VmkvYlBYdHRmdGRudjBXMUtYbjJKQlk2YTBHL05naThuUThHV0NiZTZH?=
 =?utf-8?B?YzhZejR0K3N1VktlTXRDUURzZWVGVXZQQlkwYmF6ZVhKMlBPeWxQclR1a2gw?=
 =?utf-8?B?NmVGa1daQ294YWhsTnN6WVdiRkFPZ3dUVnNNNzZvM0dWUndpM2RZZndZemp6?=
 =?utf-8?Q?+y6BaXhrWXM=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VnRjWWgwZkdFL0pWK3NTYy8rd2dUQTRZS0ZHanVpYVBiajNpREZKR081NFFE?=
 =?utf-8?B?Mjl0ampOeEJVdVkzUzlVVitJNjIxS1Y4bmpZVnlKbEg1OGYvVGZiZWIxWFVQ?=
 =?utf-8?B?T3RVOGN1QUwvOCswM3c2ZGVJMUdlVW5OaU9WUnlPNiswSGVaeWVkSG1iVWln?=
 =?utf-8?B?aTAwUWExYTNwNlNkbEpXL0RIV3ZKTTA2S0Y4TUtSa1FSdC96VitZRmJIU2NK?=
 =?utf-8?B?VEl6WWswVXVFVW45bDFCU3ZMckhZN1Z3Z2NZNmJFQWhsWUY1UzN1R01NQWxB?=
 =?utf-8?B?UE1MS2E4OVdjNytROHo3L2VWRGhUbSt4VXM5SExaVUdCUGVBdEFWTW9nNi9l?=
 =?utf-8?B?RzhqRDljNlhmWnlwMG9FUVNvZlhQTjJYRWp2aDBZRzhsQm1CMWttSi9JSnpF?=
 =?utf-8?B?Wkc5dmYzcWVqRHlEZjVjWHUyQ2tCdHViZEtZTUR0NDdXaEkyZFJKWkc4SHBx?=
 =?utf-8?B?aExpNGJNWWdSMG1BRE9ZbGZ1RXlCanl6eFFmcVkrZWlDajkySkRpOEZ0Y0Rl?=
 =?utf-8?B?V1JLYms5YmhsU09QV3lLSzhKTkRYeVlsaU5SUGFMbHQrY0tydmR0NEZxTW1u?=
 =?utf-8?B?RnFxNWFkdll2REp0STlNdklRcTRDZExpWU0zdldtdXlQWUlRMGZ6OTk5WmNi?=
 =?utf-8?B?RnZJTm4wSHZqRjZxUWJmeDZQTWxYcWdQN21mcU1YMnY5UDJTMkdmek9rOWE5?=
 =?utf-8?B?M0QyZWx6dnJRN3FhM24rVUxSV0RBdVNVaEFXNWkvUVJyMnhHSW9MVkp6RU5X?=
 =?utf-8?B?WXAvTjV6VS9mTG9TU0xSM1NHM2pVMHlKdjNEbzNKY3dOK1NLbHdKZEUzK3Vp?=
 =?utf-8?B?SHNQVk1rRm9qNWFKVDUrMWtEZ1FCS01BY3JkT2gvNnEwTkhEWkFZUEdGWHlD?=
 =?utf-8?B?SGJaK0pyVUJmM0Z1dHh0M2ZpbTlSYTNzNHFiZjBlamxHbytzNkg3a0VHYmVu?=
 =?utf-8?B?T3J6SXFGaW1HNkVCdVJVM3VBbzFZbTBuVnNLUnlwSWxUWjFJWXVKWkZwQ3hk?=
 =?utf-8?B?cFpyY3A2NVhQeVpEUVR2WXNTTkMybXdWMnJPYXdnM1hENkZ0RUZvdExBL3F2?=
 =?utf-8?B?V2dNVUtVSGVPYm8rT1IrVVVhYitFNEVscFFmTTRYOFlRa2lTRGdFME9OL1Ny?=
 =?utf-8?B?OFhSalVtTEhyQ21sMzN1SmE3Z1NvemdMaElPczc1TXlvWmZuVjBSTGJJaU9F?=
 =?utf-8?B?Nmc1Rk9pTmQrOUpuSUhmTjY4eS9oK3ZaSWFUVWpYeVhlUyt6cy9adDhYVUp4?=
 =?utf-8?B?MGovckhWM0V4MUJ0d3VxbU9xcGtKNko0cmQ3N1dXUHd4Wjlyb0w5bThQeWlB?=
 =?utf-8?B?SVgzQ0FuazdBQ3RTTWFwcCs1RUpmdHUxckVEcURNMWNLTCtsRjJkSjRLSmsx?=
 =?utf-8?B?MUZRY1VPTXY4M3VpZllYUW5YVk83eHNTR3pWNzhXOU84elQ5SkZPQkkxSWZW?=
 =?utf-8?B?VmRkbU9JWDdjb0xiQmdmK0tUQ0NuTzNSTXNkcFlJUXp4eEZCYTQ2dFdMUUh4?=
 =?utf-8?B?M2FRT3VyUFh4cng5TFVHVzF4cGVJUE1qem10bHlNZTJFV0hTZ3Q0VXBGRHpT?=
 =?utf-8?B?UHZBOTBxWTQrYXZhM0V3R1k2VTFYN0RDdEVTQXFSVU9JdVBTa1lac25hNFVI?=
 =?utf-8?B?cWtZekd1b2xIRTMyOStJYVJqL3dwMHNLV3ZXSHpncXpnYzcvVFZVTUs0TnJR?=
 =?utf-8?B?MlZaZU5xTmRkQkxNRUdtZ2VWWHQ3T2hDbDJLbWxGZm1PWmdMRXBkVzNHcTg5?=
 =?utf-8?B?VXpodzhpZE5sdkl3VWs2NEE0NGhQSlBGZVp2dTNlZTNNeFB2ekZBM29SUTQx?=
 =?utf-8?B?VExlOWhKMmROSXJZWUkrSENXN2IyZkFFQnhzWTRCZGVYbnBMMnhCbnVBcGMw?=
 =?utf-8?B?dTI0SDZiamNFVHFwNUppNEVQejd2YzhsbG51S0xGMkQydVVHdDUxek9GWGVT?=
 =?utf-8?B?ZmhLbDJCdFRXR2M0N2tuYjBPZUY1MEJHS0NrSStFL2NXZ1hHNXovMlhnTFQ4?=
 =?utf-8?B?SEdWYjZuYnBaWTFjOTZXeCtuRzBNSVJZU2x5VUFlVlhnRlZXRmoyMlYrVW5E?=
 =?utf-8?B?Z3NrWDhQTzlWWVNXVmhrUnNTWWoxWGcxbXNHZnhpU1ZRT0tlRjBEK25PRW0x?=
 =?utf-8?B?MmF0cno0ZVFvbWEwUFdNZERsc1Q5NWxvNk4rWThhQlhXditPeXQySU5UT2lI?=
 =?utf-8?B?MkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a486830f-ecd4-4f23-9dab-08ddba2b9683
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 12:17:32.9495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wI7SHwgarn1wuBvGDvQ8rkktoCI1d4IfhK0CVMxkW3jgDUaOwv1bEEGRkQQw9K1z69FC9CKO88v/xmRWhUwjHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7479
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Jul 2025 12:17:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19326

From: Jan Kiszka <jan.kiszka@siemens.com>

No major changes, just to ensure we are up-to-date in case some of our
users consume the isar revision via kas-cip.yml.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas-cip.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index 47c02ec3..6643b341 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 938dab363006529f0b5296dfbc09ef306fc8c3d7
+    commit: 8e3122249a52db470efb32b92ed9c44e4b758712
     layers:
       meta:
 
-- 
2.43.0

