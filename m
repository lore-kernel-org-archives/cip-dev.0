Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639D4C7EE26
	for <webhook@archiver.kernel.org>; Fri, 19 May 2023 15:12:09 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web11.28878.1684509126227070121
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 19 May 2023 08:12:06 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=x4sBzyS+;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-64ab2a37812so686747b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 19 May 2023 08:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684509125; x=1687101125;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9QV4cTqiTvurh0skBM3FA18MSRBw+zxn9SADofGtrIE=;
        b=x4sBzyS+ivNiY/P9n4mSnHW6auB/OuACdmId8J6WMNRG5lJzIZW38UinCJcZJXpL8c
         8K0YouRGzyZdWuEIDTivw20fRWEJ9Trf+/RowennHjXkke3iMThN3kGN8J8Kz4gE92Ex
         dkbGxjkz/fDWdFK9xN4A4vKNS4GwDWfHZYa7u073IYPIBgIIG84e1Gpt9bklZXwZvvAe
         fIjfG8icB+9F17EoaWbiCXVHvIo/c4F+WN7hNgHlWCUTAkIiGFPri+QBdLDiUDdxkMq6
         JeXiPiLC1NtWG5FNGEJADdyq5YlbfpJGpCxKD6dODLTEHAmd0MtaeOqOGGN5fJyDbrjB
         YRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684509125; x=1687101125;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9QV4cTqiTvurh0skBM3FA18MSRBw+zxn9SADofGtrIE=;
        b=hHlswhn66VuHp3hT+nlUMN65oQ5eerCnOj309x9sVnza1VAdmdpHFBa9kuOaBrTOda
         N1+o3vCeTY6lLXrgcxopH4FtdOBwTLvleTFguMW5NRL3RQb9wKKtRw9afRj6OmkPtrAY
         T0pIqDzFlcuCCpKw2opdtDiulWYvw/LV/othdo4NYhPMROhDUH667b8zQL2KqoedQcOj
         9d9QOMbGdqmdcotKS41X/xFHZqNH4kYI65QpZQwfPPlUcXTv+8Lo2YqkA5OvRDV+C9zZ
         F2dWztaAi93/uxe+l9woZYwXEAawWjB+tcaUIZbh+7pcQzyk0Yb+M+WSgUwO4gel0euG
         ECHg==
X-Gm-Message-State: AC+VfDybgBwwvhKgLXlHUHWmFR5QmEWAaaeR6Rt6IfckHrQgwdeTE5Zv
	dfmDlObXe+/NgzYxsHAglc3Aj6SotakUeCO5h8l28A==
X-Google-Smtp-Source: ACHHUZ6lBgGXmr7wBAW7cjRkYFkYSPMM1Rxz98Mqp4FDCia24n9tfY6jSqJ48ks+QgPDS4WbhIyz6A==
X-Received: by 2002:a05:6a21:6d98:b0:102:c96b:f147 with SMTP id wl24-20020a056a216d9800b00102c96bf147mr3310913pzb.17.1684509125279;
        Fri, 19 May 2023 08:12:05 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i13-20020aa787cd000000b0064cb464e08fsm3263513pfo.15.2023.05.19.08.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 08:12:04 -0700 (PDT)
Message-ID: <646791c4.a70a0220.6061c.615a@mx.google.com>
Date: Fri, 19 May 2023 08:12:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.180-cip33
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-pty: 11 runs, 1 regressions (v5.10.180-cip33)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 May 2023 15:12:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11565

cip/linux-5.10.y-cip ltp-pty: 11 runs, 1 regressions (v5.10.180-cip33)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.180-cip33/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.180-cip33
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7f6b02104eb287caf662ade9a67f11896ab01fde

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  ce4802999f7ca6421643879ff08bbc1e18e7f8cc =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64678620550fb3208e2e85e8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-pty-=
hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-pty-=
hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/64678620550fb3208e2e85=
e9
        new failure (last pass: v5.10.179-cip32-4-gd8c029e4780f) =

 =20

