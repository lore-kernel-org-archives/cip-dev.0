X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web11.1646.1646795168192799760
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 08 Mar 2022 19:06:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=RHKAAyHh;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id v4so1132317pjh.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 08 Mar 2022 19:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=1883JcYLhUhWCN65+bZ+VdJlBNhZA7Gh9ID3JokjaHo=;
        b=RHKAAyHhlW7N2sbVx6vdpqdUxAbiaNVifk+eBXMw+LqcqymUHlj38z9nX7GL+MlMnk
         KaEL4CXb7D3MR9dGu+c6TiMhn++QZf09ZEkxrnf3aNTUSkiShqaK0W+2PWUOxnt/fwEy
         sFFZngFjZQyPIHWLLWDduvqKjv6Df5MuRRXIxyPSu49Z9IOnNewaG+75sz+0pGYtL48h
         P9rFVa8Iap4g3zrPLVcm8/O++X4EZ7jWR2l0Wm9VcRsNAMtLe0mxkkWjXX9w4P2teKbE
         8U7koreJ0vUHycJ2ykCFTBLahPZ1JnvFqq0UVwLyE9UcMZUylHZ0st9+RP8TQeDGE6j+
         hk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=1883JcYLhUhWCN65+bZ+VdJlBNhZA7Gh9ID3JokjaHo=;
        b=hZ7hVlCOkXWKPgaKeVLSEU+Zy4Fi8new3ofA13RXkIe2DsNoCCJ6cOvVPuQ8vsKAw/
         RcPDJAlVmQdgjHPJv6Jjxa3NGjThnyrD6Xx0rF2tlGAWtCrfL9dpd9rdwJSCyvfZud1R
         0wVn6SmGB2xyjlHEsjdGVojXSaGilIHeRdJEDM2984XLq5RGb1Q2xhetFlqp3+Q5Uqey
         JooxgtQsPX1+iAsfbacKlBej2YL19i+DtcM6GLm5QXBl6BXiCbR4lkwLoQWwy7nP4PI8
         7kPLceXJcEiCYNgGDPljKhzHeBuhgaphoyTHADsf6GKm9kPKq+lBUuUNjS7vxla1VVLj
         iZrA==
X-Gm-Message-State: AOAM533Pqp/sJQJi5dX1GRlPKjS4w5sN8kXUSc7SoxlKRkAAsoQcJPs8
	ZJwETi6FuJeGQqjkaVYsRaBV0Y5wctShMzpsFNM=
X-Google-Smtp-Source: ABdhPJxXvU6AYb+sNwKlgHDOzSNntmfOEQu4x4NABz1A93g2hc4XmMxWhdvMahGN42h0VrFrDRCXxQ==
X-Received: by 2002:a17:902:c3cd:b0:151:806d:1b9b with SMTP id j13-20020a170902c3cd00b00151806d1b9bmr21602381plj.98.1646795167064;
        Tue, 08 Mar 2022 19:06:07 -0800 (PST)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z11-20020a056a001d8b00b004f74f8268cbsm474369pfw.85.2022.03.08.19.06.06
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 19:06:06 -0800 (PST)
Message-ID: <6228199e.1c69fb81.25995.227b@mx.google.com>
Date: Tue, 08 Mar 2022 19:06:06 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.100-cip2-425-g0a0d92194f39
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-mm: 7 runs, 1 regressions (v5.10.100-cip2-425-g0a0d92194f39) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-mm: 7 runs, 1 regressions (v=
5.10.100-cip2-425-g0a0d92194f39)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.100-cip2-425-g0a0d92194f39/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.100-cip2-425-g0a0d92194f39
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      0a0d92194f399a5095878cd6edf9060eb4244d81

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  67eccca54eb68a1bc91cf1f140fc43fa8085d8ed =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/622809cff4fd59df20c62969

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.100-cip2-425-g0a0d92194f39/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-mm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.100-cip2-425-g0a0d92194f39/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-mm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220228.1/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/622809cff4fd59df20c6296a
        new failure (last pass: v5.10.100-cip2-319-gcbff87047566) =

 =20

