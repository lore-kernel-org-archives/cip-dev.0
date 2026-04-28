Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37936FF885A
	for <webhook@archiver.kernel.org>; Tue, 28 Apr 2026 22:20:13 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.21])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1420.1777414807104426224
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Apr 2026 15:20:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=w9Ts2/6c;
 spf=pass (domain: siemens.com, ip: 52.101.84.21, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FaBU5rbbxjw+V8et6K/J3SHzZe9GbjR8Z0cO1+y+NaxQgaZbVRHpQPL0DkKW2le2waxqVAPcRM/kCJNz1KVy051VJ2hgrYoC4M0vW1pt0CBiGWRiInJIUlMIpXQy7ElFdTbtHYkgEdFszwJBycrvFZtcHxz4HEF4lgPfhKa8sBc2KKdztX+Qd8e7uxKvSQX8aPzt6zN5pH20GX1WSMGgMZIAl3cBFpUQyRvPdlP4ZyvFTXo7GB+cgyZDNya93HaluQe1MKOCWouGXYcZHKxRl6rrJ5JekuwJE8pMmU5NLat1eEiuBw5cMznMf710aJAQpealPmcs4Ul1xm0pEa28hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bcpy6wkfcloiTwdlpycK62kGCNx6yK8bJ8CnczEe29U=;
 b=Op8JC5wpvmEsRT0TyPhZN1T/wBYFLfj5AZhZQC2BNsn9Qza0CSVlJiBtpatjCdrSwUmax2aDgpXvhv/NpG2PQ2p5TmD2zffzNMOFSc843rrSJhHjFmnBfG+lN6LPo2zZX65DWpGajRYzxgKEjfTqd0VAS8kVG1UMX2wBhCqW/IP2hRmKoCz/LfO4wxwvI2euCADxWC1WG3lQy9r4QXGZlhWpv+Pmt3o+QJEEVaUSbVIs2EJ/atPIcsVhgIGsqZfUa5KgmyJyrQcsoybXs6qzr5CPStVZrIdHXhjcZFfTZ6WE5m7pEThbXepW3z4IRHGWBkEwJ5pGaEDMuc7kM0bBDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bcpy6wkfcloiTwdlpycK62kGCNx6yK8bJ8CnczEe29U=;
 b=w9Ts2/6cQzOE/Btx/Rj5VCPlNDzLf+SCeTOUssTCx6ai0bWZ6sF61oM0pol6br5LxSj34QCL/tsY8yskv2LMgTBjL1uKzdnBN3Y9NsdMB0a7052Q2zbqBNCyMK3nM+zeEwAnj8ve6XRwpmlMJoVBDY6Tq++eUzqlSnmB0HEtdKGn8nnER7Bo0codMHyP/dFLapVXL1In/cMgr8OOXF0r0/7TQXnEP412bqNfrkqWCT8yc/vn9bT6DBdQQLpvJ9MRrj4y60YUM+2pUnvIuEqztpScu7p8zdU4m99ThjyMKCpkVYY3Exq4yOoAICkX+8DHkmlWyGv9pWAVRITAr5ig/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3472.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:136::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Tue, 28 Apr
 2026 22:20:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 22:20:02 +0000
Message-ID: <3e88bc83-3502-4e8a-9bcb-5bb157485acb@siemens.com>
Date: Wed, 29 Apr 2026 00:20:01 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH v3] crypt-hook: Check if WATCHDOG_DEV is set
 and available
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
X-ClientProxiedBy: FR4P281CA0199.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3472:EE_
X-MS-Office365-Filtering-Correlation-Id: 442d0af7-eb42-4e17-d57e-08dea5744af2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|55112099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	KKBbb36KJsBckT6hcF/jjv8KDeFRUAW4FnRC6BnNw2/e39Aq9+5IE8zJxV7Je49Pd+6K7lsI2xkWPHc/StIuZupYRSqGL8Sfy3FGzrcSeY8hEReuezcbRLn6DM7rKHRc2D/sBP1qLLMdZBzu0Z2Ue7Ogqf1M8GbjpHKCxictUF8Qsb8Jm4LQnjXNgddM10LTeurNAI+/1KiFFUjXQehAGGHL8/+jZ1VXVKLjjlI3yCr07eBJ0SybgGfxUwMz9+ldeq0MdQv4BTmewKiTV5mcxK9X7OVmgRW+/sHlaKjjKR1Rdl7vmBi7onyOIzfr8gfmPuzRvDcMh2ckntMQa4l/uxKYvDyQpifwLwf6duD74voVd/ClVGSb7c8rRtsqolkor/byhE8Il9gwjeZxixrk5XY4LbpsMRFUzrrDCKFJ1xqEqxwNjM5V11DCNpmOsbaix23BgdG2kh+MLNYm8sTXN1McZsQtNKYRczW1ZcIK8+dfxQyeHdbShEomOkXBQW5tMdidzgC5y5hlADeBhltzSY72/CcPPZRIAQk8iIQ6LrsYaQI0xwzxkIPKq1wMmS7597cGfxMscwNid0g1kaKOV//V1Ozwq6jCB69kVsGbHZbSdmTaFSAlWiZ37AsTuM+B6blylSEz8Kd20Fl5G08S/VezQBBhZszH/4Moxehx15dOpuoFQ2q+9eGGGh+EtGIvS95k1eyllzlnReX3yDN8T1Du+4MiviKXJK8WzlwtdrY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(55112099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?azZvZWFqVHE1QWpnUkg5QVh2Qml4dmF1KzFMdFFkekE0UXhIVVBYaEhFc1Vv?=
 =?utf-8?B?UERkdEM3Y0ZacWRHZENYaE1wKzk4eEhIWmRESzl0blJRMXJyVHVoQmc1S2Mw?=
 =?utf-8?B?T21uOHJXUTFBYUl5czAwaDRVc2UxUWdWVWdzaGVnRkpBT04yc2kzSElRd21T?=
 =?utf-8?B?U2s2dlhrMlNnK2ZZVTBTd2I0SEVqQ3hMTFdiQ0FqRWtPM1dQYmtQc1ZpT1ov?=
 =?utf-8?B?V3FjQU94SlJtMlRNQlRIOE9CZjlqT0Uwa3ZlQzZBTmR4UVB2U1VRdktmSVJS?=
 =?utf-8?B?YUJHSVQ5YzE0REZYbWpjdlhBek9hNDF4dFhiRmhCTjkxdTU4WWdtczlsQmFr?=
 =?utf-8?B?MHF1LzFQdll0WTZKU0NSVXFiVTZGa01iajNoTnJvSzdNZy9ORW9PZldaY3No?=
 =?utf-8?B?TWRPY2xMSEs4ZmdiMnpVVVpxSFlWc3J4a1c2bUE5TlR3UkZaZXRyNngxV3JJ?=
 =?utf-8?B?ajRrOFMxeG13Um10S2pnSWxBdzJxc3FJcHNQVVFNWGVTeXVpekFucGVNV3k2?=
 =?utf-8?B?RzFYQ0NteWdJVFNMR0ljcjVjZ1Q2TnlQRlBHSkxBMkVSbDZ6TE1PREFnM241?=
 =?utf-8?B?dUdMQjNEM256QjZKNytncjhZcTRUN25VQlBZalQ4K1dFakNHY21Eb3FmM1Vv?=
 =?utf-8?B?YmZLZGFXcGZSb0U3d1hBVEpPc0Q3QXBhWE5ZbkxYaVRUQXRkQ0VQdUxsQ2px?=
 =?utf-8?B?L0NIQWd5VldFWkVoSy9yUGZMWlk0dEN0M05jSFVySmZsUzI3d1NwbERtaUtH?=
 =?utf-8?B?UWp2MCtPS2xyaHhRalQzb1RRcmt6ZkhqeURHY3N0aStnaDh3SnNNVDNXRnBw?=
 =?utf-8?B?Y2pEdUp2T0RkREJKR3hRRmcyVWw5ZU1CZkxhSkljNHc3M1J1Tk9OYnNTUEQw?=
 =?utf-8?B?N3luUlBLTENJeGZtd29nS0F2ZkVWWjVObjV6c3pJbHBmYnBNdXVhSVMxNzFT?=
 =?utf-8?B?Z21SdHVOVG1LcWVMSm5oOFBjL2lGUDA1NlNtd0JYVGVQYWF5WllPZGpTOW9y?=
 =?utf-8?B?MEd2Nzd4dGZ5ZFIzRzlsc05rOUhNYVdHMzdjT2VZUXllNUxHTkNTWTFHbnBh?=
 =?utf-8?B?M3Iyc2NXdkppSFM4WUgrSFVYeUk0UXFhVFpQbzkwSjM2SDJzL09CM3hRcXFV?=
 =?utf-8?B?aVFXZnZja3Y2TnpMTHYxNHZ1NTZuSjl6WUdZaXUxakVJVmxuaVk2WWYrVlVP?=
 =?utf-8?B?RGdaaktpS3QzVnc2SDJMZUJXdUdCSEZkVHlwNnduYmVTWGlTc1U4ZHRFc0hk?=
 =?utf-8?B?SmsyNDhjL0I2M3lYVlZVVERSbkhqUXBrdTZsdEdkOXNtQjBMNmc4V3JhTDcv?=
 =?utf-8?B?ZTZhTVpkUnZubmRzRVA5K0U1SEhrVUp1bkpBbDFlWmJLVFRUWklZOSt3bkdU?=
 =?utf-8?B?Tk5EWjNlYVpQRUYrVU5IMkpUN2RqM0ZVbkpUZlVKMS9IZjB1eDIrQlZaN1Rz?=
 =?utf-8?B?ZENzekpSR2FKdXdRb2hZQ3ZQa1RJTnZmc0hJOStETTBaMUIyMVRtZnUwUVZC?=
 =?utf-8?B?cU0zTEFYbFVKWFUvb2JuaUxGMnZLeTVLUXgxYjExSGRKRHltTEkwRWFQa0J0?=
 =?utf-8?B?SmJpckE3NXNTQ2Jrd2NCSDY1Ymh1SkxxQWJOUjJKTWtaY1BGa0hXSUNDU0RG?=
 =?utf-8?B?YWhDcnBlcTR2amZJbkJUWmVRSWRIanovTXQzb05mZlpMYlNMUU4zVlF3STUx?=
 =?utf-8?B?NjVWTDZHaXRuMVdOS0k0UUJPTHNKTkh1ZVNFbWJoaHBRRTNIRUt1bzk4cldW?=
 =?utf-8?B?M1lqR2t2Y3Q1cUhWLzRtcW1HUURGcHlHR0N5dlFYTVExU3pGWnhUSW5JcXVJ?=
 =?utf-8?B?WXYwUkhVc0V3OWpkU0dodVl6Wm4xTUp6KzNRZ0oybEFka0U0a0VpZGRGUW12?=
 =?utf-8?B?RUZUNDZVdXVnblRJa09WbURoWkd6Z1hKZ3hNMUEyZVpSYm93dnVsSzhka3R2?=
 =?utf-8?B?VEgyK25FRExYcEVRMGtHOElXUWR3Z0xxZGdaekRYL3JjVkFpeEloS2FwZXFk?=
 =?utf-8?B?Szlic3N3ZlVqSVlPY2RWSC9mdCtEUDFJQ3NFbFNiOGNTUzlmWlExVWVHRlhT?=
 =?utf-8?B?RVB0amF4dUlBb3I3anhQT1pJU2M3clBPeVJ5VzV5ZWxPY3FYT1AvSnFDRTdJ?=
 =?utf-8?B?MXFmQWZkak9JRlM0REsxSmFOaVpJYnZDKzJQRFdyUzk3c3dlZWhXV2ttUkU0?=
 =?utf-8?B?QStVVmlUYjZJS2RPbHhWRkNYZ25kL0xUSjhzeTVCSmlZSWJsTlM4VzdGdldy?=
 =?utf-8?B?S0VTeWdOOGY4Mmhqc3VGUTRyN2NBOUhQRENXNGt2R3Z4VTVza29ud0VZNEd4?=
 =?utf-8?B?c3hHUk5zbi94cEtVSkM2WFg2ZVNrZHZ0YWZ0S3ExcE1DQXl3NXdXQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 442d0af7-eb42-4e17-d57e-08dea5744af2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 22:20:02.8446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMJUGz+99UMg6fxrqpO7uDUhllo0MvHBkjlN0lFyYRg1BC20FCIOAA0mK7Pqi5UnUpIOYUh7g8niwP6dRDO03Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3472
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Apr 2026 22:20:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22821

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows the user to disable the watchdog by emptying the variable
`INITRAMFS_WATCHDOG_DEVICE`.

Also add  a panic if the watchdog device is configured
and not available.

Reported-by: Stefan Koch <stefan.koch@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
[Jan: fix up device test, link INITRAMFS_WATCHDOG_DEVICE to WDOG_TIMEOUT]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Posting as the second change, conditional INITRAMFS_WATCHDOG_DEVICE 
default, deserves review.

 .../files/local-top-complete                    | 17 ++++++++++++-----
 ...ook_0.10.bb => initramfs-crypt-hook_0.11.bb} |  4 ++--
 2 files changed, 14 insertions(+), 7 deletions(-)
 rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.10.bb => initramfs-crypt-hook_0.11.bb} (97%)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index 4f3eafc6..b0335975 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -2,7 +2,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2023-2025
+# Copyright (c) Siemens AG, 2023-2026
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -64,10 +64,17 @@ if [ -z "${create_file_system_cmd}" ]; then
 fi
 
 service_watchdog() {
-	for n in $(seq $(($SETUP_TIMEOUT / 10)) ); do
-		printf '\0'
-		sleep 10
-	done > "$WATCHDOG_DEV"
+	if [ -n "$WATCHDOG_DEV" ]; then
+		if [ ! -e "$WATCHDOG_DEV" ]; then
+			panic "Could not find '$WATCHDOG_DEV' - Please check your kernel configuration."
+		fi
+		for n in $(seq $(($SETUP_TIMEOUT / 10)) ); do
+			printf '\0'
+			sleep 10
+		done > "$WATCHDOG_DEV"
+	else
+		echo "Watchdog is disabled."
+	fi
 }
 
 check_partitions()
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
similarity index 97%
rename from recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
rename to recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
index c0572f2f..3cb05201 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2020-2025
+# Copyright (c) Siemens AG, 2020-2026
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -88,7 +88,7 @@ CRYPT_CREATE_FILE_SYSTEM_CMD ??= "/usr/sbin/mke2fs -t ext4"
 # Timeout for creating / re-encrypting partitions on first boot
 CRYPT_SETUP_TIMEOUT ??= "600"
 # Watchdog to service during the initial setup of the crypto partitions
-INITRAMFS_WATCHDOG_DEVICE ??= "/dev/watchdog"
+INITRAMFS_WATCHDOG_DEVICE ??= "${@'/dev/watchdog' if int(d.getVar('WDOG_TIMEOUT') or 0) > 0 else ''}"
 # clevis needs tpm hash algorithm type
 CRYPT_HASH_TYPE ??= "sha256"
 CRYPT_KEY_ALGORITHM ??= "ecc"
-- 
2.47.3

