Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB75C10F15
	for <webhook@archiver.kernel.org>; Thu, 25 Apr 2024 06:41:28 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.45])
 by mx.groups.io with SMTP id smtpd.web11.11075.1714027279316089927
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Apr 2024 23:41:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=hW7caSab;
 spf=pass (domain: siemens.com, ip: 40.107.249.45, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHdWcaf7Y3IK9CZyjNf9ig1ySPA05M6g1iqt8q5mNERXDAVxqW3GEreisA0DLzKp7mIbi44aHgXqZ7nTpGqiFfwRLnYsue61hmVj/70psIV7/HxYaXfNJ5CiASm+ANTBv5QTLZc+bnYfp2IfNxkMZ8I4ddqkBJOWKZyhe2yPESymri1f22Ach817ekpROrrUxRPVLwQ4S0ujmscdNjwqHOy/TN+WVlnC6YRJnPLNKpjsuxm5qoyih4xl0Et7F9SlmGwO0kNjsaAiXwyAobhOTAutQCQRdjkPpvH5WePmXPHDnibwEMOvGbmiZkj14vzDTDiXTDqKQcg1SAZdMIMSMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsttdtGK7yv57jLWLmr5PYX2SMcfx5IrEsyPc1WDqn4=;
 b=hvLYz+wr/KtUHfGea4kIfrIIdn0Qgz87SlSBzqbNyM0iNcNfy801UgoONL7eKWA0oIwrmHwJsPgzL6n327/bY+vqzxIJe1Qh3Flh4DpV5YCNCwLcO7Ibmo0PiksgvhYwmhqv057truUds00HHbNXDzxyfNvMn4It8VYLnPqqtPpoX2UwL/rR2rPuqtB5PnXIiqV7e8G14I4P+UOms/PPunIYnG/qINDBZYv03qQlLDx5AmsV3cByK99H85DKy9vwwjJh2KvP2qR5D4wa6wYv19Yy31GFCFsjnOtc7EiGO8yaqC9O1Ydvoy9Jo+qM7vQPFWxNN9ghCIFV/7sXFvdFbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsttdtGK7yv57jLWLmr5PYX2SMcfx5IrEsyPc1WDqn4=;
 b=hW7caSabc2vQe1c4LN0/LZ2NLvA01QoC5kVyOzBrF5azh3slEVZE2lfqG36/k4jOgeI5/ra+MxDHy0S/pVfeW//BuSsGgcAWuOjRd1AeBvhinuI5vrzGLSf7UtHyiJZEl/Ej8eMNC6hmGkXvlN04PnLmEUj43ZZ0xSV7iejE3ze5HCNcfccfP2U39t3dCwdcrCNYlLCY4F3Nme66e4hvADWvPMgzsfcRReBnKonhnSHVCJbwPC9pfzDBft9dVSoZ4Iw6GptviUI2DoqqfZ6leveQYdxYGjQSgAHIr9c2h4a6w8Xm7odUW/hubgM2/f5mHRBlOSXIqnrgQ81E2yLRtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM9PR10MB4087.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 25 Apr
 2024 06:41:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 06:41:14 +0000
Message-ID: <3283c176-3ed8-4808-92af-b5e16af941f2@siemens.com>
Date: Thu, 25 Apr 2024 08:41:12 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM9PR10MB4087:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d26115f-2a33-4364-dc52-08dc64f2b423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dVdNQ1F6Yk0rMnc1TkZPRXZhU2hoajB0cWxzQ2c2bG5iR1pPeE1JWjhvSFhG?=
 =?utf-8?B?UzA3NlpiOTAxQVI0d09hNEE2MUFRVklRSTdqNCtDaDNLMnhaMlFiNlV0ai9t?=
 =?utf-8?B?eVZBRkpHK3Z3a29nUlIxcVJ3NGQ1THhSVXkvRXNFek9XaVVRclZadG5WMG1n?=
 =?utf-8?B?dWxpVUhlQ1F2a1crT2dZdHFER0VPQzdmcitHMzFodHVmVWpmMlBTMm4rZ2FI?=
 =?utf-8?B?TDhhZVNXa1lDNEpFei9lM0pzR3hwd0t5azQrY2M2V3NxSG1hQW91b1JCSGdr?=
 =?utf-8?B?L2hmbDhaYTFBeXhPa0VndzRxU0c5ZkZGd2JrcEJLVE10ZmhoRTF4TGhObFE2?=
 =?utf-8?B?bExHZXNJM0h0MVdKREduYmVyUjgzS0VKcE1YY3VLeFhFdlg2STJsWHdESUsv?=
 =?utf-8?B?MFhzdlZFREhiZmk5VGxrZjRuUU9HYzFpblQzMHgvdHV2U3NESnFsUkdaTita?=
 =?utf-8?B?VW9qVnQweXNJVm9KalJIcFFqaTVodXl3TE5QMVhSRHVsYjhSNkRjNGxldUlu?=
 =?utf-8?B?NnNDRUx2elhadVJTeWZiQzZJZmlISWtjenkwdjFVMFpVb2poaFdUcTVHUDNV?=
 =?utf-8?B?OHNCUlRSWThkaFZJRkp6L210eEZPaGlyRThOK3NRaElWVjlLdHlYVmtFOFJX?=
 =?utf-8?B?aGpJeXE0N0dUemdkOFZKdERnS3g4djFnazNQcThMNHp4UnEveHZGWEtOakR1?=
 =?utf-8?B?TkJmR3hhNGsxMmZzSjNaSHFUNFVVMzA5Rnd6UWFBM2ZyMXdIMFM4Um96Sjgv?=
 =?utf-8?B?aFFwN1lEcyt5YlhZZklnY3RzL203K0VubWF6K1BWL2pGRGJsSXM0K24rUWV2?=
 =?utf-8?B?V3BxZ2NvYlZwQkxHNnpHdkRHU0p3VnEvaEFIWXBjeWVMWk90TU5nUEtvZk96?=
 =?utf-8?B?UHJRekxJTTVnQ1B2SWhIaXJIejlEWUNRYnFpRXJZSWVBb0R3RzlYcmRJaHZO?=
 =?utf-8?B?Y0c2U3NpbmlvMHVscWFUaHlGT0JzOFRsZmJKS1JZQmdJNE40dGUwaHZ2cE9M?=
 =?utf-8?B?Uy9nbXlDa3UrelNGTVZUclBvdG5ueGQ5QktRYUFKVUlOWmloM2RRYzd0QlUy?=
 =?utf-8?B?SEwwRmtGdm5Ycmh1ZmVMRjRDN2IvTkZkYVAzeXNxUlRCR054cys2YnBORVpx?=
 =?utf-8?B?QXZaenVvVEJNMDBPd1BmTjkrSlNUdDVjS1dNbE1VZFJ6VDFKMkxYQW5HRU1r?=
 =?utf-8?B?WkNQNlAwekx1d3JzRGVoTUFqWkRYMXJVWU02cWoydkRPSjUrbG5LSlExQjRl?=
 =?utf-8?B?cnU1dlhsZHpZZ00zdFVNNjRDRmEwZVJhNzMrT3NhZG1NQk1QYU5uU0ZlcFpC?=
 =?utf-8?B?ZEhIanNNenZadi9NMDNWdFZjNFNYMmxXMGVBTk4zZ2ZiZjBmdUZBdVA0WEs3?=
 =?utf-8?B?VG43SW5tMVQ5MmlaRmlBOTgxUGRpcnV4anFyOWtMY3ZFR2dQWFpTcm5aNUhB?=
 =?utf-8?B?aFNyeGlJNDVVckMyMDhkOU1DT0R1QktYWjZ2VlExQ1NNakpQMnlva2NMdlcr?=
 =?utf-8?B?eHFQNFJ6TDRZc2t0bWU4SkN2UjB1ZXFNV2pFK0ozMWo3MndEeEQ5RHRNV0pq?=
 =?utf-8?B?MjA1elpDNVhvVjVuNWhvRnlkKzVzYTNWeTNhWC9GZGNWNXlqbEJuSTMxUDlX?=
 =?utf-8?Q?5axc1D/EQYK9cGuRC4BnqM+MsauodxsXc00lW7ZW0dx0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SW1oUThyWHpyTFJyTUQ0NEl2UmJ2dXZzOW4vcEpSdHFHMXNaUWh2dVFwcmk4?=
 =?utf-8?B?elc1QVFJYTlHVU1PV0UxMHVEakNMU1JpOWI1SDZGVDY1eDZ3cnh1Rm5GVGs2?=
 =?utf-8?B?RFYzU3cyRHkwVWFjN1laMlJQM3N5cnNxREswQkx0azFQQktBTXNHbGlyTk9s?=
 =?utf-8?B?UXlhdXNtazZPSzBQUG9Ddml1ekFISjd1WTk2bXZ2UEticmdrVTRtNktxS1lw?=
 =?utf-8?B?eGVPeGs5c01yRzdFNXVpcUZtVUxMellEcGUxYmVWb09DVFhXYXdrNkhDbjNC?=
 =?utf-8?B?bEtkMWtZcUVMSXFReGsxaTY5Z1JlNEhqOSthVm9ETnc0dzJGVzNwM0hDMlhR?=
 =?utf-8?B?MW55MlpQWG5BdDVSZ0ZFT1JFa1dDUFF5bUlCb1pLMExuaXZDSjVXUS9Jazd6?=
 =?utf-8?B?MVVqYlF2THVma1owdS9MY3F0MW1CcndYaTR2Rlk0TFBrUTkybGJpdWk1S3Mr?=
 =?utf-8?B?ZHVCb2lZUzd2aEprWVIwK0Z1MEQ4UWFmVEZnQzBaaThOc3NrSGNKN2ZLRm93?=
 =?utf-8?B?RXBzdFB4eGsvdENZT09UZ2VYQ0hqTTExNTBKZUxyVDRTVm0zNVdjMnRrbjhQ?=
 =?utf-8?B?VUtrNzdwZkdodlVCVTlSRUJ1a2tPTTN3UGE3OVB3MVJBZmJmN1ZWamozdVov?=
 =?utf-8?B?VlFtZm1KWnNPamNnbnFydkJNUVNuZjhaQUVBdHVROTZJWUR6NE81d1l1cjJi?=
 =?utf-8?B?MS9hMndrMXQzejRzdnR6eFB0cTdXWGFOeHpsZzNnM0IxS1o5aEdrVVdFZ1cv?=
 =?utf-8?B?bnNiaXF6NUNFb2JaQ0M1dkg1Sm1lSCtLbDVkb0ptRnpTbE1TTVhBNlNrNndD?=
 =?utf-8?B?eWE1NjlHV3JGQTRsRHJvQVYvQ1doZ0hNVVZHRWhneTJzcGFEdnpoTFBQQkow?=
 =?utf-8?B?M2laVVlsWlkwSTlZVVB1OWd1YW5qZ28rLzdkS1lDbDBYckRSdmdIZmZ2cXpK?=
 =?utf-8?B?MkZKUXZuTk5XMzVhck11L2NSVGNJYWhKWXJoMXhreDdSWk1oc0g1WG43Kzdh?=
 =?utf-8?B?NzFlbDZyZDhjdWR1dHphNEUrQVNGRlY0VUVzOHAvZGxGZW9IVXFJOERXY0hk?=
 =?utf-8?B?MWFDNzAyK3R1YnMwdUR0OTNCSCt3V0hORW9LUms4NWljNUNKRnJzNHF4WFRO?=
 =?utf-8?B?TjlQejRsQTIvN29odFQrZ1VFdlY2c3E4TVNsczZ3d05LLzBGbUJoM1lIcWNS?=
 =?utf-8?B?aUZ3V0FGbWllZ1lDemFkTTVYMlFmVFczcVZpNXNJdUNFemtGczIvV3pJaXRM?=
 =?utf-8?B?YTJSMThvUDBFTEZLTmxETE1vMG1YODNyZFFidWxNRmIxVDZuUkxtMTBSTWc1?=
 =?utf-8?B?endzVDcvdmZlMnpDeFc0b0g2UGsvNm42dktiNVlPMEhrSWVhSnFnZjl1WXhQ?=
 =?utf-8?B?KzRLUzhETVJhV0dZNGtrVGVFZm96dG1Cc3dYL1BRTUgwYjFDcHJDMEFxdzRC?=
 =?utf-8?B?UHA5U2Q5SHV1REkxZUI2U3hxWGhxNnVhNEZyVElhcW9DNStPa2xPV2RMNTlN?=
 =?utf-8?B?aFdDTUhjVndXNVNWRHExNkVySnc3SFNvSFFMOHY3ZHVlRUFaZlkzNDd4eTQ2?=
 =?utf-8?B?NXF1Z0MvenVJdXNwVjRvb0pPNUlGaXlHcGFxWnhtQTJocjM0bjNRSHhnQ2px?=
 =?utf-8?B?Qms3Si9hanFCTk8ySVduRzZwVlRsTXpBQmpyaU9XbzFUcUw5cFEyREsxblh4?=
 =?utf-8?B?K3RKNGo2NlFzM2VmOFhIV3dwVHRUbW5ZZVYzdWdsdFpRZWFON2V2a3YyRG5C?=
 =?utf-8?B?VWNqbUFOaVBtMWRRUnJiRHVWbXpOYjhOajlYeFFhcUJVOXQwRFNyZ2FVWm5H?=
 =?utf-8?B?UTRxamY2QjkraU9NS2U0M3FwdTZNUWY5Qlh5T0RWYmRUdkoxTEJGbTc2Nkto?=
 =?utf-8?B?UTlkRDRIR29RS2kvY1Bja2Zkbk4vSVJ3ODdMOU9qS1VTTVBFUVlhZXh1cFln?=
 =?utf-8?B?QzhFSUZpL3Z1V0ozUGJCWnZaSDBuL0dic3dBbHpxTHNCYlZSa1hwOWhyNE1k?=
 =?utf-8?B?R2xGT0tCa1dPM0Zrbm5lRmplYmJGYk5Fc1k4a2ozeVVFb0VGL1k0QkE3LzV5?=
 =?utf-8?B?RnpnejBjQ2Rxdlp3Q2pBSC84ZWFXNi9ZbVBSbUlBMG1TemxxaGczTnQ4MWtq?=
 =?utf-8?B?Mzk1RE5TUnZsWitrWTZybHR5S1lpeVovZHZua0x1SGJFRGFGNDhvZ0R1eS9n?=
 =?utf-8?B?QVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d26115f-2a33-4364-dc52-08dc64f2b423
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 06:41:14.7567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NKPxKMjH6fY1GmPy2g//uOoHpqN5AKqqZiEbqjQ+/8g2UbhDNOW1/WOXMfEEBuqm8TnOnN80llDaO9uEYgZSkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4087
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Apr 2024 06:41:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15746

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&month=4&day=25&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/04/cip.2024-04-18-13.07.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed 10 Apr 2024 08:14:20 AM UTC
  limit date: Fri 10 May 2024 08:14:20 AM UTC
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Mon 18 Mar 2024 10:21:04 AM UTC
  limit date: Fri 17 May 2024 10:21:04 AM UTC
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Fri 22 Mar 2024 08:52:01 AM UTC
  limit date: Sun 21 Apr 2024 08:52:01 AM UTC
  Status: *Late*
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Fri 01 Mar 2024 08:49:23 PM UTC
  limit date: Tue 30 Apr 2024 08:49:23 PM UTC
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Wed 03 Apr 2024 04:45:35 AM UTC
  limit date: Fri 03 May 2024 04:45:35 AM UTC
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Mon 05 Feb 2024 05:21:45 PM UTC
  limit date: Fri 05 Apr 2024 05:21:45 PM UTC
  Status: Late
linux-6.1.y-cip: interval 15 day
  latest version release date: Tue 02 Apr 2024 07:59:26 PM UTC
  limit date: Wed 17 Apr 2024 07:59:26 PM UTC
  Status: Late
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Wed 03 Apr 2024 09:29:14 AM UTC
  limit date: Fri 03 May 2024 09:29:14 AM UTC
  Status: On track

