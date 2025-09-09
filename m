Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F7DCA0FED
	for <webhook@archiver.kernel.org>; Tue,  9 Sep 2025 11:49:33 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.65])
 by mx.groups.io with SMTP id smtpd.web11.11105.1757418572774233507
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Sep 2025 04:49:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vwgaAMnQ;
 spf=pass (domain: siemens.com, ip: 52.101.72.65, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qKeJT5uHTk4YpJXf7X+fEAljEiRs9NgYEZLf0QMPHoA/3AoC9g2zPUXIOaoh1IOiBn9JsppTuwTGn3v0RSM9VoOwwzE9pytZj0SFyHTNAF3XCzo0MPv3mlJZToEepL+ONEY6J0Ns9tuurmD+zqWSZxcqTKAv1YzBhHCQwQJaoFU6HM3TVDy54nz/PF518fSOrRT6lss45E4bg0evecZ5W/zVuXzvg3jZ5unu2rO0h8RYLixtIcoKbEJV/piameHnq10NJ6eipXw5spIQND7pTQCEFsiClecFa3Em0YUtnhRkpNb+6TfUwxuoV6ikBB7BBQHU9pwbnLbdM4DeMGXdBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9cQsfO6TldlbBivSM19CDRZXRz3ThGlytoTgewEHcs=;
 b=oTg5zbx4KMgx3xR4KzodCGiU1Hzg8EV8LVICLh3axG2uIu5MJYaRvKLfM0wN8WAIcmqLWkrBF+wuttrOGhREzIDoJfqLpQyUKZ7OF7MnYCJMQ8foHRJ5HGzLLsjTHZlOd+p3CDyuYBUnoCJB7Q4qxViJamlsrR70ok3Jwb0G6i4KLpkkKP+6LbMB/MxEVMpHI4gGna7K0LNNT2SbjTv5YfiMAQv1hlVt4Qc7hNj4T8prw/9vN3DwJpiW1IsxzfdtOY77FlwW2pCqTKItOir/2q2z2ep7sst8AC84yxt0o+mBgeYoPKYca5J9MmtTCTB++60zapPYZzjTFlJRrrZ/GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9cQsfO6TldlbBivSM19CDRZXRz3ThGlytoTgewEHcs=;
 b=vwgaAMnQRp6oI9TGsWAPwVNTNznJRRMP6TRgUOUlHePxBVk2EM0FW8QRtWNBxnOiMXiEpVey7muP0K3Rt/4vIDs10Dz31hSAVlLBUqid9t0soK5rXphPH3tIWTm6ZWQNE3NIw2rUoNvuCrdRGD7dXHs2ClJn4mhhTcpdv2ixXVzP9ZdASZf3jOnE/kmyNnPVdtomHyTYMsOSLFzNSeTEIn6iTv+AUcW3IZyvc2NuD2+Y3sJV8JqrPrd1P3fhZ41uEHOQxSzZxMYuVdf28sxb5z24xEN0hJz4ZF1tBXy6AL/uKguyCntjMyYP4DxhRmb/+1vjJzsVIrCUCQ3jlsAVKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6624.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 11:49:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 11:49:25 +0000
Message-ID: <e2e9a482-3283-469d-b629-965662c716e7@siemens.com>
Date: Tue, 9 Sep 2025 13:49:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v5 7/7] Add Readme for
 factory-reset
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250904095231.2039819-1-Quirin.Gylstorff@siemens.com>
 <20250904095231.2039819-8-Quirin.Gylstorff@siemens.com>
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
In-Reply-To: <20250904095231.2039819-8-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0211.apcprd04.prod.outlook.com
 (2603:1096:4:187::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: fe6835b9-4c89-421b-076f-08ddef96ec62
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?a3BhVnRnZHBuWDEzTjZhYi9HRzVBaDk5NmNBUXZ0aDVaLzJ5ZUVacWlZNzYr?=
 =?utf-8?B?N2lSTDRxQml2cVh4ZE8vUmhEUGo2VmNjMko3VkRhUkhvWGlDakUzN0dtbVRJ?=
 =?utf-8?B?d0J1dWg4VTBRNmFJNk9aQjBybU9Xa3VIMHErL3NOMkg0c2I4Ym1TeUppb0VL?=
 =?utf-8?B?bUxzbVhWY0NJSmdNaS9tRFZzQXlrR2dxTm80Rzk2Y3gwdGE3NVc1NzNhcU9w?=
 =?utf-8?B?WHY5Tmo0ekR1TGVwamxxYlJCSko1d3IvVFpwQUtoTFRRdVJqa1BTT1gzb0VJ?=
 =?utf-8?B?emRFNGRoUitZSkR1bWhJczFuN0JxakZQWG5hbXhSV1FGNWdnWXRHUWZqZjk4?=
 =?utf-8?B?WUhQRGQxUy9UVlpKckl1dkZubzIzNERYVGZGUGxMK1BSZUl1dUU3R0NoelBV?=
 =?utf-8?B?OTY5emNDQ01vbk5PUHU4Z21taWtyeGV1QjZKMWl0SHRaRllIS1BDTGpKRGhL?=
 =?utf-8?B?QWZnanJVMkR4VUhvclRNcmtHVjdWSUFrOU0zY2E0Skh6bnlDcERhUzBsbmJN?=
 =?utf-8?B?a0gxNktqa0R5MFFFZEVDYmJrMlRBV0xoUExGaXV4b1l1cWNVZmExaXEvWlFN?=
 =?utf-8?B?aFVxSi9yQ0xWQVc1NVJJc2VJa1J5dWI2MEpZMUdRYTY4UGYrc2N3V25uNkZU?=
 =?utf-8?B?eCt3cVFkZk9TMk1FVVNaWlVwdlNtdkFSSWpCdWFyc2hobnlKYkZybm1hd0dk?=
 =?utf-8?B?byt6VnA1bFBhMk90bUxJS0RlMzVCUnN2QlpYY3duYlhEMk5acXFtNG1zaEZW?=
 =?utf-8?B?eDYzUDBVK1lHMlBMWlppaFNiSC80VEJZZ3Y5YU0zTDlRUytDWXNZR0VQODI1?=
 =?utf-8?B?WC9oM2I5aUhBN1hVQ28zenFSdDF4TU1uMnNyUVZoR3hpUkFCWkdTV00yd3A0?=
 =?utf-8?B?THVqeThDRlhuLzJOYUdrbVRTRGFDa2NneC92eVQvN3ZLeWRjQnNqNHdYdm9n?=
 =?utf-8?B?dCtpeGQzRXhOZDFhekgxU0dXN255dUR3SjJFL2dlVzFCaXdXR0VJbFJ6YnBJ?=
 =?utf-8?B?elB5NEpRTmdoRkJPNEY3RXErb1J4WVJBMGkzSHpLU0VtdHkyVmE0Z2ZhMW9Q?=
 =?utf-8?B?V3hQSDVMTDhEZGdwejk4TEd2NlZWa2ovVUdPb3JEVkRDVHZybHBROWNWTXd2?=
 =?utf-8?B?Q3lPKzZaSEFuWDNUajJjNTZxenRnVnRwckFUUlF3R1JhcjRJZDdYOEVEYlF6?=
 =?utf-8?B?Vk8xazdwL3FFdUIxdTIxejdjSEFuTHVJT2l2ekpaREdxNUJpTUhlNWV1MWZv?=
 =?utf-8?B?bGcrVFVINmhUOWZ6elQ3Snp0UGFwa096Z3gwMmFmSXFWUTlVaE5tandjSEdi?=
 =?utf-8?B?MXoyUDRQSWd5OGlRUkxzOU43NnFQd1YvZGNOYkZrVHNhT3U5emMyNVNXRHAx?=
 =?utf-8?B?cSs0OTVWZEM5TzM2UXpIQ21YNjEvajZZVWN3M3RHT0VCTlFhakdUMHI5bFhw?=
 =?utf-8?B?aHhGajI0NUdTdGJEbGhMeloyVCs5M21ybVFCakJsL09RZUZVVzRzeDU1S0s3?=
 =?utf-8?B?ZGI3MUJOaXhCN3BMTmdrV0RLQk1sY0tyL1J0ekdkR3pHKzJoQXVVQ3Q2L1pZ?=
 =?utf-8?B?cE5TV3JoNHMrSTByZkx5NjNkWTNueU90WXJxVzJQWVNPV2FQK0NRQTNNQW5m?=
 =?utf-8?B?N2dBVk1TZDFhVmlqQ3ZLeTg5a1J4LzBpL2pieEo4MUo3YUFIakdvMTY3VDQx?=
 =?utf-8?B?R3VRYm5tQlpNelpyRXI3UHh2SW11VDh4SHdnTjg0UTZjK3ErbU5OTU5GYndD?=
 =?utf-8?B?TEo1VlVia1FKRTY3K2FxeENXbjJFMytvUjdZSTJXTDV4TU5IS3l3bStlWGta?=
 =?utf-8?B?VXRPV2E4TjRVWkx3QUFBSE1uL1N2aU9kY0NKREwrcUo3UXVoNE1VSk9sbEFC?=
 =?utf-8?B?ajBsL2ROa2NqeUNxNEc2aFRsY2IwTVRCclZCeVB6MCs5OGREbUtPRzlUQjBk?=
 =?utf-8?Q?ToHBn3DLJAw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SHQycC94UlNvejVJWjFmUE1pQVZuK1dTcldWTVJVd2VDSzFva0w0QXRsd2Vp?=
 =?utf-8?B?bHBnUU4xUW1EbXBhay9DR1NqQjFaWE5VYlNwSHVqbkVLekJHU1VlYmdyNml0?=
 =?utf-8?B?ZmUwcCthVGJIak1JUHl6cUx0WUd0N25tQURZZnUxWkxpZWNyd3hwOWlyaHFa?=
 =?utf-8?B?WGhOSEUxNTdRenk4MFUzK0JVcTFVajBvcEF1aEpYTWVRZEt5bEw3N1QzQmpj?=
 =?utf-8?B?WHdrOUhyOXdleDZaenJBTXNsZ2xMR0M1WDlpaEJvcTYwMkFjZlZKaEh6NEkv?=
 =?utf-8?B?TlNQZ0dET3EwT2VVcXpJWDhEa0RFbGU0dmNXWkJCcDBpaGtUTWt6U2p0dHI2?=
 =?utf-8?B?Q3ZqMnFGMEpmcWhDOElZUEpqRmVQWXNiZGxDTEIrUG4rM0V1eUJhcC9CbnJw?=
 =?utf-8?B?c3lqSG1PZE5CVHNIaktKTDBJYXdNUWhYQ0IvdVJ0QTNqOFJpUXY0c2xBUU92?=
 =?utf-8?B?SFFnSkpSNytCNE93a0wyNU5DT1NYZVZmSjZTdFM2N1lkSmlyMHg0TisvcmdP?=
 =?utf-8?B?Wkx2Mkt2dWdvbkU0bFhTV1BEM3h2NVNkcmY5QllGeUNnaHNWNStJMGxyZnNm?=
 =?utf-8?B?bXJXdmNKYU5STjRwK0JEOUpTbW9rRGVkUE14d0lsOGNGcnpJcXNMRThCOW9F?=
 =?utf-8?B?RENRanMxWVNqeW1IOGNWdnhsamo0ZHpZY0pTUERzbEJTV3hYOGw0dE9vYmlS?=
 =?utf-8?B?RkFMSS9LVzNvazgvSm4zdm56bkM1S2EzUVZOU201aFMwaXdQYkRjQThMTWdT?=
 =?utf-8?B?dDN3RWFUTzFGRUZGVG9DRTN3RGh0WUdpQ2lwdDJHR09SUllNRFM2YXh4WXI4?=
 =?utf-8?B?alQ4L0NrM3A1czRndVpxYzZKZnMrejY0TFI4ZUV2Zk9aOUcwa2ZvbGcvaHJy?=
 =?utf-8?B?YUg4OFlnQzZVd0NyMFo5eE1zUW9PSXFhaHY2eGM5Mk1HbVUwZnhHdlBqQzlX?=
 =?utf-8?B?VmdZbFNWZTd5SkhaWVdtQlBIOVR4NXRpSXNCMUpQRmlrYlFlUFdCMTcxbHBS?=
 =?utf-8?B?anpLVGhjUk0rU1EzYXZHZFhybXdtZHc2Q1JIeDFJYlBadEJMU05Ya0JudnhV?=
 =?utf-8?B?aHhkY3pxTzhMdHZoWmRvbUUxK3l2dGNkTCt1ZCsreEpWaGJuTjJTcXhETG9u?=
 =?utf-8?B?WjdMeWdZdjJBNWFyVHB5NWVSSVg1YThubWwya1RmNmJmL1B3MmpaL3NnTmpJ?=
 =?utf-8?B?T21GN0NKVTRhTEhXR1ZXdGN0ajQ0Vy9HRGs4M0FsTWpmaGxZVlJIOER4YWtD?=
 =?utf-8?B?TDNqbDlYbCtSVWNTRHVINVNjbVBtcGlZa09zdnYxSG1pVFNoV29tN3VObUp0?=
 =?utf-8?B?OTJFS21MUk9xT3lFU0xVRkFVR1UxMjVvRHVkMGdlalYwYU1LMHpnamdLOGxH?=
 =?utf-8?B?V285cGpHbGtWdE9xZEJVZ2VySXFPRkhkMmtHQ2IzQzB0d2RBYlJFbmIvOFky?=
 =?utf-8?B?ZGN5eGR0elhUdlErNmhFMldwWU54VERCclMyTndHcWhBOWpxZ1Fvb1VoOTlS?=
 =?utf-8?B?KzhHZnVoT05Bb3V3Z0JJcU8vQ1hqbVU3NzV2VEFyU2pqa3NjbE1XMjBXa0NV?=
 =?utf-8?B?K2tTOXJxeU90ZnF0QWhLWUZnak9KQWp0NzhxN0ZRZEhnNDhLbnN3d083ckRa?=
 =?utf-8?B?S3ZmaXAwZHhpWDNLeVJsbFc2eE1aQWdROHdRUDZHVXZGRjdrc1Uxb0FkMlA0?=
 =?utf-8?B?TkpoTG1iM3VZckRHcTYyQkdONjdyMDJEbEZEbWt6MU82TDR6WEhJL1FqSTZa?=
 =?utf-8?B?RFdkb2xoYm9zMTU2OEE5Ri8zT3JqbnpzT281ekJ3SVRlTWFCQVhVc2IrTndC?=
 =?utf-8?B?MWVWalp2MXUwSHFEZ3AvUjJoc3Mvd21xRW5jeElQa2JlTEtaQmMraVhuSjZo?=
 =?utf-8?B?WjhUU3g5S1B1VWNMY3pkRDVIUnhXRzZEa3JTRkpaTUNPRnpYYnN1enQrbit5?=
 =?utf-8?B?d1hzUW1XMmdlVXB1UkVGZHViclRwL3h3a0s2cXdSOFRZYm12a0ZDaWFZcjl6?=
 =?utf-8?B?T0hZbkt6VHcwdy81Y0N0ekFqOGlEdUsxRUpzNWZZZlorY1ZRZHFDcFkxTms4?=
 =?utf-8?B?b2pOc3JWNlV4dFppOXhYMmVwUk5qVGlBYzVvZGtPbTRGdHdQeTMySWgzN280?=
 =?utf-8?B?Qno3TGdDTFQvbWVtNk91dkowNXhDaUFkUTlkYmVCN2ErRm5pVE1KaU1STFlP?=
 =?utf-8?B?clE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6835b9-4c89-421b-076f-08ddef96ec62
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 11:49:24.9935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iA8CXzchWsz6ZwOO/9gH2XrsL5AdntOS6jYfhAoZxwsKgUIxHbIP0OrdSJ5Yrqd/B9X8ydKU9jM0eG+Eiy4e4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6624
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 Sep 2025 11:49:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20027

On 04.09.25 11:39, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  doc/README.factory-reset.md | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 doc/README.factory-reset.md
> 
> diff --git a/doc/README.factory-reset.md b/doc/README.factory-reset.md
> new file mode 100644
> index 0000000..f3e2560
> --- /dev/null
> +++ b/doc/README.factory-reset.md
> @@ -0,0 +1,25 @@
> +# Enable Factory-reset
> +
> +To enable the factory-reset functionality to following two elements need to be installed:

*the* following?

> + - initramfs-factory-reset-hook which executes the factory-reset
> +  ```
> +  INITRAMFS_INSTALL += "initramfs-factory-reset-hook"
> +  ```
> +- factory-reset-helper which provides the helper scripts to set the factory-reset marker
> +  ```
> +  IMAGE_INSTALL += "factory-reset-helper"
> +  ```
> +
> +## Technical details
> +
> +The factory-reset works be writing, by executing `set-factory-reset.sh --create`, a marker into the persistent storage.

This parse does not sentence yet.

> +The initramfs reads this marker and formats the hard-drives provided by the variable `INITRAMFS_FACTORY_RESET_DEVICES`.
> +The disk will try to detect the previous used filesystem and will format with the same type.

The /disk/ will detect this? Or rather the initramfs hook?

> +
> +### Disk encryption
> +
> +The factory reset will remove the previous used disk encryption keys from the TPM before formatting the selected hard drives.

previously

> +The removal of the TPM keys can be deactivated by setting the variable `INITRAMFS_FACTORY_RESET_CLEAR_TPM` to `0`.

In fact, the keys could still be removed - but only those keys if a
general TPM clearing is not desired.

> +As the factory-reset is executed before the disks are unlocked in the initramfs the filesystem type must be provided with the

... initramfs, the ...

> +variable `INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE`.
> +

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

