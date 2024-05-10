Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58126C25B10
	for <webhook@archiver.kernel.org>; Fri, 10 May 2024 12:28:53 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.48])
 by mx.groups.io with SMTP id smtpd.web11.11209.1715344130432735362
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 May 2024 05:28:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=TllK1ref;
 spf=pass (domain: siemens.com, ip: 40.107.241.48, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUDdepUjVg+SGIBGDSV85JEqEZl4TaJ8UtF/bdvtoO7WS0fhqTM2vswAxAAotgD2JE3+z80vKE+wXQQHcX/6gBFoVEj0e5yPLmrzjqZDG0b1hy6NyJuRVqTS9Q5ySRIBP44rbLdTTtTZp41Hw5eujpt/s0kJXEdajQ/G2LeXKBRbQlIR9FEufQfFLsWR6Y+LfXhQLQ+02hGw722q57nQ0wpP+OueTYKSaWx67o7QEDk+E0r2mi5svjHqF2Jp3VYQ1xvjPN8Nxt4sEaxd+1H1Rr+j4WGNK+WdT5M39HrdfL1xetuBd+pV81EUe+dODwVA2ulQjaQv3cFLuiGs5bcrCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LapfiZI+ZfNVlYikAmXNCLUxlv8dXth8vVhhmq/ao7A=;
 b=Aw4zlx7YhY9OANLrD0lrV3kXpnk0lQPIeqKjKDrO6svHY7WFPeyjtNxFZb+AAtc8sMo/5Y8djvFUSbQh/wE88W8PEKocK+qAsWeOdfaXJc8doRva6afu8exPYuvEZZwwmk9a2D6RvwXCacUa36oU8ewH9PoXqWxw+9cmKED0AnwUjlRprEmAcaIt5I1Uma6DoMkTIJn6R0z8VjMdGpOMXz/rUf/vSpao0KXkWaahBfkIy9TB8X9hg5cP2zX6GSArFvOciJpCWhogDXQU4hWlxlHyBVC4L5Eh2fm/TpP/FN9duiguDJ2FrW4DT3aWAbKbhuxIW+Y6xNl3sOEP1jy3kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LapfiZI+ZfNVlYikAmXNCLUxlv8dXth8vVhhmq/ao7A=;
 b=TllK1refCakf4i1x1gvEfNjCVpeAM72wdgsPMu8JJGhHLpTONNtkN++QiYx3soccFhyscPzzOKkSKAmJAlSFb5AvmcGVCg6sXTjb8k3m2qloKTS3nPP9hbvhkAvThCG3GfqEnMwwZhqdHxfwx8TW31Lex4Y/Bi1seltXA9m45PKWYXHBKZO64MZwJ7h6SjmdumFThL845tVJ+JMvWMr/ZFslWEAAlpBqfkMbIlWKkBW1eWOGrj3bIHKie0vAD4r1IS/0Y9IottY8XPPTn7CnRbVWbcVhK/Y0W9W0dhehLWC2czWddjCdgaK6qLgD8pKcO9oFJyxS9P17VuTJDP7LtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5344.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 12:28:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 12:28:47 +0000
Message-ID: <b71023d7-e0c0-4fab-b1ca-8d87a007a0fa@siemens.com>
Date: Fri, 10 May 2024 14:28:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] Enable APT snapshot for reproducible
 builds
To: "Moessbauer, Felix (T CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Adithya.Balakumar@toshiba-tsip.com" <Adithya.Balakumar@toshiba-tsip.com>
References: <94e8b177-e56e-48d8-b5d2-880758658b6a@siemens.com>
 <a008e3175c8a0cdcea515f4ce3bf3aef38f1b463.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <a008e3175c8a0cdcea515f4ce3bf3aef38f1b463.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5344:EE_
X-MS-Office365-Filtering-Correlation-Id: ef26e81e-d4fa-4e73-5c80-08dc70ecbd48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?a2VJRHZIQXNkNDA1dXhNS1N1Nnp3bjJpbElDazdMaTBIZ3V6YXM1NUdNamtE?=
 =?utf-8?B?a1dCVVB0K1c3aVQ4anM4a2VkRlpqdUNqWCtYZ0RBWjlWdmNJQWx3U09KYXdJ?=
 =?utf-8?B?Rkx2UXp2YzZaY3VSbysrVHlkK1A0by9IK05OenBTdk9VTzlqd1hkU3BaNEx3?=
 =?utf-8?B?YjRnLzYrWEJ1a25SWUJiWW1mTzJZSitmTVpseWppSzFoeWVhZzRJeWVmcnht?=
 =?utf-8?B?Y3o5ZlNKVDlTWUcvYjVQSTBxWGd0NVRFbDh6dHAvNnAzNHJwcWZncFRzR1ph?=
 =?utf-8?B?Q3FtUWZORG5ndUI2N2NsczhOVUF6aDVkWlRzNWZZUS9iYVMwTG5sSmYxbUp3?=
 =?utf-8?B?WTBTNTBNbG1RK0dEeVlIR1JVOTFONnpXUW8vNE55TnViZ2dmVlAzNGpPTUJG?=
 =?utf-8?B?Y0NDWGp6blAxamVhVGttNXFDVWd6YVVmcitPODVEdEJNSFFEVjlNTndJd1dV?=
 =?utf-8?B?c2ErMldnVjYrditQUTBQejM3c3VvR0xWRmthaFE1V2tTbmpid1RyZDdvM3Bp?=
 =?utf-8?B?V2x3aDZ6aGpLVGladlVQRXRoTThJSTlZTmhjLzdmKzRDaW1ZUk1YTXgrVXZm?=
 =?utf-8?B?YlhIejJEU01oRkYwVEw0LzhhVHJwcnhWQTd4YXg1eURSWnZ5Rm5VUnVpWVhH?=
 =?utf-8?B?bkprM2hUeW8vWGYyOGY1eGwrZzI5U1ZpUTNzeXU0ZnM0TEFpeFBjYmo1T1pk?=
 =?utf-8?B?V2IwWXdDRjRTS2ZIc0pEeTArN1dSWmd3QTlDdWN3UkpEMGszSkNsTkJWWGZk?=
 =?utf-8?B?dTVWempGdzZTYk9IZWJmdnA5UGVkZkdnZWx5bWlOVHV4Y1I3SWhUK2xxNlBi?=
 =?utf-8?B?djVSWHNhS05NN1RvdHRJOWtib0k3SFJ0QjdzNWU0WUFDbTR0bFU5bG5QZzNU?=
 =?utf-8?B?SzZEbFZCcjNrd1JDUHU1NGtITW03RW5yUFRoSHRpN045QkV0RXFDSnYvZGk5?=
 =?utf-8?B?UmtPSkRvN1lKVUE1T3JFYzRNempIdEpibzZMWTJuOWN2bjhtNWFnc003MTMr?=
 =?utf-8?B?UWtPT0YyT2NzWlZYU3prMzMwREZKandXRStnVHlNT1o0eWlERUk3WUxQb01a?=
 =?utf-8?B?YzJ5b3JzQW5SS0NLYm5SMTg5QTFjVmNjWklNWjhUVmh5TUN1QVAvZ1AvOUdG?=
 =?utf-8?B?ZnJIRmZxVGxmMmtJMkwwc2FYLzhxUnpQSzUzZ0R6K1lmVmVrOHEva0ZyS3NS?=
 =?utf-8?B?Mi9UMXBwWHpJODltVGwyeXBqeG5yWGk0d2V0MjFneHhOSWNNa2huL2hxSkpO?=
 =?utf-8?B?dk05ak04enVsRXgxby9LWVU3WkJXNnVPMmtSaXVEb1lxdkI3SlIwb3o0VkV2?=
 =?utf-8?B?QTRXamVnNzQ2R1Q4ZTJzT2JYclhMd0hBLzhNR0JMTitjWWk5OXQwRDFOOTAz?=
 =?utf-8?B?Qk4xSlI3Sm5mNkZYUSs4dWNPUjl1NUh4cm4vV0dyaHRhdEFQZnpXSkxmTFRk?=
 =?utf-8?B?NmV4RmF6VWluY1pJY1dYZFdMT1JURzZsUGIyTnAvSGFwdFpYcVVRNWpKSVBs?=
 =?utf-8?B?azlzVXVuRFMyTzFQWDRBOVFiL0dKMGplWHBLNllHQkkwYXB0bWcrajVYTVdn?=
 =?utf-8?B?N1IrSC9TRWdHQmQwU2JTREY2eFdpMUNVVk1wUEJaZHhkRlVQbzN3MkZ0Wjlr?=
 =?utf-8?B?UmpOWnRVSDlIczNBY1ppMXJ6eTBxNk1LQ2xheExhdWl2ZEIvRU1ESjA5dXg0?=
 =?utf-8?B?TGFGeGFBRjdBN0d1RGdxNVE5YUdEWXFqWFVPbjBSa3pTbU1XWjlFOG9nPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?djBaMEFLc0Z2YzBRbXRJZUFiUkI5YjJNZFZOc21YTkc4dU1QM2hJQXA3SXJL?=
 =?utf-8?B?RDk2SytCaEhoU3VZYzhuank3UlhWUnh6VUcyOVA3N0RJR21PYmNRZnFRWTVV?=
 =?utf-8?B?bndXRnVpOFF0MU5ZdVBVQktIZEJDUjJrTTRSTGJ0NmM4Ukx6Z0VVb3ZqNCtZ?=
 =?utf-8?B?bGpQdE1ib3Z2UG5tS2ZhWU8zaklycEpXcXBDSVFyWlU4bFRHNUhHZ0MyaGE3?=
 =?utf-8?B?dTVSQXJaMmpxRkhMYXVyNU11Rm5aMHRKS3hvOGFZcUthNjJINnUzTXZVY0tr?=
 =?utf-8?B?MEp2K0NCZ1o5UkkrVTJNdGxHYzJoMi9WSlZxTC92QUVpcjRLWHRwdklNbXUx?=
 =?utf-8?B?MVlYTHdGdTB0NW15UHFEaDdHRlY3eXZSOUJBdFVWVFdFODg0MW1KbFF3ODRo?=
 =?utf-8?B?bUZ0ajAwNUgwSmlEN1V6eUpld3ozOTF3dnlRTFIvOFVaaENNMitrYVVLNjN0?=
 =?utf-8?B?cFRuSmVpWjJLR3VqK0RpMm9ZUCtESmlMcEI1WjFZcGR6ajhvRUMzbXFQbmlm?=
 =?utf-8?B?OVpGa1FBUjB5TkRaUVIrVTZsNzN3NnZFOWxFVlNlMU1pK0RON2lHQUR6ZlFr?=
 =?utf-8?B?cjBZT20xNUF5T2tZZlpiaWc4Q1M4NEZOV2xkN3I1dnFHRDExZTEwMFdJRGZE?=
 =?utf-8?B?MEJTTmtrYm1Dby9kYmNxb2ZmVHI2VU8ydHdVYnpGZEJVQ3Z5dGliSktFTmhQ?=
 =?utf-8?B?VW1raHZENmRKNVo1bVd3eWY2clA0dFU0YmgxOWdyZWw3SEdzZHc5T0w0Rm9m?=
 =?utf-8?B?NGtjL09ZMVVZU05wUVBMdmxXQ2RTZElta3RUUE9PZXVRaUcwRmEyQmN4RFhI?=
 =?utf-8?B?YlU1bzF0WjVYc0NheHljcWpEVmtORTJ0K29jT1hqR0E3SE15OXBQU1A1dXlY?=
 =?utf-8?B?cWpMTThmeE1EbXF6VzQ5UWEzMXUrSHN5VnBjeEVoRWlDbFBubzVhZ1FnZzVu?=
 =?utf-8?B?OE5yNmJRMnpsSk56ZlhLYXJ4VkI1d0pUcW9kOXdMWVlKNndvcWhEMjBGV01s?=
 =?utf-8?B?KzdMcVRQVng2VC95c1gyb3I1blNudnJ3cGRrM0tZUXpjZDJGaHFmMEQ4ZmEy?=
 =?utf-8?B?OXlTYWlEZWltd3A1aDYrS1NsOXl2Z0NIekNEZXQvZ2lSL2lLN05mNUlMY3Rq?=
 =?utf-8?B?ZVpvSk5jQ2FpbWVIbFNmWlFYN2w2QUVodUk2dzBKUHR4S050dU9obU5oazFw?=
 =?utf-8?B?bUprWUlFQXZKMGZlTG1ZQ1pGWlYwL3k0V3h1QklzSnBmRFZaZEJtL1QwR3dT?=
 =?utf-8?B?cjlUc1pTZSttNWdVT3RWWk1tc3BaYlFjSXM1SjNCckIwMEZoemMzb0c0NVdR?=
 =?utf-8?B?N25tNDJWSjJQM2ljVysyTXB6dlBiK1dLcTRrc2pVbnB4UnRlTldFQXdjenVD?=
 =?utf-8?B?Z2g1RWJMblkwcUR0bkNIajBLdksyNzRoWXFjRFh0SklMRnNHNkhMb2xLZVBG?=
 =?utf-8?B?RjJkaEZuOXd0S0VKRnp5WnBHM1RjMFV6MzR6cEdOb3BYbVRKdEFWc1JSMy9h?=
 =?utf-8?B?alY1ME9oMzNYZzNzMFZwOXFoZElSUHcyWGlNMGw0Rlh6aGdtVWlFRk1PZzNX?=
 =?utf-8?B?OUxGb3R5Rk1pOTIwZlExQThoV2hjaTR6SXAvRk1BcG42TUxUdVFqTzF1QTJo?=
 =?utf-8?B?cUdseTlEK2NTNEZBc3BNcjIvM0xycGZ2eWpMdExWdi9wQllTTVFrTG4yK0JE?=
 =?utf-8?B?VDZoRWhJVnRxSm02U08yUmVnT3pkNkRKbkJjeVRHQWRGWjRxRFNtb0FFWHpC?=
 =?utf-8?B?NXhxblNmcTNUVFc1TlJZWStkdjZtVDdzbjg2UGpuNXJSTE5aRFVVMWQyTHJ6?=
 =?utf-8?B?YXZIWU9rY0N6UUZEaGg5cUpxbFFlRVoreGpvZjhKWlFsRGhOSGNRZXVEc2NL?=
 =?utf-8?B?SzJ4dHl0UkxXOVhEcWhCWmhVN08zazQ2YlkyWVJDbWtPaVM4UFd3TUM0UnB4?=
 =?utf-8?B?VFN4STNjSVVtQlE3c05ObC9Ld2lzQ0ZVeFNNVWxKZFpRUktHYThjTlBLVVh4?=
 =?utf-8?B?MVlqNnB0SUFBTWVJQnE0YjZNcW5GTlBRaHFCMDZTR3lzOFA1Uk1QbDJkNDMx?=
 =?utf-8?B?MlZVT0ZtR0lDRXViVWh3NG8wNmhJb3MxemR6R0dyUEUxdmpMeU9VdlVJSGVT?=
 =?utf-8?B?WnFvWmRmaDV6dFVBVVROY2EyTjk1OFdVWU1rTUp4Y21aMU1ZNS9YZStnTm9x?=
 =?utf-8?B?cWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef26e81e-d4fa-4e73-5c80-08dc70ecbd48
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 12:28:47.1086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: egHFRtKtoZaBxbf1Yxc1NN5yK8/HZvJlDawWJ/ucknGga3+7mhF4yxzCnr0XNIsSmDTXSGG9LhKvocCujaeD4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5344
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 May 2024 12:28:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15879

On 10.05.24 14:19, Moessbauer, Felix (T CED OES-DE) wrote:
> On Fri, 2024-05-10 at 13:19 +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Ensures that rebuilding this image later on, maybe outside of CI,
>> will
>> still give the same result.
> 
> Shall we port the sid snapshot logic over to the new
> ISAR_USE_APT_SNAPSHOT=1 as well? There, we need to pin the snapshot
> version to a fixed value, though.

Not stopping you. ;)

Jan

-- 
Siemens AG, Technology
Linux Expert Center


