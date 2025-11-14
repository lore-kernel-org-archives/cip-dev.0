Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB2CCE8D75
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 18:22:46 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.13])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5082.1763144564096966421
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Nov 2025 10:22:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dMoA6fDh;
 spf=pass (domain: siemens.com, ip: 40.107.159.13, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9GMQkColMcnCTh5V0K9cteQsIdftd5q4QHn7/KZp0E5+sOd+ivyR5DUybmIViGQ3EU03XoJ5+/vqKaCKYpjzOXVkvTVGY/MENzlYLjEvIiB0/cT1HPRuo+e3IbmrKy7Y/27q3s/c9ciDCwc+MuMHWOu5EmNNxu7nWcO6UWlpGgac21REDBi26Dy3LTmzIq9ewj0Lr86jbeeQlVnAv+W03eW1q/ptyWRP0ofWjPCCQgvDR9ZQ1QIbO2D75x74i8WJaVVj0GqK6fd16htDKy5f7wsez4H9o/6H4yCA4BmN4VtQL1QaqNVTmWWICzYu4wklSEXEeYvfewTmPKqTGTKfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AtBugRVSHTqAJ/42fUOCEsE9DphjASboJGi2hapGiM=;
 b=ry759AbsrvKTpt15vz0KgKGr6dtASPbYo9BKcxyvoMPbuktyDn4IXHi0CjSpvQHjfiTrU9iO+kWUCKIIGbmLzxFWS6PZpp3IhuNY/C/mOamO02XmVm9eYldbk9pSv+/mhuN3Z5ABsTlB9TaqLSHzaXEY7r5eB0pSaLSNFuUTGgRBZmnkD9Sl/vA7zWq0f3F/4QKiqFytQ1195JEXAfVrrI3BELsUMT0G5PSXrPMQuEuQJNHBZ6euDJCtWSy2lUR8klzFtYy23oC6A102nACt6si0aAgePRnliafoOdgEW2/K0lRykie2Ww8NnCvsYhIjyUNOxR6+0OnAKSwohvaDBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AtBugRVSHTqAJ/42fUOCEsE9DphjASboJGi2hapGiM=;
 b=dMoA6fDhUI+G6ogeinST7V4SSa4Wf8ry3M25b2hwlLX21/u47nB9OqRbig6bcJrUEEJCQSHaMswLqgMa79SH7pTM8SfnTZGws4xiqtsZ6kk3+MkFzVcCzKcLSA0bcoiAWNyAy+aOn00UNwwiKgkvSd3uIB231DKQQMdQ3XqQkY+N6LSmYLPVhsyn5A1yXQCj4CmqvKI7+p6Od+YxNDHR6PfW5cdsT/yP2MU9izDG/tPcHWMAMOGyuSZbKuEsoK/Q6ew92+L8m9h3uRttw0U3Zjl2kYNqyd3msXlLjHTbZrGA5aKOfpzcrO7WpgexYdYKhVhyPacemtXgWmfR7oUgSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3472.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:136::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 18:22:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 18:22:40 +0000
Message-ID: <abafab56-b8a9-44d5-814b-c4acce953df6@siemens.com>
Date: Fri, 14 Nov 2025 19:22:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 5/5] initramfs-crypt-hook: Scan if
 all request partitions are available
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20251114111925.903740-1-Quirin.Gylstorff@siemens.com>
 <20251114111925.903740-6-Quirin.Gylstorff@siemens.com>
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
In-Reply-To: <20251114111925.903740-6-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3472:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e2e9256-67b3-4fc4-f0f0-08de23aacbaf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VlpFWTZ2VlRYQTkveENsekNRKzBJdDhzektjTkVzWDNPVDQ0aDBTZXFFaFUz?=
 =?utf-8?B?b2lDV29UK1UvOHcxcVBKR1IzTG5jRmxOWllELzhJVGJwQTJKTy9qUW9jc0hy?=
 =?utf-8?B?MGpoVndGMjJuczVoczRxK2o3OHI5aG5qbDFiTWVaRHRMcmNIeVJRY0l4M2FF?=
 =?utf-8?B?dVp5M01SZ3MwYUh3SnpRSEtOY1FPQWNjQ1hvencrN0hka0d0bGJycndhcGNa?=
 =?utf-8?B?Z21ZbExub1VrSTByYTJkdWxVWWQwd2w0UEw0M0ozUTZDU2R6alRFMFBZUkk0?=
 =?utf-8?B?eHBucFRTNnF2TkxJeTF3UWlSZTlXZk9JTFlTMFFsOEN0QXZscmRhTmp1RHJI?=
 =?utf-8?B?TlIyZEZnVS9LUjQraFoyVWRRZFc1bXExc3dGVitDUmJ4RUVvbEF1a0VnVWpU?=
 =?utf-8?B?UTRtVnR1NkpiK2hiUEZSd2VNWFVwUXBodXdZU1ZVNFN6L2haT3BZa2xtV0xs?=
 =?utf-8?B?QWVGWG9jeTgrcmNVck1obUdEWXlKMFNyakpJTDZDZjJIWVhRWnluRTU0dld6?=
 =?utf-8?B?MUhjYkFqNlYxelNaZW1zZ1dvL0pCQmxTNnNwZ3BDUURaVEVRYkJmV1B2TFBI?=
 =?utf-8?B?d3dhTGhVbncrZ0FiM01FZ1FCa2lFcWI0ZDlmdVNBUHphUTA1d1VScW9aS05v?=
 =?utf-8?B?V1NhT2ErbzdjdStSQVgweHJLMS9IUjRBNGJ4dUZ2aGVoeU50Z0RUc2U5NEEz?=
 =?utf-8?B?Qk9XS1NlRFpERWdqMnU2R1NwVjU1NWpuRzdvdzZsaG91Sy9PT2RqdHJPV3FN?=
 =?utf-8?B?dUUrVEIxNnh0bC9TNWg1eTFGNnk5aWhnNlM4TS92ZGwxVVpvSGlsdlk2NWR1?=
 =?utf-8?B?M2NRVVBOR1N1ZHF0bjQwTkpXTDhFUEhCbEE5Y1d2UWQxSFg5MDFLOHkrTW9R?=
 =?utf-8?B?NjhzMkNnSVBEV0o3eXpiUDcwTk5HQUhGZHVjVjhoTjlNblpGd0xFemVZWFpB?=
 =?utf-8?B?VlN0dU1nZk9XdzRNOXZaRjhOcmhTY3B4YnVVeXJ4SHVQa09mdlpQbGovcEds?=
 =?utf-8?B?S1FnQTUrYUg0WkdPZGJEbWkwSk0xdEZWMVdOczVFTTBIK0dHUmdLNmtLUkdm?=
 =?utf-8?B?R2dEd3lDYXdHa2xIb3RQcDBVYVR1SG9XaW95dENPSHI5T0lLN25iRkdSSlJx?=
 =?utf-8?B?WlZmeDZMb214Vm9ObG5YbmN2cnJTZk5tRnliWG54YUs1YlhJRHVwMHp6ZHN0?=
 =?utf-8?B?NCtvSXdWM2NSVW9JWXVNWmhMdHk5S0VqM01FdW0xa3ZORnhCd0YzMmNiOXFV?=
 =?utf-8?B?OEYxeXRlUkk1UFNBaFNnd1R2Ullta2xPbk1JM25oMXltaml1d2RFNW9qcVc1?=
 =?utf-8?B?dG0zV1lRMDIyYUJ2N1ozUUx6c1lURHU4UENiYWVWd21vWUxPZ05KQlFjWTR4?=
 =?utf-8?B?MG5EN2NPZ1VVQXYxVjY1d09EWElkMWVoaTdrNEM4bGdpN3hxc0lrUWJhbTlx?=
 =?utf-8?B?NlJmZ0VUSmcxUDBvRjlQalorOUZ6NG5RL1lKN04wWGFoZFdsblNzRHo3TUFV?=
 =?utf-8?B?c015dFlhR2JGZURYLzY0dDVFTDhNV3R0L1dGTUpSaXhLRllHcFdmZHhUZUcw?=
 =?utf-8?B?RG40WnJxSGFRUWE1RmJoV2dLN3FWVUdXcTBqbmFLczVQTlU4aXdOLzVkS0p2?=
 =?utf-8?B?SGdyVUJKeVFzWjEzZWx0VXMvYlNsZUZyb0NWS21qN0NmSnd4dTJmZHNYN2Jj?=
 =?utf-8?B?RmozTC9JNlVwQUVJbVQrdTBPd2ptMEFwWDk1UHFqc2hmeW5GTDhBSVR5b3Vo?=
 =?utf-8?B?WDhhTUVuWHhodGVtU29qYWZ4Q29SdEFJRG5sazFldTN5NVhiNWZvL0xUT2pY?=
 =?utf-8?B?Tzh5MlpzN0hycDdGaDlmWlNpLzB5OFd5YThZczBSeEpITDh4SXpMY0xlZ1pU?=
 =?utf-8?B?bSthS2NHZWkrMUZJMG0wazIrTk9EZjdKOWh1NGh4ZVJnTEE9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a2N3a3BUclYwKzhRQ1ZyZ21GVE1uQVFmbGNzWGUyN1h2SlB5dWNPeXpaa0w1?=
 =?utf-8?B?MlRDMEVxd2EwZmNvbXgrbms4cTNvc0FFeWdoSThBWHZxYzk2RlYyczkvTkww?=
 =?utf-8?B?ekhMdGVPK1RRTWFQaGdtWDdEZStvQ3lnSFFreEZleFU1WGFyVXlPZFoyVDBs?=
 =?utf-8?B?Qk91S1dYWEw1a0V6dUp0aEorWk1MN29JUWxscWk1TW1zT3VEOUh4MzFyeG54?=
 =?utf-8?B?MDJzT2IvT3Y1bTFBT0p2YTBrU0V2NXhOTm9sL1VpL295RjFGektMQWJJQ05F?=
 =?utf-8?B?WHIrY0c2SFFqb29maXIxYjl1NU5CclVrRjRiM3RQWXFoZWNpUmdvTFVaLzQw?=
 =?utf-8?B?ZGJtbk1ibzErWC9WdVI0VjlhWFg2SUZPWml6MGdFQ3BBMWQxRTBUdU05dU43?=
 =?utf-8?B?emtIRUFXOS9xclYwTzBydGlQd3NwRERlL0o5OGdWU2hXRUFvWGttL0lqQjMy?=
 =?utf-8?B?ek1ObVBqUjEreURwTFB5RmFZVHVTR1RTV1QrelNqblVNRnh4MlI4bVZld0w1?=
 =?utf-8?B?M1VnOG9EL096cGw1OElUK3J6TzBvZTJFby9rT0dONG1vRENGZXcyN2ZQTWti?=
 =?utf-8?B?N1pHRE5zam42NFl2KzNhY3dXaWpYVXN3TExrODUxV3EySjhJZzVQdjlPaThk?=
 =?utf-8?B?QkthUkRZTnJUcXFNYUZPdEljNDRDeHZFbHN4aTdWTkZqOEZXOCtHOHZlNDR4?=
 =?utf-8?B?cGhOeC90SlVKQzdHNEloSmNXNTVacjNNZEwvTWswNlA5TStnckdERnFiTWxJ?=
 =?utf-8?B?YkI2NHdiaXV0azZQOEFBa2k4WVFuSGhTZVVRYVcyMGVrMWpyYXNjRWxjYWVv?=
 =?utf-8?B?Rm9pWTNPaXUxblhKWXkvYmJyNkFETXJvL2Q5S0tYZzRacGhZM1VQU1RzU1Bu?=
 =?utf-8?B?R0tZN0N3cXhpa0JLeUwyaDZmR2tsRWdxVkRTSUhsUjZqZ285aC9hTlNrUWE3?=
 =?utf-8?B?OTVqc3NXVlVXY1hTdTlYNlRWRXNVZG43cWdVRmRVZkRnM2ZsTWhablFGUzhv?=
 =?utf-8?B?ZTJUa2ZKaCs4M0IxZFUrL05xRm9VRGtuYytQUFNRZGdrWE9PY3dBbWN5Q3B5?=
 =?utf-8?B?TUdkdDgzSWQzUy9uZlVsMUtCRVhQem5kakNEaWxqTEl2TUIxZkYvVFkzSE5B?=
 =?utf-8?B?RUZwdk5Fa2lrYmNJN1BXdkhHOUVBRFRsWDZFVXk2a25Pa1ZYbVdhR3E4NUdO?=
 =?utf-8?B?dGxMYmNMSmxRb21GVmVqMzZKYTcxQ3hPMTFBOGpEY1BqOW54aVU5NnhHQkJj?=
 =?utf-8?B?UnZ1VVBhY3FxN29GV2Jzb3lHNXdKOVlTbHV5akRaS3k1Q1N0alk0T0FXRzZy?=
 =?utf-8?B?Q1dxWFZNMk45U0ZHd1VjNW5oUU1zQVB3N3RkMmRzMll4TUZPdjJvQlZ4R1lM?=
 =?utf-8?B?bkUvdVJoWGZKcHcweWdSUmI1aGpVd2IzVDVSOEFMbUtONFRhekYyN216d3Ja?=
 =?utf-8?B?MGw2WHcyVnJlNlBCNVdsS2dyMGxwamZndElBRTVXc1JaZGZDL2Fkc2Z3Nm9s?=
 =?utf-8?B?T1dCN3d1aHV2SnRwWVNKbnFOcjZCVUdVTHowc0RMaGFCd3RKUExpWHp1RDN2?=
 =?utf-8?B?eFc5RThTbHpnb0pxMnI3YW5FaEYxUmljQkxXLzhMblhaNWg2ekFGNExmRnRC?=
 =?utf-8?B?bnJhWE5xTFlpSGZwUktpVEhDbVNVV3lHbnB5VmNQYWlQMHNGVjhNMkZQM3Vk?=
 =?utf-8?B?RmJESWEreXRyZ1pwT3ZHL0Fod0RIUlRKSmx3SnZ4cm9SeWxPN3d2dHJscWl5?=
 =?utf-8?B?VnBUZXRqNFhzZit2WVVjVEVaMzkzVzBaVXBJK1RHZExPMytlUkFibDRQZHFF?=
 =?utf-8?B?dHNadHZwb0Y0Ri9OKzU1blJjeG9aY2NjY3hTUTA2V1pQa2NHQjJTd2JjWGFw?=
 =?utf-8?B?Uk1icC9Wd0tPK2xxS0Z0dGNBLzBhWlRPVmhwRVJEcmw0RDlzZ3pZMEE1Z0pl?=
 =?utf-8?B?YnZ3N2w4Umk4OGV4bVFXbTdDZVpXeU5UTFJKMG1WOW5tdHVmcHNFYmp1RWdW?=
 =?utf-8?B?bFh0L2ZQU3kvbUVpamFQUlZFMFNYdEcwL05NWUxSaXdvN3NUdElBMW5WRjFw?=
 =?utf-8?B?MC9DNUc1QkxGUmEwT016cXc4dU9lbzZ1MWdFaVJFMFJoNktCOXg1QzZ1Q0R3?=
 =?utf-8?B?dlFudWFNbm9qYTZlN1dtNHkrcjZrd2kwQXRrWlBqd2FCODBiVDl2b3hsYm1P?=
 =?utf-8?B?ZXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2e9256-67b3-4fc4-f0f0-08de23aacbaf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 18:22:40.3425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JyGIkDU7c15CCVJSgxun+XXjXbKBju9GGLhc6T/t2JgJe1a3ClZChy3SM250VUJG4D1Kx67Fn6c90PCwSOrV9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3472
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Nov 2025 18:22:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20570

On 14.11.25 12:17, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This fixes an issue found during testing in the cip-lab with debian
> trixie as the device was not available[1]:
> 
> {"dt": "2025-11-05T17:42:59.297005", "lvl": "target", "msg": "Begin: Mounting root file system ... Begin: Running /scripts/local-top ... /dev/disk/by-partlabel/var: No such file or directory"}
> {"dt": "2025-11-05T17:42:59.297463", "lvl": "target", "msg": "Could not find device  mapped to 'var' cannot be encrypted!"}
> {"dt": "2025-11-05T17:42:59.297795", "lvl": "target", "msg": "Rebooting automatically due to panic= boot argument"}
> 
> [1]: https://lava.ciplatform.org/scheduler/job/1325480
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../files/local-top-complete                   | 18 +++++++++++++++++-
>  ...ook_0.9.bb => initramfs-crypt-hook_0.10.bb} |  5 ++++-
>  2 files changed, 21 insertions(+), 2 deletions(-)
>  rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.9.bb => initramfs-crypt-hook_0.10.bb} (98%)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> index 664124d..74970ce 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> @@ -33,6 +33,7 @@ esac
>  
>  . /scripts/functions
>  
> +. /scripts/cip-initramfs-functions

new-line

>  # get configuration variables
>  . /usr/share/encrypt_partition/encrypt_partition.env
>  
> @@ -67,6 +68,21 @@ service_watchdog() {
>  		sleep 10
>  	done > "$WATCHDOG_DEV"
>  }
> +set -x

Debug left-over. Please replace with a new-line.

> +check_partitions()
> +{
> +	found=0
> +	for partition_set in $partition_sets; do
> +		partition="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[1]}')"
> +		if $(blkid | grep -q "$partition"); then
> +			found=$((found + 1))
> +		fi
> +	done
> +	if [ "$found" -eq "$(awk -v var="$partition_sets" 'BEGIN{n=split(var,a," "); print n}')" ]; then
> +		return 0
> +	fi
> +	return 1
> +}
>  
>  reencrypt_existing_partition() {
>  	part_size_blocks="$(cat /sys/class/block/"${1##*/}"/size)"
> @@ -220,7 +236,7 @@ if [ ! -e "$tpm_device" ]; then
>  fi
>  
>  prepare_for_encryption
> -

Why?

> +wait_30sec_for_condition check_partitions

new-line

>  for partition_set in $partition_sets; do
>  	partition="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[1]}')"
>  	partition_mountpoint="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[2]}')"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
> similarity index 98%
> rename from recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb
> rename to recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
> index e107575..9aaa03b 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
> @@ -11,6 +11,8 @@
>  
>  require recipes-initramfs/initramfs-hook/hook.inc
>  
> +RDEPENDS += "initramfs-cip-functions"
> +
>  DEBIAN_DEPENDS .= ", \
>      cryptsetup, \
>      awk, \
> @@ -18,7 +20,8 @@ DEBIAN_DEPENDS .= ", \
>      e2fsprogs, \
>      tpm2-tools, \
>      coreutils, \
> -    uuid-runtime"
> +    uuid-runtime, \
> +    initramfs-cip-functions"
>  
>  CRYPT_BACKEND:buster = "clevis"
>  CRYPT_BACKEND:bullseye = "clevis"

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

