Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3155CCFA18
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 14:32:18 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18845.1762871536065739255
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Nov 2025 06:32:16 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=o8Z05Opv;
 spf=pass (domain: siemens.com, ip: 40.107.130.56, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ROccm7SS77uHYYrwKPOAFyLlHVULuym6OY1Y0mg3/jchafv3bda2dYR2QfQela7WRlim+SkK7ItbQKOsXusnsqX1bHoH0W7M8Gv64zNxldvsysYqmpTDniQwqMhLqKdBs/yIuh0cvnMOEP6EkAI6tYAW9P8q01vu58pUmC7+AOMaPC7HVLLAyQZWjswlInja2lGW5GZ4W7SPV+jOmjvSUqgGq1j6TlY10zGjBI7D6bwWtGmE9gxYtFl9JcV4EHkBxShsNv1a0bhJMJxpNc2OwTDrUJhJldlkHlE2N37r+uh111+Vu0BIckpFtj3+43JBt5y2QoDBqSa4QEZnotK/Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vw4weaa1tV18gJrVnjnBVulcjJ0pfXSYdK1i9E0gdJg=;
 b=CfIy6C2g6s9FMI/t59Q6zoNlWHwZkgWUCESBrvIK8U6pNObw/5AVf+5+AhW5jE4fIHOTaJsRGmOVSbouAzFfI39RkgZsVKMVkoSFKSqcIIJxhUCiXbmHSQwzIJaWbFKV2nPstnLJleTHdQ6BcaMrowi+Dl5xnbX0MHKoNf8nUuM3Fh4XzKR6ZxfBnyzmcMMFii8l1IL6s7U9QKj7tVlHPVpECALTB4ICIcuvFPMo0f/ndtUUe4T/EW4aS3QV6pQvalinP0RjxgvCrQOvxssVfgUK3gwe/bCYIe7JlsJqMwKN5gtTbej/AT4/MxlHkGhNrQG4SEloSndzodBytcmIfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vw4weaa1tV18gJrVnjnBVulcjJ0pfXSYdK1i9E0gdJg=;
 b=o8Z05OpvVnrEUHF8vQQ8rLeSrGr1DI1IsET3DwUI+qNiToEYWFuWFznh/sxVYi0UxOCuteXensr93lHxCLkE4iYhObuO/lOL/T0uLIoUWJNNwccLmI0LZLqBVzjdPEWjbdHqRvfwHKaSu7XZw18+UfU1ftGPPEEFC8ExzJG/E9ufJB47xzqTngby4VjM35yfnSi3x+KU2Ma8Q51unHsR6ZDoAG4hyj9suASTWQZbu8S5G3mJBIB9mpYg8bMl5xd0csi690XXhLLnGr0Bwhh05plOrcs8ZvOKgJzu1eDN+lh2l/GtiGMQNpWKqo4NVkUFvb0r6ffnmX+b9NnTV9eX6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5615.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:245::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 14:32:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 14:32:12 +0000
Message-ID: <d4e17e5e-404a-4106-96a5-c875100ffef9@siemens.com>
Date: Tue, 11 Nov 2025 15:32:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] swupdate: generate reproducible source
 tarballs
To: "Hombourger, Cedric (FT FDS CES LX)" <cedric.hombourger@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Gylstorff, Quirin (FT RPD CED OES-DE)" <quirin.gylstorff@siemens.com>
References: <20251111101231.143022-1-cedric.hombourger@siemens.com>
 <62a8ff54-596c-4a18-9b09-be0c7cbe4d6d@siemens.com>
 <1efa7ff43e8a5fedb5b4174979507802ee66c651.camel@siemens.com>
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
In-Reply-To: <1efa7ff43e8a5fedb5b4174979507802ee66c651.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR03CA0068.namprd03.prod.outlook.com
 (2603:10b6:610:cc::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5615:EE_
X-MS-Office365-Filtering-Correlation-Id: cca31353-030e-4d5c-0709-08de212f1a22
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?BEQrJmeRrJ/0zVyb5wwT4W7ksHZvPDl/Ngm5FGPHMzFmZnEQ94QxRfuMIlEz?=
 =?us-ascii?Q?qq1XSZWRh8w5zvwG2/8agpNEHeI2YnVdpOVowNnOZS1Z9BO8i275MCwKwOC5?=
 =?us-ascii?Q?ZPbzUHqnRyugffGAdif9a1u4zFRJj0PTv2Xk7QXLblKT6Em8xiB7ELp75O46?=
 =?us-ascii?Q?iEX+49MKsiAAy2zP0GuTlTgiEJqimzKi+IYrb1lktGDEzHNP+vD09Sc0qdXU?=
 =?us-ascii?Q?xNCKltbNHiZG+IJRa1t5mXrLg4o1JjeWG58MuVwz58BhJzQ8FknD5tlYGuW6?=
 =?us-ascii?Q?k5IN4uj+PZg5tVMeYOVt/qAdRa5qqaFnAFOjrhR42vuhD2t0NtN+fQ1thg9G?=
 =?us-ascii?Q?FSCEGMQTx173LUCW6+oNQ0Ld2Z7qKibUuo4QO4OTyfPfh6G2UyXYemN3EPDB?=
 =?us-ascii?Q?09Dj9XIDa2EVh3NNt4KKHt5KGHydQ6u7kqmX8Dksdfp2NgtxXTGuvSbg46PR?=
 =?us-ascii?Q?Ogt5rUIfDC9/fDA7lFdb1LUGVl45FHjAd0cNwfkR2PodMheW+X7PX2F+rufJ?=
 =?us-ascii?Q?XRxUH5b/wYprqPde3iSUH67ZxrRuhTLsdm1CzFIy42NvBYTyHD1e8VRvXLmP?=
 =?us-ascii?Q?yqTpU+7K2qp9qzrRaMWbxn8fyEOwDmRCNPT9mrtRkKEfh9YFjZ2i25kjNrEz?=
 =?us-ascii?Q?j6qWxJCpY36B3ZAOfFVqU3BOSvG8fBx6OUayXblH78Swv5TZrF0EO5vJ43w3?=
 =?us-ascii?Q?ujbLHlPZyjft1GIO4yzOdemP47y8CHuzN2FZ5FYFOx/vF1MyHH6JX1bpvzGu?=
 =?us-ascii?Q?CEXZcdq4ciEZoWvkbJHARCUGbfyyjBqw5c1AVSrozoOguBd9F3gHpMAOwD18?=
 =?us-ascii?Q?TA9g7Fcl48e+fhidvqre3bY5oySIOP2c770d6A0WGPm1TdM6xSjubAiIF10T?=
 =?us-ascii?Q?FFHxPXx3zzy9wek8DIemN6fb5SzUA1uTtSdHYSIubHOXkzxKWgDxEPEQTL3r?=
 =?us-ascii?Q?S9GnisNfAydm3LrzYLUJQh2Z6dkhESNDPMbKaaMBBkUzoiNesAq7xil4tFyF?=
 =?us-ascii?Q?G7LYk0GAlmXGpVGyLi+vgdz5E2aqB22Rg/bj/zWkPUEJ8GCaQurqOCYw03Wm?=
 =?us-ascii?Q?zR8nzUevV4U9lXPKz/zldC2GL7XyS63wJMV9EFN3xWT2nCe1aEMFTRXJpUtI?=
 =?us-ascii?Q?VSWILztdTgABAxkjTHKbFS4XDy0rYtmFV6UBNAG2wAfKJu8utX6VKLY1jwGS?=
 =?us-ascii?Q?QNu+W0vUQspmDgEctWGfzJbjuwELQsoc4mj6mv3LYsajqx7F3mmoV8Zc6G8V?=
 =?us-ascii?Q?xmjbbUJsPEMam3rhOJmLnjYBr32fNlYXXmD0vmmUdbjk+3UuZdqmdf7sPr7k?=
 =?us-ascii?Q?5Kis4SWIPbyn8f5fNnKPcrH7hdgXTdfIFYMjQ6cVCTbFnXK+SLfQHpxEeSrn?=
 =?us-ascii?Q?8C5Y/lBBOd0MRpVkRxGKqqiLTnQB/UUwLEdPPlOdDViQEYWDtHMvHYfw3bb5?=
 =?us-ascii?Q?GHL/CAoWixm3RAb5K/DcRYaX1MHjH9t9?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?TWkWkhxJT7z6g6y7DZjq/aXxQwv6ozP8fEXobCsqo9bfGaBqYtwQj1atGeqU?=
 =?us-ascii?Q?y3UEst6yW7mpQHMT1oXnXlO76pPzQ9RZySV7O2rmP09Y7tDPJyy9usPj9xYd?=
 =?us-ascii?Q?lzq+ze7tDQ9RSwMmE9n9bzdDcsBWXUSFitkwcvrco5BcanuF4PVtn0yu/i33?=
 =?us-ascii?Q?v5qQ2VNyLjgUMcjuibJjfVHcSnx9Ys5N6p0htKK2e3OuNqVo33ji0Ro2+Tt7?=
 =?us-ascii?Q?WSd1sAAn6DArIqH2tzW0jKblbTAF77UJbTYqsCRAUAt/kuyXddDYj7q8/zmM?=
 =?us-ascii?Q?vsPVvGmtC6WDzVqD3evLxQ7hzZ59jo/emAsYu1Yykrmm1xmpiSCqez4ctC2H?=
 =?us-ascii?Q?x84jDjdE+uvCPlb5JAfAuVjmFmzAKfJ9PdXZBwZsd0nCS5Xyzjno/N0g9oiw?=
 =?us-ascii?Q?jP9CFVJw1RK/UBRlJpZKK3Si0Dt9aALnpEOohldDQJ3ntBDeOiqQa71Chtdd?=
 =?us-ascii?Q?E248z3AjY6bjlQHw4gfYpW1uwnX6WydB66IWUPNtZf7mH0pZGhPNrgWjyXTz?=
 =?us-ascii?Q?BCR14aZjH4vyp2L5jm9cLhPFqmQkWWQxHGLvLKccfqeOkiiKByL70RN3xyrJ?=
 =?us-ascii?Q?kSG0Z70yaapmrdpRtwktV7XEs/+C+NZNCwOHmH7tkKNcMse+M8GuYr+wKgm/?=
 =?us-ascii?Q?6DuqKD1Hn5CMqvFqKjZd4XX7eXt3qanlKEqxSW+jP/09jtvxOW6iY7ethKeT?=
 =?us-ascii?Q?yIcz1yQxDRp/+a9qBaSdkWWYdLFkG7IlcBB/P+3iY4s7XcyHAZxU0fq1klQM?=
 =?us-ascii?Q?Xver9fNTpvqlL+avl0q7PmPPlgpwmz4vaoLA2VMYqbof75NHXbo3CExFTNXC?=
 =?us-ascii?Q?OtdY6IXsNMuQ3Ol4kk7js3D1k2l/0i2vjg6rgnhvvBNngKuuUShpbS9q5CMG?=
 =?us-ascii?Q?mDpau9xJIoJUVNtbFW/O5yuRdK4xN1PzyihsMGYoD5K97ek1knCkVMEN7cR6?=
 =?us-ascii?Q?BFCYyDAUDhrPEGa/Uitr04inl+BNOUx4UBnuF6b3zLTJuGBct56OnJ/tGlAX?=
 =?us-ascii?Q?r0XtQgG5fpoq7BJAB7980nk8VXbO7aYH9IBF9QaBdQg71Wejvze+qTgP7nrg?=
 =?us-ascii?Q?ebfGHnQFA0wc+byh4hzIDXKnJfbatfUP+TRahWXiMkqcbSzFpFoTMubxnJzf?=
 =?us-ascii?Q?qR1xkz1BQqB2/7HRfe44XAJKB6v9iZFoFkK86uVI/OoWo2MPw8YlD1ipi0B3?=
 =?us-ascii?Q?AYKI36D3it7BV8A/MLC5eb6OyGA7tRH6Do7IPh5fQHqz0/T45oczVdMq3kAC?=
 =?us-ascii?Q?3DPxWhy8ZD/9WlmdYrZCWfBwnRVLsSnIbvEZdqyAWP1+eO/OFRYK8C6Xe1t1?=
 =?us-ascii?Q?Njfdfx+RNYJGQNRmtVdwdxol8tKg5KevJU16UjuPP1qario780tBocNGfVm3?=
 =?us-ascii?Q?T+MrOY8sjgjx9+rXQsuf7//6Lau/l1ithS0tfCSDwfHpjSuxgdoYuF+CyddA?=
 =?us-ascii?Q?PnJu2Jxt5YOWrb8HiUB8QrCkSYEBDD7s7LpXH72uuvwHjhIwayb5wnbwp6Qi?=
 =?us-ascii?Q?5c8O6mvYP7i5UX4JbrHVf7DklpkyjfGS+vAk5l/9W0j3rZghI4m0PNXu/oWO?=
 =?us-ascii?Q?aLHt3F4GBM7EK5YjBbgsxZo58pk//xX8gBpquBaBB7TmNRAAwn+DCg2fqQLz?=
 =?us-ascii?Q?TQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cca31353-030e-4d5c-0709-08de212f1a22
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 14:32:12.1111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bsw2oM9hOJdjjETFdnX5ReAjuRpAnVF2gvgeU5I1/ocpiB6Qhlm/i4JGnEhLwL/gu0xc/m3rDqHc8tzH5vqaOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5615
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Nov 2025 14:32:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20496

On 11.11.25 15:26, Hombourger, Cedric (FT FDS CES LX) wrote:
> On Tue, 2025-11-11 at 15:03 +0100, Jan Kiszka wrote:
>> On 11.11.25 11:12, Cedric Hombourger wrote:
>>> Apply additional options to the tar command used to generate
>>> reproducible source tarballs: (1) use numeric and null [GU]IDs,
>>> -clamp-mtime for file modification times to never be later than
>>> SOURCE_DATE_EPOCH (preserving mtimes for files not modified by
>>> the recipe) and --sort=3Dname for consistent ordering within the
>>> archive.
>>>
>>> Signed-off-by: Cedric Hombourger <cedric.hombourger@siemens.com>
>>> ---
>>> =C2=A0recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb | 6 +++++-
>>> =C2=A0recipes-core/swupdate/swupdate_2023.12.bb=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 6 +++++-
>>> =C2=A02 files changed, 10 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb
>>> b/recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb
>>> index fcccc2c..b5becaa 100644
>>> --- a/recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb
>>> +++ b/recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb
>>> @@ -37,5 +37,9 @@ CHANGELOG_V ?=3D "${PV}-${SRCREV}"
>>> =C2=A0do_prepare_build() {
>>> =C2=A0=C2=A0=C2=A0=C2=A0 deb_add_changelog
>>> =C2=A0=C2=A0=C2=A0=C2=A0 cd ${WORKDIR}
>>> -=C2=A0=C2=A0=C2=A0 tar cJf ${PN}_${PV}.orig.tar.xz --exclude=3D.git --
>>> exclude=3Ddebian ${P}
>>> +=C2=A0=C2=A0=C2=A0 tar cJf ${PN}_${PV}.orig.tar.xz \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --exclude=3D.git --exclude=
=3Ddebian ${P}
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --mtime=3D@${SOURCE_DATE_EP=
OCH} --clamp-mtime \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --owner=3D0 --group=3D0 --n=
umeric-owner \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --sort=3Dname ${P}
>>> =C2=A0}
>>> diff --git a/recipes-core/swupdate/swupdate_2023.12.bb b/recipes-
>>> core/swupdate/swupdate_2023.12.bb
>>> index cc01a98..50df215 100644
>>> --- a/recipes-core/swupdate/swupdate_2023.12.bb
>>> +++ b/recipes-core/swupdate/swupdate_2023.12.bb
>>> @@ -50,5 +50,9 @@ CHANGELOG_V ?=3D "${PV}+cip-${SRCREV}"
>>> =C2=A0do_prepare_build() {
>>> =C2=A0=C2=A0=C2=A0=C2=A0 deb_add_changelog
>>> =C2=A0=C2=A0=C2=A0=C2=A0 cd ${WORKDIR}
>>> -=C2=A0=C2=A0=C2=A0 tar cJf ${PN}_${PV}+cip.orig.tar.xz --exclude=3D.gi=
t --
>>> exclude=3Ddebian ${P}
>>> +=C2=A0=C2=A0=C2=A0 tar cJf ${PN}_${PV}+cip.orig.tar.xz \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --exclude=3D.git --exclude=
=3Ddebian \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --mtime=3D@${SOURCE_DATE_EP=
OCH} --clamp-mtime \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --owner=3D0 --group=3D0 --n=
umeric-owner \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --sort=3Dname ${P}
>>> =C2=A0}
>>
>> Seems this pattern is limited to those older swupdate packages, at
>> least
>> in isar-cip-core. In isar, there might be one similar case
>> (libubootenv)
>> - and couple of them around vm image generation.
>>
>> Back to package customization: Is this way of generating the orig
>> tarball the best approach here? If so, and given the longer list of
>> options, shouldn't isar provide some "reproducible_tar" helper that
>> adds
>> what is needed?
>=20
> good idea. could definitely propose something and demonstrate its use
> with libubootenv.
>=20
> would you apply this patch and take the rework once the isar helper is
> proposed & accepted? either way is fine - this is simply to understand
> what my next steps should be
>=20

I'm happy to apply this patch if the original tar pattern is the one we
should keep (for now). Quirin?

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

