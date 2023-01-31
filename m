Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DAEC636CC
	for <webhook@archiver.kernel.org>; Tue, 31 Jan 2023 07:17:52 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.41])
 by mx.groups.io with SMTP id smtpd.web10.6963.1675149467042025223
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Jan 2023 23:17:47 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=R7M/hRtB;
 spf=pass (domain: siemens.com, ip: 40.107.22.41, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aw0Os07r61KkNNXnlmpwq6pXwPisB2auulzlYTQo7p7yMwp0kmakZIN1PnOyvXyr+0A/F89f2TRpO8ay51ZkBlUnPf3i6jk6dSE8Q8uOWkQRwqgCkZ9kKNXZaeXJvC42IGgPLAsYxCEqibpCzDPm3WYQjeUdc8yGRQCugKbAoJAbX1ALQPv3YlYATFKBqRo0doY8LRzq+LpUdSfsggMS+6UijZQUgg2un6lwKdPqAIvG5fAvdrmmQP61qpO/SsilbsliQzyFe+9CzeTHe3RqKSluApia8LnykF8+PDVWZgZHfMJjIBEzyWuBielSkYWx8acD95KiJAgGiYwVmVNNqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDMWdYmI3FXsMHsGk/s4mNyrSP1a1HcjwU1k6f2CIYk=;
 b=PFdtUsngiNKz1M+YGQYwb+zyUUpUtWK4YWLDrDhkaszuY36OFJ7pkzvq8N4MTlQIW5no2U2NzKpoHeAKWMW6ovgXVqgiolR3kLyANRuvJcA4qRr3luyGRBcNEjn1+L6FTXl23izQwnBSnjdBPDIjWyU2V6PlP3Cca49xvEQMRkFpaCMMtR8rBmf0nDBDTBE0Sfd3brfPIzTHGbzThjDRb4Nc7SaJ4mmN8sWeoKZzGRSJ0gg+tKT4+Ao4FU8LWYwzuIjjXX0yZY4i70HI7rxpyLg/T6/T9auW/4sMhUA3pJm+bEb9Fksi796+QbLgb6S2ZxN/UFxNtyoPVfSh+ST2tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDMWdYmI3FXsMHsGk/s4mNyrSP1a1HcjwU1k6f2CIYk=;
 b=R7M/hRtBNXa8taQzTLPEs60riQdDFd6FLsNMbrXsg6IAWutiXdpk6zUXZ9e+/m5zA9R5BXAxH8fbXHxrLt2d+TI8JYRqL8lvbwh8k3dBv8COEZGtnIOAd2bu3l1IaQeBHET5Umr/FTvt7p2Xv/cn4KBQ2N53iW3nPY7uLI9zjGpvQuHfMhhI5r3Kzh8miqIIfxmZJokgl/bTOrw3nGl/B40klPgedzjo4g39p9ETUo3FM93T8q5VrDSNvWWAmQ7DBvrjzD488eX5HxfQe5jdnb9iRMFOq7uG/SwUcisfi7H11uQsMKK6RR2U2kC/7P5W9Nu1bUmxPp3enVp9Zm1W0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB3PR10MB6836.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:43d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 07:17:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%8]) with mapi id 15.20.6043.030; Tue, 31 Jan 2023
 07:17:44 +0000
Message-ID: <a22ec99e-0922-a66a-59d2-31b084a33bd5@siemens.com>
Date: Tue, 31 Jan 2023 08:17:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [cip-dev][isar-cip-core][PATCH] Add bookworm
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 "Moessbauer, Felix (T CED INW-CN)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20230130113412.628646-1-Quirin.Gylstorff@siemens.com>
 <97eb0b03ed4831bbb9d3eebee92da01ee85b4c0d.camel@siemens.com>
 <efd2c2d2-79e0-f5f5-534c-33ddba4540ad@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <efd2c2d2-79e0-f5f5-534c-33ddba4540ad@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB3PR10MB6836:EE_
X-MS-Office365-Filtering-Correlation-Id: 98ca67af-a411-4c8e-1181-08db035b3f1c
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	VBN5fpwhR4s3Jl0puyxt8UxqRFOj9u9x0g1BrlN9NiD/D+xgglvhhP53Fis9HMqZr7FJQJXcVaAPmhQl4Kv7himKVVzxLsk4GoHrvQfF81F3IoDJYE7RcsZVtg8gZYLKWtNb81S/vX2HpweFAFIAmkc0TXIuJxDM5IdueypXZBJDbaoDpFpNCB6ZJPCBGmcD6yM53G7kLAPXid8JpU9uhXEKe3gNc9ZljYVuL4ZguFHcqF3phJn9AJ2H/BozRxt9XnaNzFa7HpCBgHR5PzK/UB5f9ZbXvPo8XQPNNX9RiI7FWviRCvlJ5iN32Y18j06HeUbaiIc0ZZ1X0AhQ7rlugkXDd7Ed0lzfYR3qv+DVA03vVQpG8qBC19sq89ICUnD4MAFsmfKXyhWkCuD161F1XsxdhhycP212R9ZUn4o5ZyeLmIZRmzWxKJd3XVeZLayAkLRr/QH7c8QUBpFx1l5y6sACcBFgmDpODZ0FaTrE2GoZOWd1cc0Zo/enDER7eTY8Xj7pNV9pz57C2zDzPo3Pq9uH7858SxQNWwShN5mTCVbwe2+z0yk5ecnyb8HipZ5u2cwffa80HRh++YJ2B2bUhfdMT/bRKlIHLI+HpkATpr3TkJvWm2aquMGluwnMZO8LHaL9XDJZc5uf0urZek7rkBsduHF0Jehd//PK75f+3OyByYlajJEEMoenZ7T+k6/KRSc8y5yFk6Kvr2ticnV/lTyhJLw+e8zo6fBsoKMqSqk8Mabd4wxtVrDp2xhzPQaYbkD10sFQ32QgvZxcCruEJQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199018)(31686004)(2906002)(5660300002)(44832011)(86362001)(82960400001)(83380400001)(8936002)(31696002)(41300700001)(36756003)(6486002)(478600001)(26005)(6512007)(186003)(6506007)(6666004)(966005)(53546011)(66899018)(2616005)(110136005)(316002)(66476007)(66946007)(8676002)(66556008)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?K/7NpgkO9ly/mxkjoU2GzGKQHorW+/slF12kZNixz1Kj2m7w4jS/jgOP3IY8?=
 =?us-ascii?Q?W4qld/2UjibYj0SEe4QimjfwvtSVYQ2bXLozjTRFSGJ51MBkPFv7ObAPPN5L?=
 =?us-ascii?Q?gs5I0BpOspazgLbl33ZlAB763DcH399R1+9nniK/wiawEhVY1KvT2zuB5RsQ?=
 =?us-ascii?Q?FWPocRrJ6B+xZZbl62T/X69Cr4Xky1hN8iebKtEpudxncDyxmWXWwIvYjyaY?=
 =?us-ascii?Q?ANaHSqn/9HYCar80ZWr0VmyvWCp4XQUtSNlsDIEvSao2/0INopVm7bZwWM9W?=
 =?us-ascii?Q?zRhjKHulcxTPpp3O4A/r9wqib9MedvsI7YdFu72YosiI92t8MUcMub3by11m?=
 =?us-ascii?Q?wbqDHsfUvKTYYLmdkm4F8BElCGdY3MnubLPP6I9eApckBjekeoXYjTSrJOXa?=
 =?us-ascii?Q?bY1eqbEVVw8ULyelcz8oFL5Oas9NNYnnddjrz0OAdBC60yYvQq5YI6Qnh8SZ?=
 =?us-ascii?Q?g9AADPQCPcuRYj07lu6WfTCEYbUIKS0K/ebHDjKW/WfAR45BkgPVSGQ/XNJq?=
 =?us-ascii?Q?22dyO9MvXdisQw0JxMHORuy6Xp5GwOswdbLx+90Cv6UL04QCi79PU3ACymP4?=
 =?us-ascii?Q?jAUGg/qiKWzQKIJllSQG679mKbkXftRMmaAaskvj3avDy54IZEngtkwV0knk?=
 =?us-ascii?Q?0MG0AGYGfxshSVkA1/77WsQjIVcN9OsXwU783NkKN9sUvYCzZFBlxWH/PVD7?=
 =?us-ascii?Q?s3/s+uentxmlM4IWS7QPCogtod4SGGSo8dwAOGTnnUR1YhiDVccmqSpwmnF2?=
 =?us-ascii?Q?8oDunwkKvSpHiwgRgujZ9Zo5bjUPz2Bq13rL5qodoIuTv6enaf+nwQZ/A9NW?=
 =?us-ascii?Q?Zp5kjJn6Iy16j2waAvmpfemrGFbjFgIxqmt9WHJxcEhEQRlKp4s6QA6whyz8?=
 =?us-ascii?Q?Wt491dB8XwsOIX59N3UIHvv1C6ZdlIEBC5KdEJuD5SUGThBrIQINQdEWUoV1?=
 =?us-ascii?Q?Re8YDZHN4nDuMBiwkaQ/rPAYf+/BvKbnCuZoaVMKO0X/rU0N8TReHLczOxBO?=
 =?us-ascii?Q?px90r2wIjt5RSRGLiaLgXDk3KO4MDsCaRs4fXE7G/yDckiMmXMVxXfme2TTf?=
 =?us-ascii?Q?v5va4MUf2kQOQlRyIY8XInZ7HtT4q03F5NZAs2TDAmnkNbZ3ErG4erL6iHdV?=
 =?us-ascii?Q?XyWK9HYT/3xmf1ZAGAHXkP6xlzEzv5ZAxXxNGWkKurJdzcLYsTs5e5eYNKPb?=
 =?us-ascii?Q?e7ObeaYlmtBNzSgGKU6hOXkpE1UYqmv+BrfdszAcg84lWM35jdVzQ36safAu?=
 =?us-ascii?Q?YdRCbyrU7pc5zjP/FRS0vZTyUW7XBCB+LakPkcS7bARAydAZF8zPSG4eix0l?=
 =?us-ascii?Q?WBxTYzAiRoczn4gMmxkM+fYbeAp/VG2Ur9bC3U0qHuhGos0rE8RoQLjs+GJN?=
 =?us-ascii?Q?mLI+sOM+8OBp+4htN5Dj65fMXB8aSWM3ufUcRm9dG/32D2epBNDvfEJ+W7W/?=
 =?us-ascii?Q?8GYvL5Y1m67hAqlPOhplKJa4alkvlv9dYfAk6FH6wVEFNTOh2Lahmrq3aTkA?=
 =?us-ascii?Q?P9SENIRlWuOYE66VZcipabDYXQbFw66/cMinmLnjt+el6a3EGQrF/IuoESZK?=
 =?us-ascii?Q?WgndapJrLdHQVWy6J13GfPq6+s9IgpSK5a6Nuypxc0HdhBCAbnmEc+8rpLjG?=
 =?us-ascii?Q?hw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ca67af-a411-4c8e-1181-08db035b3f1c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 07:17:44.3298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pfrTobtlTz/2gm6XpdfM1s8awBMKLyIcE0gwRnogt7OQGYowvjb6uTlrwXF+lYir+rTB0q95cPFFe1vqLMpvrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR10MB6836
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 31 Jan 2023 07:17:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10517

On 30.01.23 14:53, Gylstorff Quirin wrote:
>=20
>=20
> On 1/30/23 13:37, Moessbauer, Felix (T CED INW-CN) wrote:
>> On Mon, 2023-01-30 at 12:34 +0100, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> This will add prelimitary support for the debian 12 aka bookworm.
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>> =C2=A0 .gitlab-ci.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 45
>>> ++++++++++++++++++++++++++++
>>> =C2=A0 Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 ++++
>>> =C2=A0 conf/distro/cip-core-bookworm.conf=C2=A0=C2=A0 | 17 +++++++++++
>>> =C2=A0 kas/opt/bookworm.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 15 ++++++++++
>>> =C2=A0 recipes-core/images/efibootguard.inc |=C2=A0 6 ++--
>>> =C2=A0 recipes-core/images/swupdate.inc=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 6 +++-
>>> =C2=A0 6 files changed, 91 insertions(+), 3 deletions(-)
>>> =C2=A0 create mode 100644 conf/distro/cip-core-bookworm.conf
>>> =C2=A0 create mode 100644 kas/opt/bookworm.yml
>>>
>>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>>> index f7c8c88..2b9505d 100644
>>> --- a/.gitlab-ci.yml
>>> +++ b/.gitlab-ci.yml
>>> @@ -37,6 +37,7 @@ default:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - if [ "${targz}" =3D "enable" ]; then
>>> base_yaml=3D"${base_yaml}:kas/opt/targz-img.yml"; fi
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - if [ "${release}" =3D "buster" ]; then
>>> base_yaml=3D"${base_yaml}:kas/opt/buster.yml"; fi
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - if [ "${release}" =3D "bullseye" ]; th=
en
>>> base_yaml=3D"${base_yaml}:kas/opt/bullseye.yml"; fi
>>> +=C2=A0=C2=A0=C2=A0 - if [ "${release}" =3D "bookworm" ]; then
>>> base_yaml=3D"${base_yaml}:kas/opt/bookworm.yml"; fi
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - echo "Building ${base_yaml}"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - kas build ${base_yaml}
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - if [ "${deploy}" =3D "enable" ]; then =
scripts/deploy-cip-core.sh
>>> ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
>>> @@ -281,3 +282,47 @@ build:qemu-amd64-secure-boot-buster:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 use_rt: disable
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wic_targz: disable
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 deploy: disable
>>> +
>>> +# bookworm images
>>> +build:simatic-ipc227e-bookworm:
>>> +=C2=A0 extends:
>>> +=C2=A0=C2=A0=C2=A0 - .build_base
>>> +=C2=A0 variables:
>>> +=C2=A0=C2=A0=C2=A0 target: simatic-ipc227e
>>> +=C2=A0=C2=A0=C2=A0 release: bookworm
>>> +
>>> +build:bbb-bookworm:
>>> +=C2=A0 extends:
>>> +=C2=A0=C2=A0=C2=A0 - .build_base
>>> +=C2=A0 variables:
>>> +=C2=A0=C2=A0=C2=A0 target: bbb
>>> +=C2=A0=C2=A0=C2=A0 dtb: am335x-boneblack.dtb
>>> +=C2=A0=C2=A0=C2=A0 release: bookworm
>>> +
>>> +build:iwg20m-bookworm:
>>> +=C2=A0 extends:
>>> +=C2=A0=C2=A0=C2=A0 - .build_base
>>> +=C2=A0 variables:
>>> +=C2=A0=C2=A0=C2=A0 target: iwg20m
>>> +=C2=A0=C2=A0=C2=A0 dtb: r8a7743-iwg20d-q7-dbcm-ca.dtb
>>> +=C2=A0=C2=A0=C2=A0 release: bookworm
>>> +
>>> +build:hihope-rzg2m-bookworm:
>>> +=C2=A0 extends:
>>> +=C2=A0=C2=A0=C2=A0 - .build_base
>>> +=C2=A0 variables:
>>> +=C2=A0=C2=A0=C2=A0 target: hihope-rzg2m
>>> +=C2=A0=C2=A0=C2=A0 dtb: r8a774a1-hihope-rzg2m-ex.dtb
>>> +=C2=A0=C2=A0=C2=A0 release: bookworm
>>> +
>>> +build:qemu-amd64-secure-boot-bookworm:
>>> +=C2=A0 extends:
>>> +=C2=A0=C2=A0=C2=A0 - .build_base
>>> +=C2=A0 variables:
>>> +=C2=A0=C2=A0=C2=A0 base_yaml: "kas-
>>> cip.yml:kas/board/${target}.yml:kas/opt/5.10.yml"
>>> +=C2=A0=C2=A0=C2=A0 release: bookworm
>>> +=C2=A0=C2=A0=C2=A0 target: qemu-amd64
>>> +=C2=A0=C2=A0=C2=A0 extension: ebg-secure-boot-snakeoil
>>> +=C2=A0=C2=A0=C2=A0 use_rt: disable
>>> +=C2=A0=C2=A0=C2=A0 wic_targz: disable
>>> +=C2=A0=C2=A0=C2=A0 deploy: disable
>>> diff --git a/Kconfig b/Kconfig
>>> index cd24ce2..87056b9 100644
>>> --- a/Kconfig
>>> +++ b/Kconfig
>>> @@ -128,6 +128,10 @@ config DEBIAN_BULLSEYE
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "bullseye (11)"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on !ARCH_RISCV=
64
>>>
>>> +config DEBIAN_BOOKWORM
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "bookworm (12)"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on !ARCH_RISCV64
>>> +
>>
>> Why is riscv excluded here? If the blocker is only efibootguard, we
>> should try to get that unblocked as soon as possible to not miss the
>> bookworm freeze. I'm happy to help to make it possible.
>=20
> From my understanding Risc-v will not be a official Arch for Debian
> Bookworm [1].
>=20
> [1]: https://lists.debian.org/debian-riscv/2023/01/msg00001.html

Yes, 2 more years of constantly breaking sid-ports for RISC-V,
unfortunately.

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


