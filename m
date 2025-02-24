Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBE5C021A4
	for <webhook@archiver.kernel.org>; Mon, 24 Feb 2025 13:18:36 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.1])
 by mx.groups.io with SMTP id smtpd.web10.88417.1740403112943680334
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Feb 2025 05:18:33 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=g11VTGHK;
 spf=pass (domain: siemens.com, ip: 52.101.70.1, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E7+i3ZJaT12hv/OH2UbcvUpHZOiQ3AGYopwy3+kgMIlLnnWb21VNNmQXvOPEdj1Q4X5VlY7rRB0Yymm7JQ/ea6DP67xqeDacTvlRkzGP9exizZ0KQ6h89L8Lp8B9PSnVYrpJTtKcXWlB/EZ3KVtff34bdKbzaxu4a2aidozdbYc6yIo7bDf6DzCbTUGX/ki+xjw+Lbb6wKbqM5aHru3CEiGbBvyAwSLYaa2WGAFTGjjyw/R8P+gRbzspExWKL1/pHQoMlbtpAGCRaRw/Q5X09nV4eRM7oFOyDM5adXYwxYQaqkG9KCN3CQMjBi5R98GJw6OS0xYd1yOf2ncFcsVw8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKuezO2fh8hkdpztAcwf+KqrQjKHUD2BC4JuFNdyCMU=;
 b=TJyATdZ+erdsg6RMYVwCMGjcYAmXrVUjMr7Xry94V9ViKjwyvbfU394l/8DNze0omcgNXjI9WOHiHk8cI0IBhye+P1S8y3W82bYg1E2VAE6cz+rBr5dBs3oLhRrXxsOoCShW8lBm3Bofx4HpDSFSsKTI9f8SE5Y2MnHsi98saDZ2w6W1VN3wtcEnVMsLGly4n93sk6N7aOlfKE2JbF8fENLKxzeZT4WHUnRZXbJGT0nquu+dS9f8Aam8zsJiwOWtzRZMs+GcPq1QqBCsdBE5606BUT6/we3oiMaJTYeAVsBVAEWDvh3pL94Hrljsv76PqorsyQlQP7sAwdy9cayjMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKuezO2fh8hkdpztAcwf+KqrQjKHUD2BC4JuFNdyCMU=;
 b=g11VTGHKk+ypoiQC70kQc6EKZE7GecZgDKyjL4PtwWcPQMxWsr0tSU3/0+nIP96NkRZ+UZW9uYVAbpEx+HxyCAkdHCRNIERkgS1ONluR3Nv4m4Yx8cXLFIplZ3DNud6SXT9esduaFgn7ed0GKWSAgQ8K/AaCwD1FxAKWLAl7ubIIegkgRMwkbUKRtkRo0KMuNlGtE6gQC1eLkmSLeAQX/h1X5GeWKuA0jg0HUGvVuvGyDDklMkktmpQuZ7pxkFf1uuPbPIX0MvN9EtsF8rXRuMq0+E/Y0mhPf6hPfZdTxppSWhbKpf9im4yDbf9Oshlc+z/kO6VZTFsIcrJ92mc/SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PRAPR10MB5180.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:278::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Mon, 24 Feb
 2025 13:18:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 13:18:29 +0000
Message-ID: <5218fe69-939c-460b-b1db-ea8a48a292ef@siemens.com>
Date: Mon, 24 Feb 2025 14:18:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH 1/3] Removed "ro" option from
 read-only-rootfs's fstab.
To: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>,
 "Gylstorff, Quirin (FT RPD CED OES-DE)" <quirin.gylstorff@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20250217100024.42995-1-alexander.heinisch@siemens.com>
 <1824F69F112B9158.31881@lists.cip-project.org>
 <AM7PR10MB33205157A04B7C1290C1B6CB86C72@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <6fce5303-59b6-4aee-b60d-d0d25c8a3a2a@siemens.com>
 <2010c1c9-c33d-48fe-911c-4d4dfdf46d0f@siemens.com>
 <f05430e8-0a36-42bb-9c67-d6ccf60c0ddc@siemens.com>
 <AM7PR10MB3320A04B717DF98709A7F9C086C02@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <AM7PR10MB3320A04B717DF98709A7F9C086C02@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PRAPR10MB5180:EE_
X-MS-Office365-Filtering-Correlation-Id: 99558cd8-7491-4b62-139b-08dd54d5bab8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?6qiRdInbHoHpebZKYbEQ/qbSzqpkIG136wUbS+05sAWy/8WEszUWsulUj7mU?=
 =?us-ascii?Q?5z+byQ6SEAmVShAweJUPRvda/e02o4+QCvcX9ccUn3lVbp0lO4iAuWkchBzD?=
 =?us-ascii?Q?tCsQN880NTCLyMB2Z9NFOZZg9RAvuTmgTPAkjr/aDiWPw62gYS2rSSR0n7nI?=
 =?us-ascii?Q?clZszIc3wNvpuSg6bT3N3Nqxg+RNefTS46ML+Bwysa+o5eLjJ7wSovY7+HSH?=
 =?us-ascii?Q?W5IBwly2QlP5FIfiX/XaymUl/4wnP82a7B/VA9+/kiWcS+A4qf7HKTbXSu8S?=
 =?us-ascii?Q?YmMdUPIAVGrMtJ5YT33CmbtBXgt+r81smqZqAkLCg3bukanJFCoSacjXiNd4?=
 =?us-ascii?Q?8ysiDM3qV/e0+/Q74jQUuhWvktXJKSwXTKDS84kydu7D0eUDvp7ImxcvkrS5?=
 =?us-ascii?Q?Ad2WvBCz54sY3sLGeHUJfBVs5gnnR8bEdGAp/u/TwDo/D5T6Lee3NYAyLhEV?=
 =?us-ascii?Q?V6fHrDOarOEUPsE0/3+ftYnB6UVVLb5+pL76weMmMQOJZYI82hGt/r+DkCdS?=
 =?us-ascii?Q?7HXoRQVelJhbAdHezzRgdrzwYGdwqrsKduOOhv69bbI3HFymoddYoXOjN4ts?=
 =?us-ascii?Q?gBvXNf0mPktU18ZUBYbNczMGd6z+1ZRvmt2xfb7qPlonlAIKnHS38OmtjAOA?=
 =?us-ascii?Q?kLXQBtlESp6p7oiRJ5iJP21ixXvvsk79Emc6qMgCbV10dcyC0B7lJ+V5DL2x?=
 =?us-ascii?Q?czmoulzEBX2BB7I47lYguelt4iIbeT+IzRFXtP3zJmHClzzIuijPxuwBYTrE?=
 =?us-ascii?Q?Eb3u9zWs2RUdsB/5LlTjC6MRRGxzw9BcA6Hb5MnfMF4N1jFGmTad7JJL88tW?=
 =?us-ascii?Q?+nB6ifGntyAVRdH50nLt4OPO7zryshwF+CIqkSpDk8cy9zKYPzxwBDbGIsjS?=
 =?us-ascii?Q?cUmBhfDllVbVx4edcGmuPCsE+XvfHXlXx8p5MdYctS3Jy4koFv6vhTkZOvt5?=
 =?us-ascii?Q?6bPAe6hZP3IhlHxgU8HFVUQWAhbDTH4mykFhatUEeTNC4LKKvnRe/ZoYQIBi?=
 =?us-ascii?Q?M5wvXTG/4VOHwYws5MXyBK8ohGp0/Qc+yjJWMgub5wbme+xsPioqUGgs3VId?=
 =?us-ascii?Q?YwxIVvbtmXc+JFnM3iZm2Rku4mZMSA4IYSkjzGWhSvWDkGDm9wg5uqMFy1LJ?=
 =?us-ascii?Q?1G1RLZTOzoHhlU5pWxajS8Kw+OP3TptRsNyz0d3c//mI4uLM/WfY/5cJm4+j?=
 =?us-ascii?Q?l6hWokUkt1YNOXz2DXQEUAH5VCC6ur1J0B33/3VumcJOuIGjxDUzsWMjOFSa?=
 =?us-ascii?Q?IcIZJDUR1/HfXKma5kJJPF65jynJyuKJkd/9QFhAYuVS6qEPkNwCt0BscONI?=
 =?us-ascii?Q?IVrjRQgExJ/SplG+0VUhL/RA6mCS2w2++jti+zp0ullLERjJWlpVlBHgynDQ?=
 =?us-ascii?Q?Si3kjqCgFqgsU1liDRQQptlJQv7r?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?q0BsCNdchZ2/9kp8QXmC3ZjLrT5UaR0KI+QVZH4Ggw5NPrVNkumNIZP7QFks?=
 =?us-ascii?Q?WVzZMwhiDQPD8B745n3BqPjX68gv609zcU/OWrODxnMYuM7Y9KuSvjJT6+dd?=
 =?us-ascii?Q?n8m88QPTSBUh1p17OyJw+29UbU6z6GM0oxUQXxqmHqhUFfqpg9wyz+Le945B?=
 =?us-ascii?Q?vGblGceeXOzVC4+0GjXFx0nIZ4OPflmxjDdc4TuRpiAEO+IHH9DTycmF3Ea5?=
 =?us-ascii?Q?5BiC6btsB+XXL7UETHZZDXdVfEnq51DhuPaVbWxoB3jOZg7/lq0Mqhiy2sWP?=
 =?us-ascii?Q?djA0vLZjSYYhPSqptwgrXp7lXgZ7d1nY811+AQEZG19FQOv1ThzF3OAJRFWA?=
 =?us-ascii?Q?/MVWzYHeTiMFo0sqXZZuAQ8tUF6NrNNFqqwjC11ftvDe/zzAajRU8eO7mcTy?=
 =?us-ascii?Q?lC29IHA49pVhnc8bLD//e1q71hEuflmwK1/ccBxOXeO5Kkch0A4/5es2AiOi?=
 =?us-ascii?Q?FtNVt0m9ZktYuWgDmZ5h9GIdQRnVk9XzWzuYBCbm5EEkH2uPgK75F2iJBPtQ?=
 =?us-ascii?Q?bnGYGBpVEjihWUSB3PioXwziZSk7D2eFx0VkW8GTT5gqoel4BxseQFZoeUTz?=
 =?us-ascii?Q?8qURIIXAQEQcqjqMxafd6zBkE2OezQ98vF6XtO9M/7L0VItoYirlLItJxi0x?=
 =?us-ascii?Q?w/j/BjLTaEc1AHVpPnSG0fNbh9KgUNW7W6u7Jk01SW8+ihSCHgH+LFXYLvNR?=
 =?us-ascii?Q?9gLMo4xTn4jufqLSTrBZbxwVSwmVtZ02ZpxYnRXptUVXDiIRCE/0AjQwBBJV?=
 =?us-ascii?Q?4r+UOuF7Qnk3VzxsGG/gdDb0KKgfbqrGlakzcK0vYyFkicv2M9sjHiKCmTZ0?=
 =?us-ascii?Q?OGahV8/wQR5LdjHV9q6tuUfpAqpUAbYalkKmrcvdXMxLdLkIuliRNkgbFDRU?=
 =?us-ascii?Q?Ss0NjTHctZnmHd/vBZiFG7qeh5shbK3eOR2pl1GoEb6HN5eJtW/ffSrDvrl6?=
 =?us-ascii?Q?I9sOlDSPvMn4BzoHyC23wUzO+LF7oFfvX/IZMpUnqy4tetYRLiAmUpyhXgug?=
 =?us-ascii?Q?V8t4olqghPyiww+o4tN3J0nI8YKUmWUNZryRdOYg69TsYWo3+6rNBtTeFmR6?=
 =?us-ascii?Q?Mk2vDkWRE43IMDrUAikRL7YwlwBsxyAxB2miA/qH9uXD9BUu7zWr5ZDO1Tt+?=
 =?us-ascii?Q?phcTRd/Eq0dAzdWjwrisaiz3LukflLp/VdgtpjlzdhHvOjaLyi3pW3+97pul?=
 =?us-ascii?Q?Z6mXVTKnMtqXndps2xD3HqL1/DumTehJuwjg/PR6ILrqoXbaK8EMATbD6/1i?=
 =?us-ascii?Q?yTf1MDL1Zi66Wt+CwOM6o2GSoynZDVPWFLt9Fpf2trkkAt1xYSvhGEdJMMde?=
 =?us-ascii?Q?/a85LL4sYZff3D7pdFrjIS4r3UQ5WeIHYPY63zmz1CR9s3SbgYw3u2vl3uho?=
 =?us-ascii?Q?BAxJqQdbyosP0TH/FgA8cKnElwxqItxgPrqrL6VtCDcUCMbWTxySGcDaONwq?=
 =?us-ascii?Q?oOT99HMD7LU77gRxZCma+wKeG2+vPuOvOxd+pOlFJZ02gbO/M/wyd6lLXXG+?=
 =?us-ascii?Q?ndlgmqaslgS60WNiN2c12frGfEMtEf5xCw0kgRl4URiPNv5QmdiAPvLXSfCU?=
 =?us-ascii?Q?DRL6kVVyEgBn5a/su8jDJJIrTIaRmvx5Y2nWKqzmG937QVaYZTvOjQt6pVaj?=
 =?us-ascii?Q?AA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99558cd8-7491-4b62-139b-08dd54d5bab8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 13:18:29.5344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CWPPA94+BzPi0WF7ehiCEerWgEDmR2O056cJjp1lcxphE2lTM6KBylAWA1/j40BR50TzaqHVwoVyAQVzV0nlgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5180
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Feb 2025 13:18:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17898

On 24.02.25 14:03, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>> On 24.02.25 13:17, Quirin Gylstorff wrote:
>>>
>>>
>>> On 2/24/25 07:09, Jan Kiszka wrote:
>>>> On 21.02.25 13:31, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>>>>>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>=
=20
>>>>>> On Behalf Of Heinisch, Alexander via lists.cip-project.org
>>>>>> Sent: Montag, 17. Februar 2025 11:00
>>>>>> To: cip-dev@lists.cip-project.org
>>>>>> Cc: Kiszka, Jan (FT RPD CED) <jan.kiszka@siemens.com>; Gylstorff,=20
>>>>>> Quirin (FT RPD CED OES-DE) <quirin.gylstorff@siemens.com>;=20
>>>>>> Heinisch, Alexander (FT RPD CED SES-AT)=20
>>>>>> <alexander.heinisch@siemens.com>
>>>>>> Subject: [cip-dev] [isar-cip-core][PATCH 1/3] Removed "ro" option=20
>>>>>> from read-only-rootfs's fstab.
>>>>>>
>>>>>> From: Alexander Heinisch <alexander.heinisch@siemens.com>
>>>>>>
>>>>>> Since we only support erofs and squashfs this option is not needed=20
>>>>>> any more. Further, it causes potential overlay rootfs variants to=20
>>>>>> be remounted read-only.
>>>>>>
>>>>>> Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
>>>>>> ---
>>>>>>   classes/read-only-rootfs.bbclass | 2 +-
>>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/classes/read-only-rootfs.bbclass b/classes/read-only-=20
>>>>>> rootfs.bbclass index 35a3ab3..83ddc33 100644
>>>>>> --- a/classes/read-only-rootfs.bbclass
>>>>>> +++ b/classes/read-only-rootfs.bbclass
>>>>>> @@ -41,7 +41,7 @@ SQUASHFS_EXCLUDE_DIRS =3D "${RO_ROOTFS_EXCLUDE_DIR=
S}"
>>>>>>   image_configure_fstab() {
>>>>>>       sudo tee '${IMAGE_ROOTFS}/etc/fstab' << EOF  # Begin=20
>>>>>> /etc/fstab -/dev/root    /        auto        defaults,ro           =
=20
>>>>>> 0    0
>>>>>> +/dev/root    /        auto        defaults            0    0
>>>>>>   LABEL=3Dvar    /var        auto        defaults            0    0
>>>>>>   proc        /proc        proc        nosuid,noexec,nodev
>>>>>> 0    0
>>>>>>   sysfs        /sys        sysfs        nosuid,noexec,nodev
>>>>>> 0    0
>>>>>> --
>>>>>> 2.39.5
>>>>>
>>>>> We observed `systemd-remount-fs` failing in a downstream layer.
>>>>> (using a ro squashfs and apply full disk encryption on top)=20
>>>>> Although, the service is executed in isar-cip-core as well,=20
>>>>> upstream, the service can be executed successfully.
>>>>>
>>>>> In essence what happens is that, the `systemd-remount-fs` remounts=20
>>>>> various mountpoints based on their settings in `/etc/fstab`
>>>>>
>>>>> ```
>>>>> root@device-mgmt:~# cat /etc/fstab
>>>>> # Begin /etc/fstab
>>>>> /dev/root    /        auto        defaults            0    0=20
>>>>> LABEL=3Dvar    /var        auto        defaults            0    0 pro=
c       =20
>>>>> /proc        proc        nosuid,noexec,nodev        0    0 sysfs     =
  =20
>>>>> /sys        sysfs        nosuid,noexec,nodev        0    0 devpts    =
   =20
>>>>> /dev/pts    devpts        gid=3D5,mode=3D620            0    0 tmpfs =
      =20
>>>>> /run        tmpfs
>>>>> nodev,nosuid,size=3D500M,mode=3D755    0    0 devtmpfs    /dev       =
=20
>>>>> devtmpfs    mode=3D0755,nosuid        0    0 # End /etc/fstab ```
>>>>>
>>>>> Since `defaults` in fstab renders to:
>>>>> `rw,suid,dev,exec,auto,nouser,async`
>>>>> the service fails trying to remount the `squashfs` as `rw` as shown
>>>>> below:
>>>>>
>>>>> ```
>>>>> root@device-mgmt:~# systemctl status systemd-remount-fs =C3=97=20
>>>>> systemd-remount-fs.service - Remount Root and Kernel File Systems
>>>>>       Loaded: loaded=20
>>>>> (/lib/systemd/system/systemd-remount-fs.service;
>>>>> enabled-ru>
>>>>>       Active: failed (Result: exit-code) since Fri 2025-02-21
>>>>> 08:55:39 UTC; 5min>
>>>>>         Docs: man:systemd-remount-fs.service(8)
>>>>>              =20
>>>>> https://ww
>>>>> w.freedesktop.org%2Fwiki%2FSoftware%2Fsystemd%2F&data=3D05%7C02%7Cale=
x
>>>>> ander.heinisch%40siemens.com%7Cde0b4a7d3b494f87bd1a08dd54d0ac65%7C38
>>>>> ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C638759977392750433%7CUnknow
>>>>> n%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJX
>>>>> aW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DX5%2BBY=
i
>>>>> WGiccJJ8qUcawdQ40DExa71H3avr0h15jJaU4%3D&reserved=3D0
>>>>> APIFileSystems
>>>>>      Process: 7530 ExecStart=3D/lib/systemd/systemd-remount-fs
>>>>> (code=3Dexited, statu>
>>>>>     Main PID: 7530 (code=3Dexited, status=3D1/FAILURE)
>>>>>          CPU: 15ms
>>>>> ```
>>>>>
>>>>> ```
>>>>> root@device-mgmt:~# journalctl --no-pager -u systemd-remount-fs Feb=20
>>>>> 21 08:55:39 device-mgmt.local systemd[1]: Starting systemd-=20
>>>>> remount-fs.service - Remount Root and Kernel File Systems...
>>>>> Feb 21 08:55:39 device-mgmt.local systemd-remount-fs[7531]: mount: /:
>>>>> cannot remount /dev/root read-write, is write-protected.
>>>>> Feb 21 08:55:39 device-mgmt.local systemd-remount-fs[7531]:
>>>>> dmesg(1) may have more information after failed mount system call.
>>>>> Feb 21 08:55:39 device-mgmt.local systemd-remount-fs[7530]: /bin/=20
>>>>> mount for / exited with exit status 32.
>>>>> Feb 21 08:55:39 device-mgmt.local systemd[1]: systemd-remount-
>>>>> fs.service: Main process exited, code=3Dexited, status=3D1/FAILURE Fe=
b=20
>>>>> 21 08:55:39 device-mgmt.local systemd[1]: systemd-remount-
>>>>> fs.service: Failed with result 'exit-code'.
>>>>> Feb 21 08:55:39 device-mgmt.local systemd[1]: Failed to start=20
>>>>> systemd-remount-fs.service - Remount Root and Kernel File Systems.
>>>>> ```
>>>>>
>>>>> The rootfs is mounted as follows:
>>>>>
>>>>> ```
>>>>> root@device-mgmt:~# mount | grep " / "
>>>>> /dev/mapper/verityroot on / type squashfs=20
>>>>> (ro,relatime,errors=3Dcontinue) ```
>>>>>
>>>>> I understand why this happens on our system, but could not clarify=20
>>>>> why it does not happen upstream! So any idea, welcome!
>>>>>
>>>>
>>>> The same issue happens in upstream: secure boot on, data partition
>>>> encrypted, remount-fs fails. Which makes me wonder if our boot tests
>>>> should check for failing system services...
>=20
> Such check for failing services definitely makes sense!
>=20
> The good thing, I could reproduce using the config you described.
> The bad news, it still works with a slightly different config.
>=20
> TLDR:
> In the failing setup we use dm-verity and in
> the working setup we use the A/B-rootfs.
>=20
> In both cases the filesystem is a squashfs=20
> (once mounted directly and once via dm-verity mapping)
> Thus, in both cases it cannot be mounted rw.
> Options used to remount are similar.
>=20
>=20
> Details:
>=20
> In my isar-cip-core setup this does not happen!
>=20
> I did a clean build using ./kas-container build using following config:
>=20

<snip>

Disable full disk encryption and also exand-on-first-boot to get the
error with upstream.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

