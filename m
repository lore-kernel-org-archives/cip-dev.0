X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web12.9936.1648046205712333257
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 23 Mar 2022 07:36:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=hOr1SjVa;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.46, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f46.google.com with SMTP id v4so1847581pjh.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 23 Mar 2022 07:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=drmiA0dhkhnLiqtcy/0uqem2reLvDZJOptrQ9vIhe4s=;
        b=hOr1SjVal8KOLd97QRHmVDmhTX0xgMrDJTfcoVaLLI4eMLUOiPpbT8ozXmu5Rup9TF
         9gqQq88O+SRAVEtn8Swpij0ob247ZFUHrPBJ/7oGYjmr+HMxbJv3aX9ENhmD4kV92l6V
         2I9PGqsr6w6fkcx8vSpduV74ADHF3q+zZwlVNatzPDXc3MDsB2y3zcs5lX9txQgCcgCV
         rXLfmlNHu4eNw6qIWViG4wd8EJjMZhSYOY35W4SHeI2KQvRePoO3nI8kw2VqJhYH6MML
         1Su6iFWXuJrpzoEGjV3Z/IR+J5oShvDbVKHZ958AwXsRAJjahFul100nlHaUBbzUScKg
         CQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=drmiA0dhkhnLiqtcy/0uqem2reLvDZJOptrQ9vIhe4s=;
        b=Za/cRX0AISTy9iMatqeekx/VawlRqdIkT/5XALu8rslUHqi68qotPCxy1mTocit8cS
         3a5xt2BdOVsq6Ari8FRgB6+kuzqLoXpEVrYH/O2vlPv1L/9kT8cFliICl6C5OzImWpnQ
         000yPtaW8UseT+sKZ3H2lLpGcX8ichve8Y+6YKcW433HfJm3fzXrb+a89+NAnxM4/Q2P
         BM0J7OHC3JeFDsro1KwVN0ywfrp8ZdQV3mkeHoGBa6A+5aOp5sAwTWzyisimRFa2Nd1Y
         BDHGH9NvRqm6K8K0JeOC7PMMDnkNLkhJGb9Wj66XOEm/lAJxS8UhUvRvsZhfDfWnAotZ
         +zMQ==
X-Gm-Message-State: AOAM5334EUdoLYt7hsA9eB0HgU7kMlZ+KXIDiD64M748HN7lQxChapTg
	XbX5SaLDt5TdrfhXUdqRG8T3AfulETDqmB2arn4=
X-Google-Smtp-Source: ABdhPJzLBTX1akmOhzW6bFqPFk/i8rJAy5lJPPY9xRlkTQeT1xkZgmuIdFTnjCPHKW/+BAQE0x86Mg==
X-Received: by 2002:a17:902:ec83:b0:154:7cee:7722 with SMTP id x3-20020a170902ec8300b001547cee7722mr262232plg.96.1648046205032;
        Wed, 23 Mar 2022 07:36:45 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y14-20020a056a001c8e00b004fa829db45csm121551pfw.218.2022.03.23.07.36.44
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 07:36:44 -0700 (PDT)
Message-ID: <623b307c.1c69fb81.7e123.04c7@mx.google.com>
Date: Wed, 23 Mar 2022 07:36:44 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v5.10.104-cip3-186-g758e0f22e236
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-mm: 4 runs, 1 regressions (v5.10.104-cip3-186-g758e0f22e236) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-mm: 4 runs, 1 regressions (v=
5.10.104-cip3-186-g758e0f22e236)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.104-cip3-186-g758e0f22e236/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.104-cip3-186-g758e0f22e236
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      758e0f22e2369c3d29d49c89c4ab585390c74a82

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  dc836ec4cd4e02e1346001f828c1f1988a8d7d54 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/623b2e4d92f1a799e0bd91b2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-186-g758e0f22e236/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-mm-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-186-g758e0f22e236/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-mm-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/623b2e4d92f1a799e0bd91b3
        new failure (last pass: v5.10.104-cip3-132-g46c091c34fabb) =

 =20

