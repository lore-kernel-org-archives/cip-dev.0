Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00FBCCF9EB
	for <webhook@archiver.kernel.org>; Tue, 28 Oct 2025 15:16:59 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.33])
 by mx.groups.io with SMTP id smtpd.web11.11613.1761664609690936964
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Oct 2025 08:16:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=o5QNpxnN;
 spf=pass (domain: siemens.com, ip: 40.107.162.33, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sqt2Xm/hxrAns7u5xV8uqKKGU82Wnz+SBx/ZxsOoD1pcL2cWZWae95l1HnJ+Q6fUgggXDKXCyUuDCTIT/ZhsPawc/hd9voAcm94jREquC+4eb6KhKgYVyj2MtXs7LwsIpY9wHRL0QiF24eeB97t33neC0C30rQixnQVftfVz7YtiT27Lz8EviJgVz/9kEXvI+kez4PNteWfogewpVjIjhvrO/Oqp9WDivmWNQAopDVeJ2sb+4U+AkySM2kz04s2pvHhAfIcvxf50PuCYkOh2LUN5etkjqdEQ7Sd2ZQTgsJbtYkDtKpJbfAqVNM6vW5f4Dd7Ei4Cfv/E8E6LrR6jqSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHU0rSgDKaR4D+Gd+iKWYouu1ajUtJy0fkBvYUy5bO8=;
 b=HZndiaOyKeJd0kMtlOJ3Pn34ipRXFHeBCg2/rLXq0DHaxvyPks/OCjXnc7skpaOdhSVBJWv77P2ZeI7my9r3rNnG8pJFkivO/Ge5UfH2cbXjwQthbIbv9Ood/BnUYJnMPZkyXrDuZfp8BjZ01AxxGuRJWK5tGPGzblPYPR5bucb7ls+OP2r3Ue76g4h0XbsAXbrRJV3VSirelpRHk3YjDLBK6Mdlj1qB7sLyEGNoSQpnyErttG2CcZ69g2ZTdaKLmK1ImEEsYBUNGI3h2os8F6aE34Zt7vW5f8Mekoiapql/x8+ZqpSGpVY+kRJRFbvRAHfC7HDfMC5ew/tLgA5V2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHU0rSgDKaR4D+Gd+iKWYouu1ajUtJy0fkBvYUy5bO8=;
 b=o5QNpxnNIhnpCje56m7YdStOfqyDBToxjZwe/aLIdl05JoQ/Gff9DZ+pw90Rv60Ml7V1k0uNMGJTl8mFMJXC78xyGbuzbdUkuioVPvGp4b2sY9Ix7mwKtvYds8v1tPbO4GZnqnGeo+6Gov55MTQAaxiWxQBDEprNfYbmY8bZU31/bKVXQ7WdE3LfNShw5QBLtNA3L+W+kVONa0yKc/2Oz00k3toN4SRsmfJlN8FISRGBZ8Dwxui2fQdu2fwC6jI1c5zzr6ovyfhawQZBp76vnQEk+PeHGvUJTTdVXVM/0YsJyIbrg3WaIB1xvm4CG2izB1K0VWuk1K/xQe2wB2xITg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7118.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 15:16:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 15:16:46 +0000
Message-ID: <ca35f0b0-e37f-4825-90b4-cdc1a4caebb2@siemens.com>
Date: Tue, 28 Oct 2025 16:16:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC v3 3/5] wfx-customizations: Recipe to add wfx
 helper specific scripts into target
To: Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp, akunuri.sahithi@toshiba-tsip.com
References: <20251028122042.2355451-1-Adithya.Balakumar@toshiba-tsip.com>
 <20251028122042.2355451-4-Adithya.Balakumar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251028122042.2355451-4-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P223CA0005.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: 1101e244-2445-4581-d291-08de16350234
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dEYra1pWTjNkTWNwY2QrUGttMm5yTUtJNGtKcFpBWENSVUpaMVlVb1pmT0Rp?=
 =?utf-8?B?R3g5VWhKME4xT01hKzdOWjhYSWZONFcxeFBnajNqR25oemxKdE4wYVJNbFF6?=
 =?utf-8?B?c0NXYzV1OW1jRXVDZ0ZuQW0vT3pDakpMaHlaQk11bHhOWks3V0E0MEJoeTAr?=
 =?utf-8?B?RHc4UWUxNks0Kzc5dWl2VTlDUVg4U0t1cUdQM1AzS1ZXWjcvUG9MeDNqeXNC?=
 =?utf-8?B?NDBsZk00eHRBY0srRG5PcVQ1RlVjWFhvRm1HM2NZelRCVTVTZmtYVG0xYUc4?=
 =?utf-8?B?bWxERTJCVXZ6YWpYa2d3bm5hVS9TWVpEeHRuSTlVTEovSjN0emNheTNsYjFM?=
 =?utf-8?B?OGh4cWxWVGRlUFl6Q0dwZFlvU3hudHFWdDE0andxNTBkQXpkeHhBcXY5bzZT?=
 =?utf-8?B?R2xSN2Y1Mk1ld29EdTRVck1YN0tnanlrdWt6eEwybzdNV1ZCZHluWUcyVmtm?=
 =?utf-8?B?VmlUS0QyT2ZadEMyTkpEMCtuYjRYRC9BMitCb05LSm5tVFdnRS9zd0l4OE43?=
 =?utf-8?B?bnR2eHN3UFJNMUIxQlh4T3BnY2J2NlRUc054UnphZWFUMVo1N2Rac24ra2N2?=
 =?utf-8?B?MlRiVXR6VDd0bFBiU1JLYlYrcjA1ejdHVzV2SEQvVytkWm52Q09kYzhoSCtL?=
 =?utf-8?B?WmhiL0x1NEcxVzVzTjNPd2VSaWkxQmJ0dDJvTnlRSHZVTHFpeW9mdCtMTUtu?=
 =?utf-8?B?OVZtOTlvQU1CQWQ1SmtBR0pkbk5DMU54V3BKNitYcVc3OXRTVWVpZklYMHhM?=
 =?utf-8?B?YWVzYVZUdWNuUG5UQjBUL3NnWW9ja3pPcVhKWWUrQkltcVhLb3BabzQxdWJj?=
 =?utf-8?B?eE1vZDYvZWhyZ0pWU09DdkRiek5MV2NiVG9wbDI1NVpNN1A4Y3h3SUoxcGgx?=
 =?utf-8?B?T0pKNHI5R0lQbDlDMFUyeHJybWRRdkphWnJIOUFRTVJ4eThoZFpkSmI1bHVO?=
 =?utf-8?B?TWM3NEhLdUYxQWhhNGpvcXpFNzBESTg2cVhmZTBKK2F4cklwd1ljQWNkVFZM?=
 =?utf-8?B?aHdLRCtzSVJRUzN2NHNiWDVaUitWSzliUHN0Q1Vrblo1SzhGRzlaUXd4eVVG?=
 =?utf-8?B?aUZTTVIyRGRRUWtGcEVVQTFRZGp6d1NPaU9IaTg3TysrR2pYUlUvcDJJRXg2?=
 =?utf-8?B?VTJNajMzR1NEZk5EUC8yVjg5U0VtR1V0bFNraWZjNXJPc09IQ0NyTEdFd3BT?=
 =?utf-8?B?Qm5kZHBhUDBMUktJRTZLSDJ3Wjd6a09NSUdQT29XRjhZTTEzZ2lFRlY2T3or?=
 =?utf-8?B?ZDF6Z3BYWGhVQVpnQnJFTlpvSXNRL1R2ZVg4UFNDVGpXMGp3NTdzbDVOYVc0?=
 =?utf-8?B?cUtsN3dmWnBTdjhkRU1tRjhYODUzSkQzZ2QvaHhXVW9KcWNhZ2xTNTdCc0c1?=
 =?utf-8?B?REN3ZlpVQ3VUYy9jMTZ0dis0MGhPQ2gxbmkyTXVyUWg2aUxGa3hSYXpVaXkz?=
 =?utf-8?B?ZmExTnlGeHVXa3VhRWpES1dBNmxtd0VsTjI1bi85dXA4eVJPZ1ZlZzRQMytV?=
 =?utf-8?B?OVNDNDNJTVN1MFhJVXV6RSsxbXlNaDh1UW1Iamo2azljNXQ2eW43VjluOTBV?=
 =?utf-8?B?eWl4NUNGVEIwaDlsNjNNdkg1MzU3UlZjbkZwOUFNWkxScFRVUkI4aUx1TExx?=
 =?utf-8?B?YXd1eStyelBud1NCblA1czdDUmFqRGsyS2lNSTVwUTdrOVV5d0hwbU16M3Bi?=
 =?utf-8?B?aE1wWE1XTDhnOSs1OUxiL3JBWFRaRGFVMmw1MlkrdjhiTU1QSlptM0ZPUWFR?=
 =?utf-8?B?cG9lU1N3eHJYNnRCRDZqbzFzN1ZpNkxLS0srMGNma0M2K0hMTlRVUDBqazlj?=
 =?utf-8?B?ZlBMeGU2U0FXb2h6Sm01cjlOTE85NFE4b212c3lnK1ZrM1F1akhYdXZESmNo?=
 =?utf-8?B?TCtEMTB3YkdBTUN2UTdWMElWZDZTNTRiRUJaVCtkOUJhUWJsY0dNeGZJQnJI?=
 =?utf-8?Q?UKds1QQF1sQbKjwHHKyFP9ZcvlTr51SO?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WlowaEgxL2tUNHZua0pOSlZldWFUZjFCbE5hdkluQlVPc1QxdVhuVS9MVFNF?=
 =?utf-8?B?V2luZ1Nqc0RmS21HbWdBc2NmRjdDTTJJaXNFMlFXMmQyajVUQVZZMzBzV0dZ?=
 =?utf-8?B?VlVOUTN0K002aWlHdHJvRy9manVkcGpYemNpcWlRWkFOejFpWnJiN29QSlNp?=
 =?utf-8?B?UTJubW0rK2M4QmluSUtlZ2Jpc1diQmZheFhQcFRra3dBdFY4eHE4OVpOMG9E?=
 =?utf-8?B?THVobFZLVHp4azNiZ2g1dXdyc2YxR3lIbHVpNHVLSUZ2SGFtTG5SN3hic3dY?=
 =?utf-8?B?NmF5QTBPWXVDeFRjYzNBZmNEUHR2YmNsQU5NNWEwbjdNRXo2Tisxa01IKzBK?=
 =?utf-8?B?Z2pqdi9EdjRRZEVja0FNcGlWRmVqNXVVR0RNUExEbFpXZ1BYYXBqRVRiRGhY?=
 =?utf-8?B?NmRNaERWcklYUUJCQXVhWUVaaFBCVjFtK1kyVjVCMGNEVGsyeld5UTRtMnJH?=
 =?utf-8?B?K011K241NGt3N1hDcEFoY1Q4MFZtdDNHK2hQQTB1cGNGcW0zbndGNFV0NXJv?=
 =?utf-8?B?RGJyb0NGWXZzQXppa2hsSi9nWTRVVElxdklTRXJwRElmSFRCNDBkZ011eEtr?=
 =?utf-8?B?ZjRmL1dLTkpSZ1U1dzNHaG8yV1lTelFjMDBLQUhrR3ZEVFRnS3MrZnNPYWFV?=
 =?utf-8?B?NExKZkpvSnNCaU1UUVJmSlB5c3dTc0tFcTZ4alJmNFIzNGF4QnE0SmNxbGhO?=
 =?utf-8?B?RHVxWkxtYXFxdTZKQkVURENQZStlTnpySzJqYWtuQnFBQ0FYN0hXQ0NtcGt3?=
 =?utf-8?B?T0dzdGpacXNVK21MUlBlaVBmcWV2eDRaRDduR2RKbWR4WDNMM2padWxnOEg0?=
 =?utf-8?B?VEkvT0ZxcU5LVWdZZ2ZZZHVTUUx6VHNtMEFqK3kxajNwOVdMQ0tkZXZVekV0?=
 =?utf-8?B?N3l2QXFKR0Y1MHdqTjRueWttNFVoUHFtbmJyUkg3V2srRG1CZ1lxQWlVUndE?=
 =?utf-8?B?dkFSemN6TCtzMDJ2OWR0NVAwS0MwOGJxdldCQVVRU2QwR1ZsdHNPWmtvcVly?=
 =?utf-8?B?NzZkbHRkakhsVHo5ZDVRM1JYZFdyemtFeG81MmZLM3ArekZTNnZPNi9mUjNG?=
 =?utf-8?B?ME0xQWNiZWZnR3JvdzhSTmpJUlBBZXl2eFM5NzhsYUhheXFBOWVZOTNubnl6?=
 =?utf-8?B?bFJOb1FsRmN1VG9pYW1WYjN2MFJuLzNvR0ZYdklSSWZ1Nk93UldKSGp2NTdO?=
 =?utf-8?B?QmNYV2RCTGN6UXB1SDdubkZTMFRvWnY1dVhvM0oyN3lZSzJsTGMrdGpGL29F?=
 =?utf-8?B?djhKcU5nbFYzMWY4YldQTkJ6NVFTQnl2ejU5Nk43VWwyb3VUVUZzUU5OSklk?=
 =?utf-8?B?dWRxUDkxWHRKUUI0S2NTQWlJTStFSkZOdk5GRm9UYndadHNCbVA3dlNweFVi?=
 =?utf-8?B?Ylk0N0xVdlY1T0FDSHJvTHJxOUhvbmRtcnlpNDdTZVZQNkt2ekFqbnR0WUR4?=
 =?utf-8?B?bTJTQ1RtZXhtcTQzdnM5eUJUa2NXckRlZDU4RkwwQkFQV2JwQUMrVVpIOGNs?=
 =?utf-8?B?RlFOcCs2T3ZHb1RZY1pmNkVpa1BVTzBISjFIZTFhSTg4WTZoRDN0V2drUURh?=
 =?utf-8?B?TjRycW5nL1R6dnVsMDRYTG1RZEpYUnBFdzZldUh0K21ERjlMMkcyeE9qdGlk?=
 =?utf-8?B?RkdCdjlZeXdHUXV6N1BIeTRaU1d4VWpwbU94dU5sS1hPZ0V0M1lJTmZUcEdn?=
 =?utf-8?B?dWllbGNQYVpiTUZTdGkyNElsUFoyVGZ1UjRScDdLaTYyV3c5ZUp0RlJOR1Zv?=
 =?utf-8?B?cEZZYmJyQVJNanBNdGxLSmFCVVMvL1A0bHZIc2l3N0kxVUdkck45QnMwQUR4?=
 =?utf-8?B?dmRzVm84VXpXNzJCa0FoNHd2Sm11eGp6QVNMN1NBZWF4TG0zVHhvY0lYaEpk?=
 =?utf-8?B?bWszQ0lJOXBTUWgzMm92Y2o3OHFXdUVZVzBVSmJHSjJrZndMQlE5blNMMTh5?=
 =?utf-8?B?U1NFbk1Va1dWaFB4ZmJNVnFNU3VkbFl2ODBSdzFpTFR6ZnN5V2toVzh2cmwv?=
 =?utf-8?B?dHpDVHVjMXJwbHBRampRbzR2WGhRYjVGTUM1ZHhyVmZITER6OWRFYlV0Z281?=
 =?utf-8?B?ZUhPcDB4d2xpZldOZE1sM0lIaXkrOWZWcGNCMlovdmZvVzErRTVHMzRBOTcy?=
 =?utf-8?B?N0pVM1VSU2dWaFNqYXN6aVZOWlNmRE81bFJjUVBBMis3VUU4OThKV0F5SVNn?=
 =?utf-8?B?S1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1101e244-2445-4581-d291-08de16350234
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 15:16:46.0876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IiF977yJwOqwMu21Q8hif1b9YRG883j/DUodHw80XQlC8xNa2/s0PY78TwaF+wuWKk9l28brei9IdBISMn2QRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7118
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Oct 2025 15:16:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20263

On 28.10.25 13:20, Adithya.Balakumar@toshiba-tsip.com wrote:
> From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> 
> wfx requires a unique clientId for each client device for targeted jobs for
> each client. This includes a script that runs as ExecStartPre for SWUpdate
> that generates a clientId and sets the same in swupdate.cfg
> 
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>  .../wfx-customizations/files/override.conf    |  6 ++++
>  .../files/wfx-generate-client-id.sh           |  9 ++++++
>  .../wfx-customizations_0.1.bb                 | 28 +++++++++++++++++++
>  3 files changed, 43 insertions(+)
>  create mode 100644 recipes-core/wfx-customizations/files/override.conf
>  create mode 100644 recipes-core/wfx-customizations/files/wfx-generate-client-id.sh
>  create mode 100644 recipes-core/wfx-customizations/wfx-customizations_0.1.bb
> 
> diff --git a/recipes-core/wfx-customizations/files/override.conf b/recipes-core/wfx-customizations/files/override.conf
> new file mode 100644
> index 0000000..17ac396
> --- /dev/null
> +++ b/recipes-core/wfx-customizations/files/override.conf
> @@ -0,0 +1,6 @@
> +[Unit]
> +ConditionPathIsReadWrite=/etc
> +
> +[Service]
> +ExecStartPre=
> +ExecStartPre=/usr/lib/swupdate/wfx-generate-client-id.sh
> diff --git a/recipes-core/wfx-customizations/files/wfx-generate-client-id.sh b/recipes-core/wfx-customizations/files/wfx-generate-client-id.sh
> new file mode 100644
> index 0000000..950e444
> --- /dev/null
> +++ b/recipes-core/wfx-customizations/files/wfx-generate-client-id.sh
> @@ -0,0 +1,9 @@
> +#!/bin/sh -e
> +
> +# Use machine-id as the device identifier for suricatta wfx
> +device_id=$(cat /etc/machine-id)
> +
> +# Replace the clientId in /etc/swupdate.cfg
> +cp /etc/swupdate.cfg /tmp/swupdate.cfg.backup

What's this backup for? You are overwriting it with the next line below.

> +sed "s/__DEVICE_ID__/$device_id/" /etc/swupdate.cfg > /tmp/swupdate.cfg.backup
> +mv /tmp/swupdate.cfg.backup /etc/swupdate.cfg

sed -i ...?

May even become a one-line and could as such even be inlined into
override.conf.

> diff --git a/recipes-core/wfx-customizations/wfx-customizations_0.1.bb b/recipes-core/wfx-customizations/wfx-customizations_0.1.bb
> new file mode 100644
> index 0000000..d44dc63
> --- /dev/null
> +++ b/recipes-core/wfx-customizations/wfx-customizations_0.1.bb
> @@ -0,0 +1,28 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Toshiba Corporation 2025
> +#
> +# Authors:
> +#  Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +inherit dpkg-raw
> +
> +PROVIDES := "${PN}"
> +DEBIAN_PROVIDES := "${PN}"
> +
> +SRC_URI = "file://override.conf \
> +           file://wfx-generate-client-id.sh"
> +
> +do_install[cleandirs] = "${D}/etc/"
> +do_install() {
> +
> +    install -d ${D}/etc/systemd/system/swupdate.service.d
> +    install -m 0644 ${WORKDIR}/override.conf ${D}/etc/systemd/system/swupdate.service.d
> +    install -d ${D}/usr/lib/swupdate
> +    install -m 0755 ${WORKDIR}/wfx-generate-client-id.sh ${D}/usr/lib/swupdate
> +
> +}

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

