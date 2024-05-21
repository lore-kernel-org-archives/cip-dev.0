Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C432C25B74
	for <webhook@archiver.kernel.org>; Tue, 21 May 2024 07:54:13 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.50])
 by mx.groups.io with SMTP id smtpd.web10.14538.1716278043494710238
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 May 2024 00:54:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=w+0ECAT3;
 spf=pass (domain: siemens.com, ip: 40.107.8.50, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJgQPx62HTrSLvsM2X/VENtixgXHDEg76vImUJzxJujCvsWX/fs/kt29aTZKJlyWRQe4AmsAQnEYB2v42oLI01QuY+FotEZETFuwtodCimyzlJ+djvMJEUJtt61MLjS2s+eGb/b0b3Ad7Y9rSVeD168kwPIVlzmN6NEHxrtHgTVOoMECrJj8LwkEgig87TtaF5RyEiII95ZOFeyMBSpb3E4NDwNz/sGsFFJx7BbXx2LDycmNVcNc0HZZZAauyfZTMkCBfE+V/RiHkmIimRVAgJjTdCAcAixJ/hMPlJAyP6A0wCb63QUR8puHhFdHKBkuDe81gPuNUp99k38Of6MJXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P50q/lDsq0ORbhQOACtQ89MWRq4YBJSx0Cgf4sT5B5A=;
 b=LEv4GH2sjFGdGVUnXiWKfOgjX/HuLr9zaRAMaXNMG286djMhlOlyOIFTM1IvZwfycorfBAPgLr0Ctntjkhsm3fPgfhVhIdDgVZceAyUDpmatY+SnOiq4KfacWrv5zYzmvmfYdzAQRSPwEQeBABYFBKM8bYtOTOyG7DK3NmG49oQQPnHKzHfnzsojIQvSFRYoZts7ojkQXpOBI0S5T7eDhzvtizBuYi1rG2/oX3ave98YzTk9EdkRiHxyM0BAJiol8Ur56KricEKZ7VU15tMmebRfcNQ8595uE1iBwpwkF3fpLSraWBl4aVVsz0RBPtz/ruoplPKOR4Jih8g3EjrpPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P50q/lDsq0ORbhQOACtQ89MWRq4YBJSx0Cgf4sT5B5A=;
 b=w+0ECAT3GIaUiW22shJoi9areTlLx/lYABA1fitR5+f1DxKo1MSDrD4ALeaxiSetxzR1QPG+kOudaCu5N7xcWkYoj1cB36PEUE3WHZklhfQ29R59P/rQgZI7sPPf+rCQ+HTnDndOZKzYTRJIXSIUO8zYSnLCG/YHXfJL3ORJBZEd/Qy+b7LndksSqT7nMeS3SGA65TeOWAlLYwC3Gpqf/MZ7D3UaBcAwfnsI00Yf94HqABg3hM2VGIhaZ0epuJkpW6uw0ebSmezhxMh4K00RzUtwknq5uZqfHOW9viYcS3JBSrI3bsaiOMsm6JztZaj63tkubJeqsq0jkhApZDJWqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB9044.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 07:53:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 07:53:59 +0000
Message-ID: <8b4ddb32-060a-440f-bdeb-db3797a36513@siemens.com>
Date: Tue, 21 May 2024 09:53:57 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Cc: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>,
 Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>,
 "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>
Subject: isar-cip-core: State of security image
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB9044:EE_
X-MS-Office365-Filtering-Correlation-Id: 3306ac61-c368-4a98-0348-08dc796b2c8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VkZaYkwyazBvYnArMFdyYllWYUVmbDAyaXB5NHdrZFk0MUVTZE9LZ2ZVWXda?=
 =?utf-8?B?bzQ3ZTc3enhPOGxsdEVvR3VXWHFxdmc1UWZtbGpHQTlEeUo0cGM2TDRiZzl1?=
 =?utf-8?B?RTZlZ01YSlVsQWRrTm1RSnk2NmdVNXRONS9nSm10QXNBR252SDk4RTFlVWdi?=
 =?utf-8?B?K2Y0NjFjTkorUk93M1RHcHhZdlhaclplR1R2bTdlQnlBQXZRMWMyMzNoRHg1?=
 =?utf-8?B?a3FmTXFRcFZaa1RzRmxzYkxZQmxZMzRacC83bHdXVFlzZWNKRm5kTjR1Mk1v?=
 =?utf-8?B?bUV1WE1vYmk4b25nOGpYN2pzYkZWL0tRS2hJWHpjaXNiamZaM2NGMTMvYllP?=
 =?utf-8?B?SENNK1FIaWxTb3FqaDk3a1c4UW03QVBDZTlJMlRMdzZ4ejNBdjVaTVRiTE5j?=
 =?utf-8?B?WDB2eko0WitmaW52VXBQaTZSUzhrSkNkM0U3TE92UmtaT0crNmsyay8vTmQy?=
 =?utf-8?B?Ri9GN2JlaE9ZYm9rZDMzZ0tZNmtKaWRZN3J5cmkzam9QTUJIckFIaGFKemdY?=
 =?utf-8?B?TXEwMDI3REFuemFSQUZySWNwb1NnQ0RuamZxWmw5YytuR0xSY3RWZmVVaGRE?=
 =?utf-8?B?aG1vUjJBdGwxS25IMytqQjVFWS9CdHM3cEFUZkF6enAvNGQ3ZDhBdlh5N3hJ?=
 =?utf-8?B?M2FiR1VkU09xQzZwZFEyMlo1U2IrSXh1QVdRdHFuZTkzR3dDUWloOWNoQWo4?=
 =?utf-8?B?VUlUWllsNVNTdVhNY3BJWXI2b3dpUDUveE10am1GcVNiTDFYbUdmUWk2cFlB?=
 =?utf-8?B?ak9zODJzc3lPQ3BRUnFJK0puejhVYTNaT2ZFSWhwczc2MzdySC9Oc2FnRFF4?=
 =?utf-8?B?Y21xOTA2aTQ2WXVQM2k0VUtCQkhTaDZ4dkxpejNIZUdQdGMwVFhpVVErL0tq?=
 =?utf-8?B?eW1nSkNlUkROSVNyMGowc3hjeURSbmpnOUVMZFFyQnpjc2RITmNLc2VKN3ZJ?=
 =?utf-8?B?aVpWZml3NW1OMm04LzRFcFA0bm55VnZFd2VSdnF3di80VXprUWZsUk4zRDAz?=
 =?utf-8?B?dFpKMTdtOVZ2RVZnbFczZUt0TmZwcXBBMDRHZE1jSGV0bjZXaEw0UzNvNHow?=
 =?utf-8?B?Z01jL2tZSkhNbk5CclBCRDY3VWlNaWptU2JJRUdrSE5STEk0czN0dFVpSUV3?=
 =?utf-8?B?WnEvZXpBMGlMQ203cE52elY3K0cxelc4S0NzN1JGcmdzSW1odzNqcThnbjJ5?=
 =?utf-8?B?U25ZQ2hzR0tEVEtYcHRHQ3laVlB0eE8wcjdpV3Q0b0FBSll5WlYwcXRDek9v?=
 =?utf-8?B?blo3ZlhQaUJ2UE5XV1RCa05INGtXMEJHZ1ZTV09Od3lqNnpLeFV1aDJWb3Zv?=
 =?utf-8?B?eEZkbjVEdEZOWjZLQnFnVmxJWE5IbGtNR3QvWFBmNG91Q3FnUlQrNVI4bmps?=
 =?utf-8?B?MnNGSDA1OUhrOTQ1ZzFhY2VZWUZiTVZMODJWcTRRanpBaWVuMGVyQkxJV21o?=
 =?utf-8?B?SzVaL00xMUxyN09VTUg4a1JSTWFLM01DYm9FVkowL094Z0w5RFlCQmoxb1RG?=
 =?utf-8?B?SVYzcHRGYWw1V3RxdjNYbkNxRzhqYUlrTUhNNGhHMDdmeWJzRmtUVnhhcm8v?=
 =?utf-8?B?NGFBU01GK3lzTmduVk52b1dDamh1b2ZpdDltWjlmZzNpU1BBN0h6aEdwZVdx?=
 =?utf-8?Q?jkE5RKX2o761GT6vyFMOVnU4OiC5OiHhvl4b3dyCtBlk=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UnBMWFVsTCtyWW50WVZrZXNKZHFSdE5KVGUxK0ZsUG9mUmZweFk5cXZIR01Q?=
 =?utf-8?B?cUUxZ0lSbXNtV3FPR0hXbld2dzRTdkExcnJZM1BIVXJMUVQvcDg1cVQzUUZl?=
 =?utf-8?B?SVZmNGlzVjJHT0NlYUMvV1ZSWSsvTXlOaERsUCsyWW1WRFRCRUt2U3owM1Y5?=
 =?utf-8?B?dy9MNFVEQkdCaklUYXl2RmhkRjc4NHl2RSs2Vm1lOWJoQjlqbDg0dEdjVkg1?=
 =?utf-8?B?SFpIa000aDBFcXBqRHp0dWViMW84N2s1UDAvWWorSVIzVHJSY2VFUWhlRG45?=
 =?utf-8?B?VkVFdWRDZnV4YXIvWTk4aUxrOGE5N29DVjNDMlZyZGs0R0oxbGxST0REemN0?=
 =?utf-8?B?WGwybitwZ2JyVG9XN01OdWt1TGJPZ2JlRytqMzcyS2ljWW5ubVlDMHdob1hE?=
 =?utf-8?B?aWZ2djd2MFYySUlFMlRYLzBoYndSQWZGcW42M2tWaExSYW9vMmJwTTdhR3hl?=
 =?utf-8?B?S2IxaG56MThLRS9KTCtkdE96eE51L0d3OWxndmZpNDlRUTRQaDJIdmZlUCtS?=
 =?utf-8?B?Si9vK3lhTnNieXZpc0RlZXUwV3hzeUx0RWswMnAvQkJVd0h6bkdPS2pFR1E3?=
 =?utf-8?B?UTNMaG82OGRoNmMrUUV3MEJqd2FyS2FhRVhjcC84dEYwYkNjT3BzQWFTTnpm?=
 =?utf-8?B?ZTNtakR0RjhvZ2psdUZzTXU1RnZxaitUSVFNWEJQa2dKendiSHFSTzRaNVhH?=
 =?utf-8?B?SjVLdmNtbmJ2NkNGWVNzUGJCU2VRMU9QUUk5U21vZUtvVURVRFdCTzA0eGFG?=
 =?utf-8?B?eGgrTFJWNWR4TXlwUVVwVHNvazlBVEJ2NTE1amNNblJwYTF0S0t3K29jYnRM?=
 =?utf-8?B?cnRjWTN4Q2tzUFR5SzR0QjBRR0RzZG9YMm9Va01adkc0WG5hWGhlREJvOUxm?=
 =?utf-8?B?RHMrcmREV3p1NDRuTDVJc0xnTGdMb2hFd2JXQVJSRkN6cW93d2ZCaEFFN1oz?=
 =?utf-8?B?UEhSa05xWE9vSnAzTWlyOGNmaEx2b2xvcHE3U0RkOExwRnljRU9NUWgxQWxQ?=
 =?utf-8?B?cEtmM0x6L21iMW9xelZSai81RE1TTlQ1bWZoV2FxaEMyN3VJYVIxUXh5dzRi?=
 =?utf-8?B?T1pTL3MxWE9pQURVSmJPL012TFU2ZTNHNVhOeUdNN1J5ZXJYdkVQTzNyajNC?=
 =?utf-8?B?aGxadjNQd3JDMmZ3RzRWdE1JK2pMVy9TREV6YngxNlpmelZhbXpPZjVRNDFK?=
 =?utf-8?B?SjRSUEpVN083M3BpR291K2Jnc2ZRV2JxRnNYZlEyanplQXB4K0o2WlZhT28y?=
 =?utf-8?B?Zjl4cUJRdzFxelpKLys3clF5UFdlVlVZN0t1cWNDS3JCbzJVWGVoNXBSaTh4?=
 =?utf-8?B?M29hRTg0U2hwSHhKaHdVMTRuWHYzNXd5UU42MUJ2TnpSY2RKVEZseU81Y1ZP?=
 =?utf-8?B?aVU1eGFudWJBQ2FYOWlPaEFta01YZkRXancwY3ZZN3FKVG1VYlRwOTFvblhy?=
 =?utf-8?B?d1c2NmdSYkRDK2I1cXJzVUpMZ2pzU3Z3U2xjN0RnamN6NHcyenU1RWZoUzVD?=
 =?utf-8?B?R2VqaXNYWVczYUo0MXhHMmRRTUF3cDlPZGdtUmNQY3RPc29GZ2F6QWdmUm5t?=
 =?utf-8?B?bTBHODByYW44UjlnYWtDZTN1bXZjVk5KeFg3RUk4ZnJWUmg4MlNjTjBMMTFu?=
 =?utf-8?B?My9POWtseG90UmtvR1hnL2NqL04yWXdNb2FCMkpISmp4ZE5TUGlubi9LTzQ2?=
 =?utf-8?B?TWdTQXZYODRFNHRnWFZYTTVhTzNMdWY2Vy9JcmF6aE1XdWg3TE1YWlpVc2pw?=
 =?utf-8?B?VWg0ZTQ1aVB5VVQ3eHdScnRTa0RQaXh1S3VJaWJNMmg0YlZMdXlRY1JuekFP?=
 =?utf-8?B?Y2h3TnYwbXo3U1JmN1A4bExvUWhTQzY5OVU0L0FKMERzYWJBbjFvYzdnUEg4?=
 =?utf-8?B?UVVHTEZXZ0svblBRQmhjVWg3bFhwbENTUzlNbmppaFVGaFlyUWhuTXBIbHBp?=
 =?utf-8?B?eVpianRLT295azkyanZoUi8vanlIcEQzR0MxeG1qUUFLUkdFc3RUS20xNnFt?=
 =?utf-8?B?dHhacjlmb0ZjWUdnYmgxOHoxVFY2N2pEeTE0Vk9yNDM4QndpK0NXL1FvYVky?=
 =?utf-8?B?QjNOellOWHpaUTZsSHN4ODBXWUdUY1MxajAvdXlKOFR3UjMrMStienZiSHp1?=
 =?utf-8?Q?8t5eX4Mbyk170iiOp++3R0k3O?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3306ac61-c368-4a98-0348-08dc796b2c8d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 07:53:59.6944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sWsb1ci1r2OPDCWtMu0ncOG2lJcfPfiFocX/r7oa02c2Fmc3/dzMC6LhYQaQqdi0NUOuvQeE00KT7PPPKfldhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9044
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 May 2024 07:54:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15920

Hi all,

just had a look at our security image in the light of [1], and it seems
to be in sub-optimal shape:

 - syslog-ng broken over empty var (that's [1], fixable)
 - we depend on syslog-ng - that's bad because it brings another
   dependency which real deployments may not want anymore
 - tpm2-abrm is broken because dbus is not installed - why do we install
   it when it is not used afterwards?

We can (and should) fix the smaller issues before 1.4, but I would like
us to clarify the syslog topic afterwards. And the test topic.

Jan

[1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/105

-- 
Siemens AG, Technology
Linux Expert Center

