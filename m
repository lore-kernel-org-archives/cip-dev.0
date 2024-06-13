Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00516C27C4F
	for <webhook@archiver.kernel.org>; Thu, 13 Jun 2024 10:14:51 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.43])
 by mx.groups.io with SMTP id smtpd.web10.4787.1718273681111492250
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Jun 2024 03:14:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=rYzH1Rpm;
 spf=pass (domain: siemens.com, ip: 40.107.22.43, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSruRG/atfMXnxDOormj1ylDVB/suC43yrOIPUNgT4Z+cKlIZTAB2SRsKTmEOMHl0A5FLo1hB9LFWE0t6SS+nGYD1AQfeEZXlf4rIz3VjIZokZpRi4eZ4BfQ8NX2pUcbmL6i5oT809eGmjQRHdoTAotxFwkaikZdoboY/l+28umvk8niBG4mXEUd7S8fpRGJqrB/Wiq5Uc+yBt7QM8q1Bvp7dyLP9O/2QMA8b/Web78XW90tOdayKlvdvMRLsw8W2rL2bKO2nmfCDoufGn9dTaXiRTZ14VVi0FUqGW9oUJCnDtfzqqoBZNRya4o9Z4Y6tcVAHNwlY5LDcptXD+9cqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yptho1XT9jCfHVgV4zK3RBd3/ydcNglp9YRKwespEf8=;
 b=dB6HjkaEf+w2QhEInxcuXYw1LxePkARbsdsGkb0QhjY7g3vZ8itNIm4NHRwjdoiRVU7XRvRMgXrZxYanlhMIeA3KPcLDk7xOgcQasHk2B72nZgCaKiISJ17rv/mcLbq0koO3zJ6CyFWqnEJ84ufIarJ84VRpyQ/G6RRp/huMQ3v4i4USuN7fuM6UFQyc9plXb7w1AHuda1DyVftKUxQA8TrJ6lsom76Xwvc6Ed01DpQ/mU8QIPbsG/qmma0jVSUCtAV6HnxCDbRpsjwkNz2c6C2iwrVIYzfJPRmdULCUQgvMbshT69nnNiUnfztAXIFKDxZi+4WXs2CObqSFixCWsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yptho1XT9jCfHVgV4zK3RBd3/ydcNglp9YRKwespEf8=;
 b=rYzH1Rpm8CgqbHZOi/L5cSQFGNme3RplW61Rda7hFtQXqIxTdGCHS9LDQewz9ATGOJl5gRKbwZfv2T3wS24BVNe6uVgp20pOcRZGJlILVkZCBtxktROqa5O/BddFystwy4dvjO5FZTtO/jouN7gg5cp7FMRL8qbNFD6uggkcB5qqtoe3dNRg1HdRbPxDUW7sFyqQg/pmF3B19uy1PRcNR6Wu5YeCrEWIg19rs/SzpSK9ppqbWE+H/wQmE81TzE6WUKrPFAiVyDLfG7A4ayprdgMAFZajmfalJKo8KQQ+YbP0lEoOTvyJIzWm9n/Dcn8KMcwttg4VJeIN7JqAm8iZuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3566.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:131::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Thu, 13 Jun
 2024 10:14:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 10:14:37 +0000
Message-ID: <a2710749-1ad6-450f-b1fa-004d6f2e749b@siemens.com>
Date: Thu, 13 Jun 2024 12:14:35 +0200
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
X-ClientProxiedBy: FRYP281CA0009.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::19)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3566:EE_
X-MS-Office365-Filtering-Correlation-Id: 9928fe33-5065-4f76-f045-08dc8b91a145
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230034|376008|1800799018|366010;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MENpdkY4eVpMTDVSYnk0WmxvUFVvem5sL1IxSjZxcExRbkJBMDVoSkUvdXUw?=
 =?utf-8?B?UjBqUWRJQXkwRFdFaFF1T24zR2tvbW5ZaXlRSkxJNjJGY0lrNFBNdFZLWHMz?=
 =?utf-8?B?OGF2L2J0eTVKd09kbUxTYnBWVUlsTldKak9YY0hBSzlnTlVtMHJFSUNNbHpq?=
 =?utf-8?B?cTQyVHNEV0pIK1FBSEw5SytSSGFidm9veTZSTEN2KzExaE9JdWtOMFZxc1pV?=
 =?utf-8?B?RWwzVFBocVNISGthL0JyLzBBQU5KQWtaMWZsQjF0R3pFSUkyLzV5a3FLYnZx?=
 =?utf-8?B?aFhtSTY2cWtNSTR0YkhrdTRSK1h6ZzdIRHRWVjIzcnZFcHVYMmhoYjJpUHFu?=
 =?utf-8?B?blZscDlOYW51OHdXT0ZzYUpwdVo2WDgrdGdyQlNQNHVMS0tiMmxQSnp6dzc5?=
 =?utf-8?B?YjdGMmxWOUFJUHlyMHh4ZExnUVUxSjlMdXZpcGpXZzZqMUJjMGlCMWI3NGlZ?=
 =?utf-8?B?NGw0RVdVZDNDLzEvQWtpdWdYRW9FV3VUd3RVSHcrRzg5NUlFQnBMNlY3S25I?=
 =?utf-8?B?dFMvaU1Gd2tnaXZNM0dQd0QzMTZ0WjNyci85UWVyQTAxczNxazB3ckRGSFdR?=
 =?utf-8?B?TnFOTlFpOWpNOEszT1Q0VDFrZGFMaURZNjJpdWtNOTgvUmJJbVFZRWRIbDYw?=
 =?utf-8?B?MnErcjlPNSt5NjMyc1hpNDJsdU1DeTdMWDJ2MTVKMnBkaktLYzNnTjFUM2tO?=
 =?utf-8?B?UEN2emc4QTZOUExGRmw1eXBiQytkUmhIdTIxMnNud3ZxdWZXaEpnczZQdENz?=
 =?utf-8?B?aEtEU2d3R3BOS0lLYU1abjNNbGl5TEVaL2NxVlMwT1B2M0lqK0lBMDhCRk9m?=
 =?utf-8?B?aXl5VEkyckJxME1ZNTdWeStvQ0JMVXprc0VraU04Mi8wcER2QTUwc2YwK1Np?=
 =?utf-8?B?TkZtdXltQVFWQWZkVUVTbDBxNmgxNnBvbDY5NTNoWFF3QmxhTm54KzFKZEpV?=
 =?utf-8?B?SHM2UXhCeXJZa3hBeWN2bmZ3VTVqT3NrSnRPSGxhd0crQTV6amxpSDAzc2pZ?=
 =?utf-8?B?Mk5jL3B0T2t3M0JoT1NkZWpkNUp6MDNBY283c0k3RzVLU3JtOXRJbk1pdGkx?=
 =?utf-8?B?TnpxRkMxdEh0S2h2TFFtdUV2emF2YllhSnNTa1hPMTg0Q2Z0MHk5T21iZEo3?=
 =?utf-8?B?YUZ6U0Q5SXdXUjc3VUlYM05lVCt3b1p0QUZ1ZjM2bHpwZTkrYVZpcDgrZ2da?=
 =?utf-8?B?K2FLZ25PZWFqUmJReVJaVXl0TmEyU3NPSlh5MldUU1IxNTZsc1NNOWVDc3Jk?=
 =?utf-8?B?TWlNbVdmVCt0S3NmQ3BmY0luc3djeW9GS2hXaERud0llTGpmOHNtZFE4dHhL?=
 =?utf-8?B?Vm1xQUV0ZU8rL3dyQy9icVNlTGF4cXltQVVYeGcrZjkrcnpVb09NS2pXODJD?=
 =?utf-8?B?aEJFc0IvUTk4bXpDL0M0dHY2ZWFwMm9OeU1ZUDZoT2hWRC9QK2FFcnFZUnVq?=
 =?utf-8?B?a1NrZGt1TitoQTVjanVXVVVMTHBqdjB6ZDFrZjFkTlBmbGdnYzlNZDhncExm?=
 =?utf-8?B?VEcybmNOellGczFDaGNQNlJYME81T1hjQ2tkRk5RMmF5UUxDOVhmUktCNm84?=
 =?utf-8?B?VEYxVmZCRGFhZUpmV2QwblBJSXJaMmhPd0h5Myt3d2JJRVM1R1hDOURLNzhY?=
 =?utf-8?B?azdtcXRtU1ZjcHFzRDVmZm51SEd6Ymp0bWhtekhubkhJRE4rS0grcTZMQlpO?=
 =?utf-8?Q?2fcyghB5iDLciaUMPxfB?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NGlLbVhsTmpFbEk0OXFxYmJWb3h5STFzaFR6UWhLSEZoWHBxeFRKdU5TbGtI?=
 =?utf-8?B?RnowRkhyMmhWVW5nQlVmcmhNZEplQnQ4aXdzVlVhZ0NYNWZrMUtzaWk5Z0pT?=
 =?utf-8?B?dzRPeERyUThBR2FzbEJvbExNZHFkZXl2eDN4SlR4UlNhYnZsN3dGU1AwSm1X?=
 =?utf-8?B?Nk5COGlnVGZKRDZqZnVOcHo0VnRQSGhCdm9leUgrZmNJdS8yY3BBajFadE9k?=
 =?utf-8?B?QUFDSktxTDBUVjRTQmdKUzQ2OWJrQzRGTjFOYTRqWUJHQzBxZE9Lam9FUms4?=
 =?utf-8?B?MWJZUkNmUUxtZkJCNzJxQmNyWVhtTS9TVDdBaldlZDNnUWZZRUJuNXRKZUpM?=
 =?utf-8?B?b2czR2g3djk3enlrcmFmclZCMjN1YkI2QjdUZ0FvY1VnRUpvV1Q3amgwZ3hD?=
 =?utf-8?B?V29pWmVnYVM2NTVkNUkrUjZEUWdSYlJoaVp0QkQrM1VVd1F6WkliWThHTzV3?=
 =?utf-8?B?SXJxUmRvNjY4a0JMQlpxNjJBQk9pSlI1Qk5kbFA0Nml3b1BJNjk0WklSVnhq?=
 =?utf-8?B?ZUFoVDMyTWhYU0UycHp0UjRaM3U1UFJOZW5KUFRZbGRKRkZCcEltRzVrNFdv?=
 =?utf-8?B?NlZoQzhQNXdaOE5UbjdlMXVtWTVJQ0QyNVdVa3pvcGd0ZktsREhscGRWaUtD?=
 =?utf-8?B?K0JlWldUcFFlYWUrSEpXZkdvSUpmTWhiaUh5a2g2T1BJMUJXdTJSbmFTU29S?=
 =?utf-8?B?dE9NdlpnS0hERGdoNkhxbEdvbjlhOUlLY2RUVWdDZGV5bmZnazJnSDlGUWtn?=
 =?utf-8?B?cm82eXh0U0NwaXdEd3lvTE03VXFrVml0OEkwMEFLZTBldy9mcFB4c2w4N3pp?=
 =?utf-8?B?eWVPbDJjaml1S3hrUWJuN2dWNG12b3ZSMllRU2lHclNmMnp2ZVVnKzRqejhw?=
 =?utf-8?B?QkRzd2FVd0ZPRW1WOVpOSmdJM2tIbEIxblA4aWtNajMvWUpqQjBwRm16MUVR?=
 =?utf-8?B?a21US0ttSzUvQ3lpMmV6amxQQytqdnRwSEFkdjMxUklZeGoxMlJmYnBHdW1N?=
 =?utf-8?B?TDVQRFlSNG44WXd4RWMrcUdmSzAzWld3U0U2VzBJcGNTNTBQRkkwaklXMGYz?=
 =?utf-8?B?Q2FDcWtUcUNVZVFFZnlwSFZKbzM2MU40WUlVUVZiWS9LVWlQTVpobFgyYUlB?=
 =?utf-8?B?UHRFM0ZPc1NFc21HemgyN09SbncwNzVPeWFOZFZuZVpxYmY0dDNQMWZBY2dK?=
 =?utf-8?B?dGoxZU1UNndEMUdNT2ZsZ24rcXY1ejB3NUp4SVJUZGsvMXNUbmlCTE1hc0hp?=
 =?utf-8?B?Qk9pSVR4VjJFcjVmT29LZ25OZy9tQlVqcDdCenhEK1Y2cjRpM3Z1N3UreU5o?=
 =?utf-8?B?QXNIOGdTc2FCaVl0L28vdWRNY0ExSG9ob0ZOR0tFWThBRElSbXMxbmlKSi9l?=
 =?utf-8?B?LzRQTG8xc3dPTjg5T1JuWE5XMmdvTk8rNy9kNDJKVXN5ZUM1eTNzdTZORDRN?=
 =?utf-8?B?Y1JpKzJXR3V4QmdDK0p3alR2QnF2WFVIQzJsZkdKOGx2TlZZWXBmbmlHeWVW?=
 =?utf-8?B?aG1UTlp0cFUycHJza1dvQUFsRFh2TU4xdkRCdzZzMFVEeWFvNVV0NGw0S0Jq?=
 =?utf-8?B?UUhxQmcwTkhJelBwaDNpQmF2OWJ5TS9jKzFha1hGcGRmbUhlRnpxY29QTlNI?=
 =?utf-8?B?UVhKMkZibjd1a2FIZVBpSnZjRjJVL25aREpsa0VDYXdJNFdxM01rNEI1ZlR5?=
 =?utf-8?B?NmFMenhkRnY4OG9RbVBDRDZ3NWNNbndxSkRheFEzVzF2K0FEb1Y5d3I4dkJF?=
 =?utf-8?B?UGszOVgyeTdpaGNDK3RxY3VaU2Z3NmxmTVp2QUtJUDBJYk1KaDJQaXQzLzF4?=
 =?utf-8?B?SzBvQjFLalRuUU9NZDZvS3hUakJuamU0ejU3NVFxaWpyK24rK2ZZRWt0SHBO?=
 =?utf-8?B?Wjc3K3lJTS90NmJKZ0I3aEFBVEV6Sjh5ZnFLLzVOTzFINlEyVGhITG02SGZ1?=
 =?utf-8?B?K0J6NExQWEFBamJMT2hjUExNTVhOVUkxczVVbmhmOFFxakJwdlpEbzVERXRV?=
 =?utf-8?B?YU9KbUVtUW1uN3MzOW1vSjRwK0dDS3lBbFNQa0RpTldOTzJxNzFhS09UaGpS?=
 =?utf-8?B?LzFZVkpTd1hwcjRJb2g3dHZDdEVBT01JYU1rd1NUSk8zZmRmcm0xTzNJZGN4?=
 =?utf-8?Q?rcO48H9DIcqW7AalfTGHwgA7f?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9928fe33-5065-4f76-f045-08dc8b91a145
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 10:14:37.3160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Q9g/A/VNrefo6EKMwuRlGecmHvLtLcCwzx2I+qBcxXKXLjKWuURXvwT/v3/SY/vEnMagl54Cew0vqzMU958xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3566
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Jun 2024 10:14:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16201

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&month=6&day=13&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/06/cip.2024-06-06-13.03.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed May  8 10:31:09 AM UTC 2024
  limit date: Fri Jun  7 10:31:09 AM UTC 2024
  Status: *Late*
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Mon May 13 07:50:32 AM UTC 2024
  limit date: Fri Jul 12 07:50:32 AM UTC 2024
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Thu Jun  6 12:19:51 PM UTC 2024
  limit date: Sat Jul  6 12:19:51 PM UTC 2024
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Thu May 23 09:06:28 AM UTC 2024
  limit date: Mon Jul 22 09:06:28 AM UTC 2024
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Wed Jun  5 08:14:01 PM UTC 2024
  limit date: Fri Jul  5 08:14:01 PM UTC 2024
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Thu Jun  6 09:43:37 AM UTC 2024
  limit date: Mon Aug  5 09:43:37 AM UTC 2024
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Tue Jun  4 01:28:02 PM UTC 2024
  limit date: Wed Jun 19 01:28:02 PM UTC 2024
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Tue Jun  4 09:25:36 PM UTC 2024
  limit date: Thu Jul  4 09:25:36 PM UTC 2024
  Status: On track

