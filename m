Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB98C77B75
	for <webhook@archiver.kernel.org>; Tue, 23 May 2023 01:46:36 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web10.11282.1684806386760148122
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 22 May 2023 18:46:26 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=QiDo/krT;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1ae54b623c2so63344305ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 22 May 2023 18:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684806385; x=1687398385;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=48Y/VuvKxvidFgF0xTc5WBxd7GJls0BKTkLhXoXfzGo=;
        b=QiDo/krTjRUn7gnbys2W1jPAGitb1gPsd2+2mAkIgbOGB9AjGnT6V7HwTwv9t4kIBv
         I1ggC3IU4+lnneCNxjwE/OUe3SoCGi6mKrcBtVo8i+p1kGVbZwf+5h1wq5sQ43p651Ya
         20kwVFe3TVuERgqTFh27aFkYCOf2mVm628q1FyrdOjIVVkSdcogD5ukm3P5pMTcz3xk8
         5ChHMJ6xRxP7zeDaOxxPwBtqtZG6LdX4VhT7GLu/mqdLNd3oqSlOVIX9LC046zv76Nnp
         Gl41kifzt9qvW9YVHcNScmOPpoUiXWyq7N6CRajODeiL/BnYt+Mx1+XJ+C1Wqtyt0c8K
         gQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684806385; x=1687398385;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=48Y/VuvKxvidFgF0xTc5WBxd7GJls0BKTkLhXoXfzGo=;
        b=cTKoR6oMiF66qD9iMVeS0bQh7xze1OybrIuOHfE1xCvop3IF1Oii3it78lmCGNGGrm
         VKFlXN4yDgCZAUOnEA6yCBhrpXOw5NyXFmCn/dZaMKFH9BjxyesXP+SZ37x1tv8OjxRy
         RPuSvyCmBo6jzDLj0tX6NJH/C6WVchndpTIU4BiqP/baYUyazE+4VhBPJJ7FJTlKK/DZ
         /SeNTFnSR/KaoklZmQewtBjIOVGz2963gImpfBdBapp12DiwAqnVg/GSTnBYdl4TuFPA
         W4TXAVAeKecAwr+63MAD/1+KI9/bqRzuijof1ao2ldOSE5KKil0SnlHtE55OQj5Vdch8
         QOAg==
X-Gm-Message-State: AC+VfDyeEtjCv7IpUYJJeRmfCl3HAi9XHeoLroIkWVUQIwrFgce8oU9v
	NlKS+42iiAAMjgz74+FwmoCiuYafUY9JeEJld2P29Q==
X-Google-Smtp-Source: ACHHUZ5PnSlysLqI6I1X9oPhb9ScuO2T3SHustz6gqwkdZC/kRYLJJn85pFoMTOhKm8dvLar+QEZhw==
X-Received: by 2002:a17:902:ef84:b0:1ac:6c26:c32f with SMTP id iz4-20020a170902ef8400b001ac6c26c32fmr10646050plb.46.1684806385620;
        Mon, 22 May 2023 18:46:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j4-20020a170902c08400b001a060007fcbsm5409039pld.213.2023.05.22.18.46.24
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 18:46:24 -0700 (PDT)
Message-ID: <646c1af0.170a0220.258d2.9c99@mx.google.com>
Date: Mon, 22 May 2023 18:46:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.280-cip95-rt30
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 9 runs,
 2 regressions (v4.19.280-cip95-rt30)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 May 2023 01:46:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11599

cip-gitlab/ci/pavel/linux-test ltp-ipc: 9 runs, 2 regressions (v4.19.280-ci=
p95-rt30)

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
nux-test/kernel/v4.19.280-cip95-rt30/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.280-cip95-rt30
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      dcee20e65677ab5d0e0d47c572f2c71dae6074a1

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  ce4802999f7ca6421643879ff08bbc1e18e7f8cc =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0cf308bbafb1c52e860f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-ipc-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-ipc-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/646c0cf308bbafb1c52e86=
10
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-cx9400-volteer    | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0ba1ecf833eeb72e85fd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-ipc-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-ipc-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/646c0ba1ecf833eeb72e85=
fe
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935) =

 =20

