Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16F3CFA74A
	for <webhook@archiver.kernel.org>; Fri, 21 Nov 2025 08:28:54 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7391.1763713732058207145
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Nov 2025 00:28:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Ec1l9p9e;
 spf=temperror, err=temporary DNS error (domain: siemens.com, ip: 52.101.84.49, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wq0wfzui1E12c0jOd1MCHoONfrJDPU2Y8XnK/Xj1/tBoM8hu1aVAbygKhAAXOpvkscP6mR/B3cUZWyZIjOZLrfAXLdmIF1dZVlsDPBvBGRfjMG7yvp+ybyClkM2vX5yS51zfUstlepEyPIRmVjsjTr8+Xm/auKS2NgsM2srJXwGZ900FvSAK9Sj3OadoUT1RMGmgY8JDEB+I/Lnf39/Ppv5Iy7t+VBMF2PhnR9+a3MGFrwc0z4YuDYdWTxfnKLZwbUj/rau5LKHYF0yo06RWTEBXTmKciGZsoQLDT2EqGyhuIQL8Vq5mY4M0ZKe0i4fANQGiEKPyvNIN5uMgNUlUew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5rabEfvOCeSrFrQZkuzXukXxVI7W3WYyI208jlU3Cs=;
 b=yTnk5XqUEka1OOhEqrvZMVd+00yqsK2nP3PZRDBreHk6yT8JV+YI+M/aIzPJcFcAsgJyISbA8oo7l73DJFbrIloBXGfQxTaxAuPtmFImi+1fdAvDWGv1hTrwvJK9e6cQDTWrePfJmWBsVcHqtdd71wsdC5WkohOtTFRi2uXC9WIfEIowKyjuxEFIgNZ5SrnYeurFymd34bb9pnIVcW8yZ7/P0j+NcOHB3OwBuUOVGQgxABwvUgjd153cKfmb2hM1J8BeLPt5UxepndmsOd/YFVHaniYPoM41AjWsd0rhlLMHTzCCnHEyzJbot4OgUaZNL0kaOqNXYb814U1iayWIuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5rabEfvOCeSrFrQZkuzXukXxVI7W3WYyI208jlU3Cs=;
 b=Ec1l9p9ejs3I4WQvuzp/CxVQteOi51bUnMnjB9uBiGQae9n+wHtts+4ng7RBGMV/lh+i5Ct6otMgC7S3RThDbWFr6P9mTFW2DY0ehgJNV/QQkQbLVpcOM9Y424yMa4JT4vX+LH0v31xi0OgkHV30Sjnq7R2BZrNrIu/SeotLiv1H3p6hdk4AGKAWjN56mZprk0t5mNRPrAGnrWQK7AVfS/nFbVcsMWYJ2VxyRmlPm9JVRIldej3GltfhpYzroR3BfqrtvEUPm0Ipb9yTLwPMJ2tH+kVQVhjPx7nh+6OVnc3HsVwN+Oliegli9GXMCneNCgALFyw9OHH8GaykxLUfHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6955.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:416::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 08:28:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 08:28:47 +0000
Message-ID: <630d2015-a1ee-4acb-8100-b941abbd7354@siemens.com>
Date: Fri, 21 Nov 2025 09:28:46 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
 Pavel Machek <pavel@denx.de>, Ulrich Hecht <uli@fpond.eu>
Subject: Drop CONFIG_OABI_COMPAT from CIP configs
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: 32a5678f-6523-4d11-c200-08de28d7fde5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NjBzd2IrMmhxVEU5N1RNVTM1TElCWGdoeC9CUWtWcGpNYkM5QXJHRStKUkVU?=
 =?utf-8?B?L2ZpYmZ5bHhRMHZ3R0RBNGlVN1JZTTVGbWtUdldsMnc2UzFDbzI1bFl4TUk5?=
 =?utf-8?B?ZDNHTDB6YWdJUFB4NHdXWTNiL1FJVDQ5RUdlalp6b1ZXNDdva0k5UWVxUG03?=
 =?utf-8?B?dTUxK2g1U1pxWnZ0c3VvQ0pRQnRJTHF2VFRCTWJKVFNlYVhGWFRhb21SZm0x?=
 =?utf-8?B?WUZaNS80a2FhRUNnS01PMG9pVDgyUDlaNENFSVNNT3FjWmQrOGZMd3lYL0R2?=
 =?utf-8?B?MHRwVWNGNHcwamlEK3hFT2NNeHVWQ2lGSklNc0N0Z1kwQ0o5eFJzU3dobm91?=
 =?utf-8?B?VEI3RmgwU1BkOEh6RmczOVNFZW11aG1tRlhZcHB1aS91Z0lkVE9xQjNJcFV1?=
 =?utf-8?B?WEUwZk1SM3FmamNTenc3bDN4TUZCRTBuTG1lK3VncEd3ejJ3QXh2cWNkSGFR?=
 =?utf-8?B?cFQwZDZEWW5OS2pvUHBVV2RvQjIrL3FtcERtUTFlS3BMT2U1R3k5NEFRT1lW?=
 =?utf-8?B?a3JHd1RnVmExMEprckMrS0l4dmZISWI3WGNuNDFnNzZBQnREaVZHREc1dFlW?=
 =?utf-8?B?VFluWXhKbWtuKy9vQ1FLMG9ldVJZb0w3Ylpuem1CMGZMUzBkZFk1ejZSNyts?=
 =?utf-8?B?ajRHTHZFQkJLaG5ZNHNZalY4TGs2TXBIUW55Mm8zTithT2VoY1o1dkExTTFy?=
 =?utf-8?B?di92cUlqQzNhZlEzTW9TTVVuc2pldlArNVVwb0FWK2JUUGpoQjV5dXZaTnFa?=
 =?utf-8?B?dWRFL0tlRlNJMVJlajI3emxqeEp6K0d2ZXZhZG1oNlZieDg0aDFCWTVNSTVV?=
 =?utf-8?B?d2lNOFhHL2piOENIMkJ2bnUreDBTZlE4MHkvbWt0VlRWNXZ6OGc1Mk55a0N0?=
 =?utf-8?B?eUhqZ1czMkd5eXdicmtrUGExcjl5MGRlaUhEY3R3amhVNU04MkxLM1JQeE92?=
 =?utf-8?B?NmJSaGNiYzdWMDlsYk9ZODhTU3luaFZ2WlUybmFVcUk3NnRLbEpRUDhUbGYz?=
 =?utf-8?B?NVRXVmxRZnJyS1NrcnhGc3Q5MUd3bXVla2J2L3JZaUVSd3l6OVRpa1VNMllw?=
 =?utf-8?B?UnFRb0YxRGZQRSt0SUFHSlNxRnBraXBpaGpPR3pTNy9KUm1ucTh6UkFIUjBK?=
 =?utf-8?B?M1hYc1RjSzErbUh4WElaUTBJWU1Ja3NTVWdMRmRHc3gzS2ZkUTdvcDZ2bkxM?=
 =?utf-8?B?a1p2dVd5ZW5RMnNCc25iN3RvRUl4UG05VUFxL2x3d0VXNTA0VmRJeUFGd3ZP?=
 =?utf-8?B?RndQaUpqc2lJUGF3Yk9qYkQ3TUFsQ2dQVVU2UVhpcmE2MzFzWXJydWh0VXg1?=
 =?utf-8?B?VytJbkVySWtBdFRTNmZ6MitUUm1pSVFxS1J0UVc5TlVYaW9VR2Y5TE5OR2Fq?=
 =?utf-8?B?bk0wQnF3RkNCRm5UTWlERkV5cUxMRlFydXlrall2bUdKczJpeDNqSGdQeHg4?=
 =?utf-8?B?WHJ4S3I4S3BuTlJMTEpLOTVGam1tL0lGUWUyUDdHVkcybzZndjg4UDZkSWFD?=
 =?utf-8?B?N2xYOXBtclJNVHF0Rm5NZlNrNi9lWmZEc08wL3dPV2R3QXVDb0h1eVFsNU1W?=
 =?utf-8?B?dHhBTmh4VjRoNTBvTzNxcEkzRndhTE1iWFR5VFhSM0N0bzZ5cWo1SWlmRno3?=
 =?utf-8?B?TXZoSjl5ZjJUOUpZRnZ3aW5Wb0R2Sk02czBXQ2JZNlRGam9jT21GTFQxY3Qz?=
 =?utf-8?B?SFVFdkJLeHB1YWwvQld5ZU5FbWtUbTExd1o2MTZhZlhFWk5uWFhtZ1NOVnBQ?=
 =?utf-8?B?bEVabGFkalpVeDBueVdncjNWTzBhTlk1amJpMFd3Nm1HODh1WWtxak1vYThB?=
 =?utf-8?B?K0s4Y2NCcVpvcVF0eHdJbUp4TlhjYVZmSEdtUG9KdkdlWG9IdGFBdHRYbk9R?=
 =?utf-8?B?S09UbkdIeUJHQ1hHV0k4RzhHMGFkbmJlMVhsTVBFckwwbk01SEZ3aGd6QU45?=
 =?utf-8?B?NEhoNHB6NEhlb2xIZ2hkaWs2aTZZK3dldm5BZWo2R25Bc0pmenRJb1JaZWZ2?=
 =?utf-8?B?dUtBcVZyRXVnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N256OURURi9pWWF6b1hPS3hmeDl0NXdUL0dLUDdPeFl2WVZNbWNxdDhtd0s5?=
 =?utf-8?B?WTlGYnNKeVVxR0hTZ2xTRE5xZmxoL25oK2cxdzB6TnVpVEs1UDRsdjVaVjM1?=
 =?utf-8?B?bFZMT2taV0FzSDNHV2JnWFRFYVM4MmhrSWdOL3FrVnFGZUxQckM3eUgwRVBX?=
 =?utf-8?B?b25DRUVZQXpmVHd6cjlQL1c0N2JheW9PN2xPcW5FaWY4d09qSDdFVUMzeWJZ?=
 =?utf-8?B?dU5vQ0VVb3B3WmJkY3YzOEJZNjdoVDFxNC9sQWdsT3JRR3EwOUczZi9Bck4z?=
 =?utf-8?B?MmpIZGpZVTdLd2I2cnducWFXUjFzVWM0c2M2QUMyWFl6UWoyb2F1RkZGTTBm?=
 =?utf-8?B?UUxxQTFselZ6Kzl6OWVka3VaNGFob3JrdExwNkVEdXV0a1QrakVjWEgvSzNT?=
 =?utf-8?B?ZlNVbnA0QmNtenBObjhtSklscEEvL2FLSC9kMkVjNDd6Q1FET0g1QkNxaUZi?=
 =?utf-8?B?cElwRHgxb3hFekxESFdmWklnRktSeEgrRXVEenZ1UXkzeVU3dW9Md240Sldz?=
 =?utf-8?B?ME0zeUZkd3ZWc29zaGRONEhwZDNQQmt1NUxnM1JGdzkrSnpXb0ZsMXFOV3Iy?=
 =?utf-8?B?dmU2STNDaEVqcmErZDE1bkQ4dG4yZmxFUjRTZElHbCtQL0l3RnlZekIxN0tB?=
 =?utf-8?B?V3VBLzNPbTJlKy9kU280bTlwR1B6bU1mb0ZFMTBiL2t6OXMvd1dqd1U3Y3pQ?=
 =?utf-8?B?NUNiekZhSVhqSHQ4RFV4ajQ3aUpiTXR1dUV0S3NCblNWT3lyWE1xVkNFOHV5?=
 =?utf-8?B?b1pMZnlTdGtncTFnZk5LR3BJUGpzT2RES2thTjk0empiekZoQ2c0aGtrNk4r?=
 =?utf-8?B?UVNjL05GNllHWmNVWGJVR2VHeVNLZGZhR05GTjFiYXdrbFozUkxZUnpjVDEv?=
 =?utf-8?B?TGRaYlJVT0NJdnpnamphTmZzUGRUUjArTFpIL0lCdW5XK0xTUzAyL0NpbkpT?=
 =?utf-8?B?dlBLY2xLUGM1ZVFxd1lLZ0NjQzlzZ2pOeTZqWUFhcFRBODlNWTlhYlpSS0ZM?=
 =?utf-8?B?d1QzZ1NoSzFwQkM1Uk1Da1FXQmw5WU54UkNRMXZyWTRaL01VWXBFM3VlcDk2?=
 =?utf-8?B?SXh5NlE3TWw3QUFoVDNOT1kxK3FQZmxldFRVcjMvS2plM2UvY1N5bVdYZ3lr?=
 =?utf-8?B?aW9wT2VKM25FalhOVS9UMXV3V2crbGVNd1NBSk93cGhJWXF3NXUwSDB5UVdJ?=
 =?utf-8?B?WWdPYzBMWWd2ZnRYTjFMOXllbnRYS2FRSXoxblJHeHdwR3N1bnA1YzNTSFFU?=
 =?utf-8?B?R2JIMzBBTWJtVW05WDJuSTZZWlBNMHNrUHpDRTg4V1YvcHJCNjRKMmFqOUdo?=
 =?utf-8?B?UFIrQm16VEVEOHJBSjhVRFBGOG5LeVZsLzNCK3NTNmJ5SWJoTnUzQnJ5VTdS?=
 =?utf-8?B?aEVISDlNTVA3UkpoT1hZcG1uQU1NRmEwVXM3cDZyS2VrVnVRVmtKbXoyZzBm?=
 =?utf-8?B?TjJQYVl5TTF2NzVSTXRMdWxVUTBrQXE1aHZPeG5DUkJXZHFjTi9yZFpYQzFo?=
 =?utf-8?B?aWRMVXpYa0ZDR2dadTYzOTFwZjE2VkUrM21ULzhiU1pVRHU5eEhYOGoxb1kz?=
 =?utf-8?B?S2xuZFdWUDdtS3FGY1BoN3BtN2NzOUMxaHRHK3NoNHVqTWRBcDV3N0Y0akpv?=
 =?utf-8?B?bXJTUHhweDhWVUduTlgwQXdheSthNTBtUW1BalhpaVZ1bmlubDQ2MWc3NC9h?=
 =?utf-8?B?TjEydTkyTElPNkRBVnAyYUhPcUJlL1ZVdFI3RXdWempONzdJaDJkV2JQSndp?=
 =?utf-8?B?RmVSamdhTEN4VWRDdG5UTmRtTUNDT2pZYlRkN0pTeVJ3VjZWb282czlLQ1Bt?=
 =?utf-8?B?ZG9jTGZrZW11UWt1bnByaEU4T1hJTnRJa2c3ZTh4L1hFOHNWWXoyZ21pYUZQ?=
 =?utf-8?B?WlAxWlR2bjNsYTZtbG5DcS9JRXplRnhMMTRaRldxWlhDd3pyZ2VhTnlhZ2ZY?=
 =?utf-8?B?ZDdCMVRaVmE2NWxXa1I3UEhuNThDSGZ4dlZxSmRqMHB3QUxZNWQ5N1VkdlN5?=
 =?utf-8?B?d3pxOFp2c0k3K00zaTNid0tHVWVDbDVpajZYMWRyVWtTM2RiL3ZXbktwZGVi?=
 =?utf-8?B?MVROSHBRZWUrUWNGYlRXdDYrenVYMVo0cmFXem9nMmVlOW9KcTBuTzI3VTNr?=
 =?utf-8?Q?X9e2tp22qs6dENtOkbK0T+3ca?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a5678f-6523-4d11-c200-08de28d7fde5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 08:28:47.8471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fm79QT0shsXqqyuPUC8OZCjD1VA2nMdgjsvQjw3YXBHSwGUnJw29I3lm2cdgY8P6YJfFmOsTYTnNQlt4xw+XLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6955
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Nov 2025 08:28:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20675

Hi all,

while switching isar-cip-core to arm merged defconfig, we noticed that 
CONFIG_OABI_COMPAT is currently enabled in bbb configs [1], and that 
since [2]. This prevents CONFIG_AUDITSYSCALLS in our merged config, and 
it is also very likely not required nor supportable (no userland for 
it). Therefore, I just created [3] to drop this.

If you have concerns, please raise them now.

Jan

[1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/140
[2] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/commit/e28e124c4b0bdbf9d9552a3ee77ba29b4247f86f
[3] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/merge_requests/147

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


