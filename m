Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89274C83013
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 10:09:23 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.33])
 by mx.groups.io with SMTP id smtpd.web10.20025.1751450962875234535
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 03:09:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Ulg2lxR1;
 spf=pass (domain: siemens.com, ip: 40.107.130.33, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ItJxQf3ZWRHCup2ojK5ff7xatHXo7cGpHjocdFFn86RBnHXT6MIkenYQlirb8gqRCiji0ZKP0KDGWEFkv+o71SSkAp5xPzkPBU0LDQO9Cyftvm0EtsBJ0ldTErpY6cgHdO0BWbBoaftl35VVaP4qG7EEt1eSc7bPKlHmUlS9O5BgCD/qGlhTdwUsBp+LhYfaTGLmWlNDSbUUn/K91zsR3vNOarK7Zdsb7iPAkK5Rt85LC/+s0KKFIWw6nk6cDaQ6IJIJbokZJSEIqDwohUDBr6x6xRlCZxp72rt58tsx0pRmPZ/M7Zh1CibELlK0al+HVVc1QIryKPeEW9bDW2dQ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JfthjzdeYvA0uy0+ByJqyBAU4nAOvPQWFkvt0w76ac=;
 b=ciMd6KOBadGeO7VqAMoNU2rXW9s0gweuGiRfHLDa5ZgxQpURvzij3uB2Ipbti29IEp7bCM1UQkRPfdSjq2af+dRg/CT3c1w6bZ3yy1y1kkGUz6POSIIurCGF+Te39iFsNIWyHrjEbyHOgoFaWp7tY8RnaIDQ9zdN0C3b5RG6DXaW69DMJ/YpWEHXbSEj1H7e4D/iL2KFpsdnHQmHOgMl+LsfofBGMlbXSADITrZlwMizm5+WUnhLwHi2gWmzlXvIjRdVwNPbe93O4dVZrIZumfiSGlr2LpzmbyGH86TH6h/ApVDHGqM/LtIiEgFXF4nWoQzAj5nuBzDbx2hFITLKDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JfthjzdeYvA0uy0+ByJqyBAU4nAOvPQWFkvt0w76ac=;
 b=Ulg2lxR1i9cOvMkbJyAgQ0HJvq3DLbzoQoFB0IrMV0MjrneT+M5UcKefH7g8dwVUoPNZRX0l3Ou4IUjpTJb+R/waz2/+lVVvtNg/pv/Z2YsYWv8eumgMWzKWJ+StjsFbMDEevNv8Wfb7hc3bB0owKi3B+Q3+c6/IEmbae1zEX39im5zpzr9VdQC40F/UPgVp51/iibotOrSW0RwgdxOWodRbUqPWq4Fw5niplkKMgSuInqEouT3W1EONC4cWlk/wVz2INPvimhtAqysiXP4HScZmI4FcqYrc4zdlw19OPOJnYz+PbJLKQgjY8tQ+icSh5U8NL776DMN9+i3uWsBVsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB9101.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:44f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Wed, 2 Jul
 2025 10:09:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 10:09:20 +0000
Message-ID: <7294c0cc-3b39-4857-bca8-2258e2da9f91@siemens.com>
Date: Wed, 2 Jul 2025 12:09:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] LAVA: Support ROOTFS dm-verity corruption detection
 case.
To: Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <TY3PR01MB1107541F904CDED694538F4F2C740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <511d0d4a-5604-4be5-ab59-c8abbfab8a26@siemens.com>
 <TY3PR01MB110751BC4788282D51875846CC740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <4e7965a6-f4ac-4d1a-a6c3-ac3a09bffd50@siemens.com>
 <TY3PR01MB110754BBC6C6B9E2D8B90BAD1C740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TY3PR01MB110754BBC6C6B9E2D8B90BAD1C740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB9101:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fb713e6-aaf1-41c5-e205-08ddb95082ae
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZDdIN3Q2cHVrRXlxVUFRRnZqQSs4b3NWdlFCaUZuQWk3V3VDSWVWWDBUU0sx?=
 =?utf-8?B?MDI0eW5Odm5ZU2xOVTZFNnJUV1Exa28wRFppNEYwRHhPbnN4czNaajFoMGZr?=
 =?utf-8?B?L1EyTlljNzd0SEpNV0FIQ0R6allYYmt1OUgvTWtRVE93M2NKYUg1YVVVZjdj?=
 =?utf-8?B?VFBwZVBGcFM5R2Yrd2JvTTIvUS85WUhhZUVPbGtWZGQvS0p0Qis3Mzl1UFla?=
 =?utf-8?B?TVdwb25LaVhMRXJNS2gvL2p2S2NZUEhOU0U1ZnhOdzg2SndZOWRJWlY4Ylhj?=
 =?utf-8?B?RFRaUzhVaDIzUGtCdXlXTTJqUE83aVhqRGRickJOSFNReTlzN3JiT0FNOVBO?=
 =?utf-8?B?dVNtd3lkL3pIQW9tcnM2M3IyYzF2TWticHQzVmtsdEVMQ2VCK3IrajJoVnhR?=
 =?utf-8?B?NFhESXJwcUxQNkZtM2J6dlhOcmpuVC83eUEwWEc0cmdKZ0hlTWpaaXlIZDRv?=
 =?utf-8?B?cUN6by9TTlV5Um8rZ0FvMzV3a3NOc0ZVeHMvSVhWbUZVV3VmTFR2amJrVlNN?=
 =?utf-8?B?MmIwTThjdG1jZDQ3MGtOY3JkbkpwMXJaWHFPTjdLTmRacXQvY0pKZW1mcFdp?=
 =?utf-8?B?STBXNmlRUmJMZmJCRmpjTjZTSExHUGU2M0ZDVHNXdzNzUXJwbHNQWldzOGtw?=
 =?utf-8?B?OVJFUzNlaCt5WFBQVjJPUlhGM25GR285L0REWTcvWkFra0RlaVF1MGNUOGdu?=
 =?utf-8?B?NmVadlBBK3ZXeENOd0c0Z1FnMG1YVVNvQThFb0wyZ20wMFoyZlpwY0lUNVZ2?=
 =?utf-8?B?WDJGUDZyaXVsZ3FsREFXcFVqUnQwSC84SEZqOW0wUWdLUFV2engvRGdjckRs?=
 =?utf-8?B?VWdFamFoVDlqcXVnLy9KdjNCclhzSHZHNGw0eUo5NlV0OHFVVVF6b3VjUWp0?=
 =?utf-8?B?eEJaRWRnUEIwNDBMeUlFZUFSOGdnYzVXOC9WZ2oxcjRBcFZxTFllNUpzUmxO?=
 =?utf-8?B?NVhRS2kzbUk2TzVPUS9wUXMycHZHTkRqL2ZwUVdyVHFsaGFYbC91cUN6UjRx?=
 =?utf-8?B?cVJRSnlBa0FweGg0REZqZnJhTVBGdjFiVVBCZkdGbytXUEZ6c1JLSGdkTG9a?=
 =?utf-8?B?NDVPWDc2R3QvcVUydDA4eVNCc3lzVlRDeVlQUGFPQXFGN0FnNUpad3UxK1BE?=
 =?utf-8?B?QmRiMzFQN2YzTFNGMFE4S0FRRlJqNFI5MnQ3TVZHdnprU2c3UkNudDl3NHhR?=
 =?utf-8?B?Q2t4WUh0enpuMEZ3ckVKQXQ5bU8wYzc2MEo4VEJvbDB2MlE3UFczUFpTbGdu?=
 =?utf-8?B?cmJ2TGdJUTJ2N3JraVhDZVQ4Sjk4aDdnTTBYVXpaNWo0ZlMyb0RzWjdUVTJY?=
 =?utf-8?B?ZUowd2F4RjQwcjVNUkZ1cFk1MCtZU1RNcGhnZE9SR216OGo0QjQwMmtrQlV3?=
 =?utf-8?B?cG0rZFY3VTdrWnhTRlFSaldTTjBReG1QKzBEYjR3aEtXc0FoZTRRd2Fwc0lw?=
 =?utf-8?B?T1BCcTI3WTRwKzh1VTEzeGtXRFRPZkM4V21BL3NiamRrMmdrZEJtV01EblBy?=
 =?utf-8?B?RWxhb2JIN1NvT1kwVzNXaG9OZWtWMUZCWDVBTHNsTEkrVnVpeC9ScXRMV1VS?=
 =?utf-8?B?M1pTZHgzTURtZlY1YXM3MU1XekxickwvZllLa0t6TldwVjZLb2pYY3BvcEE5?=
 =?utf-8?B?VU9aTnc0ZFF2TGVrRkdVRVBabWlSNUlvVm9iejk0Z3ZxbDVscUFsOGlLWVZ6?=
 =?utf-8?B?VjBTTzdUcDliMmhGNFR6Rm4zU1M1OTdDeGFaTXNGaklvLzBXWlJtVFVoTFRS?=
 =?utf-8?B?T2RxczMzcmJnU2wvd1lwSTdYem0wODljaFVkYVZEQXFGYUZYaFo1TmlhQTlm?=
 =?utf-8?B?VzYxYlVXSXJtWlQxQ0hUa0w0WWFXbEVNNDZtV2UxMUt6c3N0OHhaY1RjSlVY?=
 =?utf-8?B?SElGM0xrQjJCRVFESGRERUEwMUg4V0JCNVdFOUloajFON1JObFNpTGVjRERr?=
 =?utf-8?Q?4YrI229xixM=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NGRxL2puZEVERU9WcE9Udld6WU1hRkVha3JFUWlXMDFVSVBreW5EcE9mczNV?=
 =?utf-8?B?S3pXV1B3TGMvaXpaTVNUODNrN09PdENTVWRQajQxWlYwWHFwSUR4emVoMCtC?=
 =?utf-8?B?eUxnVjZZb2lvb1ZFa3o5ZzJYMi9LMWxMRmloK0MrWDUzUm9BSC93QkZjNHdH?=
 =?utf-8?B?VVFKaGtDeDhLekQzdFE4dEYxNFZ3NnBQeU8yRXlNOElJbFBnMy9oSFNXU1Jx?=
 =?utf-8?B?aFE2MUlGOFZjRytTa0xZUnJWMHBhaDlYWFhZSjdxY1JnMVhnZ0xSNUFXaWFU?=
 =?utf-8?B?eWJTRmVxS3JySDBHVnFIR3VraE5MTmFSa0djbmZvMFdsMnhwNTVpTGxyTHQ3?=
 =?utf-8?B?a0lJeEU0clFYc05Oc2RvK0hFUHhKY0szUmQyMldjL3BMdjU4S21UVVVnRzcr?=
 =?utf-8?B?M3RSU0x2Q1NjeEhUZVNOd3RZNkFZSGR1V09VaFpPY253aWkyM09jbHhQMVl3?=
 =?utf-8?B?VmhPYzBTN2FEV3hyMDgxdC9iaUxvVTlqQ09raXAvMktuMXorOVVXbzFlKzFI?=
 =?utf-8?B?MmRpMzlhMHVpUmRmOU9uWFBWKzRNTG0zZ3dDS3RhTnIzbDZ1cUVXQ09UaDlp?=
 =?utf-8?B?QVBGZXdTd21DcFoxY2xhamRiWG1mQUR2NGFOU3NONVZVRXg0MzcxZkluSFA3?=
 =?utf-8?B?UEI5eUVKdlJLMVdmbGlyUUV1bTJ0L2Z1dVducGc0QlpaTVUreEJtdEdmMndB?=
 =?utf-8?B?ampyREw5L0syUVdVOHpYVUk5Q3JDN2dKa0FMRVVnd2xneHY5ZDhnQytZNmNW?=
 =?utf-8?B?TUd3OXZnSzl6anV1VFdMMkxoL3VZa2xDMExDbkFqczRDWkx5TjZFNUlsS1l5?=
 =?utf-8?B?VzRHb2RmL0lxYjBndWxvRHQ3cWpTUFJKcGVxeVZVQkI3c09uZXU0OFpuWDJk?=
 =?utf-8?B?U0t0cjMzaWNvNGEwU0dsaEFkU1JSakkxM3kzcEFhU2U0aFVKNnV1K2dXRlZ5?=
 =?utf-8?B?MDlnYWhTd3J1WVJUQWFOVVAxdDFhc2FmTDArUURGbTZLd014NHNXdUE1eG8v?=
 =?utf-8?B?cEdwY2YrdjZZampyUjFQenNBQlVpTTZZbmFueWhwTWlndmthQnhtVG8za2Qv?=
 =?utf-8?B?TFJkT2xKZW9sU0s3aWlyUGdvb0U5N25hSzRkbWZVQ0FIUzYwNWMzR1JMNzRp?=
 =?utf-8?B?RXMzVkRSSzFOOG1KTVRuZnVweUd4VkdJZytCY1h5UkdFbG40ZXF4akZQNERP?=
 =?utf-8?B?eFFUc243TDN4Z0VEaU12ZTFXeGhVWGg1Tkx1SkhMSUloejAyajF3ZmgzZ1BF?=
 =?utf-8?B?cmZEZjJnTjVpSzMrOUtlaHhKUnNhcUh1U0hQYTVNSVI5OGpkMEZUVGYwZVpY?=
 =?utf-8?B?VVBXd2xQSWgrelZYd3REMm9aNGtsdVkxRjVLU1VsTDB5bVBONW9GQVZnQjVm?=
 =?utf-8?B?ZUNzbTdvOEkrcG1iTlhhZDRka2tyREdBbzNoeUc3eVVMNXJVTUk2NFkvUWwz?=
 =?utf-8?B?cTZrUW1uTjBITWdkdWZhc2pBSFVYMVE5SG1kT04vZHZJVm1weEFPd29vS3BV?=
 =?utf-8?B?WWZ5Y3NQTm5EMENtelo1bE9HclNPZzlvRHNJejFjWXJwT283dHB2V3FrSEVU?=
 =?utf-8?B?OG51Q0x4bk5rLzFDSTE3ZzJYdjhoeGdKNW5hTnNVUHBMOHE4dlhvZ09WUWx0?=
 =?utf-8?B?MkxaWlZFNExQRDlNTFZTcUM4aFFIdHVKMk5MekpTaGxIdDQxL21KSUFQbk5P?=
 =?utf-8?B?Kzg0a25lZXFXN1JlWXVBL0l2MURleTZaeG80cWkwRXBGUG4xTlRoQ1d0amZV?=
 =?utf-8?B?UXFIZXZJVm00d2ZmYVpZL3NLTFFoZXJmdnVpRWtWSHJBS0dMMHBYNFhLdHl1?=
 =?utf-8?B?N2h6VjJZNGNuOUx2TDZyZWYraExuR2REa0M5WXBrbHhIdW1zbjR3NjNsOWF2?=
 =?utf-8?B?R2NtMW5HOCtwNXI5Sk1pTWVaaFhsTFVUQ0RHWm02SXhXbnlkVmFYRHJZK3E1?=
 =?utf-8?B?R0xOa05ZSHZSUklRdHV5QWlpRVdXV0VNaEFkMGk3N09vaE9DbnI4REo2QS8v?=
 =?utf-8?B?NEVWOGJjNjNRUUlSd1FBV0xIcXhuNHVSNWxCTnd4UU5HTUZ2UlhKdS9MMjB3?=
 =?utf-8?B?M3hPNU9MRktHYjFZVlM1Tyt0a01xbFZDNmFIWXl0RytUZ3hyMVNaN3hxcW5Y?=
 =?utf-8?B?Z2xkcHhVVnpXUWNBNkJvUGF1eFhsd1FKY29PQlRNbVpIeVh1TzZMSlAwSkdR?=
 =?utf-8?B?aFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb713e6-aaf1-41c5-e205-08ddb95082ae
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 10:09:20.0156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s37DYqm5W4mS5K0z4hT01/uiDHTO4m+BpyMEHL/WIEe3A69YtvIIPA/wdxgFir65WbP3PihcEN3C1Un6AUfe8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9101
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 10:09:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19284

On 02.07.25 11:58, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> Hi Jan, 
> 
>> No. I mean, only if the rootfs is embedded into a luks container because we want it to be encrypted as well, this kind of error is expected. 
> 
> Thanks, understood. 
> 
>> Do we build that security image with kas/opt/encrypt-all.yml?
>> If we don't then you likely did not hit the rootfs but the luks container for /home and /var.
> 
> In CI, we use kas/opt/security.yml for security image so it internally includes kas/opt/encrypt-data.yml. 
> So, it means it is hit because of luks container for /home and /var.
> 
> In that case, is there any other way we can simulate the dm-verity corrupt scenario by manipulating the .wic file. 
> If not then we can adjust the test case to confirm the this (Could not find device mapped to 'home' cannot be encrypted) behaviour itself and write the LAVA test definition accordingly. what do you think? 
>  

The approach you took would have been my proposal as well. But maybe you
can enrich it by deriving a fitting offset from the output of sfdisk for
the target image file? That will also work without privileges and will
ensure that partition changes will not break the test case.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

