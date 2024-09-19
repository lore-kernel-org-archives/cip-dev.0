Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6052FCE8D49
	for <webhook@archiver.kernel.org>; Thu, 19 Sep 2024 04:38:30 +0000 (UTC)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
 by mx.groups.io with SMTP id smtpd.web11.12217.1726720706837949342
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Sep 2024 21:38:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=nTbGZrRZ;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.180, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3e06b72f3e7so714920b6e.0
        for <cip-dev@lists.cip-project.org>; Wed, 18 Sep 2024 21:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1726720706; x=1727325506; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zfEX76f1wewZ0HIcaNKijvxxB+9qqpZ7egbBmTRyBlY=;
        b=nTbGZrRZeJw2hBIJx7tZMmijMqBaeqOEQjt1zfHBEViOg+Xz4QfC6+9jFL97UhEspp
         YQjXs287hLONllnDVlm+y0Vac5Y9gPmqG3hIQGKSwEvM0W1Xjw1xszTcoKULj/n66gMj
         hGaTyLj1UvF/+Qgum9HTTDeyBiHhJF5tbqHfTukzAmu6X85hb2tcbmJdrojBWwuSmxUs
         78gq/1GkVM991RbWPowaI5ogyrkH0ZgZ0l7Mxkdh+9uFVEkiX+Xp4z61p8JT5QWmxzlM
         ebkc1pPPZwGv3XtMSqJT9DViBTZH1LHPbXYQE1RujETPMwafqizjOV5GjKPM2rzD/8Js
         UNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726720706; x=1727325506;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zfEX76f1wewZ0HIcaNKijvxxB+9qqpZ7egbBmTRyBlY=;
        b=CQ4tlqoZ458ceETNJealDDk7WAhbU8NEna4GFBZfzHhmhmOo7U20ywicm1Q1Z/JLJk
         /z8+J5P1Mx+ojWt/Y1mpV+uiNdGnlDyxpmZM7PiWrObNtlsGEuqb0n3iHuK/rHxKqn9H
         NLPenbZSToUyese+crSMgwEsiZ+yXN+zKXm5EdjS01CK/7VYUYk4tQ+2hqhKKYZAsw9O
         01JcyvyQXhvPNk7NgtIBI7fF/cfQJ7GM7Wqxa75krIanwnV9dJV08auTpGRNOHL1ljOZ
         aBFEUZ8Up+uvRJ+B7tpmb6WYBchcw7p26LPNgU5s+qV8zPKhFhN/+rlbN/s3G6uhMMXZ
         cniA==
X-Gm-Message-State: AOJu0YyE0AvMdJNrpeNPhxRfZii3OGubkcEoZktiqcZFzbrEYHnNkjDW
	hh7T8hebNhKPvoy1vMEkL7MaH/3iPyBZXS1TC8SrmWrWkEdpqmTEVwmDWuuz9wCoqTTTpHCRXXp
	cCF0aSqrMEFDMRu6x3R8oxSlFTSzTP047tnSOzNmkXGAU9A+m8v8=
X-Google-Smtp-Source: AGHT+IFlFnG0rz9wK7irkbjzVUiOhAvzYuXL5h0wKvHxMOqxb70kvwRgl1C612OxvzI9fCuH43cOc7lAU8K4YLRbYSM=
X-Received: by 2002:a05:6808:3385:b0:3e0:44ce:9522 with SMTP id
 5614622812f47-3e26a766d5emr905958b6e.0.1726720703897; Wed, 18 Sep 2024
 21:38:23 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 19 Sep 2024 13:37:47 +0900
Message-ID: <CAODzB9rm1=zQVazcf2R5KeOq4QVxGRr6ozVoE+QW1v3WOSKZ=A@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Sep 2024 04:38:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16909

Hi!

It's this week's CVE report.

This week reported 130 new CVEs and 13 updated CVEs.

* New CVEs

CVE-2024-46673: scsi: aacraid: Fix double-free on probe failure

Announce: https://lore.kernel.org/linux-cve-announce/2024091333-CVE-2024-46673-c49c@gregkh/

Introduced by commit 8e0c5eb ("[SCSI] aacraid: Newer adapter
communication iterface support") in v2.6.20.16.
Fixed in v6.11-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [919ddf8336f0b84c0453bac583808c9f165a85c2]
stable/4.19: [d237c7d06ffddcdb5d36948c527dc01284388218]
stable/5.10: [9e96dea7eff6f2bbcd0b42a098012fc66af9eb69]
stable/5.15: [85449b28ff6a89c4513115e43ddcad949b5890c9]
stable/5.4: [564e1986b00c5f05d75342f8407f75f0a17b94df]
stable/6.1: [60962c3d8e18e5d8dfa16df788974dd7f35bd87a]
stable/6.6: [8a3995a3ffeca280a961b59f5c99843d81b15929]

CVE-2024-46674: usb: dwc3: st: fix probed platform device ref count on
probe error path

Announce: https://lore.kernel.org/linux-cve-announce/2024091335-CVE-2024-46674-93ed@gregkh/

Introduced by commit f83fca0 ("usb: dwc3: add ST dwc3 glue layer to
manage dwc3 HC") in v3.18-rc1.
Fixed in v6.11-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ddfcfeba891064b88bb844208b43bef2ef970f0c]
stable/4.19: [b0979a885b9d4df2a25b88e9d444ccaa5f9f495c]
stable/5.10: [6aee4c5635d81f4809c3b9f0c198a65adfbb2ada]
stable/5.15: [060f41243ad7f6f5249fa7290dda0c01f723d12d]
stable/5.4: [f3498650df0805c75b4e1c94d07423c46cbf4ce1]
stable/6.1: [4c6735299540f3c82a5033d35be76a5c42e0fb18]
stable/6.6: [e1e5e8ea2731150d5ba7c707f9e02fafebcfeb49]

CVE-2024-46675: usb: dwc3: core: Prevent USB core invalid event buffer
address access

Announce: https://lore.kernel.org/linux-cve-announce/2024091335-CVE-2024-46675-ba70@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc6.

Fixed status
mainline: [14e497183df28c006603cc67fd3797a537eef7b9]
stable/4.19: [eca3f543f817da87c00d1a5697b473efb548204f]
stable/5.10: [b72da4d89b97da71e056cc4d1429b2bc426a9c2f]
stable/5.15: [111277b881def3153335acfe0d1f43e6cd83ac93]
stable/5.4: [d2afc2bffec77316b90d530b07695e3f534df914]
stable/6.1: [2189fd13c577d7881f94affc09c950a795064c4b]
stable/6.6: [7bb11a75dd4d3612378b90e2a4aa49bdccea28ab]

CVE-2024-46676: nfc: pn533: Add poll mod list filling check

Announce: https://lore.kernel.org/linux-cve-announce/2024091335-CVE-2024-46676-0b05@gregkh/

Introduced by commit dfccd0f ("NFC: pn533: Add some polling entropy")
in v3.12-rc1.
Fixed in v6.11-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [febccb39255f9df35527b88c953b2e0deae50e53]
stable/5.10: [8ddaea033de051ed61b39f6b69ad54a411172b33]
stable/5.15: [7535db0624a2dede374c42040808ad9a9101d723]
stable/5.4: [c5e05237444f32f6cfe5d907603a232c77a08b31]
stable/6.1: [7ecd3dd4f8eecd3309432156ccfe24768e009ec4]
stable/6.6: [56ad559cf6d87f250a8d203b555dfc3716afa946]

CVE-2024-46677: gtp: fix a potential NULL pointer dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024091336-CVE-2024-46677-b53c@gregkh/

Introduced by commit 1e3a3ab ("gtp: make GTP sockets in gtp_newlink
optional") in v4.12-rc1.
Fixed in v6.11-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [defd8b3c37b0f9cb3e0f60f47d3d78d459d57fda]
stable/4.19: [620fe9809752fae91b4190e897b81ed9976dfb39]
stable/5.10: [8bbb9e4e0e66a39282e582d0440724055404b38c]
stable/5.15: [4643b91691e969b1b9ad54bf552d7a990cfa3b87]
stable/5.4: [bdd99e5f0ad5fa727b16f2101fe880aa2bff2f8e]
stable/6.1: [e8b9930b0eb045d19e883c65ff9676fc89320c70]
stable/6.6: [28c67f0f84f889fe9f4cbda8354132b20dc9212d]

CVE-2024-46678: bonding: change ipsec_lock from spin lock to mutex

Announce: https://lore.kernel.org/linux-cve-announce/2024091336-CVE-2024-46678-ca65@gregkh/

Introduced by commit 9a56055 ("bonding: Add struct bond_ipesc to
manage SA") in v5.14-rc2.
Fixed in v6.11-rc6.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [2aeeef906d5a526dc60cf4af92eda69836c39b1f]
stable/6.6: [6b598069164ac1bb60996d6ff94e7f9169dbd2d3]

CVE-2024-46679: ethtool: check device is present when getting link settings

Announce: https://lore.kernel.org/linux-cve-announce/2024091336-CVE-2024-46679-3527@gregkh/

Introduced by commit d519e17 ("net: export device speed and duplex via
sysfs") in v2.6.33-rc1.
Introduced by commit 4224cfd ("net-sysfs: add check for netdevice
being present to speed_show") in v5.17-rc6.
Fixed in v6.11-rc6.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.4 cip/4.4-rt cip/4.4-st cip/5.10
cip/5.10-rt stable/4.19 stable/5.10 stable/5.15 stable/5.4

Fixed status
mainline: [a699781c79ecf6cfe67fb00a0331b4088c7c8466]
stable/5.10: [842a40c7273ba1c1cb30dda50405b328de1d860e]
stable/5.15: [7a8d98b6d6484d3ad358510366022da080c37cbc]
stable/5.4: [ec7b4f7f644018ac293cb1b02528a40a32917e62]
stable/6.1: [9bba5955eed160102114d4cc00c3d399be9bdae4]
stable/6.6: [94ab317024ba373d37340893d1c0358638935fbb]

CVE-2024-46680: Bluetooth: btnxpuart: Fix random crash seen while
removing driver

Announce: https://lore.kernel.org/linux-cve-announce/2024091336-CVE-2024-46680-f40d@gregkh/

Introduced by commit 86d55f1 ("Bluetooth: btnxpuart: Deasset UART
break before closing serdev device") in v6.4-rc1.
Fixed in v6.11-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [35237475384ab3622f63c3c09bdf6af6dacfe9c3]
stable/6.6: [662a55986b88807da4d112d838c8aaa05810e938]

CVE-2024-46681: pktgen: use cpus_read_lock() in pg_net_init()

Announce: https://lore.kernel.org/linux-cve-announce/2024091337-CVE-2024-46681-6086@gregkh/

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.11-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [979b581e4c69257acab1af415ddad6b2d78a2fa5]

CVE-2024-46682: nfsd: prevent panic for nfsv4.0 closed files in nfs4_show_open

Announce: https://lore.kernel.org/linux-cve-announce/2024091337-CVE-2024-46682-df82@gregkh/

Introduced by commit 3f29cc8 ("nfsd: split sc_status out of sc_type")
in v6.9-rc1.
Fixed in v6.11-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a204501e1743d695ca2930ed25a2be9f8ced96d3]

CVE-2024-46683: drm/xe: prevent UAF around preempt fence

Announce: https://lore.kernel.org/linux-cve-announce/2024091337-CVE-2024-46683-e513@gregkh/

Introduced by commit dd08ebf ("drm/xe: Introduce a new DRM driver for
Intel GPUs") in v6.8-rc1.
Fixed in v6.11-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [730b72480e29f63fd644f5fa57c9d46109428953]

CVE-2024-46684: binfmt_elf_fdpic: fix AUXV size calculation when
ELF_HWCAP2 is defined

Announce: https://lore.kernel.org/linux-cve-announce/2024091337-CVE-2024-46684-d492@gregkh/

Introduced by commit 10e2925 ("binfmt_elf_fdpic: fix
/proc/<pid>/auxv") in v6.10-rc1.
Fixed in v6.11-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c6a09e342f8e6d3cac7f7c5c14085236aca284b9]

CVE-2024-46685: pinctrl: single: fix potential NULL dereference in
pcs_get_function()

Announce: https://lore.kernel.org/linux-cve-announce/2024091338-CVE-2024-46685-6606@gregkh/

Introduced by commit 571aec4 ("pinctrl: single: Use generic pinmux
helpers for managing functions") in v4.11-rc1.
Fixed in v6.11-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1c38a62f15e595346a1106025722869e87ffe044]
stable/4.19: [0a2bab5ed161318f57134716accba0a30f3af191]
stable/5.10: [4e9436375fcc9bd2a60ee96aba6ed53f7a377d10]
stable/5.15: [6341c2856785dca7006820b127278058a180c075]
stable/5.4: [2cea369a5c2e85ab14ae716da1d1cc6d25c85e11]
stable/6.1: [8f0bd526921b6867c2f10a83cd4fd14139adcd92]
stable/6.6: [4ed45fe99ec9e3c9478bd634624cd05a57d002f7]

CVE-2024-46686: smb/client: avoid dereferencing rdata=NULL in
smb2_new_read_req()

Announce: https://lore.kernel.org/linux-cve-announce/2024091338-CVE-2024-46686-5b18@gregkh/

Introduced by commit a6559cc ("cifs: split out smb3_use_rdma_offload()
helper") in v6.3-rc1.
Fixed in v6.11-rc6.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [c724b2ab6a46435b4e7d58ad2fbbdb7a318823cf]
stable/6.1: [6df57c63c200cd05e085c3b695128260e21959b7]
stable/6.6: [a01859dd6aebf826576513850a3b05992809e9d2]

CVE-2024-46687: btrfs: fix a use-after-free when hitting errors inside
btrfs_submit_chunk()

Announce: https://lore.kernel.org/linux-cve-announce/2024091338-CVE-2024-46687-5668@gregkh/

Introduced by commit 852eee6 ("btrfs: allow btrfs_submit_bio to split
bios") in v6.3-rc1.
Fixed in v6.11-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [10d9d8c3512f16cad47b2ff81ec6fc4b27d8ee10]
stable/6.6: [51722b99f41f5e722ffa10b8f61e802a0e70b331]

CVE-2024-46688: erofs: fix out-of-bound access when
z_erofs_gbuf_growsize() partially fails

Announce: https://lore.kernel.org/linux-cve-announce/2024091338-CVE-2024-46688-7a5a@gregkh/

Introduced by commit d6db47e ("erofs: do not use pagepool in
z_erofs_gbuf_growsize()") in v6.10-rc1.
Fixed in v6.11-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0005e01e1e875c5e27130c5e2ed0189749d1e08a]

CVE-2024-46689: soc: qcom: cmd-db: Map shared memory as WC, not WB

Announce: https://lore.kernel.org/linux-cve-announce/2024091339-CVE-2024-46689-4c19@gregkh/

Introduced by commit 312416d ("drivers: qcom: add command DB driver")
in v4.18-rc1.
Fixed in v6.11-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f9bb896eab221618927ae6a2f1d566567999839d]
stable/5.10: [f5a5a5a0e95f36e2792d48e6e4b64e665eb01374]
stable/5.15: [eaff392c1e34fb77cc61505a31b0191e5e46e271]
stable/5.4: [0ee9594c974368a17e85a431e9fe1c14fb65c278]
stable/6.1: [d9d48d70e922b272875cda60d2ada89291c840cf]
stable/6.6: [ef80520be0ff78ae5ed44cb6eee1525e65bebe70]

CVE-2024-46690: nfsd: fix nfsd4_deleg_getattr_conflict in presence of
third party lease

Announce: https://lore.kernel.org/linux-cve-announce/2024091339-CVE-2024-46690-38b2@gregkh/

Introduced by commit c596772 ("NFSD: handle GETATTR conflict with
write delegation") in v6.9-rc1.
Fixed in v6.11-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [40927f3d0972bf86357a32a5749be71a551241b6]

CVE-2024-46691: usb: typec: ucsi: Move unregister out of atomic section

Announce: https://lore.kernel.org/linux-cve-announce/2024091339-CVE-2024-46691-93e1@gregkh/

Introduced by commit 9329933 ("soc: qcom: pmic_glink: Make client-lock
non-sleeping") in v6.10-rc1.
Fixed in v6.11-rc6.
Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [11bb2ffb679399f99041540cf662409905179e3a]

CVE-2024-46692: firmware: qcom: scm: Mark get_wq_ctx() as atomic call

Announce: https://lore.kernel.org/linux-cve-announce/2024091339-CVE-2024-46692-f287@gregkh/

Introduced by commit 6bf3259 ("firmware: qcom: scm: Add wait-queue
handling logic") in v6.3-rc1.
Fixed in v6.11-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9960085a3a82c58d3323c1c20b991db6045063b0]
stable/6.6: [cdf7efe4b02aa93813db0bf1ca596ad298ab6b06]

CVE-2024-46693: soc: qcom: pmic_glink: Fix race during initialization

Announce: https://lore.kernel.org/linux-cve-announce/2024091340-CVE-2024-46693-cbe3@gregkh/

Introduced by commit 58ef4ec ("soc: qcom: pmic_glink: Introduce base
PMIC GLINK driver") in v6.3-rc1.
Fixed in v6.11-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3568affcddd68743e25aa3ec1647d9b82797757b]
stable/6.6: [1efdbf5323c9360e05066049b97414405e94e087]

CVE-2024-46694: drm/amd/display: avoid using null object of framebuffer

Announce: https://lore.kernel.org/linux-cve-announce/2024091340-CVE-2024-46694-0706@gregkh/

Introduced by commit 5d945cb ("drm/amd/display: Create a file
dedicated to planes") in v6.0-rc1.
Fixed in v6.11-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3b9a33235c773c7a3768060cf1d2cf8a9153bc37]
stable/6.1: [093ee72ed35c2338c87c26b6ba6f0b7789c9e14e]
stable/6.6: [f6f5e39a3fe7cbdba190f42b28b40bdff03c8cf0]

CVE-2024-46695: selinux,smack: don't bypass permissions check in
inode_setsecctx hook

Announce: https://lore.kernel.org/linux-cve-announce/2024091340-CVE-2024-46695-affc@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc6.

Fixed status
mainline: [76a0e79bc84f466999fa501fce5bf7a07641b8a7]
stable/6.6: [459584258d47ec3cc6245a82e8a49c9d08eb8b57]

CVE-2024-46696: nfsd: fix potential UAF in nfsd4_cb_getattr_release

Announce: https://lore.kernel.org/linux-cve-announce/2024091340-CVE-2024-46696-a8c1@gregkh/

Introduced by commit c596772 ("NFSD: handle GETATTR conflict with
write delegation") in v6.9-rc1.
Fixed in v6.11-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1116e0e372eb16dd907ec571ce5d4af325c55c10]

CVE-2024-46697: nfsd: ensure that nfsd4_fattr_args.context is zeroed out

Announce: https://lore.kernel.org/linux-cve-announce/2024091341-CVE-2024-46697-d166@gregkh/

Introduced by commit f59388a ("NFSD: Add
nfsd4_encode_fattr4_sec_label()") in v6.7-rc1.
Fixed in v6.11-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f58bab6fd4063913bd8321e99874b8239e9ba726]

CVE-2024-46698: video/aperture: optionally match the device in sysfb_disable()

Announce: https://lore.kernel.org/linux-cve-announce/2024091341-CVE-2024-46698-357c@gregkh/

Introduced by commit 5ae3716 ("video/aperture: Only remove sysfb on
the default vga pci device") in v6.5-rc1.
Fixed in v6.11-rc6.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [b49420d6a1aeb399e5b107fc6eb8584d0860fbd7]

CVE-2024-46699: drm/v3d: Disable preemption while updating GPU stats

Announce: https://lore.kernel.org/linux-cve-announce/2024091341-CVE-2024-46699-b1cf@gregkh/

Introduced by commit 6abe93b ("drm/v3d: Fix race-condition between
sysfs/fdinfo and interrupt handler") in v6.10-rc1.
Fixed in v6.11-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9d824c7fce58f59982228aa85b0376b113cdfa35]

CVE-2024-46700: drm/amdgpu/mes: fix mes ring buffer overflow

Announce: https://lore.kernel.org/linux-cve-announce/2024091341-CVE-2024-46700-ed8e@gregkh/

Introduced by commit de32462 ("drm/amdgpu: cleanup MES11 command
submission") in v6.11-rc1.
Introduced by commit fffe347 ("drm/amdgpu: cleanup MES12 command
submission") in v6.11-rc1.
Fixed in v6.11-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [11752c013f562a1124088a35bd314aa0e9f0e88f]

CVE-2024-46701: libfs: fix infinite directory reads for offset dir

Announce: https://lore.kernel.org/linux-cve-announce/2024091326-CVE-2024-46701-ad65@gregkh/

Introduced by commit a2e4595 ("shmem: stable directory offsets") in v6.6-rc1.
Fixed in v6.11-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [64a7ce76fb901bf9f9c36cf5d681328fc0fd4b5a]

CVE-2024-46702: thunderbolt: Mark XDomain as unplugged when router is removed

Announce: https://lore.kernel.org/linux-cve-announce/2024091329-CVE-2024-46702-9b8e@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc4.
Vulnerable function was introduced by commit bfe778ac4 ("thunderbolt: Convert
switch to a device") in 4.13-rc1.

Fixed status
mainline: [e2006140ad2e01a02ed0aff49cc2ae3ceeb11f8d]
stable/5.10: [747bc154577de6e6af4bc99abfa859b8419bb4d8]
stable/5.15: [23ce6ba3b95488a2b9e9f6d43b340da0c15395dc]
stable/6.1: [80ac8d194831eca0c2f4fd862f7925532fda320c]
stable/6.6: [18b3ad2a3cc877dd4b16f48d84aa27b78d53bf1d]

CVE-2024-46703: Revert "serial: 8250_omap: Set the console genpd
always on if no console suspend"

Announce: https://lore.kernel.org/linux-cve-announce/2024091329-CVE-2024-46703-1f29@gregkh/

Introduced by commit 68e6939 ("serial: 8250_omap: Set the console
genpd always on if no console suspend") in v6.7-rc1.
Fixed in v6.11-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0863bffda1131fd2fa9c05b653ad9ee3d8db127e]

CVE-2024-46704: workqueue: Fix spruious data race in __flush_work()

Announce: https://lore.kernel.org/linux-cve-announce/2024091329-CVE-2024-46704-113e@gregkh/

Introduced by commit 134874e ("workqueue: Allow cancel_work_sync() and
disable_work() from atomic contexts on BH work items") in v6.10-rc1.
Fixed in v6.11-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8bc35475ef1a23b0e224f3242eb11c76cab0ea88]

CVE-2024-46705: drm/xe: reset mmio mappings with devm

Announce: https://lore.kernel.org/linux-cve-announce/2024091330-CVE-2024-46705-b9c0@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
Vulnerable driver was introduced by commit dd08ebf6c ("drm/xe: Introduce a new
DRM driver for Intel GPUs") in 6.8-rc1.

Fixed status
mainline: [c7117419784f612d59ee565145f722e8b5541fe6]

CVE-2024-46706: tty: serial: fsl_lpuart: mark last busy before uart_add_one_port

Announce: https://lore.kernel.org/linux-cve-announce/2024091330-CVE-2024-46706-ea07@gregkh/

Introduced by commit 43543e6 ("tty: serial: fsl_lpuart: Add runtime pm
support") in v6.2-rc1.
Fixed in v6.11-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dc98d76a15bc29a9a4e76f2f65f39f3e590fb15c]
stable/6.6: [8eb92cfca6c2c5a15ab1773f3d18ab8d8f7dbb68]

CVE-2024-46707: KVM: arm64: Make ICC_*SGI*_EL1 undef in the absence of a vGICv3

Announce: https://lore.kernel.org/linux-cve-announce/2024091330-CVE-2024-46707-9e4f@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc5.

Fixed status
mainline: [3e6245ebe7ef341639e9a7e402b3ade8ad45a19f]
stable/5.10: [15818af2f7aa55eff375333cb7689df15d3f24ef]
stable/5.15: [96b076e8ee5bc3a1126848c8add0f74bd30dc9d1]
stable/6.1: [94d4fbad01b19ec5eab3d6b50aaec4f9db8b2d8d]
stable/6.6: [9d7629bec5c3f80bd0e3bf8103c06a2f7046bd92]

CVE-2024-46708: pinctrl: qcom: x1e80100: Fix special pin offsets

Announce: https://lore.kernel.org/linux-cve-announce/2024091347-CVE-2024-46708-95c1@gregkh/

Introduced by commit 05e4941 ("pinctrl: qcom: Add X1E80100 pinctrl
driver") in v6.8-rc1.
Fixed in v6.11-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d3692d95cc4d88114b070ee63cffc976f00f207f]

CVE-2024-46709: drm/vmwgfx: Fix prime with external buffers

Announce: https://lore.kernel.org/linux-cve-announce/2024091347-CVE-2024-46709-2465@gregkh/

Introduced by commit b32233a ("drm/vmwgfx: Fix prime import/export")
in v6.9-rc5.
Fixed in v6.11-rc6.
Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [50f1199250912568606b3778dc56646c10cb7b04]
stable/6.6: [9a9716bbbf3dd6b6cbefba3abcc89af8b72631f4]

CVE-2024-46710: drm/vmwgfx: Prevent unmapping active read buffers

Announce: https://lore.kernel.org/linux-cve-announce/2024091347-CVE-2024-46710-cd88@gregkh/

Introduced by commit 485d98d ("drm/vmwgfx: Add support for CursorMob
and CursorBypass 4") in v5.19-rc1.
Fixed in v6.11-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aba07b9a0587f50e5d3346eaa19019cf3f86c0ea]

CVE-2024-46711: mptcp: pm: fix ID 0 endp usage after multiple re-creations

Announce: https://lore.kernel.org/linux-cve-announce/2024091348-CVE-2024-46711-ab95@gregkh/

Introduced by commit 3ad14f5 ("mptcp: more accurate MPC endpoint
tracking") in v6.0-rc1.
Fixed in v6.11-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9366922adc6a71378ca01f898c41be295309f044]
stable/6.1: [c9c744666f7308a4daba520191e29d395260bcfe]
stable/6.6: [53e2173172d26c0617b29dd83618b71664bed1fb]

CVE-2024-46712: drm/vmwgfx: Disable coherent dumb buffers without 3d

Announce: https://lore.kernel.org/linux-cve-announce/2024091309-CVE-2024-46712-5ca7@gregkh/

Introduced by commit d6667f0 ("drm/vmwgfx: Fix handling of dumb
buffers") in v6.11-rc2.
Fixed in v6.11-rc6.
Bug introduced commit was backported to following branches.
stable/6.10

Fixed status
mainline: [e9fd436bb8fb9b9d31fdf07bbcdba6d30290c5e4]

CVE-2024-46713: perf/aux: Fix AUX buffer serialization

Announce: https://lore.kernel.org/linux-cve-announce/2024091316-CVE-2024-46713-5e49@gregkh/

Introduced by commit 45bfb2e ("perf: Add AUX area to ring buffer for
raw data streams") in v4.1-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2ab9d830262c132ab5db2f571003d80850d56b2a]
stable/5.10: [7882923f1cb88dc1a17f2bf0c81b1fc80d44db82]
stable/5.15: [52d13d224fdf1299c8b642807fa1ea14d693f5ff]
stable/6.1: [9dc7ad2b67772cfb94ceb3b0c9c4023c2463215d]
stable/6.6: [c4b69bee3f4ef76809288fe6827bc14d4ae788ef]

CVE-2024-46714: drm/amd/display: Skip wbscl_set_scaler_filter if filter is null

Announce: https://lore.kernel.org/linux-cve-announce/2024091831-CVE-2024-46714-73de@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
Affected file was added by commit 345429a67 ("drm/amd/display: Add DCN2 DWB")
in 5.3-rc1.

Fixed status
mainline: [c4d31653c03b90e51515b1380115d1aedad925dd]
stable/5.10: [c083c8be6bdd046049884bec076660d4ec9a19ca]
stable/5.15: [6d94c05a13fadd80c3e732f14c83b2632ebfaa50]
stable/5.4: [0364f1f17a86d89dc39040beea4f099e60189f1b]
stable/6.1: [1726914cb17cedab233820d26b86764dc08857b4]
stable/6.6: [e3a95f29647ae45d1ec9541cd7df64f40bf2120a]

CVE-2024-46715: driver: iio: add missing checks on iio_info's callback access

Announce: https://lore.kernel.org/linux-cve-announce/2024091833-CVE-2024-46715-7e7b@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.

Fixed status
mainline: [c4ec8dedca961db056ec85cb7ca8c9f7e2e92252]
stable/6.1: [0cc7e0ee31e5c44904e98e2229d591e093282a70]
stable/6.6: [72f022ebb9deac28663fa4c04ba315ed5d6654d1]

CVE-2024-46716: dmaengine: altera-msgdma: properly free descriptor in
msgdma_free_descriptor

Announce: https://lore.kernel.org/linux-cve-announce/2024091833-CVE-2024-46716-f63f@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It seems as if this bug was introduced by commit a85c6f1b ("dmaengine:
Add driver
for Altera / Intel mSGDMA IP core") in 4.14-rc1.

Fixed status
mainline: [54e4ada1a4206f878e345ae01cf37347d803d1b1]
stable/6.1: [a3480e59fdbe5585d2d1eff0bed7671583acf725]
stable/6.6: [20bf2920a869f9dbda0ef8c94c87d1901a64a716]

CVE-2024-46717: net/mlx5e: SHAMPO, Fix incorrect page release

Announce: https://lore.kernel.org/linux-cve-announce/2024091833-CVE-2024-46717-2f30@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It seems as if this bug was introduced by commit f97d5c2a ("net/mlx5e:
Add handle
SHAMPO cqe support") in 5.16-rc1.

Fixed status
mainline: [70bd03b89f20b9bbe51a7f73c4950565a17a45f7]
stable/6.1: [03924d117625ecb10ee3c9b65930bcb2c37ae629]
stable/6.6: [ae9018e3f61ba5cc1f08a6e51d3c0bef0a79f3ab]

CVE-2024-46718: drm/xe: Don't overmap identity VRAM mapping

Announce: https://lore.kernel.org/linux-cve-announce/2024091833-CVE-2024-46718-c5c7@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
Affected file was introduced by commit dd08ebf ("drm/xe: Introduce a new DRM
driver for Intel GPUs") in 6.8-rc1.

Fixed status
mainline: [6d3581edffea0b3a64b0d3094d3f09222e0024f7]

CVE-2024-46719: usb: typec: ucsi: Fix null pointer dereference in trace

Announce: https://lore.kernel.org/linux-cve-announce/2024091834-CVE-2024-46719-4a53@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It seems as if this bug was introduced by commit af8622f6a ("usb: typec: ucsi
Support for DisplayPort alt mode") in 5.2-rc1.

Fixed status
mainline: [99516f76db48e1a9d54cdfed63c1babcee4e71a5]
stable/5.10: [7e64cabe81c303bdf6fd26b6a09a3289b33bc870]
stable/5.15: [3aa56313b0de06ce1911950b2cc0c269614a87a9]
stable/5.4: [8095bf0579ed4906a33f7bec675bfb29b6b16a3b]
stable/6.1: [b4243c05d7e3db0bdbf9124e6fa59b4ca7c807ae]
stable/6.6: [3b9f2d9301ae67070fe77a0c06758722fd7172b7]

CVE-2024-46720: drm/amdgpu: fix dereference after null check

Announce: https://lore.kernel.org/linux-cve-announce/2024091834-CVE-2024-46720-a598@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.

Fixed status
mainline: [b1f7810b05d1950350ac2e06992982974343e441]
stable/6.1: [1b73ea3d97cc23f9b16d10021782b48397d2b517]
stable/6.6: [0aad97bf6d0bc7a34a19f266b0b9fb2861efe64c]

CVE-2024-46721: apparmor: fix possible NULL pointer dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024091834-CVE-2024-46721-9aa7@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.

Fixed status
mainline: [3dd384108d53834002be5630132ad5c3f32166ad]
stable/4.19: [8d9da10a392a32368392f7a16775e1f36e2a5346]
stable/5.10: [52338a3aa772762b8392ce7cac106c1099aeab85]
stable/5.15: [e3c7d23f7a5c0b11ba0093cea32261ab8098b94e]
stable/5.4: [730ee2686af0d55372e97a2695005ff142702363]
stable/6.1: [09b2d107fe63e55b6ae643f9f26bf8eb14a261d9]
stable/6.6: [59f742e55a469ef36c5c1533b6095a103b61eda8]

CVE-2024-46722: drm/amdgpu: fix mc_data out-of-bounds read warning

Announce: https://lore.kernel.org/linux-cve-announce/2024091834-CVE-2024-46722-34b3@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.

Fixed status
mainline: [51dfc0a4d609fe700750a62f41447f01b8c9ea50]
stable/4.19: [5fa4df25ecfc7b6c9006f5b871c46cfe25ea8826]
stable/5.10: [310b9d8363b88e818afec97ca7652bd7fe3d0650]
stable/5.15: [345bd3ad387f9e121aaad9c95957b80895e2f2ec]
stable/5.4: [2097edede72ec5bb3869cf0205337d392fb2a553]
stable/6.1: [b862a0bc5356197ed159fed7b1c647e77bc9f653]
stable/6.6: [d0a43bf367ed640e527e8ef3d53aac1e71f80114]

CVE-2024-46723: drm/amdgpu: fix ucode out-of-bounds read warning

Announce: https://lore.kernel.org/linux-cve-announce/2024091834-CVE-2024-46723-6726@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It looks as if this bug was introduced bu commit bf3911b0 ("drm/amdgpu:
add cgs_get_firmware_info interface v2") in 4.3-rc1.

Fixed status
mainline: [8944acd0f9db33e17f387fdc75d33bb473d7936f]
stable/4.19: [82ac8f1d02886b5d8aeb9e058989d3bd6fc581e2]
stable/5.10: [5f09fa5e0ad45fbca71933a0e024ca52da47d59b]
stable/5.15: [0bef65e069d84d1cd77ce757aea0e437b8e2bd33]
stable/5.4: [e789e05388854a5436b2b5d8695fdb864c9bcc27]
stable/6.1: [8981927ebc6c12fa76b30c4178acb462bab15f54]
stable/6.6: [f2b7a9f3839e92f43559b2795b34640ca8cf839f]

CVE-2024-46724: drm/amdgpu: Fix out-of-bounds read of df_v1_7_channel_number

Announce: https://lore.kernel.org/linux-cve-announce/2024091835-CVE-2024-46724-02f5@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It looks as if this bug was introduced by commit d99605e (drm/amdgpu/df:
implement df v1_7 callback functions") in 4.18-rc1.

Fixed status
mainline: [d768394fa99467bcf2703bde74ddc96eeb0b71fa]
stable/5.10: [725b728cc0c8c5fafdfb51cb0937870d33a40fa4]
stable/5.15: [45f7b02afc464c208e8f56bcbc672ef5c364c815]
stable/6.1: [32915dc909ff502823babfe07d5416c5b6e8a8b1]
stable/6.6: [f9267972490f9fcffe146e79828e97acc0da588c]

CVE-2024-46725: drm/amdgpu: Fix out-of-bounds write warning

Announce: https://lore.kernel.org/linux-cve-announce/2024091835-CVE-2024-46725-af49@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.

Fixed status
mainline: [be1684930f5262a622d40ce7a6f1423530d87f89]
stable/5.10: [c253b87c7c37ec40a2e0c84e4a6b636ba5cd66b2]
stable/5.15: [919f9bf9997b8dcdc132485ea96121e7d15555f9]
stable/6.1: [cf2db220b38301b6486a0f11da24a0f317de558c]
stable/6.6: [a60d1f7ff62e453dde2d3b4907e178954d199844]

CVE-2024-46726: drm/amd/display: Ensure index calculation will not overflow

Announce: https://lore.kernel.org/linux-cve-announce/2024091835-CVE-2024-46726-587e@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It looks as if this bug was introduced by commit 91954c6c9 ("drm/amd/display:
Fix mutex lock in dcn10") in 6.1-rc1.

Fixed status
mainline: [8e2734bf444767fed787305ccdcb36a2be5301a2]
stable/6.1: [733ae185502d30bbe79575167b6178cfb6c5d6bd]
stable/6.6: [3dc6bb57dab36b38b7374af0ac916174c146b6ed]

CVE-2024-46727: drm/amd/display: Add otg_master NULL check within
resource_log_pipe_topology_update

Announce: https://lore.kernel.org/linux-cve-announce/2024091835-CVE-2024-46727-2565@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It looks as if this bug was introduced by commit d8bafc2b ("drm/amd/display:
add pipe topology update log") in 6.7-rc1.

Fixed status
mainline: [871cd9d881fa791d3f82885000713de07041c0ae]

CVE-2024-46728: drm/amd/display: Check index for aux_rd_interval before using

Announce: https://lore.kernel.org/linux-cve-announce/2024091835-CVE-2024-46728-edfe@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It seems as if this bug was introduced by commit 630168a9 ("drm/amd/display:
move dp link training logic to link_dp_training") in 6.3-rc1.

Fixed status
mainline: [9ba2ea6337b4f159aecb177555a6a81da92d302e]
stable/6.6: [48e0b68e2360b16edf2a0bae05c0051c00fbb48a]

CVE-2024-46728: drm/amd/display: Check index for aux_rd_interval before using

Announce: https://lore.kernel.org/linux-cve-announce/2024091835-CVE-2024-46728-edfe@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It seems as if this bug was introduced by commit 630168a9 ("drm/amd/display:
move dp link training logic to link_dp_training") in 6.3-rc1.

Fixed status
mainline: [9ba2ea6337b4f159aecb177555a6a81da92d302e]
stable/6.6: [48e0b68e2360b16edf2a0bae05c0051c00fbb48a]

CVE-2024-46729: drm/amd/display: Fix incorrect size calculation for loop

Announce: https://lore.kernel.org/linux-cve-announce/2024091836-CVE-2024-46729-158c@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It looks as if this bug was introduced by commit 8ce74b356 ("drm/amd/display:
Fix MST recognizes connected displays as one") in 6.7-rc1.

Fixed status
mainline: [3941a3aa4b653b69876d894d08f3fff1cc965267]

CVE-2024-46730: drm/amd/display: Ensure array index tg_inst won't be -1

Announce: https://lore.kernel.org/linux-cve-announce/2024091836-CVE-2024-46730-b69e@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It looks as if this bug was introduced by commit 2174181019e ("drm/amd/display:
add more pipe resource interfaces") in 6.7-rc1.

Fixed status
mainline: [687fe329f18ab0ab0496b20ed2cb003d4879d931]

CVE-2024-46731: drm/amd/pm: fix the Out-of-bounds read warning

Announce: https://lore.kernel.org/linux-cve-announce/2024091836-CVE-2024-46731-0e54@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It looks as if this bug was introduced by commit c82baa2 ("drm/amd/powerplay:
add Tonga dpm support (v3)") in 4.5-rc1.

Fixed status
mainline: [12c6967428a099bbba9dfd247bb4322a984fcc0b]
stable/5.10: [38e32a0d837443c91c4b615a067b976cfb925376]
stable/5.15: [3317966efcdc5101e93db21514b68917e7eb34ea]
stable/6.1: [20c6373a6be93039f9d66029bb1e21038a060be1]
stable/6.6: [f1e261ced9bcad772a45a2fcdf413c3490e87299]

CVE-2024-46732: drm/amd/display: Assign linear_pitch_alignment even for VM

Announce: https://lore.kernel.org/linux-cve-announce/2024091836-CVE-2024-46732-49a9@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It looks as if this bug was introduced by commit 68c0fca5e ("drm/amd/display:
support virtual DCN") in 5.6-rc1.

Fixed status
mainline: [984debc133efa05e62f5aa1a7a1dd8ca0ef041f4]
stable/5.15: [4bd7710f2fecfc5fb2dda1ca2adc69db8a66b8b6]
stable/6.1: [d219f902b16d42f0cb8c499ea8f31cf3c0f36349]
stable/6.6: [d2fe7ac613a1ea8c346c9f5c89dc6ecc27232997]

CVE-2024-46733: btrfs: fix qgroup reserve leaks in cow_file_range

Announce: https://lore.kernel.org/linux-cve-announce/2024091836-CVE-2024-46733-77eb@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc3.

Fixed status
mainline: [30479f31d44d47ed00ae0c7453d9b253537005b2]

CVE-2024-46734: btrfs: fix race between direct IO write and fsync when
using same fd

Announce: https://lore.kernel.org/linux-cve-announce/2024091830-CVE-2024-46734-9fe1@gregkh/

This CVE announce does not contain fixed commit in the mainline.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.10 stable/6.6

Fixed status
mainline: [cd9253c23aedd61eb5ff11f37a36247cd46faf86]
stable/5.15: [d116a0b0e02f395cedfb8c725bd67480aa7c428c]
stable/6.1: [cd3087582e4fa36e89be4e6f859e75a4400292b4]
stable/6.6: [7b5595f33c3c273613b590892a578d78186bb400]

CVE-2024-46735: ublk_drv: fix NULL pointer dereference in
ublk_ctrl_start_recovery()

Announce: https://lore.kernel.org/linux-cve-announce/2024091832-CVE-2024-46735-fbce@gregkh/

Introduced by commit c732a85 ("ublk_drv: add START_USER_RECOVERY and
END_USER_RECOVERY support") in v6.1-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e58f5142f88320a5b1449f96a146f2f24615c5c7]
stable/6.1: [ca249435893dda766f3845c15ca77ca5672022d8]
stable/6.6: [136a29d8112df4ea0a57f9602ddf3579e04089dc]

CVE-2024-46736: smb: client: fix double put of @cfile in smb2_rename_path()

Announce: https://lore.kernel.org/linux-cve-announce/2024091833-CVE-2024-46736-a70d@gregkh/

Introduced by commit 71f15c9 ("smb: client: retry compound request
without reusing lease") in v6.9-rc1.
Fixed in v6.11-rc7.
Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [3523a3df03c6f04f7ea9c2e7050102657e331a4f]
stable/6.6: [b27ea9c96efd2c252a981fb00d0f001b86c90f3e]

CVE-2024-46737: nvmet-tcp: fix kernel crash if commands allocation fails

Announce: https://lore.kernel.org/linux-cve-announce/2024091833-CVE-2024-46737-d36f@gregkh/

Introduced by commit 872d26a ("nvmet-tcp: add NVMe over TCP target
driver") in v5.0-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5572a55a6f830ee3f3a994b6b962a5c327d28cb3]
stable/5.10: [50632b877ce55356f5d276b9add289b1e7ddc683]
stable/5.15: [91dad30c5607e62864f888e735d0965567827bdf]
stable/5.4: [03e1fd0327fa5e2174567f5fe9290fe21d21b8f4]
stable/6.1: [7957c731fc2b23312f8935812dee5a0b14b04e2d]
stable/6.6: [489f2913a63f528cfe3f21722583fb981967ecda]

CVE-2024-46738: VMCI: Fix use-after-free when removing resource in
vmci_resource_remove()

Announce: https://lore.kernel.org/linux-cve-announce/2024091833-CVE-2024-46738-d871@gregkh/

Introduced by commit bc63ded ("VMCI: resource object implementation.")
in v3.9-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [48b9a8dabcc3cf5f961b2ebcd8933bf9204babb7]
stable/4.19: [f6365931bf7c07b2b397dbb06a4f6573cc9fae73]
stable/5.10: [6c563a29857aa8053b67ee141191f69757f27f6e]
stable/5.15: [ef5f4d0c5ee22d4f873116fec844ff6edaf3fa7d]
stable/5.4: [b243d52b5f6f59f9d39e69b191fb3d58b94a43b1]
stable/6.1: [b9efdf333174468651be40390cbc79c9f55d9cce]
stable/6.6: [39e7e593418ccdbd151f2925fa6be1a616d16c96]

CVE-2024-46739: uio_hv_generic: Fix kernel NULL pointer dereference in
hv_uio_rescind

Announce: https://lore.kernel.org/linux-cve-announce/2024091834-CVE-2024-46739-0aa7@gregkh/

Introduced by commit ca3cda6 ("uio_hv_generic: add rescind support")
in v4.16-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fb1adbd7e50f3d2de56d0a2bb0700e2e819a329e]
stable/4.19: [3d414b64ecf6fd717d7510ffb893c6f23acbf50e]
stable/5.10: [1d8e020e51ab07e40f9dd00b52f1da7d96fec04c]
stable/5.15: [3005091cd537ef8cdb7530dcb2ecfba8d2ef475c]
stable/5.4: [f38f46da80a2ab7d1b2f8fcb444c916034a2dac4]
stable/6.1: [2be373469be1774bbe03b0fa7e2854e65005b1cc]
stable/6.6: [de6946be9c8bc7d2279123433495af7c21011b99]

CVE-2024-46740: binder: fix UAF caused by offsets overwrite

Announce: https://lore.kernel.org/linux-cve-announce/2024091834-CVE-2024-46740-e05a@gregkh/

Introduced by commit 6d98eb9 ("binder: avoid potential data leakage
when copying txn") in v5.17-rc1.
Fixed in v6.11-rc7.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15 stable/5.4

Fixed status
mainline: [4df153652cc46545722879415937582028c18af5]
stable/5.10: [3a8154bb4ab4a01390a3abf1e6afac296e037da4]
stable/5.15: [eef79854a04feac5b861f94d7b19cbbe79874117]
stable/5.4: [5a32bfd23022ffa7e152f273fa3fa29befb7d929]
stable/6.1: [4f79e0b80dc69bd5eaaed70f0df1b558728b4e59]
stable/6.6: [1f33d9f1d9ac3f0129f8508925000900c2fe5bb0]

CVE-2024-46741: misc: fastrpc: Fix double free of 'buf' in error path

Announce: https://lore.kernel.org/linux-cve-announce/2024091835-CVE-2024-46741-4ce7@gregkh/

Introduced by commit 72fa6f7 ("misc: fastrpc: Rework
fastrpc_req_munmap") in v6.2-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e8c276d4dc0e19ee48385f74426aebc855b49aaf]
stable/6.6: [f77dc8a75859e559f3238a6d906206259227985e]

CVE-2024-46742: smb/server: fix potential null-ptr-deref of
lease_ctx_info in smb2_open()

Announce: https://lore.kernel.org/linux-cve-announce/2024091835-CVE-2024-46742-223b@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc5.
Affected file was added by commit e2f34481 ("cifsd: add server-side procedures
for SMB3") in 5.15-rc1.

Fixed status
mainline: [4e8771a3666c8f216eefd6bd2fd50121c6c437db]
stable/6.6: [07f384c5be1f8633b13f0a22616e227570450bc6]

CVE-2024-46743: of/irq: Prevent device address out-of-bounds read in
interrupt map walk

Announce: https://lore.kernel.org/linux-cve-announce/2024091835-CVE-2024-46743-f386@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc4.

Fixed status
mainline: [b739dffa5d570b411d4bdf4bb9b8dfd6b7d72305]
stable/4.19: [d2a79494d8a5262949736fb2c3ac44d20a51b0d8]
stable/5.10: [9d1e9f0876b03d74d44513a0ed3ed15ef8f2fed5]
stable/5.15: [baaf26723beab3a04da578d3008be3544f83758f]
stable/5.4: [defcaa426ba0bc89ffdafb799d2e50b52f74ffc4]
stable/6.1: [8ff351ea12e918db1373b915c4c268815929cbe5]
stable/6.6: [7ead730af11ee7da107f16fc77995613c58d292d]

CVE-2024-46744: Squashfs: sanity check symbolic link size

Announce: https://lore.kernel.org/linux-cve-announce/2024091836-CVE-2024-46744-451f@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc4.

Fixed status
mainline: [810ee43d9cd245d138a2733d87a24858a23f577d]
stable/4.19: [f82cb7f24032ed023fc67d26ea9bf322d8431a90]
stable/5.10: [5c8906de98d0d7ad42ff3edf2cb6cd7e0ea658c4]
stable/5.15: [087f25b2d36adae19951114ffcbb7106ed405ebb]
stable/5.4: [1b9451ba6f21478a75288ea3e3fca4be35e2a438]
stable/6.1: [fac5e82ab1334fc8ed6ff7183702df634bd1d93d]
stable/6.6: [c3af7e460a526007e4bed1ce3623274a1a6afe5e]

CVE-2024-46745: Input: uinput - reject requests with unreasonable
number of slots

Announce: https://lore.kernel.org/linux-cve-announce/2024091836-CVE-2024-46745-7b05@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc5.

Fixed status
mainline: [206f533a0a7c683982af473079c4111f4a0f9f5e]
stable/4.19: [9c6d189f0c1c59ba9a32326ec82a0b367a3cd47b]
stable/5.10: [51fa08edd80003db700bdaa099385c5900d27f4b]
stable/5.15: [9719687398dea8a6a12a10321a54dd75eec7ab2d]
stable/5.4: [597ff930296c4c8fc6b6a536884d4f1a7187ec70]
stable/6.1: [61df76619e270a46fd427fbdeb670ad491c42de2]
stable/6.6: [a4858b00a1ec57043697fb935565fe267f161833]

CVE-2024-46746: HID: amd_sfh: free driver_data after destroying hid device

Announce: https://lore.kernel.org/linux-cve-announce/2024091836-CVE-2024-46746-eb7f@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc5.
It looks as if this bug was introduced by commit 4b2c53d93
("SFH:Transport Driver
to add support of AMD Sensor Fusion Hub (SFH)") in 5.11-rc1.

Fixed status
mainline: [97155021ae17b86985121b33cf8098bcde00d497]
stable/5.15: [86b4f5cf91ca03c08e3822ac89476a677a780bcc]
stable/6.1: [775125c7fe38533aaa4b20769f5b5e62cc1170a0]
stable/6.6: [60dc4ee0428d70bcbb41436b6729d29f1cbdfb89]

CVE-2024-46747: HID: cougar: fix slab-out-of-bounds Read in cougar_report_fixup

Announce: https://lore.kernel.org/linux-cve-announce/2024091837-CVE-2024-46747-f489@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc5.
It looks as if this bug was introduced by commit b8e759b ("HID: cougar: Add
support for the Cougar 500k Gaming Keyboard") in 4.19-rc1.

Fixed status
mainline: [a6e9c391d45b5865b61e569146304cff72821a5d]
stable/4.19: [e239e44dcd419b13cf840e2a3a833204e4329714]
stable/5.10: [34185de73d74fdc90e8651cfc472bfea6073a13f]
stable/5.15: [890dde6001b651be79819ef7a3f8c71fc8f9cabf]
stable/5.4: [fac3cb3c6428afe2207593a183b5bc4742529dfd]
stable/6.1: [e4a602a45aecd6a98b4b37482f5c9f8f67a32ddd]
stable/6.6: [30e9ce7cd5591be639b53595c95812f1a2afdfdc]

CVE-2024-46748: cachefiles: Set the max subreq size for cache writes
to MAX_RW_COUNT

Announce: https://lore.kernel.org/linux-cve-announce/2024091837-CVE-2024-46748-03e7@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It looks as if this bug was introduced by commit 64e64e6c ("netfs, cachefiles:
Implement helpers for new write code") in 6.10-rc1.

Fixed status
mainline: [51d37982bbac3ea0ca21b2797a9cb0044272b3aa]

CVE-2024-46749: Bluetooth: btnxpuart: Fix Null pointer dereference in
btnxpuart_flush()

Announce: https://lore.kernel.org/linux-cve-announce/2024091838-CVE-2024-46749-fc9c@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It looks as if this bug was introduced by commit 664130c0b ("Bluetooth:
btnxpuart: Fix btnxpuart_close") in 6.9-rc1.
Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [c68bbf5e334b35b36ac5b9f0419f1f93f796bad1]
stable/6.6: [013dae4735d2010544d1f2121bdeb8e6c9ea171e]

CVE-2024-46750: PCI: Add missing bridge lock to pci_bus_lock()

Announce: https://lore.kernel.org/linux-cve-announce/2024091838-CVE-2024-46750-3be1@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.

Fixed status
mainline: [a4e772898f8bf2e7e1cf661a12c60a5612c4afab]
stable/4.19: [0790b89c7e911003b8c50ae50e3ac7645de1fae9]
stable/5.10: [e2355d513b89a2cb511b4ded0deb426cdb01acd0]
stable/5.15: [04e85a3285b0e5c5af6fd2c0fd6e95ffecc01945]
stable/5.4: [df77a678c33871a6e4ac5b54a71662f1d702335b]
stable/6.1: [7253b4fed46471cc247c6cacefac890a8472c083]
stable/6.6: [78c6e39fef5c428960aff742149bba302dd46f5a]

CVE-2024-46751: btrfs: don't BUG_ON() when 0 reference count at
btrfs_lookup_extent_info()

Announce: https://lore.kernel.org/linux-cve-announce/2024091838-CVE-2024-46751-17f5@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.

Fixed status
mainline: [28cb13f29faf6290597b24b728dc3100c019356f]

CVE-2024-46752: btrfs: replace BUG_ON() with error handling at
update_ref_for_cow()

Announce: https://lore.kernel.org/linux-cve-announce/2024091839-CVE-2024-46752-49e7@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.

Fixed status
mainline: [b56329a782314fde5b61058e2a25097af7ccb675]
stable/5.15: [b50857b96429a09fd3beed9f7f21b7bb7c433688]
stable/6.1: [0fbac73a97286a7ec72229cb9b42d760a2c717ac]
stable/6.6: [41a0f85e268d72fe04f731b8ceea4748c2d65491]

CVE-2024-46753: btrfs: handle errors from btrfs_dec_ref() properly

Announce: https://lore.kernel.org/linux-cve-announce/2024091839-CVE-2024-46753-5ec2@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.

Fixed status
mainline: [5eb178f373b4f16f3b42d55ff88fc94dd95b93b1]

CVE-2024-46754: bpf: Remove tst_run from lwt_seg6local_prog_ops.

Announce: https://lore.kernel.org/linux-cve-announce/2024091840-CVE-2024-46754-7f04@gregkh/

Introduced by commit d1542d4 ("seg6: Use nested-BH locking for
seg6_bpf_srh_states.") in v6.11-rc1.
Introduced by commit 004d4b2 ("ipv6: sr: Add seg6local action
End.BPF") in v4.18-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c13fda93aca118b8e5cd202e339046728ee7dddb]

CVE-2024-46755: wifi: mwifiex: Do not return unused priv in
mwifiex_get_priv_by_id()

Announce: https://lore.kernel.org/linux-cve-announce/2024091840-CVE-2024-46755-1f46@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.

Fixed status
mainline: [c145eea2f75ff7949392aebecf7ef0a81c1f6c14]
stable/4.19: [a12cf97cbefa139ef8d95081f2ea047cbbd74b7a]
stable/5.10: [9813770f25855b866b8ead8155b8806b2db70f6d]
stable/5.15: [cb67b2e51b75f1a17bee7599c8161b96e1808a70]
stable/5.4: [d834433ff313838a259bb6607055ece87b895b66]
stable/6.1: [1a05d8d02cfa3540ea5dbd6b39446bd3f515521f]
stable/6.6: [c2618dcb26c7211342b54520b5b148c0d3471c8a]

CVE-2024-46756: hwmon: (w83627ehf) Fix underflows seen when writing
limit attributes

Announce: https://lore.kernel.org/linux-cve-announce/2024091840-CVE-2024-46756-2ca6@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.

Fixed status
mainline: [5c1de37969b7bc0abcb20b86e91e70caebbd4f89]
stable/4.19: [93cf73a7bfdce683bde3a7bb65f270d3bd24497b]
stable/5.10: [56cfdeb2c77291f0b5e4592731adfb6ca8fc7c24]
stable/5.15: [cc4be794c8d8c253770103e097ab9dbdb5f99ae1]
stable/5.4: [77ab0fd231c4ca873ec6908e761970360acc6df2]
stable/6.1: [d92f0baf99a7e327dcceab37cce57c38aab1f691]
stable/6.6: [8fecb75bff1b7d87a071c32a37aa0700f2be379d]

CVE-2024-46757: hwmon: (nct6775-core) Fix underflows seen when writing
limit attributes

Announce: https://lore.kernel.org/linux-cve-announce/2024091841-CVE-2024-46757-4fbb@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It looks as if this bug was introduced by commit aa136e5 ("hwmon: (nct6775)
Add support for temperature sensors") in 3.10-rc1.

Fixed status
mainline: [0403e10bf0824bf0ec2bb135d4cf1c0cc3bf4bf0]
stable/4.19: [298a55f11edd811f2189b74eb8f53dee34d4f14c]
stable/5.10: [8a1e958e26640ce015abdbb75c8896301b9bf398]
stable/5.15: [02bb3b4c7d5695ff4be01e0f55676bba49df435e]
stable/5.4: [d6035c55fa9afefc23f85f57eff1d4a1d82c5b10]
stable/6.1: [0c23e18cef20b989a9fd7cb0a745e1259b969159]
stable/6.6: [2f695544084a559f181cafdfd3f864c5ff9dd1db]

CVE-2024-46758: hwmon: (lm95234) Fix underflows seen when writing
limit attributes

Announce: https://lore.kernel.org/linux-cve-announce/2024091841-CVE-2024-46758-6154@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It looks as if this bug was introduced by commit e1eb490 ("hwmon:
Add driver for LM95234") in 3.10-rc1.

Fixed status
mainline: [af64e3e1537896337405f880c1e9ac1f8c0c6198]
stable/4.19: [93f0f5721d0cca45dac50af1ae6f9a9826c699fd]
stable/5.10: [59c1fb9874a01c9abc49a0a32f192a7e7b4e2650]
stable/5.15: [0fc27747633aa419f9af40e7bdfa00d2ec94ea81]
stable/5.4: [438453dfbbdcf4be26891492644aa3ecbb42c336]
stable/6.1: [da765bebd90e1b92bdbc3c6a27a3f3cc81529ab6]
stable/6.6: [46e4fd338d5bdbaf60e41cda625b24949d2af201]

CVE-2024-46759: hwmon: (adc128d818) Fix underflows seen when writing
limit attributes

Announce: https://lore.kernel.org/linux-cve-announce/2024091841-CVE-2024-46759-9b86@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It looks as if this bug was introduced by commit b4c9c1a7 ("hwmon: Driver for
TI ADC128D818") in 3.15-rc1.

Fixed status
mainline: [8cad724c8537fe3e0da8004646abc00290adae40]
stable/4.19: [05419d0056dcf7088687e561bb583cc06deba777]
stable/5.10: [2a3add62f183459a057336381ef3a896da01ce38]
stable/5.15: [019ef2d396363ecddc46e826153a842f8603799b]
stable/5.4: [7645d783df23878342d5d8d22030c3861d2d5426]
stable/6.1: [f7f5101af5b47a331cdbfa42ba64c507b47dd1fe]
stable/6.6: [6891b11a0c6227ca7ed15786928a07b1c0e4d4af]

CVE-2024-46760: wifi: rtw88: usb: schedule rx work after everything is set up

Announce: https://lore.kernel.org/linux-cve-announce/2024091842-CVE-2024-46760-1eb3@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
Affected file was added by commit a82dfd33d12 ("wifi: rtw88: Add
common USB chip support") in 6.2-rc1.

Fixed status
mainline: [adc539784c98a7cc602cbf557debfc2e7b9be8b3]
stable/6.6: [c83d464b82a8ad62ec9077637f75d73fe955635a]

CVE-2024-46761: pci/hotplug/pnv_php: Fix hotplug driver crash on Powernv

Announce: https://lore.kernel.org/linux-cve-announce/2024091842-CVE-2024-46761-289f@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It looks as if this bug was introduced by commit 49f4b08e ("pci/hotplug/pnv-php:
Disable MSI and PCI device properly") in 4.11-rc1.

Fixed status
mainline: [335e35b748527f0c06ded9eebb65387f60647fda]
stable/4.19: [4eb4085c1346d19d4a05c55246eb93e74e671048]
stable/5.10: [bc1faed19db95abf0933b104910a3fb01b138f59]
stable/5.15: [c0d8094dc740cfacf3775bbc6a1c4720459e8de4]
stable/5.4: [c4c681999d385e28f84808bbf3a85ea8e982da55]
stable/6.1: [438d522227374042b5c8798f8ce83bbe479dca4d]
stable/6.6: [b82d4d5c736f4fd2ed224c35f554f50d1953d21e]

CVE-2024-46762: xen: privcmd: Fix possible access to a freed kirqfd instance

Announce: https://lore.kernel.org/linux-cve-announce/2024091843-CVE-2024-46762-6512@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
The irqfd was introduced by commit f8941e6c4c7 ("xen: privcmd: Add support for
irqfd") in 6.6-rc1.

Fixed status
mainline: [611ff1b1ae989a7bcce3e2a8e132ee30e968c557]
stable/6.6: [e997b357b13a7d95de31681fc54fcc34235fa527]

CVE-2024-46763: fou: Fix null-ptr-deref in GRO.

Announce: https://lore.kernel.org/linux-cve-announce/2024091843-CVE-2024-46763-a580@gregkh/

Introduced by commit d92283e ("fou: change to use UDP socket GRO") in v4.7-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7e4196935069947d8b70b09c1660b67b067e75cb]
stable/5.10: [231c235d2f7a66f018f172e26ffd47c363f244ef]
stable/5.15: [4494bccb52ffda22ce5a1163a776d970e6229e08]
stable/6.1: [d7567f098f54cb53ee3cee1c82e3d0ed9698b6b3]
stable/6.6: [1df42be305fe478ded1ee0c1d775f4ece713483b]

CVE-2024-46764: bpf: add check for invalid name in btf_name_valid_section()

Announce: https://lore.kernel.org/linux-cve-announce/2024091843-CVE-2024-46764-2d5c@gregkh/

Introduced by commit bd70a8f ("bpf: Allow all printable characters in
BTF DATASEC names") in v6.9-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bb6705c3f93bed2af03d43691743d4c43e3c8e6f]

CVE-2024-46765: ice: protect XDP configuration with a mutex

Announce: https://lore.kernel.org/linux-cve-announce/2024091844-CVE-2024-46765-1b8f@gregkh/

Introduced by commit 2d4238f ("ice: Add support for AF_XDP") in v5.5-rc1.
Introduced by commit efc2214 ("ice: Add support for XDP") in v5.5-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2504b8405768a57a71e660dbfd5abd59f679a03f]
stable/6.6: [2f057db2fb29bc209c103050647562e60554d3d3]

CVE-2024-46766: ice: move netif_queue_set_napi to rtnl-protected sections

Announce: https://lore.kernel.org/linux-cve-announce/2024091844-CVE-2024-46766-417c@gregkh/

Introduced by commit 080b0c8 ("ice: Fix ASSERT_RTNL() warning during
certain scenarios") in v6.8-rc7.
Introduced by commit 91fdbce ("ice: Add support in the driver for
associating queue with napi") in v6.8-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2a5dc090b92cfa5270e20056074241c6db5c9cdd]

CVE-2024-46767: net: phy: Fix missing of_node_put() for leds

Announce: https://lore.kernel.org/linux-cve-announce/2024091844-CVE-2024-46767-31a2@gregkh/

Introduced by commit 01e5b72 ("net: phy: Add a binding for PHY LEDs")
in v6.4-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2560db6ede1aaf162a73b2df43e0b6c5ed8819f7]
stable/6.6: [26928c8f00f6bb0e194f3957fe51c69d36838eb2]

CVE-2024-46768: hwmon: (hp-wmi-sensors) Check if WMI event data exists

Announce: https://lore.kernel.org/linux-cve-announce/2024091845-CVE-2024-46768-b0bb@gregkh/

Introduced by commit 23902f9 ("hwmon: add HP WMI Sensors driver") in v6.5-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a54da9df75cd1b4b5028f6c60f9a211532680585]
stable/6.6: [217539e994e53206bbf3fb330261cc78c480d311]

CVE-2024-46769: spi: intel: Add check devm_kasprintf() returned value

Announce: https://lore.kernel.org/linux-cve-announce/2024091845-CVE-2024-46769-9b81@gregkh/

Introduced by commit e58db3b ("spi: intel: Add default partition and
name to the second chip") in v6.9-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2920294686ec23211637998f3ec386dfd3d784a6]

CVE-2024-46770: ice: Add netif_device_attach/detach into PF reset flow

Announce: https://lore.kernel.org/linux-cve-announce/2024091845-CVE-2024-46770-3a5d@gregkh/

Introduced by commit fcea6f3 ("ice: Add stats and ethtool support") in
v4.17-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d11a67634227f9f9da51938af085fb41a733848f]
stable/6.1: [9e3ffb839249eca113062587659224f856fe14e5]
stable/6.6: [efe8effe138044a4747d1112ebb8c454d1663723]

CVE-2024-46771: can: bcm: Remove proc entry when dev is unregistered.

Announce: https://lore.kernel.org/linux-cve-announce/2024091846-CVE-2024-46771-913d@gregkh/

Introduced by commit ffd980f ("[CAN]: Add broadcast manager (bcm)
protocol") in v2.6.25-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [76fe372ccb81b0c89b6cd2fec26e2f38c958be85]
stable/4.19: [5c680022c4e28ba18ea500f3e29f0428271afa92]
stable/5.10: [aec92dbebdbec7567d9f56d7c9296a572b8fd849]
stable/5.15: [10bfacbd5e8d821011d857bee73310457c9c989a]
stable/5.4: [33ed4ba73caae39f34ab874ba79138badc2c65dd]
stable/6.1: [3b39dc2901aa7a679a5ca981a3de9f8d5658afe8]
stable/6.6: [4377b79323df62eb5d310354f19b4d130ff58d50]

CVE-2024-46772: drm/amd/display: Check denominator crb_pipes before used

Announce: https://lore.kernel.org/linux-cve-announce/2024091846-CVE-2024-46772-4ad6@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It looks as if this bug was introduced by commit 9ba90d76 ("drm/amd/display:
add pixel rate based CRB allocation support") in 6.5-rc1.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [ea79068d4073bf303f8203f2625af7d9185a1bc6]

CVE-2024-46773: drm/amd/display: Check denominator pbn_div before used

Announce: https://lore.kernel.org/linux-cve-announce/2024091847-CVE-2024-46773-5781@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It looks as if this bug was introduced by commit a550bb16 ("drm/amd/display:
dsc engine not disabled after unplug dsc mst hub") in 5.16-rc1.

Fixed status
mainline: [116a678f3a9abc24f5c9d2525b7393d18d9eb58e]
stable/6.1: [20e7164c52d9bfbb9d9862b833fa989624a61345]
stable/6.6: [dfafee0a7b51c7c9612edd2d991401294964d02f]

CVE-2024-46774: powerpc/rtas: Prevent Spectre v1 gadget construction
in sys_rtas()

Announce: https://lore.kernel.org/linux-cve-announce/2024091847-CVE-2024-46774-48d9@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
powerps is not supported by CIP.

Fixed status
mainline: [0974d03eb479384466d828d65637814bee6b26d7]

CVE-2024-46775: drm/amd/display: Validate function returns

Announce: https://lore.kernel.org/linux-cve-announce/2024091847-CVE-2024-46775-aecc@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
link_dp_training.c was added by commit 630168a9 ("drm/amd/display: move dp link
training logic to link_dp_training") in 6.3-rc1. dcn20_hubbub.c was
added by commit
bbeb64d0 ("drm/amd/display: Add DCN2 HUBP and HUBBUB") in 5.3-rc1.
dc_dmub_srv.c was
added by commit 3a1627b0 ("drm/amd/display: Add DMUB support to DC") in 5.6-rc1.

Fixed status
mainline: [673f816b9e1e92d1f70e1bf5f21b531e0ff9ad6c]

CVE-2024-46776: drm/amd/display: Run DC_LOG_DC after checking link->link_enc

Announce: https://lore.kernel.org/linux-cve-announce/2024091848-CVE-2024-46776-7a95@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It seems as if this bug was introduced by commit 54618888d ("drm/amd/display:
break down dc_link.c") in 6.3-rc1.

Fixed status
mainline: [3a82f62b0d9d7687eac47603bb6cd14a50fa718b]
stable/6.6: [874e3bb302f97b94ac548959ec4f925b8e7b45e2]

CVE-2024-46777: udf: Avoid excessive partition lengths

Announce: https://lore.kernel.org/linux-cve-announce/2024091848-CVE-2024-46777-6114@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.

Fixed status
mainline: [ebbe26fd54a9621994bc16b14f2ba8f84c089693]
stable/4.19: [c0c23130d38e8bc28e9ef581443de9b1fc749966]
stable/5.10: [551966371e17912564bc387fbeb2ac13077c3db1]
stable/5.15: [2ddf831451357c6da4b64645eb797c93c1c054d1]
stable/5.4: [1497a4484cdb2cf6c37960d788fb6ba67567bdb7]
stable/6.1: [0173999123082280cf904bd640015951f194a294]
stable/6.6: [a56330761950cb83de1dfb348479f20c56c95f90]

CVE-2024-46778: drm/amd/display: Check UnboundedRequestEnabled's value

Announce: https://lore.kernel.org/linux-cve-announce/2024091848-CVE-2024-46778-ded6@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It looks as if this bug was introduced by commit 7966f319 ("drm/amd/display:
Introduce DML2") in 6.7-rc1.

Fixed status
mainline: [a7b38c7852093385d0605aa3c8a2efd6edd1edfd]

CVE-2024-46779: drm/imagination: Free pvr_vm_gpuva after unlink

Announce: https://lore.kernel.org/linux-cve-announce/2024091849-CVE-2024-46779-3186@gregkh/

Introduced by commit ff5f643 ("drm/imagination: Add GEM and VM related
code") in v6.8-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f6b2f60b4631cd0c368da6a1587ab55a696164d]

CVE-2024-46780: nilfs2: protect references to superblock parameters
exposed in sysfs

Announce: https://lore.kernel.org/linux-cve-announce/2024091849-CVE-2024-46780-9155@gregkh/

Introduced by commit da7141f ("nilfs2: add /sys/fs/nilfs2/<device>
group") in v3.17-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [683408258917541bdb294cd717c210a04381931e]
stable/4.19: [b90beafac05931cbfcb6b1bd4f67c1923f47040e]
stable/5.10: [157c0d94b4c40887329418c70ef4edd1a8d6b4ed]
stable/5.15: [b14e7260bb691d7f563f61da07d61e3c8b59a614]
stable/5.4: [ba97ba173f9625d5f34a986088979eae8b80d38e]
stable/6.1: [19cfeba0e4b8eda51484fcf8cf7d150418e1d880]
stable/6.6: [8c6e43b3d5f109cf9c61bc188fcc8175404e924f]

CVE-2024-46781: nilfs2: fix missing cleanup on rollforward recovery error

Announce: https://lore.kernel.org/linux-cve-announce/2024091850-CVE-2024-46781-377e@gregkh/

Introduced by commit 0f3e1c7 ("nilfs2: recovery functions") in v2.6.30-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5787fcaab9eb5930f5378d6a1dd03d916d146622]
stable/4.19: [35a9a7a7d94662146396199b0cfd95f9517cdd14]
stable/5.10: [07e4dc2fe000ab008bcfe90be4324ef56b5b4355]
stable/5.15: [8e2d1e9d93c4ec51354229361ac3373058529ec4]
stable/5.4: [da02f9eb333333b2e4f25d2a14967cff785ac82e]
stable/6.1: [ca92c4bff2833cb30d493b935168d6cccd5c805d]
stable/6.6: [9d8c3a585d564d776ee60d4aabec59b404be7403]

CVE-2024-46782: ila: call nf_unregister_net_hooks() sooner

Announce: https://lore.kernel.org/linux-cve-announce/2024091850-CVE-2024-46782-00ff@gregkh/

Introduced by commit 7f00fea ("ila: Add generic ILA translation
facility") in v4.5-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [031ae72825cef43e4650140b800ad58bf7a6a466]
stable/4.19: [43d34110882b97ba1ec66cc8234b18983efb9abf]
stable/5.10: [93ee345ba349922834e6a9d1dadabaedcc12dce6]
stable/5.15: [bda4d84ac0d5421b346faee720011f58bdb99673]
stable/5.4: [dcaf4e2216824839d26727a15b638c6a677bd9fc]
stable/6.1: [925c18a7cff93d8a4320d652351294ff7d0ac93c]
stable/6.6: [18a5a16940464b301ea91bf5da3a324aedb347b2]

CVE-2024-46783: tcp_bpf: fix return value of tcp_bpf_sendmsg()

Announce: https://lore.kernel.org/linux-cve-announce/2024091850-CVE-2024-46783-edcb@gregkh/

Introduced by commit 4f738ad ("bpf: create tcp_bpf_ulp allowing BPF to
monitor socket TX/RX data") in v4.17-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fe1910f9337bd46a9343967b547ccab26b4b2c6e]
stable/5.10: [3efe53eb221a38e207c1e3f81c51e4ca057d50c2]
stable/5.15: [78bb38d9c5a311c5f8bdef7c9557d7d81ca30e4a]
stable/5.4: [6f9fdf5806cced888c43512bccbdf7fefd50f510]
stable/6.1: [810a4e7d92dea4074cb04c25758320909d752193]
stable/6.6: [c8219a27fa43a2cbf99f5176f6dddfe73e7a24ae]

CVE-2024-46784: net: mana: Fix error handling in mana_create_txq/rxq's
NAPI cleanup

Announce: https://lore.kernel.org/linux-cve-announce/2024091851-CVE-2024-46784-4773@gregkh/

Introduced by commit e1b5683 ("net: mana: Move NAPI from EQ to CQ") in
v5.15-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b6ecc662037694488bfff7c9fd21c405df8411f2]
stable/6.1: [9178eb8ebcd887ab75e54ac40d538e54bb9c7788]
stable/6.6: [9e0bff4900b5d412a9bafe4baeaa6facd34f671c]

CVE-2024-46785: eventfs: Use list_del_rcu() for SRCU protected list variable

Announce: https://lore.kernel.org/linux-cve-announce/2024091851-CVE-2024-46785-5351@gregkh/

Introduced by commit 43aa6f9 ("eventfs: Get rid of dentry pointers
without refcounts") in v6.8-rc3.
Fixed in v6.11-rc7.
Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [d2603279c7d645bf0d11fa253b23f1ab48fc8d3c]
stable/6.6: [05e08297c3c298d8ec28e5a5adb55840312dd87e]

CVE-2024-46786: fscache: delete fscache_cookie_lru_timer when fscache
exits to avoid UAF

Announce: https://lore.kernel.org/linux-cve-announce/2024091851-CVE-2024-46786-a167@gregkh/

Introduced by commit 12bb21a ("fscache: Implement cookie user counting
and resource pinning") in v5.17-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [72a6e22c604c95ddb3b10b5d3bb85b6ff4dbc34f]
stable/6.6: [e0d724932ad12e3528f4ce97fc0f6078d0cce4bc]

CVE-2024-46787: userfaultfd: fix checks for huge PMDs

Announce: https://lore.kernel.org/linux-cve-announce/2024091852-CVE-2024-46787-8b6d@gregkh/

Introduced by commit c1a4de9 ("userfaultfd:
mcopy_atomic|mfill_zeropage: UFFDIO_COPY|UFFDIO_ZEROPAGE preparation")
in v4.3-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [71c186efc1b2cf1aeabfeff3b9bd5ac4c5ac14d8]
stable/6.6: [3c6b4bcf37845c9359aed926324bed66bdd2448d]

CVE-2024-46788: tracing/osnoise: Use a cpumask to know what threads are kthreads

Announce: https://lore.kernel.org/linux-cve-announce/2024091852-CVE-2024-46788-1fbc@gregkh/

Introduced by commit e88ed22 ("tracing/timerlat: Add user-space
interface") in v6.5-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [177e1cc2f41235c145041eed03ef5bab18f32328]
stable/6.6: [7a5f01828edf152c144d27cf63de446fdf2dc222]

CVE-2024-46789: mm/slub: add check for s->flags in the
alloc_tagging_slab_free_hook

Announce: https://lore.kernel.org/linux-cve-announce/2024091853-CVE-2024-46789-2106@gregkh/

Introduced by commit 4b87369 ("mm/slab: add allocation accounting into
slab allocation and free paths") in v6.10-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ab7ca09520e9c41c219a4427fe0dae24024bfe7f]

CVE-2024-46790: codetag: debug: mark codetags for poisoned page as empty

Announce: https://lore.kernel.org/linux-cve-announce/2024091853-CVE-2024-46790-33ec@gregkh/

Introduced by commit d224eb0 ("codetag: debug: mark codetags for
reserved pages as empty") in v6.10-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5e9784e997620af7c1399029282f5d6964b41942]

CVE-2024-46791: can: mcp251x: fix deadlock if an interrupt occurs
during mcp251x_open

Announce: https://lore.kernel.org/linux-cve-announce/2024091853-CVE-2024-46791-af66@gregkh/

Introduced by commit 8ce8c0a ("can: mcp251x: only reset hardware as
required") in v5.5-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7dd9c26bd6cf679bcfdef01a8659791aa6487a29]
stable/5.10: [3a49b6b1caf5cefc05264d29079d52c99cb188e0]
stable/5.15: [513c8fc189b52f7922e36bdca58997482b198f0e]
stable/6.1: [f7ab9e14b23a3eac6714bdc4dba244d8aa1ef646]
stable/6.6: [8fecde9c3f9a4b97b68bb97c9f47e5b662586ba7]

CVE-2024-46792: riscv: misaligned: Restrict user access to kernel memory

Announce: https://lore.kernel.org/linux-cve-announce/2024091854-CVE-2024-46792-7745@gregkh/

Introduced by commit 7c83232 ("riscv: add support for misaligned trap
handling in S-mode") in v6.7-rc1.
Introduced by commit 4413815 ("riscv: misaligned: remove
CONFIG_RISCV_M_MODE specific code") in v6.10-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b686ecdeacf6658e1348c1a32a08e2e72f7c0f00]

CVE-2024-46793: ASoC: Intel: Boards: Fix NULL pointer deref in BYT/CHT
boards harder

Announce: https://lore.kernel.org/linux-cve-announce/2024091854-CVE-2024-46793-268d@gregkh/

Introduced by commit 7d99a70 ("ASoC: Intel: Boards: Fix NULL pointer
deref in BYT/CHT boards") in v6.8-rc5.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0cc65482f5b03ac2b1c240bc34665e43ea2d71bb]

CVE-2024-46794: x86/tdx: Fix data leak in mmio_read()

Announce: https://lore.kernel.org/linux-cve-announce/2024091854-CVE-2024-46794-9f64@gregkh/

Introduced by commit 31d58c4 ("x86/tdx: Handle in-kernel MMIO") in v5.19-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b6fb565a2d15277896583d471b21bc14a0c99661]
stable/6.1: [26c6af49d26ffc377e392e30d4086db19eed0ef7]
stable/6.6: [ef00818c50cf55a3a56bd9a9fae867c92dfb84e7]

CVE-2024-46795: ksmbd: unset the binding mark of a reused connection

Announce: https://lore.kernel.org/linux-cve-announce/2024091855-CVE-2024-46795-9908@gregkh/

Introduced by commit f5a544e ("ksmbd: add support for SMB3
multichannel") in v5.15-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [78c5a6f1f630172b19af4912e755e1da93ef0ab5]
stable/5.15: [9914f1bd61d5e838bb1ab15a71076d37a6db65d1]
stable/6.1: [93d54a4b59c4b3d803d20aa645ab5ca71f3b3b02]
stable/6.6: [41bc256da7e47b679df87c7fc7a5b393052b9cce]

CVE-2024-46796: smb: client: fix double put of @cfile in smb2_set_path_size()

Announce: https://lore.kernel.org/linux-cve-announce/2024091855-CVE-2024-46796-41c4@gregkh/

Introduced by commit 71f15c9 ("smb: client: retry compound request
without reusing lease") in v6.9-rc1.
Fixed in v6.11-rc7.
Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [f9c169b51b6ce20394594ef674d6b10efba31220]
stable/6.6: [5a72d1edb0843e4c927a4096f81e631031c25c28]

CVE-2024-46797: powerpc/qspinlock: Fix deadlock in MCS queue

Announce: https://lore.kernel.org/linux-cve-announce/2024091856-CVE-2024-46797-9174@gregkh/

Introduced by commit 84990b1 ("powerpc/qspinlock: add mcs queueing for
contended waiters") in v6.2-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [734ad0af3609464f8f93e00b6c0de1e112f44559]
stable/6.6: [d84ab6661e8d09092de9b034b016515ef9b66085]

CVE-2024-46798: ASoC: dapm: Fix UAF for snd_soc_pcm_runtime object

Announce: https://lore.kernel.org/linux-cve-announce/2024091856-CVE-2024-46798-ce16@gregkh/

Introduced by commit a72706e ("ASoC: codec2codec: remove ephemeral
variables") in v5.4-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b4a90b543d9f62d3ac34ec1ab97fc5334b048565]
stable/5.10: [8ca21e7a27c66b95a4b215edc8e45e5d66679f9f]
stable/5.15: [3033ed903b4f28b5e1ab66042084fbc2c48f8624]
stable/5.4: [993b60c7f93fa1d8ff296b58f646a867e945ae89]
stable/6.1: [fe5046ca91d631ec432eee3bdb1f1c49b09c8b5e]
stable/6.6: [5d13afd021eb43868fe03cef6da34ad08831ad6d]

CVE-2024-46799: net: ethernet: ti: am65-cpsw: Fix NULL dereference on XDP_TX

Announce: https://lore.kernel.org/linux-cve-announce/2024091856-CVE-2024-46799-cc5c@gregkh/

Introduced by commit 8acacc4 ("net: ethernet: ti: am65-cpsw: Add
minimal XDP support") in v6.10-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0a50c35277f96481a5a6ed5faf347f282040c57d]

CVE-2024-46800: sch/netem: fix use after free in netem_dequeue

Announce: https://lore.kernel.org/linux-cve-announce/2024091857-CVE-2024-46800-0f62@gregkh/

Introduced by commit 5061253 ("netem: fix classful handling") in v3.3-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3b3a2a9c6349e25a025d2330f479bc33a6ccb54a]
stable/4.19: [f0bddb4de043399f16d1969dad5ee5b984a64e7b]
stable/5.10: [98c75d76187944296068d685dfd8a1e9fd8c4fdc]
stable/5.15: [14f91ab8d391f249b845916820a56f42cf747241]
stable/5.4: [295ad5afd9efc5f67b86c64fce28fb94e26dc4c9]
stable/6.1: [db2c235682913a63054e741fe4e19645fdf2d68e]
stable/6.6: [dde33a9d0b80aae0c69594d1f462515d7ff1cb3d]

CVE-2024-46801: libfs: fix get_stashed_dentry()

Announce: https://lore.kernel.org/linux-cve-announce/2024091857-CVE-2024-46801-3cb7@gregkh/

Introduced by commit 07fd7c3 ("libfs: add path_from_stashed()") in v6.9-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4e32c25b58b945f976435bbe51f39b32d714052e]


* Updated CVEs

CVE-2019-15222: ALSA: usb-audio: Fix gpf in snd_usb_pipe_sanity_check

stable/4.19 was fixed.

Fixed status
mainline: [5d78e1c2b7f4be00bbe62141603a631dc7812f35]
stable/4.19: [5c4b0a778419d9deab8557265f4b3fd6f0e97e11]
stable/5.2: [bcbfb3efab0671590a14c7baf104173e49b7b248]

CVE-2022-48733: btrfs: fix use-after-free after failure to create a snapshot

stable/5.10 was fixed.

Fixed status
mainline: [28b21c558a3753171097193b6f6602a94169093a]
stable/5.10: [7e4c72dbaf62f8978af8321a24dbd35566d3a78a]
stable/5.15: [a7b717fa15165d3d9245614680bebc48a52ac05d]

CVE-2024-38577: rcu-tasks: Fix show_rcu_tasks_trace_gp_kthread buffer overflow

stable/5.10, stable/5.15 were fixed.

Fixed status
mainline: [cc5645fddb0ce28492b15520306d092730dffa48]
stable/5.10: [17c43211d45f13d1badea3942b76bf16bcc49281]
stable/5.15: [af7b560c88fb420099e29890aa682b8a3efc8784]
stable/6.1: [08186d0c5fb64a1cc4b43e009314ee6b173ed222]
stable/6.6: [32d988f48ed287e676a29a15ac30701c35849aec]
stable/6.9: [1a240e138071b25944ded0f5b3e357aa99fabcb7]

CVE-2024-42246: net, sunrpc: Remap EPERM in case of connection failure
in xs_tcp_setup_socket

stable/4.19, stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
mainline: [626dfed5fa3bfb41e0dffd796032b555b69f9cde]
stable/4.19: [bc790261218952635f846aaf90bcc0974f6f62c6]
stable/5.10: [02ee1976edb21a96ce8e3fd4ef563f14cc16d041]
stable/5.15: [5d8254e012996cee1a0f9cc920531cb7e4d9a011]
stable/5.4: [934247ea65bc5eca8bdb7f8c0ddc15cef992a5d6]
stable/6.1: [f2431e7db0fe0daccb2f06bb0d23740affcd2fa6]
stable/6.6: [d6c686c01c5f12ff8f7264e0ddf71df6cb0d4414]

CVE-2024-43835: virtio_net: Fix napi_skb_cache_put warning

stable/4.19, stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
mainline: [f8321fa75102246d7415a6af441872f6637c93ab]
stable/4.19: [19ac6f29bf64304ef04630c8ab56ecd2059d7aa1]
stable/5.10: [842a97b5e44f0c8a9fc356fe976e0e13ddcf7783]
stable/5.15: [cc7340f18e45886121c131227985d64ef666012f]
stable/5.4: [d3af435e8ace119e58d8e21d3d2d6a4e7c4a4baa]
stable/6.1: [6b5325f2457521bbece29499970c0117a648c620]
stable/6.10: [468a729b78895893d0e580ceea49bed8ada2a2bd]
stable/6.6: [f5e9a22d19bb98a7e86034db85eb295e94187caa]

CVE-2024-43854: block: initialize integrity buffer to zero before
writing it to media

stable/4.19, stable/5.10, stable/5.4 were fixed.

Fixed status
mainline: [899ee2c3829c5ac14bfc7d3c4a5846c0b709b78f]
stable/4.19: [9f4af4cf08f9a0329ade3d938f55d2220c40d0a6]
stable/5.10: [3fd11fe4f20756b4c0847f755a64cd96f8c6a005]
stable/5.15: [cf6b45ea7a8df0f61bded1dc4a8561ac6ad143d2]
stable/5.4: [129f95948a96105c1fad8e612c9097763e88ac5f]
stable/6.1: [d418313bd8f55c079a7da12651951b489a638ac1]
stable/6.10: [ebc0e91ba76dc6544fff9f5b66408b1982806a00]
stable/6.6: [23a19655fb56f241e592041156dfb1c6d04da644]

CVE-2024-43892: memcg: protect concurrent access to mem_cgroup_idr

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
mainline: [9972605a238339b85bd16b084eed5f18414d22db]
stable/5.10: [912736a0435ef40e6a4ae78197ccb5553cb80b05]
stable/5.15: [e6cc9ff2ac0b5df9f25eb790934c3104f6710278]
stable/6.1: [56fd70f4aa8b82199dbe7e99366b1fd7a04d86fb]
stable/6.10: [51c0b1bb7541f8893ec1accba59eb04361a70946]
stable/6.6: [37a060b64ae83b76600d187d76591ce488ab836b]

CVE-2024-43897: net: drop bad gso csum_start and offset in virtio_net_hdr

stable/5.15 was fixed.

Fixed status
mainline: [89add40066f9ed9abe5f7f886fe5789ff7e0c50e]
stable/5.15: [413e785a89f8bde0d4156a54b8ac2fa003c06756]
stable/6.1: [f01c5e335fbb7fb612d40f14a3c02e2612a43d3b]
stable/6.10: [2edbb3e8838c672cd7e247e47989df9d03fc6668]
stable/6.6: [6772c4868a8e7ad5305957cdb834ce881793acb7]

CVE-2024-43905: drm/amd/pm: Fix the null pointer dereference for vega10_hwmgr

stable/5.10, stable/5.15 were fixed.

Fixed status
mainline: [50151b7f1c79a09117837eb95b76c2de76841dab]
stable/5.10: [2ac9deb7e087f0b461c3559d9eaa6b9cf19d3fa8]
stable/5.15: [0fa11f9df96217c2785b040629ff1a16900fb51c]
stable/6.1: [c2629daf218a325f4d69754452cd42fe8451c15b]
stable/6.10: [69a441473fec2fc2aa2cf56122d6c42c4266a239]
stable/6.6: [2e538944996d0dd497faf8ee81f8bfcd3aca7d80]

CVE-2024-44974: mptcp: pm: avoid possible UaF when selecting endp

stable/5.10, stable/5.15 were fixed.

Fixed status
mainline: [48e50dcbcbaaf713d82bf2da5c16aeced94ad07d]
stable/5.10: [ddee5b4b6a1cc03c1e9921cf34382e094c2009f1]
stable/5.15: [f2c865e9e3ca44fc06b5f73b29a954775e4dbb38]
stable/6.1: [2b4f46f9503633dade75cb796dd1949d0e6581a1]
stable/6.10: [0201d65d9806d287a00e0ba96f0321835631f63f]
stable/6.6: [9a9afbbc3fbfca4975eea4aa5b18556db5a0c0b8]

CVE-2024-45009: mptcp: pm: only decrement add_addr_accepted for MPJ req

stable/5.15 was fixed.

Fixed status
mainline: [1c1f721375989579e46741f59523e39ec9b2a9bd]
stable/5.15: [35b31f5549ede4070566b949781e83495906b43d]
stable/6.1: [85b866e4c4e63a1d7afb58f1e24273caad03d0b7]
stable/6.10: [2060f1efab370b496c4903b840844ecaff324c3c]
stable/6.6: [d20bf2c96d7ffd171299b32f562f70e5bf5dc608]

CVE-2024-24856: Missing null pointer check causes a null pointer dereference bug

mainline, cip/4.4, cip/4.4-rt, cip/4.4-st, stable/4.19, stable/5.10,
stable/5.15, stable/5.4, stable/6.1 were fixed.

Fixed status
cip/4.4: [454a4b89e5f56659e5afe0898fb73571f68e17e4]
cip/4.4-rt: [454a4b89e5f56659e5afe0898fb73571f68e17e4]
cip/4.4-st: [454a4b89e5f56659e5afe0898fb73571f68e17e4]
stable/4.19: [35d67ffad6f5d78dbd800d354f5334c7b71a19e0]
stable/5.10: [978e0d05547ae707d51a942fc7e85a34e181ee6f]
stable/5.15: [d997c920a5305b37f0b8a40501b5aca10d099ecd]
stable/5.4: [c409eb45f5ddae2e3b3faa76cefc87f3cd0d0e88]
stable/6.1: [fee6133490091492dc66bcf71479bd53bd17a7d2]

CVE-2024-35943: pmdomain: ti: Add a null pointer check to the
omap_prm_domain_init

stable/6.1 was fixed.

Fixed status
stable/6.1: [bc08f5ab11b1881b85371f0bd9c9a3d27f65cca8]
stable/6.6: [ce666cecc09c0f92d5f86d89d8068ecfcf723a7e]
stable/6.8: [04f23510daa40f9010fadf309507564a34ad956f]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

