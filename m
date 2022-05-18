X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
 by mx.groups.io with SMTP id smtpd.web08.1706.1652906474513630625
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 May 2022 13:41:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=PeVgI7pX;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.182, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f182.google.com with SMTP id q76so3157648pgq.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 May 2022 13:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Ay7EkW3KWgEVV485S8fV6IXBt/OEU6sWSTgj8cAtG0o=;
        b=PeVgI7pX3UCTrzjhcFZe1DxVzkDr7BpZ4vOhprO8Qlz8Xhy088KfGenegxf4ktiTpj
         QTI7sY3cdH7Eqn1zul1p/zoZsLf84Zse5+QxLF3rHrCFwoOevKZTXYM+z2xPzaqxgEyO
         8bpAVGpIZiXaExEmpco3/VpnAQDlUYxiV18dAP0AOBnonrlqUo653UV0CrXbkoNM3HX8
         vHbqckWL50Ytsu8PGoD1gN2DmdtDCe07h9ELeLuwzG7me6+aUYx9iWKSBr0PTSwpxtqd
         m890sAnFExcz49dtHDyb2vu8m4xO2blRObO+0VOThVUJizEsC8hSkfCEReB+vgj+PhNf
         WtlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Ay7EkW3KWgEVV485S8fV6IXBt/OEU6sWSTgj8cAtG0o=;
        b=VtZT+EQ+d4SgGdezSwk6adN1xWihi8IDB2vNpg3t5UkVSNxiR3Vaig49wZ9WUdhGIu
         WKwp9BDr6af7nJ76ZwYGIkY9xR7y5EBLZFmejYakKNqdWVLbrOvPQMq/3Pdrc8h+JFl+
         kqJNk6junkk39EKMn8NpYH/COlZ2TuKH5LNlJERsZmm9pyUjgcWrS8Iff8zlm/5btwiy
         yzChcNnor54wzjJlkJEWdNiqq08PfZ3o2maZ6wEZdXnImMdWAprGzGDdZlvmackbRtNX
         xoR38eWKbBSStdAW9c9ADuUzy/7MPYWdDoiaNJV3l9ZeAwb1o8LYPx+BjF3ola8WI2no
         ZGDA==
X-Gm-Message-State: AOAM531FFv3D01T50baZKzYpcaqGbqpcov3Ge4kWAO4KcnZ3Vxd5puwF
	AAICnKqMu7g0E5q7sXghdOwQuHyNerqmLAur2Xk=
X-Google-Smtp-Source: ABdhPJwAvfph+RTO3Kx+qs/NI058NcrxpECNebvLZ7pqhCpTJ0S3ZLefp9ifyuI2qFfCrKRh+zCS8g==
X-Received: by 2002:a63:f057:0:b0:3db:8238:ed3d with SMTP id s23-20020a63f057000000b003db8238ed3dmr1018386pgj.345.1652906473601;
        Wed, 18 May 2022 13:41:13 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w2-20020a62c702000000b0050dc7628161sm2340939pfg.59.2022.05.18.13.41.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 13:41:13 -0700 (PDT)
Message-ID: <628559e9.1c69fb81.f8f2b.5cfd@mx.google.com>
Date: Wed, 18 May 2022 13:41:13 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.115-cip7-81-gd05f72e501084
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 10 runs, 1 regressions (v5.10.115-cip7-81-gd05f72e501084) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 10 runs, =
1 regressions (v5.10.115-cip7-81-gd05f72e501084)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.115-cip7-81-gd05f72e501084/plan/kselftest=
-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.115-cip7-81-gd05f72e501084
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      d05f72e501084803c8658a71668fc1aadb075165 =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6285462874fa629c2da39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.115-cip7-81-gd05f72e501084/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/kselftest-filesystems-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.115-cip7-81-gd05f72e501084/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/kselftest-filesystems-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220513.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/62854628=
74fa629c2da39bce
        new failure (last pass: v5.10.112-cip6-289-g2969e096d186) =

 =20

