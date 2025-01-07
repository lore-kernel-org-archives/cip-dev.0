Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C460E77197
	for <webhook@archiver.kernel.org>; Tue,  7 Jan 2025 12:53:18 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.64])
 by mx.groups.io with SMTP id smtpd.web11.19434.1736254388815447054
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Jan 2025 04:53:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=gz3ojfnE;
 spf=pass (domain: siemens.com, ip: 40.107.21.64, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qh6GKxWlyIKh+hbzycZ2tep7py309zNK4NYjUH4FcmN81+wGBkSE/W5CMxSOuaswFTltw2SQluzwbxJQVvVJVKlJPYYEoPK925joIbTakSIEf1ZihvyFgum8LR23Sffc5A0adiDD7WLRSDSYbnsKbOF+1Cx2vFXeVcwCdw7eUUzLPRkcq+deYye1R4YVUZpn0dlUfvno4pAZ8YCnnY277YqhIpGvrQZAqOR8RcDiy5SDLz8HkqYSpE1s7j+Q2/FwiOlJ13w6S+TXWi9dj0rn0KAh3cWyz3fs8OVN66EVVPdNUeuzIX0xrYtVrOU1ZRHM4Wibs1j/CQQMMAI4ygNOrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSq4sw2r3eWxrNicTvITEah/DBG1X/5QqVb+GhGdfk8=;
 b=XrL6YnvlJ4SkXdMj+1S+6M17SCi4salK+OF53B4+B8TXCGlX9tCYwnWJA3bmKVlgP/bgLCSLwlUscP2UTTqRuQvoLhvicF6OS2zXmu7UJrl28yl2RT/+ZbPL/DmxWNccAciR22fwVOn7x8RU16b3seW6g3kd4hEFukTJkpBIi0rP7tqXr+r13eM/TFHXHRnz/yteyYJKsBqEMltp0zE6oV9l8lueDXMWXUzDueHTn4ve39vrrbhifloW8UGfXlg50NwvYy3QBezYVWW/HrxKdPHPpoTHJdG4JOujpKbnriobn4fow1ZRGjSZPPLO4rDf70UI4XOvoiet6YJasDaYBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSq4sw2r3eWxrNicTvITEah/DBG1X/5QqVb+GhGdfk8=;
 b=gz3ojfnEuEthc2QEiHxbMkB4FG3GvST2xXQrkxQebXi94zescAa+EmP2aJWzLXzppoi7kv8U0ZdKh2dh8yzG6SsBiFu9HtRgUtPkvc8qwq2CeloSv8wFfUI1HF/CO7w77Und+NKZGPSUx7iqG1yUF6TrDNJ87oxLdOJyG/k1ZuEbAOGNRQZZTg7ho7C1QHxQAN+Pa7vk3iYTgeQJuvuFH55+9H1YUM2gyyi/54qquiOMa9dAvUgdGjmV6rE9fUPT5gBK1zEs8uXwnCQ3EkMhJamI8ixGDhYY592ulkR6LDA2t8jPumLfaZF2yZfrlzrIlgq7HW/9BwHAdBDtr3Z/+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5517.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.9; Tue, 7 Jan
 2025 12:53:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8335.010; Tue, 7 Jan 2025
 12:53:01 +0000
Message-ID: <40d957e9-4fec-4f1a-9027-1089b6f14ca3@siemens.com>
Date: Tue, 7 Jan 2025 13:52:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC] continue boot if not enough disk
 space for encryption is available.
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20241220103918.1165341-1-Quirin.Gylstorff@siemens.com>
 <5e4cc176-e945-4cb9-a3b1-bf2e4320a4db@siemens.com>
 <1e879d48-ed2b-4138-bb12-7a07c0379ca5@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1e879d48-ed2b-4138-bb12-7a07c0379ca5@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR08CA0026.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::39) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5517:EE_
X-MS-Office365-Filtering-Correlation-Id: 40be3fd8-4bb2-434a-db9c-08dd2f1a37f2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?anpWaUNQWXVuazJGajhNUkF1ZWwzdHJjd3VmQ0JESjFTOXZ0TENHcmhiaWNU?=
 =?utf-8?B?UmZIWkh4b01oUUtXNVM4WWdNazYxaW5xQUk4U2VQRFNiKzh0ODFac0dUL1Fh?=
 =?utf-8?B?bldLdUdTdVN6N2pyeUVpcDVsdDdrdU1EcjFSZ1l2NVI2WjdXQUhuVlpWMHRq?=
 =?utf-8?B?M0dJQVBpcXV1QkFBcFdmL05vVmRuTkpiZkpnL0xHNGhQbGpWM242LzRkWjBL?=
 =?utf-8?B?QzFNODlEMExRYi9tZk1SZmk0K1grWjltV1lpdW9qNk9QNnNQWkdmSlBRQ2VH?=
 =?utf-8?B?K1hYK1c5WnMyQ0dHNTBjdXVpVy9PRDFDZTRXeCtTTHRrb2s5ZjBtVXp4MTJR?=
 =?utf-8?B?dS85TkVublF1czFLQklpMHJ6VTU5TENTdkJyVVpZSGhPUkQ4L1pJNFp5SlAz?=
 =?utf-8?B?cEpLVWd2YnVXSlVVVFZnK1JoOU1PU1JRdWQrMFh5cDFJSTF0d1B0Qysrd0to?=
 =?utf-8?B?OGU0amN0RDUwR1FPUlRaU1QrNjE4WUROOXBaWGRpV1lORVhoUnBKd1hKOVZU?=
 =?utf-8?B?QkdadjVuUThJdFBFYXN0Q1ZxYUYvbWdYaUsvZ1BIbmJ4TWVTK0JzN0IxNytt?=
 =?utf-8?B?Z0pUVDJYWFlPV28yVk9CWlI2WERaM1NmODZKRUxCRzZMTWpkNWJXVkg3WC9U?=
 =?utf-8?B?eDErYjNCZGFNS3hmeW5RdDZXcjlYd1RUR3VmdWJoT3k3ZStTcitVclpLMEor?=
 =?utf-8?B?WDlMOEc4VTM3dUpDMGxTcWFucHNJeEI2TXcwQmFNb2JIemRXVXJwRXFIbWc0?=
 =?utf-8?B?bXA4UWQvbEo5VVdJUzUyUHp4aDJqd1RjTWZ1aE1pdUlGc2hRSzA0TFJNaVNC?=
 =?utf-8?B?UEQrcFRlSVoxSHE3V0RCOUNRRGEvSDlTelc2MWVmZmdWTlVqQkE4cXZ0TTl0?=
 =?utf-8?B?ZFE0N3U1ejg1MHppQk9veFFTTVNpTThDcTRCbjlVdUZJLzhCOFNJUDF1RHZL?=
 =?utf-8?B?c0NwdnZ0a0dlWFJrdEdpeHJjN2NUTXo0d25ZZWZreXdkc1lXTVlrQVBGUENE?=
 =?utf-8?B?TEtNVnBDOFMxMFNhQzg1THNrZlBQTWNZQTYyem84VnNLTEN3T3NKNjR2OFNh?=
 =?utf-8?B?TGo4Z1ZHVjBGQlNuREhkUHg0cmdkTTJZYVNxYnpET3dreE1hL00vK0cxQ3Bl?=
 =?utf-8?B?cFhqY3RSWVBPMkxYMFIwQUxVQWxydFRsclJOQll1cHNJWUZ2ejFjdDhETnZB?=
 =?utf-8?B?S0tSY0VGNjJ2bUJPaG15SHhWYVhScFF5SkNlUDNIMHlEak1wcDIrZGJHeXds?=
 =?utf-8?B?Z3pSRHVXaUZRRTFveEFHTWJ3NW8zYTlwa0djR2RLSlU0N3F3WWhPNlZ4ZWxO?=
 =?utf-8?B?dzRsN0pJQ3o5dWc1T1FreVJlRlRyYjliYys5N21IUm5USkxYcVdBdDJhUld3?=
 =?utf-8?B?RkhXTW5xSzd2RmdTK2paUys5Q285NXlWZ0VEWktSZ3FNWkJxaDJXZGhDNkc3?=
 =?utf-8?B?U1JiUkt0Z1VqMTJsbTY4RWdINzVZaExWL24rbVRnUE53RGZiYzAycjJiV0di?=
 =?utf-8?B?Smh3bk5kSXhJaVNWQXJTQVlidHF6YkdDanhld29WQ0ZrZUpPQzY2WnRxblVr?=
 =?utf-8?B?SzUrMDRpTnhxdUJnTHZwbG1IS2tudFhCcXFyN3EwSkVHa2RVaWtwcklvYTNC?=
 =?utf-8?B?c2RqQzVyQ1FWK3JnMGhGOWZoSVpCaHdyaHBseWtGY2NVeHB4Y3YySWJGYktq?=
 =?utf-8?B?dGpMNjF5UWJuRittczk1dlA3clp1a0RNRENyUy9RdGo0S3FEeVZxNkQ0QzdL?=
 =?utf-8?B?dERFK29wQitBNE9mbS91VXBlR2xOQ1p6dDYycG85clZrdmhyZ0NUYlZLMGND?=
 =?utf-8?B?MXlZZW94WExPb1VTcnVyQmpZNWV5RExzcGUyKzBxakd4Um1uUmtjc0tteGht?=
 =?utf-8?Q?e01WvXDXFrEVY?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MFFtWEcwcHhzc3I4NE1pNzRrQ2dNTXo1bWg3N01Ob2NLck1zcWNpQVNWWWNR?=
 =?utf-8?B?dUVzOEI3QlVDKzVaVXZBRnZsWnVTVHBJeDMvSlc2bVpHbzc0ZTIySjlpQkpG?=
 =?utf-8?B?WkFvZytlK1NhU25MZW9qbjVmS2xaWHBuUTNYWnpBdkI5M3ZoTWF3QUtNUU9O?=
 =?utf-8?B?L1lCS21SQUMwRTduZUNWM2o5QjZnd0RxQjl5VDZiNWQ3Z0pyTVJQVzQ4WkZv?=
 =?utf-8?B?K0dOc0hpUDYyendabzczbHNLVTlYRzE0RGltNzhjVEVVNkRqK0ZCbkhRRWwy?=
 =?utf-8?B?S0NXMWZuWFZyQkRrbWlJMEdNLzNPeWJoZlpOdmsrMWVZRGlIczAyQnQ3N3BC?=
 =?utf-8?B?MTRlWDI1ZkhEeHhabEwxSGpaWmxSU1ArbTdqVWllWDZLQ1p5N1M3aDVnMHU3?=
 =?utf-8?B?OGpzZGVrdG42UGxEaVlOMFJYSmYvRVpFaHNtMlllK29VQmxIOE9SY05PSDBS?=
 =?utf-8?B?RjlybklpOW9iN25yeW9SSFg5aWRKSE4vVCsvRTJqR1N3NUIvalF0YVpmdVZT?=
 =?utf-8?B?OTh2TWNTY1FoR2UyVVFCOWRuMlRuT3hGNWNtWm1SNjRKOENZenlzOXJNNjFi?=
 =?utf-8?B?T1RaajBZakdzeDVpSGxOa2pRUFdHN2VranlJaDZRWCt1TEpKT3ZkaUlGTnpi?=
 =?utf-8?B?eHByWkprU3ZVWGFMcHRMVFdXVVhwU2tkZDB2aC82dUcva2NhTDhnNXlCd0cx?=
 =?utf-8?B?Z2pYNEh5bnNNdDcybjVobEo0VGkvWXY0Q24xOWkyaldla1FqNmtBZlM0dTBo?=
 =?utf-8?B?dlNKb01lS3hJUTZFc0NDL1BWVlJGZkhuVHlNelEyREp4aE5QK09hMDRIeUFa?=
 =?utf-8?B?Y1ltVWFjZm9UeVVFZmdlY08yTTVTTkxuY1VyNDc0NGY3Y0UyQTdKc1NzdTlU?=
 =?utf-8?B?SEdYQklVRWRKOGxMK0RqODcyMG4vcng0ZDl1RHc3ay9oSzdxOGVCa3JQWFRS?=
 =?utf-8?B?Q3ZGdkdGbEcvQ3VlZ1FVZzlBQVVCNzZ4dXYwZGlDZ3ZKSDZTd1lzRzJKZERz?=
 =?utf-8?B?UTNsNEMvMFBtRzhuS29WK1lDaUs2VXdlY3Bac2dKRDlnbDRpODFDcnVJdCs4?=
 =?utf-8?B?UHRXRlV1SmlJVG52NjlJKzBmVzg1bVZBRmpFWWVYZFdFYU9PU2M5eU84Tk5M?=
 =?utf-8?B?Qk9BMytiRktObVFMVU1Bem4vRXkzb2Y3U25xVEh1ZEh1dytmeERiZ1pYeFhT?=
 =?utf-8?B?Y1h4TUFodzRBakRZRUxQOWh5TGc4ZlNodUhhbHhaVDlNckkxUG96eUpJdTRx?=
 =?utf-8?B?WGZiZFNlL1Fob0FLRnA3akdlRXd3YzlNbkRlNE9HM3NrSnZSeWxRcjMvaWpM?=
 =?utf-8?B?bkg3UC9tUmxqQVQrSm44K0NvcTlLeHozNjhhbFh2VjJPS1NYUFlaMHlTRVlB?=
 =?utf-8?B?NG5XYnpiVmNxZENUaWV4Y09KdXRxaXgvaklER1Y2aTQwMTJ1bkRjT2pkbndG?=
 =?utf-8?B?R2tYQVZOd0psSUR2YlBjMXdrOWRjV1hobVdTdCtOcThVcEtZSzg4NXo5ZVJH?=
 =?utf-8?B?YVJBZjFwRXdoSjRPVS9BRmJQQ2w5MmlHSHc5cFl5aHUyYlUrN0RCVmhXSFNX?=
 =?utf-8?B?dGl4cVdZMXNsLzRyZWE5R0dNUG1FbVhRamxtcS82aDVYUk1VTExsVm9rbURE?=
 =?utf-8?B?OUYrQ2twc3g3Q2x4UHA0ZVQrcThRT25WclY1Yys3amJaTjMwVFBNZ28wek5s?=
 =?utf-8?B?eUh1NHcrblpwcjREdklZR2FReWl2dGVPQmZ6UGJraEFnaTNCRHRXODdoNHhi?=
 =?utf-8?B?ZXo1a1hWTWFmdVdWV2dqWmQ5YWZLZVFNTzc0K3N4Q2NjSGZpaG5kdU9QZSth?=
 =?utf-8?B?N05CUHFrMWUyV1hGZzF0b1FsRFozUXpEeHhyeSt1UEZBanZSK2pCUHNLUTJs?=
 =?utf-8?B?c2JSWXJGRk9YajlLVHNBMkVTWTFnY3F1ajA5OFhIMVRCZ0FsakNCQzVhMzRI?=
 =?utf-8?B?aUN6MWMrNmJreGpmejBWU2poa0E3ZVZZV2prZkNOZE83ZjJOL3AzSGp2TjBk?=
 =?utf-8?B?UDFUNm9LTGdzUUFmMkNhdnVRK1RKOUFqQ2lCUGF0S1NsamxwYjEwNFNkeitz?=
 =?utf-8?B?MXhFdVVxUTJsQzVSSDBQeHJGeEVlbTZHK3dwZFZrd2x1Y3hIOUNoVHgvMDdW?=
 =?utf-8?Q?71gu5UsVuZr56nBtkxdiubr2e?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40be3fd8-4bb2-434a-db9c-08dd2f1a37f2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 12:53:01.2385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DkOcoWteFFpOPKzq18YOk9Ui+c7XFDnBrBQjUO52T9SIrSQ804pk3j2IPaZaNzi+SOQhPaYwpbRh3WiTfsIAMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5517
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Jan 2025 12:53:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17504

On 07.01.25 11:08, Quirin Gylstorff wrote:
> 
> 
> On 12/20/24 12:03, Jan Kiszka wrote:
>> On 20.12.24 11:38, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> Encrypting a existing system with a full partition will lead to a panic
>>> during resizing. To ensure the availability of the system continue
>>> booting
>>> if the flag `CRYPT_ENCRYPTION_OPTIONAL` is set to true.
>>>
>>
>> Is that not overloading the semantic of CRYPT_ENCRYPTION_OPTIONAL? IIRC,
>> it was introduced to handle devices that lack a TPM.
>>
>> What exactly is the scenario we want to handle now? Misconfigurations
>> during image build should not be papered over via
>> CRYPT_ENCRYPTION_OPTIONAL.
> 
> The scenario is that we introduce disk encryption via an update for a
> device in the field and the device has enough customer data on one of
> the partition that the disk encryption fails.

That insecure scenario that we don't want to promote via upstream?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

