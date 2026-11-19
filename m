Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.6])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10138.1795074305327457843
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Nov 2026 23:45:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=WsRjkXt7;
 spf=pass (domain: siemens.com, ip: 52.101.66.6, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/Ra2g9zbE0lyV62XyqOPhEMfBM89q4OcvylTPvbG1SucCwwSxeYhdA1Ck7/eiSK9esgULJJ527t8DgTyFfKz6XPWOK5baVSn0S0XFOiucSSN1YD46fGyb4z7J3rYVouCFc9vu+JqFAf5bP4idWFFD0sXF0nwNoMLfcKk04DGWw6VXPjC70LMAqKyCAksFlfyFpI+w3+A1sreYP8y4SCFfDW9MfLxTf+kExpW4NiJBrYSfSarX4tz+OeGK+O7VdLAOoHLRzXZx52qkB+DAM0W+u2jrqS74WAG0Fm86vdjX+MU15jJY+GpLHqy2HruzTeK8rdh/lFAibmkK7twopQVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IK3Mg/LNCFln3oQT3f72C/V0G4Xv3E00Cmjn7b/7ZE=;
 b=Wk1CPoXarHwKr27bUex3F3p5P+0cTXDql6iSCfmu7Tua4RVGACNDUuN5yYZfL++x1VDmeHIMsCpbYK2+ukN3gP1dcwSPT2L3m2VNheFho+hs0tOxvdO1XKBtz4UoLtY8D40aaL37PGaCyRqfgl/aQ18IbJaU7t4y+wvAFeeoycokOG5rwlZDoKCxE7zTHXKdPyOe6hfD4VVM9j4mrAM12nRVDHwJMW299wtqtM02zmdQi6i7A2KQ/4qIO2ezzwkaH/Ya2aqQstEIQF8lfHB0SOJqCpI2XdvdbHGP/pZ+tOSmYvC1Dpqb5Hx8f0ZX6X+14KKQmFHek4v25CXdO1YY5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IK3Mg/LNCFln3oQT3f72C/V0G4Xv3E00Cmjn7b/7ZE=;
 b=WsRjkXt7pxKL4uEFUCeV0lChuxVMNVUosTp7vgXYISbmokc5SWsNXbN0R9ET3Dyz1TC3WprjRvnwHj7LpOBnhxp4P9TqGZQT0nqirMjMLof9WfWN9tUbqN7yoxZW2TCT/cn8guUVEx+NRJSK7CMP8o50wNAdpN7txsYwEL6pDnCr84LFiayt7XvmUanHLlD457+fGdAHNshv4Ju0FA2Dd/kZIVshJY2tfczTKjDmVY2DF0dfyjZOcVIP8ZHn7NQtiHuXYQjRygUgGPilBZhKdE+ySFBfuCSgLrNj8gXU2KBFs7X05FUUA2/Bwgdslm8m4QGpWdGqtr0Pk+Ha6nmBkA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by GV1PR10MB8913.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:1d5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.1; Thu, 19 Nov
 2026 07:44:59 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0639.006; Thu, 19 Nov 2026
 07:44:55 +0000
Message-ID: <198a5254-e4f0-4ad6-b47b-7c0090af09e7@siemens.com>
Date: Thu, 19 Nov 2026 08:44:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [kernel-cve-report] New CVE entries this week
To: Masami Ichikawa <masami.ichikawa@miraclelinux.com>,
 cip-dev <cip-dev@lists.cip-project.org>
References: <CAODzB9q9ieR9nEhh=sCVdOFJU+a2q3dRJZQOPkf=3QWXqzuBwA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAODzB9q9ieR9nEhh=sCVdOFJU+a2q3dRJZQOPkf=3QWXqzuBwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0171.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::16) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|GV1PR10MB8913:EE_
X-MS-Office365-Filtering-Correlation-Id: ef1a36b5-53c1-495c-ee4e-08df4611011f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|11063799006|56012099006|261021121427099003|261102123227099003|55112099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: d1Dvwo6BhWWplY15YKSYUVBoE7lNVTtzYgsthXgy45lhPZ8BFs4v/doKDu2z/i7JSLNP+YtfxpGM/iW2bZFmD7Nw/IsH55i7lc/ZTr+TkFCIoO/KTLqmpHZXR7gOFGgJeM+vO2+spRe3xqh6pFKO0qWXk222sUZY9OGDwBWWCxu/lbFNOlwtFVfBpBYyY/TZbX+/DqzilXa59sMRUhzhVIScSUdH+8Cj5XGpOH/Ga/0I5Er8MkIq1+jEScTcHUfGEQVJKgyeJ25jxl85fnSAsmSmZu+63ai/5pSjNgZ15okcwriWXMrm/OPibcWqjmrIJt5v1nyvUjPuQ/X9cZPXwX4o3owikabSkivsNy3VfYIX7+9oOLTlkDYMINl0LE5S/ey/C8G1Z4rKNgiR9IKJvHuOCHaCZ7pmIBp73UeFi976fh6IZmz5rwmbvnUiZ9FV2VN//eMsNbbr7AmSz6wakmBb1/s3Yrcv5IifzUIAad9T+tuBCNBZN2nezgGhAiLymBdm6wYl74a/FspH95v5JAdBUBlPXY2DhhNzPgte7LzInPK9OTanr0/vnE+30LDW1QmwbTnrXTnfLs9PvD7x+46919uUAd7cHzwq6/E29as3OJsLe4p10FHwQAyFT3D1ThwX0NVKdyo7T3Ygfm7uQKEqihQv3tSHYfMM8TRgAjI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(261021121427099003)(261102123227099003)(55112099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWk4cTFoVi9tVXQ2YUF2RWxVeXA5Q3NRY1hPR1F4K3Q3WDVxSHh4T3ZScEtx?=
 =?utf-8?B?NHN1RjdBSVpUeUdrTURJamVybkZwNnVOWWczZXZvU0Vzb08zTm96Qkd1SW1D?=
 =?utf-8?B?dEJwajk3L29ZMitMSzJUemhYUVozSFZLemVva043OUY1ODZNcGUzVnRZUFF6?=
 =?utf-8?B?R1Y5SHJjM3RycXRUWCtpWVpsU25QQTZ2cUxNNmJQSUtDVGxEQWNDY0syWXc0?=
 =?utf-8?B?cEpuUEd5M1VsL1ZHa1Q0SFdpZXFUbTBpNGRPZDVnVzRudmp3TDVJbFNvMWxT?=
 =?utf-8?B?aTRrQ2JUNEM4ekNodW9menFwRGlJL3loMTFFM3Z3clBLZzQ3K09aNDFvdW5z?=
 =?utf-8?B?TGc4UFlOKzR5VzJ1UUFhMDI0bWZod2VQMjk1NEhmekVwWS9jQ2UxRys1d0J0?=
 =?utf-8?B?anl3VWlwaHdidEhVUlBYRkt4YnF5SHhyMW5DUDNPYm83d3dJOW5GRzZtUmFw?=
 =?utf-8?B?V3dwbXBXQkFWcXBDNXN5Mnd5SFB1UzFPdG9lQzlvbWhXQ1g3WiszdjRpeXQ3?=
 =?utf-8?B?bGRZcHlkS25qRG1LWHlueDgxS1pESWprMEpGUXJpZy9teWtOVGk4eGpuYkRo?=
 =?utf-8?B?YU5YUjhLd1VVa2JYcWk5WTM3MkkvNWxxMXM5WG8waXNjZGFoT0FsdzhldVFV?=
 =?utf-8?B?eWRGZ3czTFo5N0VJcGd5eUZWL2hFN3VaWXBVYkZ5L2RJZnY4ekkvTG45Y2dY?=
 =?utf-8?B?MXl4cCthdUpnQlk0ZjYrN1FSTENzWWVnR0hwR0kralh6YjU0NHZLbjdqWWND?=
 =?utf-8?B?Z2c1Zi93Zy9hQk1DWTV2Um5OOTlHU0dWZ0tvV1VtZ1ZJa0NVTUNnakJPcXRv?=
 =?utf-8?B?UFRaN1pCTDd3OXVqbTNYMnBsdHQxQXR5dU1pa3NVakNXcFQzdXdDSk1LSnBW?=
 =?utf-8?B?eXVjMklNcFoxWDdzbmdPZXNJOGlITFpqejhtZ05JZnlKa21RSDVCOWZpTVZS?=
 =?utf-8?B?SEs2RTJzMzRISXdzQVQ0Q0g0NlVTWFVuUitKSU1YbjM3SXhTZVJFQ2E3Wjlo?=
 =?utf-8?B?Rmc2dzJlYVY4WDliYmlHY1RDd3NRWG84WHd0OGhKbmdFZmJMdlgvYnI1bzdq?=
 =?utf-8?B?V1FFUjZ0OU9tNFI0QXZzVVpyMGJSeEF4Sm9tT2cxNTFseW1WN1prYytncklM?=
 =?utf-8?B?UUdDSlM3KzAvdWlzNkVNSFNmbzEyK2NUc3J4V1VFc0dhNkNmVnBMbFNDemZ1?=
 =?utf-8?B?eVM0UlV5TS9OT0tIUGN3akZya2hXYm9UcGkxT1F2M0lXdGNTdFJQdndiaW1E?=
 =?utf-8?B?NnUwMFhBa3RuYjNwdTNVSDRwTEl1M3RpTmkwMi9aTnZCMjFoc0VrVEQ2VzZl?=
 =?utf-8?B?WTAxYWQvK3QvZkRSYXovblZNNEpCT2RPd1dxTzlpb3B0L28waENWbGJiSmx5?=
 =?utf-8?B?cmp6ZU9udFpEcTV1Z1dsZmJCR21EOVpsY2krd29NZjZMaHRvL29UWUdyS1lX?=
 =?utf-8?B?NDVoeTdPRW9nbTJhWWlYNDJWTm91VCtnbVpGSTNwYnVUT210SDhBRTIwb3E2?=
 =?utf-8?B?ekdadldQQzgrdDNYU1EranRqQ0hIQXJhOUZWRXFiOXRxc3BmQndpbW5pV21E?=
 =?utf-8?B?NkN5T1kvb0ZMbGVuZHduekZmVXh6Y2xqcFFQZWhNblFSaVZZVU5wbUR3Zzda?=
 =?utf-8?B?QzM5NG5YTHp2YXBPckNvY3BCNVRLWlhxOHdtMFNNd29VSjRjUHFsUzJieGh4?=
 =?utf-8?B?WnpEZGExYWhQMUNXblFPVWJiOFExenZydmdkNmgwdEdSY2YwNmpZMnhtVFdE?=
 =?utf-8?B?VlpFVCtvUFFoamcvT253NXV2YmJyQkM2N1VqOU5hVEVha1BwRkpwUTFwYVNo?=
 =?utf-8?B?WitvSnJvN0l5WVRqdnpESXU1L2lUelFFSlZxLzdaKzUvQUtKbWRJNENGYlNT?=
 =?utf-8?B?bmJyWU44dk5Pc0MvanRSdzFXcGwyTDRnU1NVdTlnOVJVLyt5ZlV6Y0MzM1lq?=
 =?utf-8?B?b3pnempxVGpWNXFsSGd1RzhBOVFSak8vZnhxWjNoRHY1dnFJSks3WjlnV0I1?=
 =?utf-8?B?WjFYUTZXVE9MVG5PYmJvcGpsY0xjRzRrMlBFa214Mjd2by9PN3ZDeVBqU3A1?=
 =?utf-8?B?dTBEMWE5YWhkMnI4b0xmVXFlL2VEMXFiL2hvb28wdmJzQkFvc1lWWFRGZU1H?=
 =?utf-8?B?TXgxWTJuVGhyc3Z6anY5QjVUTFh2dUhldlQ2OFBmc3l6OU9OeHhUOEhkSUx4?=
 =?utf-8?B?SlcwWTY2eHhFM2IrVUwzcWx6dDFUQUoxL3Q4MUNFUUNwMFh5SFUvWW1BeC8w?=
 =?utf-8?B?RTNETWJOUDAwMkx1SGdJTGduYXFyYm0zaGVyQkVEaWZrMnVLTEpWanBLTXBP?=
 =?utf-8?B?T001T0o3ei9QMzRrSWZkM01BOTdBZ0NLWkFMS2sxdHcxZE1XQi9kUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1a36b5-53c1-495c-ee4e-08df4611011f
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 07:44:55.8516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1EFb7lCWc7x5EGdbG5SiawiDX2RUW8B5GU8FsPWN599WFSqEdrLrVGOA/TiRDT90+Z0JAgw2oXZZxZx3SJjXjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8913
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 19 Nov 2026 07:45:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25007

On 18.11.26 23:22, Masami Ichikawa wrote:
> Hi!
> 
> It's this week's CVE report.
> 
> This week reported XXX new CVEs and XXX updated CVEs.

Did we suffer from an overflow of these 3 digits now, crashing your
script? :D

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
