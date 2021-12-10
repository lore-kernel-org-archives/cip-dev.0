Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B932C433EF
	for <webhook@archiver.kernel.org>; Fri, 10 Dec 2021 10:40:37 +0000 (UTC)
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (EUR03-DB5-obe.outbound.protection.outlook.com [40.107.4.48])
 by mx.groups.io with SMTP id smtpd.web11.5646.1639132826076822027
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Dec 2021 02:40:27 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=vMYGjzGw;
 spf=pass (domain: siemens.com, ip: 40.107.4.48,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K46BjK7M17tiqXEk3+8c7TXXIPjg1c2F0XI+83ztStJGqym70cEkxP4AsrxL4qm8nCwq+xomSyRiDvlqPsgAlgbMJRaEiG36i4+SXD80LxygQ9pxB2kPwQTYsZn0Jhajaaj85dd/6ETPA63LhzR+0iLCrsT4gi0P5cgJ/84qE+38ah1/SNSlQs334aNW6fDTMaKCl5yJGcSoLY/B+OX06TMmf3jAj8xiVUezgt+c4MLSAQJ9cPQyoAIRe2LrjDnTUlXzeSM3zfSQ6gV0b20/UBSwyUCJChc+lm3zfYkqi+DFVJh9g2wiVNLEwDFWRSqnGTFzX2QoXBdHiJmVX9apVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWgOAHSzdSfbJCnMJVyD0pBQvQZVltyYURmW6mWvQrk=;
 b=ElRer7A7r4U0mNO3ENGgd4006p3vt2PwqAxiRo1knyQeIFWpg932EgMfrisBiZPmN4lkVeoumDPiac2yRKD+gnY+vPG9idqvXK6xa0MeeGC1TkqbwyU4xtKN6VIAV3P9/NgG02kzGiv6r7z0LEEItCklRFkd/pjwJhnjDxRAuBNezvTmFwItDoX05rJPM+/DMVmz+zfM4mzywMJd4M+IQ+/zvl4VEr8FonPPXtwgdc/kvAzq/C34uAtr9ueTjM+Q1ddEpH8fa8aLU33jclBKJGhu0eWgmlj2lR+xf5zfjY+bXW776KqvYoL6CLbvAjzclpDsxg5DRVbF6pcUdO16bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWgOAHSzdSfbJCnMJVyD0pBQvQZVltyYURmW6mWvQrk=;
 b=vMYGjzGwb2uHDltWyq+RFAxFed2vfTETLdcWbSLDOB1XjBnm2rMEVo81CUK5nZez34uWVkRSrNGiMwdYzkx69gnUTUv5Zt5lhcp6R89rqaZ3yFd44FEtdN0iWdpNRfMJCGC2imiagIM22nruM35ztlhtoLHp23jk76o0OmvtoYk4OLPT88TJFrUNtKjvcnEeO44Vnk8VMuyMWXBltqjQ23uKaKqLBEoCdXBiWY87ROX/7MSmlSPy8AEGZTdEFWfOHYeosFbEQIIVS/WjeOKL6EypfGlyZTSNwNzOhPG0jNYiFCFO+E9YcKwBWaNICxWaj0aeqtQi7xqSreEmeAotlw==
Received: from DU2PR04CA0020.eurprd04.prod.outlook.com (2603:10a6:10:3b::25)
 by AM6PR10MB2759.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:a8::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Fri, 10 Dec
 2021 10:40:24 +0000
Received: from DB5EUR01FT054.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:3b:cafe::ed) by DU2PR04CA0020.outlook.office365.com
 (2603:10a6:10:3b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend
 Transport; Fri, 10 Dec 2021 10:40:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.71) by
 DB5EUR01FT054.mail.protection.outlook.com (10.152.5.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.12 via Frontend Transport; Fri, 10 Dec 2021 10:40:23 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 10 Dec 2021 11:40:23 +0100
Received: from [167.87.72.174] (167.87.72.174) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 10 Dec 2021 11:40:23 +0100
Subject: Re: [cip-dev][isar-cip-core][PATCH] conf/machine/*: Add variable to
 set version of kernel defconfig
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <20211210093448.1860864-1-Quirin.Gylstorff@siemens.com>
 <c482fbfe-53b4-5d80-c84f-914343e224e5@siemens.com>
 <32192e47-078d-ddf5-35d4-68ca7d197616@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <090f184f-056e-065d-4c82-242f59dcc186@siemens.com>
Date: Fri, 10 Dec 2021 11:40:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <32192e47-078d-ddf5-35d4-68ca7d197616@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.87.72.174]
X-ClientProxiedBy: DEMCHDC8A1A.ad011.siemens.net (139.25.226.107) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8985c12b-a2a7-4398-707b-08d9bbc978bc
X-MS-TrafficTypeDiagnostic: AM6PR10MB2759:EE_
X-Microsoft-Antispam-PRVS: 
	<AM6PR10MB2759F2557418B691BE9B680395719@AM6PR10MB2759.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jWudf794s1vDqq8uG4nPtuF6eP9FipEtxBWd7JqZt8ggUrYP7KV8wu9zRxu0H03njKVgu+7jhqyD+iHxh9igadOhMSkBxxicMTRFhgZda02YrDKB++TrwICv7zmWracOYtIkvpDMi9cHf3J92adbo4PgJTUcg4zfFHFgHtKLKY4IQjGiUJYrzJOtmfaJixBbnzTHuV72ci8L6W7HgIvFcBw5Z5fe7me49Yyk4sF06HM1UyS3EV/S4TRulMFvIYUu9i+GFtFv3lVnbmjZctxRo5x07/hn+JNJ22xQYWjpiQtq5pZMMRu+bGtvKy20mSsxv9z/ZVtQL+R71SR3brWdFD9hkfLm6xzhANc1nu8g2Q4e+BFnvjOSEtR6HWegNgRC/0DBc1tSpzb+3IH4LKHfFohXuOdtaOYFrYMAFQFpqfe+oVNR273ncRlE3J/s1K888ORYhd8dSpB3AFs3XeaHiu3G6mfp0Mih9+Il8OLGv0S4ZvTQYaSIljiujZGuFHjPXUsOgZLixO94lM1Q/4H5NUVBKYmH3l/s6Ku17cyueEGmbKX0hDiwySre8mDlYpUrTGQVLhJNzsJDleyFDxwLe5A7NXZKGyowXyeL845Yh8DW9mSJ/RB9wMmg1gUHMt7Klb2X9Pn33in3/ZbEdR4Dz0dr5Pyr2j22uJVFTB6HG9z0jCofVAb7Azot92ywyaOZeg5QtQ0Nmsl9tl0it4dgpTI7CAvER6Ts41znl4DPYkbg7jlL+6GKhTG7jwCvfbJTnmK4WthpzfD6NeHzl4t4I5MM8Bc9SjNIoxL1T0lONV/YdrFtqBQM8l5GDXht/QuYjPbn/Z0EgeL6Qu0KGqmg8rTU4OPC58SgEN1DyjN+2bzh1fWInTQobt0ViUuVd4rlncXOCXTOG2GGIXO6Iq/ypjkSK2fPjoTOprpBpVAjQ80=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(26005)(31696002)(70586007)(956004)(336012)(70206006)(82960400001)(316002)(2616005)(16576012)(2906002)(110136005)(8936002)(6706004)(81166007)(36756003)(356005)(186003)(53546011)(508600001)(47076005)(16526019)(36860700001)(31686004)(44832011)(8676002)(5660300002)(966005)(86362001)(82310400004)(83380400001)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 10:40:23.7446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 8985c12b-a2a7-4398-707b-08d9bbc978bc
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT054.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2759
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Dec 2021 10:40:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7087

On 10.12.21 11:38, Gylstorff Quirin wrote:
>=20
>=20
> On 12/10/21 10:58, Jan Kiszka wrote:
>> On 10.12.21 10:34, Q. Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> This fixes an issue, that the defconfig from kernel 4.19.X does not
>>> work with kernel 5.10.X. The kernel boots but cannot find any qemu hard
>>> disk.
>>>
>>> The fix adds the new Variable
>>> KERNEL_DEFCONFIG_VERSION to select to correct path in [1].
>>>
>>> This fixes issue [17].
>>>
>>> [1]: https://gitlab.com/cip-project/cip-kernel/cip-kernel-config
>>> [17]: https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/17
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>> =C2=A0 conf/machine/hihope-rzg2m.conf=C2=A0=C2=A0=C2=A0 | 3 ++-
>>> =C2=A0 conf/machine/qemu-amd64.conf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 3 +=
+-
>>> =C2=A0 conf/machine/qemu-arm.conf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 3 ++-
>>> =C2=A0 conf/machine/qemu-arm64.conf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 3 +=
+-
>>> =C2=A0 conf/machine/simatic-ipc227e.conf | 3 ++-
>>> =C2=A0 kas/opt/4.19.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 ++
>>> =C2=A0 kas/opt/4.4.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 ++
>>> =C2=A0 kas/opt/5.10.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 ++
>>> =C2=A0 8 files changed, 16 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/conf/machine/hihope-rzg2m.conf
>>> b/conf/machine/hihope-rzg2m.conf
>>> index 4f4ee81..74f03df 100644
>>> --- a/conf/machine/hihope-rzg2m.conf
>>> +++ b/conf/machine/hihope-rzg2m.conf
>>> @@ -13,7 +13,8 @@ DISTRO_ARCH =3D "arm64"
>>> =C2=A0 =C2=A0 IMAGE_TYPE ?=3D "wic-img"
>>> =C2=A0 -KERNEL_DEFCONFIG =3D
>>> "cip-kernel-config/4.19.y-cip/arm64/renesas_defconfig"
>>> +KERNEL_DEFCONFIG_VERSION ?=3D "5.10.y-cip"
>>
>> This variable must be set by the kernel recipe, not the machine.
>>
>> Jan
>=20
> Ok, my reasoning was that I want the variable near it usage for
> readability. It is only used when the KERNEL_DEFCONFIG is from [1].
>=20

The machine config has no knowledge about the kernel version that is
going to be used.

Jan

--=20
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

