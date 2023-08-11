Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2AEC001B0
	for <webhook@archiver.kernel.org>; Fri, 11 Aug 2023 12:54:03 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.89])
 by mx.groups.io with SMTP id smtpd.web11.41919.1691758438383046651
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Aug 2023 05:53:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=pwcwdG5Z;
 spf=pass (domain: siemens.com, ip: 40.107.241.89, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GyVMHw8x8cabcvd2E6zllHP4e6SBxMx5uaCR/ALdw7JWI/3l0BuCGigyoGsyvXQIskfMbITGCNY624J3tDeEpkr1SL4hZxsKt49Imk/QMvp0i6h5xvWQzFX5xVpQojC0cNbSKtglQTQAL9fdKrriZMaGVdvRoMwM4q31gHgsVXTKUBp4PKnja7XsUFU9PKFlEOBVyYRWS8vGLmpINFhWb7HvEsE++xKLpqmG1KCIyOWrzVwxGwh/cAb/4W9f0NDdQqJ64XIL9Wu5/E3N7m3a+dXdcTTeYOj7ZbxBOXQDU+1aHY4nW6kWMuhEvCQPH8O/6wPg/IofI+oucMkUC9Cwmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ud5OLUP2KhTYSBwKJOI5/vmoXCIhpfEfiGeTjK5J7SE=;
 b=R1I3+g9qca7IkJjnnxpnHGLoih1hxYtYjsA3ujPD2LBHnxItF1UbwmVnIcb2xqMkGIJXYlJjIzFMuFgt9hUrXVxjPFq+fcedENEtpoJQEsG/wXw6oYdBJRyt0PObyFdTfgkuR0XT847mS+09Ch80IOSIR4z7lYE2kKpXYQ4aM4m1QefRi3osljLTTps/VXdCjsL3Av3pDlEIgSMp10W4OFFljpXGtSSxvSKcSaqbYLkHBAQbjiHI6gTcJPGtaNqHS6UbO+v2iMltIokPJPl/YXtprAed229rAFDP1Z3VjNkU9afkmSZkrAayrfKQW2vJEutcNuUJatDotvhjLvRLdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ud5OLUP2KhTYSBwKJOI5/vmoXCIhpfEfiGeTjK5J7SE=;
 b=pwcwdG5Z3Qw4nLI/PvI/cnuiYse79JIUrEBF9NtsjSYYwb1pGONM7p3apGHUS1iL2njQLoy/8csIvNV7GGF+amKYvFLB4IwIGIolWiKoJhW+Sz3qW9ghQDC+5cmocke/DCJ0/UKa8LYySSxJbEoTrskZeTM0yoY7636DQk8NaCW8sulN2iUYKmHjHiNG/0fZuj23SmnHTKiQfof5WHA9xGaYY4jb4otU5sX9gv68T68Za9apsnxc+YTUwf0cVrA8OchpFOU9Q5e1A9C6ZMAeh2AOherng1rxEfuzSXikzkUeQb7g+c8zpM/kyPbcD620xkpNY4PPN1eVbaGl1j8DQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5907.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:39a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 12:53:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6678.019; Fri, 11 Aug 2023
 12:53:52 +0000
Message-ID: <e27c652d-f203-483f-bc7b-1b994f3d4e7c@siemens.com>
Date: Fri, 11 Aug 2023 14:53:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH 3/4] initramfs-crypt-hook: Avoid
 calling of tiny mke2fs from busybox
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org,
 "Koch, Stefan (DI PA DCP R&D 3)" <stefan-koch@siemens.com>
CC: "Storm, Christian (T CED SES-DE)" <christian.storm@siemens.com>,
 "Adler, Michael (T CED SES-DE)" <michael.adler@siemens.com>,
 "Sudler, Simon (DI PA DCP TI)" <simon.sudler@siemens.com>
References: <20230728143320.3891194-1-stefan-koch@siemens.com>
 <20230728143320.3891194-4-stefan-koch@siemens.com>
 <15101ae1-62b7-47fd-808d-501433da81f1@siemens.com>
 <a49cdd53-e2b9-52c3-ac40-b11264952b28@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <a49cdd53-e2b9-52c3-ac40-b11264952b28@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR03CA0103.namprd03.prod.outlook.com
 (2603:10b6:610:cd::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5907:EE_
X-MS-Office365-Filtering-Correlation-Id: 12f026f5-7c45-4af5-bb87-08db9a6a03c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UTc5fdKnlqjk+AcKHC6rAvQr9MW48lvXnApkFR3tXr0RHs5X3JpWpcUj0DedbXWeCzF6IM35zp5sHkXRk57nxJt2IelF3UVaErM94W2o0m8SFjC5mgu3B/LHRqRHkXJ2geDhbHqRSKQOxyoljGUSHWvgywtS+DslUmYNWA+/NaGb3mRCDHZDU1rcX5jHxKFo4X3m8vfLfcRuNtsxaDZrQiWGGxrNcsOQeQwVTcizyPwIrNiAWdLa7xHnEu7veesnmqosLhvdq4HJfDZqleDEon4bxRaoDjq0wZ/LU09kCwZI0xRn56Q4CjaU3SrM2QOmLhG69Kkhv+L2vGWPT8poRPldOE02X65SmF+2RV2Q7crDB7RpIXO1mHsoEMWk65F9hcIjn33WLXXOkLnhLtuFJ2XqpiLs+9fe4CKj31t3uSOtjYSNrLFuuy1gLbjHZF30g6XORsfDY3YmW6HLZta6ML1tGNFcAjgmI7C35b8Nr5IsHmS5e3bTAs0UqFckXT5t6tz0sUa67rSfN/QFTVT2C7lvI59cIjUJMoIGo8qmhS89LB61MIxfVp+6DMGUf/gy91dzHzHJj0BN2wZu+RFtB2PrU0+YAPlsSKFrl+4590EFsHYguZH4JD4sPicpI29XRCSIcL4zsfP+Nz7nc5nrXA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(1800799006)(186006)(451199021)(6512007)(2906002)(316002)(41300700001)(5660300002)(36756003)(6666004)(44832011)(83380400001)(8676002)(8936002)(6486002)(2616005)(31686004)(53546011)(110136005)(38100700002)(6506007)(54906003)(26005)(66476007)(6636002)(66556008)(4326008)(66946007)(82960400001)(31696002)(86362001)(478600001)(107886003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?v0xrV+82UQsulwgxNH/6xieYg4ipVXMPAiYzF8r23W+ZECVczyyJLkBBdP7J?=
 =?us-ascii?Q?3pIu2iF1qOMyfXf4h5O2cLHV4mZoVOXcn5sSfa2U6apw4yBj/pzcTy7DW6o0?=
 =?us-ascii?Q?R6f/PSkDZjlKxRKYA6epS+Q88KCW/X/mHc8/jzAaLJwzeTegr9/NltPiMgL6?=
 =?us-ascii?Q?1OkR35XvbASftBHmRr+k5XfVzpWkRus+/Qhgm7ieTvLv94giF94AvZ5WmS/9?=
 =?us-ascii?Q?Edz3F6JVfG83a1j8z7dNn/cQBwbT2L3ali/t+WXxMlR7IhomYJM8vsd/MUWW?=
 =?us-ascii?Q?rL5DzE7pI6T8/X74LNs6eQsSFjSSg9Fvzvzo6sSYVGNmXsdANBy6x1MKXift?=
 =?us-ascii?Q?00IINcyzoyNmM8AhLhZfy1hG8wzWkZfmhJeI3zjEFP0aJQKdlVdWP2jlkzVB?=
 =?us-ascii?Q?atTdOwKhMAPql6rgot0HlxZKwtA3MyL+uQ3KjfSEmfJ/PTezVOf+INV7sgoO?=
 =?us-ascii?Q?aUW/JDP0tqxR02zRAjt+DiMx1oeiKrBab+0IViuwkNjhHMSOj+XLaPlO/Cee?=
 =?us-ascii?Q?DpP+swA3ZEC838H54Si/XM9YootzsKasFitrBjpXw6q1XV1X3XWvB1Wf5ve2?=
 =?us-ascii?Q?Exz3gMHhpBLEu6BNqTyVN4Q1YWSBw/hIg4DmjxRPK0fI+FdHnWpka8AgYmyy?=
 =?us-ascii?Q?BpilmwkjjVtbpm3MdA6LYNYp4MhFJ4jnjupEJc/ko+9AO1pIGoQPQ5xeEhzV?=
 =?us-ascii?Q?o5EinteoKs2DRhlNzH3or8SAfpsFOrLTQ+8Hy/w6C1Q4FIVffAQsa0ZCUNoS?=
 =?us-ascii?Q?GnAIPfQinOwb0a704Sb3s8Qfb204n0va5CxZ7EYeNj2pa0HC+2K9zXjRVuLP?=
 =?us-ascii?Q?DAj1dSdVIQvmWRlgmpXxtrjFy5OZ3tpNikkW2boCj14TQC4tdLDLHmgvNAJS?=
 =?us-ascii?Q?wzvva2X1cuVqkF+30MyxASyFRGf0js/oDLWLHlW3ccZ3Ky9AUQPkEt+hdCrN?=
 =?us-ascii?Q?+mJz+DJoTKdizxz1i9ZUikC1TSJHcDTzKpd9/xWNy4AjZxn4NbSYKjmrRDF2?=
 =?us-ascii?Q?/LbcFrVGV+UxSIrHgdDpI6yEXT7ADnXMNikEsgldVIsFHU0T/wHUDHJdnOQG?=
 =?us-ascii?Q?mZDSTUocpSUKji8Zw8wxz99EY6medMYlAziUCF4O2H4dHC3K0B1OSZ7CHcp2?=
 =?us-ascii?Q?KE5y5MQ0IUvSA0rAxOBzsv10LOxnrAN5AbnzMS5BUx3+7Mpz2AITy5J/Ow+8?=
 =?us-ascii?Q?L3p2TwHF0iWe+g32dzR38KFtVT5lComdQRHgaw/r/ZShhQjUzVYUcXbh7zXz?=
 =?us-ascii?Q?zSh2BSWeVhfM1dZlUiXFRlbiURQy8wEa/9CvmaokzmBkC3UNa9G1jwoasXyk?=
 =?us-ascii?Q?EtUrAAO60SDFSF00GCSPAhJeU/ZPtaa+g7BY1CVI4sxJscidLiMINZVO8xET?=
 =?us-ascii?Q?/RlbwBwQ0CHhdhYbAuZ6heZQMSBXd5IVFWAQURVB4Yt39uUuEc7sSSZ4dqmP?=
 =?us-ascii?Q?Y4iTUPGPB4Y/0pcT0JhM4xXrHM3ZGskqNhb9N8htW0l2T7TivxpptUB0S92F?=
 =?us-ascii?Q?5awqHZqQHj8pbyZ8pn3bquldyvc7oOn/AVNlSBy3NQwrhJ2Vd6YkMNzLQEhl?=
 =?us-ascii?Q?t5QBS9Ds47S0QoQ9CNq9JoNWlu/thhMypr0A8GFZGKy793ra4tI8sXy5e8YT?=
 =?us-ascii?Q?ag=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f026f5-7c45-4af5-bb87-08db9a6a03c7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 12:53:52.7097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s4Ro/iRh0atyAX6kZgO5eHr2zNMWchXknGMVKNnjJWrqxp5Ud0OiW4F4h2TXjBtj8ZMGCAgSXEpp6r/h5mJACA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5907
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Aug 2023 12:54:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12611

On 10.08.23 13:17, Gylstorff Quirin wrote:
>=20
>=20
> On 8/10/23 12:36, Jan Kiszka via lists.cip-project.org wrote:
>> On 28.07.23 16:33, Koch, Stefan (DI PA DCP R&D 3) wrote:
>>> The tiny mke2fs does not support the used -t option.
>>>
>>> Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
>>> ---
>>> =C2=A0 .../initramfs-crypt-hook/files/encrypt_partition.systemd.script =
| 2 +-
>>> =C2=A0 .../initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
>>> =C2=A0 2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git
>>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.s=
ystemd.script
>>> index b32b2f2..4e04d37 100644
>>> ---
>>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.script
>>> +++
>>> b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.script
>>> @@ -42,7 +42,7 @@ partition_sets=3D"$PARTITIONS"
>>> =C2=A0 create_file_system_cmd=3D"$CREATE_FILE_SYSTEM_CMD"
>>> =C2=A0 =C2=A0 if [ -z "${create_file_system_cmd}" ]; then
>>> -=C2=A0=C2=A0=C2=A0 create_file_system_cmd=3D"mke2fs -t ext4"
>>> +=C2=A0=C2=A0=C2=A0 create_file_system_cmd=3D"/usr/sbin/mke2fs"

This is not correct.

>>> =C2=A0 fi
>>> =C2=A0 =C2=A0 service_watchdog() {
>>> diff --git
>>> a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
>>> b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
>>> index 1c1bf3d..3c3f6bb 100644
>>> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.b=
b
>>> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.b=
b
>>> @@ -32,7 +32,7 @@ SRC_URI +=3D "file://encrypt_partition.env.tmpl \
>>> =C2=A0 CRYPT_PARTITIONS ??=3D "home:/home:reencrypt var:/var:reencrypt"
>>> =C2=A0 # CRYPT_CREATE_FILE_SYSTEM_CMD contains the shell command to cre=
ate
>>> the filesystem
>>> =C2=A0 # in a newly formatted LUKS Partition
>>> -CRYPT_CREATE_FILE_SYSTEM_CMD ??=3D "mke2fs -t ext4"
>>> +CRYPT_CREATE_FILE_SYSTEM_CMD ??=3D "/usr/sbin/mke2fs -t ext4"
>>> =C2=A0 # Timeout for creating / re-encrypting partitions on first boot
>>> =C2=A0 CRYPT_SETUP_TIMEOUT ??=3D "600"
>>> =C2=A0 # Watchdog to service during the initial setup of the crypto
>>> partitions
>>
>> Do we have both already? Also in case of the isar-cip-core generated
>> images, or only with additional customizations of the initramfs? Just to
>> understand when this issue is currently visible.
>=20
> cip-core does not include busybox in the initramfs - therefore this was
> overlooked.

Ok, so the path should be adjusted.

But now I'm wondering why to spots have to be changed. The script checks
for create_file_system_cmd, means CRYPT_CREATE_FILE_SYSTEM_CMD, being
zero and falls back to the standard creation. But then we have the
standard command also in the recipe. One should go, also to avoid
mistakes like done by this patch.

Jan

--=20
Siemens AG, Technology
Linux Expert Center


