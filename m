Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A310C48BF6
	for <webhook@archiver.kernel.org>; Wed, 21 Feb 2024 09:09:16 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.58])
 by mx.groups.io with SMTP id smtpd.web11.9145.1708506554609555215
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Feb 2024 01:09:15 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=LQzl2jYh;
 spf=pass (domain: siemens.com, ip: 40.107.22.58, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDzSEWQ2tLOkmKNe9PDvHzbtvnBEel1/fQV8Sn/g0EHKRXjOAmk5JhVeuksZ2syTd4yf2jEzUx7YClIs6B/gWsRKvuMi5s81fkTkOH4r/Qk0R1kjRKWk0oIUwiLvXcI6TdwK3sSJ88fyBpu9NNgaALf8IAZmDorMAgxuFiC+/Nz+YkNc6Tbd546DBB7z7yX+H5xCsmmTmYRZib69s0b3iC+f0a26t1DaGKqCzjbl5j0eyQSQGTMy7KzbxKxYvbnjy0QhEWkVHNRyV4beZzoo0ZoDpMkkCNukhoLqGG1D6RB/ki9T+tScDdekVHtrYIEYkuqGjk2UIdEpZc+6f9Xp3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=werxhsiIxsN9yUSASohtPFebofCeNGbbjBtAmoOEJ9I=;
 b=L4tUYG77RHmZIXRrd7jA4zQRHnulPCpfSGFTpT1mAG3lWYAYr99l660m8TTZkSi5+Yy208pwiDyxfkoCZrVIADEh4gg2zb5/U7EuPIeI32TYUungDCih3fa1o5C3qwbntiTMeLjp/FiR04F6JwzZUGzk6BSRhVXe1naVy2hfP6zNH3bY3/A3mou9m8UQ1XpVi2fDoqhgQ99tsSyG+fEh77/wFgiZmIHKYO55dzQ1xiIjgS1st+UGsob+2xU0oab+4PfjnjvhPm14f/6oJS25BxXZmVUyQbUq+iq9ZEgNW9YcYsBC/LrhayyLmBhkJdEAXnCpqWv4knbtBjMED6oaXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=werxhsiIxsN9yUSASohtPFebofCeNGbbjBtAmoOEJ9I=;
 b=LQzl2jYh4UuermFKBJ4jM7+udPu3XzC5NqxeC2t4yrT3SJ9OzClWztIrgevR1uniTk3iXTEQK2VpOu9R4Io/u4hx+Ykk0EqvvoksORmI+HK/IcnhwgcyZ3wuz0HeyB0zLlhSKl3Nka/xvDIYqiP43oGhVyVgUjDrgNHOIc1nc65zM7ZJPeoSaDATsIelM7Pda7Vp3CwhtOO+NgOKm/L2YwIchsbio1cgO4laNyo1mqslKlt9O7jj5ENeMLxbnxrQxSCQnZBJ9208qyfYUrrl4AUxBzXNy4tzpLSwpviVRIW4s1odNY1C56W9udSHCxX5lN5NcR/N99yNTcDMy7ftCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:392::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 09:09:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 09:09:10 +0000
Message-ID: <44066f2e-1a36-472a-925d-ffef067f6eaf@siemens.com>
Date: Wed, 21 Feb 2024 10:09:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dec][isar-cip-core][RFC v2 2/3] swupdate.bbclass: Add
 SWU_EXTEND_SW_DESCRIPTION
Content-Language: en-US
To: "Moessbauer, Felix (T CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Gylstorff, Quirin (T CED OES-DE)" <quirin.gylstorff@siemens.com>
References: <20231211122528.486786-1-Quirin.Gylstorff@siemens.com>
 <20231211122528.486786-3-Quirin.Gylstorff@siemens.com>
 <217b7c161aa3a608ff107d5f2661d384722a259f.camel@siemens.com>
 <10f157f7-4b0e-4900-a7c3-2ef1f08c5c8e@siemens.com>
 <402501ce19a19e4717d7b62ebdc495cd4fc853c3.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <402501ce19a19e4717d7b62ebdc495cd4fc853c3.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5835:EE_
X-MS-Office365-Filtering-Correlation-Id: 41bf3f30-f51e-4ee3-e3ab-08dc32bcc40c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	awJzHLPZ/ZZLfgRUZRPHDewXB99G4u6cCIFfWUfnfg/fc+FdRuoobFtPeZMd3UwiOe+wgyTXnFJGmadOGK6z12hdX9by+cGWuQVVTQVrPCp0xnJIM5ekWBpRNAt902HNQyQuR82cSmhTC0AOsB2JSs5AKeu/X4OGI/jLtnkFcQ2/cwOWtaRTVYzDoH4TbO+1QKlBAjQq0HilIEx/hv5GQRxXscPmb9raB/VzCAP3L5Ic5PO2eir+l5+yF6SzgjIu50YehhI45rUxHGAtArCulyyYevhnQS+AVCY/LsHuPpqL25bLunjEGlQtxRYwcpLpCyeAwQBzVe8ClBEBb2Cc9Y0LYLN7Q+mbXWYIhE14jw2ixfafIXGkdg6Ia+Ve88pZwpOBt1LG+G+dCXOIOH/XA55NrY1DJeK302OKp8aCd1JEa87WSFJz/Cg30F9pNxCw0U60xmQKn6W077ikSK4pkyQbseV6OloUR9sDFDldxGjI7VOUMoWWlw5DlyaQ0OnKfacD1U80/sDyWZCdv/7zLcfeOXdSFHUjOSAMkbN0t2A=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?v6t3XcgxlIG84BOq+d9Z5AyQ751WzQ/yZ50J3x1HTEMpFTgNz/TLNaLoEuSw?=
 =?us-ascii?Q?YAKceCboqE+POmuxS9bkhxo9tYEOYl/WkGlUDo6bQqaU/zpCu2NN3MNzISEd?=
 =?us-ascii?Q?Q3FgGb1lHPVdiRWHARmtM54sSPYsCYC8PfXQLxpi2gXn+sZh9+LMzd/YzR8L?=
 =?us-ascii?Q?Y8TB16qEDmx4BL4iZnH132mYnM/x9bISPST4Q2B7k+eBXuc6GzHgRjN0/pBb?=
 =?us-ascii?Q?26rNTHdfVr6uofrUpjRcvjJHK7UBlZ8xHCT3aKPRuh6U+MNaUArKEMvxe+9e?=
 =?us-ascii?Q?vGNTs4/gDK3WpLXceSLfpkDm95WHE9vmfXA+k27bAVOIGdfLLNIgZJmCuP6u?=
 =?us-ascii?Q?xOk8AwqgKUBej17zBzNuuPwP1e3QIP5VzjyfTFxwqWynPU2Buis3YMOnZ1lK?=
 =?us-ascii?Q?YvxpL5OCIAupLlos9+It1sR8ZxW/9+wgb0d0OGEbSCMF1ubFVMcSoXMNPBG8?=
 =?us-ascii?Q?+nk472sqTeojfrXSquzl+vt7MsxYyOuR2IoFtA3cPS99vtuF1UNFGKmcOnpp?=
 =?us-ascii?Q?iUDYWGHzDdoK5Rqr4oNDQeOLj8ny3ci6lt3v96yGaRpDdDz6Ikk0JV6vfKfn?=
 =?us-ascii?Q?x/OAhdyR6W4nlNYk85blK72ZwrFYBTYmOiKVsIoq14CNW2YlXFdpO6dFPBN8?=
 =?us-ascii?Q?CcZ7EqmcthL9FJQeg8wdYyp13WQCH77CWFvgBHt+EZWxQdqSLlOELZkXBNrD?=
 =?us-ascii?Q?ZPyjxtaaHAZkLsB7WyI7sYXGA0d5v+SBnUxQaDjSYTLBx1eOd7HnYuZMyA75?=
 =?us-ascii?Q?xlsY2/S83GleSiUr9veSXWutgGSQw76Qj29b9HP5zr4nUpnj3u/777envTSG?=
 =?us-ascii?Q?WOd7tDwtC88izvMOzU/jnJU4uPa3mc9QDJRT9bWHmVbSxHxK0gwPwedIqOvX?=
 =?us-ascii?Q?IoX1VuvopoEDU8xWuFW1K5/oOyIh4E5M0yXyfTpI67C4dsZrmawoEsEuusHu?=
 =?us-ascii?Q?qEC8rJYnfmES9AHuJlL1wAY7odZtGd5ZD84wC6eoSJG6TZ6GCDnUovPHgVZs?=
 =?us-ascii?Q?I95U3YbfMVpOqHZgwpoP6/ArKQUZJccScjv4fADekNceXnt1YmOdbFXpaZlX?=
 =?us-ascii?Q?MeIVgyRVGnsXAkmKsAt8ZA8ffTSpJISGoplcjdJWKfRTzn07x2aOAQGInghq?=
 =?us-ascii?Q?RPheiUEH60r7G+YBAxRoLNFOJqqfxtBlUdXjA5Q1CyCRsfDio6EDj8w32ppY?=
 =?us-ascii?Q?ErK4/qsGlbNCu7pUJh6q8WWO1DrGcViARa1pIfinCTVmVGYYxfRoLfJPG/Ww?=
 =?us-ascii?Q?NQQvxprUixg6gLadxmPdhC1Y2kJgdHHu55dNxOi0Bh2hPaCoDXATjYrs4m1k?=
 =?us-ascii?Q?1tq3oIX/aVtar0ryAouHdcueggDneT2I66vs5UIIFDEPc43XUrBEqD8NzRSb?=
 =?us-ascii?Q?PKlQgd23NDeXBxnu+aJIPBSYXqZljJaoHmnyO3jLVOXKiKkO2RJgbf8irzuZ?=
 =?us-ascii?Q?VqQwN1WQtPUTJ+9v4ekPbZ+XU6OfIvOP+aZX/jKmk4jmmEDQRkgtZmVnWC3g?=
 =?us-ascii?Q?0vTIEceuSnJUk9AeQvobO8sX/cK/QqxYqzZl6uCkv+YGjeAmalrUexk/FoUL?=
 =?us-ascii?Q?7CV6vUzhfjEnaLAUvRw4EFxPODpVKgItBygkm6o+DOGmtbaMYJ6qZWiJZKTy?=
 =?us-ascii?Q?3g=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41bf3f30-f51e-4ee3-e3ab-08dc32bcc40c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 09:09:10.5022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jxCmPVu2UWA/C4yLDRI+POAPRMQ0MODRuNSYunvNvOvF9R1U0IKWtCHL7N0SvGyE+h0dIAJ7KqFQaErTaiGYcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5835
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 Feb 2024 09:09:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15046

On 21.02.24 10:06, Moessbauer, Felix (T CED OES-DE) wrote:
> On Wed, 2024-02-21 at 09:53 +0100, Jan Kiszka wrote:
>> On 21.02.24 09:22, Moessbauer, Felix (T CED OES-DE) wrote:
>>> On Mon, 2023-12-11 at 13:19 +0100, Quirin Gylstorff wrote:
>>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>
>>>> The elements of the new variable are called as functions. This
>>>> allows the user to extend the sw-description file with new
>>>> template
>>>> variables and new entries.
>>>>
>>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>> ---
>>>> =C2=A0classes/swupdate.bbclass | 14 ++++++++++++++
>>>> =C2=A01 file changed, 14 insertions(+)
>>>>
>>>> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
>>>> index 117f9fe..0e95e3c 100644
>>>> --- a/classes/swupdate.bbclass
>>>> +++ b/classes/swupdate.bbclass
>>>> @@ -22,6 +22,7 @@ SWU_NAME ?=3D "cip software update"
>>>> =C2=A0# space separated list of supported hw. Leave empty to leave out
>>>> =C2=A0SWU_HW_COMPAT ?=3D ""
>>>> =C2=A0
>>>> +
>>>> =C2=A0SWU_IMAGE_FILE ?=3D "${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.swu"
>>>> =C2=A0SWU_DESCRIPTION_FILE ?=3D "sw-description"
>>>> =C2=A0SWU_ADDITIONAL_FILES ?=3D "linux.efi ${SWU_ROOTFS_PARTITION_NAME=
}"
>>>> @@ -53,6 +54,16 @@ IMAGE_TEMPLATE_VARS:swu =3D " \
>>>> =C2=A0addtask do_transform_template after do_generate_image_uuid
>>>> =C2=A0
>>>> =C2=A0python(){
>>>> +=C2=A0=C2=A0=C2=A0 cmds =3D d.getVar("SWU_EXTEND_SW_DESCRIPTION")
>>>> +=C2=A0=C2=A0=C2=A0 if cmds is None or not cmds.strip():
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return
>>>> +=C2=A0=C2=A0=C2=A0 cmds =3D cmds.split()
>>>> +=C2=A0=C2=A0=C2=A0 for cmd in cmds:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb.build.exec_func(cmd, d)
>>>> +}
>>>
>>> Hi,
>>>
>>> this function is completely off. As the swupdate.bbclass is
>>> automatically injected into each image, this function will run in
>>> EVERY
>>> image that is reachable at parsing time, during parsing. Please
>>> move
>>> this to a task.
>>
>> This is ugly, but under which conditions is this breaking the build
>> or
>> causing other serious effects?
>=20
> I did not observe any build failure yet, but for each image-variant in
> reach of the parser, the /tmp/work/ now has the following logs:
> - run.add_swu_compression
> - run.add_swu_hw_compat
>=20
> As each image potentially has many variants (e.g. -compat, -sdk, []),
> we are talking about dozends of logs and executions.
>=20
> Once the first non-idempotent logic is added to
> SWU_EXTEND_SW_DESCRIPTION, things will explode.

Ok, but this is not really a major issue (yet). Let's fix it for the
next release, though, and users can cherry-pick that fix earlier if they
have an urgent need.

Jan

--=20
Siemens AG, Technology
Linux Expert Center


