Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FEFD46C08
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 22:21:02 +0000 (UTC)
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2159.1769638855605524487
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Jan 2026 14:20:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=L+nrCt8v;
 spf=pass (domain: miraclelinux.com, ip: 74.125.224.47, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64997a4a66aso323661d50.3
        for <cip-dev@lists.cip-project.org>; Wed, 28 Jan 2026 14:20:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769638854; cv=none;
        d=google.com; s=arc-20240605;
        b=D/TZLbMG+W76po15G2sn3ESyoRo34M2wnjPKH5qBMY3FZTQBfI09CRxve3gJ1k1gv7
         GKvpSmpd1G1vQC0Bvc3o741V9h2YC+MrTU62lSBFYRmTv7S0Jfw0g19GzhK4p5/3Remb
         KbsOSnisBmylEig14ExND9YADPvz3MQLWCEXpeRBRZNzbbTYqr3n9Ucr6/3uU0NklPQB
         DL6L4SyT06THqnm11eFN8oM3dYjVMQ0aslh8kGZX6z7i98SISsqGdQdjsbVgMwABRlKS
         gP2YscAT7wQmC7v6QM8VJDPJr6pHjoyUOlqi7zim0Lr/S/oWSc4qn/1efzA67nR0fpdA
         rGZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=bsvUhf5Xox8UfMp9ToqD2yWX0I87YyHtt9COLHwuQdI=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=TDc8fOBA4xA9vpb303jIDzOH3bw1QtdnoBSZ4SbnKRrmLP26afOtACP2BX/o3dvMVL
         +Xqj3SWCW38LUDC5A1Vd5UDvNuFX3AYZlJFt6PCCL2EEYf4cFj/Tg3GGPdVYiSYfHQjH
         uX8LebhrwE7RXZfUz1m40wYyOBmG5TTXATqW/PLSosi2YsD3oyUMIw0MdjDalHboh7+5
         gKUa5/Y/kFPLVr5kegLtwaTpgGSvchO07C0ZHRzVoLNPn636gW+Znn+9RCBmBluuKKo4
         bEmo26ZcmJbFpql+UbewT/ZUozouoTNY/6OMaKlziqdBJ1kr9yXaaRuwAlgWP/oCjZgH
         Ri3w==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1769638854; x=1770243654; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bsvUhf5Xox8UfMp9ToqD2yWX0I87YyHtt9COLHwuQdI=;
        b=L+nrCt8vnFrNI/ZfnoABsfDKUVAux+sYSrX5PgYNQMeBSDYicOx6odwvWMAt4/Zo67
         20mvmZ6DLol2gZS3putp+89aCwiWNAI+NI5VN2rr+ONEEl4Wn98Par3itzXmyqj6EBqb
         KrwaWr1dgWTrCWw4X/sv5anB8TxpGY1mYxazLeXv7b960vUT/2wMIG4LZ9uFN4ZoscNC
         CIwmSk/Tr0x29tzM0CFqrTFe0CJew2BME8dDjWnvbN0U1aNr4tdPVk16jkEZQCUhPD1l
         l2qABEoUu7xKng54KMppxWB3XMa0lqtIhqNB/qWDwfnekugVZgT6+T268B7P/NOmi4FT
         NM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769638854; x=1770243654;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bsvUhf5Xox8UfMp9ToqD2yWX0I87YyHtt9COLHwuQdI=;
        b=lZUHoE0gL0SFAolEtD/na9KSKzBxgAG2KUBLpigwPJB4x/fSWICKGnzmPBEg0+AS9p
         hH1CCrZH0Oe6U0Sxtu87kCUxpIgYvnByX2fFyp2KEgXWjCYib09UyBlqM2Zyfq1IdSUm
         UZX31zIYbcYh/GSYIlXk+QJAtJV54Boq4qimAfGnr9W1V/ncCMclDky0imJut7SXqwUA
         Nsi1oFFuJ4BU9Wj/TxCyibeOIodSKVNSChsYdnr2/8Pw2rOCoQuFXB/nHHsjsEoVVsAP
         2Uqia5xHcQMKW3PF9swBHjGOZxuIwSzJliiqo4TCzVFUu0na9Z8o3drcWFkt/21H2Rb7
         FWOg==
X-Gm-Message-State: AOJu0Ywg40CojOusCVJrvqPvVtwkHOpgxl9Cr2XYZp5OfPYbh/45n3LK
	ZDkoTDAp4Gwy08XsVQ6ynTXuQWbhypkB+nDP+YsZqVaSsD+fFEUHdf8cx+btg2VsgXcCaXt7EV/
	KEnixYitJrd/KzRBbOnk5GvNBNQbobK+7566Bz1U8rCIleViEove6cvQ=
X-Gm-Gg: AZuq6aJgxFprqSnuGTTKuT6SPksvXNWT5h2FDI+Q8D3+KyyjQ0Y7GJMVJE3H74BHpFH
	bLrR5NIEfCjZwHkN1qEzk3C/7YuNhmrH/9NBrxiPovYG18zal8BDdGM/LngMm+yWTov6TSGmNmL
	VpinNMv2plY6Omqs6M2tiipLPyCyiG+BlKsev08WvB3JMD2U3fjWBU6hev8IBnAG+Y5ZS+oEPSC
	0s62IZyUUZ1sG0SCKiI9+OuGkE84w5Mj8KTHNPDeCxKvTTnUtG6Uf3adpl0VQpR4i1YQHhS
X-Received: by 2002:a05:690e:11c8:b0:649:66ff:3154 with SMTP id
 956f58d0204a3-6498fc68786mr5519332d50.85.1769638853591; Wed, 28 Jan 2026
 14:20:53 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 29 Jan 2026 07:20:17 +0900
X-Gm-Features: AZwV_Qh-jpcbb7nwnk90-jtBrZxMVdKeYUbNyla6MvnOXPH7ics81EapDM9QvxA
Message-ID: <CAODzB9pM2MLYsgDjmpzv+-OW-e_gjcGRhgmLUyEGmVRO4QQ5Dg@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Jan 2026 22:21:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21781

Hi!

It's this week's CVE report.

This week reported 56 new CVEs and 2 updated CVEs.

* New CVEs
CVE-2025-71145: usb: phy: isp1301: fix non-OF device reference imbalance

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71145

Introduced by commit c841179 ("USB: lpc32xx_udc: Fix error handling in
probe") in v6.19-rc3.
Fixed in v6.19-rc3.

Bug introduced commit was backported to following branches.
cip/6.12 stable/5.10 stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [b4b64fda4d30a83a7f00e92a0c8a1d47699609f3]
stable/5.15: [43e58abad6c08c5f0943594126ef4cd6559aac0b]
stable/6.1: [03bbdaa4da8c6ea0c8431a5011db188a07822c8a]
stable/6.12: [5d3df03f70547d4e3fc10ed4381c052eff51b157]
stable/6.6: [75c5d9bce072abbbc09b701a49869ac23c34a906]

CVE-2025-71146: netfilter: nf_conncount: fix leaked ct in error paths

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71146

Introduced by commit be102eb ("netfilter: nf_conncount: rework API to
use sk_buff directly") in v6.19-rc1.
Fixed in v6.19-rc2.

Bug introduced commit was backported to following branches.
cip/6.12 stable/5.10 stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [2e2a720766886190a6d35c116794693aabd332b6]
stable/5.10: [08fa37f4c8c59c294e9c18fea2d083ee94074e5a]
stable/5.15: [e1ac8dce3a893641bef224ad057932f142b8a36f]
stable/6.1: [f381a33f34dda9e4023e38ba68c943bca83245e9]
stable/6.12: [0b88be7211d21a0d68bb1e56dc805944e3654d6f]
stable/6.6: [325eb61bb30790ea27782203a17b007ce1754a67]

CVE-2025-71147: KEYS: trusted: Fix a memory leak in tpm2_load_cmd

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71147

Introduced by commit f221974 ("security: keys: trusted: use ASN.1 TPM2
key format for the blobs") in v5.13-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [62cd5d480b9762ce70d720a81fa5b373052ae05f]
stable/5.15: [3fd7df4636d8fd5e3592371967a5941204368936]
stable/6.1: [af0689cafb127a8d1af78cc8b72585c9b2a19ecd]
stable/6.12: [9b015f2918b95bdde2ca9cefa10ef02b138aae1e]
stable/6.6: [19166de9737218b77122c41a5730ac87025e089f]

CVE-2025-71148: net/handshake: restore destructor on submit failure

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71148

Introduced by commit 3b3009e ("net/handshake: Create a NETLINK service
for handling handshake requests") in v6.4-rc1.
Fixed in v6.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6af2a01d65f89e73c1cbb9267f8880d83a88cee4]
stable/6.12: [7b82a1d6ae869533d8bdb0282a3a78faed8e63dd]
stable/6.6: [cd8cf2be3717137554744233fda051ffc09d1d44]

CVE-2025-71149: io_uring/poll: correctly handle io_poll_add() return
value on update

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71149

Introduced by commit 97b388d ("io_uring: handle completions in the
core") in v6.0-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [84230ad2d2afbf0c44c32967e525c0ad92e26b4e]
stable/6.1: [8b777ab48441b153502772ecfc78c107d4353f29]
stable/6.12: [c1669c03bfbc2a9b5ebff4428eecebe734c646fe]
stable/6.6: [0126560370ed5217958b85657b590ad25e8b9c00]

CVE-2025-71150: ksmbd: Fix refcount leak when invalid session is found
on session lookup

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71150

According to the .vulnerable file, this bug was introduced by commit
b956294 in v6.13-rc3.
Fixed in v6.19-rc2.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [cafb57f7bdd57abba87725eb4e82bbdca4959644]
stable/6.1: [0fb87b28cafae71e9c8248432cc3a6a1fd759efc]
stable/6.12: [02e06785e85b4bd86ef3d23b7c8d87acc76773d5]
stable/6.6: [e54fb2a4772545701766cba08aab20de5eace8cd]

CVE-2025-71151: cifs: Fix memory and information leak in smb3_reconfigure()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71151

Introduced by commit 0f0e357 ("cifs: during remount, make sure
passwords are in sync") in v6.13-rc1.
Fixed in v6.19-rc3.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [cb6d5aa9c0f10074f1ad056c3e2278ad2cc7ec8d]
stable/6.12: [5679cc90bb5415801fa29041da0319d9e15d295d]
stable/6.6: [bc390b2737205163e48cc1655f6a0c8cd55b02fc]

CVE-2025-71152: net: dsa: properly keep track of conduit reference

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71152

Introduced by commit 83c0afa ("net: dsa: Add new binding
implementation") in v4.8-rc1.
Introduced by commit 71e0bbd ("net: dsa: Add support for platform
data") in v4.11-rc1.
Fixed in v6.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [06e219f6a706c367c93051f408ac61417643d2f9]

CVE-2025-71153: ksmbd: Fix memory leak in get_file_all_info()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71153

Introduced by commit 5614c8c ("ksmbd: replace generic_fillattr with
vfs_getattr") in v6.9-rc1.
Fixed in v6.19-rc4.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [0c56693b06a68476ba113db6347e7897475f9e4c]
stable/6.12: [676907004256e0226c7ed3691db9f431404ca258]
stable/6.6: [5012b4c812230ae066902a00442708c999111183]

CVE-2025-71154: net: usb: rtl8150: fix memory leak on usb_submit_urb() failure

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71154

Introduced by commit 4d12997 ("drivers: net: usb: rtl8150: concurrent
URB bugfix") in v3.10-rc3.
Fixed in v6.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [12cab1191d9890097171156d06bfa8d31f1e39c8]
stable/5.10: [a4e2442d3c48355a84463342f397134f149936d7]
stable/5.15: [2f966186b99550e3c665dbfb87b8314e30acea02]
stable/6.1: [db2244c580540306d60ce783ed340190720cd429]
stable/6.12: [6492ad6439ff1a479fc94dc6052df3628faed8b6]
stable/6.6: [4bd4ea3eb326608ffc296db12c105f92dc2f2190]

CVE-2025-71155: KVM: s390: Fix gmap_helper_zap_one_page() again

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71155

Introduced by commit 5deafa2 ("KVM: s390: Fix to clear PTE when
discarding a swapped page") in v6.18-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2f393c228cc519ddf19b8c6c05bf15723241aa96]

CVE-2025-71156: gve: defer interrupt enabling until NAPI registration

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71156

Introduced by commit 1dfc2e4 ("gve: Refactor napi add and remove
functions") in v6.9-rc1.
Fixed in v6.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3d970eda003441f66551a91fda16478ac0711617]
stable/6.12: [f5b7f49bd2377916ad57cbd1210c61196daff013]

CVE-2025-71157: RDMA/core: always drop device refcount in
ib_del_sub_device_and_put()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71157

Introduced by commit bca5119 ("RDMA/core: Support IB sub device with
type "SMI"") in v6.11-rc1.
Fixed in v6.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fa3c411d21ebc26ffd175c7256c37cefa35020aa]
stable/6.12: [20436f2742a92b7afeb2504eb559a98d2196b001]

CVE-2025-71158: gpio: mpsse: ensure worker is torn down

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71158

According to the .vulnerable file, this bug was introduced by commit
c46a74f in v6.13-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [179ef1127d7a4f09f0e741fa9f30b8a8e7886271]

CVE-2025-71159: btrfs: fix use-after-free warning in
btrfs_get_or_create_delayed_node()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71159

Introduced by commit e8513c0 ("btrfs: implement ref_tracker for
delayed_nodes") in v6.18-rc1.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [83f59076a1ae6f5c6845d6f7ed3a1a373d883684]

CVE-2025-71160: netfilter: nf_tables: avoid chain re-validation if possible

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71160

According to the .vulnerable file, this bug was introduced by commit
a654de8 in v4.18-rc1.
Fixed in v6.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8e1a1bc4f5a42747c08130b8242ebebd1210b32f]
stable/6.12: [14fa3d1927f1382f86e3f70a51f26005c8e3cff6]
stable/6.6: [53de1e6cde8f9b791d9cf61aa0e7b02cf5bbe8b1]

CVE-2025-71161: dm-verity: disable recursive forward error correction

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71161

According to the .vulnerable file, this bug was introduced by commit
a739ff3 in v4.5-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d9f3e47d3fae0c101d9094bc956ed24e7a0ee801]

CVE-2026-22978: wifi: avoid kernel-infoleak from struct iw_point

Announce: https://www.cve.org/CVERecord?id=CVE-2026-22978

Introduced by commit 87de87d ("wext: Dispatch and handle compat ioctls
entirely in net/wireless/wext.c") in v2.6.27-rc1.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [21cbf883d073abbfe09e3924466aa5e0449e7261]
stable/5.10: [d943b5f592767b107ba8c12a902f17431350378c]
stable/5.15: [a3827e310b5a73535646ef4a552d53b3c8bf74f6]
stable/6.1: [442ceac0393185e9982323f6682a52a53e8462b1]
stable/6.12: [024f71a57d563fbe162e528c8bf2d27e9cac7c7b]
stable/6.6: [d21ec867d84c9f3a9845d7d8c90c9ce35dbe48f8]

CVE-2026-22979: net: fix memory leak in skb_segment_list for GRO packets

Announce: https://www.cve.org/CVERecord?id=CVE-2026-22979

Introduced by commit ed4ccce ("gro: fix ownership transfer") in v6.9-rc3.
Fixed in v6.19-rc5.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [238e03d0466239410b72294b79494e43d4fabe77]
stable/6.1: [0b27828ebd1ed3107d7929c3737adbe862e99e74]
stable/6.12: [3264881431e308b9c72cb8a0159d57a56d67dd79]
stable/6.6: [88bea149db2057112af3aaf63534b24fab5858ab]

CVE-2026-22980: nfsd: provide locking for v4_end_grace

Announce: https://www.cve.org/CVERecord?id=CVE-2026-22980

Introduced by commit 7f5ef2e ("nfsd: add a v4_end_grace file to
/proc/fs/nfsd") in v3.18-rc1.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2857bd59feb63fcf40fe4baf55401baea6b4feb4]
stable/5.10: [ca97360860eb02e3ae4ba42c19b439a0fcecbf06]
stable/5.15: [e8bfa2401d4c51eca6e48e9b33c798828ca9df61]
stable/6.1: [34eb22836e0cdba093baac66599d68c4cd245a9d]
stable/6.12: [ba4811c8b433bfa681729ca42cc62b6034f223b0]
stable/6.6: [06600719d0f7a723811c45e4d51f5b742f345309]

CVE-2026-22981: idpf: detach and close netdevs while handling a reset

Announce: https://www.cve.org/CVERecord?id=CVE-2026-22981

Introduced by commit 0fe4546 ("idpf: add create vport and netdev
configuration") in v6.7-rc1.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2e281e1155fc476c571c0bd2ffbfe28ab829a5c3]

CVE-2026-22982: net: mscc: ocelot: Fix crash when adding interface under a lag

Announce: https://www.cve.org/CVERecord?id=CVE-2026-22982

Introduced by commit 528d3f1 ("net: mscc: ocelot: drop the use of the
"lags" array") in v5.12-rc1.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [34f3ff52cb9fa7dbf04f5c734fcc4cb6ed5d1a95]
stable/5.15: [8767f238b0e6c3d0b295ac6dce9fbe6a99bd1b9d]
stable/6.1: [b17818307446c5a8d925a39a792261dbfa930041]
stable/6.12: [03fb1708b7d1e76aecebf767ad059c319845039f]
stable/6.6: [2985712dc76dfa670eb7fd607c09d4d48e5f5c6e]

CVE-2026-22983: net: do not write to msg_get_inq in callee

Announce: https://www.cve.org/CVERecord?id=CVE-2026-22983

Introduced by commit 4d14429 ("af_unix: don't post cmsg for SO_INQ
unless explicitly asked for") in v6.19-rc4.
Fixed in v6.19-rc5.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [7d11e047eda5f98514ae62507065ac961981c025]

CVE-2026-22984: libceph: prevent potential out-of-bounds reads in
handle_auth_done()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-22984

According to the .vulnerable file, this bug was introduced by commit
cd1a677 in v5.11-rc1.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [818156caffbf55cb4d368f9c3cac64e458fb49c9]
stable/5.15: [194cfe2af4d2a1de599d39dad636b47c2f6c2c96]
stable/6.1: [79fe3511db416d2f2edcfd93569807cb02736e5e]
stable/6.12: [2802ef3380fa8c4a08cda51ec1f085b1a712e9e2]
stable/6.6: [ef208ea331ef688729f64089b895ed1b49e842e3]

CVE-2026-22985: idpf: Fix RSS LUT NULL pointer crash on early ethtool operations

Announce: https://www.cve.org/CVERecord?id=CVE-2026-22985

Introduced by commit a251eee ("idpf: add SRIOV support and other
ndo_ops") in v6.7-rc1.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [83f38f210b85676f40ba8586b5a8edae19b56995]

CVE-2026-22986: gpiolib: fix race condition for gdev->srcu

Announce: https://www.cve.org/CVERecord?id=CVE-2026-22986

Introduced by commit 47d8b4c ("gpio: add SRCU infrastructure to struct
gpio_device") in v6.9-rc1.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a7ac22d53d0990152b108c3f4fe30df45fcb0181]

CVE-2026-22987: net/sched: act_api: avoid dereferencing ERR_PTR in
tcf_idrinfo_destroy

Announce: https://www.cve.org/CVERecord?id=CVE-2026-22987

Introduced by commit 84a7d67 ("net/sched: acp_api: no longer acquire
RTNL in tc_action_net_exit()") in v6.17-rc1.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [adb25a46dc0a43173f5ea5f5f58fc8ba28970c7c]

CVE-2026-22988: arp: do not assume dev_hard_header() does not change skb->head

Announce: https://www.cve.org/CVERecord?id=CVE-2026-22988

Introduced by commit db5b4e3 ("ip6_gre: make ip6gre_header() robust")
in v6.19-rc4.
Fixed in v6.19-rc5.

Bug introduced commit was backported to following branches.
cip/6.12 stable/5.10 stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [c92510f5e3f82ba11c95991824a41e59a9c5ed81]
stable/5.10: [e432dbff342b95fe44645f9a90fcf333c80f4b5e]
stable/5.15: [393525dee5c39acff8d6705275d7fcaabcfb7f0a]
stable/6.1: [70bddc16491ef4681f3569b3a2c80309a3edcdd1]
stable/6.12: [dd6ccec088adff4bdf33e2b2dd102df20a7128fa]
stable/6.6: [029935507d0af6553c45380fbf6feecf756fd226]

CVE-2026-22989: nfsd: check that server is running in unlock_filesystem

Announce: https://www.cve.org/CVERecord?id=CVE-2026-22989

Introduced by commit 1ac3629 ("nfsd: prepare for supporting
admin-revocation of state") in v6.9-rc1.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d0424066fcd294977f310964bed6f2a487fa4515]
stable/6.12: [d95499900fe52f3d461ed26b7a30bebea8f12914]

CVE-2026-22990: libceph: replace overzealous BUG_ON in
osdmap_apply_incremental()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-22990

According to the .vulnerable file, this bug was introduced by commit
f24e998 in v2.6.34-rc2.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e00c3f71b5cf75681dbd74ee3f982a99cb690c2b]
stable/5.10: [9aa0b0c14cefece078286d78b97d4c09685e372d]
stable/5.15: [4b106fbb1c7b841cd402abd83eb2447164c799ea]
stable/6.1: [6afd2a4213524bc742b709599a3663aeaf77193c]
stable/6.12: [6c6cec3db3b418c4fdf815731bc39e46dff75e1b]
stable/6.6: [d3613770e2677683e65d062da5e31f48c409abe9]

CVE-2026-22991: libceph: make free_choose_arg_map() resilient to
partial allocation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-22991

According to the .vulnerable file, this bug was introduced by commit
5cf9c4a in v4.13-rc1.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e3fe30e57649c551757a02e1cad073c47e1e075e]
stable/5.10: [9b3730dabcf3764bfe3ff07caf55e641a0b45234]
stable/5.15: [851241d3f78a5505224dc21c03d8692f530256b4]
stable/6.1: [ec1850f663da64842614c86b20fe734be070c2ba]
stable/6.12: [c4c2152a858c0ce4d2bff6ca8c1d5b0ef9f2cbdf]
stable/6.6: [8081faaf089db5280c3be820948469f7c58ef8dd]

CVE-2026-22992: libceph: return the handler error from mon_handle_auth_done()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-22992

Introduced by commit cd1a677 ("libceph, ceph: implement msgr2.1
protocol (crc and secure modes)") in v5.11-rc1.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e84b48d31b5008932c0a0902982809fbaa1d3b70]
stable/5.15: [77229551f2cf72f3e35636db68e6a825b912cf16]
stable/6.1: [33908769248b38a5e77cf9292817bb28e641992d]
stable/6.12: [d2c4a5f6996683f287f3851ef5412797042de7f1]
stable/6.6: [e097cd858196b1914309e7e3d79b4fa79383754d]

CVE-2026-22993: idpf: Fix RSS LUT NULL ptr issue after soft reset

Announce: https://www.cve.org/CVERecord?id=CVE-2026-22993

Introduced by commit 02cbfba ("idpf: add ethtool callbacks") in v6.7-rc1.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ebecca5b093895da801b3eba1a55b4ec4027d196]

CVE-2026-22994: bpf: Fix reference count leak in bpf_prog_test_run_xdp()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-22994

Introduced by commit 1c19499 ("bpf: introduce frags support to
bpf_prog_test_run_xdp()") in v5.18-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ec69daabe45256f98ac86c651b8ad1b2574489a7]
stable/6.1: [368569bc546d3368ee9980ba79fc42fdff9a3365]
stable/6.12: [fb9ef40cccdbacce36029b305d0ef1e12e4fea38]
stable/6.6: [98676ee71fd4eafeb8be63c7f3f1905d40e03101]

CVE-2026-22995: ublk: fix use-after-free in ublk_partition_scan_work

Announce: https://www.cve.org/CVERecord?id=CVE-2026-22995

Introduced by commit 7fc4da6 ("ublk: scan partition in async way") in v6.19-rc4.
Fixed in v6.19-rc5.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [f0d385f6689f37a2828c686fb279121df006b4cb]

CVE-2025-71162: dmaengine: tegra-adma: Fix use-after-free

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71162

Introduced by commit f46b195 ("dmaengine: tegra-adma: Add support for
Tegra210 ADMA") in v4.7-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2efd07a7c36949e6fa36a69183df24d368bf9e96]
stable/6.12: [cb2c9c4bb1322cc3c9984ad17db8cdd2663879ca]

CVE-2025-71163: dmaengine: idxd: fix device leaks on compat bind and unbind

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71163

Introduced by commit 6e7f3ee ("dmaengine: idxd: move dsa_drv support
to compatible mode") in v5.15-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [799900f01792cf8b525a44764f065f83fcafd468]
stable/6.12: [0c97ff108f825a70c3bb29d65ddf0a013d231bb9]

CVE-2026-22996: net/mlx5e: Don't store mlx5e_priv in mlx5e_dev devlink priv

Announce: https://www.cve.org/CVERecord?id=CVE-2026-22996

Introduced by commit ee75f1f ("net/mlx5e: Create separate devlink
instance for ethernet auxiliary device") in v6.3-rc1.
Introduced by commit c4d7eb5 ("net/mxl5e: Add change profile method")
in v5.12-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [123eda2e5b1638e298e3a66bb1e64a8da92de5e1]
stable/6.12: [dcb2ad755a16cb0ecd2dc98234d71a6e216ae7fe]

CVE-2026-22997: net: can: j1939: j1939_xtp_rx_rts_session_active():
deactivate session upon receiving the second rts

Announce: https://www.cve.org/CVERecord?id=CVE-2026-22997

Introduced by commit 9d71dd0 ("can: add support of SAE J1939
protocol") in v5.4-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1809c82aa073a11b7d335ae932d81ce51a588a4a]
stable/6.12: [cb2a610867bc379988bae0bb4b8bbc59c0decf1a]

CVE-2026-22998: nvme-tcp: fix NULL pointer dereferences in
nvmet_tcp_build_pdu_iovec

Announce: https://www.cve.org/CVERecord?id=CVE-2026-22998

Introduced by commit efa5630 ("nvmet-tcp: Fix a kernel panic when host
sends an invalid H2C PDU length") in v6.8-rc1.
Fixed in v6.19-rc6.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1 stable/6.6

Fixed status
mainline: [32b63acd78f577b332d976aa06b56e70d054cbba]
stable/6.12: [3def5243150716be86599c2a1767c29c68838b6d]

CVE-2026-22999: net/sched: sch_qfq: do not free existing class in
qfq_change_class()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-22999

Introduced by commit 462dbc9 ("pkt_sched: QFQ Plus: fair-queueing
service at DRR cost") in v3.8-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3879cffd9d07aa0377c4b8835c4f64b4fb24ac78]
stable/6.12: [362e269bb03f7076ba9990e518aeddb898232e50]

CVE-2026-23000: net/mlx5e: Fix crash on profile change rollback failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23000

Introduced by commit c4d7eb5 ("net/mxl5e: Add change profile method")
in v5.12-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4dadc4077e3f77d6d31e199a925fc7a705e7adeb]
stable/6.12: [dad52950b409d6923880d65a4cddb383286e17d2]

CVE-2026-23001: macvlan: fix possible UAF in macvlan_forward_source()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23001

Introduced by commit 79cf79a ("macvlan: add source mode") in v3.18-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7470a7a63dc162f07c26dbf960e41ee1e248d80e]
stable/6.12: [8518712a2ca952d6da2238c6f0a16b4ae5ea3f13]

CVE-2026-23002: lib/buildid: use __kernel_read() for sleepable context

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23002

Introduced by commit ad41251 ("lib/buildid: implement sleepable
build_id_parse() API") in v6.12-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [777a8560fd29738350c5094d4166fe5499452409]
stable/6.12: [b11dfb7708f212b96c7973a474014c071aa02e05]

CVE-2026-23003: ip6_tunnel: use skb_vlan_inet_prepare() in __ip6_tnl_rcv()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23003

Introduced by commit 8d975c1 ("ip6_tunnel: make sure to pull inner
header in __ip6_tnl_rcv()") in v6.8-rc3.
Fixed in v6.19-rc6.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1 stable/6.6

Fixed status
mainline: [81c734dae203757fb3c9eee6f9896386940776bd]
stable/6.12: [df5ffde9669314500809bc498ae73d6d3d9519ac]

CVE-2026-23004: dst: fix races in rt6_uncached_list_del() and
rt_del_uncached_list()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23004

Introduced by commit 8d0b94a ("ipv6: Keep track of DST_NOCACHE routes
in case of iface down/unregister") in v4.2-rc1.
Introduced by commit 78df76a ("ipv4: take rt_uncached_lock only if
needed") in v3.6-rc5.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9a6f0c4d5796ab89b5a28a890ce542344d58bd69]

CVE-2026-23005: x86/fpu: Clear XSTATE_BV[i] in guest XSAVE state
whenever XFD[i]=1

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23005

Introduced by commit 820a6ee ("kvm: x86: Add emulation for IA32_XFD",
2022-01-14) in v5.17-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b45f721775947a84996deb5c661602254ce25ce6]
stable/6.12: [f577508cc8a0adb8b4ebe9480bba7683b6149930]

CVE-2026-23006: ASoC: tlv320adcx140: fix null pointer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23006

Introduced by commit 4e82971 ("ASoC: tlv320adcx140: Add a new
kcontrol") in v6.1-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [be7664c81d3129fc313ef62ff275fd3d33cfecd4]
stable/6.12: [61757f5191daab863d25f03680e912b5449a1eed]

CVE-2026-23007: block: zero non-PI portion of auto integrity buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23007

Introduced by commit c546d6f ("block: only zero non-PI metadata tuples
in bio_integrity_prep") in v6.11-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ca22c566b89164f6e670af56ecc45f47ef3df819]

CVE-2026-23008: drm/vmwgfx: Fix KMS with 3D on HW version 10

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23008

Introduced by commit 9655441 ("drm/vmwgfx: Refactor cursor handling")
in v6.16-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d9186faeae6efb7d0841a5e8eb213ff4c7966614]

CVE-2026-23009: xhci: sideband: don't dereference freed ring when
removing sideband endpoint

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23009

Introduced by commit de66754 ("xhci: sideband: add initial api to
register a secondary interrupter entity") in v6.16-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd83dc1249737b837ac5d57c81f2b0977c613d9f]

CVE-2026-23010: ipv6: Fix use-after-free in inet6_addr_del().

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23010

Introduced by commit 00b5b7a ("net/ipv6: delete temporary address if
mngtmpaddr is removed or unmanaged") in v6.13-rc1.
Fixed in v6.19-rc6.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [ddf96c393a33aef4887e2e406c76c2f8cda1419c]
stable/6.12: [2684610a9c9c53f262fd864fa5c407e79f304804]

CVE-2026-23011: ipv4: ip_gre: make ipgre_header() robust

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23011

Introduced by commit c544193 ("GRE: Refactor GRE tunneling code.") in v3.10-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e67c577d89894811ce4dcd1a9ed29d8b63476667]
stable/6.12: [aa57bfea4674e6da8104fa3a37760a6f5f255dad]

CVE-2026-23012: mm/damon/core: remove call_control in inactive contexts

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23012

Introduced by commit 004ded6 ("mm/damon: accept parallel damon_call()
requests") in v6.17-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f9132fbc2e83baf2c45a77043672a63a675c9394]

CVE-2026-23013: net: octeon_ep_vf: fix free_irq dev_id mismatch in IRQ rollback

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23013

Introduced by commit 1cd3b40 ("octeon_ep_vf: add Tx/Rx processing and
interrupt support") in v6.9-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f93fc5d12d69012788f82151bee55fce937e1432]
stable/6.12: [aa05a8371ae4a452df623f7202c72409d3c50e40]

CVE-2026-23014: perf: Ensure swevent hrtimer is properly destroyed

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23014

Introduced by commit eb3182e ("perf/core: Fix system hang caused by
cpu-clock usage") in v6.18-rc5.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ff5860f5088e9076ebcccf05a6ca709d5935cfa9]

* Updated CVEs

CVE-2025-38248: bridge: mcast: Fix use-after-free during router port
configuration

stable/6.12 was fixed.

Fixed status
stable/6.12: [bdced577da71b118b6ed4242ebd47f81bf54d406]

CVE-2025-38591: bpf: Reject narrower access to pointer ctx fields

stable/6.12 was fixed.

Fixed status
stable/6.12: [058a0da4f6d916a79b693384111bb80a90d73763]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

