Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.21])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10637.1795078654269319012
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Nov 2026 00:57:35 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=TuMm/dRh;
 spf=pass (domain: siemens.com, ip: 52.101.66.21, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNf3LjWuxnpJ7Z6Bt8By6qgMVwAPgb6d+iyWGi+OjPrfNAYiy9ETNeGYpzdQJePAIQ4hQ1OHlS5q9teiDpmmy34OhDO26lYcR+BYgt6dqcsgkjtDb1/flSm8LXacNAnTBy/2HdKBmH0Zz69iPa1oPzUUwoC2XJH/n+FkpZSGQ/1b25xKc6C0Eu78Tn8/kchgHatJIKobnUHzvUS7PfWIFst4IRo5yUPmPSpkkdcmGw9Qsv5PuK8jVdgaDLczb8TmNvZi6ms2ChPQakCk2XNKw+68Z23lkMbtGjcOLVxIj6Qs62vlFjtcr2Y0O2cPgrJ8AMay6dYQhSLrBF3dEIsAFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ivi3qqgotwCC9VbjwQV3942chkJjwNpRGhlOEkcFKg0=;
 b=C0njQ/xbkuU9tTC2mb8TdQTJM25SzOYcF4sdt0kaicwoHpQuE6BzhS+vifuTx5aBM0M4E0PRn5A2IJUEeE8fvqudx82i/sABvcAzxWzcRkEGfhY9So93dXIahb2qJM+8xvZFR7Jcv7DpapOH20i6EyQZuW3SXZqjBh9CgfAvMxJlgQS+xcrlKlotmAGq8CQd8lrMmLKHVksWhzZ8qYUXDxvzhwjjwh3WUTS8bDMcIaAtHUd62KzmC9j+Geb9Rht3xpXpAHaMD6Tgmlne3T+qOog0L/Qt2kviWTTQUqlqwTzSadJR8YcN0EqyzHohVfqScEIpRnxNGj2jAdToC2FWiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ivi3qqgotwCC9VbjwQV3942chkJjwNpRGhlOEkcFKg0=;
 b=TuMm/dRhJ5fHGhOSsLDSrIA6oQwQN50gJ2vS6Dfiik6dp6bxNFbzhUX88PSOWhFMXS9Bxkxk6ylaEoYlG/EPdOkYovjlERxnUORmCXeGbLHYONveQtLaHuez48LuYQFKwYw4Fu1czBHxROKU1uqimCYfo+t7IotP0zrdOAg4x7Jt3WX/nvgD7pznUZydQj5o29I1do4zTKb0icVIrItAxbv8a0RGrFYWDsdaXifsCwv5lqdn6+HJO9LD/ybTdVyQAaJldlA5HvZeq4wAg0UCT7t3nLcoA4IfqXx0z1wniFXFzj4UbPz0m64XFzNzzAuVPV0+k948fzCdXwWlGm1CzA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by PA2PR10MB9175.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:416::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.8; Thu, 19 Nov
 2026 08:57:20 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0639.006; Thu, 19 Nov 2026
 08:57:16 +0000
Message-ID: <91cab507-b162-4e88-94e7-cc65b2a1ab00@siemens.com>
Date: Thu, 19 Nov 2026 09:57:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v3 00/19] Add a dracut based initramfs
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
CC: felix.moessbauer@siemens.com
References: <20261117112833.316234-1-quirin.gylstorff@siemens.com>
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
In-Reply-To: <20261117112833.316234-1-quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0426.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::9) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|PA2PR10MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: 130d5da4-f673-4614-dadf-08df461b1c2a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|6133799003|261009223027099003|261009221227099003|55112099003|3023799007|56012099006|11063799006|261102130727099003|5023799004|261026140227099003|261028144727099003|10067099003|261026121527099003|261021121427099003|261021123027099003|261022115727099003|261022075727099003|261102123227099003|261021135927099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: /ktyBYxAPFtnh6aZRj7ORzRFNWkXVElUODtAnHe28gw0v28lzOeZ+PLTv+hM8SWhQDlbX41JljVapSCVLrZBDVR8PVW3B/naxnA4soFrbPJ5YknAXtGzlFh65fQ6mrSUarMyA5UrtGE9HTxHX34fEOBknCdSLcliY5EooJ/BgP/wQCXI5uuDPyshKrT8S6ockeZGGYIXPSUl4YHTu/MYAr/TF2GfSHdW5zLSrbATH0fTyprOxmd7mxPFFrDobYs4xanUpGBAtEeHka3uG16CFMQVl6hiuycGfOxe+dPhogeMZxhHeqRxtmKmF1+Cl2E1UZAqNkXdyX0PD4IB58NMFLp7F8V3yN5AOHSvolVVdX0KHuCxwb8os5r6It3+mFgv+2gRDjvuyYnXF/C9HyD/q7s0MrPKn08u0FRaW9+eovX7j/uAYw38txSLmu4xeoeAwlo+hX8YPVoQYxSsWQavDGwY6d+mceTUE4aa8Czhf3yq3BGBB/4LNpav6xBtO4ydheb8nO2GjZrNojElcY1JxdHKLIWB8Y4ar/TH96+THB/U9p5fmR7Qu+8opgFJjYR4DkXN1mEmhlxIiBq+LfAEl21dsCpPzjdBnNw5QzfzkTpycRk6SrnihOD8xcUaqmUY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(6133799003)(261009223027099003)(261009221227099003)(55112099003)(3023799007)(56012099006)(11063799006)(261102130727099003)(5023799004)(261026140227099003)(261028144727099003)(10067099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022115727099003)(261022075727099003)(261102123227099003)(261021135927099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eR5ThGdyYYHju6Ba51x1+BG3C8M1dok/GnHdfrD5qLcoZFq5UyduVdr2KB2S?=
 =?us-ascii?Q?yYP6/MKQ+YCA24STXSGW8W/x6RuaVBosZxIPWf/YoX8Kl8oFwGma+j+2lo42?=
 =?us-ascii?Q?KqXyzNWgJIFBq30eWXfYHuDil2d2r6isTIa1KkecrJ9X1Vt0k344i3f9B0qh?=
 =?us-ascii?Q?iDwdJkWI47W68d0I0/phZ9Ly8k8SutgOAstfzm1m/ee43wSx68cCI8GOiahb?=
 =?us-ascii?Q?wadj5MUuRQQYThGjbmveMfKy3UofCrkYYNwaooyUc/kw1t1oLKrWbgGsRW2Z?=
 =?us-ascii?Q?hov1je1CH3yyYYKowWaXaDMra8UcoJgjOI3Ge+mO3TLACh5VAeC6Hm0GlLMT?=
 =?us-ascii?Q?PWfwUYbORZPQRq+jyqMq7ePHpNVzbE1lCPBfhffY9qwP5OozK8R1kwdY/FUL?=
 =?us-ascii?Q?8XrJFYtiaXvsE29ifdnVSW1bErj9qYtn27vgzrAi3aTIKIP7imTHNBF4kTHW?=
 =?us-ascii?Q?kTMgqyk/mcxHnVF/1ocWWVcbFVxA0+v3thV85i+eqpwpaL+IuYToUAqsYhBo?=
 =?us-ascii?Q?vas8hew66Xf3fSUkZYYlo1CM4D8oX/0JhcoRRPEeRCVKTThDTygOsL0YUzVt?=
 =?us-ascii?Q?m/TOR6XF87t/v3eMRjS2o+QRSnbNJjL4TUCZPIM1B+lmR+LJ546AJ8N8A4oZ?=
 =?us-ascii?Q?ym3P6s3zxDXvM3asO4KPUixQMws2/rIOQdczUtYrRM0s/oCdsDIeH7D3Sd1B?=
 =?us-ascii?Q?z2br5DJATKXvwi5kQX37tZgo6jIs+O3UvIgXV3b3F0Y4M+2n+9cZVk3PD7Ab?=
 =?us-ascii?Q?yZNe9Z8Zcwz/uwie664W6K92pu//qSfoKBQaAMkwq3akoCrRlNWRVW6v/Pr8?=
 =?us-ascii?Q?NstEYcFF0bJJ3zRbKAPQ7hiNTDhpkmoyqyLq+dtwZvBxezrnszAu0onCom3J?=
 =?us-ascii?Q?WL0Pxkuvp4V+LIHdKTnujf0IK29PtlVwxEF3BzE8gtK1GQaEqx6LleInWR6i?=
 =?us-ascii?Q?aLLc5w5WauP0hNDs5FvqwQa8MpENr80S2tR2EPSrU6DvxMl29Rz4/EKkqNvV?=
 =?us-ascii?Q?9e6tyQGxwDpQ13r9EpljZbirlD1510JebuF6kLbwdMW026u1BYUPzFd+VivJ?=
 =?us-ascii?Q?pZ+HCMAiJAnd2ihw27ibaxiQ3SpJAjuIGVYwk8XAKCuvD4jmXcy7bdqMaNPn?=
 =?us-ascii?Q?CjAoNzXlcdF0MO/zOsaDgaHCoMHVCK/tfzEFCzBq8CTpzbLcXF1xXYB/9Qq9?=
 =?us-ascii?Q?DSXJTHZyRS6CuhaQXj8Mlb7uFxjoxiWjZliM8b3i0SMEgITPabZcVHb3xK8J?=
 =?us-ascii?Q?MUW80xKH2zjeinTyy56xs9VTVjPo8zf8OOarRLkmMeB/NDjGVdqgVCAAG+3J?=
 =?us-ascii?Q?od45A9XgcKe0aTaplnPt4dy5Rj/PkVFCEbZKVXTgjgpeE5Z/8ce+eroJ2Lw5?=
 =?us-ascii?Q?rVZcF3zxFOawQ8d2eyn4trcAlPBF46bxBAdKBePiyPXk+WVyAK/1AXGfgiuQ?=
 =?us-ascii?Q?Q9B88kl/YsMMet00RTyf66w/uIizizBgCNx9865JVdCgTTlqERzyvuWkLZW4?=
 =?us-ascii?Q?HPqMQHWv8OzmL+cYsze/xFswYA7VH6HpZzpBUSGcPIgyMkioHRs1g/F4KzUF?=
 =?us-ascii?Q?JpLM9/RzGQVc7dGNqEjV0Yljm/EkdTc4sd3IPAQ47kTHh1BCyTZbPHjF+ap+?=
 =?us-ascii?Q?/SPJ42Be+aRE7tJcFs/MJ0UPIIa+t/JLvw4sY4AMaowH8bvVfQ/Ces0fubF+?=
 =?us-ascii?Q?fVrtD35MryW3DY+M7Q/ud9JqFFwToIyxyV92baz/bYQi8KcUQxhP873RxpmJ?=
 =?us-ascii?Q?9nsug8jQ7w=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 130d5da4-f673-4614-dadf-08df461b1c2a
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 08:57:16.1631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DXwArG06jUgTJC4D49sHlMAxxOlOdi8EphuCi5NjfQYl/79rleiR5qpU4qXPReYWoAGRgNm2/ekzFfxujTtVqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB9175
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 19 Nov 2026 08:57:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25009

On 17.11.26 12:28, Quirin Gylstorff wrote:
> This series adds a dracut based initramfs next to the existing
> initramfs-tools one. Debian forky switches the default initramfs
> generator from initramfs-tools to dracut; this lets CIP Core images
> move early and tests the dracut modules in advance. Trixie is the
> minimum release. It is selected with kas/opt/dracut.yml or in the kas
> menu and requires SWUpdate with the efibootguard-boot wic plugin.
>=20
> The initramfs is built from the embedded-dracut-modules package
> (embedded-verity, -overlay, -crypt, -factory-reset, -watchdog), which
> replaces the corresponding initramfs-tools hooks. One
> dracut-config-cip-<module> package per module writes the existing
> BitBake configuration to /etc/dracut-embedded/.
>=20
> Supported with dracut: dm-verity root (with or without secure boot),
> overlay, factory reset (systemd FactoryReset EFI variable), encryption
> of data partitions (/var, /home), separate home. Not supported:
> encryption of the rootfs partitions; the Kconfig hides both options
> with dracut and the documentation explains why.
>=20
> Note: the embedded-dracut-modules source is still fetched from
> gitlab.com/cip-playground/embedded-dracut-modules (branch rfc). The
> final location is pending a decision by the CIP TSC; the recipe will
> be updated once it is decided.
>=20
> Changes since v2:
> - Split the read-only rootfs type: RO_ROOTFS_TYPE is now only the
>   filesystem (squashfs, erofs); the new ROOTFS_CONTAINER_TYPE ("" or
>   "verity") describes the container around it, as suggested by Jan.
>   dm-verity is stacked on top of rootfs.${RO_ROOTFS_TYPE} and only
>   changes the file suffix. ROOTFS_IMAGE_TYPE is derived from both and
>   used by the wks files and the swu. VERITY_IMAGE_TYPE is removed.
> - efibootguard-boot: derive the root mode (abrootfs or verity) from
>   ROOTFS_CONTAINER_TYPE instead of the abrootfs_root/verity_root
>   sourceparams, which are only a fallback for out-of-tree wks files.
>   dm-verity can now be used without secure boot (kas/opt/verity.yml).
> - efibootguard-boot: look up the verity and uuid env files by
>   IMAGE_FULLNAME instead of globbing IMAGE_BASENAME*.
> - read-only-rootfs: fail early on invalid RO_ROOTFS_TYPE/
>   ROOTFS_CONTAINER_TYPE, warn for verity without secure boot.
> - read-only-rootfs: do not mount LABEL=3Dvar from fstab; do not install
>   home.mount with dracut and encryption.
> - New: INITRD_EMERGENCY_CMDLINE; the dracut initramfs reboots instead
>   of dropping into an emergency shell (rd.shell=3D0 rd.emergency=3Dreboot=
).
>   An empty value emits no arguments.
> - New: WDOG_TIMEOUT configures the systemd runtime watchdog; 0 disables
>   it as well.
> - dracut-config-cip-*: fixed files/embedded-<module>.conf.tmpl rendered
>   by Isar and installed unchanged; The crypttab is installed from the
>   postinst and an edited one is not overwritten on upgrade.
> - Kconfig: dracut depends on SWUpdate; the verity and rootfs
>   encryption options are not offered with it.
> - qemu-amd64: force-load lpc_ich in the initrd (DRACUT_FORCE_DRIVERS,
>   Isar updated for it). iTCO_wdt binds to a platform device that
>   lpc_ich creates, so it is not pulled in by itself. udev loads
>   lpc_ich too late for systemd to service the watchdog during the
>   initrd phase. Forcing lpc_ich loads the whole chain early.
> - Commit message cleanups.
> - Added documentation and a CI build.
>=20
> Tested on qemu-amd64 and qemu-arm64 (trixie, 6.12, erofs, secure boot,
> SWUpdate, separate home, factory reset, encrypted data partitions).
>=20
> Quirin Gylstorff (19):
>   Update Isar for DRACUT_FORCE_DRIVERS
>   Fix expand-on-first-boot with separate home
>   Add ROOTFS_CONTAINER_TYPE to wrap the read-only rootfs
>   efibootguard-boot: derive root mode from ROOTFS_CONTAINER_TYPE
>   efibootguard-boot: look up verity and uuid env by image name
>   read-only-rootfs: check ROOTFS_CONTAINER_TYPE and secure boot settings
>   read-only-rootfs: do not mount LABEL=3Dvar from fstab
>   customizations: make systemd watchdog timeout configurable
>   embedded-dracut-modules: add recipe
>   dracut-config-cip-*: add build configuration packages
>   factory-reset-helper-efi: use systemd FactoryReset variable with
>     dracut
>   efibootguard-boot: emit systemd verity cmdline for dracut
>   efibootguard-boot: disable the dracut emergency shell
>   cip-core-initramfs-dracut: add dracut initramfs
>   read-only-rootfs: do not install home.mount with dracut and encryption
>   qemu-amd64: load watchdog drivers early via force drivers
>   Add ci build for dracut
>   Kconfig: add option to generate initramfs with dracut
>   doc: document dracut initramfs
>=20
>  .gitlab-ci.yml                                |  10 ++
>  Kconfig                                       |  32 ++++++
>  classes-recipe/cip-crypt-root.bbclass         |  37 +++++++
>  classes-recipe/read-only-rootfs.bbclass       |  38 ++++++-
>  classes-recipe/swupdate.bbclass               |   4 +-
>  classes-recipe/verity.bbclass                 |   8 +-
>  conf/distro/cip-core-common.inc               |  27 +++++
>  conf/machine/qemu-amd64.conf                  |   5 +-
>  doc/README.dracut.md                          | 100 ++++++++++++++++++
>  doc/README.factory-reset.md                   |  46 ++++++++
>  doc/README.secureboot.md                      |  22 +++-
>  doc/README.swupdate.md                        |   2 +-
>  kas-cip.yml                                   |   2 +-
>  kas/opt/dracut.yml                            |  17 +++
>  kas/opt/ebg-secure-boot-snakeoil.yml          |   3 +-
>  kas/opt/encrypt-all.yml                       |   4 +-
>  kas/opt/separate-home-partition.yml           |   2 +-
>  kas/opt/verity.yml                            |  16 +++
>  recipes-core/customizations/common.inc        |   6 +-
>  .../customizations/files/99-watchdog.conf     |   6 --
>  .../files/99-watchdog.conf.tmpl               |   6 ++
>  recipes-core/images/swupdate-efibootguard.inc |   1 -
>  recipes-core/images/swupdate.inc              |   2 +-
>  .../cip-core-initramfs-dracut.bb              |  42 ++++++++
>  .../cip-core-initramfs/cip-core-initramfs.bb  |   5 +-
>  .../dracut-config-cip-crypt_0.1.bb            |  82 ++++++++++++++
>  .../files/embedded-crypt.conf.tmpl            |  10 ++
>  .../dracut-config-cip-crypt/files/postinst    |  16 +++
>  .../dracut-config-cip-factory-reset_0.1.bb    |  36 +++++++
>  .../files/embedded-factory-reset.conf.tmpl    |   4 +
>  .../dracut-config-cip-overlay_0.1.bb          |  40 +++++++
>  .../files/embedded-overlay.conf.tmpl          |   5 +
>  .../dracut-config-cip-verity_0.1.bb           |  30 ++++++
>  .../files/embedded-verity.conf.tmpl           |   3 +
>  .../dracut-config-cip-watchdog_0.1.bb         |  29 +++++
>  .../files/embedded-watchdog.conf.tmpl         |   2 +
>  .../embedded-dracut-modules_0.1.bb            |  23 ++++
>  .../factory-reset-helper-efi_0.1.bb           |   3 +
>  .../wic/plugins/source/efibootguard-boot.py   |  86 +++++++++++----
>  wic/bbb-efibootguard.wks.in                   |   2 +-
>  wic/beaglev-fire-efibootguard.wks.in          |   2 +-
>  wic/de0-nano-soc-efibootguard.wks.in          |   2 +-
>  wic/ebg-signed-sysparts.inc                   |   4 +-
>  wic/ebg-sysparts.inc                          |   4 +-
>  wic/hihope-rzg2m-efibootguard.wks.in          |   2 +-
>  wic/qemu-arm64-efibootguard-secureboot.wks.in |   2 +-
>  wic/qemu-arm64-efibootguard.wks.in            |   2 +-
>  wic/qemu-riscv64-efibootguard.wks.in          |   2 +-
>  wic/rzt2h-evk-efibootguard.wks.in             |   2 +-
>  ...i-am62px-sk-efibootguard-secureboot.wks.in |   2 +-
>  wic/ti-am62px-sk-efibootguard.wks.in          |   2 +-
>  wic/x86-uefi-efibootguard-secureboot.wks.in   |   2 +-
>  wic/x86-uefi-efibootguard.wks.in              |   2 +-
>  53 files changed, 776 insertions(+), 68 deletions(-)
>  create mode 100644 classes-recipe/cip-crypt-root.bbclass
>  create mode 100644 doc/README.dracut.md
>  create mode 100644 kas/opt/dracut.yml
>  create mode 100644 kas/opt/verity.yml
>  delete mode 100644 recipes-core/customizations/files/99-watchdog.conf
>  create mode 100644 recipes-core/customizations/files/99-watchdog.conf.tm=
pl
>  create mode 100644 recipes-initramfs/cip-core-initramfs-dracut/cip-core-=
initramfs-dracut.bb
>  create mode 100644 recipes-initramfs/dracut-config-cip-crypt/dracut-conf=
ig-cip-crypt_0.1.bb
>  create mode 100644 recipes-initramfs/dracut-config-cip-crypt/files/embed=
ded-crypt.conf.tmpl
>  create mode 100644 recipes-initramfs/dracut-config-cip-crypt/files/posti=
nst
>  create mode 100644 recipes-initramfs/dracut-config-cip-factory-reset/dra=
cut-config-cip-factory-reset_0.1.bb
>  create mode 100644 recipes-initramfs/dracut-config-cip-factory-reset/fil=
es/embedded-factory-reset.conf.tmpl
>  create mode 100644 recipes-initramfs/dracut-config-cip-overlay/dracut-co=
nfig-cip-overlay_0.1.bb
>  create mode 100644 recipes-initramfs/dracut-config-cip-overlay/files/emb=
edded-overlay.conf.tmpl
>  create mode 100644 recipes-initramfs/dracut-config-cip-verity/dracut-con=
fig-cip-verity_0.1.bb
>  create mode 100644 recipes-initramfs/dracut-config-cip-verity/files/embe=
dded-verity.conf.tmpl
>  create mode 100644 recipes-initramfs/dracut-config-cip-watchdog/dracut-c=
onfig-cip-watchdog_0.1.bb
>  create mode 100644 recipes-initramfs/dracut-config-cip-watchdog/files/em=
bedded-watchdog.conf.tmpl
>  create mode 100644 recipes-initramfs/embedded-dracut-modules/embedded-dr=
acut-modules_0.1.bb
>=20

This maintainer gets old and lazy...

With

657e0cc (HEAD -> dracut) doc: document dracut initramfs
05b3cd9 Kconfig: add option to generate initramfs with dracut
375dd74 Add ci build for dracut
4151301 qemu-amd64: load watchdog drivers early via force drivers
531db30 read-only-rootfs: do not install home.mount with dracut and encrypt=
ion
7d5b68e cip-core-initramfs-dracut: add dracut initramfs
2abbd88 efibootguard-boot: disable the dracut emergency shell
4ef2495 efibootguard-boot: emit systemd verity cmdline for dracut
267295b factory-reset-helper-efi: use systemd FactoryReset variable with dr=
acut
3141ee6 dracut-config-cip-*: add build configuration packages
6a9eb82 embedded-dracut-modules: add recipe
3ec6ae2 customizations: make systemd watchdog timeout configurable
18b3ee0 read-only-rootfs: do not mount LABEL=3Dvar from fstab
7546389 read-only-rootfs: check ROOTFS_CONTAINER_TYPE and secure boot setti=
ngs
5e38eaf efibootguard-boot: look up verity and uuid env by image name
5ce19fd efibootguard-boot: derive root mode from ROOTFS_CONTAINER_TYPE
3e90baf Add ROOTFS_CONTAINER_TYPE to wrap the read-only rootfs
97e40de Fix expand-on-first-boot with separate home
621fa8a Update Isar for DRACUT_FORCE_DRIVERS

I retrieved this from claude:

"I reviewed all 19 commits in origin/next..dracut (621fa8a =E2=80=A6 657e0c=
c),=20
plus the pinned upstream embedded-dracut-modules (7dd1089) and Isar=20
(17565d93). I didn't run a BitBake build. I confirmed the Python syntax=20
error (finding 1) by parsing the plugin with Python 3.11. The other=20
findings come from reading the code.

High: regressions against origin/next

1. The wic plugin fails to load on bookworm, bullseye and buster (5e38eaf)
 - Where: scripts/lib/wic/plugins/source/efibootguard-boot.py:201 and=20
   :241.
 - Problem: f'{get_bitbake_var('IMAGE_FULLNAME')}.verity.env' reuses the=20
   outer quote inside an f-string. That is only valid from Python 3.12.
 - Why it matters: wic runs in the imager schroot with the target=20
   distro's Python (bookworm has 3.11). It loads every source plugin=20
   from every layer, so all wic images on bookworm and older fail. This=20
   hits CI jobs such as qemu-amd64-bookworm, hihope-rzg2m-bullseye and=20
   iwg20m-buster, even ones that don't use EBG.
 - Confirmed: python:3.11 reports SyntaxError: f-string: unmatched '('.
 - Fix: use a local variable or "...%s..." % ....

2. WDOG_TIMEOUT =3D "0" now turns off systemd's runtime watchdog (3ec6ae2)
 - Where: recipes-core/customizations/files/99-watchdog.conf.tmpl.
 - Problem: On bbb, de0-nano-soc and beaglev-fire, WDOG_TIMEOUT =3D "0"=20
   means "EBG must not set the watchdog, U-Boot or the kernel already=20
   does". It does not mean "no watchdog".
 - bbb-efibootguard.wks.in sets omap_wdt.early_enable=3D1=20
   omap_wdt.nowayout=3D1 watchdog.handle_boot_enabled=3D0.
 - de0-nano-soc's U-Boot starts the watchdog (aa585c8, just merged on=20
   next) and the kernel uses dw_wdt.nowayout=3D1=20
   watchdog.handle_boot_enabled=3D0.
 - With RuntimeWatchdogSec=3D0s nothing services the watchdog, so these=20
   SWUpdate images reset after about 60 s, over and over.
 - Also: ti-am62px-sk, qemu-arm/arm64/riscv64 and every non-SWUpdate=20
   image on those machines lose the runtime watchdog. The Kconfig=20
   WDOG_TIMEOUT help text still says it only controls EBG.
 - Fix: use a separate variable, e.g. SYSTEMD_WATCHDOG_TIMEOUT, that=20
   falls back to 60 when WDOG_TIMEOUT is 0.

3. Secure boot no longer turns on dm-verity (3e90baf, 5ce19fd)
 - Problem: INITRAMFS_INSTALL:append:secureboot =3D " initramfs-verity-
   hook" and verity_root=3Dy in ebg-signed-sysparts.inc were removed.=20
   Verity now only comes from ROOTFS_CONTAINER_TYPE ?=3D "verity" in=20
   kas/opt/ebg-secure-boot-snakeoil.yml.
 - Why it matters: The commit message says "Secure boot sets=20
   ROOTFS_CONTAINER_TYPE to verity by default", but that is only true=20
   for that kas file. Downstream secure-boot configs that follow the old=20
   README (SWU_ROOTFS_TYPE =3D "verity" plus the :secureboot override) now=
=20
   get an abrootfs command line. Depending on their initramfs, the image=20
   either fails to boot or boots a signed kernel image (UKI) with an=20
   unverified rootfs. There is no warning.
 - Fix: add ROOTFS_CONTAINER_TYPE:secureboot ?=3D "verity" in the distro=20
   config. Also fail (or at least warn) on secureboot without verity, on=20
   a leftover VERITY_IMAGE_TYPE, and on SWU_ROOTFS_TYPE =3D=3D "verity"=20
   without the container.

Medium: bugs in the new code

 4. DRACUT_FORCE_DRIVERS does nothing (4151301, 621fa8a). Isar only=20
    reads it in recipes that inherit dracut-module.bbclass. No recipe=20
    here does: embedded-dracut-modules uses the upstream debian/=20
    packaging. So lpc_ich is never forced in, and iTCO_wdt isn't listed=20
    either (Isar's own example lists both). This removes the reason for=20
    the Isar bump. That bump also pulls in about 40 unrelated Isar=20
    commits (rootfs sstate, deploy-image LUKS re-encryption, package=20
    removal fix=E2=80=A6) without listing them in the commit message.
 5. dracut builds fail on ti-am62px-sk (3141ee6). INITRAMFS_WATCHDOG_SEC=20
    ??=3D "${WDOG_TIMEOUT}" evaluates to 0 there. The ftpm-stmm override=20
    still sets INITRAMFS_WATCHDOG_DEVICE=3D/dev/watchdog. The embedded-
    watchdog module requires [1-9][0-9]*, so dracut fails. Kconfig=20
    allows IMAGE_DRACUT on this board.
 6. Factory reset with dracut silently never fires.
    - The dracut module only reacts to systemd's FactoryReset EFI=20
      variable.
    - The default helper is still factory-reset-helper-file (only ftpm-
      stmm switches to the EFI one).
    - Kconfig FACTORY_RESET doesn't require HAS_EFIVARS for dracut.
    - README.factory-reset.md:42 says "a build with factory-reset-
      helper-file fails", and the Forky section (line 73) promises a=20
      build warning. Neither is implemented here or upstream.
    - The new CI job build:qemu-arm64-dracut (.gitlab-ci.yml:274) builds=20
      exactly this combination: qemu-arm64 without EFI vars, with=20
      encryption and factory reset.
    - Fix: PREFERRED_PROVIDER_factory-reset-helper:dracut =3D "factory-
      reset-helper-efi", plus a Kconfig dependency or a parse-time=20
      check.
 7. The out-of-tree fallback from 5ce19fd is broken by 5e38eaf.=20
    IMAGE_FULLNAME is only passed to wic (via WICVARS) from read-only-
    rootfs.bbclass. Images that rely on verity_root=3Dy/abrootfs_root=3Dy=20
    don't inherit that class, so the lookup becomes None.verity.env,=20
    with a misleading hint about ROOTFS_CONTAINER_TYPE. Either export=20
    IMAGE_FULLNAME more widely or fall back to IMAGE_BASENAME.
 8. Root-on-dracut behaves differently on verity corruption.
    - The dracut path hard-codes panic-on-corruption and ignores=20
      VERITY_BEHAVIOR_ON_CORRUPTION. The initramfs-tools hook defaults=20
      that to --restart-on-corruption.
    - The non-secure-boot .wks files, now usable with verity via
      kas/opt/verity.yml or dracut, have no panic=3D5. Boards without a=20
      watchdog (e.g. qemu-arm64) hang instead of rolling back.
 9. dracut equivalents are missing, with no guard or documentation.=20
    Nothing replaces initramfs-sbcerts-hook (automatic secure-boot key=20
    enrollment) or initramfs-tee-ftpm-hook (fTPM for ftpm-stmm). The CI=20
    job uses security.yml, so key enrollment is silently lost.=20
    IMAGE_DRACUT should exclude FTPM_STMM, and README.dracut.md should=20
    list both gaps.
10. Dropping LABEL=3Dvar from fstab affects every initramfs (18b3ee0). The=
=20
    initramfs-tools overlay hook only mounts the first path part of=20
    INITRAMFS_OVERLAY_STORAGE_PATH. Setups with a custom storage path or=20
    a custom INITRAMFS_RECIPE lose /var. Consider dropping the line only=20
    for dracut.
11. Watchdog side effect of moving WDOG_TIMEOUT ?=3D "60" into the distro=20
    config (3ec6ae2). Machines that don't set it (hihope-rzg2m, rzt2h-
    evk, iwg20m, x86-uefi built without the kas menu) now get=20
    INITRAMFS_WATCHDOG_DEVICE=3D/dev/watchdog. That also changes the=20
    initramfs-tools crypt and factory-reset hooks. The commit message=20
    doesn't mention this.

Low: inconsistencies

12. Kconfig commit message contradicts the code (05b3cd9). It says=20
    rootfs encryption is "not offered with dracut". But the help text=20
    says encrypt-all.yml is supported, IMAGE_FULL_ENCRYPTION has no=20
    !IMAGE_DRACUT, the layer implements CRYPT_ROOT_PARTITIONS and=20
    DRACUT_VERITY_REQUIRE_CRYPT, and the upstream udev rule matches=20
    CRYPT-* mappings.
13. Wrong statement in README.dracut.md:94. Setting=20
    ROOTFS_CONTAINER_TYPE =3D "" does not fail the build:=20
    ROOTFS_CONTAINER_TYPE:dracut ?=3D "verity" overrides it, so the=20
    setting is silently ignored.
14. Timeouts are inconsistent. The dracut crypt timeout=20
    (CRYPT_SETUP_TIMEOUT ??=3D "600" in cip-crypt-root.bbclass) ignores=20
    INITRAMFS_SETUP_TIMEOUT. The initramfs-tools hook and
    dracut-config-cip-factory-reset both honour it.
15. Legacy variable not handled. INITRAMFS_OVERLAY_MOUNT_OPTION isn't=20
    migrated in dracut-config-cip-overlay, but the docs say the=20
    configuration variables are unchanged.
16. The dracut override only works when INITRAMFS_RECIPE is set=20
    globally. If an image recipe sets it, factory-reset-helper-efi keeps=20
    the CIP vendor variable. The docs should say it must be global.=20
    Three places also compare the INITRAMFS_RECIPE string instead of=20
    using the dracut override.
17. cip-core-initramfs-dracut.bb cleanups.
    - The comment on line 16 about module-name extraction is misleading:=20
      extraction is off by default.
    - --reproducible is already part of Isar's command line.
18. Upstream source not ready to merge. embedded-dracut-modules fetches=20
    branch=3Drfc from cip-playground. It should point to a released tag in=
=20
    an official repository first.
19. Kas and Kconfig layout.
    - kas/opt/dracut.yml doesn't include ebg-swu.yml even though dracut=20
      needs SWUpdate.
    - IMAGE_DRACUT sits in the menu before, and outside of, the=20
      IMAGE_SWUPDATE block.
20. Default variables defined in the wrong place, or twice.
    - ROOTFS_IMAGE_TYPE and the rootfs-container-* override exist only=20
      in cip-core-common.inc, but classes and .wks files use them.
      Distros that don't include that file break.
    - DRACUT_VERITY_DEVICE_LINK has its default set in two places.
21. Minor commit-message and template issues.
    - 3141ee6 says "values are not checked", yet it checks UUID case and=20
      the timeout format.
    - IMAGE_TEMPLATE_VARS:swu gains variables that no template uses.
22. CI coverage is thin. It only builds qemu-arm64 and runs nothing. The=20
    runtime fixes in this series (the home.mount fix, the qemu-amd64=20
    watchdog) target qemu-amd64. A qemu-amd64 dracut job with a test=20
    stage would catch items 4=E2=80=936 and 8.

Suggested order: fix 1=E2=80=933 before merging, since they break next for=
=20
existing users. Then 4=E2=80=936, since they make the new dracut features f=
ail=20
at build time or never work."


Due to the length of the report I only checked the 3 critical ones, and=20
they seem valid. So, take the rest with care and feel free to reject=20
them if they overshot.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center
