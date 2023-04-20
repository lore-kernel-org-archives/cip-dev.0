Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B4CC77B7E
	for <webhook@archiver.kernel.org>; Thu, 20 Apr 2023 15:30:19 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web11.11410.1682004616599787079
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 20 Apr 2023 08:30:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=QtbcrSr3;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.180, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-63b733fd00bso1021855b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 20 Apr 2023 08:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682004616; x=1684596616;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fGbbrD3Xj1SdK/7qeHi2xeE8pdR3zEbd91bHedss4o4=;
        b=QtbcrSr3t2kcpThcETo3pP+r8HMlOLKpXVBlveV8DZT1qPI5Ur8KmrukPvDzk9KJEB
         tbC5eDZDuj5+hoNZJ0M3iLbtM20Bnays9Kyn25j2l6TAcPDKMPzhEw8F4sBtnzp5YApM
         /dZ9MTXoCkgUrwislzOAzFcaZGVdg5nZ/xs6wBUtnfI/3Rp5MYIHGUfhnqy2+1QPHP7H
         peWhs40uAr0G0QWvS8Sv9laotnUFAI3p1avqtkRyntvBJfYcBntbldd1Kwj1WMHQzzNR
         7VEVEamhJFpMGWsZLtlzbmXrfew0We4gq9xRFY7WfEJOUB0lxH7bp8AUBuIGzO9/1xQO
         DSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682004616; x=1684596616;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fGbbrD3Xj1SdK/7qeHi2xeE8pdR3zEbd91bHedss4o4=;
        b=ATq2YGIqJFMr1UVs/v8rEdNoezzsJlVjGbKZr4BjKnZ/6cHbK0vYjcGyIG7tBlvd9y
         WBdcHD57npHk+T04T6volmBBkF1jDG0S0Zzq9+mRX92hQxsYVo3Q9ms4Jh9nGchscbi+
         Jx6W8DpgtKMBVrqr98pacujla7f89v0ovna6JyNC4BgkCqk4nQkAi1rfYKoiDplepyI8
         IEYmtQ399WePwezyxc1Kr6H0zEB/X6G2p+5JByOYbxiGdFsvYbdLw2woi6QlDtCBoc7O
         uQzTQ1FMiN4RThpC1XMW8RUiWhUzrBGPwEYuhctN8NKoWSfuu1ocNqed718DlbTepo0B
         YSsA==
X-Gm-Message-State: AAQBX9ePWmJqk4oFUTHrbppDgqVfPKBGxQ7UbnDfI5wpGHWcKahrMAc3
	zSgw44JHYAx2xbF6ysxwZ4sZDdjmncQJB8hTqDMl/bFa
X-Google-Smtp-Source: AKy350ZmNEZC1HExWy/zXUdnpX1h9P+W0/IWZZaoZClATI3QDMunznP3wgDJLbwIVckKdNpi7/LtRQ==
X-Received: by 2002:a17:902:ce88:b0:19d:1834:92b9 with SMTP id f8-20020a170902ce8800b0019d183492b9mr2299449plg.56.1682004615790;
        Thu, 20 Apr 2023 08:30:15 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x12-20020a1709027c0c00b001a52e3e3745sm1283629pll.296.2023.04.20.08.30.14
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 08:30:15 -0700 (PDT)
Message-ID: <64415a87.170a0220.d6ef8.2636@mx.google.com>
Date: Thu, 20 Apr 2023 08:30:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.4-st20-1099-g7b2580e1565dd
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 3 runs,
 2 regressions (v4.4-st20-1099-g7b2580e1565dd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Apr 2023 15:30:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11258

cip-gitlab/ci/pavel/linux-test ltp-pty: 3 runs, 2 regressions (v4.4-st20-10=
99-g7b2580e1565dd)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-1099-g7b2580e1565dd/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-1099-g7b2580e1565dd
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      7b2580e1565ddf95b5123aaa9a1f4c33e354e397

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  458f3554675aace42e9750086d26799e82829f11 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64414dfff74677c57b2e85ef

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230414.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/64414dfff74677c57b2e85=
f0
        failing since 29 days (last pass: v4.19.277-cip94-1098-g26d9f86d942=
d, first fail: v5.10.175-cip29-rt12) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644151f830706245122e85ed

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/ltp-pty-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/ltp-pty-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230414.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/644151f830706245122e85=
ee
        failing since 15 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43) =

 =20

