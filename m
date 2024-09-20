Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED91CC78823
	for <webhook@archiver.kernel.org>; Fri, 20 Sep 2024 10:38:08 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.54])
 by mx.groups.io with SMTP id smtpd.web11.14954.1726828680451244872
 for <cip-dev@lists.cip-project.org>;
 Fri, 20 Sep 2024 03:38:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=nwkvKI2+;
 spf=pass (domain: siemens.com, ip: 40.107.21.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yzp8hIoXEVd4Qf6LLn1Rbk0DJKbOX3T1gSdrICBneF2aMp4UWpSP+PgQdLiBIWbxXt+mP+IszqlZP98rPVgF9afrfL2X05TtuG9jA9ZjJsgYJNhOSf9eq1wg6j4+tr+L3IR9U8WTIpk7ZBXCTWeSGasRY9UtghZMgajYD40/zCYZKZ2I2UO2yG7qJPeimUwsfqbzHUC89VpGk0lGeVJ03TDDmfAe87IJKAEZqaeFTYVsbQVHjKyjaKMHyOV8dGbL2eq8BfoquhNVQNQUPqwZ0KN/zxCAHkUXTmO3LofMLrDqILIrWxg7GpOQzK+qpL0ASteXQb6hF9fD4RzgRaPpLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAuHSSo93zFUul8MDbGxx35YM1FPPIVDva2CNdO5atw=;
 b=SJH2mOwcsXTsHmGd0NY8XNHDA7gA6Ylqs4cm1xW1vL909jW36xR2PGi9Fx1160L70uMqssI9HV4OntRAiUwauoheQpumLFUXQ+1RsNnJRjli5DDah/uZAGS9PB/6l+h0uR8v9SO9R2MKL5h3Car2xkxPx2T5FNaJmLLGRL+j7G+sguncpNesg6IEFErUlmwGYQEzH+QX9sonQMze9CpI3UjDEL6DDpfbvHCVgmo7jzQC27QWHV2CrVOH+i+YPAK7tEMWTO2Lnf+kJnTlaX5zwREly4Lc/kYtD34lUP8DFsYhoL+Bj/P/fzS5okSTuvcAx7KHP6EiLt9r/QbWFTANVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAuHSSo93zFUul8MDbGxx35YM1FPPIVDva2CNdO5atw=;
 b=nwkvKI2+rtx6J5zOWSFN2Gl7gGN60lQbcCTLdR41gzlBejyKozlz1dZu2sg+5kJ4FnoBvww2gmoH4K+wlC85I4NyhDA0ClD5nlSrRx7cs1EvMJdN8NrUpbC+7BTeKHMVoHMPULzHrCXHhpDcLYZu7lcs7UklyB42OuZLr5RP817MV+oiSidQWNtyFcBeFSw5U/92ymQ1lZtoEM1lGs2IOOoTbsFSG3434FSwpP299EQaYspx3jvLXBQOiF6GiAagvwJu1o6qIQs2q5Zi9DZLO41PId7X5m7snW5b9G1uljZJWSVHK3w2zdSwkYrsRiuosPzxF+q5Tu9rvE4g65gdJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7763.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:64a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.23; Fri, 20 Sep
 2024 10:37:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 10:37:56 +0000
Message-ID: <5d09126b-4213-4a31-8031-d7524a929a00@siemens.com>
Date: Fri, 20 Sep 2024 12:37:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v4 0/2] Add dosfstools recipe
To: "Moessbauer, Felix (T CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "venkata.pyla@toshiba-tsip.com" <venkata.pyla@toshiba-tsip.com>
Cc: "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
 "kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>
References: <1788B037A0B186C6.25332@lists.cip-project.org>
 <20230928064437.12654-1-venkata.pyla@toshiba-tsip.com>
 <04c34b86139cc06e828da6242306dd54ddaadf61.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <04c34b86139cc06e828da6242306dd54ddaadf61.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0027.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::40) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: 08d1de4f-f7bc-4368-105a-08dcd96049dd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WTFVdmJlaGlNUlFsakxjYlFKdmNqSXd4K2ExeFZEWHZ1WFlnZE5iQjZLRmky?=
 =?utf-8?B?RTFpaUNWWjQ0Sm5ZZTFQVkdCQzNNczl4SzVaWG1ZT0RMOW5CWSs1eEh0RzJm?=
 =?utf-8?B?bWhhcU8xaHZqSHMwb2N0RDFXanJRdkIyRGc1QW5YVUZlYkFyM2E2bXdaUXlp?=
 =?utf-8?B?cHFZZ0N5a3haWTdYdEtBL084YTVOTDNkTWJ4VjYrOFltZWJWY1hub0dPdXVo?=
 =?utf-8?B?YXhmWFFPTm9kb2IvaEVyKzc2UzdUdXY5TEJZL3h1eU91Y3dwTTQ3bGVwem5H?=
 =?utf-8?B?WmI4cnZsK2kzZHVvZWlIVnVaM2RaY2cxZ1o2NWxkU0oyZHQyZmh5Y0RtNWNY?=
 =?utf-8?B?R2paRjRHdGkwa2h5MUlSR3lKdmNjWGRKVVFLdXMwTFd0Y1BjOEJDcFJvdUdY?=
 =?utf-8?B?eWZsaU81RWdwblVFbWZtd2RKRVNMZEpKSHNKQnJDL2V1aWt6SWdZVGtJWkRP?=
 =?utf-8?B?TmhiYi9hM2gycThNMU8zUktxbjkwdzMzbkRTZkhYbUVoaDQrNnV2a1pyOVNR?=
 =?utf-8?B?V2dCM25DV2FJUDZQd2EvWFdPNk1vK2tXMm9iVlZhaW4wWUZuK0VaM05pQXZZ?=
 =?utf-8?B?QkRXUWNjd09Tb25EbDlkNSttak51dCtuaGdaUExTYUZVK0kyaW0vWnFJc3RE?=
 =?utf-8?B?S2Q3cUp1NmlLOFdVZll2QVhJdzlCQTdxRlR0dUQzUlJ3b2RaRU9kWjNBNUNp?=
 =?utf-8?B?a2tlaW9vKzh3UlhzUCs2enc4MHFrQ2h6YTA5S2YydWpYQXNlTWthc3pSaGNy?=
 =?utf-8?B?ZE9LRUxrWHRuQUh4Z3dLQWNqSzFFY0lVRHRTMkdWamJiem1DRUdhbHA2cGcv?=
 =?utf-8?B?SE1GOEw0R21yeElTc0U3UTMzZEtiMzhVcUpBYitxbUs5YlZqTXp3Q21jdHhV?=
 =?utf-8?B?Tk5CL3NvOGU3ZzhqdEJDZnlIYng2bjFSZi9jM29OeWluTnBmc1RJTzVBNGxo?=
 =?utf-8?B?UVdQZ1M1aU9vNlg4WGp1eGdYV2tWSktjMllaQ1dEdjhiMno3N0htU3E4SkpZ?=
 =?utf-8?B?N2plNEFCcWtlbWpOL3owSGNYU0pCUUhKdFV5ZmdzSnhObzlveVFtWVRtQkdT?=
 =?utf-8?B?aXVKQ2ZaNlhsb0VtTUo1dlZNZ1hySnVrb0Roc3J1V0VJQVczMC9OMHozMndM?=
 =?utf-8?B?eGxlNkZpVDJxeTBkRC83WkQvSzQvMG5xS1RVZjhSTmV0aXR2a1F0aTVEQjlv?=
 =?utf-8?B?eXIxaTFZUnJ2WkxXN1Zpd1N2K3JoOTVYSUM0VWVIMk16NWg1RmszVVY0VDBY?=
 =?utf-8?B?K1cyNEJ1MjJrQzRDSko3ay9zTlhmTzA1TFJwNWhhekVBS09ET2NuNzN3dVkx?=
 =?utf-8?B?Q2hmSDF4M2F6dUtNYkI1cW5yRW1pOFJ0eVlka29nVjl4NTlRQ0NsaUdxbGdm?=
 =?utf-8?B?OUMxeUg3dXVzODFQWWx4NUpKM2ZpV0NXcFc5bHVNMGN5VXQ5V3liTE5RaWhr?=
 =?utf-8?B?eFZ2N1VQL0I4K3dpUDVLRUlkTWgwNWNzVE9FQkN3b1QwVytIaWNTMXRJbkZZ?=
 =?utf-8?B?Znk3cGx2b3NITlpRNE0reXFTQ25WdndzQzlDRnNkcTBKQVoyUm1oOFZPSXZL?=
 =?utf-8?B?RUdnTEx2emZKR1pybElablRiRk1jdFUwNlEzNDdxTXcwTnBXU3pNaDdmck5G?=
 =?utf-8?B?bU1yek1ZcWpoWUVMbXBqNVZQMENjK3Y2R24vVmRUMVlCZmhkelc5LzJLcDFK?=
 =?utf-8?B?ZXBscGdFRkNNcXZKZGNoaTBuS3E1c3B5VUtHR2Q1MEFKYUduMkJhcDlmTXk0?=
 =?utf-8?B?UGwybEl6aEFkcytoVy9IVGFJenJnT3ZiTklYT1RVNUxZT0swazdpOU45K0VP?=
 =?utf-8?Q?ZINB2XSRDKvDODNJBe/+aoslxgAbJVURNhp5I=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VWNscmp5RUR4YjBteVlZalFYYU83cHFoTngwdVk2YWJFam4zZE1WMkMvQW43?=
 =?utf-8?B?RFJyTTZHQ0crT3BxUWpyYVh4WDc2UVdxU0ZFME9OUUpjQzBrMnRhZkVRMlQz?=
 =?utf-8?B?UGNONFNNL0diTFlkTUZVazE2cVBFekFzU21YTHgzVnh5ZWJ1L01DSFp6MGFs?=
 =?utf-8?B?aUFiekFJVnJoVmNNemd5Y2hVSENqbjB6dTlEdmJha1R4KzdJb1lYNlZQUER2?=
 =?utf-8?B?K080YlpiTFhtdEhkV3ZNeTlOaHFFQkpnMjc1eUxmZ2RuekVSb3FOWXp0R05L?=
 =?utf-8?B?TWx6clF2SGVWbkh3am5YeGVjSFVOWHJjN2syNU0yak1WV2pYZGhjOHRtRFpP?=
 =?utf-8?B?OHNVOUZ3U1MwVHN0b1QyWlBaREFaMXhwYzFqaWRsNmpFUmFHdW9lbzNUNlFV?=
 =?utf-8?B?UUkxQjFFR2IzR3I4YUhCMmZ0dUFlcjEvT2hMdFpHNXlhU2FOVFZiSlBrand6?=
 =?utf-8?B?QktYM2d0MWJUV1JWNU9VdXJJZm1qSmZmQmpUbnZkVDZOS21XUThKY3o1SG1D?=
 =?utf-8?B?UlR4anRFZ3RLQ0h4RlZCbUxYbitlZXo1U0Q5Nk53MDY2aldubXVUM2dQRm5X?=
 =?utf-8?B?K0tiTlNMbUZSWHNabTRSWm1MeEJqQU1tbUZ1UjFMUi9adXJBK21XWnBxTGFL?=
 =?utf-8?B?bUt6Qk00UTZiaHFPTlZ2c0RJWnZOVEU2UWVya1o3WGgxZDRYYitQRDdjTkc2?=
 =?utf-8?B?MGNoM1poZTBFWWlQSmNtRnBrUmo4SFpoSHNHQUVtZk9YM1ZSc1ZFeTFQcTBB?=
 =?utf-8?B?UVNmNFk4QW5qNmc4Vnl0RDlRdkdydGlSaHBTUm04M0FFdjcxMC9sU2MwWFJH?=
 =?utf-8?B?Wld3U3RSTUVEODRsdWZsNUhtcEVtNDNDZGdxMlcxdnRkeXZqZ0pZVDZLY2xz?=
 =?utf-8?B?WTk5MTc0QkZuM3l5alRBOFNPVHZxdW44dE1qcVdqdHBMQWpZZzcwQXFPZC9H?=
 =?utf-8?B?RjU1MHN5QWk5dmNmY0VhZTdIZ0hzVHlLWVdod1lnMGFQNFhxMWpzeks0Z29E?=
 =?utf-8?B?NG1ZSitLdWJYdGZxRkR5Q0VHSXlFc21CSnhIRElSV2RpRjVWU0tXQXl4SUNW?=
 =?utf-8?B?STVxNjRoN2svNzY0a01mRGJpRmVkMUllZ1R0em5TWVJQQnRBNXpjYjRQMlE5?=
 =?utf-8?B?YmNreWFLL2JXSXFDUGJXM2lPY29DSnVRRzlyWmlIWThZL2FtU3Fod2E2QWxB?=
 =?utf-8?B?UWFNN0V3b3Fwa2dsQzZmdUVmSlpkcVZNWVlXY2wzM1hCb0dQbGFDWTk0RUZr?=
 =?utf-8?B?NjRXNEVUYW5Na3VrYzVxNTlTVm5PUk9ud3hBY3NZRkRTRzQxMVBseDkwdGxS?=
 =?utf-8?B?d091Kysya3FZVHFYQmxlU0JjUG5hRzBSMG5CRTZPRDJsRmJDVjlVMU1zQlpR?=
 =?utf-8?B?cSs2UXZwZ1FrK1gzNVNaYnlqZ0F0VDBZU2lMOVBIQjVxTWhVZUJmaGxLRnU1?=
 =?utf-8?B?Z0htZE5yZ3JKVGxOKzdxRUVQOW13dXBzZmR4Z3lxbGlyMitqMlBjbkRWaEEy?=
 =?utf-8?B?V2xla3g5YXRrWThjeEF2Y1RYOUUyclhwVW5vdkJwQXEyRW54QUw1bFNYZTVB?=
 =?utf-8?B?dEk4czVtanRyT1VrR2xlazdMNzRJdWR1N0ZycDkrRTV4REFTSzlnTTlhdEJX?=
 =?utf-8?B?OUpBbHg3eG1qaVFsVjY3SGZlV0NUTFp3cW15RTV1aHFhb240aWpPQlB3N3R5?=
 =?utf-8?B?b0tVUlQ4RmpkR1ljZkRUMVNwWUJFVS9USlVDNDVpQTRRcFZUU3hTWDFHSEFQ?=
 =?utf-8?B?MHBTbGcyd2pxNTBXbHM3SVBDZFZrWU1FZC9xRG9HdEIrbFdUbk51aTNmRFRk?=
 =?utf-8?B?dGhSWjJJSkR3c0srUzladEJIcDBvY2o0bzVkMTMvbXNkK1pGVk1vaXFwbk9k?=
 =?utf-8?B?SFhGS0tIZ3lHNkROWFFhM3BJeEpkZzBRblFaWnlKR0xtNjFtTFQxUC9rc05C?=
 =?utf-8?B?Z2tnVkE2eUx6M3RRdWZCd3dHNjFvOWhXM3ZOLy9KYUtOeVpIaTZVdlZoYjhQ?=
 =?utf-8?B?UlFlSWRyWlFrRHgzZ2ZoVHRnUWZ0T3RwVzFrN2NxRjU3VVZERjRnMEppQzFW?=
 =?utf-8?B?WmZobHpCUUx2NEpCdmpHZ2E1WUUyRVZ5ZTIyVDIxWDFGbnZnM0hxNFlFcm4w?=
 =?utf-8?Q?kYqJ4Z/QHH3E2r/j8XEDtu9Jz?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d1de4f-f7bc-4368-105a-08dcd96049dd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 10:37:56.0435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PaZgF/5HDLjkQh4jfpfX+5vuDbQ6Ze+0C3Rm9OLun5UnsnRo/m5Mg/MkTi8jEd0SBv0lz7cpuag7gr17g7eLcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7763
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Sep 2024 10:38:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16910

On 19.09.24 11:45, Moessbauer, Felix (T CED OES-DE) wrote:
> On Thu, 2023-09-28 at 12:14 +0530, venkata.pyla@toshiba-tsip.com wrote:
>> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
>>
>> Hi,
>>
>> This patch series add recipe that build custom dosfstools and use it
>> for
>> creating reproducible DOS images.
> 
> Hi,
> 
> I revisited this while debugging reproducible builds issues in ISAR:
> Have there been any attempts to upstream this? The dosfstools repo
> seems to be abandoned, but maybe Debian would be willing to accept this
> patch.
> 

Problem is tracked here: https://github.com/dosfstools/dosfstools/issues/210

> Apart from that, we might want to move this recipe over to ISAR, as all
> EFI targets are not reproducible due to this.

If things continue to evolve - or, rather, do not - like they did so
far, this is actually a way for us to side-step them for a moment.
Still, that brings more responsibility for us regarding maintenance.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


