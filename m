Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C95AC678D4
	for <webhook@archiver.kernel.org>; Thu,  2 Mar 2023 01:40:56 +0000 (UTC)
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
 by mx.groups.io with SMTP id smtpd.web11.4771.1677721252257893466
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Mar 2023 17:40:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112 header.b=RCtb2ZBX;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.44, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-17213c961dfso16663861fac.0
        for <cip-dev@lists.cip-project.org>; Wed, 01 Mar 2023 17:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112; t=1677721251;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HUP0xSFjzX05Ff6lxquNmBF0QUgDBX4T78aNrVCut4M=;
        b=RCtb2ZBX9Siav6xRxUTYgly7I274rPFLmdpsiY44EiQA+NGIPDyshtsGyG2eQ+nxNu
         b60W5js4IUGj0xNZ7uz0DkFFVn1KUE7ubRIqFwA2LLRpKVuOfg2XxKwalvAWeC4yGD1j
         elo4D8y/qoFfYD8XnnFOfg6Nh1ZMvBdEFaVAk3Yd9KCcnW0mVu1TjwJNXw4fbHkKL/EF
         lktp9CT+jEIc51fJUs9Xn/QE360Rjhegd5Jtn1FpyQ0BTuxeZch3fxjwkLvXLFc16ITl
         CGFwxc/p/i9uC1mrWj1OVEOteyNNoXvvaPiHAn+lBTUj9Vl8+nVkqqR+Nk+5T0ePVSVp
         CVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677721251;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HUP0xSFjzX05Ff6lxquNmBF0QUgDBX4T78aNrVCut4M=;
        b=eCRlgW1U/S+6nQQfBZTKU9ZYIx5csEpCB416rOFDJb6PjIh372Hh4aRW8qjfSV9ig/
         +JJJYOUlNtV0/BXOCBd2Co1hkMFf9GRGl53Ktij3i1IHUBu2EZlQJh1HhYhv9WrSCPLG
         lLro7O4lWszzuAuf1AzeEFLLQaE/+ET2qgZXwAHb5BgbWeKDIN+aHZYq8ohMIByqZ5PX
         REXXABWTIj79rbMdz8BEbp2zYQjlgt71UoZZncFL9Mz+m6UfB/M4s2hE3F+kI7Qe34Xr
         ZQNzlyq5TIO7VH0oD27A9szRX0ND1l3PHgdBJo3Wcm9VOqofVoRku7Q+g/qEyZgDKyDi
         sikw==
X-Gm-Message-State: AO0yUKUW4oW30PAexnVxXWbDQwAEi5+1EvV4H5uF3WsmzBwgfXf5hJCq
	25eJnHSB/vxv38lgje5EifSLTHeuG2FqMCy9ohKEbBule8IkhnF3
X-Google-Smtp-Source: AK7set/8j7wPPq+XKEQCXkBg+A1gGgO0jmjEd1HFYizLeBIdkKdhjPs/TyNoF44xiMArsDMCQL1XCEXQjfGeXYmJhCc=
X-Received: by 2002:a05:6870:5b34:b0:176:245d:a298 with SMTP id
 ds52-20020a0568705b3400b00176245da298mr1119289oab.7.1677721250782; Wed, 01
 Mar 2023 17:40:50 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 2 Mar 2023 10:40:14 +0900
Message-ID: <CAODzB9rdF0mU9RXJbEzyWh9T3WOXz3PMeVYw5Z_LrCV-SqNMtA@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Mar 2023 01:40:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10871

Hi !

It's this week's CVE report.

This week reported 22 new CVEs and 4 updated CVEs.

* New CVEs

CVE-2023-23039: drivers: tty: vcc: Fix use-after-free in vcc_open()

CVSS v3 score is not provided.

An issue was discovered in the Linux kernel through 6.2.0-rc2.
drivers/tty/vcc.c has a race condition and resultant use-after-free if
a physically proximate attacker removes a VCC device while calling
open(), aka a race condition between vcc_open() and vcc_remove().

Fixed status
Patch is available but it hasn't been merged yet.

CVE-2023-26544: KASAN: use-after-free Read in run_unpack

CVSS v3 score is not provided.

In the Linux kernel 6.0.8, there is a use-after-free in run_unpack in
fs/ntfs3/run.c, related to a difference between NTFS sector size and
media sector size.

NTFS3 driver was introduced in 5.15 so before version 5.15 kernels are
not affected by this issue.

Fixed status
Not fixed yet.

CVE-2023-26545: net: mpls: fix stale pointer if allocation fails
during device rename

CVSS v3 score is not provided.

In the Linux kernel before 6.1.13, there is a double free in
net/mpls/af_mpls.c upon an allocation failure (for registering the
sysctl table under a new location) during the renaming of a device.

It was introduced by commit 0fae3bf ("mpls: handle device renames for
per-device sysctls") in 4.1-rc8.

Fixed status
mainline: [fda6c89fe3d9aca073495a664e1d5aea28cd4377]
stable/4.14: [b89824a9b2398d78a32ea75343e5472a0fd4986e]
stable/4.19: [aa07c86e43ed8780d610ecfb2ce13da326729201]
stable/5.10: [7ff0fdba82298d1f456c685e24930da89703c0fb]
stable/5.15: [59a74da8da75bdfb464cbdb399e87ba4f7500e96]
stable/5.4: [df099e65564aa47478eb1cacf81ba69024fb5c69]
stable/6.1: [c376227845eef8f2e62e2c29c3cf2140d35dd8e8]

CVE-2023-26605: KASAN: use-after-free Read in inode_cgwb_move_to_attached

CVSS v3 score is not provided.

In the Linux kernel 6.0.8, there is a use-after-free in
inode_cgwb_move_to_attached in fs/fs-writeback.c, related to
__list_del_entry_valid.

Fixed status
Not fixed yet.

CVE-2023-26606: KASAN: use-after-free Read in ntfs_trim_fs

CVSS v3 score is not provided.

In the Linux kernel 6.0.8, there is a use-after-free in ntfs_trim_fs
in fs/ntfs3/bitmap.c.

NTFS3 driver was introduced in 5.15 so before version 5.15 kernels are
not affected by this issue.

Fixed status
Not fixed yet.

CVE-2023-26607: KASAN: slab-out-of-bounds Read in ntfs_attr_find

CVSS v3 score is not provided.

In the Linux kernel 6.0.8, there is an out-of-bounds read in
ntfs_attr_find in fs/ntfs/attrib.c.

Fixed status
Not fixed yet.

CVE-2023-1073: HID: check empty report_list in hid_validate_values()

CVSS v3 score is not provided.

There was an insufficient check to see if the list is empty or not in
hid_validate_values() which results in a list_head object as valid
data.
Drivers relied on the assumption that the device must have a valid
report_list. However, malicious devices can violate the assumption. In
this case,  the kernel is vulnerable.
According to the report
(https://www.openwall.com/lists/oss-security/2023/01/17/3) this
vulnerability is not exploitable.

This bug was introduced by commit 1b15d2e ("HID: core: fix validation
of report id 0") in 3.16-rc1.

Fixed status
mainline: [b12fece4c64857e5fab4290bf01b2e0317a88456]
stable/4.14: [614dd3d1725d329bf10a7ae974ebdfe101150791]
stable/4.19: [f958da03d9a71808548b2e5418d95482b106eb9a]
stable/5.10: [5dc3469a1170dd1344d262a332b26994214eeb58]
stable/5.15: [2b49568254365c9c247beb0eabbaa15d0e279d64]
stable/5.4: [89e7fe3999e057c91f157b6ba663264f4cdfcb55]
stable/6.1: [cdcdc0531a51659527fea4b4d064af343452062d]

CVE-2023-1074: sctp: fail if no bound addresses can be used for a given scope

CVSS v3 score is not provided.

A type confusion bug was found in inet_diag_msg_sctpasoc_fill() that
causes information leak to userspace.
This bug was introduced in the Linux 2.6 era.

Fixed status
mainline: [458e279f861d3f61796894cd158b780765a1569f]
stable/4.14: [97ca098d8f1a8119b6675c823706cd6231ba6d9b]
stable/4.19: [26436553aabfd9b40e1daa537a099bf5bb13fb55]
stable/5.10: [6ef652f35dcfaa1ab2b2cf6c1694718595148eee]
stable/5.15: [3391bd42351be0beb14f438c7556912b9f96cb32]
stable/5.4: [a7585028ac0a5836f39139c11594d79ede97d975]
stable/6.1: [9f08bb650078dca24a13fea1c375358ed6292df3]

CVE-2023-1075: net/tls: tls_is_tx_ready() checked list_entry

CVSS v3 score is not provided.

A type confusion bug was found in tls_is_tx_ready().
This bug was introduced by commit a42055e ("net/tls: Add support for
async encryption of records for performance") in 4.20-rc1 so that
before version 4.20 are not affected.

Fixed status
mainline: [ffe2a22562444720b05bdfeb999c03e810d84cbb]
stable/6.1: [37c0cdf7e4919e5f76381ac60817b67bcbdacb50]

CVE-2023-1076: tap: tap_open(): correctly initialize socket uid

CVSS v3 score is not provided.

A type confusion bug was found in tun and tap drivers.
This bug was introduced by commit 86741ec ("net: core: Add a UID field
to struct sock.") in 4.10-rc1 so Linux 4.4 is not affected.

Fixed status
mainline: [66b2c338adce580dfce2199591e65e2bab889cff,
a096ccca6e503a5c575717ff8a36ace27510ab0a]

CVE-2023-1077: sched/rt: pick_next_rt_entity(): check list_entry

CVSS v3 score is not provided.

An insufficient list empty checking in pick_next_rt_entity(). The
_pick_next_task_rt() checks pick_next_rt_entity() returns NULL or not
but pick_next_rt_entity() never returns NULL. So, even if the list is
empty, _pick_next_task_rt() continues its process.

This bug was introduced by commit 326587b ("sched: fix goto retry in
pick_next_task_rt()") in 2.6.25-rc1.

Fixed status
mainline: [7c4a5b89a0b5a57a64b601775b296abf77a9fe97]

CVE-2023-22995: usb: dwc3: dwc3-qcom: Add missing
platform_device_put() in dwc3_qcom_acpi_register_core

CVSS v3 score is not provided.

In the Linux kernel before 5.17, an error path in
dwc3_qcom_acpi_register_core in drivers/usb/dwc3/dwc3-qcom.c lacks
certain platform_device_put and kfree calls.
This bug was fixed in 5.17-rc1. It looks like this bugs was introduced
by commit 2bc02355 ("usb: dwc3: qcom: Add support for booting with
ACPI") in 5.3-rc1. So, 4.14, 4.19, and 4.4 are not affected.

Fixed status
mainline: [fa0ef93868a6062babe1144df2807a8b1d4924d2]

CVE-2023-1078: rds: rds_rm_zerocopy_callback() use list_first_entry()

CVSS v3 score is not provided.

A type confusing bug was found in rds_rm_zerocopy_callback(). It
causes type of memory corruption bugs.

It was introduced by commit 9426bbc ("rds: use list structure to track
information for zerocopy completion notification") in 4.17-rc1.
So, 4.4 and 4.14 are not affected.

Fixed status
mainline: [f753a68980cf4b59a80fe677619da2b1804f526d]
stable/4.19: [909d5eef5ce792bb76d7b5a9b7a6852b813d8cac]
stable/5.10: [c53f34ec3fbf3e9f67574118a6bb35ae1146f7ca]
stable/5.15: [528e3f3a4b53df36dafd10cdf6b8c0fe2aa1c4ba]
stable/5.4: [ba38eacade35dd2316d77b37494e6e0c01bab595]
stable/6.1: [1d52bbfd469af69fbcae88c67f160ce1b968e7f3]

CVE-2023-1079: Use-After-Free in asus_kbd_backlight_set()

CVSS v3 score is not provided.

A use-after-free bug was found in asus_kbd_backlight_set(). When an
attacker plugging a malicious USB device, which advertises itself as
an asus device.
The device uses a worker `asus_worker` scheduled by
asus_kbd_backlight_set() to communicate with the hardware.
When concurrently with device removal, the LED controller
asus_kbd_backlight_set() may schedule a worker whose use would result
in a use-after-free.

Introduced by commit af22a61 ("HID: asus: support backlight on USB
keyboards") in 4.12-rc1. So, 4.4 is not affected.

Fixed status
mainline: [4ab3a086d10eeec1424f2e8a968827a6336203df]

CVE-2023-1095: A NULL pointer dereference bug in netfilter subsystem

CVSS v3 score is not provided.

In nf_tables_updtable, if nf_tables_table_enable returns an error,
nft_trans_destroy is called to free the transaction object.
nft_trans_destroy() calls list_del(), but the transaction was never
placed on a list -- the list head is all zeroes, this results in a
NULL pointer dereference.

Introduced by commit 55dd6f9 ("netfilter: nf_tables: use new
transaction infrastructure to handle table") in 3.16-rc1.

Fixed status
mainline: [580077855a40741cf511766129702d97ff02f4d9]
stable/4.14: [49d57fb1fd44b9d3422f096d3b1b6415685d7364]
stable/4.19: [d3f409c375490a86d342eae1d0f6271d12dc19d0]
stable/5.10: [80977126bc20309f7f7bae6d8621356b393e8b41]
stable/5.15: [8a2df34b5bf652566f2889d9fa321f3b398547ef]
stable/5.4: [a452bc3deb23bf93f8a13d3e24611b7ef39645dc]

CVE-2023-1118: kernel: use-after-free in drivers/media/rc/ene_ir.c due
to race condition

CVSS v3 score is not provided.

When detaching the ene device, ene_remove() will be called but
env_remove() doesn't cancel tx_sim_timer.
If timer handler ene_tx_irqsim() is called, it could cause a use-after-free bug.

Introduced by commit 9ea53b7 ("V4L/DVB: STAGING: remove lirc_ene0100
driver") in 2.6.36-rc1.

Fixed status
mainline: [29b0589a865b6f66d141d79b2dd1373e4e50fe17]

CVE-2023-22996: use-after-free bug in drivers/soc/qcom/qcom_aoss.c

CVSS v3 score is not provided.

In the Linux kernel before 5.17.2, drivers/soc/qcom/qcom_aoss.c does
not release an of_find_device_by_node reference after use, e.g., with
put_device.

Introduced by commit 8c75d58 ("soc: qcom: aoss: Expose send for
generic usecase") in 5.16-rc1 so before 5.16 kernels are not affected
by this issue.

CVE-2023-22997: module: Fix NULL vs IS_ERR checking for module_get_next_page

CVSS v3 score is not provided.

In the Linux kernel before 6.1.2, kernel/module/decompress.c
misinterprets the module_get_next_page return value (expects it to be
NULL in the error case, whereas it is actually an error pointer).

Introduced by commit b1ae6dc ("module: add in-kernel support for
decompressing") in 5.17-rc1 so, before 5.17 kernels are not affected
by this issue.

Fixed status
mainline: [45af1d7aae7d5520d2858f8517a1342646f015db]
stable/6.1: [7a779e84b3c451ce4713456a413d3300143747a7]

CVE-2023-22998: drm/virtio: Fix NULL vs IS_ERR checking in
virtio_gpu_object_shmem_init

CVSS v3 score is not provided.

In the Linux kernel before 6.0.3,
drivers/gpu/drm/virtio/virtgpu_object.c misinterprets the
drm_gem_shmem_get_sg_table return value (expects it to be NULL in the
error case, whereas it is actually an error pointer).

This bug was introduced by commit 2f2aa13 ("drm/virtio: move
virtio_gpu_mem_entry initialization to new function") in 5.7-rc1 so
before 5.7 kernels are not affected by this issue.

Commit c249687 ("drm/virtio: Fix NULL vs IS_ERR checking in
virtio_gpu_object_shmem_init") changes return value from -EINVAL to
PTR_ERR(shmem->pages) but it needed to set NULL to shmem->pages.
Commit 64b88af ("drm/virtio: Correct drm_gem_shmem_get_sg_table()
error handling") does it.

Fixed status
mainline: [c24968734abfed81c8f93dc5f44a7b7a9aecadfa,
64b88afbd92fbf434759d1896a7cf705e1c00e79]
stable/5.15: [72893aadc0017f0f2998b33e7fa5e6b3a3a72d02,
60630834fad38252369bf4a351a03b75b76786e3]

CVE-2023-22999: usb: dwc3: qcom: Fix NULL vs IS_ERR checking in dwc3_qcom_probe

CVSS v3 score is not provided.

In the Linux kernel before 5.16.3, drivers/usb/dwc3/dwc3-qcom.c
misinterprets the dwc3_qcom_create_urs_usb_platdev return value
(expects it to be NULL in the error case, whereas it is actually an
error pointer).

Introduced by commit c25c210 ("usb: dwc3: qcom: add URS Host support
for sdm845 ACPI boot") in 5.12-rc1dontuse.
This commit was backported to 5.10 so 5.10 was affected.

Fixed status
mainline: [b52fe2dbb3e655eb1483000adfab68a219549e13]
stable/5.10: [94177fcecc35e9e9d3aecaa5813556c6b5aed7b6]
stable/5.15: [5157828d3975768b53a51cdf569203b953184022]

CVE-2023-23000: phy: tegra: xusb: Fix return value of
tegra_xusb_find_port_node function

CVSS v3 score is not provided.

In the Linux kernel before 5.17, drivers/phy/tegra/xusb.c mishandles
the tegra_xusb_find_port_node return value. Callers expect NULL in the
error case, but an error pointer is used.

Introduced by commit 0460467 ("phy: tegra: fix device-tree node
lookups") in 4.15-rc6.
Linux 4.4 isn't affected by this issue.

Fixed status
mainline: [045a31b95509c8f25f5f04ec5e0dec5cd09f2c5f]
stable/4.14: [f3f5fa872d09109edfd7c10c57865301fee396d4]

CVE-2023-23001: scsi: ufs: ufs-mediatek: Fix error checking in
ufs_mtk_init_va09_pwr_ctrl()

CVSS v3 score is not provided.

In the Linux kernel before 5.16.3, drivers/scsi/ufs/ufs-mediatek.c
misinterprets the regulator_get return value (expects it to be NULL in
the error case, whereas it is actually an error pointer).

Introduced by commit cf137b3 ("scsi: ufs-mediatek: Support VA09
regulator operations") in 5.11-rc1. So, before 5.11 kernels are not
affected by this issue.

Fixed status
mainline: [3ba880a12df5aa4488c18281701b5b1bc3d4531a]
stable/5.15: [0dc4db8abccf266390b81b72064191f876e55876]

* Updated CVEs

CVE-2022-2196: KVM: VMX: Execute IBPB on emulated VM-exit when guest has IBRS

stable kernel 5.10, 5.15, 5.4, and 6.1 were fixed.

Fixed status
mainline: [2e7eab81425ad6c875f2ed47c0ce01e78afc38a5]
stable/5.10: [1b0cafaae8884726c597caded50af185ffc13349]
stable/5.15: [6b539a7dbb49250f92515c2ba60aea239efc9e35]
stable/5.4: [f93a1a5bdcdd122aae0a3eab7a52c15b71fb725b]
stable/6.1: [63fada296062e91ad9f871970d4e7f19e21a6a15]

CVE-2022-3707: Double-free in split_2MB_gtt_entry when function
intel_gvt_dma_map_guest_page failed

stable kernel 4.19, 5.10, 5.15, and 5.4 were fixed.

Fixed status
mainline: [4a61648af68f5ba4884f0e3b494ee1cabc4b6620]
stable/4.19: [c5245a6cf83ca5c4b68d643f8b31ed0eb127126e]
stable/5.10: [3d743415c6fb092167df6c23e9c7e9f6df7db625]
stable/5.15: [0d3d5099a50badadad6837edda00e42149b2f657]
stable/5.4: [787ef0db014085df8691e5aeb58ab0bb081e5ff0]
stable/6.0: [bb84f2e119accfc65d5fa6ebe31751cdc3bca9fb]
stable/6.1: [1022519da69d99d455c58ca181a6c499c562c70e]

CVE-2023-20938: Privilege escalation bug was found in android binder driver

stable 5.15 was fixed.

Fixed status
mainline: [9a0a930fe2535a76ad70d3f43caeccf0d86a3009,
09184ae9b5756cc469db6fd1d1cfdcffbf627c2d,
  656e01f3ab54afe71bed066996fc2640881e1220,
6d98eb95b450a75adb4516a1d33652dc78d2b20c,
  ef38de9217a04c9077629a24652689d8fdb4c6c6,
2d1746e3fda0c3612143d7c06f8e1d1830c13e23]
stable/5.10: [2e3c27f24173c6f3d799080da82126fa044a2f5e,
c9d3f25a7f4e3aab3dfd91885e3d428bccdcb0e1,
  5204296fc76623552d53f042e2dc411b49c151f2,
23e9d815fad84c1bee3742a8de4bd39510435362,
  ae9e0cc973fb7499ea1b1a8dfd0795f728b84faf,
017de842533f4334d646f1d480f591f4ca9f5c7a]
stable/5.15: [b345b22002889b943c50db25cd7f37c93def722a,
c194fc351fecb419e7f3a33ed7e9b273b427d263,
  d107b4352284aff85e9dae0b13d4b05e17a1520c,
7a9ad4aceb0226b391c9d3b8e4ac2e7d438b6bde,
  d518ca02542fda332b34c2a3db9164363ac3f58e,
367d0456c79264d8fe743a4ab2961c772db4d495]
stable/5.4: [15e098ab1d3c8d6b2521b7cc4bc6da80936e9af6,
74e7f1828ab4205ebacf7c92b700279113dd075d,
  7b31ab0d9efb032ac1a8f25d419f7b9df1b1cfe3,
c056a6ba35e00ae943e377eb09abd77a6915b31a,

CVE-2023-25012: HID: bigben_remove: manually unregister leds

The mainline kernel was fixed.

Fixed status
mainline: [76ca8da989c7d97a7f76c75d475fe95a584439d7]

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

