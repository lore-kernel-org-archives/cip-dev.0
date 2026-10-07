Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9121ACA6004
	for <webhook@archiver.kernel.org>; Wed,  7 Oct 2026 21:54:53 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2790.1791410092154570944
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Oct 2026 14:54:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20251104.gappssmtp.com header.s=20251104 header.b=RuWFo52u;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.169, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8acda240937so23317837b3.3
        for <cip-dev@lists.cip-project.org>; Wed, 07 Oct 2026 14:54:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791410091; cv=none;
        d=google.com; s=arc-20260327;
        b=GGpAqSA+BqWo3OU+kX8mzS8fy2xY3frddE9H6IzodjKo+o2QeCl+R6GSbMzgOhPzWV
         3Gw4ZbG1ktCgy1H9TkT28xSOGPLXjbCFObdE5agvjzX9YNAxjl4kM23UqWTNRzGQnWO3
         I6jyfWJL2mpOGXGkunBZ4TeFQ0JNz6YEK18couHBko3ff1VG1JxIcqkfcnXK+T/MuKBt
         XQWAnsaNEPk5QmyYXrQJkT2gpbc1yvJ+KmTKlJKvAScSu7tq+dY/vXxUIy0l3bErRE5R
         Zecso3b+slWOx1NWts/07moTKWYsNE/EJFuXvz2m158495c0EwbG7XQJmtnth//WK3QC
         M14A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=b/1ItOJO08ZjojuGbLPrwcEKy5Qr1EhZJ6DdjoDzfkk=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=chvkNJ76wi4r5l96G8oM0TnksKiKDimp/sw8VUUJFVDubep8alxskeHnlvxE9xKaBD
         WaawH4tagv4WmI5/zYlby3HV4vgrw20OSoJM/9xAqJlGHSXg255zcOnR+YogckEvH53J
         A38i9fw5lMM6p8a3/wnVMONlxuvCKuOhI165aREC9S3NvItp/CD4JOQrQiXsbS8ISrN4
         4HIdHCDhCqhrW/dlSJ+D6f+L+my9v10ul/gFb/tzFXKnpvza3VnIMzcdKOEWPjun+PTJ
         k+DgGZTuOmJvHIZjmUIkiO6P7ONSzTh6YsEw4amK/dGumZreP38d+QNJN1AN+/eiqywq
         pOEw==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20251104.gappssmtp.com; s=20251104; t=1791410091; x=1792014891; darn=lists.cip-project.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=b/1ItOJO08ZjojuGbLPrwcEKy5Qr1EhZJ6DdjoDzfkk=;
        b=RuWFo52u8O/44CsfQ3kEvPCartEQAczkHA643S/fLvB0pCRfAwbcqBBpgA6nvnrbV+
         eIPSGcF9MdwN3GWRCnG9pP2u2+zJnz33GcJme+Ya3g8TA4wxVnH+C5oH+u5qv3uE175D
         hHji05Ph70wuDnFV1+jmJusJrrnlI2MsGLDA+Cuar9MmGPcZMTz52rrFJsYY804/NkGB
         ng6OdSIBJkhYbuhL6g0qiSYOMkNdbSD7BqsJCpUmEx7s0EXIAM19N4znHxZ3MVhAurqk
         OQMzBLV5RfZmAoqh86Rqb9hkbyEukgl4ysA3rmFkcVH207a1AAM+YLMOneS1HcrAWRIf
         HeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791410091; x=1792014891;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b/1ItOJO08ZjojuGbLPrwcEKy5Qr1EhZJ6DdjoDzfkk=;
        b=xXytTf07AAh7X+BiE1Jmdfras5lapHLFu9JzUQazuUoOiUIDnCyturK79GH75rVnMS
         GZjHCHKFfovDlqCLjgymrn/HNk2pYrKxGetW/I5Qg7WaZidY3q3rhem8fv5AoHyLv14h
         0bjX5+G2CgAwBxpovEyeA411rbW4p6zBQ5+whDbyCCUEoiAPppEJg4u4M61oBPavBAAN
         R0Z+Vki7TNWCXPSubaf33l+lIq/vKZp0u7Kxhln8VkBJXtM7c1TigzDun4RWYJWMvUxj
         Z1d+2SxQGB7t+sTpG/tptgYCorS4IfkXtvmtLQZBPPObg+mI6YFFIqZusiFccsKPhwWh
         R5dg==
X-Gm-Message-State: AFq9FYKOlPka22V74/d2axXQY8Y1VV7XuQMjeH1HomCHdvw8Hla32ebf
	iNZSbNajXCcTrDxn2/SguvzHu2SajWBy+FnkI8S5ogKqgflFilzVUW9n/X7cAJy4SzbKzoLVX8S
	bM5G/XIBEbpyCY9RdLG9MVsMuthqoyM7wRZYp9FioKjzciKnvYkpq3/sPHw==
X-Gm-Gg: AYBFou3znD4mqFkG0dkmChV8EklsvW8nM4LEdO24JD4X10kQiOTGfKfFsv1X4yOCshh
	gNpzVUXFAHyPJr7/Z88d7TtXO9oZFFsB0a45/N72eVaZwr9PQX5q7gFkm0WpHESgQRbu0FmYCGl
	tVFLesU27q8b3sS+9E/H2h8jUmdD/GcqAsqILDW8GzqwgihUPkY8mmvqyMu45BUErDhXKO8lsuF
	Oh54XUIDOmfMWEJdo7DEv0Nse6IxAbaMx7wBJYdjPDcM4W9mT3SfyQo/7zBvO+OrbdEpWZuxt0g
	RCCCmMbf1v5pf4fkORV4HPRAUIihD+0OMkNblaJZn28pgtJWr8nPdSWu901vUoFPQMSmjga4qft
	u+SSp9Gt+yfE0hZZR51Vt0eP2IQ+T
X-Received: by 2002:a05:690e:1384:b0:672:99e1:11fb with SMTP id
 956f58d0204a3-6790a49d55bmr1671823d50.152.1791410085242; Wed, 07 Oct 2026
 14:54:45 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 8 Oct 2026 06:54:07 +0900
X-Gm-Features: AclHuK8E3oGku9BZz8hCvfRglTFrJBIveYA4kSkVaJx-x-JnubSge4Tzr-RF6GA
Message-ID: <CAODzB9o7u8Y6q=KU=T1XfxL5AZvhFFs3shN4J3SZ7APjQeOnNA@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Oct 2026 21:54:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24436

Hi!

It's this week's CVE report.

This week reported 210 new CVEs and 434 updated CVEs.

* New CVEs
CVE-2026-98165: drm/amdgpu: restrict BAR0 fallback read to SR-IOV VFs only

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98165

Introduced by commit cba4928 ("drm/amdgpu: reduce early full GPU
access during SR-IOV init") in v7.3-rc1.
Fixed in v7.3-rc2.

Bug introduced commit was backported to following branches.
stable/7.2

Fixed status
mainline: [bd1f08246b8a2564d8ac61df715b6bcd5f994729]
stable/7.2: [5612934c255ad9352d07181f14981cfabd7b7a95]

CVE-2026-98166: drm/ttm: fix swapped-out resources never leaving their
bulk_move range

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98166

Introduced by commit b2ed01e ("drm/ttm: Fix ttm_bo_swapout() infinite
LRU walk on swapout failure") in v7.1-rc4.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3db7d7d583419f7b1f2e141e36418802dbb25cf8]
stable/7.2: [1169fe8c11ca45e3f91d59a73eb271d0ca8a7fb0]

CVE-2026-98167: smb: client: fix server->total_read for compound encrypted PDUs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98167

Introduced by commit b24df3e ("cifs: update receive_encrypted_standard
to handle compounded responses") in v4.19-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f73726b83e4756fdaa099e1bc1143293bd57ad79]
stable/6.1: [8703539d22fdbc13dd2db090ee199c3a427b8ea0]
stable/6.12: [a46eb242e9eef3a3897d166748b23303c516e870]
stable/6.18: [ebb8a075fdc7af3d196a4f158a0e18dbc394c0e3]
stable/6.6: [e78fc1d240b27349b45a0f1c3e3c2c401d7e230d]
stable/7.2: [282b72f9a7ef31296c48366db4128882999cc048]

CVE-2026-98168: smb: client: fix reparse buffer bounds in
cifs_query_reparse_point()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98168

Introduced by commit 56e84c6 ("cifs: Fix validation of SMB1 query
reparse point response") in v6.16-rc1.
Fixed in v7.3-rc4.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [5f0306e731e2f46e91419eae57eee3a241c055e0]
stable/6.12: [3d67f155fe5813cfb02a551a9a12d6ea06a902e9]
stable/6.18: [d1152c96a3002e3df6b9a5b007cecaa7b19b4f79]
stable/7.2: [8dc5db3a0e583ea8d31d0613cefd99e93e095c3c]

CVE-2026-98169: smb: client: fix potential OOB read in smb3_enum_snapshots()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98169

Introduced by commit e02789a ("smb3: enumerating snapshots was leaving
part of the data off end") in v4.19-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4775c3b7a597907e0b97556c7986fda238a377ae]
stable/6.1: [15a221c734b9d044ab769e7e3606b2cab96fb65a]
stable/6.12: [210f0f1f67817e7d2348b86b5115a9b85ef5c98b]
stable/6.18: [1cdf0d304d820fb13bf0faf532c3459600f9ea43]
stable/6.6: [74995ee8305a7c4d76ee70d6acd996a75eda3c03]
stable/7.2: [dbe452a905dfe2804647530a9ff3d7e3826ed04d]

CVE-2026-98170: smb: client: fix OOB struct field reads in
move_smb2_ea_to_cifs()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98170

Introduced by commit 95907fe ("cifs: Add support for reading
attributes on SMB2+") in v4.14-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eeb5ef6083e1cefa2ef75041b5597ff228b8d7bb]
stable/6.12: [d3546cecbf81d98bf3b472d341f981eb48c04f47]
stable/6.18: [34a3942e787b9c59758115bd65fe1ec89d68c7a4]
stable/7.2: [13efcd37a9b3d6ffa1579c3dda3e29c893ed9bca]

CVE-2026-98171: smb: client: fix next_buffer UAF and NextCommand
bounds in compound PDUs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98171

Introduced by commit b24df3e ("cifs: update receive_encrypted_standard
to handle compounded responses") in v4.19-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [05762c5bc1cfdcac36747994fde2c04387a457f1]
stable/6.1: [72eaef1f37a3b6bec11c342736834dc3707be3e4]
stable/6.12: [8749946579708ea0d339034bb7f423a67dbe89cf]
stable/6.18: [96c436e4b010711452b2872558938f4ef276492a]
stable/6.6: [491e33144dee872cffda207f6fcb09260728f803]
stable/7.2: [858d5ac22cb889266993e7670f9f0c4f4aeedd78]

CVE-2026-98172: smb: client: fix smbd_connection leak on
cifs_get_tcp_session() error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98172

Introduced by commit 2f89464 ("CIFS: SMBD: Upper layer connects to
SMBDirect session") in v4.16-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e75c96157d45e498970158c8f7373d90102e33b9]
stable/6.1: [3164402c58940ff58a3cecdb026405f07b0253af]
stable/6.12: [5c908e49d349266dff0c86dda6a05df0ff19b824]
stable/6.18: [928edc4bd6a617caabeb575fc13c254d9df623c4]
stable/6.6: [e3344bb0ff5ec8a276f42239e140f5442841ef23]
stable/7.2: [b26a3fcf2f1c2cadba400290b639f01395db8fc8]

CVE-2026-98173: smb: client: fix use-after-free of iface in
cifs_try_adding_channels()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98173

Introduced by commit aa45dad ("cifs: change iface_list from array to
sorted linked list") in v5.19-rc4.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d034e836eefd7ce75e588f7031cffbeec594f5ac]
stable/6.12: [c941f1ebfd26f683de81091473f3596a218abff0]
stable/6.18: [e99040e5e9c60441e6b4725e1a7b88c3106ae903]
stable/7.2: [ec36b38e65596950e6c29bed7dfc90b98707c19c]

CVE-2026-98174: smb: client: fix rlist race and missing initialization

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98174

Introduced commit is not determined.Fixed in v7.3-rc4.


Fixed status
mainline: [5f270f091256da1338c3631083e15d7f83cc05e1]
stable/6.12: [5a8f82f9c5839389cf4036029dd75a9911049e83]
stable/6.18: [04082b1833856cb9ed87e0d3d5f04cbf836cf7da]
stable/6.6: [b5f924ffbfa976e4b97f17e8132c595b97482c2d]
stable/7.2: [c037d6bde3dd5fa00b017b6b98a5389ec0ebc02f]

CVE-2026-98175: smb: client: cancel reconnect work in clean_demultiplex_info()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98175

Introduced by commit 53e0e11 ("CIFS: Fix a possible memory corruption
during reconnect") in v4.10-rc1.
Fixed in v7.3-rc4.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [c65eae6f61d1778ff7a82e4aae4080e26f486af1]
stable/6.12: [e3f6a779433d13aafb5edab59e4f9313051e8a52]
stable/6.18: [7ab9ceedd860216fb97f2d8574cbe58b8906f42a]
stable/6.6: [180380272f116dbd2b0354c5c7872e112e519149]
stable/7.2: [2e5103e11a17c274715dd56cf185eeedccf686b8]

CVE-2026-98176: drm/amdkfd: Avoid integer underflow with ffs in EOP
ring size calc

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98176

According to the .vulnerable file, this bug was introduced by commit
14328aa in v5.3-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c883d0a132d430ef7ebb23fd94323be94d0fbdb8]
stable/7.2: [82e1b8299c6da02ce02185c208d2fdf7572b5ea1]

CVE-2026-98177: drm/amdkfd: Avoid integer underflow in EOP ring size
calculation.

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98177

According to the .vulnerable file, this bug was introduced by commit
d696d53 in v4.3-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8ee521b8b189799e361d4233c5180ba56656d4d4]
stable/7.2: [287a34c4d712e0bdb67751e21316d9c8d75a528a]

CVE-2026-98178: drm/amdgpu: Skip KFD mapping clear before initialization

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98178

Introduced by commit 70cadef ("drm/amdgpu: unmap all user mappings of
framebuffer and doorbell before mode1 reset") in v7.2-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7f9caa70aef0950e06d395ca0035831214d88187]
stable/7.2: [157d3f1db7e7e6f320daa221fae84a4c13555b6f]

CVE-2026-98179: drm/amdgpu: fix rmmio iounmap skipped on device removal

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98179

Introduced by commit 62d5f9f ("drm/amdgpu: Unmap MMIO mappings when
device is not unplugged") in v5.17-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5155002b03b24ba3ef91c5c313b8cf0171b24904]
stable/6.12: [e81502d6791df9ecd003bfb2ca44f0d1f1b38439]
stable/6.18: [cd55dde2b63789a3dafe982c89844f537501d096]
stable/7.2: [a645584c3ccc493ee835f77155829442bd7578c3]

CVE-2026-98180: drm/msm: RCU-free the scheduler-containing ring and VM objects

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98180

Introduced by commit 1d8a5ca ("drm/msm: Conversion to drm scheduler")
in v5.15-rc1.
Introduced by commit 92395af ("drm/msm: Add VM_BIND submitqueue") in v6.17-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [01c8d1f385f788f1bbbbb7687c4386d614281218]
stable/6.18: [d81bf4581903b0cba0698cd4d1c07fc6be21754a]
stable/7.2: [713abac5c04ccbae67f9ac68c3921845535388e7]

CVE-2026-98181: drm/gud: fix out-of-bounds write in gud_plane_atomic_check()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98181

Introduced by commit 40e1a70 ("drm: Add GUD USB Display driver") in v5.13-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [59ced288fcba9e91bd38e61a972ad782c4edb7d0]
stable/5.15: [ee04903fe6a098160d20dde4fc5af4cb42846735]
stable/6.1: [4153a9e008f2512bd3cf90a319436865847369b9]
stable/6.12: [7e630edb22088df7aa0d55b02237a71e4c9a523d]
stable/6.18: [2c92af27ad23e2fbc0367b11a9027d36d94ef4b3]
stable/6.6: [5f5e565410b4987e9663f599f9ab0c350f8338d4]
stable/7.2: [ea57100955c1c2a525ba1a98c18d9a05b25aeedb]

CVE-2026-98182: wifi: mac80211: refuse to make a monitor active when
it has no queue

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98182

Introduced by commit 79af1f8 ("mac80211: avoid allocating TXQs that
won't be used") in v4.15-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b04d6556964ae9f89819b86a0a7801e39c3aae5]
stable/6.12: [b7b7d46ec4fa127767931938b282c361c0519af6]
stable/6.18: [abe15e643e576459469867758ae9c586a7bab95d]
stable/7.2: [46c223468537a05a404699771cd3e68532dab5e6]

CVE-2026-98183: wifi: mac80211: avoid out-of-bounds read for empty PREQ elements

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98183

Introduced by commit 8b40b1d ("wifi: mac80211: Fix overread in PREQ
frame processing") in v7.2-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e6031f02269c0f51cf67886d177f02bc300b47cd]
stable/7.2: [3beddbd56946577478fd5e649f556aaaebe15b0a]

CVE-2026-98184: wifi: mwifiex: prevent authentication frame length truncation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98184

Introduced by commit 3699589 ("wifi: mwifiex: add host mlme for client
mode") in v6.12-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fa00193eb991f92b007aefe7afb6a7566976dacf]
stable/6.12: [25c45a2075cc00faed45f92a64bb172fb074a2ee]
stable/6.18: [5747eaa38a7fcad48be2fd910b65008198b2b06c]
stable/7.2: [877b61a67d5eb3e616478daf3908114b57feff1e]

CVE-2026-98185: wifi: mwifiex: validate scan response extents

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98185

Introduced by commit 5e6e3a9 ("wireless: mwifiex: initial commit for
Marvell mwifiex driver") in v3.0-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3687d7d48070838cc2953431b3a27717cab0aaf6]
stable/5.10: [25217c5f6ce0bf3004f80c129464cd35fe9a420f]
stable/5.15: [48312f0085aa1577d6d41af2a079b34de17c1a57]
stable/6.1: [dccf5ecaad4d8d43c545921f20328e8f91af8698]
stable/6.12: [cb0008480ed7d5cf76f3ad9668a91bbb7d0b4417]
stable/6.18: [9cff2f39ed38a32070b08364c4c9346e85b8f9ec]
stable/6.6: [c4943323fda22ef27bb6479b9d328ae48c63f64c]
stable/7.2: [7106ad8b74f50cca1ef36131f327d2c78f556daa]

CVE-2026-98186: wifi: mwifiex: bound the pairwise-cipher OUI walk to
the IE length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98186

Introduced by commit 5e6e3a9 ("wireless: mwifiex: initial commit for
Marvell mwifiex driver") in v3.0-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e667aee1c192d67d27c803007bfa9c6e0873e959]
stable/5.10: [77e642af7f2f6029e12a35c847c56cbd0466e799]
stable/5.15: [982b8fcdbb28f63bbbf02f0822c0bbda12ec27ed]
stable/6.1: [58767b41f87244eebaa5a475b9d276c83b89b933]
stable/6.12: [54a9cc5bd70b0d77a5069d4c46998c679a10c857]
stable/6.18: [8bbef2b1ebfbadc0b9c37bbbf9c9e26fe2e41960]
stable/6.6: [2402c9e2644b7e10c7aaaf87bf12743d7e363559]
stable/7.2: [46cda9d42f0d6ec3057d878ddb1f38c0ab9f51df]

CVE-2026-98187: wifi: p54: require a full exp_if record in PDR_INTERFACE_LIST

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98187

Introduced by commit eff1a59 ("[P54]: add mac80211-based driver for
prism54 softmac hardware") in v2.6.24-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d8efd84f49379ed28624098821f80e992657d935]
stable/5.10: [162dbe1c285a621eab6a9f2851086b63a0378928]
stable/5.15: [70bf34b425fe549a4f6a8d50a319f8f05d1f91c9]
stable/6.1: [487f966421014de41e835bbce3feb30b35f4f729]
stable/6.12: [d44c1badc2dcb042985f7e37f4c448c84548b81f]
stable/6.18: [d2fb6b588dc5bbab4f603661e41cd60f0d931628]
stable/6.6: [bc83c04be042f53869c315b8e1eb5f124959d1d7]
stable/7.2: [d82492fd0a3fb61963c236521852763238ad3898]

CVE-2026-98188: wifi: p54: validate curve data length in the
calibration curve converters

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98188

Introduced by commit eff1a59 ("[P54]: add mac80211-based driver for
prism54 softmac hardware") in v2.6.24-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ce858fa6b8a214dee5adb82358885fa024cdd887]
stable/5.10: [81084c967c18233b19799a0c3352ebac043f31e2]
stable/5.15: [41cdf14bf4b52fbe4673a172c2a6ad756cb08111]
stable/6.1: [03d313e3dfb49a44c10a5c423452967694fb85e2]
stable/6.12: [4d767d6f8753db22bfc14c2724bd9cee677ffb03]
stable/6.18: [3bdcc4d61212b001b8752d80036509b4974ce16c]
stable/6.6: [42f4b03971f9d6329c4cbd1ea5155210d16ab65b]
stable/7.2: [b0c906107150b16925ee66da09127259864c7f36]

CVE-2026-98189: wifi: wilc1000: fix RX buffer OOB-write in
wilc_wlan_handle_isr_ext()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98189

Introduced by commit c5c77ba ("staging: wilc1000: Add SDIO/SPI 802.11
driver") in v4.2-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c1ba7f7f18465e259cf1b4d9c73fc73853d7f790]
stable/5.10: [3ddb88e237bc1e59fd37b1cf369f3b6c2dedae26]
stable/5.15: [9f6a276ade936a8803f9f3df217c2368944dc321]
stable/6.1: [aeb44a456d126d89863230eef0187e77e6441995]
stable/6.12: [304a5d72a04a3979a6434088c8d9c5172c2a908e]
stable/6.18: [4f86fb6f9dce04f697da85806ad96a932fc2f079]
stable/6.6: [612ed9224eae70c53c0c88cb0990e0f9b709280a]
stable/7.2: [14dcf4c3d74c878175b19d3da5986f83f26b1dd5]

CVE-2026-98190: wifi: wilc1000: fix out-of-bounds read in P2P public
action frames

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98190

Introduced by commit 4fb8b5a ("staging: wilc1000: refactor p2p action
frames handling API's") in v5.7-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ba6cb7c0868a412c2eb68e8efd5aa38bfb258a14]
stable/5.10: [e98ad9f4c59f2e836f8d971b57763a4277680422]
stable/5.15: [f0c46f8111a479b97b8ab17747c528cade6257f1]
stable/6.1: [a5b827dad8a3037cef04d0240d1c2acb1557101e]
stable/6.12: [cc2ee642ebeac8699b671ddb6d5955a785e5ff43]
stable/6.18: [68b786691ce24c5c94e28811db243e573c50f9c1]
stable/6.6: [491df93b10d76aebaf6aa4bb05a6ba897f4fccfb]
stable/7.2: [6fbe76eb2796d2aee45cc6a2dd16e85d3cc96304]

CVE-2026-98191: wifi: wlcore: release runtime PM ref on regdomain config failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98191

Introduced by commit fa2648a ("wlcore: Add support for runtime PM") in
v4.19-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8a1f3cf89ddcc700e25afe42cfad333059adcc94]
stable/5.10: [85ec6c451fe681ac3135dfa43a519f1404ae63ad]
stable/5.15: [3fbaae01bb7847d8b0124a8bbdb3af865e388d53]
stable/6.1: [c02352e2b5a241c8da89b5f5f1a0ae4d403120ed]
stable/6.12: [18eb148105f1af9163f5e9758f0a7bc6ab042423]
stable/6.18: [7f1f25b2db14683ab75d0d22c00d6a75ba988b83]
stable/6.6: [05b5e297bbf46f92c80da4c2ebe67828ca0d0247]
stable/7.2: [a6bb6ad517a0d4db33a0cac9448e3ae9f4008fb4]

CVE-2026-98192: wifi: wcn36xx: Fix potential use-after-free in TX ack
timer teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98192

Introduced by commit fdf21cc ("wcn36xx: Add TX ack support") in v5.10-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d9be5e75530772fc31637070d51e5717d6aeaa2a]
stable/6.12: [3edabc965bcce49cbb2ec1c2b91f8a555a8ec8bd]
stable/6.18: [2bddc5d088cf430ecd913020472f1def32a36a3d]
stable/7.2: [c0df0878e9110909cf0bec6080d72d36401a0c89]

CVE-2026-98193: wifi: libipw: reject TKIP frames without a full MIC

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98193

Introduced by commit b453872 ("[NET] ieee80211 subsystem") in v2.6.20.16.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [06f42accaf3c6aecab1dcc57f68dde6c06c8b380]
stable/6.12: [9a7fb67364817710c96785ff86b71a2711ee92cb]
stable/6.18: [ac7c08626f67844336086cf563f417566b76f0d7]
stable/7.2: [bb7ae8910cc886885aea95abb7c2e578a2341646]

CVE-2026-98194: wifi: libertas_tf: fix UAF in lbtf_free_adapter()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98194

Introduced by commit 06b16ae ("libertas_tf: main.c, data paths and
mac80211 handlers") in v2.6.28-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bbb9a0ab96d44a64529aafc7a16de460a1712f6a]
stable/5.10: [3fb3663260ec396f86b733aab9f81fac6669d2fa]
stable/5.15: [f6c3fa0d17ca0c9e6033bb45f52e33b27a9a40e6]
stable/6.1: [b4745d6063758c681d33affca9733bbd356b6ea1]
stable/6.12: [2b99bfc5a127ce8cd6a887d82815fc2e712f365b]
stable/6.18: [e82536aad653e27c8ca7a8e0f6f816bc3f853ec3]
stable/6.6: [41b1a4d545ec348b7d5324b6d4f4c6a3e0326d46]
stable/7.2: [04c837d413dc11a91e0275b08b9e35a6c111175e]

CVE-2026-98195: wifi: iwlegacy: fix broadcast stations deallocation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98195

Introduced by commit c2fd344 ("iwl4965: Fix a memory leak in error
handling code of __il4965_up") in v4.7-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b5526b780f8b297a76030410b96ba29153afb98f]
stable/5.10: [275d474a4b4bd4e73b18b1452f12e78806a8843a]
stable/5.15: [526fdd45548e22eee50ee1062abd88269d9f32e0]
stable/6.1: [c9a116d691364cd7f59d8329b395adcaf826d5c6]
stable/6.12: [1d84c2a3de449aceb94ed79eaefecdf1bedb6468]
stable/6.18: [55d34422c0d91436983028fd3c1546a1c2bee55f]
stable/6.6: [85d847ff71fe736cbc15ada321256818e630e205]
stable/7.2: [a9176fe666af1730cab92350f9c8cf67ebf14439]

CVE-2026-98196: wifi: brcmsmac: fix UAF in brcms_free_timer()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98196

Introduced by commit 5b435de ("net: wireless: add brcm80211 drivers")
in v3.2-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1eeca1d5e0920fbdad6449768fd2d4364e714180]
stable/5.10: [10eeb0b29fd7f52487c9ae573e8d79c210a0095d]
stable/5.15: [74acccc928851f69184271832d690607877122af]
stable/6.1: [050d2486e8ed2c0a23b87249ccd23e8072721391]
stable/6.12: [2a4841ff0b74b495cddd31ae324e922217fc2f13]
stable/6.18: [1edb3ddd261e973a4d577c0547e63bfa25a8170d]
stable/6.6: [856dabd5f2617efb23c043be9e1b22a9e6e97c41]
stable/7.2: [777cb6bba59e875b16a1d8897a483a5fecfcd5d2]

CVE-2026-98197: hwmon: (w83791d) remove fan/pwm 4-5 sysfs group on remove

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98197

Introduced by commit 6e1ecd9 ("hwmon: (w83791d) fan 4/5 pins can also
be used for gpio") in v2.6.28-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0ff9c7775e51ac6d47b1bb5c46f06b1434fe58a8]
stable/5.10: [081e3a78453635fb370b1712809d2af29e60b4c5]
stable/5.15: [b1d419eb3bc41245c3d3d99dfe1a7b6c45989586]
stable/6.1: [2ccf6c512290a288a2d4d7f076430dfb0c6ee476]
stable/6.12: [2dd37d00f1f1af8e02ffa70ee573c10fd1a76864]
stable/6.18: [2c381e6e0f033f2df13bd64905e7232c42f49009]
stable/6.6: [f6e2ab72f32d16d71a2549c7ea062dd209f71670]
stable/7.2: [583e04e88e75b8d57304015d83c38e82a9531600]

CVE-2026-98198: hwmon: (pwm-fan) Stop RPM timer before freeing tach data

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98198

Introduced by commit 0169541 ("hwmon: (pwm-fan) Store tach data
separately") in v5.12-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [26d5ff79768548efb1e604bb6e8697c101e06269]
stable/6.12: [1e824fdb14a187ce56697e803b02b1e86243a755]
stable/6.18: [a5ce3fe5335a24d0220958c6866830a6d5fa1cc0]
stable/7.2: [b48339b0a577783e4590a69e4cd2f2760ce33154]

CVE-2026-98199: hwmon: (pmbus/core) increase number of phases and add new mask

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98199

Introduced by commit 2c6fcbb ("hwmon: (pmbus) Add support for MPS
Multi-phase mp2975 controller") in v5.10-rc1.
Introduced by commit f9e5f28 ("hwmon: (pmbus) Add support for MPS
Multi-phase mp2856/mp2857 controller") in v6.8-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [06bd6794b5fd2163880ac3bfe973d4cc61f359f3]
stable/5.15: [272006a52cbd9c8342cead4d3eb9221ebbe8b985]
stable/6.1: [b32607710a20ad983f9fe4a3051892584c0641a4]
stable/6.12: [1ec644c94466834f8cb6b7ba12636fd047bdfdda]
stable/6.18: [9558fc1e042ac6b12dd63c37d2c51be4ec86d402]
stable/6.6: [66368f682a53f3a3842e20eebb571a59809c52c0]
stable/7.2: [b49f100a15b8876deccf8c59f41af92b8e25fd74]

CVE-2026-98200: hwmon: (hp-wmi-sensors) Fix use-after-free in fungible_show()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98200

Introduced by commit 23902f9 ("hwmon: add HP WMI Sensors driver") in v6.5-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e6cb0b4d4ecb8e71fd2200d907ab2e9663356f69]
stable/6.12: [f59ecfd2c58bace39538f3fff7f43788b3fdb539]
stable/6.18: [72c85149794a1ccf8d718ffed1521106b5d31968]
stable/6.6: [b6b2a638aa36c441b2c8d0b6bd8ed2bb9701e795]
stable/7.2: [9c1e65bc79ff104914b11e6ad972139296ec86fe]

CVE-2026-98201: Input: zero ff_effect before compat copy in
input_ff_effect_from_user

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98201

Introduced by commit 2d56f3a ("Input: refactor evdev 32bit compat to
be shareable with uinput") in v2.6.29-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f84819ef8d66931ee3998fee3c4f03230f4cb6cc]
stable/5.10: [ed0905fda39682d3da7937184397d3276abbffa8]
stable/5.15: [ec174c2ab1abb76b20fa167c6db848c3d97aa838]
stable/6.1: [6c26681c5668c973bd0e951407d670ac60d9cd66]
stable/6.12: [b878720e8bcaa4cf7163a5081f904dd6baf11b2c]
stable/6.18: [0d05b43b55d4784a42ce8fb318175f8ad7d9af5a]
stable/6.6: [c5e573bb095d502be7cbbaa99c26a20984111c6d]
stable/7.2: [ed0406e490f48ed180df140fe2a81be26bccb1a9]

CVE-2026-98202: Input: synaptics-rmi4 - fix GPF in suspend and resume
when unbound

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98202

Introduced by commit 2b6a321 ("Input: synaptics-rmi4 - add support for
Synaptics RMI4 devices") in v4.6-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fe10579b6dc3f0dac61e51e1797cacbba5039ac2]
stable/5.10: [7a3d7c68aa36f68e2a4824da4782c0e5d7c4eba4]
stable/5.15: [fafca210631d8c2d4311bdfccc5ec46b9fe65977]
stable/6.1: [84145a4a1dc58f8959811913c5f61f3235dd9f6c]
stable/6.12: [30366f507ce3e408caf7f7375bb343df54b9a4f9]
stable/6.18: [fa1713dc3d43d028d6cb66e5659d9d7e83b73362]
stable/6.6: [e2b6703465c1ce43edb91c1626604b7092b3c431]
stable/7.2: [942b06a19252908d0f952c0590caf20e47f88252]

CVE-2026-98203: Input: soc_button_array - check btns_desc->package.count

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98203

Introduced by commit 4c3362f ("Input: soc_button_array - add support
for ACPI 6.0 Generic Button Device") in v4.12-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fb5022278b6ea7f1838e3ef78028d5d5e3375f65]
stable/5.10: [c3a94bfedfa2e4c4d37d1181e8db1ab010f1321a]
stable/5.15: [ec0576dabd6bf4f6532c5f0a58c9bf57095e45a4]
stable/6.1: [c62c6944c680bc4ae188ca9045daada32fcd10ec]
stable/6.12: [eb5563386fb8c5dbb55d902a71a0ce10e4f307eb]
stable/6.18: [8a70a192e3e5b3ccbeeaf149c931cf45b8e82155]
stable/6.6: [42c7afc0e5f5b5e12e9689e9a9815b5824cf0efb]
stable/7.2: [12d80e6351556cfecbdd09416e5e4c73d6ca08ba]

CVE-2026-98204: Input: rmi_smbus - fix out-of-bounds read in
rmi_smb_write_block()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98204

Introduced by commit 82264d0 ("Input: synaptics-rmi4 - add SMBus
support") in v4.10-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [51cfe54f815ae175c7d1126b983d4d7c89715004]
stable/5.10: [d01337c0892d1509500c727edf81380777c2dd0f]
stable/5.15: [7c800af1c6030a5f27d46ce7d6d5d75f9c1efaf8]
stable/6.1: [29fbcf5834f0a7f74bfd017c07da2411b35a4e2a]
stable/6.12: [e022538e13dd1c82af5ec25ac28f12ca0ab26160]
stable/6.18: [dc05ec97b8299e48e31367a9bc412c7e9c0e2b42]
stable/6.6: [50dd585bee7669eb165e5defcc35d17f3822cfbb]
stable/7.2: [9f0ce5e162eed8b68345abe839c59768bc60f99a]

CVE-2026-98205: Input: evdev - zero absinfo before partial copy in EVIOCSABS

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98205

Introduced by commit 448cd16 ("Input: evdev - rearrange ioctl
handling") in v2.6.36-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8b852965b8eaf910c314dc346967ed82c8d4f235]
stable/5.10: [c0aebb57b73c7d06ad21731099afe119b113c403]
stable/5.15: [89b6ffa4bc10c436fa9aecc73be105124cd58a35]
stable/6.1: [e834e134a32b6a5c600fa539bb49146f617743ab]
stable/6.12: [30b853a3d71f16bd0aa66b604bc37dd1254a19b3]
stable/6.18: [71e5619db11dd6429101bd967230d0321ec5ea26]
stable/6.6: [af5f7130cbf39e6e12336d0b7a5f6e76e4e1526b]
stable/7.2: [3dfe48d5307a1ba22c58231d04257737015569ca]

CVE-2026-98206: Input: cyttsp5 - clamp the HID report size before memcpy

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98206

Introduced by commit 5b0c03e ("Input: Add driver for Cypress
Generation 5 touchscreen") in v6.2-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [85f080fb87ed5cd3e46121be677f52c82f26a0ab]
stable/6.12: [d41a80d852f2948c6d388c520e76c0a72897f003]
stable/6.18: [9eb261092d4c967679fa351b7190c6d9082b07c5]
stable/6.6: [b172c69e67bc71f71f6e3d8b3258b3dec29e42c6]
stable/7.2: [495955feb57750de4a641da13d7e51fb4d0a9764]

CVE-2026-98207: mmc: spi: reset bytes_xfered before retrying CRC failures

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98207

Introduced by commit 061c6c8 ("mmc_spi: Recover from CRC errors for
r/w operation over SPI.") in v2.6.37-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8b0cc8707f65e0f51912e764e1b309b2559db1ec]
stable/5.10: [7d2f0ec16b300645f20435a6c3827b15e01419af]
stable/5.15: [d1acf4b9f6e9697406ce84ee9acfb92e094d5c7a]
stable/6.1: [0b8c8504593409954ed1a60db4e437d814e04023]
stable/6.12: [57f5e29db63f7c80f1805d89234a74dcdbf60231]
stable/6.18: [4885e587f1afa9e1a573ab66f8c4d94d7b836d86]
stable/6.6: [da4929ee78ee701c3717543840798fedff66c430]
stable/7.2: [3ae80c1fb7de4d3331427a955a44807745ac5a33]

CVE-2026-98208: mmc: sdio_uart: fix xmit_fifo leak when the port table is full

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98208

Introduced by commit 8b197a5 ("sdio_uart: Use kfifo instead of the
messy circ stuff") in v2.6.34-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [53823e25793a97d07e6e98e0904bbf74cac8bc76]
stable/5.10: [9e992d59138fcfaa4bad7cc0750265b0a8bca100]
stable/5.15: [b97b5b66c93cb4aaf6358727a73fff880a774dfd]
stable/6.1: [8a2c1bf209ba04cbd14153a771724bd5aa522fcd]
stable/6.12: [fd8223c53ad9553b2a349d2a40e19bbc6e60fc48]
stable/6.18: [ac866db277a4c73e84b4263773652e3aba326249]
stable/6.6: [72f4c2b7a48423c708f2c348585419a1b71ab04c]
stable/7.2: [5e142adbbdc54afbd01fad476c91cded41d22594]

CVE-2026-98209: mmc: sdhci-of-aspeed: Remove children before releasing
SDC resources

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98209

Introduced by commit bb7b8ec ("mmc: sdhci-of-aspeed: Add support for
the ASPEED SD controller") in v5.4-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4396d70bb7fec531bcf934fed016b2f3300c670b]
stable/5.10: [6b22b4d29e4fc1d2de2e4d7174925d68220165fb]
stable/5.15: [67e8117df8547433989a6ac1545a68848d0a289f]
stable/6.1: [bc5e79a5a5651588f3a93bef7815e4e86f78962c]
stable/6.12: [7eb896617a6db846b18596c10ca9f8900a73013e]
stable/6.18: [15b5ffd8af2dd46856da57467eb6e0f90d8ada51]
stable/6.6: [b84d29f2541c8adb768e468388dbaa4bc25ef157]
stable/7.2: [356b4b3b28a8ecd2a6c66d3b9666686315337df1]

CVE-2026-98210: mmc: mxcmmc: cancel data work and watchdog on remove

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98210

Introduced by commit f6ad0a4 ("mmc: mxcmmc: fix bug that may block a
data transfer forever") in v3.7-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d3a421c82412344022982d5b91ba23194a0a6f29]
stable/5.10: [740f595f8ad678cb4d79f13edd12851df2492bdd]
stable/5.15: [d3641afe6ee76d852834a34ef0669eefced32752]
stable/6.1: [314966b490323bdcfd3162a1398b00e587e0ced4]
stable/6.12: [a1ff367e0dc961d73707add508a95df5c3509bd1]
stable/6.18: [23383e0578b58ba2dc0730cf9f7806bd66bf859a]
stable/6.6: [ae10838a7cdf0e54caa9d0a4f488704fd04e7f01]
stable/7.2: [e2948c4232209e87c861a680f20f1e3cf8a57fec]

CVE-2026-98211: mmc: mmci: Fix use-after-free in busy-timeout work

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98211

Introduced by commit b1a6659 ("mmc: mmci: Add support for SW busy-end
timeouts") in v6.5-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b19cf3e50cddaff07b657dae1a8f30f06032852]
stable/6.12: [af6fbf72e899932f330c4e5d0b84d985c922c633]
stable/6.18: [7fecf79f31568de161be14911db10d1251617b01]
stable/7.2: [432b98c1f5daecf04a33c8e1688d26e7ac221e23]

CVE-2026-98212: mmc: hsq: Fix use-after-free in retry work

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98212

Introduced by commit 6db96e5 ("mmc: host: Introduce the
request_atomic() for the host") in v5.8-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5d132990475f02cfa1debe03d50b479432864ebd]
stable/6.12: [df2eb59fd9eb33663dc1053f5a4ed851e0aa1f67]
stable/6.18: [8439bf262ce3267bcfee29d3c61605f1731a2271]
stable/6.6: [c50d6515bffb148c2c12be6d587ec201dfab4c34]
stable/7.2: [45341b341642c377192c95e4d48e0a859cf85f42]

CVE-2026-98213: mmc: core: Cancel SDIO IRQ work before freeing host

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98213

Introduced by commit 6826966 ("mmc: sdio: Add API to manage SDIO IRQs
from a workqueue") in v4.13-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6feadbecdae60a6324c967f3b1493741083793a3]
stable/6.1: [bae1cf4f9902b2065bd78b759c7fe6312855f05e]
stable/6.12: [1d6e7315ee1c992b4ca42c9b11c5ed0e925a00e0]
stable/6.18: [4553b5004eca9c9eae29a421f1a9c4d5db2c9114]
stable/6.6: [0bf3d168a2cc20b120d6b50f0a8ac5b40ff4d589]
stable/7.2: [2a863458828ade0671c2bc2e469bbd7f2340eb03]

CVE-2026-98214: selinux: recheck intermediate backing files on mprotect()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98214

Introduced by commit 82544d3 ("selinux: fix overlayfs mmap() and
mprotect() access checks") in v7.1-rc1.
Fixed in v7.3-rc4.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [78fc54b934bfb2c18aad8154c7302067146946f9]
stable/6.12: [89376fbfdcc1a728e1775f98752cdd90b0930a00]
stable/6.18: [d127c7e1f3e1231d8ac8b2738e3f00bea12afe74]
stable/6.6: [4d50ebe5a27724e020747ffd61a051dec67cb8ec]
stable/7.2: [c2bbb905af2293549651b614a52ad91e0b462b60]

CVE-2026-98215: selinux: preserve user SID across nested backing files

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98215

Introduced by commit 82544d3 ("selinux: fix overlayfs mmap() and
mprotect() access checks") in v7.1-rc1.
Fixed in v7.3-rc4.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [8c0c602202b9a4909b00bc3354e3c0355bc69e65]
stable/6.12: [6aaeec59aadcd1eafc18b049f1b759fb6b9d9569]
stable/6.18: [9d99b770e7b67b00bdef9005b928aad13e1d679b]
stable/6.6: [caa1b913d90d5dc07073733326d2af0f0288f089]
stable/7.2: [ff20d16b2e8230c034e21540043df47222dcc09b]

CVE-2026-98216: IB/hfi1: Fix the PIO_CRED credit-return mmap

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98216

Introduced by commit 1ec8231 ("IB/hfi1: Use dma_mmap_coherent for
matching buffers") in v6.3-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [62f0f34fbd2b2d5653d33d3b9d42fdcabb1c0101]
stable/6.12: [dcebe0b0bb080a25fe08011fd6b6e741f7912f01]
stable/6.18: [180752deb7270ad37394ab6ef7cf4978fad040b3]
stable/6.6: [535530bb2ea5254e1e9f55280143d262dd065204]
stable/7.2: [bafeac9ce5d1ce5256bcf7e5702e831e9aaf419b]

CVE-2026-98217: IB/mlx4: Fix use-after-free on pkey sysfs registration failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98217

Introduced by commit c1e7e46 ("IB/mlx4: Add iov directory in sysfs
under the ib device") in v3.7-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1af874e9f4ce22ccf8b10ab5462f32c70d3be21a]
stable/5.10: [791471421d848ce13e84f4b21c9e19973d471c4e]
stable/5.15: [734f066933484f6c7cedea0312763249beed5845]
stable/6.1: [a07bee32127d7c4cd3b1bb9a088e21d0c93634c9]
stable/6.12: [0c3482e965b18bc242e54e899d1c4d391ca8e5e3]
stable/6.18: [ffb80872617b5f9b3dd1536ec2909029fa66f228]
stable/6.6: [cf20d7476754c00eec04ae23d3e929de33ce0345]
stable/7.2: [ced1186fea7c77e16681c7ef4802897885989c3b]

CVE-2026-98218: i2c: atr: fix dangling adapter pointer on add failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98218

Introduced by commit a076a86 ("media: i2c: add I2C Address Translator
(ATR) support") in v6.6-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ad34235808b63a70ca4989b7a2852923193d06ef]
stable/6.12: [1093835f6aef58a831298d93e0d93f244fa07b84]
stable/6.18: [eabf7a3d33cd9fad106d267d00cc842434de8e02]
stable/6.6: [2f5e42edbd232bf705dc5d3a91e06344237e63bb]
stable/7.2: [a57d9592714506556e30188af72dd3bdb9f647b5]

CVE-2026-98219: sched_ext: Close the pre-enable ops error claim window

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98219

Introduced by commit 105dcd0 ("sched_ext: Introduce scx_prog_sched()")
in v7.1-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c7a1c6e8004ab12a9c9bfdcb603f60f9bf4a3cee]
stable/7.2: [959c66dc4a915be306c35691095c787c61dc7df9]

CVE-2026-98220: sched_ext: Fix NULL sched deref in kfunc sub-sched error paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98220

Introduced by commit a5fa070 ("sched_ext: Enforce scheduling authority
in dispatch and select_cpu operations") in v7.1-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0a85182723b65ad8bee8131bc38fcf0347d6679b]
stable/7.2: [589f0945bf3ebf0790fd51e28c7f0d04ed3d8b78]

CVE-2026-98221: KEYS: trusted: Fix tpm2_load_cmd() boundary check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98221

Introduced by commit f221974 ("security: keys: trusted: use ASN.1 TPM2
key format for the blobs") in v5.13-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [114f00d738f15dd8c7318369edcdc53dd6d08763]
stable/5.15: [cc86227fea28aed86c1fb52a884560b4440da198]
stable/6.1: [b020b447338872440142fe8a57350a483da86b7a]
stable/6.12: [5afa57ea91481c6c49f194b0f5a5c4d96a4d7348]
stable/6.18: [9ddbc5f4bb498aff8096a5231574858a4bffee4f]
stable/6.6: [3fd487c69ad3161e358c33c170bab0cf02a071b7]
stable/7.2: [134825dfc971fbf2b1d0f58f0b3bce8332ad0afb]

CVE-2026-98222: KEYS: encrypted: fix integer overflow of datablob_len

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98222

Introduced by commit 7e70cb4 ("keys: add new key-type encrypted") in
v2.6.38-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8697c431e297eb0d0ab13dda6bc172b48a34f05c]
stable/6.12: [1e720f63dbafc093a8f5d519f05b67724993edd4]
stable/6.18: [a1a98eca102b1cbbc37ff9eaa197ae4e6a3ea4b0]
stable/7.2: [cca38f2102a4cd35eda8d48950df4817b4b24757]

CVE-2026-98223: mm: filemap: retain mapped dropbehind folios

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98223

Introduced by commit fb7d3bc ("mm/filemap: drop streaming/uncached
pages when writeback completes") in v6.14-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [848d2ce2fce15fbdc083fbf9691bfa72911033c4]
stable/6.18: [2897601dffe576fcd87a4259102f41f7fb0cbfc8]
stable/7.2: [77c0fade37c80e8aa16ac048a9828249055e3f66]

CVE-2026-98224: mm/vma: correctly unaccount on mmap_prepare() failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98224

Introduced by commit c84bf6d ("mm: introduce new .mmap_prepare() file
callback") in v6.16-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6cc27d82196385fe06853319f74312a7d8019726]
stable/6.18: [fb5400bff669c8bad3d4ec09287d9b461e89e5f1]
stable/7.2: [8fdc521d438fbf0d22c13d51d55d5dd82d7202b2]

CVE-2026-98225: mm/shrinker: fix bogus set_shrinker_bit() with
cgroup.memory=nokmem

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98225

Introduced by commit fafaece ("mm: switch deferred split shrinker to
list_lru") in v7.2-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [932cfb25e7ce98d1f93895671ec186a3087e4f80]
stable/7.2: [469c12a69ab1842a9090b6c074ffedbfd9584f9c]

CVE-2026-98226: mm, swap: fix SWAP_USAGE_OFFLIST_BIT collision with
real usage count

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98226

Introduced by commit b228386 ("mm, swap: clean up plist removal and
adding") in v6.14-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [12e9ac7bc5b254048f886bf421e3a15491106c1f]
stable/6.18: [0a41a46859df0d2bd7ed127197aac7c7389c00ed]
stable/7.2: [7c0d0d6de46076b43a2acaf1026b6648f8434c39]

CVE-2026-98227: memstick: ms_block: destroy io_queue workqueue on removal

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98227

Introduced by commit 0ab3049 ("memstick: add support for legacy
memorysticks") in v3.12-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [90af7fde083e1b22c349c3a8b1626728e44e474c]
stable/6.1: [0ff795163f37109a134b5a421558530f8d091544]
stable/6.12: [9a2e7cdc0880e735aff0968ee402f2c92a992b9b]
stable/6.18: [6611f78ec3fd4b33a00bfda20725b254a22979f6]
stable/6.6: [19c3da6621a253f1f8b937ed91bc22330a930d9c]
stable/7.2: [f222bb8c30cf5699c560b29179ff2bddcac1f950]

CVE-2026-98228: mips: select CONFIG_WEAK_REORDERING_BEYOND_LLSC from CONFIG_EYEQ

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98228

Introduced by commit fbe0fae ("MIPS: mobileye: Add EyeQ6H support") in
v6.11-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bbc448c541ed90d52f9ec22f17394304e3bf170e]
stable/7.2: [3f017c2ca8c31a1e135dd87be647096866d6b196]

CVE-2026-98229: xfrm: save input state data before secpath resets

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98229

Introduced by commit df3893c ("vti: Update the ipv4 side to use it's
own receive hook.") in v3.15-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3cf5cdecd99c9c186a5ea518d93bbf3045b6e3aa]
stable/6.12: [35de97850987b3d022ed17df5b2577242e746daf]
stable/6.18: [148db154066b066616b82c12d373e786eba1f96a]
stable/7.2: [537a5ae18b2be70f8eb0aca843682e81a69aab91]

CVE-2026-98230: xfrm: use hlist_del_init_rcu for state_cache and
state_cache_input

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98230

Introduced by commit 0045e3d ("xfrm: Cache used outbound xfrm states
at the policy.") in v6.13-rc1.
Introduced by commit 81a331a ("xfrm: Add an inbound percpu state
cache.") in v6.13-rc1.
Fixed in v7.3-rc4.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [2afb8dc1f4390f164db8352f8e685e126e9db566]
stable/6.12: [fb38fb7420d5f7192f9e2b6ac835ede149cd7ac5]
stable/6.18: [4748c27e2e6a1969e02f1df46e62f79d2799b80b]
stable/7.2: [9b74a47a4cbd0d29faff4f3b199212c73e6b6220]

CVE-2026-98231: xfrm: serialize state GC with device state flush

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98231

Introduced by commit 07b87f9 ("xfrm: Fix unregister netdevice hang on
hardware offload.") in v6.11-rc1.
Fixed in v7.3-rc4.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [89fefad9f971bc637fb22373078144f2563c4be9]
stable/6.12: [39e41af3653ee45c985190dd97426f318918d201]
stable/6.18: [75fc4561772e2f9811abf39ed10443e6f4a4bc6c]
stable/6.6: [937108dc0258d6ac69926b00bc53598c98986ee1]
stable/7.2: [84e378395494963b1e581cf223a7cbeec8c0e2d6]

CVE-2026-98232: scsi: core: Validate MODE SENSE lengths in scsi_cdl_enable()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98232

Introduced by commit 1b22cfb ("scsi: core: Allow enabling and
disabling command duration limits") in v6.5-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3d676e458fe0c566f5a62753dc696b6a862fc412]
stable/6.12: [60b0b8ce803e3c2b2a9e5485ab3f88599fb4c7a4]
stable/6.18: [6233d0b3ef4623df0d6934dc8b93b161e9854f6b]
stable/6.6: [39491a1ae93054fea10b4030180e5c797b2c0343]
stable/7.2: [99a6e4a9176da456904b67dcbae6e77d122782b7]

CVE-2026-98233: net/packet: clear RX owner on VNET header error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98233

Introduced by commit 61fad68 ("net/packet: tpacket_rcv: avoid a
producer race condition") in v5.6.
Fixed in v7.3-rc4.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [33ff111d7ba3beb86e28938d6382bb5beabd865a]
stable/5.10: [bb10a0084c03a94364aeec542beddc5d49b59f59]
stable/5.15: [b8c0cb3069058c2d67b5c7c833b2833381ecffdc]
stable/6.1: [2daa618e7ff19eefcbda281bc4c5998c4140f9cf]
stable/6.12: [49a48a5aaf85fe69d2dc3fb334b4854fadf44e39]
stable/6.18: [805edbdcb8681da5f7ee43b3c3c809f7a8c31208]
stable/6.6: [23cd30498891d29a69ec9b75bd92f8a0f21f1342]
stable/7.2: [693209a237fc548791cf402441db8b68d1da7d38]

CVE-2026-98234: net/sched: hhf: cap hh_flows_limit at change time

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98234

Introduced by commit 10239ed ("net-qdisc-hhf: Heavy-Hitter Filter
(HHF) qdisc") in v3.14-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2cef2588c995722a901368def30befeef9ae55c6]
stable/5.10: [7adfd0a42174b85c6bd678858ecd6674f403f336]
stable/5.15: [35fd423a5c5132c6f4321f6c4f0a7b4b90af830c]
stable/6.1: [06d2a101e89063cb0b9b459104db48bdfb0a797d]
stable/6.12: [f3f4a5cb4a6e9b1f1f25d34dfc25f836a1601db4]
stable/6.18: [1731ff1d20489afe4cd01b7d16d37f324746ac54]
stable/6.6: [d8e2f1f0263b7c97b222c06070cccf13e0ab7112]
stable/7.2: [f6547d27ce2093c5627636fb63dd0b7523c466f9]

CVE-2026-98235: net/sched: act_api: release tail references on DELACTION failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98235

Introduced by commit a0e947c ("net/sched: act_api: avoid
non-contiguous action array") in v6.8-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6e05e46fa821a5c1b281355f1f622ac76cb6080a]
stable/6.12: [9eaba16f1b6ee19b249e6afd82c27f958d441458]
stable/6.18: [1be63e4579af408d596f0f3165faf1a880631d3b]
stable/7.2: [57b477e46ef2df3483f3488cc713c61c4b384aab]

CVE-2026-98236: net: wwan: mhi_wwan_mbim: check skb_copy_bits() return value

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98236

Introduced by commit aa730a9 ("net: wwan: Add MHI MBIM network
driver") in v5.15-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [31550d585589fde1ae95bf7f7a8188b2d2fdf1c7]
stable/5.15: [650af68435eaee783824457d2ef78cc5c03c1e88]
stable/6.1: [350fd3125ee26b5243935fd9e2b4d162ffba430a]
stable/6.12: [298659c3677bf622afa9d77549cb4a967f9541e9]
stable/6.18: [02eba5f36d20283f144f75d47f0354a85e4f78f0]
stable/6.6: [dd136f1fdd1059f3bc25ede3a8def8f0ee151ce7]
stable/7.2: [7e98216e9da08b79e07a514d2a4f7646f8c9ccb9]

CVE-2026-98237: net: wwan: mhi_wwan_mbim: guard against a cyclic NDP chain

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98237

Introduced by commit aa730a9 ("net: wwan: Add MHI MBIM network
driver") in v5.15-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5d063822ac5184939c1ed377a339a01d8ae814e8]
stable/5.15: [3ed36ee1b29b028f6bc2ebe100152f61a33df05a]
stable/6.1: [e4b2c7b50d4f4aa1ddfff731b136d65f65b2b526]
stable/6.12: [24ade82d6d993274e99c2c6998848751c35292e7]
stable/6.18: [8dad70ff7e25cbcfbcb5101fdbf36d98003eb653]
stable/6.6: [19b5e8dd884a530d04482e1a8e547f43cad17ed7]
stable/7.2: [829fec45122da58d77a55a3b7ca514dafab98e77]

CVE-2026-98238: net: wwan: t7xx: validate the netif index in
t7xx_ccmni_recv_skb()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98238

Introduced by commit 05d19bf ("net: wwan: t7xx: Add WWAN network
interface") in v5.19-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c7ead9704249d57d4693a04697e3bbd285138fa9]
stable/6.1: [7c2fe308bda5a7e6222d7f0c3c311991372baab4]
stable/6.12: [e1b0609b1a40da03e385be290853a604eb4c3fb9]
stable/6.18: [9dbf13de4edff6fbc1f7ad9c4040326b6ed599ad]
stable/6.6: [fba45070e25abdae08bcaebfadeef050dc39e208]
stable/7.2: [d28aa2de9654e8024922775520a2665e00c04ad5]

CVE-2026-98239: net: lan743x: fix RX checksum use-after-free

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98239

Introduced by commit cd69105 ("net: lan743x: Add support for Rx IP &
TCP checksum offload") in v6.1-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a9ce4053dc945c5372dedba5017ee675b30dc0c5]
stable/6.1: [0e52886c4324c9897c2c62f92be3dc8316cee67e]
stable/6.12: [6fe5c3a2503983abb431d93faeadfc7f5e6a7e33]
stable/6.18: [5c216bfa9fb7b36804485e67975e9c98055b31ef]
stable/6.6: [a58024835c704419bb46d2a34e5223f65605f958]
stable/7.2: [161a403c8625e152de03d1da22bbf9cda6dc9f9f]

CVE-2026-98240: net: ip_tunnel: initialize `options_len` before
referencing options

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98240

Introduced by commit bb5e62f ("net: Add options as a flexible array to
struct ip_tunnel_info") in v6.15-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [455ebeadf714f51e1dbbd6a022c74c9215b1cd76]
stable/6.18: [9907325257b4b382f26aafd5d9a8d47915907dd5]
stable/7.2: [0f6a6beb01c068fcd5274eabf22c260039749fea]

CVE-2026-98241: ipv6: xfrm: use full sockets in local error paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98241

Introduced by commit dd76785 ("xfrm6: Don't call icmpv6_send on local
error") in v3.2-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6973a21ee73c5567f883813c8ef414774b45892f]
stable/5.10: [b1a88633c36d2cbc3831382f3846754d344276fd]
stable/5.15: [904a0e827d0d7189271a3a2eb648293809f25efc]
stable/6.1: [675919e08ce266b8cac11fd9af29170e762a480f]
stable/6.12: [ca3d68c3213475b53db6647e159dc73bd1af5ab1]
stable/6.18: [4c030a0400ebfd2318361c923a88103b2c67c49f]
stable/6.6: [60459c670329d586a58db5d8f811fa5accfe4862]
stable/7.2: [c21f3f7fbfeda7c5794f606cb0ffcc2d9001eef8]

CVE-2026-98242: dma-buf: Fix silent overflow for phys vec to sgt

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98242

Introduced by commit 3aa31a8 ("dma-buf: provide phys_vec to
scatter-gather mapping routine") in v6.19-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b344ca94e8cc85796f16ea25e2e5a8e0303fe813]
stable/7.2: [6b98fd7106d4e486f432664893dcd4d6fa3a9693]

CVE-2026-98243: dma-buf/dma-fence: fix checking signaling bit for
timeline and driver name v3

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98243

Introduced by commit 035219a ("dma-buf: dma-fence: Fix potential NULL
pointer dereference") in v7.2-rc2.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3ed11c671ff7ec58c8fd96410233c677df23f407]
stable/7.2: [a4db25b8949d6ff9c1a685a1273a015e8bab29db]

CVE-2026-98244: btrfs: clear free space tree creation state on rebuild failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98244

Introduced by commit 882af9f ("btrfs: handle free space tree rebuild
in multiple transactions") in v6.14-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3565893cc72cdf6b795cf6a33e7ff9605322334d]
stable/6.18: [a32bedab8ece9d1f90a1476a5b486a1804dc78ba]
stable/7.2: [b1df2997d0cd2be7bef7b4ab64ccfd1019dedc81]

CVE-2026-98245: btrfs: take commit root semaphore when iterating in
mark_block_group_to_copy()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98245

Introduced by commit 78ce9fc ("btrfs: zoned: mark block groups to copy
for device-replace") in v5.12-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0594e3423f4ba3137c734371169491f9a98e9af4]
stable/6.12: [8e2007b263ea250251ec3021a0a197da990ee1a8]
stable/6.18: [709f6a5e986535005110c6c69b322f63631cb200]
stable/7.2: [c32490c6d3f3a9f2d177d57c7eb8bbc347561d08]

CVE-2026-98246: Bluetooth: hci_sync: Serialize local codec list cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98246

Introduced by commit b938790 ("Bluetooth: hci_codec: Fix leaking
content of local_codecs") in v6.6-rc5.
Fixed in v7.3-rc4.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [9a10987a2f160a44a638c9a35994ca6e3089696e]
stable/6.1: [9f407d52c0d881430d689836d3e7d32aa36f98b5]
stable/6.12: [1ee0c5429dc4a92879bda2554b1bfd4abc6c587c]
stable/6.18: [4dc1ae5ff75b17e17ec4b74b11cc4b0099e71e00]
stable/6.6: [560ed4373c06a58123ecdf9ad5ecaddc87a73382]
stable/7.2: [1276c2fafd18499769a28f96f45c5a76d6fc990e]

CVE-2026-98247: Bluetooth: hci_codec: validate vendor codec count length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98247

Introduced by commit 8961987 ("Bluetooth: Enumerate local supported
codec and cache details") in v5.16-rc1.
Introduced by commit 9ae6640 ("Bluetooth: Add support for Read Local
Supported Codecs V2") in v5.16-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d0795cfd6f655f4de84868a4f4bb41a03f037b3d]
stable/6.1: [9c04b9a4d08b95dee901d24b7607c4cbd65fa0a8]
stable/6.12: [e4cfd3c4299105237458b27958bd7b0aa4c60795]
stable/6.18: [f49a543d76d48f184b34225d9c0e2fc4cbdea8ec]
stable/6.6: [a6da782fefae611e68a1aa79644065fc8ca5abcd]
stable/7.2: [12a82819b0cada6e304790b1097f8f9006eb6123]

CVE-2026-98248: arm64: percpu: Fix LSE operations on {8,16}-bit types

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98248

Introduced by commit 959bf2f ("arm64: percpu: Rewrite per-cpu ops to
allow use of LSE atomics") in v5.0-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8cf2093f5372952a9ebc805c418d45df7112cd14]
stable/6.12: [d69ab4480e49bf925f4781afcc9f284affcb96b6]
stable/6.18: [390742871a723b52de9b92a94c0d1c85a2531e3e]
stable/7.2: [843ace1d0a39e9b1cfcbfb3856a7b0fbdd9cd003]

CVE-2026-98249: arm64: hibernate: pass HVC_SET_VECTORS args to the resume hvc

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98249

Introduced by commit 788bfdd ("arm64: trans_pgd: hibernate: Add
trans_pgd_copy_el2_vectors") in v5.16-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [955d86e5f3b95b731991fdb84966c50b16314629]
stable/6.1: [6646418d1032cac25110526161f60d255ed08397]
stable/6.12: [60a3c319f1127c4d247d4ed235c5d65376d5e745]
stable/6.18: [e80ea8118a073a30ebe7a31bd78938c2b1751acc]
stable/6.6: [909e92423db7299e0206232051aa21fe129f65d0]
stable/7.2: [d3f8f773312af69eaf4dda106d76d6d42e4362e5]

CVE-2026-98250: nfsd: fix handling of NFSEXP_PNFS in the netlink codepath

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98250

Introduced by commit da9baa5 ("exportfs,nfsd: rework checking for
layout-based block device access support") in v7.2-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f76017a7663c4ce5e379f8a8d39f032bdb1fd865]
stable/7.2: [30335038d4e25cf017abb0562f4f4eace4f58f96]

CVE-2026-98251: openvswitch: avoid reallocating confirmed conntrack labels

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98251

Introduced by commit c2ac667 ("openvswitch: Allow matching on
conntrack label") in v4.3-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f118c8217c109fd13ca61caa301d72c483897ef]
stable/5.10: [4371d79ea74407fb992c985b1f94391e35bb8289]
stable/5.15: [7ff688aceada1160331a789385ea146f62fbddf7]
stable/6.1: [05eab8dced6bf4d3009a6eeee16ddac99047dc83]
stable/6.12: [2e6dd889c325abf23821e1459c3ffef59b7f0009]
stable/6.18: [d16f089bd700f45d720ce989d5495e1dc3be0cf8]
stable/6.6: [579d87ec1e1e85729a6cb2c25961e58beb78640c]
stable/7.2: [8c9fcc6c33950d3db551af664d1fd3d998bfee56]

CVE-2026-98252: RDMA/core: fix refcount bug in iwpm_get_nlmsg_request()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98252

Introduced by commit 30dc5e6 ("RDMA/core: Add support for iWARP Port
Mapper user space service") in v3.16-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [33fb59da49c4c3f5c2ec9f9d4447a56857a02c02]
stable/5.10: [52c13c63bb3662c108244e7447055e30bf40244e]
stable/5.15: [8a91609032d47e77bcb37bc8f6e88d89340d2709]
stable/6.1: [ce8a379598bd4058081416abea4279fd05a95374]
stable/6.12: [88e429a4e9bac3d2138011c5ca06254331f2587f]
stable/6.18: [e15eb536be4f646ce683d2867572b2200be877f7]
stable/6.6: [2fbac8a56004b6ce54fbfe845d4b25da6e0b55e8]
stable/7.2: [117871cdb8927542abd7b65ce5995bf0265a8c05]

CVE-2026-98253: RDMA/ucma: Serialize join and leave on copy_to_user failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98253

Introduced by commit fe454dc ("RDMA/ucma: Fix use-after-free bug in
ucma_create_uevent") in v5.12-rc1.
Fixed in v7.3-rc4.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [662ade4de9ff5eceb0820a9f8e9fac70ba6a815b]
stable/5.10: [29b9ed83d8bfab5c6e11fcbf1aa836aa4ae26cb9]
stable/5.15: [52172e11bd074ccaded21740ffeb67123f01dd00]
stable/6.1: [01e29d0d78a8f66f221625720a04939eef5ec1f6]
stable/6.12: [43c4e24bd10370fc976f6220518049ce71419399]
stable/6.18: [01cbdb724c584d7772fd25af2e4dfdf8527ce0d5]
stable/6.6: [ae805d204cf1f15b87d1bf3529b4c649f3519420]
stable/7.2: [83610ee5e498fa5bfcb80031d2b959baea276bf6]

CVE-2026-98254: swiotlb: use the adjusted address for the highmem page lookup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98254

Introduced by commit 5f89468 ("swiotlb: manipulate orig_addr when
tlb_addr has offset") in v5.13.
Fixed in v7.3-rc4.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [b7d7914a9ae3097e63d113007e4fb44d33d515b1]
stable/6.12: [6e53b4d6afbde626255805d438cabb1cac482445]
stable/6.18: [aa4709813b29db89f2307f968db5d24925dcdeb1]
stable/7.2: [0219b72f5c209732b2f03a8cc0d7240b5e428a99]

CVE-2026-98255: tcp: exclude old ACKs from tcp fast path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98255

Introduced by commit 31770e3 ("tcp: Revert "tcp: remove header
prediction"") in v4.14-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f81e6c3fb06327bc49cdd6e559845293ba06a704]
stable/5.10: [07cacab90290f795bad2e566790f4ba8e84cdf5f]
stable/5.15: [6eb9b697f50b73b9684e466c1e97f4ca8e947a59]
stable/6.1: [b86e1e5a4bbcbbccde8b7a3d3486604b581f6628]
stable/6.12: [8309dc2cc360056aa9cd2acfbfc25930798c3b66]
stable/6.18: [ff037920c688ae6ca1153fec01e90e6782712455]
stable/6.6: [1c8448db5cf35a13d82b0c9004ffdb49358883e7]
stable/7.2: [8205ac5ddb42a1843fa8d6a8c295b5c7f4f8c6ed]

CVE-2026-98256: signal: Prevent exec() race

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98256

Introduced by commit fb3bbcf ("exit: change the release_task() paths
to call flush_sigqueue() lockless") in v6.15-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d2710c8d938ae6a825a6463158e6e6f31eac792a]
stable/6.18: [621c365739828900f32a0c1cdfe5387528a62176]
stable/7.2: [934bd95f1a6404dbb845951b823547abab05a649]

CVE-2026-98257: rds: ib: use rds_conn_drop() on protocol version mismatch

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98257

Introduced by commit f147dd9 ("RDS/IB: Disallow connections less than
RDS 3.1") in v2.6.37-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f97d8c7bab7843631206a114986c9059da03efeb]
stable/5.10: [424019be3f637da76b74f44a40034669acbb166f]
stable/5.15: [14fb90067d13f4494cff0f03243fae3cf2911cbc]
stable/6.1: [344c72a0bc2703a6de4918ed935850e07dae3af2]
stable/6.12: [d392b16acd0908f077289aad8bba066ff16de336]
stable/6.18: [65ca0a5037152a5a80b8fe6aac80eb80458be573]
stable/6.6: [b5c9f2951d330d4a198a64d6e60f79b4bd6ef078]
stable/7.2: [7d8c22cb2cb1efb5e830a4545c76abf7b35cc2e8]

CVE-2026-98258: posix-cpu-timers: Prevent freeing a timer which is
queued on the expiry list

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98258

Introduced by commit bf63568 ("posix-cpu-timers: Cleanup the firing
logic") in v6.13-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c21eaa72f02fc6e85621cbe09d303d8fb8bd39cd]
stable/6.18: [9971dac1a77845ff467146915fcbb9170f6a8209]
stable/7.2: [4336e3f47d9d516441066e9a65eaf076790d8d45]

CVE-2026-98259: fs/dax: check zero or empty entry before converting xarray entry

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98259

Introduced by commit 38607c6 ("fs/dax: properly refcount fs dax
pages") in v6.15-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8e2b8614039853e68d5338e37821e8bcee9fc05f]
stable/6.18: [44ab7420ab52ab6c04bf225cac7c5c007cedd6c7]
stable/7.2: [185cd2f5fe1e3319853cf065905b2885ad0bcbf8]

CVE-2026-98260: exec: Cleanup POSIX timers right after de_thread()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98260

Introduced by commit 55e8c8e ("posix-cpu-timers: Store a reference to
a pid not a task") in v5.7-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [acb03d3881818581052924a9bbbe92b8741ed448]
stable/6.12: [d9ae467e617ca29b825493a362bf0d75ad5f4ac3]
stable/6.18: [75aa08b93c65766040f9ca99f41ac85ad22596b6]
stable/6.6: [6f1977cea3e85cd8ab55fb337d3e1725fe61d1ce]
stable/7.2: [d602877baf36c43c788a5f472c977e0be414029f]

CVE-2026-98261: cifs: Fix server use-after-free in cifs_chan_skip_or_disable()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98261

Introduced by commit f591062 ("cifs: handle servers that still
advertise multichannel after disabling") in v6.8-rc1.
Fixed in v7.3-rc4.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [717e0a25036b6c92cecace30913b2d874a4c22b8]
stable/6.12: [edd52eae5fcfb8433b6bb0e7cd98db438fe01227]
stable/6.18: [fcc0a935bb6e37ecbf7e4335061309f896f35780]
stable/6.6: [0338489960ddad6368bce55e8adbc176c523093d]
stable/7.2: [7a1b27780b113583a94256d58dabfe7c0d9286e7]

CVE-2026-98262: ata: libahci: clear PxCLBU and PxFBU for AHCI_HFLAG_32BIT_ONLY

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98262

Introduced by commit 105c425 ("ata: ahci: force 32-bit DMA for JMicron
JMB582/JMB585") in v7.0.
Introduced by commit c7a4215 ("ahci: disable 64bit dma on sb600") in
v2.6.22-rc3.
Fixed in v7.3-rc4.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [82e47533221d4746947b74d2e79a478c36c6433a]
stable/5.10: [0191c9ff23ef1678dbfb5ad253a2dee92feb5d71]
stable/5.15: [8f510f68208a1f673d7c7234a687be4671490e9c]
stable/6.1: [4719424bb7cb9f20b73986bcb72dd528f0e5c6eb]
stable/6.12: [b28a17d4a9bb0aa38b48681c3927b012ba40eabe]
stable/6.18: [b691a3e244278362e552439d6d3ee5a5d3703488]
stable/6.6: [a5a8b4737f68bbac8aa0685af0c8921e6003c22b]
stable/7.2: [7912ad8fb5233bb8cfe21d50df639c7f4854ff9d]

CVE-2026-98263: ASoC: codecs: rt712-sdca-dmic: fix uninitialized
stream_config->type

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98263

Introduced by commit 63a5112 ("ASoC: rt712-sdca: Add RT712 SDCA driver
for Mic topology") in v6.4-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [03a5699a0a04309c597683967aaaf25d1e555ea2]
stable/6.12: [c144447c207e2be24d6ac86d544691ba464caad8]
stable/6.18: [d93988c9e58d37b677f6ee8aceae741c8d1e30ad]
stable/6.6: [6507055733a9d397289277408b52daf422f8a814]
stable/7.2: [a318ee718e7448cd6bf62d9b3197b6a6a8d4701e]

CVE-2026-98264: ALSA: virtio: reset device before deleting virtqueues

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98264

Introduced by commit de3a998 ("ALSA: virtio: add virtio sound driver")
in v5.13-rc1.
Introduced by commit 575483e ("ALSA: virtio: introduce device
suspend/resume support") in v5.13-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6c05d00af307560e6a9f1631d6270d3df5aa2272]
stable/6.1: [8edc3669e3e22f0123a1114c3a03df9abc4cd465]
stable/6.12: [500a8401415ab085555785c3c339747e378abd36]
stable/6.18: [3e24b4a6acfd3bedb2200334595facd767c9a897]
stable/6.6: [830012feadc228a938514a6487862dcf56af7e66]
stable/7.2: [f070cce7cb361d5389b18f3ff6bd3d25a7596369]

CVE-2026-98265: ALSA: usb-audio: Clamp implicit feedback packet count
to URB capacity

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98265

Introduced by commit cf044e4 ("ALSA: usb-audio: Update the number of
packets properly at receiving") in v7.0-rc1.
Fixed in v7.3-rc4.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/5.15 stable/6.1 stable/6.12
stable/6.18 stable/6.6

Fixed status
mainline: [76a986c980bb502c7688d605ac7a67fd257a9a1b]
stable/6.12: [ad279ba0dc1781229f5b52f58d38d56960400e06]
stable/6.18: [79c55a7b5d71cf2a6bbd4bd7698e1b10b70f813a]
stable/7.2: [ab77e3f453c5f2499c08d6e8e218501d25bab39e]

CVE-2026-98266: ALSA: core: Fix potential UAF after asynchronous card release

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98266

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fd95e68df6fe66344161a1329cbe5e5805e7b704]
stable/6.12: [5c0df40aa577e405c458e44e8d458dd78407f4af]
stable/6.18: [2dec4642589a663e064e4411d92d6e8fa250d53b]
stable/7.2: [398b21608955c9712a012355b69a39407367edc9]

CVE-2026-98267: 9p: Fix v9fs_issue_write() to update i_size and remote_i_size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98267

Introduced by commit 5fb70e7 ("netfs, 9p: Implement helpers for new
write code") in v6.10-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c60ae98c5aa64021751b38ab1313b19d620bf640]
stable/6.12: [aeb1fe55583836744aef11fbfa2a09122aa9816c]
stable/6.18: [88871ab548c1d7b11cde9b04063f3c1c6fbd7039]
stable/7.2: [9cd92e3392bdd14568e9e44aec1ac05e1fcd62e5]

CVE-2026-98268: perf: Fix null pointer access in is_include_guest_event()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98268

Introduced by commit eff95e1 ("perf: Add APIs to create/release
mediated guest vPMUs") in v7.0-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [88aed0422f39b22406f35f1e758cea25e7bbcfb5]
stable/7.2: [7fa9a465ae8f07c0e4685db6edb6a6f984dbd784]

CVE-2026-98269: btrfs: abort transaction on failure to update inode
for hole punching and reflinking

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98269

Introduced by commit 2aaa665 ("Btrfs: add hole punching") in v3.7-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [97fcd34aa9fd73cefe3120ac9a82ca9d7763922f]
stable/6.12: [834a3b5c5f1ec0df48c1a6208f9989f4ffdaa0b6]
stable/6.18: [9588850bfa75c78ce73c2f6f72544d19d2e9beb6]
stable/6.6: [2605eb9ba3bbd4c9f455cfe6b85bd28a1da7067d]
stable/7.2: [36c68dc909845c049e0286d229bc502947239452]

CVE-2026-98270: drm/amdgpu: check ras and obj before dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98270

Introduced by commit 7692e1e ("drm/amdgpu: add RAS fatal error handler
for NBIO v7.9") in v6.6-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [723d4dc628d764b19cf9efca14b82cca5ff020c9]
stable/6.12: [fc5f845a291fc8175e6857cd6ad042818da192e8]
stable/6.18: [37583946d8751f8e285c467d770ac0b609b82a23]
stable/6.6: [b7c7f07a40037514f8e890aa00f8d7b196d680cf]
stable/7.2: [315c22712715491f0dfafdaf2c2b437540e68702]

CVE-2026-98271: net: skbuff: do not leave stale header offsets after
pskb_carve()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98271

Introduced by commit 6fa01cc ("skbuff: Add pskb_extract() helper
function") in v4.7-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a5117e1eccac6ee3bd4aed7cacf8ebcb6b3eb309]
stable/6.12: [75e4a3e62531738c124c8555a626426fca29d392]
stable/6.18: [bff8a8e53a6d290bc2777bde36d3cb6317b8463d]
stable/7.2: [12929ed66a5166177ef5f06d3da81e4f99993e90]

CVE-2026-98272: net: mvpp2: prevent buffer overflow in page_pool allocation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98272

Introduced by commit 7d04b0b ("mvpp2: percpu buffers") in v5.4-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [14cb1e7702e5cb3c58888f6aed498381a73927d2]
stable/5.10: [5cefdb7acfc646fbded59ae77dfe0aac4c9e4a3c]
stable/5.15: [4ac1d5adc4f4dbafbfd270b55cc6d8bf9849d545]
stable/6.1: [dfd46b5584a5881b131008767950e1ab82713c8c]
stable/6.12: [e7f30dcfa6c64033bf9137362517bd248e5be384]
stable/6.18: [f0e7d62c1eb984dd204095118973c59604144cd8]
stable/6.6: [6569fd85b0ef9a8a6f20b7eb868420b8c7c0c2a0]
stable/7.2: [1734c3fc0066e228ce1c11e434b7c2527f0a949a]

CVE-2026-98273: x86/kprobes: Fix crash when probing CS CALL instructions

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98273

Introduced by commit 6256e66 ("x86/kprobes: Use int3 instead of debug
trap for single-step") in v5.13-rc1.
Fixed in v7.3-rc4.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [a5f7a5bb3b7f28ba7e4fa246775b29a0e5537255]
stable/6.18: [cfc1af3d054aaabee08f1f77c441b3533b082869]
stable/7.2: [d8c6a18c0552135cbf0c696c9019b2979d0862c9]

CVE-2026-98274: net: psp: avoid conflicts with skb->decrypted and
sk_validate_xmit_skb()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98274

Introduced by commit 6b46ca2 ("net: psp: add socket security
association code") in v6.18-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a41f24c612c3f5139a3143307eb85bbcf1bd4d07]
stable/6.18: [a13cca5ba5375f13cbdab545abfb5e288bef3f78]
stable/7.2: [c8c8c18862337c469e325c207601de3279847809]

CVE-2026-98275: net: ethernet: cortina: Ack RX overrun interrupt correctly

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98275

Introduced by commit 4d5ae32 ("net: ethernet: Add a driver for Gemini
gigabit ethernet") in v4.16-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1dd85662fee6e2ac580b1c4f9a0c0a7ae6e31f0e]
stable/5.10: [1163cc82dcbc145f912bf2106ab668762f53e483]
stable/5.15: [12a0c7bb448c1899ea3d8f97fa47a8740044e16d]
stable/6.1: [d72d87926ca33c6766dc73ace46859d7220a45bb]
stable/6.12: [2f23fa11fef9b4a93335894379d82238f0a28228]
stable/6.18: [4f33e036e827f368cdb10bcb15ad098448aca0f5]
stable/6.6: [472493d1d3334d104b9873abc1c2d80ed3b144f3]
stable/7.2: [d4bd670454390aab72ab9fb7b73bce2966c33fe3]

CVE-2026-98276: net: lock the socket in sock_gettstamp()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98276

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9ed55f3dbef4f4adfe65eb03b0c35c53229a8490]
stable/5.10: [18899e2e4023369a8f7739c2255a59a9748d8d17]
stable/5.15: [88c804847dd87dc613b771b392ccecdb94725032]
stable/6.1: [3b12d3967e96f1b7b977d9fc352ae29a1b299a82]
stable/6.12: [1f73253add8365d0dad0a4f421acaa8c21d20cef]
stable/6.18: [d9f96bc2d822501f84d1caa6275a2c6b316ca2c4]
stable/6.6: [17b2a1eb97fdb2a2cbaeab3b146b26797ea9311f]
stable/7.2: [899650bbf985b7bfd2a7b808357df9b16e6d6959]

CVE-2026-98277: eth: fbnic: ring the doorbell if a burst ends in a drop

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98277

Introduced by commit 9a57bac ("eth: fbnic: Add basic Tx handling") in v6.11-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [490599ab23134962a6d18a024e84541d77bdb999]
stable/6.18: [60ef74357a36ed2a102a75bb68d37aa7f305b94e]
stable/7.2: [28fb764d670aa22dcbd2a02fd8fd87ae8d3563a9]

CVE-2026-98278: net: remove WARN_ON_ONCE() from the
dev_fill_forward_path() loop check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98278

Introduced by commit ab427db ("netfilter: flowtable: Add IPIP rx sw
acceleration") in v6.19-rc1.
Introduced by commit d981035 ("netfilter: flowtable: Add IP6IP6 rx sw
acceleration") in v7.0-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [150dba2c69e93302af24a0c868eebe4871e2e107]
stable/7.2: [d8eb177632dacda28bc6130c2105afbf5b791eb0]

CVE-2026-98279: btrfs: handle lack of space when cleaning up verity items

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98279

Introduced by commit 1460540 ("btrfs: initial fsverity support") in v5.15-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [76bf149cd0298544631e756670b89c399c7acbca]
stable/6.18: [4b7ecabd87dc40998fe7870d7975279649229a3b]
stable/7.2: [efa5780b84f066f419a667f6b9542368b2f62074]

CVE-2026-98280: drm/xe/i2c: Disable IRQ on unbind

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98280

Introduced by commit 0bb78ce ("drm/xe/i2c: Wire up reset/postinstall
for I2C IRQ") in v6.19-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f0e9f963a3d209d7dc7ddd61116118ab5da2797d]
stable/7.2: [571ccbc801aa4d22a22d9f924b826c77052330f0]

CVE-2026-98281: futex: Also allocate private hash on vfork()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98281

Introduced by commit ee9dce4 ("futex: Drop CLONE_THREAD requirement
for private default hash alloc") in v7.1-rc2.
Fixed in v7.3-rc4.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [b61b6f95d6722ddbbbd09e689fa41b55fd36f9a5]
stable/6.18: [5468a4855b63b30156a79e5248e01bf1a2c18dd7]
stable/7.2: [eecbafa8cabbc4d1482f6a5e2acc25a8f934681b]

CVE-2026-98282: powerpc/iommu: Fix the overflow validation in
iommu_tce_check_ioba

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98282

Introduced by commit b1af23d ("KVM: PPC: iommu: Unify TCE checking")
in v4.12-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0b271f7d7f5ed45bc498a03ce0aa9cfd8402fc71]
stable/5.10: [98d8dcc4ebd10523507d4478e148809a7771a213]
stable/5.15: [9fd9c9bbb05417f468a11fb6d145d7ff61f4a868]
stable/6.1: [3776bf56e06980e8a12c8c0565d9e6ac44965f03]
stable/6.12: [d48ceb6e1a6915c7bac4f902554a1047365cdff2]
stable/6.18: [0543813753ef5cfbd6fa96694f7acf783fa01af7]
stable/6.6: [d6a1779129d936bc1fbab80181165da544eab736]
stable/7.2: [314091243159f8e3749bc719bb129f423f72fd86]

CVE-2026-98283: KVM: PPC: Book3S HV: fix use-after-free in
kvmhv_emulate_tlbie_all_lpid()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98283

Introduced by commit e3b6b46 ("KVM: PPC: Book3S HV: Implement
H_TLB_INVALIDATE hcall") in v4.20-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [51938dfa8a51a4f85328413fca9b6e21f9d2d088]
stable/6.1: [4d8f7b1f586375df8bce23a0909566ad5e852259]
stable/6.12: [24b634852413229bb8340d908b115c3365f3a247]
stable/6.18: [fbf69b7d0555ee83c871f58750770f74b7179ad1]
stable/6.6: [e37fba1ba69385cff2d0e60b371ee19e7d1852d1]
stable/7.2: [ec2d7a52b3996ae81131617b4afc0af31583c1b4]

CVE-2026-98284: netlink: do not free nlk->groups while lockless
readers can use it

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98284

Introduced by commit 21e4902 ("netlink: Lockless lookup with RCU grace
period in socket release") in v4.0-rc1.
Introduced by commit ad20207 ("netlink: Use rhashtable walk interface
in diag dump") in v4.9-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ceac0de741bfb47ca255eee075257b3bb31f0651]
stable/7.2: [22f313e211d58a66786c81487c3905fa5d4b2a8f]

CVE-2026-98285: net: bridge: vlan: fix bugs caused by switchdev deletion errors

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98285

Introduced by commit bf361ad ("net: bridge: check __vlan_vid_del for
error") in v4.3-rc1.
Introduced by commit 5454f5c ("net: bridge: vlan: check for errors
from __vlan_del in __vlan_flush") in v5.18-rc1.
Introduced by commit 2594e90 ("bridge: vlan: add per-vlan struct and
move to rhashtables") in v4.4-rc1.
Introduced by commit 9c86ce2 ("net: bridge: Notify about bridge
VLANs") in v4.18-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2842ce397dd09882530b42f7fdb0c855767eb24e]
stable/7.2: [ed3ea86db736a30bebf49b947c42730e8451bcd2]

CVE-2026-98286: drop_monitor: use timer_shutdown_sync() to prevent
timer rearming during teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98286

Introduced by commit 9398e9c ("drop_monitor: Perform cleanup upon
probe registration failure") in v5.12-rc5.
Fixed in v7.3-rc4.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [c391a40f71886b28c082b47270f0e856fa3e1150]
stable/6.18: [9616b0c67fbd8cc0b49de7b26cdf2ab33747c80e]
stable/7.2: [bda4d9525fb91a2388ee09669421b8d505290864]

CVE-2026-98287: pppoatm: ensure a writable skb header and linear data

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98287

Introduced by commit 4cf476c ("ppp: add PPPIOCBRIDGECHAN and
PPPIOCUNBRIDGECHAN ioctls") in v5.11-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ecc7253683a3c55caa868ce0ee530fcb0044bd3c]
stable/5.15: [208ccc4d08b1897451e9ba01c016bf93ff107966]
stable/6.1: [e6cd1bba7d113c15c00ac63671213a096fe4d686]
stable/6.12: [8e66c5969acd859ba72fb0a7fa895623fc1b3769]
stable/6.18: [e2f5529b0016db7d34f411408607f5cf395a542e]
stable/6.6: [ffc448eb54f5ba80d4212c1e870cdb92b0f709fa]
stable/7.2: [30992fe39e65589ed8e000425e088fa74994b811]

CVE-2026-98288: net: stmmac: fix TSO header length truncation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98288

Introduced by commit 9edfa7d ("net: stmmac: enable TSO for IPv6") in v4.13-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [15989abd74f16f44bf953d056b95f1d2fda9b0cd]
stable/7.2: [bcf6013c2b4d732c6e4bf4d0f6ae4a18d63d414b]

CVE-2026-98289: af_unix: Unify scc_index when finalising SCC in
__unix_walk_scc().

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98289

Introduced by commit 4090fa3 ("af_unix: Replace garbage collection
algorithm.") in v6.10-rc1.
Fixed in v7.3-rc4.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [4a4263dfeabad72f95e8ab6e15146861fa4144dd]
stable/6.18: [b8f71d69380a5fbc734c868acbeb560f1de1766f]
stable/7.2: [be550ee108ad80828aa61280400bedfc7e7c39d3]

CVE-2026-98290: Bluetooth: RFCOMM: avoid socket lock inversion in
listener cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98290

Introduced by commit b7ce436 ("Bluetooth: switch to lock_sock in
RFCOMM") in v5.15-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [801fb950cae7048eb7d83b18857d1ca37b8cd5a4]
stable/5.15: [eb4adaa46e4c9e6efa7be3ce06398f4d7c39b57c]
stable/6.1: [4aafb47301a799d3e01230d6568c4e93524e1523]
stable/6.12: [c6792c441767256030606eb82dca5d5fc360dd9a]
stable/6.18: [bfce253f039eb5f58b810af267942a9f59207254]
stable/6.6: [c741977e413f5b49d306700820fb55ccb8269f5a]
stable/7.2: [18174b166547ef41973cc19feb5ef9cab39a8def]

CVE-2026-98291: Bluetooth: btintel_pcie: fix off-by-one bounds check
in RX submit

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98291

Introduced by commit c2b636b (Bluetooth: btintel_pcie: Add support for
PCIe transport) in v6.10-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2ea5a87a5a7ae58cb2662b8a7d06f209383e1765]
stable/6.12: [b5214d72bfdf8ef7744d0c8147e6ebb09b36b259]
stable/6.18: [18464860ce27af0dccd2fc72830610b85b518cff]
stable/7.2: [de4c3c72bcc6e8474f70c22427f94ca44bccd890]

CVE-2026-98292: Bluetooth: btmtksdio, btmtkuart: validate WMT event
length before struct access

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98292

Introduced by commit 9aebfd4 ("Bluetooth: mediatek: add support for
MediaTek MT7663S and MT7668S SDIO devices") in v5.2-rc1.
Introduced by commit e0b6703 ("Bluetooth: mediatek: update the common
setup between MT7622 and other devices") in v5.1-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8879e3e0a84a86954c855caceead4867e74a9a27]
stable/7.2: [5a5cfd8488c97e1b8939515429fe4c81e9f2df4f]

CVE-2026-98293: Bluetooth: ISO: Fix parent socket leak in iso_conn_ready()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98293

Introduced by commit fa224d0 ("Bluetooth: ISO: Reassociate a socket
with an active BIS") in v6.8-rc1.
Fixed in v7.3-rc4.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [ca18ee413a7cb6f09885778039225e58bae0d607]
stable/6.12: [9228f87365e68a6cae191f57f456e89a6d2167cf]
stable/6.18: [e2b156a8d25966be49c1f809b654a2c4bb16564d]
stable/6.6: [ea8a262662be62c095789924c11722ecbf40a4de]
stable/7.2: [f016daabd4fec4e9b8563f8b6f42eabce0ca66b0]

CVE-2026-98294: Bluetooth: hci_qca: Do not write to the serial port
after it is closed

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98294

Introduced by commit fa9ad87 ("Bluetooth: hci_qca: Add support for
Qualcomm Bluetooth chip wcn3990") in v4.19-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4e93c65f87825e1e012bce56615320aeb123815d]
stable/6.18: [a5414b0a9464b863733c8bd97493cb443a210ec4]
stable/7.2: [15754e4ec47ac5d117c9609c34a49ed6980ac4a1]

CVE-2026-98295: Bluetooth: coredump: Quiesce dump work on unregister

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98295

Introduced by commit 9695ef8 ("Bluetooth: Add support for hci
devcoredump") in v6.4-rc1.
Fixed in v7.3-rc4.

Bug introduced commit was backported to following branches.
stable/6.1

Fixed status
mainline: [d236517c264e41dc09833c708ef23bccb7a91219]
stable/6.12: [24af375d7d8aa5f698e4dc41317102f44114351a]
stable/6.18: [dcaf10ef27f928568c25de3e9fc242e538de5c67]
stable/7.2: [82699d1b727ba5980b94f1eb8dc3d346f41b7c67]

CVE-2026-98296: Bluetooth: btintel_pcie: validate TX skb length in send_sync

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98296

Introduced by commit 6e65a09 ("Bluetooth: btintel_pcie: Add *setup*
function to download firmware") in v6.10-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4b837ebd0ea21ae5cc26f02dc042edc6fe7b46b9]
stable/6.18: [84f353256e170dc4865d45007d1bc446ed566da7]
stable/7.2: [c298a61e18029401486c40298a50fbeea7e7b663]

CVE-2026-98297: Bluetooth: hci_core: Fix queuing tx_work after
workqueue is drained

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98297

Introduced by commit 525daae ("Bluetooth: hci_sync: Set
HCI_CMD_DRAIN_WORKQUEUE during device close") in v7.1-rc6.
Fixed in v7.3-rc4.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18

Fixed status
mainline: [6610c6fe4b8936c232048e6049bf77c70a6f759c]
stable/6.12: [ab0678a0701ac4de499428dc1b321659bb74d272]
stable/6.18: [e220c1242a643d97102a79f09b7ef3aa31276961]
stable/7.2: [cbb325bc150e8c0dbce004ac0e5516bcffc0de31]

CVE-2026-98298: dmaengine: mmp_pdma: fix wrong sg length in
mmp_pdma_prep_slave_sg()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98298

Introduced by commit c8acd6a ("dmaengine: mmp-pdma support") in v3.7-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [075bc7b1d3dde5ed43fbaabbc1a69f09b7fc3a47]
stable/5.10: [f448a5f5bd10d792440a1b08cf2e8f311767032d]
stable/5.15: [2148db529f082d6e3ca95413bf943442f4ef30cc]
stable/6.1: [d920c07aa6d89ec11afdb6976aafaee9563a5234]
stable/6.12: [88a505330eb06128f7ce79a4c5e4832b7601b3d1]
stable/6.18: [bae65e4925928f77824ca0103122e2ed20ef5802]
stable/6.6: [4a33886057e6d127555efb022879c583e966acc5]
stable/7.2: [54ccc01012a240476edf641bf1a2b8bff54fe6ae]

CVE-2026-98299: tcp: do not let tcp_rmem be set below 4096

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98299

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [83a945a529d6e002dd7339c532288a931f463dba]
stable/5.10: [879907631b9e70eedb62d76461b29afa106ebe7a]
stable/5.15: [8e32532d0fa3191ecf9524b0e6bafa0832e712ba]
stable/6.1: [67b83c15bed9eeeb8d1a6dbf88a5f79525970173]
stable/6.12: [60df201dbb19a1bf6478b56d100f7ae1fe90e46a]
stable/6.18: [7898bda1ebc198f5559b301a96dd5398edd4d4d3]
stable/6.6: [9a4f49bf8d2da4e52e904f60c29cca317bab9b3a]
stable/7.2: [1c4bb940c3bb4325bb88ac1b7eaf5faaa39e7d63]

CVE-2026-98300: tcp: Don't call skb_clone_and_charge_r() for close()d
listener in tcp_v6_do_rcv().

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98300

Introduced by commit e994b2f ("tcp: do not lock listener to process
SYN packets") in v4.4-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8e759cd1f6444a946bd1fd2b2b29eea582eea1d5]
stable/5.10: [a23a3bc5004df6434de05797e0b6b2ecf864b86a]
stable/5.15: [1cb7f292a337fdc72a8219bcd9d40a9cf5e86db5]
stable/6.1: [7d94602e77a4525611afebb23149145ac242afd7]
stable/6.12: [3e3394a13b603cc79b6a35480b8e20df6c716944]
stable/6.18: [619bfbaacbff6a9822923f69f6af29d7f66a870c]
stable/6.6: [b727e3d58cb906f1506c1334dfba71fbb1338339]
stable/7.2: [56d38839ef0bff6526d9bd73b6811bd00316b21c]

CVE-2026-98301: net: bridge: mst: move switchdev call outside rcu

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98301

Introduced by commit 3a7c166 ("net: bridge: mst: fix vlan
use-after-free") in v6.10-rc1.
Fixed in v7.3-rc4.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [18a6fe05fb6e18de29fa90d388bb34044114b3d8]
stable/6.1: [b9661fd2423fc25e91e0517ecc0b6156ad83e3a8]
stable/6.12: [abf734d150c61acfdfee102169d0e5d1c482e285]
stable/6.18: [d5c4ee1fa4e83a12afc051c831936cd8e006cde3]
stable/6.6: [6b431b63219853eef4054e2f1cb073d2ca2059b4]
stable/7.2: [c40ed3e884c8dc0350f26484030438ef24208ff1]

CVE-2026-98302: net: fddi: skfp: fix NULL deref when setting the MAC
address while down

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98302

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7c8810c2e69c3d9ca6df870b40ae9218e50b4fb1]
stable/5.10: [835903bea770ad96ab4322e18d98e00f8e0b39c3]
stable/5.15: [5fd0f401b3eee95c93daa35ef99cb03d676031f0]
stable/6.1: [731db6110b3148331ed8d5d11a564bfd520721d9]
stable/6.12: [616ba18b2cfb72b7bea214bdd72df2485b2e37dc]
stable/6.18: [d6f63fdb298d546a47790cb373db65462c264d04]
stable/6.6: [822903ed991971780db1db1be31a4f00e2b13e30]
stable/7.2: [438131e7ae847e907d345bf504d7e25585561b5c]

CVE-2026-98303: ipv4: icmp: reject RTN_UNREACHABLE input routes in
icmp_route_lookup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98303

Introduced by commit 8b7817f ("[IPSEC]: Add ICMP host relookup
support") in v2.6.25-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2998147b59c9df0a51477c7a6b3d1f0ba3127dd4]
stable/6.1: [06083cea4a3b95f5ebc85312f97d7086e6c9e782]
stable/6.12: [cac69c50716c712ef0114837c9427da66066124c]
stable/6.18: [1af2d87964d87ba7626d96928d68c09158b5a223]
stable/6.6: [83aa83f81a8fec30ff5372dee60b2f0561bcb2ca]
stable/7.2: [fda3000147dc96c75ba162f680bec0a9fecf3037]

CVE-2026-98304: net: bcmgenet: restore the hardware filters on open

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98304

Introduced by commit 3e37095 ("net: bcmgenet: add support for ethtool
rxnfc flows") in v5.8-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [23ca4ddc4fce2c233a49e9fd34d4b5b02bd7324e]
stable/6.18: [56db7ec462d6a2b886e299ad835109c089606969]
stable/7.2: [906140955c8debde65afe12e594e04c49a61b0d9]

CVE-2026-98305: net: dsa: mxl862xx: disable the stats poll on teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98305

Introduced by commit a21d33a ("net: dsa: mxl862xx: implement
.get_stats64") in v7.1-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9e92ad4630f5dd1838ce6bbe6b1bd2c73d34de36]
stable/7.2: [97df811a11d4f76bc2ffe67b6bf730263f56c668]

CVE-2026-98306: seg6: set IPSKB_L3SLAVE from IP6SKB_L3SLAVE on IPIP
decapsulation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98306

Introduced by commit 891ef8d ("ipv6: sr: implement additional
seg6local actions") in v4.14-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7616242a2b37883f7322aaa1d2bd6cd0fed28315]
stable/5.10: [1d9f5c78903dd25a3556229eb716dd465c5f3573]
stable/5.15: [72f410616000d21a0a6ec6c93a60301b9c92e95c]
stable/6.1: [e4d7c52f15f572608374947c6c802052e1a2fc82]
stable/6.12: [f8fb4738ccef5f9d107845b05734a56352747b1a]
stable/6.18: [ddf60220c925b54a1714c4722fdbdb12833232d0]
stable/6.6: [5130afa025c95faa621adf8bac525baeb2b290d2]
stable/7.2: [8c16e1ccc082a3763dfc6bc2d3f658c1a6336f9d]

CVE-2026-98307: wifi: ath11k: cleanup arsta in ath11k_mac_peer_cleanup_all()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98307

Introduced by commit d5c6515 ("ath11k: driver for Qualcomm IEEE
802.11ax devices") in v5.6-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [820b8cff81c796ba20573e04722ab62500713f97]
stable/6.12: [c4108dce0838ec7d38d782f76f9c007cfe2fff45]
stable/6.18: [57bc3cd46458eafa1c38e3044a61b7399cde7642]
stable/7.2: [be1d5e95ec499ed5ee9704aa27dd1407ccf0d0ac]

CVE-2026-98308: ALSA: hda: trace PCM open only after assigning a stream

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98308

Introduced by commit 1848650 ("ALSA: hda - rename hda_intel_trace.h to
hda_controller_trace.h") in v4.2-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c9e6e5f38bf75276605f1952b22285f5f3abcaff]
stable/5.10: [5a4c974dee03cc46eac43c82f33e34ec94f0b348]
stable/5.15: [fba079ea22822248c82c3a999c88676d05b17bda]
stable/6.1: [3c6ca6d9342f4a0be7c1413180e11023d13b5cde]
stable/6.12: [5c89e7965220e85d06ae4c58adb7d7bb6da2440c]
stable/6.18: [8477643cb91c9e09ac1b11890eef421ae63e53f7]
stable/6.6: [0a52ba6d3b268bb82f0ec4cb861bc68d252369c0]
stable/7.2: [3db8afba2d210b7d80cd5cc6b76d7f46daa9b47a]

CVE-2026-98309: drm/vc4: Use managed KMS polling to fix UAF on unbind

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98309

Introduced by commit c8b75bc ("drm/vc4: Add KMS support for Raspberry
Pi.") in v4.4-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [073a30d75f309812ed61af134f24ffef4107b13a]
stable/6.12: [cf0c4432bda37b02e7d430ff5017228ceb7caf0c]
stable/6.18: [ee507691c18f9fee5d4751e295ab9a7ff31d59ae]
stable/6.6: [b6beee927e7f4e3142032ff91b2d0417cdddc0f6]
stable/7.2: [7f9780df677370a19b4ec9764f13b1b82073e0d9]

CVE-2026-98310: drm/xe/shrinker: Take a runtime PM ref before
shrinking non-system memory

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98310

Introduced by commit 4e7ebff ("drm/xe/xe3p_lpg: flush shrinker bo
cachelines manually") in v7.1-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [985862be16c7e4da808c51f393d631fb60c0be5c]
stable/7.2: [b7f4d2588b1342bb190c04b3d7a32560f206c74c]

CVE-2026-98311: wifi: virt_wifi: don't transfer operstate before register

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98311

Introduced by commit c7cdba3 ("mac80211-next: rtnetlink wifi
simulation device") in v5.0-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e5c8d7acd31b27057ea42cd405d0b3ece097bc89]
stable/5.10: [ee9ea1afd6990def51d52b3a0aecd5cfcc951da0]
stable/5.15: [9ce26201f6dedf3fa02b97da8c67ee6f6c5f7225]
stable/6.1: [f9526054c2b2cace5916b7225603d008834ec011]
stable/6.12: [ca49763c42c1089d654bf11b037980a9ede3772c]
stable/6.18: [293c56a66510bb7de073a1aba388e38abddff1fb]
stable/6.6: [e8304e25c6dabb8accf38b807969438d0ce84fd7]
stable/7.2: [b808a9af5fd21f9c68b0d024eda7535b5dce6a4e]

CVE-2026-98312: ALSA: 6fire: fix OOB write from device-reported iso length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98312

Introduced by commit c6d43ba ("ALSA: usb/6fire - Driver for TerraTec
DMX 6Fire USB") in v2.6.39-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1589afe2d099d3e817873bc474676968d7080410]
stable/6.1: [61e665fb48e9eee44ec6d610514af383b1802cc1]
stable/6.12: [001ba7c1d9677225a5ecbc3e60d4865c08bb21d8]
stable/6.18: [ea11ade10583cc45af515d6b24510dbfa0184ca6]
stable/6.6: [246de677552fe5dede293a1543b632e9853f31e4]
stable/7.2: [cdc31537012bc7a58c95c6750db321b69dd802bb]

CVE-2026-98313: drm/msm/dp: skip PUSH_IDLE when the link was never enabled

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98313

Introduced commit is not determined.Fixed in v7.3-rc4.


Fixed status
mainline: [e249a6e2a130c08bb4d8b0a55cbe29754307e5c9]
stable/6.18: [dc57147549a10c99766144cde265645287718ff7]
stable/7.2: [5e97d117b79c3ce89542369ef697be64850de8ad]

CVE-2026-98314: ALSA: pcm: set timer->private_data before registering
the PCM timer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98314

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1e713f9bb2ac583521f06b0eb4e22440b1e3d078]
stable/5.10: [27f167e117eca310661fbcbacb352ea08face067]
stable/5.15: [555d168bd98daa46daccc68c908201388c834293]
stable/6.1: [8c869d5cf5affb20994bdbb60e7d46d65c91b55f]
stable/6.12: [e1eee8f16628f8b6bcae0a366fd6a2dd65e71edd]
stable/6.18: [d63f5a9f8121fb43c798056d7dd34c58f47185d7]
stable/6.6: [686c7a6af1eea8d2a919303e4c6bbec3de79dbdc]
stable/7.2: [0b349249d572633d7c8cdeb917623d1676a2b7c3]

CVE-2026-98315: ntfs: protect runlist updates with the runlist lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98315

Introduced by commit 495e90f ("ntfs: update attrib operations") in v7.1-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [91709ba5d6d709b2b663287b7e871e2c6b480502]
stable/7.2: [742797432e8c9b0dd54ecc523c185e26b09d79a0]

CVE-2026-98316: ALSA: bcd2000: Fix race between rawmidi and disconnect

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98316

Introduced by commit 459d3a6 ("ALSA: bcd2000: clear the URB pointers
on disconnect") in v7.3-rc1.
Fixed in v7.3-rc4.

Bug introduced commit was backported to following branches.
cip/6.12 stable/5.10 stable/5.15 stable/6.1 stable/6.12 stable/6.18
stable/6.6 stable/7.2

Fixed status
mainline: [221253723dc58bb901c3f27a7659823e63fc598c]
stable/6.1: [3b824930259d54f5047ce6b5c97bd20db2fc2b98]
stable/6.12: [0a7ecf52cb59ed77ec525deb52c496ea8fba10b1]
stable/6.18: [812ca56867bec3065c2a27f1ff5ce04e2a8bf4f0]
stable/6.6: [c83d6b0a65f7b71bbabcc91c045dfbffdff6ae76]
stable/7.2: [9c8b6eff6e7505c128b615d9a1364ef66fa5c18e]

CVE-2026-98317: neighbour: Enforce min/max to NDTPA_INTERVAL_PROBE_TIME_MS.

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98317

Introduced by commit 211da42 ("net, neigh: introduce
interval_probe_time_ms for periodic probe") in v6.0-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6d79b223ec44ada58ad37db42f539b60985a7722]
stable/6.18: [982c7f66c04134b77126edbfd8a63ecd6928cfd9]
stable/7.2: [8550b50e49b01b572e653e572f24ddd73949aa74]

CVE-2026-98318: smb: client: validate absolute native symlink targets
before NT fixups

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98318

Introduced by commit 3363da8 ("smb: client: fix native SMB symlink
traversal") in v6.16-rc5.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [23c240d9509e15f72e4112fc95f0160ab32ec430]
stable/7.2: [6913ff607c2bc8694193e1fcc40bf16d75f35f16]

CVE-2026-98319: drm: Fix drm_pending_vblank_event leak in error path
for out_fence_ptr

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98319

Introduced by commit 92c715f ("drm/atomic: Fix double free in
drm_atomic_state_default_clear") in v4.10-rc7.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9eb1a393c89a79c4210230d23e7d88d239c61d7b]
stable/5.10: [3d6576ed3de01e8a378397b7020e33ae3d40aa6c]
stable/5.15: [86c33f740aa27e9cdc1259f0cc59c9c58f545e4b]
stable/6.1: [88c450e23b8fd4f1dcd329562f5e81ef05f3d941]
stable/6.12: [d0be0516b5224eb5b6f42f8564a8deadb20ae16b]
stable/6.18: [daefd7ff159b0d1fb8c9e64430dcbe2aca1bdd09]
stable/6.6: [780716e2e019186fa6e5aad097a44b87b0b5388f]
stable/7.2: [b9a68a9ccaada15d8dd0102c188cc6b868ff800b]

CVE-2026-98320: netfilter: flowtable: hold reference on ct until flow
is released

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98320

Introduced by commit 0ff90b6 ("netfilter: nf_flow_offload: fix
use-after-free and a resource leak") in v4.16-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e75a9fa1d44bcbd66ea02e8781bcca6ea4076e0d]
stable/5.10: [93ff1594be1aad4da364462dd8db050ebcfda2de]
stable/5.15: [eed6997e8dc40593a539fcc722e7ed51b18db86c]
stable/6.1: [61c6688be282277c6e91ab286a7acd0ae8681ac6]
stable/6.12: [8274cdc5f9c57e17ed77fc4ba76212536c840f25]
stable/6.18: [12c1ac230f4ca16e0017b62a963ab75e0b48074f]
stable/6.6: [a43cd2b67b91e943273c913237a7a88c50cdcfbc]
stable/7.2: [d9e6175a3ee48209ee65f294fc567b4e16b29b74]

CVE-2026-98321: netfilter: nf_nat: unregister and release hooks on error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98321

Introduced by commit 1cd472b ("netfilter: nf_nat: add nat hook
register functions to nf_nat") in v4.18-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cbdd39ce42530a193c56beb206a3356cb6d01016]
stable/6.18: [79084567cd082fb4482e1ea457580e7d6504dd99]
stable/7.2: [df80342f4bfc023ad7d6703df5e27f583ff0cb8d]

CVE-2026-98322: netfilter: nft_nat: fully initialise new_addr in netmap setup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98322

Introduced by commit 3ff7ddb ("netfilter: nft_nat: add netmap
support") in v5.8-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d313499df66159b4b7971d760d16729598ab7e5a]
stable/5.10: [29365695842db0a97b701a43a09fad1b4f7ecf3e]
stable/5.15: [7b9380c38c2fd2189416fa602bdbc5c8523b84b2]
stable/6.1: [eb2030137dba3b59cbb5057a33af70488d6bc231]
stable/6.12: [161f5860c92a8ec80b6bdff16e79d70dcd8afc5a]
stable/6.18: [0ce42c7b84032335abff9eac43762e4ca8224451]
stable/6.6: [e4982c489ee359162eee3ece1fb36082648464a5]
stable/7.2: [1c43f5db482f74b41987c39c9c375a5e767556eb]

CVE-2026-98323: RDMA/siw: Bound fragmented header copies by the remaining length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98323

Introduced by commit 7542098 ("RDMA/siw: Always consume all skbuf data
in sk_data_ready() upcall.") in v6.1-rc1.
Fixed in v7.3-rc4.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [9ff797e516dbc1ecb73701ec4c24055712d44411]
stable/5.10: [2c6fbcf4bfac0b2b186acc8d91154c0fa24468a7]
stable/5.15: [af9f5b474a260ad23ffb9793d716a5e3bbce3b48]
stable/6.1: [262dcd809723723ed8a4e05437ec7e9c21a8f17e]
stable/6.12: [8628f8ebf41669302513fb3f0bf0eba38b226742]
stable/6.18: [b72dcfb9bf1f0f0147cda03dc59e4002a315067f]
stable/6.6: [eb4d7a946970469b3ab0c762432bf161d5b0836c]
stable/7.2: [e6bdfdf3bcb02d0d626a45e8c98b7e63d2fddf9d]

CVE-2026-98324: dmaengine: pxa: fix double counting of the hw descriptors

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98324

Introduced by commit 69050f8 ("treewide: Replace kmalloc with
kmalloc_obj for non-scalar types") in v7.0-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f6504be006aa4bb4bd26285f410a885c17920d65]
stable/7.2: [1de93785f32b450e9eae1e4fcfb7d03eb49eb27e]

CVE-2026-98325: wifi: mac80211: set up the TX info early to fix failure paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98325

Introduced by commit c3e7724 ("mac80211: use ieee80211_free_txskb to
fix possible skb leaks") in v3.7-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [50d3d79dc0743b616afb00d01a626c76758721f7]
stable/6.1: [df711e9fa20d7e996711c7f43a11a71805bef78d]
stable/6.12: [36e6f0a5e6d7238f4023e77f423c1c1414374309]
stable/6.18: [0fb37d2b6cb829cebdaea80f39011469f474bdcc]
stable/6.6: [420fcc2fdeae6ecd682d2b1605a0a54c88aed4aa]
stable/7.2: [03d67414bd05b86029afc14535238a9393eac1c6]

CVE-2026-98326: wifi: mac80211: mesh: release the channel if start fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98326

Introduced by commit 2b5e196 ("mac80211: cache mesh beacon") in v3.9-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ae97fff6495a8764bc0ef281cfe5444f701e527f]
stable/6.1: [f0afcec2129c166e61821d6ae097061155f01b12]
stable/6.12: [632f7acfe6dac1278a9314eaaab14fada400ddaf]
stable/6.18: [41bee71112db53651ba9a9030de1b843255a4a7f]
stable/6.6: [b51f5a310bd6888b90bb9546a8081215dcfe6fbe]
stable/7.2: [4a4e3fa77ea36d3419d806fb5883ef425a605a5d]

CVE-2026-98327: wifi: mac80211: mesh: reset the CSA state when leaving

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98327

Introduced by commit b8456a1 ("{nl,cfg,mac}80211: implement mesh
channel switch userspace API") in v3.13-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [860134b3af77970e006feab7e5decb8c84771c7f]
stable/6.12: [aba8dfb45864441199748c33ce3c1c8ca121c8bd]
stable/6.18: [bd3b21145ae2e781daac1bbd19216a63ab4e0cbd]
stable/7.2: [ba5bf83a81e8832cb84bb3a2da67512f81f57a02]

CVE-2026-98328: wifi: mac80211: add HE 6 GHz capability in the scan elems len

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98328

Introduced by commit 2ad2274 ("mac80211: Add HE 6GHz capabilities
element to probe request") in v5.8-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cd54bf333f5631d3630bab0a832e9ae648f73515]
stable/6.1: [db19d5414227d86cee77a000607a6710d7f36853]
stable/6.12: [8659bd6c4c852096b6621086d1ea38eed84b454a]
stable/6.18: [ad5bd0f6a0c337a80c141ea8e6c7a1d9c145be79]
stable/6.6: [be7bfdea1ec9b672a80c736bd6ed932e1adebef8]
stable/7.2: [9d83c08dcce808c732988a5291e3ef4f59d09edb]

CVE-2026-98329: wifi: mac80211: don't allow injecting frames wider
than the chanctx

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98329

Introduced by commit 646e76b ("mac80211: parse VHT info in injected
frames") in v4.7-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e14bf37bb2b3853012ff160131d1c6233f7a9cc9]
stable/6.12: [a5c715eda066cba5ce3372759188ba8636dca629]
stable/6.18: [73f48f7e16cadfc74f444ccd10c1d3ae253e2e27]
stable/7.2: [c69718519a81e87284494d0c6e6eb7bdd834707a]

CVE-2026-98330: wifi: cfg80211: get the wiphy out of a dying network namespace

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98330

Introduced by commit 463d018 ("cfg80211: make aware of net
namespaces") in v2.6.32-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4635b1a1c1d693178a537446a6e09963f0fdae52]
stable/6.18: [caa02072b2986d4b0e7a824de05782ef7b03a0ba]
stable/7.2: [b949b2720688691f1e41bdbfbe3df2b6dc77c34d]

CVE-2026-98331: wifi: mac80211: unlist vifs when their netdev is unregistered

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98331

Introduced by commit 463d018 ("cfg80211: make aware of net
namespaces") in v2.6.32-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eee2efd82867b623982ac51925b5a1812a74c50d]
stable/6.1: [a22c02863439993095acd0c3db97fa53cd515f4f]
stable/6.12: [b735ad1a9aca6080192c1316cf2706e5e1318762]
stable/6.18: [d45bf731ec7085d2cc2c5d179d3b3b6c743d4fb1]
stable/6.6: [20a56e96a6f7b4dfbd13f8732fd2673409fc7ba0]
stable/7.2: [821bab0456dfca12acef6df702c8f2477d313227]

CVE-2026-98332: wifi: mac80211: only operate on TDLS peers in the TDLS code

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98332

Introduced by commit dfe018b ("mac80211: handle TDLS high-level
commands and frames") in v3.2-rc1.
Introduced by commit 17e6a59 ("mac80211: cleanup TDLS state during
failed setup") in v3.17-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6f0a100df8539ce90f37c14e1945f396ca2410bc]
stable/7.2: [0cd452ccaa5c5971440256ce72c64611eca176c1]

CVE-2026-98333: wifi: mac80211: reset the LED state when ifup fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98333

Introduced by commit 67408c8 ("mac80211: selective throughput LED
trigger active") in v2.6.38-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [78183e8331958fda11cd2b6850bb424a9747c4b2]
stable/7.2: [de6f9561db572df86d65c05545eb2397313bb8a5]

CVE-2026-98334: wifi: mac80211: reset state when starting AP fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98334

Introduced by commit d6a8322 ("mac80211: track enable_beacon
explicitly") in v3.9-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f28551d0241254a75626d868041c6340285088b]
stable/6.12: [d83da43e9b3b3b1bad99ac5a1065f1c63ad5fc32]
stable/6.18: [5d5ff5b36f5748a2a077f875a73ccb26860d3fcc]
stable/7.2: [6eac225f59c1c2277ac74f8a716d6df0ba3b8d28]

CVE-2026-98335: wifi: mac80211: abort chanswitch when leaving a mesh

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98335

Introduced by commit b8456a1 ("{nl,cfg,mac}80211: implement mesh
channel switch userspace API") in v3.13-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ac7472a24bd433b81c06582835dd1d5547c10da9]
stable/6.12: [bc544ef02327edf61c94d2b6bae9d14b217009b2]
stable/6.18: [2e1d6e80148495e728a85a9250176f266312e55c]
stable/7.2: [d222fdc973bb8dbf0357772bd9042ffdc8291939]

CVE-2026-98336: wifi: mac80211: don't offload TC setup on AP_VLAN interfaces

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98336

Introduced by commit 61587f1 ("wifi: mac80211: add support for letting
drivers register tc offload support") in v6.4-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [362bd5bce29ed0f6fd3d39a7065567777d70606e]
stable/6.12: [40bc8a268c3b6e21fa3a8dd1b4fd85aa905b9718]
stable/6.18: [9c34f01b8f2177dd4e1ee524ca1f9ca3fcd85a11]
stable/6.6: [790221efbfece13a2347563b3785aaca48f192e2]
stable/7.2: [ea3ef2165e4751df2ee3bc1c07a192243a08faa5]

CVE-2026-98337: wifi: mac80211: don't start a ROC while scanning

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98337

Introduced by commit aaa016c ("mac80211: rewrite remain-on-channel
logic") in v4.5-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [733f0fde95392ed5f61a4e36aee661ea8d0e8581]
stable/6.12: [5dc8ec2f8d1d62914661577c23ec151f5c9734a4]
stable/6.18: [81baab8b645ec532bad2b7a8464191c720ef8fd9]
stable/7.2: [58b806f699052c572dec6cab2c376f884f27e98f]

CVE-2026-98338: wifi: cfg80211: ibss: ref BSS entry for joined event

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98338

Introduced by commit 667503d ("cfg80211: fix locking") in v2.6.32-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [708f9d43d6a2eb9c6b83fe62af628de9dffd9314]
stable/7.2: [b0e3f019e461ac42e45aa3ec1216cefaca2f4a8b]

CVE-2026-98339: wifi: cfg80211: don't filter by BSS type when removing
stale entries

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98339

Introduced by commit 0afd425 ("cfg80211: fix duplicated scan entries
after channel switch") in v5.4-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b377e1000d963e7182a987082b4b06580bd7ac84]
stable/5.10: [6ef87a853327434ae1cd9c5a2c27a557fb4047fc]
stable/5.15: [1380ee3a202dbb9f8e8b3c3b87eb410450d57799]
stable/6.1: [fb445ec7480da5d2b82bf681e3b4313603722729]
stable/6.12: [64e23a36d8f04811372365b44cfca325f8e0f4bb]
stable/6.18: [6d2fd26185678038ef2ea11dd4d2e6eccbf2dd25]
stable/6.6: [65fdb973bd905bc3f5cb045a04c1828f2d2a7e24]
stable/7.2: [0aa44982125c86b47961be5ac1c82eddab8080f3]

CVE-2026-98340: wifi: cfg80211: only group hidden BSSes with beacon entries

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98340

Introduced by commit 4593c4c ("cfg80211: fix BSS list hidden SSID
lookup") in v3.9-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [068843ed0902c552a13860c5ec6b2ca65b57a065]
stable/5.10: [4cd6a518ce7527284bbc9baab5fa2453a7d477c2]
stable/5.15: [74ed0d992f392c75e1969415527e06df3f7a4034]
stable/6.1: [3658093df69849daf4f813a8f087f358e13be203]
stable/6.12: [7405dd19bda4537a2843637d8d7bed1efd4776cf]
stable/6.18: [86235be788094131912e9bd8412b358d91d99f49]
stable/6.6: [73365b81630b57e1a1f9d50dc87281797855c2ac]
stable/7.2: [332ea1502c46f53375cb109fa82bfaff818f3a41]

CVE-2026-98341: wifi: cfg80211: don't free driver-owned scan requests

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98341

Introduced by commit 4a58e7c ("cfg80211: don't "leak" uncompleted
scans") in v3.14-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dab68a74e90b8e07f08ed9deaa5884857a3cfe89]
stable/6.18: [e8c75736cfd0c6c87562cda2312e3fe5e2227955]
stable/7.2: [cf6da29d17994865f73ca70976495ea856909c63]

CVE-2026-98342: dmaengine: wait for RCU readers before releasing dma_device

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98342

Introduced by commit 2ba0562 ("dmaengine: provide a common
'issue_pending_all' implementation") in v2.6.29-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dc750422170a563c7a81f6e49d36bb02c62ae37f]
stable/5.10: [ac8ce9f89638d6d79875cca7d8ae42566a9bde15]
stable/5.15: [14578c78405d51fa92e4ada4502a45f537c0fcb8]
stable/6.1: [cbb3310a5167e868a5e763e32b9a23b4d50669ee]
stable/6.12: [4448a539a0c39141cccc67be6cacde0f35024313]
stable/6.18: [fc1f4884f1d46fc7a8cee6e2997ecc9e8d1c7f77]
stable/6.6: [8577a5ec4f7e00443015ef99f646def093121a1b]
stable/7.2: [4aed7e47a10b94ea3c5171e8d1382081accd2e03]

CVE-2026-98343: dmaengine: fix use-after-free in dma_chan_put() and
dma_release_channel()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98343

Introduced by commit 8ad342a ("dmaengine: Add reference counting to
dma_device struct") in v5.6-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e873c74132f0c5f1452816cd9bb26208f0bba1e1]
stable/5.10: [b92c502595336a3cc5bb7a060170891366745a5d]
stable/5.15: [855187a88bdf762c46b6849307597e3e02bfc1d9]
stable/6.1: [c9780b601438137494b407eb4301bb3de2587ac9]
stable/6.12: [9319dd64d5cdef851841c091f30424faa2284c31]
stable/6.18: [6cf31716b77a71c0d634106f4f3951377b8dc6dc]
stable/6.6: [07eb075b60d565a5e465a1945a80cc62807492ad]
stable/7.2: [02bd02c585293634b213b142cba63cbf77891f6b]

CVE-2026-98344: dmaengine: Fix device kref underflow in dma_chan_put()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98344

Introduced by commit 8ad342a ("dmaengine: Add reference counting to
dma_device struct") in v5.6-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [44dab659064eb5c10adb0306510eebe848ed592d]
stable/5.10: [036b527f92570206da4b8c40b38f8d689e29d0f3]
stable/5.15: [5fb1797a8c9485e40e5492fa0338ab5c7d1f3fef]
stable/6.1: [57f7f1c6827be7d8f80feca48d2125fb91c6f6ed]
stable/6.12: [de2677e57d3161390d8a508f08cddec6ef7e4b23]
stable/6.18: [1a0d9b406febf23054ad595fd47b29325e70fb2d]
stable/6.6: [7c3f4ce651d43705f9ec7f778f642a90d5ff4fba]
stable/7.2: [77906ac448d2fa81fa710ae26c0e591ebdc81154]

CVE-2026-98345: wifi: cfg80211: check IP header size in cfg80211_classify8021d()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98345

Introduced by commit e31a16d ("wireless: move some utility functions
from mac80211 to cfg80211") in v2.6.31-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [48b2c5c628b09cf36cbeca53e0432fc2a7518be7]
stable/5.10: [18d5547327c202cda33ad2bbd203220c2c62c8a7]
stable/5.15: [3ff17ffa8d02e0e3f6b2f6e57af4aac511f5b734]
stable/6.1: [c4fbcf1e614ef0755fcc751fdfca21b0bf4e0ef7]
stable/6.12: [f33ad4e2f846e55cf4637419268f093ac9f1a765]
stable/6.18: [a2cdb4a675ca04c4ac8cc962848082d8ce065008]
stable/6.6: [12c0abd4d1c1b04a7663d04ba85268bc9ad9c017]
stable/7.2: [65893c8d28f239c7ddad5a83683be193a9133e9b]

CVE-2026-98346: wifi: cfg80211: don't get the radio mask for netdev-less wdevs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98346

Introduced by commit abb4cfe ("wifi: cfg80211: extend interface
combination check for multi-radio") in v6.11-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a7783e585360ee05dfe21d3173dbbe985c94f29e]
stable/6.12: [5b313159c970e945ee125ca87fad0d96ed913e55]
stable/6.18: [693d777846d525b8b218bad97a1befa5d9bd4334]
stable/7.2: [7166da84a7fe3553f9065782fd80299a37b150e5]

CVE-2026-98347: IB/IPoIB: Avoid restoring OPER_UP after multicast flush

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98347

Introduced by commit 344bacc ("IB/ipoib: Don't allow MC joins during
light MC flush") in v4.8-rc7.
Fixed in v7.3-rc4.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [9a141d3dc869d18b2eab35e999f4790a9b84e40f]
stable/5.10: [f973769fb7cb33ba0d4a64b7dcfee0cabaead938]
stable/5.15: [b72f38929f4b5aa83161fd3b22a7327207e51ec5]
stable/6.1: [1b11e4b55b41d9e69a8e8d07622614202e2eaca9]
stable/6.12: [5ad925d45f28464a5e043c9620880bb6a030da89]
stable/6.18: [188b334a6db36a8e0bfaaf59bc4020639a0f3aad]
stable/6.6: [326f7d34bd7e64de535566b65c0533b640df5a81]
stable/7.2: [1ff3add37c329704ec46181b4ae4f00f9f16ce6f]

CVE-2026-98348: wifi: libipw: reject too-short association responses

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98348

Introduced by commit 9e8571a ("[PATCH] ieee80211: Add QoS (WME)
support to the ieee80211 subsystem") in v2.6.20.16.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [adb7118b7d2cfd7e8213c17d7d2829f353017754]
stable/5.10: [766268b429ae26d8ca599031fa962b0fe4673120]
stable/5.15: [d70bdb84cf1782039384c1ffa7a18b0303c286a7]
stable/6.1: [400b89217058fac672134a0d4092c8493dadb8ad]
stable/6.12: [e3025ecdb2057f866c09e059fc1466e81d6f243e]
stable/6.18: [14cb425ba1f3a5d849e3bbc3d02d84e0ae195dbb]
stable/6.6: [46aa75291056b6dc5faaf956dffdb3e9662477b0]
stable/7.2: [af1b69be19c34e28c0ae54bee954b58cd076969a]

CVE-2026-98349: wifi: libipw: reject too-short beacon and probe responses

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98349

Introduced by commit b453872 ("[NET] ieee80211 subsystem") in v2.6.20.16.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5ce5721e8cbe3e80db8f43851cc2a2a92485ef4b]
stable/5.10: [cee6f141b3bebe62eb0363fd147acb52023935f0]
stable/5.15: [23afeb5d2bdfd34c8a0a661876291a4fa9978293]
stable/6.1: [89959ff00a978f3172726d3d5f861ee6f1aae26d]
stable/6.12: [ff756e6647722b7d225d882f7bdb186d8eee318e]
stable/6.18: [2c87bbc00dc93149d1dc4f803ad92d92e4ef3758]
stable/6.6: [14ae269c1306053ddf1ccf37c4bd66e085a652d1]
stable/7.2: [19959fb60228f6dccc40d55507f8b1a751c2dc89]

CVE-2026-98350: wifi: brcmfmac: cyw: pass PMKID to firmware if present

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98350

Introduced by commit 66f9093 ("wifi: brcmfmac: cyw: support external
SAE authentication in station mode") in v6.16-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e2de8d5eb2984416affdd9559e55f37c7f1bbf47]
stable/6.18: [c2cf589c7d546557ed60c43f2ec014279265dfbf]
stable/7.2: [6fba6233e9ca7718661e53555a3961c58772c21a]

CVE-2026-98351: wifi: virt_wifi: free skb when disconnected

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98351

Introduced by commit c7cdba3 ("mac80211-next: rtnetlink wifi
simulation device") in v5.0-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f9edf7cf63b96d2b776fca8d258d3c5256e40c8e]
stable/5.10: [38d3a5df85345f158f78b478b265ca906224454e]
stable/5.15: [ee053ea35c759135460f03d1c574f4ed08de844a]
stable/6.1: [d177eca79e1106834bc423d3969a4a2e3987996a]
stable/6.12: [56469996c10a0240653fc00576b4d33bdfb4cc51]
stable/6.18: [4f266738af45675faa0e8afee08c6e780afa8b06]
stable/6.6: [36727a702cf8e3399e3da60d0856378f6afcfb34]
stable/7.2: [46371442847a725cc0df3697fea2eba1dd54b82b]

CVE-2026-98352: RDMA/rtrs-clt: Fix CQ pool leak when connect is interrupted

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98352

Introduced by commit 3b89e92 ("RDMA/rtrs: Use new shared CQ
mechanism") in v5.13-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2ae16aaa78b5edc6e6d0904c84fd9cdfb762bcda]
stable/5.15: [a82cca40139d9fcae8208901856bd5bb4051f097]
stable/6.1: [74c4ed55e61f1b65ddbebc5b635d136461a1c3da]
stable/6.12: [31024e158b45358370a0a14ed96589e6aa62d6cb]
stable/6.18: [8f253d5893f991742464b9e7203c43fc08d0aa11]
stable/6.6: [6f8020fe7465f49e234a576c04e415e9d08c7878]
stable/7.2: [bf88ac4867050112a6c819c8d1a7209bf48ef427]

CVE-2026-98353: RDMA/erdma: Use IRQ-safe XArray helpers for QP and CQ tables

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98353

Introduced by commit 98df2ae ("RDMA/erdma: Hold CQ references when
processing EQ events") in v7.3-rc1.
Introduced by commit a52eeff ("RDMA/erdma: Hold QP references for AE
and CM processing") in v7.3-rc1.
Fixed in v7.3-rc4.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18 stable/7.2

Fixed status
mainline: [00baeade709fb66da647e8327e8398bb532e30f7]
stable/7.2: [74d4085221a7ec5440996af199ccadfa75b9eb0e]

CVE-2026-98354: RDMA/mad: Fix receive buffer leak when PKey enforcement fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98354

Introduced by commit 47a2b33 ("IB/core: Enforce security on management
datagrams") in v4.13-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3476c28c9addfa253f505e6bd87f1f5598b961d0]
stable/5.10: [4617c9a856188674dddb0ca66979746d07688579]
stable/5.15: [8e2036fb47a5b152d53eadbd35abf311bd34cc7f]
stable/6.1: [bad289e42f512646a988f278f536d21547df73f1]
stable/6.12: [39c4ea72a40503e102ae07e6776005f96ca078a6]
stable/6.18: [5091e25ec503f7fc02723ca435226467b68caac7]
stable/6.6: [752b30e9d339008e5ce7eed412e9446078916129]
stable/7.2: [c0d8df85db146d6275e226cb950023be69dd6c77]

CVE-2026-98355: RDMA/rtrs: guard against null kobj name

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98355

Introduced by commit 5a93929 ("RDMA/rtrs-clt: Add event tracing
support") in v6.1-rc1.
Introduced by commit c16762b ("RDMA/rtrs-srv: Add event tracing
support") in v6.1-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [99c24a8968ebef0573825b5cb89d5985d51635b9]
stable/7.2: [f79cf42ff23f9120246cd6740eaa26f59c632a4a]

CVE-2026-98356: RDMA/bnxt_re: check create_singlethread_workqueue() in DCB setup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98356

Introduced by commit 51dc531 ("RDMA/bnxt_re: Add support to handle
DCB_CONFIG_CHANGE event") in v6.14-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6c368f7baaea63c1c7c28c6df271511f2a1562c9]
stable/6.18: [a0fb2007d00b440fd1adddd9b042f01744ed0efc]
stable/7.2: [727bbda37d9758960c346546004eea4ad49242e1]

CVE-2026-98357: IB/isert: wait for deferred control PDU completions
before releasing the connection

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98357

Introduced by commit b8d26b3 ("iser-target: Add iSCSI Extensions for
RDMA (iSER) target driver") in v3.10-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a8fe3dfce8c0d8a76dc3d8486a5bff5feebe156f]
stable/5.10: [f5613acbe2e346d5c466ef0bd264fca936b69f82]
stable/5.15: [ccdb1523f12bc8a9646de65055d1aafed9e9bcc6]
stable/6.1: [0e230917670c6e6fe3243abfa11299fcbe05b1f4]
stable/6.12: [7edb8a88d6c76237c8b4435765bee1009e26a50a]
stable/6.18: [b96b8b3e41c308f606ffd10cfef1a7b9f97414cd]
stable/6.6: [505b242d9351690d1385bbe508ab4666f60363ce]
stable/7.2: [7908fbc597a694bbd99bfb59ece73bc3daded68e]

CVE-2026-98358: IB/iser: reject a remote invalidation of an
unregistered direction

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98358

Introduced by commit 59caaed ("IB/iser: Support the remote
invalidation exception") in v4.5-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d85f0f0a7c85756fc992c70d869706f19dac9259]
stable/5.10: [198e4db9add54a50cce60a5d80b8f0ee5456b65a]
stable/5.15: [b9e37452915feaa8422af87dea5d0c16a7d1ff13]
stable/6.1: [19ddd4af7fce9200e70882f622011e9dd130f427]
stable/6.12: [b4d278c91209931199db9c0836dc2e21a7593dad]
stable/6.18: [6ed3ebaff3345837f0528d85bd39ce573c7b9a41]
stable/6.6: [9d145a2d8d6f8f2cc460b80df41870819048f2a0]
stable/7.2: [ceecf3f9c322fc6937a66682942a26ad13a34a07]

CVE-2026-98359: RDMA/core: Reject unregistering netdevs in ib_get_eth_speed

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98359

Introduced by commit d418619 ("IB/core: Add generic function to
extract IB speed from netdev") in v4.14-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ef9fbe1b93f3b617b96e86d5cd76b3fa44514cb5]
stable/6.1: [be4b44c8b47c67a04c08b1a0aba18006b749ae6a]
stable/6.12: [520cd057f138ed8dbe8e05f0eae3a8ed4c5d3a5e]
stable/6.18: [a219459fbd1b2598e63c81a52847eba6c28b72d2]
stable/6.6: [45c60ffc79771bad154f224a05753191cf1b37bc]
stable/7.2: [5bd42f74ec3b4f4687fb600f367af0828d513b3c]

CVE-2026-98360: RDMA/rxe: insert mcg into mcg_tree only after
rxe_mcast_add() succeeds

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98360

Introduced by commit a926a90 ("RDMA/rxe: Do not call  dev_mc_add/del()
under a spinlock") in v5.18-rc6.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1caceeb2d74bbe88223aea55eb8626b4c5f076fd]
stable/6.1: [ddb43ac0926d4a931bc9b7744b93627f627457e5]
stable/6.12: [faae1fb4ccf8205806a8802c008798dabeb0205b]
stable/6.18: [02c0a2fa69c16248a7432af8a6d64ab2a73a5283]
stable/6.6: [c79a789aa15180a1543b5db49c343d12e3ec214d]
stable/7.2: [d4fc4e37f8a143b0fe83b42c8fb48cf542154fee]

CVE-2026-98361: RDMA/rxe: Restore HMM_PFN_WRITE check in ODP write paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98361

Introduced by commit 0b261d7 ("RDMA/rxe: Break endless pagefault loop
for RO pages") in v6.16-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [769001ce838d907ecaa95f1d0a4e8fc86f761f9f]
stable/6.18: [c6f56982ec5c7da83c4bdfcce3b6db18bcfe6425]
stable/7.2: [2d6c6f94d3e1cde049fe5db71dbd5549f10b2de1]

CVE-2026-98362: clk: scpi: bound-check DVFS index in scpi_dvfs_recalc_rate

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98362

Introduced by commit cd52c2a ("clk: add support for clocks provided by
SCP(System Control Processor)") in v4.4-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [70f4b78d560e592cbf3325b162424737d032fc1d]
stable/5.10: [6e3b55823da8ef0d99621efb422cc29f50d7f280]
stable/5.15: [7204095917aeaac89db7377c29a457351a19b076]
stable/6.1: [0f89e2ac0e945da2ce798f6a61aebf9d291c2e0a]
stable/6.12: [a82b274697d0876b478594ca78ad1e6cb062467b]
stable/6.18: [e1188332a9110cf3635fe286481ee38305b3c2b6]
stable/6.6: [56b7a9d89c67932bf11b71e3b6d17941fc24a393]
stable/7.2: [108c46e8dacc4a0e472a74f98171115d49cbc079]

CVE-2026-98363: firmware: arm_scpi: reject DVFS OPP count above MAX_DVFS_OPPS

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98363

Introduced by commit 8cb7cf5 ("firmware: add support for ARM System
Control and Power Interface(SCPI) protocol") in v4.4-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [32471d84a487c7fd74532bc96be56f8028cf4a3f]
stable/5.10: [e9887eeaa138c6b5697af3d2f7c71dc82407b154]
stable/5.15: [1aadbef648e92ca642125f188f99b0a26628e3ba]
stable/6.1: [7daaa684097377b66b98a832de307688a7f3bbc7]
stable/6.12: [0130f9ad3974a5b2ad0fa03d0b300a9fb83ed901]
stable/6.18: [69ec03cd481973e4be44a7158ed6c0fa06a9a5f9]
stable/6.6: [f17865332cc4ceaac846bcd7c28badbaedfabeff]
stable/7.2: [cc563a59aded6f3b02d75dcc3c0bc5e90755d99e]

CVE-2026-98364: xfrm: hold net_device reference under RCU in bundle creation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98364

Introduced by commit 25ee328 ("[IPSEC]: Merge common code into
xfrm_bundle_create") in v2.6.25-rc1.
Introduced by commit a0073fe ("xfrm: Add a state resolution packet
queue") in v3.9-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9fa903b24b1f46b4ff5443bcd4aca23e5c57f9c1]
stable/7.2: [8d85d6bc9c46dc41cb2be0eac53f8ab068c3a807]

CVE-2026-98365: RDMA/rxe: Fix integer overflow in mr_check_range()
leading to OOB access

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98365

Introduced by commit 8700e3e ("Soft RoCE driver") in v4.8-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d10e2a08799e858d3e71ea4169bcd018f216d444]
stable/6.12: [5d9426a74fc8cb8f375fcdc19b465a030f9b8cab]
stable/6.18: [2f3b705144e3a3c14184fec6e354680081fe91ec]
stable/6.6: [b7d2118660545a00b21e83010ded1a231c6fb8c5]
stable/7.2: [3431f525718f6b07da308cda6d44f8cb548bbd37]

CVE-2026-98366: RDMA/rxe: validate access flags before swapping the MR's PD

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98366

Introduced by commit 544c7f6 ("RDMA/rxe: Implement rereg_user_mr") in v6.5-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ae36a5b609ae79f4de966328b78d2584be9719a4]
stable/6.12: [7230cc456d4bb2221c20c5f1d22b38b8576aa16f]
stable/6.18: [fe602c91a52e161ace4afd5bdb8f33270c554c6f]
stable/6.6: [08f12745cb72981aa2cabe214af0c7a42a856f0a]
stable/7.2: [4dd7a53f1c5b44693c26dac4b9b5bd5bb9d604c8]

CVE-2026-98367: RDMA/siw: Clear association under lock if
siw_qp_modify fails in siw_accept

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98367

Introduced by commit 6c52fdc ("rdma/siw: connection management") in v5.3-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [32cd87f54dd1070020e664ccb0312a9f0fea79b4]
stable/5.10: [f11e09fe2fc3a11ccdf8f932b68181b0bb1d2078]
stable/5.15: [e3f039082856adab7e195dea1af45d93dd6a3f1c]
stable/6.1: [ad50d19f3d1ce052b3a146143581e930a1efb33e]
stable/6.12: [df2584750314336edcbcc21fb388e04b260f35b7]
stable/6.18: [9dcc0f4e488b70cff81e0e5717a498c929cf5de3]
stable/6.6: [030306bbb9273af80f14d7af20129661964cd9a7]
stable/7.2: [bfdc744bf20ae4c3ef2e470298de5237c5c9a13c]

CVE-2026-98368: esp: downgrade zerocopy managed frags before mutating skb frags

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98368

Introduced by commit 753f1ca ("net: introduce managed frags
infrastructure") in v6.0-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f89416eb3db151170a6f3c6dfc5239d26cdce4d2]
stable/6.1: [2359264f377cdbdef2d95868cc8fb572949e48d3]
stable/6.12: [6508304ac2c8cdafca2f4ab915df8c707893e134]
stable/6.18: [6cab554f2c0f28773f712ed3a5479103f42ce844]
stable/6.6: [69a768c12398cada8528080332c822623fa7064d]
stable/7.2: [0d0845ee61c5df47cc68bc446501f48f71e8dcc6]

CVE-2026-98369: xfrm: add missing rcu_read_lock(), skb_dst_force() and
dev_hold() for xfrm_trans_reinject()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98369

Introduced by commit 4f49206 ("xfrm: Reinject transport-mode packets
through workqueue") in v6.1-rc1.
Fixed in v7.3-rc4.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [d2f5082f9e84653fa1a9e8aebaaff23e688f5e19]
stable/5.15: [41e47f1664be86c91326f0afe0504a1162d00907]
stable/6.1: [6601d91a85761f33351c71e04ec0bbd294ca07ce]
stable/6.12: [68a317b4aec8ca1868a39d69e40f9e29baa4f40a]
stable/6.18: [6eb3b071be8e260543c604550c54dac66e6b174b]
stable/6.6: [0cda8273265d30cac6423834fd7d4acb75f04fdb]
stable/7.2: [664fc0941df7c1918b2cd4de6ee00469ba77d8e4]

CVE-2026-98370: xfrm: fix compat ALLOCSPI request use-after-free

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98370

Introduced by commit 5f3eea6 ("xfrm/compat: Attach xfrm dumps to
64=>32 bit translator") in v5.10-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d1ebd9081879fd9ae9c8fb7e8928f19cc88ae320]
stable/5.10: [494f2bee9d8d0ebcfa249ac41bed7fed26d119b4]
stable/5.15: [17893987e52918c23945c42e47e894a936305a25]
stable/6.1: [42971ea17c7a8afc0bdd5ca40648bf4e5bb7b810]
stable/6.12: [bb63ab52a18273ec68340ac49aebbaa7b514ccd5]
stable/6.18: [248433942155b42a0ef04a5806c8aca024ea7c33]
stable/6.6: [2b63341e2ebc9b6f73cbd9214dbe7d46dd98c718]
stable/7.2: [e70f639aee2ff0def155c256cace9e0f81d998e2]

CVE-2026-98371: xfrm: iptfs: fix runt reassembly panic from short inner tot_len

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98371

Introduced by commit 0756947 ("xfrm: iptfs: handle received fragmented
inner packets") in v6.14-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dc33262be1fe43d0eb0b84fb58c6ed42e2f64a8c]
stable/6.18: [a7018ee0ea8622ed59edc064be4e0f2c26464f53]
stable/7.2: [5b8afb56ccb7c014b0f1ac40341708b200443c2d]

CVE-2026-98372: xfrm: iptfs: fix stack OOB read in iptfs_skb_reset_frag_walk()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98372

Introduced by commit 5f2b6a9 ("xfrm: iptfs: add skb-fragment sharing
code") in v6.14-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d042487dc118e494db2e2c1382310255c90ff544]
stable/6.18: [7e1c6884a0b494b7e3f204877f94c1e07a117bf7]
stable/7.2: [da56d0ee93d1bad779b0486f2fab92d1bc1f0cf3]

CVE-2026-98373: mm/hugetlb: preserve mremap address delta when
skipping page tables

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98373

Introduced by commit e95a985 ("hugetlb: skip to end of PT page mapping
when pte not present") in v6.0-rc1.
Introduced by commit 4ddb4d9 ("hugetlb: do not update address in
huge_pmd_unshare") in v6.0-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9bdad082d44bdcf93716973dcba6be77e8a06e7b]
stable/6.12: [7a96b0f657c8d799ea5b8e02fc9ec7cca0e6e7ff]
stable/6.18: [850cc4a84b36a0062dcd0391acd2450e20ab0767]
stable/7.2: [480a39b0a12c977ed6e755f3d12a23424c57d11f]

CVE-2026-98374: tcp: fix use-after-free of retransmit_skb_hint in
tcp_send_synack()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98374

Introduced by commit c31b70c ("tcp: Add logic to check for SYN w/ data
in tcp_simple_retransmit") in v5.11-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fe99bbeee5c5dbd3abc30721a8079ced59649d97]
stable/5.15: [fad6d429651e748365e93ca54645accc212f0018]
stable/6.1: [c5b4da1f403a658c1c19766be2b426003ada419f]
stable/6.12: [e3ea71cb1408a013ed4e8a757b815f1a919324bd]
stable/6.18: [631aa4cb45099f09e9385dd786bd291c6270bfc4]
stable/6.6: [71d45049b0d631dfdbf3c65305f7fca676de023b]
stable/7.2: [0f87720c7e4bcab07c24888b3cf12bfe857bb90e]

* Updated CVEs
CVE-2022-48816: SUNRPC: lock against ->sock changing during sysfs read

stable/5.10 was fixed.

Fixed status
stable/5.10: [cd366b9091a3e6ed8229e4b908e895d20b527dc0]

CVE-2022-49142: net: preserve skb_end_offset() in skb_unclone_keeptruesize()

stable/5.10 was fixed.

Fixed status
stable/5.10: [91c118727432a5d776d5fe86e0cf8eb1289ac1fc]

CVE-2022-50406: iomap: iomap: fix memory corruption when recording
errors during writeback

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [76a9234cb66479e9d02b15fd0f3e349cb2320279]
stable/5.15: [169adb79cfd59250a5b1f68cdc69e7287fc5a0ce]

CVE-2023-52629: sh: push-switch: Reorder cleanup operations to avoid
use-after-free bug

stable/6.1 was fixed.

Fixed status
stable/6.1: [ff635d1f143b55fa005e9e43b16e6d8f677e90a5]

CVE-2023-53231: erofs: Fix detection of atomic context

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [c3446e50fb4dc39e2dfb5951a57bc175d38f68be]
stable/6.1: [96bcd9650e15901201d964eef5f79d18a81daac8]

CVE-2023-53336: media: ipu-bridge: Fix null pointer deref on SSDB/PLD
parsing warnings

stable/6.1 was fixed.

Fixed status
stable/6.1: [bca783c943cefea97c27f02fdd16bf414e8057df]

CVE-2023-53353: accel/habanalabs: postpone mem_mgr IDR destruction to
hpriv_release()

stable/6.1 was fixed.

Fixed status
stable/6.1: [c96cc6b46fdce89a8feb270a35bbe5086c142534]

CVE-2023-53429: btrfs: don't check PageError in __extent_writepage

stable/6.1 was fixed.

Fixed status
stable/6.1: [3c26023365a955d2d69355f5167508a963e44333]

CVE-2023-53491: start_kernel: Add __no_stack_protector function attribute

stable/6.1 was fixed.

Fixed status
stable/6.1: [5a7e8f89cdee16db705905a5b1ce2100b13dd63e]

CVE-2023-53538: btrfs: insert tree mod log move in push_node_left

stable/6.1 was fixed.

Fixed status
stable/6.1: [7e0ee4cb02e6b485103ecd125743b2818a68993d]

CVE-2023-53574: wifi: rtw88: delete timer and free skb queue when unloading

stable/6.1 was fixed.

Fixed status
stable/6.1: [60ee0f6fea7ba5681ebf7d70b8ebe592227188a4]

CVE-2023-53627: scsi: hisi_sas: Grab sas_dev lock when traversing the
members of sas_dev.list

stable/6.1 was fixed.

Fixed status
stable/6.1: [6fb177f10d87b8d816402c488e83506d0fb5340a]

CVE-2023-53707: drm/amdgpu: Fix integer overflow in amdgpu_cs_pass1

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [8fb035232b505ab12119adf78f5fc1f93f2b7e24]
stable/5.15: [6e03634f44cd5988ee5b6cdd4f849e73762095e7]

CVE-2023-53762: Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync

stable/6.1 was fixed.

Fixed status
stable/6.1: [5e3ee972f185eb7957ce789b3bf13a3cb790f178]

CVE-2023-53851: drm/msm/dp: Drop aux devices together with DP controller

stable/6.1 was fixed.

Fixed status
stable/6.1: [ff1338a3bfaa2f35b5f49a434f2ad6884b75fafe]

CVE-2023-53857: bpf: bpf_sk_storage: Fix invalid wait context lockdep report

stable/6.1 was fixed.

Fixed status
stable/6.1: [47cf3387de902e8f61f705b06cb2fc1315d26932]

CVE-2023-53999: net/mlx5e: TC, Fix internal port memory leak

stable/6.1 was fixed.

Fixed status
stable/6.1: [9079ef5fb26ff38ced50cc15199ce56a009b8605]

CVE-2023-54227: blk-mq: fix tags leak when shrink nr_hw_queues

stable/6.1 was fixed.

Fixed status
stable/6.1: [26d495f0f64d8cd4fcd29206ee5c653ee0e0cbcd]

CVE-2023-54233: ASoC: SOF: avoid a NULL dereference with unsupported widgets

stable/6.1 was fixed.

Fixed status
stable/6.1: [d42fe2721111138d7656d4f621f38c171979c8a0]

CVE-2024-26948: drm/amd/display: Add a dc_state NULL check in dc_state_release

stable/6.6 was fixed.

Fixed status
stable/6.6: [3218df42ff3b187f055edb8a38498b316bae0ecd]

CVE-2024-40979: wifi: ath12k: fix kernel crash during resume

stable/6.6 was fixed.

Fixed status
stable/6.6: [7e323cb55705398123ae087d4870c44e0424e7c0]

CVE-2024-41045: bpf: Defer work in bpf_timer_cancel_and_free

stable/6.6 was fixed.

Fixed status
stable/6.6: [5eaa11c500ed07f505f86cec07d5593a71927e26]

CVE-2024-41062: bluetooth/l2cap: sync sock recv cb and release

stable/5.15 was fixed.

Fixed status
stable/5.15: [9c0b7d61cf3c00f87f2529b5b8b785f0f65089aa]

CVE-2024-41082: nvme-fabrics: use reserved tag for reg read/write command

stable/6.6 was fixed.

Fixed status
stable/6.6: [cc91c461cf3902993364ea85d8814ba7786c95b1]

CVE-2024-41085: cxl/mem: Fix no cxl_nvd during pmem region auto-assembling

stable/6.6 was fixed.

Fixed status
stable/6.6: [bc262c6d32b6c1715e64220e2cbfa64a225cd266]

CVE-2024-42282: net: mediatek: Fix potential NULL pointer dereference
in dummy net_device handling

stable/6.6 was fixed.

Fixed status
stable/6.6: [81e82340170ae82f8cc28e76c13a0069c0d47cb4]

CVE-2024-46730: drm/amd/display: Ensure array index tg_inst won't be -1

stable/6.6 was fixed.

Fixed status
stable/6.6: [15403445b873a4ce45b2d4ecfb5928a025297282]

CVE-2024-46775: drm/amd/display: Validate function returns

stable/6.6 was fixed.

Fixed status
stable/6.6: [e2379b2e343e34f8f73f5d9f0e348b0b203ff68f]

CVE-2024-47408: net/smc: check smcd_v2_ext_offset when receiving proposal msg

stable/5.10 was fixed.

Fixed status
stable/5.10: [35da53027c1f2efdd7d0177dc00584134204761a]

CVE-2024-47702: bpf: Fail verification for sign-extension of packet
data/data_end/data_meta

stable/6.6 was fixed.

Fixed status
stable/6.6: [4b48228eebce2ab1b01e3133da822164472b7e46]

CVE-2024-49568: net/smc: check v2_ext_offset/eid_cnt/ism_gid_cnt when
receiving proposal msg

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [9cc0170ae646876aa5de2f0cad3066ce53e86f27]
stable/5.15: [49798283fce4c1a24fb1ba4c7c39127739535571]
stable/6.1: [690b9a8db9460d065785548e43fd6a02d247c1b7]

CVE-2024-49922: drm/amd/display: Check null pointers before using them

stable/6.6 was fixed.

Fixed status
stable/6.6: [336bc3461b1c74e085bb0f2e1488df4dcc6dc983]

CVE-2024-53056: drm/mediatek: Fix potential NULL dereference in
mtk_crtc_destroy()

stable/6.6 was fixed.

Fixed status
stable/6.6: [fb05e973698f4af008c7fb6e0cfa6a2fa1d98409]

CVE-2024-56545: HID: hyperv: streamline driver probe to avoid devres issues

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [b7c074d21fe8a8ee3b4f866a12c72cad6a5826eb]
stable/5.15: [4c419126cf71ca1f358ec0b8ccc448928719d502]
stable/6.1: [a216f6dc0444c3bd900bca66b9f21467d08e3ed3]

CVE-2025-21759: ipv6: mcast: extend RCU protection in igmp6_send()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [638e8fe3563a82f298fe537a28d5342a97278cf1]
stable/5.15: [6901bbb169e3add6c037218d996790cef6b3d650]
stable/6.1: [7e0a818ecc4d62e7fb668ea02de0bfe8ba0b7dff]

CVE-2025-38349: eventpoll: don't decrement ep refcount while still
holding the ep mutex

stable/5.15 was fixed.

Fixed status
stable/5.15: [263f5de8302a6f2f136d392e5d3f8b1edf922857]

CVE-2025-40074: ipv4: start using dst_dev_rcu()

stable/6.1 was fixed.

Fixed status
stable/6.1: [864155c164654110f68a17a63bd0339754790d67]

CVE-2025-40097: ALSA: hda: Fix missing pointer check in
hda_component_manager_init function

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [b044aa6ae63391ba40c93ca5d476d276cb17db1b]
stable/6.6: [1c3f4b15eb1850558d7d4da74b98cffbb8121721]

CVE-2025-68190: drm/amdgpu/atom: Check kcalloc() for WS buffer in
amdgpu_atom_execute_table_locked()

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [0b52e3192181b4de58844faedd2928e5c6ca0e06]
stable/5.15: [47252c7d5559d8776ad336be9c955d8404e7ae69]
stable/6.1: [88d198836f628c57536c6c71d13e90c5d15fbf1a]
stable/6.6: [73853208a497a036596dcf9efbff8ce927651d3a]

CVE-2025-68736: landlock: Fix handling of disconnected directories

stable/6.1 was fixed.

Fixed status
stable/6.1: [4f5cdc82a6c7e22cfd9a92d203cec13a52a3f363]

CVE-2026-23175: net: cpsw: Execute ndo_set_rx_mode callback in a work queue

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [680076cb69f0d54e2a0cbfc5006ecc809eef94f9]
stable/6.6: [fa252fe7dc32956a4f7803e27b46449d98ad0b2f]

CVE-2026-23203: net: cpsw_new: Execute ndo_set_rx_mode callback in a work queue

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [a9b89786a769b85791d89cae7627097fb9393ca7]
stable/6.6: [74852715757d961c87362a9ed112b90957770bfa]

CVE-2026-46113: KVM: x86: Fix shadow paging use-after-free due to unexpected GFN

stable/5.15 was fixed.

Fixed status
stable/5.15: [9597963a8ca16259d194a1d9950d7bd22a10ab2f]

CVE-2026-46242: eventpoll: fix ep_remove struct eventpoll / struct file UAF

stable/5.15 was fixed.

Fixed status
stable/5.15: [a10fbbe74e1c743beb1bb312109366667461df8a]

CVE-2026-52988: netfilter: nf_tables: join hook list via
splice_list_rcu() in commit phase

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.18,
stable/6.6 were fixed.

Fixed status
stable/5.10: [ed8d3bd8272e49ea987100de2abfb13710329a9b]
stable/5.15: [8fdd2204503ab1ce07dc000c277e2c3edf96a67b]
stable/6.1: [5593c640f9daedec8de61555c41e1019fa675aa6]
stable/6.12: [28ecfb3d1fe8dea70319de7051cb6718c25b5b52]
stable/6.18: [a557816c6e38e9473d99aa9ea8c662f55fc85847]
stable/6.6: [00e370627f2e1fb3585f9d26348b1abddc75442b]

CVE-2026-53005: af_unix: Drop all SCM attributes for SOCKMAP.

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [866e69a824b46e682b8fb923be321b585e634874]
stable/6.6: [301bdc558a5eb4057473204d35e2608e682aaafb]

CVE-2026-53359: KVM: x86: Fix shadow paging use-after-free due to
unexpected role

stable/5.15 was fixed.

Fixed status
stable/5.15: [0b5e8ead71e683bcf6232db16234cf7e6d553a23]

CVE-2026-68097: ksmbd: validate ACE size against SID sub-authorities

stable/6.1 was fixed.

Fixed status
stable/6.1: [5a2d9fe0e87c71baa0aaa1cfc1361892fcd1ece0]

CVE-2026-68155: libceph: Reject monmaps advertising zero monitors

stable/5.10 was fixed.

Fixed status
stable/5.10: [ba5f0015bfd376d764163045a61c17be75f44dae]

CVE-2026-68161: sctp: close UDP tunnel sockets during netns teardown

stable/6.1 was fixed.

Fixed status
stable/6.1: [c29affd44e6769e3073235d4b471d9b501fa8166]

CVE-2026-68236: drm/amd/display: set new_stream to NULL after release

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [92b7c6e3a1546c6db868b07e93fa6fb950d1d3a0]
stable/5.15: [bf9c06c70f496f1ba4474caf95c69696c828340e]
stable/6.1: [01ba5b36898d6258f584269537cc49e7b05cf7c6]

CVE-2026-68286: drop_monitor: perform u64_stats updates under
IRQ-disabled section

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [dd8472526a04f2185afd792b8041a912a7d75d85]
stable/6.6: [3454c729ee8aa682ec871f1b174b047f731933ae]

CVE-2026-68287: drop_monitor: fix size calculations for 64-bit attributes

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [1275a4769c126405c6c63b6372daff120ac679a6]
stable/6.6: [0da8f531336b28a59b23e5a67d40eaed15906201]

CVE-2026-68288: net: drop_monitor: fix info leak in NET_DM_ATTR_PAYLOAD

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [d427b152b663cb2b19fcd449d792e17edbe4a938]
stable/6.6: [3c0bc7dcc5f9257d25c59eeb7ccb4df33dcfc446]

CVE-2026-68289: tipc: fix integer overflow in tipc_recvmsg() and
tipc_recvstream()

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [9fd4f92671146b068809b6c34b50346cb30cf8f7]
stable/6.6: [93580911f02d1f4a506ec0a6fc4354140c53ffe8]

CVE-2026-68391: Bluetooth: mgmt: hold reference for hci_conn in
mgmt_pending_cmds

stable/6.1 was fixed.

Fixed status
stable/6.1: [84674dd1d3192ecb050827d3148642609c0c9dbb]

CVE-2026-72315: smb: client: fix busy dentry warning on unmount after DIO

stable/6.12 was fixed.

Fixed status
stable/6.12: [f7748b551010c021d92f0125e37f32ac0c376d8a]

CVE-2026-72334: Bluetooth: ISO: fix malformed ISO_END/CONT handling

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [d2df29dc9abda2fc10ff522eac0969f5b77b3637]
stable/6.6: [7250b6b5ba9b737cff2c2c1d0760360c7b6bca00]

CVE-2026-72402: bpf: Mask pseudo pointer values in verifier logs

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [b767a5d7c6cb595f9feb00b5af96191a59efca26]
stable/6.6: [6181239115e19cda4b483a2604193a9379cbd28f]

CVE-2026-72413: sctp: fix err_chunk memory leaks in INIT handling

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [a8e6a839c0e7ca1da752faaab51e2eafb17483a4]
stable/6.6: [43ddbcdc0ed74a8fba4aff5e623ace8135411b93]

CVE-2026-72463: xfrm: Fix dev use-after-free in xfrm async resumption

stable/6.12 was fixed.

Fixed status
stable/6.12: [fed4d3195a31125566876952ce66113ec1eb9008]

CVE-2026-72485: coresight: platform: defer connection counter
increment until alloc succeeds

stable/6.6 was fixed.

Fixed status
stable/6.6: [dd3c9e1c9858c797ba78f4ca6c0fc663eeac6d72]

CVE-2026-72496: RDMA/bnxt_re: Proper rollback if the ioremap fails

stable/6.6 was fixed.

Fixed status
stable/6.6: [00444baa8f74d220764ee5903f60759c120cabd5]

CVE-2026-74258: bpf: Guard __get_user acesss with access_ok for
uprobe_multi data

stable/6.6 was fixed.

Fixed status
stable/6.6: [ff6c5ee77dcc98381290d16af53f6262625870a6]

CVE-2026-74289: ipv4: fib: Don't dump dying fib_info in fib_leaf_notify().

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [8bdb20b8a581495062b5879f4e9d435da648b3b0]
stable/6.6: [7907a395701b339c2d68f37456d395e953c74795]

CVE-2026-74291: ASoC: topology: Check PCM and DAI name strings before use

stable/6.6 was fixed.

Fixed status
stable/6.6: [c405b07246bf179e9457de57501c3470175b165e]

CVE-2026-74294: ASoC: meson: aiu: Validate written enum values

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [91797708f99e4a910ab019760069c0a7e00a6fc0]
stable/6.6: [90703664dbc5a4bf3d84f649404318f3cafdbe69]

CVE-2026-74347: netfilter: cttimeout: detach dataplane timeout policy
and repurpose refcount

stable/6.12 was fixed.

Fixed status
stable/6.12: [b2e84317f334d834fb06c9b340ea465f398b6d4f]

CVE-2026-74460: can: ems_usb: validate CPC message lengths

stable/5.10 was fixed.

Fixed status
stable/5.10: [1c380a332e342b7d58c86c4f556cb0823b16a9b8]

CVE-2026-74496: fou: Fix use-after-free in fou_create()

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [0ee628a58d83e571f36ec9f07624d6845e420c50]
stable/5.15: [a6fca682cfa2041e31aa72cc397c4a1406eb7468]
stable/6.1: [b3f9c3e60aa25453774f899d25b5e61dd0bec1d5]
stable/6.6: [99f4d3120b244f92e5df787152041296a2860cb5]

CVE-2026-74521: ksmbd: use memcmp() to compare ClientGUIDs

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [7bde6f181fa307d2cc1ec2b0313ac8e9811c8232]
stable/6.6: [5a0367bf5ce420be7b19936def2e90adcf32a683]

CVE-2026-74743: macvlan: inherit needed_headroom and needed_tailroom
from lowerdev

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [c2ef3f134b069c54b9cc95cce1a16c38c4939336]
stable/5.15: [7b0eb3e0f363ca79a3af9efd2e87c6258f11da2b]

CVE-2026-80521: af_unix: Unlink scc_entry in unix_del_edge().

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [2b6c2842692d08e7acaf32d1eb47f95def35f3fe]
stable/6.6: [6fda5c51b8e43a8440f76e65c89d9f95ddb2ef33]

CVE-2026-80726: KVM: x86/mmu: WARN and clear role.invalid when
creating a child shadow page

stable/5.15 was fixed.

Fixed status
stable/5.15: [ec4eb5c2ef964bf398f07889265121c316561911]

CVE-2026-80833: crypto: sun8i-ss - Remove crypto_rng interface

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [9127d2a88c1795ddc4ba7687fea01cab1908fae1]
stable/5.15: [64f3406ad082c00fb7a80240a24943ccb6d9a538]
stable/6.1: [6117968fe2cdcde28ac3aa6ec814485320af4049]
stable/6.6: [a41e4ba94ad4571aa2e566baa395e6e871e0fd4f]

CVE-2026-80834: crypto: sun8i-ce - Remove crypto_rng interface

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [19588f78db582ba4c47b4001bb27f39bb19dc432]
stable/5.15: [ce641e75e0fc912acd4bf661367617561bc7c63f]
stable/6.1: [b69af40720cabd13da763575022a3d4430b02dfc]
stable/6.6: [2c8fa2299789282db1aac566a60c2012a5ba8ea8]

CVE-2026-80836: crypto: virtio - bound the akcipher result length

stable/6.6 was fixed.

Fixed status
stable/6.6: [bd33cb19bcb432a4dd5e8f50be5e2547af1e9f78]

CVE-2026-80837: netfilter: nf_tables: don't queue packet path object
notifications

stable/6.6 was fixed.

Fixed status
stable/6.6: [6989f298103f575a768a85e4b19d2384709237f8]

CVE-2026-80841: net/packet: defer vmalloc TX_RING free until skbs finish

stable/6.6 was fixed.

Fixed status
stable/6.6: [debf9f50140b3df3949ebcb97d4450f8993fe32d]

CVE-2026-80851: gtp: serialize PDP context updates

stable/6.6 was fixed.

Fixed status
stable/6.6: [b4ac2a5ce5a96ec21ed48f60d30b52b1fb22c62a]

CVE-2026-80861: usb: xhci: bail out of setup if the controller is inaccessible

stable/6.6 was fixed.

Fixed status
stable/6.6: [301f4a3303b21ea959a8294518ee883710498ac2]

CVE-2026-80925: vlan: fix skb_under_panic and races when toggling HW
VLAN offload

stable/6.6 was fixed.

Fixed status
stable/6.6: [b38d7a4bc9c17e1d437696da25f9fbc286614d9d]

CVE-2026-80926: ksmbd: fix use-after-free in oplock break notification

stable/6.6 was fixed.

Fixed status
stable/6.6: [892f643b141aee3f7aa7c0fc61ddcb55c59f1996]

CVE-2026-80929: sysctl: move the "cad_pid" entry from pid_table[] to
kern_reboot_table[]

stable/6.12 was fixed.

Fixed status
stable/6.12: [b4201fef066a95fe5f310a5f2561e18ecbde5d7a]

CVE-2026-80935: wifi: mt76: mt7996: bound the device EEPROM address
before the EFUSE copy

stable/6.12 was fixed.

Fixed status
stable/6.12: [388f471ca4758f644394b681ce97677a4d0e772c]

CVE-2026-80937: wifi: mt76: mt7915: bound the device EEPROM address
before the EFUSE copy

stable/6.12 was fixed.

Fixed status
stable/6.12: [394e8cb56fc732d71041599cdb4e01f82cfd11c5]

CVE-2026-80939: wifi: rtw89: pci: add .shutdown callback to stop
rfkill polling on reboot

stable/6.12 was fixed.

Fixed status
stable/6.12: [dfe2b5b2056918d186ad890079a9e7ec1898429a]

CVE-2026-80980: net/smc: stop killed, freed and out_of_sync sharing a byte

stable/6.12 was fixed.

Fixed status
stable/6.12: [09a9cbadc05f452405de31012bd2c428b601291a]

CVE-2026-81015: platform/x86/amd/pmc: Fix LPS0 and debugfs leaks when
STB init fails

stable/6.12 was fixed.

Fixed status
stable/6.12: [d201c09c2428a4a8fd3bdcb032ae99f1e016458c]

CVE-2026-81016: platform/x86/amd/pmc: Propagate SMU errors and
validate S2D address

stable/6.12 was fixed.

Fixed status
stable/6.12: [638e1ca5d4e2b4fdbb209db64926d013b34f3b79]

CVE-2026-89437: platform/x86: int1092: Fix potential memory leak in sar_probe()

stable/6.12 was fixed.

Fixed status
stable/6.12: [4bdbb7f1045820aa8fd87d84db6b26c01049a005]

CVE-2026-89441: mmc: via-sdmmc: cancel card-detect work on remove

stable/6.12 was fixed.

Fixed status
stable/6.12: [0a3c70191868fb007c03ff79693ad4e4b3fdcbb8]

CVE-2026-89445: iommufd: Fix UAF in selftest IOPF reporting

stable/6.12 was fixed.

Fixed status
stable/6.12: [fd2e7ac94d6d813548b021473c3dddc30c8c07d1]

CVE-2026-89452: iommu/msm: Unwind probe state on registration failure

stable/6.12 was fixed.

Fixed status
stable/6.12: [51e37f9179387b6e3fa64a3d3b4fece1a38b3a02]

CVE-2026-89467: power: supply: qcom_battmgr: fix use-after-free

stable/6.12 was fixed.

Fixed status
stable/6.12: [77fefca305db44b0edd3fcdb52d781771c1ce366]

CVE-2026-89500: ring-buffer: Make cpu_buffer::free_page a buffer_data_read_page

stable/6.12 was fixed.

Fixed status
stable/6.12: [d8f52dc3c3f1f987d8cf920ccd8d66590870bf3f]

CVE-2026-89503: ring-buffer: Fix subbuf resize race with
ring_buffer_alloc_read_page()

stable/6.12 was fixed.

Fixed status
stable/6.12: [2313ff69bd237aad264a5913907f374f958335a2]

CVE-2026-89520: sched/core: Make core-sched flips wait for in-flight selections

stable/6.12 was fixed.

Fixed status
stable/6.12: [3e2511bffa93a639774a99e392181e21d28677e2]

CVE-2026-89560: landlock: Require LANDLOCK_ACCESS_FS_MAKE_REG for
whiteout creation

stable/5.15 was fixed.

Fixed status
stable/5.15: [39fc16597715125529df8f94e016fb00836ee3c1]

CVE-2026-89739: usb: dwc3: gadget: Fix use-after-free in
dwc3_gadget_free_endpoints due to race condition

stable/6.12 was fixed.

Fixed status
stable/6.12: [5f359265f616873edf32db418bd1513fdae3ddec]

CVE-2026-89766: pidfd: hold exec_update_lock around namespace ioctl

stable/6.12 was fixed.

Fixed status
stable/6.12: [bac2f1913a216677c2c220d7bb352dd0330065ca]

CVE-2026-89792: ksmbd: prevent out-of-bounds reads in share config responses

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [df8aa4a09733c4d3974b1db32c1782b3aad3a151]
stable/6.1: [0127f1c119bde40578f4d25f5d17333b4e75de8c]
stable/6.6: [fd636a87161def6e35876ab7943641ce457974c8]

CVE-2026-89795: PCI: Allow per function PCI slots to fix slot reset on s390

stable/6.12 was fixed.

Fixed status
stable/6.12: [0d1a7d67f45645106578d65181e4e492dd20ed79]

CVE-2026-89796: mm/damon/core: avoid infinite kdamond_merge_regions()
internal loop

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [407da1dd7f48e5ba22ceb8834f6923390632d025]
stable/6.1: [65edd8b3a88278c9f8e5c7d8c15d4f296ce35078]
stable/6.6: [5b0953f86d65855dc901050f40bbe6da0475d198]

CVE-2026-89797: power: supply: ab8500_fg: fix use-after-free on remove

stable/6.12 was fixed.

Fixed status
stable/6.12: [c2ce9b8f325f522e10e4d262b37ae49deb83e79b]

CVE-2026-89806: drm/sysfb: ofdrm: Fix integer overflow in fb_size calculation

stable/6.12 was fixed.

Fixed status
stable/6.12: [711fe7949d37656a5586244afee9523b9e5e37e9]

CVE-2026-89827: drm/amdgpu: avoid force-completing uninitialized UVD rings

stable/6.12 was fixed.

Fixed status
stable/6.12: [863f08c485fbb51b6443681893e4044c7cb6cd51]

CVE-2026-89832: f2fs: fix to clear dirty flag on folio in error path

stable/6.12 was fixed.

Fixed status
stable/6.12: [34732e3a8713f3b7acd1a0ea37e3a6bee4c78550]

CVE-2026-89837: f2fs: fix dentry folio leak in find_in_level

stable/6.12 was fixed.

Fixed status
stable/6.12: [af9cc316d31371824de8d409260a2ab9759dd51c]

CVE-2026-89838: f2fs: limit recovery filename logging to stored length

stable/6.12 was fixed.

Fixed status
stable/6.12: [7ab1780074943508534343e1e5e5ab0c9ef9dd7b]

CVE-2026-89840: f2fs: validate MOVE_RANGE destination size

stable/6.12 was fixed.

Fixed status
stable/6.12: [bca61ee5192ea47003722486ae9588a2a4bb47b6]

CVE-2026-89859: scsi: qla2xxx: Zero dport diagnostics buffer to avoid info leak

stable/6.12 was fixed.

Fixed status
stable/6.12: [5dfc77099c7d9fde9520a229794b0154d7ccccc1]

CVE-2026-89868: media: chips-media: wave5: Add timeout while stop_streaming

stable/6.12 was fixed.

Fixed status
stable/6.12: [58e185e69a3dbe3494e54aad330f228f0b6645e1]

CVE-2026-89921: KVM: s390: Zero initialize data structures for
inject_pfault_token

stable/6.12 was fixed.

Fixed status
stable/6.12: [b8abc760fa18a389319d977834a30550b3ec18e8]

CVE-2026-89956: s390/vfio-ap: Fix missing lock required to access list
of ap_matrix_mdev objects

stable/6.12 was fixed.

Fixed status
stable/6.12: [530ee1cc71562b6799b9ece187b6c1b757a2c6fa]

CVE-2026-89971: nvme: skip the zoned limits update if the zone info query failed

stable/6.12 was fixed.

Fixed status
stable/6.12: [a75258e651d91ec25424cd94d824d192c11ccc24]

CVE-2026-89972: nvme: add missing SRCU grace period in error path

stable/6.12 was fixed.

Fixed status
stable/6.12: [0d4735418512ef825176726eaaa8bd6a35f6b46d]

CVE-2026-89996: dma-buf: dma-heap: don't publish fd before
copy_to_user() succeeds

stable/6.12 was fixed.

Fixed status
stable/6.12: [1bf6083a41f810d760c4dcd1b80c5194a92575aa]

CVE-2026-90002: ftrace: Take trace_array reference before accessing
its ftrace_ops

stable/6.12 was fixed.

Fixed status
stable/6.12: [177cd8966325f0ffffa3c9381f9e0422019a3973]

CVE-2026-90013: tracing: Take trace_array reference when opening options file

stable/6.12 was fixed.

Fixed status
stable/6.12: [97ceaffbd672449ad7ead5ae8788dce16374b0c1]

CVE-2026-90016: staging: rtl8723bs: fix OOB read in rtw_restruct_wmm_ie()

stable/6.12 was fixed.

Fixed status
stable/6.12: [e63b72c5d7336981dfc05e5cb92becff29dfea00]

CVE-2026-90023: usb: gadget: f_mass_storage: fix null pointer
dereference in fsg_common_set_num_buffers()

stable/6.12 was fixed.

Fixed status
stable/6.12: [51cc9af4f2d3f0b765266aced66b9b532b423b13]

CVE-2026-90029: usb: storage: realtek_cr: fix use-after-free on disconnect

stable/6.12 was fixed.

Fixed status
stable/6.12: [524d4257f741cd95eb85e2817c9c890928fcfef7]

CVE-2026-90030: usb: dwc3: clear forceRM when issuing EndTransfer

stable/6.12 was fixed.

Fixed status
stable/6.12: [9f1e57c484f9edeaaa5a27a03ed985e98496e81d]

CVE-2026-90304: ARM: 9484/1: enable interrupts when unhandled user
faults are triggered

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [0ceae734f545d28deaa1b3df063228232af1d1bc]
stable/5.15: [9be3fcee9cfd9e6335180037c26b4cc6f33325c8]
stable/6.1: [3bcfa8d173b7b350b992cf5fd79f4ecd329f8943]
stable/6.6: [ec9f166e6573ce1c48b300f45a7ca89bb0acf70e]

CVE-2026-93196: nvdimm: virtio_pmem: refcount requests for token lifetime

stable/6.12 was fixed.

Fixed status
stable/6.12: [4691c137e9cbe76137d730a26d663d900ac7279b]

CVE-2026-93199: i3c: master: Do not treat master device as a duplicate target

stable/6.12 was fixed.

Fixed status
stable/6.12: [533faf3d2e67ded0a62b7ba753c0fe993d1dfc26]

CVE-2026-93200: i3c: master: Fix use-after-free of master->this

stable/6.12 was fixed.

Fixed status
stable/6.12: [23a1c4288a60e253a05a882bd8928ed61beb4a48]

CVE-2026-93204: batman-adv: dat: atomically update mac addresses

stable/5.10 was fixed.

Fixed status
stable/5.10: [181012b3d29c51197c235ee5871fc7512c736855]

CVE-2026-93231: lockd: fix swapped arguments in nlmsvc_match_ip()

stable/6.12 was fixed.

Fixed status
stable/6.12: [d34c2ac447fe0490ede828e0143e2cbcb59e6c77]

CVE-2026-93244: drm/sysfb: simpledrm: Improve stride validation

stable/6.12 was fixed.

Fixed status
stable/6.12: [b09d27caf49ff584dbafdba3bb95487a75cb8824]

CVE-2026-93284: drm/pagemap: dma-unmap pages before handling migration errors

stable/7.2 was fixed.

Fixed status
stable/7.2: [415f5a755cec5164b149037bf294e270b78d36c6]

CVE-2026-93285: f2fs: embed f2fs_gc_kthread in f2fs_sb_info

stable/6.12 was fixed.

Fixed status
stable/6.12: [7ee6be9ee7f9a803e0f539af26ab1154fdde48ba]

CVE-2026-93286: net: appletalk: fix NULL pointer dereference in aarp_send_ddp()

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [51cc5e756cec6071ffc620076aebcf5bae936668]
stable/5.15: [8c4b9ceb1be780588c1c50d573d5ee308e0874d2]
stable/6.1: [d643fd42ad96f19b5ce5cb11824fefa617191dbe]
stable/6.6: [542c1dd41e1b0cd1c2c3ba8091c7d882eea0d680]

CVE-2026-93287: i2c: smbus: reject oversized block transfers in the common path

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [856dffcc097b3d8ed45a643ebda07cb92968cb33]
stable/5.15: [356875e33f2c6d2061a02c9dec1a1e639d265a55]
stable/6.1: [72ca5e0b8b7a62615758f8871c34d61616c2dc8b]
stable/6.6: [df077253f6405d67ad087538e495ef32a05717b7]

CVE-2026-93288: netfilter: nfnetlink_log: wait for rcu grace period
before freeing pernet state

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [ba2e246aa294f9acd86194ea87fb6834ed0a37ac]
stable/6.1: [5570d6c8b320dbcc602617ee08c27ce752fed65a]
stable/6.6: [3b9aa62d78ce80de47af2db472ff452398755213]

CVE-2026-93781: scsi: core: Do not block on tag allocation in
scsi_eh_lock_door()

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [3bc7af4cefac1c583f0607f6183a67012436aad9]
stable/6.6: [6b450c277c106c4e31411067f025d1aaa27c2a02]

CVE-2026-93782: vhost-scsi: flush backend after device ioctls

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [6436411203d8c702ffc055700f1a6bde488ff681]
stable/5.15: [cec088285adcc7ae23c119b6bbdb22270dc2de8f]
stable/6.1: [e0bf6bed528693a6b32439ab122b34a34b66d96f]
stable/6.6: [be2636e1b21fe860db918152abf2932638d06ed7]

CVE-2026-93783: Bluetooth: RFCOMM: validate skb length in rfcomm_recv_frame

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [fb40eda15122f6b780228639c1ead6820340ff54]
stable/5.15: [3829af5fab5a22405bf1e7d69068c2ec0fce46ca]
stable/6.1: [b161eacd7fa4a2d765724b5504ac6cc388e48f80]
stable/6.6: [30d1d9f3495463f7c026e4c553127f79b486fcd6]

CVE-2026-93784: wifi: cfg80211: validate IEs in cfg80211_wext_siwgenie()

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [269498ce6c1e2132b072aa0c8660404926008f03]
stable/5.15: [685082f4be77f4657b498ebbe9f942ef65c492cf]
stable/6.1: [8b921a8993469a3482e0c67b5ce5cb6ce93f5f61]
stable/6.6: [d01f1600e8b075aa17adb751ac9881bb6ee40dcc]

CVE-2026-93785: cifs: validate idmap key payload length

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [eeac976b74b4f697cfc517187b7cbfd72652dbbc]
stable/5.15: [125b05ac8ca8758950e4369c1542d57a162f504c]
stable/6.1: [945f6cde6bcf8f08f6fa5df8882b1b9582e55efa]
stable/6.6: [3a4a34a732e8a08309eed0a74314dbd9f2f1c972]

CVE-2026-93786: ksmbd: preserve VFS inherited POSIX ACL mask

stable/6.6 was fixed.

Fixed status
stable/6.6: [4a19bb1c45667f5a5f6eff9cf6648e0f692d046f]

CVE-2026-93787: smb: client: bound dirent name against end of SMB
response in cifs_filldir

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [4cb3d79beee0fecc739ce07af915d503f29ae557]
stable/6.6: [cf87ef1e62ed31a439064cef69d6eec38c68bd92]

CVE-2026-93788: wifi: iwlwifi: acpi: validate WGDS table revision index

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [4f2ec7a0b3ff148cb13e14cb26ac43523df8b9f5]
stable/6.6: [9096509e63ddd349eb075ec447d1a714e87e17a4]

CVE-2026-93789: wifi: iwlwifi: bound aligned TLV advance in FW parser

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [61da42fdd21d98ccb8f1ec5224659f3d09202cf4]
stable/5.15: [8c332d45b736d41301b7e07f322785d821265dbc]
stable/6.1: [ce709fcab5e1d4df6d4ba980736dc5908502a40f]
stable/6.6: [4cfadb2e01566bc36d42922fbe18838345087050]

CVE-2026-93790: wifi: iwlwifi: mvm: fix out-of-bounds tid_data access
in BA notif

stable/6.6 was fixed.

Fixed status
stable/6.6: [35f991d685feafd27255bd33272512c434e52527]

CVE-2026-93791: wifi: iwlwifi: mvm: add a check on the tid coming from
the firmware

stable/6.6 was fixed.

Fixed status
stable/6.6: [0f690fd3b5535d110898b99ae6214f29c9060941]

CVE-2026-93792: wifi: iwlwifi: mvm: fix a possible underflow

stable/6.6 was fixed.

Fixed status
stable/6.6: [3ea815f401652003c2eec3b8969f74526f1342f0]

CVE-2026-93794: smb/client: flush dirty data before punching a hole

stable/6.6 was fixed.

Fixed status
stable/6.6: [216e469586057c29409e4ef8311d282388c6e251]

CVE-2026-93795: blk-cgroup: fix leaks and online flag on
radix_tree_insert failure

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [0f840db042caee9d2f3dcdcf97d6674f6e4c1e30]
stable/5.15: [f53945d7c712efe63fadbcc5ffed6370871fd0d3]
stable/6.1: [ada8270ccdb6f212da5eb22614c28ea418746a4a]
stable/6.6: [c3650be82ef6e7af13b79b2d10a7363bdf54aa7f]

CVE-2026-93797: wifi: iwlwifi: mvm: fix an off-by-1 boundary check

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [2c8c06c59ed72a42e4d32e222542b582b4911459]
stable/5.15: [23d3fddddd2bcedb4fd6cec5bef16b1fbb563019]
stable/6.1: [45fcdbae679861b90f08964a0c3e9eead3bacd6f]
stable/6.6: [7a2d4efea2c41b49db90907c8b6f37f8b63a9f50]

CVE-2026-93798: btrfs: fix reloc root cleanup in merge_reloc_roots()

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [29531470b1bf1e8bd2df4941fe913106edbca615]
stable/5.15: [415f8665a969d3c906e4fd7c90fcbb4b357886f6]
stable/6.1: [ee695a968aa73b1e67ccbf2133dc0e54381d32b2]
stable/6.6: [0bc25f0a2d1b3e0a691431c4d7aef36afcd527c5]

CVE-2026-93799: wifi: iwlwifi: mvm: validate sta_id in BA window status notif

stable/6.6 was fixed.

Fixed status
stable/6.6: [f9938eb95e2ddab4a58d3946a320abcbd60b56a4]

CVE-2026-93800: btrfs: fix use-after-free on reloc root after error in
insert_dirty_subvol()

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [5a247097c5f94b51ffc991b444d998ad6e85875f]
stable/5.15: [6372dd394ea907cd85a7a8063db320ec73dfaed0]
stable/6.1: [9f599d120b2b79d2d937c3935b7cdf2697514283]
stable/6.6: [a01837ae174a2a968c245a30e6dd010f50eaf05d]

CVE-2026-93802: wifi: rsi: validate beacon length before fixed buffer copy

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [795ba65f46fe44061f1195951c122cc8ec685d44]
stable/5.15: [66a964432b2758a4cf69962366e37581d6e70632]
stable/6.1: [7f99742c3c2801f8033d8b7a0a58254d7f24fb1e]
stable/6.6: [f08d7f3c916335a0e539f1c45c130615967fac47]

CVE-2026-93803: wifi: libipw: fix key index receive bound checks

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [bb18262c19feb690ddde58c70e3ad04bc6fe566e]
stable/5.15: [09d4a1bc3a08bb0e19bdf250b9f575cfef0bae82]
stable/6.1: [2836a870f612a8a6d9e390d00fa2cf6c90aa5808]
stable/6.6: [0b61c465ea62063593bc9ac186871b69e58ae991]

CVE-2026-93805: wifi: cfg80211: validate rx/tx MLME callback frame
lengths before access

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [6eb4bd50be53f5afbabb3a3b5153276e08fa7a4a]
stable/6.1: [ce2a3be6909462f49c34de96be71f0ad5f0d573f]
stable/6.6: [6bdf4dcff98df634e04ebf99f52027a48d7f78ff]

CVE-2026-93806: wifi: cfg80211: validate assoc response length before
status and IE access

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [3bcaaaa4ad334053ceea2ea2f0623f22afe2e1ac]
stable/6.6: [71be658246c903b9e96976a23c23800675896a1b]

CVE-2026-93807: wifi: rsi: avoid reading TKIP MIC keys for non-TKIP ciphers

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [6937b06d55b528e961feff8cc083b97ede622e02]
stable/5.15: [ebd7172f8c4edc232738ef50338fb773c6f6c208]
stable/6.1: [6b6690ac5c35e803df14afdc44312d11e8a60893]
stable/6.6: [5207727e53fba1e3a6fce9b2c15b6b8b06c6438b]

CVE-2026-93808: ALSA: usb-audio: caiaq: validate EP1 reply lengths

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [91acd231f219452fa58285239f83945accad9513]
stable/5.15: [7cc6b3745a0cea697c8d0684b3094f220281a08d]
stable/6.1: [add9328c91c195c494cd68a21b19e5e47a20d784]
stable/6.6: [319393151367e6626affedcdd4f7b7b0286f4246]

CVE-2026-93809: drm/amdgpu: flush pending RCU callbacks on module unload

stable/6.6 was fixed.

Fixed status
stable/6.6: [717db0d4368755a865bfda8bc9e7f7e5260ce763]

CVE-2026-93810: cachefiles: Fix double fput

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [e582a3e99584d5a634a3cbce4b12e9381fd5d964]
stable/6.6: [246098a2b8e88761e92cf82c1be1ec576437b176]

CVE-2026-93811: ksmbd: Fix acl.sd_buf memory leak and invalid sd_size
error handling

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [f46a70a082bdbfecbe074af8a719c26c4deb58c6]
stable/6.1: [86c2625fb9863139b359805fc6be1e31edbd3d65]
stable/6.6: [edc17db83085624a2b1bacf6a4521d7f15571737]

CVE-2026-93812: ksmbd: fix sd_ndr.data memory leak in ksmbd_vfs_set_sd_xattr

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [306d6f370da7e0e5532dc51c972f4ce101e42431]
stable/6.1: [dc55270e410ccb4d24e637c13b5c4c25bcd106d7]
stable/6.6: [c866c3314a6853eb06c7a8bef67f43c8a8bdfb6e]

CVE-2026-93813: btrfs: tree-checker: validate INODE_REF's namelen

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [60078a3e25c09d9d8fba828b0d81bb33e449a1b2]
stable/6.1: [509d6a4d889e425f305461d8323a7b39ca6c121c]
stable/6.6: [4cb41f07685f88ec724a375883bb0c731db8f6eb]

CVE-2026-93814: spi: core: Abort active target transfer on controller suspend

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [a75d9eb78c89d3fa8d503966c91a51f02eced768]
stable/6.6: [1cc84ca8599b8fa64014821bca453ebb3326c71e]

CVE-2026-93815: net: au1000: move free_irq out of the close-time
spinlocked section

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [f86bca5b7857b85bfa8afdb4fa895d7c0a3f7ebc]
stable/5.15: [26fd652915123a690f19d62b253b545a53f3cd51]
stable/6.1: [d514b08ed61fdffe23604fd3e9e53c07cbe5ac3e]
stable/6.6: [e1b5a13249975fec3cf654efa84f57118db2da2c]

CVE-2026-93816: f2fs: validate inline dentry name lengths before conversion

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [6b5552449fc5acb8e6ecf045b46702b29b71165a]
stable/5.15: [6343208fd73f3f2b8044c0922185cd13ff807693]
stable/6.1: [4dd81faa63fd54b9ba1a83c304e6d0bd03f1898d]
stable/6.6: [aee4e6de71ca77626c006166ff00f1d01ff990c9]

CVE-2026-93819: PCI: mediatek: Protect root bus removal with rescan lock

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [d54417acb22d9e8bc404a8598330bc9729ee7146]
stable/5.15: [5dd379acfa38c516e904bcfa693502cd585a0bba]
stable/6.1: [8d910649725955435c6a807944108bca0570712d]
stable/6.6: [31e33dcc896527b3ad790fdc6aa6b8d2995c078b]

CVE-2026-93820: PCI: rockchip: Protect root bus removal with rescan lock

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [025308e7c9cd10112b73558c9f63f8f7285fa726]
stable/5.15: [ac47d42901859edb504a2890a3a5709c86dbc0c3]
stable/6.1: [eaeb9bed3641741aceb0add84a97023bed61e748]
stable/6.6: [5d566ac3a055f0a6f4890ff0af7cfd7e8ed89652]

CVE-2026-93821: PCI: altera: Protect root bus removal with rescan lock

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [cf9d84d1b6a7c3f3780c043df220a7e9e38137eb]
stable/5.15: [fc462f1bdeaea9789928cbfdf5e069ee559c7642]
stable/6.1: [442b7f2a093b4a75f8963aaa7cbb2b8df35a6ac3]
stable/6.6: [4b69c63cc247fc0f499fbd11076fee9c2a6e6fd7]

CVE-2026-93822: PCI: iproc: Protect root bus removal with rescan lock

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [e7d9d7be2c1f8d434032983bc86a05805178c9c9]
stable/5.15: [1618e374ba4c7117c04662422ef985e9d64e2466]
stable/6.1: [4e1d34d824050a4e700ca442f815a95d9f214b83]
stable/6.6: [aaf4153caed9f1760b9f266612b0599bfd97150c]

CVE-2026-93823: drm/amdkfd: Let driver decide buffer size at
AMDKFD_IOC_GET_DMABUF_INFO ioctl

stable/6.6 was fixed.

Fixed status
stable/6.6: [d51841bb5ceee75ec3aeeb4e5c51c8e5e7524228]

CVE-2026-93824: tls: reject the combination of TLS and sockmap

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [c4896592744f30ff026f799947c5978bcfd7c8c7]
stable/6.6: [e26aa709454d48c3b3ef8d3100c8a04e7d9fd94e]

CVE-2026-93825: spi: Add NULL check for spi_get_device_id() in
spi_get_device_match_data()

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [1fa4484116d14a0356edfeb6ecc7ea3b370911b1]
stable/6.1: [aa966ccea3584a70c9a6030f4a16577030db35e5]
stable/6.6: [359b3442e66c595ed03e5a6b0493b66600c63941]

CVE-2026-93826: HID: hidpp: fix potential UAF in hidpp_connect_event()

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [e03fd646adad7f97fa4429ec5f38cee9bde5276e]
stable/6.6: [5d7637f4d050d105177217e64b869f56f9825060]

CVE-2026-93829: smb: client: fix races in cifsd thread creation

stable/6.6 was fixed.

Fixed status
stable/6.6: [cfa09f63e75cf440c9be97d1e73d509bfbb2c2c5]

CVE-2026-93830: net: stmmac: xgmac2: disable RBUE in default RX interrupt mask

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [8c9d57b5dc098b84631d0b3559c84c499ea2170a]
stable/5.15: [7a10e54e42a8f73a8d731f5a281fc06bb41b9250]
stable/6.1: [6b3b91433d5f4eae6865cdaa96f40cd67849e1f6]
stable/6.6: [74dbb85a6a254b5fc1f265a6cd61b2ba9d9221d7]

CVE-2026-97407: ASoC: rockchip: rockchip_pdm: Handle runtime PM resume
failures in set_fmt

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [105ea8b7a29b473cbe3aa1e542997700c98e3adc]
stable/5.15: [aa48db0257ed4cdb52f922d32872dcc8d201925e]
stable/6.1: [52b77346cf66174ab9bc34504729cd686a9e29b1]
stable/6.6: [7f0fd754c708785c31b067dd98649e3ec9b8fd72]

CVE-2026-97408: Bluetooth: L2CAP: validate connectionless PSM length

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [8104cd9859b6de0826cffa68adf2c1461185823b]
stable/5.15: [9448e6f693fcf1f0ac4ee648a9b2cc83bfe4a982]
stable/6.1: [22fc1ce4e37c81d4e7aac01566ebdc232214540d]
stable/6.6: [72e26293a231f63a856340d3a1f0f5fc29bf87e5]

CVE-2026-97409: nvme-fc: Do not cancel requests in io target before it
is initialized

stable/6.6 was fixed.

Fixed status
stable/6.6: [5488e2706c58444a24e15773237dcc0bedcd771f]

CVE-2026-97411: net: ibm: emac: mal: fix potential system hang in mal_remove()

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [9c1c814a662d9c81959eba591bb52b24639390f2]
stable/5.15: [34c4cae51718d6f393415e01c61314c1bde02f2e]
stable/6.1: [62126e73e230cf4bd6c27cf201949c4290af84a1]
stable/6.6: [f0399b3e212741bc5a64b8399d6266c4a150bdfe]

CVE-2026-97413: RDMA/rtrs-srv: Fix integer underflow in process_read
and process_write

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [6b1e26e70d7ca9f0906af2283558a530eeb1f066]
stable/6.1: [2c52b2afded988233cd4ccc185cf5147bbc77a76]
stable/6.6: [b042b4947752df0b3d16e683ac09fb4f7f0e33e0]

CVE-2026-97415: btrfs: tree-checker: validate names in ROOT_REF and ROOT_BACKREF

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [1370badf6b823ce3cde39a65f46f9e5dc7b4bf43]
stable/6.6: [ba6c4fc662853f6662e4db060cf88ee994053e21]

CVE-2026-97416: btrfs: balance: fix potential bg lookup failure in
btrfs_may_alloc_data_chunk()

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [9f37a6d6ae9e998232e2ba091ab4999cdf967e1b]
stable/5.15: [e479236a8f4d85c4fb6b3f7c2556c21f583e2bf2]
stable/6.1: [322f891b4d4fe64acb3351a0ffa62a7fa5ba7256]
stable/6.6: [81a664ed8b1a44c76b204c4bd0d751317a02c5cd]

CVE-2026-97417: netfilter: nf_conntrack: use get_unaligned_be32() in tcp_sack()

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [740ad3d17a281f7764dda4dbeb37cea52e2e31ae]
stable/5.15: [a0523267de2523522b0f70972dd1ffa22ec6176c]
stable/6.1: [55bcc3376cd7b18954cc9814da697504fdaf12bf]
stable/6.6: [0d5ad732e4fdc569eb85861115e8f7b4c2c67852]

CVE-2026-97418: ALSA: es18xx: check control allocation before private data setup

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [e6c84fe4cf6f98f7b1ad446a42cfcb46bae83f66]
stable/5.15: [908323ed61d5e7ad74889524d327cfb6a65ec8df]
stable/6.1: [3d8adddf4e4a5a43847ee62e5e78ba05e756bdef]
stable/6.6: [91c97a7969dae976de954453ab6e925e6522fecb]

CVE-2026-97419: hsr: broadcast netlink notifications in the device's
net namespace

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [9f13023607f1e95bd098cc49052b0c8955d334f9]
stable/5.15: [798ccb12810a58a37264685b28ddf990ef49559c]
stable/6.1: [9bf45feee630be868ab54e3d0f3d430c07471f0e]
stable/6.6: [016b8eaca53bfd57e84ea28b5c9174c89d7679e1]

CVE-2026-97420: bpf: NUL-terminate replaced sysctl value

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [bfcee1f79aaefa90679ad47690107fb7682724ec]
stable/5.15: [c73e4a04eedc677fe91a736d7a5db45100adba5e]
stable/6.1: [36d3e9f62dc2beb9299d3bb6f589cb9e07f773fe]
stable/6.6: [31377675c3d75603d957c08e338a9ac27e9f6cd5]

CVE-2026-97421: RDMA/umem: Be careful about boundary conditions in
ib_umem_find_best_pgsz()

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [3014da7587ce006cd08004fd6b257626b314e0a3]
stable/6.1: [ddccf6cc3861de2fe60986933bead79220e0d797]
stable/6.6: [e9bbb5f5349ef560ff6f0395564f04c3aa664559]

CVE-2026-97425: drm/amdgpu: fix buffer overflow during vBIOS update

stable/6.6 was fixed.

Fixed status
stable/6.6: [4a1b0a4c5acbe96368d71157b264dcd917ba6c9e]

CVE-2026-97427: drm/amd/pm: bound pp_dpm_set_pp_table() memcpy

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [abe61d067b48b947bedc9bae3725cb8f48dc8c0a]
stable/6.6: [9b5cb2e4eb297fe52be26fd895fc5ea28fc22bf9]

CVE-2026-97429: drm/amdkfd: fix UAF race in destroy_queue_cpsch

stable/6.6 was fixed.

Fixed status
stable/6.6: [090b51e2dabf88c02c0b6b25ea672a8bddfba7d5]

CVE-2026-97430: xhci: Prevent queuing new commands if xhci is inaccessible

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [0e2eaa000e4e5ad46b7cf8fcf1e4a2585ef8b5a8]
stable/5.15: [add3aeb74e2c7d82fa1035af2a027666c6906210]
stable/6.1: [a215190ef68ca3602fe00674e0efffad71beb3aa]
stable/6.6: [fec259e46d44317379834a44115fae66122dc93f]

CVE-2026-97434: dpaa2-switch: fix handling of NAPI on the remove path

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [d39603e21087e9ef9cd125e5895cdc70b2eb154d]
stable/6.1: [bd16f46d0796109d241d6311a7577f9956467c96]
stable/6.6: [c996faba71fc465ad12c6d177bd1a9ad974f9ee8]

CVE-2026-97435: net: dsa: sja1105: flower: reject cross-chip redirect

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [6bf5158af52a5293e9160d8f2992c629ca14aa7d]
stable/5.15: [277f8611e017d3ff1ab06af58a6c538b55da1cc8]
stable/6.1: [eb177aa00c392de3dc530c34f173a962216f82dd]
stable/6.6: [d0e54098c072b6064cdcf8039075ada8b88583da]

CVE-2026-97436: dpaa2-switch: rework FDB management on the bridge leave path

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [ec41bfd281a8bc8027a42d2674eac5b74947ff7a]
stable/6.1: [e07ff2338f45adbf572850335d761c2f97545935]
stable/6.6: [dc626f2abb3052881911b6166a9425739ce80085]

CVE-2026-97437: ntfs3: fix out-of-bounds read in ntfs_dir_emit() and
hdr_find_e()

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [d1f98938e437732c0ecdfc8ee451e12a072f6d07]
stable/6.1: [0505f1e7bb5b981b6ed62d98b26ddce76142865d]
stable/6.6: [2f7d0ec8c10dc7bf7a8c9a9cb169f9a4d1fac2ba]

CVE-2026-97438: fs/ntfs3: validate index entry key bounds

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [c8d93bc4823baecab3c39b877e16ac5f8d4d41ba]
stable/6.1: [7feeb424bda7f6ffaf5090cdd01b300eaa74c02b]
stable/6.6: [d564a885219a655077eefafeb72395a4580ebd69]

CVE-2026-97439: fs/ntfs3: preserve non-DOS attribute bits in system.dos_attrib

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [533217b90addd57cc16f1c974e023c72d18949c7]
stable/6.1: [f2d6bc89e2236939df189831707c8cdad199f57a]
stable/6.6: [fdc9f65aa6631df04238c6154713bacd5133d77c]

CVE-2026-97440: net: qrtr: fix node refcount leak on ctrl packet alloc failure

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [78d066ecac9ce50441d4affae0df2093c4c3e62e]
stable/5.15: [f3e90fbcd2d5ec1632bc2e8cdd1218f56bcb5fcf]
stable/6.1: [c3515740174b778d0ee44acc477b51a6478da6b8]
stable/6.6: [f76a39c45182d9137e053081cee9f2c197404ce6]

CVE-2026-97441: ata: ahci: fail probe if BAR too small for claimed ports

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [533a08ea11217100cec7a0ed903cb9b9c892d6f1]
stable/5.15: [c717b20100ef8cd06b5237af70ea2cb692e058ce]
stable/6.1: [ff0ab535f8febbd32afa5832f8d2d9b06a8d5060]
stable/6.6: [6d29b91164424256a759ddabc8f2de1ae09bd3f1]

CVE-2026-97442: wifi: ath11k: fix invalid data access in
ath11k_dp_rx_h_undecap_nwifi

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [958cf3696ddc5ccafd3d0b8b0c03d90bcd771c0c]
stable/6.6: [b4ef30f1d107aae460edf731a7c2d187fbc46a32]

CVE-2026-97443: perf/ftrace: Fix WARNING in __unregister_ftrace_function

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [5fc7a10746ad91c4c7ce370cc6cf2d31beaad028]
stable/5.15: [1493aa15ecc61e4ab313ce4a67822e4062321779]
stable/6.1: [9ef0fd42dc866f1c915550ae67857c63fcb1d6c0]
stable/6.6: [d85b5591ea4595b4d19e27ed7b4ce401e246aefc]

CVE-2026-97444: ACPICA: add boundary checks in two places

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [3a8c1efc0fd3abb2d2b1254315f36db03abc88eb]
stable/5.15: [c917df56b73719a2d4cee1c4ab4a6626acb95315]
stable/6.1: [4f03d84c95a51436878cd750a14f8ca37eeb3112]
stable/6.6: [38ee32a9ace6fae8965f059b38e6e7fb27b1e7ce]

CVE-2026-97445: ACPICA: Enhance buffer validation in
acpi_ut_walk_aml_resources()

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [816badec122fe01d05265f2d306212739f5d3fdb]
stable/5.15: [cd60a407a3a6d75347a04f9271b7b561d06d21c8]
stable/6.1: [37c794f87a72471f7ef71633ac0550ad14ac0885]
stable/6.6: [50a11e2f3dc8a7189e7ebbd3eeafa51f16128a56]

CVE-2026-97446: ACPICA: Fix NULL pointer dereference in acpi_ns_custom_package()

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [fad537538cdfcdc51e41db61bbf9ebe5ed9427eb]
stable/5.15: [9936507ac0f2379787a2a805b11ab1cf0f241372]
stable/6.1: [644888605f55395e6012ed43e3ed643ef7ab5013]
stable/6.6: [08c5dee5da1d8d99b5a4e94db5a3d873c491771e]

CVE-2026-97447: ACPICA: Enhance OEM ID and Table ID validation in
acpi_ex_load_table_op()

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [8b7522d0073032beb5dc061c8b7f77779ac7f8b4]
stable/6.6: [e301b6132be066cffc75fd05e045d3af6b553675]

CVE-2026-97448: ACPICA: Add validation for node in
acpi_ns_build_normalized_path()

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [087eed8b347e14864f8806fa1f5976c7dc2c6792]
stable/5.15: [b06bb9b82c8f9a522dde213b1e0ddd535f22e3a2]
stable/6.1: [90ebe7f8bb6ca1c6eadb16bed141ab8bb3dbab70]
stable/6.6: [26dd27000e9540fcb594f15010b0696b03b0d240]

CVE-2026-97449: ACPICA: Add package limit checks in parser functions

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [c82d4adeeb5acbd5231f082da11155017a4c241e]
stable/5.15: [7beb63a99f43c090ec235e44773bd906b3fded9f]
stable/6.1: [55594743fb6935d046cb6ce1e9f588828b43f3e9]
stable/6.6: [2442772fd79a440c067936f307c4948c570d6f81]

CVE-2026-97450: ACPICA: validate handler object type in two places

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [7af2da201623ab5bc0773bd3eeb2f2345cfa1c4a]
stable/5.15: [9d9fbf6b895a23238e4a7b1a3230f648f0d952a1]
stable/6.1: [e98825650c2eb1605c707fd1391ceed65bb8e481]
stable/6.6: [254e304f68dc079906ce2df4723548ffe35f682a]

CVE-2026-97451: ACPICA: Fix integer overflow in
acpi_ex_opcode_3A_1T_1R() (mid_op)

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [6da963ed4c3de0963c23809af3194323328080d2]
stable/5.15: [e539003886b34c8109574820b9ba67f0dbe62a12]
stable/6.1: [9010ad440f970e684324d507510415a67bc125e4]
stable/6.6: [4532c9cf006bb6323957897455b6a5ab45957a19]

CVE-2026-97452: ACPICA: Prevent adding invalid references

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [2350a6f89eca45f9219f37b331e4083f96299996]
stable/5.15: [61cb905c33d0e0c6ff3c9c90fb269331bce8c2c0]
stable/6.1: [d239ccf5069f892cc36b9befafda030b3ca789e6]
stable/6.6: [c2cf936b07b0a298637e56e53ef043c7ff8eee31]

CVE-2026-97453: ACPICA: validate byte_count in acpi_ps_get_next_package_length()

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [6b9904fc65d82bea4922a33038d075488954bcc9]
stable/5.15: [802f83e628b8fa6106428ef05d3fb03f99816fd6]
stable/6.1: [37e60db04eed9d6c5801d63f99cfd3af99b9a2c8]
stable/6.6: [6e0d26e6ec90340533722214b7a923521f91caa2]

CVE-2026-97454: ACPICA: add boundary checks in acpi_ps_get_next_field()

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [1d704a9ba665f8d1598fc6f37a76cbd6547cdcb1]
stable/5.15: [6ecf2a4855a728c4c46e33919fea9480052d62a7]
stable/6.1: [6509f56df51235fe447b624e40c098082717625c]
stable/6.6: [7d97ecf2a4c7a77a9daa3fe76790ddecddc9cd0c]

CVE-2026-97455: ACPICA: Fix use-after-free in acpi_ds_terminate_control_method()

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [460aed7b408508a2c28ca4fdd8d90a82bb4005aa]
stable/5.15: [3855d8992f5a88b033925cc4f6aef7a485f326cb]
stable/6.1: [2793b1c38f0053fd9b119ce4607dd056eb05d382]
stable/6.6: [63ca6f67816a229e07a08cac4bef1b3858abde66]

CVE-2026-97456: ACPICA: Fix condition check in acpi_ps_parse_loop()

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [c838d32fbe02a6d426aebf95d2aef97de92ddc43]
stable/5.15: [b79f5cb2131956a7d2c99870336d9fcc6db80c4b]
stable/6.1: [de2bbc8dbe7048f20f0a783a81e712fd3664de5b]
stable/6.6: [4c22c9842c53b824743bdf1d8d19e1cdb908f82e]

CVE-2026-97472: ipv6: addrconf: fix temp address generation after
prefix deprecation

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [b00f7c1da82a809156f785ed37536c2d2584927d]
stable/5.15: [6da8ba900b85e6478e211427630c67595fb707a4]
stable/6.1: [4f7d2a8dc364c4e55d0a1533451339008512933f]
stable/6.6: [f601ec5c92b3260c742f27a5d2fd289e30ae798f]

CVE-2026-97475: thermal/drivers/tegra/soctherma: Switch to devm
cooling device registration

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [78a2ba09fd7501df09239c7e3c311c80c259ed31]
stable/5.15: [0c65f786a69402620306828aa19817fd71f37f4b]
stable/6.1: [e777ab46db8c2addffe801274d713252318ef750]
stable/6.6: [a643ce49ddcdbdec173e7bbf4c32c897e0293ba9]

CVE-2026-97476: rds: filter RDS_INFO_* getsockopt by caller's netns

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [64ca5839916176c3451f61a2c7178033423c67d7]
stable/5.15: [8b04dda272c30d46834bb03dd2895b08c090483b]
stable/6.1: [f05142d0eeaa6e8227511c88e10a2b8fe7a78fc4]
stable/6.6: [65fae4b42269dbea7e3842ae4dd0786162c6248e]

CVE-2026-97481: serial: 8250: fix possible ISR soft lockup

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [4bce4a6f6318035d77d6b6199527b1950bb015f4]
stable/5.15: [8b67af8cd90542b2607623e3282811849e191b79]
stable/6.1: [95d0b40c0623fd2b58c753f8dd6adda7263e3cd1]
stable/6.6: [03ed804a0ddc3d069faf94c47f9e702afe5ca084]

CVE-2026-97482: usb: gadget: goku_udc: avoid NULL deref of dev->driver
in INT_USBRESET log

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [d7b33afbf9b54b61cb423af9663df54eae11d3b1]
stable/5.15: [ea2901a4a90afc662e4d023542d91f10ab10fd3c]
stable/6.1: [999ff3bf665f2abfb6af519ef3d6d42b061d3c15]
stable/6.6: [a018d4195114ca2cf79858cc45c98581dee4795b]

CVE-2026-97483: usb: core: hcd: fix possible deadlock in rh control transfers

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [8461eda5af77c44d216cec66455bd5b01ee35c9a]
stable/5.15: [8f82fc3d72e5feb7a1efae94b51b431c5bf41c86]
stable/6.1: [936b08d87c667031725bcc753007e7c1182548c6]
stable/6.6: [d0291fb4d91982d9f6a680bf759ff0555d351ecb]

CVE-2026-97484: usbip: vhci_hcd: fix NULL deref in status_show_vhci

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [2b477ee5cc9c2670185ffd82911a20e1760008c2]
stable/5.15: [671d2687a790f63110c3c4213230209f5c3e0e8e]
stable/6.1: [fd7d938ab4759a45eb107e658c199a2c47cc1ace]
stable/6.6: [517c353e5358b2123cbf620a1798fe632fb7bdce]

CVE-2026-97485: omfs: handle set_blocksize failures

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [a2a3592ebf3920dd6f2b754d2bb7361f54764e84]
stable/5.15: [d81e1e9bd1df5948c699cb5aec984acdef5b2681]
stable/6.1: [120e0db84a69f18e51ba9ae2d036df3a052a33e1]
stable/6.6: [29186cd17bb5f501a6ae831dac4fabf637879982]

CVE-2026-97486: hpfs: handle set_blocksize failures

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [f7b0cde62edb8ceff8bcc17ba3f1b086646fff89]
stable/5.15: [b618f681acb6748faf95eee9af2aac5455a74e68]
stable/6.1: [10f226687bcb07ed925a453b6f25e817165d113b]
stable/6.6: [0451927f42b0282d80d402e8e8c46ff34e9f606f]

CVE-2026-97487: jfs: handle set_blocksize failures

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [e2712fa5c02cd1b3e40d45bc8ce581f3c67bf4b4]
stable/5.15: [deb9400a38849e03210c9169b777e89e74debe96]
stable/6.1: [a0eaa3f4b6dcc829228752f6255f0e45cc94b273]
stable/6.6: [87d6852f06c5a29f757f7b7ad1423e4cbd0f2cad]

CVE-2026-97488: qnx4: handle set_blocksize failures

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [de8bd760ca0c2a3f337bbafbeb1dcad0853787cc]
stable/5.15: [3f2088a3973faf3ed9b56ea3d3f0240b9a797016]
stable/6.1: [c9f03e750d9ddf0f42c24e3ba683f26e377ffd72]
stable/6.6: [f83e416c2242fb298ad33b756c83aae75d9e359c]

CVE-2026-97489: bfs: handle set_blocksize failures

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [965b53ee91cfda3faf8bd0d0ffff5f70c7d1c479]
stable/5.15: [0fe260d82555ffebfb627cd23cbb6e880399804c]
stable/6.1: [c6d069c34d57414c039167967ef826a8516c98f3]
stable/6.6: [8a96010d230a8c83181137d88bad4bf71d862628]

CVE-2026-97490: affs: handle set_blocksize failures

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [f5d65b2811872e8f8b424860fa7c2500afbbc5a6]
stable/5.15: [c7f29c5d999093629712c63792abda89a36b428d]
stable/6.1: [d05b0ee9b42cb3cc499272d1bc91609f7492a1a8]
stable/6.6: [ea8a4a9f3cc101207611be724a8b83838de9a93f]

CVE-2026-97491: net/rds: Don't sleep inside rds_ib_conn_path_shutdown

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [b3621acf640e32dcb986d9b3767f2387f29dad05]
stable/5.15: [ac0bc28da5150c4fa81a76172fff5ec70f2063eb]
stable/6.1: [934a6381c79d815680c955d676791322e020bfda]
stable/6.6: [07a348d48e589b91a0d5a5cfa0de137cc703fabf]

CVE-2026-97492: wifi: mac80211: don't call
ieee80211_handle_reconfig_failure when not needed

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [026637b864b16dfae238e7e1accded820a3d7ae8]
stable/5.15: [6ef85dd9f8c62c9a465a32901d09475a114e67bd]
stable/6.1: [f27a5bda84ff3b0fea3de7572ff48e518e66cf5d]

CVE-2026-97495: drm/amdkfd: Check bounds on allocate_doorbell

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [7e06636260a2d95e3fa181bc337d0eeb812b7a41]
stable/6.6: [3d2ddfc9b361b0d38c3ff4804ce42503e4bc97de]

CVE-2026-97496: drm/amdkfd: Fix OOB memory exposure in get_wave_state()

stable/6.6 was fixed.

Fixed status
stable/6.6: [e2bef0f168be46692a6b900916ff5da3771480ed]

CVE-2026-97497: drm/amdkfd: Check bounds for allocate_sdma_queue restore_sdma_id

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [41460d2dd0246f0ab7e80b103d34c8649e022999]
stable/6.6: [25e1b29ecc8da3609ba0072ca54a3b1fdd1578f3]

CVE-2026-97500: wifi: rtw89: phy: check length before parsing PHY status IE

stable/6.6 was fixed.

Fixed status
stable/6.6: [72bf6944e336d6f046f5c886ebededdd6560a693]

CVE-2026-97502: mmc: davinci: avoid NULL deref of host->data in IRQ handler

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [51738de7dd5f8e8b33dfc07ef85bc06d3bf41e96]
stable/5.15: [f216cf00e829895ff49bdf695c944915e59bd698]
stable/6.1: [a0cde8d70d64c1a75fbd57f01d9f2d7cccac8319]
stable/6.6: [3c5e3e5badbf0592332887d12db02458323682c3]

CVE-2026-97506: crypto: ixp4xx - fix buffer chain unwind on allocation failure

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [d4007867be42d71795b78fa7f8ce7514dda9ca83]
stable/6.1: [4918b0bd7d2baafb45d87dca9e322137c96005c2]
stable/6.6: [8c37bc8d6a6f77bf9593fb1bcab6c14c7cf02991]

CVE-2026-97507: media: dm1105: fix missing error check for dma_alloc_coherent

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [a2017c80dd7f3c409778ca0898d6e75ccab6d2f2]
stable/5.15: [e96f91da5c83e4c1f1bebe1c58856d02cea4afd9]
stable/6.1: [3ff12d5ea9cb0d0fd89c24b69940f0b989bf6d2a]
stable/6.6: [b6327023dcc7482156fc13cda6361ee573721b05]

CVE-2026-97508: thunderbolt: Set tb->root_switch to NULL when domain is stopped

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [d9a638e7bc87e0e6fe3a75517ac481e72fc0058c]
stable/5.15: [66b0fe27e277713c2b9f3c452c76330ed0bd7eaf]
stable/6.1: [54ad3415cc211ca0d64ae1bf3234d6eb5c6aedd0]
stable/6.6: [83d1af5b1b6e6c96ffa633ca2c9a77f6f4c93efa]

CVE-2026-97509: thunderbolt: Keep XDomain reference during the
lifetime of a service

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [cca72fe513f3d6b1279fe83483f8a8990adbe0c6]
stable/6.6: [57359bb31526c2f1bb0a7b9b69d8b8a6bd3f0e9f]

CVE-2026-97510: thunderbolt: Release request if tb_cfg_request() fails
in __tb_xdomain_response()

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [dbc8a8dd7c1930043c473818fcadcf88cb5e1c4d]
stable/5.15: [487ee7dbad21d1e757f5dd490ac182aebfa5f689]
stable/6.1: [000189b249e45e63ee873d0c59c3be1805349681]
stable/6.6: [9d6657674919bef57c8a7195170263f3456e9876]

CVE-2026-97512: spi: spi-qcom-qspi: Fix incomplete error handling in runtime PM

stable/6.6 was fixed.

Fixed status
stable/6.6: [d9fa79ccd09204f626d382bdde1b8f5f4c5d03b3]

CVE-2026-97516: wifi: rtw88: Add NULL check for chip->edcca_th in
rtw_fw_adaptivity_result()

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [a8cdb18ef80d67790d8611ba94ae3d81901c9e04]
stable/6.6: [0b58a5ac9170a6f5e6425f8e1a4b3e1d9c2bf53d]

CVE-2026-97517: wifi: nl80211: reject beacons with bad HE operation

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [6e24f72985782013bf2feb0f0712b2ac9390e909]
stable/6.6: [8fe5eb7b68d76b3801409ada7365c67696e7af84]

CVE-2026-97522: mptcp: fix bad accounting in __mptcp_subflow_push_pending()

stable/6.6 was fixed.

Fixed status
stable/6.6: [ddbf9f03c1cc7d5b86eebe7c2beea0db4286d354]

CVE-2026-97523: mptcp: close race between scheduler and state change

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [2f8c4d57b312912f6807ced9c47095c2a233bbaa]
stable/5.15: [d74b2e26b54a7dae1d87c1f19ae0d6db500e5e03]
stable/6.1: [5883ae880f51edc4b1484e787473b865b6159ead]
stable/6.6: [0a926b5df8efdfbac07e2fb7fafb21849a2ad9c0]

CVE-2026-97524: mptcp: avoid unneeded actions on subflow reset

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [6d669c740933124eae3df8cfc15995af9bcc6aba]
stable/5.15: [83a7dcdd2b1060484528da70a643125174d47e5a]
stable/6.1: [a370e56024df0b07e3120c45a9773ae123819fd6]
stable/6.6: [1962841387087970d75ba8b8d4c2aa2d45705e50]

CVE-2026-97527: scsi: qla2xxx: Serialize NVMe unsol ctx list with a
per-fcport lock

stable/6.12 was fixed.

Fixed status
stable/6.12: [c1ee12eecbab9674fb73c9e00a93fac655d5a5dc]

CVE-2026-97528: scsi: qla2xxx: Unlink NVMe unsol ctx before freeing on
LS reject error

stable/6.12 was fixed.

Fixed status
stable/6.12: [cbbf1484496aac86038e67ac984949af58009d4b]

CVE-2026-97529: scsi: qla2xxx: Validate BSG request_len before reading
vendor_cmd[]

stable/6.12 was fixed.

Fixed status
stable/6.12: [ef63922d8bdea03de1804af39a6b12212acb1be2]

CVE-2026-97530: scsi: qla2xxx: Fix soft lockup polling continuation
IOCB signature

stable/6.12 was fixed.

Fixed status
stable/6.12: [3e58eb888ebf265af937f636d05997c60d2f197c]

CVE-2026-97531: scsi: qla2xxx: Skip vport under deletion in report ID
acquisition

stable/6.12 was fixed.

Fixed status
stable/6.12: [20bb54601d2655e83795b73499c89f6b1cb31016]

CVE-2026-97532: scsi: qla2xxx: Null out freed pointers in
qla2x00_mem_alloc() error path

stable/6.12 was fixed.

Fixed status
stable/6.12: [84f5de696b8c924aeb4bf430a0bdc762fc50e99f]

CVE-2026-97534: f2fs: accurately adjust free_sections during free_segment_range

stable/6.12 was fixed.

Fixed status
stable/6.12: [faeb0a20bdd113311519b598dcc075af3b6fb366]

CVE-2026-97535: scsi: qla2xxx: Bound VP index against VP_CTRL IOCB bitmap size

stable/6.12 was fixed.

Fixed status
stable/6.12: [c80a0362a0fe548c15a0324b1f61c04b62bb2174]

CVE-2026-97536: scsi: qla2xxx: Fix use-after-free of qpair work on
queue teardown

stable/6.12 was fixed.

Fixed status
stable/6.12: [dd6c14db0dbb7774278e62c8114902f953540932]

CVE-2026-97537: scsi: qla2xxx: Fix queue teardown NULL dma_free and
bitmap locking

stable/6.12 was fixed.

Fixed status
stable/6.12: [56e25d716833604fd5bff388e472f290bfe793aa]

CVE-2026-97539: usb: xusbatm: don't rely on id table pointer arithmetic

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [ee4006c2175e8b50ff5d47a54bff52eb29bb1f0d]
stable/6.6: [5086f5639197f321b766cec0dce383492eaf2305]

CVE-2026-97540: net: usb: pegasus: don't rely on id table pointer arithmetic

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [7c940a1100cb0aa18a54dc48d736c0525c0f400c]
stable/6.6: [05d47f540d85c8f6697ec5cfc1aa7b4f96a5b31b]

CVE-2026-97541: wifi: ath9k_htc: don't store usb_device_id

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [664ef8ce390fa6575c3a3dc003f9ccdd7cca9932]
stable/6.6: [8cb99d4a715939b9fcea3341b08eaf4b9e0cc44b]

CVE-2026-97542: xfs: bail out on bitmap errors in xrep_agfl_fill

stable/6.6 was fixed.

Fixed status
stable/6.6: [c2bf1299aeff6db186aa0db8d19328e1816f0e39]

CVE-2026-97549: xfs: fix under-reservation of blocks when repairing sf
directories

stable/6.12 was fixed.

Fixed status
stable/6.12: [996cce0c422b66a0e8b1a99505f896b0669ee5b6]

CVE-2026-97555: smb: client: fix heap overflow in DACL owner/group rewrite

stable/6.6 was fixed.

Fixed status
stable/6.6: [d5cea6766ae1868a51c7d17d77d065b4f55c587f]

CVE-2026-97556: smb: client: avoid leaking refcount when cifs_sb_tlink() fails

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [55c5f095d4df14271b238f826e1392fda7b6e60e]
stable/6.6: [e9c5bcc88b8337157e480c85a6d2f326bc265012]

CVE-2026-97557: smb: client: avoid leaking refcount in cifs_queue_oplock_break()

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [735a3a610136ae10f381d0909dff38e5b5c5f056]
stable/6.6: [de2a6bcff2659bea40c7485115b57f0ae189fc01]

CVE-2026-97559: smb: client: fail DACL rewrite when the new DACL exceeds 64K

stable/6.12 was fixed.

Fixed status
stable/6.12: [d433376abc47e10870ae732f89c7c1a60b199a0c]

CVE-2026-97560: smb: client: fix one-byte OOB read in
smb2_parse_native_symlink()

stable/6.6 was fixed.

Fixed status
stable/6.6: [ff411fcbfc55eec1d66ea82483d254319dc8e973]

CVE-2026-97562: smb: client: pin DFS superblock in iterator callback

stable/6.6 was fixed.

Fixed status
stable/6.6: [3c9acc9835c304013a4faeb969fe9333d66ca9f8]

CVE-2026-97564: smb: client: reject userspace cifs.idmap descriptions

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [f29c1ec0e7d8c887a91df3f93bb4617c0ac95c6a]
stable/6.6: [17c93bcd17755523c21abb22cbf2a41a6eb0caaf]

CVE-2026-97566: mptcp: pm: kernel: drop pending ADD_ADDR when removing ID0

stable/6.12 was fixed.

Fixed status
stable/6.12: [bacf23e7c9876c9f4170166b3597cb22ea3ed39b]

CVE-2026-97568: mptcp: syncookies: remember the request backup flag

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [c97fa2c7ada82d4cac1c6c00643238dc4c462f15]
stable/5.15: [1668b34452009d27be3262646de748a3e48ffd51]
stable/6.1: [b138e7dc719f0a3949de8bb6500b8cf1604eea06]
stable/6.6: [360d99258a6402cb8e49771460944f19f04d25b7]

CVE-2026-97571: bnxt_en: Propagate TPA buffer allocation failures in
bnxt_queue_mem_alloc()

stable/6.12 was fixed.

Fixed status
stable/6.12: [d7db2e4953e4626339fd0075564a3e447650d37b]

CVE-2026-97572: bnxt_en: Propagate RX ring init failures in bnxt_init_nic()

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [e40641638743b4b848d5ed78a0565afffc359d8e]
stable/5.15: [6b24eca42619b93f69aebc2aa0a9fd28ac9a5085]
stable/6.1: [1f2d333ae2e1a73b7cc1c2a627587024cd147c01]
stable/6.6: [c3eb07e78e628243cbb9bbb0115db802fb7a303f]

CVE-2026-97573: bnxt_en: Handle buffer allocation failure in
bnxt_rx_ring_reset()

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [52fc97cbc3ba118aad84e7c001bf02ebe8496f70]
stable/5.15: [40b4a7bb6b0b872b45f017dbf211268de098b75c]
stable/6.1: [af9a2bdaba0b4ceb0fc5e5122ef3fc6b7e5a366a]
stable/6.6: [cfec9e7f15a56cb0104bac13d01e5d11e1ba84fb]

CVE-2026-97574: bnxt_en: Don't free the live ring's TPA state on queue
restart failure

stable/6.12 was fixed.

Fixed status
stable/6.12: [e42287b4d38d653f7d4a47f6c29b0c01288bb050]

CVE-2026-97575: media: v4l2-ctrls: validate AV1 tile counts

stable/6.6 was fixed.

Fixed status
stable/6.6: [1afaf85c4990fb1e3168d0d6e99246a65e526f1b]

CVE-2026-97576: media: v4l2-ctrls: validate HEVC tile counts

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [9c0a718e24d4cd6d975f3df9740f968f62891a20]
stable/6.1: [975e0180488966bb709092a52408604bd4f4edd9]
stable/6.6: [724915535558b14c111ad8a498b896026dfe8d20]

CVE-2026-97577: media: verisilicon: rockchip: reject AV1 frames
exceeding the tile capacity

stable/6.6 was fixed.

Fixed status
stable/6.6: [95ee48eb17c91bd4859b65e0a54e7722f370d0e5]

CVE-2026-97578: media: verisilicon: rockchip: guard VPU981 AV1 divisor
and tile buffer

stable/6.6 was fixed.

Fixed status
stable/6.6: [8659e5fc21a82e00fb2db1557f2e06f0fca06b90]

CVE-2026-97579: media: mediatek: vcodec: bound AV1 tile-start copy to
the array capacity

stable/6.6 was fixed.

Fixed status
stable/6.6: [f19acf00818a9eada06a77715d0188c181fb435e]

CVE-2026-97581: media: verisilicon: hantro: bound G2 HEVC tile loop to
the buffer capacity

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [6d192fc0d6faff25ecf6d52cbde4b939cb12c192]
stable/6.6: [2887a98c03d97a6fcb6c2dab92956f2f4c402cdd]

CVE-2026-97582: hwmon: (gpio-fan) Fix use-after-free in alarm work

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [594c62eea7c82f526054496e9fa9b895122a8016]
stable/6.1: [6e67d9bdac810edacef78cbaeedd34445aa8ceb7]
stable/6.6: [e9fc7d53b2eb34c0a607d1659f49b46911aaf16c]

CVE-2026-97592: s390/crypto: Fix missing scrub of temp buffers with
AES ctr and gcm algorithm

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [538f00558db9a66aeff20c36f43692c178a0e0eb]
stable/5.15: [6ab772d675a885c3119bf0e79ea9e84756d7657a]
stable/6.1: [e17b85eb8cee90a1200fa5e7806db7ffa08a0608]
stable/6.6: [991c875310254a13b3a637bb279379c8c66e842d]

CVE-2026-97594: landlock: Fix use-after-free of the source's parent directory

stable/6.12 was fixed.

Fixed status
stable/6.12: [4c37992b9668c4f37aae41dd95c369f7b6009915]

CVE-2026-97595: mac802154: fix use-after-free of sdata via queued RX frames

stable/6.6 was fixed.

Fixed status
stable/6.6: [4826fd8373f684f9952536333ad45b26acd3455d]

CVE-2026-97596: ipvs: reject invalid states in connection template sync records

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [5677e81ffdbfc1c03dcb427fb8b1c38289bed76d]
stable/5.15: [d4eb339b442a0ffaa565779b975494a0a0664f18]
stable/6.1: [1a8f15911352bb3cf4663aa02049c49c7f30e524]
stable/6.6: [652d9caa5ac925ab012834e325d77b9ed638d4fc]

CVE-2026-97597: ipv6: flowlabel: cap duplicate leases per socket

stable/6.12 was fixed.

Fixed status
stable/6.12: [6d917992c22b6029fc2dc1bd464b7f6709357161]

CVE-2026-97598: ipv4: fib: bound automatic table ID allocation

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [999bc00588cb305ab25065e8a8ac31da7465301c]
stable/5.15: [f1f2da33eaab54b4d5cdea6d70befb2e2fb49cb6]
stable/6.1: [125890702ef4417cd0ffac2e448c0cd4fbf0ac45]
stable/6.6: [3080f9e653d8c057d5652db5ced8137f81b3fcbd]

CVE-2026-97599: ieee802154: hwsim: serialize pib updates to fix double-free

stable/6.6 was fixed.

Fixed status
stable/6.6: [e3b4681197aa026bd2d79358de5a3d62b76b04b9]

CVE-2026-97601: ieee802154: 6lowpan: fix NULL dereference in lowpan_newlink

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [a1760f21c32adce41af5ed5687200865d8feaaeb]
stable/5.15: [5063b9354e6e285dae61e530b30458498444a914]
stable/6.1: [16d8e0b560d50cd1a9e6d77a9a154a94c4d6021e]
stable/6.6: [543994fa03c36a91d967a12c5c99cae74899504c]

CVE-2026-97602: inet: frags: invalidate queues before flushing them

stable/6.6 was fixed.

Fixed status
stable/6.6: [ff83367cda8eefbd62007ef1dff4f8104226d18a]

CVE-2026-97603: idpf: disable DIM work before freeing q_vectors

stable/6.12 was fixed.

Fixed status
stable/6.12: [7d64d4c6bb6bb63b6cdb7de133c3ec48333b27b5]

CVE-2026-97604: fbdev: vfb: defer cleanup until the last reference

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [bf49eac7ed11aabd0b9b790c062742a8e4be97c6]
stable/5.15: [040ce3950f64a11e9ee5646c8aaa91fd2e29e245]
stable/6.1: [ab664e279eb2a68e55895dd115a9488807280f07]
stable/6.6: [de5a0eda59fe4b3eacd1a67c992e54766bb6683f]

CVE-2026-97607: vdpa: ifcvf: Put device on unsupported feature error

stable/6.6 was fixed.

Fixed status
stable/6.6: [123acfd63d7677232a5ba2d9761c9045243ea3e2]

CVE-2026-97608: netfilter: nf_log: unregister loggers before per-net teardown

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [51417230716b73f6aa1dc402b3a56d3382a694dc]
stable/6.1: [b0514ca1ee6f2b708d6c602ea946acdfc6a90e24]
stable/6.6: [90166834b7dc6131aa42b6b14b8b4ed47be97079]

CVE-2026-97609: netfilter: cttimeout: prevent UAF during module unload

stable/6.12 was fixed.

Fixed status
stable/6.12: [73f353bec62509c776184e49a031c6145cec0d05]

CVE-2026-97611: net: openvswitch: fix use-after-free of the flow table
mask array

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [4c98b492e9ed63f9ca3e23566d9a6a4f235944f4]
stable/5.15: [4016ead17acd75312c066ecd47c4b7f0a81ceaa2]
stable/6.1: [017dbbf0d6c319a487f68e22f56d91fc787d5525]
stable/6.6: [76678217cdabc41e3c74c23b45b62086ffb8fe7a]

CVE-2026-97612: net: mpls: clear inner_protocol when the last label is popped

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [55ed97db27bffe29c21fdefd5d25601322c36ff8]
stable/5.15: [833ec2788322306407503b4cfc7745cd1f9d785f]
stable/6.1: [38db09804b2616aa1e2fcdf97f0c3ae8b9dbdd34]
stable/6.6: [0b3425fd0ecd515997956f7bb8a8a576b444ed64]

CVE-2026-97613: net: mana: Reserve extra CQ slot for the fence completion CQE

stable/6.6 was fixed.

Fixed status
stable/6.6: [f7d76b84b9206eef4320d8ab715d65f944535acf]

CVE-2026-97615: net: bridge: use option bits for CFM/MRP frame handlers

stable/6.12 was fixed.

Fixed status
stable/6.12: [be5ead6552418d70df3a76b962ccd6ed78a31fb5]

CVE-2026-97618: io_uring/net: don't overconsume buffers when using MSG_TRUNC

stable/6.12 was fixed.

Fixed status
stable/6.12: [41d24d2fb168fa05fcaf9ec4e55478411dbbf8e1]

CVE-2026-97619: io_uring/rw: end write accounting from ->ki_complete

stable/6.12 was fixed.

Fixed status
stable/6.12: [696459029f3b65c070c91b729478475582f1dcdf]

CVE-2026-97620: drm/xe: Flush LSC untyped L1 dataport cache after
rcs/ccs batches

stable/6.12 was fixed.

Fixed status
stable/6.12: [d73975c121f56fe3fcbbfcfe3ea8853b9f597ab3]

CVE-2026-97899: drm/i915: Fix memory leak in query_perf_config_list()

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [d60532306397233fb860860e9694f4e35abc0e80]
stable/5.15: [c0c727809229119598b50aba2776d236fbaa7989]
stable/6.1: [3726824aa1418594a7458721f8b8cafd5393a300]
stable/6.6: [362c42720259f42abbbafa99a12cd14f74254b7c]

CVE-2026-97900: drm/drm_exec: fix up contended obj when num_objects is 0

stable/6.6 was fixed.

Fixed status
stable/6.6: [506cfed91e50cc8055799480a2fde5a18f63a21c]

CVE-2026-97901: genetlink: pin family module during policy dump

stable/6.12 was fixed.

Fixed status
stable/6.12: [6e4d746e55c83c240cffce92356763d16b236af5]

CVE-2026-97904: cpufreq: initialize policy rwsem before sysfs publication

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [c9d8435814f2ac533c40fe3f35d94235bc3a9443]
stable/5.15: [82a54923700da5de83ce2b26c0b43f6b5005c8f1]
stable/6.1: [b14987a0f73777644099f47f01aba3b0f9dc6c27]
stable/6.6: [b22193eea2ce32c39dda5e09f9c2be2f3fd7eb4a]

CVE-2026-97905: cpufreq: zero-initialize policy cpumask before sysfs publication

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [e13370c5b549712f49f80234df249303381c53b4]
stable/5.15: [e807920031ca32b668f9e7a1efbd21858f03d64b]
stable/6.1: [ca52482508b3ac9febe74ca4f732647d394727b8]
stable/6.6: [06f273d29e5e0fe5c775a65c563fbeed8cd94c7a]

CVE-2026-97906: bootconfig: Fix integer overflow in initrd size check

stable/6.12 was fixed.

Fixed status
stable/6.12: [4d45bc0f8cdf606d5409b5f64a8a6609f6520c03]

CVE-2026-97907: Bluetooth: btrtl: Don't leak return code when parsing
firmware format v2

stable/6.6 was fixed.

Fixed status
stable/6.6: [ba96047bba4a6101267cf4f6b3057cbc58e6c554]

CVE-2026-97909: ASoC: sti: initialize IRQ lock before requesting IRQ

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [9128265f0fc8031a71775d70786052e5631aac54]
stable/5.15: [181bb64a1333bbf3c369123d05614536f3ae7b7c]
stable/6.1: [3a9552d18fc8174bab015bc941ede19452b184b3]
stable/6.6: [45021eb56211431f0ef44001b7d12cce32d49261]

CVE-2026-97910: ASoC: sprd: validate compress buffer sizes against
fixed allocations

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [2fada8276117215407afd1f59de5d2fe22aff01f]
stable/5.15: [ad796a1bc1875da2ebb616ea9bc1f2994273fd02]
stable/6.1: [2e27144ba4b98bb3eb14aaccd4b088e2e69844e3]
stable/6.6: [1467e3989c6edf79d3898c78aa47027f31ee5acb]

CVE-2026-97918: tracing: Undo the registration when enabling the
histogram trigger fails

stable/6.12 was fixed.

Fixed status
stable/6.12: [c7ee2d5733574d4694f7c0035e4381f54c1fca27]

CVE-2026-97919: tracing: Take the reference before publishing the
named histogram trigger

stable/6.12 was fixed.

Fixed status
stable/6.12: [b6fb2f5370a9a6aec325ab2db1ca3d1a881499b8]

CVE-2026-97920: tracing: Keep the entry count when the histogram stats
allocation fails

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [89c978d67ad01ce28223944cc58e95feea177b35]
stable/6.6: [fe05eeed27128e17d38dbc0af02e4470bcecda89]

CVE-2026-97921: tracing: Free histogram the field rejected for a bad modifier

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [a2652fcf96b63e9da04951e4e58e6a0672df695d]
stable/6.6: [3d42fed18b2c5707b6332ebe87b789fd768eb01b]

CVE-2026-97922: tracing: Free histogram var refs regardless of how
often they are referenced

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [a1f1d64a0a9791c842c4646253daf6ac0313eac7]
stable/6.6: [b513a4c60a7aa1f4b4c2a48544ab003cb36f1e94]

CVE-2026-97923: tracing: Free histogram the var ref when its
initialization fails

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [608b7751926ec08fae6a1ac4e7308195da68c362]
stable/5.15: [4870f9071c9ea3c1423a07741b85a794db30d672]
stable/6.1: [352f84a381e7b4651b30366e93cb858f3fa9c91a]
stable/6.6: [4924328d6991f25b65bb7c8ff5d56c2a9b254851]

CVE-2026-97924: tracing/user_events: Don't destroy fields when event
removal fails

stable/6.6 was fixed.

Fixed status
stable/6.6: [a3d9b8b7c8f3627976fe758c77ffd3da260824d7]

CVE-2026-97925: tick/broadcast: Plug clockevents replacement race

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [338d6859cd1580617807290f6d7e92b1662d4695]
stable/6.6: [757aa9f548c18b96da1d56d11f65be8188a16d59]

CVE-2026-97926: ufs: validate cylinder group metadata before caching it

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [88cccb6beba136b73f0caf80e59457e1b3c0ca1e]
stable/5.15: [f560a9e33365c460827c735fd86435f9213f1aed]
stable/6.1: [e4c5cc9688c3e69d07d888853388549ae26c0521]
stable/6.6: [58c0c414b2b8d099d33da494a354fa836ca6c10b]

CVE-2026-97927: ufs: create the root dentry after loading cylinder metadata

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [e58db6c2dce6e453dca26c3a4953002425201880]
stable/5.15: [05360c6eb8388bb5adac3c439ffb1512de39550a]
stable/6.1: [5cc48633fb76196b596a449ba1f4f642ad6125ce]
stable/6.6: [cd21f1ff74b1c15077fa3b98e80da3b41055aae4]

CVE-2026-97930: ALSA: usbusx2y: fix in04_last array size mismatch with in04_buf

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [e75e4b0e647137f4c9f6dee4a7ef5b7b09e16f57]
stable/6.1: [869fb83c072e884b80d93eab498e6040ffb010ba]
stable/6.6: [d170cfbe38c8817ac787f605655546a6d343017d]

CVE-2026-97931: ALSA: us122l: Prevent write upgrades for read mappings

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [cbc1f954ce67d739d41d1f0757d29850353ebb6a]
stable/5.15: [becb89036a1320ef0a77da2d27935ac0704345c4]
stable/6.1: [6a5f5a5a32c78e67701f1d0f26bc87af68895604]
stable/6.6: [938e8d6cee8d36f24669dfdcd3717e081eb32d64]

CVE-2026-97933: tracing: Take trace_array reference when opening a
tracer options file

stable/6.12 was fixed.

Fixed status
stable/6.12: [b2890064a12efbeb3b3c093e69e9010dd244c881]

CVE-2026-97934: tracing: Fix memory corruption from a "STACKTRACE" histogram key

stable/6.12 was fixed.

Fixed status
stable/6.12: [b6cc6ec5f032ea6fd5cce94fb83baab4d1c02e33]

CVE-2026-97935: tracing: Set the trace clock before registering the
histogram trigger

stable/6.12 was fixed.

Fixed status
stable/6.12: [cc6c4cf565b0c187c61ffd2e67a4dfb2427675ad]

CVE-2026-97936: tracing: Fix memory corruption from the histogram
stacktrace modifier

stable/6.6 was fixed.

Fixed status
stable/6.6: [98da3379cdee343f671dac89b9afbd8b071f2591]

CVE-2026-97938: reboot: fix cad_pid use-after-free race

stable/6.12 was fixed.

Fixed status
stable/6.12: [ae3e53fe3c1241855e3a88f74877738349948c78]

CVE-2026-97939: ipmr: account multicast table and route memory

stable/6.12 was fixed.

Fixed status
stable/6.12: [ec1c6140394ee87127479bc500a3158b125bf07a]

CVE-2026-97940: ipv6: fix fib6 walker UAF on seq stop

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [9a3f73d62c86271614eda4c43315230896a37018]
stable/5.15: [63407cddabc5992b5ac03af165559f4a1968a032]
stable/6.1: [05b687ee04f816658f4a9cf586f4d2f129157943]
stable/6.6: [14fdaba201fdff92a3e45994e02bccda409cb19d]

CVE-2026-97945: x86/mm: Fix user-space data loss with MADV_FREE and THP

stable/6.6 was fixed.

Fixed status
stable/6.6: [b5dec6dfb593d81fec15ba43c4fe5d58f10a49a2]

CVE-2026-97948: powerpc/eeh: Fix recursive locking on devices without
EEH sensitive driver

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [3833dfae0680b6b16e2469fbc90aa48376311cd8]
stable/5.15: [24524fca27da674668941440e8e05cdfec0b0222]
stable/6.1: [a58531181363219fa5de2b53d5d7274dcdfca98b]
stable/6.6: [460fab22b65138531082910702f74b048b25237b]

CVE-2026-97949: configfs: unhash the dentry before dropping the item in rmdir

stable/6.12 was fixed.

Fixed status
stable/6.12: [446720051d44eebaa81b33969173160057b73a33]

CVE-2026-97950: configfs: pin the symlink target's dirent instead of
chasing ->ci_dentry

stable/6.12 was fixed.

Fixed status
stable/6.12: [846ff40fd57a47e59a41f4e331ec3b34efaddc23]

CVE-2026-97951: scsi: target: iscsi: Fix hang for aborted WRITE_PENDING commands

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [b070c8b4b237d55bdac13da3c5a994491177b312]
stable/5.15: [19315262991dc983cc5c5c2ed24ff768abbf9339]
stable/6.1: [f806f54ae3de780b8f4139baefc95b81c599cf9f]
stable/6.6: [9c777f8e0cb0486fdf16db8ffea32e562a31e85b]

CVE-2026-97952: sunvdc: unmap LDC cookies when the descriptor send fails

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [eb9c5f6747fe98b83c78cb5476a914e91d50e8e8]
stable/5.15: [24564576be423f3b5d7e67cd7df848ac66646497]
stable/6.1: [9251573e7cf7d797ae4a30b2a236af8242237a61]
stable/6.6: [b0de6463667e9bb9dc14a83a9c24c1b6b3f7b5f7]

CVE-2026-97954: net/rds: fix tcp stream corruption with large pages

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [7d7705ce73eac1de1146706d887bc969a48ebb6d]
stable/5.15: [3230961a72b312d0e47101d1428084d0a02bff52]
stable/6.1: [ee74a4b42e3a2f9635ba376be9e58311322eebe4]
stable/6.6: [348492de88bc6ea06b6f3dd544a7a00d908a807b]

CVE-2026-97957: net: hinic: fix mailbox segment buffer overflow

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [7cc974799fde846eda2d8f00ad4f8e1810eb0499]
stable/5.15: [8de1e23bd91fe3a6683e4bc574e2d6bcb0eef920]
stable/6.1: [72be1fd5d256dde748c0905c5e1749a119cad5bd]
stable/6.6: [c622bbc212207d7c6bbd69dd88f0c3a3f5853d16]

CVE-2026-97958: net/sched: cls_api: Don't replay RTM_GETCHAIN in tc_ctl_chain().

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [240251a4ca7cda213103694b6e21c4a5745e5d8b]
stable/5.15: [9a0f07f7dbd1bfe8c2fd03ad055e9e60a703d5df]
stable/6.1: [6558b0d46c5941ed1aa67da8878e224c54239cc5]
stable/6.6: [96c2fc5daf983af2e0c1256c31e89c1f3f855279]

CVE-2026-97959: net/sched: cls_route: free emptied bucket on filter move

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [9e7741b41a25b9d49df4d262fa314342e6f95c50]
stable/5.15: [48d38bf8c22a05fde07ba1f885cde27b851649a2]
stable/6.1: [cc99d26b12431e4e4d0e346ec32764eb42c0aed9]
stable/6.6: [41e94079200aaf0cdbe4594b0af75710b33da124]

CVE-2026-97963: net: stmmac: initialize ptp_lock at probe time

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [ee33e424d4932c70f103b94a46b685923f236f65]
stable/6.1: [7ced87834f3a58761d4bbcabf8326478548e6a54]
stable/6.6: [79fb5bcc50996964e076dffbdc24b7d2c06bd957]

CVE-2026-97964: ppp_synctty: ensure a writeable skb header

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [25e03eeead2c49748c7582dfb64c205f93a42d00]
stable/6.1: [a256f9925288ef47de8febed5c38d5cc21340211]
stable/6.6: [7953946f68262a8bb137aa101249adef6e029652]

CVE-2026-97966: octeontx2-pf: reset HTB scheduler topology before freeing queues

stable/6.6 was fixed.

Fixed status
stable/6.6: [16c5c8ea5017952ff14c87626a45359d195dda6f]

CVE-2026-97969: watchdog: msc313e: Fix clock leak and spurious timer
in settimeout()

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [68665016c7b777b44e27b6b0c1e6524c28ebe40a]
stable/6.1: [77ef2aa8b46876ca9935f32dd874c517ccf5d880]
stable/6.6: [a1dd0817776ea2a870ba2347001af13ddd4cb321]

CVE-2026-97970: watchdog: msc313e: Avoid division by zero

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [5168267d5ae6f26f751512003df4263ae91ee3f0]
stable/6.1: [db900bc7c0739e5505a84bebb1bff2c3f67860e3]
stable/6.6: [660571b082331d250fbcef92363e15b38d107520]

CVE-2026-97973: net: macb: destroy the phylink instance on the probe error path

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [0112aa02c7847314be599d68783d50c7e228a694]
stable/6.6: [c1de1e7b51ab2531f564b39b51998c3d71caccd7]

CVE-2026-97977: Bluetooth: btusb: Fix UAF of btusb_data by rx_work

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [fc654a72a8d979db15e2773a481e931abaf5a9e8]
stable/6.6: [5242050195a711e9cd6a9935f689ab6656b94a91]

CVE-2026-97979: ice: add missing xa_destroy for sched_node_ids

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [09a7cdf8fffb065a8aa30cfa604ff4a65cbf04c9]
stable/6.6: [c075a91fe5762d314e6e182d37d29cf874bd314a]

CVE-2026-97981: net: ethernet: cortina: Count dropped frames as NAPI work

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [620b7184808b25cf58268856f892b9ba83c181fd]
stable/5.15: [9620e2ce9b5998ebbf157241f296f8ddb92285c2]
stable/6.1: [27b5753077d1cfda5fe201d2ba602de76a9a09b1]
stable/6.6: [e858b9b1ea3cbbc353189d07dec40dc16967e290]

CVE-2026-97982: net: ethernet: cortina: Fix budget accounting

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [d3deb54d9507c2d7f05efd896142095eef5b7d85]
stable/5.15: [e6e5732b90d0fc25fd3d9961ff61e660297d7608]
stable/6.1: [aa339ac334d4e51f43af9d2901e6faf11ffd981e]
stable/6.6: [4ca84049c6428c665ef7c903a32a99ed0f1e01e9]

CVE-2026-97984: net: ipv6: Fix UDP length overflow with PMTU discover
and big MTU

stable/6.6 was fixed.

Fixed status
stable/6.6: [1dd562f3019019ffdf4b396570613053facda9ee]

CVE-2026-97986: virtio_input: stop callbacks before unregistering input device

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [3ae729b1f8ab81d1244061872db2fb0ebb110d2a]
stable/6.6: [81073bca2062c916c818f2744fbab545a5c4982b]

CVE-2026-97987: virtio_input: reset device if input_register_device() fails

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [087b9ee4d36968329c846e6846e4e50f66532888]
stable/6.6: [16c90260ae7ae32d7ac9128fb5da404c37154765]

CVE-2026-97990: vdpa_sim_net: check TX pull result before RX copy

stable/6.6 was fixed.

Fixed status
stable/6.6: [1b803d382cde6d85755b363f22010208a04ba40a]

CVE-2026-97991: vdpa_sim_blk: reject out-of-range sector starts

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [2ff2a8d063fdfa1e1479fb1fe2e3356a2ce89018]
stable/6.1: [36ef4d8527f71648f00347f6ba759f0b7e5e0977]
stable/6.6: [000c6300776ceaf6b715780113f4275b1be4195b]

CVE-2026-97993: vhost-vdpa: don't install the eventfd_ctx_fdget()
error in config_ctx

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [e260dc9fbfdae0978e7a8698f977fbb463a657be]
stable/5.15: [66e73fa18910b39fea0941dea5fe091122240855]
stable/6.1: [4fde085eb839fbb39c25cbba5d2a091ded394877]
stable/6.6: [59fc7c1c6b4d325194ca45352180340092d95098]

CVE-2026-97994: vhost/vdpa: reject VRING_NUM larger than device max

stable/6.6 was fixed.

Fixed status
stable/6.6: [4875c65ca53797a0a402fe2bb54d1b12f28b3cda]

CVE-2026-97995: virtio_console: do not free control-out buffers on remove

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [b1f39c2a676698cc64c8e105e08b25111a112ec6]
stable/5.15: [e03522a990cd2e0f1a736eaa349a9df9ab8541c3]
stable/6.1: [8f6cfc3eca79b8e108d0823756101e2f4f9d811f]
stable/6.6: [2e40c69b9c3448b9c6609cd02013da593b2e123b]

CVE-2026-97998: netfilter: nfnetlink_log: cope with concurrent
instance destruction

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [c5c89beaa628d6ac527c6eb2e01b2b52eb417f59]
stable/5.15: [042465e7d3d3127e21f04e42c1639e2518b98915]
stable/6.1: [291685fc8d2e4cf75ed3a23c810883653f407f46]
stable/6.6: [3161186a2ff81288e9a5f35daf1911153764ecae]

CVE-2026-98006: ALSA: caiaq: Decoupling ep1_in_urb in caiaq dev

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [a3bbd2845bc7188ae18548a591da1067af997e80]
stable/5.15: [fbfbad728da2e95d6560e43266895de5c8e844b3]
stable/6.1: [dbd3effcbdb85394d3c4bd5ee9df785a44303333]
stable/6.6: [671037b282eb7fe477136bd0130ffd9029eb8668]

CVE-2026-98007: bpf: Reject non-scalar bpf_loop iteration counts

stable/6.6 was fixed.

Fixed status
stable/6.6: [2ff38b3552af53238aee6c877ae64cc798d46fce]

CVE-2026-98008: net: macb: fix NULL pointer dereference on unbind with
fixed-link

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [afa224cabc0132ca414b9141b1a919ca2d318cd0]
stable/6.6: [054ad8e66025eb4778d840bef80c270646cebcd2]

CVE-2026-98009: net/sched: ets: clamp quantum in parse and fallback paths

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [440b66cc7b56ea38e9b878ae88da91992efaa4c4]
stable/5.15: [4ef8664eafafc8db68a1d52601f17dc008a223b7]
stable/6.1: [8b8d782c3b96376217087767dcf662cd3d25f226]
stable/6.6: [226d2702e74a570f5bfae6115b4706da4b94e5cf]

CVE-2026-98010: net/sched: drr: clamp quantum in change class

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [e2297bbf9cf6ece86f1d1f8c683517a994990f9e]
stable/5.15: [560794ee6e040b6e1c4ac2b3c8909f341a4596ee]
stable/6.1: [23fea7e6736b2e1c6f6f2f05cccf33d36834da73]
stable/6.6: [b464affe9f9dfe41ac48930c376e3fb8596651b0]

CVE-2026-98011: net/sched: hhf: clamp quantum in change and init paths

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [a328698d046098e6f55b3b1460cac6bab577be58]
stable/5.15: [c364ad3ab3c8a6bce469a5cbf02881ab1324c5da]
stable/6.1: [2c6dd9fc86d446a03728c43f3b96d9ae29aa058f]
stable/6.6: [6570f326a6a96bedf3d1d1dab6acc9f8c29104ec]

CVE-2026-98012: net/sched: sfq: clamp quantum in change path

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [4117c528b2de5fdc3e4a7e3626815b616a635cdc]
stable/5.15: [f82fa6f10d4a69322cad0f7a4aa523ce6292a5a0]
stable/6.1: [0692ce5a528df450d64e9f819054177e9d91076f]
stable/6.6: [e4192bcf83aaab02129644ddf4656fd86e93751f]

CVE-2026-98013: net/sched: fq_pie: clamp quantum in change path

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [ff4f3a0f3abd2ded467931d7da7984a68a768e0b]
stable/5.15: [749aaebc1eb92ce2f38fd3caf68a2f99686d84ef]
stable/6.1: [8fd98e56c41f79278eeb67512c28d7abc175bcf4]
stable/6.6: [215df1e953ae72a09d425ec188e054058ae23dc9]

CVE-2026-98014: net/mlx5: E-Switch, prevent mc_list repopulation
during vport disable

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [413e04adcc1fd263cf02b1b83b4a0dbdc66bcee9]
stable/6.1: [2196f9d3358b00fcb28835a5fde14071f51ecb96]
stable/6.6: [5a2b87dfceccf9065157a14a599d395c2b6281b8]

CVE-2026-98015: net/mlx5: E-Switch: fix use-after-free in
mlx5_eswitch_termtbl_put

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [e3ee194a790896fa92fea20b5385a354be2f2c12]
stable/5.15: [b1398c9dfb5d3d4faaf6905ff7d98110a5d2c797]
stable/6.1: [92f581cac93a71723456ac79ef54d9f60a251b42]
stable/6.6: [a5833fdf53350b8b95a558fcf0056ddb1c0fe154]

CVE-2026-98016: net/mlx5e: Fix use-after-free race in sample_restore_put()

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [cdf920e44cbbee1900c66f002fb50afee20977d4]
stable/6.1: [308e1cbb0d9712081f90860fe839ccb47bc196ee]
stable/6.6: [8267e46d14e847e80e0aebe366d348e8a484a619]

CVE-2026-98017: net/sched: defer qdisc freeing after failed creation

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [96a27a3e64e7c87abade03fb2ad04ed66992a89a]
stable/6.6: [6a1b49bb9fdf9e8e7aa38e8cd635c0cc4074447d]

CVE-2026-98020: pds_core: fix cmd_regs access racing BAR unmap on reset

stable/6.6 was fixed.

Fixed status
stable/6.6: [0bf9f3bae3c4b1eadb7a2bf63350333db7dac0d9]

CVE-2026-98022: net: cap tx_queue_len at S16_MAX to prevent oversized
ring allocations

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [24d02c909a1725ab9eceb92db7d02e4e841f17ca]
stable/5.15: [5e5591a0f33f7c11bf1d338dbb6c5072575de64c]
stable/6.1: [c8d4060610c69645733c92d94fceb4b93808ac4d]
stable/6.6: [c2362c500931e5bd1826bce34e9ce28af80e7541]

CVE-2026-98023: vxlan: reject dynamic fdb entries that reference a nexthop id

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [00c7f4b8144e535ffb931ad45942a1bd1315b882]
stable/5.15: [55a33882808f1402052d53a08ead59aff8af18a1]
stable/6.1: [c8f29af91e0830fdabc9aa1eb1a0f898ce1bc603]
stable/6.6: [b2a8e165ddb6cd72176890b2954c52b0f6dbce1a]

CVE-2026-98024: s390/ism: folio_put() after error

stable/6.6 was fixed.

Fixed status
stable/6.6: [90f6f5cb331af52b14c0f309fb27dc243e8e2982]

CVE-2026-98025: net: usb: cx82310_eth: drop URB after 0xffff reboot
sentinel to prevent partial_data heap overflow

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [d0c1ce6ef4cefe568e19afa83f543caa3c3c0873]
stable/5.15: [0dbc89e664b4609ad672b5bdeef60df251294b8f]
stable/6.1: [00520cdd21ea6a9b5dc8d53bbd241620d2059554]
stable/6.6: [59bf9e94bdc49557f07d87164269daff7340f4d6]

CVE-2026-98026: net: bridge: mcast: properly convert mglist to rcu

stable/6.6 was fixed.

Fixed status
stable/6.6: [37cb9a81600da8250f24e25edc07253b62353cbe]

CVE-2026-98027: net: dsa: mv88e6xxx: bound the policy rule dump by the
caller's buffer size

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [7e4bfc5f0b66feb22cba821303fc25ca22cd0887]
stable/5.15: [01124cd2cf4b71755b1130ac82d78dcfbd5d69e3]
stable/6.1: [609c4378f212cf580aae02250f1146caf63d873f]
stable/6.6: [c5b5c52b6524c9fb50def2260baac745c095ec3a]

CVE-2026-98030: net: dsa: bcm_sf2: bound the CFP rule dump by the
caller's buffer size

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [ca49c526291d7cd3a5cb49b0edd7f50a5ae7176e]
stable/5.15: [8e41ce02589c92356bfd8ef62f6ceff840546e1a]
stable/6.1: [f2cf4ef2d94fc15fd2e21c131fc1ab3f76125bf4]
stable/6.6: [f5e93162b3dd195bfda815e8f7a39aaf1d45437b]

CVE-2026-98031: nexthop: Initialize extack in remove_nh_grp_entry()

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [35d9ec61466109ef0c2de87067338d929f629527]
stable/6.1: [704319510af2179cf03955747d714ab291075c25]
stable/6.6: [17acbcd4c5a6ca3dd3f9e52eb203c9175bde609a]

CVE-2026-98046: bpf: Mark bpf_btf_find_by_name_kind() as sleepable

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [7bf23cf7c9c0e0b5e638e497cdc0ec3f223742cc]
stable/6.6: [b843ab43ac9d2fa1ddd0dab8d0dcc19dbf764e2f]

CVE-2026-98051: net: bcmasp: fix tx_spb_ring_full() checking same slot cnt times

stable/6.6 was fixed.

Fixed status
stable/6.6: [990df1ba4d0805d1e7f6148c364febd2ab618766]

CVE-2026-98052: net: bcmasp: clear txcb->last before writing each descriptor

stable/6.6 was fixed.

Fixed status
stable/6.6: [1e213ba7cb3b9dd97ac2e0a1054e6d0d1d91f5bc]

CVE-2026-98055: ASoC: Intel: avs: Clean up the bus when fetching ML caps fails

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [68885c606a6e41dd4d3fe72f11241a6a438246ed]
stable/6.6: [a16ca1987ce8666c13482437db21232d41600e3f]

CVE-2026-98063: bpf: Fix NULL-ptr-deref in btf_var_show()

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [5756450c9a702da0efb4a993d0a6766b965736f3]
stable/5.15: [e83fcbe3b5d4a1ffb0569bb7c280358065c6017a]
stable/6.1: [e0d6a06171633d3ee3f7a39b57e5c845fb2b79f2]
stable/6.6: [aec0a9c1579eb9edf534960be592d09481bd7ac3]

CVE-2026-98064: bpf: Fix NULL-ptr-deref when showing a void BTF type

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [cf528f2d7a0a54f2a3c6d439cfa3c8d7dfe90d8d]
stable/5.15: [adb15557a641cb8a31f83e5f62bd12042b138c7b]
stable/6.1: [62b00074b58ccf43f61f70f2cfcac80937b530c6]
stable/6.6: [86d86f9fcf62dd3654090fbf3cf7ae5f42aa0706]

CVE-2026-98065: bpf: Reject key-less BTF for hash maps

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [54098e3fe34ec190bc256b338b9a93c7e2dc9354]
stable/6.18: [fa047f2a025003f5654ebd76539f16a6ead0401a]

CVE-2026-98066: ALSA: caiaq: Fix potential double-free at error path

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [ddfff1cec52b7deec6c770ba85de4dab6221d0a2]
stable/5.15: [da93fd9002d980bb02b729c5d5aeefeb252dd110]
stable/6.1: [b6cd6f1664a0bc8038b9baa7e6f5fe8e4142d056]
stable/6.6: [75b20534d7a37e091db585f8b505a3b77b7e81a8]

CVE-2026-98068: net/rds: don't let rds_conn_shutdown() consume a concurrent drop

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [f777c602d3e15d3414b53f760147687bd56b03f2]
stable/5.15: [7cb11257aa3e5ef0bedfd5d55ac60bb00347aa97]
stable/6.1: [4980ce260205001d582a7b3cb5eab29877777fbc]
stable/6.6: [0ec75c69918b7f6a1a5e3fb6442925246a9ec86b]

CVE-2026-98069: net/rds: acquire the fastpath locks in rds_conn_shutdown()

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [7f4f21e4439df30d9aca9fb3bac38191a2f34729]
stable/5.15: [1f900f585cbb0fbe6aa00c31c9f5bb63ee614456]
stable/6.1: [32e21bcf4b5b11454bf57c4bb3bf019b71512ace]
stable/6.6: [2e46248e375a516301884719f08b6015c79a6456]

CVE-2026-98070: net/rds: acquire RDS_IN_XMIT in rds_tcp_reset_callbacks()

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [670af4e4a4de5e6bb5daee3838485571a0caa5fa]
stable/5.15: [830a2e21b200c6b6fdccc63dd3f23932bf7a894b]
stable/6.1: [a05790cb4ff03f797d76906990b148d83f63e7a3]
stable/6.6: [d184e6dd4b8f3c20c018595fd09795a66b46c8ef]

CVE-2026-98071: net/rds: clear cp_flags bits individually in
rds_conn_path_reset()

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [c9a7c1eb0ad41dcf004a9e870e452cafedcd9172]
stable/5.15: [b767b48614c38687d717082860de7aa46f3b142c]
stable/6.1: [b7dc5da660eb5ffa7f7b4d33f2c74cb71c6edd6c]
stable/6.6: [b8a8b6d25e7426a638c60eaba2129c0664131e84]

CVE-2026-98072: net/rds: use wq_has_sleeper() in release_in_xmit()

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [6f552364d97cf4005c7a58f11c9f79e14e269865]
stable/5.15: [a94b1dfc82454c5bc068e71c25393af674daf63b]
stable/6.1: [5a806ed1eb46850ca4159a18b2a8c4b70f0c1341]
stable/6.6: [3d401934b7edb3ccb07d982dabadd04c45ee307c]

CVE-2026-98074: bonding: do not clear curr_active_slave prematurely
when releasing all slaves

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [b1ded242135071769902778dbab081e3fc09730f]
stable/5.15: [e39b203ec9e73852098d41b26386172d51babeb9]
stable/6.1: [384739c631aa6749356ba062d6b7c9a484a733f6]
stable/6.6: [7b435c69a30b40efc642de98b9bfa95fcf2ad4f0]

CVE-2026-98075: bpf: reject BPF_PSEUDO_FUNC reference to the main program

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [c74750dca96f40a1adb9d334f5a3152f44b270c3]
stable/6.1: [314c8caa9cb64ad60c5b969fe9a3e2dcdccf156f]
stable/6.6: [8cb75f7ada25b1cf25f2f74dec3ba649b9064a09]

CVE-2026-98076: tracing/probes: Fix use-after-free on field name/type
of events with multiple probes

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [38305e1b8b1ec27eef8f2d4e461e3b6c8624d494]
stable/5.15: [6d6118c17bc791594cbfd9cc4936ee21073b894a]
stable/6.1: [a2510fcaad92b09b34574c97e8356234c6a84a9a]
stable/6.6: [9379e193826f23876daccb3351fab89c87084ba3]

CVE-2026-98077: netfilter: nf_conntrack_sip: fix OOB read in
sip_skip_whitespace()

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [9ae0a87e6f513293677fe286729fbae34d592215]
stable/5.15: [b6277622b7323000895b674321c9a1f060553188]
stable/6.1: [0cfb96a118c5c6d46d7a1cfdfa18355ad734ca79]
stable/6.6: [c6beb08b1a9fdb96795816d8329ed75dd785d48e]

CVE-2026-98078: ipvs: fix reversed sequence option serialization

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [ae38b2ae16f709c0193e1b4340bde26ef3e2687d]
stable/5.15: [bbc68ba258a4eb0a2ca3b3a105550801aa8b00b0]
stable/6.1: [f487b5788f15c6c32a219ed1480d25c93fc18d30]
stable/6.6: [677ff8ab30a663cde984d8afe86465fd0d81aeef]

CVE-2026-98080: btrfs: do not force reloc root creation during
qgroup_account_snapshot()

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [d0284d974be46a0a06068f930c84039d540ae8ed]
stable/5.15: [21bd77c132f18dc21c6fcdf417310d1adcf7448b]
stable/6.1: [7ce02d52548b672795511c2cac8da6ec79ac8877]
stable/6.6: [7caaae233a55e167063f4cfa3385b1a04c8bbecb]

CVE-2026-98082: btrfs: fix the possible bioc_list memory leak during error

stable/6.6 was fixed.

Fixed status
stable/6.6: [d043c43d2b4ebcd75ee7f907948ef2847306d6b2]

CVE-2026-98083: btrfs: fix transaction use-after-free in raid stripe insertion

stable/6.6 was fixed.

Fixed status
stable/6.6: [089d9c45ea49ffffe55a8fe08d0ce2536626e90a]

CVE-2026-98086: ALSA: ump: do not touch legacy_rmidi before it exists

stable/6.6 was fixed.

Fixed status
stable/6.6: [d6f9af093dc91dac8848a01e417b8109c651c0b2]

CVE-2026-98088: scsi: mpt3sas: Avoid out-of-bounds cpumask_of_node()
call in _base_assign_reply_queues()

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [f531758ef21ba9a7716148cc290e8d9a110f20d9]
stable/6.1: [06a994ad7bbd13714cd45df582389f751531e60c]
stable/6.6: [7bcce856c79c1799351e170aec83e018ccf3d044]

CVE-2026-98089: bonding: alb: fix uninitialized transport header
access in alb_determine_nd()

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [862c8eb6947689c44fe11353755576a3672563a5]
stable/6.6: [7adb1bf25b0c5cedfb49b6e82844394d4f3c0d99]

CVE-2026-98090: btrfs: restore active device pointers after failed sprout

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [46863a9f93186e620c70584f91c8d5d95da83eff]
stable/6.1: [49179f13c04735c55fd0f43b03696c015b067137]
stable/6.6: [0a0ee38ad6324ac1603079bb785f784191576bd5]

CVE-2026-98091: btrfs: detach failed sprout device from transaction update list

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [2a57fb1d5ce8f316b81bbb60e6df245ebc816ffc]
stable/5.15: [86eff3052054e8f3b059b2d5845b6dcca021f20c]
stable/6.1: [63bfa52eb3289517aa82cb90e1189385873aae21]
stable/6.6: [7fe9dfbca43464baa8f050447a4837587b18adec]

CVE-2026-98092: ASoC: amd: yc: fix memory leak in acp6x_pdm_dma_close()

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [28869353ab83a7fa08fe5fe7b12c84b0257a63b1]
stable/6.6: [d356c188a653d31c20cd69a152b2e2ea9893180a]

CVE-2026-98094: staging: fbtft: make dirty_lock IRQ-safe

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [0843298b159599ee7bc6d14800efdb4bc7349706]
stable/5.15: [a323066337ed85c38decfc7f6bbf42f27605dff1]
stable/6.1: [f2451e18826eb6a33ea51419f39bdd2eb99fa1ea]
stable/6.6: [10cc145b873670438d3b105133dffdae70822db6]

CVE-2026-98095: af_packet: Don't cast tpacket_hdr.tp_len to int in
tpacket_parse_header().

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [3e0cad1432a0c0564f5076bab16f1aa4c0474be4]
stable/5.15: [6d4d55f75fa0ea32d874eb33e356e9361f3e4591]
stable/6.1: [09e3c9b32434600a6992e762bf0d6837f5902134]
stable/6.6: [2b9fa12fbdbfc0f671ff23b0ea06c177a6b8a6b8]

CVE-2026-98096: ipv6: sr: restore network header before routing and forwarding

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [f463c4786cf27376de7dfc0833a12e924a98f698]
stable/5.15: [8f44d4160bcdb3136a9145a4b9c7816382976925]
stable/6.1: [9cfbe2c381ab6d00a08e7a5b6028865adfb4e1bc]
stable/6.6: [af08f62b5a5a446d6134a92d86771d3d12e0e3da]

CVE-2026-98098: tipc: fix NULL deref in tipc_named_node_up() on empty
publication list

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [246a4b4aace490664927042e93400a6f940d197f]
stable/6.1: [6188cf0c989dea60f2efe800eaebb7d0bd16e2b2]
stable/6.6: [b5344e459996afb45e30fdc407b41e6674793b21]

CVE-2026-98101: ipv6: mcast: use copy-on-write RCU updates in ip6_mc_source()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [dba00514bf668c26cb4900e9f0da84bf96bf065a]
stable/6.6: [ac51321d3b2391860a935820ebcf4d8b9bb16a8a]

CVE-2026-98102: ipv6: mcast: fix RCU list diversion in ip6_mc_del1_src()

stable/6.6 was fixed.

Fixed status
stable/6.6: [c3343cd7ec8706c221e52b782f386b9af14a928a]

CVE-2026-98104: net/sched: cls_u32: fix duplicate handle when node ID
pool is exhausted

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [f4ee13ed7f7b22dcd8287fcf477ae37bd84567da]
stable/6.6: [84223baf21bc9b008444ae9bc38d5fb91fe00b9d]

CVE-2026-98108: Bluetooth: L2CAP: fix chan mode for LE_CONN_REQ +
EXT_FLOWCTL pchan

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [ad0f44a3f1f688558ed876a0702bc2c82b0df689]
stable/5.15: [564ae0e05e598aa895b9dbd18cb7d6eb64752869]
stable/6.1: [aab17938998b29e75c3324763411aef3e300fc67]
stable/6.6: [0e1fc7cab95ad958e55d70a5dfaaea687c9c639f]

CVE-2026-98109: Bluetooth: hci_core: Fix race condition during device
registration

stable/6.6 was fixed.

Fixed status
stable/6.6: [593e64f64a20b25e4042c3ee863119eb7f991785]

CVE-2026-98111: Bluetooth: btintel: validate version TLV value lengths

stable/6.6 was fixed.

Fixed status
stable/6.6: [e9cf7f175c00d36b060828f4eac8d2e246ee079b]

CVE-2026-98113: ksmbd: rate limit unmapped SID errors

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [3005d43143096321cc857645a9d48ef4ffde8bcf]
stable/6.1: [674aabf554bdaffcf25f145bf32c8b4f510f7916]
stable/6.6: [486876f957456721b5e51af532235db4c6f7bd47]

CVE-2026-98116: ALSA: pcm: Serialize PCM mmap with buffer reallocation
to fix page UAF

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [e6cdd2a0470d64073349a970dc1691433804b271]
stable/6.1: [9857a75714bb5df4781e4d8b1a1753b1e17bf07a]
stable/6.6: [cbadf2575d25e7dcc0d4da2717817ae569fbc99b]

CVE-2026-98121: watchdog: msc313e: Fix NULL pointer dereference in PM callbacks

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [960251cc4a413d8f1eef2a2c6aca41073b57ce16]
stable/6.1: [afc3ea51e479289a23c642cc8bade67b94225ed9]
stable/6.6: [a135415be56839e555e0bcdd5ffb8d2f5f947bd7]

CVE-2026-98122: vxlan: mdb: Fix use-after-free in vxlan_mdb_remote_src_del()

stable/6.6 was fixed.

Fixed status
stable/6.6: [069d5527bb0f229e528fa88c6b72f15060c373f2]

CVE-2026-98123: sctp: fix soft lockup from unpadded ASCONF-ACK
parameter iteration

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [ba54cad229977f4fae6355dbdaf117088414fdd0]
stable/5.15: [7d8e7ab6a0665888beee91f7ad77ac805963c4fd]
stable/6.1: [5fbc6a778d5fce7628821236972596acb18e1065]
stable/6.6: [4548d843e7b29f6d150d8caae4e64015fa226b0c]

CVE-2026-98128: scsi: mpi3mr: Fix target device refcount leak in
mpi3mr_sas_port_add()

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [60a9aaac07f6470b252c4de40e7d8a6e25004093]
stable/6.6: [58e3d2fbc8c914ed3dce2f7d915b3c4f4a3c76fb]

CVE-2026-98129: scsi: mpi3mr: Fix NULL pointer dereference in
mpi3mr_sas_port_add()

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [7e3489b5950e7668355762968a7c7f75fe9bc80d]
stable/6.6: [c848a1bbe110496eff8dcdf7cfbff66a69edae89]

CVE-2026-98130: sctp: fix a TOCTOU race in SCTP_CMD_TIMER_START

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [cbf2df9aac4202f9fb0b361a7fe8c79b29fad92c]
stable/5.15: [3205a20f837f5b1f009427ac3d9f706bf8a6fbec]
stable/6.1: [755d70ca845fd9b87c7b338ae6ae832b08cd0005]
stable/6.6: [09e7f9290d63178f56095d5c18fb9f9470153db5]

CVE-2026-98142: drm/cirrus-qemu: Validate BAR0 size during probe

stable/6.6 was fixed.

Fixed status
stable/6.6: [2a0e7bcff3fa63e7309d2b39e18af59eb8ef2b6e]

CVE-2026-98154: nvme-rdma: fix -EIO cleanup order in queue_rq

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [ccf37fff526cab2d0e6ff2aaf35947f3cf62e5bb]
stable/6.1: [c2459519b39587c9c27d6b8a8cf516fee10fce66]
stable/6.6: [965804b20c0f02c1a6cf4b69c0498a79e56f97fe]

CVE-2026-98155: accel/qaic: Address potential out-of-bounds read in
resp_worker()

stable/6.6 was fixed.

Fixed status
stable/6.6: [5807a65f301b6c0e73a2dc03dd6f5e80a2861b72]

CVE-2026-98157: EDAC/device_sysfs: Use kstrtouint() for poll_msec to
prevent truncation

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [a60794ee3f453516ab3ed212ba0295ecf890bc8c]
stable/5.15: [f856511058c8cb470d6c6c7ce908870adcdc7dc6]
stable/6.1: [656e2fe98ac452db4e5b8147d1f33b8c35b4ec4b]
stable/6.6: [541fc6f733b32463cf23277637bb07e2aaa00b53]

CVE-2026-98158: ppp_async: drop the errored frame instead of resetting
its headroom

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [25f354c55b8435d1f51b8a0a05a3cfe429358523]
stable/5.15: [a86a17745c3e1c6fadd4d6e90c03552dfe531c8c]
stable/6.1: [ff035780adb0f49dc2c7ada26b4697849a68bec8]
stable/6.6: [c4bb894362d224b699e2f95c6c26707d9654e4a3]

CVE-2026-98159: wifi: mt76: mt7921: validate CLC firmware records

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [46673662402884ca55a869e4ebe956e08e8b6b05]
stable/6.6: [740272d46ffc8231709a5e774cf5e4a5785b8a02]

CVE-2026-98161: nvdimm: pmem: keep PREFLUSH before data writes

stable/6.12 was fixed.

Fixed status
stable/6.12: [d34c30bc994328d9cf6749b2e9a32aabd08fd076]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

