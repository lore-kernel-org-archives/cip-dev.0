Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEE3C433FE
	for <webhook@archiver.kernel.org>; Wed, 19 Oct 2022 13:24:53 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.43])
 by mx.groups.io with SMTP id smtpd.web10.7988.1666185885566089906
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Oct 2022 06:24:46 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=THXifRiF;
 spf=pass (domain: siemens.com, ip: 40.107.7.43, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbZ+jbnNIUuy7X78O+AP6d1aIb5vHkUuC6MCIoG7gLJag44xM2VCivQ3BMoZ+EPz2bPWxilMg4dMZXmGotURixxXaedqWA5/WNPHZPidJnhR3r6d3h0qJVU3KMVkHFGaOfN1f/aMTTN2981LKKpE+92X37ovxSf3qoABgnGcvhjuU1VrGeyR259MrS8I8I6bPPnxC0q+7cVuUdwVWvbPRA3GY/cgnI9b4wg6jdKvVOxlETArtAySwtnOOwiknf5e44i0h3DAGJJaMeuaVluoFdZPe7jjgz4ltuG5d2uahBRIXI9bw5JqKXOl/VkKcLlePkfSkVS2IOMLN5Ddj46WQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtPu/V96xU9lWxFm7bLMtluNl9O6xzhSIpOQZybcvs8=;
 b=STu1zpT7P4vgtnKIGMzrWXesUiS2o2u5kycXSkwSAQ8xOFeY5M89d5IGnd94dY0X7RWDGwekF10ojE2/01fXUYuyVc1xO4QZ1GEQBHjqzeHxHUEkrUmEvTAtquEE7mRsqc2VKXSuuB7ZUUqVraorFlfd29bQwdwQaH9mnS1S4flVjco2VgIVkB0p4oLuZVJrQSbzvmMBkPaVWbPtr3eOcWqAVLCaHNzmrqhZkyFxQEjH1BJo1a+fzVmjS3MP3ZNrEOM2+vVnmDAGvJzzVrSNo2KXfMeVwCI9PlBJU90TqhwhQnr710RQRnj/yswTyno67m7x3dsGv1mk0bsMD8c8Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtPu/V96xU9lWxFm7bLMtluNl9O6xzhSIpOQZybcvs8=;
 b=THXifRiF/Z/pBD1+JvaliJRZCAQElwH8Ks77rqv1ajDek19gT8hT78nqXhlIESnQUXDAD2QqEz5XVu+HOzU/65UxpqiC1ZSv0Coxxy7gQgYZsKdYBScqFgiDD2MBKEpzY92w2gpaSb/e7fhqLnQSp1uggOLHz97f8rNLMEXR3q4BPPhkd9qxnTeeaczQBNkpSh8rCgCXRr7KSD9yU4cot0XCd7CSRGhKsuIX+dz+2b6SYxVSYRPqY+ffzs8PQgKWr0m3v61YaNwHnquw0nHqe9lvkCuAwPYfLWvEuL7rCiNWDpNcVe8mKagHI1GFPbq3oMeEVQ9t4+YvQzx9EILbGg==
Received: from GV3P280CA0120.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:8::26) by
 DB9PR10MB7146.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:452::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.29; Wed, 19 Oct 2022 13:24:42 +0000
Received: from HE1EUR01FT091.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:8:cafe::f5) by GV3P280CA0120.outlook.office365.com
 (2603:10a6:150:8::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34 via Frontend
 Transport; Wed, 19 Oct 2022 13:24:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 HE1EUR01FT091.mail.protection.outlook.com (10.152.0.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.16 via Frontend Transport; Wed, 19 Oct 2022 13:24:41 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Wed, 19 Oct 2022 15:24:40 +0200
Received: from [139.22.133.243] (139.22.133.243) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Wed, 19 Oct 2022 15:24:40 +0200
Message-ID: <4c0ca00a-8a29-e10c-6a36-9f1c79099abb@siemens.com>
Date: Wed, 19 Oct 2022 15:24:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [isar-cip-core][PATCH 1/7] add recipe for optee qemu arm64
Content-Language: en-US
To: "Schultschik, Sven (DI PA DCP R&D 2)" <sven.schultschik@siemens.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20221019092117.5291-1-sven.schultschik@siemens.com>
 <c020dd31-5cc6-4be8-bee1-f313e816a817@siemens.com>
 <PAXPR10MB50374EF86982812226C025A6902B9@PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <PAXPR10MB50374EF86982812226C025A6902B9@PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [139.22.133.243]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--15.524600-8.000000
X-TMASE-MatchedRID: qeBAs1OleyZQ8KeJIgW2y2dZwlT0cB74Pg9yfk4YC0Y38vQ+IQtktdOo
	OI6ILwj2rcN9BdgNdeaHWMMz4DW4ujmcvaMWKiDIeSwJDTNFbzEoq8ZSCTK+aQPZZctd3P4BP6T
	ki+9nU39O+elk6C5rQJhk0IlW43clkssYQ+yKiMP++vFBYLLFFd5MntES9XX7cxMkBeI9K3dL9x
	4FCuBLUXj2Rh3ce3hohEzI3+mkzicyagPvoxWFg4ZlvY+BZiODArUjf9GxaNNoMLOoNHsM9ps7C
	fArGWFOoUhuKHSz/jbjG7lc3cmGGnVW+ZNmOD6QOiORBAq0r1pk4NvlU5uTNqygL0j4rnchOhJ9
	m53n4aC8YDH/UBNnmz/21AwfBazEz9YXdGTB0gO82cmKvpHScJXvqupO0P3ML8y5bOx03xkORjM
	32hn2bwIZ++dWnH7bmDf1GCyO16jnzlXMYw4XMAGLeSok4rrZC24oEZ6SpSkj80Za3RRg8C+Yhu
	Cqi5q9azW3UZukPCt9pY12bXJ4jv52yKGjpJtLjHlrtc0/6VU=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.524600-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 1B800379871DE482DC1BC3E741BA88A8C913E664F6EF8AE8D9F41C4F000AC2832000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT091:EE_|DB9PR10MB7146:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a297cc0-40c8-4441-2136-08dab1d547d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+n1eVWkgLpw30Na5A7gnqMBF4gi9ImhiGGQ0lIeQdwuUSSOW/LRR4NnehQktFbZuGfTNp/vjOt6LVqlMAJx3egSS+dAiXAKahd5DF4oLq83tIvagzzaM/P4g+b/xcIv/tMXqtinhVa0hQMB7LC85VoMWzEjcXR3w94CJFxuYoNK81rjpJLTAa1pELAcwZQxrpmN5j2uXdNfdgmI8p9NIbgqX/cChuUpOxpT6Wj9vCnLGbDgzCp0fb7dtVjRKcZp6GulUk3Xy/mVDVFaln4pIDMjTXGSH3T3CGDx4NsC7TjVP0PHbGi+qDNN60gi7BEm3Dv2PWCsYV8jJvjl6ioLxcvwghyPy1+7/2N9z8p27hRCPEN68gwlozz2HNfGfDn0aenZ1H7cEIlG9DbBWN2NlDfpGVUDgFPAt9K6fpsBiWIqu7cjS8urse5/ov+GHltbb8L2f+JMU743hsr8IjpRqpHeu7LJszXDpRxwqT4xF841zqVgZWfaFEuf5m6zRtJHo+OXM8NVcQ4IUzos8u0AQvRO7efBnHdewGzxVtLE80cgr8mb7euTh7o1pJz0gcx9J2LCm/n4ST0g1N8Q2x8IBQQPeX1n6NukylYIKAIu98k3urrZYQ8HmvJ6IttxFv8zi6QO3ofFHo/cA9wsRMjBfqLkpPFAXJHO1NOjea9XaTZLR4RADXzE3HQ4dOP5NKQXNRBYId1y3GjGo3gt1EDMW5P9SqwQVoFsnTK83EZgadC5Wa0uNCBf+MIGp1OxwausgTC13qj5mHePn6HtlLuaAG8DxfiKofsyzq8018jAs8nKgdIiGFWe79X7L0gm69wDSDPIT5DdntA9C0cQRL1Jxc2jeHyRORvCGoyXuFtSodVitxiJmGHxCEZ5YKv/jM+3KjHR1aHylefruMHis51RgTg==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199015)(36840700001)(46966006)(40470700004)(956004)(2616005)(83380400001)(53546011)(336012)(26005)(478600001)(16526019)(186003)(34020700004)(40480700001)(44832011)(5660300002)(40460700003)(2906002)(110136005)(8936002)(82310400005)(316002)(70206006)(41300700001)(8676002)(6706004)(70586007)(16576012)(66574015)(47076005)(36860700001)(86362001)(82960400001)(31696002)(36756003)(82740400003)(7596003)(356005)(7636003)(31686004)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 13:24:41.6356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a297cc0-40c8-4441-2136-08dab1d547d2
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT091.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7146
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Oct 2022 13:24:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9790

On 19.10.22 15:21, Schultschik, Sven (DI PA DCP R&D 2) wrote:
>=20
>=20
>> -----Urspr=C3=BCngliche Nachricht-----
>> Von: Kiszka, Jan (T CED) <jan.kiszka@siemens.com>
>> Gesendet: Mittwoch, 19. Oktober 2022 12:44
>> An: Schultschik, Sven (DI PA DCP R&D 2) <sven.schultschik@siemens.com>;
> cip-
>> dev@lists.cip-project.org
>> Betreff: Re: [isar-cip-core][PATCH 1/7] add recipe for optee qemu arm64
>>
>> On 19.10.22 11:21, sven.schultschik@siemens.com wrote:
>>> From: Sven Schultschik <sven.schultschik@siemens.com>
>>>
>>> The recipe provides the possibility to create optee-os binaries for
>>> use inside of an qemu secureboot setup with edk2, rpmb, u-boot and
>>> uefi
>>>
>>> Signed-off-by: Sven Schultschik <sven.schultschik@siemens.com>
>>> ---
>>>  .../op-tee/optee-os-qemu-arm64_3.17.0.bb      | 57 +++++++++++++++++++
>>>  recipes-bsp/u-boot/files/secure-boot.cfg.tmpl |  7 +++
>>>  recipes-bsp/u-boot/u-boot-common.inc          |  6 +-
>>>  3 files changed, 67 insertions(+), 3 deletions(-)  create mode 100644
>>> recipes-bsp/op-tee/optee-os-qemu-arm64_3.17.0.bb
>>>
>>> diff --git a/recipes-bsp/op-tee/optee-os-qemu-arm64_3.17.0.bb
>>> b/recipes-bsp/op-tee/optee-os-qemu-arm64_3.17.0.bb
>>> new file mode 100644
>>> index 000000000..5e60041af
>>> --- /dev/null
>>> +++ b/recipes-bsp/op-tee/optee-os-qemu-arm64_3.17.0.bb
>>> @@ -0,0 +1,57 @@
>>> +#
>>> +# CIP Core, generic profile
>>> +#
>>> +# Copyright (c) Siemens AG, 2022
>>> +#
>>> +# Authors:
>>> +#  Sven Schultschik <sven.schultschik@siemens.com> # #
>>> +SPDX-License-Identifier: MIT #
>>> +
>>> +HOMEPAGE =3D
>>
> "https://github.c
>> om%2FOP-
>> TEE%2Foptee_os&amp;data=3D05%7C01%7Csven.schultschik%40siemens.com%7
>> C4f98c0d0333a4da5414a08dab1bee02e%7C38ae3bcd95794fd4addab42e1495d
>> 55a%7C1%7C0%7C638017730602326587%7CUnknown%7CTWFpbGZsb3d8eyJ
>> WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C
>> 3000%7C%7C%7C&amp;sdata=3DEnwEqlIP690Rw3fcrJv0Wc9dfcAc%2BN8h4O%2B
>> yRdvsXX4%3D&amp;reserved=3D0"
>>> +MAINTAINER =3D "Sven Schultschik <sven.schultschik@siemens.com>"
>>> +LICENSE =3D "BSD-2-Clause"
>>> +
>>> +require recipes-bsp/optee-os/optee-os-custom.inc
>>> +
>>> +SRC_URI +=3D " \
>>> +            gitsm://github.com/OP-
>> TEE/optee_os.git;branch=3Dmaster;protocol=3Dhttps;destsuffix=3Dgit;rev=
=3D${PV}"
>>
>> Do we really need the second-class supported gitsm fetcher here? Also,
>> destsuffix and rev are both redundant (they are defaults).
>=20
> I tried your suggestion and removed destsuffix and rev and now I remember
> why I added it initially:
>=20
> SRC_URI +=3D " \
>     git://github.com/OP-TEE/optee_os.git;branch=3Dmaster;protocol=3Dhttps=
"
>=20
> optee-os-qemu-arm64-3.17.0-r0 do_fetch: Fetcher failure for URL:
> 'git://github.com/OP-TEE/optee_os.git;branch=3Dmaster;protocol=3Dhttps'. =
Please
> set a valid SRCREV for url ['SRCREV_default_pn-optee-os-qemu-arm64',
> 'SRCREV_default', 'SRCREV_pn-optee-os-qemu-arm64', 'SRCREV'] (possible ke=
y
> names are git://github.com/OP-TEE/optee_os.git;branch=3Dmaster;protocol=
=3Dhttps,
> or use a ;rev=3DX URL parameter)

Right, it gives you an even better suggestion than I what to do /wrt
SRCREV when you have multiple repos (not here but in edk2).

--=20
Siemens AG, Technology
Competence Center Embedded Linux


