Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0087C2D0CB
	for <webhook@archiver.kernel.org>; Thu, 15 May 2025 06:15:26 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.16])
 by mx.groups.io with SMTP id smtpd.web11.6643.1747289722362013600
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 May 2025 23:15:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=JMdAjfaY;
 spf=pass (domain: siemens.com, ip: 40.107.159.16, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DmfBDKrAKxfv74882gYycElVhyOoVJ67iFWoaDvdYc5zYPkNFkxFAQW1YWfkJ64mqTmg+Vv+hXpZpBm6Tq1pyp5QfcMeDU6nhBSuad8+FpDpjSXOPeRXp8h9XU5t2OFi3dbC5eMTbPLCBjctqS2C8yZ/Rzn+0TEWC/3/LQwU7ls81ft+u+B7swOiyTiyXLkT77XjqOH7k/KO36q8ViRHhBBpZoST6kSb8KpbNfxhbGhSwDOx9xzl15DxB9J4IkeuvpRxXXRWce9qNz2SW2Xl44wNat9+nDTzvQAxMShvnJQAgNdFjwQUE9lvFslM9VRvMG1nNFXYGSHlGe1YPk6hkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMhVs6njY8mHt6SwYG3rGRhrjhR5kl0v6UWQmtcYiEc=;
 b=TCsABW6Nj16lYiCYiCztfRoYhBEhByD9zNjPyH9Ev7eMNbmgpR73zZuktrNZP8yJQCJ6TbmAF7gh/AEFCiEiGj2O8i/qjLOl62fGQBu8vkfgQOJ0ykUvynzx3cOOUimZ/O/RibY0xQHqnRRqE3YPh7PCKof4fqhpZQAbnF3jHT/Qe1C7LyI3W4qZhGQkkEYDgCQzmksSDJuW2QTBP7SH88JaIXbTnJ8i67kZaW2LgpSHqmuEDK3ifYmtBCKAaiI574iZDBub4X7wm86fLCjnYVNY+Vxbci8DdVHchGT4KmMaaFPTszcfLLgMdedtr5TN0UNJsrP/f1KvHnmZ0znChg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMhVs6njY8mHt6SwYG3rGRhrjhR5kl0v6UWQmtcYiEc=;
 b=JMdAjfaYQIKG21LnWE2IFQAswB7VoyxzqvW021b4DUPyDk8bVf0gKrkvVuWHH/pGqSUFiXp78sowTsRLUrC7Ie9ISzfP9AQUIaGWZAEEu0+G9sTp8iLfLgjAPhUlQjThEgpWFWmvEqi1gPkdjzEbkISBLklvEfu6q8hjeVuN4iMmopHnSB5vCXJZk4NrW64GiwH1MOyQSA/PXBtVj2ZJW0s69zX4ohIhHDCOi6H5BLvXCd3KT3x5Gng+JOxBO0kUlxht9iZLkA/BLywYCNRCmbjNC5HL4hcNayH5IdTkQi2oB7ryDoU0hvfhSun8ndao8VBS1T45DSOLOTOwQwPvZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3955.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.26; Thu, 15 May
 2025 06:15:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 06:15:18 +0000
Message-ID: <61802c21-5f90-46fb-84fd-f19b4bb592f4@siemens.com>
Date: Thu, 15 May 2025 08:15:17 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0374.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3955:EE_
X-MS-Office365-Filtering-Correlation-Id: be57c0a4-0557-4308-d16e-08dd9377dd5e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TUpsZUExcXNhOHFNTHB3eit6aFEwWWpjTWxzRmxGd1hicURDV1JzdXhoditI?=
 =?utf-8?B?WkxrZyszU3phYmEyZkgvUDhrb1AyS2ZaTjZ2Y0FtOCt3L1l1elFMWHRUU01R?=
 =?utf-8?B?bEF1RTQrKzFRbkNsVzZORytXL0M1NmFZOWxzTnJiR3YzSXhQMENmL0MzYnh2?=
 =?utf-8?B?eFBGSHFVVlc3SlpYK3JzQ0gwQ20zeDJEN3Z2bjVtb2lySWJWc1RXQjhRMG5S?=
 =?utf-8?B?aGFxZURHUGJ2bFlZdGVyS2VsdWd1V3ZmOXB0bmpobCt2akRvcDc5c2xqN3BY?=
 =?utf-8?B?K1JaTUd4VWphNDY4ZGRUQXhlKzFSMFlYaFZPWWcxemhTMmhhN1FSZGU3L2JE?=
 =?utf-8?B?KzhOTXdqMmYrbFBad0JKWk5WMlhudHZmd0lKaThWeEpwOWdveER5dVhCdzdH?=
 =?utf-8?B?Znk0bU4xaDBwaWQyUm95ZHovR2IxV1I0eHNPVGxvTzRwSGRSUHJQNVZBNkZF?=
 =?utf-8?B?YUlxNnRaanpSUk5nemNVUGY4WUM0UEJiUVlXamtBUzFycTNLNG51YVo5dGVs?=
 =?utf-8?B?VVhZaFhHOXIyR01hV0dwVlExdkpvSmllMzlxZzJHandRN1dMa1FPTm9uUU9Q?=
 =?utf-8?B?bXlHU1hXU3FmOGIzd3NXRUlwUnliMytpTWpJTWtYR0N2ZDVram1HTTVBQ3J5?=
 =?utf-8?B?U1ZQWGxSNExXZUJaSlJIVTYxUXdJMGNPTXlpelJXRXFrOVZ3RnlSOEVkL1ZM?=
 =?utf-8?B?OXVjeEZJdE5rdGZ3SGw5Y2w5SlZrYnVMRlIyZUpxLzc5R2NrTFFaT2xBZVVi?=
 =?utf-8?B?eS9oUW9BVGdsNWg0M3MrY0lMZ3U5ZjhDTU5ZWGZaR2ZuNXNaR3FXQUU1a0pM?=
 =?utf-8?B?MW1iMlE1V0F4a29zSExnOEhUc0NsSStLNVhiNzlvY3doUm5yeldqelNmcmpR?=
 =?utf-8?B?K01PbU9CYUJkNVplZ1FKTkVRK0hRZzRYdnlDa0J0eXFJMGRkaGl2RnNsSUFl?=
 =?utf-8?B?czd0c3RTS0FEZzdRS3hBT2dSczljN3ZpK29BNFlIQzZUR3ByZXh3bm1vME9u?=
 =?utf-8?B?dStsNXVQZEhreEdPMjlnWEx6WDdKY0tqQVpxNE1UYW5xZm1KT1BFMkwyaGhO?=
 =?utf-8?B?OFBTUXhVWTFNS3lxSU1xZmd0ZGJuSXVRek13REQvekNIcmJtdE9Ua1R6ejEw?=
 =?utf-8?B?WWhGcTZ1VU5Va09Pc1JqbmhzMEcwWm1WN09xZkhtMVNNTTJURWVZeVV6OGEx?=
 =?utf-8?B?YlFVOXhxQXZzVWtoUzRURDIyMG5WdW94NXRlMitKV09HUUNBc0w0OVZIcVN4?=
 =?utf-8?B?dnQzSHZodkEvVlA2T2F6cTZmdnY0UUxxK09GME8rOExZa0lJaXFZcm0xcDFv?=
 =?utf-8?B?RWFwVkx5bTdiMGN5bHlPVXE1SVJDcWovZDBxTHhiTmVab3ovanlPZUY3L3p6?=
 =?utf-8?B?NnRiRGNxOUwxVGlsS3NOQnhXc3JaeHhHVWR2NHRJeU0rOVVRenJ1d0kxWTg5?=
 =?utf-8?B?SWtKdUNRM204MXlpOUkxWWtxb1crS2VMczJOVHhSSW82cVVMaWJEblNna1Fz?=
 =?utf-8?B?UFpaZzFUdFdEd01QemxZNWV0OGZDTXgxV2FQM0hqMXBaOG5jOFlJNURvNlI3?=
 =?utf-8?B?OEd0eEg4SUhrY1hKQVJYYklzclBVVDhPZEcvSGFXU3RBSUR5Wm4yVXkyeXlJ?=
 =?utf-8?B?dW9RcHFSc3NFeU5oeERaMTk1UWNLbVZUY3lrVm13U1M3dEl0cU8rOXVubmZM?=
 =?utf-8?B?Yk1FSVpWQ0RmWlkreUNMeFdFcmJ4eW02WE1rNkNzMmxaS2YwS0VVbEFYNnR1?=
 =?utf-8?B?SzFmTDluVmlPQ1FVSm10VUJiWloxZ3FFZGxqbzdPVEtqWkM3RDhPRWl4UFAr?=
 =?utf-8?Q?inYV0xbPdTMCIOu4XjTsLALdkDOgEc3RG2x8A=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YVpxWkFFWlc0UzFZYzVublhEK3lJRlluZEtTeHdCR1psR2M0clBKU201MFYr?=
 =?utf-8?B?NkYwWWh0NmFIdERoSVRLd29kUXA4bEZ1dkN2ZU8vencyR240V0NXa3lHdU1i?=
 =?utf-8?B?Skp6aEMzVHpOd3l6UlNIWVAyUVEvbmVuQ0FCV1lESGp6MEN3Zm82cjRDSjRa?=
 =?utf-8?B?T0dQNG1pUGpyMVpWNTN4cGtrWTIzSzN5YkNMWlpnRVRyMTdyRVRETTdFN1Ux?=
 =?utf-8?B?MU55d2kzOTNEbzQ2Vk83QmVFaUI0ajdvWkt1OFVaK0xJZXlNYzlXZWlDSEdL?=
 =?utf-8?B?d0JVblZoNWpOYkROWlY2VGFCVmUrZUIwNUo1bkRxa0lYNXA4emkrMnFUdS9E?=
 =?utf-8?B?c1BLbEJpK0VxaDJXdWRlNUxQL2hhUTY5dUxCemVFVk5VTmtZNVQ1OHRKaFla?=
 =?utf-8?B?Vzl2K1dSQWZNeTBVZmVjb2d1d0M4WllEOHFpT2lpQWNYTVN6RURCa3Jtc2ho?=
 =?utf-8?B?RGZSZXEydDJJRzdCdjN3U2hOako1V1lDaGZDU2RDeThlNHNpMXorTkhXdnpm?=
 =?utf-8?B?OW45K0tLc0YvT0dZOVF2dHFNUm5LalY4OGF0ZjVUSklta3NEYnc0eWM0NWgx?=
 =?utf-8?B?aGtPcENDYlUveW9ManFieEtMSlVqb1FqUEdpTGVBMXBnT1ZoSW5rZm5jdlB2?=
 =?utf-8?B?TmFTZm5qVXQ1V1JZTjdrTlpxclZTZXg3N0w5MnE3MmVudHpNKzNydHZkbVlU?=
 =?utf-8?B?WGUrVElzTnZXc2JKUFRCK1M1eGVvKzIva2Q0bjh5MGJNR29HTkk4YUVyZ3pJ?=
 =?utf-8?B?b2EwdkxDUGc4dDlVMlExeFpVNlB3ZjFiMDRvZ2srK0ZSNTRuQjVESE9jM2Ji?=
 =?utf-8?B?TldMOUhNaDhwakI4M3pWQzB1U21aakR2a1FPU2hCcnh0QzdRKzV6MDN5RUpy?=
 =?utf-8?B?UHNVaXNKeU5SRDVWYmpZenNKSkJ3RUF4RDVOUXVwYjZqaVZRT1EyZGl5Mkp6?=
 =?utf-8?B?eE1wTU84VitzWkY4dy9tRmx1M0N0dFBQOU56a2czSHp5OGtrcGRzcGxzRFVP?=
 =?utf-8?B?bnpQQ1BHZTY3OXFDQ3BqN013alZFV0cyZDhyMzVuWjgvd0VVV1pRMTg4cGxn?=
 =?utf-8?B?TUpxOWVRMUl2eCtTV1lmc3UyYy9VTmo0NUdXSWtjRTJZbmZGQmNNNFZTYzhp?=
 =?utf-8?B?LythQm5JNWROUVBGOGpBaFZTbks0RUI3RUVGbzVuWUZIL1QvY20rK2x1S2s0?=
 =?utf-8?B?UmdhNUMybFNUQnB0VkNSTGc1VzdheEpyVGJLTmVhM3JnTmFnNUt1bmFCampO?=
 =?utf-8?B?Mm92Z3hNOXk4ZVVhUHdHZ1NvY0htUWlaU1Npd3IrTUhrM0JTVGt2ZWZxbVI0?=
 =?utf-8?B?WG5nYzlOS3pQVWNxZ0xqQzA0RFRHRTFETE1hZC9tR29OOU9sWDBFMjdKblVW?=
 =?utf-8?B?T2pEUG9YbXAzaTVWNXFyazh5YzUxeVlPTzJWOXVwbU1ndWJTZFlLK3E2K2xN?=
 =?utf-8?B?b21EOW9Fbi92M0hRMnFaaDNhM2hoVTlOcE5paVQzdkFOVEc4a2hIWUFJL2NZ?=
 =?utf-8?B?V1VScDQzcnAxa0xsd2ZJQnZOb0JJWXltVndsM1pJa0VCUjJGN3JMalM2c2Fv?=
 =?utf-8?B?SWJUZE43WTlFYmFpc05CVTErclhjUm1iNnRWK2F6ZkRCcEg2UlRHR2pKc1hh?=
 =?utf-8?B?bng1dWo0NWdnaS9FYUdsR01HOHc3NEF5VFVCNS9BK2VUbjhBaThyb2I1WnRV?=
 =?utf-8?B?bE0vd0ZsUEp4QlB3Q3IvYmdFV0xTTDJXRml3SEFlSzFRWGVxQzRjWDNJZTRv?=
 =?utf-8?B?MytWYkN4TVdPNXl1RkZ2MlBFM05PdzBrRHlzVHpwSStsc2k0QWZJVU9Zb2Vm?=
 =?utf-8?B?c0JtblgxbVRwOW5VUlhKY1daZW9TcWtlcDBuMW5ZbUJFL0JTMjdPWmpnVldv?=
 =?utf-8?B?aHpUb1ExK25OOGRBZ0x5M000andST2xLeU9CTzk1WWF5U3BXa3pDc3VoOUV6?=
 =?utf-8?B?N2NpOTlUM0I5ellvUml1VFlpem1jM0Y3bkV5cDQrcUdRVHRDVnptSWpXa2dH?=
 =?utf-8?B?MFNyc3FxaldzWDIzaC9LTVZQMUhkTXl5RytFZmZvZ1A2S2ZSWWpxYW5WOE5Q?=
 =?utf-8?B?RHQ2OGdzS3dwRisxRE96NXJ6Q28yWFdpNkJJT0huUjdDTDFUc3BpaTd4a3Q2?=
 =?utf-8?B?djRTaEpaUlk3b0pBVGJkWkRuczNJeTRBQUlnelB0N00wS1NaK0pnNDNlZHNJ?=
 =?utf-8?Q?pYkZfND0/JKbK+Kf7VjlLWxXFb0UkN7iZm4a+gYkqcx4?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be57c0a4-0557-4308-d16e-08dd9377dd5e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 06:15:18.3431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nlZ/3YJHRqZigrgnz7zEVjfas/w59mmRV4fjvDM9hbif6al0MvS5OBEA1i7Q/5fICmH9h/ziZY9FD+u1mKus0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3955
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 May 2025 06:15:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18908

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=5&day=15&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/05/cip.2025-05-08-13.01.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
  + state of 6.12.x-cip1
* Kernel testing
* AOB

Note that I have a whole-day workshop in parallel. I will likely be able 
to step out for this, but please don't wait for me longer than a few 
minutes in case I fail to.

Jan

[*]
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed Apr 23 09:15:22 AM UTC 2025
  limit date: Fri May 23 09:15:22 AM UTC 2025
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Tue Apr 29 11:30:23 AM UTC 2025
  limit date: Sat Jun 28 11:30:23 AM UTC 2025
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Thu May  8 10:15:18 AM UTC 2025
  limit date: Sat Jun  7 10:15:18 AM UTC 2025
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Wed Mar 19 01:02:44 PM UTC 2025
  limit date: Sun May 18 01:02:44 PM UTC 2025
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Fri Apr 18 04:57:16 AM UTC 2025
  limit date: Sun May 18 04:57:16 AM UTC 2025
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Mon Mar 17 09:54:04 PM UTC 2025
  limit date: Fri May 16 09:54:04 PM UTC 2025
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Thu May  8 10:21:06 AM UTC 2025
  limit date: Fri May 23 10:21:06 AM UTC 2025
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Mon May  5 07:36:59 AM UTC 2025
  limit date: Wed Jun  4 07:36:59 AM UTC 2025
  Status: On track

