Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD29CCA476
	for <webhook@archiver.kernel.org>; Mon, 13 Oct 2025 10:56:48 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.8])
 by mx.groups.io with SMTP id smtpd.web10.40669.1760353000225282376
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Oct 2025 03:56:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pf5e4mak;
 spf=pass (domain: siemens.com, ip: 40.107.130.8, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GvYXMZCbWyNf8pEhTHBbHWb0uPWqrYOjSo6QE6Y2boXBkA0VtWid6FHFtkFn8XJ34o4esOPuZz9JMjMx/tp4Cyj3YaaTO7aIYCTO2+1aC4WlFs1kXc7+myKKvbqj/ChJ1MzeTMVBOM1zCnrQYH+cNOpnWFKpxInBjhtzqsLXkGQpa/A0HWukF1Yd7PuSDSVm7lV3mHJL9aMPrSfh851PmfuwXrMSZHRo8zZbb0RUXF8XXl+YdLLs9fwMPgm2UdClgjE4tUdF2yNN0TV38yZ3asL5jrc5GyFpdBYsu8pZiDSwG5Cjer26trEZertlS45AyEWk7zFsMtS7bJeX4L/FLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czFKy4PldyLDKwM1iPXtBidRDkKYdHGllnNlfsrh/rs=;
 b=od7pMHB/62OPriJ+xS8kB4D3QkxK7Ig9Y3AzaSYK6x5jO7XBbrkMq7DmCMqwYC30Bz8+TB8ZLxZZmsiH694LFRmF8s+X2oT2lUVYvtDu4gniMMurapR1yPprWXqOjdeV5OKHwqoAuwSvqDpqmD8///0di9aNDCkmDpGLu7JqFSST3ADqfOhgrlRwkDPeRBweAN+DdTe44BzZyqkDFbR3Am4E/Eqxh9HaPfT90OxIkW7XHXotClLr/xtFA8SFqtosprq1A8RL6U+GwK1Qlq2wUWceFMBJjZk6/j7fMH17zx/3Zm+Rw0w3bWyEj05RCAXJ0sWNaj+drNIVu8CyWdErYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czFKy4PldyLDKwM1iPXtBidRDkKYdHGllnNlfsrh/rs=;
 b=pf5e4makIWWooUTMWXa8hHJb3er+HyZe84bIQUwUNz0Vc9fbB0fq10VdcxYduofWKdl1PzAhWuX31E0kEiEmc2xR0XgPnmWfbgPvY6n6r88gP0SeXX+QJUUO/METfQs/mvywxFe5qiPzKtLuhSjf6wvadrf+CMFHgL6OPQ/1+P3Iy3cH8Yb0lgx5cM3vVJNctAEYGVU+ZRZv6BaUqHqnpxSgR04kEclOt/3vaiE/8Z4TmxXWbD//n+bJMg7FmmiJGS5o1tYAXkDKnC2spI28aPOCFgEykrB4M8TjQvTzO6SNldonx1v9Xa1vbu4U1GSmi6cWxcs1hGL/3t396c5aiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM8PR10MB4049.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Mon, 13 Oct
 2025 10:56:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 10:56:36 +0000
Message-ID: <232ddcae-a297-4e7d-9898-f34edd3671f1@siemens.com>
Date: Mon, 13 Oct 2025 12:56:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] isar-cip-core: on-device tests failing
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org,
 Chris.Paterson2@renesas.com, dinesh.kumar@toshiba-tsip.com
References: <53fe043c-eba5-4d8b-826e-5846efce7d57@siemens.com>
 <TY3PR01MB11075F7F38A4345A60D5FF028C71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <3643259b-7e4d-4e38-9d53-b0e2227f9931@siemens.com>
 <TY3PR01MB11075A9F4E791BBC04C5EE28DC71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <c8e57ef0-6f4f-481a-9e36-214f44fffb5f@siemens.com>
 <d196dbf9-7c3f-421b-a80c-2d39cfb6e27c@siemens.com>
 <TY3PR01MB110754E7268909F7468881081C71BA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <638abd24-8fc6-4fee-9bf4-679b51c936a3@siemens.com>
 <dcc32fbe-2b53-40de-aca3-0bb0e9bdf481@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <dcc32fbe-2b53-40de-aca3-0bb0e9bdf481@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM8PR10MB4049:EE_
X-MS-Office365-Filtering-Correlation-Id: 4529b1c3-2c50-4110-b513-08de0a472da0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SVVHZWU5OUNBT3lERmF4RzZ2bGhDV2FYUFRkR0ZuVXFQQW5tblF1ZDg3aWRR?=
 =?utf-8?B?STZ6eDd5bnNmOVlNcHB2UzdVajgvb3YzRHBVUDV3NFNnRHROMnM0VktCZmxz?=
 =?utf-8?B?dCtyN3h4YTBvN2Myc0JmOVBZUnl2RUlFYVFReVp6a2NDZmZlWG1Ldmxnd041?=
 =?utf-8?B?ODBaaWJsKzVpanFLaVBDSUl1VmNBUk5sMi84VEV5eFNoS1doYi9zcG85Y3BR?=
 =?utf-8?B?WWMveGkrQk9jWGhlZGwzRU5MVmx1bnpPbExDZk9MdE1ETVJuVjlMbE9KWExD?=
 =?utf-8?B?Mk50VGhGcGkrQkJxRDlpZi9qcThZTCszb3lLU2E4VmI4YXJnUzY5Skk3OGc4?=
 =?utf-8?B?d2d0Znp6NmZXaWZVRnNXY0Q4UnlxbkM0MEdUcjE0ekYzVHBnczlMbjJmYllj?=
 =?utf-8?B?RmRkQ2dSTEw0Qnl1ckg0T3RGdEhGTTl3eFB1QTBkUGFMcXNzNG11VndWV0x3?=
 =?utf-8?B?bUpRa0puTGlJbkljR0N1cmdEVFV3V3o4K2U4ZmdVNkZrR1h5SXdFVzJaTlEv?=
 =?utf-8?B?cnhJSGtDNG52cWRLT3IzeVNWeWhMNUxOeVdBL0laODROQndML0lOK1pvdENV?=
 =?utf-8?B?NEgwVzFBSTNOM0tsOCtiSjB1MnFQV2xzYUJ2dVg3Sk94T2NvcFhSbGxSaDRM?=
 =?utf-8?B?MVFnQ2pMSFgyVStPZFdJY0FuVkRUeS9scmhsSXhmaHZkM0w5VVQ1eDdxWkM1?=
 =?utf-8?B?VStrdGJtQitUWW9pZ0pNNkxSNHpkL3BremdNei84TnpUbmxyeXVyaG5VUFlx?=
 =?utf-8?B?aFZEMnFyS2wwOUhhcXVKMVQ4dXhEekh0MVJoYnBmakdoa2phUkMzYktHZzdj?=
 =?utf-8?B?eFluVGlHc1JrVHlHeHBUenorMU81YmZtMjFrY2FObWlUMWhQdFJBTjVyUUJD?=
 =?utf-8?B?NzE4ZVppOXdkbVNWSWJMREFhTHJlaVc1cjBDdU95WGR5WmdITEJ5N2VVK3lY?=
 =?utf-8?B?Y2NXeElhUEYxMjVKS3ZhNGk5a2ZpS3pGNVFnOWdLVkc0UmExSFpRTnVnY01m?=
 =?utf-8?B?Rlc3YVNkOTk1UTNhcG14bDhxSjUraFVZZkdMOUd4dnFVSmxLL3JmdGJtYUpK?=
 =?utf-8?B?UmFvUk5hK2VOS3RSS0Z4cUw1ZW5XVVFYQWJNd1FSdjNZajk1c0x0RWdQZnN5?=
 =?utf-8?B?UmRwMlEwb1ZibDJDOGljbXF2VTdvTDIyeUNtdU1QVFVzWU1LcW0yS0dvZVZL?=
 =?utf-8?B?L1doV3pkYnU4akFGaFpMVnRqNVJPaTdtcU0xNzZaRmt6ZG9VbitKME9kczM3?=
 =?utf-8?B?K1FSMXZ5YmJyYldkRWl2V0Rma0Rycjl4Z0pxdHZFM25QZ2hDc0tFMGZBZW8w?=
 =?utf-8?B?aC9pVjgwRXQrM2VFMkVBYnRhUVgrbEtDQmpTTWdqMzB2UENxM05NUHRyUlJE?=
 =?utf-8?B?WGd1TXU5Z0JWZTVJK0FMNUx3Z3pmUTFkL2FtamY5Y3g1WXpWd1BWTG1neHVS?=
 =?utf-8?B?bWlqb3ZxZlg0WUw0eFdmM09wMkJHUlRMTDMzY1NGcjdGbU5ZSFRIRnI3Vmhz?=
 =?utf-8?B?OUFGN1IwVzhDZ2pJNm96RUVSaHBCaGN0TFR4dGlrSk1TRm9pZ2dmUU9BQWN2?=
 =?utf-8?B?TDJTbCt5b3Z4Y1VXOGdiRERqK2JtUGZmeWRDSXBjTzR4N1VlNFR3b29UZXFj?=
 =?utf-8?B?bXZ1R1NVL2FmS053RmJhajFxYmtrMzJMVll4Mk1uL0x4Y21qYm5pOER1VEVQ?=
 =?utf-8?B?YXI2K2VvM1F3UmpNUzB1Tkk2d1BkSzRpVjBZU2NGT2UyalU4bUxQNzkzMngv?=
 =?utf-8?B?TWR6bldTUmRmNHk1VXpZNzM0L01NdExMR3I5WGc4cjF2Y2RRSitDUWl5THAv?=
 =?utf-8?B?NS9tcU1TMW9oRFdna3VIYjhWaDUyS016SmJCNjE4emV0dXVQMFcwSGRkZ0J3?=
 =?utf-8?B?MzFYTXNzYTdoT0JNN1R0LzU3N255Q0V5cXBQTExEd0dGa3c9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QmJHNFRoWXRjODB6NFN3cWczSHNPbnRmU0d5UDJkUlVnZ3lqWC9Hb0VHOFpv?=
 =?utf-8?B?U1dQT0xXdUc2cWQ3R1dnbFpvNXdhY3JLRGt5Wm00WVNGY1BhVW9HOWhOa1FQ?=
 =?utf-8?B?ckNvOG9WTkNsZzhjUTFlYmZFcHhTSEJ5WWNQbjhyeEx1L0dERHRsWnZ2MkZT?=
 =?utf-8?B?UkNkMUxseFV4UWFtbDVXb3hNNktPS205VzFXWFNHbXlDRHArUGlxTTlEcGo5?=
 =?utf-8?B?U2RmSGVKZjgrUjl2ZHRZVXlUOTkzODllWFEvSTlIWDlZYndHQkkyTHd0YXZa?=
 =?utf-8?B?djBibEd3c1BPWk05MVdQaThJaHE4RU1COU44TnhlUEhpZnhJajNQNFI0S0dP?=
 =?utf-8?B?UWVkTjM3RlZGWXBHOHJiTDd6MWN3S0ZZWWxKb0RnQUw1Rkx0KzZUWlIwWEdp?=
 =?utf-8?B?d2ZNOGlPQys0TnEwNW9JNVdHL1VFRGZiZmJYaTVMcVNHaU13TFJnVkpUTFlO?=
 =?utf-8?B?S2U5eDBURWpJMFpOUGdyR0g0ZkpxTW42N2NibTlmVXJmd0JjOVBaKytMZFFt?=
 =?utf-8?B?VDRXN3plMEFSRkZxdmlxSFZ1NU9INnRDMW5HSndlRVNhSmt3d28zUkxOenhR?=
 =?utf-8?B?UnI0MjZLWGtxZTBlOUNWRXpzUldyaHQyT0c2WkI1OHZRZS9raEZqYk1GTWtK?=
 =?utf-8?B?Vk5xeXY0Z2FkRm1vbnBJV0V1cmtCUXRKeGRlbUpMRXNMRTNTV21PblRKSGN4?=
 =?utf-8?B?c0owb2hUQ2RIWGhsWXhVMTRZY2gza1NBVGlpbytmNHoyM2xadTl4VEl2YWJ0?=
 =?utf-8?B?YjNRelJyd3UrL3poN0l2OWVydnZ2em9vT3BLTEJSZllDV29MNWtIUGJQUE14?=
 =?utf-8?B?K20rRTBXRmpkSWJZYTh4QTdvRjVWNmhXSTROZThlSUV5QWF0a3g2T285YUpn?=
 =?utf-8?B?YStERG5KbStUZzBwcjcxeU1VcDhoV0dwQm92NmhReXBhODVoM0RWd2x4SkhD?=
 =?utf-8?B?R2hOckNOOGo3RUpxcDY1bW9tZEgybW9FTE9SUFdUQVBsdW9raWlCenJxQmlI?=
 =?utf-8?B?dllQZ3FrbVRIMWdsbzh6blFMZ09BRHFudFlLUlE2V3YyWFU3MURJS0NDbWY3?=
 =?utf-8?B?bWRWUk1MM2x0TGI0M1BvdWJoUm9rODdZZ3dNWG9XY3lNVmVFbEN2UGtvenhY?=
 =?utf-8?B?SmxFY0pZb2gyN3dmYVJwMmxlRkFVT2Qrb0hLR0pIaEI4cVhlMEhhU2QrcTdW?=
 =?utf-8?B?dFNwaTlscEltWUIwanVlQTZ2ZHlBT3l0QmpPLzNObEFDZENuK2xpbm9YckFU?=
 =?utf-8?B?UWhpYk1CR20zZjdPRGd5NllvZ0U1ZUZoRE1JZ3FmZlpzT3JJWGRlZDRJL1F6?=
 =?utf-8?B?ZmpTY1VXZXphV0kvOXozQkFMNW1LalFkWjgwTU43V0xDeFdNSmRLOWZVQ3Mr?=
 =?utf-8?B?SVRQcm5CVFphR3V6MGt2R3FQMFFVd1FWVVNzN3RrNTZkaDdvQVVWZ2VocTBJ?=
 =?utf-8?B?UzNKdXltNEhvMVFJQ3dYQ1F0T0VjdUlFUnZRWVRlTWNCeGdkcDdRUzBkWmwy?=
 =?utf-8?B?ZHljcFFjTW16eTE4eDJyYmV5YWFlOE1hZ0ZOL1Z1cEJWMVNxa3NmYm5XeXBN?=
 =?utf-8?B?MkdUMzVZNU1jSVhhd3M5Z3JXSVIvVFpDR1dNZG80dndkRHFPUWJHRGx2VFBU?=
 =?utf-8?B?d2RUclQzSUErVmYydjFwTHFpb0Mvc210NHZlWTFmSnZvWjBqM3N3bklIZDEx?=
 =?utf-8?B?M1kvVEdjQmpmV1pVYU95SXBTSzRMdHhIWS9yQ2NPNmU5TFgzd1h0dFZlY2t4?=
 =?utf-8?B?ZDBSKzVKWjZ1OXZMTnk1MkwxdzVqU2pyZXFXbi9vZDBvZ0x3L1RaYjBxR2lN?=
 =?utf-8?B?L2NITUdnMVRPWWE4WFVjdWRnRm5RMGhmV3lhNXdUL3U1NWpEcnl1MVlSZFZE?=
 =?utf-8?B?YlVTMEtOT0tjWVVlWGZQMHJ1cG93d0diUUNxTU05Nk5rN2ZoQkVEc2p0eWdT?=
 =?utf-8?B?dUpUeGpKTXRnMTh6SU1EbW54b0VQbEJ5YUhIOEF0Z1lZSHJlZHIzTU5VNG9G?=
 =?utf-8?B?bGIrTDBSa3dIT2hVZUFiUGhTcDlXTm9OOHFEQjR1cDhVZGsrVXdYQmtRbXhL?=
 =?utf-8?B?MHVtKzNmOGRiUnlEV3JvU1JmRXhpWUdUZ0M3ekovaWJVMzlRTGNsUnJSeEJR?=
 =?utf-8?Q?ho+A0wOIuwzo/M1AJbx+1Ki2v?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4529b1c3-2c50-4110-b513-08de0a472da0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 10:56:36.0490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ngtos3a5SuFlzGvh4coBPScsmsCA+drFdVNDgmPJBVH/9jbstwoCFfHzhOujRumScuwFLGiV3cSSaw0xltarrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4049
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Oct 2025 10:56:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20170

On 13.10.25 10:51, Quirin Gylstorff wrote:
> 
> 
> On 9/29/25 15:56, Jan Kiszka wrote:
>> On 29.09.25 13:36, Shivanand.Kunijadar@toshiba-tsip.com wrote:
>>> Hi Jan,
>>>
>>>> We have a problem with the on-device IEC test now. Retry didn't
>>>> help, and it rather seems we are handing during the TC_CR2.6_1 test:
>>>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/
>>>> jobs/11513053235#L2101
>>>
>>> In the above test job, the test TC_CR2.6_1 started at 16:44:34 and
>>> failed at 17:39:25 because of timeout.
>>> It is almost 1hr time, there are no prints from the device side
>>> during this time, so don't know what's happening during this time in
>>> the device side.
>>>
>>> Another job https://gitlab.com/cip-project/cip-core/isar-cip-core/-/
>>> jobs/11509181697#L2062 here timeout happened during the test
>>> execution of TC_CR1.9_5.
>>> The job started at 13:59:34 and timeout occurred at 14:56:53 so here
>>> also it is almost 1hr time. And same no prints from the device side
>>> during this time.
>>>
>>> In the job https://gitlab.com/cip-project/cip-core/isar-cip-core/-/
>>> jobs/11513053235#L2101, the test TC_CR1.9_5 is completed and it has
>>> taken 519 seconds.
> 
> I look into last logs and it is mostly 1.9_5 which breaks the test
> execution. If I execute the test suite again the test will also fail.
> 
> https://lava.ciplatform.org/scheduler/job/1313908#L1854
> https://lava.ciplatform.org/scheduler/job/1314503#L1847
> 
> Also from the inspection of the tests logs on the device 1.9_5 is never
> finished.
> 

So, this is apparently no longer an infrastructure topic, it's a test
case thing. Next question would be if anything related changed recently,
possibly in the shadow of our general lava issues?

Reminder: This remains a release blocker for isar-cip-core until someone
can explain what is going on here.

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

