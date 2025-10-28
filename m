Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB2DCCF9E0
	for <webhook@archiver.kernel.org>; Tue, 28 Oct 2025 11:44:08 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.41])
 by mx.groups.io with SMTP id smtpd.web11.6349.1761651840672048257
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Oct 2025 04:44:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Zwpsv768;
 spf=pass (domain: siemens.com, ip: 52.101.83.41, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwfI3/f7iSL7eNpDuBZd4YndHSRkcxewya42vXIuDI7k57iqhvL0Jp++EuuMuxoC2fNRtLsz8JbJ6QtUn+Yp5+PhPmfOdx7/Ja93mEUcaKtWxRnximYRWG+O121N29Kp1b5x8PO8UbsRCVmFFpAN3M2wMKQIH+iWt5PIQwzhE/zXbFMHlsTgBeJ05EG7YwpthaVxvLIIjreCIUQGwozh87mESiTtQUtvoaBurbm51m5fbgJ4q0/KhmRpwph6CWBhxI3KAiQCdoVN7d9+Cael4DgN7j1bJ/0u+S6XJ8QqgCI+TSMxl/yZbcnThlld9+RgOA9+Cov8V65gEoOY4oXqRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGHA8uFwQEaftwHVxSRzgehRNa3h5IsTkVNnNvMVTP4=;
 b=otVo2srwZd3d3ZJzDkeP/xUnL7m0d4NTojXNb0bYIQzt22Iyd1hB2RZIxOUnEpbkG1h3kPqw+dFJo6hWDbP0FN4ElY8ZETu9LkXgDhgLqGQGhfYpo55qjOXFw2LSa0BYZNMswn2CGLV8g+or8Fq7yl6fhYp7/qwlzmvtC+uC94V2ksBMfHqPaXxh9rtOURH8ZAyDN7CGYjQgHJVca9TcHdrrCzROqh+o82zsMvLJnngFKXgGBYRlLucfg6D3BEBsBQgVvJz42wwLhqmS+aAwaoHAvVb6VUD9mL3CoTlsvo4jyHyiNSjSPVYGyhpoLKWUEnW114spLMssq3/OfqeryQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGHA8uFwQEaftwHVxSRzgehRNa3h5IsTkVNnNvMVTP4=;
 b=Zwpsv768E2Xc1o4rCUi1dnRbkIIRMuNV7EyvK/TT+tcMlCZrXxPeT0v3Vx8Js7cxofeYOKL/+laACYZo718sVyDvTN8lHBvQFAdOUxG0mMasGWZsCa3vE1qefUjjx4dfOgiMV8jMl9G0fLOHVHC2n3//CFIxstwAR9gVN3VdAnvNRg6Hvg011ExS6oFQrHbjR8e0VKOef4QP0326LI47CSJmkIeDmLydekU355msOF/hUSvAAY07uxAOkRfdl6y2HnErwcV8TAwClB+y0so2JP14J74pEzjWAtGQt+X03nOzD0UJgHc0sZCZ0NyEeQB5cdRQTpxq0wp1R7G2NgnnfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:525::6)
 by DB8PR10MB3292.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Tue, 28 Oct
 2025 11:43:54 +0000
Received: from AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4bc5:6908:1189:7a]) by AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4bc5:6908:1189:7a%7]) with mapi id 15.20.9253.011; Tue, 28 Oct 2025
 11:43:54 +0000
Message-ID: <ea2de6f2-5574-44e9-8c96-29d1ec0d3084@siemens.com>
Date: Tue, 28 Oct 2025 12:43:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][RFC v1 1/5] SWUpdate: Use self-built
 SWUpdate 2025.05 for trixie
To: cip-dev@lists.cip-project.org
References: <20251021125233.1528087-1-Adithya.Balakumar@toshiba-tsip.com>
 <20251021125233.1528087-2-Adithya.Balakumar@toshiba-tsip.com>
 <0f2a33fc-dcca-423e-a3f6-efc12a3a6d50@siemens.com>
 <TYCPR01MB966928ACDB11A20191951248C4FCA@TYCPR01MB9669.jpnprd01.prod.outlook.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <TYCPR01MB966928ACDB11A20191951248C4FCA@TYCPR01MB9669.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::7) To AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:525::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR10MB6023:EE_|DB8PR10MB3292:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d0bb0c5-665b-4649-4874-08de161745dc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|4022899009|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eE55ZFF1NndxYUxJeFRXREJJaURqMnV6YTRDU0taVnYvQTJndjRmMEliMEZh?=
 =?utf-8?B?QVJCbk1ZMElrTnVpbnBSY2dHK1I1NlZDN05wNE5pTU5rZmMvOXVrdDQ5RlRz?=
 =?utf-8?B?N3ZCNzl6c1hycmpzL21nUkNXc0tjRTd1dTQyMFljSHYwN3h3RE1RMDZKdHFM?=
 =?utf-8?B?SUVFUlRmQ0ZIWkFmbUJhdGt6N1FhcVFDQnhqeG8zQ25kVHdNeDBMQ0RWUWxH?=
 =?utf-8?B?SEt4SXpJMm9OcmhNV0ZVNTQxV0dhWmJiR0NoWFdsblNxQ1dodk9DOWpUdUpr?=
 =?utf-8?B?TUpjRGFFSTF5WTRGZkI0THdDbXNsRlpxdmE5REFjN29nbnhGOGNiWC9CcGJs?=
 =?utf-8?B?cHcvYjlxaWZScUhvSTJqbk9uWEQyek51ek92bzY4ZjdZa1ZacDlBUWZ4cStp?=
 =?utf-8?B?cDRneFdjNEI1WEpHVk1SWVRzc1crQ3VtejZnbkg0M0M5bHBJeW0zTVdtMUxR?=
 =?utf-8?B?Slh1ODNoT0JlNFdGTmRWT2NWSDVCQ2Nlakw1cTZxMWZraEo4cm1aMVpRWTBt?=
 =?utf-8?B?Qm5NcTlCd1NrUVJNczRSR3RyN2dTTVJXM2o0L2hDQTNveEtHMmNGS2Q4NzB1?=
 =?utf-8?B?dXBpSEF4Q01jL0RjbHV2djBJQlNMM1Zzc3QwU081d09nSjNhK0J4NFNCWUtQ?=
 =?utf-8?B?Z1JvODErTFQrL2dpNUthU0VVeEk0aFNPTnBWNHJUZ2dBSjgwZGpuTlBXMFRW?=
 =?utf-8?B?bGZVc0gzTXk3cXhWRGxFU0M1ZGtTeGhkRGdQZXo0RTNMODhMb2dnVjJDKzRW?=
 =?utf-8?B?TmgvMDVPYTB2TjlhakE3aFc4dGJXSFFINHhyTEVkQTBtamZaSlBuaXkzaGZO?=
 =?utf-8?B?NVFOSU1rbm5OL1JtSFIwbEhaVFdxN0xyTGJDblJyLzVvWEtwRy9iRS9WR0Z0?=
 =?utf-8?B?K2l6OVA5NkNNMEswQ1dpbEVNTHJsaFFPdXJEdzVWek9JcUhqb0ltd212NUtS?=
 =?utf-8?B?c20xS0dOYTdLbFFpVnNwUk1lWG8zdjJSVnpsYnRQeVIyVHlUMU8vcmVyTGdG?=
 =?utf-8?B?UlVFaktmbGRYZ3NoeFkvbTZSbnNISERiSVYzV1o4QzljK216dkxQUG51RUtJ?=
 =?utf-8?B?YzBmTTQrQTNjbDdLK3ZlTHQrNU1JQVp1ZzJWcXBLcDJQK0plaFRzcGVQR3l3?=
 =?utf-8?B?b2UwSExQRVVSTWZjUzliNVVaZE96TEl4WFU5R2MzVC80Wm45N0xJbHNsL2ZN?=
 =?utf-8?B?U1V5THhjOUc5dHgwV3p0ZXVyZnpmdklrRmlINnBRN2lHdmlYVGlwV0dJRjBu?=
 =?utf-8?B?c3UvTkozZ05mZXFLZkZFdUIyQVJKUWdVSnJFLzJwZkZlNG55WTJmbmNTbU9k?=
 =?utf-8?B?TzdkMDZra0RkMEN1U3dvVjVOSHhEYTNiei9QMXMvak5MOXBoYnR4MXZYM1h0?=
 =?utf-8?B?cnFXS0tMWTZNZ3ZxZDNiR2FUOTJJR0wzZkJoa2JZclRjU05ERDgzUnpHbS8v?=
 =?utf-8?B?SVdsZzBkdXZuVFRFYVJKMDN1OWZxOE5ES3NnakxidTVqVnBZRHpOQmVSQ1ZT?=
 =?utf-8?B?T2RETS8wUHl0Rm95Y3d1ajJ0ZVJQa0lhcGlUZW4yd2NpNmQ5dkVmM3lNY3M1?=
 =?utf-8?B?T3hBZ1N3WDJDWmdLb3FVd2plai84QmpNWTlCSEdYMzFoWXBoQ2RXK20xRXMv?=
 =?utf-8?B?WmJVMVg1TEZCRDBZTUx1RVFKTktaaDFSbjZxWlYybU51Y1AyM3Z4bXliRE51?=
 =?utf-8?B?TW95MjJQTlQ1UnNYV1dUQ0NPckxaYXorYjNQUUhmY1Jhb0RvcVk0K1VueVVG?=
 =?utf-8?B?cTlaZWZ2WFBya01UYi9ZeE12MFNVbkdhUEhYMy9tNnJIemFEeEcwbG9nMk91?=
 =?utf-8?B?b1B0OUFlSjcvcFVrNCthNmc5KzI1RzVwOTJiaDUxK1B2UytZVzZHTGRzakNh?=
 =?utf-8?B?VW41cDdPTmRENFdPVnFkWEtkRWFpRWJjcmtDME1IaHd2eXc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VmJpSzZ4d2VJRkMwOVNYckI5RHdvZVNlaEFmOVBUaDN5a042ZHhDL2MwaURQ?=
 =?utf-8?B?S3k5bG44TVVBVnRldWZ2UnZ6L0QxdmNTdWFGbjVXb3M2S3V3bnNqOW8yTTIz?=
 =?utf-8?B?RVVtU3U3MldyRjlLRHVjN0VRbFc2UXFwWjJsKzQ2S2xFQXJjSllLaUlMM0dn?=
 =?utf-8?B?ck8xbHBsbml2V0pJNmM0SWFLVlpIbkF2eCs5UVhJQ3V3TnIwNXFOdDd5YTV1?=
 =?utf-8?B?QklDS2I4QU50VWZpZUVXa2dBL0pKNG5HZVNneFMrWEN5ajlEZVpMS2xJUndj?=
 =?utf-8?B?aUMwc0QvSjBZSGV5VmtVNG5wTzNFcUhGS2liZ0JDYWpQc3dPcFMyL2x6MGxy?=
 =?utf-8?B?bnJaNnBtdDkwZEg2cjVVTlVoTFZaRGNrVVJCUlN0L2JOUUQvODlZUkJFVVBC?=
 =?utf-8?B?eGJpVmt2bmZTWFBkWm4rYnVWUEJHbWxzYzh1SUpGc0ZFRkFUenE1MmhUbCtz?=
 =?utf-8?B?WmdqUWlJblNOUTExSlpOLzhEY0c3OFk1RC9uWUxhWmZOc2diTmxDVFFTNGJE?=
 =?utf-8?B?QlpNRUhiMmN1M1BtVTgvZmpISlBYNE1PNFRkakZqVnF1ZlJKdVplVVozWFQy?=
 =?utf-8?B?eExKb01QTnBvcmFhS1JFVkJJUEt6amtsNEpXSS9tS3J4bms0ZXZrYUJYOHV4?=
 =?utf-8?B?YnpOeHRjZ3NDZHpYOWVqQkZZeXBPTnNxbWhad3NnY3IxYmhUL0JQbENpSTBK?=
 =?utf-8?B?R3FKTENtVXBXUW0yYmVtbnp5N2paekVQcWFsQnNXdmJOS0Q5NXRSNzU4S2FU?=
 =?utf-8?B?dDI5NXE3ZEZZNkhGbmg5Q0d0WTY1dTlLZnZ1SGdyQ2ZqREF2ek90Y04vdkNZ?=
 =?utf-8?B?dmZuYk0xdWUyVXRKSnRoN3o3UkdKYTN0ZTczYjJNcjloQldOanNaSW9nWjY0?=
 =?utf-8?B?MGkzYzNHcldyVW5LdUMzT0JzK2hwOGJ2N1JSdk4vOFNQTTdReUNiUDJ3Sjho?=
 =?utf-8?B?YVIwMlVSdjFiRGVVd2VUWWU4QVEyUE9vZ0lXOUN0dnVlV0FVMUxKVDhXd2d4?=
 =?utf-8?B?UlQzVitISXl1NzYvNHY4QXROemVxWFhydWJCVTE4emVRUW1ZSEg2UHRoNk5o?=
 =?utf-8?B?c1JpdHh0T1NSU2NwcGk1aDhRNjFrQUdxL0M4Kzh5ZTBkcjBJYVFXc2FHYVZ0?=
 =?utf-8?B?b0UrNmFQcHg5aEpPUjhTV0JFUWxFV3lCUE9nWVJkZXlLUzNka3JIemJRSU5z?=
 =?utf-8?B?ankrY3ZXL0cwclZMY1hTNVJiYnFRU1p5cmVmMERHNUdzV2RsZFlvZlJEY0w4?=
 =?utf-8?B?emI4dEZJWUdnWGc3QW10ZWRmbjRJN09vYkFRRXVpcmRDTFRyZGJRS0xrb1Fl?=
 =?utf-8?B?czk0YzFtcG9Xd0NFOFh2OGxPT2F3SURUSGRUeEV2VmJtT0ZISEFNaXQ1UE9L?=
 =?utf-8?B?eGRNYVRVTTRUaXBXenJvN0c0N3pwQ2RjR0pNZXVhbXVrZEN1TnJReE9lY0tx?=
 =?utf-8?B?NEM0YVJocW02ZFRVcEtGLzlTVk5hbm95TTRmYTIxaS9scjZUT3Q4RWZ5OTB5?=
 =?utf-8?B?bjhaMzlSNXRhSFFacDBKemRQSmgvUWk0YWNXZktuRGc4cUJNQkUzMjBkQng3?=
 =?utf-8?B?b3hPRVhMeDZoQlF1UGtuVE80eGloUjUrME9FekcwNkJCZ2VtTlByblA1RFp1?=
 =?utf-8?B?eVhJdlhBdEdzUWlXeW42TWhDZ2VMekFEbXp5d0tIVGJ0aFltU1d1OHI5eURW?=
 =?utf-8?B?T25GSGFJTHZkV2VZQ2krdmpaN202V0pOZ0hvSjJMRXhQczExdC8rNFBFS2NM?=
 =?utf-8?B?bE0xZWEzM1VqZWxlVlB2c0gzdVZiZHpvdjNaRVZWRHNCUzhtSGlsaFQ5QVZX?=
 =?utf-8?B?M1ZJVEphSkhaZytmU0p3NzlkOTFTNndiTDloVmJtQU02VFVUWmZ3SWVpb3NM?=
 =?utf-8?B?T2lVVUFRbzloL1lMYThVcEZMdDVpNXE1S0VXa3FmVkNseWE3NnRJYUlXN0VY?=
 =?utf-8?B?R3BIQWZsVWRuOGQwODVOU0FIU2kvSFBvTHRXbHNDK3pNQlFNNDgxeDlrM3hw?=
 =?utf-8?B?WjlWTkFnMWVxSEFPcFVsQkVNQmcxdmN5dnRLeU13WnkraHRtWkFSd3hQS0kr?=
 =?utf-8?B?a0JidzNTR3pTRFRmNFRlTmlJOWFRYzYxUXVLb3VwK1I3Ti9IWG9hdllwdjhw?=
 =?utf-8?B?dkJ1d3R5RDJVWUx3ZUVzUXVzdEY3YlBnQUdIc05FUVNPZ3RMNnpQRjhrbkdX?=
 =?utf-8?B?a1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0bb0c5-665b-4649-4874-08de161745dc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 11:43:54.7050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NyQr/n56xkk9yQur30YCXtnlwbleJtIYHdvNBWaB32KfuymnOoniMaRpyuskvfD9hgc2cRYhR29kaVcjsDWK20mesDfnn857aaTndZLOWaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3292
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Oct 2025 11:44:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20253



On 10/27/25 06:21, Adithya Balakumar wrote:
> Hi Quirin,
> 
>> I would discuss this fix with Debian upstream instead of fixing it in
>> CIP with a new SWUpdate version. As we need to maintain this version
>> even after debian no longer supports it.
> 
> Thanks for the feedback. As it turns out, the fix is backported to debian SWUpdate 2025.05+dfsg-3 [1] but not to trixie stable (probably because it's not a security issue I guess). This should help with not carrying the patch locally.
> Would it be alright to build SWUpdate 2025.05+dfsg-3 from source? Or do we want to avoid building packages from source entirely?

In my opinion, we should avoid build package from source. These packages 
will increase our maintenance effort of isar-cip-core.

Quirin  >
> [1] https://salsa.debian.org/debian/swupdate/-/commits/debian/2025.05+dfsg-3?ref_type=tags
> 
> Best Regards,
> Adithya Balakumar
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#20220): https://lists.cip-project.org/g/cip-dev/message/20220
> Mute This Topic: https://lists.cip-project.org/mt/115872046/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


