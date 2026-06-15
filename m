Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20EACD98CF
	for <webhook@archiver.kernel.org>; Mon, 15 Jun 2026 13:46:22 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.63])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.129763.1781531176475951903
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Jun 2026 06:46:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=rhI69oWX;
 spf=pass (domain: siemens.com, ip: 52.101.84.63, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gVC8JtETpabMhzt/R/saWAls88vLzG/Vmcf2Z0VMNJoWwpQextHzvCGd9sI9Ijb8hBbfSpIIXWyhlxXnCJUDllUr8EMBfiokK1KrPYIB5Zwl4aW+rrPJjyY6+ZTVdU/WBF+yS0hj5hQw+XRhnRp07ZSEhMgvE01kcqzTtiSJ8N6EOEsLy3HAh+JGVqtsv+MG7wUSzuJHTQYu8HUfBPWGCUgSEAp3tDULxCHpRItjsFHMgDZU1GG/6Eth26PFhxhTUNOgkvKIjyjb2xcjx/2c+xkbbY9Pas85fpfE/HcjfXlV1KA5R2ZgMDlNn3YBYmCIRBq8NfDz/jzO4u3WZ/WdZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUJKYOUQQkQaTIz3tAbPu4JmeSP3ZvdrPmRYcU7Hrt8=;
 b=PHRYqd0sC9olq+HIMDxA1xtNssKU9uvNFlSbrYb5ksNPIu8DM+ndEtZlbPT79t4IUyLP5Y25pJHmVL2hJhvElGYJ9zjBDRAPFSHC8upXzMH5xMmdp5BTbiUVohzXn6GuWs/UVug72GwLSR9YMKjR3KyRSXXY99irs+AvEQLsmPwhlRyfLZO2Bu2XnORE0dt2L9/wG1xekM+q34+Za0o6TdpYqS0qj3rnocIdtp3AVjwB+ioX2B0Jq+8RlGCtwPTHRTzjWkdznIia4kDv2vtynoGSsNgqFWEKYymt9pQZwUbGe02jVZxkm1059B26haKbtNLr2O0d4R5ELdJSqjWE5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUJKYOUQQkQaTIz3tAbPu4JmeSP3ZvdrPmRYcU7Hrt8=;
 b=rhI69oWXkLA88D6t6lgpQuypU5GjK1ghivV96ElWisZRdDY1UWLxFnJJ/elHi6Mdt4x/PJbZxjf3Gqlu24JhrnT8NIFOC3DaNWVUs+qiBX8nsGHFGSxd0OTI9SXQRPyhcQxqeq6eme75wiGyxEQaPAiYSFRnsecYEcVPiriXBZoXtFjQ5KeifQkk2se0A/KV8egfyjQeWF3KDSdqBtxdv2WdUn/K/hdnWGyEsUILIO+uF2ybqgcxgv7I7F5Xzt5JOdBT+cv8H1mKBSDrrOuG8ZJ5Iob89wgm1KtyH4dtNnz0tsOcRMpZukFiz3KP4dqIfIVnhZKHPGW59PsYhWfnLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV4PR10MB9594.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:2ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 13:46:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 13:46:09 +0000
Message-ID: <3ecbe1b2-9260-4810-8fb1-2869c2904159@siemens.com>
Date: Mon, 15 Jun 2026 15:46:07 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: isar-cip-core: freeze for v1.12 release ahead
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
X-ClientProxiedBy: FR0P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV4PR10MB9594:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dded261-fbc0-441b-f671-08decae4749c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|55112099003|6133799003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 
	b7TcnaWn5UJmrPEE2PK4HquZCkH6stAomXihwElhxrXYQckdTUperjwh0YA3ZQmRUrYSOOZf2AzzlqToNww/mmlqj4JfL3TofKHsphhML5Z6QiXATjVb0LQx1aBs1RSJz8bsKnc44nKFLvmjLXQG6Esiku0Rw2dKwLl4FT7Up+DK2KjpxjLbOpMh8CwlgBBH24ZdqpxyP1f8NlZBlzRix6aqcLUI22zLG3GHkgRNbwX3LVo/1HPgITU7TQ/XpXoCDqzDdeBFIDCwFRTP4eg49hmFDOudGEsro2gdR8voNcKMInTZKDm9j1igwzHzqaevgEVJouUm4RK6JZPCmX16P6KscEHKy8/OOi5KeBwtvvsWQOmeBD4RwGYBqf5gkKHvQlrjZIwpqI1gAlNTiYs+xvOsAknLkcVyLe2+7m+gUV6PtDLpjgjiya7U+GOPDiW+O1/YJxD7u9b9mACSZD2NGbvet465GpQJ33GFXERJSrqNBIb0i5WUi2iRMXUl9rSbpGdW0zP1quev7KH4C8Opm0krmy5+nK4AtEfJvLUyCF6eX7uz12HpM5Os/oRXlS4VUg06Rxa1Dt22YTmpBHbFQ4phdDJEEACbr9wXGmqxwNUKDtLH2d4AZKKU8nsCz7vmYN3Yg8NAsEr0+hg4bgYCEqmi83PBQHE8SqaToiNW0QZ3vfxkeyp1saI1/i5WNMKi
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(55112099003)(6133799003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eTA1bHB6K3E1UXBHc05saXU5Z3NoeVJmdm5vVjBuclFEdzNCWkJFend4SjAr?=
 =?utf-8?B?THpxMEc1OXFBMW9GZkFZS3ZOWi9UYzIrQlcvT0FQcnJEcXZMdTdKQlhDUDFz?=
 =?utf-8?B?LzViRnFpaGdQWkFKTW1reWZuRHFxSUFDd2tYSXVvbElwbTlIRDNFQkQ2RWFH?=
 =?utf-8?B?VUhkTEVuSFNHNGN0bWgvTUFGR3Z2SHpxN1NZV1FPNDZqbC9va0Y1MDlNWVNG?=
 =?utf-8?B?bis5dEROazVvajVuMVRyYWkvTzNDdWViSEtaMVVVSHQ1bkp3SlJiUTR3TGsr?=
 =?utf-8?B?TDRSR0hibEw1UFMyRWNWTTdwTmlUTENTVnZ1UzdHZ0FZM2FIVlErcWVmMHIr?=
 =?utf-8?B?TGRXdmdRQmpoYlF5NU5rcSt0WFFwamVCZ0d6cCtVWHp6cHJOdDV4U3E0dUQz?=
 =?utf-8?B?QkEwVFFDWDVOeGVQUk1ZYmZNK1hJTUZ4RVFsZy83TzdjbTg0aVAxalJtTk5i?=
 =?utf-8?B?TlZidjNHWVBNUDl6NE9TVXJDNHg0R1dEcXZNMWZ0T25BOXVnQ2hMNVlTWklZ?=
 =?utf-8?B?OE9iOEM0OXpzb0VNUXlnOWVYNm41cEJkZHRZbmlRYmZESEVjcThDVmlaMWQ3?=
 =?utf-8?B?VTYwYUhUckw1MnhjSUZ1SHpnYTgyNDNpQlB6eFBwUjU2bXZtMHZOOUFhVDgy?=
 =?utf-8?B?SzJvMnpyZnpvYXZnY2UyRzJ1cGhVM3lsUkl0MjVweUQxRm9pQ1B4RGNOVGtW?=
 =?utf-8?B?UjQ4Wno1Qm93dmpnN0M2bGxmYUY5UUVGTVhyazZicFBXV3pYMlhGb290b2ti?=
 =?utf-8?B?dElCQ1NoRnNldE5xVGdDUzVFYnFLaUZBTkpQSW9yT0xLSmR3MDV4N0pkMk1E?=
 =?utf-8?B?QlUyRlFlVjIwUnVpKzJYWGdGN054VkVLOW16VjRmakdNNXBoYkIwd3ZtZytT?=
 =?utf-8?B?Vm1xMGxOWjQxeEh2azRCaHduZjJnRFlSS0JFaHQzVGFoeDlZOUFrK2d4bHFO?=
 =?utf-8?B?TEo1Z0g5QzlERmhVbmtmWEhpak5TNTVKMlIzR0gvVHhlVkxkWlY4NWlaNmFY?=
 =?utf-8?B?TWg4QmhVQUJJREYrWXgxUGM0cU1XNzR4V2pwUjhjMDRvOXVDZWppUjdJOGkv?=
 =?utf-8?B?MCtQRXdFaGtrL3IyaGNYMnFuM1NWODRkYXlEZkxvVW1zOFdzUTY3cGRaVHlU?=
 =?utf-8?B?a0djRUIrc0R3WXdHUEpKL0hNQlZhekpsSUcybUpxSWZ3UTVmODlmRnc2RkVP?=
 =?utf-8?B?dTJhUUlSWmgycTRVTDIzVEtWdTNwT1VjMjhENDdhdmlqVE1YWHVEa1M2RFFk?=
 =?utf-8?B?WldNRWE3SHkxZFFxZzluemNwSzMxZkJMVGFHOXozSEoyYXdxbC9zREVRemEz?=
 =?utf-8?B?cnB6R2hDc0JZeGZQZVQ5Z3o2VEUwRGhBZ1lYa0VadmYxRFhxUUcxYjRyaHF3?=
 =?utf-8?B?UFJSWW56NXBIeERGeXgrb2wxTDZDNUJZNElKcHVBeVVTcmJWaGs1U1R2NFZi?=
 =?utf-8?B?amVaeWorcWVJZ0hldEQ5OXNqRnExUGZSN04zUXFMb2xLUFpBNC9ZVTB6Skpq?=
 =?utf-8?B?dVVyV1F1TG5yWkRtWDNnZ2FZTzk2QWdwdGZlaDY1emNYbnU4N0VjeXlZaVZo?=
 =?utf-8?B?bjlZdHZCSmU5L245Z2xWeTJwazRuR2UwS1hmemxXUnJNMU9kWGQyZi9kVWdI?=
 =?utf-8?B?bjJmRE91ekZWVVZRWm1pU05qd1gzc0Q5dVlUTm81d2kxaVByV3RLWHhmdDVH?=
 =?utf-8?B?cEFFcVlaWTRpazZaSFlrbFdUcSsxeXEwQUNPQmtkL2tBMG5LM2k5YmY3Q3lK?=
 =?utf-8?B?Z28xTjZzUEhCZ085dlR0U1pubzNzU2JuMEFDdWc4Y2N5THYrV0xLZStRSUtC?=
 =?utf-8?B?czlyWklPaE9yZ0MwSzVrTkNzblA5YVNvN2NQU25FcVJlUGYvRXdKQ1EwOG5K?=
 =?utf-8?B?bGtjRDEwNUcyT05GcHpDNUFiRG41c3loK3kxbUpORmQzMThhTkRGaHhvRnZO?=
 =?utf-8?B?TXpRemZobXFBR2w0WnZ3aTUzaTcxUjBoS1lHejc4dEN2VlBlUzVDaitCWDIw?=
 =?utf-8?B?ekxmVGx4dFdiM3licDVIZTFmVUtpTG5xR3Zyb1U1RUxWMlZ6Ukl6Y3U1WEls?=
 =?utf-8?B?Y3JIL1RwODRsUkljM1RHNVM1ZkZ0TnFSMVYxdzJ1ZjN2dDY1QXF1Z210ditB?=
 =?utf-8?B?Zmx0eUYyRWxoY04zV05XSUgxM2pJQmxOb2JibUsyM3IxUTVSdWROOS85NU1R?=
 =?utf-8?B?aW5zTWpXN2I5OC94SzAvSkhGdDVEMlQ5cmlKU1c4djYrQzNXdkVIbEJPQVpw?=
 =?utf-8?B?KzBjcXJNa0p1d1VzVHhUVWZVVUdXNjAzMmpJVUliVkIzS3pVdGNEQlV4VGh6?=
 =?utf-8?B?aVBmRmgwdWo5OHhDMmR6eHphZGVvcjhkdm92ZGhiLzI1a1YzS3NhUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dded261-fbc0-441b-f671-08decae4749c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 13:46:09.3008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /JArqzrRdaUQU+x+As2YHsbp+5sToaagiRqPHtv/RTcPGU1F8+dnyLaWHKkcFZvDzl2qwqpxXjwb53B40a8YTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR10MB9594
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Jun 2026 13:46:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23141

Hi all,

trying to target with the next regular release end of this month, I
would tag 1.12-rc1 early next week. Please make sure all your patches
that should get in have been sent, and remind me of those that might
have been forgotten.

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


