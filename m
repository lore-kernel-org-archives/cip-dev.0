Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629B1C3ABA3
	for <webhook@archiver.kernel.org>; Fri,  2 May 2025 08:22:17 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.10])
 by mx.groups.io with SMTP id smtpd.web11.14632.1746174131554624205
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 May 2025 01:22:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kadOxmWj;
 spf=pass (domain: siemens.com, ip: 52.101.72.10, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0PRl2kLjpb4xYpXjaB/kluipaeK9nrv/LuwVgffEkCZgoeJIEPSnpxytIGwF1j60M0TTfFxkHwL93+WwI4vEtH+SqOC0b+MbRfa672JcLPzNl8/P6bQ6AmBWDbjWEAhbd12OvUueWsqm/7pb7WyFhitThUnXT9pjd3FlEd45Ib1rhpZ44syjAkUxTp5f+yd4YaweG8BAuikPc77lRYWCSSobYjUACQz3lGQ7KHs7vFw5rdUpiI3C1mVWCOZEAzfcicLWV7J/2CZvstCB7H6HC5Jk2R0bikSsfdmGsvR4isiVa0/MDSjzRs1xhPNWG7m/ngVwWHwaBN7s/ByBOrdLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3OFkFpBf+MhFoxpgYXPql3uDzEGsFLzQErGmkWnKk8=;
 b=NfcjtXmE9091PA/mC/Q9Gp8Cn4/J25eIvv/zFLjvuEdwv2K5qSOG/91dFOFV6JeewI1o1eQl/bDvg6qykocOWBRFzuwwgaK3OASyEbdsdHtNjMAOUqKrZ9KM46e98WSHniePP80vQ0LlvLxRUjnZ/MR4MQ4D8ZP7YDxXwvmPZnJb0Rv9fZKsNPpBka/lXiDFjQdsKkQu+5RqXfRdmp5KnhziykJ9EBbKWclS60kjZuyMlzWdWFYwCVf5lighG3VVKgu4o0Fwb7jSjxCdJYBteaBNFl8+g00nnBSxx/fLA+oftWNb2P7fiZQ458KW0jr3U1EX8/S+9rdy9B9sOOP07w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3OFkFpBf+MhFoxpgYXPql3uDzEGsFLzQErGmkWnKk8=;
 b=kadOxmWjcI2nCPUtJnQU1mO393wmILQaokXEIZFZg/kowIod/IGLRDNFPDtkREmUUxVkuXb3XGZbYP35aOXfsiOzdc87XSJZlOCBxaLdmB/JR2LHpAUxto8LwCEp2rHRGQHiZikNzxga3GgV/OudmYx6c0KpDNaNAhAd3Ouyk0syhb7/GbdU3iuUFkoAI3NuwBDZZVeU/WbJAomVlUdUFJgx7HrkEKize49rSM8O1X/JOLUz4G9aFcptyb0YP9yvIXYf23DTOY9oUYvBujgXNrf7CUTaX5r1JcTlTqjhVyWEW9ziihVHudfoeGNfPu+9+NRVbtSmvlrYwABRFN37ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3549.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:137::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Fri, 2 May
 2025 08:22:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8699.019; Fri, 2 May 2025
 08:22:07 +0000
Message-ID: <fd30e45c-302b-4a87-9c92-2760a056fc83@siemens.com>
Date: Fri, 2 May 2025 10:22:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 0/4] Use kernel commandline for
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com
References: <20250428113325.3208873-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250428113325.3208873-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3549:EE_
X-MS-Office365-Filtering-Correlation-Id: b433145d-2b3b-44e7-b35b-08dd89526d48
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Y05NMkowVWZINGN4RzQxQ1MrVDBHQ2M4cXJjdWNjZHdERHc3b29tcGpZbVpR?=
 =?utf-8?B?SDlTS3hSK2NmVzVEbTZEbk9mcG1VbFQrd3ExaTBSekJIN1RvdjVUbUUxaW41?=
 =?utf-8?B?UGlyMythdnFDTXQ5a25BR2t4cTRvZHFEU0dwbXlwZm9IYXV4dFh5VTFWYURk?=
 =?utf-8?B?ZWs5Vi9pTTI4Y0Z1SHp6SzZqWkFHTFhDaWpBQ0xrQjREbHRaVU12TWdPbCti?=
 =?utf-8?B?Y0RXUU0yRFBGUzdWU2JCc2pUTDdrRHdMN0J5WE1jR3FWZVNnYWdtaVNlblNR?=
 =?utf-8?B?UURTait2RFVwcGJqMVd5Y1RTK2RpWTRSbnl3UGhVSmFWRmkwMWl2b1pRNlNQ?=
 =?utf-8?B?M0NIclJxZ2Qvd216V29TWXdXUE9MMHdDQWJvY2U2UnFtTG5xUHZVck5KR0xn?=
 =?utf-8?B?UjU4aVdNYkJtVk9teG1tb2tZVTBuTldaS290ZHYxTHY5aVNIRUZmTW5VYWdU?=
 =?utf-8?B?UFB5cm9tTGlNVy9HMnp1RjZXWG5UMTVRVzdtV2lER2t4cnBGQWZMVTFpMnpz?=
 =?utf-8?B?MWtZSndab0FmTW9kZFFqdEZWVDlpL0xxMFVpd2JOUXVRQlhZN2FwYWY3a2tN?=
 =?utf-8?B?SjRSajhFdVAzWWVkajNyazRmU3RHaU5aSzBtUmo5SENVQ0dBTFpBc2dJWGc4?=
 =?utf-8?B?QnVwL2M4bnZPRWRDeGRFcUpZNkVBSG9mbWUxeEY1eDZrTXRydkxSQ0FxZW53?=
 =?utf-8?B?VGVDTm5GVWNvMlZjVWVmR2lMeEE0Uk8zYk1ENjYxM0RkczlMR3pkQUtUNXps?=
 =?utf-8?B?ZGcvYlgwRVpkeGZ2SlM5MmljUnJ5cWJrbHE4bFV4cUtOT25TdmNzTEszZzVk?=
 =?utf-8?B?ZTAweVBXaXpjR3BqdEpRWkplOFo2bUkxbjFTWGhpQnJPNVBBRFVnSzRGa3BU?=
 =?utf-8?B?bllCT1hsbDIwd0tuUElXVzR6bENUbm93WHh2N1poaEZrdXUzTW1XNHlmR3FB?=
 =?utf-8?B?K0hBSit4RnlYMk52NTFSbkJlSmhybGFZYzZHcG5EK0gyS1ZCRklVSWNqbjFH?=
 =?utf-8?B?UkY2TlZQVDVycXZQOGZheFkraDE5SHVwVHJiSFk2Y3lPUTZnL2tHMWNmR052?=
 =?utf-8?B?T3hCcVZiS1l1eG83QmZhaURDd3lIa0FEbUhsam5nV0lEQWlNb0VwckRUQzlL?=
 =?utf-8?B?NGRMZnVBUE5RNlFIajRIVXdsNHQrM1VwdmFDQUVjSlZ0MlV3UkpyVVZnZVJk?=
 =?utf-8?B?S200UURtMW9VNER2ZVNzdVBJbWo5Q2F0U2NjbUVGR05VRE5DN1U2UkpRSmFG?=
 =?utf-8?B?ZS91bC9TWlpLUFBRU0JKVkxqTW81WHcyU3NuYSsvS0hsVHhvTUp1NHhYS2lv?=
 =?utf-8?B?aWlzMjU4OFEzQlNmVk9OZFB1S2crM2JzK3Y1RmZXTDdHYytkWUxUVTUyaFV5?=
 =?utf-8?B?UDl5a1FRYk16c1puYWFSVU1QeDJnc01SalUxR2xjdUoxSGNERHNXTngxVG5h?=
 =?utf-8?B?aC9xOW5Nc0RFNWIyUHAzQTNjalFQRkdnMkdKRmRnTjBxWnRGeFZIMU9pRVFB?=
 =?utf-8?B?eGxWRExaMHhRaWVSYlQ0cUxkMWVGVjdwOVYyM1cwM0tySFlzNXBWMC8wdlEx?=
 =?utf-8?B?Z0lMRmhXTXAyVjF6MmxzdGVMTmNkaENYRllnVlcyTWZ5MVFBcGVXS043WVdj?=
 =?utf-8?B?UUVTZXBCZXpEeE5aZmNzc3hiWmR3akpOTU5WSjJLNnN5SGxxd3FMSjNEUWRZ?=
 =?utf-8?B?b2x3QVI2ZEhwekMxUXFuci9SSC9UOVcvb0VnK0dVZjJ5dndTN3hMRWFweDNO?=
 =?utf-8?B?b0ZXeU4xWWNDTnB5OEtSby9GUjJQNkc2QVBsY1cyQXRBRnNMT1VJQXBlMGlj?=
 =?utf-8?B?c1dVaGFXOWp1ZjNMaDZsR1BNQUY0YXJkNnBTVzRjQlo5Y1RLdVMrY3FGbXcw?=
 =?utf-8?B?ZjNtMXk1SlhkR2ovN1ZkREF3b2JLVitoOTAzZ1N4anNHLzFFaUVTU3lTVEFF?=
 =?utf-8?Q?R9Vu4qSRSO8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?emVFWEZiWlh1ZUF5eVhKaldwYUJCWDZKZE1obGMrVXc5Nmo1bmtuM0U4dnha?=
 =?utf-8?B?Q2lZdlpiSXpMQU1CWERTL3VGdVBZV0N4ejR5ZG5iVVhSSktiRW9OL0paSFds?=
 =?utf-8?B?dDZObEhqVnRWVEpQT1dpVFBMV3RTYTdoVk1ucEREVlgxVTZZVHNWWncrdXpI?=
 =?utf-8?B?VXRoRDIrUmxxU2lNbWptaFhTbjJqako0SEQ1L3BjZEpQNkNraHNoSWpVdTdR?=
 =?utf-8?B?MHhpaVlVYytyUUdlVFNEb3psOVVVaFRQVXBzdlFBdmlORmJpTUxCdElJQTVu?=
 =?utf-8?B?NVYvY2tJYXJTV29mQ25DbGQ3ZlpLS1ZROWxMYm5PQlpJZ1RJZUdsQ1FzRVdt?=
 =?utf-8?B?L0lJQUVWMFRLSGFQa0U5ZHhkSmw5QlVqWUROMmx1cXRwWmY1bUdZN1Riams2?=
 =?utf-8?B?amxEbkJLK0JUTG5WeFc2bzUyTWc1Q3ZiVkNsU3hEVlEyQThLZWdLeVNaTENn?=
 =?utf-8?B?dEV0Q0xmL2tSRi90eXJqdVdtMlJ5L2tFTkNhcVUvN3ZJQlRUZXJEYk9sZC95?=
 =?utf-8?B?ZkJieEowRU5QY081RDFRVEZ5OVp3bXVrY2FJZVdCd1hVSWFCYnhwV29jOXl3?=
 =?utf-8?B?ZllXMk90dnBRd05WTmJ2dllQdTdyQm13aEduaU1iak5pWHlJU01vcUFWYVpT?=
 =?utf-8?B?STYycy90djJPeEl4ZE1hVnEwYlgrU0RBVEVTQk5xaXJXT1FuWWNBdnhoU3Nx?=
 =?utf-8?B?MUVXbGQreStrbEhmTUp3VzBORFF3amp6TlhCLzZEVzM4cDg4L09uVmJ0UUN1?=
 =?utf-8?B?cS9XVTJ6d29DK0NDTlFzMmhxTXc5NTNyb3lvZDBEOWFKa1QwMDFoMGNzRVBp?=
 =?utf-8?B?Q0NBQTJ6Z0R1aXE2S1paQ1BnZHNXalErUi9GTDJ3YlVmNDlKUzQydGhaWU5P?=
 =?utf-8?B?UGUreXlMdHRYM2VJK3ZzRmlzSjFnOThPNHM2VU9TNE8rT3ZXRWtrMHlHMWV0?=
 =?utf-8?B?NkJUeDQ3TXVkZ1JqL2RwdWpnTEFpR2w0djArS040QTJ4V0ZZRTZLenc4S2Vm?=
 =?utf-8?B?VjBJY2pwaXlzelE1dEJIVEZCOFMwWWxqK2YyRUt3WmFvMXA3dHJHMll6RlVC?=
 =?utf-8?B?M1pVbll2Z1ZlZGVkMjA1ZzFzTUtuWk4xT3lPQkE5VEk3Zk1OZHdkbHV5MWN6?=
 =?utf-8?B?b0h0eGFTQ05NU2YvcFVxUFNqeGtkZnpQdzkwRVB3cE9NWFBXbXhzNld6RGps?=
 =?utf-8?B?MmxTL0NHdXZjSDFwUjIyVm1VRDZZc0FIcGhhd3V0dHdzTXRjL1FCTllaTnNB?=
 =?utf-8?B?V2ROS0lCdlYzNDg3bGtXMnR6MThkT1ZTUklDZFlBRS9uVm9ieE1aZVpYSXdL?=
 =?utf-8?B?bkZUNlpxaDc5OWhhbnJ5K1RiSC9ockVzdjFNdTR2VTErNXdDeVpiaExWK2VG?=
 =?utf-8?B?eVo0OGhjTlRuSXo2MXVvREM0RC82cFBHb00yWnNTckNxWjloMVBzSE0zNDBt?=
 =?utf-8?B?bHIycnowcUd5ekdiL3kvZ05mOUJsa2pZVHJ6VUc3NEdtMWVuY0xLTHFVWkJS?=
 =?utf-8?B?cU56RWtJNmo3QjdFNCtTY2R1dGZxNTYzZWFHL2w0QWwwT3krd2ZJYlR3VEtT?=
 =?utf-8?B?N29UNWFNakhYRHNaaGFocS8rbU9ySm41RHpuTmNPbTV2OG5nZEthUlVRRHh4?=
 =?utf-8?B?bGRqSG83VzJSeVV2dWdzekZSaFlUYUg5NC9BY0lJVDBtNEd1MHA3aDNNSG9S?=
 =?utf-8?B?M1BpeXdwbmF2dkhkbnFIQVRMdllnbUZQT1A0V05yWUFWOVVrNDVQWDI2S001?=
 =?utf-8?B?SThkcGxVVEkrWHhDd2d5Z3B5RGt1U0ZJYlJyejlUK2FYN3ZUZnVvbHZvWUha?=
 =?utf-8?B?RnNzem5nd3htaVYxc2FNS3ZZSU5SaWRZSlVJZXI4RTJYNk5GMUZub3NlSy9G?=
 =?utf-8?B?MlZBTW9lOVYxbGRWdkF5Z1ExalcxeWdjMUN4ZzFIM09aVkRVVVNwTEkwZnhM?=
 =?utf-8?B?OGdmdnFLRklHKzJDQ3ZTbFlnZ1hmZFE4OUNRQlgzb2FCTDFSZU5PZG9RNnZr?=
 =?utf-8?B?cHNUOTdNVDBXWTVOOVg1MHN6bGJjVUM4SnpINXRDT3krOHE0R1piRU1ZZ3RV?=
 =?utf-8?B?akFVT3dFbzhBeCs2NU12TDBmNUJMdC95cjNGd2c4b2Y0Rk5DUk4xZzd4S0p1?=
 =?utf-8?Q?4ceGThg4CoEa4E0ZGeEJWnQ6s?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b433145d-2b3b-44e7-b35b-08dd89526d48
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 08:22:07.1811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ptTez4GtOJHn+K8cXy00/j5KE0O/+AgqPTf+kHb6fTs29bbmQP+D/7D3AEoouAP1ISBgfgzXaRYTHcMOh+iCIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3549
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 May 2025 08:22:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18753

On 28.04.25 13:32, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Take Felix work and add the missing abrootfs recipe.
> 
> This change allows to reduce the amount of initramfs builds as the
> variable part is now consumed by the wic process.
> 
> This allows to use:
>  - one initramfs for multiple images.
> 
> Changes in v3:
>  - incorporate `wic(ebg): reduce search to generate the verity environment` in
>  `wic(ebg): add support to add verity env to cmdline`
>  - Move common parts for env file reading to new function _generate_kernel_opts_from_file 
> 
> Changes in v2:
>  - fix some typos in commit message
>  - use `IMAGE_BASENAME` to search for the initramfs
>  - add missing abrootfs
> 
> Felix Moessbauer (2):
>   wic(ebg): add support to add verity env to cmdline
>   port verity env handling to new kernel cmdline infrastructure
> 
> Quirin Gylstorff (2):
>   wic(ebg): add support to abrootfs env to cmdline
>   port abrootfs env handling to new kernel cmdline infrastructure
> 
>  kas/opt/security.yml                          |  1 -
>  .../initramfs-abrootfs-hook/files/hook        |  5 --
>  .../files/local-top-complete                  | 21 +++++++-
>  .../initramfs-abrootfs-hook_0.2.bb            | 21 +-------
>  .../initramfs-verity-hook/files/hook          |  1 -
>  .../files/local-top-complete.tmpl             | 41 ++++++++++++++-
>  .../initramfs-verity-hook_0.2.bb              | 24 +--------
>  .../wic/plugins/source/efibootguard-boot.py   | 51 +++++++++++++++++++
>  wic/ebg-signed-sysparts.inc                   |  4 +-
>  wic/ebg-sysparts.inc                          |  4 +-
>  10 files changed, 117 insertions(+), 56 deletions(-)
>  delete mode 100644 recipes-initramfs/initramfs-abrootfs-hook/files/hook
> 

Thanks, applied with additional cleanups in patch 4.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

