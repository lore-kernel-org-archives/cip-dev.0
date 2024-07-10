Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247A7C3DA42
	for <webhook@archiver.kernel.org>; Wed, 10 Jul 2024 23:27:17 +0000 (UTC)
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
 by mx.groups.io with SMTP id smtpd.web10.224.1720654034295050649
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Jul 2024 16:27:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=hwxjlWRU;
 spf=pass (domain: miraclelinux.com, ip: 209.85.161.50, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5c477d97159so179796eaf.3
        for <cip-dev@lists.cip-project.org>; Wed, 10 Jul 2024 16:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1720654033; x=1721258833; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t6nyqHe5x11MUSAgibMaiLepq5+tsSdP+pARRo2x8rw=;
        b=hwxjlWRUC5wQW7GDVnNp7iBPvuL+8hQcRFTQhCCE1TqGi1SZOmbtCk7BZNNJLKf6mZ
         N2N+XjaGXdnqOuNQ21vgBfs7sWTE8wWRlVjbopAf5Oq/6jveRowvZzMsDa6QYq50Vfzi
         AmnxecQ1Z57lI/feGLolooL+/8lttvAoFVWJVeiITyil2NS/zNfWf2wHBjFADqMqjxhQ
         lkMffWju5O3eem2kdfouV9fr/Wy5SsJILMh2fvz0eHdxbOiNeHHgIGzvNQNTH+XGlKTb
         oQ9FC2DH1/bXJZ4CE34xsOdXJr4jnR8xyaUh6oqi8hTFWWSYqTazwxIIUT8js18rbZ4p
         4vHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720654033; x=1721258833;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t6nyqHe5x11MUSAgibMaiLepq5+tsSdP+pARRo2x8rw=;
        b=lkaqtwLE7tONNG5PFVO45UChlvPloNfLQqrrzG4Qb5dBafxkY7U7WyEDiBOPiPcVuP
         oxeXJGJygokyEXsDDs5ghXwncVsJCtQTZjNbXWyFdC+oCW1zltgD5FKPdLZp65qjISSO
         oyH3TreNe4Mu6OfWGmUT6fKibdOL5l1ToTpofl8Yfy2PxhcwKmX1hScpQrN2/TtmY1KJ
         /Sk+Vp3pqznsc4ybgyTYW/m2vodnWr8cLrcURoUXyAl3+xNC2k99NQKlJJTeAni+DHPR
         7f0myo1vAPAPVLqPuR7K8vdrsQAA4kR4+tiV32Vngzc6Xh0P6nBWEZ7CQ16KiI3EmKTS
         AWkA==
X-Gm-Message-State: AOJu0Yz40Xub9lB9RV9yOnyGBpVorTi+1yVrnTPiEIx0jiI1XPBeLPd0
	8Q2c8VcJDnLyp26QAOKo7SkN/qTII4RlnxCpZeimSWoifmsQQyPmlAlugYf8a1JsLUzFnALbR/e
	knIMVzDXEk1EtavehkJS7c3dYNrTRbO4OhwUrqTqi7YjSgMtKijQ=
X-Google-Smtp-Source: AGHT+IEtgQtL9AgISOKesogzuRgAIANvtbZBqV/0LKFniOXAemgVM40nh24tOQcgRsZuKlqDRsQHym5QIlj6LyLiTbc=
X-Received: by 2002:a05:6870:a349:b0:25d:905:dcc4 with SMTP id
 586e51a60fabf-25eaec14409mr6261805fac.47.1720654032558; Wed, 10 Jul 2024
 16:27:12 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 11 Jul 2024 08:26:36 +0900
Message-ID: <CAODzB9pf203qrSQ5VpDTiG=U0DUa7gC1NJmJAog0y7U=TcuFjA@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Jul 2024 23:27:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16449

Hi!

It's this week's CVE report.

This week reported 22 new CVEs and 18 updated CVEs.

* New CVEs
CVE-2024-39472: xfs: fix log recovery buffer allocation for the legacy
h_size fixup

Announce: https://lore.kernel.org/linux-cve-announce/2024070512-CVE-2024-39472-f977@gregkh/

Introduced by commit 0c771b9 ("xfs: clean up calculation of LR header
blocks") in v5.10-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [45cf976008ddef4a9c9a30310c9b4fb2a9a6602a]

CVE-2024-39473: ASoC: SOF: ipc4-topology: Fix input format query of
process modules without base extension

Announce: https://lore.kernel.org/linux-cve-announce/2024070516-CVE-2024-39473-d28c@gregkh/

Introduced by commit 648fea1 ("ASoC: SOF: ipc4-topology: set copier
output format for process module") in v6.4-rc1.
Fixed in v6.10-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ffa077b2f6ad124ec3d23fbddc5e4b0ff2647af8]
stable/6.6: [e3ae00ee238bce6cfa5ad935c921181c14d18fd6]

CVE-2024-39474: mm/vmalloc: fix vmalloc which may return null if
called with __GFP_NOFAIL

Announce: https://lore.kernel.org/linux-cve-announce/2024070518-CVE-2024-39474-97cf@gregkh/

Introduced by commit 9376130 ("mm/vmalloc: add support for
__GFP_NOFAIL") in v5.17-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8e0545c83d672750632f46e3f9ad95c48c91a0fc]
stable/6.1: [198a80833e3421d4c9820a4ae907120adf598c91]
stable/6.6: [c55d3564ad25ce87ab7cc6af251f9574faebd8da]

CVE-2024-39475: fbdev: savage: Handle err return when savagefb_check_var failed

Announce: https://lore.kernel.org/linux-cve-announce/2024070518-CVE-2024-39475-ac04@gregkh/

Introduced by commit 04e5eac ("fbdev: savage: Error out if pixclock
equals zero") in v6.8-rc2.
Fixed in v6.10-rc1.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.4 cip/4.4-rt cip/4.4-st cip/5.10
cip/5.10-rt cip/6.1 cip/6.1-rt stable/4.19 stable/5.10 stable/5.15
stable/5.4 stable/6.1 stable/6.6

Fixed status
cip/4.4: [836b11cc29e6ef103ccab9a84e40517cef702ed2]
cip/4.4-st: [836b11cc29e6ef103ccab9a84e40517cef702ed2]
mainline: [6ad959b6703e2c4c5d7af03b4cfd5ff608036339]
stable/4.19: [be754cbd77eaf2932408a4e18532e4945274a5c7]
stable/5.10: [32f92b0078ebf79dbe4827288e0acb50d89d3d5b]
stable/5.15: [4b2c67e30b4e1d2ae19dba8b8e8f3b5fd3cf8089]
stable/5.4: [86435f39c18967cdd937d7a49ba539cdea7fb547]
stable/6.1: [edaa57480b876e8203b51df7c3d14a51ea6b09e3]
stable/6.6: [b8385ff814ca4cb7e63789841e6ec2a14c73e1e8]

CVE-2024-39476: md/raid5: fix deadlock that raid5d() wait for itself
to clear MD_SB_CHANGE_PENDING

Announce: https://lore.kernel.org/linux-cve-announce/2024070518-CVE-2024-39476-aa2d@gregkh/

Introduced by commit 5e2cf33 ("md/raid5: Wait for MD_SB_CHANGE_PENDING
in raid5d") in v6.1-rc1.
Fixed in v6.10-rc1.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/5.10 cip/5.10-rt stable/4.19 stable/5.10
stable/5.15 stable/5.4

Fixed status
mainline: [151f66bb618d1fd0eeb84acb61b4a9fa5d8bb0fa]
stable/4.19: [b32aa95843cac6b12c2c014d40fca18aef24a347]
stable/5.10: [aa64464c8f4d2ab92f6d0b959a1e0767b829d787]
stable/5.15: [098d54934814dd876963abfe751c3b1cf7fbe56a]
stable/5.4: [634ba3c97ec413cb10681c7b196db43ee461ecf4]
stable/6.1: [3f8d5e802d4cedd445f9a89be8c3fd2d0e99024b]
stable/6.6: [cd2538e5af495b3c747e503db346470fc1ffc447]

CVE-2024-39477: mm/hugetlb: do not call vma_add_reservation upon ENOMEM

Announce: https://lore.kernel.org/linux-cve-announce/2024070519-CVE-2024-39477-5c3f@gregkh/

Introduced by commit df7a6d1 ("mm/hugetlb: restore the reservation if
needed") in v6.9-rc1.
Fixed in v6.10-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8daf9c702ee7f825f0de8600abff764acfedea13]

CVE-2024-39478: crypto: starfive - Do not free stack buffer

Announce: https://lore.kernel.org/linux-cve-announce/2024070519-CVE-2024-39478-7e1c@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
It seems as if this bug was introduced by commit 445a4aaf ("crypto:
starfive - Add RSA algo support") in 6.5-rc1.

Fixed status
mainline: [d7f01649f4eaf1878472d3d3f480ae1e50d98f6c]

CVE-2024-39479: drm/i915/hwmon: Get rid of devm

Announce: https://lore.kernel.org/linux-cve-announce/2024070519-CVE-2024-39479-5bd1@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.

Fixed status
mainline: [5bc9de065b8bb9b8dd8799ecb4592d0403b54281]
stable/6.6: [cfa73607eb21a4ce1d6294a2c5733628897b48a2]

CVE-2024-39480: kdb: Fix buffer overflow during tab-complete

Announce: https://lore.kernel.org/linux-cve-announce/2024070519-CVE-2024-39480-b85a@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
It looks as if Linux 4.4 is affected too.

Fixed status
cip/4.4: [f96f7d3008e83affed93a2bd98590fe0a68786d7]
cip/4.4-st: [f96f7d3008e83affed93a2bd98590fe0a68786d7]
mainline: [e9730744bf3af04cda23799029342aa3cddbc454]
stable/4.19: [fb824a99e148ff272a53d71d84122728b5f00992]
stable/5.10: [cfdc2fa4db57503bc6d3817240547c8ddc55fa96]
stable/5.15: [f636a40834d22e5e3fc748f060211879c056cd33]
stable/5.4: [ddd2972d8e2dee3b33e8121669d55def59f0be8a]
stable/6.1: [33d9c814652b971461d1e30bead6792851c209e7]
stable/6.6: [107e825cc448b7834b31e8b1b3cf0f57426d46d5]

CVE-2024-39481: media: mc: Fix graph walk in media_pipeline_start

Announce: https://lore.kernel.org/linux-cve-announce/2024070520-CVE-2024-39481-108f@gregkh/

Introduced by commit ae21987 ("media: mc: entity: Rewrite
media_pipeline_start()") in v6.1-rc2.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8a9d420149c477e7c97fbd6453704e4612bdd3fa]
stable/6.1: [788fd0f11e45ae8d3a8ebbd3452a6e83f92db376]
stable/6.6: [e80d9db99b7b6c697d8d952dfd25c3425cf61499]

CVE-2024-39482: bcache: fix variable length array abuse in btree_iter

Announce: https://lore.kernel.org/linux-cve-announce/2024070520-CVE-2024-39482-8ed3@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.

Fixed status
mainline: [3a861560ccb35f2a4f0a4b8207fa7c2a35fc7f31]
stable/5.10: [2c3d7b03b658dc8bfa6112b194b67b92a87e081b]
stable/5.15: [5a1922adc5798b7ec894cd3f197afb6f9591b023]
stable/6.1: [934e1e4331859183a861f396d7dfaf33cb5afb02]
stable/6.6: [6479b9f41583b013041943c4602e1ad61cec8148]

CVE-2024-39483: KVM: SVM: WARN on vNMI + NMI window iff NMIs are outright masked

Announce: https://lore.kernel.org/linux-cve-announce/2024070520-CVE-2024-39483-92bf@gregkh/

Introduced by commit fa4c027 ("KVM: x86: Add support for SVM's Virtual
NMI") in v6.4-rc1.
Fixed in v6.10-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b4bd556467477420ee3a91fbcba73c579669edc6]
stable/6.6: [f79edaf7370986d73d204b36c50cc563a4c0f356]

CVE-2024-39484: mmc: davinci: Don't strip remove function when driver is builtin

Announce: https://lore.kernel.org/linux-cve-announce/2024070521-CVE-2024-39484-afbf@gregkh/

Introduced by commit b4cff45 ("DaVinci: MMC: MMC/SD controller driver
for DaVinci family") in v2.6.33-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [55c421b364482b61c4c45313a535e61ed5ae4ea3]
stable/5.10: [6ff7cfa02baabec907f6f29ea76634e6256d2ec4]
stable/5.15: [aea35157bb9b825faa0432bd0f7fbea37ff39aa1]
stable/6.1: [5ee241f72edc6dce5051a5f100eab6cc019d873e]
stable/6.6: [7590da4c04dd4aa9c262da0231e978263861c6eb]

CVE-2024-39485: media: v4l: async: Properly re-initialise notifier
entry in unregister

Announce: https://lore.kernel.org/linux-cve-announce/2024070521-CVE-2024-39485-0f50@gregkh/

Introduced by commit b8ec754 ("media: v4l: async: Set v4l2_device and
subdev in async notifier init") in v6.6-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9537a8425a7a0222999d5839a0b394b1e8834b4a]
stable/6.6: [87100b09246202a91fce4a1562955c32229173bb]

CVE-2024-39486: drm/drm_file: Fix pid refcounting race

Announce: https://lore.kernel.org/linux-cve-announce/2024070628-CVE-2024-39486-1ea1@gregkh/

Introduced by commit 1c7a387 ("drm: Update file owner during use") in v6.7-rc1.
Fixed in v6.10-rc6.
Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [4f2a129b33a2054e62273edd5a051c34c08d96e9]
stable/6.6: [16682588ead4a593cf1aebb33b36df4d1e9e4ffa]

CVE-2024-39487: bonding: Fix out-of-bounds read in
bond_option_arp_ip_targets_set()

Announce: https://lore.kernel.org/linux-cve-announce/2024070912-CVE-2024-39487-f52c@gregkh/

Introduced by commit f9de11a ("bonding: add ip checks when store ip
target") in v3.13-rc1.
Fixed in v6.10-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e271ff53807e8f2c628758290f0e499dbe51cb3d]

CVE-2024-39488: arm64: asm-bug: Add .align 2 to the end of __BUG_ENTRY

Announce: https://lore.kernel.org/linux-cve-announce/2024071013-CVE-2024-39488-f796@gregkh/

Introduced by commit 9fb7410 ("arm64/BUG: Use BRK instruction for
generic BUG traps") in v4.3-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ffbf4fb9b5c12ff878a10ea17997147ea4ebea6f]
stable/4.19: [f221bd58db0f6ca087ac0392284f6bce21f4f8ea]
stable/5.10: [461a760d578b2b2c2faac3040b6b7c77baf128f8]
stable/5.15: [c1929c041a262a4a27265db8dce3619c92aa678c]
stable/5.4: [22469a0335a1a1a690349b58bcb55822457df81e]
stable/6.1: [3fd487ffaa697ddb05af78a75aaaddabe71c52b0]
stable/6.6: [9f2ad88f9b349554f64e4037ec185c84d7dd9c7d]

CVE-2024-39489: ipv6: sr: fix memleak in seg6_hmac_init_algo

Announce: https://lore.kernel.org/linux-cve-announce/2024071016-CVE-2024-39489-104f@gregkh/

Introduced by commit bf355b8 ("ipv6: sr: add core files for SR HMAC
support") in v4.10-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [efb9f4f19f8e37fde43dfecebc80292d179f56c6]
stable/4.19: [afd5730969aec960a2fee4e5ee839a6014643976]
stable/5.10: [daf341e0a2318b813427d5a78788c86f4a7f02be]
stable/5.15: [61d31ac85b4572d11f8071855c0ccb4f32d76c0c]
stable/5.4: [4a3fcf53725b70010d1cf869a2ba549fed6b8fb3]
stable/6.1: [599a5654215092ac22bfc453f4fd3959c55ea821]
stable/6.6: [0e44d6cbe8de983470c3d2f978649783384fdcb6]

CVE-2024-39490: ipv6: sr: fix missing sk_buff release in seg6_input_core

Announce: https://lore.kernel.org/linux-cve-announce/2024071016-CVE-2024-39490-9fc3@gregkh/

Introduced by commit af3b515 ("ipv6: sr: fix BUG due to headroom too
small after SRH push") in v4.12-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5447f9708d9e4c17a647b16a9cb29e9e02820bd9]
stable/5.15: [e8688218e38111ace457509d8f0cad75f79c1a7a]
stable/6.1: [8f1fc3b86eaea70be6abcae2e9aa7e7b99453864]
stable/6.6: [f4df8c7670a73752201cbde215254598efdf6ce8]

CVE-2024-39491: ALSA: hda: cs35l56: Fix lifetime of cs_dsp instance

Announce: https://lore.kernel.org/linux-cve-announce/2024071016-CVE-2024-39491-fb62@gregkh/

Introduced by commit 73cfbfa ("ALSA: hda/cs35l56: Add driver for
Cirrus Logic CS35L56 amplifier") in v6.6-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d344873c4cbde249b7152d36a273bcc45864001e]
stable/6.6: [9054c474f9c219e58a441e401c0e6e38fe713ff1]

CVE-2024-39492: mailbox: mtk-cmdq: Fix pm_runtime_get_sync() warning
in mbox shutdown

Announce: https://lore.kernel.org/linux-cve-announce/2024071017-CVE-2024-39492-384a@gregkh/

Introduced by commit 8afe816 ("mailbox: mtk-cmdq-mailbox: Implement
Runtime PM with autosuspend") in v6.7-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [747a69a119c469121385543f21c2d08562968ccc]

CVE-2024-39493: crypto: qat - Fix ADF_DEV_RESET_SYNC memory leak

Announce: https://lore.kernel.org/linux-cve-announce/2024071042-CVE-2024-39493-ec00@gregkh/

Introduced by commit 7d42e09 ("crypto: qat - resolve race condition
during AER recovery") in v6.9-rc1.
Fixed in v6.10-rc1.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.4 cip/4.4-rt cip/4.4-st cip/5.10
cip/5.10-rt cip/6.1 cip/6.1-rt stable/4.19 stable/5.10 stable/5.15
stable/5.4 stable/6.1 stable/6.6

Fixed status
cip/4.4: [d31e894541357089276dc0d5f4927bc19a9c8019]
cip/4.4-st: [d31e894541357089276dc0d5f4927bc19a9c8019]
mainline: [d3b17c6d9dddc2db3670bc9be628b122416a3d26]
stable/4.19: [0ce5964b82f212f4df6a9813f09a0b5de15bd9c8]
stable/5.10: [a718b6d2a329e069b27d9049a71be5931e71d960]
stable/5.15: [3fb4601e0db10d4fe25e46f3fa308d40d37366bd]
stable/5.4: [6396b33e98c096bff9c253ed49c008247963492a]
stable/6.1: [e7428e7e3fe94a5089dc12ffe5bc31574d2315ad]
stable/6.6: [c2d443aa1ae3175c13a665f3a24b8acd759ce9c3]

* Updated CVEs

CVE-2021-47002: SUNRPC: Fix null pointer dereference in svc_rqst_free()

stable 5.10 was fixed.

Fixed status
mainline: [b9f83ffaa0c096b4c832a43964fe6bff3acffe10]
stable/5.10: [3de81c1e84bf84803308da3272a829a7655c5336]

CVE-2022-3566: tcp: Fix data races around icsk->icsk_af_ops.

stable 4.19, 5.10, 5.15, andn 5.4 were fixed.

Fixed status
mainline: [f49cd2f4d6170d27a2c61f1fecb03d8a70c91f57]
stable/4.19: [5bb642cc3355ffd3c8bca0a8bd8e6e65bcc2091c]
stable/5.10: [3b32f265805a49071e2c4568a524398ba22bf93c]
stable/5.15: [fcd31dd8291b23d713245947ec2b2d99ef07aef2]
stable/5.4: [d529193eae979a7bf2255cd9fe68b7af7a1c91b3]

CVE-2022-3567: ipv6: Fix data races around sk->sk_prot.

stable 4.19, 5.10, 5.15, andn 5.4 were fixed.

Fixed status
mainline: [364f997b5cfe1db0d63a390fe7c801fa2b3115f6]
stable/4.19: [fda6d62642a9c544a293d7ad7cb058f8c7f8f3dd]
stable/5.10: [ea2ed3f78ab238865b9b9e19a85c1de16d570ab7]
stable/5.15: [5088b4d4f91f15f02f52f3f3d4eb5968a6a3cb51]
stable/5.4: [f194e63054458b8f5019b294529409875be13c0c]

CVE-2023-52628: netfilter: nftables: exthdr: fix 4-byte stack OOB write

stable 5.4 was fixed.

Fixed status
mainline: [fd94d9dadee58e09b49075240fe83423eb1dcd36]
stable/4.19: [28a97c43c9e32f437ebb8d6126f9bb7f3ca9521a]
stable/5.10: [a7d86a77c33ba1c357a7504341172cc1507f0698]
stable/5.15: [1ad7b189cc1411048434e8595ffcbe7873b71082]
stable/5.4: [cf39c4f77a773a547ac2bcf30ecdd303bb0c80cb]
stable/6.1: [d9ebfc0f21377690837ebbd119e679243e0099cc]

CVE-2023-52760: gfs2: Fix slab-use-after-free in gfs2_qd_dealloc

stable 6.1 was fixed.

Fixed status
mainline: [bdcb8aa434c6d36b5c215d02a9ef07551be25a37]
stable/6.1: [7ad4e0a4f61c57c3ca291ee010a9d677d0199fba]
stable/6.6: [08a28272faa750d4357ea2cb48d2baefd778ea81]

CVE-2024-25741: usb/f_printer: WARNING in usb_ep_queue

stable 5.10, 5.15, 6.1, 6.6, 6.9, and mainline were fixed.

Fixed status
mainline: [e587a7633dfee8987a999cf253f7c52a8e09276c]
stable/5.10: [2798fc1560716c7945587ad43bef8f31f78c00af]
stable/5.15: [aa14dca6392ace6b182d15103c40571e66edfb96]
stable/6.1: [e9835f39a88e20092a8c5f068c8a34f98af9dc32]
stable/6.6: [a96915ffc956d8953c0f54180c6eed7e8c68fdc9]
stable/6.9: [01378f3fd7c704c92fbdb87337f1972311779354]

CVE-2024-27397: netfilter: nf_tables: use timestamp to check for set
element timeout

stable 6.1 was fixed.

Fixed status
mainline: [7395dfacfff65e9938ac0889dafa1ab01e987d15]
stable/6.1: [b45176b869673417ace338b87cf9cdb66e2eeb01]

CVE-2024-35976: xsk: validate user input for XDP_{UMEM|COMPLETION}_FILL_RING

stable 4.19 was fixed.

Fixed status
mainline: [237f3cf13b20db183d3706d997eedc3c49eacd44]
stable/4.19: [beb99266830520e15fbc6ca8cc5a5240d76851fd]
stable/5.10: [a82984b3c6a7e8c7937dba6e857ddf829d149417]
stable/5.15: [f0a068de65d5b7358e9aff792716afa9333f3922]
stable/5.4: [0b45c25d60e38f5c2cb6823f886773a34323306d]
stable/6.1: [2a523f14a3f53b46ff0e1fafd215b0bc5f6783aa]
stable/6.6: [b143e19dc28c3211f050f7848d87d9b0a170e10c]
stable/6.8: [2eb979fbb2479bcd7e049f2f9978b6590dd8a0e6]

CVE-2024-36032: Bluetooth: qca: fix info leak when fetching fw build id

stable 5.15 was fixed.

Fixed status
mainline: [cda0d6a198e2a7ec6f176c36173a57bdd8af7af2]
stable/5.15: [62d5550ab62042dcceaf18844d0feadbb962cffe]
stable/6.1: [57062aa13e87b1a78a4a8f6cb5fab6ba24f5f488]
stable/6.6: [6b63e0ef4d3ce0080395e5091fba2023f246c45a]

CVE-2024-36894: usb: gadget: f_fs: Fix race between aio_cancel() and
AIO request complete

stable 4.19, 5.10, 5.15, and 5.4 were fixed.

Fixed status
mainline: [24729b307eefcd7c476065cd7351c1a018082c19]
stable/4.19: [f71a53148ce34898fef099b75386a3a9f4449311]
stable/5.10: [e500b1c4e29ad0bd1c1332a1eaea2913627a92dd]
stable/5.15: [3613e5023f09b3308545e9d1acda86017ebd418a]
stable/5.4: [9e72ef59cbe61cd1243857a6418ca92104275867]
stable/6.1: [a0fdccb1c9e027e3195f947f61aa87d6d0d2ea14]
stable/6.6: [73c05ad46bb4fbbdb346004651576d1c8dbcffbb]

CVE-2024-36974: net/sched: taprio: always validate TCA_TAPRIO_ATTR_PRIOMAP

stable 5.10, 5.15, and 5.4 were fixed.

Fixed status
mainline: [f921a58ae20852d188f70842431ce6519c4fdc36]
stable/5.10: [6db4af09987cc5d5f0136bd46148b0e0460dae5b]
stable/5.15: [d3dde4c217f0c31ab0621912e682b57e677dd923]
stable/5.4: [c6041e7124464ce7e896ee3f912897ce88a0c4ec]
stable/6.1: [0bf6cc96612bd396048f57d63f1ad454a846e39c]
stable/6.6: [724050ae4b76e4fae05a923cb54101d792cf4404]
stable/6.9: [c37a27a35eadb59286c9092c49c241270c802ae2]

CVE-2024-36978: net: sched: sch_multiq: fix possible OOB write in multiq_tune()

stable 5.10, 5.15, and 5.4 were fixed.

Fixed status
mainline: [affc18fdc694190ca7575b9a86632a73b9fe043d]
stable/5.10: [52b1aa07cda6a199cd6754d3798c7759023bc70f]
stable/5.15: [598572c64287aee0b75bbba4e2881496878860f3]
stable/5.4: [d5d9d241786f49ae7cbc08e7fc95a115e9d80f3d]
stable/6.1: [0f208fad86631e005754606c3ec80c0d44a11882]
stable/6.6: [54c2c171c11a798fe887b3ff72922aa9d1411c1e]
stable/6.9: [d6fb5110e8722bc00748f22caeb650fe4672f129]

CVE-2024-37078: nilfs2: fix potential kernel bug due to lack of
writeback flag waiting

stable 4.19, 5.10, 5.15, and 5.4 were fixed.

Fixed status
mainline: [a4ca369ca221bb7e06c725792ac107f0e48e82e7]
stable/4.19: [95f6f81e50d858a7c9aa7c795ec14a0ac3819118]
stable/5.10: [0ecfe3a92869a59668d27228dabbd7965e83567f]
stable/5.15: [33900d7eae616647e179eee1c66ebe654ee39627]
stable/5.4: [a75b8f493dfc48aa38c518430bd9e03b53bffebe]
stable/6.1: [271dcd977ccda8c7a26e360425ae7b4db7d2ecc0]
stable/6.6: [614d397be0cf43412b3f94a0f6460eddced8ce92]
stable/6.9: [1f3bff69f1214fe03a02bc650d5bbfaa6e65ae7d]

CVE-2024-38586: r8169: Fix possible ring buffer corruption on
fragmented Tx packets.

stable 5.10 was fixed.

Fixed statut
mainline: [c71e3a5cffd5309d7f84444df03d5b72600cc417]
stable/5.10: [61c1c98e2607120ce9c3fa1bf75e6da909712b27]
stable/5.15: [b6d21cf40de103d63ae78551098a7c06af8c98dd]
stable/6.1: [0c48185a95309556725f818b82120bb74e9c627d]
stable/6.6: [68222d7b4b72aa321135cd453dac37f00ec41fd1]
stable/6.9: [54e7a0d111240c92c0f02ceba6eb8f26bf6d6479]

CVE-2024-38588: ftrace: Fix possible use-after-free issue in ftrace_location()

stable 5.15 was fixed.

Fixed status
mainline: [e60b613df8b6253def41215402f72986fee3fc8d]
stable/5.15: [8ea8ef5e42173560ac510e92a1cc797ffeea8831]
stable/6.1: [dbff5f0bfb2416b8b55c105ddbcd4f885e98fada]
stable/6.6: [7b4881da5b19f65709f5c18c1a4d8caa2e496461]
stable/6.9: [31310e373f4c8c74e029d4326b283e757edabc0b]

CVE-2024-38619: usb-storage: alauda: Check whether the media is initialized

stable 4.19, 5.10, 5.15, and 5.4 were fixed.

Fixed status
mainline: [16637fea001ab3c8df528a8995b3211906165a30]
stable/4.19: [e0aab7b07a9375337847c9d74a5ec044071e01c8]
stable/5.10: [f68820f1256b21466ff094dd97f243b7e708f9c1]
stable/5.15: [3eee13ab67f65606faa66e0c3c729e4f514838fd]
stable/5.4: [51fe16c058acb22f847e69bc598066ed0bcd5c15]
stable/6.1: [e0e2eec76920a133dd49a4fbe4656d83596a1361]
stable/6.6: [2cc32639ec347e3365075b130f9953ef16cb13f1]
stable/6.9: [24bff7f714bdff97c2a75a0ff6a368cdf8ad5af4]

CVE-2024-39468: smb: client: fix deadlock in smb2_find_smb_tcon()

stable 5.10 and 5.15 were fixed.

Fixed status
mainline: [02c418774f76a0a36a6195c9dbf8971eb4130a15]
stable/5.10: [b055752675cd1d1db4ac9c2750db3dc3e89ea261]
stable/5.15: [21f5dd36e655d25a7b45b61c1e537198b671f720]
stable/6.1: [b09b556e48968317887a11243a5331a7bc00ece5]
stable/6.6: [225de871ddf994f69a57f035709cad9c0ab8615a]
stable/6.9: [8d0f5f1ccf675454a833a573c53830a49b7d1a47]

CVE-2024-39469: nilfs2: fix nilfs_empty_dir() misjudgment and long
loop on I/O errors

stable 4.19, 5.10, 5.15, and 5.4 were fixed.

Fixed status
mainline: [7373a51e7998b508af7136530f3a997b286ce81c]
stable/4.19: [2ac8a2fe22bdde9eecce2a42cf5cab79333fb428]
stable/5.10: [c77ad608df6c091fe64ecb91f41ef7cb465587f1]
stable/5.15: [11a2edb70356a2202dcb7c9c189c8356ab4752cd]
stable/5.4: [405b71f1251e5ae865f53bd27c45114e6c83bee3]
stable/6.1: [129dcd3e7d036218db3f59c82d82004b9539ed82]
stable/6.6: [d18b05eda7fa77f02114f15b02c009f28ee42346]
stable/6.9: [59f14875a96ef93f05b82ad3c980605f2cb444b5]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

