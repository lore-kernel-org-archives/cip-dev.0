Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7ADC5B543
	for <webhook@archiver.kernel.org>; Wed,  4 Jun 2025 22:22:06 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
 by mx.groups.io with SMTP id smtpd.web11.29802.1749075723985223960
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Jun 2025 15:22:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=tDibqG/d;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.182, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-70e767ce72eso4248727b3.1
        for <cip-dev@lists.cip-project.org>; Wed, 04 Jun 2025 15:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1749075723; x=1749680523; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jTTzsmdU+UeMn1Mz6RtYVIiMDxh66k00vPff0WFtxqU=;
        b=tDibqG/dirTUdhA5PSQyeLHvnZeL65PjSINrRrZ25GYS+F/b1t5ULFgXsSz16PUJvL
         ZBNBoqXtkKadY7epfU+2Bq+jFU3+S59+3A0vJh1yxoNzpY4FKK5mkuzZZywkE4S+QPbQ
         utGR4LAxY+PCf/84Fg2RpIiE57MCH61F+FYU5AREfmShUY55EJZtvF2K6yf5xO9Nj1d0
         aVaXsmpt/jaOREmVJrYsxLgULydskH7Vmgkpdmn/zmgESXgvEqC4aVkbNJaFYHh3j/EQ
         wzazwca8IXPsv6eVROLv1F508PMPJvW/0SHciNgh+QnbUHeFyWP7Pwhjsjt4Alg27Rvy
         4bjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749075723; x=1749680523;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jTTzsmdU+UeMn1Mz6RtYVIiMDxh66k00vPff0WFtxqU=;
        b=e6MFJFy9e03by29nX4X8BIGu5jY9D1wKxmpyb2I3q3eYqHQ6QPJ7DBszeloMGS3N+4
         7akG3yWoY+Cg+PCHk0rfhUE9flj8eDlKkOhytUQ4Q/5XDVxFSDt45UelrtTzpKF4MyOt
         ue9vFRZptRhQMLTNDfLIr4lh0aR4R+ECyI6LKvn1QaHelL/EXsI4jNcjK17fWWGVtBeZ
         Z4peXKviXNM273PxAh+CU1okCmzO0SyOJCNPlMAqW16csXn8s9r4Kx1zIlM6i8l/8plZ
         BkA2em1gWrg8R9XL2enYtMOWMIZRTdWvItykDE9qRvoWoSnkJykEqa4wjO2kmx88kr9U
         2ZJw==
X-Gm-Message-State: AOJu0YynsbSvPAOL+TVMAh9P2IlV52ZMqFNbK5w2ZB05m6hK3inVWo1B
	C2T0w65E26WU1Ohxh8eDyKVCCurPORES+ZIokgHsEh/Qb144a2qvVOG8s3pR3kEEVuDBF5EGEHz
	K9uxnvqjTaERw8WRg98tyDbUyjyj7KOuQW4lsAPTKZBBYDKaMS7Q7BLk=
X-Gm-Gg: ASbGncthff4c+TD9kncR15kzjTUvyhT9kZ+MGU/L44nJPZnFeYxi/Yo72XmXTIxUvCN
	3KbNvEgP7Nu2/VAcMb+sUgtZJ9LS9kOwDenapn+uCiB05+PbKu/s2KOxasi8RzEqRDHhII84JJT
	e4K3RTqI8s8qOQ8x/hxUNk3n7DjyLpfdKpLA==
X-Google-Smtp-Source: AGHT+IE8/2a6Vh8+Bu4wVEYN8QP0xN5EbwURE6Wbd378lSALmo8ChXUvSmligqi7racj6f0Fv17i4g+xwoXCuJEl2Yw=
X-Received: by 2002:a05:690c:6004:b0:70e:1771:c152 with SMTP id
 00721157ae682-710d9fe21b1mr62764347b3.30.1749075722689; Wed, 04 Jun 2025
 15:22:02 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 5 Jun 2025 07:21:25 +0900
X-Gm-Features: AX0GCFufE4hwOFjbpO8j7e7MXw-dHpkIVY3hpnc3QHTQE98kVq2ZMMFgj7wQwhA
Message-ID: <CAODzB9pEyr1_tMjjrQ2ught37JdPC=FfMC8N-BnZCMgWa8SM1g@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jun 2025 22:22:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19016

Hi!

It's this week's CVE report.

This week reported 7 new CVEs and 31 updated CVEs.

* New CVEs
CVE-2025-37993: can: m_can: m_can_class_allocate_dev(): initialize
spin lock on device probe

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37993

Introduced by commit 1fa80e2 ("can: m_can: Introduce a
tx_fifo_in_flight counter") in v6.9-rc1.
Fixed in v6.15-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dcaeeb8ae84c5506ebc574732838264f3887738c]
stable/6.12: [2ecce25ea296f328d79070ee36229a15aeeb7aca]

CVE-2025-37994: usb: typec: ucsi: displayport: Fix NULL pointer access

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37994

Introduced by commit af8622f ("usb: typec: ucsi: Support for
DisplayPort alt mode") in v5.2-rc1.
Fixed in v6.15-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [312d79669e71283d05c05cc49a1a31e59e3d9e0e]
stable/5.10: [a9931f1b52b2d0bf3952e003fd5901ea7eb851ed]
stable/5.15: [7804c4d63edfdd5105926cc291e806e8f4ce01b5]
stable/5.4: [9dda1e2a666a8a32ce0f153b5dee05c7351f1020]
stable/6.1: [076ab0631ed4928905736f1701e25f1e722bc086]
stable/6.12: [5ad298d6d4aebe1229adba6427e417e89a5208d8]
stable/6.14: [e9b63faf5c97deb43fc39a52edbc39d626cc14bf]
stable/6.6: [14f298c52188c34acde9760bf5abc669c5c36fdb]

CVE-2025-37995: module: ensure that kobject_put() is safe for module
type kobjects

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37995

Introduced by commit 942e443 ("module: Fix mod->mkobj.kobj potentially
freed too early") in v3.12-rc1.
Fixed in v6.15-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a6aeb739974ec73e5217c75a7c008a688d3d5cf1]
stable/5.10: [a63d99873547d8b39eb2f6db79dd235761e7098a]
stable/5.15: [f1c71b4bd721a4ea21da408806964b10468623f2]
stable/5.4: [93799fb988757cdacf19acba57807746c00378e6]
stable/6.1: [9e7b49ce4f9d0cb5b6e87db9e07a2fb9e754b0dd]
stable/6.12: [d63851049f412cdfadaeef7a7eaef5031d11c1e9]
stable/6.14: [31d8df3f303c3ae9115230820977ef8c35c88808]
stable/6.6: [faa9059631d3491d699c69ecf512de9e1a3d6649]

CVE-2025-37996: KVM: arm64: Fix uninitialized memcache pointer in
user_mem_abort()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37996

Introduced by commit fce886a ("KVM: arm64: Plumb the pKVM MMU in KVM")
in v6.14-rc1.
Fixed in v6.15-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [157dbc4a321f5bb6f8b6c724d12ba720a90f1a7c]

CVE-2025-37997: netfilter: ipset: fix region locking in hash types

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37997

Introduced by commit f66ee04 ("netfilter: ipset: Fix "INFO: rcu
detected stall in hash_xxx" reports") in v5.6-rc4.
Fixed in v6.15-rc6.

Bug introduced commit was backported to following branches.
stable/5.4

Fixed status
mainline: [8478a729c0462273188263136880480729e9efca]
stable/5.10: [226ce0ec38316d9e3739e73a64b6b8304646c658]
stable/5.15: [82c1eb32693bc48251d92532975e19160987e5b9]
stable/5.4: [00cfc5fad1491796942a948808afb968a0a3f35b]
stable/6.1: [aa77294b0f73bb8265987591460cd25b8722c3df]
stable/6.12: [e2ab67672b2288521a6146034a971f9a82ffc5c5]
stable/6.6: [a3dfec485401943e315c394c29afe2db8f9481d6]

CVE-2025-37998: openvswitch: Fix unsafe attribute parsing in output_userspace()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37998

Introduced by commit ccb1352 ("net: Add Open vSwitch kernel
components.") in v3.3-rc1.
Fixed in v6.15-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6beb6835c1fbb3f676aebb51a5fee6b77fed9308]
stable/5.10: [06b4f110c79716c181a8c5da007c259807840232]
stable/5.15: [47f7f00cf2fa3137d5c0416ef1a71bdf77901395]
stable/5.4: [6712dc21506738f5f22b4f68b7c0d9e0df819dbd]
stable/6.1: [bca8df998cce1fead8cbc69144862eadc2e34c87]
stable/6.12: [ec334aaab74705cc515205e1da3cb369fdfd93cd]
stable/6.6: [0236742bd959332181c1fcc41a05b7b709180501]

CVE-2025-37999: fs/erofs/fileio: call erofs_onlinefolio_split() after
bio_add_folio()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37999

Introduced by commit ce63cb6 ("erofs: support unencoded inodes for
fileio") in v6.12-rc1.
Introduced by commit 9f74ae8 ("erofs: shorten bvecs[] for file-backed
mounts") in v6.14-rc1.
Fixed in v6.15-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bbfe756dc3062c1e934f06e5ba39c239aa953b92]
stable/6.12: [61e0fc3312309867e5a3495329dad0286d2a5703]

* Updated CVEs

CVE-2021-47037: ASoC: q6afe-clocks: fix reprobing of the driver

stable/5.10 was fixed.

Fixed status
stable/5.10: [2202e87fc19440cecfd4f7b4f60a7d48bc2e236c]

CVE-2022-21546: scsi: target: Fix WRITE_SAME No Data Buffer crash

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [d8e6a27e9238dd294d6f2f401655f300dca20899]
stable/5.15: [4226622647e3e5ac06d3ebc1605b917446157510]
stable/5.4: [54e57be2573cf0b8bf650375fd8752987b6c3d3b]

CVE-2022-49063: ice: arfs: fix use-after-free when freeing @rx_cpu_rmap

stable/5.10 was fixed.

Fixed status
stable/5.10: [ba2f6ec28733fb6b24ed086e676df3df4c138f3f]
stable/5.15: [618df75f2e30c7838a3e010ca32cd4893ec9fe33]

CVE-2024-26739: net/sched: act_mirred: don't override retval if we
already lost the skb

stable/5.10 was fixed.

Fixed status
stable/5.10: [0117fe0a4615a7c8d30d6ebcbf87332fbe63e6fd]
stable/5.15: [9d3ef89b6a5e9f2e940de2cef3d543be0be8dec5]
stable/6.1: [e873e8f7d03a2ee5b77fb1a305c782fed98e2754]
stable/6.6: [28cdbbd38a4413b8eff53399b3f872fd4e80db9d]
stable/6.7: [f4e294bbdca8ac8757db436fc82214f3882fc7e7]

CVE-2024-35790: usb: typec: altmodes/displayport: create sysfs nodes
as driver's default device attribute group

stable/5.10 was fixed.

Fixed status
stable/5.10: [6b989ea1c479533ab8dbfbeb1704c94b1d3320da]
stable/5.15: [9794ffd9d0c39ee070fbd733f862bbe89b28ba33]
stable/6.1: [f1c5ddaef506e3517dce338c08a60663b1521920]
stable/6.6: [4a22aeac24d0d5f26ba741408e8b5a4be6dc5dc0]

CVE-2024-38541: of: module: add buffer overflow check in of_modalias()

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [733e62786bdf1b2b9dbb09ba2246313306503414]
stable/5.15: [c7f24b7d94549ff4623e8f41ea4d9f5319bd8ac8]
stable/5.4: [46795440ef2b4ac919d09310a69a404c5bc90a88]
stable/6.1: [5d59fd637a8af42b211a92b2edb2474325b4d488]
stable/6.6: [0b0d5701a8bf02f8fee037e81aacf6746558bfd6]
stable/6.9: [e45b69360a63165377b30db4a1dfddd89ca18e9a]

CVE-2024-43863: drm/vmwgfx: Fix a deadlock in dma buf fence polling

stable/5.10 was fixed.

Fixed status
stable/5.10: [9908dc0d2ef0e4aec8a242c098455729c0e2f017]
stable/5.15: [9e20d028d8d1deb1e7fed18f22ffc01669cf3237]
stable/6.1: [3b933b16c996af8adb6bc1b5748a63dfb41a82bc]
stable/6.10: [c98ab18b9f315ff977c2c65d7c71298ef98be8e3]
stable/6.6: [a8943969f9ead2fd3044fc826140a21622ef830e]

CVE-2024-46751: btrfs: don't BUG_ON() when 0 reference count at
btrfs_lookup_extent_info()

stable/5.10 was fixed.

Fixed status
stable/5.10: [9c309d2434abbe880712af7e60da9ead8b6703fe]
stable/5.15: [d64807ded1b6054f066e03d8add6d920f3db9e5d]
stable/6.1: [18eb53a2734ff61b9a72c4fef5db7b38cb48ae16]
stable/6.10: [ef9a8b73c8b60b27d9db4787e624a3438ffe8428]
stable/6.6: [3cfec712a439c5c5f5c718c5c669ee41a898f776]

CVE-2024-53203: usb: typec: fix potential array underflow in
ucsi_ccg_sync_control()

stable/5.10 was fixed.

Fixed status
stable/5.10: [627c2a5056aba42a8a96a8fffe8996aeccf919a9]
stable/5.15: [e15fd96c0b701c53f9006bcc836eaeb35a05a023]
stable/6.1: [e44189455c62469eb91d383ce9103d54c1f807a3]
stable/6.12: [56971710cd541f2f05160a84b3183477d34a1be9]
stable/6.6: [0e66fd8e5a2e45c7dacfc9178ba702153f4a61a8]

CVE-2024-56655: netfilter: nf_tables: do not defer rule destruction via call_rcu

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [2991dc357a28b61c13ed1f7b59e9251e2b4562fb]
stable/5.15: [b8d8f53e1858178882b881b8c09f94ef0e83bf76]
stable/5.4: [5146c27b2780aac59876a887a5f4e793b8949862]
stable/6.1: [b0f013bebf94fe7ae75e5a53be2f2bd1cc1841e3]
stable/6.12: [7cf0bd232b565d9852cb25fd094f77254773e048]
stable/6.6: [27f0574253f6c24c8ee4e3f0a685b75ed3a256ed]

CVE-2024-56758: btrfs: check folio mapping after unlock in relocate_one_folio()

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [36679fab54fa7bcffafd469e2c474c1fc4beaee0]
stable/6.12: [d508e56270389b3a16f5b3cf247f4eb1bbad1578]
stable/6.6: [c7b1bd52a031ad0144d42eef0ba8471ce75122dd]

CVE-2025-21816: hrtimers: Force migrate away hrtimers queued after
CPUHP_AP_HRTIMERS_DYING

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [82ac6adbbb2aad14548a71d5e2e37f4964a15e38]
stable/6.12: [e456a88bddae4030ba962447bb84be6669f2a0c1]
stable/6.13: [2aecec58e9040ce3d2694707889f9914a2374955]
stable/6.6: [63815bef47ec25f5a125019ca480882481ee1553]

CVE-2025-37819: irqchip/gic-v2m: Prevent use after free of gicv2m_get_fwnode()

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [b63de43af8d215b0499eac28b2caa4439183efc1]
stable/5.15: [f95659affee301464f0d058d528d96b35b452da8]
stable/5.4: [0c241dedc43a036599757cd08f356253fa3e5014]
stable/6.1: [dc0d654eb4179b06d3206e4396d072108b9ba082]
stable/6.12: [3939d6f29d34cdb60e3f68b76e39e00a964a1d51]
stable/6.14: [47bee0081b483b077c7560bc5358ad101f89c8ef]
stable/6.6: [2f2803e4b5e4df2b08d378deaab78b1681ef9b30]

CVE-2025-37890: net_sched: hfsc: Fix a UAF vulnerability in class with
netem as child qdisc

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [e0cf8ee23e1915431f262a7b2dee0c7a7d699af0]
stable/5.15: [e3e949a39a91d1f829a4890e7dfe9417ac72e4d0]
stable/5.4: [273bbcfa53541cde38b2003ad88a59b770306421]
stable/6.1: [8df7d37d626430035b413b97cee18396b3450bef]
stable/6.12: [2e7093c7a8aba5d4f8809f271488e5babe75e202]
stable/6.14: [ac39fd4a757584d78ed062d4f6fd913f83bd98b5]
stable/6.6: [6082a87af4c52f58150d40dec1716011d871ac21]

CVE-2025-37909: net: lan743x: Fix memleak issue when GSO enabled

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [6c65ee5ad632eb8dcd3a91cf5dc99b22535f44d9]
stable/5.15: [df993daa4c968b4b23078eacc248f6502ede8664]
stable/5.4: [093855ce90177488eac772de4eefbb909033ce5f]
stable/6.1: [a0e0efbabbbe6a1859bc31bf65237ce91e124b9b]
stable/6.12: [189b05f189cac9fd233ef04d31cb5078c4d09c39]
stable/6.14: [f42c18e2f14c1b1fdd2a5250069a84bc854c398c]
stable/6.6: [dae1ce27ceaea7e1522025b15252e3cc52802622]

CVE-2025-37913: net_sched: qfq: Fix double list add in class with
netem as child qdisc

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [005a479540478a820c52de098e5e767e63e36f0a]
stable/5.15: [0bf32d6fb1fcbf841bb9945570e0e2a70072c00f]
stable/5.4: [041f410aec2c1751ee22b8b73ba05d38c3a6a602]
stable/6.1: [0aa23e0856b7cedb3c88d8e3d281c212c7e4fbeb]
stable/6.12: [53bc0b55178bd59bdd4bcd16349505cabf54b1a2]
stable/6.14: [370218e8ce711684acc4cdd3cc3c6dd7956bc165]
stable/6.6: [a43783119e01849fbf2fe8855634e8989b240cb4]

CVE-2025-37914: net_sched: ets: Fix double list add in class with
netem as child qdisc

stable/5.10 was fixed.

Fixed status
stable/5.10: [24388ba0a1b1b6d4af1b205927ac7f7b119ee4ea]
stable/5.15: [554acc5a2ea9703e08023eb9a003f9e5a830a502]
stable/6.1: [9efb6a0fa88e0910d079fdfeb4f7ce4d4ac6c990]
stable/6.12: [1f01e9f961605eb397c6ecd1d7b0233dfbf9077c]
stable/6.14: [bc321f714de693aae06e3786f88df2975376d996]
stable/6.6: [72c3da7e6ceb74e74ddbb5a305a35c9fdfcac6e3]

CVE-2025-37915: net_sched: drr: Fix double list add in class with
netem as child qdisc

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [4b07ac06b0a712923255aaf2691637693fc7100d]
stable/5.15: [2968632880f1792007eedd12eeedf7f6e2b7e9f3]
stable/5.4: [5da3aad1a13e7edb8ff0778a444ccf49930313e9]
stable/6.1: [4f0ecf50cdf76da95828578a92f130b653ac2fcf]
stable/6.12: [26e75716b94d6ff9be5ea07d63675c4d189f30b4]
stable/6.14: [ab2248110738d4429668140ad22f530a9ee730e1]
stable/6.6: [db205b92dfe0501e5b92fb7cf00971d0e44ba3eb]

CVE-2025-37923: tracing: Fix oob write in trace_seq_to_buffer()

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [665ce421041890571852422487f4c613d1824ba9]
stable/5.15: [1a3f9482b50b74fa9421bff8ceecfefd0dc06f8f]
stable/5.4: [f4b0174e9f18aaba59ee6ffdaf8827a7f94eb606]
stable/6.1: [441021e5b3c7d9bd1b963590652c415929f3b157]
stable/6.12: [1f27a3e93b8d674b24b27fcdbc6f72743cd96c0d]
stable/6.14: [c5d2b66c5ef5037b4b4360e5447605ff00ba1bd4]
stable/6.6: [056ebbddb8faf4ddf83d005454dd78fc25c2d897]

CVE-2025-37927: iommu/amd: Fix potential buffer overflow in parse_ivrs_acpihid

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [a65ebfed65fa62797ec1f5f1dcf7adb157a2de1e]
stable/5.15: [466d9da267079a8d3b69fa72dfa3a732e1f6dbb5]
stable/5.4: [2b65060c84ee4d8dc64fae6d2728b528e9e832e1]
stable/6.1: [c3f37faa71f5d26dd2144b3f2b14525ec8f5e41f]
stable/6.12: [10d901a95f8e766e5aa0bb9a983fb41271f64718]
stable/6.14: [c8bdfc0297965bb13fa439d36ca9c4f7c8447f0f]
stable/6.6: [13d67528e1ae4486e9ab24b70122fab104c73c29]

CVE-2025-37930: drm/nouveau: Fix WARN_ON in nouveau_fence_context_kill()

stable/5.10 was fixed.

Fixed status
stable/5.10: [39d6e889c0b19a2c79e1c74c843ea7c2d0f99c28]
stable/5.15: [2ec0f5f6d4768f292c8406ed92fa699f184577e5]
stable/6.1: [47ca11836c35c5698088fd87f7fb4b0ffa217e17]
stable/6.12: [b771b2017260ffc3a8d4e81266619649bffcb242]
stable/6.14: [0453825167ecc816ec15c736e52316f69db0deb9]
stable/6.6: [126f5c6e0cb84e5c6f7a3a856d799d85668fb38e]

CVE-2025-37932: sch_htb: make htb_qlen_notify() idempotent

stable/5.4 was fixed.

Fixed status
stable/5.4: [e6b45f4de763b00dc1c55e685e2dd1aaf525d3c1]
stable/6.1: [73cf6af13153d62f9b76eff422eea79dbc70f15e]
stable/6.12: [0a188c0e197383683fd093ab1ea6ce9a5869a6ea]
stable/6.14: [a61f1b5921761fbaf166231418bc1db301e5bf59]
stable/6.6: [bbbf5e0f87078b715e7a665d662a2c0e77f044ae]

CVE-2025-37949: xenbus: Use kref to track req lifetime

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [f1bcac367bc95631afbb918348f30dec887d0e1b]
stable/5.15: [4d260a5558df4650eb87bc41b2c9ac2d6b2ba447]
stable/5.4: [0e94a246bb6d9538010b6c02d2b1d4717a97b2e5]
stable/6.1: [8b02f85e84dc6f7c150cef40ddb69af5a25659e5]
stable/6.12: [8e9c8a0393b5f85f1820c565ab8105660f4e8f92]
stable/6.14: [2466b0f66795c3c426cacc8998499f38031dbb59]
stable/6.6: [cbfaf46b88a4c01b64c4186cdccd766c19ae644c]

CVE-2025-37953: sch_htb: make htb_deactivate() idempotent

stable/5.4 was fixed.

Fixed status
stable/5.4: [99ff8a20fd61315bf9ae627440a5ff07d22ee153]
stable/6.1: [c928dd4f6bf0c25c72b11824a1e9ac9bd37296a0]
stable/6.12: [98cd7ed92753090a714f0802d4434314526fe61d]
stable/6.14: [c4792b9e38d2f61b07eac72f10909fa76130314b]
stable/6.6: [31ff70ad39485698cf779f2078132d80b57f6c07]

CVE-2025-37969: iio: imu: st_lsm6dsx: fix possible lockup in
st_lsm6dsx_read_tagged_fifo

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [76727a1d81afde77d21ea8feaeb12d34605be6f4]
stable/5.15: [35b8c0a284983b71d92d082c54b7eb655ed4194f]
stable/5.4: [4db7d923a8c298788181b796f71adf6ca499f966]
stable/6.1: [16857370b3a30663515956b3bd27f3def6a2cf06]
stable/6.12: [dadf9116108315f2eb14c7415c7805f392c476b4]
stable/6.14: [9ddb4cf2192c213e4dba1733bbcdc94cf6d85bf7]
stable/6.6: [9ce662851380fe2018e36e15c0bdcb1ad177ed95]

CVE-2025-37970: iio: imu: st_lsm6dsx: fix possible lockup in
st_lsm6dsx_read_fifo

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [84e39f628a3a3333add99076e4d6c8b42b12d3a0]
stable/5.15: [f3cf233c946531a92fe651ff2bd15ebbe60630a7]
stable/5.4: [f06a1a1954527cc4ed086d926c81ff236b2adde9]
stable/6.1: [6c4a5000618a8c44200d455c92e2f2a4db264717]
stable/6.12: [a1cad8a3bca41dead9980615d35efc7bff1fd534]
stable/6.14: [3bb6c02d6fe8347ce1785016d135ff539c20043c]
stable/6.6: [da33c4167b9cc1266a97215114cb74679f881d0c]

CVE-2025-37987: pds_core: Prevent possible adminq overflow/stuck condition

stable/6.6 was fixed.

Fixed status
stable/6.12: [2982e07ad72b48eb12c29a87a3f2126ea552688c]
stable/6.14: [5e3dc65675faad846420d24762e4faadc12d9392]
stable/6.6: [517f928cc0c133472618cbba18382b46f5f71ba3]

CVE-2025-37990: wifi: brcm80211: fmac: Add error handling for
brcmf_usb_dl_writeimage()

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [62a4f2955d9a1745bdb410bf83fb16666d8865d6]
stable/5.15: [508be7c001437bacad7b9a43f08a723887bcd1ea]
stable/5.4: [972bf75e53f778c78039c5d139dd47443a6d66a1]
stable/6.1: [524b70441baba453b193c418e3142bd31059cc1f]
stable/6.12: [bdb435ef9815b1ae28eefffa01c6959d0fcf1fa7]
stable/6.14: [fa9b9f02212574ee1867fbefb0a675362a71b31d]
stable/6.6: [08424a0922fb9e32a19b09d852ee87fb6c497538]

CVE-2025-37991: parisc: Fix double SIGFPE crash

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [757ba4d17b868482837c566cfefca59e2296c608]
stable/5.15: [ec4584495868bd465fe60a3f771915c0e7ce7951]
stable/5.4: [2a1aff3616b3b57aa4a5f8a7762cce1e82493fe6]
stable/6.1: [6c639af49e9e5615a8395981eaf5943fb40acd6f]
stable/6.12: [cf21e890f56b7d0038ddaf25224e4f4c69ecd143]
stable/6.14: [df3592e493d7f29bae4ffde9a9325de50ddf962e]
stable/6.6: [6a098c51d18ec99485668da44294565c43dbc106]

CVE-2025-37992: net_sched: Flush gso_skb list too during ->change()

stable/5.10 was fixed.

Fixed status
stable/5.10: [ea1132ccb112f51ba749c56a912f67970c2cd542]
stable/5.15: [d3336f746f196c6a53e0480923ae93939f047b6c]
stable/6.1: [d38939ebe0d992d581acb6885c1723fa83c1fb2c]
stable/6.12: [d1365ca80b012d8a7863e45949e413fb61fa4861]
stable/6.14: [fe88c7e4fc2c1cd75a278a15ffbf1689efad4e76]
stable/6.6: [a7d6e0ac0a8861f6b1027488062251a8e28150fd]

CVE-2025-37997: netfilter: ipset: fix region locking in hash types

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [226ce0ec38316d9e3739e73a64b6b8304646c658]
stable/5.15: [82c1eb32693bc48251d92532975e19160987e5b9]
stable/5.4: [00cfc5fad1491796942a948808afb968a0a3f35b]
stable/6.1: [aa77294b0f73bb8265987591460cd25b8722c3df]
stable/6.12: [e2ab67672b2288521a6146034a971f9a82ffc5c5]
stable/6.14: [6e002ecc1c8cfdfc866b9104ab7888da54613e59]
stable/6.6: [a3dfec485401943e315c394c29afe2db8f9481d6]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

