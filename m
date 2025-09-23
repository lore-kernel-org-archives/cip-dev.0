Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17900CAC5B0
	for <webhook@archiver.kernel.org>; Tue, 23 Sep 2025 10:54:31 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.2])
 by mx.groups.io with SMTP id smtpd.web10.13899.1758624861164981468
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Sep 2025 03:54:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=w7VxJRUn;
 spf=pass (domain: siemens.com, ip: 52.101.84.2, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHjgUrGLzx/Ef4TQcQhbmwExr5KASObel3jXF4xGqSGaaqEd7FBZKMYyrHo3nJH5KJsypFGxihyMbAgtxFJK+oFy15P6X94gmtzLOduhrzin9m44zqIym3bfYgwGJ4J81Me2FS9G5v1kvO8rRn8W5skb5bxYQEPSrVYPrz5YDdAletoFX/ObKA4K4fxM/C5fJDCxBgdU3bcscI+agalngB91sEAsbD8b8BMpPiRV3W5u/Nwa/2pcb8SqRELydSwQ29qi48mnG2CrQwwo/4vG1BN4QMMHXhE2mg1lWmU5r3MVQnB3ToVjMUN7Ns7/nwlnkJRowYWiQxB5mfoQ5tCevw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KW4fJVUdrJIIm3IxmLDHglssabDomwDicDcAwebdyJk=;
 b=EzCumvVxd0h+ny3xhwOjXsDE2cJIHqCBFBgMJ8KVlr63QHPsVx9vy2KPqgV8INQhSfVnmXNIWlJjhHXotcPi7RVbheiBtCuVFaSbIETPItfqyb1Lj2WkxtNscX+55hzj31Msn9TD/KcT4W2e2G/ACEOUzU1gp8WbJWwGAAHPGBLYcjTIpeGZgO4mihiQJsoWqhhVOqhWPHJkkasvBNTlBaSWDulGxLY3pIe4vdHJzlQ5IoWZTrRE/6ctiKWQ6wIEav7c6M1zpa32gXVj5X/d1FOLFIo/Up0wy1dbq4Z3ZhtO/Rb1iuLJboccJZXA+wl737/0cUQr5NHzdc1xy8KwWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KW4fJVUdrJIIm3IxmLDHglssabDomwDicDcAwebdyJk=;
 b=w7VxJRUnHFWm8Twm8sHFV6reHhE/aFfOvvdYsvviP9El7OLQVE/++jg/IIH0NudDeqTGSu8MnNIhZ+itUUYK09syak7SNB8nZvkT/PU98s5pZisHFX40TWD9/FSBY0cAmRfizP6veKOF3dNOzlUvtkb7ceal8keB/DW8sOrYjRDpT1u2Qc8yRCMlMuhGp9/6Y0wZJl8KydsZ4/9IfZhuReBEbOiDXY0FXBeE+7ARWJhEtj/L2qon3wjcwv5i6eBXNr+MTdyf5hVJhtdHIdcMBsEQ02AlOi6KInSmUMv7qeZqNRN8Y2XaKJJd71QxXOemeHLoaZoo63JyqjXBzdTCpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM9PR10MB4117.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 10:54:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 10:54:16 +0000
Message-ID: <deccd90e-14fb-4129-84d4-c09cfd64c98d@siemens.com>
Date: Tue, 23 Sep 2025 12:54:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v6 6/7] Factory-reset-helper file
 is incompatible with encrypt-partitions
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250923100734.319688-1-Quirin.Gylstorff@siemens.com>
 <20250923100734.319688-7-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250923100734.319688-7-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR02CA0026.namprd02.prod.outlook.com
 (2603:10b6:610:4e::36) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM9PR10MB4117:EE_
X-MS-Office365-Filtering-Correlation-Id: 0377fd96-d6c2-4151-540d-08ddfa8f8a7f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aWg3TUhRVDcraDdFTCsxNS83TWd3OS9ROGtIU1h3L3RYZXFWbGNvY0xySWR4?=
 =?utf-8?B?NGNFVjl1bDk4empjeUw0SThjSFN1RC9HY0N2MUE5WEdkbFJlMDVZREx3VTcv?=
 =?utf-8?B?NDhDdXBQL2JPOEczK1R2YVExTktwa01FdCthWFA2enFtL3dVMkJCU2d4dlVr?=
 =?utf-8?B?SnBFOGl3NGdSUnc5KzZTV0FScmZBVE5BaVZCYlpoaVA0dzJUakNac25ZNlhr?=
 =?utf-8?B?TlkzZnJ0eUZZZ2RleHFkbTFzR2tHYStSTm0yd29GQThLdGI2WXNSdGhqZmRI?=
 =?utf-8?B?cXY0OVVQS1JaZmQrR0lua2JIU3VWR2laN2d5SkRwaTh5MGJQSnVqZGIzNzhQ?=
 =?utf-8?B?c3YvK3dpMzRTT2hSNDBxYk9GZkxWT29WYWlBM0JOUU4rMER2ekI3bmxCM2hy?=
 =?utf-8?B?OGJMSWxua2JBZXdwODZxMzQvS2RXZ0VqcWRkY0tTdGsxQmNhN0Y5ckNONGY4?=
 =?utf-8?B?WVRhbmJUUGdsdUk4R2h1N2F1eXlsQkppSklvTGlyUTdYLzY3OGgxVW1HVmxU?=
 =?utf-8?B?ZjA1aDMvODBQVURJZFZUdks0dDJhWHd6TXpFeGRhejlVclo1UVRjRHdkd3VC?=
 =?utf-8?B?NytaTTlCNGFMSTVUbFoyTU9tWjF5ZTYrWW8xRTJJUlpxSUw4KzFDSGF0TEpJ?=
 =?utf-8?B?cEw5RWZ5WDJmRzNaKzlJTndCVU5tbzBpVGZsZS8zaEYrWDRCdkx2dWtXYlE1?=
 =?utf-8?B?Q0piWDBLM2RBc3lWRUprem05cVBlTjc5bExvKy9lWkUxOTFtd2k5d0VEWmVl?=
 =?utf-8?B?VzNXM3I3cmhFYmtLeG0xVU04VHZzN1loMHVZeEhzelRiOFNSS01QbE83eFNy?=
 =?utf-8?B?a08yMzRUMVlOYUU5ZTN4cE5NZmRORVorak1McThEUGZuNHlkQk9uaXFNZkNa?=
 =?utf-8?B?VU43WTZuRDBqVXA5WDg3YkoyWk5Ea3QrbnJUV2JXOE80eS9OYnk4L1owV0Z6?=
 =?utf-8?B?KzhuOTVBL3d4L042VllEMVJLME1qNUlJZDR6cnlVYTZnQVNGYklwSmNsTnlx?=
 =?utf-8?B?TFZ2Rm1BYlVhZTRCZjlIUTFyR1NsZnptM3N3QlFnM01pNi9IdU5VYXJ1dUR1?=
 =?utf-8?B?MlY3c0xNQnFvVkhqOWNrbHpVTXc2a0IzdHlBSVdWZ1dWNnd5UFhoVExTcktP?=
 =?utf-8?B?MDVwVWdpS2twRGZkeWhheG9CaEs5M0J5aFRRdmpBMk5tNHJLS21FUUlhZVpY?=
 =?utf-8?B?U2ZoMzlwNnB1Tk4vUno5NVpobFRLWUE0YjgxWTJRTFBmTkErM1hOS0hjSXZX?=
 =?utf-8?B?ekZSTW1aRzFScTZORDk2QVRvVHFqdDc1K3VhdmRYTFhqakg1MzdaWU05dG5q?=
 =?utf-8?B?RC9LZWgvM0tabk1uVG0vZTQxQW1YMmZpYkNzWm5rZmlXMzhIelVicjM3MDMv?=
 =?utf-8?B?blBBbUIrQ1NLQXIzT3pnYnhDMFNpSmRiM1l6cFhVMUdLN2F3QTBxMzdyS2Na?=
 =?utf-8?B?MUNrdS9SZFVOTVFUVkpCaTJhMXQxejJZWnhsSElnbzQ4cSt2RENzcHhQS0g5?=
 =?utf-8?B?YUdnb1ptYjhhcDZ5ck83K2xnSUJCUlVzVTFuaEduZHNVR0lzaEs1TXUrcnN1?=
 =?utf-8?B?eWs0dWkvemZZcmRSZ1Z4VzlNcEQxMFdPZmhDTGQvbVc4UGhqOWJYczdSYzNK?=
 =?utf-8?B?dUdNbFUvaW5XOUZwUWFhM1Z4cWtyZnpNWEFpcDc5SmdQbzJ2RUU4MCtpd29Q?=
 =?utf-8?B?RnRZTlpBYkk2dTg0MGdhdnl5czltVXJRM0NYU2JsNUdZajh6VUdkYTdHZ1FO?=
 =?utf-8?B?TUVRR0JOUUszZGdWNkRVK3N1QWdzbElhMC8zN1RYd3JVN0JwL25ZUCtGMnNs?=
 =?utf-8?B?ZzVBMFhkd2lGWi9aOE1JdWZjMmhrYU5uSGVDd2trWTBDV205QzR4a2NhcVRm?=
 =?utf-8?B?bTBuazJwYTBVN0ZqcW5PaHlnMVdkTzdaYUxXY2F2T0hicm5JZDE2K1JBalR1?=
 =?utf-8?Q?WCyhfDElFWw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N1lYNm00L1B1czdjQnFtNjJ1YWNTODFjN08zUlBZMDVpQmRVWmRvR2psNUQr?=
 =?utf-8?B?cGtFQzRZZ2g0bjljQXZCTzRLMWxHYlZ2c2dGQzFxVm55aDJvMTNpbU9xR3Jl?=
 =?utf-8?B?MTRDdDhFMGovR0w0M1NhY0Jxd1ZuNXlpVmNRMWRITWVEU2E2ODNMalpOQ0ho?=
 =?utf-8?B?ajIxR01ENkhXZGxQTXBSZTlPWERSS0pVSnFheG1WWkZlK2pZZGs4TU15Wlhq?=
 =?utf-8?B?K09zUTlYTjlqQUpBYnpVc3BkM1lreTgzeXE3b2J2MzkwZDVWVmZwOXBUdGJK?=
 =?utf-8?B?Z25aaEhFcE9BMm5OdUVPNGJKMStFaWMvM0xyNXI0V0VxVjhpK1Z3MHp6b1Y1?=
 =?utf-8?B?TDEyblViU0RVWUh6eGpyOFZsZE43RTVUYTg2RjJLbUgxdnhJNGVSdGRaZnR3?=
 =?utf-8?B?Z0VNbUUxcjJVRXNjMTlDZUJJZFNxQXl2Ym5MRUtuNGUvYUJKNldyWUdmMGhG?=
 =?utf-8?B?bzVLcDNzRVZXQUhhYSt4c0pPdXFXckFEMEJnNnh1MU9qSDNqQnpKL2N1Sk9l?=
 =?utf-8?B?d2xtcDZkOEFlSkF2dTM1ai84L1Y1UDcrcHB0UXRtZUtKQStmeXo0aTNFb1Ji?=
 =?utf-8?B?U2NKQ2lCR0lUcFpDQUpMdXF3SU9YU1J6aCtNem9WTEhTQUliYkE0SnlVcXZt?=
 =?utf-8?B?MmxJamNTNytjSVVDZ1MrWkhWR1dWQi9NZmFnaGxEMDJNMktWaXpGUGhjREhy?=
 =?utf-8?B?N3pUc25nTUhlMGlpZ1FaaDNkZVA5aUlaYzJSZ2tqU0ZHM0JHdE1SMWxoZ2Y3?=
 =?utf-8?B?WGZ1YkkrWmdCNENBd2R0dkhhUzhCZHF3MTlpMzBQc25jcnpONzJIZEpFaTYw?=
 =?utf-8?B?VnFmZkd1QWdWOXJXclg0ajRZbUNEdDlZbWZMK2FrNzlmOTdsZGF6dmtLVmgz?=
 =?utf-8?B?R0hTR2t1ajJjQnVNcGluRnI1K04raHlJT2pHMmNoYnQ3YVo3QmNkYUszWmJz?=
 =?utf-8?B?cWtSSzZLOGNDbmcrNExhOE0vTzlOaTZqOUViY1cwMi9aM08yakhtSCsxVE9T?=
 =?utf-8?B?cTdwTUkwTU02azdmMjhwQ0hWOHFXV25rbzRrRFpLanJINm04UTNTVUtCNms2?=
 =?utf-8?B?RTRRVVlQcUJNK2N0UXBJUDRUa1RPZVd6L1NMc3BJbXArZmZtcWVBVnRINExF?=
 =?utf-8?B?eVdCVlFWWXBHeVhiS0VBSUxDL2JnTXQ0bnE2RFdGWGFHbTdOVDZMZmpOVjNX?=
 =?utf-8?B?REJoYlZaZFA5eFEzWUlSYzY1WDhsYS9RTE5SQVY0c21TN1dxZzBuWWREYXVL?=
 =?utf-8?B?ckxLditRUFVqUzVMY2dzNXBmOGF3SnFJamdFcTZRR1FzdFoyWUtZY0tNOTc0?=
 =?utf-8?B?QWxMd0FBeVlLbGtpb2ZsZ0MycWlnNzJ1aUJwekJlSzdiejhDLzFYd3dRNFIy?=
 =?utf-8?B?ak5hK0ZVUmJVZHpOa252VjVsNnNNVGdRSXdFRkpOT1J4cFArVGgxdEc5L1N0?=
 =?utf-8?B?WWxrWkwydElVZzR1TVRuWmxSMzZLcHJSdldFNTNXazFweURWZ1Z1VTVFMXZF?=
 =?utf-8?B?MlE4cmxRaWlNVEFXY1FlQmVvZTRxNTZhRkMrYVY0aXRWY1MvZ0NJazN1MzY5?=
 =?utf-8?B?Zjg1TXE1SGdKN2VNbHpjTUJjM1ljcDVuK3UwaWErZFNuV1FmWmc0OUVCenp4?=
 =?utf-8?B?dmErSU9FQWlXYmxtdk05dC83WlpjcUc1U0wrc2t4T2tDeXlpZkM0VEpTQnh0?=
 =?utf-8?B?YUVkVnBLclZGYlJlZVM3SkVrVzZtbGpUR1BiQ2hsUFFOd3RuU3F2T0JYUGk5?=
 =?utf-8?B?YTgrMVdaNW5xU1BxZW9lOXIwemk2Nm0zWFlGNE5LUDNjbk5Xd2VvczJwUnRP?=
 =?utf-8?B?NnR2blpJZGlRdXpYd2V3dEtDV01pRURaQ0ZFUGFPVWJGaDAwaE5ycHRRN1dt?=
 =?utf-8?B?b0JuYjZESUUxc1ovTDJ3RFV0SzJBNWxpbUF1dFNUMXhKckZKbXo0aHg1SFhl?=
 =?utf-8?B?dmV2ZWVyU2kyWnRPVkMrYURmRmZXMm4rK3FNWUtaZ29saFFJK0gwR2hqanFV?=
 =?utf-8?B?U201cTBJZlJjWmlDeGVlYlp2T3FlbEsvcWhrOGxrVmZPaHFXMy9JRUtLRDBJ?=
 =?utf-8?B?ZXlqNEFtZW5yTENYeGJuMkc5WHg4cm5tVGRMUGg4NjZzSzMwbXVwb1JrdW9I?=
 =?utf-8?B?a2l6WWYrdWErblhRTnRTMkxGQXQyK1hOVWgwWkNBQ0E2MWQ3MFd3T0gxWWhN?=
 =?utf-8?B?Nnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0377fd96-d6c2-4151-540d-08ddfa8f8a7f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 10:54:16.9393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XR6OoJjJi/q+QSqe7A5BPWCI1E7BFCWC6MdPfCORKtJvfrajWvC22HrmeU079NVSqmlXWvj5XlKAn2plpuIm3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4117
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Sep 2025 10:54:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20104

On 23.09.25 12:02, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> The partition which contains the reset-marker is encrypted and therefore
> a factory reset cannot be detected. Print an error if this incompatible
> combination is selected.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../factory-reset-helper/factory-reset-helper-file_0.1.bb    | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/recipes-support/factory-reset-helper/factory-reset-helper-file_0.1.bb b/recipes-support/factory-reset-helper/factory-reset-helper-file_0.1.bb
> index 8d82663..14870ce 100644
> --- a/recipes-support/factory-reset-helper/factory-reset-helper-file_0.1.bb
> +++ b/recipes-support/factory-reset-helper/factory-reset-helper-file_0.1.bb
> @@ -17,3 +17,8 @@ FACTORY_RESET_MARKER_STORAGE_DEVICE ?= "/dev/disk/by-partlabel/var"
>  FACTORY_RESET_TYPE = "file"
>  
>  DEBIAN_DEPENDS .= ", coreutils, util-linux, e2fsprogs, bsdextrautils"
> +
> +python __anonymous() {
> +    if "encrypt-partitions" in d.getVar('OVERRIDES'):
> +        bb.error("This recipe is incompatible with encrypt-partitions")
> +}

Intentionally a separate patch? Or should we fold this into patch 1?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

