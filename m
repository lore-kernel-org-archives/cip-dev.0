Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD36AC43217
	for <webhook@archiver.kernel.org>; Fri, 22 Apr 2022 19:12:53 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.88])
 by mx.groups.io with SMTP id smtpd.web12.111.1650646793781828924
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 Apr 2022 09:59:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=bvlPf6XR;
 spf=pass (domain: siemens.com, ip: 40.107.7.88,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vi9Y9LRPH5frGytML54GRbzAs7U2zKgyzzKQ0mSQk7SuS2aI+X9XvyPeuyDPc2pohtPw1Qwbzy91iZjaJSi0Rj2q83dTjoDrW99uarzmn+WgkCLBYIxlH4+ht8R668tBmfMjmV2wdfJ7d6kqdsVX4xwI68Kays3xkhOOqeHsryM3j4C3L8/ZcGRtseXG5OSB2s+MAnIbpkSIyuuHQ7NL48s52AfK/vY5uah1PdP53czA8mhfg2XOoaIilwYS92x3yohmFKjHcrAg07S1Kt5fbY/jDph5rfQd2SfN96EKAibbZR8rLptdGBJ6mLHYwzaYxmra9LiUxDxYly4uAjj/3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mx5N2nMaDkAFmTiQ4S4NXBromkpEsXwfshzi3y41pWA=;
 b=ljzEkpP38GtJX8BQldsalvlcWCdseIG4MFVUQa9Yuvw02221mdAxo2UHqf7HXIYOVqmzrhqU6TIOIsqrfL8dNsbyb35o8Bd2QZDlGgve4iRYVwHZzSXsSCq6heRQV0omkLjhlTNR8wN/gMRZOPkT55VRrT7HtO84yU67z/AzXVU63v0OxVlnqND5sN5ImL+2764ooTU0uG46yL4ZvZSmkMj8C36E4I9bo6/GukA++9v9k4g/7yz6lCu6TLkpS0oMNk2pTcucUOWbGsO21M95VMLjP2fmhm4Nu7cF9PDIvDjnXWfEdYQgkZPxp8/4RogPeYXbvpOXucVZnGnrmIKiSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mx5N2nMaDkAFmTiQ4S4NXBromkpEsXwfshzi3y41pWA=;
 b=bvlPf6XR3bY/Jvg55F1PZjMLutAHXvvPOxv/576o+PR8U0TY4K2Q8KF310CZLqn2b5R3L3nkZx/6Zmc8ba16rFbJNrfSW+ACzyoKPX/ReLSU2B18Rz+3wQuW8mPHrq/mXuPEG/miyDzshF4LUC2mh63Ipi8JNT0SNZnQl7km+IgH1ATNbn+Z1lOXfmvFuNw8dlQ76C44bHiBfrOIjmcdSKol2irVYIzgJGCYx29ObFbLsLpRQNE/2wjE52ZmV7aaMmvoDZp/qOpV5U6jAbk0wfLPZu5SL3QcpUbsMGCHX9ijXVM40gzD1l9HA+PJjkNoGfrudSzzcSjOJm5pWWdDrg==
Received: from OL1P279CA0028.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:13::15)
 by DBAPR10MB4316.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 16:59:50 +0000
Received: from HE1EUR01FT097.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:13:cafe::79) by OL1P279CA0028.outlook.office365.com
 (2603:10a6:e10:13::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Fri, 22 Apr 2022 16:59:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 HE1EUR01FT097.mail.protection.outlook.com (10.152.1.54) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 16:59:49 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Apr 2022 18:59:49 +0200
Received: from [139.22.137.211] (139.22.137.211) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Apr 2022 18:59:48 +0200
Message-ID: <967ff119-c3cc-6340-c4ce-471d6dd95d9f@siemens.com>
Date: Fri, 22 Apr 2022 18:59:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [isar-cip-core][PATCH v2 2/6] initramfs-abrootfs-hook: Convert to
 an initramfs-class recipe
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: <cip-dev@lists.cip-project.org>
CC: Quirin Gylstorff <quirin.gylstorff@siemens.com>, Christian Storm
	<christian.storm@siemens.com>
References: <cover.1650613658.git.jan.kiszka@siemens.com>
 <bec2642fc52c2cb38eade4569b88315dfa5dade6.1650613658.git.jan.kiszka@siemens.com>
In-Reply-To: 
 <bec2642fc52c2cb38eade4569b88315dfa5dade6.1650613658.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.137.211]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--17.555300-8.000000
X-TMASE-MatchedRID: G9QKf9eUqNA5QaOxwNGfvo9bHfxDWoibm7Y1PYDhGLrnBcjWg41W4H4J
	YJwdJw4TTvnpZOgua0BuU3c+6DuYA7pFBnS6uULLgLj/R6aiehvST8uvJbLgQF67ppG3mtjJ9/p
	lKg1lCsgzLmb0l2kucPtN2vjEPERNQ5AL8DYx7xKscXQUDNLy0EElpwBtHoIxUL+lPXRaPqn167
	87vFsqdBCOwdkP3NVe9lijtp+uizykz5X0uqhSdFB/D9lmIvK1rSKKfw/QqNU/QdUh6LEl0Mu99
	zcLpJbCpKG9GN+fhxRSkV47LHGpi5Jd8FxLEX71MVM6FCHqb7vACzB7RAZhOXCO70QAsBdCF4r8
	H5YrEqwntdTRDVV8h/Z8RDA0cqfQFgDH5MjhEJOClerjixwhDJBuyrHhdqZBbl4CKqupkMr0VPv
	T0zx0mKfub87GOZij8P7ohAxHFTni8zVgXoAltkWL4rBlm20vt7DW3B48kkHdB/CxWTRRu25FeH
	tsUoHuNI2kHm247ZPpCXvY5WYql1a8xm5xOyvcCiH7KAl/x9DFhXMjdQIJpg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.555300-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 DD8AE12B21D109F0399C35DAACEB987B7987B46E105D8DC286629B15174DEB052000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78f296c5-3f82-4f9e-056b-08da24818348
X-MS-TrafficTypeDiagnostic: DBAPR10MB4316:EE_
X-Microsoft-Antispam-PRVS: 
	<DBAPR10MB4316AA7F16A1B549817F715195F79@DBAPR10MB4316.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	NZ9Qmd4BqMmA615HPa0VlRPnOpxHoX0lMBqFUWw9yq8ZYXdvO5yv2NbIZr2k4/1kzCCNuqoyPvY8zVgnuYLQ5nPolKrOCCfeVh0Mp06T6y/pQ9dHcaQ1gHaCs7f2lYGzMyO0WwWTR7D/hpK1BGIiqMlhPZy9UxdzmTl5Bir2cUBXNAWtFSIIoUOo2smXSjWvbAYJrHgwsgj7wxOpyEFo31XTyBFEwe6wLmI5XIK79A1XhZOzhHfwSMsOn2M+zu9U84CJSyeVy8X3HJ0+IqyQ8XcmIozT48wfrBih8TAAzYzulJ4MbLLZb+XOnIc2bk5m8jhB684MGryjh1uR1itsmJC4oA3oRPm3E/IpbkPsnOiVInNadv/AMk+dITCZxYeh8wdW5g6F0LtJoskMh6nuGbxSCnkpJfqJaO32dvZajIXkadsa5dS0xoBRzl1J9SLVBDQ0gYY9L0LZ1vOwkSVQWkFK1o23m+XC9jTAIZsU2cNfwIoYXS8lNuSgzUB2g7Fibv0KA2nhh6BznsRIMtIA6Jk2g1dNMqmT0fSisHjQjXolJfAAvk07DZCRAClbFDkQea4OWmr0pQPSc6n8pnOg1aXmdIZciGgRdf6wLwqnXFXp9MBJXmEXWAZBlRLkMIHh5mZ6vOnzNRJZGKcIHrtmVFr1dWl03VeVVWoC+cIkwoIQGdmPhui3u/dv1nSnoP7sG3QZil1Jq/xbCqvS++shsT76NiJMb5y2x+BXCFuX/4LGQJ9rXu+3ZOg7P5kFFJSw+6WoGlLGeIZ/lM7A2NHjhtF9iAVBVASFCAiyNMLdyigwlBnD0S9YvFW0jDopIcvX
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(81166007)(356005)(83380400001)(16526019)(82960400001)(508600001)(44832011)(40460700003)(6706004)(5660300002)(8936002)(70586007)(70206006)(54906003)(8676002)(4326008)(956004)(31696002)(6916009)(2616005)(107886003)(186003)(86362001)(26005)(82310400005)(2906002)(53546011)(36756003)(31686004)(316002)(16576012)(336012)(36860700001)(47076005)(403724002)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 16:59:49.7481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 78f296c5-3f82-4f9e-056b-08da24818348
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT097.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4316
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Apr 2022 19:12:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8191

On 22.04.22 09:47, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This unifies the pattern we generate initramfs images for non-secure and
> secure SWUpdate images. Besides cleaning up the related abrootfs
> selection hook, the unification is a precondition for adding another
> initramfs recipe later that will be shared between both image types
> 
> The pattern followed in the new initramfs-abrootfs-hook script is now
> similar to initramfs-verity-hook: a local-top hook is used, rather than
> a patch for Debian's local script. This hook looks for the matching
> rootfs by read-only mounting candidates, comparing the contained UUID
> against the one stored in the initramfs, unmounting again, and then
> setting the ROOT variable on match.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  classes/image_uuid.bbclass                    |  6 +-
>  classes/secure-wic-swu-img.bbclass            |  4 --
>  classes/wic-swu-img.bbclass                   |  6 ++
>  kas/opt/ebg-secure-boot-snakeoil.yml          |  1 +
>  kas/opt/ebg-swu.yml                           |  2 +-
>  .../cip-core-initramfs/cip-core-initramfs.bb  |  4 --
>  .../{initramfs.lsblk.hook => abrootfs.hook}   | 11 +---
>  .../files/abrootfs.script                     | 66 +++++++++++++++++++
>  .../files/initramfs.image_uuid.hook           | 33 ----------
>  .../initramfs-abrootfs-hook/files/postinst    |  6 --
>  .../initramfs-abrootfs-hook_0.1.bb            | 41 +++++++-----
>  11 files changed, 104 insertions(+), 76 deletions(-)
>  rename recipes-initramfs/initramfs-abrootfs-hook/files/{initramfs.lsblk.hook => abrootfs.hook} (62%)
>  create mode 100644 recipes-initramfs/initramfs-abrootfs-hook/files/abrootfs.script
>  delete mode 100644 recipes-initramfs/initramfs-abrootfs-hook/files/initramfs.image_uuid.hook
>  delete mode 100644 recipes-initramfs/initramfs-abrootfs-hook/files/postinst
> 
> diff --git a/classes/image_uuid.bbclass b/classes/image_uuid.bbclass
> index 2813ed9..7294eb3 100644
> --- a/classes/image_uuid.bbclass
> +++ b/classes/image_uuid.bbclass
> @@ -1,10 +1,11 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2020
> +# Copyright (c) Siemens AG, 2020-2022
>  #
>  # Authors:
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#  Jan Kiszka <jan.kiszka@siemens.com>
>  #
>  # SPDX-License-Identifier: MIT
>  #
> @@ -27,7 +28,6 @@ do_generate_image_uuid() {
>          sudo tee -a '${IMAGE_ROOTFS}/etc/os-release'
>      image_do_mounts

This line is obsolete.

>  
> -    # update initramfs to add uuid
> -    sudo chroot '${IMAGE_ROOTFS}' update-initramfs -u
> +    echo "TARGET_IMAGE_UUID=\"${IMAGE_UUID}\"" > "${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.uuid.env"
>  }
>  addtask generate_image_uuid before do_copy_boot_files after do_rootfs_install

This one as well, plus it broke when no one else used DEPLOY_DIR_IMAGE
before. v3 will follow, fixing a similar issue in verity-img.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

