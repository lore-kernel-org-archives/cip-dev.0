Return-Path: <florian.bezdeka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE87E77197
	for <webhook@archiver.kernel.org>; Thu,  9 Jan 2025 08:11:37 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.43253.1736410295858174999
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Jan 2025 00:11:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=florian.bezdeka@siemens.com header.s=fm1 header.b=DYMFYnK9;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-68982-20250109081132f547ac5c4b55d80f61-zzyxdm@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20250109081132f547ac5c4b55d80f61
        for <cip-dev@lists.cip-project.org>;
        Thu, 09 Jan 2025 09:11:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=0KNeevtdWqHo7FxvSL4pUE2RyTA9E+rM8PLBKax3NZY=;
 b=DYMFYnK9FGWiWxnyaWZ0WpalbMnrhpEeo0cYeWOuw3jfxcreYi1hIW0VLXr2hf86CKE+Ov
 qJXSgP3bLg/X2v3n58zASKiAm8UtjVgM0s9uhq/UZgqNwaPha+OZ46AWlhD0KvQOoWqyusWZ
 3ttVEadJiJ90zsKPQRxyDQ1yx0CKrldDMPZjMAlNmEV0/KiPcV9OicCKfx5FyUCNLRFN+0GM
 +WbjXOWOcRH4MM3ONaiW53Jgt/GrX88y3L3mfuPweVR8qf/Ss7QEkj/mQN5U51xcNuwCSGPC
 crfPjj+ccIEUFOkgKgB8J1Iu4q4XB6c3vv/0YYZ/Kz+mIfGmf6NzBCxA==;
Message-ID: <ae76220a96b4e1a58889755492db2079cd251cc0.camel@siemens.com>
Subject: Re: [cip-dev] [PATCH 1/1] linux-cip: add kernel config snippet for
 container compatibility
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Michael Adler <michael.adler@siemens.com>
Date: Thu, 09 Jan 2025 09:11:31 +0100
In-Reply-To: <20250108100755.55673-2-michael.adler@siemens.com>
References: <20250108100755.55673-1-michael.adler@siemens.com>
	 <20250108100755.55673-2-michael.adler@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Jan 2025 08:11:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17510

On Wed, 2025-01-08 at 11:07 +0100, Michael Adler via lists.cip-
project.org wrote:
> Obtaining a fully functional kernel configuration as required by popular
> container engines such as Docker or Podman can be challenging. By
> setting the Bitbake variable USE_CIP_KERNEL_CONTAINER_CONFIG to 1, a
> kernel config snippet is included to ensure compatibility with these
> container engines.
>=20
> Note: This feature is designed to be separate from the cip-kernel-config
> project to allow for custom kernel configurations.
>=20
> Signed-off-by: Michael Adler <michael.adler@siemens.com>
> ---
>  conf/machine/qemu-amd64.conf              |   1 +
>  conf/machine/qemu-arm64.conf              |   1 +
>  recipes-kernel/linux/files/container.cfg  | 114 ++++++++++++++++++++++
>  recipes-kernel/linux/linux-cip-common.inc |   5 +
>  4 files changed, 121 insertions(+)
>  create mode 100644 recipes-kernel/linux/files/container.cfg
>=20
> diff --git a/conf/machine/qemu-amd64.conf b/conf/machine/qemu-amd64.conf
> index d786646..dad6504 100644
> --- a/conf/machine/qemu-amd64.conf
> +++ b/conf/machine/qemu-amd64.conf
> @@ -10,4 +10,5 @@ DISTRO_ARCH =3D "amd64"
> =20
>  IMAGE_FSTYPES ?=3D "ext4"
>  USE_CIP_KERNEL_CONFIG =3D "1"
> +USE_CIP_KERNEL_CONTAINER_CONFIG =3D "1"
>  KERNEL_DEFCONFIG =3D "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/=
cip_merged_defconfig"
> diff --git a/conf/machine/qemu-arm64.conf b/conf/machine/qemu-arm64.conf
> index a2c5e53..8fd824c 100644
> --- a/conf/machine/qemu-arm64.conf
> +++ b/conf/machine/qemu-arm64.conf
> @@ -10,6 +10,7 @@ DISTRO_ARCH =3D "arm64"
> =20
>  IMAGE_FSTYPES ?=3D "ext4"
>  USE_CIP_KERNEL_CONFIG =3D "1"
> +USE_CIP_KERNEL_CONTAINER_CONFIG =3D "1"

I get the idea, but the user / downstream could append your kconfig
file to the SRC_URI directly. No need for the variable. Files ending in
.cfg are "auto detected" as kernel configuration files.

>  KERNEL_DEFCONFIG ?=3D "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm=
64/cip_merged_defconfig"
> =20
>  # watchdog is not yet supported in our QEMU executor for this platform, =
disable it
> diff --git a/recipes-kernel/linux/files/container.cfg b/recipes-kernel/li=
nux/files/container.cfg
> new file mode 100644
> index 0000000..18f8b2b
> --- /dev/null
> +++ b/recipes-kernel/linux/files/container.cfg
> @@ -0,0 +1,114 @@
> +# Copyright (c) Siemens AG, 2025
> +#
> +# Authors:
> +#  Michael Adler <michael.adler@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +
> +# Kernel configuration required by container runtimes such as Docker.
> +# Based on the following scripts:
> +#
> +#   - https://github.com/moby/moby/blob/master/contrib/check-config.sh
> +#   - https://github.com/opencontainers/runc/blob/main/script/check-conf=
ig.sh
> +#
> +# NOTE: CONFIG_SECURITY_SELINUX and CONFIG_SECURITY_APPARMOR are intenti=
onally
> +# not enabled.
> +
> +CONFIG_NAMESPACES=3Dy
> +CONFIG_NET_NS=3Dy
> +CONFIG_PID_NS=3Dy
> +CONFIG_IPC_NS=3Dy
> +CONFIG_UTS_NS=3Dy
> +
> +CONFIG_CPUSETS=3Dy
> +CONFIG_CRYPTO=3Dy
> +CONFIG_CRYPTO_AEAD=3Dy
> +CONFIG_CRYPTO_GCM=3Dy
> +CONFIG_CRYPTO_GHASH=3Dy
> +CONFIG_CRYPTO_SEQIV=3Dy
> +CONFIG_KEYS=3Dy
> +CONFIG_MEMCG=3Dy
> +CONFIG_CHECKPOINT_RESTORE=3Dy
> +
> +CONFIG_OVERLAY_FS=3Dm
> +
> +CONFIG_CGROUPS=3Dy
> +CONFIG_CGROUP_CPUACCT=3Dy
> +CONFIG_CGROUP_DEVICE=3Dy
> +CONFIG_CGROUP_FREEZER=3Dy
> +CONFIG_CGROUP_NET_PRIO=3Dy
> +CONFIG_CGROUP_PERF=3Dy
> +CONFIG_CGROUP_PIDS=3Dy
> +CONFIG_CGROUP_SCHED=3Dy
> +CONFIG_FAIR_GROUP_SCHED=3Dy
> +CONFIG_CGROUP_BPF=3Dy
> +CONFIG_BPF_SYSCALL=3Dy
> +CONFIG_CFS_BANDWIDTH=3Dy
> +CONFIG_RT_GROUP_SCHED=3Dy
> +
> +CONFIG_HUGETLBFS=3Dy
> +CONFIG_CGROUP_HUGETLB=3Dy
> +
> +CONFIG_BLK_CGROUP=3Dy
> +CONFIG_BLK_CGROUP_IOCOST=3Dy
> +CONFIG_BLK_DEV_THROTTLING=3Dy
> +
> +CONFIG_NET=3Dy
> +CONFIG_NET_CLS_CGROUP=3Dy
> +CONFIG_NET_CLS_ACT=3Dy
> +CONFIG_NET_EMATCH=3Dy
> +CONFIG_NET_SCHED=3Dy
> +CONFIG_NETLABEL=3Dy
> +CONFIG_INET=3Dy
> +CONFIG_POSIX_MQUEUE=3Dy
> +
> +CONFIG_NETDEVICES=3Dy
> +CONFIG_NET_CORE=3Dy
> +CONFIG_VETH=3Dm
> +CONFIG_BRIDGE=3Dm
> +CONFIG_BRIDGE_NETFILTER=3Dm
> +CONFIG_BRIDGE_VLAN_FILTERING=3Dm
> +CONFIG_VXLAN=3Dm
> +CONFIG_IPVLAN=3Dm
> +CONFIG_MACVLAN=3Dm
> +
> +CONFIG_NETFILTER=3Dy
> +CONFIG_NETFILTER_ADVANCED=3Dy
> +CONFIG_NETFILTER_XT_MARK=3Dm
> +CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=3Dm
> +CONFIG_NETFILTER_XT_MATCH_BPF=3Dm
> +CONFIG_NETFILTER_XT_MATCH_COMMENT=3Dm
> +CONFIG_NETFILTER_XT_MATCH_CONNTRACK=3Dm
> +CONFIG_NETFILTER_XT_MATCH_IPVS=3Dm
> +CONFIG_IP_NF_FILTER=3Dm
> +CONFIG_IP_NF_IPTABLES=3Dm
> +CONFIG_IP_NF_MANGLE=3Dm
> +CONFIG_IP_NF_NAT=3Dm
> +CONFIG_IP_NF_TARGET_MASQUERADE=3Dm
> +CONFIG_IP_NF_TARGET_REDIRECT=3Dm
> +CONFIG_IP_VS=3Dm
> +CONFIG_IP_VS_NFCT=3Dy
> +CONFIG_IP_VS_PROTO_TCP=3Dy
> +CONFIG_IP_VS_PROTO_UDP=3Dy
> +CONFIG_IP_VS_RR=3Dm
> +
> +CONFIG_NF_TABLES=3Dm
> +CONFIG_NF_TABLES_INET=3Dy
> +CONFIG_NF_TABLES_NETDEV=3Dy
> +CONFIG_NF_CONNTRACK=3Dm
> +CONFIG_NF_CONNTRACK_FTP=3Dm
> +CONFIG_NF_CT_NETLINK=3Dm
> +CONFIG_NF_NAT=3Dm
> +CONFIG_NF_NAT_IPV4=3Dm
> +CONFIG_NF_NAT_MASQUERADE=3Dm
> +CONFIG_NF_NAT_NEEDED=3Dm
> +
> +CONFIG_NFT_COMPAT=3Dm
> +CONFIG_NFT_CT=3Dm
> +CONFIG_NFT_HASH=3Dm
> +CONFIG_NFT_LIMIT=3Dm
> +CONFIG_NFT_LOG=3Dm
> +CONFIG_NFT_MASQ=3Dm
> +CONFIG_NFT_NAT=3Dm
> +CONFIG_NFT_REDIR=3Dm
> +CONFIG_NFT_REJECT=3Dm

All CIP kernels are building fine with this config enabled? I'm missing
the testing part...

> diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/l=
inux/linux-cip-common.inc
> index 5d1b8ac..437ee17 100644
> --- a/recipes-kernel/linux/linux-cip-common.inc
> +++ b/recipes-kernel/linux/linux-cip-common.inc
> @@ -23,4 +23,9 @@ SRC_URI +=3D " \
>      https://cdn.kernel.org/pub/linux/kernel/projects/cip/${KERNEL_MAJOR_=
MINOR}/linux-cip-${PV}.tar.xz \
>      "
> =20
> +SRC_URI:append =3D " ${@ \
> +    'file://container.cfg' \
> +    if d.getVar('USE_CIP_KERNEL_CONTAINER_CONFIG') =3D=3D '1' else '' \
> +    }"
> +

As said, could be moved to the user.

>  S =3D "${WORKDIR}/linux-cip-${PV}"
> --=20
> 2.47.1


