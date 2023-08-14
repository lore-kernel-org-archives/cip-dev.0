Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40840C04A6A
	for <webhook@archiver.kernel.org>; Mon, 14 Aug 2023 11:46:13 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.53])
 by mx.groups.io with SMTP id smtpd.web11.105338.1692013571499771606
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Aug 2023 04:46:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=lo2yB0IV;
 spf=pass (domain: siemens.com, ip: 40.107.22.53, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axsxe4rbj3JbX86bJAt9mafqImxNWnF3I6/IuRCKkTjFho8PS3rXVRgVYYdwYOpL0SuqsbmQy8NmsUwOuT3eiLweiy74mtF0g6Gw4/oyJn7vayn/NZhjntnTGiFHQf21ir3AVhXIUHQTOq3XB2D2PeIl2Hi+dL6QLoTG5oapLDcDRNaNWechtnyVL8WLjqBI99/TRJM81uLxKspqNKZuSsRDKYk1OkUayDglSvArMku3/4EYXoZlYYn7rJ3HBAuPNi5MpyX//r6yA/HHzsmuOZjZpZ2YPb9AIG0+l0R/VOQaMPsIm7O2ct2dy64URvQxJL+f0R7b9MiUR2OoP+RM3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqNFHculgc0KG300ripRN0CnXg34z5EjKYaDtZWxmfs=;
 b=XiXjmUwIzgLJVBwzu2dE+fAh6bq0oYeIdqwDl2CH3p6se9Y0EwdnzcSpnWGUhL8wypce2uK/Jv3bInqXXkGrfXlmxLcNbu/fnrxG31xUPEezz5S2PRqCmvNxleN7WL4Oue7A/M9QJWsjySzlIU//YmTu9PAJIj9nbQ3QmI7bV0yhIWXUjhHJ8lbIUsQwJx6DlsLXYVFV5P+PcbVou4hDnK0qsEyhzW7kwbR3RDDKdz5VaM42D8v6ZUUxS4kij2uR2Jy7d8/VLZyq5LmUcqhLR2EGQbiCwMeLRxCab2q2WCNf/CjtSVUK5Vl5+JvSWrVDQg4dyfJVSCRD77ypTi96qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqNFHculgc0KG300ripRN0CnXg34z5EjKYaDtZWxmfs=;
 b=lo2yB0IVKuF0w+oI/7VFAw2i3pRZ0EP9pjFyTLhbRXxbXaObT7Cpb6U0NPMXSkf3/haLYurF6RR7715uJUqN3Sfn1+/awEFlgodOw77zjnRXoSnkRl8itriENflXWnbHrEluB3aoAtdb4fPXNhiLgMKNe4YOUJpD5jfpRSy/1YL40NB/mtUYCOGUS60YfW8rr5TuQSqDeaUTIy88DaJ+R3huorJHvml1i48B6CN7BK3kiLfkblu1U2subOz59F32W5cQIIEShaUIbGvEsgzGFBF9GLhm2xTqrS22VkcOqu5xEJgr0DvE4oVlnkJLqsNa2oPFMF6H5TYMPw6Tf3AcdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7901.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:64e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Mon, 14 Aug
 2023 11:46:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 11:46:08 +0000
Message-ID: <5d54eeeb-cce3-451c-a28a-95eb669694d9@siemens.com>
Date: Mon, 14 Aug 2023 13:46:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 2/4] initramfs-crypt-hook: Check and repair
 filesystem to prevent resize2fs failure
Content-Language: en-US
To: "Koch, Stefan (DI PA DCP R&D 3)" <stefan-koch@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Gylstorff, Quirin (T CED SES-DE)" <quirin.gylstorff@siemens.com>
CC: "Sudler, Simon (DI PA DCP TI)" <simon.sudler@siemens.com>,
 "Storm, Christian (T CED SES-DE)" <christian.storm@siemens.com>,
 "Adler, Michael (T CED SES-DE)" <michael.adler@siemens.com>
References: <20230728143320.3891194-1-stefan-koch@siemens.com>
 <20230728143320.3891194-3-stefan-koch@siemens.com>
 <dada78d8-aa43-470c-bdb2-d55c7f90dbd1@siemens.com>
 <88fa04c6796b3b2c69adb7d507f9a6b54b531c96.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <88fa04c6796b3b2c69adb7d507f9a6b54b531c96.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7901:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d9425d4-8400-475a-2e06-08db9cbc0cab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9X4Ui3RKLpr/s6iXo5XlFxSA8geX/HoDPRcmfNhCYCgn5x9RIDtXSafP2CaQlMJhJxxKyESASRUw+8M8zv7qylUL9mdqNMwCKgbil2Mk8f05+Uxv3GhO083CozKQk5a53qD1gdJKDMnuN2BglASG8h5i8ZS0jT4Gz7DYUkoXQNSBsB/pKIBJXsWAZCzIXTJ/oGBgTvguAl2avYE9y0Lki5xyBtfmR/H+Qg/iSQw46SHJf1TqM6DfNOsTVu8V8kcpkGFf/2knga/teE7JayasJuAaZbHHN3Ro+g7vKroYLOxFnzp3TXdMCwliBIgCxeBsmYaSpm3kQawcAwbieYpGEPdLM9LzEInFm+G3qDmcBhwMUuUXBvmaniQ6IEd/UGJzX60h3oP2q6pnxHExc6WFYlm2WfQGpSQ6Rw5c/imuIFvYcWpESqnZtLm/Mhw85AyEeI+0Unf2TRGpjMh3HhyaHczXkQrIxkCZVCYF73+lRhS417i/TVk1rvHruzit4SktjAGiYDVs9xqaCyPh69aCKK39zIecIKPupuY2wNoMkIeFweEHUmDtBOz1nhsnkW9BKaxtDmKkRp95Vs2mwvHjY0EO7HUSikhT/ZsADpe+nEVKWU7CKssOiYPNn+BU8KN/laD7jKOl9phTqUCK6LXDdw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(346002)(396003)(376002)(1800799006)(186006)(451199021)(110136005)(54906003)(31686004)(107886003)(83380400001)(38100700002)(2616005)(6506007)(26005)(53546011)(478600001)(41300700001)(316002)(6512007)(4326008)(66556008)(6636002)(66946007)(6486002)(66476007)(44832011)(5660300002)(82960400001)(8676002)(8936002)(2906002)(86362001)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gsEPVVQk3IByH0wXlV/cR+lhDKqKOWkvPHpBH7cx0H3nQjZp+pZzrn6DFEs0?=
 =?us-ascii?Q?/SZ161YTrE0bGKLfV6Z4XgpiR4jQNdLqm3RfK0ZzC3ehs5ERS5AhcMCriQWR?=
 =?us-ascii?Q?QE7c0thV0IDLNOwaYwT34lKHj3u7DnHhABX3vPghDou7vFeooXzvvnEcuqfp?=
 =?us-ascii?Q?ri2WLxyz4ptVUx8OJqsFTHb0S9zV5bbKhvVcDsjQqDC8P7eKHuJLDn8DINZH?=
 =?us-ascii?Q?wq/qXKK+IH23k0N50OcFUrXKyuYNM75CHyABZDiEEW/M4MafQJ1mbbscpz1L?=
 =?us-ascii?Q?H1JY/KAtZ4fO0NuCr4Qr9MT4qMeWe0IjNjVud+08WsaDRw8WjqzEgjeJwTyb?=
 =?us-ascii?Q?4az+Ffp2ndlViSX8dX4SUPuGGz6PwD0bxQykVvYQN1Zk8IMxqburFpOXQC9t?=
 =?us-ascii?Q?j7gnCzpnGqcTDRNwm5Fxwrt+xuSz1NjEbLcHEvIkcpjOXqaNIOcJ2kgen7Ld?=
 =?us-ascii?Q?rHogxbVvxj2I36z6qym90KauSE+OevzGfoVJ6etDAehgd9JOGeHzVWjNTfFc?=
 =?us-ascii?Q?e3Ejm7kD42rsllLPzNTYdXX7lFR63RYfZOgWdbewD2oXYsLUFybJ77OseGZp?=
 =?us-ascii?Q?O4DHee7G9aTTJgtw9XpK5uaQKTwdg7vdJCGqjO0NIxkzygIp+ZWNvYTlNXCb?=
 =?us-ascii?Q?LJejQ1LdZZIM0j/PQqsHC62smAetSBAy2wxuP9T2FjVVBGxUt5/wzXQFHv/1?=
 =?us-ascii?Q?+sQqBV+RZpHc2dpIVZolfAkOyvjNMl4rGWOf1WruS1OuOJKOuHpD6/WsO936?=
 =?us-ascii?Q?oNhhgVXfG6JUCp49s5TRZ6kUZ7iOHBiitbLSBrTM4kBMDQr1LqLDKR22Zaa0?=
 =?us-ascii?Q?8D8o18yRHgEXQ1Epf9FLOVFQfgK6u4ImldjsbGXWg0vB/z9rYvfooSuRhCI2?=
 =?us-ascii?Q?q6koEYrOFo3KMdMBFnhSPVNNQvO+NX1ZNS71hXBjcAtaotX6pAsTYhliBwi3?=
 =?us-ascii?Q?NxzQbZ7q8fr5Us25Zo3BtEGPpUaU0iVLarlz8bIsPJghnPzNfiDlV5D/PeOu?=
 =?us-ascii?Q?F+A7VKZmPiS8wXZrSCJnGquCfbCAddpHmC7gvR7Dk+VA1Gm30Juwc/R+hKkq?=
 =?us-ascii?Q?a3qQd7zGUrAgYNNebkVV49ziosrUMJa76hDQT1L1QsStPP5yT7NXMCUu8CHH?=
 =?us-ascii?Q?kJ3L5UVRv6mL4tIagF/yzlVER+8eTFEkM1kVWmVAnL8IZaP7F7a7YZOdi9Bs?=
 =?us-ascii?Q?D6bniuB6dM8cJ8bvQNY/7c92kJc4Bw49lkMP/oquITAyOnAZS5X8/pIwxrnG?=
 =?us-ascii?Q?h2AspXC8GRpMB9hGy6t3a6PDu0nOi5sO0jgGqowHPB42xGS0n4BQ5NHAH5R8?=
 =?us-ascii?Q?8Pr7Zwtz/xTu6iXeL6zcM7WFmXcN/iRv0P8d/nKwzpHf49rTpohefe13OUdg?=
 =?us-ascii?Q?tK+VunNhO6ozfnle5SNSSEhzV+iev1YUexfkfZdLq7ty1YjkQlZ1BABYi6bh?=
 =?us-ascii?Q?idGteOWCAcK89TBsrogNJpqYUb8Wx8RB24OT3UW8i8igrN7/K1Y1VwYqV+47?=
 =?us-ascii?Q?3z5HC6Vc+jubRfGh0GcRDxKq3zYAh6IdrKJFEYvblLd88oKgy29x17zbg6qZ?=
 =?us-ascii?Q?Y3Tc8SRtWwWbhJoulTh2FCpZRQ4tl/A62xzAoekU8Jz+nL1L9uJp3fZufy+h?=
 =?us-ascii?Q?yA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9425d4-8400-475a-2e06-08db9cbc0cab
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 11:46:08.4703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TtHUQCUW0hs0+Swfw1zzBBKr9ArAjDsF3FhOqqNFLUMzlFWFbUd7koT6hJy6Jed9mdmKvEZ6tCL7FGCrYLFiHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7901
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Aug 2023 11:46:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12644

On 14.08.23 13:36, Koch, Stefan (DI PA DCP R&D 3) wrote:
> On Thu, 2023-08-10 at 12:34 +0200, Jan Kiszka wrote:
>> On 28.07.23 16:33, Koch, Stefan (DI PA DCP R&D 3) wrote:
>>> This checks and repairs the filesystem first to ensure that
>>> resize2fs will succeed.
>>>
>>> Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
>>> ---
>>> =C2=A0.../initramfs-crypt-hook/files/encrypt_partition.systemd.script=
=C2=A0 |
>>> 1 +
>>> =C2=A01 file changed, 1 insertion(+)
>>>
>>> diff --git a/recipes-initramfs/initramfs-crypt-
>>> hook/files/encrypt_partition.systemd.script b/recipes-
>>> initramfs/initramfs-crypt-
>>> hook/files/encrypt_partition.systemd.script
>>> index 83c3238..b32b2f2 100644
>>> --- a/recipes-initramfs/initramfs-crypt-
>>> hook/files/encrypt_partition.systemd.script
>>> +++ b/recipes-initramfs/initramfs-crypt-
>>> hook/files/encrypt_partition.systemd.script
>>> @@ -87,6 +87,7 @@ reencrypt_existing_partition() {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reduced_size=3D"$(expr =
"$part_size_blocks" - 65536 )"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reduced_size_in_byte=3D=
"$(expr "$reduced_size" \* 512)"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reduced_size_in_kb=3D"$=
(expr "$reduced_size_in_byte" /
>>> 1024)K"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0e2fsck -y -f "$1"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if ! resize2fs "$1" "${=
reduced_size_in_kb}"; then
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0panic "reencryption of filesystem $1 cannot
>>> continue!"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
>>
>> Why is that needed? Conceptually, we should start with a clean fs,
>> fresh
>> from the image build, resized on first boot.
>=20
> In our case the problem could be setting some modifications with
> tune2fs at image generation.

Via wic or via custom post-processing?

>=20
> Additionally I have observed that resize2fs breaks without e2fsck
> called before, when setting the break=3D kernel commandline argument, and
> mounting and unmounting (without forcing, just standard umount, no new
> data was copied) the partition before disk encryption scripts are
> running.
>=20
> What is for cases that are using the reencrypt mechanism? The
> partitions should be in a modified-state by former device usage and
> just installing a image upgrade that enables disk encryption.
>=20

Re-encrypt is so far designed to only run on first boot against a clean
disk, not used before. I'm not sure if we have more corner cases lurking
behind the corner when we expand that. And we should have test cases for
that expansion in isar-cip-core. Quirin, what do you think?

Jan

--=20
Siemens AG, Technology
Linux Expert Center


