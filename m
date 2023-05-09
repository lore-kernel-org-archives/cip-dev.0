Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9828AC7EE22
	for <webhook@archiver.kernel.org>; Tue,  9 May 2023 23:12:55 +0000 (UTC)
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
 by mx.groups.io with SMTP id smtpd.web10.3883.1683673968097713382
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 May 2023 16:12:48 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@miraclelinux-com.20221208.gappssmtp.com header.s=20221208 header.b=4YcRfiyV;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.44, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-18f4a6d2822so41076262fac.1
        for <cip-dev@lists.cip-project.org>; Tue, 09 May 2023 16:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20221208.gappssmtp.com; s=20221208; t=1683673967; x=1686265967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vznyTmBGqgOI/AdzxAGh+iZVnY93nBX1+hj3s16fKe8=;
        b=4YcRfiyV21icVVE3/X/xPZtfDQWWYoPAMV9msMkrr9GB5K6bp9WLgCUfiorU35f8X6
         xzpR5VrSpMnsUAC2Te3vPHkMw3v6nJS/QgXfKU1sBO0BUEly+wZQdlAuweGb1H2b6DW+
         ftcTtafJZiPWZLp8tl3iRGN1qyd01pBlwhEm2iPSd2iCdfXZaC7JH00T++dZZiv16/EM
         uKvidaSmtpRsX5P6VEE5aEWeQ4siG1cMUEqdxUFCHRxg4RvzIiXyI6xPem8DhHTX+j+7
         Zp1V9D4bPKXy70TQHfpNjjGMmOskYw1ppSPq7GpP6SJx/cvNJ1GN41KxXLv/InCoRMh4
         OGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683673967; x=1686265967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vznyTmBGqgOI/AdzxAGh+iZVnY93nBX1+hj3s16fKe8=;
        b=hpKte951Q9ySPz9do3gyv9+kmbVSbxxnQlF78+pU94HZY2ByCvElPbe162r9fFkp+N
         kMhMVXeLqIxLafEUgjYwoQzd+aUUNFWRjYlOZ7KX5ens8oWhFjT5TQtJS4qkE+sobdLr
         VVjnHiY5j4mEKXMFfUjvhgQXHtOR/XcPlhd51KawazXrV+ZJbq+DfDf3w9Tv/A20P3s8
         6CHxHwuBC0g6zZ+9g4yeCTfWZYxFXbr0Y+/UyDKz31/ZbNo7DaiSUMpZbWRn0vfVcWHa
         NTBDbjqmfHN21l7ZL5v9rLZT2iGyXaO9oUPD8NfvT4j/ge6flXNmgHj4LRgvlwalEC/P
         2S2A==
X-Gm-Message-State: AC+VfDxnGVV1LGBy2ph2ORCNXZaZPGzTeS0P77Zo7x1v4tbbTUT/aJrj
	DQ68NpsBvvHsboy0JWGsM9NqBOqRxY5VlnyzxeJeRg==
X-Google-Smtp-Source: ACHHUZ7b0gxyPPDpzZf/yp+KWfwKYR4O2vQGvHe0sZT9z+IYJlZMWioBADmsb3aqw4hl8vnuIYPEiLRvxKCfg9A4Wr8=
X-Received: by 2002:aca:d789:0:b0:38c:4c61:e7ad with SMTP id
 o131-20020acad789000000b0038c4c61e7admr2295196oig.19.1683673967359; Tue, 09
 May 2023 16:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAODzB9oaJ73uvgppYvcOBbM2xLNB1LQW34TZbjA3gd+bkAKaVg@mail.gmail.com>
 <63fb0d57-3550-1188-8243-7ea8c8b5ab5b@siemens.com> <TY2PR01MB37880583E930BBEC98A5803EB7769@TY2PR01MB3788.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB37880583E930BBEC98A5803EB7769@TY2PR01MB3788.jpnprd01.prod.outlook.com>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Wed, 10 May 2023 08:12:10 +0900
Message-ID: <CAODzB9rdcjQKhj9a0a6igrjHCbMwo0Qy=xenxmTXFryMkOhVUw@mail.gmail.com>
Subject: Re: Size limit in the cip-kernel-sec repository?
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev <cip-dev@lists.cip-project.org>, 
	Pavel Machek <pavel@denx.de>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, 
	Ulrich Hecht <uli@fpond.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 May 2023 23:12:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11427

Hi,

On Tue, May 9, 2023 at 7:39=E2=80=AFPM Chris Paterson
<Chris.Paterson2@renesas.com> wrote:
>
> Hello Jan,
>
> > From: Jan Kiszka <jan.kiszka@siemens.com>
> > Sent: Tuesday, May 9, 2023 7:39 AM
> >
> > On 09.05.23 01:34, Masami Ichikawa wrote:
> > > Hi !
> > >
> > > When I push commits to the cip-kernel-sec repository
> > >
> > (https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi=
tla
> > b.com%2Fcip-project%2Fcip-kernel%2Fcip-kernel-
> > sec&data=3D05%7C01%7CChris.Paterson2%40renesas.com%7Ccf0d089f5f4f424
> > 1aa6f08db5058242b%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C
> > 638192111707052389%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM
> > DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7
> > C&sdata=3DCjxru6HLSW5Kq%2BwYCwcuzgmvfKwr4G4x4V8jbdakiT8%3D&reser
> > ved=3D0), I get the
> > > following message.
> > >
> > > $ git push cip master
> > > Enumerating objects: 7, done.
> > > Counting objects: 100% (7/7), done.
> > > Delta compression using up to 4 threads
> > > Compressing objects: 100% (4/4), done.
> > > Writing objects: 100% (4/4), 457 bytes | 457.00 KiB/s, done.
> > > Total 4 (delta 3), reused 0 (delta 0)
> > > remote:
> > > remote:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > remote:
> > > remote:    Your push has been rejected, because this repository has
> > exceeded
> > > remote:     its size limit of 0 Bytes by 400 MB. Please contact your =
GitLab
> > > remote:                   administrator for more information.
> > > remote:
> > > remote:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > remote:
> > > To gitlab.com:cip-project/cip-kernel/cip-kernel-sec.git
> > >    78850bfd..92d679f5  master -> master
> > >
> > > Even Though, I get the message, commits are pushed successfully.
> > > I can see commits in the gitlab's UI.
> > >
> > > Do we need something in the repository setting?
> > >
> >
> > This issue affects the complete cip-project. The reason is likely
> >
> > https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
lab
> > .com%2Fcip-project%2Fcip-testing%2Flinux-stable-
> > rc&data=3D05%7C01%7CChris.Paterson2%40renesas.com%7Ccf0d089f5f4f4241
> > aa6f08db5058242b%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C6
> > 38192111707052389%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> > AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C
> > &sdata=3D8YzAuSt5tXmv6m61DlGl8KZCTfvNXGyD%2FrAfTs8bS1c%3D&reserve
> > d=3D0
> >
> > which hit the 10G limit, see
> >
> > https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
lab
> > .com%2Fgroups%2Fcip-project%2F-%2Fusage_quotas%23storage-quota-
> > tab&data=3D05%7C01%7CChris.Paterson2%40renesas.com%7Ccf0d089f5f4f424
> > 1aa6f08db5058242b%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C
> > 638192111707052389%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM
> > DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7
> > C&sdata=3D6TajRY6KeI9VMENausm3UpzfY5EggnVtjKcHYvVaPXg%3D&reserved
> > =3D0
> >
> > Folks, can we avoid this?
> >
> > Chris, didn't we apply for an OSS project rank on gitlab.com?
>
> We did!
> And according to the billings page [0] this isn't due to expire until 22/=
06/23.
> [0] https://gitlab.com/groups/cip-project/-/billings
>
> I don't know if there is a storage limit even for GitLab ultimate users t=
hough.
>
> Actually, according to [1] there is a 10GB limit for a git repository, bu=
t it hints that this setup may be changing to "namespace" storage limits
> [1] https://about.gitlab.com/pricing/faq-paid-storage-transfer/#q-what-is=
-changing-with-storage-and-transfer-limits
>
> I'll create a support ticket with GitLab and see if they can provide some=
 clarification.
>
> linux-stable-rc is a mirror of the kernel.org repo. There isn't much we c=
an do to reduce the size.
> If we can't get the quota increased we'll have to go back to using kernel=
.org directly again and remove our mirror.
>
> Regards, Chris
>
> >
> > Jan
> >
> > --
> > Siemens AG, Technology
> > Competence Center Embedded Linux
>

The warning message disappeared today (Tue 09 May 2023 11:09:07 PM UTC).

Enumerating objects: 12, done.
Counting objects: 100% (12/12), done.
Delta compression using up to 4 threads
Compressing objects: 100% (8/8), done.
Writing objects: 100% (8/8), 1.02 KiB | 1.02 MiB/s, done.
Total 8 (delta 6), reused 0 (delta 0)
To gitlab.com:cip-project/cip-kernel/cip-kernel-sec.git
   92d679f5..ef1cf1be  master -> master

Thanks alot.

Regards,
--=20
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

