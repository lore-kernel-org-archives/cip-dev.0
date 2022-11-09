Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F31AC433FE
	for <webhook@archiver.kernel.org>; Wed,  9 Nov 2022 23:17:56 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web08.447.1668035874255577526
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 09 Nov 2022 15:17:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=6E9qPJBn;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id y4so119626plb.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 09 Nov 2022 15:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9mA9U8Z2907F6qWuB3beQjPWcxD0KGpHzY+OMNebP6A=;
        b=6E9qPJBnTHuxvIYDUpv4faPewbWqd3Dn/EYtoQzq14MHbmj2FnYLvl4YyicC9ckNwi
         i9m7PPxNliV+Nj6c4WkeZCC6p1347LUY0SimBg8ieh5j6xfoY8bEDgAFZIVKDRt9bilB
         yVpWB4DjHs15cQe4WXPmBtFBYPz7nyI2lDKF4n1MD2eTDS9ksGethyAmcoUvtGtdI+9p
         P6jwaKmd996NPPeD+mlXn1nGj2mAdKcQ1vbnfS3hs/pxt7h0y6P018mr48OmOrK46WY4
         2LTuZnCV0RQ3k5mumR6uR4e+Jv0XWR5cZTGdbDHjJt+wq36TJoEbxnFAV56fWHncUA0n
         7NBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9mA9U8Z2907F6qWuB3beQjPWcxD0KGpHzY+OMNebP6A=;
        b=mwYzREUU70UwgTKU/AUcgI81RkEuxn0L1es3ggwrAauuuXBZ07YFLjYtujHfBSjh3a
         6FNL1jw7/gjtWBGrrQzk8TzKP1QfbMYhOUdeDh/ANWkj5qhC+QVBMkiDX9aUDZ6zcwsG
         lGXCQjNcfWJV4HA8v1ntSx2lsLjXsYiDzlnZZHH1FNh2BbU2sE7JMEytoG8fuc8DMhaV
         IWF+iZyKKi13opLTvPvUSw7UB4UVNgaKBVyRYQ19BkqiNynPAfDS8E2wYzFZMl1GxICi
         inUi8c4wH2CuHdL3PijfPc+59z9g/UbfbYeyz3fldUgKRdBPpJXjharawuswCVa6o3au
         Ih8g==
X-Gm-Message-State: ACrzQf1DiEOybBXt7WhCaheQ7sPMbVA3i8YtTmvYxAPisle9omYGC94L
	WpxqqP+CZHDRwJCiq+NlCGttE5B1TOd4A55vmKA=
X-Google-Smtp-Source: AMsMyM5p9qotVWzGAwzZRcJExnbDeuP7+d5v8TJTw+py8DWhs/APTcPplDq/EfzR+9U9Rl0U7J/hrw==
X-Received: by 2002:a17:902:b70c:b0:186:8bb2:de36 with SMTP id d12-20020a170902b70c00b001868bb2de36mr64639507pls.106.1668035873571;
        Wed, 09 Nov 2022 15:17:53 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u15-20020a170903124f00b0016d72804664sm9674707plh.205.2022.11.09.15.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 15:17:53 -0800 (PST)
Message-ID: <636c3521.170a0220.1091b.0613@mx.google.com>
Date: Wed, 09 Nov 2022 15:17:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.153-cip19-rt8
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip-rt ltp-mm: 8 runs,
 3 regressions (v5.10.153-cip19-rt8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Nov 2022 23:17:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9990

cip/linux-5.10.y-cip-rt ltp-mm: 8 runs, 3 regressions (v5.10.153-cip19-rt8)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =

hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.153-cip19-rt8/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.153-cip19-rt8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      4b5bf35ef58ec8f9f73fd6fec577de2f6710955f

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  b79157c8375cfdd2abfc59f63afe8ea09eaa8c5d =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/636c28a0b1a74fadcee7dba5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
153-cip19-rt8/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-mm-h=
p-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
153-cip19-rt8/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-mm-h=
p-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/636c28a0b1a74fadcee7dba6
        new failure (last pass: v5.10.145-cip17-rt7) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/636c28f3a0aba108a2e7db4f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
153-cip19-rt8/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab-=
collabora/ltp-mm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
153-cip19-rt8/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab-=
collabora/ltp-mm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/636c28f3a0aba108a2e7db50
        new failure (last pass: v5.10.145-cip17-rt7) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/636c2934232cc16a02e7db5b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
153-cip19-rt8/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab-=
collabora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
153-cip19-rt8/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab-=
collabora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/636c2934232cc16a02e7db5c
        new failure (last pass: v5.10.145-cip17-rt7) =

 =20

