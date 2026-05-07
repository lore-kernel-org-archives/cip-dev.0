Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBAECD3439
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 14:58:35 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.69])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14018.1778165907471136416
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 May 2026 07:58:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=RqHmoLvP;
 spf=pass (domain: siemens.com, ip: 40.107.159.69, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=io2qYIPWtcC3Aek1suwUVtCSxIZeA0tLsbCB8SZ1qxbBfcoMwLo4LS/u5IMmr/FxHaY6W2+DKWELmuETrCC7xSBqVkKY4V7Z70cBImtqoC0MSc4ZKr9UGIquvoq5/hxsMiqQ4igF/hCG2s3RpcUZY3KlX8rQMaueGRFgawFH46K5AM+6VogEPK5YSEFRXQfqIuUdmEMMSYZ4/BrauZgbkMwKDEJS7eKeuXTcRtaWKARHtHEhMcjk2R7ld/px3yJ8GJWhFWX/GnVpMCwF/ljTzA08jwBiFsYLDxlR0kPVgnUJO3589CWjUZVSJH5xusbHb7KkxIHbsONG1oZbTXuVQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2rpnQ+VJJLfHkFXzf+vx4uDWyxACMRK67Hcm+ICNxI=;
 b=yrBR8d43tubprba75PsPrfBPCcHIoPKxqoRCMQikiLeZZrjhTX+RLGz+pmNYSU5CsACwMf8dJfH3irFXFO236F2jBlGXqVEDktv7t/dVtskLWj8axpos4j52IHAjLqgV5xBkeKTE6hXn19WeU4GVEm/1MkJccs9b3nvu6dmpaZKu95lA3iLYnv0VkW8iHjId4/6TDE4ugObi+y1RGT8H+50z8nkNsOlpaOToDYw3xesM2GY98Ale4hQ3zI5IAwjYlmiGj/Ku1CKL+608kKufLs8XL7+cJb7yLMtY1fpxn/MOZOrfi3j0ggd4d0Irp0Dzef6ykcchUIQOYZ/3b2CA/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2rpnQ+VJJLfHkFXzf+vx4uDWyxACMRK67Hcm+ICNxI=;
 b=RqHmoLvPpJHUeIEPDw9vdFi34s297oWDXGktkp6P3QHo6g/ldqb+qjmRhKWkgV7CgtLaolnTx/b8MyOwjLu7rhlZzqJUaMI89GbG0coBVoR9HHcZj5hTNMRjkFpE6GxVgX8/Ag2OPj54sNW6+GvoCIzlS8ExkqY+uGRATErxxMXVf2HP4npiPH/iLEgs/f5C8/IEtnPB/trJxV7wwBjB7y3LlT+mb2FfHVsxH+C4QOVHFBUuhXCPgUhV+Hk0d87Bgma2ZWQrf219oZFQXuBq2O6s3ma5UEsi/p9UcqXbOb/NCbVQ9DWzNLneJqn1dNhPh1WpftK2SAQiOmV6sBMB/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6154.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 14:58:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9870.023; Thu, 7 May 2026
 14:58:22 +0000
Message-ID: <24220dd5-ab7a-4c83-b6a6-4d6f355cf421@siemens.com>
Date: Thu, 7 May 2026 16:58:21 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.19.325-cip132 and
 5.10.254-cip72-rt32
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
X-ClientProxiedBy: FR2P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6154:EE_
X-MS-Office365-Filtering-Correlation-Id: 5736032f-bfb9-4212-56ac-08deac49153e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	7RjVZQwgE0nW2aWScBtfzaGWaka8zsEc7rMCm8EMfXfUxoqwhSzwXvJHxlWe7rfkX2Gax2aRHdW0pjhIhsGdZDx+C1LnQDV6wggpg6/i8CKMBYJ55KGRD7V8aBdR8KhGNljGJ6h4FN5upqJTNVt11F1uTdXxxynUiM/cwihzlFXTIHsDRjfVLTvb+osl4XqPiwimwFsc4CIc9fduu/1b4mGIycdRLwSTLFQe5HMnAF9xgN2yop6muXvKK0ROo3K5EgCEIIRHzzLgzDSYkGpvEgKx3+KKl/chAf6AYP2m1X3IvtTVn1qAMiBn7DlzQykZO+WI/+2whOnv3Keg+XL/6t2lfBWevsp7un00ckhQbmN0TfPg52geGa6MUW1lJ7n7eUfDfc5CmCVbks64A6KQ9kxb71mQAC5wgKOQkP1f108kWTmKbLyJpOKsOmyJM66sD6NpQX9RQVyxwpRVWnXJlZ9gDR2/6RvTcg8JfmdQ8YqqrPCPF645zGrUuodqkqKUWqBjCYUsJ21h9ewEFTI3wcAlJ7De2ZvHLQm2kebm3J8mZM69YelUx3Jd25gyRPMTnshKijZeslsB0fCEOl+GkjGisNeGMlJUK/32yeld6HoqmchdC3Dw9ZA/oTX2w2rNgbWecB2CCeNUhJv0IXKG/KUhtHNyboD5Oucn/0SLc2mldp/hsF0EPqAFipbAHbQT
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bmxDNFd5dHc0ZlV6cjJpemQ4REZiT3BMUlhaWCtUN3JyQ1prWXF1TTQ2UkVB?=
 =?utf-8?B?QlZNV1lVUW01UEJwcUdiTU0yZGtHWEFPcUxneS9BZ285amRKVHNHeTA2OWNF?=
 =?utf-8?B?VXZTWWZSR1JhMW9vampjNExVRjlEck1xYnBmc0FkVVRaYlI0SmhFTnJabUo2?=
 =?utf-8?B?ODNNeGpCMnEwRVlXVzBUNUZzS0JYVnk3djhHdGVONUJML2ltOGVxRWlRMW5W?=
 =?utf-8?B?Y2hxNE1zQkl4YWpLS2tCNUdXemZMMTVvZnQrZE5QamtuTHpEN0IrU3UyNUpE?=
 =?utf-8?B?RE14US85RnIrWlJWUk9BcXFrd3U3WGRFWFRKbHl3dU1VVVI2RjhTMzJmajM5?=
 =?utf-8?B?b0dwSStlVmtBaUIwQ3BGbmlvc1ZUSkx2V25aWGFIdlhYK2dxTXhMcXNIRG9M?=
 =?utf-8?B?c2lST3pTZFZPR0ljblRpbUNTMlVyUW9hOTdIVUszSndBVDBSV1F6OTJsSDQr?=
 =?utf-8?B?RWdWZDUwVzYzbHlGOUYxay9hMXpVaElOTDJjYzVxYUg5SnoyeFhaVEY0cnh0?=
 =?utf-8?B?QXdRZ1U2bVhuaG1QVTVRSVVmdXBSKzR0bWxBNTFTWVVwbXgyUFpsR01hT29v?=
 =?utf-8?B?eXR0TWRPZmFSa25SRlpsMGFCUUQ2Smc5eUJmaENhZjhRUWVQTVUrYUp4cDRp?=
 =?utf-8?B?TXYxZVNIUkdHT3hndkJSWlFoU0VNMFpUTlJBTEttdnh1a2ZweWphZFptU2pC?=
 =?utf-8?B?aWZXYTRleVMrNDY4TExmazFVbko5WHMrYjdlcGd4bGZqWVcrTnUrR2NsTzRw?=
 =?utf-8?B?OVJVSHhucVJVQXVhWTVnaDhhMVpLQjk2TEQ5TUJVL0l0VG9jcTQxcWZyL0k1?=
 =?utf-8?B?QStvVUdoMU5wcjhxTytmZFByejFUdks1V3E2MUNSMm1Eam5BQ0JSR2lXaFFU?=
 =?utf-8?B?V0NTQWFOR0FVSFQvV1Z2OFRTaUtwSDk3TElmcHlRT0Q0NThKNExQUGczTjR1?=
 =?utf-8?B?MlNaYWtmclRRUjFhWDZUeEw4d0E4T2VRM1ZoSVdQNDl4RU5qWWYvaHFxeWV0?=
 =?utf-8?B?Rlc1dlhrWTUzSUJPK3ozQ3g3MzdDZTA0RmU5WE9sNG8wUE9LbXFHaEl0Zk1s?=
 =?utf-8?B?emFJUC84TG5pNVYwOTFKbnVBWHY3eGxTT1Z1Q25GRW1oSHZYUFNYeGdubXhM?=
 =?utf-8?B?U3hYUlNsV1ZEMTZZdUJjbFpVajl6dCtERjExRjZtalZpQ09sUzVmWUlWQWx1?=
 =?utf-8?B?WS95Sm0yRnU2R0lEWlZpZ2lmU0pBdDRPZTU1a3diV2IzZlZ0TFFWakQ1ODBP?=
 =?utf-8?B?NlFlaDk4ZEcxemdSNTRPalJPd0VLc3VidW5zYXhvaGh5UlliZnUvSVc3dkZJ?=
 =?utf-8?B?dXZjbkFEbmRxOFJNTVRIQkUxeG9YT1k3WHJUMEM5c1c1NTF5eXlDQmQ2Z25h?=
 =?utf-8?B?bE8yczIxZkRRM0wyT3RiMzFSa3l4UW9TSVA0TWVad1Q4clJIa1EwN3Uwbkpn?=
 =?utf-8?B?V2ltOG1YaDlQamd4bDJleGFZVUFuQUFBSWVvcGVYV2dGWHNYTGRzNlpSSmNw?=
 =?utf-8?B?clo5R0E2TWJmUVRSVzB2YzBTRTRyWE5oNHA1d0V5R2k3SXZDQ0F0TnlpU2JD?=
 =?utf-8?B?L3RhQ2lFK2V3OWM5WTg5Ti9hQ2pHeFlsZjZRcmhQTEFpVjYxaytCZ0gxQVdD?=
 =?utf-8?B?b1VNc3NYUXArcUZqTjBUaUhHd3ZHa2N1bnVVWFRVaG5xbmgyd1ZWN2Q1NUpW?=
 =?utf-8?B?N3JRTm41M1dYNjU4cnRHMkF2NmpGTGNoZ2FudFJIOHorMjhUaUtYUmVaL0xz?=
 =?utf-8?B?RWxuOVkyQ095Sm9sVjMyTEt5SERCTk56KzEzeWpRK1BIc0Z6V1I1YU1PZW5G?=
 =?utf-8?B?Z2FMZmdpbWNQTCtLQmNiUVVGMUpLMTV0Zk9HdURNQnBZRzhTbW1CenJyNkps?=
 =?utf-8?B?RFhrMnpFd2RKVXNmeU52MEpBSHI4UVRWTUVtdUpnZzVBdUdjMGJtdmhRNmY2?=
 =?utf-8?B?Q0pGYWo5Z3lUZUNWZmdxUE4xanFCOWRjVlV3YWFvUHZoTkdjWEwxUWxpTEpS?=
 =?utf-8?B?QUo0dVZ0Q3NuZEdQMG83b1hCMCtLZGxpeDRJMFJPQ3RmZ3FRVkpBdzVqUFRI?=
 =?utf-8?B?RnZjcmkzeFZrUERKTWxkVHRkSnVPMUxkaHNSZ2RGTHNVVENaQWFlWkNWVENN?=
 =?utf-8?B?V0dSd3A4bklIWHN5M2o5Tm1pdWZsblYrMFE2SkxyeXVyU1h0K04vRTE1UnFv?=
 =?utf-8?B?bnlDVzRSN2JUV3VPSTkzKzJ5RGttcDViQXdVbi81RG5NL3FyaUpTSkRrRGhm?=
 =?utf-8?B?aWZDNzVWUy9nc1BsRm1hMXQ5cG9FWUVJckRGNDZ2MmpxK1FUclVWVzdJb3A0?=
 =?utf-8?B?VHBhR2N5TjY0THVrQnIvYTI5TWcwa1BVeWNUdmMvL2wvQ1BHbXg1UT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5736032f-bfb9-4212-56ac-08deac49153e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 14:58:22.4273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VhhTzf2SOexwvUdMsdCuj3b0/lQRm0CvynmY0i2iMFFsLhUjZQwJ6xiTXVIQbNRpjlZjrrG6zCRfem8RjQOkhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6154
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 May 2026 14:58:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22907

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...10.251-cip70-rt31.bb => linux-cip-rt_5.10.254-cip72-rt32.bb} | 2 +-
 ...inux-cip_4.19.325-cip131.bb => linux-cip_4.19.325-cip132.bb} | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_5.10.251-cip70-rt31.bb => linux-cip-rt_5.10.254-cip72-rt32.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_4.19.325-cip131.bb => linux-cip_4.19.325-cip132.bb} (68%)

diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.251-cip70-rt31.bb b/recipes-kernel/linux/linux-cip-rt_5.10.254-cip72-rt32.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_5.10.251-cip70-rt31.bb
rename to recipes-kernel/linux/linux-cip-rt_5.10.254-cip72-rt32.bb
index 06c77b64..9fe4937c 100644
--- a/recipes-kernel/linux/linux-cip-rt_5.10.251-cip70-rt31.bb
+++ b/recipes-kernel/linux/linux-cip-rt_5.10.254-cip72-rt32.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "0f2646b522468a95b5e0618ef12821ace79f08cd2c9011f4608544d7477fe7cc"
+SRC_URI[sha256sum] = "650fbe9ca95dd0d3d7aa388fcc892a9f0df1dafa77f9c30f3cf76998e440f60b"
diff --git a/recipes-kernel/linux/linux-cip_4.19.325-cip131.bb b/recipes-kernel/linux/linux-cip_4.19.325-cip132.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.19.325-cip131.bb
rename to recipes-kernel/linux/linux-cip_4.19.325-cip132.bb
index 3f6fc67e..4133ec71 100644
--- a/recipes-kernel/linux/linux-cip_4.19.325-cip131.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.325-cip132.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "02a5a31d21ce3edcc2de6b012df98dbb9ac60269ef2e35a214f0fd47e373df62"
+SRC_URI[sha256sum] = "3b3eb046d0ffefc4fd85406d835cac737095a1c8f4941013057e45f72abb881a"
-- 
2.47.3

