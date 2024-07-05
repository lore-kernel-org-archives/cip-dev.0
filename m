Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EDBC3271F
	for <webhook@archiver.kernel.org>; Fri,  5 Jul 2024 06:19:15 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.67])
 by mx.groups.io with SMTP id smtpd.web11.11491.1720160350187834372
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Jul 2024 23:19:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=d+XKkhEi;
 spf=pass (domain: siemens.com, ip: 40.107.21.67, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIrcFFqG4uf3jfec7HqV8kWth1XTd3z9LOww1Pb3Dc3NBXLP3+fSUKzOJFegsyrp8hToPYnlhYwEgL+Bstjmjh2fTt34tJChCoXJPR1uyH8PcrcVB4qyk3J4NVnUCe/LwUwrYQ/RaC9AoIlw9GII0z9skHit056XAqjXIouERsZPAnsRp2tRgsmmszPYGQs4K8NfjUMQlapurQOeodQfwbrfYqZyceKSIQA0h+WUc1vsofHieeeVuT8BUBh2N9q2p095wt3L9cdRC71pW9zNpajQQ0Hq5XTbcfLDTXjvq5rNfAXhVYlBRsD0jASphxPKBmIJ8f7kIqoXv8GlN7Ni3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yURy7AzNhlQiJHoZ5C1siW6STXqXt8+hLUV9NAKw9y8=;
 b=BCv1LA8msNjnNe7dPDP5SKgc+ej5fGAVxnbUcnnDfcHVfpaxV5cYCjxXJEddqns0XPwtdQw09RE/0VYQ4OIwHeI8/Ex3iwtksi4rDXJg9vwsVhn7SxDvlolFqjdtJGNXVqXtPjhXVuFDvC+Z30LmLR+UKdn1mMBH9zu7gOIiP8/2mTCQy41vy95ubbsJZIFyilxUXXpJCai8z0vUOIdWXxTHN6ktGS9BMYvUfEH2p5LZDCp+4ZMdfZZ/KbIU74j5vZlc3vDUoQBYmFOUbFTDHiEN9Z1NgpuZPLf7EsdVZUXKhNhHU2mmfezmU3WIzcpGC8YtPYU8s/ubikJf9uL4Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yURy7AzNhlQiJHoZ5C1siW6STXqXt8+hLUV9NAKw9y8=;
 b=d+XKkhEiGMBI3LGlsQH0cX1huVGVnKu6d2OO3FYMmsesrnu1D/c+lAXstbHWaNo5ZF/5BuaCA1FOHKCd/vGu5MmR4j9ruazoCH6y9NwodWacvBW24JCRJncPM4FbSNmyv5nCF8XYz/2yCN/c/jQYMAqERaZ/nVeo8XUvpeTdNx5X8QfuHHVtQkObGaDlVL6jwtq+MkoOSyHeNCcOHIWD4JDZEPvWM5DPubadoGK6mls5/9c1dm7F1WnYIyZpIvoBFgJqf3W/gGytdpoVS5sacfGwoOt7AH8ineDrs5ZrmYPzVdbiuiRo7n4+bbYXlafwniEzhZCkatVyU/wQgofiGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3715.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:153::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.31; Fri, 5 Jul
 2024 06:19:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 06:19:07 +0000
Message-ID: <ce96a45d-edbb-4401-842e-93117ab1f9cc@siemens.com>
Date: Fri, 5 Jul 2024 08:19:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core] Kconfig: Refactor Kconfig options
To: Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240704091803.3250609-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <68a430ab-afc1-4594-847d-bd823d44f965@siemens.com>
 <TY3PR01MB11075ADF741232B7FD668B5C3C7DE2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <434ca8c8-b1c6-4fee-8838-ee052666221b@siemens.com>
 <TY3PR01MB1107571B579722017185157BBC7DF2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TY3PR01MB1107571B579722017185157BBC7DF2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0196.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3715:EE_
X-MS-Office365-Filtering-Correlation-Id: 429853b7-1de9-4c5b-27c3-08dc9cba601e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TEExWk43czBHK2liai9SNDBjUW9hSUpKWVkxTDJPZkQ4elp0d1AvV3FVSmNK?=
 =?utf-8?B?aEdEaUU3RzVFbGVGRUlKTjRvaW8xbDRaRXFtZ3hJRUplTllVOUhzMmd6WWkv?=
 =?utf-8?B?OFNlL2lOSHlJUUtqaE5zZzNHUmh3SzNSdmIxR3dZSkpscEl2Z2IvOEVzem90?=
 =?utf-8?B?OWNLUzZXdlNNOWd4SEVHVWZDeTBQRnkwZmlsTVJtRWtTTHJjZjZsbmhOeGRj?=
 =?utf-8?B?SHVSSlNKc2R1MnE4RDl2K3hMWUN1czkxR0kxazVRYThhaVRvTDRFTTgvYU1L?=
 =?utf-8?B?ZlgyWlIxQTJRc0w3RUxhMWRkR3V1MEdOQkJWK2w4M1NVM0xMcmc5NmVqL1ZI?=
 =?utf-8?B?Rml6aWVSNWJQZmYyTitLdTdUTXFPZU43Mk5Sek5uTnNZYksvU2t5U2lBQ0dt?=
 =?utf-8?B?a1JSY3dCMlRKdXNteS9FdXRVaG1hbENjMzNwT1dSb29OYy9VRjNFNXIrbjlF?=
 =?utf-8?B?ejZvYzhuQjg3emZuWmxYM1V5ZUJGUGFTS3VmMWU2MmlSUHpkWmZ5dGU2aVBF?=
 =?utf-8?B?MU1EREdldlROSStrV1JuMm53QVFZU25vNWtERk1TVGFMRCtSNFpTK0RwRVJT?=
 =?utf-8?B?WDE3Zm9oLytkNFdIUVdOYnhUQlMvZzY1b1h4Rk9ZZlM4NXhiSmJtTmlhOGs3?=
 =?utf-8?B?VFNOeHd6eklhTEl1VnlLd2ZNRmpLR2NnVmM4dURmYmxGQmczM1BzOVE3STVt?=
 =?utf-8?B?OTNsSkhhZmdOcllPRFUxVStjd2VORTZlUGdFalgzMHVrWkcvS0RhS2N2dFdj?=
 =?utf-8?B?dThRQVMwSEg2Y094NkRwMzlXdzkwSjZBcjF5SHBjS0dJVGJCUmh6bHFYVmk2?=
 =?utf-8?B?YXluUnZadmNZdHpnWWd3QXJhaWEwQ1FHQXQxN3Jwc2ZrTkhVeVpvQXgwOE1V?=
 =?utf-8?B?OXErT1phWmlOWmVqLzE2WHV1b3JNR0tieUhqQndSdkNKZVNISDAzMUhjMDUy?=
 =?utf-8?B?aGhSM25vc1BkT0l3bW5tSEhoSDdKQlZ2Z0JLeGlxMkl4d1hCTXRTNlBrc2cx?=
 =?utf-8?B?VDZMTnAyQUVTRnJXRDN0T0dMY0diTWprR3ZaeUd3M083aWdYZVFtN1d4NCtm?=
 =?utf-8?B?RkhoKzNrdzhET2JaMjVmVzZPYWlmckpCdCt1K1lRaUJKZEdkVjVScFdXMTlL?=
 =?utf-8?B?aTBkQ3J5STRueXhSOFBmT3NweENWVFB5QVVvV0p4UTFPTG9QMVAyMDFHNWN3?=
 =?utf-8?B?T0dMVXRVMHk1N1dIT2JJcDFxUk5DWXd1WlI1VFV6Q1BZU0xXZW9GTndzNEd1?=
 =?utf-8?B?KzVVU2ZsUjYvS3FCWW1JSFlubUNjTTBCMWJ5SzhjaXV6SUhoK0JHSHN6MW9u?=
 =?utf-8?B?WktFZjdFLzlFYVhCczBCT1RxMTFIU2p4QmRHcFcydnViNXRUU1NIb1FJZFBj?=
 =?utf-8?B?QS81TlppOHhhVEErVzNoTHpHODVLUGN3UmFRNzNYT3NUWUpQK04yRlVCdldV?=
 =?utf-8?B?US9ZaFJWUEpzb0hkUWd2TzV6UmhUZXVCL3F5U3R5SzdmNWJkcjUrVE5HdEJU?=
 =?utf-8?B?bjFISFZwR0xhajZkek1Camt6b2R5YjBZUmhVTmNyTHkvcm80OTBYRTFkdXFH?=
 =?utf-8?B?Z3pNN1VRaCtaRTFXa3VId0tsZlhDdzJrMnduM01NQlpqVDlRa2o2aE14OEVX?=
 =?utf-8?B?Zk1HVlpOdENLYnZqQm40dEFUbEJ1ZUtMU20wUUlEdk02ekx1b3RuYTNENWZB?=
 =?utf-8?B?eEU5WGt2Nmw0aTRINVRVUm9UWk5XTDh5aVVIdk9ZbWpXYTRsSTFET1NZRGYx?=
 =?utf-8?B?ZCtETWdSdmJnVEN0VWR6M3JmNWxqajNSVU9odjA3aENYY01ZSjNGcUtRN0lj?=
 =?utf-8?B?TmFwYlZITTVsNnFGTGxSdz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?M2d1M09wazFKMTBDS3lqVEtJZ3o3WkRJK3ZobXROc015UUxzMlhkN004WHFC?=
 =?utf-8?B?eG5rb3ZJNEs4RTRmdXFPU2ExS1dLWE14UDlmNTFreURreHVqUzZEVE0yTUZn?=
 =?utf-8?B?N0ZNZ1IrMmZlN1FDckNLTzhsSU92SmI0d3lPS01JU0VlZTRBd1h5dlZ1KzIy?=
 =?utf-8?B?RXBEZmc5MDkzd0hPQVlZYXNCdEwvQXJlbEJreC8xWVBYQ0lVY0Zvb3RFSkRX?=
 =?utf-8?B?RVd0aWlvOWViZEVVOThrbDYzbFJ5VUpIdkRRSFJuUWM0L21QQnBLSHpPOGxz?=
 =?utf-8?B?NHFtdTVaMVlMMzhqdXFmM2NPMzh2Ui9XQVdFKzRHc2o5STREbnM2YUZpd2pM?=
 =?utf-8?B?ZDFscU9OVjFQQXhRR3Q4SHc1RitCQWI5ZlI3V1U3NUxzbk9KSVN1RlhNYW9L?=
 =?utf-8?B?cUgrR1UrQ1VhK3U3MmRrY0JWcTNQMUtJeExJWUFGSUpSSDVxQTFoS2dwc1hU?=
 =?utf-8?B?WktQQWk5QnlXenlTOG16V0NwL25IOS9oenhhYVV2OWhmbTdMSWQwR1Uyd3VI?=
 =?utf-8?B?NzNVYWVXNlZWRk92a1lxTExveTV0NVBENzZLdURkOEpVLzB4VkdneUtOTXhL?=
 =?utf-8?B?RmVhUjdyenllZkJNNjZNQUhsKzN2bUdOdG0relE1QiswUnIyUWtxMVhkaWFO?=
 =?utf-8?B?a1hSTE5KL1NJKzF5a3FCU1FWWkhqZVFBL3RPSlpoZEFORDBXMDdXMVNUbHpq?=
 =?utf-8?B?Q0xJbFFwcW1TTVhQOHMzR2lBUWlaQUNSUFh6WEY3aGEzT1RQRXRFQjAzNXMr?=
 =?utf-8?B?RC9XTmYvQXhHTE9IRldmd20yU29qVXdjaURhVDlLWDJuWGxOdTRnU0R5UEtZ?=
 =?utf-8?B?Wi90QkJjMCtmbkdyMTJMQlJEck13Z2N4VGVyaWI0cXpNSnBJbDlPV3hlM3Qr?=
 =?utf-8?B?eTRsVDFldEZ6NjArRktpVWRtSkdNRmVFeDVCRTZRRTJyNXdETm8rL0dLWEcy?=
 =?utf-8?B?YVF2Z1BwY3hYNkZ3czV2eVYrNjRzUnIyNTNmekRkekhrL290cTVSOXJUbFhi?=
 =?utf-8?B?NWUwQ21jRzNrWDZSTEpRbHI2VVRSQTNZUmlqMjZyNXRJLzFhVEx6Ky8xWnU2?=
 =?utf-8?B?VnJ3S2w0QWtWZkltaUNTUHdjVFZtNVBTTmtSRU84d2pwVFVrUTdqVEdiR3Yv?=
 =?utf-8?B?ejN0MW5ZTTltVnk1cHhmWDhQc2ZEUmRTUnRYL1Y2OENaT3ZkbkRwajdndkg3?=
 =?utf-8?B?TDBxRSt4STJ5OUJhajJWQU52U0tGRVIrOEp2UGJ1cU45bFllMG1OMG9zaWt4?=
 =?utf-8?B?ZDk4Nkloa0piWnczS1Evdy82NlJHY1RYbjdEKytKSFNXSGNCVnl6SVdINDhv?=
 =?utf-8?B?RU10Y2xYTGpJMW9mWUhzTHVYcjJ1T1BNSFVlZVZoUUt2YmR2ZXZqZ3FZdHZW?=
 =?utf-8?B?WDFBTThMemtUZFV3T3dzM2IveDZPWGgvaVFXMU02MEZ3Y1ZLeFNPK0p3WEFw?=
 =?utf-8?B?WXU2ODNPVEt5UitxSXZDNkliVWZaVW9hSVFWOXlEMCs2Yk5pckc1eUVjbm01?=
 =?utf-8?B?c0pJVzBPUitVWTRvZStTQ0VpQW1mTDJWcEs1WHp6TkREUWhDVjRCY0Jrb0lv?=
 =?utf-8?B?Rzl0WUczbzZjSWxVaWhBTkRpTnR2YVBMampIU1hYZkxlZ3hYYXhsa1BwdEdi?=
 =?utf-8?B?TktnY3JVWlFlZTA2ZE9xN1NPK3hXbGxtaXJlcXdIMFJsc0cyZW5lTEQ3WkxC?=
 =?utf-8?B?RTV1cU1Ec1hkbGN2WHYxV0FLYlZjc2tTalBJWHk4OVpOZW9KYXVPbjNnNzcy?=
 =?utf-8?B?R0s1T2hKc21qY0VjSW80UHBWaFlMUGdHVW9Fbm1jZXNLQmNnRy9MRnFDR0Zj?=
 =?utf-8?B?SlRIeTB3TWswcWFoWnVWV3U5MXFhMEN6czRSVk5wdmRsSUdFckdLTGFBTmhZ?=
 =?utf-8?B?ZExrV0pvbHpvTmtmWG1Mc21IazI3U2I1dXJCazBSZ3hQaEY5eUpTaTZzYWx4?=
 =?utf-8?B?TmRjR3A5Zk1BaXFUL2pjK0Z5NVdlUnV1UnNjVldqdFJORFcyZWI5UzQ5N3d3?=
 =?utf-8?B?czh2RGVHV2NQQ2FybUg3K2JWampBU1h0eWxYdlI4SGw5WVhobzVFODcrdWov?=
 =?utf-8?B?aHlYcDNZWHh6dXNBWkZmMTZZMWpJNzVkNTYvQkNubmQwbU5xd1V5dkVtYldr?=
 =?utf-8?Q?OgSmXBcKokCYUhJWBTdxHjYbc?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 429853b7-1de9-4c5b-27c3-08dc9cba601e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 06:19:07.1223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VrLev8cnoZ9uVmxEa9s+T7YwkK1cBYpPmFPBa/XDoDg4WP7KothjLXXt/tvG9WKfaZi/ZIGGsg7bS612EVdVrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3715
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Jul 2024 06:19:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16379

On 05.07.24 08:06, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> Hi Jan, 
> 
> Let me explain it through the pictures. These pictures taken on the next branch (commit: 507a6a70a7244a646165c1051668b855aeee9b5f) 
> 
> In pic-1.png, I don't see Secure boot option under Image features until I click on Security extensions. 
> 

This is by design: We do not support secure boot without SWUpdate. While
is technically possible, our recipes and conf files are not preparted
for that. Therefore, you have to select SWUpdate first before being able
to choose also Secure Boot.

> In pic-2.png, Security extensions is checked so SWUpdate is enabled by default but not Secure boot. A user may think here only SWUpdate is enabled in security image. I understand that internally it is including "ebg-secure-boot-snakeoil.yml" to enable secure boot for security image. There is no issue in build part(I mean proper .yml's are getting included for security image).  
>  

Ok, it's getting clearer: kas/opt/security.yml includes
kas/opt/ebg-secure-boot-snakeoil.yml, thus already enforces secure boot
while the kconfig menu suggests that it can be disabled as well. That
should be fixed visually by selecting secure boot in Kconfig.

Now, if you enable (or select) secure boot for the security image, you
include kas/opt/ebg-secure-boot-snakeoil.yml (and kas/opt/swupdate.yml
as well as kas/opt/swupdate.yml) once again. This looks redundant but is
actually harmless because the statements in those kas files are
automatically de-duplicated by kas. Just check the effective
build/conf/local.conf.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


