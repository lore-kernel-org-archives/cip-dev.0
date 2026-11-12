Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.5])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8347.1794466989089239453
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2026 23:03:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=FO4jqcEN;
 spf=pass (domain: siemens.com, ip: 40.107.130.5, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IZ9nNq9yUc0hyrOM0iR1Rx9Fd1YR0ocs4eFKOPfGThZFjNZEh+Ghs+i6t8Ht1LiLxH+oxE3NSKDyVvYN1UC8MHX50bTOcwg6so93B4/mxbo3lKrRfEifeo9D0cFv4bnaa50hJkaZ8w8SwT4bvzgxy7P0ctOln/ya7ldFE6zdAzrRFQRYA7DbJZzij1BsCMWjwO0fu8a1SrlUdRLGnrW3GoywWzZCKD0h4sCZ6pLNmH21ad9HSQE/FeKf0Hwm8q3ltYLlv9we+xzu66Ny7PG16RMGJI6/rag7Yh2iVFroWul964qBDNlNXSHPp+ryuEM8FpvlnvrWp8QvT+HPpJRi9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfxczYg3VkhDE5g0vk1jb3Ez2jRrZtKfC4fVaP+R0t8=;
 b=trT6RdKcBFjWLzjj+DuiAxQPNYkgxGcWw1FfqOFMIPTN2CrffP3yZ9FNNUxL5vGwRzJi//q24zzVxWyUoAJFhOTAuxDQpgCbfGPD8IP+7VVGWltISutE5Czy/TZe9zMd8ASAP9j2V7iQyA2T618nvSG1ByOxABZmOKE8uuG5nmpaj/pUwbh+1G0d7P2qahbJx0E/pmv9nyKxFXC5DfeQ2sGoSgF8i7Ds8Bn4uRoyxqK+tgzMAZtUHQ7y7h8Yy3tLG9YR6aNgiy5NQ1uKKoA8nvZSR4OhyiTZYEepPtOGkPX0S8UNVTDvoAImovFBaIBoo9PWKHILZUqOFvAQmCsSzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfxczYg3VkhDE5g0vk1jb3Ez2jRrZtKfC4fVaP+R0t8=;
 b=FO4jqcENDjaDJEgG9SOGOSsaEIHOtLpR4kcuvyO00esiEbEAahjnuNeXQZdqHsr1RMGn+P5ZeYnR2WyUGDsZqPXXStfM45QqD5JqIkrPwVu3+ltVfAQ1IvyftAjCnl9whR9pvEWRitq63lMi1jfLrd5xI4tTjKm2AZQhiAa9OghZ91IrnsVru+TkUpi7eIr0PunTorV9uU1gN2NrZ3Sei5aEYc5PgtICDCzWmcJmZeHObf9wk0mkVgbZ013HZDpYqwIlhcq0rlyNVoZRohDW6hpYRzAL1bfNwPievmd2316ufALLuZ7OiYkoi0fG5vKgnSc7CMWuxAbaHhZmRyBwUg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by DB9PR10MB5330.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:338::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 07:03:04 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 07:03:04 +0000
Message-ID: <fab27901-4064-4843-9d0c-09a748920845@siemens.com>
Date: Thu, 12 Nov 2026 08:03:03 +0100
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
X-ClientProxiedBy: FR2P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::16) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|DB9PR10MB5330:EE_
X-MS-Office365-Filtering-Correlation-Id: 476c9cf4-4dc6-4bac-57aa-08df408aff18
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|261026140227099003|261022105027099003|10067099003|11063799006|261021135927099003|261022075727099003|56012099006|261028144727099003|261009223027099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9cWvu7oqjQxvMCuhtk/OmEQLZvNI9M8nRE6+LjvHpkDGh7kHkUcGxvwCgdCseRVLqlN8DvMFXJk/0Va8hamE1o2TRQP/q00GE6y71RewFlFIhlzquNLIyVykBFytIqGh1RS3EfvF85zjfuAsCRv3GduEMBDgACZ3Q/E5kAnlB6ObnZz19xXa8sCZpkecV6gAqUeZiDkzVJ7y1Q+LtYMavhMhjBPYqWX0dx0pISIUbJdATjHWhmrlq15KHuYfNUSgFDniJGbZPj2lIccw24Ahk8X3GHytnggspXEKJ/RqnwgcuUx7AsyVrmZUw3PNihwabFpFEaffb1niRgQEcm4Hdqa8XubMEkUgeJLIf3cOzYsnPEYdO4lvhmGWcC3GyT8r6gSCZKBdINePuvHLEqbvSwbCZSOSG8QIYrmQFBvJnFO9n5TqQKI8aFAv4pxpj2FTMRH0KjwxqlZE1Nxgslr4BGjqUoU5r3MiZcCu4YrHL7IIHDjed0+uPEOy4Z5PYnmulaIaDaqiGHG11TE3cHorCVMGgkMjsqtCGpSQx5i9G4LRFR8Mi9N9+Kh+hzsj24azeNeJqPrY7NaemwVLgluB2NBPYFdSJ2JrIzkf1fv0Wys58SjdxW34GhFnY6IPgUx2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261026140227099003)(261022105027099003)(10067099003)(11063799006)(261021135927099003)(261022075727099003)(56012099006)(261028144727099003)(261009223027099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHV5SEVYajZ6cGk3ck51bTNFTFl0NnVCSUZGQWRLbEN6RmxPbnFUcW11cjdj?=
 =?utf-8?B?V05mUUYvaEFzU2JyaWp4RDVjUktaZXdydkVjTGFMTU9peGplRGp5bEU4RzVz?=
 =?utf-8?B?TFo0dHkrY2lKWFR5Rk1mc0tQRThHUW41ZnBiK2x5cmJYVThsMnNJMHlRTkVq?=
 =?utf-8?B?WnhCRSthb08vN3pneUU2bUc1cy8xQ1VDeEZxQlZvUU5jL2VVeFVsc1FlZG9I?=
 =?utf-8?B?VlZoRFF2TmdmNWR6RU9NZlpRRHhUandNWjBHeVNGdkVUVmk4b2czVnpGTXF5?=
 =?utf-8?B?WldjZGpQdXhUZlYvL2tkblF6ZlQ0aDMxdHZDUmJBWDdlb3BGc1dxREJ0R1VM?=
 =?utf-8?B?bEtsZHQ5NGRyZjJEQzJ6YlBBTXd2UjRCZThwZlZ1S21tV1MwN0NCN2tJWEpJ?=
 =?utf-8?B?OFgzMXNXMUdxeTc5bW4xNHNBazg4MTZpbFUyQU1wNU9DdHVvT25PVXBqVEhw?=
 =?utf-8?B?WTBKVlJPeW5zWnJtRDZRWEdVNitQWnU0eFFIeUdrVXJPS0xGTUs1d2l5a011?=
 =?utf-8?B?TE9DZ0JjOG0rbnMvRy81L2ZRMDI2Skd2YXRCR1R0YzY0a25hNzd3bUh4ZEFK?=
 =?utf-8?B?WmlNK2NlaW55enMxajZ1RVI3MlNrSWhybC9nbDcrcEhValhjS2t0TG1XTjhn?=
 =?utf-8?B?Y09RMjdmeTRLR244WXpEczhpOERYSjZoa0FsQ2ZPYmRlMHJLNTBLN0cvdXlH?=
 =?utf-8?B?d2s4OVo3bGRIY3c5Zk9BNGg1Z3NrN043UlhNSzJueUhMVlJkQVFadjVmRmRV?=
 =?utf-8?B?SnhZQlJFQzlwZ3AxbDBiclhTRjNOckcwTytHaitNQXgzbDRmTmx5ZGlsTGky?=
 =?utf-8?B?aHVKQ2R4dXRRMWEvQkxoSFFSTVVQSytUV1JYS0JTbXRWcXJZT3BtcU5aOGE0?=
 =?utf-8?B?NllLMEphNE1qc1JEd3ZRbGFvS3FUczgwNHphVGZKc050L29yejJyckxPMnpt?=
 =?utf-8?B?bGQ4MkNTWXMybUV6cVFEaDErN09NVHhOcTAzdWJ4emF1R0UrV1BzeTZMY3pJ?=
 =?utf-8?B?aDFmOXdzM2s5NUR0b0JBcGxXSHlXcFRHYXVOeEFXY0dYOGRxSE82dURacUFR?=
 =?utf-8?B?VHYwSmFRdDZ0NmFVb3ozRHBtNG5rNVFSWEx3REcvYXZ1alV2N1F3aGZpMHgv?=
 =?utf-8?B?S2dXTklUZzZwMVpNNHNCRDBzKzFiM0JiczY4RjVHcmF3VEhuZlV1b2xpRDlw?=
 =?utf-8?B?aS9mK2tkVmgvdVBnZ0JPN21KdFdsNFVXSFhUdHRiNTc3clNKVGg0NXRRVHRl?=
 =?utf-8?B?dk5XK25uVHVYYjVRNWtBNU5LL0N4R2M3OUFETnFKTkZrS1J3Y2ZtcnluT1la?=
 =?utf-8?B?OEZxNmc0SmJ5RGJFWkw0NzhsN3lNak9VWHhWSDBFVUgwMWoyVkt0UGxOYnZB?=
 =?utf-8?B?d011a2lmUHNSMHk1UWxuRURBbUlXbHZEcStYR3dDdVNiTVdWbi9ZTHM4dzZH?=
 =?utf-8?B?eWpIajluZ0IrSXFrc0kybHNqY1V5eVhxZjhXWmt4SENHTVcyVWNlWjB3d2RP?=
 =?utf-8?B?R2x3aWVmTWtjSHFiM2lzeXI2elVsdFB5RUIvVWo0Y0l1V1RjRmZrTmIyV01L?=
 =?utf-8?B?UTNUUTFxR2w3cmo5clljamluY2RGc2pPZmEwZno1YmlrTWVJMHlDVS95UkpU?=
 =?utf-8?B?bHRvM1NUaDlsL1htcW8vQ3NWdmlXQ0c0b1EzbGRMOEovdjVFYUVWZnpLaFls?=
 =?utf-8?B?ZXpnbFpQRTEvUEl3WXVvci9LYTV0OVBXSUY0bWFTK05nUlh6ZWRBSW5wbGpS?=
 =?utf-8?B?a3VUNXBSNU9VRU1TS25NVldkNWt0azhNRkpwenBINEN0SENiVU9SQmpicEFh?=
 =?utf-8?B?SE50OGJMUDhSNkJOeUpKVzAwWG4xQU43bzlGU2piVFBZNzRIdGNWREgzbVIz?=
 =?utf-8?B?L3Q1SWsxcmNzT0ZKbEQ3UTZzQkpBQVN2THo1YUtMRGFmbVhRL3d0cGwvRGpL?=
 =?utf-8?B?ZDNoazlwRW5OdDdKOXFEa0lFa05zRzFqRzdMRDdRNUpHSXhsK1NKd3dodmk3?=
 =?utf-8?B?T0g2cmYzOXNLZ2YxZndsd0hxMTV4WWlWWHRSVmsyZXN5RG5iUmMxSFJxSXNX?=
 =?utf-8?B?WDZtRU1yaXJoRVcvSG91ZHg3Q2FRVEJBcytYWjExc0JBaFliZHpydEtHaDBs?=
 =?utf-8?B?bmxKOEpJRFNiV3I0SXplNndDbFc3ZTlJTEhKNFoxM0lDZjk4QUwwWFZvSXE2?=
 =?utf-8?B?VHA2eElqdUZJaUZEU1puVW9vK2cxcDcybDNhTUlXWnRYOU94aEh4dENRTUR3?=
 =?utf-8?B?cFRveWRYeS9YUGwzdjF1cCtFMTA5U1p5eGthOGhlV0YrSzI4VzFDSjRWZkFo?=
 =?utf-8?B?a1VCWjRKQ0dPYmthRnNVRVNsOWg2Qkl3U0tYVEhrSi8rcmh4WGpQdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 476c9cf4-4dc6-4bac-57aa-08df408aff18
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 07:03:04.0127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k9mDKphUd9MQt7k8qpALDn8wPuQemxIsbboYEgwOCujL8awDngcDcyW+55QCg9k2T5NqImw6TTM8ivbx6FV1uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5330
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 12 Nov 2026 07:03:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24780

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6697/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&month=11&day=12&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
04:00     07:00     12:00     13:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/11/cip.2026-11-05-12.00.log.html

* Action items
   - draft of improved patch review process [all maintainers]
* Kernel maintenance updates
* Kernel release status [*]
   - 4.19, 4.4 - what's missing?
* Kernel testing
* AOB
   - status SECURITY.md

Jan

[*]
Date the data is created: Thu Nov 12 06:59:58 AM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version: v4.4.302-cip115
  latest version release date: Mon Oct  5 10:29:52 AM UTC 2026
  limit date: Wed Nov  4 10:29:52 AM UTC 2026
  Status: *Late*
linux-4.4.y-cip-rt: interval 60 day
  latest version: v4.4.302-cip115-rt63
  latest version release date: Mon Oct  5 07:16:38 PM UTC 2026
  limit date: Fri Dec  4 07:16:38 PM UTC 2026
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version: v4.19.325-cip136
  latest version release date: Fri Sep 11 08:53:07 AM UTC 2026
  limit date: Sun Oct 11 08:53:07 AM UTC 2026
  Status: *Late*
linux-4.19.y-cip-rt: interval 60 day
  latest version: v4.19.325-cip136-rt50
  latest version release date: Wed Sep 16 09:32:17 PM UTC 2026
  limit date: Sun Nov 15 09:32:17 PM UTC 2026
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version: v5.10.272-cip79
  latest version release date: Tue Nov  3 09:48:41 AM UTC 2026
  limit date: Thu Dec  3 09:48:41 AM UTC 2026
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version: v5.10.272-cip79-rt35
  latest version release date: Wed Nov  4 02:13:46 PM UTC 2026
  limit date: Sun Jan  3 02:13:46 PM UTC 2027
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version: v6.1.190-cip62
  latest version release date: Mon Nov  2 08:01:07 PM UTC 2026
  limit date: Wed Dec  2 08:01:07 PM UTC 2026
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version: v6.1.189-cip61-rt32
  latest version release date: Thu Oct 15 09:34:39 AM UTC 2026
  limit date: Mon Dec 14 09:34:39 AM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version: v6.12.114-cip34
  latest version release date: Fri Oct 30 09:28:17 PM UTC 2026
  limit date: Sat Nov 14 09:28:17 PM UTC 2026
  Status: On track
