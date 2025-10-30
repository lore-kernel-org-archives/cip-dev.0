Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B129CCF9F6
	for <webhook@archiver.kernel.org>; Thu, 30 Oct 2025 06:20:24 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.20])
 by mx.groups.io with SMTP id smtpd.web01.18051.1761805222925879294
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Oct 2025 23:20:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=iy+H3Vxq;
 spf=pass (domain: siemens.com, ip: 52.101.84.20, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPkVKyeZrUReL0ClJL13miMwi71c2MHFT6zqrn2W8HgjBYuG9GNEIxkko94sXeQNfSpFwrjaco79Vd4vZ8FpJT4TZlIYX0rnx0GyNP6dW6yRfn4c111F9mE9SkapJEbzVo0inAXxmbVAB6GyVZpujoEZOddiPp9ExU+8zmRykzP3OQY7WoRMERVlniXnxnJISMiBQQDtO/AEr2d6UJAlYZufr2Cw7VW/6N3RVU2fTGVO4mHaQXWhOkjyX//wRazzESZDeDHGFp6butNtikbETYUhMx60wakkb+cRsLvxG9r/mkdvvWiICMDFzhmiIlcmoRGFHOeARuNynWJqwUDufg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50IbmJqWho0a3AH/3D0H4b7XURKZCqUNHsqtKOso7Jo=;
 b=dJlECzANhmQTKolHRtG6LhUikOR4UWCAKkYrxK4fPX987zKnfCTt18/LKAzJVuEnDdMhNrSJkm/37t4hcxAj6ckCYz+lepcmCBRuFMYmaWaPU+tx8RsF7WhJjl9YGRmpjhJYtLl6pV/EgVKWG1fq3E8cgd5u8KcmgoheOQ8n6yIugVu8+XZk1oeNgsDGt+uZ7yFZAwx7Pi5VM9qUXTwhXczvhVrcDPzI7LWqn8jluNEl+J34Ol6nE46bILaCoZnF4hVSqEKtWVZoSJVgQy6Lhyjk/VlLKE0WeIvJtU/fhCGov6Z/nvc8R2U2883FylzND5bnM6QknqSrDWa0GfrG7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50IbmJqWho0a3AH/3D0H4b7XURKZCqUNHsqtKOso7Jo=;
 b=iy+H3VxqJ5fntsC6YiDOBAQ4cnDeSSrQ+oAHPzeIrx0LLFfcq2YIZVyb1LlG4M7si6aCpSc3p9RDrr0jWQwn3EJvJfQeW93hK2jxKVP+P/ycQcxzseL4Knqb4VWqK5x1etW5W2CdGjzDH6DkDHFbIDxY8P+r/hc/tntzQiUwnDcazoZKVEfDGdc9kNqOeU/AThtHPfjkS2Yimkrh2YUHvBg36nU09mOkjt7dPaDmwVqbCO0c7JmPv6rux9oms3HdCAu2uaLq9r8mm72wDgya+ogmWcouG7d5xiSxczoNQzdL6wY70xEM8X0EwBD2j5Tkq1WlYWJmq+37UxXAvgTIcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7155.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:60d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Thu, 30 Oct
 2025 06:20:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 06:20:19 +0000
Message-ID: <c77da46a-cbed-4541-a61b-7380f928a3e5@siemens.com>
Date: Thu, 30 Oct 2025 07:20:18 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat (NEW TIME SLOT!)
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: 10a35e4c-2ab8-4ff0-0249-08de177c662f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ejd0Tzk3YXJzWGRydnhsMjgybEJ2OWthS01Ob3plakY1U1NHLzhpUDQySTlR?=
 =?utf-8?B?Y0VTbTNPM042QjBOcVM0V0FPbW1hQmdQNDdZaERUa2lkVzZJRyszdElnQ1FE?=
 =?utf-8?B?WUo2cCtJM3NsSy9ZT3lMR2U0d1FwUWQ3WWsyVkNvVkhDdlFydmZDWHM2Z1pD?=
 =?utf-8?B?VWJUcDcvV0pzSFdNQUZXVHJmbCtkeDdwTG5QREtoQlRxSFJ3c1N4QjhuM3NB?=
 =?utf-8?B?ZStsa3E4c0pCdjlUTWthYTJTUXFnRE9HdWpJUklVek4vaFErMGZBZzRpRzh5?=
 =?utf-8?B?bmxpTkh5WFh3bElHSGt0b2RmaUdYNHJtNkc0cWZELzdXemd0UnBJSlNJUEl6?=
 =?utf-8?B?akFaWlZTaVVnd01jd1VPYnZUN1FiVHliL1QxeFh2NFRvVmVpdTFkR1FnVXFv?=
 =?utf-8?B?ZTNJTzIwS2Z1ay9Tc1N3NjU2eVlBbU9MUFVaVXRzKzFCYWFYakZmSzd2b1VX?=
 =?utf-8?B?NU5pNDlua0sxcE9obHBXQmpWMHEvWVE0M0ZEQWlyWGxVVVNjYVBESjBSanZs?=
 =?utf-8?B?N3BDeWJBL0hhTmFGUFgydUxIeHMxK1ViSDFURjIrc0dnQWNvejg3N3ZsbUhp?=
 =?utf-8?B?SmJXSGVmamlEWXlBZHN2aDZ6NFRrbkFlTUtEQkpRaVlQN2VaaE1YNWcvZFND?=
 =?utf-8?B?aEhEY1RPNGtUVDRRYzBlMmRybklONVVmcXdSME1BeUtsY3VaOWg3aUhVUXdl?=
 =?utf-8?B?dkQrdDNwNUNBeGFlRlpGd1Rpb2VjamVrcDFwWituMTZSRE54OWtvYkNXRnNs?=
 =?utf-8?B?UEtEc0NzYjZ6SkJoalRrSTNITlBrYnlDS3lGTVplQ20zK1lNYnhVSWxPdEpB?=
 =?utf-8?B?ZUxZMi9yZFJtS3BXUjA3bGxrd2FMeGtUem9kdUNvbFBzenF4UVVCYjZqV0NC?=
 =?utf-8?B?Q3pXVHp0K2IwN3FBYXMyT0grOEJDQTlNdk5xRm1DY3BtTkhpZzNmTXJVRTF1?=
 =?utf-8?B?d3RNNWlWVWVSalR5MzFCMjMwYlJ4TUI1c3VubXBvUDl3Y2F2TSszRTJwRHJQ?=
 =?utf-8?B?L0F0b3NLNjhvSGlWWFBzcWNpT2wxekRqYWFUSG5xZ1ZTZEZsc3lUd0tlMFFH?=
 =?utf-8?B?ZmtrblhQMDhGTk5MNmJYV0VYUy9jWmxzWWgxU1g4VzA3cGllZ2RReWFXdk8z?=
 =?utf-8?B?Ulc5dWhpakdJdnd4WmkrQkFITS9VWHdhNnZNRVlCb2xleDgxamZqSHV1V3pa?=
 =?utf-8?B?OUhRNEd0dTgrLzNQREtyeW5PU0tYd1lnWHpSQVRuTlZzb2NzZGZwdDdteHpM?=
 =?utf-8?B?ZlBnRFd3Ni9oZEhCVExlN2I0NnpzZlZjZnRxQnhuUnRERlIwVlcvNnRJUlhV?=
 =?utf-8?B?cTZPZ1FYd3ZPNTU0YUQ2eGxubkJURE9XdWt6ck5PUHd2YXh0T1g1RGlsbFp4?=
 =?utf-8?B?UkVHK0JHSXliK1o2ZXlRWW5VWEVudHByVHIxTTNXaHQvd2ZjS1BwZERzaDhx?=
 =?utf-8?B?Yk5LNnIwV24rRW5GM090dC81czFlNXpTZi9CN1RsWGtyRXZLUHZlbWtFVyt4?=
 =?utf-8?B?RHZMLzRSZDNmVFNSQXd0Y01RYmhPWm94djlDbEthT3RaRmFqWUQrTWsrank3?=
 =?utf-8?B?dmEzUXNWZFJsNkdoeVp6ekRxanBGYzdTK1pLUkl5OTFJRDhtRWRYdzJJRGUv?=
 =?utf-8?B?ZzRhYWlKeHlCaXJVWXJjc0JVTHgvNk9QZ0dLQ0ZUM0xpOTNMSWs1YzRDMlJ2?=
 =?utf-8?B?THJwMC9ueTJiRjRhNFlKSG14bGpkZ243aGRQN3NJTFB6SUJxTHRaa0NHeENz?=
 =?utf-8?B?NWtxeklmY09QRFcyMHdiN3pEQkNieDdwTWYyN3c2ZFZwSEcrb25hZEpwZWxN?=
 =?utf-8?B?aUZ3V0FDZ1J2Ulg2ZXF1TnhyL2srL0g4T3doOVVDZWJMTHhHY05LcEh1bzRV?=
 =?utf-8?B?UWJVdHZMT3p2c2pJRWFUV3RDdng3OXBOV1o2Uy9RdE14L0E9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QStlSy9JTytRY3lkRnZJY3V0cnI4NU1naWIxT3ZFYUExNGxHQkpnTHFLZFhV?=
 =?utf-8?B?UFoyeU9mM0tEOUw4NnFodG1iMWtJM3VPT3VjSEowS0QrL1BiZk8xZ3Ricm1R?=
 =?utf-8?B?Vi8wYm5odjBvVHpxVWp6MXQ1Qkt1T2VIdmw2MVZaVU42eUpUcW1zOFBkVCs4?=
 =?utf-8?B?WnR4T3lLRTdRRjlsZHJzVUNvaU9HL1F0MFpJS0Z1Y29udmRWKzBiUURPSGxV?=
 =?utf-8?B?NUZZbDlEbFgxUkJ2T0xUWHIrQ051Uy9HVTNUMWJ0T0RIVHExNnpqZjNhSGtX?=
 =?utf-8?B?bHdwUDJTMDh2dktrVEpCb0VVNzV3UVhUdGRKaTNSTWY0TlZBTGZiTFdLY3JC?=
 =?utf-8?B?bWRsSjVtUlZHRDlqNUx4SkRXV1ZqNFJtRFZ4a25JdTk5dXNEbVo2bWswKzNv?=
 =?utf-8?B?cTdXcTA2QkxEb25mcHdBVVVZNWJUQU1QRFZPTnE3MElLYVRjVE0xQUJKcnkz?=
 =?utf-8?B?bDFuYXpJWFpPMjFDNlBwRHJVcjRGN3BzOUN3bjhCSGtyZC96VE0yM0JrVHps?=
 =?utf-8?B?K3AzWW1LOEswSXZuelNjM2oxZ2NUcGFBTWhlTXFJQXpKNEdhZ29TaUMvM3R3?=
 =?utf-8?B?N3JsM2MvVFJiUHNNcEdUQXdld0RwTHhDN2M3aHVqc3VxbE1RaWdyVElCOU85?=
 =?utf-8?B?clpDRlE0YnFmRCtPd3FJQ1BGaWNibTNGYW02amtjT1JVNkQwTkNkaHF0elA4?=
 =?utf-8?B?VHlFbE9tNFJpTSt2eVJHL1pCdGRlMDhMTVR6L05rZm5ndmM0VnZEektnditv?=
 =?utf-8?B?eVhzRUR3ZURBUXlPbXpWYjIybmxRSmxMTXVhWGQ2YjNhd0gyNWVVamFicFdF?=
 =?utf-8?B?YmwrcHVhcGduM3FXREtQd3BWeHBhb1pxdkpwQy9PR0JVV1hYU0xYNEZoMVpU?=
 =?utf-8?B?WEtCbk43cm5LSlVCS1JnU3h4N0hkTm5PUE0rWTk3UmFwcUlJQ0Era2VkaUxD?=
 =?utf-8?B?dEhEUkd0MnBya3NFTWJ2N0x5cEd5dTJUdlpkTm1FWGtKZk8rbnBKamZ2WVl6?=
 =?utf-8?B?d0R6WEVjTCtubjdySTNPV0FuL3pxWmM1L1VpMURXbmdxRnlQcmpoczg2MVhH?=
 =?utf-8?B?a1VWVjU3OFBVejlHb1JpaG5SaGFmZXZBVGNFRzZ5Y1NHTEVGYlVtak5IMHlZ?=
 =?utf-8?B?WFBEYzJWQmppT1lZd3ZyTGFpVXdJaFhSUWZpemdRZWNVQTFSYzNyOWtCSzk3?=
 =?utf-8?B?ZTRlVjN4OFpTZEFlY1doMjc4Zmd6Nkk4RHl6YWFVVVVYVU42QjFOL01rQWFV?=
 =?utf-8?B?Y3ZMWDBkdEltNjNiQStjbDY1bXpLbTZkaFZwdUpJTWFaRXpVOS9QVTRKQWhI?=
 =?utf-8?B?YkcwU1hnd0VVVm1RRk0wNVBWNWxUQzNydzNmR3RsVDlsbFljN1VOcTE2Q1RB?=
 =?utf-8?B?aEFhbzZBNGFDU1daODVyNHFLdUJheWhmem5kMEtqd3Y0dDl2c1VrVDFQc2Fu?=
 =?utf-8?B?VkI2djBmNk16SHE0U280dy9hMEFFbmdHdHZRR250Y3FoNHNJamFlSG5qNmlz?=
 =?utf-8?B?bExoNGF6WWUzZXRSclBpMEZuYmVJS2pkM3N5Sk5CZVB5N2JqL0pyenhBdnUr?=
 =?utf-8?B?Z0VwZkFwUVhseHpYSzNKZzRRcHg5WlNSc0N1UnRrYm4wbWw2K2VQWWlxYVJm?=
 =?utf-8?B?S2FlYnJ6RlhpelVVa3Mxb1VoRTl3VnpwMkY4QVZ4Slh5ekIvdVpiQ3lzZmZ6?=
 =?utf-8?B?QWd6b29OSXpvSzdVL3h2NWhQbmVjNEhnOU5Ha1owc2V4RThBTlM3dmkyTHha?=
 =?utf-8?B?QXVHaE1Za3Jtd1V6MzBKbXQxZEJFdE93ZzFPQ1Zaek1GOFZGRmJjK3lhWFRm?=
 =?utf-8?B?aTNnRFB0NjEyWDBqZithSVU4MjU4cTA3RXE1N0J0NTdnTzltMjJnQ1pHQkZ5?=
 =?utf-8?B?N2ZyRmw1UUo1N3FOUC84MjJiMis5WWVCb0JWQnkvbTM4d2grVlRiNlNtRXhX?=
 =?utf-8?B?WmY1elZNU0NLVFIyUlp5dE1YVG56ZDllanI3VE5ycXZHdXV4bW5FM2NOTUFj?=
 =?utf-8?B?RmVQaGJTcDIvdUZGRy9qcmdXem5Yd0tRdnN2YnNXZGJwU1NVL3pEdjBadmhj?=
 =?utf-8?B?dUJUdWJMcmRvRDc5ZVdzV1FFWGtsZ2FyeXYwZFFCVHFCdmVEdG02MkV2RWlI?=
 =?utf-8?Q?kIlr/pDvi3F8bOL9VvPEUqMFz?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a35e4c-2ab8-4ff0-0249-08de177c662f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 06:20:19.4617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mtGhEVW6ifEgkfodnxcTbOf4kWskVu8QGp6+H6KugYvHFCkSHPHleO7WoRjF9wohag4FqWxR6eLZeWc7TssMqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7155
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Oct 2025 06:20:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20279

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) *12:00*:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=10&day=30&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     12:00     13:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/10/cip.2025-10-23-13.01.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
Date the data is created: Thu Oct 30 06:19:27 AM UTC 2025
linux-4.4.y-cip: interval 30 day
  latest version release date: Mon Sep 29 02:11:50 PM UTC 2025
  limit date: Wed Oct 29 02:11:50 PM UTC 2025
  Status: *Late*
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Sat Sep  6 09:10:31 AM UTC 2025
  limit date: Wed Nov  5 09:10:31 AM UTC 2025
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
  latest version release date: Wed Oct 15 11:57:26 PM UTC 2025
  limit date: Fri Nov 14 11:57:26 PM UTC 2025
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Fri Sep 12 01:11:18 PM UTC 2025
  limit date: Tue Nov 11 01:11:18 PM UTC 2025
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Thu Oct 16 08:01:41 PM UTC 2025
  limit date: Sat Nov 15 08:01:41 PM UTC 2025
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Fri Oct 17 10:54:36 AM UTC 2025
  limit date: Tue Dec 16 10:54:36 AM UTC 2025
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Tue Oct 28 05:10:10 AM UTC 2025
  limit date: Wed Nov 12 05:10:10 AM UTC 2025
  Status: On track

