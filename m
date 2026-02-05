Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322DCECD99B
	for <webhook@archiver.kernel.org>; Thu,  5 Feb 2026 19:52:03 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.25])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.29735.1770321115847260278
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Feb 2026 11:51:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=B0bkGroM;
 spf=pass (domain: siemens.com, ip: 52.101.70.25, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i0OL8LPrYJ9len2DJz7U6nlV6esnx1N3QOTDi59vs9Wf/zReDIZxmc+aU7X1s9GBJ9RnaasI83FKWmz2F+bSnV0XTxZJ+URgKo4MN7MGFkmxzCTnMXF68XN2sRfjbm4g8vb38qUurqnYczrt/Lk10clYpO5V5c+9R7b/kxWupf5BWK7Lii1avwTBf1s9m3IVECICqJm3YX68LmiwQyixulyzHL21AeTITrd3u69veWw4jaaj5JZxPHrNvS88cFCWNr7YxIpzck2Hs0slQhT52nBZWnc2xjv0s0U78D+tb0um2GoL3PZAzNotLtmveGgBA07J2UPeQf8tO/xtoAQQTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O476apt8tEC9NGvPk0zNPYKE8WDYpDlRo0aQl8Qt2YU=;
 b=m+wJJ59kJmEYhDU/RNEAgy4j6K+S5tfzI+qAsaRE05PQbpnQACIedqAwhvWdIYzHXHKCF5i9IemYVH0U4Q7MkTsRKA4fZMInfjwqehLZwzkMIgVWGvVuJEvVDn3fgIdu94YsZCuJX1bPZ+h98n2Y6pgw86nyHoolaEN+hC3Zr2IXNXhlHd3Q/0/+kiAYChDPiIllgnxvM+vvX51wlYwtqKehvTUcoZw5K3/LUhtydXQ0EC1YcHEckR7H6JwmDKxuUPqCqFoE4aV0vreGLQuXd/xsRe6Hy+7hmSawXmUxt2fuHdLnoj0EmN9bvWhOIMaLh/RxP+ysYrTTUYCwWfR++w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O476apt8tEC9NGvPk0zNPYKE8WDYpDlRo0aQl8Qt2YU=;
 b=B0bkGroM7yimrUH+RKc7+pR32J+UcfX4AeKggMw5gThg17XANS4TZT9cJX0pB5M1I/tozLmx+M6X4D1YROJSXPZOhPjSPMLPJ4J+WoGeVDJHAG9ua0QSkkeVfWBORJGwbiejJOBbCuyf36+L5X9tGEsU+pUSF6PsyExbvVaEK8As0kltUA4aqfo6IoO61EWxIn1m6ERWHKnMwxWcRzo2XIQwEKXeuGY7xTF//eIbMGsDZzxOJ1YbJE0ztF3dqJQk/DLJFZS372Dtax5KlV9nhCMcRN6k3vQdVASr0AV2SGSA8BTX9TaMyw9lWF7nN383PALp9gfmo2L1cJIvTW4+DQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:89::19)
 by AMDPR10MB9504.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:73c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 19:51:51 +0000
Received: from VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b57f:1a19:e3c8:fbb6]) by VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b57f:1a19:e3c8:fbb6%6]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 19:51:51 +0000
Message-ID: <263c929e-e873-4592-aa1d-3a79cfc4b148@siemens.com>
Date: Thu, 5 Feb 2026 20:51:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] swupdate: use self-built 2025.12 for
 Debian Trixie
To: "Prusty, Badrikesh (FT FDS CES LX PBU 2)" <badrikesh.prusty@siemens.com>,
 "Kiszka, Jan (FT RPD CED)" <jan.kiszka@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20260205163727.2995422-1-badrikesh.prusty@siemens.com>
 <944f83ee-b233-46d0-9e2d-f96af55cbecd@siemens.com>
 <SG2PR06MB51078D17CA7212B9DE6CE6039199A@SG2PR06MB5107.apcprd06.prod.outlook.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <SG2PR06MB51078D17CA7212B9DE6CE6039199A@SG2PR06MB5107.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::6) To VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:89::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR10MB2319:EE_|AMDPR10MB9504:EE_
X-MS-Office365-Filtering-Correlation-Id: b0141e4f-8acd-4fbc-678b-08de64f0016f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NGVGZHpQcFJQWjQ4T0FrSGV3RENXaXFJS0FYVEZlbXVSRmJxWWFManYxcFNa?=
 =?utf-8?B?OXRlNW0wU2xuMjg2YkNpOGJlRGdGbUFpeGpTN282ZnY3QS8wWXQvWW1xTTYx?=
 =?utf-8?B?dUlkRDRJM2hGd2hMQnF6K016VjE3TGJGU21hTVZCb3ZWdUpBd0NSRXgvUXRV?=
 =?utf-8?B?bVgwdGZxRFp3NS9ja0JuV0VycFkzMGQ0SkNBa0tXbmczTEptRVZSUDhJT0ZJ?=
 =?utf-8?B?MHZUZkJBSVZ3bVBlU1VIZWVsM1hnWHlycHM1M2lpQVp0RU9LVE45VWVKeDEr?=
 =?utf-8?B?dk9ROW5GZ2Q3SU5yM1FWTDlYOFlDa0lGY0JlUGQvQ0lKSTh3MFZoN20wZ2lt?=
 =?utf-8?B?N0tyT3lIWS8yaUtVNmJ4dzRlRGd4S2xZV1hTSFFoVE04UlB0MUU1UHR4OTBa?=
 =?utf-8?B?QlBmY0FYS0JqRElGcEhtSGF3K0JHRFVlV0Q2ZlFqYTRWN3hhd0JJbHJQWTBq?=
 =?utf-8?B?VnRRdVlRajNZQ1F0ck5MdVU0cWZ2K3Zsam5pM2NuY3VldTEvK2M4a0RINENE?=
 =?utf-8?B?YWhvS2ExVTNxSk16TlNaOFZ6ODlmK2NNMHVZa1F0L010WngwUzUwVCtPejFR?=
 =?utf-8?B?Z2wzdTV6Y1NicHk3T0FsZEtJTzB5bDBTZ2FUcXdIWWxSWG9YVG1XdExsMHBx?=
 =?utf-8?B?VGlwUnVBV2NSTTBmR3RqeVpSdi9UNmt4VmhTTDBRU0J4dWQybzV4ZGJaWlo2?=
 =?utf-8?B?aHByUmtxRXdrUldkQUkxdEJ0enQ5dmozMUYyTnlxUy9RSVp1ZThSWk1hUUho?=
 =?utf-8?B?eGhObWhQQ2VKWG1QN29wYWlnL0IzMzkyeDIvdGJBVG1QVzBldlFCZXFhTTJ4?=
 =?utf-8?B?Ujk2VHI5S3E4UFc2NzExbHpOeWkrY2hDWnFyUHVycUFaV3VBbUlOYzJrL1J0?=
 =?utf-8?B?b09RK2RyUFhUTVI4dFZEd1BNMEV4N0tXbEU5RXBPZjFtb3NVZUJMYWhIRTJ5?=
 =?utf-8?B?UUNHYUY4ZU9CN2p4Q21BdUtXSjZ0dWZQb3pyYUcrazgrU014TDV3RmhlVWRL?=
 =?utf-8?B?VUxrQlFiL2Fjc1pDVUVZRHNyNGVoZHFORFE4bFRTaG1GRnQ4RWplYXkvWE5h?=
 =?utf-8?B?U3ExNy9SeEt0NWpaOXBWYi8wZVpxcEhJanBpWWE2d1ZNZzE2OXFZVFNhNkJo?=
 =?utf-8?B?SXpUN0haeGxWLzhVSmxMcmsvNzR2V2laWVRITC9xbmNUTHRvS2xyTUdpRTQ5?=
 =?utf-8?B?MVc2OVlOZnFOOTgzZ2NTL2RwSXZHVTFRVHlzQ09NQkZmaVJkZVAva0QrYUxX?=
 =?utf-8?B?aEhMWjBjQ20vbEZ6STdXRHBVUXh2djZEOEo3SkxJb0FBWlR5VHp3Y3VITHNB?=
 =?utf-8?B?RE80endwTzRkQnZpUkU4ZWVSamtUTTJtbVlmRXFOWFFHYjRqUUoxMDNHZmVt?=
 =?utf-8?B?RlBTdjNsTU1rWkFSOFV5S3Y5NlpuUnc0MUR2azFCbHB5ekg1cDdBeW1CQ1J2?=
 =?utf-8?B?R2hRS3NtM0s1OHQxMnFwSDgrelFIWlF3ODI0d2hoL3E3TCtzVC8vUWI0dkpx?=
 =?utf-8?B?NzJJT21uTE9kYzJyazlYbnhRL2JoM2Z6Zlo1Y0U1cjdZWHZ4ZjdFcWZGcUFk?=
 =?utf-8?B?SUtGNzVPMFowTXVoOHhMYXMxbGJQRitiUnV3M0NrN1RjVXhjL2piaVZPaE5t?=
 =?utf-8?B?S1N6dk15dS9udmpGZHFmUVZNV0pneEo3VHU3YkxnWm5tUUVCVjgwMHJsTFlq?=
 =?utf-8?B?WlFtYjFVYWRIcUswVm5SY1JrbmpQVWgveHloNEtGdGZTTmZpc3kyVVBtQnV2?=
 =?utf-8?B?NklkNjhacHFGcEpxVzB6Z2piZFdScnQxb1BxcFlpODYrMmRqbUxmdmxJOXox?=
 =?utf-8?B?NWlPNkI2eDFzNTRGais1LzBEWms1VkZiTjBPOTNmSnRXQmFoYXpCdGJWTU1r?=
 =?utf-8?B?LzgyRHM4dGE0NGFKOVVCWURieG1zUkgvc3g3dEx4b1F6eGgvKzFrYlhXSURw?=
 =?utf-8?B?MTRFcGlLM3FJVWp1bG5zaHBncTFQNjN1R25DMElFZEdJWjdON0EzbXhDMmE0?=
 =?utf-8?B?bE5DOHFMVDZjaE9PWU1ibGc5dS9RbkVwQTB0OGlBNjBnMktOWnE4YjduUnpi?=
 =?utf-8?B?SzdSWGRQeUNjeFBXMkc3cENCWmk1eG9RU0txR1ZBWlVGcDVCM1MwcmJUcERl?=
 =?utf-8?Q?aQYmJEkEbm7vvtodV39dyCMEN?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RDR0b2VMYzkzOFp1Z0wrbXlFRVpDbmo0bU9FZkV4QlJYaVpBQmhSajdubDZh?=
 =?utf-8?B?TE9UOEozVjdidlZrVlR6UUJwNjE4Q3pSaUVscWdLdWhibDB2VG1sTDhxRXBl?=
 =?utf-8?B?ODNMTXJJVGdlbWh3N1NZczIzWlFLdk0zbWgyZFdrNGRWa2taMTlMb3RxZU1z?=
 =?utf-8?B?TGJXNTZqMHZsR3JaM3JiakZhWGkyMHl5eUJHNGpDZTg5M3NXanl0ajJqNmUx?=
 =?utf-8?B?UHUrcEVOWDk0RFAxQjd0SThZS0lGcmZBdjVzb2RIYUxwZ3prWU5LQ2RwWEU1?=
 =?utf-8?B?Q0Iyb2szVm4zRXpQcUV0SU42VjZkdldaVENpdFl6U3NaYnl2TDlONSt3NVFw?=
 =?utf-8?B?eU9MWUlrTTEyaVllMHU4Q3ZsNkFzbW92UnFVYzZwQVpXNVdoN2tvT2N5TmVu?=
 =?utf-8?B?N212bThyTjhac1Y5SXF4RmhFNE1zV0ZETUt0Kzc4WXdLaDVMamxtMlk1QUdk?=
 =?utf-8?B?Z1d3SEIyNW5hZzZFUTFGRVVLYUpWTXZsd3I4eVg5eHFpYllLN1FPbkE2a0NF?=
 =?utf-8?B?eHlNbmZyMXpZandReS9nS1cyYU0vMjJLWEFYV0tQVXZ2Q1VSanlNT3BkNjJB?=
 =?utf-8?B?bXVwcXlmVFBMWDJrQWU2eVZ0VUdqVWxEci95emtnL3BZSTdMczNIM1RDUG1V?=
 =?utf-8?B?bTd0WUxVMlRkSjIrNWVoRUZVRTBNVi83dUFJSk8xR0JRVmdSWnpJZk15Um5G?=
 =?utf-8?B?eW9OYTFabUYySjNUWlZtWFVZQ1UreFovSUlFTXErajlxRnhqYUJJVDdUbHdE?=
 =?utf-8?B?Y1RnRWVFbzJqcmwwMnRtYlIxSzdycHhQWUhQUjBxV3dtTGpBa1pQTy9IMnJy?=
 =?utf-8?B?R3FibGpoa05HZ3hWS1BNWGthRVBsdEJSL2h6S2FrWGx3UkRaUG94bTl3UjdB?=
 =?utf-8?B?MnRvVVo3UzRUZmZjVTUwcXVqcExMalpGeDlKbkhaZEJHY0JJTlpVdDFvUGwy?=
 =?utf-8?B?ZWduWFJSTDFxK0ROUmNCSHlyWVU5YytGUkVER3lpSWMrR0REbWczcVRDRSt6?=
 =?utf-8?B?NTZwVjFCM2tEQUhhS1FoUDQvWlhuemRZUlZ2RWRFZFRZTjZybE5oOFIrMHVp?=
 =?utf-8?B?UTFRaHpNSmhOUGd2Wmd3ZzR5SXkvSU5UL21YWWZXVWxkVE5TeERpRkR5UW5z?=
 =?utf-8?B?LzF3SkIxaGN1bk1mNm1OVVIzeXFGeWVHOTM0T0hXZGdkVm9ET2VxZ3RBMUhI?=
 =?utf-8?B?M3FBWm9MYTJlYkRydzUxOXlZTzZFREJFRVhJT0JOR1QyRyt2UTAxcUJ0dG1x?=
 =?utf-8?B?Tkl5cTh2NjgzK0pneFdpWEgzaWlidDVvWUY3dVk4NVlnOEgrWE5Ja2I1YkVq?=
 =?utf-8?B?bXJUMnVtQ1B2VngwSWdUbUpKM0tyWjJpWmsxcEtvcDFDVGx1MTR4M0M4TW54?=
 =?utf-8?B?L2hLYm5kczV2L0lJTXpEZkZzeDNud0xVZDJPbFZ0QlVpa0VCMjBpeUpyVWtp?=
 =?utf-8?B?YlVGMnFNUjRmZ3I4Q2VxMHlOZE9SM2ZLWnovQkw4dGtVWG5yTDRVYUVzWldY?=
 =?utf-8?B?L3dJMjlWNm90MTNHbFhLWFFnK2xFMjN5MDR0TDY1V2UzK2I4ckJadUh1R1BM?=
 =?utf-8?B?YzJIQWF4N2pwNklRL3ZDWklNY1NiWE82OEh0Q3ZobEZwTmtYRzBYdmNXR3dG?=
 =?utf-8?B?SWFiYXpXWmp3ZGIyUkhndGNSdXRNa2tlcXNEcURJTFdHWXNFblh0NE0rZTBt?=
 =?utf-8?B?L1dFUUVRY01UMzdiNEtPZWVkTnNYQko5Q1B2UlZ5NTFycXFqZVRibjZ1Y3py?=
 =?utf-8?B?R2wrMDhoTy9KSEVrVnJvSDN2d2VZa1F5YUVkdktubGdRazgyZUd2MXlnbDgz?=
 =?utf-8?B?cmE5SzR4M24yUGVKVHlCdVJ4QUExVldkbEgxaXQ1cndHUTJNdUpjRGh3Zyt3?=
 =?utf-8?B?WHFlczBIVGtYY29Dckttck5md1JCdHJxaU9Nc0hHOE5tYklSRjFadFpKZXJN?=
 =?utf-8?B?ajNJN2JuTlFMK3V3cktLUFoxaEdJaGhDdHEvVFU5Rzl0TmJ5MHFwZmFaN1hJ?=
 =?utf-8?B?azVMWnpjL0pqTTVxTjlwMllKbkpmZ3phYUlJL0QyY29lY1ZPaEFnd3NTaVc1?=
 =?utf-8?B?V3dhRzdlS3BKeFpFWmZwdXp2U01nK204VXNqVnNGZjNJOFE2K0RpZ2lsYW5k?=
 =?utf-8?B?RkZsaGpwQStiSW5QTGRrVDFYYzlVRS94Mm9HZHVFUGZLRHdKV3pZMG1hVWE3?=
 =?utf-8?B?NFZYcVZQMHJocXpUL3ZDVW1xQzJwSldIOHFUZTRiVHRWc0dsV1FKakNOaGIv?=
 =?utf-8?B?TFJicFBzemJJR0kwbkZMV3A0R014dUdZWTBUMS9BTk1Jb3hQTVFNL1JyNDRx?=
 =?utf-8?B?N0N6UzM5Zlo5ZEEyZlcyZEtyMUZuLzRTQWh3K2R5T2tTZVZBWVAwNjVkNVox?=
 =?utf-8?Q?FZ6spuXuS/SBdKwY=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0141e4f-8acd-4fbc-678b-08de64f0016f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 19:51:51.4246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hbC5VbouT2hMIf9JWVwewnsjIq/rbtMSmzMvWciI2u0m+l0B08jRfv1z3WGVD1nkoRPWvReTGLXu3mizD45ERjEqwRX49ONOIqlbkD6+awU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR10MB9504
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Feb 2026 19:52:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21841

Hi,

On 2/5/26 7:19 PM, Prusty, Badrikesh (FT FDS CES LX PBU 2) wrote:
> Hello Jan,
> 
> I have shared my changes as an MR for the debian/master branch here:
> https://salsa.debian.org/debian/swupdate/-/merge_requests/34
> Once it is approved and merged, we can look into backporting it to stable.
> 
> Many thanks,
> Badrikesh
> 
> ________________________________________
> From: Kiszka, Jan (FT RPD CED) <jan.kiszka@siemens.com>
> Sent: 05 February 2026 22:27
> To: Prusty, Badrikesh (FT FDS CES LX PBU 2); cip-dev@lists.cip-project.org; Gylstorff, Quirin (FT RPD CED OES-DE)
> Subject: Re: [isar-cip-core][PATCH] swupdate: use self-built 2025.12 for Debian Trixie
> 
> On 05.02.26 17:37, Badrikesh Prusty wrote:
>> Debian Trixie ships SWUpdate 2024.12 which has an issue: swupdate-client
>> ignores the daemon's RuntimeDirectory setting and always uses /tmp
>> sockets, causing IPC failures.
>>
>> This sets PREFERRED_VERSION_swupdate to 2025.12 and enables
>> SWUPDATE_SELFBUILT for Trixie. It also adds patches so control and
>> progress sockets are created under /run/swupdate by default,
>> matching documentation. swupdate-client now uses these sockets by
>> default when applying updates.
For this  the TMPDIR env variable exists or the Kconfig switch 
CONFIG_SOCKET_CTRL_PATH and CONFIG_SOCKET_PROGRESS_PATH.



>>
>> Closes: #135
> 
> What's the state in Debian? Did they refuse to fix it in stable?
> 
> Jan
> 
>> Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
>> ---
>>   conf/distro/cip-core-trixie.conf              |  1 +
>>   recipes-core/images/swupdate.inc              |  3 +-
>>   ...date-as-default-socket-directory-ins.patch | 49 +++++++++++++++++++
>>   recipes-core/swupdate/swupdate_2025.12.bb     | 43 ++++++++++++++++
>>   4 files changed, 95 insertions(+), 1 deletion(-)
>>   create mode 100644 recipes-core/swupdate/files/2025.12/0001-ipc-use-run-swupdate-as-default-socket-directory-ins.patch
>>   create mode 100644 recipes-core/swupdate/swupdate_2025.12.bb
>>
>> diff --git a/conf/distro/cip-core-trixie.conf b/conf/distro/cip-core-trixie.conf
>> index b133bbb..4ed2461 100644
>> --- a/conf/distro/cip-core-trixie.conf
>> +++ b/conf/distro/cip-core-trixie.conf
>> @@ -12,5 +12,6 @@
>>   require conf/distro/debian-trixie.conf
>>   require cip-core-common.inc
>>
>> +PREFERRED_VERSION_swupdate ?= "2025.12%"
>>   PREFERRED_VERSION_linux-cip ?= "6.12.%"
>>   PREFERRED_VERSION_linux-cip-rt ?= "6.12.%"
>> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
>> index 00e972e..c9dbcde 100644
>> --- a/recipes-core/images/swupdate.inc
>> +++ b/recipes-core/images/swupdate.inc
>> @@ -42,10 +42,11 @@ SWUPDATE_SELFBUILT ?= "0"
>>   SWUPDATE_SELFBUILT:buster = "1"
>>   SWUPDATE_SELFBUILT:bullseye = "1"
>>   SWUPDATE_SELFBUILT:bookworm = "1"
>> +SWUPDATE_SELFBUILT:trixie = "1"
>>
>>   python() {
>>       base_distro = d.getVar('BASE_DISTRO_CODENAME')
>> -    if base_distro not in ['buster', 'bullseye', 'bookworm'] and \
>> +    if base_distro not in ['buster', 'bullseye', 'bookworm', 'trixie'] and \
>>          bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')):
>>           bb.fatal(f'Self-built SWUpdate not supported for {base_distro}')
>>
>> diff --git a/recipes-core/swupdate/files/2025.12/0001-ipc-use-run-swupdate-as-default-socket-directory-ins.patch b/recipes-core/swupdate/files/2025.12/0001-ipc-use-run-swupdate-as-default-socket-directory-ins.patch
>> new file mode 100644
>> index 0000000..e87c8bc
>> --- /dev/null
>> +++ b/recipes-core/swupdate/files/2025.12/0001-ipc-use-run-swupdate-as-default-socket-directory-ins.patch
>> @@ -0,0 +1,49 @@
>> +From c89f62d0a68e5c45e3f052edf6c3d77bba8c67e5 Mon Sep 17 00:00:00 2001
>> +From: Badrikesh Prusty <badrikesh.prusty@siemens.com>
>> +Date: Tue, 3 Feb 2026 11:25:18 +0530
>> +Subject: [PATCH] ipc: use /run/swupdate as default socket directory instead of
>> + /tmp
>> +
>> +Change the default socket directory for control and progress IPC from
>> +/tmp to /run/swupdate.
>> +
>> +This aligns with systemd conventions (RuntimeDirectory=swupdate) and
>> +the documentation in `doc/source/swupdate.rst`. It also improves
>> +security by avoiding world-writable /tmp and provides deterministic,
>> +predictable paths for both daemon and clients.
>> +
>> +Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
>> +---
>> + ipc/network_ipc.c  | 2 +-
>> + ipc/progress_ipc.c | 2 +-
>> + 2 files changed, 2 insertions(+), 2 deletions(-)
>> +
>> +diff --git a/ipc/network_ipc.c b/ipc/network_ipc.c
>> +index 099587d4..e167d0b1 100644
>> +--- a/ipc/network_ipc.c
>> ++++ b/ipc/network_ipc.c
>> +@@ -32,7 +32,7 @@ char *get_ctrl_socket(void) {
>> +                     socketdir = getenv("TMPDIR");
>> +             }
>> +             if (!socketdir)
>> +-                    socketdir = "/tmp";
>> ++                    socketdir = "/run/swupdate";
>> +             if (asprintf(&SOCKET_CTRL_PATH, "%s/%s", socketdir, SOCKET_CTRL_DEFAULT) == -1)
>> +                     return (char *)"/tmp/"SOCKET_CTRL_DEFAULT;
>> +     }
>> +diff --git a/ipc/progress_ipc.c b/ipc/progress_ipc.c
>> +index d3689271..382a83c9 100644
>> +--- a/ipc/progress_ipc.c
>> ++++ b/ipc/progress_ipc.c
>> +@@ -41,7 +41,7 @@ char *get_prog_socket(void) {
>> +                     socketdir = getenv("TMPDIR");
>> +             }
>> +             if(!socketdir){
>> +-                    socketdir = "/tmp";
>> ++                    socketdir = "/run/swupdate";
>> +             }
>> +             if (asprintf(&SOCKET_PROGRESS_PATH, "%s/%s", socketdir, SOCKET_PROGRESS_DEFAULT) == -1)
>> +                     return (char *)"/tmp/"SOCKET_PROGRESS_DEFAULT;
>> +--
>> +2.39.5
>> +

This is a SWUpdate upstream topic and not a Debian or CIP topic.


Quirin

>> diff --git a/recipes-core/swupdate/swupdate_2025.12.bb b/recipes-core/swupdate/swupdate_2025.12.bb
>> new file mode 100644
>> index 0000000..d53545e
>> --- /dev/null
>> +++ b/recipes-core/swupdate/swupdate_2025.12.bb
>> @@ -0,0 +1,43 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#  Badrikesh Prusty <badrikesh.prusty@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +
>> +inherit dpkg
>> +
>> +require swupdate.inc
>> +
>> +DEPENDS += "libebgenv-dev"
>> +DEPENDS += "libubootenv-dev"
>> +
>> +DEB_BUILD_PROFILES += "nodoc"
>> +DEB_BUILD_OPTIONS += "nodoc"
>> +
>> +FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files/${PV}:"
>> +
>> +SRC_URI = "git://salsa.debian.org/debian/swupdate.git;protocol=https;branch=debian/master;destsuffix=${P}"
>> +
>> +SRCREV = "1fa1ce0c85423f228529d2fccbe8813f07040536"
>> +
>> +# patches
>> +SRC_URI += "file://0001-ipc-use-run-swupdate-as-default-socket-directory-ins.patch"
>> +
>> +# Disable cross for arm and arm64 on bullseye
>> +# with cross compile we have a unsat-dependency to dh-nodejs on arm/arm64
>> +ISAR_CROSS_COMPILE:bullseye = "0"
>> +
>> +# add cross build and deactivate testing for arm based builds
>> +DEB_BUILD_PROFILES += "cross nocheck"
>> +
>> +CHANGELOG_V ?= "${PV}+cip-${SRCREV}"
>> +
>> +do_prepare_build() {
>> +    deb_add_changelog
>> +    cd ${WORKDIR}
>> +    tar cJf ${PN}_${PV}+cip.orig.tar.xz ${TAR_REPRO_OPTS} ${P}
>> +}
> 
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center


