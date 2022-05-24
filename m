Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED1BC433F5
	for <webhook@archiver.kernel.org>; Tue, 24 May 2022 15:50:38 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.75])
 by mx.groups.io with SMTP id smtpd.web11.11150.1653407430561120744
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 May 2022 08:50:31 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=E6p+q2Mv;
 spf=pass (domain: siemens.com, ip: 40.107.7.75,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R31CKicZqpFjErEzkEhoUXq54xjokod0QunFQTEk+cYa9lwYMNvQiVHwZuUIMY/5iSQwF9fKZyyjsXUO0gvlOWPN5MnW8WuytUutC/wBEY/GETV8scKax8O4lucrQXq8uPDhMm0Z/BmE9qRW1PlPwa++BufvQmK5YUucRefkjeEU3Ux59epK1pq1redGVsl0r+RIBFvfizQODeS+h4PWl+SgnyeBVskdowiDw/lpmGMGQu2j9s4WG/4r+qaGoknXxQTxo+9KvNpwbDzh90Ti0tZ2Hgu7hi+ZMg0jOR+TEv7uYuaYGNzDt7FmHnF/Bj8arRGpc3isEluKsfR3pTGAdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2qfqzOGJpIHR/7S0LhUkRbOUts9ab94BxdHjn4l8nM=;
 b=b2LCT7WprT5qFk3GFTkicVjB0QL3igNIBVAhsJufXASIRcKtaUFeC9hxiIlTUv78rHh7bi6FA3NxF/HohZ8VlvsFw4GNpivYfPiE54x0+yMng4GMMqGOHdhG1PiLRG03+AS71JctQ3dLYgbmHjt+63HOvqjVtmB6Xuz8e0ZrYZ89Xgz/ySTi4P+PFf70wT7USkSkpIbD/hWRlEj74O4jHtpR2wu20vYDGLQO0P1McWvEalJQtaS8S35rz6ox92YcfszxLMG+qZPBn36jaNLX6/joTKpD5syiRLqH71dhjuSAlNMcbUocL0NWkKgxv30gfKYwxkm9AA5e2gXRugaNYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2qfqzOGJpIHR/7S0LhUkRbOUts9ab94BxdHjn4l8nM=;
 b=E6p+q2Mv8cYPJdwQ3W17C7VWeOC+SrqaitWBmV0g4hXGqSNiYbDgxbi4JUHtZiw/pJbRHNTvLSXO7SDHJb/j0N3G/Z3DpXJp9aP1v2k/ONIrq/KiO+H6SOPm1RokjwVzNuCpBhbPKJm17rnCOn02ZEs9BHnSdo8CtNprwSwX1eTXkyXG/LWmggsBQenEJhGdySoujImr73CP3oMIRISlPfSE2rRsWtqHrFG6L1skd8KOv7EW6eUPNoBfNrHKwVkaYWYxTcdyA1khtWkO1g3/4kRQaeRNeBVAWWAWlLJcLxAqkxYrmp6MWvlDwnPzQSQ4GpFdyZixYd9jwRi//+VpVg==
Received: from DU2P251CA0020.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::29)
 by AM0PR10MB2452.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e4::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 15:50:27 +0000
Received: from DB5EUR01FT064.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:230:cafe::2c) by DU2P251CA0020.outlook.office365.com
 (2603:10a6:10:230::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22 via Frontend
 Transport; Tue, 24 May 2022 15:50:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.71) by
 DB5EUR01FT064.mail.protection.outlook.com (10.152.5.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 24 May 2022 15:50:26 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Tue, 24 May 2022 17:50:26 +0200
Received: from [139.25.68.37] (139.25.68.37) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Tue, 24 May
 2022 17:50:25 +0200
Message-ID: <17b1a6c1-d06d-90ac-231a-e9226b28d143@siemens.com>
Date: Tue, 24 May 2022 17:50:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [cip-dev][isar-cip-core][PATCH] efibootguard-efi: Use correct
 search path for the efibinary
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <20220524145757.1704927-1-Quirin.Gylstorff@siemens.com>
 <8827c44a-366e-59b3-8062-d2d4b1dd47af@siemens.com>
 <17b20d92-af97-5598-8733-f9c625414394@siemens.com>
 <9cadf05d-a3ad-687c-9fd8-b3715173f2d7@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <9cadf05d-a3ad-687c-9fd8-b3715173f2d7@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [139.25.68.37]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--13.394800-8.000000
X-TMASE-MatchedRID: Cc2Ao8tLfKA5QaOxwNGfvo9bHfxDWoibWi7t2dR1S0YaLqFbxdotGQyg
	hFX0lxFwrP7fIroeSfODmItpkInC+sX5dLrRwDRDVPv3/UoKH3sDI91I0N0Y7wPZZctd3P4BJSc
	vOTX4jHNZdl+RWburG+nQk6dUeFKNTfV1RcxxkrQ9qsdubtvoYVL+KwgRcYO/x64UvlSkg3ESp9
	rqY6jeEjL/GHoao0dV0ZVCudkmoh4QQrxeVqUQQAH3zZVGDAWmgoTNcgEj13g4hD0Y/Y/a78nlJ
	e2gk8vIC9lxI7Zs/OljLORo1y6rxjE1l01VWuknLxxHBMdDc7oy7wvC8Uc6Hfbta0OAYFzyfS0I
	p2eEHnzUHQeTVDUrItRnEQCUU+jzjoczmuoPCq2lx4OyfWVu3sX7fu14T6+ldaqOo/msLl28/qs
	jqsR53H8EewTsr0tR
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.394800-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 1F6A4A25DD7965410D0C5B9C15D808BDCF7C93FC89A8C90CEFDE95E1637FE0252000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6de663f-6cc8-425e-f1fb-08da3d9d1f07
X-MS-TrafficTypeDiagnostic: AM0PR10MB2452:EE_
X-Microsoft-Antispam-PRVS: 
	<AM0PR10MB24528B56E57CC576BC037E0495D79@AM0PR10MB2452.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	RrufFQUPP2a5SF34xlfqIKmR56ln9Kfrj8fAX/IpH8QaAacm5PrmEjCWBt1czsMepY0xqwzRljF0y2xaTyFWHfQXOY1LiDrY36/+jd64tHIp4pUmmqIjkeXrHRveo65sg7M5PJac7HMQpdqulizoa1eGtGYgnrfC751F6IIF6G2L+/+F/VELNJBGTOf7nuPz+QoB6ahOMKIpgTIJNfAbvdxx1Tcb4jqHfshvvP3TlJcyGJdr7XZY2+cV5a2g/h37k4fTw3uSdr7LcgfD/IkfgD6OiMNNKt3SsngqhlU1L9xX70KlyyxoUmyNE1Okljgvlhc6Dy05a6bFNa1/CulAZNmR3Q6u/kGKYQrOXFppaNOsUmuz5lNsbdUi5uVPn4NH1C5v9xF+FtnwgEAjP0JEfC4h604NANuYnBSYxbgLQ/dtx3H3lOENxSYsG1bVDj6RZbX9mryXub7owgKydkTU6B3qaSGP7zJHlePs3DMUadN8GaTEmucqJ8tvgnfKdizol5soXyg1fnyftYCl+zyqhqxj6oVjgEpepkxdbqn/DzpSuH+E9EJ4Fp2kJCCFTf9XGDSjClGRX104mqT9uZfk7oZo5vByzteWqSRHIbjPSYj26JWvv5kGNTwCc8UlA5QUqKuMKBltucyDD34HTDVjM6GGEIadQ0MM+EddcGZSbhGvNv1MluqWyhYcGwGTnbPKhlrtW3QFVUYODxCEI0loYeFI75J0LQMYKeVQYoG5eAwJqAY+EvPD5nILiZyBrDoHt9/PT0YXqW+ncLFGfp0dUTesvumTnniXhbNMEo53lLVs8wCeU1/R/idTx3k/5ErYriezzSn5PE8yGcSh0wDtX4zoEw0hFD6qdpzC9xXMXh/M9ArXnfebzC845fDMJfrkk2vf9ZiQkVJ81pNFl2CJiw==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2906002)(40460700003)(8676002)(81166007)(31696002)(36860700001)(44832011)(5660300002)(83380400001)(186003)(86362001)(956004)(336012)(508600001)(16526019)(47076005)(110136005)(8936002)(36756003)(356005)(2616005)(966005)(82960400001)(316002)(6706004)(16576012)(82310400005)(31686004)(53546011)(70586007)(70206006)(26005)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 15:50:26.5339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e6de663f-6cc8-425e-f1fb-08da3d9d1f07
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT064.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2452
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 May 2022 15:50:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8433

On 24.05.22 17:38, Gylstorff Quirin wrote:
>=20
>=20
> On 5/24/22 17:23, Quirin Gylstorff via lists.cip-project.org wrote:
>>
>>
>> On 5/24/22 17:07, Jan Kiszka wrote:
>>> On 24.05.22 16:57, Quirin Gylstorff wrote:
>>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>
>>>> This fixes the build error:
>>>> ```
>>>> ERROR: _exec_cmd: cp /usr/share/efibootguard/efibootguardx64.efi
>>>> /tmp/tmp.1Y4utA1zC2/sentron-product-sentron-sentron.wic/tmp.wic.ampnaw=
p6/bootx64.efi
>>>> returned '1' instead of 0
>>>> output: cp: cannot stat
>>>> '/usr/share/efibootguard/efibootguardx64.efi': No such file or
>>>> directory
>>>> ```
>>>>
>>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>> ---
>>>> =C2=A0 scripts/lib/wic/plugins/source/efibootguard-efi.py | 6 ++++--
>>>> =C2=A0 1 file changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py
>>>> b/scripts/lib/wic/plugins/source/efibootguard-efi.py
>>>> index e1411cb..a01e484 100644
>>>> --- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
>>>> +++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
>>>> @@ -59,8 +59,10 @@ class EfibootguardEFIPlugin(SourcePlugin):
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 distro_arch =3D=
 get_bitbake_var("DISTRO_ARCH")
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bootloader =3D
>>>> "/usr/share/efibootguard/efibootguard{}.efi".format(
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 di=
stro_to_efi_arch[distro_arch])
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rootfs_path =3D rootfs_dir=
.get('ROOTFS_DIR')
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bootloader =3D
>>>> "{rootfs_path}/usr/share/efibootguard/efibootguard{efiarch}.efi".forma=
t(
>>>>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ro=
otfs_path=3Drootfs_path,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ef=
iarch=3Ddistro_to_efi_arch[distro_arch])
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 part_rootfs_dir=
 =3D "%s/disk/%s.%s" % (cr_workdir,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 part.label,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 part.lineno)
>>>
>>> Makes sense in first sight - but why did it work so far? Or did I miss
>>> to test one of the two cases (signed/unsigned)? Did you test both?
>>>
>>> Jan
>>>
>> I am still try to find the reason why it work in isar-cip-core. The
>> error occured in a downstream project.
>=20
> In isar-cip-core the error never occured as we install `efibootguard`
> as a dependency for wic[1].
>=20
> efibootguard-boot uses the same logic[2] to access the kernel stub.
>=20
>=20
> We should decide which is the correct way. I would prefer that we take
> both stubs from the buildchroot.
>=20

Yes, the preferred source for bootloader artifacts should be the
buildchroot and NOT that target image. We are currently installing more
on the target as practically needed. If that should ever change, things
shouldn't break here at plugin level.

Jan

> [1]:
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/kas/o=
pt/efibootguard.yml#L24
>=20
> [2]:
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/scrip=
ts/lib/wic/plugins/source/efibootguard-boot.py#L190
>=20
> Quirin

--=20
Siemens AG, Technology
Competence Center Embedded Linux

