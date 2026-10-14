Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249A1CC6B1F
	for <webhook@archiver.kernel.org>; Wed, 14 Oct 2026 09:37:49 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.9])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9411.1791970666749651175
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Oct 2026 02:37:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=GoRU++PB;
 spf=pass (domain: siemens.com, ip: 40.107.162.9, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NPNsvJiSLGFr7aqbIfTBHy01oJIt2ftKIeHXtjc5ZwnZ8nPxNSXN/FzJe3cJK83qId+Tl5y8Z3BJ0LkwDOrknduEUI36lKq25D67gJwt//0aMiQV2W0gfQJGl095rOIxtauTR87JVKpzhggRKXriamhH68GwKQWOyV1HlQ04cQq6TdmqhTVyb9w1zPQS/wRyhSmRgk1WBBCjthZjTbjwD0bmRWyk7yu1LtfoBFr139JkEd0U5A8TdKjk4WCeWj+a1lCZT/uBkmYRjCsmO674G3g6cKVJys+YJ0fusamgYne8aRB1BRMzc0rSmYBU3k5FfxwxcaT7L6k+0bembr+NvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKwS34devo+K8Myco2RZUIZ1l+DQXiTD7OzEwJBOpwQ=;
 b=TsMjWYxm3ADz1CTZjs9+TLi5NAgtX4ZOQfWp0b54ilJv1aZEINwEY4+PwyrDR2aO2pyOaZu+6yhTGPZze0aY7hibgdfm8ATJDEuRrMIlUhfhlIWivoQ9Wu+a0XW8q8qMWnwAYBwU9bUOmZcq9A0ZYEP1YNVaqsFjLBvWI2Jox0JeD4w9VFKRB+MfGP0Umm1tqDyEO5rhWNZwtkea6N8Gv9/oFSPClnfKQh1rQXtWF8+dEpmLL7/cDF9dB/yzoXHv0GLsVfoAOrV6LTqcDesFg3+o+NvFXbmjmiqOa+S550jXUlyHWY+guq96D4F5VMRTsBOSb2oyqat+hG6OIVFD1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKwS34devo+K8Myco2RZUIZ1l+DQXiTD7OzEwJBOpwQ=;
 b=GoRU++PBF8GtYewEJtgr4iOb9aQXsrONKn7Hrhird5mSgsxRumJP240yc0AQ8kj+uTnUk+L+j2l/sIbZXEa44NfoUT6U4bAnd1zckljrwJr2NlE/GkOtxlG8p1cp9BA+tyD8bJTAUqte1qWMdShmcGoqmKOm+JP829miCaGXsD5kqoIXhf/G8Q+qrnSrPyKnQliv35D3638EP+FhZ+SQWqtG577BmXSXnmD3gX4SpNxYYa6HvFXxwyxxlQH+kKicPHdCtwgxh6r3ekS1pjnjXOBWGtl1LUyq1d0U4MjPBxdiTeMEKZoEjeo2YAOvKRatnLBTocAbwraaom0n/SrYLg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by MI9PR10MB536290.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:290:c3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 09:37:42 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 09:37:42 +0000
Message-ID: <46df214e-eae3-47a3-9176-060568b80a38@siemens.com>
Date: Wed, 14 Oct 2026 11:37:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] Bump kas header version to 23
To: srinuvasan.a@siemens.com, cip-dev@lists.cip-project.org
References: <20261014092943.1108318-1-srinuvasan.a@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Cc: Felix Moessbauer <felix.moessbauer@siemens.com>
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
In-Reply-To: <20261014092943.1108318-1-srinuvasan.a@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::11) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|MI9PR10MB536290:EE_
X-MS-Office365-Filtering-Correlation-Id: a70b0e14-ca02-4431-f11d-08df29d6cb91
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|261009223027099003|10067099003|3023799007|11063799006|6133799003|55112099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	FT189D/jAqpgEBTg2zrQoI/6cI1UrrOVTEb8n2XhrzK76sg2AGMaKjHylJ+Qgd4KadHxLot1ykoSLBkBfYnEx0DO/DuxwA1TniSOZPLOqO++KgaQnWJtGbr9idTW5/AsEOLb6UQjNHi8VvoAmmx593yW2e7tSMJdveeciQwSAvo0H5lxUxdiRX9unttudJxHb8jBm2yvy4nScXF5Hw0VhjYpze4KnYrGm5p3bkkRZqHEy+mr6VTEKKLJt80Y8UNjfpcEPkwYL083Y2w3FWSNPItY9j+yMUMbEdr9hqxzcvBZr+DKOHzjOeWi1UMH6OJ/i+mpInQHmAPXICsoE8YYX87z71ZfdiqXoI2dB6MJE/0ToItqSC3pezmPl7jQbqZrN/t+ipCEx0hVOMrvvQdu0E33Ezu6WqMqg9WnCsg1Fh43aN7sV/DLfDQzaRvUiid3pIOaZs30KBmOXfNbCq9yNzx1RB66OVewPQpanWuRMZEIsc+DY3+IYndhqdq/u89OQjE5f/ewYIaepH+n2kbNWCu3bzPcVKFlez1rzc4vDzdq2ODPpJYJPboHmPRVjJgHMKy4/sB5F3JDUi6nGGBSYd/97VaK3uBgHToUTCcS8DU0OQne4uLXhSbAwIJBYafGm4JqYgT0B6v52BqV/8D8k6MzWmWUixk6tWtgEv9ORtA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261009223027099003)(10067099003)(3023799007)(11063799006)(6133799003)(55112099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OFpjbmUwNEtnZllEYi94ZURLeHNwKytKSzZ3bWVGdWlqbDBGVU9XSm1taTEy?=
 =?utf-8?B?K2NIRCtxVUE0NGdIZ3lWZzVDSncvZ3JKUEU4VHNNQ010QlIzQis1ZW55RHhM?=
 =?utf-8?B?RkpRb1lodHUzQ2FwRksvS1Vma1BUdndTdkNRWS96QWVpYU1ZZnVsQ2NYNVFS?=
 =?utf-8?B?T0dLTWhXcUlMVE5pT0JoWmRsTnNwRjBHV0s1M1BDRnNISGVWRnlqeEpHYitK?=
 =?utf-8?B?dVlDMDRXNlBtZTI2c1hSbVllNk0xNFRpVnl5STFvMXExREdydlZjSnFXYmRu?=
 =?utf-8?B?cjJkUnlHNXV2VUdZa0I0MnBTR0U4MlNDaW1IYWFHek96dVNPNEc2cDN5dVNy?=
 =?utf-8?B?d08veU5VOXZReHYwQzZwYXp4TUYyYllrdWVteWFnL1UreTY4VEl6WHQ4WGg3?=
 =?utf-8?B?UHZEZDFNVjRHVG1ZM0R6d3d2M1IvVFk5amhGdmlZY3cway8xeGI0c01KRGxM?=
 =?utf-8?B?cWtYSzhHUElGZm9kRW4vb2JzUlBkQVY0Q25CNG9pQk5QNGpBRkpPcVlUNkc4?=
 =?utf-8?B?UVFBVE9kOEZJTlRKZ3AyRFpmaVBhT1UzdlhrTHZvU01ZYmNldDJ1aWg5NFRD?=
 =?utf-8?B?K2N5MjdoZUFnbGI2NE51ZTFsVitPT1VHYmNZRjgzSlJGc0ZyTktxbXY4U1lL?=
 =?utf-8?B?TXFUNGE4OWJ1OG1UczVXMUo2WWpYdE1pOVJMS3FrTi8rOEhTRHI1WGdYVHN4?=
 =?utf-8?B?bWhkYnMybXBWL04vV0tLTTZhM21pT3E0RWxMZitGVWtCSEtSTFdObENIdHVN?=
 =?utf-8?B?dzhVWkVoMkJVRWZTaHpnaW91L1ovUVJWL0JXSlRBd3pwUlZCRkZWYklLYmpq?=
 =?utf-8?B?VjNYY3hhYWNKWjVFMFJwU3hnMlpEaGZ3VkxPNHJldmxmL2NTYzQ4djhxaGNl?=
 =?utf-8?B?TWk4OGZDUlcvN3VKZ0JFSDBhVjlweG9wajhuZzI3QXAzQU84MWpXMlRXR3Fl?=
 =?utf-8?B?aXdpSGIySDNZSjZINEY0b3BVdEZSQ2lPOWx4M1NjZVJRWmlPSGQ3cDl0YWNz?=
 =?utf-8?B?L0x0NW1SWjVBZWdOVGlyQVNsS2ZvY1F1VGhac1BRNWl2TG5GcU9aMGZ1MFBr?=
 =?utf-8?B?ZGVyVjk5QzlBeTNrYU5aM0FWQ1BnOGJMdE84Ly9mc2hyekdsWVlqWUIrb0xj?=
 =?utf-8?B?UkNqaGhhTmkrUlNXajFmTU1zczNNOXhQMGUzcEpnREtreTRqdmFYWkg5eXdR?=
 =?utf-8?B?MzRnbkl5Vmk2V0c2b1FHKzExY0VLSWZYMVc1Tks2RkxlcnR4VmVCV2Q1Qi96?=
 =?utf-8?B?d0VEaFFNL0RvN1pmQy83MHIrVmdJMGFSeDFIM3cvWllRMlhjYU1CM21CQmJV?=
 =?utf-8?B?MnAzM0Zmd2Y0Tm9YdzdkMnNKQjRTNUUxNWIvakZXNFIyZTNjalVuL2tYc2Fp?=
 =?utf-8?B?TittR29zT28xTUEyU29xRkNud0VRL2Z3OUNHR3RFZnR1cHg5b09ZTEZPY2NP?=
 =?utf-8?B?RkxmRUhXWk5nOE92OHJVcFppLytWYm8ydWFSeWZKMlhSZ0hBaU1YaDRpY3VQ?=
 =?utf-8?B?dzM2SDExWUZEVHVYMURKQW1OQUoxTFZZdlEzYVZETFJKeG5JM3NwUVpJVXdB?=
 =?utf-8?B?M0dQTEVZK1V3UWlxNHYxY3duVE1nZzltcDdhMVhlY0lubXZIQ3RIekIwWlg4?=
 =?utf-8?B?QzNtL1U0aUJxRVlhODl0amh3em9OeXcvd3JvekVWQzd0bGh2ckNDWFgrUFNQ?=
 =?utf-8?B?N1k4Q3JZZ3paMkJGZnhTdFYyOVdod0ErQWdydnlUQUNlQW82VUdkbmJoTzhp?=
 =?utf-8?B?clJFdXM1QVpiT0tPcEd5WXhwTjk3UTVITEtSZmxrSnVMMzJTRmRMOW1ucVY5?=
 =?utf-8?B?dWxYN0FIN2swZ2N3K2FMTzByRjJ2cmx5Z1lNZGd3NlNGWEJNZ0RmNGhaRFlM?=
 =?utf-8?B?OWs3Ly9kTlZVbCtneWJuKzI1V0pNSlcvOTNlSlNYbVVpVU5DZTJ1U21hbm1I?=
 =?utf-8?B?K2tYZy84SVBBNGpKWFYxSjJkUHN5Vld5TkphUWs4aUF0YmtrRGV0NWcvdkpj?=
 =?utf-8?B?SWpjOXE1REtJNnhHTHZtdWF3d1RzSEprTmd5Q2UrS0ZGcVVDZ2RWZ2Rpa2hF?=
 =?utf-8?B?N0hxZmtpcHBWS0NMZFNZcy9YbkRvSytQSVpXWFNNcEdibjhMczJCQjZtYWRL?=
 =?utf-8?B?Y2JBVG9vVHltYndoV3FDeHZ0ODdHcGM4QVU2b09DUTNaRUxaK1NIT1k4Tlg4?=
 =?utf-8?B?VmczaFU2SGdOUFBZWEhwcTljM1dlUm9LRVJ4OFRyTE1lVW5DTk1hTDJTblF2?=
 =?utf-8?B?Wm5lNHRORWJJQ0lUdGc4ajJQK212WWNOOGtSRk1kM0RZVWxXREFIemlLcHE0?=
 =?utf-8?B?SjNQbFI3QnF4WEVvdFBSTnZ2cVlCdzQxRFZMcWhPZDg0SDd0bm1FUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a70b0e14-ca02-4431-f11d-08df29d6cb91
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 09:37:42.5787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xi96pstA6YbbibyaDUyS6k0E9myyEGtDx2uyrvPO3qR0Sbb3324zw109rePh+AOz/6Bn39nup+S95DrK+iUZnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR10MB536290
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Oct 2026 09:37:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24459

On 14.10.26 11:29, srinuvasan.a@siemens.com wrote:
> From: Srinuvasan A <srinuvasan.a@siemens.com>
> 
> This revision adds support for the isar-privileged and
> isar-rootless build systems, enables repository URL
> overrides, and allows the commit to be set to null to
> use the HEAD of the selected branch.

Good finding. kas does not enforce this incompatiblity while it formally
could, and then the build would have been broken without this bump.

> 
> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> ---
>  doc/README.secureboot.md             | 2 +-
>  kas-cip.yml                          | 2 +-
>  kas/board/bbb.yml                    | 2 +-
>  kas/board/beaglev-fire.yml           | 2 +-
>  kas/board/de0-nano-soc.yml           | 2 +-
>  kas/board/hihope-rzg2m.yml           | 2 +-
>  kas/board/iwg20m.yml                 | 2 +-
>  kas/board/qemu-amd64.yml             | 2 +-
>  kas/board/qemu-arm.yml               | 2 +-
>  kas/board/qemu-arm64.yml             | 2 +-
>  kas/board/qemu-riscv64.yml           | 2 +-
>  kas/board/rzt2h-evk.yml              | 2 +-
>  kas/board/ti-am62px-sk.yml           | 2 +-
>  kas/board/x86-uefi.yml               | 2 +-
>  kas/opt/4.19.yml                     | 2 +-
>  kas/opt/4.4.yml                      | 2 +-
>  kas/opt/5.10.yml                     | 2 +-
>  kas/opt/6.1.yml                      | 2 +-
>  kas/opt/6.12.yml                     | 2 +-
>  kas/opt/bookworm.yml                 | 2 +-
>  kas/opt/bullseye.yml                 | 2 +-
>  kas/opt/buster.yml                   | 2 +-
>  kas/opt/delta-update.yml             | 2 +-
>  kas/opt/disable-watchdog.yml         | 2 +-
>  kas/opt/ebg-secure-boot-snakeoil.yml | 2 +-
>  kas/opt/ebg-swu.yml                  | 2 +-
>  kas/opt/encrypt-all.yml              | 2 +-
>  kas/opt/encrypt-data.yml             | 2 +-
>  kas/opt/erofs.yml                    | 2 +-
>  kas/opt/expand-on-first-boot.yml     | 2 +-
>  kas/opt/factory-reset.yml            | 2 +-
>  kas/opt/forky.yml                    | 2 +-
>  kas/opt/ftpm-stmm.yml                | 2 +-
>  kas/opt/kernel-head.yml              | 2 +-
>  kas/opt/kernel-panic.yml             | 2 +-
>  kas/opt/no_kernel.yml                | 2 +-
>  kas/opt/reproducible.yml             | 2 +-
>  kas/opt/rt.yml                       | 2 +-
>  kas/opt/security.yml                 | 2 +-
>  kas/opt/security_test.yml            | 2 +-
>  kas/opt/separate-home-partition.yml  | 2 +-
>  kas/opt/sid.yml                      | 2 +-
>  kas/opt/swupdate-2022.12.yaml        | 2 +-
>  kas/opt/swupdate.yml                 | 2 +-
>  kas/opt/targz.yml                    | 2 +-
>  kas/opt/test.yml                     | 2 +-
>  kas/opt/trixie.yml                   | 2 +-
>  47 files changed, 47 insertions(+), 47 deletions(-)
> 
> diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
> index 2a387f0..2b14bfb 100644
> --- a/doc/README.secureboot.md
> +++ b/doc/README.secureboot.md
> @@ -151,7 +151,7 @@ For user-generated keys, create a new option file in the repository. This option
>  
>  ```yaml
>  header:
> -  version: 14
> +  version: 23
>    includes:
>     - kas/opt/ebg-swu.yml
>  
> diff --git a/kas-cip.yml b/kas-cip.yml
> index d618a6e..13251a7 100644
> --- a/kas-cip.yml
> +++ b/kas-cip.yml
> @@ -10,7 +10,7 @@
>  #
>  
>  header:
> -  version: 14
> +  version: 23
>  
>  distro: cip-core-trixie
>  target: cip-core-image
> diff --git a/kas/board/bbb.yml b/kas/board/bbb.yml
> index f2e701c..f36bc22 100644
> --- a/kas/board/bbb.yml
> +++ b/kas/board/bbb.yml
> @@ -10,6 +10,6 @@
>  #
>  
>  header:
> -  version: 14
> +  version: 23
>  
>  machine: bbb
> diff --git a/kas/board/beaglev-fire.yml b/kas/board/beaglev-fire.yml
> index 07345f1..c82ed50 100644
> --- a/kas/board/beaglev-fire.yml
> +++ b/kas/board/beaglev-fire.yml
> @@ -7,6 +7,6 @@
>  #
>  
>  header:
> -  version: 14
> +  version: 23
>  
>  machine: beaglev-fire
> diff --git a/kas/board/de0-nano-soc.yml b/kas/board/de0-nano-soc.yml
> index 2d1d242..b1d26c0 100644
> --- a/kas/board/de0-nano-soc.yml
> +++ b/kas/board/de0-nano-soc.yml
> @@ -10,6 +10,6 @@
>  #
>  
>  header:
> -  version: 14
> +  version: 23
>  
>  machine: de0-nano-soc
> diff --git a/kas/board/hihope-rzg2m.yml b/kas/board/hihope-rzg2m.yml
> index 8d0136b..9b5086a 100644
> --- a/kas/board/hihope-rzg2m.yml
> +++ b/kas/board/hihope-rzg2m.yml
> @@ -10,6 +10,6 @@
>  #
>  
>  header:
> -  version: 14
> +  version: 23
>  
>  machine: hihope-rzg2m
> diff --git a/kas/board/iwg20m.yml b/kas/board/iwg20m.yml
> index 9c9ef4b..5f83173 100644
> --- a/kas/board/iwg20m.yml
> +++ b/kas/board/iwg20m.yml
> @@ -10,6 +10,6 @@
>  #
>  
>  header:
> -  version: 14
> +  version: 23
>  
>  machine: iwg20m
> diff --git a/kas/board/qemu-amd64.yml b/kas/board/qemu-amd64.yml
> index c27ed8e..5a679f4 100644
> --- a/kas/board/qemu-amd64.yml
> +++ b/kas/board/qemu-amd64.yml
> @@ -10,6 +10,6 @@
>  #
>  
>  header:
> -  version: 14
> +  version: 23
>  
>  machine: qemu-amd64
> diff --git a/kas/board/qemu-arm.yml b/kas/board/qemu-arm.yml
> index 969fd5a..abd256b 100644
> --- a/kas/board/qemu-arm.yml
> +++ b/kas/board/qemu-arm.yml
> @@ -11,6 +11,6 @@
>  #
>  
>  header:
> -  version: 14
> +  version: 23
>  
>  machine: qemu-arm
> diff --git a/kas/board/qemu-arm64.yml b/kas/board/qemu-arm64.yml
> index 1a1eb0d..68151e8 100644
> --- a/kas/board/qemu-arm64.yml
> +++ b/kas/board/qemu-arm64.yml
> @@ -11,6 +11,6 @@
>  #
>  
>  header:
> -  version: 14
> +  version: 23
>  
>  machine: qemu-arm64
> diff --git a/kas/board/qemu-riscv64.yml b/kas/board/qemu-riscv64.yml
> index e8272b0..894b5e3 100644
> --- a/kas/board/qemu-riscv64.yml
> +++ b/kas/board/qemu-riscv64.yml
> @@ -7,6 +7,6 @@
>  #
>  
>  header:
> -  version: 14
> +  version: 23
>  
>  machine: qemu-riscv64
> diff --git a/kas/board/rzt2h-evk.yml b/kas/board/rzt2h-evk.yml
> index 90261dc..7c82a78 100644
> --- a/kas/board/rzt2h-evk.yml
> +++ b/kas/board/rzt2h-evk.yml
> @@ -10,6 +10,6 @@
>  #
>  
>  header:
> -  version: 14
> +  version: 23
>  
>  machine: rzt2h-evk
> diff --git a/kas/board/ti-am62px-sk.yml b/kas/board/ti-am62px-sk.yml
> index 5127218..cd9d07f 100644
> --- a/kas/board/ti-am62px-sk.yml
> +++ b/kas/board/ti-am62px-sk.yml
> @@ -8,6 +8,6 @@
>  #
>  
>  header:
> -  version: 14
> +  version: 23
>  
>  machine: ti-am62px-sk
> diff --git a/kas/board/x86-uefi.yml b/kas/board/x86-uefi.yml
> index 056ca32..92bd94f 100644
> --- a/kas/board/x86-uefi.yml
> +++ b/kas/board/x86-uefi.yml
> @@ -10,6 +10,6 @@
>  #
>  
>  header:
> -  version: 14
> +  version: 23
>  
>  machine: x86-uefi
> diff --git a/kas/opt/4.19.yml b/kas/opt/4.19.yml
> index 708562b..944175f 100644
> --- a/kas/opt/4.19.yml
> +++ b/kas/opt/4.19.yml
> @@ -10,7 +10,7 @@
>  #
>  
>  header:
> -  version: 14
> +  version: 23
>  
>  local_conf_header:
>    kernel-version: |
> diff --git a/kas/opt/4.4.yml b/kas/opt/4.4.yml
> index db9bbdc..1be0441 100644
> --- a/kas/opt/4.4.yml
> +++ b/kas/opt/4.4.yml
> @@ -11,7 +11,7 @@
>  #
>  
>  header:
> -  version: 14
> +  version: 23
>  
>  local_conf_header:
>    kernel-version: |
> diff --git a/kas/opt/5.10.yml b/kas/opt/5.10.yml
> index d76d056..aff3f26 100644
> --- a/kas/opt/5.10.yml
> +++ b/kas/opt/5.10.yml
> @@ -10,7 +10,7 @@
>  #
>  
>  header:
> -  version: 14
> +  version: 23
>  
>  local_conf_header:
>    kernel-version: |
> diff --git a/kas/opt/6.1.yml b/kas/opt/6.1.yml
> index caca83d..8ab9fc3 100644
> --- a/kas/opt/6.1.yml
> +++ b/kas/opt/6.1.yml
> @@ -10,7 +10,7 @@
>  #
>  
>  header:
> -  version: 14
> +  version: 23
>  
>  local_conf_header:
>    kernel-version: |
> diff --git a/kas/opt/6.12.yml b/kas/opt/6.12.yml
> index 052b59c..ee1bf75 100644
> --- a/kas/opt/6.12.yml
> +++ b/kas/opt/6.12.yml
> @@ -10,7 +10,7 @@
>  #
>  
>  header:
> -  version: 14
> +  version: 23
>  
>  local_conf_header:
>    kernel-version: |
> diff --git a/kas/opt/bookworm.yml b/kas/opt/bookworm.yml
> index dc0e0a2..82d7594 100644
> --- a/kas/opt/bookworm.yml
> +++ b/kas/opt/bookworm.yml
> @@ -10,6 +10,6 @@
>  #
>  
>  header:
> -  version: 14
> +  version: 23
>  
>  distro: cip-core-bookworm
> diff --git a/kas/opt/bullseye.yml b/kas/opt/bullseye.yml
> index 0614c92..6d10d4c 100644
> --- a/kas/opt/bullseye.yml
> +++ b/kas/opt/bullseye.yml
> @@ -10,6 +10,6 @@
>  #
>  
>  header:
> -  version: 14
> +  version: 23
>  
>  distro: cip-core-bullseye
> diff --git a/kas/opt/buster.yml b/kas/opt/buster.yml
> index 3f19310..4913ea8 100644
> --- a/kas/opt/buster.yml
> +++ b/kas/opt/buster.yml
> @@ -10,6 +10,6 @@
>  #
>  
>  header:
> -  version: 14
> +  version: 23
>  
>  distro: cip-core-buster
> diff --git a/kas/opt/delta-update.yml b/kas/opt/delta-update.yml
> index 7d4c28c..6d8282d 100644
> --- a/kas/opt/delta-update.yml
> +++ b/kas/opt/delta-update.yml
> @@ -10,7 +10,7 @@
>  #
>  
>  header:
> -  version: 14
> +  version: 23
>  
>  local_conf_header:
>    delta-update: |
> diff --git a/kas/opt/disable-watchdog.yml b/kas/opt/disable-watchdog.yml
> index 88ece6b..64695b8 100644
> --- a/kas/opt/disable-watchdog.yml
> +++ b/kas/opt/disable-watchdog.yml
> @@ -8,7 +8,7 @@
>  #
>  
>  header:
> -  version: 14
> +  version: 23
>  
>  local_conf_header:
>    no-watchdog: |
> diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
> index a581466..569d2a5 100644
> --- a/kas/opt/ebg-secure-boot-snakeoil.yml
> +++ b/kas/opt/ebg-secure-boot-snakeoil.yml
> @@ -10,7 +10,7 @@
>  #
>  
>  header:
> -  version: 14
> +  version: 23
>    includes:
>      - kas/opt/ebg-swu.yml
>  
> diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
> index 7835559..486d30f 100644
> --- a/kas/opt/ebg-swu.yml
> +++ b/kas/opt/ebg-swu.yml
> @@ -10,7 +10,7 @@
>  #
>  
>  header:
> -  version: 14
> +  version: 23
>    includes:
>     - kas/opt/swupdate.yml
>  
> diff --git a/kas/opt/encrypt-all.yml b/kas/opt/encrypt-all.yml
> index faf7206..8ad40ee 100644
> --- a/kas/opt/encrypt-all.yml
> +++ b/kas/opt/encrypt-all.yml
> @@ -10,7 +10,7 @@
>  #
>  
>  header:
> -  version: 14
> +  version: 23
>    includes:
>      - kas/opt/encrypt-data.yml
>  local_conf_header:
> diff --git a/kas/opt/encrypt-data.yml b/kas/opt/encrypt-data.yml
> index 3de76ab..a4332e9 100644
> --- a/kas/opt/encrypt-data.yml
> +++ b/kas/opt/encrypt-data.yml
> @@ -10,7 +10,7 @@
>  #
>  
>  header:
> -  version: 14
> +  version: 23
>  
>  local_conf_header:
>    initramfs-option-encrypt-partitions: |
> diff --git a/kas/opt/erofs.yml b/kas/opt/erofs.yml
> index 7c44f5b..1eff7e5 100644
> --- a/kas/opt/erofs.yml
> +++ b/kas/opt/erofs.yml
> @@ -9,7 +9,7 @@
>  # SPDX-License-Identifier: MIT
>  
>  header:
> -  version: 14
> +  version: 23
>  
>  local_conf_header:
>    erofs: |
> diff --git a/kas/opt/expand-on-first-boot.yml b/kas/opt/expand-on-first-boot.yml
> index f5be699..d4dddd1 100644
> --- a/kas/opt/expand-on-first-boot.yml
> +++ b/kas/opt/expand-on-first-boot.yml
> @@ -10,7 +10,7 @@
>  #
>  
>  header:
> -  version: 14
> +  version: 23
>  
>  local_conf_header:
>    package-expand-on-first-boot: |
> diff --git a/kas/opt/factory-reset.yml b/kas/opt/factory-reset.yml
> index 1ea11db..d8e0b71 100644
> --- a/kas/opt/factory-reset.yml
> +++ b/kas/opt/factory-reset.yml
> @@ -10,7 +10,7 @@
>  #
>  
>  header:
> -  version: 14
> +  version: 23
>  
>  local_conf_header:
>    factory-reset: |
> diff --git a/kas/opt/forky.yml b/kas/opt/forky.yml
> index 6c4fcdc..c7f1294 100644
> --- a/kas/opt/forky.yml
> +++ b/kas/opt/forky.yml
> @@ -10,6 +10,6 @@
>  #
>  
>  header:
> -  version: 14
> +  version: 23
>  
>  distro: cip-core-forky
> diff --git a/kas/opt/ftpm-stmm.yml b/kas/opt/ftpm-stmm.yml
> index 06f645d..60797c9 100644
> --- a/kas/opt/ftpm-stmm.yml
> +++ b/kas/opt/ftpm-stmm.yml
> @@ -9,7 +9,7 @@
>  # SPDX-License-Identifier: MIT
>  
>  header:
> -  version: 14
> +  version: 23
>  
>  local_conf_header:
>    ftpm-stmm: |
> diff --git a/kas/opt/kernel-head.yml b/kas/opt/kernel-head.yml
> index abb4d62..2c8ef9e 100644
> --- a/kas/opt/kernel-head.yml
> +++ b/kas/opt/kernel-head.yml
> @@ -10,7 +10,7 @@
>  #
>  
>  header:
> -  version: 14
> +  version: 23
>  
>  local_conf_header:
>    kernel-version-head: |
> diff --git a/kas/opt/kernel-panic.yml b/kas/opt/kernel-panic.yml
> index f966779..3628d8e 100644
> --- a/kas/opt/kernel-panic.yml
> +++ b/kas/opt/kernel-panic.yml
> @@ -11,7 +11,7 @@
>  # This kas file adds systemd service file to cause kernel panic during system boot.
>  
>  header:
> -  version: 14
> +  version: 23
>  
>  local_conf_header:
>    kernel-panic: |
> diff --git a/kas/opt/no_kernel.yml b/kas/opt/no_kernel.yml
> index 7bba6a5..4ee3ece 100644
> --- a/kas/opt/no_kernel.yml
> +++ b/kas/opt/no_kernel.yml
> @@ -10,7 +10,7 @@
>  #
>  
>  header:
> -  version: 14
> +  version: 23
>  
>  local_conf_header:
>    kernel-version: |
> diff --git a/kas/opt/reproducible.yml b/kas/opt/reproducible.yml
> index ae611eb..79dd936 100644
> --- a/kas/opt/reproducible.yml
> +++ b/kas/opt/reproducible.yml
> @@ -9,7 +9,7 @@
>  # SPDX-License-Identifier: MIT
>  #
>  header:
> -  version: 14
> +  version: 23
>  
>  local_conf_header:
>    reproducible-builds: |
> diff --git a/kas/opt/rt.yml b/kas/opt/rt.yml
> index ab43a84..3abc4c1 100644
> --- a/kas/opt/rt.yml
> +++ b/kas/opt/rt.yml
> @@ -10,7 +10,7 @@
>  #
>  
>  header:
> -  version: 14
> +  version: 23
>  
>  local_conf_header:
>    preempt-rt: |
> diff --git a/kas/opt/security.yml b/kas/opt/security.yml
> index 2ad53ea..ed6087f 100644
> --- a/kas/opt/security.yml
> +++ b/kas/opt/security.yml
> @@ -9,7 +9,7 @@
>  # SPDX-License-Identifier: MIT
>  #
>  header:
> -  version: 14
> +  version: 23
>    includes:
>     - kas/opt/encrypt-data.yml
>     - kas/opt/ebg-secure-boot-snakeoil.yml
> diff --git a/kas/opt/security_test.yml b/kas/opt/security_test.yml
> index 40ac576..68571b2 100644
> --- a/kas/opt/security_test.yml
> +++ b/kas/opt/security_test.yml
> @@ -8,7 +8,7 @@
>  #
>  
>  header:
> -  version: 14
> +  version: 23
>  
>  local_conf_header:
>    lava-testing-add-curl: |
> diff --git a/kas/opt/separate-home-partition.yml b/kas/opt/separate-home-partition.yml
> index 9fccd20..16fe2cb 100644
> --- a/kas/opt/separate-home-partition.yml
> +++ b/kas/opt/separate-home-partition.yml
> @@ -12,7 +12,7 @@
>  # This provide backward compability to the previous isar-cip-core
>  # versions.
>  header:
> -  version: 14
> +  version: 23
>  
>  local_conf_header:
>    separate-home-partition: |
> diff --git a/kas/opt/sid.yml b/kas/opt/sid.yml
> index 26515d3..cb67e8a 100644
> --- a/kas/opt/sid.yml
> +++ b/kas/opt/sid.yml
> @@ -10,6 +10,6 @@
>  #
>  
>  header:
> -  version: 14
> +  version: 23
>  
>  distro: cip-core-sid
> diff --git a/kas/opt/swupdate-2022.12.yaml b/kas/opt/swupdate-2022.12.yaml
> index cbaa4b5..803036f 100644
> --- a/kas/opt/swupdate-2022.12.yaml
> +++ b/kas/opt/swupdate-2022.12.yaml
> @@ -12,7 +12,7 @@
>  # from the first wic partition
>  
>  header:
> -  version: 14
> +  version: 23
>    includes:
>     - kas/opt/swupdate.yml
>  
> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
> index b4c4b99..5a4c8bf 100644
> --- a/kas/opt/swupdate.yml
> +++ b/kas/opt/swupdate.yml
> @@ -12,7 +12,7 @@
>  # from the first wic partition
>  
>  header:
> -  version: 14
> +  version: 23
>  
>  local_conf_header:
>    image-option-swupdate: |
> diff --git a/kas/opt/targz.yml b/kas/opt/targz.yml
> index 5c0b87b..48f3ebd 100644
> --- a/kas/opt/targz.yml
> +++ b/kas/opt/targz.yml
> @@ -10,7 +10,7 @@
>  #
>  
>  header:
> -  version: 14
> +  version: 23
>  
>  local_conf_header:
>    image-type: |
> diff --git a/kas/opt/test.yml b/kas/opt/test.yml
> index 4a60ad4..ef0fc9e 100644
> --- a/kas/opt/test.yml
> +++ b/kas/opt/test.yml
> @@ -9,7 +9,7 @@
>  #
>  
>  header:
> -  version: 14
> +  version: 23
>  
>  local_conf_header:
>    testing: |
> diff --git a/kas/opt/trixie.yml b/kas/opt/trixie.yml
> index e9a76ef..9734a49 100644
> --- a/kas/opt/trixie.yml
> +++ b/kas/opt/trixie.yml
> @@ -10,6 +10,6 @@
>  #
>  
>  header:
> -  version: 14
> +  version: 23
>  
>  distro: cip-core-trixie

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

