Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4903CCFA442
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 18:54:47 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2111.1763664879465536182
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Nov 2025 10:54:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=EFcdoRsl;
 spf=temperror, err=temporary DNS error (domain: siemens.com, ip: 52.101.83.50, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPXank2oow3G6j/ccbBDzklVqGOPtuzIKZkw8hwfgDeKzGk2CsZds25frlSQDgYMyjpBfT0brVzyDh4tudjt4FhqWQQokTPdvg6PpxT3HYUGSPoOMn2Q77EL1vcc25io0qucT5nc21sjk214IA7INSPZz97NzhCZUV22Vw0WP1Ahq4bfg4OyS3t3Ei40M2EN6iJjH9T/3ey7KQgwMuEr14Oax115sj99gPlBU8ouDYWGFqdOTeZmUm5ipaGQ0fAKxeW534Dz28SwlouFrH44/zw4WAOwRZP2SkXzy4cjyIvh4BQL9U3TkT8WG2nx9dsNA7lsnmt8K4KfgwUHEEflgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BO1HdHgEMwz4pb4JXmTEgzNWiPsj3jjCU0+OBu0gTjE=;
 b=h+/mpUfb9CPRVR9VaPQRUAj8Y2ffyyjIJmj5MzfBkawUNYdTIbb8EjNriPqdxiN0GaCmW411CVvyhRxnrKRQHagCdujJ4sYQvp0KjClTy5vOWjU586XhoUpVGGnicYT2cWYYt7n9XtktWBd/D1a+n7h4v996r+CBk29Nuduuumdo4cHIhd0TRw1QLdx4FJh5wiliEyKimLE/EGf3MbVLZf4GXcb5CoE6isSVNS5YiGuKrUT52dGl86Zq0d9ID6s2NyAIhgLelQw+LwoPTnMNxmhVybRJ6CagczkK2GSS2fFzNiljMVd33SKyL4FjTCwWSRusUF9hzvDbdUQ4us+pWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BO1HdHgEMwz4pb4JXmTEgzNWiPsj3jjCU0+OBu0gTjE=;
 b=EFcdoRslXaoaqEHOZHNYGhPD6pb0kjW712OyOsavwcZNwiKehcknPzilO4cq883dcJr/Yes35p/mIEQIivVay9TN8H+bp3/AtnSSHIz/g58t83Qy+/EflQpBVACxse6WOIdAcZDm2f9tl6x3ImVQKb7+Xjxmzng4k2u3kb946woYr/LNfFdR3P66ZL4FUAFYahRQcCCjSQpprMBA1ItTKE1NvxikkyKM/TzoI2qTI9rFAU9uNCTMrGAjlaIKE8WOcvhO+HmDOD0bS6AIsr246M1jUC3q5CLmYk8oAswFYHgQQHHQbG1LE2i/aI7DhdWMn7JjtSa9qGX1/vpNMnG4Pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6364.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:56e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 18:54:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 18:54:35 +0000
Message-ID: <954de443-156e-418b-aa85-6b36de0d0b51@siemens.com>
Date: Thu, 20 Nov 2025 19:54:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 2/2] fix(security): add libpam-passwdqc
 for debian trixie
To: Gourav Singh <gourav.singh.ext@siemens.com>, cip-dev@lists.cip-project.org
References: <20251120071653.606694-1-gourav.singh.ext@siemens.com>
 <20251120071653.606694-2-gourav.singh.ext@siemens.com>
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
In-Reply-To: <20251120071653.606694-2-gourav.singh.ext@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0291.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b27bf41-9d9b-4863-c1d6-08de28663fef
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TzZsNGhpYkhlbkpzbnlDQWR2OFkwd3dRUHFiN29ncEdHaUF3UFZOSUl1dUlT?=
 =?utf-8?B?dkcyTlkwbVBaQUtudEVyaDkwcXg5UGx0amZIT2duaWZhcFAzVk9wdTlCeHpD?=
 =?utf-8?B?anpVVFN3YUxmUlNqTmJrOG9WZnZVMmVieW5CVDVVeUFKbjgrR3NIZ29JdDlj?=
 =?utf-8?B?aEhYOVB0aXQyRi9TMlZxLytoQVNYUkw0TGh6S1MrK3ljUEQ4ZXJhU2pFYUpZ?=
 =?utf-8?B?eldabzcrOE10aFlocTQ1R1IxLzEzZEZkTnREQUlkQkFOUzJSek83UlEva2tB?=
 =?utf-8?B?aktKZUZsQkRRQ2dCS0l3a2dBTlBQSFduaEdRQlozQVgveFNaeHRZdmtZTUNi?=
 =?utf-8?B?c1hzejVLd2JjUG1SaTZ1azRnS3JLV1prUVh3QTN4SXR2dmVWM0FKRnhQZHRm?=
 =?utf-8?B?cnJlUWRtczNLSlJLVmFYOXEzOTRVV2NkWnhudksxSEFCNkpyb3dBQS9WR2s4?=
 =?utf-8?B?K3ZYNTlVUVQ3QVFLMnF4TVhxdlBucTJVY3RPeGZoWkdDeUMwN3RDOWdUd25G?=
 =?utf-8?B?cE56WkpTeTEyTTBpSmVHTzVNVThZTTdCaWUwMGZYZUU0c2Y3aFhxQlNkWm1w?=
 =?utf-8?B?WjM4MGZiM3lHVjZ3YTdqbVhNVEdRTzUyaGNnalFsOTlBU3BnSUY1SnFiYzRm?=
 =?utf-8?B?a2JCbHpGSndsNnhmRXRKK3lkRzZJVzFRai9WTXVKZ25xZlJrcEN1eDNaNUNY?=
 =?utf-8?B?WFhTTDJ5b2ZveVNsUlltb3cwMVVYMXFvYmsyWTJ4ZGw4NW5qWWU0RUZiaU9E?=
 =?utf-8?B?ZnJvZlErS2pDWGhLT2phb0tHTGRwUzJHNWE3Uy91M2oxUEo3dHBYa21hVFV5?=
 =?utf-8?B?WnUxWTJFVG14TlE0WllId1ZwMFFiam0zWjltRThXK3g2VzhwSkZRTDhYOXdZ?=
 =?utf-8?B?RGxSeHBaaEFXc1RYUFRIb1laSnQxNG5rN1k4R0tTeHhTdmZBVmsrSXBHbi83?=
 =?utf-8?B?T09JTXRnd3laUGpicGhDVjJBeGNXZjNqZjZXaFBXcFBoYVVuc284ZmFmZFBY?=
 =?utf-8?B?RSt5ZGVyR0FiVnRHZzRyQ1JKZ0x6WFEwa2RHTStTcVR1Y2ZqdUxZak80ekxH?=
 =?utf-8?B?bnVOWUZGZTZnOHJ5YnV6UWx3b01ncXBGSjEwTVBDQVZkRjhQRWM2WVhDaWRW?=
 =?utf-8?B?WEdCNFU1TlNxMUxoa3NIOUo1OWlURitLaUVUR2hVMUU3dFBiaytrUmRIUllz?=
 =?utf-8?B?eEhnNGZyblVMaFMxdjkzL0NxU0pKUVBPYWNXMDJZY1VXa3NjYjlWcnArQkhk?=
 =?utf-8?B?RC95K0RVMGVSck9melkzRUxwM25VWTZpVTh3MDhpNjhiUEhLdUVKS2VvZjA5?=
 =?utf-8?B?Ynh6RUk4QmcxMXc1c1djQjU3WWdHTXI3RXllRlBOV3MwR2dVR1Ira3BjeVhS?=
 =?utf-8?B?T2dCS3Baa0ZmeUNXSXFXM05vaTZFeGF6N3F0cVp4ZTkrclNmZW1GTThzS2Ry?=
 =?utf-8?B?ampFQjc3VlA4MldNaWMvTVp6TmduN0dFNUNqMkVKTGZXYnlHalhnbi9tSTZ5?=
 =?utf-8?B?allXclJDYzBIQ21qL1VSSDdWNnNFcXowQ1daY2JjQWxRamZuZ1d6WXl6ZFRX?=
 =?utf-8?B?akJna0RQNGFMaCt6eEFBKzRXZUxNaGowZFBlbUtJeU5sN1VSQXU2MkFXYzUv?=
 =?utf-8?B?bEltaVZ2RGNxNnBpc3dxODRNb25pSkJrOEptVUpka3BLUmc2cit6bzJhYkxI?=
 =?utf-8?B?U0FRYzJoSWlTTlhDbkNIU1I3ZGdvbWpTWkxyYzEyVUdBdVVkYlVTUEw2Wm0v?=
 =?utf-8?B?YkpDeHBIUHZ1UE1TS3VPcjVCdGFERlJ2MlNVbmVuZ2lKTUo1MFpqS0NET0tW?=
 =?utf-8?B?OXBrRmdmSDQzbHJVSEk0TElJVlRiRHNYL20vVHQ5Z3d2WGlrcVdrc0VuSUMz?=
 =?utf-8?B?MGdYaWZ6cVI3aG1adjhPQnQxU2ZRYkJkYk1jWEdoL1pSTVFDRWJwR3Fub2Ur?=
 =?utf-8?Q?vMyxpul6QS2YvREyJoqnTVoJrqLFL/+Q?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Zk9IMTN0cW1tbnY2Ty94SE5xc1RSYXRJVkpSRWRqNWZMY3JQSHZnVXgrOHhp?=
 =?utf-8?B?UDlPVDJNUi9CWW9VbWRYWkRBV21sWUdEejBQQm5vcWVpbWY3ZU51V3ZDRlMw?=
 =?utf-8?B?Z2VjaVFTZXJReElMditkVDhITzcxMkhoOFlvbUpsdnRnMHkzOEtHa1NlRElY?=
 =?utf-8?B?ZFFETE5ES0FZUGs4UlMxMFZuTVpDS2RmWUFSQ3R2M0VXK3h2eEpHd3BYVGo3?=
 =?utf-8?B?Tk9iMVpJM3BudzBGayttVndXcVR5a0hyTlpveDN4NTFpaVhRRWY5c3ovZjVo?=
 =?utf-8?B?UTNRaFgwYWpuc0cvV0h1b1NpZ3VjS215a1JWWGIzSTdjVHc3SVo5SXF0dnI3?=
 =?utf-8?B?Yk0zMjFJRnhzOW9hMTN4dUR2cXlzUjNmSDlVTy8raERZRXYwLzZ1MFp2eWNo?=
 =?utf-8?B?dlAyZ3NFS05Qb1duYWJuM0VGMFYvdmFuNzFaMHRnYzdqM1JKNUNVSDhhMTVP?=
 =?utf-8?B?bEtZL1AycW1TNU9Cbzk5d01KY0lQL2lWK21lVDNWK2R3NG1YV2JmT0lGTVJN?=
 =?utf-8?B?dkRhUHBoK1BFZGlRZGFKa1VBOVdPa2dqUjZrY3AvenBOWCtHSmVESVh1QnJX?=
 =?utf-8?B?c0JTbjlDZFBGckFZS3VEaEtNRFJBbTVFZEt2UkU4OGlSR2RnRzF1UXNyRnZR?=
 =?utf-8?B?a0xvU1lnU0s1OFc4Y2toeFBrU085dHd2Qll1TGtTb2JLNlQ5S2pJZUkxWDQ0?=
 =?utf-8?B?RHdyUnFGSFVSY2pPVmFUVVQ4dGp6K0hrMisranRQWDl6ZzFoRUJxMFlFUTNu?=
 =?utf-8?B?RHk0bnF2MlJHcGpuRUR3RFNSbU9lT0ZFY2VFd2ZvWlFmY2x1QS92ZVBqMlQr?=
 =?utf-8?B?ZFVsUFVVT01XelkzbkdSSGNVemMvV3VOTDJVeW5adzFzUlVUbTZ0Tm1kMWNz?=
 =?utf-8?B?V1ptd3RkZUxzYUhVYnhaeG9kUVFvd2p6RVdPTncrS0ZyUXkrcE52SnVBYzhP?=
 =?utf-8?B?RkM5RXZpeEV6eVlZN3FyUDhsUG5qVXBrUWFjZTRhQnhLMlkzV0x6dlJWRDRi?=
 =?utf-8?B?OXNld200WDlqeURsL1ErZWV5Zk5ndXFaZ3dpOEdEcFJ6TENNR0RnMFNxWnBO?=
 =?utf-8?B?U3V4ZVhGbHVMK1JWbzRwOUhNTVZxekd5Q2p5ZDZ2b1VxOVZjQURHVWdaSmMy?=
 =?utf-8?B?SS91TGtBNkpmM0Zabk1oOU1kV1BEUmRHMWt1LzhKb2lrNkxUaS8xVzExV0Jx?=
 =?utf-8?B?c3luaXcrR2lCTXVWczU3eXg1ZTFnaXZORnhCckFQZVhwQmo2Rk5LNGNpaTEy?=
 =?utf-8?B?WWpGQW1lQXc2WXE4dndnTGlraTdSRitsMllGNGRraW9DamNvbUJJVDNIZU84?=
 =?utf-8?B?dWJqTmxrbHNuL0hwc2ZpWDRhU2V1eE52ZFFOT211ZHZmbDd5TEpvay9mTGt4?=
 =?utf-8?B?VWptQ0VRZEV5Y1lqQVZIcEZNampIZnNoM0c1bkxKNzE3MHpNQnhSTTZPeC9N?=
 =?utf-8?B?WG5vV2N4TGlFaE1nbHpxUnp2cEVsdnkyNENNaFpjemI3SGNsYnB4aUZ6ZkMv?=
 =?utf-8?B?cE9neCt3MGVKSm82ejV1VnM2a1p6Y3pIRm1TUFZ5RDJpbjFWSXZCNTBFZy9E?=
 =?utf-8?B?dVlRejRqeDFWb0srT0llVk9sSE45bXlxUW83OXQ2dFBlZ25SL1c3aXZCT1R5?=
 =?utf-8?B?WDRCa2l3a3FKaDVaNWd2NHBOZGRoNk1aRmU4TFBmRXVhaDQ0U0hEemNpejgy?=
 =?utf-8?B?V2Z4WFdDYzcyb0lIbWsyeHI3UXVCYnR0am93SEMzczVxV2tnM05FNlBmRWUv?=
 =?utf-8?B?RTVXWmZ6TStMMVNyNEx0R29ENkh0VEJ5TTZ5eWk5SjF5UXZRU3pEeFp0Mnpq?=
 =?utf-8?B?bkR4K2hKaGsxMmxLTEVJUVh2TXk2eFRFaW4yWkF3WVhRcEFKclZVK1M5SjVp?=
 =?utf-8?B?QTdzNkxZQldYeFJRSFM2MFVFVmN4ZWxRR21qZ0hlQTlnS3dFZGthVEg1UG9y?=
 =?utf-8?B?b01pQTlBT0cyaDFZelpEUHBwQkUzMStBSXFVc2NlL25RdEgwa0IzK0kwcWxq?=
 =?utf-8?B?dkJ4SUhSaEVjSlJydCtMQzJ5aE8rMW5yMWlYMUduTTIrOGFVQVlrT2N0STVx?=
 =?utf-8?B?RGNoWndibkE0VDlMRjlmWUViNGQrUFErdjhWaUs2WG5jQU9ORUFlVUg2L25l?=
 =?utf-8?B?b2l5TE4zUlJObVZGb1hoWTdGR3M1NDdIZGdtTFZldjY5L1dwa2Fvd3B0OHpi?=
 =?utf-8?B?c0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b27bf41-9d9b-4863-c1d6-08de28663fef
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 18:54:35.9022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ReDARev9uTz1cE5cKyDZEi09a9tcAzzvjJwn7OGWRupLfr7I4sRW0nEs9R7Iy8zDWeUuZrg8/UeU2qqKZ4LLEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6364
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Nov 2025 18:54:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20660

On 20.11.25 08:16, Gourav Singh wrote:
> The IEC 62443 security requirement TC_CR1.7_1 (Validate
> strength of password-based authentication) is failing for
> Debian trixie because the required package `libpam-passwdqc`
> was not added. This commit adds the missing package to ensure
> compliance with the security requirements.
> 
> Signed-off-by: Gourav Singh <gourav.singh.ext@siemens.com>
> ---
>  .../security-customizations/security-customizations.bb    | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/recipes-core/security-customizations/security-customizations.bb b/recipes-core/security-customizations/security-customizations.bb
> index 75a6a99..717e2d3 100644
> --- a/recipes-core/security-customizations/security-customizations.bb
> +++ b/recipes-core/security-customizations/security-customizations.bb
> @@ -20,10 +20,10 @@ SRC_URI = "file://postinst \
>  DEPENDS = "customizations sshd-regen-keys"
>  DEBIAN_DEPENDS = "customizations, sshd-regen-keys, libpam-google-authenticator, libpam-modules, libpam-runtime, auditd"
>  
> -# Package names based on the distro version
> -DEBIAN_DEPENDS:append:buster = ", libpam-cracklib"
> -DEBIAN_DEPENDS:append:bullseye = ", libpam-cracklib"
> -DEBIAN_DEPENDS:append:bookworm = ", libpam-passwdqc"
> +# Append PAM module dependencies for password strength enforcement based on the Debian version
> +# - libpam-cracklib: Deprecated, but still supported in Debian Buster and Bullseye.
> +# - libpam-passwdqc: Preferred for newer Debian releases (post-Bullseye).
> +DEBIAN_DEPENDS:append = ", libpam-passwdqc | libpam-cracklib"
>  
>  do_install[cleandirs] += "${D}/etc/ssh/sshd_config.d/"
>  do_install () {

Thanks a lot for these, both applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

