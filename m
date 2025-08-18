Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CC5CA0EE4
	for <webhook@archiver.kernel.org>; Mon, 18 Aug 2025 15:17:38 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.23])
 by mx.groups.io with SMTP id smtpd.web10.78118.1755530253449354066
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Aug 2025 08:17:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pUouazqO;
 spf=pass (domain: siemens.com, ip: 40.107.162.23, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HXhmTiQY84V/xmm/R7FEfxFd2PhSC5cPyK0mm1sN9SjHN20hySdecvZcBcPZ8odE9d+fbZpZnWB+OGlSq+Q3AfRlEp7wZxSUThAaFhbq9PhEqxupRZdfPvYBXEh+ncLw92DnxQ0LN00OmsbvgVBftX2yOMCm6uE+u8Wj98S7MbE7ZN29zW64Ct6nsfQGG24jIYQ/OIrLgrUGWEobfzdPXHolDSKarbMC+w3nV9fLq50cwrQLE6djWlHxGJLOsNzSJ17z1ZorJO6QrF1EA4DNpaiyfkpLohfsRtfYEjpiE2zGoC5veehNdQ5zodEmNbm5xE6+CDG6RVh/MCtPcM4kZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibxgG+6CidkBhV6nl4DFcpPFUMK42wuWUFwpf383MPc=;
 b=D/nuJTB4UiWUyQ3ZR15m+AhcyrfOgU6ujSchyc5pPJECDl6K4DUPPg/tst7ckn8DZflFyfN0g79RAwv2Sad4KpLyq/RjD0aL3+s1nNnVIbMdEuxEXiFuzGCgy8VIijsKaevPvzZhSF+CjTlklCHFp6KwUBJJDQM0gF2yUpNWTol79YyrPkaNrzcniii1NIEBLOSVv5iI7ufznhyCLQDpYQt9MZ9ndkSQdvuBt+mRD2uGB5llBAASAAfcpXZ2qoNG6I9MzUt5Kg4VD6UqH92iR41P3JRuXKImv7DvGcAQZRd7KrLaQnbIWpMJbMXMxd7ueP3RMB8EGAaSPJ+YmNP26Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibxgG+6CidkBhV6nl4DFcpPFUMK42wuWUFwpf383MPc=;
 b=pUouazqO3CHdWj42BWiKglDBNZIqhiJLsmGxj3gUE4cM1Je/z/MhF3kgGt4Sr+XHPZEmvibyL78qTx1NWTxaKme+bJHHncDGHvcrF5u3pn8R/ss9HBWuXMTqNGvCHA+DNgy+gWWiluU47XeAMmsEBCddOvMuq8sYvSfQi+qSd2MqjXJPsjZX8y2wLewFnMVETuGTbAO3YUyganf7huh+Chqssj9ARYHOB+KMuwheRL4458Zd0XMySJc41YKVy0TKA/mrEyyLOF8AgcUGynyx6ND3/TuTRq5yPxsp/mXtwvdVBbmL/ccq0gRHI1SiWBC9pAu4KFA0OxlNUoLtG2KRtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5801.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3a7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 15:17:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 15:17:28 +0000
Message-ID: <a7c8ca61-26da-4714-9f6b-b91ac8e2a8d0@siemens.com>
Date: Mon, 18 Aug 2025 17:17:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 4/4] ti-am62px-sk: enable data
 encryption
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>, cip-dev@lists.cip-project.org,
 vigneshr@ti.com
References: <20250722101551.1727649-1-s-adivi@ti.com>
 <20250722101551.1727649-5-s-adivi@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250722101551.1727649-5-s-adivi@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0199.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5801:EE_
X-MS-Office365-Filtering-Correlation-Id: ac26aa37-48bb-41fa-080d-08ddde6a5840
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UEtiYnZqRGhDTGNSQnpxb3FWUDhFbUI1ZVR4WFJiTSt5SmY4L29vczZLeTRZ?=
 =?utf-8?B?SG5zV1JTeDRvbkRJL0Y2YnlKS2VzSW1EUldwM01LMVpNWWN6c05iY2ZmQUFk?=
 =?utf-8?B?aStlaGRjUDVpNDh0VXo4YmhDakkwRjY0ditNT1d6ZkpEeHZCeU1uNHlxY3Y3?=
 =?utf-8?B?azdNSnk5Z2s0U0JPbHV3L1FWeHNsTlUzVG1EaFpiOU5yb3RtdG5LSTlJeUtW?=
 =?utf-8?B?dnFNM1I2NS9LSDh5a2FFWDNXdkQ0V1JBYmZzQ010OGdmL1E2L0poZlVFYXFZ?=
 =?utf-8?B?d0dqOFVyb1EwNFhTckVUQVd4NGkxSFBnZ3l4Yk1tMUVuQ2pVMG5pYmZTWVh0?=
 =?utf-8?B?cTFEV1ZDSXNINXFFSldsME1VZmVKckJ0S1U2cUJEQ3lGZW9lVy9xSjFheVg1?=
 =?utf-8?B?ZHhIMjJyTU02anhtZFR2RFlvQWNDMldaSjNNMXpPcExicVFsL0lQaTV0d2s2?=
 =?utf-8?B?VmpuZUlqYkR2R0l1T3REdTVoeElmUjh6NUxuYXd5aEdidnFUQzY0bzE2SWRp?=
 =?utf-8?B?L1BKTEd2R3ErNTk1aGp3L1hUUjNrTEJtQ3JVaTVzd08wbk5kWXhEbkkxZDJM?=
 =?utf-8?B?c29kSlVJU0dQYmlCbk5jMm4yMUJ3TkVqN3hkRUs3N1RRQ21xd2tZSWFyMnpG?=
 =?utf-8?B?Wkp5NGhuT2c0eUYrc0c5aWc2LytPZno2TUlxWkdteXFQL3NYZmkyNXZxM1ZW?=
 =?utf-8?B?Tm9WZmhzbmJTYmNJZ1cyazl1UUJ6ZzhMaE1TMjdMYlpzOSsxM3dmRzhhTlVk?=
 =?utf-8?B?SWpodllWZGVEZjVFZGRYbk1pMXVsMi9vc0V5SkY3OWJiMEhRcms5VWRZTENC?=
 =?utf-8?B?OGhNVENGTGg3bjlIdmFFYWJJSVd6Nm8yS1Fvb1N1TEtFaTVONEUwNXgza1VZ?=
 =?utf-8?B?QVdPMzBRL09zeENpRWJpU3Q0QmppYmc3QWVRZEV0SmFSVldZZXk1bE9DVzBW?=
 =?utf-8?B?d2NMUE1lcTdkSkxRUGt3QlpYMUNvSFNFbXNpNmVtOGNpODdIdndkVUdmczZC?=
 =?utf-8?B?YUdtN0hRaExsSUd2M3puRmJjQ0xncUEwWHB2elJ2SkVYb0pObVo5elJXdEEx?=
 =?utf-8?B?eURwdVA3NDI1MFdzOG5qc2JsdDlQaWVMNFNmb1hMMHU0R0hvOGZLOEIrQ054?=
 =?utf-8?B?Sy9vRVcveTdmMVFTOEVZdU11amxISUtQdE5oclZ0MWh5S0NuT21vU0FRTjJZ?=
 =?utf-8?B?aUlrQ0hKUG10SldraHVWNVhuOEpFMVhRQVhiWWFVZVR1cVRSSko5SitRanNR?=
 =?utf-8?B?STFtaU55bDA0Rlg1ODltdGtnZUhsYTRuS1RicThpSUtzVnZzNGx4amZBVmt6?=
 =?utf-8?B?WVRRNjZOTmFUN2dVY2hFK25LbVV2dmJYZW9IdFFjTkV0VFJ1VC9HWVorS2xK?=
 =?utf-8?B?Y29DZHV3b1NTT05TS0FTT0ZRa3FlekFsaGEremo5bFJBeHZyWHVVWXB5dmV4?=
 =?utf-8?B?ZU5FYVRVek8xM3g2YWtEbkZUQzlQSFhWajNpRm9henlZaUdmSGdFckw5ZnJ2?=
 =?utf-8?B?WTJYUmV3amQxSmpZVUZJTHB1b2ZxcUh1VGtHZkFUcWNKWjFFOEFkSUx4Mmtw?=
 =?utf-8?B?NVFadTdzeEJyMkUvLzJWbExEUmJZVG5GSExEeHNRYXpFVG1VNGsvaERNQ0M5?=
 =?utf-8?B?UXJYWEZrVy9XM0FOMU9STmpRcGFCQVNBNG5hTWV2ZDgyYkk4djhOa3RNM2Zm?=
 =?utf-8?B?cWI2QjFuZFlJUU9ZeUhmY2xQclBWTE45TkRVSVUyNGUvTFR0QnZibDBLMXpB?=
 =?utf-8?B?aE5VVHpkV3JtQkdzQkpBZHU1eTBDTXZsSXhZeGw0T3NqK1V2aHVGcllHdmdP?=
 =?utf-8?B?TnIyaHo0MTNZSEtCaGNlZWdpb3NXUzZaK0lPamRXSm4zcjFzdnNMUE5RVUpq?=
 =?utf-8?B?eUhvWExwU0RjVFQrNGdSMVVHaC9XeGVNRkNDdzZzdzBDNmxlVTUzY2dZRUxt?=
 =?utf-8?Q?zAWiP3m8oD0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UURpKy9uY05nbTM2Z2hrakQ1bDdza2tjRVhTeXF0YnRsRHU2N2NIby9QaDlq?=
 =?utf-8?B?QVp4dEM3UDQzbjdyU1FkdU9LSEduZWtxMnlnTEVmRlJzenB2L2RsSGNLYVdV?=
 =?utf-8?B?VEdVK3gvRlpHLzBSRytxbE0xTEpkb01rRG9ETGpkMUk3Sk5GSHBPMmQybFh5?=
 =?utf-8?B?bUI1Ynk5TEcydXVaQzhyVUZZL0hwcE9qRVJiajhYSVBNa1VYcDljZlVHbk9C?=
 =?utf-8?B?YzRDTlNFTUpwQVVmUUpRSzBRanVZeFpPSHF1ZVYvay9rWWN0MGtvbnF5ZURM?=
 =?utf-8?B?N2w3SGk2MXNOc2xza3FsRVZyK3luRlhxMG9SaVkrSUROUWpRU0pwNDRvdGxS?=
 =?utf-8?B?dDZBQmpXYkRHTy9MRjR4RE9VZlF2YUJmUk9uNHJrclppZFFLemp3ODFnbWlC?=
 =?utf-8?B?UGxDSnVhQVhIYjNQcGttU0EwQlFmMkNnM201UDA1eFBjNERhOUJ4Tk9iSGNU?=
 =?utf-8?B?ZHRpQXlJU1BvTTlrNzdGa3BIcjlnWnVBTGVVeHFOcUJlQUhTN0pzR21nQmE1?=
 =?utf-8?B?b2d4TmhxaHRibVRuYkViQVBDbWZLL1VmVnZVdmVpWUw1eHpvZG5oSHNRQUwr?=
 =?utf-8?B?b3J0T200OHNRYlA3M3k3ZVNEU2JFSEswMDlGV2ZReGFZWXVUUldaWTBTaUxK?=
 =?utf-8?B?REo2RXNiZVlrcEVNd0p1ZitnNWNTWGowMm9LTkxiaUZiMFU0SkFFWWlieDJS?=
 =?utf-8?B?VnZMR08wYTVTUHR0cG9vMEZtQWxER3ptRjdFY3RyaTY0VGl4RWxQTjRIQ2hv?=
 =?utf-8?B?V0ZyQ3FWcnJGL0JuR0tvSXVRT1pkVVB1bU5IamdtZnU4T2wydWRWcElTdU1j?=
 =?utf-8?B?UENFekl1aHYraFNLUjBoRDBCbnpyWmtmcmpBczB6Q3l5dHNvNm9mZGg4ellw?=
 =?utf-8?B?bWRoNWdNeDE5QVdjSjYvSys2N1NaeVRjRWI5MXhma1lYeHVSUysrY0NSUE45?=
 =?utf-8?B?SXNwYkttMEc5WFp5c0Zwdi9ZbWJyUHhFdUdrV2xXNkZ0ZHNCVC9TbTNqWkVr?=
 =?utf-8?B?TVZGemIrNlU1WVlUZXNkNFh1eGRvUjZHT2ZMOExEYWJEVVdiYzVsdXAzMDZz?=
 =?utf-8?B?bHNJSytoUXgzTUtMaHlMSFlUbFlWbHd6bUtLZUhZdnBzK1RoSUFiOTVVREhm?=
 =?utf-8?B?RzBIa1E3UkNVTlBYcUdXQWNUYXFDR2pCbW1FazllbHRQdVBUODhJK0J6c3la?=
 =?utf-8?B?QjNZN0ViSHRpclhGanlMM1hFLzFSZ21MK2NIbGdkTFl4MkZpMDlCQWtBTjdC?=
 =?utf-8?B?K2dqYjVtTVA5L0Q0UXM1NXNRVklObXhmYytCVk1ySFl3bkxYQVBCVVBQMDEx?=
 =?utf-8?B?L2VLTUVtWWRYVGprQ2YvNXRpaXJSWjVmVitaSUJ0UkJCa0Z2K1drUWJvTmxE?=
 =?utf-8?B?RVdRSUx0dEJnOWhHUFFvYWl0TmtHYy9HWHNhRklxSVREK1hBMUJVdEVPcW9m?=
 =?utf-8?B?cUdIa0tlNFdTb1BBODBsV25YZ21XZGlXb2c0Q0VVWTJEcVRXbWxDS2hCSlVP?=
 =?utf-8?B?NTFneTdHWDU1bTc5Vnc4cEM4TmlTdGdFT2pjTS9scGVFMWpwc09FZkwyaDRG?=
 =?utf-8?B?cDIzVmVHaWY4WjlwYm1UUThhN3VNaHFoTzZ2MUNBaXRMRTlxZ0NPbUltdUJ1?=
 =?utf-8?B?TVZHOFgwbDdQSUxzYmllcnNNOHpoSUIrT0g0WURsNDBiZUJWQlZPcDNCTlAz?=
 =?utf-8?B?d1h6RENZZm9pcTFySTVxZk9HdFNDdHRTN1RyNy9UNjZ6empjL01tbjcyVllT?=
 =?utf-8?B?NlVHWFJmY0lzeVY4SjlleGRNTGluUENMNXJNZHNNUVpHcnBFZ0NPNHRtT01h?=
 =?utf-8?B?dnlnTUcxSHV1ZnA0azU0QmtnYSsyS2FCQmNmNkhXcStaSUhmdWVpNTNOUFZo?=
 =?utf-8?B?clZrQlpaZmkyUXVVcmcrMXhEZFlxNG5jTHI4VlkxT1dOaEptMW1tUWM0Y3dP?=
 =?utf-8?B?WkZUUjBRYk9wSWtHTU1pVTFWQUZKM2c1NHRxQTBTbzY4RzZPYStSOHErK2xN?=
 =?utf-8?B?dnFUeVNudnNDTEFqVlpVS010VVhUQS9GOFRxRHRDZkxBSWNQRjJQN2lzTzRr?=
 =?utf-8?B?T2t1L2N1dmZDSTlMZWtUNWZDM3M1UC9GcG9rQ2JDcWhvM1JrLzdBWTFHbkZU?=
 =?utf-8?Q?odpb8yqII6y5/UdYi7lw7ZC5w?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac26aa37-48bb-41fa-080d-08ddde6a5840
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 15:17:28.6624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ta5zxYbGi5nOE9EiniXL2oaVst5W9qL7COtDp3dg4iguQHpvcFpDRMnaDDU/XVULDHY4jFp44mcnEgbWBQntVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5801
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Aug 2025 15:17:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19753

On 22.07.25 12:15, Sai Sree Kartheek Adivi wrote:
> - optee-client, optee-ftpm:
>   - This integrate Microsoft's reference implementation of the TCG
>     TPM2.0 as an OPTee trusted application.
>     Since the OPTee secure storage on TI AM62Px SK is RPMB-based, and
>     the RPMB accessing is provided by linux tee-supplicant, this TA is
>     only discoverable when tee-supplicant is running.
> 

I started to refactor isar for switching to optee_ftpm. I'm collecting
bits right now, some are sent already (isar patches), others will follow
ASAP (wip branch for isar-cip-core - huge hack still as I'm enabling qemu).

I also tested in-kernel RPMB supplicant which nicely obsoletes
tee-supplicant for us (StandaloneMM + fTPM), at least for kernels >=
6.12 (needed anyway for stmm which was merged 6.7 or so).

> - optee-os, optee-os-tadevkit:
>   - refactor optee-os recipe and add one for optee-os-tadevkit which is
>     required for optee-client

We should not require optee-client anymore with in-kernel RPMB supplicant.

> 
> - u-boot:
>   - New patch to add ftpm node in the am62px device tree

I think you already said that this is not needed. At least it is not for
the qemu-arm64 u-boot I'm using here.

>   - Add rpmb-setup.cfg for setting up additional configs required for
>     enabling FTPM.
> 
> - cip-core-image-security:
>   - Add newly added optee ta packages to cip-core-image-security

Not needed for tee-supplicant anymore, but maybe there are other use
cases? But that should be discussed with the security WG, also regarding
maintenance implications for the additional component (even more if it
should be built from source).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

