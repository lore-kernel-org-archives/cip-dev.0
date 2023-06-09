Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BD9C7EE25
	for <webhook@archiver.kernel.org>; Fri,  9 Jun 2023 18:39:34 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web11.2432.1686335970685446223
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 09 Jun 2023 11:39:30 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=zDmZ28YI;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.174, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-652dd220d67so2132738b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 09 Jun 2023 11:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686335969; x=1688927969;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E0v/Unu56vTIpdF9pzU69KitzppLqSMnooPi7RMWVRQ=;
        b=zDmZ28YIjIuniSWVs04RTIFLidK2tMTGx35KM8LzQingfcBTZdP3obhRgFH/POHrsl
         Udm162/VwwsdTWWVRIJGfmtl5tQkhpGFLY/XcGBUVzFYF4WQ96003B2620MrV3oKSzpu
         6ccUnijJu5AB2ec0//xI78K6NjRrSvSCr1YBnmLdMJU0YBoOf3hEGcTg8blSSjy5b59a
         tlpfKZZxjFDZzDVuXBqOFBkFx+NfaWV7gA6MRdsEh5XRWEhaiaC+vdVqtDzIF3dGTPMi
         o4XUQtafyxr/MsYe+F3vyCs+lErcHAIV6j1n2aHCWI631Pm0vf546lLzXCdpEOCiLCZ+
         HBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686335969; x=1688927969;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E0v/Unu56vTIpdF9pzU69KitzppLqSMnooPi7RMWVRQ=;
        b=c+E1LpJTvYr18vfnhfAjO9lRWM6Zz5K9mOyXnX89YdeXb5sfCYpGp4Nx+bSlRrNJ7k
         u7rXekdqNE1VzcyXM9MAU7fCvQs5owM0zxYrgpcOhf0YqdEPVkn8zMEJlvsF9lxa982W
         cdH8s2JBJwr2fAWt+YLd48pt4BRhP5pE6I+Glg7ZGdKMrJYQ31zTLaVlOrt7gjzxNw+P
         kuRp2Cxk4WTjCY7rUNRki9CDnoGfFJgZHkqrz4FA06w9bjIaxZXC5vyhHHa5jdretrbj
         dzzZDOUTkuL5p5K8hqtAkBqS0JekPv+lXaJtTxOojmaHdoHKl8akziJ71qPNQTxyuaMQ
         aQGA==
X-Gm-Message-State: AC+VfDx5u6dgIXIRXK1MbZgi8AOFj7x4yeGwzBNQ6+BJaxQQwEBi/XnC
	cr+WwVaqQv73ale7TJhaNvIiwDpgeerk7RtQ+Qe+rQ==
X-Google-Smtp-Source: ACHHUZ5vWDNmewibFJM9tegHSvNyB5kXhSkCgVGBRQXuMUYQhT8WCNIFivcK5oB41yuC/KvbngKrHg==
X-Received: by 2002:a05:6a00:14c6:b0:64d:f5a:3fd2 with SMTP id w6-20020a056a0014c600b0064d0f5a3fd2mr2586128pfu.28.1686335969369;
        Fri, 09 Jun 2023 11:39:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e10-20020a62ee0a000000b0064fdf5b1d7esm2941005pfi.157.2023.06.09.11.39.27
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 11:39:28 -0700 (PDT)
Message-ID: <648371e0.620a0220.94202.638b@mx.google.com>
Date: Fri, 09 Jun 2023 11:39:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.283-cip98-1248-gcaf6e8ee921e9
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 5 runs,
 2 regressions (v4.19.283-cip98-1248-gcaf6e8ee921e9)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jun 2023 18:39:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11956

cip-gitlab/ci/pavel/linux-test ltp-ipc: 5 runs, 2 regressions (v4.19.283-ci=
p98-1248-gcaf6e8ee921e9)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =

asus-cx9400-volteer    | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.283-cip98-1248-gcaf6e8ee921e9/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.283-cip98-1248-gcaf6e8ee921e9
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      caf6e8ee921e9e7714b8669fc9187fcd56d5a5e6

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648361ba56580135fe306143

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/648361ba56580135fe3061=
44
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-cx9400-volteer    | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64835f6d8d61119798306135

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/ltp-ipc-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/ltp-ipc-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/64835f6d8d611197983061=
36
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77) =

 =20

