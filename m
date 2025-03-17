Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBC9C35FF3
	for <webhook@archiver.kernel.org>; Mon, 17 Mar 2025 14:55:10 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.40])
 by mx.groups.io with SMTP id smtpd.web11.54779.1742223306852215925
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Mar 2025 07:55:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=lMJo+PhZ;
 spf=pass (domain: siemens.com, ip: 40.107.241.40, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cMaNZ7BboUcCr6M+vSoa7sEtLMW+tXq6iEdhqroDtlKWyS0wcb+faYRrcbfj7uEVagttbeCH8tGUXZyVN8PPcNpI5HPawTK3Rhq/IehBtiGY+U5mrx51OUx4zPJN3bUlksbd5PuNzxwsPbuL+ALWSpvUrM/gWbiu0yCB7P58gsJMevebDbW2udvPVkdeP296W801iztJJnxnufYfUHGfELuEbLDq3b5OKUq4teQWVyIGxQ6TOiu+T0OtJCfZVD+auUfMwHA+hbsH+XO/35b0orp1Y4UWszLKVqCjqiNgNeo2PUOU0XdymqYvHcqpglYSz0/rnM9XJLXsOsYP2oMbtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xe/BJqsClmaRhTy2RUBwkqbTaNgMErtnKr4yP/Fe+Wk=;
 b=nloqjSnr0ZPmjXa4FtsVGOEEnH/kQGYjN1j+tMYzHj8JERu8XnKA+PU7i4LTcx662D7nPcPrnOf394JqqtoW3YaQmnS9B7QijhaKR2hJGLirzbbX/Ecg7Olte4/578imQ9fhQIs42toQZUXhiXMysDLwBYDT/a6jCi6l0Xv3AByD/5LoXOhRRn0urRH+mUf5d5v3jYZvscARi9nQbOhDHvPGJHLFq1ViYCjVE1nBqIL8m7jQOr0WNH2rwpmpnQYtH4W2Ql69gohpp1QkOPblkvBEaJW0rPUiFXzFn2s05YEof7+rG+skC2A5T1KQNOuJZob1bQ5thdlOUI8LcVin+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xe/BJqsClmaRhTy2RUBwkqbTaNgMErtnKr4yP/Fe+Wk=;
 b=lMJo+PhZtnDZ6cOKR4LmerwTVZCdVIukUrrcIoVaAVzDxUNAPEec7HICybyxx15GLtL0wDRWTMfut+b0nTDmsQOvSfFoaJNhtuV2mtarKtfSbJzuIl2m55O9GbH5RwzneHMfuNlc1H0xoifLAqAJRffO2pQAF3JjZSZeG3tY6UBSwNU+pn9oQh+fZenq9pr099ut5ySMvp/sAahAX8boMTJ1NXmIm/BNCty7Fv/SHWJVjcBON8cbdsysA15wrQGGjynlRzO0JnNkTv3LgIa9zH5DJExMn1+kpPa+iKXyoMmyiwJ2PK2x1KwToHA6gixw1kwZczj1oUGvBDdx/mNwMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DB8PR10MB3738.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:118::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 14:55:03 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%2]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 14:55:03 +0000
Message-ID: <d2bd42c1-6c64-49a1-80e1-50419d2e5fc8@siemens.com>
Date: Mon, 17 Mar 2025 15:55:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC] Add documentation to provide
 project specific signing methods
To: Jan Kiszka <jan.kiszka@siemens.com>, felix.moessbauer@siemens.com,
 cip-dev@lists.cip-project.org, gokhan.cetin@siemens.com
References: <20250317112102.609922-1-Quirin.Gylstorff@siemens.com>
 <b0d9eded-a489-4941-b890-09e7788aaccf@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <b0d9eded-a489-4941-b890-09e7788aaccf@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::11) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DB8PR10MB3738:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d4b19f0-16a3-42fc-d42b-08dd6563b293
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aHV1Wld3MWJ0ZHVRM3BrTUJzUkJWdDJ3TTZjOFZpc2JmMVorb25ScnZ0bDc4?=
 =?utf-8?B?RDdGaDdqMHB0TEJHdXpvamFJcmw3Tktuc2swbUUxRSthWnFoQzQzQjFhc2VS?=
 =?utf-8?B?NUpxTDZ0KzVhaXpmQm0vNmlxazVoSElwWktZMDlsUjVmbTZXWW9YQTQ3eGJm?=
 =?utf-8?B?MWdWaEtGMG9wRmlwcUthSmVNd0laQXM3NWxpeXVyTDhFZ0QrNy9nVEEvbDhG?=
 =?utf-8?B?WEl1NDZIMndMczRDb3c4blJqQkNJc2Z3bWRRVW1wQ2JqMjQ4dlVLQzVMdE9J?=
 =?utf-8?B?WHlTaUQ3MEwwQVFqNzhiSUxLRWNVUG8rakFLYW4vVUsreFgvVjM5SmZpQ2ZK?=
 =?utf-8?B?Z0dtMUNIY2MxMXlnaVpBbmNMeUh1cUdwVkdnYlZWMDJDa2lrRkR0MkwrWUc0?=
 =?utf-8?B?QkhsdmEwQk9wNDg1U0lCQnUyN3huYmhxc1FiMWcrcHNRV1RrWEZKQm1EOEpn?=
 =?utf-8?B?NGs2c3pjb05XR0IzRnVsb2VDOVdxV1hWa1B5UjQrcW53bXp2RTUzaWpyaWVt?=
 =?utf-8?B?eWxHNXlwQVJmeUM5THpHNllzMEdQa1FmcDRWcUpnbDhJOWFUS0gxcFpCakFV?=
 =?utf-8?B?UkhyUmVRTVQ0VTNKdnJrcUl4VUxZemRKWEhrYzF1dlBBTWgvazhxY1FJT2tN?=
 =?utf-8?B?OFFPS2ZiWi95SzlTQWxzd3dCT3dKd2dDakR3d2NZV1h1RGlHSlFPWUFZNldn?=
 =?utf-8?B?S2dHb2ZPdi9ROGJIUWlJSFhjSlF1MVlVZGtsVml3NnRyUGxyVXdjMkVNSk0w?=
 =?utf-8?B?anFlUlZNLzFUWFhTRm0xUjB2Uk5ORE9yM2hqKzlESk5PSHJ4ZEFoT0JKOTNu?=
 =?utf-8?B?WVZlVmpUZlcya0h2Umk0N21iU3gzMjBZMnphU2srMW9LZVlndkxMMU5TaDVO?=
 =?utf-8?B?NHNrWFRiYzRxVTZXRERMQjYvTHBkaWlEMnk5TVNBSzdMQm5QdW9WNnBLb2RF?=
 =?utf-8?B?dGxSY2JqVmovcndybExMUjJieC80RmZlWndlbzdtQTRUd0dodHBmdEg4dkd5?=
 =?utf-8?B?eVRBR05saklyNHhtQkVqcW9GSDdLTW44SU5NNWFTY3RYejBwaWRBN2pvTm5s?=
 =?utf-8?B?U1dMTnB0UE9vakJtOXhzSU1qT2QxWFVWdGJyUDRLVUJOeitzZkIwbGJ0VE94?=
 =?utf-8?B?WVRiTDJ6SlF3bENxbmJJdHlKbDhXZ3hLbm1TSDltWjcwRnZkSEtiRnZGV2FF?=
 =?utf-8?B?V2diKzUrZTdEeEhtRTZLNm50V014MXp3TzJ2YTRHVGxDZEk2S2pyK2VUblZ4?=
 =?utf-8?B?VEkrYVREWUYzeE90aUVFY3Rvam0zTTBjNzVZcmRESkoxLzgrek9rbG1PTEtS?=
 =?utf-8?B?Z01aVUNobHBQS0swb0dCeTlwQW1PWkZlaDM1d3VVRDRPM1VDL1IxS0NOV1Ny?=
 =?utf-8?B?aSsrTDhyWWU5eDcvY3RISGZIdHNaemVJeHhRdnFZVTJvOG5HRlM4NmY4eENW?=
 =?utf-8?B?UWV2L0MxaC9QVlZCZTU3aVRVWUxhZ0tab2kyTUtnRkNWbzdJeTg5Q1Z1OEpH?=
 =?utf-8?B?bFB3a0ludDV4NEtHNE54SUd5dG5yd2Foa05sM2RlU2tsKzFIek1tQWtINFNF?=
 =?utf-8?B?Wm80NUp6Uk10SUgxZS9PYmx0MGxOYTB0RHR2Zm1tUjNXeFJoTmZKRUxwaXRr?=
 =?utf-8?B?UFNFWWtUc3ZmYWpJSTRrUXhwdE9oZ00yb1U4UmRSeG5VU2tPc3JQU1ZMSkhW?=
 =?utf-8?B?bUFzQjFsb2NLamxJRGZCTzBBTW1nNjBuRlRscndVREhoMDJyRDh2SU1WaFlj?=
 =?utf-8?B?cTcvSjNRQ2FGY21ZQUgrZUUzNHpuTkg1TlJGcUdockhUSytQbWRUeUxKbG5a?=
 =?utf-8?B?YXo5elFWam9ZYWJlRm5DYXhGcE5IWkRiR2pnZzVMeHdwdkwxRVF5eEk2NUhr?=
 =?utf-8?Q?XlARoBj/35Jbj?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y2pHZFRKUUQ1MGo0ZnNUZXNBYlZjYnovMmhQMWs5MllzdVdwNXR3RmRRK3cz?=
 =?utf-8?B?MnBxc0QyUVJqWExGbVd1RUF0QitMQnpGQWhLaTFadmFUajQ0bDgwb0VKYmg1?=
 =?utf-8?B?Nkc2SzdtVUJVbzdxZ0I2QXRwK0wvN0k3V01Ea3Q2QnNnRTh6Wk1QT09jeHUr?=
 =?utf-8?B?ZjVMM1hlVzYwaFJSNUx4K2ZyeFp6WndJVGFSa2lRNjA1WTlGV1RSR1h6amN5?=
 =?utf-8?B?NVIrWU9TN1BKenpyLzZZNzh1UVBVK3M2RGtWOEtRSEszL29rL0VZd05vVjdy?=
 =?utf-8?B?Ni9vQjhrN1BqZWt6YlVhbUlmb0Z0VGZNM3dMakt0RGJZYnNzNmFQNGtNUFNV?=
 =?utf-8?B?WEdLRXE0VzVIdyttVHJTMURka1hoTFJmRjhmczV2VWxldGVSVG9kY25wNlR0?=
 =?utf-8?B?TkU1anY5TWJ1RmlBQU5uK3hramZNbU9IY1BtUGpYOFNaSzlRenNEVExkeTVI?=
 =?utf-8?B?TnVNQ3lZYWdFVDNRd1VsbHV2RWxMRjZlaFpJUlBhdy9XOWtpZWJnTCtTOU1j?=
 =?utf-8?B?TXBXTU9zNHBpWFBoUXRJYXRtRnNXVlIwZjNnWHlEUUdQSm5ENjNWR2N6WjVG?=
 =?utf-8?B?QytYdXUyTlRYOEx6YUhDZE9oVjhWZEtqWW1sNzE0dnVRSFNiTW9JWU5TL0Zv?=
 =?utf-8?B?NWJNRHozbm41Sk9YWkwzTW1UcEQxUHdsbUJQYmJQOWozS2lXeVk4aGovdlJp?=
 =?utf-8?B?SWdLM2xINFRRNjdEYnhUaXBtQ3oxQlRHVzJnMytHMVFneVVWWm5HNjNLelF6?=
 =?utf-8?B?aGxPeUJYOHhPNlRMUzYzMkZGZlZJaWxhMVhDK2JMckRuaHU1NmNKcE5uOGZW?=
 =?utf-8?B?cWlSMUtjczNMZkVPRVBreXFzL1NhMkZ5dUd3NitudGZpMkczdWM4ZmVWa25l?=
 =?utf-8?B?NVBKVW5LcVZEamwveC9XOVVySEZrZjdNOHNBNm1JWUUxbkthS0NiRnh4UE05?=
 =?utf-8?B?cC9sb3p4d1plaDlOS0RjbzA2RCt1SkU4dzhyVUxsYU5wL01BSkNUZVNHRjFK?=
 =?utf-8?B?d2lpRG5kalNSUnJ6YUxhbWZoVmc4Tlc4ZGZJWHhGRW9nR0U5WVBuNUpaNGdK?=
 =?utf-8?B?aDczdm0wd016bmI0cXd0Q1lFQ3VPN2NQa0Roc3JDTTVZZ3dVNXBlRzdseFZM?=
 =?utf-8?B?akY0VTV3UjhBUVp1U1EySXE3LzlraGN3TzVwd0Z4YVlucG8wUVVISkF3dmlJ?=
 =?utf-8?B?M05KQmIzWFlQdGw5YmU5ajVHWnhaMTlzUElCOVQydmVNRTRHd04xSyttRlZO?=
 =?utf-8?B?QThhMUx4UnR2WUJZNGdFYVp4dmNzenV3QW9ZbnpaUStmMHhzZjI3elhvYWRG?=
 =?utf-8?B?ZkZEcUtTQVdLckZWd3ljd2lJaTQ3cFU4b3JjU1JWZk9JNkZDMENHbW0yOG5G?=
 =?utf-8?B?ZG1tSFFvU2owYUdSSzhrNUhMNVBtOFM3YzA5L2taUU1FcFFBSEdsVVh4SHVZ?=
 =?utf-8?B?alQwRCtnSjZxbWNUVHVNc0ZKa0dhTFNVWnUxV2RrdHpvWlVEaEhtYzBDM09x?=
 =?utf-8?B?L05LbzBrNDJTQ3ZrbHAwdW5QYlNHZTRGN1FZaGU1eTZoRlk1aHhlcVpKT1hv?=
 =?utf-8?B?cTdsRThiYUY2M0xsQW4zeXIvVjF4bHJjSThiVDdMNXA2STNZRExGQXcvQnV0?=
 =?utf-8?B?aUJKWE56cmZ3Rnh5MzFWK2RXOXRWQ0VDMTJQM29sS3I2NU9qS2l1akQwTnRG?=
 =?utf-8?B?K3pqbmpLR2xhVndiV3FBUTU3WXdrOHFFTEVUS2h6UWhROGVWTVhndVo5VHJD?=
 =?utf-8?B?SjNUUU82RXpiUGJXbXcyZllQbU8zM3Y0ZmpUTU5GQ2V3MnlxR3JjdFJKZFV3?=
 =?utf-8?B?SExseElSd0lyQUIrOHIra0JoQ1BmQ25TVUwwWnZncUlveS9wd3NLZ2tHWjRJ?=
 =?utf-8?B?MU9OMzg2TlhueHhKTG5ZMUJNV2x6bmIyS0tSMXJKdTJnNHl4K1pXYmVpWjdq?=
 =?utf-8?B?ZlU2TkdkOWF0Y3MwVEo0eVZDWHo0azE5MXFIZ1hXb3JITHdXYkJIdlg0MWNs?=
 =?utf-8?B?VEFBTVFjRysyZjd0NXZaN1dMdFRpb21xRHZtT0Z2eXdXRjV5S1NVcTBBNG9u?=
 =?utf-8?B?Ymx3WlFLOHlxNWpqLzBzaVZZbFZjMjVLMFJSWEpZcnBMNVJQK0xKUmRYb3dv?=
 =?utf-8?B?VGpsMG9iMFg0L3JIemJxMDVnMTdib09kS2N0VGxEOXpSTCtsUXJWODZvMEF0?=
 =?utf-8?B?ZFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4b19f0-16a3-42fc-d42b-08dd6563b293
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 14:55:03.0493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JMD76RTGyEKbXPXlG/OqZAnetK2dkedRYzpIK8ofjUm26WSh3nXPPYvif9p+kZAcrpljMhu8DiqJ4I2SebG9+Es6ob2qOUwguBiwClpeoms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3738
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Mar 2025 14:55:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18234



On 3/17/25 14:55, Jan Kiszka wrote:
> On 17.03.25 12:14, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This documents the preferred way to replace the signing scripts
>> provided by cip-core with project specific variants.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>
>> As we had the discussion how to unify our signing scripts this document
>> provides a overview of the current state of artifact signing in
>> isar-cip-core.
>>
>> It is currently a separate document to have all the information for easy
>> access in one place. I am open to split it up and add the specific parts
>> to doc/README.secureboot.md and doc/README.swupdate.md.
>>
>> If I missed something please let me know
>>
>> Quirin
>>
>>   doc/README.certificates.md | 93 ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 93 insertions(+)
>>   create mode 100644 doc/README.certificates.md
>>
>> diff --git a/doc/README.certificates.md b/doc/README.certificates.md
>> new file mode 100644
>> index 0000000..7283cf7
>> --- /dev/null
>> +++ b/doc/README.certificates.md
>> @@ -0,0 +1,93 @@
>> +# Certificate handling in isar-cip-core
> 
> This is not only about certs, I would say. It primarily  covers the
> signing procedures where certs do play a role as well, but so do keys or
> signers with organizationally and/or hardware-based protected keys.
> 
>> +
>> +This document describes how to replace the certificates or certificate handlers
>> +in isar-cip-core.
>> +
>> +In isar-cip-core provides the infrastructure to sign:
>> + - efi binaries
>> +   - efibootguard binary
>> +   - unified kernel image
>> + - update binary for SWUPDATE
>> +
>> +isar-cip-core uses the Debian snakeoil keys as to provide an example and during
>> +testing.
>> +
>> +
>> +## Signing an update binary(*.swu)
>> +
>> +An swu contains an signed sw-description file with the name sw-description.sig. This file is
>> +created during the swu image build process by calling a script call `/usr/bin/sign-swu`.
>> +The script is called by class classes/swupdate.bbclass. The script has the following
>> +call signature:
>> +
>> +```
>> +sign-swu <unsigned efi binary> <signed efi binary>
> 
> copy&paste: it's swu, not efi.
Will fix in v2.
> 
>> +```
>> +
>> +The default implementation of isar-cip-core is `recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb`.
>> +
>> +To validate a signed *.swu the image needs to contain the public part of the certificate which
>> +is stored in the recipe `recipes-devtools/swupdate-certificates/swupdate-certificates_0.2.bb`
>> +
>> +## Signing an EFI binary
>> +
>> +EFI binaries are signed with the script `/usr/bin/sign_secure_image.sh`.
>> +The script is called by the wic plugins scripts/lib/wic/plugins/source/efibootguard-boot.py
>> +and scripts/lib/wic/plugins/source/efibootguard-efi.py. The script has the following
>> +call signature:
>> +```
>> +sign_secure_image <unsigned efi binary> <signed efi binary>
> 
> Maybe time to rename to reflect that this taking only efi binaries:
> "sign_efi"? 

Sure we can prepare a separate patch for that - to only issue is how we 
handle that change for downstream layers.

Or is there anything generic in this signing so that we call
> it after the signature format?
I would need to test that.

> 
>> +```
>> +
>> +# Replace signing scripts
>> +
>> +The preferred way to add your own signer is to use
>> +the overload the necessary recipes with `PREFERRED_PROVIDER`.
>> +
>> +## SWUPDATE update binaries (*.swu)
>> +
>> +To use a project specific signing script, e.g. when using a HSM,
>> +add the following lines to the build configuration (kas file or in the
>> +conf directory).
>> +
>> +```
>> +PREFERRED_PROVIDER_swupdate-signer = "<swu signing package>"
>> +```
>> +
>> +The project specific public certifcate can be replaced by
> 
> certificate
> 
>> +setting:
>> +```
>> +PREFERRED_PROVIDER_swupdate-certificates = "<swu certificate>"
>> +```
>> +
>> +### Content of the swu signing package
>> +
>> +The efi siging package needs to provide an script at the
> 
> signing
> 
>> +location  `/usr/bin/sign-swu` with the call signature:
>> +
>> +```
>> +sign-swu <unsigned file name> <signature file name>
>> +```
>> +
>> +## efi binaries
>> +
>> +To use a project specific own signing script, e.g. when using a HSM,
>> +add the following lines to the build configuration (kas file or in the
>> +conf directory).
>> +
>> +```
>> +PREFERRED_PROVIDER_ebg-secure-boot-signer = "<efi signing package>"
>> +```
>> +
>> +Alternativly the an own file name can be used by modifing the signwith parameter
> 
> modifying
> 
>> +of the boot partitions and bootloader partition as described in [README.secureboot.md](./doc/README.secureboot.md#wic)
>> +
>> +### Content of the efi signing package
>> +
>> +The efi siging package needs to provide an script at the
> 
> signing - spell checker??

The were some quoting issue which disable my spell checker - will fix 
the spellings.

Quirin

> 
>> +location  `/usr/bin/sign_secure_image.sh` with the call signature:
>> +
>> +```
>> +sign_secure_image <unsigned efi binary> <signed efi binary>
>> +```
>> +
> 
> Jan
> 


