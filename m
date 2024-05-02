Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021F5C4345F
	for <webhook@archiver.kernel.org>; Thu,  2 May 2024 09:14:05 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.54])
 by mx.groups.io with SMTP id smtpd.web11.9192.1714641239710854535
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 May 2024 02:14:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=wlC8OrYP;
 spf=pass (domain: siemens.com, ip: 40.107.22.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHgCmNvx+cP+0V5p3jbQf7lQnYggXh5CcGc6VJaP1PUVEY7zE/9BN5O5DOLZJ7CNTg1XKGiCbdRbT5nRzWi51yJX2kmQAKFRORbKQSszXX5UbH/3lr4vc7yQGLJYIJ/IRWp8vSDpWu8lEPAOAd6bm8y9nLGTbHLGjNhQovtSTTwt+pwwK+i0Wa99j9puNz5xc/OOtxqeGFNVo5YI7umA9ciwgFQBtRyQFzoXFjwrUxinR9peK3F7IB2qsL8nTKmj9KURkiOscLI6H0PXa6qPl00XyUxrGlLttVJ0d303xxdKFbqY/JY9VprMIDVgT9u8tIbsmGIaFfL6XD1iP3vxmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgdd87UcwDsYW8bOJnh5MYSDuONyNAll0tXCjX8nSEc=;
 b=J6YjFZ0hMS3wTPPuhVv1S3cr7kV4g42HuaeAyxEh3IWrUjP7/pP2dy8zSgNRis8r/mfaqYShCrYGFbAla0l9jjZqm70Vwa004MBfzi5xgIz7QjEKO9sSjFD39oQ8cVBuJPW8GXDGaPwPDzNiEJywdiHDd6t3ZQUIQg0bVXYQIA4Z0BKSVV4rYyOXYM+yEQ5vXFYEz/H6D8p66lTdRHdbs2zenK7/AL0QnLwvMcK2vxn3Po2VHBFqGy/X5UxGAfR7hVvcwFc0eolwnnr+K9PErGacuNW5diaC6ieUUq1dDjrzREC/j+AbNQKKyZZj84dyEBxCBkhYhnSdrLtEUK/8DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgdd87UcwDsYW8bOJnh5MYSDuONyNAll0tXCjX8nSEc=;
 b=wlC8OrYP5WGUU5+0kxVIHd3Po9BVwh7kLGEPo6UW3aUEXDq6stHhYbf6sLFqP/XuytdcwzAMK0eUfTRMFcHwyhs9Jpk5ce+TrcQVf4t4Dkq2kxPiqH7RHxtgSceVlf4pX276tfpXtgx1j3jOIQdeNY7XYev8Ayd+srB9j9pbTHLfK5fE/g5ot3xGnSYWz2RcpAUOnOLO9xdYA8r8X14TsKabj44mFPR9LZyANGiztzOR6GWcR4VhBhKOBlfhy3Fh0NBeJxFOJ3+CW69fgEGmdLc1O2KAJekno6By5vDu1KZSaVt9w16uP1YvPOhLIgrnHT1Pgghz1fqPzX56ryi5Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA4PR10MB5513.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:26e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.24; Thu, 2 May
 2024 09:13:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 09:13:56 +0000
Message-ID: <b9153a9a-78a5-4e7b-abed-6be10463fbc7@siemens.com>
Date: Thu, 2 May 2024 11:13:54 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA4PR10MB5513:EE_
X-MS-Office365-Filtering-Correlation-Id: 10fdeaf1-36d2-47fd-6fac-08dc6a8831e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aUxUZ2lua3V5NW1DMUY4SW5uRWNqVkVUcjkrb1lWbGxIQ0E3SWJ1T0RYTm1q?=
 =?utf-8?B?dDNyUFd6cjFyQzJLSkhtQTlwZURyVWRuR1hIVkdpTWh1L2t5M09raTNCTCtl?=
 =?utf-8?B?cGR3Ui95YlRkME9pOHQ4V1lISTZCZjFrRkxLS2Z0MERtaFNiUDFYenVQMnR5?=
 =?utf-8?B?ak1DS2FWQXFvSUJWUXU5MG8wL0lISnFJeDYvSVFIZkdES3VTVnVKVm5KeEwy?=
 =?utf-8?B?YnQ3Qy83U2V2b1gzZ0EyaWpEUWprMjRTZFAvTCs2dE1yYVM1bVZjQ05JRTRW?=
 =?utf-8?B?d1ZFVjhWL1pJQ2pYTGVwSTZldk92bDdkNUowdmx1azBmS3BXMWNyOWd6cnRP?=
 =?utf-8?B?UmNnVm9mSXpHaDcxdEo5cGxCblZ5dm93V2NYeWZVMHA0TWdwRHQyOWRBbUNr?=
 =?utf-8?B?L2Jwdm1TZXBMOFl1aWppdWx1OHNESmJvckI1N2RTUkdCc1NYeFF4Y2t2TmJj?=
 =?utf-8?B?ZUtnalZjSXVra1QzcEVYbmsrODFFeUkxUE16eVNwSktDclJleEdiY0RGWlBt?=
 =?utf-8?B?Vi9KTUEwVHQxR2lwYTBtMUsxTEgrblhVRGdUTzVMTjJxcG5Qa0tONVgxMDJH?=
 =?utf-8?B?VmZuUGcwM1N1WlVSRFhoNGtDMTJqNjB6MkNkaGlvOC9RbmFzSmRmZFI3UldS?=
 =?utf-8?B?eHNWQnp0QjlBMG1mSk5qR1dXTmNBV25EM2I5MUpac2UrQTZkWnp5UWlSZWJ2?=
 =?utf-8?B?Z2NETUJHdm1TK1JXaEIvYjRwcndnVXlaRnhEWU1LUFU2S3RQbWJnL3VUR1V0?=
 =?utf-8?B?dUdIQlY1NHZBRUhwbjltNzV0YVF5cTErQ2dCRVB2cDdZVkI4R0RGQWdORjRv?=
 =?utf-8?B?T2U2QkprSnhDc3hkdEc2Z01kUTROZExNTzFBK1NPSUdSU1NrZ0VYSHVPSkZa?=
 =?utf-8?B?ZE1pbm9hUG9PcFR5bHlBSDdLaEFSRzNFSjR0VExNYk04Z2N0dTNWYzZKVHZu?=
 =?utf-8?B?bEQvQk80MmF0aDlRYVlkSHRBZHMxbnFaY2wxQkFhRUtJN0RNSEREZXJ0d3E1?=
 =?utf-8?B?VnArSXBhR2taQU1vUXZXSHpsOVc5UXh4YjZWQXdsNnczdGdpT3N2ZEFNYU9y?=
 =?utf-8?B?R3VHN3RObVphWEFrbW01WklmTm15ZG94aHhBNUFna3BkUHdVSUpXV1laMFRo?=
 =?utf-8?B?Ym8xZVlqV1RTYk5XbkpWL3QxQ0tQdEprbUtJZTROT1lXRjZ5UHl6QWgvbTg5?=
 =?utf-8?B?NE9jQnVpZlN2WmZGdzZ6ZHZTRnR0cTVFcGFUV0VKRHdORjhNK2RkTUxWQ2tz?=
 =?utf-8?B?R3M3bnNBQ3N5N0k2WXRkQ29OcDA3NjFoRmZVYko0TXpFRTVZVDRVZ0RYcUpN?=
 =?utf-8?B?cnozNEZhSWw2dzFVUGZrSFVLbXByeW5VWVN4MXoyT2JBdnN6d2RCbmYrNlBp?=
 =?utf-8?B?SGd2WVRZczJ4SmIyaDdQcUNhVHNyS28vREdJNngycTVTQ2M3cUcrZDBtbnJC?=
 =?utf-8?B?MUJrMVlFNElPUFE0ZDQ5b0daMThlMUUzZHFKa1dIN1NSYlhFakZSUGJkR3F1?=
 =?utf-8?B?cTZUcFRha2NzNUtLWWFqck9vQ1FKMHNySDdNcUhML2dpY00wRVZXR05BOERq?=
 =?utf-8?B?VE9oRzFxNEQ0M1pZZ0JVZ2gwcWN1MW1IZDgyZnh5OG8zZ0NCZWdJTzlpQWY3?=
 =?utf-8?Q?pCDHK38UdqWYgqC1We6SS2tkz9w7ac4MJ9IqHK7oZJak=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Zjk0T2h0OStYNzNOdkVQSkk3MkM1elNyd0E1RVpYUFVDa1NSSU84Yk9oWHlq?=
 =?utf-8?B?RFhUVllwa0t3N2Q0Y0JJNU9iK3hzOHlCMEZQTWNHOTNIUHJDR01Hd2JlQ1R0?=
 =?utf-8?B?SGRxblh5VTRabDVYcVBRU1VJbVNaaGVDVS9OR0ZVTHZoT0dRUUpGeitaNmdm?=
 =?utf-8?B?WnVHSWdCNGU1WTdHeENpT3FkOGRLMGpVSkZpaHZKSzgzYnJHN254QVVCNlF2?=
 =?utf-8?B?TVdmSGxlYlBIQ1Z2bjcxYmRvd2txOE9vOUFzaXp0MnZ0cTVzQU14c0w3VmhQ?=
 =?utf-8?B?bE82OFZvbTlRbjROaWV3YTUrY1dtS2JaMzQ4MWVUVEE1WnVUWTNTeHFqT21K?=
 =?utf-8?B?ZkJLVXpqNHltM2xiUzFLSHBsT1pGTWZaQXY5N1ZicERZWm1zOEpHY2JueW5p?=
 =?utf-8?B?d2srR1R4dmgzZXRzQlJ6WnJDM0ozYm0rMzE5bTdzTVpyNzhLQjVRaGFEdm1P?=
 =?utf-8?B?NS8xb1lTVHVWc216NGlmRXpMaWUyV0lMbXlBTzk1VENtU0RNcGdPMzB0b0ty?=
 =?utf-8?B?VVdPamRqODhUQ2MxY1c3QnZ6ZFlOYVpmdHR5eng4TGwzR1FjWFBxR2Vua3Iz?=
 =?utf-8?B?T2c2SmpBRDFJYWFNYUNYVGhPWU5HQkl4SWx5UU4rcGxXV0JCbjl0cXN3Slkr?=
 =?utf-8?B?VG1TRStiV3l1RGYvV3lUalJQZGs2T1Rib1o3THQyRi8xTmFWb3RxN1dnZ0xR?=
 =?utf-8?B?eU1UaUNxOUxZN240SjBTSmUyNWU3TElRNkZ1cWs2dFNZWFBQWUwvMjRTQWJJ?=
 =?utf-8?B?aVo4bTBLNFRkM0J1SlNsQzZIa1FheTYvVXZJakZndUZWZzhIemVvK2ZJTGZI?=
 =?utf-8?B?SGFpek4zbXIzQUl6RHVaeCtZb0JEK0hrMjlPWGJCaGpjQmpBdmw3RlloV0FC?=
 =?utf-8?B?ZDc2dlo2S1Jjd0U0RXk5aVNoaDI0WW9UOEZFOGkyajZSa1pEdHQyRmgvVFVE?=
 =?utf-8?B?S3Jqc2Z5Y2dMbU5zejdxbjN6NlpBZEdhbXF6WGN2dXNqYzJTT0ZrSy9VaFg0?=
 =?utf-8?B?cHQ4RURJU0N2SjBDdS93Y05DdElPaHRIcDUvWWdYcllwZkZZOVk5a3lYbWxh?=
 =?utf-8?B?VXdWejZTMGhtREtXNGNpR3RnUWNWQ1F2V0pXRVFMSytEUUliUHczeUFwbTNH?=
 =?utf-8?B?MGc3MXFsUDQ1b0JBNTFiaDh5eUpXNHNOREhkczBVaWw3bWF3dXVNVS9DUTBK?=
 =?utf-8?B?TXJ3dXlwQno0a09URlI4K2JuV216K1poanBaNFVOUjBJajAvcWw1NDZDK0d6?=
 =?utf-8?B?MWVRdG90aUZId21XWHRoNm1HamNUby9iMERGZXJNNWNKRFJLbnZXUnVQbmFQ?=
 =?utf-8?B?bVh0OU5VMUw1RXZkQW9SR3hvK2duMFpUcE1Ua3V2NWV3dW83QzljRzZXSjBW?=
 =?utf-8?B?NlE1VG43THRUYldSMGNlU3BRbzVud2trSUVnRmI2WjFrd2F1eG9HdWk0UUFE?=
 =?utf-8?B?WlVRd01NUFVCbUtQZ2dDR2xIT0ludmg3bWtrbCtvMmFMU0V2ZGpjVnhyQk04?=
 =?utf-8?B?S2JkanRBMTdJTjdMMkJBQTVOSXBuSWZpT0hla1IzM3RsZ2FxbVpLRWNFc09N?=
 =?utf-8?B?MGoxeWRoYUJHTFlBOENmRjF3RlA5N1ZuclhMZjRNbXR2MXFUd2lWR1pnVU1o?=
 =?utf-8?B?Tmc5dDNldDd5UmtMV29LcjlVVEM4VEpyTkhwV0JxN3hYa3g1UW1talI4ekJj?=
 =?utf-8?B?Y2xPdzRpaVY3UVdPYk56L0hON0o2QmxDWW9WYmVIbTYzNFB6VFJ1VUU1RmdE?=
 =?utf-8?B?L2tCaUUrYnFod28zSmIxSEhyWjY2TUNDcmt5dkdZeDZKd2lObm45VzAxaU50?=
 =?utf-8?B?VzhIZVZPQTNCb053SVZuTjBxQWxaSTl3N2JSRDBNeTRYa2taaTNxMjBFWW5x?=
 =?utf-8?B?RjZRMFk1VUVSc3kxTXlpYkRGOU1zTGNWYTJJWnNiS2tYZVFHTU5HWVpEeEE1?=
 =?utf-8?B?aytPWjVYKy9zY0MzZDZjcmR0S0UyWUR2ZkoxNWRjelpqeGxDNWFpa0ZlNmVp?=
 =?utf-8?B?ajYyaHdPVS8zOGNJbldpNHhYQmE4aWdLTDFldGJ2OTFldlV5cjJZYXZvb21D?=
 =?utf-8?B?V1hoWXBTcUREM2RkZEJIREpTK1IzdmVqYmluUjh0aHZXcWVGckRielVUVklT?=
 =?utf-8?Q?E1l2tugsgVJbDaI8QlzD5oWCu?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10fdeaf1-36d2-47fd-6fac-08dc6a8831e9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 09:13:56.6207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JDiPbIJWvUhuM1gBfhCMolcf+MCrdKBdi7ZP2hsRY+PwEepfzxPjy3zNfOjr+z9CG7W08GH4atb9zlAdtRdJcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5513
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 May 2024 09:14:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15792

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&month=5&day=2&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/04/cip.2024-04-25-13.02.log.html

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
  latest version release date: Thu 25 Apr 2024 11:55:36 AM UTC
  limit date: Sat 25 May 2024 11:55:36 AM UTC
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Fri 01 Mar 2024 08:49:23 PM UTC
  limit date: Tue 30 Apr 2024 08:49:23 PM UTC
  Status: *Late*
linux-5.10.y-cip: interval 30 day
  latest version release date: Wed 03 Apr 2024 04:45:35 AM UTC
  limit date: Fri 03 May 2024 04:45:35 AM UTC
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Fri 19 Apr 2024 09:32:00 AM UTC
  limit date: Tue 18 Jun 2024 09:32:00 AM UTC
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Wed 17 Apr 2024 07:29:58 AM UTC
  limit date: Thu 02 May 2024 07:29:58 AM UTC
  Status: Late
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Wed 03 Apr 2024 09:29:14 AM UTC
  limit date: Fri 03 May 2024 09:29:14 AM UTC
  Status: On track

