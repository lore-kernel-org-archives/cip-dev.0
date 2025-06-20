Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3497FC7115C
	for <webhook@archiver.kernel.org>; Fri, 20 Jun 2025 15:28:36 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.30])
 by mx.groups.io with SMTP id smtpd.web10.3001.1750433310817230602
 for <cip-dev@lists.cip-project.org>;
 Fri, 20 Jun 2025 08:28:31 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=l9eTcDTm;
 spf=pass (domain: siemens.com, ip: 40.107.162.30, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UkkmYRBSuwu7nbfkQFRLYVtG0nAZ2SRgtLBgMAJkbeZT3Ab4VJhCOqpVbeo2LfG1q2fgPoKfu3MHeJGxvjcmkkS602Ln7ehjZ5QQ1m/W/vCJFB/Yb0/zXZQobKyUKiyWjk2cLEEDJo7MJ7GOT6bJnWR71vn4bUM7zGj00+glG/lQZk/ZmJFCsGGl40hwm9E/PnJd9z+xbWz0bJvZ5HSiYbQ5ta3/YImA+jKTIKd0PVZ5py3J17yrTEDRTS18h91BjsmnDJUnhA0NXC6n2DYlso35j1V3VrNdjOv4MP6xBxvRGM5odO8lgl4SPhM+vFjIY+pylt9N/Y0fGze78zFuBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7n4cvS3Q/5geNZPkm9A7yDk5n/U0d9/0wZ/zAKccPaQ=;
 b=jhHqK/wZSBMSUis6E0sNdFc5gMbEF/GukoOqzLpjYuuk0O7Do439lwhQqnCGSyI12GttcRQ1EFG4T52A8hx6yy+kZC1zke6UJWo4sJrPm7r8/Hnc+j1Jy+fzZ6bSNpe0TSfi2FHifSXQyDF7EHfW4Yw6qo05nXZX8ZBxhbb0ST53FlZfpQlBtI52nn7qAycvEtRBsds+mCw2KPTDA7A0L5fncA5UVaFlc90Z2Xq3IK2XbsQe+rziC0gvAU1rXZfwhHScYZDheJhm1a8sGFqm2aFqI0twh14XrOWDl4SyuaWLVhM7s+1zRwz0VnQocsTAM7mhDsV5cAR6ODV+KiQszQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7n4cvS3Q/5geNZPkm9A7yDk5n/U0d9/0wZ/zAKccPaQ=;
 b=l9eTcDTm7iWqD3jMjbXyaOafsNnlO1CENUNOCBFL60vXPK5Tc35CgwE8s7RbVzkncuMt8QCZUefxIk4iwRoJLVk3GooNG9FjJRSzIba/KsN69PTH5k8g8++w/6ZOtKkNengSTv914CkRsGXb2KuAX6Y7dXKBkirbGkt6VYLQPgxFUQW7f6GjLEtW5sMd1vHqLTC1ASWb1m4vnj2yziDlTt+03xSYnYnknnwj+uQFpXvwmv9hdoxupwI5l8BsvIYcchVvGN3J7Yyx4ysf2DBkrmj7FRT4foiWjVbOlrMg2pMP4rmAD4K3XMUeEeC1ONqpdo8nOzOLZDZ9MvSfasUTCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3969.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:157::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Fri, 20 Jun
 2025 15:28:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8835.027; Fri, 20 Jun 2025
 15:28:27 +0000
Message-ID: <c966af1b-24d8-459c-a423-363e55d7c3d4@siemens.com>
Date: Fri, 20 Jun 2025 17:28:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] Testing 6.15, bbb target has problems?
To: nobuhiro1.iwamatsu@toshiba.co.jp, iwamatsu@gmail.com, pavel@denx.de,
 pasquale.nieddu@siemens.com
CC: cip-dev@lists.cip-project.org
References: <184A639C5862A401.23068@lists.cip-project.org>
 <aFPR0THrbjSZ5m8B@duo.ucw.cz>
 <CACe6DC5N2ZHbYrEsPp-3reo7uy+iZ1NYmAPEvhdnhUo8Sc=rpw@mail.gmail.com>
 <TY7PR01MB14818F5B189840E46ABE6F827927CA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TY7PR01MB14818F5B189840E46ABE6F827927CA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3969:EE_
X-MS-Office365-Filtering-Correlation-Id: 692f72ae-013f-4ffc-7e00-08ddb00f1a62
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?NoXU3hT1VqG4rkUCNgJ25WsIqxLixD5uLxOJSVcYa7MnfgSmQlkumUSA5ha6?=
 =?us-ascii?Q?wd22qztNB820b1/wJGrclfxffR40wwciRw01u77pc/mP352GbyoNT14ykoFy?=
 =?us-ascii?Q?csmwZ9Ht1j7dk98jeOZ2LAziE+xj6EuJ3SsE9MSIUIUJv3ootun7wx1yY6IG?=
 =?us-ascii?Q?dAe6SVynxaREB5QL3u+3lfOl8hOKttZgHSYLi2tPHXqEOihUW2m+t8sTYgU7?=
 =?us-ascii?Q?6yul9oRUo/uQRDJO65cZzBVyI5G/8QDOggDLBTYOw+GLszu9hVBv/r+HFc1e?=
 =?us-ascii?Q?uquaH5ne8d7XnEfgPwzMatNfZ38AF8BlcrWyszxHIvTldgwUyHuRbCTs5sUV?=
 =?us-ascii?Q?YKNqu8lWNTz7xNxKEmLigS5Uf1x6vfv+BRuCpVBh0+0V+A7IjENtBkkrbRk8?=
 =?us-ascii?Q?AojelCYoBih7bUDZWhd6Gw4HkKSiZPgqynvo749VegMOberbdIlg6t3BkJ5/?=
 =?us-ascii?Q?iCY70IUi5nqjWO5esT9QfrcdTm1bgd/ffYUlRuxnJPArS023SFsXsTeE/6My?=
 =?us-ascii?Q?DiFP5lPAdr9nFipChIhgfWamLbnK2tly3LTQ/6+zixV3W2hyFgwmS//zuB59?=
 =?us-ascii?Q?jgM9uJ0NgY2CJEqUEE4teF/1dzrR3siC00kzQLb6uq5VLdPFIx1LuZ6zmInX?=
 =?us-ascii?Q?28TJIoAoTXxZptFxPBfl7as0L3w6biSoRfyziRXr1me1pm+bc5vxgr4x/pYz?=
 =?us-ascii?Q?qvDQrqRAE40VSldoBOHzktmgc7/KC4u4LNtXiEcJO+kZwf3ZCKtiSj6xHRRd?=
 =?us-ascii?Q?jBL12XR7kC4rq4iuGLkRvnWTwtHpYofzil7EaAzY7nubCso/2Un40je/kFrw?=
 =?us-ascii?Q?NZjrI8+e39YGLN03IS03cBW5KwXwt/8FbR5Ffv1khm++81oxWEwaqgfy95zb?=
 =?us-ascii?Q?1YhU/GBuVBOLY80rcjtRV07m5LNrTPgqyXCfMttkxcwcJpX+zND/WnQQJ2jS?=
 =?us-ascii?Q?BgHozqi8/T9u9LEM4nmapkFhs95w4KLtmm0EYvjSC7j9RnlwM35CGkrf8eeU?=
 =?us-ascii?Q?gdw6YgATuroNqDfnEd6XQzTRt5T3lEdJgsFAvlHfpT+0ZeGgqbJ4Yj/13wIX?=
 =?us-ascii?Q?oZP+a8m3a6yTQ0ZaKAPYV6Iop3RfzZ77ileFqcI+rZLi8vNajci73u0XqcWR?=
 =?us-ascii?Q?mEQ9mK/AVTsYK64NiHFncYU/laHH9RroR0pntyGw4P9mlnkvR5CVTQPaaVUW?=
 =?us-ascii?Q?o5bO0NJ+sRVAQp5SwmpgMUJXJtmEiugTL8EkxT1Iz2wEMkmXUwP7XxjVOljj?=
 =?us-ascii?Q?t6KbrjPIGtabzBY6UpT01g1xo0lm1Zt/hGQkPXy6xSHUeFzCRSbF9Ki6Y9hf?=
 =?us-ascii?Q?4EPFfyQ9EjR0rAxUGMt4EnCgdgohL+6Y1NJrpcTAWYvF7MPM2Q3m9xvJttQO?=
 =?us-ascii?Q?NGsA8YA=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8DF+TtZKt4VS0jgST20MVOcB+nGRMW55U770clOt8++/vXxu1nRVK0ul9i8/?=
 =?us-ascii?Q?bo8LBF7WZdi5UWsklmjz6Y4Es3Zo/lRnLqH9IwGe28vgGt4F7okjjsjLYc82?=
 =?us-ascii?Q?R25eLujnttrqoA9J4L1DbPAkNrTAE3r22/MAuoB5ZJdIaUGyqhqTQtfil0yp?=
 =?us-ascii?Q?GPKR18HrZTUUOe/GlcZLuFByo4UkC+xWndhGyP1Dcf4tooPX0qDTdfYZPNhD?=
 =?us-ascii?Q?hE9xY7OpFA17Ol522XFALn9UfD4SoleFBg48bYMMJZCHM9k28xwc/AHzUpOr?=
 =?us-ascii?Q?XwUQ5XtzVPiZ7Ta+hzy2FvVj3OKi1vVSS4P9c8RZeMnDp2nQDo4thXQDdQbG?=
 =?us-ascii?Q?2kMFZn6jE/hpUW3joVHi/5FJaJzn/qfRd8N1AwO2JOh354NlB4xT7TlE6Hap?=
 =?us-ascii?Q?sknaHhZii6LRndgEDSk2x1CYD0sOwR43fPPSlceN9gJDFxAwJ1ImEyXeCAJ4?=
 =?us-ascii?Q?Old4PBnz9hO2jgCcMEl8ElK8p7Y3eF/DjrI50ejapsf7GTMPa3huBydujOjl?=
 =?us-ascii?Q?MHLleBkqwxZWG+N83xbuoVgJLpoMp72wvQ04by/wruFTpPV5HUSZ5c5WM40z?=
 =?us-ascii?Q?532U4+v4B7Bzuqmr9L3iQt/n4v0T40RLcrdcC2TjYEs+lD3T8k0+5tfS5juk?=
 =?us-ascii?Q?5LXOBVnoZ2gJaNAZFNN8GLQ67Ab8GO6CEuGGeRL+q3xoEtA2PCWebzfjbMcT?=
 =?us-ascii?Q?WxNPuI7FKBgI87MbjwMMEgaGvDJnhq2Wq/6+9Yfqe4ktkOsKg4CYd/+G0ybR?=
 =?us-ascii?Q?Igpo01ao8Ws+Yv7plzNzJR6CZq1yxSqTqv77MoLzWkq4WUfQwA8UpSMYjtuM?=
 =?us-ascii?Q?Y4lbxc2xS9yaO0C3k5LCDxzUV46s3tIVIm0owAgP3Y53SASrEBpts3LD71kG?=
 =?us-ascii?Q?jMCTj/4RLtNAz40iJL3a8KDJvF+5ucYec+eHYb6STlG9II3AP3PNK/SUN8XR?=
 =?us-ascii?Q?YBPAuxhi5GasbeXs1n675qM0BBAfPBX3k+wbxB08FWA05ynGNlgfB/Z0wg+L?=
 =?us-ascii?Q?GHzdRQBaH4TFlNbKIRKAkHEN9exCSYEzk+I2UB0eYLOzrcNG5rqpkCiSx/IL?=
 =?us-ascii?Q?TuGZtQyWrTuqvsf2TphOacH/XAhQMaasg9Akfmiul+P4sTYIAMXd+Oshi0/O?=
 =?us-ascii?Q?nRdD7sOclVHTNmD8bRWap3SAL+UiOLsMvRVjnl7VojOwTggLJQd7sI6BEmdy?=
 =?us-ascii?Q?FRhHo5mAhvELvQNm0BwtG6bk1/YuIex/6RE79cgN/JkoOQSV+gNZrbZdeFyt?=
 =?us-ascii?Q?eQYoMK//D/0f8HpCK3JP09e7Ms9c/Os5bGgLPMy+T3Tt/ibJMur9FAInw9wi?=
 =?us-ascii?Q?452RB5AhE26CVcAyevZEtMPngoTsMWSTcMb154gKsE7AZhs5SijgDXZTkaAM?=
 =?us-ascii?Q?Jv4iZQML3TFVAkBvLXaXIy/Ufz99GOUIYGi4CA4T6kT5CeqjW+3KV3otidpW?=
 =?us-ascii?Q?xq4yj8TYPcMNSfLdVZD6EXtWBNoH5rb1+qJWrtO2GOKWBy4U+8WhmqKFRRcJ?=
 =?us-ascii?Q?AqZUT5vMt93/eAdGajfNCVB/pWwWr5E/uyejs/emK+vRTqlXB/+xEXRZCqe4?=
 =?us-ascii?Q?+4dn5vgG4z6TblCZK/259+HQufOZWTX85JtC0yME?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 692f72ae-013f-4ffc-7e00-08ddb00f1a62
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 15:28:27.3556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NaXK7NRIbTc2mt2LB5h6Zk1419s7N1Cscjy9SUs498pZQXF1ixqrg+KGxn7thWVkxIVJ/tR8pnLEGAuJEtjR4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3969
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Jun 2025 15:28:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19155

On 20.06.25 05:10, nobuhiro1.iwamatsu@toshiba.co.jp wrote:
> Hi all,
>=20
> I have applied the patches and tested them. The problem seems to be fixed=
.
>=20
> 5.4.y:
>   https://lava.ciplatform.org/scheduler/job/1283628
>   https://lava.ciplatform.org/scheduler/job/1283649
>   https://lava.ciplatform.org/scheduler/job/1283648
>   https://lava.ciplatform.org/scheduler/job/1283629
>   https://lava.ciplatform.org/scheduler/job/1283650 / NG (lab-cip-siemens=
-prag's BBB)
> 6.1.y:
>   https://lava.ciplatform.org/scheduler/job/1283661
>   https://lava.ciplatform.org/scheduler/job/1283660
>   https://lava.ciplatform.org/scheduler/job/1283658
>   https://lava.ciplatform.org/scheduler/job/1283662 / NG (lab-cip-siemens=
-prag's BBB)
> 6.6.y:
>   https://lava.ciplatform.org/scheduler/job/1283657
>   https://lava.ciplatform.org/scheduler/job/1283656
>   https://lava.ciplatform.org/scheduler/job/1283655
>   https://lava.ciplatform.org/scheduler/job/1283600 / NG (lab-cip-siemens=
-prag's BBB)
>=20
> I have submitted these patches to stable.
> However, the problem still occurs with BBB at lab-cip-siemens-prag
> I think there is a problem with the NFS configuration for boot paramater.
>   https://lava.ciplatform.org/scheduler/device/beaglebone
>=20
> https://lava.ciplatform.org/scheduler/job/1283600
>   https://lava.ciplatform.org/scheduler/job/1283600#L567

Pasquale, could you have a look if there is something specific to the
Prague lab? If you need support, let us know.

Thanks,
Jan

>> -----Original Message-----
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
>> Behalf Of Nobuhiro Iwamatsu via lists.cip-project.org
>> Sent: Thursday, June 19, 2025 10:49 PM
>> To: pavel@denx.de
>> Cc: cip-dev@lists.cip-project.org
>> Subject: Re: [cip-dev] Testing 6.15, bbb target has problems?
>>
>> Hi all,
>>
>> I've looked into this issue a bit.
>> It appears that this issue has been fixed upstream
>> (929d8490f8790164f5f63671c1c58d6c50411cb2).
>> The patch has not been backported to 6.1.y or 6.6.y, where the issue exi=
sts.
>> I will apply this patch and test it.
>>
>>  - 929d8490f8790164f5f63671c1c58d6c50411cb2
>>  - b9bf5612610aa7e38d58fee16f489814db251c01
>>  - 623cef652768860bd5f205fb7b741be278585fba
>>
>> Best regards,
>>    Nobuhiro
>>
>> 2025=E5=B9=B46=E6=9C=8819=E6=97=A5(=E6=9C=A8) 18:01 Pavel Machek via lis=
ts.cip-project.org
>> <pavel=3Ddenx.de@lists.cip-project.org>:
>>
>>>
>>> Hi!
>>>>
>>>> 6.15.X is out, it would be nice to start testing it.
>>>>
>>>> Plus, I see bbb failures way too often. Any idea what is going on
>>>> there or how to debug that:
>>>>
>>>> One example is here:
>>>>
>>>> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipe
>>>> lines/1874747536
>>>> https://lava.ciplatform.org/scheduler/job/1282821
>>>>
>>>>
>>>> [    3.556545] Sending DHCP requests .
>>>> [    3.567340] mmc0: new high speed SDHC card at address 0007
>>>> [    3.579884] mmcblk0: mmc0:0007 SD4GB 3.71 GiB
>>>> [    3.590452]  mmcblk0: p1
>>>> [    3.600982] mmc1: new high speed MMC card at address 0001
>>>> [    3.607395] mmcblk1: mmc1:0001 MMC02G 1.79 GiB
>>>> [    3.615388] mmcblk1boot0: mmc1:0001 MMC02G 1.00 MiB
>>>> [    3.622199] mmcblk1boot1: mmc1:0001 MMC02G 1.00 MiB
>>>> [    3.628670] mmcblk1rpmb: mmc1:0001 MMC02G 128 KiB, chardev
>> (236:0)
>>>> [    6.136382] ..... timed out!
>>>> [   86.523950] IP-Config: Retrying forever (NFS root)...
>>>> [   86.529327] cpsw-switch 4a100000.switch: starting ndev. mode:
>>>> dual_mac
>>>>
>>>> seems like a network problem.
>>>
>>> Another example is here:
>>>
>>> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipeli
>>> nes/1875019823
>>>
>>> I can retry, but it can take more than one retry to get it to pass.
>>>
>>> Best regards,
>>>                                                                 Pavel
>>> --
>>> DENX Software Engineering GmbH,        Managing Director: Erika Unter
>>> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>>>
>>>
>>>
>>
>>
>> --
>> Nobuhiro Iwamatsu

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

