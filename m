Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABB4C001DB
	for <webhook@archiver.kernel.org>; Mon, 14 Aug 2023 11:43:13 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.71])
 by mx.groups.io with SMTP id smtpd.web11.105292.1692013388884623017
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Aug 2023 04:43:10 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=bQyFGVit;
 spf=pass (domain: siemens.com, ip: 40.107.7.71, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwpeDibkBSBi1PlfEdbeyAcvfeXYSEOFQuQ9K5JLnMY9QY0xqy4D0ht+5o154Wd9Dp5mtjDWhK6nDS3uUo0rxfyXr+ZYEM5u5UnwHOKzhkHLXUfFv2OTDhUsuEpFXXVfFTnj2E+mH6VmH2LNUJXQr8MRoFSvJlAatiXf8UynWJbWRr3R4q6JL9IsDq/GPiyZXcfh7OWPw0EJBWfkdn9K0iJob2GnK773uRB1nEOtTsjk+jcEC7Oduj3OZiNxzscUuHfHvQcC7lUxUeAi+ky+ZNVgHQxZoZX9OotvsjeR7kHbbHvfNSY/2kJLlfJ3ec3CwwQCGoJLDwgqnjQZdb6iOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQlbQP9+l/xgYFKLmhNeJEt6/pOFN3EsByjDVZPIqws=;
 b=IXmG2dO4OzwoJq1yKQH5bWZAPBubqiWWOkU2v5xMAhBT3g9iKkSqbT7TKwJAzjEi+AK3PqJZGxltPjjiNEB8SxqopwK6UC2iDh9Z3cW8KNbS1tXgcA3yW8UC03OqlQ7S1//VAliw7BDt2Fpsx1DVYSYPllddyNFEAfMa+0hXQxkDMASe9Tpi8cfQAZRMRVJysN+NAxTZaX/DyMnYBjZx3V5WqAdGg8zTtvG9B9mTLlDe0nyao5bjbnZiVL6rF8Tui4zVLcaFHDjFqlu9T1LfkyvkWyLrSty2YJbgkgcP7zUExitqYpJSYI8fb6Z96DNVwpvn2kImQHc1UKZKtVTWWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQlbQP9+l/xgYFKLmhNeJEt6/pOFN3EsByjDVZPIqws=;
 b=bQyFGVituddu1lUgYMM+UlOh624yR0x4BBsSWF4lU/lVBsgKSr1SsShzJVy8eEqu6I4wpxtUQC0iP2g2Dk3QPtDxxpugK/R0yzmymcwAeJtwAN4hq9/N1MMO38njwHuMM42FCU2CZuw9NDptHk4ETozHTO8JE9anJXROCqldos7M0TxqSQaqXOw/7vmzsYMS4Y0am7ybEp2RDlw5x7qRosBp6EGkqbaXo5h/BMxufThi54W/OU8+BCDRQUMud5BfOEAEeJbvy5v+6+B2Qyh+S24OoPY02/rywX1X49NM3K4dweQc3zVy94gVjklDSr9B2BMgE9T9E19Xnj+cIv8bug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM8PR10MB4049.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 11:43:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 11:43:05 +0000
Message-ID: <6ec810bf-51d6-4ede-9c31-027e8da203f4@siemens.com>
Date: Mon, 14 Aug 2023 13:43:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH 3/4] initramfs-crypt-hook: Avoid
 calling of tiny mke2fs from busybox
Content-Language: en-US
To: "Koch, Stefan (DI PA DCP R&D 3)" <stefan-koch@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Gylstorff, Quirin (T CED SES-DE)" <quirin.gylstorff@siemens.com>
CC: "Sudler, Simon (DI PA DCP TI)" <simon.sudler@siemens.com>,
 "Storm, Christian (T CED SES-DE)" <christian.storm@siemens.com>,
 "Adler, Michael (T CED SES-DE)" <michael.adler@siemens.com>
References: <20230728143320.3891194-1-stefan-koch@siemens.com>
 <20230728143320.3891194-4-stefan-koch@siemens.com>
 <15101ae1-62b7-47fd-808d-501433da81f1@siemens.com>
 <a49cdd53-e2b9-52c3-ac40-b11264952b28@siemens.com>
 <e27c652d-f203-483f-bc7b-1b994f3d4e7c@siemens.com>
 <9443dd8ff4eb0bb72c28c99f62d71c341d6f958a.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <9443dd8ff4eb0bb72c28c99f62d71c341d6f958a.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM8PR10MB4049:EE_
X-MS-Office365-Filtering-Correlation-Id: db3efefe-5598-4f4c-24aa-08db9cbb9f63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gROZnbU6ntRtty0QTADR0EmHl27KRzRRUEYXtGa3EV/YNlhlhXVT3DlBv4791oaIbIL4D2IDaDC4s96ooHsp3mG+kMYO1hQc6lsWhb3mqADQMamYqvmbPLMD0wwD7AYSay55wlt7MxRhjF7RzfBQdeQwiOr1BkIrwrCRBMM4+66hDth+QCFZHjx6orAMWY4K7m+7bliEcc611GFnCyY83Cb2fvlVYqu0+h+Bs1LPoafUszruzRyY6LSGhMHuzyuJJZgNim23BfdOEyyVcB/+Ta0yDv5dGlKDu+7p0P1Een30hR7nhnM+7vsI6qmbNOMkWA/AQSxJrxWF195K+4Uf3JKMpP78mkf/EwOc+l4us9QiLXT7Vx1hqcdOw0++IQJMZCExvp0mBeqDktWcyUchhvy8xhDjjDTSq6tlEVx3mR0G9KgZCfJrnq57ZeH6UnOzrdsqLVx1+VOGW0HKVjAM+K98P1F7iIrKWUTAPRSpDVgdYUqRgak8zKqHm4279F6DqgES7AqJaDk5i03WUKuy4rMAsHmhOkicmcgyPz1iLFR70LH9XWVNtvunw7/38c4oCvme8bOIwDdXDIXfqQIUUqtaPVUNI0i5fSXn+D8EvWN1oDJJFWErlD7l/JJL4WvuCaFbVY4NbzOX+HiBJFHH7Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(376002)(136003)(396003)(1800799006)(186006)(451199021)(107886003)(83380400001)(41300700001)(8936002)(66476007)(66556008)(66946007)(8676002)(316002)(6512007)(31686004)(2616005)(53546011)(26005)(6506007)(6486002)(54906003)(478600001)(38100700002)(110136005)(31696002)(44832011)(36756003)(86362001)(6636002)(4326008)(82960400001)(5660300002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?PN04nsREEijN4q9/XAWhFmPlRBbRJd9ApF89+WYJItU6O/HwxuGHr5sIKaC9?=
 =?us-ascii?Q?oGRPZsrrqGANRSsdRFZIgDX1N+53RY9+XJwnYydlq2iGhC0hB6iYTg/yn9AL?=
 =?us-ascii?Q?EtA0qE+spY60ki5kQmB8jRZmvCPwGnYZvBiveq7Atq4e5Su9rbDr4bryTF7x?=
 =?us-ascii?Q?dcjwit9GIZp2c9BLNBi1dOXZle1xZlk+oqyj4nuubSpVwDhNfnEUv23expxu?=
 =?us-ascii?Q?hWHQY4feQwtGlMiIHBoamQ1eU78tWLzVr3+YRExeXP2RoBbFrq6k0ds6LpS1?=
 =?us-ascii?Q?tViW2Bs8qyi85FFmaQ+FlKtV4ExR1+gs4vCmu77v8TKPCuXjy+YZdnKzNGNS?=
 =?us-ascii?Q?EkEPdjyR5V+9fA7E7KIkm9hTPYoJYYUYKrffjAh1dT6GD7Kehm5937sV69vh?=
 =?us-ascii?Q?psklV9Xy/8szbNWcegXGsyb28Manqcyr7Ve3mbB2IdQmnvywPd5UeuyetVpj?=
 =?us-ascii?Q?r9lnDGrAVjd+S1UPWxNkE8QlNhgy8hJrPGHooimsuzTtyDJgbs1zB8EG+knq?=
 =?us-ascii?Q?Q4xYiNfbDhYkHef25sR1y4/AbFUWY2LtBVkrZ7oyfMG7rVHy63JgioxXNNJn?=
 =?us-ascii?Q?uRk+YzvwFBaVPPd83pz9GNNsUwhGGKiQec6mdjRTg4Iy1cwKVd18UcZ3jqoQ?=
 =?us-ascii?Q?IgKggOhV0T7ee/WtIYruwxPQoNDcNJTXl2cv3Cn3eg7OXf2iUwwQ+E8KyKo3?=
 =?us-ascii?Q?bXYi2ujvWR5S6rrtUjtlhTlQLxQgD3xdaUe2jrkww9l+XzWOKXpTft78ZYXE?=
 =?us-ascii?Q?BhKTgtJ1t6P1bnRCRjgbgYTBCCzhCGlXYB6DHN8bRB03llCCT9ms9v2C+NAF?=
 =?us-ascii?Q?rR840ahdrkKQnxlN6IVV4e6+dk3rIi/sFdO887Z0bBmzzFDmg1zCUlfVJOjM?=
 =?us-ascii?Q?kaiWXLkHWUcT3NNfOR0rnZJiDfeNyhr65v87NoP9dMt2MitSuam6/9ZAazfl?=
 =?us-ascii?Q?Dg5Mt4jv6l3Ide+7yLKVmom9DeB1vRYlv94w/lmVD57nqAdvLgjJ9P+pWkDU?=
 =?us-ascii?Q?IshRkKn8Cif+nYQRfYygltdKx+SD+vByzMCueIfd5p5Yg1WUUINMQy6frTdR?=
 =?us-ascii?Q?8M9R2PcW3IjeoqMkXzmY+JkNZU4ZPh7akbY/OIGURl03cq/zhuR9LthimYnp?=
 =?us-ascii?Q?6LNh1RhfX/fpd+FWUZTsfTX/F8qo+cwF+tvMlIArGU/B409INJRD13BDtFG/?=
 =?us-ascii?Q?omuk9MG4pVWq0Hec0ED5I3RaE8eI7hCGF+eZaBJE2NYqENbTcz/TTNrvcC8B?=
 =?us-ascii?Q?rOJLZyEwwsx2KCToamGal0JAmE+9zNXMuVVQXZvp3fmC8n3WGeBUGGC8t//D?=
 =?us-ascii?Q?DaMB7ENYpeZDe/BcAXH4jVLipJuY6VW1N2lPoVfUkYW+KZEyhklmH1l3LNP9?=
 =?us-ascii?Q?H7MGwJgUYiqkifrlspMXviOr9XpI+RVOWBZLBb7FJySJc/uG4ZEmY51mOPRz?=
 =?us-ascii?Q?zCFnbV1pmA4m+N0+d2NtNTJocR4XdlT7TSBhmnufbzUrH1sg0KWLsKK7QBSs?=
 =?us-ascii?Q?kjACPQ7/3UHi14nq3iNidQkeuh7ZPbq3EEmBH7lW1RuCEEwYbqaIBWh+yLB9?=
 =?us-ascii?Q?CG7QIUKVoF71DaPjOBjcUTx2mZk6tdLP25IngVGNMBTP+6oFGGnq0h0OB8vc?=
 =?us-ascii?Q?oA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db3efefe-5598-4f4c-24aa-08db9cbb9f63
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 11:43:05.1536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6XPGdgMFiCHelPhEUuq7ee0Fu/+++R2J52M9HqKAvZMfjtlcPaxTon0Qybn9hG3KkWzrcGOGOpcAxJyvdllnkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4049
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Aug 2023 11:43:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12641

On 14.08.23 13:25, Koch, Stefan (DI PA DCP R&D 3) wrote:
> On Fri, 2023-08-11 at 14:53 +0200, Jan Kiszka wrote:
>> On 10.08.23 13:17, Gylstorff Quirin wrote:
>>>
>>>
>>> On 8/10/23 12:36, Jan Kiszka via lists.cip-project.org wrote:
>>>> On 28.07.23 16:33, Koch, Stefan (DI PA DCP R&D 3) wrote:
>>>>> The tiny mke2fs does not support the used -t option.
>>>>>
>>>>> Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
>>>>> ---
>>>>> =C2=A0 .../initramfs-crypt-
>>>>> hook/files/encrypt_partition.systemd.script | 2 +-
>>>>> =C2=A0 .../initramfs-crypt-hook/initramfs-crypt-
>>>>> hook_0.1.bb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 2 +-
>>>>> =C2=A0 2 files changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git
>>>>> a/recipes-initramfs/initramfs-crypt-
>>>>> hook/files/encrypt_partition.systemd.script b/recipes-
>>>>> initramfs/initramfs-crypt-
>>>>> hook/files/encrypt_partition.systemd.script
>>>>> index b32b2f2..4e04d37 100644
>>>>> ---
>>>>> a/recipes-initramfs/initramfs-crypt-
>>>>> hook/files/encrypt_partition.systemd.script
>>>>> +++
>>>>> b/recipes-initramfs/initramfs-crypt-
>>>>> hook/files/encrypt_partition.systemd.script
>>>>> @@ -42,7 +42,7 @@ partition_sets=3D"$PARTITIONS"
>>>>> =C2=A0 create_file_system_cmd=3D"$CREATE_FILE_SYSTEM_CMD"
>>>>> =C2=A0 =C2=A0 if [ -z "${create_file_system_cmd}" ]; then
>>>>> -=C2=A0=C2=A0=C2=A0 create_file_system_cmd=3D"mke2fs -t ext4"
>>>>> +=C2=A0=C2=A0=C2=A0 create_file_system_cmd=3D"/usr/sbin/mke2fs"
>>
>> This is not correct.
>=20
> Oops... Params lost :( Then default should be ext2.
>=20
> But the=C2=A0condition
> 	if [ -z "${create_file_system_cmd}" ]; then
>=20
> is never true, because of "??=3D" in the initramfs-crypt-hook_0.1.bb
> file:
> CRYPT_CREATE_FILE_SYSTEM_CMD ??=3D "/usr/sbin/mke2fs -t ext4"
>=20
>>
>>>>> =C2=A0 fi
>>>>> =C2=A0 =C2=A0 service_watchdog() {
>>>>> diff --git
>>>>> a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-
>>>>> hook_0.1.bb
>>>>> b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-
>>>>> hook_0.1.bb
>>>>> index 1c1bf3d..3c3f6bb 100644
>>>>> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-
>>>>> hook_0.1.bb
>>>>> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-
>>>>> hook_0.1.bb
>>>>> @@ -32,7 +32,7 @@ SRC_URI +=3D
>>>>> "file://encrypt_partition.env.tmpl=C2=A0\
>>>>> =C2=A0 CRYPT_PARTITIONS ??=3D "home:/home:reencrypt
>>>>> var:/var:reencrypt"
>>>>> =C2=A0 # CRYPT_CREATE_FILE_SYSTEM_CMD contains the shell command to
>>>>> create
>>>>> the filesystem
>>>>> =C2=A0 # in a newly formatted LUKS Partition
>>>>> -CRYPT_CREATE_FILE_SYSTEM_CMD ??=3D "mke2fs -t ext4"
>>>>> +CRYPT_CREATE_FILE_SYSTEM_CMD ??=3D "/usr/sbin/mke2fs -t ext4"
>>>>> =C2=A0 # Timeout for creating / re-encrypting partitions on first
>>>>> boot
>>>>> =C2=A0 CRYPT_SETUP_TIMEOUT ??=3D "600"
>>>>> =C2=A0 # Watchdog to service during the initial setup of the crypto
>>>>> partitions
>>>>
>>>> Do we have both already? Also in case of the isar-cip-core
>>>> generated
>>>> images, or only with additional customizations of the initramfs?
>>>> Just to
>>>> understand when this issue is currently visible.
>>>
>>> cip-core does not include busybox in the initramfs - therefore this
>>> was
>>> overlooked.
>>
>> Ok, so the path should be adjusted.
>>
>> But now I'm wondering why to spots have to be changed. The script
>> checks
>> for create_file_system_cmd, means CRYPT_CREATE_FILE_SYSTEM_CMD, being
>> zero and falls back to the standard creation. But then we have the
>> standard command also in the recipe. One should go, also to avoid
>> mistakes like done by this patch.
>=20
> Should we just delete the condition above within
> encrypt_partition.systemd.script - since the default value is always
> set? Or are ther cases, that do not use the initramfs-crypt-hook_0.1.bb
> and bring in own customizations that might fail after dropping it?
>=20

I'm inclined to delete the script test, given that we have a default via
the variable. Or what was the idea behind that, Quirin?

Jan

--=20
Siemens AG, Technology
Linux Expert Center


