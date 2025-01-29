Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA12C0218D
	for <webhook@archiver.kernel.org>; Wed, 29 Jan 2025 22:33:15 +0000 (UTC)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
 by mx.groups.io with SMTP id smtpd.web11.2890.1738189987733256767
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Jan 2025 14:33:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=0DJPjDy9;
 spf=pass (domain: miraclelinux.com, ip: 209.85.219.174, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e4930eca0d4so339679276.3
        for <cip-dev@lists.cip-project.org>; Wed, 29 Jan 2025 14:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1738189987; x=1738794787; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PGz+btZR9DGToFENCx33nnakO7Ebv1X17l5GBHbR44Y=;
        b=0DJPjDy9VXKtkxr9q4r3/FE5I8jNfc57Q6w75BMBVbqy1D3wocKVJAhycghPI2OEyO
         OJtZUkNSBh+5zH0zCIpxm2ShGeH7vEkQbFQLWqzozQnrcaDdIlye04+lXZ6gCHhdto6q
         iMrL/khfV3Ws0njidkPRbONKgSAIU/VvxVZ3a0xhH5O9pFR9aZPlBXyMrRz6y377qXDm
         GkpoY45MDDfTOT+gb20kenoDvgNOys/EitBgd2er+XbicKuMzZhQczrsW/vC/bLTxgcw
         3UaXi4p4hhcaabLjVn9kgMv5W11Z2YD2H8JVBZvZrB150Io3XUWvvWZJhXSKawSWF/w1
         QaJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738189987; x=1738794787;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PGz+btZR9DGToFENCx33nnakO7Ebv1X17l5GBHbR44Y=;
        b=K49OgetQ+2du8gi7QgY8TzKAz7fJWM0cA+zhxFN5WqaOo3kDZSoWk/QH/fqQZJucCe
         Vu7eF9MIY26Gl4r5wQu+uJoIGH8b2P6u+Gdy+u0nDC4WbI2VsKaTYSCA/RA5XPenPuO5
         A7jd0syyQU/ndyOqd33oLRPtEqMEj6sIWEiWyc6FWxt5H00RFVuVuD71xCL/BYGcipBj
         Hzq8or49NPJm+9A2a6EUpViZhEgx2KoBCzkclhdHFyUrqi40RSKDNW2v2Cl448Knv3qd
         IxQAXEOQL3HzE2GgBFvcINfTM/hxiejl7YPvsBGjBQdeQxP4YLEmlIaeJ7K/uQmpA9DC
         LTLQ==
X-Gm-Message-State: AOJu0YyM4QNYE//MDV4MnSmikmfEva84//K+FPaH8pzfBB8yvBa6WraI
	zh9kC6rn81fEq4zo90NVI/buIR29Rq6pTXVCHyVn4Naa7tv/XKqWtawEubgKEsGi0heyymKWTTR
	DQ26nzKAe1L1cU9BAPtJLA+pdK0UfOJt54AfYL3rHXIX6ER/ixRc=
X-Gm-Gg: ASbGncsiWy5bKhBS+Z/frhBR4F//eqAoKvxaEbTUaA4GyyZ6G/90cA0rcEzqUZQmv6n
	Ki5DVDELdiFjq7Xb7JFcNJcAT0p5DqhKucesLajnV5kYFrycYq//cSTnOTeB2TdlQdWRqa3xKRQ
	==
X-Google-Smtp-Source: AGHT+IHptl07clRmaLFvMfimHGGW6ZEGJWiquzIrlspuPpzogRz/e23ED6idapIP/6hnTu1HQK8/x1D8ZaWrt92GVGs=
X-Received: by 2002:a05:690c:f0a:b0:6f6:cc1d:a6d with SMTP id
 00721157ae682-6f7a8377fe0mr39627807b3.18.1738189986284; Wed, 29 Jan 2025
 14:33:06 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 30 Jan 2025 07:32:32 +0900
X-Gm-Features: AWEUYZlVNz0Ahl9JF--yXGBh0JFIdfwdVVJR_u9UXNx087DMD5eVALENckIB3O4
Message-ID: <CAODzB9oD004fNkOYtnKjvdQ_S4ZfauZ29U+gSF0z9iiytfBnDw@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Jan 2025 22:33:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17679

Hi!

It's this week's CVE report.

This week reported 1 new CVEs and 41 updated CVEs.

* New CVEs

CVE-2024-57947: netfilter: nf_set_pipapo: fix initial map fill

Announce: https://lore.kernel.org/linux-cve-announce/2025012322-CVE-2024-57947-480e@gregkh/

Introduced by commit 3c4287f ("nf_tables: Add set type for arbitrary
concatenation of ranges") in v5.6-rc1.
Fixed in v6.11-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [791a615b7ad2258c560f91852be54b0480837c93]
stable/5.15: [957a4d1c4c5849e4515c9fb4db21bf85318103dc]
stable/6.1: [9625c46ce6fd4f922595a4b32b1de5066d70464f]
stable/6.6: [69b6a67f7052905e928d75a0c5871de50e686986]


Fixed status

* Updated CVEs
CVE-2024-23307: Integer Overflow bug was found md/raid/raid5 modules

stable/5.15 was fixed.

Fixed status
stable/5.15: [203f38eb72f2fb8b353338cc9ffe45ae3b9bbc65]
stable/6.1: [9477cfeb300823461b44223a7d5fac26a31df4fe]
stable/6.6: [8ec4a68a25a231e2303716a0aba8ff1413d47c87]
stable/6.7: [1191f9391105e49115715e55030476849f6f6da5]
stable/6.8: [83dcc4e850c69ca569e1b0f1484910e6a68b2d78]

CVE-2024-36899: gpiolib: cdev: Fix use after free in lineinfo_changed_notify

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [2d008d4961b039d2edce8976289773961b7e5fb5]
stable/6.1: [d38c49f7bdf14381270736299e2ff68ec248a017]
stable/6.6: [95ca7c90eaf5ea8a8460536535101e3e81160e2a]

CVE-2024-47707: ipv6: avoid possible NULL deref in rt6_uncached_list_flush_dev()

stable/5.15 was fixed.

Fixed status
stable/5.15: [e43dd28405e6b9935279996725ee11e6306547a5]
stable/6.1: [f2bd9635543ca41533b870f420872819f8331823]
stable/6.11: [08409e401622e2896b4313be9f781bde8a2a6a53]
stable/6.6: [0ceb2f2b5c813f932d6e60d3feec5e7e713da783]

CVE-2024-53124: net: fix data-races around sk->sk_forward_alloc

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [c3d052cae566ec2285f5999958a5deb415a0f59e]
stable/6.1: [be7c61ea5f816168c38955eb4e898adc8b4b32fd]
stable/6.11: [d285eb9d0641c8344f2836081b4ccb7b3c5cc1b6]
stable/6.6: [3f51f8c9d28954cf380100883a02eed35a8277e9]

CVE-2024-53170: block: fix uaf for flush rq while iterating tags

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [1921fe7d2836f8be1d321cf430d17e0d4e05301b]
stable/6.12: [61092568f2a9acb0e6e186f03f2e0649a4e86d09]
stable/6.6: [1364a29b71c7837770f1902c49e7a6e234d72c92]

CVE-2024-53229: RDMA/rxe: Fix the qp flush warnings in req

stable/6.1 was fixed.

Fixed status
stable/6.1: [9e95518eca5ccc0a2f5d99d7b8a142c73ce3f8d0]
stable/6.12: [cc341b5d761a8a16693fe406b8127e4378747f85]
stable/6.6: [31978d5c5aef034d96fc53b4a9cb3c6e11dbb94d]

CVE-2024-53234: erofs: handle NONHEAD !delta[1] lclusters gracefully

stable/6.1 was fixed.

Fixed status
stable/6.1: [75a0a6dde803e7a3af700da8da9a361b49f69eba]
stable/6.12: [daaf68fef4b2ff97928227630021d37b27a96655]
stable/6.6: [f466641debcbea8bdf78d1b63a6270aadf9301bf]

CVE-2024-53685: ceph: give up on paths longer than PATH_MAX

stable/5.15 was fixed.

Fixed status
stable/5.15: [d42ad3f161a5a487f81915c406f46943c7187a0a]
stable/6.1: [e4b168c64da06954be5d520f6c16469b1cadc069]
stable/6.12: [99a37ab76a315c8307eb5b0dc095d8ad9d8efeaa]
stable/6.6: [c47ed91156daf328601d02b58d52d9804da54108]

CVE-2024-56551: drm/amdgpu: fix usage slab after free

stable/6.1 was fixed.

Fixed status
stable/6.1: [05b1b33936b71e5f189a813a517f72e8a27fcb2f]
stable/6.12: [6383199ada42d30562b4249c393592a2a9c38165]
stable/6.6: [3990ef742c064e22189b954522930db04fc6b1a7]

CVE-2024-56599: wifi: ath10k: avoid NULL pointer error during sdio remove

stable/6.1 was fixed.

Fixed status
stable/6.1: [6e5dbd1c04abf2c19b2282915e6fa48b6ccc6921]
stable/6.12: [543c0924d446b21f35701ca084d7feca09511220]
stable/6.6: [b35de9e01fc79c7baac666fb2dcb4ba7698a1d97]

CVE-2024-56608: drm/amd/display: Fix out-of-bounds access in
'dcn21_link_encoder_create'

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [5bd410c21037107b83ffbb51dd2d6460f9de9ed1]
stable/6.12: [f01ddd589e162979421e6914b1c74018633f01e0]
stable/6.6: [08ac5fdb9c6dc34d0ed4bc64ce3c5c3d411b3b53]

CVE-2024-56631: scsi: sg: Fix slab-use-after-free read in sg_release()

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [198b89dd5a595ee3f96e5ce5c448b0484cd0e53c]
stable/6.1: [275b8347e21ab8193e93223a8394a806e4ba8918]
stable/6.12: [1f5e2f1ca5875728fcf62bc1a054707444ab4960]
stable/6.6: [59b30afa578637169e2819536bb66459fdddc39d]

CVE-2024-56672: blk-cgroup: Fix UAF in blkcg_unpin_online()

stable/5.15 was fixed.

Fixed status
stable/5.15: [8a07350fe070017a887433f4d6909433955be5f1]
stable/6.1: [64afc6fe24c9896c0153e5a199bcea241ecb0d5c]
stable/6.12: [29d1e06560f0f6179062ac638b4064deb637d1ad]
stable/6.6: [5baa28569c924d9a90d036c2aaab79f791fedaf8]

CVE-2024-57882: mptcp: fix TCP options overflow.

stable/5.15 was fixed.

Fixed status
stable/5.15: [88b01048f286bb522f524ad99943ba86797d6514]
stable/6.1: [09ba95321a269019b5aa8e0c3bc80cf86d91fd18]
stable/6.12: [fb08e6b0ba284e3dcdc9378de26dcb51d90710f5]
stable/6.6: [53fe947f67c93a5334aed3a7259fcc8a204f8bb6]

CVE-2024-57892: ocfs2: fix slab-use-after-free due to dangling pointer dqi_priv

stable/5.15 was fixed.

Fixed status
stable/5.15: [f44e6d70c100614c211703f065cad448050e4a0e]
stable/6.1: [2d431192486367eee03cc28d0b53b97dafcb8e63]
stable/6.12: [ba950a02d8d23811aa1120affd3adedcfac6153d]
stable/6.6: [2e3d203b1adede46bbba049e497765d67865be18]

CVE-2024-57904: iio: adc: at91: call input_free_device() on allocated iio_dev

stable/5.15 was fixed.

Fixed status
stable/5.15: [028a1ba8e3bae593d701aee4f690ce7c195b67d6]
stable/6.1: [25ef52f1c15db67d890b80203a911b9a57b0bf71]
stable/6.12: [d115b7f3ddc03b38bb7e8754601556fe9b4fc034]
stable/6.6: [09e067e3c83e0695d338e8a26916e3c2bc44be02]

CVE-2024-57906: iio: adc: ti-ads8688: fix information leak in triggered buffer

stable/5.15 was fixed.

Fixed status
stable/5.15: [aae96738006840533cf147ffd5f41830987f21c5]
stable/6.1: [ebe2672bc42a0dfe31bb539f8ce79d024aa7e46d]
stable/6.12: [485570ed82b7a6bb109fa1d0a79998e21f7f4c73]
stable/6.6: [455df95eb8f24a37abc549d6738fc8ee07eb623b]

CVE-2024-57907: iio: adc: rockchip_saradc: fix information leak in
triggered buffer

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [7a07fb80ea886e9134284a27d0155cca7649e293]
stable/6.1: [64b79afdca7b27a768c7d3716b7f4deb1d6b955c]
stable/6.12: [8193941bc4fe7247ff13233f328aea709f574554]
stable/6.6: [5a95fbbecec7a34bbad5dcc3156700b8711d53c4]

CVE-2024-57908: iio: imu: kmx61: fix information leak in triggered buffer

stable/5.15 was fixed.

Fixed status
stable/5.15: [a07f698084412a3ef5e950fcac1d6b0f53289efd]
stable/6.1: [6985ba4467e4b15b809043fa7740d1fb23a1897b]
stable/6.12: [565814cbbaa674d2901428796801de49a611e59d]
stable/6.6: [cde312e257b59ecaa0fad3af9ec7e2370bb24639]

CVE-2024-57910: iio: light: vcnl4035: fix information leak in triggered buffer

stable/5.15 was fixed.

Fixed status
stable/5.15: [cb488706cdec0d6d13f2895bcdf0c32b283a7cc7]
stable/6.1: [47d245be86492974db3aeb048609542167f56518]
stable/6.12: [f6fb1c59776b4263634c472a5be8204c906ffc2c]
stable/6.6: [a15ea87d4337479c9446b5d71616f4668337afed]

CVE-2024-57911: iio: dummy: iio_simply_dummy_buffer: fix information
leak in triggered buffer

stable/5.15 was fixed.

Fixed status
stable/5.15: [006073761888a632c5d6f93e47c41760fa627f77]
stable/6.1: [b0642d9c871aea1f28eb02cd84d60434df594f67]
stable/6.12: [ea703cda36da0dacb9a2fd876370003197d8a019]
stable/6.6: [74058395b2c63c8a438cf199d09094b640f8c7f4]

CVE-2024-57912: iio: pressure: zpa2326: fix information leak in triggered buffer

stable/5.15 was fixed.

Fixed status
stable/5.15: [64a989aa7475b8e76e69b9ec86819ea293e53bab]
stable/6.1: [b7849f62e61242e0e02c776e1109eb81e59c567c]
stable/6.12: [979a0db76ceda8fe1f2f85a116bfe97620ebbadf]
stable/6.6: [fefb88a4da961a0b9c2473cbdcfce1a942fcfa9a]

CVE-2024-57913: usb: gadget: f_fs: Remove WARN_ON in functionfs_bind

stable/5.15 was fixed.

Fixed status
stable/5.15: [19fc1c83454ca9d5699e39633ec79ce26355251c]
stable/6.1: [82f60f3600aecd9ffcd0fbc4e193694511c85b47]
stable/6.12: [a8b6a18b9b66cc4c016d63132b59ce5383f7cdd2]
stable/6.6: [ea6a1498742430eb2effce0d1439ff29ef37dd7d]

CVE-2024-57915: usb: gadget: u_serial: Disable ep before setting port
to null to fix the crash caused by port being null

stable/5.15 was fixed.

Fixed status
stable/5.15: [d2de56cc45ee447f005d63217e84988b4f02faa9]
stable/6.1: [3d730e8758c75b68a0152ee1ac48a270ea6725b4]
stable/6.12: [8e122d780a0f19aefd700dbd0b0e3ed3af0ae97f]
stable/6.6: [0c50f00cc29948184af05bda31392fff5821f4f3]

CVE-2024-57917: topology: Keep the cpumask unchanged when printing cpumap

stable/5.15 was fixed.

Fixed status
stable/5.15: [1c7818e2746e747838a3de1687e89eac7b947f08]
stable/6.1: [ca47e933a900492d89dcf5db18a99c28bd4a742d]
stable/6.12: [360596e7fe319a5db1b5fb34a3952862ae53c924]
stable/6.6: [b02cf1d27e460ab2b3e1c8c9ce472d562cad2e8d]

CVE-2024-57922: drm/amd/display: Add check for granularity in dml
ceil/floor helpers

stable/5.15 was fixed.

Fixed status
stable/5.15: [95793f9684e58d2aa56671b2d616b4f9f577a0a8]
stable/6.1: [f3d1e4062ef251fa55ccfeca1e54a98b6818b3a1]
stable/6.12: [4f0dd09ed3001725ffd8cdc2868e71df585392fe]
stable/6.6: [ae9ab63a268be99a27a4720ca24f6be801744fee]

CVE-2024-57924: fs: relax assertions on failure to encode file handles

stable/6.6 was fixed.

Fixed status
stable/6.12: [adcde2872f8fc399b249758ae1990dcd53b694ea]
stable/6.6: [f47c834a9131ae64bee3c462f4e610c67b0a000f]

CVE-2024-57925: ksmbd: fix a missing return value check bug

stable/5.15 was fixed.

Fixed status
stable/5.15: [781c743e18bfd9b7dc0383f036ae952bd1486f21]
stable/6.1: [ee7e40f7fb17f08a8cbae50553e5c2e10ae32fce]
stable/6.12: [2976e91a3e569cf2c92c9f71512c0ab1312fe965]
stable/6.6: [271ae0edbfc942795c162e6cf20d2bc02bd7fde4]

CVE-2024-57929: dm array: fix releasing a faulty array block twice in
dm_array_cursor_end

stable/5.15 was fixed.

Fixed status
stable/5.15: [738994872d77e189b2d13c501a1d145e95d98f46]
stable/6.1: [e477021d252c007f0c6d45b5d13d341efed03979]
stable/6.12: [017c4470bff53585370028fec9341247bad358ff]
stable/6.6: [6002bec5354f86d1a2df21468f68e3ec03ede9da]

CVE-2024-57939: riscv: Fix sleeping in invalid context in die()

stable/5.15 was fixed.

Fixed status
stable/5.15: [10c24df2e303f517fab0359392c11b6b1d553f2b]
stable/6.1: [c21df31fc2a4afc02a6e56511364e9e793ea92ec]
stable/6.12: [76ab0afcdbe8c9685b589016ee1c0e25fe596707]
stable/6.6: [f48f060a4b36b5e96628f6c3fb1540f1e8dedb69]

CVE-2024-57940: exfat: fix the infinite loop in exfat_readdir()

stable/5.15 was fixed.

Fixed status
stable/5.15: [28c21f0ac5293a4bf19b3e0e32005d6dd31a6c17]
stable/6.1: [31beabd0f47f8c3ed9965ba861c9e5b252d4920a]
stable/6.12: [d9ea94f5cd117d56e573696d0045ab3044185a15]
stable/6.6: [dc1d7afceb982e8f666e70a582e6b5aa806de063]

CVE-2025-21631: block, bfq: fix waker_bfqq UAF after bfq_split_bfqq()

stable/5.15 was fixed.

Fixed status
stable/5.15: [f587c1ac68956c4703857d650d9b1cd7bb2ac4d7]
stable/6.1: [2550149fcdf2934155ff625d76ad4e3d4b25bbc6]
stable/6.12: [bc2aeb35ff167e0c6b0cedf0c96a5c41e6cba1ed]
stable/6.6: [be3eed59ac01f429ac10aaa46e26f653bcf581ab]

CVE-2025-21636: sctp: sysctl: plpmtud_probe_interval: avoid using
current->nsproxy

stable/5.15 was fixed.

Fixed status
stable/5.15: [1dc5da6c4178f3e4b95c631418f72de9f86c0449]
stable/6.1: [44ee8635922b6eb940faddb961a8347c6857d722]
stable/6.12: [bcf8c60074e81ed2ac2d35130917175a3949c917]
stable/6.6: [284a221f8fa503628432c7bb5108277c688c6ffa]

CVE-2025-21637: sctp: sysctl: udp_port: avoid using current->nsproxy

stable/5.15 was fixed.

Fixed status
stable/5.15: [0a0966312ac3eedd7f5f2a766ed4702df39a9a65]
stable/6.1: [e919197fb8616331f5dc81e4c3cc3d12769cb725]
stable/6.12: [5b77d73f3be5102720fb685b9e6900e3500e1096]
stable/6.6: [55627918febdf9d71107a1e68d1528dc591c9a15]

CVE-2025-21638: sctp: sysctl: auth_enable: avoid using current->nsproxy

stable/5.15 was fixed.

Fixed status
stable/5.15: [bd2a2939423566c654545fa3e96a656662a0af9e]
stable/6.1: [1b67030d39f2b00f94ac1f0af11ba6657589e4d3]
stable/6.12: [c184bc621e3cef03ac9ba81a50dda2dae6a21d36]
stable/6.6: [7ec30c54f339c640aa7e49d7e9f7bbed6bd42bf6]

CVE-2025-21639: sctp: sysctl: rto_min/max: avoid using current->nsproxy

stable/5.15 was fixed.

Fixed status
stable/5.15: [0f78f09466744589e420935e646ae78212a38290]
stable/6.1: [4059507e34aa5fe0fa9fd5b2b5f0c8b26ab2d482]
stable/6.12: [c87f1f6ade56c711f8736901e330685b453e420e]
stable/6.6: [dc9d0e3cfd16f66fbf0862857c6b391c8613ca9f]

CVE-2025-21640: sctp: sysctl: cookie_hmac_alg: avoid using current->nsproxy

stable/5.15 was fixed.

Fixed status
stable/5.15: [86ddf8118123cb58a0fb8724cad6979c4069065b]
stable/6.1: [3cd0659deb9c03535fd61839e91d4d4d3e51ac71]
stable/6.12: [f0bb3935470684306e4e04793a20ac4c4b08de0b]
stable/6.6: [ad673e514b2793b8d5902f6ba6ab7e890dea23d5]

CVE-2025-21646: afs: Fix the maximum cell name length

stable/5.15 was fixed.

Fixed status
stable/5.15: [7cb3e77e9b4e6ffa325a5559393d3283c9af3d01]
stable/6.1: [aabe47cf5ac5e1db2ae0635f189d836f67024904]
stable/6.12: [7922b1f058fe24a93730511dd0ae2e1630920096]
stable/6.6: [7673030efe0f8ca1056d3849d61784c6caa052af]

CVE-2025-21648: netfilter: conntrack: clamp maximum hashtable size to INT_MAX

stable/5.15 was fixed.

Fixed status
stable/5.15: [b1b2353d768f1b80cd7fe045a70adee576b9b338]
stable/6.1: [5552b4fd44be3393b930434a7845d8d95a2a3c33]
stable/6.12: [f559357d035877b9d0dcd273e0ff83e18e1d46aa]
stable/6.6: [d5807dd1328bbc86e059c5de80d1bbee9d58ca3d]

CVE-2025-21653: net_sched: cls_flow: validate TCA_FLOW_RSHIFT attribute

stable/5.15 was fixed.

Fixed status
stable/5.15: [a313d6e6d5f3a631cae5a241c392c28868aa5c5e]
stable/6.1: [2011749ca96460386844dfc7e0fde53ebee96f3c]
stable/6.12: [6fde663f7321418996645ee602a473457640542f]
stable/6.6: [e54beb9aed2a90dddf4c5d68fcfc9a01f3e40a61]

CVE-2025-21664: dm thin: make get_first_thin use rcu-safe list first function

stable/5.15 was fixed.

Fixed status
stable/5.15: [802666a40c71a23542c43a3f87e3a2d0f4e8fe45]
stable/6.1: [12771050b6d059eea096993bf2001da9da9fddff]
stable/6.12: [cbd0d5ecfa390ac29c5380200147d09c381b2ac6]
stable/6.6: [6b305e98de0d225ccebfb225730a9f560d28ecb0]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

