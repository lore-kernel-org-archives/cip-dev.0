Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA56C25B75
	for <webhook@archiver.kernel.org>; Thu,  6 Jun 2024 07:32:09 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.83])
 by mx.groups.io with SMTP id smtpd.web11.8679.1717659119400098500
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Jun 2024 00:32:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=KfMn/ut+;
 spf=pass (domain: siemens.com, ip: 40.107.249.83, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBWPIV7p1hYVkOlQU/CQWBR7y/yIBY20iFbNz5beP5xBOC+NE1jQRQj2hkFsT/Gq8yCwOi+VGAvJfMeG4+V2lfb5tCxsxtsHMXu7dUgBdauI2LN69VNQFDphCd/RQOXgDBUtnnY5lBQj+9dCkX+yadvkkq9SLgl2uTtpn5m34Z6FiOuJ1s7B07on+wOrEQVUxSFDc6oBVwr+JF979EGiTBRGvUKXRTH7urQc5D5dOEOeMUsi1lGuw8THf9AAZA8WgGdzhhg39A7eaGmyqUnsLq+UDkcb2OdPRnNy8rwM3xM/KlfTJJq7WgjvGuK6LSHTtu0YVd6gmPuUkDR1vfGSRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHh/6S9ZvHcKhxFAuuT+EcSichk38kze6rk4ITkLJhU=;
 b=Y5WnldyulxPpLznHbqEnlorg9nj2bd7DQQD9NBzfv+g+xCdMjVq49fSuZ7pHK9ZM+YBm73SvWzRhBipOBJCpX64B7m6M4oQVbk035zymKUP/XF0bkiCRZRW1oIoKicmbNqesuEr85gQIgm1driRAx8bU5y4Q2nOxMiaQhLyFNzE86wWqti7jO59z3xIYvSNDAGX7yt/NW7C6KM7bqP5HWWe/z3UbFMmdc9n1Ed6OPjB7WRf2zJCafznBdnbVjjufEGN4+OrBv4/hU7J/wtb0W9tD7IiGNhUx8gc4iO830L1VnuJ/618x9XkM2uCmcaxvlV4Rm/ciIWyIiuQhm0bFWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHh/6S9ZvHcKhxFAuuT+EcSichk38kze6rk4ITkLJhU=;
 b=KfMn/ut+5xzQvHLZOf5WpbyJ94/wgxgLZtJ8fzbFgUVX94d8m27xAAr3m7O+jgAXDpUA22qVE1fJJ/h8DbLar/RNtKwAEO6l8NDs3DXvN/RPvHZKumQxb9yIx/8sWByn2qbLBbpn77VK2ZVfNOE4AtzH7LT0JxX/RY+FOaszPzhThfilj7IiizpztB+n1zT+WDRVhGht0/wRWCNgxv+0ptDDleAdVIZT1/LtgrXTw57oV5x2Gw3utMeh0ThnQPnNt3iXyz77xI9I/Dy66L735OZ8ROEEAuDsEktqV1TusTQv9w9JISBSHUopqCChkjag1AKcsVB2kr9Wt63Yn3Qlkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7565.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:402::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 6 Jun
 2024 07:31:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 07:31:56 +0000
Message-ID: <9805ab8c-760d-440f-a0f6-8804fc7c6d98@siemens.com>
Date: Thu, 6 Jun 2024 09:31:54 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7565:EE_
X-MS-Office365-Filtering-Correlation-Id: 5614d465-02b0-4f0e-01b9-08dc85fabe69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UE5SZG9JcnFpZlhXTU1GYjc2dmtrWmZZWmg2cVhWSjRlUmZBTDF0TGcybGQr?=
 =?utf-8?B?ZVZsUU5JMTBiSmZiOVB6bFd6YlN5OThwUDZtNWlmMjIyeTA0Q0d1Mjk2RXIz?=
 =?utf-8?B?T3l0aUI5Y0JNa016L0pwTS83U0tSUzB6QklydlRlMnQvS0lvWjNUV1kvZE01?=
 =?utf-8?B?WmZ5OGlKR1FteGpOWEx1dzh5d3VPbWZQVUtMQjdvcTRsRjdTYWJJMEU4M0hQ?=
 =?utf-8?B?VUpkNE9zOWRhMmN1Z2lXQUE0dkQvZWVuZkRTeE1JNGk2K2l4WXc4QWx4aTdi?=
 =?utf-8?B?SFZwZFlESXAxbWczaFVtVmhFYnpjUHdEWXRJaWVPU1dJcnJaTEdCSmJmdm4r?=
 =?utf-8?B?SS81QWswSDJKbXNRV1lIM1RseWw4dFdWTmQwanRjcE5nREZ3QjQzbWJmVVFH?=
 =?utf-8?B?TnVQb3RqRDZZWmZQVDg2N3VLUDQ2OVg3a2NINkpBQm96ZHhCQldYenVyYUMv?=
 =?utf-8?B?ZkRpWDNjdmwwWHB4b2ZwcTJuMGtsZFAzWEdiWVVMdUx4RDRqeGFiQUF6OHdq?=
 =?utf-8?B?bDhSSmFCbmdkeE1Kcm9sN3BQZE9makJBRUNNOVRIR2ZjUkhoSnFIeTFKRFJt?=
 =?utf-8?B?czlTMWE0b3k2Nm5kQUFGOXBXK1RNUzF2T0pVaFptQVREYWN6bVhtSyswamVi?=
 =?utf-8?B?cms5SzI2ang3b3A1am9DeHBTajhpamVTTmtnelFMSFRkNy9zemo3RzZpejVh?=
 =?utf-8?B?Y3loSlJwVG9pb21uYzZxbUEvbkM2MVlPWCtYWWJWMURtdU5tZjNmZXFLTUho?=
 =?utf-8?B?ckRyQmNkOEpCTGhTMHluY3U1dGpnc0xKaTYyY0sybyt5VG5IQmtnTGpmQXBo?=
 =?utf-8?B?bjBwb0hDejBBYWVCVENHNzB2M2RaNHFUbDJ4TmlucitWclhibGNaWWl1dk9V?=
 =?utf-8?B?V2VKSFRzcVpHYXdrSzB3WFUwZ21oS3hqWVAzU294K042ZUdnV0dGSldGdEor?=
 =?utf-8?B?bGt3c0lIUld2Q3h5M053TVR6SWNpZ2JpcFRZZjNwUlA3TGhyZGNiMWVZZkFG?=
 =?utf-8?B?NXM0SGNCRzY4SmM5WFN3SnhMa01BdndnM3ZLQ20rZnoxT2lTVU9udWdVdnU5?=
 =?utf-8?B?bkU4SzhuekZOSWFBd2xCa3YzZ3pDUVpvRDlJQ3NxcVU1SGhqUXFwOXdBNENn?=
 =?utf-8?B?dlNCOHFGV29HMG1rUDJUZng0QTYwSmVGK2ZyYVdrSVNHMUpVcnVNNHcxeE43?=
 =?utf-8?B?SWJnbHErRG14TDh0ckNBQlBNeFQ3bE5icTN1a3UydWlSdS9IZzJqaDgrenVp?=
 =?utf-8?B?eklSNVp1R2JnanVmeTRxTU1zY0Zra1A0aDdZMVdIejgya0Uxc0NBbzF4dlNn?=
 =?utf-8?B?NjhzT1F2SVg2RnlJemFWZVFFdm12aERMYlRtalVMUHB1VTlOZTBLbmU1Sy9V?=
 =?utf-8?B?aXhQN0RvZFE3NnZrcU1wYStTay85OG1sZFlxOWwxbWV2MTVsd3d3OWM5Tk1j?=
 =?utf-8?B?Qk92RzZuWkgzUGQ4UDdjdHlsWDFCakcwRTBvQmNpdGorNU1zNmViV2hleXNp?=
 =?utf-8?B?djhoVEpudkFoNEtqcnZPc3hPVFVwVk0wWnpNTmRTMWY1d3U1dFFveHAvdTZ1?=
 =?utf-8?B?ZVVQeWZxd3BERkRrYnlWajl6R250YXd5SnZKVytTM0o2V3JQU2U1ckswWUNP?=
 =?utf-8?B?UmNlcEFOZTBaVHkvT3lUNEdYQTJHL1gxNEEvaE52VVBPcWs5WDUwWHBBZU1U?=
 =?utf-8?Q?Ee/JROvuo7DLaBT6k/1X?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RUp0N0JWZ29Kc3JSY2NYNHN3MnNHc2h2WERlcnY1N1NhTUJmTEhhTDNvdjB5?=
 =?utf-8?B?RnN5RVZKOGJBTXhtSnBNNUxyREY0NCtkZkpYN2NmOUQrR0RreE5raEFaZEdr?=
 =?utf-8?B?bTUrRzNOdTN2b2VaYjgvSzIrZFlvU00yWFQzS2pxZjE0ZGZvQnBTMGRacjJO?=
 =?utf-8?B?RUlmdkFwZ3RHd0JTOURQY2lnNW9kbzl2U0IzeUxCdW1lMFpQM0Z2aUxSMVlB?=
 =?utf-8?B?UEdIcW1vMmVqZ2JEaDVkTFpiS1FWTFlLZTZINmFiT0kyNTI4cGdiU2RZc3Yw?=
 =?utf-8?B?emlSTk1ON1pxZGFFV0xwa3hDYysvRC8xVmJMUGg3SHlEeFFEeXIxMmNpWllo?=
 =?utf-8?B?alpTMkw1emU3ZkpDRkQ3L2lhN2NZRFg4bHpsUGF4WW9TTXZjeHRKR3FTU05I?=
 =?utf-8?B?eUFJdnRnVEZ1ZkpxcFd5blhrMEp1VStSZ1VQVk4ya1BBaTVDOG9UOFh4RWVw?=
 =?utf-8?B?RWVWdmN0M1MzNGhJV2JsTVBnYnBuVjdTVFRnZFdwQnR3Z0RnbE9rL2FQU1c3?=
 =?utf-8?B?Y1BHM3YvR054b1ZKTnBUQTEvNWl5aXEwbHVobmxRWWFwZjNnRUR3OXBIT0Y3?=
 =?utf-8?B?OU0vb05nWklWRTRIU1lZSnNMWi9mUEQva2dPWlI0ZGplVWpTNDJ6V1NNbC9U?=
 =?utf-8?B?cGx1OWdyYUxLUUhHeThidmU1UHdiSExSUHhVK2NqckMyb3ZXbk84SlpvRGFP?=
 =?utf-8?B?WkYrMktRS256RTRUWVhZMStKZm1SNmdlc3VkTHpYQ2JLclVBbXd1bVRXaFZy?=
 =?utf-8?B?cGl5ekh4UHpyV0NYSytHQW5XM0tJWHNjZ2ZyWUxkblE1bjdZSkJDVk5tQXlm?=
 =?utf-8?B?UVRvZnJqZmJBYUV6a3oySlBqZllrd3pYNEYrSGxqUGFKNUJteXpGcjY3aytE?=
 =?utf-8?B?RWY1SkVKYWt4eG1jODlwb1lWS2FFZkJKcWlMZHYrODYrUDZqZjV3VmZzQWVI?=
 =?utf-8?B?cFpPT1lRSXNqa3A4bUExWWZ0SVlvL3ROWDQrZnVieXNDeFM0SkZ0ck1rdUpi?=
 =?utf-8?B?eGRMTHZuOWxuaUtwb3kxclpGQ1EyUmN3ZUNMNGhIZHpCN01VamVNMHVRRjJ5?=
 =?utf-8?B?VzdKQ0Z2UjgwbVZ0UzNxOE9BYmlDRG9xUURLMFppSlYrczJRZXRBNmNCSWVO?=
 =?utf-8?B?UFhuL2tDTlRZOGZ5bVRmNU9JazVTMjVwVm5sVnlxNVowSWZRYktpTEJJQXdU?=
 =?utf-8?B?ZlJXM1o3eEpnMFhlTVI1R2xNdGU5em4zZTR0Z28xTnRzSCtVb2YzcDZtVmJv?=
 =?utf-8?B?ZlhIZzNBaWtza3BTWDNEOVZYZHpKUHUxcFZyaFI2ZGFuWmg4VWZDQlMyZG84?=
 =?utf-8?B?ZGZqd3FRYk8zRXIraldpd3F3Q0V1anhtNHM1QldISXFrWDlUVTRBNjcwazhz?=
 =?utf-8?B?Rjdoc2x1T29WRitCVnpOb2dmTmZKaEFQTXl1U2FZbnJUZ3JvWGdRZkFlM2Zh?=
 =?utf-8?B?S1ZZKzZyUUtmci9seG1iYjMzVnlidkgrUU5jRlJ4UHNRTFlRZytzNXJBekh4?=
 =?utf-8?B?RWFzVHVUZk43YU9hbGRTaUJRbWtGMmpQblB3cFRXY2NqUUlpOW1vK1hDb0ZX?=
 =?utf-8?B?a2p5eUpzdmZCdkVKRk5IVWZzWXZ2U1JrR0tDY0VhVENab0VrcTBkZmlEREhC?=
 =?utf-8?B?M00yZlNpTU9VcUJ4ZC9xVU15anFVM1lkMVdaWi9ldExJeVZ0d1I5MWlhMVBL?=
 =?utf-8?B?U0hjbHc4bVhFd2dBb3NyQS9YNmtVclpsTENNekVLYnZoUmVXaFo1YjNwckNp?=
 =?utf-8?B?QlhqZGlGMWhIL0tST2FYVkJ6a1hmMzVEOWdRYUpNY3dLRkdpc0N6Tm1YK0lF?=
 =?utf-8?B?RWgvUm8wTDMzTlJ2NXEzaEdOT2N4eHk4NWYwbzAzRXpabWJtQXZqdHNZcUVh?=
 =?utf-8?B?Q0FBakZWNjNoYmxjbDBjZU83ZjVKZUNBODYycVhVQ2NydXRNQUdnUHdoZFFl?=
 =?utf-8?B?SjBKQm83amsrSjUwT3VDVFVYVVJ6RzhsYlBvcENlbUg4RnVpSDlTa3NJdkor?=
 =?utf-8?B?Tlk2dFNRNFR4bmxvVGVCRHFMRzRSa25uT0Z1MFdYR1hMTnRVVTc3TUZFYS9J?=
 =?utf-8?B?Y1hYNUtnR01ueUcrZTVHUTFqYkdWMUorcUI4QVZ5eHNCWm1kTyt1TXh1NUFY?=
 =?utf-8?B?TWR2d2hsREg4eUk1Y0p1RHF4SGFZbUVGTHcybmM1alltRWFmMWZueGZ1b2dq?=
 =?utf-8?B?SVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5614d465-02b0-4f0e-01b9-08dc85fabe69
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 07:31:56.3390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BYy7XaNd2jG1jD/hJft9oEz62ttui7zwzETwNkYTBfSw9X7hOQr80RnBF5tZfGeKz0EQ2E78idMzrQpqNOypeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7565
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jun 2024 07:32:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16123

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&month=6&day=6&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/05/cip.2024-05-23-13.02.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed May  8 10:31:09 AM UTC 2024
  limit date: Fri Jun  7 10:31:09 AM UTC 2024
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Mon May 13 07:50:32 AM UTC 2024
  limit date: Fri Jul 12 07:50:32 AM UTC 2024
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Thu Apr 25 11:55:36 AM UTC 2024
  limit date: Sat May 25 11:55:36 AM UTC 2024
  Status: *Late*
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Thu May 23 09:06:28 AM UTC 2024
  limit date: Mon Jul 22 09:06:28 AM UTC 2024
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Wed Jun  5 08:14:01 PM UTC 2024
  limit date: Fri Jul  5 08:14:01 PM UTC 2024
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Fri Apr 19 09:32:00 AM UTC 2024
  limit date: Tue Jun 18 09:32:00 AM UTC 2024
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Tue Jun  4 01:28:02 PM UTC 2024
  limit date: Wed Jun 19 01:28:02 PM UTC 2024
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Tue Jun  4 09:25:36 PM UTC 2024
  limit date: Thu Jul  4 09:25:36 PM UTC 2024
  Status: On track

