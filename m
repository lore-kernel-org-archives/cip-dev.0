Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502D0C433FE
	for <webhook@archiver.kernel.org>; Wed, 19 Oct 2022 10:46:12 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.65])
 by mx.groups.io with SMTP id smtpd.web10.6497.1666176367178649000
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Oct 2022 03:46:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Q9pbdNq5;
 spf=pass (domain: siemens.com, ip: 40.107.20.65, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLhSHKLQ/mEhr7QRiv74H3XRmuBTtOikkEjGEKasLV3kPp2hSgOuF/Q6XmhKvJ5ondgw30shfrF9e5FwwXzgIg6pt4xpbRM6/pst1Sje3HpMQja0Ggrb54vsJtCP/e0wM8E+BMsObel/lloUl/TtB/kAXqDzff2uHNIkbcnfBxRVEF/svqNtJo28VmuRAc4Hu2EX5SszRqJIwtE38k+0dmiy9C6zr4sELHbwqUu4ev+tgj7ODARgosH9EgtZ2NACjlXK33RukvSqMHzUBcTdQG2d7Oh01HFmkhvHY9xw8t23DFOjPFUVx50uBA4tCw32QjIv6VuJM3UeRt0aWBsH0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKMc2byz2f9eigGtvuWfYVPORBifvw++tDh2k505RGI=;
 b=mvTkkZLwUEn1KGeGkd+TvawYFgZCuhaIyMIfq0e24W4O59pbvhreiuFDhuCh1gDXEicCHCdq8HesIXC2a1A4QJg1bxUDfxKg76vYFyWfrpbXFD3oeiw6Z8d1KW5pwkjA8cIE2C5FBmLMYfyl9BFEVvYtoPSMuW3/Rythe42moKawn7OAqjX/v6ECkMuQAPmMJYwknYw1qnh7534QNQ7Ow2Sn9GWGx89Wi2R3Qs6qb4KX2cyAaTGIA7cznq0SrAfXQz2C0KT6uewDfCDO4ov8G6tLNFCrdmpjTzxn0F8OsIXFHzyjYKDEOq3h/3gFszJgt/bwHTFGPcEY8NWVzAELsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKMc2byz2f9eigGtvuWfYVPORBifvw++tDh2k505RGI=;
 b=Q9pbdNq5irzIUW885AgeUzALlzEkCDFVUu4hcyxYxsFvb5wGytGFO6aAikt3S2HY2yx/1mJJ0EAJp8ujT/DEDFG6NyF9HJbz6p6B2MFa1AQ/wNHHVDhq1rdaZHzkfkt3QmRxbYhq7qpmVwoioE4/MAD9DYo2M9+JO2qM3YH7Ectvn5A//fJNSVs2nOQP6xKQLiC/zgyVtjaIqL2Vba+XKRoFMPbLzhEXQHwIcr8inkqLn4NMobOfxhdGadyFqFCiUe/bicOm7elDlWECmT/3RnQa9wa0I4cAzVuAY+QVLu0161lnG7QnVFR8+0p4xwodg3+XbD2OQH7/udPbL8ZNFA==
Received: from GV3P280CA0111.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:8::28) by
 DB9PR10MB5526.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:309::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.26; Wed, 19 Oct 2022 10:46:04 +0000
Received: from HE1EUR01FT075.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:8:cafe::b9) by GV3P280CA0111.outlook.office365.com
 (2603:10a6:150:8::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32 via Frontend
 Transport; Wed, 19 Oct 2022 10:46:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.76) by
 HE1EUR01FT075.mail.protection.outlook.com (10.152.1.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.16 via Frontend Transport; Wed, 19 Oct 2022 10:46:04 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.15; Wed, 19 Oct 2022 12:46:02 +0200
Received: from [139.22.133.243] (139.22.133.243) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Wed, 19 Oct 2022 12:46:02 +0200
Message-ID: <42bbe569-bade-11ca-42a6-91769548ebe8@siemens.com>
Date: Wed, 19 Oct 2022 12:46:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [isar-cip-core][PATCH 1/7] add recipe for optee qemu arm64
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: <sven.schultschik@siemens.com>, <cip-dev@lists.cip-project.org>
References: <20221019092117.5291-1-sven.schultschik@siemens.com>
 <c020dd31-5cc6-4be8-bee1-f313e816a817@siemens.com>
In-Reply-To: <c020dd31-5cc6-4be8-bee1-f313e816a817@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.133.243]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--16.661300-8.000000
X-TMASE-MatchedRID: sszaBKuRWIs5QaOxwNGfvo9bHfxDWoibATaHBwVHy/1qZ6OipRp3ejlb
	BhAKzgGf31GU/N5W5BB2DX7fiwsbtuV6Ukjo9KrLWP7S1AyiPEAsaaYlMvaOHA97mDMXdNW3AZn
	/4A9db2Tvrj2fROADiX+YLBuR+SHBzd9D/IRLjmkQea4Si8omsgK1I3/RsWjTaDCzqDR7DPabOw
	nwKxlhTqFIbih0s/42TxSugU04anvJvHAVwrvMvCUskOAallgBOiyyh0NN44NwGgR8fjmhmExBQ
	tM1e2ykBO9W+Ur4NIBu5QV/9+0eKXrB/EX0Zo5Q9cmyfKQ9I/yg3GTuSc7pg1kxnoxnQfVSIgt1
	z4icQStsHXaY2NrO1xZaDvoiUT/MJFAZJ30BJdQ2rW8Pb51lrkx+cqYYl+rsSHCU59h5KrGg886
	7bIwmU9JO+sYlhfSowsbDDvMRD0h0rOfKxm64UqlC035hebmRtsysVODxqe7fLwFfPJufPGvaom
	g0i4KN70ULJJwFphpp4FVA3+HPGEz/4ur4wujoeJs832DqeTyxv27DaG1ZXWFzg+No/uuNcV3n4
	J/0zUOk7Bk3i0ppq1Vxc/d4wt8X44Yh583I62YvHEcEx0NzujLvC8LxRzodngIgpj8eDcC063Wh
	9WVqgtQdB5NUNSsi1GcRAJRT6POOhzOa6g8KrUOpSRRmC32t5Ilo98jll9SB3u0yrC8f53Sy2FG
	PAwUakW8Io851Azs=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.661300-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 2F923FB162A75F5E1F4B472844E9EF4B6A3F696193D7A9C913567497C0802F4A2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT075:EE_|DB9PR10MB5526:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e804cbb-38c9-4b74-8340-08dab1bf1ee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	IIZ62Le6fnGH4hEhQexxJq/e0txKlzlwK8bIYk69yhdYfDBsCItxr/OQ+jnwCXnX7ybu096Qp/N2YaKVyHHB+k9YMyCXprRQtDARDz5JZBIyXWlCPjZYPuNi6uCojqNEh7z9i2TYR5JBON4//G3DjSAvqpPmtCswPdVbXf1+7tZPUjpRwrrujVvo7Bj2pNlSqpTCPA14C9ilwBYOYtQUL1zY0W24eT1yCcJ/y3s9n5dXJw73WyrkzqtNAA5scwpy9dfHWxoVZavf4h7rHUlJYghEYhP6gvpG2MGFhbo2oJlHpzphB5KbdI2JiXgk6a/NcvWhv+RkqY0CI44eVx7TukJnaTx4s3jh6fcCKk4HM/hhHrD2LIUlMz37ErbmY4iDi9yikiB15iHg6u/dAmyP79BwRas6HYEvJez1V6z4Vy889fBLpvbdn37lnipL+fJWYq7Huiq1mKKhdW1DvXcwl9hotoa6MQQ7ZfcqFoyWELM1ts5DcOw++TJnZ/iLK9w4PoHuObOpKBm0qwnVLtJcjbfzqQT88qErNg65E+1XYsfuW5CCoEtArbOTjYXK/K3lzEqBv/lMmkj51NdesfUQhaVVVEiBMj5G6LyfiO+pXfJQbyvGc1PhiL37qvyu13BbaghY8/zoLoHHAmMWlWWPtIvD4C4HC5IfR2L94Hc8h2Iq69Rb282YwlG67eokgji0uJ+r/DtBfmjrJPtjq5HsLgnI+XKh+0Td7EED777PA249TM135QRu87NqqNBqU+zKQ1Zl9n6ntFyInuoOl8zoCuv6rRZB18kOiPCk61z2zuJGrzcfWfTW7g6xJV3xF1XhT2gCCpn/+qpEP4sc3Y+f2mp95LKWnKio/CxR3DOw/7rqXZn3Ra/8NEcx8AdHIf+yA6rhkc12lEnjr6PyuCBUfGf86k90Upbq80fVef6zniw=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(16526019)(47076005)(34020700004)(186003)(2616005)(83380400001)(356005)(81166007)(26005)(31696002)(956004)(86362001)(36860700001)(82960400001)(336012)(44832011)(82740400003)(5660300002)(2906002)(8936002)(6706004)(40480700001)(82310400005)(8676002)(40460700003)(478600001)(110136005)(16576012)(53546011)(316002)(41300700001)(70206006)(70586007)(36756003)(31686004)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 10:46:04.0283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e804cbb-38c9-4b74-8340-08dab1bf1ee2
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT075.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5526
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Oct 2022 10:46:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9783

On 19.10.22 12:44, Jan Kiszka wrote:
> On 19.10.22 11:21, sven.schultschik@siemens.com wrote:
>> From: Sven Schultschik <sven.schultschik@siemens.com>
>>
>> The recipe provides the possibility to create optee-os binaries for use inside of an qemu secureboot setup with edk2, rpmb, u-boot and uefi
>>
>> Signed-off-by: Sven Schultschik <sven.schultschik@siemens.com>
>> ---
>>  .../op-tee/optee-os-qemu-arm64_3.17.0.bb      | 57 +++++++++++++++++++
>>  recipes-bsp/u-boot/files/secure-boot.cfg.tmpl |  7 +++
>>  recipes-bsp/u-boot/u-boot-common.inc          |  6 +-
>>  3 files changed, 67 insertions(+), 3 deletions(-)
>>  create mode 100644 recipes-bsp/op-tee/optee-os-qemu-arm64_3.17.0.bb
>>
>> diff --git a/recipes-bsp/op-tee/optee-os-qemu-arm64_3.17.0.bb b/recipes-bsp/op-tee/optee-os-qemu-arm64_3.17.0.bb
>> new file mode 100644
>> index 000000000..5e60041af
>> --- /dev/null
>> +++ b/recipes-bsp/op-tee/optee-os-qemu-arm64_3.17.0.bb
>> @@ -0,0 +1,57 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2022
>> +#
>> +# Authors:
>> +#  Sven Schultschik <sven.schultschik@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +HOMEPAGE = "https://github.com/OP-TEE/optee_os"
>> +MAINTAINER = "Sven Schultschik <sven.schultschik@siemens.com>"
>> +LICENSE = "BSD-2-Clause"
>> +
>> +require recipes-bsp/optee-os/optee-os-custom.inc
>> +
>> +SRC_URI += " \
>> +            gitsm://github.com/OP-TEE/optee_os.git;branch=master;protocol=https;destsuffix=git;rev=${PV}"
> 
> Do we really need the second-class supported gitsm fetcher here? Also,
> destsuffix and rev are both redundant (they are defaults).
> 
> Oh, indention by 4 spaces would be sufficient.
> 
>> +
>> +S = "${WORKDIR}/git"
>> +
>> +OPTEE_PLATFORM = "vexpress-qemu_armv8a"
>> +
>> +OPTEE_BINARIES = "tee-header_v2.bin \
>> +    tee-pager_v2.bin \
>> +    tee-pageable_v2.bin"
>> +
>> +DEPENDS = "edk2"
>> +DEBIAN_BUILD_DEPENDS += " ,\
>> +    debhelper(>= 11~), \
>> +    build-essential, \
> 
> Redundant.
> 
>> +    cpio, \
>> +    python3-cryptography, \
>> +    python3-pycryptodome, \
>> +    python3-serial, \
>> +    device-tree-compiler, \
>> +    edk2, \
> 
> Do we need Debian's edk2 here?

Nope, self-built one -> wrong patch ordering, 2/7 must come first.

Jan

> 
>> +    gcc-arm-linux-gnueabihf,"
>> +
>> +OPTEE_EXTRA_BUILDARGS = "CFG_STMM_PATH=/usr/lib/edk2/BL32_AP_MM.fd CFG_RPMB_FS=y \
>> +        CFG_RPMB_FS_DEV_ID=0 CFG_CORE_HEAP_SIZE=524288 CFG_RPMB_WRITE_KEY=1 \
>> +        CFG_CORE_DYN_SHM=y CFG_RPMB_TESTKEY=y \
>> +        CFG_REE_FS=n\
>> +        CFG_TEE_CORE_LOG_LEVEL=1 CFG_TEE_TA_LOG_LEVEL=1 CFG_SCTLR_ALIGNMENT_CHECK=n \
>> +        CFG_ARM64_core=y CFG_CORE_ARM64_PA_BITS=48"
>> +
>> +ISAR_CROSS_COMPILE = "0"
> 
> This looks wrong, specifically as you are installing a 32-bit
> cross-compiler and calling a 64-bit one as well below.
> 
>> +
>> +dpkg_runbuild_prepend() {
>> +    # $(ARCH) is the CPU architecture to be built. 
>> +    # Currently, the only supported value is arm for 32-bit or 64-bit Armv7-A or Armv8-A. 
>> +    # Please note that contrary to the Linux kernel, $(ARCH) should not be set to arm64 for 64-bit builds. 
>> +    export ARCH="arm"
>> +    export CROSS_COMPILE32=arm-linux-gnueabihf-
>> +    export CROSS_COMPILE64=aarch64-linux-gnu-
> 
> That is a deprecated style, and sbuild will complain. Move into the
> rules file.
> 
>> +}
>> \ No newline at end of file
> 
> Please have a "newline at the end of file".
> 
>> diff --git a/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl b/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl
>> index 956dcbfed..8e6428238 100644
>> --- a/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl
>> +++ b/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl
>> @@ -4,3 +4,10 @@ CONFIG_USE_BOOTCOMMAND=y
>>  CONFIG_BOOTCOMMAND="setenv scan_dev_for_boot 'if test -e ${devtype} ${devnum}:${distro_bootpart} efi/boot/boot${EFI_ARCH}.efi; then load ${devtype} ${devnum}:${distro_bootpart} ${kernel_addr_r} efi/boot/boot${EFI_ARCH}.efi; bootefi ${kernel_addr_r} ${fdtcontroladdr}; fi'; run distro_bootcmd; echo 'EFI Boot failed!'; sleep 1000; reset"
>>  CONFIG_EFI_VARIABLES_PRESEED=y
>>  CONFIG_EFI_SECURE_BOOT=y
>> +### OPTEE config
>> +CONFIG_CMD_OPTEE_RPMB=y
>> +CONFIG_MMC=y
>> +CONFIG_SUPPORT_EMMC_RPMB=y
>> +CONFIG_TEE=y
>> +CONFIG_OPTEE=y
>> +CONFIG_EFI_MM_COMM_TEE=y
>> diff --git a/recipes-bsp/u-boot/u-boot-common.inc b/recipes-bsp/u-boot/u-boot-common.inc
>> index 60f0da361..7fe4d3fad 100644
>> --- a/recipes-bsp/u-boot/u-boot-common.inc
>> +++ b/recipes-bsp/u-boot/u-boot-common.inc
>> @@ -25,12 +25,12 @@ DEBIAN_BUILD_DEPENDS += ", libssl-dev:native, libssl-dev:${DISTRO_ARCH}"
>>  
>>  DEBIAN_BUILD_DEPENDS_append_secureboot = ", \
>>      openssl, pesign, secure-boot-secrets, python3-openssl:native"
>> -DEPENDS_append_secureboot = " secure-boot-secrets"
>> +DEPENDS_append_secureboot = " secure-boot-secrets optee-os-${MACHINE}"
> 
> Nope, this must go into qemu-specific U-Boot bits. We don't have
> optee-os for the rest yet.
> 
>>  
>>  TEMPLATE_FILES_append_secureboot = " secure-boot.cfg.tmpl"
>>  TEMPLATE_VARS_append_secureboot = " EFI_ARCH"
>>  
>>  do_prepare_build_append_secureboot() {
>>      sed -ni '/### Secure boot config/q;p' ${S}/configs/${U_BOOT_CONFIG}
>> -    cat ${WORKDIR}/secure-boot.cfg >> ${S}/configs/${U_BOOT_CONFIG}
>> -}
>> +    cat ${WORKDIR}/secure-boot.cfg >> ${S}/configs/${U_BOOT_CONFIG}    
>> +}
>> \ No newline at end of file
> 
> Spurious change. Please cross-read your diffs for such things.
> 
> When you resend, I would suggest to split up the optee recipe
> introduction and the U-Boot changes.
> 
> Jan
> 

-- 
Siemens AG, Technology
Competence Center Embedded Linux


