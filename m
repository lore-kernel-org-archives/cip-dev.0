Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2FAC25B74
	for <webhook@archiver.kernel.org>; Mon, 27 May 2024 12:37:13 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.58])
 by mx.groups.io with SMTP id smtpd.web10.26556.1716813427960004660
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 May 2024 05:37:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=y3+oSdqh;
 spf=pass (domain: siemens.com, ip: 40.107.21.58, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6oYJ7zJd63xws+bko5EJ1ypFsOSQxRLFK0BiCijP/ikysjk9jR2F9EWF/x5Ma+gMmnLmC4LPDrrciLZ5ALDrW5ipwOEWU3FUkxO+Ukj5VfLeuiK4NLz0UdJI8r8g4pLX6MS1BkC/9n8Gi71OXd2tbJFqQ8JXxkg3aFEN3fcLHV4yjMmP6DG7fgYxFnux/pPWdLShNyHtsAOeNWsEoV4YZvf0mu4bqtQg0c+XINFT9Ah4G2eGgeG0eRkJTlSduWXA6pSxB54EtlaeRJRhOk1nxCP/aviUpOelnaS43rgWfUaNEmtcM1bbQYpOxN+LgWBIgQA/V5eGml4xiScs29Oow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIRneW5OqDRF4E+2aREbRDU5xcrIPF218voA3XqN1aA=;
 b=VVi8wj6eS8EC3XPZi8jeC5ZCcLzigJaZ+FqjdiMZr9q0a8JC67rkLay0VqvMoXK1CqP5Noxm0LeCKLCJtkuF6qnPRqSvcjnmacym8EFApjX540Q1b9jyrCgHg3ptNrdIGYX5HlzVg/d+T+IllMYEarspUVz1P+4pltV1MpSmcC+a+aZk0tihtDIKuXKuZ8VK2wkJS3am2Dj9jksHd760SFSjh+3tHORdXZ1qndF0OYD2IzPFQ9eG5S2OUtxoK/wZb/vH0AMQnX2ee8v8OWr2Ee2dFXPmSJSHdEaVd5RomU36eP0WXz5QmbTqaXdFreNjq6ooZoF65qIUEOLQH04BNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIRneW5OqDRF4E+2aREbRDU5xcrIPF218voA3XqN1aA=;
 b=y3+oSdqhitYhmBB69rJOlflJ6bDLgoXz4SJyi20F0uAAN+DA4/VRVihZQLh3qGZ9yyMriVX7bBBTH1hMbjHEFCJ3b983YHFZ+5j7cI8T3/yX2biodboW872Yl1tDhFNQzVUS+7ZDb+gA5YE4XCy60SaqmRTjmjaOHwYW++RKea2yysZveP0TUeqefq5qndX9kr+abgAArQ6Ig96nu7PpA72sZn85igVyfA28rPuEwlHabFlPKO1E3EgfQTYOsI9FMqUeH9r0gFvbSDP006sWW3wFm9iXitn9c9D7VCIwu5WErCggBvoGIcFwfB5WYhz4x5FzyQh7fzcH2snSEUwRNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7262.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:449::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 12:37:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 12:37:04 +0000
Message-ID: <5bf62a03-889a-46c4-a93b-0dc7ea159c98@siemens.com>
Date: Mon, 27 May 2024 14:37:02 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Derive PREFERRED_VERSION for native
 and kbuildtarget from base target
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7262:EE_
X-MS-Office365-Filtering-Correlation-Id: f1c870ad-5c12-4ad7-c2fd-08dc7e49b6b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YnNCaFo4NGRnR1A2a1hIdzdpWlFpUm5jZ3NFUHlwWUNYcnVMZ21DN1RCVk1N?=
 =?utf-8?B?c1VJbmFPUTFPVHUySVpybEdXWEIxby92cHZEN1BzdFZOK2hJZGVzKy9sRzVI?=
 =?utf-8?B?THBjdVhublM2a3ZESEZZOVRSM2FRc2UyQ29YREFMSVN3SkhieUhmMnFteVB5?=
 =?utf-8?B?dStJN1JlSlpPODR3UHY3OWxETzkvYTk1YWt2U3JCZDdkUGVwZUd2NGIwU3Rl?=
 =?utf-8?B?aDJRanlKSENqWjYzOVM2eGFLZHpxMS9oa0Fob3pCK293NFYxVDFOejRFcTl4?=
 =?utf-8?B?SStsaU5xaEJXZ0MxcEU0QzJyUUpocWQvQXloekovNnY3aFBTVjFHbEhjTklI?=
 =?utf-8?B?R2JMVXVlUXJralhVRTduTEcyOFFFZ3krT0h2Nm5zYTlrNXU2L3d0UjRmOGhx?=
 =?utf-8?B?RTMzNXd5NTVDdm9BT0RxYmZGUlFGdzJJSGgzRHczUkFyTGRBSmYydy9Bc2NU?=
 =?utf-8?B?YXhyYTVKOUdDUVpiWTNSZmtXbDV5M3c3L1NXZFNCcmdHMk1mRlJ2di9naG5Q?=
 =?utf-8?B?MjU1UkdUdStPYWRuUkJmczZVeURKZVFNc1dNekZvektXTWlhMnlIUWpqNHFH?=
 =?utf-8?B?TUpLMXJjSUpvTWlicXdicSt0M1k1SDlqZVFJSU5YdXh1ckl1VFFMSzNyczRX?=
 =?utf-8?B?WEJTQzZONjlORXlaZ20vWlRaUVlNRTgvbHJPcVhuRStmK1FFQmhGbVZnTUx3?=
 =?utf-8?B?eGtGdEtyRUI2Ui8rQkV1b0ZGbXV3ZGVxT2dCRWd0TEhtbmVXTEJqV2poTFdG?=
 =?utf-8?B?WWw0OWFSeXZRWWlFbnJZTGhpZ1U5M2NQM1VvNjU3dW9YUkJsdnFITlFHejdu?=
 =?utf-8?B?R3ovdk1jMmM2MlNIUUZmdXJJaUxEbit3MWo1QVcrQk43TWZzaXBlczg4T2Jp?=
 =?utf-8?B?WkdqNUNPZ1Vzamc2T3lXRHE4Unc1enNJT29pb3RZVXdUUmt0dWZkNUx1a2c2?=
 =?utf-8?B?OVI2cW1KRlYwc3paVlBqVFRrSmdPdVAyWlU3Tm1nTTltK093SmcxdDVoeXRv?=
 =?utf-8?B?TmlrUk9ieG9xTnQyd0N0SmpJYjNvMGJxWitKSEdhejhQZThwMkdKNWFCUFp1?=
 =?utf-8?B?OVpHb0pkNzcrYllhRGVFdVhLU2JZOXI4aHBMSDY5cUE0RUEzVHZQRjFRYU5V?=
 =?utf-8?B?UWRrcXlib2tGTnRwR0lwSG10eGhobkIwNGEzVEhxeGZ2cVBqVlhCRkVXaHRV?=
 =?utf-8?B?RDRseDBqZUJCTUY0WTVXcEJ4bFd0RXdCU1lzalY5NEl0THBiUUIwZTJCQUE5?=
 =?utf-8?B?cEJ1RTR5Z1BTMGpvVjZXaGVGVUVvRUdDSUQxWGFTUHRxQXZvdlV3RnQ4RG1T?=
 =?utf-8?B?RVV3cHF6a2NuMjdDalIvK1k4T3oxVGVVTFRvTDRlN2dhV1ZkSEcxczVYYzgx?=
 =?utf-8?B?YkZhNzVBblZxYXFtYytCYUNsazJ5a1RjbkhEZ3A2VlphdmF1aVM3V21MdWlO?=
 =?utf-8?B?eDhmUERSSTdTODNoRnRwd3B3emZIRmd4MTJsQ2hIZWRoMFh5czlNc3lnUzR1?=
 =?utf-8?B?ZFYwWXdEUDVvUG1MTE1zYlJ2Mk52YWhRcUFvU2prNnB0aThSTTVaL3VMaVNs?=
 =?utf-8?B?Uy80WEZKMHU0dVJLT3VqQ290VjR5QXZzSWtJUittUG5nVW9TZkE2b05mUlcz?=
 =?utf-8?B?bEh1bzJIclBMb2I4UjBhYjkxT3QrZmdrdlZjSDRxSHZ1bW1CSk11Q3kxQ1lu?=
 =?utf-8?B?OGxENW9QbERkWHA0NGpZSlhXUTlzemRjRituSHJBeC9seUdNaFg3YnN3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Vy9SekpxZGV0ak1oT0ZPWTJ0MllDbnFxVSs1MmExcWNkSmRhZzVzU241MThs?=
 =?utf-8?B?bHVKWXNhSFZtam5rT3RFTlJ2b3cyc3BRNUNjWHpqcW42ZFRRcVNlVWZjSWdO?=
 =?utf-8?B?NlBRRW5vNXdyam9YRk1MVWJISXNoTkRzREFQUy9DUjB2blNNVEZNbkVXZ3hs?=
 =?utf-8?B?aitJUEZKNzhLN2FaOXE0TmE4RCtTY1VGSjVNTlB3b25UelBDVlFMYllmZ3Zt?=
 =?utf-8?B?NlYxODl4eFgwWXc2bEVSNWt4dzExVDBONzRnSXphMDN2UmxCRHRtazNLbitK?=
 =?utf-8?B?ejZxMGtDOTl3U1dpRmR5VGFza1dlNGNRYU9EQ2RqTGdGcWcxZUZNN1I1bFpq?=
 =?utf-8?B?YkdYbFdzcSs1VGUzNGliL0cvTDd5R3VLb1FzRTg1NnhnZEZrNkxNZUl3S05Q?=
 =?utf-8?B?YlhzcHQrQmhaYTcxS096NUdwVGNGbk8ySEF6TDk3L0RuWDFPZVdpcmhGRHJB?=
 =?utf-8?B?NlJZU2sxZmxQbmJ0bDdJYXordzZyb29kR0JWUjUrLzRpWmVLQk9ZTUNNcjNq?=
 =?utf-8?B?Qk16Q0ZoSEd3Rmt2dnlOS00vODZ6K0ZuY1VkMEo4UlluaXYraStLRVI2ckN0?=
 =?utf-8?B?d2txNHY5dEpyUStGMTFKY3lUSk5VZWJyakNrZ2FDYUkvQWh1dCtVWTZxc1hn?=
 =?utf-8?B?VEJ4VUxZVFFDVWxhN1ZXbHNyVko0NTJiN1ZkV3VSMGw3Q3N1NzhVZGJsV3Zs?=
 =?utf-8?B?dHRkZ3gyMWVXY1Q4Y1RYc3prbFVqK3BYTXVSaHpveER6YUtMRU4xaitqQVpa?=
 =?utf-8?B?MVFhTkhrQ21FaTZMYnI1djlVV1M4amtJZndjMUhLdDBHcVloUFhhTHVSTGtD?=
 =?utf-8?B?WGFiek9KY2ZRL0ppb0cySnBPTHczTS9QR0hzejdmeXZlWWVhSzJtQWdvUkdP?=
 =?utf-8?B?TVlXNlNYWS85d1dBZ0VLWlNxT0Q3emE0S0RFcDNFeXJFZnd1WVVOelVHK2Fs?=
 =?utf-8?B?Nmwvdm80NkNKRlk1K3FrVUJoZFlwaUN6S3NZeFBwdmdYZ3RvN2lYblRVdUM2?=
 =?utf-8?B?Sk9mZ0c3blJaVytjUjdsTHl0YlAzQ29JMmkwazFiWjdqL3JtSWh3VHNzb1V5?=
 =?utf-8?B?V05aVHNBcFp3WXlBakNqYWtOWnhUSmxpam1YSU1kVjFRMlFjZGdQRURYODNO?=
 =?utf-8?B?SHRXeUU5bVI3bkhiQ1Q5eFlvOCsydUMya3FJRkJwckNEeG5TdmVUdnhXSkdF?=
 =?utf-8?B?NUI0eE0zN2hJemRFSzNBQnB1VmZjVmM5MDR0UE9OVlMxOFZIS2M5MjlhbEVZ?=
 =?utf-8?B?RlhUZWRCbVU3MWthYUM5UTJ6V0ZyS09vclpGU0ttMGJGd2thZW8vSVBLMDRO?=
 =?utf-8?B?RFprU05GdUJVZGVMdlF1KzBic1FhbVF3R3BBYjQyRlBPM1FsakJ2cm5Gd25N?=
 =?utf-8?B?WFEvMVpBOE5LVUVObzJFZ2VaZVdjMzZKTTZRTm1mMW1TMVA3M01rcENnQ3hK?=
 =?utf-8?B?eWlTWWp4dXlkTGxGbEVZNmlPZHBRS2YrMDZzV3E5V3BMMGNWb3RiOW5tNVI1?=
 =?utf-8?B?UUI2Z2NPNmNlSUdLZ3JKeHIzMUlieHlPeWJvRlFSVk14OVRnRDVGSzJ5QU9G?=
 =?utf-8?B?aVFKZlMxMGd1aGZNcjJNUzJZTFNhU2dHV0E5UXMwWXk1c2wwdzIrQXJMWlVD?=
 =?utf-8?B?cURmL2NCU2FPTTd5WXE5MWpTSWk0OUxJbUc4MFdKWGN5YlFBLzFhbEZCb2xN?=
 =?utf-8?B?K3F2OEFmWkZQTmQrcC9JMi8xMEZscVlJRW9zZkNzeVU2dW5lc3dPVnk4WEhD?=
 =?utf-8?B?bmdJWHIzMlRsR0NLU1BUTDVoZ2pWZWY2bDh0aTltdVpuTGRiRk1FNTJWMHZt?=
 =?utf-8?B?QytJT3Y2TzR3VXNYZHo1dURTWllqMlEzRndTa3FPM2JRUTZvV05NOFVmcXkx?=
 =?utf-8?B?TEpoSmlwVWF0OGwzSVJka3lXTVlKdk5WVXFtaGVKMm1obVc3WkVOUkFWYW15?=
 =?utf-8?B?OWszTTB6SDY2bXVSK2lscFpwazlGaTlIV2V6eWlCSGlKYzcrYUQxaUFBdDVi?=
 =?utf-8?B?Tml4V0RHUkErZXhFR2dBQ2RucGt5dVVJWDRSQjNPRTJ1UWlGb3NndVhGZUVH?=
 =?utf-8?B?NXBsdHBYbCs2d3J4bS9mR0JaTjgzQ0JqUmQwTjEwV1MxdERQQkJ4U0YyNFZr?=
 =?utf-8?B?UkhTdHAxbXhDdEk0Tyt6RTA0djRmTGxWYnlQTWU1bXh0ZTF6a2E3NmFzTHJJ?=
 =?utf-8?B?QkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c870ad-5c12-4ad7-c2fd-08dc7e49b6b2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 12:37:04.3315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N2FxazL19/7oJnoGdlBDMnkXlEegz8LKXcxYLD+1ldZV2JdjiXKi783sE1Tn2Ia3PuQddWcNXq55dJHdgvhhHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7262
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 May 2024 12:37:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15957

From: Jan Kiszka <jan.kiszka@siemens.com>

Less code, easier to maintain with kernel versions coming and going.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/distro/cip-core-bookworm.conf | 4 ----
 conf/distro/cip-core-bullseye.conf | 4 ----
 conf/distro/cip-core-buster.conf   | 4 ----
 conf/distro/cip-core-common.inc    | 6 ++++++
 conf/distro/cip-core-sid.conf      | 4 ----
 kas/opt/4.19.yml                   | 4 ----
 kas/opt/4.4.yml                    | 4 ----
 kas/opt/5.10.yml                   | 4 ----
 kas/opt/6.1.yml                    | 4 ----
 9 files changed, 6 insertions(+), 32 deletions(-)

diff --git a/conf/distro/cip-core-bookworm.conf b/conf/distro/cip-core-bookworm.conf
index 16fce25e..61b3faf9 100644
--- a/conf/distro/cip-core-bookworm.conf
+++ b/conf/distro/cip-core-bookworm.conf
@@ -14,8 +14,4 @@ require cip-core-common.inc
 
 PREFERRED_VERSION_swupdate ?= "2023.12%"
 PREFERRED_VERSION_linux-cip ?= "6.1.%"
-PREFERRED_VERSION_linux-cip-native ?= "6.1.%"
-PREFERRED_VERSION_linux-cip-kbuildtarget ?= "6.1.%"
 PREFERRED_VERSION_linux-cip-rt ?= "6.1.%"
-PREFERRED_VERSION_linux-cip-rt-native ?= "6.1.%"
-PREFERRED_VERSION_linux-cip-rt-kbuildtarget ?= "6.1.%"
diff --git a/conf/distro/cip-core-bullseye.conf b/conf/distro/cip-core-bullseye.conf
index fc8981f9..b5501694 100644
--- a/conf/distro/cip-core-bullseye.conf
+++ b/conf/distro/cip-core-bullseye.conf
@@ -17,8 +17,4 @@ DISTRO_APT_PREFERENCES:append:swupdate = " conf/distro/preferences.swupdate-bull
 
 PREFERRED_VERSION_swupdate ?= "2023.12%"
 PREFERRED_VERSION_linux-cip ?= "5.10.%"
-PREFERRED_VERSION_linux-cip-native ?= "5.10.%"
-PREFERRED_VERSION_linux-cip-kbuildtarget ?= "5.10.%"
 PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
-PREFERRED_VERSION_linux-cip-rt-native ?= "5.10.%"
-PREFERRED_VERSION_linux-cip-rt-kbuildtarget ?= "5.10.%"
diff --git a/conf/distro/cip-core-buster.conf b/conf/distro/cip-core-buster.conf
index e30603fd..63a2dd85 100644
--- a/conf/distro/cip-core-buster.conf
+++ b/conf/distro/cip-core-buster.conf
@@ -14,8 +14,4 @@ require cip-core-common.inc
 
 PREFERRED_VERSION_swupdate ?= "2021.11%"
 PREFERRED_VERSION_linux-cip ?= "4.19.%"
-PREFERRED_VERSION_linux-cip-native ?= "4.19.%"
-PREFERRED_VERSION_linux-cip-kbuildtarget ?= "4.19.%"
 PREFERRED_VERSION_linux-cip-rt ?= "4.19.%"
-PREFERRED_VERSION_linux-cip-rt-native ?= "4.19.%"
-PREFERRED_VERSION_linux-cip-rt-kbuildtarget ?= "4.19.%"
diff --git a/conf/distro/cip-core-common.inc b/conf/distro/cip-core-common.inc
index dfee24a0..4bd4b840 100644
--- a/conf/distro/cip-core-common.inc
+++ b/conf/distro/cip-core-common.inc
@@ -17,3 +17,9 @@ CIP_IMAGE_OPTIONS ?= ""
 
 IMAGER_BUILD_DEPS:append = " dosfstools-native"
 IMAGER_BUILD_DEPS:remove:buster = "dosfstools-native"
+
+PREFERRED_VERSION_linux-cip-native ?= "${PREFERRED_VERSION_linux-cip}"
+PREFERRED_VERSION_linux-cip-kbuildtarget ?= "${PREFERRED_VERSION_linux-cip}"
+
+PREFERRED_VERSION_linux-cip-rt-native ?= "${PREFERRED_VERSION_linux-cip-rt}"
+PREFERRED_VERSION_linux-cip-rt-kbuildtarget ?= "${PREFERRED_VERSION_linux-cip-rt}"
diff --git a/conf/distro/cip-core-sid.conf b/conf/distro/cip-core-sid.conf
index 6d3cf088..eefcbb59 100644
--- a/conf/distro/cip-core-sid.conf
+++ b/conf/distro/cip-core-sid.conf
@@ -17,8 +17,4 @@ ISAR_APT_SNAPSHOT_TIMESTAMP ?= "1707606000"
 ISAR_USE_APT_SNAPSHOT ?= "1"
 
 PREFERRED_VERSION_linux-cip ?= "6.1.%"
-PREFERRED_VERSION_linux-cip-native ?= "6.1.%"
-PREFERRED_VERSION_linux-cip-kbuildtarget ?= "6.1.%"
 PREFERRED_VERSION_linux-cip-rt ?= "6.1.%"
-PREFERRED_VERSION_linux-cip-rt-native ?= "6.1.%"
-PREFERRED_VERSION_linux-cip-rt-kbuildtarget ?= "6.1.%"
diff --git a/kas/opt/4.19.yml b/kas/opt/4.19.yml
index 799b890e..708562b3 100644
--- a/kas/opt/4.19.yml
+++ b/kas/opt/4.19.yml
@@ -15,8 +15,4 @@ header:
 local_conf_header:
   kernel-version: |
     PREFERRED_VERSION_linux-cip = "4.19.%"
-    PREFERRED_VERSION_linux-cip-native = "4.19.%"
-    PREFERRED_VERSION_linux-cip-kbuildtarget = "4.19.%"
     PREFERRED_VERSION_linux-cip-rt = "4.19.%"
-    PREFERRED_VERSION_linux-cip-rt-native = "4.19.%"
-    PREFERRED_VERSION_linux-cip-rt-kbuildtarget = "4.19.%"
diff --git a/kas/opt/4.4.yml b/kas/opt/4.4.yml
index 3b9239c1..db9bbdce 100644
--- a/kas/opt/4.4.yml
+++ b/kas/opt/4.4.yml
@@ -16,8 +16,4 @@ header:
 local_conf_header:
   kernel-version: |
     PREFERRED_VERSION_linux-cip = "4.4.%"
-    PREFERRED_VERSION_linux-cip-native = "4.4.%"
-    PREFERRED_VERSION_linux-cip-kbuildtarget = "4.4.%"
     PREFERRED_VERSION_linux-cip-rt = "4.4.%"
-    PREFERRED_VERSION_linux-cip-rt-native = "4.4.%"
-    PREFERRED_VERSION_linux-cip-rt-kbuildtarget = "4.4.%"
diff --git a/kas/opt/5.10.yml b/kas/opt/5.10.yml
index a9cbe25b..d76d056f 100644
--- a/kas/opt/5.10.yml
+++ b/kas/opt/5.10.yml
@@ -15,8 +15,4 @@ header:
 local_conf_header:
   kernel-version: |
     PREFERRED_VERSION_linux-cip = "5.10.%"
-    PREFERRED_VERSION_linux-cip-native = "5.10.%"
-    PREFERRED_VERSION_linux-cip-kbuildtarget = "5.10.%"
     PREFERRED_VERSION_linux-cip-rt = "5.10.%"
-    PREFERRED_VERSION_linux-cip-rt-native = "5.10.%"
-    PREFERRED_VERSION_linux-cip-rt-kbuildtarget = "5.10.%"
diff --git a/kas/opt/6.1.yml b/kas/opt/6.1.yml
index f140c273..caca83d5 100644
--- a/kas/opt/6.1.yml
+++ b/kas/opt/6.1.yml
@@ -15,8 +15,4 @@ header:
 local_conf_header:
   kernel-version: |
     PREFERRED_VERSION_linux-cip = "6.1.%"
-    PREFERRED_VERSION_linux-cip-native = "6.1.%"
-    PREFERRED_VERSION_linux-cip-kbuildtarget = "6.1.%"
     PREFERRED_VERSION_linux-cip-rt = "6.1.%"
-    PREFERRED_VERSION_linux-cip-rt-native = "6.1.%"
-    PREFERRED_VERSION_linux-cip-rt-kbuildtarget = "6.1.%"
-- 
2.43.0

