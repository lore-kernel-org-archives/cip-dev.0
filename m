Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA7CC00528
	for <webhook@archiver.kernel.org>; Mon,  7 Aug 2023 16:27:23 +0000 (UTC)
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
 by mx.groups.io with SMTP id smtpd.web11.39209.1691425634903745862
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 07 Aug 2023 09:27:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=l6oHfqMB;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.166.173, mailfrom: bot@kernelci.org)
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-34928e9f24bso15970195ab.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 07 Aug 2023 09:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691425633; x=1692030433;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zxxJDDD2AXAL3QHgq+lIQwJM7sVXg6Ga+nZVpEOYYVA=;
        b=l6oHfqMBCfsqHoLej5NOTsc6qRalKcFY8HE+urWci0wJp+DgIethiVGRqE2evelJgY
         bFflKzqqybqwbJwNBsCrcCN2r/SdC+E9aeyCSOwnucgthlJ55cVD4uXXayvF3eRMsmd4
         xHlpLS/zu56vCAdjYChcHWhNufsZD3g1vRsZgbWrUHWdpdWTVSYgkb6DEL/yqxyOzBLv
         mUzx6dPCx3YO11XU10jknhccOMyspDdFxca4yXnIFL8fQjEjM2djYqEbxLRQiE20R7MF
         6NfyUWJywUBBIilJcAQHfU+uGPlXVhkzvNy7Y9PkW0Id1f2I5FP/sjNXHQchhume6t4y
         iT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691425633; x=1692030433;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zxxJDDD2AXAL3QHgq+lIQwJM7sVXg6Ga+nZVpEOYYVA=;
        b=M3sZfLJyz7uAI12+X6lqmmZFryHL8Tx0Qc1WRApmfpvCPLBZM9mS1vPlVjneR/8EMm
         54WnNFl5WvWxnkEXw1NWuk2hTKuMAU0Tam62e5GYOwxe+8xjKBw3hEpfr2RaiV8AsTcI
         4Bt+pQzdSP0FoJlMSBSkfe8VA/jNKmXL6KcHHl2FNlUWlTRtG/wrhIv5TOqugPjZq73U
         qHI89Gw/jNREqgMdbEci42DUBY/Ge6Cbj1EWKQL+bI/cormL/HFwVPhB7KsfP74DetIQ
         zxF0bie+DBkSbCNdmrglrmI8gAFCD9Ejhdy13pzk0GTW5w9qWdgjmI9fkDjF9AHdIyJb
         ytwQ==
X-Gm-Message-State: AOJu0YxOEDxZVD+hUUmgVnxFeImEGs4F8t1FhA6U2G2vUzxbPvxeqaAo
	vmoSh4rzZjVxdtU1Bxfydz7TQdCZbpVByHRZHvLtFg==
X-Google-Smtp-Source: AGHT+IENmBFBwYB9IpkoxcqiGVZAnRYCjCGMLhr5SfgpYgfgjDO4I+1tHrmn7jMdkNMKlopmHNiv0w==
X-Received: by 2002:a05:6e02:1a87:b0:346:6b6d:79a4 with SMTP id k7-20020a056e021a8700b003466b6d79a4mr14101509ilv.26.1691425633544;
        Mon, 07 Aug 2023 09:27:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 12-20020a17090a004c00b002694da8a9cdsm3338060pjb.48.2023.08.07.09.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 09:27:12 -0700 (PDT)
Message-ID: <64d11b60.170a0220.d8d78.57a0@mx.google.com>
Date: Mon, 07 Aug 2023 09:27:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip72-638-gbfc57fcad0ac
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-cip
Subject: cip/linux-4.4.y-cip baseline-nfs: 13 runs,
 1 regressions (v4.4.302-cip72-638-gbfc57fcad0ac)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Aug 2023 16:27:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12559

cip/linux-4.4.y-cip baseline-nfs: 13 runs, 1 regressions (v4.4.302-cip72-63=
8-gbfc57fcad0ac)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-x360-14-G1-sona | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip72-638-gbfc57fcad0ac/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip72-638-gbfc57fcad0ac
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      bfc57fcad0ac581f1b39110b5847f3e579e7888a =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-x360-14-G1-sona | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d114ee101bfbbfbf35b1ec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-638-gbfc57fcad0ac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-638-gbfc57fcad0ac/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64d114ee101bfbbfb=
f35b1ed
        failing since 251 days (last pass: v4.4.302-cip70-236-g69445bc0d420=
, first fail: v4.4.302-cip71) =

 =20

