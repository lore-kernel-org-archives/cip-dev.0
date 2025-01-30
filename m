Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11976C0218A
	for <webhook@archiver.kernel.org>; Thu, 30 Jan 2025 16:11:31 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.81])
 by mx.groups.io with SMTP id smtpd.web11.19061.1738253486554401001
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jan 2025 08:11:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=VWAy115c;
 spf=pass (domain: siemens.com, ip: 40.107.103.81, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ut30jpYVulkh8ks1vBuiewn+3LQr1ZWRFD72WCKJApNwjKNe8cJdee3pIhBouZgzfRkkzPGtIaNjrZTB5YKhI4uH0ol3yxe6IEJgU7OMByl9KttYQNsJiULEpi2WyeByN3SAXpy1dWVOBs9DJqlQJWJj+bYIWpl/4isQ85L4OKzdNM+L4IhhVVnjq9W/DjJJH/Ez72U6BZk2BMn56MsadPL+zsorgyaHli5aesj8t1qU2Se+OEqWT31crBYfQvPrYlLSENQQSD18K3tQ4z6RUqOOFDGS89SYDL9HSGtHh7KOn5IYkKC6a79vZCzyMgGx0Wh0IFKVRzV0R7LmRQZ9Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbAG09RIxwUYhaNnxi9dTA5ihi3f8rUuoFq0Ps6WpRg=;
 b=fxsVTWLYIhSznrMy42hq1qwBG3+Ryy9QVfldCP0g8E6bP6njVPb1OLJkRq5SYjfcItpcTJCJ+vp18+8uzsGlnzN3LqlSvcgA2zOA+C8BdE5tFUU7xNhOwQCYLrClg0tv4dmICqVWeoGOQ1AfL/DgAB5Up38TsEe80ajtLFBvM+2whscFqay0j1a1y7vYJUUtHfPIxnvuYjXDePqTiLSYTQIGyOkh3+4XpjLJDwoOtbeJaCTQFOe2ZlPLOTpa5vF9xVbvufh4myUJiagCh4DfyHPZU36icKwajkxjQUbm9KUjzLfEqYdlSfl4/cQBApCKGMku4jPugSfVRyrd9QwGXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbAG09RIxwUYhaNnxi9dTA5ihi3f8rUuoFq0Ps6WpRg=;
 b=VWAy115cyZaAoEQkgqTpk+MTz5+xV21sqddSLCI0kvJm+OvXMxJZoC21G+Tp9uSSI/EVoLYdzt/uLPTOcp/5aU7WHAy49JcOHfL6L+Wad+M2IDhM8XdDHmy7/zJ6al1nnVFfAWpfYG+4WcUIHYyANbfgNdV/R9AXb6+48xu17oL5ZTMJcscKWpY40LRvejHVnBQORP0vMI9SZfRpuE7phchhDyLvv7p+Oi8LHqo/qDxlfcWmvtKW5lVWop3kT16mDNfO7FrwdopqYOzmOFe3Wtx8Bz20hHTigNPuRfhzt5iFfBGyJvz9uSgiADukwOQPOVoSSksx/qQPPY7YcEalyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8820.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:420::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.5; Thu, 30 Jan
 2025 16:11:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8422.005; Thu, 30 Jan 2025
 16:11:23 +0000
Message-ID: <ebee2f73-3aea-4b48-b131-b7d17682242e@siemens.com>
Date: Thu, 30 Jan 2025 17:11:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC][PATCH 00/10] Provide A/B snapshot support
 for persistent /var
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Christian Storm <christian.storm@siemens.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Felix Moessbauer <felix.moessbauer@siemens.com>
References: <cover.1738229957.git.jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <cover.1738229957.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0005.namprd14.prod.outlook.com
 (2603:10b6:610:60::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8820:EE_
X-MS-Office365-Filtering-Correlation-Id: 264d4f7c-9a85-40cc-6628-08dd4148bdc8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WXFKOUlpV2JxQU1sbFB3TGpZbjhmcHkzUGVUd0tFa1ZVUURBc0FYWXcrQjZo?=
 =?utf-8?B?ZU5iczJXdVBOUE5zZklnVS9oaUNwRUdEVkVsNHFLNGZlY241RU11NmR5UndB?=
 =?utf-8?B?YXZzZjNFSEhiWWRpTzhYSXlwTWNXWUlORkJiSU5tc2d3VjZRY3RZdGFLUmNR?=
 =?utf-8?B?QVltU0pwRDdZTjJlNmU3TkwzUFZ4KzZhazJwbzQ0eHFxbkxwOVVhZE55ZWgz?=
 =?utf-8?B?VXZuQmJIcGROWDZia2dZV1VWSjhjckdpbGR6VSs1bEtxVG1BbjV4eXFTcEtZ?=
 =?utf-8?B?ajhaQzhDZUt6bTltaDMzMFFsYTYveXc0aTlyWkZlWDUzcEFZdWZrNENYY21i?=
 =?utf-8?B?SHoralJ6eXRLZFhoNGFoS1B3RUVKNDlQWUNOQ2hJb2N4WjRBYURQdGRXWEpt?=
 =?utf-8?B?WjNZVWVlNXE3SUdjVjhEWnoycDViNWpwYzRuYU9mVytsdFF5WklmUCsrQmp6?=
 =?utf-8?B?M3Y1YWZYZ2htS2ZyZDJ3dVFIOEp0ckQzdDVBR09xK1pJbTNYdUt2cmdtOXQy?=
 =?utf-8?B?M09rNHMrTFcxSEVrSDROZ2dxNjBaaGExckJPSURNSnNadDBkL01YZnV0VlBJ?=
 =?utf-8?B?cjBGN2lvSEJHSnpteXNMTHhhRGZMSGo4dDE0ekNSeTFsOWExbURXem9FSXpE?=
 =?utf-8?B?cmJsLzlpamxTdW9LUCtTOTJESTBBSGpkK3lvdFp5dGxNVWNxUHR3UEE0Umg4?=
 =?utf-8?B?RUZzV2p6MHdxZGNVbUFKTkN2UjVUdDRUSVl1cXBGSklWU1NHWnArYXBkNm1q?=
 =?utf-8?B?K05IWk1nWHJ5OG9RU3p3c2lTS0lQdy8xRWF5K29kTXp4SWhPY25WMis4c1ZQ?=
 =?utf-8?B?aEFFWEpvcGNYdFN5eGpYcUk2VGdDT1MrcytDcURSY1ZWUG9md2cxWTcyaXll?=
 =?utf-8?B?TGR2WlpHaldQSHpKaFpsV1hLQlo4aGZtd2Z1bk9iRUM2eWxjUHdPZlFaYUhF?=
 =?utf-8?B?VFk4U3A4SVZjcVpJMFN3SkszZENyakdkanRDZ2VTRXlGdG1ZOW53WnFhUG8z?=
 =?utf-8?B?dmpTQTAvMXhzNzJCdlZid3NWZmg5QmRjY1pRZkEwMXZiVlVnMFpoT1BnZnNF?=
 =?utf-8?B?MlBaRWJLQlplK0pGbmcwRnZzdzUzeUdIT1RRT01LZGNSK1MvTjJ6T2lkRHRG?=
 =?utf-8?B?WTJkMVhZZ2xHNnZyMDBpbXlqOUp3MHJOTzA3THNWNHFyWlpnbG9peXV4VW1q?=
 =?utf-8?B?TDBZem5rcFR0Nk1PSHd6WWIybnhNNHBCZ3habXJ5Y0JlTVR4M0QvVUFLcTN0?=
 =?utf-8?B?NWNmbStibWVMVStXK2gzNzUrUUJIYmJrRE9FR1FMSXc1dVFpZlNxMlNES3N3?=
 =?utf-8?B?MlVKRm9JQXI3Q0dFc2l0bUZKNzlOUitMTWZCbGp6NG9QR1NUN2QyRU82MlJR?=
 =?utf-8?B?YlpPOHFQcHlZdFQxNklhbklGRUxyWW5OZndvdmpvWG5oV0F5MVBFb2tmbmJ3?=
 =?utf-8?B?VmJVODFrR0xrQjQ4UDd1RG5yY25jclBXRXBwWjVjK2dENkR1SG9kVlRZSDVD?=
 =?utf-8?B?eEJDT1RVVjRVaUVaWVlkR1c4L3ZFYndFMkhkaDBTNjFFMFRLeXVUSlByV1g5?=
 =?utf-8?B?ZS9aOXEzQTYwajAvQ1E1UUpmZ09ySHVWMkxEZFlxL2h3Mll5NUIwdVNZUmpt?=
 =?utf-8?B?ZmxnL1pxcFBOMERZb200eEN3TDJUMWdPeCtOejYwOWdTTmtkMXZSU01SSm5O?=
 =?utf-8?B?Vnd3clZLbW5veW5pS296V09nei94bVZObXZjNzZVYUJ1TlFmdUhMME5XZ1Fm?=
 =?utf-8?B?bXk2TDhJOEFJZ2pEWXpWTHBTTWpJeHBEbFNsV1dqT3hHSm9YQUdEalpndWg4?=
 =?utf-8?B?d1BkUk9iSzA0WVhNTVpkU0ZETzl0TWNuK1dZb3ZIOGJRSStlUUt1VjNkcTFN?=
 =?utf-8?Q?ApipAY0S5jKFJ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TGVsdFNXenUwSk1BWUhKYmprREZmZHhPMGh5UDB1WjQ5U1A4VVdmNnlWMW9E?=
 =?utf-8?B?enRXbXlma1h6d1lPTUkxS1JnUnQ4UHdOWlRSbURvSXlXeFd3aGVOcTVkOUxD?=
 =?utf-8?B?eUFZdkZVcE52YW1qMWhZT3pGVGEzUjdEUFB0dTVnYnJacHpxblJUOTl2Skl4?=
 =?utf-8?B?bjdyMkNrVExMQjlWemU1UXNwbXNPcjJGQ0hZNG4yTmgxaE5WenNQdGpjd2Rx?=
 =?utf-8?B?VWRPdGJ5UlZTNUxLd242SGhFQ29LcHJtQjU0eFBkQjRWRUVLWDNTWmYvVFUw?=
 =?utf-8?B?ZWw1cHZTL3BxdXhIdTNacEZNV2R3d25xSFdsNmdJOC9rQS9sbGlQSjlmVUFa?=
 =?utf-8?B?VjhCQlNKaUtaNVgvMTNuMnJkQm82b1JqMXJ6T1BpSEk1K1FZRmI2TW9Uak1H?=
 =?utf-8?B?aHJ4R3ZhVFRjak1VMjIzc0cza0YwMWpRcktkY3hZOTB1V1ZHdEFhME5lNjhu?=
 =?utf-8?B?MHhFTjlPUVNJL3daTWQwbVhqMHlJZnZoeW1YOWRLdGFwenN3Y1FXYlI5UVYr?=
 =?utf-8?B?MDYvcGdLM2I1NG1yakttWlpCZU1VZUc1U3duMXN6dGovcUIrc0F1WEJGeGI4?=
 =?utf-8?B?U2tZTmZoRmtDb1J3Qnl5S0dZL3pldExHVmZiMDFuRk4yclgxa2VGQ25DcGdI?=
 =?utf-8?B?bEphU0p2RG45SXNDNTYraklKN3NnTWFXOWlKc3JUbVIrRHRjYnVRNTBUbGxI?=
 =?utf-8?B?eXFaNnk1SDJ6UkRIUC9UUmgzajJINEkwVE1YanRGMmR2VmJnY2pUOHdNWTla?=
 =?utf-8?B?VkFsbUw0NlNRczN5YTNya1pXaVpYSStGOGtVK3dTK3F3QTBvZks3cGtXbFEz?=
 =?utf-8?B?MDJIM05XNHBzcGtqRWpzRDczNGNrdmM1R3poa0lVSXhNSlZPbkxndTZrbldm?=
 =?utf-8?B?ZDM4aU5PRDZxZzB2OGN0dUsrMnhsUFI3MXVDQXVPOU1TYklBNzZDTFRrUHJO?=
 =?utf-8?B?aEJUaFg0dkRzSHJhazBvdkdtOFo0MnNheCtvM3dPVDNNQ0JEa3Ira1JKc3hw?=
 =?utf-8?B?TVNxdkwxQ2pQTGU5QjczS3VSTSs3TTBESXZ6YktZM1pLSGlLK0dsOEsxaWJy?=
 =?utf-8?B?NFFTUGI4Z09yRnhiUlZ2ZWhKR0krb2tMQml3MmFHVGd1cFhiRDB3ckFEVnhq?=
 =?utf-8?B?d2g0cmhEa2Rwb3RqcUJKQTEzQTZjbkRZeUtRUnMyanJLTHo2dHhneHBXQTBI?=
 =?utf-8?B?ZWI0MGt0dDQ1VU5LS1EvSnBHLzR5M2s2TEYxSlpHKzRNMVJlTE0zd0tpcUJC?=
 =?utf-8?B?bVFFQnFEVENQTGVIY0hiL3RVVnRKVFJWOGhuZXBicjM0dGkweEthcTUrWUxG?=
 =?utf-8?B?aDRIRC9GR0h6dVFhTEYvZWV6SlNaR3BBbm1DYlp4a1JWS1pIWW9SRVFPK3lv?=
 =?utf-8?B?ajQyeWVZOXN2dnJlRXpGYnFFTkRnS0x1QlRRVFhYVFhiTU15a1VhakxDZ0dV?=
 =?utf-8?B?TXkyaTZJTWo4Rk9wY0R3OWJQOEZPOW50R2lBWnV4d2ZnQ2czVVJ6bG1zcTYx?=
 =?utf-8?B?aHYwSmRsOGtBN1Rac1Z4M2c0ZmZFMzByU1J1cVMwQ1pMYWV5TktzOWFnNFlr?=
 =?utf-8?B?dDlwOVBDL1lUZ3FkdWFheDVUUE4wTWYrRmU2WXVkNzZXRUswMVNIYVg2SlRo?=
 =?utf-8?B?QzlYZFRTSzcwa2xmc0xTV2h0OXJ5L3BLN0k2SUFjR2x4WjZrbXlYQU9wc2tt?=
 =?utf-8?B?d0gxR3M0bW1lYkxqa3FDU1QvdXFxcmozYlBnZkhEMy9hRGVhOVhBeDJXVmhI?=
 =?utf-8?B?VjQzaVNZTnF6eGx5RFc1TWo2UE5HcWhKMTB2bENnZjJXNU1QbG5NK1k3Q0RG?=
 =?utf-8?B?V29KVHNNbk9BbWx4ODh2dW13ejFyaklOSXNKV2lRUHd2NTV4RGVGQ2RyR1hQ?=
 =?utf-8?B?RmI1UmoxeVo4bzVZRGMxbjZmZnNIT1ZLb3dJVTlTZ1gySElNelZvOGdiVzZl?=
 =?utf-8?B?QjN5VUpYR3dzaDdibHVyNnJHR1BGeGFRNnlLTE9FOGZ5dW1DL3FobjB6ZGlp?=
 =?utf-8?B?RUNyS201dFVNdkd2TDIrVXhickVpRmIzeGQrUWJkcUw1UXRGTEdHb2UwNDJm?=
 =?utf-8?B?M0w4TVVtajY2N2dWYTltTzZ6WFlCVWZ4dTVUa05oaG5yb1Z2aGM0RzdXZE1M?=
 =?utf-8?B?SFc1cFBpdXhZUzFId09OMm04ZS9hNHFsVjFEOHFNaDdHZlpNYk5SMk00cTRH?=
 =?utf-8?B?UEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 264d4f7c-9a85-40cc-6628-08dd4148bdc8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 16:11:23.6598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKUqKLYnp/ZbxiQQz+KFmlP2RTWrt+b12Us1xqaiIZcrIKtmxl2Ubqdk2FrTD7AR/3gibrFMfniHHogYnO765w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8820
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jan 2025 16:11:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17713

On 30.01.25 10:39, Jan Kiszka wrote:
> This is a first attempt to provide a pattern and reusable recipes for
> saving and rolling back the persistent data during A/B updates. The
> obvious approach is using a filesystem that supports snapshots and
> linking those to the rootfs revision that is being booted. As first
> implementation, we are using btrfs. While the current implementation is
> built around btrfs, the concept should not. It may even work with
> device mapper snapshots.
> 
> That said, the devil is always in the details. And even this "simple",
> btrfs-only implementation took some rounds to find a logic that neither
> piles up obsolete snapshots or deletes them prematurely. Still, careful
> review is highly welcome, specifically of patch 3.
> 
> As we are currently having split /var and /home partitions, this does
> not cover anything in home directories. However, this will automatically
> change when [1] is addressed.
> 

Forgot to mention some todos (which are related):
 - handling of filesystem errors, likely by resetting to factory state
   (blank /var)
 - enabling factory reset via explicit requests

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

