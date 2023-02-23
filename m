Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8091C636D7
	for <webhook@archiver.kernel.org>; Thu, 23 Feb 2023 06:49:17 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.72])
 by mx.groups.io with SMTP id smtpd.web10.5336.1677134947402455522
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Feb 2023 22:49:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=umvGM38k;
 spf=pass (domain: siemens.com, ip: 40.107.104.72, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQ0Kqb62HASvR2EhXEmPOEMgL9wgjTTXGWF1JEieI0jScaV+4MjyuhO6zSNPzWSP0+ia2nFYxJRgU4oVITRVcHXqQ7DXvse7fKABTL7/3T3F2g1t6ImbwjxhJ9dafF4nfx/TgsP4dCrfmFqC+t+fM5POuF/GSgo2pWwaOf76hpkMUYcef096xoWmZK1iqoQ2UDbzwPMP0Q9zu0dnM5w9xlHaQMbPncaFuUPevEZqxhoxMrguzaVgXu5h5FLIEO77biXdAiqdRgjbD8t445JKr/P+XIqz+IMPWzc3ipyUDUd/F09rrQlz/RTGiTCw1DMCTKu3e7K4DwG752DJWjBrnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZXvC0rQ3x+1SvlABTmX228TfgVDt6EZSdLdbQet3Fc=;
 b=INtzuX+L1cZ6x7D/MiaTWOHi39pspVzLB0iATLsXgqvYsq9/3nmAR00Ffi/76Hf7cBJI/jXECI2uMPbCVgNX1/gvXscYhHmeJBcZIo4kQUXkW1XGlJ6DsC9HKGxmFA6rosPMGFivmaWlJWZn3da8pMGRtN8XpDbYOrROdHTG4pPR7KBi1JaBoH9va7oAGTCOdqBKiFFu/UOKEkMymZmMlfbsSZMGsrkLQjj6nAp/dS3JZRsAAntjZzd6N+Trqf4nAHWnnp16AgpsSAWYd1+8pi9k0JoCho+92HP5ztE8nncxMNGDrjugLFKsjaleYaEPY2xsiQyXmgbrlk8h4HlNHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZXvC0rQ3x+1SvlABTmX228TfgVDt6EZSdLdbQet3Fc=;
 b=umvGM38kVAAUs+ZtwTdD+L9e6blKnQNPeeDT7sx09SheZtluQYkcoSdzBNMtTOxvm7Cr1DAt5nHoYvi8I69WAmyQQNICou6zk+okxeph/TeqqPBmosXWmD4kTDa4A4yqTTRwYeCMLLQvUciQKpr6AvZRU+1FGMkYA2bj0babyZvRsXR/V5h9+h19jur+mGy5oNMTAYeW515RuX4ZBwVx1v32/ab7f8phSKbnT1af7zw4PhzWXzKvsI01G+dTv0QajYCVA0l/L2fCSzR3nbFnDdZZozBlLCW/+GDfa2Zm/EndQLPgbj1jLMv8G2xlt0upbNFMsUpsudD3Pqo+VmyGBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7816.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:49e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.18; Thu, 23 Feb
 2023 06:49:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 06:49:03 +0000
Message-ID: <4c4ee732-415b-3552-a255-058ac13a2c2c@siemens.com>
Date: Thu, 23 Feb 2023 07:49:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7816:EE_
X-MS-Office365-Filtering-Correlation-Id: f41fad43-7465-4db8-e0e5-08db156a0d15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2CN6aKupPlmHD2R480XlwtqG/Dn5s/gfX63Z50eQ/pgA18GgzuqKU5Fe8DgV6sk0lL8pgWrSQrXF7MglWRDuLpyHoANpX5qf9QCkYX4/3erYib0svqCoemv98XRYGdjTlMeWBj80z9vSGiFYLWwOhL6FAGXgSpAGEqsrTQDCuRXiX7PLQyCcEAg7XWALFub8XXbA0qPxoZ6VcFcspAoHmBU5JJqsFNMuMDmBoWhx7+EprgKS8zHDJElRvTy4bn/tBIIk2pomo8Gtnbn0fP43NmkIL+aGL6joDEdZPN2ScUMt2Sbl0E/ShlT/LpnavFWZnxxgBFF29NLsWI7QYSqekThmFTj16HcoOeIpx/UZDnJtklAJRPMnXyTW2CGkUBOP4n7R4pjAxgZ91C2sXcfpFq1sP2vJ5iOy/9MXlANRiI1Ozu43RCkKpF5XNVO7PPk8cJHdKLOgsUhMOKEbFblghxjUf58WaG+YNudvDmgKkykY4ds4kdtyzU8FZZR5AAG98fKHZaefCV/jVIaxTAdNe7IszVdr7dqLZ79wAa231RTC58QMjgbd1yNydmul681OSQRqYrgIrQf9p8+SiCN6VAi1dS39605GnzoqFs/Um9XEWkDcmvj2ChDGDr50sluDXTt0zGceY/O79OKe40jdmTIOoEx+PyTo/vO3rHVIuWvvimhrUpCcmxE2AZ2BGK3dFz1+1Zjf6cUzJJNYgwo5fSLOcAE/6rZyFKUAw9zJA/GGYrN/B7Rz6tKyOGJmub3q3qRJqTJCZkQFZV4GBaz3zg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199018)(86362001)(31696002)(36756003)(6506007)(478600001)(83380400001)(2616005)(316002)(6512007)(26005)(186003)(966005)(31686004)(6486002)(44832011)(5660300002)(82960400001)(4744005)(66946007)(2906002)(6916009)(8936002)(66556008)(8676002)(38100700002)(41300700001)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aUJTNFgrU3VuQnd2OFFBWGY5YU1DcnNqNWJibmpHdDlUTEhORHkwSlF5a20r?=
 =?utf-8?B?enhxOXhYeVNvc1RNN2x4aTV2V1UyUmtZajRVcVROVDlMTkY3OFo0azEvcU84?=
 =?utf-8?B?dVorcmtRdXV0YVRHMnlRb09ac2pObWwrWGRTbCtOVlpncHZmSEhqNkRveGNn?=
 =?utf-8?B?M0hYTFphU2FhMUZNTFIrbVBpVlJ2aisvdGNCYjJwMm9LSW1TZm1sc2U0UXBt?=
 =?utf-8?B?NmVIVkxLODRGMEhhSEdoUWVCck1PM2p5aU5mYmMwZW4wRlNrRVRQR2d2SXlP?=
 =?utf-8?B?UUVSTGxKZVZCdkJ4dUliczFCZUVZOTB6TXg3d2RMQitvRXlEbnJSYkpqa09y?=
 =?utf-8?B?OHFpTytneDNjaXM5RHBrVHl3WnNtTi9BcHR6U0hLQmZYZElCRDNXRXU0QnRy?=
 =?utf-8?B?WndnNEprSVI0N254cDA5eFNjS2xBOC9JK2lTSHNFNFlCSHYrRHpCTmV2WTVw?=
 =?utf-8?B?QkY2enljYlpWOVI1clFRcEV4bHAyT3Y3c0hZSS9iQjVLcjFLZ2pVWFNESWhE?=
 =?utf-8?B?WlBjZG9YT1ZLckJxTTFYRENzZlAzSkVVU3FhVmhnZkkwOXVFdWFlZjcxWndR?=
 =?utf-8?B?b2xRMWdLaUl6cTg2Nk1icjRqOUVRQTZLWjc4Mk02VFAyK0gvdnM3ck5IRU5t?=
 =?utf-8?B?emI3aDFuYUF0MSs2OVYwQng4Q000TFJzUlJGWWVORlZmV3NXNUNsSTJBOThr?=
 =?utf-8?B?UzFVMnMwNUcxdVlFWktiWjZ1UHM5L2NZS1pLSEp4ZXRuMUxRd0hSVm1QOEJ3?=
 =?utf-8?B?L2xFNGpkSThmamdnZ3Qva2VITUNrNTN2eFBWdVQ1WVQzL2J4elV1dHZDY2py?=
 =?utf-8?B?ODZsR2JmUjRaUkwyRWhPSGhHOUd0T2c0V0trSk4zTng2ell3OXcwcE4yRzgz?=
 =?utf-8?B?cFRYeUJVWWkyUmJFSmF1VmxQbm9pcXJFaW9RdisxWVpVbnoyUTg0TWNQS1Ra?=
 =?utf-8?B?bTBSMWJzTkxsY2tqd2R0SmthNStsYVpMZk5KM1RJYlFNRFppY2ErRWV2bklZ?=
 =?utf-8?B?RkREVmtDUVdpUTRtNkpMSVl1ZGlVb0YyZkhxQlpsOXRqLy8yK1k4aytkNUsz?=
 =?utf-8?B?UFYwdEhjNzdQTmZiUGtVazI5SzVhbUlqL3d1Q3F0OHpWMkRVQ0NUdjdnblBV?=
 =?utf-8?B?ZE9BQ3hoZ2JmamR4WFAzK0NvUHl4R21xcEptR002T0FESCtSSWFYZ2NKVVVq?=
 =?utf-8?B?OEdaZFpONDN2RUxKNDFaUU9RRE5LSFl5OU9jeGRUUk8wZXBvTkZhbU9SKzgr?=
 =?utf-8?B?S2hwZEpDcDkxN0x2TUhxV3pJZUJ1QUpCWVpxWEpEZWFITERwTmREZkFJMDg5?=
 =?utf-8?B?S3ZIVmtTQ1g1WHpXWHo5bDNFVy80WWw4dmJIdk5XdnZSemkyVnBPbDRYVjhP?=
 =?utf-8?B?M0lDY2hXNWd1UXFWaldWU1Nyc3pNRjhzTEFqUERHVldrQXVlNHN0NjV0RmxY?=
 =?utf-8?B?OTFwVktQd0I1bUtKejdiY05PU1lPekd0ZXJIR2VrdFVzcEdiWTZQWjQ0Qzdx?=
 =?utf-8?B?WmFyazF3VkZ1bnZhaXBxR0lvWEZ3QmR6NUN6cTZBU01hQ0V2VDVYUkRlbnR5?=
 =?utf-8?B?anFXeXQxSHZuaXBTSitsZi9IQmtleXB3c2dVdkIvN3dmRlRoRkJVa1RTVExW?=
 =?utf-8?B?TVo0dTVGdnptL3UyRGRKTXVuelA4M2xEcllHaUZJWktaNnlnb213U3VydTJR?=
 =?utf-8?B?WkE3SCs5MnJyN1FJa2VzOGR6ekk4RlM0eEhqRDJ0YUxSb2ZJKzl3T2IrU00r?=
 =?utf-8?B?VHNjd0RZa1d5U2NVdndDNHBzY0VTNWlaNExBVFM0UWFsNy9CQWRQMHRUb3NB?=
 =?utf-8?B?czNBRllDcWR2TktpV1Z2R01zRlRlaU1CYXZ2N205RWUrZ1ExMkZTdzlpQ1Q4?=
 =?utf-8?B?aWdjWGdYSHBUWFVsQm93RWtlR0xqQWVod0F5YkttQ0dvOFE2Y0ZCQzhMS28z?=
 =?utf-8?B?bVhSOWtucmtzbExCbXlIOU5JSENnK2tneHFQUkVBcHhFcVZZaVB2bmpVRnVD?=
 =?utf-8?B?d2Y1eFNDTm1FU29KK3h2UTRiczZ5aEpGZkNnVFREMzE0aWs3V2VRbUVEdjZH?=
 =?utf-8?B?UlNKelB5NG14UkhRZ00wTkxVZzBJbzVlanQzT2R6SUJDSUgxaWtqeDQ3cXRy?=
 =?utf-8?B?OVRLYWVWUlNiN09XTXFkUURpNG43SENLeGRaM3hhRmt4ZmJwWWwyajJKc0VZ?=
 =?utf-8?B?MWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f41fad43-7465-4db8-e0e5-08db156a0d15
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 06:49:03.4716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /yeu3ks7M6Uf91DUocZJZZKdaL/f+uqJj2E2O25RnjPMPUfGF1sCy4OmOFKN2gqvAXhGHX4j3QRqGB5jdTsXHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7816
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Feb 2023 06:49:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10796

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=2&day=23&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/02/cip.2023-02-16-13.02.log.html

* Action items
  1. enable more stable trees for testing (patersonc)
  2. report 6.1 test plan to LKML (pavel, depends on 1.)
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
* Kernel testing
* AOB
  - topics for extended TSC meeting

Jan

