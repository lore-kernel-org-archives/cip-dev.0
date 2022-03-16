X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web11.3388.1647470620975440452
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 16 Mar 2022 15:43:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=YwQLYHbo;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id i11so2286140plr.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 16 Mar 2022 15:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ctDTPE+1uUrvGDY1YjodOAzX57ds3DQwAPzceeYfPdk=;
        b=YwQLYHbo9igyc/me6oTy7bUfIqQ2jfCpVu8MUpTNoNSRoIB1gJOtP0dlisCM9G+fUO
         mPu6qdlDyWaexLe4Q8dwAny8DmsD4VG3quIea7zSO8d89Rvbk0Ob7yz1Gfp25SEbLaCm
         N1NQNiHBhj89Hh1mhGVmKoHuS5Lp83LdCbUogMfguRNoxQQQHsFXwP9xG/qc1zHb75Sj
         DP+7muMPA282tgzvSoY4n3DRZQpLPJg+SncnJ4BHCxwlT9iXk7AyEBtok6WsJ4QoSXx4
         ch0dZiGf+nOZR9WTt+3AazxQpyueS/AzEodj5Lo30qFaPGh4MFWM04DTbmJ549LZyDYA
         2pjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ctDTPE+1uUrvGDY1YjodOAzX57ds3DQwAPzceeYfPdk=;
        b=bC7w/JopsokcUWMpT8YBzEDqibb61R5DibiM0l5AukE9Hd8oIeouEBuQaxDFrlUZgy
         Qmd4JrUlLcv+OoDBCtHg1AIjX2FIQExsZ1qC/kpk2EUlJmUYwnnSy5VyTFBU1GOKJyCX
         t+L3lyjNBNiGsKLW4ABFyStahZ7tHAx6ajyUsXtA5CraoOID64w14RJzNk2+dv3q1UqX
         xVOk7Yd25FemEXDRISE1DR47cW5mxTf8DFMKMRRFGnXCTzCjTdRra0aOs0wh8NIdXCFd
         Fy6dqHLuqeDQYn9B6++kbxecOrvptLW3uY2cST/8MIaeNTnp+++Iiw0J/3mCCR/UIAD7
         QrmQ==
X-Gm-Message-State: AOAM532Ftu5tij7rqUAcgZBqhZEohaoGWRin49nPo6rwYd9IkP5+uJhe
	yzsz3345/sB35Y1OyUz3e4T5KNFDsoRpgQ9yeE0=
X-Google-Smtp-Source: ABdhPJzFChG9fc2lXHtNtRYI1OfcsBARgjfya938LehSes1ZExkj2SdR8N9Ps0shYsEpEFKSkUW63g==
X-Received: by 2002:a17:902:d4d2:b0:152:fd44:5004 with SMTP id o18-20020a170902d4d200b00152fd445004mr1558899plg.99.1647470620157;
        Wed, 16 Mar 2022 15:43:40 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c5-20020a056a00248500b004f6b5ddcc65sm4316923pfv.199.2022.03.16.15.43.39
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 15:43:39 -0700 (PDT)
Message-ID: <6232681b.1c69fb81.413ec.acdb@mx.google.com>
Date: Wed, 16 Mar 2022 15:43:39 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.104-cip3-132-g46c091c34fabb
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-cip-nfs: 7 runs, 1 regressions (v5.10.104-cip3-132-g46c091c34fabb) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-cip-nfs: 7 runs, 1 regr=
essions (v5.10.104-cip3-132-g46c091c34fabb)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.104-cip3-132-g46c091c34fabb/plan/baseline=
-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.104-cip3-132-g46c091c34fabb
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      46c091c34fabba36aab030f3c3c0d43214e7806e =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6232598244af43439bc62977

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-132-g46c091c34fabb/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-cip-nfs-hp-x360-12b-n4000-octopus.=
txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-132-g46c091c34fabb/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-cip-nfs-hp-x360-12b-n4000-octopus.=
html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-amd64/cip-core-image-kernelci-cip-core-buster-qemu-amd64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/6232598244af4=
3439bc62978
        new failure (last pass: v5.10.100-cip2-484-gede5006fb276) =

 =20

