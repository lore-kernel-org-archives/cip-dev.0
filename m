Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4031D65C5B
	for <webhook@archiver.kernel.org>; Thu, 14 Nov 2024 08:48:17 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.61])
 by mx.groups.io with SMTP id smtpd.web11.32923.1731574090737009937
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Nov 2024 00:48:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=aKC4RNyZ;
 spf=pass (domain: siemens.com, ip: 52.101.69.61, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOEA3Mhv1sABcSyzwvxWg/omc5LD42jldF2CGoF3pqqSxdPAEui8z1RsTILYHYPdxVrCZeaOdkAHWLz0NW58zibAZXslqyjFGeXkyuRxXocJgrv6Fu2UOw5XnP4VK9ZVKXs1Hs6R3e7u+bAIeZzwCesq3dmpAw+DlS1o4mz70X0ClM0nvHVx2AshncxnyEQBQUuCqIxqfPpuR3XNcyuSoTXA318AHYyBFlCO8tdIVr5WwIBsm9IoIdzh5e37lUwhIqEVvELl5Jtxru2Ri1BvOdkdPBUVPO7/z6ddgxQ9u/2feXGm3nZ568seTIm8DxPBXLkrhnGfQbC5PG7CIBKXPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WE2zTRKudS/X6oOw+N4ioAhADKhcC3O5/T2pFng1ZLs=;
 b=Uxtg90LZBJJIys/WfhgsUWn9HeK8iXin23azMzbM3JZW+XYP2w+LRHpoZVqhf/wfw5tLV9kSwJCBIW1fRlUrqouKXTkPUG21He9PDbGV06+r7bSMsTCVATuKD4DfVq+D6sTb2ZfDG68kkMqIqDhvNybRR0TBYrxdF0fqd4Zlun6G88R9DGlUdCt9YtxVxb/CCrrHV6QvRDYVa1BaE7EN6o4HPMTn2mJsO/p55zRxqf06t1NEe605ZZDmr1avHqmnwCGzsL+czu6dhQffIQFtR248daITpxWIyHtS6GseCooYXcedEF16024vTAOgLnRxNUu0TNqGVPRPD9cP16Epkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WE2zTRKudS/X6oOw+N4ioAhADKhcC3O5/T2pFng1ZLs=;
 b=aKC4RNyZiR86HyVwFLAg9S0O12LqB6Rl/ZQuUdIzOZe5qfIM9RamSzASHyBKpHRiTTQdZeWvaKgqWjDKrA6EVxTlQ9wcrBZfnO7+CWlSXLIrgTXL93760NQ+guYyU+HxbOuPECCDMdwFjHp8W/ZCEtfIHnHwy9Yf1M7f5hVY9pK6PyZHn7JwtLTeWFkPy9174g91lF6pimE2hDtlcUoKy/Cxccku9E6SpwLAyO1BluzPjSJwTUaTsV2dkvvZbX10C4Z8WdnUYIAnHdNQIULTOy57VfALu5rmE5E/YrGhFDI7bznNjeLjfWWZfctyG6W18/4TzNEaYrvy1tArJw8JoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5882.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:396::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 08:48:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 08:48:06 +0000
Message-ID: <401e58c1-1359-43d2-a65e-67e3f9b97c85@siemens.com>
Date: Thu, 14 Nov 2024 09:48:05 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0048.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34a::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5882:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b62d10e-86c2-4b48-9535-08dd04890f01
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?d0p5VEFiK1BOcVVWSmZtd1dYaVlNRXE5aVRRTnM0dkpzeGRKYllMWG44WXF3?=
 =?utf-8?B?VldZR1ZFWVVITFpQRWRVdTBrSFVGdEZ6ckpLbnBHWVFXdzJaV2EyOS9pcnIy?=
 =?utf-8?B?azdyVWZCR3plT1JkM1NxTFkxWFpXOUxYUGZXZVUrSi8wVDU4dzZwMWY3QlBC?=
 =?utf-8?B?cTltUDF1cEMxWE5ydE1WaVlHM0E0NUdTcWwrVGthVlN5TWhsdzRSdnoyUTMz?=
 =?utf-8?B?VFZSYU5SZkNSMUVIa0prUDZnU3NyUGNUYzV3T3FvS1ZMd0hVOWRTSDFDZ3R0?=
 =?utf-8?B?VUQ2RFlSNGthZ0g2SWs4VGRvaElmejFic2FIL2R6cCtWU2ZWM1h5RE1NdGlL?=
 =?utf-8?B?N1kxRnlNYmY1K3hLS0g2UTdqeC9ya0lCcnkvb3FsNXpsc2t0TjlvcmlkTkhQ?=
 =?utf-8?B?TFlqbTRPNXZJWkpuaWVxRkdVRDF4ak1SMmNWaEd3bmUrWFVCRmxPcCswZ2tr?=
 =?utf-8?B?VXQyaXc2OElvbnlsMnRiVUpaUVd6ZmR0alV4NnZCWXNXd0V1VmVnT1pHSmlF?=
 =?utf-8?B?aU1kUUlBSXpOS1JMVlNRVXN2K3g3cmdxYWV2RzN4MzU1RXBZL1g0bFlPbDM2?=
 =?utf-8?B?bjlyOVc1ZDh0ZlZpb3N6L3JlWDVjTEF1SVpMRlErd3B6bVd0K0U2KzJ6Visr?=
 =?utf-8?B?aXk4OUF3bW9hbHA0cVFxYXREMTc1azZDUGl4UVBpakttT0pUaTNGbkxOdzFt?=
 =?utf-8?B?Tnkrb3hVa2FBMVJNUmE1OVluQ2dGQ0lrUHBvR2oyVTR5SGI3b041TDBVVDJX?=
 =?utf-8?B?b29OYytPNWxadk9xeWVtQlMyelRIZWg3SXZEV2ppbndTNHIrTWExMldXcVF5?=
 =?utf-8?B?WE1wa1MzaWU4ZFFiWFZncnNCb28vRkQzeFVFUXhFdEJaOEtjdEFlNENsdi9P?=
 =?utf-8?B?MjM4T0t6dW5UaFl2NFBLT21NbVd5Y09KRlhYWTNGWmt1d2hQWlhFci82dC85?=
 =?utf-8?B?R2ROcEtEU1I0cDcrU2ltM05hYWNXZnM1T3VDSTdVcDRkNTVwUE1aM3BQNUJJ?=
 =?utf-8?B?alV5MGdXMzYzM2I3WGI4U0svYWE4dGx5N0xRMHJuTzRsT0xuTGxMaThIUFRY?=
 =?utf-8?B?amgyVUQ2NXZUVXlsVzR0NnRiNHJPUC9RRW5Md2d5QmNIQ3NybjlmS1c0b2JS?=
 =?utf-8?B?b1VCT2w0Z3NYZFdZOUg0OUVqK3d6cnByRzhUTVBtMWtITWtZV28zbmpSUVN6?=
 =?utf-8?B?eGJzZy9RN3daanhNcmxvRjRCbjZoWEwrbDAwNWJGQzRyMVJSdy9hYmhVeWdN?=
 =?utf-8?B?bEJlaURKWnQvazZZczkxWnY4ellyS1RZTTRZQUE4RFVTVFc4UDI3Sjljc09h?=
 =?utf-8?B?cklvUHkvRUttZkw1TXNGdE5FMlVjd29KelNmelBsbldpVkdkOVprREIzNjRm?=
 =?utf-8?B?MzVhUk9LNjNzVU5qMGxWc1E4djZOQm1KR2tCeGN2TE1oRkhvbGhrUjVoM1dh?=
 =?utf-8?B?QjlwYnZyVTVFZTJlYWsvR0hwNXB5ZjFmV3R2NTVPRWlMTHp2VndxYlJJRlha?=
 =?utf-8?B?TEpsbFpJb0twTGsxTFFiVjVzTHBVU1BSUjNiUG1OODBjbU9Pb0VsQkx6RUdy?=
 =?utf-8?B?Y3FEUy9WZ3Z6Wm41YzFDT0pUUHRmVzc3VVZBU3lPTHVLVGlXOWp5ZTNPYXpz?=
 =?utf-8?B?ZjdhYUdyVnNBL0RDelVVVDRRcElueC9xbkkyWHpmODU1TjVDN3p5M3R0QjY1?=
 =?utf-8?Q?nIkRpj3USiRF+b/dK48k?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UHhEM0IwL2E0bjVQWDc3SFJ2MVNhME9XTkE2QW1vK0NJem5VL085cnF1ZHdS?=
 =?utf-8?B?MklqWWxoeURkaVNxRGxxOGJMSHdUVEpIN1h6RkNlRjJHY3owdFlEV1piblNp?=
 =?utf-8?B?RWNFTjZicUNLQnlNd3lwaW5xZ1ZieUdqNEl6dndKOTA0YVBzdkFRQVVHN0tN?=
 =?utf-8?B?Z1dpTy9HelpBTU5LOVpKcmhKSGM2Y2VBVTc3VG5kSk1pWXhxSjk1OG9Cejcz?=
 =?utf-8?B?SjFETm1PcXhBaklTeWFES3Z2eGRqWTBDVkJ6YWtDWVg3QVFQZnB5a3o4blQz?=
 =?utf-8?B?cEs0QnlvOER1cTBDMk5SUlRkY0ZvaEpTcFgvTGRFbkVCdi9oazNscVdUNXEz?=
 =?utf-8?B?OTlLcUFTa0Z4YXl2NlZDVU1abjhMY3RodHh5eHRwTXc2cmI0Q2p1Qjlwb25n?=
 =?utf-8?B?T1orK2V3dE54TFhMWkR0Z0JLTEc0UUhLdFNKaTM3ZlQ1YjJnMlY2ejhjNWhw?=
 =?utf-8?B?WXVmS3N1cEVCVkNBdklkUXlEVDdhZ3FiYitwMXZFeE5LQzBtZGZneldsTUxY?=
 =?utf-8?B?L21uV0h3UitEL2IrMkg0YUZJdnFGc3BQZm9rTmIzb1pBNlNEOTZ5U2NJMndV?=
 =?utf-8?B?N2JObXBWNGp0dy9QTzBzMnUxUUlLSjdUMnFwY0FlRUd3ZmdRdHE1UFYvRmtK?=
 =?utf-8?B?ank3RTJIMW55N1VUN0xQSFFBcUlkb1E0YjJKUjR2bXhEUndnZDN1MEpNVzNj?=
 =?utf-8?B?eWtaaXJkNms1WWFyMUFsTFA5ZEIzbXBoRkQ2YUdYUHFYZFNpbXdZQWhNL2tD?=
 =?utf-8?B?V2dUbWNGUkg0U29UeU0xR0pwTjhlV1FaeHJYdlAwMlE2bWdURHAxVUVQSmFK?=
 =?utf-8?B?STRvc0JFbGs3WXZRdk5VQ3NNbWdmMU50bEFnUW1XOFRoTXdJcGJLZW1VZnVt?=
 =?utf-8?B?aC96ZjhCTXQycWhpd3JJL0ErQ3Y3Uyt6ZHRRUFduU3ZBUXRINTZJZ2RIbWRZ?=
 =?utf-8?B?YjhzeVZiMzdwK0JNMHRONk95eGg1NzJLNmcyZW81c2xRaDltcFVoRUZUQTJ4?=
 =?utf-8?B?c25QN3dwc2ZNZTArZlhiMmkzcEZqZmNMRk1KUEhMRkgrM3hhek9odnp0VEJN?=
 =?utf-8?B?UTlRMkNKbG5FZzlEUWVDdlZuWElHWVphZWhvcXBxT0NLZmFBWkhkS1ErKzEw?=
 =?utf-8?B?RGswNThBOTNzV1l2eFBETTdkdkZoREU0OUE2ZlRKWkp5bmNudkNQcDRxOTJa?=
 =?utf-8?B?KzExUnJ3dWJrK1hYUG81Q0gyeitwcjBNS2x0VnBBRTNGUi8wdlRDL2F0Nkc5?=
 =?utf-8?B?a3BTQ0dzUHJ1VlExWVl6YThJbDNyVFdXZjNjNUJuQVliQXFoZ3EzQmFkRDMz?=
 =?utf-8?B?OEYzRy83NHFlRUljaTE1QmVIVjRSQVYrUzZwL2l5bG9qQms3WEdPRkhsQ1Qy?=
 =?utf-8?B?a2lZT2pLU0NIaVVNQm5uT0NJMHM0SVBDYVR1eVk5aXRkTDJGYTlHY1k3TzYr?=
 =?utf-8?B?ZEpTOWx5RC95YUpKRGt0blV3bjN5Zi9jYlZ0Y0NaTUhXRzBXS2orOTZGcE1N?=
 =?utf-8?B?SEtScWtKODl6VjFoZ29OazhxSG11TWZ3Q1c5Z1FtT0lMb3BDZ2thaHRMZHNj?=
 =?utf-8?B?RXBVUThnYkhJTno5SVY0elBjZmxJeENqZlVmNlBDdmNTbzhsQkRlSkVHQytm?=
 =?utf-8?B?Z3JlMVkvVW4zZGFKOWsyZDFtMCtEcmtwbWVhbHVrM3NYMFVlL0FSK1FmSjdn?=
 =?utf-8?B?anJ5MEtJYjFDUkZqQ0RQQjZ1Nk1DR3BhNnVCZDRHNlR5NWhIL2IzSGpYNmQ5?=
 =?utf-8?B?c3BaU0NWcnUvY2txNHdnU2F0RGZOdTBzM3FLWVRtTXVXRlFDa3kyUWNsRTJP?=
 =?utf-8?B?MWNEZmRhRVRvY1RicERVU3BwRnNGV0lpcWRjNW1jRk1KakVXeEhXVVg0RzY5?=
 =?utf-8?B?dWw4cFJzbis1eVJPRzdiTDV6azlzTU8xSGxsRERBYnBIL1FCVC9ZSlpOekNM?=
 =?utf-8?B?bWhvQ3pDcFY4UGFEZWFhaW9tK1lIbXg3MzF5V3NCTTRjVU11MDMvVzJGZEZM?=
 =?utf-8?B?dWxEMWVMWkdhcGhnVDY3SEY0SHMzR2E5YTlMNy83Nks0cDhUdWV3M3NxMURy?=
 =?utf-8?B?YlkrNGdaSmZDSG5pWHZUME1wV3ljYVlEYlpLRW0vVVY4T2R4TzFQNFdBQWRr?=
 =?utf-8?B?VWJ0aVdaS1pmclZQRmd5ZEtoMGN0K2R5REZpenI1cjdxVGpzOXlHQlBNVkU3?=
 =?utf-8?B?REE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b62d10e-86c2-4b48-9535-08dd04890f01
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 08:48:06.6734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5cVxW8rj8jOStrgl2U0DDQvzIsAyjSHO79HeuL4WTHrgoPe03z+Tx/R4TS08liLfLhMHNghpohdoiCujwkBhcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5882
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Nov 2024 08:48:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17251

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&month=11&day=14&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/11/cip.2024-11-07-13.01.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed Oct  9 04:23:37 AM UTC 2024
  limit date: Fri Nov  8 04:23:37 AM UTC 2024
  Status: *Late*
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Mon Sep 30 09:48:28 AM UTC 2024
  limit date: Fri Nov 29 09:48:28 AM UTC 2024
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Mon Nov 11 07:08:57 AM UTC 2024
  limit date: Wed Dec 11 07:08:57 AM UTC 2024
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Tue Sep 24 10:34:04 AM UTC 2024
  limit date: Sat Nov 23 10:34:04 AM UTC 2024
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Mon Nov 11 07:28:28 AM UTC 2024
  limit date: Wed Dec 11 07:28:28 AM UTC 2024
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Sat Sep  7 01:56:36 PM UTC 2024
  limit date: Wed Nov  6 01:56:36 PM UTC 2024
  Status: *Late*
linux-6.1.y-cip: interval 15 day
  latest version release date: Mon Nov  4 11:35:47 PM UTC 2024
  limit date: Tue Nov 19 11:35:47 PM UTC 2024
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Sun Nov 10 11:47:28 AM UTC 2024
  limit date: Tue Dec 10 11:47:28 AM UTC 2024
  Status: On track

