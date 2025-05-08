Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8D8C3ABBE
	for <webhook@archiver.kernel.org>; Thu,  8 May 2025 06:09:10 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.50])
 by mx.groups.io with SMTP id smtpd.web10.9090.1746684546179176136
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 May 2025 23:09:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kLjTb9SF;
 spf=pass (domain: siemens.com, ip: 40.107.249.50, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2euaI/CchDd6CAenCUaTEIrqmVssYa1HsXc3+B4gY0rgiz3WNkcSzSClWdROfFFq/y5XLGGFX4EMPVg6J7S/nTMUP4ZO68erL6xg5lSMOuRcd/MZ/cqr6GNXuo15afVsyhAm86RWr0TEYyMImx4QU4lnwxFH8x87+4dv/3Eox6+JGYjvxkVhaiXQ20faY2VYB2395S6fJ0zF907w9dEk6HQAl184U/2rKOMlw2QcCGpM8gSrNgOSDcnyGMDPGL32Tb56c+TtkR8hxgyRohr3zRGcZkxLi6SNN2qb1fsMuUXsUyZkIEk6f8jCuVCG6vugITI6JXbLnB3HPI0t39JDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMplfzs6j1bhSeLUP+dCHxr7sSUYCz9ni31Cj6hq9AA=;
 b=mD1m2fb69Npyi/cALdtJ/droE1YP5V+fDpkk+2BA5/HCvdDhE7x2H2lij/yQrJjeCUvJxbYHmYvuPljiFNGL1uEVRQ4ScXazdFfzYi8MyOpoOTa+104/PWsd/8qLIrFf9fUc6nu8WwGj92TkUWzMX8ULqBh3YaRnLwHAyigL6WeHgVnw+mx+VmWGfrwjA2AGakd1b9k4Dg8Z4WHIdPMd3MApAksnj++m5GV6LdBc+ClLcIu6k0IHkeLF0+uUSyEIEECaII+6V+tMXsEH7e/zYHyJKwHufWCO3pNb2QxatkGxYAHao4L5qMC6+S5DA4Myogxwoox+Hx0UMDR/K0jrZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMplfzs6j1bhSeLUP+dCHxr7sSUYCz9ni31Cj6hq9AA=;
 b=kLjTb9SFCVOmRD+0Wjii5B8WhxQQL2H26LkPEAUD7HcQoMBem+iiMN6iURVfxj2vS3DvEtFbSmfB+ju2fPf7ap/0VNc45J7KZLEKFjiM5NxRSCxZ8vxIXLM7VwwpDRCSkqHrSy840CwwZ6a5ivXJTNqHji1NN0OZtEO6f3R33QiOZ1DHM9QBbwbLZNMD/sJ/2xWHl8TwIzcnvX7k5LLD9RZ6WpNHFB8w9bPEute5bA6jxuPn1nYnWEXOieR2zX/Y2kiYIQIAtXnTi3PDW6iBH/IhCik3fu2UMh4L3yZSACyNdiKyB1cmFzWfndS1L7hk3VNwsopCC9/tU88XNZqmgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8082.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:114::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 8 May
 2025 06:09:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8699.026; Thu, 8 May 2025
 06:09:02 +0000
Message-ID: <f172f6ad-7262-4a30-a1a1-eb32d3c165fc@siemens.com>
Date: Thu, 8 May 2025 08:08:55 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8082:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b48ba3e-b9a4-4932-2d50-08dd8df6d42b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Vm5za0hyL2FLYWpMWlhMOFdubE9FMldNakVrL0xDcXQ5UERpWXVuNkhkaTUv?=
 =?utf-8?B?QXkybTZHUDJRUHdsUXM3U3pwRkM3UHlGZnM2NlFIQjM2U2s2TlQ0K0dQRTdF?=
 =?utf-8?B?VjQ3T2FpZGFIWDkyQmFMeDdOVk9IaVFOb2JTdmtJTFlPNURoR2NkbzhQNUxU?=
 =?utf-8?B?dUpiZm1vTFVybHQxZU9CeGNsN3o4WitRYmJUa1p6dDI1VFBkZXdoUHYvQlM4?=
 =?utf-8?B?Rjh1TTJvR3drRVkzWWUyc2lHdnQxZDJxRFhxbStJYXlTOUFvTkZOSk8zNjc0?=
 =?utf-8?B?YzV2NnU5MUhBYWpYc2ZLRFBqcnFjdHMybkdnSng5WTlhbXJ5Y2Q1cTBPMGpP?=
 =?utf-8?B?Q09nQnoxSFJGS1VzRFZkSWlBQ3JsNVZ1QW9HYzlZbGswRDZSNDVrc0hqbFkv?=
 =?utf-8?B?aTU1VXhMQzNIZDNWaHB6VHU1YzE3a1N6SmhCZ0JFY3dWL2dVSzlEUlNZUmtE?=
 =?utf-8?B?TXhNRk9SL2NERElSV3hyY1ZFWnY3WG0yMHpVYUd4MzJhQ2NyaWIxWGF0cW9j?=
 =?utf-8?B?MnhKTTFWSE9UdmZZQUwwUElUOGdzVkZZVTI2bi9DWk5IcUVqL3dtRCtoL1Ir?=
 =?utf-8?B?dTl5eVNpUyt1L2prYVJDcWtOL1hxcUxkRjNkM3JkMmFuVzdwekIwZG1LQ1dU?=
 =?utf-8?B?RUVSOHRUakZ6TmcyeGVNQVpGZkVESmFTYnN2NzNSVHMvQVplVVYydjBvREhQ?=
 =?utf-8?B?blc3ZXptOWFac1NBTEptaWFUZTFOcEdaUFdSNENPWFhwZi91b0pBMGppTGxo?=
 =?utf-8?B?OVdlNElhblBzcm03b0s4VUFrVDljVEFDZkxxdGZSeXVTaHdDT0JUeS95Tnlr?=
 =?utf-8?B?eitIUncvL2JvZkZtdHpaZ3BZeDBkWWpINjlqTHlIc0lWdmhCb1RreHM4ak5z?=
 =?utf-8?B?S2hucGtFRWIyOGE4YjNETkFDbGdOazNpMTZuVkpvWWtHdVBIWHZOcVNyd0lz?=
 =?utf-8?B?T0lmYTg2ckJRUFRsczljUUdkKzJ2VkF1OVQraVJGYklUa1kzWVNZcW9aTDVX?=
 =?utf-8?B?dHRlMzJNYVhseW8yVzM2SGxuSTFEd1NMWmYwa0dFQ2ZtUHRpOFBrZE1YOUJu?=
 =?utf-8?B?Y3VZSHNZU2xEWjBtV3lwS0JoeUI0Z2kydnJORzhvcXQvaGEySGFab2NiS29h?=
 =?utf-8?B?d3l0TitPOEJ1OUtzbDdidk1CRXJtcFQzeW8zV0MvSm90dENyc3hSc3JaeFpx?=
 =?utf-8?B?eFM4Vyt5aHdtMU5vVWN6ZXdlRUc0blpWRmNlREg1TUl6dVlyQVNtOXVQRlh4?=
 =?utf-8?B?eUVybnBUMVRjQzlDOUpHSVcvem45N2dOcURkWEt0cTBMeUxKMkMrSVRQV0JN?=
 =?utf-8?B?ZElWODhxMVcvMUY1UU02Ujc0MUxSYUw3dk9LMWI4N3Z0SEhKS3pwRUh6NG5H?=
 =?utf-8?B?VVlxUlcxOEJpQ1pyWmM0cnUrV1lzbkhYMlp6YmJ5T2R4QWQ3TFRCVHQ5b0tt?=
 =?utf-8?B?dlFUcTdPWUlMSjJKUjVJd01uVHdiTi96dXlwVHgxS09iZEdqYktHZTVZUTVv?=
 =?utf-8?B?YUtmMWtHUlZLTzlqdUJpN0k1cFBsSnFScGI3Tk5yM2FwSFUrVS9KU3pLTFpF?=
 =?utf-8?B?ZjQ5dVFkcG9MdWRuWnFjUkVMNjQ1cElaRS9jT0ZrR3dtRWdLczArVVltdloz?=
 =?utf-8?B?b1NFS0VUOUsxZUpZclV5WkltUW9reE5JbFNxMTRYbVhLSVFHMUJVQjJ6MjdO?=
 =?utf-8?B?RUwzZ2pKejB3TktwaXAyb2pHbHRvM1lRTkh0b0VRZ3pqT1Rsd3ZaNkpZdGF2?=
 =?utf-8?B?SGdVeGQ5M2RXdEwwY3NkLzF4dDZWTUdOVndPLy9qOFFxWFF5bGw5dmFuWGpp?=
 =?utf-8?Q?7rPPbwo+DahdoLNhsdvMDLAI2GvuXrtoFCwqM=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dDFnaDl0T0VHRThtelBFTWYxVCtTQ0hxMXlQUkNlaG9zcHI0K2dmbXo2blBO?=
 =?utf-8?B?VzZhcjBtRFQxYlhLWEtiZkFsWTNMUjd3VEJzaVh0YVcvNXdrQXdOcGcyQmZ5?=
 =?utf-8?B?Snc3SlNkdFFVdDNGTFV2d1lpNzlpNWFXWEdOUkJyckN5bms3c1lVakNJLytv?=
 =?utf-8?B?ZGtmRk4vTWFsM2RvOE55SFZjWEs0Wms5TzhuejdFOFVZd1k5U3N3Vk1Ya0Rw?=
 =?utf-8?B?akx4M043WnFBMzZtN3dMMUJGUFRxL2kyTVlnSVBiYlB2b25tYlhFbzc4N29G?=
 =?utf-8?B?VEkrZGRXZUliT1p4b1hDVWhaL283MFhZYkJ0NmVqdlM5TFBUSUxIRDZISmw4?=
 =?utf-8?B?MTVYZWFTYUU1U0U4TElQNmN6VWxSZEZ4cnJuNkhSZ2dsTHZ0eFU3Z1YyYVI2?=
 =?utf-8?B?cExCTXlhMnNnM1ZxeGQ4Yjdad3QrbDEya3U5MVRsVXNJMHRuUk9RK0xweXIx?=
 =?utf-8?B?QzQwOXQ5bjA1cVhSdWhVTWcxRWpqYVlGb3hYOTFabTVrUVNVYld0YkFkbUhq?=
 =?utf-8?B?K2hFbDc5WmdGNExBV0szdTVSN3pKNzM1UDBzdjdPVyt2bVZscUR2OXJaeVdU?=
 =?utf-8?B?anYrdFZTL3p4QVcxaTVaNDJiRkhvbHZxNDgxZ0pDMU92YTJjQ3dqbkd6aGlm?=
 =?utf-8?B?dDBLeGdVeGdZZXAvMjZNQnUweXB4b1gwdnRqZ1hjcjhHU3RXZDE1aHdlcFBj?=
 =?utf-8?B?MFo2cVZIOEl1Qk9taWQ2RGhIdFU5RXU3Y2wwa0JKVDk5UFRtUEhXcE5wazQz?=
 =?utf-8?B?Tkp2MHovYTBvbTN5WnhFQVNwd0thN3MveTB6ZVhXbGVOeVloNlQwZW1nd0Fh?=
 =?utf-8?B?Z1gxK0RIWFljKzJtU1Y5cmVibjRnTnpmaW4xdmxYYngvNFFHK04ySlZwVFJF?=
 =?utf-8?B?cklMdUtXOWV0eWZPamptbXJqNjFkR2VIZG9iVHRzRzZGb2lHQlVwc2Y2NnZj?=
 =?utf-8?B?YW4zTXRUdDBVQysxdFp0YkZ5MEpIRU9XMzBXZkk0SlpycmM5SnJsOExNUzRG?=
 =?utf-8?B?WEQ0bXVWcFlIcC9vRzdQS1N5QUo2ck1ERS9ja3l2Ym9LamVkR2syTzhBMnU2?=
 =?utf-8?B?dTlEZVNjVTlEYU9mTUZUQUFjeEtqcnI2ejJvVnc1cDRnUXNuZGVIVkdveXlu?=
 =?utf-8?B?TkdMc2RMaUxIZEFhcmZoS3hJU3dZNnZkTEdwRmxpTXBtbU9UUGRPN0pJMjJt?=
 =?utf-8?B?ODluSGNHMzcyTDVVUk5KTFZlcWJaQnQ2R0VmTjVkb3g2OWJ0OUVoM3JUS1gy?=
 =?utf-8?B?ZkZBbXNyUElQa1RjaUQvU0FVL3dZVnFxRFdld3lVWWdzcTJaVkk3TXFUelhG?=
 =?utf-8?B?YklvUHRPajRGNDdwckVjR3c2WGhNTklUOWRoZ2htN2dJRTRML3Z5MStxbUlM?=
 =?utf-8?B?azUreHdQSndLdWs3ZXBZSzRDbTh0ZjU4dkJmODFhTlo5bWlITUdnaS9zYmxa?=
 =?utf-8?B?aUIva1Rnb0oydE5pbmxOSVJRbk9WdXlzVE00d2REckl3b0xxZWNpUUN2Y3lK?=
 =?utf-8?B?TG5mUEpXOHVDdHYvVDBLOVZXMjB4bDN6S3M0NUhTVUwwOXoxakd2WFRCcGg1?=
 =?utf-8?B?dDJWczF4eFFyMlc3b3oraGVGLzRnSHBwODBZcVlDN1pkSEp4V2ZCNDJEdXpn?=
 =?utf-8?B?eW1Ca3VWYXFnYW03ZW5NTXUybmN5N2tvOXpudG5CY1VKTEMyZnJab1VyOWtO?=
 =?utf-8?B?UUZuMmRTNm1ScVlCQXVtaTZTSzNYdFdmRGZaRVdPdXdVaGhQWW5tNlNDSDhX?=
 =?utf-8?B?cDRDZlZDSzY4QUUrNWtIL01YUGp2SkhYc2s4ZGR5WnVvM1VoS2lDck51R0VC?=
 =?utf-8?B?RmJRcHBNK0c1RXY1NEZFUVg2TzZpTkh3RXVWclo1VkpuT2dWWkxUVzljWE5Q?=
 =?utf-8?B?bUFENURWTCtlQjRQR2VRQzFmdm1tQUZXWEcvS1h4bld2TkNzTlRiZWxHSVhU?=
 =?utf-8?B?SlRjSlJMSCtnMVMyUzhtOE1hTUYrdnBtekdkOUgwV0kxU0JaRmZaSjFWdUNB?=
 =?utf-8?B?ZjExL2IyT3ZDOWdGTFdNOXVkbTArNjQzb2YrQmpGM3VmMzg4ZWZWNVRHeDdO?=
 =?utf-8?B?ZnEwdG9xRG9ZbXdqbmYwQTQ4VjM5b2V5aUlMdHNIQ3NzcllCcEd3V200SG1x?=
 =?utf-8?Q?/eiArnmWjwdeVLny/slTAc5EE?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b48ba3e-b9a4-4932-2d50-08dd8df6d42b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 06:09:02.0118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ElsEEs8pYy8nVcONwoTCLcwili0pS0RVm3mAuJ54XAwBxcCJEyJi6AxA2nSvS6UbZsE0zKj/y4CuFbl5m+x+/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8082
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 May 2025 06:09:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18779

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=5&day=8&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/04/cip.2025-04-24-13.01.log.html

* Action items
  - write docs for release scripts [iwamatsu-san]
* Kernel maintenance updates
* Kernel release status [*]
  - state of 6.12.x-cip1
* Kernel testing
* AOB

Jan

[*]
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed Apr 23 09:15:22 AM UTC 2025
  limit date: Fri May 23 09:15:22 AM UTC 2025
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Tue Apr 29 11:30:23 AM UTC 2025
  limit date: Sat Jun 28 11:30:23 AM UTC 2025
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Mon Apr  7 12:49:49 PM UTC 2025
  limit date: Wed May  7 12:49:49 PM UTC 2025
  Status: *Late*
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Wed Mar 19 01:02:44 PM UTC 2025
  limit date: Sun May 18 01:02:44 PM UTC 2025
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Fri Apr 18 04:57:16 AM UTC 2025
  limit date: Sun May 18 04:57:16 AM UTC 2025
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Mon Mar 17 09:54:04 PM UTC 2025
  limit date: Fri May 16 09:54:04 PM UTC 2025
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Fri Apr 18 12:23:18 AM UTC 2025
  limit date: Sat May  3 12:23:18 AM UTC 2025
  Status: *Late*
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Mon May  5 07:36:59 AM UTC 2025
  limit date: Wed Jun  4 07:36:59 AM UTC 2025
  Status: On track

