Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0D8C7EE2F
	for <webhook@archiver.kernel.org>; Fri,  3 Mar 2023 07:11:54 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.72])
 by mx.groups.io with SMTP id smtpd.web11.18055.1677827505279238717
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Mar 2023 23:11:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=quKuM/i7;
 spf=pass (domain: siemens.com, ip: 40.107.247.72, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eU2i/bgeIWCjk3a/FcFlyLKdtYRKarEUMJQ2LJnkXO4Dy+YHZHr/fAzG2V70aEF6epYfJrkmKUnZPf9GAl0mWWIYrKiohWSY7SYFFp1j8UobfY3O9tdsrwa2LukEopWB0EB79XkIjGu2HyOz86cCK6PrYi0+djb62cryvor+ZR7SQqlyAWaUfi65R+JdSw075l7aWKkoy1S6Xbs+qgefEe4+K+03rRRvSGxXB+Kp5+xpe6nH9sfjCNqvSDfCkpqiOQ2WkP81pVYtAuY8pjXTRdllgRku7hs+Kx31RCUCzJlXX9NFg2JJrbt2UvzZ1YQMwiEmEzDnIxLU4x2EhhjpYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFIm6kigYU3TTohIsAReThLIRUXdtDZwbMJFw0HC86Q=;
 b=fvI4k2tghmMOXl9qdyaTuO5DdE4hnCe+VxsrBICgB+OgNUQsoMhoBkJlQ8XG8I0PPWCxKxNSH2azHwiy1sTGl7eMVQmfrLVExOxa+/wrpJh3a9HYd6SxHyGBpK4hPtjF98zik/65YElv2yNUolJPhu+/b0FyYq/xhvC7BdTjJCyXXkiC9BNjyATVw66QYRpM2/cZqx0teJqgK17OspHhKfKZ62pjfoAgGfqvaF8r4eNhHbu+OdvrIf9ZtA6xQdX2adhpULscIKLcZwTg1ASL0gYkbouW8w1Y9ByLyzEvT5T8v5PLYcDwsBlxNKgAspsCuODnF5km0Vl/f6AkbGjs2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFIm6kigYU3TTohIsAReThLIRUXdtDZwbMJFw0HC86Q=;
 b=quKuM/i7pVxz5iOb1u5v9tvYKJu6cDcxNTgN3mfMX4GH6nUU02beI2Gsta5cK7fm4GZX2JPsypb0LAbcBR3eTmb/fHF1i+xJP1f6ncPx+aW9+Umh5a82lrUj+q+qIL2QMxFj/W4x/4v4/kWJgaF4Gu4qJK0lfOG5aQah7iDCoyAeglwMGD0FWvOOmr0HHSoCsS04bGH0OkKXImRYd6bLj2xtKJkqS/ueQELaADrYkS9kC6/eN0L5CKu7Y4Vo1B7d+s7I/0hnhg8ffchh9MxiHF3SOTYJpAgRQEAX45QnvDVHeNrIJOFEPwzxvTC4RP8jkIMw1hNNA6ASNXn9/OF4jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS5PR10MB8145.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:672::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.10; Fri, 3 Mar
 2023 07:11:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%6]) with mapi id 15.20.6178.007; Fri, 3 Mar 2023
 07:11:40 +0000
Message-ID: <fa5c5337-e190-b744-13f2-06dbadea8ee7@siemens.com>
Date: Fri, 3 Mar 2023 08:11:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [isar-cip-core][PATCH v3 5/9] add opensbi with u-boot payload for
 riscv64
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: daniel.bovensiepen@siemens.com, quirin.gylstorff@siemens.com
References: <20230302152659.2096307-1-felix.moessbauer@siemens.com>
 <20230302152659.2096307-6-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230302152659.2096307-6-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS5PR10MB8145:EE_
X-MS-Office365-Filtering-Correlation-Id: 806b2ce8-f564-4682-9dc9-08db1bb6895d
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qJwElqg/ygdY4ySPQmLjYHmZHdoQGos0IbPFHd2sXnE5wGjX9yNQklZi4WQvyCIc+/RCboY0dOd0mFxjl/focD8acgaJ/8c72+QigZFN26y17BaJyKyz+DuCfRmfiWEva4uBwaj3I7aCF69ttFlmXWW69AI6wjYf0AZLrfzIFisXv5KGtEhBFojy9rLogd0bBE05zSUVkYldAZFw5vE6EtxWcNZBlY55Wa8M2qFgZshFk1JWPy6+Y9TvEoK4bQkZtQZ0hUiFN8wP9QNti7nWdUqEhCtLAR7Jm3+VryKbrHJmrhhyrb+Pgb8gSR09x57wqLRxzrc4K1j2OTAaNj0pbezMIS8NVmGG2bewVo70mA/MXn/Y4BEjd+BL0YSjCMoPCvICMebredppT7U0jrM8snwx84hTV2cbgeDqdWW1nENBduCV3K9E3YiiFjx5sDCXLErLfPbdAOdC9eIZANxMmQMND/+JYG/l/Gzv4UHQj1SRm1pNCV0xvMHyGQB3zDR0Sid05Ir2Z/MNsvpVH9r4pSGVerq4hQpJXf8GgH0J/+Yu6p+5Y2lCztcqFlY4KIbim8b0TbJIIAZGtkGGCiXU7AWqBjFRxHnvjLBiicmraspPPKlndMvvsuoQlipwXUJyffyhYPiZuHEaCdipfQMz+F8TftL6u/Iy5lk1IDqDa9wsdwYaKi/Ysw2hBCYVGOaDSxXUkC7R8yJeCrC9ze4hb5acuxc0Cl9UsI4HZ0srsG4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199018)(83380400001)(31686004)(107886003)(36756003)(38100700002)(8936002)(5660300002)(82960400001)(478600001)(2906002)(86362001)(31696002)(2616005)(186003)(26005)(6512007)(6506007)(53546011)(6486002)(966005)(66476007)(66556008)(66946007)(30864003)(8676002)(44832011)(316002)(4326008)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZWpkWGdPZm1rb0xJbXA1NUErUTN6OVFPcnVjamd4QTdRb2IyRnVuWWl1QmRZ?=
 =?utf-8?B?cmM3eU14aUlxTGpoeGIrV2FaZG9mb3pKS1Q3b1ZJLzVVd2cxSW5TVFlKWmto?=
 =?utf-8?B?cDdCNUtKSU4rRkRiWmw3b25NMVVLVWV3UkY2S3JGU1pvQ1RzazM4RVVoNWtV?=
 =?utf-8?B?clJ5aHlvQnlYVkkyT1R5azkxSXMwUmp1R1VlRjRvY2xaZlBSdkQrbEpQOTFk?=
 =?utf-8?B?L2docEtOTGhjbXlvNmZ4c0pDb0lOSmFreUQwbElQaDlocTQ5d1BPMXJDN2dn?=
 =?utf-8?B?UXpGdnlqeFlVZ2tBYXo0RFZ3RU5wQ08yZHFaU0ZGTTIrT3g2SE9COVpZQy9w?=
 =?utf-8?B?WG9CRmFzVnFDTE9GRnRFTWE5c1dKanl6cDBBNDJpdzFiNTA3TGJaUW5nTzZZ?=
 =?utf-8?B?ckh4a0krRFlhQTJnblJHbVRYcGxmQityR3dYUmxia2xWS3JUM2RuNVY5OHVr?=
 =?utf-8?B?UUZMK2JnZy83eU1tUnFHNUVjQjg5V1BTVXR3QkxHRW40Um9qdkVLdk1vc0po?=
 =?utf-8?B?NFk2c1pGbHk0ellFWTFtZXZWazRRWXR2U254cjhlajRQM282K3hKMmxlQzZi?=
 =?utf-8?B?M1NsUEZlQ0pXUkRmVk95NXgrMWVaamdFTmZLYWZHTnI4LzFyWDQ1WnEzMDVL?=
 =?utf-8?B?VmIzVzlWaityQVIrMVhoc1ltWU4xMGQ3RnE2M241NE5vK0RkdHFtKzRMbUo5?=
 =?utf-8?B?blZ2ZkF6cnMxb2pGS0V6UFM2Q3FQc3ZTOGVxazJuTkk1NHdnSVFpeG9OVDlj?=
 =?utf-8?B?ZEgyTUZ5TW1CeDd5YTRudHZuZjJSRGtILzcrLzdJRVdncnpBL000RjRLT0xp?=
 =?utf-8?B?ZU1oS2pwUVcxd3I0ek0yM2dhV1hrWFRZU3k1Q0lzMXV3UTE3ZkNjMENDRzRH?=
 =?utf-8?B?U2QzZ2pqUXpzTEZJU3dzYWNVMWg2ZVFmS2dIdlJ2TldDNEk2VnBmckxUUnF3?=
 =?utf-8?B?bkl2SzJHOXdaZ0thRnNDSFB3YVFkTlEwaWtmQlRWMEdXb3gxak1zYW80VGg2?=
 =?utf-8?B?UHhnV1Jta1NGMzZXVTI3cllPN29OaEtMNnRJU1A1TFExdmNyeVN6REdnK2Fz?=
 =?utf-8?B?TWovZ1RSN2M5SDN2OGs2WHV4MXpkSy9ELzNLMXRUWXB3Nko1NnU1djNXaDEx?=
 =?utf-8?B?cXpwTWdXV0RvZisrTGpIQUVnSW5JRnA5M043Ym02YlZrdVVCbjk3LzJyTW9x?=
 =?utf-8?B?M0xkbmR4YW5TTU5hOGpRZlhRakZ4R09FNDJFY28yaGpNekcyZFlvWUNwUDRv?=
 =?utf-8?B?TWY3bFpGZW13STU1dTBRUDkwWmsxT00zaHFuQUdKL2FobmZhR2hGN25HaEVY?=
 =?utf-8?B?QW9kbE9heDFJZnB0NmN3ckhSTmppWnkvTENKMklHN1orZW1BVzk3aGhxYk1J?=
 =?utf-8?B?M3Z1bmhrcHZzTDNiTVFFZkgvVFRQd0FpT3gwZUNaYjNpU0tTUHFKZkpkZ3RL?=
 =?utf-8?B?d2xqUVZNZkkxa0tKWDU1VThoeUUzS2JGZkV4RVcvczVtUDdmNThYdGlhSDlo?=
 =?utf-8?B?RjJYN2doK0JGNVN5U0lqa2FzTjZSUHpjcFFwUHZqYUFEV1BIM0t4WGhrUGJC?=
 =?utf-8?B?dGlhN2pYaHdyS2k3N09BTWg2WHhYUTZiVmZ6QWViR3FBTUtibUZ6TUNrSVpm?=
 =?utf-8?B?YUU2R21YWEVGSUptUDFMdkZYSmpOVzg5NkxTUWdPOHd2dWVlRTN5dk9SSFJQ?=
 =?utf-8?B?OUpPcm52WjRiZEJrUTV3enRZNHppcTNPU0FwVVFyYWRNU3RndW16NkFITXVi?=
 =?utf-8?B?R2RoTytmVGdzR1R0UFlDb3hUUkZhdGNaRU1CVWJub1JFd2NFL2ErZ3RxYnM1?=
 =?utf-8?B?VWFYYS9TYUsvRHd3aVBQUUZlNU9sNWpZdzhkTjBhVHhYT2l6K0lOU0J3eVd0?=
 =?utf-8?B?c29JQ1MreldCRzlQcVkyZFZjVmo5Nnh1QTFycS9iUTZmdVFlcUk4cWVQYU5w?=
 =?utf-8?B?NElicmVKUTh0dVJZa210Z1ZtUEljVlZOaGpiOXI5elhLNWhsUXgwejBwdDFZ?=
 =?utf-8?B?RUFQU05hVzRrci9NT3oyK3NCUzBUNWdXM29zcXhaL3dualJESVRZQmdSZG5r?=
 =?utf-8?B?MlQ1ak1rTlliR0JXOEhhM1htL1BNYzNuVmdOQTk3R2loU0NRTTNwU0JkTjQw?=
 =?utf-8?B?RWhZdWRQK09ES0pHb1c3aGVoRS9qaWZtZ2wyU0l5dXcwT1FUNkkvVnp6YmFK?=
 =?utf-8?B?WEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 806b2ce8-f564-4682-9dc9-08db1bb6895d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 07:11:40.7387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V3WtNPXMi7oWFeySMZjCuMJNyojQFrWCJYPC715GzvY6/qPynuWCUFunlp2hvLDqG/csYjg7HatreWuUeoKIjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8145
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Mar 2023 07:11:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10891

On 02.03.23 16:26, Felix Moessbauer wrote:
> This patch adds the opensbi firmware with u-boot payload (smode) for the
> qemu-riscv64 machine. Using that, the generated riscv64 images can be
> booted on qemu.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  recipes-bsp/opensbi/files/qemu-riscv64-rules  | 12 +++
>  .../opensbi/opensbi-qemu-riscv64_1.2.bb       |  8 ++
>  recipes-bsp/opensbi/opensbi.inc               | 45 ++++++++++
>  ...iscv-Fix-build-against-binutils-2.38.patch | 55 ++++++++++++
>  ...upport-building-double-float-modules.patch | 89 +++++++++++++++++++
>  .../u-boot/u-boot-qemu-riscv64_2022.07.bb     | 23 +++++
>  6 files changed, 232 insertions(+)
>  create mode 100644 recipes-bsp/opensbi/files/qemu-riscv64-rules
>  create mode 100644 recipes-bsp/opensbi/opensbi-qemu-riscv64_1.2.bb
>  create mode 100644 recipes-bsp/opensbi/opensbi.inc
>  create mode 100644 recipes-bsp/u-boot/files/riscv64/0001-riscv-Fix-build-against-binutils-2.38.patch
>  create mode 100644 recipes-bsp/u-boot/files/riscv64/0002-riscv-support-building-double-float-modules.patch
>  create mode 100644 recipes-bsp/u-boot/u-boot-qemu-riscv64_2022.07.bb
> 
> diff --git a/recipes-bsp/opensbi/files/qemu-riscv64-rules b/recipes-bsp/opensbi/files/qemu-riscv64-rules
> new file mode 100644
> index 0000000..960e10c
> --- /dev/null
> +++ b/recipes-bsp/opensbi/files/qemu-riscv64-rules
> @@ -0,0 +1,12 @@
> +#!/usr/bin/make -f
> +
> +ifneq ($(DEB_BUILD_GNU_TYPE),$(DEB_HOST_GNU_TYPE))
> +export CROSS_COMPILE=$(DEB_HOST_GNU_TYPE)-
> +endif
> +
> +override_dh_auto_build:
> +	CFLAGS= LDFLAGS= $(MAKE) $(PARALLEL_MAKE) PLATFORM=generic \
> +		FW_PAYLOAD_PATH=/usr/lib/u-boot/qemu-riscv64/u-boot.bin
> +
> +%:
> +	dh $@
> diff --git a/recipes-bsp/opensbi/opensbi-qemu-riscv64_1.2.bb b/recipes-bsp/opensbi/opensbi-qemu-riscv64_1.2.bb
> new file mode 100644
> index 0000000..b503afc
> --- /dev/null
> +++ b/recipes-bsp/opensbi/opensbi-qemu-riscv64_1.2.bb
> @@ -0,0 +1,8 @@
> +#
> +# Copyright (c) Siemens AG, 2023
> +#
> +# SPDX-License-Identifier: MIT
> +
> +include opensbi.inc
> +
> +SRC_URI[opensbi.sha256sum] = "8fcbce598a73acc2c7f7d5607d46b9d5107d3ecbede8f68f42631dcfc25ef2b2"
> diff --git a/recipes-bsp/opensbi/opensbi.inc b/recipes-bsp/opensbi/opensbi.inc
> new file mode 100644
> index 0000000..b41a8bb
> --- /dev/null
> +++ b/recipes-bsp/opensbi/opensbi.inc
> @@ -0,0 +1,45 @@
> +#
> +# Copyright (c) Siemens AG, 2023
> +#
> +# SPDX-License-Identifier: MIT
> +
> +inherit dpkg
> +
> +U_BOOT_PACKAGE ?= "u-boot-${MACHINE}"
> +PLATFORM ?= "generic"
> +
> +DEPLOYDIR_FIRMWARE = "${WORKDIR}/deploy-fw"
> +SSTATETASKS += "do_deploy"
> +
> +SRC_URI = " \
> +    https://github.com/riscv/opensbi/archive/v${PV}.tar.gz;downloadfilename=opensbi-${PV}.tar.gz;name=opensbi \
> +    file://${MACHINE}-rules"
> +
> +S = "${WORKDIR}/opensbi-${PV}"
> +
> +DEPENDS += "${U_BOOT_PACKAGE}"
> +DEBIAN_BUILD_DEPENDS .= ",${U_BOOT_PACKAGE}"
> +
> +do_prepare_build[cleandirs] += "${S}/debian"
> +do_prepare_build() {
> +    cp ${WORKDIR}/${MACHINE}-rules ${WORKDIR}/rules
> +    deb_debianize
> +
> +    echo "build/platform/${PLATFORM}/firmware/fw_payload.bin /usr/lib/opensbi/${MACHINE}/" > ${S}/debian/install
> +}
> +
> +do_deploy[cleandirs] += "${DEPLOYDIR_FIRMWARE}"
> +do_deploy[sstate-inputdirs] = "${DEPLOYDIR_FIRMWARE}"
> +do_deploy[sstate-outputdirs] = "${DEPLOY_DIR_IMAGE}"
> +do_deploy() {
> +    dpkg --fsys-tarfile "${WORKDIR}/${PN}_${PV}_${DISTRO_ARCH}.deb" | \
> +        tar xOf - "./usr/lib/opensbi/${MACHINE}/fw_payload.bin" \
> +        > "${DEPLOYDIR_FIRMWARE}/fw_payload.bin"
> +}
> +
> +python do_deploy_setscene () {
> +    sstate_setscene(d)
> +}
> +addtask do_deploy_setscene
> +
> +addtask deploy after do_dpkg_build before do_deploy_deb

This inc seems to be an Isar upstreaming candidate, right? I suspect in
can help meta-isar/recipes-bsp/opensbi/opensbi-sifive-fu540_1.1.bb and
your upcoming VisonFive 2 recipe. We can carry it here meanwhile, not an
issue.

> diff --git a/recipes-bsp/u-boot/files/riscv64/0001-riscv-Fix-build-against-binutils-2.38.patch b/recipes-bsp/u-boot/files/riscv64/0001-riscv-Fix-build-against-binutils-2.38.patch
> new file mode 100644
> index 0000000..6f8a2ae
> --- /dev/null
> +++ b/recipes-bsp/u-boot/files/riscv64/0001-riscv-Fix-build-against-binutils-2.38.patch
> @@ -0,0 +1,55 @@
> +From 5df4b2299f86933fa79aa3bc6a3986fc7e55b7e0 Mon Sep 17 00:00:00 2001
> +From: Alexandre Ghiti <alexandre.ghiti@canonical.com>
> +Date: Mon, 3 Oct 2022 18:07:54 +0200
> +Subject: [PATCH 1/2] riscv: Fix build against binutils 2.38
> +
> +The following description is copied from the equivalent patch for the
> +Linux Kernel proposed by Aurelien Jarno:
> +
> +>From version 2.38, binutils default to ISA spec version 20191213. This
> +means that the csr read/write (csrr*/csrw*) instructions and fence.i
> +instruction has separated from the `I` extension, become two standalone
> +extensions: Zicsr and Zifencei. As the kernel uses those instruction,
> +this causes the following build failure:
> +
> +arch/riscv/cpu/mtrap.S: Assembler messages:
> +arch/riscv/cpu/mtrap.S:65: Error: unrecognized opcode `csrr a0,scause'
> +arch/riscv/cpu/mtrap.S:66: Error: unrecognized opcode `csrr a1,sepc'
> +arch/riscv/cpu/mtrap.S:67: Error: unrecognized opcode `csrr a2,stval'
> +arch/riscv/cpu/mtrap.S:70: Error: unrecognized opcode `csrw sepc,a0'
> +
> +Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
> +Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> +Tested-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> +Tested-by: Heiko Stuebner <heiko@sntech.de>
> +Tested-by: Christian Stewart <christian@paral.in>
> +Reviewed-by: Rick Chen <rick@andestech.com>
> +---
> + arch/riscv/Makefile | 11 ++++++++++-
> + 1 file changed, 10 insertions(+), 1 deletion(-)
> +
> +diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> +index 0b80eb8d86..53d1194ffb 100644
> +--- a/arch/riscv/Makefile
> ++++ b/arch/riscv/Makefile
> +@@ -24,7 +24,16 @@ ifeq ($(CONFIG_CMODEL_MEDANY),y)
> + 	CMODEL = medany
> + endif
> + 
> +-ARCH_FLAGS = -march=$(ARCH_BASE)$(ARCH_A)$(ARCH_C) -mabi=$(ABI) \
> ++RISCV_MARCH = $(ARCH_BASE)$(ARCH_A)$(ARCH_C)
> ++
> ++# Newer binutils versions default to ISA spec version 20191213 which moves some
> ++# instructions from the I extension to the Zicsr and Zifencei extensions.
> ++toolchain-need-zicsr-zifencei := $(call cc-option-yn, -mabi=$(ABI) -march=$(RISCV_MARCH)_zicsr_zifencei)
> ++ifeq ($(toolchain-need-zicsr-zifencei),y)
> ++	RISCV_MARCH := $(RISCV_MARCH)_zicsr_zifencei
> ++endif
> ++
> ++ARCH_FLAGS = -march=$(RISCV_MARCH) -mabi=$(ABI) \
> + 	     -mcmodel=$(CMODEL)
> + 
> + PLATFORM_CPPFLAGS	+= $(ARCH_FLAGS)
> +-- 
> +2.30.2
> +
> diff --git a/recipes-bsp/u-boot/files/riscv64/0002-riscv-support-building-double-float-modules.patch b/recipes-bsp/u-boot/files/riscv64/0002-riscv-support-building-double-float-modules.patch
> new file mode 100644
> index 0000000..ec7d7d3
> --- /dev/null
> +++ b/recipes-bsp/u-boot/files/riscv64/0002-riscv-support-building-double-float-modules.patch
> @@ -0,0 +1,89 @@
> +From 5aefdcad0950c244d826988a8bd2f90584399849 Mon Sep 17 00:00:00 2001
> +From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> +Date: Wed, 12 Oct 2022 14:59:51 +0200
> +Subject: [PATCH 2/2] riscv: support building double-float modules
> +
> +The riscv32 toolchain for GCC-12 provided by kernel.org contains libgcc.a
> +compiled for double-float. To link to it we have to adjust how we build
> +U-Boot.
> +
> +As U-Boot actually does not use floating point at all this should not
> +make a significant difference for the produced binaries.

Why do we need this patch?

> +
> +Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> +Reviewed-by: Rick Chen <rick@andestech.com>
> +Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
> +---
> + arch/riscv/Kconfig  | 15 +++++++++++++++
> + arch/riscv/Makefile | 15 ++++++++++++---
> + 2 files changed, 27 insertions(+), 3 deletions(-)
> +
> +diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> +index 0cf51799fe..25ed0ba1cf 100644
> +--- a/arch/riscv/Kconfig
> ++++ b/arch/riscv/Kconfig
> +@@ -161,6 +161,21 @@ config RISCV_ISA_C
> + 	  when building U-Boot, which results in compressed instructions in the
> + 	  U-Boot binary.
> + 
> ++config RISCV_ISA_F
> ++	bool "Standard extension for Single-Precision Floating Point"
> ++	default y
> ++	help
> ++	  Adds "F" to the ISA string passed to the compiler.
> ++
> ++config RISCV_ISA_D
> ++	bool "Standard extension for Double-Precision Floating Point"
> ++	depends on RISCV_ISA_F
> ++	default y
> ++	help
> ++	  Adds "D" to the ISA string passed to the compiler and changes the
> ++	  riscv32 ABI from ilp32 to ilp32d and the riscv64 ABI from lp64 to
> ++	  lp64d.
> ++
> + config RISCV_ISA_A
> + 	def_bool y
> + 
> +diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> +index 53d1194ffb..4963b5109b 100644
> +--- a/arch/riscv/Makefile
> ++++ b/arch/riscv/Makefile
> +@@ -5,15 +5,22 @@
> + 
> + ifeq ($(CONFIG_ARCH_RV64I),y)
> + 	ARCH_BASE = rv64im
> +-	ABI = lp64
> ++	ABI_BASE = lp64
> + endif
> + ifeq ($(CONFIG_ARCH_RV32I),y)
> + 	ARCH_BASE = rv32im
> +-	ABI = ilp32
> ++	ABI_BASE = ilp32
> + endif
> + ifeq ($(CONFIG_RISCV_ISA_A),y)
> + 	ARCH_A = a
> + endif
> ++ifeq ($(CONFIG_RISCV_ISA_F),y)
> ++	ARCH_F = f
> ++endif
> ++ifeq ($(CONFIG_RISCV_ISA_D),y)
> ++	ARCH_D = d
> ++	ABI_D = d
> ++endif
> + ifeq ($(CONFIG_RISCV_ISA_C),y)
> + 	ARCH_C = c
> + endif
> +@@ -24,7 +31,9 @@ ifeq ($(CONFIG_CMODEL_MEDANY),y)
> + 	CMODEL = medany
> + endif
> + 
> +-RISCV_MARCH = $(ARCH_BASE)$(ARCH_A)$(ARCH_C)
> ++
> ++RISCV_MARCH = $(ARCH_BASE)$(ARCH_A)$(ARCH_F)$(ARCH_D)$(ARCH_C)
> ++ABI = $(ABI_BASE)$(ABI_D)
> + 
> + # Newer binutils versions default to ISA spec version 20191213 which moves some
> + # instructions from the I extension to the Zicsr and Zifencei extensions.
> +-- 
> +2.30.2
> +
> diff --git a/recipes-bsp/u-boot/u-boot-qemu-riscv64_2022.07.bb b/recipes-bsp/u-boot/u-boot-qemu-riscv64_2022.07.bb
> new file mode 100644
> index 0000000..6f101c5
> --- /dev/null
> +++ b/recipes-bsp/u-boot/u-boot-qemu-riscv64_2022.07.bb
> @@ -0,0 +1,23 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2022
> +#
> +# Authors:
> +#  Jan Kiszka <jan.kiszka@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +require u-boot-qemu-common.inc
> +
> +# we run as OpenSBI payload, hence use smode
> +U_BOOT_CONFIG = "${MACHINE}_smode_defconfig"
> +
> +EFI_ARCH = "riscv64"
> +
> +SRC_URI += " \
> +    file://riscv64/0001-riscv-Fix-build-against-binutils-2.38.patch \
> +    file://riscv64/0002-riscv-support-building-double-float-modules.patch"
> +
> +U_BOOT_BIN = "u-boot.bin"

-- 
Siemens AG, Technology
Competence Center Embedded Linux


