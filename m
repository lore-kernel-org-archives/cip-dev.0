Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625A7C5321E
	for <webhook@archiver.kernel.org>; Mon, 26 Aug 2024 13:17:12 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.68])
 by mx.groups.io with SMTP id smtpd.web11.51948.1724678226452024666
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Aug 2024 06:17:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ve8NgOkd;
 spf=pass (domain: siemens.com, ip: 40.107.247.68, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WT2VG77szMWT7aD5/uCURzzg9hXlgMzw/reFvzHjk+22iUTQIrovKQ6xENsTQ5tG/2xPdjE2xBiRn7/12TY6SkTR6YZRTP2gtPJKtdanqnSmEwDNvpc+i+S4Ah5QRPWGS/69xctfh7p4ff60gEmts8+xSpIybyU24UK8VAte+b244mPeVGjdFYAGLcW0/AaOBRxByL5Rs2J3/PHQGbo7hPuQ65GWNvsRmOeXWuF22JQXnx6NN8sQF0nbftqTO4gqT05K6a42F8RaN2AjNCHQEiNk9YlvNDIXzvEaBXFq2ZCjsxrI0mvP171tLZVifanJmT4lGY5aqxfip4tJ92E+pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Mi9AUg3DfqMmSH/6FeFCmfzbv8tqNYXzF5a19LypcU=;
 b=Zx8PyaZeCJLkC2eMjzpI4Bfm18npZfNrRCsE9Fv18JQfD3FI+Y2H2lxvOT7QQyqV5EN0XYQA/fUG/fKv3GWTysirWBhZ2kum5OtVsk99Ph+yrqtQ9Lqe7+pso49DasvaEeI+1FNXuX9ogy06+yWSA3wsANZBK/wpjAn7OfHsC3bocU4KOUJCAzChPPZfc7rL/j+WSw8EcMx/7hhGNF0UwRVozcuJ6Jutm3hOnKJ4BH4Xxm4AYcukay0XVB1nG1KihV0LvZCq8q4UnwpaP4P3Jz48S2NXMJhQ7ExUOiG5w4MLqZ8Dy3sv+LHKVDYUTGkUn1naUXuTDiTLaSOzKXSDOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Mi9AUg3DfqMmSH/6FeFCmfzbv8tqNYXzF5a19LypcU=;
 b=ve8NgOkdXzW2nW0xK+sMHXAVVSoNYcqDnFwrxTZ/fJDvJUfOJSfxqopcsMvtBSB7QX5PseGmL6uV2bsVe/RNM/ORlb4cpsp0XEqZr7mysa90rGy2Z3i3BWOLUlIzD2PEYmCIZmmZSg/bwANqDoeEjTZl/uo0VTm7Bm8tfHqwre6UgbZMbNJq3nBD/q0c2go+gVSwDHWauTqhGBWYEzY3+66/NUn5SAtfxVUQGMTN0KMyWpzCKzPXq22QLQOwIOa7U8kb/KKVuyP4zhibB5jJsiei1m+XowkbCOO0dW3oAWynXRiZD52KUI8Fq/cri1ewhHJcOjgxYn0DCVyNQL7Zcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6424.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 13:17:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 13:17:02 +0000
Message-ID: <875945bf-6be7-46f9-803b-dbad06734b72@siemens.com>
Date: Mon, 26 Aug 2024 15:17:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] Fixing dependency of package
 expand-on-first-boot on cryptsetup and tss2 (tpm2) libraries when building
 with disk encryption enabled.
To: "Heinisch, Alexander (T CED SES-AT)" <alexander.heinisch@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Gylstorff, Quirin (T CED OES-DE)" <quirin.gylstorff@siemens.com>
References: <20240823161906.1168642-1-alexander.heinisch@siemens.com>
 <70399ffd-bf1f-4a28-b8d6-b7a7981c7726@siemens.com>
 <AM7PR10MB332074787FC29E44AC3F6AF3868B2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <AM7PR10MB332074787FC29E44AC3F6AF3868B2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: e1b7c69c-103d-4c77-fe31-08dcc5d15faa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VFRzWXJzS0xWVVlLbkNjZTJHWXVKY0xMYlZGTi9LNkZKYXljYWloMzNiSUtJ?=
 =?utf-8?B?MjV4TlZEaktmcWVVTHNkVm1ucTBHODk3czJUVU43N3JRV2pqc1pIR3NjZU96?=
 =?utf-8?B?Y1B3S1RXOE11TS9Tak9BOUxkUGtFNzE0eHpXQnFRTVhKclppYzJvdUE5T3FG?=
 =?utf-8?B?dWFBak9ZY1huTDBaOGNIL2p0RXRnZFFtTXVwTGRaZjRXeUphQ29RVHVRQU9I?=
 =?utf-8?B?dktkQ09ldmF4WmVnUTZjTnBzQUhrRzIrQ0xNYWdleGdCM255WXZHVDhxakNM?=
 =?utf-8?B?RmtLSFlNc1NwbnRkVTRFTG55S3U4Mm5RQU9SUmFwU3RhcFlrS2pPbWV0d2FB?=
 =?utf-8?B?TDV3OXV4VE12c0pxa29KbVpkcVhqNi9TcERteEcrdDNVaUovajRWNUNtUDAx?=
 =?utf-8?B?M08wSmlGemt3YW50TE14dlZWb2I1MnBiYzY2ZWZ0TzNjRmdjbWZpdXhwR0Fr?=
 =?utf-8?B?WEp3dVdodGs2QkdoODNYeWcxVU9QbncxRmxrYmtLbjJ5OE05SFZRUlpwRzZ4?=
 =?utf-8?B?K3NScUIwdzhaUGRTYzRQUkx5cXlUWVphSmMydkxmRGdYWHU2a0N1SUtxUlI2?=
 =?utf-8?B?V1BheGZsMGV2anNoWTQrSWJwRkh2RmRsRUFzUlZORCtDUFo1OFdxRDFHZDBh?=
 =?utf-8?B?SUszZnF4OHZ0QndNT2tLRThPUlNrSm1QSW9TZ1NqcnAvMk9rQmdkbElQMlRi?=
 =?utf-8?B?SWpwWFl2dXZzMkxuR1JFVzNlNjd4eDJVT1IvcjZyaFhubFpHYjlIaTQ1QXdp?=
 =?utf-8?B?TjhBeEJjT2ZWSFdaT3cyVEVKMnJiaVdDallhV1JreGREQmV0anNpWENmYy9n?=
 =?utf-8?B?UEJwYmxucCtKd3RtRmw1UVRMNkpHTWZQdy9ZT3h6ODdwOTJBVEJXc2FsM2sr?=
 =?utf-8?B?VzFvdDFkNU56bXJIK3pWeEJQTVNkVndDNGVPVEpPdzk1WTdLclNUdE9tRmRj?=
 =?utf-8?B?YTdtZ2ZJTXZCMWM1M25RTkE5WDMwTHpKamxnWU1WT0ZBRzNrZzFFS3hiOEJH?=
 =?utf-8?B?dzBzR21jY3pGb2Jxd3R2eHkzUXNzSnBWaVRQVmw0aUhNYklrdkNCNXUrLy9u?=
 =?utf-8?B?SXVOUDBOTldEY2xkamcyM0UzVzZpbjBGRWlzbWtsbk5tWjBxZ05IK2o4R241?=
 =?utf-8?B?UEZkbVNadFpFMTBlUzgxNkJhTVZsL243SVdOaldXMjlJZmQ0TkxmMC9nRVpX?=
 =?utf-8?B?MVQ3YmJkVWYydkFITTJhd3QzV1lYbUJnSERsdVk4amhjNGNOaHNmc0Q2K0hJ?=
 =?utf-8?B?T0kwVkR3QUx4UFJBZ1JOT2hrZmZ1a25KS3MrSEI1U2tEQ0Jiakl3dWFZZkRC?=
 =?utf-8?B?Qkl1RHBFN2ZjcVlnTzRabG8vV3ZNRWhsdXJnL3ZVUjZZaFRGS0FIc1NrSmk3?=
 =?utf-8?B?UU0zT3N4MFVhNkpoK0ExaGJrbWdZTGtJQjZqMVhlZGs4dDAraFpzVGdqbUo3?=
 =?utf-8?B?aVp2YmdQWWhQUVNObVNkMStmcG5TdlhYaDhYUXpkWHFOQXVHUXpCcEpGeTBo?=
 =?utf-8?B?MEtDOXhvMXQ4dTIvTWNzTkZrc1lPWXhYemg2REEwYy9SNXM4MWlsN3oySCsv?=
 =?utf-8?B?NU4xUkMrQmdwMEVRNld2ZUQzeWNkQmd3K2tFeVpvWTk1a283YWJLQ0Nhb0lH?=
 =?utf-8?B?TU0vc1czcy90TGR4YnRXWVNBNVkyMTVYWnNPTVBLOFIwc2dmS256Y0pPbXd4?=
 =?utf-8?B?L3cwUHJ0UkVXUVhNQ3habmt3cSt5RDlxdVVHQlh0ckErK3J1d2ptanRaVEpE?=
 =?utf-8?B?aUVYaEdGMDVqc2toaEg4b0YrQ1hQUTNIcWNCaGZSaXRFTVlEMUZrU2pqejRW?=
 =?utf-8?B?TnF1TkNwV2xacmZvSm51UT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SDBPd2w3b3F5Q0ZmckJjVldLMjJvcEY2YmJJenoyc280bkxjc29kNnZqdFNB?=
 =?utf-8?B?N3p1VWxjRUxSSTgzeXVhNFgxZENCMVB6TURKR016M1k0dkpSLzQ2dWluUUVY?=
 =?utf-8?B?TGtHUEd2OXBTWGl0Rm1JMXZnSHdrb0gyT1pOeUxmUFltQ1hzSlQwZk1DcnFn?=
 =?utf-8?B?VmFMdU80RjF6K3d1M3UyOU9IUXlCQXNySU53b0N4aGQrVW1nUCsrNTZGc28w?=
 =?utf-8?B?ejkySUgwejhURFZjcHIxK2hlK1U5VStpMGd1M0FuQ1NySXgrbTVRdndjVmJ6?=
 =?utf-8?B?d0QxYk5tQ0JTTWRoZXQ0NHdHQzVTcm5WVGNFS3hnSnptNEp1RzIrRFE0ZFVK?=
 =?utf-8?B?WGcvWlRiYm5JQXR6bnphQlZFMkpoSVJKT0UwWEhPUWozSWlvVVl0a1A3OVNp?=
 =?utf-8?B?bktsS2pLUUdoWGp5VHpCelhqU2NIcWQwYjluWkJ0UGVjR3NQL09XcGo3MC84?=
 =?utf-8?B?SnIxNWd4Ullhd3ZYaldzbEV2ays5MTBKWXBsd2dHRU1DQ3RIUzF0VHZzU0RK?=
 =?utf-8?B?OVN6Q0RMQSsxOG9MUnd3YXpSYWZqUkduTldNMkN4V0pQRGlXakFFTGZNVzNm?=
 =?utf-8?B?blJvYU4xR1hFL0pZVkMzSldsV2FJRGdPSzRSTjFDbGJiWEFLVzhHSmF0OEN3?=
 =?utf-8?B?T0JLcjlNd0J4YksrZ3N6Yk1rK1BPVklwak5OVk94Tk0vdzZmcDVhc0xxbTA5?=
 =?utf-8?B?RzViTnVxREVkTnUreVdDMHRXQ244SmFYTEp6cXVGSk5WWjhRbi8zMm9tb2pi?=
 =?utf-8?B?cVNtT0JSY3NmajBuQ3BLYUVBVmJPQjRVQU92ZmJpN2pENHVQOTM1di9kaTZx?=
 =?utf-8?B?UlJ6REF3cnhZWE1TejFEaUZTbXY5S0hPajFsRzRraDBiV3hqeTFjMm5SUkZz?=
 =?utf-8?B?eFNuQ0N2VWJhMlpUOHpGekNzazF1SkJsUFA2YWZGaEpzckFlVE8zNzFvZjgx?=
 =?utf-8?B?dy80K3BhOU5iLzdMRWJQamdWNytMZFV6cXNhZDZhaW0zRHROcGk3b0lvdExp?=
 =?utf-8?B?S2FyNU9hbDR2eHBmUTRmZ2F6QVlNalo4elhPdmltTTVxb3Z1T25oajNtUStE?=
 =?utf-8?B?WlVmVlI3S3NDdnkwZ0ZjQjNtVFlLS01mRU5FcjUrUlMzSHh6VXN6QlZTY1py?=
 =?utf-8?B?SUV2dFdKTUJhc0xLODRuQjBSdXJoL0l3TzhzNzdrUXQxdG4zOGcvZWhhQlRr?=
 =?utf-8?B?anF5WGNYSTFDZjRNZXQ1dGcrVlNiQ2gzL1FyTFVXY2ZlSWVqV3dJTGR3T0RJ?=
 =?utf-8?B?YStSbVEyOXZWbVEwRXBzTlI2T2dDWkxkVWJGZ2R4c1d3a0JQd282Vk95ZlU3?=
 =?utf-8?B?RGFEWTZzbHN5NVFoS3I5TURqQncwZ0RBdERBbi9Ubm14RUNoWVRlMUFkM3ZF?=
 =?utf-8?B?MG8zd2paR2RwNXd2VGJsc05aaklxYkptZ0FKRnF5eXIwTEtDcXYrbzJ6QjhP?=
 =?utf-8?B?TCtTaStYcXdGZ3k0eUo3Sk9tRDV6bGlMR0w5WlYvamlSVnJnazUvTlBlOTU5?=
 =?utf-8?B?NjRIR1BBZjV2SFlEcHdtVmRmNUlqaExmYkMwOExBUmkzaW9aaElTYldFZEJP?=
 =?utf-8?B?RlFjNEl2QXplcnpVN1VxRzE2WG41SHZIR0hWekE3SEt2RFpQRXFuWmFiYyta?=
 =?utf-8?B?SlZ2Nlg0SnNNdWp4dTNXZUlhRVZjU1FRNVdrL05CRm9HaTd5RFBqTnFOMmRB?=
 =?utf-8?B?Mm10eVRVRWZERDAwTmFkNVI4WWFkTDBCL1IwT1huYkRkK0ZjV0FRZ2U5SkxT?=
 =?utf-8?B?eVVjcVR5anp2N1dEelFCYndIcjZ0NkppZXIvY3RGT3FXNEEwMy8xSWJPazJv?=
 =?utf-8?B?bi9RdzBwRW4yMHdrNHo1ZkI5S2p6d0QvM2RTVm1rWjN6Y3p1ZWh1V1VNNHNy?=
 =?utf-8?B?V3Rjb3hnTlp4ckdCOWN3ZkJyWnU0M3hzMmc0QlB6K2REcWt3dVJzSi9zNkk0?=
 =?utf-8?B?cFN2a3pTb2NMRFJBbG4wcW13S2VreWF2eFFBVE9ndUxsclQwT01pUVV4NFNL?=
 =?utf-8?B?ZVR5TjVLS2U4T1FUOFhHTUZ1ZkZGQVJabXU0UDYvTmQxay9PbXdaYUFHZnZ6?=
 =?utf-8?B?ci9PS05vY0IxcEJidUdQNExDYnJWSUNaUTBQQzh4WGxHSE1PSHljcTBHQVVB?=
 =?utf-8?B?T01XUVZhWFlOc0FsamRLbXVaODZCUUQxYnp1UzRqSCtzNUxMT2VtMld1cHVB?=
 =?utf-8?B?SkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b7c69c-103d-4c77-fe31-08dcc5d15faa
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 13:17:02.5614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbDhJjbP1anRUNMODOn1AfG25UoMxXA2JPld682FhKQpTrPv5cDz33xZrNX1y305jzhqK+KNVBVa4WWKlBHF1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6424
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 26 Aug 2024 13:17:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16812

On 26.08.24 14:38, Heinisch, Alexander (T CED SES-AT) wrote:
>>> Since expand-on-first-boot is hosted in isar and disk encryption 
>>> features are enabled with encrypt-partitions override in 
>>> isar-cip-core, we extended (.bbappend) on said recipe by adding needed dependencies if this override is set.
>>
>> While the implementation of encryption is handled here, everything that expand-on-first-boot needs to run cryptsetup resize needs to go upstream. I should not matter how the image was encrypted before.
> 
> I was initially preparing a patch for isar.
> But decided against, because isar does not know about disk-encryption, using tpm2 to store the token nor about the override used to enable disk encryption.
> 

At least cryptsetup is generic and has nothing to do if a TPM is used or
something else. So, this patch will at least have to be split.

>>> +DEBIAN_DEPENDS:append:encrypt-partitions = ", cryptsetup, \
>>> +                                            libtss2-esys-3.0.2-0 | libtss2-esys0, \
>>> +                                            libtss2-rc0 | libtss2-esys0, \
>>> +                                            libtss2-mu0 | 
>>> +libtss2-esys0 \
>>
>> Two issues:
>>  - this looks debian release-specific and needs to take that into
>>    account
> 
> It is! But, since `DISTRO` is not limited to a fixed set of debian releases,
> I don't see an easy way on how to improve on this. Any suggestions?
> 

OVERRIDES contains BASE_DISTRO_CODENAME, and this is already used here
as well as in isar itself.

>>  - indention is unusual and ugly wide
> 
> Intention was to put all related packages on single lines
> while aligning them vertically.
> I see the amount of whitespace is probably a little overkill ...
> 

VARIABLE = ", \
    value1, \
    value2, \
    "

>>> +                                           "
>>> \ No newline at end of file
> 
>> ...and this should also be avoided.
> 
> Sure.
> 
> BR Alexander

Jan

-- 
Siemens AG, Technology
Linux Expert Center


