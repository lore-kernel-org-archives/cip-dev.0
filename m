Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.18])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3679.1793328165150830890
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 Oct 2026 19:42:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=IsOSdxKl;
 spf=pass (domain: siemens.com, ip: 52.101.84.18, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emTM/iNSZHnX/g8ym4OUuHDh+7sgzG2UeSv5ffb8uOnUT/A/mPE/ztfjQosrf8ZWrmYrMStDweE1Qj2SnMMNDrGUpB9O0+042Pwxtu4gLhjsQIpthr49XcBUIHBa5e5Ir7aZSmQ/85bslJmfxAiyzTnA8QK1w3kZj8jwXO4hVnQJaORPBcB21Qb2+RAhO9n2RprfwpSuiR5qJN/MdVWumHMIRd+GLfN06n49qAC70b3/wL+kV8sewI/GOTFVgyINYZKw3unUEoBcRNllSr6xyMYPpSlDwwyo0t5lcr/RTehqdD62qr09U5paUfncxizR7Hz1lTUaFc46h+JuGq8gtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtkJ1aN35EiyTZo93XgrRBVg7ax5l8mrONrhq6EN9eA=;
 b=rlFfCotFba8FoPYGf6QE7//0xOGxEEx4tOHUG3rZD7qOSlKiWhgsfL0Pb2cZ0WIRhZXiuA0PxZEfN19YRHEnCPlKdblDDmn0yZsuOjuQfh6y0iIDftfN2FDR+ZSxgycpM6gIVI2MWPXv+WQw+okGcVkq01Xzm5anJEvGnkcDI9k+DDmEACRlkQH+/36AAzX6SHlPwAa/gHv+R4d+3aUjwXABsrsFQtPBpRjnYU9643t0WhJEdDwPfZVVwAsxqAveFOTs78p19o1Ta835OGPNHi4lqTym865W3hqI1eO/bS8ppbnP3bqy51+g9u+WJFvRNMxjBvscIGuLCe0s6FNjxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtkJ1aN35EiyTZo93XgrRBVg7ax5l8mrONrhq6EN9eA=;
 b=IsOSdxKlnwFhxR7UDR38+4oQtr8GvLG9IvY/BKd2AHHNKj4IzxSZdleIGNw5bcGyzKxOZlDDjIKoMJYbOK0wydZrGnfn73K5wvlii9LGVFhfZH9WWBLHnHWtMpBsjBWN2mjB2yPYpSd6g0mVFRCCseAVNkej/NYQ1BcweDqiINCYPt5O5hdtoccqKw+fymBPx66m3lB9CWywkLuw9ONDEPD0J/JnCj1ihrArzH0pHFDxgTKJUENeROsqRHPic2Pbptx1bSsEQR1Frv/XBUsuAwiKEFWwVYHjMPTpoUQbd6yo7J9cLfKCG1qczi/1S9wbFlbjY4I0jNh0SA7MWcRsXQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AS1PR10MB5316.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:4a0::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 02:42:40 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0592.003; Fri, 30 Oct 2026
 02:42:40 +0000
Message-ID: <27271c84-9136-43d0-9769-bf45500f8946@siemens.com>
Date: Fri, 30 Oct 2026 10:42:34 +0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
 Ulrich Hecht <uli@fpond.eu>, Pavel Machek <pavel@nabladev.com>,
 "masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>
Cc: "Kowalsky, Clara (T CED SES-DE)" <clara.kowalsky@siemens.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: CVE-2026-98432 and CIP
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0436.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::8) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AS1PR10MB5316:EE_
X-MS-Office365-Filtering-Correlation-Id: 9abdaea7-a9c1-4b3a-2e17-08df362f776f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|55112099003|18002099003|56012099006|261022075727099003|261021121427099003|10067099003|11063799006|261009223027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: ZxAFwFIkA5fmMc9inmWoKPSRv00GPJM4B+vU8ANTis+SHbk4XM89hz+ZoGQXeVwr+qp7u2JEHuVvPbzfSfu3tm0aH/OyOFoqkeH93UlZo3MfpnctVyXtFJb/3IxAgOfNoPfoijneEmcSEdZjUJvrEZOnausVwrTm35uUt4P3nV+uNG877tUgj6x6SN5E7Xqv1/oVZQIaYKeajf+WvxhVG/6053Acg4sww+A7SSDt0MRhbtegCnhC7BC4Opfo5kTtBD9tObiYQr2J4w9vizUhjdy6ERZZF2Qd3r+qfB9euy3EkogkIUp1/6ob0BfCvomsSWfDHiVMU8uXRaxZ0v4ahZQhV/bV+2pAxeaWaTP2R99AWvaqEF2VxyGZzGpBZPMhewc4UHl9pcHtVKsMPSshL66hbtT5SBVAht9oCxVFzBCRaXyMfHhovYW0Ylx8Iok45QMjQXE2HutAI7YaNj7tvBk/Om6AFCcvNbC1qtD7LzUgH6adXAJbBGT11E/PxaoNj7pm5GFnlpV/YoS6SBtBjLNzh5K8r7aJPZVAdoIiJa2A9DLmezX9Beg5bw6gKBqNCAEZqUsWm7DYBZhb9vcyfkm9w2QMn2i3KcUBHe7r1WxXeRyrzl/csAU1E4sB/NPT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(55112099003)(18002099003)(56012099006)(261022075727099003)(261021121427099003)(10067099003)(11063799006)(261009223027099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3I5djQ4S3VaM0JjbUhsZ2k3ODNyQ1dRRnhrb3I4R3pWc2JWSnNtbnd4U21s?=
 =?utf-8?B?MFZ4TGtDUGUwNEtTZnVWdE9jRXo5OE9ZSk9JV0srRVMydnF3TkxoNTRBNHE5?=
 =?utf-8?B?K1hJaUx1WEFPOVdpcHc0VWxNUW40Y0d2ZTdoMkxTMVRDZ0VYZlhhOW13Vzdq?=
 =?utf-8?B?SUprakwxTkZDeW5kRXlYSFkxTHlBYW1nV25OdGNuR0M4dEdpNFhMdWxGVmFI?=
 =?utf-8?B?K2p1US9RRzBxQlkrQ3Bzcno4VmpKZVR4SzZJb3BPRjkzQTNPRmdMRm1iNmpF?=
 =?utf-8?B?c3VHWml0Rlp3MWNxeDFOZmVoaEV3YXh5cDF3T3JoR0cveURXekszemhuWXEv?=
 =?utf-8?B?bkZXUTRUU0Y4dGlRc09PYUNKRGJXaFlDRzJaZC9oV3RndG9OVVVkbUtGeVhS?=
 =?utf-8?B?cGpJdnU4NXNuYmMrYzdDWnBXZU5EUExEL2N6YlZOK3NzL1RQRTFpSFFoU0g0?=
 =?utf-8?B?Qm9WZVBoaXRrcnVOdHBYWVF0T0VyM1BhUmJOR093R293bldRVkpxbzNzUHhB?=
 =?utf-8?B?a3MzNDl1a2kwL2ZYRllvU0I1L1E2WHFyMWdQOWRtUEl5ZHJzd0Vnc1BCVGVX?=
 =?utf-8?B?b1Z5aVdEcWRBMmJvQ0NtaHhUYjJqQkcvM3dyVUpuaTJ3cUpGNXdqTXpBUWhw?=
 =?utf-8?B?Kzg4dHFnUGVYVEJUTXduOEN6dDdqT2dDZ29ZR0tyUFQ3blRzcmhVTzFhaVZT?=
 =?utf-8?B?U3BhVm85S0N1WkU3TG9IZitFM21mTTUzYVY2SS9PRVVMeVBYdk9uajNEcEVE?=
 =?utf-8?B?cktjYUwrOGpFRFlxaTJSME1yeC81ZWVFMEwzZlp3dlM2dUplZjhmRlFmYi9o?=
 =?utf-8?B?bmFuaCtqNDFpMXlXcnFJQlRQb2EwVzZCYVl2c3hrbVJtY0hVb2cxMjFrU1Yy?=
 =?utf-8?B?U1Q3Zy9RTWVzVVF1Z0tHNkdGTjNhTUR0UEYxWk5QQXhsQ01raTdhVTdEdXZT?=
 =?utf-8?B?Vitwek5mTjRmMHlRMENDNlgxb2kvTFhkRCtJQTE2UEcrQThpRmRsamV0R1V2?=
 =?utf-8?B?VlBYZUdSTjMxL0QvR1lLM1l0aGtoZlJIRTBnMCtmbjlJR1ViUTRKSUpYV2NX?=
 =?utf-8?B?QVkydFlZYXI0N2Fib2VUVWRnRFROZ2JpOTdCaEVOdCtZeFlzRjdyeUtXS2JB?=
 =?utf-8?B?Q2N1NkZnazlnS3htUldrSGI1N2dmOGIxRHhlYVplUUVWNm9QeVl3cVhRank3?=
 =?utf-8?B?V1VXczkrZWF1NmU3RFVrZjAzcnlGTmt0NUROd052MmpoQ1pvbWFHZ0RjYi9I?=
 =?utf-8?B?TU5sNWVNR0hMU3pJTVVvM1NmSzV4bGxKWGhLaWhVVXByYUUxMTZXQXdUUEMz?=
 =?utf-8?B?YnpKb1ZzMmdIZFBJalg5OUxvMWJ0YWhFelYrc2o5cnFsUTZ2OHFUaTB2NTNn?=
 =?utf-8?B?RGNPZ3l3WlN0MmtOMmZWRmZCZFRtVlgyVjNvTW5nMVVuYVA1Z21KQTR2NEd2?=
 =?utf-8?B?QWlVSDJ2Nkw5ZXRYcmZDQWU2SGRMdjF6dythUlJNelh2WlJMck1USWRJQ0Rq?=
 =?utf-8?B?dFluYTZJTWdHK0hLVGpmKzhYTXEvSzMza0p0cDBXaFN1di9zU1hjZEd2dEdn?=
 =?utf-8?B?Rk1ETHBRaC9JRHdBNDhjcUwwOFN2bHAwUjZLd1ZBYit3d3NqTG53ejZVRUZD?=
 =?utf-8?B?c3c5K2xMY1JnYzFVQjdxRzIwWHg0UnVXOEZ2QmZwdytBNXJ3TjBvK0gremMy?=
 =?utf-8?B?cXFwS3NEc1RDMzZOYkRaUTlvSm5HMVdVS2RGU0NOdU0veGlXWm8xT1d1UFY5?=
 =?utf-8?B?MGRqMnI5YTZYbGR2UStPa1lkblplYVBZeGpYeFhWb29VOUpudDQwa2d5V3Bs?=
 =?utf-8?B?MkdSUkg2WENic3FKUkdtQXdYaUptbkYrVHNCWDdBaEZLZnBwVjJDd2trcVI2?=
 =?utf-8?B?YzNUUGUzVU1yMFBMYjN0U0dhSEpyY2dqMnBocnhHSFlyc2FwSFhWVER0eE81?=
 =?utf-8?B?S1J6WW1qbW9vVWJnVFFFOUZNQ1o5dHF5SmxMR2RXTnlqVUdod0hUS2V2blRM?=
 =?utf-8?B?cjBPOGZOa0s1UWJjanVmWU9IbVhlU3MxREdtbk9kYnMyaWZXSWR0RzJqV3VO?=
 =?utf-8?B?WGlOemJkWW1zYVExeUN5bFVRTjVyZCs5TVFaaFlxbU8va09BQ3VhQkxtNVVy?=
 =?utf-8?B?VVVZSVp5Ulp4V2J3di9YRUp2clg1TGVZMGNlMi93YjE0SmNIR2ZZMHFCSnox?=
 =?utf-8?B?Ym9iOUFoeUhWRW9od080UE1lV3NTMHdMVWEzWlJRcTRLZEQwOElWY01xcHlW?=
 =?utf-8?B?bFlZT2FrVFdPRmRBZzR3NmNZZmh1c2o4bS9VajVRcFg5VG1vYkw4UWpNQW91?=
 =?utf-8?B?dmNudFZDa3AwVmtUcEhjSXErVkpDT3hlaUZYT3gvaWx2eVp3Q1lFZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9abdaea7-a9c1-4b3a-2e17-08df362f776f
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 02:42:40.5741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPUel7IM3PHk/7egIJDIj0De8h1foOzfh5UYCO2a2qN+AKNmsW3O6S957NtZuyFwlal1Llk79WvyfYP0SIKlpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5316
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 30 Oct 2026 02:42:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24578

Hi all,

there has been some media coverage like [1] on this two weeks old 
vulnerability [2] which is reported as "remote exploitable". Assessments 
still seem vary, though the tendency is "increasing criticality".

The issue apparently depends on CONFIG_MPTCP enabled, and that is 
fortunately not the case in most CIP kernel configs. Furthermore, this 
feature did not even exist in 4.19 and 4.4.

Still, we do have CONFIG_MPTCP enabled for 6.12.y-cip/x86 in [3]. I'm 
clarifying with our colleagues if that was by intention. The next 6.12-
cip release is due today, and we should then also pick up the related 
upstream stable patch [4] very soon.

@all: Please speak up if I should have missed something.

Thanks,
Jan

[1] https://thehackernews.com/2026/10/linux-kernel-tcp-flaw-with-98-cvss.html
[2] https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/-/blob/master/issues/CVE-2026-98432.yml?ref_type=heads
[3] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/blob/3df75973c690a4b433e8580e16c175e1fd959b63/6.12.y-cip/x86/siemens_server_defconfig?L194
[4] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=11a03ce3c4a62d84c10ccdfe47f8075006498568

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

