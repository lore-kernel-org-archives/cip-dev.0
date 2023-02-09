Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73012C05027
	for <webhook@archiver.kernel.org>; Thu,  9 Feb 2023 07:56:30 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.75])
 by mx.groups.io with SMTP id smtpd.web10.9103.1675929383441552242
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Feb 2023 23:56:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=FbMAYEDm;
 spf=pass (domain: siemens.com, ip: 40.107.14.75, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1xQDYP9W1dBFpiGL0uFrZovA5fY0l2nuC96cwI5hrhOhA5M4B/yFxokloy11aNUxed5A81vwdlntu3/WdyLTJkeB0UHRIJhfPpTka+Xty2erPTS30NSQUBaEiJZTRxeqqbiWgTmvRMO6FWk+mv0fhA5792lHjqfREPE/HPjY7DHWlXlFxIlG1tySnwv3woVg5KNy/hRTlgY5mRUJCrJKeKG0ktSzBG9H+LJmJeb++YmAg3HfRf+C/N3aRqikiAroo89xixjag/I5TvfwJOudWMMG52bWP2VxQiv5bheM8VpfTfPac9o5R6Q8w5yJO3nt9NzWo8Rf3JALj9it1velg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AiB82+pHo7yt3GgQJA/kuKiUl/al/qXWy+hrcLFw5NY=;
 b=Yr4U6iCcNtbwiqBP+D7QfgvW7ULrTjBckInRKxTNPtCTwkvUHhRWm18fSOI7SNNNZrKUXbcbvTBrfz+NRH7IrWoXiO0xeVubyr4M0Kp1hfmdy3U7yOcbhHScCLywjbWb0T9M8DL2PBtFDI0loaSgrDohFFiBtn6XsWQ9paf7fsqo+d4HqemuRHZGFySG2bj+OpjSP7BFRTj0WrJQP7rXpZnMw1J8S/1aiflZqLbDb1HVKpq5ocaEArjtrWXrQb9Y6Okyj/n2fpu43+lfuQ0zAZyV8ruzzAZ76nMsPgX+NyIA8Po0wYgjcU8npBACF4bCHgZQ8gfvYZ3a9xTLsEcBHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiB82+pHo7yt3GgQJA/kuKiUl/al/qXWy+hrcLFw5NY=;
 b=FbMAYEDmgEWc/Z9aNhvib9NhUu5AT/WGsLskZ88oftoTjY2LEFn6fPHdB8TNlskP1+DXvhj0AuQyG7gj+9243VCV1lr9aEsVD8r8HOQO1WMEDjPY+bAGer/9hNnKdq8AIbs6swA/PqfvcQN0SQsO36ibfJczPBlbG3DKcY+WopFZNO7s3apeXuhXabXILx1y0ezVPJFwpu4vrQr/7SoWusrEKYV2H0h7/80n/6LTWhfnc6kOf+cvxVk7DL1osmmzFhp5a0w2IYIHhugreOFB1HeQ8kJROHNshLpPujdBs5iwfgea1EQ4G1fp4nphSxea+AarQ4MCpt1r7x2KidSNuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7204.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:608::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 07:56:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%7]) with mapi id 15.20.6086.017; Thu, 9 Feb 2023
 07:56:19 +0000
Message-ID: <171fd41b-a562-84f7-01de-640d4bf0e3aa@siemens.com>
Date: Thu, 9 Feb 2023 08:56:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7204:EE_
X-MS-Office365-Filtering-Correlation-Id: 48076591-ae5d-4ab2-f8a3-08db0a732127
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0367pD2PRTRM1jmBx4kKaUlVI4BWGaLiwoEdQqL4YxLdaP2aa1rQzSAoKukvvuvsN9kEHmTodXogthQIY2yYhBQxAT5k0qJR2DjLURdFNknHxZSFIvBVBjSq4XAqIcsRN22lHnVotVo4Unn+06MnnUgOvlSJ5x8FMKBA7LPi6hjOUl4SJjed1UD+9yLQ9i/CVvtypAVnAMJJJcXEdgnEMpf8DC1vc1uZ7rMGB2HHOTpG7r6McKXuHeeT38TrDMUEJQNK0QBPcMiWyWfRAOpwhT49UP+cOVi/dd2sUb+0CEB6ieZHtbJYQ2FlLPzppkJbAC7Bs36dHmkEgktpgoFdN8O56ZcOxcLdsH3JVbsTr6m868lL1ic0tcAAfVSo0Tn8Gi9MsfAT3JkP1N+lw3YKIWdaxe/+GeGyViT90LQ9PaqBIZQJyB+XG2GHaMzLdihbYwQhjR/2rNG9V27M1ZgdjgQoW+PPTPEgz/0MH3vTZVLSn9ElEBP2bALrIjZoJPSH8fyTH5zjBIXIzpyJKTBeTNZB0Ck8T2TQL+0psGYSjUKSfiXByMx5aYoxbD9zHamrFMjUU+ZF3wZrVz9phCqdD5FsU2Tsgvz1RU6PWYOwUISeKgZvK5aGNFiMlBdlv945ABdR0l/lAf8quS4Bi1KyDZuaq7X/ixkRu34FgkNQQNIuyiKKwVQaxCT9U3kMotsSnYVLbrjiWArCpsKCaeUBas4fE5O8YmTeIe3Rd0Ej6YjmllJ8lSObEAI7RwjLsBAwB0aM1GyWp5pepGt7qpWrNQ+ZnWkqojfXRdY1TKW4shRpLImOP7Nj+w9j0pjV0HlG
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199018)(31686004)(316002)(83380400001)(2616005)(2906002)(26005)(478600001)(38100700002)(186003)(41300700001)(966005)(6486002)(44832011)(4744005)(86362001)(6512007)(6506007)(8936002)(36756003)(5660300002)(82960400001)(6916009)(8676002)(66556008)(31696002)(66946007)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UllYdzRoaC85NEVNd2JZbXVoT2ZMUkhXUVQ3RFI3eTlBU2gxOTJvdTlhcjhi?=
 =?utf-8?B?OWFRcmxOUFFOZkxUK0ZRc1F2U1V6dy9xV3RwWkk3aGc5RjY1cUU2M0pySVR3?=
 =?utf-8?B?YmgzL1dnSmhIeVhIYmdBaW1IbmZINlIrRUQ4TXEyOTJrT29JOVhmUDhIMU5O?=
 =?utf-8?B?RGVKNGZsbElyTXNrdllPOUN1VlFmZUw1eXNyaXdZc3AycHkyUURtdi8rRi85?=
 =?utf-8?B?bW1uQnpOSG9RclR2bjRnUXo4eXNvMlZmTGFzVE1vRDVtSlVMeWYvY3U1aFlr?=
 =?utf-8?B?djh3YUNVMmlvQ3hjaFFuWTFDNTIwSzQ2dmdvKzRxSWZUMWx0M1hBRmJKTElN?=
 =?utf-8?B?eldMSmNGTUNGZmtPc2srb0h1a1kvSTM2Z09yUEdxV3NQcGtuTUJFRHJROVdY?=
 =?utf-8?B?SE5GMnViLzRjQ2w4cFR4TmxIdXY1MlJGSUk4RFhxY3ZqZVVQUTh2bFlTQ1Vn?=
 =?utf-8?B?cVVmTVpIbUx1K2c4MHNwU2pycHRsRnM5UzFtUi9BUlpBZTdONzBnK0cxS3JZ?=
 =?utf-8?B?MTJZRkozRVk1dW9qM20yZCsrdkZGUzhKMFpXMzlzZ054eXZxK01XT3RIeGg0?=
 =?utf-8?B?cnArNVdIbitBZHV0OE5nNWtWWE1Cdm5MSEtqL1Z0WVgyODk1RkVtZXB4RGdW?=
 =?utf-8?B?a1loaW4vMEdnM2FuYTlQeXpOVC9ERFhxUTlIUFIrbFM1dGJEdDRWQVlZcDhN?=
 =?utf-8?B?aXFLSnZQQWl0MWoreFhITkJJbFdVVG1kOVBDUWJ6QjNIc08yWVkwZjI0bjEr?=
 =?utf-8?B?d0YxRzJVVnV6ZHI3dlMwM0JjcnVTRTdBN0Y4WFJybCtyVHRTUTBqZERCS0Nt?=
 =?utf-8?B?VWxXQ2R2NjdFRklXd1h0S0FXenY2UGdRc09YWEZqSWhqcXdtdkhmSmI5NzRG?=
 =?utf-8?B?R0JTakw5bldnNmtPcUl6ZHJWM0xueGxYemRaZ2FHeFo3V2k1ems2eGkxOGZM?=
 =?utf-8?B?blZLMWdJTEZDSGtNbFJRY1QwUHROdTdVNjY1OG5iOVJsZ0hSODM5UzdUczds?=
 =?utf-8?B?S0ZjWjZnVVVWajBBcmxpcDc3Mmg4YnpTMlI5ekRIRE5xbkk2Wk1VNkpzQjd2?=
 =?utf-8?B?NUdPSFFsY1FWOTFzVVI4TWxmTVVwS0NCSmVQQlh0V2gzKzQ3RDAyU1FkRER0?=
 =?utf-8?B?MEhTbFJmUW9KY204N1k2MEh2QXRpeG9nOEF3dkNjMFA1YVFEZk9ITTNEZUcy?=
 =?utf-8?B?emVYM29WNXZudnNGU2g3akgrc3draWZYYzVrQzhUY3lBNDZLWFRGMFQxbUx6?=
 =?utf-8?B?VXBOWElCYmRrdFhPZThnNTZKN0VQVHFaWGRSMVQvWFZ4RHBwNWN1cTRlY3Bh?=
 =?utf-8?B?WDB2UFFuelcxcmNGMU83dW5Ec3pUTXFSN0QxUi9tUVN4M1ExSmcyTnc5VTR5?=
 =?utf-8?B?eTM2SWpWUGJ3NzVTUVRoc1MxTitnWTJodmZlTjRpN3NGYnp6UmJVM3oyb2Y0?=
 =?utf-8?B?VWJTWDg0OWRxWlpUbFJ3VDhPUnVWRVFFcFViVzlVUG85NFdIejFLYk5udXli?=
 =?utf-8?B?QzlJTEcxVk1UWUxyRUZyNkFyZXRFdVJTanZwTjdSNHhKNTMvUGQ5T3Q2aW95?=
 =?utf-8?B?S2oxRVV5RE1OSFoxOWREN2lxdXNBa0IxVEdrUDN4ak9QZUVGM0tmbGpRbmda?=
 =?utf-8?B?cndOOXZ3NGNVbUpsZnJYdnlUVXJEdExiWnh2RTltcHladmRYNjZOVkp2em9s?=
 =?utf-8?B?Z2ZGdmQ1MWZoaDJneDFhS1BsVjRISXpuTGkzcVZTYkRMa2J2M3lhTTIxaWRz?=
 =?utf-8?B?REwxVnQ4VkRXMklwSXlUUlBkR1BwbTRFK1RaV2NnVmNEaktKL3B6bERqZ3Qv?=
 =?utf-8?B?UHMrWWNLQnh5VkNpcVpqeDlZdVViWTBHM2M2TUgwdmQ0UDdUbkd0b0o2K1lO?=
 =?utf-8?B?Z29VTjIyWW1lUmpzTzR4RkZvMVovOWVuQlcwdnM0S2phbzd4OG1yZmo2VTN3?=
 =?utf-8?B?MkQyOFFvNk8ycTNzRkhyQWgyeHJnUGY2NmFTakZjVEtteDhrZVZ3d0JyVHJM?=
 =?utf-8?B?eFdkVW9JbWRuM3NsclF5TUd5TVBaTkZKbEY3bUtNd0NVOXFyR1JnSEloSU5p?=
 =?utf-8?B?aCsxcTA5S1pLVmV6MzVXZjZrVEZWWmNkQUNJZnRtdWY5bWNPZ3kwVTVJbFVm?=
 =?utf-8?B?M2VkUWNndzVBS2tYcEE0djE2USt2dkNOTENxODhXV3VKaDFOdWY0Nmg5amhD?=
 =?utf-8?B?Z0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48076591-ae5d-4ab2-f8a3-08db0a732127
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 07:56:19.8259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RZoNTsTOVDnlsLlFf9baTXEYZUG5mOC/ffkjRFzPbMTCrJr75XZX0y0uXki6TkcD1VoFkTX8+uUJapwHu8iE1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7204
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Feb 2023 07:56:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10630

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=2&day=9&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/02/cip.2023-02-02-13.03.log.html

* Action items
  - enable more stable trees for testing (patersonc)
  - report 6.1 test plan to LKML (?)
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
* Kernel testing
* AOB

Jan

