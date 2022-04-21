Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0974C8303C
	for <webhook@archiver.kernel.org>; Thu, 21 Apr 2022 16:46:12 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.47])
 by mx.groups.io with SMTP id smtpd.web12.21550.1650548333652646794
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Apr 2022 06:38:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=jvOXc6aL;
 spf=pass (domain: siemens.com, ip: 40.107.7.47,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1y4lEU1qV3ZBEmRH8ggb+OUJE90WasUFEccToyB9aBQZfKOO33jtdEzegu9HmWx1r4T7hgmZK4qiW2OSrkxuFoCIfDdQlEH6t15c1YbXVnXca5BKzz4YCk11amhWWS1Ek5KDWqgv0BU1WzDFMzAPzQD5uxktVw4FzdflbuU9PyMYmSYR962Ezj+6afBkolg5c/C9gPS57qDmp5ua7kfElWf+UEr0Luk2GNRUFHdvVeZnaJCyBRUlpeHXad3ktEfXD7daC7ZaT5jTjDRMkP4yFbr8JqDPUapFcnT5nUfzVQr6UiMrBmE6GKPQfGADzPMt9zOKBUYJ6CSdGiveLMStQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/7u77xKQyVomcX+R+hHVB2igJORK65mtTYEXXCidM8=;
 b=edcxFcvatrw7t/+DtlZZJcFoUx3Q/zs7Pp8PeEkJDMq7CZorX4h2LC4MpJ+X7k1F1wuXqsf093V/Bns5QgFOw37A2fogNw1M2dF2ikIBIkZW3Rv2C1t1eZJOMYXr0tsaRMf/DJo77Rdx6g/XdjF57o0A3debcpom1lEJwisi/YtX6ll2QZKKFfXgbv9ZqigeqcQsNpY6nKkf36wFpdgNM4PW6K+lwWvLyByjilDjU5Opc3wh+fqHP88XhJvRRB4/122Tp4cBn1/uHr8i4g+K3Res2aoB7nc+V/KtP731r1hFjcWhMza1LdrR/KzqpYV0IxxtgbSpC/M3BTI5piIn0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/7u77xKQyVomcX+R+hHVB2igJORK65mtTYEXXCidM8=;
 b=jvOXc6aL0GGoQzLQlrnuY8L7rhqHUMdfxm9/dJbl5euISK3RWWHJps9uK1+4QddNGtR+CBdJvCgYCsj96w9lQ1JEfgQ8ITJJ2jGgFjSEUxzi35a5sdjjnZciFpbvb1uB8VtAmzJmeMdBbzS+BCVYK5/Pv3iwfBt/Q2zsXnXmDwk5SrH6NqpA2C4AyudUtUJXXHsiOhU8OiBIXgk8lhAPLx3YqBf5JOjPpVndkR2Pcm2/XztQQxAfD39G4NMPeJVxv0wkrsqin/9sKA27kcVYEDIzLEuca5q0sXV05G6/HZVQWvVWPqKCgjUWmMJ1FwY7KI6qMHX5Wwl8gIDq3nPsKw==
Received: from DB6PR0202CA0042.eurprd02.prod.outlook.com (2603:10a6:4:a5::28)
 by DB9PR10MB5552.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Thu, 21 Apr
 2022 13:38:50 +0000
Received: from DB5EUR01FT106.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:a5:cafe::77) by DB6PR0202CA0042.outlook.office365.com
 (2603:10a6:4:a5::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Thu, 21 Apr 2022 13:38:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 DB5EUR01FT106.mail.protection.outlook.com (10.152.4.178) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Thu, 21 Apr 2022 13:38:49 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 15:38:49 +0200
Received: from [167.87.32.12] (167.87.32.12) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 21 Apr
 2022 15:38:48 +0200
Message-ID: <70653967-0126-d85a-3a8e-a3c3525146e7@siemens.com>
Date: Thu, 21 Apr 2022 15:38:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [isar-cip-core][PATCH 3/3] Convert /etc overlay from systemd
 mount unit to initramfs hook
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
CC: Christian Storm <christian.storm@siemens.com>
References: <cover.1650541963.git.jan.kiszka@siemens.com>
 <6700d82b66bcf4939e729a01b612353b458919b0.1650541963.git.jan.kiszka@siemens.com>
 <28c26f61-2ae8-df3a-004f-21ea842439a7@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <28c26f61-2ae8-df3a-004f-21ea842439a7@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.87.32.12]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--14.704700-8.000000
X-TMASE-MatchedRID: MWBePzxHDOw5QaOxwNGfvo9bHfxDWoibnZzvVk+DChslPLVu9PurrfIK
	8gK4rjpyyB3Vn0eT/ZLTqAoW2PGHdEBm79YwY9dNQG62Sn3aGkwpw3g/d9ksDb+a7Hw+x9qZy73
	3NwuklsK2ZO4LLn5VSvEqCMNk4PLqaBishwIABxD08pD3L2/Xj3iXGrukUFRRTvKpZzlxUs9C3i
	RApcRQCkXtykZ+aGOtgtpdYIvYnir55VbxwR5f88jvnZ1JUTphTsc3oPKh4goZSewgzb/T8w/o5
	bNHEsCTWAuSz3ewb207fUAhHHRznTCM053QqFPDg6dF34V0O2gnF14bW3vLZo61Z+HJnvsOLozI
	+rhNYbm2zFWqrVN4BZIu8BCNfKQKQY9ube1qTn5ftuJwrFEhTbew1twePJJB3QfwsVk0UbtuRXh
	7bFKB7uJ3o+UdLxfpE9L6gxn7Y+Ki5qLMlbD6JI9FNcwXIcSdHIV02d1rpG8=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.704700-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 3048C52C786C2E601380EF1C6945523E1CCE4F6DFF1B2FBE8404A9BEF7340C8E2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d498ee8-dab0-4377-a611-08da239c448b
X-MS-TrafficTypeDiagnostic: DB9PR10MB5552:EE_
X-Microsoft-Antispam-PRVS: 
	<DB9PR10MB5552C8B3347D9F55EB4E39F295F49@DB9PR10MB5552.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	oHioGL8cDF/l5hquW9zJ83W7bIOcxdl/o/lsuP7pdCpdrmb7N8U+ypaLtCQiGcBdgmPvp4P+nph56Faw+eHi5NGxz1AI4veBVA3Ni/Vc4OsvjhvWiCEnNiOYeGyFz8fHqWui7WKX65sxJ2sNp9R+SP61PD6CH1cOhmTruTDVERp6rfC8BvjC7mLQzj2ZC2ugus3l/0bu5OdFraqwU5i93NmsD3QhqL2O4h/nLEygM+c5U5NJmz2bHTbtZcBOxON1CiACUt5FaAXSA2LpNCncqs7QPo/rXbF6Vf++FbO28uYOUY+C+XosyY5+9CLwzLdpFEDpcRroaok4YrF38uCkKKcytwX9GzhBe4b1BVZPBJCIXK+VWpn59YZDeYU9JprK6FiSPIL6KqCIRA9XgM6+m+SzpnY+XfaT6IK91lKUwxnLUh9VVbVRHeeIknmqn7NiAWaYuUsWA6yLA1U9p0fQSk8QD3YfL/b9xIN2A2oRIU4bLFHwXJ974yR4yeR1CcnbJeKwMSbNe/WBX4kBat319hZlVoaonzFlWKUgHHPgGYXvH0SFZT4cDNgrc1w9tf2LyD2v1AEmGQQsCPS4eFyRyvFeiWrZO6JM1rjKzXn51+13BTIgSCpwZ+VeJ/JPohW282hKGc9T61voXIfrYq6R4CwyMHrCKv+UgrIkcT+2+fVFuZbyKSbB86AU5jKWAMhI104gk0Egm3VrTYaP4khVrLSX3cLeqPEFoOOVhFigcTixGvZMFdo2BfXHmUeZTqyc6dmIuiiXYpoSGex3kj/Hwd6ubH/nWlOkdt5by0NOclbfq0kBygRvL4MKHRyYrZUG
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(508600001)(8676002)(16576012)(36860700001)(53546011)(31696002)(6706004)(86362001)(8936002)(4326008)(82960400001)(40460700003)(356005)(16526019)(70586007)(44832011)(70206006)(31686004)(110136005)(26005)(36756003)(956004)(47076005)(186003)(2616005)(2906002)(82310400005)(316002)(336012)(81166007)(83380400001)(5660300002)(107886003)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 13:38:49.7594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6d498ee8-dab0-4377-a611-08da239c448b
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT106.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5552
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Apr 2022 16:46:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8170

On 21.04.22 15:18, Gylstorff Quirin wrote:
>=20
>=20
> On 4/21/22 13:52, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> As systemd is not well prepared for read-only rootfs, specifically /wrt
>> machine-id management and anything that depends on it, it's best to
>> mount the /etc overlay already in the initramfs. This implies that also
>> /var is mounted at that level. We still keep the fstab setup done by
>> wic-swu-img class so that systemd will recognize the rootfs as read-only
>> and not try to remount it rw which will only fail with underlying
>> squashfs.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>> =C2=A0 classes/wic-swu-img.bbclass=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 2 --
>> =C2=A0 .../etc-overlay-fs/etc-overlay-fs_0.1.bb=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 32 -------------------
>> =C2=A0 .../etc-overlay-fs/files/etc-hostname.service | 14 --------
>> =C2=A0 .../files/etc-sshd-regen-keys.conf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 ----
>> =C2=A0 .../etc-overlay-fs/files/etc-sysusers.conf=C2=A0=C2=A0=C2=A0 |=C2=
=A0 4 ---
>> =C2=A0 recipes-core/etc-overlay-fs/files/etc.mount=C2=A0=C2=A0 | 13 ----=
----
>> =C2=A0 recipes-core/etc-overlay-fs/files/postinst=C2=A0=C2=A0=C2=A0 |=C2=
=A0 4 ---
>> =C2=A0 .../cip-core-initramfs/cip-core-initramfs.bb=C2=A0 |=C2=A0 4 +++
>> =C2=A0 .../files/etc-overlay.script=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 24 +++=
+++++++++++
>> =C2=A0 .../initramfs-etc-overlay-hook_0.1.bb=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 27 ++++++++++++++++
>> =C2=A0 10 files changed, 55 insertions(+), 75 deletions(-)
>> =C2=A0 delete mode 100644 recipes-core/etc-overlay-fs/etc-overlay-fs_0.1=
.bb
>> =C2=A0 delete mode 100644
>> recipes-core/etc-overlay-fs/files/etc-hostname.service
>> =C2=A0 delete mode 100644
>> recipes-core/etc-overlay-fs/files/etc-sshd-regen-keys.conf
>> =C2=A0 delete mode 100644 recipes-core/etc-overlay-fs/files/etc-sysusers=
.conf
>> =C2=A0 delete mode 100644 recipes-core/etc-overlay-fs/files/etc.mount
>> =C2=A0 delete mode 100755 recipes-core/etc-overlay-fs/files/postinst
>> =C2=A0 create mode 100644
>> recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.script
>> =C2=A0 create mode 100644
>> recipes-initramfs/initramfs-etc-overlay-hook/initramfs-etc-overlay-hook_=
0.1.bb
>>
>>
>> diff --git a/classes/wic-swu-img.bbclass b/classes/wic-swu-img.bbclass
>> index b93a96a..41b2164 100644
>> --- a/classes/wic-swu-img.bbclass
>> +++ b/classes/wic-swu-img.bbclass
>> @@ -15,8 +15,6 @@ inherit squashfs-img
>> =C2=A0 inherit wic-img
>> =C2=A0 inherit swupdate-img
>> =C2=A0 -IMAGE_INSTALL +=3D "etc-overlay-fs"
>> -
>> =C2=A0 INITRAMFS_RECIPE ?=3D "cip-core-initramfs"
>> =C2=A0 INITRD_IMAGE =3D "${INITRAMFS_RECIPE}-${DISTRO}-${MACHINE}.initrd=
.img"
>> =C2=A0 diff --git a/recipes-core/etc-overlay-fs/etc-overlay-fs_0.1.bb
>> b/recipes-core/etc-overlay-fs/etc-overlay-fs_0.1.bb
>> deleted file mode 100644
>> index 4e2b80b..0000000
>> --- a/recipes-core/etc-overlay-fs/etc-overlay-fs_0.1.bb
>> +++ /dev/null
>> @@ -1,32 +0,0 @@
>> -#
>> -# CIP Core, generic profile
>> -#
>> -# Copyright (c) Siemens AG, 2021
>> -#
>> -# Authors:
>> -#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> -#
>> -# SPDX-License-Identifier: MIT
>> -
>> -inherit dpkg-raw
>> -
>> -SRC_URI =3D "file://postinst \
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file://etc=
.mount \
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file://etc=
-hostname.service \
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file://etc=
-sshd-regen-keys.conf \
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file://etc=
-sysusers.conf"
>> -
>> -do_install[cleandirs]+=3D"${D}/usr/lib/systemd/system \
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> ${D}/usr/lib/systemd/system/local-fs.target.wants \
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> ${D}/usr/lib/systemd/system/systemd-sysusers.service.d \
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> ${D}/usr/lib/systemd/system/sshd-regen-keys.service.d \
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ${D}/=
var/local/etc \
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ${D}/=
var/local/.atomic \
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "
>> -do_install() {
>> -=C2=A0=C2=A0=C2=A0 TARGET=3D${D}/usr/lib/systemd/system
>> -=C2=A0=C2=A0=C2=A0 install -m 0644 ${WORKDIR}/etc.mount ${TARGET}/etc.m=
ount
>> -=C2=A0=C2=A0=C2=A0 install -m 0644 ${WORKDIR}/etc-hostname.service
>> ${TARGET}/etc-hostname.service
>> -=C2=A0=C2=A0=C2=A0 install -m 0644 ${WORKDIR}/etc-sshd-regen-keys.conf
>> ${D}/usr/lib/systemd/system/sshd-regen-keys.service.d/etc-sshd-regen-key=
s.conf
>>
>> -=C2=A0=C2=A0=C2=A0 install -m 0644 ${WORKDIR}/etc-sysusers.conf
>> ${D}/usr/lib/systemd/system/systemd-sysusers.service.d/etc-sysusers.serv=
ice
>>
>> -}
>> diff --git a/recipes-core/etc-overlay-fs/files/etc-hostname.service
>> b/recipes-core/etc-overlay-fs/files/etc-hostname.service
>> deleted file mode 100644
>> index 2306b9f..0000000
>> --- a/recipes-core/etc-overlay-fs/files/etc-hostname.service
>> +++ /dev/null
>> @@ -1,14 +0,0 @@
>> -[Unit]
>> -Description=3Dset hostname /etc overlay-aware
>> -Before=3Dnetwork-pre.target
>> -Wants=3Dnetwork-pre.target
>> -Requires=3Detc.mount
>> -After=3Detc.mount
>> -
>> -[Service]
>> -Type=3Doneshot
>> -RemainAfterExit=3Dyes
>> -ExecStart=3D/bin/hostname --boot --file /etc/hostname
>> -
>> -[Install]
>> -WantedBy=3Dbasic.target
>> diff --git
>> a/recipes-core/etc-overlay-fs/files/etc-sshd-regen-keys.conf
>> b/recipes-core/etc-overlay-fs/files/etc-sshd-regen-keys.conf
>> deleted file mode 100644
>> index b386c12..0000000
>> --- a/recipes-core/etc-overlay-fs/files/etc-sshd-regen-keys.conf
>> +++ /dev/null
>> @@ -1,6 +0,0 @@
>> -[Unit]
>> -# set hostname /etc overlay-aware
>> -Before=3Dnetwork-pre.target
>> -Wants=3Dnetwork-pre.target
>> -Requires=3Detc.mount
>> -After=3Detc.mount
>> diff --git a/recipes-core/etc-overlay-fs/files/etc-sysusers.conf
>> b/recipes-core/etc-overlay-fs/files/etc-sysusers.conf
>> deleted file mode 100644
>> index ad45d7f..0000000
>> --- a/recipes-core/etc-overlay-fs/files/etc-sysusers.conf
>> +++ /dev/null
>> @@ -1,4 +0,0 @@
>> -[Unit]
>> -# make systemd-sysusers /etc overlay aware
>> -Requires=3Detc.mount
>> -After=3Detc.mount
>> diff --git a/recipes-core/etc-overlay-fs/files/etc.mount
>> b/recipes-core/etc-overlay-fs/files/etc.mount
>> deleted file mode 100644
>> index f0ae3c5..0000000
>> --- a/recipes-core/etc-overlay-fs/files/etc.mount
>> +++ /dev/null
>> @@ -1,13 +0,0 @@
>> -[Unit]
>> -Description=3DOverlay-mount /etc
>> -Requires=3Dvar.mount
>> -After=3Dvar.mount
>> -
>> -[Mount]
>> -What=3Doverlay
>> -Where=3D/etc
>> -Type=3Doverlay
>> -Options=3Dnoauto,x-systemd.automount,lowerdir=3D/etc,upperdir=3D/var/lo=
cal/etc,workdir=3D/var/local/.atomic
>>
>> -
>> -[Install]
>> -WantedBy=3Dlocal-fs.target
>> diff --git a/recipes-core/etc-overlay-fs/files/postinst
>> b/recipes-core/etc-overlay-fs/files/postinst
>> deleted file mode 100755
>> index e436b53..0000000
>> --- a/recipes-core/etc-overlay-fs/files/postinst
>> +++ /dev/null
>> @@ -1,4 +0,0 @@
>> -#!/bin/sh
>> -
>> -deb-systemd-helper enable etc.mount=C2=A0 || true
>> -deb-systemd-helper enable etc-hostname.service || true
>> diff --git
>> a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
>> b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
>> index 649daa2..9e0ee26 100644
>> --- a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
>> +++ b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
>> @@ -10,3 +10,7 @@
>> =C2=A0 #
>> =C2=A0 =C2=A0 inherit initramfs
>> +
>> +INITRAMFS_INSTALL +=3D " \
>> +=C2=A0=C2=A0=C2=A0 initramfs-etc-overlay-hook \
>> +=C2=A0=C2=A0=C2=A0 "
>> diff --git
>> a/recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.script =
b/recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.script
>>
>> new file mode 100644
>> index 0000000..08271cd
>> --- /dev/null
>> +++
>> b/recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.script
>> @@ -0,0 +1,24 @@
>> +#!/bin/sh
>> +
>> +PREREQ=3D""
>> +
>> +prereqs()
>> +{
>> +=C2=A0=C2=A0=C2=A0 echo "$PREREQ"
>> +}
>> +
>> +case $1 in
>> +# get pre-requisites
>> +prereqs)
>> +=C2=A0=C2=A0=C2=A0 prereqs
>> +=C2=A0=C2=A0=C2=A0 exit 0
>> +=C2=A0=C2=A0=C2=A0 ;;
>> +esac
>> +
>> +. /scripts/functions
>> + > +mount -t $(get_fstype /dev/disk/by-label/var) /dev/disk/by-label/va=
r=20
> ${rootmnt}/var
>=20
> should there be a check for existence for /dev/disk/by-label/var?
>=20

mount will fail - and we likely want to panic in that case, true. Will
write a v2 for that.

Thanks,
Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux

