Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A2DD609A4
	for <webhook@archiver.kernel.org>; Wed, 27 Nov 2024 06:48:18 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.48])
 by mx.groups.io with SMTP id smtpd.web11.66537.1732690094091772933
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Nov 2024 22:48:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=N3nu3wAI;
 spf=pass (domain: siemens.com, ip: 40.107.20.48, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zOcjkT1ANztZvl7h3v7vi+loF9+a5lEPwgkDx2SDc9jkcZn6X4VSWQre+5/WKaQhAMAjb6uvPybz2o+2f7pijGMYlfHXmMbf6f1RWhFXXa5GKmN5on1O1ib6E0ZSaDCI0jz1V98Lk6bb5x08kvKZAfFmVsfM/8v6oucE/1JQR/7H/Bmfy0uBKUFE8WS/N+dw02RCmYDpzY/gZGs6w4X1y67FsXXBJPZ3+1qoBqSjCd3xqs5i97UHeblkHUdIYFU6dSr6f9/tbf38xcjcJ8eGRuXVUMUKCKgmrV/Fm4t92zL2clc1TakYfmFFRU/13RSJrRdlgbwVJf9qjBJvSR7MhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqTLl8ycNWb1PlnlTUjccn/4lYeNou4vaicxZoW+2uc=;
 b=xMEegkDj4PaW5JXUd/MGtsADIFwf0nWejbsoLr+tbLoUXKRJ/6EfeQQYCKFY3llaFdHvQ+tsVPyCdhwbbafhPBi2BSXziVxRiqPQcTrZqzrrdEEkv9xR7G7r+hKwrxMZJUX49NUPGxB+qaXStpNgyOQ8CsOEuUuGaakjlXjJs1GNAUSb5WqQFZvWeJ9YxsXA0VP0lC8hsn58shhLtIZdAoD2GEIBPZFG1syAsy4HYQ/oXStaR4qflntqXCTzgGI11HENsG3E7pPxIQQ9CoMvqH4PV2EoVeccQtpCYHSlWpXTbIIuVkB/ozmmVSOXuDAwSJXyozCp4p6PgK68oStdhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqTLl8ycNWb1PlnlTUjccn/4lYeNou4vaicxZoW+2uc=;
 b=N3nu3wAIZOnu0T9O4rQ7l/wRfyx+MrN37wUzuHwIv6PA+d/X2JrrServ0FR2b6K/cLQKkbuKmDP4wVBKEeDdOebovVEYz2miafxyPCb5WCQ2zvcDdGO/gSXD1ybMUdSmKi1vOKG/4URzNY54rJEUnvfTDDYDvqRfkOHK3cv2eaOvmh4A8QM+x8fZeGVZNc0aEBsiF+3rpKtkJ7UfFIS/KbkoVxtdLOsIkIfvDX9CO8antJEFRfXUyl1Snpz3yq9cWinTcW/pAJg1ina5/pPwUnlDNdZmdtarhw8AJ5teBBy4bqrgs6qJ9pg7grTYxnAehRTJD8vYvCZFPAxTBN7gLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by VI1PR10MB3728.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:131::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 06:48:10 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%6]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 06:48:10 +0000
Message-ID: <bf09c286-2b4d-4c39-b0bc-0880215d7c7d@siemens.com>
Date: Wed, 27 Nov 2024 07:48:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Hardware Support for Raspberry Pi 4
To: Jan Kiszka <jan.kiszka@siemens.com>, d.kauschke154@googlemail.com,
 cip-dev@lists.cip-project.org
References: <Ubf8.1732521612032277054.npTn@lists.cip-project.org>
 <84b98953-0729-45bd-9715-7c177464813c@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <84b98953-0729-45bd-9715-7c177464813c@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0295.namprd03.prod.outlook.com
 (2603:10b6:610:e6::30) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|VI1PR10MB3728:EE_
X-MS-Office365-Filtering-Correlation-Id: eb993438-9e28-4fc2-8692-08dd0eaf74f0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?REFLVlFQeXAvaWlrbDdZZkhGTlBaQWVTYU1kallJcTkrSGhhT2JXb3JLaEEz?=
 =?utf-8?B?RzFsMXQ5aXRhbVlPblZST0s1enVNYkNwUi9jMEMvamRtQndZTE5KTDFEbm0z?=
 =?utf-8?B?YVpoS2ttdXVFcVUralZoRXNHc1Y1UFJEMk1iSlUwalJrM3J2Rm9menhmVGRj?=
 =?utf-8?B?VjdVdGltOS83eEwwTHNmZitucnFHVmUrelIwRnZRRjdyU2NYcXM5d2tKbXdT?=
 =?utf-8?B?aTg5ZDBUTG9KQy9sbS81cG1FUEkzd0s4NjJKVVltOUYzVWg3YzVHUGFVYjlw?=
 =?utf-8?B?ZjZ4cWFHb3VCL1VKSzU0MjFTM2pFT2R1blkyakpTQTlFUG1ubFQ5eUoxOHZu?=
 =?utf-8?B?M3I3REhNV1h3K21mNFVmK3AyWDdpTnJRaGJraHJEYXllR1dNNnl0WU5UYnRa?=
 =?utf-8?B?VWlYa1BrTFZLNXorbFNHdi82N2lCYzQ5R2RXMGFYTERwNWpoUkVwSUxMYk11?=
 =?utf-8?B?bmY3Ky9oV2NSeHIrcFFzamRLMmgwQlJEWHVxY1JhbGxhUWtoVk41VFo5KzZS?=
 =?utf-8?B?VWx1ZjBYTzVLQUg3WTlNVEJOYVZwaS9FT2gzYk05Tkc3RXVocllhYjJMWHZq?=
 =?utf-8?B?WG5KTWhWaU42ckZsUHhvY0N3Z1IvUEVONVc4SWw1L0F3eERteVJqV3J2UzBJ?=
 =?utf-8?B?Vm5iQkdvbUZRMkZSSWZqZ1dJZ3A0UVFuRVV5bFl5N0tiMzg3L1Y5V0YxUDFS?=
 =?utf-8?B?Wkd1YW4za2txcVVKeEl5SDdnTjVFNnNJMzUwMmdmR0RmczN6RUVkMENmOXZl?=
 =?utf-8?B?NEloV0MwNENubHh5UXJYaktxVkJDREZmL2IzVDg1eXRUU05GMEF2NzgvR01D?=
 =?utf-8?B?UkVtdmNNMUJTZ2pmUVlQSjhIZjdjb3Z1MkFKS2g0dGgyWG5HeXVkQzZuUFho?=
 =?utf-8?B?ekFnazFrN2JDVHp2Skx5VlRyNkFHTlo1RTNBSjd5ZlhBdDhJMncyZ2I3a0ww?=
 =?utf-8?B?MFJyZkVLQ1BjME1LcVB0cXBKVnErYkNuckVxeVdNZFVQZUVQNHZlckdQcEZD?=
 =?utf-8?B?SHBqenp1VzhaMlU2MlFIMUl5a1pkU25HVXNLeTlFUXJVMFZjWXRsVmd2RWR1?=
 =?utf-8?B?VS9LdVNCZzk5VUZlZ205SEFiYzUwYWY2KzFubC8rTi9sTExYbGJXb0FNRGNN?=
 =?utf-8?B?cm5XTGdTdXAvTjBoMGVmbWdpV1JjeUUwNWpyMlpJWmxzZG9qcjNySXIwRVR1?=
 =?utf-8?B?cmZGVTlHanMvWlAvaVBhckJheTdYTmd5cjYrd2s0dGZNaEg1WStBd1Roc01P?=
 =?utf-8?B?UjJCc0RNaTh3NjA1Rm0vdkRyUE4wZkZDcStUcWt1YjI2TXF6MURRQVdmM1BD?=
 =?utf-8?B?NDlvUXZDRmRxV2JIU1lScDBaOTNyckYvZXFqODk0QkN2ZlJiOVNwYm5pMlhK?=
 =?utf-8?B?dWhzK2pqanowdW84OXNGTWRieEZUR0NORldyM3lIN3ZkekJnSjYxNjJsd3g5?=
 =?utf-8?B?VXlWdXI5YjNMdGhDOERhVW9HUHFUT3JIc1R1SkdrelFQMStSTHRGSDcxNE1P?=
 =?utf-8?B?R0NNNVE0cnpubVp1NytGOTRHa2ZNTkpwa05VQXhpMnQzZ1dCMHc5UnBRdUNC?=
 =?utf-8?B?ODNBYUJRZnVlQ2kvU1JUUER2MmdLK25vQjJwWnN4cmJsejdxK0hDS2hUQWds?=
 =?utf-8?B?ZGNlWU1CTnNqM0VHVHFKY2hJdmVZb1pUemd6Q3BsQnNzM0xNYjRRRVBGN25S?=
 =?utf-8?B?QVhKd0ZYczM2MSs4cHNmc0Jod0JmL3JZY0xaTnRVV2t1VlRjTDRIWE9ia1lH?=
 =?utf-8?B?RGUxTEVBcys0Um9jR1RNRTgzYmtXTFZ6VTJMeGUySjdVdkpSai8vVWdyN2U1?=
 =?utf-8?B?OVJDaHova1NIeXYxaUx2Zz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S2VxVThoWjhYN3UxUEE5UytCU3NQVEpqRnN6TzdVVCt1Ri93TWU3dXpLbmdD?=
 =?utf-8?B?NGdsZDczZWNvaFFMVTY2bTRYNVNoYzVEVXYvWWFNREIwL0pEaHVMUUFGUkdT?=
 =?utf-8?B?SlFSSzkyOWc1bzVzcnpEVmdSYnVpYkxVRGtsdmt4K1c5T3NaV3MwU3M4bzNo?=
 =?utf-8?B?NVgyYlhMdlZ4QUVkZERhcHcrb1FtbVBoRERtSDBVbC9FS0s5Z2RLakRiaE1v?=
 =?utf-8?B?RlRlYjlDM0N4QndpR0Q0U3l2d040ZDM2UC94bjJpMjRCZ3hQeWg0cy9ZbnZO?=
 =?utf-8?B?aTZhN2tQN3JsSGVnRTEvazU0L2NKK0htaHBDUW9LNlNmMmR1T0E1T1I4Q0lz?=
 =?utf-8?B?dFV1M1J6TzNpMmJHaFdwaXdPUGVTV05rZFVMaStiNTU4dmpOTmtHc1NqTVlI?=
 =?utf-8?B?dUxXRzF3dkN2UjlqN3o1b3VGdExjQS9udEJndENBTlFKcXJwWDVFdFBCRGhy?=
 =?utf-8?B?R3p3SnRGdFpqQjFmaTExbXRFeUF6dFJad2gySGpGRkhkWklhSWNmQ01PT3ov?=
 =?utf-8?B?WEpVTCs0bXNRWnd5bFNyK2N1NWFPTVBvK0p6aVNMaHBiNkUrRnJITzdjYlp4?=
 =?utf-8?B?RGJ4NVY3MzJvMFNUeVkwL2FzQ2l4dE1ESFA4R1djUWVSZ2pIazlZOTd4SGdz?=
 =?utf-8?B?SUR5MWVJaEV4LzIxa25udDkvTjZnWG1kbEJoMjZRU2xBTEVNOVFiYVlkOTlR?=
 =?utf-8?B?WWh2eW9Jd0sxNFZJRUpMWnJqbzRiNXpoUHlQelNua0czbWd6Zkk0ZkZNV1Mw?=
 =?utf-8?B?eUI3OFN0NVkyK0hqMHVCMjhhV0N0MmJWZ3F1MnA1bWhzWHJPRnhZeCsveUp1?=
 =?utf-8?B?L21nQitGK2d3c0VMbzl5Ymx1YktFdG5TYjNrRlJibzBGNnNaYVJHNkp3UTdv?=
 =?utf-8?B?Um1vVERvOXBtVE1KbFJucFpJRDRDdFpqcitoOWVWZzlRZmx2a3BwUkg3UE5E?=
 =?utf-8?B?bSswUmV5L251dmtNVC8zSzZGRzNITklPY1B2R2dnTmdGYmFGcDR2aElTSXFr?=
 =?utf-8?B?QjlvbkVTVlp2MU9vSDFBNUkzckt5RWFmRFFjckEybzAxQ0tZRjhNeW10UG5W?=
 =?utf-8?B?WjN5UUpWVFBkU2xnWVNZY25GOXdtSktEMmZjeFRsa1lsVjdHN0wxcGNnQVZj?=
 =?utf-8?B?V0VEUWt0QW5yVWhnYjZnTFhRbzRwZ3BGckVPQkprc0RqNTdLQ0swd1NkQnpy?=
 =?utf-8?B?WFpzaHF6b08vTm1waE1KRm9XR2NvTlBZVWJpTzJSYVpUdjRMMTllNU1ER0RY?=
 =?utf-8?B?WHByMkZucU5TRHVONU4yeklMbXhMaVBaa2kreVc2QTBIZXhNVjFJR253eUQ4?=
 =?utf-8?B?QlFya0xibDhxMWpqUk5aOUNOamRIOFN3UlNaeVlJdDZvWE1YMTh6VkZCZ2F4?=
 =?utf-8?B?OWVhRzByaDNSOEpiN1crY21HUEVDUlZDR1hKVEZ3MjlGVWVUZW1pZkM5Zlc5?=
 =?utf-8?B?bFNYdVBXU2lJMjM3VTZJamlzUXRpazNWeERPdHllcVoxQnRFdGtGVndwWmk0?=
 =?utf-8?B?VFhnMU1iSWJoRmNQQVM2TVkxSU1mS2J5UFUyM1ZGazNuZFZxK044UXhjK2hj?=
 =?utf-8?B?dU5WeS9VT0FHZkthS28rL0N0RXBmTGt6bFcwZVZ1ZGV4Yjd4emt1Y2dFVkhG?=
 =?utf-8?B?eHRUWnY5Y1dqM3hoQXcxYzNER0s1OURRMGM4NkFyNzNWT1h6TjhHQW5SRk1a?=
 =?utf-8?B?eTgvUDhqRkR0VFJ5OTYySE9ZalVQd3lvOGlzK0tsbWhYaW5jRHlEd2xJazRT?=
 =?utf-8?B?L3cxQW1EdFNkRzFjcWxxQ2c0RHdTSlc3VkZNU1VnakIwM2ZKRnBjMmtaNVQ0?=
 =?utf-8?B?REl5UmZpTW9sM1BXWHdpZjJicXRRWEVPQVVRSGpCWXF1bEd0UDQ5K2hxQkNQ?=
 =?utf-8?B?NUEwZi96aFA2N1V3U1VtekFraml1RGhJYXBGbG1jNXhrczY4aDQrZkZQSUdE?=
 =?utf-8?B?UlU4Q0FEMC91NFpNK245aEJjWStBdUNiUEdhS2I1SjljRzI5a0pkdmYxdmhX?=
 =?utf-8?B?L3F2MGFmQzVmU1lrVXVkTTdmUlRpMzdKQTV6Vk5BZzUzK1JjOHFncEo5Y2JU?=
 =?utf-8?B?QU0zMGVlbFdNYk5yeXBBN1RuWTR1RUJKeVUrK3RDQkRvanViMFBFelpZSnhh?=
 =?utf-8?B?MmxWZjB0MndSNHBZUGlZeWVmNGtjWE9Rb1ZiSVlkUHJNY1NIMEpCUFpKSmxK?=
 =?utf-8?B?NFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb993438-9e28-4fc2-8692-08dd0eaf74f0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 06:48:10.2947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j5Sh72bJNXLXMncAUNhj3PCU2j5+gtxazkgnmPSjGMk/dOYh9L0KtkXlI3vAMp6Je21/Fm8Y8HKmF6TtKzLM/6EpSjH85pzUfS6rOiTEeqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3728
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Nov 2024 06:48:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17283

Hi David,

On 11/27/24 06:28, Jan Kiszka wrote:
> Hi David,
> 
> On 25.11.24 16:00, d.kauschke154@googlemail.com wrote:
>> Hello everyone,
>>   
>> I am interested in understanding the current state of hardware support
>> for the Raspberry Pi 4 within the cip project.
>> My goal is to use the Raspberry Pi 4 with secure boot and secure update
>> mechanisms based on the cip project.
>>   
>> 1)) What progress has been made so far in supporting the Raspberry Pi 4
>> hardware in the cip project?
>> 2)) How can any remaining gaps or challenges be addressed to achieve
>> full support?
> 
> IIRC, Quirin once had a prototype for that, just not public. He may
> answer best what was need or what would still be missing.
> 

For our internal rpi4 prototype we used the following boot chain:

raspi firmware -> U-Boot -> efibootguard -> CIP kernel -> A/B

I added the following adaptations:
  - Raspi-config for booting U-boot
  - U-boot config for Raspi4 with EFI support
  - Additional bcm2711_defconfig for CIP kernel(6.1.y-cip)
  - wks for RPI4 and A/B rootfs

The rest of the cip stack should then work out of the box.

Quirin
>> 3)) What steps or contributions would be most valuable in advancing this
>> effort?
> 
> Baseline would be a booting image with a compatible CIP kernel. From
> there, we would need to see what is missing for SWUpdate and Secure Boot
> (both via UEFI). Probably just the integration of a chain-loaded recent
> U-Boot as UEFI provider.
> 
> But note that no CIP member has so far expressed demand for officially
> supporting that hardware and its SoC. So you may have to bring an
> RPi-specific recipe rule to add potentially disabled (and not officially
> supported) kernel features via a config snippet.
> 
> Jan
> 


