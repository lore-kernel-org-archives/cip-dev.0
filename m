X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.web09.6465.1649899346904518939
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Apr 2022 18:22:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=h6odjOHp;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.176, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f176.google.com with SMTP id q12so3377684pgj.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Apr 2022 18:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=aDMFV6zyZhhGFYIxh3Pzi7jfn8VGJvEXyueekWWhJ0g=;
        b=h6odjOHp0mQ+W/asESPZhjkGbzjNsl+NDFgwd/yBBA8o9w/lHZmTCt5wKV7BhQAR4Z
         ZqXhSczBMXR1hhGYQlLPGBCsPtIMK13CnxpO1CKloxQgaER/z0gNhkLpeCQJBWOwcnsQ
         SLH6LLAm6ujk1etblVfvER2t42qouAx2WH/FNVNI5dR7SgbmoIfxvWUVxM4+Vg8gmMU7
         z+w6WuptmNP+IwVqp4Ukp+k+KlC5MwC6RG7v8qJdMzIiFDcfQ3MGk6kPRjss3mCsHw+p
         yQ2SYeCuKwMXwrjul1QrT6bixCa8MsOPgPxF6xYWltqt1oQ3orjqW/pfN+NnYSBBpas6
         H0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=aDMFV6zyZhhGFYIxh3Pzi7jfn8VGJvEXyueekWWhJ0g=;
        b=59rnZMdGo/1iOqQbtvF/Y2af+S1PsSa+0LiPano4Ll3ZSkSK+rJAHlbK6GEPPihoXd
         WmG7vCol9pnhv897v9fy6qrRHOky0d1M79+YJ6jgGUGCSe7N7JvQuAQVBC2EpuXK7N9I
         AKHAMZ6Rtpu/sBBolmviU7JZRDNAdf6aDoV2koqevP31+VQSCp2nQFaV6V7z9Ed02rCp
         vaS/bTvGZHJ7i5LmtiUI1Bg0WwDf3JwITQBFAgbllkEy6DwhG9Q2mwNrxF4rt9gz6INg
         mSkIdj24rmhEn65lJfjBvC5Tu5E+0SJtmQfVudumJJcqOZMUl2IrpJa8PC683KOIl80X
         ff+A==
X-Gm-Message-State: AOAM533OjqTf6bNeH4tgkWVOhg23UyefUBM8X+jVeV2S5vkH+1aY3yRi
	5Y7HCbZJmTHIVPn/LkjHknLjWTbn8tEej5/i
X-Google-Smtp-Source: ABdhPJxjjnNyPC+wvPlDleAjQOHdF58CjKmZn158pn01LAvTcGxzwIuCNDI6s3E0ieZxr+8yswa5VQ==
X-Received: by 2002:a05:6a00:b92:b0:4fa:82e9:786c with SMTP id g18-20020a056a000b9200b004fa82e9786cmr12499143pfj.31.1649899346186;
        Wed, 13 Apr 2022 18:22:26 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p4-20020a637404000000b00375948e63d6sm294382pgc.91.2022.04.13.18.22.25
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 18:22:25 -0700 (PDT)
Message-ID: <62577751.1c69fb81.9dfe9.13e4@mx.google.com>
Date: Wed, 13 Apr 2022 18:22:25 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.109-cip5-770-g2801336f0f208
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 10 runs, 1 regressions (v5.10.109-cip5-770-g2801336f0f208) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 10 runs, 1 regress=
ions (v5.10.109-cip5-770-g2801336f0f208)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.109-cip5-770-g2801336f0f208/plan/baseline=
-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.109-cip5-770-g2801336f0f208
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2801336f0f2089b0d935efe67d93eccaa85e4bec =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62576ca919771fcd72ae068d

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-770-g2801336f0f208/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-770-g2801336f0f208/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220401.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/62576caa19771fcd72ae06af
        failing since 35 days (last pass: v5.10.100-cip2-319-gcbff87047566,=
 first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-04-14T00:36:37.575427  /lava-6084514/1/../bin/lava-test-case
    2022-04-14T00:36:37.603210  <8>[   96.287180] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

