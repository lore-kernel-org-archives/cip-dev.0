Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0952C433F5
	for <webhook@archiver.kernel.org>; Thu, 25 Nov 2021 12:01:22 +0000 (UTC)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53])
 by mx.groups.io with SMTP id smtpd.web08.11261.1637841680805551615
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Nov 2021 04:01:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=ixwlmWwG;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.53,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f53.google.com with SMTP id
 r10-20020a056830080a00b0055c8fd2cebdso9066938ots.6
        for <cip-dev@lists.cip-project.org>;
 Thu, 25 Nov 2021 04:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=BQmXRNIt5ttUcOYQIvOzCyV2T8NpQHsw4mt8UZXUQwE=;
        b=ixwlmWwGG4eii3j7CAbiVfiD+8Ph/KL4HI1i/dV+0ampiC7hYPGIEaZu14ESb0y8tn
         O/Hm7zpFq8ws6f96Lhdgd5Prw9RTbstkxemFQXxVKMuqOS9+EFxjPTp8TgKz1QGMSpwc
         tVKh5GpRMzW3uabI/Xq9pxaXiX94qcYE3MBcgRoSGGs9aZp4dXJysaa8elBJPXjYhBIR
         laJjIoSX9uQICb9tqaDUk7ivgarFjgmFZKsDbARQsWcYhBqFYOEB+ZAqwNCWqVcdrh8A
         LJbWE2JNY8yiTWaMcm6t6j7ebfw6IZou6h+dWyLd4CuQddDK61So6uyUMmNpSJjGeyG/
         nt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=BQmXRNIt5ttUcOYQIvOzCyV2T8NpQHsw4mt8UZXUQwE=;
        b=Ekhw4mQUSXr2Eq5RocnBlS9Zy54MF1zHsHsZhuzohvSk40UEsWyAFNna6Wf8Da4F1O
         0bqI+he9Yta3IHi7B1deH2sIjA4mCm0EA53q5wU7A2THuE1Kpx5sdFa5YAl+xDD9pI1V
         v7yT8OE+fM9cgEtVL0r93kt40SShUrBz22BGmh2GQ3Oq7ebIt36gRLlYs6p64wxu0tm0
         bqQFbGlgu7VULo68DLTc/8diIoYuPLc7On0FkAnhx5ZzwPmb0jVnQO8yobpGhSOvNise
         de0t8dSwAxzGddb6pLYerv3Bb+XLx8yIvHKWk3LTqKhoQjS/bphFB1WW5wIC4pgm73QT
         HBaw==
X-Gm-Message-State: AOAM532Ht588gggRJG9uH1s0iGdLNQdocxOtlYXgxP4v+ATebOoIRj9c
	HaXSGV24FGbDsgIiiyBDHGcBZ0f5XBeGyjZnKRIdPfh3yaM=
X-Google-Smtp-Source: 
 ABdhPJy3t488AkjT3DncOiY6HcbZbNPRP5vGST97FkyEeYR760QgqwbW8FC+fkCU7WrSQK3EFFf0rS5CK+kx8pQRJqo=
X-Received: by 2002:a9d:12b4:: with SMTP id
 g49mr21001851otg.232.1637841675208;
 Thu, 25 Nov 2021 04:01:15 -0800 (PST)
MIME-Version: 1.0
References: <16BAA9D56D09F20A.23256@lists.cip-project.org>
 <CAODzB9pm61qjStFZ9_GW-w-M2nqiUyrk1aR3-fJhkzfSyNpx-g@mail.gmail.com>
 <TYAPR01MB625214AA3D666DCAF383397892629@TYAPR01MB6252.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYAPR01MB625214AA3D666DCAF383397892629@TYAPR01MB6252.jpnprd01.prod.outlook.com>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 25 Nov 2021 21:00:39 +0900
Message-ID: 
 <CAODzB9oqr8go+zMRi0Gw-p+uG0VmQL=Wb9fGE6MHa36mv7R2Ng@mail.gmail.com>
Subject: Re: [cip-dev] New CVE entries in this week
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Nov 2021 12:01:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7017

Hi !

On Thu, Nov 25, 2021 at 5:00 PM Nobuhiro Iwamatsu
<nobuhiro1.iwamatsu@toshiba.co.jp> wrote:
>
> Hi,
>
> > > CVE-2021-4001: bpf: Fix toctou on read-only map''s constant scalar tr=
acking
> > >
> > > CVSS v3 score is not provided.
> > >
> > > This bug was introduced in 5.5-rc1 and fixed in 5.16-rc2.  Patch for =
5.15 is in stable-rt tree. Patch for 5.4(https://lore.kernel.org/stable/163=
757721744154@kroah.com/) and 5.10(https://lore.kernel.org/stable/1637577215=
186161@kroah.com/) are failed to apply. However, this bug was introduced in=
 5.5-rc1 so 5.4 can be ignored?
> > > Fixed status
> > >
> > > mainline: [353050be4c19e102178ccc05988101887c25ae53]
> > >
> >
> > I attached a patch for 5.10.
>
> Thanks, LGTM.
> I think it would be better to add the comment of the conflict fixing.
> e.g. https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/com=
mit/?h=3Dlinux-5.10.y&id=3D1ada86999dc84b852fcc32962f4002e939f4beb7
>

Thank you ! I added a comment and sent patch to the stable list.

> Best regards,
>   Nobuhiro
>
> ________________________________________
> =E5=B7=AE=E5=87=BA=E4=BA=BA: cip-dev@lists.cip-project.org <cip-dev@lists=
.cip-project.org> =E3=81=8C Masami Ichikawa <masami.ichikawa@miraclelinux.c=
om> =E3=81=AE=E4=BB=A3=E7=90=86=E3=81=A7=E9=80=81=E4=BF=A1
> =E9=80=81=E4=BF=A1=E6=97=A5=E6=99=82: 2021=E5=B9=B411=E6=9C=8825=E6=97=A5=
 14:16
> =E5=AE=9B=E5=85=88: cip-dev@lists.cip-project.org
> =E4=BB=B6=E5=90=8D: Re: [cip-dev] New CVE entries in this week
>
> Hi !
>
> On Thu, Nov 25, 2021 at 11:42 AM Masami Ichikawa via
> lists.cip-project.org
> <masami.ichikawa=3Dmiraclelinux.com@lists.cip-project.org> wrote:
> >
> > Hi !
> >
> > It's this week's CVE report.
> >
> > This week reported two new CVEs.
> >
> > * New CVEs
> >
> > CVE-2021-33098: Improper input validation in the Intel(R) Ethernet ixgb=
e driver for Linux before version 3.17.3 may allow an authenticated user to=
 potentially enable denial of service via local access.
> >
> > CVSS v3 score is 5.5 MEDIUM.
> >
> > Intel released fixed version of driver kit. Not sure this CVE affects m=
ainline's source code.
> >
> > Fixed status
> >
> > Intel released fixed version of driver kit.
> >
> > CVE-2021-4001: bpf: Fix toctou on read-only map''s constant scalar trac=
king
> >
> > CVSS v3 score is not provided.
> >
> > This bug was introduced in 5.5-rc1 and fixed in 5.16-rc2.  Patch for 5.=
15 is in stable-rt tree. Patch for 5.4(https://lore.kernel.org/stable/16375=
7721744154@kroah.com/) and 5.10(https://lore.kernel.org/stable/163757721518=
6161@kroah.com/) are failed to apply. However, this bug was introduced in 5=
.5-rc1 so 5.4 can be ignored?
> > Fixed status
> >
> > mainline: [353050be4c19e102178ccc05988101887c25ae53]
> >
>
> I attached a patch for 5.10.
>
> > * Updated CVEs
> >
> > CVE-2021-3640: UAF in sco_send_frame function
> >
> > 5.10 and 5.15 are fixed this week.
> >
> > Fixed status
> >
> > mainline: [99c23da0eed4fd20cae8243f2b51e10e66aa0951]
> > stable/5.10: [4dfba42604f08a505f1a1efc69ec5207ea6243de]
> > stable/5.14: [2c2b295af72e4e30d17556375e100ae65ac0b896]
> > stable/5.15: [b990c219c4c9d4993ef65ea9db73d9497e70f697]
> > stable/5.4: [d416020f1a9cc5f903ae66649b2c56d9ad5256ab]
> >
> > CVE-2021-43975: atlantic: Fix OOB read and write in hw_atl_utils_fw_rpc=
_wait
> >
> > The mainline kernel was fixed in 5.16-rc2.
> >
> > Fixed status
> >
> > mainline: [b922f622592af76b57cbc566eaeccda0b31a3496]
> >
> > Currently tracking CVEs
> >
> > CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
> > Bluetooth Core Specifications 4.0 through 5.2
> >
> > There is no fix information.
> >
> > CVE-2020-26555: BR/EDR pin code pairing broken
> >
> > No fix information
> >
> > CVE-2020-26556: kernel: malleable commitment Bluetooth Mesh Provisionin=
g
> >
> > No fix information.
> >
> > CVE-2020-26557: kernel: predictable Authvalue in Bluetooth Mesh
> > Provisioning Leads to MITM
> >
> > No fix information.
> >
> > CVE-2020-26559: kernel: Authvalue leak in Bluetooth Mesh Provisioning
> >
> > No fix information.
> >
> > CVE-2020-26560: kernel: impersonation attack in Bluetooth Mesh Provisio=
ning
> >
> > No fix information.
> >
> > Regards,
> >
> > --
> > Masami Ichikawa
> > Cybertrust Japan Co., Ltd.
> >
> > Email :masami.ichikawa@cybertrust.co.jp
> >           :masami.ichikawa@miraclelinux.com
> >
> >
> >
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
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#7012): https://lists.cip-project.org/g/cip-dev/messag=
e/7012
> Mute This Topic: https://lists.cip-project.org/mt/87295441/4520416
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129101/452041=
6/1465703922/xyzzy [masami.ichikawa@miraclelinux.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>


--=20
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

