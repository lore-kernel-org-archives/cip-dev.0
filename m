Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B8DC88E5C
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 09:03:40 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.11])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10566.1789549416589083256
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Sep 2026 02:03:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=a8KWP3Jt;
 spf=pass (domain: siemens.com, ip: 52.101.72.11, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJkh7vCmH8QKYb0r1KumMmmoqnnwqITUyIy7HQV9QwGzCuWqDwqJcAeb4TNHYA0XYpBbfiRpu/eAtXCUKs5T/vcsVM1tc61orzHnrM4EIOb25b5oxlA2oF+b3jeq1A2JINsizQYnvwFT3StytA4gHd5a0tTmFTrIL9bJiapLLFMGU0pLB07CKNhrw29RNpsHcZG+3nfYxEEc3nN/RjQb4PFy7Vb+3kjWMJJ2+uzc3xS6PVrMoiYJ2qq20HQqMczAneCqzk2JxbyJCi7hGE/lUvkFiD8pdyNbB36a+K7TZyhxrLv6J5nWPvUM0YnmJSzRw33UR3yl5xMl9zKhi0LHpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/o2GPPOZq9vROUofedpMFloc+PKTLijExIPKRfN5ow=;
 b=Q4bxwadrzWuCSd4rsOqHs9cJ/g5DUvSQ+5C1rowKwnckjVV0f5mlsMdiy7pPS3v1DWfRnv/lSxAIlZAHizE0RThtwAKozooFSPNcHNbGYZf2HN4CLaQMMqRTdvqDFh/15kj2zt6G2PQVulw4ZLyxBe6lefL50VTn+KCYEg8lY4xfLquFWbLF3VVe3hr2Y3gAzu7oA4f2YqKOFdPYsuvn6SGM6ed7797ze0rEqTJ9GMmya9ZieiNtETuqWmSfYIv4aHQh2biUrJSySXbo3bRW9mmmjXucAsknFp+nUbjTdHGmwvMSAj7lPzb/D7hwBVWGWjB5jL/+R1wqzAy9jzTLjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/o2GPPOZq9vROUofedpMFloc+PKTLijExIPKRfN5ow=;
 b=a8KWP3JtsvXy33xzX/CcHZVoyBOoiSFgpGHEeil4odbLKL5mrPJ/4Lf8aCyYXf0PWotHa0kKwzlKXHYhlQ7/5FtpEXrT5vBZh0UpuKAOi9nzo81Z6R22h4VFgSK9Z8dg302K2KW7zXsmOZ/uUlcQVImecM3JoVzk2L1xzWgLppf0SgGYLCXbsWXxsqdlMGne4v/ZXYJopDR4uie386DGjtv5OwYTHAtYLGSb5u1krzjaVKucp5+XoholQyxnD6CMYeVan37dOl6co+CELQ1QeZ1MNzGd/+Nse7bU7FMNcXtZAtXqCqnYBC+Jbuve92QpPv8IL7JkY83m2liRhEfwqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AS1PR10MB5216.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 09:03:30 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0428.009; Wed, 16 Sep 2026
 09:03:30 +0000
Message-ID: <70f50807-5083-4c8b-b77b-e715a205ad24@siemens.com>
Date: Wed, 16 Sep 2026 11:03:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 07/12] Add class for validating
 the CIS options in the kernel config
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 felix.moessbauer@siemens.com, clara.kowalsky@siemens.com,
 christoph.steiger@siemens.com, dinesh.kumar@toshiba-tsip.com
References: <20260824094721.2636375-1-quirin.gylstorff@siemens.com>
 <20260824094721.2636375-8-quirin.gylstorff@siemens.com>
 <5cbd3567-d84b-4a87-a029-b6bfc0ac2b43@siemens.com>
 <e6e65f01-2a78-4a7f-b329-4a35e53af1fa@siemens.com>
 <ae35acaf-61c6-47a7-9c7c-1eef062d5880@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <ae35acaf-61c6-47a7-9c7c-1eef062d5880@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::9) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AS1PR10MB5216:EE_
X-MS-Office365-Filtering-Correlation-Id: cf682633-0ded-49c6-d484-08df13d160c5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|6133799003|10067099003|4143699003|56012099006|11063799006|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	2U93q0tk+jFDQ+TXopja21HlSxfRq8XiCxTZb2BcS/9Up6Zuucxd4Qd/3bp/f3RzfARt0REYScj8rJDpxmh9wMtFuHprrq1pjOFwaZQVF0HjryZ+V2WjTfrZNKAVHKsSRul3ihGvPnrVz8swjuAbZkLVby3UttSv/P9molPmQF+6WRNyO9nrBXp8V1mGQ91yekn2VCrNtQJcUx7ji2b04s5iiFBvXCf7N9Q599e24TosyrgXxX5Bykyq+i4RfMpTtcDL5HPICZwOaeew1ScpXtYYBJRW/UhlmYzgTIoT0xVFErS0EGV7lG7/uDFrs3uh0Latftjg5AKgRuW/DxKRjOzGIC5UdeWIfmJgjdbgqUgWuvp4RwFIr7CZb/m35H2yP94sVz9Co9N0WHfNjEnf/wCjrsKlTS1qlx1rcHYAdxk5X2n37t6nvvKeEykzMUX1SBfr3dKKZo5K0v/ikrblv8XcXP1WHwEtVA8Nc+LwcUkEx5L2f/lxAa3KD6oOzyZFqdylBJ+494PSb78VZw+P1i0QvWlp39sgYxkrlbWMNVN2Af3xcAJDWkag/lwVvBr/sf4aQXIVhfvwIidu6jnbrGSf/G2pBY8ND0vgKKmgIIFVaSQI43N5s77+XeAGBCrWucYaUxsKUg0vvo7B7s47zqPSCmCSruGqWAevzD3m1ns=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MWZaaXdoV2htM1dzSVdXVjQ5TkljbzJEYWlKdHBPQS93L0ZWKzk0OTRlbkd1?=
 =?utf-8?B?d1VDRUFOV1ZsOTR2UlZjSDVCWnBEb3dJT1hpVm0rVnVTQXhJMTRzZXE0L25R?=
 =?utf-8?B?ZU1MbVBIV0VTdENrLy9PYmpnZ0x3OXdZZ3duNEE3bW9wTzcxZVNHZDF0R3V4?=
 =?utf-8?B?aHpncHNlSXV2aW5FL0dwd3p3VzR3UTBxaW9rNUxjelpnUlRnQkp5dzRWVFFj?=
 =?utf-8?B?cEh0TnFsQ0hTdERVM1ROWkE4U2E4cTNDV1E5ZlY1QjdIU3FkSFpOcENCanBN?=
 =?utf-8?B?YjI5TGw3YzZLbFhwOVBydTRtMTNZNEgzY1BsZmcwYXZJVWFVTVAyZnVGQWVv?=
 =?utf-8?B?aTZYcFFNZFJ6dCtaMUxRYmVYZGJHWU5USnZsMDU3L1FTc2QzR09iK0xDNU5o?=
 =?utf-8?B?bU1ObTFpVHM0bVVYSURPSUxhd3JxYTJUeDR6L0tIRzNQa2tIWlVyTzVXcm1P?=
 =?utf-8?B?b1VidlpNQ1NlZitsT0FmOTRJRWR6Q2lLR056enE3Z2d5NWV0Q3lFemFOZWhM?=
 =?utf-8?B?Zmo1SUxHRXh2cWZycDJoLytuQzZCalY1V3NtdlZVeXRubzdrYWlMSVo4QThB?=
 =?utf-8?B?WjhKWFJVdGhBeGEvbHorR2EySGRrdFNjNDdFajlyQ3hjbFcrTXYvS01hMHp6?=
 =?utf-8?B?Yng4L1hnVkFtdVQ4ellHdzlOR2ZkWkJ0bkVScG9hdTF0cEJmUzcxRTJldFc3?=
 =?utf-8?B?b2cxYUl5QlNsRlRDMU91c3dnWGRsWWJHTVNYUnlUejEweHI4ZUpRcWxaZzIr?=
 =?utf-8?B?YnQ2NVdQcXc2TU1waVV5dUI2OEhxWUJadUFoT3BvYzhURHVneDFxbTVOQXMz?=
 =?utf-8?B?UWRUc3FUazhHOEVPaTNCcmhaUzNqTE9KWXN2NlFzeTRKa3BLa0Q2M3VQSHJ6?=
 =?utf-8?B?MG1Sdm1QZ3BCNlpOQWpRZ3pERThJaS9VZTlYbzVxMjlGYzRoQ2E1VVdqc0N5?=
 =?utf-8?B?RXdDMEVFM3JQMkFpNHp3TEFHRTEvcDVYT3FZQWNYdHZ0cmFkSTN2U1g2YnlM?=
 =?utf-8?B?cU5sNXMvN2toZWV3MGdpSi9hUUhRS0sxR2NBaStrNm50aFdVUGZjOUdHRWdr?=
 =?utf-8?B?cmk1NzNub2hQaFZvSkFnbDNBekpGY3QzTitSTUhSQmpzcmVpbnVyOXUxMWZu?=
 =?utf-8?B?SWpLakNPcjJSSVhDOU9WUzJmUjRSMkM1Umc4S01mN01kOXpiM3h3ZFk0RXhz?=
 =?utf-8?B?Ri95VkdBRmdZeTBxejV4RU9ncEJEY0N3aG9aQXdVU1ZFWTUvaG40czY5dnJV?=
 =?utf-8?B?VE85TmN2MlowNzlEcUdBNkp2dS8xdWdScDJpUWhFYzZESWNMV2ZWKzBTa21R?=
 =?utf-8?B?RjJ6OVNmVGdOZ3dsMnVSRTZ1a0N3dkV6S2J1SmYrWTR6Rm4yZkoyQTIvQnpW?=
 =?utf-8?B?b2QxL2laRVJwZW1vcER3a1dwTjhiMGtNTlRxUGk3OWt0ODFiTVp4QW9MOTE5?=
 =?utf-8?B?bjF0VHRiV1R1WlNIbzgzcnNNNVZEQzBWcHRjK1lMMEZxM0QweWZOU1VENlBQ?=
 =?utf-8?B?OWcvK0tyVm1CY0RFUTRLaURGc1E4SldpVTBGN0hpNnk4L1lsTTdrUkl5WmZh?=
 =?utf-8?B?UTZIQU5ZN1RiTSs5enp2dXNjUG1QOEtaSytkQWlXRjEySHl2NnZFTDQyTGJx?=
 =?utf-8?B?eEI4MEw1VUc3dDQ0VVJLd2w4QmlsQm5sWTMrU1ZRSGtRZE9SZGR2aGZJWnZj?=
 =?utf-8?B?aFVoaEFSeENBd2IzckZjQ1lZdkpPOTRXQVJsMDMrWXJlUFpObWNCRk9oUDF0?=
 =?utf-8?B?a0l5d3pXcnl0Vy9Zak1DVTdYTFVZRFZOUHJLTnk1ZkVoT3RYSlg2Q29CUDVz?=
 =?utf-8?B?Wmc0ZGlTZ1NYaU9EV0JKeWdQVXh3eURqUjNiOENKSTV2clY0QStsNTYvSkwy?=
 =?utf-8?B?dlRUWGQzODFJdDhIVTJwK1F5RGlRcWEwelhSeGJId2Joa3ZRYlFHSURiNDJa?=
 =?utf-8?B?aHJzYkorVWdwNlhET0hVUC95NzFndEZmRUhoYVhLYXJSNHEwaFlVQjltd2lk?=
 =?utf-8?B?Ui9RMi9yOUxZOGVUM1owWEQ0MjEzemlGdEdzTFVuSmZ0dEVGUURFT3lnUjdN?=
 =?utf-8?B?eFIzaXVlVmtQMTRRVE5Ydmk0cDBNUEdvMjJ3WnFiU0wxSlBCYkp2UU5ZdW5M?=
 =?utf-8?B?OFhWemRuU291RGNubENtanJaUEJ5MVBEQjFZOVFiMmh0TmtCTUEzaTM4OU9V?=
 =?utf-8?B?UGI3OGw1Y1VMbm9HOFh4RFYrVDJWMTFaUXBRMFMyN3ZJczBSbWZZcHI1YW5R?=
 =?utf-8?B?b3ljbzNET0s1OTQ1MGdUUnp0QnJGWUJtMk1PaVRUaTZuMlo4N3FvcDVqMzVC?=
 =?utf-8?B?MU5pMWZpY2dUcmlxeVpuSHgrVVRRdVBvVG5JQ3d4K0RFZW40V0lPSUpXQUZU?=
 =?utf-8?Q?jC6GBrUYbMY+vLYY=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf682633-0ded-49c6-d484-08df13d160c5
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 09:03:30.8178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ht0uXBgrsoCEYZEJtq6XU/0Btja6oOxxNjXh8oOUg84urf1jdv9WE6cmxFuq2GuBzGfPvDiBnPPrQsCDoSfoVbxVgdGSfMotEH/V13vA/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5216
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Sep 2026 09:03:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24193



On 9/14/26 5:53 PM, Jan Kiszka wrote:
> On 14.09.26 17:46, Quirin Gylstorff wrote:
>>
>>
>> On 8/25/26 7:00 PM, Jan Kiszka wrote:
>>> On 24.08.26 11:46, Quirin Gylstorff wrote:
>>>> If CIS hardening options have been configured that change the
>>>> kernel configuration, this class checks whether the correct options
>>>> are selected in the resulting kernel configuration in ROOTFSDIR.
>>>
>>> I think I already pointed out that checking for some random file in the
>>> rootfs is NOT reliable, specifically when there is no config deployed.
>>> Please check the config that was used to build the kernel, possibly
>>> leaving "signature" if the check passed which can then also be
>>> runtime-validated (if that is really needed).
>> Currently the isar kernel build and Debian build all deploy the kernel
>> configuration into /boot.
>>
>> We can add for example the shasum of the kernel configuration to image.
> 
> No, it's not about that. It is about doing the check in the kernel
> build, offline, and then passing a confirmation of a passed check down
> the pipe.

Ah understand, in that case we already generate a report of the kernel 
validation. We can include it in the image and check to report result 
during runtime.

Quirin
> 
> Jan
> 
>> The question would be where to store them as the should not be in the
>> rootfs if for example a kernel only update should be possible.
>>
>> Quirin
>>
>>>
>>> Jan
>>>
>>
> 


