Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350CDC021BE
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 09:17:08 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.54])
 by mx.groups.io with SMTP id smtpd.web10.7013.1740647823751130466
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 01:17:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Gvtp3yVt;
 spf=pass (domain: siemens.com, ip: 40.107.104.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9vptN1S94opCs4NNntsd0b4wRpCxnw4YrzkMfcW6s4CD6K3bpGTN9Z85dkACs2lgshut3PRYEm9nfaOsTOSS6qzlcaJijO/NZm4cI0Adfo3MFNzgbQrbhnFGm4L3QffH2Wu3+SqNw5+ywKWFzyp0m5dXsc3JMcjjFmZxyessXbTpaI31IvwJAYaePXze6nxBN1fMKbVDmMwF0RgLjgVJ+nAaL71Etw2hisaUO7HefiFt2sp/NpFO3ctKg5mfBfWe7qiEls1STmBesl2IRCZ5wdioVAi46aCQQK9YbneFn0ucnexXa2DqWGYRTCCn729eqQ7cddBO85dMKn9e/zy8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOfR4Tv6LG7eiy0/BOY+1r/ULgVS31Eh929fIIsYzfQ=;
 b=kXea6j2dhsqSqx1O0zgYoUjdrsUtWnDbvB1rjJbawOM3I/Mj5Qs+dkKx8KoF0A4gLUkuf2btCYOX9upGnobtjI04OsAynDIYi9Ri5FxqRAztfHl6F/HkyzB9Oebi7BvcfAcGcM+i/pB5c7vM3pIVNoZWmvCy6nwdQ8jeoFgXB+t+ZIXAfoYlPFY4po/xrCKtTlPj6wR3a1xzwnkrgtBxRv1GkSrCsF3vVA9P9l6ZdDG4l10nnkHR94Fp7narVq5QLQQGxjjbdI20lG5Cx0xRIeYWA7iJHSbNzGE8lI8UgehvYTGPjJRPRG9X51D6Z/AFNzKn2TIxqOtap1LtbZ3xIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOfR4Tv6LG7eiy0/BOY+1r/ULgVS31Eh929fIIsYzfQ=;
 b=Gvtp3yVt0GV9PekcRuQuDF/EU2L6XcamBhTLK8P1re4W+f4vK6dI9M8ePVVAIY7NQS0dKWvGM9tbU9xNMesTx7Tm0QPBxsj9u1T5AcJ7NC+v7Qinhb0gg+pa2h7/LD0xLoIbl5ecTsz/LblkdUirrIba/0Q0OxgnyRHSPmKiOCY6eYd3KgIkGMDk1j/L88DFOz6/6FliwW6ANqxbBZSZywTXjRpK2rrcBwKUe4KvdeZ+TPcvdctLo+yHP149hC/HqRgmlaMrEJitO1bfeS/XcIzqcf41b1lL+x9w6Rndt/JmGOydT81qVDQsGYrhhM0iAsMCp0X8uxZAcBN5uedvhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM8PR10MB3988.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Thu, 27 Feb
 2025 09:17:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 09:17:01 +0000
Message-ID: <2977fbac-b0d9-44ce-8f23-a4fca025cdf6@siemens.com>
Date: Thu, 27 Feb 2025 10:17:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] initramfs-crypt-hook: implement 'noencrypt' option
To: Claudius Heine <ch@denx.de>, cip-dev@lists.cip-project.org
References: <20250226095921.168962-1-ch@denx.de>
 <20250226095921.168962-5-ch@denx.de>
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
In-Reply-To: <20250226095921.168962-5-ch@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM8PR10MB3988:EE_
X-MS-Office365-Filtering-Correlation-Id: 985564fb-d40f-411c-99be-08dd570f7e30
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?L09rVDd0c3ZIODU0NFdkTmVVYXhXQ3pKOEdXcW1zTmlkem9zTEFhd0pmTnFm?=
 =?utf-8?B?bTVQWENUMkdLYSs2U3oxM0hWN0JzRy9ETXFOTmlBNlZuQ1FHdnVuT0phaFdS?=
 =?utf-8?B?dHBkaDZDZHAzQ2k3anpkSmJSMG1CUWpWdUVGUk45R21KcWU2UEs1TWVMQ3g2?=
 =?utf-8?B?eVBBVzVHSGMvWTZKRFpRMTdqdGl6a3RPU09LYXk2Ums1T0tROTJpc3h5Mnor?=
 =?utf-8?B?RUEvQ21SUk9qQjdCMmFaVWtKY25xWjA3dk5MSVFmZEtKYkd4RXJ2QmFteWs4?=
 =?utf-8?B?N1EvNWVvaHdLYTZpUHlXWnc5ZGdBN2hkZC9BT0NjdUp3amRXUU0yZnRVTmhY?=
 =?utf-8?B?U09ibEEzRXhicjlMYnVCRmljbUxJK0NhS3lmSEJNdGxiMDdMMTIwcEhhMUFx?=
 =?utf-8?B?aVN6ZFpCVnBPRXRKTmYvMXdjN0VHR0ZjU2dKeUJYM1pERzlUUDViekRrNGY0?=
 =?utf-8?B?RHJuWVk2d2F2WVVsaEVPRk9tTkpOd25QREdJbXpYbExEZ0ZNYm9pS0JUMnFL?=
 =?utf-8?B?eFdwS1lHVVBhOUwzWXk4RWtxb0dCWTVCK0IvdHFJbUJWV3EvYkNiU29FWUNQ?=
 =?utf-8?B?SVpHaFFXUWp3RWhVUVhUQUxxeXRJQWgzTXd2OVVmRTd6eEZrZHdSWTRJWlhm?=
 =?utf-8?B?SGNKZERzaFpVT1JSMFZsbnY4Y3IrS2Q3Nzh5Tit1aGZsR0ppdjkwYmluNjFU?=
 =?utf-8?B?bjRZSDVuVmpvcFNHczBCblZ1eUhzNGtvM2tVeWk5dnplQ2VYaHNuL2V3aC9U?=
 =?utf-8?B?ODhna2ZtdzRHdndUdCtHOU5WNXJDdlZWSXU0dllSTnRnSEFxUnpobUdWZ1E0?=
 =?utf-8?B?bmFORmNPbGppcmc2ZkdhNnQwN1NwekFJSWovd1VTU0NvaXdNNi9QWmdLQmpC?=
 =?utf-8?B?bE80Ukt5d0F3ZFVobFhrMExFZWJ6b2xZYXkvZUR2MzdHZFdmTVZGdHd5OWJv?=
 =?utf-8?B?U3ZZSkE1VmpOSGFWN29aY1huN3pYS3cxMHVTTExFVklCR0gzZWZBSnBwYTNi?=
 =?utf-8?B?R0hRT3JKN1Y3bktwaFhreXBZMjk0aW4wRHh2VnRVNWNMZkU1VFVOOTRYM0F6?=
 =?utf-8?B?UFRRY2k2VlJBblBJRVJaTVhQZkt5YUpEckd2TnVLTDlzaWVtSENzajk3T0x3?=
 =?utf-8?B?eTJGdWFQN0hMNWtFU3drSWJBQ0t4NDJMcDlOLzJaZFl3NUVkVHJ6aUZVOXEw?=
 =?utf-8?B?N0Q5Z0NQUDAwNjhablZPbTFJWW5UZWZDV0RlOGFHQXpjT1JsUEswcThHWEF6?=
 =?utf-8?B?cFZlbi9XdjkwNXlLNEFRb0JSOGFFZmJWeUJjbmFUV1k0S1U3UGdyQk4wV1Zr?=
 =?utf-8?B?ZEFZNjRGVEVnRkdVenFXQzlsd1ZybStmMEJ0Q3luWXFEdjIwMndjNzMra01v?=
 =?utf-8?B?WXF2OWJtcG9VYTVxTFRNK1JyYjdQT2VvTDlORUR3NVlKNUV4NCthUjZiNFpl?=
 =?utf-8?B?VUJyRHFSSTNMWjVBOHIxMkNHSUwxOUh0V1pPQ0krMHhuRzdqRTROa243V09O?=
 =?utf-8?B?NlBmWXFmYjV3Sk8ycmwyZGxuZW1GTVFzSGtid3l4V1BRTG5sckZRU3p2Umw0?=
 =?utf-8?B?ZDUybkltZ3FqNXFLZHZ3ZDZyZHBuUTZreFRadUJWcWc2dmhsNm4xQU9ZbzVL?=
 =?utf-8?B?OElxeFpsRFhGR0lQNjFKaExVdGFJb1N6OG9RK0lLWjlDRUQ5ZXVZZm1FaXds?=
 =?utf-8?B?YzUra0htbzdIUVNlaTV3eXBtajV0VVd3QkFsWXBiVk9aTm9mcmwwODlVN3Rt?=
 =?utf-8?B?c0hoOWpHTGwxOG5nZituT3NvLy91STZUM2I0aUNJN0txRzdPOW1VcHpjYWdK?=
 =?utf-8?B?MDIxTythcFo1a3ZTYmhmb3M4Mjc4Z0VIcGlzUmo2RlNGVkhYdm4yOS93blEw?=
 =?utf-8?Q?UzzNK7fAyPhNw?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cUJONk8vaEkwREc0U1ZLMG1VY1dGWUpORUthMm1VZkEwWEUva2kwS2VPcnFY?=
 =?utf-8?B?dFMxQU4weGpDYVlTNy9TUS9QOW81VjdZMGRjQm5yNEEzSkwyNmNqb2VpcmlE?=
 =?utf-8?B?MUJkbUFiU0Vwd0J6UG44bitreGhPN1Raa1h0OEFHSUlDMDE5L0VyeE1SRzFZ?=
 =?utf-8?B?Vm5qdzVxdGwrcGh1amhlZXhlbmF6L1V6ckQ3a1pmb01idVYzbDJQVFhHVDJr?=
 =?utf-8?B?ejdsRGRDQy8weWRRanhRYk1zNU0zTTlRZVZUVEQyNnBiSjdOWmI5YXNDb2NT?=
 =?utf-8?B?Q0swdVJnNFkwR2cyVnVlazF1bDVkSGRtazN0QkExVXlDMmVTSU9tYTA3T2t2?=
 =?utf-8?B?Ui9BSDBISG0wR1RMbis2MEFsamNyNjdndmh5MGdiZkQ4WW5iOEovTUNjREhs?=
 =?utf-8?B?dWkrUlR5bkZjUGFuSDR6dHgxRVpLRVVjYUxwblg0cDgvdTlLcHZQdXltanpL?=
 =?utf-8?B?RjRsMkxLNWVGV3lCYTFLRlRwaVJxZU83TXdKUmlHbUVaV3dXRTB5WExHZ3I4?=
 =?utf-8?B?WjE4S3pMZHl3NUZTbUpqR3JLdGtyVml5cjROcTdFVmthSTk5cWdWT0dFZm55?=
 =?utf-8?B?ajUyN1lBYzhlbHI0K0d1bTliSVRFZ0dYT3BtVjcycUowbjBzR2lRbzdqV1FR?=
 =?utf-8?B?S0FTSWpaTk95all4TFhQYnk3NkR0b0RYMTVwU2JmbmlRYUgwU2o1Rm16Ympz?=
 =?utf-8?B?RG9RdHRjV1YxMytjTys2UFpzNUhEMlR1NEVaNm5KZjFKdmxlN215YkpEQjJs?=
 =?utf-8?B?NUZ3V2VObUgyMU5NOFJPMHZPK0VMOExMQUE5MVBXdVNtaHA4TUVVQ3ZZbGth?=
 =?utf-8?B?YzFrQTBIZ2NMTnFKS0c4TFAvWjhNTmlQaUxRSmxPaVFmV2c3SmxzUlF6TmZH?=
 =?utf-8?B?WmVadkNPeDA0UGhaN05iY2NhSUF4S3NRWUdXSm95dUV3QkhBanYwZXVVOSta?=
 =?utf-8?B?REVVWjF1c1F0NHY3YTdUTklIVVpPRVFJSDFHY2trSU5IQnVjaSt2NU9HYmRz?=
 =?utf-8?B?UUFuUEhTdElPOU9TcUd5WVVrZnhiS2tVa044VDBPMlk4WmxzS25DOFdlNWpX?=
 =?utf-8?B?bnhsYXhuZFlwcWZ5OW8vUHpCbHNXZDM2N2Foek9sNm5xbXpyWE0zL2pGWWRu?=
 =?utf-8?B?TkR2SjBuMW1KZkMycFV1OEpqb0h0d013a1dES2NkaVN6NEx1eU9UOXY5dEk3?=
 =?utf-8?B?OUg0U3AzSHpHQlBrOUdqc1ZUcHdncko2dlEyVFBnQkJCeTVaMWd3cW9VWUZL?=
 =?utf-8?B?ekVnTWdXTW04RkNPd0p1SFZqM1BQUTMycTFvSHFpOXZRbE1UaVA4Tzg2NGJJ?=
 =?utf-8?B?L0tlWC9wbTJ5OTdoOXpmb29Xem5WcUhkL3pocktBaEZQOHgwdTYvZG1YMU4r?=
 =?utf-8?B?YzU4ZjZtM3hkZW1Jdy94S01qdmFBdG0ySGQ4eW4vb0xtdThLQUdEdllWQ2xF?=
 =?utf-8?B?RjBTclZIMTQwMXRESGNXV3dkVVhFR0w2WDd6V1VtYU1rU1hMUVRWYmgwZ0ZS?=
 =?utf-8?B?Ym10dEUvQUJuMFFFM1RJdHhQZG5CNVpDWDc1VHZRN1R6TjN5QUpVMnBTbm0r?=
 =?utf-8?B?b0lIMjhEYzBRNmpwbTVtelVYREdEL2s5N2RPSHFWbS9VT3ZjSXRVU1UvVGdX?=
 =?utf-8?B?bVNTNDN2WUwwTzN0M0FZUHM1NTFuNDl5VVpkd2VVUkc3bUNQNW1PWDM2WGE2?=
 =?utf-8?B?RmVPU0NkMlg3Tis5NmY2bjdqUDZpTHF1bEZhUGJOb3RLZ3RBVFlXdnIrcDRX?=
 =?utf-8?B?Tm5uZ0JHMFJwdnhPWitaenN3U2xOeEZyY3Y2ay9QYi9aclFhcElDZ1NoVVQx?=
 =?utf-8?B?T0pCaUhpMC9KVXpVb2hkK29rVCtHd0V5U0dRVERCSGFuK3lJZnVkdVNSS2tn?=
 =?utf-8?B?YWlMQjVNM2crVitlclZSQ1hXOXZPWDNYRGRzSW5za3kxZ1BUQVMxMGM2bis1?=
 =?utf-8?B?Y0E4WTFrd2UzMEw3TU01OHNXdytZVldyNjR4MWovWU1KbHNJbXIxc3ZkZC9D?=
 =?utf-8?B?YjdzNXIvY2ZwWFdPY0dOR1FPaEpteVZBclNtZ1gyNW5qelJ2bmhwSFFCb2xX?=
 =?utf-8?B?UXg3VzROTldkd0dNMmgvVjRQRS9ZOHNONkgwZ2JKZFQ3cWlQOThjRVNvc2Jv?=
 =?utf-8?B?RkJVdXlnR3V5aVUvSkJwWDFCVURrakVjUUN3WGk5aktFYjIybi9MQ2p0NkxQ?=
 =?utf-8?B?K2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 985564fb-d40f-411c-99be-08dd570f7e30
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 09:17:01.1020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eBdxwu0qI7S9uh0N+v/upyCtdovZ7v+XAFVAqasYLNDDECEHinHvMLlIVNkuwXRGWXm21eNUtxymthUepjd0Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB3988
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 09:17:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17933

On 26.02.25 10:59, Claudius Heine wrote:
> In case encryption needs to be enabled via an update, while still
> allowing the update fall back to work. One update step where encryption
> is supported, but no reencryption is taking place if the device is not
> encrypted.
> 
> For this the `noencrypt` hook is implemented, which requires some
> restructure/reordering of the `local-top-complete` script.
> 
> Signed-off-by: Claudius Heine <ch@denx.de>
> ---
>  doc/README.tpm2.encryption.md                 |  3 +-
>  .../files/local-top-complete                  | 29 +++++++++++++++----
>  2 files changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/doc/README.tpm2.encryption.md b/doc/README.tpm2.encryption.md
> index 3f7e89f..515348a 100644
> --- a/doc/README.tpm2.encryption.md
> +++ b/doc/README.tpm2.encryption.md
> @@ -42,11 +42,12 @@ The initramfs-crypt-hook recipe has the following variables which can be overwri
>  ### CRYPT_PARTITIONS
>  
>  The variable `CRYPT_PARTITIONS` contains the information which partition shall be encrypted where to mount it.
> -Each entry uses the schema `<partition-identifier>:<mountpoint>:<reencrypt or format>`.
> +Each entry uses the schema `<partition-identifier>:<mountpoint>:<reencrypt | format | noencrypt>`.
>  - The `partition-idenitifer` is used to identify the partition on the disk, it can contain a partition label, partition UUID or absolute path to the partition device, e.g. `/dev/sda`.
>  - The `mountpoint` is used mount the decrypted partition in the root file system
>  - `reencrypt` uses `cryptsetup reencrypt` to encrypt the exiting content of the partition. This reduces the partition by 32MB and the file system by a similar amount
>  - `format` creates a empty LUKS partition and creates a file system defined with the shell command given in `CRYPT_CREATE_FILE_SYSTEM_CMD`
> +- `noencrypt` will not try to encrypt the partition, it it isn't encrypted already, but will open it if it is. 

"it it" -> "if it"

> This makes it possible for an image to support encrypted systems, while not encrypting anything on their own. Useful when updating from a system that is unencrypted to one that is, while supporting a fallback system.
>  

Please elaborate a bit more on how things are supposed to work this way,
which scenarios should be addressed - and which not because they are
inherently insecure.

>  #### Encrypted root file system
>  
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> index b907ea7..1214a63 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> @@ -216,22 +216,41 @@ for partition_set in $partition_sets; do
>  	if [ ! -e  "$part_device" ]; then
>  		panic "Could not find device  mapped to '$partition' cannot be encrypted!"
>  	fi
> -	decrypted_part=/dev/mapper/"$crypt_mount_name"
> -	# check if we are trying to mount root
> -	if [ "$partition_mountpoint" = "/" ]; then
> -		echo "ROOT=$decrypted_part" >/conf/param.conf
> -	fi
>  
>  	if [ "$partition_expand" = "expand" ]; then
>  		expand_partition $part_device
>  	fi
>  
> +	# If partition is already encrypted, decrypt and continue with next partition:
> +	decrypted_part=/dev/mapper/"$crypt_mount_name"
>  	if /usr/sbin/cryptsetup luksDump --batch-mode "$part_device" \
>  			| grep -q "luks2"; then
>  		open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
> +
> +		# check if we are trying to mount root, set ROOT to decrypted partition:
> +		if [ "$partition_mountpoint" = "/" ]; then
> +			echo "ROOT=$decrypted_part" >/conf/param.conf
> +		fi
> +
>  		continue
>  	fi
>  
> +	# If partition should not be encrypted, continue with next partition:
> +	if [ "$partition_format" = "noencrypt" ]
> +	then
> +		# check if we are trying to mount root, set ROOT to plain partition:

And this is exactly where all alarms go off: We should not promote the
inherently insecure scenario of trying to post-mortem secure the rootfs
via an in-field update to encryption unless it is backed by some
integrity protection mechanism already (dm-verity in our case).

We may encrypt certain data partitions post deployment if data on it is
not sensitive or is integrity-protected at application level. I don't
see other scenarios here, in the official isar-cip-core layer because
they are simply bad practice.

> +		if [ "$partition_mountpoint" = "/" ]; then
> +			echo "ROOT=$part_device" >/conf/param.conf
> +		fi
> +
> +		continue
> +	fi
> +
> +	# check if we are trying to mount root, set ROOT to decrypted partition:
> +	if [ "$partition_mountpoint" = "/" ]; then
> +		echo "ROOT=$decrypted_part" >/conf/param.conf
> +	fi
> +
>  	# service watchdog in the background during lengthy re-encryption
>  	if [ -z "$watchdog_pid" ]; then
>  		service_watchdog &

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

