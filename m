Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FFFC00144
	for <webhook@archiver.kernel.org>; Fri, 29 Jul 2022 09:00:02 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.50])
 by mx.groups.io with SMTP id smtpd.web12.5902.1659085195441851039
 for <cip-dev@lists.cip-project.org>;
 Fri, 29 Jul 2022 01:59:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vW+wiF4D;
 spf=pass (domain: siemens.com, ip: 40.107.20.50,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQXLSbvTnJ8B+9BNMqNm+OJVauTU78onPSJwXyhEuWApyr1mKbPo7b4UkviMy2pljCOzJOq1Y40jes1jf9Bhdv4CARjWF8N+jSnpqZp54xMGpWFEHFUoJnhOpsRS7bFQqCJdFFDMMUskTvd78npjg+f71AkC+JxLotIrG5RUFrwtVuc5AqYORB3aAvDUxv6d7fiAciFnc0KQJ2bCq11Xe8+IaF5IliD1RYlX2H/VBclTqQWtCP/5mB6074vx45HOBblxMn7hT+cFu2psCHchBzDXSmM5yTUtZHwXMvi5jgFPHl5uIb4SCb/smtSb/nZvc5kCVNufBdKP2j5sq0XW5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tq3UITzP09kQJiaCYGjfhcFiAitsiZpImwLypJUb20=;
 b=JgiOrhsPOAeLL/Hc4QatHo5wpi4Ev8pdDWoMgv+SwqPYwiiSWOUVO76KJLlRQsK8vuqsELOdcmdUjDQ3zJwQikmeWS8hxJ+tbBxTedqiTC1yU/+iH6A/K6yNL9i0N5zrbMGcflTf5WdE2IQw4Ui8oYASrcyc9OEkvGUgzZI+Y6GYZ38CR8kv2XibTeKZqcT7PrDdWTI84TGPoPoKaWNANaFIf9pJUQpKU4VQwFWVcYMLbwsD2cLyDx62QcgvcKHsXP7Sg01regIU2rWN9rDyPZdvycxLd3213P7FwMA7+i2yZcpPEPvkvuUZZV5frCWndhYfDrD6ha+EuD+lS1X8VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tq3UITzP09kQJiaCYGjfhcFiAitsiZpImwLypJUb20=;
 b=vW+wiF4DyLHZ2n0u7UJwjR+L06gfXmAh5RolhWTY56NkFXHZl4ENpnp6O8zf+IzU/gbAqk88ob/WU+bDhLZN5NV0FSxJDLIQH/Q1EO4hw1R1SgVCPPW7Slpqg5rA5kkQJiSXmaTxtvEZcizw+m2wie8ZoQpANn1ix2OneFXVIOBh4ZnTcnX1tXmd6kjLg0F9fmohMJr7Pu/x0yQ0SMjOjtb+eDjYIrTR6xctcBJeaaph2VJ86uYeIJtXK4ASjg2J7kWD0TB+7Ro+PXtIdNsi4GCGET+YWdLBkbxpq0e/Z0JoG86bWAKYrBGLJFbiITdZmI9pQWzkBu5zVSP5RmMZWQ==
Received: from AS8PR04CA0079.eurprd04.prod.outlook.com (2603:10a6:20b:313::24)
 by PR3PR10MB3948.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Fri, 29 Jul
 2022 08:59:53 +0000
Received: from VE1EUR01FT091.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:313:cafe::8b) by AS8PR04CA0079.outlook.office365.com
 (2603:10a6:20b:313::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12 via Frontend
 Transport; Fri, 29 Jul 2022 08:59:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.71) by
 VE1EUR01FT091.mail.protection.outlook.com (10.152.3.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.10 via Frontend Transport; Fri, 29 Jul 2022 08:59:52 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Fri, 29 Jul 2022 10:59:52 +0200
Received: from [167.87.165.107] (167.87.165.107) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Fri, 29 Jul 2022 10:59:51 +0200
Message-ID: <446e0599-aba4-cc61-18cd-4518bd5f3dd4@siemens.com>
Date: Fri, 29 Jul 2022 10:59:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [cip-dev][isar-cip-core][PATCH 3/4]
 recipes-devtools/ovmf-binaries: Adapt to sbuild environment
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <20220729083931.419731-1-Quirin.Gylstorff@siemens.com>
 <20220729083931.419731-4-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220729083931.419731-4-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.165.107]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--21.004900-8.000000
X-TMASE-MatchedRID: ObgwaKFsELDdDS6etHbe28U8jBVxKY1xPg9yfk4YC0aJkf5qQgIh3VAG
	vCQ4hMt831GU/N5W5BAu1yMLFpHhOjWAgc88bFJ7+7rgA0QyMKyqPTUWVYFp2mvOwg12ikVSbXm
	IkXx4TqsWYUZl9+1ZUfmv83Rzid1pzg6SFO4iYqNrCXi+CAenHOV3ZC6n0t5VcxMkBeI9K3eLwn
	zPZ/AZp05VvgDuaDCkJMJXDJjkqdTgr0WZ6u+ypd8dsStXeviR6ng+QM4KwJRNP1m95I8DFUKJ5
	iyNYGPpzCw8IK7CtTvEfwwD0ihEz6TL4NaaSz0E9E0Oh6Qvt2g5rof3b4z0VBlJ7CDNv9PzyeUl
	7aCTy8gtferJ/d7Ab6JcNRKYzfnkK+fbv4M7+TC1M6vEQZCbhnDWCEZXvYIHngIgpj8eDcC063W
	h9WVqgtQdB5NUNSsi1GcRAJRT6POOhzOa6g8KrZRMZUCEHkRt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--21.004900-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 C47D0A85DE9F1B79849FEA62F8ADE3E076B30108CA5F2515D1FD9E7127E48F742000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab822b82-a3dc-462e-14ef-08da7140b36e
X-MS-TrafficTypeDiagnostic: PR3PR10MB3948:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Q+FOtEVHMu5/dSrEMk+BaxpPVVvgKqzQyjuHlk49eE91Z8AQqDRpy5FZ1z+aLR/TjPODy1hvambw9Z44mvUmaVziu63I4YFhE7AA/VSN9BGu4WB3P2r3Galz9ncGeE1IdK1oDRTM+oWaERimoV8+aLoWwOC6zsbpcGQ5FBNT0ZWKpu4dlBUbQqjbb5fQyr3Bcef8ZPrMPBP4IamlbTK1dM7+s6DQVcaSuEB8pCYIl+8yQE/E/OEJn1OxP3qfsnj+6IwSTT3dqgL9Wcrx+wv8YHwjVswK51EWZnCSdB/xB1g8QThyfQVrRzjoqT6Mjnh8lYxLpmpy8nA3OgVHKJECzQXS8XvJy8xh8pHh+KmqDVbIVqbVMOAywwm33R8jBS4fDKsLTQofHHhZdihjFY0pN+nXK1sXCw4MSaqGEcxsX2HquhA6SR9Kg8Manv0duuO6iIrg6uSbpFkYyzQk8f7zIGSobI+qy+FPaQGkODjg1Ie16c7W9Z3NxsehvB5dxXDEoAPMyUy8Ya2ezqlgHmHE6pUHG7gxEUCtoDOyVITUT07PPpIAOoSR7gLBInGa+HoiaH5xbEuTCeXaPj7i70oFaVJ3DTxTtTmq1ITvArvIT969iw3O6rFtrTEtCpXh928+xnBp/yesROkxJR/nAAqDzpyZwa7j8HBENlEzeH2fRw8GwxuPrxLK7fzedKCk2QYhBGPlucJioGhC86Kg+z7NsMZEquCoP04JJvqNtdMU35BCE+ApDQ63KWv2wu3atqUwe76lOtdP9sMkhw9aztyJ66p1KE0LDRwVFOXyc2piCdH/WJsblmZfjHmyrrNBKnCqWDyLbEa0b/nFZQFxVwA0AJ4/txSZLiu31R4DeYVVMpME2RVxNKDYl5HB8pv0PLOIR+pfy16A/EbqcvHN7Zhq7A==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(396003)(46966006)(40470700004)(36840700001)(356005)(82960400001)(82740400003)(6706004)(16526019)(44832011)(40460700003)(81166007)(26005)(186003)(8936002)(110136005)(5660300002)(83380400001)(70206006)(70586007)(8676002)(36860700001)(16576012)(47076005)(956004)(2616005)(316002)(336012)(40480700001)(86362001)(82310400005)(31696002)(41300700001)(36756003)(31686004)(478600001)(53546011)(2906002)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 08:59:52.8059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 ab822b82-a3dc-462e-14ef-08da7140b36e
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT091.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3948
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 29 Jul 2022 09:00:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8977

On 29.07.22 10:39, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Due to sbuild we can no longer access the build chroot with all installed
> packages.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../ovmf-binaries/files/control.tmpl           | 11 -----------
>  recipes-devtools/ovmf-binaries/files/rules     | 17 +++++++++++++++++
>  .../ovmf-binaries/ovmf-binaries_0.1.bb         | 18 +++++++++++-------
>  3 files changed, 28 insertions(+), 18 deletions(-)
>  delete mode 100644 recipes-devtools/ovmf-binaries/files/control.tmpl
>  create mode 100644 recipes-devtools/ovmf-binaries/files/rules
> 
> diff --git a/recipes-devtools/ovmf-binaries/files/control.tmpl b/recipes-devtools/ovmf-binaries/files/control.tmpl
> deleted file mode 100644
> index 54641d6..0000000
> --- a/recipes-devtools/ovmf-binaries/files/control.tmpl
> +++ /dev/null
> @@ -1,11 +0,0 @@
> -Source: ${PN}
> -Section: misc
> -Priority: optional
> -Standards-Version: 3.9.6
> -Maintainer: ${MAINTAINER}
> -Build-Depends: debhelper (>= 9), ${DEBIAN_BUILD_DEPENDS}
> -
> -Package: ${PN}
> -Architecture: ${DPKG_ARCH}
> -Depends: ${DEBIAN_DEPENDS}
> -Description: ${DESCRIPTION}
> diff --git a/recipes-devtools/ovmf-binaries/files/rules b/recipes-devtools/ovmf-binaries/files/rules
> new file mode 100644
> index 0000000..dcbef80
> --- /dev/null
> +++ b/recipes-devtools/ovmf-binaries/files/rules
> @@ -0,0 +1,17 @@
> +#!/usr/bin/make -f
> +#
> +# Copyright (c) Siemens AG, 2022
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# This file is subject to the terms and conditions of the MIT License.
> +# See COPYING.MIT file in the top-level directory.
> +#
> +
> +override_dh_auto_configure:
> +	mkdir -p /home/builder/ovmf-binaries/image/var/share/
> +	cp -r /usr/share/OVMF /home/builder/ovmf-binaries/image/var/share/
> +
> +%:
> +	dh $@
> diff --git a/recipes-devtools/ovmf-binaries/ovmf-binaries_0.1.bb b/recipes-devtools/ovmf-binaries/ovmf-binaries_0.1.bb
> index 6524300..0f4592a 100644
> --- a/recipes-devtools/ovmf-binaries/ovmf-binaries_0.1.bb
> +++ b/recipes-devtools/ovmf-binaries/ovmf-binaries_0.1.bb
> @@ -14,18 +14,22 @@ inherit dpkg-raw
>  DESCRIPTION = "Copy the OVMF biniaries from the build changeroot to the deploy dir"
>  
>  # this is a empty debian package
> -SRC_URI = "file://control.tmpl"
> +SRC_URI = "file://rules"
>  
>  DEBIAN_BUILD_DEPENDS = "ovmf"
> -TEMPLATE_FILES = "control.tmpl"
> -TEMPLATE_VARS += "PN DEBIAN_DEPENDS MAINTAINER DESCRIPTION DPKG_ARCH DEBIAN_BUILD_DEPENDS"
>  
>  SSTATETASKS = ""
>  
> -do_extract_ovmf() {
> +do_install() {
> +     install -v -d ${D}/var/share
> +     touch ${D}/var/share/test
> +}
> +
> +do_deploy() {
>      install -m 0755 -d ${DEPLOY_DIR_IMAGE}
> -    cp -r ${BUILDCHROOT_DIR}/usr/share/OVMF ${DEPLOY_DIR_IMAGE}
> -    chown $(id -u):$(id -g) ${DEPLOY_DIR_IMAGE}/OVMF
> +    dpkg --extract ${WORKDIR}/${PN}_${PV}*.deb ${WORKDIR}
> +    cp -r ${WORKDIR}/var/share/OVMF ${DEPLOY_DIR_IMAGE}
>  }
> +addtask do_deploy after do_dpkg_build before do_deploy_deb
> +
>  
> -addtask do_extract_ovmf after do_install_builddeps before do_dpkg_build

Same question here: Move to the front? Or is there anything
sbuild-specific in this recipe?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

