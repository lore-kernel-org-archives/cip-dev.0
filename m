Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF67C43602
	for <webhook@archiver.kernel.org>; Mon,  6 Jul 2026 09:18:46 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.147214.1783329519160678892
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Jul 2026 02:18:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=doz3KGo1;
 spf=pass (domain: siemens.com, ip: 52.101.83.31, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LEiYgOiZppbum66KX+T7/MU/Ie5SY4fDlC41ih+j1yT/+PdTm7zDCH6SsR+xwhjLG3SC8/6of1JZNoWrvLymfJUuyIEC5iURnLgiQ6PIUqvT1OZqPeMM5NzER6KXW4rVmzVZeHiJSdHrXkEfG4DI9ciXaeljyK48hvpDtPVYPLhKEA+RHWsjA1O6iT4Ve3SiJz7DcMczq0P/uyOOxWy+RGt7xbBtsZHjQLWD9ATC+5sUxuVP1YBMxnxXG9pd5au2u1CGnbtkF7Td5OODHggidSwtS7K4Lw+NAVZv+3U42Q0n0U0vosWcA/MXf9cy5irTCOTLKPHwq+CuTVtGop7S1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOR3KSh0DDqDvgq8d7uvqT/0NDEfR+rA2rriDRjixIE=;
 b=vZgKCIakSd8OggVxmV7oH00RHLPFaY/ybMha7KE2wzBTlfiTk1E6GQN/suyfHx+yjY3qw9hrhDvaWRPCJ5ytNxXOLwf5k/fT5y+kjDBcPWvGj+zl3iZTQYnHxC3QvKdu5yef/O+CVatBYwJGMOmq1Hh6bJXyieD1YqEPoFx18b7+zZGROTeMe9iH7CCst5MWiQ+n5ipO15jGnj7nbE/HCQzWPtK8ztDB/6LjlN8q6eigBJLrf0aPWrUCZx+fYP8Ux+rpuhRb6k8k6sRJKeDFgE2N9In7FTE+BvUpRXTxr53P37DWjPCZMWUfD9ArIBnpPsFE9T4PIX6SMsXxLyxjag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOR3KSh0DDqDvgq8d7uvqT/0NDEfR+rA2rriDRjixIE=;
 b=doz3KGo1eV2NiIJdhAZ/zKkDWICXP/Fbjaw+LiKUk854DpzRU5/oBwKrqzHU6tD6rvfUhNio4Ep51sER45cCsXAmOFE7ErOANtbGFBi4yiNIKX24AqnD/qD4S4XfkuQxQL9mb6RxM1iWvN5vdHTyi/eku0295oNz74tUQCHcygwFg1ESnQNIwmugGwsTHPhW32Vevu9Ya+PxGdLj0BZaYclAXESuLXgDRnQoVTHLTAnv1wuzhgRsk/URFMQl4XlebS7GpPkfskC918qnB1vpDkJFnX3X/Waa7YB/cZTi6odXOE1Gts151KLJXf4OUxQBBJEJCGcPd2X9BpaQzqtO/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3581.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:141::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 09:18:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0181.010; Mon, 6 Jul 2026
 09:18:34 +0000
Message-ID: <7463f056-8815-4a58-946d-786de0526eec@siemens.com>
Date: Mon, 6 Jul 2026 11:18:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v4 0/3] Enable Debian Sid support
To: Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: Adithya.Balakumar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro.hayashi.f74@mail.toshiba
References: <20260623105234.972121-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <fd407f79-72ca-4da1-8937-9ab989c3a1cd@siemens.com>
 <TY3PR01MB11075746DDA24B486D0D524BBC7EE2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <29837d2e-3205-4d02-9b02-f26d86bfc198@siemens.com>
 <TYWPR01MB110635B2601B887DFEF2DCB27C7ED2@TYWPR01MB11063.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TYWPR01MB110635B2601B887DFEF2DCB27C7ED2@TYWPR01MB11063.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0005.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19e::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3581:EE_
X-MS-Office365-Filtering-Correlation-Id: ad8fe327-c947-487b-b720-08dedb3f8d9b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|55112099003|56012099006|5023799004|4143699003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: 
	ZDYvairUXLw9W5Vw2ln9uPj/jbZJw8hDEAYEuJd4wDd1GDi5zoNm3FfGiYzqiN1rpV9U6UhfWQfptlq7HKpxhFlDPkiQmpVDjIf/N23orMTTw993TAL5kVItZI6aWSRQqsmQfqNscqdamvi4mVUz9cggFK7XNuDU02uZHd2ZwDYv9A1Y/RBalD4JxhfUtM7or1qrLugFO+0KPFnIXQ8OQfkRMj32Ttd30tTZbYLLMOx92bkkPbqEC/vk1NpemXULMJwJwWWD83tkWhCuejIBLAYuAcYMN5D03IzCgUcyjvZqL7S2S+Ntafp6Pwyr/CHZRguohqHwHdTARML+zR9556pOK6ZrI9gZ4idJbXwnmeoaAdsjcyE9R8vvTEAXYUPhLmMAQQYZdNkK35BzFAfXh/NACo962ESxEtOGE6QpN2phYqpQmIkWXe6D3dyTlJT0kpfDLGYcfByJdc2qePfreqtleDSXj8MGCoehRkLPoy9dTSJsxYh0ilMF4JeWBY+1HNlvOgZYJ2F5n3E4+rVsuHBMKtnZomxrCasEImClQtSIUAkqqQeLnl2EgGcj5d2reIqWUpRvLSg4EmAuVkqJ/zAwUqHlWhnG9Mxc8AWRJ57LTmU+9BBYSGN/KA0C4Xe4C3fyzTpCWWfyNxXWOBC1BcRDBOQOY7pKDVk+JlPmGhg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(55112099003)(56012099006)(5023799004)(4143699003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Qk81VXRzMWtPMEVSbWsrTkxPMlM3WE5nZ2xodkk1NGt0V0lXS09yT0xzVTZz?=
 =?utf-8?B?TzNGOUpmM1U1NkYyQzVUc2hXVjVtZFBLVUV1RTJqU0lCTTNMMXNCRWhZQlVN?=
 =?utf-8?B?RFZyWFlsaTA3ZXc2cHRjUWdabGJadDhVZ250bnJSYU1yWnFCUlV5RnJqMzZM?=
 =?utf-8?B?QzkrenV0RTl5dXJzZk5uSnlpWktqdWxrRGQ2L0lZcTF2K0ZkTE1KSk5hemp1?=
 =?utf-8?B?WXZ4QVFtWXd2ckN1UE5MbllmTG55YzJXTHVUM3pXbDE5aTBuSjEvN0tOWDQr?=
 =?utf-8?B?QlJ2M01ES2VyR3MrZVovK3RWeXZYY1JpUmVTL1B6bG9GUzFnMnpwWUhBendC?=
 =?utf-8?B?bzR6NWNCT2tZNWliMFF6ODhoeVJtbXhQUHppTnFiSGJ1KzVFUjVMVWorWkY2?=
 =?utf-8?B?aWFESUVhSDd1RUVZMEJ5RVNlY0JiZlBxNFRLclhoU0F2TklOMXNGWlhQd0hp?=
 =?utf-8?B?SngveDBJcWF3THRuLy92MlNFTW9rZlVRY0pvd2pIKzEwUGdmR3d2dTc2VVBO?=
 =?utf-8?B?c1NWbE5tZTFzS084dmhQbVYvdXJDQzlzUGkralNFbURnK2pjRndRNnVlS1g5?=
 =?utf-8?B?ZWNFNldDa1NNa2FUZDZGV1NxQ2dlWkhtT29rcWZaY0t0TlBMeCs5K3ZmMXhE?=
 =?utf-8?B?eklUZ1ZaY2RwVkc5RVNCaWRnTksyblZyTmlGSVN2d0FwNVNFUXN5WDFBVmov?=
 =?utf-8?B?ZFg0VDlWTDhVczZ4QUoxb3RRTTlEUGhraFRBajdiVEFPVGhNQjI2WmNCWk9q?=
 =?utf-8?B?bld1bjlGRkJBdTE5UmRMQlJ0MWVBMXVYYVA4czAwaWk2RFJZcE9ScUdsZGVX?=
 =?utf-8?B?WEZlbUhJcUJFSTJhOGw1ZnlBOC9yQ2V2ano1cW1jM0JxdVBtQ2VtcHFKSVc3?=
 =?utf-8?B?YVpDeUlQTklDR1JUeDJ5NmFtak16dExwVklwNjBWZHJjQVNJSGdBdXduRW91?=
 =?utf-8?B?dUhMQWh6S1JqbldwTXRZdytWMGR6dlFXYjZVZ2tRcWh5VjA4UktkenREMWVB?=
 =?utf-8?B?eE8xY2FxV2hSSXBzMnFtZkNDcllFMEVwd3BpbStDQ0plMlZhNkdCTnZURXZw?=
 =?utf-8?B?NS9ZZzBoZjNlTVlJMTdCcndmSHorRStQY3ovMUVMUi9XNVZxOXR1N1lsbGdq?=
 =?utf-8?B?UFQ0ZHdMa2krSmtsNGx0c04xZTEwNm54Z1ZXMUw2d1dOemJMbXNwcCtVM3I3?=
 =?utf-8?B?dmZuODNqLzc5UjVsdHh3NGVsUnVNZnZPem1HTHd0cVd1N0VCbk1kQW1mVDlD?=
 =?utf-8?B?eUdpVXJTTGxtTmNYeGZwRy94S3k3NkR0UHN1Z01lenYvMTUwVWdCTGxDS28y?=
 =?utf-8?B?dWlzOWtHOVk5L2JCMjRvR2VJZGlseEgvaFpVblczeEpFOGRrbldBNjQ4YkRa?=
 =?utf-8?B?YTJwcXU1VGZoTTRZMTBZK0wvaE56K2RFc3NmTFFORTBxaGM2ajlEY01qcldq?=
 =?utf-8?B?Z0xsODVLVnJpaExuT3MybEF2NFR2K1F5YWROVnRTc0pPMFpDYWJ1eGNEY2tt?=
 =?utf-8?B?YWMwSkxQRVFIQWJUdS84K25ZRnRmQTFkaWs2U0Vqd3liVmREam4yVVkwZkcv?=
 =?utf-8?B?bDNSV1YxNG5oTWg3R3pSSlFPZkxEckdPeUg3UjlDQTZTQWZPbUVHQzNBTGR0?=
 =?utf-8?B?ZWJ0NTRHOEdsUDV2TkVBSlBYd1Yvb2lNVHpyN0dOdUFzbkRlRUJnZGpNbjV4?=
 =?utf-8?B?Wndab0ovdUFoNDJDdStVYUhIT1pjampOZUVaL0RxNXZEL1FJYzR6Z0RjZ3B5?=
 =?utf-8?B?N1VReEZYLy9MZEpPSS9TWmFvTHBLTXZtbUhIZlVHYnpZZUVKSXZiVFFwZmtT?=
 =?utf-8?B?NytFaDMvRHY1c3p0d3REaE5yNUZxeVhMZ0FPMVBjSS93dkRHbEV2aUxiaC9p?=
 =?utf-8?B?bHZFN2IrWDRlVFZHS3dlSjB6L1YzeWdaZ3FXVVRObFpSM0tQWFJ5MFdzK0Yx?=
 =?utf-8?B?RjMrdnVxckF5d3BxNXBtZU5kYitjaXFEeTdqZ29YTzJUQ0V5NllPSnZPSmE1?=
 =?utf-8?B?QlhJUXVtYXlUY1F2b1hSa1d2WlVtQkFHdFFpUzZIVFVRWUJ1RGxOdnFDRGdL?=
 =?utf-8?B?NXdsckp0TlhxTDVaZ3d3eEhwTFhVTFNrTU1tdDZYQ2NEcFdSNTFWRmg2VWh0?=
 =?utf-8?B?cHltZUtJRittTkJmVDIrYzRUUFRpVU92RW1XNnRYR2ZqUjFHTFN1RElGUndV?=
 =?utf-8?B?bmpnbFRYdGkzZ2tzWndON0w3bzdLdlpCUnRMZ3hRaUZ3OC9TR1FmWnR6NW4r?=
 =?utf-8?B?RitRcEdueGFMdWdQQ1pLVnEwei9Ic1d2a0tDZFN5R0wvQUhITzNMdjFZejBB?=
 =?utf-8?B?VlljdWFQVXlRbTZsb1FBMXd1WDFybHlPSnVWUStSOG5GeVpXRlVNd3g3dHND?=
 =?utf-8?Q?yMTtk8b9ZWiwmb+0=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8fe327-c947-487b-b720-08dedb3f8d9b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 09:18:34.3154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +HuU0St7WrkiQaMkcTIuFWiT17EUf027m2tfWFYItuPM3hApT+5LpUqv/v41q9ZVikbk0atGexIsYMn3d6N/LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3581
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Jul 2026 09:18:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23459

On 24.06.26 11:10, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> Hi Jan, 
> 
>> it is a protected one, and that likely prevented that you could define this. 
> 
> Right, it makes sense. 
> 
> Thank you, I confirmed the new scheduled pipeline is created for "next" branch.
> 

What is the state of this now? You somewhere mentioned that some changes
to the deployment script would still be needed to make this fully work.
Happy to take any patch needed for that now, after the release.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

