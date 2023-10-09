Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CD1CD6123
	for <webhook@archiver.kernel.org>; Mon,  9 Oct 2023 18:47:22 +0000 (UTC)
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
 by mx.groups.io with SMTP id smtpd.web10.71572.1696877239966378842
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 09 Oct 2023 11:47:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Fmy4dNr1;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.161.51, mailfrom: bot@kernelci.org)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-57bab4e9e1aso2927766eaf.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 09 Oct 2023 11:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696877239; x=1697482039; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wTFV5h4V/9JcjWoI37QSCMeHgsTLHBC8BY+T7RBrzJs=;
        b=Fmy4dNr1//nvI07UPYnTUUkPFikQNSF1QMdvptJnOdRlcUpSy4fzsHpGH/ueqc2HDi
         cQ8rFXVB9nGurfFYKtxgYzeI0WtproLYYKACxbfL9Gi8WltjAQegBuIqEmpjnEgMes+p
         MR4zFSgewHWQGCyHf/qTDZV/edGVW0WV4DwEkTbjh5iI+pWUQs/RBnV8xltxQnxAtTOr
         b9qcERTTzZKuVNHJyH9nGfwUKfO76JLelXVvlaYsSBTvvG3t97RU/X9cT0S0bjRzD2du
         8PuVHb3jezwmJ0IY5JMAHlCjuIb8yvvCIS6/rfDeOo4e4Gig7cvuy8Y12VL3Spj9IpR8
         orHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696877239; x=1697482039;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wTFV5h4V/9JcjWoI37QSCMeHgsTLHBC8BY+T7RBrzJs=;
        b=tcSZzRtTiC/A5NFIV0D+D8iMRbmxSyLUPedkmiZt1c/9hMPkrLgbRSivFkUxF7sQrd
         NVEbnb2JJxvQyp1fMRN/JCYRWACcQ0EdyK5GWJT76MKV0TgyCZOmETaM68AoCTe28I5/
         pj0/3YBJCzYXum0cEItzs0mMtOJ0qBPJoDH/UZpudfLdwwwPVi8AC9MWu7Qr4C3ZUDtj
         ejPqz/Jt+2Nxs3ejN5tT2d+FrgVgnEu9006pRD9AjrE9qrcwup/X8a/lDtwsY2bohVXk
         Kq0c7x9b01woZ8YCWDI+pT5TRKyPAn5PQpnUt5Lzh3cwcBGVqeXUMh2nDm/4c/ePPBM3
         ZsCg==
X-Gm-Message-State: AOJu0YxPpekhLeWVef/51XLvF1/CODKQ6n13GqAt2z51giS9gYeZE8Nv
	qRiUJb4u3/6NYzz5BOVYJnJuzBIZQEkFNMmYWbglow==
X-Google-Smtp-Source: AGHT+IFigwIUS5G2xrXICzoEH+n55u6hI0BwU5JY2HCk/dhNpyVxiPgPM0dihqpQSjbIdGWaQNz6Fg==
X-Received: by 2002:a05:6358:72a:b0:139:bbae:1f3 with SMTP id e42-20020a056358072a00b00139bbae01f3mr15194107rwj.3.1696877238881;
        Mon, 09 Oct 2023 11:47:18 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k22-20020aa78216000000b0069337938be8sm6702208pfi.110.2023.10.09.11.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 11:47:17 -0700 (PDT)
Message-ID: <65244ab5.a70a0220.ea0c3.f040@mx.google.com>
Date: Mon, 09 Oct 2023 11:47:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4-st20-1778-g3b01feff09495
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.4.y-st
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-st ltp-timers: 8 runs,
 1 regressions (v4.4-st20-1778-g3b01feff09495)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Oct 2023 18:47:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13333

cip/linux-4.4.y-st ltp-timers: 8 runs, 1 regressions (v4.4-st20-1778-g3b01f=
eff09495)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st/kernel/=
v4.4-st20-1778-g3b01feff09495/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-4.4.y-st
  Describe: v4.4-st20-1778-g3b01feff09495
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      3b01feff09495bfdcf43283997a6ea6c6bf6c649

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6524422b160d0c9c27efcf0a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
778-g3b01feff09495/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
778-g3b01feff09495/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6524422b160d0c9c27e=
fcf0b
        failing since 125 days (last pass: v4.4-st20-1187-g8497d3390dc2, fi=
rst fail: v4.4-st20-1308-ge1d2f27f3d7b0) =

 =20

