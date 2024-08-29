Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17FBC7EE32
	for <webhook@archiver.kernel.org>; Thu, 29 Aug 2024 07:45:22 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.82])
 by mx.groups.io with SMTP id smtpd.web10.7356.1724917512553990742
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 Aug 2024 00:45:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=IeKMG/hR;
 spf=pass (domain: siemens.com, ip: 40.107.249.82, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJBaz9h2D7IJh7DiP3I0PlJkkl2M280wdelL0yQGkRmB0VnQwMMY4ibgSJaVJph4z7+VxnY4VbzQkX4j5IS/gFqb3tMtahFpUC/XoGHdWbQLl4efVHXTKbaHDsIZPIQFyHmQJ1favMp/wBotyHdAGCBgpZqVMm4xkrhobyUxUItIrTrc+o+933fTHDxMeWk+nO7rcg2192y+LIzX5HrQ1c4hDQu06fQ7J6PvtS1cnpT8t/+h3uJHXNRkKIbITBxhlwc6CGhEjG3JK3/WK9wAYubg4rF/bzKu3iRDnkCjMUWOMC9VGJrHqHDcN0YzffvQnP7KpZt2YfTCBQksFshqrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5noBua+Ob7vJcZA+Lbqnbdu9p2DvAGQIwESfUasd4fo=;
 b=Mqn1Ytvy85nu8LtcgdH0dKuHXUGAs0D8PghShdF4m5Gabh2RVElEDgw1W0YmT5G+W2A28qVOmmImwiRfX/tmsL7SqKPzS0xEu+dQuyfM8dd8+DFM7SnRZPyiDonsN8fE8s1SQ/ro2Fedqc0DdwX4W1gLbuI1fO2RmEkxg6rjpmocrtUt96j+TngsK65iAgHXm/Cza9uL3lTHe3Ohjp4Cbs6+53scIspQJ4iLycxtrxZeAxzTWRWeP5iQ/LdxXfFvn78tI1exrDuhvUuOHcoroi9ERYflOR8erzEYoBHjQ7zwdbbie8uCk+LvzgY8CCQvAsZXed3Q+8RvpSUhgeyG2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5noBua+Ob7vJcZA+Lbqnbdu9p2DvAGQIwESfUasd4fo=;
 b=IeKMG/hRSr3hOWZvOxhVTl2bLUnEUYL4nt7krVYzv4jsnJMUONCi0HC5BdFy8m7jgVvobQ5ebD7DFktSm6Wd9ttIKpKR7zdJ0/Zkkr4FOd99dCz3gwFNLwR9drX/qcNu6YpPHKjocXCNw9Fx91FNpq8EHLeb3v+fDYpC/E8Yoy2N6k28T8iGWIhVh7CmXp01frRz95azHvigIcUOdCR1EDG/BavmsD7JABueHFgYWt2hJNYV0h93e2BnLygqHul4FJwx8OtbjP9dTiK0OxuDUZJLfoC7H3hr80JBHZoIiM+1SQa99fJsYzzVdtuLCG6byXdO6s6bkFZESiFdz7Sfpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DB8PR10MB3944.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 07:45:07 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 07:45:07 +0000
Message-ID: <b0736566-6319-4918-8f76-b2c12f90fc82@siemens.com>
Date: Thu, 29 Aug 2024 09:45:05 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::7) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DB8PR10MB3944:EE_
X-MS-Office365-Filtering-Correlation-Id: 01316f12-0ad6-425e-d819-08dcc7fe809d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cWtJRGI1ZEFFQmF4N2xkbFRHWmQ2RTR6a2V3NkRub0I1SEMxbDdraVgyVXdn?=
 =?utf-8?B?Sk5WQVpFWjh2UjNYY3hQdW1mZ3Jyd0JMMC9ZYXl3bE1Ic3ZiYjNkVXVpdFBG?=
 =?utf-8?B?dWlTVEJSVHBTaldJUTRtSUhuZUx1OWprNTZFcGI3QkdhODJwTGhXTlhWTWdx?=
 =?utf-8?B?dXdyN29hSUR2alhML0VFYlUyWEt0c0NHR2VUbW1NWGU0RnJUbU5Fcmp4N0po?=
 =?utf-8?B?dlREbkZYVXZlTVc5VC9GemhKdnpxS01yakdaVXNPTThCRytvb0RCMmlmWjNk?=
 =?utf-8?B?Z29HODFIRGlYQVpsbnMvTlRwYldVOHVvN0hnaXp5WjVQaDl2L0JubmVqSEVM?=
 =?utf-8?B?MzVlcm16NGlMZFRiMnRpSWY1U0NUL1duTzZRdUlNOVgwaktRREZjUVNWcTRI?=
 =?utf-8?B?SkNENERlaXpBSTR4d1FJT0VPejlFaUk4U2g4UnFjdUJRbjRkSHNTZ1NCVmgw?=
 =?utf-8?B?Ry9IRGljMldxcjhjc0c0NHdmZWNlM3pCblRiZFNIS3NMQ1ZlK3hkYW5ZOEFi?=
 =?utf-8?B?UExUa3Y3Z1RhQWFweU52VWlFMXYxZEdNdFFFZnByR25jTm1lQUtzbVNLeHFl?=
 =?utf-8?B?aFpsT3pGa3ExcjNGMTNxRWdZUHcxRjF5ZklQdXlObHJrckU1SkQrY3hoUkZQ?=
 =?utf-8?B?UnVWYVptelVESzR0Tm55U0FGMDhqMUkvYjdnZExkSkhXT0s3M09NRytjb3NZ?=
 =?utf-8?B?cGI1NXlCZWhwaG45d3FOenFVVlQ2RUQ3NTA4YzFyQnJlQ2FtUDFMNkp1cS82?=
 =?utf-8?B?dTlocmtHTThzdit2aFFPVXhCdEk4MXp5NStQd3pCb3JTZXQwYlhHc1JjU1Rl?=
 =?utf-8?B?eWlYR3pHVHdjWEpVSFM2ZFFETFNNUTRROTBBWHkvK2NwaFQ0UFk3SFp5NExV?=
 =?utf-8?B?N05rcDlMcWdYdHM5SFdsNXpIalg3V2xPYnBEUUFMaFFIZ083eHZiWFo3eGd4?=
 =?utf-8?B?T3JNTDMzNE5DVnE2ZTltMGRWUlI5TEF3L1RZeitJTFdsRzJ5NjR1KzJscGxM?=
 =?utf-8?B?a2RaV3ZaODRKVk9XM3V5aGdiNnA4NEpTOUtUbGowUkZBaDBqKzk2YVRvQ0o2?=
 =?utf-8?B?M0NjdmkrdUxqVytHN1c3aTg1aEZmVHdmYVFmMTZpcHRld0FxSmJUS2JGelBm?=
 =?utf-8?B?WU4xc2JlQk52OXl4SWhJWUtnd2hPdTNOMmNNL1VNNTllRnlxVlBDTnN3VDZz?=
 =?utf-8?B?YjJoVXZTMG8vdVBoc2VsVWkrQWhwNVBReU9vZWtYY1lIMkNKdG1WaXpiUXIz?=
 =?utf-8?B?ejBSS0taTGh5S3NQM2luWW5BRjhBWTlnVzZEUUs0dzl1d2J0OCtQcE11cHdk?=
 =?utf-8?B?akRQRTVHaXc4UlM1Y2lJN2UrMWxXV3VVSTRRQ2ZTRFR5cU50NVNYblNoSTli?=
 =?utf-8?B?YXdpUzdSMFpkVFMyNW83YytNNlBsOFk0Qy9CcVRNU0cvM1pmODdIamovWmx0?=
 =?utf-8?B?L2drN1dHV3VvcDhKdENEMVZkNUxXWXVodmVBd0RmNW1DZzY0SWxSbXBUbjRn?=
 =?utf-8?B?T0pIOUZQVThDNVMvdms0UjA5NlNlNUFSYWhMRXF1d0RxYU0xSGU2Wm5mR3RB?=
 =?utf-8?B?L0RWUi91V1RUR201NlZSUlE2akFBZ1ErcWsxbkk3OUN3V0l2Mm9oS0hxM2N5?=
 =?utf-8?B?YndqTTRscXhPUHYxd2FJQ2J1VzFpWCtEa3N5aXh4VThXNnpRVjBoWDllaEdi?=
 =?utf-8?B?K1NpVlR4Z1VpU01aWGF4UHVyODRTMmM0eWh2c21sWUxRNVJGSFBjRno1cnlS?=
 =?utf-8?Q?guZdK4ujYlgAPMEfxo=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c0orOTI2WjhBd1QzRW5JemlkTXdQaE9GTEh6bnJETFdTUWgzTWUzcnAzOXpp?=
 =?utf-8?B?WWFsY1NpNWRIZkxqMmhFSGw5SjdvUWdieVN1eG9QTndGZjJJS05icUxFUkp4?=
 =?utf-8?B?aHp2eFhJd0tNZGFxNW16ZTY0OC9HaS9rVStFK1NJeE5MeCs2cGo4c1NTLzJE?=
 =?utf-8?B?dk8wL0UwbW02OEtBemdlcWptUGMraVMxT1pCL282ZlFCQ1ljQVNOWCtxanpl?=
 =?utf-8?B?Y0xqT1BNemE2dEpVWElOUGtxN09sYVRoclpTSDMwMUVsSTVCUTEyRklXRjhY?=
 =?utf-8?B?QVMvZTMvbUVHbWJ1eU5DVjZobkcvUVlEOUFTSTNFSldNUUNZVWJOZkwxQjRD?=
 =?utf-8?B?dFh6R3l2MERnOUFNRWpvV1J5NENacGt3M3ZzaHFGZ0xPc3VFaWx2MVdsd0NS?=
 =?utf-8?B?Sll4ZThkTWhobHEvK3ZnZlVVZEExdWVZQVJVbDh1ZUtSZGV6SEh5KzBOSGpx?=
 =?utf-8?B?ak44blZtQU9GVWNzWmF3ZDc4M2FhMFkvV1lzakJBelNyQmxYQktyT1FqSlo0?=
 =?utf-8?B?R3Z0bG1oVm40cWRNbGM0bnZYZUIwWWxmZzVTa2xTc0lxUy8xZ1Z2TldGUzk5?=
 =?utf-8?B?aTdFbW1oVWRJUURpSTFDN0YwN1JYU3liYUlNQVlUd25UdDc1K1FVY2w4OHlK?=
 =?utf-8?B?VmdxMTQxZmRjTzllcDhEVHJEMjl2QWdhdGF4OE9KSkl0WmRHUG1NaWxab2dv?=
 =?utf-8?B?c1dRencrK1Q3RFQrV0RHUVV6OEhmK2NQTXR1V1YrNTJZci9zd2xRQXJMVmtp?=
 =?utf-8?B?QzF1U1Q4RE9JbHdFT1Z2d0o3cnlNMXFTdjFNN3RPV1NleFozM1BTZEFkSE5U?=
 =?utf-8?B?dEM2c0s2T01reUhNSlR5M3VaMUxLZ2tZZnJBcUEzc2NrQ2NsS3ZzRGtjZGpU?=
 =?utf-8?B?TFRMR1FuT3FHWnB4TUpwQmNxWnEwM2FQK21FenQ0cUhIbHJ1OHladXNsMTFu?=
 =?utf-8?B?L09sSnhNWlgvQWJ3MmdqR010RGZVSG9VbjBuZXB6dXhvU0pYV1hCOWxuR1V3?=
 =?utf-8?B?MmVTTThpbndIMlloNTI2L1ViTjU0a1Q1Tjc5YTRxQnlBN3BZTWNKNVV1S0xI?=
 =?utf-8?B?QnpGeGg4T3lmbTN0TEVmcVpKNkczd2ZjWGNvNFhQRTFFRXo1NTJqLzZCNGVx?=
 =?utf-8?B?WjBzT1JVMzZxSi9zSVlzWmlhNEhpWlFncnNNTGRnUDFqMHY1TEs1eFdpN1VE?=
 =?utf-8?B?RDEya29NbWJrT3RIdjRLSTVKM2kycmt2ZDJYTkF4QXdkcVpHcjlxSkVmQkRP?=
 =?utf-8?B?OVR6RjlyYkZpeU5yODRjUUdLeTRlYnVzQWxYdVBWa0UxL3BnZXljaGRiT3Ri?=
 =?utf-8?B?cWZxRE9GQ2lqYVA4Q3ExOUtKOS9ZbGJHaXZsTjFwOURNVmF2Y2hFVTU5Tllh?=
 =?utf-8?B?bVA1dXdkNmNIamsxZmhHY2hlNmV1endUS0gvZjc1eDJQNDhQSUdVY25Eakg5?=
 =?utf-8?B?dDdMSXpOZEhpNGZqdGJxRE5RODRSSnBtR0dGK0dzYWsveDFIcmQwWDlWc0p5?=
 =?utf-8?B?Z3hoOXByZ3hTU3VnNFl0NERzUVpucS92NVNCL1dRME81SlFxVGdIL0cxL1VC?=
 =?utf-8?B?Q1o2Nk9UeGZ5YzZERVBtcjhrU0VQNmk3UTBVSEpSUThBTkFBZ0hCTzZycC9J?=
 =?utf-8?B?OUZGWTRlaUJmRDUvR2l0c2ExZ0ZlSGVVWlZTU2RrZGFEblI0OU1EM2Y3dzRj?=
 =?utf-8?B?WXpTV3lENFNLV2ZjSnVXSzBDc0YzU1JKRUZBYjd2STRtV0E1bithR1FFMTFr?=
 =?utf-8?B?Y1ZtdW1vRUgzc1RNYXlWQlFCb1Jad2NyQzNJQzlJSEwxalM0YlRYWW5WUDJq?=
 =?utf-8?B?ZTBHQ2ZvMGRBdWx0NlZrcGVITE81NlRaOFNuWXdDZ1piVjlPN2JMNks2QS9C?=
 =?utf-8?B?RnZNeFFPSXA5VjRsdkxyS3cvdVBtMEJZNERLZjYvaW15d1prdVVCVTFyK1RJ?=
 =?utf-8?B?UklTZVRhQmJ3UUM3UW5aM1orZ2hmMkNrYUp5RUV1WSt3ZXErOU1nYjZORHNJ?=
 =?utf-8?B?MlN4TmdsV21CN1pEWDlzN252VnRQUEwyUVIveFcxdDUyVFBldUl1VVBWU3pX?=
 =?utf-8?B?b2hWNWNuekpJQk1nTjROSTdXNlJVTHBubnk1VEkxYUhkaG5YdlFxa0dqTzd2?=
 =?utf-8?B?UTJ0VitDUEJyVGJJU1pxNU9EVVF4N0FIdHFRU3BKK1JWQ0FPc0Q3VCtpY1dm?=
 =?utf-8?B?Q2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01316f12-0ad6-425e-d819-08dcc7fe809d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 07:45:07.4469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQjNCiaHkaMQaOsjU+0j1nrSO7d2DlFhFMSnhOSl6lkqTG1nuMyd/lkk3vE6LKYmFDAHlgwkwe47NX9paOJMxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3944
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 29 Aug 2024 07:45:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16831

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&month=8&day=29&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/08/cip.2024-08-22-13.02.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
  - clarify role of linux-6.1.y-cip-rebase tag [iwamatsu-san]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed Aug  7 09:06:02 AM UTC 2024
  limit date: Fri Sep  6 09:06:02 AM UTC 2024
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Wed Jul 17 01:30:36 PM UTC 2024
  limit date: Sun Sep 15 01:30:36 PM UTC 2024
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Mon Aug 19 09:14:08 AM UTC 2024
  limit date: Wed Sep 18 09:14:08 AM UTC 2024
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Fri Jul 12 03:18:17 PM UTC 2024
  limit date: Tue Sep 10 03:18:17 PM UTC 2024
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Fri Aug  9 01:12:59 AM UTC 2024
  limit date: Sun Sep  8 01:12:59 AM UTC 2024
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Fri Aug  9 05:08:44 PM UTC 2024
  limit date: Tue Oct  8 05:08:44 PM UTC 2024
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Wed Aug 28 11:17:13 PM UTC 2024
  limit date: Thu Sep 12 11:17:13 PM UTC 2024
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Sun Aug 11 07:14:28 PM UTC 2024
  limit date: Tue Sep 10 07:14:28 PM UTC 2024
  Status: On track

