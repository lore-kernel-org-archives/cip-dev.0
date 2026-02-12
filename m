Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD96EDF051
	for <webhook@archiver.kernel.org>; Thu, 12 Feb 2026 07:31:42 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.63])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.40910.1770881500273231849
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Feb 2026 23:31:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=XvM4y/ro;
 spf=pass (domain: siemens.com, ip: 52.101.65.63, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X7aK51uZYOvnpQrMon6EOmylhjeji87EY2OXK/ah4wa+AFSKKMwFjYtqFH2lkC7RKQg6XEcZtENxfCPjuCCXdxBZUIEjtD9IfbosA1twmY/aMdYQ1jMu4Aro4I+9CbpqcLqLX6Ls7S1BThX6SLZRLkYGQLRtyGOi2J//Ms2fs6wH55RHpVhmtenZTwyfs3U8YaXDVhfzTHzYZRTW+SBn+nD3U77C45NP75rdpCKvJJGRk1+wj2vpsLUxTAXnIYMD49wuBGgMU8e+s7Wnp13evDCkxHWOcEpHIHR1srqfJdD78+cjoAMIz5qi/gofGieHVc2GRwJj2g8m2gMvuNgngg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFWOZXmzv0sfBMP1A4M2jFVOnKfTpuaQBKkgFOEijqc=;
 b=YlHI5+3bcu/EXcyWfOd3PcaIYz/qVD3tHgY/3/kaZRkI/fcGugxV0IATWZZsEH4Q+Ub+Tce4xOqB4D9mYS0mEXA4+Wm80d4+GNfoGkkh3PEe2aNlAmxWU6MAOsxm4PAshYZzrMFHwuv53WlHTaN9SPduxaytHb/wtDJXx6RUNW4L3DFuKPCii5873FKLI1/S8tOJ0n5s2smHGPR6uMUTcJJ2+e+IE4jF8DEhl7bmWYkz42Lso8NGA93j2ELXGCO+JLUjaRYpAD3H7hvFOIaDWychneg1kY3FCj1ARqpT8IkEDpynGBb9NGHOGW7gkNy0JnsIZ1gutETb/VrcoaDxfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFWOZXmzv0sfBMP1A4M2jFVOnKfTpuaQBKkgFOEijqc=;
 b=XvM4y/roq9dGFxOTQ0zSWPpTUWiGnG8JewKJt8frnRncIMcLE3fF4wwmL+RKG4vrKV+OaGd83csznJbYkn9Qqx0neeCBk0SDcaeuJFWctJxjyAryjPkXLbjn2HoQvgkT7bB1sY39onNGlf2m68XAUOJD2M+BUYB9oLYVCfZ44QfJibJ80jE4BJ2pOLlOwFSgi/XqknoGlSLooW3lOvJGXOaBRxJnamKqjjzvoC+2Be9RO+BTA2yKAxEL1hLi9z4GuWrjuriOwxj+FV7DbDfAzYDr7LzkBJqMgOPhG8gDcfzWwMOrlpRThLTRd2NYlJ2dOBdEcyXxxfqWLA5Gb3EGbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3211.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:117::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 07:31:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9587.013; Thu, 12 Feb 2026
 07:31:36 +0000
Message-ID: <0840ad9a-685e-4c3a-9259-411aa05be85f@siemens.com>
Date: Thu, 12 Feb 2026 08:31:36 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
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
X-ClientProxiedBy: FR4P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3211:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca3a03a-3bd3-4184-6e24-08de6a08c13d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Zi9yUlk1R0tqaG0yYXpxcElIVzNXKzdTRHo2ZmlUMGhJYVRiVVNZRXphWFFD?=
 =?utf-8?B?WUhjdU1aNHpuTXV1ajRPd0Z6YmxBNm53QnJuZERxVXloSHR1S21YMXpCYkVr?=
 =?utf-8?B?TWhaU2Fvc0x6MVhjNjhFMndxdVhIV2hXSDFEbEtCYm1PR003Wjl1MGhmbzV5?=
 =?utf-8?B?YXUybXcxYkNTcDV4Yys2ZG5GMUN3c2N2MWZwZm1VL3ZrcXdvcXZJU3hRdms2?=
 =?utf-8?B?R3NVRE5WZi9wSWl2N2pKV3VwVzBDanpoMUVkRWQxK2xnSTRVQ1JONU16WXI2?=
 =?utf-8?B?OHpkVmxBNHN3RjNXWXdDSHA0TGdZR3MwWFpGYUlCc2xtZUlkRlRJLzdIbEdB?=
 =?utf-8?B?L0RoN2JDc2c5SlIzMEd4OU92QVpDcGVhTk13L0xka05QN1BhOEF3ZHdrVWli?=
 =?utf-8?B?UXRRSHdJMm1Wb2UwMU9iRDAvN2diZmlrZWh2UzlUNDhNdHdjbzc0T09lSUZV?=
 =?utf-8?B?djZSRXB2R2dUamtrdEx0Z3czd1N2NnFWMVZuZ0o2WW9jNXVESW03bC93TkVr?=
 =?utf-8?B?L1dOWDA1OGxqeXNyVS9ZMDVnL1NPeW5vMDhuYmVSMHd4OWRPa1dZcXhzejg1?=
 =?utf-8?B?Q2hxbVZiQzR2VU9RTmhzWjI3ZWRBTlZRRTdBbWc2NXJhRFRmRjFmeFh3MXo2?=
 =?utf-8?B?WE0xQTg0NFNLTEMzb3RmZy9tRGVqN3gwR1VqSTFoazQxSnhjYkxEK05yVklu?=
 =?utf-8?B?MlliMTNhUytlN1dqam94bHpFZHFQcjZ5bkV1dGNSVnhKN285N0xVejNRQ29Q?=
 =?utf-8?B?WU5ZNkU0N2RUTFFoYkMyNzZyUk85aTJRQllzRmFSMlZDQ2UxcEphL29LdHg2?=
 =?utf-8?B?bHl4c3pIWXYrTTFlbC9DTzIzaGtORnNLSXpMVGw2WDdXYzNReGl5V1BPVXgy?=
 =?utf-8?B?VjBvODNwTldzbWwrb3kxVnltVnNNWEJhY28xY1VtU21zU0hVQUo3KzZ3VWlo?=
 =?utf-8?B?NytIU2RHMVNVK2tuamhFbGdNa1dOdkxhSUhxUk5JbnZ4T1ZHMDBxM09Ib2gv?=
 =?utf-8?B?dEZ2WDlrTXZWRHFULzcvUnZ1MUFGRUx0WjdrcjJLQjVMY0xSQk92UjRZbDAx?=
 =?utf-8?B?ZisvcUNtYjY1YkxjWmdYUVIwZnlFbCt3U1dVNlFlQzZHclZrd3dDSVl1QzFH?=
 =?utf-8?B?RS9XWGczRm56NVNJU0l2VDRtMUMyVXBhOXJzdVNCMzBYU0R6cWNWc0M2U1l4?=
 =?utf-8?B?b2FsSFBNN2o1YVRFNHpVbEVXdFkwekN2RTVzTDE5aFVaRTVWNXlnK1JubmNj?=
 =?utf-8?B?K0ZvdVZ6aVpYYk52K3F4NUUwbmRxazhMeGZ5R0ViaXhQSmlmZFJudTI1akY5?=
 =?utf-8?B?aG40WUYzN0FOVHRxSHd1bDBQYWlDNDUvK2NZZm5QeTlTcUFlbU8yN3lxQTFn?=
 =?utf-8?B?R09Nc2pidGh6UlBQL2dRdkRWS2N4QjYrZG1zOTl3VHV1K0xQZWN0UGsrRWNM?=
 =?utf-8?B?SHdLeFI5c0RsL0FSaFo3SmlxUmY4dllzK3pSb3RoVndKTjBTOXVpOUwyU0FR?=
 =?utf-8?B?azBFWHRaTHhKSXJMMlE5S0QwNDNiWlZRQ0RaRXpWSWRuOW9rQU05bTZGOGdB?=
 =?utf-8?B?bFJFZG1EM3Y1VGprUXRjdWgwQkQ4bEpGTGhMZHJKbDZLSGJPZUJDOWk1VmxF?=
 =?utf-8?B?Q2U1VkRaVGdwU1RUMXpyZDBhVGxjbDJhMjZ2dHZDZ1ZKeEJ1dlZIYUJSaGcx?=
 =?utf-8?B?Zld6T0JuRnhWUVZHcEsyb0VsSjNCMkFpQWpDMDFuZHUrREoxa0NKT3VzZDgx?=
 =?utf-8?B?azBzL3YvaGdYK3JtNjN6YVFuenNTRjhNN21sVmU2SG9yZlR1c3lkUDk3a2ov?=
 =?utf-8?B?dERnWFNwZXhCb2EzbHZEYVdhdEoxZlplRU84ZmV0Mzk2SjJqeWtWWjNHMlBL?=
 =?utf-8?B?RzFnR3BqSVJsbFlMQklGbFpGZ3dTZkRqU2NGbjZ1d3FRVEl2T3pJek4wOEwv?=
 =?utf-8?B?cW5IdXZDM0V2dlhIUzF0OWxXZkpJekhIcnNpWnZqN0UzVFBlMkpHRmhaY1Jo?=
 =?utf-8?B?UjRCYTMwd0cxT2VGT3JzTnFwWGlma1ltT3RxampucDFmVmo1OWFCNGZVYTY5?=
 =?utf-8?Q?+W8jmg?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ODB4KzR0NTdkN3RyQk9qemtQaGVxcm1jc3gxbUNTckVMRm41YldJRXZ0L1NC?=
 =?utf-8?B?aTB5MjhkdDhFSGNjS3BiNG11UDhnRk5WV3h5cHZsKzFXd0o4NjEra0Z0eW9W?=
 =?utf-8?B?c1RUc3RoZStnQjJRR01XeVZBWWtsMjFodHA2WFlxc1BCQTdHODl5Q2g0K2VY?=
 =?utf-8?B?K2JaNGFFSXZ2OXBJZXBDbVQ1eDFTdERpa0k4U1hWYmEzeGlTT1FLbTNWSXc4?=
 =?utf-8?B?dk03TnFUZEY3RzVXTDVtck9CczZXODduRXRuZ0M5MFdtZUp0MlFocjFKM2da?=
 =?utf-8?B?cWhsVUNRck4rSzFaMC8vbHJNcnEwT3Bja0ZmMFBKNEoveDdFdzhLVjd1UXVM?=
 =?utf-8?B?a3p1aVpkeXgrRlczMm9GWC9qamR4U0RyVzAxTzdKWEllNUVTYmN4OEpnNGxx?=
 =?utf-8?B?SU0zUEZTb3BmVis0enQyQVp4R25XV1BYekxBRWlqQU12U0sxb0NDVi9ETzdI?=
 =?utf-8?B?eEt2TVQzNGpZVjBsb1lPOCtQbkhvYkRDRk9Wa0NyanFRZVBOc000TUFIN1Rs?=
 =?utf-8?B?VVZCbVBpajJJNitad1F6OStuRHJGU05MdHQ2SGFlT3ZIWHJUUEZPNUI2Mmd4?=
 =?utf-8?B?M2JKZm05OEt6YlRRZ2sxVlpyY0RkTDloblBuTkVHWmRDbFVoOGdrRGFmSU96?=
 =?utf-8?B?T3ROTGZDLys3OXI3eDY3S1M5WnRjN2VjdDhRaEE4ZXkyME1UOEpvRjlWVFFF?=
 =?utf-8?B?ZFVzR05BT21jVHBFV1lWVUtUNHJwcWhjcnB6WDk1anRmSDdWTWc0MElsRXpJ?=
 =?utf-8?B?VjdmMFlrQkdZYW9SOEcwdHk4SG1qeHYrTnRuY3Z5eVp4VkZSaHRjZnJVNStV?=
 =?utf-8?B?aHNNdmdxdjYzK2ZXZTRNNDExUWFuaEdBU2tHSTVwc3JIaHkvakV3NG55cW9j?=
 =?utf-8?B?dTFwclR0eDVMdTUzMlJ4dWpWbmhuTkVqVUF5VzB5dERnMWUvQTJra0VHL0kx?=
 =?utf-8?B?SnFGUFptWThMWHJmaHFta01YeDU2ZjdsY1JkaTFQcGd1WlowSGJialpUQUU2?=
 =?utf-8?B?My9BaE9iemRBQkRBRXorbjlGZHVhU1QxRkxxM1N0UFc3OE05eVR5czE1ZDdQ?=
 =?utf-8?B?aXdtUGkvbnptMTdPUXB6MmlIQUVBOE1UckpVOUtIVzZFU2F6NDJuMkh1Tncx?=
 =?utf-8?B?aTYxTk5tWW9INTB6U091SVVSakVyWlExTERRSlMrd1ByMEl2elVqcVJJN1dq?=
 =?utf-8?B?SGw2amNzL1NjNUZFb1RTMlVEUmZqNHExZ1pmL09ZVGNzQ2RXYzJ1RlFXUkFo?=
 =?utf-8?B?YkJPUVFvSENZeTFuQUowbytPVnNMdXBDS3htSXkrVi8xL3l3QkVvdVROTk9S?=
 =?utf-8?B?Q2pGbDAwOVVPeVJUWFViNGxZNVZkTjFvTUQ5R0pid1NBaGw5MjBWazlaQ0Ji?=
 =?utf-8?B?alNFN1pHWDhSKzU5TkM0ZkFYU1NZTEVVTVZLb2p4VWw5R1FxMXBmMStqNkRr?=
 =?utf-8?B?VCs5ZGx0LzVvOC9GL1hXK0d6WWhTRU16Y3gwSlNGT2k2d3dBcTRneTRvS0p6?=
 =?utf-8?B?WGhtSTc5MzhrQmFzRDV5NVJqN3dVaU5yK1Q2TkZma1pERmRkSG9IQmFqWFFL?=
 =?utf-8?B?M0pkd3hiUUJlTUhvMDJLa2gwa244WmxCaTBqeG55R2MwQ0Z2VndxM1JSV0hT?=
 =?utf-8?B?M3lIOXp1ZEJkaGVtKzRiMjZjRm0rd2E2SjJ3OWIrbmxPaXNEa1ZZU1VZVkNo?=
 =?utf-8?B?aVNzWkJRUlZZWXFVYWs2OE92SXllV2h6WXN2S0NrUkZ5ZWw4dHFvOVNwZUR1?=
 =?utf-8?B?UkFRT2VBc0R1Smh5VmdGZ1hzZ083Tm1KcnhyNUlpZjVCamtUUWxUVm44ei9R?=
 =?utf-8?B?WW9sQytzQ0ExVFJVY2lDWXFaampqaXpXdHltekhjS011eVZNWUVxZVRvQ2Zi?=
 =?utf-8?B?UERJWG1tZ3kxRnB3N0x4cUQ3RzQ1UU5WSXQ4Q2Jaa1d2RUxYbVlDTnhoN3pv?=
 =?utf-8?B?TTBaalRLVlhzUlhFaU1iUXhiSVRkU3hmbWpUUCtxMkRQcU1wZC8zNDFhQVZN?=
 =?utf-8?B?eFNUcFVZaVJMODhSMzhsZWEvVDBPY0pPUlpkNjRDYkppbE0xUGFHOEs4SHFp?=
 =?utf-8?B?VkpsREZJWVFOODIwcnZsMHg0TUE1WTkrVEZnOHBzQm1wUUwyV1J4NjF6Ym4y?=
 =?utf-8?B?a25YM3pJa21EOHZNVnVxNTdFU0FKVmJzekhEZDNsdGtMWUxPR01aZ0s1Qmpj?=
 =?utf-8?B?V0lHblRrSHQ5QS9QTWtkdGp0TllzemxNS1NEcG51dWVKRjlLR0M2ZHRhOEdW?=
 =?utf-8?B?NGRRQUNjMlhtYy9tRlVJb0Yrc1E1eU1QZUx4eVV4MFo5WXFta3VKY0dCTlAv?=
 =?utf-8?B?UVZLM1BqQm12b2xQL1hncjAzYlVOWmhZWjVGOTQwU1AyNmF1Z0M2dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca3a03a-3bd3-4184-6e24-08de6a08c13d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 07:31:36.8778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQlFrEKgfHObl3+5f2uiEp+AGnBLffAFg9VgErBRL3dpxUa4blcGt7AP0FkUPS8Dw72Y7vlld6FaG60Jz7cxDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3211
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Feb 2026 07:31:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21859

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&month=2&day=12&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
04:00     07:00     12:00     13:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/02/cip.2026-02-05-12.01.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
Date the data is created: Thu Feb 12 07:19:29 AM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed Feb  4 01:55:28 AM UTC 2026
  limit date: Fri Mar  6 01:55:28 AM UTC 2026
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Sun Jan 11 09:55:11 AM UTC 2026
  limit date: Thu Mar 12 09:55:11 AM UTC 2026
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Thu Jan 29 04:48:14 AM UTC 2026
  limit date: Sat Feb 28 04:48:14 AM UTC 2026
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Wed Feb  4 10:41:33 AM UTC 2026
  limit date: Sun Apr  5 10:41:33 AM UTC 2026
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Fri Jan  9 05:02:19 AM UTC 2026
  limit date: Sun Feb  8 05:02:19 AM UTC 2026
  Status: *Late*
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Sat Jan 10 07:38:46 PM UTC 2026
  limit date: Wed Mar 11 07:38:46 PM UTC 2026
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Fri Jan  9 02:26:25 AM UTC 2026
  limit date: Sun Feb  8 02:26:25 AM UTC 2026
  Status: *Late*
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Thu Feb  5 10:58:13 AM UTC 2026
  limit date: Mon Apr  6 10:58:13 AM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Fri Jan 23 06:50:44 AM UTC 2026
  limit date: Sat Feb  7 06:50:44 AM UTC 2026
  Status: *Late*

