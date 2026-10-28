Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.560.1793228575246672065
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Oct 2026 16:02:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20260707.gappssmtp.com header.s=20260707 header.b=jcmeywR+;
 spf=pass (domain: miraclelinux.com, ip: 74.125.224.49, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-67921b515a7so1567644d50.2
        for <cip-dev@lists.cip-project.org>; Wed, 28 Oct 2026 16:02:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793228574; cv=none;
        d=google.com; s=arc-20260327;
        b=W9NT5mOe5cuCIiSHKK6Q4FWVngqoTf9YqGMhFr0dzH/evB1T3Vvsz+Cpwf6drHtDEv
         LBr6zNYLVkjOPI9P6iWHNT8e+eWQB2saEcdgSUgXL9zSSoQqiiRQMnQYHh+vwE53KMUn
         OKXmuJNMwbyTFenSMHhk+bn2U2iJ3n+Uo6zxp6vjH8yod+zdEWfDjdpOFTERgy4sX6as
         F2/LerlmtwvebOfpDsvXC4zfQau7FJQaFftPSfEO04s7wh+FCuTPLCTHzMMACdX4cBxq
         YsaC8wyNe1NMf4Z6CdpytluI5DHSXr0sppzaMj0IBU+a6Rz6eg+nb7AmlLwhZm9wKKmz
         725A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=k3e/6IhGe92A0OeWG15/vylYleLVn4FlDsVWrk4DicA=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=Fa0U7+N2oGDPedb/3XW2vzuGVzvlZLNpKnbseLdiTqB3UJrbjMZbhKNLhrh7jDC3g7
         hgtpsM9SXC91UygAjq8BfFWEd5kCLEWCRl0nq5UyWF6agfr/UZbCeIWadfLDudAYKQl7
         RIopwBYgiOccKHCn4ZWCjrDrN8obKfexIUTGiBOq1FQEVeKmoYESJB4Sj8etpmY9TucG
         kQWyRt58IyTRMUKzBB5B45vamvJ0ju7uLRqNaiceavNjYc8XsRsMRTedk0vuoX+JHFCy
         esz7EgvlNG2Zf9ZrWTzkoHJEO2/akWh0NT4K58K1sPU2JBU6uehi9dBrluB+zoUb1GXi
         Ks0Q==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20260707.gappssmtp.com; s=20260707; t=1793228574; x=1793833374; darn=lists.cip-project.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=k3e/6IhGe92A0OeWG15/vylYleLVn4FlDsVWrk4DicA=;
        b=jcmeywR+U8GoQDKqBzInZWYiEzbuHmPiuRrf4Surzp0JeAq7pJJ3Q/2gF9gdpv5GW1
         ljYSN99oBiKAy7GsRdsTnO5qKbArtSOz8k73yoSpfQmFKsTNI157uJQPWWvl7txfUHp5
         6JgQHhqMR5UVdaMUsKBfwdeIK1fND1bN2u3OLmAnZUR/pbfxzfjqLN/3a6XcmuAZGhAN
         Dy7N5RTFvh3L0Jll6ciuq3us7mA6n4Twq2jvG7/yRaMEvGpSda2BdKvSMrxG/VyabLB7
         +EjzIbao6X6NoDOEQOsMu5F8EAReR45Q/VL9nrJ2Qp7gvDUe6Ba1ewwLBFh3Hnyyq5h1
         NMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793228574; x=1793833374;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k3e/6IhGe92A0OeWG15/vylYleLVn4FlDsVWrk4DicA=;
        b=myIrmFnPBm/Gyiof4mrHS/myLEQ73DoNjNlLjHT/NhJQFp7rjs0GIEohCF6/HsUfGC
         0KiPLe2y1KT4rrCbGSqke10MfxUgwxsPvZ9nS4Z7dRj6C53B850LvkgV13dhFFPFTlv4
         kYDvQdA4GaBSRMtKIn5h6/lhJkctcFhti16g2cA6cxUIc8p3VTFQX+9kHcV9jyavzUSh
         Ltbzpi3owCeEUJI0g+/hTdkdgfhuVmHkBvtbw/sI/YTZqDR6XoY90MRSn5lIZcyOfJfl
         iMc8BifvZEHr/9W1V57Av3aQPgce99jOQU/hDuw/DxLwjYA9Nq6CvnwCaE1x5uDNXkVe
         fYCA==
X-Gm-Message-State: AFq9FYJ6jMSXDZaCekwqJzrdVFcwg2DLNrbu8d/df7O12b4AKJQdv1ly
	rCr6VuajyNWJ2lzGv+N3efqmID3YQJZUsYgg9qD7iGJ6V81E/kYnfdHFlpeRztKFecS5E3R8uup
	BWbiQ9iQdokmUax9LKntvqeyqD33+/c8y050NaXeQTzCbVK4PG7JOdu07XQ==
X-Gm-Gg: AYBFou3RXkOQt1UO5waAtgM1XQoNHeePphJmQZaqPwsU/NldBnjAr4byFMUOKrbNMI1
	Y4JwCwtEc7lropJMYb/16HXB6Tnia7X5VYywNl8si0mFd/bezMJOrnuhEOksEYZC9Mb3keEyi6F
	1iNE8b+jGGCHK+y55r/AjvhcTWvHcnQJ2kAq1OM+CoV1uizajXj0fPHKwDPMl0j62raWhRUb0KK
	kM8l/J4z/uNtYaX5cowodjDHH2LYZT2z8u48cCcTpU6gDTaJaht/8MXFaFG81ok0Omtd9uarJiO
	Zb9dTcU4yduTItsD1ePKrQGKwDx2PmffouKQzdWWEzGpvR3UbK++yk38gz+RjJRme2Wnzbdx16R
	J/Y/8v+PdOzS69h0rrLHsFAyJD5UooqLATLTMxgkXlZVfNme2mG6f/2ClL+rhJ46yKoGJXUt88b
	bcIA/GzqlpJxPDuPVeakFPtV4Lb5mCQA==
X-Received: by 2002:a05:690e:441a:b0:679:8f53:9d5b with SMTP id
 956f58d0204a3-67a7bd2204amr2406749d50.85.1793228568608; Wed, 28 Oct 2026
 16:02:48 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 29 Oct 2026 08:02:11 +0900
X-Gm-Features: AclHuK-AG0QfhMvx6C54puw4kF4Eb98IZYCWaiBirSlFLtiG4cCAHkKI8sGeKt8
Message-ID: <CAODzB9rCFF3wikpkTOeJxQLF-U-2XjjR0gg5nAzJ8hgxCUWREA@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 28 Oct 2026 23:03:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24562

Hi!

It's this week's CVE report.

This week reported 347 new CVEs and 5 updated CVEs.

* New CVEs
CVE-2026-98870: ksmbd: remove stale channels from all sessions on teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98870

Introduced by commit faf8578 ("ksmbd: find bound sessions during
reauthentication") in v7.2-rc3.
Fixed in v7.2-rc4.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/5.15 stable/6.1 stable/6.12
stable/6.18 stable/6.6

Fixed status
mainline: [b10665730fbf6b5e45fe422badcbbc3f0df96ef5]
stable/6.1: [f8200bb4994e65a2e5c5b314789eeae39078619d]
stable/6.12: [b145f9b56c87f9c23ad5464ab0844dbc1de12b36]
stable/6.18: [a15cae16f4432a5ad919ee633e31b07178492955]
stable/6.6: [9cd6d714d3ca0cff296542dc989696884e41970f]

CVE-2026-98871: crypto: ccp - Fix possible deadlock in SEV init failure path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98871

Introduced by commit 7364a6f ("crypto: ccp: Handle non-volatile
INIT_EX data when SNP is enabled") in v6.9-rc1.
Introduced by commit 7364a6f ("crypto: ccp: Handle non-volatile
INIT_EX data when SNP is enabled") in v6.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b0e7ec0dab242c5e480121ba12400d0513e37ca2]
stable/6.12: [8e7e06ee7c2938ee3fa31a61cc5289a45c8c13f1]
stable/6.18: [ffd3a3df92be697eb78118a146c6a5d5e6c1f724]
stable/7.2: [364f3841bc22c72b6e2cb72a1e3c91c9c8fc1ef4]

CVE-2026-98872: freevxfs: don't BUG() on unknown typed-extent type

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98872

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [704d48d81dc41470e108811c32c577ada66192d4]
stable/5.10: [fe40a19d571cbb584eea46038ee919d8712b2d2c]
stable/5.15: [500e9d5bf9eff2096a21b7ac25a0a06ca46ab821]
stable/6.1: [f1f2d54a576f0e4133b979e545abcfefd439c300]
stable/6.12: [1284d687d46953fff9c0d969df108114611aca8b]
stable/6.18: [405f13d7b270913e06e8e2b4de568985f94ef7d6]
stable/6.6: [7ada9807e37103b41f586d34e3075e1209182b65]

CVE-2026-98873: netfilter: nf_conntrack_expect: zero at allocation time

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98873

According to the .vulnerable file, this bug was introduced by commit
076a0ca in v3.4-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [241ccd2fed9051db443aadce248fc0ab30f55e97]
stable/5.10: [39cb6ff947c16a576ea68c5f272e634acdcb0085]
stable/5.15: [90545aa07a183887e9d72ce573c18e08f62e2c91]
stable/6.1: [9c11d7ea5ff4dbe162e79f00188814ef5483c295]
stable/6.12: [824397af7bfe14edad374c64253dae0187ca623d]
stable/6.18: [a39ecb856514274c80d0fac4d128dba6b266a8ed]
stable/6.6: [b7f3ee925aee9f1f547d539bc03c35433c238958]

CVE-2026-98874: wifi: iwlwifi: mld: don't WARN on WoWLAN suspend w/o netdetect

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98874

According to the .vulnerable file, this bug was introduced by commit
d1e879e in v6.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [301b0dfa9db3f1e204de95e803bbd88fbd878c7c]
stable/6.18: [d4158bc784f4b45c8daa446a8e1c29eb11f63674]

CVE-2026-98875: drm/nouveau/gsp: add SEC2 to GA100 chip table

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98875

According to the .vulnerable file, this bug was introduced by commit
176fdcb in v6.7-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [604d0efb17cc0dd197e089134736ac2698d5fca7]
stable/6.18: [f29267ace04283e76f92a74d9a7f4fcfcb32f484]
stable/6.6: [feb1ad41281aed00e8a741942e56a1cd774e8342]

CVE-2026-98876: host1x: bus: Fix missing ops null check in error teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98876

According to the .vulnerable file, this bug was introduced by commit
8f7da15 in v4.16-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [71d25f668bc5c0f36ea843462e12307dea45aaa3]
stable/5.15: [d8d5b6e02fc281dea33d6b0b0fadaccea56f2067]
stable/6.1: [f1fa6c936fa9de80ae446ba5e76e227e991b8e56]
stable/6.12: [62851e7b0e55de6fe08da08bc41fd587fbcb0e9b]
stable/6.18: [29375e071ea201fe97bafe1d2ad9d9f30311abfb]
stable/6.6: [74bd1f05d9ba2d6672d30ccafe80a38104c1f73f]

CVE-2026-98877: irqchip/gic-v4: Don't advertise VLPIs if no ITS is probed

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98877

According to the .vulnerable file, this bug was introduced by commit
a754605 in v4.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e61654fbc3bc5d07ec9fafe29f33e19b2b5d0fd5]
stable/5.10: [3e4cae9f1472ba3c9fe87edee24074618b51f537]
stable/5.15: [a2508b8855acc96abe69be73b41b672f1ef12516]
stable/6.1: [e79934064be85fc9a3a6434da857307d8b78e33d]
stable/6.12: [ab233119a19716b8f33e73ea7e092e0eb353cfbf]
stable/6.18: [c8a911b3b07baa0aeb3dbc4e16a4670bd21bed40]
stable/6.6: [4761493dd663443f7353c184e6fa16e1cb3ac5a1]

CVE-2026-98878: irqchip/gic-v5: Immediately exec priority drop
following activate

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98878

According to the .vulnerable file, this bug was introduced by commit
7ec80fb in v6.17-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [abf60331ebe9a9a7937a72aac7699c2907ab9307]
stable/6.18: [c29bb5acd0cad0b49399d1399dd1bacb39e41438]

CVE-2026-98879: isofs: handle set_blocksize failures

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98879

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [25ef4c4d9f0e96fb89c0ae0d7127c3f12a31bc32]
stable/5.10: [6db7f0ba365786304558db6a3d52013ae176e03e]
stable/5.15: [61f277bf35f533b602984f0e55900111fe52f31a]
stable/6.1: [cebde6d88e34396c29f2f001d90e921677cc17d6]
stable/6.12: [9c97e3b1152d3092581745189f5d2f04c6404ef9]
stable/6.18: [9584ab6283721e5aab485c79bd06c2f78d89e55c]
stable/6.6: [28d1f6aa14f5924e36602b7a31c9141d34de0b9c]

CVE-2026-98880: ntfs3: handle set_blocksize failures

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98880

According to the .vulnerable file, this bug was introduced by commit
82cae26 in v5.15-rc1.
Fixed in v7.2-rc1.
Add minimal affected version. Affected file was added by 82cae269
("fs/ntfs3: Add initialization of super block") in v5.15-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [24f7d1824b7581ae3daf9d443c5dfeabd89df6d8]
stable/6.12: [c5b8a7ec9a0a71518915c82b8552be1ccbb88288]
stable/6.18: [78e10082f3e919b8863958feac5f269d3ade9469]
stable/6.6: [df9dac4dbe557f6455a61e68cc09ef98b22f3686]

CVE-2026-98881: net: bridge: remove stale rcu_barrier() in
br_multicast_dev_del()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98881

According to the .vulnerable file, this bug was introduced by commit
19e3a9c in v5.0-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [25ae123db10ba9ab890b56bcdb0a4363aee8529a]
stable/5.10: [35f9f11740515a10b084adfb1ce691351f2452ab]
stable/5.15: [0443f6aac6bf6a91e406273fdda11497cef6ad07]
stable/6.1: [ac0e823a228f94ad9d7a3d876cc07e59a7afb806]
stable/6.12: [372ee8fbe0f796031c60f676ec90f0788c26523d]
stable/6.18: [39679927fa7aaf4601119f7234342d1b5d4f6f84]
stable/6.6: [f0018acf0b66f93a292667c9a9c2a26c570cf270]

CVE-2026-98882: media: chips-media: wave5: Add range checks for dec_output_info

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98882

According to the .vulnerable file, this bug was introduced by commit
45d1a2b in v6.8-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [79aef69bb0903616f4867f0168aea717a11c439c]
stable/6.12: [d6f777d11c7b34549cdadd8578d4b85f685eb976]
stable/6.18: [144f24ec0fc1e51673611912a6d14ded0a61db43]

CVE-2026-98883: serial: 8250_port: recognize UPIO_AU

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98883

According to the .vulnerable file, this bug was introduced by commit
7c7e6c8 in v6.13-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [49fa670efdfdd27e29145cbd2beef065c08717ef]
stable/6.18: [9f67997353caa29c6a080789a1fb6e01fb50c118]

CVE-2026-98884: mmc: core: Add validation for host-provided max_segs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98884

According to the .vulnerable file, this bug was introduced by commit
05e5b13 in v2.6.24-rc4.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3e0483e93a8be320f70a1ff68d835f7f015af311]
stable/5.15: [03f5a16ec85beebabd5ab5e67ac1527f87908ded]
stable/6.1: [c465608bd25d7f8565be7817a6a36a5d69f8aa14]
stable/6.12: [9cca3c0c1472d6204ef8a78a6e7b3afe9610b22e]
stable/6.18: [b037c2f7794aa01ee2a00e43c29645fd2dd2dfb9]
stable/6.6: [a8283f7d93f0d9336b15618b9665279ff6944319]

CVE-2026-98885: ima: return error early if file xattr cannot be changed

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98885

According to the .vulnerable file, this bug was introduced by commit
07f6a79 in v3.7-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [69fc6474236d9edda6983623e4282f2bdfd8e3d8]
stable/5.10: [86acb68ebb220b83def94e7f4c33e24e843970e0]
stable/5.15: [4d98295357bcacb70874e73117e298a9d7d9b830]
stable/6.1: [c6988714c0549e06610635c7a71e88635da6db64]
stable/6.12: [dce1b66fcfb40c935f426f602c3a41a7b9f62ba4]
stable/6.18: [2f29f880e98bf0087215726c45a485afd15b42cf]
stable/6.6: [8c77312728d07b60fc028f676e42d842df918bcd]

CVE-2026-98886: drm/gma500: return errors from Oaktrail HDMI I2C reads

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98886

According to the .vulnerable file, this bug was introduced by commit
1e585b5 in v3.1-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9b5ce5c496efd20c1c662cedba88465d39ec1f93]
stable/5.10: [09a950950e7e4e74e021e60941c8e816ef1b4f71]
stable/5.15: [898d209157fe2a245f7d9fe28c5921037d8b5033]
stable/6.1: [15c6d7f7127a53b7312232178ecf03e5850161d2]
stable/6.12: [f85e8224bd4e1a0939cbfe13a6220fbddf61127c]
stable/6.18: [c268df0653ab07bafc3d191e74ea097e3d9b9e69]
stable/6.6: [8add43887cca1fe11a0ded62199ce726901d3f20]

CVE-2026-98887: wifi: mac80211_hwsim: reject undersized HWSIM_ATTR_TX_INFO

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98887

According to the .vulnerable file, this bug was introduced by commit
5d44fe7 in v5.7-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3dc723ac78a6e4fa0fd49e27e487ed319da40a9f]
stable/5.10: [3a96bb65b4b820d8b41fa155781ec1c29e3479d4]
stable/5.15: [59e1f2a0242232b4a3af144ae317d3913fc09046]
stable/6.1: [1ae85bb34fe3510659b86d6a5f8036dd498233f8]
stable/6.12: [b5b1234bbfa25537fb9a5c0d62c328ed4547f721]
stable/6.18: [13edd8ea7ff2ce6a964b290ef2034cd8cbed96c7]
stable/6.6: [6f6368b20f8c9481fa7ba7b672dcb3c9f36b2695]

CVE-2026-98888: arm64: kprobes: Allow reentering kprobes while single-stepping

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98888

According to the .vulnerable file, this bug was introduced by commit
2dd0e8d in v4.8-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [23f851ac0078a908bf3422d6467ebc1db5828c46]
stable/5.10: [bb0fe9121aa0824211aafa33c7d0151fd25ddb75]
stable/5.15: [f96a0606de6bcc8d937b80e6470fd7a174c17e26]
stable/6.1: [1f342b3e44c3035a837b53b217d816f7511c0d0a]
stable/6.12: [68774caca799e9695db56d426c69acebd041c2ed]
stable/6.18: [a21bf9cb893126e8d9730995708d0be5eb167652]
stable/6.6: [c8e84e292ed4cfc199824146da71bb4397b02a1f]

CVE-2026-98889: wifi: iwlwifi: mvm: fix sched scan IE sizing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98889

According to the .vulnerable file, this bug was introduced by commit
eae94cf in v5.11-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4f155d262b31b9b17e0f9856bdabe0968eb4930f]
stable/5.15: [f2268060e99f94314b9988dfa17393c2694fa9b2]
stable/6.1: [358eca9a898ad4cce7453e9dcfd005d019a2b01f]
stable/6.12: [a24417478f90e9f1a4ea24cd4b784afccb56fbae]
stable/6.18: [0a63f98e5163a2ec2822dfb691ee5a6094de08ec]
stable/6.6: [05f79cea3b15cfe600b205ddcfd51ebee15d908a]

CVE-2026-98890: wifi: libertas: reject short monitor TX frames

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98890

According to the .vulnerable file, this bug was introduced by commit
876c9d3 in v2.6.22-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [13ff543e0b2c713aedeaadadde686686e949dc78]
stable/5.10: [68c92c991ddb75dfd3fd62a94a1d4d2dde44dc3c]
stable/5.15: [d865dd6de8295f2bfaa83f0f5d49d2bef1543065]
stable/6.1: [6576baa3fdbaa91fa75e4ba27095f4b8a27349a8]
stable/6.12: [443fac3de65c76544b450b9f9903be8989150d55]
stable/6.18: [cdcfd662c67833d89ee3d912efde2eb67c8a7326]
stable/6.6: [b657cc98d7936c5d9ed7e0e1944ad0e1f36375bb]

CVE-2026-98891: wifi: mac80211: validate deauth frame length before
reason access

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98891

According to the .vulnerable file, this bug was introduced by commit
c9c99f8 in v4.2-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4a360c6e18dfa9d70006c7247a6a8cc8dfe0d60f]
stable/5.10: [51092dc769f021e9634474e1bd5a561da477fbdb]
stable/5.15: [a6ed4c00ccdc15011a73daa2b38af9fc5a2c543e]
stable/6.1: [80d1a110e9096b5bf41497f6b151154084862385]
stable/6.12: [7a5ef1fd654d0e90d59aa32c881789c8bcc4125a]
stable/6.18: [9df64ad43e1f2c036667bba2bf385e9d7b3af564]
stable/6.6: [a78689e2beed200d4590318612c74ae25c9408cf]

CVE-2026-98892: firmware: arm_scmi: Validate BASE_ERROR_EVENT payload size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98892

According to the .vulnerable file, this bug was introduced by commit
585dfab in v5.9-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [56e7e64cdd0e7209a58c8ec66028d63387402919]
stable/5.10: [4a754704698017ced0b657c92b468035faad00ed]
stable/5.15: [28d65a0a46435d48b96b6943c518095dff1602a1]
stable/6.1: [890a9c3bf9dae90dcabded9d8e10c708a13779f7]
stable/6.12: [bd8bc95ef2daa3bac56197cffcbf2d4c5ed42216]
stable/6.18: [cb77a50d1114c0c9e084176301a8e094d383edfa]
stable/6.6: [c0742f23ec13fb6f5e0cd884323467a6c127d3c2]

CVE-2026-98893: firmware: arm_scmi: Validate SENSOR_UPDATE payload size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98893

According to the .vulnerable file, this bug was introduced by commit
e381119 in v5.11-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [32bc5496b48174dbca1f187f710955ee4d9527a1]
stable/5.15: [e543d60f966a5f5c92298720c2fd1810f85a6be3]
stable/6.1: [87a72e75f7560ea45cd28870194eaa153dd19e75]
stable/6.12: [c148ff2f5a168e0bc41d801efca6ee35a376cfcb]
stable/6.18: [767789a58ae0d65ec3028e5b5b4da82210355d00]
stable/6.6: [1bbe431fc59704d012660647516f6f94ddd82564]

CVE-2026-98894: drm/amd/ras: reset CPER ring on corrupt entry size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98894

According to the .vulnerable file, this bug was introduced by commit
4058e7c in v6.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4d695e66d7027a0c78302e47ac76293675fbbb4d]
stable/6.18: [a98d0d49757a113ce17960262b9cd4ccc1420108]

CVE-2026-98895: net/mlx5: HWS, Handle destroying table that has a miss table

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98895

According to the .vulnerable file, this bug was introduced by commit
9fc43b5 in v6.14-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [60e9e82f162ab7399373ff2185119289e4f6dc06]
stable/6.12: [16b81428f7b5f253ab30a998bc4f4ecd1c8823f8]
stable/6.18: [6efdc212627cecf33b594256ae4460b4c52a126a]

CVE-2026-98896: thunderbolt: Keep the domain reference while processing hotplug

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98896

According to the .vulnerable file, this bug was introduced by commit
d6cc51c in v3.17-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [138ec65b2c761f065b19d115aed2b8246fc272f5]
stable/5.10: [06b2e894e640f6a3dbeb536a2d26d72426b26a46]
stable/5.15: [1d991f749a8255ee2ecc6307e2f27354ab631827]
stable/6.1: [e8656465d08ed832e120c9cca4a6d0c8ccb45698]
stable/6.12: [04df2985159e381c88a923fae1bec2f8d0272412]
stable/6.18: [0a87af3b1e3aa2e09d160848daf0c39e765b73de]
stable/6.6: [b61a4ae2ec6a0d363615d01106e0a2d284133a38]

CVE-2026-98897: ksmbd: don't hold ci->m_lock while waiting for a lease break ack

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98897

According to the .vulnerable file, this bug was introduced by commit
d1c189c in v6.9.
Fixed in v7.2-rc2.
Affected file was added by e2f34481b24d ("cifsd: add server-side
procedures for SMB3") in v5.15-rc1.
Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [27a9bc968d4ae809a3f5ca2f2b136856ee613cb4]
stable/6.18: [868c9038ffd4af39766d087f68c8f543a3f66635]

CVE-2026-98898: drm/amd/pm/si: Don't schedule thermal work when queue
isn't initialized

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98898

According to the .vulnerable file, this bug was introduced by commit
1919696 in v4.9-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f8922d5a946699fc2bdc7660e6778bd6726bf8b8]
stable/5.10: [2c08ae91df3cf11d517dc1273195f7b1df2a0ddb]
stable/5.15: [7987c5abdf537663b0957de521edefe77ae12842]
stable/6.1: [8c9e7265b3379eb2ce1758b73c4ffa2606ae2256]
stable/6.12: [ac0250da54afb519fab98478e2e1d9e51d4737fd]
stable/6.18: [52c4c623474df0e19efa158057966f2a149bda28]
stable/6.6: [2750f52b58d92ca52a5496c00db8abf925103a27]

CVE-2026-98899: netfilter: ipset: mark the rcu locked areas properly

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98899

According to the .vulnerable file, this bug was introduced by commit
f66ee04 in v5.6-rc4.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5d0c22e73656d050daffad10a2ba8765ce8441c8]
stable/5.10: [67bd3d2350d17c2f4fb158c3f917c10b15ecbc94]
stable/5.15: [892399abd1a005a455d5b74d86d82b9773405f2b]
stable/6.1: [eee5172741b2c0e73210020732043e5d589295d3]
stable/6.12: [0c46c9ce24130657ec7460c27fba5d445f5abd06]
stable/6.18: [ca9fab1ca15534cef1630e81a479e94b3bbcdb6a]
stable/6.6: [ecb48c6b9edc78de8dd456c365727ae14b88c1ee]

CVE-2026-98900: xen/gntalloc: validate grant count before allocation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98900

According to the .vulnerable file, this bug was introduced by commit
dd31405 in v2.6.39-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2299822f3f466b5dcad2377bf63986199f881a6b]
stable/5.10: [e2806390aa1c4d5b3f7a68f10a56ae12c71c00d8]
stable/5.15: [71a0cf87e19fb35c4292ca88985e376e613c900a]
stable/6.1: [641de086a05f349de7fc548612432bc2fed721ca]
stable/6.12: [84d5727cef8eb9c8a28210ad248f1c70b223b065]
stable/6.18: [231542f4e43cf9837cb520664545e85fbe666b7b]
stable/6.6: [720554c04acba80018ded069d3e0984bebaee891]

CVE-2026-98901: ksmbd: fix lease break and ack state handling

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98901

According to the .vulnerable file, this bug was introduced by commit
e2f3448 in v5.15-rc1.
Fixed in v7.2-rc1.
Affected file was added by e2f34481b24d ("cifsd: add server-side
procedures for SMB3") in v5.15-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5015191096db311759fef98769270336cd8b1324]
stable/6.12: [3251ea36df5eef58aa207fbee48849d89b922ea6]
stable/6.18: [fba4653a0b4dc2f6d42600abe21fb326292f70ff]
stable/6.6: [17699905a381621c1cee5b6528feb05acedc86a4]

CVE-2026-98902: md/raid5: let stripe batch bm_seq comparison wrap-safe

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98902

According to the .vulnerable file, this bug was introduced by commit
2b6b245 in v4.1-rc6.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [00e93faf4cea9e8802ac5dfee0952d84fc95c40f]
stable/5.10: [647c7289a3960118e249c0a53da6f1ebba1e47a3]
stable/5.15: [ffdd3aee932fc293456678f6b0200ffe9bf12a6d]
stable/6.1: [628b14d0744bd5dfe176ea93559071cdcde14255]
stable/6.12: [c5c89e1a872a84019f674f5107111e6e6b7cc30f]
stable/6.18: [cc8eb1715673de850f14376782151f68f73ae3ce]
stable/6.6: [2fdc51228d9a8cad2d727d5aef732cc66fc6d56e]

CVE-2026-98903: mailbox: imx: Add a channel shutdown field

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98903

According to the .vulnerable file, this bug was introduced by commit
0a67003 in v5.7-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5ccea7eacb7786c358833634f45700365f6c1d99]
stable/6.12: [02273054b2e94e53065ea5644265bb9d8f7ee2a7]
stable/6.18: [944d8509c2220a2313d4a094a646507929fb6f8d]

CVE-2026-98904: mailbox: imx: Use devm_pm_runtime_enable()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98904

According to the .vulnerable file, this bug was introduced by commit
676f23e in v5.8-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1f602619e408b6e9655ee76656a2a5ab6e89c5e4]
stable/6.12: [b30a047744ea4344bb6f854b0a052cf276349128]
stable/6.18: [adcaa21d50c3a4c884f4d0b7a95fa3bd7a07cf84]

CVE-2026-98905: drm/amdkfd: Properly acquire queue buffers in CRIU restore

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98905

According to the .vulnerable file, this bug was introduced by commit
fb91065 in v6.12-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [20a5e7ffdfecddc34c60a6b4483f42acf3d8731d]
stable/6.12: [e2dbdd14c3352483a89e4a9afda05d0f3fcc2c83]
stable/6.18: [c6c290e408fe328e091f0bf7502a42b0deea82e9]

CVE-2026-98906: net: lan966x: restore RX state on reload failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98906

According to the .vulnerable file, this bug was introduced by commit
2ea1cba in v5.19-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aa97f11a76e545ed73cc455bcdd1ece4b480b507]
stable/6.12: [3883898ddc26308497dbba8068951ab5eddbd111]
stable/6.18: [b5a6462f4646687c922931133a2478da94addc87]

CVE-2026-98907: btrfs: protect sb_write_pointer() with invalidate lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98907

According to the .vulnerable file, this bug was introduced by commit
3c20917 in v6.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [123b9a545f4d0348e81f558a032bf2a93ee5722f]
stable/5.15: [c9b38f2eab5a9bd74087390318d93ccdd8d2deff]
stable/6.1: [a0dc28359a8a26f970ccd250b126a2e0bd4118a5]
stable/6.12: [a58cab4535f085adc0f93d7efd7952ef437371da]
stable/6.18: [80cd97c5e90096d040a623851795eac92fbd0ff1]
stable/6.6: [1a6c92aa7242a04e4349c0ea213dbf703a1c9891]

CVE-2026-98908: net: microchip: sparx5: clean up PSFP resources on
flower setup failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98908

According to the .vulnerable file, this bug was introduced by commit
6ebf182 in v6.3-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [46e50367338702abe3df661df7795bdada40fef7]
stable/6.12: [a46ea3f7ee0d3ad3d5e92043232b293be2a305d3]
stable/6.18: [640c1bd8d359ad34817f5afec0872985e87b49ec]
stable/6.6: [a7625d408f7f0535c2b0f05d53231d6496acd48b]

CVE-2026-98909: net: cpsw_new: unregister devlink on port registration failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98909

According to the .vulnerable file, this bug was introduced by commit
ed3525e in v5.5-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b64f763b607426ac97e44b114f0b8844ac3b86dd]
stable/5.10: [b020390b4ef39adc40c800301042baf812280da1]
stable/5.15: [5a5ac0defdd42e566f1c871272370b6a3a8eef5c]
stable/6.1: [43d4af5c5331ea739a49cb1097d41e502ed91ec4]
stable/6.12: [2bcf21ede6b097ca96cb1f7679761acca6510555]
stable/6.18: [0a44945b0d3422f5d81b49c97e293f3e21a8c585]
stable/6.6: [8af61d5bd87fd1a3bdc81fe948e7acdc8aa5bcf0]

CVE-2026-98910: drm/amdkfd: Unwind debug trap enable on copy_to_user failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98910

According to the .vulnerable file, this bug was introduced by commit
0ab2d75 in v6.5-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [01112e241e37f9ac98b6f418d93ce2e0b87b7ee0]
stable/6.12: [656a40bdc20def58790b8512e6000195436d8855]
stable/6.18: [1b39f46eec2f907417d4955bb88434170f94a8d8]
stable/6.6: [641be20110cdfb6d921605adb42a764a0fccac54]

CVE-2026-98911: dpaa2-switch: fix the error path in dpaa2_switch_rx()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98911

According to the .vulnerable file, this bug was introduced by commit
613c0a5 in v5.13-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [74c1c9f5c0c30bbd0c2cf87b6e3507e7ea46c13d]
stable/5.15: [791068c962469af0090e1a1ee63657fb9eef40db]
stable/6.1: [ee54f8d7e642c44cfcc2dcb390b4c50e145d81b8]
stable/6.12: [f4ceb8e3d6d5becb4cda7a7098a8638e18c835a1]
stable/6.18: [fa232b4496cb59503ae5108c756cbe10e59b0bc3]
stable/6.6: [259ad6093204b999d41e7e6d0ad90ef9a71a44ab]

CVE-2026-98912: ALSA: seq: oss: Reject reads that cannot fit the next event

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98912

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [611f538253d970f4d152003841544e875828d015]
stable/5.10: [b3b4b647313757a275be7f7f9d0415d0a90acf73]
stable/5.15: [591226398c1f93bd994678237ff0be229b19d3bb]
stable/6.1: [372bec8a01e2ab8eaa6851bdc346ede5f82dba99]
stable/6.12: [7483fd5f6990f43cc266e94b3f50ce84856ebb97]
stable/6.18: [20b8520d1ef996173065f7abdde47b99136c0785]
stable/6.6: [2922cf2583e590f51bed613a6fcd27b9aea83674]

CVE-2026-98913: net: thunderx: fix PTP device ref leak in nicvf_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98913

According to the .vulnerable file, this bug was introduced by commit
4a87550 in v4.16-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2bcf59eefb9f00a2b1d426b639ee49c305a80695]
stable/6.1: [3a2eedb172e777f2c8608395eec42250fb355dae]
stable/6.12: [df3d586ecc580623edadec71a6ffdf4c79e2a8e8]
stable/6.18: [916d74343cd60ef7c3d433bd417d26ba31642c09]
stable/6.6: [c8bc44a1d86d5b432ec7f5a6f30b4e719a047374]

CVE-2026-98914: drm/amdgpu: cap ATOM command table nesting depth

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98914

According to the .vulnerable file, this bug was introduced by commit
a2e73f5 in v4.2-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [27ef1795bc4e47cae838e0a3ced531c549f9b23d]
stable/6.18: [b1d2b29d3115b36efba0976cb5ca3d794c58eead]

CVE-2026-98915: media: video-i2c: use vb2_video_unregister_device on
driver removal

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98915

According to the .vulnerable file, this bug was introduced by commit
5cebaac in v4.18-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [56384b486b80ce4a2bc93689aae49995f908f90d]
stable/6.1: [97adc8cd04df2085f7fd437838005f3bb16bafae]
stable/6.12: [b8fba9f66019d4c83235c4219ff8edeb7e3af20d]
stable/6.18: [82e432c9ebfa13fb8d47d6d550be5d7d2a84a8ab]
stable/6.6: [b7afb0c24a761c2367e5fa87a9941d67d373c127]

CVE-2026-98916: wifi: nl80211: check link is beaconing for color change

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98916

According to the .vulnerable file, this bug was introduced by commit
b4b9f0a in v5.16-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [55308cee9c2196f39cd1ce8ee6c1fed9e12a00d4]
stable/6.12: [dc4713539da73d2d2c03d064b22b0e6ab38bd361]
stable/6.18: [e50965c702cfd41eb83464565f6272d4d4bfc00c]
stable/6.6: [51423d370739aa3f701fdfbfcc52ecf321dfd71a]

CVE-2026-98917: parisc: Increase kernel stack size to 32kb

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98917

According to the .vulnerable file, this bug was introduced by commit
da57c54 in v4.15-rc5.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [94b7e3a7e871ae27d4935c76959dfc61829f27f9]
stable/6.18: [5023c70853ad9829c53d8e9def5ee969b4e1b931]
stable/7.2: [db45f02b7a5f753efc9003f616dfb5ee4cb6d077]

CVE-2026-98918: mm/damon/ops-common: use a page-aligned address in
damon_ptep_mkold()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98918

Introduced by commit 6f0e114 ("arm64: mm: support batch clearing of
the young flag for large folios") in v7.0-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f166586f74dd5d9cbadaabf86ef81c8ddf6cafa7]
stable/7.2: [d5208de0799c506d3315b6f96d034c38e4509dbb]

CVE-2026-98919: drm/xe: harden adjust_idledly() against divide-by-zero
and overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98919

Introduced by commit d2de441 ("drm/xe: Apply Wa_16023105232") in v6.15-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [90f467577ebc28c5bc4ba2f0f1b83a4419fb0740]
stable/6.18: [2bcbfc5e7bfa9cc76818c54db698da5bdc13d9ff]
stable/7.2: [531d4cd03118224022dc21ae25af052ce2a9e267]

CVE-2026-98920: netfs: Fix missing alloc tagging of direct mempool allocations

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98920

Introduced by commit 1d78d56 ("netfs: Fix folio_queue ENOMEM in
writeback by adding a mempool") in v7.2-rc6.
Fixed in v7.3-rc5.

Bug introduced commit was backported to following branches.
stable/6.12 stable/6.18

Fixed status
mainline: [b78b728e21c32ec4c330b299f657fb1eb02dffc2]
stable/6.18: [5c03da745171485fd181f17b69213464f6d05f3d]
stable/7.2: [37a2042748bc880df03ff8315db86ed82991fbb8]

CVE-2026-98921: ovl: fix UAF in ovl_do_mkdir() debug print

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98921

Introduced by commit fe497f0 ("VFS: change vfs_mkdir() to unlock on
failure.") in v6.19-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ae146bc1abdeb4607abf2975b858c053024e8ac1]
stable/7.2: [719bd33ab359c539a68a278c15a97deb77565cdb]

CVE-2026-98922: net: emac: move setting of netops to fix crash

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98922

Introduced by commit ded86da ("net: ethtool: relax
ethnl_req_get_phydev() locking assertion") in v7.2-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7c9f391ec89cb621d7af375ace2eb9a6248e5b9d]
stable/7.2: [c664cca8f622e66bea6a94279ae2611f1d1c0c67]

CVE-2026-98923: arm64: io: Reject non-user protection in ioremap_prot()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98923

Introduced by commit 8f09803 ("arm64: io: Extract user memory type in
ioremap_prot()") in v7.0-rc2.
Fixed in v7.3-rc5.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [bb756b11ad63832ebee58caf9e8f9381eaecff9f]
stable/6.12: [0b04af3d88bb7fc69b2d92457890608860e42365]
stable/6.18: [b17aa4955e3a694c663ebe99626e4c76ca4f7cfb]
stable/6.6: [fddc90d4af4550af410f52d11bbf6b5f36443838]
stable/7.2: [9b583795feb51f8d50203228d001760d1344ef01]

CVE-2026-98924: fs: avoid repeated scans in evict_inodes()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98924

Introduced by commit ac05fbb ("inode: don't softlockup when evicting
inodes") in v4.3-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7459c021874246c196f397686e100702f059b9e7]
stable/6.18: [e4f3e476cd4066a815ef68cd6caa1828b9c167d5]
stable/7.2: [3cdc6e12ff79f0f8a3ba62d7e61474ae4b5e119a]

CVE-2026-98925: bpf, sockmap: Fix self-redirect copied_seq double-counting

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98925

Introduced by commit e5c6de5 ("bpf, sockmap: Incorrectly handling
copied_seq") in v6.4-rc4.
Fixed in v7.3-rc5.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [490a83d6386eec1d29f470c8d7331677fb46c3b7]
stable/6.1: [cf9aefb26a071cb8b6fdd761c27e022a1184946d]
stable/6.12: [ef6f2182fee6b9721c005ccfc6aec0a47f79bbfa]
stable/6.18: [ae1ffd04e98beefbe5d83335d506b0bcd5c2a6b3]
stable/6.6: [dc98def81e3c629e25fcdd5753b1db93aab27ce9]
stable/7.2: [88942054191185c6f8bea5568cbb5614d1e99af9]

CVE-2026-98926: drm/amd/display: Remove sink usage from DPMS

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98926

According to the .vulnerable file, this bug was introduced by commit
052fa7e in v5.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8fa813b7fd1eccbed13e126166cf764f1f11a7d3]
stable/7.2: [0b1eebd359685dd681f6e0df5540a5bb985a27bf]

CVE-2026-98927: KVM: arm64: nv: Fix life cycle of the nested_mmus array

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98927

Introduced by commit 4f128f8 ("KVM: arm64: nv: Support multiple nested
Stage-2 mmu structures") in v6.11-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [33346f8960c7bb6a3b4e273b5cfe25c5a8be349f]
stable/6.12: [ea242bdc29e8a8ff0e2447a64b3841114779f3af]
stable/6.18: [81e3f065a6485626f816d791dfd5e00ddd12eff5]
stable/7.2: [512c93f4461b9a3735987f48423d438a9cd49e6a]

CVE-2026-98928: KVM: arm64: Derive GUEST_HAS_SVE from the SVE feature bit at EL2

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98928

Introduced by commit 41d6028 ("KVM: arm64: Convert the SVE guest vcpu
flag to a vm flag") in v6.14-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4f16c5fc8dc4c5596e3777ab9f449a54e3f85fd5]
stable/6.18: [4efda204087145d40a84344edec7e9d3885ad3ab]
stable/7.2: [7b5e99d286747b6b5b583b8efcd06bdbdd94b229]

CVE-2026-98929: macsec: initialize SecY before registering the netdevice

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98929

Introduced by commit c09440f ("macsec: introduce IEEE 802.1AE driver")
in v4.6-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c2de369c5c5b8599ca10fd5ca8d11fcd845c1331]
stable/6.18: [2b42adf3b8ee9a0e1d2629aca3c5a02a1c438066]
stable/7.2: [b07bea42bf590edb0fd507ab25622a74af09548b]

CVE-2026-98930: KVM: s390: Fix IRQ injection with SIGP Stop and Store Status

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98930

Introduced by commit 6cddd43 ("KVM: s390: handle stop irqs without
action_bits") in v4.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d343407b728a80b74be3c24b59f15e60289ea527]
stable/6.12: [3bd77c59576b1d447fd56cc689ae9523a334b924]
stable/6.18: [a379ac504fcb8c6fc2aa36203f5489b9581eb2e0]
stable/7.2: [d0e3bf633f0585a0c2c2105ea7723777d764fae5]

CVE-2026-98931: mtd: spinand: fix NULL pointer dereference with no ECC engine

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98931

Introduced by commit f9d7c72 ("mtd: spinand: Create direct mapping
descriptors for ECC operations") in v5.18-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b890e6163761ddb580cc74f43e15f8bbde15647e]
stable/6.12: [3c765fd5212c1bbc71568b1518a7ec963a7040b4]
stable/6.18: [80e8b0ea73ba295e92dfb6cf1c41df9da64234c6]
stable/6.6: [77c449c9c946fc420008dc55cd30f53749c915e4]
stable/7.2: [fc2f651f520394893b14b75281a01e502bfa73bb]

CVE-2026-98932: EDAC/altera: Fix use-after-free in error paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98932

Introduced by commit 9110498 ("EDAC, altera: Add Arria10 SD-MMC EDAC
support") in v4.9-rc1.
Introduced by commit 588cb03 ("EDAC, altera: Add Arria10 L2 Cache ECC
handling") in v4.7-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eef3b67f9c6782127163b631c9043011a68016e2]
stable/6.18: [865f3bdebbc9b34012358c377c9b15154f95f33b]
stable/7.2: [87364b19b3fe4e6dbf88d6acf6db4ec87e7dfbba]

CVE-2026-98933: usb: hub: use shorter 120ms post resume hold for SS root hubs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98933

Introduced by commit 8f5b7e2 ("usb: hub: fix detection of high tier
USB3 devices behind suspended hubs") in v6.16-rc5.
Fixed in v7.3-rc6.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [29480b05e6e226594dc11ccf2a036fbd5cdd0e42]
stable/6.12: [2dc82d6a12050c2c678a328cd29837beb367df7d]
stable/6.18: [e9545dd8bc62596b2a20966be41f39879ea7c8d0]
stable/6.6: [e4df763ba3c4fdd1d9256f7a75a17ab7c5e31db6]
stable/7.2: [d7c4a49b41583266e1456d40f37966029f61dab9]

CVE-2026-98934: ipv6: sr: use skb_get_hash_net() in seg6_make_flowlabel()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98934

Introduced by commit d58e468 ("flow_dissector: implements flow
dissector BPF hook") in v4.20-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8ec454dcd00ce3375119111c6394964455b36d0d]
stable/6.12: [8fe3d6717f5536793727e60b7a0b7ec20c697def]
stable/6.18: [53b21bc2df6e8ed538bceda93a5104a5fe6a8a84]
stable/6.6: [4ab37e4f4a33c64d9e565dc8c4c3ed774f05c0e3]
stable/7.2: [086e8acb3a0e55f6d22d29fae2a4a3b1561bb766]

CVE-2026-98935: rtc: dev: zero-initialize struct rtc_wkalrm to prevent
information leak

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98935

Introduced by commit 36e14f5 ("rtc: rename core files") in v5.0-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0ee5c5d804d592a8328a425b9274487d393d3a05]
stable/6.12: [beda3c9730ad3087d01aa1d0415c40942042ec87]
stable/6.18: [00dc50cede96738dadc64b20e671186cddb8a58d]
stable/6.6: [a2215eb3cbbd3d9d73cc18c08e3ef53f903443cb]
stable/7.2: [2838d7bbb551861c25187dfb581ed6e7a56762e9]

CVE-2026-98936: wifi: ath11k: reset ar->num_stations on hardware start

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98936

Introduced by commit d5c6515 ("ath11k: driver for Qualcomm IEEE
802.11ax devices") in v5.6-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7e0ad05ebc72fffba2bdf2400400902d94ed7272]
stable/6.12: [c3ac51701e925e8d50479ae2fddca51a09f636e8]
stable/6.18: [9a9467f7cc633b31e4c34a2c56aa095e0c3fa853]
stable/6.6: [60142eb2afda34508e640a3ff2a54c90e51525cc]
stable/7.2: [c27779d3679c695674747744390f97a5424a0dc8]

CVE-2026-98937: perf/core: Check kernel access when kernel callchains
are requested

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98937

According to the .vulnerable file, this bug was introduced by commit
0764771 in v2.6.31-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a4573a3838ae4fc73b70019cfa1dac9aaea7cc2f]
stable/6.12: [132bee76097be421ab3012130b5b506324cf2be1]
stable/6.18: [2581b43e162cfc43e6f5d8dd8d2b38f3441550de]
stable/7.2: [6e187281f978a2bff98ead6aa40f8ddc9a2c9afb]

CVE-2026-98938: rust: irq: pass RegistrationInner as cookie to request_irq

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98938

Introduced commit is not determined.
This bug is assinged to stable 7.2.
Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [98c63ce4d7606b2362d8702f159b07f77f75547e]
stable/7.2: [9a7931e847f338a687e96cde9f37e0cff83ddd84]

CVE-2026-98939: x86/mm: Drop unnecessary PMD page copy when freeing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98939

Introduced by commit d5d8b86 ("x86/mm/pat: Acquire init_mm read lock
on attribute changes to avoid UAF") in v7.3-rc4.
Fixed in v7.3-rc6.

Bug introduced commit was backported to following branches.
stable/6.18 stable/7.2

Fixed status
mainline: [e3ee38c1bc0b11a8d3e63dce7050759b61864286]
stable/6.18: [d3c2d2692bdf4af94bb27bc7a3aa0a348a567606]
stable/7.2: [f38c57a28ebbd057471573e39555d5aa11ab03cf]

CVE-2026-98940: ASoC: qcom: lpass-cpu: use DAI table index for
playback constraints

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98940

Introduced by commit c223f41 ("ASoC: qcom: Add four speaker support on
MI2S secondary") in v5.14-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ca51771c8efde5df05476ac98dd1b2af4e2b149f]
stable/6.12: [6833f1893ac2ec40016c348779af63debf3700d2]
stable/6.18: [69d2b7a4c115181629eb14d800aecc3e7de3f7fb]
stable/6.6: [775df6a27e8433e2414124472938009b958f9a77]
stable/7.2: [f11336e6d3cd9e28e5cdf1cb8a6171e7c3eff4e4]

CVE-2026-98941: ext4: don't enable large folios on encrypted inodes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98941

Introduced commit is not determined.


Fixed status
mainline: [40554d1221e3d2ff2e0d192b74a05d89eb3620e7]
stable/7.2: [40554d1221e3d2ff2e0d192b74a05d89eb3620e7]

CVE-2026-98942: sched_ext: Build the cid tables privately and publish
them with RCU

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98942

According to the .vulnerable file, this bug was introduced by commit
e9b55af in v7.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3a773220d39ba993dfe5d135f8b610be10794d5d]
stable/7.2: [0e1a74369bdbc357d3d9713734418d914a981553]

CVE-2026-98943: [REJECTED]: HID: steam: Clean up locking

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98943

This CVE was rejected. Introduced commit is not determined.Fixed in v7.3-rc1.


Fixed status
mainline: [de1d341b9b3ec9655f31fb8b44f784cca5e670ad]
stable/6.12: [6bce4b221dc0e144180c333123dbb82d1dc3a500]
stable/6.18: [d1e095c75d12799a1cd855a399f88c89147c1eca]
stable/6.6: [cbf9961602ffb34d6902bbe9a247c54e13361265]
stable/7.2: [6c714d6691515fa3d38eb770b484a0046593ccc9]

CVE-2026-98944: HID: steam: Refactor registration

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98944

According to the .vulnerable file, this bug was introduced by commit
385a488 in v4.20-rc4.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [6f9b740c31ba7e061b2ebb330d9a3d63f1358f29]
stable/6.12: [2b15e10aff95c78dbacc4fa32fa90c9098213e03]
stable/6.18: [cf71a6ee1d4e36b8e65b81c064e2797a10247280]
stable/6.6: [3c2f97343d4df2a75747f4c79effa0587509888f]
stable/7.2: [c06cf54fe99b8c6bcf2017bb076c0e3918608cea]

CVE-2026-98945: HID: steam: Rearrange teardown sequence

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98945

According to the .vulnerable file, this bug was introduced by commit
9cd61c8 in v6.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ddce9641ce924ed91ec8304577e463823a29ffaf]
stable/6.12: [81a8209c09f9be7eef860ca6cc154749a6b4d243]
stable/6.18: [86724f4bcf6049c3a322f7a7b1f968210059c46a]
stable/6.6: [d2587923d50c8b141ce0ccb284c714cf6054d6a7]
stable/7.2: [b5ea938ff776306798d3a11485c2475034f92131]

CVE-2026-98946: drm/vc4: Disable the V3D interrupt across runtime suspend

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98946

Introduced by commit 9b6f461 ("drm/vc4: v3d: Stop disabling
interrupts") in v6.1-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6abc8e4dcfbc1d26a94c0ac037dfb3716f686b1f]
stable/7.2: [e81402c3d42041356cb7978510ebab997bc8d411]

CVE-2026-98947: vsock: Fix memory leak in vmci_transport_recv_dgram_cb()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98947

Introduced by commit d021c34 ("VSOCK: Introduce VM Sockets") in v3.9-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7c24a4e87e219072e5e106f6791146cbf3b056b3]
stable/6.12: [0f8e2b2045355a0ee2008125e573435504b13cee]
stable/6.18: [4835dbcde5cc3ae37e0d0796052056b35fcae8bf]
stable/7.2: [9907db2b8e7ba70b442bb9dec86526a6511fac62]

CVE-2026-98948: mlxsw: spectrum_flower: Fix port range register leak
in tmplt_create()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98948

Introduced by commit fe22f74 ("mlxsw: spectrum_flower: Add ability to
match on port ranges") in v6.6-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7ea07afb230f1342ab0f9365edd0aae137f425d3]
stable/6.12: [c8e934287debb29c6ded86b21e49fc72e186d15e]
stable/6.18: [3938430f0237c59ca08d6a366e7657b2b7f8d0bb]
stable/6.6: [41ad5bcf0219aaebf8ffb052c5e8177479330cde]
stable/7.2: [4eaf1285b5c1e42f80e47f9fe0d391e70418db02]

CVE-2026-98949: drm/imagination: Fix reference and vm_bo handling in remap()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98949

Introduced by commit ff5f643 ("drm/imagination: Add GEM and VM related
code") in v6.8-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [196d4d10c1b33ae176685ff42a9994a5952b1d0f]
stable/6.12: [521cf8403a185a9d5790fe324bb43ba7ea85f51c]
stable/6.18: [9caa2eca5cc8372517ff36a83f321d4326abae93]
stable/7.2: [784356aa88b82035d70e9faeded49b70cddeb29e]

CVE-2026-98950: flow_dissector: avoid u16 truncation of hlen in
bpf_flow_dissect()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98950

Introduced by commit d58e468 ("flow_dissector: implements flow
dissector BPF hook") in v4.20-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f202578efc738b883cfa04889eb97328914265a7]
stable/6.12: [3fb5ad2951a6df92c98f4f06cd70f20c50a2eb2a]
stable/6.18: [cc18eb0e9941162c03f03f411ed7f6c339d91fa0]
stable/6.6: [c44c02c930c6583b235a1937c69ff716c4bb4514]
stable/7.2: [61b43a51a55929ec040bee3ea51af2121b956d05]

CVE-2026-98951: riscv: ptrace: Zero-initialize regset buffers before copyin

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98951

Introduced by commit 9300f00 ("RISC-V: Add ptrace support for
vectors") in v6.6-rc1.
Introduced by commit 2af7c9c ("riscv/ptrace: expose riscv CFI status
and state via ptrace and in core files") in v7.0-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [59052a88ba5fe4a7bb34b3a0a42aa5d453d3bb97]
stable/7.2: [89fc70d73f4ac8781f9e15edd1dbc6b6088453b3]

CVE-2026-98952: pfcp: make sure the SEID is linear before reading it

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98952

Introduced by commit 6dd514f ("pfcp: always set pfcp metadata") in v6.10-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [23609bce9e1de525d1d0e73fc68c6e7971d0b49e]
stable/6.12: [3192a5e398c64d48aad64a09e29643e327369bc4]
stable/6.18: [b18a6496495495e2dc27e525aa3315a0c59b9513]
stable/7.2: [2fb6d05f706d79bbdc88835be2f4f45ab56dd819]

CVE-2026-98953: devlink: fix devlink_rel reference leak when notify
work is pending

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98953

Introduced by commit c137743 ("devlink: introduce object and nested
devlink relationship infra") in v6.7-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c5381ae1cd1481cc431c2bd79460472c6f1d3ce3]
stable/6.12: [8c7830e0120e6e1f5084212fd5b79b3092496f87]
stable/6.18: [8de57bfec3825effb57fe4d25da98ec3b8fda4c6]
stable/7.2: [dc2e787b5fb474241c8a6d18fdacb44adc6d571f]

CVE-2026-98954: net: always dissect GSO packets in __virtio_net_hdr_to_skb()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98954

Introduced by commit 9e8db59 ("net: avoid false positives in untrusted
gso validation") in v5.0-rc8.
Introduced by commit d5be7f6 ("net: validate untrusted gso packets
without csum offload") in v5.0-rc8.
Introduced by commit 924a9bc ("net: check if protocol extracted by
virtio_net_hdr_set_proto is correct") in v5.12-rc3.
Fixed in v7.3-rc7.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [44378d02c5aaae24b60a75fbbb539b4aa4db503d]
stable/7.2: [5f4dfdf0077730e9d3ef5b37ceb17a5a56d6f34c]

CVE-2026-98955: flow_dissector: avoid u16 truncation of skb->len when
computing thoff

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98955

Introduced by commit d0c081b ("flow_dissector: properly cap thoff
field") in v4.15-rc9.
Fixed in v7.3-rc7.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [99bda1ecbd56905f8bd934b9cdccd3bd251192b1]
stable/6.12: [50d0cd575cab763f833d6ac6eb6550b23a0b3dae]
stable/6.18: [9993e6a0ac1b5b3101ffba702cacb9f42b9909d8]
stable/6.6: [d9e08836d06c84abb18470c94b12b131eaccdc7d]
stable/7.2: [52efce4755a4b8b82039caa773645ffc80b25362]

CVE-2026-98956: ASoC: adau1372: allow sleepy powerdown GPIOs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98956

Introduced by commit 6cd4c64 ("ASoC: Add ADAU1372 audio CODEC
support") in v5.11-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [64dd172bbffe6135d79a06ddad53dd2da4d8bd62]
stable/6.12: [6cf4c3c9b7a4df0fe4cc67481b7b251cff781b29]
stable/6.18: [47c0c7a051b70d396774d5dc27b23283c28c3555]
stable/6.6: [58905982b0d912021325f5de84facae86cc0f2f2]
stable/7.2: [65cd0e21746b812d311e9fac6d473dd62f0ad52a]

CVE-2026-98957: wifi: mt76: mt7915: disable rx napi when removing device

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98957

Introduced by commit e57b790 ("mt76: add mac80211 driver for MT7915
PCIe-based chipsets") in v5.8-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [916c484d29d82f45c281da2786fcd6a1284430ce]
stable/6.12: [0281dac1e213329b053fb02e612de7f1477a52d7]
stable/6.18: [0f9afe238eeb79829f0f92f376ba3a20781caccd]
stable/7.2: [7199ee4b47de0b61fa6455a1587c5ab645ebe262]

CVE-2026-98958: wifi: mt76: account non-AQL frames per peer rather than per link

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98958

Introduced by commit 86c051f ("wifi: mt76: mt7925: enabling MLO when
the firmware supports it") in v6.11-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [752770d7a58c821c17909c3ca67f9f14ab146a40]
stable/6.18: [9f28f504650869d41f7b3e98e4bc4547af4d5670]
stable/7.2: [e0f2ae4a7539454ec50c353571779fcda8c0cfcf]

CVE-2026-98959: btrfs: fix xattr replace when multiple xattrs are
packed in the same item

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98959

Introduced by commit 5f5bc6b ("Btrfs: make xattr replace operations
atomic") in v3.19-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [858bee1c77857aabcc2327cd32dd8266332de332]
stable/6.12: [5877d7138cc4359d26fd7b010eedfd1b3162348f]
stable/6.18: [a97114b9b00ed3d05156f3b2ddbf797296260389]
stable/6.6: [7a53bb4668b319fc6c8a3ce2c21635125c7d2712]
stable/7.2: [c1803697a60f22743aa28ad522f805e92d45e3f0]

CVE-2026-98960: btrfs: don't stash io_uring encoded data across -EAGAIN

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98960

Introduced by commit 34310c4 ("btrfs: add io_uring command for encoded
reads (ENCODED_READ ioctl)") in v6.13-rc1.
Introduced by commit e32dcdb ("btrfs: add io_uring interface for
encoded writes") in v6.14-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [51562a8cb11628d3a5e105b4c347ec5473e5745f]
stable/7.2: [4d9c1e0a7fb2cfb1cc924acafc194d2c15c3e83e]

CVE-2026-98961: btrfs: unlock inode and extent in caller when io_uring
read extent fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98961

Introduced by commit 34310c4 ("btrfs: add io_uring command for encoded
reads (ENCODED_READ ioctl)") in v6.13-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b6e8add5d79d1f6f819a054c833bab452bd7365d]
stable/6.18: [2797eb38773a96914ccedeec71eb2144645400b2]
stable/7.2: [ada1fc725a4db407294ae90a0d40ef1c46f457f2]

CVE-2026-98962: btrfs: free iov when btrfs_uring_read_extent() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98962

Introduced by commit 34310c4 ("btrfs: add io_uring command for encoded
reads (ENCODED_READ ioctl)") in v6.13-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a8ea92830b3e0e163d4e829bdcb17ca83c0f951c]
stable/6.18: [7a3addbdc5ad1fd80541a6a4ff4e06cd1331530a]
stable/7.2: [578ef517142420cf9d36b364ad4b3490b85469fb]

CVE-2026-98963: btrfs: always return -EIOCBQUEUED after
btrfs_uring_read_extent_endio

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98963

Introduced by commit 34310c4 ("btrfs: add io_uring command for encoded
reads (ENCODED_READ ioctl)") in v6.13-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [80a8dbb30d2b00b9c671b02bd73f700f6d20100f]
stable/6.18: [033dda5b321f01661de518a8d5c8607ae8675b14]
stable/7.2: [a449433b0e3d4a3715d0bbee078f8c603f03c9f6]

CVE-2026-98964: nvmet: use the local P2P device on metadata allocation failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98964

Introduced by commit bcd9a07 ("nvmet: fix freeing unallocated p2pmem")
in v5.13-rc5.
Fixed in v7.3-rc7.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [4aa9c0f377a4de5e8fddce76b34ee4529639a1ff]
stable/6.12: [32f21607911a1f69c8f0f93a6c28fe6f8490aa98]
stable/6.18: [ce79a6c5cc1b8054ec8d3eba16adda4a36113438]
stable/6.6: [3c231142c4f4bb96836469eb276026ec55940093]
stable/7.2: [73bf0f9579633b531098a475e6e55c9316763aed]

CVE-2026-98965: ice: Restore Ordered MMIO Writes for Tx Doorbells

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98965

Introduced by commit ccde82e ("ice: add E830 Earliest TxTime First
Offload support") in v6.18-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7a579dec8423bba7bec96fcfcb2e30838b0858ee]
stable/6.18: [b7725acf9c574debb97ae1613569ac9e148438be]
stable/7.2: [f94ab1fffd009250d72c6dc1662cb84467ac5365]

CVE-2026-98966: bonding: fix the program leak when XDP is replaced

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98966

Introduced by commit 9e2ee5c ("net, bonding: Add XDP support to the
bonding driver") in v5.15-rc1.
Introduced by commit 6d5f1ef ("bonding: Fix negative jump label count
on nested bonding") in v5.15-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [184b5ddf82d45d6f75cc83719a2e453392512bd2]
stable/7.2: [bba6b1b086f9f4ddbfdaba7ea6279dc3abec70c7]

CVE-2026-98967: cxgb4/ch_ktls: disable softirqs around tid_list erases

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98967

Introduced by commit 65e302a ("cxgb4/ch_ktls: Clear resources when pf4
device is removed") in v5.13-rc4.
Fixed in v7.3-rc7.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [4c9dc0faca98084922caeb689579d338cf3e1c29]
stable/6.12: [bcf97573d44e277b1744d7f1226f665aa0ccc599]
stable/6.18: [7110c7f70c59eb7924e79853bcc00e2a026662e6]
stable/6.6: [8739f06e3f82cd715f7dd10ab24029ed881efc90]
stable/7.2: [bea736a2b8c6da5b1078badf1206541b5404250f]

CVE-2026-98968: amt: send the relay's General Query directly from the
receive path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98968

Introduced by commit cbc21dc ("amt: add data plane of amt interface")
in v5.16-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [afae89de73dd693cfa329580ba0fba63bd3f0a11]
stable/6.12: [e7183b7d518ce8b3e1f7284f9881d7a87569df14]
stable/6.18: [181cb48c1e9af6b402567e132f879f89d1c54131]
stable/6.6: [95114e421196250e3d9662f12df442799477d3c3]
stable/7.2: [e7ea63b4195a150604993044ab574d8240f2a399]

CVE-2026-98969: net/sched: em_text: reject unterminated algo before autoload

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98969

Introduced by commit d675c98 ("[PKT_SCHED]: Packet classification
based on textsearch (ematch)") in v2.6.13-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c9728fcf2e7fb4a7a8d08ebd9524c3b02ae1a021]
stable/6.12: [22182f91c6703af6e9832cffe6d22b381031cb5a]
stable/6.18: [85e5512369d4fe6e5f2c43712d9f9e01d4ae8437]
stable/6.6: [00bcc303000bac524d62eed054d77372b38ace0f]
stable/7.2: [b627c6ba20be20334338229b4820baacb9d96826]

CVE-2026-98970: drm/vc4: Free the BO cache size list on teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98970

Introduced by commit c826a6e ("drm/vc4: Add a BO cache.") in v4.5-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b41ff8b529278216cba22a5dcdc93fea2a3a9619]
stable/6.12: [035ad1bc964f6698e9b06c26ffe94bcac08dadea]
stable/6.18: [bea10b84e22efa22b005e8dba1a19df4e04a7649]
stable/6.6: [bf2848e50bd73782c2942ec023b5b60231f16e9b]
stable/7.2: [40870a0290cd913c9d94f98ed87ebe00dd091e53]

CVE-2026-98971: gpio: exar: initialize the ID before registering its cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98971

Introduced by commit 5300ebb ("gpio: exar: use devm action for freeing
the IDA and drop remove()") in v5.11-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4d69e74034b208588636ecc177e0dd43a7696af3]
stable/6.12: [b78c114600ae3df90c083c72c290437b068577c8]
stable/6.18: [01318927a9055136c207399eeb36ce07becac179]
stable/6.6: [bf3d841ef12fcbec4458e2750956b738b043a226]
stable/7.2: [f7ec4dbd2a073dd53b6349be1c586fe8580dd6b2]

CVE-2026-98972: cgroup/cpuset: Don't access cpuset_cgrp_subsys.root in
is_in_v2_mode()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98972

Introduced by commit b8d1b8e ("cpuset: Allow v2 behavior in v1
cgroup") in v4.14-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e06b678e3b4e12fdaa0b51a7a5a54abc5dbd6469]
stable/7.2: [988bf67a13890a37a33201f95947095ca9bec856]

CVE-2026-98973: drm/bridge: Fix unlocked list_del in drm_bridge_add()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98973

Introduced by commit 17805a1 ("drm/bridge: add list of removed
refcounted bridges") in v6.19-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b62e3db8cdc1680e1c3390591e872f485148541a]
stable/7.2: [f469d850854101eae60dd4080244f114a9bcf2b5]

CVE-2026-98974: xfs: fix exchange-range-to-eof file size exchange

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98974

Introduced by commit 966ceaf ("xfs: create deferred log items for file
mapping exchanges") in v6.10-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7dfb218c829c1acb626e0fe92c5fddb9a26a03e9]
stable/6.12: [b361d32b884f8ddcb9bad5d99b69eece648f8e43]
stable/6.18: [cf32eb20dfacfd2e92ce86ba1fece9ae5f98a7d8]
stable/7.2: [952b5c99a840c2bff1f6645fd5e06e1db6ec2623]

CVE-2026-98975: xfs: stop exchanging reflink flags when exchanging mappings

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98975

Introduced by commit 966ceaf ("xfs: create deferred log items for file
mapping exchanges") in v6.10-rc1.
Introduced by commit f0bc4d1 ("xfs: swap inode reflink flags when
swapping inode extents") in v4.9-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d84d6c1a7f1e2de9e601703a326a4c1b7b421943]
stable/6.12: [1fa2f3a7ef7ee0f2503a4b0afe24bc8c9d0820be]
stable/6.18: [7d3b9b2c9dc57f93f36c716ab752548cb4db9900]
stable/7.2: [4756c94260e69ce42612b8220c3614f02f7a11d5]

CVE-2026-98976: namespace: keep the lock on a mount that a propagated
copy is moved beneath

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98976

Introduced by commit c62a476 ("move_mount: transfer MNT_LOCKED") in v7.1-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d74d66aa708ccf2bc0b1e265a83fed0f2308d5c4]
stable/7.2: [f1f0c24ca701d7d3061c7f69f7450f1734c11745]

CVE-2026-98977: namespace: handle mount locking for automounts correctly

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98977

Introduced by commit 132c94e ("vfs: Carefully propogate mounts across
user namespaces") in v3.9-rc5.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [33aadc7c72055fca93cb5a3691d836ebf8b31c9b]
stable/6.12: [b3ccde78f1608836e62320428abc0e8aa9cf2329]
stable/6.18: [e01c79761c7b3373e80094c5eadb21cb864fa8bc]
stable/6.6: [5e8f3ac8fa3d411b422ad32b9168c46a4824cc79]
stable/7.2: [6ab37fae14196ba2262b152a7d9222c50356d278]

CVE-2026-98978: namespace: never expire a locked mount

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98978

Introduced by commit 5ff9d8a ("vfs: Lock in place mounts from more
privileged users") in v3.12-rc1.
Introduced by commit c62a476 ("move_mount: transfer MNT_LOCKED") in v7.1-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f78ddcc872248c7aa1d7e904928441a0be4c6d5d]
stable/6.18: [6b8dc3713a76346d212abab46cbfc8d7070f534c]
stable/7.2: [d23265a12e4991ce7aedce670c0b6b598cadb644]

CVE-2026-98979: namespace: refuse an automount below a mount that is
in no namespace

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98979

Introduced by commit df820f8 ("ovl: make private mounts longterm") in v5.8-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ba985ce08471c555af2a2fbe217c1bc2e72a6d8c]
stable/6.12: [35f2013f83ef16f9f0331c4c3a8e8d161580d574]
stable/6.18: [494c57572d2d5bc2839553ed41aabe92ed0f587c]
stable/6.6: [95fb7c259b86f5521f04973040ad492f2bef6f82]
stable/7.2: [776e20e4fdc23c23687b511ffdc80047878049d3]

CVE-2026-98980: namei: don't reveal overmounted entries in refwalk

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98980

Introduced by commit 8ed936b ("vfs: Lazily remove mounts on unlinked
files and directories.") in v3.18-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8189ab688f5a2c745dc90b63374da02f213d6994]
stable/6.12: [e2b10181d913b4efa3a8dc67a532f859aa5f95e0]
stable/6.18: [5f97df8ca7fadf5b53954f50073445ba193902c0]
stable/7.2: [b43ff2deef48260bfbdc0dcb520f7929bd3e4007]

CVE-2026-98981: namespace: unhash a dentry before detaching the mounts on it

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98981

Introduced by commit 8ed936b ("vfs: Lazily remove mounts on unlinked
files and directories.") in v3.18-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [528b383dc35d1e5caf64ddf5d35f983ae543b0d0]
stable/6.12: [8d71bfc9b3fc15d7103e82ea9dc5057541866e46]
stable/6.18: [d29cd99db3db74cf3447be74d25740981789d461]
stable/6.6: [db90eecbde319527aa9480c039d32a0f5fe80574]
stable/7.2: [8300de4aa5d09061bfcf2af5b52c0cdba3873185]

CVE-2026-98982: namespace: don't let a pseudo dentry become the root of a mount

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98982

Introduced by commit 35f96de ("bpf: Introduce BPF token object") in v6.9-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b138e16fb1e81376cea89f727dda7bfccd140de4]
stable/6.12: [a256e31e0c54c4c37d2523aa52faabdcdd2ebc07]
stable/6.18: [7e1c466011ba9e64d43075396badc03191bcee44]
stable/7.2: [00287afa7cd989efdbf5822b7efac33cce7d489a]

CVE-2026-98983: unshare: don't drop active namespace references that
were never taken

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98983

Introduced by commit a98621a ("unshare: fix nsproxy leak in
ksys_unshare() on set_cred_ucounts() failure") in v7.1-rc1.
Fixed in v7.3-rc7.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/5.15 stable/6.1 stable/6.12
stable/6.18 stable/6.6

Fixed status
mainline: [0b6f31a3c0b16066f812e94b52a704174a6f23cd]
stable/7.2: [56fe03a0c05dba4c5f6a23c391f96de1614a098c]

CVE-2026-98984: dcache: don't put a mountpoint on a dentry that's being removed

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98984

Introduced by commit 1064f87 ("mnt: Tuck mounts under others instead
of creating shadow/side mounts.") in v4.11-rc1.
Fixed in v7.3-rc7.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [75f4197f1e11d2eb75c2d6f916a7d4764db621e5]
stable/6.12: [793cb67b0f52d00c67bd0e76bc57455b5c70ebb8]
stable/6.18: [390ddcea2a8aca411b931a8e2863a80ccca8d2b3]
stable/6.6: [5e6bfd9f249f2c74bb63c0f06ad959da3bee0971]
stable/7.2: [30a1625022411a387cce9239408ece9955bc9c58]

CVE-2026-98985: namespace: check the mounts before reading their
parents in pivot_root()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98985

Introduced by commit e0c9c0a ("mnt: Update detach_mounts to leave
mounts connected") in v4.1-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6b7c001eb5857fa09041f47673666060a2e5fc1c]
stable/6.12: [3c2441e21c3df867e4131e0ff784ecdb3a7a55f8]
stable/6.18: [e3aba6900483f64e6c9eb328150dd633b7d36c1c]
stable/6.6: [a56d4f8f8f4c5d9ac339d5c03a9d90eecd3697fc]
stable/7.2: [3dad2330c89343ba083cf7868779083fd5fbe0fe]

CVE-2026-98986: namespace: remove the fsnotify marks of a mount
namespace in process context

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98986

Introduced by commit bf630c4 ("vfs: add notifications for mount attach
and detach") in v6.15-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1a116222acdcc1bc1a8350727ae6f28907d44594]
stable/6.18: [888363d74c3b5d32e2accf217add70f8b38e0e2b]
stable/7.2: [9e820a6becdd955a04adbedfd767253a47eedd9e]

CVE-2026-98987: namespace: look at the topmost mount for a mount namespace file

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98987

Introduced by commit 96f5d2e ("attach_recursive_mnt(): unify the
mnt_change_mountpoint() logics") in v6.17-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8714b44adac7b10506e1db3ef1710689751f0f10]
stable/6.18: [b9c40553f6ceba50042281eef6f701e5fb719726]
stable/7.2: [87ecd4c6da146363384a603bd9e90c90e7275536]

CVE-2026-98988: namespace: keep covered mounts covered in OPEN_TREE_NAMESPACE

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98988

Introduced by commit 9b8a0ba ("mount: add OPEN_TREE_NAMESPACE") in v7.0-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0febe278ec45b1ccdbe9bd5ff1ba365d8fd55e2a]
stable/7.2: [b8a94a405ddcf45e9470789e0a821d8f2aa4ca10]

CVE-2026-98989: namespace: check a recursive bind mount for mount
namespace loops

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98989

Introduced by commit e149ed2 ("take the targets of /proc/*/ns/*
symlinks to separate fs") in v3.19-rc1.
Introduced by commit ef4144a ("pidfs: allow bind-mounts") in v6.14-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c640a01a78e42302879006ed7b7d5a9a943ba815]
stable/6.18: [a0ba48256f5dff6f75a45f8ce39fe57f21df1022]
stable/7.2: [37a82f400efa4d263542a5fa41755b21057f1e5d]

CVE-2026-98990: namespace: check a submount for references right
before unmounting it

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98990

Introduced by commit 1064f87 ("mnt: Tuck mounts under others instead
of creating shadow/side mounts.") in v4.11-rc1.
Fixed in v7.3-rc7.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [32bf92416614a1e3ff3524fc6b780259c7aad3ef]
stable/6.12: [6e4012e571867868b545c91ca9d6095fdb709907]
stable/6.18: [d73f04e92c1aab78d96ac6cadb234c8a3a373d22]
stable/6.6: [f6394281834492c6516a405a348b545ae698a331]
stable/7.2: [18902a23ef36f83d32bafc58ae2484e6bb4bb8ef]

CVE-2026-98991: namespace: queue a mount only once for mount notifications

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98991

Introduced by commit bf630c4 ("vfs: add notifications for mount attach
and detach") in v6.15-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bd2feb7796b6585938a4241e7b7c4148a6f7b762]
stable/6.18: [acbe9e4418e2ef7bef1a12e62e0e7d6145a15190]
stable/7.2: [702ff3fe499876e09c45558a05366d21a5bc41ab]

CVE-2026-98992: namespace: don't copy an unmounted mount tree

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98992

Introduced by commit e149ed2 ("take the targets of /proc/*/ns/*
symlinks to separate fs") in v3.19-rc1.
Introduced by commit ef4144a ("pidfs: allow bind-mounts") in v6.14-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8bacbf6be959973b28b691713a872c12eae69eec]
stable/6.12: [7e037b1fd339d865737c8accd29abcf40130a5a0]
stable/6.18: [b47b40c4f058418f9707454543179df240796aad]
stable/6.6: [86a2d56b1960720bf1844441c0890621e9db2f25]
stable/7.2: [8d3527457e183cedee3003c2897314da49488311]

CVE-2026-98993: namespace: don't inherit MNT_UMOUNT in clone_mnt()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98993

Introduced by commit 590ce4b ("mnt: Add MNT_UMOUNT flag") in v4.1-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e2c6d326216642011da318b9edfd5d57ebd5a56f]
stable/6.12: [c26c1a91ad2881a194f7af543e0b57f0870006b2]
stable/6.18: [eecc9cd0fc07dba3f7fb0b2f844b4029435a2f7b]
stable/6.6: [99698cfa34e493fc091219056aae446fe9442a96]
stable/7.2: [5077b52e9e4d72da53c50251296b99cd416765a1]

CVE-2026-98994: statmount: read the parent of an unmounted mount under
mount_lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98994

Introduced by commit 0e50322 ("statmount: accept fd as a parameter")
in v7.0-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bb46094057520304073130920c223451c2a694a7]
stable/7.2: [98fc6c7b6ca676157d2c780bd0a537b2c10fe08f]

CVE-2026-98995: namespace: reset the old parent's ->overmount in
mnt_change_mountpoint()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98995

Introduced by commit ffdc52f ("prevent mount hash conflicts") in v6.17-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [476ef286a7a5db8bda51325dc0c45887b4d99d9a]
stable/6.18: [5e0a1f2c753a79749bc2ead3ae2f2ede3941daa5]
stable/7.2: [08d575ee89393fd812dbdca7b5d7b4574cd5a564]

CVE-2026-98996: fs: don't silently unmount busy mounts

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98996

Introduced by commit 99b19d1 ("mnt: In propgate_umount handle visiting
mounts in any order") in v4.13-rc1.
Fixed in v7.3-rc7.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [6857e209015f95be7a8f19a9cd5dac345b9b9859]
stable/6.18: [bf2c8dec26fb792876b5e9bde7030c45d8be3908]
stable/7.2: [a210ac218c307513d43e98a08f23c2dfbeeebc2f]

CVE-2026-98997: drm/amdgpu/userq: only accept doorbell BOs as queue doorbell

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98997

Introduced by commit f09c1e6 ("drm/amdgpu: generate doorbell index for
userqueue") in v6.16-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7f7c88dbf4d543f6703e53bdeed380e886733167]
stable/6.18: [112dbe2b10d6d088a6c599980dd960dcbfa55ff0]
stable/7.2: [8640b3f961d743d6dc0458c2b53a3af434690cc1]

CVE-2026-98998: drm/bridge: th1520-dw-hdmi: Fix remove() callback

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98998

Introduced by commit 96f30ee ("drm/bridge: add a driver for T-Head
TH1520 HDMI controller") in v7.1-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [01c83795d50ccdb441f60e89ff50767cb2f6045a]
stable/7.2: [d7cd43c2f546170ed42b2498d13805f4f89193c1]

CVE-2026-98999: drm/xe: Fix stale pinned_link entry when fb-pin
performs the final unpin

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98999

Introduced by commit 44e6949 ("drm/xe/display: Implement display
support") in v6.8-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cf238c067eaae1cbfb00738e29219b9568d2313e]
stable/6.18: [3a11adcfd9a2de74d405bd3e8c4d7a1b328e4684]
stable/7.2: [b3eaff982839e5c22912d604cd8e7748cece8d63]

CVE-2026-99000: drm/xe: Fix shrinker accounting double-subtraction on
nested external pins

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99000

Introduced by commit 00c8efc ("drm/xe: Add a shrinker for xe bos") in v6.15-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [83d5acca1f4f6132038ea88c72c5844f62e42d44]
stable/6.18: [993c952e6832ad0aa4be82e11f0760b1f532090a]
stable/7.2: [ab39bc55cf08208b8511b1c09926b1b646a8befc]

CVE-2026-99001: drm/xe/i2c: cancel the client work on remove

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99001

Introduced by commit f0e53aa ("drm/xe: Support for I2C attached MCUs")
in v6.17-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [611857adc9e7b0ee1239a0baf38498922ca5a12e]
stable/6.18: [2efa187fd4c9b8d7edcae0c1acf46739ce39fd01]
stable/7.2: [175d654cd48320ad52d0f82dc3f4e3c063c3c5ca]

CVE-2026-99002: drm/vmwgfx: validate pitch coming from userspace

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99002

Introduced by commit 2ac8637 ("vmwgfx: Snoop DMA transfers with
non-covering sizes") in v3.2-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [21bc51cb89ced74d6645a138cc2f21184bc75094]
stable/6.12: [f6d9c8abdf06a9c7efa799532d66ed8d5a50734c]
stable/6.18: [76e5ddd7d9822c8c3492e0f50ba8978e093069ad]
stable/6.6: [db6fbc2b77849e3c3c2bc115ea9ac925c4625a0d]
stable/7.2: [fcb137f6e7ed769f7ecad84364a33c451371b602]

CVE-2026-99003: drm/panthor: validate userspace queue count against
initialized firmware slot count

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99003

Introduced by commit de85488 ("drm/panthor: Add the scheduler logical
block") in v6.10-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ec86c43dcfff68eab4db9bdafcd3e2b16e342e18]
stable/6.12: [4487cf79bf173f2b426a02d102076f8a20d23b96]
stable/6.18: [fdee3570b282a6c8699aea63fa5694355e010ec9]
stable/7.2: [9be126be5f78bc331a930295af97c9b1f9158f06]

CVE-2026-99004: drm/imagination: Size page table preallocation by device address

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99004

Introduced by commit 0a82240 ("drm/imagination: Fix page count for
page table for map() interface") in v7.3-rc5.
Introduced by commit ff5f643 ("drm/imagination: Add GEM and VM related
code") in v6.8-rc1.
Fixed in v7.3-rc7.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18 stable/7.2

Fixed status
mainline: [789f290b2e81d42820bddcb4010ffbc2ae2ded54]
stable/6.12: [51b56bad96fd20127034f660b337c00317c65151]
stable/6.18: [f9b215b3e37a5047c406545de51bf8a2aeb4cd1c]
stable/7.2: [7f73da0facf864fe796371ebaccacb1fee678aaf]

CVE-2026-99005: drm/i915/gt: Unmask interrupts only when ACTIVE is true

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99005

Introduced by commit 3e7abf8 ("drm/i915: Extract GT render power state
management") in v5.5-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5346b1cec6afa4f9b4b49a9f84e3cfef95a3f7bb]
stable/6.12: [60f58da15f8c8e39706c564f9251de3626636dce]
stable/6.18: [0b4a0fb98b9ffeac36798bbd369c821605cae70f]
stable/6.6: [77abc1837c9651c8f43f7f7f336d10093eeb7745]
stable/7.2: [49d349c42cf5ebaa878d02699c632c9d883d935f]

CVE-2026-99006: drm/i915/gem: Prevent overstepping exec array boundary

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99006

Introduced by commit 8e4ba49 ("drm/i915: Parse command buffer earlier
in eb_relocate(slow)") in v5.10-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ebe162db655881a38de43301151ff7ac940602b5]
stable/6.12: [b1c357131fc467c579f65e9a9d1fdc1a6273ae1d]
stable/6.18: [152fb5083b9333a1cb8629572f9e0f276a404ba6]
stable/6.6: [24c04e80c35ff36947366f6deafddb522eea080c]
stable/7.2: [72d5cbb10d4916a3f8ef9da516c5c0634aca8439]

CVE-2026-99007: drm/fb-helper: defer setup when fbdev_probe() fails,
not just on -EAGAIN

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99007

Introduced by commit ca91a27 ("drm/fb-helper: Support deferred setup")
in v4.14-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [755c94d178b7e972bb766199d34e4ba4f63a89eb]
stable/6.12: [3b303696f61461b3569019d7fcac6a646652b2b4]
stable/6.18: [4e7b508c7c60dec7a86b7eb2a1b7e6d174afa457]
stable/6.6: [4a2006c675758f0c765b36fec6b49d17e89159cf]
stable/7.2: [d510ed273854177f0a3ed330145858b2fe667f81]

CVE-2026-99008: Bluetooth: RFCOMM: Fix NULL tty_dev dereference in
rfcomm_dev_shutdown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99008

Introduced by commit cad348a ("Bluetooth: Implement .activate,
.shutdown and .carrier_raised methods") in v3.12-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [08e90633377f1b2567ab5ad6810b74c552246a07]
stable/6.12: [3fd5164bdb04635caa7942ddb554b0ec699a9433]
stable/6.18: [a661f401f83b8462f2d424e0a1a72b7681e92ea2]
stable/6.6: [d5c372ad03330f02962d4860df4d355ab25487df]
stable/7.2: [d0aef0b0374678153244f162df507106d728af39]

CVE-2026-99009: Bluetooth: RFCOMM: connect the session socket without
rfcomm_mutex

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99009

Introduced by commit 759c185 ("Bluetooth: RFCOMM: serialize security
confirmation handling") in v7.3-rc1.
Fixed in v7.3-rc7.

Bug introduced commit was backported to following branches.
cip/5.10 cip/6.1 cip/6.1-rt cip/6.12 stable/5.10 stable/5.15
stable/6.1 stable/6.12 stable/6.18 stable/6.6 stable/7.2

Fixed status
mainline: [ac022970e9fb0a5f7e7d1f6c8e104c1ed924dd1c]
stable/6.12: [d2206e8c78be69d21d4f5343c3e99fbaeef41cbb]
stable/6.18: [cc7732b8549ecb6f02457edeb8db1f6d255e381c]
stable/6.6: [4dc3d5a004b8fd59f3c905631dbb18cb601b1b41]
stable/7.2: [f492de11b325446b0b11bc2eb86e1f546eaa61b6]

CVE-2026-99010: Bluetooth: RFCOMM: free the skb when the DLC has no owner

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99010

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9d1afbf60ed53c5b051cd124153e0ae3078c8b93]
stable/6.12: [c3f76b025cbbb0ab47310dbe7de18092d89f2a99]
stable/6.18: [4f46de658ce61968aef5ea7ae809d1c180330544]
stable/6.6: [a54ce160e3ef7e50ec94e0ac4131c3d0f9f739b9]
stable/7.2: [b8814161b14c610b7a09527433301d8ad8180aef]

CVE-2026-99011: Bluetooth: SCO: serialise sco_conn lifetime against
sco_recv_scodata()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99011

Introduced by commit e672077 ("Bluetooth: SCO: Use kref to track
lifetime of sco_conn") in v6.13-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [816fb1590a4c8cf8d05cd076057616be02e276f0]
stable/6.18: [b108ea7ebba147465f4158d8133f0e8f013762ed]
stable/7.2: [8a98d58f6cfe70d51138cd9ce894e72671d95f8a]

CVE-2026-99012: Bluetooth: ISO: Serialize concurrent connect calls

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99012

Introduced by commit ccf74f2 ("Bluetooth: Add BTPROTO_ISO socket
type") in v6.0-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e32d80293a0e1a160d5e5101daa8c82148c07510]
stable/6.12: [1adcfe232c0f58890c2538211a841100ad0512bd]
stable/6.18: [c6489a3a0ac8c07f64cb5b44f005bc518f1048ac]
stable/6.6: [9b6ed57eb8c892ee7566b8c1bd06fdd0053b53de]
stable/7.2: [3728f6b0d5990c0d500e929ba10baf93bee24f5e]

CVE-2026-99013: Bluetooth: ISO: Reject concurrent BIS listener setup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99013

Introduced by commit 168e283 ("Bluetooth: iso: Fix circular lock in
iso_listen_bis") in v6.13-rc3.
Fixed in v7.3-rc7.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [555ff78fa719f50ff4cdbdb40aa1acc6e8e327d3]
stable/6.12: [559e4d2b6f83aaa96061659cc7104b7a0293f9ef]
stable/6.18: [90b744066ca520d1a6a505a11ade9c9a5f48accf]
stable/7.2: [79993e9919a87068183ba3622c383f05c049c4bc]

CVE-2026-99014: Bluetooth: hci_sync: Fix command skb lifetime during scan setup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99014

Introduced by commit 22cbf4f ("Bluetooth: hci_sync: Use QoS to
determine which PHY to scan") in v6.9-rc1.
Fixed in v7.3-rc7.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [9af12272061d206af8bc3e40215cb694421ab73a]
stable/6.12: [119ba8070b3f112dd36c897f4f70ea5bb7d370b8]
stable/6.18: [7db33b36213a3a1a40940c009ddac30670b55922]
stable/6.6: [f01cbddfb4273fcc9a786d13b0a2525029023605]
stable/7.2: [762850c203fab1190ad6a3de41cd51920b22236d]

CVE-2026-99015: Bluetooth: hci_sock: Serialize dead-device detachment

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99015

Introduced by commit e044809 ("Bluetooth: defer cleanup of resources
in hci_unregister_dev()") in v5.14-rc5.
Fixed in v7.3-rc7.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [381a0925c556a8d91a80a9b9e3e86651d60ffee3]
stable/6.12: [76f2e2665697340ac719e7ff1bf148dd014e55c1]
stable/6.18: [c3d2799877906d0c8392d96e14216cd82b020330]
stable/6.6: [37cef0c8fb537f40600910d2c2e5f2d5509305f3]
stable/7.2: [e660a22402944f2615a16fde7129a3c497537329]

CVE-2026-99016: riscv: futex: untag the user pointer before the atomic access

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99016

Introduced by commit 2e17430 ("riscv: Add support for the tagged
address ABI") in v6.13-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [405290be962b32eec842776fbe3bdf81f15b1676]
stable/6.18: [2e5c80bbc062a8dda33e687ebf7be8f074ee4f7d]
stable/7.2: [8e48d8d51ab37b7decfbff3e2844e027a52ad6ea]

CVE-2026-99017: riscv: errata: select RISCV_ALTERNATIVE_EARLY for
THEAD GHOSTWRITE

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99017

Introduced by commit 4bf9706 ("riscv: Add ghostwrite vulnerability")
in v6.14-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [298510bbc7c3017c0faf481c6ea66f1065b657b4]
stable/6.18: [fa465a7819ecbe5801b78c088d3cadaf2664b8ca]
stable/7.2: [7fee577a2fa78b9a76da015beec1ccf978746ebb]

CVE-2026-99018: riscv: entry: gate shadow call stack reload on
sstatus.SPP, not tp

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99018

Introduced by commit d1584d7 ("riscv: Implement Shadow Call Stack") in v6.7-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4d0697f192975dab5985e921989be1d85cf580e9]
stable/6.12: [6639735367a7d491977e9e5e7afc50b489d81d83]
stable/6.18: [7d1367a53137e379498eb8791295e58854378636]
stable/7.2: [37b4401ee6fa06046446d55e97e8d11784080843]

CVE-2026-99019: scsi: ch: Do not keep references to data transfer
element devices

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99019

Introduced by commit daa6eda ("[SCSI] add scsi changer driver") in v2.6.13-rc1.
Introduced by commit daa6eda ("[SCSI] add scsi changer driver") in v2.6.13-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [27c0f718d3b3c99e6d315308e95d987d0382a8a8]
stable/6.12: [cef2cedb6f7a394b278775b3d6ffb9b20ecd61db]
stable/6.18: [a34a230ccea1b8b667ae59dca11295a2c8f81738]
stable/6.6: [ec6ecab1b7577ae555ee6b81480814d123dd9ec0]
stable/7.2: [1d35a17f1c2ed4154731895694a1a3557f0da766]

CVE-2026-99020: regulator: tps6594-regulator: Fix n_linear_ranges for
TPS65224 BUCK2-4

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99020

Introduced by commit 00c8265 ("regulator: tps6594-regulator: Add TI
TPS65224 PMIC regulators") in v6.10-rc1.
Fixed in v7.3-rc7.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [2f15518682c779b1014552cb2ccb4a2052f85f27]
stable/6.12: [66b7da589b2ce44a02b8387c6160e9254685f34f]
stable/6.18: [f6fbe9c6b39968a7696b9badef4bc29331a6376a]
stable/6.6: [1ea151615a82fd94f25e38b2cc7eeac49112508b]
stable/7.2: [f3423b56be12208a393274afb9a5e3d67fc58ce3]

CVE-2026-99021: regulator: of: fill in supply names in
of_regulator_bulk_get_all()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99021

Introduced by commit 27b9ecc ("regulator: Add
of_regulator_bulk_get_all") in v6.2-rc1.
Fixed in v7.3-rc7.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [e2151c29cec73f6cc70abf1c7cbc7b9b202489f5]
stable/6.18: [82ac8c4939bdbd064b4f54a580fbe4baf0d60e41]
stable/7.2: [a3384ec2516a7cc567bd7c09029282494469b247]

CVE-2026-99022: regulator: ltc3676: don't read the write-only HRST and
CLIRQ registers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99022

Introduced by commit 37b918a ("regulator: Add LTC3676 support") in v4.9-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [28c2388ee24cdbefbcc458fa41ef7bffaaa1cc83]
stable/6.12: [1fb0d58fd363b439b4faf08a16ee6ae38b575cd4]
stable/6.18: [199a62d70314d21f06a9a6faaa3ef54d0404910c]
stable/6.6: [fd376d83741118e0212f0da985889c1a98d9c827]
stable/7.2: [ca5d85335a8fa6e87b45629f1a07b412482cab17]

CVE-2026-99023: power: sequencing: pcie-m2: Fix leaking array from
of_regulator_bulk_get_all()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99023

Introduced by commit 52e7b5b ("power: sequencing: Add the Power
Sequencing driver for the PCIe M.2 connectors") in v7.0-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0d6c5794fd633427f0d4ad8b51d94061295649da]
stable/7.2: [5cd2354ebfbd35bcb88d01fe7d3ee08dcf266eff]

CVE-2026-99024: optee: register TEE devices only once fully initialized

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99024

Introduced by commit 4fb0a5e ("tee: add OP-TEE driver") in v4.12-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c108feca0a096f8db25d1b69130035025e9e936d]
stable/6.12: [8cae1605be8a047ae3a62df07b9474d61462c4f6]
stable/6.18: [681adbc9c7a820279582a295e183fa6a1d1b4ec4]
stable/6.6: [262062c01f5a817104c88bf6eacb7c6ffdc7018d]
stable/7.2: [2f7240f0a6fd83df274fc0a2abf0609b4e6bd388]

CVE-2026-99025: openvswitch: fix soft lockup in the netlink flow dump

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99025

Introduced by commit 63e7959 ("openvswitch: Per NUMA node flow
stats.") in v3.16-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aaaaf87ea99b8766c9a8aa0e71aa42e6bc8a5320]
stable/6.12: [b872de585edff534056c65ba30970b68499fca14]
stable/6.18: [55f12552b00a34ca7ab5cf2d2b5ed02f8f06a965]
stable/6.6: [c995c52eba1926a5e82823fa5573a6f1b1010e5d]
stable/7.2: [80db24f3c16fdeef85460d9d66a4aae7a9cb92b4]

CVE-2026-99026: net: team: free skb when broadcast has no txable port

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99026

Introduced by commit 5fc8899 ("team: add broadcast mode") in v3.6-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [489114c9ecae44e523361a4b3e610ee5ebd9189c]
stable/6.18: [961563117626f4681623077ec0cfd86f86da0d49]
stable/7.2: [f34b1bcac4581a5bd3daf9eff90f175e736b54aa]

CVE-2026-99027: net: team: stop reusing skb after queue override

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99027

Introduced by commit 8ff5105 ("team: add support for queue override by
setting queue_id for port") in v3.7-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b7454f1940c5e6d92e753853c476a769e452f30a]
stable/6.12: [07a48cfceb3d0555710a9acb87c949500a7b4523]
stable/6.18: [0c0568c9d35c47dc8e3ef6705d4c35a02bd88c4e]
stable/6.6: [b21f20320fa2f3c683e3334d70de6bfd172e544a]
stable/7.2: [bed63353341d2d44cbad034001dd382cfe3a3892]

CVE-2026-99028: net: xilinx: axienet: Free outstanding DMA buffers on
dmaengine stop

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99028

Introduced by commit 6a91b84 ("net: axienet: Introduce dmaengine
support") in v6.8-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bcf2573a68a808a5b54cadafa72b6672e662c2bf]
stable/6.12: [079396129da5e7cb40ca0920aa1b9525bef6097c]
stable/6.18: [eececf7c3a679d9c08175ad6bacbc8c31848f5af]
stable/7.2: [5e5cf3ad7c099ff86ea9e422cddb25a2e5317b58]

CVE-2026-99029: net: sparx5: free the matchall entry on destroy

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99029

Introduced by commit 1ede4ac ("net: sparx5: add bookkeeping code for
matchall rules") in v6.10-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b82e16d6084cbc651e3c902198f1945408ee1a5]
stable/6.12: [fa0c27d9e17ee2e46d4b8274a6fde706f0d6725e]
stable/6.18: [cc7cc5955d22ea90555f09a680d4bf56d4a0c24a]
stable/7.2: [44efb6d92dd5a2b1dd9553d92ef0eebde135fc6e]

CVE-2026-99030: net: skbuff: don't leave stale bytes in skb_copy_and_csum_bits()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99030

Introduced by commit 65249fe ("net: add support for skbs with
unreadable frags") in v6.12-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ab9414ed70bd783e902a85c350620dee269bcb2b]
stable/6.12: [5f19b9cfff79508e8cb09be40d014cb0807f3854]
stable/6.18: [5551399751e2c9f31e4f3428040985a07e79d9c2]
stable/7.2: [39d1a6b601831237c6038b5e3ac8dbb883c1700a]

CVE-2026-99031: net: bridge: avoid recursive multicast port cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99031

Introduced by commit 8266a04 ("net: bridge: mcast: handle port group
filter modes") in v5.10-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5158353121bae4f552cb677ce8c5c3ef52f93a0d]
stable/6.12: [2fb87c6025f90191516bee3ce14b42eb3e1cfed7]
stable/6.18: [d109141ba14652146089ef78b32d5e4d5285ebad]
stable/6.6: [695a5a4c69c922d9296b2d7ad5f1ce8c6858fc64]
stable/7.2: [7931fb9181421953f3133b408b0f2e2b8dd68b61]

CVE-2026-99032: net/smc: protect clcsock lifetime in smc_getname

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99032

Introduced by commit b03faa1 ("net/smc: postpone release of clcsock")
in v5.1-rc1.
Fixed in v7.3-rc7.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [64a6b36b0e1855288080bc5f89769f27d6dc03c8]
stable/6.12: [1512e3714b3946bda75a160a34f22a51710daa43]
stable/6.18: [6a1833f0d7dc037c8e876b9178ba69d5d107c086]
stable/6.6: [e607017a553d2a48e428ec8b8ffb06bf3bb92ce9]
stable/7.2: [c223da71abfaea2ebb1c7208ae9ebf15038f9388]

CVE-2026-99033: net/packet: guard the ll header push in packet_rcv_spkt()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99033

Introduced by commit d549699 ("net/packet: fix packet receive on L3
devices without visible hard header") in v5.10-rc6.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [28bc1ef699610ee09ce3d46a00552f5a0a0144bd]
stable/6.12: [31c7b15b3716e8d0dad58d2c3cdf321dfd06f4be]
stable/6.18: [3efe0e0944157fdd2072b4dc7eb0491a317ed272]
stable/6.6: [d8a24b9e1774a93943caf68d48c5e17be432220b]
stable/7.2: [00fbf71e74115f7628fc0880b855434b1e70c40c]

CVE-2026-99034: mmc: sdhci-sprd: disable runtime PM on remove

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99034

Introduced by commit fb8bd90 ("mmc: sdhci-sprd: Add Spreadtrum's
initial host controller") in v4.20-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e1c6c10a6a70a69e29b04fcc1ebe4b9bcbc7a49a]
stable/6.12: [03244b8713d044425db5dbee08037ecd79b684f9]
stable/6.18: [3a1caa886d41d9bcc9a402906336eda34a90d323]
stable/6.6: [605a59639abb9cb63cd7676460461fb0b34756b3]
stable/7.2: [dbad91a31c482063c0a87c90aa83c9001972c6ac]

CVE-2026-99035: mmc: mtk-sd: Cancel request timeout work on remove

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99035

Introduced by commit 2084890 ("mmc: mediatek: Add Mediatek MMC
driver") in v4.2-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b38af5386a74416e898955443f2e26547b358cb2]
stable/6.12: [f37e0367ad6f2147a0b37564b442b7a25bec0d23]
stable/6.18: [46e75703ca3f00fb8c935b3ce35b90836e34e8af]
stable/6.6: [9e799f25c420e759641eb25102967ea091fc758f]
stable/7.2: [edef1355224c0799a502a46b71d3649fa0dd218e]

CVE-2026-99036: dm: fix reading free memory in do_resume

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99036

According to the .vulnerable file, this bug was introduced by commit
d581687 in v2.6.29-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c9417c1c5269e2bd0570fbe53e4ec03a8d31f008]
stable/6.12: [2c96d1a8324e7736e0f8a5790ecf39d36c2c4a82]
stable/6.18: [e3bf232c913b7e0103d323f15e6342d37cb1b357]
stable/6.6: [281f68d6cf8acb2547ebf0a849b8beae8fb0ec3c]
stable/7.2: [301691c32b8ad023e3316d5dbb6a8cf52d47b0dc]

CVE-2026-99037: dm-crypt: reject the lmk IV mode with AEAD ciphers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99037

Introduced by commit 33d2f09 ("dm crypt: introduce new format of
cipher with "capi:" prefix") in v4.12-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3195e0daf590683992edb4eed32269e569e04924]
stable/6.12: [962ce265fbf5d87afeb78cf19c12e083ab0ffeb8]
stable/6.18: [a1a875614dae43b43d311bb9e7a7a70eed78efe6]
stable/6.6: [9a0dab8a9d9975dec14a118b55cae2517aea5ca9]
stable/7.2: [40ea7dfa8cd5f9aed72a55c9ca3008aee5880e6f]

CVE-2026-99038: memstick: rtsx_usb_ms: complete requests after eject
instead of dropping them

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99038

Introduced by commit 99451dc ("memstick: Add realtek USB memstick host
driver") in v3.16-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c96ca94425b076dc398d929366e378d1e22ec794]
stable/6.12: [5b599e28aeb3684772aef64f46cc6f25f4c67128]
stable/6.18: [d7e811c3a49cd5cff529c157df886719e09370ec]
stable/6.6: [f2c181e1d58e911804e14543b2f1cc6b23a0d4d6]
stable/7.2: [5616da0f92339328fa1472876df51555e15ad340]

CVE-2026-99039: memstick: core: wait for request completion before freeing card

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99039

Introduced by commit baf8532 ("memstick: initial commit for Sony
MemoryStick support") in v2.6.25-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aa0a37b5024d921e96ac4f8f487c8bfbf1f1a582]
stable/6.12: [810580cf60edc75c9891c2de3225e4cda78e4d9f]
stable/6.18: [f2795c50144d528dabc2cf2fd53c0f0c63a823a1]
stable/6.6: [c3ab92542475d59ae685cbb294e70ca4d0ba38e9]
stable/7.2: [3af81770e2011c6ac7bb597a4af2e4f3591f928c]

CVE-2026-99040: KEYS: Fix add_key() race with keyring restriction

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99040

Introduced by commit 5ac7eac ("KEYS: Add a facility to restrict new
links into a keyring") in v4.7-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd3ea3fcba7c75493760cdbccd35f029597e8d5e]
stable/6.12: [f99399b48e3edd6851fac34cd329bab9f1f33baf]
stable/6.18: [11516a0c402a6c1fa52254aa70d8d65fb921e59e]
stable/6.6: [305f1828b871dd46bf41addeb6f11d2c162dcb25]
stable/7.2: [da0b595d8e6e2dd798f6e34e09dc51a13b888514]

CVE-2026-99041: ip6_gre: remove obsolete ERSPAN PMTU update

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99041

Introduced by commit 5a963eb ("ip6_gre: Add ERSPAN native tunnel
support") in v4.16-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8bc60db48e8cba35488bbd6e1f94aa990afa275a]
stable/6.12: [f5b143f4cd3fb7673df8d727550478a4b762908a]
stable/6.18: [2d06cb25a497d3a7034ef9d172626c2d6620a0f1]
stable/6.6: [b14a682ad7d45345701e08f9279d483a1da8b36c]
stable/7.2: [8f27260b989f488760289276377db24fbfb20bfa]

CVE-2026-99042: io_uring/net: populate CONNECT filter fields for
24-byte sockaddr_in6

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99042

Introduced by commit 899bea8 ("io_uring/net: allow filtering on
IORING_OP_CONNECT") in v7.2-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aa5d5f8e502318e783545ba5d04bb40130b83e20]
stable/7.2: [596a955d2d01b7e29d9fed60ebcf7c4ba518b8e5]

CVE-2026-99043: ice: fix metadata_dst refcount handling on representor teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99043

Introduced by commit f5396b8 ("ice: switchdev slow path") in v5.16-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [58858b8f14803a7eeac297b3ce20f3b21bf2ff66]
stable/6.12: [6f5544f53f1e58ea8a49fb9f9158d5793b9205b0]
stable/6.18: [beb05f484a1e4a5a66e3678e4b7f3147f651c080]
stable/6.6: [1f263235651775f93c15d90c9f25c3f4a4ef6512]
stable/7.2: [5e4d20db5179e83a4948927bc39e489a9a83256d]

CVE-2026-99044: ice: fix use-after-free in dynamic port cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99044

Introduced by commit eda69d6 ("ice: add basic devlink subfunctions
support") in v6.12-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1402fc67d2f4e2e1fc7bf8ee0825b8ad994557ff]
stable/6.12: [7c1344df1ae0579f57b97647e5203b06496ce10c]
stable/6.18: [ca8a6285b11d01e5a279b1aa7fb55b1a02ecebb1]
stable/7.2: [b98eb58ba2f8fe8e9bba1b8a3b94fa5602c6de84]

CVE-2026-99045: ibmveth: h_free logical LAN on open-fail after register

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99045

Introduced by commit d43732c ("ibmveth: properly unwind on init
errors") in v4.13-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [af0524bf4ce1a4cbd2946aa81751582951cfcab5]
stable/6.12: [c54bbdf6f0731102a4bf7f5e4ee535b3ea415996]
stable/6.18: [a065bd31ec462f6f9c267026b708dd020f122723]
stable/6.6: [decb4d4ead2c71ef698727734ab5024a872eb372]
stable/7.2: [d24fdec1413c656d29298097926e77542785ca0c]

CVE-2026-99046: gve: fix XSK buffer leak on error descriptor

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99046

Introduced by commit c1fffc5 ("gve: implement DQO RX datapath and
control path for AF_XDP zero-copy") in v6.17-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9fed6a8ab8a5bacba2c709cb19d2dd6d2fa9112e]
stable/6.18: [06656aaa7e43ae62b673c2244d27099b8b94a70d]
stable/7.2: [889f763874855c575429f75946132a53c573aa14]

CVE-2026-99047: gve: fix XSK buffer leak when rings are stopped

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99047

Introduced by commit c1fffc5 ("gve: implement DQO RX datapath and
control path for AF_XDP zero-copy") in v6.17-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [73670ddb91a4d22e1deb3efd962242de1ec48e90]
stable/6.18: [506f9de069d07a72b9887ce3edd2fdf32f4953aa]
stable/7.2: [7a7e6bbbf0586c1f62f0cc7d9a2877d8a5e5aaf7]

CVE-2026-99048: gve: fix napi_disable deadlock when attempting to
disable XSK pools

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99048

Introduced by commit 606048c ("net: designate XSK pool pointers in
queues as "ops protected"") in v6.16-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0cb6939a4dfefa822007b7a71986e06bc4f61f54]
stable/6.18: [42935a61001927aa01db10b53b420efd37eaa99b]
stable/7.2: [3d377911ce81fd4e61af814e750d8e08879a5208]

CVE-2026-99049: gpio: xilinx: fix runtime PM leak on request error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99049

Introduced by commit 26b0477 ("gpio: gpio-xilinx: Add support for
suspend and resume") in v5.12-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ff82fc3a4a1d417dee1229681cc5285986edb1fa]
stable/6.12: [f73ee2bd2293f8cc340061c5229395ace71fc2eb]
stable/6.18: [a027e0d7765d1531ee39e4dae81951b04f32ba7b]
stable/6.6: [b07b3925f676640103b3d74b93fc401b1c873d13]
stable/7.2: [2fd6ecda5d1f47cffcfadddb35ee49402162c724]

CVE-2026-99050: gpio: mpsse: fix race when arming the IRQ poll worker

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99050

Introduced by commit 179ef11 ("gpio: mpsse: ensure worker is torn
down") in v6.19-rc1.
Fixed in v7.3-rc7.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [7efa1a1953cd6b20b23a3524d5b4b81789c6ef25]
stable/6.18: [76390ac0bca7e5058b7482eb4d951c3bda5df812]
stable/7.2: [c0071ee496e1228976c72b096f529503222708a0]

CVE-2026-99051: fsverity: RCU-delay the freeing of struct fsverity_info

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99051

Introduced by commit f77f281 ("fsverity: use a hashtable to find the
fsverity_info") in v7.0-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e58c3805ed325fe2d4ae2dd467c0486cc860b733]
stable/7.2: [fa84f091a8e7fc46fd29834496fab9739dd4c8dc]

CVE-2026-99052: selinux: preserve NATIVE_LABELS on already-initialized
sb in set_mnt_opts

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99052

Introduced by commit eb9ae68 ("SELinux: Add new labeling type native
labels") in v3.11-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [28b7260548af3d35773477993ad4e4de41578dd7]
stable/6.12: [a6da93c625b3557dd23ff6db45d2d1bafeae1565]
stable/6.18: [5509d498e1b9edafebd5a60ba3cb9ecfda23dc2b]
stable/6.6: [a545def625860d4ccedc14fe45e884a62a041cef]
stable/7.2: [c997832414f1d846de0a1fa38d7d4f62ba2ea917]

CVE-2026-99053: tipc: hold a reference to nodes found by link name

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99053

Introduced by commit 6a939f3 ("tipc: Auto removal of peer down node
instance") in v4.19-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [17e73bae400f6a434dc006e3bee92c94cf781954]
stable/6.12: [f17e70206a1e763fcca2578a8db3c4eed0f843a9]
stable/6.18: [1428c5f1d346a2e1ac9156713975a72246957009]
stable/6.6: [b60259d4047fbb735476c729dcf9306a038b6110]
stable/7.2: [3c3b308ee6e25729a6cf09b69cdd0e093220d40b]

CVE-2026-99054: tipc: destroy topsrv workqueues before closing connections

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99054

Introduced by commit c5fa7b3 ("tipc: introduce new TIPC server
infrastructure") in v3.11-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3acdd44385bc7e2e57605e073691ce69cc5a960d]
stable/6.12: [da9c16568bc79140a54c1f5fcf07a0305df47b37]
stable/6.18: [0af8780bdfdfc91fb9127bddb9c48fab67dc9d9e]
stable/6.6: [7f796bb3b440d7f1b14c0e3b520462eb34f553af]
stable/7.2: [fb717c536af2aafeca520ff11d1e0f25f7ab8fa9]

CVE-2026-99055: tcp: reject net_iov in zerocopy receive mapping hints

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99055

Introduced by commit 9f6b619 ("net: support non paged skb frags") in v6.12-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8b1f0af1fd5fd113432233ed8a3862ee7c30a84f]
stable/6.12: [563d3564513496b9ce3b3ba7a5154427554d0f06]
stable/6.18: [1c7463ac0e99cc91c4eecc1b69a740ef1a619932]
stable/7.2: [3aa6f536a95eb0617c313ae2eb76fdfa85331f85]

CVE-2026-99056: strparser: make sure __strp_recv isn't running before
tearing down the parser

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99056

Introduced by commit e27cca9 ("xfrm: add espintcp (RFC 8229)") in v5.6-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0984ebc631792acf8fff105112ee74a6b8f1efcc]
stable/6.12: [9f3e9fe1b155e9b4572054d8d140586bc3512ecf]
stable/6.18: [d2b5f637b9b67a79a50d42614d10653c13b4e449]
stable/6.6: [a18dd388045dc7263d99a07db9de4e0f149ca8f1]
stable/7.2: [eaa3a29004c063d7e9d5ea55636f693f67e6db0f]

CVE-2026-99057: xen/netfront: don't leak the skb when xennet_fill_frags() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99057

Introduced by commit ad4f15d ("xen/netfront: don't bug in case of too
many frags") in v4.19-rc5.
Fixed in v7.3-rc7.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [93ccaf1c26e2133396173b76a071e59024daa622]
stable/6.12: [99011a11c97340ef7290df7dc199305c73fab2f2]
stable/6.18: [086944c1c2cbb683543bc3ff08637847b03c8009]
stable/6.6: [5051df031144753d3e18862514969146b601d089]
stable/7.2: [84e3ea6502b5f14ce8d499d0b6e0e38386274cf0]

CVE-2026-99058: workqueue: Fix NULL current_pwq deref in chained work check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99058

Introduced by commit 8d03ecf ("workqueue: reimplement
is_chained_work() using current_wq_worker()") in v3.9-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [980db94e3eeefdd8a1c46f86412c33a7f7806f51]
stable/6.12: [729d576df89c7e4341e58c452f8890620a610ac2]
stable/6.18: [b12a25fb2b9d5dac80e419d695450cc17a51fdfd]
stable/6.6: [3dc61af2998cfc7312d6e59bbdcd5eed074483f2]
stable/7.2: [1a2668682e998039a027796b236319b380078a6a]

CVE-2026-99059: wireguard: noise: reject response consumption after
intermediate initiation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99059

Introduced by commit e7096c1 ("net: WireGuard secure network tunnel")
in v5.6-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d0305f8d90029556260c6824b61c493c424eba9e]
stable/6.12: [c76a80db593096edf2b3b3972f58b6342a8c6c04]
stable/6.18: [4d64a3d6e96aa78619c9c29ffde309794974588a]
stable/6.6: [fb5ce4c7790c3eeec820302d08d70ecf46af4295]
stable/7.2: [3bec3d32c2a3afd164fc87f95457df2cf9049c20]

CVE-2026-99060: wifi: mt76: mt7603: initialize global station WCID

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99060

Introduced by commit 0335c03 ("wifi: mt76: fix race condition related
to checking tx queue fill status") in v6.7-rc1.
Fixed in v7.3-rc7.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [456de496b53ae73e6e3020fec815dbdc88aa7c07]
stable/6.12: [e454ec553996f21085657c96c8a605e2d89a81a6]
stable/6.18: [dd117d17e8aa2e89f857fb708e5b770709fb81cb]
stable/6.6: [99b8bd6323e6fc69615af828522878b7acb77bff]
stable/7.2: [19d6fa087dcf242223645828b8282d4040bad168]

CVE-2026-99061: wifi: brcmfmac: fix P2P device removal race in brcmf_detach()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99061

Introduced by commit 9831bcb ("brcmfmac: Deleting of p2p device is
leaking memory.") in v4.4-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [08a3f02fea636e97a7422d1512f76dacdb5b0887]
stable/6.12: [2e0c8c60a11b3177e7432c71d41249e276a0825f]
stable/6.18: [eef16a74ff8ed2a838d6bb862bb2c7783fce7466]
stable/6.6: [7b79131e357c4786765b20a994ad40d4d35f2163]
stable/7.2: [47ca6395a1d91545cc9403f9218bc61be941a0c3]

CVE-2026-99062: vsock/virtio: account only unread bytes in read_skb()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99062

Introduced by commit 45ca7e9 ("vsock/virtio: fix `rx_bytes` accounting
for stream sockets") in v6.16-rc1.
Fixed in v7.3-rc7.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [a463f55c791b96cfd12df8b10ea737d45c80bb18]
stable/6.12: [e4a0028b0d54b2c45e1dc8c0dd95fe3e9236f55b]
stable/6.18: [38bad3930b1185dd6c98db3dd342ddc123c6f3ef]
stable/7.2: [dd4b2f88ee517f9629d0d3dbfced02ffbc33e2dc]

CVE-2026-99063: dm ioctl: don't let data_start run past the buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99063

Introduced by commit 76c072b ("dm ioctl: move compat code") in v2.6.25-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9b3fcf519d370df94a56f3b272d9eddffffa5be8]
stable/6.12: [e5c3f3d8935ecc64c962fb66e6a86dbf79218f61]
stable/6.18: [5680b6fb3054677d4ee65d3baba24b649f1b430e]
stable/6.6: [98195e822343a656b92e235847ab3e72b1a3f920]
stable/7.2: [725b49c689bbb29ef740b0d6b5ea9390baa9a695]

CVE-2026-99064: cipso: adjust cached option offsets when removing CIPSO

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99064

Introduced by commit 89aa361 ("cipso: make cipso_v4_skbuff_delattr()
fully remove the CIPSO options") in v6.10-rc5.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6d25ffca055a77787c21a36b66c253f76239411b]
stable/6.12: [b965977126a90e01825814c859ba4788691eddd3]
stable/6.18: [2200fe1d6148b78e1b8f00f4b2bd47760015077f]
stable/7.2: [6e49d611a9cfbaac927b8fa80ebd4f6b1f37ada0]

CVE-2026-99065: cgroup/cpuset: Handle cpu hotplug race in
guarantee_active_cpus()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99065

Introduced by commit 7a0aabd ("cgroup/cpuset: Always use
cpu_active_mask") in v6.16-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [23b1ab15ca91f2cffaf149d9bb0fafeb700c7db2]
stable/6.18: [8d88d3221204fbb1b6dc2c0f2f2181fe49126639]
stable/7.2: [a21c255159bfe0034740292e10d2e258feeeb10d]

CVE-2026-99066: can: dev: init_can_skb(): restore skb header initialization

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99066

Introduced by commit 9f10374 ("can: remove private CAN skb headroom
infrastructure") in v7.0-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0a04c0cb8606ff88399489d03ef255afe90d0d5f]
stable/7.2: [8078375dfd0baecd9f1b7b06bb2d6f88d7cb8632]

CVE-2026-99067: btrfs: scrub: fix local_root reference leak in
scrub_print_warning_inode()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99067

Introduced by commit 558540c ("btrfs scrub: print paths of corrupted
files") in v3.2-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1fd742c7479961da6d0bb794ef8ac6b7b9442847]
stable/6.12: [452a435b74f7f598a343c51f7c89c5d2244384b6]
stable/6.18: [12ba7d8b9cd45a2c6aa8f37c3f4b8a50422fb549]
stable/6.6: [41cabfbf3532e2a2a17be9e4876042a5393b5c8d]
stable/7.2: [a7e5992bc37088f9b00e531955022aef69de3dc7]

CVE-2026-99068: ALSA: ctxfi: Fix memory leakage when clearing DAO input mappers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99068

Introduced by commit e576e78 ("ALSA: ctxfi: Simplify
dao_clear_{left,right}_input() functions") in v6.14-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [593d46fc6af9a0178a46e77d6d24b20d2314165f]
stable/6.18: [f7dc71c1ce885f5d9f128037ebc75d9c0356e060]
stable/7.2: [0919d8dd19f92e12829055c75fced9a454d644bf]

CVE-2026-99069: Input: ati_remote2 - fix type confusion in device
attribute handlers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99069

Introduced by commit b20d6bf ("Input: ati-remote2 - use driver core to
instantiate device attributes") in v6.11-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f321cc430c49b6c1be0d53f2ef19d8342d8029cc]
stable/6.12: [e44ec6b6d3c0b8ea089b589fa0cce49a4da66b89]
stable/6.18: [d738e51bf2c21921df351f536147178ae3cbd38b]
stable/7.2: [2caae9d1977beea0a7914b3d86639262801fd116]

CVE-2026-99070: ipv6: do not warn on route notification size race

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99070

Introduced by commit 907eea4 ("net: ipv6: Emit notification when fib
hardware flags are changed") in v5.12-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c97426ec649d99596d8969e1a052c16b14b7b485]
stable/6.12: [7b112bd43f1172fb152e848570a957467008a5ae]
stable/6.18: [4ac7d92a4698e34e614c254359665b9de1f65283]
stable/6.6: [8a3b935b6b6037eefb36bd27a60793a008358e8d]
stable/7.2: [291fe0bafee78c95f9f2e7f579f17793fd5a1e5a]

CVE-2026-99071: ipv4: do not warn on route notification size race

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99071

Introduced by commit 680aea0 ("net: ipv4: Emit notification when fib
hardware flags are changed") in v5.12-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e02a5b6588161673ef75a4bc5cdfb62bd493374d]
stable/6.12: [78a1cf5c54b2f795c81fedb530755a8d01cc84f0]
stable/6.18: [7dfa7ca97f3ac46353edd4cc44f7733758e4535b]
stable/6.6: [088ba80eef85fa7a5ad8f9e7c82b403c99242b56]
stable/7.2: [221ef5e1e44a044790f0f54e6aa237883f475a4d]

CVE-2026-99072: ipv4: stop route notification sizing when nexthop group shrinks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99072

Introduced by commit 680aea0 ("net: ipv4: Emit notification when fib
hardware flags are changed") in v5.12-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d3daa33c7af92e38f2274bbd2576f58bfbaf89e6]
stable/6.12: [ad1c9f1b98c92609e9bb2ae8f05916defc3b0a54]
stable/6.18: [c1f48d1c2d5e9efd904dbbc2f2b3d41543e55c49]
stable/6.6: [72d9d17092bb37b0717f12042a0817d01a1f9e78]
stable/7.2: [ad2b3a68b8a7d5d27de88e05674e4adb1ce46d88]

CVE-2026-99073: ipv4: stop exception dump when nexthop group shrinks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99073

Introduced by commit 4ce5dc9 ("inet: switch inet_dump_fib() to RCU
protection") in v6.9-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4f4afc07dcb2edd4f9afa36595373f8cdb9b58c2]
stable/6.12: [f91e472821e32f58b03eb631e20a67157e2b928b]
stable/6.18: [21cba134c30c17ae55f468b5809336437df5d7e6]
stable/7.2: [b9a30bb7b831e8c5a47fadbdf1760918aaf009cc]

CVE-2026-99074: ipv4: stop PMTU walk when nexthop group shrinks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99074

Introduced by commit 7d3f3b4 ("net: ipv4: Cache pmtu for all packet
paths if multipath enabled") in v6.13-rc1.
Fixed in v7.3-rc7.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [6619e01855e65ef35723685a557e3eb106f4ecf5]
stable/6.12: [c60d17d6dd61adc761ac6f65a008fefbc54cbf87]
stable/6.18: [c6d670ac656badfd0e15355e07a13a6bdf3b69fd]
stable/6.6: [7fd60d3c9a1e1b11ef5f1643bbae78d91eae2f4a]
stable/7.2: [f27483f9975b5065ff67054cc7eb8edac6083488]

CVE-2026-99075: rust_binder: reschedule node refcount update on thread exit

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99075

Introduced by commit eafedbc ("rust_binder: add Rust Binder driver")
in v6.18-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2a74ccd1bcc170e66525f34e9de8652b57e2cf3d]
stable/6.18: [71cbad138969edecef01b28dff87d91b56db538d]
stable/7.2: [fb0f8dfc5a030ed3d60a1d03acdc99c90ee99fc1]

CVE-2026-99076: ipv6: udp: Create exceptions before socket matching

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99076

Introduced by commit 2b760fc ("ipv6: hook up exception table to store
dst cache") in v4.15-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ac76cab50e899a7346408b8d3c3a4192c2eefb9f]
stable/7.2: [8c9b310c958be33ba8fb9d0e6b77811d013e10c0]

CVE-2026-99077: ipv4: udp: Create exceptions before socket matching

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99077

Introduced by commit 4895c77 ("ipv4: Add FIB nexthop exceptions.") in v3.6-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4c3499f79f8c7e8561266bcc220a18538cec0458]
stable/6.18: [ecd7ead4bf05e221e90f18a29aec570a50fd1592]
stable/7.2: [be4fd05398f2b5e42029be70ee875fc749b8ce3a]

CVE-2026-99078: net/mlx5e: Prevent stale XSK buffer release on MPWQE
refill retry

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99078

Introduced by commit 4c2a132 ("net/mlx5e: RX, Defer page release in
striding rq for better recycling") in v6.4-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [63811edf512584c946e5e96b100e9e280703bbb5]
stable/6.12: [d215d09606b0fcd18ad1eb532995782a21cea49d]
stable/6.18: [867119b4b588037724b85839d534465f0334d9bd]
stable/6.6: [f3a52e2ec2788a7f6b64137985c087188a54ad4f]
stable/7.2: [3d73a1164a8c6b4461907a65cb6c022ea4fd39af]

CVE-2026-99079: net/mlx5e: Prevent stale XSK buffer release on refill retry

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99079

Introduced by commit 3f93f82 ("net/mlx5e: RX, Defer page release in
legacy rq for better recycling") in v6.4-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e01620844c5c88b6fcf819d171df8e3976a0e76f]
stable/6.12: [34d1db2b18e1c1d189e34dd51923e031815f88e3]
stable/6.18: [639522e5056cade578a324acfa993ec6c9f7f5dc]
stable/6.6: [32bbb870078d467479965c21bbc4960c57eea208]
stable/7.2: [655f47477054d19de3b138840be229a1a4490d0c]

CVE-2026-99080: fs: Free any excess xarray nodes in clear_inode()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99080

According to the .vulnerable file, this bug was introduced by commit
77da938 in v4.20-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ee3f011250104129893d8e9599147e457d4d7280]
stable/6.12: [21f51434c47d8628b62275ae6c6ad6b573abcd02]
stable/6.18: [50cff3f112d64db6e5f57355f79bc837db8fe132]
stable/6.6: [f1c966eb6ed5e190c90a56c5bdaa69967de39f21]
stable/7.2: [43f830e2bb84b22ca824b20bb861d823ecb520bd]

CVE-2026-99081: bnxt_en: fix DMA mapping length for padded small packets

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99081

Introduced by commit c0c050c ("bnxt_en: New Broadcom ethernet
driver.") in v4.4-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a51d233ccd4889aadb71dace863525cc2b00271e]
stable/6.12: [2956aca14dd2977cd08bd2ccafae3beb8b84b268]
stable/6.18: [fbd977e513971ccb4f0762a7f59eac500e474f89]
stable/6.6: [cf8530a25ae92c4493e2f22981ecb46f0b66f4c8]
stable/7.2: [5213f65a9667d3dd85db2e6df8f2e0516290db34]

CVE-2026-99082: KVM: x86: Use active memslots for the per-vCPU MMIO cache

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99082

Introduced by commit 699023e ("KVM: x86: add SMM to the MMU role,
support SMRAM address space") in v4.2-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b3e6212dea2e4328a841ceb37f377583176dc735]
stable/6.12: [7fd4e64f4bbc8c35ae8f0d2a1fb5b77a76d5b4fd]
stable/6.18: [2566780c684c9c21241d409d790087c73070f312]
stable/6.6: [a63f79d9da9468952396af73e1e53330845cf876]
stable/7.2: [e792a9ace39d2812a5b342a1987186c7bc653204]

CVE-2026-99083: ksmbd: fix heap out-of-bounds write in krb5_authenticate()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99083

According to the .vulnerable file, this bug was introduced by commit
98422bd in v6.5-rc1.
Fixed in v7.3-rc1.
Affected file was added by e2f34481b24d ("cifsd: add server-side
procedures for SMB3") in v5.15-rc1.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [23a0be6a84a38ac169eeab49017934e8e27c65f0]
stable/6.12: [80af1bde97d5a85ad6f2c40ca894ccc8fa75a27a]
stable/6.18: [517404e157395d0f8da125ca956c566895dfcd06]
stable/6.6: [59c6dcc5dd9dafe764ca0d40525933b2be69b059]
stable/7.2: [4722d06b2907585074252061b1024a696c1cfc23]

CVE-2026-99084: readdir: take no inode lock on an immutable directory

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99084

Introduced by commit 9d4e752 ("namespace: allow creating empty mount
namespaces") in v7.1-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e08f57a7dcb83818c058e415988c23beb6c5a47f]
stable/7.2: [6d30b399ae28e5166d62484f81ccaefde6fe7996]

CVE-2026-99085: sched_ext: Fix CPU hotplug hang when a dying CPU's
tasks sit in the BPF scheduler

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99085

Introduced by commit f0e1a06 ("sched_ext: Implement BPF extensible
scheduler class") in v6.12-rc1.
Introduced by commit 991ef53 ("sched_ext: Make scx_rq_online() also
test cpu_active() in addition to SCX_RQ_ONLINE") in v6.12-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d35a535d3e3e71f92a051d94e415f43612c4edfc]
stable/6.12: [f79cd7a2df3768323fbfb9b0f96adff08fb7eb4c]
stable/6.18: [638ee6bca19750934ea13f9c325f46fd8ae60064]
stable/7.2: [173ff9d03ec6373c3158b6e630af33a9b36fd216]

CVE-2026-99086: dm-integrity: validate the superblock on resume

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99086

Introduced by commit 118ba36 ("dm-integrity: fix recalculation in
bitmap mode") in v7.0-rc1.
Fixed in v7.3-rc7.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [fc79aeb86a2c244c1f1894e2d8f2966fe2b60fa2]
stable/6.18: [454b67fcc28c18502e47dfb9f067b04c28628ada]
stable/7.2: [e9ec5cbbaf4dd3a02ae3d81719f4fcb9b609aa8e]

CVE-2026-99087: dm-integrity: fix NULL pointer dereference when the
'R' flag is used

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99087

Introduced by commit 468dfca ("dm integrity: add a bitmap mode") in v5.2-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7d4d4f3b668d708d94f62ecdd33ac330a6fd8a84]
stable/6.18: [2e25842f0e4423e0efb243f56153d842ed6b933f]
stable/7.2: [69ed43ed8a174465fca1ba6bfbde53e4618c8956]

CVE-2026-99088: net: openvswitch: validate transport header presence
in set_ipv6_addr

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99088

Introduced by commit 3fdbd1c ("openvswitch: add ipv6 'set' action") in v3.8-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3c6a4b11330fe424557538a98fca9f0a4c5bf313]
stable/6.12: [6774af7cd17be8f0d0f70de3a749d381b4f2e9da]
stable/6.18: [2594795fd832f0253826d64ff8976b8ff5fbfe9f]
stable/6.6: [b7b80d204abdc258006f9e17c92b363ab13bb599]
stable/7.2: [6b8897ba0733f88f0360ea48a970f373f9142de0]

CVE-2026-99089: ASoC: samsung: i2s: enable op_clk in probe to balance runtime PM

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99089

Introduced by commit 48279c5 ("ASoC: samsung: i2s: Prevent external
abort on exynos5433 I2S1 access") in v4.17-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7529254014764ae0b8c33d5c61a58f36c65b1a1c]
stable/6.12: [5dac6bf09b5a4fff2433629801309c3884c3e94a]
stable/6.18: [64bb35079dcbc67901da1fe8c52c234cbcd17df3]
stable/6.6: [2c64c30d493d82d5edc95811cede0083e1195822]
stable/7.2: [a728c12f8bd89947894e227d0f4f83a895ac9ab7]

CVE-2026-99090: drm/amdgpu: serialize vblank counter reads against GPU reset

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99090

According to the .vulnerable file, this bug was introduced by commit
d38ceaf in v4.2-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1a6023edfbb5673f55fab6348f135fb3b1428ea5]
stable/6.12: [11b6193c8841a052b7907006ffb1e02468b1448e]
stable/6.18: [8d6f773d7479034a574ecc3b585bcd07d46b4824]
stable/6.6: [037796d9ca1da97978deaefd88ca5649f6cb69f5]
stable/7.2: [f4a0a1ce147d1a6e428d7cb5e3b99fd695139fc7]

CVE-2026-99091: Bluetooth: MGMT: Fix status of pending commands
flushed on power off

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99091

Introduced by commit f53e1c9 ("Bluetooth: MGMT: Fix possible crash on
mgmt_index_removed") in v6.12-rc2.
Fixed in v7.3-rc7.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [86ef0f58bdecdedb3a1240971c56d71b7e4ce3fc]
stable/6.12: [7ed7e038b520cf0dfa12d61c2caddb95e2f6922d]
stable/6.18: [ec227cddd13cd7ac9077d263a73473ac370a055d]
stable/6.6: [44ce36c5789ac84e65de1e98c32db9a5ac04ed47]
stable/7.2: [07976405a3c71253e50533ee7b7a8b0dc16ab6ba]

CVE-2026-99092: riscv: patch: fix handling of bpf-jit execmem addresses

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99092

Introduced by commit 2c9e5d4 ("bpf: remove CONFIG_BPF_JIT dependency
on CONFIG_MODULES of") in v6.10-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a510e1ae8c9030750c2edf7b0bc9b186cd8c7a06]
stable/6.12: [562a35b9e0b3d9483d9472995219cadb3592db3d]
stable/6.18: [9e8fc7972b398e9dc2415ece283d8f64edac3858]
stable/7.2: [f71d6ea3843c8038c431c2699482f246aea37ca0]

CVE-2026-99093: mm: don't schedule deferred kernel page table freeing
while booting

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99093

Introduced by commit 9e4a3ec ("x86/mm/pat: Allocate split page tables
as kernel page tables") in v7.3-rc4.
Fixed in v7.3-rc7.

Bug introduced commit was backported to following branches.
stable/6.18 stable/7.2

Fixed status
mainline: [2fb552b0bee70c24c092720028ab4620f5eb2646]
stable/6.18: [7a25ca170c12a9328f6fcf4410713beb516b01c0]
stable/7.2: [df6c704a08bc0925d5db047b0a6221f962bda4d9]

CVE-2026-99094: Bluetooth: btintel_pcie: fix TX descriptor bounds check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99094

Introduced by commit 6e65a09 ("Bluetooth: btintel_pcie: Add *setup*
function to download firmware") in v6.10-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [baa53af641c9e3644e717b8dfd1b95a55a0c111b]
stable/6.12: [08704ec6d4bf69725e7815b09a9b5c7af83e255b]
stable/6.18: [39ab048cce70d50af48015f5f294c4cf80d6ba89]
stable/7.2: [2669567615215d52fb306053cbcc1f53dc386158]

CVE-2026-99095: drm/vc4: drain the hangcheck timer and works on V3D unbind

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99095

Introduced by commit d5b1a78 ("drm/vc4: Add support for drawing 3D
frames.") in v4.5-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [94cf5971b1d04c6382437387c4dc3836cc7a1437]
stable/6.12: [a046cd60ff3f4a8c8e672b3b18902682c1f91731]
stable/6.18: [e61465d3e0292daebf4dbb34e0add635e2439569]
stable/6.6: [17c5fa371de2d5508755cd4cd227cc8e2bb99240]
stable/7.2: [ade226dfd28cf2fd1dce143c556d1ee77d953696]

CVE-2026-99096: io_uring/register: don't exempt disabled rings from
task restrictions

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99096

Introduced by commit ed82f35 ("io_uring: allow registration of
per-task restrictions") in v7.0-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6da8f402e362b2f546e2efb7167fc9597aef6faf]
stable/7.2: [f55c240192ded562386de843bfa067671d2731d5]

CVE-2026-99097: tee: shm: reject zero-sized allocations in
tee_dyn_shm_alloc_helper()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99097

Introduced by commit cf44415 ("tee: optee: Move pool_op helper
functions") in v6.10-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b7f925fd5226deb953c8dcdc9677d3fcc2717c00]
stable/6.12: [e5dc7af9c3a5373ee7a84959126e7dfa9e4ad50d]
stable/6.18: [65cb86860a80ffc6af897d53f5bd4b1733bca0ec]
stable/7.2: [c2a97703359e25ec7ef8b2b0ef32fb3982add90a]

CVE-2026-99098: dm-integrity: fix buffer overflow in inline mode with
large tag size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99098

Introduced by commit fb09876 ("dm-integrity: introduce the Inline
mode") in v6.11-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [764b683a6180fd72c931c13fea98d383506a3475]
stable/6.12: [3c7aad85aeb9e28386672e3a009aa2e61f751b86]
stable/6.18: [4f0ee735dc68e3e6c4dd9a666d7f7047163c4165]
stable/7.2: [f49cd7820cd0a96f20e1aa2708adb002124e38a7]

CVE-2026-99099: x86/CPU/AMD: Fix AMD TLBI Erratum #1718

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99099

Introduced by commit 82378c6 ("x86/mm: Use INVLPGB for kernel TLB
flushes") in v6.15-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [87db7795cbaaf636ae22ae031f4906db7bb77803]
stable/6.18: [e3e6779f77ab6f0a1aa80e24868d2d89f31053fe]
stable/7.2: [098d80b04d0fe02889c332d061db968f070b83a6]

CVE-2026-99100: wifi: p54: validate firmware record lengths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99100

Introduced commit is not determined.Fixed in v7.3-rc6.


Fixed status
mainline: [db7b86bd97b380ece8fa39cfdd7502a9fd35e56f]
stable/6.18: [f641066b0ddcd1b0cf007c0d04f9c966f6e888ae]
stable/7.2: [8c4f962f368d5e17481f3c2c5a43028953e137a5]

CVE-2026-99101: ntfs: move attribute payload before shrinking its record

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99101

Introduced commit is not determined.Fixed in v7.3-rc1.
Affeced file was added by fc053f05ca28 ("ntfs: add reparse and ea
operations") in v7.1-rc1.

Fixed status
mainline: [0ab6dc1ac4601c8d79e5448a024daed6b0c5ef64]
stable/7.2: [7dc2c524608039d1b082a0087f7aa0751edd4ffb]

CVE-2026-99102: ntfs: take invalidate_lock in ntfs_setattr_size()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99102

Introduced by commit 9c87959 ("ntfs: update file operations") in v7.1-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9cc5761b8f28f9cef72061094eb5e37e2cd44d97]
stable/7.2: [f0b0738ba95731eeafd11352c74f8b48951f67dc]

CVE-2026-99103: workqueue: Fix unbound pool lifetime for pending pwqs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99103

Introduced by commit 5797b1c ("workqueue: Implement system-wide
nr_active enforcement for unbound workqueues") in v6.9-rc1.
Fixed in v7.3-rc2.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [cf9c8aaea0d47410df8708bec195889f3a85cd3c]
stable/6.18: [f320b85c90fe5fc9d4d06badd450518323a94a7f]
stable/6.6: [6741dd3fd38e47c08bc39d11ef5fa141fa6d0441]
stable/7.2: [3d2ef2b9f4c084ab498494d26495a82f7e15407b]

CVE-2026-99104: sched_ext: Fix the bypass dispatch claim for
schedulers bypassed by an ancestor

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99104

Introduced by commit aa2a0a1 ("sched_ext: Separate bypass dispatch
enabling from bypass depth tracking") in v7.1-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5bdeca322a6f8d10acaf67cccab1f69747ee7be3]
stable/7.2: [f0f18075e45d47bef7ff2eb9512ee4f0c7e5f9c7]

CVE-2026-99105: sched_ext: Fix stall when a task enqueued with
SCX_ENQ_LAST lands back on its CPU's local DSQ

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99105

Introduced by commit f0e1a06 ("sched_ext: Implement BPF extensible
scheduler class") in v6.12-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7a9df76679633cf26e0fea882a684012c6ec245a]
stable/6.18: [8d891c218016b6145993e082e7f732cb69dd0e29]
stable/7.2: [396ba6f04da3fd1fb5a3d1c9535bef3f967f4e59]

CVE-2026-99106: drm/amdgpu: free the userptr ranges when a CS fails
after parser_bos

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99106

Introduced by commit fec8fdb ("drm/amdgpu: fix userptr HMM range
handling v2") in v6.2-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1b4da805a0ba354a549ce07459c871c17dd94fe0]
stable/6.18: [6ac46ae5ac561d4fc7d4246ad83d71bed0d9af9a]
stable/7.2: [2d9d24385201f476a2f754495b71bbac5ba6ea7b]

CVE-2026-99107: ntfs: fix incorrect MFT record pointer passed to
ntfs_attr_record_resize

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99107

Introduced by commit fc053f0 ("ntfs: add reparse and ea operations")
in v7.1-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8d139e3635c86e2c97c78d55538ce0b00b6d9986]
stable/7.2: [0a9122cada749447dfb6d67aa3fed4ee1982231c]

CVE-2026-99108: ntfs: fix FITRIM range alignment

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99108

Introduced by commit 11ccc91 ("ntfs: update runlist handling and
cluster allocator") in v7.1-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [03c6ecc4b4b13a3901f207152451fdd2d82e40c4]
stable/7.2: [5e87da8ba8d3d647d89c754912e45c1f1a3bfc2e]

CVE-2026-99109: smb: client: reject SetEA requests that do not fit the
request buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99109

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4aa2c106aef4bf3dfd97c30842db0767b26e8428]
stable/7.2: [9efbd764ab80fa86d2258550877a74d78a25e855]

CVE-2026-99110: smb: client: fix heap overflow in cifs_do_set_acl()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99110

Introduced by commit dc1af4c ("cifs: implement set acl method") in v6.2-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1dac61e2c29d1a71784604b48cf3b1234a65ec29]
stable/6.18: [d96f3365ce61c5f39602955af43c8174548dee98]
stable/7.2: [596b4062e6c75bdd85a7f2b7f2087a872dc420ac]

CVE-2026-99111: smb: client: fix data corruption with concurrent
writes and O_TRUNC

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99111

Introduced by commit 110fee6 ("smb: client: fix missing timestamp
updates with O_TRUNC") in v6.18-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a8603b52b39f520ea8a34def74c23fba87396d3e]
stable/6.18: [4d143608a0445443a85c9b29f4c9f8e63d5dbfc9]
stable/7.2: [ffa66fdc7d35b890606767c4d2c7ac26b4d90a99]

CVE-2026-99112: net/sched: cls_flower: validate mask pointer after nla_next()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99112

Introduced by commit c96adff ("cls_flower: call nla_ok() before
nla_next()") in v5.11-rc5.
Fixed in v7.3-rc2.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [fee10655709c5c597e8e9f722f3035d9ea31ff3a]
stable/6.18: [45e60747a9db2307929260d9aa9c1c6cbb70ee77]
stable/7.2: [bb187146c7e5c666874784e4f3fc1bc5126e6e92]

CVE-2026-99113: ksmbd: zero the FS_OBJECT_ID_INFORMATION buffer before
filling it in

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99113

Introduced by commit e2f3448 ("cifsd: add server-side procedures for
SMB3") in v5.15-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [399aa12450a61a5c73dc77e73f069ece9687c95d]
stable/6.18: [898cb4f2e12a5ddea1b2d821cc642c3100f46da7]
stable/7.2: [015fffa48e96ca8d73a627445341ccff86b02251]

CVE-2026-99114: ksmbd: initialize FileSystemControlFlags in
FS_CONTROL_INFORMATION

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99114

Introduced by commit e2f3448 ("cifsd: add server-side procedures for
SMB3") in v5.15-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c0cd3fc6824122014da2b3b0cb7ddeaa2946ec8e]
stable/6.18: [d8c450ad0d08980b39b08d435efa921086c8b227]
stable/7.2: [03bb4338c3a7c3fc4decf699a35753f0891aab2a]

CVE-2026-99115: ksmbd: fill in FileSysIdentifier in FS_POSIX_INFORMATION

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99115

Introduced by commit e2f3448 ("cifsd: add server-side procedures for
SMB3") in v5.15-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [db2267b27c054a6c2151ff7fbb67927e784f31d6]
stable/6.18: [beba2ef6f66a71f20531ac70a1acb0b221e362e9]
stable/7.2: [ab057f271ef60ff8163818badc3de75c480eca07]

CVE-2026-99116: net: psp: do not inherit the Rx association on clone

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99116

Introduced by commit 6b46ca2 ("net: psp: add socket security
association code") in v6.18-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1d2929d0850fff683b8aff051275945e65f082c8]
stable/6.18: [a9f14ea73e82db743f0acf4219f499d594589288]
stable/7.2: [c962695467d3ab9738a6508279827ec33a7d2bdf]

CVE-2026-99117: net: bridge: mcast: don't truncate the port group walk
on teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99117

Introduced by commit b081236 ("net: bridge: mcast: install S,G entries
automatically based on reports") in v5.10-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5a3f7a683aee56e1f15c9d53041f3236767eaae7]
stable/6.18: [8243d587a081e790ad96e80d48eef44d9f7ef005]
stable/7.2: [b45e8c24608c992d1e2cea047eb5bcbfa537f86b]

CVE-2026-99118: drm/i915/dmc: Harden DMC firmware payload parsing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99118

Introduced by commit eb80562 ("drm/i915/skl: Add support to load SKL
CSR firmware.") in v4.2-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8bb1858db453cd4250e3b633f5d2d09206024ca6]
stable/6.18: [dfcfe2874e7c16e8460dc86ac1eeb54ea0e7f8aa]
stable/7.2: [05f7a2f712f8b287a98ee61a7c2c6b72dad2fc6d]

CVE-2026-99119: drm/amdgpu/userq: actually validate userq BOs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99119

Introduced by commit 4cdbba5 ("drm/amdgpu: restructure VM state
machine v4") in v7.2-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [32d0771ef4ca69c30a1db3aefa34dd177cd2a047]
stable/7.2: [d1d6b859e89dd274cd0fae77503cdf91be8310c0]

CVE-2026-99120: KVM: x86/mmu: Cope with the SS bit being set in #NPF exit codes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99120

Introduced by commit 8db428f ("KVM: SVM: Enable shadow stack
virtualization for SVM") in v6.18-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e90ab3669181c6469e3647ef2b30ae408275f496]
stable/6.18: [0caeefed99b37f03251a00eb1fdb403a1cf2cb68]
stable/7.2: [d6e08ec2fff45e0ec69f11010851650d7c6282b9]

CVE-2026-99121: ipv4: avoid divide by zero in fib_rebalance

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99121

Introduced by commit 0e884c7 ("ipv4: L3 hash-based multipath") in v4.4-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5046d2880fec7d49ebed2fd2866747ee1d06ad71]
stable/6.18: [5dac5c7ba8f5f3fb4bf29f2a2c3cb552f5b83c8f]
stable/7.2: [d5520e815c4b1427104ce1428ee23821f2aa824d]

CVE-2026-99122: vsock/vmci: validate packet source for connected sockets

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99122

Introduced by commit d021c34 ("VSOCK: Introduce VM Sockets") in v3.9-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ad9a7da3fa39c2d616ec0dd3cf6e30531d032fe7]
stable/6.18: [c027f8b429dbb2157fc1b503df196e272d947c89]
stable/7.2: [90c423b62ec9be08177f74b07a47937ca8d2035b]

CVE-2026-99123: vsock/virtio: validate packet source for connected sockets

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99123

Introduced by commit 06a8fc7 ("VSOCK: Introduce
virtio_vsock_common.ko") in v4.8-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dee44f41f206becb41c492899c1996cfd7f82a1b]
stable/6.18: [6cd829de69efd9ed3a53aa2421004a0396eb2bd7]
stable/7.2: [e9bf92de436ba55f33eaa55d7008e68551123cfd]

CVE-2026-99124: s390/pci: Fix leak of uninitialized kernel data in SCLP report

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99124

Introduced by commit 368704a ("s390/pci: add report_error attribute")
in v4.7-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8ac60ae2a307a50b599bf5d300b448d638f3ba29]
stable/6.18: [ba5001db9bb23ff7d2ea328c405c287ffb07786f]
stable/7.2: [126a7c227d8543e13903dd5622640c1f0fcc5a16]

CVE-2026-99125: s390/pai: Handle multiple PMU stop callback invocations

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99125

Introduced by commit 9f66572 ("s390/pai_crypto: Enable per-task and
system-wide sampling event") in v6.11-rc1.
Introduced by commit 582cc1b ("s390/pai_ext: Enable per-task and
system-wide sampling event") in v6.11-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f3110e969ad226ffbb2d9b4bf5387e68d0d9ef40]
stable/7.2: [cf348ec613f75b9774291e47b804fd7010835a6c]

CVE-2026-99126: s390/ctcm: Prevent XID null dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99126

Introduced by commit 293d984 ("ctcm: infrastructure for replaced ctc
driver") in v2.6.26-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b264d8422779d69febce914efc47a92a85cc382c]
stable/6.18: [34fa3607b7604b3052b19cec8b0ad644818cdd2a]
stable/7.2: [8a2f7a4ad1d81612fa65bfa4d392ba1bb2f5eeab]

CVE-2026-99127: page_pool: keep frag_offset aligned for odd-sized requests

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99127

Introduced by commit 53e0961 ("page_pool: add frag page recycling
support in page pool") in v5.15-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dc0df5a0c62ccea1d0e08d39a4dc9064de81d411]
stable/6.18: [813a72beaa5d3f4bb135e0def9b3f07a3511ca0e]
stable/7.2: [dca1b51693c81eaf77e50980be373e01ae857394]

CVE-2026-99128: sctp: validate chunk length in the inqueue parser

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99128

Introduced by commit bbd0d59 ("[SCTP]: Implement the receive and
verification of AUTH chunk") in v2.6.24-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6cfc1b90cb86f4aabc69fb8e30128e07e2cdfa3a]
stable/6.18: [40507f59f230dcf60ae13cb48d34f8c6e9f40659]
stable/7.2: [9ac57e4c62e93c287b36080e5da3645690549990]

CVE-2026-99129: selinux: fix BPF token permission checks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99129

Introduced by commit 5473a72 ("selinux: add support for BPF token
access control") in v7.0-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [77d499e61d36e883a6ad1f10afe05f556aa7e0cc]
stable/7.2: [e1ef306ba20eb13099ca4463527890df67619405]

CVE-2026-99130: io_uring/cancel: don't spin on local work the task can't run

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99130

Introduced by commit 360cd42 ("io_uring: optimise
io_req_local_work_add") in v6.4-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fddcf4c5321b3ea5f72166c3fd36a9d1c34f80c7]
stable/6.18: [94d13387b96e50a4288f7bbdfe401189246a11a1]
stable/7.2: [3005459e0ddfcef0f555b6e81f672f2c49a1c0aa]

CVE-2026-99131: xfs: fix capability check in xfs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99131

Introduced by commit eba0549 ("xfs: don't generate selinux audit
messages for capability testing") in v5.18-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e2f62a9744ebad3bcb6347a648e615026e9efeff]
stable/6.18: [19a1a22029ad3ae3604c763af6bd1195cb73648f]
stable/7.2: [7809ac0161c7c5f52ed348fb1ec683b2b454a83e]

CVE-2026-99132: xfs: don't hold buffer locks across sync transaction
commit in xfs_sync_sb_buf

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99132

Introduced by commit f7664b3 ("xfs: implement online get/set fs
label") in v4.18-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [41a28c865d1d5843f8cb9e0af17a8f4d9e2961ff]
stable/6.18: [e5456dec79c71c8ef8f9f9adb77d320f113b34db]
stable/7.2: [6353e5cd8c43d6e805cacbfbfecf4103571a7ff8]

CVE-2026-99133: net/iucv: fix the recvmsg window update

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99133

Introduced by commit 3881ac4 ("af_iucv: add HiperSockets transport")
in v3.2-rc1.
Introduced by commit 238965b ("net/af_iucv: build proper skbs for
HiperTransport") in v5.2-rc6.
Fixed in v7.3-rc2.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [fa5acd038ea657ad5033713d6916214cbd349151]
stable/6.18: [8f2efa742f4cfe7dd756154f8bc07350dbe3ec92]
stable/7.2: [fe7393a627db2d093e8c0cae69d619b30fefae5f]

CVE-2026-99134: mac802154: fix data race and NULL deref on local->assoc_dev

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99134

Introduced by commit fefd198 ("mac802154: Handle associating") in v6.8-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c037915f80c4db47f7d061d68e703ffd551b1a34]
stable/6.18: [3cdd8b1abddebbae2582e90294c77b61d5f5aee7]
stable/7.2: [a585901bb8cd2cd60d678be8a56ca6a4e1a6946c]

CVE-2026-99135: dm-integrity: fix infinite loop on discard with large tag size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99135

Introduced by commit 84597a4 ("dm integrity: add optional discard
support") in v5.7-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [18d80c77b4c7dd20699e81cedfbbff4e9d198f28]
stable/6.18: [fc512700f1413fed652dac22fa1c4e837210b9c0]
stable/7.2: [251b44b424920df9204e88a81fb3f78fa48ddd99]

CVE-2026-99136: dm-crypt: fix a tiny race condition in crypt_dec_pending

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99136

Introduced by commit b35f8ca ("dm crypt: wait for endio to complete
before destruction") in v2.6.29.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [148845aa1921d95ef5dc851c76e6a284f6657df6]
stable/6.18: [ac5d887ab93592fc5e3605fe30c1d8d232d609b3]
stable/7.2: [4f16bb982b27b9f5a15301f622c318001fe521f8]

CVE-2026-99137: cifs: don't update i_size in cifs_do_truncate without
a cached handle

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99137

Introduced by commit 110fee6 ("smb: client: fix missing timestamp
updates with O_TRUNC") in v6.18-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fe39cd9d48f2346605f3746e0cc19e89d5f373eb]
stable/6.18: [04d020b3d0b58a1b7e116900e4095b96a7f4e11a]
stable/7.2: [88a51743cd8094b76fd910f53f718747c7729cc8]

CVE-2026-99138: tcp: fix use-after-free in do_tcp_getsockopt(TCP_CC_INFO)

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99138

Introduced by commit 0baf26b ("bpf: tcp: Support tcp_congestion_ops in
bpf") in v5.6-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [385e474086c2e7e29e2dded690be40dc273e20ee]
stable/6.18: [86814e5370068ec2bf0caa6e6d55c3e5bfc6c324]
stable/7.2: [39aa489e85752f9de214edb0f85e4d578e57af29]

CVE-2026-99139: tcp: fix use-after-free in do_tcp_getsockopt(TCP_CONGESTION)

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99139

Introduced by commit 0baf26b ("bpf: tcp: Support tcp_congestion_ops in
bpf") in v5.6-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5271b79b7ad68dcb222e893773f92bdabf7750f3]
stable/6.18: [c1804ef016392dd91267d2207ee43b1de34302ca]
stable/7.2: [a8e45471afa230c1431c26c8e99ec24377e3b514]

CVE-2026-99140: tracing: Fix hist trigger timestamps for buffered events

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99140

Introduced by commit b94bc80 ("tracing: Use a no_filter_buffering_ref
to stop using the filter buffer") in v5.13-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9414ca3b99e5a7f1f3bf51c2a01b383e1b355dd0]
stable/6.18: [09c7cce2e59e6b3b1807520bcb1980c561f15d1e]
stable/7.2: [89e90b16aadd6e66bd0323bc8dfc76a62e756b57]

CVE-2026-99141: tracing: Fix crash in print_graph_function_event()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99141

Introduced by commit e29aa91 ("tracing: Have function graph tracer
define options per instance") in v6.19-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3cc117514d69067a94d6c7479730dce41e678f50]
stable/7.2: [b1547c6ba93b8863010aa324cd20c441f886f23e]

CVE-2026-99142: tracing: Check operator stack capacity before pushing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99142

Introduced by commit 39f7c41 ("tracing/filters: Enable filtering a
cpumask field by another cpumask") in v6.6-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c47a7b11bcb3d45e29723afcf6336866476b1d08]
stable/6.18: [a866a8a753922cdf7710b8eb3f686dc0efc06505]
stable/7.2: [75e894f92417390f0ef44fd350f2d3634c784876]

CVE-2026-99143: tracing: Keep the predicate limit separate from program capacity

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99143

Introduced by commit 39f7c41 ("tracing/filters: Enable filtering a
cpumask field by another cpumask") in v6.6-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [803aa6fc2dbea25ab9d3ed19eca1c96d0ab17445]
stable/6.18: [2058a1fe791bb30fd6e4875a7ada3237076c8541]
stable/7.2: [68ecc9510bb82dd78585c02bd5357f34ee16b153]

CVE-2026-99144: sched_ext: Fix use-after-free of a destroyed user DSQ
by a deferred reenqueue

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99144

Introduced by commit 84b1a0e ("sched_ext: Implement
scx_bpf_dsq_reenq() for user DSQs") in v7.1-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [069403dff337feb192bfc70fb28ddc8a171e20c1]
stable/7.2: [633f586329bfd9843bf8acf86c95353f4c16e22d]

CVE-2026-99145: drm/xe: Don't transfer shrinker pages for pinned bos
on purgeable state change

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99145

Introduced by commit 536a2ea ("drm/xe/bo: Add purgeable shrinker state
helpers") in v7.1-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ffbfd3f98f4393e91dffce3a46ccb7cf5329cf2f]
stable/7.2: [135e998dd1e66b8854db7bd356b6563baf8b9d51]

CVE-2026-99146: drm/i915/dmc: Add sanity check for DMC load address

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99146

Introduced by commit 3d5928a ("drm/i915/xelpd: Pipe A DMC plugging")
in v5.15-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7dedc5bb11f95e96fe80757c924d8d9aa7327759]
stable/6.18: [ef82b4d5cb4a3fe77c7f99008d78b8c64709e258]
stable/7.2: [2fbd099b4e7c8c4ff70033c5bb950cdbb20838e2]

CVE-2026-99147: drm/exec: don't immediately add prelocked obj to array
of locked objs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99147

Introduced by commit 0959321 ("drm: execution context for GEM buffers
v7") in v6.6-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [26401a4999f1596a515b2e704e7066ac09306488]
stable/6.18: [96d9996e5dbcfabed052c0d9377a382c95fed607]
stable/7.2: [7a10cd79c4d9a90334fece32fef3a8e5b1a9727b]

CVE-2026-99148: drm/amdgpu: keep the eviction fence until the last
handle is closed

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99148

Introduced by commit 31f7efc ("drm/amdgpu: enable eviction fence") in v6.16-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3c44cbcec5eb370713bbd2c315ed7c34d8ccec2b]
stable/6.18: [dce8f7f03a47b1744dccf506268f9229b67fab47]
stable/7.2: [6467c4cc83b94850bfea614e9f98276edf9a7c3f]

CVE-2026-99149: drm/amdgpu: fix GEM object leak on ENOMEM in userptr ioctl

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99149

Introduced by commit e095b55 ("drm/amdgpu: use user provided hmm_range
buffer in amdgpu_ttm_tt_get_user_pages") in v6.19-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3c516a5646285442e1cd71dff2584b77eb4fc421]
stable/7.2: [64a6d40156ae98caafc922c6d79fe202b0acd836]

CVE-2026-99150: drm/amdgpu: don't drop the runtime PM reference twice
in amdgpu_gpr

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99150

Introduced by commit 9eee152 ("drm/amdgpu/debugfs: fix ref count leak
when pm_runtime_get_sync fails") in v5.9-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [de9f6bcdb44f0e410031002e2f103826ea6b6259]
stable/6.18: [652b1f26125fe48aed5f4944698a85b457eef491]
stable/7.2: [253555a9baccefffe1f6e5f2fe54363c7c01ebb9]

CVE-2026-99151: drm/amd/display: Fix NULL sink dereference in USB4
bandwidth functions

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99151

Introduced by commit 8fa813b ("drm/amd/display: Remove sink usage from
DPMS") in v7.3-rc1.
Fixed in v7.3.

Bug introduced commit was backported to following branches.
stable/7.2

Fixed status
mainline: [55a67aa89342545b89f469dea6f29bfb6fac6f3d]
stable/7.2: [4c8b5e5b9776ad08138d79b14238c5742b32911b]

CVE-2026-99152: scsi: libiscsi: Validate the task named by a management response

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99152

Introduced by commit 7996a77 ("[SCSI] iscsi: add libiscsi") in v2.6.20.16.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [11bffcd9cb346732eab2914ef44fe777a3f0b585]
stable/6.18: [55a65ef61e2775aeb18fda63bd1959fa8b41f936]
stable/7.2: [f721487523d45941aed4b0ac8d829b0461a7d860]

CVE-2026-99153: scsi: libiscsi: Validate the ITT reflected in a Reject PDU

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99153

Introduced by commit 8afa143 ("[SCSI] libiscsi: handle immediate
command rejections") in v2.6.32-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c5958c770b2a0ee492414e26b07da9164a0d1f5d]
stable/6.18: [7215a69b6456fda79c0935c2959045dff3fcaac8]
stable/7.2: [d79343ae3223b3f7f74b55e79f8a1371fa3f4b1a]

CVE-2026-99154: scsi: libiscsi: Reject a negative task index from parse_pdu_itt

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99154

Introduced by commit bfead3b ("[SCSI] be2iscsi: Adding msix and
mcc_rings V3") in v2.6.33-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8ee2a09a1dbb257c9e828ad2497f8e4832dfb142]
stable/6.18: [6cadfa6f1f5896632d4223d3b7addb2a29fea74e]
stable/7.2: [35b60549a956237488c89a2d85352e026e7d55b7]

CVE-2026-99155: scsi: xen/scsifront: Check for a NULL shadow entry on
a backend response

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99155

Introduced by commit 6d1c2f4 ("xen/scsifront: harden driver against
malicious backend") in v5.19-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8c8222c255772713eb36cde695777a1fce224917]
stable/6.18: [1d91ec793d6c80eca963d426e0da832d40a062df]
stable/7.2: [15791e57f57f7050014d08cfe239d4aa1e6b94b0]

CVE-2026-99156: scsi: st: Fix use-after-free race between st_remove()
and st_open()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99156

Introduced by commit 6c648d9 ("[SCSI] st: get rid of scsi_tapes
array") in v3.7-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [71caf7f84bd62a4bf91cc95abd2de690afb8d15f]
stable/6.18: [a1647b653549ff29f0422a63eabf329b842f3822]
stable/7.2: [18a0e3733ce38718688e813e5e2d1106bd4830e5]

CVE-2026-99157: scsi: bsg: Pass reply_len to bsg_setup_queue() to fit
UFS ARPMB replies

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99157

Introduced by commit 6ff265f ("scsi: ufs: core: bsg: Add advanced RPMB
support in ufs_bsg") in v6.3-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ec6b083915e8146e147314a5f4f1285d07b57bfc]
stable/6.18: [2effbe746452c108188f85a6951f2b0b65653840]
stable/7.2: [7a755f6d47b811d3abd93c1642ce5e63894540b8]

CVE-2026-99158: ring-buffer: Fix false warning in ring_buffer_map_get_reader()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99158

Introduced by commit 117c392 ("ring-buffer: Introducing ring-buffer
mapping functions") in v6.10-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [89bab1dba8a0167ef0d819e0f55b6bafa038e87f]
stable/6.18: [029770f5badedc0f0ff85fc45e24785cbbee4a67]
stable/7.2: [68e6ab180cfb6dfa79652f41ed7899a6d4cf5438]

CVE-2026-99159: ring-buffer: Fix the sub-buffer array base in
rb_meta_subbuf_idx()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99159

Introduced by commit b14d032 ("ring-buffer: Add ring_buffer_meta
data") in v6.12-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [25132363c723afc39aace8b098f547ab4a0ea759]
stable/6.18: [2f1248b728b56d583ea454fedf239550c49f7b18]
stable/7.2: [7469b3585ef5f65840d467d2caa811a9098c84b9]

CVE-2026-99160: ring-buffer: Do not show buffer_meta for CPUs without a buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99160

Introduced by commit 950032f ("ring-buffer: Add output of ring buffer
meta page") in v6.12-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f23cae09a4677a3f7c163a68388512cb231ff22]
stable/6.18: [8512d0312cc0ea83ca4511b164c29a138bbb0c21]
stable/7.2: [ae670c1a24fb5ffb167f26358cf47a5f0abbd670]

CVE-2026-99161: i2c: viai2c-wmt: Fix clock leak in wmt_i2c_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99161

Introduced by commit 560746e ("i2c: vt8500: Add support for I2C bus on
Wondermedia SoCs") in v3.11-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aaabefc79b0ff0018e8e3832169bbe359d0551fc]
stable/6.18: [5d476bb76b7d72d8b7ed04a9c614900b097e3af7]
stable/7.2: [1875de656370c89b99a150d220df876288ee0344]

CVE-2026-99162: gpio: shared: fix use-after-free bug when adding shared proxies

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99162

Introduced by commit a060b8c ("gpiolib: implement low-level, shared
GPIO support") in v6.19-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bd22f7e63509fa758cf500d9af3e88a3d3df96be]
stable/7.2: [8861491f8501516429e0e6c9d7a056480047227c]

CVE-2026-99163: tracing/histograms: Reject non-stacktrace fields for
synthetic stacktrace fields

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99163

Introduced by commit 00cf3d6 ("tracing: Allow synthetic events to pass
around stacktraces") in v6.3-rc1.
Fixed in v7.3.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/6.1

Fixed status
mainline: [a244c241593b5b38a08f0df2cb43c26574efbdcb]
stable/6.18: [1f36e4ddd05d540f363dbaa4c23042549f15b3ef]
stable/7.2: [deb336ae7c7b341591a6862cf6fcfeca97c77dfd]

CVE-2026-99164: spi: imx: fix slab corruption from undersized DMA bounce buffers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99164

Introduced by commit faa8e40 ("spi: imx: support dynamic burst length
for ECSPI DMA mode") in v7.0-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [59eb22641f0c526dd064390b11cff99ae87c2858]
stable/7.2: [2777f6637da02da84c9c1ff92f413ce0f0995084]

CVE-2026-99165: sctp: revalidate output stream after association connect wait

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99165

Introduced by commit 668c9be ("sctp: implement assign_number for
sctp_stream_interleave") in v4.16-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b7ad72414c673ce1fa1f463e807cd4f34f8be9bf]
stable/6.18: [77a63d1b813b08c4e5a948f5e04fbaca6176aa8f]
stable/7.2: [fd56ac95ec31a05b66e8938debfa847f49c0e993]

CVE-2026-99166: net: rds: fix uninitialized trans dereference in CM
event handler

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99166

Introduced by commit dcdede0 ("RDS: Drop stale iWARP RDMA transport")
in v4.6-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [492ba6ac1b1ffb8a06ff52db0825c1af2cdb28c8]
stable/6.18: [5f23e4e3a31dacfd82a8f56be253adc0910ee84f]
stable/7.2: [ca14c289ed9ffed6cc64290d039e923e5720a8bf]

CVE-2026-99167: net/sched: fix use-after-free in __tcf_action_put()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99167

Introduced by commit 16af606 ("net: sched: implement reference counted
action release") in v4.19-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7b16eb911091aae237a8673da94e4dfb9cd21d54]
stable/6.18: [2465d27ef90de9105c2bffb6c35f8ce08918e642]
stable/7.2: [2e012e431aa271ef3c84206f48854f539c03bff0]

CVE-2026-99168: mshv_vtl: Check per-CPU register page before mmap

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99168

Introduced by commit 7bfe3b8 ("Drivers: hv: Introduce mshv_vtl
driver") in v6.19-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [874194a8de75fc2f4d1fb70c670b289b7e48f93e]
stable/7.2: [5c0757b065fbd140d8fbd05dc2c2146b713dfa68]

CVE-2026-99169: futex: Fix mm reuse handling for FUT_OFF_MMSHARED

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99169

Introduced by commit 2229933 ("futex: Remove pointless mmgrap() +
mmdrop()") in v5.7-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3267512ad1c2cc0c7768c5b014dc2cceb398a801]
stable/6.18: [c17cc2027773e8e4913c5ab0fe3a489b1ed5bf81]
stable/7.2: [2855ddc6844f527e375e78afb55ec2a5182f23b3]

CVE-2026-99170: namespace: a mount that copy_tree() leaves out can't
take over a lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99170

Introduced by commit c62a476 ("move_mount: transfer MNT_LOCKED") in v7.1-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [69fbe94f80bc423613fa18dae6656757423732a2]
stable/7.2: [bd71d33923b9d6216bcee44331dd37142b0a8441]

CVE-2026-99171: ntfs3: free the sbi after a grace period

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99171

Introduced by commit a3a956c ("fs/ntfs3: Add option "nocase"") in v6.2-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c01b091b06412d3b1b53d8c2925f6de586c8a2fc]
stable/6.18: [c8b1a4840467930e01f1a9374d991d7a8a2896c1]
stable/7.2: [7abecef26a9be8f9de70659a3092250461a52072]

CVE-2026-99172: ipc: drop the mqueue mount with kern_unmount() on setup failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99172

Introduced by commit dc55e35 ("ipc: Store mqueue sysctls in the ipc
namespace") in v5.19-rc1.
Introduced by commit 7229d74 ("ipc: create_ipc_ns: drop mqueue mount
on sysctl setup failure") in v6.19-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f0e48172a59e517e613b73f73cc35f24fd123aeb]
stable/7.2: [c0620b648321fff654173d238d4a85298ea16d05]

CVE-2026-99173: eventfs: Free the eventfs_inode after an rcu grace period too

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99173

Introduced by commit 8e55643 ("eventfs: Use SRCU for freeing
eventfs_inodes") in v6.11-rc3.
Fixed in v7.3.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [2cd88c498ecff8e22bf4c397b8eb226db70ac343]
stable/6.18: [4586ef24ce390e8becb9f3e5852d5d3978b01c33]
stable/7.2: [45fcfd5d9c10e0aa977ed5b9bd445707e01bb107]

CVE-2026-99174: ext4: free the sbi after a grace period

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99174

Introduced by commit 6493792 ("ext4: convert symlink external data
block mapping to bdev") in v5.19-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c17b44266a1f9fcb49b894d4611d1254bf1aa313]
stable/6.18: [80d5db1686b05fad6f384be017714297d828a714]
stable/7.2: [87d29b8b849738d52fe820d495fa0aa2d5a1ec82]

CVE-2026-99175: fsnotify: prevent mark additions during connector teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99175

Introduced by commit 6b3f05d ("fsnotify: Detach mark from object list
when last reference is dropped") in v4.12-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [36ebddca56b9d8993d6dc984fdecc748ee1f5e06]
stable/6.18: [952501bfc6e5e654ac4a17ec9d90c1ec614bd9f1]
stable/7.2: [472589eacdf10b5f9bd10b333957ed5291b2544b]

CVE-2026-99176: KVM: nVMX: Reset MMU back to the root MMU if loading
L2 state fails for !VM-Entry

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99176

Introduced by commit 72e9cbd ("KVM: nVMX: fix SMI injection in guest
mode") in v4.15-rc1.
Introduced by commit 8fcc4b5 ("kvm: nVMX: Introduce
KVM_CAP_NESTED_STATE") in v4.19-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c8f4cfe1cf93bce924e27f2abead7a4c4a487505]
stable/6.18: [d00d5f534a8238674755e59826a6c7d3c8efb870]
stable/7.2: [c9716f956216eb74ab0aad7f633586edd49e0322]

CVE-2026-99177: KVM: SEV: Fix page dirtying in sev_gmem_post_populate()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99177

Introduced by commit 97cd21d ("KVM: SEV: Mark source page dirty when
writing back CPUID data on failure") in v7.2-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [97818b2fa7082e940ddd36dab12a68615300e798]
stable/7.2: [184382f9852d433af21de96c334ecf43b8414ed8]

CVE-2026-99178: x86/kvm: Don't consume async #PF flags on a kernel #PF
in NMI context

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99178

Introduced commit is not determined.Fixed in v7.3.


Fixed status
mainline: [81d99abe2bd81379abfb595e403bbbee6fbfc624]
stable/6.18: [b77e9622bbade9812e2090c66d25c372f515e921]
stable/7.2: [f45ee1ff6358a22d7e22a4c53cb3148ea97b10d9]

CVE-2026-99179: watch_queue: Fix note pool publication race in
watch_queue_set_size()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99179

Introduced by commit c73be61 ("pipe: Add general notification queue
support") in v5.8-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5e531d62f1f8834faf7a4eed0d41105cf6570a8f]
stable/6.18: [811fb6d0b07605e8e8d93bde8748be4b3028809a]
stable/7.2: [9e73a6754457ffed8399b835552013b9363e51d1]

CVE-2026-99180: unicode: free the map after a grace period

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99180

Introduced by commit b886ee3 ("ext4: Support case-insensitive file
name lookups") in v5.2-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a96c5299bd7305eb984377681eb3222a57376405]
stable/6.18: [2b54d3c971a1e5df3c9b0bcc10311ae6c29e79d8]
stable/7.2: [6560c3d9a6925e3747d9ad8463e16010c31ba715]

CVE-2026-99181: autofs: ignore notification errors from a replaced pipe

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99181

Introduced by commit 8d7b48e ("autofs4: add miscellaneous device for
ioctls") in v2.6.28-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [65676cd4203c0e41a94caf54080a7f0a95434bda]
stable/6.18: [1a177064f501ed4b67873a43aae5d5bdb18b3704]
stable/7.2: [fb296391f685d82dbb93621a970fb234cea45280]

CVE-2026-99182: ASoC: SOF: ipc4-topology: Fix shift-out-of-bounds for
aggregated ALH capture

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99182

Introduced by commit 0390a10 ("ASoC: SOF: ipc4-topology: use different
channel mask for each sdw amp feedback") in v6.3-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [746de48c3a250f0c264105dcbfcdf0c5001e970b]
stable/6.18: [cad63a7798d6a6cac1fc68732595f0a3278ff6f0]
stable/7.2: [5e1322787c5e424a570e87c8c2c25e37552cbe3b]

CVE-2026-99183: accel/rocket: search every core slot when looking up a scheduler

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99183

Introduced by commit 0810d5a ("accel/rocket: Add job submission
IOCTL") in v6.18-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [89c2c777df17eb0201c8e22afabbf3691f2a28fe]
stable/7.2: [c137756469d5bcc79e97beb406ae4d14b9585463]

CVE-2026-99184: accel/rocket: search every core slot when a core is removed

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99184

Introduced by commit ed98261 ("accel/rocket: Add a new driver for
Rockchip's NPU") in v6.18-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6eff1d69dae808a1518aee5a58d0853a8db3f1be]
stable/6.18: [5078c91f5c84bb383d0a10ed39856f98575e39cf]
stable/7.2: [134451cf95cb6aa04b725fbfa04e878d072756f5]

CVE-2026-99185: firewire: core: fix race condition in split transaction handling

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99185

Introduced by commit fa2dc27 ("firewire: core: code refactoring to
find and pop transaction entry") in v6.19-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7f9f2d6abc40f79e802b4063859eda343043b85c]
stable/7.2: [a8caee0e623ca5d56e829032f9ec073c09e4d224]

CVE-2026-99186: x86/insn-eval: Fix shadowed segment index in
get_seg_reg_override_idx()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99186

Introduced by commit 45e1dcc ("x86/insn: Simplify
for_each_insn_prefix()") in v6.19-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [32c52ec87d6245ee2d12ed5dd509e40062939b50]
stable/7.2: [0efe927053f7eabd1e8658cbda96ee3d78bd1765]

CVE-2026-99187: perf: Fix perf_pmu_migrate_context() leaving events behind

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99187

Introduced by commit bd27568 ("perf: Rewrite core context handling")
in v6.2-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e76b36b4be7160eaa14b416681e548b125702395]
stable/6.18: [3eb08f09bfb364051f51316da873c3bd51a839ef]
stable/7.2: [f5f0028764de322a3d04eda0d3b6389ca9847446]

CVE-2026-99188: net: stmmac: dwmac1000: clear the RGMII status interrupt

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99188

Introduced by commit 2e2c878 ("net: stmmac: remove SGMII/RGMII/SMII
interrupt handling") in v6.19-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aa07285705f8d5bac464eb1c5b7412f8e88b91e1]
stable/7.2: [affc6d572935282ef9ab1e0b790cbc31e5ad8bca]

CVE-2026-99189: gpio: mxc: fix race between chained IRQ handler
install and probe completion

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99189

Introduced by commit 5f6d199 ("gpio: mxc: release the parent IRQ in
runtime suspend") in v6.6-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [38d44f78f041ffe60c8e2443b99434a199e7541d]
stable/6.18: [261802c14e1a3281987ea8f106701e5ed9652f68]
stable/7.2: [6c1e035d881579a6e4ed1ce5feabb13d23e80a82]

CVE-2026-99190: gpiolib: fix memory leak in
gpiod_set_array_value_complex() on error paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99190

Introduced by commit 9b40731 ("gpiolib: rework the wrapper around
gpio_chip::set_multiple()") in v6.15-rc1.
Fixed in v7.3.

Bug introduced commit was backported to following branches.
stable/6.12

Fixed status
mainline: [c28846ca1ac6134881114d272314623c8433e372]
stable/6.18: [78189c0e35abbcdab3b8ab0b764d578c02900734]
stable/7.2: [890c3bf08e0fc09eff788a6cfeded7d21b4d3e9d]

CVE-2026-99191: calipso: keep BIG TCP payload_len in calipso_skbuff_setattr()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99191

Introduced by commit 81fbc81 ("ipv6/gro: insert temporary HBH/jumbo
header") in v5.19-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8070ed578b6b9134e045627fb745c887a806d46e]
stable/6.18: [1c9fcfca51e3c5cd46dd72a4da74d56eff183513]
stable/7.2: [8ee0e03663826a76507048d58466b29321a57656]

CVE-2026-99192: net: bcmgenet: unshare the skb before writing the control block

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99192

Introduced by commit f48bed1 ("net: bcmgenet: Free skb after last Tx
frag") in v4.13-rc2.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [89771ce4f8f67dcffae561b2ccac95c0f6e3aa01]
stable/6.18: [40c04abcbc34e3afe338f41dae851ecbd72852ac]
stable/7.2: [7939ad3b4db9eadf45a64f0524f38337a9494672]

CVE-2026-99193: net: ti: icssm-prueth: Move setting of netops to fix crash

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99193

Introduced by commit ded86da ("net: ethtool: relax
ethnl_req_get_phydev() locking assertion") in v7.2-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [955bb7cf680d8699ce94c73539af882840a9be43]
stable/7.2: [e7694aab7ad002480ed9d534bd8d6bc28b798d8a]

CVE-2026-99194: net: ethernet: aeroflex: move setting of netops to fix crash

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99194

Introduced by commit ded86da ("net: ethtool: relax
ethnl_req_get_phydev() locking assertion") in v7.2-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d71483f0716e7ae98578817bfdc8a5b822d250f8]
stable/7.2: [5293e376e9d6cdb945db11f71821bb57d415631d]

CVE-2026-99195: net: ethoc: move setting of netops to fix crash

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99195

Introduced by commit ded86da ("net: ethtool: relax
ethnl_req_get_phydev() locking assertion") in v7.2-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c9f8ce62a5faa73515ff5457716bd7306d20fd93]
stable/7.2: [c51b13299b4d45226efb09e532fb33e7109f78d7]

CVE-2026-99196: net: au1000: move setting of netops to fix crash

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99196

Introduced by commit ded86da ("net: ethtool: relax
ethnl_req_get_phydev() locking assertion") in v7.2-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [beabbafdd0f6779813a7656baa1b412b19bda911]
stable/7.2: [cfc11024fc061bf36044b40de9ecab57ed0a537d]

CVE-2026-99197: net: mv643xx: move setting of netops to fix crash

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99197

Introduced by commit ded86da ("net: ethtool: relax
ethnl_req_get_phydev() locking assertion") in v7.2-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a3eef3d2cca032d8768b5eb07aab0f46b79bfd8a]
stable/7.2: [bfb1ca89e9f6efa26c8a4a5b9de46541a222abc9]

CVE-2026-99198: net: ethernet: actions: Move setting of netops to fix crash

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99198

Introduced by commit ded86da ("net: ethtool: relax
ethnl_req_get_phydev() locking assertion") in v7.2-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c2c4824319850c87e77d26aeb8f860bc310a64d7]
stable/7.2: [d2eca3a54f415081711cd102d0db733de5abf170]

CVE-2026-99199: net: hisilicon: hip04_eth: Move setting of netops to fix crash

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99199

Introduced by commit ded86da ("net: ethtool: relax
ethnl_req_get_phydev() locking assertion") in v7.2-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0d9342701f14ec0a9465772b7cd5d515c1ecd818]
stable/7.2: [1c2f9c3a63baabfb965a23a00f026f3ddcaadb24]

CVE-2026-99200: net: hisilicon: hisi_femac: Move setting of netops to fix crash

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99200

Introduced by commit ded86da ("net: ethtool: relax
ethnl_req_get_phydev() locking assertion") in v7.2-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [444889dfa27b54b39026e962464b1f8f9093e1ea]
stable/7.2: [06ef5b084b150c538bc84148e5d710eee012413c]

CVE-2026-99201: netlink: avoid hashing the network namespace pointer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99201

Introduced by commit c428ecd ("netlink: Move namespace into hash key")
in v4.1-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f88bb3606e4bd11ee035b682cddc2999e604609a]
stable/6.18: [bdd55b8a8acbf6b4840ab420eb6a63774bf4593b]
stable/7.2: [078deff25f8a849ecd1c3fe17b1e473b1cf44f28]

CVE-2026-99202: scsi: libsas: Fix SMP IO deadlock during HA resume

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99202

Introduced by commit 3dbbbf6 ("scsi: libsas: Fix HA resume deadlock
and hisi_sas disk-wake race") in v7.2-rc6.
Fixed in v7.3.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [81e097a064b28b4a1f6ca1a8b433e659c1bd64c0]
stable/6.18: [c9fb89246d9922ac0a45d504adb03e0bb971310c]
stable/7.2: [08b95ef36a64c3ae4490794bed3c35d0c3354e85]

CVE-2026-99203: pipe: preserve existing fasync readers on writer setup failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99203

Introduced by commit 7639842 ("Move FASYNC bit handling to
f_op->fasync()") in v2.6.30-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [40bb03d3ea6f6a915218508819ecc4d7a7fa260d]
stable/6.18: [4c42ce499ce4b1c787e61082e3b13df4f30c4eaa]
stable/7.2: [2259809e5b7043c4ba20af7b14ba3e471cf55521]

CVE-2026-99204: ocfs2/dlm: Protect the recovery list during debugfs reads

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99204

Introduced by commit 007dce5 ("ocfs2/dlm: Dump the dlm state in a
debugfs file") in v2.6.26-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4c435828932bf46f29860e4a0375bcae101b778a]
stable/6.18: [04d4571c00db61a9664f387752fa05cb3c08a537]
stable/7.2: [2bc426a32bfb78868c7f76d9547132837b6b5284]

CVE-2026-99205: sched/core: Call wakeup_preempt() for queued tasks
during class change

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99205

Introduced by commit 7040696 ("sched/core: Rework
sched_class::wakeup_preempt() and rq_modified_*()") in v7.0-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [118a2cf4ced60777a2408001e2b4838fed1cea55]
stable/7.2: [ae89744c5ebf299bf55ac7581768fbd9f119a903]

CVE-2026-99206: scsi: target: iscsi: Fix race in discovery auth updates

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99206

Introduced by commit e48354c ("iscsi-target: Add iSCSI fabric support
for target v4.1") in v3.1-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e15b81f602edbdee39c335546f25486a1747f3f0]
stable/6.18: [9b07828b133b326cb4fb59f144ca37f8db535999]
stable/7.2: [6caa2b3edb7da4f50a38e16561b75fcae21d4099]

CVE-2026-99207: scsi: target: Disable interrupts while holding delayed_cmd_lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99207

Introduced by commit 0693306 ("scsi: target: Add support for
completing commands from backend context") in v7.1-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [04a67a8b1a4460345d22fe75d93430cbf7e651d7]
stable/7.2: [7563650522732041ccfb2e4593878b5ea98d498c]

CVE-2026-99208: drm/xe/oa: Zero OA buffer at allocation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99208

Introduced by commit 392bf22 ("drm/xe/oa/uapi: OA buffer mmap") in v6.11-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fd8662823caa114a63f07222d2aa448f6ac5e864]
stable/6.18: [21f41b6daf0dbe2cdaaf9f54af6e23fd3c9190b9]
stable/7.2: [cd3e2918c247db631d88cdd704596d9d27e5513e]

CVE-2026-99209: drm/xe: skip eviction of a BO with no resource

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99209

Introduced by commit dd08ebf ("drm/xe: Introduce a new DRM driver for
Intel GPUs") in v6.8-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [448e76cbdc6652ccd3ba337b7a6e1f028859f2ed]
stable/6.18: [6046bb9cb2859e3d9bf939e4d6527f3827e1096f]
stable/7.2: [b6499d19ade1f1e4a1e6b739abc8c815297c98b8]

CVE-2026-99210: accel/rocket: clear rdev on device init failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99210

Introduced by commit ed98261 ("accel/rocket: Add a new driver for
Rockchip's NPU") in v6.18-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4ac852419f0d317c7bd8db5b8acb3cc78be7fe33]
stable/6.18: [79071b67182e1b352d51a3917729b8d424710b49]
stable/7.2: [dd47a6c920083b069f00f0920e4566915a6aec46]

CVE-2026-99211: netlink: reset skb headers before unicast and
multicast filtering

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99211

Introduced by commit b1153f2 ("netlink: make socket filters work on
netlink") in v2.6.26-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8bf659bd54e1f00e34cf5244b1d289c506fa47c0]
stable/6.18: [06791594274f87c29f1a9f1961d700272716a49d]
stable/7.2: [06935da5de83aa8b98841563894857e7d2f80e47]

CVE-2026-99212: net/rds: don't let the rdma_cm destroy an id RDS still
owns on route failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99212

Introduced by commit 55b7ed0 ("RDS: Common RDMA transport code") in v2.6.30-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [98d446b7c013254a8a7b49720557676a3a851fde]
stable/6.18: [a7c7d0ff876377fea7ae876a28d6df8d9349df57]
stable/7.2: [91ece3efa064f0b3b3c67b9b045d9eeb4a034e43]

CVE-2026-99213: vsock: treat TCP_CLOSING as once-established

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99213

Introduced by commit d021c34 ("VSOCK: Introduce VM Sockets") in v3.9-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4f6ac74fa594a918d41255c941256e1d51592d3b]
stable/6.18: [c2c5359ef2c33684fa3f3652fd761a483db8d1e7]
stable/7.2: [44d1ca05d6094a5d75c671a0545249186d790b8d]

CVE-2026-99214: drm/vc4: hdmi: Move packet RAM enable to PM runtime

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99214

Introduced by commit b47a72f ("drm/vc4: hdmi: Switch to HDMI
connector") in v6.11-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f57b34485dc01e5a2db60a89a6ae5439a897e53]
stable/6.18: [6b03e354526f6bad60ed3a7f08fec8b7d29d2f27]
stable/7.2: [6a987992c78e2e04f71e685d1c589f8ea2151fa2]

CVE-2026-99215: power: supply: core: prevent unregistering a power
supply while a callback runs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99215

Introduced by commit bc15405 ("power_supply: Add API for safe access
of power supply function attrs") in v4.1-rc1.
Fixed in v7.3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5b4bd13e0552926648a46c2c9a12a24dfaee3715]
stable/6.18: [2ac0256a28e15c4888fa394d1fe66cf7b1d58090]
stable/7.2: [45388e50d14bc161873b14b9a05d4b8b8822fca6]

CVE-2026-99216: Drivers: hv: Don't reset VMBus connection state on
error/exit paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99216

Introduced by commit 74347a9 ("x86/Hyper-V: Unload vmbus channel in hv
panic callback") in v5.7-rc2.
Fixed in v7.3.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [ec31dc39e835ccde0930daccece8c492d28282fc]
stable/6.18: [f47ce27af80b87cc684d5c12b65506af498ac7e5]
stable/7.2: [3195546a377c2d8d176d837e8baad5ce15d11195]


* Updated CVEs

CVE-2025-71312: fs/ntfs3: fix ntfs_mount_options leak in ntfs_fill_super()

stable/6.18 was fixed.

Fixed status
stable/6.18: [d977b979081ef2585a15453f309a6311c95ede02]

CVE-2026-23353: ice: fix crash in ethtool offline loopback test

stable/6.18 was fixed.

Fixed status
stable/6.18: [a4c584ea79d958ea1cadc9ce056f6df58a363342]

CVE-2026-31775: ALSA: ctxfi: Don't enumerate SPDIF1 at DAIO initialization

stable/6.18 was fixed.

Fixed status
stable/6.18: [7fca3600e79e9f8bac1ebc10af9ff20a35d6cccb]

CVE-2026-72453: regcache: Do not overwrite error code when finalizing
cache after error

stable/6.18 was fixed.

Fixed status
stable/6.18: [bae057687f61580dd897411cd749da22a7740647]

CVE-2026-98166: drm/ttm: fix swapped-out resources never leaving their
bulk_move range

stable/6.18 was fixed.

Fixed status
stable/6.18: [b48ebe399b4e72baa323462580fdd83ebda561e1]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com
