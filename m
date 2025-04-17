Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0024C369C9
	for <webhook@archiver.kernel.org>; Thu, 17 Apr 2025 17:43:09 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.51])
 by mx.groups.io with SMTP id smtpd.web11.15057.1744911788648234010
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Apr 2025 10:43:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=AZUXv1FM;
 spf=pass (domain: siemens.com, ip: 40.107.247.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJ/XS/AGD8cbM06nK+CDme9Vd1S/kL4PlZIuSfp8+KaZhQL9qDPBjXV2AwFrN5hbjD9bWQeY7la3J8UTJNRQxbBPzOSQnrycdtZrs6/aYbKmx1deP4yn2VV8tFaQiAPZoO0JTcjfzwEKtAXlP8NSoI+htNzjptH+CEScStAbyVVT59+TVToTDZgWSEuK+2pGyGZLa6sC3l+81hJe51K1CSxaHilAtTWCiLOC1330OKvcTU7oYaPLoZOEkGcvfi0MAaPHQnvpG8flA9azsIMZ/kSO+vxfjkMcmZTwE5K54Fns6OXM5XIojvBiP4GtgGy9v53ZzA5m7vtbA2g45jN+3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3jYjky5Dbd5jFp9k54ucobm5ueK202iz/lO+it1pIQ=;
 b=tlD2e6WMcUGtTExTiH8sprkEjfJ9F+XQ2/LJYj459cudM6tagU5Hg73vbwNku79RWBXjpEp7nXvcWnkeLHbWQH93NqkeB9ehwwmfDH5n9Gt+fAkeqJzJ+KsvMYv6la0rPYtvtYiPpmsdYcRf2Qry1wpep7GucsJEdhI5Z/6SdkvSYWXAF6YRPK6nlf1upm4ETBVu2tUPOjVop+hYKmXQb1dP7+LcG7WbBkeBAWyni3tKuHdbYWiIzUHW+XsvjSsJRG5At4iYDw9Q3rUaIJtv0fmju9FZ/d+84ze7hN2/zFSCrDN+x2xlvp7fgI8pAL+GOe8EH/6+Od+ZmazHnNIUgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3jYjky5Dbd5jFp9k54ucobm5ueK202iz/lO+it1pIQ=;
 b=AZUXv1FM+yPLOaZx1w+aaEseNoz3dEovxwQi5XRJ+3kuBLfSVnEs9TIbBgOYypxctM9hJ+GeMlIwL054Mi4dqP0AElO+HXBkRQMDOYBFOz0kI3p4sb3oTOZmbOK0lB2TpTcGjqVQ26E0Pr48+cjOqGCsBpFFcK+9vVYnnbx8/DG9f6CyUIeCkXJoE1CNfjGOZjGGDVzSAQDSr+ApWowIDJTXZcgN6OW0XkQShcp9k+AJnbGL3G2zb835GmwNsh73qtRzTNOHES+FOfkPJ/Dto3gyNc7OV9yW3+yMwQQcQmP8fl14sp/MdK8A+O4hXAqF/givJpjaXwQAvttS7qJEgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5809.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:390::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Thu, 17 Apr
 2025 17:43:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 17:43:04 +0000
Message-ID: <825618d2-d3f6-44f3-b1f0-625f7256dd38@siemens.com>
Date: Thu, 17 Apr 2025 19:43:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v4 2/2] IEC_template.yml: Update IEC layer tests
 revision
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20250417072708.2757909-1-Sai.Sathujoda@toshiba-tsip.com>
 <20250417072708.2757909-2-Sai.Sathujoda@toshiba-tsip.com>
 <7fb7d0ce-f588-4d85-a01d-ea8678588aa3@siemens.com>
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
In-Reply-To: <7fb7d0ce-f588-4d85-a01d-ea8678588aa3@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0398.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5809:EE_
X-MS-Office365-Filtering-Correlation-Id: 036e3cd3-1ec8-4145-9eeb-08dd7dd74e6f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WENNOXgraTJERmppekM0NG9MU2sxdWgrbUxlY3JMMjJpaTF5ei8rOW1OUnRx?=
 =?utf-8?B?eHd3RGRzRFJ4T3F6Y2g5bEthRDl2WW5DM3k4akNOQm1aRk8wZVYvd1YyNHVs?=
 =?utf-8?B?ck1XYkFUZ0tiWTFnYURNS2xlUDl5R2txbkYzS09SM3hZRklNS3RJcFRWRndR?=
 =?utf-8?B?eXc3cmNLVDY3NXE2RHRXSTZsTDc2eXRJZXBBUmE3L3dtSHlsVjFEaEZMckZj?=
 =?utf-8?B?bER0ckFXWDk1MUJ0TVRlWlRPcFArL0xRTG4yNE0wQ3FYVmlnSWNBcVE0bWkr?=
 =?utf-8?B?ZEVNeFJOWWlEcmhNU0UxaUhxdWtTYVJvR0w2ZTVqblBKY202ZEJocHZ1TjdV?=
 =?utf-8?B?RnVieEg2aVRHWFE0cEhGMTZJd2F5Z1pQRVNZOUVBbDdxeVdDUlNwOHlxS0FX?=
 =?utf-8?B?djdNb3MwNVhCNXNvT2JtUGhMYnpLOWZkRXROclhzQ29sTGN2SEt5UDZzUmVJ?=
 =?utf-8?B?aU9vMHNrU2h2bXJuNU9FNWhneU9RRHFQWU54Z3JsQ1NrNysxZHBidC81Z0gw?=
 =?utf-8?B?aFBsNGhFZWcraWcxZko4V1lRTVdsWlAvQ1lpSzRCMDVXbForWGFGczFTbFJu?=
 =?utf-8?B?d1BsNStXWkxqN0pQRkVzZ1V1RkdXOEg4MFBUaXNxb1IzMjdDVzhsQjBzTWc5?=
 =?utf-8?B?RjdxMVJGZldJSjAraWZSb290NkpFTUpKQjFFd0xqdzQxeUdVeHQxSUYvTFlR?=
 =?utf-8?B?YWtCWjcyamJpcUE5ZVlUd0MzNzRUcFpZM0U2cjhDTEs4czFVc2pnUFVWUmEz?=
 =?utf-8?B?ZDVpdTlVYUVoaE9PMWRsRC8wOWZWQ0VraHNScWpzUUdDdzV5VTJFeENJenNQ?=
 =?utf-8?B?ZDJSeDNJc24zeVVCTjZjajdjZGdySEFCT2xaRWIxTjgyb01vTklMTEcyMUFj?=
 =?utf-8?B?cHNrUVJXUjVQZjZGSVZvMDF6ZnFYMDJQSzh3NVNRa0FoVmN5ZmdsM0N4WUNr?=
 =?utf-8?B?TEJvL3prWXQ1aU5vMHFBeUs4cVppSkNwWjBNNkNlOFVWT1NnTnd4TVNNbG9w?=
 =?utf-8?B?MDJwQmlxVUlUMVZ3bXhSUkpzVTE0SWFsRlJXRzA1K0pteE1UeFpRaFpkUXB5?=
 =?utf-8?B?WlVweS9Bek13bmIxS1ZacVo4eGlqUms5R3BrY1F5YTdZSmYzYzZzTHljcnNO?=
 =?utf-8?B?ci9qQy94SzJwdG1Xc09pQXc2ZXBHOVNrVk1NOWZtUExOOFNFMkpSWlZQUnpn?=
 =?utf-8?B?R0NlRjM2RStlTjBTTmdoU2FuQmFtR2VIdTM1VldYclBuM3ZhUXNVZ3lqQS9J?=
 =?utf-8?B?eUMzbWgvQXZZa1BGTGNvNVk3TDY2UGR1dzcxcnhCcDJvejhyR0E3VEN5dFlN?=
 =?utf-8?B?UjBUYmNiTUJPQlBaendvekRLMllWS3AxcFg1aWFDRC8rdjljRC9MV1BRT1Jy?=
 =?utf-8?B?dUpSNWlvSUZzUStxWWRGckdTNjFlZkFzK01NVWhVajcyOHg4cjNXbVZiOXg4?=
 =?utf-8?B?S2tVdjRiaVBQbUUzd1JxcFBSTDVod3RyekZUcG1xNCtsaWl3WFFwTnRGQ2Vy?=
 =?utf-8?B?RlVUZXE4OTc3b3Q5TnpxOHVoVFhTVGQ5OXpGdGJodFk1SURUTFBUaUVyc2R1?=
 =?utf-8?B?OVRGa1JyRmh6MGJmNzdLbk9pWk9sVVNHbmxWeUJzNzk4K2RiODRUN0NvWXJk?=
 =?utf-8?B?TERydkN1TGtvSHJob2F2eThrdzlRWUF2WmtTbkZlWDBqQVFyQ1REWGNlTFlW?=
 =?utf-8?B?b3N4bXN5Mms1MVdKY3NzdDArTUs0VGdvV1JGK01NQk1KOE1Da0FWOTY4Sy9s?=
 =?utf-8?B?OTJKRk1PMm5tZ3VUeFhLNGNaRVE0MG52c1ROZis4cEIxck9IV1NqUjR0S1FG?=
 =?utf-8?Q?trHtJaildmNnfs9oJ/CgRza99+gbsb4xU6PyU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b0tsZ2doWk9ocStlYkgwQ0FSOG10djFIcVQvK0p2aHN6MkE3eFhRa25TSzNU?=
 =?utf-8?B?aE14SHozajNUQ1JqTUxNQWJaaUF4eXBxTkRFYUhaREI2Ty81WUlwaUE5Q1hL?=
 =?utf-8?B?OUtybjF4dnp0djNsOWluaHUyOFo4WHZxYzJsVkFXTXUvNytPVXZDd01BeFp5?=
 =?utf-8?B?YzUrWXpWbHpnbzhRRnBydmNmamhESmVVMWsvWTBLUWJZWHQzdlJMT0ZPTVBW?=
 =?utf-8?B?ZmJCV1luRHYvWElxY2RITmdrclpzdzRoeFhieURUbVZoSkNVck5zVHJvUFg3?=
 =?utf-8?B?SFN4eEtManlkcXV5N1pQM0NiOFpldm41WW4yYkNKaHk4MDlGVjYyN3VrM1Fj?=
 =?utf-8?B?YVBzMWpETk1DNGhTTE1TRStONjhtY25EM2NnUERxaldjSUt3MHhLM25FZHRJ?=
 =?utf-8?B?THZ0VkNPclk4L3FFd3luOXVlVWpTT2FrSEN5UTZsVmUyRDAvL3dOMnpWdTNZ?=
 =?utf-8?B?cFg5QTFwVE5YS2tmRFBvOUt5SGVvNnVoNDdTeTBNSXUvT2FQcERmMmxSeU1B?=
 =?utf-8?B?NDlwbTdyMGc0Z21Nb2tLQmYrZFA3WnRscHBWZTU4STRHeU1KWFFLaTJYaGhT?=
 =?utf-8?B?aEdVbHVwOWF2QXAxdHZhY2xkNEJ3dEZScUJELy8wTktucWxETHh2VmVOaVJo?=
 =?utf-8?B?dFdHeVVoSVdUSGY4MHI2SEJLbG03VTJnbWl0bjdObHlieGpReGg3bWpTTlRp?=
 =?utf-8?B?T3hiZEZzZGJaZytEZWg5NDExMWlkLzBzdHpVVS82ZnJhek1mTmxBenVpNENy?=
 =?utf-8?B?dlYvZ1NJWmJDc29tdnAzaGdzZU90Q1RCWUpIMzZyYXVsaGlnUlE1cVo2Z2Fq?=
 =?utf-8?B?ZHRmMDJzUDI2LzFxL3F3S1hhcWsyM2owRVJyVEI1STlxK1NWYlFPNkpHL3BO?=
 =?utf-8?B?N2NlYzNqTnJ2NEpONFdlTkhObGRqbnMyc3pjTHY1QjBNZzNxZUhNOUw5TjFD?=
 =?utf-8?B?aWhDd01TUkJ3MmNZKzZHVjNoaTNNRXE4eGVnT2dHeld5djJ2aUF6cEVNNDlt?=
 =?utf-8?B?cVZ1R2UyK2ZXV0tRSW5XWDV0NGY2NGFuWXZmUzI4WklwK3o3Vm9uYzRSMFNB?=
 =?utf-8?B?TkoxZ2xPTG1abEo0RG5YdU1JcTA4TndYRTAydDhGdFhrVHo1TW9oTzJWbGZ3?=
 =?utf-8?B?VjFxaFFPS0tqMWgzUVhmNnFLY0crc0VsSDlzWGJzN1ZUVEtId3cweENVOG5y?=
 =?utf-8?B?dEk4K0VsRVNMUVVQL0h5SEcreFY5dndrUk40cXNXa1Jla3ptRFRYdSt4cHYr?=
 =?utf-8?B?eEtPQ21lRmR4NGRTNnJxR0p3OG0vSGE3bCtSQnZHZGtOelVVdHFLZFljR25l?=
 =?utf-8?B?T0o3Q0ZNOUxGakhLL0IrK2VGY3dEYkVQTlV0ZUlxcTJQSytzYUlSVHkzNzhu?=
 =?utf-8?B?b1BUT2lxNk85Q0FLYTRqR0FHN0pnVUM4MGtlV29sbm9GUXpKVnU2dEZwZlV6?=
 =?utf-8?B?YnFKamZORXZhTGhWZFB0aEdlbHJqNmxaV0FMVkdIb3JXUDNDeVVnTHlrVUwr?=
 =?utf-8?B?aVpyUkFFZzJjRDhIdytQeVRJNGRTZ0JzMkpmYjcwTjR5ZjJEaXJURVNOakhv?=
 =?utf-8?B?SFZOTWNENnl6UG1VTVA5bXNieEE2ZEVaNVJMVWhBQ3pJbkxSY1F4ekhYZUVr?=
 =?utf-8?B?bWsvTll6dGFVMTdMeEZhU0dMaDMwVnNYaXR2MXFMYjIweGxXYnFEYUVmTjNL?=
 =?utf-8?B?dDljZlR3ZmErM2pzMXNQVzcweTBBcjRuM1RORUtHeERPMGNzV21CVldhNWNq?=
 =?utf-8?B?ZCtBSGRWR1dMenR2VXBScGFLUlVQc29ObHZiRXB0QkwxVUZnbE9DL2trRDdN?=
 =?utf-8?B?MkIvSmdhYWMzcXovOEpEb3NDbTJweGxHSWtVMDI2SDFPMnNkV1A3eWpPSFQz?=
 =?utf-8?B?MXlSN3l4UjdQTjlRRzM2UXNWRUR5cnpRS29YazJDeThwd1k4STRkRGVjbW5Y?=
 =?utf-8?B?SVhSWHZVNENvRTVYbk9nVkZxZUYrL29FQjlHRkVyRzBRaVJ1aDFDMG15TVBY?=
 =?utf-8?B?cUJFRWVuWmVTQzY2MjdDNkNWL2kzK1M3YTR3ZUM4NDUyendoNzcySVFmVHNW?=
 =?utf-8?B?K1UrbGI0M1MzZnN3UnpSdkxCQjM0NE10K1JZMHJHR3dHazJXMGJjYWs3U3BQ?=
 =?utf-8?B?V2FFemV4Qyt0ZVcwWjdlQ0Erbk1jcFRHMTIyZVhCQzF2cC9FWW45V0tVVmpX?=
 =?utf-8?B?N3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 036e3cd3-1ec8-4145-9eeb-08dd7dd74e6f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 17:43:04.5866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IuEe2F3A+TCIMp90BxQdpK4t5dMQ1dn/1cl5IeWG6ktKR/c1/2JeA/0/CTb+EmgocC/UhIeIc3zkxgw9djCizg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5809
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Apr 2025 17:43:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18524

On 17.04.25 15:22, Jan Kiszka wrote:
> On 17.04.25 09:27, Sai.Sathujoda@toshiba-tsip.com wrote:
>> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
>>
>> Major changes in this update:
>>
>> 1. Fixed instability of TC_CR2.7_1 (Concurrent session termination)
>> 2. Added TC_CR1.10_1 (Authenticator feedback)
>>
>> Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
>> ---
>>  tests/templates/IEC_template.yml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_template.yml
>> index c8efe40..b93ed4b 100644
>> --- a/tests/templates/IEC_template.yml
>> +++ b/tests/templates/IEC_template.yml
>> @@ -64,7 +64,7 @@ actions:
>>       definitions:
>>       - repository: https://gitlab.com/cip-project/cip-testing/cip-security-tests.git
>>         from: git
>> -       revision: 5dbc47f55d4a43449dcbde4363e5d23d6e96344f
>> +       revision: bb19990c2b29ea96eea309e54124c74ea3246f18
>>         path: iec-security-tests/Singlenode-TestDefinition.yaml
>>         name: Security-Testcases
>>  
> 
> Thanks, both applied.
> 

CI fails now, please have a look:
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/9757849360

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

