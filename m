Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FD810A3D85
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 12:19:45 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.69])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.46840.1774527578171459163
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Mar 2026 05:19:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=h/OpKfvS;
 spf=pass (domain: siemens.com, ip: 52.101.69.69, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wokWxgIGPfd0T/jL+UbtClpDdU50KThhCCF2nE6mZnZH/4Qg3jUT/5CwUV9GfVtUDQ8IT6/5aU/WDDPRoZZt8kY26jWwl78ImI/IstAhhsvr8ONPbphdzxrFcQVH/3Cp+Q/5bPVTkuSGKFhBFtJTTC7hbH1KNxS39+ByKQgYYyWWPgWa+76JHP+KX/4pWZm/yYknWEfvdE9Wf3vpcvXOrwm2lpn/MhfaRViOxlbbtmcxD6XjU92A4jq+9R++al+jNXMHhEIgxnmEgzPZDi51llYWvotVApbrTKu8byGRbRK85yDr//c5VO6yQn35/8JpI2cfiuhoEgXNnrnzAaa7/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cuxvpY19hDXx8QCiGZ38emCwD9NXAIlupmK1cwXGJI=;
 b=Nq6rdV6FOd5Lp2xeghJBvjyEeNJfmFAwv5X7bG2eBt19f+iwkYN0m/4esaSxRNar4WF1REZtB/VJ2jaxlNaSmr53EuY9Rzhuf/92Qhr+bjagELIhmuyUDb4vqtkVSyaIJgR9LTPDEw/+cG+tUGY+4FvZGM+enIqcJZmt9MbgC258peJ1T0R71AMl2c7LGrAHcYXBWELXX/bS6uGqFSgL3JbUNU9jEx5+YYKvle2EQaoIxi7/4Eoxz4iT4XPKibr+S2iwDDIx0iEUNLvJBecfbly3vEanUoN/eGWmL7zrxs+gsEqTxo0BEgzXkxTNuTo6G/8ZqfG/dyc3FcCzszjfVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cuxvpY19hDXx8QCiGZ38emCwD9NXAIlupmK1cwXGJI=;
 b=h/OpKfvSirc0HOBhyllBvdLUJVF3f7t5HOMjRZQHiVv9xVIRiQ3fNP7YXNQrKcMmZyrPBMAv63/4AFIXTc6pMAseYWUZpsQK5oO3SvnvreqfVjoVq7RmAm7bJAEwqo2fzqmPYCP+oleuqMiNpLxoEYzgXxB1qOm/lm9U8o6LaCYDSu7woR45LVCahlVVrbOVoJXB66b3FV+hz/6DWkQFxc4/ILCofKeBJIyRpCzmt4oxWElt7+wNVxW2JZLKnd5TDEaoB3RHIOZCmdT+azLdYmedvgWoSYD0uqDxLQh+GWGaVs8t/kvSmoFlmys+jvCn5jUwP5TddCAjGItC3RrzJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6680.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:400::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 12:19:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 12:19:34 +0000
Message-ID: <d24a009f-eaf4-4989-bd0a-42488f83733d@siemens.com>
Date: Thu, 26 Mar 2026 13:19:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 1/2] chore: update isar revision to latest
 master version
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20260325092333.1651628-1-felix.moessbauer@siemens.com>
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
In-Reply-To: <20260325092333.1651628-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: 1db0e50a-bb88-4114-4bab-08de8b31f0ab
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	ebzfY4YRC4A+utAE1SzV0qm09u9Zn0SxQkgNQnZwzw3OJ7iR1OFQ04EBWv4OotheH2IK3MjiGMO+4JW8hC/7fk5ivnxrTMSCJl6/zPMQYhjFDPJkKcJGRN/EnAr3KbuYX+zPJss5vNGT8PwpOzKAMDxAI+HF80CNjEkxIwrmEK5DJWVz2pB/7JwptAYVFscYPJLrCvdVuc9K4hgO2Rmk+N+qlXth4zydVh42j9IwGjPuyUr5uuouRfJR7R2NuPw+sek3nkKuhPTgYFpRdT/PeUJXOIW3yeQRgg7IRwPARwg3uvgSZ1oBuzdA7bD/5sef1VQ4FmPiR1UEkVbuGeoayQtulDKjsZUE4txzPct9FwBgqPKOu9TgZfkErz52fh/E57hZA97MXo8InN22gQf3kIA74oxUiwL3iWqiLPCOEKf8dPdfQoAMGGupiA9O90svop2v+zE2mtf7Y68JGtwZT+1euMcONDuK7X0Du19NhU0mnVJBXPh7BBc2amoWaFjg1mHM154+urRasKIaiIrWLBj8/13RxAYp3tcz+8eOhVBkYkGoMu5u8MS6bfQPkkj7xJynW7WSQ8XoTjsj3386MlDgMvC9ceLg0IM7xjdYz28vstWJ3BQ5oHK8069/AOYKerwdcYDVVCYo7bM5y63gYshYe2ZfQAm9YX29JqcuJGzx/SifxdtX9bi8/lMzf0RqvpUCydHz1DVHhGKmIXR3DYsJOCEZkg9JywVCeh9rH+s=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dTZWd3hhajF5QjB0dHVxdXEwL1dXdU5QWUFUZmEreGorbGxzQXRXZzlnV1lr?=
 =?utf-8?B?UU5vaGxTeHYwUlJxaURkTnZDZlcwOVd6M1RwZmtlcy8yVnpyV3ZJVWtsUG1n?=
 =?utf-8?B?Nk9tZ1k1QXU1RHZ4Q1BLVUFQQzFkdWdEa0EzT0VNcjl6MURPYW5IUXhDTSto?=
 =?utf-8?B?UmQ1cVVLdDFaL2g0bjk5V1VUNm1pcnZvcmhJRkU3SVIycExUKy8rUWoyYmhD?=
 =?utf-8?B?TktVNUUzenA1a0IwWFc3cFR5WmxRcGVWeWo2dDArVmVQc0JuZzdGZVk4SUZ6?=
 =?utf-8?B?UjZNejUzZU5ZL0tLVm5QNnFRMDVrekVVTDNuL3FaY3p4Vjl2VEJnaXFadXIy?=
 =?utf-8?B?amNDSzdLRkpadTNCVWJGVHVjemlydVVXVXpFQnRwTWM2TDJBRlR1ZWJ3eHNU?=
 =?utf-8?B?NkppUmsvUzRJMWFmS2Q0NTNxRUpuVFRyWURRbHpxSlVSeWg0Q2NJemZ1SUZq?=
 =?utf-8?B?bDZlbnpJbjRmckNJbXNHeVBVcytrUUtLa1FnNklCR0kyQUtZaTQwVnhlN1Rv?=
 =?utf-8?B?T0t1WGxNM3pJbDV2RUJrQi93Z24xMnJXSHZKaEUwM25oZE9nTjk3T0o5ZFJF?=
 =?utf-8?B?VGxneG0wQklTb3dxVGVTM3I4RTExN1R4MGc2eEZ0Nmgwa1l0QWRTTjB3eGNi?=
 =?utf-8?B?T1Q5NEljUmZTR2pkWVJmNzBNMjlJdmhZdWhsVVhjSSs5WFh0alU2MnBGVkhi?=
 =?utf-8?B?Rnk0enU4bkNQdVl0TENjdGNBaFE2UXF3eCt4amdIcDVRRUc0S09XdnlQUGtn?=
 =?utf-8?B?N0VpVFQ1ZEt6RlJBUWI2dVVaYlVYajBjRkJCS0VKTVNzdkRzVHM4U0V0MkFS?=
 =?utf-8?B?Tk9aczJxdmJTVUJXRTdjRDRhdjVzWWVlWG1WTDdlL3pxUTZXWlBzQ0J3Q3BV?=
 =?utf-8?B?T3ZVYTJlY3lHMDAvNnBUR21PMzdpRG91c2RtQ0Q0ZHRhSVVxaG9PQjVPaFBQ?=
 =?utf-8?B?ZDJYMWV6Q1o2LzBaZjAzSnp6SnYzcnNGbHdPTVMvUEhId0l2RHc4TFVTRVFx?=
 =?utf-8?B?VHYrR0QyRmFpcUpDQ3FEYVdDa2lYQWh5M0dwQXpRZWRzYlpnZ0NFTDN2SjRj?=
 =?utf-8?B?dXp5TTBTays4cGJ2SEZadFFoVmRRV212TFZOc1NuVkpyaWFoT0VtSnJQRUNQ?=
 =?utf-8?B?RU1Ka3huTGlRV2dHdlVpWDhjOEdwKzJGUXNONTBVdFVVWEh4bXVDRC9yRGYv?=
 =?utf-8?B?U3NveURVd2FXdnRQWkQxa0V2bWp2TFo4OFNVZHhlTC94czJIc3ZmVkxwUVRB?=
 =?utf-8?B?VEdlaDlrbURHQVA4ckRveE53eGFYWGhjaGFzckM0OXM0QmthYU42SSt6SzFO?=
 =?utf-8?B?S3h1bm1FUDQ0cXdKSWZMbDFyMzJmZlBDOHV5YXNEVmhCaHFuUGROOXN2ZEFC?=
 =?utf-8?B?M2FndmdsWE9PenVndzMwQ0dlSEd0enlNY2IvSVYvZHhDdm1XQmdsZFhJUWN6?=
 =?utf-8?B?Zlh4ZVhNdHVHWVc3aVUrUDl2ZEhsRUp3cDJWcUpVWEpua2k2RFJuZVE5VldP?=
 =?utf-8?B?NnlPUEU4ekJ3OHc1Yjkrd1BhQXl0Z0JyY3NBRFVId1lQNmtrbStRR0VPbHJv?=
 =?utf-8?B?aVoramJQd244b3JBOGtWVDJqU3V4VGo5YjBIVmdXK1pNR2FiREZ4YWl0MlVO?=
 =?utf-8?B?T0c5czZCTUM0eHN6Y1lwWExSSVJmSFZVWlFyV1VYWUJ5WTRGb1FoeTlEem1z?=
 =?utf-8?B?QTl1em0rTUJpZWxpMHNHRVRmemI4SllCL3kwdDlTOERGQ012eEs1aVFNQjh2?=
 =?utf-8?B?UlFTU3JwTkZkK01MUEFSUzNUVnJONC9NWmFGdTdmVnJXRDF0ajNQL2pSVGND?=
 =?utf-8?B?SlUwbXVld3ArZDlEc2YwdllMU1FHbkhZWk16N3hDbU5xeTMwK1pRMG1hMXR4?=
 =?utf-8?B?V29DVXhZL3hESVVQL1JSNG9ic3k0bjlhMXFxdlpBaVVHTVVMSzBVRkluREZw?=
 =?utf-8?B?R01BdG1jTDFuVWlsUllBRnI5bDJvQUczYlNLQ1lST1dHMTRNSW1vZTltalBv?=
 =?utf-8?B?QmpZZmNscnRzd3VPb2VEUmZQS0YrYkxrM0ozbm5LbXpFaDl6OG1VOUNRc1Rp?=
 =?utf-8?B?SS9NNE1zOVJFMGJqZ09MclEvelIxTG5YQlkyNGg4dEFNaHlEdkJmd2w0TkZ4?=
 =?utf-8?B?a3ZNQ1ZsQ3pIZnRFVk5zT0lwQThCYnUzODNRM3NiZCtCM096b20yc24rZFNT?=
 =?utf-8?B?YUN1Ukd4MHhSMWE3ayt1R3YweWpvNXAyMHpzcnRSdFRIMDc2aXlwalUyOXBR?=
 =?utf-8?B?dU1LNWpMM2IvNUlSN3hRN1RaTEpaSi8vYml0ekVJK0h4N3laV2R5WkJIeFhn?=
 =?utf-8?B?S3ZsVEd4OW1rMWgrWHIvTzdaTVVNN004ZGRNUUVwSTVSZ1pDYkVMdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db0e50a-bb88-4114-4bab-08de8b31f0ab
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 12:19:34.2385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IlKuVuJnPNSYIgBiuVYfr4wLCK1bUOuOhM4KF5kTnar1s3UJlgU+5CxDSDqJxiji7pKkX+gNx2oLvbvjzS3Wxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6680
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Mar 2026 12:19:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22583

On 25.03.26 10:23, Felix Moessbauer wrote:
> By that we get support for the imager-bom feature, as well as a couple
> of bugfixes.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  kas-cip.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kas-cip.yml b/kas-cip.yml
> index a3e9b24..ca865ed 100644
> --- a/kas-cip.yml
> +++ b/kas-cip.yml
> @@ -22,7 +22,7 @@ repos:
>  
>    isar:
>      url: https://github.com/ilbers/isar.git
> -    commit: 33ca03c711e34d38d303ca38c1259cb6c5fe55ef
> +    commit: 34c3cda51b46a2a2a405e472a3c4b88c820c765e
>      layers:
>        meta:
>  

This is causing build breakages and need Isar patches that will come too
late for out release - pulling this patch out again, leaving harmless
patch 2 in place.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

