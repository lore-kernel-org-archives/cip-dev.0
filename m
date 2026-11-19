Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11111.1795081678367931879
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Nov 2026 01:47:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ZFYZ2vWj;
 spf=pass (domain: siemens.com, ip: 40.107.162.45, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WfOVhtc34DVfEzvhVhe0UM8pTg5OEZLABjS+7fx0fHOV0ZTpAV3lKGUvR7F0QNHZFGftOGEIgcGBTX5afNOKnAnYdo5Jq4gJtic/SUX5vC+ftNIL/RgzVVno6eiuLeWcscQCMjdbEWP4kQKxdFpm1MSO0cB3qHMtqb+n2CsXZdCEIaCg5O3zV1y9wjbx0iLKq/cWCouXJkCIf6oN2sspqQfMYCYz7BrSTJhkTmxOUNu4J/E2PBDx4f3O1AfrPF/XSaTUVaLzS3Wrgll7nHMV24T5AdfhsUoKsdU59OobUPTY9WJo8iKgyljmrnuBTbtv2SR67uWDza2j1DACAD5Z4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IL/nsRAkIKXivBQgcC20Vz1t+M3mW3Z/5XZupANOc9Q=;
 b=YXhNsMmS7UlsqFWZDckMEiK6Qcz8emEeDSU6ehOhsaS08BN2SGMfYiYJ2RPtg9vBQbZq5zTawNBUVq6NyvKwUsBrLxo+7+9ea8mUEfYNjuFJIfaf3lwNhvoKC153B71ddDTmN0Go45LsO3R8My/rXESvf+noigc6PlJwGHTNibiRIlHyDysoNlpgR+Ubkjid8ccCpsB8xuDgKWsKR8TBVbal8x8xS7Ue8EeI7H8ir7nTJrBceDPjY9Ng8j3QTcCMAvNULDGBYLeaPl87vKNf9TiwfVqyTGkXBvqUiZqfJEtLwl0NkiST+lSnwMZOf0ZzZtWAQvzpfGHJLQn+D7LGMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IL/nsRAkIKXivBQgcC20Vz1t+M3mW3Z/5XZupANOc9Q=;
 b=ZFYZ2vWjTB3+XO/fVFmPgMcLC0rlicQIoxKhuwRL0xpfGp2wefTmcpxI/12B1h/f7mZ33JNFtRmGfiBQx0r/X92y1CYZ5cVATCHGDUnO3c0e6vz8rUUpyxICQcMFIkqXUXjoww5tZqkCs6nSv5OR/xAzxeJOs9QX72pyNG9bkm0hQ7LA+WvI6UkAnK/JXHUpUnrEUwyxwm5AxIU39yoflINTLiuoTUnLEY5cOyaYTqEpnAwkRTz6S9yICHXa995cm0orf/3RJGZdkPid8iv45aFkI44pT0Y5ijm1w8HmEuvkLvt4K7cpVsXzIP7uuT4mLOmLtDYYpOBpv22yTU+sqg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by ZR6PR10MB130213.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:910:e8::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.1; Thu, 19 Nov
 2026 09:47:54 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0639.006; Thu, 19 Nov 2026
 09:47:54 +0000
Message-ID: <9eed115b-9ea6-4624-829f-3843c607abb0@siemens.com>
Date: Thu, 19 Nov 2026 10:47:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip116 and
 6.12.118-cip136
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
References: <e6cb733e-e8ff-436a-be3f-10d15ce6dd02@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <e6cb733e-e8ff-436a-be3f-10d15ce6dd02@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::14) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|ZR6PR10MB130213:EE_
X-MS-Office365-Filtering-Correlation-Id: 279ccf54-bc6b-44e9-dce0-08df46222ed2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|55112099003|6133799003|261009223027099003|18002099003|22082099003|261021121427099003|261021123027099003|56012099006|10067099003|261102123227099003|11063799006;
X-Microsoft-Antispam-Message-Info: H9H2cmH4M2ND97Y6b/Ipm4TQYI78eKDZFv8xJKPNmar4fzkPSP7v8bBhgWuG2K5NSWerkWq2GeqTeSUIxL0P28A9I3FkBPRTprUjkA7SzI5F68xATXpSqA3Yk9DblpHFwTf3WP0zdjLGOnHFIKW8ZWsc/bNUoRKKmu49UC2sEcfo83wfM/nSy/wRwn3Kdfy+G1oHBfi5BHw7OZu5hfXLz+H5hR2bymCpgNcRtBwi3IIdSPSMqcY1aM6TYlQk4bUYLTQybpll4TvBLwrs5JECLjifPy4T9ser9vw4+R726HKQtyXpJzZwydGXsTDVExNGM2LCR7P8oSuLnMnuSra/QIqHDk8hbcntaVhR2Bnud88kHObl3CNJHC6/qH/frT3gtpFjTe0QmPeUHvVs3tojihxqkzxmln/JtEsCzx++pGg3zhnBEnyuyuX07Uc9Ftsm/d7uoyyJkpZ/vD6BxVoY3+8/5sLvrjkiGbCTKvmFOMXODgfbVbI+IfuxW64EunozaxMmYpi8I/VejOwJ+wrnS2loFo5KnwzzKfELOR5PMWurqiPyYkST4LguoTxzIqBmxQTw3z2/vhNbXATJMUEf9h3GEwGMRW2ObY0I+IxvLQiwpqPyAkyA1srSRqsmAfoBYpP/f6CSXgngiM3rxrLrKYnLh5gjJ8WuHdSwYymtwio=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(55112099003)(6133799003)(261009223027099003)(18002099003)(22082099003)(261021121427099003)(261021123027099003)(56012099006)(10067099003)(261102123227099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SllUb0NLa1lDdkZpNllHV2QvQWxuSHhCRzljMUhhby9qd3ArbzRlRDlWMHFp?=
 =?utf-8?B?SlJqTHh2UXZRaUdwbHhtcmZhVzRoWVdaNGg1eC9FbXc3aTg3OTdCZjdkNWxv?=
 =?utf-8?B?K2JSanBsMm1pTEp2L3g2QytXRnFIUk9tN2VZZUd0VGZsa0tteXI2VWxLYlNI?=
 =?utf-8?B?TlVSYTMybFhZMmRrZ3NvV3QzWDQwN2NUZnlpS0tyWkNEZ25acTZOcHRlWlpQ?=
 =?utf-8?B?VUxKVVBmd21YSmVOYXB6MFBsQlZsMzRtWVh6Q2xvQmNPQnNzOXV5Mnd1UjFJ?=
 =?utf-8?B?bUx5M1YvVEZ3dzlTT2tOaXhFN0w0clJlL0tLOGJtSVdmblhrNHRUMU5mcHlG?=
 =?utf-8?B?bVJvN0M1MzBVVllxOEdaOTd6Z1JzaUswVGlPQTRxM0VyWTFiazBDakplU1ll?=
 =?utf-8?B?ajdPRGNmM1dZMnZlRk8rS2I5bndiUytMUGhNNWlOZTRzbU9LdmIwTTRlNEZX?=
 =?utf-8?B?QjZsbEUxT3pWc2xKSmxuRVVrOUZqWHpubWQ3NmdBNWdaSkM3SlVYRXRaclQ1?=
 =?utf-8?B?aVhPSUY0RWszT0ovQU1hMTZ5QkZyaDhQZkdkM3NXZ25HV0cyckJHalR1NEJU?=
 =?utf-8?B?MktJa0NnUU5kREFpYURzUnpyZjF0UEV6TGh0ckIyZlBoWGZqcXdMUzFLUXcx?=
 =?utf-8?B?Yk9CZ0c3NkxJSzRnMHNQREk4VjF3dnZMcWVyRzE5bFZFeDdOOVdyMWtKRjhH?=
 =?utf-8?B?YXpzZGtkOHlHZ05SUWQ4ajZWd2ZjR1NSOHZVS3BHdGx1TXFFR05DaXpOa3BC?=
 =?utf-8?B?UzhoMHRiZTJDWVcvcDZ6SEJTNFZaUVlMODBxQ3hka1RuMmpUcURBMGl6b0Ro?=
 =?utf-8?B?SmJ3VmpxODBRUjRLd0xaaUJ3ZkxMYTkxbmVqR1hHSkpvU3Fqdy9hVlZFTkdO?=
 =?utf-8?B?Z1o3K3haMTBrSDlDL1h3YStkbkx3WlRLei9oSWdMZm53M01aMmpkVVMwVm9u?=
 =?utf-8?B?aHJKOS92cVA4NSsyYnFHYWNRb050WjNrMXgwMHJiUm5xdm9oMFRHc2psTVFx?=
 =?utf-8?B?cC8yWjBzdXIwc2c2WVRmbUdwOEN1MVpyN3NUWlEwWVBGMDVNamIrZXZyc1Fz?=
 =?utf-8?B?Q0FreFN0MW9XdGZHSTA3dnpPZWdSZGt2Z28xV1p5WnZhUlBRZ3lWZ201b1VT?=
 =?utf-8?B?UWRLZmplcHhKQnFTSGFEMWszeTgxbkZKcHdpTnBQUEdzSGxtY2JDNjlyZVFm?=
 =?utf-8?B?KzRpWklrb0NHb3ZiTStsb2VHRG12d2pCWThGb1prUjJjV3VaZS9mbHZmb2FC?=
 =?utf-8?B?VGtuLytjYjg2TlRFN21FSVk5VVFMWjJnQUV5MzhnT1VrWTAzeUJmR2R3OXdZ?=
 =?utf-8?B?MDBXUUFDejl6Z1pEVFN0RFZwWXhCTWUzN0xKR0tWcVgvN2pZMWw0UGV4UU5N?=
 =?utf-8?B?cFI5eEh6TUwwUC90QWRIWGZRK2pqNWhtMnpvdS9Hdi9ZM21mUjFMMG1UTWJS?=
 =?utf-8?B?Y2plR3p4djhtYXdYaWgwNlFFVkxucVpPOEk5YlBheVBlZ3V4aGVFZDZnZ2R0?=
 =?utf-8?B?ZllCMzNMbHF5Znk2VFloVUR5MVZBb0dKQnU2T0p3bSt1anU4REY2Z0UwUHRC?=
 =?utf-8?B?RXJOeUwyWmxnc09YQSs5a1dqdG5aK1RlRWNocDdRRHhXRWV1d3k2UUJZQmg5?=
 =?utf-8?B?NGRWN1dkQ28wNklxaVF2VmZodTBEMGlNcEtocWxta08wRW9XeUJnUWNPd1NL?=
 =?utf-8?B?QjgzbFM5NGZHQThYNXJTWXJLT01tKyt2ZnN6elNnNlIrc1F6eUdWdjlqY2Z1?=
 =?utf-8?B?WWR4NERpY0NPTzZsaUwxVHIvT2p1KzQrbkNSMVkxbXJMeVpEZGdKT0FtQWt2?=
 =?utf-8?B?SFhMVHJESEYxekxPNXNSS2UrQmdNdTFZem9pOHFCemJucWFPSVpmQmFFWXMv?=
 =?utf-8?B?ckxSU2UwWVgyMDFBRUp1aWZ1dGQyY2l0VVJYYlZYVExVMi9na05jYlowZzBk?=
 =?utf-8?B?clJ3OUVJbEx1dTJXVkJJKzdTR2VZbDFhWkxrZlpISmZuNWxGV3FIU2lGS0NK?=
 =?utf-8?B?K1IzVmtERU5EdGEreGkwT3Y1UEFKNUFNU0VVSmdlaWJRODVtZWFsb2JXVEpx?=
 =?utf-8?B?dXZmeldoOW9FOUdmenE4aFJ0aHpUd0NjdEVLdjVwUm14QXRRWm9wdTZzdVo1?=
 =?utf-8?B?dFE1WFdhZVp2TWZJU05OUVRrTkhYR3ZjL21KVDJPZFFNVFBvNDM1cVEvcldH?=
 =?utf-8?B?aDVSYjlMUlFiV1ZUTUN2R2ZsM1lRMldneE5iVXJNa3huRjFjMFZkczZjV2pC?=
 =?utf-8?B?U096RVphYjJBZzJvOENRWG1jSVkraXF1WUFLY3UzdUZ6Skp5RURLN2JlOUVU?=
 =?utf-8?B?dE9kcjNyaVA5S2d4YUNYOEZXVDVZd0hSV2pTNGtUUkNTSWcyRFd4Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 279ccf54-bc6b-44e9-dce0-08df46222ed2
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 09:47:53.9343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SBCUCSB5/AbnDrxIaVGp6NOtQGRfz2lXBpLAq2Qg4M8N3q5Dui4uKkuNHJhswsW2HJUjpwKI8pTp2QBdH7GKAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR6PR10MB130213
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 19 Nov 2026 09:48:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25011

On 19.11.26 08:59, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  recipes-kernel/linux/linux-cip-rt_6.12.117-cip35.bb             | 1 -
>  recipes-kernel/linux/linux-cip-rt_6.12.118-cip136.bb            | 1 +
>  ...{linux-cip_4.4.302-cip115.bb => linux-cip_4.4.302-cip116.bb} | 2 +-
>  ...linux-cip_6.12.117-cip35.bb => linux-cip_6.12.118-cip136.bb} | 2 +-
>  4 files changed, 3 insertions(+), 3 deletions(-)
>  delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.117-cip35.bb
>  create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.118-cip136.bb
>  rename recipes-kernel/linux/{linux-cip_4.4.302-cip115.bb => linux-cip_4.4.302-cip116.bb} (68%)
>  rename recipes-kernel/linux/{linux-cip_6.12.117-cip35.bb => linux-cip_6.12.118-cip136.bb} (59%)

Holding back - the 6.12-cip release was mis-tagged.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
