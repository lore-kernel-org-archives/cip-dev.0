X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.web12.6111.1653670299970429716
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 27 May 2022 09:51:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=wtG9oFgm;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.49, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f49.google.com with SMTP id q92-20020a17090a17e500b001e0817e77f6so7570672pja.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 27 May 2022 09:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=MQ/vfbCcSwewbYd9nM2Xbf5GjkoapHMuqghuPOqR5cA=;
        b=wtG9oFgm1jEC9FhY2gPNnBcU9kdCiFc+Njar1C24NOOMVXcV8AT/q1RStCD5g0kBrb
         gy6RCUPbpKU0vmAtM4fttN3ZPzoVlyCZGNfGSRpiKqJhGy733kkmJt4LQM0rmeX1/u94
         81FuAcSxMcUqaOaszRiZfM+JjjgchMDw0QiDhmkwjbODf5gC7XaZm+zrXvp572BmXu+w
         5VAafA4BYQdv/g7O8EJy512y03DeRjDeXcJFwFB3galr1mUZ+C6WfHbPYqE9bEAmWzOw
         UsQ9ZlGsX7Rd1fNjTtInz7wDpkgh2ImS/muThb1tcvphPVRCQabBrb8Qt+sxe5FmYfDo
         ynFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=MQ/vfbCcSwewbYd9nM2Xbf5GjkoapHMuqghuPOqR5cA=;
        b=TVSug3BOIXfHw0iCvyQ5YbEGfy1Wl+e7Bmho6nwxTw3HcUBHyycVht0ZgdI/oi27kF
         wYi30+z+SWK4/dq8wWoToOjXi5JoNmLhMMi2YNm1JaK1jSu9M402UO9Ugwlqb88TxahS
         JmFmPD7pwdZ5sIIx5apORngWoo32OcPxYaH4yj069TWaUAJnaqJk+kxZANg80PFynQvp
         Y8niKtVnDYAmUt9tXvwEPeTTkvVK3borRGSstZYBi2MESNkVuB+IZCmHcFk4lvC5ynj0
         dm9eyylF3HQTuNXbH5LQYXtQwBk0R+/x1DPBr2dgY/okk8Df+YkI2m+bV8URLBdQpdUr
         WEiw==
X-Gm-Message-State: AOAM532CxGKOBQZ6FNPowGSloQCd/kkDLZZbKyPCXLGUOMONINBQNL+w
	/OoF+hq/AcqncKw1dph4FYC8RRItusW4YD2oO+Q=
X-Google-Smtp-Source: ABdhPJwxrXEVv3eLRrOurRoAecNQzu+ltorr4HgYRhchnsYvUc2XMsi/ANv8wLE8BJURo6b1iYjcNQ==
X-Received: by 2002:a17:903:32d1:b0:163:8181:be69 with SMTP id i17-20020a17090332d100b001638181be69mr7486553plr.143.1653670299152;
        Fri, 27 May 2022 09:51:39 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902e9d300b0015e8d4eb216sm4037330plk.96.2022.05.27.09.51.37
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 09:51:38 -0700 (PDT)
Message-ID: <6291019a.1c69fb81.a3c2c.9347@mx.google.com>
Date: Fri, 27 May 2022 09:51:38 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.112-cip6
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 23 runs, 3 regressions (v5.10.112-cip6) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test baseline-nfs: 23 runs, 3 regressions (v5.10.=
112-cip6)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 3          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.112-cip6/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.112-cip6
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c8f6747dcd02a8f87731c324f4bc37bd120a8982 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 3          =


  Details:     https://kernelci.org/test/plan/id/6290febf2e72f74fa2a39be4

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.112-cip6/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/basel=
ine-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.112-cip6/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/basel=
ine-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220513.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.cros-ec-sensors-gyro0-probed: https://kernelci.org/=
test/case/id/6290febf2e72f74fa2a39c27
        failing since 17 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a)

    2022-05-27T16:39:14.787459  [   34.142791] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-sensors-accel1-probed RESULT=3Dfail>
    2022-05-27T16:39:15.835294  /lava-6489125/1/../bin/lava-test-case
    2022-05-27T16:39:15.872873  [   35.228683] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-sensors-gyro0-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cros-ec-sensors-accel1-probed: https://kernelci.org=
/test/case/id/6290febf2e72f74fa2a39c28
        failing since 17 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a)

    2022-05-27T16:39:14.751571  /lava-6489125/1/../bin/lava-test-case   =


  * baseline-nfs.bootrr.cros-ec-sensors-accel0-probed: https://kernelci.org=
/test/case/id/6290febf2e72f74fa2a39c29
        failing since 17 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a)

    2022-05-27T16:39:12.635947  [   31.991095] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-sensors-driver-present RESULT=3Dpass>
    2022-05-27T16:39:13.676986  /lava-6489125/1/../bin/lava-test-case
    2022-05-27T16:39:13.709676  [   33.065601] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-sensors-accel0-probed RESULT=3Dfail>   =

 =20

