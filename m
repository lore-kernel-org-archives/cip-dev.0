Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DE2C531FC
	for <webhook@archiver.kernel.org>; Mon, 27 Jul 2026 14:45:43 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.28])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32975.1785163541161519912
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2026 07:45:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=zwJUtH3l;
 spf=pass (domain: siemens.com, ip: 52.101.72.28, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDGq5vA+HHmgekpK09QTh9JJVMWQwuOdBpIj86BRkGFuhZl6e0yarjdc8QJvHg7tCcogL93DEoZ8w894HLsmoLgxtkkbD9SVY9Bzle4cq0egv/gKe83e5IRqBtOtwIlWfwta3GFXhGrXXfjoe7psLKJnk+IwTjsNs52WZHiHnKei3SQSZI6AtQjyu6Zmgt+DgFVAdWZcK03InTPxFbUpBd6JnRtbt07/l5V2XdMqJmuusNqd8zuJ+KjpPKGDIt2GAeGcBLR0UqNie5DTJRYagZBcXq+idUfI+vJtt2HNo8FyWaUsBPUkX0ugSGwHZq7LeC07AAz6brL7vYhV0kyVYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqwznbvCQpHEmlqnVGF9CV3g1lURySMZjDYSCBRqiPY=;
 b=nV+1Cbhgf+ytXoXxsQHLmKn3gaSTADG/zTUK3VrnzdqgDVNt1zsdpHOv2i3b5V1qmmvzH5nlneVRMl5ft9vcKoVy/Hrs/To4CAooHSAMq5l1NElcbrPR2jcK5KtqYvOoiVymo8UNF3m4WulE40cAbToKFxID21kfUx/UycQgLW0MhqQepPnTXkPbcmxtk6tGrro9NGC39w1j+1q7SSptQxp2hT5Vz1f7JU0M/7eVXv2Hr3jEw62wfzMhA8LMFVE/ZcJEinu3TcXksRVSm5O5+Yzc2NXHLqOYcT+lzLVDA83EICCaSUBDm3AzGcM62cAqpFxSjTroNixRtEbCIq7vEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqwznbvCQpHEmlqnVGF9CV3g1lURySMZjDYSCBRqiPY=;
 b=zwJUtH3lPl8omp0GhujKsT+B8wFCTP4++/HrJJTiUGD7m7bkQFS2sT81OHtnuo9rqE4ES00Np7thToNJbjkFEJhdb29Z50CY+z3RAQMpRP1/4cqZpai79Co7ZG1260wZs7ju/5REZsmmP3MF4VTOj/p5VhZhc6mJRrZ6BHo1TtJlvraOiEiIMFX5ryF6OmgzeA29AR9d6+GtVAqmbhh2EbHpeHYTeGWNO/WgoL4nUNBFB5xjd+uehLOws1fDCyGNWY3BIC21c1TIYmsgIyqy5/quRg/cwAZuC03ywv01sP6uzRlUyZObORsWcr2fov3jq5T4kHRBFqAZ8AoajlodWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB5PR10MB7704.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 14:45:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 14:45:37 +0000
Message-ID: <3d7f3eb4-f298-433d-82b1-60dfe7c2697b@siemens.com>
Date: Mon, 27 Jul 2026 16:45:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC cip-dev][isar-cip-core][PATCH 13/14] Add Kconfig option to
 select cis-validation
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com,
 christoph.steiger@siemens.com, clara.kowalsky@siemens.com
References: <20260724124038.3633611-1-Quirin.Gylstorff@siemens.com>
 <20260724124945.3636668-1-Quirin.Gylstorff@siemens.com>
 <20260724124945.3636668-4-Quirin.Gylstorff@siemens.com>
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
In-Reply-To: <20260724124945.3636668-4-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0295.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB5PR10MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: 72077921-3d0f-4939-1ef1-08deebedb8c2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|6133799003|4143699003|56012099006|11063799006|10067099003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	H50FoLXVspKJZj5Vb4rRyhk4it1VmZckwECgNHsJancj1ZKpH3jWP+jzEA8/h6TF68dm1j1B4eIMBCk+PpRGK5E2JnU5UsRbGcyDNp4qlgEEaip5fpr7f9MTl2LUS+K/HomMiAFHA36/JnBtxLHlS/x1iAzXftLkyz5Fbt/ktBHf12wQVSUDZuYWvXRy8bisugmdnCI4JQk5buOSy6MwW+Xm+50Ma2kuLpv2yGbkBcwVWylcZIkCeExlP+rjPuxfFoJZtfV2FEyIp6WxSe5vXFUriizz7aHDbL51TJ8QpoEaRK0KkRQhzwwx2ETgv1IThsBCJfMGf0H7/4dbtJSY1xbnUUXGQTh4wpT1fsdfmXcuxGvrMu6rF2eUbH2CeN37gfJWCOg0aMLF84s0aLPCDQcNyKoKKNa0868lO/JTskvfp8mhPz1Ew4sPvf2A+J8/EbwKthD6ktdB0/e4bl+zKxYe9VH3hEzdDeGT6Hu22IrsXwWmm9q4cBq/fb50LcFxlpBrCXs4OdR00SPWngGyoir07V1euNZfl8sOGuUF2fXSLcXNXl0ilwFH6AgrdyRXmZljhj2RehlIK740jtDI9YbMrg/e93Uey5TDICRPNii46XSThGBcbNqONPzAT/RiBllUG4pHVxHpYxy7VMcjXcjUDmGY03+899G6N0ud4h8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(4143699003)(56012099006)(11063799006)(10067099003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NU5HZjFrcWR2YXRhY2pDVVBJN0I1dEVpSEo3cTZySkNkRG9iOXFDNlh4cmxO?=
 =?utf-8?B?K1VFUnpwNUlraU9iaXp1VWtDYkkxaDdNVEJ1U3BvS2kzOXoyMUZzSUtVQSt4?=
 =?utf-8?B?Y2ttS2pBRmxMbnZ5azhtLy9yR24ySGtEclJoQnJWWTdjOVd0M2V4QkpkdkZT?=
 =?utf-8?B?Q1JhcnlSaXVmV081OWdBWjhOM3VGMlIwcE1SR1dxWjh1ZHBhc3BRT2QvK201?=
 =?utf-8?B?bW9zWnN1VktmejRpTEZxSGNWSjJ5MmdqZGtYdHh6bVhBQzVrR2pHSUMrdGdT?=
 =?utf-8?B?SmxabFFxUFBwMGx3TWlocnloMGluSmVTbDl1SXRKMXBIOWtVQjN2YjJzc09K?=
 =?utf-8?B?eFo2M2VWWkdtMjQ0Z0xKSWdKREdMd1pTRWcwNWJZVWU4Z1ppRGphMEVMMTdq?=
 =?utf-8?B?cHQza1ZsRXZMTG43ckthaVZrVlBnUUh3YktZbHBCakZpTWJobENqK2NLZ0xI?=
 =?utf-8?B?amNDSjllZEcwcklGTmhxT3VJMm5nQ0VyUnF6eC9GY083bzUwdWFUejFmM2pj?=
 =?utf-8?B?TGNocTZMT2w2NUFQM0FidkNPc3NHeU54RmhXNHZac0tzWGpNYXljOHdEdG96?=
 =?utf-8?B?UUY0RWh6QmFUS0lSb2FkUUJDM3c0UHBmanZNajUrZlZNQUdvM3YzRkw5dWJx?=
 =?utf-8?B?U1pXY0FJZ3hWYVpKMUtSY3MvdHpIZ1NEekdzWWZVNHpLYURIM3JDSnJyeW9E?=
 =?utf-8?B?RTUzZmgvd3V0T1Z2WHI3WEVxKzBOcE5yMnRXdXBYdXU1QVkyZVQ3amhSMlVn?=
 =?utf-8?B?MjhjTlh1cUl0RTNteWpEbTRyeEZXZkpJRlBtalVlU0xmT0N6RXhMUFdaaHlk?=
 =?utf-8?B?eUEwb21pdFAvNzVuSm5LS3dZcmZHM0xSZGZIclB4bVpCa0JZeFFPNmd0THFP?=
 =?utf-8?B?RE90Um1wWnlFcG5TSkpYaThJNkdhZjJLTXlkY29KWVhMVU5mRUFGSTN0VDBs?=
 =?utf-8?B?Z2NDa2hSRE9mektMZzY5UG9kMHdhTFk4a3c4b3I4SUZObDZWMEpBQzI3SWNL?=
 =?utf-8?B?U1ordUVrb1B1MndXd2N6d2dZVjdhSys4QjJIanp6TW5LanRUYWxwSmNZelAx?=
 =?utf-8?B?M0NIZG1TNE1OSDdqeTNOM09HVTBOUm5RSkQwY3dYTHJXOU54eTNNREFEd3ZG?=
 =?utf-8?B?TzdJNW5teE1hNXZZZDRWalRSK2o5eEFRV2VrYWQweTZNMjRQdWtpZXU4YzRu?=
 =?utf-8?B?OXlQQk5JdWRkdktqTGd6R2VndW5PN0ZVNFVFQnNUZ0RLVGtOVFg2RnZtcGhw?=
 =?utf-8?B?T1p2VjNBdFhEcThWOTBwajRxdFRSMEl2OGdyOFYxZlIrVWFOeGp0empIUDkx?=
 =?utf-8?B?QjVrd0JWMU44N2QwREwvZXRZTE03YWdtaWxqQkFzc29IYzRZaExpbDBYdkJ1?=
 =?utf-8?B?OXJ1SXBwdUVhR25GWEg4Slh6RFpGd0M0NHNSeWpSQ0FDTU8yVzE2NUpIREtX?=
 =?utf-8?B?emdoelVNYThqS2N5clNEOWgvSVF1UTVsT0pKc3YzN2k5OFZRWCtqQXBWU2Fk?=
 =?utf-8?B?bkJySnVmNWNsc01MODgrb1dHblpqWXZsYmM2V0VTa3ZXUGZUNW56ek9FNXFN?=
 =?utf-8?B?S09ZYUY2VUkrMlpNcjE2d2x2bEhyaUdWU3lOK1I4eUY3ZENxZFlCVkhWUk42?=
 =?utf-8?B?NkRuSEZjT1ZiOHE2M2tvQ1U2QXBiSFQ4L0pMZGxFK0sycVM2OFVKYm9sNGtY?=
 =?utf-8?B?NzE0Smp1MURHRUQ1V0FnRTFjVHZCT2Y3RkcxTTJUeW9ZNEhqYmQvdVZ5eFA4?=
 =?utf-8?B?R2ZmdFVzN3NkTWp6UHg4MGdMRUk2b0UwdmVqNkVrZHdQTGtRd2p1c2ZtdWI1?=
 =?utf-8?B?YTVMYWwxSGZKQTF6WkJYNWV6Q0owcFArS0RRUnc5US9vckJFU2x2YWxiczhF?=
 =?utf-8?B?WVdoQjcwcVh6NndwT0JpQkV6WnBHbndtTTlXb2lwMFRCenN2VTRtOVlYc2NL?=
 =?utf-8?B?dTdGdGtXQnc4Z2g2ek5BNmliVlVMNG5KRk5EZHdZM2VsaXdLSmU2VENkZnNF?=
 =?utf-8?B?VXpQMVBna05USGp5d1V6UHliWFNPSWJ6dTBsckhRUEpQQ2JOTjBDUGtydWRv?=
 =?utf-8?B?UVFsU083SUpVK2Q1NmxsejBNQTFiUTBkOVRIZnRmV0kyM2pRMzBlKzZyYWZn?=
 =?utf-8?B?azBYUWRibXVzNmFVWTVxNG94ZUNQcFVxNVZyOGpIcGdZVkd4dkJUeE9LdEQr?=
 =?utf-8?B?Wmk3LzhZcTJIUTJLMUw2akNrQmtpejYveU9jdjIzdCtTSDYwdmNiVVJzWStM?=
 =?utf-8?B?ZG9TeXpmVngyUDJWcmowakJMQzB1MlBBb09zaHB1SG9HNFM3ZG9kalpSUEZn?=
 =?utf-8?B?LzVMMzMveDk2ZExJL2s0Vnc4VkpKbmZKTmxoLzRkUkd4cmpkbERTQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72077921-3d0f-4939-1ef1-08deebedb8c2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 14:45:37.5279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rz8/rfa5xPtHD0FyFvAUYDAiHSiMzB5/+h97MrQTGxLrGwIx7DftqbcU6gVumgKUM0bn14XbOjlTZy2jjscgCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7704
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2026 14:45:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23781

On 24.07.26 14:47, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This is for testing the cis-validation.
> The following rules are failing as the prerequisites are intentionally
> not installed:
> 1.3.1 install sudo
> 3.5.1.1 enable firewall
> 3.5.4.1.1 net_fw_default_policy_drop
> 5.3.1 enable pwquality
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  Kconfig | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Kconfig b/Kconfig
> index 438234c..6790dab 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -364,6 +364,12 @@ config FACTORY_RESET
>  	  This adds the necessary packages to request and execute a factory
>  	  reset of the persistent partition. See also ./doc/README.factory-reset.md.
>  
> +config CIS_HARDENING
> +	bool "Harden image according CIS rules"
> +	depends on DEBIAN_TRIXIE
> +	help
> +		This hardens the image according the CIS Debian Linux Benchmarks
> +

...and validates the successful application of those rules, no?

Jan

>  config KAS_INCLUDE_DATA_ENCRYPTION
>  	string
>  	default "kas/opt/encrypt-data.yml" if IMAGE_DATA_ENCRYPTION
> @@ -380,6 +386,10 @@ config KAS_INCLUDE_FACTORY_RESET
>  	string
>  	default "kas/opt/factory-reset.yml" if FACTORY_RESET
>  
> +config KAS_INCLUDE_CIS_HARDENING
> +	string
> +	default "kas/opt/cis-validation.yml" if CIS_HARDENING
> +
>  config WDOG_TIMEOUT
>  	int "EFI Boot Guard watchdog timeout in seconds"
>  	default 60


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

