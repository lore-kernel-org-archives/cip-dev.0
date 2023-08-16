Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA087C001B0
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 15:37:39 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web11.163882.1692200258628217063
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 16 Aug 2023 08:37:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=I1L/Dyot;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6887480109bso1361915b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 16 Aug 2023 08:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692200257; x=1692805057;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mLqKlniN5LlYgzmbrNqR/JqM8hYIPUutQpRF4onarsU=;
        b=I1L/DyotD/Fz5O19es4091itd4seIaGtL3w0JHlmQ1Z7YhDtE71bJVKOLeOc+phGuN
         8MRLt9L4xsfVZTrC6LKA7D6h5i4DHdkmE6bwCT0QbquloL4zydvZ2VkfAfgQcws6ZUiq
         Mr0tByc2cVtN9c8xD4MBhexW4QEpXcZROidETWkl80qYyj1vrY+8CgnYwhnvj1PedcLF
         JmP5jy0bYQTuyc+hnglu+HCr095ssM28b91pFQWTAQokH/EL138dtCjG8e4hKFljkocG
         ABAP/7REuimXRqD4pxhxfmIzTlZz0G7qO+henrASacbaDVxeFHtNlfW+v6ewGSxnMoXk
         8cKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692200257; x=1692805057;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mLqKlniN5LlYgzmbrNqR/JqM8hYIPUutQpRF4onarsU=;
        b=CyClTIq4/BMozvpjicYGh28ajtSJWmCv4Zg4r8NAhuzi404SDgvmhsqnMggOkNqzJU
         WHFZY2xd0b40ljymHCQKNc8lILGPjF7yX7YCyDvJ2zXfzPob9jn3i8/sZ++mPCYWQ8NF
         nWqi+fOZG0kKq3DaK3RPMhxpslfDb0nkjoeI5FgMJs0l5VMgVJcEQswjo9z9327WBf8A
         iVmBMPpU88Uw5LdIBm4q+9gO/9ga6zkX2sNGcJ6Ul8sAU6wyarJ3asGqE5ezBiZXj08S
         d43UOdGVx+6YCbfBeFl1S+0x9/XFKQcldwTDWFVIq8HK5ejJXiynIcW/M2MKjAKshrIZ
         Xk0g==
X-Gm-Message-State: AOJu0Yx36KCy65BNBojmRIlWw7raavjTx5JGo1qD+NCvwKDtD2oPqPod
	esufBsbODMHCPjghzpZX1eGtWnUBuv7rxr2rfH1xYQ==
X-Google-Smtp-Source: AGHT+IFLu82jdObB0N6AKJo/ztB4BlMcLBMX4JpFyPWMvHoq2y2llAtre4H5DgHhFPYp1osiOreZaw==
X-Received: by 2002:a05:6a21:6da5:b0:144:c131:dbe2 with SMTP id wl37-20020a056a216da500b00144c131dbe2mr3487331pzb.5.1692200257484;
        Wed, 16 Aug 2023 08:37:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o29-20020a63731d000000b0054fe6bae952sm12081699pgc.4.2023.08.16.08.37.35
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 08:37:35 -0700 (PDT)
Message-ID: <64dced3f.630a0220.fa71d.578b@mx.google.com>
Date: Wed, 16 Aug 2023 08:37:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-3262-g667bb8d8b2cb
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 1 runs,
 1 regressions (v4.4-st20-3262-g667bb8d8b2cb)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 15:37:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12737

cip-gitlab/ci/pavel/linux-test ltp-ipc: 1 runs, 1 regressions (v4.4-st20-32=
62-g667bb8d8b2cb)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-3262-g667bb8d8b2cb/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-3262-g667bb8d8b2cb
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      667bb8d8b2cb1a46bab0ddda1cf60f6e73eff4c6

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dce5027fd11519d935b1db

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/64dce5027fd11519d935b1=
dc
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d) =

 =20

