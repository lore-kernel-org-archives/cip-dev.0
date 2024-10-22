Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39334D1CDCA
	for <webhook@archiver.kernel.org>; Tue, 22 Oct 2024 09:32:24 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.41])
 by mx.groups.io with SMTP id smtpd.web10.14457.1729589538776577234
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Oct 2024 02:32:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=GSOc0ATm;
 spf=pass (domain: siemens.com, ip: 40.107.103.41, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vuGXS+74b5oDAD0ImCZB4L+FFb8vjIui7jBixbpRbb9A+qGDUGRIHiOUVklN8BUS9DtsbvxA2DWOsCsFLGwVlQJX2TZAoij9kZmIaBJB+YGdC4C/Z5n7ywL1T6HJHzfqfYeZiBxiZHgK3ru8n9PLVdWLkyMJuy/IjBFb95VOcPlAyGIR9u9NL5wUD5k9xN/ijc1xUEOHywsF6s6yhIBSymubgI/IUIdrC5vHSE2UqPb8jNlwSHEWM6mbdWoIegT2v9R0PkhLSALkzozrGNx/qpfjBkwj//1DJ3uiSOrdVde2KRDaUKG4mLqHpNrYQSSy/aS+a6ynu11D5nVKAqf8aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/mYBrUTMMYOt/8d06C6V0ippQcAk9VwZGHXDJJZZyE=;
 b=wPLbbVQPng/d/aRZHbSldjDUf9QQc5go8XAsyCO/8FugJoUOMRjtTCgfN2NrUCTRogLF4tb/E3IAGc1bI8VnkauworqR+ZNCf/sWVJPr16U1uM4oHvJfYL7MggoTMPrQIxBhYhZTnearycjjYXeekplTzPw6XDyyjLDLmQkkxgl2MtvvqyAbaMq9H5ucJ2pUspo/NkWtCzeX3wJgqFa28pHJ9Bwv3NaZe4ZmdrYP6z3zzMSy7bFC/3zjgOAFnL7ZZDswQfzOUDdG8VeaMg4hR2Zs8d5k/eONvk7KvxtNiYczs9F7bX490EHxAIWyWlbXWgr4wAUSAWO82/2/fC8lIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/mYBrUTMMYOt/8d06C6V0ippQcAk9VwZGHXDJJZZyE=;
 b=GSOc0ATmaQTlIpVbpC41UPFN2NbXaFRlv4MwNqf+QRe2sdGMqBBXHYdIe0ffYVS/aIrmsGdnCpekUUkGvd0yzgGtc4Pg7HCkCxk9vc2OZCoT9reAtkO+sFo9roJABKBsJsvxX5G4j99lmWz1mfFG9OdFQMHLUEBs93kwpsX0+gb0EEoY9wcAdawIQLlvm9jT1ILy0z9/7sIP9e0mCleJUIt1j+8wytwqs03v9doVQI0BonzssW63ctAr439TAJZQRZzdhjmrJMM5XQ8yEf7f1q317FKvkr0kRDqSsSJYiQqVrThWZOzqeMJekz1qwXyTIRzdVsEvRf4kyfXxMy4ZBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3124.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:18d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Tue, 22 Oct
 2024 09:32:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 09:32:14 +0000
Message-ID: <6998f97e-52b9-4ad4-a388-a4c52afa5e8e@siemens.com>
Date: Tue, 22 Oct 2024 11:32:13 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [ANNOUNCE] isar-cip-core v1.5
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0367.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3124:EE_
X-MS-Office365-Filtering-Correlation-Id: a1a9eb9f-85e1-4483-5e5e-08dcf27c69da
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Y0EyMndmNGthSzBMNDczRVpTcVR2TWxhMk5LYUNhaDBIRDBETmRZM3hoemVX?=
 =?utf-8?B?eXh4Y2RJQVVTRGxyZG12SVRIWmRsVzBHMFpXZEN2UWZRRytQa1RldHo1Z09s?=
 =?utf-8?B?MWpFbG9BYTRjWnk4RWlZdUNTc2hrdFdQdjMxOGhMRFpzNzNpVjlIRVpkVTVY?=
 =?utf-8?B?eHZYa08zTXh6RkZmWlM0TUw0RSt2bU5VVTBWM3hTYlBoNTRCTW13TzlSVGto?=
 =?utf-8?B?WlR3ZHYrSlp1a09hQ1FJakxvVDVCYmVORVlpeGN5bzlsc3VwTGRWSGdqcXlU?=
 =?utf-8?B?cXlmcHhhcnJsSHRBS01BY2hqcHRObityN0dFUTlUK2h5U1M0MjVxOU0xYVhy?=
 =?utf-8?B?TVBNeWNaTmxVSW9NVFc1Y3c0ZnFPdktiK2YwVHlyVzlqVlRrK1BXOGFxY1du?=
 =?utf-8?B?UTZ5Vm1oL25RVHhSVURpNlQ0UkdrNjViNXUzZzlTRUlLU3VlaEtPRE1pdTNl?=
 =?utf-8?B?Vm9ZZXdzTEZBdVY1ODJ0YVRYOXkwVUJMaXBCcy9oZERuWEpxa2RNSzlMbkZH?=
 =?utf-8?B?bDNlRG16Z1FSWDhzMHpDeVFQaXlYRktwVjdkTXo1V2NyUzFqRGVybmZVcm9L?=
 =?utf-8?B?a2VIcFVITm1LNlNodTlDUE9mZHozSlJNaktxVE0xbDBuU1I0ZDd3MDk5UkVa?=
 =?utf-8?B?dHZ6ZDA2VlJsWFBuSStnak1YLy9XVkNDenhEbDVYanIwajhlZzZKTzZ0MVlD?=
 =?utf-8?B?dTRzcVh4QjAvQUxPM3pBOGNLazZSZS9qRWFEWmVjS1ZKeklpSnVLUnJmMk1z?=
 =?utf-8?B?dEx5anY5cXlHN3FEUWVKTTZ0YkJ2ZW9MQlVUUVpjZm5nYlN1U3ltTWhJNkpT?=
 =?utf-8?B?ZUdhVkM0ZnZsdVp2L3ZmY0pQMVZZZlUwaW45cEZTdEV2S3lQSnA2YXVRSlRv?=
 =?utf-8?B?azVGV2dqQXNkcys2K3dxakVVb1htR24zQk9WODR4NGJTM2U5QTN0L2IvOVY3?=
 =?utf-8?B?SnkwUFZHMlU5RWhVRnM4dS80YWcxMXFPT1NMckwvY1FwemxBeWpyZnQxQkcr?=
 =?utf-8?B?RTI2V3piS0hjU2I1aExHbkxYY1Nva0IvMDBqWGZyT1RuOVhycWpYQ1dXSUp0?=
 =?utf-8?B?ZGovZ21oVWxmcWVrR3R1SDQ3SDVrWEhGOWdLWUtUVTVaUk5tUTh1UHVXZytO?=
 =?utf-8?B?NG8xMEJ2M3F6TzhXb3hyOUhlbER5UTFDckZSRCt5WkR5ZVBiY2pSN0dqT2hF?=
 =?utf-8?B?MUViYlhnUU9oT29ybnVXY20xdEttbmNTem4reUVSZ1VvUERTRFlGdjBSQ2VB?=
 =?utf-8?B?QldRRnJuQzN5alYyZ25vOEhlUzZDeEY4NU5Od2RZYzQ3cFJLakkvTHRoTm1u?=
 =?utf-8?B?VFlrL2xoNkpRMzlxMDYwdUNkOTE0emRCN0k5ZHJ2anhDSmlWYkR4UTFQV2s2?=
 =?utf-8?B?VTFxNWVxZ093dms2TWtXSnhBTE5zaTI1bmFpUHY0ZjdSazQrQTJWelVrWWtC?=
 =?utf-8?B?VFJ0Y21kSWNRSHhnNmR0cFU1Y1hjaFJzRkhOQmdZSUl3QkdYaU4yaGlDZHZS?=
 =?utf-8?B?U1J5Y0hOcEkxRXdGdU8xYXl4YnVXYmJjVFhzNW50YXQ5WkVUdXlsRVo3Q212?=
 =?utf-8?B?N3lOOFV5MkpKQkxtYURBWWVFZUN6Wlpsem5rL3lzTHNqazRCdlZCUWhSeXF3?=
 =?utf-8?B?aE5iemkyVG5jS3d0VlJnUjFieFRJUlRYb2QrVEhucUI2ZS9sUHUzMWdSWmp1?=
 =?utf-8?B?aXl0WDJoWnJmSHU1dUhIQ2pIWGd6TGt6SThhNXhRTDdHMjdVWWFKaVFyRVhV?=
 =?utf-8?Q?9Pdmz8EdyBE9HMbqpJu75vljLua5Q46jn/ggN6A?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RGFOMm03bEhNNWFLUkhqVUZpaGlETFNCTSswcUhhUnA0TENpY3EvdEpjUmpv?=
 =?utf-8?B?ZEMzZC9vVDdSWll1MFB4b0NBRC85SFA4NGI0TWRjcnpEOEdyMzRsZjBiOWpM?=
 =?utf-8?B?algzZEkvV3BqVWJyRmJrSlJSbnJaR0JkWEs5aFk4UTZwaWppODZVcDdXelk1?=
 =?utf-8?B?N1FvdHdTNFFSU1VUeXk0YUszUXhkNjkvZ1BIU2NMTGlGcHlKWTVmMW5RTHFI?=
 =?utf-8?B?bkZxNUxVekhEUTNWOTVtejBKSW02ZVhuMnNGTWhFZ2JXUXdXYzdla3VFR1c4?=
 =?utf-8?B?RmZldEhRQjExT2tFRWtmYU9aY3JNNG9Xa2tmaUJOK0VleHpsS3FhdjYyTmh3?=
 =?utf-8?B?aEU2cDkvdkFKVVFVT2p2UjNKUXQyc0hscjhneFRPa1VkNE11SHpnU2V1cTcy?=
 =?utf-8?B?Z0FGZWlPT0xIU0hKTFJsVlNzQVZuV2lmWHcxOEoyQTlOYnIyTzRBejRpdHNm?=
 =?utf-8?B?VlhqRWlQaWRndjgzMHlzV2Z3VXBZenh3dDY1Q3RlS0t2RUprN3lRQjRTazhy?=
 =?utf-8?B?a093OWxaVEV6NXlBVWlxZllMemg0a05FWG1JbnVRbG5rL1lLZjhSeHh1Yy9j?=
 =?utf-8?B?RXNRUTdjaDVDc2lDeWFoUUM0Zm95SVdZR2FJUnhnME44blQ4dC9qd2I4SWdK?=
 =?utf-8?B?NE1wM3hNZzRodG15R2FIdXJFZER0bUI2RHQ2V3kyRUJOeEdFK3JlSjBYcXh0?=
 =?utf-8?B?T1pVVzladlFwS0p1TTJoTW9BMkg4Mk9QOWFFOGRTUzV0Mmh2NVFFWUFCZGRR?=
 =?utf-8?B?UXcvYnM2MXRPaXh6NFFUQ0ZRVDdXdDBKRWlmN0RQOTF3QkxEaHh5Qk1mOGZO?=
 =?utf-8?B?TzJkdzJqaTRjQXRDQSt3eFhnT09zUmJIT3pLTHBrSGR2dVI1NndYOGF4SEVl?=
 =?utf-8?B?a01EWVk2aEc2Q3Y2YS9jbUpyWlZLaTNpUFp1QzVtYWhtMXlRL1EvQ2MxS0NU?=
 =?utf-8?B?aXN1K2ltN1N2OExTSjRnd2xRdVhiY0UvYURMbTNZUldrNEFoTXh3WjVmVmgw?=
 =?utf-8?B?cHdLaklScE16U2t1ZXFHeE00bzBMVU84dkVUejhTb3ZNRjlMMXVnK0lwSVV1?=
 =?utf-8?B?TjFSaGcySGRpeEhqNHR5bWNHUEh1UHRHcVdvYi91eFFFQXRocjVmTUVqVCtW?=
 =?utf-8?B?eENRaE9hdVM1L0Q0Z1hzZE5QRFpBOVhQa0Q5Z1VmK09jdlV2bC8zM1RKV1dV?=
 =?utf-8?B?TVllT3dWSXVOT3hYa3kzQUJROGpZOHh6WExEMW5LL2ZCOXZYVzlZUFJmYjZ0?=
 =?utf-8?B?NUdWT1ZpUFhMZG1laC9VNVRkYUZ5ZmJnSEJMWk1hTjN0ZUNPRXdJU1E3THRi?=
 =?utf-8?B?a2FxMHA0UjZwOTZzcHlsNTgyazlFdm5udmNwRklhY1FMd1F2dXdQTnZVb1RI?=
 =?utf-8?B?cWJURTRobmVrVE9maXFqZm9hNjVxK1JSWHB0SEhXazFacnN5QktZUGYrZGg3?=
 =?utf-8?B?S2xLQm96K1o4alN4NTdOMEFvQm1nT0tRcmQ4ZjlnT3NpM1RIMUQ3THJRRjZC?=
 =?utf-8?B?VzVJelM2VjFMZW1sNFNvSTVFcDJlRXNvbndEcVdWaW9oSEdCSzhFM0Z2V3d3?=
 =?utf-8?B?V3M2ZFJway9CdlVXclUxYXlKcHNsWlVmOWZpR0JZNGdjS3NSbFdMNmxzVnR1?=
 =?utf-8?B?NS92R1laaWtQdVVSWWhUTFlwbFJmYWRKaGdnMEpnQUVPS2k0TUlxNGVjcU1G?=
 =?utf-8?B?anV4eEZ5dnJkalQvL2pEZG9WRE55LzBHYzVOTXVGTk9YbzZZZjdqL01OOUVi?=
 =?utf-8?B?aTJqSGVvUHdPVUFYNlJPZUxlZHc1MlpOMWtCYlNhT211d0JIRG5SeXVkb25F?=
 =?utf-8?B?bytsS2d2bG5qSVVSRGVGSm45UjI0UmdFT1lNNVd6aElWdkMyZ1lpemtWODc2?=
 =?utf-8?B?QWU1Z0lUYXRtWHVXUkdYTklWcXNBMnovTmNtcFgyYWVxMEx4YkNyWFA5ZENS?=
 =?utf-8?B?MlgrVGltSmxxc3Nsay83VEdGektJUGt2a0d6RFR3TFZuWlZaekYzcm1jRzdR?=
 =?utf-8?B?OEYySUtoblVSdnNBV2llWWpWRDZ5L2JneHpaWElXQUVFN2JkUVZ4L1QrWUtE?=
 =?utf-8?B?RWRQUStVMm4yTlY5eklMbnRxSlhqK3ZpV1VwN0p4cmx6Q2NaQnBoZmtlMW45?=
 =?utf-8?B?bHYycDJNOWk4RG5ka3RoL3g5c2tVZU5pWEwrNlYrVlZOUlU3eldSRzh3VFFO?=
 =?utf-8?B?Ync9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a9eb9f-85e1-4483-5e5e-08dcf27c69da
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 09:32:14.7840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HtqGgeeZaC+okWaA/UE5/vYXVz6Of3UaaqgKl7x7yb6P3cpVFqH8KnKhqs5v1J4nVPSOaqdnteAojdQRjEN3DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3124
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Oct 2024 09:32:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17065

A new release of isar-cip-core is available.

47 changeset, 10 contributors, 38 files changed, 371 insertions(+), 229 
deletions(-), these are the stats for v1.5. We are almost on schedule 
again when aiming at quarterly releases.

Lots of housekeeping in this release, but we also made further progress 
with reproducibility (via isar fixes) and improved the reuse of the 
overlays initramfs as well as the signing recipes in downstream 
projects.

Thanks a lot to all the contributors!

Jan


Chris Paterson (1):
      .gitlab-ci.yml: Use "large" runner for cve-checks job

Clara Kowalsky (2):
      initramfs-overlay-hook: Add INITRAMFS_OVERLAY_MOUNT_OPTION
      initramfs-overlay-hook: Check file system of INITRAMFS_OVERLAY_STORAGE_DEVICE

Claudius Heine (1):
      swupdate.bbclass: make swu_files entries unique

Felix Moessbauer (2):
      fix(PREEMPT_RT): disable CONFIG_RT_GROUP_SCHED
      PREEMPT_RT: enable isolcpus feature set

Jan Kiszka (16):
      ci: submit_lava: Fix reporting of submission errors
      ci: submit_lava: Fix access to LAVA API
      ci: Show live output of LAVA jobs
      ci: submit_lava: Reduce validate_jobs to handle only a single one
      ci: Only allow IEC tests to still fail
      ci: submit_lava: Improve detection of failed jobs
      tests: Pin revision of cip-security-tests
      ci: Require IEC tests to succeed as well
      linux-cip: Update to 4.4.302-cip89, 4.19.317-cip111[-rt37], 5.10.221-cip50 and cip_6.1.96-cip24[-rt13]
      linux-cip: Update to 4.4.302-cip89-rt50
      linux-cip: Update to 4.4.302-cip90, 5.10.223-cip51[-rt21], 6.1.102-cip26[-rt14]
      linux-cip: Update to 4.4.302-cip91, 4.19.320-cip112, 5.10.224-cip52[-rt22], 6.1.107-cip28[-rt15]
      linux-cip: update to 4.19.322-cip113[-rt38] and 6.1.111-cip29
      linux-cip: Update to 4.4.302-cip91-rt51
      Update isar to latest revision
      Update isar revision

Nobuhiro Iwamatsu (5):
      recipes-core: ltp: Update LTP to 20240524
      linux-cip: Update to 4.4.302-cip92, 5.10.226-cip53 and 6.1.111-cip29-rt16
      recipes-core: ltp: Update to 20240930
      Kconfig: Update default kernel version to 6.1.y
      linux-cip: Update to 6.1.112-cip30

Quirin Gylstorff (6):
      fix: Check return code value of e2fsck
      fix: force mke2fs in overlay recovery action
      Move signing script to seperate package to better support HSM signing
      Add check for sign-swu executable
      Update README for swupdate signing
      Add missing paragraph for ABROOTFS_PART_UUIDs in production

Shivanand (2):
      doc/REAME.secureboot.md: Add steps to inject UEFI keys from KeyTool.efi
      README.m-com-x86.md: Add M-COM board specific details

Shivanand Kunijadar (3):
      Kconfig: Select secure boot as default for security image
      doc/README.secureboot.md: Add information of DB and KEK in case of snakeoil keys
      doc: Add information about Debian snakeoil and user generated keys method for secure boot

Srinuvasan A (3):
      kas/opt/expand-on-first-boot.yml: add an optional expand-on-first-boot
      classes, recipes-initramfs: remove do prefix for adding task
      wic/x86-uefi-efibootguard: correct the partition name

sai ashrith sathujoda (6):
      submit_lava.sh: Rectify condition to push results to relevant projects in SQUAD.
      IEC_template.yml: Update revision of cip-security-tests
      submit_lava.sh: Modify environment slug in SQUAD
      scripts/run-cve-checks.sh: Extract suite from dpkg status file name
      scripts/deploy-cip-core.sh: Include release name in dpkg status filename
      .gitlab-ci.yml: Update debian-cve-checker image reference

