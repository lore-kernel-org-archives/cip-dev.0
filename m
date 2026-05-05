Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBA6CD13DA
	for <webhook@archiver.kernel.org>; Tue,  5 May 2026 07:02:19 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.10])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.33776.1777964533028626933
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 May 2026 00:02:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=VbNsotKq;
 spf=pass (domain: siemens.com, ip: 52.101.83.10, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QmOecsM+8CCPrOik3UwEu15nQAlVWHSkZoO7vUz0jBuwkOzAJ6zh5iBMp3es9OCEMYzoSLcEoqQhSmKuzXJFv2/gbTHtm5/WnN8sb1fw5BnpQf5DuSV3Kc2CdMdk8otv0sF2AaB1hcyokDBpIzDwhwNxFykGSPuidbhTRMGZHXGFeIu68+JCRaTx4EWl7+EbGDCUoyAGz/eN3vRGn8oyTWRXXe7ZRgv9izRmPCfPxdvAtHhtGAnYWVPdUM+slsh9mkNzSCvyRIODAYq8/PfPNwh646Jt5FFeZhkOguecNUgPdH9sleCh4iqdFiYiE1PIuuxjqIGUZ2H8sg+bTWu0Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dteWFV64c1lqBL3kUrLSpuWMw5CTsBXnIagkuzrUqBc=;
 b=guqQ5yQ2n5XLfpOJY/tJMkjbairgkAB83xUDdaOWHfT/FHywoq0aPyUSikfagKNPCIElxwcXDDpM+PMeKQmVjXgGO+jT+8OwMME1fvAe8s/H+YOVVw9pJXLUOdfI3+NbbKK2Ze4idzeygUki2fR8ARoA9jM98UK4bqkU4cf6dz8vETEsWwMMog/1TSxVTl20toWbm0KnudHVhbQz9JgJcsRIAiR6bF6oNeW4y/+8OT2O+wuxF/IKHBYilECvs5otoH+xr6WiA6E68xzmnkOZmeNDq1cvcnM01jipQRx3WD0wm7Gas3P1ctsW22c4g48/KyMf/bBgtaLjCFc915geJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dteWFV64c1lqBL3kUrLSpuWMw5CTsBXnIagkuzrUqBc=;
 b=VbNsotKqXoeIOHCxWHpuGm4SIpm/0kUKi1vNEKFtF9qDkIQLOhB7pIYNtG9n0rlTIwyEJSblwchzMp9n1Ifx0DroaN6dt8lE5vhqftqBX07iMKLwRmj9pVFFaUZ4HF1uysnnEs0MO3NIJLskR1sqeOaAm9LSIwNVDsMWthiCIW5ioi29POU8v7oIVKid/MJc4L7h9WXgza54z38hM3PSOzsS+Dn4HC1ctpVb2cXDFYgn+X4t6AdKfhfI0V+1vb8jfDhGxGavMsdvjYp7EOUnT+BDl2wIixo71gO3d0wNgzi3s5rYu4m9kxcR2AYu+lutTshgnu+LSvWevYB7yKs+Xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8553.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:232::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 07:02:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 07:02:04 +0000
Message-ID: <071e371c-ef56-4296-a001-0ad992b79bca@siemens.com>
Date: Tue, 5 May 2026 09:02:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH 6.12.y-cip 00/12] Backport PREEMPT-RT support for ARM
 32-bit
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org, pavel@nabladev.com,
 nobuhiro.iwamatsu.x90@mail.toshiba, Sebastian Siewior
 <bigeasy@linutronix.de>, Bryan Brattlof <bb@ti.com>,
 Daniel Wagner <daniel.wagner@monom.org>
References: <cover.1777964226.git.jan.kiszka@siemens.com>
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
In-Reply-To: <cover.1777964226.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8553:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e0143a3-6c51-46d9-710c-08deaa7436bc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	Brbtjat8AKiTzIOHxcfRCga88c/foyV+CEz48F74LkZ6hzawJoe3vE1MqW3mWJQepvzeW3zRuP8/2L2ONMKFeJsHXx+x7MgPLjehOyDripB5EAC8k/a0kzVcctNqrkTJCe3Xjgl2dy9WqSN2NpAcwLni9j6qRblnFRz605OY9ymt4IF8xkxnSrZrt38UwHa6JirlPKfnMMnb6a7aEDDIyyexGCXpYs48tSNiWS9VpNDM4e7yFYg5MZ/b5YJOB/K7y4/coS1QbATCZCqW4ByrFk+Pp/9Nkz3+QZYYSrr1M1wv6vx7nvntmUAQ2o2oVe34krYP3EjFhe2FPwrjT342kL6OJSKHHzGKJeOdC6OYS51CJDG2ab0fED9PZPWh6lrI3TyEbjhnrRs+zXi7KvR6nSdK/c3Ww9e8m0lfrmtraBD4GHIta615M6nNU9LJ+2t3l+c+J4DIltdFwbQRJtpi88+cv2vKveTR0K2xR3zvZF4GFLPWeNQ0ekIhet7VHMMJKqivWzJoienPGoa3dpC94cImj3BL/Dwpl/qJicK64F2MHQymENL8LkZsCexyrRRFLJfoa/2ecKK31Vt7j6BKdga3Rujh8kuY5kdET2NaAFYiWDIrIF9uPvqE2zzlfeqJqs5Gw6M8OJyQzklRWzr2eRnes1TVOmagCTkE8sw2Zr3QFyRdFHtkBscaAeRlq8Yu
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V0U0U2tUU2ZyUkJPRFFUN2lxaFVERC9mekJ3eWZOejU2VFl1MW5yWm14QU42?=
 =?utf-8?B?VTk0Mm9tUkY3Myttek5PNlBoeFIvVi9sSTBrcFg0dTJpUUJIQ1AxQkU5dW80?=
 =?utf-8?B?U280eUszRDRRbG9Oa0ViSUlvelJYZEtCK0prcVZZUTlSd2JmR3RBNGM3bHor?=
 =?utf-8?B?N3ZoQXdqVjVXdHp6Z2FSdHBDTXl3ODVwd2hqMHF1VmZGTFBBRmp3RDJKNVpT?=
 =?utf-8?B?cDVqMEIvSmhGa2JzVmg2OVh0cnJRYnpuekFFTHNNQW82eXpJWnZwV2VhMDll?=
 =?utf-8?B?SzdlTkFMMmRxZU13eDZ0bUs5NWxDSnI2LzJBQVlEaGNkMmlNMGV2bHFhaFNN?=
 =?utf-8?B?SWVURCt1WThHNXYwb0ZoTlpkT1IveXJYN0tIVkt4S0VmdGtzQnRDd1FZZ2g0?=
 =?utf-8?B?SmZuYWV3aUo5dnhKYWY4cUxkNm1RUGdNeGlBVk1LOWFweVA4Z2hWbkxrQmJV?=
 =?utf-8?B?N3JQc3RqQ0RFM2lpaXVxSmtKTVlhN1ZXNHY3NDRMR1NlL3R6QUlvZU93ZWh5?=
 =?utf-8?B?Q2pqRlY1dzFFMWZYYW1MVzRGMVM1ZUNETmpXb3ZaN0tPMTE0ZnY2RXlNUWZF?=
 =?utf-8?B?MHRPWHRqUTRwOGhJKzRWNW44d0FYNFdDaGNHQ1huU0Rob0NsU2hYK0hRTmdp?=
 =?utf-8?B?cm1sd3lidjh2M3loSzNyNTJPOHJEdzYyaU5xZjl5RENuNlZZZnJVRUs4eEkw?=
 =?utf-8?B?K1VROWlyYm4wMWVhbXRwTVluZ2lQeHJWU0xGWEpTVWJ2RWx4WXFYZEg4T21D?=
 =?utf-8?B?aHZ6ckJQUDVDeVp5VStBRlV3YWVlMVZreXlSd3BxSG14clB4YlNsS0UzS3ll?=
 =?utf-8?B?SHNyV3RKZ1RoUkxpeHh2bjRuZk5laHNLbkc5WERFYjNjamx0cEFwcis2akhG?=
 =?utf-8?B?cVp4NlRGWlAwUlI4V2NIUCtJVHNKZ2Y5Nk1hVGx4SjlDN1lyeEJDaytTTjZx?=
 =?utf-8?B?bWNUMG1ncFVtN1pvSkkreTFqMmV3WGt3Yzd5WlBCaERrZldGTm9HRVpOWTFm?=
 =?utf-8?B?N3RYT1ZSVXBKR3ZZZ0ZlVVZkcC9VNWdYLzViM2F5d1FaL2M5TUpUV3IzUlJO?=
 =?utf-8?B?VG1rYXFrTHFMTG1iTi9yeEg0cDR3b0dsSStLcks4bHFyQ1NiV3RYMGhwWExq?=
 =?utf-8?B?czVoNThUVE5EajRyR0VrN2N6S2F5dFAvaUdOMjhUZUw0K2Z2M0Zob2dpZXU3?=
 =?utf-8?B?dkd1dDc0Z2VKMFdjSGdncTVJRmpTc09sSDNHa2RPaFBhSitISkVCQ3FwT1VM?=
 =?utf-8?B?b01EOC9WUVRBenlVMWNQMEFlMDRNMWtERzhzRURwZEg3NHRPQUNGRzlXY0wx?=
 =?utf-8?B?T1YxV0gxa2hscjkwQnl4cDVPRVNoekYxM3JoY1lqVGNjcEZFb2tIQ25yNDRt?=
 =?utf-8?B?Rmd2TVVOQk1CWGZVL3F3emdJNDIwS3FQTjRlQ0R1QUwrMzZlQ1k0QmlQL2ZD?=
 =?utf-8?B?YytrSGppM3JHeTZoam9XWDAxSndob2xCUHZ0dG5uVC9obFh2N1FBWEJjUWtz?=
 =?utf-8?B?aVV3blhjTHN4V29DU2tXdy80cHhEV3gyajdKL2Y3WXVReTRRUlJYaHByNWIx?=
 =?utf-8?B?S0E2VDdGMUpoYW9ua05ZSnZBeTRjTnorT1pkVGxDcWFWR3dHcUdIcTlPYjhE?=
 =?utf-8?B?cEtLNlR6TEtOc1k1VFVGajUzbnlFeXE2OFJ4d1F4dHRUNzNJTU5xenR1c3lX?=
 =?utf-8?B?eTNKVlJkc0pweUQrL1A1WW9GMTRER0dZWUZWb2FhNjVWYUZDcyttZ2FSczhY?=
 =?utf-8?B?ZlNyRmY0V0JJeGQ4YndVUHl0K2lnMFFTNVZDcEc1b0pmMGdlSVMweFlpWWRU?=
 =?utf-8?B?WFh3SzdJTWlMTW56ZlA3MHRnME4wMm9tYThRTFNWTzJZblZsRjE1Nmd2U3hD?=
 =?utf-8?B?UUdkaDROUXdSU1NIUFlJeXRFRkpDV25jNWtQdDVkUnFQMXEwTkpjRXMweVY3?=
 =?utf-8?B?MXM3R2YvSllQT3JKZlFkWE1IaUlxblNBTUNpN1YramZDZHgxSFBRTklnWlNy?=
 =?utf-8?B?VTRuaFRXdXVHcGJJS1ZKTjRpZEk4RDdIY014NlFnVDdmaXY4b2o5allVVXdF?=
 =?utf-8?B?ZkxwWS9yQW5hcnczS3ZIOCtacXpjdG4vYU5LNTd0Zm9zdDh1T1ZMQWNUTUhu?=
 =?utf-8?B?bWhXalJiQlByM0pWRS9ZRHhXZ0RpdHJDTG9WMDhxQ3Zvakx3aEd1UXhsRG0r?=
 =?utf-8?B?N25ydndhU0dnQmI3Y2NpYWkzWm9oWlhGTzIvWkhsSGw3TmZOcmtwbTJuZEJv?=
 =?utf-8?B?YlpGM1RUU052RXU2VmlOL2VMUHMyQkZIV2Y0TFl1eXBRQmxFejgyUEpON0N4?=
 =?utf-8?B?NFc0REg2Q1RQazl5VGVFWjEyUHJ6eVVxcWMxSXFsUWpIQjQrZW9xUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e0143a3-6c51-46d9-710c-08deaa7436bc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 07:02:04.6486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9W1MrluSNRGRHmaX/fAZY2TPw8HijMog9SZfo+u7G1DjqlzctNRS9VLmgJ1ikEKNane78H95/Ls1Hnt/l5SuVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8553
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 May 2026 07:02:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22880

On 05.05.26 08:56, Jan Kiszka wrote:
> A first attempt to backport the recently merged ARM 32-bit support of
> PREEMPT-RT from 7.1 to 6.12-cip. Only lightly tested so far, first of
> all looking for feedback regarding completeness.
> 
> This may also be valuable for 6.12-rt as this series should be able to
> replace all patches tagged with {ARM:,arm:} in v6.12.79-rt17 - adding
> Daniel.

Grrr, CC typos and misconfigurations - at least no overshooting, it seems.

Daniel, Bryan, lost you on CC for this series.

Jan

> 
> Jan
> 
> Russell King (Oracle) (10):
>   ARM: group is_permission_fault() with is_translation_fault()
>   ARM: allow __do_kernel_fault() to report execution of memory faults
>   ARM: fix hash_name() fault
>   ARM: fix branch predictor hardening
>   ARM: ensure interrupts are enabled in __do_user_fault()
>   ARM: move vmalloc() lazy-page table population
>   ARM: move is_permission_fault() and is_translation_fault() to fault.h
>   ARM: use BIT() and GENMASK() for fault status register fields
>   ARM: move FSR fault status definitions before fsr_fs()
>   ARM: provide individual is_translation_fault() and
>     is_permission_fault()
> 
> Sebastian Andrzej Siewior (1):
>   ARM: 9463/1: Allow to enable RT
> 
> Thomas Gleixner (1):
>   ARM: 9459/1: Disable jump-label on PREEMPT_RT
> 
>  arch/arm/Kconfig        |   3 +-
>  arch/arm/mm/alignment.c |   6 +-
>  arch/arm/mm/fault.c     | 222 +++++++++++++++++++++++-----------------
>  arch/arm/mm/fault.h     |  42 ++++++--
>  4 files changed, 173 insertions(+), 100 deletions(-)
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

