Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4757AC54E68
	for <webhook@archiver.kernel.org>; Thu, 21 Mar 2024 08:02:37 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.74])
 by mx.groups.io with SMTP id smtpd.web10.2124.1711008149940928902
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Mar 2024 01:02:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ZMv4WLQZ;
 spf=pass (domain: siemens.com, ip: 40.107.22.74, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISytm4TKQxUyfbHyR5vkXLNkO5Qw0oBZOPlBZGbgqlz+ugMF3MmvQLa2AcgeG+VK7GJapqqUHrG0myi1vfbRmMtxc1HqwPvTYXq4Q8JRNp5w7WpPNuvoV+cK5HTBvl8BXu8jzTzlWNittrba42/HmMke1vrl9JzJ3xDD2VmoANvFTlg88PLreLF5zVus06lLY20KFly8JQL1EjqOFS8nwM6uhgZsg665HrJt+Oocd5PjQlo5jJZd09uL8GVEBLVsZBw1/MwQINxZKCovJn8bXCrk+D7v85i6u5Vba3CY1fE/NHuU5Jk5cHSyLCqruQ0AhcV6gnLFcWc/Sfbx1i8Tfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMf758NiIx3uL+bwdHsT3H80ZmdCEX32T2pC7XRTpbY=;
 b=nFbfuQlcAIRwx5kXd72+iw9UXFmxopU3zJvQ1+zSNugR8XiI7Yix+Dx2uVMkewobn2GfQxeOT7DxRUEtrRj30vzUZu0UySqmEWXFaJ4OTvmQaH9VwWP+14eggMlbRSf4mUciMOCsMhnl9IOpHsqQwX49CvlwIaqRfPamXGVo2C0arWNcM2z+N7YmFGN4ktH4yoZZ0w07H3NDskRENV8k4eBFXYKuWOHSl8LOcFnZ1FWNj0gnLfvFl3A5CXwhaDkHUMBLkPod/84XTWCv59cLxcbPqc87aD/dppSCBKZGXFOILUpmTtTQYsw5OmUXGPAX1BMibd67onWmXW18qfK1BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMf758NiIx3uL+bwdHsT3H80ZmdCEX32T2pC7XRTpbY=;
 b=ZMv4WLQZYV38hqIq5/QCY0UJ9reUVZFIt2pZjNLVjsfr6dHuV69w8jOisCCLd6mU93FsQOT/e6Oq+dkcG5fK7JtGtphFS3RrV74OsE0M2YEigWZo/cwq9jBmPyVCCwshTV86GyKKXz55ZUI4X01xuqzfnsMLamolMqi9RXwfJ9HWwq8EKaH5+gZtI7I53RTEMS6z1N41gvSAylAzc4YKB2Ms6nbv0EUsjajoSqIRu+FsCEydEP4he3WIT41s0ZKXHaaAhOHpShOlu3UX/fiO8bTOsmg+ywZjMWD4RWCJ0HKEubqIYiOXgO+n3mZ3nyh4ljtnob6lEl1ljieLPHdz+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7862.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:492::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.29; Thu, 21 Mar
 2024 08:02:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7386.025; Thu, 21 Mar 2024
 08:02:25 +0000
Message-ID: <cd2f9b27-64e3-4d22-b50b-2baa2d0b9bdd@siemens.com>
Date: Thu, 21 Mar 2024 09:02:23 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0157.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: e860feaf-ffbf-47e5-1dec-08dc497d3e93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8QUM2Vj94V0FyTKplmuqFXbrTudEQ1eVNjY0OBKgyJ3Kr4FTxZk2GJe/1sr+OU0RcIPN6OXnTGgxZ4c80Xn0HE6ny1IfvSX84ecGdVeZBPe6TpXe2C52muEnb73pu3+xxyeHEFJPESGZ39cn6sQTKHFIwzjfPqYs+xMcivZPX2RqgoCvMvviwhAIz+6Usvb8WNsv/uS16SjlCDGoH0beiuLkVnYCJS+un77Zb2vsvdGkhTlYBA4zlozREz6O/AVSyqwoh8iY8LB3IvtsccXQWDFlZ6PaD3pbt+XXSBd4o/6xn54+leF4beCYIlcck1iFdM3zx08b2PvcVoXbA11sVCmT+yaY9nB72+QjRrX7f2WmeN+DdEq4n/V8+5EoT1uT7uUi77vI/l3VWd+PMa88zxgGmOP5SOosFagZrznvlCW8398egR1bytWm3X2LGPfY1GmseLnjvzEpOMMbAAfqmPXOBOnTtWrVCxsKUDp2MkMYc+EUFcBWoVr7meGjlGP2Q1B/pBiLE1F7egoFS8b/XFsWWyu+Eiv5DfKeLyGczboLdSyCqVh+4+eiQRkDJA+BNvEyBouXd/5DCyVwKkG3Hj2p3jEwMAwNSYKuqynTuYQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?M1JxakZUVXZtTlNDdXJnSDU4KzJCY2ZWajlyRld2UWpIcG1yZ1lCdFpZVmNL?=
 =?utf-8?B?NEVxTUdyeDgzSDYxZGlhOW5adjdvU3ZpZHFVd3VHaWVvUU83TlVuYWhvQUl3?=
 =?utf-8?B?YW1XSDFlN3FGTkVLUFRwRUFnUC84M05ZNk1GNEpuTXQybTd1R0ZsY1VCZDVK?=
 =?utf-8?B?SjkrMlRGcFlRdzJTS2VuOVpTMlNRM1dHbDNtUzJoRUpyaGZJazRlbE9NK0FC?=
 =?utf-8?B?ajVmWnQ2TXZ0R0VKdjFwWGNUckpHcWFsWm1FMGVHenJCUlkzVlV4TVJrZG44?=
 =?utf-8?B?M0N1SkxKSjlHQU9VNzdVdE85VTc5VklXYm1BdFRJWmZhclgxNUVJYmFiTGp0?=
 =?utf-8?B?T0lKOGlRaVZFSFFXWjdkeGFQZG52TVNWNjBwd08wSHpwSmxHZmk0aEhieFJ5?=
 =?utf-8?B?QVoreGExcTdYNmdqMzZwS2YreDE2V1dEMGxROHdteHVwT1Q0UjAxNGhwMlph?=
 =?utf-8?B?NTkvYnU4cjRhV0I1ZytGWlZiWDAvSDYvZWhlbXZhTW9Pbkt1TG51V1FlM3lq?=
 =?utf-8?B?b3JuRjJKaG5leGJITlQrS1o2KzJFRU40dWZJWHRNdVkwRjNBQW9DL0grUith?=
 =?utf-8?B?LzRscnluVjEwMm1JNG5aTFJZVkxnRnN2aDNWaVJsbFFkZkZpZ0E5NHJkOHVq?=
 =?utf-8?B?c2Y1NzhCa2ZRK2pBTXlWRm8xZjBWTWtPVFYyOUZlK09NWW5EVWw5VUlhNkNU?=
 =?utf-8?B?QzV0OUtSY0dnUHVlc0VrT3IyQ2RyOE9sbDMrOUNXVlZmV3EvaHN2SkRUdFhh?=
 =?utf-8?B?ZmNUS3VyVjdYdEhoam1LZnlQa0NTOTRxc25SN1pvcUlzRWt0MHdsQUFMK0g5?=
 =?utf-8?B?L0g2M2xGaFN4a2dsb1pqY1BscVZySzVsVzhlUXN1a2JCWFFxWkVNQzJ1RG9I?=
 =?utf-8?B?YVNjYUROakd6Zk9obUhMRHF1dVhzQWdiNXpod0lPdjRQUlIvNW84aEgwSGNI?=
 =?utf-8?B?UUU2YndmV05YdFdNUkw0SW9xblBJeXFaTXptNFZGN1dlb05Yd1ZZdExKVFY4?=
 =?utf-8?B?aUVUd1dwb2srd3dPczdBSnNIbyt5YzRuQmRpUXJPeEd6b0tZSEsvVk5xQWl1?=
 =?utf-8?B?Zk0zZnpoRzF4bzNSMi9lV1luVTFxek85V3dueXZpaUJBZUlJVE5sR2xYMmth?=
 =?utf-8?B?SjU3TWM0SXhmeXgrYTJmOXJUd2ZwSmplY25MeEpjSHIyeSswV2F6Y2MwVWhY?=
 =?utf-8?B?WXYrUndydUt4NWNNa3BZM2xOZWFTR3B2ZlcwWDZOZVo2LzZRbTZ0YkhlMXRE?=
 =?utf-8?B?UytSbExPbFpwRDAwOSszZHFLQWNwak5qNi9BLzdMcXhXUlU5WndneU83SVhp?=
 =?utf-8?B?U3dZeDNFRXY4dWhyVWd6SnVqdFBobXVISDI3M1ZNSVQwRjFJV2VKczZyUG5U?=
 =?utf-8?B?UHNkdUwwaGRaVHBkdFpHSVowS0dCRFJQQUpwWG1VSmJMcGtYNHRWNmVPcnFv?=
 =?utf-8?B?UUM4MTV5ZHhjdDlDcHIxNFVMZW1kYTV6WFNra0daSjFwV1NPbG9RTVVsY1Qr?=
 =?utf-8?B?anRRUmF6N0MxWkc1ZWFaQndva0VRcXBKQzIrclRNMWRQRk1kSnNVVERhTFcz?=
 =?utf-8?B?d1NDTVIrSUlGQ25Jd013bW5MRUtYVno0bXp5UG13ci91QVhQL1o3S1IyMm9l?=
 =?utf-8?B?OVFzN0pOVkZjOTQ2MS9ITGdmZzZxT2tIUHdLdHVLQWx1YTBnbnJmSFJ1dXNu?=
 =?utf-8?B?dkFubUdvem1GZStXd1pkRU5xNGdmZUpQRDdienhlMGR3OVJuZ1VFcmtUTEkv?=
 =?utf-8?B?djluYmtlalJJTWVTWnNuUmhGNEllZ0xjWGFBQURWL0Fqa2w0SzBEelBMQmNm?=
 =?utf-8?B?Rjg1RmpzVUVzVkdJclZ6cTAzZnJvd1g5STRZQnVSNVJsTDVpamRFbnhKTWxv?=
 =?utf-8?B?TjhQVWliVHpLWi8wSnMvMFN4dmRFaU1pNWZFRkN2b2NVU3dvL3A0a0Y2L0M0?=
 =?utf-8?B?QW91YXFMZ3NoNExIYTZqMzJFdmRJK0xDTzE4cW5TUVA2eU9jZjByN01zTE5j?=
 =?utf-8?B?T1lBT2xCa21DK1NJRmxXQWkxRm54cVlSOUZtbzNiOFdSU3pleVpDZk9EZUVl?=
 =?utf-8?B?SnFpNDdYMGt5MWxvRXJWZnFpa2tYQVd4VEQ1RzdHTWVscnlubHRCUnBJMGZJ?=
 =?utf-8?B?NnFBL0pEckRrNUM3OW9RNWtVMmVmdWJndFRmSkg5dzBSOWRqWGozMm9ENGd5?=
 =?utf-8?B?TWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e860feaf-ffbf-47e5-1dec-08dc497d3e93
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 08:02:25.0582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q20ZUcaWquujf1ZpGavvFtA7QkfaLGPVJH9iZXROKLM+qcJger0kLMJjt2LqX9WuII9Q/iEgVLJJLuDM6THzuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7862
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Mar 2024 08:02:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15394

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&month=3&day=21&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/03/cip.2024-03-14-13.04.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

PLEASE NOTE that I might not be able to fully run the meeting due to a 
parallel appointment. Start without me in doubt.

Jan

[*]
linux-4.4.y-cip: interval 30 day
  latest version release date: Tue 12 Mar 2024 11:03:54 AM UTC
  limit date: Thu 11 Apr 2024 11:03:54 AM UTC
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Mon 18 Mar 2024 10:21:04 AM UTC
  limit date: Fri 17 May 2024 10:21:04 AM UTC
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Thu 15 Feb 2024 09:08:09 AM UTC
  limit date: Sat 16 Mar 2024 09:08:09 AM UTC
  Status: late
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Fri 01 Mar 2024 08:49:23 PM UTC
  limit date: Tue 30 Apr 2024 08:49:23 PM UTC
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Mon 11 Mar 2024 06:10:02 AM UTC
  limit date: Wed 10 Apr 2024 06:10:02 AM UTC
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Mon 05 Feb 2024 05:21:45 PM UTC
  limit date: Fri 05 Apr 2024 05:21:45 PM UTC
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Sat 02 Mar 2024 09:15:14 PM UTC
  limit date: Sun 17 Mar 2024 09:15:14 PM UTC
  Status: late
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Sun 03 Mar 2024 05:34:51 PM UTC
  limit date: Tue 02 Apr 2024 05:34:51 PM UTC
  Status: On track

