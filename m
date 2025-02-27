Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324D4C19F32
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 14:37:50 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.65.57])
 by mx.groups.io with SMTP id smtpd.web11.11830.1740667067472777208
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 06:37:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Q47La1AI;
 spf=pass (domain: siemens.com, ip: 52.101.65.57, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kW6+o1QMR3l29juSMETLjUyvhdDZz6qq09mRgUd+6idKYV/oPOHM+XYg81C+wpdMmfhm11iQ1LsR/fUX7aftFduk/pc1ew+cNYbpLlC7cjZxo69U3YmVF3Oox5VnhnlEN5wGfoVwr31QWeG8C+y5cw4/dcMzCA5BuLGfeuhjDi3uLzmPyy5uPlZDw6QFIELqlGtAkIpUDHDEsjZPKCOw3RCCOPLOLGEhcVCVbhhXKnhTIuZ4hwkIp4yDuVdt0ivjY9Iw9dO1no6uxxWS7Ympq8pLqAtdUplmJtn24NpcA9OnT3WWdhE08ovYNpnIrfchtICFw2ETr4XnnCX1Nu2cwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cgreb57dUB68QPfVpGvXgEBMkTvwdAv594oSiq1vLZw=;
 b=UidUBBuU+nraxs8Z8kSDQL3y1LN/UhSQfO7C1FoDXHVtytUQwsVWstTFAQSPezenf19wicrLnbdj5vdKQGS2b7B3WK7cgHy3H6Z9vpHZpWkhCELYQ1fUpo/Y+XdntdrcX7iWkwyaI8YeVPugMXMzCAip16S4JGtlrUCZbVtlskly7xhhqalxTxClyzVp84xioZ9gup8dNP1j9JWDsR20NYCCW4+teiM3ypRazoKRjEkpwkhHJew723wk53LjC9CbfXwmKxHebY3bTvq5GznGO85f5kEIJCdp9iwKjnQAMvNkRzZFNYY/S9jOeEZbDqHgQUQH4Y37GOSdAkaGDnGQJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cgreb57dUB68QPfVpGvXgEBMkTvwdAv594oSiq1vLZw=;
 b=Q47La1AIxI0MoBugV+0iVzcGIPNwi5p37q2aiQTpxM/xGyateJGDNJ6QftwqNLNw+ahEXMbBC47qK/bQTrIuaTYky1PkAIRMBMlKMxc9l0GKK06GJAUwPkpe4q0ILWWC64BelDXxAeE7NT8b46z0Yo0k26YYhTrB5D4siVEidsZ9p8JyNFFdrK8Y/Di7fWlAfvd0wVxMnmW9pTpphrW5pIs2Tcl5pBLw+IyhbVTtxaFCUaBQjSYCuQxDUHXDdStCkExa1KWgaiyqtoXJrQlKOLyQA9wT9nyk1+65J8V9NRTbMa2n9QEr0FEcmkBrEoModT4kukNetaAz1DwItMHR9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by GV1PR10MB5867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:56::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 14:37:43 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 14:37:43 +0000
Message-ID: <8f3bbc52-69e3-4187-a229-8d9356b22fd0@siemens.com>
Date: Thu, 27 Feb 2025 15:37:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] initramfs-crypt-hook: add re-encryption recovery
To: Claudius Heine <ch@denx.de>, cip-dev@lists.cip-project.org,
 Jan Kiszka <jan.kiszka@siemens.com>
References: <20250227143022.323950-1-ch@denx.de>
 <20250227143022.323950-5-ch@denx.de>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <20250227143022.323950-5-ch@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0061.namprd03.prod.outlook.com
 (2603:10b6:610:cc::6) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|GV1PR10MB5867:EE_
X-MS-Office365-Filtering-Correlation-Id: 40f756ec-74c9-48ff-28da-08dd573c4bb2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QWtmb0RDbmNpV0NRWnEycnhoSEdoRHRIc3lOUGxIYzlaRXZYd0l1S1l4ZVow?=
 =?utf-8?B?TWIxY2d2Vms1dXVqU0tQL0MyTnJ6amt1bGE2UGVPekN0c09aVU93eGZ3enVK?=
 =?utf-8?B?NDlGdnZIWGIwWW0rVXRWR0NXUnpnUUxQK2s3L3RPV2ZkL2oza1FBMkUzQ3ZJ?=
 =?utf-8?B?K2tNTnBycUpMLzNRYlZQeHNObEVuUXVDNmxBNkVudjk3eTdRWTB5TjVQaGdt?=
 =?utf-8?B?WjBXQnhJaWtoVVNQVGdKaGFkWHBYcXk2cjA0U2VSYjQ3aWV5ZHRvd2lOUUMv?=
 =?utf-8?B?KzNDWGI5K2NBdk52bTMwVXNPRFdPdWpVTHpIam4yVGx6WE5NV0tWTkRMZUNp?=
 =?utf-8?B?a1B1SDdIMmZsMEMxSXBhVVBJMEd6YWcwSjJhVkVMK0ZoZys2cDNCNDBQZWdv?=
 =?utf-8?B?a0pyeU9pbFVZQjZGYUYwOW5xTDZTQVlyMHR0bHdOSkpXVEVNbHVXa044MHZN?=
 =?utf-8?B?SFg0eXZGY0VHV0dudXRCNFRxWGJaRks0OExiaG5CdituYW4vQnBlMmRUTkRB?=
 =?utf-8?B?NS9yZDcrb2IwRXdmUW1VVTJlblpuei9vdURRUUQ1ZkxJeXZNd1NGMWFBMndC?=
 =?utf-8?B?SngvdlYrWWJFR2pBZ2NhenljcDlwUDNlajY4YUhYaUdpY2NEOE5Ic3BLMW5O?=
 =?utf-8?B?aTlOUTVZOS93Y2xnaUdvSERYOHpYVWFSSDJKbTQ0TlFJaXN1ejgrb2FaK3JG?=
 =?utf-8?B?bUdqempXTk5oQm8yajRBeFNEaTRVQjVVRzFscVRQYkJoUW4veXlhMXQwRzZ6?=
 =?utf-8?B?bENPam1JNHIyVk4vS05sTHhhOHhqUiszQU1Gd2JZS3NBZEVwQm4xTFNjN2N4?=
 =?utf-8?B?aVBocCtLSDcvTmlWOVk3b1BCUkxjUUlWeEVYaUk5cks1Ni9ZamNBYXB5bUEy?=
 =?utf-8?B?Rkt6bU1PTlVja250OSs0L1kzRU9kWUc5OVhZZXVGOG42LzN2Ty9OSFArazZC?=
 =?utf-8?B?ei83YXdBbUxobUZwM2xnaFRTL2pTS3ZpV0kxa3ltS28vY1YydXBZaENvTVps?=
 =?utf-8?B?T0xVZUJGc3h1N3loZGJvWSs1NHF1NStNQmdYblFDUnQrTXY3SXU4OURxdGRH?=
 =?utf-8?B?SVhBaVZ5KzVveVMxR0diM0w0MWZDUXU5dkk0VHZUd2VnY3o3YUlvakdadjd2?=
 =?utf-8?B?QURhT1dvTWgzcVIwNVJRUGdWZW9qQVB2SG9ZTEJBcjVzR1pjNTNpY2tna2gv?=
 =?utf-8?B?eG54QVlnNnVVM25WMG50b1VGdnBJZmc1ZlU1QTYzTExQMWg0WjdZSW5qUld0?=
 =?utf-8?B?R2ZEVjBaaUV1WUZkVGJNU2tucEhCVFRhWGdtejZxVmdaejBjL2ZnMkc1VS9D?=
 =?utf-8?B?RFVOS0hKTmxjNXAwYXcrbktUNGNUdUNXZmw4dy83dTlVNGFjODhOS1ZnTkRG?=
 =?utf-8?B?Ykd2VmhmdjNwb0NoNTlkNFRpZHRhZGJRZXkyZVlubVRBMllocEROK21oeTBh?=
 =?utf-8?B?M3V4LzdHRDRDcDdZQkp0WnFRSkRKMXFESm05b0NQanVySTVWZUdLYkZieTB2?=
 =?utf-8?B?TFg4M2cvUmNWaTlkWnNjR0FNR0tCOUtnaVR2bGovZW4xbC83dXlSZ3o1dFZP?=
 =?utf-8?B?RHA2SDBCdE00QmZMZW5GcVErWkJMbVEyaGI5dWtVRDF4NUxrWFR6aTRraUd5?=
 =?utf-8?B?OGRPa2svZnFJVHlZcU5RdGZ6TUl1RzhRWnU0TU9zV2JyVUlRaWZCTzlLTEJX?=
 =?utf-8?B?Ylhydit2K1lqeHN0OEVEQSsrV3dVejJCZm5CVFc1ZFBjbnVTY09FOWdTMzBu?=
 =?utf-8?B?eGROeWVnYWxjTnR4bTdRZ2tZT1JncEtRakJWckZOY0FsdEM1V29MYk82MlNS?=
 =?utf-8?B?NjFGcEp5Z3Q4UVJNdVc3YkF2VEpkQnZWNlJ5ZUg2Y211NTU3Sk43VEFrTmhW?=
 =?utf-8?Q?/ZVH7ZB+ZJT3y?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MENYUDJ3SDJ2b1FNTThlV0FGM0FDK2lXV1NVUzdSM0tKbFB1OHpnZjc5dVJv?=
 =?utf-8?B?c0p0Lyt6RURHT0NiSTlVVlFFOWJZRjgyTkdvWHY1YThWd1NsNzVESE1Za1Jz?=
 =?utf-8?B?aHV4eitYUG94dTZHc1lMZkJQVlFJSG5lRHM1MzNEQ1RxRlF3a05MelhqZUV2?=
 =?utf-8?B?R2ZJbmNLMHFCREVaWlNEVXoxbk9IbG1CMCtKaTIwU1R6bFZ1YjRqZTVYN1FV?=
 =?utf-8?B?a05ONE8wek9tbk9mT3ZUd0xOQW51end2OHJQM0IzMUFYWVliSnJ1Zkx3RjdN?=
 =?utf-8?B?TG5mUjVvSFp2dkpCZDI1ZFhQZzF6Q0R4TGRtcnBrb051dzNNZlk4Z0lreklD?=
 =?utf-8?B?Rjc2U2RaVlhPd0tKNTRlUEpuTDMxaFM2WGVtZkNncDVPeVg4ZUFyTkN2VFhW?=
 =?utf-8?B?OWJWbGZ3M2NicXd5QmN3YitHR3dERVBjMDVJRGlPK3NOQTk2dUw5bmo2N1U3?=
 =?utf-8?B?STUyQVBMWHl3ZW5PREJtMkUvdWM0SXRjUmJwSWFHMW1TeitFeE9vaWhBTGpN?=
 =?utf-8?B?ME8vcUF5VlNNR2VheEoybUVZaXVwWnJQMmdpZTNTVzN5eE1KWVgxbW41bUlu?=
 =?utf-8?B?bE9WbE4xRXlNR0lxU2NIb1grTGZqVkQ3UlBmTGFyTzJNUkp4ejFkR25Tb1hy?=
 =?utf-8?B?UU5jVWVhanAwbmEwbE5naWEzNkgzV2JaMjhScCtvekZVQVdBQno2d0svK3JZ?=
 =?utf-8?B?bjYxSVNkUnMwak43NlFhSzZGOHdqRHk0OUtkd2RsZFowSkhjazFaVVFLNzNs?=
 =?utf-8?B?Y1BRdHRWZVIwL3dPNUlYbldVeFN3cTEySG83dnhiazc3Q2lpREt1NVhmWnpW?=
 =?utf-8?B?c2cxV0dYNjliMUFLRlRERmF1b0lSeDFsdUozN240aGQzeWcwOEVpR3lmN3RF?=
 =?utf-8?B?YUdsczFHUzdTeU5yU0JOMndQa1gzTzhrYzJGcUZIT215WU5kYXh5eG5oU1Nx?=
 =?utf-8?B?SjlSTkppZDB6cUgrZ25XaEwvWG9vT1ViWVYrR3BaNGg1MTdxZXJMT3VyMzc0?=
 =?utf-8?B?YlVYNUZ3eFpDV2pGVjBvV0ZlWVFOaVBteDRmOWJvcm01VWE3OUt1a0hyWEZ1?=
 =?utf-8?B?eEs4dVowcmtxODNJSXo0djNzSmZCRUZ2eTNLYnN5OE9NWjRCL1YvV3FRaDBM?=
 =?utf-8?B?VU5XRlR0UTZvRlBvaG5JclJjVjBQd2hQa3R2bXpWaW8zRGs1WW1HZU5TSEZI?=
 =?utf-8?B?T0hRejl6SHAzWEFRN1QrVCtXVFZ1WGVyOUpyZVhUelJnSVo4RFRQRk1rNU5j?=
 =?utf-8?B?aXFKb3JNMXFEMnozL05qbzBQc1ZBYlBOUThkVzNrNllzY2xTSkNHanJHWlN1?=
 =?utf-8?B?TGxlMjc3SXhKMElkUzVTVll1a09KUHdtZXRZS1Z5UjhIRWp4K0pGK0J6V1VG?=
 =?utf-8?B?bTE5NVdNQjcrWVcyQXFDQWI1ai9UNGhlRjI3dW1LdEdZa0Y3d3RIVk9GTnlF?=
 =?utf-8?B?N0lPTGNNeXhKYUlWTURlT1JJR0lHdTVjeGRyL0VwNjFacm54M2ZTUXc4R2d3?=
 =?utf-8?B?RW1DZ2d1TGh0MU8xT2tRUlBveWxFc1pNcFRpYllTaTF6a3ZnTFNPU29tSXp3?=
 =?utf-8?B?MlZPL29KaHpJSmZPNExnd0NMV2N2OGIvRUQ0VFIxZ2xsNVo0YWtyT3QwV0tS?=
 =?utf-8?B?Ris0RUNabHIzRHlZdm1SbVlUUmE4WDhIZE9kL3ZGUlA4SGIwTmlKdTJIQVM1?=
 =?utf-8?B?cWFFTkY5TTBrY3RFMnRzRW94b0tOVDVWU25jTWtwRk5zT0tTMERlT2JoUHla?=
 =?utf-8?B?NWdjei9BOFoxWUNXLzFXMlVJVnp0U21ndG5HVDBkK0RudGdQdWVBWnZTRnJR?=
 =?utf-8?B?eDhhWUp5ZnRtWjBRQTRHRHRzbkg0aVJ6bzY2bGtMLzNCYWYxeGY3TWJib1B3?=
 =?utf-8?B?ckZXczZWOFFhVE1weUFRbGtwVEozVWZTUFd5N1Vva01SeENpemRhUE1KUnNM?=
 =?utf-8?B?c1FkWFp0OXRKSjRvUExoWEJEWEdKUEEvVlJUbUx0SDhhaEhzYkNwRGNsNzlr?=
 =?utf-8?B?ZnAyZlBYeW5ZNnd2bTdLTDNnWVFPU2RDVWJyVG12YmMzRks0SzJ0NFk3TDJ4?=
 =?utf-8?B?QmRhTmxOVUJHRkptaHdWcjZPQStzM2xJaFBOb0pWUjJQMmFtUHU4bEdvbnN6?=
 =?utf-8?B?SjA1Qkw4Q0xJeUtxbVdoTlNJWnMwM01HUjJoWHdFOFBsSm9wWlJ4dU80S3BI?=
 =?utf-8?Q?Z1qJj+1BCd8i08EyqAAz82c=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f756ec-74c9-48ff-28da-08dd573c4bb2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 14:37:43.7142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yMEiUj3H+FpVcj9v3udNwlWtQjBD6PHD3Xyo3EeyT7qkG1+fzk5B0VsnsAvkt67LdrbwNys9v+Ntrbn4awODuZSrMFwUkxEQgoIEHo2hUns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5867
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 14:37:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17946



On 2/27/25 15:30, Claudius Heine wrote:
> Integrate detection and recovery of power failures while a partition is
> being encrypted.
> 
> There are possible scenarios:
> 1. Power-fail happens while the partition is reencrypted:
>    - The LUKS header contains `online-reencrypt-v2` and needs to be
>      repaired with `cryptsetup repair` before it can continue.
>    - Also no resizing of the file system is necessary
> 2. Power-fail happens before the systemd-tpm2 token can be installed
>    - The LUKS header does not contain 'systemd-tpm2', thus it needs to be
>      registered and the temporary encryption key needs to be removed
> 
> In both scenarios the system after the reboot needs to have access to
> the temporary encryption key that was initially used. So using a random
> one, generated via `openssl rand` is not possible. Since it is only a
> temporary key and gets removed after the systemd-tpm2 token was
> installed, a known password can be used.
> 
> The list of these scenarios is not complete, there might be other
> instances where a sudden power-fail could be fatal to the system, but
> these where the most obvious and risky ones.
> 
> Signed-off-by: Claudius Heine <ch@denx.de>
> ---
>   .../files/local-top-complete                  | 33 +++++++++++++++----
>   .../initramfs-crypt-hook_0.6.bb               |  5 ++-
>   2 files changed, 29 insertions(+), 9 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> index 4b6451a..6034175 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> @@ -72,6 +72,9 @@ reencrypt_existing_partition() {
>   	reduced_size="$(expr "$part_size_blocks" - 65536 )"
>   	reduced_size_in_byte="$(expr "$reduced_size" \* 512)"
>   	reduced_size_in_kb="$(expr "$reduced_size_in_byte" / 1024)K"
> +
> +	CRYPTSETUP_PARAMS="--reduce-device-size ${reduce_device_size}k"
> +
>   	case $partition_fstype in
>   	ext*)
>   		# reduce the filesystem and partition by 32M to fit the LUKS header
> @@ -90,14 +93,25 @@ reencrypt_existing_partition() {
>   	squashfs|swap|erofs|"")
>   		[ "$debug" = "y" ] && echo "skip disk resize as it is not supported or unnecessary for fstype: '$partition_fstype'"
>   		;;
> +	luks)
> +		# Check if reencrypt was aborted
> +		if /usr/sbin/cryptsetup luksDump --batch-mode "$1" \
> +				| grep -q "online-reencrypt-v2"; then
> +			/usr/sbin/cryptsetup repair --batch-mode "$1" < "$2" || \
> +				panic "cryptsetup repair was not successful"
> +		fi
> +
> +		# already luks partition, don't resize
> +		CRYPTSETUP_PARAMS=""
> +		;;
>   	*)
>   		panic "cannot resize partition, unsupported fstype: '$partition_fstype'"
>   		;;
>   	esac
>   	if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
> -		/usr/sbin/cryptsetup-reencrypt --new --reduce-device-size "$reduce_device_size"k "$1" < "$2"
> +		/usr/sbin/cryptsetup-reencrypt --new ${CRYPTSETUP_PARAMS} "$1" < "$2"
>   	else
> -		/usr/sbin/cryptsetup reencrypt --encrypt --reduce-device-size "$reduce_device_size"k "$1" < "$2"
> +		/usr/sbin/cryptsetup reencrypt --encrypt ${CRYPTSETUP_PARAMS} "$1" < "$2"
>   	fi
>   }
>   
> @@ -219,7 +233,7 @@ for partition_set in $partition_sets; do
>   	# If partition is already encrypted, decrypt and continue with next partition:
>   	decrypted_part=/dev/mapper/"$crypt_mount_name"
>   	if /usr/sbin/cryptsetup luksDump --batch-mode "$part_device" \
> -			| grep -q "luks2"; then
> +			| grep -q "systemd-tpm2"; then
This should break encryption with clevis.

>   		open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
>   
>   		# check if we are trying to mount root, set ROOT to decrypted partition:
> @@ -230,6 +244,12 @@ for partition_set in $partition_sets; do
>   		continue
>   	fi
>   
> +	# If partition contains an aborted reencrypt luks header, switch to reencrypt mode:
> +	if /usr/sbin/cryptsetup luksDump --batch-mode "${part_device}" \
> +			| grep -q "online-reencrypt-v2"; then
> +		partition_format="reencrypt"
> +	fi
> +
>   	# If partition should not be encrypted, continue with next partition:
>   	if [ "$partition_format" = "noencrypt" ]
>   	then
> @@ -247,10 +267,11 @@ for partition_set in $partition_sets; do
>   		watchdog_pid=$!
>   	fi
>   
> -	# create random password for initial encryption
> -	# this will be dropped after reboot
> +	# use partuuid of the partition for initial encryption password, this key
> +	# will be removed after the reencryption has finished and the TPM2 token is
> +	# registered:
>   	tmp_key=/tmp/"$(basename "$part_device")-lukskey"
> -	openssl rand -base64 32 > "$tmp_key"
> +	lsblk -no partuuid "$part_device" > "$tmp_key"

This has the security implication that until the tpm key is used the 
device is insecure.

Quirin
>   
>   	case "${partition_format}" in
>   		"reencrypt")
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb
> index c9a7f89..5e82521 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb
> @@ -14,7 +14,6 @@ require recipes-initramfs/initramfs-hook/hook.inc
>   DEBIAN_DEPENDS .= ", \
>       cryptsetup, \
>       awk, \
> -    openssl, \
>       e2fsprogs, \
>       tpm2-tools, \
>       coreutils, \
> @@ -40,8 +39,8 @@ HOOK_ADD_MODULES = " \
>       ecb aes_generic xts"
>   
>   HOOK_COPY_EXECS = " \
> -    openssl mke2fs grep awk expr seq sleep basename uuidparse mountpoint \
> -    e2fsck resize2fs cryptsetup cmp \
> +    mke2fs grep awk expr seq sleep basename uuidparse mountpoint \
> +    e2fsck resize2fs cryptsetup cmp lsblk \
>       tpm2_pcrread tpm2_testparms tpm2_flushcontext \
>       /usr/lib/*/libgcc_s.so.1"
>   


