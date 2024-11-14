Return-Path: <christoph.steiger@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084CFD65C62
	for <webhook@archiver.kernel.org>; Thu, 14 Nov 2024 09:17:18 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.68])
 by mx.groups.io with SMTP id smtpd.web11.33238.1731575834441195055
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Nov 2024 01:17:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=z2bzIU5+;
 spf=pass (domain: siemens.com, ip: 40.107.247.68, mailfrom: christoph.steiger@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZyZncnrDYLGALeYkU6TJLuoSbaVlBeP5U+FXe9HCOTbN5/LoM8+C/O/8iObNRAxjfAf5O5Kr1kWj1NWyYGZ+8hrCewunR/pGMSVF6fYXhAnkB+RAR1EILzmY0esvWHBz5bEMqX3I1XAp97NVSwQDw79P6YHbbBWvi38eSZH7qNCnB+0EosQStM8+kA/Tj8gPraK9kjqBRn1vjJl4QOk3LrIKhELShHNzAsuHMPrtu274tMSPQSKTyhuoc9TeA6OD6BSpATao3VEA0lbA5cq2cPd2RwBTU4VjRekMt1HUgSvgSn3DnKTWoFRNtzSvI8dB6xx7oWmPgkmpH953TSNUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKm5GZQ3nhGJh9kGDVtPbLcF6lZ6hgh2QvMv1cO/4Fo=;
 b=CDxaYhL0AZ4dLvwNqF0ZykgYy6NDiyzMmpe66vvVbIRJgAYdHsQBqU9SYGdTxoODChEPSMer3IPf7AHlITiNW47mUzrk+Hg4BAssdGmhJyaWWnhblB6yDAIVtfZMdKKTe0+PjKCUfDoxR4mbBk9l1z7/oARlJxaaIv0O/pmJ7xAce7xBg5wLO2PgK+psYkhcDLaui5Z+p1s0AqtcJgQhoUgmujl3S+n+iJlOODEm64iMiXQT/Pzz9J6xkE1LzHJm8DjTmnIctBLpMtyc8Wrd5plfvEqyT1NQpOfxOlDDlcN0JAGOw/Htcd56BfKDCTwwq6ooXozkPBeu5CJV1IOpFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKm5GZQ3nhGJh9kGDVtPbLcF6lZ6hgh2QvMv1cO/4Fo=;
 b=z2bzIU5+DJbDbAlAxySV+iIUrJts+4nwo6s3eMgC6OC77nglSrN1EMDok6hryoJcti9hqiLpIzLYq55cga4Bb9njXcoMh5jDCCyByF4YmrH2npfXQALiVf2yGaMEw4yg5nAiimCA86Mi0/1ngErukRg9Cqn1qNlgJATxhMfPN0KJpmQbEDyfqtmTz3DQ/78PpI9S0lInYrucvAM7ZAwbc+EjbYDkI3C0StCqReurygzgOjYZrmEyvhmVzeL43cZhoP9AEwH9dvn4lomYQIwBnjQI7nDpAhWYnM6i+zf/K0HVXjj3u8UgtNpsmj+q72chpV+/2k6C1frZz2XVFvOEzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS8PR10MB7136.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:61c::5)
 by GV1PR10MB8967.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1cb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 09:17:09 +0000
Received: from AS8PR10MB7136.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fb1c:78f4:4286:6306]) by AS8PR10MB7136.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fb1c:78f4:4286:6306%5]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 09:17:09 +0000
Message-ID: <81d9b8cf-6fe5-4a90-8541-5cb620ad9420@siemens.com>
Date: Thu, 14 Nov 2024 10:17:04 +0100
User-Agent: Mozilla Thunderbird
To: cip-dev@lists.cip-project.org
Subject: Weekly CVE triage report
Content-Language: en-US
From: Christoph Steiger <christoph.steiger@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0181.namprd03.prod.outlook.com
 (2603:10b6:610:e4::6) To AS8PR10MB7136.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:61c::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR10MB7136:EE_|GV1PR10MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: d9eb704f-1acf-4a3c-fbfa-08dd048d1d8b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bzBoZGRzMzVlaktXTENyL3kxU0cwRTR0L21XZzlMckJZSUdJWUtza2pHV2NO?=
 =?utf-8?B?aFdySGxIQXBtYzZSazhOcjRxUC9yMVA0UkRXNG1GL1FrMEJ5WktHZDdLMUJH?=
 =?utf-8?B?MlFBcC9aTkVGQjlRUEtPYTg0cVBvY0dGSGlLSTNXOFJoenpNRzhSU2ttcGpu?=
 =?utf-8?B?dHVldktORURmMGpKNVlDNm9RV2RqeFlWdlRlVjNFam0wek5ibVlIU0RUcVZr?=
 =?utf-8?B?S2lBNnpRM21qMFBRNERoOC82UjJYbmlvYTJIblIycEIveS9xOXRaZE44cnlZ?=
 =?utf-8?B?NzN1VG8xdDlTRDliVFQ4aXl1N2o3VjIxWWlNZzFyOFJHZ1hzenRoUG5OaFVN?=
 =?utf-8?B?dzMwUmJuSHhIR2NGQXVBZTEzRjlkNDFKVzY0MWVFeVQxN29NZzl2eGhUcS9V?=
 =?utf-8?B?WStHbFFTcEM1bGNmdXdYUlBDcWwzTXNTZlZqUHdIdC83c3M4SW5PcEVjZ0x2?=
 =?utf-8?B?dzJjRXhmQXZrL1RQN3l4Y1oxTE03b2lxRDdlbDNXYlBiNUZDUVMyOUs0U2l2?=
 =?utf-8?B?My9iSE56dWtxYVNndzBzTUZsbkJ4QjJSeUxocVJ2a1hXQnZzQ0ExTGdEZC9D?=
 =?utf-8?B?RWt0YkdOT3c1L05OZDloc0ljdDI4T254dTE0alMwYTh3MEp0NTk1elU0SytY?=
 =?utf-8?B?elFyZHNPMmg4WjJVU05BQ1ZhZkswcStKSklwck1wbjlkWFVvLzc4QUlHanJr?=
 =?utf-8?B?RHRERWNQVWJFcjlnTTd6RHR0L3BBSVJJTTVGVUtibzFiMkQrN05zVXhjYm42?=
 =?utf-8?B?WjBweTErUXowc3VkRmZCYUw3UzIvQVliUEFmVTNqZ3lVa0ppM2l4ajR5R1Q1?=
 =?utf-8?B?ZmQ3WlJNQjZac2hjZWZPUUhONnNFS1Fhbzk2bzdqcmlGUVA0UVlrUzdjdmY1?=
 =?utf-8?B?Um85RHgyUzlSZi95OW9MYjBEa29YaDFlYXJPRDZ2NU1SajFKTzVCL0lERm1q?=
 =?utf-8?B?TlRSanJMYStpRDFuYmhpYlNZTWVMYTJUMTJQS3ovRExDSW5CY0liUmdyK2tW?=
 =?utf-8?B?b1B3cEpqZWViSyt2WmJrM2Q0VFl6OXgzY0hMcFl4TTJSZmhwN29lWFIxRDVk?=
 =?utf-8?B?UUMvdThnbXRjNlk1U29zbDcyNkxCTGJubml0U1VqYVkwbmJuT2hpczd0a0tl?=
 =?utf-8?B?N21TcUMxTHBFcHBid2hFTVp1bjZQZkx4enhkY093enJ5dDRoWlVXTSszSGtI?=
 =?utf-8?B?anFwRjZYMmluWkVZaGo2a0hDWGs3OXd6eDNKY3BuQVhFWmlMR2JTNkhWMFNs?=
 =?utf-8?B?d09VTDl4YWNVeU1sS3dvZWxXWlM4R0FKeWw1dEhmdy9sQW05bmFHNTFCLzJI?=
 =?utf-8?B?NFc5TkFjaldXR1M5MWxJcWk4Y2YwMmRwSHRNYlY3bVBNTm12clFVRUhRM2h5?=
 =?utf-8?B?emIvMUZKbGlFRk1MdVFDNDlsekJwZDJ5OUgyaStiYTJRdi9wN2c3bjM3MkI2?=
 =?utf-8?B?eENZbnZpb2lOLzZpVXFZemwwbzdKWFl0NGVndmpGVUI1ZU5JZUdQYURpNW0y?=
 =?utf-8?B?bDF4YUlGS1hsT2ZZNWxvTmwxL3pvb25LQk91NjR1RkNUekJKVmVKc0pNZVl2?=
 =?utf-8?B?aVcySjd0NFJ5bWdGbUx2b2Fjcm1Pd0RONWtBUVlzc2RsWWI3UXZaZnlneUdQ?=
 =?utf-8?B?ZHhCVTlxMll0KzY2TFRWY0J1S1NpVFBoemYwWExSSjVCVS93RDd0Ulc2Ym10?=
 =?utf-8?B?RHlHMUxWM3JjdmVQQ2dFL3pzZVJmUEo1bFhmcDY0NE56d0RQMnNpdktIVEJF?=
 =?utf-8?Q?PPbI490eHUZSs2Ko9El/w7qElYWUe1P3fjsx95W?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB7136.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c0pjRVQ0amc0NU42NzRXQWoxRTF5ajNNSlRFT0V5aHllZmZuRzluRFNGTmJV?=
 =?utf-8?B?MVduc1Y2UkgwTy93dHVmZHh2OEhTbmVJaTFSaFhZcDFlZHVFblNFcUtvTC9S?=
 =?utf-8?B?QzVOR0h3RW1hd3UycnRGRDFDQnFaNTBrUTFMVW5qeXpKSk1sd2N2ZmJkUEQx?=
 =?utf-8?B?UzN4RGM0dmVoaXBNZm1BYVZlMCtPRW5VYW9OTHR3eW1PV0J4T1NJTlJkL1Ju?=
 =?utf-8?B?REtJMlFtSlI0aEhXd2swcnE1VnRxNUVienV1NFRLaVV1MENOU3llYjk2WTJ6?=
 =?utf-8?B?OS9qVjBsek9tNVRtVkgycTF3WTdpQ2tld29RcjNBMFU5aDBHelN1R2lmSXYy?=
 =?utf-8?B?NlA4OWJlaTVzOCtHMzhkL21keFNBQURkMEpQbWZ4eEczOWpzemtkK2wzWUdY?=
 =?utf-8?B?c3VHeUt0QUVMQWk2ckhIU3pJUUFpaVdmbHdFSGk1SDcydEtzT0RPQVpoZjk1?=
 =?utf-8?B?ZjdKQkZ1V2RZdVV1V2FQZThlYTY0SXBKN1l0VHpEOW9HTXVDMUxmUmxpcXVk?=
 =?utf-8?B?bXNycFlzaHFKcTVaSjVYUExlcVM0QkIxem4xNXdEenJlV1BpbUV2d2ZiNmI0?=
 =?utf-8?B?MHVJdzZmbjY3R2pFKzlySnBIU1hpUkJkTEJ5UWtCRzF5TmhycHdGOUU2YnI3?=
 =?utf-8?B?K1IxOEx1cmRONHV4WnF1WkZXeE41bmovdCtpRlI0Zk53SjFXN1NJTjhZOTZs?=
 =?utf-8?B?Z2VJbVpTaEZBQ3hLelFoK2hpMkZOeTRPMi8wbG0ybU51UzdQbmlObWxXYmZX?=
 =?utf-8?B?V2d3ejZkenZkTmpZME5NaW0yUEoxU3pTUEZ5ZDNSYjdWMlVVVEgwcDltclBx?=
 =?utf-8?B?R1RLTUlZVTNFRzFzRm1SLzJyUWhZS0NVN1BjM2NrdW56Tys1RTA0RElTQkRo?=
 =?utf-8?B?UGdzc3g2aXpKREZackRvT1RUOVFkOGtHSzBUM29hV01BRFd2Uk56R0N1VXhm?=
 =?utf-8?B?b0NwaXlsZzdQTmFqMndXdktCUUIwQzYvQzJTYlE0WG9tNlJ0MUNUNjlLM0s0?=
 =?utf-8?B?Sm54SHBwcW55VEVQVUNvY3FHY0k1eENOY1VlYmpYdFQxcmIyejlPMkw3MTJE?=
 =?utf-8?B?UWVuQXRTNWtlanRxZ015SXZTcklCaFBKMVhDU3FscGc5NDZGK213VTBHQXVl?=
 =?utf-8?B?dy9OVWhRRGxGdlJRRUJVNHNwSWwxMTVjd09aeDZLOFJ3WlRQRnVEZ2JHWU1q?=
 =?utf-8?B?RnU5dlFJcXhjZThxVXVMOTNzYzRwTW4yaU5IdTRnTmJOQjJ2L3pSNHNvRXJy?=
 =?utf-8?B?bHV4dXZPdzZ2d21NRXd0eDdZRUY3ZWJ0M0RjK3dVeEswL2FyY21XTW53RGxn?=
 =?utf-8?B?ZGJrNi82VGVSMktmdXVZV3J0ak0zazBMaHBGUWZxMmVOa0lkT1h3bDA3MUhG?=
 =?utf-8?B?Sktodzl0akRJbzFTUHNTcHRXZ2dMTFN3M0dWRS9ZRGxSTHlxRUdhRUgyRm9G?=
 =?utf-8?B?TktRanNUbHdqUW83Szc5OXRnY2gzR1NkNW1aOHd2bDJHMWo1V05rcXVKenhn?=
 =?utf-8?B?K05OOFNJRDhTd01Nb2xuekhGb2VWeWFGVzVyZm1kN2FLNm9zZEU2SmpYU1Iy?=
 =?utf-8?B?Sk1pTzBZL2hRRzl4Z0c2OTdORHVRV1hRL3ByS0dYMkpzUG92VzBUUkE2WnJL?=
 =?utf-8?B?WkdWdExxTFZLTjVRZVRvSVVoOVRYVUtyYk0rUHlzSWI5TTE5ajg4NmRsWENG?=
 =?utf-8?B?dFJwMjY3SmYrelk2Q3RvOWpLNHdrVE15K08yMkxqZVBJajFwVW9Yd3N2UFAx?=
 =?utf-8?B?U3ZabVUydk52b1BwT0pBZkhwVmZSMEYwYVYvTUtJYmJ6cmZpc3h2T1BNVC9o?=
 =?utf-8?B?RnYycFFYQWpoMlpwd29NT0NtdWpNcG9jVzhtZ0VMb1ZVSDBjMXJVRVFWL0RU?=
 =?utf-8?B?Q1doTXppNjFuZHFWSUU5c1NwQ09URjR1NHFsWEQ2dmxTbE51aUVSZG1FOFlW?=
 =?utf-8?B?MS9nQ1M0YWkzNzNFZ2h3VmRTa0IvelRITkFrOHJyZU5PV3ptb2hnLzg4ZzQx?=
 =?utf-8?B?K09aOElVRXFLUitGbndZdkVPMGY3OWFIYm5UUk5KbXNIMWg4Qm4zd3Nxc0k4?=
 =?utf-8?B?RDF3WVhkSFIwWWF0VEoxTzFadG50bVFmL2JsSmJJREdYMjJSTmt4N05aUzJS?=
 =?utf-8?B?bTZ2QkQ1V04yaWFiZGVnelhLRC9TR3JOV3B3dGdKVlFLU3FLUCtqZjMzTmJs?=
 =?utf-8?B?Rnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9eb704f-1acf-4a3c-fbfa-08dd048d1d8b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB7136.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 09:17:09.0929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mU3VigN/OTXOlrYlGMpR7b1BKVpZte+1Szv7PAXV+vrnqoGUyhXo6HuU3O1rvu5FOCmeLfVryp3fm781IW2yRaq8XdqqwZEiBcdMXyNfVKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8967
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Nov 2024 09:17:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17252

Hi everyone!

Here are the weekly CVE triage results.
72 out of 182 CVEs need further manual review:

CVE-2022-20158: mm: backing-dev: Take a reference to the bdi in use to 
prevent UAF
affected versions: v4.4.302-cip92 v4.19.323-cip114

CVE-2022-48910: net: ipv6: ensure we call ipv6_mc_down() at most once
affected versions: v4.4.302-cip92

CVE-2023-52530: wifi: mac80211: fix potential key use-after-free
affected versions: v4.4.302-cip92 v4.19.323-cip114

CVE-2023-52913: drm/i915: Fix potential context UAFs
affected versions: v5.10.229-cip54

CVE-2023-52920: bpf: support non-r10 register spill/fill to/from stack 
in precision tracking
affected versions: v4.4.302-cip92 v4.19.323-cip114 v5.10.229-cip54 
v6.1.115-cip31

CVE-2024-26921: inet: inet_defrag: prevent sk release while still in use
affected versions: v4.4.302-cip92 v4.19.323-cip114

CVE-2024-36914: drm/amd/display: Skip on writeback when it's not applicable
affected versions: v4.4.302-cip92 v4.19.323-cip114 v5.10.229-cip54 
v6.1.115-cip31

CVE-2024-40953: KVM: Fix a data race on last_boosted_vcpu in 
kvm_vcpu_on_spin()
affected versions: v4.4.302-cip92

CVE-2024-41016: ocfs2: strict bound check before memcmp in 
ocfs2_xattr_find_entry()
affected versions: v4.4.302-cip92

CVE-2024-42229: crypto: aead,cipher - zeroize key buffer after use
affected versions: v4.4.302-cip92

CVE-2024-43904: drm/amd/display: Add null checks for 'stream' and 
'plane' before dereferencing
affected versions: v6.1.115-cip31

CVE-2024-43911: wifi: mac80211: fix NULL dereference at band check in 
starting tx ba session
affected versions: v4.4.302-cip92 v4.19.323-cip114 v5.10.229-cip54 
v6.1.115-cip31

CVE-2024-44931: gpio: prevent potential speculation leaks in 
gpio_device_get_desc()
affected versions: v4.4.302-cip92

CVE-2024-47670: ocfs2: add bounds checking to ocfs2_xattr_find_entry()
affected versions: v4.4.302-cip92

CVE-2024-47672: wifi: iwlwifi: mvm: don't wait for tx queues if firmware 
is dead
affected versions: v4.4.302-cip92

CVE-2024-47674: mm: avoid leaving partial pfn mappings around in error case
affected versions: v4.4.302-cip92 v4.19.323-cip114

CVE-2024-47679: vfs: fix race between evice_inodes() and find_inode()&iput()
affected versions: v4.4.302-cip92

CVE-2024-47685: netfilter: nf_reject_ipv6: fix nf_reject_ip6_tcphdr_put()
affected versions: v4.4.302-cip92

CVE-2024-47701: ext4: avoid OOB when system.data xattr changes 
underneath the filesystem
affected versions: v4.4.302-cip92

CVE-2024-47713: wifi: mac80211: use two-phase skb reclamation in 
ieee80211_do_stop()
affected versions: v4.4.302-cip92

CVE-2024-47723: jfs: fix out-of-bounds in dbNextAG() and diAlloc()
affected versions: v4.4.302-cip92

CVE-2024-47742: firmware_loader: Block path traversal
affected versions: v4.4.302-cip92

CVE-2024-49851: tpm: Clean up TPM space after command failure
affected versions: v4.19.323-cip114

CVE-2024-49860: ACPI: sysfs: validate return type of _STR method
affected versions: v4.4.302-cip92

CVE-2024-49867: btrfs: wait for fixup workers before stopping cleaner 
kthread during umount
affected versions: v4.4.302-cip92

CVE-2024-49868: btrfs: fix a NULL pointer dereference when failed to 
start a new trasacntion
affected versions: v4.19.323-cip114

CVE-2024-49881: ext4: update orig_path in ext4_find_extent()
affected versions: v4.4.302-cip92

CVE-2024-49882: ext4: fix double brelse() the buffer of the extents path
affected versions: v4.4.302-cip92

CVE-2024-49883: ext4: aovid use-after-free in ext4_ext_insert_extent()
affected versions: v4.4.302-cip92

CVE-2024-49884: ext4: fix slab-use-after-free in ext4_split_extent_at()
affected versions: v4.4.302-cip92

CVE-2024-49896: drm/amd/display: Check stream before comparing them
affected versions: v4.4.302-cip92

CVE-2024-49900: jfs: Fix uninit-value access of new_ea in ea_buffer
affected versions: v4.4.302-cip92

CVE-2024-49902: jfs: check if leafidx greater than num leaves per dmap tree
affected versions: v4.4.302-cip92

CVE-2024-49903: jfs: Fix uaf in dbFreeBits
affected versions: v4.4.302-cip92

CVE-2024-49924: fbdev: pxafb: Fix possible use after free in pxafb_task()
affected versions: v4.4.302-cip92

CVE-2024-49926: rcu-tasks: Fix access non-existent percpu rtpcp variable 
in rcu_tasks_need_gpcb()
affected versions: v4.4.302-cip92 v4.19.323-cip114 v5.10.229-cip54 
v6.1.115-cip31

CVE-2024-49938: wifi: ath9k_htc: Use __skb_set_length() for resetting 
urb before resubmit
affected versions: v4.4.302-cip92

CVE-2024-49948: net: add more sanity checks to qdisc_pkt_len_init()
affected versions: v4.4.302-cip92

CVE-2024-49957: ocfs2: fix null-ptr-deref when journal load failed.
affected versions: v4.4.302-cip92

CVE-2024-49959: jbd2: stop waiting for space when 
jbd2_cleanup_journal_tail() returns error
affected versions: v4.4.302-cip92

CVE-2024-49962: ACPICA: check null return of ACPI_ALLOCATE_ZEROED() in 
acpi_db_convert_to_package()
affected versions: v4.4.302-cip92

CVE-2024-49967: ext4: no need to continue when the number of entries is 1
affected versions: v4.4.302-cip92

CVE-2024-49975: uprobes: fix kernel info leak via "[uprobes]" vma
affected versions: v4.4.302-cip92

CVE-2024-49995: tipc: guard against string buffer overrun
affected versions: v4.4.302-cip92

CVE-2024-49997: net: ethernet: lantiq_etop: fix memory disclosure
affected versions: v4.4.302-cip92

CVE-2024-50006: ext4: fix i_data_sem unlock order in ext4_ind_migrate()
affected versions: v4.4.302-cip92

CVE-2024-50008: wifi: mwifiex: Fix memcpy() field-spanning write warning 
in mwifiex_cmd_802_11_scan_ext()
affected versions: v4.4.302-cip92

CVE-2024-50010: exec: don't WARN for racy path_noexec check
affected versions: v4.4.302-cip92 v4.19.323-cip114

CVE-2024-50012: cpufreq: Avoid a bad reference count on CPU node
affected versions: v6.1.115-cip31

CVE-2024-50024: net: Fix an unsafe loop on the list
affected versions: v4.4.302-cip92

CVE-2024-50033: slip: make slhc_remember() more robust against malicious 
packets
affected versions: v4.19.323-cip114

CVE-2024-50035: ppp: fix ppp_async_encode() illegal access
affected versions: v4.4.302-cip92

CVE-2024-50039: net/sched: accept TCA_STAB only for root qdisc
affected versions: v4.4.302-cip92 v4.19.323-cip114

CVE-2024-50040: igb: Do not bring the device up after non-fatal error
affected versions: v4.4.302-cip92

CVE-2024-50058: serial: protect uart_port_dtr_rts() in uart_shutdown() too
affected versions: v4.19.323-cip114

CVE-2024-50059: ntb: ntb_hw_switchtec: Fix use after free vulnerability 
in switchtec_ntb_remove due to race condition
affected versions: v4.19.323-cip114

CVE-2024-50072: x86/bugs: Use code segment selector for VERW operand
affected versions: v6.1.115-cip31

CVE-2024-50089: unicode: Don't special case ignorable code points
affected versions: v4.4.302-cip92 v4.4.302-cip92 v4.19.323-cip114 
v4.19.323-cip114

CVE-2024-50095: RDMA/mad: Improve handling of timed out WRs of mad agent
affected versions: v4.4.302-cip92 v4.19.323-cip114

CVE-2024-50106: nfsd: fix race between laundromat and free_stateid
affected versions: v4.19.323-cip114 v5.10.229-cip54 v6.1.115-cip31

CVE-2024-50112: x86/lam: Disable ADDRESS_MASKING in most cases
affected versions: v4.4.302-cip92 v4.19.323-cip114 v5.10.229-cip54 
v6.1.115-cip31

CVE-2024-50115: KVM: nSVM: Ignore nCR3[4:0] when loading PDPTEs from memory
affected versions: v4.4.302-cip92 v4.4.302-cip92 v4.19.323-cip114 
v4.19.323-cip114

CVE-2024-50117: drm/amd: Guard against bad data for ATIF ACPI method
affected versions: v4.4.302-cip92 v4.4.302-cip92

CVE-2024-50121: nfsd: cancel nfsd_shrinker_work using sync mode in 
nfs4_state_shutdown_net
affected versions: v5.10.229-cip54 v6.1.115-cip31

CVE-2024-50125: Bluetooth: SCO: Fix UAF on sco_sock_timeout
affected versions: v4.19.323-cip114 v5.10.229-cip54

CVE-2024-50134: drm/vboxvideo: Replace fake VLA at end of 
vbva_mouse_pointer_shape with real VLA
affected versions: v4.19.323-cip114 v4.19.323-cip114

CVE-2024-50138: bpf: Use raw_spinlock_t in ringbuf
affected versions: v5.10.229-cip54

CVE-2024-50142: xfrm: validate new SA's prefixlen using SA family when 
sel.family is unset
affected versions: v4.4.302-cip92

CVE-2024-50143: udf: fix uninit-value use in udf_get_fileshortad
affected versions: v4.4.302-cip92 v5.10.229-cip54

CVE-2024-50148: Bluetooth: bnep: fix wild-memory-access in proto_unregister
affected versions: v4.4.302-cip92

CVE-2024-50167: be2net: fix potential memory leak in be_xmit()
affected versions: v4.4.302-cip92

CVE-2024-50168: net/sun3_82586: fix potential memory leak in 
sun3_82586_send_packet()
affected versions: v4.4.302-cip92


As the attached reports are getting too big for a mailing list I will 
provide links once I found a proper storage solution. Until then feel 
free to contact me for the reports.

Kind regards
-- 
Christoph Steiger
Siemens AG, Technology
Linux Expert Center


