Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FF3EB64DA
	for <webhook@archiver.kernel.org>; Thu, 20 Jul 2023 14:17:46 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web10.14124.1689862658093626082
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 20 Jul 2023 07:17:38 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=T9dp4nA7;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.181, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-666e5f0d60bso529807b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 20 Jul 2023 07:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689862657; x=1690467457;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VaOhZAI0S/GnnFX/E1lM4yzJGxVoa4lUr20CkAhOD5U=;
        b=T9dp4nA7IWzW9DJKVJjgXf+zaPQdN93+Iun/b0aL5QVSY072Zp5cpkUutkyL4QaY0i
         4MyHnWsV6qL7g2dZl5LAWsMNUuab4LFrJiiq+qg5HZNDlErPCDWK6JX+TfAiw2ufZsL7
         JeVMEVcCTw4ARFx/Xn0N+4hIhNka/hpCRCJT7G71EoCykLFEvhk08RwkzYpyM2s29i90
         a1xfp6tn83sDChaBmhqS7uCuQIlA2lNWW+db8tc5+WlTh+ArsFq/4ULY+/79mg0EulJf
         I7ZPZl5NNG5VSBNL9T5o/CrniE+nIfkjgyHnWqzNNfZ+9wdZiXIbQ7fq7MkhrkNvX/CU
         ifUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689862657; x=1690467457;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VaOhZAI0S/GnnFX/E1lM4yzJGxVoa4lUr20CkAhOD5U=;
        b=gltXQfTB5CEzwieMT3uWykogykwOF7zoxMm5EhPnC9XT/bgoTKSYsYyid1nJdD9d1G
         Lv03QqIhMkJo7Yiur2MD3kDHKu5LawCSM/87Dd0R/dgb4CPVsk4Nf0kfSUS8OneOGYKh
         xyr0UkzMZJV6IFAJkLwKJVYshsV5Sf1CgpQafO7rr1bojpx47qid1nGKzCnjXuGWGfrt
         Zyak5FEH2KBDZlsuvApvwVZKdQ1fVAEerI8ZAWaz6uwmv9WFyIp8iZDuh4g3mY9Lg7Cu
         nCqIEkd2ApG2d1JRdQ3EU/C7vXrGUgdy+2K0DUfGM1s/94PJrnNhP6gRpWfV0+txomGE
         iRAQ==
X-Gm-Message-State: ABy/qLb0DJ0DY16ThkZZCWT+pxy+vQ1nrlFnALBvVmfS7W4vYsDvqN4d
	UF698uZgokk0m9N9F/0r2y6TtUL59/djQAfp5zjkGA==
X-Google-Smtp-Source: APBJJlH9gzEmxOUw2/pe18/le1f4ft7JdkHWqPr3wwjwR3HuvwV0wfG50ByLS/rCYr7I3lyZ0evEJQ==
X-Received: by 2002:a05:6a00:2e98:b0:63d:260d:f9dd with SMTP id fd24-20020a056a002e9800b0063d260df9ddmr23651383pfb.33.1689862657152;
        Thu, 20 Jul 2023 07:17:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h23-20020aa786d7000000b0067f11aa76cbsm1226411pfo.108.2023.07.20.07.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 07:17:36 -0700 (PDT)
Message-ID: <64b94200.a70a0220.9f5d4.1bbd@mx.google.com>
Date: Thu, 20 Jul 2023 07:17:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Kernel: v6.1.38-cip1-7-g5cff59cac977b
X-Kernelci-Report-Type: test
Subject: cip/linux-6.1.y-cip ltp-mm: 1 runs,
 1 regressions (v6.1.38-cip1-7-g5cff59cac977b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jul 2023 14:17:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12473

cip/linux-6.1.y-cip ltp-mm: 1 runs, 1 regressions (v6.1.38-cip1-7-g5cff59ca=
c977b)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.38-cip1-7-g5cff59cac977b/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.38-cip1-7-g5cff59cac977b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      5cff59cac977b1b5b2762b500623602540959ab1

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
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b93209fa3fc369b48ace1c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.38-ci=
p1-7-g5cff59cac977b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/ltp-mm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.38-ci=
p1-7-g5cff59cac977b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/ltp-mm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/64b93209fa3fc369b48ace1d
        new failure (last pass: v6.1.31-53-g486caac40d06) =

 =20

