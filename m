Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8C6C27C6E
	for <webhook@archiver.kernel.org>; Fri, 14 Jun 2024 05:28:06 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.83])
 by mx.groups.io with SMTP id smtpd.web11.4633.1718342883398014864
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Jun 2024 22:28:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=JcR9Itho;
 spf=pass (domain: siemens.com, ip: 40.107.20.83, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7c0al+WHJDZieLhKLfsVxx39ReUwKoewoXm+hSwIxwlEK6QJWlPHRggT3YAzOhwnsV83EXeeVLK2JL4Xxc0OCVqbWBYkv0voddat8eYuKb5taiMmA8VU8R1unfawRZ/xD1n2mShjFYlhg4KUaWodyI3J8gFP/nxTa36wYLuXnj+t9k/orML8sbA8AdalH8XwqXceBAsMaJEdhIU/CKdCzcreMk/2RdFfQY3gIG3HP7mQSBVrKB3kGuWQFXu80imeSaPl3AXJLRYpPWhxbHgUJlQ2rZcD+HJxlqqvjzOrPKFIviMPew1XB83wetCt/eeP+PopJj4Ry8vbssf5GqWsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hbE9GumVdq4/+OvmQnYTHsNNeesJ7InR3X9KRDg4e8=;
 b=k8qttFDnFSHFJl3NDUwhER6/HgZqfANVufpUfSDdCzf5gx8aqBMz0nmJ3K+Hv6I0GwSgJJkHA2/yJ/z9r9grEWCWJGgCZsH8dnqsAPr9Jn+JjaWUNQUEQ2NVXKL8K0PlX1OgTRlyPp8liq/8BfdEBEzQU7EiJD5l0PEAICkrQcgvVt7L2TSM8/fr6cs3gyaJeLCusJ4RLv7PmKr3R7KGDBIOGKvP/M2SiCEA8pQGif0jaBFLX0lX/LxBUxtuIw/MasyYgQYx37nY9UpYjbhqSQOMyRbFUtPbt7hhBGXTqRDPoIV2AqBo2YfMvoQ1bA60KAvj4nImbmIZu/JTT7BGRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hbE9GumVdq4/+OvmQnYTHsNNeesJ7InR3X9KRDg4e8=;
 b=JcR9IthoskHcnXTBefhIFQ+U9DLQRW4zMPBi9fIs26vcWCHFSEIuSuEq7VpV9TfhKq54Tg2cFT/zy/f+bolpDQ7PSYCFKRcvAtW/BsNkRqn30WPP0tV7Jt3VA3SnkoOUUZiceb+svgxsZauUvttF1zjfkrkgq+wGacdQ0hbAMHzz15Z305xkTsdkv5N8boLseBRtetagVJITECPUoXALAIDEseplQ2YaqwZTyhZvhQ6hvr/udcM991yd/CoSwtAKg191A8UkGE+G3c66YzAcApHYW9up0eC7MbUSqvLNjvbvPoHagovYpLbDMEP8Sat2qNsp1LjVC2ihGqQdAiLGGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7043.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Fri, 14 Jun
 2024 05:28:00 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 05:27:59 +0000
Message-ID: <e31d036f-7b6b-494d-9b5e-19a227a48b28@siemens.com>
Date: Fri, 14 Jun 2024 07:27:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Artifact download failed due to timeout in 'lab-cip-cybertrust`
To: Sai.Sathujoda@toshiba-tsip.com, Chris.Paterson2@renesas.com
CC: dinesh.kumar@toshiba-tsip.com, cip-dev@lists.cip-project.org
References: <OS3PR01MB61030B7550E645EED661DCEFC2C22@OS3PR01MB6103.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <OS3PR01MB61030B7550E645EED661DCEFC2C22@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7043:EE_
X-MS-Office365-Filtering-Correlation-Id: ecb99f5b-a806-4768-b00b-08dc8c32c148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|376009;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?L4ljlSh8LaDBkvcRDEFTYNM0rvdAblqIrTGPShVg2MI/PIjyvoCC9ccMv/1j?=
 =?us-ascii?Q?MqQLnt0USZib1Xc+Ubw1GNAQ8rlkjYuoS8lJXIm6uWhF0GCs3tZ5diBSdYjA?=
 =?us-ascii?Q?U1jS0jAsomSJ1IaX9qR0YMRIloEfVNDlikoxzx8LT1l9UJ/NmkX7/3Cx0EcV?=
 =?us-ascii?Q?Zsdpi0E3BZTUFe9KLgzD3LeKkxr5G3VajwrfLGKMK3i6CJ8mf9Y7jY4GY3O6?=
 =?us-ascii?Q?I0QBlE/lJ8Y+m6KqftO9Xte5xsCJTn6HXLy9Bx5Swug4jedrv7FwrwQnjF4W?=
 =?us-ascii?Q?KqVCvUEgwAgcGXQOo+RJ/iWoEXa7iVKC1qxr74XeFpIq4eMcDnocmSalkdGX?=
 =?us-ascii?Q?X8ZXq6en6cIh+dzaeQCsbfiRs/sQ0DjUCcV+NOVRpwh/dXhAuOrapA/M7LCH?=
 =?us-ascii?Q?GdLdcCZWQPSojAeZEMCJWl0Zfjdb530wjoD8W4fRj9ogVGXy0wBoFpgtYrrI?=
 =?us-ascii?Q?p4p7jc6ClY/7QBVNWPrf7LKwGDw5lShZZYWlWo9bd0LsUDjrXEHrA0POsYP8?=
 =?us-ascii?Q?mQAJTfghg92rPFHQN60eDGAbz60uDIFC6xa+4WXb71VfPQ7UZkjAM2pxq9iA?=
 =?us-ascii?Q?JqeeLJiZBFITLB4j6jcOBQGOfob/ENyLVWscJgptDzPP45MLIHQs1CQqingE?=
 =?us-ascii?Q?gZX86WrKg9C/YG5WqNL2GffelUMjZtk5SQum+nPew9/WfbnmYIIowjv+qGDN?=
 =?us-ascii?Q?uZFGmhahgXBYmL8TC/7rEr0MuJPv3QyISpZsSkGQhSvqPgyRg0s7jfC4SxvI?=
 =?us-ascii?Q?zaYaw2dI4wu2h040dWjssC5quqBnP1uairmdsxo7dUwMVMQ6MaVfzZ+IWjY5?=
 =?us-ascii?Q?ivDpcbYSOEIzjg9pRJQC8FI2nbMjYvjuvOkVBMr27cFB3em8HjQy1k4KnMz3?=
 =?us-ascii?Q?acI7DZ3Q86167S2U6m4BcO6sttuGly+bkQU6Tn6CmEFiPUcIXhLIRaRIUi0z?=
 =?us-ascii?Q?xO57kf9jbF6rYR9b5HmIM+l9q5F2ztI8FIdAMIhh6qQYMOfsfCrBzNhe5pZn?=
 =?us-ascii?Q?8Ub+md3suoAZKIl09Luba+6Ql+hlF7YrPQsYiETV5b2Z+Wudy01uXAAC4CNp?=
 =?us-ascii?Q?dTB+NXx6f4iAOBrgKGgQZjDFDKR/nq9TPYX2t1ZCR/9z4awUoFb9qPgc8/mZ?=
 =?us-ascii?Q?KqXkM+rKZjH0a+YCoFI9xHfohDP1/K//xMRLKUVBuLASrj0JyLh1yNOXoehR?=
 =?us-ascii?Q?SAkDWqKBkvtULHdVW9ZeTEoUfTU3cwULGg8TV/8VK12QskZWhqfiZiBvK6aT?=
 =?us-ascii?Q?RgZ5VcSyLxayLXvxeQNnXmPXnohYfVfMwvTwJTQrxA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?R5d+0moA3VJNLrGxjLU1jljxaiEJcuWD/iQx/5B3f4Rpd0ylYqDg9Lny+yaz?=
 =?us-ascii?Q?7VSmVRMH71AA94TSelhP8NQhQMXidLed/MTBq0NTDrrgCBCCLxJpoUp1r15I?=
 =?us-ascii?Q?bwQ8j588u0atvVWYBVe1xBwZzp6zIFZG7IZBo3yONsRcsCSckW9KXxTIjK6p?=
 =?us-ascii?Q?2oPBUqjh5Z/iWZTvqD612sU4iunRg9Sl5ilI8Qmn6oAFDQrS8uT1+6DetdBp?=
 =?us-ascii?Q?nrbVBEyLpmxR6hfVX3mt9phk0xEio7qtabPzYcJP1rb9o7nlAMV3nCBeCmdY?=
 =?us-ascii?Q?BxwP8Srb+eDVivczgFUf597fcRUsoEJdrfYOXiVkV14GiyHF1wSOOuGwyVig?=
 =?us-ascii?Q?f6ue6JFy2Q5efX3aLdYmjMjatjsCPPHr/KYKlnos4//fNi+7yxC+JJZx3rip?=
 =?us-ascii?Q?e/WoffVeWDMYl1kZFgruvuR/iokK7YwcNVUxR2fFoRCBilnh+7oriKvQrgAo?=
 =?us-ascii?Q?qK1K1/wPLpxsH8tu6e+LIm7fgvyOmxHXmEL+KONAKoZ8JnyyQavoZQsI7kcf?=
 =?us-ascii?Q?QY8Wo7O19xuXqLkc9T6izc7g7Mu0S8CcJI5GWq59wCDGHdSJGxm3G5I7UrW6?=
 =?us-ascii?Q?swMejhkpGlvZm960DLj8/vw31aqXtbrH0zkgfdPw93beWHqdA+RqnpHiAfN+?=
 =?us-ascii?Q?wWOjINuSX/W5jajQp2uu3U1JBUnvZvu/wR+8/eQY8JnocCUBD+BvyN14Dow7?=
 =?us-ascii?Q?ez+/DZvhk4eYl38KB3p/xWtt1ED0ydBUUlJfcSxZyBo0kzB3c983TcfOEe9D?=
 =?us-ascii?Q?EZPs4Rv50NCB4TD/RBRXMTsITujxd4JpdcoQAFV39VeD1UO849tQPqnN1zeu?=
 =?us-ascii?Q?t60VGSXtceskQ0I0fdQUt+l3Yoku2kwyYudpM7c5i1UyB9/svS71v4HpD7Ae?=
 =?us-ascii?Q?Q4eIK0ixRJW+SYxXhjIooakJA5FHp+3NzAyGW65XVA0Ku///gb+3pYXzw/Wi?=
 =?us-ascii?Q?n7qBzoVI96sNRWQiJaCD5khvCC3GL7uDlERdrjXWoTR1Ak+npTHlthYGRqmA?=
 =?us-ascii?Q?0t62oDJ4g+j1YRu/xMGqtJZRXmlw1M7RqkSEr4t9AvRNg1kMjthUvW8sphwG?=
 =?us-ascii?Q?lTDkgb/DuNe3OOC+Vild4NpMj7Ca/7WT0bpLQWSVRKEKQQFseY8Kk/ysyX+7?=
 =?us-ascii?Q?eBvO/yv8RXq3ab7IJPab9U7IhWCuOrzmam3NjcbqGxGzMm2RaRU1ejEemcdn?=
 =?us-ascii?Q?6zip2KLwwjGSoWsp96ydhYTzaZfNI+HLvVUjAbFF6R1LVz4NYahL3kecxo6T?=
 =?us-ascii?Q?c12jwDSKpUCE9bu60vgJzKk9rMRYa+6VK9qBWGWA4vyq8Qp/4E81L0hPEjk/?=
 =?us-ascii?Q?STqYfXdpvRt+AT3HxbeSFtkpXZLEoXl2tZub1N+6R3+qrXOwgRiU8D1rvYig?=
 =?us-ascii?Q?P8Y8effZ1xfjrsOE76LZrSDT5279WRGORqK+XOCDtY+a7gudZp4d5ZahN3xT?=
 =?us-ascii?Q?2oshHKrl3OW43UzZ2fW88pojfnXqw1bJvJyMDnLMr1rCc4bkhJqwbcX5/M2K?=
 =?us-ascii?Q?kLsIdcv6nnGb7X1+LkfZliXOGfz36fKkiVdIlYIsZDLFEuvfCkZpDLREjSWl?=
 =?us-ascii?Q?gisMn5CN0K7t0lyaTDe5fuja2n1vaKG7Kwk6EugCSef9jYKbki3rHCDBMgu+?=
 =?us-ascii?Q?mA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb99f5b-a806-4768-b00b-08dc8c32c148
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 05:27:59.9598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/qgXBdsuasuDT/0c6Yn9/pyOC4PNSNKMTuDU6gmSf/e9Wa/ZT8zDOmHBPCbY+OQlnMvTd7yIhNDV7ZV5+u+AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7043
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Jun 2024 05:28:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16227

On 14.06.24 05:48, Sai.Sathujoda@toshiba-tsip.com wrote:
> Hi Chris,
>=20
> Hope you are doing well.
>=20
> Yesterday I noticed that jobs which run on =E2=80=98qemu-03` device in
> `lab-cip-cybertrust` are failing due to a common issue i.e timeout
> during downloading the .wic artifact.
>=20
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7094898973#L=
699 <https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/709489897=
3#L699>
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7094898970#L=
985 <https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/709489897=
0#L985>
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7094898965#L=
670 <https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/709489896=
5#L670>
>=20
> Do you have any idea about this Infrastructure error ?
>=20

Was about to report the same.

I just kicked the affected pipelines once more, and the issue might have
been temporary:

https://lava.ciplatform.org/scheduler/job/1149433

Jan

--=20
Siemens AG, Technology
Linux Expert Center


