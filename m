Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2EAC433EF
	for <webhook@archiver.kernel.org>; Tue,  5 Jul 2022 18:42:30 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.49])
 by mx.groups.io with SMTP id smtpd.web11.87823.1657046544926729135
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Jul 2022 11:42:25 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=sc8VXdo8;
 spf=pass (domain: siemens.com, ip: 40.107.22.49,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMz7LLbgfctnPCdJLi0Ay600PCf6rV8h16bfZUzJlhM6Q2bD5VmuMBDgVlbQAnAwjpS1XbNuOpad60xDHdTC3hTuyJFBFgeSYWg5oFerGJmAMyXqWASnZHa3Kc2pX/rvcOVJWWDRKqg1AKVg+apEFXoJodxW8acSZkvMX6MpYwqZZrLN/NGhG+fetop8YwkefVn9JIAQkob51hQaWYzKqTRWluZ2m6qpxJVcK5P9PYMS0Hg8ynb6UEo02F3RUkJ8g+KWn8Jwvm3PpDvhB/TpD2u6NMKioRQ7vOfEYoIv+f3UNoN1vukNs/X0xuDW4qBw3sZjzHPsvLIhw/813fgYTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQO0Ieer1TWB1KiaJJf6DXTaTNMsGSXWnYCbh2I9jzI=;
 b=ZmNtqnbzPympYppvUYYshr5ENZSEarGG8YgYmwNh0RFsRRA8k36HEpHCnKzDd12cZ736wsyAVpYZ8WBw8GLJAkQ8cijCdixugDB1d8Fi9WbWiVD+LZm+hD5hHS7KDCFqNcJ4N+OZkg6ja+nZ3u4bee39xzN0KzgpM4v9Zdh/WiU9hiUj+sRTeM1e4yXqd4hVGhYFFlTZN25L5AV6/WDIcb9qpyfv2qG2dmZXTB1LMw5I8qxlNKUNtt4QrTS0qtvihRScru1FR4z9iKrHa7aoVBQTFObhDFbqwZrtnKjjch2rP21YyDDi2SvmPrLQF5+fMMGus+h0RcC/ny8qXGhFuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=toshiba-tsip.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQO0Ieer1TWB1KiaJJf6DXTaTNMsGSXWnYCbh2I9jzI=;
 b=sc8VXdo8oYD9hAHyb4a3K18VS+EN9oVYcG0QeH8+Q1YBE6SFsGQiw45bjP2hjdPCxtTLQPlKhYX1fihqvlm2uAUEeiDihgIlQep1n16/SrBMCZSq+tW6pFyc4LZqVFPDJ0kyECjStKxlB/sIZYStyP9V2XPyC16LXc5U/y7qMYkAqFGFP7evBzf05KohoBXg9x83gp/pKa6UgRh1nZoQC5guygef5Q45+643VH2Iq8m85zvv0hvn2CA4z+3THDBQgHtvwCyenGbDJN/Eqn2C9NiZGffr4FtEQShVuPksBWUvj/H8hf148NGImshF/oAWRMjLxQoK4r9NJEcgepsAZQ==
Received: from DB6PR0202CA0027.eurprd02.prod.outlook.com (2603:10a6:4:a5::13)
 by VI1PR10MB2349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:81::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Tue, 5 Jul
 2022 18:42:21 +0000
Received: from DB5EUR01FT013.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:a5:cafe::8d) by DB6PR0202CA0027.outlook.office365.com
 (2603:10a6:4:a5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15 via Frontend
 Transport; Tue, 5 Jul 2022 18:42:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.72) by
 DB5EUR01FT013.mail.protection.outlook.com (10.152.4.239) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.17 via Frontend Transport; Tue, 5 Jul 2022 18:42:20 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 5 Jul 2022 20:42:19 +0200
Received: from [139.21.19.13] (139.21.19.13) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Tue, 5 Jul 2022
 20:42:19 +0200
Message-ID: <52dc6b82-03ff-f143-a54e-da936e4f2924@siemens.com>
Date: Tue, 5 Jul 2022 20:42:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [isar-cip-core][PATCH] security-testing.yml: Add kas option for
 IEC layer testing
Content-Language: en-US
To: <Venkata.Pyla@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
References: <20220704172122.11322-1-venkata.pyla@toshiba-tsip.com>
 <b8271bd9-8574-4bc7-9c96-5dc8843d22f0@siemens.com>
 <OSYPR01MB5542CC30289B807E5A66A5AAA4819@OSYPR01MB5542.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: 
 <OSYPR01MB5542CC30289B807E5A66A5AAA4819@OSYPR01MB5542.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [139.21.19.13]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--17.220300-8.000000
X-TMASE-MatchedRID: qeBAs1OleyYwrKi3eh3JIsb9CgEQmMW5Pg9yfk4YC0bM1jffIgQXhr/k
	INU/9Cx+fhcIM0AFu8DZTAEszxrPVPGwUUhZtzr+6hyvCHatgOnFC7Ja5OfrKgdHNpBuxrOoa2p
	CAnJvQFEXR19nmRX2X/s7JnUrxLXXVHll461yvk4C3U6IhW4BeqJVrIWbE6AHT7O/YHJhINApA2
	ExuipmWgdkFovAReUoilvAb18i4hPjq8Vr7gTGbtQfNGn/5BppAuvQFdmopk9O8qlnOXFSzzB4t
	WHctlhIgCOzL6v7C+e4iCuQ76IBEb7O+YHGOXsu5ip+Ou5j4UrbsL0F6Nbalo6cpbnLdja9gOn9
	DzGCF7OhSG4odLP+Nm8ZIm25saftpb5GCewFZcAMAIfZEbI3hWJIEq3r88+zXmFVlObh0PxBfkJ
	WKY0KaQrVgpI9tRVko8WMkQWv6iWhMIDkR/KfwI2j49Ftap9E4kYXbobxJbKl/MtrTwS4UEuSKI
	Gzo8v50Xq4i0KKW6ka7l09rrGZCJzkCcu8JH68Dm4dF7WRZWY=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.220300-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 11CC652A840B0947CE705F3B0460EA4AD6B12E0CC7146B6D2B99E2CEBFBE08A42000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1792155a-0b86-4598-1430-08da5eb617f3
X-MS-TrafficTypeDiagnostic: VI1PR10MB2349:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	rr9j5ncYX3bWLl1BBxjMN1hgcc7bBgO1ebfp/GYtCKr+yAP4lq+9W2E/9Jaig41lLhdS/CKiBC4/XVXEvrFiHUu37PsswuXSC6em+UxNUVTOq03fXVOAtv/nMlX0P7k5KVYj3/Nd2xytuyE4feUm/4XGN2hRMZMFO+gkkmxZSJc2LvO6ewh1Ygp4tmGIlMNT4lYnUOi5QivjXeVHu2BYjPqPMTFeJI44bOU0tCEv94BugnZecpZVZDrIwRQimshJkFistdICoOv7lDqRyd8AoxRzE6crwwfuEI7PnEUakk5DpHvie0nDFUqEVhukEYJHgFbu2cwvUaVM9HnbubJKDaMmPvbgMTEdMQ9vaCn+hBSRiLGrXvItDoTVtghzLkXm3Di/PqlgBRvKMi55vVwiOQkFCIDPKUZJCkbjkhDHu9+4vwehKOZbchsW/umBCu93ZSzj2u+NtqHUFjOgMxMHEm0/1c5q2GLDHFgXrFxE41k9adogKjxyY0rWv/y2a0pHV04Y0DLbHP8WTZuige7a+TK2e73sSH9kviVCdO6uiYjRZvxw4um7XcO8+50Lz1t9My6o9zMuXPGdTR8Ie+FDwVq5uWSw3qU4PrjXh1J+ofRMLidIToifXSO79eU+/PVZCoyt4m94rbW+ICtHHpyTFDxn6QqjEertPqUk05zCOOGLlKDtvlZiK2alzFZzeL4PsEfqtlysZdihHyB9GrpBIMIhL6cf9P9lGy6pQVFbz/0Kpkku700lyaxSoj/n346fQimASa3R1HGHx+UfKZrlcdHr36XoyA0mpoOboibbmxjW9ah3oMLV2otKVFw5CIk9P5whp++ROYjrpupulxBabYa1MlsfEOlQFiSQQUhuHd/rtTAuQTDIKRFaKDBKcGR9y3KaPaRcdArdNkFl81X0pNY6Abjl1lAeDA/WlhzgduHp+2/Bcrf9XLEXqEmQh+MF
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(39860400002)(136003)(346002)(36840700001)(46966006)(40470700004)(47076005)(336012)(83380400001)(54906003)(36756003)(41300700001)(6706004)(186003)(36860700001)(40460700003)(316002)(16576012)(110136005)(82310400005)(8676002)(4326008)(70586007)(70206006)(5660300002)(81166007)(8936002)(356005)(2616005)(956004)(966005)(478600001)(16526019)(31686004)(86362001)(31696002)(44832011)(15650500001)(2906002)(82740400003)(82960400001)(53546011)(40480700001)(26005)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 18:42:20.4468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 1792155a-0b86-4598-1430-08da5eb617f3
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT013.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2349
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Jul 2022 18:42:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8686

On 05.07.22 13:14, Venkata.Pyla@toshiba-tsip.com wrote:
>=20
>=20
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: 05 July 2022 14:24
>> To: pyla venkata(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting)=
 <Venkata.Pyla@toshiba-
>> tsip.com>; cip-dev@lists.cip-project.org
>> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0) <dinesh.kumar@tos=
hiba-tsip.com>; hayashi
>> kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =E2=96=A1=EF=BC=B3=EF=BC=B7=EF=BC=
=A3=E2=97=AF=EF=BC=A1=EF=BC=A3=EF=BC=B4) <kazuhiro3.hayashi@toshiba.co.jp>
>> Subject: Re: [isar-cip-core][PATCH] security-testing.yml: Add kas option=
 for IEC
>> layer testing
>>
>> On 04.07.22 19:21, venkata.pyla@toshiba-tsip.com wrote:
>>> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
>>>
>>> This kas option file adds additonal packages required only while
>>> testing using cip-security-tests[1].
>>>
>>> Also it provides additional rootfs size required for testing.
>>>
>>> [1] https://gitlab.com/cip-project/cip-testing/cip-security-tests
>>>
>>> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
>>> ---
>>>  kas/opt/security-testing.yml | 20 ++++++++++++++++++++
>>>  1 file changed, 20 insertions(+)
>>>  create mode 100644 kas/opt/security-testing.yml
>>>
>>> diff --git a/kas/opt/security-testing.yml
>>> b/kas/opt/security-testing.yml new file mode 100644 index
>>> 0000000..19215f1
>>> --- /dev/null
>>> +++ b/kas/opt/security-testing.yml
>>> @@ -0,0 +1,20 @@
>>> +#
>>> +# CIP Core, generic profile
>>> +#
>>> +# Copyright (c) Toshiba Corporation, 2022 # # Authors:
>>> +#  Venkata Pyla <venkata.pyla@toshiba-tsip.com> # #
>>> +SPDX-License-Identifier: MIT #
>>> +header:
>>> +  version: 10
>>> +  includes:
>>> +   - kas/opt/security.yml
>>> +
>>> +local_conf_header:
>>> +     security_testing: |
>>> +        IMAGE_PREINSTALL_append =3D " sshpass"
>>> +        ROOTFS_EXTRA =3D "8192"
>>> +
>>
>> There is already kas/opt/test.yml. Can't we piggy-back on that one?
>> Would also already come with kconfig support.
>=20
> Yes I thin so, we can also add security testing requirements in to test.y=
ml,=20
> but does it not create any side effect to  the original test image?
> security testing requirements adds additional package `sshpass` and incre=
ases=20
> the rootfs size.
>=20
> Or, can we select the local_conf_header fragment ('testing' or 'security_=
testing')
>  from the kconfig based on image is selected?=20

Adding Nobuhiro, he once wrote that. But I strongly suspect the impact
is not relevant, in both directions. If there should be, we can look
into image-specific additions, but via the same option file.

My goal here is to keep the number of kas option files low whenever
possible. From a user perspective, it does not matter if a regular or a
security image is augmented with testing features.

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux

