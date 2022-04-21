Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1EEC71128
	for <webhook@archiver.kernel.org>; Thu, 21 Apr 2022 16:46:11 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.42])
 by mx.groups.io with SMTP id smtpd.web09.17885.1650518920020727280
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Apr 2022 22:28:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Lq1qIbGB;
 spf=pass (domain: siemens.com, ip: 40.107.14.42,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2kkZ5BjR8+46LX+yKbVRyE4ey2obYniFsRyuxy5Q8f0zJ6wZVa9q/ST4nDT62QXrujDsxKGAS6aW9NATAyOQ/rh4QZeUxbj+Ecaq6FxwxX2u0/qb9+WbtenpeSPyTjccYxrTde3UI4bdSIS4i3YU8qAjxBNe1phSI6aJuu4lfHdvzAAah/0q9EUVGKsCXrFsjfDXIx4BmEf2ws5TBZ4uyH7hUoBr1Ltg0KkKRg2eykEzzT2F7nRFAu57SSFDzfuObdhCTBEsltQ8cJM7tNnwMSmxGec71+gDFJagh5Y5ifEkBkog902cybOpUEX3Az9NwhJ935ToXGaOgLHt4U8Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cesMug5SFXxxNvUYdGUKxjtLBn3lFoc7l1mfnfvZIm0=;
 b=MtQaxQ5IhHofHeJoczdkv+8B8FA5uWCNU50PLF8Qt4SVk34wifHYB0doYiVapwxi0R2HbOhZiIkk7kYey5DfmSbL4u4yQTnPQTsC7M/hdFhexaGNonMdLrxiqNlFEAOSIy8Ekjk1tzsLrFpksIlPHqJog9EJT2HOzKLYxAQN+r3b4UReW8LgiSp4J7mRGiaTaSAXwrb89uyJudsJ/nB1UKoCQ/umD7lLLRnYX1ZhOVprOxXbc5CkPkszsgV2pW1IVKSHXfLa/vHrPP6TKCdxbC+0OA41qknhwZ9oKK4ej9zKEvo+RIbFgYxOQJJpIrHZLcOJBVCYA7TDrHRmLFoCGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cesMug5SFXxxNvUYdGUKxjtLBn3lFoc7l1mfnfvZIm0=;
 b=Lq1qIbGBxgmksOM/BMohDH6H73KXon/rHW1eZv/4sL3YSaJuYiG2mJdrP/weAznoctorBdMiN0DkO5pViETU/FJNDg9QWg+hD0SktY9vgbh9KPd5iJiDarJ86OfKRCR4aLALV0EJWQAf3CKq93FjRwaliRf3WLSoHr83DlPh2IWEPVyjPOdkLUiHd3WcoOqt8Nnw344ftA18Y+BOdSgaN0ZRU/Ji6SJLQkpWo1OPjLYuThrj4fqu3S/6v9P4PBpfIDa5yogYSLEF4LFaDgp4NqU4lkWBPcBBBJWQ4BBPNxQPXhnXFa5PEDhXS4FVYJD/Y/+TquULSWdS+A4R/RlVlQ==
Received: from AS9PR06CA0235.eurprd06.prod.outlook.com (2603:10a6:20b:45e::34)
 by AM0PR10MB2209.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Thu, 21 Apr
 2022 05:28:36 +0000
Received: from VE1EUR01FT096.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:45e:cafe::db) by AS9PR06CA0235.outlook.office365.com
 (2603:10a6:20b:45e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Thu, 21 Apr 2022 05:28:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 VE1EUR01FT096.mail.protection.outlook.com (10.152.3.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Thu, 21 Apr 2022 05:28:35 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 07:28:35 +0200
Received: from [167.87.32.12] (167.87.32.12) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 21 Apr
 2022 07:28:34 +0200
Message-ID: <1ebe0fa5-49db-2c44-5b80-296c2ac2538d@siemens.com>
Date: Thu, 21 Apr 2022 07:28:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [cip-dev][isar-cip-core][PATCH] Bullseye: Fix journalctl on
 read-only
Content-Language: en-US
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <20220419154918.223283-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220419154918.223283-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.32.12]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--19.617200-8.000000
X-TMASE-MatchedRID: jHaaRReu0S85QaOxwNGfvo9bHfxDWoibvBkFvcgSMyIsisyWO3dp29yA
	omAsZentfz7H5SPFlpjo0Q+af7WkZ/I7xCPleag0FJ4Sig44mJ6Vf6JCu7Pe8SU8tW70+6utOve
	kY6F8PB7fUZT83lbkEIlE4nBOIRnvg3n8lw8GhruL/S4ZMx3GTPI1YbpS1+avyl2yL95kDWPr3E
	41VlKsfU5eE9HVP+GB/7R1viDPZXxRF2m5nDUJEX6O9V1h0uu0/0dTUjHNqgkPe5gzF3TVtxQQa
	ikHPEUntXl9IxEPXOpBDqT5YiJkSi9Ht6D4LD8tvCet/YhI36jQODanTO2mNOcFyNaDjVbg2gp+
	A6golzZYwVHjLI3nehia/MKkLl0DK3AMuHjnmQyG/2jAVj+LPndpFkj4BgGZ2K3acmlx/ml+CWC
	cHScOE1AoBBK61BhcYG32ZLukpVN6ipWzVkuu8DN360kR9zHUXHEPHmpuRH05f9Xw/xqKXVkMvW
	Auahr8+gD2vYtOFhgqtq5d3cxkNQP90fJP9eHt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--19.617200-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 F0F108A7D3049785BC7128733EE80448E2261CDF21BAC96BAC884231698101852000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e0df2af-dc06-4195-2166-08da2357c886
X-MS-TrafficTypeDiagnostic: AM0PR10MB2209:EE_
X-Microsoft-Antispam-PRVS: 
	<AM0PR10MB22093FDB5C20B966B7179DBD95F49@AM0PR10MB2209.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Ey5pnxiryLQ3LgWDfiUyYCOEYdru1CoxpjHLDbfJfJoYVmh9oRukUcc9YEJdC71ADhYUdVod/BEMA070P8TA2zDz/m4Z3v/cHULiGQHSqQ2cboucJ/SvJoNitxOHoFsrd6tUBD5pm+FrdUWCwUTmcXV1wCxEQWrOMejJhEbZh7kPaPQ8VoZNhjcZ5TkUSHPoUU/AWkjVkVIRYaZezWp3k1Pk340UymDzHOTjUCguIGP+uH1N7jUWhIRBuY4b6/QR5PgO5uucw0z9H1Gj/sKFkF8NGT/ujHZcodFmDhwbr4S3Yxi6+ie39dV0Dg7hwxro/nplNXuLFX/G6VNLM5oXtw7mtJbNPQGafsLHXixJJQrOaMYJx3X1yI6ae3mkWCX5u8C8DrBRaZ2gOQfMmvyHe4EnnBaEc43IoEnmub+v+KYPvWa1fJeETbifOGH4QORIaV9Ln7eVLGltcwKuT8vJhfbTNsLIbfStxGGI4vQXcOa8rgzYvYunuCOiHo3eiyxEEMHAV5tGXVapiouodjYkCQ7yy1nBQiKyr8FD/NJB4tz8Hgy+4uJDZqgIqZU144DVyCaRx6h7NE6zUqSY5tDwPdbiuRlEtvQxxdZt+CwMPEY0z5ueCf5XhtsIkTBdCG3up7R0yeZzPn9p7tJPaXRgzKLaP8mYATf3/0H9TuRKwcohoN9VbpmbOMwjj6Jy9zBNe5IhyJPuMKM23JPBgEbhl2gR5kjdhCINM1G2zdAxj+Ru9glldheg4tIZ5ogtu89RY9N8OIMEspJ44jF8OUw4lte/ZLYE3EX7jmjRGcFUUJG/EnTN51Q5XbchOik9KeogjPoNEuASukLHIr1oF2GGwL6vIRWVdj6WmjlZliEgyJQ=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(26005)(316002)(336012)(2616005)(53546011)(31696002)(8936002)(83380400001)(2906002)(966005)(40460700003)(508600001)(5660300002)(44832011)(86362001)(16526019)(70206006)(110136005)(70586007)(81166007)(47076005)(186003)(956004)(31686004)(356005)(82960400001)(82310400005)(36860700001)(6706004)(8676002)(36756003)(16576012)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 05:28:35.9082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 4e0df2af-dc06-4195-2166-08da2357c886
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT096.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2209
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Apr 2022 16:46:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8150

On 19.04.22 17:49, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> If an image with a read-only partition and etc overlay
> is build journalctl does not display the system log in
> Debian Bullseye.
> 
> The log is available with the command `journalctl --merged'.
> 
> The root cause is overwriting the  mount point for /etc/machine-id
> by the etc-overlay. This leads to the usage of multiple machine-ids
> and journalctl does not match the current used journal file to
> the machine.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  kas-cip.yml                                   |  4 ++
>  ...stproc-extension-Remove-etc-machine-.patch | 37 +++++++++++++++++++
>  2 files changed, 41 insertions(+)
>  create mode 100644 patches/isar/0001-classes-image-postproc-extension-Remove-etc-machine-.patch
> 
> diff --git a/kas-cip.yml b/kas-cip.yml
> index fce176b..2c2b7d7 100644
> --- a/kas-cip.yml
> +++ b/kas-cip.yml
> @@ -29,6 +29,10 @@ repos:
>        fix-pseudo:
>          repo: cip-core
>          path: patches/isar/0001-Fix-permissions-when-splitting-rootfs-folders-across.patch
> +      fix-machine-id:
> +        repo: cip-core
> +        path: patches/isar/0001-classes-image-postproc-extension-Remove-etc-machine-.patch
> +
>  
>  bblayers_conf_header:
>    standard: |
> diff --git a/patches/isar/0001-classes-image-postproc-extension-Remove-etc-machine-.patch b/patches/isar/0001-classes-image-postproc-extension-Remove-etc-machine-.patch
> new file mode 100644
> index 0000000..95b49ae
> --- /dev/null
> +++ b/patches/isar/0001-classes-image-postproc-extension-Remove-etc-machine-.patch
> @@ -0,0 +1,37 @@
> +From 6e72a422c52f9995f5ee3acca293b92a7c0194d9 Mon Sep 17 00:00:00 2001
> +From: kas <kas@example.com>
> +Date: Tue, 19 Apr 2022 14:52:54 +0000
> +Subject: [PATCH] classes/image-postproc-extension: Remove /etc/machine-id
> +
> +In a read-only system the machine id should be deleted or 
> +set to `unitialized\n`[1]. 
> +
> +Systemd will generate a new machine-id during the first boot. 
> +In the case of a read-only root file system Systemd generates a mount point with 
> +the machine id. If an overlay for /etc is used this creates a mount conflict. 
> +To avoid the conflict between the overlay filesystem and systemd /etc/machine-id 
> +mount point deleted the file /etc/machine-id.
> +
> +[1]: https://systemd.io/BUILDING_IMAGES/
> +
> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +---
> + meta/classes/image-postproc-extension.bbclass | 2 +-
> + 1 file changed, 1 insertion(+), 1 deletion(-)
> +
> +diff --git a/meta/classes/image-postproc-extension.bbclass b/meta/classes/image-postproc-extension.bbclass
> +index ca520273..0c412c0d 100644
> +--- a/meta/classes/image-postproc-extension.bbclass
> ++++ b/meta/classes/image-postproc-extension.bbclass
> +@@ -57,7 +57,7 @@ ROOTFS_POSTPROCESS_COMMAND =+ "image_postprocess_machine_id"
> + image_postprocess_machine_id() {
> +     # systemd(1) takes care of recreating the machine-id on first boot
> +     sudo rm -f '${IMAGE_ROOTFS}/var/lib/dbus/machine-id'
> +-    sudo install -m 644 '/dev/null' '${IMAGE_ROOTFS}/etc/machine-id'
> ++    sudo rm -f '${IMAGE_ROOTFS}/etc/machine-id'
> + }
> + 
> + ROOTFS_POSTPROCESS_COMMAND =+ "image_postprocess_sshd_key_regen"
> +-- 
> +2.35.1
> +

As discussed directly already: It takes more than that to make systemd
happy, and the easiest approach will be mounting /etc overlay from
within the initramfs. I have a prototype working, but it will also need
a conversion of image-uuid to a cip-core-initramfs recipe so that it can
be applied to both secure and non-secure read-only setups. I'm on it.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

