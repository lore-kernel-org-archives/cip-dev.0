Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C10C5B543
	for <webhook@archiver.kernel.org>; Thu,  5 Jun 2025 05:26:47 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.53])
 by mx.groups.io with SMTP id smtpd.web11.392.1749101204256981573
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Jun 2025 22:26:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dBqztw3Y;
 spf=pass (domain: siemens.com, ip: 52.101.69.53, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdUkfyUpPtuYDgsrYNhLLD6KVJgLhHeJNprEeXTrw7H2eyeiM2i0vATyPuueTjdxheMGx8YlIZoSX2rFqXCmPJkLLmObDtv9XdKtLaTo/AuguBC2QlfSpNwy56fYJvfELkt+wNgy8EwNEDQSr3nf8cih9J6gMvj1h8tICJGssSmTu+kjCvPGlbrUM2HlZN2mJlXrG874xC61gQaAovDtVq5+eYIHY74ikTy2p4gHmM0XG92MpwkpMpTGC7wKuyoD2WEnEvJ/UVQ5+vq/5Zt5eYlAM8cmC1JI0UeN56knBC5WyB8JncJZ7ZnAupjt4XOXeNT7b/nHNpVPJke5xpSxdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8B+ypSY1IgocIooh3tAF0Fd3BXd2VEV3q6MeebolZU=;
 b=WYWLV9d3t1bfPxJiQwDCXpUFWlXcNojOWOS4YYVbJKtnPntxDqGvGRBTpdDSNTB4T7etLSJmq5S6jDZQjKdu2K/eMwxgex21FkTlS8SUuHyxOzzgQqvUpLbHh5b7Cr4fWkOkL1dUvytD5kZ4v/1JlZqcH9c+35CyfY+3nZ8tdxTPKOCGdkRfsXjOPY5NYBYsxLkws16xcFhZJHkbbhn2P4JT/yBcPQyZh7/kWW+nP7WFoSayPQPqpqqN8FEgfqaLCCzAVsrw46r12xFQORkaoq2JdBcgCHnumhrVjsY6YjEqEkaJQbhhvNIViaeIr2bUezbhgwzVkDL1Wnuffh3aeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8B+ypSY1IgocIooh3tAF0Fd3BXd2VEV3q6MeebolZU=;
 b=dBqztw3YPencDPlchS1fRVOkULM/chXXMe3Kr7f128mMx68uTdY9H3NQ/rsH/8X1CX/qZZnCOsNRamDrCKrcrvpghbtkcj9E7RmBb2YouTFMd8TKg8I9RO9AdIp365ZJziP5Bmc8UfJbRjV4ol46xiBBYc08uTuwyGoxD9qKCjf+Pl0g8sBWYGW6T8dGim/1thKFmakucOHdfNe97QdX+Ux2NzhuEZiK8DhkWv7bdXnfSvpN5b8pFXxBLeWE8g24HS5lVZrxrZ6KLiYgVi/fFpB6bFXyK7C1Nf9humQY3bTDDi5bjonehExgEnF/+7hL9au1Q17OIpmyvM05yRPq/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA4PR10MB5756.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Thu, 5 Jun
 2025 05:26:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8813.018; Thu, 5 Jun 2025
 05:26:39 +0000
Message-ID: <6a90e686-fd08-41f5-a21b-cd173456af74@siemens.com>
Date: Thu, 5 Jun 2025 07:26:37 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA4PR10MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: c0dea85c-f2fc-4010-47db-08dda3f18c2c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?L2trNVhNalVxTWw4T002ZjkwbG52NmNRZ3ZKVkQ4R1loaGxWOWp4dGJMMXd4?=
 =?utf-8?B?RnhMUEhGWHpPblpRZURHOCs2TUtUcnZsaGlsTHkybTgxUHdsTTZjNDZQcHQ3?=
 =?utf-8?B?UEc2YUFPaTdMZm52WGJYbkpYK3FBM3JTWVcxZmNtTXNCQUpCYUZvQ2d1WTZ2?=
 =?utf-8?B?b3VIQzI2Zk04azl5OFRIcSt1RGFmQkt4Q0hHS3Z5d3RsaTVreU9KSldQbW9z?=
 =?utf-8?B?azRLUjhsME5OeTdBcEVBOGNJcVJDQ2VGUUxwYU1OajFSUE9VMFRLZ2p0MU1S?=
 =?utf-8?B?aXFQT0lrMEp4emptU1NjbVp0UThWZmk5aUNjOUdPb1VYN3l5V1JlQ1hoZC9U?=
 =?utf-8?B?ZGYyWHVlaFJPckpLeE9aOUR5MTdYcTlrejFYTmF4WWRWWDkzelpyRENyd3NI?=
 =?utf-8?B?YmhBZWR1M24zbE1UTld1MGlSUnVxa2JmZllrTkx6Nlc2d3ltNHljY3U0NGNz?=
 =?utf-8?B?RG9NbVlnR2szWkdLVi9wenZoaTFlQytQQWkrMDl6WlZPZUdJYzVCaFFyK2d3?=
 =?utf-8?B?eGFnUUV1ZnRZUVRFK2prc210Rk1XWFlLamNuNjFWQmlUQ3JrcElYSmN2SnRp?=
 =?utf-8?B?RVVwOEY3eS9sQXpOMG95VkgvRGhadlMwQVlNYityZGhCa3h1ckU3QnlOUjQx?=
 =?utf-8?B?VGl6TUQydW1jcmpUMUt0akExdTZmeCtKU0dxNDFLaUtaNTRjY2VUd3cxK1lM?=
 =?utf-8?B?YXA2ZUxOeE9wV1cyam9FRVBDb2w2MlZRYnN4SFNBalNWWUNQdkFpaU1mWFIy?=
 =?utf-8?B?QW9mcGdRMFpFQStpcGJNVHVxSWMrSkhTTlVhZ0R6RTFPaHpNMi9YNG93ckNV?=
 =?utf-8?B?WHU3MUYzc3ZCS21MS2ZOT0ZuY09GaFBtUXRYOXk0TGZOMXFzaTFpVHFGSERI?=
 =?utf-8?B?N1FLVnA1c0pXTWtFU29VUjRDcXI1YS95cXc4Tis2dXlsNUVjcldhL213V3k3?=
 =?utf-8?B?Mk13NUtNY1hxM2VKNXRNenl4aHQzWk8zTmMwRnJRVXFqNmYyTkk3a2Z1THh2?=
 =?utf-8?B?M0Z5YmZHMFc3RnB3YWt0NGVmRDl5ZlJZU0tRNEdBeGRObEtNekZuNmVEazMy?=
 =?utf-8?B?N0QvWU41WW1ZOW9pZ1NXdmVwY0pzNHZTTWQ4TW5uQWhqRVFlOFQwSXlsRUh2?=
 =?utf-8?B?UEJxb3hmMmlINmxVd2NvTkVoNWppbVZDWU5kOVh1eDBSc2VVcWkrRDQwaE9H?=
 =?utf-8?B?eUExUHJhbHdBeUYyL2hrM1pnSDR3bFBra0RudGl5U2pwRU9rcHBOOXAxVXNB?=
 =?utf-8?B?enFlczArbURpbG1wU0NyR2w0d0htOFIvVWhhNS8zQWJqUnV1Y2MraUhpTDVS?=
 =?utf-8?B?SHR4bldlSTVwRFlCR3lLWnVNd3U4WGJVOEpCZ1lwNkFZOEd3MnhEOEJUenlx?=
 =?utf-8?B?T1krbVBLQ3VYTUIwUlNndVdwcnlINWpvQk1kVS9VZkQvbnREbHFCTW9kUVFx?=
 =?utf-8?B?bzVaQTJWdTY1QksyS0wzYzB4TzhzdUI3YkJ2U09naW5Sa0dNSlUrb3YrVnFr?=
 =?utf-8?B?clJpOHg5QWMwajB5MHFyU1krbytXbC9KeWZORWhnSGFoSlF1djRhMmJaWnlt?=
 =?utf-8?B?Tlo1eFZCUEoxMUlFR3VScTBQTjVHRWttWHJXNm9sRGk3WmE5Sy82TmVjOHB2?=
 =?utf-8?B?QjFFL1ljS21Zem5zcm1hTTkzK2N6c1Y5bXNkM2NIVUhDQ01OWThXNmNVdlo4?=
 =?utf-8?B?NEtlTFN1VXdsOEpDdGpJeGw3czZEYXJoNUFEdGh1WDJaNGlWdlZrTTN3dkhq?=
 =?utf-8?B?SUhBeVJYU1BEYnBDRDIxdDJobHFMeExTNXlUeWhjWHAxT2RVcWZDR2N0K0dk?=
 =?utf-8?Q?Vt+NuO3CA03fy6fCn6Ua/T2sF+MHhAxvgEg7w=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eEtjY1ZUbDNlTk9BVWVMbTJyUzk3bnZGdlR0dEdLOCt1SU0yUy9aRi9hWWU0?=
 =?utf-8?B?Vlp4eUdhSTNablR1bDMwY25GOWFWZ091Ri9kM0JmajV5clBMMDNnYnhZNWJY?=
 =?utf-8?B?M3hEbGpOOFp3VEtGTnlNWG5kK05DRTEyZndoNXRUWWpVQTF6amhSQ1dsbXRn?=
 =?utf-8?B?ejdXRW1IYnpCeDY4c3l1YXNScDY2alZBeXExVmIxQmFpRTR0NDg4YWI2VFo1?=
 =?utf-8?B?M2FEbzR4SW5sRms1M2NpOTAyZFJqTUN0aU9YaHpPUFpGZ1ppMUdKY3VGOWhU?=
 =?utf-8?B?TERiTXkrK05ZWkNOR2NGMzF0V3lidFNFSmV0NjFLczAyN1Y2VUZ6MkV2cW9B?=
 =?utf-8?B?SVZLL1Vpc0lxU3FtNStreHhaZm9scVd6eng0WGVINHhtTmg1NURqMW1seFRl?=
 =?utf-8?B?dHd6dDZNVU1Zbkk2KzRvRkk2SzBRdXpGa1lXTFZ6K1c1RkhVZllGNko1bXJH?=
 =?utf-8?B?Nk9XOHdlZkxCNG92VnVsckpTQzE0WmwwdDl0c2JlWFZrQnBjSTdrbVlZSVl3?=
 =?utf-8?B?S0ZwdEV0WTVLZ2dKNk12ckFjNk5sUm1oUmo4b2VVYlpGOHZ2VnRqelp6OHdJ?=
 =?utf-8?B?dXZzOHdBbnFEQnltSWtrYllZRXZ1bjBlUnFOQ0V0bUZGQk1taDMxM1crU3Rj?=
 =?utf-8?B?Yno2TE95SDVDUEtHRy9KdHY2Zlg5WjJMd2k0QXZnekVjUENEZVlNTGhmSFdv?=
 =?utf-8?B?TVcxNEMyQ0pNT1ZzL0xZZ3NWcmVMQUxMVjJSUnk1K0UrL1NaUk9kbVdubEsr?=
 =?utf-8?B?N2NqVzJhbTNzZEZ3Z2lhN1dLci9lTytRWVNjVmpNcWI4SmlWVno5OXg3Ukk1?=
 =?utf-8?B?TjJWNTRPWmU4VlRUenU4aWNxa2hlQUt3YjkvYjc3TTdJSVIwNG5WbGdpT2NU?=
 =?utf-8?B?Y2l0eStnclh0dCtUMFVRV1FxenhpeG44YVhRcDhtYmpFT1pJKyszSHZXdE1R?=
 =?utf-8?B?MWV0TUVQeEhPOEd2UWhETGlyWVZ3UnRraTlQWVhFOHBKVnhDV0luMXUxQVJy?=
 =?utf-8?B?UHJlci85MndBbGpWRDF2ZlU3THozUFNqc1k1V09McEZ1NFhBa21QeHN1aXI5?=
 =?utf-8?B?MnRRekY5ZUFRVXlPTWR5Q3ZkWEpnb25PSStyTlRieW1XYnYvS08yUjB2bU8y?=
 =?utf-8?B?bzFobWhoYXJFdFZtOFd6L0NnYTh6ZHRXUWt4U0l1ajNGK3QzenBSNHgraU03?=
 =?utf-8?B?L1JsM1M0QXJGc0t2ZGhoZktsSkVucUNGRmtMeXVMRlo3dGRlUHBWTTdVb3FQ?=
 =?utf-8?B?eUZJVHQyeUJXYUp2SkNVcldtM2NmbUVJZG5jbmlpby9KVmZYRHNGRlJJU2xy?=
 =?utf-8?B?SnZZV1BOM2N2VnJRSlRFZFV2cFZOMkE1M3dMQjJ5cXBicWFMeTBWeU5iYU4z?=
 =?utf-8?B?amxXZ0NEK2xRbXNiUFRoVldZK2tuSFJVR3RtRHdOelpTNXRHa1dIaERwWDlO?=
 =?utf-8?B?QmVOajV0TE1LY05iR3VRR3VBNmVPdzcybzQxd2lSTGo5ZzIzSDB5cmRHVWk4?=
 =?utf-8?B?Q0F4dks1eW9XT3BjM3l5UjdxV1V5Wlk0MHp0eVRmWXdqTmxiRzNLdjNxMmw0?=
 =?utf-8?B?dHAreGt2dzlvNzBLUFhJT1lPa20xeHNYUWw4alBrTUJlUytBSURSYW1TK2Ux?=
 =?utf-8?B?cGExbFRHOEFoUkhyMm9ucWNyRGRqbFZ2TkwxcTVpZ0ovZi8vd0xOamxBVEJW?=
 =?utf-8?B?VUVLb2VNL0M5L1JNdGpjV1UyaldJY0NUVlUxeDR0QzBVbTZiYWxwcW5tVEVX?=
 =?utf-8?B?ZXg4T0Z2OERxbkUxRk1ESzFkUy9WMWNwRjRoQ1p1Nlk1eUdqRE9Xalc5Vk9F?=
 =?utf-8?B?K250SE10QlRSdkpVY2JiRDhsUW92YjVDbGozWm1PeHZVNjN0RG9lUytxdTJR?=
 =?utf-8?B?QS95aUUxKzFFWndFTjlXTFc2K29TbUZTK0xiOG9lMzAxam03MURXK1N4TlFl?=
 =?utf-8?B?L3QyZUNnNnZuRDNiQytNSUlucWpOVWFSMDBubWdzb0cvNG9VWTJlNmdpTCtX?=
 =?utf-8?B?OXZUSmFDVjBpVGZMenlnVWFWblBBSCtPb2lIeUF2QlVRVzM5bW5qUmhsZUhY?=
 =?utf-8?B?eXRocmdDUm11elo1UFh0SHA5WFVMVnljS1M0eGt3dUZrN1JIK3B5NTZGMkwv?=
 =?utf-8?B?TEp4REJtb3R0OGJTOHNsbVhjRHl3RnpGK3RST2dXa1BEUE9VL1preWFKajNy?=
 =?utf-8?B?ZXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0dea85c-f2fc-4010-47db-08dda3f18c2c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 05:26:39.1985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l1B/SHH9jKD89QqqaknYVseshHifvU2Plq+NQLw60GK8ozZOAeBh2u3NlR0RrTdfr2RN/675zoyFqaiKW7R1Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5756
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Jun 2025 05:26:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19019

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=6&day=5&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/logs/%23cip/%23cip.2025-05-29.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
  - ppc32 vs. CIP SLTS

Jan

[*]
Date the data is created: Thu Jun  5 05:26:00 AM UTC 2025
linux-4.4.y-cip: interval 30 day
  latest version release date: Thu May 15 09:59:23 AM UTC 2025
  limit date: Sat Jun 14 09:59:23 AM UTC 2025
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Tue Apr 29 11:30:23 AM UTC 2025
  limit date: Sat Jun 28 11:30:23 AM UTC 2025
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Thu May  8 10:15:18 AM UTC 2025
  limit date: Sat Jun  7 10:15:18 AM UTC 2025
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Wed May 21 07:22:16 PM UTC 2025
  limit date: Sun Jul 20 07:22:16 PM UTC 2025
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Wed May 14 09:48:14 PM UTC 2025
  limit date: Fri Jun 13 09:48:14 PM UTC 2025
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Thu May 15 12:41:24 PM UTC 2025
  limit date: Mon Jul 14 12:41:24 PM UTC 2025
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Thu May  8 10:21:06 AM UTC 2025
  limit date: Sat Jun  7 10:21:06 AM UTC 2025
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Mon May  5 07:36:59 AM UTC 2025
  limit date: Fri Jul  4 07:36:59 AM UTC 2025
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Thu Jun  5 02:14:36 AM UTC 2025
  limit date: Fri Jun 20 02:14:36 AM UTC 2025
  Status: On track

