Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8537AE91277
	for <webhook@archiver.kernel.org>; Thu,  5 Feb 2026 07:01:29 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15373.1770274882712690120
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Feb 2026 23:01:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=L2gKPEvD;
 spf=pass (domain: siemens.com, ip: 52.101.70.42, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iM4kI/ADit/StmIaw+f3F3WhJzDQ6fwJmwOEYJRl+yzql/JTNlPiREfnDcXsN5YDeEKC7XlMJLMa/MYAEZHRNXLqZNJz0osH4WqYabFRu8ek40J/v1xxRNwJDHQe72C5Jle+HWqHhq64aAttASBj+Uu7A9qYm3vXw0zNi6mUquDY+nzW9SjnedPOyrTIXQNpFXMh0O5DS18ddwYHsqpUo+fWfrXBcCF7ZZZ0cHQuXvffpkLz3OZQ32eZzBzRdE3MKpEBn5z5pxptOL+EnX7nOvFXOhsU8NqewJczCwpkZOJEAkvvlIKa5O+cp3TynHVkUkN5pDXochArP9MOtH1i6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZpePBvgazbKE6zr6g0oTOQ+J7snFtIO3EU2xbzSY8E=;
 b=kjgCiMN3YrGkSkXFNlz1rc4BMNyC1kwPDT+4WyZko+/91YVVIc/gCvnz9PMegNeJXy450CrT0f59pMZdeNURgZIWm1MRuCy9If4HtTFwzzMqXjq7AgQWl53qmxpPvvH+J401De3kPqbc92JIodiBxzSgQbaJ9Z0M3MTUD5r/cg4jp6XaA3mLgXI3FWCykxipiE3lo58P0RUIqcu1oMhNBv0hFIfXWCKOhNY+Zm0+JxdbHGAiI3tuhlpdRi/Mn1r00U0Iy+a+OjsceOaysSqN5LvuG4l0hgvuo446Svn781PITBz6szy1QXau3RhxNCPcS2POoapd6mc1X0lEcVyrYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZpePBvgazbKE6zr6g0oTOQ+J7snFtIO3EU2xbzSY8E=;
 b=L2gKPEvDW2ZYUDl5cqKQ+jWBogkTc1xeih4K8lXzQIcpolFhUwP1UClP9MNP5hD9nmBbG3DUsYxMiHruV0KypN7oIJKVm9gOKDG27bdTLYpNxoNGYFBm5dxXaaehIBCmNAf48YoKSs/eYkOvxv96Nu9KJ35UrQHL1QvQDqLp9gmyq5LFSjEXUP2jLZ1rKPzwDwwYbi60CM1np7LkTz+wToo5Z6DEAZr2d0Nyd22steaAVh9hOv4bTr5JtzmVQwdE4ady8oYBQoKl0z2qTi/eFhjCDkoCWi5cSyTzKAMH6UiT2AFGTAKbbMXdkEICroq95LfzEoyhhWUh1HZNBxXQEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PAWPR10MB7720.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:364::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 5 Feb
 2026 07:01:18 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%5]) with mapi id 15.20.9564.014; Thu, 5 Feb 2026
 07:01:17 +0000
Message-ID: <584f457b-2d06-4074-9f0b-22d967f11847@siemens.com>
Date: Thu, 5 Feb 2026 08:01:16 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::9) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PAWPR10MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: bac87a20-3c2c-4771-53b2-08de64845c18
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aWtCQnB5dXFVazdvekNwVFNrRGZWL05wMGNRNWFLNXArMytXalhKUlRLSEo4?=
 =?utf-8?B?ZzFDOVJrMHhKdDVqZ2pFc1lnSEJXMjE3d2Q2Q3Y4cml0L3dTNHpkb2wzNFhm?=
 =?utf-8?B?a1k4MnRERllvTjFBZUZQRklObWpXcXhOL2xZdUZ5TXFBM3o1dys2SjFOSGJD?=
 =?utf-8?B?SkQyZ29QWEF5RjcyOStMaWlUd3B6TVo2V01NQStjTVc0NGwxQkFvWlFDbXF1?=
 =?utf-8?B?bkRyRE0rSHNsZ2krbDZwOXdyWkFJakxrOG5nMVVOZWludnRJMnkrMnhoak45?=
 =?utf-8?B?OC9OUmUwUFJlT0JMTUU2NEdidE1MWS9UMTRESEt1TTUvR01Zb0hKa3pnc2FQ?=
 =?utf-8?B?b01Cc09jZlFibWRDUTNaRXBaTkJoTkJYalhTWjY4ZkgyVGE0c1kyR3kxQzZj?=
 =?utf-8?B?WEtzVzRmNWZySWhING1pMUZURVphQm94N0VhZUF0UDdWQjRzSGxaSGdvbEtH?=
 =?utf-8?B?R0NISitGMzErOHoxTFpBZFptUkgyeUdwNnZIVlZTQnhjbU9teHY1Y2kvcGRQ?=
 =?utf-8?B?OXpPZ0dqZVFPbitERTVpQ0hZdlloclZqU1VqTGVjUzZVUERNSHVmbFFvODg0?=
 =?utf-8?B?cUp6YUVnZE1VUVdUaUJCMitSOGhzRW1sUEV2N0p6S1ozdUpPMm1qQXQ4emty?=
 =?utf-8?B?MlNOak5vSExXKzB6ZWxHZDJSVjRXcjZQTFJlVWl2ZlZJQ0hCdVBtaFVKMm12?=
 =?utf-8?B?NjYrcFhTell0eDBaT1hTY3VMSzZKYWFKaGJrNXArK2RVZEN3eVhFVVBvTm9s?=
 =?utf-8?B?U25uMzRSMVBndmpURXJpbGdXZkZTSnk1eHdHVUcvRjBWTjhEMkhzN096RUt0?=
 =?utf-8?B?RHgvUEZlUmNmMldibDBwajBnNUN2ZUIxYVVRcVJTV0lRZTRLdnlYZHVqbUJD?=
 =?utf-8?B?UW5QOUh2dXNPK3pzUitvNEh6TXVTRlNZVmR3c2J0TU9BOHBaOFZWVkwrZ2M0?=
 =?utf-8?B?VTNWd2FWbzhyWHNXamY3SGFKYUt2SUlKZkhtK0FlS3o4T00yYytxM2N3Y25E?=
 =?utf-8?B?R2dmbHB4TjgzMUduVEJmajkzMnQybDB3WU52dStGMjEzYURvM0phWWpGN3RQ?=
 =?utf-8?B?b0ZNL01TNGJUQk9Bak5BV1RpenpwNlZPWGd5OFZ5N1l1QUZzRkxZRHlZMHBQ?=
 =?utf-8?B?V3VGdHZuRjhBUjlLTDZFZHVJT1RTdnRaTGVVeUZVaWU0cTRyV0hpOWs0L0Jy?=
 =?utf-8?B?NmtkUWI1VEhmQmxmakFCREZ2YjFNMkk0WlNITFJXeWppS1pCckoyNm1RUW1E?=
 =?utf-8?B?M3h2V0g5TmluMnlXbDNMaDh0djNYYlJzWW1meUliMFdKd3k3MnZJdXlIU1Na?=
 =?utf-8?B?b1lyYzMwUDNYR1RWaTNrL2RWKy82VmFlWGlnWUtPbHlJenNWaEF2dW03dS9M?=
 =?utf-8?B?TmpTcGVUd3RWQXI3Q0JWTTJiMVU4WVh0aEFXNEx0Sm5aYzhwUWFUcUNuVzZJ?=
 =?utf-8?B?d2J0RStRSmhxMTRXeFJ1WDFCMVE5SjVyVThmcFB2Slo4WVNyOWlpeGVsOUFC?=
 =?utf-8?B?WWxFS3pRMmpHZDladmwreWgrcmRnNm10U29DYnFkMzhELy9tNVVIek5zVUl5?=
 =?utf-8?B?bmtuYlNDa3Y1UlB0THRSOWY0WkxDNE9xSzlTUEFINWM3dWlIMnd5S1BMSDA4?=
 =?utf-8?B?b3FoWGhMcFovRDlVTVdrNzUvMS9PMlF4VzJuQ0w4V1RSWDJsTjNTeHFZMERV?=
 =?utf-8?B?Z25xc2s2Q2QrT2Y3SjZKQ0xUODFCYW1rbzFLMXRoVCtwZkpkVnNRNnpUOXZ4?=
 =?utf-8?B?aXByUDRibUZiOFIwTTltL1RjL1Y3ZmM5aXRKMW1pMUo4Nzh4WmNFV0lEaUd0?=
 =?utf-8?B?dmdPbDlMNVpWaTY4TWxXMThQOWFWUlUwQjVuNVE1Z1oyUWtMd2h4SVV2R0d1?=
 =?utf-8?B?YnVwdmg5eElBVUpkVjhpeks5UUNnTWR3dHZjL2Z6NHVnUCt0dTZSSnp6OWRv?=
 =?utf-8?B?OWw0M1kzZ3RsTDRGd0RjR1RIV2N4bElYYVhxOVJvQ2YzV0Q4Nm9adENLdVFj?=
 =?utf-8?B?ZDMrSlliL1U5Q0VUY1J4OEpzd28vN3gyRWNuSVB1bFdPVWN2bmJQazUxa2M3?=
 =?utf-8?Q?ubS1yO?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a0FVMkppYzhUQXVVQUFVNVk2ZzIrVUV2M2VOMDBpSjNHWVZxZ3JpV3RCelEy?=
 =?utf-8?B?ZkI2aVZhNXZrMm10T1B3TWNCbnNQdjl1eFluTzh3YlE0dng0THJ0QnMvRU1r?=
 =?utf-8?B?Y1JFVVNJblFPNXlxaFBMdVRNbFl6azVMVVFUWEhLQ3lDeEg1MERtd29DYUdO?=
 =?utf-8?B?d3dHSFRWMGZTaW40aXJTbUppVUl2cTRnU3JSTXY0RTdnNlJZZk54cWRFOW11?=
 =?utf-8?B?UTNJUmo0aEpZUy9NV1ZJODdPTW11dHQzNGJ0Tzgza3lpZlNDOWRYM28wUlBK?=
 =?utf-8?B?WEtiYzJkakhuVlAwWWdUQzVtOUhvUWZxU2pCOFNmalMwOHFYQW92cFpWdGs3?=
 =?utf-8?B?c2x1WnFPY2JsK0RHOHB1czhDZlR6bGNQNGpjWWRSK1ZPQ0N4S1lpaWRqVzNX?=
 =?utf-8?B?U3lpS0tYS1drSzY2MzE2eSt1OUhHYjJIeW9kWlJzYjUzUWlDSis5QzhWaExN?=
 =?utf-8?B?d1VtbFExdVcwQVU1WkVVcGZLdDhMMGlHRVJCSDB6YkZLRTVmcGJNbHU0MW5E?=
 =?utf-8?B?T0pPNERmM0RTZko5WXdzWGRwclZieTE1ekFycEdpbkZCKzJQS0xiZVErclpG?=
 =?utf-8?B?NzJkWUpScjNJeWJPek94dHhLNXV6M3d5WThRL25tVVJQaExqS2pLT3FPN0pQ?=
 =?utf-8?B?R0ovMllIbTJOM3ZUSDFYUjJTMjA1RTZnY2QvaTFudmpOQ3BLcnl2VWZpdUtk?=
 =?utf-8?B?VVdaV0NUYnBmMUM1aWFuc2lySnkxVzJEaEpIbmpNM3BLOVBjWERVUDRLQ25k?=
 =?utf-8?B?bGlpeGhnSVlVdHNyd1NDT1krbXk5SndpV3lDNmZueXoxVHRMbFZKaVVoSXFV?=
 =?utf-8?B?blk3OFRNUVE2ZndvL096WXhtMGVJd1FUUVhnZnRkZmlBLzVENnZuNHdFYjJu?=
 =?utf-8?B?R0VDOGxNZ3doVjUxRTM4cjN6eGxwOURCbW5DRGgvcUJ5amozUWkwVWkzYit2?=
 =?utf-8?B?OEpOTGdpQktCLzdjL0dSeTNPbHFkTlFLMnZUeVI2QTVxYW5uZkVCdmtoSlpY?=
 =?utf-8?B?TVhybitBME5ubkMwdElSQllPaW01dmdFYVBhOUYxZHRYckl0TEpERDVlMEJD?=
 =?utf-8?B?U0hVTnBKV3IvNnRNbXQvY0RCa1c0SjdwYTBBelJaNkJvMjg3dDBKajRoVm1L?=
 =?utf-8?B?VG1XMUQ1OUdGOUo2NnpGT3A5eWg4YUFqeDN3a3BHdktENXM3TDVPWWlFdWs5?=
 =?utf-8?B?S1JjbzI1YnNjbGFmMHFsNDV5ZVkxSlJiaUxTVkQ0VkdPSllNMDNFdkl1ZVNP?=
 =?utf-8?B?cXE0SHN4eDhMYjBpK1FDMExHTUxnY2NObjFRMElGVXlBZFMxS0RQZWkrOGha?=
 =?utf-8?B?NytGVHY0dTZCeXFpczZ1cWl6T1RZL3p3V1J4aTBTQVpoSDdmOGJrdE1zVndB?=
 =?utf-8?B?OXdSM0czb2pwelZIL1JJUlhGRTVNR2Y1WFpiMVRmbFdKOU9hVktkbDhhMVVm?=
 =?utf-8?B?SksvcVhCZGZXUlR1SXBMTC9NM3lqYTZETFJRcGthc0FacnhjaG1CZExMUGd3?=
 =?utf-8?B?djZRVGxSUllnZE50dlAva0toSTRac0c3bzkxMWRTSG9ESSsxUlpaMUV3c3NC?=
 =?utf-8?B?ZVlIbUM4Tk14YWV3Rm9xRGVzZEZXMFdORlJ2cHdKZXJDY0UyTzRoWnliMllo?=
 =?utf-8?B?MWZpWVZKTjlXVjVnWjRIZXRrbjBCLzJCa2ZLb3ZXYXBJOHZMODF3ajcwb093?=
 =?utf-8?B?YnI1TTlMWGx5enlGYWtrVExlUXNOTmZTeFJTcjBNVDh0RU5La0RMa1lHN242?=
 =?utf-8?B?clA3cWhuK3NtdWh0dU53OEdTS1pTcjJndTV2TWpUa3RRQllGY3J1WG1TeWFq?=
 =?utf-8?B?YXJiNm4vRE0zcEZ4RFRVeVduOCtkSlFTSVdWR1haaGVIN2kyNll4amZUKzZP?=
 =?utf-8?B?cVV4dE1uQ1ZDREIya3RON1NOeDcwYmRIRjJ4WGJabVpESGFaK0dnTmZ3bUl3?=
 =?utf-8?B?b2lVdWpDdW5rQmVpa2VaU2FjeVJsZ1kwZTlGaFloK0JubzlDY0hWTzRtUFZu?=
 =?utf-8?B?b1pBMlJtc09uUjJPQ1lMMjU4N0VHTXE3bzY0L0gxSVQ4bzdHKzVhYzhraGlR?=
 =?utf-8?B?S2d1d3NSNy9kd0ZydllnejRkQjRnM1RCcUpoZjh6Z2Z5dmY5Mm40ZnlrQnRG?=
 =?utf-8?B?ZnJDL0p4STh6bjRGLzF5RW5WK1RNZjA2YWNyRy9tZnd1dy9hZFhJckl6d1Vt?=
 =?utf-8?B?Z3NTdVlzc3BibVdWZkN4b25UcldnK3p0T1h5c2NZQzYwbFRFUTdUU2xDVitU?=
 =?utf-8?B?Z3BSSVptbSt2Vys1U0gveWRnbEd1WDNqTVZoR1dZLzZoa0dqWTliZEw0Y0V6?=
 =?utf-8?B?cVVFWS9vMUJIVmRLbUJEYmVwUGZGU0t1S2U1N09uNkVHNEQ5NmNPdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bac87a20-3c2c-4771-53b2-08de64845c18
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 07:01:17.8858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NOXPhzS6MsVVimUY+YsJwTGmxRvh6Dk3QNi0TjwCY+xXfTpcjcvgRFZWBsn4h+U7hvOebyQFnhizrFnJnKYXwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7720
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Feb 2026 07:01:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21832

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&month=2&day=5&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
04:00     07:00     12:00     13:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/01/cip.2026-01-29-12.01.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
Date the data is created: Thu Feb  5 06:58:13 AM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed Feb  4 01:55:28 AM UTC 2026
  limit date: Fri Mar  6 01:55:28 AM UTC 2026
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Sun Jan 11 09:55:11 AM UTC 2026
  limit date: Thu Mar 12 09:55:11 AM UTC 2026
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Thu Jan 29 04:48:14 AM UTC 2026
  limit date: Sat Feb 28 04:48:14 AM UTC 2026
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Wed Feb  4 10:41:33 AM UTC 2026
  limit date: Sun Apr  5 10:41:33 AM UTC 2026
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Fri Jan  9 05:02:19 AM UTC 2026
  limit date: Sun Feb  8 05:02:19 AM UTC 2026
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Sat Jan 10 07:38:46 PM UTC 2026
  limit date: Wed Mar 11 07:38:46 PM UTC 2026
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Fri Jan  9 02:26:25 AM UTC 2026
  limit date: Sun Feb  8 02:26:25 AM UTC 2026
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Wed Nov  5 06:50:13 PM UTC 2025
  limit date: Sun Jan  4 06:50:13 PM UTC 2026
  Status: *Late*
linux-6.12.y-cip: interval 15 day
  latest version release date: Fri Jan 23 06:50:44 AM UTC 2026
  limit date: Sat Feb  7 06:50:44 AM UTC 2026
  Status: On track

