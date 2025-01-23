Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12843C02182
	for <webhook@archiver.kernel.org>; Thu, 23 Jan 2025 07:31:19 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.68])
 by mx.groups.io with SMTP id smtpd.web10.6101.1737617476498297676
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jan 2025 23:31:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=rxWirahc;
 spf=pass (domain: siemens.com, ip: 40.107.22.68, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XiN/YAplX70ZuGvqzHldURwOGZnsMus1Miew9gU6FQNQkEeh2Fr+HNLo4NCsNF7CFheTXg8Zdbh9nQfCKlf287YIfbH22ynrrMUlCFDbpQ7oRWzORlpNMuk+9poH3TrF6dgakVNq73zqFUzdDMoeJvfo1Ts4z3nk8LeFcC05mbamNbuJ6MK/d9jUvl99MCCwSrM/u9KdC0JE+wCFV5ZicY10QwuOV1OTWQXiIuUrCMUjzfLtJwgdFv+LwvAY2dE//mMeDVKT+VL8YFYRG5/Pk9lTbM5ljRdTHcAxMdE8Q8AUljVDAxPNaZoz4L30J/U8HxZeS93i9hoZUCefYU9goQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYagF0qUAGBrPtLyxNh/XuP2GS2G4pejAaqu40x10ZA=;
 b=sE3aoEcO+p1fLPGrCy2rVkrisH9Oe8aC1697/VPzAwOO0N9gd/7XZQ1qHnxaI1aJFTiOSk40Dk+lBAUOKKXxJ62HJn4LYyjGKh+v168G7nojQEltlcV7wA1wYFGjOwsgbGFc1z6iNhSP279F6Q2NJiIWxImi0I9lNkcifgtAus2OnEzNNLIhGp6fLgF0NwgjFP51OGqICnOjlgaQiSiCM7K9y3MtP0jpBGMjlaqXLZKjbthkJ1Nzs2WvN6xT6w0wqhPkX12fDZbxdzGUJRdvCdzNxuozNFuXJ3YX8KrESD8lc/e0sLK5jdYPsMnmOG/vugqaoBQy1o8uzABTsONDew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYagF0qUAGBrPtLyxNh/XuP2GS2G4pejAaqu40x10ZA=;
 b=rxWirahcq4rf0g4iS+XjOIbXaiEeJgAcdq0YiXzeVP600IWTWoKhqCSMXhi2vBSPazUqwcv6lDUwMGmHdnJBXQErMiTood+R+rEggm9Ir9mILNiFd8Ter3nkEoqfPxYviOaAj9QEOUdGBLyVvf6T8PISG4ja7Uy4unIyafhf3r/oqobR1mHiFALTEy0d2ovzd1hC0Gj/Uudqk0VDGrH2p3VnPbQzkYeI0PWPteIjL+S7yMKXmjxDYpk4DJwobgN9NZcTXixOYKNDbDzCgx1lOOFRwRSeTuV2RofhkeYsxFbBmC35N8YYfXICKsXUSm4W5TyDc6NVMHiIsPgTQBll+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8948.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1de::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.14; Thu, 23 Jan
 2025 07:31:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 07:31:11 +0000
Message-ID: <137e2abc-e5fd-4050-9471-6f27d33c6983@siemens.com>
Date: Thu, 23 Jan 2025 08:31:10 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0034.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8948:EE_
X-MS-Office365-Filtering-Correlation-Id: eba5c37e-1d2f-4f88-ccf3-08dd3b7fe8da
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TWVTM3A2NHFHaU8yUlFDR1ZBRVNuTHBvcXVENk1MTXdiRkpwb3p2UG00WUw2?=
 =?utf-8?B?bjYrUGZBT2RJbitScnViajZqQjk3UzFKL2xBSDZCdU9saHZwWmZIZ3V6UjhV?=
 =?utf-8?B?TmlSMTVST0FCQ2c1Rkw5WFVwalN1Q3RZSmlOdnNXUitRYWcvSE5MVno0YVdv?=
 =?utf-8?B?MFgrVDFDQWdZUEh5b2FqVXBRaUxnMm9XanJXWUw0eFdWc0FWKzJaKy93TFJI?=
 =?utf-8?B?NWNtZEM1RjkxWmIzUVMxcDJaMFZsNVlNMExsRHNMWlUwNkZnblQ3SWo1SHBs?=
 =?utf-8?B?RUdRVFNsYXl1Y2ZrVStuQXBWaUZLUmZtbllKU2IrRndkSHFnQng0YUlvS2Fr?=
 =?utf-8?B?a1VqV2tXSDBmdGR6QUp0Q09hN0o4NTFuWVk0OVBFeXFLRWFyeDBWK09TWjVE?=
 =?utf-8?B?eTN3aDhjNmdUUjR3eDNJa0xGWVR6dnRYRFYyWUU2SElHR0ZZUlp0ai9xODEv?=
 =?utf-8?B?clEzRFIzZGJqQUF4ajM0a2l6V2ZuNkRoS0pnUXdrTUxJcXZjemN4Qk5maGlh?=
 =?utf-8?B?L3R5cnVvSm9jZ2h4Qnk5elhoVTlId2haTXBOUk15RHYrTkJOaktzb3VDZU1W?=
 =?utf-8?B?MC9HT2JRcVRFdFU5V1lzZ3NQT2lQZTFGYTlhVUF2aG9CdENWMFFkSC9YMlRt?=
 =?utf-8?B?QUNIbDF4Qk5CZG13Uy9aUWNFRWxaVE1pTVBJRCtPclJaa1lOTXV1blJ4a21M?=
 =?utf-8?B?Y0E0OXhvWFd2UCtmbVZhT25IUXN0aVlVK3JmR3lnOU1wU2hCMThyanRFbnVz?=
 =?utf-8?B?RWhrK0Y5TU94NlBDNEJXeDZwVFU2TG5kMDZ0Y29ZejQ5QzJ6c2FmRG8rczdw?=
 =?utf-8?B?M2hiVDdremJKSXJ1ck1OSmxTUUp5WlBNM1NleWV2QVpOLzM1SnhDdXhHMkpi?=
 =?utf-8?B?YWZJWlBTUGpVU1QvZUQzYkpETEdxWnlYallZUnFzNGx0MkhRckNFRGwzRnZK?=
 =?utf-8?B?ZnZLUkx1UzZLZFFHNCt4d01MN1c3TTBIb1Q4dS83VmNYQTNvUW5LcUVIdVdI?=
 =?utf-8?B?cG1MTGtocEpIV3k3bXlNZ0R2SFV4ek9qMzVNdlBvaWMrR2JYTnhnekIvK3ox?=
 =?utf-8?B?c1pjQmJaY3pTNDBhRWdSSkdkRXcreG0vQnB2amlWeVdWMm9KNGdDYWdEdTcz?=
 =?utf-8?B?bVhpRDRsNHF6WElMQTBUTGFwdHlWZUNKY2M3UG9haTJ0RDhGRWxUcklXOU8y?=
 =?utf-8?B?SExOeVlGK1pWc2Y3eGRmUDRjOWNNcFoxbWM3MUgrb2tFZE5kN3BPNWpkdlJu?=
 =?utf-8?B?RTlaVXBWbU40SmRmYUlZSzF6cWl5NVY4RGhjZFVWbVdEQ3NqYTFMNDFpRU1Q?=
 =?utf-8?B?cXI1Y2tvM2ZDaHgwZnBHbmtvTVlkay8rNS9MMms5WFhrZEVIUnFzd1pSQlkx?=
 =?utf-8?B?czJJbUhlRmVISlBPNnF3MlZDS3JTSmIvYnRqZkdQeldBSDdwWmppUGtiUzFW?=
 =?utf-8?B?Y2R1ci9YaFR1Rmg4ZGp5THdVNVBzQkZxR21KSWR2eENVekxZYWpVT2kvZzM2?=
 =?utf-8?B?U25sSWg1dTF3dGdGNExNRTBMOXB5SXRkODRJSzQzRlRaRlVJQVpzOThXaDJX?=
 =?utf-8?B?MTQ4NmlzV3YrL0x0NHB1anZYR3Z5dStHeG5iWEF6TEp2Z2pGR3lCZysvVjVs?=
 =?utf-8?B?SG1QUmJaU0Q5YWtuZ2lpeGFkeHg4b21OMFg5MjlYR0NJNmQwRnhvam9tcjhr?=
 =?utf-8?B?K1RtRXlEME5QZFVYYVQySEtqV0loUjlJQTZvb3lkU01HRzJtVHFuVk9oTVlj?=
 =?utf-8?B?dUx5WXVhMHUrRGxXL0kvTWxIaFlnT2J0OVpCbEw1OVFtOWpnSkd5OWhYRWdy?=
 =?utf-8?B?eHhKM0ptZElSYUZEOW5CQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RHFSb1JTV3RNN1VBU0RDRXA1d1lYcTVyZXRvOHNCTi9ubThqQ1M3a09aNTJp?=
 =?utf-8?B?SU9PQ0owbXlnbytjQ0ttRi85NHNGYThzTk9kUnl4QW84QVM5Y1RpSXNWUFlZ?=
 =?utf-8?B?TGpPb1RaY1dVbjZYMFk2UmZicmRYMnFzbEFFTlNHeEhEVFp0d1pPUTRUMUdU?=
 =?utf-8?B?bHAzWVV4cjVXZnJLWVhkL0J6U1RHa3lWZkpzcU1SVkIrdXdkcGcxN2dudFBh?=
 =?utf-8?B?MVZUczlpZmprSlRvNGhqRGYrQTBTb0IwMjhmWllCNlRJQmtXTGJ3am1ldUVV?=
 =?utf-8?B?UUszUE80T1VOTlo4ZVJpVDN6VzNMQ1cxc1NKck1aYjh1WHRSQWtuRHM0YUF3?=
 =?utf-8?B?bk40eHlQb09zZmQ1TXJycEFhZnAyL0ozVzIxTktOSG01bGpLR1JIa0dPT2ZC?=
 =?utf-8?B?Uzh6QStoL21VYTEzS2dZcU5nTFF3NENvTDBaeEN5cEZPL1Nrbnp4VDRhcWJ1?=
 =?utf-8?B?dzhiek9pS3ZBUGZ6U2laaUVUWDNvVjFwQVl6c1FlR3BFTUE3MXZRRTFYK1dO?=
 =?utf-8?B?SW5BQlhNRXNDSGt6bkpqZTV2VVNZQ2ZTTWdpWlo4MDZKSkZma3lROUdMTWN1?=
 =?utf-8?B?aVFhVnZiSG9EYWdYMko2TlhMcXM2cnpSRUdiVTdNSUV1UWlrQm0rZjdxOU8w?=
 =?utf-8?B?bE00dS81NVh3ZEFveWRGanJMaEhCMENBeDlYUmU0STVEUW9NVzJuVUJ0a3dR?=
 =?utf-8?B?YTUzdG1VRnBPR2RZTnVrK1dVR2N1OHF1djl3VG5wUldUVnhRcEdWdjVYVTNq?=
 =?utf-8?B?VGNJWUFyOEpQemxSdmFncFdYK3M5UXBPOGlPNFlWcDE4NEVrZHpSNWpJRmFP?=
 =?utf-8?B?M0tjUmN5VlQyK25KUytaMDRmOXRkdjJhbjJ1WVBNVVVvN3BDOFd5MU12a25E?=
 =?utf-8?B?anRQUHA1aUNIMFdpMFhURE9TbWtYcHpubytWSGhVQ1hFRExMUzBMUU80aFdH?=
 =?utf-8?B?Wkt4Y3V4WmtjT3UveGo0Nm0vNWtOM2lOd3JSTWJlNENaQ25oR3ZJQ3pPeG0v?=
 =?utf-8?B?ZEhyRXJOOUNQbmVHWDhEVFhTSHpvSTI0TGJQUGZONGdkZnpiQmk1RTJGZzFk?=
 =?utf-8?B?dmNqek9NeUFEbkdRN0FxMzRuUnhiZW1GdWltTkRWRDVJR3kyVG5xV1lmcDlD?=
 =?utf-8?B?LzNrWG5HK01PNVF0RUUrYkhFMi9SNzQrVkRBNUZ1UnlqNFFDeWNEMEMzWGw2?=
 =?utf-8?B?L25WNktYOSsrYnNwOEhhVVd4MkpwaXhQYjNTRGJ5KzFLbjdwckJWRDVPYjZm?=
 =?utf-8?B?WVd5YytHTExjUjhQT0MvQzZrZDVFdlp5Qnk1ZWpoaHRDYkZzWW9WVTc2K1ZO?=
 =?utf-8?B?bG5NQkUxWnBLSWRSRWJpRWtEaHV5TXlhbU9SRzNjSEpCL1NXeVlQMnNXWDZq?=
 =?utf-8?B?eWRXdFBnUG5qU21rR3MxWmRlV1RJb1p6MlE0L05NMmd5ZC95dm9aYzR2OGNC?=
 =?utf-8?B?bElqbTgvR01ZbHpUMTJHYjk0MmR5UUhsYUFxV1RSRFhxL1ppd09vRmlwME9S?=
 =?utf-8?B?LzdNS29lZHB0YjhIQm1DVTZCVHhDYXByTDBLelRqMEhCVk9RNE9kN2VTRmMr?=
 =?utf-8?B?WmJxcCtmdHhUVFpWcTlJVGZ3bzBEb0ExSzdIcmhpYU1LNVIyaVAybE1jeWVm?=
 =?utf-8?B?QTVnOUpEMDkzcGFUVlJKcWs5SGRkK3JUT2NaSmdiTm42ZTA3RXN6bFFtS1Uz?=
 =?utf-8?B?NGN6UlRMNm5NbzlPM1pTVjQwWWdTNkJ5UXl6WXFCWFJTQ3hPVnI1SklYblFk?=
 =?utf-8?B?OHVlemw3NzJrQlJ5cndGV2lXbzR5aFZ0a3VEaUpwNWhjZzRRM3R1UU5GNEZS?=
 =?utf-8?B?eEJQV3lVQ28xTTZFc2JleFVJeUpsdFpqZWdHUTM5emcxTTJnMDJ4MlFML0g0?=
 =?utf-8?B?SlNtUDhHQ3gxSVRvSW9QN0tHQVl6UkRvVWIyUWJHQ0pRcUhndWZsOVYza3Uy?=
 =?utf-8?B?eklHajVHMURtZWNSaW4wZ05DQlpkQ2tCTGFFTE5DcUltNGZwQ3k2R09SdFU4?=
 =?utf-8?B?QlpoZ0k1UVkrZ0tYRDlaNzJNdGZDY01FVlBSOGFqdWVWQUdrbmJYYmhhKzJ5?=
 =?utf-8?B?WVV2SWZDWmdCVkl0dVg1ZThiS2xzZlA1RitQL2sxdFd2QlFWdnRxSHBSS2FC?=
 =?utf-8?B?WkNSN1UzaWFBK3ZaUVdhVHU2WDhObHdjOXNVVmNsMnBwd3BtVC9KcEphY3dj?=
 =?utf-8?B?V0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eba5c37e-1d2f-4f88-ccf3-08dd3b7fe8da
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 07:31:11.1559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T+V3AeNo0YGmYNHJiPHNlStp3W0vxW8X4mevqkUJC+uhtupJQOMdxJYQxqxV/NbJWLurUXWqWa4PwVLTTRVH1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8948
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Jan 2025 07:31:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17604

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=1&day=23&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/01/cip.2025-01-16-13.05.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
linux-4.4.y-cip: interval 30 day
  latest version release date: Sun Dec 29 08:41:22 AM UTC 2024
  limit date: Tue Jan 28 08:41:22 AM UTC 2025
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Thu Dec 12 10:45:41 AM UTC 2024
  limit date: Mon Feb 10 10:45:41 AM UTC 2025
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Tue Jan 14 02:33:46 AM UTC 2025
  limit date: Thu Feb 13 02:33:46 AM UTC 2025
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Tue Jan 14 11:41:15 AM UTC 2025
  limit date: Sat Mar 15 11:41:15 AM UTC 2025
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Tue Jan 14 02:41:29 AM UTC 2025
  limit date: Thu Feb 13 02:41:29 AM UTC 2025
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Tue Nov 26 03:12:05 PM UTC 2024
  limit date: Sat Jan 25 03:12:05 PM UTC 2025
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Tue Jan 14 03:04:39 AM UTC 2025
  limit date: Wed Jan 29 03:04:39 AM UTC 2025
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Thu Dec 12 10:20:12 AM UTC 2024
  limit date: Sat Jan 11 10:20:12 AM UTC 2025
  Status: *Late*

