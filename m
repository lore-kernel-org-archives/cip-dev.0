Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A9BCA0EE4
	for <webhook@archiver.kernel.org>; Mon, 18 Aug 2025 16:09:48 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.64])
 by mx.groups.io with SMTP id smtpd.web10.79629.1755533382766271215
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Aug 2025 09:09:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=jcviNT94;
 spf=pass (domain: siemens.com, ip: 40.107.130.64, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eq3JBsfPd77RXHbNEOoFYZRD5Rb8sFe7AYdMBUBpnuYf/PTbW/jQWaomba7KdgdrJ9RtA0gbU/b/5M+JvjvtzAnTh4h3TrtMjUdBZuAIC8jar12hC85TUzqRywtI8etwTCbv5XpvzNzS8MsEG0iD0gf+ImOY4miR2nvVQTNhPrKrXU2M7zrqXNucIXHKis55uUUJJRdj6PYIVCxALtnMkoH+99ZVj/CiVvGeOiHz5h3q83ECH6gjCnpz/rMNUSp6OGnxaE1Kpu0ahFx9xnsR1xQweCf+6juD/C3AjHV0kwPeU8uB/+XH/gkYf7gMEzz1qUG57r4iCkL/Aa1ouPgr1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhySid2IS1niedwFkLH24GRNLaPdUWshwJk1AvkVFPc=;
 b=OkEIOWSig9X0RnCVnV9sSmdvVrDFcht+hulhqTinbZCEw2Z4/Vitz54r/CHeDxDJ/OzMxAjn3fqHktYbks2raj30DPVvSW21bc4MgWqq40eWaX5nAjklB3wv7pMGvRl0lyeR3zDcjg3GgFu2RKcDTXwu/X/W+BdE/1qjPdk0096lyisXZWvq+oQmBJzKBeBfIPXrnjMsMfHVfBZl0t+NvxaOi1khg1HCt+a31yTWLv64FxOg1lopNIPFemJRRZ4NqmU4rjvAs4wA5N4khD9lXnQ7VXnn1CYB86O1GWrY4W0NGRTFoz4Bk03e2nYd5i1sG07ecW7Mj/DWDv3a5yTHoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhySid2IS1niedwFkLH24GRNLaPdUWshwJk1AvkVFPc=;
 b=jcviNT94MPrWrrd6i+AwFRcVMu/27pT04eN/IMQW5hf2sxWs+/PGMFosAeLE1jx3HFigwlJhJn8xauf6TOG49iwDlA27nfnTZdSqlHjomSzB9rJvYfqtjE6vIwQVyneJLxrCCPZbWnKTG8HQgHHLs17waL4AbFkVstc4qC8Zo+kX0v6Uru/Ke63VdR7HLVDHmTjC98EKqvQoREBgN3Fo21cmoYzfmHPfqR/6f0vuJhuyT480X1UM4BkP5kZwe6zOSMQqDSTZYiIQLamSZIbHp44/Sjaef6078hOsZNCi9G8lJME44pSApKVsbSDSDjFS0DAuIgsBLoYbZncYx26jGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3499.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:137::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 16:09:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 16:09:39 +0000
Message-ID: <678884fe-e78d-4299-a4df-192e69816cc3@siemens.com>
Date: Mon, 18 Aug 2025 18:09:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 4/4] ti-am62px-sk: enable data
 encryption
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>, cip-dev@lists.cip-project.org,
 vigneshr@ti.com
References: <20250722101551.1727649-1-s-adivi@ti.com>
 <20250722101551.1727649-5-s-adivi@ti.com>
 <a7c8ca61-26da-4714-9f6b-b91ac8e2a8d0@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <a7c8ca61-26da-4714-9f6b-b91ac8e2a8d0@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3499:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c5126ca-06dd-415d-96e0-08ddde71a239
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Q0w0TFZGaklXZU1heW1FWm1mMzQvcENZS3JmdE51U1Y2b0VONUkzWEdCdGQw?=
 =?utf-8?B?NnVtcmczZUliSWVZWHlFYzhxazJ2ZTdyN2pEYUFQS0Uvdm90bElDSjVIbzFj?=
 =?utf-8?B?MHFKVWpPZkl3cXp1c0pmaEM5dEg5QXIrdTlYSnd0RmdISzRhR0cxYWxBeFRT?=
 =?utf-8?B?R0hxNExPUWorcEZsa1pENytoeUFTVUF0QlNqSCtTcmtiR1pGT2xwQmp0bkdY?=
 =?utf-8?B?N0FWcFBXV05pWVlYVkdqY2tCWDNhL3BJMEZUd21XNm5aL0Q2cnFjRFhkeHh5?=
 =?utf-8?B?RVQwQkF1KzZ6TUVyQnJlSEkxSkVlUlQ2KzZwQ3pEN2pEYlRKQVpLNmdGN2JI?=
 =?utf-8?B?SUYvRXpqdGYzeE05akxpRjY0bTZEcU5TNUF4RkRLSUdqcDd1dytvZHp3dnNB?=
 =?utf-8?B?OHp4YlhTOFh5NUtiVkdDSW1TT3g3T0d4SmpBSjIzdmpSVytwSTBnTktqV0JC?=
 =?utf-8?B?TFR6aDVGbTd0OUVqUUFmMXlkU3RrMGxUS01aa1NnRmI3aU5EckpDYk1tMWdk?=
 =?utf-8?B?ZkYvNGtBSWVNRi8xVzlZTGJLR09WQmdJSDNFTUliUkYzNWtFRkhIV2JMQmM3?=
 =?utf-8?B?ZkxWTXd1Z01OTFZ3eDJBNUE3aFVuN0ErcW1zQVFtUStkK0RIYUZ2TEYxMFd2?=
 =?utf-8?B?bUVFK3djeXVSRVBtSXZvQmJRQUVGZXgyYVVSMDYvQk4zZ01zWUtOU0ZoMklu?=
 =?utf-8?B?MVVFTmxVSTdwR0dRMzJmZUNmRXlVSU9Md1h4REtBMDJMTmVvYmlyb3c5UEhn?=
 =?utf-8?B?YnN4QXhsR3k1Yi9OcXdVc0s5Z1RZT2t1OFlsWjVnai9yK01CdVRhV1EwZG13?=
 =?utf-8?B?U2M2SHE0STZWMGFTTkJtc2Z3aldrZENNOVNPSVRuNStibVlRU1Y1NUlMRnZ6?=
 =?utf-8?B?cG1QSTNZRlpuNFNMcm5VbEIrVXRzaU5ZMTFsb2dvVHVSTm1HQmJDa3dOeXJs?=
 =?utf-8?B?d2g0TGt0OEErb0Npd1NkSkR4YS9MR1JETmwrajRjYnRmeUhkY2wxNjNTSTBG?=
 =?utf-8?B?RzFmcTdwTHVYWi83SDNXaWloNlZuNGVFNkxtVEs4VTRuV1pjZ2dWL2ZNd3FV?=
 =?utf-8?B?ZUI3MW82MDlsRm5jT2o3V3pkM0ZrUzFLR3dyQXlsNzFVcVZUcExjdzFnZ2di?=
 =?utf-8?B?RHluWmxGVzBsckpQZkNtWlJWSjNNbzRTSnpFYVlRRXBmRlJ5Qk5IdTJ3RU5y?=
 =?utf-8?B?L0o1UzJNZXA5WVNLaWI3WWlGN1BIMXkwc2owY1hXK1JTYW5PVWxFT3k4MFU0?=
 =?utf-8?B?K2NlaUFRSUdFcU1pS2dYSGNKbHVqbUV5Sndhd2x2b3B5L1hUbldGQXZySFNx?=
 =?utf-8?B?ckhid0xPY0Q3Q09qOVBBVU9mbWQzWllXb3JLZ2lOYUJXV0VhMVJVUGh4a3Fp?=
 =?utf-8?B?UUtVRUhKT2xEeXBRWlVJWUZiVlVNNDFSd1E4Z1E2N2llOThIOEdWUWQvRTl3?=
 =?utf-8?B?VFFDWUx3NUxUY2FIblZMUjE4dkdXQU5lMzFteFFkckdPNFdoeks2OGRYVnZs?=
 =?utf-8?B?cndvTkRCN0xyUFN1aE5yMlpFU2k5UUdHK2JkYnJJQmtycjBXbHg4dVYyQSs0?=
 =?utf-8?B?WmpiS0tiZHFwcGFweWdjSW1LSEhxOEE2RlBtbVN4enZmZjQzbU80Mk94WjRz?=
 =?utf-8?B?STZNRG5LRGtLdUJtT0h1WmZtd2Z5MnpUcTZuT1RwTjZ0ZjdkQXFpcWFzM2ZX?=
 =?utf-8?B?YU4rMlV0cU56WDdhWTNRcXhTUmw2dVhvR3laSEdkbGZQY1hBWUY0Qm9QeVNB?=
 =?utf-8?B?aENaUnVUM3lsUUJ0SVNJRlVBUi8rV0E4YVNXZ2hlSU9JNG9mNWtRd09JWUg2?=
 =?utf-8?Q?m65lJc9PkwsvQhFPESEYTISL+I7zsw4VjPESE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WkJtUXFVakNrUzBvVFlIQStDUGFiWVN5VFA1bS9zVzRDTHk5WERzYXJBa0lw?=
 =?utf-8?B?aHZNYUtIbitPZDE4YzRtK2gzZjBsT1ZOLytWR1ZwWVR4NmhNcWtUWFZEaXhn?=
 =?utf-8?B?ZnZjQlBhLzBvZUl3OWRpRktiYU5KM3JvOEtwSGJQeCtmVWtLZzZqMTZlTzF4?=
 =?utf-8?B?a0daLzVVaEduM3pBQ0R0VWk3cFltRi9YL1N2U05XLzJLMllFV0VxSHpqYnFV?=
 =?utf-8?B?Q2ZQTmtkYVdQbCtRbVdkdWs0TFRZTTRiNkZTWXo4YU1wVzhPeVc4QUhlZEVi?=
 =?utf-8?B?Nm10bjVKdkFjMy9xYkFTQktSbmx3VVVzMThIc3Y1Q2pDMk5WVWFaU3BlNmtO?=
 =?utf-8?B?Y0RoY2FWWXYvTFlyemREMU91NzdDZXk1TWNCT0p4Q1RNYmRxR1g1YUxSMXFC?=
 =?utf-8?B?dmpEWERDUkdvY1B3MThjdi9PS3p0SVlEZ2xSbDY3ZHFkVHY3SmkxQ2gxaWNi?=
 =?utf-8?B?TVk4KzFmYUU2eGlCRlpkVW1xdk4vZFRibm10ZWdBWFJobDhWb0FlcTdjRXZC?=
 =?utf-8?B?NGNGb29NR2pnWXNkN3BoUTdxNFl5U3k0ZkFHbkE5VGovSzQyY3lhYk1acnoz?=
 =?utf-8?B?UjNsRmF2WXZjRWxMT3R3TEpMa3dTTUYvYVNkMmRGMXoweVdPOHFLMmV4ZDNS?=
 =?utf-8?B?Ym1Zcis5MGFWQlVEZFFzV2xCeExzamtCd1BwWU55ckt2bXlDOGh2V0xCblB6?=
 =?utf-8?B?YThqNGdSQlFqWnlqckxwOVpZN016RWVWYVlEYkRLUkUzcENuOS9LYVBlQ3Bt?=
 =?utf-8?B?eEZYMURXS3NON2Zsd1crME1hY1lVS0hBRGQ4dGEyUHB2OXcvbFRnR1VwdVFU?=
 =?utf-8?B?TUYyTllnNyt1N0VFNUJDcHkwZk9YcWlJZEl1U1gxSmhZa2ZPNHY5VnhQQlQ3?=
 =?utf-8?B?eUFrSXRyN0wwRWU1TWYvUXdMVVh3b0p3ZFQwQ2JwTkdZQlNRa0RwWWxITzdS?=
 =?utf-8?B?TDREemtBUVMzbzJ2THk3Y0ZWTUZkSjlMbjJ3b2N0NXRUYStibVdpWUNpdkZ1?=
 =?utf-8?B?amtGSDBLQXY0UGpFWXlKcjhtVkNoUStXdktpMk5EaGJCbmNFNkU3UEhDMXE2?=
 =?utf-8?B?U2h5MGVCakJKeHJ0VWdWeXI2R1JqMXpzMFV3bDBQN2VQcFBPOUlIcTJKRnBS?=
 =?utf-8?B?S0FhT0xZT1FFOGczcDQ2L3lMdTI0dUV4cENEcHEvUUNhUUsvWnlFMmtzd1Fj?=
 =?utf-8?B?aXpzUG16M1NqNDZQK0hWbHB0MlFndHBVUzI2NGVHQU5hZnRnYXlJbXQzcDVt?=
 =?utf-8?B?NlQyMDluTzJnbVZnL1RlMVZaK3VtdU93Zjk3aVkxaTF2bGI5NXdqelVObENC?=
 =?utf-8?B?Nnk5NmpBQUlqcHRBbTJxWjVkVXNmSWliOEFYd2xXZ2E5Q2o0SUg4akFsYk50?=
 =?utf-8?B?bjBVQ1hrRjhwVlJzTmNnbGFmQWhvSnBWRDBRVDhST3UrM04vZVVzY2xuWkdE?=
 =?utf-8?B?d0FDU2FadjRucUUraWZEekRRbjFCaDNGZ2YwYzFia1pneWRQK2J1OXMvbzBB?=
 =?utf-8?B?MnhzN242TlJ3emJVY2J6RzVqaU93emkwcFhlcE5NTDN5bWlxeTg5YVV0UTV1?=
 =?utf-8?B?R1hsb2JjNjBUdUphd3lhUVF1cnZRTFhGRjRXbWl4WndHSmdXQzhxM1J4UWY3?=
 =?utf-8?B?Vi9WTjBhcFpQUjRyOGpYLzFxL2ErV2R4czZzV3lpOHZtdS9QQVEzT0JnaTJn?=
 =?utf-8?B?UE1rWVFvbjQycklldWRtc1NDcURnSEdKdHZkcTNBYVRZcFFLT1VjcWtxRzlB?=
 =?utf-8?B?dStySXlMb3RtejJGWjFldzNjemdkdVdSZHgrUFBQaGd4SDBUK1JqeXFmR2Z6?=
 =?utf-8?B?VFE4bWZRTnJSWjFpSVd6ZHZWdDdkNTZmRUhCbVpDV0VET2hUdUlqTEtlM0kr?=
 =?utf-8?B?emJQMWNTLzNEY290WXdsSnh3M0lScjVIUzNDcGlTOXNlSjNZaXVPTUZtVTNm?=
 =?utf-8?B?VjBiRWRxQzRWaXVDWWp2N1ZzbWtTL2ZUamplRnNVblBiNGREaXlxL2pick1i?=
 =?utf-8?B?NW0wOVFjbk51WXhtTTNEOEFQSHkrSnJ3aUFlWVdJdUtWVnRMVFlXUUVWYzB3?=
 =?utf-8?B?THFVR2ttRzN2VFk0dERydG9WdDFIdXI1bTU0OWsrQkl6SUFEbE5FY3lMTGJJ?=
 =?utf-8?B?emgvbi9Ka0VrekNYeDM0aGR2T25aTWY0WUdsbThjc09iUGc0MC9qNDhkcklm?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c5126ca-06dd-415d-96e0-08ddde71a239
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 16:09:39.2621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZR0JGMX0/fA3o+3FkhDUVUghPE6M+UPPAvZ9NWuMgDE5qe9OFnCqZEJF7K/S/kkdFQfzDFlF1GqdxEfua/s8Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3499
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Aug 2025 16:09:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19755

On 18.08.25 17:17, Jan Kiszka wrote:
> On 22.07.25 12:15, Sai Sree Kartheek Adivi wrote:
>> - optee-client, optee-ftpm:
>>   - This integrate Microsoft's reference implementation of the TCG
>>     TPM2.0 as an OPTee trusted application.
>>     Since the OPTee secure storage on TI AM62Px SK is RPMB-based, and
>>     the RPMB accessing is provided by linux tee-supplicant, this TA is
>>     only discoverable when tee-supplicant is running.
>>
> 
> I started to refactor isar for switching to optee_ftpm. I'm collecting
> bits right now, some are sent already (isar patches), others will follow
> ASAP (wip branch for isar-cip-core - huge hack still as I'm enabling qemu).
> 

Here is the change to demonstrate everything in qemu.

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commits/wip/qemu-rpmb?ref_type=heads

It's still mostly a single, huge one. Will step-wise break it up. Next
step should be the cross-board U-Boot update that we should do soon now
and that should also help your patches.

Jan

> I also tested in-kernel RPMB supplicant which nicely obsoletes
> tee-supplicant for us (StandaloneMM + fTPM), at least for kernels >=
> 6.12 (needed anyway for stmm which was merged 6.7 or so).
> 
>> - optee-os, optee-os-tadevkit:
>>   - refactor optee-os recipe and add one for optee-os-tadevkit which is
>>     required for optee-client
> 
> We should not require optee-client anymore with in-kernel RPMB supplicant.
> 
>>
>> - u-boot:
>>   - New patch to add ftpm node in the am62px device tree
> 
> I think you already said that this is not needed. At least it is not for
> the qemu-arm64 u-boot I'm using here.
> 
>>   - Add rpmb-setup.cfg for setting up additional configs required for
>>     enabling FTPM.
>>
>> - cip-core-image-security:
>>   - Add newly added optee ta packages to cip-core-image-security
> 
> Not needed for tee-supplicant anymore, but maybe there are other use
> cases? But that should be discussed with the security WG, also regarding
> maintenance implications for the additional component (even more if it
> should be built from source).
> 
> Jan
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

