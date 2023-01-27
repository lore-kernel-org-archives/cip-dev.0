Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABDEC05027
	for <webhook@archiver.kernel.org>; Fri, 27 Jan 2023 01:22:47 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.web11.92557.1674782561388846762
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 26 Jan 2023 17:22:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=QbNA0AbL;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.170, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f170.google.com with SMTP id v3so2308260pgh.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 26 Jan 2023 17:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jqDCN4FvrvHqrVC3UozOqwjnOBfggrxVHh5SYzWAe5U=;
        b=QbNA0AbLLu3SWCVqEbInTFacOlGp0GOACe1RxMldoZjyI0ieXuINeig+TFI6k9hGWp
         SqQMTs9mTPRDt4lF+NoiMgquHpiddRtcLAUxFQAOuV6hu8ME6FX5BNUQABnccFQ8O37k
         r0DTJ9yyF44cl9Nix5aPToT1HhBsqG+tf0Uv/SKxLafcDocumUVxTdZj7+7hS4pQi9+a
         C2sWP1sHNI6u8s3t3muz4QjOxYQRUzONdkrIX7QpermZGycGb1Rcowo/3tGOYDe/aI1p
         Av/yOVtjbcokmEJpNQrCzeXrzJMZyW1s5RAPZK5/8wCWfq7jUu4e42xzvtJwqc4yBpfO
         6log==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jqDCN4FvrvHqrVC3UozOqwjnOBfggrxVHh5SYzWAe5U=;
        b=VJCcNRyVtr94SOkdksMpg/KHUGKJVA6SNuU3Ycj2AkXWqCDoTtPgiwgkSxN4U2Zwaz
         iSt3psXFugbvEybWd9c42HPA3iMHaD7cFk+463WC7AVSZNPmHMipHDf+astd6J+XDReK
         lvzWT3SYpqVgJdnata3+vLzu/EevtWhpJmZt3VDXIqX2MyzeSlq6eaqpWiNCNI0t1tMf
         vT/Nl/rfmkR6+QwDDStLwVF/Kk+HR2p4nrHKXVSEltYjzuwNav/Zie0EwZ5Iu6aBK7q7
         tFKzSPPydxAjSlwfOYmJMMxlAlC5UxN8L/ou0Bo9sUm4+CrJ/4tPEKI35Fq4EMTI3BLn
         SplA==
X-Gm-Message-State: AO0yUKXUxoIzpsCUpaErkUtGT85rxUpX/VqJJlAjQUFSnbMsba6nJEj/
	77EB59OsujuRmqtXXiWwvboCxBFJBdvCdF6eQQsduA==
X-Google-Smtp-Source: AK7set9E3sScq5rDENpp96h3/BWqDJoh1qaWMGTKWRzRSBbLmvWBKRdHxxC4cLS2uETcLa/XxqNCiw==
X-Received: by 2002:a05:6a00:1f0c:b0:590:6f90:ae41 with SMTP id be12-20020a056a001f0c00b005906f90ae41mr5843496pfb.24.1674782560281;
        Thu, 26 Jan 2023 17:22:40 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p31-20020a056a0026df00b0058bbaa5200dsm1414261pfw.214.2023.01.26.17.22.39
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 17:22:39 -0800 (PST)
Message-ID: <63d3275f.050a0220.a3b99.2d2d@mx.google.com>
Date: Thu, 26 Jan 2023 17:22:39 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.162-cip24-443-g1f8fb81fe752
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-mm: 7 runs,
 1 regressions (v5.10.162-cip24-443-g1f8fb81fe752)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Jan 2023 01:22:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10487

cip-gitlab/ci/pavel/linux-test ltp-mm: 7 runs, 1 regressions (v5.10.162-cip=
24-443-g1f8fb81fe752)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.162-cip24-443-g1f8fb81fe752/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.162-cip24-443-g1f8fb81fe752
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      1f8fb81fe7523922b7ff40bbacc9ac4aa9e11796

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  d042c168dd037bb0128b86ee4ac4f5c526eddc7b =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63d31f3d7a9b843518915ecc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-mm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-mm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230120.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/63d31f3d7a9b843518915ecd
        new failure (last pass: v5.10.162-929-gae713b3c4626e) =

 =20

