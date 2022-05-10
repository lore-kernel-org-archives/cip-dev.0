X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web09.9088.1652184958591528877
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 10 May 2022 05:15:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=2p8I+pdU;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.42, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f42.google.com with SMTP id cu23-20020a17090afa9700b001d98d8e53b7so1871304pjb.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 10 May 2022 05:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=M8W4jrRXWqZgqmMKyblb4+sdcHQdM5FsIPogUcXqBeM=;
        b=2p8I+pdUQG8RF1vKIdnOkNl7RzR0/xC07ZWhK9jZK1Anop3bsOaoi4rJ4D6+wCp1lt
         f75/H8eqq95XQIAaAzqXgIHjodWo2DIZ9Z5Bxm5bLYfATgsDY82H4r3C4Xi9SNZjGgOt
         HBnYr79OTE0gph4ryIWM9wLQPjrTdKhCFvBaU5AY66XiGh2as25BNzKEhTD4oo3S5VZA
         tagN7yIuZakbvNR8809O31fNw9b5FnnWdFmJMErju89yuGxiBj+BxRzbnD1MRfiVJjHd
         Ze/5Zn5ASqbLf24Xc1xAFf8nK0DCmR/FaHp5QqTk+pJaXqefbx7SIGj/eSsBfQA35p63
         6Idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=M8W4jrRXWqZgqmMKyblb4+sdcHQdM5FsIPogUcXqBeM=;
        b=uH72jhLwcs8GB70eAxGvvHCqnSZD2hw9nCvRasH8kOZq4VH3hNc1jOU3wGLVq6IQBW
         0bS85YH52AxppNdT+jUUKmJgIaaWHTFHstXBT61n4ksgNQSEtjZhFMaY1jWBVxjIuMMC
         hErtyJ0E9t2TodxN18iSMAS9LCPXFQuEnUQFBtwjUYWuJhHAZD/lZg1cXYcYCq8ZaDGx
         d7lYRerGeRw96pPbkKCEILfx4r/O9JYAfH9Yxpt8NsRBT893dsSKPUu75YZlUg2uOssH
         NTCvD+Mvd9m2cUrg+reYtJlYcsI+ceIFlH0M+uOsRioUBmkoHweaP5SovNPuHa/W5Iry
         RQNw==
X-Gm-Message-State: AOAM533FPU1RlWZnEFeTADA5F36kXwLChzgTzZxdP4OfQJ6vbndHNWzf
	05OtPk4I2ogoDXYNoZiWOaGfmRhrSvN+WfclmXo=
X-Google-Smtp-Source: ABdhPJzc8Cy3xP2sJEwGz7qH6ArjOIDN0h/oGgoOtYz/C9TuvznWZJbeJ2HW5QiYAQ21/j+vgXAvTw==
X-Received: by 2002:a17:902:bd4b:b0:15e:ea25:94f0 with SMTP id b11-20020a170902bd4b00b0015eea2594f0mr19928009plx.105.1652184957756;
        Tue, 10 May 2022 05:15:57 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q20-20020a17090aa01400b001cd4989fed4sm1684498pjp.32.2022.05.10.05.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 05:15:57 -0700 (PDT)
Message-ID: <627a577d.1c69fb81.502e4.3dba@mx.google.com>
Date: Tue, 10 May 2022 05:15:57 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Kernel: v5.10.109-cip5-rt4
Subject: cip/linux-5.10.y-cip-rt baseline: 73 runs, 1 regressions (v5.10.109-cip5-rt4) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip-rt baseline: 73 runs, 1 regressions (v5.10.109-cip5-rt=
4)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.109-cip5-rt4/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.109-cip5-rt4
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      b41186882eaf0137277045da13ea649577c42c11 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/627a5153c7e17b9b3e8f573f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
109-cip5-rt4/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h=
64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
109-cip5-rt4/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h=
64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627a5153c7e17b9b3e8f5=
740
        failing since 74 days (last pass: v5.10.83-cip1-rt1, first fail: v5=
.10.100-cip2-rt2) =

 =20

