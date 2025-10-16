Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6766CCD194
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 12:28:32 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.70])
 by mx.groups.io with SMTP id smtpd.web10.6824.1760617707287769028
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Oct 2025 05:28:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=hgfpVFxN;
 spf=pass (domain: siemens.com, ip: 52.101.69.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CdDLD9+Eg7Eby6YdAL6ePaczjnU/J+wNpWDz5TrlrPlW/p6pWpK114rR71cd1zp6ASgU8HSqPQzT68FceDzq7LkkoLEMZju1RqWCKh5GSugG9ITRd9i5cnuZG68Frsqz6Z5iPGiCBrXrj/wZyGpblq2lKhZYzUS0YfiGzvizubbhXTOLCTdwGs6ypEDd6npkVpVtnD/aiFLswUNi/AnIfwkFFafSYH0k4tYUYhI2BASySh7yveKunEfgQbl6cwx4zE5YR3CRwvAbehJl3rsKaPxtmDHFrcYxbTG36PiwISQJekeEhFDB5ld/QxcILQJnU7GQ1xukYhHsIfInhlk9iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STQVaNhUSDfmL4teHu5giefbvlbo5it5042VmpXi/k4=;
 b=kwzwPtuTQRDbcet2q/y/WKfZMxDq26N4v3DnsGj5aCyVFPbQMPBR/uy4421biJyc1hMb7AaDSPa6HlQh18sdTRwvUSiSnUtuBmnHJdaHtzlU2S9xYpwwPNE6BVLGKfmghiOt8ovPlW4Lf0g3L6dViJHHntekaVWX0ieQ/Ipxw/1DTh/6IECHJ+0klV00k/e0TCWtAW9ZoLRo2nvuf50ztMBwgWrf2yA8uwo2HXEWhOxer9CBh2xfdX3Yba2kxmBbIyoogrVXTSe6ubJnevl2RdqDFHDXFPfLKYrEHRvAun67CCe838Qx3KmwMS9bJhmbllgaWdl4B8qzADq/ONqIFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STQVaNhUSDfmL4teHu5giefbvlbo5it5042VmpXi/k4=;
 b=hgfpVFxNONpO2w+cJDEruSCxEauoACmRImZRGqw92G2nFF6Yy9H0zEYsoVq9+khvPCDfFOCeAGXDuZBD5ATg4stw4T7V/63D7pOElROv8djcEzdFus3ogB4LVFUQix1w/MTfxnUyaKt2FmU3ocMXAj2iQQjAA1WvBz1VAzUvgNDgk6AtogxyDi6l/Pct5T/tEXpjMSinFGmBCcQDFux1FIYy87DRz4oAxIG+LJJohfjzqtSKUO3iC3jRNvgqHeh82uSqE+f41I59SQBANv4/0o/SxEjyNUu4Ksrr4M0y0Ikmt0yt0cao5hdXBdeeaFAw2xjirqKfj31qDs27Ek8NMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8743.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.9; Thu, 16 Oct
 2025 12:28:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 12:28:23 +0000
Message-ID: <de098b99-d72b-4f28-8f5d-a8c20716ffbc@siemens.com>
Date: Thu, 16 Oct 2025 14:28:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] isar-cip-core: on-device tests failing
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Shivanand.Kunijadar@toshiba-tsip.com, Adithya.Balakumar@toshiba-tsip.com,
 cip-dev@lists.cip-project.org, Chris.Paterson2@renesas.com,
 dinesh.kumar@toshiba-tsip.com, nobuhiro.iwamatsu.x90@mail.toshiba
References: <53fe043c-eba5-4d8b-826e-5846efce7d57@siemens.com>
 <c8e57ef0-6f4f-481a-9e36-214f44fffb5f@siemens.com>
 <d196dbf9-7c3f-421b-a80c-2d39cfb6e27c@siemens.com>
 <TY3PR01MB110754E7268909F7468881081C71BA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <638abd24-8fc6-4fee-9bf4-679b51c936a3@siemens.com>
 <dcc32fbe-2b53-40de-aca3-0bb0e9bdf481@siemens.com>
 <232ddcae-a297-4e7d-9898-f34edd3671f1@siemens.com>
 <TYWPR01MB110639A5228DE9FB8CAC93E4EC7EBA@TYWPR01MB11063.jpnprd01.prod.outlook.com>
 <0f2a5909-4746-452a-8f39-187eaa9e3cd1@siemens.com>
 <6fc52da1-ce17-412a-85b0-8e36187ed56e@siemens.com>
 <8bf58a7b-cea2-480f-bec6-bcba41d450dd@siemens.com>
 <TYCPR01MB96696580C7FDEB7E0CDC3782C4E8A@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <ce936062-26d5-4bee-8eb4-e2eadd1a37d0@siemens.com>
 <160719b2-7915-48e3-9e63-eb08fa9d5c6b@siemens.com>
 <TY3PR01MB11075F1040D50FD87E26D929FC7E9A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <0116457c-5409-49cd-a077-e5bc696a5e21@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <0116457c-5409-49cd-a077-e5bc696a5e21@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8743:EE_
X-MS-Office365-Filtering-Correlation-Id: 47a32ab6-fd2b-4e11-ed78-08de0caf7fb1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NnBDMm14cFp4aVJNTzc4bDNiKzM5dldpMmFzWUJOeS96R3piUUxLZU9NWlBs?=
 =?utf-8?B?c0RpemdjLytReEtsdkY4R2I4UnlhT01Ecm50S0VUWnpYbFZZV01oV3FKeFpk?=
 =?utf-8?B?K04xUUhuMmQ0QTkySkh3TzEyZml6NHh5RWp0NTNuR3MwU1Z1YkQzNTZ5SVEw?=
 =?utf-8?B?eUlBMERROWc1TTE3WTN2MFZSVEpXNEdWbUw3bFNKSUd6RTdsUitERy93dUZh?=
 =?utf-8?B?S1NHUTVuaFI3UjUvRWtLSlhqN0ZtOExidjVwbGd6ODF4T0p0MkFOaGdSTGZn?=
 =?utf-8?B?T2Zjbm9hZ0tSVDBpTE90NUY0alNIRG1RT1c3WjR2TFk4aWtnbFQ0N2dWMEVG?=
 =?utf-8?B?Y2dPNktJZnhNS3lwVXNtTkY1Rnl0OUh2SHYzbGhuWk5hUjYwbGNCQlBLNWFL?=
 =?utf-8?B?aEp1aUVKZ2pkWFA1WExTVDhUOGgvZ0lKL094dElzRG5Ydm9wSnUwTyt3QU0x?=
 =?utf-8?B?M3hQQWh4NXF6bUcxNTRpTEllVGo5QjFxNG5GSzdFR1I1OVM2SERzakhOOU5o?=
 =?utf-8?B?QWFmZGxEaTRLdUVVYXhlQ1grS1JtSU9JZzJLSUZrWkpKS2V3eGhjM1hXSExQ?=
 =?utf-8?B?dlY0UWkwSUJOazNFYnFkdFF6L01Bam1uMlRkSWZmOXNpWm1RMjlRVUlWMnpC?=
 =?utf-8?B?TDRJYSs0cDd5aVRWZTl2SkphVUkzcm5yUG9zZ255dXpPVG84cVlVR0F4Ty8r?=
 =?utf-8?B?TVNyOFF1ZDZlVkR2MU40aFNMTDhqWGtET3FkY2h6VktvditSYW9ZZ0d2M1ht?=
 =?utf-8?B?NVdZU1B2Y2t6TFpUYWt5QldRb2FRMWJYdEw0NElxN0pMTWJITnUxR3d2S3Ix?=
 =?utf-8?B?dy93ODBRWjNQcFFubjRhcy9pMWpPSzlDN3hSSkRrYng0UGZIb2Z1YXpmR2Nl?=
 =?utf-8?B?dzBoQjhkZk5QSnZSUzVTcEZuVFl3MDdoNUZlUzVBVHE2b3AwNGp5NWQxVmJ5?=
 =?utf-8?B?VXhYOUVCeHhpdWZPTS92bmR0L01ueTViK3Z0TWN4VFJnNzE3TWxEdmVsUHBP?=
 =?utf-8?B?N0NSZ1g1MnUzM1VXTUpyVE1hYTFJSWFPNWdUbmZ0WER1bis4MmRZb1JkcWJN?=
 =?utf-8?B?Y0l0VGFKdktMSituT0NKVmhnRmJFa3hWaDQ1WERCUnIzUk0wUEJQZElpbmlq?=
 =?utf-8?B?VkJRMk1WWHZlTWJ6NjJTWFAxWmhYNHNmTzh3V3ZlNGZYTVhib2lVTllKRGdF?=
 =?utf-8?B?NDdyMmN1N2VjMGhrVnNKVFBhbUdlSVFJcjRGMDZXL3czS2ZWY01rTk5aMXdK?=
 =?utf-8?B?R0ZHUi9lTVpMK2R4UGVvcXZPTzllRWlFNDFsS2hJdTJGTFhRVUZlSk5razZx?=
 =?utf-8?B?ZzlmcWtOdEtGOFlLVTFEMjR3S2MzN0xMU3RVV1NXVTR4SllHTXdDbHZlZXRi?=
 =?utf-8?B?OHc1eG84OUxmN3hWZmd2Vm0raXhiMzRsY2VrdFRTczk4TnpQRzVscGgwZVVi?=
 =?utf-8?B?bk9pcDNmNFBiRlQ4MFBOQTAxMERLaGZBckhRSmRaUkNVWTVkUEEvaEN3UytR?=
 =?utf-8?B?MXdtQzRlZjY2bUxXMFdHU2duWWhDajFxdElCcDNWcTgwMHh5MmtGN3QvbTBp?=
 =?utf-8?B?RHFEeSsvdVJsUmRlR29qNG5ERmlBU0VRcmZvYTF5dDZ0aXd6NmNRNEZBZzRH?=
 =?utf-8?B?R1c5ZnlreldsS2IvWDg4OW9RcHRpOE1pMU1jNm9RUzJKdXhSeGxZK0xmSGZZ?=
 =?utf-8?B?Q2ZFZUdIMlIyQmdHdFpIVm0xZGJDb0YzelFlcVdYYlBNbVFPQ015WU8xQ1Rj?=
 =?utf-8?B?aXo2bXNqSnZKK0Fudkw3dUJtd0kvV0tNMVN4WjlTV3ozb211dm1kNlRFR09K?=
 =?utf-8?B?dU1XUVIvSXd6Nk14VzlYczZvN1E4L3hod0Fxa0hLZERuSEdjSk80Y29XU0VC?=
 =?utf-8?B?bnk1clVUbGp2SHlqKzdiYndJaEUzVCtVTGZrdUNhRkNpbjFGakVYakZOOGlD?=
 =?utf-8?Q?P0ym9KcKlfXth+h7bWokD82topmvh5Fq?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bjVWeGtnQXZhNnJvNllmWGRiV3FoSGx4VVc0aEsxdUpGM3VtYktyN1RFeFpB?=
 =?utf-8?B?b0JVckVxMUNKTnhiQ01MUXV2Z1JKTzh5K3FWWkhvemVSQ2tYcnFsSENWdmhN?=
 =?utf-8?B?N0ZZM0phbm9vUjh1WkpOSDJkZ0VHT2kyNmZkT21vM01IUkxUSHRoYmVTTS9B?=
 =?utf-8?B?MEdVNzQrVXdZWmp4YTdnR3hOOVRNR1ZtOWt5b3B6eUVybjg5dFJud1g1WU85?=
 =?utf-8?B?bnU1R0dFNjZxMG5qc0h1ZFdWTC94aDlNb0E3TXZHTVFZbHptYnpmbGJaOGla?=
 =?utf-8?B?VlM0eUN6cHZ4Nmd4dzVIL3JKdVdDYU53OGVKdnFEYnJSL21ua2dIaG9yWEQr?=
 =?utf-8?B?bSsvNCtpV0NpTEFNazJZNVlkK1lrNVRqVFF4UmhMQzV1cUJkR0kxTk8zWE5y?=
 =?utf-8?B?RFNySHlqM3JNYXpjRVR5dk1QbUxJbGNzU0hKaW9HVnU1ckxLSjlUU1VjenlJ?=
 =?utf-8?B?ei9KS1h0K2htSUNCMmtPb1ZXNUVJV0U4bjV5WTM2QWViQ2xjRmo2dGJYSFJo?=
 =?utf-8?B?UXFsSXVUVW50bDJ4V2drcTlidUd6UGV2SlVZRXE3bWpyMmRHM2RMWmY1QnVP?=
 =?utf-8?B?U0JyRWRCWkFWTUF0Z29kNDBuY1VDVnpPVTNEZzZ4bjNTUFQwOE1oT0lwMjJP?=
 =?utf-8?B?c2VadFpoSjA1YXk2V3F6YzFsUEFaMFpCcWE0MW4xc1BCc1FFWGJGOUtFUzM1?=
 =?utf-8?B?RStZSmF4M1lqUVNBeVdoUVlkakh6cHgyeklYbDlNQTdYY1lQaTVJR0VPQjF3?=
 =?utf-8?B?amtwVDd5d2tBazhvdTNwRWxmTnBQTXp2cnozeEVraTV3WC9Wb001T3BQdFFa?=
 =?utf-8?B?Wkh4ZTdib0FPenlGY1hZVitUd2NCQXBZRUlwWm9GRUFOV3FhR2dpNjhnazA0?=
 =?utf-8?B?WExNSXUvQ3ZkYmRqdEpNNzJha0tjOWFadXF4TWRCa2g4a3FHZ3g2NFUrTDRs?=
 =?utf-8?B?ZG8yWmMzQlJQeU9Bb041RUF2QzlzanBaaWh5OG93M0k0Y0puS2xodlZGcXl1?=
 =?utf-8?B?YzFTSkJnZzJqdzVIYlJlWEJPeUorUFZ6bzBXZndCMXFSb284alRJMTlMaTVo?=
 =?utf-8?B?MEttZUJ5dHh0TjlJcmMyV2FaakMxSHhtVUh5c0lkMFhGMlVZSzNFQ1BBQ2tX?=
 =?utf-8?B?VmVMcDR1OEFUOGs2RlFKNGV4UjZNaVVWbDkvdnlGaC9ZMXFmblBFUllpd2Fm?=
 =?utf-8?B?cEl5ZHRaMUtMdy9ncWE2aE5iWGFkNUZIeGZYMXRxVW12S1JHYmoybjlUMnhu?=
 =?utf-8?B?LzhEclFUcmFQSGp3L2FzRlJBZk9GZHBJK0ZUVGU3TVhBSEJaOStJODJjZWhF?=
 =?utf-8?B?SlJUQ2NPUzdsZHBYakNyZlBmbysrQmF1RmtIak5vUlUxOVBNdklIZUp1SWpS?=
 =?utf-8?B?cFViYUJxU1Y0Ym9RaEQ3ZWU2dkttYnhKUklqQWFqQklHaEFtTkFCVGJwaTV3?=
 =?utf-8?B?YzdQWDNYMVhrZGxXYU9icXVQWHdkQ1BlQmRaVDBPZHhxVnpKbHE0ZVJzSThs?=
 =?utf-8?B?MGpXYnlpdXl5N0ZOeVF6VVZUS3dRRjAwV2RIL1BGZmMzZGM1blQ3bmxoZTBI?=
 =?utf-8?B?UWF1ekw5S21hdTZIcUdiMVM3OFV2OXRLZ0xCa1FUeHR6RUtNMGxHeG9ac0w0?=
 =?utf-8?B?Y3o1dWJoMWxCYmQxTTZacTM4UncwUStUbjR5OVAycXBxa05EZUhYTE94VEFy?=
 =?utf-8?B?RXhsSlRmWHRza0trU3VuNE5palVORHVqOXd6ZDY4MlMwM1ZjYytQdHNRZVRF?=
 =?utf-8?B?Y2hNSFBqQ0FQbWtrQTcxSFRyaXZSMC9OZ2ZPSFBoa1V2TER3NWNjM1hveGtM?=
 =?utf-8?B?MkVhbC9lc0dZWFA0TkdkdEE0OHRTOFFSQXFsc1ZNQmpoa3Z0aExNdHEzUHNG?=
 =?utf-8?B?TXNmM3JtekxBV01KbGgwYmsrci9tRy9rRS9jVzlQd2ZxV0tldDI0UTc0aTdN?=
 =?utf-8?B?SHBuOVVyTnZmc29qd0t1cEx1bGRQeDkrY2tjdkdZWUgwSmJ6UWxHc0FqWXRv?=
 =?utf-8?B?ejBZbmJVVEVlTGQwWmFIWGlzOFRpTTdKeU1IMEVWZjNvSENyVHNUd2xtblk0?=
 =?utf-8?B?QUpYaFpodSs2ZllxZC9iTjNad0F5NHgzSjJlZGpxZTB6YXdEY3pvUWRLSVE0?=
 =?utf-8?B?RGFObXA3YjRKNzFVNk5SZ0w1YWJDdXg5dEhob1hlNFNaUXFvZ0xRZ0FpRDdZ?=
 =?utf-8?B?N3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a32ab6-fd2b-4e11-ed78-08de0caf7fb1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 12:28:23.7212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZWpryygimEiTfiPdKmlAofy1opndwk32wz/LhNGgB12+g4LVLYvbLrZr1VIQnUprUA0sJ5zbjnOLHpQpxeXrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8743
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Oct 2025 12:28:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20187

On 16.10.25 13:22, Quirin Gylstorff wrote:
> Hi,
> 
> On 10/16/25 11:16, Shivanand.Kunijadar@toshiba-tsip.com wrote:
>> Hi,
>>
>>> the test case completed (without timeout issue) successfully on Sept
>>> 22nd, after that all IEC tests which are submitted on M-COM are
>>> incomplete (timeout issue).
>>
>> In a test branch, I reset the commit to the Sep 22nd version, which
>> was the last point where the test case passed successfully, triggered
>> the pipeline[1] and completed the test execution.
>> It look 54mins[2] and 1hr 6mins [3] to complete overall IEC LAVA test
>> job. Please note the kernel version is 6.1.148-cip45.
>>
>>> We updated the kernel afterwards (Sept 22nd) e.g. Also some Debian
>>> package update
>>> could have brought a relevant change.
> Thanks for testing the old version. I have set the device into
> maintenance to test some stuff.
> 
> From my initial look, the execution of ssh-keygen is the main blocking
> task.
> 

As this no longer looks like a direct regression of isar-cip-core, I
will unblock the release now and likely tag 1.9 tomorrow.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

