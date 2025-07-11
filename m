Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AA6C8303C
	for <webhook@archiver.kernel.org>; Fri, 11 Jul 2025 10:58:47 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.70])
 by mx.groups.io with SMTP id smtpd.web11.10919.1752231518251501687
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Jul 2025 03:58:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=DTLrc2SL;
 spf=pass (domain: siemens.com, ip: 52.101.65.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UUmW2+s6kbN0AGkjOYdLCArpFqD45cYN8iUuuPCyVkEs7wp74n2iwccKZK+0l4mdL/x/PMIQQdu0R+MezBGVkGXKaizNrPplehmxPEGrwgl4MVoRhnYl9p880zGl9AiJuNu4EmwsLo1ln6QN1jCisiR0j7jCes35u7jsKu4x7doP2je8zzEU+pVxrzYK3r5WN+AJyFn6jNIkH0+BQo7SByoZzph2WykU8s8Iju7LR2kacuieWXaLZvowHEfuxtxTMjmkg+HVfHcNCEtYaF+dCq+CDfpJ/+hJij1ANUelLIQmysLrTVBbiSwnGjhAjgwqo5j1w7Tj4xLwSlzhbmIPOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+QfB4jWKzgZpqHY2piTz5GivuffsxJrQR2C28qWj2s=;
 b=F0UEoqKvH/mtDOFZbU6igFHzhMoXKcOBtP3XpHtO8JiryCgufW2poz4qsBH2taPySixfLqVKN8LXaDocezRje0EoXtUqujK7YSLtyatctrh28CSbOxTc7OcWYbpOkBv5JciDS11PLjejuMUlbOnOQ1WHDTNMYJV/ubbqPfDlwzfDxdF+9Ei0cl38cDW6PIhM7ok/Uv1h01TnsDasYPmh5Xon1ELqrDtTleuCnovQJcaUmI1VYKx4MJ4VDsTss8UV4BKv8TkD/nr62OZrxYVICt4wJIGoIZic/wox9YfLhMqT65JSo3WudnqItCmlPrc2lckY9VhT1P/1w2U7hmbRTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+QfB4jWKzgZpqHY2piTz5GivuffsxJrQR2C28qWj2s=;
 b=DTLrc2SLbx1Wyicxg/NvKYrxEYEvSwJ5t6HwsXZuLZ0Qtp1B+0rttZ4L86P1lXo5YtbJqtk+f2/WO7jh6lRFwofKVlBpgdTk8Ra+cwfPWiiWXG+l1TuOjAAVJd3ckPpaeFCfByFg+Tz3g7yWFuIjZO7suy0V1iLWDEnC/dsJw2HaL3jUrnVq7EbdjFSooiYcKjdNq9epiUd094WLJUf97ThJOJJrTQBQ9r4iwg5ljUyf8zt7tZDxhyqFnvQKzcb/ghd2cqXX6KyCoPstFLx6RlnkHSuAdqL7WSLgGXme3lv8OFnWrH1Syy+FY/gL/cJuaxuNR6MSOyjlH7rRdLaA7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8996.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 10:58:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8922.023; Fri, 11 Jul 2025
 10:58:34 +0000
Message-ID: <6f65f4d4-a007-48ff-a3e9-86b91ec2fab9@siemens.com>
Date: Fri, 11 Jul 2025 12:58:33 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] isar-cip-core v1.8-rc1
To: cip-dev <cip-dev@lists.cip-project.org>
X-Mozilla-News-Host: news://news://news://nntp.lore.kernel.org:119
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8996:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d3cd4f2-c053-41f7-2473-08ddc069e117
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Zk80UTVEeGNSNGxoTklxZHh3cUx2WnRJVzBVVFZ0cGVLNlpWU3o5VytNZWFo?=
 =?utf-8?B?aUgrV1ZvY3UzWUk0bGFzc2lLbzgyZFdBNURtMm0yMWRacE1YSWxqazVyZjRR?=
 =?utf-8?B?WEswRjVBNWxUSWREdWs2ekk5UWNodndON2J5cERhTzZFb3hnUTFIVFRvRkJY?=
 =?utf-8?B?d3VxTnFPd2tPWHh4bXlDVEY1aGdacHhFKy8rai94V0RPRjJPenI1M1RJWFNX?=
 =?utf-8?B?Yi8rS1dUcDFDN2RraXA5RmZMR1lva1NPY0JIUndFYjFGcHB1VGpxVUdZc1dC?=
 =?utf-8?B?RUFORHdQTTBPdkpKdHRhUEU3RjRMRS95b3hJTTBtK3QwYkYrTHZmTkJTclho?=
 =?utf-8?B?Q2szRmY1QmlUcHdEbDFLdE45eE1xZ01mWjRKQjBTSk9uOUtRYlJwd25jZGJB?=
 =?utf-8?B?c1g4aW1LVmU2TkkyNWlxc2FON0FBeDZPeXJRVXUzMWd3eUF0VEl1M1RDV1pp?=
 =?utf-8?B?RVRiZVBWMkptUWhOTjRvcXdZRlFoTEEzYWZBbFNFNGEzaUIwWDlqa3FGY3VB?=
 =?utf-8?B?V2MvR21tdGhqbzlwb2lyNG9Bd2lyYnpVa2RtYlFZVzhQTWpQOTFrMzRxalRF?=
 =?utf-8?B?SFI2QVV0dHFyMGI5K2NNcHJ0VjY1RFcramNySnAzQjRDQXB1bWdmREYrV0VX?=
 =?utf-8?B?USt1THFMeTF1T0t2YnhacmwrUDlQTmFyZzdtU25hTnVPMDJ4eVB2QzZtTU1J?=
 =?utf-8?B?dW13a3pMaWtLS0lBUURKUmFiOGw3dWw1OXA3bWhCNGpxME5rL3Fha1hNd3M3?=
 =?utf-8?B?bDcxcTR0bHlKa3R6Q3VROTMxZGYwSzQ0M0huT3hoUDNxc1JieThEWG0wZ3BG?=
 =?utf-8?B?dzVla05RR2NEaEx1MHErRE9RL0Z6ZGwvUDA4Z0NuSlFjMFpXTlpLTnRUakla?=
 =?utf-8?B?N0FSU3JsTWFSSEdRTmJRKy9qTzd4aHcyZ2Q1VHVEV3BZLzk5U2F3ZE9VYXQ4?=
 =?utf-8?B?ejdvbXEvVjY5ZW5mRFJmQnZQV3ZVSDJSQ0ZEU2dUQ0sxdXh0T1hranBmdXov?=
 =?utf-8?B?UUdkbk1RbGVncGUrbXRwSHVkaHFWMjJGYkZqeGpHQkdjYXJjeDRCdDJIU0or?=
 =?utf-8?B?dnYxQ2NPK1lSSXNuazdLS1Z3OGZwQ2JzZlZPbmZ4WlJSbWhlUytUeTRvdms4?=
 =?utf-8?B?N0hyNFJCMC9Vbjh5R3lRQzdHcUVtZSsxcG1QSEdTeE00NTlEajNaeWZtOUd3?=
 =?utf-8?B?Y2tYUEhpTk05Q09PMDE5UnFLZi9sOFFxK1NaRkVEcGp2RHhQcVJmWmo3NU00?=
 =?utf-8?B?QmJyRTE2bWNqdW9VTUZQL0FvQ0EyamxXNndKZVZyS0w3YW1wTGtwNThuVCsv?=
 =?utf-8?B?ejgxVGVxSHhMTUFkeGEyR1gzcXc4R1JLNStrMGM0bmp3YkpkVzB1dHZZRmo5?=
 =?utf-8?B?Mjl0cG9jazJVbDdnWHpsVE9ORGcvclRGOEl2T1ExbUJmRC9ESFhQcGVsRlk2?=
 =?utf-8?B?YW5qL2pEQ2kxVCtiU3pJNGNGL1drNkpXVEFTWm1zQ2hCU2gycTJhZUhUOFBG?=
 =?utf-8?B?NmdoYkhjZFdUUGFvaklhRm5PeEMzbzdibC9nQXZYclYwUXprWUJHWFUzUjR2?=
 =?utf-8?B?cjZJSVQ5NXg5eVg0QS9HWG82N1lFcVRpcEgxMElBczdjQXphT1VsTytFS3dF?=
 =?utf-8?B?MEpvZWlhdFpBVGZ0d0toK0ZvcHRRTmVqSnhvUmRuUlZ3RnJFOUVRZE5kVTBa?=
 =?utf-8?B?SFk2clpoblVCOEZGRFVhWTd4MWxjUkYvMUhXaFpwZ1RkUFFCYmNPbDFIZWRn?=
 =?utf-8?B?eUpVSTdOVFg0b2VDOUYvdmVCRWlVQTRzNVhrd01pK21MRGx5d21vNXpxR0tk?=
 =?utf-8?Q?fQDSbK3P0bm6V2mp4BQqAFc/A35uaDlakDO1s=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OElIUVdZQzNaZW5SbnRKazVYZERHS3ljNHl4Mzc3K2c2aXZiY1o2QkJ0V1hK?=
 =?utf-8?B?c3hMcmxDcW8xYUZESnFNaTcyOHBBd3RVY01xRTVzcHFUVU1PVjMrNU1lNVEz?=
 =?utf-8?B?bmIvdURNUG40eEo1ODllU21DakN4UlVFSDlxZWhHZ2xGVyt0ejVvS2ZHS0k3?=
 =?utf-8?B?OEhUZlJldkpTM0hZTW5xTjhCYVVIRi9zTjFVY3ZkMlBQdzBkUHlsbndUdWVW?=
 =?utf-8?B?b0V0c2t1RTVxVSt3OExXYUw5Z3BRQ0RudTdpOEZPdXRydWJoaHk3bzZzMVNO?=
 =?utf-8?B?UU8zUU0rTFpCQjRqM2UxS1duNkpwVW94K2FGWmpaVm82NG9OVFgzMHZIU0FH?=
 =?utf-8?B?NWk5L3FrMUlPank2RVRDdVJRR0lRTEE5SVh4UFZ2S2E0RzVjQ2w0ZWUrOUha?=
 =?utf-8?B?OXUrZkZQRk9HU2ErWElITXdCUkt2ME5acEltTm9TY0h6KysvR0dYVlJtZG9p?=
 =?utf-8?B?dzR5a2hzdHVtNjJVQnozTXdCZWF0aDkyTUFDSC9kUVpKZzVUYm1mejZmTTlD?=
 =?utf-8?B?R0VDWFdNVGRaVllmZUJjTjNOSGlodDJhK3pNclQ1SVR3ZGpaQmYwc2g3cFdr?=
 =?utf-8?B?ZFJrNktzdkV4VjcxaUZ6VDdWUjNyc3UzNkgzMGhveVRXWENrQk5naktRVUZX?=
 =?utf-8?B?QnFTTSs3ellSR1pXMkluOHU1R3JVa3o5U05QNGhzaGI0SThTNGwvclFWTXZ4?=
 =?utf-8?B?RkpIRE1jTnU5aFptdTNteGRDTlo3RWdHNWtkZlZVRTJmcDdyMUdlU3JKVVRa?=
 =?utf-8?B?K1BoWGZqakZzaG1KZ0lRRnhJcFBDdVBMWFNrbGVaeUdRcHRRNHRnazJWWnc0?=
 =?utf-8?B?QXVTSWhFRXNZT1dUbHN2RkcrSWQ5d1h2TUZ1WG5QU1p3K0ZvalRqUWtvNENs?=
 =?utf-8?B?RCtjRzZncDlPZ2VlRUFQaDJjT3JnZmhYWFQ1YWp6MkYrYk5uSUYwaGlXZ2sx?=
 =?utf-8?B?V0Yxc3hzcDM4cEdpeHdlaGlOZnExU1pUQVZDMlppdklYaUF1REczQjN5S3Rh?=
 =?utf-8?B?dU42YTFraWxZVlRTbjFmR2FYVGFhZUQwZHo0dE1RTEhUWFhNb3ZHMlJYMldx?=
 =?utf-8?B?SXVFTW9aY2ZzZG5ydUlXcFpXUXZhcW5JNWRkUnVmVThIcXV3NThQcG0vZEM5?=
 =?utf-8?B?Sjh2M2QvS1lqWlRvUzJLb0lQcVRzRld0bU0valgrMTZhOUtCOXRYQXlaNjE2?=
 =?utf-8?B?dE5nMmFreTJLUVU2NUc1TXRuR3dGQWk2N05oZURxMFhJWkY0YTFxV2FVYzR6?=
 =?utf-8?B?T0dBendMNGdXSTZza2tWREx5V1FySDRLcDdYaVhCampzT3N2MTlyYktiNW8r?=
 =?utf-8?B?Nk9JQm1nMENlT3l0MDNJMUxrWEwxYXQ5REVXQlZiNUNMWWlIdkt2djhwSWJL?=
 =?utf-8?B?L2RuL2FMNjZId3hRVExRbFlaNmVHR2JmQUZ2Vys4TUpoQzVPZjdYM2ZNNm1y?=
 =?utf-8?B?QUl4eW9jZGlLSHBRTm1zS0VIQWpwK2svOE05MlpmaElXbUFmTFFid1Blamkv?=
 =?utf-8?B?RFhIZmR6Y1ROand6WUNKVVJQVTNFK3owdzZoRUdQVmNkT0RVOHBrVWhjT0RZ?=
 =?utf-8?B?SGE5K3NaYkJqaXE4TkVDQTZic3UvYjl2TllsNkhCYUMxYUErMUMvQ2RxcWxJ?=
 =?utf-8?B?M1crY0g5WGlZVkVjQ2dodFZNdzJrSnd5TjlGcCsvd1RYT0NnTUJOcW4rbUc1?=
 =?utf-8?B?YUtUM2FuNm9Na01EWjVpTkFlUEc1WEo0d1ozT2ttOVpPN2VmNjFUTEdsOWlv?=
 =?utf-8?B?TjN4SzdnTURvV0JrZE9aeXVnRnhncEtpRkJRa1p2MDFOem5lZ0lNTU1OMmZ4?=
 =?utf-8?B?d2pOVzdpOEN2MXBTVnA1ZzYyMjUvemNIRjIxWGFPcko1VWEvNU9OQWh4RUtY?=
 =?utf-8?B?ZnU3b1g0UzF1d2U4aFBZMmVocFkzSkE4L3BDTzZCNDhrbHRsQ3hiTHk4S3JJ?=
 =?utf-8?B?TEw0bmIwNm0va3dpUUVPV1FNSC9zNmovOEs4NVh4Y2p6azJWdk8zc3pVc1JW?=
 =?utf-8?B?Ukhpb015VU84L0MzSUFpLzFEdjZwSTVCcy9zdDB5ZmlzRElMb0JjTWdoaWpX?=
 =?utf-8?B?K3duTzZ5TDhLS2hmNndDcHpVMGxSKzQ4WVFzZERrRDRZYlBGTlQ0UFNyNUZ1?=
 =?utf-8?B?d05uZEdaaGFMTTFTQlRieDlINUJrc0JlTzhQaFM1UkRMZ2FoQm9NSmdrMGFT?=
 =?utf-8?B?R1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3cd4f2-c053-41f7-2473-08ddc069e117
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 10:58:34.0607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oYbj97TitMunPHQssNF0pj1PS/Rsg1veoRB0dC6ZJygSlELOD0s0tewYc7jMGkxocYAL04FaHUwq95bc6GdIpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8996
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Jul 2025 10:58:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19396

Hi all,

here comes rc1 for the next isar-cip-core release.

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/archive/v1.8-rc1/isar-cip-core-v1.8-rc1.tar.bz2
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commits/v1.8-rc1?ref_type=tags

Please test carefully, specifically disk encryption! If nothing goes 
wrong, the final version should be ready by next week.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

