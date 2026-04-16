Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52C3F8A172
	for <webhook@archiver.kernel.org>; Thu, 16 Apr 2026 12:49:53 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.6])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13183.1776343790767846373
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Apr 2026 05:49:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=FVE7+CZl;
 spf=pass (domain: siemens.com, ip: 52.101.65.6, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=euwb9rBxDkY2oczYA9OKMpvHbAx8ro3ncp4KSAnkqyQH+yn2rXSX+Bxczy40jMy5uXirzNGvXpcbBIM8F+Yqkm5v93th3X5oweOXVAB11KvhyE+Qn3ZkBTxGhrCT05AmWksFGolSWHQbDFYeCyeJ59XjZQNdS1C/1I5+ouiHbG793PAcdU5i0yINnoEoGS4TreDUjHU/HIJ+RnARw/HUZVJkGSSgDV8G5baoUm1RTIbBBN+ECIpjCoBPI4FNpyfAzVSGJMjE4M517bYq1yLN5ERlIMke0aGJpaSCcRONWwoSB/UayCg9wjz95LccXR2nV3o8VmoRvcmsLoi5mqVXzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7riFqe4f3dskiUuIZJtsUCaFDq4U0CYsYeTfTFgeAqY=;
 b=e+4JDtvtSfJzqpLwyUGG+AHkCykPgxy0BkKkfPQuXuuBaOz9ZCzCljuGimACk5aNSkcSQCanququzerv46sZEHPxl8mFqZiucNbST1INljcKnp/1Q4fh0ex/NVsd5GNLgT96PLpaVzq2QxUt1Pfpm9ZE5n8q8j/xL5dgdv0u2/CxA78GOWMPg4TxedfzyLaGSHUTBxqRE+z30lKEqWvPwuwbXJNnTgO8+Yr/vT51EztvsRls/g8q68JvHeHT7EWFn4kATEyPXSmyL71r/2Fr6K4ROe5iTd5R/Vr7JHD3B7+ks1xQg8DC8/AHB3kSjS1QjM2qH+j1b3uOw24FKZy+fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7riFqe4f3dskiUuIZJtsUCaFDq4U0CYsYeTfTFgeAqY=;
 b=FVE7+CZlF34z4iVmb3Fr0TWswsEs3z2Nhc2atv8kQJ9jEb4E2n7a1Jp7cRF9rbhEEzqeTGx7C7oNsirX5c+UNOTSZx81u77vGW1OuUj3Z+GT670EDMCpV64BD0ZB3u88/rnZhwEYzJE7Di7JQuBFgdmkipwX3k3q0c2QNYaos6MzHQSP2lVxEPqCODJ2TWAGiPeNuyzaYWMPF26lQqkD3/YKC2lfvGpq6fBJgrWlw6Xnw2NR99NDHnHqipBOmicNHn6zTb1gmSoqpHs54C2206sJB8fGbiBbta38/1lM8vap7RWOPdrxokcySdwO/L2sVrZ/G5fVe+rl3qyOa2PIzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5439.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:48e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 12:49:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 12:49:44 +0000
Message-ID: <5677bfda-ba9a-4c69-8989-071b96cbc1eb@siemens.com>
Date: Thu, 16 Apr 2026 14:49:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate: Set Debian build
 profile cross only if ISAR_CROSS_COMPILE is active
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20260416083513.819854-1-Quirin.Gylstorff@siemens.com>
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
In-Reply-To: <20260416083513.819854-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5439:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a7a4fd4-27d2-4ed0-ab6b-08de9bb6a294
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|55112099003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	Mar+ZNi7tkaHhiNao+Ajbn7GvsoWbiFbdDAkn030Ubeg9swqnkhBO2wK5bw3oI+WufpQ4OBQVrEpINNpsOsfUWGVdgnnZLVbQoLqpSHU2Q+bCnmuEP0AWfPiVZF9ADn++Y4onHXsRVsbUjNuNEQzY/vW1enDljdnrYOAcxjigP0GKQZNGjJo7p7yYBY4hTvC/VhP5HTI4IoFFsVbfYSO5zsXWZY/N7qCM1BSccxI9Vghxu/WCA/MPlh0KCAO9ZxRbFSll2Mi0sEZiCwfDW5vh+9M/kIsahAnDu2YwaJWha8hko0Rhw3H2NmLBeSaTJUqcFFzackZI5MJ1OUX48ISUyhfZ5DUw9uz0FbkdlCzXr+m2/997EI5pnCeOkAsfdrrWQgwyr0eHaX9nA50WVUv3i5OBtQJaL7pqZFi/WrJ+iWyqqHvTNFuRc05KUfBY5wKh8FDOgUuxJB63UyoHg3al6/HGYwfxHzhAH9Sn0JmPm/b1EXfAhaUqMy4Ta5tdDIpoF6XhBIn+iqJ07rp/ZeXXRYcTNMi1570nuVZDMab5862FzYTJhCxzn7CCTUoNa21pGt8p/fBZJHDuE+JOqKCMx1APaeArvFWOikU9bTOZkCk0EKcSmuwp+B0weF6ptqdPtwWA6/xeNDzRYMDisJuSzZXOslRYZaZGxyNF5RWnXaGRdDEfETVDXxcw+f7QboQ2Efi1QrK6AHPdi3ka/ceEJKM4uaFDUewz1VSIoThaeA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(55112099003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eUhOQU1pTFVtaWVqc2VIRjJjRm9jZisvbXYxeWRVbU9BTEw0WFlzcjhwcTFy?=
 =?utf-8?B?VnJhcUNFTytremFuTzdmdVZJeHlGTC94eDl2TVp2VjhGS2NFZjhiQ3ozRmE5?=
 =?utf-8?B?VE1yZThBajRVMjhvY3dBQnBSeXBxZTRKV0pBb3JVQ1JhSnFCNXhMM01DTUMw?=
 =?utf-8?B?R0NINFNXSG93eTNSb1NRcjRsTlRqWnQvSFVHcEZ4Qi9XaFBiMEdINHJucyti?=
 =?utf-8?B?MHd5N3QrVGsyaVZ4QWYydlM0SU03RUtROHhiSEdUQVpHNVpXT1Y1cVBpbDl5?=
 =?utf-8?B?NEhLMTZhUmR3SmJLRnpNTTg3WXlLUnhTZWd5K2x2L0pBaCtRZG1Fc0UwaUFV?=
 =?utf-8?B?Sld0QjAyWStCc2Q3RFJQalM1VzBhTVdnT21FS01NSkNoRURacHYyTkJ5Ukta?=
 =?utf-8?B?eWkxWmUzRVlFelQ3bTBZZFZBMHNIcE5QT0pQL0FqZ2RRTTc5NGNTODFsVi9B?=
 =?utf-8?B?ZXNubWpxWE5aU0VIb2xnUlZ6OU9lWEpvbGkvR0d6YUZ4Mk5OTEhxeGkwZVNG?=
 =?utf-8?B?UmdZbWxpK1BVdmdyNy9TdzBSVTlkVVFCUHllcWpzZVJQQWx2amhzaEtwM1h1?=
 =?utf-8?B?T2tzVlRwUVRsL3JIclI4Rk9jVHpGaFhMVElUaVdGcGRLZlZySVdWTkI2N0pZ?=
 =?utf-8?B?Q2xYVGV2OXlhTk10eHZmZ1VZZGdkMmxNeXVqKys5WXhQcHA4MmFjNVZKcy94?=
 =?utf-8?B?ZFYrd2hMZGVMdm5DTFZoaHdiMWtsNzNDbmpDWUdsUG9PeWNIQUo1a0FTNUdJ?=
 =?utf-8?B?QU9OZER1bTVDV0RBWWxPSVRLbWZTYmlKd1hYUmtSYkF3Ym14ZlBIVW0rTGVR?=
 =?utf-8?B?QS9aQVRuRzBsQVJEMzNiV0RqbjVhM0IzQ0pFSXJteFJacStZRVRaZmNDQ2d4?=
 =?utf-8?B?aWJpMVp3ajBuRGNFRmh4bXkvck5SUzByaTJZWVJTSFFkcHdHMHRTalFxN1Ez?=
 =?utf-8?B?RWlMeXFCU1Jkczl1UnhtbjUyTjJxYlVQbEZBdDNnTDNHMWM5d21YYzNjUmRB?=
 =?utf-8?B?YkZSZW1zSzFEUmRsYm9rcVMxdEdwZDF2UzcrWGNoS3VCVkNtajRvRkF1SHdB?=
 =?utf-8?B?MnA1NEt4NkRXYk9uQlVtTC9tbGh2d0JvcDhDdzE4YVZ1aVloS2xsbVZoWUJD?=
 =?utf-8?B?c1lJRi93dC80YUI5OFplR1FZVEt4aDdBVUNzZW5kajFlOTF1YkRCaFREaFlv?=
 =?utf-8?B?Y2lIMlpXRHdOa1lwWjFyS1doem5OWHlvOUkvRnlGWE05bi9OK215aUFwR2oz?=
 =?utf-8?B?THd2L0tLYVRBOTkrbVJRNWdIWnYwL2RGeGYvcHF3S2J3dGhsSlZhSEduR0tj?=
 =?utf-8?B?cE9WK0tyVmF3N3d5R2h5Rml2aVdBUjlaWHVDZHB2em9CVk9OUEVpa0FyRWMr?=
 =?utf-8?B?K056cCtHK1pQZW5OUThkbGNuVnU5YkNBcGZDQmFnUWRUNDcvaGRteDRGWWdi?=
 =?utf-8?B?SDVWeFltY3JLNm5zMWtXZ2VxbTZVY3lSRXRpZm5pdnc0bDVsT2VtNHNMRm1X?=
 =?utf-8?B?U0V1VjJ2MEZ3dzE3dzlhM1ZSY20zWncyVXdScHQ3TU9YK1ZjdXZJZUh3ck1I?=
 =?utf-8?B?aitBam10SE1DSjRXTEF6L0VTeWpDaGd5dTFmdGtYaWN1MTJUVGxvaHdjQkNR?=
 =?utf-8?B?MHVOa1B5UWEvaExPSURrSVVaekFma0ZlY3dIcXo2SWtnWnJsM2JCell0WDFK?=
 =?utf-8?B?OVZacjRuVWNEYmhBc1Jod1orcVJtSUp1bkFmM25sNjFxekZJMmt5NE9kVXNh?=
 =?utf-8?B?VFNOVzBRYXp3QnVkMEVKVlZJaHlUYnozUktYUW1uMFZpZXFPbHVZOHVndWFZ?=
 =?utf-8?B?YU5QNU03ZVIxV3ZNeVc0WmVZY0RuMUVIbVRKZ2k0cEkvSnliY1YyelFLa1By?=
 =?utf-8?B?TzJyQ1RCYW93Y0lyR3ZPUFZNWE1aM2ZLU2RBSTlWdGtpUDFsSDZZaDJHWVRI?=
 =?utf-8?B?VGFkbEZHS1NrM0FIVHRCekZyaVIrdXRXaWUrTG93VFQ5Q2ZLMk5oOGFuVHBL?=
 =?utf-8?B?dG5oWVl3QUZiQXg3Y1RiTkM0aEpmUWNnaHZhWXVoOFFsRzgxM3A2U3RXdnZj?=
 =?utf-8?B?L0RMekpUL0FlUXZrQ3E4TVhXajdnSy8zdndhb0FHRkxVNXgwSDU3TnVzNlhT?=
 =?utf-8?B?RXVyWTd1S2Nzay9GZHlwamVEWTdRNXVXSEdqdDdTbTRmUHE3WWRLL0ZiZENZ?=
 =?utf-8?B?RHoxR0NibFErNHpXOHBUbHpxWGo3cmFObTRxZHVHZzFpQ256Y3hXWFlSUkpT?=
 =?utf-8?B?ZTRRUy9KOFJ4QTJPMFc0WjJ1SkVFeDhweFZBRDJDVG1zcWwrQ3Buay9uclNk?=
 =?utf-8?B?M2hGTDFXQUVFclYvdEJ0ZzczTndaTXhGa2gvdUZHNXpsSzR5Y20zZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7a4fd4-27d2-4ed0-ab6b-08de9bb6a294
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 12:49:44.8910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNR1E1y7GCXtp8tpr+2wjgfQ1J7ql6a4cKrIX5rPGfOqNY8WHpAYfE2UYOcKPtkwb1YNQieoFCtSq3/E9drdWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5439
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Apr 2026 12:49:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22738

On 16.04.26 10:34, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This avoids the following error with building bookworm or older in
> trixie:
> 
> E: The package cache was built for different architectures: amd64 vs
> W: You may want to run apt-get update to correct these problems
> E: The package cache file is corrupted
> E: apt-get update failed
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  recipes-core/swupdate/swupdate.inc        | 4 +++-
>  recipes-core/swupdate/swupdate_2023.12.bb | 3 ---
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/recipes-core/swupdate/swupdate.inc b/recipes-core/swupdate/swupdate.inc
> index 497b1c2..59db631 100644
> --- a/recipes-core/swupdate/swupdate.inc
> +++ b/recipes-core/swupdate/swupdate.inc
> @@ -37,8 +37,10 @@ DEPENDS += "${@bb.utils.contains('DEB_BUILD_PROFILES', 'mtd', 'mtd-utils', '', d
>  SWU_SIGNED ?= "1"
>  DEB_BUILD_PROFILES += "${@'pkg.swupdate.nosigning' if not bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>  
> +DEB_BUILD_PROFILES += "${@'cross' if bb.utils.to_boolean(d.getVar('ISAR_CROSS_COMPIILE')) else ''}"
> +
>  # add cross build and deactivate testing for arm based builds
> -DEB_BUILD_PROFILES += "cross nocheck"
> +DEB_BUILD_PROFILES += "nocheck"
>  
>  python do_check_bootloader () {
>      bootloader = d.getVar("SWUPDATE_BOOTLOADER") or "None"
> diff --git a/recipes-core/swupdate/swupdate_2023.12.bb b/recipes-core/swupdate/swupdate_2023.12.bb
> index 6822153..89785b6 100644
> --- a/recipes-core/swupdate/swupdate_2023.12.bb
> +++ b/recipes-core/swupdate/swupdate_2023.12.bb
> @@ -39,9 +39,6 @@ DEB_BUILD_PROFILES += "pkg.swupdate.suricattawfx"
>  # with cross compile we have a unsat-dependency to dh-nodejs on arm/arm64
>  ISAR_CROSS_COMPILE:bullseye = "0"
>  
> -# add cross build and deactivate testing for arm based builds
> -DEB_BUILD_PROFILES += "cross nocheck"
> -
>  # use backport build profile for bullseye
>  DEB_BUILD_PROFILES += "pkg.swupdate.bpo"
>  

I think we can simply drop "cross" here:

https://github.com/ilbers/isar/blob/6504321e85b5fdc3bb5a83f042b77cb39cd11a6f/meta/classes-recipe/dpkg-base.bbclass#L149

But good catch! Was already pulling hairs over this weird issue.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

