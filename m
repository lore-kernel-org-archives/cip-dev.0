Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5B2C43327
	for <webhook@archiver.kernel.org>; Thu,  2 Jul 2026 06:04:13 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.13])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.63549.1782972247836274015
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Jul 2026 23:04:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pdeVGzsX;
 spf=pass (domain: siemens.com, ip: 52.101.66.13, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qOhb6KVtB1Iip8YuHx6nc2siCMvcLJI3inHy77XYEMmJtJCwPX/FJXfcTC0rn7HiV+e5EJhZ/ySN3xEDIK7sqDoXT3fxTICjz4Xs0EaT7e9InDWGUet1FApOAkNPNZC97ycop/yGh8HdY1hryfkGzs/IilxHNJos8q6o5C3or2ZQGpGGuK4lyXdF8TK13l+xwhXLmhZPmPVFFXZM2egrfjq1atdrxxKhAAba6Vqbhf8avxi68Lqah2jeITzbtptonN1ehSkgJDQcDwiEqK3lTWIv+33cfpsQe4IVwhHW4ROZ7CerK1ESl0e3w1vwgVvEijqpPoF1tEBpFDf0D22Yyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMAWGx7mBhdI+FkcUVrDDneX9n9jDL1Av81cXMR2psw=;
 b=XOJ8GrGQFRY0hA80Qr6j6GzqWtv1eiIvWI2LsZdSZmufNMsCu3UybFua0E3Ti6iUI9DZykljpPZCRZgQZuJtrsLCpnNVRTlRiGWBZBirTX6g9JMAbIppsyuMpplSF1gXj2jNeI86kncgeNhwlGY33hoK0jdaomSO6AmH3HELqJuDqqclQmSQCXxjHV+ZPmHx19ig5f1eefUvdtWIr/kqDDrM7pDRR7hGWCe4gbFzRylnMtdZ2YCFMGFB5QM4Dft437KiykdlwxeeWQyfmJFAvmuj8aE5rehyxQ0w1J9AawXU/ZMyYEO78Uf79w9rZ7D5TZ7xz575I+PkpZF/kMCPcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMAWGx7mBhdI+FkcUVrDDneX9n9jDL1Av81cXMR2psw=;
 b=pdeVGzsXd5VmBngqqkSVlH6CdnUOX7Z9HLs1z7z9kT+0rD4lf/n4P7p+I9a4UP4sQr3/GhBrxuEMU5Estj4QMRwpIPauTURDbudyJZnVKglmemA5ZH0Lrc9TkudktDChaXmONcrl2YHnU2zbw53ezC+L2R0NffeoNux1AsMYUvosU5BTfkfJ/MJw8wPaJf7s18Y20bhy/jqzmZpolXV95LKRunBggiZqXJuBUEQrqhJRkvJs1oevyUYCX2slweghaKbHBhJFbN2xMxjwLfKUMWdGozFjgLVSsFt6TOJSjNg44Aww0NPlwzmNuYT1QrW5g0NTVPkPGx91QKapJFW6rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3133.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:134::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 06:04:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 06:04:03 +0000
Message-ID: <860a8e9b-27d2-4850-91e4-d59247134bb0@siemens.com>
Date: Thu, 2 Jul 2026 08:03:59 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0393.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3133:EE_
X-MS-Office365-Filtering-Correlation-Id: 731bd486-79b6-4035-543f-08ded7ffb717
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|11063799006|55112099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	b6dxxZHhUTcWPq3GoEbK5Y+iDYbI2o5XT/CFAy8flkcBwlQQa0Xs+7quaWAos729AnKo2nmD0L73/1vwFNP5FO3xNnZ685wbjT4cJOkumTzSXODLjeoi1fFIinYmSt1FXaFJk96jl3APpewq7xO0RZVS8hjI1CVWKCpEVnZ00NXewEEDSfA7HtGZ3qMVo+HcJ4LhKX5YVHEr+/2yj3PvsqJs5+PPch3lz9AGlQVIzaJXKG9wXMQyV28uZWA9H4WeNH9nC5ekq24uM/MwqueszHUv2gPOEjLl4lGdCE6qEjuc7oIsiLPUqiJ0/7aT1jfcLP9Rdg1vfjrS/R2ng884lNMznAjLpn/VN+X7/JnvbML6evvr2BCQjDbi4gaTowizCKy4gdeMxvF6kOd1leClnF29QJidpHOkgQh42LUdcYqcM8ixbDKGdENsQhKmPh4cqdIK6ajIHTqNGHR0OvFK67LhHiCKgiRZ1jYFtJhHHYfnGyiCrwJEeJp/0Snp10fMn3WHekkwxmAaA5qyy3GBR5Lmn1Vt02IKscPiU/oJtV9sA1bJPnmmBOJjHRBh3SmQrUzUQ3jMSpKFpRMk0iwJprcZH1ZGpSPSDMIR0xpP5Vo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(11063799006)(55112099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MHFRRFhMcHdSeGE5S3l4ZnQrUTZrbWFheDkzWEY2bWtMb3dNdlhmd3NpVXZN?=
 =?utf-8?B?Z2pwQm1zY2laUGNsOHBSblBYOW00WGg0S21EQUdsSXlzRkx3eEQ2aEl3a2Ns?=
 =?utf-8?B?cHVia0NseEtsOGpmVXVsTFpsLzM1eVRFWndzTGpjbHplbXVnUlZ4U0dmWlZz?=
 =?utf-8?B?V0t5S0FVUUpCci85bmQyT3dxYkRpMCtqenFhQ3JMNzVlVTVQNnQwSnlHQVg1?=
 =?utf-8?B?Mm94amxtdVFwNUtBeHhlRXhEY1l0bVNrNWlhZjdNMVFzZGtNSjlsbGhCQVJs?=
 =?utf-8?B?bDNvcXhVcHFqY2lsckdFQVkwN0Q2TUVNSmlXMk1UdE1IeWFpM3o2dUlnTEZi?=
 =?utf-8?B?cFpEaVk2dzFxeGgwTk02QjB2a2x1MklnQmdNSXZnWlpwRlRvWlpmZTJhS1Vl?=
 =?utf-8?B?OWFGdTlFNmg5aVNuWlpOcEljK1NZY0FUSW5leDNuOHJtSTN5NDgwU0tMQ1ho?=
 =?utf-8?B?SUVidzY1SnBXS2dsUlZnU0tERzVBRlpLNzU0cXhSVHNDaUJCQUEwWGhxd2Vr?=
 =?utf-8?B?ck54bEMya2Q3S3BOeFZnandjWHBJWDk0RmRqMFNjcXBYeHpQTG9RNlJTRGRE?=
 =?utf-8?B?SkZldSsrQ1BKUWVQRWFYNjhHeXgvN3hWdHJGRVQycXNxRFZuREYxYnlVOVh6?=
 =?utf-8?B?ZzBBRlVjaXhqc0FlUlhkc3RHbXl3bVVFTVRkSUJucXpIaFdDWnhUKzVSRXIy?=
 =?utf-8?B?VHIvM3hBZ3NFZkVLZ3pGNFNPTHYzVXNRSG5Wa2t1ZmNPSG00VVpTWEswcFlu?=
 =?utf-8?B?YTJERXVnMVhyZmhoalA3OStqZTNxOWlUY0hrZ0xDNFowcXRYR3gvUGpYd2Fr?=
 =?utf-8?B?ZW1reEViOFIrR3BCZUkwNFMzNDZWK3FITmhEeUFXOE1YMXB0S2FvZWFEbmk0?=
 =?utf-8?B?bXlwY1JzMDlKZkNwRlBaQU5XaHlBNERmeWhaUkdnZnJXTVhqWVkwSUxoR2wy?=
 =?utf-8?B?TmlhMkVDZW03YmwyUCtvV0ZRbThsVk45M2x4eVNkWWMzRTdhWUZuT2Z4cUxk?=
 =?utf-8?B?dW4rSlpkd1c0R2RBWGRWODE1Z3F4SnJQYUpVUU4zeCsrTnRYREdEMmFIRTlG?=
 =?utf-8?B?V2FxRXh0ZWd0QUQvTHc2a3NNaDFRRzM4Vk5QWWxyRUhMcitFK0pKQktXSU1D?=
 =?utf-8?B?b0lqaW8wMkVwZjFnVktMQ01UQk5UYkhzb3RvRVFieStncjdZeXdiU1NRZ1pz?=
 =?utf-8?B?cUJRZGpGYjdaMm1IT2doLysvZ0R6elFaNWFsZUd4dmQzL3RWd3krQWFxc21E?=
 =?utf-8?B?Qkt2WkZ1MXh3MkhDeUR0a3hsd1JvUjh0Rmk0T0lyc2pBUi9PbEg3d1l4ckVM?=
 =?utf-8?B?amZTSkJBby9GcURKazh0a2RoNkpublF2UkNkYlFFWXdMMGhJb0x1THUzSHdw?=
 =?utf-8?B?d2RjNlZKUzlZY2lRT05tdkJDOWU3a1h0Q1QyMi93STJ0djdHUUJiTTRrQ0hV?=
 =?utf-8?B?Qk1TR3YwQ01YcUtrWUlqTTNSWUtSOHBxMWpjdjUxRGhmY28rZktrYlU1cjQv?=
 =?utf-8?B?MW4zeDRTY0wzMDB2Rlh6KzBTZ2xzVkw1MnVKeWJuSE1BakY1MVNZL3dGM0lo?=
 =?utf-8?B?djJ0QVJWS2JZYnp4RHdXaUw2SUk1UFFzRWZCeWdRS2RIaENvU2lPa2hkQ0JK?=
 =?utf-8?B?SWhZRWRjYTBEV2JZWndYclozVGhWR2JGeWxOWEdMVWY0cGlBcXY1TDhJSUh1?=
 =?utf-8?B?OWJndTFwRjlNRGxMVlhrNWpMOG10Rk8xdFF4anZlQVlzWU5objdYUGRBQVBR?=
 =?utf-8?B?SUZOSHNKSnNnT3dXYS9IRzZzdFN0SmJSS0s1VEg2eWE3Z0lRcmNrU3ZVMlho?=
 =?utf-8?B?bkVVUWtsKzY5NnVsNW1CckVvWDlZcWNWZjcwcjRlN3BxdXZMclA2N0U3bThH?=
 =?utf-8?B?b2h1SFhsK013cktGcml4QmlJb3JSdHVlOGdXNVZxYXJoemVTUGpBckVreXhV?=
 =?utf-8?B?c1htZ0RGT1dRdUlSVWpiSklLN1hZdFFncDBpSWx2MFVSSzZ3YlB4SUNabHpC?=
 =?utf-8?B?cERqdzhUdFBPNXBqV3NmMTJGdGZmUW5pdDJJazkvdkl4aE9HaHg0Q3REbjFN?=
 =?utf-8?B?ajJ2ZkdxNTB1MkZvL2puUnZOL25JaTZJRFNXMDV1ZnFCRXpISk9zVXVHM3hK?=
 =?utf-8?B?alU4Umx1dTRYUGZNT3RLVmRwYmNsTnBhRk9oTUxVQTlRWUVRYUVxdGl1V0pv?=
 =?utf-8?B?TndpZTFEckM2VGhsSk41YUF4anVUSkR3VGZMMGVTamQ1RlN3ZnZNQVM5aGhm?=
 =?utf-8?B?WVEyRHRYTlZubUdld2N5ZlozZGxrbW5HeUtVRUVnaG93Z2luNDNteGhXUnZl?=
 =?utf-8?B?RFZHOG10dEcxbEk2dzE3aitzWVQwL1FscWk1NnlMc2RqWVBSS1VSQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 731bd486-79b6-4035-543f-08ded7ffb717
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 06:04:02.8201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ulJ00jbD3dzUa2FbX43PyvfS8Oqch2dEvLcfRs/kuMmd8nMAxAf7IC6ZpczqAZQBqg2JN3myRbNKEgRw2kWGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3133
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Jul 2026 06:04:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23374

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6697/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&month=7&day=2&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/06/cip.2026-06-25-12.00.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
   - kernel WG blog post contribution

Jan

[*]
Date the data is created: Thu Jul  2 06:01:47 AM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version release date: Thu Jun 11 08:34:12 AM UTC 2026
  limit date: Sat Jul 11 08:34:12 AM UTC 2026
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Mon May 25 11:40:18 AM UTC 2026
  limit date: Fri Jul 24 11:40:18 AM UTC 2026
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Mon Jun 29 09:22:22 AM UTC 2026
  limit date: Wed Jul 29 09:22:22 AM UTC 2026
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Tue May 12 11:56:37 AM UTC 2026
  limit date: Sat Jul 11 11:56:37 AM UTC 2026
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Tue Jun 16 12:38:40 PM UTC 2026
  limit date: Thu Jul 16 12:38:40 PM UTC 2026
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Mon May  4 10:49:51 AM UTC 2026
  limit date: Fri Jul  3 10:49:51 AM UTC 2026
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Tue Jun 16 08:11:47 AM UTC 2026
  limit date: Thu Jul 16 08:11:47 AM UTC 2026
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Tue Jun 16 12:51:56 PM UTC 2026
  limit date: Sat Aug 15 12:51:56 PM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Sun Jun 28 11:06:06 PM UTC 2026
  limit date: Mon Jul 13 11:06:06 PM UTC 2026
  Status: On track

