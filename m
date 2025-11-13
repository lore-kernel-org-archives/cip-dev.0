Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E47ECD4F2F
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 05:37:35 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.70])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17355.1763012252845822891
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Nov 2025 21:37:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=bZvVhQfh;
 spf=pass (domain: siemens.com, ip: 40.107.130.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZTfFiQiGlKY/27mTqI1pbwKEpUc8CliMgOa3fs7e8TK/SzfCieD3WdkPgUUmgQlPM7nmvXplfFrqglaQYrsA9HTanek54FLp+GiHWyaPRNJ5DgyTIJyYhphhpW7wbQ3dG00hvraeiSnY2HhgF6oUk3ZopG9xTJFYPGQ7JRF458gldaBc20SVGusLzRK2u4+bcw2EPJJtl7O+9PD5rw60ZaESu0Zq/w5N/nrMijstGB6GPVpCi+cE7C+H3Q63/4eHS6SyQgcT8BwP+51Euxu1aKGUlfzrWorLwzZslZs2rGdcbfdvE3X+TTXtUMU6RwZA50e1K+qoIV+BoIcIVCqFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlj60jfAD8cDn73XyDYddlakHk/uGF1D3RisqvwVgMM=;
 b=cwBEUvbPiA/EdfR0T5MVCdj2+XBDA+D7Dne2Rw/xBt6v8plGis67prKVJQFlMXh1wR+LMY12uWUWuTsBUNKjL6cZWifAnEXvGtzXepNHM1hJQ2gNVGXmyku7GIjDQWNELJ0kBmYTCDCsrTDNgrCqhHLoTsdPxEh7nwx0xEfeFZnpx6AAEAV6qxAbi61QCIFRYRCrp2aujXbYs4kuwtFVSOnwyL8HG13dhjGhiPInNV+6cgP/DQ9tkFnkLc96uOYOIelArCCk0wOjpoAgS0tV83bpi7VbC/+41+9f/470H3uE4Sx89wAGbYokzPN6f44RvwCUEKsalse3mhX1v4lYkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlj60jfAD8cDn73XyDYddlakHk/uGF1D3RisqvwVgMM=;
 b=bZvVhQfhwzC4VbaXg8DqkG4PA9HW5TW9Vv/fzz8811EkcfHoCaIa4WpeGWKx11qvd6MFbzklgT0uoF8Zs182z4Z9Op7yphq3vdvR4baIKK3cN6oBvhfzkVySGyY3PLgu7qFsvQ4vbLs0ryZMNPTEhvibCxVx2A3uGySRK+eJ6e1blx6Ke6s/XywZ4SNSYhzdBj2ykCDwNriKXSJmOg47lobBB8XyX27TRNOQQVNeMdDu2If3qS+X38zNzfZcvLkA+p2j8vM2F53SkoF2xlYC3i/8FtiTVvKB5pv/8TKfBU3wcckDo5LBarhSuQbpdiSQbKYaSrakUSn9sSWtMu47vA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6132.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 05:37:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 05:37:28 +0000
Message-ID: <2082e0ff-07cc-4d83-8767-21efa3e89d80@siemens.com>
Date: Thu, 13 Nov 2025 06:37:27 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6132:EE_
X-MS-Office365-Filtering-Correlation-Id: 857feb1d-24c1-4429-cc49-08de2276bb5b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ejFuZ1R3eEY2Mk1TTlN2UHJsbXZSaGFCMUZETWJiZnp2N1FtcWQxZjJuQWdV?=
 =?utf-8?B?SVhKQXpGMFhmMjZVL3Z1SlcxeG44cncrSjY0VFY5Zk5qazRHTjc5L1I0UEFy?=
 =?utf-8?B?UkZkMURqVkJwR1N3SkhhQ29WQlpYWHhhbXZSMkNPWnlFRjV3MVozNTdrZWpQ?=
 =?utf-8?B?WStGM3BDenQwcExGMHdUbXdiRkppalVJSXR0M0UzR01ZN2dtZ2tWOFVuSVZj?=
 =?utf-8?B?QlVZSE4yVU9jQm4vNFdUQm8yRCtoSWwvL3E4R1pLdGhjNEk4cnN3RzQxYmRh?=
 =?utf-8?B?NXIrQ2p4S0x3UHQ1ZjBvRFJqRVgvR1Nqcm9Ub2tKNzBJYnA1TFFkZFk3ZjdY?=
 =?utf-8?B?ZWY3aUUvUUtWZG5QejJDZDBWRE9MY1NXOWRaWkwrSHk2SmtFYkJnTjRNQXR6?=
 =?utf-8?B?ZUZxZU1YTFFjdkMxSGRWTXBHR3RSdlBtNllHYXR3WGJOekpIOXlKdGM3dWxL?=
 =?utf-8?B?bElVbG5TYkM2OHFQRVJtVHJTNGZ1RHdSbVBlUml1TjU1VHFEUGlxaTdpTmFk?=
 =?utf-8?B?aENuVWducERNTU9SQXpzSTJWWGlRbTRQa1RSUTR6V1ZDTVpzSE1iNGplRDZO?=
 =?utf-8?B?S0hJbzhkUjdlMUhZZDFVMEJvbnJvSlNpb1M1cGRVOWRqcUVITEsvRDE5bTh4?=
 =?utf-8?B?T1dXaHkya0RMNFVOaW15eGRhaEgwdWg3bmtxOFYvSXpVdFJHSW1pMUxHSEZr?=
 =?utf-8?B?aWhPbUprUWNMNFpxZ2xaUXQ0YkV3SHRPODlZYkM5SW01SWdtMFFtSURDdVcw?=
 =?utf-8?B?dm03aDV2c0xlR0llTU82S0s2emZBZldiOHlzMzZ6L2FjSzBOY2wxZHE5VG95?=
 =?utf-8?B?cWxwRGRLRDR2cTVYR203QmZpM2ZPTUVRbnNxTWlka05MdFdXaUlHeFRqa1Zl?=
 =?utf-8?B?V09FNjBTMlo3bXVmTS9WdmFmMlZiRUlSMy9mdEhBWHdMVmF4WTJLZk1HTHAx?=
 =?utf-8?B?M3FZQ3dVRVZ0MklIaU1rd09remJLVEcvWFVyL3l4TmQ1SEpVZUVDOGo3YzZV?=
 =?utf-8?B?MVB3K3YyMDdhbTFyTHhCaE5GdUtzRWY4dDUyaVdXNkJBc210dUMwNnhub1VS?=
 =?utf-8?B?VHl5ZS9LZXdLcXZUUWlZOGoxZ1p4ZHplTnRrcGJhZE1wcENjcHVuWGhqeWps?=
 =?utf-8?B?YWF1Uk8wanlOKyszZUxveEszelNhNHdqT0N5aXpsb3V3NlQydHdTMk56VS94?=
 =?utf-8?B?Mm9sQ3lxMlI5MDQybkZlL3pWSFZNdFFjd05iL1FYajBPc1Z5TjZuTnNNY211?=
 =?utf-8?B?SFB6ZjJXdXZpMnI1Sng4VFNDeU9hS3lQa3VnamdHdkNnUHZBUURveUZJYnkw?=
 =?utf-8?B?ZHI4cklhb3FyM005MEVwbTN3ZGZaMVlGUUdqaUgxZlI2VkVQRUEyTGdHOU9i?=
 =?utf-8?B?TFFpNVV3alk1R0MrR2hjMFArbzZmRU1tMWlYQlZRY1l1bEhUTlR2T0g1YWFE?=
 =?utf-8?B?N2dQUVB1aGJ4NGdBdGUvM0Q4MDBpVWxBZmszdGFSWmFSRWlSVmdqT3k3bHkw?=
 =?utf-8?B?WFFmU0JqRlhLYUdMOVhQMGJMaUtkUkRnR3AwR3AxUFZobER6UFZiSzVZb0ZL?=
 =?utf-8?B?eURrRXVLTjNzMi9yMnk5QjBFVkRKSVJJVmxmK3ZqbjFxajBEbTUwd1NUMHV4?=
 =?utf-8?B?ZjFJNjV6T1lHbGpxbU9YUTdZL3lkNUJLa09YTHF1d1NsNWVIUlMwcFBiZ0FX?=
 =?utf-8?B?MjBnVGtSZzJUeUVFQy9zRFk0R3ZRQ3F6YXc5WmVBdXAxV1VrL3A0K2xaczlk?=
 =?utf-8?B?RGpkMDRRRFBXY01qcjN6c0hoU25DVVZtcGorWFlHQ2tCL0hqaStpVDJxYllz?=
 =?utf-8?B?YW4zKzhYVytTbTNsdnR3M21xZmgyVXloNVl1VzY2MVhIL1F3T3ZUU0lkOXZ6?=
 =?utf-8?B?dFRLVXFkMXdEN3BiRWFTSHpDZ214SVR3OTg3c2NUL1hjcWc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bTAxRzhBNTRuRysway9Fak1YeGpRY2xhdmVSaHNSMzREeW56eUhXczJlanJD?=
 =?utf-8?B?NGNFaVlFcmNodVljQ3J5MkVUZzBsSk5BR255WW1Ja241MnY2MzRIS0E4VS9E?=
 =?utf-8?B?ZmJjL0gvSUMySFZuR1JvTGJoejArei85SW5XOHVqTkpoL1U1aVRrR1BVR21n?=
 =?utf-8?B?dDdnU3pvdm8zck5qbjdmWGE1VExYV1VJSy9hamJtYW5xbE4wN05rL2hlam9Y?=
 =?utf-8?B?RmExcDlURXNJKzlnYzI3UVZwMDQ3MHJlSExkdVFGSUtnRUI1aDlJV0ZUQWRT?=
 =?utf-8?B?MThaSUJ2ZldrNE5XL00wYTZmVDh5NDU4QzRRaWxtTXlEUVRwSm5IdUhHZTVv?=
 =?utf-8?B?VTRkazY1eThJaExGRWQ2bmwwQ3Z3Um43Q1hsNUJVeDJOc0lweXRVSVJoc0Fo?=
 =?utf-8?B?alplOGN6S0lJNVlFZFh1Y2t5enVNRHhHdU1hRU9WeDN1cEtjaWZ0dUdYQ3NS?=
 =?utf-8?B?UGZTR3VCWFRWY3pReldQakxpM2lMemo5TDFPR3FUTnZOeStCSmovUElMRmk0?=
 =?utf-8?B?NWVjN0VQbVVGUVN4Q0pybXhMN1ZLbmVxWFp6MjJuVERTM1ZUZzF6N0ZvMU1j?=
 =?utf-8?B?dHVPSHhCVTAvQ1daWW1VRXQzeXM5azh0Q0gvakNLbnFHdmVxVVR2N2NuNUN3?=
 =?utf-8?B?aC9mVnV6cjFOTUUzemVaSW1QVHd4eUYvYU1INWh2bGxsL0tBemt1REtaMm95?=
 =?utf-8?B?UnBtejFrZzR3QjlldEpFY3hKelN0bnJUa204Ykx3SXhreVlQbFJBdVVmNnNE?=
 =?utf-8?B?NVptZGFSc2tsVGZXOW1aYjVyTm5Qd2hZbXFVTmZSL1lEZlEwdUhBVVhsVFQ5?=
 =?utf-8?B?eHBRSFdyY1FkMldwNURSNnZXMkZxZDVyZWl5d2w0RjNsRnpDY1E2eHpoMkRF?=
 =?utf-8?B?aG1yVjhKR3N0VDNwdlgwRm9lUjh0MEF4aU5rWDUrUFV0MFFTYzU1YjY5YjVU?=
 =?utf-8?B?TkRWTVVLd3J5OEpGU3N2SHVQc3ZEeWJkU2NtbVZ1SjEva08rL1BlV2h2aHBt?=
 =?utf-8?B?UDMvTjNVMkc2UlhoWG9jRWRuOE9vSGd0SUUyc2s1YnB3d1hOMlI5NU1wc0VL?=
 =?utf-8?B?NlFsMkVxYjY0Zm1TcVhnU0xRSzMvT25pOFR1cy9ScXNxMkxWTXpCNldHOHdr?=
 =?utf-8?B?L1ZadUE5TEU1WFVoRVhaZm04d0hYbEtFbXd0VUtjNXR0MU5YdkpCRnRTeDhS?=
 =?utf-8?B?TFhzTWIzREZQVDREaXBET2x4NUNQTzB1ZFNWRWh0WnhkTjNWZkhyc3ArVU9z?=
 =?utf-8?B?VmZxSnRxc2l4WGZVUXdHUEpndkFVZG1rbWM1NDFJUWRnL1IrcWw4M3BtcDkz?=
 =?utf-8?B?eEllNzhJdHlVdjFoWUJUbnNrWWZCZlBLL2MrZmExMjlTZXJWNTExR3puQk1H?=
 =?utf-8?B?OVVHOWx3elpJNEFZNklnUmlETmxweFU2MnhrSTdUbmthcWxJbzVaU0tWRVhQ?=
 =?utf-8?B?MHE3Q2F2WHg0SDRJb1NtUXROOW9oMTh5dzRNdktMN3JUdTdacjRZQzZ6Z3F6?=
 =?utf-8?B?alp4RE0yT3NqZTkyQ2tCRm9GcnVrVTBoMmF1Y3Z3NTBHU1ovNzdiUHJWcTlN?=
 =?utf-8?B?SWtONWtsbWdLVGhENjVHVlBUS2NBcHRxbVV4d0lncm0xUjRXL01McmhKREo2?=
 =?utf-8?B?cVhFOEplQThJRmFBR2JmWVF4YmVjTVNCLzcyb1dKYi9rM2lYM0IzZVpQQ0Jo?=
 =?utf-8?B?YWVCV0tFMk1VQVhhUTRxblE2NFJVU3RHRXNwR2VQb3VaSG96SHZwazl0YmRI?=
 =?utf-8?B?UmpYR0JWTU1pUkpGY0RDcHBkRVlaV2R3QkVXc0hjOVllbGxJclBneXBtRlJo?=
 =?utf-8?B?cTFmejRuQ3M0dHk1ZlI3NDFSRDNxd3E5V2N2Vm9qdHhQWTFNSmpoZjVLbEdn?=
 =?utf-8?B?ZDl2dU1JdlBKdHRScWNabVd2cEVHYW10R2JBN2FlaUROTUdvRkRrcGR3MXpt?=
 =?utf-8?B?aEI4YWJsV0JMWmlJd3FTeEsxNUNDemkxNHJ0OFA0Mi9RT1lDVWFHSEo4Q2NR?=
 =?utf-8?B?NFpHaXNqL2Vhb01iV1ZwczIxb3QzUENmKzZmYnI1YldiVTU5R1cyelhoYmI4?=
 =?utf-8?B?UnMwS3JWUERjRTExM0Z2aGFGMDBiZDd4Qm45VDBQMWhVanBHei85TUQ5bEgv?=
 =?utf-8?B?UnlxT3VHOXV2dSs4cDJVemdRRlN4SGxQRTJZVW41VmJVTmVOTFpUS1FvQjdS?=
 =?utf-8?B?cmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 857feb1d-24c1-4429-cc49-08de2276bb5b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 05:37:28.1262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xbSkVe+HObAprViApoPFZpf9Z3ssErkf/p8rziWJ+/9lO9X1/DZGVLmS1BW5SrCpbUgeS2cz/6ZbJndYk48DCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6132
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Nov 2025 05:37:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20518

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=11&day=13&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
04:00     07:00     12:00     13:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/11/cip.2025-11-06-12.01.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
  - riscv reference board proposal for next TSC call

Jan

[*]
Date the data is created: Thu Nov 13 05:35:34 AM UTC 2025
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed Oct 29 02:00:44 PM UTC 2025
  limit date: Fri Nov 28 02:00:44 PM UTC 2025
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Wed Nov  5 10:07:00 AM UTC 2025
  limit date: Sun Jan  4 10:07:00 AM UTC 2026
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Mon Oct 20 10:22:11 AM UTC 2025
  limit date: Wed Nov 19 10:22:11 AM UTC 2025
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Tue Sep 23 10:53:07 AM UTC 2025
  limit date: Sat Nov 22 10:53:07 AM UTC 2025
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Thu Nov  6 09:00:25 PM UTC 2025
  limit date: Sat Dec  6 09:00:25 PM UTC 2025
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Fri Nov  7 09:45:57 AM UTC 2025
  limit date: Tue Jan  6 09:45:57 AM UTC 2026
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Wed Nov  5 12:32:45 PM UTC 2025
  limit date: Fri Dec  5 12:32:45 PM UTC 2025
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Wed Nov  5 06:50:13 PM UTC 2025
  limit date: Sun Jan  4 06:50:13 PM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Wed Nov 12 11:22:48 AM UTC 2025
  limit date: Thu Nov 27 11:22:48 AM UTC 2025
  Status: On track


