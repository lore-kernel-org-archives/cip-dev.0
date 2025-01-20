Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C0DC02181
	for <webhook@archiver.kernel.org>; Mon, 20 Jan 2025 15:10:44 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.56])
 by mx.groups.io with SMTP id smtpd.web11.38523.1737385842626017014
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Jan 2025 07:10:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ZlSJbhzO;
 spf=pass (domain: siemens.com, ip: 40.107.20.56, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1z/oxzwvNQ7DakfA+FGDUHDmmnl9ofeR1uj5o7q6VI7g/FIPIELic9WIh8Z9BtTsyP7BEBIQ7wwOcmHkm1ZgZBig6oEz5wAXAMsnyd5omY5Fq8n/TubjC1mGRRPEbIAyvwtz1sIkdbV1JRAAYjWMxj1wKmoftS124JRL6QFAAHkfI+2tyc42gInOnmtem6KNVgyRbmzm5LqdaDVmwrPzbaUF3inM+wiXA+lnHihiI/olC+gzZWRZApwOH02Kk/TKhHIDLPryptLDVH5iaew2on2QvoGhO8Xk1Gk2KrfOLqGnkO2Aws46Z1u1HG8D10M1k47ttOKukeAq6/Z2M4Rkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGdBGFk7K5Ut7OYgCOR5RF/iIBCgW85ezTNUgUKzmGA=;
 b=IBlP9CTgcz81CnAdotxihX1RvFUpQLEc3DHl7YaZWzq/v8Pj8d8cOz+US33X4mUA9HQChA+ip50jld/WYJ6hhafvsCE3ytwCVdcqlvxYsbqLJiejNRfephrDDMhR6CQ6xx2ilfm+knbt3WTsWlv4mkWwqtXOWmnd27VYpkqrPvoelcDu5XkbXnQbqkEXrnvuPS5bW77XdXUK/Bm9y4wodtHnImor1326QVFd+76k1Re5xwghJAPP/X3soJfMbNtSAQ7E0ElL4mu4kJqVOlAmpY5MI6xD+O4tLncEyL4Nyq3fXsKauOGI9j02vRQW6PGy9Ju75eNe7Hl3yxC3s00VaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGdBGFk7K5Ut7OYgCOR5RF/iIBCgW85ezTNUgUKzmGA=;
 b=ZlSJbhzOFNXiz2EdZnThOxwo8QMSmRoX/7315F02keI8P74ypeQbBZ3Nx3LNFnHeyXYyl/V0D7qkea3oHofcaQJT9ev0wyHdglN6GVkj2sAAxJo/SX90vYPYBeI2++nhBab0VD2DJi4xlWslGqHwnc31HVYr2Hr+32Tj1qlblb3/hvZ4X0Bn+MJsLqPKN0Jvk9CmldxSKKAktVdIGrPwzUkf3sye6MlD8TQx17SmHSDYXfLTWpacZrh2ANA0mlobCl3JPZTB0G2xgcFvZw3kWVzs3kaSm5cXYlj+/btTPpT1lAFCSjwN3bNCq1T7rz8mbqcYVKcgXq5y6r+lmd1ovA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7155.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:60d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.15; Mon, 20 Jan
 2025 15:10:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8377.009; Mon, 20 Jan 2025
 15:10:40 +0000
Message-ID: <89e3feb1-a98f-422c-ace6-5ccd9d8c23f6@siemens.com>
Date: Mon, 20 Jan 2025 16:10:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] initramfs-crypt-hook: Optimize disk
 encryption in combination with expansion of last partition
To: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Gylstorff, Quirin (FT RPD CED OES-DE)" <quirin.gylstorff@siemens.com>
References: <20250120123425.79292-1-alexander.heinisch@siemens.com>
 <0c27d834d60e2408da0e016254ad260e5dd534e5.camel@siemens.com>
 <612ec933-6036-4df7-bda2-c07e4989a6c8@siemens.com>
 <59ebca3ae43ddc47918de2aca962991db517fb43.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <59ebca3ae43ddc47918de2aca962991db517fb43.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0077.eurprd02.prod.outlook.com
 (2603:10a6:208:154::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: ae467dbc-92c1-4e26-65db-08dd396499fb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MGZuWEhiL2lnTHEwT3NVZVVnYytuOENiak5YUFJqSUVGbzVuTFFRcUNSM0tF?=
 =?utf-8?B?SExQSytXVzFIYzVyTG1tUHorbWlaa0lUZ3dIQlRHMWNIRUNkUGFIaDVYV2RO?=
 =?utf-8?B?WE5QdGc5d0NrT05YenBDYkNid2xTRFBDUzBLVlk4ZWNDN0ZOMVpRTmlvSVh5?=
 =?utf-8?B?NWdlQm9GbUpxTlFwNGxUNkNBaHZPUHBwa2hVUU0xLzhlWUFCd09sVGRubWsw?=
 =?utf-8?B?NUhGZWp3cXBXekxIdWRqRklTY0hST1dFSTNEcy9qaU9Jb3A3NkFxbCsyZ0x1?=
 =?utf-8?B?cHp5VlArR2NXS0l5dkpBR0dFeFZtWEJnK3ZHVkxyM0VmUDc1OXVVeElVd2xT?=
 =?utf-8?B?Y2U2WUhJWGdJRHVMQjd6K0tPQTh3VzlLejYxYmtuZVZzdHRqNWJEcytxeE1P?=
 =?utf-8?B?QVRhbnhqd0xuaUZWUFpRYmFEczV4OVFreWZpZmw0Z0ZsK3orckExbFA0SVRs?=
 =?utf-8?B?UEhRai85LzNZN29nSUtOZDVLRmNJdStueWZWVy9Dam5NaWs1U0h0UlpSY1I3?=
 =?utf-8?B?WmlxNDlZZ0NRclh6T0xTalB4SUhmWiswNkNPR3BZOXI1dy91L0h6R3VQdE9K?=
 =?utf-8?B?SEhCaWtMaHYxVTN3Sk1oVUtjWjJyL3E2OEJHeVlxQi9rRW1nVjNucHlDcjNr?=
 =?utf-8?B?eWtUUUtlbFBsTm00UDBReTQvNmhRRm5zMUdubXRzWGVOMHF1TS91S1ZMTmNo?=
 =?utf-8?B?YUR4WjRqTDJhbWFWcHFNZElhUVdEL0NxVVJISndHa1daTTlWdEpHWnhWalR2?=
 =?utf-8?B?VVFOMTRtVHA4MFJYb21vdFpXeWtzb2U5KzVOZ3YxcnpLRHpiTGJLU0JqYXo1?=
 =?utf-8?B?S01kd0RibTFhOWlEdi9FZEwrUlhHQ1ZWNExmVWNhM2gyUlZuakhOVUFXTlJp?=
 =?utf-8?B?VldPQ1M2ZisxeVQwanNZd3NkZ1FBdUdZYlpzYzA4bjNyN2V1N1ptRTZxK0Rt?=
 =?utf-8?B?YVp3bjRvMXQ4WTQrbTg4ME1zSStzWDcyV2hTTllIQWRRYjFVVW9tYkdia0pG?=
 =?utf-8?B?cktDVmF5bXJkOUVWTHZxUENyYVE2NzAxZTJxRzBDRks5RlJGeThDNXZvZ0xL?=
 =?utf-8?B?NVZBbDNkRnQwTDBCekhCSEdqV3Y2bUVsWmFtMVkyUGRXWVhsVjhYRG96NUs0?=
 =?utf-8?B?eEdySmxQV3BQZlJ1M2s1VlcwNzZLSHB2RklLc25FKzhBNjBUVndjRHpRTnFY?=
 =?utf-8?B?M09tWlJramlCdGtVN3Q2THA3dy9NSkFKMU1vVVhnSC8rQ0toNlNjandXT3N4?=
 =?utf-8?B?RExvTWZ4UVJTTGg1WkFPVG9tRlpjMWhZVUFybHNGckNLbXk0V2tiS3RhWFA5?=
 =?utf-8?B?ZUNGR1MxQ0J0N2x2Mk1id1puY1VIUU5uKzUrSVE1bDZnWlVsc1Y3NktqdkVN?=
 =?utf-8?B?R0NSakV5Nk5IRVhub3hVbTgxL1EzZGtKcVFYSEp5cDIvTVZ6aGxjY1l2ay80?=
 =?utf-8?B?NHFzeklNdVZaNnZvejFTcDdpTm90ZWRrbE1xaC9VamdSL3ZDVFRZS0pSVmhE?=
 =?utf-8?B?SkQvbmRidmQ5S2tVbmprUU5pZjNwZmVyZENXdzdldTNzRDdpOHlCL1hxOWhU?=
 =?utf-8?B?SlJyb2t0MGFmL0Q0alUvc1V5MVA3UGlaZmh1bnFPZlIreklRSkM3Yll2VXRs?=
 =?utf-8?B?bHFJa3dDRy90cTNvWUd6MTlBeFhvRURJenQ4dlJRbW12U1dQSFVWcmRTRE9Y?=
 =?utf-8?B?NS91Z0xaaGNaY1JCVFhhd25DTVUxZnh2U2YyZGZSUTF2SEZRbldxK1JFNlFM?=
 =?utf-8?B?cVNWK20vTmtPQzBDa0thcTV5R1VBRlA3VDZuWUFzejJZai8zVkFXTEptdlVp?=
 =?utf-8?B?UmxDVGttWmcxZ1B5cDJwd0VMNXo1VWVqS0tQOWVYMmt5UXl2ZHd5T3hsK3lU?=
 =?utf-8?Q?dquy+SJoFglWg?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SVlsNitMc1BQRW5NWURMNStNcm0wakRycWNtazQvK05zMVFVWFl1Z1Z1U1Bk?=
 =?utf-8?B?Z1lqTW8xM1BsUDd3S1RGSitLUXF0dWZhS2p1bXUxWGgzWkR3VGN1dmJHd0pS?=
 =?utf-8?B?VUlOS3JuMXZSYTFmeWI1bGpqMkRwY2w1eit0TGlyN0ZkNWNRbjQ2ODBkRm04?=
 =?utf-8?B?ejh5ajZzb2ZkVUVDblJ4U2pGMm1xSlFoZW9jUy9CY0dGYUtDT0N5dTlIMHdB?=
 =?utf-8?B?cEk4NG5wUXRpQlNZTXR6cjVpRFo2RmJvLy84SXBVblAvYkFEVGlOTE5UNW9J?=
 =?utf-8?B?aWc4RFFVT2FEbnZMbVBwb0tBZ2J1dEh5VTdnZERlbFdvN0VPYmF4RHN5STRq?=
 =?utf-8?B?eTVrbks5TndQQnk0U1JTNGFpWFpEWFc0ZHNsTUpmOURFOU5xcDIwWEMrUFRR?=
 =?utf-8?B?QnJ4SjExc1U5QWVqSUZWTjhXU0FkMGMzdUlnQWpzY3BBcmRYQ2l4NUtTeml4?=
 =?utf-8?B?K2dSZzdMejk1clc4WEJpWEkxc1RpZU1sMHl2Ty81bkx0VUV0YWF2UVRIWkl1?=
 =?utf-8?B?OVNWTnU0ZzQ4S0psVFkvV0Y2WDZwZFRRa2ZIcWJkc1JtblVTMDlkRWZ5YlRl?=
 =?utf-8?B?SEV3K0grUWF5R1FPaHhaMldJa2ZJUTdyUEFyQzFtN3FiYk4rVElIOGVTb3Vy?=
 =?utf-8?B?WnlRVkJDeW1CQk9zQ1FURkRHaXM1R0c4YThRSUQ5WVE5dWRVclFSOGtKb3pT?=
 =?utf-8?B?Q05UanE5VUdrdXY4ZllkR0F1dEJnTU44emhOMjFpNkZXc28vTjNvcVpWVFh1?=
 =?utf-8?B?OEloWVFIVlFUcmRlNC9LaWk3ejlCU0I1Z0VUUVdOMmhUdlBza2ZPUExLbW9x?=
 =?utf-8?B?M1gwMVpOVEZjQUdCbkVSYUF2d3YwWlh2cWxiT3NLUG5UampLN2k3QnFkY3A2?=
 =?utf-8?B?cDJMZzNhcytFL3dVR1JQNWxKdFNyd21QMzlLR241eW5FNjRnWlk0YjEwdVZW?=
 =?utf-8?B?bHEvRGtLT2Z1Q0JKdmdUOGNYN0wveEQ1Y1gxMmt1V0h5NVhoYW01T1RQNjdy?=
 =?utf-8?B?ckR6TGthc2EyS0g5VXU3bXpNODI1SSs2cVc4clB1YTNlVXRLZm14S2hMd0hO?=
 =?utf-8?B?eUg2S1c3eWlIL3p5OGU2czRIaGlwdjZwUU1uOFNsZzk4S2VUQWtxbTZ1TStB?=
 =?utf-8?B?OEpac1NNVTRTT3kxcVRucmF5NXdrVFdwOUVwWEJEaXp0UWdNQ2hJWndnUEZD?=
 =?utf-8?B?TFdxQnRqNVY5RS8xangvbWdkMWFXVjRodE5nWnJ5Sno4SHhYR2lsSkozUVNF?=
 =?utf-8?B?QjIrV0Q5V3hFTFV3aUtienl4cThNMi9IVFR6eElGU2FJUTNNeldQdGFhM1Ey?=
 =?utf-8?B?SVBOZ2lvanhFaURnSUtVcjBMTjNLTGRTOVZYamhQbUNObGRKL1JoMytOOTBq?=
 =?utf-8?B?YWl3ZXdoSGFCc3ZNWHRXRlN0ZEt4Y2puVFZ0ZkFROEFyQTFkVGsxV2FwYmZK?=
 =?utf-8?B?VDRKZlQ1WnpBcFpoczlmWURNamMxNnVqWVhQT05IWS9WYktmcVBpTWdJTmZ2?=
 =?utf-8?B?T3dMQmp5dDhJZmNoVTRVZWtNVVZ1Z2ZCREdwUjdtUGxabTF4ZW5EZ3lnTmVs?=
 =?utf-8?B?N2pyc2NMT1JodFVJeU4reWIxT2tGQVMrQWdDZHZJZDNlb0pCOGs5dkxJTm9W?=
 =?utf-8?B?ZHU3a1lEeHVpbFZPQVp0Y1E4Mzc4YlE5S2R4NDUvcEZYMFhRSXdyMWpXdGRE?=
 =?utf-8?B?NklRSzY5dEFka0NPMlliL2dKTERHN1JZNkVObDR3K0FrTHlNWlVFaEFMcXV4?=
 =?utf-8?B?enZxNEJxcm9yV1M2Ym1GRmg0aEZ5bnk1OU8ydnlXWGVUVHp3ODFYbnVxR0Vt?=
 =?utf-8?B?b1ZyODkxQWVTOU1tOGVvemllSkxGeGFYZ1dKQTlxNVVDSmdwMHFySWNuRTh5?=
 =?utf-8?B?bXhZZDV2aWNtTlZNMEs4NWYzNmR3YnRjRnh5ZDJ2MzJDMVZIVVJMdUlLelpM?=
 =?utf-8?B?cHVTUmgyMkEvMXl1cGlSSlloTEplZmJnQUo1OEIzRWVWM0lPQ1N3NW03WVFj?=
 =?utf-8?B?eUY4OWVVejdzUmJYdmhXcmhNd285S05GUTJvSFV0K2swVUdOWmdyaGhFdlMz?=
 =?utf-8?B?Nnc3cGsvckw2N3FYV3l0NEJQY0I1MnpYb1pBbU5uSVZKRmNXTUQ4bWR1M0Ju?=
 =?utf-8?B?NDJnQk54NTdUUzlWdlRmZU02ZGx5dk91N1lnNTZyQ200UzllcjNJVS9QUGhz?=
 =?utf-8?B?ekE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae467dbc-92c1-4e26-65db-08dd396499fb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 15:10:40.0468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uH38ZQX+bk1QB++VId7vcMDN5POfIetnJsB0OnXaq5i1GGqAlY01Qri/UxeIZE4bKqa13/wcDDpXM3V/BlLDNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7155
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Jan 2025 15:10:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17554

On 20.01.25 15:09, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
> On Mon, 2025-01-20 at 14:51 +0100, Jan Kiszka wrote:
>> On 20.01.25 13:51, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>>> On Mon, 2025-01-20 at 13:34 +0100, alexander.heinisch@siemens.com
>>> wrote:
>>>> From: Alexander Heinisch <alexander.heinisch@siemens.com>
>>>>
>>>> In the current implementation (since: 284175c3) disk expansion
>>>> logic
>>>> is done before the actual disk encryption.
>>>>
>>>> This results in reencrypting the full expanded size of the disk,
>>>> instead
>>>> of only reencrypting the sections containing the actual data.
>>>> This
>>>> results
>>>> in a drastic increase of time (approx 20x on our systems ) needed
>>>> for
>>>> reencryption!
>>>>
>>>> Since relevant disk contents are only available in the sections
>>>> of
>>>> the disk
>>>> available before the expansion, it is sufficient to reencrypt
>>>> them
>>>> only.
>>>>
>>>> This patch changes order of encryption and disk expansion
>>>> resulting
>>>> in
>>>> faster encryption (since only the necessary parts are encrypted).
>>>> The resize operation does not reencrypt the added disk parts but
>>>> just
>>>> extends the LUKS container (cryptsetup resize) to reflect the
>>>> maximum
>>>> available disk space.
>>>
>>> The thing I am not sure about this patch is, if executing the disk
>>> expansion here is really the way to go, or if we shall just reuse
>>> the
>>> expand-on-first-boot from isar (incl. fixes proposed earlier -
>>> [1])?
>>>
>>
>> If you find a good way to factor out the common code an reuse that
>> inside the initramfs, I'm open for patches. However, as we discussed
>> on
>> the isar list as well, using the systemd service later on will no
>> longer
>> work once we properly hide the keys when initramfs ends.
>>
> 
> True!
> 
> Refactoring that part out, probably introduces more boilerplate, than
> the actual refactoring will save. Anyhow, once the new sealing is in
> place the systemd service support for crypt has to be
> reconsidered/dropped anyways.

That was already done:

https://github.com/ilbers/isar/commit/004f9935102f81b18a54fc9c0940d23b84be411a

The isar service is for unencrypted partitions only, this one here is 
for fully integrated encrypted ones.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

