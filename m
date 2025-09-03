Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED91CA0FF2
	for <webhook@archiver.kernel.org>; Wed,  3 Sep 2025 16:21:43 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.39])
 by mx.groups.io with SMTP id smtpd.web10.17223.1756916498410369518
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Sep 2025 09:21:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=H2CGM7ig;
 spf=pass (domain: siemens.com, ip: 40.107.162.39, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cdhwpd11hlgdpTYXuPxN7BVSMaBqHD6e5D+3b9VYeiJlb2NLTCn9OTeYIA92xgAtiQSz3JH/uGtIkqrv5MnkJg/VphLfXq9yo6q0HkBYC2gtp5dTbBL92EjaWa0sA/d3FXnYdnEd07+4TAuBqrFuBQfEy+46C8ZI6+IBphFWdCZq29w5KEh4yflMvSqUNnNb8sCxsHfUPfTMwfAThHrmkUMZFz7rPFtHr/o56MTbugQzXtOEBKkQdu4jiCsNxpbofGfNgfK/5D+FxgO0fe/ljHjdGXMBeAaIvqTbLrTeFN/8QX60OUdv3tYykzC5YGMdsiZkCeZ+Hws1chYsMHT4qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbLkTwsV3y5ZuPa25TkcQAMVe9xbMB3RjYQwiis2myo=;
 b=gs5hJ2YNHr8iuzpCnONFTKLgko+202eONs5ISyQ+ID+hu62kWoyF8+2NJZQCmeKg14aZn5ipKD4ZrmVVyao6cyUa/vKvRKaEzla57mBNtrFldLXEztz3AAOW6iYuf02V42kU2mS2wVQaw5SDBfqlQKoINXHKkBPb0Ohz1xUK7i7OGa2ifVuzRhoKVhXSwl2W7sepSNIVGF6SlFCUefRu3dp8Tid2VtFPNDEB4fhvIzR92OOGddPKXyJj2ikDxyd8xqe9YhhuxGmG6f5f1FX8spDqUUU54veFhV8WQ7KYeSqSmCmbr7gtdF4kMmHZc1PLRpJN0ftotJsPmdnf/CJ6Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbLkTwsV3y5ZuPa25TkcQAMVe9xbMB3RjYQwiis2myo=;
 b=H2CGM7igyaGFqNmta2i4XBeepW4jd4g1dePYgZoi3jGAWnGzRhy2+R5QVqNaxr3Tij3h7+KIE+QoWH62MpLYcrSHJQg20Nc3pPNGRiwJiatJzV02JhAUs3zTmttxFmIXJN9UEaogTaFx2xaVBMbmBqio7ni+48F8ZX+mWfOpn1OBZQzasFPoJokw5sqwOG3cY26uwbuktdotY/jor5IR2hwUxGH19bQD8HWdFk7N0MlE/+dY6BDyjhPDjsCBn6uAL9rJwdhx7aQkLqDXvkmEHn6Q8ZhAFWTsRtv7ftDBBEeTbNrZzejK1p/+Zru20i1ic+6kp81KgOs/0LFKxwz5kA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by VE1PR10MB3934.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:16e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Wed, 3 Sep
 2025 16:21:34 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 16:21:34 +0000
Message-ID: <4057f18c-49ae-498d-abfe-f7c10153c703@siemens.com>
Date: Wed, 3 Sep 2025 18:21:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [ANNOUNCE] Release v4.19.325-cip123
To: Ulrich Hecht <uli@fpond.eu>,
 Kazunori Kobayashi <kazunori.kobayashi@miraclelinux.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "pavel@denx.de" <pavel@denx.de>,
 "masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
 "chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
 "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
References: <1602384696.84101.1755530487321@webmail.strato.de>
 <42de8250-d98b-40e5-9e8a-d6bbb1ca8b6b@miraclelinux.com>
 <7a864d4e-3051-493c-a64a-cfda61c92936@siemens.com>
 <1208303079.251954.1756910805287@webmail.strato.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1208303079.251954.1756910805287@webmail.strato.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::16) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|VE1PR10MB3934:EE_
X-MS-Office365-Filtering-Correlation-Id: d7bcbb90-1c65-4489-f436-08ddeb05f34d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZVNmWXpvaldqSlp3TzVYY29TK3pXOTJQcFBXOXl2UlRQdUZMelpscnJUekhm?=
 =?utf-8?B?VGh3bys0M2RXS1p2c3U5UDJLVXo2S0llRTZNOTBNUWNsa1VYMjQzKzZWdTgx?=
 =?utf-8?B?OTJ5eHNuWVBGTTJUdzc3SHlWNFV0bDgxTjlKNFlHQ1psbkppODBEU1hsMHc0?=
 =?utf-8?B?b2tLYlFOVDMrY3grcHBPMGIvMC9PRGNKWnZVZjVoOE8rVXExYWQ0K2dwaFNC?=
 =?utf-8?B?VGFneFhQUEk1Y2ovQW96ZmdiQ2J4eThoTWcxRDR6dWRqY2svb0t0a3JQclho?=
 =?utf-8?B?RXJsTDBYU0p2Yk5lQjdqQ1ZsQW5UR2RPQmtkN0kyaXBoenlkYXdaUVBRbHdK?=
 =?utf-8?B?RHhCQTBzUGdwUVlyTEZpZHBwY09kN0ovY1ltb2x5NTdwcy85MHoxZ1lrMDJM?=
 =?utf-8?B?eHZqcTBaa1VWa1QwS2lBY0Zlc1JrVmJrZVFqQy9XZWQ1ZTlxKzRaQUlKbGVq?=
 =?utf-8?B?dkh5L1ljdmhRNlg0dGR6ZjQxb2dDTi84YnRkMzhHM1Z4ODY1SElyeUwyOU55?=
 =?utf-8?B?VTBKYkZNY3ladEVkSmNEWnRxdzRJZXpqcFl1ZFRuSW4vT2V1SmJIQkVnL0w3?=
 =?utf-8?B?YngydGVHRzFCb2lnTENDZXlESUtvMk1NYTRrdE9qckplMklrd3lsTG10b3N0?=
 =?utf-8?B?aExnamFVL2V2ZStZbFVxbjh1WGN2WHBuZEdiL3QrUjkrWnZGcTUrUk55NWs5?=
 =?utf-8?B?RFZNR01pQVI3a3M4K0xHTXBvMEJRRWw0cDBrQU5haUR3N0dLYTdkTk9YL2RX?=
 =?utf-8?B?a2M0Y2l1Rzd5MjlnNkdYaHVqQ29uYm9CaVR2VzMybDcyWVlwTlJoTFJFNVNx?=
 =?utf-8?B?VWtmcXJsaHIvak5TOVV3QTRxcVlvYUpCcVpuaVRDbysrNnpmZFNwSVd1eXRt?=
 =?utf-8?B?YWx0Ni94OHlJYURCVWdtM0ljdGJrRmdkMXlwaWN0Q3hVZThoVDNrS1pCQ1N3?=
 =?utf-8?B?N1piZU45aWh1cklyR2kxR1U0eFROSjFYWUp6Z3diaU1Ob21xanplN1d3N0dt?=
 =?utf-8?B?dUtsTGgzSFY5TTZpN3dYVkk0NUlWY2ZiVXpmWmJ6bURibGJrSUFmaUdqNTBQ?=
 =?utf-8?B?QXlaRTZFM0FkZFpMS09ZTWFsbHBQYkViUUVmUkE2Z1BNUmtIRWRDWmkyVUVO?=
 =?utf-8?B?ZmlBOHcxMVNSeXI3clRRQytLaUxHaUpCN3NMcmdBWGVNeGFReFhBQkZldk41?=
 =?utf-8?B?KzlEbGxDcUw0cHpQL2ZvaVVVbjlqN0dna2pRWVRqazRWQjg3NmE5QyswV3RD?=
 =?utf-8?B?R1Zzdno2Mllic1hOd3E0cEdnL0RJaks5UGJ6dGdJZ3BZbjhoaTZBSDdkc3pX?=
 =?utf-8?B?aEtkR0Z5V2c3K3YxUzZTTjlpVHRQaXI4OCtqZEhiVFYwLzJDWlArZDlmWFcx?=
 =?utf-8?B?Vi9CblBVSXZoa0ptRGZLdjU4dDJvd2l4Um1iZENOWm9kd3IvNmNmeVlMT2Jh?=
 =?utf-8?B?SzN2cXJCS0EwQXpsMTF1eWlwWUppTzFQUkp1Z3pXTlJCMFBWSC8rK3dQSnEy?=
 =?utf-8?B?RlY4VmNac3QzblBUYVo5U3lFZXpKcXlKRmh6ZjJKSU1HZUhTaklMVklwRGYr?=
 =?utf-8?B?eVg2VEd2OEhGdUpiK05Mbk1vODNHUjNTYS9haHFPNVUzU0xwNXVrSlJiVVJ6?=
 =?utf-8?B?a2JZQW81MUJ1anJRTWRiVkpERjZYMXRQYnFqR0M2NTZ6QitmQ25vL0VvVTJ2?=
 =?utf-8?B?dDg0ZEVySWh4VDl4NFZXTzdzamxXOG1leklYcnRML0l3dzlLV2Q1UHhCVHQ0?=
 =?utf-8?B?cUphOUhWaG1NcjlBMHB3a2pDcGZBdXg0Yi9YQ2hka3BpWmNmS296K2h6anpJ?=
 =?utf-8?B?UlRLb21UL1AvcEFxcksvQ3RyaElmY0FRYXRpSnI3NHg4SklKcWs4YlZEc25Y?=
 =?utf-8?B?cXl2Wjl4L1RMTCs0Sm5QTW9Cd2d3cHA3VEJ4MW1zeFArR0E9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y2tHYTRzeVplUHg2WTQweXJLWTlleUh3aU5yVkthTmlSVG4xTnAxMlpGZ24z?=
 =?utf-8?B?ZGRFRnJWS2pCdm01Vkp2QkNhSmU1a0x6Um02cWo2dkJKU0ROS2pWWWg4K0Jj?=
 =?utf-8?B?cFFCUlgxNFlNR01naGcxblhEK3VDcDlIaEwyNjRaZVpUTEtBMkpReW1PV2pv?=
 =?utf-8?B?STRxWVR1VjN6UnQ2ZXBPcVJpOGhqL016MzNIdEVEc0VOY3hCeUJMSjRnckx3?=
 =?utf-8?B?VUJwVVVscHVGS3lReWxpeWJhdDF4bWdrTWhud3B4NDJzTGgrcmU2a3NkUy9P?=
 =?utf-8?B?R0Rya29GL24rMVE5MUJCNGRqSGs3RXZBb2EwM3RQMDY0cUlCQTRETWJQMFJQ?=
 =?utf-8?B?ZVZKSjFPaXdmNFdUcjdnSWR6WUJwa1FhYkROdTMyR3JZdXExVkRzUit0Nml4?=
 =?utf-8?B?U1JTN1Fxd2hPZ2haeXdhb2ZDYXpWOGcrdWpSVWN4czBuTHozMzdtck9HYWY2?=
 =?utf-8?B?S3lYNHN6bitJRWVDLys1MzQ2ZGZQeUVGWGphSFZOeE04TjFEd0xSVE9TVEpz?=
 =?utf-8?B?Mzc1TjgyaklSMFdJTVU2VlE2c2xPSCtmNHcvRWZZeEVYZldNdDNKQjUxY2JM?=
 =?utf-8?B?YkVSVDFOYlMyMmtMcTRVMFhtSnA5TTdWVFRBSCsvTm1yVXFXMmVCdWJvWDYw?=
 =?utf-8?B?UzlJOEpRTVhibUxEWUltd1A2OEtUVGg4UDNXeXkwZUkwT2tTZDNXWjhUNzA5?=
 =?utf-8?B?NjhYanVDNitlZVRzZ2M5RDd3MFFZYXkzcC81dU5xZkIrQkNvZ1dFWjhEU0tl?=
 =?utf-8?B?U0xCb0RKNTgvd1ZoZENYVnJHN2c2WVpTWnhLOXRnK3diVEw3QnpPY201UzMy?=
 =?utf-8?B?TTBvN201M2h0WmxuMG5BQUU3bm1SdThOSVYwYzBJbWdHbWpNRFlMeEFkV2l6?=
 =?utf-8?B?SFlKdXJmTE9nRkhqd3c2VmkxbWlHQUY0L1RTblBzd1JqeDdzbndYYUF2V0lh?=
 =?utf-8?B?N1VtNGw1WDc2S3JFbE96RHdRNVNQYmRZR1Q3MXFqeXlWSUh6dHZrRjM1b3hs?=
 =?utf-8?B?dXlacWEvb2RHOTFCS0JJUjlyS1ZlOG0vSkkxc0pUVWIwOFNKTyt0VnZxTERm?=
 =?utf-8?B?VlpRTWltWUlzMkV6NUpVbWtkQWdZdFJ3THErUkJwRUtwbmZNZW00YUtUQ0dR?=
 =?utf-8?B?d1JFVFZiVVVEWmZqNjRXYTBDNzhab3lrQTAxdWFkYURrVXZyeDBIVHV6eHdQ?=
 =?utf-8?B?dnZQQXJnbGNUaG5NSXJvcVlkQVphclFmbm1KOVdZb0h2ZDlJV0Z0MEpJUURV?=
 =?utf-8?B?WmZpY0hsVDUzR2lBMExRTDBGR0hPRjJCWkd1Z0JwbEN4K0xmZGVTci9SeFhw?=
 =?utf-8?B?b0Y1b0VTUENid2N5eEtIREQ1bDF3MUxScHd1bGhKNkhZcHlieGNybWc3Ui9C?=
 =?utf-8?B?ZndPNDR0aldUdEl4eWZaWTIwOFNuSGxoOWxxSjlhNzZRUzRKRnN5aEJTVTUr?=
 =?utf-8?B?M0JMK0t2c2xUa2twOGlxYmFNYUtic2NmTnFFNGZvR3JvaWUwcTFFa2RTZ1BP?=
 =?utf-8?B?MW0yN0YzZ0RsT1FhZzZxN3NOYnNuWFZaOVhncUo0a1pKUFZZQTRyYkd5S2E2?=
 =?utf-8?B?VW9MdUcwZEV5NCtobk41YWZuQXNxNkVQelRBS1ZQS0VGenoyS2tEcFArK2lN?=
 =?utf-8?B?bUVPTk9SWUVOV3UrMVdLdy9yZ3hZMFVnV1RHajd2M0JhRmdlenJVelplanU2?=
 =?utf-8?B?aFh6MUsvbHBaaVhmN2tUTncwQmx1dHJtOWlJWFoxTVU1eC8rZzIxMS9yZWRx?=
 =?utf-8?B?SXZzRDVFUmhvMGsrYkFHcFgydGppR2FNRlJibVV0U1pzNzJBaHpkVWVMZmdW?=
 =?utf-8?B?ZjZyMzVQUzBvZWxITGFXS2ZSampiS0Fwbk5QajZBVytCb3VNQzdLcXdxbUpG?=
 =?utf-8?B?TjVsTXdkOExic0s4SEJjY2JTOHd0R085WjdWTUk0d1hRMXJFWXBtQTlYeWUz?=
 =?utf-8?B?ZDYxU2RZL2phRXdEM0w1SzhYait2Z1FrTU1XWlBjYmlaTlNod25xQkErZkRK?=
 =?utf-8?B?Y2ExdHdJOU16WFcrM0w4Mmt3WlkzVG0zZ3NvbzlrWGRWVU9XZ0ppSjgweUdo?=
 =?utf-8?B?RFV4Skw1TkZaWDRLakZDVlN6UFdaZGJ0V2NINUdRd2h4cGhNMENjMHFuc25P?=
 =?utf-8?B?K2M4K2V2bi9EUUlUenZCdThyWVhtT0loZXJ6bnpqdUFZMkVnTmViQitMUjZS?=
 =?utf-8?B?YkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7bcbb90-1c65-4489-f436-08ddeb05f34d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 16:21:34.7818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8GoHDIWUn6NmDYSfuyt3KflGO3MrcHS+5fmMryLgthXQ7C1bGFLi1TIC2TdDU7/cvN+1U9o9IUFTh+A/JkYYAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3934
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Sep 2025 16:21:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20000

On 03.09.25 16:46, Ulrich Hecht wrote:
> 
>> On 09/03/2025 12:36 PM CEST Jan Kiszka via lists.cip-project.org <jan.kiszka=siemens.com@lists.cip-project.org> wrote:
>> General question: Is that build breakage above not triggerable via the
>> cip-kernel-configs?
> 
> CONFIG_VIDEO_OMAP3 is not enabled in any CIP configs.

I suspected that :) - then it is formally not supported what is likely
not the intended state...

> 
>> If so, you likely want to make sure that it is. If
>> it was triggerable already, then we should try to understand why it was
>> missed.
> 
> We could enable all the defconfigs; I think that discussion has already happened some time ago, though I don't remember the outcome. :)
> 
> I keep a bunch of local configs that cover all sorts of unsupported stuff (m68k etc.) that I build before pushing a kernel to make sure nothing breaks needlessly. I have added omap2plus_defconfig to that.

My point here is to remember everyone that we are formally (and here
also practically) defining our support and test scope of the CIP kernels
via the publicly available defconfigs.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

