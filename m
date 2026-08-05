Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6182C55174
	for <webhook@archiver.kernel.org>; Wed,  5 Aug 2026 20:28:07 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5037.1785961678145395351
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Aug 2026 13:27:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Ur6cqFxS;
 spf=pass (domain: siemens.com, ip: 52.101.70.43, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MYPm2HtLHir4K8fhGeynW9G6ArmZSyfiC3JV4DA7mifYkexVzvfF2oDZHznsyvN/EA6LB6e5E8XsPUBMHvmLhdtLx83/ctSS1djVfIcwEo3b/MGlM5m9/k1CtDhTqGqjIdVSd4tYvp5h1LfslqNt7BrW701Th1xnst9kGLTqpWkVqPdfZUX49+Z27JtkUobV/DaNCE6tKgVsmUdsDlt/l5TAowAh68oXUmPLQnZG6wr2uV7GVVPUPhXlCJgC8IaLL9kfvhffC0Q0he4Z6fi4Mz+IrXqVG6YjHaUKA7+NkHvTbFxkW7euoCDT13o7QC5XoTp5vdKZMCj4ADMh69SHEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bfku1kkw9RXB1y5N8gCOWdBR4P2LnytRUdiPszWA+N0=;
 b=WAIrJ5lmEf9f/myH3HDHspWxjvv8UTSSRP4Odt91ibX0NzRiOiMyZiHZm59llQPhC6Iv6X1Ftn+O8YcgHSuyVbCkWx7oyJ//4bZ7n/5EugnaMgq+CzrcQAJY1SsadTL5Jz5MRDVzYsiERchLPEAoH//34wPPK7n+orP+QIrausTxv68gT0APsW9Uh7p7O/Zox5lfXG0EORBNpTXHb6vpVQFOu+hIUEiBqYWbXVK7zES+/3xBwaN2tIK4Sq/HRcBEO+zy3Jogu+cX7qjHJKXl3kDOBx125GEkNAWlUWRWdmBufOPHpnJQVcztkKiVAd7JfQlQKFvRglJCXz1lQDtVdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bfku1kkw9RXB1y5N8gCOWdBR4P2LnytRUdiPszWA+N0=;
 b=Ur6cqFxSDD2ePw6aqobQdYZpx9AEoMXGrmkbulPhauf3day7dncZAehRQlFy08CdIHLZUYXanzu5jFXO/0WpuG7mwYRur6fjZDzYxn720VgpNp1ZS0P9vAC5zA3TaewMY2tQGTfQzjoPrIr/mWtIOzZP3MWeuLvotPhU851XS38SYSxYzedFZqhUNs/ctq26E+Jo8Yo4cnZ0uoTPXblSIkIV3uMWSP+6ZRoR1Wt9eTRwR+uXAQjMslRkX1MLKznp6ArdGFeTPY4zP/2/r0tDR3xhUdlarMPpxGUvKuAtQ/hPyblAhNRrVy22pOcIRz6u/cUBWPe2OsvmG8hxxCmxXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8179.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:11c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 20:27:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 20:27:52 +0000
Message-ID: <49215a8a-75a1-4c30-9132-15f2d6f1ac99@siemens.com>
Date: Wed, 5 Aug 2026 22:27:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [ANNOUNCE] Release v4.19.325-cip135
To: Pavel Machek <pavel@nabladev.com>, whyshall.dev@gmail.com
Cc: cip-dev@lists.cip-project.org
References: <1672269011.888387.1785850990322@webmail.strato.de>
 <1252941.1785911162738531742@lists.cip-project.org>
 <anL4d800j3arkffa@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <anL4d800j3arkffa@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0193.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8179:EE_
X-MS-Office365-Filtering-Correlation-Id: aa2c76fb-7166-4fef-65c7-08def3300662
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|10067099003|11063799006|4143699003|6133799003|56012099006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	qErz3lf/VnbtleDXm6WKVGJbUdhKVQL8yKr8OEOct74KooaiRcuZzPk5lOJgXULmxtX936xBHKy8p+Bvl9WRRzNiVVir9wLeCdooT5H/v/ZQ12xBwA5Q+ALcHbV8uchgobVOkdqfY9+zMDTlcjNwm5EN61mCS7Bs7uFRVZM/i+lTfT25iUBgyHC/mglXFfyEWaV2bZTWPcZeo9PrfXfOGHFhPl/5GYwxBdlcgGBzXoWrtEA+sLcTpW5aATC3cPC/Lh2gDAl/ugslq32gco4D6VE3ZOg8NFpaSqhn16EnGlbTqHZfZ8kQe+ckjx23MIkmAlfS7rfJYqrB98WpI+K7j8GQDoAPmVwbfIt7I7AEWP1MslyHVI78mbHlLBXHj4sMqy5NLZWltR0xHp3GvSKvJ6MPE82eFDbzjC2/4alZ22ECNPFJYXzwWQQ4NB39YvhuuY3jQyDptsQGN84rDVW/knny0acxmjpmM8KKmCJi17A1S0I/TS2WiVxBYz4E6py253dvdlU8rh2vD2miGgx3hcpG09QNhrnr3lw2AXLYPWv6+8Aw3/lYltYPHLLJP76fXVhLvVre2e3UpY3iQM6UK7D8nYQLAbXdDeYnLMsBQNoVmEz616MFZnprglbMVG3m/Ce5dEgaOF/CicVkjFwvTqm/YMCX12wnFezIjxmfcI4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(11063799006)(4143699003)(6133799003)(56012099006)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UmxyTVpudGFlcVhYQ1orQ1hmdUg2aWVtaVNReTZiMVJ1R3p3TmpmWWoxUTI1?=
 =?utf-8?B?OGwwSlFWNE9vL0ozaHYyYXd6QnJicDk0bnVjS3I3SnppS3Byemt1bFBQcHdQ?=
 =?utf-8?B?UnBuZ1ZwMlFpTEpQRFlKbVN1UnJOT2I4c0RldCtIekVvd1NYMFZyVUUwWjAy?=
 =?utf-8?B?THNSbThCdkZRZ0VBZFVLYUd2ZzQ1SWdRTDVoY05UZjdCSEZYU2pWYnpOcTFT?=
 =?utf-8?B?dkF0NUcvT3JuUVhCV1dHQ3FHWnU4ODkzOTROZEhLWENVeFNsbjJRUkdVNXNs?=
 =?utf-8?B?MktnKzZINy9JU2VVSklMbGxhbkZJMFlnVXhzY1lTTGhLRk9URmxzRUNPU2lj?=
 =?utf-8?B?SS9HYzNCeVB4SSsvOTdwM1MvRUNkbytwOCtZR1RnMnJwbDVGaHcwc3BZTG5y?=
 =?utf-8?B?bkZSRmFBS1RQazhTVWpwQ2NsT2lia1hyUm9MaDNNQ1dHbmJSNzl4c0JWY0x1?=
 =?utf-8?B?SUFDRENJdmJyUDJYWmUyekF1RC96ZVhBZzZTWStFQ3FHYzR0OU5ZSVVOK0JF?=
 =?utf-8?B?dlg1TUVkeEM3LzBPeFB1ekNCZEdWQlZpREFZczRqVjBUZmFLdWZUVWk4VlFm?=
 =?utf-8?B?SGNMK2pJY1pVTTk0WXlQT3ZIcWFkSjcyVS85enFWSG80Mkx4N1dIKzNwVjdZ?=
 =?utf-8?B?aTJwSFpFcnhDVDg4Z0FNK0p0MkNiczZJeThtTVR6b1ZkcWwxVFZEZ0dUdmll?=
 =?utf-8?B?dDM0TWlISW1xcUZaNVRCVEVDWlFIQlhORktrUnJpSS9wUkc1V1Q5NlZ2SnRV?=
 =?utf-8?B?TmlQYjEvMk5LYXBCKzFRaTN6cXpSYlJSUyt4R2J2NGpCUms3ME9BZ2tVbFVQ?=
 =?utf-8?B?bGlOR0tOK1VreWpRdDJVZlVnVU9naGM3elh4Zm9RVjZvcXEvdEpLeERCVHI2?=
 =?utf-8?B?WVZOeXJWN0VKNDl5aHd3WHpsUEk2RlM2VVYyK1U1ZnREZTltQzR0UW9GYW9K?=
 =?utf-8?B?ZTFaTXlBcFYzNHA5TnN0RThWenp6N2FVS2ZhbHdpYURuZ1N0NTJUQ1dlRkhl?=
 =?utf-8?B?TUZqcG1QUFRUbE83eHdFZUtHU3h3U0loZC9aQnVnam9GVEVVTStIRStmZ3ZC?=
 =?utf-8?B?RWRVeW1yYytxUXlqd0RjenEvQnF3NDdmcjJZbG5tU20zbldla2tWTTE5a3Zu?=
 =?utf-8?B?ZXVyOVhmY2Ztb3lnRzFuWS9KQlRRN2FlZmJZWHZNWTlWSDJtRUtpdTcwUXlh?=
 =?utf-8?B?TWdCUFF1cWVYNkl2TUIrWFcxOG1hdDRXTGtVdmYwKzhiTFBJdWNhd09qZS9H?=
 =?utf-8?B?Wm9VT0J1d2VnTjltMTA4Q2V5TDBVbFFjOTBIeDUwaVlqMVBxVG43R0F3dXFY?=
 =?utf-8?B?azFteVhydWREVHUzSXVZZDFvY3JET2llYi9nWnNwcENhcWtEMEJDelEza1NU?=
 =?utf-8?B?R283OFdIYVdPb3dmbXhKSTlMQUtVb1Q2Y2R4anRTTTgvbnRrOUZqZlVIbHhE?=
 =?utf-8?B?czJ3NXhZbndDR0VwcGZjWXowRTBPelNwOEJ3TEtwcUh0NVdKWEZLVEJNb0dG?=
 =?utf-8?B?MEZwSDhCdXJ2dGdrZzdQRVJ3RWcwSG0rSGRabFgrcXk3Uy9oSi9qZ05zL2dq?=
 =?utf-8?B?RGoxM1V4YWFmMXdWVHBEK1lzTXFiQXFyU2w2dmZhK0ZVM1hwdWFORlhzUHA4?=
 =?utf-8?B?MTlwNzdpRTNDd0JCMnRUUG11UUgxeDByZ3NNTWlVTmFSbG5aYkZNYW9zVVV0?=
 =?utf-8?B?aDcyOFNhOUtHU09OdlZ4ZUlmY2xkLzNSMzNja3JFL2dRUmlRcUR2L1llN015?=
 =?utf-8?B?R0w4aFdsWmFKK0FFeVRqTEhXdGp6dERRUTBuVGx5Z0NPcUIrZ0JDOXczRWw0?=
 =?utf-8?B?cWtaQVVRUkZBU3FXTlFnYWVmWU5MMzliakpxcEVEUGRMLzR0VFJFZ0VmU1Qv?=
 =?utf-8?B?QnFPSVZxZElCL0gxT1RISGJzQ2tkWW5najNzQ2hJSjlaT1JQRnk1bENrc0JF?=
 =?utf-8?B?STJaZ2NGRkZnaXFNb253ZnJqVUFkeGZvbW9SVCtCL0hGSFpXRmxmQWFLaTlD?=
 =?utf-8?B?d1FvVnNXK3Q3dU1pWnQ5czV5K2JRZXlic0s4bmpTZlFJZ1lLWGhqR0xRUmx0?=
 =?utf-8?B?M0M2aXlDYll3V2d2QXEyZjJhNEZYYVJhMFdMeXpIV0xaMkRYeDZqNG1MY1NJ?=
 =?utf-8?B?Q2tlaEhNSjFsYzdFMDBxNHNNNzFVaVV4Y3F4VkVXQmxhMncrOGxRTEoxcHgy?=
 =?utf-8?B?QnVEZm5ObEJYWGpQSjkzZEJkNUZnSDVjeE5kUGMrM1NSaE16ZytmcU9pK0Nt?=
 =?utf-8?B?S29Ld2JzekNrSmN5ZEVSYzVWdXdSVVkzdjdoZlZqWFRzUXMraFI2WVFYVHNx?=
 =?utf-8?B?UWFmdXBPSjNZUk5vKzVjSjMzUHcya0kyeVJjWTBFcDU1QklVaE9LZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa2c76fb-7166-4fef-65c7-08def3300662
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 20:27:52.6744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bOhKkuFHEJc4mCLgGh3ZUjXjE8B91H1t21YuSiNVYiPmn90TZckznRH+Ng5fCglhgleikW80Cx+P9aJA1W33aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8179
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Aug 2026 20:28:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23868

On 05.08.26 10:46, Pavel Machek wrote:
> Hi!
> 
>>
>> I understand that the CIP project addresses vulnerabilities in the Linux 4.19.325 base kernel and releases updated versions such as 4.19.325-cipX, with the latest release currently being 4.19.325-cip135.
>>
>> Could you please let me know:
> 
> We don't really have answers to these questions. Due to low quality of
> recent CVE entries, we don't track them closely.
> 
>> How many CVEs relevant to the 4.19.325 kernel are still unresolved?
>> How many of these CVEs are expected to be addressed in future CIP releases?
>> Is there an estimated CIP release number (cipX) by which all relevant CVEs will have been addressed?
> 
> 

Still, you can have a look at
https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec for those CVEs
that are mappable on 4.19.

In addition, intentionally unresolved ones would be documented in
KNOWN-BUGS (see 4.4-cip [1], not existing for 4.19-cip so far).

If you identify anything that is apparently missing but critical, we are
all ears - or even open to review backport proposals. Just keep in mind
that the official CIP kernel support scope is limited to the
member-defined kernel configuration set [2].

Jan

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/tree/KNOWN-BUGS?h=linux-4.4.y-cip
[2]
https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/tree/master/4.19.y-cip?ref_type=heads

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

