Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.27933.1793857562676570208
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Nov 2026 21:46:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=qNcdseQq;
 spf=pass (domain: siemens.com, ip: 52.101.66.46, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pz/iujfdLOqtjoWFoHabY3T4bwXTTSieX7DVledQmBT6SwSDl+wV94VlWK5VbBOMfvLmCwGJ1uCLidh9srya4gOqlMg5nivS8FturDdDcAqc77Hq+JKR0a7rhxM+IYncoeOO7eIEBGcOVRLMNOTdGHPNHlGZoUnBu6hOg7+rFATwuIFatmqAPl4LyvtXA1Fpoyt5Wh7QEBAxdKDeUj5E7kipc6GgrqvnualdO8ybaazHgIG7GFkvDfQg1OgdvogUIkVknOOMrS5jeqm5sQBpGxbqpyc0rpqgAe3kWUSv8Gy1kEkVRuhM/0wTHgaPTqWPaqkx9twzmd2GpLX3WnlMMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpJQ62pP15lE2Ly3cACTIxcHnuudBHsiGeoFNmxyYbw=;
 b=zLfry30SsuaGzRy30aWX6Z3zltDJ9WltC+UxVzEJ3BLoP/hghtuom4VbBV0SczvpAKjqxozvrWfb6i8/yb40FgdnHaJfaw/ee7znkolnVjQZiTjd4BQlz6n2eKuuJrEXd7j0eQX61dYv0tDNKPi4ad4E1/R0El1zRwLV6Qe2bf9m7p5EWGh1iC34d/Tfau4UVUhzUUbcZkz0PW1KYt3IqQ3v3anMsOalOImAicJtKpnCmm3xgoVtddoUMMze2CBd4tOmgpIitVRlrE1ZJvT4IWbACEeLDXCjwW8uUpaJjGe1jwhDt8pscpV6Asjw4bzg25dHYE/DxD04noxOGroqjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpJQ62pP15lE2Ly3cACTIxcHnuudBHsiGeoFNmxyYbw=;
 b=qNcdseQqlzJTFASVPjvAiGAgy8+ZxODFvVtNKtmyKdBjggIR49+5xz5SbdPOJRbjYn+f6IYtlqppsl1MJumLPyT9PhBkMiwrIxQts4jzKbwBHxqGaiZjZ9/f8JQ7m6bgZz/MSk+lt5V2yZEjTB3uZcSuWhnmuBi/+QQ5xwmEEqKYdaBo5qqxYBT3LU/UHrxK5CYjN/ej6OWzsmqQb/QetSne9PM/uOxfGtoIZhJDgrdFU/Og3h2hoYh6J409kb6K7B2GyNTMoQ5z8djCItspT/AIhqCj2QfdKk1bEdVd30CV53OUzCePVuIO25qXp/SgQ8EuqPO5ecj+O1xXz1DT/A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by DB8PR10MB3689.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:13e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 5 Nov 2026
 05:45:58 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.003; Thu, 5 Nov 2026
 05:45:58 +0000
Message-ID: <65b9ab53-8b5e-4d87-aca5-3e47526d70ca@siemens.com>
Date: Thu, 5 Nov 2026 06:45:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: CIP IRC weekly meeting today on libera.chat
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
References: <f42cc882-7a2d-4eb2-907a-afecc051a688@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <f42cc882-7a2d-4eb2-907a-afecc051a688@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::7) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|DB8PR10MB3689:EE_
X-MS-Office365-Filtering-Correlation-Id: 13651c65-3eb7-4b45-638b-08df3b001139
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|11063799006|56012099006|261021135927099003|261022075727099003|261009223027099003|261028144727099003|261026140227099003|261022105027099003|10067099003|22082099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1qADcHT6Pe4J1aj+GN7tjSjb0uqXxTEWG+gbJsZ+e9w5aUbONV1JQgTQ1ageewDrmWcsAdAV9g0OsIIDQ3H91HIKcqkp8MrsCxwzBnoPsEb2bnBQR1AsuL3Sy+CEjsKXx5afAKCx7V9pz9twNUSCQu9IYMlJYEyPKPsZEskF7ZR+ojmbg9XFpEWxuqFKxswZRi5/R9bdwuV+AUY6VmogX+flmL/TPogOh+8qLbD8T8V8s6JLU0bLLD/eoqtvoJeNkpU4/IE2/YjfepaSFmaHbVXfYvswb+4QOO7IRc/YjrMGoAlYybw4pEaNPw5IzGlevcmbNn2rk2mQxlSZD7qoiDtTrVXsj31Sm54yoJRFPiLST6I+eVGRTLOZ+Oy8GevJt9ATjRRYJp6V+Z+rn5bV9LjamNsj2LKhZq/Mj3CLAI12O2FitKScza+LNceTqRuOqyOXDZzSJEhiwEbLHY+8To95N5v65yW5wX8HsohPllvQLMkhDWo3lQdBNPWmOxdyEy+ry120G/6REaIUXoAxel973dhSIJeeTZXtd5aZQWLtxHJ3wLlpce6Ms2owZFAuY+LEZ7ZMiprjSq6tESp01464j++xIBW6bRNOtLyL9KwN4IGGmg6mr6qFybVbd82Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(11063799006)(56012099006)(261021135927099003)(261022075727099003)(261009223027099003)(261028144727099003)(261026140227099003)(261022105027099003)(10067099003)(22082099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmxjYkJRY0I5QmRCaTlETk4xM3gzcEhDZ1ZCVEp4WnZZQXdPV1Exek1qdnVI?=
 =?utf-8?B?SEt4UjczNm85TkphNXRGTjZBWWpBL2lGS09aOXpTZTc3aGR3STV4a2xrWE45?=
 =?utf-8?B?UWFuMkpyai9RSmhGTG1CREtnZWJrWjJ6MmVvazFMZWpsaU5leXJIRGxHSEVz?=
 =?utf-8?B?dUhxaTNzMVNGWWw0NVRvVk9HWVhtYmwxZmhXZk1qNlBZVGd5VEJqa3VVZFVh?=
 =?utf-8?B?ZWtoTFlHVXRMYUJHUmtrSlpaL1MyaVVWUHppNEdoK1M1czlodnFKcTRBSk8z?=
 =?utf-8?B?SUdHZy9DVEdFd3pVRC83UlpyWnp5cmlxcldSL2V6TWlqR2ZvQWFMSUN1OFdm?=
 =?utf-8?B?NTdpcTI5NDVLWlQzRytJbTV4VGdVd1ZaWTRUSGlwdW8zQXBXeURENVVTdWpF?=
 =?utf-8?B?Y3JGaE4ydHlZbnNZUVRZZkd4ZC9raVZLUkRIaU5EdUxpNDJsdkpxVkZtK2xU?=
 =?utf-8?B?Y0RKbkF2dlNSWHZYYXFtY3g0UFR1SXp2NTFENDcvS3hIcWljT3dzeUk0UC9B?=
 =?utf-8?B?N3RwRGo0aVp2YTFiZnQ1L2s2bDFFRXUxaC9BeWxKM2E3M0s0TUtqTGxpMWxB?=
 =?utf-8?B?WlRYRDZxKzBZSDRITDV6U2NZUU1xUjlZNHR5SUVkbjNDeG8yUEw0ejdma2ZE?=
 =?utf-8?B?K1lWZ0lwcGRHcTVYL2Y2eTFxT1FIampqZ01XcDZCWmVCcytNaXF2MXQxRFFB?=
 =?utf-8?B?QTNFcUY2YXd3T2JSaVhTUnhzZTlaRHBmRFhlZXRYUUkwd0FjUXlPUWExd1Va?=
 =?utf-8?B?eXVqR2JHN3RZS2lvRWNZNkMxZEdZZ3diRHVtQ1lnOVhLUVpwOG8rSzZ1SHdj?=
 =?utf-8?B?bklTUVRnS3JmalF3K2drQWo4ZUplRHlGVmZxOGY0cmJrUEE4alBuanRWRjZO?=
 =?utf-8?B?NDRCb3dVNm02STZQSkROR2k0RzJ3emxzVW5QTnp4eFllNC9HUDZrSE1veWhs?=
 =?utf-8?B?SnlHVDNMc09xL2RSeTVqUkM5dERYUVdFc3ZyZWNSZExTNGNXNjRvcDNSTklQ?=
 =?utf-8?B?ZTl3dzVZOXNRbCtOd25UOXNJVnNiaEt3Y2E2QU5jSTB6TnFMYTdueUhacFdv?=
 =?utf-8?B?MG5HeDEwcmQyMTZtTzBwTkdoVGxsTGQwOWxFWjBkMTFQQ2tiMGlTd2YxeFBi?=
 =?utf-8?B?dkVaWjAvano5YnYzd3JFbTdIQzVDZG9WaFYxb1dBeDFUM3RlbUpIbXduek9Z?=
 =?utf-8?B?U2VHa0RWY2NlTUZNVWRYdzcwUGIvNDBSdk1Iai9NZzVWWFBDSitSSnJmOWds?=
 =?utf-8?B?VXRRNlk3WDUvL0R0K0JXZmpWbTlUaWN0cGMzc29Vc3AwNzVaQVpBeUdJR2hC?=
 =?utf-8?B?eUZSRndheWE0Y2hiQWhnTG9aOEozNDRDNXhxOTF1b0RucFZxRnh3RWVzZUFh?=
 =?utf-8?B?Wmw5bTl0S0FtV2Z4alp3RDVpMGxpRzFSNmtIcTlJNHNaZm5GVTgwc3hZK1do?=
 =?utf-8?B?ZkZFZzMvNXdHTEN4M052dkp0LzZrMnV5aTF3dnFXSlVOTk5BR0ZreWJXZUZS?=
 =?utf-8?B?ZzJjQy9kRUNtUHU4a0hVSHFIcmcyQ1Y4VzNkaSs4bkwreERXLzQyTTNudkFr?=
 =?utf-8?B?ME1CYituU1BqazFCaVlaWTVwNE91bmdBNDV0bHY4bUlsY2J4dHA4RzIrTmU3?=
 =?utf-8?B?cjR6Tmw3VVprV3NrWEZPaitxYmI5TnBYYlpWUFRNeE9ya2JEZ1oxMThIWm40?=
 =?utf-8?B?YVM1M0gzVWEzYnJXUnhUWHEvVUt1R2RWWkZqbFkvZHFhZDUzOW5RenFVSDM0?=
 =?utf-8?B?ZGNuOWQzazRXWEFzRzZVcmFUL1Rxdy93N2M4TElhTTZVSWgvRVA0QjF6ejNq?=
 =?utf-8?B?dU9sTjMxVG9JdW1rV21IemNmaHp0TEhNdEVwSjhxclNXT1U1NG51K2hMYkhx?=
 =?utf-8?B?a3dSYmxJNE1JZzN1ODlELzUrSXdzSHU0OTFSamthSUcrSVBqMWdEQ3FpQ0dF?=
 =?utf-8?B?UlFjRFh1ZDFoZXlrSU11L3JESUVMWjlkMlpXUHdzdFhIa0E1d05VY3ZKcm9I?=
 =?utf-8?B?QkdyTFBKWEs2ZTRwRkdTcUJuWm1LSThYTURYcVVySzRUM0NtVENBMy9CcHVO?=
 =?utf-8?B?ajRHUkJaU292eEZTNm8xT05DNXlEVjQ3MTZUZGd1OXhXeVQwaktJaVVHSjEv?=
 =?utf-8?B?MS9YRUs1MGpGNnBNQXRXVkM4eUNpWHU5OHlaenJrUTljMEZaWnJIYUI1Wldq?=
 =?utf-8?B?NjV4VzZDQzREZ1pBZm5VcHFOTjI0SnhaVXJzSjBiekRKU2M4eU5uSzNlS2Nq?=
 =?utf-8?B?TW9jQzRTOUs1NkFuZk5veTJ6bzhjTDBjTlYvVFR6cGlSOU1sNDRNdkR3N3pz?=
 =?utf-8?B?ZW1nZlZMY2k3aTg3eXZzSXhNcTVKVTJtZUZBTitQbnVKYWJ4cW5kdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13651c65-3eb7-4b45-638b-08df3b001139
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 05:45:58.5454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3tApwhBH1tKqqauID5tZmS+91Mr9YjIYGLKEqxG13BeRzK5jMgCEW2w/c+/KmYnISPayI3jmX5gl6KHwsBF2tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3689
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 05 Nov 2026 05:46:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24636

On 05.11.26 06:44, Jan Kiszka wrote:
> Hi all,
> 
> Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today. Our channel is the following:
> 
>     irc:irc.libera.chat:6697/cip
> 
> The IRC meeting is scheduled to UTC (GMT) 12:00:
> 
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&month=11&day=5&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248
> 
> USWest    USEast    UK        DE        TW        JP
> 05:00     08:00     13:00     14:00     20:00     21:00
> 

Correction:
USWest    USEast    UK        DE        TW        JP
04:00     07:00     12:00     13:00     20:00     21:00

> Last meeting minutes:
> https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/10/cip.2026-10-29-12.04.log.html
> 
> * Action items
> * Kernel maintenance updates
> * Kernel release status [*]
> * Kernel testing
> * AOB
>    - status SECURITY.md
> 
> Jan
> 
> [*]
> Date the data is created: Thu Nov  5 05:40:37 AM UTC 2026
> linux-4.4.y-cip: interval 30 day
>   latest version: v4.4.302-cip115
>   latest version release date: Mon Oct  5 10:29:52 AM UTC 2026
>   limit date: Wed Nov  4 10:29:52 AM UTC 2026
>   Status: *Late*
> linux-4.4.y-cip-rt: interval 60 day
>   latest version: v4.4.302-cip115-rt63
>   latest version release date: Mon Oct  5 07:16:38 PM UTC 2026
>   limit date: Fri Dec  4 07:16:38 PM UTC 2026
>   Status: On track
> linux-4.19.y-cip: interval 30 day
>   latest version: v4.19.325-cip136
>   latest version release date: Fri Sep 11 08:53:07 AM UTC 2026
>   limit date: Sun Oct 11 08:53:07 AM UTC 2026
>   Status: *Late*
> linux-4.19.y-cip-rt: interval 60 day
>   latest version: v4.19.325-cip136-rt50
>   latest version release date: Wed Sep 16 09:32:17 PM UTC 2026
>   limit date: Sun Nov 15 09:32:17 PM UTC 2026
>   Status: On track
> linux-5.10.y-cip: interval 30 day
>   latest version: v5.10.272-cip79
>   latest version release date: Tue Nov  3 09:48:41 AM UTC 2026
>   limit date: Thu Dec  3 09:48:41 AM UTC 2026
>   Status: On track
> linux-5.10.y-cip-rt: interval 60 day
>   latest version: v5.10.268-cip77-rt34
>   latest version release date: Thu Sep 17 09:59:47 AM UTC 2026
>   limit date: Mon Nov 16 09:59:47 AM UTC 2026
>   Status: On track
> linux-6.1.y-cip: interval 30 day
>   latest version: v6.1.190-cip62
>   latest version release date: Mon Nov  2 08:01:07 PM UTC 2026
>   limit date: Wed Dec  2 08:01:07 PM UTC 2026
>   Status: On track
> linux-6.1.y-cip-rt: interval 60 day
>   latest version: v6.1.189-cip61-rt32
>   latest version release date: Thu Oct 15 09:34:39 AM UTC 2026
>   limit date: Mon Dec 14 09:34:39 AM UTC 2026
>   Status: On track
> linux-6.12.y-cip: interval 15 day
>   latest version: v6.12.114-cip34
>   latest version release date: Fri Oct 30 09:28:17 PM UTC 2026
>   limit date: Sat Nov 14 09:28:17 PM UTC 2026
>   Status: On track
