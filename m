Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3586EE77197
	for <webhook@archiver.kernel.org>; Tue,  7 Jan 2025 10:08:37 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.64])
 by mx.groups.io with SMTP id smtpd.web10.17166.1736244510980566719
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Jan 2025 02:08:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Eqjtki5G;
 spf=pass (domain: siemens.com, ip: 40.107.22.64, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ibb2HG1ufFJESXt1W/Wi510Vrg3pDcEkcCKrg7A0IYZsF6Wh04/BUURMnCVreR+Jhwk6lROqqBZ0r9DYK0+E81WZOiDdy5ft79VxuobHclr1O47FlLQTTgCy9Yp88ycSIZtolsT9IdxcpJ1yXRXy3wSI+xSHkgkMCuUUJdfjdqNoge804CIPZ9zfnk3PA0UCHrCdWWXvFsIFnzcynvYyHwvw1MPJH7pEew7ku+vPvFyCFOpRHMbSzQOXv3XDd/RHUoKzWsxeK/oLgD/6+8QwGKrjJQUfUZPBhEI8cacsL39WhbBaZ6pECi4AC/0QcPTVpQvuowvpEIrrs4FE3G9ZHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Z0nDSJu3aopI1YN/Yf5TthEDqdz1ST1iTMxRWRVh3M=;
 b=oZXnPuFTvfyCnBRUnYN8QKx6RxiocLJoNjAbtiFbfz8o6e0YNKItq/9yXhdyXhYCrwsuBz6IFH8l1gMlE32azAkN1d7lO1F2C5SrHt6XhudJiQSDkjMw0kPOkYrRcWlLvaoQl2GZ3dQ7IEfejXoR6/UuaiZQkN9i45/LKmWxb9ZS9KtzhhIp5lDYm6QE/xvJh1Ts76H7IlxpvZvsS4ChHl854F7EK4PMrUSKjw8Uw9kwliHaoVPgb5MspI1gCHKKcrpOJTCxf61Nbz2Fx4uHZXup9ZIc1jdXlkNWuMJt5UFAOkrJ3jIRHENVOt0DViE3pfMfAm6w1ja4m2oG86sZFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Z0nDSJu3aopI1YN/Yf5TthEDqdz1ST1iTMxRWRVh3M=;
 b=Eqjtki5Gi9h3gzFqbR6prTCZ88z3KK5KYT4TvMr/D2brVE+8nMpzwSd1gnfNsXi9l2TIx6ZG936XbR3RdWgF2S0V2Tn6IMQD2ZYhCnyBUVCagnReH5pyn1RTMfo0WvCqINoKIoMUZEfAq8k3jIpF/XZTqSOVtHVYKvf3s/bhAiUNNOpZYrzdmzLC4Jxy8NbHa0Oo27zYDgXlGPT4hMYARzYsrLiu6/WRUwk4watfuA4YIBv1tK4+FV6CpwtG/pTZNvDRibk933lwNAPfH1NbJKrDqfzDzMuSz1j65f3QUXI3tdWbhfSAm3dbPG1UVkYsNmG1fzYAeYtCOGwTOIMzrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a5::7)
 by DU0PR10MB6409.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:40b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Tue, 7 Jan
 2025 10:08:27 +0000
Received: from PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67be:42ba:72cc:5a8c]) by PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67be:42ba:72cc:5a8c%5]) with mapi id 15.20.8335.007; Tue, 7 Jan 2025
 10:08:27 +0000
Message-ID: <1e879d48-ed2b-4138-bb12-7a07c0379ca5@siemens.com>
Date: Tue, 7 Jan 2025 11:08:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC] continue boot if not enough disk
 space for encryption is available.
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20241220103918.1165341-1-Quirin.Gylstorff@siemens.com>
 <5e4cc176-e945-4cb9-a3b1-bf2e4320a4db@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <5e4cc176-e945-4cb9-a3b1-bf2e4320a4db@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::6) To PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:a5::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3PR10MB4096:EE_|DU0PR10MB6409:EE_
X-MS-Office365-Filtering-Correlation-Id: 3388553e-de4d-4bb5-4616-08dd2f033abd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?S2dsK1lnaWdOZ3lhVTNTendZWVZXUktLcTFGNXhNMjhjWFNUeTU3OVJkS2Zw?=
 =?utf-8?B?aHRjUXBRR004T3l5Uk9kV09iSUI4RmFabUE0bFdQYXZWNThmRGpqSUF3d3dJ?=
 =?utf-8?B?MFNwRnBOSmJBbVVnZ3JxV3NqWFpWS3N5T1RxSzdTL2pVVXpDclEzSzNnL2xD?=
 =?utf-8?B?NlNETGZFMVRoSkl3OEp0bjNZOHJnY3FCaXpsVnJFbWZLOHUvelBMbUJTa1BG?=
 =?utf-8?B?YlNPWjVlRlFzeGRRUnNJR1RDYkFyVTBRNDUxWEV6N0tnN3N5V0ZNenBsM3lK?=
 =?utf-8?B?NWJpSmpIaVd3Mjk4SVRsWURvR0llc2xYOHMvQi82NWxsY0xneWh6Zi95WjJh?=
 =?utf-8?B?R3FxdXoycnFDZDYrOHJHazhicm1maW1vcWJFMk9MOTh1ZzQzZ1FIUXJORVBj?=
 =?utf-8?B?NzBnSkxnUFRhK210dlk3WWF4dENvOXNzLzI2Wlo0UHNjUkZMRHNadlZLRDRN?=
 =?utf-8?B?alJlSHc5NnJKQXZqbDNwdGVnQytvS2x4UkMrVXBWakRCcU5zMTVVSUN6dFN2?=
 =?utf-8?B?ZHYzU1BNSHNkcWRqN1N0MThDdENNMm4wS1krS3IzM1hodnZmMVUxVVBZR0Iw?=
 =?utf-8?B?VWxGd0VmeXlYMG1EbjBZTjlSWlY0Z0ZVOXBRVVNhNTVqRmQvM0pwTnBId1ha?=
 =?utf-8?B?Z0hyaWwzaFgrOUc1dC9OUnZkZXFhdnYyVWRKZjZUVjRRZ3orOG15NWpQYnIy?=
 =?utf-8?B?UzhHZHNjeDllb2RpOHJoOWdFV3hzem5PMXhHcTRUZk1pZTNtemJSRU92T3J2?=
 =?utf-8?B?ZWk3SDl6ZUJYRFVjbFQ1TnhodGs4cmZFTm1CQm9CbXRtOXd4RVNpWUpRbGky?=
 =?utf-8?B?NURxOTNKN2hwelBwdEM1cGZOb1Npb1hWbFg2bEhPbzEvWGNHQ3ZrUjlIN2Rx?=
 =?utf-8?B?eHU1ZjRXb3dNcXIreDJlcmtLNWp3N3c2dVdjZUdpelIxaEI5TDVSRGphMU1W?=
 =?utf-8?B?eEI4a3JlK3dOY1ltQkk3bWJta3BPMG95Q1M4MUZ2MzhxS1Q4dnY2WTZZaFhE?=
 =?utf-8?B?eDBHNVNleGN4NXcxUFl2K2s2SGJkZitNRys0TmtkcElnRUJRMDl3SzZsY1k4?=
 =?utf-8?B?R09ETlRCVWdaZnpvTmw0d1czT2FNQXE4S0RnbjFVTm1rOWtHTzdoQW5ObE5H?=
 =?utf-8?B?MHRJeUtDVENlZWdYYjVOUnJPSlAyVTJvNDZGWVJRcmhLdEtLdk9BbGp0K2xV?=
 =?utf-8?B?NWNvY0svblVGSDljWGlVTHY0UTlJNWxPcjBBUmNCaWg3NVZZV3JJYWdVeTla?=
 =?utf-8?B?OGNaNEVGaXlTeG11NWFQUVFXU3N4YjZsTk5mQms3azBseFlMSEpYNHRub2dJ?=
 =?utf-8?B?aUhlVkRUMU5JejFrODRrUG5tVGx0RFd5cnJTUDIyVC9QTWlvL3MyUk42a1Fu?=
 =?utf-8?B?ZTlGa2p2OUJJVndWZGlqMUMwMHh0YnVRczlaaTRaV2VvVCtGMk95ZjdXWms0?=
 =?utf-8?B?Z1JCaklaMTNQYTIybXg4MU1zR29ndnBSZWxSa1RRWTlnSVVXWTlrWmE3eVlZ?=
 =?utf-8?B?eXlobUdXRThDeURLd1Z5YVNqL0VqT25rTk5ZSU5wQkNBNjNKTlZ0bmViYWcv?=
 =?utf-8?B?dkJFQVV6b09XdXIza3h2NmhNcWppOUFPbEZzODZ6bVZEcFNhb3ZBbG1VNm9N?=
 =?utf-8?B?enBReFBBM05LUG5QQjY0ZlJYWDdsOWMxcXFRM0VBQ2VqUEducWUyVVZEa1o1?=
 =?utf-8?B?YWhKYTNoOG1tOWJGQWxRTVQrSEFweDBKSUlrMTZZaEpSQWxGd3FBd2kwZFZy?=
 =?utf-8?B?Q0hyb1hSUGYzWHFUVW1RTUh0d2E3bkJhYXAvanh6eEE5N2t1eUd6enpEVm8r?=
 =?utf-8?B?L0JZeTNRVE5CN1lTZkVoQjE0WTNkZGpVRGs2Q3BZbFZZWTFmdXArbDVSc2pp?=
 =?utf-8?Q?Ukmi/ZxYxyXLP?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q3dMSjlUZWxxUFg0MmNKZTZlRFBVMXAvdWdZR29KWXNDTHlLblNEMnRuTmxT?=
 =?utf-8?B?MWRjV1dJNU9LSmFoVjVtYXQzUlFWUlYwOTI1WnlVYnZSTUdLNGlkTzVVN21I?=
 =?utf-8?B?TDl4MmlLeWxXSjFndWt3Q1lZeXFST0YvYXZnZjUzS2pVOWlyQThQa2piYno5?=
 =?utf-8?B?dGovSkprOFh1Y2JkZDdIQWxhUlE1QVVsVFVFaklIZVQwREhjNStQT0NDbHBC?=
 =?utf-8?B?cGJsRHZpQklNajV2djVOOEFKSW5FU3V2eEx5SUxXejR2ZlAvTG9iMGR5K2VS?=
 =?utf-8?B?a3U4OXlDVm5DbElLb2QxQ3JpbDg3TUtObEhjeSs1UHZPaldjcUJqbDlGQzlq?=
 =?utf-8?B?WTZHTVR4aTk2dFlTdWdaZU5GL0tOL0U4cXF4UUZNQzFpT0h2U1piOW1Vb0xT?=
 =?utf-8?B?dDh2M2pjOHRLTEdKV2pSTVU4MlFnVzNyWG1hZi9MVmM5N2ZpSXZCT2kyL3Nt?=
 =?utf-8?B?d016Z0dUSGJLeFE0aDl4ZHhuNGl6QlgzQ0NFcXZrdTQ0TDR5ZVlpdDJpSWRx?=
 =?utf-8?B?bTN2eUF5dHptNXpPZ1Q0czZ6ZDROc0t5NThHem1tZlVUNkh4Q1pwTDZobGZC?=
 =?utf-8?B?R2t6b2Q3aTd5SUdZaGhsM3k5UVdrVnFxMmQ2QXhTbjhwZWwzZTU3eTk4VXJM?=
 =?utf-8?B?b1QxTjArODUzS1JPVzZ1ZjRSYWVNNy9WMnpmVU1MWHRJcm5jc2t0Z1pDL0lU?=
 =?utf-8?B?Yk9aL1RtTEpMblFHMDZTSXp1aHdmYjhDWkJrdDJGSzk4NnFoeEdES21jVFd4?=
 =?utf-8?B?aHV3Y3pPRmkrQjMxejEyV255bW41UTFWVGd4aWRpbzhub2I3REJwamNVRVVp?=
 =?utf-8?B?WVV4Ymltdm9PcjBIdVBGZEJ2Q3BiWmUwZ0VINWJlY29rZnJxSE5GZWNSNkFk?=
 =?utf-8?B?bHFoVXhWZGxnekhLbGJLYWVVRmJWNGtWL0grOXZuZTNxT0wvZlBzMUxqL1Qr?=
 =?utf-8?B?QldsM0NOV3pWRG1KSzkzRVdZcFVieG1xQWNydlVWT3dSdXhZYjJjRXBwOHN2?=
 =?utf-8?B?MytId1BGczBFYWgzcTl5VVowTjhTS3pHVVdjbGpRZTRvQ2hqV3V5Z3lFMnNN?=
 =?utf-8?B?TEJlWlF1N1hSTXRqRXFrMEF5TFkza1dQUDNaY3RwNFJsZC84emNrazI4RWFM?=
 =?utf-8?B?NUQwQkdsZ0pTQzdnOCtvMHlhekFyYnhQeUdBcGxTSW1zNDZHQkhQd1M4NE1Z?=
 =?utf-8?B?LzNQSll4aEVQZHQrT3NuTlZHOGJsOVRnemtFMThlMGE1am1Gcm5BVSt3SlJt?=
 =?utf-8?B?enFrOUc5aCtTVmJiZWVOUnZYbUpoVGgvdlNDKzlCcXNJMGJ4eXFjYSs5ZEZC?=
 =?utf-8?B?Z09mUGpiQk1BS1UxK3oxVkFIMzNNRzR6UldJcTFqeC9jSThwNFZzMGE3aklK?=
 =?utf-8?B?UzNDK05udnErRlBOZDNtYVovaC9TNXV6NVBuMENoTmljTUlMZnBGcWRTSS9P?=
 =?utf-8?B?akkreFpVSk45ZXhkR1hvK1drVHJrWE84Qlc4R0xuQnVNcDhIT0pHMjllK3k4?=
 =?utf-8?B?NEVobThmYzIzWGVJZVBxV3pTcjJ5TGc5anIxOGkweWt6SHczeDVGenNMN044?=
 =?utf-8?B?VHZJUFRXK0xIamxlbjBQdlRjazVCbWNRVmlNOWxjWXYxV214ZkNUOVkzZUY5?=
 =?utf-8?B?SmhSNmQ5OW83bWJBWDR6TG1BaDBtbmhEd05yQnpBZWZDUHdNcHhEeitCQlJI?=
 =?utf-8?B?SVlGcXpLOHRMeVRZMVVLc0ZXRUtwYnJJckVGeUdmcHhMbkt3Yy94ejduZTRH?=
 =?utf-8?B?Sld6TUNqQmZiNGJacWRSZi9oTDhXZEp1VWtLVzBhZmtReVo3amxJU1B5a29I?=
 =?utf-8?B?bGlVZ2JvaGhhZUM4SjBoMTZSeWtkQTY0bXVmZTNaZml5aStWeHl5TFB6bHZK?=
 =?utf-8?B?cmFMWnF0d0t2SUFKb1dzSVpvREdhdm0wMnRXa0hQS0hncGJKSXgyWmRxSDJ5?=
 =?utf-8?B?bmVNTnpXOHFoMTVFaTk1N1c1N0RrT0NjcTBoRW5mei9XM0dqMEpDRkMvTlNR?=
 =?utf-8?B?eVRhZTZhWHBLMk0ycXUwM1U0U0liTUVmMjI5R3pPZjJJV2d5N2ZTU2pRZFhJ?=
 =?utf-8?B?WDJKdE9GZE90R1Y2Ukcyb0hId0NyUlJleVFSUUlnNlRrUEo1ejAycCs3ODZl?=
 =?utf-8?B?dzJra3gzZ0dXQ2tzZFlVdGJtalkyelhLajdFYlllNThJZ0RkQ2ZuR2wvV21P?=
 =?utf-8?B?cFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3388553e-de4d-4bb5-4616-08dd2f033abd
X-MS-Exchange-CrossTenant-AuthSource: PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 10:08:27.5467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PinVxwr2+kcXptA/vNT+Yyjme+A2GRNdAlHz+ItnTzP2JcEsIo0J7qCG0emIO7wRkfXw57pLFJLG2x43HXrhyqmdh+dZ+9GTuWJQ7zJhM5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6409
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Jan 2025 10:08:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17503



On 12/20/24 12:03, Jan Kiszka wrote:
> On 20.12.24 11:38, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Encrypting a existing system with a full partition will lead to a panic
>> during resizing. To ensure the availability of the system continue booting
>> if the flag `CRYPT_ENCRYPTION_OPTIONAL` is set to true.
>>
> 
> Is that not overloading the semantic of CRYPT_ENCRYPTION_OPTIONAL? IIRC,
> it was introduced to handle devices that lack a TPM.
> 
> What exactly is the scenario we want to handle now? Misconfigurations
> during image build should not be papered over via CRYPT_ENCRYPTION_OPTIONAL.

The scenario is that we introduce disk encryption via an update for a 
device in the field and the device has enough customer data on one of 
the partition that the disk encryption fails.

Quirin


> 
> Jan
> 
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   .../initramfs-crypt-hook/files/local-top-complete     | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> index 834dea2..f86cade 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> @@ -79,7 +79,11 @@ reencrypt_existing_partition() {
>>   EOF
>>   		e2fsck -p -f "$1"
>>   		if ! resize2fs "$1" "${reduced_size_in_kb}"; then
>> -			panic "reencryption of filesystem $1 cannot continue!"
>> +			if [ "$tpm_encryption_optional" = "true" ]; then
>> +				return 1
>> +			else
>> +				panic "reencryption of filesystem $1 cannot continue!"
>> +			fi
>>   		fi
>>   		;;
>>   	squashfs|swap|erofs|"")
>> @@ -94,6 +98,7 @@ EOF
>>   	else
>>   		/usr/sbin/cryptsetup reencrypt --encrypt --reduce-device-size "$reduce_device_size"k "$1" < "$2"
>>   	fi
>> +	return 0
>>   }
>>   
>>   expand_partition() {
>> @@ -236,7 +241,9 @@ for partition_set in $partition_sets; do
>>   	case "${partition_format}" in
>>   		"reencrypt")
>>   			log_begin_msg "Encryption of ${part_device}"
>> -			reencrypt_existing_partition "$part_device" "$tmp_key"
>> +			if ! reencrypt_existing_partition "$part_device" "$tmp_key"; then
>> +				continue
>> +			fi
>>   			enroll_tpm2_token "$part_device" "$tmp_key" "$tpm_device" "$tpm_key_algorithm" "$pcr_bank_hash_type"
>>   			open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
>>   			log_end_msg
> 


