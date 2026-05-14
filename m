Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD790CD4851
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 06:38:57 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.64])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4755.1778740727390818728
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 May 2026 23:38:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=d1yrJ4QS;
 spf=pass (domain: siemens.com, ip: 52.101.72.64, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ge3shL8cu2N27mF+oyAQTiGHruxwE7kgcsjV3GCGWLLNivgl02fToaF6C0oqzsFVj5o1O4Gcp4m+YMUAl0CrYPltNGasTRHWZJ9Un+XzMBJWEED50LlaaY7l77oA8qvnsjgij68wOAyBqDPC/zVztIFzJzfUALNdhGthJkwozRMqgTln2D3gDjNh1RPtOKSNcaeBskQ3rp4QZyiqOzLxbrXPEGIjAT2AV0ZOLcnF/gzQFmI6Zr69IGqrbCBVQCNcKlwjhXf+Akixu5cYa84ocl4FgCdEtX3pgj+4Y6Oy6lroXgKJFckqijW25Y/Fa3Wu95v/vN7tlck0Pi2EXGkM1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGBhwQqH+Bkr6ITeBuMY/RsBnhGPPUNAD5gbJsx1Xoo=;
 b=uyGjdnJIqiBqT6/S9yXBiXXJKeprdy4XsRKdsX4+rUTq9LRnoqPUTGlkQ6ravhudoKRdQXiFBjwcES15xxaMD4Czam9rDpd9f3nvfoRW3yvttWvcWWxSSFGRvj7SA9zs8XZtqJuTA46VzspW6xE1CnoT/bH1MSymFF22RpuoI/808XGmxVC+4J5s5njEhacsBSiTqaKvZ0qwUXOVF/E8gMmLJ5d3oFQSZNkG0Jh0LMZY19NKj99vPBsWFEl3Yzami/a9pebvxfbNp51HNCI7gp+YDkltUDZEgDTRq9/h1gNzKaRJx8iWCalckmp3C0FXuHJwVy6mTpHZeIS41D2ziw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGBhwQqH+Bkr6ITeBuMY/RsBnhGPPUNAD5gbJsx1Xoo=;
 b=d1yrJ4QSpz1OZfMMoldBQcrYg/d+Uce/rQ+/dOOzVes7Md+U7vlT04zYtOdoSB92QOmD8Tu+LEszRWFCFDTJwxc7sAK2kRim1pQWh2W7g+ca+l6KRsv8nAg1hI1xTv35WDDGTWMDcgTNPvczfqAoxgRrNe9fsnPCcPvoILcEEJMeiu4Jj6d7oLsIhaik3FoQNzQI89O+TYBdZe3Vlq7OeaD21MtqRcl1iWjEvI4i4xSmveJbPtKtMRkwJoiA5OtqeDHLNhbmVuMVYKJ1jl2cLicxKKYhCALIfkAF1GUXGYc7F0K1k9pQ5Gy/1RZBWeJdvp47pXicZYf/BPrSW4/zdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6974.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:579::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 06:38:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0025.012; Thu, 14 May 2026
 06:38:42 +0000
Message-ID: <5059104f-1d91-4acb-9ba7-8ac06435332d@siemens.com>
Date: Thu, 14 May 2026 08:38:41 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6974:EE_
X-MS-Office365-Filtering-Correlation-Id: 46b02261-8b91-41d3-ee6b-08deb18370ea
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|55112099003|56012099003|11063799003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	vmcZvUIEPWffOmGMjOAzaQyz0Xbn/n985Aj9FfiP162hHUQ6V9o3Frl7kg1IrEmUkTX3rslsuyA0bVJBOL/3TM4pxFq6GCRgkRT1Sq1McfmzcnTDzPed/psnXTAAsOfRGeQnpvwiUmEcCnGTmPNAw4ojGQIK/X9nnYCUarmbZsXSvdCyi4TO3kgllHeJpIx1mXNnRWRv41iYF6Xaly56b3g4mLPfirwtps8q9c8jou8iJz7zrstI8WxUDtF2J5EHqP3/IBsnaqvxCw6FrxMTM9yylnVIUPR9eGHpU5lOAqDgmbbIYjcyMlMBSEUzsI0qe3OA5HdnWT6WDVHn6C7EABynYSYIY6RxoUO0GaT9UoEajAS1UTRS+6j26JUL2j69BYmW08bmIHl9Fstxy+/bZEl2iP+2akjWHvY0Ztjc+A9DR5ocSONjBGJcZVI9E8twgYfwdfWgcPIvppMH/Ap9afm8ggD+gvzrLKeK9WYbxVFb5jg9dwExFUdLK3jFTQqHOiXRreiGg6xuKCB13kM+uKRq/hj7fw232Con7UqTt3P7WV0hdPLJp3b1pG140pt09ZaZhLbt7lOojpf7kigGXjc7uJiuX/CgDj4F9BwPmg7JhvlMQGu7ll7WkONlRS+Xn5iR6mR44nY9+UYP6ydb0g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(55112099003)(56012099003)(11063799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VDBCbk15VE5iV2o5dlducGllWmdTZjhHVSszRjVFOGRUMlFSbG82NDI4Wk1L?=
 =?utf-8?B?U2tUYlVlYTBqaDVtOGloaVl0RDNGdmswUnNGUnhENktPUkpUZVgxUDVjbWNv?=
 =?utf-8?B?cGtnRUFTaEhmMUtpQ1hDL1d1Ylhma251YzhWakc0dHM4dC9Ed3FxL241L2kx?=
 =?utf-8?B?RGpUYjc2dGRINzFURXlBUUo2TUduY1kzQ0xBS0ZwM29lY0VkbDZmbXUrVVkx?=
 =?utf-8?B?a1NmdkRZcjJTUWMxaGFSS0lWVFRxOEhqNk40bzdLemFodzNpUWgzcllWSlRU?=
 =?utf-8?B?OUpMYU45bTRZNXFTVkt2ZWtaV1BPYnRGdWhYcDJTSC9lcDJBbWxiTlhTRjZt?=
 =?utf-8?B?QlBiUmUyalNjZHFkaDQrMlNvZlJEZWZCeHRpakdxdHBqNnltNU12TVlvZ1h5?=
 =?utf-8?B?WG03aUx5SWNENWtiSXA2ZlpFV0tSaE4yQlNsdWhDclJ5NXJLaXMwRUdRV3ZW?=
 =?utf-8?B?ZGJnRU9jeFZuRnhJTHQvN05KNmJhWmh0c052dWlhbVMyN3dJRUJlZWp3cjFF?=
 =?utf-8?B?ZElFbWJCY1oyWUpobVRYSHk0MVBma1Q1MHo0QjBUaUxWMTMwbGJsL2JmRHov?=
 =?utf-8?B?RVN1QVlDZnpZSFpsUUV0QzRUNG9aV3FhdmtwU0FCVU0vNVhMeExPZEZKam1t?=
 =?utf-8?B?SGI3MnQrelpNcGZnTDdBNkN4WU1WbDJPMGxiMkhzdlIyUXFSejFiakVDNnVX?=
 =?utf-8?B?RVpEOG55V0NuZEhlYllScFNodjNUVHZqclVnMVRQdldBY2tFcWxqM0pvSmw3?=
 =?utf-8?B?Q21RZW1KWVRyMEFBS0ZmRHBGMlFTZUptZjBFSEVSOUo5dG1sNHZ1R1FjVkNx?=
 =?utf-8?B?aU9aUkFvdURJT3VKR3NvWHNzSFAxOFdPUTJOeXp0emNnMFdnYmFLbnBwTW1N?=
 =?utf-8?B?MXA3MkpUL2U4SDBIcnVxRU52UVRGWGdwVCtYdjUwUEJ6bGxsSTR4L0xSdEYx?=
 =?utf-8?B?aVV3VGFzdWZLU0pqY080TmZLNTNWY2w3bVdMc0J6TTdMZFhOUkJuU3VNRWg5?=
 =?utf-8?B?NlZMVjBwejhnT0NEa1BzY0FwK0oyckZEMGhRTkNUajVkL1VacmJxSE9vMGM5?=
 =?utf-8?B?dWVpZGRSbzR3OXNueVg4cm5nN29ib0l6eXJkMVB5TldxanlqOWdFWS9Zd3FR?=
 =?utf-8?B?SVRMbmVtY29qVGF0QUVzQ0NYTjhwbkpwS2hyeTk4U2ZTNWNlOGNmTkNYS0RC?=
 =?utf-8?B?c2pIbFdhbzJuaHQrMisrc3Y4QVFEZHNmS3JMQTE0YXVLV0tuN2kvdWFuWGZK?=
 =?utf-8?B?WkI1Yk45cW5WOS9NS3lOdUY0KzdqQkVBRjNxazVaSEdwUnI5K2lwdVZCenc5?=
 =?utf-8?B?dUpycDFwR1RiWEhLT0p3S2ZjQ29HU2xSMi8wTWtsTHkzMmpTYTliTm1pM2hI?=
 =?utf-8?B?aXhSVysvazIreGtvR1M5c1lQYU50OFd4bTBqU1AxcTYrQ3VXNkN3SXpoaGZQ?=
 =?utf-8?B?clVjcVAvcGJVeXQzRWNIbmVzMEpaWkp4QlVSRWRITTZmeHZHdXZIOXlTS1pw?=
 =?utf-8?B?WUFZVXBKa1c5ZWUzenFQOVRLM1B1YWlqZlhXMFF5eHpHOWU0aW1TQlI2dFJt?=
 =?utf-8?B?NkJkOXBsc2FjTHRDZURVdVJHR1RzSThka2ZPQkIrUVlxL2F4Z0dXVmtBOFJq?=
 =?utf-8?B?eVZiSWJXaHRET0FnTTBYUHlpL3E3NXMydWFmVFJzNDZLVFZ4YVBYUWpSekd3?=
 =?utf-8?B?ZzlBK2J2ZjRZU2tqZEthNXMwN2FQTWY4SHdXU0VXdGpva29VVlhZWm9zbll4?=
 =?utf-8?B?d0ovejQ0akw4OG91dTdSS0d1Z1ZmNGxSUTRtM0lKeHhqN294WWpCWmdDUmhR?=
 =?utf-8?B?OE0zZGZDeGtBOVpPSnlxRlRPa0w5TGxIQXExOWRDY2dTSTlOb2pQcnVmeitn?=
 =?utf-8?B?QzZjMkt4R1ppTmFuZnJNSlVFZGQ0ZjdZVStPcy9UMm4wTnBJVGdXamRSWWNB?=
 =?utf-8?B?Vkk2Q0EyQXl1Vks4c1hNVGFrNWtBOXZ3Z052K1BRNm9SY1ovRXhsZnNUenFS?=
 =?utf-8?B?Qm1qZ1ZFdnZDSkNMSWJQblBiQ1Z2ZGxJMHludlA4d1RncThQY3MrUGwyOVh2?=
 =?utf-8?B?eHFHc2hFVDU3SmdoVE90UnlSTVhRSkx1VklkaU5ZZzJBRXRYVlVIV1RSdlFW?=
 =?utf-8?B?Qkh5ZnJUTndybHd5UlpvcUNleHFvdjk4K2YweERRSkdjVDhRVDMweFZQS05K?=
 =?utf-8?B?c2dYTlh2WmIrWktRamc3cVU1L2wzK2ZHNVV2YXJJUGFLUVQ2MVFvY3oxbERa?=
 =?utf-8?B?dmZsUFJpWUpoUVkwRDBJcEFIUEkxa0lZdlpyRUpUdGp2Q2NYMXhObjdab0hC?=
 =?utf-8?B?UXdnQnNRSjZVb2h5MGVhYmZnc2VUUmVOcmlsQ1FnVllEamhhUHJjZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b02261-8b91-41d3-ee6b-08deb18370ea
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 06:38:42.7982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vYxWXXCh7cKqi/e8pBZ21USeonuiu8dMISMapwCWLMFoZ4i9n/FlVqnkV7aR2yFS4Gi7v4rBUkDsLwPEo57mLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6974
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 May 2026 06:38:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22933

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6697/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&month=5&day=14&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/05/cip.2026-05-07-12.00.log.html

* Action items
* Kernel maintenance updates
   - Dirty Frag & Co.
* Kernel release status [*]
* Kernel testing
* AOB

Note that today is public holiday here, but I will try to make it.

Jan

[*]
Date the data is created: Thu May 14 06:37:55 AM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version release date: Fri Apr 24 06:54:09 AM UTC 2026
  limit date: Sun May 24 06:54:09 AM UTC 2026
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Mon Mar 16 09:03:44 AM UTC 2026
  limit date: Fri May 15 09:03:44 AM UTC 2026
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Thu May  7 11:06:48 AM UTC 2026
  limit date: Sat Jun  6 11:06:48 AM UTC 2026
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Tue May 12 11:56:37 AM UTC 2026
  limit date: Sat Jul 11 11:56:37 AM UTC 2026
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Sun May  3 01:17:37 AM UTC 2026
  limit date: Tue Jun  2 01:17:37 AM UTC 2026
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Mon May  4 10:49:51 AM UTC 2026
  limit date: Fri Jul  3 10:49:51 AM UTC 2026
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Fri May  1 12:45:01 AM UTC 2026
  limit date: Sun May 31 12:45:01 AM UTC 2026
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Mon Apr 13 11:43:31 AM UTC 2026
  limit date: Fri Jun 12 11:43:31 AM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Thu Apr 30 01:36:52 PM UTC 2026
  limit date: Fri May 15 01:36:52 PM UTC 2026
  Status: On track

