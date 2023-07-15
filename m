Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D91C0015E
	for <webhook@archiver.kernel.org>; Sat, 15 Jul 2023 02:31:19 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web11.4888.1689388275703055368
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 14 Jul 2023 19:31:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=d8s9f4Ss;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6682909acadso1792052b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 14 Jul 2023 19:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689388275; x=1691980275;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZV+XePeASV8AyNv6ezZczoZkH1pk57oKtGMlkvVNv/4=;
        b=d8s9f4SsB4Cz4vDVPKx1wCiDjIt0TlSoGPCUWu6GC3D/jVR41MIJYWjEEY+gvIZED3
         VptexCrd5eiu3txYBjJ2EoRKWebh556j6cqkyiNFgZUTS0U3HZjB7a3i72WzzNS8ZRhQ
         VZ7xtfEgooHhm83SpI4U0tSJYQ4MC5t07zI277xHytRB1yzq33quNzMGRNhxQBhyczPn
         CQLUS12b+5kStJxQhNxVhjjQx+2FlTwV6Wd9Ejf+z+vVJIVPgRi5rsjGsaKOb9LKf/Dz
         kftTuBQr0ENsFsAcp/OBtwgzGTge/9G2O/YRJ821VzerKhCLoqZsN64aclUoJHR3bSrS
         68lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689388275; x=1691980275;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZV+XePeASV8AyNv6ezZczoZkH1pk57oKtGMlkvVNv/4=;
        b=ZfdxxAwFxpex6SPvgN7SH145DKGhcjV17GGvNXv05Pkmi/l+l2XUkoWG62lPwRq216
         P7feVBrTCSrn9V7FNWoK8xoxtUz4U8llrIG9lK6kbb/uNKHsLJ8hYCMeHc9BqtL61WmW
         pzbgBIGQOwOk/RbWF0eaqjh0A+ToiIVgx1CXC6FUgp3gZED+qltqPPeWbB4oLjTGyUlX
         yNaxUPKWuiXT89WOK7MF0uDP6+PLz3kHZPYbEk1i+wTW06gGEg1hDst1O1DXCoiEdDaW
         hjUhfuWnF1/qjrsV0Dyt77usx2AtA7dc42jmgjxqxV797x11xuzhEiuAYKlMn7xSPJ9h
         9aTA==
X-Gm-Message-State: ABy/qLZnTof3mYBwEchv3q/uXzY3WwosPgYm+85LL252YmxJwMtP3qWh
	x/NcJxb8Ii8+t0Cu9zrmSHEwDNKsCXKaztPK2YNVgQ==
X-Google-Smtp-Source: APBJJlF9p1udmbjj1ThfE48ff3vH/4cL6Mo02zeyu+BgHurjk/wunsLD1XrvUUY2EQjn39riByf0og==
X-Received: by 2002:a05:6a20:9185:b0:12c:e2f6:e39 with SMTP id v5-20020a056a20918500b0012ce2f60e39mr5646096pzd.7.1689388274768;
        Fri, 14 Jul 2023 19:31:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m7-20020aa79007000000b00679dc747738sm8027047pfo.10.2023.07.14.19.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 19:31:11 -0700 (PDT)
Message-ID: <64b204ef.a70a0220.493e0.1899@mx.google.com>
Date: Fri, 14 Jul 2023 19:31:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Kernel: v5.10.186-cip37-rt15
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip-rt ltp-mm: 2 runs,
 1 regressions (v5.10.186-cip37-rt15)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 15 Jul 2023 02:31:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12359

cip/linux-5.10.y-cip-rt ltp-mm: 2 runs, 1 regressions (v5.10.186-cip37-rt15)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...k+=
preempt_rt | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.186-cip37-rt15/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.186-cip37-rt15
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      db05335d4d4ee47b8fc64652b2c2ad8e57eeaf52

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...k+=
preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/64b1fc9d1f713e693a8ace1c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-mm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-mm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/64b1fc9d1f713e693a8ace1d
        failing since 57 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v5.10.179-cip32-rt13) =

 =20

