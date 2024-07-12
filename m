Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844E1C2BD09
	for <webhook@archiver.kernel.org>; Fri, 12 Jul 2024 07:23:30 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.68])
 by mx.groups.io with SMTP id smtpd.web10.2610.1720769002910571108
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Jul 2024 00:23:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=P3ks1zhU;
 spf=pass (domain: siemens.com, ip: 40.107.247.68, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PvY4rOX2jJaLTJ4wl1Monj/E6HEvTH+LgDIzSgwaGkZlien9qOeCUZjFK6alGKnuoapLvPYNr70vRXTfnY9rC3jhi6rRhaU4m6Z4HSjmxi9wmJ+UNw8Mv7jI7x6P2mJhxnskkBt5yUuEXCvd5xqWnLEpAnY54twuzkRDMBuhH6r/ElR2pBNAHN+fwdAuUOARyk00Y2BefvYVXvOEydgMYJaM1ZyzcyrWIAlGkuhJ97DvdLPGVCmAUiVqtZPuvFdY82RDfOKYeB0b04FTSBoiVqcYgA36UVvX0L34TYl2hCAxzzqFvLZ8UhH2kM16v3UPRfx8qz7nIiMzyAnqwyXyAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3eektT+0Vqybaw2IsU0VIxTBDbtY0wN1EUGgSBP+pw=;
 b=PDkXsMqHWexwJtb45HY62WD9ylehZvCG0EatD0ca0/eoCWVx29jlIyIpnryS+/kgEyrjLz0DBtWvlOxB5lL07urBLVLMDZ/jVqLDX4tuuMDGUcfH+bXsXZortXoaml//LqvyCo4HzImcNi/OBSRcrIwKJsiVYaxAx41lHKmy8SUhpA0ayH6YxT+0M3+kWNG3HgKk3cfk5b8H/umFqAWD/q2aVguIFLrDxAYB5UMnBUtrlUVaaPsAPUf6k+ovvXzGEFeBLcwRAwaOmpcJX7BuDUG23Oihyjzh6ioaW6KmYfmKrXyPp/f0DjeV6gfHq22yVshNys1SBh2BVxTrNo/pPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3eektT+0Vqybaw2IsU0VIxTBDbtY0wN1EUGgSBP+pw=;
 b=P3ks1zhUJ02izeuAbpTkYNxMEouD37rF+Am4MCXVD9dYwJICXTj4lq6JDYAoJ4UZ9txlvccwErQjgEOvQCv6Ur+mnkiGH8LiVBgTzeVNcyeD20OF6Pq5NrBk5KVcb826RYtVfPVysfjInyK6RzUuwxry877bXzyr7DymoCubIUQ7G189YEdlvjWAnEXnKpPXqRPHFre44sGNlxVvMTdhxtG+nY0ShpdsGLSm96J/VbTbzC1blIPIhjkLo0cdm1k5JgiDUyBqlMz3LAxD8Rne1goxuEDdOpo7Jdug+sgUQgAYnDO+t/TrZFwJOTwwaU8YVL89893y0falWmp4Lu7MQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PR3PR10MB3834.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 07:23:19 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 07:23:19 +0000
Message-ID: <63f09b2e-7e46-4587-851b-b6140c191f96@siemens.com>
Date: Fri, 12 Jul 2024 09:23:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 2/2] initramfs-overlay-hook:
 Check file system of INITRAMFS_OVERLAY_STORAGE_DEVICE
To: Clara Kowalsky <clara.kowalsky@siemens.com>, cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com
References: <20240708124734.591324-1-clara.kowalsky@siemens.com>
 <20240708124734.591324-2-clara.kowalsky@siemens.com>
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
In-Reply-To: <20240708124734.591324-2-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::20) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PR3PR10MB3834:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cb01739-5cf0-49c5-0fb9-08dca2438120
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?a3huWlVIUGJPOGF5TFNxMjB6eHd3VUtvdjRkVUU5bW96WVpKbG8zdDljL2Vo?=
 =?utf-8?B?Vk51V2xoUnpuMWwvV0JhT0NuVit5NUZvN0RPTThUdXZxZFg0aEY5bUxCLzVE?=
 =?utf-8?B?bXBLMk5BQS9LOEVscnkrTGZ3TW9mTzlxdGpQcEw3WlNEaHN4UC9nTkVmakw4?=
 =?utf-8?B?bEVxMzlHMFVmYnl2amFYRytpL0RpeGxjaUpMT0ZEOFo5Rm5aQzl2ODJFRTZr?=
 =?utf-8?B?a3BrNXNubGI0QUJmRlVIQWRlaS9Jd0YzWTZDeStFYVgvaGRRRm5YK3RLS0Y3?=
 =?utf-8?B?TWRpMDA1cXFUSDUzRFQ2NUxUUFRmR1ZGRzNvZjVOU0l0OWRCNVVPRFcwZUZE?=
 =?utf-8?B?WXlFYTFTczdhOGhJTloydmYwUjBTZjFFVEtMdklEWVBVb0VIOFBhSkFkQkps?=
 =?utf-8?B?TUpnNG93VG1yVVlUU0hxSnNjR2lzZTdBODlleWUydHVHbFMvWGNYQjZneGhi?=
 =?utf-8?B?aVlQYVlVVHZIdWRsbUx2RU1ham1Da2poWE02ckJoejdQQmNQTVFDcmhHVit6?=
 =?utf-8?B?cUVOOVhlZFZJNktjTm5oZVJuRW83QlhUM0hZS1pIbG1tOGIzNWhhcEN4SFY5?=
 =?utf-8?B?WjdIVTdDak5GVUdlRXA5VG5FSlFtanVaRk1jaUlCbEo2SmhNYUZEMVJHRm5M?=
 =?utf-8?B?V0Vjd3NqYUJGMjl0UktwOURPbzNOU2wrc2dVbzZSNGxNSjJubUYrL1l1N25K?=
 =?utf-8?B?QS82d1ZiQ0RHQVBlZkNielF6aHpCVWxGNGNHYi95ZWFhRWR4cTdVdW1kazNw?=
 =?utf-8?B?VHp2TXNVS21NT3E1aENxSGNNV2ZpeU1MRi9vTGo1NS9lekswaTJzWmxKZDh3?=
 =?utf-8?B?bjU4VDhuTHNpWm1udXQzaERYaUhaaENrM25qMStpY2d5UmxYTys1aVQ0cXBu?=
 =?utf-8?B?WTFySEJMOWc1VnplQzJib3hNQ1dhRGRyNmZyRThyWXErZTNlNFg3aENJc0tn?=
 =?utf-8?B?amNsdFVqMkhwU3h3QTN6UEZFVFY2NFUyckwvNUdNZHNpazZtem5nYkFtNm44?=
 =?utf-8?B?V1pEZ3h2eFZIMSs2bnF1czJSQWx3ZWhsV3FkRVJBVElINGtKczhTRG5Tcjlj?=
 =?utf-8?B?UTd3MjUvZThhY1FhOHdMR2daU0o3cXZJR1JodXpPKzNPN0ZLc25MN28rOGdp?=
 =?utf-8?B?elh6UENCQSs4blJDRGJyZzZ2U2pvVUpkamlDdG45Rmo2dUFTazErbDlsWWR0?=
 =?utf-8?B?K0FXVW5FdGtGK1JHRVA0RzN3YkhKU3FvdnNqRG1CajF1WHdKUWRIS3U3ZkNV?=
 =?utf-8?B?VVJrb0kzVmUrOGNBOUZVSUVjYy8ra2trcnVhR3IwUFRTbTFQRTRNQ1pabUpS?=
 =?utf-8?B?TlRpaS9rL3F1K1NLRHFmTC9Yd0ZwQnc0SVFpbDVDak91Z0N2NitNTTFHc2Z3?=
 =?utf-8?B?OGpTdDRjY1hhbzFSdnN2OUpyRE1TejN0MUswUjMzdXNkK0Zyb0dRZFZodUR3?=
 =?utf-8?B?am1HSUdWSGpFTmNMVGlMTkVDTjBWaTVCM1pQVWZyRE1Xc1dpZkdUQlZaUW90?=
 =?utf-8?B?SUY2cDF0VFIybkRjdThnKzRQQXZEcmVJRjNsZEl1cWIyYldCejFxNUo3SEJn?=
 =?utf-8?B?a3JZcnowN3JqRWI2MVZTNWFTYWVjSVVwUHo0dVpLS3BnU3N6dGY3SkpBU1No?=
 =?utf-8?B?TDY1Z1VXYm5hMC9DVE95aFZRNjJXNjJnOU95Z2x2R2g3RmRDeUZNdVFCUWcz?=
 =?utf-8?B?ekdGUmo4NlUvMzB3c01aNFN3VzIwLzI1UUVTNURuMDg1VkdEd2V0YzVHSm9Z?=
 =?utf-8?B?Uk0xTUZKN1Z6ekFEenNSTlFzT1I0SW10YitwNm1kdWtMaDlubG9hYzB5d3V1?=
 =?utf-8?B?NnlyV29iZE41d2F4T3BZUT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QnRkMXR6YWFvQ3ZrYm9TYmY0ZnNzR2JMMjM5L2EyRzRuSGNHdzFOcVB3aysv?=
 =?utf-8?B?am1TRHB1OUt3bTh1dUtoSy93YWdweFAzZmlHV21Jd0tLbUdDQWhnZWlOaFdV?=
 =?utf-8?B?Q0ZrUVRoNlQzOS9MaGlmT0wwSU5Uc0hjd2pRODN3YnlIMHUwcFhaaDNZam02?=
 =?utf-8?B?WkZMbW5RQmp0Mlh2NnVwMWUrdS9QTWh6NGlZeGlmMWVucDVLWHkxeTZSaWJm?=
 =?utf-8?B?bCtDc09laVBNUEtxemNvZW1aZ3RyeitnQVVWNGJ3a1VLK0VVMjJQTUlJSTlu?=
 =?utf-8?B?eDMzbXRZWmhMTFpYYWZqaUFveFdIbkZQSi9TVXovaVpzL1YwUnhCZ1VkV3JC?=
 =?utf-8?B?cXQ2T0R6ZzVuQmdXb0RXc1pSTHRyNWVOeXlKVWt1VndudXdTMWtQNC9RMFdx?=
 =?utf-8?B?cFZnZ0h6VlAxNWQraW5vS2hFUllodE9PZjRQZGZvT2xMMmVCMjJ2T0R3cTEr?=
 =?utf-8?B?bVJKYXgwWXRIMytwcHlBR3IwenNEVFdhcENxa1RFVmMwbGIzQmdWb005K1pB?=
 =?utf-8?B?T0NlU2FSL2VnYTNGVEdkY1U1NmpUU0JsdFlqbENHeDJ6YmNnWElsY0xxSHEw?=
 =?utf-8?B?d1c2aCtBQVB1aFBBNWpOV1YxZTExK1hrTDR3NXlBU1NFQTdpbTY1Sld5cVZ0?=
 =?utf-8?B?VnMxVk5tbDFIeEVDdzJ4bVk2RkE2dk4xWWN6U3VwSitOMjg4TzFabGdFU0x3?=
 =?utf-8?B?NEc2YlI3elFDRjV1TE1UQ3FxVG81Wk1RNkhYczdjSG42R0N4L244dlpZUlgz?=
 =?utf-8?B?NzloaTVVL2pOSE95MnVRdy9yZkE4R0M2ZUFlM2laT081QlpVTUNYbXNsUWFT?=
 =?utf-8?B?Ly9XYUtrWk8weTUxZTBGbUJhYklIT0Y0aTY4SzNIdTUxdk5LWE5OdnRoTGE1?=
 =?utf-8?B?YmYwaVFORnp0VVpVbVB0TUhIMFV0Q0pkemFzZGZjYkVuTllvTTYyWnBEQVJj?=
 =?utf-8?B?YS84bC9welQwOHltM2Y2YTlZb3F5b0haUWtpQWtqQjlxOENGWElhbzR4elBh?=
 =?utf-8?B?Rk4zb3lDNW4xbnhVdnBlMDBVbGVKUzhYWlFJZGZlVEw2d0lITDZvdlBVeFhL?=
 =?utf-8?B?bDBHK1l0WWRjZnB2WndsbVNkRlQ3ZW9hTlRMMHZabzVzOW9SdkJtN2pIcG9z?=
 =?utf-8?B?OTJ5ZnIranhqT0FLQTBJN0k5eE9WU2xNYlcxdjhxM2pBSXM0bk8yYS9SZGoz?=
 =?utf-8?B?QWJDck9uREcxQ3dXV3U2dlRqL0I2dHRlNW9YaVlxNDRxcFV0cnU0RDRmOUJr?=
 =?utf-8?B?emJueGcyR3M3NllJK1JBNE5OMXB5L0JtbWFVcWhiL1Nld2I5ditsQjBYeDhW?=
 =?utf-8?B?bmJmOEJCRnBvMWJDUnpyV0tNNE9vTElCQzF1bUdadS9PT1NiZ2JpRm5OSVZz?=
 =?utf-8?B?enFoR0k3blNGUjFIQ0E0UDJrRmt4WUhQenJaeW5pZUNYYUZJbHRTUXVXWlQz?=
 =?utf-8?B?eVpLdlFBN1hHK21jWHRZUWFGcWh2SHB0N0ZFeXhTZTFFc3VGR2haUHpXeFFk?=
 =?utf-8?B?NHJQNzNtNDZYbGJ2Tm04QUxlNVczdlE1cnBBVlRVaUptYldUbUlGdTVWM0t5?=
 =?utf-8?B?TG1NOGVmMjNzN1E3emtYMmZUR3k5eFVncEV0K01Rc2xiV1FESzhSWFdTSDZU?=
 =?utf-8?B?OTllWHF5YzJ6cUFPSWFyUjJtWndsYWtneW44UCtDWmVYQ29FcUk0QzV0MzRC?=
 =?utf-8?B?NW50bG9xNVJHWUVESE8vQkx1dk1jc1EvM3VyenRsUEcrWnRpV01jeFRDMWdR?=
 =?utf-8?B?MWxweWRzenBCWU5kUEhjYzlEWTFLOTF4M0xTME5kbzNPWWtjMlNkTHB6U3VM?=
 =?utf-8?B?THQ3V3k0dWZjTERGRkZKRFNRdFJ2K05YNHJzUVBKNGduYnNOa0tZZGMzN2pI?=
 =?utf-8?B?UHJwZDJZNUF6SkgrL3JiREJTa2NhZW14bFdsbmUvWW9NTDF2U1ZXWEZIMTUz?=
 =?utf-8?B?RUJrdkJWQWt3WjIrdkdGRFJINHFpOWpOUGdpOGpFYmYvVytUU3BWOVh6YnJX?=
 =?utf-8?B?Y0YybVNBNkVXU2dVYzA5ZHVzTG1RcEJKcEZ2c3dlUEpzRjhodmRKZTU4dWtQ?=
 =?utf-8?B?UG5GYTRjUkY4YnRaRFN0cmE4c0FnRTdKbGxDZEN5bVZSRGJneWgwd3c0UWxS?=
 =?utf-8?B?VGJKV2xiM1VxNENnL0QwNUR6dy9iOWZwV2hkdllaWUg0NmZGektmZGM0cm5m?=
 =?utf-8?B?elE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb01739-5cf0-49c5-0fb9-08dca2438120
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 07:23:19.4284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E79eo6d6jSfq7p8EEPLKc7L3sVc4mMs05qlS5uUstihqgu6IqhChjkGfvRh9PcvCyL8h2wX5l+zPIM4t9WSgUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3834
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Jul 2024 07:23:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16454

On 08.07.24 14:47, Clara Kowalsky wrote:
> In case of ext*, this detects and fixes file system errors in the
> partition device before doing the partition mount.
> If the partition turns out to be broken, the factory state is recovered.
> 
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  .../initramfs-overlay-hook/files/overlay.hook | 11 +++++++++--
>  .../files/overlay.script.tmpl                 | 19 ++++++++++++++++++-
>  .../files/overlay_recovery_action.script      | 17 +++++++++++++++++
>  .../initramfs-overlay-hook_0.1.bb             |  8 +++++++-
>  4 files changed, 51 insertions(+), 4 deletions(-)
>  create mode 100644 recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script
> 
> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
> index 8b00ecf..6f634c5 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
> @@ -22,6 +22,13 @@ esac
>  
>  . /usr/share/initramfs-tools/hook-functions
>  
> +hook_error() {
> +    echo "(ERROR): $1" >&2
> +    exit 1
> +}
> +
>  manual_add_modules overlay
> -copy_exec /usr/bin/mountpoint
> -copy_exec /usr/bin/awk
> +copy_exec /usr/bin/mountpoint || hook_error "/usr/bin/mountpoint not found"
> +copy_exec /usr/bin/awk || hook_error "/usr/bin/awk not found"
> +copy_exec /usr/sbin/e2fsck || hook_error "/usr/sbin/e2fsck not found"
> +copy_exec /usr/sbin/mke2fs || hook_error "/usr/sbin/mke2fs not found"
> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> index 42eb59c..6120615 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> @@ -16,6 +16,11 @@ prereqs()
>  	echo "$PREREQ"
>  }
>  
> +recover_partition_from_fsck_failure()
> +{
> +	true
> +}
> +
>  case $1 in
>  # get pre-requisites
>  prereqs)
> @@ -24,7 +29,13 @@ prereqs)
>  	;;
>  esac
>  
> +ovl_recovery_script="/scripts/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}"
> +
>  . /scripts/functions
> +# shellcheck source=/scripts/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}
> +if [ -e "$ovl_recovery_script" ]; then
> +	. "$ovl_recovery_script"
> +fi
>  
>  
>  ovl_partition_device="${INITRAMFS_OVERLAY_STORAGE_DEVICE}"
> @@ -34,9 +45,15 @@ ovl_mount_option="${INITRAMFS_OVERLAY_MOUNT_OPTION}"
>  
>  root_mount_storage=${rootmnt}${ovl_storage_path}
>  storage_mount_point="$(echo "${ovl_storage_path}" | awk -F/ '{print FS$2}' )"
> +partition_fstype=$(get_fstype "${ovl_partition_device}")
>  
>  if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
> -	if ! mount -t $(get_fstype ${ovl_partition_device}) \
> +	if [ "$partition_fstype" = "ext*" ]; then
> +		if ! e2fsck -p -f "$ovl_partition_device"; then
> +			recover_partition_from_fsck_failure "$ovl_partition_device" "$partition_fstype"
> +		fi
> +	fi
> +	if ! mount -t ${partition_fstype} \
>  		 -o ${ovl_mount_option} \
>  		 ${ovl_partition_device} \
>  		 ${rootmnt}${storage_mount_point}; then
> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script b/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script
> new file mode 100644
> index 0000000..a05e4c3
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script
> @@ -0,0 +1,17 @@
> +#!/bin/sh
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2024
> +#
> +# Authors:
> +#  Clara Kowalsky <clara.kowalsky@siemens.com>
> +#
> +
> +recover_partition_from_fsck_failure()
> +{
> +    ovl_partition_device="$1"
> +    partition_fstype="$2"
> +
> +    mke2fs -t "$partition_fstype" "$ovl_partition_device"
> +}

Why do we need to put the recover logic into a function? If the script
itself is the interface, we can save a lot of boilerplate and can also
avoid that sourcing with the shellcheck annotation.

> diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
> index 955748f..7097130 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
> +++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
> @@ -12,9 +12,12 @@
>  
>  inherit dpkg-raw
>  
> +INITRAMFS_OVERLAY_RECOVERY_SCRIPT ??= "overlay_recovery_action.script"
> +
>  SRC_URI += " \
>      file://overlay.hook \
>      file://overlay.script.tmpl \
> +    file://${INITRAMFS_OVERLAY_RECOVERY_SCRIPT} \
>      "
>  
>  # The variable INITRAMFS_OVERLAY_PATHS contains the directories which are
> @@ -35,7 +38,8 @@ TEMPLATE_FILES = "overlay.script.tmpl"
>  TEMPLATE_VARS += " INITRAMFS_OVERLAY_STORAGE_PATH \
>      INITRAMFS_OVERLAY_PATHS \
>      INITRAMFS_OVERLAY_STORAGE_DEVICE \
> -    INITRAMFS_OVERLAY_MOUNT_OPTION"
> +    INITRAMFS_OVERLAY_MOUNT_OPTION \
> +    INITRAMFS_OVERLAY_RECOVERY_SCRIPT"
>  
>  DEBIAN_DEPENDS = "initramfs-tools, awk, coreutils, util-linux"
>  
> @@ -48,4 +52,6 @@ do_install() {
>          "${D}/usr/share/initramfs-tools/hooks/overlay"
>      install -m 0755 "${WORKDIR}/overlay.script" \
>          "${D}/usr/share/initramfs-tools/scripts/local-bottom/overlay"
> +    install -m 0755 "${WORKDIR}/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}" \
> +        "${D}/usr/share/initramfs-tools/scripts"
>  }

Jan

-- 
Siemens AG, Technology
Linux Expert Center


