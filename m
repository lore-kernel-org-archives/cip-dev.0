Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB51C36005
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 07:07:25 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.62])
 by mx.groups.io with SMTP id smtpd.web11.42301.1745823981501446643
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Apr 2025 00:06:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=XZQq7Y8G;
 spf=pass (domain: siemens.com, ip: 40.107.105.62, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jLH7hiNvYH4QOy/+pdZ4gKO5ION6zvo4no/AbVRMUY6XIc/TUTeqksSK4l5K/S2MRvwRSDGDvsYCGMqjGUI+BsHHJKmc5vpFWga+HWI6YZZPDeJ8vOPr9Kn8+C969FsrbW9WDUGviNR5lH5h8N62yxkFYfEfX9dwcpfEJJkEAK8evOpbR/YJaZLl62+qd47XFlqvIVvjeB1dqyGspFFi+w9q/iX+5OmXZTt534HI+q2qMp7zvb9dn4kODi1EBeMUvX7Xn/xKo/Ax6PEsLnsAiZ2Ic96wHJL9XV8IbuWDDUPwNocpuULntslc+sHr6jvLZMOVNk2ykTptgcE76nK27w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxBz8sQCzLoKngVde0dVmn0+YnhyPjT6nsM6shyv4Hs=;
 b=fJmCyguv1cc87rRzWCb+XlHZaOZeDUBBE/iirMESrwP9XJghW8dPZqSoPBqguFjHvmmIEvYHjR862AVmulDb1y0fzRprT5FEEdXDslxwmzxkfICHh26lyC0A77paglRzYNFIyCDxGPZg07aBzN07PULyw2IPXoasW5t4pjnBYSdA1Kv8CLgin+hY/XAiLqr2yn+fKxwLAsQwiPzcLYwAEJ4To+sEnescfaM/mSi25mhU5E1/KV4WzgJOVXjuOVGhGtuq8dIm+wAEwiH3Lngpp9RZgFzHKZVCZXMSy+8OcTadcsuqqXIPD7siwJyezWA662tRQdgEXUDGYEASbAPXyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxBz8sQCzLoKngVde0dVmn0+YnhyPjT6nsM6shyv4Hs=;
 b=XZQq7Y8GF450ycFyXa7K+B4CGOdEfj4I15XoDoMavi3o8y0K2J3zuRPZYLrTp3jHW2dMNxFYc3Y8VLZGG+sheVuYuOtzBgVAxAdDFv7gZCDAZwhQy64hUOIWvyQQ7612gK1CNs/WwdfXFAq3vf/GOS/l869zVnvODmisTqmAfQkZ6vzrTq1OXuDfyCulAgKZkAdFn6EpLP0TYn/Wu7c89Mbq76BjP6a8RUiVCkydApOPn4m9MCElWy/zJ7PObIbWxMR9cJXFzELlz6B6GPERkOJ3HqYqGNWGqgx+Tsr31sYEwxWPyYdVTJ7ehvl0lpxAVEYrbamDCH8Eeam8c703vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5216.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Mon, 28 Apr
 2025 07:06:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 07:06:16 +0000
Message-ID: <46f5d079-c362-445a-b73d-beb5ed9fbd21@siemens.com>
Date: Mon, 28 Apr 2025 09:06:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC v2 0/5] Use kernel commandline for
To: "Moessbauer, Felix (FT RPD CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Gylstorff, Quirin (FT RPD CED OES-DE)" <quirin.gylstorff@siemens.com>
References: <20250422145055.1095348-1-Quirin.Gylstorff@siemens.com>
 <95e952da10ed1a0f98eb69a32eeaf4ca239076af.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <95e952da10ed1a0f98eb69a32eeaf4ca239076af.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5216:EE_
X-MS-Office365-Filtering-Correlation-Id: 43e2e226-abf9-469c-6b1a-08dd86232b06
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?citOU1B0Yko2blNxSEhCZTAzd2I4ZnVlcGVLSkljYWtwVURRR1lNZk14U2du?=
 =?utf-8?B?VWFlY3hyUXVYZTR3ZXA1Rko3b0oyelN0RGRpKzR1M0F0N2YwWVVCVk05QVMx?=
 =?utf-8?B?QVVYS0ZJK3MyV2FUN1NGQ2hDZjlhUVJweG5LYmtxRmVxU2FXOUNKakRaWU9u?=
 =?utf-8?B?aURpMXFsMHk3dGNKeXVTaVhOeE1sYlFsMWl5ZVFxSFdORzltNjUzdmZXYW0r?=
 =?utf-8?B?d1NlSFh5UDJnaHMwTWd4eTFEVUtDSDRLQncwWkNtUjJjRWdkVWx0ZzVBZ3Vu?=
 =?utf-8?B?bDN6Ymc2VXJXZFc2a1lRRWtWcllYWC9mL3A5WUwzVnJRdFhtNzVMcjcvdTh6?=
 =?utf-8?B?NTNqc1dnSWg5ZmkvZ2tuV3lyblE4cTc5a2lsb1NnSjdLR2NjL05ueWVMQnlN?=
 =?utf-8?B?N2U5MU8ySkF6ei8zWDF5LzJQNnd5VUNTNCsvOGZlSUM2SGx5ME5LdGdxdFNx?=
 =?utf-8?B?NVRZSW5hZUd3b3JPUU5GcEt3MjJjRFI0dElaZ3F1bW5FTTZIOElMTlNuU1Nl?=
 =?utf-8?B?bEMydk5CaWcvbEs4VVJPT2ZPYUt0T0hxaFBDRHZuVFN1RFByV002bWZ3S1hL?=
 =?utf-8?B?OFFyRVJKcXZiYlE1dWU3WlNyU3NpSkk0TlRwUnhNbGRJc1E3V1RlNWRkSS9M?=
 =?utf-8?B?NXA4KzJ4WUF2ak43WlVpeFRvSTU0dE54NzhlWkV1cWRHWEQ3NzRuUTJqM252?=
 =?utf-8?B?cElGN29DWlltazVJa3UwUTViV0FXUVcyTkJMeEFtNmpqblJrcHoyVk1reWNB?=
 =?utf-8?B?Nm5lOWZXWUY0eHZJbzgycHc1WjVLZTBZcHhkMHdub2ZtZERONUdzNHozZWRj?=
 =?utf-8?B?dWhnM3lWSk9Uc2FGM0Y1ekNkZnZPdlA0ek4wOFV0Mnh2dlZhOXhodXF5c1ZX?=
 =?utf-8?B?a00rNm1yY1g2aGtIQ3VMcnNrRy9HTWhuRTczYkFuZEM5VHlvSEMybGsxM20y?=
 =?utf-8?B?VEVnZHU5NTVWTUF6Z2w3L2lGYmkwS3BYbVcwSllEV01wVDhFTCtLbTIyU2JT?=
 =?utf-8?B?QlNHdlZOOUs2L09Ea0JqVzNLbllmWVRqbUdvcWtpdFU3RXUvam80RzMzeDJk?=
 =?utf-8?B?VTU2SlJiN28rellBUDN4S2xRNC96ZmY2dGo1NlR4ME9salNzaFlzUHFDbHlp?=
 =?utf-8?B?bjFXQUh2emNrMnRnUEM4WlQzSXRDaU1MK2pkbWhQUWlEN1orUVpzQTRlSFM1?=
 =?utf-8?B?UmdSUkdHQW5pMmVnVzRHdkxTSTJEZ0tQc1JzVGtNUmxNcWc1ZDk4OHYwbWF0?=
 =?utf-8?B?Z1lZT0ZKeFhnU3pUdGNCcSt4akI1REMrbEx3MFl2WGZSdHJTeDVzUVJ0MkJH?=
 =?utf-8?B?WTRqeUg0VE93dmVxZEF3RHU0SmtvRHlleEtXdG9IcVMrY1hpbGpiaEZmUHg4?=
 =?utf-8?B?RVpKMTBCcnJZcS9oVmN5a3ZjUnpPYlFwTThTZmRsaFZtaERwMWRSREU1cGtB?=
 =?utf-8?B?cStSOXk2L25LNkp6a1VuS2QzTVVaRjg2c0Rjd0NGWEpSZDRoMFhlUFBYWHQ3?=
 =?utf-8?B?NUpEblZ2bldDMDllVnQvK0xsSFZQamdjOXN5VzRLbFZ6eTMzcWlSNEsvOVRy?=
 =?utf-8?B?TU9WWlBtMkV5dk5Sb3dJUSs5MjJlV0IwSEo3dHJoQ3dXNmtxZlpnVVUrRThL?=
 =?utf-8?B?RGZGeS9RVkpvYkNJRnl5eis5NURTUUZzTDBBSENIMGdVd0d1N0RPMm5laVNh?=
 =?utf-8?B?SGIvc0tCS0lnQVFRbG5XUk1kdzlvYjVqQXVXaEVmeE1GS0lRanhXMUk2YXh0?=
 =?utf-8?B?SUdlWWFKMUp3dWc2MlFzZUJ5TUwwNDlVbWo2bjJTaGRBTjZkV2NhaWo0cFZC?=
 =?utf-8?B?NHZ0SHFTQU53R1o4ZXNRNmJxQVBkWG00TnBQWmhDallTbDNaTFVHZmNwa1lQ?=
 =?utf-8?B?amE5UngyR29zdHZIRytIamNkSkhvWHBsMWE4THlQaUVaUk00eEtRbjRCNGNl?=
 =?utf-8?Q?Ro2zQ8ywcBg=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SDA3ZnlHSjVLdHlJN3pDdmxLOWtOUUYrSnhYR3JEWnpvbTBsdjJsS0pOckcy?=
 =?utf-8?B?MjBLRFVIZExDTWY3TGZqWGJydWJvOVEwUTZPR3BZQUVDZzY0aFhwdlYzdCtX?=
 =?utf-8?B?VnhxNG9ZZStWZFVLUm4yS1pVTWo1MjIwdEMxankvZGJ5Y1A4dEl5N0oyZ1Zz?=
 =?utf-8?B?WVpJcW9WbWYrZ3A3VXl5eS9jUHpIQzdhVTQwUytIUmd5Vm5IYjBaUGFDSE1H?=
 =?utf-8?B?a2pydG94VXRrVk5NblRLQ3FXZ2tITkxYbGRWK2NPSDNIdFo3TUZnVml6OVFI?=
 =?utf-8?B?UlVmK0QxaDhkd3NzbWoxcXdodENlV3hxUjlpQzZMY0pDNzJYWDYzMzVpd3Yz?=
 =?utf-8?B?VHZvYmJUbUhRd0R0Z3IxTFpLd1dOR0l6eDNSbWRuSm1WVnUzRldnQjRqaWsz?=
 =?utf-8?B?NlZ3Y3BpZFo5MVRRQ1Q1LzB4eDFQUWF0TmlndkZBaUhINXplMFF6S2Z6clo2?=
 =?utf-8?B?dlRXTnBzalJBWWRnTTU0Z2FQOEd3cjh1bjhrZEk1OWdkbkpKQkY2QURYcURN?=
 =?utf-8?B?QkpkTlR4YjZZT2R2VjJXdUhKN2kwN0lsM3ZzNXQwdEVReTBWSk9YbW9Oekdp?=
 =?utf-8?B?UGlwMlkyYkIwaVdDRmxQTWZQOEQ4enkwNGplRkNpNXlxZ3hyVEJjaGQ5ak90?=
 =?utf-8?B?SUpKMDhUUlp2L1o3enU1VW5QclN1YzZyNWp4MHFGR0thd3l0SXpOSXFUZksw?=
 =?utf-8?B?Y0R2TENzclhwZ0NYbW5EODQyNEUvdVU3NUs4WjNlZkRoMk9iNi8yRWFJeU9I?=
 =?utf-8?B?Smo0YUVIM3F6NnMzSEVJVDVXZ3hic0JTeEQyMGQ3NlpXVzIzWUJtMEI4R25n?=
 =?utf-8?B?Q0JNMjJqMkU1SFczcjBFNXM3dFFnMGE4WHFYRU9FNCs1aktaMFBHNTJpTU9O?=
 =?utf-8?B?dUs0TmJpRlRKTlYwSU00TnRiOHBrRHFFaUNiZGMwdWVCSURiMnVrbVIzMzFL?=
 =?utf-8?B?L3RmaVZrWmk5MFNMenB1R1paMzY2Y2tmZFdJVTJ1MG82VTdJdkpMaitDT3c2?=
 =?utf-8?B?Ym9mRk8wcnQ2RGQ3M0hHNUt0bnZ1dU12ZjlNNk9Xb1k3YkRGMkRMMXd6VHpy?=
 =?utf-8?B?YzBHcFJKZGFLanZEMTBDYS92L0p0QmxPQVRkWklBbFh1VGIvY05CbHdzUXVy?=
 =?utf-8?B?c1kyTDg4elhFaE9KNS9KOU04WEhVNy9TZmhmTCs4WDg3Nm51ekFJWm4yWkww?=
 =?utf-8?B?czA4N3V2bHF2MXFiMk0xMnBHd0tKZUZLUHp4Ui9UZXYvb3MzSTdPY2RVY0Y3?=
 =?utf-8?B?U0JkZjlmREorQ3hRejB5TU15NjlMU1MrNks2R2pVVW9ESlV3YndtSmRmR092?=
 =?utf-8?B?Y0wwcnVqdWs2QUZTNklwWnpXSENUMTB2WE5UNWFQTWIrY090MStmTU81eENR?=
 =?utf-8?B?a2pwZkMwdmJGVHY2VXJVQUpNSWZiVWlvc0JxZnF2eTdabld6dElFcTRsVDZu?=
 =?utf-8?B?eVVMMVF5ZWxZU2lHSXZoTzRaQmhKMGxXeGlKSWUrNlVvS3pDL3BOcG9IMWdI?=
 =?utf-8?B?UndudmNGamRidk1JSVBnSnRTVmRqUklVRThsUTV3bjBxYVBEVk9McUNzbEF2?=
 =?utf-8?B?Ky9BcGg3aXhueHA4aTJIQkNaamYwMDlMenZTV1Z0eUpnOW1UNXVUeHZrUVRL?=
 =?utf-8?B?Wk5zMGxWeFc2M2QxcU94YnJ0MEYvRkNWbUVwUGpMV2JKSXh4S2MxZldtYS9H?=
 =?utf-8?B?Z2M2UTRZaUEwVjZDVkpoNzRjZ2NKcmxySkFpUC9rVXZKczVSSVhQOGxNcXpX?=
 =?utf-8?B?R3p0UFMzejJqTDRkSFBSS1JhS21DVEs3bmJucXp3TmJLb2lLMXVDK0Q5eXlq?=
 =?utf-8?B?WEh1VnozSjZ2U2dGVnU0Z2krOFlRWTA1MVVTeVk4UXREVVhKNVpnaXFoUUlj?=
 =?utf-8?B?MW1wWDRCMUhJUTNnU0pzdEdpWlY2SEgzV0szcUlMSnUvTm01bVZMTHFBLzlJ?=
 =?utf-8?B?V1FNRkN1RDRVbkxaZHJsQTZlMmQrK3QwejhjZkV1SjRGakUzNFFubEdIY096?=
 =?utf-8?B?M0ZsckxDY25OdmhMamhkZWFtUHgxRDZYeEtTM3VhVkZYNHZlRVdrREtUSjll?=
 =?utf-8?B?WFlhSHV1RCtvZlVSQS9LQjVDSWFhN3JDUmVoa3RsMHh1SXpnSm16UVdXY0k3?=
 =?utf-8?Q?iAg9vg6cZ0WJTDUMGfjAa4PHg?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e2e226-abf9-469c-6b1a-08dd86232b06
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 07:06:16.1923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mY3OIaHMDUIU9dI2gUHGranzOablilK0H0puBBbNSSfIgrTItTcPQ2A94A1RK6OD5S290HcVQRqdw5fm4b/4CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5216
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Apr 2025 07:07:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18684

On 25.04.25 10:01, Moessbauer, Felix (FT RPD CED OES-DE) wrote:
> On Tue, 2025-04-22 at 16:35 +0200, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Take Felix work and add the missing abrootfs recipe.
> 
> Hi Quirin, thanks for taking over.
> 
> I tested this on the new A/B rootfs MTDA image and can confirm that it
> works. I did not test verity or crypt, though.
> 
> It also makes the initrds sstate cacheable with is a huge benefit and
> also solves the issue with broken verity hashes due to non binary
> reproducible root filesystems.
> 

Looks good to me as well. But some code unification between patch 1 and
3 would be highly appreciated.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

