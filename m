Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41145C6FA8F
	for <webhook@archiver.kernel.org>; Wed, 30 Aug 2023 00:28:09 +0000 (UTC)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
 by mx.groups.io with SMTP id smtpd.web10.3371.1693355282749506280
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 29 Aug 2023 17:28:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=xpGUUXw7;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.180, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3a85c5854deso3755483b6e.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 29 Aug 2023 17:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693355281; x=1693960081; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OSdHjkgPBW0C8+0wNF0h53n0zYWr8W+IGQ7PIPXEXhM=;
        b=xpGUUXw7iBzluapYi8+Wy+Qn44e7tdhsMXdGO9NvlKJ+FN9SGaUEAsVSdf61fEU4jE
         ZiJY95mfNaiPspGbDW9+v3uIHeUnbg8YZnJ+vIXelrdaY30KA3M7vLVfPt9WN0Fq9rvj
         rdSVeW8bQSwfeB3qVZgjTf+D6cXeophnBn4Ded17ipT1qXwy1GSMZeI6an1FE2RFZ6KN
         QARVgqRvPp0oDQlsJS4fRxGZaO8yASZvMIVwM8Dva6hRy+7q4SHS8SFdZ9c7OQe9L/Wy
         kjdlgiqI10Lm66T/cWMR6GsrJmd1IKOAib+z1q7uTsJ+beY6UTsSl91T/v4G/V2FHoym
         LG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693355281; x=1693960081;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OSdHjkgPBW0C8+0wNF0h53n0zYWr8W+IGQ7PIPXEXhM=;
        b=Vf0K3RKo8ao6PkX+ekmh1HP21EDyamfd/lwTx3SGqcwrsL3mqeBtqkX+pawuVZMP7h
         dTRv2LIEl0SPpEvt7odriwwwS/XfYLwHms99F0mY7NWnyCfXIpksgRXUHggRtTbIKaxs
         pUknonZUTLeoO33t2htZratT+p4HNLKsM5DbJmiFg1KaIRHZA1FlboHwvNRbQbabT7j4
         mCRXHRIZ3XWletphCorFfilnXA9SGI5Yo5vJt+aEM8YD7eKqaHx6gj23jzkGoinNaeSt
         +u837hP5TxOZx3s3DpTlnPRa9JCI6eTcfJMxgtLnDcmoROl0VjAR8aWWJEKHvwkkTdbs
         D7hQ==
X-Gm-Message-State: AOJu0YzjfyAoQqAGAaSaukVUrOuuFPXG/ibuBdx3RfPxFybhJJwmOxPD
	kk/nH2EXsnJSzoaVMV08kwaNL+FGsXpaE2gSvqg=
X-Google-Smtp-Source: AGHT+IFZsd3+s0y9Hlq4cKPiSvqyaANdV2kZq/h/HNnqnhGtbVUcslWQnM1EICdZk5GZQ4yFQCAgZw==
X-Received: by 2002:aca:1a13:0:b0:3a7:6213:6898 with SMTP id a19-20020aca1a13000000b003a762136898mr714443oia.12.1693355281534;
        Tue, 29 Aug 2023 17:28:01 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j22-20020a62b616000000b006889664aa6csm9005078pff.5.2023.08.29.17.28.00
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 17:28:01 -0700 (PDT)
Message-ID: <64ee8d11.620a0220.bb420.f4b2@mx.google.com>
Date: Tue, 29 Aug 2023 17:28:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.191-cip38-2-g05fb42f86d06a
Subject: cip-gitlab/ci/pavel/linux-test ltp-mm: 1 runs,
 1 regressions (v5.10.191-cip38-2-g05fb42f86d06a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Aug 2023 00:28:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12900

cip-gitlab/ci/pavel/linux-test ltp-mm: 1 runs, 1 regressions (v5.10.191-cip=
38-2-g05fb42f86d06a)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.191-cip38-2-g05fb42f86d06a/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.191-cip38-2-g05fb42f86d06a
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      05fb42f86d06ab31aa144cefe1ccd3c7cd8bbc72

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


  Details:     https://kernelci.org/test/plan/id/64ee820ee9fec18042286d6c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-mm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-mm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/64ee820ee9fec18042286d6d
        new failure (last pass: v6.1.46-cip4-rt2) =

 =20

