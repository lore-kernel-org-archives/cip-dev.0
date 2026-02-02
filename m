Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301BBE7316F
	for <webhook@archiver.kernel.org>; Mon,  2 Feb 2026 13:22:18 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.51981.1770038530472579396
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Feb 2026 05:22:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Gopt5eIX;
 spf=pass (domain: siemens.com, ip: 52.101.72.4, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vo54vVw7tbBT+Nz0bwtO3GfY7VULe4ROm4Z6DaT+XPBSgjQFVBzQKxnJhIXFzp57pu38ZmJT7FTaoPcp45LQX9+zogBDFzSuRfeIcm96xGqRQuo+XGOgs5tBHpGlZWR+RBd+NaeI25stxiBM6kfZ7OMIIs78g3Lb+N6l6KIEofSx1qqGqLFYDpv0hv04tR3gCs8pJuZ7WXQU3lF1CFDMQsym7EDo4xlk4L+yzlPkRGktyG8siw0jzIyeu7itNAgEJpmn1J5rzGUBUwLhBiMMPE9FHH70h63kwUmi079FqkdSkKzzW3WpTPyJpsvg3PWQm78E9i2xLxGT6os451qniQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qe9/TH1YDmrUoJ82etwMPD3rVeF8G96ACCinrw9peUc=;
 b=bz5etTv0Of876Ihh5YpSXef0CO8CFyTLMb0YtMB8pfUxwFB94U/L/YDH+SnWUKleRBduAJNpFiXWooS6067obfoOy3DNyG05yQjgh/Lul9qe6xjAQVFK2TKpoipGmwUxWTojov5YxPQiS7Xz1VOkBtpSvDcvhvF9ME6mspYNMHyufoXw0aE7c+WJsW303SkaQbUh6dbzNDNNrPbMw6Ua2WriJnWgcwhEzIKyIUK3b64EqwAIGh0NpqHuqlqy4Lxokn6IcxbGrDJu3rGQux3dyDH5G2qi+hrcCAm9OhP+PCkIc4tLtUyx4i7rNwM0PABPn4bwmfc66dI1Etka7uQIzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qe9/TH1YDmrUoJ82etwMPD3rVeF8G96ACCinrw9peUc=;
 b=Gopt5eIX2nLeklXxhr3dI0YkYrFdHpZKtDQH+kV4Qq9XBBbPSOB8lrlP/Pm0Hg3gV3Mxa2ZZkviP5aKbJ150ll/1r34IqyeLIB6ACZvFWET5DIIpW5OXPk+K7sclLB69FX1Z+7iTJ/9g88/cw46wKEmWIFK5AAaw/utzHIRrbSWQebIrh0q8ho+ZjO1S1mjmRvOS7plnGkhqDnj5uy1493TPy/6ukzho2u/LdLR+P3McbREhF6vYShWWvLR9B/1o+M11CDorGRH6zApfKg3uN9TzhCdADatr1qtqlabZCKjimh9wEHYiiTxHiaL3FjlHW7uMZURtcgyal9mNYne5rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:89::19)
 by DB9PR10MB6449.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 13:22:06 +0000
Received: from VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec8c:43f1:36b1:3314]) by VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec8c:43f1:36b1:3314%7]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 13:22:06 +0000
Message-ID: <f1fb4b66-f549-44dc-8937-312a0bc6cb74@siemens.com>
Date: Mon, 2 Feb 2026 14:22:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH 2/9] u-boot: Add
 U_BOOT_EXTRA_BUILDCMD to common rules.tmpl
To: cip-dev@lists.cip-project.org
References: <cover.1770037068.git.jan.kiszka@siemens.com>
 <03d818137b9923826170a993ea9e7bbab01e9153.1770037068.git.jan.kiszka@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <03d818137b9923826170a993ea9e7bbab01e9153.1770037068.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::17) To VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:89::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR10MB2319:EE_|DB9PR10MB6449:EE_
X-MS-Office365-Filtering-Correlation-Id: 79bc5012-8534-43ae-7234-08de625e0f70
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|4022899009|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NldNWVpoUFJ3MUZIa2xuZzFZaUxEOU1UenpUQlZBMDBrenFKamtDbXNTOHNR?=
 =?utf-8?B?aloxeThTdVJuVUIrdTc5UUpBTTY0S24zK2NRQWpFNDR0eUZoTzllN0lXa1lx?=
 =?utf-8?B?VVVlZkorSHUyQ0paQUFNTHZsaFlTbVVpd1hFSktBcUFBSnRjV0RHdytZSWRS?=
 =?utf-8?B?TjNwVzkyZVptMkFKQlMrYVJRWkR4YTVvd0JLUm04R25NTFB3ZmN2UXhyUzJ3?=
 =?utf-8?B?aUx0WVlrUUJlTUxSL1VLMjEvZThWZVRpRFhZckNtdC9tM1RjczVuYUFVU0tT?=
 =?utf-8?B?ODBMSzE0UVFmMHVCdHZsQ2wxdkVvWE9HV2tPZWxyTGlaTHhDVk9uT3huNnhN?=
 =?utf-8?B?MkNaRUZqcFpMWk9DOVdncm5nWHRHdmJha1psdU9RUFdRRXQyVDJBQk4yOVlW?=
 =?utf-8?B?MGtDbmlVRkppYmNxeWdTdy9ZM2lwa2NjWnM1WkYyVng1MlBzRVRiWUhiVW1J?=
 =?utf-8?B?OS9qOEx6NEtwVkNicVBpcmkyemp1d3FmblNueDR0YjBib1pnV1FOeWh2Q1dI?=
 =?utf-8?B?cS9ETStseWxkSFd1NXljZDQxNzJZeFVtMWYwdnliMkVHdDcza05mdElQam5j?=
 =?utf-8?B?Q1lFSjBEaDVnNEttK2hsN2czLzBnbm1nU2s2R3VuTlgwdnMwNmtlSEcrUWlE?=
 =?utf-8?B?a0RJdG52UEYxZndkNFZPVlJwQUc2QkdMSXlWT3BGTWMrZjZlbkpQZGhnbHln?=
 =?utf-8?B?U01hMHBSY1AwdmJHZGt3U2NxR0t0dk9PcjdGNE5zM2JBTDJWZW1BTHl3bThO?=
 =?utf-8?B?Q3dLUWJkVTVZOXpOMXl6d1VYbytOS21PM05XeEhGVHJpNkdqc0JMb1AxWWJ1?=
 =?utf-8?B?Q0hnaVc1SU93eFBHa1d0RWFSbng2N0pnNkxHZHNZUk5kZzIyZDRPWDBVL3Jr?=
 =?utf-8?B?Q3Z3TThqVU93enpqaGRmS3RSWVNLckFBMlE3aWU5eHdpNUo0eW5MUXM2Q0do?=
 =?utf-8?B?elI1RHc3UWFpc3NMaGpxQmxyUXcvcVhjMDZ5UWJtUlVmekt1eVorL0JvMXJw?=
 =?utf-8?B?OHZVanducjN5N251TmFkMW8wQmdTTjhKN1IzR3phRy81aXZMbDl0V1VVb2Fu?=
 =?utf-8?B?Z2Q1SFQ2SS9OUWQxS0ViRVEwUlV3UHJYRmsxMkRZaHZ2U1NPSFNMNnhFVXdE?=
 =?utf-8?B?TDVYVnUvbTNNYzJWWVN0YjF6TW5SYkF5ZlE2SktoSG5LeXFuOVlMUmJlQU9a?=
 =?utf-8?B?NEh0VStkNkR2enhRd1JqNnNiVlpldEdoell2M2ZYemZ1UVRmNlNFUFBuNnZo?=
 =?utf-8?B?Q3hlYUs2SVA5bFgwQVNsb2h0REFvQ0w3dVVJRlBZaldmRXY2LzJZTGRVQVRa?=
 =?utf-8?B?bjQwZDNsMGJ4SFlUam1KMUhzSUQvMXBmRjZ6U3lJRm1SVEJVNzdTa0pEcDY4?=
 =?utf-8?B?Y2JxN1hpNGxBclJCSm1pNjhHZmZzSmJpZFVJSVo1Y0dXQXpRQ3RjTFkwUm5I?=
 =?utf-8?B?UzNPT3NmbkJUYXpPcXFxWE82V3FGa3NVR1NENVJuZ3lFNkVTVW82bFFXWkFC?=
 =?utf-8?B?dUJUMi9qbEFMdk5xS3BIVjk2YmIzNXVZZ0ZBQStjVUNJUEloaS80elpWVDFx?=
 =?utf-8?B?RHNGbk1Ya2cwL045U2MxRjBadDV5U0NwbGsxNnV3UVRybXFWeVR0YlJQRTRj?=
 =?utf-8?B?SVNVbEpsdHVjVStORkZCY2tIcU84Rkt1ckR4d1VrYzhRUUVvdjY4RnRtcXg2?=
 =?utf-8?B?NWhyNXkzWURkeW1MNVpRK3RXN0t4YkxXTFhyYVJOb2hVVW5UQ01uay92c1dz?=
 =?utf-8?B?eEc5OVZ0NERZYXB6WkRvMzFDZ0pMZy9OdlJNRHVGejN3Q25oQVl0akZVVFht?=
 =?utf-8?B?QVp6VVpLdlhiRkVRVkFYSlZSY00xQ3JWSENtNGVTQ243K1ZtbzFLUlhKQmY3?=
 =?utf-8?B?azFsazhVaTc3WmxJNmJ2eFFxWjBuQmdRMWVOWFY2aWJmMXBuRjk1VmJ4WWNy?=
 =?utf-8?B?RW50c2RITmpwY1d2eTI0MjNXYkFQWjROV0hOOG9uMjk0OXdCVkdQbm1sRlJR?=
 =?utf-8?B?STMrTlllTlV2VDZSdWxvYWxIVHYwMHFHQjZTQzBuVUd2Ympnc29qV3RXM00v?=
 =?utf-8?Q?mSU8/G?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(4022899009)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TU5lQThJYzZHeTE2UVB1UFJOaUlEeUVWWlovZlhrV2JjNjYyL0lDQVNnVzY1?=
 =?utf-8?B?ZTQ1Unk4OE55MnZqNUpISG85ZHVqeUh5R0YrNDBLRFFxOU9JM05Nbko4UEdO?=
 =?utf-8?B?RWQ1aEJ5U3lMSVBtVGRHSlo4TDVKTCsxVjBSKzY0TlJkS2hqOTVjQVFCY3BF?=
 =?utf-8?B?TlZDemhhRVNOUnVMMWg0M05IbkNXQWRNY1BqQUpDRVhjNFFZYlh4UUR4T2lN?=
 =?utf-8?B?WnUvTkNZek9aUC9KN2Y5ODFGblJpZ2dkNHRJUXk2UFBEZy9GbGNnMkhBaGRn?=
 =?utf-8?B?dDNNbGVjWGdGcXZIZWZDZkVSNXE5MHpEOXNiOG9QRVIzakNjMUVGanliVHFy?=
 =?utf-8?B?dlplUmRPRVNCS0xqZ25qUVRzdlREbVRCazcrS1F2Q1pCRnNuNVlFeUI0WkY0?=
 =?utf-8?B?ZVFKN00wd2l4c281b1JJZEFFRUhkZmFRTlJOdWdIR2loOHhRaXdPdkJGeUlU?=
 =?utf-8?B?MWZ3NmFRTkh4RkR2b1MzbnNGakhLODFram1zZ1dSNldiN1dPRkREeWlYVitP?=
 =?utf-8?B?VlRyTkpwV21MdXIvcGVuMkk3NHoxUlcxQkpKSGpuZmdremdYdXRnZnFMS2Fk?=
 =?utf-8?B?SitialpVeFZKN2xxNXBlNjBOS20yZU14S2tFYVdLMHRPUFF4WTIxUWdYa2Ux?=
 =?utf-8?B?N2xDVjA2TVJZQitRSFlzOVorUzlUNjNhdEdRb0QweTdKaWl4djhCekgwaUhs?=
 =?utf-8?B?QzZMaU1zSmxUUk9hMjFGSzF6eThCNHh6bVQweFRhV1E3QytJL2U2ZzNPcTA5?=
 =?utf-8?B?ZGxkS2d0SEtHZS9IM2l3cXN2bGRPM1E1SFgyYmZEU0ovVkRBR1pkOTJoMnBj?=
 =?utf-8?B?L2hDblJUOWV2Z2VUdWxXQmEyUUtwcU56bkl5UEZ6Kzgwamp6L0tUNmlJQTNY?=
 =?utf-8?B?V1V4WW1vOWFkMFo5aW5ucFVyZElIYnEyWWZXektyaVpmcDVxTlVDa1NFaG1S?=
 =?utf-8?B?a0lXVi9aK3hwNEIzSkxvK0kvVnlBTXh1dzlkdHdndmZXcEk5RHpvbEZacm9W?=
 =?utf-8?B?K0N0R29DSXdSNEhlT1RWcVUyN0lOVEJwWmtXYVVNcGtZbTYwaVJORnBMRVho?=
 =?utf-8?B?UG9DbklEdzY3Yms2NW5kaFVLcXY1azl6SkE5NHZlNFh0Z3lPQlQxWmxha1gr?=
 =?utf-8?B?dHhFZ2tJN2N3SEx5Wk5JeTFxdHA4bjBVUWRHcHQ1bnN2d2Q3UWVjbGpPWFY3?=
 =?utf-8?B?eUN3YTFXSDJoN3ZHanl4MGhaYklBQXVES2xldVRsSHQyTloyelJtdVFseVc5?=
 =?utf-8?B?d0dURzF2eCtSQWpJeENuWE9uQ0pYdzlSZmdzaGFwSGptOUU0M2pCNGZPdFpm?=
 =?utf-8?B?MWs0SGFjYlFFUGJNZjVPY2ZuSVhCUFltS21MeTJWVFpKVjF4WGc2T3hFTXV2?=
 =?utf-8?B?Y2Erd2JJM1N3QldHVURKTXlhcXN0Z0tWZWlqb3d3Z25yVFFVY1FJcEZsRWJF?=
 =?utf-8?B?dEZxc1E0QStNRWMybjYrZVlNR0M2MXNZSWkrbWdhMlBOcnppVCs5OTJ0RjhV?=
 =?utf-8?B?T210TzRFNHJUdmtlVFFlUCt3WVlmNHJpTlFZWkpOazBDRDIrYTVidlA0L3du?=
 =?utf-8?B?S1JNbGI0dkZVOVM3eHFkd1ZzS1F0QmJSdklCMWhOWUt0alJMTWExSWtjVXJK?=
 =?utf-8?B?WTh1d3JlRmdzVmEzbXVmMFg0UVNkSmhVYmlxVUVPY1NMRUo2ZmZIYyt5QnNQ?=
 =?utf-8?B?UjJSTzFzMmlFNVZNUy9LSTh6NCtOM0tBNFh3WFF0SWpXVCthbEhtNkRMTEI0?=
 =?utf-8?B?aGZuV0daVGNKWlp3bEZCRWQ0dkZYQlBvNVduRm1GVnRvUXVMMkphQURHTlB6?=
 =?utf-8?B?dlRtUTJ3SHZpTkNycFlMWlllZFdub1p5RTBlZVNWZTlvc2F1ZTNpL3JscjNs?=
 =?utf-8?B?N3pKWFI1YWo0VmxOWkk1bFp3TXNjNW1UMjJXZlVSTk5jNnBYeHI2bHZaTXJ6?=
 =?utf-8?B?R2hEa1l1OVhWZCtHeTc3azc5Z09ENlJMZWFyNGVTc2trWFFKUnlxR0svQlRR?=
 =?utf-8?B?MkFRK3Q3cEk2NHJhclpweEE4MEpGSTZCUVNGYW5TdkJrS0ZmSEtwMHBnRTdQ?=
 =?utf-8?B?UUhWWElKWUFSWEF5MDhUaTl5RWdyV2pYL0t1MUNZY1hDWk8yZ1djUTdoTHc4?=
 =?utf-8?B?NEJsQmQ5WTc2b1huSGc5d2l2OG5HdHJ2Umc0U1F1MnhIejRRUWo3TDU2Q3pV?=
 =?utf-8?B?Q3dTalZGNi9qbXk3bVJ5eXlveHBOcEVVYTFsOEY1MzUwZE9sVkhPOFd3VjZZ?=
 =?utf-8?B?aDFLdGZ5VlRjSURudEFweUllK1VldE82WFg5TmN4RHlRdkdNREpRM1c3V1B3?=
 =?utf-8?B?SnkzTjRLemRiVlNCUCtWWWFWazlOUFlmanVDcGp1U2VUeGdwcm02NzYyL1d5?=
 =?utf-8?Q?JZ4OEy+7VnRBF84U=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79bc5012-8534-43ae-7234-08de625e0f70
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 13:22:06.0426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LnsHCGtu9Fm+CMT1NBlD8scBTIcoEwUsSLzF5Dtu4gx4q/xysQg5lP6Bw4i34Ny7aqWkSmQ6zxiNGWwxV1ZOlVB0PnqZzv6oQAu4+cncHqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6449
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Feb 2026 13:22:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21809



On 2/2/26 1:57 PM, Jan Kiszka via lists.cip-project.org wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Allows custom post-processing steps without having to fork the
> rules.tmpl file.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   recipes-bsp/u-boot/files/rules.tmpl          | 1 +
>   recipes-bsp/u-boot/u-boot-common-2025.07.inc | 4 ++++
>   2 files changed, 5 insertions(+)
> 
> diff --git a/recipes-bsp/u-boot/files/rules.tmpl b/recipes-bsp/u-boot/files/rules.tmpl
> index bbf7bb5a..560a6540 100755
> --- a/recipes-bsp/u-boot/files/rules.tmpl
> +++ b/recipes-bsp/u-boot/files/rules.tmpl
> @@ -31,6 +31,7 @@ override_dh_auto_build:
>   		./scripts/get_default_envs.sh >u-boot-initial-env; \
>   	fi
>   	$(MAKE) $(PARALLEL_MAKE) $(SET_CROSS_BUILD_TOOLS) NO_SDL=1 tools-only envtools
> +	${U_BOOT_EXTRA_BUILDCMD}
>   
>   override_dh_auto_install:
>   	mv tools/env/lib.a tools/env/libubootenv.a
> diff --git a/recipes-bsp/u-boot/u-boot-common-2025.07.inc b/recipes-bsp/u-boot/u-boot-common-2025.07.inc
> index ed44bad0..7d91a8d1 100644
> --- a/recipes-bsp/u-boot/u-boot-common-2025.07.inc
> +++ b/recipes-bsp/u-boot/u-boot-common-2025.07.inc
> @@ -39,6 +39,10 @@ S = "${WORKDIR}/u-boot-${PV}"
>   DEBIAN_BUILD_DEPENDS += ", libssl-dev:native, libssl-dev:${DISTRO_ARCH}, \
>       libgnutls28-dev:native, libgnutls28-dev:${DISTRO_ARCH}"
>   
> +U_BOOT_EXTRA_BUILDCMD ?= ""
Should we not add this variable to the rules.tmpl in Isar? The 
difference currently are secure boot signing and this variable?

Quirin
> +
> +TEMPLATE_VARS += "U_BOOT_EXTRA_BUILDCMD"
> +
>   STATIC_KEYS_BUILD_DEPENDS = ", \
>       openssl, efivar, secure-boot-secrets, python3-openssl:native"
>   STATIC_KEYS_BUILD_DEPENDS:append:buster   = ", pesign"
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#21801): https://lists.cip-project.org/g/cip-dev/message/21801
> Mute This Topic: https://lists.cip-project.org/mt/117595046/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


