Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66560EF48DD
	for <webhook@archiver.kernel.org>; Fri, 13 Feb 2026 07:34:10 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.67])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.66908.1770968049185566411
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Feb 2026 23:34:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Nhtqdyjz;
 spf=pass (domain: siemens.com, ip: 52.101.69.67, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRNc8KShbtKKMKPH1fLwm+wpW+edvWfJFppvZoN5ILBf4RRBMT9ZZk5rmyRu3aaDGcPSmWgLUemyYHsPPiYxAnKcNLU3ZUMSpQ6ghFSs5Sk/Z8bPh+3tbTRWnO2g1I2Go6dnzjmxcA8RQfuv/Zl6ljNMwR+LTDaWEmeqYTju+KDHh9wwSyGk2cGw4xkvOfVSlwUtGZR56nWDAs03IErzvG8MSXPSLcmnsT2nR9zH0AV+fc4sPyiO+StpnB59vsNvgzC74v50jt9jSwQOe+nv2diu15NnEezRUNpwbpxhF7ULksil4Oe/RQiKk4yT6tL2LEnB8m3FdbtBhEpL07rqGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3zk1XrTChUVJ4dwZpErk+OGRMw//UCmYGcKl1zjXEw=;
 b=SFLoQhS63ky+1lXLjUEGGYongkwevxiFdF45iCgqfp2++LMIJ084WsZN/+7b70jzsKdTMRkDFCnXKR57lauXP8Ye7FmXRv26Hd5KD37DfiaA3py1BlmXLfzvo5sDTkkiabyfuxtUThVBIaHuvbCf5Rm91d1A3liXERtq/LQHnr6DW1mFN7Qirw2OHCgK7yi/ArDYMBetldIURFH6I7rHuNR1KryTlQuIsE7eZcccHvRtPrrgVNWq6oPNY+bgIXKTJMNi48HZRPHADyu6SDm9yRg+3eGaiJlyK+7XJVGuz+KQsGN5aEROAf2Q2xujv0WDtzy7MrW+IrdP23+5OHl42A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3zk1XrTChUVJ4dwZpErk+OGRMw//UCmYGcKl1zjXEw=;
 b=NhtqdyjzoStt27ERTCgjKHUIH6ofdUEOPIGSdCwNJscUVkY+9q4Nkj867Iyuy1CJq5zOu558wkhYvOT9aZnCSWLULW/lK85qPFbTw8KxOHQG6WXtxazo2qT02Kaul8z7vcC/yuXhDa/9ink85QP/WijrbA96m4W7SHScPNlEvr9I7BLLX8Byu6fdCoEGjib+Cigbvy0owbeVS3AaaIuhrTfVUx+lXWVaGHB2je1V0rHf8vN+ryJUiHY9hK+tCRcmMrSAdx8/hQfthjMmKxK1QZvby9JznTCNFR77EzdLElX8cxpt7BH9cEyjpYG6IscZ2WBDzHTn4F5YfvqtkNhwgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB8187.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:391::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Fri, 13 Feb
 2026 07:34:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9587.013; Fri, 13 Feb 2026
 07:34:05 +0000
Message-ID: <e3ba1e13-a952-4e32-9893-040801f3edeb@siemens.com>
Date: Fri, 13 Feb 2026 08:34:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] Release v5.10.249-cip69, v6.1.162-cip51 and
 v6.12.69-cip17
To: nobuhiro.iwamatsu.x90@mail.toshiba, cip-dev@lists.cip-project.org
Cc: pavel@nabladev.com, masami.ichikawa@cybertrust.co.jp, uli@fpond.eu,
 chris.paterson2@renesas.com
References: <TY7PR01MB14818948CDCC24C4DE8F193D0CD61A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
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
In-Reply-To: <TY7PR01MB14818948CDCC24C4DE8F193D0CD61A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB8187:EE_
X-MS-Office365-Filtering-Correlation-Id: c53fc2a2-4ba7-4780-d4b2-08de6ad243ea
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aC9pWVV0d1Y5SU1IbDlMY2Foa1llODczOTlKbjFJQ2gzOURPcHM0K1FUOHBn?=
 =?utf-8?B?S1JqUEVBQ2ZGNTNQMXA5dTQ2UlZscDVvazltYXZseVM2MkZpRnVMck9BR3ZM?=
 =?utf-8?B?ZDFRR1YrOXhvOHRVbEJpdlY0Ui9KVGk0S0xvckU3SnIxWElPTlp2c29FUXgv?=
 =?utf-8?B?Y3U4UmtQd1pRRWJsSEthcERtTlo2bncwT21nSTdFVFpXeitWYThhU0NvZFpF?=
 =?utf-8?B?S043Zmo5WWVtREtldEpQT3p6N25EWjB6WUt4VDlYbTRLWGNIeUxWYkxScEJr?=
 =?utf-8?B?K01vZkkwQkkwcUhIOUt6cGJMM3hsWkhoMEg5WmRrTnBqdWdwK0M3QXVDdkVP?=
 =?utf-8?B?WFI3K2dQOWpoSFpNMm40QUpKRmpXM0tMZG9icmNNQjJMQ0RlcVBVR09ndTN3?=
 =?utf-8?B?YTlVRXJDYk9jYU5obG9VQXlSZ3NKZ0V1WnkycWNiOXlwQmVONVZKYlVVRk91?=
 =?utf-8?B?YjNDVE9UbE00TVpXT1d1TDZWK080ZEJkMFFPd05OMmFOaGJqV3Q3TnhZa1Js?=
 =?utf-8?B?NDJURWI2NEdPbWwxNTh4VDJuY0ljZlpVcXNoZk9Cb0hmSFhORWNQVHA5cksx?=
 =?utf-8?B?aUZILzZPS3lvUlFHN01QeE5mQWhENmJQSDRHZzdvMUgwMzRlZ1Rodkk5QTRD?=
 =?utf-8?B?eUNwVHByZFU2enp1TzlWMytpWFJuaE1FdXM0R2tkNjdBWEJnVXFwaGN3eEdC?=
 =?utf-8?B?TS9ERERRMWRTY21IdTNjblllOG9OMURLVWdZcGoyY3p5NXJ3U25rbSttZ2Ux?=
 =?utf-8?B?c3hpYXZBVlJlT0dWMUZBdkRUMXhscGgxLzVGZTJTQjFsSTVJUHFiQzM2MVNE?=
 =?utf-8?B?NTlOQWtvUW9JQ29JZ0w5UnFFVlZtOWMxZG1jVC9xZEphQlZyaXByQ1Rua2hu?=
 =?utf-8?B?Zyt4RisyTW1oeStFT1l1SHVQQTZCc0w2WVBjSTBONlVIMmNtcCt2VFMwRFU3?=
 =?utf-8?B?V0tERVVTUFczTTZXWncwMk9HbStCQlBDY2F6N3ZSb2dpaGRqdFgvb0dhV05P?=
 =?utf-8?B?Qk9Yc0FYeDZ5Z0U3ejJxYjE0bTVpNmFxTFNXZ3lKWndwdFc4S2oyb2tEblRK?=
 =?utf-8?B?NXVVYXFnNEYvR2dpVnUyOFZ1amI4QytCUGdxZDVDckwzQWZiRVNJQitqK1dZ?=
 =?utf-8?B?dEpleGxjYlV1TmcwenRwOGRyRFh1eDR4RWUwa2RwV2oyMTVMRFpTUS9SOW8x?=
 =?utf-8?B?WkVReXEvMyt4cmFJOHdkYWFtZCt3YnpHUmFTQ2FHSmRjUHdwY2diZzdUbXVu?=
 =?utf-8?B?cDNjdG12TlRwSzJ2VU0zTmtEMGpYdzVyWGlrRU9WNG5hRU8rL01zV2dPMWp5?=
 =?utf-8?B?TkVTNnIyWlpvRGdSSnhBejlnMUxTdmRiQ3IxcmhYUVpYSHlmYWtyK1hFb2li?=
 =?utf-8?B?ZDk5L0krZmRwS243WG1sVXNjMFRMNU9hempSTFcwQ3NDcWdxMFV6clZYZXhI?=
 =?utf-8?B?WkZsUmJmcDBBdjdkVXNpR2w1ajYzWHdmSTlCN2dUTXZMV1VrYlhoNnBWUTVP?=
 =?utf-8?B?OWlzMGl0eXl4VUdGNHNPNCsxeEx5Z0UyRTM2Wlh4dXkveFdTeXRXc1dRdmtX?=
 =?utf-8?B?RmFneE42ODBZVUptdksxL0pEQlpVd2VUTnBma3RQTkRmbW1rWXdZOW5VNXY3?=
 =?utf-8?B?TUFKYjVtVTZacm9LTGwxMkdQczRsUytSK2hQa1VlK3YrZE1YSkJ3Tlg1V29J?=
 =?utf-8?B?bmVDRDRhNThTVEg3TmYwNmJ3b0d4OFhFcVl6QkRLaHpUUjFMWm1qb0thaGJD?=
 =?utf-8?B?M25jeEwvdFRzM3BCcTc5OFhFaXl1TDJ2amx3M09wQm1HL0tINENvdkl1UldM?=
 =?utf-8?B?L3JNaHU3amUxZHh4YUc2MldRTEgwVmtNSlNmQllXb01kcU01T3hhT0YxYkF4?=
 =?utf-8?B?eUZvTkhwUFhrVHhNYyszTDRqNjhEVEpTTHdtTHphWkFHQTdKTXl1YStyUS9p?=
 =?utf-8?B?cTFTa2E3V1B1N0R6dVQ2NVVIMXZxS3UrKzF4OG1tZ0FLVkVpbGNPalZTNFZS?=
 =?utf-8?B?bmwySDJGS3NoRVBTMUNUZHVmSjRZSis4QmhVOE1DOSs0bzJxUnBpQm1RK2Zu?=
 =?utf-8?B?OHFoaW9Hekc0WEZhdDdtaFFSckVMcjVwb2dtRHhUZUhERU9MMkJuamljTHpB?=
 =?utf-8?Q?FEjo=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YUl4Y1FiUmRDVy9VTDZLOWN3SWNuK3FKdXRYTC9jYU53UnA4WFBQZ3pIMUZL?=
 =?utf-8?B?djZEclBYZnQrVFJoOFMyWmhXM2l3N1RXeS95UkF3bHg2aDBob3RjUmJkYy8v?=
 =?utf-8?B?dzdCby84SkQyM0JaVXZld0xVZHBpL0VueFpHWEFWZHg5QzF2bUZtSTJXVEZw?=
 =?utf-8?B?bG1KY05ubjJCWmNTbUg0cGlCaFc1YlNiZ2pVUlBBOEU1WGFqR3RSdU5XUHpv?=
 =?utf-8?B?YWQrOEJMMlpnV3JXNWQzSVFmdzlEdjhzY0g4bVp6WTlhZGg4dm9Xb0pBTk9J?=
 =?utf-8?B?am8yTlk5NmtZYW12aVZzNXJsWWhxaTZBMmlud0xyVWlDMzFPeWxZeHFLM3RI?=
 =?utf-8?B?aU9XYUVReHVISjVySVdwZTZuSGZMYjQ0UlYxalR6WFdtMnlBM0RBVFNOelpi?=
 =?utf-8?B?bnowSmErdG9Tb2V0RTdTQVFoOHdMd05SanNTK0swKzBPUFJWYWJhMXlUcFk3?=
 =?utf-8?B?YTM2SnN6OE9jRUdMQkhHbzdqRTV5d1FncTRTd28zTDd3NG1uRnpPeStncGRh?=
 =?utf-8?B?QTJwbTRha1ZQakRncG0rQk5qYUFRZmFEOXp0alBUZWN5QzdpZTdhckwzSTVF?=
 =?utf-8?B?RDRkaDNWajV1U3hPY1VLK1ZkR05LN1pBUVVZRzQzcXlqc21iZ1lwTkQwTE16?=
 =?utf-8?B?WGdEVnZibXEwWGJzQ1p4K2E3TSs5MGZ2a2hsZ0R4RzZndGY1OXliaGlQMzIr?=
 =?utf-8?B?bkJWZ0JLWXNpR2VhSVQ0TTZvV090Vk5mc2xmNmdPZGpHR2RKWEJFTFVGQnBK?=
 =?utf-8?B?ZFlrMi9EMVRKaEN3YzdRSVRmMXpVd25DcnE2aVo5S2ZDSVZDVU9DN1lLNHla?=
 =?utf-8?B?M09mc0s4VVNpQTRIcUxYRUhQbjlTNVVLVy94Vms3UkNKaWsycGpGOG5XUzdH?=
 =?utf-8?B?WGFjM0kwYWNhQkg1QUQxYSswU3Uxb203UG5EN0NJWUhpRURkZEZiR3BjNURW?=
 =?utf-8?B?SmRFVzhaYVpWN1B2Qk8wRjFvWnNuOHl3NkFPN0puaTlRUzA5OEVnakM1N3dv?=
 =?utf-8?B?WnROOUhtNTR5ZEpQSGZmYStMZVFBei9NN0Ywc3pGY1lDU0N4Vkw1U2hETmRR?=
 =?utf-8?B?bmk1d2V6T0dvSVY1RGdaVHU3VGVhMTJ4Y2QveW9Fc3JEOEdxTitvampFc0NC?=
 =?utf-8?B?V2trbXlTVnE2QXBBbkNIYU83MlBEejZ0Y0pZaUNzQTNmNCtMZktVY3VMOGZW?=
 =?utf-8?B?cHhDY216THpwUVVqYm5EWFl6cFNaV1pydUxZcVlobUpoTmhRUmlEMVBUdXpQ?=
 =?utf-8?B?ZzQ0bElRWnJvZUF4aU5DTVl5YVNhMTJOaXBGQ2dSQ1NlMUI3S053Z1BycXZK?=
 =?utf-8?B?T1dEczcxQVJ1ZE1nd1RTT1h6OWt3OXNWN3VnZW0yVnBINTBzUm10YlFxZXF4?=
 =?utf-8?B?Q0Y2TlNpZE1WMU40dnJxclZ2K3BaMHozWUZJYlJ6WGU0UnJLam1ITG5jUUNT?=
 =?utf-8?B?QTYreC9ncGRHUG5zaHVoMWN4R0ZtUWVyZDBpb2Q4U1hSWWVKMkVCQnI4S3Nn?=
 =?utf-8?B?dkJUVXBZK0RXREFCM3NGajM0cUJ5c21RdkdWWkM1U1M0VG80VHBsRjl3RGlB?=
 =?utf-8?B?cnRhMGJHRllhQVN4aWlMK2prYndJR0RiUStlSTI2dmdVbERPSzJRQzYyMHFK?=
 =?utf-8?B?TUI0SVhNUEo2cmdaU2VaeXphbnpjS0xlWFhtSUJjZG9KOG1SUndCVnZQbU9l?=
 =?utf-8?B?alphclVTamdZWStYMjZvVzRhbkNueU85aHhFU0VaMWZMRGtiMUhlb3IzZ2xT?=
 =?utf-8?B?eWZsNU5ybmxQVEtQSWw1MlkrbUZIQ2hhdVpjSGFoTzhISlF0Q1QrZTk4ZkM5?=
 =?utf-8?B?TEVremNsUWQvOEg2UStxY0w1d09ZVUtLYVkxTGxaVVJqaTFFQUlUZ1dGL2pr?=
 =?utf-8?B?UGlrQjNYZkR1ejE4SXlCaFIzbENoMEVieXdVdmx5MGZyTTJjQk9pSHp3Ui9Y?=
 =?utf-8?B?MzVKUkxwTGlXNW92OG04QlBOWHV5S1U3N2F2YlE3Q0dYV1BCOUVuem90eUpU?=
 =?utf-8?B?cWJESStqeHV2bEQ1V1d3Y2N6N1g2aUVhVUxvanZSR2ZTbjNBV0J6Q3NhUk0r?=
 =?utf-8?B?QzN6Zks4Rnc4UW1XQnArYjUzVlc5M0VQTXJUSFc4REdDWWpZV1c5NS9oOWdr?=
 =?utf-8?B?Mk8xTkhjTVV4cHlYUTduVTZqVGhTVGxacXNCNTV2MjVuaXpuUkQ1NkplTE9D?=
 =?utf-8?B?Qk5TR2dVZ01sN0l5NkUxbU43Y2x0YUxwNUlRZ2luODdoQkJPUUdYOHMyNzZS?=
 =?utf-8?B?YUx6OUZQQjRWWGIvaTR3Q1JqVCtaek1YN1BsOG5IMzlLVnA4NXBObGxTL1c1?=
 =?utf-8?B?R1BhSE9JVmwyVW1xNkFSS2xDSGVqWThPeTFLZjcwL0hhUHB4WEVXQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c53fc2a2-4ba7-4780-d4b2-08de6ad243ea
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 07:34:04.9620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8SYl0MAjsBNKQ6dqM/asJnkPzerad9+DyIEclwn7yF3DmyzTkvBrm6KBLL/m68dnHg2FPOzG19pVmubPNcxgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8187
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Feb 2026 07:34:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21871

On 13.02.26 03:39, nobuhiro.iwamatsu.x90@mail.toshiba wrote:
> [ANNOUNCE] Release v5.10.249-cip69, v6.1.162-cip51 and v6.12.69-cip17
> 
> Hi all,
> 
> CIP kernel team has released Linux kernel v5.10.249-cip69, v6.1.162-cip51 and
> v6.12.69-cip17.
> The linux-5.10.y-cip tree has been updated base version from v5.10.247 to
> v5.10.249, the linux-6.1.y-cip tree has been updated base version from v6.1.159
> to v6.1.162, and the linux-6.12.y-cip tree has been updated base version from
> v6.12.66 to v6.12.69.
> This release includes updates for Renesas ARM64 SoCs. Please check the following
> information.
> 

Thanks! Did you also trigger the tarball generation, and is just
kernel.org a bit slow to perform them?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

