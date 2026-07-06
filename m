Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE71C43458
	for <webhook@archiver.kernel.org>; Mon,  6 Jul 2026 09:16:06 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.58])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.147184.1783329359637214178
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Jul 2026 02:16:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=wFRUZza/;
 spf=pass (domain: siemens.com, ip: 52.101.72.58, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bd1nffAY2qRzltmfmhAIiCch5NalzwdqmrByjANQFCzzvqJzB5RZTdOlYUzFQSFz0wO96gq2QmFo4OILZshrCe+LX+PQLn5hUFzI59MIPqCDAH3D5/rM1eK/FKHjUAf9ew52yPCJ7Whn82P41MJgjHwS/c0qpDboFTXkcyHqG1+tLP1k6agmkv0WwImcIzy/XwNx6AXxhSUwOKO8CfM8uQhYufDEDewNv7TFnJp4Jk+zAdmYW3KKlPPJRZiE5szdIU8wWzWneTEd+s/HcUGKzdiL1U0BPpl/rYz+hTATiFbSjMIj++U4OrbQJIASp0AtkLXqD5aYiL/f3rrcCjMaKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZ5pTnJQNKu/1wUdJqVnyIjYtik1IKl0/VGBnglgKIk=;
 b=lYakcSBpUwTxf/1MvIBB7gZYify+EZCISMpgKvPX3evzFo8Y1wVVMqJCCA3HcOQdpe75f/AflbbQnhAR9CSMhGwNeHd9Enn/ek9o65qDKgFt2vWkb4jrJUI2tCycDGbVwwK5yFx1NQcgLd9SuPaCQm5+wghuJVVVU74vBkq7O8s099JDanhvqaYFvcRrdbkp2ByyLFAK9t/qbbb7b128eRPCT9SiieIWBR5sMwEiytii2+hTaIXUAzlNHsmShdM0HCmVpoDKFfcM0YWmjXCvVdTAeqDQNnnX9C5/SJa9bUy2cjX+H4uCFBK1Dv1zbTX2DKXYaMGMtzB1EyuJZlc76w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZ5pTnJQNKu/1wUdJqVnyIjYtik1IKl0/VGBnglgKIk=;
 b=wFRUZza/UpPWrYCXK3M1TxBF1L+r473S6wvQHUayv+wIZa9l9BQEiDNaRhl9AVWHesahEM2+WXbpZs996fIUNVdiXnIKK6QCpYJUSCfJujrCmkHTpfIvZVwF1+BKzadHMZ6olNmArlP/USMUAMA/FsVj1nBY8ZinSz3XSJtALAM0N/+epadV2NPtdvt5VdtFO0XrSkm0cvFl9scNo9BNCQAW/GKyRftRDe1pEMVuRWS2JypDK2IEKDbjsjV9/f6ICwVVqQNVRvOKQW+R2kD3wTEvMzXd5HrTRh5UBQ5yu1hmCmXLfIJSJdwTO98HmZSjJ4emARp1jTn1FEc8AO5m2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6920.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 09:15:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0181.010; Mon, 6 Jul 2026
 09:15:53 +0000
Message-ID: <a266e8de-2662-4ddf-ba4b-858dc9f13fbc@siemens.com>
Date: Mon, 6 Jul 2026 11:15:52 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Kconfig: Drop redundant target exclusion for
 kernel 4.4
Content-Language: en-US
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Hung Tran <hung.tran.jy@renesas.com>
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
X-ClientProxiedBy: FR0P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6920:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a9c7992-2e81-4bf4-d724-08dedb3f2de6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|55112099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	ybUo97tN+CiEKROe8n6K+0urj9vgPh9nGbEGDsRAdhMezF+LlcbiOu8XnlK0DpN5jn8ptJEVwx0TxxiuNM2ejEvVp4WltaYXrmYyIcHWm/4psVdtiwDwWu1C+CX2BDkouAOe+ZKCf1sDPs2uMp3V1wkGax//eOVxN7++gLn2ccTRVE2lmArgtXi4TqxRjfysTynWpMCKZIOEppgoQC9BLnZUv746A4XARcu5lpcYSWhRJa04w/CHV2B784yJia1MRnB80ZSF/iFm2LVMGoDLJVp90kLm0NMjcp+eJxrl9TmYahnJge0waR7yLYbYjJpuhtHL3eMzs4G6biBGOxxGQ84C7YBNAzKKDlIm1SifkKjl6L3wsZ/TtSLKQIuf3dmLaIiDsTB3AtRZRa7P220OfI7uFC8o5Ftg2bm19crnoQWt65wFtbBkuKYUs/znj1ab5qrFguKc1M76cmv8qxQQy98FvnQzh3xiHHrB0k3WMsrqWXpSH3vbd35ZCxTRLWIm+hZVw4PVIfrcN3Ab6R7xJhIoEDN4rlnr3K2NvE4GFsHJSOgWWvEyxR3+bTw9o8jUT9R9qqJT99Kg62JweiMOk3uhNxxsjSdS+zQ7GQgU1vsnrHE996QUavQnzD9xDvDLfRDbdBpRDNNEuXmmPGxZsYqVRnWEuTIJgXtjVnqEP/E=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(55112099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bDd5UWRVWGIwdmZJV09kTGplMjZleUMwK29BYlVhazFLaVRzRE9LZWd4bUdL?=
 =?utf-8?B?TTBmUmpJN0lsZXlBaDBxNFRqQnNURzZ2UnZORmtRdTNvUVlkdnNZenpMaUxU?=
 =?utf-8?B?M0E4OERodmdBV1l6OHdWckxqNmp3YXRZSUxQSkdvTHJwbFdmbkIyQ25NUUVY?=
 =?utf-8?B?ekdlNVdCbHgzcFFFTjFNYjIrVU5FWndwYnhsTGJQWHVabHhNWGErTmFmUnNW?=
 =?utf-8?B?SUMxdUtDelpzd0U2QTRWanc0SXY3MzVXTTR4dXlqbW9MQml2TXdHU3JMQ2Yz?=
 =?utf-8?B?TGVRZi9MdVhGSWlyWGFkRHVvRk11TnVYenRWaVpxcS9RQkxTL04ySXg5NjRs?=
 =?utf-8?B?QnQwRnYzdnZrbXE1bUtEN2EyQ0FORHJha3JuYW5NZEI4MDBUbm9ZNWJ3Mk1N?=
 =?utf-8?B?ZjZwcXFYcTArMUVOamt1RjhOSmxMOEZnUS80MW5zblVKK2dHN2JVZW0zM1Bj?=
 =?utf-8?B?WlpxVWRXcFJkSXFDR1dVTTAxaUlNMmJLTGtPUG9aM3ltUDZRRkpIbXBzYkxV?=
 =?utf-8?B?RmJWRkxJT3o1ditVbm1Udk1LZmVWaVBtdEMxNUZvWkdZYnpObUk2VlhaSldp?=
 =?utf-8?B?cDZHdmZMWWppeUdWY1hFOTJoeDZYTUFZV1ErVmthMCtncDNaNUp3cFVOSVpi?=
 =?utf-8?B?SWxsOEVRU1IvRHRWWU0ySDFOVzRCTVJFREpCUzdzOWdSbEN1S1BobjE2UnVu?=
 =?utf-8?B?Rnc3VSthN2dGa0IrWGM4a1RMYkYvcHN6Yy9DaU9mOVBGcmMrSDBGTGVwd1JX?=
 =?utf-8?B?ZDAxYXdYRUl6cnVpWGZqUGo1dmNVRFVFV3hObkZ3YjA3Vm5KVkhGNGpnY2xG?=
 =?utf-8?B?dDdVbE1wM1NnODFBV0YzRmtjc2RGcXpObHQrVE9DTUsyT2JkbUZEdXlBY0l3?=
 =?utf-8?B?TFBBcDZRK25NQ1Fjc0J4aTBORVpUL1F4cERWK1Q2SEg0T20vNUo5VTR5SlpZ?=
 =?utf-8?B?b1VUQ1lTMno0TXpaQzMxRG5PdU54UUNvcHBMcG9uTFc4VXd3ZUlKemtGM29C?=
 =?utf-8?B?UUVHN2RyZDUvcHZjNGFNU1E4THQyL0liN29hTzVxbTVJVHJFM1AyUkhsbk11?=
 =?utf-8?B?OU5uYVl4eEZsMVViSWUwL2Y3OXBTVnJWQ2ZSa21yWXFvTVFUakdEbDFpWGVr?=
 =?utf-8?B?NU9kNlBEYm9uendmRDlqNWZaa2dSYzJKT3BZbVYxaXQxMnREYnlsVmovQ01m?=
 =?utf-8?B?U1hLdEpyd3VoR2NmSlVFcmFUaGR4akRvR2lqc1RBc1pVajN1KzUxNHlOVlJ3?=
 =?utf-8?B?MllWL1B3MGlUTTV0eTJWeTlEOEl6Mm56TnhkblVyNEhRUXEvSlJyTUQ3cUhG?=
 =?utf-8?B?TjkydmI2cmJReTdwMjRGbEZFYmFsc0U5L2lSdk9hMVR0WDNQVmZ5bXpMQnJP?=
 =?utf-8?B?aCt2NlBPUGpUellVTEk4Z0M0a2poL1hnZUZLMFRUQzNhanQzOUtFRVZYZVZK?=
 =?utf-8?B?NnJuR2o2dTZTYTJHOXRLQlJQVWRSaHFyaGtacDhtdGUwcHFSc0pNNHBHTkR3?=
 =?utf-8?B?SkpoRUxUUG12U01FRlJBcVlaVWhkOVN6OXBNN0htZkY3TVZVMzRiYkdMbXlr?=
 =?utf-8?B?Nk5SMFpwL2x0UDhYUW55NWNOcFlSN0JjelZ5TFVwUVBNUmxUZlppUGFidXJ4?=
 =?utf-8?B?L0J1d2ZVTDhuVEkvSUt1NjBYakdacTdRaENBNDFKUVhHbkNIbzdLRG9rRXMw?=
 =?utf-8?B?aTh6c2xoYnBGSlFQNTVKT3pFaHFESlhvN0dIczR5dTUvZjIrMGJWUUxDaUNJ?=
 =?utf-8?B?dENWRWxRWU5zK09tT2FUV0dpczgxV1Z0aFpuNTVOcXRtTlZhWWRFcXcvYlha?=
 =?utf-8?B?SXFReUh6SFpMTkZWSVMxOFZrbktDcU93TlQ2ZkdoWk5KZDM5WllpUm5JcnM2?=
 =?utf-8?B?UXhhVGVNelEreUpOUzdsYlJKcGg0dnFIR3c2SjhPdGU5Mk10dFQzSHMxdUtp?=
 =?utf-8?B?MWZnNk9XTGNaeUZMTCs2N1NWMzlzeVd2clRjUWpxRXlkKzR0cHFMVmZNWTdE?=
 =?utf-8?B?ejVmMG1yUi9xdU84VVRhMWdFOVI5aFNPTnJyZTdwem1iZ2hOK29STUN1U1ZB?=
 =?utf-8?B?Q1VGckNyYjJUWUd3eUtIOWtpWFRpOWZGa2xIQmVYQkZ2TCtLUVAycE5VUTF0?=
 =?utf-8?B?REplZ2tyejgvbnhGd3NVMkNpT21iRi9zSDg0NXRPa3B2ZEpMZnlnR2tKaC9V?=
 =?utf-8?B?VmhLMFJKK0h6bnYwQ2NNcEVYRmVsaVh5ZklXTGk4M1gydE9yd3JrRmlZdEZU?=
 =?utf-8?B?Z0FuMDd3RkYvTk42NFpqZXRCbFNyR3lnYm1zdHpUaEdCRWMzRXlCdm52S2hN?=
 =?utf-8?B?c1JBQk5zV0lkMW9YTFl5c0RDYVozWlZUTXhyOFJIckRkcUZ1VHI3OXJwM2g5?=
 =?utf-8?Q?ONrsARR03DzUgKcY=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9c7992-2e81-4bf4-d724-08dedb3f2de6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 09:15:53.4890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gm8yelX/yMq+X4mfxlBOX5y4DawTwETVBClY/gbnvZ4QF2YAKTj5ApSx8xLdsfLzXQrSBkosi10fZfXBgehsoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6920
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Jul 2026 09:16:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23457

From: Jan Kiszka <jan.kiszka@siemens.com>

The AM62PX is ARM64, this already covered by the !ARCH_ARM64 rule.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Kconfig b/Kconfig
index 44f2337a..438234c5 100644
--- a/Kconfig
+++ b/Kconfig
@@ -144,7 +144,6 @@ choice
 config KERNEL_4_4
 	bool "Kernel 4.4.x-cip"
 	depends on !ARCH_ARM64 && !ARCH_RISCV64
-	depends on !TARGET_TI_AM62PX_SK
 	depends on !DEBIAN_TRIXIE
 
 config KERNEL_4_19
-- 
2.47.3

