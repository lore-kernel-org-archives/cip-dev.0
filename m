Return-Path: <SRS0=8wHb=LZ=lists.cip-project.org=bounce+64572+6589+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9390DC11F64
	for <cip-dev@archiver.kernel.org>; Thu,  1 Jul 2021 09:26:19 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 635E761490
	for <cip-dev@archiver.kernel.org>; Thu,  1 Jul 2021 09:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 635E761490
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6589+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id BeRVYY4521723xEFa5lriUeY; Thu, 01 Jul 2021 02:26:17 -0700
X-Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
 by mx.groups.io with SMTP id smtpd.web11.4660.1625131574954427943
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Jul 2021 02:26:17 -0700
X-Received: by mail-ot1-f43.google.com with SMTP id v6-20020a0568300906b0290464d9be9510so5833292ott.12
        for <cip-dev@lists.cip-project.org>; Thu, 01 Jul 2021 02:26:14 -0700 (PDT)
X-Gm-Message-State: MnB7kFPz2HhtQIVLYIvUuLESx4520388AA=
X-Google-Smtp-Source: ABdhPJzn6yhjmdC5LtoJOyren/u2esLr4DvFDTJ5W2NUigIQyZN0hCHareRgs3sdrSmcQ6oWdLjKkfsYKTDKXIBpzD8=
X-Received: by 2002:a05:6830:2649:: with SMTP id f9mr13153161otu.179.1625131574132;
 Thu, 01 Jul 2021 02:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <168CAFBE1BE94C78.17502@lists.cip-project.org>
In-Reply-To: <168CAFBE1BE94C78.17502@lists.cip-project.org>
From: =?UTF-8?B?5biC5bed5q2j576O?= <masami.ichikawa@miraclelinux.com>
Date: Thu, 1 Jul 2021 18:25:39 +0900
Message-ID: <CAODzB9rLz=+TJLgR+FQ2F+1yKpJjitGMhqK4G4zVn45PcXDytg@mail.gmail.com>
Subject: Re: [cip-dev] cannot push to cip-kernel-sec repository
To: cip-dev@lists.cip-project.org, nobuhiro1.iwamatsu@toshiba.co.jp
Cc: masashi.kudo@cybertrust.co.jp
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="Ip1ByIZzZphDleOjtMx5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1625131577;
 bh=q3xJZJy34kS+M0zVybnnTgEH6qebNLbrRNFd9cmF0Mw=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=DsxlwUkAAiDCjfnZ3gZvf478GYRA8Jt+fmfFbg1eLzZAsyNxUOi2uUTZ2li9IK4Ozej
 TI4Nagcpcenqp3C/WF9Tlvk3telntzFRcvfeDoxXCh9lR+UlIcjRgLKdIT6YWuYa6qwKy
 60451GWLd1abCpAXvDpJyeAL+K4cZEM9Nu4=

--Ip1ByIZzZphDleOjtMx5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Iwamatsu-san

Would you mind taking a look it, please?

2021=E5=B9=B46=E6=9C=8828=E6=97=A5(=E6=9C=88) 16:53 =E5=B8=82=E5=B7=9D=E6=
=AD=A3=E7=BE=8E via lists.cip-project.org
<masami.ichikawa=3Dmiraclelinux.com@lists.cip-project.org>:
>
> Hi, Iwamatsu-san
>
> When I push commit to the cip-kernel-sec repository,  I get the followin=
g error.
>
> masami@debian:~/cip/cip-kernel-sec$ git push -u origin master
> Enumerating objects: 1557, done.
> Counting objects: 100% (1557/1557), done.
> Delta compression using up to 2 threads
> Compressing objects: 100% (811/811), done.
> Writing objects: 100% (811/811), 186.14 KiB | 6.89 MiB/s, done.
> Total 811 (delta 742), reused 0 (delta 0)
> remote: Resolving deltas: 100% (742/742), completed with 741 local objec=
ts.
> remote: GitLab: You are not allowed to push code to protected branches
> on this project.
> To gitlab.com:cip-project/cip-kernel/cip-kernel-sec.git
>  ! [remote rejected] master -> master (pre-receive hook declined)
>
> It looks like I don't have permission to push the master branch.
> Would you mind giving me permission to push, please?
>
> Regards,
>
> --
> Masami Ichikawa
> Cybertrust Japan Co., Ltd.
>
> Email :masami.ichikawa@cybertrust.co.jp
>           :masami.ichikawa@miraclelinux.com
>
>=20
>

Regards,
--=20
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

--Ip1ByIZzZphDleOjtMx5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6589): https://lists.cip-project.org/g/cip-dev/message=
/6589
Mute This Topic: https://lists.cip-project.org/mt/83840144/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Ip1ByIZzZphDleOjtMx5--
