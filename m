Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3413FC4332F
	for <webhook@archiver.kernel.org>; Thu, 15 Dec 2022 03:25:59 +0000 (UTC)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
 by mx.groups.io with SMTP id smtpd.web11.125383.1671074755998855689
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Dec 2022 19:25:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112 header.b=rzAs2G0a;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.54, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1433ef3b61fso19344591fac.10
        for <cip-dev@lists.cip-project.org>; Wed, 14 Dec 2022 19:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QaQvkGWZyWWXVPDIoWUQo5NMoAUbdB3b39d6dlj99vs=;
        b=rzAs2G0a8smJNfOetjQXu5IoH7IRNAWdHPbV/MeqRbZ5vsu+Qj9R2b/CKPR6e7CiEP
         PiuVUI7P8iDuiz3Da+c/CZ5voC89dJH7vMWHCx7aCw6nPIQS7tNAArL2FRJbZrGcw/29
         QMNNvJsn/65LjLfZ4rF9U3FmkuiySdLW4/0b/I+A2uVXOmw+v1A+9c27FBvDgKfQFKR9
         JX3XykIwsMSXcpKg599b07JyrTXal8b95sqREN5OTmTAINxJ9Bl3Ka2lUEcEUR0ZE+fB
         h7gGMnMOajXyqplRJ7j33j+v2jNpDP9tMs5bGhZGD3GZnteOwMWRA31tQDRwj41jH6cc
         C7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QaQvkGWZyWWXVPDIoWUQo5NMoAUbdB3b39d6dlj99vs=;
        b=GGr7+X2lEYlrqJCvNpbYCuJbU1QihIninhlGr6Y9mthHogYWMilUIcWNmAlhrKNUiN
         RHquvOjzM2R+vnFRYsMefp+wzVRTPYtnTp6/4kGaWAgm2jeTDWcH3ChpBsk+8r3Jk0jR
         L5prUkmfjcowWkOab1jFHyvK3A+asHF774z7TuQuGjWKt9krzFNp5DSC5WvJ8YrguEnz
         hHccQ95X9XT/8j4AgWuYiDZ3O2hf5x0xlA2xh5PjY82okG687ba0cI0Nud7PHGvo7qFY
         RGxGKLy9A2lsxkfHm0ULFPZAUjFfHbghEwrb4zuqBce9YcPKE9c/0wm0owrGP8/moHTs
         stQw==
X-Gm-Message-State: AFqh2ko+o1Tt0OP8+7XKLovylb3OnCLhrDuiz9WDPpKiK8Gpa98+oi6s
	miRLH5rF+vzU1gcx2U6P2nrwV1oGB8xP0yeb23fKPl6MQOSZrlcJ
X-Google-Smtp-Source: AMrXdXuj/P/s85h796LZd9KJgqphbkIsFQO19SCSrqNKwk6tq0Ffcuooc2KH3hHs1j32erQw4CZRtrV/XaJG+IjG+bs=
X-Received: by 2002:a05:6870:2f17:b0:148:43a2:188 with SMTP id
 qj23-20020a0568702f1700b0014843a20188mr44737oab.58.1671074754364; Wed, 14 Dec
 2022 19:25:54 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 15 Dec 2022 12:25:18 +0900
Message-ID: <CAODzB9oy2nCYdfa7vzG59nQ6owAKUv+jkqD4tpufn+k8_kjuaw@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Dec 2022 03:25:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10230

Hi !

It's this week's CVE report.

This week reported 17 new CVEs and 11 updated CVEs.

* New CVEs

CVE-2022-4378: Linux kernel stack-based buffer overflow in __do_proc_dointv=
ec

CVSS v3 score is not provided

A stack overflow bug was found in __do_proc_dointvec() which missed
checking on user input.
This bug affected all stable kernels. It seems as if 4.4 is affected too.

Fixed status
mainline: [bce9332220bd677d83b19d21502776ad555a0e73,
e6cfaf34be9fcd1a8285a294e18986bfc41a409c]
stable/4.14: [dad6ca557f640b032ed5de9c0136e5628fba1253,
4f4ff21bbcaeda6c061a25c8c2dfac3f27a1fb34]
stable/4.19: [a9c309fb49ffe3203f948973fd27b8f64f7f30c4,
fe84d7f0cb66d150de094fba461f0cb5d5b12c85]
stable/4.9: [6e3644aca0bcb572e461ace04d7045beeebb4aaa,
32646215df00b5dbc79bbeb4df69189fc2a0b234]
stable/5.10: [9ba389863ac63032d4b6ffad2c90a62cd78082ee,
4aa32aaef6c1b5e39ae2508ec596bd7b67871043]
stable/5.15: [48642f94311b0cf9667aa6833f9f5e3a87d2a0ce,
3eb9213f66127fbccd56dd4d36c4b47f3302dbf7]
stable/5.4: [0390da0565ade35f9c2bedcb57ab64c61b40045b,
dd3124a051a1c0397e82bc240f4db9987ef52b3d]
stable/6.0: [fdf2c95f28bf197bfab421d21e8c697d4f149ea1,
e04220518841708f68e7746232e3e54daef464a3]

CVE-2022-25836: Bluetooth SIG Statement Regarding the "Pairing Mode
Confusion in BLE Passkey Entry" Vulnerability

CVSS v3 score is 7.5 HIGH

Bluetooth=C2=AE Low Energy Pairing in Bluetooth Core Specification v4.0
through v5.3 may permit an unauthenticated man-in-the-middle (MITM) to
acquire credentials with two pairing devices via adjacent access when
the MITM negotiates Legacy Passkey Pairing with the pairing Initiator
and Secure Connections Passkey Pairing with the pairing Responder and
brute forces the Passkey entered by the user into the Initiator. The
MITM attacker can use the identified Passkey value to complete
authentication with the Responder via Bluetooth pairing method
confusion.

Fixed status
The Bluetooth SIG recommends that implementations enforce Secure
Connections Only Mode.

CVE-2022-25837: Bluetooth SIG Statement Regarding the =E2=80=9CPairing Mode
Confusion in BR/EDR=E2=80=9D Vulnerability

CVSS v3 score is 7.5 HIGH

Bluetooth=C2=AE Pairing in Bluetooth Core Specification v1.0B through v5.3
may permit an unauthenticated man-in-the-middle (MITM) to acquire
credentials with two pairing devices via adjacent access when at least
one device supports BR/EDR Secure Connections pairing and the other
BR/EDR Legacy PIN code pairing if the MITM negotiates BR/EDR Secure
Simple Pairing in Secure Connections mode using the Passkey
association model with the pairing Initiator and BR/EDR Legacy PIN
code pairing with the pairing Responder and brute forces the Passkey
entered by the user into the Responder as a 6-digit PIN code. The MITM
attacker can use the identified PIN code value as the Passkey value to
complete authentication with the Initiator via Bluetooth pairing
method confusion.

Fixed status
The Bluetooth SIG recommends that implementations enforce Secure
Connections Only Mode.

CVE-2022-26047:

CVSS v3 score is 6.5 MEDIUM

Improper input validation for some Intel(R) PROSet/Wireless WiFi,
Intel vPro(R) CSME WiFi and Killer(TM) WiFi products may allow
unauthenticated user to potentially enable denial of service via local
access.

Following products are affected.
- Intel=C2=AE Wi-Fi 6E AX411
- Intel=C2=AE Wi-Fi 6E AX211
- Intel=C2=AE Wi-Fi 6E AX210
- Intel=C2=AE Wi-Fi 6 AX201
- Intel=C2=AE Wi-Fi 6 AX200

Fixed status
Intel advisory said that "Intel=C2=AE PROSet/Wireless WiFi drivers to
mitigate this vulnerability will be up streamed by November 08, 2022.
Consult the regular open-source channels to obtain this update."

CVE-2022-3104: Kernel: kmalloc's return value not checked, leading to
null pointer dereference

CVSS v3 score is not provided

This bug was introduced by commit ae2e1aa ("drivers/misc/lkdtm/bugs.c:
add arithmetic overflow and array bounds checks") in 5.7-rc1.
This commit isn't backported to 5.4 and 4.19. The
drivers/misc/lkdtm/bugs.c is not present in 4.4, 4.9, and 4.14.
c
Fixed status
mainline: [4a9800c81d2f34afb66b4b42e0330ae8298019a2]
stable/5.10: [56ac04f35fc5dc8b5b67a1fa2f7204282aa887d5]
stable/5.15: [1aeeca2b8397e3805c16a4ff26bf3cc8485f9853]

CVE-2022-3105: uapi_finalize's return value not checked leading to
null pointer dereference

CVSS v3 score is not provided

An issue was discovered in the Linux kernel through 5.16-rc6.
uapi_finalize in drivers/infiniband/core/uverbs_uapi.c lacks check of
kmalloc_array().
This bug was introduced by commit 6884c6c ("RDMA/verbs: Store the
write/write_ex uapi entry points in the uverbs_api") in 5.0-rc1.
This patch is not backported to 4.19.
The drivers/infiniband/core/uverbs_uapi.c is not present in 4.14, 4.9, and =
4.4.

Fixed status
mainline: [7694a7de22c53a312ea98960fcafc6ec62046531]
stable/5.10: [16e5cad6eca1e506c38c39dc256298643fa1852a]
stable/5.15: [0ea8bb0811ba0ec22903cbb48ff2cd872382e8d4]
stable/5.4: [7646a340b25bb68cfb6d2e087a608802346d0f7b]

CVE-2022-3106: kmalloc's return value not checked, leading to null
pointer dereference

CVSS v3 score is not provided

An issue was discovered in the Linux kernel through 5.16-rc6.
ef100_update_stats in drivers/net/ethernet/sfc/ef100_nic.c lacks check
of the return value of kmalloc().

This bug was introduced by commit b593b6f ("sfc_ef100: statistics
gathering") in 5.9-rc1. This driver was introduced since 5.9 so less
than 5.9 kernels aren't affected by this issue.

Fixed status
mainline: [407ecd1bd726f240123f704620d46e285ff30dd9]
stable/5.10: [734a3f3106053ee41cecae2a995b3d4d0c246764]
stable/5.15: [9a77c02d1d2147a76bd187af1bf5a34242662d12]

CVE-2022-3107: Kernel: Unchecked kvmalloc_array return leads to null
pointer dereference.

CVSS v3 score is not provided

An issue was discovered in the Linux kernel through 5.16-rc6.
netvsc_get_ethtool_stats in drivers/net/hyperv/netvsc_drv.c lacks
check of the return value of kvmalloc_array() and will cause the null
pointer dereference.

This bug was introduced by commit 6ae7467 ("hv_netvsc: Add per-cpu
ethtool stats for netvsc") in 4.19-rc1. This commit is not backported
to 4.4, 4.14, and 4.9.

Fixed status
mainline: [886e44c9298a6b428ae046e2fa092ca52e822e6a]
stable/4.19: [a30c7c81db60f7f7ad52f75a4f7de5f628063df4]
stable/5.10: [9b763ceda6f8963cc99df5772540c54ba46ba37c]
stable/5.15: [ab0ab176183191cffc69fe9dd8ac6c8db23f60d3]
stable/5.4: [b01e2df5fbf68719dfb8e766c1ca6089234144c2]

CVE-2022-3108: Kernel: kmemdup''s return value not checked

CVSS v3 score is not provided

An issue was discovered in the Linux kernel through 5.16-rc6.
kfd_parse_subtype_iolink in drivers/gpu/drm/amd/amdkfd/kfd_crat.c
lacks check of the return value of kmemdup().

This bug was introduced by commit 3a87177 ("drm/amdkfd: Add topology
support for dGPUs") in 4.16-rc1. The
drivers/gpu/drm/amd/amdkfd/kfd_crat.c is not present in 4.4, 4.9, and
4.14.

Fixed status
mainline: [abfaf0eee97925905e742aa3b0b72e04a918fa9e]
stable/5.15: [5609b7803947eea1711516dd8659c7ed39f5a868]

CVE-2022-3110: Unchecked rtw_alloc_hwxmits return leads to null
pointer dereference.

CVSS v3 score is not provided

An issue was discovered in the Linux kernel through 5.16-rc6.
_rtw_init_xmit_priv in drivers/staging/r8188eu/core/rtw_xmit.c lacks
check of the return value of rtw_alloc_hwxmits() and will cause the
null pointer dereference.

This bug was introduced by commit 1586512 ("staging: r8188eu:
introduce new core dir for RTL8188eu driver") in 5.15-rc1. This driver
was introduced in 5.15-rc1 so less than 5.15 kernels aren't affected
by this issue.

Fixed status
mainline: [f94b47c6bde624d6c07f43054087607c52054a95]
stable/5.15: [029983ea88e59f4c7dc0d56ade2b16d6b869bf94]

CVE-2022-3111: Unchecked WM8350_IRQ_CHG_FAST_RDY free leads to null
pointer dereference

CVSS v3 score is not provided

An issue was discovered in the Linux kernel through 5.16-rc6.
free_charger_irq() in drivers/power/supply/wm8350_power.c lacks free
of WM8350_IRQ_CHG_FAST_RDY, which is registered in
wm8350_init_charger().

This bug was introduced by commit 14431aa ("power_supply: Add support
for WM8350 PMU") in 2.6.29-rc1.

Fixed status
mainline: [6dee930f6f6776d1e5a7edf542c6863b47d9f078]
stable/4.14: [ae64b838bececea902b819a69731cb80cca8f31a]
stable/4.19: [60dd1082322966f192f42fe2a6605dfa08eef41f]
stable/4.9: [a6a3ec1626846fba62609330673a2dd5007d6a53]
stable/5.10: [48d23ef90116c8c702bfa4cad93744e4e5588d7d]
stable/5.15: [4124966fbd95eeecca26d52433f393e2b9649a33]
stable/5.4: [90bec38f6a4c81814775c7f3dfc9acf281d5dcfa]

CVE-2022-3112: Kernel: kzalloc's return value not checked leading to
null pointer dereference

CVSS v3 score is not provided

An issue was discovered in the Linux kernel through 5.16-rc6.
amvdec_set_canvases in drivers/staging/media/meson/vdec/vdec_helpers.c
lacks check of the return value of kzalloc() and will cause the null
pointer dereference.

This bug was introduced by commit 876f123 ("media: meson: vdec: bring
up to compliance") in 5.7-rc1. This patch is not backported to 5.4.
drivers/staging/media/meson is not present in 4.4, 4.14, and 4.19.

Fixed status
mainline: [c8c80c996182239ff9b05eda4db50184cf3b2e99]
stable/5.10: [032b141a91a82a5f0107ce664a35b201e60c5ce1]
stable/5.15: [b0b890dd8df3b9a2fe726826980b1cffe17b9679]

CVE-2022-3113: Kernel: devm_kzalloc return value not checked, null
pointer dereference

CVSS v3 score is not provided

An issue was discovered in the Linux kernel through 5.16-rc6.
mtk_vcodec_fw_vpu_init in
drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c lacks check of
the return value of devm_kzalloc() and will cause the null pointer
dereference.

This bug was introduced by commit 46233e9 ("media: mtk-vcodec: move
firmware implementations into their own files") in 5.10-rc6. This
commit fixes  bf1d556 ("media: mtk-vcodec: abstract firmware
interface") in 5.10-rc1.
The mtk_vcodec_fw_vpu_init() is not found in 4.4, 4.14, 4.19, and 5.4.

Fixed status
mainline: [e25a89f743b18c029bfbe5e1663ae0c7190912b0]
stable/5.10: [bc2573abc691a269b54a6c14a2660f26d88876a5]
stable/5.15: [0022dc8cafa5fcd156da8ae7bfc9ca99497bdffc]

CVE-2022-3114: Kernel: Unchecked kcalloc return leads to null pointer
dereference.

CVSS v3 score is not provided

An issue was discovered in the Linux kernel through 5.16-rc6.
imx_register_uart_clocks in drivers/clk/imx/clk.c lacks check of the
return value of kcalloc() and will cause the null pointer dereference.

This bug was introduced by commit 379c9a2 ("clk: imx: Fix reparenting
of UARTs not associated with stdout") in 5.13-rc1. This commit fixes
9461f7b ("clk: fix CLK_SET_RATE_GATE with clock rate protection") in
4.19-rc1.
Commit 379c9a2 is not backported to 4.19, 4.14, 4.9, and 4.4.

Fixed status
mainline: [ed713e2bc093239ccd380c2ce8ae9e4162f5c037]
stable/5.10: [9e33e261b4d62a33616a16b6fda57123b1ee9c4d]

CVE-2022-3115: Kernel: Unchecked kzalloc return leads to null pointer
dereference.

CVSS v3 score is not provided

An issue was discovered in the Linux kernel through 5.16-rc6.
malidp_crtc_reset in drivers/gpu/drm/arm/malidp_crtc.c lacks check of
the return value of kzalloc() and will cause the null pointer
dereference.

This bug was introduced by commit 99665d0 ("drm: mali-dp: add
malidp_crtc_state struct") in 4.12-rc1. This commit is not backported
to 4.9. This driver is not present in 4.4.

Fixed status
mainline: [73c3ed7495c67b8fbdc31cf58e6ca8757df31a33]
stable/5.10: [b4c7dd0037e6aeecad9b947b30f0d9eaeda11762]
stable/5.15: [4cb37f715f601cee5b026c6f9091a466266b5ba5]
stable/5.4: [fa0d7ba25a53ac2e4bb24ef31aec49ff3578b44f]

CVE-2022-4379: NFSD: fix use-after-free in __nfs42_ssc_open()

CVSS v3 score is not provided

A use-after-free vulnerability in  __nfs42_ssc_open() in NFS subsystem
of Linux through v6.1 which allows an attacker to trigger remote
denial of service.

Patch removes calling nfsd4_interssc_disconnect() in nfs42_ssc_open()
and nfsd4_copy(). It also removes nfsd4_interssc_disconnect(). the
nfsd4_interssc_disconnect() was add by commit ce0887ac ("NFSD add nfs4
inter ssc to nfsd4_copy") in 5.6-rc1. So, it looks less than 5.6
kernels aren't affected by this issue.

Fixed status
Patch is available but it hasn't been merged yet.

CVE-2022-4382: usb: A use-after-free Write in put_dev

CVSS v3 score is not provided

This use-after-free violation is caused by a race among the superblock
operations in the gadgetfs driver. The vulnerability may not be a big
deal, because the normal user can't execute umount.
It could be triggered by yanking out a device that is running the gadgetfs =
side.

It looks like all stable kernels, including 4.4, are affected.

Fixed status
Patch is available but it hasn't been merged yet.

* Updated CVEs

CVE-2022-3169: Request to NVME_IOCTL_RESET and NVME_IOCTL_SUBSYS_RESET
may cause a DOS

5.4 was fixed.

Fixed status
mainline: [1e866afd4bcdd01a70a5eddb4371158d3035ce03]
stable/5.10: [023435a095d22bcbbaeea7e3a8c534b5c57d0d82]
stable/5.15: [b1a27b2aad936746e6ef64c8a24bcb6dce6f926a]
stable/5.4: [99c59256ea00ff7fab4914bb38e10a84850de514]
stable/6.0: [0c2b1c56252bf19d3412137073c2c07e86f40ba1]

CVE-2022-3435: ipv4: Handle attempt to delete multipath route when
fib_info contains an nh reference

5.10, 5.15, 5.4, and 6.0 were fixed.

Fixed status
mainline: [61b91eb33a69c3be11b259c5ea484505cd79f883]
stable/5.10: [0b5394229ebae09afc07aabccb5ffd705ffd250e]
stable/5.15: [25174d91e4a32a24204060d283bd5fa6d0ddf133]
stable/5.4: [cc3cd130ecfb8b0ae52e235e487bae3f16a24a32]
stable/6.0: [bb20a2ae241be846bc3c11ea4b3a3c69e41d51f2]

CVE-2022-3524: tcp/udp: Fix memory leak in ipv6_renew_options().

4.14, 4.19, and 4.9 were fixed.

Fixed status
mainline: [3c52c6bb831f6335c176a0fc7214e26f43adbd11]
stable/4.14: [205c1e9ac56a5cd1a7d0bc457d8b38871f5b37ed]
table/4.19: [bbfbdca680b0cbea0e57be597b5e2cae19747052]
stable/4.9: [d2c9e2ebafa14a564b28e237db8d90ab7bdbd061]
stable/5.10: [818c36b988b82f31e4be8ad8415e1be902b8e5f8]
stable/5.15: [1401e9336bebaa6dd5a320f83bddc17619d4e3a6]
stable/5.4: [92aaa5e8fe90a008828a1207e66a30444bcb1cbd]
stable/6.0: [0c5d628f1e1d049c33595693fab1b6e9baf25795]

CVE-2022-4139: drm/i915: fix TLB invalidation for Gen12 video and
compute engines

5.4 was fixed.

Fixed status
mainline: [04aa64375f48a5d430b5550d9271f8428883e550]
stable/5.10: [86f0082fb9470904b15546726417f28077088fee]
stable/5.15: [ee2d04f23bbb16208045c3de545c6127aaa1ed0e]
stable/5.4: [3659e33c1e4f8cfc62c6c15aca5d797010c277a4]
stable/6.0: [aef39675ad33317c8badc0165ea882e172a633e6]

CVE-2022-42896: Bluetooth: L2CAP: Fix accepting connection request for
invalid SPSM

4.14, 4.19, 4.9, and 5.4 wer fixed.

Fixed status
mainline: [711f8c3fb3db61897080468586b970c87c61d9e4]
stable/4.14: [9f4624c42db9dd854870ccb212ddd405d8c59041]
stable/4.19: [a2045d57e844864605d39e6cfd2237861d800f13]
stable/4.9: [c834df40af8ec156e8c3c388a08ff7381cd90d80]
stable/5.10: [6b6f94fb9a74dd2891f11de4e638c6202bc89476]
stable/5.15: [81035e1201e26d57d9733ac59140a3e29befbc5a]
stable/5.4: [0d87bb6070361e5d1d9cb391ba7ee73413bc109b]
stable/6.0: [d7efeb93213becae13c6a12e4150ce1e07bd2c49]

CVE-2022-45869: KVM: x86/mmu: Fix race condition in direct_page_fault

5.15 was fixed.

Fixed status
mainline: [47b0c2e4c220f2251fd8dcfbb44479819c715e15]
stable/5.15: [f88a6977f8b981bfb5fddd18fbaa75e57e8af293]
stable/6.0: [34ced1da74eb975abdf7ef823512c7719f67601b]

CVE-2022-45934: Bluetooth: L2CAP: Fix u8 overflow

The mainline was fixed.

Fixed status
mainline: [bcd70260ef56e0aee8a4fc6cd214a419900b0765]

CVE-2022-3623: mm/hugetlb: fix races when looking up a CONT-PTE/PMD
size hugetlb page

5.10 was fixed.

Fixed status
mainline: [fac35ba763ed07ba93154c95ffc0c4a55023707f]
stable/5.10: [fccee93eb20d72f5390432ecea7f8c16af88c850]
stable/5.15: [3a44ae4afaa5318baed3c6e2959f24454e0ae4ff]
stable/5.19: [86a913d55c89dd13ba070a87f61a493563e94b54]
stable/6.0: [7c7c79dd5a388758f8dfa3de89b131d5d84f25fd]

CVE-2022-3643: xen/netback: Ensure protocol headers don''t fall in the
non-linear area

stable kernel were fixed.

Fixed status
mainline: [ad7f402ae4f466647c3a669b8a6f3e5d4271c84a]
stable/4.14: [e173cefc814dec81e9836ecc866cdba154e693cd]
stable/4.19: [44dfdecc288b8d5932e09f5e6a597a089d5a82b2]
stable/4.9: [1a1d9be7b36ee6cbdeb9d160038834d707256e88]
stable/5.10: [49e07c0768dbebff672ee1834eff9680fc6277bf]
stable/5.15: [0fe29bd92594a747a2561589bd452c259451929e]
stable/5.4: [8fe1bf6f32cd5b96ddcd2a38110603fe34753e52]
stable/6.0: [e8851d841fe4f29b613a00de45f39c80dbfdb975]

CVE-2022-42328: xen/netback: don''t call kfree_skb() with interrupts disabl=
ed

stable kernels were fixed.

Fixed status
mainline: [74e7e1efdad45580cc3839f2a155174cf158f9b5]
stable/4.14: [2b81c566ab5724976de59ad7787e204f7938ae27]
stable/4.19: [d3e1b6151d5d40bedabea129f5873a83b9390b62]
stable/4.9: [b41eab5790ac8ceed2b940f7acc5b3698c824644]
stable/5.10: [83632fc41449c480f2d0193683ec202caaa186c9]
stable/5.15: [5d0fa6fc8899fe842329c0109f8ddd01144b1ed8]
stable/5.4: [50e1ab7e638f1009d953658af8f6b2d7813a7883]
stable/6.0: [3fb02db125bbcf8163e9e30d2824b4adf13f06cb]

CVE-2022-42329: xen/netback: don''t call kfree_skb() with interrupts disabl=
ed

stable kernels were fixed.

Fixed status
mainline: [74e7e1efdad45580cc3839f2a155174cf158f9b5]
stable/4.14: [2b81c566ab5724976de59ad7787e204f7938ae27]
stable/4.19: [d3e1b6151d5d40bedabea129f5873a83b9390b62]
stable/4.9: [b41eab5790ac8ceed2b940f7acc5b3698c824644]
stable/5.10: [83632fc41449c480f2d0193683ec202caaa186c9]
stable/5.15: [5d0fa6fc8899fe842329c0109f8ddd01144b1ed8]
stable/5.4: [50e1ab7e638f1009d953658af8f6b2d7813a7883]
stable/6.0: [3fb02db125bbcf8163e9e30d2824b4adf13f06cb]

Currently tracking CVEs

CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
Bluetooth Core Specifications 4.0 through 5.2

There is no fix information.

CVE-2020-26556: kernel: malleable commitment Bluetooth Mesh Provisioning

No fix information.

CVE-2020-26557: kernel: predictable Authvalue in Bluetooth Mesh
Provisioning Leads to MITM

No fix information.

CVE-2020-26559: kernel: Authvalue leak in Bluetooth Mesh Provisioning

No fix information.

CVE-2020-26560: kernel: impersonation attack in Bluetooth Mesh Provisioning

No fix information.

Regards,
--
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

