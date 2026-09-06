Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02C8C79F85
	for <webhook@archiver.kernel.org>; Sun,  6 Sep 2026 11:33:02 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12654.1788694377211527578
 for <cip-dev@lists.cip-project.org>;
 Sun, 06 Sep 2026 04:32:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=hT9/U4se;
 spf=pass (domain: siemens.com, ip: 52.101.83.31, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7kvzZa7KB0ly6Y77KyIQOEw9PFBayvBcZZsnfqGmCcQKCLvuRXwW2CKw1xrIsci7/0HkJT2EkzdSOivDinOLxFwGBTLThAK3l5+3SFgHHC8vcd4czQ4hBhxnHMCGjJDHprr5w4rcZULDERWTu7PmLCxeNvLuvr3OR9I8uhXtKTpYsZsiIfJlMndhMTxqrHngVsp3lDndRPZyB4FeOOXNVieK72MVSkPfAE8g+Hsf8XyBgf6IUIYjuYSWF9urSzAe0jdFHyc22yFWjejY6JH07bT+GEY25A0aZ5U1zAvtKA1Gs7LEA+Xr4tNc1TiD7ipYSAq2TdcprqHDpPnHLG7aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ADczM9rRatWoaTBZierwpypkKYPxRe6EUWgRxuCYL4=;
 b=FSrj8Apj468yMs/WcrJxM/JdQiZxm3UoEB0SdVmuSGnB/tmZLJP+4p2b/jvtnMC62Nw04HczkD3lI2lkAzbd5TWjrOTdNjXSZH28rR9pdW2C7oBvwLJhuS67XgUqX6rzv3ZIjbRKawZ0sXnbvYvt/WmbG2bVIrQoDwozYG1LFc0KUZDcjZ7cjGVK/5KxP643A4Qg2gl7avqcW6XZyY6mw1MXs+5Ja9QpOr7bhVBxVaVJNxIENDKPXZegjsc9EE9bI1WKDyifvuP+pwNoUQAlkpbMwER4pQ7ChS4/ivMJMB9mWV54vqohjmCaRG5jKO4R4/zWs/ZsK1ZtDByi/Ib2aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ADczM9rRatWoaTBZierwpypkKYPxRe6EUWgRxuCYL4=;
 b=hT9/U4seHqbWNly+ClYQN/Y6wRONCwWjV56/RzncH753ZHBjefEZc8L6gVhlJlZnYXlKX5DrJWIpN0wF7IFVQAZdsnVN7PgukHjPsIBVzlVTWmDzFv7aQ+tGlVOa/SFDHcgetZKysIneks6nCbqkzzQEe21lPfAAXySGCkj73/kxth0YWqjvxy2dOSYWyNjaxAqugVcAv5DnWyDFhM5nKS2KmQ8sqxsxIR3uszPTSdhTwz1J/msnF4mvY+qlUvkxV1kAelTICGhPVsnlIbeJu/6RvaOOFUhxeM+d9wVLqiGKAwBhbDhBGhGc6V2POBz1qqvA9Qy0UEUHEqp16H6ONA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by BESPR10MB9268.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:b10:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Sun, 6 Sep
 2026 11:32:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0382.014; Sun, 6 Sep 2026
 11:32:53 +0000
Message-ID: <38b562a3-5207-4268-8445-640fbe8cd7b5@siemens.com>
Date: Sun, 6 Sep 2026 13:32:53 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Allow to select EFI-based factory reset when
 StMM firmware is enabled
Content-Language: en-US
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
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
X-ClientProxiedBy: FR2P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|BESPR10MB9268:EE_
X-MS-Office365-Filtering-Correlation-Id: a6644624-8da3-40d1-1393-08df0c0a96fd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|10067099003|56012099006|11063799006|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	WGC+thAbzyeHdg+Z4HcSaC7FuWcVkQ9VsUZ5wCYLh2tdjcfMVGkSGhNQb/3NqWB2hZ0qj4jhz2KgMVW6VJt1WSrL526uLf3+7BSKy6xK6i7pMam3Z/56pTPaxvbzkUevQuvXGJOGazfqyej9UGl0zNw4qKOCsoD0qIg9FctJ8rMvtznxuU6jnuhTgVP2rm9/naXlNhfgJBXghEAEwanoddTPlTf8/3g799SGa/oOrP8ayRRaTd3NNt/IqdcxiGQ3EXXxICronb5IcVORF7Z00qj56obYICWtly0QePofA0erTdl4LgW2CpY8Usd7hJOKzwXlJiDl//tqEYyZOFgh8DZmRPUQVFgzzoPHq/L98znJ6u8W8eYnfU0YtWI7K9m8J+eILEuLgHbiB7Pkh8mgU1PGzujsBMymyQ7WVe4UOLIqpG6oJ15igXrQnd9j7n+0Tbeq6DgdiNjY7bsnE5N/iDdLf9Glt3di/SBVA45ZaMUjhcoj5N+fyUI/CA4oNt3dBCodBIXoQrTfsA8lfgWkcAyqu+VzuMxZC414eFDv99WKsVIX3awYckWuGHDppfOz94tNU2eos2FnJ8JzJfhkL10VduArSjkF6QT/Un2MU2/HdnGfsYXsEe5pJz0NZnQ7nzUhF048lCVAlmZ7zTSwu3xGGxRerF9fmxFTFYvi+ZY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cTFIWlpOTjhVUCttQUNJYnNRdG8wVGpCbnE0QlNJRktJVGFmOWdlemlzT1hs?=
 =?utf-8?B?N0FaQWErbVdiSnVMNEN3VHlnRlNxREZRQXRCWjdVQzViY0xpdm03a01oU21h?=
 =?utf-8?B?T2Z0WEc3QUo1TnZHUmI5SmF6b29ySWRaNUtSa1Q5anJqdW9zUjY5QW1DMWRL?=
 =?utf-8?B?TFJ5RFFDR1lvNDUyTHRZOE0rZ3E5M2dCYld3ZUc4b2d6ZFJHelF6RzY4L29h?=
 =?utf-8?B?Q1N6RDg4L2xBc3NUWkV1RkRXY001d3Y3L1JpRSttLzhaM201L2FTenY1VGxM?=
 =?utf-8?B?anI1UTFpZ1FGb2VoRm0wMFl2bXhwL2RpN0xsVnFGZ0FTMVZNZVAyZmVnQ2dI?=
 =?utf-8?B?N3p2Z0N1SjFaRW5wN095SnlmU1VwYjFxTFVoWi9aRHhXZUp1MlhrVUY0R0dG?=
 =?utf-8?B?bG1FbW1VMkFPNmhnMUduV3krS1BvZC82eTFsUjkvd0ZXbmRYVjJtMHVmN2hn?=
 =?utf-8?B?RzhMa0wzOVhiMGlkeXhIZXBhVVhDQ3RVbUF4bjRDaWhhUHllU2tGUlZxQkVu?=
 =?utf-8?B?aUpuTm5URTVwNWphaVJjNjVKWFlldlJ1Zjk2SVlWc1pkNGFEazMrYTNiMDEz?=
 =?utf-8?B?M2t5aURLUWNMRWQ0UzZvNWpTVVFWQW5yL3pnZ2RIWW80NDQ0Y1FqUlk3Vmkw?=
 =?utf-8?B?dG02UnUxY3dDRnkzV3Nwb2VnY2FSUlVJTXRQWFlPZndEbHlpcnk0d0dmZ2I5?=
 =?utf-8?B?OVdjWDJYRk5lR0xwZGpEMWJPWVFLejRRbzloR05lby9DNld0cTBWZUxhQWFn?=
 =?utf-8?B?d0hoY1JnNy9iTnlSSUt1dHU0T2p4ZmlmM3dYSTBJeUszQXFZeHhiU1ZyMnkw?=
 =?utf-8?B?VDZ1Qm1OSXhndWJCakhPTm9ibFUwK2J6RkRhWlozY1g3M0NNN1hoL1FNa1Nl?=
 =?utf-8?B?WERmdTNIbWNjQWFVY3FUOW9DU2paaFljeElVc05hRUVVZkR3dGlzaGZ3cUdr?=
 =?utf-8?B?S2pTcllveGg1aFZmc3pEajkxNnlNSEdxTUJPRlRkdStDLzlyT0xPcTNxKzRn?=
 =?utf-8?B?RDlzWXdIbjQ0djRWRmFyQmFmNVdvdmUvODRqcjJIWHpYUXJsdThZSXY1VHBl?=
 =?utf-8?B?NXA4SXhzYzVYdkZwY0VHY3ZHQ0Z0aGJWdlhvMFBHeWROUGpnV1BDM1lYaHo1?=
 =?utf-8?B?ZkZCQmUxV0pacnJjUXJTMFllUlVSZWc1K1VkdFpHMUt0SjhJdFZmc3h0ank0?=
 =?utf-8?B?T3NjaDhZYWZBVDByVTE1WjVaY0lyOEFiYkQ4Ny9tTzQ3RnhYK2RFWE96KzZ2?=
 =?utf-8?B?dnlaWkNDODV3d05rTGJyN203RnVma2hHSzFPWmtXbHdvbHo4YTlRT2ZRUVhH?=
 =?utf-8?B?eUlWQVlva0FuYTJPRHFWU3N1d3hkSTg2K3ZvcHlpdDBqY1F3SENITHRyQWZ0?=
 =?utf-8?B?YzBXSGJlWFR3ODFOTVl2SHpueSsrZTJpcDI4SVpWNytobEhSV2tOZXZKYUZp?=
 =?utf-8?B?WGd0NGFtL1FjbmJocVpWM3FJRDdLeHlZWkoyZE91Ti93bEpBTU9PMS96YXVF?=
 =?utf-8?B?Y0x5R2k1MWZET3QxcWpEY09DQjFjaVp0Z0dRd3VTSk9uRjNQY1VmNFc3dDI5?=
 =?utf-8?B?V084RGRNNmVNNldQaDM1cE03cUNYUzJrMDdDaXdVN3JCYWxXWlUvcGlxenhz?=
 =?utf-8?B?T1BFOFZPbkdoMktoK093WC9PTEhZUUtNc0hZVjc3a0JkOGtZNTloWU03T1BC?=
 =?utf-8?B?NzExQzdNcy81VEg4NStxMEdsdC8vMHVpWEdCejV5cjQwek82cWwrWTRvclZx?=
 =?utf-8?B?VkFaZFg3WWE0VFJMcHJJd2FnUTIwWUpVZkNJUDNHc1pMYUs5K2Q4TURENnRi?=
 =?utf-8?B?bTVlanNNa2xaRitGQUlNOGJLTFBiUGVvdnR6UW1YY3FRUXNVNU5DREJSdFhW?=
 =?utf-8?B?VDlLWjd2ZjF1WVMyeHlmYWNJWDRSenhIQ0E2d0kxWkIzdWpuSHlrYzcweXlt?=
 =?utf-8?B?MjcyeDZlMjM1UXVOdEhMZjBaWEZ5NzZOV0loYmUzK2lxNDdQdnZ5RU9SOEV1?=
 =?utf-8?B?VGlTdEhlTElsSW9qZWtua21sb2dxa3c1aG5sQlZkZUJvclpmZEwyVDNXU0Ju?=
 =?utf-8?B?ZnN3MkFlZDF0Kyt3SllsZWF2bU9zRzZxNmZkYnFzbmszdnNlaTZmTWlqcmNU?=
 =?utf-8?B?Wlg2eVczNUNJcFEvTURpa1dHS2I1NklmSUlqMm9zakM4eno2SXJuczZqWDBs?=
 =?utf-8?B?YzQ0NEtLT3ZPbkI3K1NudVJLQVJBVjVLcnNxL3MzNE50anBOQUlrdjhFSEFJ?=
 =?utf-8?B?K0pzdGFNbTZRN0J1MURLczNlUFBiQW5CT3ZXRVRJenVxZWRyVUtxVEdrR0hC?=
 =?utf-8?B?SHVPZzJwV01RYjlPMWE5NWdBd09wQUg3ZnpuWTlIV1pON216TnJUdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6644624-8da3-40d1-1393-08df0c0a96fd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 11:32:53.3510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGaA2jhIDZwTyzPm7+n1d8UVaaFoLrWpj+MJCIOSHoQoYeTa006V9RhmgslkTF5QYR4fmFjF3+L7GYR8RlaCIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR10MB9268
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 06 Sep 2026 11:33:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24097

From: Jan Kiszka <jan.kiszka@siemens.com>

This firmware provides persistent EFI variables.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig                         | 1 +
 conf/distro/cip-core-common.inc | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Kconfig b/Kconfig
index dae87f6e..490af8d9 100644
--- a/Kconfig
+++ b/Kconfig
@@ -209,6 +209,7 @@ config FTPM_STMM
 	bool "Use Firmware TPM and rewritable UEFI key storage"
 	depends on IMAGE_SWUPDATE
 	depends on !DEBIAN_BUSTER
+	select HAS_EFIVARS
 
 config KAS_INCLUDE_FTPM_STMM
 	string
diff --git a/conf/distro/cip-core-common.inc b/conf/distro/cip-core-common.inc
index 8a1db618..99218c3d 100644
--- a/conf/distro/cip-core-common.inc
+++ b/conf/distro/cip-core-common.inc
@@ -30,3 +30,4 @@ PREFERRED_VERSION_linux-cip-rt-kbuildtarget ?= "${PREFERRED_VERSION_linux-cip-rt
 TEE_SUPPLICANT_IN_USERLAND ?= "0"
 
 PREFERRED_PROVIDER_factory-reset-helper ?= "factory-reset-helper-file"
+PREFERRED_PROVIDER_factory-reset-helper:ftpm-stmm = "factory-reset-helper-efi"
-- 
2.47.3

