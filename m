Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6746EDE984
	for <webhook@archiver.kernel.org>; Thu, 14 Sep 2023 05:56:18 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.53])
 by mx.groups.io with SMTP id smtpd.web11.5582.1694670969616434705
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Sep 2023 22:56:10 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=GyMPaUUA;
 spf=pass (domain: siemens.com, ip: 40.107.105.53, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gw/qPpMUlhdwNaG1R7GXUUNVNCyBSB2ZrBVbI1qLoRyGWVSw8xijcgJcw8/BOaXHO3ls1MEIWJ2U3UG/gxwLJhUQPxZGhbjQdBeeUi6ASLoamhvT76e8avDe2Rf8t0HhBWSchJMJ8P6HCCt29F1tUy3SRnZpFvPmtEcwBc5l1rNQKXYrUEKHuhjA60l/IGHWdhHZDXG171BjxogEMXXZN5gDUrwHp2ucszyd8nkFQXJcigJyZthc4sli3OLfYDSfIGkL4bYJ7wqnWxmTByH/80J/Jcp/mNVzYw6wu957F3WXzCz5LT1Ok6+BX0tpQqqQwwQrw9BVvANrL5PFH/85fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfacV8Oscr7dbTDt/yq/oJd2CPR/ldt4jh8ILlgow+I=;
 b=PJV6uOizdkWRCHZZkGW5sBHNuNxzXBrU7+v/Okqe5iS8YIzY07KFhdzI7jHYGlY/SM4MVfUgAVnRJeVUjSazBfMuRsdB7ayRqFY0J1YqSw/aDCneUtZeBOnsjSzSiMaJuDDwPschmBYwPnuNP68got+zw7Y5dBZymj6B1hLZFT5MCWjkGVQabYKg7qpDUPE6lf1acqSrPOsR1YAYc6nfP6oF3WInNq0Yiv1h7Sy4QDXgPrHkYeFIURVelTZiHUaRC5dQjexcgLdqy9WQWUPcS2HZNId14QfmeX3zTPgT9BXSPzvvPmd/4C0/8yMISu3rhzVF4+bHBbdWkp6P5CvOBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfacV8Oscr7dbTDt/yq/oJd2CPR/ldt4jh8ILlgow+I=;
 b=GyMPaUUAcVpLi1FbDlR4mW4gNzWf4ME8I1QVxtW5H2ERROm4go7fFmHOY/gjid5G+KMttcaiHt4suMDD+3EOKs07G6Bhxcod7BWU3rrn+xiDWM4XiWY8NG8QfXl/X9IfA4UXpRvfR0Ojy1OMjKq8ZTqxiKNYpC4wrzm57c3ewdSufh9aDLX8elUYGDGvOV1ocBLISNp2G8LydAzrCOC25yVx3VwUeFTFzC638pK9sKg2wC+0hM3X4gOK7SIUNn6IDX+2W6aMu7rvUAsjZ2h3/xSK3wFRSi3HS/fKHYYBZmeUOwYlLItw0S2JYN7lnJii901i72fsFApA+HJzgNCytg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6148.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:97::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Thu, 14 Sep
 2023 05:56:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 05:56:06 +0000
Message-ID: <e25473b5-670b-457d-a017-200663b93e7c@siemens.com>
Date: Thu, 14 Sep 2023 11:25:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] initramfs-verity-hook: Ensure
 sync on rebuild
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 "MOESSBAUER, Felix (T CED INW-CN)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Schmidt, Adriaan (T CED SES-DE)" <adriaan.schmidt@siemens.com>
References: <20230823132816.1011054-1-Quirin.Gylstorff@siemens.com>
 <5a4f1ebe-305d-409d-b142-49626877455a@siemens.com>
 <94deff88-b5ff-16e1-89cb-d5337b788b50@siemens.com>
 <c90ebb07-260e-496b-9280-c340ae41c26b@siemens.com>
 <cfe1f5d1076d50f409e6f2f6aea7728ca8f06695.camel@siemens.com>
 <595d5791-a08d-f08f-5dee-6f9ed5d472e0@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <595d5791-a08d-f08f-5dee-6f9ed5d472e0@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MA0PR01CA0021.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6148:EE_
X-MS-Office365-Filtering-Correlation-Id: 71f9d871-06c0-4f52-35d9-08dbb4e74918
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	fZmxytAgAjkzCOCZ0w4fwwvkFc5bTOMfFKiNoPzVOPDddf6JqoX3MBGVyA8lN161O1JsVw2ultpwCRmb7WHceENO0Flt9bHHrGy+NVIHv9144pyVEhnjtJ+PIPu2xISqCjQqU1VnEc1myUSExkFKkz6G6Llyw7gyMQRWl9tG9XNF4wUvzYOPAaueXjRoQzw/hW0p6UkgPRrF8Kz6GnL/HFNuL1orS6sD6LqmXgaY/b2PYaQ6V0yHNyOTYR3AjVodqJkr8zEcatGCWnvfRd9akVVdrl7UBIo0OfbYTIiDGTkWpDfiyRydLb6i7enFmfi4+xsIgQqE0U+XXgV19BNbzwH2rDbtR3Ox6PPTKOcFyLcJngnhnCLkK3oc+eUnvsEPN3Xl9N7zRYY6hUMmQ5I5abVWxrbvzfhGIufHrzLllSxl9LA04C+9lraQMnC7/pfEFWX6+ZA1FIHVMVoE8SXa+LoGNXd8OFv/Bmz7Dl1jBtD+o/phjKkQgbFhCF69agOr30Hf2wnK9LpAVOLxMZj+/LOxYx+6U4f6cKTQ1I3sK/xas40l9sUtcZw4E+hpG4Uml1P+rhr4chNYmH1f63FwZj/2RfsDP5wtjR7cHBA50b3hkUvKLpzqGWP+Ctc3zoQ2sshBjPYfH8FTvyFNETMNaA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(136003)(376002)(346002)(186009)(1800799009)(451199024)(83380400001)(478600001)(966005)(31686004)(2616005)(107886003)(26005)(53546011)(31696002)(6512007)(6506007)(6486002)(86362001)(6666004)(66946007)(2906002)(8936002)(66476007)(4326008)(41300700001)(44832011)(5660300002)(38100700002)(66556008)(316002)(110136005)(36756003)(82960400001)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JQk3fdDv44UA6xujo5X6l4qsEdkuZN+xt7NC2RQrQh3l8DWnQeMmFbABammq?=
 =?us-ascii?Q?ZhgmYQvqEzLKqZwZTl0hYYtdaXukTzZR7sBy06tcCX5i5FRBjAlzv6zJ9t6i?=
 =?us-ascii?Q?UEOeT/R40V6He32Fd0TuGbKH/sAEFcovbMT9CcLLkyfVt6R2ABWp++IpZayP?=
 =?us-ascii?Q?acxMjnRQgFTkQikHTGCnCKiu2HbV+hGeKWpZUnyZE6fIyP3MMSQjww3zNV0k?=
 =?us-ascii?Q?UNy0fS6WIEf+2H8z94Ejy8RPnZmBwpd6FTe4Fn5883YJuAEc3/KWRQONh09a?=
 =?us-ascii?Q?Sj4QQe994+050Qf0nkCg6Z6McHnqC02s4Zle7vMCER3kG7euGglL1HP4HTTr?=
 =?us-ascii?Q?F+KnXcn4H9nN8nuMFjn7PnQYoIeb5pv6huz21z2+Bw5xZsfuHD1OC2EpMIQh?=
 =?us-ascii?Q?cPZH4vuTk+jLmyP7g/AwtAYGBxftm0sEhfLrsho3TKxYdtwzjjttc3cKZNJ0?=
 =?us-ascii?Q?DtBQif1wlEAtF/ORji4mMxnWJXPusm1Je4OJXwME0b0ri/MGtKQDxJrbF/nU?=
 =?us-ascii?Q?RudUkSK5crY/k1OhjNRP5bgXLd9V2v/IFjbkUT1Os2mWT5Su/rs9fuNsALaw?=
 =?us-ascii?Q?NUHZzaVem3ODXDxZkq2krqkQJDhL2XWuKrevw9viaemP5OBWY4eY79AZ8U8R?=
 =?us-ascii?Q?CN/gqFdwCtHr8Q/U5tc0FxaE+6fGCgkIXgfSmRx/qFom1CYiK8Aktl9Mbz0Q?=
 =?us-ascii?Q?/nyFOONL3nPoaqslZ6K73qj//frEx9TqgUEQu2mVOrB2LY+Z2nA31BBoasBJ?=
 =?us-ascii?Q?SPqnNm38qqeBWk3p1gvOvWs96D4FTsnj2+kmzO30fEuwbgD3pvHCwspZgcAz?=
 =?us-ascii?Q?2K3YOXdsI4JkU5D3j57LHk1E+k5tye+d4aSwVcyaUYEQoCDEmnPYRS292Gtn?=
 =?us-ascii?Q?htbWwhKhcbGHY3SwwWs+6VDy6yDJDHiqfIjwkcS5PXveGmjzkQedMY9fsqbL?=
 =?us-ascii?Q?K6UMzmCxIx6uk8Ll1AFO4STtVe5pGV/IX7DvYX+L+YV+LtihyLs4ZuLniz7I?=
 =?us-ascii?Q?qXeZIYiYC9InzUV28B4zYBqkqFZw+S/hqq8KSO/e2MzOddaEqcgxieG3x2CL?=
 =?us-ascii?Q?yshgNDa4lBluP/Lrl20z5Bfi5s6/YYVh574SMiDlhd0guaVIO1hVVW6jqr/2?=
 =?us-ascii?Q?pyilED7zyWWveGYxhGgMdAAEUCWUT6LliBjVBcHLRqaNoaAL7y04aDjAWw6S?=
 =?us-ascii?Q?o0t0SA09XzlOP58j3L/XUuRwZ2xl5qcOdXNP6qapBsE5bEtv+C5kDrWhRLS7?=
 =?us-ascii?Q?kdZepeaYIRaBPLEHNyt4UIqDvB4VXpyPq/ZQduQ20vAamxZ8WTNMKLMkn8Lz?=
 =?us-ascii?Q?EE8IVPOAi/vNoEiPL75Z1PHNTx7+WswDBPtgP0CVB9n9rYpEMni5bsCJSFQ3?=
 =?us-ascii?Q?7MQkPzqlFFI5+z7MvdiFvS/LVsF+tUfdIWuOlPy7thpOLPPsgR+PAk0KkxJe?=
 =?us-ascii?Q?CuZFpdcW7PWbVKnizROJYMPdLw8lG794E85lStr5tPkFfkXjkT3UcKUmMpKJ?=
 =?us-ascii?Q?lxh5r0jFGvaMKVwT4DJ/cmH+senZLSFzypdzNleXDZChq4dSTLYMUI399TUq?=
 =?us-ascii?Q?KOLgnBW2jdhKYfONW1F3DoluqpljQDLtdAxW/utu9hrF2duDoaOcHQSymAoJ?=
 =?us-ascii?Q?Ag=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f9d871-06c0-4f52-35d9-08dbb4e74918
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 05:56:06.1427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bHb+dubLlu+w9aEA/R9D0eQeJszAp/QKpIjaflX9U0hkyTxk9Jt+44S0y3nHi/R5sGLrgfyHBO1Fjt0xB/fGgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6148
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Sep 2023 05:56:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13128

On 13.09.23 18:21, Gylstorff Quirin wrote:
>=20
>=20
> On 9/13/23 03:26, MOESSBAUER, Felix (T CED INW-CN) wrote:
>> On Tue, 2023-09-12 at 15:55 +0530, Jan Kiszka wrote:
>>> On 12.09.23 15:37, Gylstorff Quirin wrote:
>>>>
>>>>
>>>> On 8/28/23 08:47, Jan Kiszka wrote:
>>>>> On 23.08.23 15:28, Quirin Gylstorff wrote:
>>>>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>>>
>>>>>> Disable the timestamp of the do_install() task to
>>>>>> re-execute when ever a dependency on do_install
>>>>>> is executed.
>>>>>>
>>>>>> Without this change the sstate needs to be clean for
>>>>>> every rebuild.
>>>>>>
>>>>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>>> ---
>>>>>> =C2=A0=C2=A0 .../initramfs-verity-hook/initramfs-verity-
>>>>>> hook_0.1.bb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 3 +++
>>>>>> =C2=A0=C2=A0 1 file changed, 3 insertions(+)
>>>>>>
>>>>>> diff --git
>>>>>> a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-
>>>>>> hook_0.1.bb b/recipes-initramfs/initramfs-verity-
>>>>>> hook/initramfs-verity-hook_0.1.bb
>>>>>> index 3fc63ed..7435649 100644
>>>>>> ---
>>>>>> a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-
>>>>>> hook_0.1.bb
>>>>>> +++
>>>>>> b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-
>>>>>> hook_0.1.bb
>>>>>> @@ -40,6 +40,9 @@ do_install[cleandirs] +=3D " \
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ${D}/usr/share/initramfs-tools/=
scripts/local-top \
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ${D}/usr/share/initramfs-tools/=
conf-hooks.d"
>>>>>> =C2=A0=C2=A0 +# Ensure VERITY_ENV_FILE is updated also when rebuildi=
ng
>>>>>> initramfs-verity-hook
>>>>>> +do_install[nostamp] =3D "1"
>>>>>> +
>>>>>> =C2=A0=C2=A0 do_install() {
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Insert the veritysetup comman=
dline into the script
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ -f "${VERITY_ENV_FILE}" ];=
 then
>>>>>
>>>>> No other dpkg-raw packages require this, do they? What makes
>>>>> initramfs
>>>>> packages special here? And what about those in isar upstream?
>>>>>
>>>>
>>>> This is necessary for the initramfs package which contain the
>>>> checksum/uuid from the root file system build.
>>>> This ensure that the checksum/uuid is refreshed.
>>>>
>>>> It fixes the problem that an rebuild of a verity image leads to a
>>>> broken
>>>> boot after the build.
>>>
>>> And what will happen when the user decides to pin the UUID to fix
>>> value
>>> in order to have reproducibility? Won't that cause a needless re-run?
>>> Shouldn't this recipe rather make sure to depend on the UUID value?
>>
> Even with pinning and same salt and uuid veritysetup will generate a new
> roothash during the build.
>=20

That sounds like other reproducibility issues we have, eg. with mkfs.*
Can't that be fixed? I think it has to, otherwise dm-verity images will
never be fully reproducible.

> Quirin
>=20
>=20
>> This is a general reproducibility topic: The task checksums are
>> computed at parsing time and by that the tasks that need to be re-run
>> are selected. However, this is based on the assumption that tasks are
>> deterministic, i.e. same input data also generates same output data.
>>
>> Unfortunately we are still not 100% reproducible. By that this pre-
>> condition is not met. For normal packages this does not really matter,
>> but for the dm-verity checksum this very well matters.
>>
>=20
>> I'm just wondering if we could work around that by making this
>> component non-cacheable. Putting Adriaan in CC for the sstate part.
>=20
> The same=C2=A0 solution as is used by meta-security for Yocto[1].
>=20
> [1]: https://lists.yoctoproject.org/g/yocto/message/50624

Interesting - Yocto is NOT reproducible when it comes to verity...

Jan

--=20
Siemens AG, Technology
Linux Expert Center


