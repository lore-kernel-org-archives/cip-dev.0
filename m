Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFF4D0E6D0
	for <webhook@archiver.kernel.org>; Tue, 25 Nov 2025 12:29:49 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15678.1764073787790406270
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Nov 2025 04:29:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=A/F008zE;
 spf=pass (domain: siemens.com, ip: 52.101.65.53, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqFOEnHDg2jPpPXMEV0FnP1GT6HAsFDyhH1bQ0fxAqzlWOQpV7g6BF/Jg4CHqHpwT8pNnQxNhbQRVYD+4sfdE7IRgWpfsjt1jYiG0+gOWXOIWKusP/9jnDtx07XfgiLSD+Dy0fWVEjjw9KmfirCGLHcM7xFOtBzwgcUKaoC+xwtXtEzloJv5x7cCX5RT45KbTYPGk58r0qiZwWO+VGVZ1S5x3+jYP2b5fFhYaMFqbjpUzEAL9mvtzyJUd9eAlsqIaYX2AOVlDxXEkEbf7YDFLf9hQlyV7N3Kofoi37tY+2nO2FWALccvmLQAgHjf08xouCSxMlYz5X1n+hvd2GsQUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36G8YpE6ZzoXZReqL+eUKs3rw9lRD372TbFZw9aTQhw=;
 b=xPttCJcVQP0FKz0j4RlDNAhfbRTLtp7wz7HlX1qjbZGPfnXobvjqPC0h5nyhne8aBPhAbJu552RNMezE47BVdo8TdXSR/QoIuW4qUGjsCXdkkc381PSKh2bq9jFApraQJXokDvDcT89lxcRBzbHpRq0IasaCoflhTfs26IwDn5x60VP9DEVpFIl18BbNVuWXlQ9bkbOpjbjL+N5dTdJiEVnkzn4VaPB9BPtnzIZJSIzVAamGIHgf7w5u8GjN1g6LhtbZyWZ+h9x9TaAJZW1OMLmxYeaLQBGbVwQt+Ib32KIrRtwfWfWg1YhN0MnXcB2GKacfkKDFCUwonnH/FIAPEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36G8YpE6ZzoXZReqL+eUKs3rw9lRD372TbFZw9aTQhw=;
 b=A/F008zEOBrkc0sDDUpWpkbLmj+5YGAX9HSoqjiHjmeaSnPv75pjIK45tRhC7K15sJd4sT+bUn5l8YH1Lb1nOCTmDGiNJlxr0zry70l1XMQC2i7wdb9Tx55ua6wdcfx9Yyhy+HJ/zkYFps7bkmnBzKTuN4zTHNagJ3SzOD4Y5A25sIPPPzE/kX9dxI4sl93Q/V44a9I4uP+D1sTqaPbTik9jYmzXTaHJV77USaWbGgxYBMzhMkhKDkgnUIq76pjnjIbACIq2NnEe6DIvJYzLWX+boX6e4n3sbHd5DFla31WCQCsbYggq4vNiF4C5+zAs93a+kcpkE5QLBa1Ik/Xe6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB8086.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1da::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 12:29:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 12:29:43 +0000
Message-ID: <d0b5fe55-f030-487e-b75b-a7fd9d761648@siemens.com>
Date: Tue, 25 Nov 2025 13:29:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] fix(security): add libpam-systemd in
 Debian trixie
To: "Singh, Gourav (ext) (FT FDS CES LX PBU 2)"
 <gourav.singh.ext@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
 "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
 Kazuhiro Hayashi <kazuhiro.hayashi.f74@mail.toshiba>
References: <20251124050607.876836-1-gourav.singh.ext@siemens.com>
 <345f8c1e-0166-4946-893b-02dba9dd71ce@siemens.com>
 <KL1PR0601MB4697CEAF6AACC78EAB99E5CBD5D0A@KL1PR0601MB4697.apcprd06.prod.outlook.com>
 <e3ea7e4e-7679-4ddb-9074-fab4f51c8c8a@siemens.com>
 <KL1PR0601MB4697F954236371E6E07F0C35D5D1A@KL1PR0601MB4697.apcprd06.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <KL1PR0601MB4697F954236371E6E07F0C35D5D1A@KL1PR0601MB4697.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: dfcc9d48-5ebd-478e-bc4d-08de2c1e4fdb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aWlTRjBmVXhpZVl5NlBUZ1ByeTJOOEhOODh6dEJGcWlrblRsMWpXS3E5bk9a?=
 =?utf-8?B?WXhnU0RUQ0RlS3AzMlhrL2xmNVJzdUJqT1UyWm1oRWp3aXphZmlVYjhCalFC?=
 =?utf-8?B?VHBHWFp0RFA2eENZR2h6UkU2RjQxT2ljRzZPRWJaZGdBZWdXNkJSM25LNkgy?=
 =?utf-8?B?L2xNN1hJQzRrTTBPOXFRNVJseVc2ekszUXhPQkh1YkNCRi9vcW01VzF3NFpa?=
 =?utf-8?B?NDJEczJsaGJFYndneXRmRUtkSkEyZHhaQmFneWhZd3ZTRjkxck0wSTlRTFJw?=
 =?utf-8?B?T0Y5N2FKUmErbTlsc0tJcUx1VW04Tis3NWFRbm5Tcko1aTg5M3YzZE5EQURC?=
 =?utf-8?B?VnpScC9hOGd2NXRDWFdDYXAvTmdjc25LajFkZFY2RmsxL0ptcEJiTGV4ZXlW?=
 =?utf-8?B?V2s3UWpQQzVWaWN3VG1SMEVpUzhDU09HeWZmaUxJalh4a1BnT0xsbllROXBN?=
 =?utf-8?B?S0lXaVd4ZzBuRWp2VTlTT0hwcW9XRSt6U1A0U2RIWWtWUHRtTUdWWXJGaVBw?=
 =?utf-8?B?Z1FwcmlRdFU3aE1qRzJGdWF2VFdXcVNGbjBTRzN6QmVsVUlqblV3SFdjaXFI?=
 =?utf-8?B?azIrSHBEaWdCMVJlUWdMUWRYaXpNemQwdTEwM1laelNackxtT3RBU0orK2da?=
 =?utf-8?B?TlhFWktVRGZwdTM1TkE1Ui9VcjRHUjdRWmx6NHJQbFJ3a1NzRFFsSGc5Mk1u?=
 =?utf-8?B?c0lXM3hVQTl5Zy8xWG5IckpCanhISHZTME8yMEU1TnpmL1VIMWpTVjVlOTFF?=
 =?utf-8?B?WEI5L0daQUZjY1pSdVllUlMxNDdvWlBzUWtVMzE2NnVTYzNyaEZwZzcrUFQ5?=
 =?utf-8?B?bnVOYzZJZ1U1VitsSjlOTGVQUVFKNjlzZFF5TDhvU1R6Z2tSWmp2RFhzSXZN?=
 =?utf-8?B?dldSQ3dMVDZINkM3bUhhbkJieExzcnNJMTZmVysrMU9ZdXJzbjlOMnV0Z1cx?=
 =?utf-8?B?K1R2aUZjQmN5Q3Ivd1lLUTdnRi9HRFYyenZmNld0eTVmdFIrVmhJUlM4KzRJ?=
 =?utf-8?B?clB4UkJYQlQxL3ljTUJnVXExVGxndnFpVEtKY0NjNHJ6dHdhUmhHejM0UWMz?=
 =?utf-8?B?NTIrRldselZ5NHpWcjE1N1hPdFBqUWJRTTNGK0RYRE4rZ2FadnFER3FHY1c1?=
 =?utf-8?B?WEo3Ry8wa1JoNEtISGJ5anVtWTZXM2U0Vi9STHpoc3BkSExrQWdZdEo0bzNT?=
 =?utf-8?B?dDFoOUxsUFhVTlNESjV5NlZRd2JacU51dTZhL2R1SURsNVlyeWRyem54eUxy?=
 =?utf-8?B?TXZpV1ZySW9iQmN5SE9ZOEE5RFY1TDJmL2RYcDkvV1FSVjFDMjVUeFh1anBv?=
 =?utf-8?B?V0ZzZ1dRZi90aG5UMTVJK0V1anVEZEs4ZXYvOG9KVnFMNU1VdzVnSHlIWGRT?=
 =?utf-8?B?MkxKUlZudGh2NVpnM1dHcDBWTFh3OTZCVjdRNWFrTHBkalJWRHVvNlZGSkh2?=
 =?utf-8?B?c0VnNDliT2phYjVRa1lXNEZ4RE9VNStvK3ovcW1tQjZsTjFEUmVja3oyWFJi?=
 =?utf-8?B?L05mWk13ZUIvYTY3SGNDMnF3NFlhSGVQV0ZpZkNuL3NZdGhUS3BRZ1hTVEFj?=
 =?utf-8?B?WmFsNFhaMzJCZ2lDV2VIN0JIYUtQM0N0bjNZMldtc2tBbEpUUXJkcXh2VDhy?=
 =?utf-8?B?Z1dKVXM3N250SkRoVmhhN0NkWmFFTnZzQkxzQUhPbDIvSW1MYUpqdWhERjQy?=
 =?utf-8?B?VDNjT1p3OU1nUnIybWVHNkl6YTY0dzN3WEtadXFVZTZGUTd2RnRIaTVNMHhQ?=
 =?utf-8?B?bGk2M0FydkZNMEZPQ2hadHRMWVJrc2FBaXRWMmV5bTZpUGRsNHBoa1VWS3Q3?=
 =?utf-8?B?RXlqL0pRRVFTUmVqQ0dEZTZQVldoQWRDcjVoZFlQclIxbDhJOGdIVFZ5eElD?=
 =?utf-8?B?endOOTY0TWt3M1YvMnpiS2lKK1dUbjUyTGE1WkNIaVlSVDNoUm51SDU4SGU2?=
 =?utf-8?B?Q0w2RmhEUmRvRjlCOHZtWjg3ZkhvZjVtNTVBQXNQQ2tvMjUva0tDMTZpeWQ4?=
 =?utf-8?B?M3FlZW5weUVBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TkZLUU5RamZlcVVWeDc3UTN2RlhvRnhVVTVDZ0tJaTJUSjIvRFREODlQSVFy?=
 =?utf-8?B?VHFRcVlvU1lkM1hvOWs2TFVuRndIN0xSVnc2MlFsUjRjbXZES3lEbEZ6UjUx?=
 =?utf-8?B?OExCNjFzYi9YbHJFZFRJSGwxTm1aSzBIVnNEYlhFdGdNQTRoMHZQM3NoOE8w?=
 =?utf-8?B?OU8xbDg1aGp5Mzk5czFsQ3lURFJ5VER1SlMvR0NQYjRjTWt4YjhEdTgyQ014?=
 =?utf-8?B?emRpdytZNXIxdUdtU0dhV2RVSStLaUZMaXNabENEc1JzUDdtZFlZNm5aSXlJ?=
 =?utf-8?B?K3ZEYlMwY2JHRmlHeE5JYkN1OXA1NFI1MWxjRk9Cd2txdU5lTi9oU2JKMEo3?=
 =?utf-8?B?K0xES2JZQXdmTllmNWw1TmxpMlVIRXNQWURHbmpVbHhGUkpDWk5VdzM0cW5k?=
 =?utf-8?B?Vk5rbDJlU3JIbWJLY29tdTk1NVpGVFJMcUZNaE5zWVdwaXg3cTB3TnVpNHl4?=
 =?utf-8?B?eXl6Z1pUNWtXeU5GcHFZOXlkRzFEQmVSWXZXYkZyenNLczRpelc1TUR5N0tB?=
 =?utf-8?B?Qk1zYUNoYmhoK20zZ1ZDbGFRejEvTG5Cb3V3RzBQNG9yNGU2ZU5WcGlwdmFr?=
 =?utf-8?B?ZnlDU0VlUEROUlNyMXpjTFdkMkZlOHlKRVJ1RSs5TDRTZXByYUswL3o3OFNh?=
 =?utf-8?B?dUovUzBwN2MrZ3BncndSU3drTFhOS2lVNDNxYWdiTkVmZEpYWHVrakV3ZmUw?=
 =?utf-8?B?NUo2MGVkdXdkSVF6RVJRR0lOZ2pJZTRGMmdvZ0tOdEdjTU5TTkRTS0k1SmQ0?=
 =?utf-8?B?Rk5xcWZUODV1UmNLWUo2Z0xyR1VSYTRvV3pDTjJLcFJ1V0IvUXQwMjExVGxo?=
 =?utf-8?B?S29IdlNRTlA2VTZZcUc3R1NCTVMwRk1majZSSlp3bm1kT0ZHdHZTMlUrNFBs?=
 =?utf-8?B?QW5uMXJ2N0VKdXhJakxiUTZJalpPNW9KN0xiNzJ3aElqRjAvWDZMRWM2SFBi?=
 =?utf-8?B?UVRrektocXgxNXFiOWpzTTliNHZPZ2FXMUZZeFRNK3VmNVYvcHE2STJ6TmRP?=
 =?utf-8?B?ekVsdlcyV3JsUmNXcTlPUVBIWUJxcU12QWc3a2psR2FoWEtscDZDUTQ2a21i?=
 =?utf-8?B?Ry8yd05reVVvWE42ODJjTUVrUkwzZVBTMjliVXUzMFdpTnR6OG9zRHNiOStx?=
 =?utf-8?B?VHlsb3ljem13bDZGU0ZMYmZvN3FlMlVMUWdUTkNlWDRhUkxiOEkyZEZ4ZGtU?=
 =?utf-8?B?dDhPVjU2ejcrZlJSR043T0FoTlBtTUtFQThNdnBsQi9iRU1KTmNPdDhmR1hU?=
 =?utf-8?B?Q3FzaENyTUc0NHREZm1Qa0NSSFR0V1QwalV4SURRUTJKalpsOHNvcWlnclFk?=
 =?utf-8?B?dTZKbFF0RGw0YW1JbFo0NDhlWFZwVzNhUHBTSGhreFAyVGxpbGNPeFh6YjhF?=
 =?utf-8?B?eStZbTNadDh4cmMxM0xFeVRSeHlYSTlkbjBjVEVrSnZQUW5zR1hqOGJtTE9t?=
 =?utf-8?B?YjVkVUoyc3RFUHU4SlBpb2NCaGlXN21mcWozV1VOZ3dQR2RWMnAvOGlpMkhN?=
 =?utf-8?B?c0JpODU4VlpiWTZnWXMvaWFWM1I4QVM4cWJReXJvZ1NlSUpRT2VsM3puZG9J?=
 =?utf-8?B?Rm9EMnYvYlV4MFF2Z3NORUVJR25aYzN6blloVUxUTmNoblRTZXJlUWhFTFR5?=
 =?utf-8?B?eTBhTHlzdWxXVWhpRTJjSU4wcWRKZ1V3ZUJ5RWhIK1FkNEhDYW91bG8ybHNM?=
 =?utf-8?B?ekQrbVZRNnh1T3FsUWJsRzdmMWNSOVhjblZxUEpOS3MxREhxeUpGbzZCVTMw?=
 =?utf-8?B?V3Y5d1JNWThJVU1OVlNtbHRRREF5RFduY2x3SmxhUG92eklhU2x4WUQ0bTFY?=
 =?utf-8?B?a1hsRnE0Vm0wclRzM2dKQ1B6TjUvLzlWa1lNTm9CQjIwM1JCTWxsblpvTEVo?=
 =?utf-8?B?anpsMmxENUJ5MUFtbHIwSDFtWFVnME1sVEVzWEJtSGxnMjdackVQaWtlUUhj?=
 =?utf-8?B?c3A5d252eXBBWWk0MnNvNkMxbU9FZFkySVRMZWRSd3RBMHBZWFlueUhqakFV?=
 =?utf-8?B?K0xaYUU0NFEwNzVPTjdtVGZpQlE0SjhyOWRTVENxUnRYWHNsQW1aM2loSTVY?=
 =?utf-8?B?b0FoZVJNRGI4NEhaU0J2YXRGZy8xMjNRbjQza1RlWm9nMC90cFJUczZZVVJD?=
 =?utf-8?B?V1BxY2RpVTBtUm94T1A3alpxM2xoRnpvdWppSVIzd0tTSklXNGN0Sm9rdFNH?=
 =?utf-8?B?Umc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfcc9d48-5ebd-478e-bc4d-08de2c1e4fdb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 12:29:43.4751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mG2b0PVvjFwznS5c01WZuMHd6bgf5RYOzSuwhyQzaclHG659Zi+QoWYg4DiPyWC6cF5XBz7Nvg5aLJvKAXlwhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8086
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Nov 2025 12:29:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20725

On 25.11.25 12:08, Singh, Gourav (ext) (FT FDS CES LX PBU 2) wrote:
> Hi Jan,
> 
> After applying these changes, the IEC test suite now passes all test cases on the Trixie image. I've verified this on my end, and I'm attaching the results log file for the test suite run on 
> the cip-core-image-security Trixie image.

The patch is now also in next. I lost a bit track when what started to
fail, but we still have a red pipeline for bookworm right now:
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/12206266133.
I hope it is not regressions.

In any case, I would appreciate if people familiar with the test suites
could sort out what the pending issues are. The bookworm-based pipeline
for qemu will stay BTW even when we moved with the defaults to trixie
because it remains relevant for the security WG.

Thanks,
Jan

> 
> Thanks,
> Gourav
> 
> -----Original Message-----
> From: Kiszka, Jan (FT RPD CED) <jan.kiszka@siemens.com> 
> Sent: 24 November 2025 22:07
> To: Singh, Gourav (ext) (FT FDS CES LX PBU 2) <gourav.singh.ext@siemens.com>; cip-dev@lists.cip-project.org
> Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>; dinesh.kumar@toshiba-tsip.com; Kazuhiro Hayashi <kazuhiro.hayashi.f74@mail.toshiba>
> Subject: Re: [isar-cip-core][PATCH] fix(security): add libpam-systemd in Debian trixie
> 
> On 24.11.25 17:30, Singh, Gourav (ext) (FT FDS CES LX PBU 2) wrote:
>> Hi Jan,
>>
>> Regarding customizations or configurations for the `libpam-systemd` package, which provides `pam_systemd.so` - a new systemd mechanism that replaces the traditional `/run/utmp` for tracking active user sessions in Debian Trixie - it is necessary to ensure that `pam_systemd.so` is included in `/etc/pam.d/common-session`. This replaces the traditional role of `/run/utmp` in session management.
>> Ref: 
>> https://list
>> s.debian.org%2Fdebian-release%2F2024%2F05%2Fmsg00150.html&data=05%7C02
>> %7Cgourav.singh.ext%40siemens.com%7C69f7415c2bc3402b8cde08de2b77b21d%7
>> C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C638995990271096290%7CUnkno
>> wn%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXa
>> W4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=zbwdGBW1zzz
>> p3xN5q0UW3qN5o1MXmzbBmJv3uQdILhY%3D&reserved=0,
>> https://ddp-
>> team.pages.debian.net%2Frelease-notes%2Fen%2Fhtml%2Fissues.html%23the-
>> last-lastb-and-lastlog-commands-have-been-replaced&data=05%7C02%7Cgour
>> av.singh.ext%40siemens.com%7C69f7415c2bc3402b8cde08de2b77b21d%7C38ae3b
>> cd95794fd4addab42e1495d55a%7C1%7C0%7C638995990271126607%7CUnknown%7CTW
>> FpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIs
>> IkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=5ry3XapBLPScmMpiz5
>> bdwF%2F9MVx0%2FG6reUH%2Ba5pYxXA%3D&reserved=0
>>
> 
> This all makes sense so far, and if no one complains, I will merge it soon.
> 
> I furthermore assume that our IEC testsuite will "just work" (again) with this applied, right? Switch-day for the CI to trixiw is now Wednesday, or more likely Thursday.
> 
> Jan
> 
>> Thanks,
>> Gourav
>>
>> -----Original Message-----
>> From: Kiszka, Jan (FT RPD CED) <jan.kiszka@siemens.com>
>> Sent: 24 November 2025 12:21
>> To: Singh, Gourav (ext) (FT FDS CES LX PBU 2) 
>> <gourav.singh.ext@siemens.com>; cip-dev@lists.cip-project.org
>> Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>; 
>> dinesh.kumar@toshiba-tsip.com; Kazuhiro Hayashi 
>> <kazuhiro.hayashi.f74@mail.toshiba>
>> Subject: Re: [isar-cip-core][PATCH] fix(security): add libpam-systemd 
>> in Debian trixie
>>
>> On 24.11.25 06:06, Gourav Singh wrote:
>>> In Debian Trixie, /run/utmp has been removed, so traditional 
>>> session-tracking mechanisms (used by w/who) no longer work.
>>> To restore secure and correct session accounting (needed for 
>>> enforcing limits like maxlogins to comply with IEC 62443 CR2.7_1), we 
>>> can add libpam-systemd.
>>>
>>> This ensures that PAM can register user sessions with systemd-logind, 
>>> aligning with Debian's design for Trixie.
>>> See Debian-devel discussion: "/run/utmp is no longer provided in 
>>> trixie ... replacement mechanism provided by systemd."
>>>
>>> Ref: 
>>> https://list
>>> s.debian.org%2Fdebian-devel%2F2025%2F04%2Fmsg00011.html&data=05%7C02%
>>> 7
>>> Cgourav.singh.ext%40siemens.com%7C13545a99022f43a55dce08de2b25d0fb%7C
>>> 3 
>>> 8ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C638995638612273708%7CUnknow
>>> n
>>> %7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW
>>> 4
>>> zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=tNzGl6b239zR
>>> 7
>>> GFA5WPQwQwSi0fRIhXp5hQchE7pxKw%3D&reserved=0
>>>
>>> Signed-off-by: Gourav Singh <gourav.singh.ext@siemens.com>
>>> ---
>>>  .../security-customizations/security-customizations.bb         | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git
>>> a/recipes-core/security-customizations/security-customizations.bb
>>> b/recipes-core/security-customizations/security-customizations.bb
>>> index 717e2d3..d8fa22b 100644
>>> --- a/recipes-core/security-customizations/security-customizations.bb
>>> +++ b/recipes-core/security-customizations/security-customizations.bb
>>> @@ -25,6 +25,9 @@ DEBIAN_DEPENDS = "customizations, sshd-regen-keys, 
>>> libpam-google-authenticator,  # - libpam-passwdqc: Preferred for newer Debian releases (post-Bullseye).
>>>  DEBIAN_DEPENDS:append = ", libpam-passwdqc | libpam-cracklib"
>>>  
>>> +# Append systemd PAM package to limit concurrent sessions in Debian 
>>> +trixie DEBIAN_DEPENDS:append:trixie = ", libpam-systemd"
>>> +
>>
>> So, no configuration needed? And does this obsolete any other dependency in trixie?
>>
>>>  do_install[cleandirs] += "${D}/etc/ssh/sshd_config.d/"
>>>  do_install () {
>>>      install -m 600 ${WORKDIR}/ssh-remote-session-term.conf
>>> ${D}/etc/ssh/sshd_config.d/
>>
>> Thanks for tracking this down. I suspect that our certification efforts are still focused on bookworm as baseline, but this is an important step ahead already. I also hope we can soon switch CI to trixie, currently waiting on lava-docker updates on the workers.
>>
>> Jan
>>
>> --
>> Siemens AG, Foundational Technologies
>> Linux Expert Center
> 
> 
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

