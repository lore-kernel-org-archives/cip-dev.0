X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web11.9648.1648044402921618379
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 23 Mar 2022 07:06:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=A/s+3WRi;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id d19so1580552pfv.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 23 Mar 2022 07:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=LAbzZqTCmguIx3gWPXi4Z9W6E0/oHl1AmdM3Lk/ilE8=;
        b=A/s+3WRiDIYsJJKCII74Vl0Z7T5oHcYXd8IMlBFsrcoq3WfClpLk1++9W++5ulWcKo
         3kDtWht54rr12V3FESo6PMdr5BAGeRmNbXTZjvGCgVc2xqLEimjuT6Ni9+NxXFRLNYoN
         LXqGX1CA/5X2pcL00OsbCGHl0Xppu9GQXZPclz4egz0W3BEi5Kv7LxLTOws32N2v2gG3
         aHzSBSMGLnOMfjhrjAO3lNZdhMo3tphYApjkVnyvNYC0Z19PTajspWhJWKo3Fsf6bzIN
         OCksbxf+d/SmGdbyOJxO84hg+xMbk0/9S61XtfADl/wmg+AGPcW8qXl9L2e2Hr0WEDwy
         mRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=LAbzZqTCmguIx3gWPXi4Z9W6E0/oHl1AmdM3Lk/ilE8=;
        b=4W0c+a388lEHrEthuBJtw/PG5bUYm3lCxCsl8d4v87zrtEciCjbVemmFAP2kdL4nc6
         3eJs2W2+zoeKRPKZFor4MswsSYR2Fhwcp6+DGkzxfm8MP46+eNRZXwXlJ3g8jgZ4q7NV
         srNa+jrDRYSFNorfWyCN3/Jj7gMW6+kEKlHeJFH1qAwSDOk6ze9V8V3QaA6tZK3I/quu
         whBRx9jE2W03ZQWn7fm1QTvPCnXG7QDb97JZoaz6rqniyPXJlRpUI3bTcy1wqmMjRyE+
         K59weY9A+I4lyxwvLmu6hJPContWTTpG+fGeTEuexISbC+YONxIn9uLNSFJJ6noPmGlL
         O6gg==
X-Gm-Message-State: AOAM530Rnv0tOI/MoAJ/4yr1VJj682oKZZoJf2CIPCkFD6aBQtw5n87o
	KzJSCa1tfq1b+CCceLyuW3rc0mlPKQXdsi+3PEg=
X-Google-Smtp-Source: ABdhPJz9BNdWXQb315tRm9T36jZfYhJ+ItBPsslycUDX9OHdHUMsxdXcUbwtCWxDBScS+8/hhyUk6A==
X-Received: by 2002:a65:6657:0:b0:381:1b99:3f04 with SMTP id z23-20020a656657000000b003811b993f04mr73027pgv.512.1648044402163;
        Wed, 23 Mar 2022 07:06:42 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f8-20020a056a00238800b004f7a066c904sm100969pfc.96.2022.03.23.07.06.41
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 07:06:41 -0700 (PDT)
Message-ID: <623b2971.1c69fb81.d1cc0.0427@mx.google.com>
Date: Wed, 23 Mar 2022 07:06:41 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v5.10.104-cip3-186-g758e0f22e236
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 19 runs, 1 regressions (v5.10.104-cip3-186-g758e0f22e236) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 19 runs, 1 regress=
ions (v5.10.104-cip3-186-g758e0f22e236)

Regressions Summary
-------------------

platform            | arch  | lab          | compiler | defconfig | regress=
ions
--------------------+-------+--------------+----------+-----------+--------=
----
r8a77950-salvator-x | arm64 | lab-baylibre | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.104-cip3-186-g758e0f22e236/plan/baseline-=
nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.104-cip3-186-g758e0f22e236
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      758e0f22e2369c3d29d49c89c4ab585390c74a82 =



Test Regressions
---------------- =



platform            | arch  | lab          | compiler | defconfig | regress=
ions
--------------------+-------+--------------+----------+-----------+--------=
----
r8a77950-salvator-x | arm64 | lab-baylibre | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/623b20ce65c3e036f2bd9189

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-186-g758e0f22e236/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-nfs-r8a77950-salvator-x.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-186-g758e0f22e236/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-nfs-r8a77950-salvator-x.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220311.1/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/623b20ce65c3e036f=
2bd918a
        failing since 1 day (last pass: v5.10.104-cip3-132-g46c091c34fabb, =
first fail: v5.10.104-cip3-155-g4f07dbd2df49e) =

 =20

