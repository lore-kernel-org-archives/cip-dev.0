Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE575C4345F
	for <webhook@archiver.kernel.org>; Thu, 25 Apr 2024 18:18:56 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.49])
 by mx.groups.io with SMTP id smtpd.web11.24392.1714069128427246023
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Apr 2024 11:18:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=OmZ9QA6c;
 spf=pass (domain: siemens.com, ip: 40.107.13.49, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkythGGDu0J2xj4N0yjOlW857ueeantz7cx45VxFaEMfDWmpyBZhBtUl8TwWoSmGrwNOoDaFjGy3bfM1LLEJ0oiB6xNnSZThVUvDInGI4D1FyufsyH/2if1WNnqjYS7zRF6Ae42EvWrns4yLm1n1wmcFD1OvvWrZZ8RRSe1hmhVHxOUQtT8oyR3zPCtNjTk6d1E5ROXhfHsMAQzEIWgmeATaxNUml+Hy4f+fLxx1NR7f51GAMziAqlp7GQdjYnchrnirETNFstsDQuHzXsFASukRBoFkCq78PNazFFDBg62UQMa4vHuob9lVS92vS5BhXJTJ9FUbbuYeurxTXIkuuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8Pjn9oV1t9zusI5iHoIg1xnQ8TLsETHX8Lq3bI2OZU=;
 b=W9ZOdS47bUxYyxEFEfV+yNLRvcpquAIMW0pNoriJQAZ5aGDSrGDSTreQCyLLiPZN9HdyFYGzyvWhL+sJpSn0t4O0PD3SflfUWpvWkNapFLU6sbM2b3/9U3+uZWuacUAYRJIARRN6tMUnG3j8YPgl2cdsspNXKdhSLy6HQhgGD6P2undfuiEhQcbuBwjZsMYS/AylSEP9epYXNGlMbCYRtxGkg6vsJMxHd4p8GdrkcnIgjl5SB1zSEIXnb04lZe2BPNFCb5+1PH0SIHm45/0hLpL1sw34UclRoF/QGAGjZ/l+YA7jW0lBYnPJU7z3lPXoQbkclLS/YjQC94ej9MBi+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8Pjn9oV1t9zusI5iHoIg1xnQ8TLsETHX8Lq3bI2OZU=;
 b=OmZ9QA6cJAj8yBIEMZL3YfI6aa8wyf8V9VfCNI/U7nqQ7AL7wpFQbWE6vGfPJBgWMoJhOeqGFgfxS9kYK9ik6NMbhPmBuw/g6iCMD/Lb3260N261I/H3HM12dkH9ZCWxR8dpRcSP/Z0lAj6fYFPHUl3lJOSAIWGlzWQbHjLXGj+TcJaU2+eVZUAisJzuuY91aGvbUwsP/JbQUmlaolV8Qi8TZQDm4/xdXPLzEUL+m8rI/JRUett5ts12A5pQxrpOXWduGy7BJVpCRt7tZBHzZI5qcwMVhsDxO/BDrmM8jT0DwyH0klccI7aSfVpoZpNXKqfr9coF+D1I6WUpUp0/Vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS2PR10MB6399.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:557::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 18:18:44 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%4]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 18:18:44 +0000
Message-ID: <2e85b04d-7afe-4265-b87d-a0a936bdcbd0@siemens.com>
Date: Thu, 25 Apr 2024 20:18:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
Content-Language: en-US, de-DE
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 nobuhiro1.iwamatsu@toshiba.co.jp
Cc: "Kiszka, Jan (T CED)" <jan.kiszka@siemens.com>
References: <3283c176-3ed8-4808-92af-b5e16af941f2@siemens.com>
 <OS0PR01MB6388A0EC11DAEA9A56B5891792172@OS0PR01MB6388.jpnprd01.prod.outlook.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <OS0PR01MB6388A0EC11DAEA9A56B5891792172@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::16) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS2PR10MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f024713-a0fa-4c99-e8a6-08dc6554247c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WTIvaTJSQ3NOZzVyVzN4akptQ0RFeUdDNVdjcmI5N0lTbGJycmJqWnp2WTVV?=
 =?utf-8?B?dC93RVk2OFlBRnVuWkJwR2JEaFN2d3dtWkY4SVNnWjRzL1ppVG5QbGFXOVMr?=
 =?utf-8?B?bWMyZytFU3hzd0kwZHZ1R2J4blEyaldjUkdsSnFPa1JJZEtOWUFOTi9jY3p5?=
 =?utf-8?B?VkJScjVhbnJVakkzTWpKTHFqNkNqcmlNdTBsSnBvS2Iwa3BNbXFpa2NwRE85?=
 =?utf-8?B?OXptUFZXbjdlb3Z0WnZvQms2RGRONkhNZWRwVTRCYitrODBMYWZkT2RlaDlB?=
 =?utf-8?B?L2x5VG5wa1RyNklWUmMwSDB6VzVjVHVpWGdiaGFuVys1UEZPT0IxcHdNRVlx?=
 =?utf-8?B?UVh4MFhyQnl2ODIrSDJ6cDJoN1MrTFNZZ3FoNm5RbzFOUFhMYS9tZWI4VWNX?=
 =?utf-8?B?YTRIekhHZzFsbGNtU1o0L21MR3NaU0RyRjRUNkZwRytEQU5idXB1Sjk3WUdy?=
 =?utf-8?B?cnV4TmVsMUZJcFJRb3Z0cVYzcVpldGV1Ky91a3JEQU1SQWhvLzFFcTB0clF6?=
 =?utf-8?B?SXpyR2U4am54WktralNKWkMwTGtyVFpNZzhmTG5aeVlLYWl2cDVRVGxMQ2l4?=
 =?utf-8?B?QUF3MzkwdzAzRFZaaGtxRjVmOXoyWXo5WFlMUjlEN2s0dUh6SkZKV29kQU9k?=
 =?utf-8?B?N1JLM2dtVHNMYnNxQ3EzWU1QcEgwMytKUSs2UXVVMk1RZGlHSnNTME1lRWJN?=
 =?utf-8?B?Z0dlb0JSRGNNTDY0cTE1SGxkZStsUW4zV0Y2QnVwS2ZMNndIRThVTVZFcVlT?=
 =?utf-8?B?bEk3akJwZmJTNUhiNUcrZzZEWWQ3WjFqNm5CZVFBOUtqSGRxc1h0WndSYk1k?=
 =?utf-8?B?eERUVE9leVVoN3FtcHpLSVNvMmFYVFVIczA1SGhka0p6aS9GaEN6Y3liU1Zt?=
 =?utf-8?B?Z1dWQldNcVBJTm1zSjMrZEZWY0dkWkdWekVQNlFFeHBndlNZTzdpeUdNLzM0?=
 =?utf-8?B?ajE3RWNDK0xXcjBLeVJWdUZlK1Nxd2ZvVkdST3lrQjl4R0V0SitrOUI4Tm9O?=
 =?utf-8?B?Z2xEZjB2NEt0cXVzVm10QUpQYzNZMDJxTllRemRiOHp1T0xUampjTUlCYWxO?=
 =?utf-8?B?NDAvaU14blRFaThrNU5aT3dRRGkvU2s3aldJUWI2L2lUQ3NqbXJwcExFeDVr?=
 =?utf-8?B?akg0N21iLzcrU2RRbXdURHVKeDBCNEREdmRIRHdXM2EvUzlrdFU3SFQ1ZTNs?=
 =?utf-8?B?V1hQTEpRMDNldVZ3ZS8zclU2c0JWQXhrL3NseTNWWjlNL0lEeloxWFBmNnVS?=
 =?utf-8?B?UllnWUZOZDBIVjNKaHlEUURMVTZMcUUyNlVFaDRGcDRVL3FQbjJ3QXBoYy8w?=
 =?utf-8?B?Um5ORFVSb2pJMlIvcGhFUlhzWURpbXk2aXRGcWg0Q29jK2svRlp5QUM2MitG?=
 =?utf-8?B?RTlkRG9BVWlmemNyMmlzOUl2SmR1WXdVV2NidEZDblVGRWRGQmFFNjltNEE1?=
 =?utf-8?B?WVdCazdRZnAydFBEc25KYUhrRXlLU0lIN3E0aHBYYkpUMG85bysyaWJKTlJt?=
 =?utf-8?B?RENnU1ZIYUllemVqYndSOXpLMXkxRFQxWVFDWVhiOUpzUjNKVzJDbFdhWldw?=
 =?utf-8?B?OEZ3SHFmWUZFVVpqaTNwNFowQzVtV092NmJvVUZEcmMrcVU4dzc0clBBTHQ0?=
 =?utf-8?Q?C6MP9Y1O+8aXtdEoylXy7nLZQ4119isldxHmcS1tHWt0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eVkwOVlzWUxPQ2tOTzlSVGM0TTdpY3NqMmovSnFkeVFiT2ZLdVBOQlN2dmV2?=
 =?utf-8?B?dlViVDlLUXVxNk0vRXdueDdtdU1MS21VNE44YlN3SzFxb2l0YUFwNnVjYVNt?=
 =?utf-8?B?MTliR2pBT1ROUHVQVDJTUkwxZjhPRkN4djJoRjVnM3ViV0dLSEF3RnpGRG81?=
 =?utf-8?B?Yy9LdnJ4SFVranE5ZXJYMVEzUHlOSVpGbEpIU05DZWhySE1xN0MvV2NHQzBv?=
 =?utf-8?B?VnFUYzNNeUpzWHpjS0dDMWZKNkU2WEc3TTRWUkwzODNwUkw3QVBObVh1UHZL?=
 =?utf-8?B?a1libFo2K3UxSlYzTkRSbm1pMjJCQng1Q2RvdWFBZ3NHRXZSb3pLV0JwODl5?=
 =?utf-8?B?OThoR1J1WTVjZDZFODVrZEJKc3FoeVR3NzBLbldxSzB6QXh0THEwRS9uUDA5?=
 =?utf-8?B?ZjdyNmZ0emRpcmRpR005eHI2d1BHOVlMbUhxYTh1cWpXME1IRDFLU3Y4Wjlj?=
 =?utf-8?B?OTZvUDFtM0t6L0ViMUVrRWtsUCtkNXRtaDlTVUFzYmEwTlVtRXVjNXJZYjBl?=
 =?utf-8?B?eVVlNmxXdDhGNHpQeHFLd3poYWszV1c4anNvOHdaL0JSL3c3dkhjYnNBWnpC?=
 =?utf-8?B?QWFuOTFZcE9Bd25oQ0ZPRkllaG9PZUs4MkJJT2d6ZWpZWTJsWXVYL1Nlc20v?=
 =?utf-8?B?QS81Y0ZmN2t2UEJPWUR5a2xBMitaZEZFbUVRUTY1WCtsMGRBVGs1dGJvNURl?=
 =?utf-8?B?MnhEMFdUS1pQanN6UTVjSkZuS3lJbVQ0TlQvWlcyZnZTN2FhdGpxUHhsaTlV?=
 =?utf-8?B?UDcxYmVjczkxZ0V4TGpsdU8vUnlLNzlWcHpEbERIc09kT085MlZuZk5KbDk2?=
 =?utf-8?B?alZOVUtNNDZPcVNwOVpSV1lxM3ErYlpKaWtyakRmYXFvOFUrQ1o3RGV6czRD?=
 =?utf-8?B?Rk9uVUN5bG1nNi83QjkwM2hYL1NnaU5sL3ZQb2ZuSGZEUnFIcjFOQ1IwQVE5?=
 =?utf-8?B?eDVaM1pWNkVCbjgrZ243cVdQL25pSnpUOTBNd1NxbkJpUjUzR2JWMFVnU1gy?=
 =?utf-8?B?Z1JEU2t5T0xWY3Fab2NDN0lsSWZXSklCVjdMdi9tczVHb1gybFpld0ZGSExl?=
 =?utf-8?B?eTR6U0dJSVZsT2k1WlMybXYwMmM1dE5MR29CYm45OHJ5VXNwMmRWcHFHYW9Z?=
 =?utf-8?B?ZTNFMXY0a0lxL2ZDeWRDa2FGaXBNeGozaGpMWFQ5TVZ5MWptRG0xSnhWa3ZQ?=
 =?utf-8?B?ckZ4OHlwNE9MMFV2R1hVeUxXSzYrejVWclFZaGJiaU9vM1hjWkV0UFo1QTFM?=
 =?utf-8?B?ZzJZRzlxNVZELzE2MlhRL29iTUt6TFpDRkZNcWxQdDZKaWpEelAvTlM5NkdO?=
 =?utf-8?B?NFFyaWZjZ2ZIN3pDeG5lbVlxQllHejFOS3IvZ2x2WEVvVUt5VFEzMllVbFU5?=
 =?utf-8?B?bUhQTzdMeGdOZEtobnNvODRlbkZidzJES3lsbWVHYWtBeXpLbDFPQXdQem5U?=
 =?utf-8?B?T3lVR3lBRHZFS3kyOTBZTHEwSHIrNFR3WU5IRDhNcVU5V1VZRkozWXFKWnRw?=
 =?utf-8?B?RjJicTBYbU94OGJHWSswKzExN3BlZG9aTXlvTVc1MWtqZFJQUTk4OXdRMWRj?=
 =?utf-8?B?N3FJRXdQY2c3U0JVRm9uODBxbENtZkxPMXlDM1FDVFlhYUJpTVJVNzJSLzgv?=
 =?utf-8?B?d2s1Qm1EUmUxd2hSQmkwYXAvM2R5WGdiUEh4MHBRd2RhdWg1L2R2c1lNUEQx?=
 =?utf-8?B?d2pHT0RhZ2x2RXBzV1VvSFZHeFdBMDJ1ZHRQaUF3aE1JVUkwL3ZLWHdHekFi?=
 =?utf-8?B?T2lJNHAyZTVuc3hrbUh6bDdPVFlWRDV2MUNEWE5yMm5ZMThqQzBPcnVFOVN2?=
 =?utf-8?B?OVc0bTIrZkVmMjNWR3hlQmxxRk82MzV1WmNnK2tidXVIUk9EZWg3NCswQ0dM?=
 =?utf-8?B?RmpVNlBXelZ4blNNbjlCQ0NMZDhVK0h3VGFNTys4Mjhvbi9oOW1OS1lyTzFy?=
 =?utf-8?B?cm1sVCtxbGZxQkpGNGVsZGViWkVTYjNMVFY4NU5KTzYzeWQ4dHBETlkvSy9L?=
 =?utf-8?B?TXUzNGhUWThKTEV2K25BODZsSTVoNUc1VEVjeW9JTjZhQzl3d040bGJLTm1R?=
 =?utf-8?B?Y1IxZytiY29sVEtWLzRhN2crRUNqYVBUL2hMdnVFQk5pTys1THhST3dMR005?=
 =?utf-8?B?U3BuUjZMV2FFcEUxWGUwOGZ5bkYrVlFBaXB2Lzk1ZlBWeTdPL0dnUnZWQUlo?=
 =?utf-8?B?cWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f024713-a0fa-4c99-e8a6-08dc6554247c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 18:18:44.5111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8h8rS2Y1V3MdvOSd+Ow7SoxrxreOrkEw9f4wW+H29nyQDJ73iQfpMUI4qPc4oDOuWhv2fYy5q6Iy2va/PQM6YLP5iMmZAdNjPIgRjK1nrT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6399
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Apr 2024 18:18:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15770



On 4/25/24 2:12 PM, Nobuhiro Iwamatsu via lists.cip-project.org wrote:
> Hi all,
> 
> I can not participate today's meeting.
> 
>> linux-4.19.y-cip: interval 30 day
>>    latest version release date: Fri 22 Mar 2024 08:52:01 AM UTC
>>    limit date: Sun 21 Apr 2024 08:52:01 AM UTC
>>    Status: *Late*
> 
> I update linux-4.19.y-cip with v4.19.312.
> 
> Regarding the generic linux kernel config, I'm currently working on comparison.
> I am going to report on ML when it is completed.
Hi Nobuhiro,

I talk with Jan about the topic Generic Linux kernel config and would 
support you with that task.

Can we have an short sync.

Best regards,
Quirin

> 
> Best regards,
>    Nobuhiro
> 
>> -----Original Message-----
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
>> Behalf Of Jan Kiszka via lists.cip-project.org
>> Sent: Thursday, April 25, 2024 3:41 PM
>> To: cip-dev <cip-dev@lists.cip-project.org>
>> Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat
>>
>> Hi all,
>>
>> Kindly be reminded to attend the weekly meeting through IRC to discuss
>> technical topics with CIP kernel today. Our channel is the following:
>>
>>      irc:irc.libera.chat:6667/cip
>>
>> The IRC meeting is scheduled to UTC (GMT) 13:00:
>>
>> https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&
>> month=4&day=25&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4
>> =37&p5=241&p6=248
>>
>> USWest    USEast    UK        DE        TW        JP
>> 06:00     09:00     14:00     15:00     21:00     22:00
>>
>> Last meeting minutes:
>> https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/04/cip.2024-04-18-
>> 13.07.log.html
>>
>> * Action items
>>    - prepare blog entry on SLTS kernel state and challenges [Jan]
>> * Kernel maintenance updates
>> * Kernel release status [*]
>> * Kernel testing
>> * AOB
>>
>> Jan
>>
>> [*]
>> linux-4.4.y-cip: interval 30 day
>>    latest version release date: Wed 10 Apr 2024 08:14:20 AM UTC
>>    limit date: Fri 10 May 2024 08:14:20 AM UTC
>>    Status: On track
>> linux-4.4.y-cip-rt: interval 60 day
>>    latest version release date: Mon 18 Mar 2024 10:21:04 AM UTC
>>    limit date: Fri 17 May 2024 10:21:04 AM UTC
>>    Status: On track
>> linux-4.19.y-cip: interval 30 day
>>    latest version release date: Fri 22 Mar 2024 08:52:01 AM UTC
>>    limit date: Sun 21 Apr 2024 08:52:01 AM UTC
>>    Status: *Late*
>> linux-4.19.y-cip-rt: interval 60 day
>>    latest version release date: Fri 01 Mar 2024 08:49:23 PM UTC
>>    limit date: Tue 30 Apr 2024 08:49:23 PM UTC
>>    Status: On track
>> linux-5.10.y-cip: interval 30 day
>>    latest version release date: Wed 03 Apr 2024 04:45:35 AM UTC
>>    limit date: Fri 03 May 2024 04:45:35 AM UTC
>>    Status: On track
>> linux-5.10.y-cip-rt: interval 60 day
>>    latest version release date: Mon 05 Feb 2024 05:21:45 PM UTC
>>    limit date: Fri 05 Apr 2024 05:21:45 PM UTC
>>    Status: Late
>> linux-6.1.y-cip: interval 15 day
>>    latest version release date: Tue 02 Apr 2024 07:59:26 PM UTC
>>    limit date: Wed 17 Apr 2024 07:59:26 PM UTC
>>    Status: Late
>> linux-6.1.y-cip-rt: interval 30 day
>>    latest version release date: Wed 03 Apr 2024 09:29:14 AM UTC
>>    limit date: Fri 03 May 2024 09:29:14 AM UTC
>>    Status: On track

